unit FacilityModelLib_TLB;

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
// File generated on 19.02.2008 14:58:56 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\Sprut3\Sprut3Pas\FacilityModel\FacilityModelLib.tlb (1)
// LIBID: {5F8591B2-0FE6-11D6-9328-0050BA51A6D3}
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
  FacilityModelLibMajorVersion = 1;
  FacilityModelLibMinorVersion = 0;

  LIBID_FacilityModelLib: TGUID = '{5F8591B2-0FE6-11D6-9328-0050BA51A6D3}';

  IID_IFacilityModel: TGUID = '{9DCB5BA3-14B5-11D6-932D-0050BA51A6D3}';
  IID_IZone: TGUID = '{5F8591BC-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IBoundary: TGUID = '{5F8591BE-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IBoundaryLayer: TGUID = '{5F8591C0-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IFacilityState: TGUID = '{5F8591C4-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IFacilitySubState: TGUID = '{5F8591C6-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IZoneState: TGUID = '{5F8591C8-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IBoundaryLayerState: TGUID = '{5F8591CC-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ISafeguardElementState: TGUID = '{5F8591D0-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IWarriorPath: TGUID = '{5F8591D2-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IBarrier: TGUID = '{5F8591D4-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IBarrierFixture: TGUID = '{5F8591D6-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ILock: TGUID = '{5F8591D8-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IUndergroundObstacle: TGUID = '{5F8591DA-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IActiveSafeguard: TGUID = '{5F8591DC-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ISurfaceSensor: TGUID = '{5F8591DE-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IPositionSensor: TGUID = '{5F8591E0-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IVolumeSensor: TGUID = '{5F8591E2-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IBarrierSensor: TGUID = '{5F8591E4-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IPerimeterSensor: TGUID = '{5F8591E6-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IContrabandSensor: TGUID = '{5F8591E8-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IAccessControl: TGUID = '{5F8591EA-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ITVCamera: TGUID = '{5F8591EC-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ILightDevice: TGUID = '{5F8591EE-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ICommunicationDevice: TGUID = '{5F8591F0-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ICabel: TGUID = '{5F8591F6-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IGuardPost: TGUID = '{5F8591F8-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IPatrolPath: TGUID = '{5F8591FA-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ITarget: TGUID = '{5F8591FC-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ILocalPointObject: TGUID = '{5F859200-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IJump: TGUID = '{5F859202-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IStartPoint: TGUID = '{5F859204-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IGuardVariant: TGUID = '{5F859206-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IGuardGroup: TGUID = '{5F859208-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IAdversaryVariant: TGUID = '{5F859214-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IAdversaryGroup: TGUID = '{5F859216-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ITool: TGUID = '{5F85921A-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IVehicle: TGUID = '{5F85921C-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IAthority: TGUID = '{5F85921E-0FE6-11D6-9328-0050BA51A6D3}';
  IID_ISkill: TGUID = '{5F859220-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IWarriorGroup: TGUID = '{9DCB5BA1-14B5-11D6-932D-0050BA51A6D3}';
  CLASS_FacilityModel: TGUID = '{5F8591B9-0FE6-11D6-9328-0050BA51A6D3}';
  IID_IFacilityElement: TGUID = '{9DCB5BA5-14B5-11D6-932D-0050BA51A6D3}';
  IID_IPathElement: TGUID = '{9DCB5BA7-14B5-11D6-932D-0050BA51A6D3}';
  IID_IElementState: TGUID = '{F080A721-154A-11D6-932F-0050BA51A6D3}';
  IID_ISafeguardElement: TGUID = '{F4204D31-1936-11D6-9335-0050BA51A6D3}';
  IID_IFieldBarrier: TGUID = '{B06BB691-2046-11D6-9343-0050BA51A6D3}';
  IID_ICabelNode: TGUID = '{5E521B01-2CFD-11D6-96C0-0050BA51A6D3}';
  IID_IDistantDetectionElement: TGUID = '{55EDE0E0-2E2C-11D6-9B9F-A06FA09A99A2}';
  IID_IWeapon: TGUID = '{7FEA85C0-2F7A-11D6-9B9F-846689E068A3}';
  IID_IAnalysisVariant: TGUID = '{64830DC0-38FD-11D6-9B9F-C8B92BAC54A3}';
  IID_IVulnerabilityData: TGUID = '{7DE9F7A0-4A51-11D6-9B9F-FBE42A0D5AA3}';
  IID_IVulnerabilityMap: TGUID = '{375483C2-4DD6-11D6-96EE-0050BA51A6D3}';
  IID_IBoundary2: TGUID = '{3B9C7CF1-777A-11D6-971B-0050BA51A6D3}';
  IID_ITechnicalService: TGUID = '{F5703240-1E89-11D3-BBF3-DF0FFE18F633}';
  IID_IDetectionElement: TGUID = '{EF126AB2-7E8C-11D6-9726-0050BA51A6D3}';
  IID_IRoad: TGUID = '{A2F1FDB1-84D4-11D6-972C-0050BA51A6D3}';
  IID_IUserDefinedPath: TGUID = '{A2F1FDB3-84D4-11D6-972C-0050BA51A6D3}';
  IID_IGlobalZone: TGUID = '{249B0381-8D7C-11D6-9733-0050BA51A6D3}';
  IID_IAccess: TGUID = '{E6BFAC11-8E49-11D6-9734-0050BA51A6D3}';
  IID_IGroundObstacle: TGUID = '{EDF75060-9759-11D6-9B9F-970B96239AA2}';
  IID_IFenceObstacle: TGUID = '{EDF75062-9759-11D6-9B9F-970B96239AA2}';
  IID_IRoadPart: TGUID = '{CC0F05D0-FBB3-11D6-97AD-0050BA51A6D3}';
  IID_ISensor: TGUID = '{6C39E8C0-1EB4-11D7-9B9F-8882FDE2B460}';
  IID_IAlarmAssess: TGUID = '{D6DA6000-2586-11D7-9B9F-AF2428699060}';
  IID_IBoundaryState: TGUID = '{803E4A60-6DF5-11D7-9BA0-81150452AC60}';
  IID_IPathArc: TGUID = '{B2C7FD47-E3EA-4BA1-86A0-B8A1A5A17483}';
  IID_IWarriorPathElement: TGUID = '{1F1F2C31-ADE2-11D7-9885-0050BA51A6D3}';
  IID_IConnection: TGUID = '{6230D8A1-F889-11D7-98CD-0050BA51A6D3}';
  IID_IPathNodeArray: TGUID = '{E8247791-FA18-11D7-98D0-0050BA51A6D3}';
  IID_IControlDevice: TGUID = '{FB147E91-FADE-11D7-98D2-0050BA51A6D3}';
  IID_ISafeguardUnit: TGUID = '{41AFEA40-1185-11D8-BBF3-0010603BA6C9}';
  IID_ICriticalPoint: TGUID = '{B3D894E1-1349-11D8-98EB-0050BA51A6D3}';
  IID_IFMRecomendation: TGUID = '{B3D894E3-1349-11D8-98EB-0050BA51A6D3}';
  IID_ISafeguardUnit2: TGUID = '{20BA5FC3-1B21-11D8-98F8-0050BA51A6D3}';
  IID_IFMState: TGUID = '{B6FA295E-0D7C-4225-B9F6-3B341FD91EFC}';
  IID_IBoundary3: TGUID = '{7A9ECCE8-E389-463C-8A70-01E940A04FB6}';
  IID_IGuardArrival: TGUID = '{11975726-2C31-441D-810C-8DBC9B6EA558}';
  IID_IImager: TGUID = '{949D2686-5893-4404-B61A-3C5E9D7A4BA5}';
  IID_IWidthIntf: TGUID = '{3C6B1F15-4EFB-4E54-89B9-AC3BD2907537}';
  IID_IZone2: TGUID = '{C6CF9DF9-321B-4ACD-AD44-FF08119E8A47}';
  IID_IStairBuilder: TGUID = '{0C1C3DB0-80B5-4EF7-9CDF-ACA7E0E65280}';
  IID_IElementParameterValue: TGUID = '{C4177E40-D7D9-11DA-B2B6-A37BE6432D60}';
  IID_IInsiderTarget: TGUID = '{E3CA6913-2984-41CF-9899-D11256ED87DD}';
  IID_IControlDeviceAccess: TGUID = '{0CBF3983-39DE-412B-A9BC-2D01A596E2CA}';
  IID_IGuardPostAccess: TGUID = '{CBE1F657-3E91-4104-8EE4-31A632928C37}';
  IID_ISubBoundary: TGUID = '{3B367272-4523-4E9E-B8EF-9870617A873E}';
  IID_IOvercomingBoundary: TGUID = '{BE6369C0-474A-4DE4-AB03-FCF443BF73E4}';
  IID_IPathNode: TGUID = '{346CD6A1-03DF-11DB-9247-000272C5192A}';
  IID_IGuardGroup2: TGUID = '{DC5FC52B-1803-4DB9-BBC0-761CD4FF4F2C}';
  IID_IGuardModel: TGUID = '{1594045B-A35E-4F57-8855-013041F9C07C}';
  IID_IZone3: TGUID = '{7BFC0CB6-138E-43BF-BCC2-FF8126AD4360}';
  IID_IRefPathElement: TGUID = '{FD8AC823-932A-41B8-8EC5-4A162FE8989B}';
  IID_IGoods: TGUID = '{65A351D1-A3F8-4028-9C08-ADCC766F8430}';
  IID_IObserver: TGUID = '{BDBAD5B6-F09D-4CD1-B8F9-E3FBE1048370}';
  IID_IGuardGroupState: TGUID = '{2DA51BF1-804F-4A64-A1F8-AB73A99E07D3}';
  IID_IObservationElement: TGUID = '{DA4E27C8-3C94-4A0A-84E6-B6D7AF8DB9E6}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum FacilityModelClasses
type
  FacilityModelClasses = TOleEnum;
const
  _Zone = $0000000B;
  _Boundary = $0000000C;
  _BoundaryLayer = $0000000D;
  _TechnicalService = $0000000E;
  _FacilityState = $0000000F;
  _FacilitySubState = $00000010;
  _ZoneState = $00000011;
  _BoundaryState = $00000012;
  _BoundaryLayerState = $00000013;
  _BoundaryElementState = $00000014;
  _SafeguardElementState = $00000015;
  _WarriorPath = $00000016;
  _Barrier = $00000017;
  _BarrierFixture = $00000018;
  _Lock = $00000019;
  _UndergroundObstacle = $0000001A;
  _ActiveSafeguard = $0000001B;
  _SurfaceSensor = $0000001C;
  _PositionSensor = $0000001D;
  _VolumeSensor = $0000001E;
  _BarrierSensor = $0000001F;
  _PerimeterSensor = $00000020;
  _ContrabandSensor = $00000021;
  _AccessControl = $00000022;
  _TVCamera = $00000023;
  _LightDevice = $00000024;
  _CommunicationDevice = $00000025;
  _SignalDevice = $00000026;
  _PowerSource = $00000027;
  _Cabel = $00000028;
  _CabelSegment = $00000029;
  _AdditionalDevice = $0000002A;
  _GuardPost = $0000002B;
  _PatrolPath = $0000002C;
  _PatrolPathElement = $0000002D;
  _Target = $0000002E;
  _Conveyance = $0000002F;
  _ConveyanceSegment = $00000030;
  _LocalPointObject = $00000031;
  _Jump = $00000032;
  _StartPoint = $00000033;
  _GuardVariant = $00000034;
  _GuardGroup = $00000035;
  _AnalysisVariant = $00000036;
  _Weapon = $00000037;
  _Tool = $00000038;
  _Vehicle = $00000039;
  _Skill = $0000003A;
  _Road = $0000003B;
  _Athority = $0000003C;
  _AdversaryVariant = $0000003D;
  _AdversaryGroup = $0000003E;
  _FMError = $0000003F;
  _UserDefinedPath = $00000040;
  _GlobalZone = $00000041;
  _Access = $00000042;
  _GroundObstacle = $00000043;
  _FenceObstacle = $00000044;
  _WarriorPathElement = $00000045;
  _Connection = $00000046;
  _ControlDevice = $00000047;
  _CriticalPoint = $00000048;
  _FMRecomendation = $00000049;
  _GuardArrival = $0000004A;
  _ElementParameterValue = $0000004B;
  _ControlDeviceAccess = $0000004C;
  _GuardPostAccess = $0000004D;
  _SubBoundary = $0000004E;
  _OvercomingBoundary = $0000004F;
  _Observer = $00000050;
  _GuardGroupState = $00000051;

// Constants for enum TPathStage
type
  TPathStage = TOleEnum;
const
  wpsStealthEntry = $00000000;
  wpsFastEntry = $00000001;
  wpsStealthExit = $00000002;
  wpsFastExit = $00000003;

// Constants for enum TAdversaryTask
type
  TAdversaryTask = TOleEnum;
const
  MainGroup = $00000000;
  SupportGroup = $00000001;
  Insider = $00000002;

// Constants for enum TPathDirection
type
  TPathDirection = TOleEnum;
const
  pdFrom0To1 = $00000000;
  pdFrom1To0 = $00000001;

// Constants for enum TGuardTask
type
  TGuardTask = TOleEnum;
const
  gtTakePosition = $00000000;
  gtInterruptOnDetectionPoint = $00000001;
  gtPatrol = $00000002;
  gtStayOnPost = $00000003;
  gtInterruptOnTarget = $00000004;
  gtInterruptOnExit = $00000005;

// Constants for enum TReactionMode
type
  TReactionMode = TOleEnum;
const
  rmNever = $00000000;
  rmAlways = $00000001;
  rmFiftyFifty = $00000002;
  rmTotalFalseAlarmDependant = $00000003;
  rmBoundaryFalseAlarmDependant = $00000004;

// Constants for enum TWarriorpathKind
type
  TWarriorpathKind = TOleEnum;
const
  _wpkUser = $00000000;
  _wpkFast = $00000001;
  _wpkStealth = $00000002;
  _wpkOptimal = $00000003;
  _wpkRational = $00000004;
  _wpkGuard = $00000005;

// Constants for enum TFMRecomendationKind
type
  TFMRecomendationKind = TOleEnum;
const
  rcDelayTime = $00000000;
  rcDetectionProbability = $00000001;
  rcTimeAndProbability = $00000002;

// Constants for enum TMovementKind
type
  TMovementKind = TOleEnum;
const
  _PedestrialFast = $00000000;
  _PedestrialStealth = $00000001;
  _Vehical = $00000002;
  _ClimbUp = $00000003;
  _ClimbDown = $00000004;
  _MovementImpossible = $00000005;

// Constants for enum TDetectionPosition
type
  TDetectionPosition = TOleEnum;
const
  dpOuter = $00000000;
  dpCent = $00000001;
  dpInner = $00000002;

// Constants for enum TLayerKind
type
  TLayerKind = TOleEnum;
const
  lkRelief = $00000000;
  lkBuildSector = $00000001;
  lkUserDefinedPath = $00000002;
  lkVerticalBoundary = $00000003;

// Constants for enum TShowLayersMode
type
  TShowLayersMode = TOleEnum;
const
  slmShowOnlyBoundaryLayers = $00000000;
  slmShowOnlyBoundaryArea = $00000001;
  slmShowBoundaryAreaAndLayers = $00000002;

// Constants for enum TGuardArrivalTime
type
  TGuardArrivalTime = TOleEnum;
const
  gatCalculatedFromStart = $00000000;
  gatUserDefinedFromStart = $00000001;
  gatCalculatedFromPrev = $00000002;
  gatUserDefinedFromPrev = $00000003;

// Constants for enum TPursuitKind
type
  TPursuitKind = TOleEnum;
const
  pkNever = $00000000;
  pkAlways = $00000001;
  pkUntilGoalDefiningPoint = $00000002;
  pkUntilObstacleAndStay = $00000003;
  pkUntilObstacleAndTurn = $00000004;

// Constants for enum TStartCondition
type
  TStartCondition = TOleEnum;
const
  scAlarm = $00000000;
  scGoalDefiningPointPassed = $00000001;
  scIntrusionProved = $00000002;
  scArmedIntrusionProved = $00000003;

// Constants for enum TPathKind
type
  TPathKind = TOleEnum;
const
  pkRationalPath = $00000000;
  pkFastPath = $00000001;
  pkStealthPath = $00000002;
  pkGuardPathToTarget = $00000003;
  pkGuardPathFromStart = $00000004;
  pkRationalBackPath = $00000005;

// Constants for enum TPathStageFlag
type
  TPathStageFlag = TOleEnum;
const
  psfFast = $00000001;
  psfBack = $00000002;
  psfCriticalPoint = $00000004;
  psfTarget = $00000008;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFacilityModel = interface;
  IFacilityModelDisp = dispinterface;
  IZone = interface;
  IZoneDisp = dispinterface;
  IBoundary = interface;
  IBoundaryDisp = dispinterface;
  IBoundaryLayer = interface;
  IBoundaryLayerDisp = dispinterface;
  IFacilityState = interface;
  IFacilityStateDisp = dispinterface;
  IFacilitySubState = interface;
  IFacilitySubStateDisp = dispinterface;
  IZoneState = interface;
  IZoneStateDisp = dispinterface;
  IBoundaryLayerState = interface;
  IBoundaryLayerStateDisp = dispinterface;
  ISafeguardElementState = interface;
  ISafeguardElementStateDisp = dispinterface;
  IWarriorPath = interface;
  IWarriorPathDisp = dispinterface;
  IBarrier = interface;
  IBarrierDisp = dispinterface;
  IBarrierFixture = interface;
  IBarrierFixtureDisp = dispinterface;
  ILock = interface;
  ILockDisp = dispinterface;
  IUndergroundObstacle = interface;
  IUndergroundObstacleDisp = dispinterface;
  IActiveSafeguard = interface;
  IActiveSafeguardDisp = dispinterface;
  ISurfaceSensor = interface;
  ISurfaceSensorDisp = dispinterface;
  IPositionSensor = interface;
  IPositionSensorDisp = dispinterface;
  IVolumeSensor = interface;
  IVolumeSensorDisp = dispinterface;
  IBarrierSensor = interface;
  IBarrierSensorDisp = dispinterface;
  IPerimeterSensor = interface;
  IPerimeterSensorDisp = dispinterface;
  IContrabandSensor = interface;
  IContrabandSensorDisp = dispinterface;
  IAccessControl = interface;
  IAccessControlDisp = dispinterface;
  ITVCamera = interface;
  ITVCameraDisp = dispinterface;
  ILightDevice = interface;
  ILightDeviceDisp = dispinterface;
  ICommunicationDevice = interface;
  ICommunicationDeviceDisp = dispinterface;
  ICabel = interface;
  ICabelDisp = dispinterface;
  IGuardPost = interface;
  IGuardPostDisp = dispinterface;
  IPatrolPath = interface;
  IPatrolPathDisp = dispinterface;
  ITarget = interface;
  ITargetDisp = dispinterface;
  ILocalPointObject = interface;
  ILocalPointObjectDisp = dispinterface;
  IJump = interface;
  IJumpDisp = dispinterface;
  IStartPoint = interface;
  IStartPointDisp = dispinterface;
  IGuardVariant = interface;
  IGuardVariantDisp = dispinterface;
  IGuardGroup = interface;
  IGuardGroupDisp = dispinterface;
  IAdversaryVariant = interface;
  IAdversaryVariantDisp = dispinterface;
  IAdversaryGroup = interface;
  IAdversaryGroupDisp = dispinterface;
  ITool = interface;
  IToolDisp = dispinterface;
  IVehicle = interface;
  IVehicleDisp = dispinterface;
  IAthority = interface;
  IAthorityDisp = dispinterface;
  ISkill = interface;
  ISkillDisp = dispinterface;
  IWarriorGroup = interface;
  IWarriorGroupDisp = dispinterface;
  IFacilityElement = interface;
  IFacilityElementDisp = dispinterface;
  IPathElement = interface;
  IPathElementDisp = dispinterface;
  IElementState = interface;
  IElementStateDisp = dispinterface;
  ISafeguardElement = interface;
  ISafeguardElementDisp = dispinterface;
  IFieldBarrier = interface;
  IFieldBarrierDisp = dispinterface;
  ICabelNode = interface;
  ICabelNodeDisp = dispinterface;
  IDistantDetectionElement = interface;
  IDistantDetectionElementDisp = dispinterface;
  IWeapon = interface;
  IWeaponDisp = dispinterface;
  IAnalysisVariant = interface;
  IAnalysisVariantDisp = dispinterface;
  IVulnerabilityData = interface;
  IVulnerabilityDataDisp = dispinterface;
  IVulnerabilityMap = interface;
  IVulnerabilityMapDisp = dispinterface;
  IBoundary2 = interface;
  IBoundary2Disp = dispinterface;
  ITechnicalService = interface;
  ITechnicalServiceDisp = dispinterface;
  IDetectionElement = interface;
  IDetectionElementDisp = dispinterface;
  IRoad = interface;
  IRoadDisp = dispinterface;
  IUserDefinedPath = interface;
  IUserDefinedPathDisp = dispinterface;
  IGlobalZone = interface;
  IGlobalZoneDisp = dispinterface;
  IAccess = interface;
  IAccessDisp = dispinterface;
  IGroundObstacle = interface;
  IGroundObstacleDisp = dispinterface;
  IFenceObstacle = interface;
  IFenceObstacleDisp = dispinterface;
  IRoadPart = interface;
  IRoadPartDisp = dispinterface;
  ISensor = interface;
  ISensorDisp = dispinterface;
  IAlarmAssess = interface;
  IAlarmAssessDisp = dispinterface;
  IBoundaryState = interface;
  IBoundaryStateDisp = dispinterface;
  IPathArc = interface;
  IPathArcDisp = dispinterface;
  IWarriorPathElement = interface;
  IWarriorPathElementDisp = dispinterface;
  IConnection = interface;
  IConnectionDisp = dispinterface;
  IPathNodeArray = interface;
  IPathNodeArrayDisp = dispinterface;
  IControlDevice = interface;
  IControlDeviceDisp = dispinterface;
  ISafeguardUnit = interface;
  ISafeguardUnitDisp = dispinterface;
  ICriticalPoint = interface;
  ICriticalPointDisp = dispinterface;
  IFMRecomendation = interface;
  IFMRecomendationDisp = dispinterface;
  ISafeguardUnit2 = interface;
  ISafeguardUnit2Disp = dispinterface;
  IFMState = interface;
  IFMStateDisp = dispinterface;
  IBoundary3 = interface;
  IBoundary3Disp = dispinterface;
  IGuardArrival = interface;
  IGuardArrivalDisp = dispinterface;
  IImager = interface;
  IImagerDisp = dispinterface;
  IWidthIntf = interface;
  IWidthIntfDisp = dispinterface;
  IZone2 = interface;
  IZone2Disp = dispinterface;
  IStairBuilder = interface;
  IStairBuilderDisp = dispinterface;
  IElementParameterValue = interface;
  IElementParameterValueDisp = dispinterface;
  IInsiderTarget = interface;
  IInsiderTargetDisp = dispinterface;
  IControlDeviceAccess = interface;
  IControlDeviceAccessDisp = dispinterface;
  IGuardPostAccess = interface;
  IGuardPostAccessDisp = dispinterface;
  ISubBoundary = interface;
  ISubBoundaryDisp = dispinterface;
  IOvercomingBoundary = interface;
  IOvercomingBoundaryDisp = dispinterface;
  IPathNode = interface;
  IPathNodeDisp = dispinterface;
  IGuardGroup2 = interface;
  IGuardGroup2Disp = dispinterface;
  IGuardModel = interface;
  IGuardModelDisp = dispinterface;
  IZone3 = interface;
  IZone3Disp = dispinterface;
  IRefPathElement = interface;
  IRefPathElementDisp = dispinterface;
  IGoods = interface;
  IGoodsDisp = dispinterface;
  IObserver = interface;
  IObserverDisp = dispinterface;
  IGuardGroupState = interface;
  IGuardGroupStateDisp = dispinterface;
  IObservationElement = interface;
  IObservationElementDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FacilityModel = IFacilityModel;


// *********************************************************************//
// Interface: IFacilityModel
// Flags:     (320) Dual OleAutomation
// GUID:      {9DCB5BA3-14B5-11D6-932D-0050BA51A6D3}
// *********************************************************************//
  IFacilityModel = interface(IUnknown)
    ['{9DCB5BA3-14B5-11D6-932D-0050BA51A6D3}']
    function Get_Zones: IDMCollection; safecall;
    function Get_Boundaries: IDMCollection; safecall;
    function Get_BoundaryLayers: IDMCollection; safecall;
    function Get_FacilityStates: IDMCollection; safecall;
    function Get_FacilitySubStates: IDMCollection; safecall;
    function Get_ZoneStates: IDMCollection; safecall;
    function Get_BoundaryLayerStates: IDMCollection; safecall;
    function Get_SafeguardElementStates: IDMCollection; safecall;
    function Get_WarriorPaths: IDMCollection; safecall;
    function Get_Barriers: IDMCollection; safecall;
    function Get_BarrierFixtures: IDMCollection; safecall;
    function Get_Locks: IDMCollection; safecall;
    function Get_UndergroundObstacles: IDMCollection; safecall;
    function Get_ActiveSafeguards: IDMCollection; safecall;
    function Get_SurfaceSensors: IDMCollection; safecall;
    function Get_PositionSensors: IDMCollection; safecall;
    function Get_VolumeSensors: IDMCollection; safecall;
    function Get_BarrierSensors: IDMCollection; safecall;
    function Get_PerimeterSensors: IDMCollection; safecall;
    function Get_ContrabandSensors: IDMCollection; safecall;
    function Get_AccessControls: IDMCollection; safecall;
    function Get_TVCameras: IDMCollection; safecall;
    function Get_LightDevices: IDMCollection; safecall;
    function Get_CommunicationDevices: IDMCollection; safecall;
    function Get_SignalDevices: IDMCollection; safecall;
    function Get_PowerSources: IDMCollection; safecall;
    function Get_Cabels: IDMCollection; safecall;
    function Get_GuardPosts: IDMCollection; safecall;
    function Get_PatrolPaths: IDMCollection; safecall;
    function Get_Targets: IDMCollection; safecall;
    function Get_Conveyances: IDMCollection; safecall;
    function Get_LocalPointObjects: IDMCollection; safecall;
    function Get_Jumps: IDMCollection; safecall;
    function Get_StartPoints: IDMCollection; safecall;
    function Get_GuardVariants: IDMCollection; safecall;
    function Get_GuardGroups: IDMCollection; safecall;
    function Get_Weapons: IDMCollection; safecall;
    function Get_Vehicles: IDMCollection; safecall;
    function Get_Skills: IDMCollection; safecall;
    function Get_AdversaryVariants: IDMCollection; safecall;
    function Get_AdversaryGroups: IDMCollection; safecall;
    function Get_Tools: IDMCollection; safecall;
    function FindSeparatingAreas(C0X: Double; C0Y: Double; C0Z: Double; C1X: Double; C1Y: Double; 
                                 C1Z: Double; const C0Ref: IDMElement; const C1Ref: IDMElement; 
                                 WhileTransparent: Integer; const SeparatingAreas: IDMCollection; 
                                 var TransparencyCoeff: Double; const ExcludeArea0E: IDMElement; 
                                 const ExcludeArea1E: IDMElement): WordBool; safecall;
    function Get_SafeguardDatabase: IUnknown; safecall;
    function Get_Athorities: IDMCollection; safecall;
    function Get_Enviroments: IDMElement; safecall;
    function Get_AnalysisVariants: IDMCollection; safecall;
    function Get_CurrentBoundaryTactics: IDMCollection; safecall;
    function Get_ExtraTargets: IDMCollection; safecall;
    function Get_CurrentZoneTactics: IDMCollection; safecall;
    function Get_TechnicalServices: IDMCollection; safecall;
    function Get_CurrentTactic: IDMElement; safecall;
    procedure Set_CurrentTactic(const Value: IDMElement); safecall;
    function Get_Roads: IDMCollection; safecall;
    function Get_UserDefinedPaths: IDMCollection; safecall;
    function Get_Accesses: IDMCollection; safecall;
    function Get_GroundObstacles: IDMCollection; safecall;
    function Get_FenceObstacles: IDMCollection; safecall;
    function Get_DelayTimeDispersionRatio: Double; safecall;
    procedure Set_DelayTimeDispersionRatio(Value: Double); safecall;
    function Get_ResponceTimeDispersionRatio: Double; safecall;
    procedure Set_ResponceTimeDispersionRatio(Value: Double); safecall;
    function Get_BattleModel: IUnknown; safecall;
    procedure Set_BattleModel(const Value: IUnknown); safecall;
    function Get_BuildSectorLayer: IDMElement; safecall;
    procedure Set_BuildSectorLayer(const Value: IDMElement); safecall;
    function Get_DefaultReactionMode: Integer; safecall;
    procedure Set_DefaultReactionMode(Value: Integer); safecall;
    procedure CalcFalseAlarmPeriod(const FacilityStateE: IDMElement); safecall;
    function Get_CriticalFalseAlarmPeriod: Double; safecall;
    procedure Set_CriticalFalseAlarmPeriod(Value: Double); safecall;
    function Get_FalseAlarmPeriod: Double; safecall;
    procedure Set_FalseAlarmPeriod(Value: Double); safecall;
    function Get_UserDefinedElements: IDMCollection; safecall;
    function Get_UseBattleModel: WordBool; safecall;
    procedure Set_UseBattleModel(Value: WordBool); safecall;
    function Get_BuildAllVerticalWays: WordBool; safecall;
    procedure Set_BuildAllVerticalWays(Value: WordBool); safecall;
    function Get_WarriorPathElements: IDMCollection; safecall;
    function Get_Connections: IDMCollection; safecall;
    function Get_ControlDevices: IDMCollection; safecall;
    function Get_CurrencyRate: Double; safecall;
    procedure Set_CurrencyRate(Value: Double); safecall;
    function Get_PriceCoeffD: Double; safecall;
    procedure Set_PriceCoeffD(Value: Double); safecall;
    function Get_PriceCoeffTZSR: Double; safecall;
    procedure Set_PriceCoeffTZSR(Value: Double); safecall;
    function Get_PriceCoeffPNR: Double; safecall;
    procedure Set_PriceCoeffPNR(Value: Double); safecall;
    function Get_SafeguardSynthesis: IDataModel; safecall;
    function Get_CriticalPoints: IDMCollection; safecall;
    function Get_FMRecomendations: IDMCollection; safecall;
    procedure CalcEfficiency; safecall;
    function Get_TotalEfficiencyCalcMode: Integer; safecall;
    procedure Set_TotalEfficiencyCalcMode(Value: Integer); safecall;
    procedure CalcPrice(ModificationStage: Integer); safecall;
    function Get_TotalEfficiency: Double; safecall;
    function Get_TotalPrice: Double; safecall;
    procedure MakeRecomendations; safecall;
    procedure MakePersistant; safecall;
    function Get_FindCriticalPointsFlag: WordBool; safecall;
    procedure Set_FindCriticalPointsFlag(Value: WordBool); safecall;
    function Get_CurrentZoneFastTactics: IDMCollection; safecall;
    function Get_CurrentZoneStealthTactics: IDMCollection; safecall;
    function Get_UpdateDependingElementsBestMethodsFlag: WordBool; safecall;
    procedure Set_UpdateDependingElementsBestMethodsFlag(Value: WordBool); safecall;
    function Get_MaxBoundaryDistance: Double; safecall;
    procedure Set_MaxBoundaryDistance(Value: Double); safecall;
    function Get_MaxPathAlongBoundaryDistance: Double; safecall;
    procedure Set_MaxPathAlongBoundaryDistance(Value: Double); safecall;
    function Get_FastPathColor: Integer; safecall;
    procedure Set_FastPathColor(Value: Integer); safecall;
    function Get_StealthPathColor: Integer; safecall;
    procedure Set_StealthPathColor(Value: Integer); safecall;
    function Get_RationalPathColor: Integer; safecall;
    procedure Set_RationalPathColor(Value: Integer); safecall;
    function Get_GuardPathColor: Integer; safecall;
    procedure Set_GuardPathColor(Value: Integer); safecall;
    function Get_PathHeight: Double; safecall;
    procedure Set_PathHeight(Value: Double); safecall;
    function Get_ShoulderWidth: Double; safecall;
    procedure Set_ShoulderWidth(Value: Double); safecall;
    function Get_GraphColor: Integer; safecall;
    procedure Set_GraphColor(Value: Integer); safecall;
    procedure Reset(const BaseStateE: IDMElement); safecall;
    function Get_UserDefinedPathLayer: IDMElement; safecall;
    procedure Set_UserDefinedPathLayer(const Value: IDMElement); safecall;
    function Get_ShowSingleLayer: WordBool; safecall;
    procedure Set_ShowSingleLayer(Value: WordBool); safecall;
    function Get_ZoneDelayTimeDispersionRatio: Double; safecall;
    procedure Set_ZoneDelayTimeDispersionRatio(Value: Double); safecall;
    function Get_DefaultOpenZoneHeight: Double; safecall;
    procedure Set_DefaultOpenZoneHeight(Value: Double); safecall;
    function Get_OvercomingBoundaries: IDMCollection; safecall;
    function MakePathFrom(const NodeE: IDMElement; Reversed: WordBool; PathKind: Integer; 
                          UseStoredRecords: WordBool; const Paths: IDMCollection; 
                          const PathLayerE: IDMElement; var BoundaryPath: IDMElement): IDMElement; safecall;
    function Get_UseSimpleBattleModel: WordBool; safecall;
    procedure Set_UseSimpleBattleModel(Value: WordBool); safecall;
    property Zones: IDMCollection read Get_Zones;
    property Boundaries: IDMCollection read Get_Boundaries;
    property BoundaryLayers: IDMCollection read Get_BoundaryLayers;
    property FacilityStates: IDMCollection read Get_FacilityStates;
    property FacilitySubStates: IDMCollection read Get_FacilitySubStates;
    property ZoneStates: IDMCollection read Get_ZoneStates;
    property BoundaryLayerStates: IDMCollection read Get_BoundaryLayerStates;
    property SafeguardElementStates: IDMCollection read Get_SafeguardElementStates;
    property WarriorPaths: IDMCollection read Get_WarriorPaths;
    property Barriers: IDMCollection read Get_Barriers;
    property BarrierFixtures: IDMCollection read Get_BarrierFixtures;
    property Locks: IDMCollection read Get_Locks;
    property UndergroundObstacles: IDMCollection read Get_UndergroundObstacles;
    property ActiveSafeguards: IDMCollection read Get_ActiveSafeguards;
    property SurfaceSensors: IDMCollection read Get_SurfaceSensors;
    property PositionSensors: IDMCollection read Get_PositionSensors;
    property VolumeSensors: IDMCollection read Get_VolumeSensors;
    property BarrierSensors: IDMCollection read Get_BarrierSensors;
    property PerimeterSensors: IDMCollection read Get_PerimeterSensors;
    property ContrabandSensors: IDMCollection read Get_ContrabandSensors;
    property AccessControls: IDMCollection read Get_AccessControls;
    property TVCameras: IDMCollection read Get_TVCameras;
    property LightDevices: IDMCollection read Get_LightDevices;
    property CommunicationDevices: IDMCollection read Get_CommunicationDevices;
    property SignalDevices: IDMCollection read Get_SignalDevices;
    property PowerSources: IDMCollection read Get_PowerSources;
    property Cabels: IDMCollection read Get_Cabels;
    property GuardPosts: IDMCollection read Get_GuardPosts;
    property PatrolPaths: IDMCollection read Get_PatrolPaths;
    property Targets: IDMCollection read Get_Targets;
    property Conveyances: IDMCollection read Get_Conveyances;
    property LocalPointObjects: IDMCollection read Get_LocalPointObjects;
    property Jumps: IDMCollection read Get_Jumps;
    property StartPoints: IDMCollection read Get_StartPoints;
    property GuardVariants: IDMCollection read Get_GuardVariants;
    property GuardGroups: IDMCollection read Get_GuardGroups;
    property Weapons: IDMCollection read Get_Weapons;
    property Vehicles: IDMCollection read Get_Vehicles;
    property Skills: IDMCollection read Get_Skills;
    property AdversaryVariants: IDMCollection read Get_AdversaryVariants;
    property AdversaryGroups: IDMCollection read Get_AdversaryGroups;
    property Tools: IDMCollection read Get_Tools;
    property SafeguardDatabase: IUnknown read Get_SafeguardDatabase;
    property Athorities: IDMCollection read Get_Athorities;
    property Enviroments: IDMElement read Get_Enviroments;
    property AnalysisVariants: IDMCollection read Get_AnalysisVariants;
    property CurrentBoundaryTactics: IDMCollection read Get_CurrentBoundaryTactics;
    property ExtraTargets: IDMCollection read Get_ExtraTargets;
    property CurrentZoneTactics: IDMCollection read Get_CurrentZoneTactics;
    property TechnicalServices: IDMCollection read Get_TechnicalServices;
    property CurrentTactic: IDMElement read Get_CurrentTactic write Set_CurrentTactic;
    property Roads: IDMCollection read Get_Roads;
    property UserDefinedPaths: IDMCollection read Get_UserDefinedPaths;
    property Accesses: IDMCollection read Get_Accesses;
    property GroundObstacles: IDMCollection read Get_GroundObstacles;
    property FenceObstacles: IDMCollection read Get_FenceObstacles;
    property DelayTimeDispersionRatio: Double read Get_DelayTimeDispersionRatio write Set_DelayTimeDispersionRatio;
    property ResponceTimeDispersionRatio: Double read Get_ResponceTimeDispersionRatio write Set_ResponceTimeDispersionRatio;
    property BattleModel: IUnknown read Get_BattleModel write Set_BattleModel;
    property BuildSectorLayer: IDMElement read Get_BuildSectorLayer write Set_BuildSectorLayer;
    property DefaultReactionMode: Integer read Get_DefaultReactionMode write Set_DefaultReactionMode;
    property CriticalFalseAlarmPeriod: Double read Get_CriticalFalseAlarmPeriod write Set_CriticalFalseAlarmPeriod;
    property FalseAlarmPeriod: Double read Get_FalseAlarmPeriod write Set_FalseAlarmPeriod;
    property UserDefinedElements: IDMCollection read Get_UserDefinedElements;
    property UseBattleModel: WordBool read Get_UseBattleModel write Set_UseBattleModel;
    property BuildAllVerticalWays: WordBool read Get_BuildAllVerticalWays write Set_BuildAllVerticalWays;
    property WarriorPathElements: IDMCollection read Get_WarriorPathElements;
    property Connections: IDMCollection read Get_Connections;
    property ControlDevices: IDMCollection read Get_ControlDevices;
    property CurrencyRate: Double read Get_CurrencyRate write Set_CurrencyRate;
    property PriceCoeffD: Double read Get_PriceCoeffD write Set_PriceCoeffD;
    property PriceCoeffTZSR: Double read Get_PriceCoeffTZSR write Set_PriceCoeffTZSR;
    property PriceCoeffPNR: Double read Get_PriceCoeffPNR write Set_PriceCoeffPNR;
    property SafeguardSynthesis: IDataModel read Get_SafeguardSynthesis;
    property CriticalPoints: IDMCollection read Get_CriticalPoints;
    property FMRecomendations: IDMCollection read Get_FMRecomendations;
    property TotalEfficiencyCalcMode: Integer read Get_TotalEfficiencyCalcMode write Set_TotalEfficiencyCalcMode;
    property TotalEfficiency: Double read Get_TotalEfficiency;
    property TotalPrice: Double read Get_TotalPrice;
    property FindCriticalPointsFlag: WordBool read Get_FindCriticalPointsFlag write Set_FindCriticalPointsFlag;
    property CurrentZoneFastTactics: IDMCollection read Get_CurrentZoneFastTactics;
    property CurrentZoneStealthTactics: IDMCollection read Get_CurrentZoneStealthTactics;
    property UpdateDependingElementsBestMethodsFlag: WordBool read Get_UpdateDependingElementsBestMethodsFlag write Set_UpdateDependingElementsBestMethodsFlag;
    property MaxBoundaryDistance: Double read Get_MaxBoundaryDistance write Set_MaxBoundaryDistance;
    property MaxPathAlongBoundaryDistance: Double read Get_MaxPathAlongBoundaryDistance write Set_MaxPathAlongBoundaryDistance;
    property FastPathColor: Integer read Get_FastPathColor write Set_FastPathColor;
    property StealthPathColor: Integer read Get_StealthPathColor write Set_StealthPathColor;
    property RationalPathColor: Integer read Get_RationalPathColor write Set_RationalPathColor;
    property GuardPathColor: Integer read Get_GuardPathColor write Set_GuardPathColor;
    property PathHeight: Double read Get_PathHeight write Set_PathHeight;
    property ShoulderWidth: Double read Get_ShoulderWidth write Set_ShoulderWidth;
    property GraphColor: Integer read Get_GraphColor write Set_GraphColor;
    property UserDefinedPathLayer: IDMElement read Get_UserDefinedPathLayer write Set_UserDefinedPathLayer;
    property ShowSingleLayer: WordBool read Get_ShowSingleLayer write Set_ShowSingleLayer;
    property ZoneDelayTimeDispersionRatio: Double read Get_ZoneDelayTimeDispersionRatio write Set_ZoneDelayTimeDispersionRatio;
    property DefaultOpenZoneHeight: Double read Get_DefaultOpenZoneHeight write Set_DefaultOpenZoneHeight;
    property OvercomingBoundaries: IDMCollection read Get_OvercomingBoundaries;
    property UseSimpleBattleModel: WordBool read Get_UseSimpleBattleModel write Set_UseSimpleBattleModel;
  end;

// *********************************************************************//
// DispIntf:  IFacilityModelDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {9DCB5BA3-14B5-11D6-932D-0050BA51A6D3}
// *********************************************************************//
  IFacilityModelDisp = dispinterface
    ['{9DCB5BA3-14B5-11D6-932D-0050BA51A6D3}']
    property Zones: IDMCollection readonly dispid 3;
    property Boundaries: IDMCollection readonly dispid 6;
    property BoundaryLayers: IDMCollection readonly dispid 7;
    property FacilityStates: IDMCollection readonly dispid 9;
    property FacilitySubStates: IDMCollection readonly dispid 10;
    property ZoneStates: IDMCollection readonly dispid 11;
    property BoundaryLayerStates: IDMCollection readonly dispid 13;
    property SafeguardElementStates: IDMCollection readonly dispid 15;
    property WarriorPaths: IDMCollection readonly dispid 16;
    property Barriers: IDMCollection readonly dispid 17;
    property BarrierFixtures: IDMCollection readonly dispid 18;
    property Locks: IDMCollection readonly dispid 19;
    property UndergroundObstacles: IDMCollection readonly dispid 20;
    property ActiveSafeguards: IDMCollection readonly dispid 21;
    property SurfaceSensors: IDMCollection readonly dispid 22;
    property PositionSensors: IDMCollection readonly dispid 23;
    property VolumeSensors: IDMCollection readonly dispid 24;
    property BarrierSensors: IDMCollection readonly dispid 25;
    property PerimeterSensors: IDMCollection readonly dispid 26;
    property ContrabandSensors: IDMCollection readonly dispid 27;
    property AccessControls: IDMCollection readonly dispid 28;
    property TVCameras: IDMCollection readonly dispid 29;
    property LightDevices: IDMCollection readonly dispid 30;
    property CommunicationDevices: IDMCollection readonly dispid 31;
    property SignalDevices: IDMCollection readonly dispid 32;
    property PowerSources: IDMCollection readonly dispid 33;
    property Cabels: IDMCollection readonly dispid 34;
    property GuardPosts: IDMCollection readonly dispid 35;
    property PatrolPaths: IDMCollection readonly dispid 36;
    property Targets: IDMCollection readonly dispid 37;
    property Conveyances: IDMCollection readonly dispid 38;
    property LocalPointObjects: IDMCollection readonly dispid 39;
    property Jumps: IDMCollection readonly dispid 40;
    property StartPoints: IDMCollection readonly dispid 41;
    property GuardVariants: IDMCollection readonly dispid 42;
    property GuardGroups: IDMCollection readonly dispid 43;
    property Weapons: IDMCollection readonly dispid 44;
    property Vehicles: IDMCollection readonly dispid 45;
    property Skills: IDMCollection readonly dispid 46;
    property AdversaryVariants: IDMCollection readonly dispid 48;
    property AdversaryGroups: IDMCollection readonly dispid 49;
    property Tools: IDMCollection readonly dispid 55;
    function FindSeparatingAreas(C0X: Double; C0Y: Double; C0Z: Double; C1X: Double; C1Y: Double; 
                                 C1Z: Double; const C0Ref: IDMElement; const C1Ref: IDMElement; 
                                 WhileTransparent: Integer; const SeparatingAreas: IDMCollection; 
                                 var TransparencyCoeff: Double; const ExcludeArea0E: IDMElement; 
                                 const ExcludeArea1E: IDMElement): WordBool; dispid 56;
    property SafeguardDatabase: IUnknown readonly dispid 57;
    property Athorities: IDMCollection readonly dispid 50;
    property Enviroments: IDMElement readonly dispid 51;
    property AnalysisVariants: IDMCollection readonly dispid 52;
    property CurrentBoundaryTactics: IDMCollection readonly dispid 53;
    property ExtraTargets: IDMCollection readonly dispid 58;
    property CurrentZoneTactics: IDMCollection readonly dispid 59;
    property TechnicalServices: IDMCollection readonly dispid 8;
    property CurrentTactic: IDMElement dispid 14;
    property Roads: IDMCollection readonly dispid 60;
    property UserDefinedPaths: IDMCollection readonly dispid 61;
    property Accesses: IDMCollection readonly dispid 62;
    property GroundObstacles: IDMCollection readonly dispid 63;
    property FenceObstacles: IDMCollection readonly dispid 64;
    property DelayTimeDispersionRatio: Double dispid 65;
    property ResponceTimeDispersionRatio: Double dispid 66;
    property BattleModel: IUnknown dispid 67;
    property BuildSectorLayer: IDMElement dispid 68;
    property DefaultReactionMode: Integer dispid 47;
    procedure CalcFalseAlarmPeriod(const FacilityStateE: IDMElement); dispid 69;
    property CriticalFalseAlarmPeriod: Double dispid 71;
    property FalseAlarmPeriod: Double dispid 70;
    property UserDefinedElements: IDMCollection readonly dispid 72;
    property UseBattleModel: WordBool dispid 73;
    property BuildAllVerticalWays: WordBool dispid 12;
    property WarriorPathElements: IDMCollection readonly dispid 74;
    property Connections: IDMCollection readonly dispid 76;
    property ControlDevices: IDMCollection readonly dispid 77;
    property CurrencyRate: Double dispid 78;
    property PriceCoeffD: Double dispid 79;
    property PriceCoeffTZSR: Double dispid 80;
    property PriceCoeffPNR: Double dispid 81;
    property SafeguardSynthesis: IDataModel readonly dispid 82;
    property CriticalPoints: IDMCollection readonly dispid 83;
    property FMRecomendations: IDMCollection readonly dispid 84;
    procedure CalcEfficiency; dispid 86;
    property TotalEfficiencyCalcMode: Integer dispid 85;
    procedure CalcPrice(ModificationStage: Integer); dispid 87;
    property TotalEfficiency: Double readonly dispid 88;
    property TotalPrice: Double readonly dispid 89;
    procedure MakeRecomendations; dispid 90;
    procedure MakePersistant; dispid 91;
    property FindCriticalPointsFlag: WordBool dispid 93;
    property CurrentZoneFastTactics: IDMCollection readonly dispid 92;
    property CurrentZoneStealthTactics: IDMCollection readonly dispid 95;
    property UpdateDependingElementsBestMethodsFlag: WordBool dispid 94;
    property MaxBoundaryDistance: Double dispid 4;
    property MaxPathAlongBoundaryDistance: Double dispid 5;
    property FastPathColor: Integer dispid 54;
    property StealthPathColor: Integer dispid 75;
    property RationalPathColor: Integer dispid 96;
    property GuardPathColor: Integer dispid 97;
    property PathHeight: Double dispid 98;
    property ShoulderWidth: Double dispid 99;
    property GraphColor: Integer dispid 100;
    procedure Reset(const BaseStateE: IDMElement); dispid 101;
    property UserDefinedPathLayer: IDMElement dispid 102;
    property ShowSingleLayer: WordBool dispid 104;
    property ZoneDelayTimeDispersionRatio: Double dispid 105;
    property DefaultOpenZoneHeight: Double dispid 1;
    property OvercomingBoundaries: IDMCollection readonly dispid 2;
    function MakePathFrom(const NodeE: IDMElement; Reversed: WordBool; PathKind: Integer; 
                          UseStoredRecords: WordBool; const Paths: IDMCollection; 
                          const PathLayerE: IDMElement; var BoundaryPath: IDMElement): IDMElement; dispid 103;
    property UseSimpleBattleModel: WordBool dispid 106;
  end;

// *********************************************************************//
// Interface: IZone
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591BC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IZone = interface(IUnknown)
    ['{5F8591BC-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_Zones: IDMCollection; safecall;
    function Get_LinkedZone: IZone; safecall;
    procedure Set_LinkedZone(const Value: IZone); safecall;
    function Get_RelativeDelayTimeToTarget: Double; safecall;
    procedure Set_RelativeDelayTimeToTarget(Value: Double); safecall;
    function Contains(const aElement: IDMElement): WordBool; safecall;
    function Get_FloorNodes: IDMCollection; safecall;
    function Get_CentralNode: IDMElement; safecall;
    procedure Set_CentralNode(const Value: IDMElement); safecall;
    function Get_PersonalPresence: Integer; safecall;
    function Get_PersonalCount: Integer; safecall;
    function Get_Category: Integer; safecall;
    procedure Set_Category(Value: Integer); safecall;
    function Get_PatrolPaths: IDMCollection; safecall;
    procedure CalcPatrolPeriod; safecall;
    function Get_TransparencyDist: Double; safecall;
    function Get_Observers: IDMCollection; safecall;
    function Get_VehicleVelocity: Double; safecall;
    function Get_PedestrialVelocity: Double; safecall;
    procedure MakeHVAreas(const theHAreas: IDMCollection; const theVAreas: IDMCollection; 
                          var AddFlag: WordBool); safecall;
    function Get_VAreas: IDMCollection; safecall;
    function Get_HAreas: IDMCollection; safecall;
    function Get_Jumps: IDMCollection; safecall;
    function GetMaxVelocity(var VehicleKindE: IDMElement; var PedestrialVelocity: Double; 
                            var MovementKind: Integer): Double; safecall;
    function GetMovementDelayTime(var MovementKind: Integer): Double; safecall;
    function Get_PatrolPeriod: Double; safecall;
    property Zones: IDMCollection read Get_Zones;
    property LinkedZone: IZone read Get_LinkedZone write Set_LinkedZone;
    property RelativeDelayTimeToTarget: Double read Get_RelativeDelayTimeToTarget write Set_RelativeDelayTimeToTarget;
    property FloorNodes: IDMCollection read Get_FloorNodes;
    property CentralNode: IDMElement read Get_CentralNode write Set_CentralNode;
    property PersonalPresence: Integer read Get_PersonalPresence;
    property PersonalCount: Integer read Get_PersonalCount;
    property Category: Integer read Get_Category write Set_Category;
    property PatrolPaths: IDMCollection read Get_PatrolPaths;
    property TransparencyDist: Double read Get_TransparencyDist;
    property Observers: IDMCollection read Get_Observers;
    property VehicleVelocity: Double read Get_VehicleVelocity;
    property PedestrialVelocity: Double read Get_PedestrialVelocity;
    property VAreas: IDMCollection read Get_VAreas;
    property HAreas: IDMCollection read Get_HAreas;
    property Jumps: IDMCollection read Get_Jumps;
    property PatrolPeriod: Double read Get_PatrolPeriod;
  end;

// *********************************************************************//
// DispIntf:  IZoneDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591BC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IZoneDisp = dispinterface
    ['{5F8591BC-0FE6-11D6-9328-0050BA51A6D3}']
    property Zones: IDMCollection readonly dispid 2;
    property LinkedZone: IZone dispid 4;
    property RelativeDelayTimeToTarget: Double dispid 3;
    function Contains(const aElement: IDMElement): WordBool; dispid 5;
    property FloorNodes: IDMCollection readonly dispid 6;
    property CentralNode: IDMElement dispid 7;
    property PersonalPresence: Integer readonly dispid 9;
    property PersonalCount: Integer readonly dispid 10;
    property Category: Integer dispid 8;
    property PatrolPaths: IDMCollection readonly dispid 12;
    procedure CalcPatrolPeriod; dispid 13;
    property TransparencyDist: Double readonly dispid 14;
    property Observers: IDMCollection readonly dispid 15;
    property VehicleVelocity: Double readonly dispid 18;
    property PedestrialVelocity: Double readonly dispid 19;
    procedure MakeHVAreas(const theHAreas: IDMCollection; const theVAreas: IDMCollection; 
                          var AddFlag: WordBool); dispid 23;
    property VAreas: IDMCollection readonly dispid 24;
    property HAreas: IDMCollection readonly dispid 25;
    property Jumps: IDMCollection readonly dispid 26;
    function GetMaxVelocity(var VehicleKindE: IDMElement; var PedestrialVelocity: Double; 
                            var MovementKind: Integer): Double; dispid 1;
    function GetMovementDelayTime(var MovementKind: Integer): Double; dispid 30;
    property PatrolPeriod: Double readonly dispid 31;
  end;

// *********************************************************************//
// Interface: IBoundary
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591BE-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBoundary = interface(IUnknown)
    ['{5F8591BE-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_FastPath: IWarriorPath; safecall;
    function Get_StealthPath: IWarriorPath; safecall;
    function Get_OptimalPath: IWarriorPath; safecall;
    function Get_BoundaryLayers: IDMCollection; safecall;
    function Get_FlowIntencity: Integer; safecall;
    function Get_Observers: IDMCollection; safecall;
    function MakeTemporyPath: IDMElement; safecall;
    function Get_Zone0: IDMElement; safecall;
    procedure Set_Zone0(const Value: IDMElement); safecall;
    function Get_Zone1: IDMElement; safecall;
    procedure Set_Zone1(const Value: IDMElement); safecall;
    procedure CalcExternalDelayTime(out dT: Double; out dTDisp: Double; out BestTacticE: IDMElement); safecall;
    function Get_NeighbourDist0: Double; safecall;
    function Get_NeighbourDist1: Double; safecall;
    procedure Reset(const BaseStateE: IDMElement); safecall;
    function Get_WarriorPaths: IDMCollection; safecall;
    function Get_BackRefs: IDMCollection; safecall;
    procedure CalcGuardTactic; safecall;
    function Get_GuardDelayTimeFromStart: Double; safecall;
    function Get_GuardDelayTimeFromStartDispersion: Double; safecall;
    function Get_GuardDelayTimeToTarget: Double; safecall;
    function Get_GuardDelayTimeToTargetDispersion: Double; safecall;
    function Get_AlarmGroup: IDMElement; safecall;
    function Get_BattleTime: Double; safecall;
    function Get_BattleTimeDispersion: Double; safecall;
    function Get_BattleVictoryProbability: Double; safecall;
    function GetPassVelocity: Double; safecall;
    function Get_BlockGroup: IDMElement; safecall;
    procedure Set_BlockGroup(const Value: IDMElement); safecall;
    function Get_IsFragile: WordBool; safecall;
    procedure ClearCash(ClearElements: WordBool); safecall;
    property FastPath: IWarriorPath read Get_FastPath;
    property StealthPath: IWarriorPath read Get_StealthPath;
    property OptimalPath: IWarriorPath read Get_OptimalPath;
    property BoundaryLayers: IDMCollection read Get_BoundaryLayers;
    property FlowIntencity: Integer read Get_FlowIntencity;
    property Observers: IDMCollection read Get_Observers;
    property Zone0: IDMElement read Get_Zone0 write Set_Zone0;
    property Zone1: IDMElement read Get_Zone1 write Set_Zone1;
    property NeighbourDist0: Double read Get_NeighbourDist0;
    property NeighbourDist1: Double read Get_NeighbourDist1;
    property WarriorPaths: IDMCollection read Get_WarriorPaths;
    property BackRefs: IDMCollection read Get_BackRefs;
    property GuardDelayTimeFromStart: Double read Get_GuardDelayTimeFromStart;
    property GuardDelayTimeFromStartDispersion: Double read Get_GuardDelayTimeFromStartDispersion;
    property GuardDelayTimeToTarget: Double read Get_GuardDelayTimeToTarget;
    property GuardDelayTimeToTargetDispersion: Double read Get_GuardDelayTimeToTargetDispersion;
    property AlarmGroup: IDMElement read Get_AlarmGroup;
    property BattleTime: Double read Get_BattleTime;
    property BattleTimeDispersion: Double read Get_BattleTimeDispersion;
    property BattleVictoryProbability: Double read Get_BattleVictoryProbability;
    property BlockGroup: IDMElement read Get_BlockGroup write Set_BlockGroup;
    property IsFragile: WordBool read Get_IsFragile;
  end;

// *********************************************************************//
// DispIntf:  IBoundaryDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591BE-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBoundaryDisp = dispinterface
    ['{5F8591BE-0FE6-11D6-9328-0050BA51A6D3}']
    property FastPath: IWarriorPath readonly dispid 5;
    property StealthPath: IWarriorPath readonly dispid 6;
    property OptimalPath: IWarriorPath readonly dispid 7;
    property BoundaryLayers: IDMCollection readonly dispid 8;
    property FlowIntencity: Integer readonly dispid 12;
    property Observers: IDMCollection readonly dispid 13;
    function MakeTemporyPath: IDMElement; dispid 18;
    property Zone0: IDMElement dispid 2;
    property Zone1: IDMElement dispid 3;
    procedure CalcExternalDelayTime(out dT: Double; out dTDisp: Double; out BestTacticE: IDMElement); dispid 4;
    property NeighbourDist0: Double readonly dispid 9;
    property NeighbourDist1: Double readonly dispid 10;
    procedure Reset(const BaseStateE: IDMElement); dispid 11;
    property WarriorPaths: IDMCollection readonly dispid 23;
    property BackRefs: IDMCollection readonly dispid 26;
    procedure CalcGuardTactic; dispid 24;
    property GuardDelayTimeFromStart: Double readonly dispid 25;
    property GuardDelayTimeFromStartDispersion: Double readonly dispid 28;
    property GuardDelayTimeToTarget: Double readonly dispid 29;
    property GuardDelayTimeToTargetDispersion: Double readonly dispid 30;
    property AlarmGroup: IDMElement readonly dispid 31;
    property BattleTime: Double readonly dispid 32;
    property BattleTimeDispersion: Double readonly dispid 33;
    property BattleVictoryProbability: Double readonly dispid 34;
    function GetPassVelocity: Double; dispid 35;
    property BlockGroup: IDMElement dispid 38;
    property IsFragile: WordBool readonly dispid 14;
    procedure ClearCash(ClearElements: WordBool); dispid 1;
  end;

// *********************************************************************//
// Interface: IBoundaryLayer
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591C0-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBoundaryLayer = interface(IUnknown)
    ['{5F8591C0-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_DistanceFromPrev: Double; safecall;
    function Get_X0: Double; safecall;
    procedure Set_X0(Value: Double); safecall;
    function Get_Y0: Double; safecall;
    procedure Set_Y0(Value: Double); safecall;
    function Get_X1: Double; safecall;
    procedure Set_X1(Value: Double); safecall;
    function Get_Y1: Double; safecall;
    procedure Set_Y1(Value: Double); safecall;
    function Get_Neighbour0: IDMElement; safecall;
    procedure Set_Neighbour0(const Value: IDMElement); safecall;
    function Get_Neighbour1: IDMElement; safecall;
    procedure Set_Neighbour1(const Value: IDMElement); safecall;
    function Get_Prev: IDMElement; safecall;
    procedure Set_Prev(const Value: IDMElement); safecall;
    procedure Reset(const BaseStateE: IDMElement); safecall;
    function AcceptableTactic(const TacticU: IUnknown): WordBool; safecall;
    function Get_SubBoundaries: IDMCollection; safecall;
    procedure ClearCash(ClearElements: WordBool); safecall;
    function Get_Construction: Integer; safecall;
    function Get_Height0: Double; safecall;
    procedure Set_Height0(Value: Double); safecall;
    function Get_Height1: Double; safecall;
    procedure Set_Height1(Value: Double); safecall;
    procedure CalcParams(AddDelay: Double); safecall;
    procedure CalcGuardDelayTime(out DelayTime: Double; out DelayTimeDispersion: Double; 
                                 out BestTacticE: IDMElement; AddDelay: Double); safecall;
    function Get_Visible0: WordBool; safecall;
    procedure Set_Visible0(Value: WordBool); safecall;
    function Get_Visible1: WordBool; safecall;
    procedure Set_Visible1(Value: WordBool); safecall;
    procedure CalcPathSuccessProbability(var SuccessProbability: Double; 
                                         out OutstripProbability: Double; var DelayTimeSum: Double; 
                                         var DelayTimeDispSum: Double; AddDelay: Double); safecall;
    procedure DoCalcDelayTime(const TacticU: IUnknown; out DelayTime: Double; 
                              out DelayTimeDisp: Double; AddDelay: Double); safecall;
    procedure DoCalcNoDetectionProbability(const TacticU: IUnknown; ObservationPeriod: Double; 
                                           out NoDetP: Double; out NoFailureP: Double; 
                                           out NoEvidence: WordBool; out BestTimeSum: Double; 
                                           out BestTimeDispSum: Double; out Position: Integer; 
                                           AddDelay: Integer); safecall;
    procedure CalcDelayTime(out DelayTime: Double; out DelayTimeDisp: Double; AddDelay: Double); safecall;
    procedure CalcNoDetectionProbability(out NoDetP: Double; out NoFailureP: Double; 
                                         out NoEvidence: WordBool; out BestTimeSum: Double; 
                                         out BestTimeDispSum: Double; out Position: Integer; 
                                         AddDelay: Double); safecall;
    property DistanceFromPrev: Double read Get_DistanceFromPrev;
    property X0: Double read Get_X0 write Set_X0;
    property Y0: Double read Get_Y0 write Set_Y0;
    property X1: Double read Get_X1 write Set_X1;
    property Y1: Double read Get_Y1 write Set_Y1;
    property Neighbour0: IDMElement read Get_Neighbour0 write Set_Neighbour0;
    property Neighbour1: IDMElement read Get_Neighbour1 write Set_Neighbour1;
    property Prev: IDMElement read Get_Prev write Set_Prev;
    property SubBoundaries: IDMCollection read Get_SubBoundaries;
    property Construction: Integer read Get_Construction;
    property Height0: Double read Get_Height0 write Set_Height0;
    property Height1: Double read Get_Height1 write Set_Height1;
    property Visible0: WordBool read Get_Visible0 write Set_Visible0;
    property Visible1: WordBool read Get_Visible1 write Set_Visible1;
  end;

// *********************************************************************//
// DispIntf:  IBoundaryLayerDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591C0-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBoundaryLayerDisp = dispinterface
    ['{5F8591C0-0FE6-11D6-9328-0050BA51A6D3}']
    property DistanceFromPrev: Double readonly dispid 1;
    property X0: Double dispid 4;
    property Y0: Double dispid 5;
    property X1: Double dispid 7;
    property Y1: Double dispid 8;
    property Neighbour0: IDMElement dispid 9;
    property Neighbour1: IDMElement dispid 10;
    property Prev: IDMElement dispid 11;
    procedure Reset(const BaseStateE: IDMElement); dispid 12;
    function AcceptableTactic(const TacticU: IUnknown): WordBool; dispid 13;
    property SubBoundaries: IDMCollection readonly dispid 2;
    procedure ClearCash(ClearElements: WordBool); dispid 15;
    property Construction: Integer readonly dispid 16;
    property Height0: Double dispid 3;
    property Height1: Double dispid 6;
    procedure CalcParams(AddDelay: Double); dispid 14;
    procedure CalcGuardDelayTime(out DelayTime: Double; out DelayTimeDispersion: Double; 
                                 out BestTacticE: IDMElement; AddDelay: Double); dispid 17;
    property Visible0: WordBool dispid 20;
    property Visible1: WordBool dispid 21;
    procedure CalcPathSuccessProbability(var SuccessProbability: Double; 
                                         out OutstripProbability: Double; var DelayTimeSum: Double; 
                                         var DelayTimeDispSum: Double; AddDelay: Double); dispid 18;
    procedure DoCalcDelayTime(const TacticU: IUnknown; out DelayTime: Double; 
                              out DelayTimeDisp: Double; AddDelay: Double); dispid 19;
    procedure DoCalcNoDetectionProbability(const TacticU: IUnknown; ObservationPeriod: Double; 
                                           out NoDetP: Double; out NoFailureP: Double; 
                                           out NoEvidence: WordBool; out BestTimeSum: Double; 
                                           out BestTimeDispSum: Double; out Position: Integer; 
                                           AddDelay: Integer); dispid 22;
    procedure CalcDelayTime(out DelayTime: Double; out DelayTimeDisp: Double; AddDelay: Double); dispid 23;
    procedure CalcNoDetectionProbability(out NoDetP: Double; out NoFailureP: Double; 
                                         out NoEvidence: WordBool; out BestTimeSum: Double; 
                                         out BestTimeDispSum: Double; out Position: Integer; 
                                         AddDelay: Double); dispid 24;
  end;

// *********************************************************************//
// Interface: IFacilityState
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591C4-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IFacilityState = interface(IUnknown)
    ['{5F8591C4-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_GraphIndex: Integer; safecall;
    procedure Set_GraphIndex(Value: Integer); safecall;
    function Get_ModificationStage: SYSINT; safecall;
    procedure Set_ModificationStage(Value: SYSINT); safecall;
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    function Get_SubStateCount: Integer; safecall;
    function Get_SubState(Index: Integer): IDMElement; safecall;
    procedure AddSubState(const aSubState: IDMElement); safecall;
    procedure RemoveSubState(const aSubState: IDMElement); safecall;
    property GraphIndex: Integer read Get_GraphIndex write Set_GraphIndex;
    property ModificationStage: SYSINT read Get_ModificationStage write Set_ModificationStage;
    property Kind: Integer read Get_Kind write Set_Kind;
    property SubStateCount: Integer read Get_SubStateCount;
    property SubState[Index: Integer]: IDMElement read Get_SubState;
  end;

// *********************************************************************//
// DispIntf:  IFacilityStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591C4-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IFacilityStateDisp = dispinterface
    ['{5F8591C4-0FE6-11D6-9328-0050BA51A6D3}']
    property GraphIndex: Integer dispid 2;
    property ModificationStage: SYSINT dispid 3;
    property Kind: Integer dispid 4;
    property SubStateCount: Integer readonly dispid 1;
    property SubState[Index: Integer]: IDMElement readonly dispid 5;
    procedure AddSubState(const aSubState: IDMElement); dispid 6;
    procedure RemoveSubState(const aSubState: IDMElement); dispid 7;
  end;

// *********************************************************************//
// Interface: IFacilitySubState
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591C6-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IFacilitySubState = interface(IUnknown)
    ['{5F8591C6-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_ElementStates: IDMCollection; safecall;
    property ElementStates: IDMCollection read Get_ElementStates;
  end;

// *********************************************************************//
// DispIntf:  IFacilitySubStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591C6-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IFacilitySubStateDisp = dispinterface
    ['{5F8591C6-0FE6-11D6-9328-0050BA51A6D3}']
    property ElementStates: IDMCollection readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IZoneState
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591C8-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IZoneState = interface(IUnknown)
    ['{5F8591C8-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_PersonalPresence: Integer; safecall;
    function Get_PersonalCount: Integer; safecall;
    function Get_TransparencyDist: Double; safecall;
    function Get_UserDefinedVehicleVelocity: WordBool; safecall;
    function Get_PedestrialVelocity: Double; safecall;
    function Get_VehicleVelocity: Double; safecall;
    procedure Set_VehicleVelocity(Value: Double); safecall;
    property PersonalPresence: Integer read Get_PersonalPresence;
    property PersonalCount: Integer read Get_PersonalCount;
    property TransparencyDist: Double read Get_TransparencyDist;
    property UserDefinedVehicleVelocity: WordBool read Get_UserDefinedVehicleVelocity;
    property PedestrialVelocity: Double read Get_PedestrialVelocity;
    property VehicleVelocity: Double read Get_VehicleVelocity write Set_VehicleVelocity;
  end;

// *********************************************************************//
// DispIntf:  IZoneStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591C8-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IZoneStateDisp = dispinterface
    ['{5F8591C8-0FE6-11D6-9328-0050BA51A6D3}']
    property PersonalPresence: Integer readonly dispid 1;
    property PersonalCount: Integer readonly dispid 2;
    property TransparencyDist: Double readonly dispid 3;
    property UserDefinedVehicleVelocity: WordBool readonly dispid 4;
    property PedestrialVelocity: Double readonly dispid 6;
    property VehicleVelocity: Double dispid 7;
  end;

// *********************************************************************//
// Interface: IBoundaryLayerState
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591CC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBoundaryLayerState = interface(IUnknown)
    ['{5F8591CC-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IBoundaryLayerStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591CC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBoundaryLayerStateDisp = dispinterface
    ['{5F8591CC-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: ISafeguardElementState
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D0-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ISafeguardElementState = interface(IUnknown)
    ['{5F8591D0-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_DeviceState0: IDMElement; safecall;
    procedure Set_DeviceState0(const Value: IDMElement); safecall;
    function Get_DeviceState1: IDMElement; safecall;
    procedure Set_DeviceState1(const Value: IDMElement); safecall;
    property DeviceState0: IDMElement read Get_DeviceState0 write Set_DeviceState0;
    property DeviceState1: IDMElement read Get_DeviceState1 write Set_DeviceState1;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardElementStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D0-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ISafeguardElementStateDisp = dispinterface
    ['{5F8591D0-0FE6-11D6-9328-0050BA51A6D3}']
    property DeviceState0: IDMElement dispid 4;
    property DeviceState1: IDMElement dispid 1;
  end;

// *********************************************************************//
// Interface: IWarriorPath
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D2-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IWarriorPath = interface(IUnknown)
    ['{5F8591D2-0FE6-11D6-9328-0050BA51A6D3}']
    procedure DoAnalysis(const InitialPathElementE: IDMElement; DirectPath: WordBool); safecall;
    function Get_DelayTime: Double; safecall;
    function Get_NoDetectionProbability: Double; safecall;
    function Get_RationalProbability: Double; safecall;
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    function Get_WarriorPathElements: IDMCollection; safecall;
    procedure Build(TreeMode: Integer; Revers: WordBool; DirectPath: WordBool; 
                    const InitialPathElementE: IDMElement); safecall;
    function Get_DelayTimeDispersion: Double; safecall;
    function Get_CriticalPoint: IDMElement; safecall;
    procedure Set_CriticalPoint(const Value: IDMElement); safecall;
    function Get_OvercomingBoundaries: IDMCollection; safecall;
    function Get_FirstNode: IDMElement; safecall;
    procedure Set_FirstNode(const Value: IDMElement); safecall;
    function Get_PathNodes: IDMCollection; safecall;
    procedure Analysis; safecall;
    function Get_GuardTacticFlag: WordBool; safecall;
    procedure Set_GuardTacticFlag(Value: WordBool); safecall;
    property DelayTime: Double read Get_DelayTime;
    property NoDetectionProbability: Double read Get_NoDetectionProbability;
    property RationalProbability: Double read Get_RationalProbability;
    property Kind: Integer read Get_Kind write Set_Kind;
    property WarriorPathElements: IDMCollection read Get_WarriorPathElements;
    property DelayTimeDispersion: Double read Get_DelayTimeDispersion;
    property CriticalPoint: IDMElement read Get_CriticalPoint write Set_CriticalPoint;
    property OvercomingBoundaries: IDMCollection read Get_OvercomingBoundaries;
    property FirstNode: IDMElement read Get_FirstNode write Set_FirstNode;
    property PathNodes: IDMCollection read Get_PathNodes;
    property GuardTacticFlag: WordBool read Get_GuardTacticFlag write Set_GuardTacticFlag;
  end;

// *********************************************************************//
// DispIntf:  IWarriorPathDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D2-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IWarriorPathDisp = dispinterface
    ['{5F8591D2-0FE6-11D6-9328-0050BA51A6D3}']
    procedure DoAnalysis(const InitialPathElementE: IDMElement; DirectPath: WordBool); dispid 1;
    property DelayTime: Double readonly dispid 2;
    property NoDetectionProbability: Double readonly dispid 3;
    property RationalProbability: Double readonly dispid 5;
    property Kind: Integer dispid 6;
    property WarriorPathElements: IDMCollection readonly dispid 7;
    procedure Build(TreeMode: Integer; Revers: WordBool; DirectPath: WordBool; 
                    const InitialPathElementE: IDMElement); dispid 8;
    property DelayTimeDispersion: Double readonly dispid 9;
    property CriticalPoint: IDMElement dispid 10;
    property OvercomingBoundaries: IDMCollection readonly dispid 4;
    property FirstNode: IDMElement dispid 11;
    property PathNodes: IDMCollection readonly dispid 12;
    procedure Analysis; dispid 13;
    property GuardTacticFlag: WordBool dispid 14;
  end;

// *********************************************************************//
// Interface: IBarrier
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D4-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBarrier = interface(IUnknown)
    ['{5F8591D4-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_IsTransparent: WordBool; safecall;
    function CalcAttenuation(const PhysicalField: IDMElement): Double; safecall;
    property IsTransparent: WordBool read Get_IsTransparent;
  end;

// *********************************************************************//
// DispIntf:  IBarrierDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D4-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBarrierDisp = dispinterface
    ['{5F8591D4-0FE6-11D6-9328-0050BA51A6D3}']
    property IsTransparent: WordBool readonly dispid 2;
    function CalcAttenuation(const PhysicalField: IDMElement): Double; dispid 1;
  end;

// *********************************************************************//
// Interface: IBarrierFixture
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D6-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBarrierFixture = interface(IUnknown)
    ['{5F8591D6-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierFixtureDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D6-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBarrierFixtureDisp = dispinterface
    ['{5F8591D6-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: ILock
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D8-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ILock = interface(IUnknown)
    ['{5F8591D8-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_AccessControl: WordBool; safecall;
    function Get_KeyLock: WordBool; safecall;
    function Get_HandLock: WordBool; safecall;
    property AccessControl: WordBool read Get_AccessControl;
    property KeyLock: WordBool read Get_KeyLock;
    property HandLock: WordBool read Get_HandLock;
  end;

// *********************************************************************//
// DispIntf:  ILockDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591D8-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ILockDisp = dispinterface
    ['{5F8591D8-0FE6-11D6-9328-0050BA51A6D3}']
    property AccessControl: WordBool readonly dispid 1;
    property KeyLock: WordBool readonly dispid 2;
    property HandLock: WordBool readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IUndergroundObstacle
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591DA-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IUndergroundObstacle = interface(IUnknown)
    ['{5F8591DA-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_MinMineDepth: Double; safecall;
    property MinMineDepth: Double read Get_MinMineDepth;
  end;

// *********************************************************************//
// DispIntf:  IUndergroundObstacleDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591DA-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IUndergroundObstacleDisp = dispinterface
    ['{5F8591DA-0FE6-11D6-9328-0050BA51A6D3}']
    property MinMineDepth: Double readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IActiveSafeguard
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591DC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IActiveSafeguard = interface(IUnknown)
    ['{5F8591DC-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IActiveSafeguardDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591DC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IActiveSafeguardDisp = dispinterface
    ['{5F8591DC-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: ISurfaceSensor
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591DE-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ISurfaceSensor = interface(IUnknown)
    ['{5F8591DE-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  ISurfaceSensorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591DE-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ISurfaceSensorDisp = dispinterface
    ['{5F8591DE-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IPositionSensor
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E0-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IPositionSensor = interface(IUnknown)
    ['{5F8591E0-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_AlwaysAlarms: WordBool; safecall;
    property AlwaysAlarms: WordBool read Get_AlwaysAlarms;
  end;

// *********************************************************************//
// DispIntf:  IPositionSensorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E0-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IPositionSensorDisp = dispinterface
    ['{5F8591E0-0FE6-11D6-9328-0050BA51A6D3}']
    property AlwaysAlarms: WordBool readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IVolumeSensor
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E2-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IVolumeSensor = interface(IUnknown)
    ['{5F8591E2-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IVolumeSensorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E2-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IVolumeSensorDisp = dispinterface
    ['{5F8591E2-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IBarrierSensor
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E4-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBarrierSensor = interface(IUnknown)
    ['{5F8591E4-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierSensorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E4-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IBarrierSensorDisp = dispinterface
    ['{5F8591E4-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IPerimeterSensor
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E6-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IPerimeterSensor = interface(IUnknown)
    ['{5F8591E6-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_SensorDepth: Double; safecall;
    function Get_ZoneWidth: Double; safecall;
    property SensorDepth: Double read Get_SensorDepth;
    property ZoneWidth: Double read Get_ZoneWidth;
  end;

// *********************************************************************//
// DispIntf:  IPerimeterSensorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E6-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IPerimeterSensorDisp = dispinterface
    ['{5F8591E6-0FE6-11D6-9328-0050BA51A6D3}']
    property SensorDepth: Double readonly dispid 1;
    property ZoneWidth: Double readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IContrabandSensor
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E8-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IContrabandSensor = interface(IUnknown)
    ['{5F8591E8-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_UseAlways: Integer; safecall;
    property UseAlways: Integer read Get_UseAlways;
  end;

// *********************************************************************//
// DispIntf:  IContrabandSensorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591E8-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IContrabandSensorDisp = dispinterface
    ['{5F8591E8-0FE6-11D6-9328-0050BA51A6D3}']
    property UseAlways: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IAccessControl
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591EA-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IAccessControl = interface(IUnknown)
    ['{5F8591EA-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IAccessControlDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591EA-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IAccessControlDisp = dispinterface
    ['{5F8591EA-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: ITVCamera
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591EC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ITVCamera = interface(IUnknown)
    ['{5F8591EC-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_ViewAngle: Double; safecall;
    function Get_IsSlewing: WordBool; safecall;
    function Get_SlewAngle: Double; safecall;
    function Get_MotionSensor: WordBool; safecall;
    function Get_VideoRecord: Integer; safecall;
    property ViewAngle: Double read Get_ViewAngle;
    property IsSlewing: WordBool read Get_IsSlewing;
    property SlewAngle: Double read Get_SlewAngle;
    property MotionSensor: WordBool read Get_MotionSensor;
    property VideoRecord: Integer read Get_VideoRecord;
  end;

// *********************************************************************//
// DispIntf:  ITVCameraDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591EC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ITVCameraDisp = dispinterface
    ['{5F8591EC-0FE6-11D6-9328-0050BA51A6D3}']
    property ViewAngle: Double readonly dispid 1;
    property IsSlewing: WordBool readonly dispid 2;
    property SlewAngle: Double readonly dispid 3;
    property MotionSensor: WordBool readonly dispid 4;
    property VideoRecord: Integer readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ILightDevice
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591EE-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ILightDevice = interface(IUnknown)
    ['{5F8591EE-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  ILightDeviceDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591EE-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ILightDeviceDisp = dispinterface
    ['{5F8591EE-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: ICommunicationDevice
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591F0-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ICommunicationDevice = interface(IUnknown)
    ['{5F8591F0-0FE6-11D6-9328-0050BA51A6D3}']
    function GetAssessProbability: Double; safecall;
    function Get_ConnectionTime: Double; safecall;
    function Get_Secret: WordBool; safecall;
    property ConnectionTime: Double read Get_ConnectionTime;
    property Secret: WordBool read Get_Secret;
  end;

// *********************************************************************//
// DispIntf:  ICommunicationDeviceDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591F0-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ICommunicationDeviceDisp = dispinterface
    ['{5F8591F0-0FE6-11D6-9328-0050BA51A6D3}']
    function GetAssessProbability: Double; dispid 4;
    property ConnectionTime: Double readonly dispid 1;
    property Secret: WordBool readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ICabel
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591F6-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ICabel = interface(IUnknown)
    ['{5F8591F6-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_Connections: IDMCollection; safecall;
    function Get_ControlDevices: IDMCollection; safecall;
    function IndexOf(const Connection: IDMElement): Integer; safecall;
    function CuttedBetween(Index0: Integer; Index1: Integer): WordBool; safecall;
    property Connections: IDMCollection read Get_Connections;
    property ControlDevices: IDMCollection read Get_ControlDevices;
  end;

// *********************************************************************//
// DispIntf:  ICabelDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591F6-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ICabelDisp = dispinterface
    ['{5F8591F6-0FE6-11D6-9328-0050BA51A6D3}']
    property Connections: IDMCollection readonly dispid 1;
    property ControlDevices: IDMCollection readonly dispid 2;
    function IndexOf(const Connection: IDMElement): Integer; dispid 3;
    function CuttedBetween(Index0: Integer; Index1: Integer): WordBool; dispid 4;
  end;

// *********************************************************************//
// Interface: IGuardPost
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591F8-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IGuardPost = interface(IUnknown)
    ['{5F8591F8-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_WarriorGroups: IDMCollection; safecall;
    function GetMaxDelayDistance: Double; safecall;
    function Get_DutyDistance: Double; safecall;
    property WarriorGroups: IDMCollection read Get_WarriorGroups;
    property DutyDistance: Double read Get_DutyDistance;
  end;

// *********************************************************************//
// DispIntf:  IGuardPostDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591F8-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IGuardPostDisp = dispinterface
    ['{5F8591F8-0FE6-11D6-9328-0050BA51A6D3}']
    property WarriorGroups: IDMCollection readonly dispid 2;
    function GetMaxDelayDistance: Double; dispid 3;
    property DutyDistance: Double readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IPatrolPath
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591FA-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IPatrolPath = interface(IUnknown)
    ['{5F8591FA-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_Period: Double; safecall;
    function Get_Irregular: WordBool; safecall;
    function Get_WarriorGroup: IWarriorGroup; safecall;
    property Period: Double read Get_Period;
    property Irregular: WordBool read Get_Irregular;
    property WarriorGroup: IWarriorGroup read Get_WarriorGroup;
  end;

// *********************************************************************//
// DispIntf:  IPatrolPathDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591FA-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IPatrolPathDisp = dispinterface
    ['{5F8591FA-0FE6-11D6-9328-0050BA51A6D3}']
    property Period: Double readonly dispid 1;
    property Irregular: WordBool readonly dispid 2;
    property WarriorGroup: IWarriorGroup readonly dispid 3;
  end;

// *********************************************************************//
// Interface: ITarget
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591FC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ITarget = interface(IUnknown)
    ['{5F8591FC-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_Mass: Double; safecall;
    function Get_MaxSize: Double; safecall;
    function Get_MinSize: Double; safecall;
    function Get_HasMetall: WordBool; safecall;
    function Get_Radiation: Integer; safecall;
    property Mass: Double read Get_Mass;
    property MaxSize: Double read Get_MaxSize;
    property MinSize: Double read Get_MinSize;
    property HasMetall: WordBool read Get_HasMetall;
    property Radiation: Integer read Get_Radiation;
  end;

// *********************************************************************//
// DispIntf:  ITargetDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F8591FC-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ITargetDisp = dispinterface
    ['{5F8591FC-0FE6-11D6-9328-0050BA51A6D3}']
    property Mass: Double readonly dispid 1;
    property MaxSize: Double readonly dispid 2;
    property MinSize: Double readonly dispid 3;
    property HasMetall: WordBool readonly dispid 4;
    property Radiation: Integer readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ILocalPointObject
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859200-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ILocalPointObject = interface(IUnknown)
    ['{5F859200-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  ILocalPointObjectDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859200-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ILocalPointObjectDisp = dispinterface
    ['{5F859200-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IJump
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859202-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IJump = interface(IUnknown)
    ['{5F859202-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_Boundary0: IDMElement; safecall;
    procedure Set_Boundary0(const Value: IDMElement); safecall;
    function Get_Boundary1: IDMElement; safecall;
    procedure Set_Boundary1(const Value: IDMElement); safecall;
    function Get_Zone0: IDMElement; safecall;
    function Get_Zone1: IDMElement; safecall;
    function Get_ClimbUpVelocity: Double; safecall;
    function Get_ClimbDownVelocity: Double; safecall;
    procedure SetZones; safecall;
    property Boundary0: IDMElement read Get_Boundary0 write Set_Boundary0;
    property Boundary1: IDMElement read Get_Boundary1 write Set_Boundary1;
    property Zone0: IDMElement read Get_Zone0;
    property Zone1: IDMElement read Get_Zone1;
    property ClimbUpVelocity: Double read Get_ClimbUpVelocity;
    property ClimbDownVelocity: Double read Get_ClimbDownVelocity;
  end;

// *********************************************************************//
// DispIntf:  IJumpDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859202-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IJumpDisp = dispinterface
    ['{5F859202-0FE6-11D6-9328-0050BA51A6D3}']
    property Boundary0: IDMElement dispid 1;
    property Boundary1: IDMElement dispid 2;
    property Zone0: IDMElement readonly dispid 3;
    property Zone1: IDMElement readonly dispid 4;
    property ClimbUpVelocity: Double readonly dispid 5;
    property ClimbDownVelocity: Double readonly dispid 6;
    procedure SetZones; dispid 7;
  end;

// *********************************************************************//
// Interface: IStartPoint
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859204-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IStartPoint = interface(IUnknown)
    ['{5F859204-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IStartPointDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859204-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IStartPointDisp = dispinterface
    ['{5F859204-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IGuardVariant
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859206-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IGuardVariant = interface(IUnknown)
    ['{5F859206-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_GuardGroups: IDMCollection; safecall;
    function Get_PatrolPaths: IDMCollection; safecall;
    function Get_TechnicalServices: IDMCollection; safecall;
    function Get_LargestZone: IDMElement; safecall;
    property GuardGroups: IDMCollection read Get_GuardGroups;
    property PatrolPaths: IDMCollection read Get_PatrolPaths;
    property TechnicalServices: IDMCollection read Get_TechnicalServices;
    property LargestZone: IDMElement read Get_LargestZone;
  end;

// *********************************************************************//
// DispIntf:  IGuardVariantDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859206-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IGuardVariantDisp = dispinterface
    ['{5F859206-0FE6-11D6-9328-0050BA51A6D3}']
    property GuardGroups: IDMCollection readonly dispid 1;
    property PatrolPaths: IDMCollection readonly dispid 2;
    property TechnicalServices: IDMCollection readonly dispid 3;
    property LargestZone: IDMElement readonly dispid 4;
  end;

// *********************************************************************//
// Interface: IGuardGroup
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859208-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IGuardGroup = interface(IUnknown)
    ['{5F859208-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_StartDelay: Double; safecall;
    procedure Set_StartDelay(Value: Double); safecall;
    function Get_StartCondition: Integer; safecall;
    function Get_PursuitKind: Integer; safecall;
    function Get_AltFinishPoint: IDMElement; safecall;
    function Get_DelayedArrivalTime: Double; safecall;
    procedure Set_DelayedArrivalTime(Value: Double); safecall;
    function Get_UserDefinedArrivalTime: WordBool; safecall;
    function Get_UserDefinedBattleResult: WordBool; safecall;
    function Get_DefenceBattleP: Double; safecall;
    procedure Set_DefenceBattleP(Value: Double); safecall;
    function Get_AttackBattleP: Double; safecall;
    procedure Set_AttackBattleP(Value: Double); safecall;
    function Get_DefenceBattleT: Double; safecall;
    procedure Set_DefenceBattleT(Value: Double); safecall;
    function Get_AttackBattleT: Double; safecall;
    procedure Set_AttackBattleT(Value: Double); safecall;
    property StartDelay: Double read Get_StartDelay write Set_StartDelay;
    property StartCondition: Integer read Get_StartCondition;
    property PursuitKind: Integer read Get_PursuitKind;
    property AltFinishPoint: IDMElement read Get_AltFinishPoint;
    property DelayedArrivalTime: Double read Get_DelayedArrivalTime write Set_DelayedArrivalTime;
    property UserDefinedArrivalTime: WordBool read Get_UserDefinedArrivalTime;
    property UserDefinedBattleResult: WordBool read Get_UserDefinedBattleResult;
    property DefenceBattleP: Double read Get_DefenceBattleP write Set_DefenceBattleP;
    property AttackBattleP: Double read Get_AttackBattleP write Set_AttackBattleP;
    property DefenceBattleT: Double read Get_DefenceBattleT write Set_DefenceBattleT;
    property AttackBattleT: Double read Get_AttackBattleT write Set_AttackBattleT;
  end;

// *********************************************************************//
// DispIntf:  IGuardGroupDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859208-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IGuardGroupDisp = dispinterface
    ['{5F859208-0FE6-11D6-9328-0050BA51A6D3}']
    property StartDelay: Double dispid 3;
    property StartCondition: Integer readonly dispid 1;
    property PursuitKind: Integer readonly dispid 2;
    property AltFinishPoint: IDMElement readonly dispid 4;
    property DelayedArrivalTime: Double dispid 5;
    property UserDefinedArrivalTime: WordBool readonly dispid 6;
    property UserDefinedBattleResult: WordBool readonly dispid 7;
    property DefenceBattleP: Double dispid 8;
    property AttackBattleP: Double dispid 9;
    property DefenceBattleT: Double dispid 10;
    property AttackBattleT: Double dispid 11;
  end;

// *********************************************************************//
// Interface: IAdversaryVariant
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859214-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IAdversaryVariant = interface(IUnknown)
    ['{5F859214-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_AdversaryGroups: IDMCollection; safecall;
    function Get_Athorities: IDMCollection; safecall;
    procedure Prepare; safecall;
    function GetAccessType(const Element: IDMElement; InCurrentState: WordBool): Integer; safecall;
    function Get_ControlDeviceAccesses: IDMCollection; safecall;
    function Get_GuardPostAccesses: IDMCollection; safecall;
    function Get_Locks: IDMCollection; safecall;
    property AdversaryGroups: IDMCollection read Get_AdversaryGroups;
    property Athorities: IDMCollection read Get_Athorities;
    property ControlDeviceAccesses: IDMCollection read Get_ControlDeviceAccesses;
    property GuardPostAccesses: IDMCollection read Get_GuardPostAccesses;
    property Locks: IDMCollection read Get_Locks;
  end;

// *********************************************************************//
// DispIntf:  IAdversaryVariantDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859214-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IAdversaryVariantDisp = dispinterface
    ['{5F859214-0FE6-11D6-9328-0050BA51A6D3}']
    property AdversaryGroups: IDMCollection readonly dispid 1;
    property Athorities: IDMCollection readonly dispid 2;
    procedure Prepare; dispid 3;
    function GetAccessType(const Element: IDMElement; InCurrentState: WordBool): Integer; dispid 4;
    property ControlDeviceAccesses: IDMCollection readonly dispid 5;
    property GuardPostAccesses: IDMCollection readonly dispid 6;
    property Locks: IDMCollection readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IAdversaryGroup
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859216-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IAdversaryGroup = interface(IUnknown)
    ['{5F859216-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_Skills: IDMCollection; safecall;
    function Get_Athorities: IDMCollection; safecall;
    function Get_Locks: IDMCollection; safecall;
    function Get_TargetDelayTime: Double; safecall;
    function Get_UserDefinedTargetDelayDispersionRatio: WordBool; safecall;
    function Get_TargetDelayDispersionRatio: Double; safecall;
    function Get_TargetFieldValue: Double; safecall;
    function Get_TargetAccessRequired: WordBool; safecall;
    function Get_ControlDeviceAccesses: IDMCollection; safecall;
    function Get_GuardPostAccesses: IDMCollection; safecall;
    property Skills: IDMCollection read Get_Skills;
    property Athorities: IDMCollection read Get_Athorities;
    property Locks: IDMCollection read Get_Locks;
    property TargetDelayTime: Double read Get_TargetDelayTime;
    property UserDefinedTargetDelayDispersionRatio: WordBool read Get_UserDefinedTargetDelayDispersionRatio;
    property TargetDelayDispersionRatio: Double read Get_TargetDelayDispersionRatio;
    property TargetFieldValue: Double read Get_TargetFieldValue;
    property TargetAccessRequired: WordBool read Get_TargetAccessRequired;
    property ControlDeviceAccesses: IDMCollection read Get_ControlDeviceAccesses;
    property GuardPostAccesses: IDMCollection read Get_GuardPostAccesses;
  end;

// *********************************************************************//
// DispIntf:  IAdversaryGroupDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859216-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IAdversaryGroupDisp = dispinterface
    ['{5F859216-0FE6-11D6-9328-0050BA51A6D3}']
    property Skills: IDMCollection readonly dispid 3;
    property Athorities: IDMCollection readonly dispid 4;
    property Locks: IDMCollection readonly dispid 5;
    property TargetDelayTime: Double readonly dispid 1;
    property UserDefinedTargetDelayDispersionRatio: WordBool readonly dispid 2;
    property TargetDelayDispersionRatio: Double readonly dispid 8;
    property TargetFieldValue: Double readonly dispid 9;
    property TargetAccessRequired: WordBool readonly dispid 10;
    property ControlDeviceAccesses: IDMCollection readonly dispid 6;
    property GuardPostAccesses: IDMCollection readonly dispid 11;
  end;

// *********************************************************************//
// Interface: ITool
// Flags:     (320) Dual OleAutomation
// GUID:      {5F85921A-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ITool = interface(IUnknown)
    ['{5F85921A-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IToolDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F85921A-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IToolDisp = dispinterface
    ['{5F85921A-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IVehicle
// Flags:     (320) Dual OleAutomation
// GUID:      {5F85921C-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IVehicle = interface(IUnknown)
    ['{5F85921C-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IVehicleDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F85921C-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IVehicleDisp = dispinterface
    ['{5F85921C-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IAthority
// Flags:     (320) Dual OleAutomation
// GUID:      {5F85921E-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IAthority = interface(IUnknown)
    ['{5F85921E-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IAthorityDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F85921E-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  IAthorityDisp = dispinterface
    ['{5F85921E-0FE6-11D6-9328-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: ISkill
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859220-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ISkill = interface(IUnknown)
    ['{5F859220-0FE6-11D6-9328-0050BA51A6D3}']
    function Get_Level: Integer; safecall;
    property Level: Integer read Get_Level;
  end;

// *********************************************************************//
// DispIntf:  ISkillDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5F859220-0FE6-11D6-9328-0050BA51A6D3}
// *********************************************************************//
  ISkillDisp = dispinterface
    ['{5F859220-0FE6-11D6-9328-0050BA51A6D3}']
    property Level: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IWarriorGroup
// Flags:     (320) Dual OleAutomation
// GUID:      {9DCB5BA1-14B5-11D6-932D-0050BA51A6D3}
// *********************************************************************//
  IWarriorGroup = interface(IUnknown)
    ['{9DCB5BA1-14B5-11D6-932D-0050BA51A6D3}']
    function AcceptableMethod(const OvercomeMetod: IDMElement): WordBool; safecall;
    function Get_Weapons: IDMCollection; safecall;
    function Get_Vehicles: IDMCollection; safecall;
    function Get_StartPoint: IDMElement; safecall;
    procedure Set_StartPoint(const Value: IDMElement); safecall;
    function Get_FinishPoint: IDMElement; safecall;
    procedure Set_FinishPoint(const Value: IDMElement); safecall;
    function Get_ArrivalTime: Double; safecall;
    procedure Set_ArrivalTime(Value: Double); safecall;
    function Get_InitialNumber: Integer; safecall;
    procedure ClearAllPaths; safecall;
    procedure StorePath(const aFastPath: IWarriorPath); safecall;
    function Get_FastPath: IWarriorPath; safecall;
    function Get_BattleSkill: IDMElement; safecall;
    function Get_Tools: IDMCollection; safecall;
    function Get_ToolSkill: SYSINT; safecall;
    function Get_Task: Integer; safecall;
    procedure Set_Task(Value: Integer); safecall;
    function Get_Accesses: IDMCollection; safecall;
    function GetAccessTypeToZone(const ZoneE: IDMElement; InCurrentState: WordBool): Integer; safecall;
    procedure SetInitialNumber(Value: Integer); safecall;
    function GetAccessType(const Element: IDMElement; InCurrentState: WordBool): Integer; safecall;
    function GetPotential: Double; safecall;
    function Get_ArrivalTimeDispersion: Double; safecall;
    procedure Set_ArrivalTimeDispersion(Value: Double); safecall;
    property Weapons: IDMCollection read Get_Weapons;
    property Vehicles: IDMCollection read Get_Vehicles;
    property StartPoint: IDMElement read Get_StartPoint write Set_StartPoint;
    property FinishPoint: IDMElement read Get_FinishPoint write Set_FinishPoint;
    property ArrivalTime: Double read Get_ArrivalTime write Set_ArrivalTime;
    property InitialNumber: Integer read Get_InitialNumber;
    property FastPath: IWarriorPath read Get_FastPath;
    property BattleSkill: IDMElement read Get_BattleSkill;
    property Tools: IDMCollection read Get_Tools;
    property ToolSkill: SYSINT read Get_ToolSkill;
    property Task: Integer read Get_Task write Set_Task;
    property Accesses: IDMCollection read Get_Accesses;
    property ArrivalTimeDispersion: Double read Get_ArrivalTimeDispersion write Set_ArrivalTimeDispersion;
  end;

// *********************************************************************//
// DispIntf:  IWarriorGroupDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {9DCB5BA1-14B5-11D6-932D-0050BA51A6D3}
// *********************************************************************//
  IWarriorGroupDisp = dispinterface
    ['{9DCB5BA1-14B5-11D6-932D-0050BA51A6D3}']
    function AcceptableMethod(const OvercomeMetod: IDMElement): WordBool; dispid 1;
    property Weapons: IDMCollection readonly dispid 3;
    property Vehicles: IDMCollection readonly dispid 4;
    property StartPoint: IDMElement dispid 6;
    property FinishPoint: IDMElement dispid 8;
    property ArrivalTime: Double dispid 13;
    property InitialNumber: Integer readonly dispid 14;
    procedure ClearAllPaths; dispid 7;
    procedure StorePath(const aFastPath: IWarriorPath); dispid 15;
    property FastPath: IWarriorPath readonly dispid 17;
    property BattleSkill: IDMElement readonly dispid 2;
    property Tools: IDMCollection readonly dispid 9;
    property ToolSkill: SYSINT readonly dispid 10;
    property Task: Integer dispid 11;
    property Accesses: IDMCollection readonly dispid 5;
    function GetAccessTypeToZone(const ZoneE: IDMElement; InCurrentState: WordBool): Integer; dispid 12;
    procedure SetInitialNumber(Value: Integer); dispid 19;
    function GetAccessType(const Element: IDMElement; InCurrentState: WordBool): Integer; dispid 16;
    function GetPotential: Double; dispid 18;
    property ArrivalTimeDispersion: Double dispid 21;
  end;

// *********************************************************************//
// Interface: IFacilityElement
// Flags:     (320) Dual OleAutomation
// GUID:      {9DCB5BA5-14B5-11D6-932D-0050BA51A6D3}
// *********************************************************************//
  IFacilityElement = interface(IUnknown)
    ['{9DCB5BA5-14B5-11D6-932D-0050BA51A6D3}']
    function Get_PathArcs: IDMCollection; safecall;
    function Get_SMLabel: IDMElement; safecall;
    function Get_VisualControl: Integer; safecall;
    procedure CalcFalseAlarmPeriod; safecall;
    function Get_FalseAlarmPeriod: Double; safecall;
    function Get_PatrolPeriod: Double; safecall;
    procedure MakeBackPathElementStates(const SubStateE: IDMElement); safecall;
    procedure CalcVulnerability; safecall;
    function Get_GoalDefinding: WordBool; safecall;
    property PathArcs: IDMCollection read Get_PathArcs;
    property SMLabel: IDMElement read Get_SMLabel;
    property VisualControl: Integer read Get_VisualControl;
    property FalseAlarmPeriod: Double read Get_FalseAlarmPeriod;
    property PatrolPeriod: Double read Get_PatrolPeriod;
    property GoalDefinding: WordBool read Get_GoalDefinding;
  end;

// *********************************************************************//
// DispIntf:  IFacilityElementDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {9DCB5BA5-14B5-11D6-932D-0050BA51A6D3}
// *********************************************************************//
  IFacilityElementDisp = dispinterface
    ['{9DCB5BA5-14B5-11D6-932D-0050BA51A6D3}']
    property PathArcs: IDMCollection readonly dispid 9;
    property SMLabel: IDMElement readonly dispid 3;
    property VisualControl: Integer readonly dispid 6;
    procedure CalcFalseAlarmPeriod; dispid 4;
    property FalseAlarmPeriod: Double readonly dispid 5;
    property PatrolPeriod: Double readonly dispid 7;
    procedure MakeBackPathElementStates(const SubStateE: IDMElement); dispid 8;
    procedure CalcVulnerability; dispid 10;
    property GoalDefinding: WordBool readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IPathElement
// Flags:     (320) Dual OleAutomation
// GUID:      {9DCB5BA7-14B5-11D6-932D-0050BA51A6D3}
// *********************************************************************//
  IPathElement = interface(IUnknown)
    ['{9DCB5BA7-14B5-11D6-932D-0050BA51A6D3}']
    procedure CalcDelayTime(out DelayTime: Double; out DelayTimeDispersion: Double; 
                            out BestTacticE: IDMElement; AddDelay: Double); safecall;
    procedure CalcPathNoDetectionProbability(var PathNoDetectionProbability: Double; 
                                             out NoDetPCent: Double; out NoFailureP: Double; 
                                             out NoEvidence: WordBool; AddDelay: Double); safecall;
    procedure CalcPathSuccessProbability(var SuccessProbability: Double; 
                                         out OutstripProbability: Double; var DelayTimeSum: Double; 
                                         var DelayTimeDispersionSum: Double; AddDelay: Double); safecall;
    procedure CalcPathSoundResistance(var PathSoundResistance: Double; var PathDistance: Double); safecall;
    procedure CalcNoDetectionProbability(out NoDetP: Double; out NoFailureP: Double; 
                                         out NoEvidence: WordBool; out BestTimeSum: Double; 
                                         out BestTimeSumDisp: Double; out Position: Integer; 
                                         out BestTacticE: IDMElement; AddDelay: Double); safecall;
    procedure DoCalcDelayTime(const TacticU: IUnknown; out DelayTime: Double; 
                              out DelayTimeDispersion: Double; AddDelay: Double); safecall;
    procedure DoCalcNoDetectionProbability(const TacticU: IUnknown; ObservationPeriod: Double; 
                                           out NoDetP: Double; out NoFailureP: Double; 
                                           out NoEvidence: WordBool; out BestTimeSum: Double; 
                                           out BestTimeDispSum: Double; out Position: Integer; 
                                           AddDelay: Double); safecall;
    procedure DoCalcPathSuccessProbability(const TacticU: IUnknown; DetectionTime: Double; 
                                           var SuccessProbability: Double; 
                                           out OutstripProbability: Double; out StealthT: Double; 
                                           DelayTimeSumOuter: Double; 
                                           DelayTimeDispersionSumOuter: Double; 
                                           DelayTimeSumInner: Double; 
                                           DelayTimeDispersionSumInner: Double; AddDelay: Double); safecall;
    function Get_Disabled: WordBool; safecall;
    property Disabled: WordBool read Get_Disabled;
  end;

// *********************************************************************//
// DispIntf:  IPathElementDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {9DCB5BA7-14B5-11D6-932D-0050BA51A6D3}
// *********************************************************************//
  IPathElementDisp = dispinterface
    ['{9DCB5BA7-14B5-11D6-932D-0050BA51A6D3}']
    procedure CalcDelayTime(out DelayTime: Double; out DelayTimeDispersion: Double; 
                            out BestTacticE: IDMElement; AddDelay: Double); dispid 1;
    procedure CalcPathNoDetectionProbability(var PathNoDetectionProbability: Double; 
                                             out NoDetPCent: Double; out NoFailureP: Double; 
                                             out NoEvidence: WordBool; AddDelay: Double); dispid 2;
    procedure CalcPathSuccessProbability(var SuccessProbability: Double; 
                                         out OutstripProbability: Double; var DelayTimeSum: Double; 
                                         var DelayTimeDispersionSum: Double; AddDelay: Double); dispid 3;
    procedure CalcPathSoundResistance(var PathSoundResistance: Double; var PathDistance: Double); dispid 4;
    procedure CalcNoDetectionProbability(out NoDetP: Double; out NoFailureP: Double; 
                                         out NoEvidence: WordBool; out BestTimeSum: Double; 
                                         out BestTimeSumDisp: Double; out Position: Integer; 
                                         out BestTacticE: IDMElement; AddDelay: Double); dispid 6;
    procedure DoCalcDelayTime(const TacticU: IUnknown; out DelayTime: Double; 
                              out DelayTimeDispersion: Double; AddDelay: Double); dispid 8;
    procedure DoCalcNoDetectionProbability(const TacticU: IUnknown; ObservationPeriod: Double; 
                                           out NoDetP: Double; out NoFailureP: Double; 
                                           out NoEvidence: WordBool; out BestTimeSum: Double; 
                                           out BestTimeDispSum: Double; out Position: Integer; 
                                           AddDelay: Double); dispid 9;
    procedure DoCalcPathSuccessProbability(const TacticU: IUnknown; DetectionTime: Double; 
                                           var SuccessProbability: Double; 
                                           out OutstripProbability: Double; out StealthT: Double; 
                                           DelayTimeSumOuter: Double; 
                                           DelayTimeDispersionSumOuter: Double; 
                                           DelayTimeSumInner: Double; 
                                           DelayTimeDispersionSumInner: Double; AddDelay: Double); dispid 10;
    property Disabled: WordBool readonly dispid 11;
  end;

// *********************************************************************//
// Interface: IElementState
// Flags:     (320) Dual OleAutomation
// GUID:      {F080A721-154A-11D6-932F-0050BA51A6D3}
// *********************************************************************//
  IElementState = interface(IUnknown)
    ['{F080A721-154A-11D6-932F-0050BA51A6D3}']
    function Get_UserDefinedDelayTime: WordBool; safecall;
    function Get_DelayTime: Double; safecall;
    procedure Set_DelayTime(Value: Double); safecall;
    function Get_UserDefinedDetectionProbability: WordBool; safecall;
    function Get_DetectionProbability: Double; safecall;
    procedure Set_DetectionProbability(Value: Double); safecall;
    function Get_DelayTimeDispersion: Double; safecall;
    property UserDefinedDelayTime: WordBool read Get_UserDefinedDelayTime;
    property DelayTime: Double read Get_DelayTime write Set_DelayTime;
    property UserDefinedDetectionProbability: WordBool read Get_UserDefinedDetectionProbability;
    property DetectionProbability: Double read Get_DetectionProbability write Set_DetectionProbability;
    property DelayTimeDispersion: Double read Get_DelayTimeDispersion;
  end;

// *********************************************************************//
// DispIntf:  IElementStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {F080A721-154A-11D6-932F-0050BA51A6D3}
// *********************************************************************//
  IElementStateDisp = dispinterface
    ['{F080A721-154A-11D6-932F-0050BA51A6D3}']
    property UserDefinedDelayTime: WordBool readonly dispid 1;
    property DelayTime: Double dispid 2;
    property UserDefinedDetectionProbability: WordBool readonly dispid 3;
    property DetectionProbability: Double dispid 4;
    property DelayTimeDispersion: Double readonly dispid 6;
  end;

// *********************************************************************//
// Interface: ISafeguardElement
// Flags:     (320) Dual OleAutomation
// GUID:      {F4204D31-1936-11D6-9335-0050BA51A6D3}
// *********************************************************************//
  ISafeguardElement = interface(IUnknown)
    ['{F4204D31-1936-11D6-9335-0050BA51A6D3}']
    function AcceptableMethod(const OvercomeMethod: IDMElement): WordBool; safecall;
    procedure CalcDetectionProbability(const TacticU: IUnknown; out DetP: Double; 
                                       out BestTime: Double); safecall;
    procedure CalcDelayTime(const TacticU: IUnknown; out DelayTime: Double; 
                            out DelayTimeDispersion: Double); safecall;
    function Get_Elevation: Double; safecall;
    function Get_CurrOvercomeMethod: IDMElement; safecall;
    function DoCalcDelayTime(const OvercomeMethodE: IDMElement): Double; safecall;
    function DoCalcDetectionProbability(const TacticU: IUnknown; const OvercomeMethodE: IDMElement; 
                                        DelayTime: Double; var DetP0: Double; var DetPf: Double; 
                                        var WorkP: Double; CalcAll: WordBool): Double; safecall;
    function InWorkingState: WordBool; safecall;
    function Get_BestOvercomeMethod: IDMElement; safecall;
    procedure Set_BestOvercomeMethod(const Value: IDMElement); safecall;
    function ShowInLayerName: WordBool; safecall;
    function Get_DetectionPosition: Integer; safecall;
    function IsPresent: WordBool; safecall;
    function Get_ShowSymbol: WordBool; safecall;
    procedure ClearCash; safecall;
    function Get_SymbolDX: Double; safecall;
    function Get_SymbolDY: Double; safecall;
    procedure GetCoord(var X0: Double; var Y0: Double; var Z0: Double); safecall;
    procedure CalcParams(const TacticU: IUnknown; ObservationPeriod: Double; out dTFast: Double; 
                         out dTDispFast: Double; out NoDetPFast: Double; out NoDetP1Fast: Double; 
                         out dTStealth: Double; out dTDispStelth: Double; 
                         out NoDetPStealth: Double; out NoDetP1Stealth: Double; 
                         out OvercomeMethodFastE: IDMElement; out OvercomeMethodStealthE: IDMElement); safecall;
    property Elevation: Double read Get_Elevation;
    property CurrOvercomeMethod: IDMElement read Get_CurrOvercomeMethod;
    property BestOvercomeMethod: IDMElement read Get_BestOvercomeMethod write Set_BestOvercomeMethod;
    property DetectionPosition: Integer read Get_DetectionPosition;
    property ShowSymbol: WordBool read Get_ShowSymbol;
    property SymbolDX: Double read Get_SymbolDX;
    property SymbolDY: Double read Get_SymbolDY;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardElementDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {F4204D31-1936-11D6-9335-0050BA51A6D3}
// *********************************************************************//
  ISafeguardElementDisp = dispinterface
    ['{F4204D31-1936-11D6-9335-0050BA51A6D3}']
    function AcceptableMethod(const OvercomeMethod: IDMElement): WordBool; dispid 3;
    procedure CalcDetectionProbability(const TacticU: IUnknown; out DetP: Double; 
                                       out BestTime: Double); dispid 5;
    procedure CalcDelayTime(const TacticU: IUnknown; out DelayTime: Double; 
                            out DelayTimeDispersion: Double); dispid 7;
    property Elevation: Double readonly dispid 4;
    property CurrOvercomeMethod: IDMElement readonly dispid 2;
    function DoCalcDelayTime(const OvercomeMethodE: IDMElement): Double; dispid 6;
    function DoCalcDetectionProbability(const TacticU: IUnknown; const OvercomeMethodE: IDMElement; 
                                        DelayTime: Double; var DetP0: Double; var DetPf: Double; 
                                        var WorkP: Double; CalcAll: WordBool): Double; dispid 8;
    function InWorkingState: WordBool; dispid 9;
    property BestOvercomeMethod: IDMElement dispid 12;
    function ShowInLayerName: WordBool; dispid 10;
    property DetectionPosition: Integer readonly dispid 13;
    function IsPresent: WordBool; dispid 15;
    property ShowSymbol: WordBool readonly dispid 14;
    procedure ClearCash; dispid 16;
    property SymbolDX: Double readonly dispid 17;
    property SymbolDY: Double readonly dispid 18;
    procedure GetCoord(var X0: Double; var Y0: Double; var Z0: Double); dispid 19;
    procedure CalcParams(const TacticU: IUnknown; ObservationPeriod: Double; out dTFast: Double; 
                         out dTDispFast: Double; out NoDetPFast: Double; out NoDetP1Fast: Double; 
                         out dTStealth: Double; out dTDispStelth: Double; 
                         out NoDetPStealth: Double; out NoDetP1Stealth: Double; 
                         out OvercomeMethodFastE: IDMElement; out OvercomeMethodStealthE: IDMElement); dispid 1;
  end;

// *********************************************************************//
// Interface: IFieldBarrier
// Flags:     (320) Dual OleAutomation
// GUID:      {B06BB691-2046-11D6-9343-0050BA51A6D3}
// *********************************************************************//
  IFieldBarrier = interface(IUnknown)
    ['{B06BB691-2046-11D6-9343-0050BA51A6D3}']
    function Get_IsTransparent: WordBool; safecall;
    function Get_HasNoFieldBarrier: WordBool; safecall;
    function CalcAttenuation(const PhysicalField: IDMElement): Double; safecall;
    function Get_SoundResistance: Double; safecall;
    function Get_IsFragile: WordBool; safecall;
    procedure CalcParamFlags; safecall;
    property IsTransparent: WordBool read Get_IsTransparent;
    property HasNoFieldBarrier: WordBool read Get_HasNoFieldBarrier;
    property SoundResistance: Double read Get_SoundResistance;
    property IsFragile: WordBool read Get_IsFragile;
  end;

// *********************************************************************//
// DispIntf:  IFieldBarrierDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {B06BB691-2046-11D6-9343-0050BA51A6D3}
// *********************************************************************//
  IFieldBarrierDisp = dispinterface
    ['{B06BB691-2046-11D6-9343-0050BA51A6D3}']
    property IsTransparent: WordBool readonly dispid 1;
    property HasNoFieldBarrier: WordBool readonly dispid 2;
    function CalcAttenuation(const PhysicalField: IDMElement): Double; dispid 3;
    property SoundResistance: Double readonly dispid 4;
    property IsFragile: WordBool readonly dispid 5;
    procedure CalcParamFlags; dispid 6;
  end;

// *********************************************************************//
// Interface: ICabelNode
// Flags:     (320) Dual OleAutomation
// GUID:      {5E521B01-2CFD-11D6-96C0-0050BA51A6D3}
// *********************************************************************//
  ICabelNode = interface(IUnknown)
    ['{5E521B01-2CFD-11D6-96C0-0050BA51A6D3}']
    function Get_Connections: IDMCollection; safecall;
    property Connections: IDMCollection read Get_Connections;
  end;

// *********************************************************************//
// DispIntf:  ICabelNodeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5E521B01-2CFD-11D6-96C0-0050BA51A6D3}
// *********************************************************************//
  ICabelNodeDisp = dispinterface
    ['{5E521B01-2CFD-11D6-96C0-0050BA51A6D3}']
    property Connections: IDMCollection readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IDistantDetectionElement
// Flags:     (320) Dual OleAutomation
// GUID:      {55EDE0E0-2E2C-11D6-9B9F-A06FA09A99A2}
// *********************************************************************//
  IDistantDetectionElement = interface(IUnknown)
    ['{55EDE0E0-2E2C-11D6-9B9F-A06FA09A99A2}']
    function PointInDetectionZone(X: Double; Y: Double; Z: Double; const CRef: IDMElement; 
                                  const ExcludeArea: IDMElement): WordBool; safecall;
    function Get_Observers: IDMCollection; safecall;
    property Observers: IDMCollection read Get_Observers;
  end;

// *********************************************************************//
// DispIntf:  IDistantDetectionElementDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {55EDE0E0-2E2C-11D6-9B9F-A06FA09A99A2}
// *********************************************************************//
  IDistantDetectionElementDisp = dispinterface
    ['{55EDE0E0-2E2C-11D6-9B9F-A06FA09A99A2}']
    function PointInDetectionZone(X: Double; Y: Double; Z: Double; const CRef: IDMElement; 
                                  const ExcludeArea: IDMElement): WordBool; dispid 1;
    property Observers: IDMCollection readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IWeapon
// Flags:     (320) Dual OleAutomation
// GUID:      {7FEA85C0-2F7A-11D6-9B9F-846689E068A3}
// *********************************************************************//
  IWeapon = interface(IUnknown)
    ['{7FEA85C0-2F7A-11D6-9B9F-846689E068A3}']
    function Get_Count: Integer; safecall;
    procedure Set_Count(Value: Integer); safecall;
    function Get_ShotBreach: IUnknown; safecall;
    property Count: Integer read Get_Count write Set_Count;
    property ShotBreach: IUnknown read Get_ShotBreach;
  end;

// *********************************************************************//
// DispIntf:  IWeaponDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {7FEA85C0-2F7A-11D6-9B9F-846689E068A3}
// *********************************************************************//
  IWeaponDisp = dispinterface
    ['{7FEA85C0-2F7A-11D6-9B9F-846689E068A3}']
    property Count: Integer dispid 2;
    property ShotBreach: IUnknown readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IAnalysisVariant
// Flags:     (320) Dual OleAutomation
// GUID:      {64830DC0-38FD-11D6-9B9F-C8B92BAC54A3}
// *********************************************************************//
  IAnalysisVariant = interface(IUnknown)
    ['{64830DC0-38FD-11D6-9B9F-C8B92BAC54A3}']
    function Get_FacilityState: IDMElement; safecall;
    function Get_GuardVariant: IDMElement; safecall;
    function Get_AdversaryVariant: IDMElement; safecall;
    procedure CalcSystemEfficiency; safecall;
    function Get_WarriorPaths: IDMCollection; safecall;
    function Get_MainGroup: IWarriorGroup; safecall;
    procedure InitAnalysis; safecall;
    function Get_UserDefinedResponceTime: WordBool; safecall;
    function Get_ResponceTime: Double; safecall;
    procedure Set_ResponceTime(Value: Double); safecall;
    function Get_ResponceTimeDispersion: Double; safecall;
    procedure Set_ResponceTimeDispersion(Value: Double); safecall;
    function Get_GuardStrategy: Integer; safecall;
    function Get_ExtraTargets: IDMCollection; safecall;
    function Get_CriticalPoints: IDMCollection; safecall;
    function Get_FalseAlarmPeriod: Double; safecall;
    procedure Set_FalseAlarmPeriod(Value: Double); safecall;
    function Get_BattleSystemEfficiency: Double; safecall;
    procedure Set_BattleSystemEfficiency(Value: Double); safecall;
    function Get_UserDefinedResponceTimeDispersionRatio: WordBool; safecall;
    function Get_ResponceTimeDispersionRatio: Double; safecall;
    procedure Set_ResponceTimeDispersionRatio(Value: Double); safecall;
    function Get_BaseAnalysisVariant: IDMElement; safecall;
    procedure Set_BaseAnalysisVariant(const Value: IDMElement); safecall;
    function Get_VariantWeight: Double; safecall;
    procedure Set_VariantWeight(Value: Double); safecall;
    function Get_Price: Double; safecall;
    procedure Set_Price(Value: Double); safecall;
    function Get_MaxPathCount: Integer; safecall;
    property FacilityState: IDMElement read Get_FacilityState;
    property GuardVariant: IDMElement read Get_GuardVariant;
    property AdversaryVariant: IDMElement read Get_AdversaryVariant;
    property WarriorPaths: IDMCollection read Get_WarriorPaths;
    property MainGroup: IWarriorGroup read Get_MainGroup;
    property UserDefinedResponceTime: WordBool read Get_UserDefinedResponceTime;
    property ResponceTime: Double read Get_ResponceTime write Set_ResponceTime;
    property ResponceTimeDispersion: Double read Get_ResponceTimeDispersion write Set_ResponceTimeDispersion;
    property GuardStrategy: Integer read Get_GuardStrategy;
    property ExtraTargets: IDMCollection read Get_ExtraTargets;
    property CriticalPoints: IDMCollection read Get_CriticalPoints;
    property FalseAlarmPeriod: Double read Get_FalseAlarmPeriod write Set_FalseAlarmPeriod;
    property BattleSystemEfficiency: Double read Get_BattleSystemEfficiency write Set_BattleSystemEfficiency;
    property UserDefinedResponceTimeDispersionRatio: WordBool read Get_UserDefinedResponceTimeDispersionRatio;
    property ResponceTimeDispersionRatio: Double read Get_ResponceTimeDispersionRatio write Set_ResponceTimeDispersionRatio;
    property BaseAnalysisVariant: IDMElement read Get_BaseAnalysisVariant write Set_BaseAnalysisVariant;
    property VariantWeight: Double read Get_VariantWeight write Set_VariantWeight;
    property Price: Double read Get_Price write Set_Price;
    property MaxPathCount: Integer read Get_MaxPathCount;
  end;

// *********************************************************************//
// DispIntf:  IAnalysisVariantDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {64830DC0-38FD-11D6-9B9F-C8B92BAC54A3}
// *********************************************************************//
  IAnalysisVariantDisp = dispinterface
    ['{64830DC0-38FD-11D6-9B9F-C8B92BAC54A3}']
    property FacilityState: IDMElement readonly dispid 1;
    property GuardVariant: IDMElement readonly dispid 2;
    property AdversaryVariant: IDMElement readonly dispid 3;
    procedure CalcSystemEfficiency; dispid 4;
    property WarriorPaths: IDMCollection readonly dispid 5;
    property MainGroup: IWarriorGroup readonly dispid 7;
    procedure InitAnalysis; dispid 9;
    property UserDefinedResponceTime: WordBool readonly dispid 10;
    property ResponceTime: Double dispid 11;
    property ResponceTimeDispersion: Double dispid 8;
    property GuardStrategy: Integer readonly dispid 6;
    property ExtraTargets: IDMCollection readonly dispid 12;
    property CriticalPoints: IDMCollection readonly dispid 13;
    property FalseAlarmPeriod: Double dispid 15;
    property BattleSystemEfficiency: Double dispid 16;
    property UserDefinedResponceTimeDispersionRatio: WordBool readonly dispid 17;
    property ResponceTimeDispersionRatio: Double dispid 18;
    property BaseAnalysisVariant: IDMElement dispid 19;
    property VariantWeight: Double dispid 20;
    property Price: Double dispid 14;
    property MaxPathCount: Integer readonly dispid 21;
  end;

// *********************************************************************//
// Interface: IVulnerabilityData
// Flags:     (320) Dual OleAutomation
// GUID:      {7DE9F7A0-4A51-11D6-9B9F-FBE42A0D5AA3}
// *********************************************************************//
  IVulnerabilityData = interface(IUnknown)
    ['{7DE9F7A0-4A51-11D6-9B9F-FBE42A0D5AA3}']
    function Get_DelayTimeToTarget: Double; safecall;
    function Get_NoDetectionProbabilityFromStart: Double; safecall;
    function Get_DelayTimeToTarget_NextNode: IDMElement; safecall;
    function Get_NoDetectionProbabilityFromStart_NextNode: IDMElement; safecall;
    function Get_DelayTimeToTargetDispersion: Double; safecall;
    function Get_RationalProbabilityToTarget: Double; safecall;
    function Get_RationalProbabilityToTarget_NextNode: IDMElement; safecall;
    function Get_BackPathDelayTime: Double; safecall;
    function Get_BackPathDelayTimeDispersion: Double; safecall;
    function Get_BackPathRationalProbability: Double; safecall;
    function Get_BackPathRationalProbability_NextNode: IDMElement; safecall;
    function Get_DelayTimeToTarget_NextArc: IDMElement; safecall;
    function Get_NoDetectionProbabilityFromStart_NextArc: IDMElement; safecall;
    function Get_RationalProbabilityToTarget_NextArc: IDMElement; safecall;
    function Get_BackPathRationalProbability_NextArc: IDMElement; safecall;
    function Get_DelayTimeFromStart: Double; safecall;
    function Get_DelayTimeFromStart_NextNode: IDMElement; safecall;
    function Get_DelayTimeFromStartDispersion: Double; safecall;
    function Get_DelayTimeFromStart_NextArc: IDMElement; safecall;
    function GetDelayTimeFromStart(const WarriorGroupE: IDMElement; out DelayTime: Double; 
                                   out DelayTimeDispersion: Double): WordBool; safecall;
    function GetDelayTimeToTarget(const WarriorGroupE: IDMElement; out DelayTime: Double; 
                                  out DelayTimeDispersion: Double): WordBool; safecall;
    property DelayTimeToTarget: Double read Get_DelayTimeToTarget;
    property NoDetectionProbabilityFromStart: Double read Get_NoDetectionProbabilityFromStart;
    property DelayTimeToTarget_NextNode: IDMElement read Get_DelayTimeToTarget_NextNode;
    property NoDetectionProbabilityFromStart_NextNode: IDMElement read Get_NoDetectionProbabilityFromStart_NextNode;
    property DelayTimeToTargetDispersion: Double read Get_DelayTimeToTargetDispersion;
    property RationalProbabilityToTarget: Double read Get_RationalProbabilityToTarget;
    property RationalProbabilityToTarget_NextNode: IDMElement read Get_RationalProbabilityToTarget_NextNode;
    property BackPathDelayTime: Double read Get_BackPathDelayTime;
    property BackPathDelayTimeDispersion: Double read Get_BackPathDelayTimeDispersion;
    property BackPathRationalProbability: Double read Get_BackPathRationalProbability;
    property BackPathRationalProbability_NextNode: IDMElement read Get_BackPathRationalProbability_NextNode;
    property DelayTimeToTarget_NextArc: IDMElement read Get_DelayTimeToTarget_NextArc;
    property NoDetectionProbabilityFromStart_NextArc: IDMElement read Get_NoDetectionProbabilityFromStart_NextArc;
    property RationalProbabilityToTarget_NextArc: IDMElement read Get_RationalProbabilityToTarget_NextArc;
    property BackPathRationalProbability_NextArc: IDMElement read Get_BackPathRationalProbability_NextArc;
    property DelayTimeFromStart: Double read Get_DelayTimeFromStart;
    property DelayTimeFromStart_NextNode: IDMElement read Get_DelayTimeFromStart_NextNode;
    property DelayTimeFromStartDispersion: Double read Get_DelayTimeFromStartDispersion;
    property DelayTimeFromStart_NextArc: IDMElement read Get_DelayTimeFromStart_NextArc;
  end;

// *********************************************************************//
// DispIntf:  IVulnerabilityDataDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {7DE9F7A0-4A51-11D6-9B9F-FBE42A0D5AA3}
// *********************************************************************//
  IVulnerabilityDataDisp = dispinterface
    ['{7DE9F7A0-4A51-11D6-9B9F-FBE42A0D5AA3}']
    property DelayTimeToTarget: Double readonly dispid 1;
    property NoDetectionProbabilityFromStart: Double readonly dispid 2;
    property DelayTimeToTarget_NextNode: IDMElement readonly dispid 4;
    property NoDetectionProbabilityFromStart_NextNode: IDMElement readonly dispid 5;
    property DelayTimeToTargetDispersion: Double readonly dispid 7;
    property RationalProbabilityToTarget: Double readonly dispid 10;
    property RationalProbabilityToTarget_NextNode: IDMElement readonly dispid 11;
    property BackPathDelayTime: Double readonly dispid 12;
    property BackPathDelayTimeDispersion: Double readonly dispid 13;
    property BackPathRationalProbability: Double readonly dispid 14;
    property BackPathRationalProbability_NextNode: IDMElement readonly dispid 15;
    property DelayTimeToTarget_NextArc: IDMElement readonly dispid 3;
    property NoDetectionProbabilityFromStart_NextArc: IDMElement readonly dispid 6;
    property RationalProbabilityToTarget_NextArc: IDMElement readonly dispid 8;
    property BackPathRationalProbability_NextArc: IDMElement readonly dispid 9;
    property DelayTimeFromStart: Double readonly dispid 16;
    property DelayTimeFromStart_NextNode: IDMElement readonly dispid 17;
    property DelayTimeFromStartDispersion: Double readonly dispid 18;
    property DelayTimeFromStart_NextArc: IDMElement readonly dispid 19;
    function GetDelayTimeFromStart(const WarriorGroupE: IDMElement; out DelayTime: Double; 
                                   out DelayTimeDispersion: Double): WordBool; dispid 21;
    function GetDelayTimeToTarget(const WarriorGroupE: IDMElement; out DelayTime: Double; 
                                  out DelayTimeDispersion: Double): WordBool; dispid 22;
  end;

// *********************************************************************//
// Interface: IVulnerabilityMap
// Flags:     (320) Dual OleAutomation
// GUID:      {375483C2-4DD6-11D6-96EE-0050BA51A6D3}
// *********************************************************************//
  IVulnerabilityMap = interface(IUnknown)
    ['{375483C2-4DD6-11D6-96EE-0050BA51A6D3}']
    function Get_ShowOptimalPathFromBoundary: WordBool; safecall;
    procedure Set_ShowOptimalPathFromBoundary(Value: WordBool); safecall;
    function Get_ShowFastPathFromBoundary: WordBool; safecall;
    procedure Set_ShowFastPathFromBoundary(Value: WordBool); safecall;
    function Get_ShowStealthPathToBoundary: WordBool; safecall;
    procedure Set_ShowStealthPathToBoundary(Value: WordBool); safecall;
    function Get_ShowFastGuardPathToBoundary: WordBool; safecall;
    procedure Set_ShowFastGuardPathToBoundary(Value: WordBool); safecall;
    function Get_ShowOptimalPathFromStart: WordBool; safecall;
    procedure Set_ShowOptimalPathFromStart(Value: WordBool); safecall;
    function Get_ShowGraph: WordBool; safecall;
    procedure Set_ShowGraph(Value: WordBool); safecall;
    function Get_ShowText: WordBool; safecall;
    procedure Set_ShowText(Value: WordBool); safecall;
    function Get_ShowSymbols: WordBool; safecall;
    procedure Set_ShowSymbols(Value: WordBool); safecall;
    function Get_ShowDetectionZones: WordBool; safecall;
    procedure Set_ShowDetectionZones(Value: WordBool); safecall;
    function Get_ShowWalls: WordBool; safecall;
    procedure Set_ShowWalls(Value: WordBool); safecall;
    function Get_ShowOnlyBoundaryAreas: WordBool; safecall;
    property ShowOptimalPathFromBoundary: WordBool read Get_ShowOptimalPathFromBoundary write Set_ShowOptimalPathFromBoundary;
    property ShowFastPathFromBoundary: WordBool read Get_ShowFastPathFromBoundary write Set_ShowFastPathFromBoundary;
    property ShowStealthPathToBoundary: WordBool read Get_ShowStealthPathToBoundary write Set_ShowStealthPathToBoundary;
    property ShowFastGuardPathToBoundary: WordBool read Get_ShowFastGuardPathToBoundary write Set_ShowFastGuardPathToBoundary;
    property ShowOptimalPathFromStart: WordBool read Get_ShowOptimalPathFromStart write Set_ShowOptimalPathFromStart;
    property ShowGraph: WordBool read Get_ShowGraph write Set_ShowGraph;
    property ShowText: WordBool read Get_ShowText write Set_ShowText;
    property ShowSymbols: WordBool read Get_ShowSymbols write Set_ShowSymbols;
    property ShowDetectionZones: WordBool read Get_ShowDetectionZones write Set_ShowDetectionZones;
    property ShowWalls: WordBool read Get_ShowWalls write Set_ShowWalls;
    property ShowOnlyBoundaryAreas: WordBool read Get_ShowOnlyBoundaryAreas;
  end;

// *********************************************************************//
// DispIntf:  IVulnerabilityMapDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {375483C2-4DD6-11D6-96EE-0050BA51A6D3}
// *********************************************************************//
  IVulnerabilityMapDisp = dispinterface
    ['{375483C2-4DD6-11D6-96EE-0050BA51A6D3}']
    property ShowOptimalPathFromBoundary: WordBool dispid 2;
    property ShowFastPathFromBoundary: WordBool dispid 3;
    property ShowStealthPathToBoundary: WordBool dispid 4;
    property ShowFastGuardPathToBoundary: WordBool dispid 5;
    property ShowOptimalPathFromStart: WordBool dispid 6;
    property ShowGraph: WordBool dispid 7;
    property ShowText: WordBool dispid 8;
    property ShowSymbols: WordBool dispid 9;
    property ShowDetectionZones: WordBool dispid 10;
    property ShowWalls: WordBool dispid 11;
    property ShowOnlyBoundaryAreas: WordBool readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IBoundary2
// Flags:     (320) Dual OleAutomation
// GUID:      {3B9C7CF1-777A-11D6-971B-0050BA51A6D3}
// *********************************************************************//
  IBoundary2 = interface(IUnknown)
    ['{3B9C7CF1-777A-11D6-971B-0050BA51A6D3}']
    function Get_SoundResistanceSum0: Double; safecall;
    procedure Set_SoundResistanceSum0(Value: Double); safecall;
    function Get_SoundResistanceSum1: Double; safecall;
    procedure Set_SoundResistanceSum1(Value: Double); safecall;
    function Get_NearestSoundResistanceSum0: Double; safecall;
    procedure Set_NearestSoundResistanceSum0(Value: Double); safecall;
    function Get_NearestSoundResistanceSum1: Double; safecall;
    procedure Set_NearestSoundResistanceSum1(Value: Double); safecall;
    procedure ResetSoundResistance; safecall;
    property SoundResistanceSum0: Double read Get_SoundResistanceSum0 write Set_SoundResistanceSum0;
    property SoundResistanceSum1: Double read Get_SoundResistanceSum1 write Set_SoundResistanceSum1;
    property NearestSoundResistanceSum0: Double read Get_NearestSoundResistanceSum0 write Set_NearestSoundResistanceSum0;
    property NearestSoundResistanceSum1: Double read Get_NearestSoundResistanceSum1 write Set_NearestSoundResistanceSum1;
  end;

// *********************************************************************//
// DispIntf:  IBoundary2Disp
// Flags:     (320) Dual OleAutomation
// GUID:      {3B9C7CF1-777A-11D6-971B-0050BA51A6D3}
// *********************************************************************//
  IBoundary2Disp = dispinterface
    ['{3B9C7CF1-777A-11D6-971B-0050BA51A6D3}']
    property SoundResistanceSum0: Double dispid 2;
    property SoundResistanceSum1: Double dispid 3;
    property NearestSoundResistanceSum0: Double dispid 1;
    property NearestSoundResistanceSum1: Double dispid 4;
    procedure ResetSoundResistance; dispid 5;
  end;

// *********************************************************************//
// Interface: ITechnicalService
// Flags:     (320) Dual OleAutomation
// GUID:      {F5703240-1E89-11D3-BBF3-DF0FFE18F633}
// *********************************************************************//
  ITechnicalService = interface(IUnknown)
    ['{F5703240-1E89-11D3-BBF3-DF0FFE18F633}']
    function Get_Period: Double; safecall;
    function Get_Control: Integer; safecall;
    function Get_Testing: Integer; safecall;
    property Period: Double read Get_Period;
    property Control: Integer read Get_Control;
    property Testing: Integer read Get_Testing;
  end;

// *********************************************************************//
// DispIntf:  ITechnicalServiceDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {F5703240-1E89-11D3-BBF3-DF0FFE18F633}
// *********************************************************************//
  ITechnicalServiceDisp = dispinterface
    ['{F5703240-1E89-11D3-BBF3-DF0FFE18F633}']
    property Period: Double readonly dispid 1;
    property Control: Integer readonly dispid 2;
    property Testing: Integer readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IDetectionElement
// Flags:     (320) Dual OleAutomation
// GUID:      {EF126AB2-7E8C-11D6-9726-0050BA51A6D3}
// *********************************************************************//
  IDetectionElement = interface(IUnknown)
    ['{EF126AB2-7E8C-11D6-9726-0050BA51A6D3}']
    function Get_LocalAlarmSignal: WordBool; safecall;
    function Get_SecondaryControlDevice: IDMElement; safecall;
    function Get_TechnicalService: IDMElement; safecall;
    function Get_MainControlDevice: IDMElement; safecall;
    procedure Set_MainControlDevice(const Value: IDMElement); safecall;
    function Get_DetectionPosition: Integer; safecall;
    property LocalAlarmSignal: WordBool read Get_LocalAlarmSignal;
    property SecondaryControlDevice: IDMElement read Get_SecondaryControlDevice;
    property TechnicalService: IDMElement read Get_TechnicalService;
    property MainControlDevice: IDMElement read Get_MainControlDevice write Set_MainControlDevice;
    property DetectionPosition: Integer read Get_DetectionPosition;
  end;

// *********************************************************************//
// DispIntf:  IDetectionElementDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {EF126AB2-7E8C-11D6-9726-0050BA51A6D3}
// *********************************************************************//
  IDetectionElementDisp = dispinterface
    ['{EF126AB2-7E8C-11D6-9726-0050BA51A6D3}']
    property LocalAlarmSignal: WordBool readonly dispid 1;
    property SecondaryControlDevice: IDMElement readonly dispid 3;
    property TechnicalService: IDMElement readonly dispid 4;
    property MainControlDevice: IDMElement dispid 2;
    property DetectionPosition: Integer readonly dispid 6;
  end;

// *********************************************************************//
// Interface: IRoad
// Flags:     (320) Dual OleAutomation
// GUID:      {A2F1FDB1-84D4-11D6-972C-0050BA51A6D3}
// *********************************************************************//
  IRoad = interface(IUnknown)
    ['{A2F1FDB1-84D4-11D6-972C-0050BA51A6D3}']
    function Get_UserDefinedVehicleVelocity: WordBool; safecall;
    function Get_VehicleVelocity: Double; safecall;
    function Get_PedestrialVelocity: Double; safecall;
    function Get_PersonalPresence: Integer; safecall;
    property UserDefinedVehicleVelocity: WordBool read Get_UserDefinedVehicleVelocity;
    property VehicleVelocity: Double read Get_VehicleVelocity;
    property PedestrialVelocity: Double read Get_PedestrialVelocity;
    property PersonalPresence: Integer read Get_PersonalPresence;
  end;

// *********************************************************************//
// DispIntf:  IRoadDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {A2F1FDB1-84D4-11D6-972C-0050BA51A6D3}
// *********************************************************************//
  IRoadDisp = dispinterface
    ['{A2F1FDB1-84D4-11D6-972C-0050BA51A6D3}']
    property UserDefinedVehicleVelocity: WordBool readonly dispid 1;
    property VehicleVelocity: Double readonly dispid 2;
    property PedestrialVelocity: Double readonly dispid 3;
    property PersonalPresence: Integer readonly dispid 4;
  end;

// *********************************************************************//
// Interface: IUserDefinedPath
// Flags:     (320) Dual OleAutomation
// GUID:      {A2F1FDB3-84D4-11D6-972C-0050BA51A6D3}
// *********************************************************************//
  IUserDefinedPath = interface(IUnknown)
    ['{A2F1FDB3-84D4-11D6-972C-0050BA51A6D3}']
    function Get_AnalysisVariant: IDMElement; safecall;
    property AnalysisVariant: IDMElement read Get_AnalysisVariant;
  end;

// *********************************************************************//
// DispIntf:  IUserDefinedPathDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {A2F1FDB3-84D4-11D6-972C-0050BA51A6D3}
// *********************************************************************//
  IUserDefinedPathDisp = dispinterface
    ['{A2F1FDB3-84D4-11D6-972C-0050BA51A6D3}']
    property AnalysisVariant: IDMElement readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IGlobalZone
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {249B0381-8D7C-11D6-9733-0050BA51A6D3}
// *********************************************************************//
  IGlobalZone = interface(IDispatch)
    ['{249B0381-8D7C-11D6-9733-0050BA51A6D3}']
    function Get_LargestZone: IDMElement; safecall;
    property LargestZone: IDMElement read Get_LargestZone;
  end;

// *********************************************************************//
// DispIntf:  IGlobalZoneDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {249B0381-8D7C-11D6-9733-0050BA51A6D3}
// *********************************************************************//
  IGlobalZoneDisp = dispinterface
    ['{249B0381-8D7C-11D6-9733-0050BA51A6D3}']
    property LargestZone: IDMElement readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IAccess
// Flags:     (320) Dual OleAutomation
// GUID:      {E6BFAC11-8E49-11D6-9734-0050BA51A6D3}
// *********************************************************************//
  IAccess = interface(IUnknown)
    ['{E6BFAC11-8E49-11D6-9734-0050BA51A6D3}']
    function Get_AccessType: Integer; safecall;
    function Get_FacilityStates: IDMCollection; safecall;
    function Get_AccessRegion: Integer; safecall;
    property AccessType: Integer read Get_AccessType;
    property FacilityStates: IDMCollection read Get_FacilityStates;
    property AccessRegion: Integer read Get_AccessRegion;
  end;

// *********************************************************************//
// DispIntf:  IAccessDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {E6BFAC11-8E49-11D6-9734-0050BA51A6D3}
// *********************************************************************//
  IAccessDisp = dispinterface
    ['{E6BFAC11-8E49-11D6-9734-0050BA51A6D3}']
    property AccessType: Integer readonly dispid 1;
    property FacilityStates: IDMCollection readonly dispid 2;
    property AccessRegion: Integer readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IGroundObstacle
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75060-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IGroundObstacle = interface(IDispatch)
    ['{EDF75060-9759-11D6-9B9F-970B96239AA2}']
  end;

// *********************************************************************//
// DispIntf:  IGroundObstacleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75060-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IGroundObstacleDisp = dispinterface
    ['{EDF75060-9759-11D6-9B9F-970B96239AA2}']
  end;

// *********************************************************************//
// Interface: IFenceObstacle
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75062-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IFenceObstacle = interface(IDispatch)
    ['{EDF75062-9759-11D6-9B9F-970B96239AA2}']
    function Get_Width: Double; safecall;
    property Width: Double read Get_Width;
  end;

// *********************************************************************//
// DispIntf:  IFenceObstacleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EDF75062-9759-11D6-9B9F-970B96239AA2}
// *********************************************************************//
  IFenceObstacleDisp = dispinterface
    ['{EDF75062-9759-11D6-9B9F-970B96239AA2}']
    property Width: Double readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IRoadPart
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CC0F05D0-FBB3-11D6-97AD-0050BA51A6D3}
// *********************************************************************//
  IRoadPart = interface(IDispatch)
    ['{CC0F05D0-FBB3-11D6-97AD-0050BA51A6D3}']
    function Get_Road: IRoad; safecall;
    procedure Set_Road(const Value: IRoad); safecall;
    property Road: IRoad read Get_Road write Set_Road;
  end;

// *********************************************************************//
// DispIntf:  IRoadPartDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CC0F05D0-FBB3-11D6-97AD-0050BA51A6D3}
// *********************************************************************//
  IRoadPartDisp = dispinterface
    ['{CC0F05D0-FBB3-11D6-97AD-0050BA51A6D3}']
    property Road: IRoad dispid 1;
  end;

// *********************************************************************//
// Interface: ISensor
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6C39E8C0-1EB4-11D7-9B9F-8882FDE2B460}
// *********************************************************************//
  ISensor = interface(IDispatch)
    ['{6C39E8C0-1EB4-11D7-9B9F-8882FDE2B460}']
    function Get_UserDefinedFalseAlarmPeriod: WordBool; safecall;
    function Get_FalseAlarmPeriod: Double; safecall;
    procedure CalcFalseAlarmPeriod; safecall;
    property UserDefinedFalseAlarmPeriod: WordBool read Get_UserDefinedFalseAlarmPeriod;
    property FalseAlarmPeriod: Double read Get_FalseAlarmPeriod;
  end;

// *********************************************************************//
// DispIntf:  ISensorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6C39E8C0-1EB4-11D7-9B9F-8882FDE2B460}
// *********************************************************************//
  ISensorDisp = dispinterface
    ['{6C39E8C0-1EB4-11D7-9B9F-8882FDE2B460}']
    property UserDefinedFalseAlarmPeriod: WordBool readonly dispid 1;
    property FalseAlarmPeriod: Double readonly dispid 2;
    procedure CalcFalseAlarmPeriod; dispid 3;
  end;

// *********************************************************************//
// Interface: IAlarmAssess
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D6DA6000-2586-11D7-9B9F-AF2428699060}
// *********************************************************************//
  IAlarmAssess = interface(IDispatch)
    ['{D6DA6000-2586-11D7-9B9F-AF2428699060}']
    function GetAssessProbability: Double; safecall;
  end;

// *********************************************************************//
// DispIntf:  IAlarmAssessDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D6DA6000-2586-11D7-9B9F-AF2428699060}
// *********************************************************************//
  IAlarmAssessDisp = dispinterface
    ['{D6DA6000-2586-11D7-9B9F-AF2428699060}']
    function GetAssessProbability: Double; dispid 1;
  end;

// *********************************************************************//
// Interface: IBoundaryState
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {803E4A60-6DF5-11D7-9BA0-81150452AC60}
// *********************************************************************//
  IBoundaryState = interface(IDispatch)
    ['{803E4A60-6DF5-11D7-9BA0-81150452AC60}']
  end;

// *********************************************************************//
// DispIntf:  IBoundaryStateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {803E4A60-6DF5-11D7-9BA0-81150452AC60}
// *********************************************************************//
  IBoundaryStateDisp = dispinterface
    ['{803E4A60-6DF5-11D7-9BA0-81150452AC60}']
  end;

// *********************************************************************//
// Interface: IPathArc
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B2C7FD47-E3EA-4BA1-86A0-B8A1A5A17483}
// *********************************************************************//
  IPathArc = interface(IDispatch)
    ['{B2C7FD47-E3EA-4BA1-86A0-B8A1A5A17483}']
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    function Get_FacilityState: IDMElement; safecall;
    procedure Set_FacilityState(const Value: IDMElement); safecall;
    function Get_Value: Double; safecall;
    procedure Set_Value(Value: Double); safecall;
    property Kind: Integer read Get_Kind write Set_Kind;
    property FacilityState: IDMElement read Get_FacilityState write Set_FacilityState;
    property Value: Double read Get_Value write Set_Value;
  end;

// *********************************************************************//
// DispIntf:  IPathArcDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B2C7FD47-E3EA-4BA1-86A0-B8A1A5A17483}
// *********************************************************************//
  IPathArcDisp = dispinterface
    ['{B2C7FD47-E3EA-4BA1-86A0-B8A1A5A17483}']
    property Kind: Integer dispid 1;
    property FacilityState: IDMElement dispid 2;
    property Value: Double dispid 4;
  end;

// *********************************************************************//
// Interface: IWarriorPathElement
// Flags:     (320) Dual OleAutomation
// GUID:      {1F1F2C31-ADE2-11D7-9885-0050BA51A6D3}
// *********************************************************************//
  IWarriorPathElement = interface(IUnknown)
    ['{1F1F2C31-ADE2-11D7-9885-0050BA51A6D3}']
    function Get_T: Double; safecall;
    procedure Set_T(Value: Double); safecall;
    function Get_P: Double; safecall;
    procedure Set_P(Value: Double); safecall;
    function Get_dT: Double; safecall;
    procedure Set_dT(Value: Double); safecall;
    function Get_NoDetP: Double; safecall;
    procedure Set_NoDetP(Value: Double); safecall;
    function Get_RejDetP: Double; safecall;
    procedure Set_RejDetP(Value: Double); safecall;
    function Get_NoFailureP: Double; safecall;
    procedure Set_NoFailureP(Value: Double); safecall;
    function Get_NoEvidence: WordBool; safecall;
    procedure Set_NoEvidence(Value: WordBool); safecall;
    function Get_OutstripProbabilityR: Double; safecall;
    procedure Set_OutstripProbabilityR(Value: Double); safecall;
    function Get_R: Double; safecall;
    procedure Set_R(Value: Double); safecall;
    function Get_dR: Double; safecall;
    procedure Set_dR(Value: Double); safecall;
    function Get_FacilityState: IDMElement; safecall;
    procedure Set_FacilityState(const Value: IDMElement); safecall;
    function Get_B: Double; safecall;
    procedure Set_B(Value: Double); safecall;
    function Get_dB: Double; safecall;
    procedure Set_dB(Value: Double); safecall;
    function Get_P0: Double; safecall;
    procedure Set_P0(Value: Double); safecall;
    function Get_R0: Double; safecall;
    procedure Set_R0(Value: Double); safecall;
    function Get_B0: Double; safecall;
    procedure Set_B0(Value: Double); safecall;
    function Get_B1: Double; safecall;
    procedure Set_B1(Value: Double); safecall;
    procedure Reset; safecall;
    function Get_TDisp: Double; safecall;
    procedure Set_TDisp(Value: Double); safecall;
    function Get_dTDisp: Double; safecall;
    procedure Set_dTDisp(Value: Double); safecall;
    property T: Double read Get_T write Set_T;
    property P: Double read Get_P write Set_P;
    property dT: Double read Get_dT write Set_dT;
    property NoDetP: Double read Get_NoDetP write Set_NoDetP;
    property RejDetP: Double read Get_RejDetP write Set_RejDetP;
    property NoFailureP: Double read Get_NoFailureP write Set_NoFailureP;
    property NoEvidence: WordBool read Get_NoEvidence write Set_NoEvidence;
    property OutstripProbabilityR: Double read Get_OutstripProbabilityR write Set_OutstripProbabilityR;
    property R: Double read Get_R write Set_R;
    property dR: Double read Get_dR write Set_dR;
    property FacilityState: IDMElement read Get_FacilityState write Set_FacilityState;
    property B: Double read Get_B write Set_B;
    property dB: Double read Get_dB write Set_dB;
    property P0: Double read Get_P0 write Set_P0;
    property R0: Double read Get_R0 write Set_R0;
    property B0: Double read Get_B0 write Set_B0;
    property B1: Double read Get_B1 write Set_B1;
    property TDisp: Double read Get_TDisp write Set_TDisp;
    property dTDisp: Double read Get_dTDisp write Set_dTDisp;
  end;

// *********************************************************************//
// DispIntf:  IWarriorPathElementDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {1F1F2C31-ADE2-11D7-9885-0050BA51A6D3}
// *********************************************************************//
  IWarriorPathElementDisp = dispinterface
    ['{1F1F2C31-ADE2-11D7-9885-0050BA51A6D3}']
    property T: Double dispid 5;
    property P: Double dispid 6;
    property dT: Double dispid 8;
    property NoDetP: Double dispid 9;
    property RejDetP: Double dispid 13;
    property NoFailureP: Double dispid 14;
    property NoEvidence: WordBool dispid 15;
    property OutstripProbabilityR: Double dispid 2;
    property R: Double dispid 21;
    property dR: Double dispid 22;
    property FacilityState: IDMElement dispid 27;
    property B: Double dispid 29;
    property dB: Double dispid 30;
    property P0: Double dispid 32;
    property R0: Double dispid 34;
    property B0: Double dispid 35;
    property B1: Double dispid 36;
    procedure Reset; dispid 37;
    property TDisp: Double dispid 7;
    property dTDisp: Double dispid 10;
  end;

// *********************************************************************//
// Interface: IConnection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6230D8A1-F889-11D7-98CD-0050BA51A6D3}
// *********************************************************************//
  IConnection = interface(IDispatch)
    ['{6230D8A1-F889-11D7-98CD-0050BA51A6D3}']
    function ConnectedTo(const MainControlDeviceE: IDMElement; 
                         const SecondaryControlDeviceE: IDMElement; 
                         const CheckedConnections: IDMCollection): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IConnectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6230D8A1-F889-11D7-98CD-0050BA51A6D3}
// *********************************************************************//
  IConnectionDisp = dispinterface
    ['{6230D8A1-F889-11D7-98CD-0050BA51A6D3}']
    function ConnectedTo(const MainControlDeviceE: IDMElement; 
                         const SecondaryControlDeviceE: IDMElement; 
                         const CheckedConnections: IDMCollection): WordBool; dispid 1;
  end;

// *********************************************************************//
// Interface: IPathNodeArray
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E8247791-FA18-11D7-98D0-0050BA51A6D3}
// *********************************************************************//
  IPathNodeArray = interface(IDispatch)
    ['{E8247791-FA18-11D7-98D0-0050BA51A6D3}']
    function Get_PathNodes: IDMCollection; safecall;
    property PathNodes: IDMCollection read Get_PathNodes;
  end;

// *********************************************************************//
// DispIntf:  IPathNodeArrayDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E8247791-FA18-11D7-98D0-0050BA51A6D3}
// *********************************************************************//
  IPathNodeArrayDisp = dispinterface
    ['{E8247791-FA18-11D7-98D0-0050BA51A6D3}']
    property PathNodes: IDMCollection readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IControlDevice
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB147E91-FADE-11D7-98D2-0050BA51A6D3}
// *********************************************************************//
  IControlDevice = interface(IDispatch)
    ['{FB147E91-FADE-11D7-98D2-0050BA51A6D3}']
    function InWorkingState: WordBool; safecall;
    function Get_InputConnections: IDMCollection; safecall;
    function Get_CabelSafety: Integer; safecall;
    function Get_OutputConnections: IDMCollection; safecall;
    property InputConnections: IDMCollection read Get_InputConnections;
    property CabelSafety: Integer read Get_CabelSafety;
    property OutputConnections: IDMCollection read Get_OutputConnections;
  end;

// *********************************************************************//
// DispIntf:  IControlDeviceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FB147E91-FADE-11D7-98D2-0050BA51A6D3}
// *********************************************************************//
  IControlDeviceDisp = dispinterface
    ['{FB147E91-FADE-11D7-98D2-0050BA51A6D3}']
    function InWorkingState: WordBool; dispid 1;
    property InputConnections: IDMCollection readonly dispid 4;
    property CabelSafety: Integer readonly dispid 2;
    property OutputConnections: IDMCollection readonly dispid 3;
  end;

// *********************************************************************//
// Interface: ISafeguardUnit
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {41AFEA40-1185-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  ISafeguardUnit = interface(IDispatch)
    ['{41AFEA40-1185-11D8-BBF3-0010603BA6C9}']
    function Get_SafeguardElements: IDMCollection; safecall;
    property SafeguardElements: IDMCollection read Get_SafeguardElements;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardUnitDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {41AFEA40-1185-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  ISafeguardUnitDisp = dispinterface
    ['{41AFEA40-1185-11D8-BBF3-0010603BA6C9}']
    property SafeguardElements: IDMCollection readonly dispid 1;
  end;

// *********************************************************************//
// Interface: ICriticalPoint
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3D894E1-1349-11D8-98EB-0050BA51A6D3}
// *********************************************************************//
  ICriticalPoint = interface(IDispatch)
    ['{B3D894E1-1349-11D8-98EB-0050BA51A6D3}']
    function Get_InterruptionProbability: Double; safecall;
    procedure Set_InterruptionProbability(Value: Double); safecall;
    function Get_TimeRemainder: Double; safecall;
    procedure Set_TimeRemainder(Value: Double); safecall;
    function Get_DelayTimeToTarget: Double; safecall;
    procedure Set_DelayTimeToTarget(Value: Double); safecall;
    procedure MakeRecomendations(RecomendationKind: Integer); safecall;
    function Get_WarriorPath: IDMElement; safecall;
    property InterruptionProbability: Double read Get_InterruptionProbability write Set_InterruptionProbability;
    property TimeRemainder: Double read Get_TimeRemainder write Set_TimeRemainder;
    property DelayTimeToTarget: Double read Get_DelayTimeToTarget write Set_DelayTimeToTarget;
    property WarriorPath: IDMElement read Get_WarriorPath;
  end;

// *********************************************************************//
// DispIntf:  ICriticalPointDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3D894E1-1349-11D8-98EB-0050BA51A6D3}
// *********************************************************************//
  ICriticalPointDisp = dispinterface
    ['{B3D894E1-1349-11D8-98EB-0050BA51A6D3}']
    property InterruptionProbability: Double dispid 1;
    property TimeRemainder: Double dispid 2;
    property DelayTimeToTarget: Double dispid 3;
    procedure MakeRecomendations(RecomendationKind: Integer); dispid 4;
    property WarriorPath: IDMElement readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IFMRecomendation
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3D894E3-1349-11D8-98EB-0050BA51A6D3}
// *********************************************************************//
  IFMRecomendation = interface(IDispatch)
    ['{B3D894E3-1349-11D8-98EB-0050BA51A6D3}']
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    function Get_Priority: Double; safecall;
    procedure Set_Priority(Value: Double); safecall;
    procedure MakeText; safecall;
    property Kind: Integer read Get_Kind write Set_Kind;
    property Priority: Double read Get_Priority write Set_Priority;
  end;

// *********************************************************************//
// DispIntf:  IFMRecomendationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3D894E3-1349-11D8-98EB-0050BA51A6D3}
// *********************************************************************//
  IFMRecomendationDisp = dispinterface
    ['{B3D894E3-1349-11D8-98EB-0050BA51A6D3}']
    property Kind: Integer dispid 1;
    property Priority: Double dispid 2;
    procedure MakeText; dispid 3;
  end;

// *********************************************************************//
// Interface: ISafeguardUnit2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {20BA5FC3-1B21-11D8-98F8-0050BA51A6D3}
// *********************************************************************//
  ISafeguardUnit2 = interface(IDispatch)
    ['{20BA5FC3-1B21-11D8-98F8-0050BA51A6D3}']
    procedure MakePersistant(const SubState: IDMElement); safecall;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardUnit2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {20BA5FC3-1B21-11D8-98F8-0050BA51A6D3}
// *********************************************************************//
  ISafeguardUnit2Disp = dispinterface
    ['{20BA5FC3-1B21-11D8-98F8-0050BA51A6D3}']
    procedure MakePersistant(const SubState: IDMElement); dispid 1;
  end;

// *********************************************************************//
// Interface: IFMState
// Flags:     (320) Dual OleAutomation
// GUID:      {B6FA295E-0D7C-4225-B9F6-3B341FD91EFC}
// *********************************************************************//
  IFMState = interface(IUnknown)
    ['{B6FA295E-0D7C-4225-B9F6-3B341FD91EFC}']
    function Get_CurrentWarriorGroupU: IUnknown; safecall;
    procedure Set_CurrentWarriorGroupU(const Value: IUnknown); safecall;
    function Get_CurrentFacilityStateU: IUnknown; safecall;
    procedure Set_CurrentFacilityStateU(const Value: IUnknown); safecall;
    function Get_CurrentLineU: IUnknown; safecall;
    procedure Set_CurrentLineU(const Value: IUnknown); safecall;
    function Get_CurrentZone0U: IUnknown; safecall;
    procedure Set_CurrentZone0U(const Value: IUnknown); safecall;
    function Get_CurrentZone1U: IUnknown; safecall;
    procedure Set_CurrentZone1U(const Value: IUnknown); safecall;
    function Get_CurrentPathStage: Integer; safecall;
    procedure Set_CurrentPathStage(Value: Integer); safecall;
    function Get_CurrentNodeDirection: Integer; safecall;
    procedure Set_CurrentNodeDirection(Value: Integer); safecall;
    function Get_CurrentDirectPathFlag: WordBool; safecall;
    procedure Set_CurrentDirectPathFlag(Value: WordBool); safecall;
    function Get_CurrentReactionTime: Double; safecall;
    procedure Set_CurrentReactionTime(Value: Double); safecall;
    function Get_CurrentReactionTimeDispersion: Double; safecall;
    procedure Set_CurrentReactionTimeDispersion(Value: Double); safecall;
    function Get_CurrentPatrolPeriod: Double; safecall;
    procedure Set_CurrentPatrolPeriod(Value: Double); safecall;
    function Get_CurrentAnalysisVariantU: IUnknown; safecall;
    procedure Set_CurrentAnalysisVariantU(const Value: IUnknown); safecall;
    function Get_CurrentPathArcKind: Integer; safecall;
    procedure Set_CurrentPathArcKind(Value: Integer); safecall;
    function Get_TotalBackPathDelayTime: Double; safecall;
    procedure Set_TotalBackPathDelayTime(Value: Double); safecall;
    function Get_TotalBackPathDelayTimeDispersion: Double; safecall;
    procedure Set_TotalBackPathDelayTimeDispersion(Value: Double); safecall;
    function Get_DelayFlag: WordBool; safecall;
    procedure Set_DelayFlag(Value: WordBool); safecall;
    function Get_CurrentTacticU: IUnknown; safecall;
    procedure Set_CurrentTacticU(const Value: IUnknown); safecall;
    function Get_CurrentBoundary0U: IUnknown; safecall;
    procedure Set_CurrentBoundary0U(const Value: IUnknown); safecall;
    function Get_CurrentBoundary1U: IUnknown; safecall;
    procedure Set_CurrentBoundary1U(const Value: IUnknown); safecall;
    function Get_ForceTacticEnabled: WordBool; safecall;
    procedure Set_ForceTacticEnabled(Value: WordBool); safecall;
    function Get_CurrentDistance: Double; safecall;
    function Get_CurrentSafeguardElementU: IUnknown; safecall;
    procedure Set_CurrentSafeguardElementU(const Value: IUnknown); safecall;
    property CurrentWarriorGroupU: IUnknown read Get_CurrentWarriorGroupU write Set_CurrentWarriorGroupU;
    property CurrentFacilityStateU: IUnknown read Get_CurrentFacilityStateU write Set_CurrentFacilityStateU;
    property CurrentLineU: IUnknown read Get_CurrentLineU write Set_CurrentLineU;
    property CurrentZone0U: IUnknown read Get_CurrentZone0U write Set_CurrentZone0U;
    property CurrentZone1U: IUnknown read Get_CurrentZone1U write Set_CurrentZone1U;
    property CurrentPathStage: Integer read Get_CurrentPathStage write Set_CurrentPathStage;
    property CurrentNodeDirection: Integer read Get_CurrentNodeDirection write Set_CurrentNodeDirection;
    property CurrentDirectPathFlag: WordBool read Get_CurrentDirectPathFlag write Set_CurrentDirectPathFlag;
    property CurrentReactionTime: Double read Get_CurrentReactionTime write Set_CurrentReactionTime;
    property CurrentReactionTimeDispersion: Double read Get_CurrentReactionTimeDispersion write Set_CurrentReactionTimeDispersion;
    property CurrentPatrolPeriod: Double read Get_CurrentPatrolPeriod write Set_CurrentPatrolPeriod;
    property CurrentAnalysisVariantU: IUnknown read Get_CurrentAnalysisVariantU write Set_CurrentAnalysisVariantU;
    property CurrentPathArcKind: Integer read Get_CurrentPathArcKind write Set_CurrentPathArcKind;
    property TotalBackPathDelayTime: Double read Get_TotalBackPathDelayTime write Set_TotalBackPathDelayTime;
    property TotalBackPathDelayTimeDispersion: Double read Get_TotalBackPathDelayTimeDispersion write Set_TotalBackPathDelayTimeDispersion;
    property DelayFlag: WordBool read Get_DelayFlag write Set_DelayFlag;
    property CurrentTacticU: IUnknown read Get_CurrentTacticU write Set_CurrentTacticU;
    property CurrentBoundary0U: IUnknown read Get_CurrentBoundary0U write Set_CurrentBoundary0U;
    property CurrentBoundary1U: IUnknown read Get_CurrentBoundary1U write Set_CurrentBoundary1U;
    property ForceTacticEnabled: WordBool read Get_ForceTacticEnabled write Set_ForceTacticEnabled;
    property CurrentDistance: Double read Get_CurrentDistance;
    property CurrentSafeguardElementU: IUnknown read Get_CurrentSafeguardElementU write Set_CurrentSafeguardElementU;
  end;

// *********************************************************************//
// DispIntf:  IFMStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {B6FA295E-0D7C-4225-B9F6-3B341FD91EFC}
// *********************************************************************//
  IFMStateDisp = dispinterface
    ['{B6FA295E-0D7C-4225-B9F6-3B341FD91EFC}']
    property CurrentWarriorGroupU: IUnknown dispid 1;
    property CurrentFacilityStateU: IUnknown dispid 2;
    property CurrentLineU: IUnknown dispid 4;
    property CurrentZone0U: IUnknown dispid 7;
    property CurrentZone1U: IUnknown dispid 8;
    property CurrentPathStage: Integer dispid 10;
    property CurrentNodeDirection: Integer dispid 13;
    property CurrentDirectPathFlag: WordBool dispid 14;
    property CurrentReactionTime: Double dispid 15;
    property CurrentReactionTimeDispersion: Double dispid 16;
    property CurrentPatrolPeriod: Double dispid 17;
    property CurrentAnalysisVariantU: IUnknown dispid 3;
    property CurrentPathArcKind: Integer dispid 5;
    property TotalBackPathDelayTime: Double dispid 6;
    property TotalBackPathDelayTimeDispersion: Double dispid 9;
    property DelayFlag: WordBool dispid 11;
    property CurrentTacticU: IUnknown dispid 18;
    property CurrentBoundary0U: IUnknown dispid 19;
    property CurrentBoundary1U: IUnknown dispid 20;
    property ForceTacticEnabled: WordBool dispid 12;
    property CurrentDistance: Double readonly dispid 21;
    property CurrentSafeguardElementU: IUnknown dispid 22;
  end;

// *********************************************************************//
// Interface: IBoundary3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7A9ECCE8-E389-463C-8A70-01E940A04FB6}
// *********************************************************************//
  IBoundary3 = interface(IDispatch)
    ['{7A9ECCE8-E389-463C-8A70-01E940A04FB6}']
    function Get_ShoulderWidth: Double; safecall;
    procedure Set_ShoulderWidth(Value: Double); safecall;
    function Get_MaxBoundaryDistance: Double; safecall;
    procedure Set_MaxBoundaryDistance(Value: Double); safecall;
    function Get_MaxPathAlongBoundaryDistance: Double; safecall;
    procedure Set_MaxPathAlongBoundaryDistance(Value: Double); safecall;
    function Get_RightSideIsInner: WordBool; safecall;
    property ShoulderWidth: Double read Get_ShoulderWidth write Set_ShoulderWidth;
    property MaxBoundaryDistance: Double read Get_MaxBoundaryDistance write Set_MaxBoundaryDistance;
    property MaxPathAlongBoundaryDistance: Double read Get_MaxPathAlongBoundaryDistance write Set_MaxPathAlongBoundaryDistance;
    property RightSideIsInner: WordBool read Get_RightSideIsInner;
  end;

// *********************************************************************//
// DispIntf:  IBoundary3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7A9ECCE8-E389-463C-8A70-01E940A04FB6}
// *********************************************************************//
  IBoundary3Disp = dispinterface
    ['{7A9ECCE8-E389-463C-8A70-01E940A04FB6}']
    property ShoulderWidth: Double dispid 1;
    property MaxBoundaryDistance: Double dispid 2;
    property MaxPathAlongBoundaryDistance: Double dispid 3;
    property RightSideIsInner: WordBool readonly dispid 4;
  end;

// *********************************************************************//
// Interface: IGuardArrival
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {11975726-2C31-441D-810C-8DBC9B6EA558}
// *********************************************************************//
  IGuardArrival = interface(IDispatch)
    ['{11975726-2C31-441D-810C-8DBC9B6EA558}']
    function Get_ArrivalTime0: Double; safecall;
    procedure Set_ArrivalTime0(Value: Double); safecall;
    function Get_ArrivalTime1: Double; safecall;
    procedure Set_ArrivalTime1(Value: Double); safecall;
    function Get_UserDefinedArrivalTime: Integer; safecall;
    procedure Set_UserDefinedArrivalTime(Value: Integer); safecall;
    function Get_ArrivalTimeDispersion0: Double; safecall;
    procedure Set_ArrivalTimeDispersion0(Value: Double); safecall;
    function Get_ArrivalTimeDispersion1: Double; safecall;
    procedure Set_ArrivalTimeDispersion1(Value: Double); safecall;
    property ArrivalTime0: Double read Get_ArrivalTime0 write Set_ArrivalTime0;
    property ArrivalTime1: Double read Get_ArrivalTime1 write Set_ArrivalTime1;
    property UserDefinedArrivalTime: Integer read Get_UserDefinedArrivalTime write Set_UserDefinedArrivalTime;
    property ArrivalTimeDispersion0: Double read Get_ArrivalTimeDispersion0 write Set_ArrivalTimeDispersion0;
    property ArrivalTimeDispersion1: Double read Get_ArrivalTimeDispersion1 write Set_ArrivalTimeDispersion1;
  end;

// *********************************************************************//
// DispIntf:  IGuardArrivalDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {11975726-2C31-441D-810C-8DBC9B6EA558}
// *********************************************************************//
  IGuardArrivalDisp = dispinterface
    ['{11975726-2C31-441D-810C-8DBC9B6EA558}']
    property ArrivalTime0: Double dispid 1;
    property ArrivalTime1: Double dispid 2;
    property UserDefinedArrivalTime: Integer dispid 3;
    property ArrivalTimeDispersion0: Double dispid 4;
    property ArrivalTimeDispersion1: Double dispid 5;
  end;

// *********************************************************************//
// Interface: IImager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {949D2686-5893-4404-B61A-3C5E9D7A4BA5}
// *********************************************************************//
  IImager = interface(IDispatch)
    ['{949D2686-5893-4404-B61A-3C5E9D7A4BA5}']
    function Get_ImageRotated: WordBool; safecall;
    function Get_SymbolScaleFactor: Double; safecall;
    function Get_ShowSymbol: WordBool; safecall;
    function Get_ImageMirrored: WordBool; safecall;
    procedure CorrectDrawingDirection; safecall;
    property ImageRotated: WordBool read Get_ImageRotated;
    property SymbolScaleFactor: Double read Get_SymbolScaleFactor;
    property ShowSymbol: WordBool read Get_ShowSymbol;
    property ImageMirrored: WordBool read Get_ImageMirrored;
  end;

// *********************************************************************//
// DispIntf:  IImagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {949D2686-5893-4404-B61A-3C5E9D7A4BA5}
// *********************************************************************//
  IImagerDisp = dispinterface
    ['{949D2686-5893-4404-B61A-3C5E9D7A4BA5}']
    property ImageRotated: WordBool readonly dispid 1;
    property SymbolScaleFactor: Double readonly dispid 2;
    property ShowSymbol: WordBool readonly dispid 3;
    property ImageMirrored: WordBool readonly dispid 4;
    procedure CorrectDrawingDirection; dispid 5;
  end;

// *********************************************************************//
// Interface: IWidthIntf
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3C6B1F15-4EFB-4E54-89B9-AC3BD2907537}
// *********************************************************************//
  IWidthIntf = interface(IDispatch)
    ['{3C6B1F15-4EFB-4E54-89B9-AC3BD2907537}']
    function Get_Width: Double; safecall;
    property Width: Double read Get_Width;
  end;

// *********************************************************************//
// DispIntf:  IWidthIntfDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3C6B1F15-4EFB-4E54-89B9-AC3BD2907537}
// *********************************************************************//
  IWidthIntfDisp = dispinterface
    ['{3C6B1F15-4EFB-4E54-89B9-AC3BD2907537}']
    property Width: Double readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IZone2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C6CF9DF9-321B-4ACD-AD44-FF08119E8A47}
// *********************************************************************//
  IZone2 = interface(IDispatch)
    ['{C6CF9DF9-321B-4ACD-AD44-FF08119E8A47}']
    function Get_IsConvex: WordBool; safecall;
    function Get_Outline: IDMCollection; safecall;
    function Get_InnerZoneOutlineCount: Integer; safecall;
    function Get_InnerZoneOutline(Index: Integer): IDMCollection; safecall;
    procedure MakeOutlinePath(const OutlineFactory: IDMCollection2; 
                              const NodeFactory: IDMCollection2); safecall;
    function Get_ZoneNode: IDMElement; safecall;
    procedure Set_ZoneNode(const Value: IDMElement); safecall;
    procedure MakeRoundaboutPath(const StartNodeE: IDMElement; const FinishNodeE: IDMElement; 
                                 const ArcFactory: IDMCollection2; const NodeFactory: IDMCollection2); safecall;
    procedure ClearRoundaboutPath; safecall;
    property IsConvex: WordBool read Get_IsConvex;
    property Outline: IDMCollection read Get_Outline;
    property InnerZoneOutlineCount: Integer read Get_InnerZoneOutlineCount;
    property InnerZoneOutline[Index: Integer]: IDMCollection read Get_InnerZoneOutline;
    property ZoneNode: IDMElement read Get_ZoneNode write Set_ZoneNode;
  end;

// *********************************************************************//
// DispIntf:  IZone2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C6CF9DF9-321B-4ACD-AD44-FF08119E8A47}
// *********************************************************************//
  IZone2Disp = dispinterface
    ['{C6CF9DF9-321B-4ACD-AD44-FF08119E8A47}']
    property IsConvex: WordBool readonly dispid 1;
    property Outline: IDMCollection readonly dispid 2;
    property InnerZoneOutlineCount: Integer readonly dispid 3;
    property InnerZoneOutline[Index: Integer]: IDMCollection readonly dispid 4;
    procedure MakeOutlinePath(const OutlineFactory: IDMCollection2; 
                              const NodeFactory: IDMCollection2); dispid 5;
    property ZoneNode: IDMElement dispid 6;
    procedure MakeRoundaboutPath(const StartNodeE: IDMElement; const FinishNodeE: IDMElement; 
                                 const ArcFactory: IDMCollection2; const NodeFactory: IDMCollection2); dispid 7;
    procedure ClearRoundaboutPath; dispid 8;
  end;

// *********************************************************************//
// Interface: IStairBuilder
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0C1C3DB0-80B5-4EF7-9CDF-ACA7E0E65280}
// *********************************************************************//
  IStairBuilder = interface(IDispatch)
    ['{0C1C3DB0-80B5-4EF7-9CDF-ACA7E0E65280}']
    procedure BuildStair; safecall;
    function Get_StairWidth: Double; safecall;
    procedure Set_StairWidth(Value: Double); safecall;
    function Get_StairTurnAngle: Integer; safecall;
    procedure Set_StairTurnAngle(Value: Integer); safecall;
    property StairWidth: Double read Get_StairWidth write Set_StairWidth;
    property StairTurnAngle: Integer read Get_StairTurnAngle write Set_StairTurnAngle;
  end;

// *********************************************************************//
// DispIntf:  IStairBuilderDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0C1C3DB0-80B5-4EF7-9CDF-ACA7E0E65280}
// *********************************************************************//
  IStairBuilderDisp = dispinterface
    ['{0C1C3DB0-80B5-4EF7-9CDF-ACA7E0E65280}']
    procedure BuildStair; dispid 1;
    property StairWidth: Double dispid 2;
    property StairTurnAngle: Integer dispid 4;
  end;

// *********************************************************************//
// Interface: IElementParameterValue
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C4177E40-D7D9-11DA-B2B6-A37BE6432D60}
// *********************************************************************//
  IElementParameterValue = interface(IDispatch)
    ['{C4177E40-D7D9-11DA-B2B6-A37BE6432D60}']
  end;

// *********************************************************************//
// DispIntf:  IElementParameterValueDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C4177E40-D7D9-11DA-B2B6-A37BE6432D60}
// *********************************************************************//
  IElementParameterValueDisp = dispinterface
    ['{C4177E40-D7D9-11DA-B2B6-A37BE6432D60}']
  end;

// *********************************************************************//
// Interface: IInsiderTarget
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E3CA6913-2984-41CF-9899-D11256ED87DD}
// *********************************************************************//
  IInsiderTarget = interface(IDispatch)
    ['{E3CA6913-2984-41CF-9899-D11256ED87DD}']
    function Get_ControledByInsider: SYSINT; safecall;
    property ControledByInsider: SYSINT read Get_ControledByInsider;
  end;

// *********************************************************************//
// DispIntf:  IInsiderTargetDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E3CA6913-2984-41CF-9899-D11256ED87DD}
// *********************************************************************//
  IInsiderTargetDisp = dispinterface
    ['{E3CA6913-2984-41CF-9899-D11256ED87DD}']
    property ControledByInsider: SYSINT readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IControlDeviceAccess
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0CBF3983-39DE-412B-A9BC-2D01A596E2CA}
// *********************************************************************//
  IControlDeviceAccess = interface(IDispatch)
    ['{0CBF3983-39DE-412B-A9BC-2D01A596E2CA}']
  end;

// *********************************************************************//
// DispIntf:  IControlDeviceAccessDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0CBF3983-39DE-412B-A9BC-2D01A596E2CA}
// *********************************************************************//
  IControlDeviceAccessDisp = dispinterface
    ['{0CBF3983-39DE-412B-A9BC-2D01A596E2CA}']
  end;

// *********************************************************************//
// Interface: IGuardPostAccess
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CBE1F657-3E91-4104-8EE4-31A632928C37}
// *********************************************************************//
  IGuardPostAccess = interface(IDispatch)
    ['{CBE1F657-3E91-4104-8EE4-31A632928C37}']
  end;

// *********************************************************************//
// DispIntf:  IGuardPostAccessDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CBE1F657-3E91-4104-8EE4-31A632928C37}
// *********************************************************************//
  IGuardPostAccessDisp = dispinterface
    ['{CBE1F657-3E91-4104-8EE4-31A632928C37}']
  end;

// *********************************************************************//
// Interface: ISubBoundary
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3B367272-4523-4E9E-B8EF-9870617A873E}
// *********************************************************************//
  ISubBoundary = interface(IDispatch)
    ['{3B367272-4523-4E9E-B8EF-9870617A873E}']
    procedure CalcParams(AddDelay: Double; ObservationPeriod: Double; out dTFast: Double; 
                         out dTDispFast: Double; out NoDetPFast: Double; out NoDetP1Fast: Double; 
                         out NoFailurePFast: Double; out NoEvidenceFast: WordBool; 
                         out PSFast: Double; out dTStealth: Double; out dTDispStealth: Double; 
                         out NoDetPStealth: Double; out NoDetP1Stealth: Double; 
                         out NoFailurePStealth: Double; out NoEvidenceStealth: WordBool; 
                         out PSStealth: Double; out PositionFast: Integer; 
                         out PositionStealth: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  ISubBoundaryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3B367272-4523-4E9E-B8EF-9870617A873E}
// *********************************************************************//
  ISubBoundaryDisp = dispinterface
    ['{3B367272-4523-4E9E-B8EF-9870617A873E}']
    procedure CalcParams(AddDelay: Double; ObservationPeriod: Double; out dTFast: Double; 
                         out dTDispFast: Double; out NoDetPFast: Double; out NoDetP1Fast: Double; 
                         out NoFailurePFast: Double; out NoEvidenceFast: WordBool; 
                         out PSFast: Double; out dTStealth: Double; out dTDispStealth: Double; 
                         out NoDetPStealth: Double; out NoDetP1Stealth: Double; 
                         out NoFailurePStealth: Double; out NoEvidenceStealth: WordBool; 
                         out PSStealth: Double; out PositionFast: Integer; 
                         out PositionStealth: Integer); dispid 1;
  end;

// *********************************************************************//
// Interface: IOvercomingBoundary
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BE6369C0-474A-4DE4-AB03-FCF443BF73E4}
// *********************************************************************//
  IOvercomingBoundary = interface(IDispatch)
    ['{BE6369C0-474A-4DE4-AB03-FCF443BF73E4}']
    function Get_PursuerGuards: IDMCollection; safecall;
    function Get_BoundaryUnknowns: IDMCollection; safecall;
    function Get_StartingGuards: IDMCollection; safecall;
    function Get_BoundaryNoIntercepts: IDMCollection; safecall;
    function Get_BoundaryCombatDefeats: IDMCollection; safecall;
    procedure Set_InfoState(Param1: Integer); safecall;
    procedure Set_SumW(Param1: Double); safecall;
    procedure Set_ProdNotU(Param1: Double); safecall;
    procedure Set_BattleProbability(Param1: Double); safecall;
    procedure Set_BattleTime(Param1: Double); safecall;
    procedure Set_QProbability(Param1: Double); safecall;
    procedure Set_ResultProbability(Param1: Double); safecall;
    property PursuerGuards: IDMCollection read Get_PursuerGuards;
    property BoundaryUnknowns: IDMCollection read Get_BoundaryUnknowns;
    property StartingGuards: IDMCollection read Get_StartingGuards;
    property BoundaryNoIntercepts: IDMCollection read Get_BoundaryNoIntercepts;
    property BoundaryCombatDefeats: IDMCollection read Get_BoundaryCombatDefeats;
    property InfoState: Integer write Set_InfoState;
    property SumW: Double write Set_SumW;
    property ProdNotU: Double write Set_ProdNotU;
    property BattleProbability: Double write Set_BattleProbability;
    property BattleTime: Double write Set_BattleTime;
    property QProbability: Double write Set_QProbability;
    property ResultProbability: Double write Set_ResultProbability;
  end;

// *********************************************************************//
// DispIntf:  IOvercomingBoundaryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BE6369C0-474A-4DE4-AB03-FCF443BF73E4}
// *********************************************************************//
  IOvercomingBoundaryDisp = dispinterface
    ['{BE6369C0-474A-4DE4-AB03-FCF443BF73E4}']
    property PursuerGuards: IDMCollection readonly dispid 1;
    property BoundaryUnknowns: IDMCollection readonly dispid 2;
    property StartingGuards: IDMCollection readonly dispid 3;
    property BoundaryNoIntercepts: IDMCollection readonly dispid 4;
    property BoundaryCombatDefeats: IDMCollection readonly dispid 5;
    property InfoState: Integer writeonly dispid 6;
    property SumW: Double writeonly dispid 7;
    property ProdNotU: Double writeonly dispid 8;
    property BattleProbability: Double writeonly dispid 9;
    property BattleTime: Double writeonly dispid 10;
    property QProbability: Double writeonly dispid 11;
    property ResultProbability: Double writeonly dispid 12;
  end;

// *********************************************************************//
// Interface: IPathNode
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {346CD6A1-03DF-11DB-9247-000272C5192A}
// *********************************************************************//
  IPathNode = interface(IDispatch)
    ['{346CD6A1-03DF-11DB-9247-000272C5192A}']
    function Get_BestNextArc: IDMElement; safecall;
    procedure Set_BestNextArc(const Value: IDMElement); safecall;
    function Get_BestNextNode: IDMElement; safecall;
    procedure Set_BestNextNode(const Value: IDMElement); safecall;
    function Get_BestDistance: Double; safecall;
    procedure Set_BestDistance(Value: Double); safecall;
    property BestNextArc: IDMElement read Get_BestNextArc write Set_BestNextArc;
    property BestNextNode: IDMElement read Get_BestNextNode write Set_BestNextNode;
    property BestDistance: Double read Get_BestDistance write Set_BestDistance;
  end;

// *********************************************************************//
// DispIntf:  IPathNodeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {346CD6A1-03DF-11DB-9247-000272C5192A}
// *********************************************************************//
  IPathNodeDisp = dispinterface
    ['{346CD6A1-03DF-11DB-9247-000272C5192A}']
    property BestNextArc: IDMElement dispid 1;
    property BestNextNode: IDMElement dispid 2;
    property BestDistance: Double dispid 4;
  end;

// *********************************************************************//
// Interface: IGuardGroup2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DC5FC52B-1803-4DB9-BBC0-761CD4FF4F2C}
// *********************************************************************//
  IGuardGroup2 = interface(IDispatch)
    ['{DC5FC52B-1803-4DB9-BBC0-761CD4FF4F2C}']
    function Get_TimeLimit: Double; safecall;
    procedure Set_TimeLimit(Value: Double); safecall;
    function Get_LastNode: IDMElement; safecall;
    procedure Set_LastNode(const Value: IDMElement); safecall;
    property TimeLimit: Double read Get_TimeLimit write Set_TimeLimit;
    property LastNode: IDMElement read Get_LastNode write Set_LastNode;
  end;

// *********************************************************************//
// DispIntf:  IGuardGroup2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DC5FC52B-1803-4DB9-BBC0-761CD4FF4F2C}
// *********************************************************************//
  IGuardGroup2Disp = dispinterface
    ['{DC5FC52B-1803-4DB9-BBC0-761CD4FF4F2C}']
    property TimeLimit: Double dispid 1;
    property LastNode: IDMElement dispid 2;
  end;

// *********************************************************************//
// Interface: IGuardModel
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1594045B-A35E-4F57-8855-013041F9C07C}
// *********************************************************************//
  IGuardModel = interface(IDispatch)
    ['{1594045B-A35E-4F57-8855-013041F9C07C}']
    function Get_GuardArrivals: IDMCollection; safecall;
    function Get_AlarmGroups: IDMCollection; safecall;
    function Get_AdversaryPotentialSum: Double; safecall;
    procedure Set_AdversaryPotentialSum(Value: Double); safecall;
    procedure CalcResponceTime(VGroupTimeFromStart: Double; VGroupTimeToTarget: Double; 
                               VGroupTimeToTargetDispersion: Double; const VGroupE: IDMElement; 
                               GoalDefindingBoundary: WordBool; out theGroupTimeToTarget: Double; 
                               out theGroupTimeToTargetDisp: Double; out theGroupE: IDMElement); safecall;
    property GuardArrivals: IDMCollection read Get_GuardArrivals;
    property AlarmGroups: IDMCollection read Get_AlarmGroups;
    property AdversaryPotentialSum: Double read Get_AdversaryPotentialSum write Set_AdversaryPotentialSum;
  end;

// *********************************************************************//
// DispIntf:  IGuardModelDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1594045B-A35E-4F57-8855-013041F9C07C}
// *********************************************************************//
  IGuardModelDisp = dispinterface
    ['{1594045B-A35E-4F57-8855-013041F9C07C}']
    property GuardArrivals: IDMCollection readonly dispid 1;
    property AlarmGroups: IDMCollection readonly dispid 2;
    property AdversaryPotentialSum: Double dispid 4;
    procedure CalcResponceTime(VGroupTimeFromStart: Double; VGroupTimeToTarget: Double; 
                               VGroupTimeToTargetDispersion: Double; const VGroupE: IDMElement; 
                               GoalDefindingBoundary: WordBool; out theGroupTimeToTarget: Double; 
                               out theGroupTimeToTargetDisp: Double; out theGroupE: IDMElement); dispid 5;
  end;

// *********************************************************************//
// Interface: IZone3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7BFC0CB6-138E-43BF-BCC2-FF8126AD4360}
// *********************************************************************//
  IZone3 = interface(IDispatch)
    ['{7BFC0CB6-138E-43BF-BCC2-FF8126AD4360}']
    function Get_Length: Double; safecall;
    procedure Set_Length(Value: Double); safecall;
    property Length: Double read Get_Length write Set_Length;
  end;

// *********************************************************************//
// DispIntf:  IZone3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7BFC0CB6-138E-43BF-BCC2-FF8126AD4360}
// *********************************************************************//
  IZone3Disp = dispinterface
    ['{7BFC0CB6-138E-43BF-BCC2-FF8126AD4360}']
    property Length: Double dispid 1;
  end;

// *********************************************************************//
// Interface: IRefPathElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FD8AC823-932A-41B8-8EC5-4A162FE8989B}
// *********************************************************************//
  IRefPathElement = interface(IDispatch)
    ['{FD8AC823-932A-41B8-8EC5-4A162FE8989B}']
    function Get_N: Integer; safecall;
    procedure Set_N(Value: Integer); safecall;
    function Get_X0: Double; safecall;
    procedure Set_X0(Value: Double); safecall;
    function Get_Y0: Double; safecall;
    procedure Set_Y0(Value: Double); safecall;
    function Get_Z0: Double; safecall;
    procedure Set_Z0(Value: Double); safecall;
    function Get_X1: Double; safecall;
    procedure Set_X1(Value: Double); safecall;
    function Get_Y1: Double; safecall;
    procedure Set_Y1(Value: Double); safecall;
    function Get_Z1: Double; safecall;
    procedure Set_Z1(Value: Double); safecall;
    function Get_PathArcKind: Integer; safecall;
    procedure Set_PathArcKind(Value: Integer); safecall;
    function Get_PathStage: Integer; safecall;
    procedure Set_PathStage(Value: Integer); safecall;
    function Get_GuardArrivals: IDMCollection; safecall;
    function Get_Direction: Integer; safecall;
    procedure Set_Direction(Value: Integer); safecall;
    function Get_Ref0: IDMElement; safecall;
    procedure Set_Ref0(const Value: IDMElement); safecall;
    function Get_Ref1: IDMElement; safecall;
    procedure Set_Ref1(const Value: IDMElement); safecall;
    property N: Integer read Get_N write Set_N;
    property X0: Double read Get_X0 write Set_X0;
    property Y0: Double read Get_Y0 write Set_Y0;
    property Z0: Double read Get_Z0 write Set_Z0;
    property X1: Double read Get_X1 write Set_X1;
    property Y1: Double read Get_Y1 write Set_Y1;
    property Z1: Double read Get_Z1 write Set_Z1;
    property PathArcKind: Integer read Get_PathArcKind write Set_PathArcKind;
    property PathStage: Integer read Get_PathStage write Set_PathStage;
    property GuardArrivals: IDMCollection read Get_GuardArrivals;
    property Direction: Integer read Get_Direction write Set_Direction;
    property Ref0: IDMElement read Get_Ref0 write Set_Ref0;
    property Ref1: IDMElement read Get_Ref1 write Set_Ref1;
  end;

// *********************************************************************//
// DispIntf:  IRefPathElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FD8AC823-932A-41B8-8EC5-4A162FE8989B}
// *********************************************************************//
  IRefPathElementDisp = dispinterface
    ['{FD8AC823-932A-41B8-8EC5-4A162FE8989B}']
    property N: Integer dispid 1;
    property X0: Double dispid 2;
    property Y0: Double dispid 3;
    property Z0: Double dispid 4;
    property X1: Double dispid 5;
    property Y1: Double dispid 6;
    property Z1: Double dispid 7;
    property PathArcKind: Integer dispid 8;
    property PathStage: Integer dispid 9;
    property GuardArrivals: IDMCollection readonly dispid 10;
    property Direction: Integer dispid 11;
    property Ref0: IDMElement dispid 12;
    property Ref1: IDMElement dispid 13;
  end;

// *********************************************************************//
// Interface: IGoods
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {65A351D1-A3F8-4028-9C08-ADCC766F8430}
// *********************************************************************//
  IGoods = interface(IDispatch)
    ['{65A351D1-A3F8-4028-9C08-ADCC766F8430}']
    function Get_DeviceCount: Integer; safecall;
    procedure Set_DeviceCount(Value: Integer); safecall;
    function Get_InstallCoeff: Double; safecall;
    property DeviceCount: Integer read Get_DeviceCount write Set_DeviceCount;
    property InstallCoeff: Double read Get_InstallCoeff;
  end;

// *********************************************************************//
// DispIntf:  IGoodsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {65A351D1-A3F8-4028-9C08-ADCC766F8430}
// *********************************************************************//
  IGoodsDisp = dispinterface
    ['{65A351D1-A3F8-4028-9C08-ADCC766F8430}']
    property DeviceCount: Integer dispid 1;
    property InstallCoeff: Double readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IObserver
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BDBAD5B6-F09D-4CD1-B8F9-E3FBE1048370}
// *********************************************************************//
  IObserver = interface(IDispatch)
    ['{BDBAD5B6-F09D-4CD1-B8F9-E3FBE1048370}']
    function Get_ObservationKind: Integer; safecall;
    procedure Set_ObservationKind(Value: Integer); safecall;
    function Get_Distance: Double; safecall;
    procedure Set_Distance(Value: Double); safecall;
    function Get_Side: Integer; safecall;
    procedure Set_Side(Value: Integer); safecall;
    function Get_ObservationPeriod: Double; safecall;
    procedure Set_ObservationPeriod(Value: Double); safecall;
    property ObservationKind: Integer read Get_ObservationKind write Set_ObservationKind;
    property Distance: Double read Get_Distance write Set_Distance;
    property Side: Integer read Get_Side write Set_Side;
    property ObservationPeriod: Double read Get_ObservationPeriod write Set_ObservationPeriod;
  end;

// *********************************************************************//
// DispIntf:  IObserverDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BDBAD5B6-F09D-4CD1-B8F9-E3FBE1048370}
// *********************************************************************//
  IObserverDisp = dispinterface
    ['{BDBAD5B6-F09D-4CD1-B8F9-E3FBE1048370}']
    property ObservationKind: Integer dispid 1;
    property Distance: Double dispid 2;
    property Side: Integer dispid 3;
    property ObservationPeriod: Double dispid 4;
  end;

// *********************************************************************//
// Interface: IGuardGroupState
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2DA51BF1-804F-4A64-A1F8-AB73A99E07D3}
// *********************************************************************//
  IGuardGroupState = interface(IDispatch)
    ['{2DA51BF1-804F-4A64-A1F8-AB73A99E07D3}']
    function Get_UserDefinedArrivalTime: WordBool; safecall;
    function Get_ArrivalTime: Double; safecall;
    function Get_UserDefinedBattleResult: WordBool; safecall;
    function Get_DefenceBattleP: Double; safecall;
    function Get_AttackBattleP: Double; safecall;
    function Get_DefenceBattleT: Double; safecall;
    function Get_AttackBattleT: Double; safecall;
    property UserDefinedArrivalTime: WordBool read Get_UserDefinedArrivalTime;
    property ArrivalTime: Double read Get_ArrivalTime;
    property UserDefinedBattleResult: WordBool read Get_UserDefinedBattleResult;
    property DefenceBattleP: Double read Get_DefenceBattleP;
    property AttackBattleP: Double read Get_AttackBattleP;
    property DefenceBattleT: Double read Get_DefenceBattleT;
    property AttackBattleT: Double read Get_AttackBattleT;
  end;

// *********************************************************************//
// DispIntf:  IGuardGroupStateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2DA51BF1-804F-4A64-A1F8-AB73A99E07D3}
// *********************************************************************//
  IGuardGroupStateDisp = dispinterface
    ['{2DA51BF1-804F-4A64-A1F8-AB73A99E07D3}']
    property UserDefinedArrivalTime: WordBool readonly dispid 1;
    property ArrivalTime: Double readonly dispid 2;
    property UserDefinedBattleResult: WordBool readonly dispid 3;
    property DefenceBattleP: Double readonly dispid 4;
    property AttackBattleP: Double readonly dispid 5;
    property DefenceBattleT: Double readonly dispid 6;
    property AttackBattleT: Double readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IObservationElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA4E27C8-3C94-4A0A-84E6-B6D7AF8DB9E6}
// *********************************************************************//
  IObservationElement = interface(IDispatch)
    ['{DA4E27C8-3C94-4A0A-84E6-B6D7AF8DB9E6}']
    function GetObservationPeriod(Distance: Double): Double; safecall;
  end;

// *********************************************************************//
// DispIntf:  IObservationElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA4E27C8-3C94-4A0A-84E6-B6D7AF8DB9E6}
// *********************************************************************//
  IObservationElementDisp = dispinterface
    ['{DA4E27C8-3C94-4A0A-84E6-B6D7AF8DB9E6}']
    function GetObservationPeriod(Distance: Double): Double; dispid 1;
  end;

// *********************************************************************//
// The Class CoFacilityModel provides a Create and CreateRemote method to          
// create instances of the default interface IFacilityModel exposed by              
// the CoClass FacilityModel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFacilityModel = class
    class function Create: IFacilityModel;
    class function CreateRemote(const MachineName: string): IFacilityModel;
  end;

implementation

uses ComObj;

class function CoFacilityModel.Create: IFacilityModel;
begin
  Result := CreateComObject(CLASS_FacilityModel) as IFacilityModel;
end;

class function CoFacilityModel.CreateRemote(const MachineName: string): IFacilityModel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FacilityModel) as IFacilityModel;
end;

end.
