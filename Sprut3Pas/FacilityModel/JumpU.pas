unit JumpU;

interface
uses
  Classes, SysUtils, Math, Variants,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomBoundaryU;

type

  TJump=class(TCustomBoundary, IJump)
  private
    FBoundary0:Variant;
    FBoundary1:Variant;
    FZone0:Variant;
    FZone1:Variant;
    FWidth:double;
    FClimbUpVelocity: Double;
    FClimbDownVelocity: Double;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    procedure Loaded; override;
    procedure AfterLoading1; override; safecall;
    procedure DisconnectFrom(const aParent:IDMElement); override; safecall;
    function  Get_MainParent: IDMElement; override; safecall;
    procedure AddParent(const aParent:IDMElement); override;
    procedure RemoveParent(const aParent:IDMElement); override; safecall;
    procedure Set_Parent(const aParent:IDMElement); override;
    procedure Set_Ref(const Value:IDMElement); override;

    procedure Clear; override;
    procedure _AddBackRef(const aElement:IDMElement); override; safecall;
    function Get_Boundary0:IDMElement; safecall;
    procedure Set_Boundary0(const Value:IDMElement); safecall;
    function Get_Boundary1:IDMElement; safecall;
    procedure Set_Boundary1(const Value:IDMElement); safecall;
    function Get_Zone0:IDMElement; override; safecall;
    procedure Set_Zone0(const Value:IDMElement); override; safecall;
    function Get_Zone1:IDMElement; override; safecall;
    procedure Set_Zone1(const Value:IDMElement); override; safecall;
    function  Get_ClimbUpVelocity: Double; safecall;
    function  Get_ClimbDownVelocity: Double; safecall;
    procedure SetZones; safecall;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;


    function  GetMethodDimItemIndex(Kind: Integer; Code: Integer; const DimItems: IDMCollection;
                                    const ParamE: IDMElement; ParamF: Double): Integer; override; safecall;

    function GetPassVelocity: double; override; safecall;

    procedure CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                            out BestTacticE:IDMElement;
                            aAddDelay:double); override;

    procedure CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                          aAddDelay:double); override;

    procedure Initialize; override;
    procedure  _Destroy; override;
  end;

  TJumps=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  Outlines;

var
  FFields:IDMCollection;

{ TJump }

class function TJump.GetClassID: integer;
begin
  Result:=_Jump;
end;

class function TJump.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TJump.Get_Boundary0: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FBoundary0;
  Result:=Unk as IDMElement
end;

function TJump.Get_Boundary1: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FBoundary1;
  Result:=Unk as IDMElement
end;

class procedure TJump.MakeFields0;
begin
  inherited;
  AddField(rsBoundary0, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(loBoundary0), 0, pkInput);
  AddField(rsZone0, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(loZone0), 0, pkInput);
  AddField(rsBoundary1, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(loBoundary1), 0, pkInput);
  AddField(rsZone1, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(loZone1), 0, pkInput);
  AddField(rsWidthM, '%0.2f', '', '',
                 fvtFloat, 1.0, 0, 0,
                 ord(loWidth), 0, pkInput);
  AddField(rsClimbUpVelocity, '%0.2f', '', '',
                 fvtFloat, 1.0, 0, 0,
                 ord(loClimbUpVelocity), 0, pkInput);
  AddField(rsClimbDownVelocity, '%0.2f', '', '',
                 fvtFloat, 1.0, 0, 0,
                 ord(loClimbDownVelocity), 0, pkInput);
end;

function TJump.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(loBoundary0):Result:=FBoundary0;
  ord(loZone0):Result:=FZone0;
  ord(loBoundary1):Result:=FBoundary1;
  ord(loZone1):Result:=FZone1;
  ord(loWidth):Result:=FWidth;
  ord(loClimbUpVelocity):Result:=FClimbUpVelocity;
  ord(loClimbDownVelocity):Result:=FClimbDownVelocity;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TJump.SetFieldValue(Code: integer; Value: OleVariant);
var
  Zone:IZone;
  SelfE:IDMElement;
  j:integer;
  FacilityModel:IFacilityModel;
begin
  case Code of
  ord(loBoundary0):FBoundary0:=Value;
  ord(loZone0):
    begin
      SelfE:=Self as IDMElement;

      if not DataModel.IsLoading and
         not VarIsNull(FZone0) and
         not VarIsEmpty(FZone0) and
         Get_Exists then  begin
        Zone:=Get_Zone0 as IZone;
        if Zone=nil then begin
          FacilityModel:=DataModel as IFacilityModel;
          Zone:=FacilityModel.Enviroments as IZone;
        end;
        j:=Zone.Jumps.IndexOf(SelfE);
        if j<>-1 then
          (Zone.Jumps as IDMCollection2).Delete(j);
      end;

      FZone0:=Value;

      if not DataModel.IsLoading and
         not VarIsNull(FZone0) and
         not VarIsEmpty(FZone0) and
         Get_Exists then  begin
        Zone:=Get_Zone0 as IZone;
        if Zone=nil then begin
          FacilityModel:=DataModel as IFacilityModel;
          Zone:=FacilityModel.Enviroments as IZone;
        end;
        j:=Zone.Jumps.IndexOf(SelfE);
        if j=-1 then
          (Zone.Jumps as IDMCollection2).Add(SelfE)
      end;
    end;
  ord(loBoundary1):FBoundary1:=Value;
  ord(loZone1):
    begin
      SelfE:=Self as IDMElement;

      if not DataModel.IsLoading and
         not VarIsNull(FZone1) and
         not VarIsEmpty(FZone1) and
         Get_Exists then  begin
        Zone:=Get_Zone1 as IZone;
        if Zone=nil then begin
          FacilityModel:=DataModel as IFacilityModel;
          Zone:=FacilityModel.Enviroments as IZone;
        end;
        j:=Zone.Jumps.IndexOf(SelfE);
        if j<>-1 then
          (Zone.Jumps as IDMCollection2).Delete(j);
      end;

      FZone1:=Value;

      if not DataModel.IsLoading and
         not VarIsNull(FZone1) and
         not VarIsEmpty(FZone1) and
         Get_Exists then begin
        Zone:=Get_Zone1 as IZone;
        if Zone=nil then begin
          FacilityModel:=DataModel as IFacilityModel;
          Zone:=FacilityModel.Enviroments as IZone;
        end;
        j:=Zone.Jumps.IndexOf(SelfE);
        if j=-1 then
          (Zone.Jumps as IDMCollection2).Add(SelfE)
      end;
    end;
  ord(loWidth):FWidth:=Value;
  ord(loClimbUpVelocity):FClimbUpVelocity:=Value;
  ord(loClimbDownVelocity):FClimbDownVelocity:=Value;
  else
    inherited;
  end;
end;

procedure TJump.Set_Boundary0(const Value: IDMElement);
var
  Unk:IUnknown;
  aBoundaryE:IDMElement;
begin
  aBoundaryE:=Get_Boundary0;
  if aBoundaryE<>nil then
    aBoundaryE._RemoveBackRef(Self as IDMElement);

  Unk:=Value as IDMElement;
  FBoundary0:=Unk;

  aBoundaryE:=Get_Boundary0;
  if aBoundaryE<>nil then
    aBoundaryE._AddBackRef(Self as IDMElement)
end;

procedure TJump.Set_Boundary1(const Value: IDMElement);
var
  Unk:IUnknown;
  aBoundaryE:IDMElement;
begin
  aBoundaryE:=Get_Boundary1;
  if aBoundaryE<>nil then
    aBoundaryE._RemoveBackRef(Self as IDMElement);

  Unk:=Value as IDMElement;
  FBoundary1:=Unk;

  aBoundaryE:=Get_Boundary1;
  if aBoundaryE<>nil then
    aBoundaryE._AddBackRef(Self as IDMElement)
end;

procedure TJump.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
  Area:IArea;
  Volume0E, Volume1E, BoundaryE, ZoneE:IDMElement;
begin
  if aCollection=nil then begin
    case Code of
    ord(loBoundary0),
    ord(loBoundary1):
       aCollection:=(DataModel as IFacilityModel).Boundaries;
    ord(loZone0),
    ord(loZone1):
       aCollection:=(DataModel as IFacilityModel).Zones;
    else
      begin
        inherited;
      end;
    end;
  end else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;

    theCollection:=nil;
    case Code of
    ord(loBoundary0),
    ord(loBoundary1):
       if SpatialElement=nil then begin
         case Code of
         ord(loBoundary0):
           ZoneE:=Get_Zone0
         else
           ZoneE:=Get_Zone1
         end;
         if (ZoneE<>nil) and
            (ZoneE.SpatialElement<>nil) then begin
           theCollection:=(ZoneE.SpatialElement as IVolume).Areas;
           for j:=0 to theCollection.Count-1 do
             aCollection2.Add(theCollection.Item[j].Ref)
         end;
       end else begin
         case Code of
         ord(loBoundary0):
           BoundaryE:=Get_Boundary0;
         else
           BoundaryE:=Get_Boundary1;
         end;
         if BoundaryE<>nil then
           aCollection2.Add(BoundaryE);
       end;
    ord(loZone0),
    ord(loZone1):
       if SpatialElement=nil then begin
         theCollection:=(DataModel as IFacilityModel).Zones;
         for j:=0 to theCollection.Count-1 do
           if (theCollection.Item[j] as IZone).Zones.Count=0 then
             aCollection2.Add(theCollection.Item[j])
       end else begin
         case Code of
         ord(loZone0):
           BoundaryE:=Get_Boundary0;
         else
           BoundaryE:=Get_Boundary1;
         end;
         if BoundaryE<>nil then begin
           Area:=BoundaryE.SpatialElement as IArea;
           Volume0E:=Area.Volume0 as IDMElement;
           Volume1E:=Area.Volume1 as IDMElement;
           if Volume0E<>nil then
             aCollection2.Add(Volume0E.Ref);
           if Volume1E<>nil then
             aCollection2.Add(Volume1E.Ref);
         end else begin
           case Code of
           ord(loZone0):
             ZoneE:=Get_Zone0
           else
             ZoneE:=Get_Zone1
           end;
           if ZoneE<>nil then
             aCollection2.Add(ZoneE);
         end;
       end;
    else
      begin
        inherited;
      end;
    end;
  end;
end;

procedure TJump.Clear;
begin
  if SpatialElement<>nil then
    ((DataModel as IDMElement).Collection[SpatialElement.Get_ClassID] as IDMCollection2).Remove(SpatialElement);
  inherited;
end;

procedure TJump._AddBackRef(const aElement: IDMElement);
begin
  if (aElement.DataModel=DataModel) and
     (aElement.ClassID=_Line) and
     (aElement.Parent<>nil) then
    Set_SpatialElement(aElement)
  else
    inherited
end;

procedure TJump.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  Image:IElementImage;
  Painter:IPainter;
  LocalView, View:IView;
  aDrawSelected:integer;
  C0, C1, aC0, aC1:ICoordNode;
  Line0, Line:ILine;
  SpatialModel2:ISpatialModel2;
  L, W, ScaleFactor, sin_A, X0, Y0, Z0, X1, Y1, Z1, ZAngle:double;
  Document:IDMDocument;
  OldState:integer;
  Area0:IArea;
  Boundary0:IDMElement;
begin
  if SpatialElement=nil then Exit;
  if Ref=nil then Exit;
  if not (SpatialElement.Parent as ILayer).Visible then Exit;

  Painter:=aPainter as IPainter;
  View:=Painter.ViewU as IView;

  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfExecuting;
  try

  SpatialModel2:=DataModel as ISpatialModel2;
  Image:=(Ref as ILocalObjectKind).Image;
  if (Image<>nil) and
     (DataModel as IVulnerabilityMap).ShowSymbols then begin
    LocalView:=(SpatialModel2.Views as IDMCollection2).CreateElement(False) as IView;
    Boundary0:=Get_Boundary0;
    if (Boundary0<>nil) and
       (Boundary0.SpatialElement<>nil) then begin
      Area0:=Get_Boundary0.SpatialElement as IArea;
      Line0:=Area0.BottomLines.Item[0] as  ILine;
    end else
      Line0:=nil;
    
    Line:=SpatialElement as ILine;
    C0:=Line.C0;
    C1:=Line.C1;

    Z0:=C0.Z;
    Z1:=C1.Z;
    if Z0<Z1 then begin
      X0:=C0.X;
      Y0:=C0.Y;
      X1:=C1.X;
      Y1:=C1.Y;
    end else begin
      X0:=C1.X;
      Y0:=C1.Y;
      X1:=C0.X;
      Y1:=C0.Y;
    end;

    LocalView.CX:=0.5*(X0+X1);
    LocalView.CY:=0.5*(Y0+Y1);
    LocalView.CZ:=min(Z0,Z1);

    L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
    if L=0 then begin
      if Line0<>nil then
        ZAngle:=Line0.ZAngle
      else
        ZAngle:=0;
    end else begin
      sin_A:=(X1-X0)/L;
      if sin_A=0 then
        ZAngle:=0
      else
      if sin_A=1 then
        ZAngle:=90
      else
      if sin_A=-1 then
        ZAngle:=-90
      else
        ZAngle:=arcsin(sin_A)/3.1415926*180;
      if Y1>Y0 then
        ZAngle:=180-ZAngle;
    end;

    LocalView.ZAngle:=ZAngle;
    ScaleFactor:=1;

    case Image.ScalingType of
    eitNoScaling:
      LocalView.RevScale:=1/View.RevScale;
    eitScaling:
       LocalView.RevScale:=1;
    eitXScaling:
      begin
        LocalView.ZAngle:=ZAngle+90;
        LocalView.RevScaleX:=Image.XSize/L/ScaleFactor;
        W:=FWidth*100;
        if W=0 then
          LocalView.RevScaleY:=1
        else
          LocalView.RevScaleY:=Image.YSize/W/ScaleFactor;
        LocalView.RevScaleZ:=1;
      end;
    eitXYScaling:
      begin
        if Area0<>nil then begin
          aC0:=Area0.C0;
          aC1:=Area0.C1;
          L:=sqrt(sqr(aC0.X-aC1.X)+sqr(aC0.Y-aC1.Y));
          LocalView.RevScaleX:=Image.XSize/L;
        end else
          LocalView.RevScaleX:=1;

        LocalView.RevScaleY:=LocalView.RevScaleX;
        if (Image.ZSize<>0) and
           (Z1<>Z0) then
          LocalView.RevScaleZ:=Image.ZSize/abs(Z1-Z0)
        else
          LocalView.RevScaleZ:=1
      end;
    eitXYZScaling:
      begin
        L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
        if L<>0 then
          LocalView.RevScaleY:=Image.YSize/L
        else
          LocalView.RevScaleY:=1;
        L:=FWidth*100;

        LocalView.RevScaleX:=Image.XSize/L;
        if Z1<>Z0 then
          LocalView.RevScaleZ:=Image.ZSize/abs(Z1-Z0)
        else
          LocalView.RevScaleZ:=1
      end;
    end;
     Painter.LocalViewU:=LocalView;

    if (DrawSelected=1) or SpatialElement.Selected then
      aDrawSelected:=1
    else
      aDrawSelected:=0;
    (Image as IDMElement).Draw(aPainter, aDrawSelected);

    Painter.LocalViewU:=nil;
  end else begin
    if (DrawSelected=1) or SpatialElement.Selected then
      aDrawSelected:=1
    else
      aDrawSelected:=0;
    SpatialElement.Draw(aPainter, aDrawSelected);
  end;
  finally
    Document.State:=OldState;
  end;
end;

procedure TJump.AfterLoading1;
var
  aBoundaryE:IDMElement;
begin
  inherited;
  aBoundaryE:=Get_Boundary0;
  if aBoundaryE<>nil then
    aBoundaryE._AddBackRef(Self as IDMElement);

  aBoundaryE:=Get_Boundary1;
  if aBoundaryE<>nil then
    aBoundaryE._AddBackRef(Self as IDMElement);
end;

function TJump.Get_Zone0: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FZone0;
  Result:=Unk as IDMElement
end;

function TJump.Get_Zone1: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FZone1;
  Result:=Unk as IDMElement
end;

procedure TJump.Set_Zone0(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IDMElement;
  FZone0:=Unk;
end;

procedure TJump.Set_Zone1(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IDMElement;
  FZone1:=Unk;
end;

procedure TJump.Loaded;
var
  Zone:IZone;
  SelfE:IDMElement;
  j:integer;
  FacilityModel:IFacilityModel;
begin
  inherited;

  SelfE:=Self as IDMElement;

  Zone:=Get_Zone0 as IZone;
  if Zone=nil then begin
    FacilityModel:=DataModel as IFacilityModel;
    Zone:=FacilityModel.Enviroments as IZone;
  end;
  j:=Zone.Jumps.IndexOf(SelfE);
  if j=-1 then
    (Zone.Jumps as IDMCollection2).Add(SelfE);

  Zone:=Get_Zone1 as IZone;
  if Zone=nil then begin
    FacilityModel:=DataModel as IFacilityModel;
    Zone:=FacilityModel.Enviroments as IZone;
  end;
  j:=Zone.Jumps.IndexOf(SelfE);
  if j=-1 then
    (Zone.Jumps as IDMCollection2).Add(SelfE);

end;

procedure TJump.DisconnectFrom(const aParent: IDMElement);
begin
  inherited;
  RemoveParent(aParent);
  if aParent=Get_Zone0 as IDMElement then begin
    Set_Zone0(nil);
  end else
  if aParent=Get_Zone1 as IDMElement then begin
    Set_Zone1(nil)
  end;  
end;

function TJump.Get_MainParent: IDMElement;
var
  FacilityModel:IFacilityModel;
begin
  Result:=Get_Zone0 as IDMElement;
  if Result=nil then
    Result:=Get_Zone1 as IDMElement;
  if Result=nil then begin
    FacilityModel:=DataModel as IFacilityModel;
    Result:=FacilityModel.Enviroments;
  end;
end;

procedure TJump.AddParent(const aParent: IDMElement);
begin
  if aParent=nil then Exit;
  aParent.AddChild(Self as IDMElement)
end;

procedure TJump.RemoveParent(const aParent: IDMElement);
begin
  if aParent=nil then Exit;
  aParent.RemoveChild(Self as IDMElement)
end;

procedure TJump.Set_Parent(const aParent: IDMElement);
begin
  if aParent=nil then Exit;
  aParent.AddChild(Self as IDMElement)
end;

procedure TJump._Destroy;
begin
  inherited;
end;

procedure TJump.Initialize;
begin
  inherited;
end;

function TJump.GetMethodDimItemIndex(Kind, Code: Integer;
  const DimItems: IDMCollection; const ParamE: IDMElement;
  ParamF: Double): Integer;
begin
  Result:=-1;
end;

function TJump.Get_ClimbDownVelocity: Double;
begin
  Result:=FClimbDownVelocity
end;

function TJump.Get_ClimbUpVelocity: Double;
begin
  Result:=FClimbUpVelocity
end;

procedure TJump.Set_Ref(const Value: IDMElement);
var
  JumpKind:IJumpKind;
begin
  inherited;
  if Ref=nil then Exit;
  JumpKind:=Ref as IJumpKind;
  FClimbUpVelocity:=JumpKind.ClimbUpVelocity;
  FClimbDownVelocity:=JumpKind.ClimbDownVelocity;
end;

procedure TJump.SetZones;
var
  Boundary0E, Boundary1E, Zone0E, Zone1E, SelfE, theZone0E, theZone1E:IDMElement;
  aVolume0, aVolume1, theVolume0, theVolume1,
  Volume00, Volume01, Volume10, Volume11:IVolume;
  Area:IArea;
  DMOperationManager:IDMOperationManager;
  aCollection0, aCollection1:IDMCollection;
  SpatialModel2:ISpatialModel2;
  D, MinD:double;

  function EqualVolumes(const aVolume0,aVolume1:IVolume):boolean;
  begin
    if aVolume0=aVolume1 then begin
      if theVolume0<>nil then
        theZone0E:=(theVolume0 as IDMElement).Ref
      else
        theZone0E:=nil;
      if theVolume1<>nil then
        theZone1E:=(theVolume1 as IDMElement).Ref
      else
        theZone1E:=nil;
      DMOperationManager.ChangeFieldValue(SelfE, ord(loZone0), True, theZone0E);
      DMOperationManager.ChangeFieldValue(SelfE, ord(loZone1), True, theZone1E);
      Result:=True
    end else
      Result:=False
  end;

  function AdjacentVolumes(const aVolume0,aVolume1:IVolume):boolean;
  begin
    if (aVolume0<>nil) and (aVolume1<>nil) and
        aVolume0.AdjacentTo(aVolume1) then begin
      theZone0E:=(theVolume0 as IDMElement).Ref;
      theZone1E:=(theVolume1 as IDMElement).Ref;
      DMOperationManager.ChangeFieldValue(SelfE, ord(loZone0), True, theZone0E);
      DMOperationManager.ChangeFieldValue(SelfE, ord(loZone1), True, theZone1E);
      Result:=True
    end else
      Result:=False
  end;

  function Distance(const aVolume0,aVolume1:IVolume):double;
  var
    X0, Y0, Z0, X1, Y1, Z1:double;
    aLine:ILine;
  begin
    if aVolume0<>nil then begin
      (aCollection0 as IDMCollection2).Clear;
      SpatialModel2.MakeVolumeOutline(aVolume0, aCollection0);
      GetOutlineCentralPoint(aCollection0, X0, Y0, Z0);
    end else begin
      aLine:=SpatialElement as ILine;
      X0:=aLine.C0.X;
      Y0:=aLine.C0.Y;
      Z0:=aLine.C0.Z;
    end;


    if aVolume1<>nil then begin
      (aCollection1 as IDMCollection2).Clear;
      SpatialModel2.MakeVolumeOutline(aVolume1, aCollection1);
      GetOutlineCentralPoint(aCollection1, X1, Y1, Z1);
    end else begin
      aLine:=SpatialElement as ILine;
      X1:=aLine.C1.X;
      Y1:=aLine.C1.Y;
      Z1:=aLine.C1.Z;
    end;

    Result:=sqrt(sqr(X1-X0)+sqr(Y1-Y0)+sqr(Z1-Z0))
  end;

begin
  Boundary0E:=Get_Boundary0;
  Boundary1E:=Get_Boundary1;
  if (Boundary0E=nil) and
     (Boundary1E=nil) then
    Exit;
  if Boundary0E<>nil then begin
    Area:=Boundary0E.SpatialElement as IArea;
    Volume00:=Area.Volume0;
    Volume01:=Area.Volume1;
  end else begin
    Zone0E:=Get_Zone0;
    if Zone0E<>nil then begin
      Volume00:=Zone0E.SpatialElement as IVolume;
      Volume01:=Volume00;
    end else begin
      Volume00:=nil;
      Volume01:=nil;
    end;
  end;
  if Boundary1E<>nil then begin
    Area:=Boundary1E.SpatialElement as IArea;
    Volume10:=Area.Volume0;
    Volume11:=Area.Volume1;
  end else begin
    Zone1E:=Get_Zone1;
    if Zone1E<>nil then begin
      Volume10:=Zone1E.SpatialElement as IVolume;
      Volume11:=Volume10;
    end else begin
      Volume10:=nil;
      Volume11:=nil;
    end;
  end;


  DMOperationManager:=DataModel.Document as IDMOperationManager;
  SelfE:=Self as IDMElement;

  theVolume0:=Volume00;
  aVolume0:=Volume01;
  theVolume1:=Volume10;
  aVolume1:=Volume11;
  if EqualVolumes(aVolume0,aVolume1) then
    Exit;
  theVolume0:=Volume00;
  aVolume0:=Volume01;
  theVolume1:=Volume11;
  aVolume1:=Volume10;
  if EqualVolumes(aVolume0,aVolume1) then
    Exit;
  theVolume0:=Volume01;
  aVolume0:=Volume00;
  theVolume1:=Volume10;
  aVolume1:=Volume11;
  if EqualVolumes(aVolume0,aVolume1) then
    Exit;
  theVolume0:=Volume01;
  aVolume0:=Volume00;
  theVolume1:=Volume11;
  aVolume1:=Volume10;
  if EqualVolumes(aVolume0,aVolume1) then
    Exit;

  theVolume0:=Volume00;
  aVolume0:=Volume01;
  theVolume1:=Volume10;
  aVolume1:=Volume11;
  if AdjacentVolumes(aVolume0,aVolume1) then
    Exit;
  theVolume0:=Volume00;
  aVolume0:=Volume01;
  theVolume1:=Volume11;
  aVolume1:=Volume10;
  if AdjacentVolumes(aVolume0,aVolume1) then
    Exit;
  theVolume0:=Volume01;
  aVolume0:=Volume00;
  theVolume1:=Volume10;
  aVolume1:=Volume11;
  if AdjacentVolumes(aVolume0,aVolume1) then
    Exit;
  theVolume0:=Volume01;
  aVolume0:=Volume00;
  theVolume1:=Volume11;
  aVolume1:=Volume10;
  if AdjacentVolumes(aVolume0,aVolume1) then
    Exit;

  SpatialModel2:=DataModel as ISpatialModel2;

  aCollection0:=TDMCollection.Create(nil) as IDMCollection;
  aCollection1:=TDMCollection.Create(nil) as IDMCollection;

  if theVolume0<>nil then
    theZone0E:=(theVolume0 as IDMElement).Ref
  else
    theZone0E:=nil;
  if theVolume1<>nil then
    theZone1E:=(theVolume1 as IDMElement).Ref
  else
    theZone1E:=nil;

  minD:=InfinitValue;
  theVolume0:=Volume00;
  aVolume0:=Volume01;
  theVolume1:=Volume10;
  aVolume1:=Volume11;
  D:=Distance(aVolume0,aVolume1);
  if minD>D then begin
    minD:=D;
    if theVolume0<>nil then
      theZone0E:=(theVolume0 as IDMElement).Ref
    else
      theZone0E:=nil;
    if theVolume1<>nil then
      theZone1E:=(theVolume1 as IDMElement).Ref
    else
      theZone1E:=nil;
  end;
  theVolume0:=Volume00;
  aVolume0:=Volume01;
  theVolume1:=Volume11;
  aVolume1:=Volume10;
  D:=Distance(aVolume0,aVolume1);
  if minD>D then begin
    minD:=D;
    if theVolume0<>nil then
      theZone0E:=(theVolume0 as IDMElement).Ref
    else
      theZone0E:=nil;
    if theVolume1<>nil then
      theZone1E:=(theVolume1 as IDMElement).Ref
    else
      theZone1E:=nil;
  end;
  theVolume0:=Volume01;
  aVolume0:=Volume00;
  theVolume1:=Volume10;
  aVolume1:=Volume11;
  D:=Distance(aVolume0,aVolume1);
  if minD>D then begin
    minD:=D;
    if theVolume0<>nil then
      theZone0E:=(theVolume0 as IDMElement).Ref
    else
      theZone0E:=nil;
    if theVolume1<>nil then
      theZone1E:=(theVolume1 as IDMElement).Ref
    else
      theZone1E:=nil;
  end;
  theVolume0:=Volume01;
  aVolume0:=Volume00;
  theVolume1:=Volume11;
  aVolume1:=Volume10;
  D:=Distance(aVolume0,aVolume1);
  if minD>D then begin
    if theVolume0<>nil then
      theZone0E:=(theVolume0 as IDMElement).Ref
    else
      theZone0E:=nil;
    if theVolume1<>nil then
      theZone1E:=(theVolume1 as IDMElement).Ref
    else
      theZone1E:=nil;
  end;

  DMOperationManager.ChangeFieldValue(SelfE, ord(loZone0), True, theZone0E);
  DMOperationManager.ChangeFieldValue(SelfE, ord(loZone1), True, theZone1E);
end;

function TJump.GetPassVelocity: double;
var
  JumpKind:IJumpKind;
  Line:ILine;
  NodeDirection:integer;
  FacilityModelS:IFMState;
begin
  JumpKind:=Ref as IJumpKind;
  Line:=SpatialElement as ILine;
  FacilityModelS:=DataModel as IFMState;
  NodeDirection:=FacilityModelS.CurrentNodeDirection;
  if NodeDirection=pdFrom0To1 then begin
    if Line.C1.Z>Line.C0.Z then
      Result:=FClimbUpVelocity*100
    else
      Result:=FClimbDownVelocity*100
  end else begin
    if Line.C1.Z>Line.C0.Z then
      Result:=FClimbDownVelocity*100
    else
      Result:=FClimbUpVelocity*100
  end;
end;

procedure TJump.CalcDelayTime(out DelayTime, DelayTimeDispersion: double;
  out BestTacticE: IDMElement; aAddDelay: double);
var
  AddDelay, PassTime, Length, PassVelocity:double;
  Line:ILine;
begin
  PassVelocity:=GetPassVelocity;
  if SpatialElement<>nil then begin
    Line:=SpatialElement as ILine;
    Length:=Line.Length;
  end else
    Length:=400;
  PassTime:=Length/PassVelocity;
  AddDelay:=aAddDelay+PassTime;

  inherited CalcDelayTime(DelayTime, DelayTimeDispersion,
       BestTacticE, AddDelay);
end;

procedure TJump.CalcPathSuccessProbability(var SuccessProbability: double;
  out AdversaryVictoryProbability: double; var DelayTimeSum,
  DelayTimeDispersionSum: double; aAddDelay: double);
var
  AddDelay, PassTime, Length, PassVelocity:double;
  Line:ILine;
begin
  PassVelocity:=GetPassVelocity;
  if SpatialElement<>nil then begin
    Line:=SpatialElement as ILine;
    Length:=Line.Length;
  end else
    Length:=400;
  PassTime:=Length/PassVelocity;
  AddDelay:=aAddDelay+PassTime;

  inherited CalcPathSuccessProbability(SuccessProbability,
      AdversaryVictoryProbability, DelayTimeSum,
      DelayTimeDispersionSum, AddDelay);
end;

{ TJumps }

class function TJumps.GetElementClass: TDMElementClass;
begin
  Result:=TJump;
end;

function TJumps.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsJump;
end;

class function TJumps.GetElementGUID: TGUID;
begin
  Result:=IID_IJump;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TJump.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
