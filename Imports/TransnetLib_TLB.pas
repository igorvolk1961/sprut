unit TransnetLib_TLB;

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
// File generated on 01.12.2005 17:49:14 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\Transnet\TransnetPas\TransnetLib\TransnetLib.tlb (1)
// LIBID: {C6CCCE0D-6D7F-400A-B83C-A64493F67210}
// LCID: 0
// Helpfile: 
// HelpString: BaseAnalysisVariant Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v1.0 DataModel, (D:\Users\Volkov\AutoDM\AutoDMPas\DataModel\DataModel.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, DataModel_TLB, Graphics, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  TransnetLibMajorVersion = 1;
  TransnetLibMinorVersion = 0;

  LIBID_TransnetLib: TGUID = '{C6CCCE0D-6D7F-400A-B83C-A64493F67210}';

  IID_ITransnet: TGUID = '{77C9366A-8CB4-4D7C-8024-22CE5021919F}';
  CLASS_Transnet: TGUID = '{A0D23283-40EB-4AD8-8C7B-90F49C287AF5}';
  IID_IPosition: TGUID = '{07BA531D-342C-4464-A47F-A41CB7105A67}';
  IID_IToken: TGUID = '{BA4C700A-D00E-4BFC-A3EC-9A3401AFC655}';
  IID_IPassage: TGUID = '{CBB7A01C-3C4E-492A-B183-001806FE1E91}';
  IID_IArrow: TGUID = '{3702B234-058D-41A4-A477-2A898DF6B92D}';
  IID_ICalcprocSeries: TGUID = '{E10C787A-A191-4B61-90B3-27C8193D1DCF}';
  IID_ICalcprocVariant: TGUID = '{D4FFCBB0-7C1D-4C87-92EB-FD663F28E089}';
  IID_ICalcsysModel: TGUID = '{B5A08F34-BC61-4BC0-86CC-FF28A80462C4}';
  IID_ICalcsysState: TGUID = '{36EC000B-B971-445B-8E31-185754F7E40D}';
  IID_IAnalysisVariant: TGUID = '{A8591594-D5FD-474C-9027-7177C7FB4B16}';
  IID_ICalcsysSubState: TGUID = '{7375D1D6-D07B-4612-B9A9-90248A21A24C}';
  IID_ICalcprocSub: TGUID = '{825F8D95-534D-44A6-B559-CEEE99C6D5D9}';
  IID_ITMState: TGUID = '{28D5D127-D9A9-4CF8-81DF-5BEE7F30ADEE}';
  IID_ICalcprocTask: TGUID = '{D1135ED1-E622-4645-9A85-B0C893C15AF2}';
  IID_IChanging: TGUID = '{72B4CDA1-5FDC-11DA-9B48-0050BA51A6D3}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TTransnetConst
type
  TTransnetConst = TOleEnum;
const
  _Position = $0000000B;
  _Passage = $0000000C;
  _Token = $0000000D;
  _Arrow = $0000000E;
  _CalcprocSeries = $0000000F;
  _CalcprocVariant = $00000010;
  _CalcsysModel = $00000011;
  _CalcsysState = $00000012;
  _AnalysisVariant = $00000013;
  _CalcsysSubState = $00000014;
  _CalcprocSub = $00000015;
  _CalcprocTask = $00000016;
  _Changing = $00000017;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ITransnet = interface;
  ITransnetDisp = dispinterface;
  IPosition = interface;
  IPositionDisp = dispinterface;
  IToken = interface;
  ITokenDisp = dispinterface;
  IPassage = interface;
  IPassageDisp = dispinterface;
  IArrow = interface;
  IArrowDisp = dispinterface;
  ICalcprocSeries = interface;
  ICalcprocSeriesDisp = dispinterface;
  ICalcprocVariant = interface;
  ICalcprocVariantDisp = dispinterface;
  ICalcsysModel = interface;
  ICalcsysModelDisp = dispinterface;
  ICalcsysState = interface;
  ICalcsysStateDisp = dispinterface;
  IAnalysisVariant = interface;
  IAnalysisVariantDisp = dispinterface;
  ICalcsysSubState = interface;
  ICalcsysSubStateDisp = dispinterface;
  ICalcprocSub = interface;
  ICalcprocSubDisp = dispinterface;
  ITMState = interface;
  ITMStateDisp = dispinterface;
  ICalcprocTask = interface;
  ICalcprocTaskDisp = dispinterface;
  IChanging = interface;
  IChangingDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Transnet = ITransnet;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PIUnknown1 = ^IUnknown; {*}


// *********************************************************************//
// Interface: ITransnet
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {77C9366A-8CB4-4D7C-8024-22CE5021919F}
// *********************************************************************//
  ITransnet = interface(IDispatch)
    ['{77C9366A-8CB4-4D7C-8024-22CE5021919F}']
    function Get_CalcprocVariants: IUnknown; safecall;
    function Get_CalcsysStates: IUnknown; safecall;
    function Get_Enviroments: IUnknown; safecall;
    function Get_Positions: IUnknown; safecall;
    function Get_Tokens: IUnknown; safecall;
    function Get_Passages: IUnknown; safecall;
    function Get_Arrows: IUnknown; safecall;
    function Get_AnalysisVariants: IUnknown; safecall;
    function Get_CalcprocSubs: IUnknown; safecall;
    function Get_Changings: IUnknown; safecall;
    property CalcprocVariants: IUnknown read Get_CalcprocVariants;
    property CalcsysStates: IUnknown read Get_CalcsysStates;
    property Enviroments: IUnknown read Get_Enviroments;
    property Positions: IUnknown read Get_Positions;
    property Tokens: IUnknown read Get_Tokens;
    property Passages: IUnknown read Get_Passages;
    property Arrows: IUnknown read Get_Arrows;
    property AnalysisVariants: IUnknown read Get_AnalysisVariants;
    property CalcprocSubs: IUnknown read Get_CalcprocSubs;
    property Changings: IUnknown read Get_Changings;
  end;

// *********************************************************************//
// DispIntf:  ITransnetDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {77C9366A-8CB4-4D7C-8024-22CE5021919F}
// *********************************************************************//
  ITransnetDisp = dispinterface
    ['{77C9366A-8CB4-4D7C-8024-22CE5021919F}']
    property CalcprocVariants: IUnknown readonly dispid 201;
    property CalcsysStates: IUnknown readonly dispid 202;
    property Enviroments: IUnknown readonly dispid 203;
    property Positions: IUnknown readonly dispid 204;
    property Tokens: IUnknown readonly dispid 205;
    property Passages: IUnknown readonly dispid 206;
    property Arrows: IUnknown readonly dispid 207;
    property AnalysisVariants: IUnknown readonly dispid 208;
    property CalcprocSubs: IUnknown readonly dispid 209;
    property Changings: IUnknown readonly dispid 210;
  end;

// *********************************************************************//
// Interface: IPosition
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {07BA531D-342C-4464-A47F-A41CB7105A67}
// *********************************************************************//
  IPosition = interface(IDispatch)
    ['{07BA531D-342C-4464-A47F-A41CB7105A67}']
    function NodeInSpatialElement(const aCoordNode: IUnknown): WordBool; safecall;
    function Get_StartPosition: WordBool; safecall;
    function Get_ElementType: SYSINT; safecall;
    function Get_MarkedAsMate: IUnknown; safecall;
    procedure Set_MarkedAsMate(const Value: IUnknown); safecall;
    function Get_ID: SYSINT; safecall;
    procedure Set_ID(Value: SYSINT); safecall;
    function Get_Token: IUnknown; safecall;
    procedure Set_Token(const Value: IUnknown); safecall;
    property StartPosition: WordBool read Get_StartPosition;
    property ElementType: SYSINT read Get_ElementType;
    property MarkedAsMate: IUnknown read Get_MarkedAsMate write Set_MarkedAsMate;
    property ID: SYSINT read Get_ID write Set_ID;
    property Token: IUnknown read Get_Token write Set_Token;
  end;

// *********************************************************************//
// DispIntf:  IPositionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {07BA531D-342C-4464-A47F-A41CB7105A67}
// *********************************************************************//
  IPositionDisp = dispinterface
    ['{07BA531D-342C-4464-A47F-A41CB7105A67}']
    function NodeInSpatialElement(const aCoordNode: IUnknown): WordBool; dispid 201;
    property StartPosition: WordBool readonly dispid 202;
    property ElementType: SYSINT readonly dispid 1;
    property MarkedAsMate: IUnknown dispid 2;
    property ID: SYSINT dispid 4;
    property Token: IUnknown dispid 5;
  end;

// *********************************************************************//
// Interface: IToken
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BA4C700A-D00E-4BFC-A3EC-9A3401AFC655}
// *********************************************************************//
  IToken = interface(IDispatch)
    ['{BA4C700A-D00E-4BFC-A3EC-9A3401AFC655}']
    procedure InitMatrixs(nRow: SYSINT; nCol: SYSINT); safecall;
    function Get_Subproc: IUnknown; safecall;
    procedure Set_Subproc(const Value: IUnknown); safecall;
    procedure InitStartPosition(aPos: SYSINT); safecall;
    procedure InitMR1(nRow: SYSINT; nCol: SYSINT); safecall;
    procedure InitMR2(nRow: SYSINT; nCol: SYSINT); safecall;
    procedure FillQz; safecall;
    function Get_m0: IUnknown; safecall;
    function Get_mt: IUnknown; safecall;
    function Get_mq: IUnknown; safecall;
    function Get_IsComplete: WordBool; safecall;
    procedure Adding(const fm: IUnknown; const sm: IUnknown; var rm: IUnknown); safecall;
    procedure Subtraction(const fm: IUnknown; const sm: IUnknown; var rm: IUnknown); safecall;
    procedure Multiplication(const fm: IUnknown; const sm: IUnknown; var rm: IUnknown); safecall;
    procedure Division(const fm: IUnknown; const sm: IUnknown; var rm: IUnknown); safecall;
    function Get_MR1: IUnknown; safecall;
    function Get_MR2: IUnknown; safecall;
    function Get_Qz: IUnknown; safecall;
    function LessEqual(const fmU: IUnknown; const smU: IUnknown): WordBool; safecall;
    function MoreEqual(const fmU: IUnknown; const smU: IUnknown): WordBool; safecall;
    function ComparePositions(const aNP: IUnknown): WordBool; safecall;
    function CheckUpMatePassage(cpgID: Integer): WordBool; safecall;
    function Copy(const aFrom: IUnknown; const aTo: IUnknown): WordBool; safecall;
    procedure TransferDataTime; safecall;
    function Get_PosID: SYSINT; safecall;
    procedure Set_PosID(Value: SYSINT); safecall;
    function Get_Prev: IUnknown; safecall;
    procedure Set_Prev(const Value: IUnknown); safecall;
    function Get_Next: IUnknown; safecall;
    procedure Set_Next(const Value: IUnknown); safecall;
    function Get_Childs: IUnknown; safecall;
    function Get_PluralProc: Integer; safecall;
    function Get_CalcprocSub: IUnknown; safecall;
    function Get_CalcprocSubKind: IUnknown; safecall;
    function Get_ExecCondition: IUnknown; safecall;
    procedure Set_ExecCondition(const Value: IUnknown); safecall;
    function Get_NonExecCondition: IUnknown; safecall;
    procedure Set_NonExecCondition(const Value: IUnknown); safecall;
    function CheckUpMatePositions(cpsID: Integer; cpgID: Integer): WordBool; safecall;
    function Get_MatePositions: IUnknown; safecall;
    procedure SetMatePosition(psID: SYSINT); safecall;
    procedure AddingStayTime(Step: Double); safecall;
    procedure ChangeColor; safecall;
    function Get_Color: Integer; safecall;
    procedure Set_Color(Value: Integer); safecall;
    procedure StartActiveChanging; safecall;
    procedure EndActiveChanging; safecall;
    function CheckUpHitPositions(cpgID: Integer): WordBool; safecall;
    function Get_HitPositions: IUnknown; safecall;
    property Subproc: IUnknown read Get_Subproc write Set_Subproc;
    property m0: IUnknown read Get_m0;
    property mt: IUnknown read Get_mt;
    property mq: IUnknown read Get_mq;
    property IsComplete: WordBool read Get_IsComplete;
    property MR1: IUnknown read Get_MR1;
    property MR2: IUnknown read Get_MR2;
    property Qz: IUnknown read Get_Qz;
    property PosID: SYSINT read Get_PosID write Set_PosID;
    property Prev: IUnknown read Get_Prev write Set_Prev;
    property Next: IUnknown read Get_Next write Set_Next;
    property Childs: IUnknown read Get_Childs;
    property PluralProc: Integer read Get_PluralProc;
    property CalcprocSub: IUnknown read Get_CalcprocSub;
    property CalcprocSubKind: IUnknown read Get_CalcprocSubKind;
    property ExecCondition: IUnknown read Get_ExecCondition write Set_ExecCondition;
    property NonExecCondition: IUnknown read Get_NonExecCondition write Set_NonExecCondition;
    property MatePositions: IUnknown read Get_MatePositions;
    property Color: Integer read Get_Color write Set_Color;
    property HitPositions: IUnknown read Get_HitPositions;
  end;

// *********************************************************************//
// DispIntf:  ITokenDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BA4C700A-D00E-4BFC-A3EC-9A3401AFC655}
// *********************************************************************//
  ITokenDisp = dispinterface
    ['{BA4C700A-D00E-4BFC-A3EC-9A3401AFC655}']
    procedure InitMatrixs(nRow: SYSINT; nCol: SYSINT); dispid 201;
    property Subproc: IUnknown dispid 202;
    procedure InitStartPosition(aPos: SYSINT); dispid 203;
    procedure InitMR1(nRow: SYSINT; nCol: SYSINT); dispid 204;
    procedure InitMR2(nRow: SYSINT; nCol: SYSINT); dispid 205;
    procedure FillQz; dispid 206;
    property m0: IUnknown readonly dispid 1;
    property mt: IUnknown readonly dispid 2;
    property mq: IUnknown readonly dispid 3;
    property IsComplete: WordBool readonly dispid 4;
    procedure Adding(const fm: IUnknown; const sm: IUnknown; var rm: IUnknown); dispid 5;
    procedure Subtraction(const fm: IUnknown; const sm: IUnknown; var rm: IUnknown); dispid 6;
    procedure Multiplication(const fm: IUnknown; const sm: IUnknown; var rm: IUnknown); dispid 7;
    procedure Division(const fm: IUnknown; const sm: IUnknown; var rm: IUnknown); dispid 8;
    property MR1: IUnknown readonly dispid 9;
    property MR2: IUnknown readonly dispid 10;
    property Qz: IUnknown readonly dispid 11;
    function LessEqual(const fmU: IUnknown; const smU: IUnknown): WordBool; dispid 12;
    function MoreEqual(const fmU: IUnknown; const smU: IUnknown): WordBool; dispid 13;
    function ComparePositions(const aNP: IUnknown): WordBool; dispid 14;
    function CheckUpMatePassage(cpgID: Integer): WordBool; dispid 207;
    function Copy(const aFrom: IUnknown; const aTo: IUnknown): WordBool; dispid 15;
    procedure TransferDataTime; dispid 16;
    property PosID: SYSINT dispid 208;
    property Prev: IUnknown dispid 209;
    property Next: IUnknown dispid 210;
    property Childs: IUnknown readonly dispid 211;
    property PluralProc: Integer readonly dispid 17;
    property CalcprocSub: IUnknown readonly dispid 212;
    property CalcprocSubKind: IUnknown readonly dispid 213;
    property ExecCondition: IUnknown dispid 19;
    property NonExecCondition: IUnknown dispid 20;
    function CheckUpMatePositions(cpsID: Integer; cpgID: Integer): WordBool; dispid 214;
    property MatePositions: IUnknown readonly dispid 18;
    procedure SetMatePosition(psID: SYSINT); dispid 21;
    procedure AddingStayTime(Step: Double); dispid 22;
    procedure ChangeColor; dispid 23;
    property Color: Integer dispid 24;
    procedure StartActiveChanging; dispid 25;
    procedure EndActiveChanging; dispid 26;
    function CheckUpHitPositions(cpgID: Integer): WordBool; dispid 27;
    property HitPositions: IUnknown readonly dispid 28;
  end;

// *********************************************************************//
// Interface: IPassage
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CBB7A01C-3C4E-492A-B183-001806FE1E91}
// *********************************************************************//
  IPassage = interface(IDispatch)
    ['{CBB7A01C-3C4E-492A-B183-001806FE1E91}']
    procedure InitEt(nSize: SYSINT; nID: SYSINT); safecall;
    function Get_Et: IUnknown; safecall;
    function NodeInSpatialElement(const aCoordNode: IUnknown): WordBool; safecall;
    property Et: IUnknown read Get_Et;
  end;

// *********************************************************************//
// DispIntf:  IPassageDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CBB7A01C-3C4E-492A-B183-001806FE1E91}
// *********************************************************************//
  IPassageDisp = dispinterface
    ['{CBB7A01C-3C4E-492A-B183-001806FE1E91}']
    procedure InitEt(nSize: SYSINT; nID: SYSINT); dispid 201;
    property Et: IUnknown readonly dispid 202;
    function NodeInSpatialElement(const aCoordNode: IUnknown): WordBool; dispid 203;
  end;

// *********************************************************************//
// Interface: IArrow
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3702B234-058D-41A4-A477-2A898DF6B92D}
// *********************************************************************//
  IArrow = interface(IDispatch)
    ['{3702B234-058D-41A4-A477-2A898DF6B92D}']
    function Get_SpatialElement: IDMElement; safecall;
    property SpatialElement: IDMElement read Get_SpatialElement;
  end;

// *********************************************************************//
// DispIntf:  IArrowDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3702B234-058D-41A4-A477-2A898DF6B92D}
// *********************************************************************//
  IArrowDisp = dispinterface
    ['{3702B234-058D-41A4-A477-2A898DF6B92D}']
    property SpatialElement: IDMElement readonly dispid 201;
  end;

// *********************************************************************//
// Interface: ICalcprocSeries
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E10C787A-A191-4B61-90B3-27C8193D1DCF}
// *********************************************************************//
  ICalcprocSeries = interface(IDispatch)
    ['{E10C787A-A191-4B61-90B3-27C8193D1DCF}']
    procedure Prepare(const aTasks: IUnknown; var pPrev: IUnknown); safecall;
    function Get_CalcprocSubs: IUnknown; safecall;
    property CalcprocSubs: IUnknown read Get_CalcprocSubs;
  end;

// *********************************************************************//
// DispIntf:  ICalcprocSeriesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E10C787A-A191-4B61-90B3-27C8193D1DCF}
// *********************************************************************//
  ICalcprocSeriesDisp = dispinterface
    ['{E10C787A-A191-4B61-90B3-27C8193D1DCF}']
    procedure Prepare(const aTasks: IUnknown; var pPrev: IUnknown); dispid 201;
    property CalcprocSubs: IUnknown readonly dispid 1;
  end;

// *********************************************************************//
// Interface: ICalcprocVariant
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D4FFCBB0-7C1D-4C87-92EB-FD663F28E089}
// *********************************************************************//
  ICalcprocVariant = interface(IDispatch)
    ['{D4FFCBB0-7C1D-4C87-92EB-FD663F28E089}']
    function Get_CalcprocTasks: IUnknown; safecall;
    function Get_TaskTokens: IUnknown; safecall;
    procedure Prepare; safecall;
    function Get_Step: Double; safecall;
    procedure RebuildPluralTree; safecall;
    property CalcprocTasks: IUnknown read Get_CalcprocTasks;
    property TaskTokens: IUnknown read Get_TaskTokens;
    property Step: Double read Get_Step;
  end;

// *********************************************************************//
// DispIntf:  ICalcprocVariantDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D4FFCBB0-7C1D-4C87-92EB-FD663F28E089}
// *********************************************************************//
  ICalcprocVariantDisp = dispinterface
    ['{D4FFCBB0-7C1D-4C87-92EB-FD663F28E089}']
    property CalcprocTasks: IUnknown readonly dispid 201;
    property TaskTokens: IUnknown readonly dispid 202;
    procedure Prepare; dispid 203;
    property Step: Double readonly dispid 204;
    procedure RebuildPluralTree; dispid 205;
  end;

// *********************************************************************//
// Interface: ICalcsysModel
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B5A08F34-BC61-4BC0-86CC-FF28A80462C4}
// *********************************************************************//
  ICalcsysModel = interface(IDispatch)
    ['{B5A08F34-BC61-4BC0-86CC-FF28A80462C4}']
  end;

// *********************************************************************//
// DispIntf:  ICalcsysModelDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B5A08F34-BC61-4BC0-86CC-FF28A80462C4}
// *********************************************************************//
  ICalcsysModelDisp = dispinterface
    ['{B5A08F34-BC61-4BC0-86CC-FF28A80462C4}']
  end;

// *********************************************************************//
// Interface: ICalcsysState
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {36EC000B-B971-445B-8E31-185754F7E40D}
// *********************************************************************//
  ICalcsysState = interface(IDispatch)
    ['{36EC000B-B971-445B-8E31-185754F7E40D}']
  end;

// *********************************************************************//
// DispIntf:  ICalcsysStateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {36EC000B-B971-445B-8E31-185754F7E40D}
// *********************************************************************//
  ICalcsysStateDisp = dispinterface
    ['{36EC000B-B971-445B-8E31-185754F7E40D}']
  end;

// *********************************************************************//
// Interface: IAnalysisVariant
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A8591594-D5FD-474C-9027-7177C7FB4B16}
// *********************************************************************//
  IAnalysisVariant = interface(IDispatch)
    ['{A8591594-D5FD-474C-9027-7177C7FB4B16}']
    function Get_CalcsysState: IUnknown; safecall;
    function Get_CalcprocVariant: IUnknown; safecall;
    procedure InitAnalysis; safecall;
    function Get_BaseAnalysisVariant: IUnknown; safecall;
    procedure Set_BaseAnalysisVariant(const Value: IUnknown); safecall;
    function Get_UserDefinedCalculateTime: WordBool; safecall;
    procedure CalcSystemEfficiency; safecall;
    function Get_IterationCount: SYSINT; safecall;
    property CalcsysState: IUnknown read Get_CalcsysState;
    property CalcprocVariant: IUnknown read Get_CalcprocVariant;
    property BaseAnalysisVariant: IUnknown read Get_BaseAnalysisVariant write Set_BaseAnalysisVariant;
    property UserDefinedCalculateTime: WordBool read Get_UserDefinedCalculateTime;
    property IterationCount: SYSINT read Get_IterationCount;
  end;

// *********************************************************************//
// DispIntf:  IAnalysisVariantDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A8591594-D5FD-474C-9027-7177C7FB4B16}
// *********************************************************************//
  IAnalysisVariantDisp = dispinterface
    ['{A8591594-D5FD-474C-9027-7177C7FB4B16}']
    property CalcsysState: IUnknown readonly dispid 201;
    property CalcprocVariant: IUnknown readonly dispid 202;
    procedure InitAnalysis; dispid 203;
    property BaseAnalysisVariant: IUnknown dispid 204;
    property UserDefinedCalculateTime: WordBool readonly dispid 205;
    procedure CalcSystemEfficiency; dispid 206;
    property IterationCount: SYSINT readonly dispid 207;
  end;

// *********************************************************************//
// Interface: ICalcsysSubState
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7375D1D6-D07B-4612-B9A9-90248A21A24C}
// *********************************************************************//
  ICalcsysSubState = interface(IDispatch)
    ['{7375D1D6-D07B-4612-B9A9-90248A21A24C}']
  end;

// *********************************************************************//
// DispIntf:  ICalcsysSubStateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7375D1D6-D07B-4612-B9A9-90248A21A24C}
// *********************************************************************//
  ICalcsysSubStateDisp = dispinterface
    ['{7375D1D6-D07B-4612-B9A9-90248A21A24C}']
  end;

// *********************************************************************//
// Interface: ICalcprocSub
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {825F8D95-534D-44A6-B559-CEEE99C6D5D9}
// *********************************************************************//
  ICalcprocSub = interface(IDispatch)
    ['{825F8D95-534D-44A6-B559-CEEE99C6D5D9}']
    function GetLawValue(aValue: Double): Double; safecall;
    function Get_Prev: IUnknown; safecall;
    procedure Set_Prev(const Value: IUnknown); safecall;
    function Get_Next: IUnknown; safecall;
    procedure Set_Next(const Value: IUnknown); safecall;
    function Get_BackLink: SYSINT; safecall;
    procedure Set_BackLink(Value: SYSINT); safecall;
    function Get_ForwardLink: SYSINT; safecall;
    procedure Set_ForwardLink(Value: SYSINT); safecall;
    function Get_TokenElement: IUnknown; safecall;
    function Get_CalcprocSubs: IUnknown; safecall;
    property Prev: IUnknown read Get_Prev write Set_Prev;
    property Next: IUnknown read Get_Next write Set_Next;
    property BackLink: SYSINT read Get_BackLink write Set_BackLink;
    property ForwardLink: SYSINT read Get_ForwardLink write Set_ForwardLink;
    property TokenElement: IUnknown read Get_TokenElement;
    property CalcprocSubs: IUnknown read Get_CalcprocSubs;
  end;

// *********************************************************************//
// DispIntf:  ICalcprocSubDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {825F8D95-534D-44A6-B559-CEEE99C6D5D9}
// *********************************************************************//
  ICalcprocSubDisp = dispinterface
    ['{825F8D95-534D-44A6-B559-CEEE99C6D5D9}']
    function GetLawValue(aValue: Double): Double; dispid 201;
    property Prev: IUnknown dispid 202;
    property Next: IUnknown dispid 203;
    property BackLink: SYSINT dispid 204;
    property ForwardLink: SYSINT dispid 205;
    property TokenElement: IUnknown readonly dispid 1;
    property CalcprocSubs: IUnknown readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ITMState
// Flags:     (320) Dual OleAutomation
// GUID:      {28D5D127-D9A9-4CF8-81DF-5BEE7F30ADEE}
// *********************************************************************//
  ITMState = interface(IUnknown)
    ['{28D5D127-D9A9-4CF8-81DF-5BEE7F30ADEE}']
    function Get_CurrentAnalysisVariantU: IUnknown; safecall;
    procedure Set_CurrentAnalysisVariantU(const Value: IUnknown); safecall;
    property CurrentAnalysisVariantU: IUnknown read Get_CurrentAnalysisVariantU write Set_CurrentAnalysisVariantU;
  end;

// *********************************************************************//
// DispIntf:  ITMStateDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {28D5D127-D9A9-4CF8-81DF-5BEE7F30ADEE}
// *********************************************************************//
  ITMStateDisp = dispinterface
    ['{28D5D127-D9A9-4CF8-81DF-5BEE7F30ADEE}']
    property CurrentAnalysisVariantU: IUnknown dispid 101;
  end;

// *********************************************************************//
// Interface: ICalcprocTask
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D1135ED1-E622-4645-9A85-B0C893C15AF2}
// *********************************************************************//
  ICalcprocTask = interface(IDispatch)
    ['{D1135ED1-E622-4645-9A85-B0C893C15AF2}']
    procedure Prepare(const aTasks: IUnknown; var pPrev: IUnknown); safecall;
  end;

// *********************************************************************//
// DispIntf:  ICalcprocTaskDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D1135ED1-E622-4645-9A85-B0C893C15AF2}
// *********************************************************************//
  ICalcprocTaskDisp = dispinterface
    ['{D1135ED1-E622-4645-9A85-B0C893C15AF2}']
    procedure Prepare(const aTasks: IUnknown; var pPrev: IUnknown); dispid 1;
  end;

// *********************************************************************//
// Interface: IChanging
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72B4CDA1-5FDC-11DA-9B48-0050BA51A6D3}
// *********************************************************************//
  IChanging = interface(IDispatch)
    ['{72B4CDA1-5FDC-11DA-9B48-0050BA51A6D3}']
    function Get_IsActive: WordBool; safecall;
    procedure Set_IsActive(Value: WordBool); safecall;
    function Get_Token: IUnknown; safecall;
    procedure Set_Token(const Value: IUnknown); safecall;
    function Get_Name: WideString; safecall;
    function Get_SMLabel: IUnknown; safecall;
    procedure Set_SMLabel(const Value: IUnknown); safecall;
    function Get_LabelVisible: WordBool; safecall;
    procedure Set_LabelVisible(Value: WordBool); safecall;
    function Get_C0: IUnknown; safecall;
    procedure Set_C0(const Value: IUnknown); safecall;
    function Get_C1: IUnknown; safecall;
    procedure Set_C1(const Value: IUnknown); safecall;
    property IsActive: WordBool read Get_IsActive write Set_IsActive;
    property Token: IUnknown read Get_Token write Set_Token;
    property Name: WideString read Get_Name;
    property SMLabel: IUnknown read Get_SMLabel write Set_SMLabel;
    property LabelVisible: WordBool read Get_LabelVisible write Set_LabelVisible;
    property C0: IUnknown read Get_C0 write Set_C0;
    property C1: IUnknown read Get_C1 write Set_C1;
  end;

// *********************************************************************//
// DispIntf:  IChangingDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72B4CDA1-5FDC-11DA-9B48-0050BA51A6D3}
// *********************************************************************//
  IChangingDisp = dispinterface
    ['{72B4CDA1-5FDC-11DA-9B48-0050BA51A6D3}']
    property IsActive: WordBool dispid 2;
    property Token: IUnknown dispid 4;
    property Name: WideString readonly dispid 8;
    property SMLabel: IUnknown dispid 1;
    property LabelVisible: WordBool dispid 3;
    property C0: IUnknown dispid 5;
    property C1: IUnknown dispid 6;
  end;

// *********************************************************************//
// The Class CoTransnet provides a Create and CreateRemote method to          
// create instances of the default interface ITransnet exposed by              
// the CoClass Transnet. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTransnet = class
    class function Create: ITransnet;
    class function CreateRemote(const MachineName: string): ITransnet;
  end;

implementation

uses ComObj;

class function CoTransnet.Create: ITransnet;
begin
  Result := CreateComObject(CLASS_Transnet) as ITransnet;
end;

class function CoTransnet.CreateRemote(const MachineName: string): ITransnet;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Transnet) as ITransnet;
end;

end.
