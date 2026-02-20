unit DistantDetectionElementU;

interface
uses
  Classes, SysUtils, Math,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DetectionElementU;

type
  TDistantDetectionElement=class(TDetectionElement, IDistantDetectionElement, IRotater)
  private
    FName:String;
    FSeparatingAreas:IDMCollection;
    FRotationAngle:double;

    procedure UpdateObservers;
    procedure TreatVolume(const VolumeE, PrevAreaE: IDMElement;
        X0, Y0, Z0:double; const VolumeList, PrevAreaList, AreaList:TList);
    procedure TreatArea(const AreaE, PrevAreaE: IDMElement;
        X0, Y0, Z0, X, Y, Z, Distance:double; const VolumeList, PrevAreaList, AreaList:TList);
    procedure CheckSafeguardElement(X0, Y0, Z0:double;
                                   const SafeguardElementE, ZoneE: IDMElement);
    procedure CheckArea(X0, Y0, Z0:double;
                        const AreaE, PrevAreaE, ZoneE : IDMElement;
                        const VolumeList, PrevAreaList, AreaList:TList);
    procedure CheckJump(X0, Y0, Z0:double;
                                   const JumpE, ZoneE: IDMElement);
  protected
    FObservers:IDMCollection;
    FShowDetectionZone:boolean;
    FUseDetectionZone:boolean;
    FMaxDistance:double;

    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields1; override;
    class procedure MakeFields0; override;
    class function  StoredName: WordBool; override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function  Get_Name:WideString; override; safecall;
    procedure Set_Name(const Value:WideString); override; safecall;
    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure _AddBackRef(const aElement: IDMElement); override; safecall;
    procedure _RemoveBackRef(const aElement: IDMElement); override; safecall;

    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
    procedure AfterLoading2; override; safecall;
    function  Get_IsSelectable: WordBool; override; safecall;
    procedure UpdateCoords; override;

    function  GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double; virtual; safecall;
    function PointInDetectionZone(X, Y, Z:double; const CRef, ExcludeAreaE:IDMElement):WordBool; virtual; safecall;

    procedure Set_LabelVisible(Value: WordBool); override; safecall;
    function DoCalcDetectionProbability(const TacticU:IUnknown;
                          const OvercomeMethodE:IDMElement;
                          DelayTime:double;
                          var DetP0, DetPf, WorkP:double;
                          CalcAll:WordBool):double; override; safecall;
    function GetElevation:double; virtual;
    function GetRotationAngle:double; override;
    function Get_Observers:IDMCollection; safecall;

    function GetObservationKind(Distance:double):integer; virtual;


// IRotater
    procedure Rotate(X0, Y0, cosA, sinA:double); safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TDistantDetectionElement }

procedure TDistantDetectionElement._Destroy;
begin
  inherited;
  FObservers:=nil;
  FSeparatingAreas:=nil;
end;

procedure TDistantDetectionElement.Initialize;
begin
  inherited;
  FObservers:=DataModel.CreateCollection(-1, Self as IDMELement);
  FSeparatingAreas:=DataModel.CreateCollection(-1, nil);
  FSymbolDX:=0;
  FSymbolDX:=0;
  FSymbolDY:=-30;
end;

procedure TDistantDetectionElement.Set_SpatialElement(
  const Value: IDMElement);
begin
  inherited;
end;

function TDistantDetectionElement.PointInDetectionZone(X, Y,
  Z: double; const CRef, ExcludeAreaE:IDMElement): WordBool;
var
  FacilityModel:IFacilityModel;
  X0, Y0, Z0:double;
  SelfE:IDMElement;
  TransparencyCoeff:double;
begin
  if CRef=nil then
    Result:=True
  else begin
    GetCoord(X0, Y0, Z0);
    FacilityModel:=Get_DataModel as IFacilityModel;
    SelfE:=Self as IDMElement;
    Z0:=Z0+GetElevation;
    try
    Result:=(not FacilityModel.FindSeparatingAreas(
                      X, Y, Z,
                      X0, Y0, Z0,
                      CRef, SelfE, 1,
                      FSeparatingAreas, TransparencyCoeff,
                      ExcludeAreaE, nil)) and
             (TransparencyCoeff>0.5)
     except
       raise
     end;
  end
end;

function TDistantDetectionElement.GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double;
begin
  Result:=DetP
end;

class function TDistantDetectionElement.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TDistantDetectionElement.MakeFields1;
var
  S:WideString;
begin
  AddField(rsElevation, '%6.2f', '', '',
                 fvtFloat, 0, 0, InfinitValue,
                 ord(ddpElevation), 0, pkInput);
  AddField(rsLabelVisible,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(ddpLabelVisible), 0, pkView);

  S:='|'+rsLabelNoScale+
     '|'+rsLabelScale;
  AddField(rsLabelScaleMode,  S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(ddpLabelScaleMode), 0, pkView);
  AddField(rsFont,  '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(ddpFont), 0, pkView);
  inherited;

  AddField(rsShowDetectionZone, '', '', '',
           fvtBoolean, 0, 0, 0,
           ord(constShowDetectionZone), 0, pkView);
  AddField(rsUseDetectionZone, '', '', '',
           fvtBoolean, 1, 0, 0,
           ord(constUseDetectionZone), 0, pkAnalysis);
end;

function TDistantDetectionElement.GetFieldValue(Code: integer): OleVariant;
var
  Unk:IUnknown;
begin
  case  Code of
  ord(ddpElevation):
    Result:=FElevation;
  ord(ddpLabelVisible):
    Result:=Get_LabelVisible;
  ord(ddpLabelScaleMode):
    Result:=Get_LabelScaleMode;
  ord(ddpFont):
    begin
      Unk:=Get_Font as IUnknown;
      Result:=Unk;
    end;
  ord(constShowDetectionZone):
    Result:=FShowDetectionZone;
  ord(constUseDetectionZone):
    Result:=FUseDetectionZone;
  ord(constRotationAngle):
    Result:=FRotationAngle;
  ord(constMaxDistance):
    Result:=FMaxDistance;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TDistantDetectionElement.SetFieldValue(Code: integer;
  Value: OleVariant);
var
  B:boolean;
  Mode:integer;
  Unk:IUnknown;
  aFont:ISMFont;
begin
  case Code of
  ord(ddpElevation),
  ord(constShowDetectionZone),
  ord(constRotationAngle),
  ord(constMaxDistance):
    begin
      Redraw(-1);
      case Code of
      ord(ddpElevation):
         FElevation:=Value;
      ord(constShowDetectionZone):
        FShowDetectionZone:=Value;
      ord(constRotationAngle):
        FRotationAngle:=Value;
      ord(constMaxDistance):
        FMaxDistance:=Value;
      end;
      Redraw(1);
    end;
  ord(ddpLabelVisible):
    begin
      if DataModel.IsLoading then Exit;
      B:=Value;
      Set_LabelVisible(B);
    end;
  ord(ddpLabelScaleMode):
    begin
      if DataModel.IsLoading then Exit;
      Mode:=Value;
      Set_LabelScaleMode(Mode);
    end;
  ord(ddpFont):
    begin
      if DataModel.IsLoading then Exit;
      Unk:=Value;
      aFont:=Unk as ISMFont;
      Set_Font(aFont);
    end;
  ord(constUseDetectionZone):
    FUseDetectionZone:=Value;
  else
    inherited;
  end;
end;

procedure TDistantDetectionElement.Set_LabelVisible(Value: WordBool);
var
  aLabel:ISMLabel;
  Line:ILine;
  C0:ICoordNode;
  SMDocument:ISMDocument;
  View:IView;
  SpatialModel2:ISpatialModel2;
begin
  if DataModel.IsLoading then Exit;
  inherited;
  if DataModel.IsCopying then Exit;

  aLabel:=Get_SMLabel as ISMLabel;
  if aLabel=nil then Exit;
  if SpatialElement=nil then Exit;
  
  if SpatialElement.QueryInterface(ILine, Line)=0 then
    C0:=Line.C0
  else
    C0:=SpatialElement as ICoordNode;

  SMDocument:=DataModel.Document as ISMDocument;
  View:=(SMDocument.PainterU as IPainter).ViewU as IView;
  SpatialModel2:=DataModel as ISpatialModel2;
  aLabel.LabelSize:=10*View.RevScale;
end;

function TDistantDetectionElement.Get_Name: WideString;
begin
  Result:=FName
end;

procedure TDistantDetectionElement.Set_Name(const Value: WideString);
begin
  FName:=Value
end;

class function TDistantDetectionElement.StoredName: WordBool;
begin
  Result:=True
end;

procedure TDistantDetectionElement.Set_Parent(const Value: IDMElement);
begin
  inherited;
  if not DataModel.IsLoading then
    UpdateObservers;
end;


procedure TDistantDetectionElement.TreatArea(
   const AreaE, PrevAreaE:IDMElement;
   X0, Y0, Z0, X, Y, Z, Distance:double; const VolumeList, PrevAreaList, AreaList:TList);
var
  Volume0, Volume1:IVolume;
  SelfE, DataModelE, NextVolumeE, BoundaryE:IDMElement;
  Boundary:IBoundary;
  BoundaryFB:IFieldBarrier;
  NX, NY, NZ:double;
  OperationManager:IDMOperationManager;
  Observers:IDMCollection;
  ObserverU:IUnknown;
  Observer:IObserver;
  Area:IArea;
  Volume:IVolume;
begin
  SelfE:=Self as IDMElement;
  DataModelE:=DataModel as IDMElement;
  Observers:=DataModelE.Collection[_Observer];
  OperationManager:=DataModel.Document as IDMOperationManager;

  Area:=AreaE as IArea;
  BoundaryE:=AreaE.Ref;
  if BoundaryE=nil then Exit;

  Boundary:=BoundaryE as IBoundary;
  BoundaryFB:=BoundaryE as IFieldBarrier;

  Volume0:=Area.Volume0;
  Volume1:=Area.Volume1;

  NX:=Area.NX;
  NY:=Area.NY;
  NZ:=Area.NZ;
  
  if (ClassID<>_VolumeSensor) or
     Boundary.IsFragile then begin
    OperationManager.AddElementRef(BoundaryE, Observers, '',
                                 SelfE, ltOneToMany, ObserverU, True);
    Observer:=ObserverU as IObserver;
    Observer.ObservationKind:=GetObservationKind(Distance);
    Observer.Distance:=Distance;
    if (X-X0)*NX+(Y-Y0)*NY+(Z-Z0)*NZ>0 then
      Observer.Side:=0
    else
      Observer.Side:=1
  end;


  if Volume=Volume0 then
    NextVolumeE:=Volume1 as IDMElement
  else
  if Volume=Volume1 then
    NextVolumeE:=Volume0 as IDMElement
  else
    NextVolumeE:=nil;

  if (SpatialElement<>nil) and
     (NextVolumeE<>nil) and
     FUseDetectionZone and
     BoundaryFB.IsTransparent then begin
    if VolumeList.IndexOf(pointer(NextVolumeE))=-1 then begin
       VolumeList.Add(pointer(NextVolumeE));
       PrevAreaList.Add(pointer(AreaE));
    end;
  end;
end;

procedure TDistantDetectionElement.CheckSafeguardElement(X0, Y0, Z0:double;
                               const SafeguardElementE, ZoneE:IDMElement);
var
  Boundary:IBoundary;
  DataModelE, SelfE:IDMElement;
  C0:ICoordNode;
  X, Y, Z, Distance:double;
  OperationManager:IDMOperationManager;
  Observers:IDMCollection;
  ObserverU:IUnknown;
  Observer:IObserver;
begin
  C0:=SafeguardElementE.SpatialElement as ICoordNode;
  X:=C0.X;
  Y:=C0.Y;
  Z:=C0.Z;
  if PointInDetectionZone(X, Y, Z, ZoneE, nil) then begin
    Distance:=sqrt(sqr(X-X0)+sqr(Y-Y0)+sqr(Z-Z0));
    Boundary:=SafeguardElementE as IBoundary;
    DataModelE:=DataModel as IDMELement;
    Observers:=DataModelE.Collection[_Observer];
    OperationManager:=DataModel.Document as IDMOperationManager;
    SelfE:=Self as IDMElement;
    OperationManager.AddElementRef(SafeguardElementE, Observers, '',
                                 SelfE, ltOneToMany, ObserverU, True);
    Observer:=ObserverU as IObserver;
    Observer.ObservationKind:=GetObservationKind(Distance);
    Observer.Distance:=Distance;
  end;
end;

procedure TDistantDetectionElement.CheckJump(X0, Y0, Z0:double;
                          const JumpE, ZoneE:IDMElement);
var
  Boundary:IBoundary;
  Line:ILine;
  Jump:IJump;
  DataModelE, SelfE:IDMElement;
  OperationManager:IDMOperationManager;
  Observers:IDMCollection;
  ObserverU:IUnknown;
  Observer:IObserver;
  C0:ICoordNode;
  X, Y, Z, Distance:double;
begin
  Jump:=JumpE as IJump;
  Line:=JumpE.SpatialElement as ILine;
  if Line=nil then Exit;
  if Jump.Zone0=ZoneE then
    C0:=Line.C0
  else
  if Jump.Zone1=ZoneE then
    C0:=Line.C1
  else
    Exit;
  X:=C0.X;
  Y:=C0.Y;
  Z:=C0.Z;
  if PointInDetectionZone(X, Y, Z, ZoneE, nil) then begin
    Distance:=sqrt(sqr(X-X0)+sqr(Y-Y0)+sqr(Z-Z0));
    Boundary:=JumpE as IBoundary;
    DataModelE:=DataModel as IDMELement;
    Observers:=DataModelE.Collection[_Observer];
    OperationManager:=DataModel.Document as IDMOperationManager;
    SelfE:=Self as IDMElement;
    OperationManager.AddElementRef(JumpE, Observers, '',
                                 SelfE, ltOneToMany, ObserverU, True);
    Observer:=ObserverU as IObserver;
    Observer.ObservationKind:=GetObservationKind(Distance);
    Observer.Distance:=Distance;
    if C0=Line.C0 then
      Observer.Side:=0
    else
      Observer.Side:=1
  end;
end;

procedure TDistantDetectionElement.CheckArea(X0, Y0, Z0:double;
             const AreaE, PrevAreaE, ZoneE:IDMElement;
             const VolumeList, PrevAreaList, AreaList:TList);
var
  FacilityModel:IFacilityModel;
  PathHeight:double;
  Area:IArea;
  C0, C1:ICoordNode;
  X, Y, Z, Distance:double;
begin
  FacilityModel:=DataModel as IFacilityModel;
  Area:=AreaE as IArea;
  PathHeight:=FacilityModel.PathHeight;
  if Area.IsVertical then begin
    C0:=Area.C0;
    C1:=Area.C1;
    if (C0<>nil) and
       (C1<>nil) then begin
      X:=0.5*(C0.X+C1.X);
      Y:=0.5*(C0.Y+C1.Y);
      Z:=0.5*(C0.Z+C1.Z)+100;
    end else
      Exit
  end else begin
    C0:=nil;
    C1:=nil;
    Area.GetCentralPoint(X, Y, Z);
    Z:=Z+PathHeight;
  end;


  if PointInDetectionZone(X, Y, Z, ZoneE, AreaE) then begin
    Distance:=sqrt(sqr(X-X0)+sqr(Y-Y0)+sqr(Z-Z0));
    TreatArea(AreaE, PrevAreaE,  X0, Y0, Z0, X, Y, Z, Distance,
              VolumeList, PrevAreaList, AreaList)

  end else
  if Area.IsVertical and
     (C0<>nil) and
     (C1<>nil) then begin
    X:=C0.X;
    Y:=C0.Y;
    Z:=C0.Z+100;
    if PointInDetectionZone(X, Y, Z, ZoneE, AreaE) then begin
      Distance:=sqrt(sqr(X-X0)+sqr(Y-Y0)+sqr(Z-Z0));
      TreatArea(AreaE, PrevAreaE, X0, Y0, Z0, X, Y, Z, Distance,
              VolumeList, PrevAreaList, AreaList)
    end else begin
      X:=C1.X;
      Y:=C1.Y;
      Z:=C1.Z+100;
      if PointInDetectionZone(X, Y, Z, ZoneE, AreaE) then begin
        Distance:=sqrt(sqr(X-X0)+sqr(Y-Y0)+sqr(Z-Z0));
        TreatArea(AreaE, PrevAreaE,  X0, Y0, Z0, X, Y, Z, Distance,
                  VolumeList, PrevAreaList, AreaList);
      end;
    end;
  end;
end; // TreatArea

procedure TDistantDetectionElement.TreatVolume(
        const VolumeE, PrevAreaE:IDMElement;
        X0, Y0, Z0:double; const VolumeList, PrevAreaList, AreaList:TList);
var
  j:integer;
  AreaE:IDMElement;
  Volume:IVolume;
  ZoneE:IDMElement;
  Zone:IZone;
  k:integer;
  DataModelE, SelfE, aZoneE, SafeguardElementE, JumpE:IDMElement;
  aZone:IZone;
  ZoneSU:ISafeguardUnit;
  Boundary:IBoundary;
  Observers:IDMCollection;
  ObserverU:IUnknown;
  Observer:IObserver;
  OperationManager:IDMOperationManager;
begin
  SelfE:=Self as IDMElement;
  DataModelE:=DataModel as IDMElement;
  OperationManager:=DataModel.Document as IDMOperationManager;

  Volume:=VolumeE as IVolume;
  ZoneE:=(Volume as IDMElement).Ref;
  Zone:=ZoneE as IZone;
  if Zone.TransparencyDist<10 then Exit;

  Observers:=DataModelE.Collection[_Observer];
  OperationManager.AddElementRef(ZoneE, Observers, '',
                                 SelfE, ltOneToMany, ObserverU, True);
  Observer:=ObserverU as IObserver;
  Observer.ObservationKind:=GetObservationKind(0);

  for j:=0 to Volume.Areas.Count-1 do begin
    AreaE:=Volume.Areas.Item[j];
    if AreaList.IndexOf(pointer(AreaE))=-1 then begin
      AreaList.Add(pointer(AreaE));
      CheckArea(X0, Y0, Z0, AreaE, PrevAreaE, ZoneE,
                VolumeList, PrevAreaList, AreaList);
    end;
  end;

  ZoneSU:=Zone as ISafeguardUnit;
  for j:=0 to ZoneSU.SafeguardElements.Count-1 do begin
    SafeguardElementE:=ZoneSU.SafeguardElements.Item[j];
    if SafeguardElementE.QueryInterface(IBoundary, Boundary)=0 then
     CheckSafeguardElement(X0, Y0, Z0, SafeguardElementE, ZoneE);
  end;

  for j:=0 to Zone.Jumps.Count-1 do begin
    JumpE:=Zone.Jumps.Item[j];
    CheckJump(X0, Y0, Z0, JumpE, ZoneE);
  end;

  for k:=0 to Zone.Zones.Count-1 do begin
    aZoneE:=Zone.Zones.Item[k];
    aZone:=aZoneE as IZone;
    for j:=0 to aZone.HAreas.Count-1 do begin
      AreaE:=aZone.HAreas.Item[j];
      if AreaList.IndexOf(pointer(AreaE))=-1 then begin
        AreaList.Add(pointer(AreaE));
        CheckArea(X0, Y0, Z0, AreaE, PrevAreaE, ZoneE,
                VolumeList, PrevAreaList, AreaList);
      end;
    end;
    for j:=0 to aZone.VAreas.Count-1 do begin
      AreaE:=aZone.VAreas.Item[j];
      if AreaList.IndexOf(pointer(AreaE))=-1 then begin
        AreaList.Add(pointer(AreaE));
        CheckArea(X0, Y0, Z0, AreaE, PrevAreaE, ZoneE,
                VolumeList, PrevAreaList, AreaList);
      end;
    end;
  end;
end; // TreatVolume

procedure TDistantDetectionElement.UpdateObservers;
var
  SeparatingAreas2:IDMCollection2;
  VolumeList, PrevAreaList, AreaList:TList;
  VolumeE, SelfE:IDMElement;
  FacilityModel:IFacilityModel;
  X0, Y0, Z0:double;
  Node:ICoordNode;
  ObserverU:IUnknown;
var
  DataModelE, aVolumeE, aPrevAreaE, ZoneE, aElement:IDMElement;
  j:integer;
  Boundary:IBoundary;
  Volume:IVolume;
  Area:IArea;
  Observers:IDMCollection;
  OperationManager:IDMOperationManager;
begin
  SelfE:=Self as IDMElement;
  DataModelE:=DataModel as IDMElement;
  OperationManager:=DataModel.Document as IDMOperationManager;
  Observers:=DataModelE.Collection[_Observer];
  while FObservers.Count>0 do begin
    aElement:=FObservers.Item[0];
    OperationManager.DeleteElement(nil, Observers, ltOneToMany, aElement);
  end;

  if Ref=nil then Exit;
  if Parent=nil then Exit;

  FacilityModel:=DataModel as IFacilityModel;
  SeparatingAreas2:=FSeparatingAreas as IDMCollection2;

  if SpatialElement=nil then begin
    if (Parent.Parent<>nil) and
       (Parent.Parent.ClassID=_Boundary) then begin
      Boundary:=Parent.Parent as IBoundary;
      OperationManager.AddElementRef(Boundary, Observers, '',
                                 SelfE, ltOneToMany, ObserverU, True);
      Exit;
    end else begin
      ZoneE:=Parent;
      Volume:=ZoneE.SpatialElement as IVolume;
      if Volume=nil then Exit;
      if Volume.BottomAreas.Count>0 then
        Area:=Volume.BottomAreas.Item[0] as IArea
      else
      if Volume.TopAreas.Count>0 then
        Area:=Volume.TopAreas.Item[0] as IArea
      else
        Exit;
      Area.GetCentralPoint(X0, Y0, Z0);
      Z0:=Z0+Get_Elevation;
    end;
  end else begin
    if SpatialElement.QueryInterface(ICoordNode, Node)<>0 then
      Node:=(SpatialElement as ILine).C0;
    if Node=nil then Exit;
    X0:=Node.X;
    Y0:=Node.Y;
    Z0:=Node.Z+Get_Elevation;
  end;

  VolumeE:=Parent.SpatialElement;
  if VolumeE=nil then Exit;

  VolumeList:=TList.Create;
  PrevAreaList:=TList.Create;
  AreaList:=TList.Create;
  try
    VolumeList.Add(pointer(VolumeE));
    PrevAreaList.Add(nil);
    j:=0;
    while j<VolumeList.Count do begin
      aVolumeE:=IDMElement(VolumeList[j]);
      aPrevAreaE:=IDMElement(PrevAreaList[j]);
      TreatVolume(aVolumeE, aPrevAreaE, X0, Y0, Z0,
                  VolumeList, PrevAreaList, AreaList);
      inc(j);
    end;
  finally
    VolumeList.Free;
    PrevAreaList.Free;
    AreaList.Free;
  end;
end;

procedure TDistantDetectionElement.AfterLoading2;
begin
  inherited;
  if DataModel.ApplicationVersion<'2.5.0' then
    UpdateObservers;
end;

function TDistantDetectionElement.DoCalcDetectionProbability(
  const TacticU: IInterface; const OvercomeMethodE: IDMElement;
  DelayTime: double; var DetP0, DetPf, WorkP: double;
  CalcAll:WordBool): double;
var
  DetP:double;
  OvercomeMethod:IOvercomeMethod;
begin
  DetP:=inherited DoCalcDetectionProbability(TacticU, OvercomeMethodE,
                         DelayTime, DetP0, DetPf, WorkP, CalcAll);
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  if OvercomeMethod.ObserverParam then
    Result:=GetDistantDetection(OvercomeMethodE, DetP, DelayTime)
  else
    Result:=DetP
end;

function TDistantDetectionElement.GetElevation: double;
begin
  Result:=Get_Elevation
end;

function TDistantDetectionElement.Get_IsSelectable: WordBool;
begin
  Result:=FShowDetectionZone
end;

procedure TDistantDetectionElement.Rotate(X0, Y0, cosA, sinA: double);
var
  dA, A:double;
  SMDocument:ISMDocument;
  PainterU:IUnknown;
  DMOperationManager:IDMOperationManager;
begin
  if SpatialElement=nil then begin
    SMDocument:=DataModel.Document as  ISMDocument;
    DMOperationManager:=SMDocument as IDMOperationManager;
    PainterU:=SMDocument.PainterU;

    Draw(PainterU, -1);
    dA:=arccos(cosA)*180/Pi;
    if sinA>0 then
      dA:=-dA;
    A:=FRotationAngle+dA;
    DMOperationManager.ChangeFieldValue(Self as IDMElement,
                       ord(constRotationAngle), True, A);
    if Selected then
      Draw(PainterU, 1)
    else
      Draw(PainterU, 0)
  end;
end;

function TDistantDetectionElement.GetRotationAngle: double;
begin
  Result:=FRotationAngle
end;

procedure TDistantDetectionElement.UpdateCoords;
var
  Line:ILine;
  C0, C1:ICoord;
  WX0,WY0,WX1,WY1,L, cosZ:double;
begin
  inherited;
  if (SpatialElement<>nil) and
     (SpatialElement.QueryInterface(ILine, Line)=0) then begin
    C0:=Line.C0;
    C1:=Line.C1;
    WX0:=C0.X;
    WY0:=C0.Y;
    WX1:=C1.X;
    WY1:=C1.Y;
    L:=sqrt(sqr(WX1-WX0)+sqr(WY1-WY0));
    FMaxDistance:=L*0.01;
    if L=0 then Exit;
    cosZ:=(WX1-WX0)/L;
    FRotationAngle:=arccos(cosZ)*180/Pi;
    if WY1>WY0 then
      FRotationAngle:=-FRotationAngle;
  end;
end;

class procedure TDistantDetectionElement.MakeFields0;
begin
  inherited;
  AddField(rsRotationAngle, '%4.0f', '', '',
           fvtFloat, 0, 0, 0,
           ord(constRotationAngle), 0, pkInput);
  AddField(rsMaxDistance, '%0.0f', '', '',
           fvtFloat, 0, 0, 0,
           ord(constMaxDistance), 0, pkInput);
end;

procedure TDistantDetectionElement._AddBackRef(const aElement: IDMElement);
var
  j:integer;
  Unk:IUnknown;
begin
  if aElement.QueryInterface(IObserver, Unk)=0 then begin
    j:=FObservers.IndexOf(aElement);
    if j=-1 then
      (FObservers as IDMCollection2).Add(aElement)
  end else
    inherited
end;

procedure TDistantDetectionElement._RemoveBackRef(
  const aElement: IDMElement);
var
  j:integer;
  Unk:IUnknown;
begin
  if aElement.QueryInterface(IObserver, Unk)=0 then begin
    j:=FObservers.IndexOf(aElement);
    if j<>-1 then
      (FObservers as IDMCollection2).Delete(j)
  end else
    inherited
end;

function TDistantDetectionElement.Get_Collection(
  Index: Integer): IDMCollection;
begin
  case Index of
  ord(ddcObservers):
    Result:=FObservers;
  ord(ddcCabels):
    Result:=FConnections;
  else
    Result:=inherited Get_Collection(Index);
  end
end;

function TDistantDetectionElement.Get_CollectionCount: integer;
begin
  Result:=ord(High(TDistantDetectionCategory)) + 1
end;

procedure TDistantDetectionElement.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited ;
  case Index of
  ord(ddcObservers):
    begin
      aCollectionName:='Объекты, находящиеся под наблюдением';
      aOperations:=0;
      aLinkType:=ltBackRefs;
    end;
  end
end;

function TDistantDetectionElement.GetObservationKind(
  Distance: double): integer;
begin
  Result:=0;
end;

function TDistantDetectionElement.Get_Observers:IDMCollection;
begin
  Result:=FObservers
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TDistantDetectionElement.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
