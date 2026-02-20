unit PerimeterSensorU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SensorU;

const
  PathHeight=100;
  ShoulderWidth=101;

type
  TPerimeterSensor=class(TSensor, IPerimeterSensor, IDistantDetectionElement)
  private
    FSensorDepth:double;
    FZoneWidth:double;
    function CalcVolumeDetectionFlag:integer;
  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;

    function Get_SensorDepth:double; safecall;
    function Get_ZoneWidth:double; safecall;
    function  GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double; safecall;
    function  PointInDetectionZone(X, Y, Z: Double; const CRef, ExcludeAreaE:IDMElement): WordBool; safecall;
    function Get_Observers:IDMCollection; safecall;

    procedure Set_Ref(const Value:IDMElement); override; safecall;
    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure AfterLoading2; override; safecall;
    function Get_BackRefs:IDMCollection; safecall;
    function DoCalcDetectionProbability(const TacticU:IUnknown;
                          const OvercomeMethodE:IDMElement;
                          DelayTime:double;
                          var DetP0, DetPf, WorkP:double;
                          CalcAll:WordBool):double; override; safecall;
    procedure Initialize; override;
    procedure _Destroy; override;
    function  ShowInLayerName: WordBool; override; safecall; safecall;
  end;

  TPerimeterSensors=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU, Geometry;

var
  FFields:IDMCollection;

{ TPerimeterSensor }

class function TPerimeterSensor.GetClassID: integer;
begin
  Result:=_PerimeterSensor;
end;

class function TPerimeterSensor.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TPerimeterSensor.MakeFields0;
begin
  inherited;
  AddField(rsElevation, '%6.2f', '', 'd',
                 fvtFloat, 0, 0, InfinitValue,
                 ord(pspElevation), 0, pkInput);
  AddField(rsSensorDepth, '%6.2f', '', '',
                 fvtFloat, 0, 0, InfinitValue,
                 ord(pspSensorDepth), 0, pkInput);
  AddField(rsZoneHalfWidth, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(pspZoneWidth), 0, pkInput);
end;

function TPerimeterSensor.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(pspElevation):
    Result:=FElevation;
  ord(pspSensorDepth):
    Result:=FSensorDepth;
  ord(pspZoneWidth):
    Result:=FZoneWidth;
  else
    Result:= inherited GetFieldValue(Code);
  end;
end;

procedure TPerimeterSensor.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(pspElevation):
    FElevation:=Value;
  ord(pspSensorDepth):
    FSensorDepth:=Value;
  ord(pspZoneWidth):
    FZoneWidth:=Value;
  else
    inherited;
  end;
end;

function TPerimeterSensor.Get_SensorDepth: double;
begin
  Result:=FSensorDepth
end;

function TPerimeterSensor.Get_ZoneWidth: double;
begin
  Result:=FZoneWidth
end;

procedure TPerimeterSensor.Set_Ref(const Value: IDMElement);
begin
  inherited;
  if Value=nil then Exit;
  FZoneWidth:=(Value as IPerimeterSensorKind).ZoneWidth
end;

function TPerimeterSensor.GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double;
var
  Flag:integer;
begin
  Result:=0;

  Flag:=CalcVolumeDetectionFlag;
  if Flag=0 then Exit;

  case Flag of
  vdfFull:Result:=DetP;
  vdfSqrt:Result:=1-sqrt(1-DetP);
  else    Result:=0;
  end;
end;

function TPerimeterSensor.PointInDetectionZone(X, Y, Z: Double; const CRef, ExcludeAreaE:IDMElement): WordBool;
var
  Area:IArea;
  C0, C1:ICoordNode;
  P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX0, WY0, WZ0, D:double;
begin
//  Result:= inherited PointInDetectionZone(X, Y, Z, CRef);
//  if not Result then Exit;

  Result:=False;

  if Parent.Parent.ClassID=_Boundary then
    Area:=Parent.Parent.SpatialElement as IArea
  else
    Exit;
  if Area=nil then begin
    Result:=True;
    Exit;
  end else
  if Area.IsVertical then begin
    if Z<Area.MinZ then Exit;
    if Z>Area.MaxZ then Exit;
    C0:=Area.C0;
    C1:=Area.C1;
    P0X:=C0.X;
    P0Y:=C0.Y;
    P0Z:=C0.Z;
    P1X:=C1.X;
    P1Y:=C1.Y;
    P1Z:=C1.Z;
    PerpendicularFrom(P0X, P0Y, P0Z, P1X, P1Y, P1Z, X, Y, Z, WX0, WY0, WZ0);
    if ((WX0-P0X)*(WX0-P1X)<=0) and
       ((WY0-P0Y)*(WY0-P1Y)<=0) and
       ((WZ0-P0Z)*(WZ0-P1Z)<=0) then begin
      D:=sqrt(sqr(X-WX0)+sqr(Y-WY0)+sqr(Z-WZ0));

      if FZoneWidth*100+ShoulderWidth<D then Exit;
    end else
      Exit
  end else
    if Z-PathHeight>Area.MaxZ then Exit;
  Result:=True;
end;

function TPerimeterSensor.CalcVolumeDetectionFlag: integer;
var
  L:double;
  C0, C1:ICoordNode;
  Line:ILine;
  C0X, C0Y, C0Z, C1X, C1Y, C1Z, CX, CY, CZ:double;
  F:boolean;
  C0E, C1E:IDMElement;
  FacilityModelS:IFMState;
  WarriorGroup:IWarriorGroup;
  LineE:IDMElement;
  PathArcKind:integer;
begin
  Result:=vdfFull;
  FacilityModelS:=DataModel as IFMState;
  Line:=FacilityModelS.CurrentLineU as ILine;
  if Line=nil then Exit;
  LineE:=Line as IDMElement;
  PathArcKind:=FacilityModelS.CurrentPathArcKind;

  case PathArcKind of
  pakVBoundary,
  pakHLineObject,
  pakVLineObject,
  pakVBoundary_,
  pakRoad:
    Exit;
  end;

  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;

  L:=Line.Length;

  if (LineE.Ref<>nil) and
     (LineE.Ref<>Parent.Parent) and
     (L<=2*FZoneWidth*100) then begin
    Result:=vdfNoDetection;  // чтобы не было повторного обнаружения
    Exit;                    // сразу после преодоления рубежа
  end;

  C0:=Line.C0;
  C1:=Line.C1;
  C0E:=C0 as IDMElement;
  C1E:=C1 as IDMElement;

  C0X:=C0.X;
  C0Y:=C0.Y;
  C0Z:=C0.Z;
  C1X:=C1.X;
  C1Y:=C1.Y;
  C1Z:=C1.Z;
  CX:=0.5*(C0X+C1X);
  CY:=0.5*(C0Y+C1Y);
  CZ:=0.5*(C0Z+C1Z);
  F:=PointInDetectionZone(CX, CY, CZ, nil, nil);

  if F then
    Result:=vdfFull
  else
    Result:=vdfNoDetection;
end;

procedure TPerimeterSensor.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
begin
  inherited;

end;

procedure TPerimeterSensor._Destroy;
begin
  inherited;
end;

procedure TPerimeterSensor.Initialize;
begin
  inherited;
end;

procedure TPerimeterSensor.Set_Parent(const Value: IDMElement);
begin
  inherited;
end;

procedure TPerimeterSensor.AfterLoading2;
begin
  inherited;
end;

function TPerimeterSensor.Get_BackRefs: IDMCollection;
begin
  Result:=nil
end;

function TPerimeterSensor.ShowInLayerName: WordBool;
begin
  Result:=True
end;

function TPerimeterSensor.DoCalcDetectionProbability(
  const TacticU: IInterface; const OvercomeMethodE: IDMElement;
  DelayTime: double; var DetP0, DetPf, WorkP: double; CalcAll:WordBool): double;
var
  DetP:double;
  OvercomeMethod:IOvercomeMethod;
  LineE:IDMElement;
  FacilityModelS:IFMState;
begin
  DetP:=inherited DoCalcDetectionProbability(TacticU, OvercomeMethodE,
                         DelayTime, DetP0, DetPf, WorkP, CalcAll);
  Result:=DetP;
  
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  FacilityModelS:=DataModel as IFMState;
  LineE:=FacilityModelS.CurrentLineU as IDMElement;
  if LineE=nil then Exit;
  if LineE.Ref=nil then Exit;
//  if LineE.Ref.ClassID<>_Boundary then Exit;

  if OvercomeMethod.ObserverParam then
    Result:=GetDistantDetection(OvercomeMethodE, DetP, DelayTime)
end;

function TPerimeterSensor.Get_Observers: IDMCollection;
begin
  Result:=nil
end;

{ TPerimeterSensors }

class function TPerimeterSensors.GetElementClass: TDMElementClass;
begin
  Result:=TPerimeterSensor;
end;

function TPerimeterSensors.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsPerimeterSensor;
end;

class function TPerimeterSensors.GetElementGUID: TGUID;
begin
  Result:=IID_IPerimeterSensor;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TPerimeterSensor.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
