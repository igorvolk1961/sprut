unit DMEditor_TLB;

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
// File generated on 13.06.2006 12:43:19 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Volkov\AutoDM\AutoDMPas\DMControls\DMEditor.tlb (1)
// LIBID: {5311CE60-0694-11D5-845E-C1351F961A12}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TDMEditorX) : Registry key CLSID\{3ABC9803-5632-11D8-9941-0050BA51A6D3}\ToolboxBitmap32 not found
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DMEditorMajorVersion = 1;
  DMEditorMinorVersion = 0;

  LIBID_DMEditor: TGUID = '{5311CE60-0694-11D5-845E-C1351F961A12}';

  IID_IDMEditorX: TGUID = '{5311CE61-0694-11D5-845E-C1351F961A12}';
  IID_IDMForm: TGUID = '{99FFB6A1-1092-11D6-9329-0050BA51A6D3}';
  IID_ITreeViewForm: TGUID = '{1413F641-3CBD-11D7-97F0-0050BA51A6D3}';
  DIID_IDMEditorXEvents: TGUID = '{63417720-5B15-11D8-9946-0050BA51A6D3}';
  IID_IDMMacrosManager: TGUID = '{034DC31C-C7F1-4E18-B60C-3467409574EF}';
  IID_IDMMenu: TGUID = '{D53FAF41-6462-11D9-9A56-0050BA51A6D3}';
  IID_IDMMacrosPlayer: TGUID = '{D72B7CAF-DCF9-40BF-ADEF-AFAD18EE07AF}';
  CLASS_DMEditorX: TGUID = '{3ABC9803-5632-11D8-9941-0050BA51A6D3}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum DMEditorAction
type
  DMEditorAction = TOleEnum;
const
  dmbaAddElement = $00000000;
  dmbaDeleteElement = $00000001;
  dmbaRenameElement = $00000002;
  dmbaSelectElementFromList = $00000003;
  dmbaChangeRef = $00000004;
  dmbaExecute = $00000005;
  dmbaCustomOperation1 = $00000006;
  dmbaCustomOperation2 = $00000007;
  dmbaChangeParent = $00000008;
  dmbaDelete = $00000009;
  dmbaCopy = $0000000A;
  dmbaPaste = $0000000B;
  dmbaImportRaster = $0000000C;
  dmbaSwitchSelection = $0000000D;
  dmbaSelectAll = $0000000E;
  dmbaUnselectAll = $0000000F;
  dmbaImportVector = $00000010;
  dmbaUndo = $00000011;
  dmbaRedo = $00000012;
  dmbaGoToLastElement = $00000013;
  dmbaCut = $00000014;
  dmbaSetOptions = $00000015;
  dmbaShiftElementUp = $00000016;
  dmbaShiftElementDown = $00000017;
  dmbaPrint = $00000018;
  dmbaFind = $00000019;

// Constants for enum TControlState
type
  TControlState = TOleEnum;
const
  csChecked = $00000000;
  csEnabled = $00000001;
  csVisible = $00000002;
  csClick = $00000003;

// Constants for enum TFormPosition
type
  TFormPosition = TOleEnum;
const
  pnTop = $00000000;
  pnBottom = $00000001;

// Constants for enum TDMMacrosEvent
type
  TDMMacrosEvent = TOleEnum;
const
  meLClick = $00000000;
  meRClick = $00000001;
  meDoubleClick = $00000002;
  meMouseDown = $00000003;
  meMouseUp = $00000004;
  meKeyDown = $00000005;
  meKeyUp = $00000006;
  meKeyPress = $00000007;
  meMouseMove = $00000008;
  meDummy1 = $00000009;
  meDummy2 = $0000000A;

// Constants for enum TDMMacrosRecord
type
  TDMMacrosRecord = TOleEnum;
const
  mrFormEvent = $00000000;
  mrToolBarEvent = $00000001;
  mrPause = $00000002;
  mrMenuEvent = $00000003;
  mrHotButtonEvent = $00000004;
  mrDialogEvent = $00000005;
  mrSetFormState = $00000006;
  mrSetToolBarState = $00000007;
  mrSetEditorState = $00000008;
  mrSetDialogState = $00000009;
  mrStopMacros = $0000000A;
  mrOpenFile = $0000000B;
  mrNextStage = $0000000C;
  mrShowText = $0000000D;
  mrChangePrevRecord = $0000000E;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMEditorX = interface;
  IDMEditorXDisp = dispinterface;
  IDMForm = interface;
  IDMFormDisp = dispinterface;
  ITreeViewForm = interface;
  ITreeViewFormDisp = dispinterface;
  IDMEditorXEvents = dispinterface;
  IDMMacrosManager = interface;
  IDMMacrosManagerDisp = dispinterface;
  IDMMenu = interface;
  IDMMenuDisp = dispinterface;
  IDMMacrosPlayer = interface;
  IDMMacrosPlayerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMEditorX = IDMEditorX;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PInteger1 = ^Integer; {*}
  PWideString1 = ^WideString; {*}


// *********************************************************************//
// Interface: IDMEditorX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5311CE61-0694-11D5-845E-C1351F961A12}
// *********************************************************************//
  IDMEditorX = interface(IDispatch)
    ['{5311CE61-0694-11D5-845E-C1351F961A12}']
    procedure NewDataModel; safecall;
    function LoadDataModel(const aFileName: WideString; WriteToRegistryFlag: WordBool): WordBool; safecall;
    procedure SaveDataModel; safecall;
    procedure SaveDataModelAs; safecall;
    procedure CloseDataModel; safecall;
    function Get_ProgID: WideString; safecall;
    procedure Set_ProgID(const Value: WideString); safecall;
    function Get_DataModelAlias: WideString; safecall;
    procedure Set_DataModelAlias(const Value: WideString); safecall;
    function Get_DataModelFileExt: WideString; safecall;
    procedure Set_DataModelFileExt(const Value: WideString); safecall;
    function Get_DocumentProgID: WideString; safecall;
    procedure Set_DocumentProgID(const Value: WideString); safecall;
    procedure AddForm(FormClassGUID: TGUID; Position: Integer; const FormName: WideString); safecall;
    function Get_DataModel: IUnknown; safecall;
    procedure DoAction(ActionCode: Integer; ActiveFormOnly: WordBool); safecall;
    function Get_RefDataModel: IUnknown; safecall;
    procedure Set_RefDataModel(const Value: IUnknown); safecall;
    function Get_FormCount(Position: Integer): Integer; safecall;
    function Get_Form(Index: Integer; Position: Integer): IDMForm; safecall;
    function Get_ActiveForm: IDMForm; safecall;
    procedure Set_ActiveForm(const Value: IDMForm); safecall;
    procedure StartAnalysis(aMode: Integer); safecall;
    function Get_AnalyzerProgID: WideString; safecall;
    procedure Set_AnalyzerProgID(const Value: WideString); safecall;
    function Get_FormVisible(Index: Integer; Position: Integer): WordBool; safecall;
    procedure Set_FormVisible(Index: Integer; Position: Integer; Value: WordBool); safecall;
    procedure AddFormButton(Tag: Integer; ResourceInstanceHandle: Integer; 
                            const ResourceName: WideString; const Hint: WideString; 
                            FormPosition: Integer; Down: WordBool); safecall;
    function Get_RegistryKey: WideString; safecall;
    procedure Set_RegistryKey(const Value: WideString); safecall;
    function Get_LastSavedFileCount: Integer; safecall;
    function Get_LastSavedFile(Index: Integer): WideString; safecall;
    function Get_Changing: WordBool; safecall;
    procedure SetState(TopFormIndex: Integer; BottomFormIndex: Integer; ActivePanel: Integer; 
                       CurrentElementClassID: Integer; CurrentElementID: Integer; 
                       CurrentCollectionIndex: Integer; CurrentObjectExpanded: Integer; 
                       TopElementClassID: Integer; TopElementID: Integer; 
                       TopCollectionIndex: Integer; LastClassIndex: Integer; 
                       LastKindIndex: Integer; LastSubKindIndex: Integer; Ratio: Double); safecall;
    procedure SetState2(LastClassIndex: Integer; LastSubKindIndex: Integer); safecall;
    procedure DuplicateActiveForm; safecall;
    function Get_PasswordRequired: WordBool; safecall;
    procedure Set_PasswordRequired(Value: WordBool); safecall;
    function Get_TabIndex: Integer; safecall;
    procedure Set_TabIndex(Value: Integer); safecall;
    procedure MakeOutlookBar; safecall;
    function Get_OutlookPanelVisible: WordBool; safecall;
    procedure Set_OutlookPanelVisible(Value: WordBool); safecall;
    procedure SetDefaultFileName(const aFileName: WideString; const aPassword: WideString); safecall;
    procedure SetCursor(aCursor: Integer); safecall;
    procedure RestoreCursor; safecall;
    function Get_DataModelServer: IUnknown; safecall;
    procedure Set_DataModelServer(const Value: IUnknown); safecall;
    property ProgID: WideString read Get_ProgID write Set_ProgID;
    property DataModelAlias: WideString read Get_DataModelAlias write Set_DataModelAlias;
    property DataModelFileExt: WideString read Get_DataModelFileExt write Set_DataModelFileExt;
    property DocumentProgID: WideString read Get_DocumentProgID write Set_DocumentProgID;
    property DataModel: IUnknown read Get_DataModel;
    property RefDataModel: IUnknown read Get_RefDataModel write Set_RefDataModel;
    property FormCount[Position: Integer]: Integer read Get_FormCount;
    property Form[Index: Integer; Position: Integer]: IDMForm read Get_Form;
    property ActiveForm: IDMForm read Get_ActiveForm write Set_ActiveForm;
    property AnalyzerProgID: WideString read Get_AnalyzerProgID write Set_AnalyzerProgID;
    property FormVisible[Index: Integer; Position: Integer]: WordBool read Get_FormVisible write Set_FormVisible;
    property RegistryKey: WideString read Get_RegistryKey write Set_RegistryKey;
    property LastSavedFileCount: Integer read Get_LastSavedFileCount;
    property LastSavedFile[Index: Integer]: WideString read Get_LastSavedFile;
    property Changing: WordBool read Get_Changing;
    property PasswordRequired: WordBool read Get_PasswordRequired write Set_PasswordRequired;
    property TabIndex: Integer read Get_TabIndex write Set_TabIndex;
    property OutlookPanelVisible: WordBool read Get_OutlookPanelVisible write Set_OutlookPanelVisible;
    property DataModelServer: IUnknown read Get_DataModelServer write Set_DataModelServer;
  end;

// *********************************************************************//
// DispIntf:  IDMEditorXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5311CE61-0694-11D5-845E-C1351F961A12}
// *********************************************************************//
  IDMEditorXDisp = dispinterface
    ['{5311CE61-0694-11D5-845E-C1351F961A12}']
    procedure NewDataModel; dispid 16;
    function LoadDataModel(const aFileName: WideString; WriteToRegistryFlag: WordBool): WordBool; dispid 17;
    procedure SaveDataModel; dispid 18;
    procedure SaveDataModelAs; dispid 19;
    procedure CloseDataModel; dispid 20;
    property ProgID: WideString dispid 24;
    property DataModelAlias: WideString dispid 25;
    property DataModelFileExt: WideString dispid 26;
    property DocumentProgID: WideString dispid 1;
    procedure AddForm(FormClassGUID: {??TGUID}OleVariant; Position: Integer; 
                      const FormName: WideString); dispid 2;
    property DataModel: IUnknown readonly dispid 3;
    procedure DoAction(ActionCode: Integer; ActiveFormOnly: WordBool); dispid 5;
    property RefDataModel: IUnknown dispid 6;
    property FormCount[Position: Integer]: Integer readonly dispid 7;
    property Form[Index: Integer; Position: Integer]: IDMForm readonly dispid 8;
    property ActiveForm: IDMForm dispid 9;
    procedure StartAnalysis(aMode: Integer); dispid 10;
    property AnalyzerProgID: WideString dispid 11;
    property FormVisible[Index: Integer; Position: Integer]: WordBool dispid 12;
    procedure AddFormButton(Tag: Integer; ResourceInstanceHandle: Integer; 
                            const ResourceName: WideString; const Hint: WideString; 
                            FormPosition: Integer; Down: WordBool); dispid 14;
    property RegistryKey: WideString dispid 13;
    property LastSavedFileCount: Integer readonly dispid 15;
    property LastSavedFile[Index: Integer]: WideString readonly dispid 21;
    property Changing: WordBool readonly dispid 22;
    procedure SetState(TopFormIndex: Integer; BottomFormIndex: Integer; ActivePanel: Integer; 
                       CurrentElementClassID: Integer; CurrentElementID: Integer; 
                       CurrentCollectionIndex: Integer; CurrentObjectExpanded: Integer; 
                       TopElementClassID: Integer; TopElementID: Integer; 
                       TopCollectionIndex: Integer; LastClassIndex: Integer; 
                       LastKindIndex: Integer; LastSubKindIndex: Integer; Ratio: Double); dispid 27;
    procedure SetState2(LastClassIndex: Integer; LastSubKindIndex: Integer); dispid 23;
    procedure DuplicateActiveForm; dispid 28;
    property PasswordRequired: WordBool dispid 29;
    property TabIndex: Integer dispid 30;
    procedure MakeOutlookBar; dispid 35;
    property OutlookPanelVisible: WordBool dispid 36;
    procedure SetDefaultFileName(const aFileName: WideString; const aPassword: WideString); dispid 38;
    procedure SetCursor(aCursor: Integer); dispid 37;
    procedure RestoreCursor; dispid 39;
    property DataModelServer: IUnknown dispid 4;
  end;

// *********************************************************************//
// Interface: IDMForm
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {99FFB6A1-1092-11D6-9329-0050BA51A6D3}
// *********************************************************************//
  IDMForm = interface(IDispatch)
    ['{99FFB6A1-1092-11D6-9329-0050BA51A6D3}']
    function DoAction(ActionCode: Integer): WordBool; safecall;
    function Get_DataModelServer: IUnknown; safecall;
    procedure Set_DataModelServer(const Value: IUnknown); safecall;
    procedure DocumentOperation(DMElement: OleVariant; DMCollection: OleVariant; 
                                DMOperation: Integer; nItemIndex: Integer); safecall;
    procedure OpenDocument; safecall;
    procedure CloseDocument; safecall;
    procedure RefreshDocument(FlagSet: Integer); safecall;
    procedure SelectionChanged(DMElement: OleVariant); safecall;
    function Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    function Get_DMEditorX: IDMEditorX; safecall;
    procedure Set_DMEditorX(const Value: IDMEditorX); safecall;
    function Get_ToolButtonCount: Integer; safecall;
    procedure GetToolButtonProperties(Index: Integer; var aToolBarTag: Integer; 
                                      var aButtonImageIndex: Integer; var aButtonTag: Integer; 
                                      var aStyle: Integer; var aMode: Integer; var aHint: WideString); safecall;
    function Get_ToolButtonImageCount: Integer; safecall;
    function Get_ToolButtonImage(Index: Integer): WideString; safecall;
    function Get_InstanceHandle: Integer; safecall;
    function Get_FormID: Integer; safecall;
    procedure Set_FormID(Value: Integer); safecall;
    procedure SetCursor(aCursor: Integer); safecall;
    procedure RestoreCursor; safecall;
    procedure CheckDocumentState; safecall;
    procedure SetCurrentElement(DMElement: OleVariant); safecall;
    function Get_FormClassGUID: TGUID; safecall;
    procedure Set_FormClassGUID(Value: TGUID); safecall;
    procedure StopAnalysis(Mode: Integer); safecall;
    procedure StartAnalysis(Mode: Integer); safecall;
    procedure RefreshElement(DMElement: OleVariant); safecall;
    procedure RestoreState; safecall;
    procedure SaveState; safecall;
    procedure UpdateDocument; safecall;
    function Get_FormName: WideString; safecall;
    procedure Set_FormName(const Value: WideString); safecall;
    procedure CallCustomDialog(Mode: Integer; const aCaption: WideString; const aPrompt: WideString); safecall;
    function Get_ChangingParent: WordBool; safecall;
    procedure Set_ChangingParent(Value: WordBool); safecall;
    property DataModelServer: IUnknown read Get_DataModelServer write Set_DataModelServer;
    property Mode: Integer read Get_Mode write Set_Mode;
    property DMEditorX: IDMEditorX read Get_DMEditorX write Set_DMEditorX;
    property ToolButtonCount: Integer read Get_ToolButtonCount;
    property ToolButtonImageCount: Integer read Get_ToolButtonImageCount;
    property ToolButtonImage[Index: Integer]: WideString read Get_ToolButtonImage;
    property InstanceHandle: Integer read Get_InstanceHandle;
    property FormID: Integer read Get_FormID write Set_FormID;
    property FormClassGUID: TGUID read Get_FormClassGUID write Set_FormClassGUID;
    property FormName: WideString read Get_FormName write Set_FormName;
    property ChangingParent: WordBool read Get_ChangingParent write Set_ChangingParent;
  end;

// *********************************************************************//
// DispIntf:  IDMFormDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {99FFB6A1-1092-11D6-9329-0050BA51A6D3}
// *********************************************************************//
  IDMFormDisp = dispinterface
    ['{99FFB6A1-1092-11D6-9329-0050BA51A6D3}']
    function DoAction(ActionCode: Integer): WordBool; dispid 1;
    property DataModelServer: IUnknown dispid 2;
    procedure DocumentOperation(DMElement: OleVariant; DMCollection: OleVariant; 
                                DMOperation: Integer; nItemIndex: Integer); dispid 3;
    procedure OpenDocument; dispid 4;
    procedure CloseDocument; dispid 5;
    procedure RefreshDocument(FlagSet: Integer); dispid 6;
    procedure SelectionChanged(DMElement: OleVariant); dispid 7;
    property Mode: Integer dispid 8;
    property DMEditorX: IDMEditorX dispid 9;
    property ToolButtonCount: Integer readonly dispid 11;
    procedure GetToolButtonProperties(Index: Integer; var aToolBarTag: Integer; 
                                      var aButtonImageIndex: Integer; var aButtonTag: Integer; 
                                      var aStyle: Integer; var aMode: Integer; var aHint: WideString); dispid 12;
    property ToolButtonImageCount: Integer readonly dispid 13;
    property ToolButtonImage[Index: Integer]: WideString readonly dispid 15;
    property InstanceHandle: Integer readonly dispid 10;
    property FormID: Integer dispid 14;
    procedure SetCursor(aCursor: Integer); dispid 16;
    procedure RestoreCursor; dispid 17;
    procedure CheckDocumentState; dispid 18;
    procedure SetCurrentElement(DMElement: OleVariant); dispid 19;
    property FormClassGUID: {??TGUID}OleVariant dispid 21;
    procedure StopAnalysis(Mode: Integer); dispid 20;
    procedure StartAnalysis(Mode: Integer); dispid 22;
    procedure RefreshElement(DMElement: OleVariant); dispid 23;
    procedure RestoreState; dispid 25;
    procedure SaveState; dispid 24;
    procedure UpdateDocument; dispid 26;
    property FormName: WideString dispid 27;
    procedure CallCustomDialog(Mode: Integer; const aCaption: WideString; const aPrompt: WideString); dispid 28;
    property ChangingParent: WordBool dispid 29;
  end;

// *********************************************************************//
// Interface: ITreeViewForm
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1413F641-3CBD-11D7-97F0-0050BA51A6D3}
// *********************************************************************//
  ITreeViewForm = interface(IDispatch)
    ['{1413F641-3CBD-11D7-97F0-0050BA51A6D3}']
    function Get_CurrentElement: IUnknown; safecall;
    procedure Set_CurrentElement(const Value: IUnknown); safecall;
    procedure GetTopObject(out aCurrentObject: IUnknown; out CurrentObjectExpanded: WordBool; 
                           out aTopObject: IUnknown); safecall;
    procedure SetTopObject(const aCurrentObject: IUnknown; CurrentObjectExpanded: WordBool; 
                           const aTopObject: IUnknown); safecall;
    property CurrentElement: IUnknown read Get_CurrentElement write Set_CurrentElement;
  end;

// *********************************************************************//
// DispIntf:  ITreeViewFormDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1413F641-3CBD-11D7-97F0-0050BA51A6D3}
// *********************************************************************//
  ITreeViewFormDisp = dispinterface
    ['{1413F641-3CBD-11D7-97F0-0050BA51A6D3}']
    property CurrentElement: IUnknown dispid 1;
    procedure GetTopObject(out aCurrentObject: IUnknown; out CurrentObjectExpanded: WordBool; 
                           out aTopObject: IUnknown); dispid 2;
    procedure SetTopObject(const aCurrentObject: IUnknown; CurrentObjectExpanded: WordBool; 
                           const aTopObject: IUnknown); dispid 3;
  end;

// *********************************************************************//
// DispIntf:  IDMEditorXEvents
// Flags:     (4096) Dispatchable
// GUID:      {63417720-5B15-11D8-9946-0050BA51A6D3}
// *********************************************************************//
  IDMEditorXEvents = dispinterface
    ['{63417720-5B15-11D8-9946-0050BA51A6D3}']
    procedure OnVisibleFormChanged(Index: Integer; Position: Integer; Visible: WordBool); dispid 1;
    procedure OnAnalysisStop; dispid 2;
    procedure OnAnalysisStart; dispid 3;
  end;

// *********************************************************************//
// Interface: IDMMacrosManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {034DC31C-C7F1-4E18-B60C-3467409574EF}
// *********************************************************************//
  IDMMacrosManager = interface(IDispatch)
    ['{034DC31C-C7F1-4E18-B60C-3467409574EF}']
    procedure SwitchWriteMacros; safecall;
    procedure WriteMacrosEvent(RecordKind: Integer; FormID: Integer; ControlID: Integer; 
                               EventID: Integer; P1: Integer; P2: Integer; const S: WideString); safecall;
    procedure LoadMacros(const FileName: WideString); safecall;
    procedure PlayFirstStep(StartPos: Integer); safecall;
    procedure PlayNextStep; safecall;
    procedure StartMacrosStep(X1: Integer; Y1: Integer; CursorStepLength: Integer); safecall;
    function Get_IsPlaying: WordBool; safecall;
    function Get_IsWritingMacros: WordBool; safecall;
    procedure PauseMacros(Interval: Integer); safecall;
    procedure SetMenuItemPos(Command: Integer; X: Integer; Y: Integer); safecall;
    procedure ShowDemoMenu(const FileName: WideString); safecall;
    procedure WriteMacrosState; safecall;
    function Get_DemoSpeech: WordBool; safecall;
    procedure Set_DemoSpeech(Value: WordBool); safecall;
    function Get_DemoShowText: WordBool; safecall;
    procedure Set_DemoShowText(Value: WordBool); safecall;
    function Get_MacrosCursorSpeed: Double; safecall;
    procedure Set_MacrosCursorSpeed(Value: Double); safecall;
    function Get_MacrosPauseInterval: Integer; safecall;
    procedure Set_MacrosPauseInterval(Value: Integer); safecall;
    procedure PlayInputDialog(const WS: WideString); safecall;
    function Get_SpeechEngine: IUnknown; safecall;
    procedure Set_SpeechEngine(const Value: IUnknown); safecall;
    procedure Say(const Text: WideString; CanWait: WordBool; MaybeInterrupted: WordBool; 
                  MacrosPaused: WordBool); safecall;
    function Get_SpeechFlag: WordBool; safecall;
    procedure Set_SpeechFlag(Value: WordBool); safecall;
    procedure WriteAddRefMacros(aParentID: Integer; aID: Integer); safecall;
    procedure Write_AddRefMacros(aParentClassID: Integer; aParentID: Integer; aID: Integer); safecall;
    function Get_MainFormHandle: Integer; safecall;
    procedure Set_MainFormHandle(Value: Integer); safecall;
    property IsPlaying: WordBool read Get_IsPlaying;
    property IsWritingMacros: WordBool read Get_IsWritingMacros;
    property DemoSpeech: WordBool read Get_DemoSpeech write Set_DemoSpeech;
    property DemoShowText: WordBool read Get_DemoShowText write Set_DemoShowText;
    property MacrosCursorSpeed: Double read Get_MacrosCursorSpeed write Set_MacrosCursorSpeed;
    property MacrosPauseInterval: Integer read Get_MacrosPauseInterval write Set_MacrosPauseInterval;
    property SpeechEngine: IUnknown read Get_SpeechEngine write Set_SpeechEngine;
    property SpeechFlag: WordBool read Get_SpeechFlag write Set_SpeechFlag;
    property MainFormHandle: Integer read Get_MainFormHandle write Set_MainFormHandle;
  end;

// *********************************************************************//
// DispIntf:  IDMMacrosManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {034DC31C-C7F1-4E18-B60C-3467409574EF}
// *********************************************************************//
  IDMMacrosManagerDisp = dispinterface
    ['{034DC31C-C7F1-4E18-B60C-3467409574EF}']
    procedure SwitchWriteMacros; dispid 1;
    procedure WriteMacrosEvent(RecordKind: Integer; FormID: Integer; ControlID: Integer; 
                               EventID: Integer; P1: Integer; P2: Integer; const S: WideString); dispid 3;
    procedure LoadMacros(const FileName: WideString); dispid 2;
    procedure PlayFirstStep(StartPos: Integer); dispid 4;
    procedure PlayNextStep; dispid 6;
    procedure StartMacrosStep(X1: Integer; Y1: Integer; CursorStepLength: Integer); dispid 7;
    property IsPlaying: WordBool readonly dispid 8;
    property IsWritingMacros: WordBool readonly dispid 9;
    procedure PauseMacros(Interval: Integer); dispid 5;
    procedure SetMenuItemPos(Command: Integer; X: Integer; Y: Integer); dispid 10;
    procedure ShowDemoMenu(const FileName: WideString); dispid 12;
    procedure WriteMacrosState; dispid 11;
    property DemoSpeech: WordBool dispid 13;
    property DemoShowText: WordBool dispid 14;
    property MacrosCursorSpeed: Double dispid 15;
    property MacrosPauseInterval: Integer dispid 16;
    procedure PlayInputDialog(const WS: WideString); dispid 17;
    property SpeechEngine: IUnknown dispid 18;
    procedure Say(const Text: WideString; CanWait: WordBool; MaybeInterrupted: WordBool; 
                  MacrosPaused: WordBool); dispid 19;
    property SpeechFlag: WordBool dispid 20;
    procedure WriteAddRefMacros(aParentID: Integer; aID: Integer); dispid 21;
    procedure Write_AddRefMacros(aParentClassID: Integer; aParentID: Integer; aID: Integer); dispid 22;
    property MainFormHandle: Integer dispid 24;
  end;

// *********************************************************************//
// Interface: IDMMenu
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D53FAF41-6462-11D9-9A56-0050BA51A6D3}
// *********************************************************************//
  IDMMenu = interface(IDispatch)
    ['{D53FAF41-6462-11D9-9A56-0050BA51A6D3}']
    procedure AddMenuItem(ParentHandle: Integer; aHandle: Integer; aCommand: Integer; Pos: Integer; 
                          PX: Integer; PY: Integer; Left: Integer; Bottom: Integer); safecall;
    function Get_Handle: Integer; safecall;
    procedure Set_Handle(Value: Integer); safecall;
    property Handle: Integer read Get_Handle write Set_Handle;
  end;

// *********************************************************************//
// DispIntf:  IDMMenuDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D53FAF41-6462-11D9-9A56-0050BA51A6D3}
// *********************************************************************//
  IDMMenuDisp = dispinterface
    ['{D53FAF41-6462-11D9-9A56-0050BA51A6D3}']
    procedure AddMenuItem(ParentHandle: Integer; aHandle: Integer; aCommand: Integer; Pos: Integer; 
                          PX: Integer; PY: Integer; Left: Integer; Bottom: Integer); dispid 1;
    property Handle: Integer dispid 2;
  end;

// *********************************************************************//
// Interface: IDMMacrosPlayer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D72B7CAF-DCF9-40BF-ADEF-AFAD18EE07AF}
// *********************************************************************//
  IDMMacrosPlayer = interface(IDispatch)
    ['{D72B7CAF-DCF9-40BF-ADEF-AFAD18EE07AF}']
    function DoMacrosStep(RecordKind: Integer; ControlID: Integer; EventID: Integer; X: Integer; 
                          Y: Integer; const S: WideString): WordBool; safecall;
    procedure WriteMacrosState; safecall;
    procedure SetMacrosState(ParamID: Integer; Z: Integer; X: Integer; Y: Integer); safecall;
    procedure CloseActiveWindow; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMMacrosPlayerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D72B7CAF-DCF9-40BF-ADEF-AFAD18EE07AF}
// *********************************************************************//
  IDMMacrosPlayerDisp = dispinterface
    ['{D72B7CAF-DCF9-40BF-ADEF-AFAD18EE07AF}']
    function DoMacrosStep(RecordKind: Integer; ControlID: Integer; EventID: Integer; X: Integer; 
                          Y: Integer; const S: WideString): WordBool; dispid 1;
    procedure WriteMacrosState; dispid 3;
    procedure SetMacrosState(ParamID: Integer; Z: Integer; X: Integer; Y: Integer); dispid 4;
    procedure CloseActiveWindow; dispid 5;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDMEditorX
// Help String      : 
// Default Interface: IDMEditorX
// Def. Intf. DISP? : No
// Event   Interface: IDMEditorXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDMEditorXOnVisibleFormChanged = procedure(Sender: TObject; Index: Integer; Position: Integer; 
                                                              Visible: WordBool) of object;

  TDMEditorX = class(TOleControl)
  private
    FOnVisibleFormChanged: TDMEditorXOnVisibleFormChanged;
    FOnAnalysisStop: TNotifyEvent;
    FOnAnalysisStart: TNotifyEvent;
    FIntf: IDMEditorX;
    function  GetControlInterface: IDMEditorX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_DataModel: IUnknown;
    function Get_RefDataModel: IUnknown;
    procedure Set_RefDataModel(const Value: IUnknown);
    function Get_FormCount(Position: Integer): Integer;
    function Get_Form(Index: Integer; Position: Integer): IDMForm;
    function Get_ActiveForm: IDMForm;
    procedure Set_ActiveForm(const Value: IDMForm);
    function Get_FormVisible(Index: Integer; Position: Integer): WordBool;
    procedure Set_FormVisible(Index: Integer; Position: Integer; Value: WordBool);
    function Get_LastSavedFile(Index: Integer): WideString;
    function Get_DataModelServer: IUnknown;
    procedure Set_DataModelServer(const Value: IUnknown);
  public
    procedure NewDataModel;
    function LoadDataModel(const aFileName: WideString; WriteToRegistryFlag: WordBool): WordBool;
    procedure SaveDataModel;
    procedure SaveDataModelAs;
    procedure CloseDataModel;
    procedure AddForm(FormClassGUID: TGUID; Position: Integer; const FormName: WideString);
    procedure DoAction(ActionCode: Integer; ActiveFormOnly: WordBool);
    procedure StartAnalysis(aMode: Integer);
    procedure AddFormButton(Tag: Integer; ResourceInstanceHandle: Integer; 
                            const ResourceName: WideString; const Hint: WideString; 
                            FormPosition: Integer; Down: WordBool);
    procedure SetState(TopFormIndex: Integer; BottomFormIndex: Integer; ActivePanel: Integer; 
                       CurrentElementClassID: Integer; CurrentElementID: Integer; 
                       CurrentCollectionIndex: Integer; CurrentObjectExpanded: Integer; 
                       TopElementClassID: Integer; TopElementID: Integer; 
                       TopCollectionIndex: Integer; LastClassIndex: Integer; 
                       LastKindIndex: Integer; LastSubKindIndex: Integer; Ratio: Double);
    procedure SetState2(LastClassIndex: Integer; LastSubKindIndex: Integer);
    procedure DuplicateActiveForm;
    procedure MakeOutlookBar;
    procedure SetDefaultFileName(const aFileName: WideString; const aPassword: WideString);
    procedure SetCursor(aCursor: Integer);
    procedure RestoreCursor;
    property  ControlInterface: IDMEditorX read GetControlInterface;
    property  DefaultInterface: IDMEditorX read GetControlInterface;
    property DataModel: IUnknown index 3 read GetIUnknownProp;
    property RefDataModel: IUnknown index 6 read GetIUnknownProp write SetIUnknownProp;
    property FormCount[Position: Integer]: Integer read Get_FormCount;
    property Form[Index: Integer; Position: Integer]: IDMForm read Get_Form;
    property FormVisible[Index: Integer; Position: Integer]: WordBool read Get_FormVisible write Set_FormVisible;
    property LastSavedFileCount: Integer index 15 read GetIntegerProp;
    property LastSavedFile[Index: Integer]: WideString read Get_LastSavedFile;
    property Changing: WordBool index 22 read GetWordBoolProp;
    property DataModelServer: IUnknown index 4 read GetIUnknownProp write SetIUnknownProp;
  published
    property ProgID: WideString index 24 read GetWideStringProp write SetWideStringProp stored False;
    property DataModelAlias: WideString index 25 read GetWideStringProp write SetWideStringProp stored False;
    property DataModelFileExt: WideString index 26 read GetWideStringProp write SetWideStringProp stored False;
    property DocumentProgID: WideString index 1 read GetWideStringProp write SetWideStringProp stored False;
    property ActiveForm: IDMForm read Get_ActiveForm write Set_ActiveForm stored False;
    property AnalyzerProgID: WideString index 11 read GetWideStringProp write SetWideStringProp stored False;
    property RegistryKey: WideString index 13 read GetWideStringProp write SetWideStringProp stored False;
    property PasswordRequired: WordBool index 29 read GetWordBoolProp write SetWordBoolProp stored False;
    property TabIndex: Integer index 30 read GetIntegerProp write SetIntegerProp stored False;
    property OutlookPanelVisible: WordBool index 36 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnVisibleFormChanged: TDMEditorXOnVisibleFormChanged read FOnVisibleFormChanged write FOnVisibleFormChanged;
    property OnAnalysisStop: TNotifyEvent read FOnAnalysisStop write FOnAnalysisStop;
    property OnAnalysisStart: TNotifyEvent read FOnAnalysisStart write FOnAnalysisStart;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TDMEditorX.InitControlData;
const
  CEventDispIDs: array [0..2] of DWORD = (
    $00000001, $00000002, $00000003);
  CControlData: TControlData2 = (
    ClassID: '{3ABC9803-5632-11D8-9941-0050BA51A6D3}';
    EventIID: '{63417720-5B15-11D8-9946-0050BA51A6D3}';
    EventCount: 3;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80040154*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnVisibleFormChanged) - Cardinal(Self);
end;

procedure TDMEditorX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDMEditorX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDMEditorX.GetControlInterface: IDMEditorX;
begin
  CreateControl;
  Result := FIntf;
end;

function TDMEditorX.Get_DataModel: IUnknown;
begin
    Result := DefaultInterface.DataModel;
end;

function TDMEditorX.Get_RefDataModel: IUnknown;
begin
    Result := DefaultInterface.RefDataModel;
end;

procedure TDMEditorX.Set_RefDataModel(const Value: IUnknown);
begin
  Exit;
end;

function TDMEditorX.Get_FormCount(Position: Integer): Integer;
begin
    Result := DefaultInterface.FormCount[Position];
end;

function TDMEditorX.Get_Form(Index: Integer; Position: Integer): IDMForm;
begin
    Result := DefaultInterface.Form[Index, Position];
end;

function TDMEditorX.Get_ActiveForm: IDMForm;
begin
    Result := DefaultInterface.ActiveForm;
end;

procedure TDMEditorX.Set_ActiveForm(const Value: IDMForm);
begin
  Exit;
end;

function TDMEditorX.Get_FormVisible(Index: Integer; Position: Integer): WordBool;
begin
    Result := DefaultInterface.FormVisible[Index, Position];
end;

procedure TDMEditorX.Set_FormVisible(Index: Integer; Position: Integer; Value: WordBool);
begin
  Exit;
end;

function TDMEditorX.Get_LastSavedFile(Index: Integer): WideString;
begin
    Result := DefaultInterface.LastSavedFile[Index];
end;

function TDMEditorX.Get_DataModelServer: IUnknown;
begin
    Result := DefaultInterface.DataModelServer;
end;

procedure TDMEditorX.Set_DataModelServer(const Value: IUnknown);
begin
  Exit;
end;

procedure TDMEditorX.NewDataModel;
begin
  DefaultInterface.NewDataModel;
end;

function TDMEditorX.LoadDataModel(const aFileName: WideString; WriteToRegistryFlag: WordBool): WordBool;
begin
  Result := DefaultInterface.LoadDataModel(aFileName, WriteToRegistryFlag);
end;

procedure TDMEditorX.SaveDataModel;
begin
  DefaultInterface.SaveDataModel;
end;

procedure TDMEditorX.SaveDataModelAs;
begin
  DefaultInterface.SaveDataModelAs;
end;

procedure TDMEditorX.CloseDataModel;
begin
  DefaultInterface.CloseDataModel;
end;

procedure TDMEditorX.AddForm(FormClassGUID: TGUID; Position: Integer; const FormName: WideString);
begin
  DefaultInterface.AddForm(FormClassGUID, Position, FormName);
end;

procedure TDMEditorX.DoAction(ActionCode: Integer; ActiveFormOnly: WordBool);
begin
  DefaultInterface.DoAction(ActionCode, ActiveFormOnly);
end;

procedure TDMEditorX.StartAnalysis(aMode: Integer);
begin
  DefaultInterface.StartAnalysis(aMode);
end;

procedure TDMEditorX.AddFormButton(Tag: Integer; ResourceInstanceHandle: Integer; 
                                   const ResourceName: WideString; const Hint: WideString; 
                                   FormPosition: Integer; Down: WordBool);
begin
  DefaultInterface.AddFormButton(Tag, ResourceInstanceHandle, ResourceName, Hint, FormPosition, Down);
end;

procedure TDMEditorX.SetState(TopFormIndex: Integer; BottomFormIndex: Integer; 
                              ActivePanel: Integer; CurrentElementClassID: Integer; 
                              CurrentElementID: Integer; CurrentCollectionIndex: Integer; 
                              CurrentObjectExpanded: Integer; TopElementClassID: Integer; 
                              TopElementID: Integer; TopCollectionIndex: Integer; 
                              LastClassIndex: Integer; LastKindIndex: Integer; 
                              LastSubKindIndex: Integer; Ratio: Double);
begin
  DefaultInterface.SetState(TopFormIndex, BottomFormIndex, ActivePanel, CurrentElementClassID, 
                            CurrentElementID, CurrentCollectionIndex, CurrentObjectExpanded, 
                            TopElementClassID, TopElementID, TopCollectionIndex, LastClassIndex, 
                            LastKindIndex, LastSubKindIndex, Ratio);
end;

procedure TDMEditorX.SetState2(LastClassIndex: Integer; LastSubKindIndex: Integer);
begin
  DefaultInterface.SetState2(LastClassIndex, LastSubKindIndex);
end;

procedure TDMEditorX.DuplicateActiveForm;
begin
  DefaultInterface.DuplicateActiveForm;
end;

procedure TDMEditorX.MakeOutlookBar;
begin
  DefaultInterface.MakeOutlookBar;
end;

procedure TDMEditorX.SetDefaultFileName(const aFileName: WideString; const aPassword: WideString);
begin
  DefaultInterface.SetDefaultFileName(aFileName, aPassword);
end;

procedure TDMEditorX.SetCursor(aCursor: Integer);
begin
  DefaultInterface.SetCursor(aCursor);
end;

procedure TDMEditorX.RestoreCursor;
begin
  DefaultInterface.RestoreCursor;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDMEditorX]);
end;

end.
