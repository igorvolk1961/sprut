unit SafeguardClassU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TSafeguardClass=class(TNamedDMElement, ISafeguardClass)
  private
    FParents:IDMCollection;

    FTypeClassID:integer;
    FSpatialElementKind:integer;
    FOptionalSpatialElement:boolean;

  protected
// методы интерфейса IDMElement
    function  Get_Name: WideString; override; safecall;
    function  Get_Parents:IDMCollection; override; safecall;
    function  Get_CollectionCount: integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function  Get_BuildIn:WordBool; override; safecall;
    procedure Loaded; override; safecall;

// методы интерфейса ISafeguardClass
    function  Get_TypeClassID: integer; safecall;
    function  Get_SpatialElementKind:integer; safecall;
    procedure Set_SpatialElementKind(Value:integer); safecall;
    procedure Set_TypeClassID(Value: integer); safecall;
    function Get_OptionalSpatialElement: WordBool; safecall;
    procedure Set_OptionalSpatialElement(Value: WordBool); safecall;
    function  CreateCollection: IDMCollection; safecall;


    property TypeClassID: Integer read Get_TypeClassID write Set_TypeClassID;

// метода класса
    class function GetClassID:integer; override;
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TSafeguardClasses=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation
uses
  SafeguardDatabaseConstU,
  GuardPostTypeU, BarrierTypeU, LockTypeU,
  UndergroundObstacleTypeU, GroundObstacleTypeU, FenceObstacleTypeU,
  SurfaceSensorTypeU,
  PositionSensorTypeU, ContrabandSensorTypeU, AccessControlTypeU,
  VolumeSensorTypeU, BarrierSensorTypeU, TVCameraTypeU, LightDeviceTypeU,
  CommunicationDeviceTypeU, ControlDeviceTypeU, PowerSourceTypeU, CabelTypeU, JumpTypeU,
  LocalPointObjectTypeU, TargetTypeU, StartPointTypeU,
  ActiveSafeguardTypeU, PerimeterSensorTypeU;

{ TSafeguardClass }

procedure  TSafeguardClass.Initialize;
begin
  inherited;
  FParents:=TDMCollection.Create((DataModel as IDMElement).DataModel as IDMElement) as IDMCollection;
end;

procedure TSafeguardClass._Destroy;
begin
  inherited;
  FParents:=nil;
end;

class function TSafeguardClass.GetClassID: integer;
begin
  Result:=0;
end;

function TSafeguardClass.Get_Name: WideString;
begin
  if FTypeClassID<>-1 then
    Result:=((DataModel as IDMElement).DataModel as IDMElement).Collection[FTypeClassID].ClassAlias[akImenit]
  else
    Result:=''
end;

function TSafeguardClass.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

function TSafeguardClass.Get_CollectionCount: integer;
begin
  Result:=0;
end;

function TSafeguardClass.Get_BuildIn:WordBool;
begin
  Result:=True;
end;

procedure TSafeguardClass.Loaded;
begin
end;

function TSafeguardClass.Get_TypeClassID: integer;
begin
  Result:=FTypeClassID
end;

procedure TSafeguardClass.Set_TypeClassID(Value: integer);
begin
  FTypeClassID:=Value
end;

function TSafeguardClass.Get_Collection(Index: Integer): IDMCollection;
begin
    Result:=inherited Get_Collection(Index)
end;

procedure TSafeguardClass.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
    inherited
end;

function TSafeguardClass.CreateCollection: IDMCollection;
var
  aParent:IDMElement;
begin
  aParent:=(DataModel as IDMElement).DataModel as IDMElement;
  case FTypeClassID of
  _GuardPostType: Result:=TGuardPostTypes.Create(aParent) as IDMCollection;
  _BarrierType: Result:=TBarrierTypes.Create(aParent) as IDMCollection;
  _LockType: Result:=TLockTypes.Create(aParent) as IDMCollection;
  _UndergroundObstacleType: Result:=TUndergroundObstacleTypes.Create(aParent) as IDMCollection;
  _SurfaceSensorType: Result:=TSurfaceSensorTypes.Create(aParent) as IDMCollection;
  _PositionSensorType: Result:=TPositionSensorTypes.Create(aParent) as IDMCollection;
  _ContrabandSensorType: Result:=TContrabandSensorTypes.Create(aParent) as IDMCollection;
  _AccessControlType: Result:=TAccessControlTypes.Create(aParent) as IDMCollection;
  _VolumeSensorType: Result:=TVolumeSensorTypes.Create(aParent) as IDMCollection;
  _BarrierSensorType: Result:=TBarrierSensorTypes.Create(aParent) as IDMCollection;
  _TVCameraType: Result:=TTVCameraTypes.Create(aParent) as IDMCollection;
  _LightDeviceType: Result:=TLightDeviceTypes.Create(aParent) as IDMCollection;
  _CommunicationDeviceType: Result:=TCommunicationDeviceTypes.Create(aParent) as IDMCollection;
  _ControlDeviceType: Result:=TControlDeviceTypes.Create(aParent) as IDMCollection;
  _PowerSourceType: Result:=TPowerSourceTypes.Create(aParent) as IDMCollection;
  _CabelType: Result:=TCabelTypes.Create(aParent) as IDMCollection;
  _JumpType: Result:=TJumpTypes.Create(aParent) as IDMCollection;
  _LocalPointObjectType: Result:=TLocalPointObjectTypes.Create(aParent) as IDMCollection;
  _TargetType: Result:=TTargetTypes.Create(aParent) as IDMCollection;
  _StartPointType: Result:=TStartPointTypes.Create(aParent) as IDMCollection;
  _ActiveSafeguardType: Result:=TActiveSafeguardTypes.Create(aParent) as IDMCollection;
  _PerimeterSensorType: Result:=TPerimeterSensorTypes.Create(aParent) as IDMCollection;
  _GroundObstacleType: Result:=TGroundObstacleTypes.Create(aParent) as IDMCollection;
  _FenceObstacleType: Result:=TFenceObstacleTypes.Create(aParent) as IDMCollection;
  else
    Result:=nil
  end;
end;

{ TSafeguardClasss }

function TSafeguardClasses.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSafeguardClass;
end;

class function TSafeguardClasses.GetElementClass: TDMElementClass;
begin
  Result:=TSafeguardClass;
end;

class function TSafeguardClasses.GetElementGUID:TGUID;
begin
  Result:=IID_ISafeguardClass;
end;

function TSafeguardClass.Get_SpatialElementKind: integer;
begin
  Result:=FSpatialElementKind
end;

procedure TSafeguardClass.Set_SpatialElementKind(Value: integer);
begin
  FSpatialElementKind:=Value
end;

function TSafeguardClass.Get_OptionalSpatialElement: WordBool;
begin
  Result:=FOptionalSpatialElement
end;

procedure TSafeguardClass.Set_OptionalSpatialElement(Value: WordBool);
begin
  FOptionalSpatialElement:=Value
end;

end.
