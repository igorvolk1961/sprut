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

// PASTLWTR : $Revision:   1.130  $
// File generated on 23.01.02 12:25:00 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\GOL\Spruter3\SGDB\SgdbLib.tlb (1)
// LIBID: {24BBEAC0-5E99-11D5-845E-F63997C64D0C}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses ActiveX, Classes, Graphics, OleServer, StdVCL, Variants, Windows;
  


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

  IID_Sgdb: TGUID = '{24BBEAC1-5E99-11D5-845E-F63997C64D0C}';
  IID_ISafeguardDatabase: TGUID = '{1723ECA2-5ECB-11D5-845E-8BDDD017430C}';
  CLASS_SafeguardDatabase: TGUID = '{1723ECA4-5ECB-11D5-845E-8BDDD017430C}';
  IID_IFacilityZoneType: TGUID = '{1723ECA6-5ECB-11D5-845E-8BDDD017430C}';
  IID_IFacilityZoneKind: TGUID = '{1723ECA8-5ECB-11D5-845E-8BDDD017430C}';
  IID_IZoneBoundaryType: TGUID = '{1723ECAA-5ECB-11D5-845E-8BDDD017430C}';
  IID_IZoneBoundaryKind: TGUID = '{1723ECAC-5ECB-11D5-845E-8BDDD017430C}';
  IID_IDefenceLayerType: TGUID = '{1723ECAE-5ECB-11D5-845E-8BDDD017430C}';
  IID_IDefenceElementType: TGUID = '{1723ECB0-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBarrierType: TGUID = '{1723ECB2-5ECB-11D5-845E-8BDDD017430C}';
  IID_IBarrierKind: TGUID = '{1723ECB4-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILockType: TGUID = '{1723ECB6-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILockKind: TGUID = '{1723ECB8-5ECB-11D5-845E-8BDDD017430C}';
  IID_IObstacleType: TGUID = '{1723ECBA-5ECB-11D5-845E-8BDDD017430C}';
  IID_IObstacleKind: TGUID = '{1723ECBC-5ECB-11D5-845E-8BDDD017430C}';
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
  IID_IControlDeviceType: TGUID = '{1723ECDE-5ECB-11D5-845E-8BDDD017430C}';
  IID_IControlDeviceKind: TGUID = '{1723ECE0-5ECB-11D5-845E-8BDDD017430C}';
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
  IID_ILocalLineObjectType: TGUID = '{1723ED02-5ECB-11D5-845E-8BDDD017430C}';
  IID_ILocalLineObjectKind: TGUID = '{1723ED04-5ECB-11D5-845E-8BDDD017430C}';
  IID_IStrategyType: TGUID = '{1723ED06-5ECB-11D5-845E-8BDDD017430C}';
  IID_IGuardCharacteristicType: TGUID = '{1723ED08-5ECB-11D5-845E-8BDDD017430C}';
  IID_IGuardCharacteristicKind: TGUID = '{1723ED0A-5ECB-11D5-845E-8BDDD017430C}';
  IID_IOvercomeMethod: TGUID = '{1723ED0C-5ECB-11D5-845E-8BDDD017430C}';
  IID_IWeaponType: TGUID = '{1723ED0E-5ECB-11D5-845E-8BDDD017430C}';
  IID_IWeaponKind: TGUID = '{1723ED10-5ECB-11D5-845E-8BDDD017430C}';
  IID_IToolType: TGUID = '{1723ED12-5ECB-11D5-845E-8BDDD017430C}';
  IID_IToolKind: TGUID = '{1723ED14-5ECB-11D5-845E-8BDDD017430C}';
  IID_IVehicleType: TGUID = '{1723ED16-5ECB-11D5-845E-8BDDD017430C}';
  IID_IVehicleKind: TGUID = '{1723ED18-5ECB-11D5-845E-8BDDD017430C}';
  IID_IAthorityType: TGUID = '{1723ED1A-5ECB-11D5-845E-8BDDD017430C}';
  IID_IAthorityKind: TGUID = '{1723ED1C-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISkillType: TGUID = '{1723ED1E-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISkillKind: TGUID = '{1723ED20-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPhysicalField: TGUID = '{1723ED22-5ECB-11D5-845E-8BDDD017430C}';
  IID_IDeviceFunction: TGUID = '{1723ED24-5ECB-11D5-845E-8BDDD017430C}';
  IID_IDeviceState: TGUID = '{1723ED26-5ECB-11D5-845E-8BDDD017430C}';
  IID_IHindrance: TGUID = '{1723ED28-5ECB-11D5-845E-8BDDD017430C}';
  IID_IWeather: TGUID = '{1723ED2A-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISGDBParameter: TGUID = '{1723ED2C-5ECB-11D5-845E-8BDDD017430C}';
  IID_ISGDBParameterValue: TGUID = '{1723ED2E-5ECB-11D5-845E-8BDDD017430C}';
  IID_IShotDispersionRec: TGUID = '{1723ED30-5ECB-11D5-845E-8BDDD017430C}';
  IID_IStrategyKind: TGUID = '{1723ED32-5ECB-11D5-845E-8BDDD017430C}';
  IID_IElementImage: TGUID = '{1723ED34-5ECB-11D5-845E-8BDDD017430C}';
  IID_IStartPointType: TGUID = '{1723ED38-5ECB-11D5-845E-8BDDD017430C}';
  IID_IStartPointKind: TGUID = '{1723ED3A-5ECB-11D5-845E-8BDDD017430C}';
  IID_IActiveSafeguardType: TGUID = '{1723ED3C-5ECB-11D5-845E-8BDDD017430C}';
  IID_IActiveSafeguardKind: TGUID = '{1723ED3E-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPerimeterSensorType: TGUID = '{1723ED40-5ECB-11D5-845E-8BDDD017430C}';
  IID_IPerimeterSensorKind: TGUID = '{1723ED42-5ECB-11D5-845E-8BDDD017430C}';
  IID_IDataClassModel: TGUID = '{4F005860-5F76-11D5-845E-FEE1D8DC510C}';
  IID_ISafeguardClass: TGUID = '{4F005862-5F76-11D5-845E-FEE1D8DC510C}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum SgdbClassID
type
  SgdbClassID = TOleEnum;
const
  _FacilityZoneType = $00000000;
  _FacilityZoneKind = $00000001;
  _ZoneBoundaryType = $00000002;
  _ZoneBoundaryKind = $00000003;
  _DefenceLayerType = $00000004;
  _DefenceElementType = $00000005;
  _BarrierType = $00000006;
  _BarrierKind = $00000007;
  _Reserver1 = $00000008;
  _Reserver2 = $00000009;
  _LockType = $0000000A;
  _LockKind = $0000000B;
  _ObstacleType = $0000000C;
  _ObstacleKind = $0000000D;
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
  _ControlDeviceType = $0000001E;
  _ControlDeviceKind = $0000001F;
  _PowerSourceType = $00000020;
  _PowerSourceKind = $00000021;
  _CabelType = $00000022;
  _CabelKind = $00000023;
  _Reserverd3 = $00000024;
  _Reserverd4 = $00000025;
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
  _LocalLineObjectType = $00000032;
  _LocalLineObjectKind = $00000033;
  _StrategyType = $00000034;
  _GuardCharacteristicType = $00000035;
  _GuardCharacteristicKind = $00000036;
  _OvercomeMethod = $00000037;
  _WeaponType = $00000038;
  _WeaponKind = $00000039;
  _ToolType = $0000003A;
  _ToolKind = $0000003B;
  _VehicleType = $0000003C;
  _VehicleKind = $0000003D;
  _AthorityType = $0000003E;
  _AthorityKind = $0000003F;
  _SkillType = $00000040;
  _SkillKind = $00000041;
  _Reserved5 = $00000042;
  _Reserved6 = $00000043;
  _PhysicalField = $00000044;
  _DeviceFunction = $00000045;
  _DeviceState = $00000046;
  _Hindrance = $00000047;
  _Weather = $00000048;
  _SGDBParameter = $00000049;
  _SGDBParameterValue = $0000004A;
  _Reserved7 = $0000004B;
  _Reserved8 = $0000004C;
  _Reserved9 = $0000004D;
  _Reserved10 = $0000004E;
  _Reserved11 = $0000004F;
  _Reserved12 = $00000050;
  _Reserved13 = $00000051;
  _Reserved14 = $00000052;
  _Reserved15 = $00000053;
  _ShotDispersionRec = $00000054;
  _StrategyKind = $00000055;
  _Reserver16 = $00000056;
  _Reserver17 = $00000057;
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

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  Sgdb = interface;
  SgdbDisp = dispinterface;
  ISafeguardDatabase = interface;
  ISafeguardDatabaseDisp = dispinterface;
  IFacilityZoneType = interface;
  IFacilityZoneTypeDisp = dispinterface;
  IFacilityZoneKind = interface;
  IFacilityZoneKindDisp = dispinterface;
  IZoneBoundaryType = interface;
  IZoneBoundaryTypeDisp = dispinterface;
  IZoneBoundaryKind = interface;
  IZoneBoundaryKindDisp = dispinterface;
  IDefenceLayerType = interface;
  IDefenceLayerTypeDisp = dispinterface;
  IDefenceElementType = interface;
  IDefenceElementTypeDisp = dispinterface;
  IBarrierType = interface;
  IBarrierTypeDisp = dispinterface;
  IBarrierKind = interface;
  IBarrierKindDisp = dispinterface;
  ILockType = interface;
  ILockTypeDisp = dispinterface;
  ILockKind = interface;
  ILockKindDisp = dispinterface;
  IObstacleType = interface;
  IObstacleTypeDisp = dispinterface;
  IObstacleKind = interface;
  IObstacleKindDisp = dispinterface;
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
  IControlDeviceType = interface;
  IControlDeviceTypeDisp = dispinterface;
  IControlDeviceKind = interface;
  IControlDeviceKindDisp = dispinterface;
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
  ILocalLineObjectType = interface;
  ILocalLineObjectTypeDisp = dispinterface;
  ILocalLineObjectKind = interface;
  ILocalLineObjectKindDisp = dispinterface;
  IStrategyType = interface;
  IStrategyTypeDisp = dispinterface;
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
  IAthorityKind = interface;
  IAthorityKindDisp = dispinterface;
  ISkillType = interface;
  ISkillTypeDisp = dispinterface;
  ISkillKind = interface;
  ISkillKindDisp = dispinterface;
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
  IStrategyKind = interface;
  IStrategyKindDisp = dispinterface;
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

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SafeguardDatabase = ISafeguardDatabase;


// *********************************************************************//
// Interface: Sgdb
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {24BBEAC1-5E99-11D5-845E-F63997C64D0C}
// *********************************************************************//
  Sgdb = interface(IDispatch)
    ['{24BBEAC1-5E99-11D5-845E-F63997C64D0C}']
  end;

// *********************************************************************//
// DispIntf:  SgdbDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {24BBEAC1-5E99-11D5-845E-F63997C64D0C}
// *********************************************************************//
  SgdbDisp = dispinterface
    ['{24BBEAC1-5E99-11D5-845E-F63997C64D0C}']
  end;

// *********************************************************************//
// Interface: ISafeguardDatabase
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECA2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISafeguardDatabase = interface(IDispatch)
    ['{1723ECA2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISafeguardDatabaseDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECA2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISafeguardDatabaseDisp = dispinterface
    ['{1723ECA2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IFacilityZoneType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECA6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IFacilityZoneType = interface(IDispatch)
    ['{1723ECA6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IFacilityZoneTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECA6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IFacilityZoneTypeDisp = dispinterface
    ['{1723ECA6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IFacilityZoneKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECA8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IFacilityZoneKind = interface(IDispatch)
    ['{1723ECA8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IFacilityZoneKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECA8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IFacilityZoneKindDisp = dispinterface
    ['{1723ECA8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IZoneBoundaryType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECAA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IZoneBoundaryType = interface(IDispatch)
    ['{1723ECAA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IZoneBoundaryTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECAA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IZoneBoundaryTypeDisp = dispinterface
    ['{1723ECAA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IZoneBoundaryKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECAC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IZoneBoundaryKind = interface(IDispatch)
    ['{1723ECAC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IZoneBoundaryKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECAC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IZoneBoundaryKindDisp = dispinterface
    ['{1723ECAC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IDefenceLayerType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECAE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDefenceLayerType = interface(IDispatch)
    ['{1723ECAE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IDefenceLayerTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECAE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDefenceLayerTypeDisp = dispinterface
    ['{1723ECAE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IDefenceElementType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDefenceElementType = interface(IDispatch)
    ['{1723ECB0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IDefenceElementTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDefenceElementTypeDisp = dispinterface
    ['{1723ECB0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IBarrierType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierType = interface(IDispatch)
    ['{1723ECB2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierTypeDisp = dispinterface
    ['{1723ECB2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IBarrierKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierKind = interface(IDispatch)
    ['{1723ECB4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierKindDisp = dispinterface
    ['{1723ECB4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILockType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILockType = interface(IDispatch)
    ['{1723ECB6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILockTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILockTypeDisp = dispinterface
    ['{1723ECB6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILockKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILockKind = interface(IDispatch)
    ['{1723ECB8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILockKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECB8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILockKindDisp = dispinterface
    ['{1723ECB8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IObstacleType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECBA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IObstacleType = interface(IDispatch)
    ['{1723ECBA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IObstacleTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECBA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IObstacleTypeDisp = dispinterface
    ['{1723ECBA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IObstacleKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECBC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IObstacleKind = interface(IDispatch)
    ['{1723ECBC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IObstacleKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECBC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IObstacleKindDisp = dispinterface
    ['{1723ECBC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISurfaceSensorType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECBE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISurfaceSensorType = interface(IDispatch)
    ['{1723ECBE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISurfaceSensorTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECBE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISurfaceSensorTypeDisp = dispinterface
    ['{1723ECBE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISurfaceSensorKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISurfaceSensorKind = interface(IDispatch)
    ['{1723ECC0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISurfaceSensorKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISurfaceSensorKindDisp = dispinterface
    ['{1723ECC0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPositionSensorType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPositionSensorType = interface(IDispatch)
    ['{1723ECC2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPositionSensorTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPositionSensorTypeDisp = dispinterface
    ['{1723ECC2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPositionSensorKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPositionSensorKind = interface(IDispatch)
    ['{1723ECC4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPositionSensorKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPositionSensorKindDisp = dispinterface
    ['{1723ECC4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IVolumeSensorType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVolumeSensorType = interface(IDispatch)
    ['{1723ECC6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IVolumeSensorTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVolumeSensorTypeDisp = dispinterface
    ['{1723ECC6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IVolumeSensorKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVolumeSensorKind = interface(IDispatch)
    ['{1723ECC8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IVolumeSensorKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECC8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVolumeSensorKindDisp = dispinterface
    ['{1723ECC8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IBarrierSensorType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECCA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierSensorType = interface(IDispatch)
    ['{1723ECCA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierSensorTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECCA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierSensorTypeDisp = dispinterface
    ['{1723ECCA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IBarrierSensorKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECCC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierSensorKind = interface(IDispatch)
    ['{1723ECCC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IBarrierSensorKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECCC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IBarrierSensorKindDisp = dispinterface
    ['{1723ECCC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IContrabandSensorType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECCE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IContrabandSensorType = interface(IDispatch)
    ['{1723ECCE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IContrabandSensorTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECCE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IContrabandSensorTypeDisp = dispinterface
    ['{1723ECCE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IContrabandSensorKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IContrabandSensorKind = interface(IDispatch)
    ['{1723ECD0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IContrabandSensorKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IContrabandSensorKindDisp = dispinterface
    ['{1723ECD0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IAccessControlType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAccessControlType = interface(IDispatch)
    ['{1723ECD2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IAccessControlTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAccessControlTypeDisp = dispinterface
    ['{1723ECD2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IAccessControlKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAccessControlKind = interface(IDispatch)
    ['{1723ECD4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IAccessControlKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAccessControlKindDisp = dispinterface
    ['{1723ECD4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ITVCameraType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITVCameraType = interface(IDispatch)
    ['{1723ECD6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ITVCameraTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITVCameraTypeDisp = dispinterface
    ['{1723ECD6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ITVCameraKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITVCameraKind = interface(IDispatch)
    ['{1723ECD8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ITVCameraKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECD8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITVCameraKindDisp = dispinterface
    ['{1723ECD8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILightDeviceType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECDA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILightDeviceType = interface(IDispatch)
    ['{1723ECDA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILightDeviceTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECDA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILightDeviceTypeDisp = dispinterface
    ['{1723ECDA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILightDeviceKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECDC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILightDeviceKind = interface(IDispatch)
    ['{1723ECDC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILightDeviceKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECDC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILightDeviceKindDisp = dispinterface
    ['{1723ECDC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IControlDeviceType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECDE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IControlDeviceType = interface(IDispatch)
    ['{1723ECDE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IControlDeviceTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECDE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IControlDeviceTypeDisp = dispinterface
    ['{1723ECDE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IControlDeviceKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IControlDeviceKind = interface(IDispatch)
    ['{1723ECE0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IControlDeviceKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IControlDeviceKindDisp = dispinterface
    ['{1723ECE0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPowerSourceType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPowerSourceType = interface(IDispatch)
    ['{1723ECE2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPowerSourceTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPowerSourceTypeDisp = dispinterface
    ['{1723ECE2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPowerSourceKInd
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPowerSourceKInd = interface(IDispatch)
    ['{1723ECE4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPowerSourceKIndDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPowerSourceKIndDisp = dispinterface
    ['{1723ECE4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ICabelType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICabelType = interface(IDispatch)
    ['{1723ECE6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ICabelTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICabelTypeDisp = dispinterface
    ['{1723ECE6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ICabelKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICabelKind = interface(IDispatch)
    ['{1723ECE8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ICabelKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECE8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ICabelKindDisp = dispinterface
    ['{1723ECE8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPatrolType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECEA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPatrolType = interface(IDispatch)
    ['{1723ECEA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPatrolTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECEA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPatrolTypeDisp = dispinterface
    ['{1723ECEA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPatrolKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECEC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPatrolKind = interface(IDispatch)
    ['{1723ECEC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPatrolKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECEC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPatrolKindDisp = dispinterface
    ['{1723ECEC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IGuardPostType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECEE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardPostType = interface(IDispatch)
    ['{1723ECEE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IGuardPostTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECEE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardPostTypeDisp = dispinterface
    ['{1723ECEE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IGuardPostKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardPostKind = interface(IDispatch)
    ['{1723ECF0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IGuardPostKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF0-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardPostKindDisp = dispinterface
    ['{1723ECF0-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ITargetType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITargetType = interface(IDispatch)
    ['{1723ECF2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ITargetTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF2-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITargetTypeDisp = dispinterface
    ['{1723ECF2-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ITargetKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITargetKind = interface(IDispatch)
    ['{1723ECF4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ITargetKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF4-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ITargetKindDisp = dispinterface
    ['{1723ECF4-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IConveyanceType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceType = interface(IDispatch)
    ['{1723ECF6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IConveyanceTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF6-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceTypeDisp = dispinterface
    ['{1723ECF6-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IConveyanceKInd
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceKInd = interface(IDispatch)
    ['{1723ECF8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IConveyanceKIndDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECF8-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceKIndDisp = dispinterface
    ['{1723ECF8-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IConveyanceSegmentType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECFA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceSegmentType = interface(IDispatch)
    ['{1723ECFA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IConveyanceSegmentTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECFA-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceSegmentTypeDisp = dispinterface
    ['{1723ECFA-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IConveyanceSegmentKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECFC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceSegmentKind = interface(IDispatch)
    ['{1723ECFC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IConveyanceSegmentKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECFC-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IConveyanceSegmentKindDisp = dispinterface
    ['{1723ECFC-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILocalPointObjectType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECFE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalPointObjectType = interface(IDispatch)
    ['{1723ECFE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILocalPointObjectTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ECFE-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalPointObjectTypeDisp = dispinterface
    ['{1723ECFE-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILocalPointObjectKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED00-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalPointObjectKind = interface(IDispatch)
    ['{1723ED00-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILocalPointObjectKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED00-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalPointObjectKindDisp = dispinterface
    ['{1723ED00-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILocalLineObjectType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED02-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalLineObjectType = interface(IDispatch)
    ['{1723ED02-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILocalLineObjectTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED02-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalLineObjectTypeDisp = dispinterface
    ['{1723ED02-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ILocalLineObjectKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED04-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalLineObjectKind = interface(IDispatch)
    ['{1723ED04-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ILocalLineObjectKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED04-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ILocalLineObjectKindDisp = dispinterface
    ['{1723ED04-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IStrategyType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED06-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStrategyType = interface(IDispatch)
    ['{1723ED06-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IStrategyTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED06-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStrategyTypeDisp = dispinterface
    ['{1723ED06-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IGuardCharacteristicType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED08-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardCharacteristicType = interface(IDispatch)
    ['{1723ED08-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IGuardCharacteristicTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED08-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardCharacteristicTypeDisp = dispinterface
    ['{1723ED08-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IGuardCharacteristicKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED0A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardCharacteristicKind = interface(IDispatch)
    ['{1723ED0A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IGuardCharacteristicKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED0A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IGuardCharacteristicKindDisp = dispinterface
    ['{1723ED0A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IOvercomeMethod
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED0C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IOvercomeMethod = interface(IDispatch)
    ['{1723ED0C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IOvercomeMethodDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED0C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IOvercomeMethodDisp = dispinterface
    ['{1723ED0C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IWeaponType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED0E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeaponType = interface(IDispatch)
    ['{1723ED0E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IWeaponTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED0E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeaponTypeDisp = dispinterface
    ['{1723ED0E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IWeaponKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED10-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeaponKind = interface(IDispatch)
    ['{1723ED10-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IWeaponKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED10-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeaponKindDisp = dispinterface
    ['{1723ED10-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IToolType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED12-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IToolType = interface(IDispatch)
    ['{1723ED12-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IToolTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED12-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IToolTypeDisp = dispinterface
    ['{1723ED12-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IToolKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED14-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IToolKind = interface(IDispatch)
    ['{1723ED14-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IToolKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED14-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IToolKindDisp = dispinterface
    ['{1723ED14-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IVehicleType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED16-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVehicleType = interface(IDispatch)
    ['{1723ED16-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IVehicleTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED16-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVehicleTypeDisp = dispinterface
    ['{1723ED16-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IVehicleKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED18-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVehicleKind = interface(IDispatch)
    ['{1723ED18-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IVehicleKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED18-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IVehicleKindDisp = dispinterface
    ['{1723ED18-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IAthorityType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED1A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAthorityType = interface(IDispatch)
    ['{1723ED1A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IAthorityTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED1A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAthorityTypeDisp = dispinterface
    ['{1723ED1A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IAthorityKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED1C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAthorityKind = interface(IDispatch)
    ['{1723ED1C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IAthorityKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED1C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IAthorityKindDisp = dispinterface
    ['{1723ED1C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISkillType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED1E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISkillType = interface(IDispatch)
    ['{1723ED1E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISkillTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED1E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISkillTypeDisp = dispinterface
    ['{1723ED1E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISkillKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED20-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISkillKind = interface(IDispatch)
    ['{1723ED20-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISkillKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED20-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISkillKindDisp = dispinterface
    ['{1723ED20-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPhysicalField
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED22-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPhysicalField = interface(IDispatch)
    ['{1723ED22-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPhysicalFieldDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED22-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPhysicalFieldDisp = dispinterface
    ['{1723ED22-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IDeviceFunction
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED24-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDeviceFunction = interface(IDispatch)
    ['{1723ED24-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IDeviceFunctionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED24-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDeviceFunctionDisp = dispinterface
    ['{1723ED24-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IDeviceState
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED26-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDeviceState = interface(IDispatch)
    ['{1723ED26-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IDeviceStateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED26-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IDeviceStateDisp = dispinterface
    ['{1723ED26-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IHindrance
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED28-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IHindrance = interface(IDispatch)
    ['{1723ED28-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IHindranceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED28-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IHindranceDisp = dispinterface
    ['{1723ED28-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IWeather
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED2A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeather = interface(IDispatch)
    ['{1723ED2A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IWeatherDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED2A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IWeatherDisp = dispinterface
    ['{1723ED2A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISGDBParameter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED2C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISGDBParameter = interface(IDispatch)
    ['{1723ED2C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISGDBParameterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED2C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISGDBParameterDisp = dispinterface
    ['{1723ED2C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: ISGDBParameterValue
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED2E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISGDBParameterValue = interface(IDispatch)
    ['{1723ED2E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  ISGDBParameterValueDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED2E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  ISGDBParameterValueDisp = dispinterface
    ['{1723ED2E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IShotDispersionRec
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED30-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IShotDispersionRec = interface(IDispatch)
    ['{1723ED30-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IShotDispersionRecDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED30-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IShotDispersionRecDisp = dispinterface
    ['{1723ED30-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IStrategyKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED32-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStrategyKind = interface(IDispatch)
    ['{1723ED32-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IStrategyKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED32-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStrategyKindDisp = dispinterface
    ['{1723ED32-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IElementImage
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED34-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IElementImage = interface(IDispatch)
    ['{1723ED34-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IElementImageDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED34-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IElementImageDisp = dispinterface
    ['{1723ED34-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IStartPointType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED38-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStartPointType = interface(IDispatch)
    ['{1723ED38-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IStartPointTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED38-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStartPointTypeDisp = dispinterface
    ['{1723ED38-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IStartPointKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED3A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStartPointKind = interface(IDispatch)
    ['{1723ED3A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IStartPointKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED3A-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IStartPointKindDisp = dispinterface
    ['{1723ED3A-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IActiveSafeguardType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED3C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IActiveSafeguardType = interface(IDispatch)
    ['{1723ED3C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IActiveSafeguardTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED3C-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IActiveSafeguardTypeDisp = dispinterface
    ['{1723ED3C-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IActiveSafeguardKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED3E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IActiveSafeguardKind = interface(IDispatch)
    ['{1723ED3E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IActiveSafeguardKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED3E-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IActiveSafeguardKindDisp = dispinterface
    ['{1723ED3E-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPerimeterSensorType
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED40-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPerimeterSensorType = interface(IDispatch)
    ['{1723ED40-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPerimeterSensorTypeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED40-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPerimeterSensorTypeDisp = dispinterface
    ['{1723ED40-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IPerimeterSensorKind
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED42-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPerimeterSensorKind = interface(IDispatch)
    ['{1723ED42-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// DispIntf:  IPerimeterSensorKindDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1723ED42-5ECB-11D5-845E-8BDDD017430C}
// *********************************************************************//
  IPerimeterSensorKindDisp = dispinterface
    ['{1723ED42-5ECB-11D5-845E-8BDDD017430C}']
  end;

// *********************************************************************//
// Interface: IDataClassModel
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4F005860-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IDataClassModel = interface(IDispatch)
    ['{4F005860-5F76-11D5-845E-FEE1D8DC510C}']
  end;

// *********************************************************************//
// DispIntf:  IDataClassModelDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4F005860-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  IDataClassModelDisp = dispinterface
    ['{4F005860-5F76-11D5-845E-FEE1D8DC510C}']
  end;

// *********************************************************************//
// Interface: ISafeguardClass
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4F005862-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  ISafeguardClass = interface(IDispatch)
    ['{4F005862-5F76-11D5-845E-FEE1D8DC510C}']
    function  Get_TypeClassID: Integer; safecall;
    procedure Set_TypeClassID(Value: Integer); safecall;
    property TypeClassID: Integer read Get_TypeClassID write Set_TypeClassID;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardClassDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4F005862-5F76-11D5-845E-FEE1D8DC510C}
// *********************************************************************//
  ISafeguardClassDisp = dispinterface
    ['{4F005862-5F76-11D5-845E-FEE1D8DC510C}']
    property TypeClassID: Integer dispid 1;
  end;

// *********************************************************************//
// The Class CoSafeguardDatabase provides a Create and CreateRemote method to          
// create instances of the default interface ISafeguardDatabase exposed by              
// the CoClass SafeguardDatabase. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSafeguardDatabase = class
    class function Create: ISafeguardDatabase;
    class function CreateRemote(const MachineName: string): ISafeguardDatabase;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSafeguardDatabase
// Help String      : SafeguardDatabase Object
// Default Interface: ISafeguardDatabase
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSafeguardDatabaseProperties= class;
{$ENDIF}
  TSafeguardDatabase = class(TOleServer)
  private
    FIntf:        ISafeguardDatabase;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSafeguardDatabaseProperties;
    function      GetServerProperties: TSafeguardDatabaseProperties;
{$ENDIF}
    function      GetDefaultInterface: ISafeguardDatabase;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISafeguardDatabase);
    procedure Disconnect; override;
    property  DefaultInterface: ISafeguardDatabase read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSafeguardDatabaseProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSafeguardDatabase
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSafeguardDatabaseProperties = class(TPersistent)
  private
    FServer:    TSafeguardDatabase;
    function    GetDefaultInterface: ISafeguardDatabase;
    constructor Create(AServer: TSafeguardDatabase);
  protected
  public
    property DefaultInterface: ISafeguardDatabase read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoSafeguardDatabase.Create: ISafeguardDatabase;
begin
  Result := CreateComObject(CLASS_SafeguardDatabase) as ISafeguardDatabase;
end;

class function CoSafeguardDatabase.CreateRemote(const MachineName: string): ISafeguardDatabase;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SafeguardDatabase) as ISafeguardDatabase;
end;

procedure TSafeguardDatabase.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{1723ECA4-5ECB-11D5-845E-8BDDD017430C}';
    IntfIID:   '{1723ECA2-5ECB-11D5-845E-8BDDD017430C}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSafeguardDatabase.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ISafeguardDatabase;
  end;
end;

procedure TSafeguardDatabase.ConnectTo(svrIntf: ISafeguardDatabase);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSafeguardDatabase.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSafeguardDatabase.GetDefaultInterface: ISafeguardDatabase;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSafeguardDatabase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSafeguardDatabaseProperties.Create(Self);
{$ENDIF}
end;

destructor TSafeguardDatabase.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSafeguardDatabase.GetServerProperties: TSafeguardDatabaseProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSafeguardDatabaseProperties.Create(AServer: TSafeguardDatabase);
begin
  inherited Create;
  FServer := AServer;
end;

function TSafeguardDatabaseProperties.GetDefaultInterface: ISafeguardDatabase;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TSafeguardDatabase]);
end;

end.
