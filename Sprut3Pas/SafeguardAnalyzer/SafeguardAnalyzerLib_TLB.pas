unit SafeguardAnalyzerLib_TLB;

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
// File generated on 02.10.2007 13:10:35 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\Sprut3\Sprut3Pas\SafeguardAnalyzer\SafeguardAnalyzerLib.tlb (1)
// LIBID: {E95E2D42-34DF-11D6-96C9-0050BA51A6D3}
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
  SafeguardAnalyzerLibMajorVersion = 1;
  SafeguardAnalyzerLibMinorVersion = 0;

  LIBID_SafeguardAnalyzerLib: TGUID = '{E95E2D42-34DF-11D6-96C9-0050BA51A6D3}';

  IID_ISafeguardAnalyzer: TGUID = '{EFB68E6A-218F-4574-BE3E-9416E91D4B5F}';
  IID_IPathNode2: TGUID = '{489640A0-39A2-11D6-9B9F-EC784AED6DA3}';
  IID_IPathArc2: TGUID = '{489640A2-39A2-11D6-9B9F-EC784AED6DA3}';
  CLASS_SafeguardAnalyzer: TGUID = '{E95E2D45-34DF-11D6-96C9-0050BA51A6D3}';
  IID_IPath: TGUID = '{65A82FC8-0490-4DC0-8CC2-DBFB2C78209C}';
  IID_IPathLayer: TGUID = '{0DF3AC30-E00B-4EE9-BABA-7BC205C33F87}';
  IID_IPathGraph: TGUID = '{DF4EEDE1-5677-11D6-96F6-0050BA51A6D3}';
  IID_IVerticalWay: TGUID = '{07AEB6C1-65A7-11D7-9823-0050BA51A6D3}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TSafeguardAnalyzerClass
type
  TSafeguardAnalyzerClass = TOleEnum;
const
  _PathNode = $00000000;
  _PathArc = $00000001;
  _Path = $00000002;
  _PathLayer = $00000003;
  _PathGraph = $00000004;
  _RoadPart = $00000007;
  _VerticalWay = $00000008;

// Constants for enum TPathArcKind
type
  TPathArcKind = TOleEnum;
const
  pakVBoundary = $00000001;
  pakHZone = $00000002;
  pakHJump = $00000003;
  pakHBoundary = $00000004;
  pakVZone = $00000005;
  pakVJump = $00000006;
  pakChangeFacilityState = $00000007;
  pakChangeWarriorGroup = $00000008;
  pakVBoundary_ = $00000009;
  pakRoad = $0000000A;
  pakTarget = $0000000B;
  pakRZone = $0000000C;
  pakOutline = $0000000D;
  pakTMP = $0000000E;

// Constants for enum TPathNodeKind
type
  TPathNodeKind = TOleEnum;
const
  pnkTMP = $00000000;
  pnkVBoundary = $00000001;
  pnkZoneCenter = $00000002;
  pnkHBoundaryCenter = $00000003;
  pnkObject = $00000008;
  pnkCorner = $00000005;
  pnkZoneCenterProjection = $00000006;
  pnkVBoundaryCenter = $00000007;
  pnkZone = $00000009;
  pnkZoneNode = $0000000A;

// Constants for enum TTreeMode
type
  TTreeMode = TOleEnum;
const
  tmToRoot = $00000000;
  tmFromRoot = $00000001;

// Constants for enum TPathKind
type
  TPathKind = TOleEnum;
const
  pkFastPath = $00000001;
  pkStealthPath = $00000003;
  pkRationalPath = $00000005;
  pkRationalBackPath = $00000007;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISafeguardAnalyzer = interface;
  ISafeguardAnalyzerDisp = dispinterface;
  IPathNode2 = interface;
  IPathNode2Disp = dispinterface;
  IPathArc2 = interface;
  IPathArc2Disp = dispinterface;
  IPath = interface;
  IPathDisp = dispinterface;
  IPathLayer = interface;
  IPathLayerDisp = dispinterface;
  IPathGraph = interface;
  IPathGraphDisp = dispinterface;
  IVerticalWay = interface;
  IVerticalWayDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SafeguardAnalyzer = ISafeguardAnalyzer;


// *********************************************************************//
// Interface: ISafeguardAnalyzer
// Flags:     (320) Dual OleAutomation
// GUID:      {EFB68E6A-218F-4574-BE3E-9416E91D4B5F}
// *********************************************************************//
  ISafeguardAnalyzer = interface(IUnknown)
    ['{EFB68E6A-218F-4574-BE3E-9416E91D4B5F}']
    function Get_CurrentWarriorGroup: IDMElement; safecall;
    function Get_ResponceTime: Double; safecall;
    function Get_ResponceTimeDispersion: Double; safecall;
    procedure Set_ResponceTimeDispersion(Value: Double); safecall;
    function Get_DistanceFunc: Double; safecall;
    procedure Set_DistanceFunc(Value: Double); safecall;
    function Get_PathNodes: IDMCollection; safecall;
    function Get_PathArcs: IDMCollection; safecall;
    function MakePathFrom(const NodeE: IDMElement; Reversed: WordBool; PathKind: Integer; 
                          UseStoredRecods: WordBool; var WarriorPathE: IDMElement): IDMElement; safecall;
    function Get_RoadParts: IDMCollection; safecall;
    function BuildPatrolPath(const WarriorGroupE: IDMElement; const StartNodeE: IDMElement; 
                             const FinishNodeE: IDMElement): IDMElement; safecall;
    function Get_VerticalWays: IDMCollection; safecall;
    function Get_CalcMode: Integer; safecall;
    procedure Set_CalcMode(Value: Integer); safecall;
    function Get_TreeMode: Integer; safecall;
    procedure Set_TreeMode(Value: Integer); safecall;
    function Get_PathStage: Integer; safecall;
    procedure Set_PathStage(Value: Integer); safecall;
    function Get_DistanceFunc1: Double; safecall;
    procedure Set_DistanceFunc1(Value: Double); safecall;
    function Get_DistanceFunc2: Double; safecall;
    procedure Set_DistanceFunc2(Value: Double); safecall;
    function Get_DistanceFunc3: Double; safecall;
    procedure Set_DistanceFunc3(Value: Double); safecall;
    property CurrentWarriorGroup: IDMElement read Get_CurrentWarriorGroup;
    property ResponceTime: Double read Get_ResponceTime;
    property ResponceTimeDispersion: Double read Get_ResponceTimeDispersion write Set_ResponceTimeDispersion;
    property DistanceFunc: Double read Get_DistanceFunc write Set_DistanceFunc;
    property PathNodes: IDMCollection read Get_PathNodes;
    property PathArcs: IDMCollection read Get_PathArcs;
    property RoadParts: IDMCollection read Get_RoadParts;
    property VerticalWays: IDMCollection read Get_VerticalWays;
    property CalcMode: Integer read Get_CalcMode write Set_CalcMode;
    property TreeMode: Integer read Get_TreeMode write Set_TreeMode;
    property PathStage: Integer read Get_PathStage write Set_PathStage;
    property DistanceFunc1: Double read Get_DistanceFunc1 write Set_DistanceFunc1;
    property DistanceFunc2: Double read Get_DistanceFunc2 write Set_DistanceFunc2;
    property DistanceFunc3: Double read Get_DistanceFunc3 write Set_DistanceFunc3;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardAnalyzerDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {EFB68E6A-218F-4574-BE3E-9416E91D4B5F}
// *********************************************************************//
  ISafeguardAnalyzerDisp = dispinterface
    ['{EFB68E6A-218F-4574-BE3E-9416E91D4B5F}']
    property CurrentWarriorGroup: IDMElement readonly dispid 2;
    property ResponceTime: Double readonly dispid 4;
    property ResponceTimeDispersion: Double dispid 5;
    property DistanceFunc: Double dispid 7;
    property PathNodes: IDMCollection readonly dispid 9;
    property PathArcs: IDMCollection readonly dispid 10;
    function MakePathFrom(const NodeE: IDMElement; Reversed: WordBool; PathKind: Integer; 
                          UseStoredRecods: WordBool; var WarriorPathE: IDMElement): IDMElement; dispid 12;
    property RoadParts: IDMCollection readonly dispid 13;
    function BuildPatrolPath(const WarriorGroupE: IDMElement; const StartNodeE: IDMElement; 
                             const FinishNodeE: IDMElement): IDMElement; dispid 6;
    property VerticalWays: IDMCollection readonly dispid 14;
    property CalcMode: Integer dispid 1;
    property TreeMode: Integer dispid 8;
    property PathStage: Integer dispid 3;
    property DistanceFunc1: Double dispid 15;
    property DistanceFunc2: Double dispid 16;
    property DistanceFunc3: Double dispid 11;
  end;

// *********************************************************************//
// Interface: IPathNode2
// Flags:     (320) Dual OleAutomation
// GUID:      {489640A0-39A2-11D6-9B9F-EC784AED6DA3}
// *********************************************************************//
  IPathNode2 = interface(IUnknown)
    ['{489640A0-39A2-11D6-9B9F-EC784AED6DA3}']
    procedure StoreRecord(Mode: Integer; const Subject: IDMElement); safecall;
    function Get_DistanceFunc: Double; safecall;
    procedure Set_DistanceFunc(Value: Double); safecall;
    procedure OnUpdateBestDistance(CalcMode: Integer); safecall;
    procedure ResetBestDistance(IsRoot: WordBool); safecall;
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    procedure MakeFastestPath(const Collection: IDMCollection); safecall;
    function Get_Used: WordBool; safecall;
    procedure Set_Used(Value: WordBool); safecall;
    procedure RestoreRecord(Mode: Integer); safecall;
    procedure ClearAllRecords; safecall;
    function Get_DistanceFunc1: Double; safecall;
    procedure Set_DistanceFunc1(Value: Double); safecall;
    function Get_DistanceFunc2: Double; safecall;
    procedure Set_DistanceFunc2(Value: Double); safecall;
    function Get_DistanceFunc3: Double; safecall;
    procedure Set_DistanceFunc3(Value: Double); safecall;
    function Get_MainDelayTimeFromStart: Double; safecall;
    function Get_MainDelayTimeToTarget: Double; safecall;
    property DistanceFunc: Double read Get_DistanceFunc write Set_DistanceFunc;
    property Kind: Integer read Get_Kind write Set_Kind;
    property Used: WordBool read Get_Used write Set_Used;
    property DistanceFunc1: Double read Get_DistanceFunc1 write Set_DistanceFunc1;
    property DistanceFunc2: Double read Get_DistanceFunc2 write Set_DistanceFunc2;
    property DistanceFunc3: Double read Get_DistanceFunc3 write Set_DistanceFunc3;
    property MainDelayTimeFromStart: Double read Get_MainDelayTimeFromStart;
    property MainDelayTimeToTarget: Double read Get_MainDelayTimeToTarget;
  end;

// *********************************************************************//
// DispIntf:  IPathNode2Disp
// Flags:     (320) Dual OleAutomation
// GUID:      {489640A0-39A2-11D6-9B9F-EC784AED6DA3}
// *********************************************************************//
  IPathNode2Disp = dispinterface
    ['{489640A0-39A2-11D6-9B9F-EC784AED6DA3}']
    procedure StoreRecord(Mode: Integer; const Subject: IDMElement); dispid 4;
    property DistanceFunc: Double dispid 7;
    procedure OnUpdateBestDistance(CalcMode: Integer); dispid 9;
    procedure ResetBestDistance(IsRoot: WordBool); dispid 10;
    property Kind: Integer dispid 1;
    procedure MakeFastestPath(const Collection: IDMCollection); dispid 5;
    property Used: WordBool dispid 6;
    procedure RestoreRecord(Mode: Integer); dispid 11;
    procedure ClearAllRecords; dispid 12;
    property DistanceFunc1: Double dispid 8;
    property DistanceFunc2: Double dispid 13;
    property DistanceFunc3: Double dispid 14;
    property MainDelayTimeFromStart: Double readonly dispid 2;
    property MainDelayTimeToTarget: Double readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IPathArc2
// Flags:     (320) Dual OleAutomation
// GUID:      {489640A2-39A2-11D6-9B9F-EC784AED6DA3}
// *********************************************************************//
  IPathArc2 = interface(IUnknown)
    ['{489640A2-39A2-11D6-9B9F-EC784AED6DA3}']
    function NewDistanceFromRoot(const PrevNode: IDMElement; const NextNode: IDMElement): Double; safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_DelayTime: Double; safecall;
    procedure OnUpdateBestDistance(CalcMode: Integer); safecall;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property DelayTime: Double read Get_DelayTime;
  end;

// *********************************************************************//
// DispIntf:  IPathArc2Disp
// Flags:     (320) Dual OleAutomation
// GUID:      {489640A2-39A2-11D6-9B9F-EC784AED6DA3}
// *********************************************************************//
  IPathArc2Disp = dispinterface
    ['{489640A2-39A2-11D6-9B9F-EC784AED6DA3}']
    function NewDistanceFromRoot(const PrevNode: IDMElement; const NextNode: IDMElement): Double; dispid 3;
    property Enabled: WordBool dispid 5;
    property DelayTime: Double readonly dispid 1;
    procedure OnUpdateBestDistance(CalcMode: Integer); dispid 2;
  end;

// *********************************************************************//
// Interface: IPath
// Flags:     (320) Dual OleAutomation
// GUID:      {65A82FC8-0490-4DC0-8CC2-DBFB2C78209C}
// *********************************************************************//
  IPath = interface(IUnknown)
    ['{65A82FC8-0490-4DC0-8CC2-DBFB2C78209C}']
  end;

// *********************************************************************//
// DispIntf:  IPathDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {65A82FC8-0490-4DC0-8CC2-DBFB2C78209C}
// *********************************************************************//
  IPathDisp = dispinterface
    ['{65A82FC8-0490-4DC0-8CC2-DBFB2C78209C}']
  end;

// *********************************************************************//
// Interface: IPathLayer
// Flags:     (320) Dual OleAutomation
// GUID:      {0DF3AC30-E00B-4EE9-BABA-7BC205C33F87}
// *********************************************************************//
  IPathLayer = interface(IUnknown)
    ['{0DF3AC30-E00B-4EE9-BABA-7BC205C33F87}']
  end;

// *********************************************************************//
// DispIntf:  IPathLayerDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {0DF3AC30-E00B-4EE9-BABA-7BC205C33F87}
// *********************************************************************//
  IPathLayerDisp = dispinterface
    ['{0DF3AC30-E00B-4EE9-BABA-7BC205C33F87}']
  end;

// *********************************************************************//
// Interface: IPathGraph
// Flags:     (320) Dual OleAutomation
// GUID:      {DF4EEDE1-5677-11D6-96F6-0050BA51A6D3}
// *********************************************************************//
  IPathGraph = interface(IUnknown)
    ['{DF4EEDE1-5677-11D6-96F6-0050BA51A6D3}']
    function Get_PathArcs: IDMCollection; safecall;
    function Get_ExtraSubState: IDMElement; safecall;
    procedure Set_ExtraSubState(const Value: IDMElement); safecall;
    function Get_BackPath: WordBool; safecall;
    procedure Set_BackPath(Value: WordBool); safecall;
    function Get_BackPathSubState: IDMElement; safecall;
    procedure Set_BackPathSubState(const Value: IDMElement); safecall;
    property PathArcs: IDMCollection read Get_PathArcs;
    property ExtraSubState: IDMElement read Get_ExtraSubState write Set_ExtraSubState;
    property BackPath: WordBool read Get_BackPath write Set_BackPath;
    property BackPathSubState: IDMElement read Get_BackPathSubState write Set_BackPathSubState;
  end;

// *********************************************************************//
// DispIntf:  IPathGraphDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {DF4EEDE1-5677-11D6-96F6-0050BA51A6D3}
// *********************************************************************//
  IPathGraphDisp = dispinterface
    ['{DF4EEDE1-5677-11D6-96F6-0050BA51A6D3}']
    property PathArcs: IDMCollection readonly dispid 1;
    property ExtraSubState: IDMElement dispid 2;
    property BackPath: WordBool dispid 3;
    property BackPathSubState: IDMElement dispid 5;
  end;

// *********************************************************************//
// Interface: IVerticalWay
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {07AEB6C1-65A7-11D7-9823-0050BA51A6D3}
// *********************************************************************//
  IVerticalWay = interface(IDispatch)
    ['{07AEB6C1-65A7-11D7-9823-0050BA51A6D3}']
    function Get_X: Double; safecall;
    function Get_Y: Double; safecall;
    function Get_Usable: WordBool; safecall;
    procedure Set_Usable(Value: WordBool); safecall;
    function Get_X0: Double; safecall;
    procedure Set_X0(Value: Double); safecall;
    function Get_Y0: Double; safecall;
    procedure Set_Y0(Value: Double); safecall;
    function Get_X1: Double; safecall;
    procedure Set_X1(Value: Double); safecall;
    function Get_Y1: Double; safecall;
    procedure Set_Y1(Value: Double); safecall;
    function Get_Side: Integer; safecall;
    procedure Set_Side(Value: Integer); safecall;
    function Get_Nodes0: IDMCollection; safecall;
    function Get_Nodes1: IDMCollection; safecall;
    property X: Double read Get_X;
    property Y: Double read Get_Y;
    property Usable: WordBool read Get_Usable write Set_Usable;
    property X0: Double read Get_X0 write Set_X0;
    property Y0: Double read Get_Y0 write Set_Y0;
    property X1: Double read Get_X1 write Set_X1;
    property Y1: Double read Get_Y1 write Set_Y1;
    property Side: Integer read Get_Side write Set_Side;
    property Nodes0: IDMCollection read Get_Nodes0;
    property Nodes1: IDMCollection read Get_Nodes1;
  end;

// *********************************************************************//
// DispIntf:  IVerticalWayDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {07AEB6C1-65A7-11D7-9823-0050BA51A6D3}
// *********************************************************************//
  IVerticalWayDisp = dispinterface
    ['{07AEB6C1-65A7-11D7-9823-0050BA51A6D3}']
    property X: Double readonly dispid 1;
    property Y: Double readonly dispid 2;
    property Usable: WordBool dispid 4;
    property X0: Double dispid 5;
    property Y0: Double dispid 6;
    property X1: Double dispid 7;
    property Y1: Double dispid 8;
    property Side: Integer dispid 9;
    property Nodes0: IDMCollection readonly dispid 3;
    property Nodes1: IDMCollection readonly dispid 10;
  end;

// *********************************************************************//
// The Class CoSafeguardAnalyzer provides a Create and CreateRemote method to          
// create instances of the default interface ISafeguardAnalyzer exposed by              
// the CoClass SafeguardAnalyzer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSafeguardAnalyzer = class
    class function Create: ISafeguardAnalyzer;
    class function CreateRemote(const MachineName: string): ISafeguardAnalyzer;
  end;

implementation

uses ComObj;

class function CoSafeguardAnalyzer.Create: ISafeguardAnalyzer;
begin
  Result := CreateComObject(CLASS_SafeguardAnalyzer) as ISafeguardAnalyzer;
end;

class function CoSafeguardAnalyzer.CreateRemote(const MachineName: string): ISafeguardAnalyzer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SafeguardAnalyzer) as ISafeguardAnalyzer;
end;

end.
