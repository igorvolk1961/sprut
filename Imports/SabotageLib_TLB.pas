unit SabotageLib_TLB;

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

// PASTLWTR : 1.2
// File generated on 18.02.2007 1:29:32 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Vasilyev\Sabotage\bin\SabotageLib.dll (1)
// LIBID: {3AD8C0A8-AE78-428C-95DF-484FD6387F0F}
// LCID: 0
// Helpfile: 
// HelpString: SabotageU Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SabotageLibMajorVersion = 1;
  SabotageLibMinorVersion = 0;

  LIBID_SabotageLib: TGUID = '{3AD8C0A8-AE78-428C-95DF-484FD6387F0F}';

  IID_ISabotage: TGUID = '{017C1529-6331-4DF5-A0E0-05A45A954EE9}';
  IID_IBoundary: TGUID = '{94BEC085-1AE7-46D0-A6A6-6F79663AAB8F}';
  CLASS_Sabotage: TGUID = '{BFAB92EF-0D30-450D-9260-793CDF0F4550}';
  IID_ICalculateVariant: TGUID = '{42E84D22-36D3-41B8-90D6-4F616C269B07}';
  IID_IZoneInfluence: TGUID = '{0F858956-41B4-4421-8270-C9DF6C2BBEC1}';
  IID_IDirection: TGUID = '{9D3727FE-96AB-4321-A001-8701E43825CC}';
  IID_ISearchRegion: TGUID = '{643AAE8B-E9B4-410E-B317-236DFC5DDBD7}';
  IID_ITool: TGUID = '{5F378DD9-274C-4376-B0FB-07EBD886C55D}';
  IID_IWarriorGroup: TGUID = '{0E8EEB7B-C597-43BC-BAE0-63E751BBB490}';
  IID_IWeapon: TGUID = '{0C97BC4D-099E-40A7-8494-8DBA2F60208A}';
  IID_IBarrier: TGUID = '{BC431363-8B3D-422E-A720-FD6AF93D5E80}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TSabotageConst
type
  TSabotageConst = TOleEnum;
const
  _CalcVariant = $00000000;
  _Boundary = $00000001;
  _ZoneInfluence = $00000002;
  _Direction = $00000003;
  _SearchRegion = $00000004;
  _WarriorGroup = $00000005;
  _Tool = $00000006;
  _Weapon = $00000007;
  _Barrier = $00000008;
  _Attribute = $00000009;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISabotage = interface;
  ISabotageDisp = dispinterface;
  IBoundary = interface;
  IBoundaryDisp = dispinterface;
  ICalculateVariant = interface;
  ICalculateVariantDisp = dispinterface;
  IZoneInfluence = interface;
  IZoneInfluenceDisp = dispinterface;
  IDirection = interface;
  IDirectionDisp = dispinterface;
  ISearchRegion = interface;
  ISearchRegionDisp = dispinterface;
  ITool = interface;
  IToolDisp = dispinterface;
  IWarriorGroup = interface;
  IWarriorGroupDisp = dispinterface;
  IWeapon = interface;
  IWeaponDisp = dispinterface;
  IBarrier = interface;
  IBarrierDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Sabotage = ISabotage;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PDouble1 = ^Double; {*}


// *********************************************************************//
// Interface: ISabotage
// Flags:     (320) Dual OleAutomation
// GUID:      {017C1529-6331-4DF5-A0E0-05A45A954EE9}
// *********************************************************************//
  ISabotage = interface(IUnknown)
    ['{017C1529-6331-4DF5-A0E0-05A45A954EE9}']
    procedure Calc; safecall;
  end;

// *********************************************************************//
// DispIntf:  ISabotageDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {017C1529-6331-4DF5-A0E0-05A45A954EE9}
// *********************************************************************//
  ISabotageDisp = dispinterface
    ['{017C1529-6331-4DF5-A0E0-05A45A954EE9}']
    procedure Calc; dispid 1;
  end;

// *********************************************************************//
// Interface: IBoundary
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {94BEC085-1AE7-46D0-A6A6-6F79663AAB8F}
// *********************************************************************//
  IBoundary = interface(IDispatch)
    ['{94BEC085-1AE7-46D0-A6A6-6F79663AAB8F}']
    function Get_DelayTime: Double; safecall;
    function Get_DelayTimeDev: Double; safecall;
    function Get_DetectionPeriod: Double; safecall;
    function Get_DetectionProbability: Double; safecall;
    function Get_NoDetP: Double; safecall;
    procedure Set_NoDetP(Value: Double); safecall;
    function Get_OutstripP: Double; safecall;
    procedure Set_OutstripP(Value: Double); safecall;
    procedure CalcSuccessP(var SuccessP: Double; var DelayTimeSum: Double; 
                           var DelayTimeDispersionSum: Double; ReactionTime: Double; 
                           ReactionTimeDispersion: Double); safecall;
    function Get_DetectionPosition: Integer; safecall;
    function Get_Barriers: IUnknown; safecall;
    property DelayTime: Double read Get_DelayTime;
    property DelayTimeDev: Double read Get_DelayTimeDev;
    property DetectionPeriod: Double read Get_DetectionPeriod;
    property DetectionProbability: Double read Get_DetectionProbability;
    property NoDetP: Double read Get_NoDetP write Set_NoDetP;
    property OutstripP: Double read Get_OutstripP write Set_OutstripP;
    property DetectionPosition: Integer read Get_DetectionPosition;
    property Barriers: IUnknown read Get_Barriers;
  end;

// *********************************************************************//
// DispIntf:  IBoundaryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {94BEC085-1AE7-46D0-A6A6-6F79663AAB8F}
// *********************************************************************//
  IBoundaryDisp = dispinterface
    ['{94BEC085-1AE7-46D0-A6A6-6F79663AAB8F}']
    property DelayTime: Double readonly dispid 1;
    property DelayTimeDev: Double readonly dispid 2;
    property DetectionPeriod: Double readonly dispid 5;
    property DetectionProbability: Double readonly dispid 6;
    property NoDetP: Double dispid 7;
    property OutstripP: Double dispid 8;
    procedure CalcSuccessP(var SuccessP: Double; var DelayTimeSum: Double; 
                           var DelayTimeDispersionSum: Double; ReactionTime: Double; 
                           ReactionTimeDispersion: Double); dispid 11;
    property DetectionPosition: Integer readonly dispid 3;
    property Barriers: IUnknown readonly dispid 201;
  end;

// *********************************************************************//
// Interface: ICalculateVariant
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {42E84D22-36D3-41B8-90D6-4F616C269B07}
// *********************************************************************//
  ICalculateVariant = interface(IDispatch)
    ['{42E84D22-36D3-41B8-90D6-4F616C269B07}']
    function Get_ReactionTime: Double; safecall;
    function Get_ReactionTimeDev: Double; safecall;
    function Get_SuccessP: Double; safecall;
    procedure Set_SuccessP(Value: Double); safecall;
    function Get_Efficiency: Double; safecall;
    procedure Set_Efficiency(Value: Double); safecall;
    procedure Calc; safecall;
    function Get_Directions: IUnknown; safecall;
    property ReactionTime: Double read Get_ReactionTime;
    property ReactionTimeDev: Double read Get_ReactionTimeDev;
    property SuccessP: Double read Get_SuccessP write Set_SuccessP;
    property Efficiency: Double read Get_Efficiency write Set_Efficiency;
    property Directions: IUnknown read Get_Directions;
  end;

// *********************************************************************//
// DispIntf:  ICalculateVariantDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {42E84D22-36D3-41B8-90D6-4F616C269B07}
// *********************************************************************//
  ICalculateVariantDisp = dispinterface
    ['{42E84D22-36D3-41B8-90D6-4F616C269B07}']
    property ReactionTime: Double readonly dispid 1;
    property ReactionTimeDev: Double readonly dispid 2;
    property SuccessP: Double dispid 3;
    property Efficiency: Double dispid 4;
    procedure Calc; dispid 5;
    property Directions: IUnknown readonly dispid 6;
  end;

// *********************************************************************//
// Interface: IZoneInfluence
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0F858956-41B4-4421-8270-C9DF6C2BBEC1}
// *********************************************************************//
  IZoneInfluence = interface(IDispatch)
    ['{0F858956-41B4-4421-8270-C9DF6C2BBEC1}']
  end;

// *********************************************************************//
// DispIntf:  IZoneInfluenceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0F858956-41B4-4421-8270-C9DF6C2BBEC1}
// *********************************************************************//
  IZoneInfluenceDisp = dispinterface
    ['{0F858956-41B4-4421-8270-C9DF6C2BBEC1}']
  end;

// *********************************************************************//
// Interface: IDirection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9D3727FE-96AB-4321-A001-8701E43825CC}
// *********************************************************************//
  IDirection = interface(IDispatch)
    ['{9D3727FE-96AB-4321-A001-8701E43825CC}']
    function Get_ProbablyNeutralization: Double; safecall;
    property ProbablyNeutralization: Double read Get_ProbablyNeutralization;
  end;

// *********************************************************************//
// DispIntf:  IDirectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9D3727FE-96AB-4321-A001-8701E43825CC}
// *********************************************************************//
  IDirectionDisp = dispinterface
    ['{9D3727FE-96AB-4321-A001-8701E43825CC}']
    property ProbablyNeutralization: Double readonly dispid 201;
  end;

// *********************************************************************//
// Interface: ISearchRegion
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {643AAE8B-E9B4-410E-B317-236DFC5DDBD7}
// *********************************************************************//
  ISearchRegion = interface(IDispatch)
    ['{643AAE8B-E9B4-410E-B317-236DFC5DDBD7}']
    function Get_Length: Double; safecall;
    procedure Set_Length(Value: Double); safecall;
    function Get_Width: Double; safecall;
    procedure Set_Width(Value: Double); safecall;
    function Get_WarriorGroups: IUnknown; safecall;
    property Length: Double read Get_Length write Set_Length;
    property Width: Double read Get_Width write Set_Width;
    property WarriorGroups: IUnknown read Get_WarriorGroups;
  end;

// *********************************************************************//
// DispIntf:  ISearchRegionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {643AAE8B-E9B4-410E-B317-236DFC5DDBD7}
// *********************************************************************//
  ISearchRegionDisp = dispinterface
    ['{643AAE8B-E9B4-410E-B317-236DFC5DDBD7}']
    property Length: Double dispid 201;
    property Width: Double dispid 202;
    property WarriorGroups: IUnknown readonly dispid 203;
  end;

// *********************************************************************//
// Interface: ITool
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5F378DD9-274C-4376-B0FB-07EBD886C55D}
// *********************************************************************//
  ITool = interface(IDispatch)
    ['{5F378DD9-274C-4376-B0FB-07EBD886C55D}']
    function Get_EffIdentify: Double; safecall;
    function Get_Reliability: Double; safecall;
    property EffIdentify: Double read Get_EffIdentify;
    property Reliability: Double read Get_Reliability;
  end;

// *********************************************************************//
// DispIntf:  IToolDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5F378DD9-274C-4376-B0FB-07EBD886C55D}
// *********************************************************************//
  IToolDisp = dispinterface
    ['{5F378DD9-274C-4376-B0FB-07EBD886C55D}']
    property EffIdentify: Double readonly dispid 201;
    property Reliability: Double readonly dispid 202;
  end;

// *********************************************************************//
// Interface: IWarriorGroup
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0E8EEB7B-C597-43BC-BAE0-63E751BBB490}
// *********************************************************************//
  IWarriorGroup = interface(IDispatch)
    ['{0E8EEB7B-C597-43BC-BAE0-63E751BBB490}']
    function Get_Speed: Double; safecall;
    procedure Set_Speed(Value: Double); safecall;
    function Get_Tools: IUnknown; safecall;
    property Speed: Double read Get_Speed write Set_Speed;
    property Tools: IUnknown read Get_Tools;
  end;

// *********************************************************************//
// DispIntf:  IWarriorGroupDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0E8EEB7B-C597-43BC-BAE0-63E751BBB490}
// *********************************************************************//
  IWarriorGroupDisp = dispinterface
    ['{0E8EEB7B-C597-43BC-BAE0-63E751BBB490}']
    property Speed: Double dispid 201;
    property Tools: IUnknown readonly dispid 202;
  end;

// *********************************************************************//
// Interface: IWeapon
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0C97BC4D-099E-40A7-8494-8DBA2F60208A}
// *********************************************************************//
  IWeapon = interface(IDispatch)
    ['{0C97BC4D-099E-40A7-8494-8DBA2F60208A}']
  end;

// *********************************************************************//
// DispIntf:  IWeaponDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0C97BC4D-099E-40A7-8494-8DBA2F60208A}
// *********************************************************************//
  IWeaponDisp = dispinterface
    ['{0C97BC4D-099E-40A7-8494-8DBA2F60208A}']
  end;

// *********************************************************************//
// Interface: IBarrier
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BC431363-8B3D-422E-A720-FD6AF93D5E80}
// *********************************************************************//
  IBarrier = interface(IDispatch)
    ['{BC431363-8B3D-422E-A720-FD6AF93D5E80}']
    function Get_Spread: Double; safecall;
    function Get_Square: Double; safecall;
    property Spread: Double read Get_Spread;
    property Square: Double read Get_Square;
  end;

// *********************************************************************//
// DispIntf:  IBarrierDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BC431363-8B3D-422E-A720-FD6AF93D5E80}
// *********************************************************************//
  IBarrierDisp = dispinterface
    ['{BC431363-8B3D-422E-A720-FD6AF93D5E80}']
    property Spread: Double readonly dispid 201;
    property Square: Double readonly dispid 202;
  end;

// *********************************************************************//
// The Class CoSabotage provides a Create and CreateRemote method to          
// create instances of the default interface ISabotage exposed by              
// the CoClass Sabotage. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSabotage = class
    class function Create: ISabotage;
    class function CreateRemote(const MachineName: string): ISabotage;
  end;

implementation

uses ComObj;

class function CoSabotage.Create: ISabotage;
begin
  Result := CreateComObject(CLASS_Sabotage) as ISabotage;
end;

class function CoSabotage.CreateRemote(const MachineName: string): ISabotage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Sabotage) as ISabotage;
end;

end.
