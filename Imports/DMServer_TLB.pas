unit DMServer_TLB;

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
// File generated on 16.03.2007 13:55:47 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\AutoDM\bin\DMServerLib.dll (1)
// LIBID: {5648DD20-C6D0-11D4-845E-A2D7FAE1C81C}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
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
  DMServerMajorVersion = 1;
  DMServerMinorVersion = 0;

  LIBID_DMServer: TGUID = '{5648DD20-C6D0-11D4-845E-A2D7FAE1C81C}';

  IID_IDataModelServer: TGUID = '{5648DD27-C6D0-11D4-845E-A2D7FAE1C80C}';
  IID_IDMOperationManager: TGUID = '{A236FCC2-D90A-11D4-845E-D13F35BFA812}';
  IID_IDMCopyBuffer: TGUID = '{8AE31BA2-E687-11D4-845E-90A79423760B}';
  DIID_IDataModelServerEvents: TGUID = '{16EE0285-4C96-11D5-845E-8E92F733EA08}';
  IID_IDMDocument: TGUID = '{16EE0281-4C96-11D5-845E-8E92F733EA08}';
  CLASS_DMDocument: TGUID = '{16EE0283-4C96-11D5-845E-8E92F733EA08}';
  CLASS_DataModelServer: TGUID = '{5F557360-EE35-11D4-845E-C8EF7B9C9D0E}';
  IID_IDMServerEvents: TGUID = '{D389FF6B-4CE8-41A1-B46A-20B1A17B3E0F}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum DMDocumentStateFlag
type
  DMDocumentStateFlag = TOleEnum;
const
  dmfNotEmpty = $00000001;
  dmfModified = $00000002;
  dmfCanUndo = $00000004;
  dmfCanRedo = $00000008;
  dmfLoading = $00000010;
  dmfCommiting = $00000020;
  dmfRollBacking = $00000040;
  dmfExecuting = $00000080;
  dmfDemo = $00000100;
  dmfCopying = $00000200;
  dmfSelecting = $00000400;
  dmfDestroying = $00000800;
  dmfChanging = $00001000;
  dmfAuto = $00002000;
  dmfFrozen = $00004000;
  dmfLoadingTransactions = $00008000;
  dmfLongOperation = $00010000;

// Constants for enum TBaseOperation
type
  TBaseOperation = TOleEnum;
const
  boCreateElement = $00000000;
  boDestroyElement = $00000001;
  boSetParent = $00000002;
  boSetRef = $00000003;
  boAddParent = $00000004;
  boRemoveParent = $00000005;
  boRename = $00000006;
  boChangeFieldValue = $00000007;
  boMoveElement = $00000008;
  boUpdateElement = $00000009;
  boUpdateCoords = $0000000A;

// Constants for enum TDialogMode
type
  TDialogMode = TOleEnum;
const
  sdmIntegerInput = $00000000;
  sdmDeleteConfirm = $00000001;
  sdmShowMessage = $00000002;
  sdmFloatInput = $00000003;
  sdmInputQuery = $00000004;
  sdmConfirmation = $00000005;
  sdmPleaseWait = $00000006;
  sdmColorInput = $00000007;

// Constants for enum TRefreshFlag
type
  TRefreshFlag = TOleEnum;
const
  rfData = $00000001;
  rfFast = $00000002;
  rfBack = $00000004;
  rfFastBack = $00000006;
  rfFront = $00000008;
  rfFrontBack = $0000000C;
  rfAll = $0000000D;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDataModelServer = interface;
  IDataModelServerDisp = dispinterface;
  IDMOperationManager = interface;
  IDMOperationManagerDisp = dispinterface;
  IDMCopyBuffer = interface;
  IDMCopyBufferDisp = dispinterface;
  IDataModelServerEvents = dispinterface;
  IDMDocument = interface;
  IDMDocumentDisp = dispinterface;
  IDMServerEvents = interface;
  IDMServerEventsDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMDocument = IDMDocument;
  DataModelServer = IDataModelServer;


// *********************************************************************//
// Interface: IDataModelServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5648DD27-C6D0-11D4-845E-A2D7FAE1C80C}
// *********************************************************************//
  IDataModelServer = interface(IDispatch)
    ['{5648DD27-C6D0-11D4-845E-A2D7FAE1C80C}']
    function Get_ProgID: WideString; safecall;
    procedure Set_ProgID(const Value: WideString); safecall;
    procedure CloseAll; safecall;
    function Get_DataModelAlias: WideString; safecall;
    procedure Set_DataModelAlias(const Value: WideString); safecall;
    function Get_DataModelFileExt: WideString; safecall;
    procedure Set_DataModelFileExt(const Value: WideString); safecall;
    function Get_DocumentCount: Integer; safecall;
    function Get_Document(Index: Integer): IDMDocument; safecall;
    function Get_CurrentDocumentIndex: Integer; safecall;
    procedure Set_CurrentDocumentIndex(Value: Integer); safecall;
    procedure CloseCurrentDocument; safecall;
    procedure CreateNewDataModel(const RefDataModelU: IUnknown); safecall;
    function LoadDataModel(const FileName: WideString; const Password: WideString; 
                           const RefDataModelU: IUnknown): WordBool; safecall;
    procedure SaveDataModel(const FileName: WideString); safecall;
    procedure ExportDataModel(const FileName: WideString; ExportMode: Integer); safecall;
    procedure ImportDataModel(const FileName: WideString; ImportMode: Integer); safecall;
    function Get_CurrentDocument: IDMDocument; safecall;
    procedure DocumentOperation(const ElementsV: IUnknown; const CollectionV: IUnknown; 
                                DMOperation: Integer; nItemIndex: Integer); safecall;
    function Get_DocumentProgID: WideString; safecall;
    procedure Set_DocumentProgID(const Value: WideString); safecall;
    procedure OpenDocument; safecall;
    procedure RefreshDocument(FlagSet: Integer); safecall;
    procedure SelectionChanged(const ElementU: IUnknown); safecall;
    procedure CallRefDialog(const DMClassCollectionsU: IUnknown; const RefSourceU: IUnknown; 
                            const Suffix: WideString; AskName: WordBool); safecall;
    function Get_EventData1: OleVariant; safecall;
    procedure Set_EventData1(Value: OleVariant); safecall;
    function Get_EventData2: OleVariant; safecall;
    procedure Set_EventData2(Value: OleVariant); safecall;
    function Get_EventData3: OleVariant; safecall;
    procedure Set_EventData3(Value: OleVariant); safecall;
    procedure SetControlState(ControlIndex: Integer; Index: Integer; Mode: Integer; State: Integer); safecall;
    procedure OperationStepExecuted; safecall;
    function Get_AnalyzerProgID: WideString; safecall;
    procedure Set_AnalyzerProgID(const Value: WideString); safecall;
    procedure StartAnalysis(Mode: Integer); safecall;
    procedure StopAnalysis; safecall;
    procedure NextAnalysisStep(Step: Integer); safecall;
    procedure NextAnalysisStage(const StageName: WideString; Stage: Integer; StepCount: Integer); safecall;
    procedure CallDialog(Mode: Integer; const Caption: WideString; const Prompt: WideString); safecall;
    procedure ChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown); safecall;
    function Get_InitialDir: WideString; safecall;
    procedure Set_InitialDir(const Value: WideString); safecall;
    procedure NextLoadStage(const StageName: WideString; Stage: Integer; StepCount: Integer); safecall;
    procedure RefreshElement(const ElementU: IUnknown); safecall;
    function Get_Events: IDMServerEvents; safecall;
    procedure Set_Events(const Value: IDMServerEvents); safecall;
    procedure AnalysisError(const ErrorMessage: WideString); safecall;
    property ProgID: WideString read Get_ProgID write Set_ProgID;
    property DataModelAlias: WideString read Get_DataModelAlias write Set_DataModelAlias;
    property DataModelFileExt: WideString read Get_DataModelFileExt write Set_DataModelFileExt;
    property DocumentCount: Integer read Get_DocumentCount;
    property Document[Index: Integer]: IDMDocument read Get_Document;
    property CurrentDocumentIndex: Integer read Get_CurrentDocumentIndex write Set_CurrentDocumentIndex;
    property CurrentDocument: IDMDocument read Get_CurrentDocument;
    property DocumentProgID: WideString read Get_DocumentProgID write Set_DocumentProgID;
    property EventData1: OleVariant read Get_EventData1 write Set_EventData1;
    property EventData2: OleVariant read Get_EventData2 write Set_EventData2;
    property EventData3: OleVariant read Get_EventData3 write Set_EventData3;
    property AnalyzerProgID: WideString read Get_AnalyzerProgID write Set_AnalyzerProgID;
    property InitialDir: WideString read Get_InitialDir write Set_InitialDir;
    property Events: IDMServerEvents read Get_Events write Set_Events;
  end;

// *********************************************************************//
// DispIntf:  IDataModelServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5648DD27-C6D0-11D4-845E-A2D7FAE1C80C}
// *********************************************************************//
  IDataModelServerDisp = dispinterface
    ['{5648DD27-C6D0-11D4-845E-A2D7FAE1C80C}']
    property ProgID: WideString dispid 2;
    procedure CloseAll; dispid 3;
    property DataModelAlias: WideString dispid 5;
    property DataModelFileExt: WideString dispid 6;
    property DocumentCount: Integer readonly dispid 1;
    property Document[Index: Integer]: IDMDocument readonly dispid 4;
    property CurrentDocumentIndex: Integer dispid 7;
    procedure CloseCurrentDocument; dispid 8;
    procedure CreateNewDataModel(const RefDataModelU: IUnknown); dispid 9;
    function LoadDataModel(const FileName: WideString; const Password: WideString; 
                           const RefDataModelU: IUnknown): WordBool; dispid 10;
    procedure SaveDataModel(const FileName: WideString); dispid 11;
    procedure ExportDataModel(const FileName: WideString; ExportMode: Integer); dispid 12;
    procedure ImportDataModel(const FileName: WideString; ImportMode: Integer); dispid 13;
    property CurrentDocument: IDMDocument readonly dispid 14;
    procedure DocumentOperation(const ElementsV: IUnknown; const CollectionV: IUnknown; 
                                DMOperation: Integer; nItemIndex: Integer); dispid 15;
    property DocumentProgID: WideString dispid 16;
    procedure OpenDocument; dispid 17;
    procedure RefreshDocument(FlagSet: Integer); dispid 18;
    procedure SelectionChanged(const ElementU: IUnknown); dispid 19;
    procedure CallRefDialog(const DMClassCollectionsU: IUnknown; const RefSourceU: IUnknown; 
                            const Suffix: WideString; AskName: WordBool); dispid 20;
    property EventData1: OleVariant dispid 21;
    property EventData2: OleVariant dispid 22;
    property EventData3: OleVariant dispid 24;
    procedure SetControlState(ControlIndex: Integer; Index: Integer; Mode: Integer; State: Integer); dispid 23;
    procedure OperationStepExecuted; dispid 25;
    property AnalyzerProgID: WideString dispid 26;
    procedure StartAnalysis(Mode: Integer); dispid 28;
    procedure StopAnalysis; dispid 29;
    procedure NextAnalysisStep(Step: Integer); dispid 27;
    procedure NextAnalysisStage(const StageName: WideString; Stage: Integer; StepCount: Integer); dispid 30;
    procedure CallDialog(Mode: Integer; const Caption: WideString; const Prompt: WideString); dispid 31;
    procedure ChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown); dispid 32;
    property InitialDir: WideString dispid 33;
    procedure NextLoadStage(const StageName: WideString; Stage: Integer; StepCount: Integer); dispid 34;
    procedure RefreshElement(const ElementU: IUnknown); dispid 35;
    property Events: IDMServerEvents dispid 36;
    procedure AnalysisError(const ErrorMessage: WideString); dispid 37;
  end;

// *********************************************************************//
// Interface: IDMOperationManager
// Flags:     (320) Dual OleAutomation
// GUID:      {A236FCC2-D90A-11D4-845E-D13F35BFA812}
// *********************************************************************//
  IDMOperationManager = interface(IUnknown)
    ['{A236FCC2-D90A-11D4-845E-D13F35BFA812}']
    procedure AddElement(const ParentElementU: IUnknown; const CollectionU: IUnknown; 
                         const aName: WideString; aLinkType: Integer; out aElementU: IUnknown; 
                         SetParentFlag: WordBool); safecall;
    procedure DeleteElement(const ParentElementU: IUnknown; const ColectionU: IUnknown; 
                            aLinkType: Integer; const aElementU: IUnknown); safecall;
    procedure AddElementRef(const ParentElementU: IUnknown; const CollectionU: IUnknown; 
                            const aName: WideString; const aRefU: IUnknown; aLinkType: Integer; 
                            out aElementU: IUnknown; SetParentFlag: WordBool); safecall;
    procedure AddDeleteElements(const ParentElementU: IUnknown; const DestCollectionU: IUnknown; 
                                const SourceCollectionU: IUnknown; aLinkType: Integer); safecall;
    procedure AddDeleteRefs(const ParentElementU: IUnknown; const SourceCollectionU: IUnknown; 
                            const DestCollectionU: IUnknown; const RefSourceU: IUnknown; 
                            const RefDocumentU: IDMDocument); safecall;
    procedure ChangeRef(const CollectionU: IUnknown; const aName: WideString; 
                        const aRefU: IUnknown; const aElementU: IUnknown); safecall;
    procedure Undo; safecall;
    procedure Redo; safecall;
    procedure RenameElement(const aElementU: IUnknown; const NewName: WideString); safecall;
    procedure ChangeFieldValue(const aElementU: IUnknown; FieldIndex: Integer; 
                               FieldByCode: WordBool; Value: OleVariant); safecall;
    procedure _AddElementRef(const ClassCollectionU: IUnknown; const ParentElementU: IUnknown; 
                             const CollectionU: IUnknown; const aName: WideString; 
                             const aRefU: IUnknown; aLinkType: Integer; out aElementU: IUnknown; 
                             SetParentFlag: WordBool); safecall;
    procedure _AddElement(const ClassCollectionU: IUnknown; const ParentElementU: IUnknown; 
                          const CollectionU: IUnknown; const aName: WideString; aLinkType: Integer; 
                          out aElementU: IUnknown; SetParentFlag: WordBool); safecall;
    procedure ChangeParent(const CollectionU: IUnknown; const aParentU: IUnknown; 
                           const aElementU: IUnknown); safecall;
    procedure ClearElement(const aElementU: IUnknown); safecall;
    procedure StartTransaction(const CollectionU: IUnknown; DMOperation: Integer; 
                               const TransactionName: WideString); safecall;
    procedure CommitTransaction(const ElementU: IUnknown; const CollectionU: IUnknown; 
                                DMOperation: Integer); safecall;
    procedure PasteToElement(const SourceElementU: IUnknown; const DestElementU: IUnknown; 
                             CopySpatialElementFlag: WordBool; LowerLevelPaste: WordBool); safecall;
    procedure PasteToCollection(const ParentElementU: IUnknown; const SourceElementU: IUnknown; 
                                const DestCollectionU: IUnknown; aLinkType: Integer; 
                                out aElementU: IUnknown); safecall;
    procedure AddElementParent(const ParentElementU: IUnknown; const aElementU: IUnknown); safecall;
    procedure MoveElement(const CollectionU: IUnknown; const aElementU: IUnknown; 
                          NewIndex: Integer; MoveInOwnerCollection: WordBool); safecall;
    procedure RemoveElementParent(const ParenrElementU: IUnknown; const aElementU: IUnknown); safecall;
    procedure UpdateElement(const aElementU: IUnknown); safecall;
    procedure FinishTransaction(const ElementsV: IUnknown; const CollectionV: IUnknown; 
                                DMOperation: Integer); safecall;
    function Get_TransactionCount: Integer; safecall;
    function Get_TransactionName(Index: Integer): WideString; safecall;
    procedure SaveTransactions(const FileName: WideString); safecall;
    procedure LoadTransactions(const FileName: WideString); safecall;
    function Get_CurrentTransactionIndex: Integer; safecall;
    procedure DeleteElements(const Collection: IUnknown; ConfirmFlag: WordBool); safecall;
    function CreateClone(const aElement: IUnknown): IUnknown; safecall;
    procedure UpdateCoords(const aElementU: IUnknown); safecall;
    function Get_SourceCollection: IUnknown; safecall;
    function Get_DestCollection: IUnknown; safecall;
    procedure OnCreateRefElement(ClassID: Integer; const RefElementU: IUnknown); safecall;
    property TransactionCount: Integer read Get_TransactionCount;
    property TransactionName[Index: Integer]: WideString read Get_TransactionName;
    property CurrentTransactionIndex: Integer read Get_CurrentTransactionIndex;
    property SourceCollection: IUnknown read Get_SourceCollection;
    property DestCollection: IUnknown read Get_DestCollection;
  end;

// *********************************************************************//
// DispIntf:  IDMOperationManagerDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {A236FCC2-D90A-11D4-845E-D13F35BFA812}
// *********************************************************************//
  IDMOperationManagerDisp = dispinterface
    ['{A236FCC2-D90A-11D4-845E-D13F35BFA812}']
    procedure AddElement(const ParentElementU: IUnknown; const CollectionU: IUnknown; 
                         const aName: WideString; aLinkType: Integer; out aElementU: IUnknown; 
                         SetParentFlag: WordBool); dispid 1;
    procedure DeleteElement(const ParentElementU: IUnknown; const ColectionU: IUnknown; 
                            aLinkType: Integer; const aElementU: IUnknown); dispid 2;
    procedure AddElementRef(const ParentElementU: IUnknown; const CollectionU: IUnknown; 
                            const aName: WideString; const aRefU: IUnknown; aLinkType: Integer; 
                            out aElementU: IUnknown; SetParentFlag: WordBool); dispid 3;
    procedure AddDeleteElements(const ParentElementU: IUnknown; const DestCollectionU: IUnknown; 
                                const SourceCollectionU: IUnknown; aLinkType: Integer); dispid 4;
    procedure AddDeleteRefs(const ParentElementU: IUnknown; const SourceCollectionU: IUnknown; 
                            const DestCollectionU: IUnknown; const RefSourceU: IUnknown; 
                            const RefDocumentU: IDMDocument); dispid 5;
    procedure ChangeRef(const CollectionU: IUnknown; const aName: WideString; 
                        const aRefU: IUnknown; const aElementU: IUnknown); dispid 6;
    procedure Undo; dispid 8;
    procedure Redo; dispid 9;
    procedure RenameElement(const aElementU: IUnknown; const NewName: WideString); dispid 7;
    procedure ChangeFieldValue(const aElementU: IUnknown; FieldIndex: Integer; 
                               FieldByCode: WordBool; Value: OleVariant); dispid 10;
    procedure _AddElementRef(const ClassCollectionU: IUnknown; const ParentElementU: IUnknown; 
                             const CollectionU: IUnknown; const aName: WideString; 
                             const aRefU: IUnknown; aLinkType: Integer; out aElementU: IUnknown; 
                             SetParentFlag: WordBool); dispid 11;
    procedure _AddElement(const ClassCollectionU: IUnknown; const ParentElementU: IUnknown; 
                          const CollectionU: IUnknown; const aName: WideString; aLinkType: Integer; 
                          out aElementU: IUnknown; SetParentFlag: WordBool); dispid 12;
    procedure ChangeParent(const CollectionU: IUnknown; const aParentU: IUnknown; 
                           const aElementU: IUnknown); dispid 13;
    procedure ClearElement(const aElementU: IUnknown); dispid 14;
    procedure StartTransaction(const CollectionU: IUnknown; DMOperation: Integer; 
                               const TransactionName: WideString); dispid 15;
    procedure CommitTransaction(const ElementU: IUnknown; const CollectionU: IUnknown; 
                                DMOperation: Integer); dispid 16;
    procedure PasteToElement(const SourceElementU: IUnknown; const DestElementU: IUnknown; 
                             CopySpatialElementFlag: WordBool; LowerLevelPaste: WordBool); dispid 17;
    procedure PasteToCollection(const ParentElementU: IUnknown; const SourceElementU: IUnknown; 
                                const DestCollectionU: IUnknown; aLinkType: Integer; 
                                out aElementU: IUnknown); dispid 18;
    procedure AddElementParent(const ParentElementU: IUnknown; const aElementU: IUnknown); dispid 19;
    procedure MoveElement(const CollectionU: IUnknown; const aElementU: IUnknown; 
                          NewIndex: Integer; MoveInOwnerCollection: WordBool); dispid 20;
    procedure RemoveElementParent(const ParenrElementU: IUnknown; const aElementU: IUnknown); dispid 21;
    procedure UpdateElement(const aElementU: IUnknown); dispid 22;
    procedure FinishTransaction(const ElementsV: IUnknown; const CollectionV: IUnknown; 
                                DMOperation: Integer); dispid 23;
    property TransactionCount: Integer readonly dispid 24;
    property TransactionName[Index: Integer]: WideString readonly dispid 25;
    procedure SaveTransactions(const FileName: WideString); dispid 26;
    procedure LoadTransactions(const FileName: WideString); dispid 27;
    property CurrentTransactionIndex: Integer readonly dispid 28;
    procedure DeleteElements(const Collection: IUnknown; ConfirmFlag: WordBool); dispid 29;
    function CreateClone(const aElement: IUnknown): IUnknown; dispid 30;
    procedure UpdateCoords(const aElementU: IUnknown); dispid 31;
    property SourceCollection: IUnknown readonly dispid 32;
    property DestCollection: IUnknown readonly dispid 33;
    procedure OnCreateRefElement(ClassID: Integer; const RefElementU: IUnknown); dispid 34;
  end;

// *********************************************************************//
// Interface: IDMCopyBuffer
// Flags:     (320) Dual OleAutomation
// GUID:      {8AE31BA2-E687-11D4-845E-90A79423760B}
// *********************************************************************//
  IDMCopyBuffer = interface(IUnknown)
    ['{8AE31BA2-E687-11D4-845E-90A79423760B}']
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Paste(const ParentElementU: IUnknown; const CollectionU: IUnknown; 
                    aLinkType: Integer; DoPaste: WordBool; out CanPaste: WordBool); safecall;
    function Get_BufferCount: Integer; safecall;
    function Get_Buffer(Index: Integer): IUnknown; safecall;
    function Get_LastCopy(Index: Integer): IUnknown; safecall;
    function Get_LastCopyCount: Integer; safecall;
    property BufferCount: Integer read Get_BufferCount;
    property Buffer[Index: Integer]: IUnknown read Get_Buffer;
    property LastCopy[Index: Integer]: IUnknown read Get_LastCopy;
    property LastCopyCount: Integer read Get_LastCopyCount;
  end;

// *********************************************************************//
// DispIntf:  IDMCopyBufferDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {8AE31BA2-E687-11D4-845E-90A79423760B}
// *********************************************************************//
  IDMCopyBufferDisp = dispinterface
    ['{8AE31BA2-E687-11D4-845E-90A79423760B}']
    procedure Cut; dispid 1;
    procedure Copy; dispid 2;
    procedure Paste(const ParentElementU: IUnknown; const CollectionU: IUnknown; 
                    aLinkType: Integer; DoPaste: WordBool; out CanPaste: WordBool); dispid 3;
    property BufferCount: Integer readonly dispid 4;
    property Buffer[Index: Integer]: IUnknown readonly dispid 5;
    property LastCopy[Index: Integer]: IUnknown readonly dispid 6;
    property LastCopyCount: Integer readonly dispid 7;
  end;

// *********************************************************************//
// DispIntf:  IDataModelServerEvents
// Flags:     (4096) Dispatchable
// GUID:      {16EE0285-4C96-11D5-845E-8E92F733EA08}
// *********************************************************************//
  IDataModelServerEvents = dispinterface
    ['{16EE0285-4C96-11D5-845E-8E92F733EA08}']
    procedure OnOpenDocument; dispid 1;
    procedure OnDocumentOperation(const ElementsV: IUnknown; const CollectionV: IUnknown; 
                                  DMOperation: Integer; nItemIndex: Integer); dispid 2;
    procedure OnCloseDocument; dispid 3;
    procedure OnCreateDocument; dispid 4;
    procedure OnRefreshDocument(FlagSet: Integer); dispid 5;
    procedure OnSelectionChanged(const ElementU: IUnknown); dispid 6;
    procedure OnCallRefDialog(const DMClassCollectionsU: IUnknown; const RefSourceU: IUnknown; 
                              const Suffix: WideString; AskName: WordBool); dispid 7;
    procedure OnSetControlState(ControlIndex: Integer; Index: Integer; Mode: Integer; State: Integer); dispid 9;
    procedure OnOperationStepExecuted; dispid 8;
    procedure OnNextAnalysisStep(Step: Integer); dispid 10;
    procedure OnNextAnalysisStage(const StageName: WideString; Stage: Integer; StepCount: Integer); dispid 11;
    procedure OnCallDialog(Mode: Integer; const Caption: WideString; const Prompt: WideString); dispid 12;
    procedure OnChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown); dispid 13;
    procedure OnNextLoadStage(const StageName: WideString; Stage: Integer; StepCount: Integer); dispid 14;
    procedure OnStopAnalysis; dispid 15;
    procedure OnRefreshElement(const ElementU: IUnknown); dispid 16;
  end;

// *********************************************************************//
// Interface: IDMDocument
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {16EE0281-4C96-11D5-845E-8E92F733EA08}
// *********************************************************************//
  IDMDocument = interface(IDispatch)
    ['{16EE0281-4C96-11D5-845E-8E92F733EA08}']
    function Get_DataModel: IUnknown; safecall;
    procedure Set_DataModel(const Value: IUnknown); safecall;
    function Get_CurrentElement: IUnknown; safecall;
    procedure Set_CurrentElement(const Value: IUnknown); safecall;
    function Get_ChangeCount: Integer; safecall;
    procedure IncChangeCount; safecall;
    procedure DecChangeCount; safecall;
    procedure ResetChangeCount; safecall;
    function Get_SelectionCount: Integer; safecall;
    function Get_SelectionItem(Index: Integer): IUnknown; safecall;
    procedure ClearSelection(const ExceptedElementU: IUnknown); safecall;
    function Get_State: Integer; safecall;
    procedure Set_State(Value: Integer); safecall;
    function Get_Server: IDataModelServer; safecall;
    procedure Set_Server(const Value: IDataModelServer); safecall;
    procedure Select(const ElementU: IUnknown); safecall;
    procedure Unselect(const ElementU: IUnknown); safecall;
    function Get_Hint: WideString; safecall;
    function Get_Cursor: Integer; safecall;
    function Get_Analyzer: IUnknown; safecall;
    procedure Set_Analyzer(const Value: IUnknown); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;
    function Get_CurrentElementID: Integer; safecall;
    procedure Set_CurrentElementID(Value: Integer); safecall;
    function Get_CurrentElementClassID: Integer; safecall;
    procedure Set_CurrentElementClassID(Value: Integer); safecall;
    function Get_CurrentCollectionIndex: Integer; safecall;
    procedure Set_CurrentCollectionIndex(Value: Integer); safecall;
    function Get_CurrentObjectExpanded: Integer; safecall;
    procedure Set_CurrentObjectExpanded(Value: Integer); safecall;
    function Get_TopElementID: Integer; safecall;
    procedure Set_TopElementID(Value: Integer); safecall;
    function Get_TopElementClassID: Integer; safecall;
    procedure Set_TopElementClassID(Value: Integer); safecall;
    function Get_TopCollectionIndex: Integer; safecall;
    procedure Set_TopCollectionIndex(Value: Integer); safecall;
    procedure UndoSelection; safecall;
    procedure ClearPrevSelection(ClearAll: WordBool); safecall;
    property DataModel: IUnknown read Get_DataModel write Set_DataModel;
    property CurrentElement: IUnknown read Get_CurrentElement write Set_CurrentElement;
    property ChangeCount: Integer read Get_ChangeCount;
    property SelectionCount: Integer read Get_SelectionCount;
    property SelectionItem[Index: Integer]: IUnknown read Get_SelectionItem;
    property State: Integer read Get_State write Set_State;
    property Server: IDataModelServer read Get_Server write Set_Server;
    property Hint: WideString read Get_Hint;
    property Cursor: Integer read Get_Cursor;
    property Analyzer: IUnknown read Get_Analyzer write Set_Analyzer;
    property Password: WideString read Get_Password write Set_Password;
    property CurrentElementID: Integer read Get_CurrentElementID write Set_CurrentElementID;
    property CurrentElementClassID: Integer read Get_CurrentElementClassID write Set_CurrentElementClassID;
    property CurrentCollectionIndex: Integer read Get_CurrentCollectionIndex write Set_CurrentCollectionIndex;
    property CurrentObjectExpanded: Integer read Get_CurrentObjectExpanded write Set_CurrentObjectExpanded;
    property TopElementID: Integer read Get_TopElementID write Set_TopElementID;
    property TopElementClassID: Integer read Get_TopElementClassID write Set_TopElementClassID;
    property TopCollectionIndex: Integer read Get_TopCollectionIndex write Set_TopCollectionIndex;
  end;

// *********************************************************************//
// DispIntf:  IDMDocumentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {16EE0281-4C96-11D5-845E-8E92F733EA08}
// *********************************************************************//
  IDMDocumentDisp = dispinterface
    ['{16EE0281-4C96-11D5-845E-8E92F733EA08}']
    property DataModel: IUnknown dispid 1;
    property CurrentElement: IUnknown dispid 2;
    property ChangeCount: Integer readonly dispid 3;
    procedure IncChangeCount; dispid 4;
    procedure DecChangeCount; dispid 5;
    procedure ResetChangeCount; dispid 6;
    property SelectionCount: Integer readonly dispid 7;
    property SelectionItem[Index: Integer]: IUnknown readonly dispid 9;
    procedure ClearSelection(const ExceptedElementU: IUnknown); dispid 14;
    property State: Integer dispid 8;
    property Server: IDataModelServer dispid 15;
    procedure Select(const ElementU: IUnknown); dispid 10;
    procedure Unselect(const ElementU: IUnknown); dispid 11;
    property Hint: WideString readonly dispid 12;
    property Cursor: Integer readonly dispid 13;
    property Analyzer: IUnknown dispid 17;
    property Password: WideString dispid 16;
    property CurrentElementID: Integer dispid 18;
    property CurrentElementClassID: Integer dispid 19;
    property CurrentCollectionIndex: Integer dispid 21;
    property CurrentObjectExpanded: Integer dispid 22;
    property TopElementID: Integer dispid 23;
    property TopElementClassID: Integer dispid 24;
    property TopCollectionIndex: Integer dispid 25;
    procedure UndoSelection; dispid 20;
    procedure ClearPrevSelection(ClearAll: WordBool); dispid 26;
  end;

// *********************************************************************//
// Interface: IDMServerEvents
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D389FF6B-4CE8-41A1-B46A-20B1A17B3E0F}
// *********************************************************************//
  IDMServerEvents = interface(IDispatch)
    ['{D389FF6B-4CE8-41A1-B46A-20B1A17B3E0F}']
    procedure OnOpenDocument; safecall;
    procedure OnDocumentOperation(const ElementsV: IUnknown; const CollectionV: IUnknown; 
                                  DMOperation: Integer; nItemIndex: Integer); safecall;
    procedure OnCloseDocument; safecall;
    procedure OnCreateDocument; safecall;
    procedure OnRefreshDocument(FlagSet: Integer); safecall;
    procedure OnSelectionChanged(const ElementU: IUnknown); safecall;
    procedure OnCallRefDialog(const DMClassCollectionsU: IUnknown; const RefSourceU: IUnknown; 
                              const Suffix: WideString; AskName: WordBool); safecall;
    procedure OnSetControlState(ControlIndex: Integer; Index: Integer; Mode: Integer; State: Integer); safecall;
    procedure OnOperationStepExecuted; safecall;
    procedure OnNextAnalysisStep(Step: Integer); safecall;
    procedure OnNextAnalysisStage(const StageName: WideString; Stage: Integer; StepCount: Integer); safecall;
    procedure OnCallDialog(Mode: Integer; const Caption: WideString; const Prompt: WideString); safecall;
    procedure OnChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown); safecall;
    procedure OnNextLoadStage(const StageName: WideString; Stage: Integer; StepCount: Integer); safecall;
    procedure OnStopAnalysis; safecall;
    procedure OnRefreshElement(const ElementU: IUnknown); safecall;
    procedure OnAnalysisError(const ErrorMessage: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMServerEventsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D389FF6B-4CE8-41A1-B46A-20B1A17B3E0F}
// *********************************************************************//
  IDMServerEventsDisp = dispinterface
    ['{D389FF6B-4CE8-41A1-B46A-20B1A17B3E0F}']
    procedure OnOpenDocument; dispid 1;
    procedure OnDocumentOperation(const ElementsV: IUnknown; const CollectionV: IUnknown; 
                                  DMOperation: Integer; nItemIndex: Integer); dispid 2;
    procedure OnCloseDocument; dispid 3;
    procedure OnCreateDocument; dispid 4;
    procedure OnRefreshDocument(FlagSet: Integer); dispid 5;
    procedure OnSelectionChanged(const ElementU: IUnknown); dispid 6;
    procedure OnCallRefDialog(const DMClassCollectionsU: IUnknown; const RefSourceU: IUnknown; 
                              const Suffix: WideString; AskName: WordBool); dispid 7;
    procedure OnSetControlState(ControlIndex: Integer; Index: Integer; Mode: Integer; State: Integer); dispid 8;
    procedure OnOperationStepExecuted; dispid 9;
    procedure OnNextAnalysisStep(Step: Integer); dispid 10;
    procedure OnNextAnalysisStage(const StageName: WideString; Stage: Integer; StepCount: Integer); dispid 11;
    procedure OnCallDialog(Mode: Integer; const Caption: WideString; const Prompt: WideString); dispid 12;
    procedure OnChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown); dispid 13;
    procedure OnNextLoadStage(const StageName: WideString; Stage: Integer; StepCount: Integer); dispid 14;
    procedure OnStopAnalysis; dispid 15;
    procedure OnRefreshElement(const ElementU: IUnknown); dispid 17;
    procedure OnAnalysisError(const ErrorMessage: WideString); dispid 16;
  end;

// *********************************************************************//
// The Class CoDMDocument provides a Create and CreateRemote method to          
// create instances of the default interface IDMDocument exposed by              
// the CoClass DMDocument. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDMDocument = class
    class function Create: IDMDocument;
    class function CreateRemote(const MachineName: string): IDMDocument;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDMDocument
// Help String      : 
// Default Interface: IDMDocument
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDMDocumentProperties= class;
{$ENDIF}
  TDMDocument = class(TOleServer)
  private
    FIntf:        IDMDocument;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDMDocumentProperties;
    function      GetServerProperties: TDMDocumentProperties;
{$ENDIF}
    function      GetDefaultInterface: IDMDocument;
  protected
    procedure InitServerData; override;
    function Get_DataModel: IUnknown;
    procedure Set_DataModel(const Value: IUnknown);
    function Get_CurrentElement: IUnknown;
    procedure Set_CurrentElement(const Value: IUnknown);
    function Get_ChangeCount: Integer;
    function Get_SelectionCount: Integer;
    function Get_SelectionItem(Index: Integer): IUnknown;
    function Get_State: Integer;
    procedure Set_State(Value: Integer);
    function Get_Server: IDataModelServer;
    procedure Set_Server(const Value: IDataModelServer);
    function Get_Hint: WideString;
    function Get_Cursor: Integer;
    function Get_Analyzer: IUnknown;
    procedure Set_Analyzer(const Value: IUnknown);
    function Get_Password: WideString;
    procedure Set_Password(const Value: WideString);
    function Get_CurrentElementID: Integer;
    procedure Set_CurrentElementID(Value: Integer);
    function Get_CurrentElementClassID: Integer;
    procedure Set_CurrentElementClassID(Value: Integer);
    function Get_CurrentCollectionIndex: Integer;
    procedure Set_CurrentCollectionIndex(Value: Integer);
    function Get_CurrentObjectExpanded: Integer;
    procedure Set_CurrentObjectExpanded(Value: Integer);
    function Get_TopElementID: Integer;
    procedure Set_TopElementID(Value: Integer);
    function Get_TopElementClassID: Integer;
    procedure Set_TopElementClassID(Value: Integer);
    function Get_TopCollectionIndex: Integer;
    procedure Set_TopCollectionIndex(Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDMDocument);
    procedure Disconnect; override;
    procedure IncChangeCount;
    procedure DecChangeCount;
    procedure ResetChangeCount;
    procedure ClearSelection(const ExceptedElementU: IUnknown);
    procedure Select(const ElementU: IUnknown);
    procedure Unselect(const ElementU: IUnknown);
    procedure UndoSelection;
    procedure ClearPrevSelection(ClearAll: WordBool);
    property DefaultInterface: IDMDocument read GetDefaultInterface;
    property DataModel: IUnknown read Get_DataModel write Set_DataModel;
    property CurrentElement: IUnknown read Get_CurrentElement write Set_CurrentElement;
    property ChangeCount: Integer read Get_ChangeCount;
    property SelectionCount: Integer read Get_SelectionCount;
    property SelectionItem[Index: Integer]: IUnknown read Get_SelectionItem;
    property Hint: WideString read Get_Hint;
    property Cursor: Integer read Get_Cursor;
    property Analyzer: IUnknown read Get_Analyzer write Set_Analyzer;
    property State: Integer read Get_State write Set_State;
    property Server: IDataModelServer read Get_Server write Set_Server;
    property Password: WideString read Get_Password write Set_Password;
    property CurrentElementID: Integer read Get_CurrentElementID write Set_CurrentElementID;
    property CurrentElementClassID: Integer read Get_CurrentElementClassID write Set_CurrentElementClassID;
    property CurrentCollectionIndex: Integer read Get_CurrentCollectionIndex write Set_CurrentCollectionIndex;
    property CurrentObjectExpanded: Integer read Get_CurrentObjectExpanded write Set_CurrentObjectExpanded;
    property TopElementID: Integer read Get_TopElementID write Set_TopElementID;
    property TopElementClassID: Integer read Get_TopElementClassID write Set_TopElementClassID;
    property TopCollectionIndex: Integer read Get_TopCollectionIndex write Set_TopCollectionIndex;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDMDocumentProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDMDocument
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDMDocumentProperties = class(TPersistent)
  private
    FServer:    TDMDocument;
    function    GetDefaultInterface: IDMDocument;
    constructor Create(AServer: TDMDocument);
  protected
    function Get_DataModel: IUnknown;
    procedure Set_DataModel(const Value: IUnknown);
    function Get_CurrentElement: IUnknown;
    procedure Set_CurrentElement(const Value: IUnknown);
    function Get_ChangeCount: Integer;
    function Get_SelectionCount: Integer;
    function Get_SelectionItem(Index: Integer): IUnknown;
    function Get_State: Integer;
    procedure Set_State(Value: Integer);
    function Get_Server: IDataModelServer;
    procedure Set_Server(const Value: IDataModelServer);
    function Get_Hint: WideString;
    function Get_Cursor: Integer;
    function Get_Analyzer: IUnknown;
    procedure Set_Analyzer(const Value: IUnknown);
    function Get_Password: WideString;
    procedure Set_Password(const Value: WideString);
    function Get_CurrentElementID: Integer;
    procedure Set_CurrentElementID(Value: Integer);
    function Get_CurrentElementClassID: Integer;
    procedure Set_CurrentElementClassID(Value: Integer);
    function Get_CurrentCollectionIndex: Integer;
    procedure Set_CurrentCollectionIndex(Value: Integer);
    function Get_CurrentObjectExpanded: Integer;
    procedure Set_CurrentObjectExpanded(Value: Integer);
    function Get_TopElementID: Integer;
    procedure Set_TopElementID(Value: Integer);
    function Get_TopElementClassID: Integer;
    procedure Set_TopElementClassID(Value: Integer);
    function Get_TopCollectionIndex: Integer;
    procedure Set_TopCollectionIndex(Value: Integer);
  public
    property DefaultInterface: IDMDocument read GetDefaultInterface;
  published
    property State: Integer read Get_State write Set_State;
    property Server: IDataModelServer read Get_Server write Set_Server;
    property Password: WideString read Get_Password write Set_Password;
    property CurrentElementID: Integer read Get_CurrentElementID write Set_CurrentElementID;
    property CurrentElementClassID: Integer read Get_CurrentElementClassID write Set_CurrentElementClassID;
    property CurrentCollectionIndex: Integer read Get_CurrentCollectionIndex write Set_CurrentCollectionIndex;
    property CurrentObjectExpanded: Integer read Get_CurrentObjectExpanded write Set_CurrentObjectExpanded;
    property TopElementID: Integer read Get_TopElementID write Set_TopElementID;
    property TopElementClassID: Integer read Get_TopElementClassID write Set_TopElementClassID;
    property TopCollectionIndex: Integer read Get_TopCollectionIndex write Set_TopCollectionIndex;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDataModelServer provides a Create and CreateRemote method to          
// create instances of the default interface IDataModelServer exposed by              
// the CoClass DataModelServer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataModelServer = class
    class function Create: IDataModelServer;
    class function CreateRemote(const MachineName: string): IDataModelServer;
  end;

  TDataModelServerOnDocumentOperation = procedure(Sender: TObject; var ElementsV: OleVariant;
                                                                   var CollectionV: OleVariant;
                                                                   DMOperation: Integer; 
                                                                   nItemIndex: Integer) of object;
  TDataModelServerOnRefreshDocument = procedure(Sender: TObject; FlagSet: Integer) of object;
  TDataModelServerOnSelectionChanged = procedure(Sender: TObject; var ElementU: OleVariant) of object;
  TDataModelServerOnCallRefDialog = procedure(Sender: TObject; var DMClassCollectionsU: OleVariant;
                                                               var RefSourceU: OleVariant;
                                                               var Suffix: OleVariant;
                                                               AskName: WordBool) of object;
  TDataModelServerOnSetControlState = procedure(Sender: TObject; ControlIndex: Integer; 
                                                                 Index: Integer; Mode: Integer; 
                                                                 State: Integer) of object;
  TDataModelServerOnNextAnalysisStep = procedure(Sender: TObject; Step: Integer) of object;
  TDataModelServerOnNextAnalysisStage = procedure(Sender: TObject; var StageName: OleVariant;
                                                                   Stage: Integer; 
                                                                   StepCount: Integer) of object;
  TDataModelServerOnCallDialog = procedure(Sender: TObject; Mode: Integer; var Caption: OleVariant;
                                                            var Prompt: OleVariant) of object;
  TDataModelServerOnChangeCurrentObject = procedure(Sender: TObject; var Obj: OleVariant;
                                                                     var DMForm: OleVariant) of object;
  TDataModelServerOnNextLoadStage = procedure(Sender: TObject; var StageName: OleVariant;
                                                               Stage: Integer; StepCount: Integer) of object;
  TDataModelServerOnRefreshElement = procedure(Sender: TObject; var ElementU: OleVariant) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDataModelServer
// Help String      : 
// Default Interface: IDataModelServer
// Def. Intf. DISP? : No
// Event   Interface: IDataModelServerEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDataModelServerProperties= class;
{$ENDIF}
  TDataModelServer = class(TOleServer)
  private
    FOnOpenDocument: TNotifyEvent;
    FOnDocumentOperation: TDataModelServerOnDocumentOperation;
    FOnCloseDocument: TNotifyEvent;
    FOnCreateDocument: TNotifyEvent;
    FOnRefreshDocument: TDataModelServerOnRefreshDocument;
    FOnSelectionChanged: TDataModelServerOnSelectionChanged;
    FOnCallRefDialog: TDataModelServerOnCallRefDialog;
    FOnSetControlState: TDataModelServerOnSetControlState;
    FOnOperationStepExecuted: TNotifyEvent;
    FOnNextAnalysisStep: TDataModelServerOnNextAnalysisStep;
    FOnNextAnalysisStage: TDataModelServerOnNextAnalysisStage;
    FOnCallDialog: TDataModelServerOnCallDialog;
    FOnChangeCurrentObject: TDataModelServerOnChangeCurrentObject;
    FOnNextLoadStage: TDataModelServerOnNextLoadStage;
    FOnStopAnalysis: TNotifyEvent;
    FOnRefreshElement: TDataModelServerOnRefreshElement;
    FIntf:        IDataModelServer;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDataModelServerProperties;
    function      GetServerProperties: TDataModelServerProperties;
{$ENDIF}
    function      GetDefaultInterface: IDataModelServer;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_ProgID: WideString;
    procedure Set_ProgID(const Value: WideString);
    function Get_DataModelAlias: WideString;
    procedure Set_DataModelAlias(const Value: WideString);
    function Get_DataModelFileExt: WideString;
    procedure Set_DataModelFileExt(const Value: WideString);
    function Get_DocumentCount: Integer;
    function Get_Document(Index: Integer): IDMDocument;
    function Get_CurrentDocumentIndex: Integer;
    procedure Set_CurrentDocumentIndex(Value: Integer);
    function Get_CurrentDocument: IDMDocument;
    function Get_DocumentProgID: WideString;
    procedure Set_DocumentProgID(const Value: WideString);
    function Get_EventData1: OleVariant;
    procedure Set_EventData1(Value: OleVariant);
    function Get_EventData2: OleVariant;
    procedure Set_EventData2(Value: OleVariant);
    function Get_EventData3: OleVariant;
    procedure Set_EventData3(Value: OleVariant);
    function Get_AnalyzerProgID: WideString;
    procedure Set_AnalyzerProgID(const Value: WideString);
    function Get_InitialDir: WideString;
    procedure Set_InitialDir(const Value: WideString);
    function Get_Events: IDMServerEvents;
    procedure Set_Events(const Value: IDMServerEvents);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDataModelServer);
    procedure Disconnect; override;
    procedure CloseAll;
    procedure CloseCurrentDocument;
    procedure CreateNewDataModel(const RefDataModelU: IUnknown);
    function LoadDataModel(const FileName: WideString; const Password: WideString; 
                           const RefDataModelU: IUnknown): WordBool;
    procedure SaveDataModel(const FileName: WideString);
    procedure ExportDataModel(const FileName: WideString; ExportMode: Integer);
    procedure ImportDataModel(const FileName: WideString; ImportMode: Integer);
    procedure DocumentOperation(const ElementsV: IUnknown; const CollectionV: IUnknown; 
                                DMOperation: Integer; nItemIndex: Integer);
    procedure OpenDocument;
    procedure RefreshDocument(FlagSet: Integer);
    procedure SelectionChanged(const ElementU: IUnknown);
    procedure CallRefDialog(const DMClassCollectionsU: IUnknown; const RefSourceU: IUnknown; 
                            const Suffix: WideString; AskName: WordBool);
    procedure SetControlState(ControlIndex: Integer; Index: Integer; Mode: Integer; State: Integer);
    procedure OperationStepExecuted;
    procedure StartAnalysis(Mode: Integer);
    procedure StopAnalysis;
    procedure NextAnalysisStep(Step: Integer);
    procedure NextAnalysisStage(const StageName: WideString; Stage: Integer; StepCount: Integer);
    procedure CallDialog(Mode: Integer; const Caption: WideString; const Prompt: WideString);
    procedure ChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown);
    procedure NextLoadStage(const StageName: WideString; Stage: Integer; StepCount: Integer);
    procedure RefreshElement(const ElementU: IUnknown);
    procedure AnalysisError(const ErrorMessage: WideString);
    property DefaultInterface: IDataModelServer read GetDefaultInterface;
    property DocumentCount: Integer read Get_DocumentCount;
    property Document[Index: Integer]: IDMDocument read Get_Document;
    property CurrentDocument: IDMDocument read Get_CurrentDocument;
    property EventData1: OleVariant read Get_EventData1 write Set_EventData1;
    property EventData2: OleVariant read Get_EventData2 write Set_EventData2;
    property EventData3: OleVariant read Get_EventData3 write Set_EventData3;
    property ProgID: WideString read Get_ProgID write Set_ProgID;
    property DataModelAlias: WideString read Get_DataModelAlias write Set_DataModelAlias;
    property DataModelFileExt: WideString read Get_DataModelFileExt write Set_DataModelFileExt;
    property CurrentDocumentIndex: Integer read Get_CurrentDocumentIndex write Set_CurrentDocumentIndex;
    property DocumentProgID: WideString read Get_DocumentProgID write Set_DocumentProgID;
    property AnalyzerProgID: WideString read Get_AnalyzerProgID write Set_AnalyzerProgID;
    property InitialDir: WideString read Get_InitialDir write Set_InitialDir;
    property Events: IDMServerEvents read Get_Events write Set_Events;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDataModelServerProperties read GetServerProperties;
{$ENDIF}
    property OnOpenDocument: TNotifyEvent read FOnOpenDocument write FOnOpenDocument;
    property OnDocumentOperation: TDataModelServerOnDocumentOperation read FOnDocumentOperation write FOnDocumentOperation;
    property OnCloseDocument: TNotifyEvent read FOnCloseDocument write FOnCloseDocument;
    property OnCreateDocument: TNotifyEvent read FOnCreateDocument write FOnCreateDocument;
    property OnRefreshDocument: TDataModelServerOnRefreshDocument read FOnRefreshDocument write FOnRefreshDocument;
    property OnSelectionChanged: TDataModelServerOnSelectionChanged read FOnSelectionChanged write FOnSelectionChanged;
    property OnCallRefDialog: TDataModelServerOnCallRefDialog read FOnCallRefDialog write FOnCallRefDialog;
    property OnSetControlState: TDataModelServerOnSetControlState read FOnSetControlState write FOnSetControlState;
    property OnOperationStepExecuted: TNotifyEvent read FOnOperationStepExecuted write FOnOperationStepExecuted;
    property OnNextAnalysisStep: TDataModelServerOnNextAnalysisStep read FOnNextAnalysisStep write FOnNextAnalysisStep;
    property OnNextAnalysisStage: TDataModelServerOnNextAnalysisStage read FOnNextAnalysisStage write FOnNextAnalysisStage;
    property OnCallDialog: TDataModelServerOnCallDialog read FOnCallDialog write FOnCallDialog;
    property OnChangeCurrentObject: TDataModelServerOnChangeCurrentObject read FOnChangeCurrentObject write FOnChangeCurrentObject;
    property OnNextLoadStage: TDataModelServerOnNextLoadStage read FOnNextLoadStage write FOnNextLoadStage;
    property OnStopAnalysis: TNotifyEvent read FOnStopAnalysis write FOnStopAnalysis;
    property OnRefreshElement: TDataModelServerOnRefreshElement read FOnRefreshElement write FOnRefreshElement;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDataModelServer
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDataModelServerProperties = class(TPersistent)
  private
    FServer:    TDataModelServer;
    function    GetDefaultInterface: IDataModelServer;
    constructor Create(AServer: TDataModelServer);
  protected
    function Get_ProgID: WideString;
    procedure Set_ProgID(const Value: WideString);
    function Get_DataModelAlias: WideString;
    procedure Set_DataModelAlias(const Value: WideString);
    function Get_DataModelFileExt: WideString;
    procedure Set_DataModelFileExt(const Value: WideString);
    function Get_DocumentCount: Integer;
    function Get_Document(Index: Integer): IDMDocument;
    function Get_CurrentDocumentIndex: Integer;
    procedure Set_CurrentDocumentIndex(Value: Integer);
    function Get_CurrentDocument: IDMDocument;
    function Get_DocumentProgID: WideString;
    procedure Set_DocumentProgID(const Value: WideString);
    function Get_EventData1: OleVariant;
    procedure Set_EventData1(Value: OleVariant);
    function Get_EventData2: OleVariant;
    procedure Set_EventData2(Value: OleVariant);
    function Get_EventData3: OleVariant;
    procedure Set_EventData3(Value: OleVariant);
    function Get_AnalyzerProgID: WideString;
    procedure Set_AnalyzerProgID(const Value: WideString);
    function Get_InitialDir: WideString;
    procedure Set_InitialDir(const Value: WideString);
    function Get_Events: IDMServerEvents;
    procedure Set_Events(const Value: IDMServerEvents);
  public
    property DefaultInterface: IDataModelServer read GetDefaultInterface;
  published
    property ProgID: WideString read Get_ProgID write Set_ProgID;
    property DataModelAlias: WideString read Get_DataModelAlias write Set_DataModelAlias;
    property DataModelFileExt: WideString read Get_DataModelFileExt write Set_DataModelFileExt;
    property CurrentDocumentIndex: Integer read Get_CurrentDocumentIndex write Set_CurrentDocumentIndex;
    property DocumentProgID: WideString read Get_DocumentProgID write Set_DocumentProgID;
    property AnalyzerProgID: WideString read Get_AnalyzerProgID write Set_AnalyzerProgID;
    property InitialDir: WideString read Get_InitialDir write Set_InitialDir;
    property Events: IDMServerEvents read Get_Events write Set_Events;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoDMDocument.Create: IDMDocument;
begin
  Result := CreateComObject(CLASS_DMDocument) as IDMDocument;
end;

class function CoDMDocument.CreateRemote(const MachineName: string): IDMDocument;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DMDocument) as IDMDocument;
end;

procedure TDMDocument.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{16EE0283-4C96-11D5-845E-8E92F733EA08}';
    IntfIID:   '{16EE0281-4C96-11D5-845E-8E92F733EA08}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDMDocument.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IDMDocument;
  end;
end;

procedure TDMDocument.ConnectTo(svrIntf: IDMDocument);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDMDocument.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDMDocument.GetDefaultInterface: IDMDocument;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDMDocument.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDMDocumentProperties.Create(Self);
{$ENDIF}
end;

destructor TDMDocument.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDMDocument.GetServerProperties: TDMDocumentProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TDMDocument.Get_DataModel: IUnknown;
begin
    Result := DefaultInterface.DataModel;
end;

procedure TDMDocument.Set_DataModel(const Value: IUnknown);
begin
  Exit;
end;

function TDMDocument.Get_CurrentElement: IUnknown;
begin
    Result := DefaultInterface.CurrentElement;
end;

procedure TDMDocument.Set_CurrentElement(const Value: IUnknown);
begin
  Exit;
end;

function TDMDocument.Get_ChangeCount: Integer;
begin
    Result := DefaultInterface.ChangeCount;
end;

function TDMDocument.Get_SelectionCount: Integer;
begin
    Result := DefaultInterface.SelectionCount;
end;

function TDMDocument.Get_SelectionItem(Index: Integer): IUnknown;
begin
    Result := DefaultInterface.SelectionItem[Index];
end;

function TDMDocument.Get_State: Integer;
begin
    Result := DefaultInterface.State;
end;

procedure TDMDocument.Set_State(Value: Integer);
begin
  Exit;
end;

function TDMDocument.Get_Server: IDataModelServer;
begin
    Result := DefaultInterface.Server;
end;

procedure TDMDocument.Set_Server(const Value: IDataModelServer);
begin
  Exit;
end;

function TDMDocument.Get_Hint: WideString;
begin
    Result := DefaultInterface.Hint;
end;

function TDMDocument.Get_Cursor: Integer;
begin
    Result := DefaultInterface.Cursor;
end;

function TDMDocument.Get_Analyzer: IUnknown;
begin
    Result := DefaultInterface.Analyzer;
end;

procedure TDMDocument.Set_Analyzer(const Value: IUnknown);
begin
  Exit;
end;

function TDMDocument.Get_Password: WideString;
begin
    Result := DefaultInterface.Password;
end;

procedure TDMDocument.Set_Password(const Value: WideString);
  { Warning: The property Password has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Password := Value;
end;

function TDMDocument.Get_CurrentElementID: Integer;
begin
    Result := DefaultInterface.CurrentElementID;
end;

procedure TDMDocument.Set_CurrentElementID(Value: Integer);
begin
  Exit;
end;

function TDMDocument.Get_CurrentElementClassID: Integer;
begin
    Result := DefaultInterface.CurrentElementClassID;
end;

procedure TDMDocument.Set_CurrentElementClassID(Value: Integer);
begin
  Exit;
end;

function TDMDocument.Get_CurrentCollectionIndex: Integer;
begin
    Result := DefaultInterface.CurrentCollectionIndex;
end;

procedure TDMDocument.Set_CurrentCollectionIndex(Value: Integer);
begin
  Exit;
end;

function TDMDocument.Get_CurrentObjectExpanded: Integer;
begin
    Result := DefaultInterface.CurrentObjectExpanded;
end;

procedure TDMDocument.Set_CurrentObjectExpanded(Value: Integer);
begin
  Exit;
end;

function TDMDocument.Get_TopElementID: Integer;
begin
    Result := DefaultInterface.TopElementID;
end;

procedure TDMDocument.Set_TopElementID(Value: Integer);
begin
  Exit;
end;

function TDMDocument.Get_TopElementClassID: Integer;
begin
    Result := DefaultInterface.TopElementClassID;
end;

procedure TDMDocument.Set_TopElementClassID(Value: Integer);
begin
  Exit;
end;

function TDMDocument.Get_TopCollectionIndex: Integer;
begin
    Result := DefaultInterface.TopCollectionIndex;
end;

procedure TDMDocument.Set_TopCollectionIndex(Value: Integer);
begin
  Exit;
end;

procedure TDMDocument.IncChangeCount;
begin
  DefaultInterface.IncChangeCount;
end;

procedure TDMDocument.DecChangeCount;
begin
  DefaultInterface.DecChangeCount;
end;

procedure TDMDocument.ResetChangeCount;
begin
  DefaultInterface.ResetChangeCount;
end;

procedure TDMDocument.ClearSelection(const ExceptedElementU: IUnknown);
begin
  DefaultInterface.ClearSelection(ExceptedElementU);
end;

procedure TDMDocument.Select(const ElementU: IUnknown);
begin
  DefaultInterface.Select(ElementU);
end;

procedure TDMDocument.Unselect(const ElementU: IUnknown);
begin
  DefaultInterface.Unselect(ElementU);
end;

procedure TDMDocument.UndoSelection;
begin
  DefaultInterface.UndoSelection;
end;

procedure TDMDocument.ClearPrevSelection(ClearAll: WordBool);
begin
  DefaultInterface.ClearPrevSelection(ClearAll);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDMDocumentProperties.Create(AServer: TDMDocument);
begin
  inherited Create;
  FServer := AServer;
end;

function TDMDocumentProperties.GetDefaultInterface: IDMDocument;
begin
  Result := FServer.DefaultInterface;
end;

function TDMDocumentProperties.Get_DataModel: IUnknown;
begin
    Result := DefaultInterface.DataModel;
end;

procedure TDMDocumentProperties.Set_DataModel(const Value: IUnknown);
begin
  Exit;
end;

function TDMDocumentProperties.Get_CurrentElement: IUnknown;
begin
    Result := DefaultInterface.CurrentElement;
end;

procedure TDMDocumentProperties.Set_CurrentElement(const Value: IUnknown);
begin
  Exit;
end;

function TDMDocumentProperties.Get_ChangeCount: Integer;
begin
    Result := DefaultInterface.ChangeCount;
end;

function TDMDocumentProperties.Get_SelectionCount: Integer;
begin
    Result := DefaultInterface.SelectionCount;
end;

function TDMDocumentProperties.Get_SelectionItem(Index: Integer): IUnknown;
begin
    Result := DefaultInterface.SelectionItem[Index];
end;

function TDMDocumentProperties.Get_State: Integer;
begin
    Result := DefaultInterface.State;
end;

procedure TDMDocumentProperties.Set_State(Value: Integer);
begin
  Exit;
end;

function TDMDocumentProperties.Get_Server: IDataModelServer;
begin
    Result := DefaultInterface.Server;
end;

procedure TDMDocumentProperties.Set_Server(const Value: IDataModelServer);
begin
  Exit;
end;

function TDMDocumentProperties.Get_Hint: WideString;
begin
    Result := DefaultInterface.Hint;
end;

function TDMDocumentProperties.Get_Cursor: Integer;
begin
    Result := DefaultInterface.Cursor;
end;

function TDMDocumentProperties.Get_Analyzer: IUnknown;
begin
    Result := DefaultInterface.Analyzer;
end;

procedure TDMDocumentProperties.Set_Analyzer(const Value: IUnknown);
begin
  Exit;
end;

function TDMDocumentProperties.Get_Password: WideString;
begin
    Result := DefaultInterface.Password;
end;

procedure TDMDocumentProperties.Set_Password(const Value: WideString);
  { Warning: The property Password has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Password := Value;
end;

function TDMDocumentProperties.Get_CurrentElementID: Integer;
begin
    Result := DefaultInterface.CurrentElementID;
end;

procedure TDMDocumentProperties.Set_CurrentElementID(Value: Integer);
begin
  Exit;
end;

function TDMDocumentProperties.Get_CurrentElementClassID: Integer;
begin
    Result := DefaultInterface.CurrentElementClassID;
end;

procedure TDMDocumentProperties.Set_CurrentElementClassID(Value: Integer);
begin
  Exit;
end;

function TDMDocumentProperties.Get_CurrentCollectionIndex: Integer;
begin
    Result := DefaultInterface.CurrentCollectionIndex;
end;

procedure TDMDocumentProperties.Set_CurrentCollectionIndex(Value: Integer);
begin
  Exit;
end;

function TDMDocumentProperties.Get_CurrentObjectExpanded: Integer;
begin
    Result := DefaultInterface.CurrentObjectExpanded;
end;

procedure TDMDocumentProperties.Set_CurrentObjectExpanded(Value: Integer);
begin
  Exit;
end;

function TDMDocumentProperties.Get_TopElementID: Integer;
begin
    Result := DefaultInterface.TopElementID;
end;

procedure TDMDocumentProperties.Set_TopElementID(Value: Integer);
begin
  Exit;
end;

function TDMDocumentProperties.Get_TopElementClassID: Integer;
begin
    Result := DefaultInterface.TopElementClassID;
end;

procedure TDMDocumentProperties.Set_TopElementClassID(Value: Integer);
begin
  Exit;
end;

function TDMDocumentProperties.Get_TopCollectionIndex: Integer;
begin
    Result := DefaultInterface.TopCollectionIndex;
end;

procedure TDMDocumentProperties.Set_TopCollectionIndex(Value: Integer);
begin
  Exit;
end;

{$ENDIF}

class function CoDataModelServer.Create: IDataModelServer;
begin
  Result := CreateComObject(CLASS_DataModelServer) as IDataModelServer;
end;

class function CoDataModelServer.CreateRemote(const MachineName: string): IDataModelServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataModelServer) as IDataModelServer;
end;

procedure TDataModelServer.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5F557360-EE35-11D4-845E-C8EF7B9C9D0E}';
    IntfIID:   '{5648DD27-C6D0-11D4-845E-A2D7FAE1C80C}';
    EventIID:  '{16EE0285-4C96-11D5-845E-8E92F733EA08}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDataModelServer.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IDataModelServer;
  end;
end;

procedure TDataModelServer.ConnectTo(svrIntf: IDataModelServer);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TDataModelServer.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TDataModelServer.GetDefaultInterface: IDataModelServer;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDataModelServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDataModelServerProperties.Create(Self);
{$ENDIF}
end;

destructor TDataModelServer.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDataModelServer.GetServerProperties: TDataModelServerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TDataModelServer.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
   1: if Assigned(FOnOpenDocument) then
            FOnOpenDocument(Self);
   2: if Assigned(FOnDocumentOperation) then
            FOnDocumentOperation(Self, Params[3] {Integer}, Params[2] {Integer}, Params[1] {const IUnknown}, Params[0] {const IUnknown});
   3: if Assigned(FOnCloseDocument) then
            FOnCloseDocument(Self);
   4: if Assigned(FOnCreateDocument) then
            FOnCreateDocument(Self);
   5: if Assigned(FOnRefreshDocument) then
            FOnRefreshDocument(Self, Params[0] {Integer});
   6: if Assigned(FOnSelectionChanged) then
            FOnSelectionChanged(Self, Params[0] {const IUnknown});
   7: if Assigned(FOnCallRefDialog) then
            FOnCallRefDialog(Self, Params[3] {WordBool}, Params[2] {const WideString}, Params[1] {const IUnknown}, Params[0] {const IUnknown});
   9: if Assigned(FOnSetControlState) then
            FOnSetControlState(Self, Params[3] {Integer}, Params[2] {Integer}, Params[1] {Integer}, Params[0] {Integer});
   8: if Assigned(FOnOperationStepExecuted) then
            FOnOperationStepExecuted(Self);
   10: if Assigned(FOnNextAnalysisStep) then
            FOnNextAnalysisStep(Self, Params[0] {Integer});
   11: if Assigned(FOnNextAnalysisStage) then
            FOnNextAnalysisStage(Self, Params[2] {Integer}, Params[1] {Integer}, Params[0] {const WideString});
   12: if Assigned(FOnCallDialog) then
            FOnCallDialog(Self, Params[2] {const WideString}, Params[1] {const WideString}, Params[0] {Integer});
   13: if Assigned(FOnChangeCurrentObject) then
            FOnChangeCurrentObject(Self, Params[1] {const IUnknown}, Params[0] {const IUnknown});
   14: if Assigned(FOnNextLoadStage) then
            FOnNextLoadStage(Self, Params[2] {Integer}, Params[1] {Integer}, Params[0] {const WideString});
   15: if Assigned(FOnStopAnalysis) then
            FOnStopAnalysis(Self);
   16: if Assigned(FOnRefreshElement) then
            FOnRefreshElement(Self, Params[0] {const IUnknown});
  end; {case DispID}
end;

function TDataModelServer.Get_ProgID: WideString;
begin
    Result := DefaultInterface.ProgID;
end;

procedure TDataModelServer.Set_ProgID(const Value: WideString);
  { Warning: The property ProgID has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ProgID := Value;
end;

function TDataModelServer.Get_DataModelAlias: WideString;
begin
    Result := DefaultInterface.DataModelAlias;
end;

procedure TDataModelServer.Set_DataModelAlias(const Value: WideString);
  { Warning: The property DataModelAlias has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DataModelAlias := Value;
end;

function TDataModelServer.Get_DataModelFileExt: WideString;
begin
    Result := DefaultInterface.DataModelFileExt;
end;

procedure TDataModelServer.Set_DataModelFileExt(const Value: WideString);
  { Warning: The property DataModelFileExt has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DataModelFileExt := Value;
end;

function TDataModelServer.Get_DocumentCount: Integer;
begin
    Result := DefaultInterface.DocumentCount;
end;

function TDataModelServer.Get_Document(Index: Integer): IDMDocument;
begin
    Result := DefaultInterface.Document[Index];
end;

function TDataModelServer.Get_CurrentDocumentIndex: Integer;
begin
    Result := DefaultInterface.CurrentDocumentIndex;
end;

procedure TDataModelServer.Set_CurrentDocumentIndex(Value: Integer);
begin
  Exit;
end;

function TDataModelServer.Get_CurrentDocument: IDMDocument;
begin
    Result := DefaultInterface.CurrentDocument;
end;

function TDataModelServer.Get_DocumentProgID: WideString;
begin
    Result := DefaultInterface.DocumentProgID;
end;

procedure TDataModelServer.Set_DocumentProgID(const Value: WideString);
  { Warning: The property DocumentProgID has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DocumentProgID := Value;
end;

function TDataModelServer.Get_EventData1: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.EventData1;
end;

procedure TDataModelServer.Set_EventData1(Value: OleVariant);
begin
  Exit;
end;

function TDataModelServer.Get_EventData2: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.EventData2;
end;

procedure TDataModelServer.Set_EventData2(Value: OleVariant);
begin
  Exit;
end;

function TDataModelServer.Get_EventData3: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.EventData3;
end;

procedure TDataModelServer.Set_EventData3(Value: OleVariant);
begin
  Exit;
end;

function TDataModelServer.Get_AnalyzerProgID: WideString;
begin
    Result := DefaultInterface.AnalyzerProgID;
end;

procedure TDataModelServer.Set_AnalyzerProgID(const Value: WideString);
  { Warning: The property AnalyzerProgID has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AnalyzerProgID := Value;
end;

function TDataModelServer.Get_InitialDir: WideString;
begin
    Result := DefaultInterface.InitialDir;
end;

procedure TDataModelServer.Set_InitialDir(const Value: WideString);
  { Warning: The property InitialDir has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.InitialDir := Value;
end;

function TDataModelServer.Get_Events: IDMServerEvents;
begin
    Result := DefaultInterface.Events;
end;

procedure TDataModelServer.Set_Events(const Value: IDMServerEvents);
begin
  Exit;
end;

procedure TDataModelServer.CloseAll;
begin
  DefaultInterface.CloseAll;
end;

procedure TDataModelServer.CloseCurrentDocument;
begin
  DefaultInterface.CloseCurrentDocument;
end;

procedure TDataModelServer.CreateNewDataModel(const RefDataModelU: IUnknown);
begin
  DefaultInterface.CreateNewDataModel(RefDataModelU);
end;

function TDataModelServer.LoadDataModel(const FileName: WideString; const Password: WideString; 
                                        const RefDataModelU: IUnknown): WordBool;
begin
  Result := DefaultInterface.LoadDataModel(FileName, Password, RefDataModelU);
end;

procedure TDataModelServer.SaveDataModel(const FileName: WideString);
begin
  DefaultInterface.SaveDataModel(FileName);
end;

procedure TDataModelServer.ExportDataModel(const FileName: WideString; ExportMode: Integer);
begin
  DefaultInterface.ExportDataModel(FileName, ExportMode);
end;

procedure TDataModelServer.ImportDataModel(const FileName: WideString; ImportMode: Integer);
begin
  DefaultInterface.ImportDataModel(FileName, ImportMode);
end;

procedure TDataModelServer.DocumentOperation(const ElementsV: IUnknown; 
                                             const CollectionV: IUnknown; DMOperation: Integer; 
                                             nItemIndex: Integer);
begin
  DefaultInterface.DocumentOperation(ElementsV, CollectionV, DMOperation, nItemIndex);
end;

procedure TDataModelServer.OpenDocument;
begin
  DefaultInterface.OpenDocument;
end;

procedure TDataModelServer.RefreshDocument(FlagSet: Integer);
begin
  DefaultInterface.RefreshDocument(FlagSet);
end;

procedure TDataModelServer.SelectionChanged(const ElementU: IUnknown);
begin
  DefaultInterface.SelectionChanged(ElementU);
end;

procedure TDataModelServer.CallRefDialog(const DMClassCollectionsU: IUnknown; 
                                         const RefSourceU: IUnknown; const Suffix: WideString; 
                                         AskName: WordBool);
begin
  DefaultInterface.CallRefDialog(DMClassCollectionsU, RefSourceU, Suffix, AskName);
end;

procedure TDataModelServer.SetControlState(ControlIndex: Integer; Index: Integer; Mode: Integer; 
                                           State: Integer);
begin
  DefaultInterface.SetControlState(ControlIndex, Index, Mode, State);
end;

procedure TDataModelServer.OperationStepExecuted;
begin
  DefaultInterface.OperationStepExecuted;
end;

procedure TDataModelServer.StartAnalysis(Mode: Integer);
begin
  DefaultInterface.StartAnalysis(Mode);
end;

procedure TDataModelServer.StopAnalysis;
begin
  DefaultInterface.StopAnalysis;
end;

procedure TDataModelServer.NextAnalysisStep(Step: Integer);
begin
  DefaultInterface.NextAnalysisStep(Step);
end;

procedure TDataModelServer.NextAnalysisStage(const StageName: WideString; Stage: Integer; 
                                             StepCount: Integer);
begin
  DefaultInterface.NextAnalysisStage(StageName, Stage, StepCount);
end;

procedure TDataModelServer.CallDialog(Mode: Integer; const Caption: WideString; 
                                      const Prompt: WideString);
begin
  DefaultInterface.CallDialog(Mode, Caption, Prompt);
end;

procedure TDataModelServer.ChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown);
begin
  DefaultInterface.ChangeCurrentObject(Obj, DMForm);
end;

procedure TDataModelServer.NextLoadStage(const StageName: WideString; Stage: Integer; 
                                         StepCount: Integer);
begin
  DefaultInterface.NextLoadStage(StageName, Stage, StepCount);
end;

procedure TDataModelServer.RefreshElement(const ElementU: IUnknown);
begin
  DefaultInterface.RefreshElement(ElementU);
end;

procedure TDataModelServer.AnalysisError(const ErrorMessage: WideString);
begin
  DefaultInterface.AnalysisError(ErrorMessage);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDataModelServerProperties.Create(AServer: TDataModelServer);
begin
  inherited Create;
  FServer := AServer;
end;

function TDataModelServerProperties.GetDefaultInterface: IDataModelServer;
begin
  Result := FServer.DefaultInterface;
end;

function TDataModelServerProperties.Get_ProgID: WideString;
begin
    Result := DefaultInterface.ProgID;
end;

procedure TDataModelServerProperties.Set_ProgID(const Value: WideString);
  { Warning: The property ProgID has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ProgID := Value;
end;

function TDataModelServerProperties.Get_DataModelAlias: WideString;
begin
    Result := DefaultInterface.DataModelAlias;
end;

procedure TDataModelServerProperties.Set_DataModelAlias(const Value: WideString);
  { Warning: The property DataModelAlias has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DataModelAlias := Value;
end;

function TDataModelServerProperties.Get_DataModelFileExt: WideString;
begin
    Result := DefaultInterface.DataModelFileExt;
end;

procedure TDataModelServerProperties.Set_DataModelFileExt(const Value: WideString);
  { Warning: The property DataModelFileExt has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DataModelFileExt := Value;
end;

function TDataModelServerProperties.Get_DocumentCount: Integer;
begin
    Result := DefaultInterface.DocumentCount;
end;

function TDataModelServerProperties.Get_Document(Index: Integer): IDMDocument;
begin
    Result := DefaultInterface.Document[Index];
end;

function TDataModelServerProperties.Get_CurrentDocumentIndex: Integer;
begin
    Result := DefaultInterface.CurrentDocumentIndex;
end;

procedure TDataModelServerProperties.Set_CurrentDocumentIndex(Value: Integer);
begin
  Exit;
end;

function TDataModelServerProperties.Get_CurrentDocument: IDMDocument;
begin
    Result := DefaultInterface.CurrentDocument;
end;

function TDataModelServerProperties.Get_DocumentProgID: WideString;
begin
    Result := DefaultInterface.DocumentProgID;
end;

procedure TDataModelServerProperties.Set_DocumentProgID(const Value: WideString);
  { Warning: The property DocumentProgID has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DocumentProgID := Value;
end;

function TDataModelServerProperties.Get_EventData1: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.EventData1;
end;

procedure TDataModelServerProperties.Set_EventData1(Value: OleVariant);
begin
  Exit;
end;

function TDataModelServerProperties.Get_EventData2: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.EventData2;
end;

procedure TDataModelServerProperties.Set_EventData2(Value: OleVariant);
begin
  Exit;
end;

function TDataModelServerProperties.Get_EventData3: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.EventData3;
end;

procedure TDataModelServerProperties.Set_EventData3(Value: OleVariant);
begin
  Exit;
end;

function TDataModelServerProperties.Get_AnalyzerProgID: WideString;
begin
    Result := DefaultInterface.AnalyzerProgID;
end;

procedure TDataModelServerProperties.Set_AnalyzerProgID(const Value: WideString);
  { Warning: The property AnalyzerProgID has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AnalyzerProgID := Value;
end;

function TDataModelServerProperties.Get_InitialDir: WideString;
begin
    Result := DefaultInterface.InitialDir;
end;

procedure TDataModelServerProperties.Set_InitialDir(const Value: WideString);
  { Warning: The property InitialDir has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.InitialDir := Value;
end;

function TDataModelServerProperties.Get_Events: IDMServerEvents;
begin
    Result := DefaultInterface.Events;
end;

procedure TDataModelServerProperties.Set_Events(const Value: IDMServerEvents);
begin
  Exit;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TDMDocument, TDataModelServer]);
end;

end.
