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
// File generated on 07.04.2008 14:03:20 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\AutoDM\AutoDMPas\DMServer\DMServerLib.tlb (1)
// LIBID: {5648DD20-C6D0-11D4-845E-A2D7FAE1C81C}
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
  IID_IDMXML: TGUID = '{62641BF6-0BB9-4E04-B436-4BAC795CC411}';

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
  IDMXML = interface;
  IDMXMLDisp = dispinterface;

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
    function Get_UseAnalysisThread: WordBool; safecall;
    procedure Set_UseAnalysisThread(Value: WordBool); safecall;
    function Get_DataModelFactoryU: IUnknown; safecall;
    procedure Set_DataModelFactoryU(const Value: IUnknown); safecall;
    function Get_AnalyzerFactoryU: IUnknown; safecall;
    procedure Set_AnalyzerFactoryU(const Value: IUnknown); safecall;
    procedure DoSaveDataModelToXML(const FileName: WideString; const aDataModelU: IUnknown); safecall;
    procedure DoSaveDataModel(const FileName: WideString; const Password: WideString; 
                              const aDataModelU: IUnknown); safecall;
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
    property UseAnalysisThread: WordBool read Get_UseAnalysisThread write Set_UseAnalysisThread;
    property DataModelFactoryU: IUnknown read Get_DataModelFactoryU write Set_DataModelFactoryU;
    property AnalyzerFactoryU: IUnknown read Get_AnalyzerFactoryU write Set_AnalyzerFactoryU;
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
    property UseAnalysisThread: WordBool dispid 38;
    property DataModelFactoryU: IUnknown dispid 40;
    property AnalyzerFactoryU: IUnknown dispid 41;
    procedure DoSaveDataModelToXML(const FileName: WideString; const aDataModelU: IUnknown); dispid 39;
    procedure DoSaveDataModel(const FileName: WideString; const Password: WideString; 
                              const aDataModelU: IUnknown); dispid 42;
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
// Interface: IDMXML
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62641BF6-0BB9-4E04-B436-4BAC795CC411}
// *********************************************************************//
  IDMXML = interface(IDispatch)
    ['{62641BF6-0BB9-4E04-B436-4BAC795CC411}']
    procedure WriteXMLLine(const S: WideString); safecall;
    procedure IncLevel; safecall;
    procedure DecLevel; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMXMLDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62641BF6-0BB9-4E04-B436-4BAC795CC411}
// *********************************************************************//
  IDMXMLDisp = dispinterface
    ['{62641BF6-0BB9-4E04-B436-4BAC795CC411}']
    procedure WriteXMLLine(const S: WideString); dispid 1;
    procedure IncLevel; dispid 2;
    procedure DecLevel; dispid 3;
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

class function CoDataModelServer.Create: IDataModelServer;
begin
  Result := CreateComObject(CLASS_DataModelServer) as IDataModelServer;
end;

class function CoDataModelServer.CreateRemote(const MachineName: string): IDataModelServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataModelServer) as IDataModelServer;
end;

end.
