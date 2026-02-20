unit SafeguardDatabaseU;

interface

uses
  DM_Windows, DM_ComObj,
  Classes, SysUtils,
  SgdbLib_TLB, StdVcl,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DataClassModelU, CustomSpatialModelU;

type
  TSafeguardDatabase = class(TCustomSpatialModel, ISafeguardDatabase, IDMClassCollections)
  private
    FDataClassModel:IDataModel;
    FCalcLibraries:TStringList;
    FSphearSectorImage:IDMElement;
    FUserDefinedValueMethod:IDMElement;

    FClassCollectionIndexes:TList;
    FSpecialZoneKinds:IDMCollection;

    function Get_UpdateTypes: IDMCollection;

  protected
// методы IDataModel
    function  Get_RootObjectCount(Mode: Integer):integer; override; safecall;
    procedure GetRootObject(Mode, RootIndex: Integer; out RootObject: IUnknown;
                            out RootObjectName: WideString; out aOperations: Integer;
                            out aLinkType: Integer); override; safecall;
    function Get_SubModel(Index: integer): IDataModel; override; safecall;
    procedure AfterLoading2; override; safecall;
    function GetDefaultParent(ClassID:integer): IDMElement; override; safecall;


    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
// методы ISafeguardDatabase

//  защищенные методы
    procedure MakeCollections; override;

    procedure Clear; override; safecall;

    procedure LoadCalcLibraries;

    procedure SaveToDatabase(const aDataBaseU: IUnknown); override;
    procedure LoadFromDataBase(const aDataBaseU: IUnknown); override;
    procedure LoadedFromDataBase(const aDataBaseU: IUnknown); override;
    function Get_SGDBParameters: IDMCollection; safecall;
    function Get_SGDBParameterValues: IDMCollection; safecall;
    function Get_DataClassModel: IDataModel; safecall;
    function Get_BoundaryKinds: IDMCollection; safecall;
    function Get_BoundaryLayerTypes: IDMCollection; safecall;
    function Get_BoundaryTypes: IDMCollection; safecall;
    function Get_ZoneKinds: IDMCollection; safecall;
    function Get_ZoneTypes: IDMCollection; safecall;
    function Get_CabelTypes: IDMCollection; safecall;
    function Get_SkillTypes: IDMCollection; safecall;
    function Get_BattleSkills: IDMCollection; safecall;
    function Get_Tactics: IDMCollection; safecall;
    function Get_ToolKinds: IDMCollection; safecall;
    function Get_VehicleKinds: IDMCollection; safecall;
    function Get_WeaponKinds: IDMCollection; safecall;
    function Get_AthorityTypes: IDMCollection; safecall;
    function Get_StartPointKinds: IDMCollection; safecall;
    function Get_Updating: IDMCollection; safecall;
    function Get_SpecialZoneKinds: IDMCollection; safecall;

// методы ISpatialModel

    procedure Set_CurrentLayer(const Value: ILayer); override; safecall;
    function  Get_Layers: IDMCollection; override; safecall;
    function  Get_CoordNodes: IDMCollection;  override; safecall;
    function  Get_Lines: IDMCollection;  override; safecall;
    function  Get_CurvedLines: IDMCollection;  override; safecall;
    function  Get_Polylines: IDMCollection;  override; safecall;
    function  Get_Areas: IDMCollection;  override; safecall;
    function  Get_Volumes: IDMCollection;  override; safecall;
    function  Get_ImageRects: IDMCollection;  override; safecall;
    function  Get_Views: IDMCollection;  override; safecall;
    function  Get_Fonts: IDMCollection;  override; safecall;

    function Get_MethodArrayValues: IDMCollection; safecall;
    function Get_SphearSectorImage: IDMElement; safecall;
    function Get_CommunicationDeviceTypes: IDMCollection; safecall;
    function Get_JumpKinds: IDMCollection; safecall;
//IDMCollection
    function Get_ClassCount(Mode: Integer): Integer; safecall;
    function Get_ClassCollection(Index: Integer; Mode: Integer): IDMCollection; safecall;
    function Get_DefaultClassCollectionIndex(Index: Integer; Mode: Integer): Integer; safecall;
    procedure Set_DefaultClassCollectionIndex(Index: Integer; Mode: Integer; Value: Integer); safecall;
    property ClassCount[Mode: Integer]: Integer read Get_ClassCount;
    property ClassCollection[Index: Integer; Mode: Integer]: IDMCollection read Get_ClassCollection;
    property DefaultClassCollectionIndex[Index: Integer; Mode: Integer]: Integer read Get_DefaultClassCollectionIndex write Set_DefaultClassCollectionIndex;
    function Get_UserDefinedValueMethod: IDMElement; safecall;

    function KeepHash:boolean; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  ZoneTypeU, ZoneKindU, BoundaryTypeU, BoundaryKindU,
  BoundaryLayerTypeU, BarrierTypeU, BarrierKindU,
  LockTypeU, LockKindU,
  UndergroundObstacleTypeU, UndergroundObstacleKindU,
  GroundObstacleTypeU, GroundObstacleKindU,
  FenceObstacleTypeU, FenceObstacleKindU,
  SurfaceSensorTypeU,
  SurfaceSensorKindU, PositionSensorTypeU, PositionSensorKindU, VolumeSensorTypeU,
  VolumeSensorKindU, BarrierSensorTypeU, BarrierSensorKindU, ContrabandSensorTypeU,
  ContrabandSensorKindU, AccessControlTypeU, AccessControlKindU, TVCameraTypeU,
  TVCameraKindU, LightDeviceTypeU, LightDeviceKindU, CommunicationDeviceTypeU,
  CommunicationDeviceKindU, PowerSourceTypeU, PowerSourceKindU, CabelTypeU,
  CabelKindU, GuardPostTypeU, GuardPostKindU,
  TargetTypeU, TargetKindU,
  ControlDeviceTypeU, ControlDeviceKindU,
  ConveyanceTypeU, ConveyanceKindU, ConveyanceSegmentTypeU, ConveyanceSegmentKindU,
  JumpTypeU, JumpKindU,
  LocalPointObjectTypeU, LocalPointObjectKindU,
  GuardCharacteristicTypeU, GuardCharacteristicKindU, OvercomeMethodU,
  WeaponTypeU, WeaponKindU, ToolTypeU, ToolKindU, VehicleTypeU, VehicleKindU,
  AthorityTypeU, SkillTypeU, PhysicalFieldU,
  DeviceFunctionU, DeviceStateU, HindranceU, WeatherU,
  SGDBParameterU, SGDBParameterValueU, ShotDispersionRecU, ShotBreachRecU,
  ElementImageU, StartPointTypeU, StartPointKindU,
  ActiveSafeguardTypeU, ActiveSafeguardKindU,
  PerimeterSensorTypeU, PerimeterSensorKindU,
  SGCoordNodeU, SGLineU, SGCurvedLineU, SGPolylineU,
  SGAreaU, SGVolumeU, SGViewU, SGImageRectU, TacticU,
  MethodDimensionU, MethodArrayValueU, MethodDimItemU,
  BattleSkillU, UpdatingU, TextureU, ElementParameterU;

{ TSafeguardDatabase }

function TSafeguardDatabase.Get_RootObjectCount(Mode:integer): Integer;
begin
  case abs(Mode) of
  1: Result:=35;
  else
     Result:=inherited Get_RootObjectCount(Mode);
  end;
end;

procedure TSafeguardDatabase.GetRootObject(Mode, RootIndex: Integer;
  out RootObject: IUnknown; out RootObjectName: WideString;
  out aOperations, aLinkType: Integer);
var
  aRefSource:IDMCollection;
  aClassCollections:IDMClassCollections;
begin
  case abs(Mode) of
  1:
    case RootIndex of
    0:begin
        GetCollectionProperties(_ZoneType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_ZoneType];
      end;
    1:begin
        GetCollectionProperties(_BoundaryType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_BoundaryType];
      end;
    2:begin
        GetCollectionProperties(_JumpType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_JumpType];
      end;
    3:begin
        GetCollectionProperties(_Tactic,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_Tactic];
       end;
    4:begin
        GetCollectionProperties(_OvercomeMethod,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_OvercomeMethod];
      end;
    5:begin
        GetCollectionProperties(_BarrierType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_BarrierType];
      end;
    6:begin
        GetCollectionProperties(_LockType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_LockType];
      end;
    7:begin
        GetCollectionProperties(_FenceObstacleType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_FenceObstacleType];
      end;
    8:begin
        GetCollectionProperties(_UndergroundObstacleType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_UndergroundObstacleType];
      end;
    9:begin
        GetCollectionProperties(_GroundObstacleType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_GroundObstacleType];
      end;
    10:begin
        GetCollectionProperties(_ActiveSafeguardType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_ActiveSafeguardType];
      end;
    11:begin
        GetCollectionProperties(_PositionSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_PositionSensorType];
      end;
    12:begin
        GetCollectionProperties(_SurfaceSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_SurfaceSensorType];
      end;
    13:begin
        GetCollectionProperties(_VolumeSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_VolumeSensorType];
      end;
    14:begin
        GetCollectionProperties(_PerimeterSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_PerimeterSensorType];
      end;
    15:begin
        GetCollectionProperties(_ContrabandSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_ContrabandSensorType];
      end;
    16:begin
        GetCollectionProperties(_AccessControlType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_AccessControlType];
      end;
    17:begin
        GetCollectionProperties(_TVCameraType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_TVCameraType];
      end;
    18:begin
        GetCollectionProperties(_LightDeviceType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_LightDeviceType];
      end;
    19:begin
        GetCollectionProperties(_TargetType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_TargetType];
      end;
    20:begin
        GetCollectionProperties(_GuardPostType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_GuardPostType];
      end;
    21:begin
        GetCollectionProperties(_CommunicationDeviceType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_CommunicationDeviceType];
      end;
    22:begin
        GetCollectionProperties(_ControlDeviceType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_ControlDeviceType];
      end;
    23:begin
        GetCollectionProperties(_CabelType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_CabelType];
      end;
    24:begin
        GetCollectionProperties(_StartPointType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_StartPointType];
      end;
    25:begin
        GetCollectionProperties(_WeaponType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_WeaponType];
      end;
    26:begin
        GetCollectionProperties(_ToolType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_ToolType];
      end;
    27:begin
        GetCollectionProperties(_VehicleType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_VehicleType];
      end;
    28:begin
        GetCollectionProperties(_AthorityType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_AthorityType];
      end;
    29:begin
        GetCollectionProperties(_SkillType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_SkillType];
      end;
    30:begin
        GetCollectionProperties(_BattleSkill,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_BattleSkill];
       end;
    31:begin
        GetCollectionProperties(_PhysicalField,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_PhysicalField];
      end;
    32:begin
        GetCollectionProperties(_ElementImage,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_ElementImage];
       end;
    33:begin
        GetCollectionProperties(_Texture,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_Texture];
       end;
    34:begin
        GetCollectionProperties(_Updating,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_Updating];
       end;
    end;


  2:
    case RootIndex of
    0:begin
        GetCollectionProperties(_BarrierType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_BarrierType];
      end;
    1:begin
        GetCollectionProperties(_LockType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_LockType];
      end;
    2:begin
        GetCollectionProperties(_PositionSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_PositionSensorType];
      end;
    3:begin
        GetCollectionProperties(_SurfaceSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_SurfaceSensorType];
      end;
    4:begin
        GetCollectionProperties(_VolumeSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_VolumeSensorType];
      end;
    5:begin
        GetCollectionProperties(_PerimeterSensorType,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_PerimeterSensorType];
      end;
    end;
  else
    inherited;
  end;
end;

procedure TSafeguardDatabase.MakeCollections;
var
  aParent:IDMElement;
begin
  inherited;
  aParent:=Self as IDMElement;

  AddClass(TZoneTypes);
  AddClass(TZoneKinds);
  AddClass(TBoundaryTypes);
  AddClass(TBoundaryKinds);
  AddClass(TBoundaryLayerTypes);
  AddClass(TBarrierTypes);
  AddClass(TBarrierKinds);
  AddClass(TLockTypes);
  AddClass(TLockKinds);
  AddClass(TUndergroundObstacleTypes);
  AddClass(TUndergroundObstacleKinds);
  AddClass(TGroundObstacleTypes);
  AddClass(TGroundObstacleKinds);
  AddClass(TFenceObstacleTypes);
  AddClass(TFenceObstacleKinds);
  AddClass(TSurfaceSensorTypes);
  AddClass(TSurfaceSensorKinds);
  AddClass(TPositionSensorTypes);
  AddClass(TPositionSensorKinds);
  AddClass(TVolumeSensorTypes);
  AddClass(TVolumeSensorKinds);
  AddClass(TBarrierSensorTypes);
  AddClass(TBarrierSensorKinds);
  AddClass(TContrabandSensorTypes);
  AddClass(TContrabandSensorKinds);
  AddClass(TAccessControlTypes);
  AddClass(TAccessControlKinds);
  AddClass(TTVCameraTypes);
  AddClass(TTVCameraKinds);
  AddClass(TLightDeviceTypes);
  AddClass(TLightDeviceKinds);
  AddClass(TCommunicationDeviceTypes);
  AddClass(TCommunicationDeviceKinds);
  AddClass(TControlDeviceTypes);
  AddClass(TControlDeviceKinds);
  AddClass(TPowerSourceTypes);
  AddClass(TPowerSourceKinds);
  AddClass(TCabelTypes);
  AddClass(TCabelKinds);
  AddClass(TGuardPostTypes);
  AddClass(TGuardPostKinds);
  AddClass(TTargetTypes);
  AddClass(TTargetKinds);
  AddClass(TConveyanceTypes);
  AddClass(TConveyanceKinds);
  AddClass(TConveyanceSegmentTypes);
  AddClass(TConveyanceSegmentKinds);
  AddClass(TJumpTypes);
  AddClass(TJumpKinds);
  AddClass(TLocalPointObjectTypes);
  AddClass(TLocalPointObjectKinds);
  AddClass(TBattleSkills);
  AddClass(TGuardCharacteristicTypes);
  AddClass(TGuardCharacteristicKinds);
  AddClass(TOvercomeMethods);
  AddClass(TWeaponTypes);
  AddClass(TWeaponKinds);
  AddClass(TToolTypes);
  AddClass(TToolKinds);
  AddClass(TVehicleTypes);
  AddClass(TVehicleKinds);
  AddClass(TAthorityTypes);
  AddClass(TSkillTypes);
  AddClass(TPhysicalFields);
  AddClass(TDeviceFunctions);
  AddClass(TDeviceStates);
  AddClass(THindrances);
  AddClass(TWeathers);
  AddClass(TSGDBParameters);
  AddClass(TSGDBParameterValues);
  AddClass(TShotDispersionRecs);
  AddClass(TElementImages);
  AddClass(TStartPointTypes);
  AddClass(TStartPointKinds);
  AddClass(TActiveSafeguardTypes);
  AddClass(TActiveSafeguardKinds);
  AddClass(TPerimeterSensorTypes);
  AddClass(TPerimeterSensorKinds);
  AddClass(TSGCoordNodes);
  AddClass(TSGLines);
  AddClass(TSGCurvedLines);
  AddClass(TSGPolyLines);
  AddClass(TSGAreas);
  AddClass(TSGVolumes);
  AddClass(TSGViews);
  AddClass(TSGImageRects);
  AddClass(TTactics);
  AddClass(TMethodDimensions);
  AddClass(TMethodArrayValues);
  AddClass(TMethodDimItems);
  AddClass(TUpdatings);
  AddClass(TTextures);
  AddClass(TElementParameters);
  AddClass(TShotBreachRecs);
end;

procedure TSafeguardDatabase.Initialize;
begin

  inherited;

  FCalcLibraries:=TStringList.Create;
//  FElementImageScalingTypes:=TElementImageScalingTypes.Create(Self);
  FDataClassModel:=TDataClassModel.Create(Self) as IDataModel;

  ID:=2;
  DecimalSeparator:='.';

  FClassCollectionIndexes:=TList.Create;
  FSpecialZoneKinds:=CreateCollection(-1, nil);
  FRenderAreasMode:=1;
end;

procedure TSafeguardDatabase.Clear;
var
  j, Handle:integer;
  p:pointer;
begin
  inherited;
  for j:=0 to FCalcLibraries.Count-1 do begin
    p:=pointer(FCalcLibraries.Objects[j]);
    Handle:=integer(p);
    DM_FreeLibrary(Handle);
  end;
  FCalcLibraries.Clear;
end;

procedure TSafeguardDatabase.LoadCalcLibraries;

  function LoadCalcLibrary(const S:string):integer;
  var
    j:integer;
    p:pointer;
    LibName:array[0..255] of Char;
  begin
    j:=FCalcLibraries.IndexOf(S);
    if j=-1 then begin
      StrPCopy(LibName, S+'.dll');
      Result:=DM_LoadLibrary(LibName);
      if Result<>0 then begin
        p:=pointer(Result);
        FCalcLibraries.AddObject(S, p);
      end;
    end else begin
      p:=FCalcLibraries.Objects[j];
      Result:=integer(p);
    end;
  end;

  procedure FreeCalcLibraries;
  var
    j, H:integer;
    p:pointer;
  begin
    for j:=0 to FCalcLibraries.Count-1 do begin
      p:=FCalcLibraries.Objects[j];
      H:=integer(p);
      DM_FreeLibrary(H);
    end;
  end;

//var
//  j:integer;
//  S:string;
begin
  FreeCalcLibraries;
{
  for j:=0 to OvercomeMethods.Count-1 do begin

    S:=OvercomeMethods[j].CalcDelayLib;
    if S<>'' then
      OvercomeMethods[j].CalcDelayTimeHandle:=LoadCalcLibrary(S);

    S:=OvercomeMethods[j].CalcProbabilityLib;
    if S<>'' then
      OvercomeMethods[j].CalcDetectionProbabilityHandle:=LoadCalcLibrary(S);

    S:=OvercomeMethods[j].CalcFieldsLib;
    if S<>'' then
      OvercomeMethods[j].CalcPhysicalFieldsHandle:=LoadCalcLibrary(S);
  end;

  for j:=0 to SurfaceSensorTypes.Count-1 do begin
    S:=SurfaceSensorTypes[j].CalcFalseAlarmPeriodLib;
    if S<>'' then
      SurfaceSensorTypes[j].CalcFalseAlarmPeriodHandle:=LoadCalcLibrary(S);
  end;

  for j:=0 to PositionSensorTypes.Count-1 do begin
    S:=PositionSensorTypes[j].CalcFalseAlarmPeriodLib;
    if S<>'' then
      PositionSensorTypes[j].CalcFalseAlarmPeriodHandle:=LoadCalcLibrary(S);
  end;

  for j:=0 to VolumeSensorTypes.Count-1 do begin
    S:=VolumeSensorTypes[j].CalcFalseAlarmPeriodLib;
    if S<>'' then
      VolumeSensorTypes[j].CalcFalseAlarmPeriodHandle:=LoadCalcLibrary(S);
  end;

  for j:=0 to BarrierSensorTypes.Count-1 do begin
    S:=BarrierSensorTypes[j].CalcFalseAlarmPeriodLib;
    if S<>'' then
      BarrierSensorTypes[j].CalcFalseAlarmPeriodHandle:=LoadCalcLibrary(S);
  end;

  for j:=0 to PerimeterSensorTypes.Count-1 do begin
    S:=PerimeterSensorTypes[j].CalcFalseAlarmPeriodLib;
    if S<>'' then
      PerimeterSensorTypes[j].CalcFalseAlarmPeriodHandle:=LoadCalcLibrary(S);
  end;
}
end;

procedure TSafeguardDatabase.LoadedFromDataBase(const aDataBaseU: IUnknown);
var
  j:integer;
  aCollection:IDMCollection;
  aElementImageE, aOvercomeMethodE:IDMElement;
  aOvercomeMethod:IOvercomeMethod;
begin

  Get_DataClassModel.LoadFromDataBase(aDataBaseU);

  inherited;

  FSphearSectorImage:=nil;
  aCollection:=Collection[_ElementImage];
  for j:=0 to aCollection.Count-1 do begin
    aElementImageE:=aCollection.Item[j];
    (aElementImageE as ILayer).Visible:=True;
    if (aElementImageE as IElementImage).ScalingType=eitConus then
     FSphearSectorImage:=aElementImageE;
  end;

  aCollection:=Collection[_OvercomeMethod];
  for j:=0 to aCollection.Count-1 do begin
    aOvercomeMethodE:=aCollection.Item[j];
    aOvercomeMethod:=aOvercomeMethodE as IOvercomeMethod;
    if (aOvercomeMethod.Tactics.Count=0) and
       (aOvercomeMethod.DelayProcCode=ord(dpcInfinit)) and
       (aOvercomeMethod.ProbabilityProcCode=ord(ppcOne)) then  begin
      FUserDefinedValueMethod:=aOvercomeMethodE;
    end;
  end;
end;

procedure TSafeguardDatabase.LoadFromDataBase(const aDataBaseU: IUnknown);
begin
  inherited;
end;

procedure TSafeguardDatabase.SaveToDatabase(const aDataBaseU: IUnknown);
begin
  inherited;
  Get_DataClassModel.SaveToDatabase(aDataBaseU)
end;

destructor TSafeguardDatabase.Destroy;
begin
  inherited;
  FDataClassModel:=nil;
  FSphearSectorImage:=nil;
  FUserDefinedValueMethod:=nil;

  FClassCollectionIndexes.Free;
  FSpecialZoneKinds:=nil;
end;

function TSafeguardDatabase.Get_SGDBParameters: IDMCollection;
begin
  Result:=Collection[_SGDBParameter]
end;

function TSafeguardDatabase.Get_SGDBParameterValues: IDMCollection;
begin
  Result:=Collection[_SGDBParameterValue]
end;

function TSafeguardDatabase.Get_DataClassModel: IDataModel;
begin
  Result:=FDataClassModel
end;

function TSafeguardDatabase.Get_SubModel(Index: integer): IDataModel;
begin
  case Index of
  2:  Result:=Self;
  8:  Result:=FDataClassModel;
  else
      Result:=inherited Get_SubModel(Index);
  end;
end;

function TSafeguardDatabase.Get_BoundaryKinds: IDMCollection;
begin
  Result:=Collection[_BoundaryKind]
end;

function TSafeguardDatabase.Get_BoundaryLayerTypes: IDMCollection;
begin
  Result:=Collection[_BoundaryLayerType]
end;

function TSafeguardDatabase.Get_BoundaryTypes: IDMCollection;
begin
  Result:=Collection[_BoundaryType]
end;

function TSafeguardDatabase.Get_ZoneKinds: IDMCollection;
begin
  Result:=Collection[_ZoneKind]
end;

function TSafeguardDatabase.Get_ZoneTypes: IDMCollection;
begin
  Result:=Collection[_ZoneType]
end;

function TSafeguardDatabase.Get_CabelTypes: IDMCollection;
begin
  Result:=Collection[_CabelType]
end;

function TSafeguardDatabase.Get_SkillTypes: IDMCollection;
begin
  Result:=Collection[_SkillType]
end;

function TSafeguardDatabase.Get_Tactics: IDMCollection;
begin
  Result:=Collection[_Tactic]
end;

function TSafeguardDatabase.Get_ToolKinds: IDMCollection;
begin
  Result:=Collection[_ToolKind]
end;

function TSafeguardDatabase.Get_VehicleKinds: IDMCollection;
begin
  Result:=Collection[_VehicleKind]
end;

function TSafeguardDatabase.Get_WeaponKinds: IDMCollection;
begin
  Result:=Collection[_WeaponKind]
end;

function TSafeguardDatabase.Get_AthorityTypes: IDMCollection;
begin
  Result:=Collection[_AthorityType]
end;

function TSafeguardDatabase.Get_StartPointKinds: IDMCollection;
begin
  Result:=Collection[_StartPointKind]
end;

function TSafeguardDatabase.Get_Areas: IDMCollection;
begin
  Result:=Collection[_sgArea]
end;

function TSafeguardDatabase.Get_CoordNodes: IDMCollection;
begin
  Result:=Collection[_sgCoordNode]
end;

function TSafeguardDatabase.Get_CurvedLines: IDMCollection;
begin
  Result:=Collection[_sgCurvedLine]
end;

function TSafeguardDatabase.Get_ImageRects: IDMCollection;
begin
  Result:=Collection[_sgImageRect]
end;

function TSafeguardDatabase.Get_Layers: IDMCollection;
begin
  Result:=Collection[_ElementImage]
end;

function TSafeguardDatabase.Get_Lines: IDMCollection;
begin
  Result:=Collection[_sgLine]
end;

function TSafeguardDatabase.Get_Polylines: IDMCollection;
begin
  Result:=Collection[_sgPolyline]
end;

function TSafeguardDatabase.Get_Views: IDMCollection;
begin
  Result:=Collection[_sgView]
end;

function TSafeguardDatabase.Get_Volumes: IDMCollection;
begin
  Result:=Collection[_sgVolume]
end;

procedure TSafeguardDatabase.Set_CurrentLayer(const Value: ILayer);
var
  j:integer;
  Layer:ILayer;
begin
  inherited;
  for j:=0 to Get_Layers.Count-1 do begin
    Layer:=Get_Layers.Item[j] as ILayer;
    if Layer<>Value then begin
      Layer.Visible:=False;
      Layer.Selectable:=False
    end else begin
      Layer.Visible:=True;
      Layer.Selectable:=True
    end;  
  end;
end;

function TSafeguardDatabase.Get_MethodArrayValues: IDMCollection;
begin
  Result:=Collection[_sgMethodArrayValue]
end;

function TSafeguardDatabase.Get_SphearSectorImage: IDMElement;
begin
  Result:=FSphearSectorImage
end;

function TSafeguardDatabase.Get_CommunicationDeviceTypes: IDMCollection;
begin
  Result:=Collection[_CommunicationDeviceType]
end;

function TSafeguardDatabase.Get_BattleSkills: IDMCollection;
begin
  Result:=Collection[_BattleSkill]
end;

function TSafeguardDatabase.Get_Fonts: IDMCollection;
begin
  Result:=nil
end;

procedure TSafeguardDatabase.AfterLoading2;
var
  ZoneKinds:IDMCollection;
  SpecialZoneKinds2:IDMCollection2;
  j, i:integer;
  ZoneKindE:IDMElement;
  ZoneKind:IZoneKind;
begin
  inherited;
  ZoneKinds:=Get_ZoneKinds;
  SpecialZoneKinds2:=FSpecialZoneKinds as IDMCollection2;
  for j:=0 to skBuilding do
    SpecialZoneKinds2.Add(nil);
  try
  for j:=0 to ZoneKinds.Count-1 do begin
    ZoneKindE:=ZoneKinds.Item[j];
    ZoneKind:=ZoneKindE as IZoneKind;
    i:=ZoneKind.SpecialKind;
    if i<>-1 then begin
      SpecialZoneKinds2.Delete(i);
      SpecialZoneKinds2.Insert(i, ZoneKindE);
    end;
  end;
  except
    raise
  end;  
end;

function TSafeguardDatabase.GetDefaultParent(ClassID: integer): IDMElement;
begin
  Result:=nil
end;

procedure TSafeguardDatabase.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  aCollection3:IDMCollection3;
begin
  inherited;
  case Index of
  _ZoneType,
  _BoundaryType:
    begin
//      aOperations:=0;
    end;
  else
    aOperations:=aOperations or leoMove;
  end;
  aCollection3:=Get_Collection(Index) as IDMCollection3;
  if aCollection3<>nil then
    aCollectionName:=aCollection3.ClassAlias2[akImenitM]
end;

function TSafeguardDatabase.Get_JumpKinds: IDMCollection;
begin
  Result:=Collection[_JumpKind]
end;

function TSafeguardDatabase.Get_UpdateTypes: IDMCollection;
begin
end;

function TSafeguardDatabase.Get_Updating: IDMCollection;
begin
  Result:=Collection[_Updating]
end;

function TSafeguardDatabase.Get_ClassCollection(Index,
  Mode: Integer): IDMCollection;
begin
  case Mode of
  -9:case Index of
    0: Result:=Collection[_ZoneType];
    1: Result:=Collection[_BoundaryType];
    2: Result:=Collection[_JumpType];
    3: Result:=Collection[_BoundaryLayerType];
    4: Result:=Collection[_Tactic];
    5: Result:=Collection[_OvercomeMethod];
    6: Result:=Collection[_BarrierType];
    7: Result:=Collection[_LockType];
    8: Result:=Collection[_FenceObstacleType];
    9: Result:=Collection[_UndergroundObstacleType];
    10: Result:=Collection[_GroundObstacleType];
    11: Result:=Collection[_ActiveSafeguardType];
    12: Result:=Collection[_PositionSensorType];
    13: Result:=Collection[_SurfaceSensorType];
    14: Result:=Collection[_VolumeSensorType];
    15: Result:=Collection[_PerimeterSensorType];
    16: Result:=Collection[_ContrabandSensorType];
    17: Result:=Collection[_AccessControlType];
    18: Result:=Collection[_TVCameraType];
    19: Result:=Collection[_LightDeviceType];
    20: Result:=Collection[_TargetType];
    21: Result:=Collection[_GuardPostType];
    22: Result:=Collection[_CommunicationDeviceType];
    23: Result:=Collection[_ControlDeviceType];
    24: Result:=Collection[_CabelType];
    25: Result:=Collection[_StartPointType];
    26: Result:=Collection[_WeaponType];
    27: Result:=Collection[_ToolType];
    28: Result:=Collection[_VehicleType];
    29: Result:=Collection[_AthorityType];
    30: Result:=Collection[_SkillType];
    31: Result:=Collection[_BattleSkill];
    32: Result:=Collection[_PhysicalField];
    33: Result:=Collection[_ElementImage];

    end;
  else
    Result:=nil;
  end
end;

function TSafeguardDatabase.Get_ClassCount(Mode: Integer): Integer;
begin
  case Mode of
   -9:Result:=33;
  else
     Result:=0;
  end;
end;

function TSafeguardDatabase.Get_DefaultClassCollectionIndex(Index,
  Mode: Integer): Integer;
var
  j, ClassCollectionIndexesCount:integer;
begin
  ClassCollectionIndexesCount:=FClassCollectionIndexes.Count;
  if ClassCollectionIndexesCount-1 < Index then begin
    for j:=ClassCollectionIndexesCount to Index do
      FClassCollectionIndexes.Add(pointer(-1));
    Result:=-1;
  end else
    Result:=integer(FClassCollectionIndexes[Index])
end;

procedure TSafeguardDatabase.Set_DefaultClassCollectionIndex(Index, Mode,
  Value: Integer);
var
  j, ClassCollectionIndexesCount:integer;
begin
  ClassCollectionIndexesCount:=FClassCollectionIndexes.Count;
  if ClassCollectionIndexesCount-1 < Index then
    for j:=ClassCollectionIndexesCount to Index do
      FClassCollectionIndexes.Add(pointer(-1));
  FClassCollectionIndexes[Index]:=pointer(Value);
end;

function TSafeguardDatabase.Get_UserDefinedValueMethod: IDMElement;
begin
  Result:=FUserDefinedValueMethod
end;

//initialization
//  CreateTypedComObjectFactory(TSafeguardDatabase, Class_SafeguardDatabase);
function TSafeguardDatabase.Get_SpecialZoneKinds: IDMCollection;
begin
  Result:=FSpecialZoneKinds
end;

function TSafeguardDatabase.KeepHash: boolean;
begin
  Result:=True
end;

end.
