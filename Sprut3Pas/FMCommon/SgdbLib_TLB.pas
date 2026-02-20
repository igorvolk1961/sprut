unit SgdbLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130.1.0.1.0.1.6  $
// File generated on 18.02.2008 13:34:51 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\Sprut3\Sprut3Pas\SGDB\Sgdb.tlb (1)
// LIBID: {24BBEAC0-5E99-11D5-845E-F63997C64D0C}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
//   (2) v1.0 DataModel, (D:\users\Volkov\AutoDM\AutoDMPas\DataModel\DataModel.tlb)
//   (3) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, DataModel_TLB, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SgdbLibMajorVersion = 1;
  SgdbLibMinorVersion = 0;

  LIBID_SgdbLib: TGUID = '{24BBEAC0-5E99-11D5-845E-F63997C64D0C}';

  IID_ISafeguardDatabase: TGUID = '{1723ECA2-5ECB-11D5-845E-8BDDD017430C}';
  IID_IZoneType: TGUID = '{1723ECA6-5ECB-11D5-845E-8BDDD017430C}';
  IID_IZoneKind: TGUID = '{1723ECA8-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBoundaryType: TGUID = '{1723ECAA-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBoundaryKind: TGUID = '{1723ECAC-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBoundaryLayerType: TGUID = '{1723ECAE-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBarrierType: TGUID = '{1723ECB2-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBarrierKind: TGUID = '{1723ECB4-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILockType: TGUID = '{1723ECB6-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILockKind: TGUID = '{1723ECB8-5ECB-11D5-845E-8BDDD017430C}';
  IID_IUndergroundObstacleType: TGUID = '{1723ECBA-5ECB-11D5-845E-8BDDD017430C}';
  IID_IUndergroundObstacleKind: TGUID = '{1723ECBC-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISurfaceSensorType: TGUID = '{1723ECBE-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISurfaceSensorKind: TGUID = '{1723ECC0-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPositionSensorType: TGUID = '{1723ECC2-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPositionSensorKind: TGUID = '{1723ECC4-5ECB-11D5-845E-8BDDD017430C}';
  IID_IVolumeSensorType: TGUID = '{1723ECC6-5ECB-11D5-845E-8BDDD017430C}';
  IID_IVolumeSensorKind: TGUID = '{1723ECC8-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBarrierSensorType: TGUID = '{1723ECCA-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBarrierSensorKind: TGUID = '{1723ECCC-5ECB-11D5-845E-8BDDD017430C}';
  IID_IContrabandSensorType: TGUID = '{1723ECCE-5ECB-11D5-845E-8BDDD017430C}';
  IID_IContrabandSensorKind: TGUID = '{1723ECD0-5ECB-11D5-845E-8BDDD017430C}';
  IID_IAccessControlType: TGUID = '{1723ECD2-5ECB-11D5-845E-8BDDD017430C}';
  IID_IAccessControlKind: TGUID = '{1723ECD4-5ECB-11D5-845E-8BDDD017430C}';
  IID_ITVCameraType: TGUID = '{1723ECD6-5ECB-11D5-845E-8BDDD017430C}';
  IID_ITVCameraKind: TGUID = '{1723ECD8-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILightDeviceType: TGUID = '{1723ECDA-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILightDeviceKind: TGUID = '{1723ECDC-5ECB-11D5-845E-8BDDD017430C}';
  IID_ICommunicationDeviceType: TGUID = '{1723ECDE-5ECB-11D5-845E-8BDDD017430C}';
  IID_ICommunicationDeviceKind: TGUID = '{1723ECE0-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPowerSourceType: TGUID = '{1723ECE2-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPowerSourceKInd: TGUID = '{1723ECE4-5ECB-11D5-845E-8BDDD017430C}';
  IID_ICabelType: TGUID = '{1723ECE6-5ECB-11D5-845E-8BDDD017430C}';
  IID_ICabelKind: TGUID = '{1723ECE8-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPatrolType: TGUID = '{1723ECEA-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPatrolKind: TGUID = '{1723ECEC-5ECB-11D5-845E-8BDDD017430C}';
  IID_IGuardPostType: TGUID = '{1723ECEE-5ECB-11D5-845E-8BDDD017430C}';
  IID_IGuardPostKind: TGUID = '{1723ECF0-5ECB-11D5-845E-8BDDD017430C}';
  IID_ITargetType: TGUID = '{1723ECF2-5ECB-11D5-845E-8BDDD017430C}';
  IID_ITargetKind: TGUID = '{1723ECF4-5ECB-11D5-845E-8BDDD017430C}';
  IID_IConveyanceType: TGUID = '{1723ECF6-5ECB-11D5-845E-8BDDD017430C}';
  IID_IConveyanceKInd: TGUID = '{1723ECF8-5ECB-11D5-845E-8BDDD017430C}';
  IID_IConveyanceSegmentType: TGUID = '{1723ECFA-5ECB-11D5-845E-8BDDD017430C}';
  IID_IConveyanceSegmentKind: TGUID = '{1723ECFC-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILocalPointObjectType: TGUID = '{1723ECFE-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILocalPointObjectKind: TGUID = '{1723ED00-5ECB-11D5-845E-8BDDD017430C}';
  IID_IJumpType: TGUID = '{1723ED02-5ECB-11D5-845E-8BDDD017430C}';
  IID_IJumpKind: TGUID = '{1723ED04-5ECB-11D5-845E-8BDDD017430C}';
  IID_IGuardCharacteristicType: TGUID = '{1723ED08-5ECB-11D5-845E-8BDDD017430C}';
  IID_IGuardCharacteristicKind: TGUID = '{1723ED0A-5ECB-11D5-845E-8BDDD017430C}';
  IID_IOvercomeMethod: TGUID = '{1723ED0C-5ECB-11D5-845E-8BDDD017430C}';
  IID_IWeaponType: TGUID = '{1723ED0E-5ECB-11D5-845E-8BDDD017430C}';
  IID_IWeaponKind: TGUID = '{1723ED10-5ECB-11D5-845E-8BDDD017430C}';
  IID_IToolType: TGUID = '{1723ED12-5ECB-11D5-845E-8BDDD017430C}';
  IID_IToolKind: TGUID = '{1723ED14-5ECB-11D5-845E-8BDDD017430C}';
  IID_IVehicleType: TGUID = '{1723ED16-5ECB-11D5-845E-8BDDD017430C}';
  IID_IVehicleKind: TGUID = '{1723ED18-5ECB-11D5-845E-8BDDD017430C}';
  IID_IAthorityType: TGUID = '{1723ED1C-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISkillType: TGUID = '{1723ED1E-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPhysicalField: TGUID = '{1723ED22-5ECB-11D5-845E-8BDDD017430C}';
  IID_IDeviceFunction: TGUID = '{1723ED24-5ECB-11D5-845E-8BDDD017430C}';
  IID_IDeviceState: TGUID = '{1723ED26-5ECB-11D5-845E-8BDDD017430C}';
  IID_IHindrance: TGUID = '{1723ED28-5ECB-11D5-845E-8BDDD017430C}';
  IID_IWeather: TGUID = '{1723ED2A-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISGDBParameter: TGUID = '{1723ED2C-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISGDBParameterValue: TGUID = '{1723ED2E-5ECB-11D5-845E-8BDDD017430C}';
  IID_IShotDispersionRec: TGUID = '{1723ED30-5ECB-11D5-845E-8BDDD017430C}';
  IID_IElementImage: TGUID = '{1723ED34-5ECB-11D5-845E-8BDDD017430C}';
  IID_IStartPointType: TGUID = '{1723ED38-5ECB-11D5-845E-8BDDD017430C}';
  IID_IStartPointKind: TGUID = '{1723ED3A-5ECB-11D5-845E-8BDDD017430C}';
  IID_IActiveSafeguardType: TGUID = '{1723ED3C-5ECB-11D5-845E-8BDDD017430C}';
  IID_IActiveSafeguardKind: TGUID = '{1723ED3E-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPerimeterSensorType: TGUID = '{1723ED40-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPerimeterSensorKind: TGUID = '{1723ED42-5ECB-11D5-845E-8BDDD017430C}';
  IID_IDataClassModel: TGUID = '{4F005860-5F76-11D5-845E-FEE1D8DC510C}';
  IID_ISafeguardClass: TGUID = '{4F005862-5F76-11D5-845E-FEE1D8DC510C}';
  IID_IWarriorAttributeKind: TGUID = '{4F005864-5F76-11D5-845E-FEE1D8DC510C}';
  IID_IModelElementKind: TGUID = '{4F005868-5F76-11D5-845E-FEE1D8DC510C}';
  IID_IWarriorAttributeType: TGUID = '{4F00586A-5F76-11D5-845E-FEE1D8DC510C}';
  IID_IModelElementType: TGUID = '{C2B21360-6053-11D5-845E-C202389DB00A}';
  IID_ISafeguardElementTypes: TGUID = '{B1CCF560-65D0-11D5-845E-CD5AD705670A}';
  IID_ISafeguardElementType: TGUID = '{62264B39-E560-11D5-92FE-0050BA51A6D3}';
  IID_ISafeguardElementKind: TGUID = '{BDC00420-18EA-11D6-AEBE-F664C6F8BE63}';
  IID_ILocalObjectKind: TGUID = '{8D4BF431-2C5E-11D6-96BE-0050BA51A6D3}';
  IID_IDetectionElementType: TGUID = '{5E521B03-2CFD-11D6-96C0-0050BA51A6D3}';
  IID_IDetectionElementKind: TGUID = '{5E521B05-2CFD-11D6-96C0-0050BA51A6D3}';
  IID_ITactic: TGUID = '{22DB3A80-013A-11D3-BBF3-F7A843528336}';
  IID_IMethodDimItem: TGUID = '{79ADBEC1-6177-11D6-96FF-0050BA51A6D3}';
  IID_IMethodDimension: TGUID = '{7A290EF3-6242-11D6-9701-0050BA51A6D3}';
  IID_IMethodDimItemSource: TGUID = '{7A290EF6-6242-11D6-9701-0050BA51A6D3}';
  IID_IBattleSkill: TGUID = '{37F90C61-827A-11D6-9729-0050BA51A6D3}';
  IID_IGroundObstacleKind: TGUID = '{EDF75064-9759-11D6-9B9F-970B96239AA2}';
  IID_IFenceObstacleKind: TGUID = '{EDF75066-9759-11D6-9B9F-970B96239AA2}';
  IID_IGroundObstacleType: TGUID = '{EDF75068-9759-11D6-9B9F-970B96239AA2}';
  IID_IFenceObstacleType: TGUID = '{EDF7506A-9759-11D6-9B9F-970B96239AA2}';
  IID_IPrice: TGUID = '{101C0561-430B-11D7-97F8-0050BA51A6D3}';
  IID_ISoundSensorType: TGUID = '{26795940-8A2C-11D7-9BA0-FDDA98FCA360}';
  IID_ISoundSensorKind: TGUID = '{26795942-8A2C-11D7-9BA0-FDDA98FCA360}';
  IID_IRoadType: TGUID = '{26795944-8A2C-11D7-9BA0-FDDA98FCA360}';
  IID_IControlDeviceType: TGUID = '{FB147E93-FADE-11D7-98D2-0050BA51A6D3}';
  IID_IControlDeviceKind: TGUID = '{FB147E95-FADE-11D7-98D2-0050BA51A6D3}';
  IID_IVisualElement: TGUID = '{501EAFC0-FC5F-11D7-BBF3-0010603BA6C9}';
  IID_IUpdating: TGUID = '{C58E2AD4-E7A9-11D9-9AE4-0050BA51A6D3}';
  IID_ITexture: TGUID = '{440888B3-3515-48E7-ADB4-C46833EBFACB}';
  IID_IElementParameter: TGUID = '{7915C868-6E1A-4ABD-B72B-DB19514FDBF4}';
  IID_IBoundaryKind2: TGUID = '{FBA77FEF-7D6C-4D09-A8C9-6B94DD74DC10}';
  IID_IShotBreachRec: TGUID = '{DDD43543-6F71-4C1B-866A-34BA0556D2D5}';
  IID_IObserverKind: TGUID = '{FCEB5AAD-D83B-421C-BF75-89C4768B4E51}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum SgdbClassID
type
  SgdbClassID = TOleEnum;
const
  _ZoneType = $00000000;
  _ZoneKind = $00000001;
  _BoundaryType = $00000002;
  _BoundaryKind = $00000003;
  _BoundaryLayerType = $00000004;
  _Dummy1 = $00000005;
  _BarrierType = $00000006;
  _BarrierKind = $00000007;
  _Reserver1 = $00000008;
  _Reserver2 = $00000009;
  _LockType = $0000000A;
  _LockKind = $0000000B;
  _UndergroundObstacleType = $0000000C;
  _UndergroundObstacleKind = $0000000D;
  _SurfaceSensorType = $0000000E;
  _SurfaceSensorKind = $0000000F;
  _PositionSensorType = $00000010;
  _PositionSensorKind = $00000011;
  _VolumeSensorType = $00000012;
  _VolumeSensorKind = $00000013;
  _BarrierSensorType = $00000014;
  _BarrierSensorKind = $00000015;
  _ContrabandSensorType = $00000016;
  _ContrabandSensorKind = $00000017;
  _AccessControlType = $00000018;
  _AccessControlKind = $00000019;
  _TVCameraType = $0000001A;
  _TVCameraKind = $0000001B;
  _LightDeviceType = $0000001C;
  _LightDeviceKind = $0000001D;
  _CommunicationDeviceType = $0000001E;
  _CommunicationDeviceKind = $0000001F;
  _PowerSourceType = $00000020;
  _PowerSourceKind = $00000021;
  _CabelType = $00000022;
  _CabelKind = $00000023;
  _ControlDeviceType = $00000024;
  _ControlDeviceKind = $00000025;
  _PatrolType = $00000026;
  _PatrolKind = $00000027;
  _GuardPostType = $00000028;
  _GuardPostKind = $00000029;
  _TargetType = $0000002A;
  _TargetKind = $0000002B;
  _ConveyanceType = $0000002C;
  _ConveyanceKind = $0000002D;
  _ConveyanceSegmentType = $0000002E;
  _ConveyanceSegmentKind = $0000002F;
  _LocalPointObjectType = $00000030;
  _LocalPointObjectKind = $00000031;
  _JumpType = $00000032;
  _JumpKind = $00000033;
  _BattleSkill = $00000034;
  _GuardCharacteristicType = $00000035;
  _GuardCharacteristicKind = $00000036;
  _OvercomeMethod = $00000037;
  _WeaponType = $00000038;
  _WeaponKind = $00000039;
  _ToolType = $0000003A;
  _ToolKind = $0000003B;
  _VehicleType = $0000003C;
  _VehicleKind = $0000003D;
  _Reserved16 = $0000003E;
  _AthorityType = $0000003F;
  _SkillType = $00000040;
  _Reserved4 = $00000041;
  _Reserved5 = $00000042;
  _Reserved6 = $00000043;
  _PhysicalField = $00000044;
  _DeviceFunction = $00000045;
  _DeviceState = $00000046;
  _Hindrance = $00000047;
  _Weather = $00000048;
  _SGDBParameter = $00000049;
  _SGDBParameterValue = $0000004A;
  _Tactic = $0000004B;
  _GroundObstacleType = $0000004C;
  _GroundObstacleKind = $0000004D;
  _FenceObstacleType = $0000004E;
  _FenceObstacleKind = $0000004F;
  _ElementParameter = $00000050;
  _Reserved13 = $00000051;
  _Reserved14 = $00000052;
  _Reserved15 = $00000053;
  _ShotDispersionRec = $00000054;
  _sgMethodDimension = $00000055;
  _sgMethodArrayValue = $00000056;
  _sgMethodDimItem = $00000057;
  _Reserver18 = $00000058;
  _Reserver19 = $00000059;
  _Reserver20 = $0000005A;
  _Reserver21 = $0000005B;
  _ElementImage = $0000005C;
  _StartPointType = $0000005D;
  _StartPointKind = $0000005E;
  _ActiveSafeguardType = $0000005F;
  _ActiveSafeguardKind = $00000060;
  _PerimeterSensorType = $00000061;
  _PerimeterSensorKind = $00000062;
  _sgCoordNode = $00000063;
  _sgLine = $00000064;
  _sgCurvedLine = $00000065;
  _sgPolyline = $00000066;
  _sgArea = $00000067;
  _sgVolume = $00000068;
  _sgView = $00000069;
  _sgImageRect = $0000006A;
  _Updating = $0000006B;
  _Texture = $0000006C;
  _ShotBreachRec = $0000006D;

// Constants for enum TElementImageScalingType
type
  TElementImageScalingType = TOleEnum;
const
  eitNoScaling = $00000000;
  eitScaling = $00000001;
  eitXScaling = $00000002;
  eitXYScaling = $00000003;
  eitXYZScaling = $00000004;
  eitConus = $00000005;
  eitMultScaling = $00000006;

// Constants for enum TDelayProcCode
type
  TDelayProcCode = TOleEnum;
const
  dpcExternal = $FFFFFFFF;
  dpcZero = $00000000;
  dpcInfinit = $00000001;
  dpcEc = $00000002;
  dpcCriminalEc = $00000003;
  dpcUseKey = $00000004;
  dpcClimb = $00000005;
  dpcGuard = $00000006;
  dpcMatrix = $FFFFFFFE;
  dpcCodeMatrix = $FFFFFFFD;
  dpcVelocityMatrix = $00000007;
  dpcVelocityCodeMatrix = $00000008;
  dpcMinimum = $00000009;

// Constants for enum TProbabilityProcCode
type
  TProbabilityProcCode = TOleEnum;
const
  ppcExternal = $FFFFFFFF;
  ppcZero = $00000000;
  ppcOne = $00000001;
  ppcStandard = $00000002;
  ppcReserved1 = $00000003;
  ppcReserved2 = $00000004;
  ppcReserved3 = $00000005;
  ppcGuard = $00000006;
  ppcMatrix = $FFFFFFFE;
  ppcCodeMatrix = $FFFFFFFD;

// Constants for enum TMethodDimensionSourceKind
type
  TMethodDimensionSourceKind = TOleEnum;
const
  skElement = $00000000;
  skElementKind = $00000001;
  skGroup = $00000002;
  skGroupTarget = $00000003;
  skBoundary = $00000004;
  skBoundaryLayer = $00000005;
  skZone = $00000006;
  skControlDevice = $00000007;
  skControlDeviceKind = $00000008;
  skMethod = $00000009;

// Constants for enum TMethodDimensionKind
type
  TMethodDimensionKind = TOleEnum;
const
  sdAthorityType = $00000000;
  sdToolSkillLevel = $00000001;
  sdToolType = $00000002;
  sdToolKind = $00000003;
  sdVehicleType = $00000004;
  sdVehicleKInd = $00000005;
  sdWeaponType = $00000006;
  sdWeaponKind = $00000007;
  sdAccess = $00000008;
  sdFieldValueInterval = $00000009;
  sdFieldValue = $0000000A;
  sdVisualControl = $0000000B;
  sdAlarmSignal = $0000000C;
  sdAlarmCabelSafety = $0000000D;
  sdAvailabelTime = $0000000E;
  sdTechnicalService = $0000000F;
  sdBarrierMaterial = $00000010;
  sdDetectionZoneSize = $00000011;
  sdAdversaryCount = $00000012;
  sdElevation = $00000013;
  sdDetectionSector = $00000014;
  sdDistance = $00000015;
  sdCommunication = $00000016;
  sdPostDefence = $00000017;
  sdTime = $00000018;
  sdMineLength = $00000019;
  sdTVMonitorCount = $0000001A;
  sdWeight = $0000001B;
  sdProhibition = $0000001C;
  sdKindID = $0000001D;
  sdSize = $0000001E;
  sdHasMetall = $0000001F;
  sdPersonalCount = $00000020;
  sdSensorAccessControl = $00000021;
  sdRamEnabled = $00000022;

// Constants for enum TBoundaryPathKind
type
  TBoundaryPathKind = TOleEnum;
const
  bpkVOne = $00000000;
  bpkVMany = $00000001;
  bpkHOne = $00000002;
  bpkHMany = $00000003;

// Constants for enum TBattleUnitState
type
  TBattleUnitState = TOleEnum;
const
  busShotNoDefence = $00000000;
  busShotHalfDefence = $00000002;
  busShotChestDefence = $00000003;
  busShotHeadDefence = $00000004;
  busHide = $00000005;
  busShotRun = $00000001;
  busStartDelay = $00000007;

// Constants for enum TPriceDimension
type
  TPriceDimension = TOleEnum;
const
  pdPerPieceR = $00000000;
  pdPerPieceU = $00000001;
  pdPerLengthR = $00000002;
  pdPerLengthU = $00000003;
  pdPerSquareR = $00000004;
  pdPerSquareU = $00000005;
  pdPerVolumeR = $00000006;
  pdPerVolumeU = $00000007;
  pdPerComplectR = $00000008;
  pdPerComplectU = $00000009;

// Constants for enum TEvidence
type
  TEvidence = TOleEnum;
const
  eNoEvidence = $00000000;
  eHiddenEvidence = $00000001;
  eVisualEvidence = $00000002;
  eLegal = $00000003;

// Constants for enum TMatrixValueKind
type
  TMatrixValueKind = TOleEnum;
const
  mvkDelay = $00000000;
  mvkProbability = $00000001;
  mvkFields = $00000002;

// Constants for enum TSpecialKind
type
  TSpecialKind = TOleEnum;
const
  skNone = $00000000;
  skAir = $00000001;
  skEarth = $00000002;
  skSite = $00000003;
  skRoof = $00000004;
  skBuilding = $00000005;

// Constants for enum TBoundaryTypeID
type
  TBoundaryTypeID = TOleEnum;
const
  btBarrier = $00000000;
  btEntryPoint = $00000001;
  btVirtual = $00000002;

// Constants for enum TZoneTypeID
type
  TZoneTypeID = TOleEnum;
const
  ztOpenZone = $00000000;
  ztClosedZone = $00000001;

// Constants for enum TControlDeviceTypeID
type
  TControlDeviceTypeID = TOleEnum;
const
  cdtDetectorControl = $00000000;
  cdtTVControl = $00000001;
  cdtCommunication = $00000002;

// Constants for enum TWeaponTypeID
type
  TWeaponTypeID = TOleEnum;
const
  wtArmWeapon = $00000000;
  wtLightAntiTankWeapon = $00000001;
  wtArtilery = $00000002;
  wtColdWeapon = $00000003;

// Constants for enum TTargetTypeID
type
  TTargetTypeID = TOleEnum;
const
  ttMainTarget = $00000001;
  ttBattlePosition = $00000002;

// Constants for enum TSystemKind
type
  TSystemKind = TOleEnum;
const
  skComplexSystem = $00000000;
  skAlarmSystem = $00000001;
  skTVSystem = $00000002;
  skAccessSystem = $00000003;
  skAlarmFireSystem = $00000004;
  skFireSystem = $00000005;
  skKeyStorageSystem = $00000006;

// Constants for enum TLayerKind
type
  TLayerKind = TOleEnum;
const
  lkVirtual = $00000000;
  lkHidden = $00000001;
  lkWall = $00000002;
  lkDoor = $00000003;
  lkWindow = $00000004;
  lkFence = $00000005;

// Constants for enum TBarrierTypeID
type
  TBarrierTypeID = TOleEnum;
const
  bWall = $00000000;
  bCeiling = $00000001;
  bDoor = $00000002;
  bGlass = $00000003;
  bGrid = $00000004;
  bRamObstacle = $00000005;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISafeguardDatabase = interface;
  ISafeguardDatabaseDisp = dispinterface;
  IZoneType = interface;
  IZoneTypeDisp = dispinterface;
  IZoneKind = interface;
  IZoneKindDisp = dispinterface;
  IBoundaryType = interface;
  IBoundaryTypeDisp = dispinterface;
  IBoundaryKind = interface;
  IBoundaryKindDisp = dispinterface;
  IBoundaryLayerType = interface;
  IBoundaryLayerTypeDisp = dispinterface;
  IBarrierType = interface;
  IBarrierTypeDisp = dispinterface;
  IBarrierKind = interface;
  IBarrierKindDisp = dispinterface;
  ILockType = interface;
  ILockTypeDisp = dispinterface;
  ILockKind = interface;
  ILockKindDisp = dispinterface;
  IUndergroundObstacleType = interface;
  IUndergroundObstacleTypeDisp = dispinterface;
  IUndergroundObstacleKind = interface;
  IUndergroundObstacleKindDisp = dispinterface;
  ISurfaceSensorType = interface;
  ISurfaceSensorTypeDisp = dispinterface;
  ISurfaceSensorKind = interface;
  ISurfaceSensorKindDisp = dispinterface;
  IPositionSensorType = interface;
  IPositionSensorTypeDisp = dispinterface;
  IPositionSensorKind = interface;
  IPositionSensorKindDisp = dispinterface;
  IVolumeSensorType = interface;
  IVolumeSensorTypeDisp = dispinterface;
  IVolumeSensorKind = interface;
  IVolumeSensorKindDisp = dispinterface;
  IBarrierSensorType = interface;
  IBarrierSensorTypeDisp = dispinterface;
  IBarrierSensorKind = interface;
  IBarrierSensorKindDisp = dispinterface;
  IContrabandSensorType = interface;
  IContrabandSensorTypeDisp = dispinterface;
  IContrabandSensorKind = interface;
  IContrabandSensorKindDisp = dispinterface;
  IAccessControlType = interface;
  IAccessControlTypeDisp = dispinterface;
  IAccessControlKind = interface;
  IAccessControlKindDisp = dispinterface;
  ITVCameraType = interface;
  ITVCameraTypeDisp = dispinterface;
  ITVCameraKind = interface;
  ITVCameraKindDisp = dispinterface;
  ILightDeviceType = interface;
  ILightDeviceTypeDisp = dispinterface;
  ILightDeviceKind = interface;
  ILightDeviceKindDisp = dispinterface;
  ICommunicationDeviceType = interface;
  ICommunicationDeviceTypeDisp = dispinterface;
  ICommunicationDeviceKind = interface;
  ICommunicationDeviceKindDisp = dispinterface;
  IPowerSourceType = interface;
  IPowerSourceTypeDisp = dispinterface;
  IPowerSourceKInd = interface;
  IPowerSourceKIndDisp = dispinterface;
  ICabelType = interface;
  ICabelTypeDisp = dispinterface;
  ICabelKind = interface;
  ICabelKindDisp = dispinterface;
  IPatrolType = interface;
  IPatrolTypeDisp = dispinterface;
  IPatrolKind = interface;
  IPatrolKindDisp = dispinterface;
  IGuardPostType = interface;
  IGuardPostTypeDisp = dispinterface;
  IGuardPostKind = interface;
  IGuardPostKindDisp = dispinterface;
  ITargetType = interface;
  ITargetTypeDisp = dispinterface;
  ITargetKind = interface;
  ITargetKindDisp = dispinterface;
  IConveyanceType = interface;
  IConveyanceTypeDisp = dispinterface;
  IConveyanceKInd = interface;
  IConveyanceKIndDisp = dispinterface;
  IConveyanceSegmentType = interface;
  IConveyanceSegmentTypeDisp = dispinterface;
  IConveyanceSegmentKind = interface;
  IConveyanceSegmentKindDisp = dispinterface;
  ILocalPointObjectType = interface;
  ILocalPointObjectTypeDisp = dispinterface;
  ILocalPointObjectKind = interface;
  ILocalPointObjectKindDisp = dispinterface;
  IJumpType = interface;
  IJumpTypeDisp = dispinterface;
  IJumpKind = interface;
  IJumpKindDisp = dispinterface;
  IGuardCharacteristicType = interface;
  IGuardCharacteristicTypeDisp = dispinterface;
  IGuardCharacteristicKind = interface;
  IGuardCharacteristicKindDisp = dispinterface;
  IOvercomeMethod = interface;
  IOvercomeMethodDisp = dispinterface;
  IWeaponType = interface;
  IWeaponTypeDisp = dispinterface;
  IWeaponKind = interface;
  IWeaponKindDisp = dispinterface;
  IToolType = interface;
  IToolTypeDisp = dispinterface;
  IToolKind = interface;
  IToolKindDisp = dispinterface;
  IVehicleType = interface;
  IVehicleTypeDisp = dispinterface;
  IVehicleKind = interface;
  IVehicleKindDisp = dispinterface;
  IAthorityType = interface;
  IAthorityTypeDisp = dispinterface;
  ISkillType = interface;
  ISkillTypeDisp = dispinterface;
  IPhysicalField = interface;
  IPhysicalFieldDisp = dispinterface;
  IDeviceFunction = interface;
  IDeviceFunctionDisp = dispinterface;
  IDeviceState = interface;
  IDeviceStateDisp = dispinterface;
  IHindrance = interface;
  IHindranceDisp = dispinterface;
  IWeather = interface;
  IWeatherDisp = dispinterface;
  ISGDBParameter = interface;
  ISGDBParameterDisp = dispinterface;
  ISGDBParameterValue = interface;
  ISGDBParameterValueDisp = dispinterface;
  IShotDispersionRec = interface;
  IShotDispersionRecDisp = dispinterface;
  IElementImage = interface;
  IElementImageDisp = dispinterface;
  IStartPointType = interface;
  IStartPointTypeDisp = dispinterface;
  IStartPointKind = interface;
  IStartPointKindDisp = dispinterface;
  IActiveSafeguardType = interface;
  IActiveSafeguardTypeDisp = dispinterface;
  IActiveSafeguardKind = interface;
  IActiveSafeguardKindDisp = dispinterface;
  IPerimeterSensorType = interface;
  IPerimeterSensorTypeDisp = dispinterface;
  IPerimeterSensorKind = interface;
  IPerimeterSensorKindDisp = dispinterface;
  IDataClassModel = interface;
  IDataClassModelDisp = dispinterface;
  ISafeguardClass = interface;
  ISafeguardClassDisp = dispinterface;
  IWarriorAttributeKind = interface;
  IWarriorAttributeKindDisp = dispinterface;
  IModelElementKind = interface;
  IModelElementKindDisp = dispinterface;
  IWarriorAttributeType = interface;
  IWarriorAttributeTypeDisp = dispinterface;
  IModelElementType = interface;
  IModelElementTypeDisp = dispinterface;
  ISafeguardElementTypes = interface;
  ISafeguardElementTypesDisp = dispinterface;
  ISafeguardElementType = interface;
  ISafeguardElementTypeDisp = dispinterface;
  ISafeguardElementKind = interface;
  ISafeguardElementKindDisp = dispinterface;
  ILocalObjectKind = interface;
  ILocalObjectKindDisp = dispinterface;
  IDetectionElementType = interface;
  IDetectionElementTypeDisp = dispinterface;
  IDetectionElementKind = interface;
  IDetectionElementKindDisp = dispinterface;
  ITactic = interface;
  ITacticDisp = dispinterface;
  IMethodDimItem = interface;
  IMethodDimItemDisp = dispinterface;
  IMethodDimension = interface;
  IMethodDimensionDisp = dispinterface;
  IMethodDimItemSource = interface;
  IMethodDimItemSourceDisp = dispinterface;
  IBattleSkill = interface;
  IBattleSkillDisp = dispinterface;
  IGroundObstacleKind = interface;
  IGroundObstacleKindDisp = dispinterface;
  IFenceObstacleKind = interface;
  IFenceObstacleKindDisp = dispinterface;
  IGroundObstacleType = interface;
  IGroundObstacleTypeDisp = dispinterface;
  IFenceObstacleType = interface;
  IFenceObstacleTypeDisp = dispinterface;
  IPrice = interface;
  IPriceDisp = dispinterface;
  ISoundSensorType = interface;
  ISoundSensorTypeDisp = dispinterface;
  ISoundSensorKind = interface;
  ISoundSensorKindDisp = dispinterface;
  IRoadType = interface;
  IRoadTypeDisp = dispinterface;
  IControlDeviceType = interface;
  IControlDeviceTypeDisp = dispinterface;
  IControlDeviceKind = interface;
  IControlDeviceKindDisp = dispinterface;
  IVisualElement = interface;
  IVisualElementDisp = dispinterface;
  IUpdating = interface;
  IUpdatingDisp = dispinterface;
  ITexture = interface;
  ITextureDisp = dispinterface;
  IElementParameter = interface;
  IElementParameterDisp = dispinterface;
  IBoundaryKind2 = interface;
  IBoundaryKind2Disp = dispinterface;
  IShotBreachRec = interface;
  IShotBreachRecDisp = dispinterface;
  IObserverKind = interface;
  IObserverKindDisp = dispinterface;

// *********************************************************************//
// Interface: ISafeguardDatabase
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECA2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISafeguardDatabase = interface(IUnknown)
    ['{1723ECA2-5ECB-11D5-845E-8BDDD017430C}']
    function Get_SGDBParameters: IDMCollection; safecall;
    function Get_SGDBParameterValues: IDMCollection; safecall;
    function Get_DataClassModel: IDataModel; safecall;
    function Get_ZoneTypes: IDMCollection; safecall;
    function Get_ZoneKinds: IDMCollection; safecall;
    function Get_BoundaryTypes: IDMCollection; safecall;
    function Get_BoundaryKinds: IDMCollection; safecall;
    function Get_BoundaryLayerTypes: IDMCollection; safecall;
    function Get_CabelTypes: IDMCollection; safecall;
    function Get_WeaponKinds: IDMCollection; safecall;
    function Get_ToolKinds: IDMCollection; safecall;
    function Get_VehicleKinds: IDMCollection; safecall;
    function Get_SkillTypes: IDMCollection; safecall;
    function Get_AthorityTypes: IDMCollection; safecall;
    function Get_StartPointKinds: IDMCollection; safecall;
    function Get_Tactics: IDMCollection; safecall;
    function Get_MethodArrayValues: IDMCollection; safecall;
    function Get_SphearSectorImage: IDMElement; safecall;
    function Get_CommunicationDeviceTypes: IDMCollection; safecall;
    function Get_BattleSkills: IDMCollection; safecall;
    function Get_JumpKinds: IDMCollection; safecall;
    function Get_Updating: IDMCollection; safecall;
    function Get_UserDefinedValueMethod: IDMElement; safecall;
    function Get_SpecialZoneKinds: IDMCollection; safecall;
    property SGDBParameters: IDMCollection read Get_SGDBParameters;
    property SGDBParameterValues: IDMCollection read Get_SGDBParameterValues;
    property DataClassModel: IDataModel read Get_DataClassModel;
    property ZoneTypes: IDMCollection read Get_ZoneTypes;
    property ZoneKinds: IDMCollection read Get_ZoneKinds;
    property BoundaryTypes: IDMCollection read Get_BoundaryTypes;
    property BoundaryKinds: IDMCollection read Get_BoundaryKinds;
    property BoundaryLayerTypes: IDMCollection read Get_BoundaryLayerTypes;
    property CabelTypes: IDMCollection read Get_CabelTypes;
    property WeaponKinds: IDMCollection read Get_WeaponKinds;
    property ToolKinds: IDMCollection read Get_ToolKinds;
    property VehicleKinds: IDMCollection read Get_VehicleKinds;
    property SkillTypes: IDMCollection read Get_SkillTypes;
    property AthorityTypes: IDMCollection read Get_AthorityTypes;
    property StartPointKinds: IDMCollection read Get_StartPointKinds;
    property Tactics: IDMCollection read Get_Tactics;
    property MethodArrayValues: IDMCollection read Get_MethodArrayValues;
    property SphearSectorImage: IDMElement read Get_SphearSectorImage;
    property CommunicationDeviceTypes: IDMCollection read Get_CommunicationDeviceTypes;
    property BattleSkills: IDMCollection read Get_BattleSkills;
    property JumpKinds: IDMCollection read Get_JumpKinds;
    property Updating: IDMCollection read Get_Updating;
    property UserDefinedValueMethod: IDMElement read Get_UserDefinedValueMethod;
    property SpecialZoneKinds: IDMCollection read Get_SpecialZoneKinds;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardDatabaseDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECA2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISafeguardDatabaseDisp = dispinterface
    ['{1723ECA2-5ECB-11D5-845E-8BDDD017430C}']
    property SGDBParameters: IDMCollection readonly dispid 1;
    property SGDBParameterValues: IDMCollection readonly dispid 2;
    property DataClassModel: IDataModel readonly dispid 3;
    property ZoneTypes: IDMCollection readonly dispid 4;
    property ZoneKinds: IDMCollection readonly dispid 5;
    property BoundaryTypes: IDMCollection readonly dispid 6;
    property BoundaryKinds: IDMCollection readonly dispid 7;
    property BoundaryLayerTypes: IDMCollection readonly dispid 8;
    property CabelTypes: IDMCollection readonly dispid 10;
    property WeaponKinds: IDMCollection readonly dispid 12;
    property ToolKinds: IDMCollection readonly dispid 13;
    property VehicleKinds: IDMCollection readonly dispid 14;
    property SkillTypes: IDMCollection readonly dispid 15;
    property AthorityTypes: IDMCollection readonly dispid 18;
    property StartPointKinds: IDMCollection readonly dispid 19;
    property Tactics: IDMCollection readonly dispid 20;
    property MethodArrayValues: IDMCollection readonly dispid 9;
    property SphearSectorImage: IDMElement readonly dispid 11;
    property CommunicationDeviceTypes: IDMCollection readonly dispid 16;
    property BattleSkills: IDMCollection readonly dispid 17;
    property JumpKinds: IDMCollection readonly dispid 23;
    property Updating: IDMCollection readonly dispid 21;
    property UserDefinedValueMethod: IDMElement readonly dispid 22;
    property SpecialZoneKinds: IDMCollection readonly dispid 24;
  end;

// *********************************************************************//
// Interface: IZoneType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECA6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IZoneType = interface(IUnknown)
    ['{1723ECA6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IZoneTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECA6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IZoneTypeDisp = dispinterface
    ['{1723ECA6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IZoneKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECA8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IZoneKind = interface(IUnknown)
    ['{1723ECA8-5ECB-11D5-845E-8BDDD017430C}']
    function Get_PedestrialMovementVelocity: Double; safecall;
    function Get_CarMovementEnabled: WordBool; safecall;
    function Get_AirMovementEnabled: WordBool; safecall;
    function Get_WaterMovementEnabled: WordBool; safecall;
    function Get_UnderWaterMovementEnabled: WordBool; safecall;
    function Get_RoadCover: Integer; safecall;
    function Get_DefaultCategory: Integer; safecall;
    function Get_DefaultTransparencyDist: Double; safecall;
    function Get_DefaultSideBoundaryKind: IDMElement; safecall;
    function Get_VSubZoneKind: IDMElement; safecall;
    function Get_HSubZoneKind: IDMElement; safecall;
    function Get_SpecialKind: Integer; safecall;
    function Get_UpperZoneKind: IDMElement; safecall;
    function Get_LowerZoneKind: IDMElement; safecall;
    function Get_DefaultBottomBoundaryKind: IDMElement; safecall;
    function Get_DefaultTopBoundaryKind: IDMElement; safecall;
    property PedestrialMovementVelocity: Double read Get_PedestrialMovementVelocity;
    property CarMovementEnabled: WordBool read Get_CarMovementEnabled;
    property AirMovementEnabled: WordBool read Get_AirMovementEnabled;
    property WaterMovementEnabled: WordBool read Get_WaterMovementEnabled;
    property UnderWaterMovementEnabled: WordBool read Get_UnderWaterMovementEnabled;
    property RoadCover: Integer read Get_RoadCover;
    property DefaultCategory: Integer read Get_DefaultCategory;
    property DefaultTransparencyDist: Double read Get_DefaultTransparencyDist;
    property DefaultSideBoundaryKind: IDMElement read Get_DefaultSideBoundaryKind;
    property VSubZoneKind: IDMElement read Get_VSubZoneKind;
    property HSubZoneKind: IDMElement read Get_HSubZoneKind;
    property SpecialKind: Integer read Get_SpecialKind;
    property UpperZoneKind: IDMElement read Get_UpperZoneKind;
    property LowerZoneKind: IDMElement read Get_LowerZoneKind;
    property DefaultBottomBoundaryKind: IDMElement read Get_DefaultBottomBoundaryKind;
    property DefaultTopBoundaryKind: IDMElement read Get_DefaultTopBoundaryKind;
  end;

// *********************************************************************//
// DispIntf:  IZoneKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECA8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IZoneKindDisp = dispinterface
    ['{1723ECA8-5ECB-11D5-845E-8BDDD017430C}']
    property PedestrialMovementVelocity: Double readonly dispid 1;
    property CarMovementEnabled: WordBool readonly dispid 2;
    property AirMovementEnabled: WordBool readonly dispid 3;
    property WaterMovementEnabled: WordBool readonly dispid 4;
    property UnderWaterMovementEnabled: WordBool readonly dispid 5;
    property RoadCover: Integer readonly dispid 6;
    property DefaultCategory: Integer readonly dispid 7;
    property DefaultTransparencyDist: Double readonly dispid 8;
    property DefaultSideBoundaryKind: IDMElement readonly dispid 9;
    property VSubZoneKind: IDMElement readonly dispid 10;
    property HSubZoneKind: IDMElement readonly dispid 11;
    property SpecialKind: Integer readonly dispid 12;
    property UpperZoneKind: IDMElement readonly dispid 13;
    property LowerZoneKind: IDMElement readonly dispid 14;
    property DefaultBottomBoundaryKind: IDMElement readonly dispid 15;
    property DefaultTopBoundaryKind: IDMElement readonly dispid 16;
  end;

// *********************************************************************//
// Interface: IBoundaryType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECAA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBoundaryType = interface(IUnknown)
    ['{1723ECAA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IBoundaryTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECAA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBoundaryTypeDisp = dispinterface
    ['{1723ECAA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IBoundaryKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECAC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBoundaryKind = interface(IUnknown)
    ['{1723ECAC-5ECB-11D5-845E-8BDDD017430C}']
    function Get_BoundaryLayerTypes: IDMCollection; safecall;
    function Get_PathKind: Integer; safecall;
    function Get_HighPath: WordBool; safecall;
    function Get_DontCross: WordBool; safecall;
    function Get_Orientation: Integer; safecall;
    function Get_DefaultBottomEdgeHeight: Double; safecall;
    property BoundaryLayerTypes: IDMCollection read Get_BoundaryLayerTypes;
    property PathKind: Integer read Get_PathKind;
    property HighPath: WordBool read Get_HighPath;
    property DontCross: WordBool read Get_DontCross;
    property Orientation: Integer read Get_Orientation;
    property DefaultBottomEdgeHeight: Double read Get_DefaultBottomEdgeHeight;
  end;

// *********************************************************************//
// DispIntf:  IBoundaryKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECAC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBoundaryKindDisp = dispinterface
    ['{1723ECAC-5ECB-11D5-845E-8BDDD017430C}']
    property BoundaryLayerTypes: IDMCollection readonly dispid 1;
    property PathKind: Integer readonly dispid 3;
    property HighPath: WordBool readonly dispid 4;
    property DontCross: WordBool readonly dispid 5;
    property Orientation: Integer readonly dispid 2;
    property DefaultBottomEdgeHeight: Double readonly dispid 6;
  end;

// *********************************************************************//
// Interface: IBoundaryLayerType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECAE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBoundaryLayerType = interface(IUnknown)
    ['{1723ECAE-5ECB-11D5-845E-8BDDD017430C}']
    function Get_Tactics: IDMCollection; safecall;
    function Get_DefaultHeight: Double; safecall;
    function Get_IsZone: WordBool; safecall;
    function Get_AlwaysShowImage: WordBool; safecall;
    function Get_SubBoundaryKinds: IDMCollection; safecall;
    property Tactics: IDMCollection read Get_Tactics;
    property DefaultHeight: Double read Get_DefaultHeight;
    property IsZone: WordBool read Get_IsZone;
    property AlwaysShowImage: WordBool read Get_AlwaysShowImage;
    property SubBoundaryKinds: IDMCollection read Get_SubBoundaryKinds;
  end;

// *********************************************************************//
// DispIntf:  IBoundaryLayerTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECAE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBoundaryLayerTypeDisp = dispinterface
    ['{1723ECAE-5ECB-11D5-845E-8BDDD017430C}']
    property Tactics: IDMCollection readonly dispid 3;
    property DefaultHeight: Double readonly dispid 1;
    property IsZone: WordBool readonly dispid 2;
    property AlwaysShowImage: WordBool readonly dispid 4;
    property SubBoundaryKinds: IDMCollection readonly dispid 5;
  end;

// *********************************************************************//
// Interface: IBarrierType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECB2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierType = interface(IUnknown)
    ['{1723ECB2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECB2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierTypeDisp = dispinterface
    ['{1723ECB2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IBarrierKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECB4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierKind = interface(IUnknown)
    ['{1723ECB4-5ECB-11D5-845E-8BDDD017430C}']
    function Get_Ec: Double; safecall;
    function Get_IsTransparent: WordBool; safecall;
    function Get_SoundResistance: Double; safecall;
    function Get_IsFragile: WordBool; safecall;
    function Get_DefaultWidth: Double; safecall;
    function Get_ContainLock: WordBool; safecall;
    function Get_UseElevation: WordBool; safecall;
    function Get_Texture: ITexture; safecall;
    property Ec: Double read Get_Ec;
    property IsTransparent: WordBool read Get_IsTransparent;
    property SoundResistance: Double read Get_SoundResistance;
    property IsFragile: WordBool read Get_IsFragile;
    property DefaultWidth: Double read Get_DefaultWidth;
    property ContainLock: WordBool read Get_ContainLock;
    property UseElevation: WordBool read Get_UseElevation;
    property Texture: ITexture read Get_Texture;
  end;

// *********************************************************************//
// DispIntf:  IBarrierKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECB4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierKindDisp = dispinterface
    ['{1723ECB4-5ECB-11D5-845E-8BDDD017430C}']
    property Ec: Double readonly dispid 1;
    property IsTransparent: WordBool readonly dispid 2;
    property SoundResistance: Double readonly dispid 3;
    property IsFragile: WordBool readonly dispid 4;
    property DefaultWidth: Double readonly dispid 5;
    property ContainLock: WordBool readonly dispid 6;
    property UseElevation: WordBool readonly dispid 7;
    property Texture: ITexture readonly dispid 8;
  end;

// *********************************************************************//
// Interface: ILockType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECB6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILockType = interface(IUnknown)
    ['{1723ECB6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILockTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECB6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILockTypeDisp = dispinterface
    ['{1723ECB6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILockKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECB8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILockKind = interface(IUnknown)
    ['{1723ECB8-5ECB-11D5-845E-8BDDD017430C}']
    function Get_ForceEc: Double; safecall;
    function Get_CriminalEc: Double; safecall;
    function Get_OpeningTime: Double; safecall;
    function Get_AccessControl: WordBool; safecall;
    property ForceEc: Double read Get_ForceEc;
    property CriminalEc: Double read Get_CriminalEc;
    property OpeningTime: Double read Get_OpeningTime;
    property AccessControl: WordBool read Get_AccessControl;
  end;

// *********************************************************************//
// DispIntf:  ILockKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECB8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILockKindDisp = dispinterface
    ['{1723ECB8-5ECB-11D5-845E-8BDDD017430C}']
    property ForceEc: Double readonly dispid 1;
    property CriminalEc: Double readonly dispid 2;
    property OpeningTime: Double readonly dispid 3;
    property AccessControl: WordBool readonly dispid 4;
  end;

// *********************************************************************//
// Interface: IUndergroundObstacleType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECBA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IUndergroundObstacleType = interface(IUnknown)
    ['{1723ECBA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IUndergroundObstacleTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECBA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IUndergroundObstacleTypeDisp = dispinterface
    ['{1723ECBA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IUndergroundObstacleKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECBC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IUndergroundObstacleKind = interface(IUnknown)
    ['{1723ECBC-5ECB-11D5-845E-8BDDD017430C}']
    function Get_DefaultMineDepth: Double; safecall;
    function Get_GroundType: Integer; safecall;
    property DefaultMineDepth: Double read Get_DefaultMineDepth;
    property GroundType: Integer read Get_GroundType;
  end;

// *********************************************************************//
// DispIntf:  IUndergroundObstacleKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECBC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IUndergroundObstacleKindDisp = dispinterface
    ['{1723ECBC-5ECB-11D5-845E-8BDDD017430C}']
    property DefaultMineDepth: Double readonly dispid 1;
    property GroundType: Integer readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ISurfaceSensorType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECBE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISurfaceSensorType = interface(IUnknown)
    ['{1723ECBE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISurfaceSensorTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECBE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISurfaceSensorTypeDisp = dispinterface
    ['{1723ECBE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISurfaceSensorKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISurfaceSensorKind = interface(IUnknown)
    ['{1723ECC0-5ECB-11D5-845E-8BDDD017430C}']
    function Get_ContactSensible: WordBool; safecall;
    property ContactSensible: WordBool read Get_ContactSensible;
  end;

// *********************************************************************//
// DispIntf:  ISurfaceSensorKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISurfaceSensorKindDisp = dispinterface
    ['{1723ECC0-5ECB-11D5-845E-8BDDD017430C}']
    property ContactSensible: WordBool readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IPositionSensorType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPositionSensorType = interface(IUnknown)
    ['{1723ECC2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPositionSensorTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPositionSensorTypeDisp = dispinterface
    ['{1723ECC2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPositionSensorKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPositionSensorKind = interface(IUnknown)
    ['{1723ECC4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPositionSensorKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPositionSensorKindDisp = dispinterface
    ['{1723ECC4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IVolumeSensorType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVolumeSensorType = interface(IUnknown)
    ['{1723ECC6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IVolumeSensorTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVolumeSensorTypeDisp = dispinterface
    ['{1723ECC6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IVolumeSensorKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVolumeSensorKind = interface(IUnknown)
    ['{1723ECC8-5ECB-11D5-845E-8BDDD017430C}']
    function Get_DetectionZoneImage: IElementImage; safecall;
    function Get_DetectionZoneHeight: Double; safecall;
    function Get_DetectionZoneWidth: Double; safecall;
    function Get_DetectionZoneLength: Double; safecall;
    function Get_DetectionZoneForm: Integer; safecall;
    function Get_DefaultElevation: Double; safecall;
    function Get_DetectionOnBoundary: WordBool; safecall;
    property DetectionZoneImage: IElementImage read Get_DetectionZoneImage;
    property DetectionZoneHeight: Double read Get_DetectionZoneHeight;
    property DetectionZoneWidth: Double read Get_DetectionZoneWidth;
    property DetectionZoneLength: Double read Get_DetectionZoneLength;
    property DetectionZoneForm: Integer read Get_DetectionZoneForm;
    property DefaultElevation: Double read Get_DefaultElevation;
    property DetectionOnBoundary: WordBool read Get_DetectionOnBoundary;
  end;

// *********************************************************************//
// DispIntf:  IVolumeSensorKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECC8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVolumeSensorKindDisp = dispinterface
    ['{1723ECC8-5ECB-11D5-845E-8BDDD017430C}']
    property DetectionZoneImage: IElementImage readonly dispid 1;
    property DetectionZoneHeight: Double readonly dispid 2;
    property DetectionZoneWidth: Double readonly dispid 3;
    property DetectionZoneLength: Double readonly dispid 4;
    property DetectionZoneForm: Integer readonly dispid 5;
    property DefaultElevation: Double readonly dispid 6;
    property DetectionOnBoundary: WordBool readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IBarrierSensorType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECCA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierSensorType = interface(IUnknown)
    ['{1723ECCA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierSensorTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECCA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierSensorTypeDisp = dispinterface
    ['{1723ECCA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IBarrierSensorKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECCC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierSensorKind = interface(IUnknown)
    ['{1723ECCC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierSensorKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECCC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierSensorKindDisp = dispinterface
    ['{1723ECCC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IContrabandSensorType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECCE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IContrabandSensorType = interface(IUnknown)
    ['{1723ECCE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IContrabandSensorTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECCE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IContrabandSensorTypeDisp = dispinterface
    ['{1723ECCE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IContrabandSensorKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IContrabandSensorKind = interface(IUnknown)
    ['{1723ECD0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IContrabandSensorKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IContrabandSensorKindDisp = dispinterface
    ['{1723ECD0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IAccessControlType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAccessControlType = interface(IUnknown)
    ['{1723ECD2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IAccessControlTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAccessControlTypeDisp = dispinterface
    ['{1723ECD2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IAccessControlKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAccessControlKind = interface(IUnknown)
    ['{1723ECD4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IAccessControlKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAccessControlKindDisp = dispinterface
    ['{1723ECD4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ITVCameraType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITVCameraType = interface(IUnknown)
    ['{1723ECD6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ITVCameraTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITVCameraTypeDisp = dispinterface
    ['{1723ECD6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ITVCameraKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITVCameraKind = interface(IUnknown)
    ['{1723ECD8-5ECB-11D5-845E-8BDDD017430C}']
    function Get_ViewLength: Double; safecall;
    function Get_ViewAngle: Double; safecall;
    property ViewLength: Double read Get_ViewLength;
    property ViewAngle: Double read Get_ViewAngle;
  end;

// *********************************************************************//
// DispIntf:  ITVCameraKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECD8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITVCameraKindDisp = dispinterface
    ['{1723ECD8-5ECB-11D5-845E-8BDDD017430C}']
    property ViewLength: Double readonly dispid 1;
    property ViewAngle: Double readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ILightDeviceType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECDA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILightDeviceType = interface(IUnknown)
    ['{1723ECDA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILightDeviceTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECDA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILightDeviceTypeDisp = dispinterface
    ['{1723ECDA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILightDeviceKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECDC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILightDeviceKind = interface(IUnknown)
    ['{1723ECDC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILightDeviceKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECDC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILightDeviceKindDisp = dispinterface
    ['{1723ECDC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ICommunicationDeviceType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECDE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICommunicationDeviceType = interface(IUnknown)
    ['{1723ECDE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ICommunicationDeviceTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECDE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICommunicationDeviceTypeDisp = dispinterface
    ['{1723ECDE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ICommunicationDeviceKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICommunicationDeviceKind = interface(IUnknown)
    ['{1723ECE0-5ECB-11D5-845E-8BDDD017430C}']
    function Get_Duplex: WordBool; safecall;
    function Get_ConnectionTime: Double; safecall;
    property Duplex: WordBool read Get_Duplex;
    property ConnectionTime: Double read Get_ConnectionTime;
  end;

// *********************************************************************//
// DispIntf:  ICommunicationDeviceKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICommunicationDeviceKindDisp = dispinterface
    ['{1723ECE0-5ECB-11D5-845E-8BDDD017430C}']
    property Duplex: WordBool readonly dispid 1;
    property ConnectionTime: Double readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IPowerSourceType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPowerSourceType = interface(IUnknown)
    ['{1723ECE2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPowerSourceTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPowerSourceTypeDisp = dispinterface
    ['{1723ECE2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPowerSourceKInd
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPowerSourceKInd = interface(IUnknown)
    ['{1723ECE4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPowerSourceKIndDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPowerSourceKIndDisp = dispinterface
    ['{1723ECE4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ICabelType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICabelType = interface(IUnknown)
    ['{1723ECE6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ICabelTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICabelTypeDisp = dispinterface
    ['{1723ECE6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ICabelKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICabelKind = interface(IUnknown)
    ['{1723ECE8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ICabelKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECE8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICabelKindDisp = dispinterface
    ['{1723ECE8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPatrolType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECEA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPatrolType = interface(IUnknown)
    ['{1723ECEA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPatrolTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECEA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPatrolTypeDisp = dispinterface
    ['{1723ECEA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPatrolKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECEC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPatrolKind = interface(IUnknown)
    ['{1723ECEC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPatrolKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECEC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPatrolKindDisp = dispinterface
    ['{1723ECEC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IGuardPostType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECEE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardPostType = interface(IUnknown)
    ['{1723ECEE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IGuardPostTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECEE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardPostTypeDisp = dispinterface
    ['{1723ECEE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IGuardPostKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardPostKind = interface(IUnknown)
    ['{1723ECF0-5ECB-11D5-845E-8BDDD017430C}']
    function Get_DefenceLevel: Integer; safecall;
    function Get_OpenedDefenceState: Integer; safecall;
    function Get_HidedDefenceState: Integer; safecall;
    property DefenceLevel: Integer read Get_DefenceLevel;
    property OpenedDefenceState: Integer read Get_OpenedDefenceState;
    property HidedDefenceState: Integer read Get_HidedDefenceState;
  end;

// *********************************************************************//
// DispIntf:  IGuardPostKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardPostKindDisp = dispinterface
    ['{1723ECF0-5ECB-11D5-845E-8BDDD017430C}']
    property DefenceLevel: Integer readonly dispid 1;
    property OpenedDefenceState: Integer readonly dispid 2;
    property HidedDefenceState: Integer readonly dispid 3;
  end;

// *********************************************************************//
// Interface: ITargetType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITargetType = interface(IUnknown)
    ['{1723ECF2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ITargetTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITargetTypeDisp = dispinterface
    ['{1723ECF2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ITargetKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITargetKind = interface(IUnknown)
    ['{1723ECF4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ITargetKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITargetKindDisp = dispinterface
    ['{1723ECF4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IConveyanceType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceType = interface(IUnknown)
    ['{1723ECF6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IConveyanceTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceTypeDisp = dispinterface
    ['{1723ECF6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IConveyanceKInd
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceKInd = interface(IUnknown)
    ['{1723ECF8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IConveyanceKIndDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECF8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceKIndDisp = dispinterface
    ['{1723ECF8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IConveyanceSegmentType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECFA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceSegmentType = interface(IUnknown)
    ['{1723ECFA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IConveyanceSegmentTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECFA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceSegmentTypeDisp = dispinterface
    ['{1723ECFA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IConveyanceSegmentKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECFC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceSegmentKind = interface(IUnknown)
    ['{1723ECFC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IConveyanceSegmentKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECFC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceSegmentKindDisp = dispinterface
    ['{1723ECFC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILocalPointObjectType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECFE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalPointObjectType = interface(IUnknown)
    ['{1723ECFE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILocalPointObjectTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ECFE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalPointObjectTypeDisp = dispinterface
    ['{1723ECFE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILocalPointObjectKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED00-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalPointObjectKind = interface(IUnknown)
    ['{1723ED00-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILocalPointObjectKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED00-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalPointObjectKindDisp = dispinterface
    ['{1723ED00-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IJumpType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED02-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IJumpType = interface(IUnknown)
    ['{1723ED02-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IJumpTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED02-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IJumpTypeDisp = dispinterface
    ['{1723ED02-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IJumpKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED04-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IJumpKind = interface(IUnknown)
    ['{1723ED04-5ECB-11D5-845E-8BDDD017430C}']
    function Get_ClimbUpVelocity: Double; safecall;
    function Get_ClimbDownVelocity: Double; safecall;
    function Get_BoundaryLayerTypes: IDMCollection; safecall;
    function Get_Default: Integer; safecall;
    property ClimbUpVelocity: Double read Get_ClimbUpVelocity;
    property ClimbDownVelocity: Double read Get_ClimbDownVelocity;
    property BoundaryLayerTypes: IDMCollection read Get_BoundaryLayerTypes;
    property Default: Integer read Get_Default;
  end;

// *********************************************************************//
// DispIntf:  IJumpKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED04-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IJumpKindDisp = dispinterface
    ['{1723ED04-5ECB-11D5-845E-8BDDD017430C}']
    property ClimbUpVelocity: Double readonly dispid 1;
    property ClimbDownVelocity: Double readonly dispid 2;
    property BoundaryLayerTypes: IDMCollection readonly dispid 3;
    property Default: Integer readonly dispid 4;
  end;

// *********************************************************************//
// Interface: IGuardCharacteristicType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED08-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardCharacteristicType = interface(IUnknown)
    ['{1723ED08-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IGuardCharacteristicTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED08-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardCharacteristicTypeDisp = dispinterface
    ['{1723ED08-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IGuardCharacteristicKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED0A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardCharacteristicKind = interface(IUnknown)
    ['{1723ED0A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IGuardCharacteristicKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED0A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardCharacteristicKindDisp = dispinterface
    ['{1723ED0A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IOvercomeMethod
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED0C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IOvercomeMethod = interface(IUnknown)
    ['{1723ED0C-5ECB-11D5-845E-8BDDD017430C}']
    function Get_PhysicalFields: IDMCollection; safecall;
    function Get_PhysicalFieldValue(Index: Integer): Double; safecall;
    procedure Set_PhysicalFieldValue(Index: Integer; Value: Double); safecall;
    function Get_DeviceStates: IDMCollection; safecall;
    function Get_ToolTypes: IDMCollection; safecall;
    function Get_VehicleTypes: IDMCollection; safecall;
    function Get_WeaponTypes: IDMCollection; safecall;
    function Get_AthorityTypes: IDMCollection; safecall;
    function Get_DelayProcCode: Integer; safecall;
    function Get_ProbabilityProcCode: Integer; safecall;
    function Get_FieldsProcCode: Integer; safecall;
    function Get_SkillTypes: IDMCollection; safecall;
    function GetDelayTime(const WarriorGroupU: IUnknown; const FacilityStateU: IUnknown; 
                          const LineU: IUnknown; const SafeguardElementU: IUnknown; 
                          const Report: IDMText): Double; safecall;
    function GetDetectionProbability(const WarriorGroupU: IUnknown; const FacilityStateU: IUnknown; 
                                     const LineU: IUnknown; const SafeguardElementU: IUnknown; 
                                     const Report: IDMText): Double; safecall;
    procedure CalcPhysicalFields(const WarriorGroupU: IUnknown; const FacilityStateU: IUnknown; 
                                 const LineU: IUnknown; const SafeguardElementU: IUnknown); safecall;
    function Get_Tactics: IDMCollection; safecall;
    function AcceptableForTactic(const TacticU: IUnknown): WordBool; safecall;
    function GetValueFromMatrix(const WarriorGroupU: IUnknown; const SafeguardElementU: IUnknown; 
                                const LineU: IUnknown; Time: Double; ValueKind: Integer; 
                                const Report: IDMText): Double; safecall;
    function Get_Failure: WordBool; safecall;
    function Get_Evidence: WordBool; safecall;
    function Get_ObserverParam: WordBool; safecall;
    function GetValueByCodeFromMatrix(const WarriorGroupU: IUnknown; 
                                      const SafeguardElementU: IUnknown; const LineU: IUnknown; 
                                      Time: Double; ValueKind: Integer; const Report: IDMText): Double; safecall;
    function Get_AssessRequired: WordBool; safecall;
    function Get_Destructive: WordBool; safecall;
    function Get_DependsOnReliability: WordBool; safecall;
    property PhysicalFields: IDMCollection read Get_PhysicalFields;
    property PhysicalFieldValue[Index: Integer]: Double read Get_PhysicalFieldValue write Set_PhysicalFieldValue;
    property DeviceStates: IDMCollection read Get_DeviceStates;
    property ToolTypes: IDMCollection read Get_ToolTypes;
    property VehicleTypes: IDMCollection read Get_VehicleTypes;
    property WeaponTypes: IDMCollection read Get_WeaponTypes;
    property AthorityTypes: IDMCollection read Get_AthorityTypes;
    property DelayProcCode: Integer read Get_DelayProcCode;
    property ProbabilityProcCode: Integer read Get_ProbabilityProcCode;
    property FieldsProcCode: Integer read Get_FieldsProcCode;
    property SkillTypes: IDMCollection read Get_SkillTypes;
    property Tactics: IDMCollection read Get_Tactics;
    property Failure: WordBool read Get_Failure;
    property Evidence: WordBool read Get_Evidence;
    property ObserverParam: WordBool read Get_ObserverParam;
    property AssessRequired: WordBool read Get_AssessRequired;
    property Destructive: WordBool read Get_Destructive;
    property DependsOnReliability: WordBool read Get_DependsOnReliability;
  end;

// *********************************************************************//
// DispIntf:  IOvercomeMethodDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED0C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IOvercomeMethodDisp = dispinterface
    ['{1723ED0C-5ECB-11D5-845E-8BDDD017430C}']
    property PhysicalFields: IDMCollection readonly dispid 2;
    property PhysicalFieldValue[Index: Integer]: Double dispid 6;
    property DeviceStates: IDMCollection readonly dispid 5;
    property ToolTypes: IDMCollection readonly dispid 8;
    property VehicleTypes: IDMCollection readonly dispid 9;
    property WeaponTypes: IDMCollection readonly dispid 10;
    property AthorityTypes: IDMCollection readonly dispid 12;
    property DelayProcCode: Integer readonly dispid 3;
    property ProbabilityProcCode: Integer readonly dispid 11;
    property FieldsProcCode: Integer readonly dispid 13;
    property SkillTypes: IDMCollection readonly dispid 15;
    function GetDelayTime(const WarriorGroupU: IUnknown; const FacilityStateU: IUnknown; 
                          const LineU: IUnknown; const SafeguardElementU: IUnknown; 
                          const Report: IDMText): Double; dispid 16;
    function GetDetectionProbability(const WarriorGroupU: IUnknown; const FacilityStateU: IUnknown; 
                                     const LineU: IUnknown; const SafeguardElementU: IUnknown; 
                                     const Report: IDMText): Double; dispid 17;
    procedure CalcPhysicalFields(const WarriorGroupU: IUnknown; const FacilityStateU: IUnknown; 
                                 const LineU: IUnknown; const SafeguardElementU: IUnknown); dispid 18;
    property Tactics: IDMCollection readonly dispid 19;
    function AcceptableForTactic(const TacticU: IUnknown): WordBool; dispid 20;
    function GetValueFromMatrix(const WarriorGroupU: IUnknown; const SafeguardElementU: IUnknown; 
                                const LineU: IUnknown; Time: Double; ValueKind: Integer; 
                                const Report: IDMText): Double; dispid 1;
    property Failure: WordBool readonly dispid 4;
    property Evidence: WordBool readonly dispid 7;
    property ObserverParam: WordBool readonly dispid 14;
    function GetValueByCodeFromMatrix(const WarriorGroupU: IUnknown; 
                                      const SafeguardElementU: IUnknown; const LineU: IUnknown; 
                                      Time: Double; ValueKind: Integer; const Report: IDMText): Double; dispid 21;
    property AssessRequired: WordBool readonly dispid 22;
    property Destructive: WordBool readonly dispid 24;
    property DependsOnReliability: WordBool readonly dispid 23;
  end;

// *********************************************************************//
// Interface: IWeaponType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED0E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeaponType = interface(IUnknown)
    ['{1723ED0E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IWeaponTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED0E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeaponTypeDisp = dispinterface
    ['{1723ED0E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IWeaponKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED10-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeaponKind = interface(IUnknown)
    ['{1723ED10-5ECB-11D5-845E-8BDDD017430C}']
    function Get_ShotForce: SYSINT; safecall;
    function GetScoreProbability(Distance: Double; State: Integer; AimState: Integer): Double; safecall;
    function Get_MaxShotDistance: Double; safecall;
    function Get_ShotRate: Double; safecall;
    function Get_CartridgeCountPerHit: Integer; safecall;
    function Get_PreciseShotDistance: Double; safecall;
    function Get_GroupDamage: WordBool; safecall;
    function Get_MaxLength: Double; safecall;
    function Get_Mass: Double; safecall;
    function Get_HasMetall: WordBool; safecall;
    function Get_SoundPower: Double; safecall;
    function Get_ShotBreachRecs: IUnknown; safecall;
    property ShotForce: SYSINT read Get_ShotForce;
    property MaxShotDistance: Double read Get_MaxShotDistance;
    property ShotRate: Double read Get_ShotRate;
    property CartridgeCountPerHit: Integer read Get_CartridgeCountPerHit;
    property PreciseShotDistance: Double read Get_PreciseShotDistance;
    property GroupDamage: WordBool read Get_GroupDamage;
    property MaxLength: Double read Get_MaxLength;
    property Mass: Double read Get_Mass;
    property HasMetall: WordBool read Get_HasMetall;
    property SoundPower: Double read Get_SoundPower;
    property ShotBreachRecs: IUnknown read Get_ShotBreachRecs;
  end;

// *********************************************************************//
// DispIntf:  IWeaponKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED10-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeaponKindDisp = dispinterface
    ['{1723ED10-5ECB-11D5-845E-8BDDD017430C}']
    property ShotForce: SYSINT readonly dispid 1;
    function GetScoreProbability(Distance: Double; State: Integer; AimState: Integer): Double; dispid 2;
    property MaxShotDistance: Double readonly dispid 3;
    property ShotRate: Double readonly dispid 4;
    property CartridgeCountPerHit: Integer readonly dispid 5;
    property PreciseShotDistance: Double readonly dispid 6;
    property GroupDamage: WordBool readonly dispid 7;
    property MaxLength: Double readonly dispid 8;
    property Mass: Double readonly dispid 9;
    property HasMetall: WordBool readonly dispid 10;
    property SoundPower: Double readonly dispid 11;
    property ShotBreachRecs: IUnknown readonly dispid 12;
  end;

// *********************************************************************//
// Interface: IToolType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED12-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IToolType = interface(IUnknown)
    ['{1723ED12-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IToolTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED12-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IToolTypeDisp = dispinterface
    ['{1723ED12-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IToolKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED14-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IToolKind = interface(IUnknown)
    ['{1723ED14-5ECB-11D5-845E-8BDDD017430C}']
    function Get_BaseEc: Double; safecall;
    function Get_CoeffEc: Double; safecall;
    function Get_HasMetall: WordBool; safecall;
    function Get_Mass: Double; safecall;
    function Get_MaxLength: Double; safecall;
    function Get_SoundPower: Double; safecall;
    function Get_Kind: Integer; safecall;
    property BaseEc: Double read Get_BaseEc;
    property CoeffEc: Double read Get_CoeffEc;
    property HasMetall: WordBool read Get_HasMetall;
    property Mass: Double read Get_Mass;
    property MaxLength: Double read Get_MaxLength;
    property SoundPower: Double read Get_SoundPower;
    property Kind: Integer read Get_Kind;
  end;

// *********************************************************************//
// DispIntf:  IToolKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED14-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IToolKindDisp = dispinterface
    ['{1723ED14-5ECB-11D5-845E-8BDDD017430C}']
    property BaseEc: Double readonly dispid 1;
    property CoeffEc: Double readonly dispid 2;
    property HasMetall: WordBool readonly dispid 3;
    property Mass: Double readonly dispid 4;
    property MaxLength: Double readonly dispid 5;
    property SoundPower: Double readonly dispid 6;
    property Kind: Integer readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IVehicleType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED16-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVehicleType = interface(IUnknown)
    ['{1723ED16-5ECB-11D5-845E-8BDDD017430C}']
    function Get_TypeCode: Integer; safecall;
    property TypeCode: Integer read Get_TypeCode;
  end;

// *********************************************************************//
// DispIntf:  IVehicleTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED16-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVehicleTypeDisp = dispinterface
    ['{1723ED16-5ECB-11D5-845E-8BDDD017430C}']
    property TypeCode: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IVehicleKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED18-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVehicleKind = interface(IUnknown)
    ['{1723ED18-5ECB-11D5-845E-8BDDD017430C}']
    function GetVelocity(const ZoneKind: IZoneKind): Double; safecall;
    function Get_Velocity1: Double; safecall;
    function Get_Velocity2: Double; safecall;
    function Get_Velocity3: Double; safecall;
    function Get_DefenceLevel: SYSINT; safecall;
    function Get_WeaponKinds: IDMCollection; safecall;
    property Velocity1: Double read Get_Velocity1;
    property Velocity2: Double read Get_Velocity2;
    property Velocity3: Double read Get_Velocity3;
    property DefenceLevel: SYSINT read Get_DefenceLevel;
    property WeaponKinds: IDMCollection read Get_WeaponKinds;
  end;

// *********************************************************************//
// DispIntf:  IVehicleKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED18-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVehicleKindDisp = dispinterface
    ['{1723ED18-5ECB-11D5-845E-8BDDD017430C}']
    function GetVelocity(const ZoneKind: IZoneKind): Double; dispid 1;
    property Velocity1: Double readonly dispid 2;
    property Velocity2: Double readonly dispid 3;
    property Velocity3: Double readonly dispid 4;
    property DefenceLevel: SYSINT readonly dispid 5;
    property WeaponKinds: IDMCollection readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IAthorityType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED1C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAthorityType = interface(IUnknown)
    ['{1723ED1C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IAthorityTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED1C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAthorityTypeDisp = dispinterface
    ['{1723ED1C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISkillType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED1E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISkillType = interface(IUnknown)
    ['{1723ED1E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISkillTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED1E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISkillTypeDisp = dispinterface
    ['{1723ED1E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPhysicalField
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED22-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPhysicalField = interface(IUnknown)
    ['{1723ED22-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPhysicalFieldDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED22-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPhysicalFieldDisp = dispinterface
    ['{1723ED22-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IDeviceFunction
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED24-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDeviceFunction = interface(IUnknown)
    ['{1723ED24-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IDeviceFunctionDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED24-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDeviceFunctionDisp = dispinterface
    ['{1723ED24-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IDeviceState
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED26-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDeviceState = interface(IUnknown)
    ['{1723ED26-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IDeviceStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED26-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDeviceStateDisp = dispinterface
    ['{1723ED26-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IHindrance
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED28-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IHindrance = interface(IUnknown)
    ['{1723ED28-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IHindranceDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED28-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IHindranceDisp = dispinterface
    ['{1723ED28-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IWeather
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED2A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeather = interface(IUnknown)
    ['{1723ED2A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IWeatherDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED2A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeatherDisp = dispinterface
    ['{1723ED2A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISGDBParameter
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED2C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISGDBParameter = interface(IUnknown)
    ['{1723ED2C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISGDBParameterDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED2C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISGDBParameterDisp = dispinterface
    ['{1723ED2C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISGDBParameterValue
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED2E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISGDBParameterValue = interface(IUnknown)
    ['{1723ED2E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISGDBParameterValueDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED2E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISGDBParameterValueDisp = dispinterface
    ['{1723ED2E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IShotDispersionRec
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED30-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IShotDispersionRec = interface(IUnknown)
    ['{1723ED30-5ECB-11D5-845E-8BDDD017430C}']
    function Get_Distance: Double; safecall;
    function Get_CartridgeCountPerScore_Still_Head: Integer; safecall;
    function Get_CartridgeCountPerScore_Still_Chest: Integer; safecall;
    function Get_CartridgeCountPerScore_Still_Half: Integer; safecall;
    function Get_CartridgeCountPerScore_Still_Full: Integer; safecall;
    function Get_CartridgeCountPerScore_Still_Run: Integer; safecall;
    function Get_CartridgeCountPerScore_Run_Head: Integer; safecall;
    function Get_CartridgeCountPerScore_Run_Chest: Integer; safecall;
    function Get_CartridgeCountPerScore_Run_Half: Integer; safecall;
    function Get_CartridgeCountPerScore_Run_Full: Integer; safecall;
    function Get_CartridgeCountPerScore_Run_Run: Integer; safecall;
    function GetScoreProbability(State: Integer; AimState: Integer): Double; safecall;
    property Distance: Double read Get_Distance;
    property CartridgeCountPerScore_Still_Head: Integer read Get_CartridgeCountPerScore_Still_Head;
    property CartridgeCountPerScore_Still_Chest: Integer read Get_CartridgeCountPerScore_Still_Chest;
    property CartridgeCountPerScore_Still_Half: Integer read Get_CartridgeCountPerScore_Still_Half;
    property CartridgeCountPerScore_Still_Full: Integer read Get_CartridgeCountPerScore_Still_Full;
    property CartridgeCountPerScore_Still_Run: Integer read Get_CartridgeCountPerScore_Still_Run;
    property CartridgeCountPerScore_Run_Head: Integer read Get_CartridgeCountPerScore_Run_Head;
    property CartridgeCountPerScore_Run_Chest: Integer read Get_CartridgeCountPerScore_Run_Chest;
    property CartridgeCountPerScore_Run_Half: Integer read Get_CartridgeCountPerScore_Run_Half;
    property CartridgeCountPerScore_Run_Full: Integer read Get_CartridgeCountPerScore_Run_Full;
    property CartridgeCountPerScore_Run_Run: Integer read Get_CartridgeCountPerScore_Run_Run;
  end;

// *********************************************************************//
// DispIntf:  IShotDispersionRecDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED30-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IShotDispersionRecDisp = dispinterface
    ['{1723ED30-5ECB-11D5-845E-8BDDD017430C}']
    property Distance: Double readonly dispid 1;
    property CartridgeCountPerScore_Still_Head: Integer readonly dispid 6;
    property CartridgeCountPerScore_Still_Chest: Integer readonly dispid 7;
    property CartridgeCountPerScore_Still_Half: Integer readonly dispid 8;
    property CartridgeCountPerScore_Still_Full: Integer readonly dispid 9;
    property CartridgeCountPerScore_Still_Run: Integer readonly dispid 10;
    property CartridgeCountPerScore_Run_Head: Integer readonly dispid 11;
    property CartridgeCountPerScore_Run_Chest: Integer readonly dispid 12;
    property CartridgeCountPerScore_Run_Half: Integer readonly dispid 13;
    property CartridgeCountPerScore_Run_Full: Integer readonly dispid 14;
    property CartridgeCountPerScore_Run_Run: Integer readonly dispid 15;
    function GetScoreProbability(State: Integer; AimState: Integer): Double; dispid 17;
  end;

// *********************************************************************//
// Interface: IElementImage
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED34-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IElementImage = interface(IUnknown)
    ['{1723ED34-5ECB-11D5-845E-8BDDD017430C}']
    function Get_ScalingType: Integer; safecall;
    function Get_XSize: Double; safecall;
    function Get_YSize: Double; safecall;
    function Get_ZSize: Double; safecall;
    function Get_MinPixels: Integer; safecall;
    function Get_MaxSize: Double; safecall;
    property ScalingType: Integer read Get_ScalingType;
    property XSize: Double read Get_XSize;
    property YSize: Double read Get_YSize;
    property ZSize: Double read Get_ZSize;
    property MinPixels: Integer read Get_MinPixels;
    property MaxSize: Double read Get_MaxSize;
  end;

// *********************************************************************//
// DispIntf:  IElementImageDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED34-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IElementImageDisp = dispinterface
    ['{1723ED34-5ECB-11D5-845E-8BDDD017430C}']
    property ScalingType: Integer readonly dispid 1;
    property XSize: Double readonly dispid 2;
    property YSize: Double readonly dispid 3;
    property ZSize: Double readonly dispid 4;
    property MinPixels: Integer readonly dispid 5;
    property MaxSize: Double readonly dispid 6;
  end;

// *********************************************************************//
// Interface: IStartPointType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED38-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStartPointType = interface(IUnknown)
    ['{1723ED38-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IStartPointTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED38-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStartPointTypeDisp = dispinterface
    ['{1723ED38-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IStartPointKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED3A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStartPointKind = interface(IUnknown)
    ['{1723ED3A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IStartPointKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED3A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStartPointKindDisp = dispinterface
    ['{1723ED3A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IActiveSafeguardType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED3C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IActiveSafeguardType = interface(IUnknown)
    ['{1723ED3C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IActiveSafeguardTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED3C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IActiveSafeguardTypeDisp = dispinterface
    ['{1723ED3C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IActiveSafeguardKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED3E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IActiveSafeguardKind = interface(IUnknown)
    ['{1723ED3E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IActiveSafeguardKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED3E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IActiveSafeguardKindDisp = dispinterface
    ['{1723ED3E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPerimeterSensorType
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED40-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPerimeterSensorType = interface(IUnknown)
    ['{1723ED40-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPerimeterSensorTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED40-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPerimeterSensorTypeDisp = dispinterface
    ['{1723ED40-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPerimeterSensorKind
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED42-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPerimeterSensorKind = interface(IUnknown)
    ['{1723ED42-5ECB-11D5-845E-8BDDD017430C}']
    function Get_Length: Double; safecall;
    function Get_ZoneWidth: Double; safecall;
    property Length: Double read Get_Length;
    property ZoneWidth: Double read Get_ZoneWidth;
  end;

// *********************************************************************//
// DispIntf:  IPerimeterSensorKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1723ED42-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPerimeterSensorKindDisp = dispinterface
    ['{1723ED42-5ECB-11D5-845E-8BDDD017430C}']
    property Length: Double readonly dispid 1;
    property ZoneWidth: Double readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IDataClassModel
// Flags:     (320) Dual OleAutomation
// GUID:      {4F005860-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IDataClassModel = interface(IUnknown)
    ['{4F005860-5F76-11D5-845E-FEE1D8DC510C}']
  end;

// *********************************************************************//
// DispIntf:  IDataClassModelDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4F005860-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IDataClassModelDisp = dispinterface
    ['{4F005860-5F76-11D5-845E-FEE1D8DC510C}']
  end;

// *********************************************************************//
// Interface: ISafeguardClass
// Flags:     (320) Dual OleAutomation
// GUID:      {4F005862-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  ISafeguardClass = interface(IUnknown)
    ['{4F005862-5F76-11D5-845E-FEE1D8DC510C}']
    function Get_TypeClassID: Integer; safecall;
    procedure Set_TypeClassID(Value: Integer); safecall;
    function CreateCollection: IDMCollection; safecall;
    function Get_SpatialElementKind: Integer; safecall;
    procedure Set_SpatialElementKind(Value: Integer); safecall;
    function Get_OptionalSpatialElement: WordBool; safecall;
    procedure Set_OptionalSpatialElement(Value: WordBool); safecall;
    property TypeClassID: Integer read Get_TypeClassID write Set_TypeClassID;
    property SpatialElementKind: Integer read Get_SpatialElementKind write Set_SpatialElementKind;
    property OptionalSpatialElement: WordBool read Get_OptionalSpatialElement write Set_OptionalSpatialElement;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardClassDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4F005862-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  ISafeguardClassDisp = dispinterface
    ['{4F005862-5F76-11D5-845E-FEE1D8DC510C}']
    property TypeClassID: Integer dispid 1;
    function CreateCollection: IDMCollection; dispid 3;
    property SpatialElementKind: Integer dispid 4;
    property OptionalSpatialElement: WordBool dispid 2;
  end;

// *********************************************************************//
// Interface: IWarriorAttributeKind
// Flags:     (320) Dual OleAutomation
// GUID:      {4F005864-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IWarriorAttributeKind = interface(IUnknown)
    ['{4F005864-5F76-11D5-845E-FEE1D8DC510C}']
    function Get_AttributeType: IWarriorAttributeType; safecall;
    function Get_IsDefault: WordBool; safecall;
    property AttributeType: IWarriorAttributeType read Get_AttributeType;
    property IsDefault: WordBool read Get_IsDefault;
  end;

// *********************************************************************//
// DispIntf:  IWarriorAttributeKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4F005864-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IWarriorAttributeKindDisp = dispinterface
    ['{4F005864-5F76-11D5-845E-FEE1D8DC510C}']
    property AttributeType: IWarriorAttributeType readonly dispid 1;
    property IsDefault: WordBool readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IModelElementKind
// Flags:     (320) Dual OleAutomation
// GUID:      {4F005868-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IModelElementKind = interface(IUnknown)
    ['{4F005868-5F76-11D5-845E-FEE1D8DC510C}']
    function Get_Comment: WideString; safecall;
    procedure Set_Comment(const Value: WideString); safecall;
    function Get_ParameterValues: IDMCollection; safecall;
    property Comment: WideString read Get_Comment write Set_Comment;
    property ParameterValues: IDMCollection read Get_ParameterValues;
  end;

// *********************************************************************//
// DispIntf:  IModelElementKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4F005868-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IModelElementKindDisp = dispinterface
    ['{4F005868-5F76-11D5-845E-FEE1D8DC510C}']
    property Comment: WideString dispid 1;
    property ParameterValues: IDMCollection readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IWarriorAttributeType
// Flags:     (320) Dual OleAutomation
// GUID:      {4F00586A-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IWarriorAttributeType = interface(IUnknown)
    ['{4F00586A-5F76-11D5-845E-FEE1D8DC510C}']
  end;

// *********************************************************************//
// DispIntf:  IWarriorAttributeTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4F00586A-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IWarriorAttributeTypeDisp = dispinterface
    ['{4F00586A-5F76-11D5-845E-FEE1D8DC510C}']
  end;

// *********************************************************************//
// Interface: IModelElementType
// Flags:     (320) Dual OleAutomation
// GUID:      {C2B21360-6053-11D5-845E-C202389DB00A}
// *********************************************************************//
  IModelElementType = interface(IUnknown)
    ['{C2B21360-6053-11D5-845E-C202389DB00A}']
    function Get_Parameters: IDMCollection; safecall;
    function Get_SubKinds: IDMCollection; safecall;
    function Get_TypeID: Integer; safecall;
    function Get_ElementParameters: IDMCollection; safecall;
    property Parameters: IDMCollection read Get_Parameters;
    property SubKinds: IDMCollection read Get_SubKinds;
    property TypeID: Integer read Get_TypeID;
    property ElementParameters: IDMCollection read Get_ElementParameters;
  end;

// *********************************************************************//
// DispIntf:  IModelElementTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {C2B21360-6053-11D5-845E-C202389DB00A}
// *********************************************************************//
  IModelElementTypeDisp = dispinterface
    ['{C2B21360-6053-11D5-845E-C202389DB00A}']
    property Parameters: IDMCollection readonly dispid 1;
    property SubKinds: IDMCollection readonly dispid 2;
    property TypeID: Integer readonly dispid 3;
    property ElementParameters: IDMCollection readonly dispid 4;
  end;

// *********************************************************************//
// Interface: ISafeguardElementTypes
// Flags:     (320) Dual OleAutomation
// GUID:      {B1CCF560-65D0-11D5-845E-CD5AD705670A}
// *********************************************************************//
  ISafeguardElementTypes = interface(IUnknown)
    ['{B1CCF560-65D0-11D5-845E-CD5AD705670A}']
    function Get_SafeguardClass: ISafeguardClass; safecall;
    procedure Set_SafeguardClass(const Value: ISafeguardClass); safecall;
    property SafeguardClass: ISafeguardClass read Get_SafeguardClass write Set_SafeguardClass;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardElementTypesDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {B1CCF560-65D0-11D5-845E-CD5AD705670A}
// *********************************************************************//
  ISafeguardElementTypesDisp = dispinterface
    ['{B1CCF560-65D0-11D5-845E-CD5AD705670A}']
    property SafeguardClass: ISafeguardClass dispid 1;
  end;

// *********************************************************************//
// Interface: ISafeguardElementType
// Flags:     (320) Dual OleAutomation
// GUID:      {62264B39-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISafeguardElementType = interface(IUnknown)
    ['{62264B39-E560-11D5-92FE-0050BA51A6D3}']
    function Get_DeviceStates: IDMCollection; safecall;
    function Get_OvercomeMethods: IDMCollection; safecall;
    function Get_CanDelay: WordBool; safecall;
    function Get_CanDetect: WordBool; safecall;
    function Get_HasDistantAction: WordBool; safecall;
    property DeviceStates: IDMCollection read Get_DeviceStates;
    property OvercomeMethods: IDMCollection read Get_OvercomeMethods;
    property CanDelay: WordBool read Get_CanDelay;
    property CanDetect: WordBool read Get_CanDetect;
    property HasDistantAction: WordBool read Get_HasDistantAction;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardElementTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {62264B39-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISafeguardElementTypeDisp = dispinterface
    ['{62264B39-E560-11D5-92FE-0050BA51A6D3}']
    property DeviceStates: IDMCollection readonly dispid 1;
    property OvercomeMethods: IDMCollection readonly dispid 2;
    property CanDelay: WordBool readonly dispid 4;
    property CanDetect: WordBool readonly dispid 5;
    property HasDistantAction: WordBool readonly dispid 6;
  end;

// *********************************************************************//
// Interface: ISafeguardElementKind
// Flags:     (320) Dual OleAutomation
// GUID:      {BDC00420-18EA-11D6-AEBE-F664C6F8BE63}
// *********************************************************************//
  ISafeguardElementKind = interface(IUnknown)
    ['{BDC00420-18EA-11D6-AEBE-F664C6F8BE63}']
    function Get_ParameterValues: IDMCollection; safecall;
    function Get_MainDeviceState: IDMElement; safecall;
    function Get_KindID: Integer; safecall;
    property ParameterValues: IDMCollection read Get_ParameterValues;
    property MainDeviceState: IDMElement read Get_MainDeviceState;
    property KindID: Integer read Get_KindID;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardElementKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {BDC00420-18EA-11D6-AEBE-F664C6F8BE63}
// *********************************************************************//
  ISafeguardElementKindDisp = dispinterface
    ['{BDC00420-18EA-11D6-AEBE-F664C6F8BE63}']
    property ParameterValues: IDMCollection readonly dispid 1;
    property MainDeviceState: IDMElement readonly dispid 2;
    property KindID: Integer readonly dispid 3;
  end;

// *********************************************************************//
// Interface: ILocalObjectKind
// Flags:     (320) Dual OleAutomation
// GUID:      {8D4BF431-2C5E-11D6-96BE-0050BA51A6D3}
// *********************************************************************//
  ILocalObjectKind = interface(IUnknown)
    ['{8D4BF431-2C5E-11D6-96BE-0050BA51A6D3}']
    function Get_Image: IElementImage; safecall;
    function Get_ClimbUpVelocity: Double; safecall;
    function Get_ClimbDownVelocity: Double; safecall;
    property Image: IElementImage read Get_Image;
    property ClimbUpVelocity: Double read Get_ClimbUpVelocity;
    property ClimbDownVelocity: Double read Get_ClimbDownVelocity;
  end;

// *********************************************************************//
// DispIntf:  ILocalObjectKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {8D4BF431-2C5E-11D6-96BE-0050BA51A6D3}
// *********************************************************************//
  ILocalObjectKindDisp = dispinterface
    ['{8D4BF431-2C5E-11D6-96BE-0050BA51A6D3}']
    property Image: IElementImage readonly dispid 1;
    property ClimbUpVelocity: Double readonly dispid 2;
    property ClimbDownVelocity: Double readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IDetectionElementType
// Flags:     (320) Dual OleAutomation
// GUID:      {5E521B03-2CFD-11D6-96C0-0050BA51A6D3}
// *********************************************************************//
  IDetectionElementType = interface(IUnknown)
    ['{5E521B03-2CFD-11D6-96C0-0050BA51A6D3}']
    function Get_CalcFalseAlarmPeriodHandle: Integer; safecall;
    procedure Set_CalcFalseAlarmPeriodHandle(Value: Integer); safecall;
    function Get_CalcFalseAlarmPeriodProc: WideString; safecall;
    function Get_CalcFalseAlarmPeriodLib: WideString; safecall;
    property CalcFalseAlarmPeriodHandle: Integer read Get_CalcFalseAlarmPeriodHandle write Set_CalcFalseAlarmPeriodHandle;
    property CalcFalseAlarmPeriodProc: WideString read Get_CalcFalseAlarmPeriodProc;
    property CalcFalseAlarmPeriodLib: WideString read Get_CalcFalseAlarmPeriodLib;
  end;

// *********************************************************************//
// DispIntf:  IDetectionElementTypeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5E521B03-2CFD-11D6-96C0-0050BA51A6D3}
// *********************************************************************//
  IDetectionElementTypeDisp = dispinterface
    ['{5E521B03-2CFD-11D6-96C0-0050BA51A6D3}']
    property CalcFalseAlarmPeriodHandle: Integer dispid 1;
    property CalcFalseAlarmPeriodProc: WideString readonly dispid 2;
    property CalcFalseAlarmPeriodLib: WideString readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IDetectionElementKind
// Flags:     (320) Dual OleAutomation
// GUID:      {5E521B05-2CFD-11D6-96C0-0050BA51A6D3}
// *********************************************************************//
  IDetectionElementKind = interface(IUnknown)
    ['{5E521B05-2CFD-11D6-96C0-0050BA51A6D3}']
    function Get_StandardDetectionProbability: Double; safecall;
    function Get_StandardFalseAlarmPeriod: Double; safecall;
    function Get_ReliabilityTime: Double; safecall;
    function Get_DefaultDetectionPosition: Integer; safecall;
    property StandardDetectionProbability: Double read Get_StandardDetectionProbability;
    property StandardFalseAlarmPeriod: Double read Get_StandardFalseAlarmPeriod;
    property ReliabilityTime: Double read Get_ReliabilityTime;
    property DefaultDetectionPosition: Integer read Get_DefaultDetectionPosition;
  end;

// *********************************************************************//
// DispIntf:  IDetectionElementKindDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5E521B05-2CFD-11D6-96C0-0050BA51A6D3}
// *********************************************************************//
  IDetectionElementKindDisp = dispinterface
    ['{5E521B05-2CFD-11D6-96C0-0050BA51A6D3}']
    property StandardDetectionProbability: Double readonly dispid 1;
    property StandardFalseAlarmPeriod: Double readonly dispid 2;
    property ReliabilityTime: Double readonly dispid 3;
    property DefaultDetectionPosition: Integer readonly dispid 4;
  end;

// *********************************************************************//
// Interface: ITactic
// Flags:     (320) Dual OleAutomation
// GUID:      {22DB3A80-013A-11D3-BBF3-F7A843528336}
// *********************************************************************//
  ITactic = interface(IUnknown)
    ['{22DB3A80-013A-11D3-BBF3-F7A843528336}']
    function Get_DeceitTactic: WordBool; safecall;
    function Get_Methods: IDMCollection; safecall;
    function Get_EntryTactic: WordBool; safecall;
    function Get_ExitTactic: WordBool; safecall;
    function Get_FastTactic: WordBool; safecall;
    function Get_StealthTactic: WordBool; safecall;
    function Get_InsiderTactic: WordBool; safecall;
    function Get_GuardTactic: WordBool; safecall;
    function Get_OutsiderTactic: WordBool; safecall;
    function Get_PathArcKind: Integer; safecall;
    function Get_SafeguardClasses: IDMCollection; safecall;
    function DependsOn(const SafeguardElementTypeE: IDMElement): WordBool; safecall;
    function Get_ForceTactic: WordBool; safecall;
    property DeceitTactic: WordBool read Get_DeceitTactic;
    property Methods: IDMCollection read Get_Methods;
    property EntryTactic: WordBool read Get_EntryTactic;
    property ExitTactic: WordBool read Get_ExitTactic;
    property FastTactic: WordBool read Get_FastTactic;
    property StealthTactic: WordBool read Get_StealthTactic;
    property InsiderTactic: WordBool read Get_InsiderTactic;
    property GuardTactic: WordBool read Get_GuardTactic;
    property OutsiderTactic: WordBool read Get_OutsiderTactic;
    property PathArcKind: Integer read Get_PathArcKind;
    property SafeguardClasses: IDMCollection read Get_SafeguardClasses;
    property ForceTactic: WordBool read Get_ForceTactic;
  end;

// *********************************************************************//
// DispIntf:  ITacticDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {22DB3A80-013A-11D3-BBF3-F7A843528336}
// *********************************************************************//
  ITacticDisp = dispinterface
    ['{22DB3A80-013A-11D3-BBF3-F7A843528336}']
    property DeceitTactic: WordBool readonly dispid 3;
    property Methods: IDMCollection readonly dispid 4;
    property EntryTactic: WordBool readonly dispid 5;
    property ExitTactic: WordBool readonly dispid 6;
    property FastTactic: WordBool readonly dispid 7;
    property StealthTactic: WordBool readonly dispid 8;
    property InsiderTactic: WordBool readonly dispid 10;
    property GuardTactic: WordBool readonly dispid 11;
    property OutsiderTactic: WordBool readonly dispid 12;
    property PathArcKind: Integer readonly dispid 1;
    property SafeguardClasses: IDMCollection readonly dispid 2;
    function DependsOn(const SafeguardElementTypeE: IDMElement): WordBool; dispid 9;
    property ForceTactic: WordBool readonly dispid 13;
  end;

// *********************************************************************//
// Interface: IMethodDimItem
// Flags:     (320) Dual OleAutomation
// GUID:      {79ADBEC1-6177-11D6-96FF-0050BA51A6D3}
// *********************************************************************//
  IMethodDimItem = interface(IUnknown)
    ['{79ADBEC1-6177-11D6-96FF-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IMethodDimItemDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {79ADBEC1-6177-11D6-96FF-0050BA51A6D3}
// *********************************************************************//
  IMethodDimItemDisp = dispinterface
    ['{79ADBEC1-6177-11D6-96FF-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IMethodDimension
// Flags:     (320) Dual OleAutomation
// GUID:      {7A290EF3-6242-11D6-9701-0050BA51A6D3}
// *********************************************************************//
  IMethodDimension = interface(IUnknown)
    ['{7A290EF3-6242-11D6-9701-0050BA51A6D3}']
    function Get_SourceKind: Integer; safecall;
    function Get_Code: Integer; safecall;
    function Get_Kind: Integer; safecall;
    function Get_CurrentValueIndex: Integer; safecall;
    procedure Set_CurrentValueIndex(Value: Integer); safecall;
    property SourceKind: Integer read Get_SourceKind;
    property Code: Integer read Get_Code;
    property Kind: Integer read Get_Kind;
    property CurrentValueIndex: Integer read Get_CurrentValueIndex write Set_CurrentValueIndex;
  end;

// *********************************************************************//
// DispIntf:  IMethodDimensionDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {7A290EF3-6242-11D6-9701-0050BA51A6D3}
// *********************************************************************//
  IMethodDimensionDisp = dispinterface
    ['{7A290EF3-6242-11D6-9701-0050BA51A6D3}']
    property SourceKind: Integer readonly dispid 1;
    property Code: Integer readonly dispid 2;
    property Kind: Integer readonly dispid 3;
    property CurrentValueIndex: Integer dispid 4;
  end;

// *********************************************************************//
// Interface: IMethodDimItemSource
// Flags:     (320) Dual OleAutomation
// GUID:      {7A290EF6-6242-11D6-9701-0050BA51A6D3}
// *********************************************************************//
  IMethodDimItemSource = interface(IUnknown)
    ['{7A290EF6-6242-11D6-9701-0050BA51A6D3}']
    function GetMethodDimItemIndex(Kind: Integer; Code: Integer; const DimItems: IDMCollection; 
                                   const ParamE: IDMElement; ParamF: Double): Integer; safecall;
  end;

// *********************************************************************//
// DispIntf:  IMethodDimItemSourceDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {7A290EF6-6242-11D6-9701-0050BA51A6D3}
// *********************************************************************//
  IMethodDimItemSourceDisp = dispinterface
    ['{7A290EF6-6242-11D6-9701-0050BA51A6D3}']
    function GetMethodDimItemIndex(Kind: Integer; Code: Integer; const DimItems: IDMCollection; 
                                   const ParamE: IDMElement; ParamF: Double): Integer; dispid 1;
  end;

// *********************************************************************//
// Interface: IBattleSkill
// Flags:     (320) Dual OleAutomation
// GUID:      {37F90C61-827A-11D6-9729-0050BA51A6D3}
// *********************************************************************//
  IBattleSkill = interface(IUnknown)
    ['{37F90C61-827A-11D6-9729-0050BA51A6D3}']
    function Get_TakeAimTime: Double; safecall;
    function Get_StillStillScoringFactor: Double; safecall;
    function Get_RunStillScoringFactor: Double; safecall;
    function Get_StillRunScoringFactor: Double; safecall;
    function Get_RunRunScoringFactor: Double; safecall;
    function Get_RunEvadeFactor: Double; safecall;
    function Get_StillEvadeFactor: Double; safecall;
    function Get_DefaultAcceptableRisk: Double; safecall;
    function Get_SkillLevel: Integer; safecall;
    property TakeAimTime: Double read Get_TakeAimTime;
    property StillStillScoringFactor: Double read Get_StillStillScoringFactor;
    property RunStillScoringFactor: Double read Get_RunStillScoringFactor;
    property StillRunScoringFactor: Double read Get_StillRunScoringFactor;
    property RunRunScoringFactor: Double read Get_RunRunScoringFactor;
    property RunEvadeFactor: Double read Get_RunEvadeFactor;
    property StillEvadeFactor: Double read Get_StillEvadeFactor;
    property DefaultAcceptableRisk: Double read Get_DefaultAcceptableRisk;
    property SkillLevel: Integer read Get_SkillLevel;
  end;

// *********************************************************************//
// DispIntf:  IBattleSkillDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {37F90C61-827A-11D6-9729-0050BA51A6D3}
// *********************************************************************//
  IBattleSkillDisp = dispinterface
    ['{37F90C61-827A-11D6-9729-0050BA51A6D3}']
    property TakeAimTime: Double readonly dispid 1;
    property StillStillScoringFactor: Double readonly dispid 2;
    property RunStillScoringFactor: Double readonly dispid 3;
    property StillRunScoringFactor: Double readonly dispid 4;
    property RunRunScoringFactor: Double readonly dispid 5;
    property RunEvadeFactor: Double readonly dispid 6;
    property StillEvadeFactor: Double readonly dispid 7;
    property DefaultAcceptableRisk: Double readonly dispid 8;
    property SkillLevel: Integer readonly dispid 9;
  end;

// *********************************************************************//
// Interface: IGroundObstacleKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75064-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IGroundObstacleKind = interface(IDispatch)
    ['{EDF75064-9759-11D6-9B9F-970B96239AA2}']
  end;

// *********************************************************************//
// DispIntf:  IGroundObstacleKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75064-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IGroundObstacleKindDisp = dispinterface
    ['{EDF75064-9759-11D6-9B9F-970B96239AA2}']
  end;

// *********************************************************************//
// Interface: IFenceObstacleKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75066-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IFenceObstacleKind = interface(IDispatch)
    ['{EDF75066-9759-11D6-9B9F-970B96239AA2}']
    function Get_DefaultWidth: Double; safecall;
    property DefaultWidth: Double read Get_DefaultWidth;
  end;

// *********************************************************************//
// DispIntf:  IFenceObstacleKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75066-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IFenceObstacleKindDisp = dispinterface
    ['{EDF75066-9759-11D6-9B9F-970B96239AA2}']
    property DefaultWidth: Double readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IGroundObstacleType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75068-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IGroundObstacleType = interface(IDispatch)
    ['{EDF75068-9759-11D6-9B9F-970B96239AA2}']
  end;

// *********************************************************************//
// DispIntf:  IGroundObstacleTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75068-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IGroundObstacleTypeDisp = dispinterface
    ['{EDF75068-9759-11D6-9B9F-970B96239AA2}']
  end;

// *********************************************************************//
// Interface: IFenceObstacleType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF7506A-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IFenceObstacleType = interface(IDispatch)
    ['{EDF7506A-9759-11D6-9B9F-970B96239AA2}']
  end;

// *********************************************************************//
// DispIntf:  IFenceObstacleTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF7506A-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IFenceObstacleTypeDisp = dispinterface
    ['{EDF7506A-9759-11D6-9B9F-970B96239AA2}']
  end;

// *********************************************************************//
// Interface: IPrice
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {101C0561-430B-11D7-97F8-0050BA51A6D3}
// *********************************************************************//
  IPrice = interface(IDispatch)
    ['{101C0561-430B-11D7-97F8-0050BA51A6D3}']
    function Get_PriceDimension: Integer; safecall;
    function Get_Price: Double; safecall;
    function Get_InstallCoeff: Double; safecall;
    property PriceDimension: Integer read Get_PriceDimension;
    property Price: Double read Get_Price;
    property InstallCoeff: Double read Get_InstallCoeff;
  end;

// *********************************************************************//
// DispIntf:  IPriceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {101C0561-430B-11D7-97F8-0050BA51A6D3}
// *********************************************************************//
  IPriceDisp = dispinterface
    ['{101C0561-430B-11D7-97F8-0050BA51A6D3}']
    property PriceDimension: Integer readonly dispid 1;
    property Price: Double readonly dispid 2;
    property InstallCoeff: Double readonly dispid 3;
  end;

// *********************************************************************//
// Interface: ISoundSensorType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {26795940-8A2C-11D7-9BA0-FDDA98FCA360}
// *********************************************************************//
  ISoundSensorType = interface(IDispatch)
    ['{26795940-8A2C-11D7-9BA0-FDDA98FCA360}']
  end;

// *********************************************************************//
// DispIntf:  ISoundSensorTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {26795940-8A2C-11D7-9BA0-FDDA98FCA360}
// *********************************************************************//
  ISoundSensorTypeDisp = dispinterface
    ['{26795940-8A2C-11D7-9BA0-FDDA98FCA360}']
  end;

// *********************************************************************//
// Interface: ISoundSensorKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {26795942-8A2C-11D7-9BA0-FDDA98FCA360}
// *********************************************************************//
  ISoundSensorKind = interface(IDispatch)
    ['{26795942-8A2C-11D7-9BA0-FDDA98FCA360}']
  end;

// *********************************************************************//
// DispIntf:  ISoundSensorKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {26795942-8A2C-11D7-9BA0-FDDA98FCA360}
// *********************************************************************//
  ISoundSensorKindDisp = dispinterface
    ['{26795942-8A2C-11D7-9BA0-FDDA98FCA360}']
  end;

// *********************************************************************//
// Interface: IRoadType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {26795944-8A2C-11D7-9BA0-FDDA98FCA360}
// *********************************************************************//
  IRoadType = interface(IDispatch)
    ['{26795944-8A2C-11D7-9BA0-FDDA98FCA360}']
  end;

// *********************************************************************//
// DispIntf:  IRoadTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {26795944-8A2C-11D7-9BA0-FDDA98FCA360}
// *********************************************************************//
  IRoadTypeDisp = dispinterface
    ['{26795944-8A2C-11D7-9BA0-FDDA98FCA360}']
  end;

// *********************************************************************//
// Interface: IControlDeviceType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB147E93-FADE-11D7-98D2-0050BA51A6D3}
// *********************************************************************//
  IControlDeviceType = interface(IDispatch)
    ['{FB147E93-FADE-11D7-98D2-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IControlDeviceTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB147E93-FADE-11D7-98D2-0050BA51A6D3}
// *********************************************************************//
  IControlDeviceTypeDisp = dispinterface
    ['{FB147E93-FADE-11D7-98D2-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IControlDeviceKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB147E95-FADE-11D7-98D2-0050BA51A6D3}
// *********************************************************************//
  IControlDeviceKind = interface(IDispatch)
    ['{FB147E95-FADE-11D7-98D2-0050BA51A6D3}']
    function Get_AddressInfo: WordBool; safecall;
    function Get_DamageInfo: WordBool; safecall;
    function Get_TamperInfo: WordBool; safecall;
    function Get_LinkCheck: WordBool; safecall;
    function Get_InfoCapacity: Integer; safecall;
    function Get_SystemKind: Integer; safecall;
    property AddressInfo: WordBool read Get_AddressInfo;
    property DamageInfo: WordBool read Get_DamageInfo;
    property TamperInfo: WordBool read Get_TamperInfo;
    property LinkCheck: WordBool read Get_LinkCheck;
    property InfoCapacity: Integer read Get_InfoCapacity;
    property SystemKind: Integer read Get_SystemKind;
  end;

// *********************************************************************//
// DispIntf:  IControlDeviceKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB147E95-FADE-11D7-98D2-0050BA51A6D3}
// *********************************************************************//
  IControlDeviceKindDisp = dispinterface
    ['{FB147E95-FADE-11D7-98D2-0050BA51A6D3}']
    property AddressInfo: WordBool readonly dispid 1;
    property DamageInfo: WordBool readonly dispid 2;
    property TamperInfo: WordBool readonly dispid 3;
    property LinkCheck: WordBool readonly dispid 4;
    property InfoCapacity: Integer readonly dispid 5;
    property SystemKind: Integer readonly dispid 6;
  end;

// *********************************************************************//
// Interface: IVisualElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {501EAFC0-FC5F-11D7-BBF3-0010603BA6C9}
// *********************************************************************//
  IVisualElement = interface(IDispatch)
    ['{501EAFC0-FC5F-11D7-BBF3-0010603BA6C9}']
    function Get_Image: IElementImage; safecall;
    function Get_Image2: IElementImage; safecall;
    property Image: IElementImage read Get_Image;
    property Image2: IElementImage read Get_Image2;
  end;

// *********************************************************************//
// DispIntf:  IVisualElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {501EAFC0-FC5F-11D7-BBF3-0010603BA6C9}
// *********************************************************************//
  IVisualElementDisp = dispinterface
    ['{501EAFC0-FC5F-11D7-BBF3-0010603BA6C9}']
    property Image: IElementImage readonly dispid 1;
    property Image2: IElementImage readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IUpdating
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C58E2AD4-E7A9-11D9-9AE4-0050BA51A6D3}
// *********************************************************************//
  IUpdating = interface(IDispatch)
    ['{C58E2AD4-E7A9-11D9-9AE4-0050BA51A6D3}']
    function Get_OldRefID: SYSINT; safecall;
    function Get_NewRefID: SYSINT; safecall;
    property OldRefID: SYSINT read Get_OldRefID;
    property NewRefID: SYSINT read Get_NewRefID;
  end;

// *********************************************************************//
// DispIntf:  IUpdatingDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C58E2AD4-E7A9-11D9-9AE4-0050BA51A6D3}
// *********************************************************************//
  IUpdatingDisp = dispinterface
    ['{C58E2AD4-E7A9-11D9-9AE4-0050BA51A6D3}']
    property OldRefID: SYSINT readonly dispid 1;
    property NewRefID: SYSINT readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ITexture
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {440888B3-3515-48E7-ADB4-C46833EBFACB}
// *********************************************************************//
  ITexture = interface(IDispatch)
    ['{440888B3-3515-48E7-ADB4-C46833EBFACB}']
    function Get_Num: Integer; safecall;
    procedure Set_Num(Value: Integer); safecall;
    property Num: Integer read Get_Num write Set_Num;
  end;

// *********************************************************************//
// DispIntf:  ITextureDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {440888B3-3515-48E7-ADB4-C46833EBFACB}
// *********************************************************************//
  ITextureDisp = dispinterface
    ['{440888B3-3515-48E7-ADB4-C46833EBFACB}']
    property Num: Integer dispid 3;
  end;

// *********************************************************************//
// Interface: IElementParameter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7915C868-6E1A-4ABD-B72B-DB19514FDBF4}
// *********************************************************************//
  IElementParameter = interface(IDispatch)
    ['{7915C868-6E1A-4ABD-B72B-DB19514FDBF4}']
  end;

// *********************************************************************//
// DispIntf:  IElementParameterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7915C868-6E1A-4ABD-B72B-DB19514FDBF4}
// *********************************************************************//
  IElementParameterDisp = dispinterface
    ['{7915C868-6E1A-4ABD-B72B-DB19514FDBF4}']
  end;

// *********************************************************************//
// Interface: IBoundaryKind2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FBA77FEF-7D6C-4D09-A8C9-6B94DD74DC10}
// *********************************************************************//
  IBoundaryKind2 = interface(IDispatch)
    ['{FBA77FEF-7D6C-4D09-A8C9-6B94DD74DC10}']
    function Get_LayerKind: Integer; safecall;
    property LayerKind: Integer read Get_LayerKind;
  end;

// *********************************************************************//
// DispIntf:  IBoundaryKind2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FBA77FEF-7D6C-4D09-A8C9-6B94DD74DC10}
// *********************************************************************//
  IBoundaryKind2Disp = dispinterface
    ['{FBA77FEF-7D6C-4D09-A8C9-6B94DD74DC10}']
    property LayerKind: Integer readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IShotBreachRec
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DDD43543-6F71-4C1B-866A-34BA0556D2D5}
// *********************************************************************//
  IShotBreachRec = interface(IDispatch)
    ['{DDD43543-6F71-4C1B-866A-34BA0556D2D5}']
    function Get_DemandArmour: Integer; safecall;
    property DemandArmour: Integer read Get_DemandArmour;
  end;

// *********************************************************************//
// DispIntf:  IShotBreachRecDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DDD43543-6F71-4C1B-866A-34BA0556D2D5}
// *********************************************************************//
  IShotBreachRecDisp = dispinterface
    ['{DDD43543-6F71-4C1B-866A-34BA0556D2D5}']
    property DemandArmour: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IObserverKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FCEB5AAD-D83B-421C-BF75-89C4768B4E51}
// *********************************************************************//
  IObserverKind = interface(IDispatch)
    ['{FCEB5AAD-D83B-421C-BF75-89C4768B4E51}']
    function Get_ObservationMethod: IOvercomeMethod; safecall;
    property ObservationMethod: IOvercomeMethod read Get_ObservationMethod;
  end;

// *********************************************************************//
// DispIntf:  IObserverKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FCEB5AAD-D83B-421C-BF75-89C4768B4E51}
// *********************************************************************//
  IObserverKindDisp = dispinterface
    ['{FCEB5AAD-D83B-421C-BF75-89C4768B4E51}']
    property ObservationMethod: IOvercomeMethod readonly dispid 1;
  end;

implementation

uses ComObj;

end.
