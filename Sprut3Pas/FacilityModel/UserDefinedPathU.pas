unit UserDefinedPathU;

interface
uses
  Classes, SysUtils, Variants,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  WarriorPathU;

const
  pakVBoundary = $00000001;
  pakHZone = $00000002;
  pakHJump = $00000003;
  pakHBoundary = $00000004;
  pakVZone = $00000005;
  pakVJump = $00000006;
  pakChangeFacilityState = $00000007;
  pakChangeWarriorGroup = $00000008;
  pakVBoundary_ = $00000000;
  pakRoad = $00000009;
  pakTarget = $0000000A;

type
  TUserDefinedPath=class(TWarriorPath, IUserDefinedPath, IDMElement3)
  private
    FReversed:boolean;
    FReorded:boolean;

    FAddTarget:integer;
    FAddBackPath:boolean;

    FUserDefinedResponceTime:boolean;
    FResponceTime:double;
    FUserDefinedResponceTimeDispersionRatio:boolean;
    FResponceTimeDispersionRatio:double;
    FResponceTimeDispersion:double;

    FDisordedLines:IDMCollection;
    FBaseLineGroup:Variant;
    FAnalysisVariant:Variant;

//    FOptimised:boolean;

    procedure SetResponceTimeDispersion;
    function  GetBaseLineGroup:IDMElement;
  protected
    class function  GetClassID:integer; override;

    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;
    class procedure MakeFields0; override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    procedure _AddBackRef(const aElement:IDMElement); override;

    procedure Build(TreeMode:integer; Reverse, DirectPath:WordBool;
                    const InitialPathElementE:IDMElement); override; safecall;
    procedure  Analysis; override; safecall;

    function Get_AnalysisVariant:IDMElement; safecall;
    procedure Set_AnalysisVariant(const Value:IDMElement); safecall;

    function Get_SpatialElementClassID: Integer; safecall;

    procedure Update; override; safecall;
    procedure AfterCopyFrom(const SourceElement:IDMElement); override; safecall;
    procedure Loaded; override; safecall;
    procedure AfterLoading2; override; safecall;
    function GetResponceTime:double; override;
    function GetResponceTimeDispersion:double; override;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;

  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TUserDefinedPaths=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TUserDefinedPath }

procedure TUserDefinedPath.AfterCopyFrom(const SourceElement: IDMElement);
var
  LineGroupE:IDMElement;
  LineGroup:ILineGroup;
  DMOperationManager:IDMOperationManager;
  Collection:IDMCollection;
  Collection2:IDMCollection2;
  j, nItemIndex:integer;
  Document:IDMDocument;
  aCollection:IDMCollection;
  Painter:IUnknown;
begin
  LineGroupE:=Get_SpatialElement;
  if LineGroupE=nil then Exit;
  LineGroup:=LineGroupE as ILineGroup;
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  DMOperationManager.ChangeRef(nil, '', nil, LineGroupE);
  Collection:=TDMCollection.Create(nil) as IDMCollection;
  Collection2:=Collection as IDMCollection2;
  for j:=0 to LineGroup.Lines.Count-1 do
    Collection2.Add(LineGroup.Lines.Item[j]);
  DMOperationManager.DeleteElements(Collection, False);
  if LineGroupE.OwnerCollection.IndexOf(LineGroupE)<>-1 then
    DMOperationManager.DeleteElement( nil, nil, ltOneToMany, LineGroupE);

  Document:=DataModel.Document as IDMDocument;
  if SourceElement.SpatialElement<>nil then begin // в этом случае в SelectionItem находится SpatialElement
    aCollection:=Get_OwnerCollection;             // и DocumentOperation не проходит
    nItemIndex:=aCollection.IndexOf(Self as IDMElement);
    Document.Server.DocumentOperation(Self as IUnknown, aCollection,
                          leoAdd, nItemIndex);
    Painter:=(Document as ISMDocument).PainterU;
    Draw(Painter, 1);
  end;
end;

procedure TUserDefinedPath.AfterLoading2;
begin
  inherited;
  Build(tmToRoot, False, True, nil);
//  Analysis(nil, True);
end;

procedure TUserDefinedPath.Analysis;
var
  OldAnalysisVariantE, AnalysisVariantE: IDMElement;
  theWarriorPathElements:IDMCollection;
  FacilityModelS:IFMState;
begin
  theWarriorPathElements:=Get_WarriorPathElements;
  if theWarriorPathElements=nil then Exit;

  FacilityModelS:=DataModel as IFMState;
  OldAnalysisVariantE:=FacilityModelS.CurrentAnalysisVariantU as IDMElement;
  try
  AnalysisVariantE:=Get_AnalysisVariant;
  if (FacilityModelS.CurrentAnalysisVariantU as IDMElement)<>AnalysisVariantE then
    FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;

  inherited;

  finally
    if (FacilityModelS.CurrentAnalysisVariantU as IDMElement)<>OldAnalysisVariantE then
      FacilityModelS.CurrentAnalysisVariantU:=OldAnalysisVariantE;
  end;
end;

procedure TUserDefinedPath.Build(TreeMode: integer; Reverse,
  DirectPath: WordBool; const InitialPathElementE: IDMElement);
var
  FacilityModel:IFacilityModel;
  SpatialModel2:ISpatialModel2;
  Areas:IDMCollection;
  WarriorPathElements2:IDMCollection2;
  aX0, aY0, aZ0, aX1, aY1, aZ1, PathHeight:double;
  WarriorPathElementE, AreaE, Enviroments:IDMElement;
  WarriorPathElement:IWarriorPathElement;
  aLine:ILine;

  procedure Set_CenterAt(X, Y, Z, aLength, cosX, cosY, BoundaryWidth:double;
                         const Zone0, Zone1:IZone;
                         const Volume0, Volume1:IVolume;
                         const Area:IArea;
                         out aX0, aY0, aZ0, aX1, aY1, aZ1:double);
    var
      D0, D1, L2,
      P0X, P0Y, P0Z, P1X, P1Y, P1Z, aX, aY, aZ:double;
      j:integer;
      theArea:IArea;
    begin
      L2:=0.5*aLength;
      D0:=0;
      D1:=0;
      if Zone0=nil then
        D1:=BoundaryWidth*100
      else
      if Zone1=nil then
        D0:=BoundaryWidth*100
      else
      if Zone0.Category>Zone1.Category then
        D0:=BoundaryWidth*100
      else
        D1:=BoundaryWidth*100;

      P0X:=X-(L2+D0)*cosY;
      P0Y:=Y+(L2+D0)*cosX;
      P0Z:=Z;
      P1X:=X+(L2+D1)*cosY;
      P1Y:=Y-(L2+D1)*cosX;
      P1Z:=Z;

      aX0:=P0X;
      aY0:=P0Y;
      aZ0:=P0Z;
      aX1:=P1X;
      aY1:=P1Y;
      aZ1:=P1Z;

      if Volume0<>nil then begin
        if  Volume0.ContainsPoint(P0X, P0Y, P0Z) then begin
          if  Volume0.ContainsPoint(P1X, P1Y, P1Z) then begin
            j:=0;
            while j<Volume0.Areas.Count do begin
              theArea:=Volume0.Areas.Item[j] as IArea;
              if theArea.IsVertical and
                (theArea<>Area) and
                 theArea.IntersectLine(P0X, P0Y, P0Z, X, Y, Z, aX, aY, aZ) and
                 ((P0X-aX)*(X-aX)<=0) and
                 ((P0Y-aY)*(Y-aY)<=0) and
                 ((P0Z-aZ)*(Z-aZ)<=0) then
                Break
              else
                inc(j)
            end;
            if j<Volume0.Areas.Count then begin
              aX0:=X+(L2+D0)*cosY;
              aY0:=Y+(L2+D0)*cosX;
              aX1:=aX;
              aY1:=aY;
            end;
          end;  // if Volume0.ContainsPoint(P1X, P1Y, P1Z)
        end else begin // if not Volume0.ContainsPoint(P0X, P0Y, P0Z)
          aX0:=X+(L2+D0)*cosY;
          aY0:=Y-(L2+D0)*cosX;
          aX1:=X-(L2+D1)*cosY;
          aY1:=Y+(L2+D1)*cosX;
        end;
      end else begin  //if Volume0=nil
        if Volume1=nil then Exit;
        if  Volume1.ContainsPoint(P1X, P1Y, P1Z) then begin
          if  Volume1.ContainsPoint(P0X, P0Y, P0Z) then begin
            j:=0;
            while j<Volume1.Areas.Count do begin
              theArea:=Volume1.Areas.Item[j] as IArea;
              if theArea.IsVertical and
                (theArea<>Area) and
                 theArea.IntersectLine(P1X, P1Y, P1Z, X, Y, Z, aX, aY, aZ) and
                 ((P1X-aX)*(X-aX)<=0) and
                 ((P1Y-aY)*(Y-aY)<=0) and
                 ((P1Z-aZ)*(Z-aZ)<=0) then
                Break
              else
                inc(j)
            end;
            if j<Volume1.Areas.Count then begin
              aX0:=aX;
              aY0:=aY;
              aX1:=X-(L2+D1)*cosY;
              aY1:=Y+(L2+D1)*cosX;
            end;
          end;  // if Volume1.ContainsPoint(P0X, P0Y, P0Z)
        end else begin // if not Volume1.ContainsPoint(P1X, P1Y, P1Z)
          aX0:=P1X;
          aY0:=P1Y;
          aX1:=X-(L2+D1)*cosY;
          aY1:=Y+(L2+D1)*cosX;
        end;
      end;
    end;

  function FindJump(const Zone0E, Zone1E:IDMElement):IDMElement;
  var
    Zone0, Zone1:IZone;
    j, m:integer;
    JumpE:IDMElement;
  begin
    Result:=nil;
    if Zone0E=nil then Exit;
    if Zone1E=nil then Exit;
    if Zone0E=Zone1E then Exit;
    Zone0:=Zone0E as IZone;
    Zone1:=Zone1E as IZone;
    if Zone0.Jumps.Count=0 then Exit;
    if Zone1.Jumps.Count=0 then Exit;
    JumpE:=nil;
    j:=0;
    while j<Zone0.Jumps.Count do begin
      JumpE:=Zone0.Jumps.Item[j];
      m:=0;
      while m<Zone1.Jumps.Count do begin
        if JumpE=Zone1.Jumps.Item[m] then
          Break
        else
          inc(m)
      end;
      if m<Zone1.Jumps.Count then
        Break
      else
        inc(j)
    end;
    if j<Zone0.Jumps.Count then
      Result:=JumpE
  end;

  procedure AddLine(X0, Y0, Z0, X1, Y1, Z1:double;
                    const aRef:IDMElement;
                    out Zone1E:IDMElement;
                    out aC0, aC1:ICoordNode);
  var
    a:integer;
    Volume, aVolume0, aVolume1, aVolume:IVolume;
    BoundaryE, Zone0E, aZone0E, aZone1E, ZoneE, theZone0E, theZone1E:IDMElement;
    aZone0, aZone1:IZone;
    BoundaryFE:IFacilityElement;
    Boundary:IBoundary;
    BoundaryLayer:IBoundaryLayer;
    RC0X, RC0Y, RC0Z,
    RC1X, RC1Y, RC1Z,
    CC0X, CC0Y, CC0Z,
    CC1X, CC1Y, CC1Z,
    X, Y, Z, WPX0, WPY0, WPZ0, WPX1, WPY1, WPZ1,
    ProjL, L, cosX, cosY:double;
    TransparencyCoeff:double;
    Areas2:IDMCollection2;
    MakePathPartFlag:boolean;
    Area, aArea0, aArea1:IArea;
    JumpE:IDMElement;
    JumpLine:ILine;
    JumpC0, JumpC1:ICoordNode;
    Jump:IJump;
    aWarriorPathElementE:IDMElement;
    aWarriorPathElement:IWarriorPathElement;
    aRefPathElement:IRefPathElement;
    RefPathElement:IRefPathElement;
    BoundaryWidth:double;
    j:integer;
    ZoneSU:ISafeguardUnit;
    SafeguardElementE, SpatialElementE:IDMElement;
    Node:ICoordNode;
    Target:ITarget;
  begin
    if (Z0<-InfinitValue) or
       (Z1<-InfinitValue) then begin
      aWarriorPathElementE:=WarriorPathElements2.CreateElement(False);
      aWarriorPathElement:=aWarriorPathElementE as IWarriorPathElement;
      aRefPathElement:=aWarriorPathElementE as IRefPathElement;
      WarriorPathElements2.Add(aWarriorPathElementE);
      aWarriorPathElementE.Ref:=Enviroments;
      aWarriorPathElementE.Parent:=Self as IDMElement;
      aRefPathElement.PathArcKind:=pakHZone;
      aRefPathElement.Ref0:=Enviroments;
      aRefPathElement.Ref1:=Enviroments;
      if  Z0<-InfinitValue then begin
        aRefPathElement.X0:=X1;
        aRefPathElement.Y0:=Y1;
        aRefPathElement.Z0:=Z1;
        aRefPathElement.X1:=X0;
        aRefPathElement.Y1:=Y0;
        aRefPathElement.Z1:=Z0;
        aRefPathElement.Direction:=pdFrom1To0;
      end else begin
        aRefPathElement.X0:=X0;
        aRefPathElement.Y0:=Y0;
        aRefPathElement.Z0:=Z0;
        aRefPathElement.X1:=X1;
        aRefPathElement.Y1:=Y1;
        aRefPathElement.Z1:=Z1;
        aRefPathElement.Direction:=pdFrom0To1;
      end;

      Exit;
    end;

    Volume:=SpatialModel2.GetVolumeContaining(X0,Y0,Z0);
    if Volume<>nil then begin
      ZoneE:=(Volume as IDMElement).Ref;
      if Z0<Volume.MinZ+PathHeight then
        Z0:=Volume.MinZ+PathHeight;
    end else
      ZoneE:=nil;
    RC0X:=X0;
    RC0Y:=Y0;
    RC0Z:=Z0;
    theZone0E:=ZoneE;
    Zone0E:=ZoneE;

    Volume:=SpatialModel2.GetVolumeContaining(X1,Y1,Z1);
    if Volume<>nil then begin
      ZoneE:=(Volume as IDMElement).Ref;
      if Z1<Volume.MinZ+PathHeight then
        Z1:=Volume.MinZ+PathHeight;
    end else
      ZoneE:=nil;
    RC1X:=X1;
    RC1Y:=Y1;
    RC1Z:=Z1;
    theZone1E:=ZoneE;
    Zone1E:=ZoneE;

    CC0X:=RC0X;
    CC0Y:=RC0Y;
    CC0Z:=RC0Z;
    CC1X:=RC1X;
    CC1Y:=RC1Y;
    CC1Z:=RC1Z;

    if (X0=X1) and
       (Y0=Y1) and
       (Z0=Z1) then begin
      ZoneSU:=Zone0E as ISafeguardUnit;
      j:=0;
      SafeguardElementE:=nil;
      while j<ZoneSU.SafeguardElements.Count do begin
        SafeguardElementE:=ZoneSU.SafeguardElements.Item[j];
        if SafeguardElementE.QueryInterface(ITarget, Target)=0 then begin
          SpatialElementE:=SafeguardElementE.SpatialElement;
          Node:=SpatialElementE as ICoordNode;
          if sqrt(sqr(Node.X-X0)+sqr(Node.Y-Y0))<1 then
             Break
          else
            inc(j);
        end else
          inc(j);
      end;
      if j<ZoneSU.SafeguardElements.Count then begin
        aWarriorPathElementE:=WarriorPathElements2.CreateElement(False);
        aWarriorPathElement:=aWarriorPathElementE as IWarriorPathElement;
        aRefPathElement:=aWarriorPathElementE as IRefPathElement;
        WarriorPathElements2.Add(aWarriorPathElementE);
        aWarriorPathElementE.Ref:=SafeguardElementE;
        aWarriorPathElementE.Parent:=Self as IDMElement;
        aRefPathElement.PathArcKind:=pakTarget;
        aRefPathElement.Ref0:=Zone0E;
        aRefPathElement.Ref1:=Zone0E;
        aRefPathElement.X0:=X0;
        aRefPathElement.Y0:=Y0;
        aRefPathElement.Z0:=Z0;
        aRefPathElement.X1:=X0;
        aRefPathElement.Y1:=Y0;
        aRefPathElement.Z1:=Z0;
        aRefPathElement.Direction:=pdFrom1To0;
        FAddTarget:=0;
      end;
    end;

    JumpE:=FindJump(Zone0E, Zone1E);
    if JumpE<>nil then begin
      JumpLine:=JumpE.SpatialElement as ILine;
      JumpC0:=JumpLine.C0;
      JumpC1:=JumpLine.C1;
      Jump:=JumpE as IJump;

      if ((JumpC0.X<>CC0X) or
          (JumpC0.Y<>CC0Y)) and
         ((JumpC1.X<>CC0X) or
          (JumpC1.Y<>CC0Y)) then begin
        aWarriorPathElementE:=WarriorPathElements2.CreateElement(False);
        aWarriorPathElement:=aWarriorPathElementE as IWarriorPathElement;
        aRefPathElement:=aWarriorPathElementE as IRefPathElement;
        WarriorPathElements2.Add(aWarriorPathElementE);
        aWarriorPathElementE.Ref:=Zone0E;
        aWarriorPathElementE.Parent:=Self as IDMElement;
        aRefPathElement.PathArcKind:=pakHZone;
        aRefPathElement.Ref0:=Zone0E;
        aRefPathElement.Ref1:=Zone0E;
        aRefPathElement.X0:=CC0X;
        aRefPathElement.Y0:=CC0Y;
        aRefPathElement.Z0:=CC0Z;
        aRefPathElement.Direction:=pdFrom0To1;
      end else
        aRefPathElement:=nil;

      WarriorPathElementE:=WarriorPathElements2.CreateElement(False);
      WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
      RefPathElement:=WarriorPathElementE as IRefPathElement;
      WarriorPathElements2.Add(WarriorPathElementE);
      WarriorPathElementE.Ref:=JumpE;
      WarriorPathElementE.Parent:=Self as IDMElement;
      RefPathElement.PathArcKind:=pakVLineObject;
      RefPathElement.Ref0:=Zone0E;
      RefPathElement.Ref1:=Zone1E;

      if Zone0E=Jump.Zone0 as IDMElement then begin

        if aRefPathElement<>nil then begin
          aRefPathElement.X1:=JumpC0.X;
          aRefPathElement.Y1:=JumpC0.Y;
          aRefPathElement.Z1:=JumpC0.Z;
        end;

        RefPathElement.X0:=JumpC0.X;
        RefPathElement.Y0:=JumpC0.Y;
        RefPathElement.Z0:=JumpC0.Z;
        RefPathElement.X1:=JumpC1.X;
        RefPathElement.Y1:=JumpC1.Y;
        RefPathElement.Z1:=JumpC1.Z;
        RefPathElement.Direction:=pdFrom0To1;
        aC0:=JumpC0;
        aC1:=JumpC1;
      end else begin
        if aRefPathElement<>nil then begin
          aRefPathElement.X1:=JumpC1.X;
          aRefPathElement.Y1:=JumpC1.Y;
          aRefPathElement.Z1:=JumpC1.Z+PathHeight;
        end;

        RefPathElement.X0:=JumpC1.X;
        RefPathElement.Y0:=JumpC1.Y;
        RefPathElement.Z0:=JumpC1.Z+PathHeight;
        RefPathElement.X1:=JumpC0.X;
        RefPathElement.Y1:=JumpC0.Y;
        RefPathElement.Z1:=JumpC0.Z+PathHeight;
        RefPathElement.Direction:=pdFrom1To0;
        aC0:=JumpC1;
        aC1:=JumpC0;
      end;

      if ((JumpC0.X<>CC1X) or
          (JumpC0.Y<>CC1Y)) and
         ((JumpC1.X<>CC1X) or
          (JumpC1.Y<>CC1Y)) then begin
        aWarriorPathElementE:=WarriorPathElements2.CreateElement(False);
        aWarriorPathElement:=aWarriorPathElementE as IWarriorPathElement;
        aRefPathElement:=aWarriorPathElementE as IRefPathElement;
        WarriorPathElements2.Add(aWarriorPathElementE);
        aWarriorPathElementE.Ref:=Zone1E;
        aWarriorPathElementE.Parent:=Self as IDMElement;
        aRefPathElement.PathArcKind:=pakHZone;
        aRefPathElement.Ref0:=Zone1E;
        aRefPathElement.Ref1:=Zone1E;

        aRefPathElement.X0:=JumpC1.X;
        aRefPathElement.Y0:=JumpC1.Y;
        aRefPathElement.Z0:=JumpC1.Z;
        aRefPathElement.X1:=CC1X;
        aRefPathElement.Y1:=CC1Y;
        aRefPathElement.Z1:=CC1Z;
        aRefPathElement.Direction:=pdFrom0To1;
      end;

      Exit;
    end else begin
      aC0:=nil;
      aC1:=nil;
    end;

    if (aRef<>nil) and
       (aRef.ClassID=_Jump) then begin
      WarriorPathElementE:=WarriorPathElements2.CreateElement(False);
      WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
      RefPathElement:=WarriorPathElementE as IRefPathElement;
      WarriorPathElements2.Add(WarriorPathElementE);
      if aRef<>nil then
        WarriorPathElementE.Ref:=aRef
      else
        WarriorPathElementE.Ref:=Zone1E;
      WarriorPathElementE.Parent:=Self as IDMElement;
      RefPathElement.X0:=RC0X;
      RefPathElement.Y0:=RC0Y;
      RefPathElement.Z0:=RC0Z;
      RefPathElement.X1:=RC1X;
      RefPathElement.Y1:=RC1Y;
      RefPathElement.Z1:=RC1Z;
      RefPathElement.PathArcKind:=pakHJump;
      RefPathElement.Ref0:=Zone0E;
      RefPathElement.Ref1:=Zone1E;
      RefPathElement.Direction:=pdFrom0To1
    end else begin // if aRef.ClassID<>_Jump
      if Zone1E<>nil then
        FacilityModel.FindSeparatingAreas(X0, Y0, Z0, X1, Y1, Z1,
                                        Zone0E, Zone1E, 0, Areas, TransparencyCoeff, nil, nil)
      else begin
        FacilityModel.FindSeparatingAreas(X1, Y1, Z1, X0, Y0, Z0,
                                        Zone1E, Zone0E, 0, Areas, TransparencyCoeff, nil, nil);
        Areas2:=TDMCollection.Create(nil) as IDMCollection2;
        for a:=Areas.Count-1 downto 0 do
          Areas2.Add(Areas.Item[a]);
        (Areas as IDMCollection2).Clear;
        Areas:=Areas2 as IDMCollection;
      end;
      MakePathPartFlag:=True;
      if Areas.Count>0 then begin
//      a:=Areas.Count-1;
//      while a>=0 do begin
        a:=0;
        while a<=Areas.Count-1 do begin
          AreaE:=Areas.Item[a];
          Area:=AreaE as IArea;
          BoundaryE:=AreaE.Ref;
          BoundaryFE:=BoundaryE as IFacilityElement;
          Boundary:=BoundaryE as IBoundary;
          aVolume0:=Area.Volume0;
          aVolume1:=Area.Volume1;
          if aVolume0<>nil then
            aZone0E:=(aVolume0 as IDMElement).Ref
          else
            aZone0E:=nil;
          if aVolume1<>nil then
            aZone1E:=(aVolume1 as IDMElement).Ref
          else
            aZone1E:=nil;

          aZone0:=aZone0E as IZone;
          aZone1:=aZone1E as IZone;

          Area.IntersectLine(X0, Y0, Z0, X1, Y1, Z1, X, Y, Z);
          if Area.BottomLines.Count>0 then
            aLine:=Area.BottomLines.Item[0] as ILine
          else
            aLine:=Area.TopLines.Item[0] as ILine;
          ProjL:=sqrt(sqr(aLine.C1.X-aLine.C0.X)+sqr(aLine.C1.Y-aLine.C0.Y));
          cosX:=(aLine.C1.X-aLine.C0.X)/ProjL;
          cosY:=(aLine.C1.Y-aLine.C0.Y)/ProjL;

          if  Area.IsVertical then begin

            BoundaryWidth:=0;
            for j:=0 to Boundary.BoundaryLayers.Count-1 do begin
              BoundaryLayer:=Boundary.BoundaryLayers.Item[j] as IBoundaryLayer;
              BoundaryWidth:=BoundaryWidth+BoundaryLayer.DistanceFromPrev;
            end;
            BoundaryWidth:=abs(BoundaryWidth);

            if  AreaE.Ref.Ref.Parent.ID=btVirtual then  // условная граница
              L:=10
            else
              L:=ShoulderWidth;

            Set_CenterAt(X, Y, Z, L, cosX, cosY, BoundaryWidth,
                         aZone0, aZone1, aVolume0, aVolume1, Area,
                         aX0, aY0, aZ0, aX1, aY1, aZ1);
          end else begin
            aX0:=X;
            aY0:=Y;
            aZ0:=Z;
            aX1:=X;
            aY1:=Y;
            aZ1:=Z-PathHeight;
          end;

          if (Zone0E=aZone0E) then  begin
            ZoneE:=Zone0E;
            Zone0E:=aZone1E;

            CC0X:=RC0X;
            CC0Y:=RC0Y;
            CC0Z:=RC0Z;

            CC1X:=aX0;
            CC1Y:=aY0;
            CC1Z:=aZ0;

            RC0X:=aX1;
            RC0Y:=aY1;
            RC0Z:=aZ1;
          end else
          if (Zone0E=aZone1E) then begin
            ZoneE:=Zone0E;
            Zone0E:=aZone0E;

            CC0X:=RC0X;
            CC0Y:=RC0Y;
            CC0Z:=RC0Z;

            CC1X:=aX1;
            CC1Y:=aY1;
            CC1Z:=aZ1;

            RC0X:=aX0;
            RC0Y:=aY0;
            RC0Z:=aZ0;
          end;

          if ZoneE<>nil then begin
            if  sqrt(sqr(CC0X-CC1X)+sqr(CC0Y-CC1Y)+sqr(CC0Z-CC1Z))>50 then begin
              WarriorPathElementE:=WarriorPathElements2.CreateElement(False);
              WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
              RefPathElement:=WarriorPathElementE as IRefPathElement;
              WarriorPathElements2.Add(WarriorPathElementE);
              if aRef<>nil then
                WarriorPathElementE.Ref:=aRef
              else
                WarriorPathElementE.Ref:=ZoneE;
              WarriorPathElementE.Parent:=Self as IDMElement;
              RefPathElement.X0:=CC0X;
              RefPathElement.Y0:=CC0Y;
              RefPathElement.Z0:=CC0Z;
              RefPathElement.X1:=CC1X;
              RefPathElement.Y1:=CC1Y;
              RefPathElement.Z1:=CC1Z;
              RefPathElement.PathArcKind:=pakHZone;
              RefPathElement.Ref0:=ZoneE;
              RefPathElement.Ref1:=ZoneE;
              RefPathElement.Direction:=pdFrom0To1;
            end;
          end;

          WarriorPathElementE:=WarriorPathElements2.CreateElement(False);
          WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
          RefPathElement:=WarriorPathElementE as IRefPathElement;
          WarriorPathElements2.Add(WarriorPathElementE);
          WarriorPathElementE.Ref:=BoundaryE;
          WarriorPathElementE.Parent:=Self as IDMElement;

          if Area.IsVertical then begin
            RefPathElement.PathArcKind:=pakVBoundary;
          end else
          if aRef=nil then
            RefPathElement.PathArcKind:=pakHBoundary
          else
          if aRef.ClassID=_Road then
            RefPathElement.PathArcKind:=pakRoad
          else
            RefPathElement.PathArcKind:=pakVLineObject;
          RefPathElement.X0:=aX0;
          RefPathElement.Y0:=aY0;
          RefPathElement.Z0:=aZ0;
          RefPathElement.X1:=aX1;
          RefPathElement.Y1:=aY1;
          RefPathElement.Z1:=aZ1;
          RefPathElement.Ref0:=aZone0E;
          RefPathElement.Ref1:=aZone1E;
          if Zone0E=aZone0E then  // после переприсвоения Zone0E
            RefPathElement.Direction:=pdFrom1To0
          else
            RefPathElement.Direction:=pdFrom0To1;

//          dec(a);
          inc(a);
        end;  //while a<Areas.Count
      end else begin //if Areas.Count=0
        if Zone0E<>Zone1E then
          MakePathPartFlag:=False;
      end;

      if MakePathPartFlag and
         (Zone1E<>nil) then begin
        if  sqrt(sqr(RC0X-RC1X)+sqr(RC0Y-RC1Y)+sqr(RC0Z-RC1Z))>50 then begin
          WarriorPathElementE:=WarriorPathElements2.CreateElement(False);
          WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
          RefPathElement:=WarriorPathElementE as IRefPathElement;
          WarriorPathElements2.Add(WarriorPathElementE);
          if aRef<>nil then
            WarriorPathElementE.Ref:=aRef
          else
            WarriorPathElementE.Ref:=Zone1E;
          WarriorPathElementE.Parent:=Self as IDMElement;
          RefPathElement.X0:=RC0X;
          RefPathElement.Y0:=RC0Y;
          RefPathElement.Z0:=RC0Z;
          RefPathElement.X1:=RC1X;
          RefPathElement.Y1:=RC1Y;
          RefPathElement.Z1:=RC1Z;
          RefPathElement.PathArcKind:=pakHZone;
          RefPathElement.Ref0:=Zone1E;
          RefPathElement.Ref1:=Zone1E;
          RefPathElement.Direction:=pdFrom0To1
        end;
      end;
    end; // if aRef.ClassID<>_Jump
  end;

var
  LineGroup:ILineGroup;
  SpatialModel:ISpatialModel;
  Line:ILine;
  Zone1E:IDMElement;
  N, j, m, K:integer;
  PathArc:IPathArc;
  RoadPart:IRoadPart;
  theWarriorPathElements:IDMCollection;
  theWarriorPathElements2:IDMCollection2;
  TargetE, aTargetE,
  aWarriorPathElementE, aRef, LineE:IDMElement;
  aWarriorPathElement:IWarriorPathElement;
  RefPathElement, aRefPathElement:IRefPathElement;
  X, Y, Z, X0, Y0, Z0, X1, Y1, Z1,
  C0X, C0Y, C0Z, C1X, C1Y, C1Z,
  DMin, D00, D01, D10, D11:double;
  C0, C1, LastC:ICoordNode;
  Document:IDMDocument;
  Server:DataModelServer;
  TMPList:TList;
  C, aC0, aC1:ICoordNode;
  MinD, D:double;
begin
  if DataModel.IsLoading then Exit;
  FacilityModel:=DataModel as IFacilityModel;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=DataModel as ISpatialModel2;
  theWarriorPathElements:=Get_WarriorPathElements;
  theWarriorPathElements2:=theWarriorPathElements as IDMCollection2;
  WarriorPathElements2:=FacilityModel.WarriorPathElements as IDMCollection2;
  Areas:=TDMCollection.Create(nil) as IDMCollection;
  PathHeight:=FacilityModel.PathHeight;
  
  while theWarriorPathElements.Count>0 do begin
    WarriorPathElementE:=theWarriorPathElements.Item[theWarriorPathElements.Count-1];
    WarriorPathElementE.Selected:=False;
    WarriorPathElementE.Clear;
    WarriorPathElements2.Remove(WarriorPathElementE);
  end;
  Enviroments:=FacilityModel.Enviroments;

  LineGroup:=GetBaseLineGroup as ILineGroup;
  if LineGroup=nil then Exit;
  if LineGroup.Lines.Count=0 then Exit;

  C0:=nil;
  C1:=nil;
  C0X:=0;
  C0Y:=0;
  C0Z:=0;
  C1X:=0;
  C1Y:=0;
  C1Z:=0;
  for j:=0 to (LineGroup.Lines.Count-1) do begin
    LineE:=LineGroup.Lines.Item[j];
    Line:=LineE as ILine;

    aRef:=LineE.Ref;
    if (aRef=nil) and
       (LineE.Parents.Count>1) then begin
      m:=0;
      while m<LineE.Parents.Count do begin
        aRef:=LineE.Parents.Item[m];
        if aRef.ClassID=_Road then
          Break
        else
          inc(m)
      end;
      if m=LineE.Parents.Count then
        aRef:=nil;
    end;

    if j=0 then begin
      C0:=Line.C0;
      C1:=Line.C1;
      C0X:=C0.X;
      C0Y:=C0.Y;
      C0Z:=C0.Z;
      C1X:=C1.X;
      C1Y:=C1.Y;
      C1Z:=C1.Z;
    end else
    if C0=Line.C0 then begin
      C1:=Line.C1;
      C1X:=C1.X;
      C1Y:=C1.Y;
      C1Z:=C1.Z;
    end else
    if C0=Line.C1 then begin
      C1:=Line.C0;
      C1X:=C1.X;
      C1Y:=C1.Y;
      C1Z:=C1.Z;
    end else
    if C1=Line.C0 then begin
      C0:=Line.C0;
      C1:=Line.C1;
      C0X:=C0.X;
      C0Y:=C0.Y;
      C0Z:=C0.Z;
      C1X:=C1.X;
      C1Y:=C1.Y;
      C1Z:=C1.Z;
    end else
    if C1=Line.C1 then begin
      C0:=Line.C1;
      C1:=Line.C0;
      C0X:=C0.X;
      C0Y:=C0.Y;
      C0Z:=C0.Z;
      C1X:=C1.X;
      C1Y:=C1.Y;
      C1Z:=C1.Z;
    end else begin
      D00:=Line.C0.DistanceFrom(C0X, C0Y, C0Z);
      DMin:=D00;
      K:=0;
      D10:=Line.C1.DistanceFrom(C0X, C0Y, C0Z);
      if DMin>D10 then begin
        DMin:=D10;
        K:=1;
      end;
      D01:=Line.C0.DistanceFrom(C1X, C1Y, C1Z);
      if DMin>D01 then begin
        DMin:=D01;
        K:=2;
      end;
      D11:=Line.C1.DistanceFrom(C1X, C1Y, C1Z);
      if DMin>D11 then begin
        K:=3;
      end;

      case K of
      0:begin
         AddLine(C0X, C0Y, C0Z,
                 Line.C0.X, Line.C0.Y, Line.C0.Z+PathHeight, nil,
                 Zone1E, aC0, aC1);
         C0:=Line.C1;
         C0X:=C0.X;
         C0Y:=C0.Y;
         C0Z:=C0.Z;
        end;
      1:begin
         AddLine(C0X, C0Y, C0Z,
                 Line.C1.X, Line.C1.Y, Line.C1.Z+PathHeight, nil,
                 Zone1E, aC0, aC1);
         C0:=Line.C0;
         C0X:=C0.X;
         C0Y:=C0.Y;
         C0Z:=C0.Z;
        end;
      2:begin
         AddLine(C1X, C1Y, C1Z,
                 Line.C0.X, Line.C0.Y, Line.C0.Z+PathHeight, nil,
                 Zone1E, aC0, aC1);
         C1:=Line.C1;
         C1X:=C1.X;
         C1Y:=C1.Y;
         C1Z:=C1.Z;
        end;
      3:begin
         AddLine(C1X, C1Y, C1Z,
                 Line.C1.X, Line.C1.Y, Line.C1.Z+PathHeight, nil,
                 Zone1E, aC0, aC1);
         C1:=Line.C0;
         C1X:=C1.X;
         C1Y:=C1.Y;
         C1Z:=C1.Z;
        end;
      end; // case K
    end;

    AddLine (C0X, C0Y, C0Z, C1X, C1Y, C1Z, aRef,
    Zone1E, aC0, aC1);


  end;  //for j:=0 to (LineGroup.Lines.Count-1)

  if FReversed then begin
    TMPList:=TList.Create;
    for j:=theWarriorPathElements.Count-1 downto 0 do
      TMPList.Add(pointer(theWarriorPathElements.Item[j]));
    theWarriorPathElements2.Clear;
    for j:=0 to TMPList.Count-1 do begin
      WarriorPathElementE:=IDMElement(TMPList[j]);
      WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
      RefPathElement:=WarriorPathElementE as IRefPathElement;
      theWarriorPathElements2.Add(WarriorPathElementE);
      X:=RefPathElement.X0;
      Y:=RefPathElement.Y0;
      Z:=RefPathElement.Z0;
      RefPathElement.X0:=RefPathElement.X1;
      RefPathElement.Y0:=RefPathElement.Y1;
      RefPathElement.Z0:=RefPathElement.Z1;
      RefPathElement.X1:=X;
      RefPathElement.Y1:=Y;
      RefPathElement.Z1:=Z;
    end;
  end;

  if FAddTarget>0 then begin
    X0:=RefPathElement.X1;
    Y0:=RefPathElement.Y1;
    Z0:=RefPathElement.Z1;
    X1:=X0;
    Y1:=Y0;
    Z1:=Z0;
    TargetE:=nil;
    MinD:=InfinitValue;
    for j:=0 to FacilityModel.Targets.Count-1 do begin
      aTargetE:=FacilityModel.Targets.Item[j];
      if ((FAddTarget=1) and
          (aTargetE.Ref.Parent.ID=ttMainTarget)) or
         ((FAddTarget=2) and
          (aTargetE.Ref.Parent.ID=ttBattlePosition)) then begin
        C:=aTargetE.SpatialElement as ICoordNode;
        X:=C.X;
        Y:=C.Y;
        Z:=C.Z;
        D:=sqrt(sqr(X-aX0)+sqr(Y-aY0)+sqr(Z-aZ0));
        if MinD>D then begin
          MinD:=D;
          X1:=X;
          Y1:=Y;
          Z1:=Z;
          TargetE:=aTargetE;
        end;
      end;
    end;
    if TargetE<>nil then begin
      AddLine(X0, Y0, Z0, X1, Y1, Z1, nil,
      Zone1E, aC0, aC1);
      RefPathElement.Ref1:=aTargetE;

      WarriorPathElementE:=WarriorPathElements2.CreateElement(False);
      WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
      RefPathElement:=WarriorPathElementE as IRefPathElement;
      WarriorPathElements2.Add(WarriorPathElementE);
      WarriorPathElementE.Ref:=TargetE;
      WarriorPathElementE.Parent:=Self as IDMElement;
      RefPathElement.X0:=X1;
      RefPathElement.Y0:=Y1;
      RefPathElement.Z0:=Z1;
      RefPathElement.X1:=X1;
      RefPathElement.Y1:=Y1;
      RefPathElement.Z1:=Z1;
      RefPathElement.PathArcKind:=pakTarget;
      RefPathElement.Ref0:=Zone1E;
      RefPathElement.Ref1:=nil;
      RefPathElement.Direction:=pdFrom0To1
    end;
  end;

  if FAddBackPath then begin
    N:=theWarriorPathElements.Count;
    for j:=N-1 downto 0 do begin
      aWarriorPathElementE:=theWarriorPathElements.Item[j];
      aWarriorPathElement:=aWarriorPathElementE as IWarriorPathElement;
      aRefPathElement:=aWarriorPathElementE as IRefPathElement;

      WarriorPathElementE:=WarriorPathElements2.CreateElement(False);
      WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
      WarriorPathElements2.Add(WarriorPathElementE);
      WarriorPathElementE.Ref:=aWarriorPathElementE.Ref;
      WarriorPathElementE.Parent:=Self as IDMElement;
      RefPathElement.X0:=aRefPathElement.X1;
      RefPathElement.Y0:=aRefPathElement.Y1;
      RefPathElement.Z0:=aRefPathElement.Z1;
      RefPathElement.X1:=aRefPathElement.X0;
      RefPathElement.Y1:=aRefPathElement.Y0;
      RefPathElement.Z1:=aRefPathElement.Z0;
      RefPathElement.PathArcKind:=aRefPathElement.PathArcKind;
      RefPathElement.Ref0:=aRefPathElement.Ref0;
      RefPathElement.Ref1:=aRefPathElement.Ref1;
      RefPathElement.Direction:=pdFrom0To1;

      WarriorPathElement.FacilityState:=aWarriorPathElement.FacilityState;
    end;
  end;
end;

procedure TUserDefinedPath.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  Layer:ILayer;
  BaseLineGroup:IDMElement;
begin
  BaseLineGroup:=GetBaseLineGroup;
  if BaseLineGroup<>nil then begin
    Layer:=BaseLineGroup.Parent as ILayer;
    if Layer=nil then Exit;
    if not Layer.Visible then Exit;
  end;
  inherited;
end;

function TUserDefinedPath.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(udpResponceTime):
    Result:=FUserDefinedResponceTime;
  ord(udpResponceTimeDispersionRatio):
    Result:=FUserDefinedResponceTimeDispersionRatio;
  ord(udpPathSuccessProbability):
    Result:=False;
//  ord(udpBaseLineGroup):
//    Result:=False;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

function TUserDefinedPath.GetBaseLineGroup: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FBaseLineGroup;
  Result:=Unk as IDMElement
end;

class function TUserDefinedPath.GetClassID: integer;
begin
  Result:=_UserDefinedPath;
end;

class function TUserDefinedPath.GetFields: IDMCollection;
begin
  Result:=FFields;
end;

function TUserDefinedPath.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(udpAnalysisVariant):
    Result:=FAnalysisVariant;
  ord(udpReversed):
    Result:=FReversed;
  ord(udpReorded):
    Result:=FReorded;
  ord(udpAddTarget):
    Result:=FAddTarget;
  ord(udpAddBackPath):
    Result:=FAddBackPath;
  ord(udpUserDefinedResponceTime):
    Result:=FUserDefinedResponceTime;
  ord(udpResponceTime):
    Result:=FResponceTime;
  ord(udpUserDefinedResponceTimeDispersionRatio):
    Result:=FUserDefinedResponceTimeDispersionRatio;
  ord(udpResponceTimeDispersionRatio):
    Result:=FResponceTimeDispersionRatio;
  ord(udpBaseLineGroup):
    Result:=FBaseLineGroup
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TUserDefinedPath.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(udpAnalysisVariant):
    theCollection:=(DataModel as IDMElement).Collection[_AnalysisVariant];
  ord(udpBaseLineGroup):
    theCollection:=(DataModel as ISpatialModel).LineGroups;
  else
    begin
      inherited;
      Exit;
    end;
  end;
  if aCollection=nil then
    aCollection:=theCollection
  else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;
    if theCollection=nil then Exit;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

function TUserDefinedPath.GetResponceTime: double;
begin
  if FUserDefinedResponceTime then
    Result:=FResponceTime
  else
    Result:=inherited GetResponceTime
end;

function TUserDefinedPath.GetResponceTimeDispersion: double;
begin
  if FUserDefinedResponceTime then
    Result:=FResponceTimeDispersion
  else
    Result:=inherited GetResponceTimeDispersion
end;

function TUserDefinedPath.Get_AnalysisVariant: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FAnalysisVariant;
  Result:=Unk as IDMElement
end;

function TUserDefinedPath.Get_SpatialElementClassID: Integer;
begin
  Result:=_LineGroup
end;

procedure TUserDefinedPath.Initialize;
var
  FacilityModel:IFacilityModel;
begin
  inherited;
  FacilityModel:=DataModel as IFacilityModel;
  FDisordedLines:=TDMCollection.Create(Self) as IDMCollection;
end;

procedure TUserDefinedPath.Loaded;
begin
    inherited;
end;

class procedure TUserDefinedPath.MakeFields0;
var
  S:WideString;
begin
  inherited;

  AddField(rsAnalysisVariant, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(udpAnalysisVariant), 0, pkInput);
  AddField(rsReversed, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(udpReversed), 0, pkInput);
  AddField(rsReorded, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(udpReorded), 0, pkInput);
  S:='|'+rsNot+
     '|'+rsAddMainTarget+
     '|'+rsAddBattlePosition;
  AddField(rsAddTarget, S, '', '',
                 fvtChoice, 1, 0, 0,
                 ord(udpAddTarget), 0, pkInput);
  AddField(rsAddBackPath, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(udpAddBackPath), 0, pkInput);
  AddField(rsUserDefinedResponceTime, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(udpUserDefinedResponceTime), 0, pkUserDefined);
  AddField(rsResponceTime, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(udpResponceTime), 2, pkUserDefined or pkChart);
  AddField(rsUserDefinedResponceTimeDispersionRatio, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(udpUserDefinedResponceTimeDispersionRatio), 0, pkUserDefined);
  AddField(rsResponceTimeDispersionRatio, '%0.3f', '', '',
                 fvtFloat, 0.13, 0, 1,
                 ord(udpResponceTimeDispersionRatio), 2, pkUserDefined);
  AddField(rsBaseLineGroup, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(udpBaseLineGroup), 1, pkAdditional);
{
  AddField(rsOptimised, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(udpOptimised), 0, pkInput);
}
end;

procedure TUserDefinedPath.SetFieldValue(Code: integer; Value: OleVariant);

  procedure UpdateUserDefinedElements;
  var
     Document:IDMDocument;
  begin
     if DataModel=nil then Exit;
     if not DataModel.IsLoading and
        not DataModel.IsCopying and
       (Get_WarriorPathElements<>nil) then begin
       Document:=DataModel.Document as IDMDocument;
       if Document.Server=nil then Exit;
       (Document.Server as IDataModelServer).RefreshElement(Self as IUnknown);
     end;
  end;

var
  LineGroup:ILineGroup;
  theLines:IDMCollection;
  j:integer;
begin
  case Code of
  ord(udpAnalysisVariant):
    begin
      FAnalysisVariant:=Value;
     if not DataModel.IsLoading and
        (Get_AnalysisVariant<>nil) then
      Rebuild(False);
    end;
  ord(udpReversed):
    begin
      FReversed:=Value;
      Rebuild(False);
    end;
  ord(udpReorded):
    begin
      FReorded:=Value;

      if DataModel.IsCopying then Exit;

      LineGroup:=GetBaseLineGroup as ILineGroup;

      if LineGroup=nil then Exit;
      theLines:=LineGroup.Lines;
      if FReorded then begin
        (FDisordedLines as IDMCollection2).Clear;
        for j:=0 to theLines.Count-1 do
          (FDisordedLines as IDMCollection2).Add(theLines.Item[j]);

        LineGroup.ReorderLines(theLines)
      end else begin
        (theLines as IDMCollection2).Clear;
        for j:=0 to FDisordedLines.Count-1 do
          (theLines as IDMCollection2).Add(FDisordedLines.Item[j])
      end;

      Rebuild(True);
    end;
  ord(udpAddTarget):
    begin
      FAddTarget:=Value;
      if FAddTarget<>1 then
        FAddBackPath:=False;
      Rebuild(True);
    end;
  ord(udpAddBackPath):
    begin
      FAddBackPath:=Value;
      if FAddBackPath then
        FAddTarget:=1;
      Rebuild(True);
    end;
  ord(udpUserDefinedResponceTime):
    begin
      FUserDefinedResponceTime:=Value;
      UpdateUserDefinedElements;
    end;
  ord(udpResponceTime):
    begin
      FResponceTime:=Value;
      SetResponceTimeDispersion;
      if (not DataModel.IsCopying) and
         (not DataModel.IsLoading) then
        Analysis;
    end;
  ord(udpUserDefinedResponceTimeDispersionRatio):
    begin
      FUserDefinedResponceTimeDispersionRatio:=Value;
      SetResponceTimeDispersion;
      UpdateUserDefinedElements;
    end;
  ord(udpResponceTimeDispersionRatio):
    begin
      FResponceTimeDispersionRatio:=Value;
      SetResponceTimeDispersion;
      if (not DataModel.IsCopying) and
         (not DataModel.IsLoading) then
        Analysis;
    end;
  ord(udpBaseLineGroup):
    FBaseLineGroup:=Value
  else
    inherited;
  end;
end;

procedure TUserDefinedPath.SetResponceTimeDispersion;
var
  aFacilityModel:IFacilityModel;
  ResponceTimeDispersionRatio:double;
begin
  if (not FUserDefinedResponceTimeDispersionRatio) and
    (DataModel<>nil) then begin
    aFacilityModel:=DataModel as IFacilityModel;
    ResponceTimeDispersionRatio:=aFacilityModel.ResponceTimeDispersionRatio
  end else
    ResponceTimeDispersionRatio:=FResponceTimeDispersionRatio;
  FResponceTimeDispersion:=sqr(ResponceTimeDispersionRatio*FResponceTime);
end;

procedure TUserDefinedPath.Set_AnalysisVariant(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FAnalysisVariant:=Unk;
end;

procedure TUserDefinedPath.Update;
var
  j:integer;
  theLines:IDMCollection;
  LineGroup:ILineGroup;
  AnalysisVariantE:IDMElement;
  FacilityModelS:IFMState;
begin
  inherited;
  LineGroup:=GetBaseLineGroup as ILineGroup;

  if LineGroup=nil then Exit;
  theLines:=LineGroup.Lines;

 (FDisordedLines as IDMCollection2).Clear;
  for j:=0 to theLines.Count-1 do
    (FDisordedLines as IDMCollection2).Add(theLines.Item[j]);

  if (not DataModel.IsLoading) then begin
    Build(tmToRoot, False, True, nil);
    FacilityModelS:=DataModel as IFMState;
    AnalysisVariantE:=FacilityModelS.CurrentAnalysisVariantU as IDMElement;
    Set_AnalysisVariant(AnalysisVariantE);
    Analysis;
  end;

end;

procedure TUserDefinedPath._AddBackRef(const aElement: IDMElement);
var
  Unk:IUnknown;
begin
  if aElement.ClassID=_LineGroup then begin
    Set_SpatialElement(aElement);
    if not DataModel.IsCopying then begin  // копируется через соответствующий параметр
      Unk:=aElement as IUnknown;
      FBaseLineGroup:=Unk;
    end;
  end else
  if aElement.ClassID=_Polyline then
    Set_SpatialElement(aElement)
end;

procedure TUserDefinedPath._Destroy;
begin
  inherited;
  FDisordedLines:=nil;
end;

{ TUserDefinedPaths }

class function TUserDefinedPaths.GetElementClass: TDMElementClass;
begin
  Result:=TUserDefinedPath;
end;

function TUserDefinedPaths.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsUserDefinedPath;
end;

class function TUserDefinedPaths.GetElementGUID: TGUID;
begin
  Result:=IID_IUserDefinedPath;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TUserDefinedPath.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
