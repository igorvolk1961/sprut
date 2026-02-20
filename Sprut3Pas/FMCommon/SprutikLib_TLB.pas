unit SprutikLib_TLB;

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
// File generated on 14.02.2008 13:23:35 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\Sprutik\SprutikPas\SprutikLib.tlb (1)
// LIBID: {0D418640-AFE4-11D8-99A7-0050BA51A6D3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SprutikLibMajorVersion = 1;
  SprutikLibMinorVersion = 0;

  LIBID_SprutikLib: TGUID = '{0D418640-AFE4-11D8-99A7-0050BA51A6D3}';

  IID_ISprutik: TGUID = '{0D41864E-AFE4-11D8-99A7-0050BA51A6D3}';
  IID_IWayElement: TGUID = '{0D418646-AFE4-11D8-99A7-0050BA51A6D3}';
  CLASS_Sprutik: TGUID = '{0D418643-AFE4-11D8-99A7-0050BA51A6D3}';
  IID_ICalcVariant: TGUID = '{7E658263-B51E-11D8-99AC-0050BA51A6D3}';
  IID_ISGEvent: TGUID = '{157399BA-FE80-4892-982C-C725019C396B}';
  IID_IHistory: TGUID = '{7602A638-C1E5-41AC-8146-C255605E315C}';
  IID_IBlockGroupRec: TGUID = '{586B042C-0CED-4A90-8E9D-966DE42DA5A1}';
  IID_IGuardUnit: TGUID = '{0F2A7233-5511-4A28-881B-6A54A2ABEAA6}';
  IID_IThreat: TGUID = '{55E39558-D079-4FC2-9344-7A0916D7B6D9}';
  IID_ISummator: TGUID = '{7BEDD6B3-5855-41EB-85F6-D72AB6CD63BC}';
  IID_IWayElement2: TGUID = '{A83318C4-CCDB-4D54-9A53-E528B814E58D}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TSprutikConst
type
  TSprutikConst = TOleEnum;
const
  _CalcVariant = $000000C8;
  _WayElement = $000000C9;
  _SGEvent = $000000CA;
  _History = $000000CB;
  _BlockGroupRec = $000000CC;
  _Summator = $000000CD;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISprutik = interface;
  ISprutikDisp = dispinterface;
  IWayElement = interface;
  IWayElementDisp = dispinterface;
  ICalcVariant = interface;
  ICalcVariantDisp = dispinterface;
  ISGEvent = interface;
  ISGEventDisp = dispinterface;
  IHistory = interface;
  IHistoryDisp = dispinterface;
  IBlockGroupRec = interface;
  IBlockGroupRecDisp = dispinterface;
  IGuardUnit = interface;
  IGuardUnitDisp = dispinterface;
  IThreat = interface;
  IThreatDisp = dispinterface;
  ISummator = interface;
  ISummatorDisp = dispinterface;
  IWayElement2 = interface;
  IWayElement2Disp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Sprutik = ISprutik;


// *********************************************************************//
// Interface: ISprutik
// Flags:     (320) Dual OleAutomation
// GUID:      {0D41864E-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  ISprutik = interface(IUnknown)
    ['{0D41864E-AFE4-11D8-99A7-0050BA51A6D3}']
    procedure Calc; safecall;
    procedure ClearResults; safecall;
    function Get_MinTotalProbability: Double; safecall;
    function Get_MinProbability: Double; safecall;
    function Get_MinHistoryTotalProbability: Double; safecall;
    function Get_MinObservationPeriod: Double; safecall;
    function Get_PreservFastChoice: WordBool; safecall;
    property MinTotalProbability: Double read Get_MinTotalProbability;
    property MinProbability: Double read Get_MinProbability;
    property MinHistoryTotalProbability: Double read Get_MinHistoryTotalProbability;
    property MinObservationPeriod: Double read Get_MinObservationPeriod;
    property PreservFastChoice: WordBool read Get_PreservFastChoice;
  end;

// *********************************************************************//
// DispIntf:  ISprutikDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {0D41864E-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  ISprutikDisp = dispinterface
    ['{0D41864E-AFE4-11D8-99A7-0050BA51A6D3}']
    procedure Calc; dispid 1;
    procedure ClearResults; dispid 2;
    property MinTotalProbability: Double readonly dispid 3;
    property MinProbability: Double readonly dispid 4;
    property MinHistoryTotalProbability: Double readonly dispid 5;
    property MinObservationPeriod: Double readonly dispid 6;
    property PreservFastChoice: WordBool readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IWayElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0D418646-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  IWayElement = interface(IDispatch)
    ['{0D418646-AFE4-11D8-99A7-0050BA51A6D3}']
    function Get_DelayTimeFast: Double; safecall;
    function Get_DelayTimeDev: Double; safecall;
    function Get_AlarmGroupDelayTime: Double; safecall;
    function Get_AlarmGroupArrivalTime: Double; safecall;
    function Get_AlarmGroupArrivalTimeDev: Double; safecall;
    function Get_BlockGroupStart: Integer; safecall;
    function Get_BlockGroupArrivalTime: Double; safecall;
    function Get_BlockGroupArrivalTimeDev: Double; safecall;
    function Get_PointsToTarget: WordBool; safecall;
    procedure Set_PointsToTarget(Value: WordBool); safecall;
    function Get_DelayTimeStealth: Double; safecall;
    function Get_DetectionProbabilityFast: Double; safecall;
    function Get_DetectionProbabilityStealth: Double; safecall;
    function Get_EvidenceFast: WordBool; safecall;
    function Get_EvidenceStealth: WordBool; safecall;
    function Get_ObservationPeriod: Double; safecall;
    function Get_FailureProbabilityFast: Double; safecall;
    function Get_FailureProbabilityStealth: Double; safecall;
    function Get_SingleDetectionProbabilityFast: Double; safecall;
    function Get_SingleDetectionProbabilityStealth: Double; safecall;
    function Get_TacticFastU: IUnknown; safecall;
    function Get_TacticStealthU: IUnknown; safecall;
    property DelayTimeFast: Double read Get_DelayTimeFast;
    property DelayTimeDev: Double read Get_DelayTimeDev;
    property AlarmGroupDelayTime: Double read Get_AlarmGroupDelayTime;
    property AlarmGroupArrivalTime: Double read Get_AlarmGroupArrivalTime;
    property AlarmGroupArrivalTimeDev: Double read Get_AlarmGroupArrivalTimeDev;
    property BlockGroupStart: Integer read Get_BlockGroupStart;
    property BlockGroupArrivalTime: Double read Get_BlockGroupArrivalTime;
    property BlockGroupArrivalTimeDev: Double read Get_BlockGroupArrivalTimeDev;
    property PointsToTarget: WordBool read Get_PointsToTarget write Set_PointsToTarget;
    property DelayTimeStealth: Double read Get_DelayTimeStealth;
    property DetectionProbabilityFast: Double read Get_DetectionProbabilityFast;
    property DetectionProbabilityStealth: Double read Get_DetectionProbabilityStealth;
    property EvidenceFast: WordBool read Get_EvidenceFast;
    property EvidenceStealth: WordBool read Get_EvidenceStealth;
    property ObservationPeriod: Double read Get_ObservationPeriod;
    property FailureProbabilityFast: Double read Get_FailureProbabilityFast;
    property FailureProbabilityStealth: Double read Get_FailureProbabilityStealth;
    property SingleDetectionProbabilityFast: Double read Get_SingleDetectionProbabilityFast;
    property SingleDetectionProbabilityStealth: Double read Get_SingleDetectionProbabilityStealth;
    property TacticFastU: IUnknown read Get_TacticFastU;
    property TacticStealthU: IUnknown read Get_TacticStealthU;
  end;

// *********************************************************************//
// DispIntf:  IWayElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0D418646-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  IWayElementDisp = dispinterface
    ['{0D418646-AFE4-11D8-99A7-0050BA51A6D3}']
    property DelayTimeFast: Double readonly dispid 1;
    property DelayTimeDev: Double readonly dispid 2;
    property AlarmGroupDelayTime: Double readonly dispid 6;
    property AlarmGroupArrivalTime: Double readonly dispid 10;
    property AlarmGroupArrivalTimeDev: Double readonly dispid 12;
    property BlockGroupStart: Integer readonly dispid 24;
    property BlockGroupArrivalTime: Double readonly dispid 25;
    property BlockGroupArrivalTimeDev: Double readonly dispid 26;
    property PointsToTarget: WordBool dispid 5;
    property DelayTimeStealth: Double readonly dispid 18;
    property DetectionProbabilityFast: Double readonly dispid 19;
    property DetectionProbabilityStealth: Double readonly dispid 20;
    property EvidenceFast: WordBool readonly dispid 4;
    property EvidenceStealth: WordBool readonly dispid 7;
    property ObservationPeriod: Double readonly dispid 8;
    property FailureProbabilityFast: Double readonly dispid 3;
    property FailureProbabilityStealth: Double readonly dispid 9;
    property SingleDetectionProbabilityFast: Double readonly dispid 11;
    property SingleDetectionProbabilityStealth: Double readonly dispid 13;
    property TacticFastU: IUnknown readonly dispid 14;
    property TacticStealthU: IUnknown readonly dispid 15;
  end;

// *********************************************************************//
// Interface: ICalcVariant
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7E658263-B51E-11D8-99AC-0050BA51A6D3}
// *********************************************************************//
  ICalcVariant = interface(IDispatch)
    ['{7E658263-B51E-11D8-99AC-0050BA51A6D3}']
    function Get_SuccessP: Double; safecall;
    procedure Set_SuccessP(Value: Double); safecall;
    function Get_Efficiency: Double; safecall;
    procedure Set_Efficiency(Value: Double); safecall;
    function Get_WayElementsU: IUnknown; safecall;
    procedure Calc; safecall;
    function Get_SGEventsU: IUnknown; safecall;
    function Get_HistoriesU: IUnknown; safecall;
    function Get_BackPathMode: Integer; safecall;
    function Get_Histories1U: IUnknown; safecall;
    function Get_SummatorsU: IUnknown; safecall;
    property SuccessP: Double read Get_SuccessP write Set_SuccessP;
    property Efficiency: Double read Get_Efficiency write Set_Efficiency;
    property WayElementsU: IUnknown read Get_WayElementsU;
    property SGEventsU: IUnknown read Get_SGEventsU;
    property HistoriesU: IUnknown read Get_HistoriesU;
    property BackPathMode: Integer read Get_BackPathMode;
    property Histories1U: IUnknown read Get_Histories1U;
    property SummatorsU: IUnknown read Get_SummatorsU;
  end;

// *********************************************************************//
// DispIntf:  ICalcVariantDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7E658263-B51E-11D8-99AC-0050BA51A6D3}
// *********************************************************************//
  ICalcVariantDisp = dispinterface
    ['{7E658263-B51E-11D8-99AC-0050BA51A6D3}']
    property SuccessP: Double dispid 3;
    property Efficiency: Double dispid 4;
    property WayElementsU: IUnknown readonly dispid 6;
    procedure Calc; dispid 7;
    property SGEventsU: IUnknown readonly dispid 8;
    property HistoriesU: IUnknown readonly dispid 9;
    property BackPathMode: Integer readonly dispid 1;
    property Histories1U: IUnknown readonly dispid 2;
    property SummatorsU: IUnknown readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ISGEvent
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {157399BA-FE80-4892-982C-C725019C396B}
// *********************************************************************//
  ISGEvent = interface(IDispatch)
    ['{157399BA-FE80-4892-982C-C725019C396B}']
    function Get_Probability: Double; safecall;
    procedure Set_Probability(Value: Double); safecall;
    function Get_Information: Integer; safecall;
    procedure Set_Information(Value: Integer); safecall;
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    function Get_PrevSGEvent: IUnknown; safecall;
    procedure Set_PrevSGEvent(const Value: IUnknown); safecall;
    function Get_DelayTimeSum: Double; safecall;
    procedure Set_DelayTimeSum(Value: Double); safecall;
    function Get_AlarmGroupDelayTimeSum: Double; safecall;
    procedure Set_AlarmGroupDelayTimeSum(Value: Double); safecall;
    function Get_DelayTimeSumDisp: Double; safecall;
    procedure Set_DelayTimeSumDisp(Value: Double); safecall;
    function Get_AlarmGroupDelayTimeSumDisp: Double; safecall;
    procedure Set_AlarmGroupDelayTimeSumDisp(Value: Double); safecall;
    function Get_Index: Integer; safecall;
    procedure Set_Index(Value: Integer); safecall;
    function Get_Position: Integer; safecall;
    procedure Set_Position(Value: Integer); safecall;
    function Get_AlarmGroupArrivalTime: Double; safecall;
    procedure Set_AlarmGroupArrivalTime(Value: Double); safecall;
    function Get_AlarmGroupArrivalTimeDisp: Double; safecall;
    procedure Set_AlarmGroupArrivalTimeDisp(Value: Double); safecall;
    function Get_BlockGroupRecsU: IUnknown; safecall;
    function Get_dP: Double; safecall;
    procedure Set_dP(Value: Double); safecall;
    function Get_StealthMode: WordBool; safecall;
    procedure Set_StealthMode(Value: WordBool); safecall;
    function Get_Summator: ISummator; safecall;
    procedure Set_Summator(const Value: ISummator); safecall;
    property Probability: Double read Get_Probability write Set_Probability;
    property Information: Integer read Get_Information write Set_Information;
    property Kind: Integer read Get_Kind write Set_Kind;
    property PrevSGEvent: IUnknown read Get_PrevSGEvent write Set_PrevSGEvent;
    property DelayTimeSum: Double read Get_DelayTimeSum write Set_DelayTimeSum;
    property AlarmGroupDelayTimeSum: Double read Get_AlarmGroupDelayTimeSum write Set_AlarmGroupDelayTimeSum;
    property DelayTimeSumDisp: Double read Get_DelayTimeSumDisp write Set_DelayTimeSumDisp;
    property AlarmGroupDelayTimeSumDisp: Double read Get_AlarmGroupDelayTimeSumDisp write Set_AlarmGroupDelayTimeSumDisp;
    property Index: Integer read Get_Index write Set_Index;
    property Position: Integer read Get_Position write Set_Position;
    property AlarmGroupArrivalTime: Double read Get_AlarmGroupArrivalTime write Set_AlarmGroupArrivalTime;
    property AlarmGroupArrivalTimeDisp: Double read Get_AlarmGroupArrivalTimeDisp write Set_AlarmGroupArrivalTimeDisp;
    property BlockGroupRecsU: IUnknown read Get_BlockGroupRecsU;
    property dP: Double read Get_dP write Set_dP;
    property StealthMode: WordBool read Get_StealthMode write Set_StealthMode;
    property Summator: ISummator read Get_Summator write Set_Summator;
  end;

// *********************************************************************//
// DispIntf:  ISGEventDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {157399BA-FE80-4892-982C-C725019C396B}
// *********************************************************************//
  ISGEventDisp = dispinterface
    ['{157399BA-FE80-4892-982C-C725019C396B}']
    property Probability: Double dispid 2;
    property Information: Integer dispid 3;
    property Kind: Integer dispid 7;
    property PrevSGEvent: IUnknown dispid 8;
    property DelayTimeSum: Double dispid 9;
    property AlarmGroupDelayTimeSum: Double dispid 5;
    property DelayTimeSumDisp: Double dispid 10;
    property AlarmGroupDelayTimeSumDisp: Double dispid 11;
    property Index: Integer dispid 12;
    property Position: Integer dispid 13;
    property AlarmGroupArrivalTime: Double dispid 1;
    property AlarmGroupArrivalTimeDisp: Double dispid 14;
    property BlockGroupRecsU: IUnknown readonly dispid 4;
    property dP: Double dispid 15;
    property StealthMode: WordBool dispid 17;
    property Summator: ISummator dispid 6;
  end;

// *********************************************************************//
// Interface: IHistory
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7602A638-C1E5-41AC-8146-C255605E315C}
// *********************************************************************//
  IHistory = interface(IDispatch)
    ['{7602A638-C1E5-41AC-8146-C255605E315C}']
    function Get_Probability: Double; safecall;
    procedure Set_Probability(Value: Double); safecall;
    function Get_SGEventsU: IUnknown; safecall;
    procedure MakeFrom(const SGStateU: IUnknown); safecall;
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    property Probability: Double read Get_Probability write Set_Probability;
    property SGEventsU: IUnknown read Get_SGEventsU;
    property Kind: Integer read Get_Kind write Set_Kind;
  end;

// *********************************************************************//
// DispIntf:  IHistoryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7602A638-C1E5-41AC-8146-C255605E315C}
// *********************************************************************//
  IHistoryDisp = dispinterface
    ['{7602A638-C1E5-41AC-8146-C255605E315C}']
    property Probability: Double dispid 1;
    property SGEventsU: IUnknown readonly dispid 2;
    procedure MakeFrom(const SGStateU: IUnknown); dispid 3;
    property Kind: Integer dispid 5;
  end;

// *********************************************************************//
// Interface: IBlockGroupRec
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {586B042C-0CED-4A90-8E9D-966DE42DA5A1}
// *********************************************************************//
  IBlockGroupRec = interface(IDispatch)
    ['{586B042C-0CED-4A90-8E9D-966DE42DA5A1}']
    function Get_DelayTimeSum1: Double; safecall;
    procedure Set_DelayTimeSum1(Value: Double); safecall;
    function Get_DelayTimeSumDisp1: Double; safecall;
    procedure Set_DelayTimeSumDisp1(Value: Double); safecall;
    function Get_Killed: WordBool; safecall;
    procedure Set_Killed(Value: WordBool); safecall;
    function Get_Arrived: WordBool; safecall;
    procedure Set_Arrived(Value: WordBool); safecall;
    function Get_IsLate: Integer; safecall;
    procedure Set_IsLate(Value: Integer); safecall;
    property DelayTimeSum1: Double read Get_DelayTimeSum1 write Set_DelayTimeSum1;
    property DelayTimeSumDisp1: Double read Get_DelayTimeSumDisp1 write Set_DelayTimeSumDisp1;
    property Killed: WordBool read Get_Killed write Set_Killed;
    property Arrived: WordBool read Get_Arrived write Set_Arrived;
    property IsLate: Integer read Get_IsLate write Set_IsLate;
  end;

// *********************************************************************//
// DispIntf:  IBlockGroupRecDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {586B042C-0CED-4A90-8E9D-966DE42DA5A1}
// *********************************************************************//
  IBlockGroupRecDisp = dispinterface
    ['{586B042C-0CED-4A90-8E9D-966DE42DA5A1}']
    property DelayTimeSum1: Double dispid 1;
    property DelayTimeSumDisp1: Double dispid 2;
    property Killed: WordBool dispid 3;
    property Arrived: WordBool dispid 4;
    property IsLate: Integer dispid 6;
  end;

// *********************************************************************//
// Interface: IGuardUnit
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0F2A7233-5511-4A28-881B-6A54A2ABEAA6}
// *********************************************************************//
  IGuardUnit = interface(IDispatch)
    ['{0F2A7233-5511-4A28-881B-6A54A2ABEAA6}']
    function Get_GuardCount: Integer; safecall;
    function Get_GuardWeapon: Integer; safecall;
    function Get_GuardLevel: Integer; safecall;
    function Get_BTR: WordBool; safecall;
    function Get_DevenceBattleP: Double; safecall;
    procedure Set_DevenceBattleP(Value: Double); safecall;
    function Get_AttackBattleP: Double; safecall;
    procedure Set_AttackBattleP(Value: Double); safecall;
    function Get_DefenceBattleT: Double; safecall;
    procedure Set_DefenceBattleT(Value: Double); safecall;
    function Get_AttackBattleT: Double; safecall;
    procedure Set_AttackBattleT(Value: Double); safecall;
    property GuardCount: Integer read Get_GuardCount;
    property GuardWeapon: Integer read Get_GuardWeapon;
    property GuardLevel: Integer read Get_GuardLevel;
    property BTR: WordBool read Get_BTR;
    property DevenceBattleP: Double read Get_DevenceBattleP write Set_DevenceBattleP;
    property AttackBattleP: Double read Get_AttackBattleP write Set_AttackBattleP;
    property DefenceBattleT: Double read Get_DefenceBattleT write Set_DefenceBattleT;
    property AttackBattleT: Double read Get_AttackBattleT write Set_AttackBattleT;
  end;

// *********************************************************************//
// DispIntf:  IGuardUnitDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0F2A7233-5511-4A28-881B-6A54A2ABEAA6}
// *********************************************************************//
  IGuardUnitDisp = dispinterface
    ['{0F2A7233-5511-4A28-881B-6A54A2ABEAA6}']
    property GuardCount: Integer readonly dispid 1;
    property GuardWeapon: Integer readonly dispid 2;
    property GuardLevel: Integer readonly dispid 3;
    property BTR: WordBool readonly dispid 5;
    property DevenceBattleP: Double dispid 6;
    property AttackBattleP: Double dispid 7;
    property DefenceBattleT: Double dispid 8;
    property AttackBattleT: Double dispid 9;
  end;

// *********************************************************************//
// Interface: IThreat
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {55E39558-D079-4FC2-9344-7A0916D7B6D9}
// *********************************************************************//
  IThreat = interface(IDispatch)
    ['{55E39558-D079-4FC2-9344-7A0916D7B6D9}']
    function Get_ThreatCount: Integer; safecall;
    function Get_ThreatWeapon: Integer; safecall;
    function Get_ThreatLevel: Integer; safecall;
    function Get_UserDefinedBattleResult: WordBool; safecall;
    property ThreatCount: Integer read Get_ThreatCount;
    property ThreatWeapon: Integer read Get_ThreatWeapon;
    property ThreatLevel: Integer read Get_ThreatLevel;
    property UserDefinedBattleResult: WordBool read Get_UserDefinedBattleResult;
  end;

// *********************************************************************//
// DispIntf:  IThreatDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {55E39558-D079-4FC2-9344-7A0916D7B6D9}
// *********************************************************************//
  IThreatDisp = dispinterface
    ['{55E39558-D079-4FC2-9344-7A0916D7B6D9}']
    property ThreatCount: Integer readonly dispid 1;
    property ThreatWeapon: Integer readonly dispid 2;
    property ThreatLevel: Integer readonly dispid 3;
    property UserDefinedBattleResult: WordBool readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ISummator
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7BEDD6B3-5855-41EB-85F6-D72AB6CD63BC}
// *********************************************************************//
  ISummator = interface(IDispatch)
    ['{7BEDD6B3-5855-41EB-85F6-D72AB6CD63BC}']
    function Get_SuccessP: Double; safecall;
    procedure Set_SuccessP(Value: Double); safecall;
    function Get_FailureP: Double; safecall;
    procedure Set_FailureP(Value: Double); safecall;
    function Get_HistoriesU: IUnknown; safecall;
    function Get_NextF: ISummator; safecall;
    procedure Set_NextF(const Value: ISummator); safecall;
    function Get_NextS: ISummator; safecall;
    procedure Set_NextS(const Value: ISummator); safecall;
    function Get_StealthMode: WordBool; safecall;
    procedure Set_StealthMode(Value: WordBool); safecall;
    property SuccessP: Double read Get_SuccessP write Set_SuccessP;
    property FailureP: Double read Get_FailureP write Set_FailureP;
    property HistoriesU: IUnknown read Get_HistoriesU;
    property NextF: ISummator read Get_NextF write Set_NextF;
    property NextS: ISummator read Get_NextS write Set_NextS;
    property StealthMode: WordBool read Get_StealthMode write Set_StealthMode;
  end;

// *********************************************************************//
// DispIntf:  ISummatorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7BEDD6B3-5855-41EB-85F6-D72AB6CD63BC}
// *********************************************************************//
  ISummatorDisp = dispinterface
    ['{7BEDD6B3-5855-41EB-85F6-D72AB6CD63BC}']
    property SuccessP: Double dispid 1;
    property FailureP: Double dispid 3;
    property HistoriesU: IUnknown readonly dispid 5;
    property NextF: ISummator dispid 4;
    property NextS: ISummator dispid 6;
    property StealthMode: WordBool dispid 8;
  end;

// *********************************************************************//
// Interface: IWayElement2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A83318C4-CCDB-4D54-9A53-E528B814E58D}
// *********************************************************************//
  IWayElement2 = interface(IDispatch)
    ['{A83318C4-CCDB-4D54-9A53-E528B814E58D}']
    procedure Process; safecall;
    function Get_SGEventsU: IUnknown; safecall;
    function Get_Index: Integer; safecall;
    procedure Set_Index(Value: Integer); safecall;
    property SGEventsU: IUnknown read Get_SGEventsU;
    property Index: Integer read Get_Index write Set_Index;
  end;

// *********************************************************************//
// DispIntf:  IWayElement2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A83318C4-CCDB-4D54-9A53-E528B814E58D}
// *********************************************************************//
  IWayElement2Disp = dispinterface
    ['{A83318C4-CCDB-4D54-9A53-E528B814E58D}']
    procedure Process; dispid 1;
    property SGEventsU: IUnknown readonly dispid 2;
    property Index: Integer dispid 3;
  end;

// *********************************************************************//
// The Class CoSprutik provides a Create and CreateRemote method to          
// create instances of the default interface ISprutik exposed by              
// the CoClass Sprutik. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSprutik = class
    class function Create: ISprutik;
    class function CreateRemote(const MachineName: string): ISprutik;
  end;

implementation

uses ComObj;

class function CoSprutik.Create: ISprutik;
begin
  Result := CreateComObject(CLASS_Sprutik) as ISprutik;
end;

class function CoSprutik.CreateRemote(const MachineName: string): ISprutik;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Sprutik) as ISprutik;
end;

end.
