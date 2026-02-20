unit DMContainerU;

{$WARN SYMBOL_PLATFORM OFF}

//{$INCLUDE SprutikDEF.inc}


interface

uses
  DM_Messages, DM_Windows,
  DM_AxCtrls, OleCtrls,
  Types, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, SyncObjs,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, IniFiles,//Registry,
  DataModel_TLB, DMEditor_TLB, DMServer_TLB,
  DMToolBar, Buttons, DMMenu, DMPageU,
{$IFDEF Outlook}
  fcClearPanel, fcButtonGroup, fcOutlookBar, fcOutlookList,
  fcChangeLink,  fcButton, fcCommon, fcShapeBtn, fcImgBtn, fcCollection,
{$ELSE}
  MyOutlookView,
{$ENDIF}
  AddRefFrm, _AddRefFrm, ChangeRefFrm, ComObj;


const
  WM_NextAnalysisStage=WM_User+901;
  WM_NextAnalysisStep=WM_User+902;
  WM_AnalysisError=WM_User+903;
  WM_RefreshDocument=WM_User+904;

  ColorDialogEventId=8888;

  deAddRefInit=4;
  deAddRefKind=5;
  deAddRefSubKind=6;
  deAddRefName=7;
  de_AddRefInit=8;
  de_AddRefClass=9;
  de_AddRefKind=10;
  de_AddRefSubKind=11;
  de_AddRefName=12;
  deDelete=13;
  deInputName=14;
  deInputInteger=16;
  
const
  SuffixDivider='/';

type
  TOnVisibleFormChangedEvent=procedure(Sender: TObject; Index: Integer;
                     Position: Integer; Visible: WordBool) of object;

  TDMContainer = class(TForm, IDMEditorX,
{$IFDEF Demo}
                       IDMMacrosManager,
{$ENDIF}                       
                       IDMMenu, IDMServerEvents)
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    ImageList2: TImageList;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    ControlBar0: TControlBar;
    ToolBar1: TToolBar;
    tbNewDataModel: TToolButton;
    tbLoadDataModel: TToolButton;
    tbSaveDataModel: TToolButton;
    miPrint: TToolButton;
    ToolButton4: TToolButton;
    tbDelete: TToolButton;
    tbCopy: TToolButton;
    tbPaste: TToolButton;
    ToolButton8: TToolButton;
    tbUndo: TToolButton;
    tbRedo: TToolButton;
    ToolButton1: TToolButton;
    tbAnalysis: TToolButton;
    SaveDialog1: TSaveDialog;
    Panel3: TPanel;
    btCloseDocument: TSpeedButton;
    Panel4: TPanel;
    TabControl: TTabControl;
    Splitter3: TSplitter;
    pnTop: TPanel;
    pnBottom: TPanel;
    OutlookPanel: TPanel;
    tbForms: TToolBar;
    
    procedure tbNewDataModelClick(Sender: TObject);
    procedure tbLoadDataModelClick(Sender: TObject);
    procedure tbSaveDataModelClick(Sender: TObject);
    procedure tbUndoClick(Sender: TObject);
    procedure tbRedoClick(Sender: TObject);
    procedure tbCopyClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbPasteClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure tbAnalysisClick(Sender: TObject);
    procedure miPrintClick(Sender: TObject);
    procedure StatusBar1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter3Moved(Sender: TObject);
    procedure btCloseDocumentClick(Sender: TObject);
    procedure TabControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ActiveFormCreate(Sender: TObject);
    procedure TabControlResize(Sender: TObject);
    procedure FormResize(Sender: TObject);

  private

    FOnVisibleFormChanged:TOnVisibleFormChangedEvent;
    FWaitingForRefresh:boolean;

    FEvents: IDMEditorXEvents;

//    FProxy:TDataModelServer;

    FOpenDialog:TOpenDialog;
    FSaveDialog:TSaveDialog;
    FRegistryKey: string;
    FIniFileName: string;
    FApplicationVersion:string;

    FAnalysisStageName:string;
    FLoadStageName:string;
    FErrorMessage:string;

    FFormXList0:TList;
    FFormXList1:TList;

    FActiveForm:pointer;
    FDuplicateForm:pointer;
    FForm0:pointer;
    FForm1:pointer;

    FRefDataModel: IUnknown;
    FDMToolBars:TList;

    FSeparatorBtnIndex:integer;
    FLastSavedFiles:TStringList;
    FChanging:WordBool;
    FOldLayoutName:array [0..255] of char;

    FTopFormIndex:integer;
    FBottomFormIndex:integer;

    FSplitterPosition:double;

    FPasswordRequired:WordBool;
    FAnalysisMode:integer;
    FActiveDMToolBar:TDMToolBar;

    FOutlookBar: TfcOutlookBar;
    FTopOutlookList:TfcOutlookList;
    FBottomOutlookList:TfcOutlookList;

    FDefaultFileName:WideString;
    FPassword:WideString;
    FCommonLibPath:WideString;

    FDMMainMenu:TDMMenuItem;

    FOldCursor:integer;


    procedure WMRefreshDocument(var Message: TMessage); message WM_RefreshDocument;
    procedure WMNextAnalysisStage(var Message: TMessage); message WM_NextAnalysisStage;
    procedure WMNextAnalysisStep(var Message: TMessage); message WM_NextAnalysisStep;
    procedure WMAnalysisError(var Message: TMessage); message WM_AnalysisError;
    procedure NextLoadStage(const StageName:WideString; Stage, StepCount:integer);

    procedure btForm0Click(Sender: TObject);
    procedure btForm1Click(Sender: TObject);
    procedure WriteToRegistry(const aFileName:string);
    procedure ReadFromRegistry;
    procedure SetCursor(aCursor:integer); safecall;
    procedure RestoreCursor; safecall;
    procedure AddForm(FormClassGUID: TGUID; Position: Integer;
      const FormName: WideString); safecall;
    procedure VisibleFormChanged(Index, Position: Integer; Visible:WordBool);
    procedure AnalysisStart;
    procedure AnalysisStop;
    procedure SaveFormState;

{$IFDEF Outlook}
    procedure CreateOutlookBar;
    procedure OutlookListItemsClick(OutlookList: TfcCustomOutlookList;
                                    Item: TfcOutlookListItem);
{$ENDIF}
    function Get_Page(Index, Position: Integer): TDMPage;
  protected
    FFormList0:TList;
    FFormList1:TList;
    FActiveFormPosition:integer;

    FDataModelServer: IDataModelServer;
    FLastClassIndex:integer;
    FLastKindIndex:integer;

{$IFDEF Demo}
    FDMMacrosManager:IDMMacrosManager;
{$ENDIF}

    FAddRefForm:TfmAddRef;

    procedure DoOpenDocument; virtual;

    procedure ShowHiddenStatusBar;

    function Get_ProgID: WideString; safecall;
    procedure Set_ProgID(const Value: WideString); safecall;
    function Get_DocumentProgID: WideString; safecall;
    procedure Set_DocumentProgID(const Value: WideString); safecall;
    function Get_DataModelAlias: WideString; safecall;
    function Get_DataModelFileExt: WideString; safecall;
    procedure Set_DataModelAlias(const Value: WideString); safecall;
    procedure Set_DataModelFileExt(const Value: WideString); safecall;
    function Get_LibraryPath:WideString; safecall;
    procedure Set_LibraryPath(const Value:WideString); safecall;
    function Get_IniFileName:WideString; safecall;
    procedure Set_IniFileName(const Value:WideString); safecall;
    function Get_ApplicationVersion:WideString; safecall;
    procedure Set_ApplicationVersion(const Value:WideString); safecall;

    procedure Undo;
    procedure Redo;
//{$IFDEF VER150}
    procedure ProxyDocumentOperation(Sender: TObject;
                               const ElementsV: IUnknown;
                               const CollectionV: IUnknown;
                               DMOperation: Integer;
                               nItemIndex: Integer);
    procedure ProxySelectionChanged(Sender: TObject;
                                    const DMElementU:IUnknown);
    procedure ProxyCallRefDialog(Sender: TObject;
                               const DMClassCollectionsU: IUnknown;
                               const RefSourceU: IUnknown;
                               const Suffix: WideString;
                               AskName: WordBool); virtual;

    procedure ProxyCallDialog(Sender: TObject;
                              Mode: integer;
                              const aCaption: WideString;
                              const aPrompt: WideString); virtual;
    procedure ProxyNextAnalysisStage(Sender: TObject;
                               const StageName: WideString;
                               Stage: Integer;
                               StepCount: Integer);
    procedure ProxyNextLoadStage(Sender: TObject;
                               const StageName: WideString;
                               Stage: Integer;
                               StepCount: Integer);
    procedure ProxyRefreshElement(Sender: TObject;
                               const ElementU: IUnknown);
    procedure ProxyChangeCurrentObject(Sender: TObject;
                                       const ObjU: IUnknown;
                                       const DMFormU: IUnknown);
(*
{$ELSE}
    procedure ProxyDocumentOperation(Sender: TObject;
                               var ElementsV: OleVariant;
                               var CollectionV: OleVariant;
                               DMOperation: Integer;
                               nItemIndex: Integer);
    procedure ProxySelectionChanged(Sender: TObject; var DMElementU:OleVariant);

    procedure ProxyCallRefDialog(Sender: TObject;
                               var DMClassCollectionsV: OleVariant;
                               var RefSourceV: OleVariant;
                               var Suffix: OleVariant;
                               AskName: WordBool);  virtual;

    procedure ProxyCallDialog(Sender: TObject;
                              Mode: integer;
                              var aCaption: OleVariant;
                              var aPrompt: OleVariant);  virtual;
    procedure ProxyNextAnalysisStage(Sender: TObject;
                               var StageName: OleVariant;
                               Stage: Integer;
                               StepCount: Integer);

    procedure ProxyNextLoadStage(Sender: TObject;
                               var StageName: OleVariant;
                               Stage: Integer;
                               StepCount: Integer);
    procedure ProxyRefreshElement(Sender: TObject;
                             var ElementV: OleVariant);
    procedure ProxyChangeCurrentObject(Sender: TObject;
                                       var ObjV: OleVariant;
                                       var DMFormV: OleVariant);
{$ENDIF}
*)
    procedure ProxyStopAnalysis(Sender: TObject);
    procedure ProxyOpenDocument(Sender: TObject);
    procedure ProxyCloseDocument(Sender: TObject);
    procedure ProxyRefreshDocument(Sender: TObject; FlagSet:integer);


    procedure ProxySetControlState(Sender: TObject;
                               ContolIndex, Index, Mode, State:integer);
    procedure ProxyOperationStepExecuted(Sender: TObject);

    procedure ProxyNextAnalysisStep(Sender: TObject;
                               Step: Integer);

    procedure UnselectAll; virtual;
    procedure CheckDocumentState; virtual;
    function Get_DataModel: IUnknown; safecall;
    procedure Set_DataModelServer(const Value: IUnknown); safecall;
    function Get_DataModelServer: IUnknown; safecall;
    procedure DoAction(ActionCode: Integer; ActiveFormOnly: WordBool);
      safecall;
    procedure NewDataModel; virtual; safecall;
    function LoadDataModel(const aFileName: WideString;
      WriteToRegistryFlag: WordBool): WordBool; virtual; safecall;
    procedure SaveDataModel; safecall;
    procedure SaveDataModelAs; safecall;
    procedure CloseDataModel; safecall;
    function Get_RefDataModel: IUnknown; safecall;
    procedure Set_RefDataModel(const Value: IUnknown); safecall;
    function Get_Form(Index, Position: Integer): IDMForm; safecall;
    function Get_FormCount(Position: Integer): Integer; safecall;
    function Get_ActiveForm: IDMForm; safecall;
    procedure Set_ActiveForm(const Value: IDMForm); virtual; safecall;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure StartAnalysis(aMode: Integer); safecall;
    function Get_AnalyzerProgID: WideString; safecall;
    procedure Set_AnalyzerProgID(const Value: WideString); safecall;
    function Get_FormVisible(Index, Position: Integer): WordBool; safecall;
    procedure Set_FormVisible(Index, Position: Integer; Value: WordBool);
      safecall;
    procedure AddFormButton(Tag, ResourceInstanceHandle: Integer;
      const ResourceName, Hint: WideString; FormPosition: Integer;
      Down: WordBool); safecall;
    function Get_LastSavedFile(Index: Integer): WideString; safecall;
    function Get_LastSavedFileCount: Integer; safecall;
    function Get_RegistryKey: WideString; safecall;
    procedure Set_RegistryKey(const Value: WideString); safecall;
    function Get_Changing: WordBool; safecall;
    procedure SetState(TopFormIndex, BottomFormIndex, ActivePanel,
      CurrentElementClassID, CurrentElementID, CurrentCollectionIndex,
      CurrentObjectExpanded, TopElementClassID, TopElementID,
      TopCollectionIndex, LastClassIndex, LastKindIndex,
      LastSubKindIndex: Integer; Ratio: Double); safecall;
    procedure DuplicateActiveForm; safecall;
    function Get_PasswordRequired: WordBool; safecall;
    procedure Set_PasswordRequired(Value: WordBool); safecall;
    function Get_TabIndex: Integer; safecall;
    procedure Set_TabIndex(Value: Integer); safecall;
    procedure Initialize; virtual;

    procedure MakeOutlookBar; safecall;
    function Get_OutlookPanelVisible: WordBool; safecall;
    procedure Set_OutlookPanelVisible(Value: WordBool); safecall;
    procedure SetDefaultFileName(const aFileName, aPassword:WideString); safecall;

//IDMMenu
    procedure AddMenuItem(ParentHandle, aHandle, aCommand, Pos, PX, PY, Left,
      Bottom: Integer); safecall;
    function Get_Handle: Integer; safecall;
    procedure Set_Handle(Value: Integer); safecall;

//IDMServerEvents
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
    procedure OnAnalysisError(const ErrorMessage: WideString); safecall;
    procedure OnCallDialog(Mode: Integer; const Caption: WideString; const Prompt: WideString); safecall;
    procedure OnChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown); safecall;
    procedure OnNextLoadStage(const StageName: WideString; Stage: Integer; StepCount: Integer); safecall;
    procedure OnStopAnalysis; safecall;
    procedure OnRefreshElement(const ElementU: IUnknown); safecall;


  public
    constructor Create(aOwner:TComponent; const aLibraryPath:string);
    destructor Destroy; override;
    procedure AddPage(DMPageClass:TDMPageClass; Position: Integer;
      const FormName: WideString); safecall;
    procedure GetForm(FormID:integer; var theForm:IDMForm; var theFormIndex, theFormPosition:integer);
    property OnVisibleFormChanged:TOnVisibleFormChangedEvent  read FOnVisibleFormChanged write FOnVisibleFormChanged;
{$IFDEF Demo}
    property DMMacrosManager:IDMMacrosManager read FDMMacrosManager implements IDMMacrosManager;
{$ENDIF}    
    property ActiveDMToolBar:TDMToolBar read FActiveDMToolBar;
    property Form0:pointer read FForm0;
    property Form1:pointer read FForm1;
    property FormList0:TList read FFormList0;
    property FormList1:TList read FFormList1;
    property LastClassIndex:integer read FLastClassIndex;
    property DMMainMenu:TDMMenuItem read FDMMainMenu;
    property AddRefForm:TfmAddRef read FAddRefForm;
  end;

  function ExtractLastWord(const S0:string):string;

implementation

uses
  DMEditorConstU, AnalysisProgressFrm,
  IntegerInputFrm, ConfirmationFrm, DeleteConfFrm, findFrm,
  PleaseWaitFrm, PasswordFrm,
{$IFDEF Demo}
  DemoNavigatorFrm, DemoMenuFrm, MacrosManagerU,
{$ENDIF}
  DMUtils;

{$R *.DFM}

{ TDMContainer }

var
  ColorDialog:TColorDialog;

type
  TGetDMClassFactory=function:IDMClassFactory;

procedure TDMContainer.Initialize;
var
  H:HMODULE;
  F:TGetDMClassFactory;
  LibName:array[0..255] of Char;
  DMSeverLibName:string;
  aServerFactory:IDMClassFactory;
begin
  inherited;
  DecimalSeparator:='.';

//  FDataModelServer:=CreateComObject(CLASS_DataModelServer) as IDataModelServer;

  DMSeverLibName:=FCommonLibPath+'DMServerLib.dll';
  StrPCopy(LibName, DMSeverLibName);
  H:=DM_LoadLibrary(LibName);
  @F:=DM_GetProcAddress(H, 'GetDMServerClassObject');
  aServerFactory:=F;
  FDataModelServer:=aServerFactory.CreateInstance as IDataModelServer;

  FFormList0:=TList.Create;
  FFormXList0:=TList.Create;
  FFormList1:=TList.Create;
  FFormXList1:=TList.Create;
  FDMToolBars:=TList.Create;
  tbForms.Width:=0;
  FLastSavedFiles:=TStringList.Create;
  FLastClassIndex:=-1;
  FLastKindIndex:=-1;
  FPasswordRequired:=False;
  FTopFormIndex:=-1;
  FBottomFormIndex:=-1;

  FOldCursor:=crDefault;

  FDMMainMenu:=TDMMenuItem.Create(Self);
{$IFDEF Demo}
  FDMMacrosManager:=TMacrosManager.Create(Self) as IDMMacrosManager;
{$ENDIF Demo}
end;

//*********************************

procedure ParseText(const S:string; Delimeter:char; const aList:TStrings);
var
  S0, S1:string;
  m:integer;
begin
  aList.Clear;
  S0:=S;
  m:=Pos(Delimeter, S0);
  while m<>0 do begin
    S1:=Copy(S0, 1, m-1);
    aList.Add(S1);
    Delete(S0, 1, m);
    m:=Pos(Delimeter, S0);
  end;
  aList.Add(S0);
end;


function ExtractString(const S:string; Index:integer):string;
var
  Delimeter:char;
  aList:TStringList;
  S1:string;
begin
  Result:='';
  if S='' then Exit;
  Delimeter:=S[1];
  S1:=S;
  Delete(S1, 1, 1);
  aList:=TStringList.Create;
  ParseText(S1, Delimeter, aList);
  if Index<aList.Count then
    Result:=aList[Index];
  aList.Free;
end;


procedure TDMContainer.NewDataModel;
var
  NewDocument:IDMDocument;
  DataModel:IDataModel;
begin
  SaveFormState;
  FDataModelServer.CreateNewDataModel(FRefDataModel);

  NewDocument:=FDataModelServer.CurrentDocument;
  DataModel:=NewDocument.DataModel as IDataModel;
  DataModel.ApplicationVersion:=FApplicationVersion;

  CheckDocumentState;
end;

function TDMContainer.LoadDataModel(const aFileName: WideString;
  WriteToRegistryFlag: WordBool): WordBool;
var
  DataModelAlias, DataModelFileExt:string;
  Document, NewDocument:IDMDocument;
  aDataModel:IDataModel;
  DataModelFilename:string;
  KeyboardState:TKeyboardState;
  OldForceCurrentDirectory:boolean;
  Password:String;

  function GetPassword:boolean;
  begin
    Password:='';
    if fmPassword=nil then
      fmPassword:=TfmPassword.Create(Self);
    fmPassword.lFileName.Caption:=FOpenDialog.FileName;
    if FPasswordRequired then begin
      if fmPassword.ShowModal=mrOK then begin
        Result:=True;
        Password:=fmPassword.edPassword.Text;
      end else
        Result:=False;
      FDataModelServer.RefreshDocument(rfFast);
    end else
      Result:=True
  end;

begin
  Result:=False;
  OldForceCurrentDirectory:=ForceCurrentDirectory;
  ForceCurrentDirectory:=True;
  try
  Document:=FDataModelServer.CurrentDocument;
  if Document<>nil then begin
    aDataModel:=Document.DataModel as IDataModel;
    DataModelFilename:=(aDataModel as IDMElement).Name;
    if DataModelFilename=rsNewModel then
      DataModelFilename:='';
  end else begin
    DataModelFilename:='';
    aDataModel:=nil;
  end;

  if FOpenDialog=nil then
    FOpenDialog:=TOpenDialog.Create(Self);

  DataModelAlias:=FDataModelServer.DataModelAlias;
  DataModelFileExt:=FDataModelServer.DataModelFileExt;
  FOpenDialog.Filter:=Format ('Файлы %s (*.%s)|*.%s|XML-файлы (*.xml)|*.xml',
             [DataModelAlias,
             DataModelFileExt,DataModelFileExt]);
  if aFileName='' then begin
    if DataModelFileName<>'' then
      FOpenDialog.InitialDir:=ExtractFilePath(DataModelFileName);
    FOpenDialog.FileName:=DataModelFileName;
    try
      if (aDataModel<>nil) and
         ((aDataModel.State and dmfDemo)<>0) then begin
        DM_GetKeyboardLayoutName(FOldLayoutName);
        DM_LoadKeyboardLayout('00000409',    //English
          KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

        DM_GetKeyboardState(KeyboardState);
        KeyboardState[VK_CAPITAL]:=0;
        DM_SetKeyboardState(KeyboardState);
      end;

      if Uppercase(FDataModelServer.InitialDir)<>'DEMO' then
        FOpenDialog.InitialDir:=FDataModelServer.InitialDir
      else
        FOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'DEMO';

      if FOpenDialog.Execute and GetPassword then begin
          DataModelFileName:=FOpenDialog.FileName;
          FOpenDialog.InitialDir:=ExtractFilePath(DataModelFileName);
          FDataModelServer.InitialDir:=FOpenDialog.InitialDir;
          SetCursor(ord(crHourGlass));
          SaveFormState;
          Result:=FDataModelServer.LoadDataModel(DataModelFileName, Password, FRefDataModel);
          if WriteToRegistryFlag then
            WriteToRegistry(DataModelFileName);
      end;
    finally
      Invalidate;
      RestoreCursor;
      if (Document<>nil) and
         ((aDataModel.State and dmfDemo)<>0) then begin
        DM_LoadKeyboardLayout(FOldLayoutName,
            KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
      end;
    end;
  end else begin
    try
      if GetPassword then begin
        DataModelFileName:=aFileName;
        SetCursor(ord(crHourGlass));
        SaveFormState;
        Result:=FDataModelServer.LoadDataModel(DataModelFileName, Password, FRefDataModel);
        WriteToRegistry(DataModelFileName);
      end;
    finally
      RestoreCursor;
    end;
  end;
  CheckDocumentState;

  NewDocument:=FDataModelServer.CurrentDocument;
  if NewDocument<>nil then begin
    aDataModel:=NewDocument.DataModel as IDataModel;
    if aDataModel.EmptyBackRefHolder<>nil then begin
      ShowMessage('Файл '+DataModelFileName+
                #13'содержит ссылки на удаленные объекты !'+
                #13'Проверьте эти ссылки в окне спецификации.');
      FDataModelServer.RefreshDocument(rfFast);
    end;
  end;

  finally
    ForceCurrentDirectory:=OldForceCurrentDirectory;
  end;
end;

procedure TDMContainer.SaveDataModel;
var
  Document:IDMDocument;
  DataModelFilename:string;
  DataModel:IDataModel;
begin
  Document:=FDataModelServer.CurrentDocument;
  if Document<>nil then begin
    DataModelFilename:=(Document.DataModel as IDMElement).Name;
    if DataModelFilename=rsNewModel then
      DataModelFilename:='';
  end else
    DataModelFilename:='';

  if (DataModelFileName='') or
     not FileExists(DataModelFileName) then
    SaveDataModelAs
  else begin
    try
      SetCursor(ord(crHourGlass));

      DataModel:=Document.DataModel as IDataModel;
      DataModel.ApplicationVersion:=FApplicationVersion;

      FDataModelServer.SaveDataModel(DataModelFileName);
    finally
      RestoreCursor;
    end;
  end;

  CheckDocumentState;
end;

procedure TDMContainer.SaveDataModelAs;
var
  DataModelAlias, DataModelFileExt,
  S, S1, SS1, OldFileName:string;
  N:integer;
  Document:IDMDocument;
  aDataModel:IDataModel;
  DataModelFilename:string;
  KeyboardState:TKeyboardState;
  SaveFlag:boolean;
  OldForceCurrentDirectory:boolean;
begin
  OldForceCurrentDirectory:=ForceCurrentDirectory;
  ForceCurrentDirectory:=True;
  try
  Document:=FDataModelServer.CurrentDocument;
  if Document<>nil then begin
    aDataModel:=Document.DataModel as IDataModel;
    DataModelFilename:=(aDataModel as IDMElement).Name;
    if DataModelFilename=rsNewModel then
      DataModelFilename:='';
  end else begin
    DataModelFilename:='';
    aDataModel:=nil;
  end;
  DataModelAlias:=FDataModelServer.DataModelAlias;
  DataModelFileExt:=FDataModelServer.DataModelFileExt;
  if FSaveDialog=nil then begin
    FSaveDialog:=TSaveDialog.Create(Self);
    FSaveDialog.DefaultExt:=DataModelFileExt;
    FSaveDialog.Filter:=Format ('Файлы %s (*.%s)|*.%s|XML-файлы (*.xml)|*.xml',
             [DataModelAlias,
             DataModelFileExt,DataModelFileExt]);
  end;

  if DataModelFileName<>'' then
    FSaveDialog.InitialDir:=ExtractFilePath(DataModelFileName);

  N:=1;
  S1:=IntToStr(N);
  S:=DataModelAlias+S1;

  if FSaveDialog.InitialDir<>'' then
    SS1:=FSaveDialog.InitialDir+'\'
  else
    SS1:='';
  SS1:=SS1+S+'.'+DataModelFileExt;

  while FileExists(SS1) do begin
    inc(N);
    S1:=IntToStr(N);
    S:=DataModelAlias+S1;
    if FSaveDialog.InitialDir<>'' then
      SS1:=FSaveDialog.InitialDir+'\'
    else
      SS1:='';
    SS1:=SS1+S+'.'+DataModelFileExt;
  end;
  OldFileName:=DataModelFileName;
  DataModelFileName:=SS1;

  try
  if (aDataModel.State and dmfDemo)<>0 then begin
    DM_GetKeyboardLayoutName(FOldLayoutName);
    DM_LoadKeyboardLayout('00000409',    //English
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

    DM_GetKeyboardState(KeyboardState);
    KeyboardState[VK_CAPITAL]:=0;
    DM_SetKeyboardState(KeyboardState);
  end;

    if Uppercase(FDataModelServer.InitialDir)<>'DEMO' then
      FSaveDialog.InitialDir:=FDataModelServer.InitialDir
    else
      FSaveDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'DEMO';

    FSaveDialog.FileName:=DataModelFileName;
    if FSaveDialog.Execute then begin
      DataModelFileName:=FSaveDialog.FileName;
      SaveFlag:=True;
      if FileExists(DataModelFileName) then begin
        if fmConfirmation=nil then
          fmConfirmation:=TfmConfirmation.Create(Self);
        fmConfirmation.Text:='Файл '+
                  DataModelFileName+
                  ' уже существует.  Заменить его?';
        if fmConfirmation.ShowModal <> mrYes then
          SaveFlag:=False;
        FDataModelServer.RefreshDocument(rfFast);
      end;
      if SaveFlag then begin
        FSaveDialog.InitialDir:=ExtractFilePath(DataModelFileName);
        FDataModelServer.InitialDir:=FSaveDialog.InitialDir;
        SetCursor(ord(crHourGlass));

        aDataModel:=Document.DataModel as IDataModel;
        aDataModel.ApplicationVersion:=FApplicationVersion;

        FDataModelServer.SaveDataModel(DataModelFileName);
        TabControl.Tabs[TabControl.TabIndex]:=ExtractFileName(DataModelFileName);
        WriteToRegistry(DataModelFileName)
      end;
    end;
  finally
    Invalidate;
    RestoreCursor;
    if (aDataModel.State and dmfDemo)<>0 then begin
      DM_LoadKeyboardLayout(FOldLayoutName,
        KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
    end;
  end;
  finally
    ForceCurrentDirectory:=OldForceCurrentDirectory;
  end;
end;

procedure TDMContainer.CloseDataModel;
var
  Document:IDMDocument;
  aDataModel:IDataModel;
begin
  Document:=FDataModelServer.CurrentDocument;
  if Document=nil then Exit;

  aDataModel:=Document.DataModel as IDataModel;
  if ((aDataModel.State and dmfModified)<>0) then begin
    if fmConfirmation=nil then
      fmConfirmation:=TfmConfirmation.Create(Self);
    fmConfirmation.Text:='Данные документа '+
                (Document.DataModel as IDMElement).Name+
                ' не сохранены.  Закрыть документ без сохранения?';
    if fmConfirmation.ShowModal <> mrYes then begin
      FDataModelServer.RefreshDocument(rfFast);
      Exit;
    end;
  end;
  FDataModelServer.CloseCurrentDocument;
end;

procedure TDMContainer.ProxyDocumentOperation(Sender: TObject;
//{$IFDEF VER150}
                               const ElementsV: IUnknown;
                               const CollectionV: IUnknown;
//{$ELSE}
//                               var ElementsV, CollectionV: OleVariant;
//{$ENDIF}
                               DMOperation, nItemIndex: Integer);

var
  j:integer;
begin
  try
   CheckDocumentState;
  for j:=0 to FFormList0.Count-1 do
    Get_Form(j, 0).DocumentOperation(ElementsV,
                   CollectionV, DMOperation,  nItemIndex);
  for j:=0 to FFormList1.Count-1 do
    Get_Form(j, 1).DocumentOperation(ElementsV,
                   CollectionV, DMOperation,  nItemIndex)
  except
   raise
  end;                   
end;

procedure TDMContainer.CheckDocumentState;
var
  DocumentState:integer;
  j:integer;
  aDataModel:IDataModel;
begin
  if FDataModelServer.CurrentDocument=nil then Exit;
  aDataModel:=FDataModelServer.CurrentDocument.DataModel as IDataModel;
  DocumentState:=aDataModel.State;
  tbUndo.Enabled:=(DocumentState and dmfCanUndo)<>0;
  tbRedo.Enabled:=(DocumentState and dmfCanRedo)<>0;
  tbSaveDataModel.Enabled:=(DocumentState and dmfModified)<>0;
  if tbSaveDataModel.Enabled then begin
    for j:=0 to FFormList0.Count-1 do
      Get_Form(j, 0).CheckDocumentState;
    for j:=0 to FFormList1.Count-1 do
      Get_Form(j, 1).CheckDocumentState;
  end;
end;

procedure TDMContainer.UnselectAll;
begin
  FDataModelServer.CurrentDocument.ClearSelection(nil);
end;

destructor TDMContainer.Destroy;
var
  j:integer;
  aDMForm:IDMForm;
begin
  FDataModelServer.CloseAll;

  for j:=0 to FFormList0.Count-1 do begin
    aDMForm:=Get_Form(j, 0);
    aDMForm.DataModelServer:=nil;
    aDMForm._Release;
  end;


  for j:=0 to FFormList1.Count-1 do begin
    aDMForm:=Get_Form(j, 1);
    aDMForm.DataModelServer:=nil;
    aDMForm._Release;
  end;

{$IFDEF Demo}
  FDMMacrosManager:=nil;
{$ENDIF}

  inherited;

  FDataModelServer:=nil;
  FActiveForm:=nil;
  FActiveDMToolBar:=nil;

  if FRefDataModel<>nil then begin
    (FRefDataModel as IDMElement).Clear;
    FRefDataModel:=nil;
  end;

  FFormList0.Free;
  FFormXList0.Free;
  FFormList1.Free;
  FFormXList1.Free;
  FDMToolBars.Free;
  FLastSavedFiles.Free;

end;

function TDMContainer.Get_ProgID: WideString;
begin
  if FDataModelServer<>nil then
    Result:=FDataModelServer.ProgID
  else
    Result:=''
end;

procedure TDMContainer.Set_ProgID(const Value: WideString);
var
  NewDocument:IDMDocument;
  DataModel:IDataModel;
begin
  if FDataModelServer<>nil then begin
    FDataModelServer.ProgID:=Value;
    SaveFormState;
    if FDefaultFileName='' then
      FDataModelServer.CreateNewDataModel(FRefDataModel)
    else
      FDataModelServer.LoadDataModel(FDefaultFileName, FPassword, FRefDataModel);

    NewDocument:=FDataModelServer.CurrentDocument;
    DataModel:=NewDocument.DataModel as IDataModel;
    DataModel.ApplicationVersion:=FApplicationVersion;

    CheckDocumentState;
  end;
end;

procedure TDMContainer.ProxyOpenDocument(Sender: TObject);
var
  aDataModel:IDataModel;
  S:string;
  Document:IDMDocument;
begin
  Document:=FDataModelServer.CurrentDocument;
  aDataModel:=Document.DataModel as IDataModel;
  S:=(aDataModel as IDMElement).Name;
  S:=ExtractFilename(S);
  TabControl.Tabs.Add(S);
  TabControl.TabIndex:=TabControl.Tabs.Count-1;
  TabControl.Visible:=True;

  DoOpenDocument;
end;

procedure TDMContainer.DoOpenDocument;
var
  j:integer;
  CopyBuffer:IDMCopyBuffer;
  Document:IDMDocument;
begin
  try
  for j:=0 to FFormList0.Count-1 do
    Get_Form(j, 0).OpenDocument;
  for j:=0 to FFormList1.Count-1 do
    Get_Form(j, 1).OpenDocument;

  ToolBar1.Enabled:=True;
  for j:=0 to ToolBar1.ButtonCount-1 do
    ToolBar1.Buttons[j].Enabled:=True;

  Document:=FDataModelServer.CurrentDocument;
  CopyBuffer:=Get_DataModelServer as IDMCopyBuffer;

  tbPaste.Enabled:=(CopyBuffer.BufferCount>0);
  tbCopy.Enabled:=(Document.SelectionCount>0);
  tbDelete.Enabled:=tbCopy.Enabled;

  CheckDocumentState;

  except
    raise
  end;
end;

procedure TDMContainer.ProxyCloseDocument(Sender: TObject);
var
  j:integer;
begin
  for j:=0 to FFormList0.Count-1 do
    Get_Form(j, 0).CloseDocument;
  for j:=0 to FFormList1.Count-1 do
    Get_Form(j, 1).CloseDocument;

  if TabControl.TabIndex<>-1 then
    TabControl.Tabs.Delete(TabControl.TabIndex) // перед закрытием документа он должен быть открыт
  else
    TabControl.Tabs.Clear;

  TabControl.Visible:=(TabControl.Tabs.Count>0);

  TabControl.TabIndex:=FDataModelServer.CurrentDocumentIndex;
  FChanging:=True;
  TabControlChange(TabControl);    // вызывается DoOpenDocument
  FChanging:=False;

  if (TabControl.TabIndex=-1) and
     (FActiveDMToolBar<>nil) then
    FActiveDMToolBar.Visible:=False
end;

procedure TDMContainer.SaveFormState;
var
  CurrentElement:IDMElement;
  DMForm:IDMForm;
  TopElement:IDMElement;
  TopCollection, CurrentCollection:IDMCollection;
  TopObject, CurrentObject:IUnknown;
  TreeViewForm:ITreeViewForm;
  CurrentObjectExpanded:WordBool;
  j:integer;
  DMDocument:IDMDocument;
  aDataModel:IDataModel;
begin
  CurrentElement:=nil;
  DMForm:=nil;
  if FTopFormIndex<>-1 then begin
    DMForm:=Get_Form(FTopFormIndex, 0);
  end;
  if //(TopElement=nil) and
     (FBottomFormIndex<>-1) then begin
    DMForm:=Get_Form(FBottomFormIndex, 1);
  end;

  DMDocument:=nil;
  
  if (DMForm<>nil) and
     (DMForm.QueryInterface(ITreeViewForm, TreeViewForm)=0) then begin
    TreeViewForm.GetTopObject(CurrentObject, CurrentObjectExpanded, TopObject);

    if CurrentObject=nil then Exit;

    if CurrentObject.QueryInterface(IDMElement, CurrentElement)=0 then begin
      aDataModel:=CurrentElement.DataModel;
      if aDataModel<>nil   then begin
        DMDocument:=aDataModel.Document as IDMDocument;
        if DMDocument=nil then
          Exit;
        DMDocument.CurrentCollectionIndex:=-1
      end else
        Exit;
    end else begin
      CurrentCollection:=CurrentObject as IDMCollection;
      CurrentElement:=CurrentCollection.Parent;
      j:=0;
      while j<CurrentElement.CollectionCount do begin
        if CurrentElement.Collection[j]=CurrentCollection then
          Break
        else
          inc(j)
      end;
      aDataModel:=CurrentElement.DataModel;
      if aDataModel<>nil   then begin
        DMDocument:=aDataModel.Document as IDMDocument;
        if j<CurrentElement.CollectionCount then
          DMDocument.CurrentCollectionIndex:=j
        else
          DMDocument.CurrentCollectionIndex:=-1
      end else
        Exit;
    end;

    if CurrentObjectExpanded then
      DMDocument.CurrentObjectExpanded:=1
    else
      DMDocument.CurrentObjectExpanded:=0;

    if TopObject.QueryInterface(IDMElement, TopElement)=0 then
      DMDocument.TopCollectionIndex:=-1
    else begin
      TopCollection:=TopObject as IDMCollection;
      TopElement:=TopCollection.Parent;
      j:=0;
      while j<TopElement.CollectionCount do begin
        if TopElement.Collection[j]=TopCollection then
          Break
        else
          inc(j)
      end;
      if j<TopElement.CollectionCount then
        DMDocument.TopCollectionIndex:=j
      else
        DMDocument.TopCollectionIndex:=-1
    end;

  end else begin
    TopElement:=nil;
    CurrentElement:=nil;
  end;

  if (CurrentElement<>nil) and
     (DMDocument<>nil) then begin
    DMDocument.CurrentElementID:=CurrentElement.ID;
    DMDocument.CurrentElementClassID:=CurrentElement.ClassID;
  end;

  if (TopElement<>nil) and
     (DMDocument<>nil) then begin
    DMDocument.TopElementID:=TopElement.ID;
    DMDocument.TopElementClassID:=TopElement.ClassID;
  end;
end;

procedure TDMContainer.ProxyChangeCurrentObject(Sender: TObject;
//{$IFDEF VER150}
                                    const ObjU:IUnknown;
                                    const DMFormU:IUnknown);
//{$ELSE}
//                                    var ObjV:OleVariant;
//                                    var DMFormV:OleVariant);
//{$ENDIF}
var
  aDMForm, DMForm:IDMForm;
  j:integer;
//{$IFDEF VER150}
//{$ELSE}
//  ObjU, DMFormU:IUnknown;
//{$ENDIF}
begin
//{$IFDEF VER150}
//{$ELSE}
//  ObjU:=ObjV;
//  DMFormU:=DMFormV;
//{$ENDIF}
  DMForm:=DMFormU as IDMForm;

  if ObjU=nil then Exit;
  if DMForm=nil then Exit;

  SaveFormState;

  try
  for j:=0 to FFormList0.Count-1 do begin
    aDMForm:=Get_Form(j, 0);
    if aDMForm<>DMForm then
      aDMForm.SetCurrentElement(ObjU);
  end;
  for j:=0 to FFormList1.Count-1 do begin
    aDMForm:=Get_Form(j, 1);
    if aDMForm<>DMForm then
      aDMForm.SetCurrentElement(ObjU);
  end;
  except
    raise
  end;

  ShowHiddenStatusBar;

end;

function TDMContainer.Get_DataModelAlias: WideString;
begin
  Result:=FDataModelServer.DataModelAlias;
end;

function TDMContainer.Get_DataModelFileExt: WideString;
begin
  Result:=FDataModelServer.DataModelFileExt;
end;

procedure TDMContainer.Set_DataModelAlias(const Value: WideString);
begin
  FDataModelServer.DataModelAlias:=Value;
end;

procedure TDMContainer.Set_DataModelFileExt(const Value: WideString);
begin
  FDataModelServer.DataModelFileExt:=Value;
end;

procedure TDMContainer.tbNewDataModelClick(Sender: TObject);
begin
  NewDataModel
end;

procedure TDMContainer.tbLoadDataModelClick(Sender: TObject);
begin
  LoadDataModel('', True);
end;

procedure TDMContainer.tbSaveDataModelClick(Sender: TObject);
begin
   SaveDataModel
end;

procedure TDMContainer.tbUndoClick(Sender: TObject);
begin
  Undo
end;

procedure TDMContainer.tbRedoClick(Sender: TObject);
begin
  Redo
end;

procedure TDMContainer.TabControlChange(Sender: TObject);
var
  j:integer;
begin
  try
  j:=TabControl.TabIndex;
  if j<>-1 then begin
    FDataModelServer.CurrentDocumentIndex:=j;
    DoOpenDocument;
  end;
  except
    raise
  end;  
end;

procedure TDMContainer.tbCopyClick(Sender: TObject);
begin
  Get_ActiveForm.DoAction(dmbaCopy);
  tbPaste.Enabled:=True;
end;

procedure TDMContainer.tbDeleteClick(Sender: TObject);
begin
  Get_ActiveForm.DoAction(dmbaDelete)
end;

procedure TDMContainer.tbPasteClick(Sender: TObject);
begin
  DoAction(dmbaPaste, False)
end;

procedure TDMContainer.Redo;
begin
  (FDataModelServer.CurrentDocument as IDMOperationManager).Redo
end;

procedure TDMContainer.Undo;
begin
  (FDataModelServer.CurrentDocument as IDMOperationManager).Undo
end;

function TDMContainer.Get_DocumentProgID: WideString;
begin
  if FDataModelServer<>nil then
    Result:=FDataModelServer.DocumentProgID
  else
    Result:=''
end;

procedure TDMContainer.Set_DocumentProgID(const Value: WideString);
begin
  if FDataModelServer<>nil then
    FDataModelServer.DocumentProgID:=Value;
end;

procedure TDMContainer.ProxyRefreshDocument(Sender: TObject; FlagSet:integer);
begin
  if FWaitingForRefresh then Exit;
  FWaitingForRefresh:=True;
  try
  DM_PostMessage(Handle, WM_RefreshDocument, 0, FlagSet);
  except
    raise
  end;  
end;

procedure TDMContainer.ProxyRefreshElement(Sender: TObject;
//{$IFDEF VER150}
                                    const ElementU:IUnknown);
//{$ELSE}
//                                    var ElementV:OleVariant);
//{$ENDIF}
var
  j:integer;
  Element:IDMElement;
//{$IFDEF VER150}
//{$ELSE}
//  Unk:IUnknown;
//{$ENDIF}
begin
//{$IFDEF VER150}
  Element:=ElementU as IDMElement;
//{$ELSE}
//  Unk:=ElementV;
//  Element:=Unk as IDMElement;
//{$ENDIF}

  SetCursor(ord(crHourGlass));
  try

  for j:=0 to FFormList0.Count-1 do
    Get_Form(j, 0).RefreshElement(Element);
  for j:=0 to FFormList1.Count-1 do
    Get_Form(j, 1).RefreshElement(Element)

  finally
    RestoreCursor;
  end;
end;

procedure TDMContainer.ProxySelectionChanged(Sender: TObject;
//{$IFDEF VER150}
                                    const DMElementU:IUnknown);
//{$ELSE}
//                                    var DMElementU:OleVariant);
//{$ENDIF}

var
  j, SelectionCount:integer;
  Element:IDMElement;
  aForm:IDMForm;
//{$IFDEF VER150}
//{$ELSE}
//  Unk:IUnknown;
//{$ENDIF}
begin
//{$IFDEF VER150}
  Element:=DMElementU as IDMElement;
//{$ELSE}
//  Unk:=DMElementU;
//  Element:=Unk as IDMElement;
//{$ENDIF}
  if FDataModelServer.CurrentDocument=nil then Exit;

  SelectionCount:=FDataModelServer.CurrentDocument.SelectionCount;
  if SelectionCount>0 then begin
    tbCopy.Enabled:=True;
    tbDelete.Enabled:=True;

  end else begin
    tbCopy.Enabled:=False;
    tbDelete.Enabled:=False;
  end;
  try
  for j:=0 to FFormList0.Count-1 do begin
    aForm:=Get_Form(j, 0);
    aForm.SelectionChanged(Element);
    if (Element<>nil) and
       (Element.Ref<>nil) then
      aForm.SelectionChanged(Element.Ref)
  end;
  for j:=0 to FFormList1.Count-1 do begin
    aForm:=Get_Form(j, 1);
    if aForm.Mode<>-1 then
      aForm.SelectionChanged(Element)
    else
    if (Element<>nil) and
       (Element.Ref<>nil) then
      aForm.SelectionChanged(Element.Ref)
  end;

  except
    raise
  end;
end;

function TDMContainer.Get_Form(Index, Position: Integer): IDMForm;
begin
  case Position of
  0:Result:=IDMForm(FFormList0[Index]);
  1:Result:=IDMForm(FFormList1[Index]);
  else
    Result:=nil;
  end;
end;

procedure TDMContainer.AddForm(FormClassGUID: TGUID; Position: Integer;
  const FormName: WideString);
begin
end;

function TDMContainer.Get_DataModel: IUnknown;
begin
  if FDataModelServer.CurrentDocument<>nil then
    Result:=FDataModelServer.CurrentDocument.DataModel as IUnknown
  else
    Result:=nil
end;

procedure TDMContainer.Set_DataModelServer(const Value: IUnknown);
begin
end;

function TDMContainer.Get_DataModelServer: IUnknown;
begin
  Result:=FDataModelServer as IUnknown
end;

procedure TDMContainer.ProxyCallRefDialog(Sender: TObject;
//{$IFDEF VER150}
                               const DMClassCollectionsU: IUnknown;
                               const RefSourceU: IUnknown;
                               const Suffix: WideString;
//{$ELSE}
//                               var DMClassCollectionsV, RefSourceV, Suffix: OleVariant;
{//$ENDIF}
                               AskName: WordBool);
var
  Unk:IUnknown;
  aDMClassCollections:IDMClassCollections;
  aRefSource, SubKinds:IDMCollection;
  Document:IDMDocument;
  Element, aElement:IDMElement;
  SubKindsFlag:boolean;
begin
//{$IFDEF VER150}
  aDMClassCollections:=DMClassCollectionsU as IDMClassCollections;
  aRefSource:=RefSourceU as IDMCollection;
//{$ELSE}
//  Unk:=RefSourceV;
//  aRefSource:=Unk as IDMCollection;
//  Unk:=DMClassCollectionsV;
//  aDMClassCollections:=Unk as IDMClassCollections;
//{$ENDIF}

  Document:=FDataModelServer.CurrentDocument;

  if (aRefSource=nil) and
     (aDMClassCollections=nil) then begin
     Unk:=FDataModelServer.EventData1;
     aElement:=Unk as IDMElement;
     if aElement=nil then
       Exit;
     if fmChangeRef=nil then
       fmChangeRef:=TfmChangeRef.Create(Self);

     SubKindsFlag:=False;
     if (aElement.Ref<>nil) and
        (aElement.Ref.Parent<>nil) then begin
       SubKinds:=aElement.Ref.Parent.SubKinds;
       if SubKinds<>nil then
         SubKindsFlag:=True;
     end;

     fmChangeRef.DataModel:=Document.DataModel as IDataModel;
     if aElement.Ref<>nil then
       fmChangeRef.Kinds:=aElement.Ref.Parent.OwnerCollection
     else
       fmChangeRef.Kinds:=nil;
     if not SubKindsFlag then
       fmChangeRef.LastKindIndex:=fmChangeRef.edKind.Items.IndexOfObject(pointer(aElement.Ref))
     else begin
       fmChangeRef.LastKindIndex:=fmChangeRef.edKind.Items.IndexOfObject(pointer(aElement.Ref.Parent));
       fmChangeRef.edSubKind.ItemIndex:=fmChangeRef.edSubKind.Items.IndexOfObject(pointer(aElement.Ref));
     end;
     if AskName then begin
       fmChangeRef.pName.Visible:=True;
       fmChangeRef.edName.Text:=aElement.Name;
       fmChangeRef.Suffix:=' '+ExtractLastWord(aElement.Name);
     end else
       fmChangeRef.pName.Visible:=False;

//  Get_DMEditorX.Say('Изменим тип объекта', True, False);

    if fmChangeRef.ShowModal=mrOK then begin
      Unk:=fmChangeRef.ElementSubKind;
      FDataModelServer.EventData1:=Unk;
      FDataModelServer.EventData2:=fmChangeRef.edName.Text;
      FDataModelServer.EventData3:=0;
//      Element:=Unk as IDMElement;
    end else
      FDataModelServer.EventData3:=-1;

    FDataModelServer.RefreshDocument(rfFast);
  end
  else if aRefSource<>nil then begin
    if FAddRefForm=nil then begin
      FAddRefForm:=TfmAddRef.Create(Self);
      FAddRefForm.DMEditorX:=Self as IDMEditorX;
    end;
    FAddRefForm.DataModel:=Document.DataModel as IDataModel;
    FAddRefForm.Kinds:=aRefSource;
    FAddRefForm.Suffix:=Suffix;
    FAddRefForm.DefaultName:=FDataModelServer.EventData2;

    FLastClassIndex:=-1;
//    FLastKindIndex:=FAddRefForm.LastKindIndex;
    FLastKindIndex:=-1;
    ShowHiddenStatusBar;

{$IFDEF Demo}
    FDMMacrosManager.WriteMacrosEvent(mrDialogEvent, -1, deAddRefInit,
         FLastClassIndex, FLastKindIndex, -1, '');
{$ENDIF}

    if FAddRefForm.ShowModal=mrOK then begin

      Unk:=FAddRefForm.ElementSubKind as IUnknown;
      FDataModelServer.EventData1:=Unk;
      FDataModelServer.EventData2:=FAddRefForm.edName.Text;
      FDataModelServer.EventData3:=0;
      Element:=Unk as IDMElement;
{$IFDEF Demo}
      if Element<>nil then begin
        if Element.Parent<>nil then
          FDMMacrosManager.WriteAddRefMacros(Element.Parent.ID, Element.ID)
        else
          FDMMacrosManager.WriteAddRefMacros(-1, Element.ID)
      end;
{$ENDIF}
    end else
      FDataModelServer.EventData3:=-1;
    FDataModelServer.RefreshDocument(rfFast);
  end else if aDMClassCollections<>nil then begin
    if fm_AddRef=nil then begin
      fm_AddRef:=Tfm_AddRef.Create(Self);
      fm_AddRef.DMEditorX:=Self as IDMEditorX;
    end;
    fm_AddRef.DataModel:=Document.DataModel as IDataModel;
    fm_AddRef.ClassCollectionMode:=FDataModelServer.EventData3;
    fm_AddRef.ClassCollections:=aDMClassCollections;
    fm_AddRef.Suffix:=Suffix;

    FLastClassIndex:=fm_AddRef.LastClassIndex;
    ShowHiddenStatusBar;

{$IFDEF Demo}
    FDMMacrosManager.WriteMacrosEvent(mrDialogEvent, -1, de_AddRefInit,
          FLastClassIndex, FLastKindIndex, -1, '');
{$ENDIF}

    if fm_AddRef.ShowModal=mrOK then begin

      if fm_AddRef.edSubKind.Visible then
        Unk:=fm_AddRef.ElementSubKind as IUnknown
      else
        Unk:=fm_AddRef.ElementKind as IUnknown;
      FDataModelServer.EventData1:=Unk;
      FDataModelServer.EventData2:=fm_AddRef.edName.Text;
      FDataModelServer.EventData3:=fm_AddRef.InstanceClassID;
      Element:=Unk as IDMElement;
{$IFDEF Demo}
      if Element<>nil then begin
        if Element.Parent<>nil then
          FDMMacrosManager.Write_AddRefMacros(Element.Parent.ClassID, Element.Parent.ID, Element.ID)
        else
          FDMMacrosManager.Write_AddRefMacros(-1, -1, Element.ID)
      end;
{$ENDIF}
    end else
      FDataModelServer.EventData3:=-1;

    FDataModelServer.RefreshDocument(rfFast);
  end;
end;

procedure TDMContainer.ProxySetControlState(Sender: TObject;
  ContolIndex, Index, Mode, State: integer);
var
  aDMToolBar:TDMToolBar;
{$IFDEF Demo}
  OldSpeechFlag:boolean;
{$ENDIF}
begin
{$IFDEF Demo}
   OldSpeechFlag:=FDMMacrosManager.SpeechFlag;
   FDMMacrosManager.SpeechFlag:=False;
{$ENDIF}

   aDMToolBar:=TDMToolBar(FDMToolBars[ContolIndex]);
   if aDMToolBar<>nil then
     aDMToolBar.SetControlState(Index, Mode, State);
   
{$IFDEF Demo}
   FDMMacrosManager.SpeechFlag:=OldSpeechFlag;
{$ENDIF}
end;

procedure TDMContainer.ProxyOperationStepExecuted(Sender: TObject);
var
  aCursor:integer;
begin
  try
  aCursor:=FDataModelServer.CurrentDocument.Cursor;
  StatusBar1.Panels[0].Text:=FDataModelServer.CurrentDocument.Hint;
  if Cursor<>ord(crHourGlass) then
    Cursor:= aCursor;
  CheckDocumentState;
  except
    raise
  end;  
end;

procedure TDMContainer.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TDMContainer.ProxyNextAnalysisStage(Sender: TObject;
//{$IFDEF VER150}
                               const StageName: WideString;
//{$ELSE}
//                               var StageName: OleVariant;
//{$ENDIF}
                               Stage, StepCount: Integer);
begin
  FAnalysisStageName:=StageName;
  DM_PostMessage(Handle, WM_NextAnalysisStage, Stage, StepCount);
end;

procedure TDMContainer.ProxyNextAnalysisStep(Sender: TObject; Step: Integer);
begin
  DM_PostMessage(Handle, WM_NextAnalysisStep, 0, Step);
end;

procedure TDMContainer.ProxyNextLoadStage(Sender: TObject;
//{$IFDEF VER150}
                               const StageName: WideString;
//{$ELSE}
 //                              var StageName: OleVariant;
//{$ENDIF}
                               Stage, StepCount: Integer);
begin
  FLoadStageName:=StageName;
//SendMessage(Handle, WM_NextLoadStage, Stage, StepCount);
  NextLoadStage(StageName, Stage, StepCount);
end;

procedure TDMContainer.DoAction(ActionCode: Integer;
  ActiveFormOnly: WordBool);
var
 J:integer;
begin
  try
  case ActionCode of
  dmbaFind:
    begin
      if frm_Find=nil then
        frm_Find:=Tfrm_Find.Create(Self);
      frm_Find.DMDocument:=FDataModelServer.CurrentDocument;
      frm_Find.Show;
    end;
  else
  begin
    if ActiveFormOnly then
      Get_ActiveForm.DoAction(ActionCode)
    else begin
      j:=0;
      while j<FFormList0.Count do
        if Get_Form(j, 0).DoAction(ActionCode) then
          Exit
        else
          inc(j);
      j:=0;
      while j<FFormList1.Count do
        if Get_Form(j, 1).DoAction(ActionCode) then
          Exit
        else
          inc(j);
    end;
  end;
  end;
  finally
  end;
end;

function TDMContainer.Get_RefDataModel: IUnknown;
begin
  Result:=FRefDataModel
end;

procedure TDMContainer.Set_RefDataModel(const Value: IUnknown);
begin
  FRefDataModel:=Value
end;

function TDMContainer.Get_FormCount(Position: Integer): Integer;
begin
  case Position of
  0:Result:=FFormList0.Count;
  1:Result:=FFormList1.Count;
  else
    Result:=0;
  end;  
end;

function TDMContainer.Get_ActiveForm: IDMForm;
begin
  Result:=IDMForm(FActiveForm);
end;

procedure TDMContainer.Set_ActiveForm(const Value: IDMForm);
var
  aForm:IDMForm;
  DMToolBar:TDMToolBar;
  j:integer;
begin
  FActiveForm:=pointer(Value);
  if FFormList0.IndexOf(pointer(Value))<>-1 then
    FActiveFormPosition:=0
  else
    FActiveFormPosition:=1;

  aForm:=IDMForm(FActiveForm);

  if FActiveFormPosition=0 then
    for j:=0 to FDMToolBars.Count-1 do begin
      DMToolBar:=FDMToolBars[j];
      if DMToolBar<>nil then
        if j=aForm.FormID then begin
          DMToolBar.Visible:=True;
          FActiveDMToolBar:=DMToolBar
        end else begin
          DMToolBar.Visible:=False
      end;
    end;

  ShowHiddenStatusBar;
end;

procedure TDMContainer.StartAnalysis(aMode: Integer);
var
  j:integer;
  aForm:IDMForm;
begin
  SetCursor(ord(crHourGlass));
  FAnalysisMode:=aMode;

  for j:=0 to FFormList0.Count-1 do begin
    aForm:=Get_Form(j, 0);
    aForm.StartAnalysis(FAnalysisMode);
  end;
  for j:=0 to FFormList1.Count-1 do begin
    aForm:=Get_Form(j, 1);
    aForm.StartAnalysis(FAnalysisMode);
  end;
  AnalysisStart;

  FDataModelServer.StartAnalysis(aMode);
end;

procedure TDMContainer.tbAnalysisClick(Sender: TObject);
begin
  tbAnalysis.Enabled:=False;
  StartAnalysis(1)
end;

function TDMContainer.Get_AnalyzerProgID: WideString;
begin
  if FDataModelServer<>nil then
    Result:=FDataModelServer.AnalyzerProgID
  else
    Result:=''
end;

procedure TDMContainer.Set_AnalyzerProgID(const Value: WideString);
begin
  if FDataModelServer<>nil then
    FDataModelServer.AnalyzerProgID:=Value;
end;

procedure TDMContainer.WMNextAnalysisStage(var Message: TMessage);
var
  Stage, StepCount:integer;
  Document:IDMDocument;
  aDataModel:IDataModel;
begin
  if fmAnalysisProgress=nil then begin
    fmAnalysisProgress:=TfmAnalysisProgress.Create(Self);
    fmAnalysisProgress.Server:=FDataModelServer;
  end;

  Stage:=Message.WParam;
  StepCount:=Message.LParam;

  if Stage=-1 then begin
    FDataModelServer.StopAnalysis;

    tbAnalysis.Enabled:=True;
    fmAnalysisProgress.Close;
    FDataModelServer.RefreshDocument(rfFrontBack);
    RestoreCursor;
    Exit;
  end;

  fmAnalysisProgress.LStageName.Caption:=FAnalysisStageName;
  fmAnalysisProgress.ProgressBar.Max:=StepCount;
  fmAnalysisProgress.ProgressBar.Position:=0;

  Document:=FDataModelServer.CurrentDocument;
  if Stage=0 then begin
    if (not fmAnalysisProgress.Visible) and
      (Document<>nil) then begin
      aDataModel:=Document.DataMOdel as IDataModel;
      if ((aDataModel.State and dmfExecuting)<>0) then begin
        fmAnalysisProgress.ShowModal;
        Application.ProcessMessages;
      end;
    end;
  end else
    fmAnalysisProgress.Invalidate
end;

procedure TDMContainer.WMNextAnalysisStep(var Message: TMessage);
var
  Step:integer;
begin
  Step:=Message.LParam;
  fmAnalysisProgress.ProgressBar.Position:=Step;
  fmAnalysisProgress.Invalidate;
end;

//procedure TDMContainer.WMNextLoadStage(var Message: TMessage);
procedure TDMContainer.NextLoadStage(const StageName:WideString; Stage, StepCount:integer);
//var
//  Stage, StepCount:integer;
//  Document:IDMDocument;
//  FileName:string;
begin
(*
  if fmLoadProgress=nil then begin
    fmLoadProgress:=TfmLoadProgress.Create(Self);
    fmLoadProgress.Server:=FDataModelServer;
  end;
{
  Stage:=Message.WParam;
  StepCount:=Message.LParam;
  Message.Result:=0;
}
  if Stage=-1 then begin
//    FDataModelServer.StopLoad;

    tbLoadDataModel.Enabled:=True;
    fmLoadProgress.Close;
    RestoreCursor;
    Exit;
  end;

  fmLoadProgress.LStageName.Caption:=FLoadStageName;
  fmLoadProgress.ProgressBar.Max:=StepCount;
  fmLoadProgress.ProgressBar.Position:=0;


  if Stage=0 then  begin
    Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument as IDMDocument;
    FileName:=ExtractFileName((Document.DataModel as IDMElement).Name);
    fmLoadProgress.Caption:=rsLoading+' '+FileName;
    if not fmLoadProgress.Visible then
      fmLoadProgress.Show;
//    Application.ProcessMessages;
  end else
    fmLoadProgress.Invalidate;
//  Application.ProcessMessages;
*)
end;

function TDMContainer.Get_FormVisible(Index, Position: Integer): WordBool;
var
  aPage:TDMPage;
begin
  case Position of
  0:aPage:=FFormXList0[Index];
  1:aPage:=FFormXList1[Index];
  else
    aPage:=nil;
  end;
  Result:=aPage.Visible
end;

procedure TDMContainer.Set_FormVisible(Index, Position: Integer;
  Value: WordBool);
var
  aFormX, FormX:TDMPage;
  aForm, Form:IDMForm;
  j, N:integer;
  Element:IDMElement;
  aTag:integer;
begin
  case Position of
  0:begin
      FormX:=FFormXList0[Index];
      Form:=Get_Form(Index, 0);
      if Value then begin
        FForm0:=pointer(Form);
        FTopFormIndex:=Index;
        for j:=0 to FFormXList0.Count-1 do begin
          aFormX:=FFormXList0[j];
          aForm:=Get_Form(j, 0);
          aForm.ChangingParent:=True;
          try
          if aFormX=FormX then begin
            aFormX.Parent:=pnTop;
            aFormX.Visible:=True;
            aForm.UpdateCurrentElement;
          end else begin
            aFormX.Visible:=False;
            aFormX.Parent:=Self;
          end;
          finally
            aForm.ChangingParent:=False;
          end;
        end;
        if pnBottom.Visible and
           not pnTop.Visible then begin
          pnTop.Height:=(TabControl.ClientHeight-5) div 2;
        end;
        pnTop.Visible:=True;
        if FFormXList1.Count=0 then
          pnTop.Height:=TabControl.ClientHeight-25;
      end else begin
        FTopFormIndex:=-1;
        pnTop.Visible:=False;
        FormX.Visible:=False;
        FForm0:=nil;
      end;
    end;
  1:begin
      FormX:=FFormXList1[Index];
      Form:=Get_Form(Index, 1);
      if Value then begin
        FForm1:=pointer(Form);
        FBottomFormIndex:=Index;
        for j:=0 to FFormXList1.Count-1 do begin
          aFormX:=FFormXList1[j];
          aForm:=Get_Form(j, 1);
          aForm.ChangingParent:=True;
          try
          if aFormX=FormX then begin
            aFormX.Parent:=pnBottom;
            aFormX.Visible:=True;
            aForm.UpdateCurrentElement;
          end else begin
            aFormX.Parent:=Self;
            aFormX.Visible:=False;
          end;
          finally
            aForm.ChangingParent:=False;
          end
        end;
        if pnTop.Visible and
            not pnBottom.Visible then begin
          pnTop.Height:=(TabControl.ClientHeight-5) div 2;
        end;
        pnBottom.Visible:=True;
      end else begin
        FBottomFormIndex:=-1;
        pnBottom.Visible:=False;
        FormX.Visible:=False;
        FForm1:=nil;
        Form.SaveState;
        if pnTop.Visible then begin
          pnTop.Height:=TabControl.ClientHeight-25;
        end;
      end;
    end;
  else
    Form:=nil;
  end;

  Splitter3Moved(nil);

  if FDataModelServer.CurrentDocument=nil then Exit;

  if Value then begin
    Form.UpdateDocument;


    N:=FDataModelServer.CurrentDocument.SelectionCount;
    if N>0 then
      Element:=FDataModelServer.CurrentDocument.SelectionItem[N-1] as IDMElement
    else
      Element:=nil;
    Form.SelectionChanged(Element as IUnknown);

  end;

  case Position of
  0:begin
      j:=0;
      aTag:=0;
      while (aTag<>-1) and
            (j<tbForms.ButtonCount) do begin
        aTag:=tbForms.Buttons[j].Tag;
        if aTag=Index then
          Break
        else
          inc(j);
      end;
      if (aTag<>-1) and
         (j<tbForms.ButtonCount) then
        tbForms.Buttons[j].Down:=Value;

{$IFDEF Outlook}
      j:=0;
      aTag:=0;
      while (aTag<>-1) and
            (j<FTopOutlookList.Items.Count) do begin
        aTag:=FTopOutlookList.Items[j].Tag;
        if aTag=Index then
          Break
        else
          inc(j);
      end;
      if (aTag<>-1) and
         (j<FTopOutlookList.Items.Count) then
        FTopOutlookList.Items[j].Selected:=Value;
{$ENDIF}

    end;
  1:begin
      j:=0;
      aTag:=0;
      while (aTag<>-1) and
            (j<tbForms.ButtonCount) do begin
        aTag:=tbForms.Buttons[j].Tag;
        inc(j);
      end;
      while j<tbForms.ButtonCount do begin
        aTag:=tbForms.Buttons[j].Tag;
        if aTag=Index then
          Break
        else
          inc(j);
      end;
      if j<tbForms.ButtonCount then
        tbForms.Buttons[j].Down:=Value;

{$IFDEF Outlook}
      j:=0;
      aTag:=0;
      while (aTag<>-1) and
            (j<FBottomOutlookList.Items.Count) do begin
        aTag:=FBottomOutlookList.Items[j].Tag;
        if aTag=Index then
          Break
        else
          inc(j);
      end;
      if (aTag<>-1) and
         (j<FBottomOutlookList.Items.Count) then
        FBottomOutlookList.Items[j].Selected:=Value;
{$ENDIF}

    end;
  end;

  VisibleFormChanged(Index, Position, Value);
end;

procedure TDMContainer.btForm0Click(Sender: TObject);
var
  aComponent:TComponent;
  aTag:integer;
begin
  aComponent:=TComponent(Sender);
  aTag:=aComponent.Tag;
  if Get_FormVisible(aTag, 0) then
    Set_FormVisible(aTag, 0, False)
  else begin
    Set_FormVisible(aTag, 0, True);
    Set_ActiveForm(Get_Form(aTag, 0))
  end;
end;

procedure TDMContainer.btForm1Click(Sender: TObject);
var
  aComponent:TComponent;
  aTag:integer;
begin
  aComponent:=TComponent(Sender);
  aTag:=aComponent.Tag;
  if Get_FormVisible(aTag, 1) then
    Set_FormVisible(aTag, 1, False)
  else begin
    Set_FormVisible(aTag, 1, True);
    Set_ActiveForm(Get_Form(aTag, 1))
  end;
end;

procedure TDMContainer.AddFormButton(Tag, ResourceInstanceHandle: Integer;
  const ResourceName, Hint: WideString; FormPosition: Integer;
  Down: WordBool);
var
  aToolButton:TToolButton;
  aBitMap:TBitMap;
begin
  aToolButton:=TToolButton.Create(Self);
  aToolButton.Parent:=tbForms;
  aToolButton.Tag:=Tag;
  if Tag=-1 then begin
    aToolButton.Style:=tbsSeparator;
    aToolButton.Width:=8;
    tbForms.Width:=tbForms.Width+10;
    FSeparatorBtnIndex:=tbForms.ButtonCount-1;
  end else begin
    aBitMap:=TBitMap.Create;
    aBitMap.LoadFromResourceName(ResourceInstanceHandle, ResourceName);
    ImageList2.AddMasked(aBitMap, clWhite);
    aBitMap.Free;

    aToolButton.Style:=tbsCheck;
    aToolButton.Hint:=Hint;
    aToolButton.ShowHint:=True;
    aToolButton.ImageIndex:=ImageList2.Count-1;
    case FormPosition of
    0:begin
        aToolButton.OnClick:=btForm0Click;
      end;
    1:begin
        aToolButton.OnClick:=btForm1Click;
      end;
    end;

    aToolButton.Grouped:=True;
    aToolButton.AllowAllUp:=True;
    aToolButton.Down:=boolean(Down);
    tbForms.Width:=tbForms.Width+tbForms.ButtonWidth+2;
  end;
  tbForms.Height:=tbForms.ButtonHeight;
  tbForms.Left:=Panel4.Width-tbForms.Width-5;
  tbForms.Top:=TabControl.Top;
end;

procedure TDMContainer.WriteToRegistry(const aFileName: string);
var
//  Registry: TRegistry;
  IniFile:TIniFile;
  S: string;
  j, N:integer;
begin
  FLastSavedFiles.Clear;
//  Registry:=TRegistry.Create;
//  Registry.RootKey:=HKEY_LOCAL_MACHINE;
//  Registry.OpenKey(FRegistryKey,True);
  IniFile:=TIniFile.Create(FIniFileName);
  S:='!';
  N:=0;
  while S<>'' do begin
//    S:=Registry.ReadString(Format('Entry %d',[N]));
    S:=IniFile.ReadString(FRegistryKey, Format('Entry %d',[N]), '');
    if S<>'' then begin
      FLastSavedFiles.Add(S);
      inc(N);
    end;
  end;

  j:=FLastSavedFiles.IndexOf(aFileName);
  if j<>-1 then begin
    FLastSavedFiles.Delete(j);
//    Registry.DeleteValue(aFileName);
    IniFile.DeleteKey(FRegistryKey, aFileName);
  end;
  if FLastSavedFiles.Count=5 then
    FLastSavedFiles.Delete(0);
  FLastSavedFiles.Add(aFileName);

  for j:=0 to N-1 do
//    Registry.DeleteValue(Format('Entry %d',[j]));
    IniFile.DeleteKey(FRegistryKey, Format('Entry %d',[j]));
  for j:=0 to FLastSavedFiles.Count-1 do
//     Registry.WriteString(Format('Entry %d',[j]), FLastSavedFiles[j]);
     IniFile.WriteString(FRegistryKey,Format('Entry %d',[j]), FLastSavedFiles[j]);

//  Registry.Free;
  IniFile.UpdateFile;
  IniFile.Free;
end;

procedure TDMContainer.ReadFromRegistry;
var
//  Registry: TRegistry;
  IniFile:TIniFile;
  S: string;
  j:integer;
begin
  FLastSavedFiles.Clear;

//  Registry:=TRegistry.Create;
//  Registry.RootKey:=HKEY_LOCAL_MACHINE;
//  Registry.OpenKey(FRegistryKey,True);
  IniFile:=TIniFile.Create(FIniFileName);

  S:='!';
  j:=0;
  while S<>'' do begin
//    S:=Registry.ReadString(Format('Entry %d',[j]));
    S:=IniFile.ReadString(FRegistryKey,Format('Entry %d',[j]), '');
    if S<>'' then begin
      FLastSavedFiles.Add(S);
      inc(j);
    end;
  end;

//  Registry.Free;
  IniFile.Free;
end;

procedure TDMContainer.ProxyStopAnalysis(Sender: TObject);
var
  j:integer;
  aForm:IDMForm;
begin
  for j:=0 to FFormList0.Count-1 do begin
    aForm:=Get_Form(j, 0);
    aForm.StopAnalysis(FAnalysisMode);
  end;
  for j:=0 to FFormList1.Count-1 do begin
    aForm:=Get_Form(j, 1);
    aForm.StopAnalysis(FAnalysisMode);
  end;
  AnalysisStop;
end;

procedure TDMContainer.ProxyCallDialog(Sender: TObject;
                              Mode: integer;
//{$IFDEF VER150}
                              const aCaption: WideString;
                              const aPrompt: WideString);
//{$ELSE}
//                              var aCaption: OleVariant;
//                              var aPrompt: OleVariant);
//{$ENDIF}

var
  MR:integer;
  aName:string;
  WS:WideString;
begin
//  CriticalSection.Enter;
  try
  case Mode of
  sdmIntegerInput:
    begin
      if fmIntegerInput=nil then
        fmIntegerInput:=TfmIntegerInput.Create(Self);
      fmIntegerInput.Caption:=aCaption;
      fmIntegerInput.LPrompt.Caption:=aPrompt;

      fmIntegerInput.edValue.Visible:=True;
      fmIntegerInput.edText.Visible:=False;

      fmIntegerInput.edValue.Value:=FDataModelServer.EventData1;
      fmIntegerInput.edValue.MinValue:=FDataModelServer.EventData2;
      fmIntegerInput.edValue.MaxValue:=FDataModelServer.EventData3;

      if fmIntegerInput.ShowModal=mrOK then begin
        FDataModelServer.EventData1:=fmIntegerInput.edValue.Value;
        FDataModelServer.EventData3:=1;
      end else
        FDataModelServer.EventData3:=-1;

      FDataModelServer.RefreshDocument(rfFast);

{$IFDEF Demo}
      FDMMacrosManager.WriteMacrosEvent(mrDialogEvent, -1, deInputInteger,
           -1, -1, -1, '');
{$ENDIF}

    end;
  sdmDeleteConfirm:
    begin
       if fmDeleteConfirm=nil then
         fmDeleteConfirm:=TfmDeleteConfirm.Create(Self);
       fmDeleteConfirm.LConfirm.Caption:=aPrompt;

{$IFDEF Demo}
       FDMMacrosManager.WriteMacrosEvent(mrDialogEvent, -1, deDelete,
           -1, -1, -1, '');
{$ENDIF}

       MR:=fmDeleteConfirm.ShowModal;
       case MR of
       mrYes:       FDataModelServer.EventData1:=1;
       mrYesToAll:  FDataModelServer.EventData1:=2;
       mrNo:        FDataModelServer.EventData1:=3;
       mrCancel:    FDataModelServer.EventData1:=0;
       end;
      FDataModelServer.RefreshDocument(rfFast);
    end;
  sdmShowMessage:
    begin
      ShowMessage(aPrompt);
      FDataModelServer.RefreshDocument(rfFast);
    end;
  sdmFloatInput:
    begin
      if fmIntegerInput=nil then
        fmIntegerInput:=TfmIntegerInput.Create(Self);
      fmIntegerInput.Caption:=aCaption;
      fmIntegerInput.LPrompt.Caption:=aPrompt;

      fmIntegerInput.edValue.Visible:=False;
      fmIntegerInput.edText.Visible:=True;
      fmIntegerInput.edText.Text:=FloatToStr(FDataModelServer.EventData1);

      if (fmIntegerInput.ShowModal=mrOK)
          and(FDataModelServer.EventData1>FDataModelServer.EventData2)
          and(FDataModelServer.EventData1<FDataModelServer.EventData3)then begin

        FDataModelServer.EventData1:=StrToFloat(fmIntegerInput.edText.Text);
        FDataModelServer.EventData3:=1;
      end else
        FDataModelServer.EventData3:=-1;

      FDataModelServer.RefreshDocument(rfFast);

{$IFDEF Demo}
      FDMMacrosManager.WriteMacrosEvent(mrDialogEvent, -1, deInputInteger,
           -1, -1, -1, '');
{$ENDIF}

    end;
  sdmInputQuery:
    begin
     aName:=FDataModelServer.EventData2;
     WS:=aName;

     if InputQuery(aCaption, aPrompt, aName) then  begin
       FDataModelServer.EventData2:=aName;
       FDataModelServer.EventData3:=0;
     end else
       FDataModelServer.EventData3:=-1;

{$IFDEF Demo}
      FDMMacrosManager.WriteMacrosEvent(mrDialogEvent, -1, deInputName,
           -1, -1, -1, WS);
{$ENDIF}
    end;
  sdmConfirmation:
    begin
      if fmConfirmation=nil then
        fmConfirmation:=TfmConfirmation.Create(Self);
      fmConfirmation.Text:=aPrompt;
      MR:=fmConfirmation.ShowModal;
      case MR of
      mrYes:       FDataModelServer.EventData1:=1;
      mrNo:        FDataModelServer.EventData1:=0;
      end;

      FDataModelServer.RefreshDocument(rfFast);
    end;
  sdmPleaseWait:
    begin
       if fmPleaseWait=nil then
         fmPleaseWait:=TfmPleaseWait.Create(Self);
       if FDataModelServer.EventData3<>-1 then begin
         if aCaption='' then
           fmPleaseWait.Caption:='Спрут-ИСТА'
         else
           fmPleaseWait.Caption:=aCaption;
         fmPleaseWait.LPrompt.Caption:=aPrompt;

         fmPleaseWait.Show;
         SetCursor(ord(crHourGlass));
         Application.ProcessMessages;
       end else begin
         fmPleaseWait.Hide;
         FDataModelServer.RefreshDocument(rfFast);
         RestoreCursor;
         Application.ProcessMessages;
       end
    end;
  sdmColorInput:
    begin
      if ColorDialog=nil then
        ColorDialog:=TColorDialog.Create(Self);
      if ColorDialog.Execute then
        FDataModelServer.EventData3:=ColorDialog.Color
      else
        FDataModelServer.EventData3:=-1;
      FDataModelServer.RefreshDocument(rfFast);
    end;
  else
    begin
      Get_ActiveForm.CallCustomDialog(Mode, aCaption, aPrompt);
      FDataModelServer.RefreshDocument(rfFast);
    end;
  end;
  finally
//    CriticalSection.Leave;
  end;
end;

procedure TDMContainer.RestoreCursor;
begin
  Screen.Cursor:=crDefault;
end;

procedure TDMContainer.SetCursor(aCursor: integer);
begin
  FOldCursor:=ord(Screen.Cursor);
  Screen.Cursor:=TCursor(FOldCursor);
end;

function TDMContainer.Get_LastSavedFile(Index: Integer): WideString;
begin
  Result:=FLastSavedFiles[Index]
end;

function TDMContainer.Get_LastSavedFileCount: Integer;
begin
  ReadFromRegistry;
  Result:=FLastSavedFiles.Count
end;

function TDMContainer.Get_RegistryKey: WideString;
begin
  Result:=FRegistryKey
end;

procedure TDMContainer.Set_RegistryKey(const Value: WideString);
begin
  FRegistryKey:=Value
end;

procedure TDMContainer.miPrintClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    Get_ActiveForm.DoAction(dmbaPrint)
end;

function TDMContainer.Get_Changing: WordBool;
begin
  Result:=FChanging;
end;

procedure TDMContainer.SetState(TopFormIndex, BottomFormIndex, ActivePanel,
  CurrentElementClassID, CurrentElementID, CurrentCollectionIndex,
  CurrentObjectExpanded, TopElementClassID, TopElementID,
  TopCollectionIndex, LastClassIndex, LastKindIndex,
  LastSubKindIndex: Integer; Ratio: Double);
var
  DataModelE, aElement:IDMElement;
  Document:IDMDocument;
  DMForm:IDMForm;
  TreeViewForm:ITreeViewForm;
  aCollection:IDMCollection;
  TopObject,CurrentObject:IUnknown;
{$IFDEF Demo}
  OldSpeechFlag:boolean;
{$ENDIF}
begin
{$IFDEF Demo}
   OldSpeechFlag:=FDMMacrosManager.SpeechFlag;
   FDMMacrosManager.SpeechFlag:=False;
{$ENDIF}

  if TopFormIndex<>-1 then
    Set_FormVisible(TopFormIndex, 0, True)
  else
  if FTopFormIndex<>-1 then
    Set_FormVisible(FTopFormIndex, 0, False);

  if BottomFormIndex<>-1 then
    Set_FormVisible(BottomFormIndex, 1, True)
  else
  if FBottomFormIndex<>-1 then
    Set_FormVisible(FBottomFormIndex, 1, False);

  pnTop.Height:=trunc((TabControl.Height-Splitter3.Height)*Ratio);

  case ActivePanel of
  0:if FTopFormIndex<>-1 then
     Set_ActiveForm(Get_Form(FTopFormIndex, 0));
  1:if FBottomFormIndex<>-1 then
     Set_ActiveForm(Get_Form(FBottomFormIndex, 1));
  end;

  Document:=FDataModelServer.CurrentDocument as IDMDocument;
  DataModelE:=Document.DataModel as IDMElement;

  if (TopElementClassID<>-1) and
     (TopElementID<>-1) then begin
    aElement:=(DataModelE.Collection[TopElementClassID] as IDMCollection2).GetItemByID(TopElementID);

    if TopCollectionIndex<>-1 then
      aCollection:=aElement.Collection[TopCollectionIndex]
    else
      aCollection:=nil;

    if aCollection=nil then
      TopObject:=aElement as IUnknown
    else
      TopObject:=aCollection as IUnknown;

  end else
    TopObject:=nil;

  if (CurrentElementClassID<>-1) and
     (CurrentElementID<>-1) then begin
    aElement:=(DataModelE.Collection[CurrentElementClassID] as IDMCollection2).GetItemByID(CurrentElementID);

    if CurrentCollectionIndex<>-1 then
      aCollection:=aElement.Collection[CurrentCollectionIndex]
    else
      aCollection:=nil;

    if aCollection=nil then
      CurrentObject:=aElement as IUnknown
    else
      CurrentObject:=aCollection as IUnknown;
  end else
    CurrentObject:=nil;

  if FTopFormIndex<>-1 then begin
    DMForm:=Get_Form(FTopFormIndex, 0);
  end;
    if FBottomFormIndex<>-1 then begin
    DMForm:=Get_Form(FBottomFormIndex, 1);
  end;
  if (DMForm<>nil) and
     (DMForm.QueryInterface(ITreeViewForm, TreeViewForm)=0) then
    TreeViewForm.SetTopObject(CurrentObject, CurrentObjectExpanded=1,
                              TopObject);

  FLastClassIndex:=LastClassIndex;
  FLastKindIndex:=LastKindIndex;
  if LastClassIndex=-1 then begin
    if FAddRefForm=nil then
      FAddRefForm:=TfmAddRef.Create(Self);
    FAddRefForm.DataModel:=Document.DataModel as IDataModel;
  end else begin
    if fm_AddRef=nil then
      fm_AddRef:=Tfm_AddRef.Create(Self);
    fm_AddRef.DataModel:=Document.DataModel as IDataModel;
    fm_AddRef.LastClassIndex:=LastClassIndex;
  end;
  ShowHiddenStatusBar;

{$IFDEF Demo}
  FDMMacrosManager.SpeechFlag:=OldSpeechFlag;
{$ENDIF}
end;

procedure TDMContainer.StatusBar1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ssCtrl in Shift) and
     (ssShift in Shift) then
    StatusBar1.Panels[1].Style:=TStatusPanelStyle(not boolean(StatusBar1.Panels[1].Style));
end;

procedure TDMContainer.Splitter3Moved(Sender: TObject);
begin
  FSplitterPosition:=pnTop.Height/(TabControl.Height-Splitter3.Height);
  ShowHiddenStatusBar;
end;

procedure TDMContainer.ShowHiddenStatusBar;
var
  DMDocument:IDMDocument;
begin
  DMDocument:=FDataModelServer.CurrentDocument;
  with DMDocument do
  StatusBar1.Panels[1].Text:=Format('%d %d %d %d %d %d %d %d %d %d %d %d %d %0.4f',[
            FTopFormIndex, FBottomFormIndex, FActiveFormPosition,
            CurrentElementClassID, CurrentElementID, CurrentCollectionIndex,
            CurrentObjectExpanded,
            TopElementClassID, TopElementID, TopCollectionIndex,
            FLastClassIndex, FLastKindIndex, -1,
            FSplitterPosition]);
end;

procedure TDMContainer.DuplicateActiveForm;
var
  aFormIndex, dFormIndex:integer;
  aForm, dForm:IDMForm;
  j:integer;
  aPageClass:TDMPageClass;
  aPage:TDMPage;
begin
  aForm:=Get_Form(FBottomFormIndex, 1);
  aPage:=Get_Page(FBottomFormIndex, 1);
  aFormIndex:=aForm.FormID;
  aPageClass:=TDMPageClass(aPage.ClassType);
  if FDuplicateForm=nil then begin
    AddPage(aPageClass, 0, aForm.FormName+'2');
    j:=Get_FormCount(0)-1;
  end else begin
    j:=Get_FormCount(0)-1;
    dForm:=IDMForm(FDuplicateForm);
    dFormIndex:=dForm.FormID;
    if aFormIndex<>dFormIndex then begin
      dForm.DataModelServer:=nil;
      dForm._Release;

      FFormList0.Delete(j);
      FFormXList0.Delete(j);

      AddPage(aPageClass, 0, aForm.FormName+'2');
    end;
  end;
  FDuplicateForm:=pointer(Get_Form(j, 0));
  dForm:=IDMForm(FDuplicateForm);
  dForm.Mode:=aForm.Mode;
  dForm.FormID:=aFormIndex;
  Set_FormVisible(j, 0, True)
end;

function TDMContainer.Get_PasswordRequired: WordBool;
begin
  Result:=FPasswordRequired
end;

procedure TDMContainer.Set_PasswordRequired(Value: WordBool);
begin
  FPasswordRequired:=Value
end;

function TDMContainer.Get_TabIndex: Integer;
begin
  Result:=TabControl.TabIndex
end;

procedure TDMContainer.Set_TabIndex(Value: Integer);
begin
  TabControl.TabIndex:=Value
end;

procedure TDMContainer.btCloseDocumentClick(Sender: TObject);
begin
  CloseDataModel
end;

procedure TDMContainer.VisibleFormChanged(Index, Position: Integer; Visible:WordBool);
begin
  if Assigned(FOnVisibleFormChanged) then
    FOnVisibleFormChanged(Self, Index, Position, Visible);
end;

procedure TDMContainer.AnalysisStart;
begin
  if FEvents<>nil then
    FEvents.OnAnalysisStart;
end;

procedure TDMContainer.AnalysisStop;
begin
  if FEvents<>nil then
    FEvents.OnAnalysisStop;
end;

procedure TDMContainer.TabControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  SaveFormState;
end;

procedure TDMContainer.GetForm(FormID:integer; var theForm:IDMForm; var theFormIndex, theFormPosition:integer);
var
  m:integer;
  aForm:IDMForm;
begin
  theForm:=nil;
  theFormIndex:=-1;
  theFormPosition:=-1;
  m:=0;
  while m<FFormList0.Count do begin
    aForm:=Get_Form(m, 0);
    if aForm.FormID=FormID then
      Break
    else
      inc(m)
  end;
  if m<FFormList0.Count then begin
    theForm:=aForm;
    theFormIndex:=m;
    theFormPosition:=0;
  end else begin
    m:=0;
    while m<FFormList1.Count do begin
      aForm:=Get_Form(m, 1);
      if aForm.FormID=FormID then
        Break
      else
        inc(m)
    end;
    if m<FFormList1.Count then begin
      theForm:=aForm;
      theFormIndex:=m;
      theFormPosition:=1;
    end;
  end;
end;

procedure TDMContainer.TabControlResize(Sender: TObject);
begin
  if pnTop.Visible and
     not pnBottom.Visible then
    pnTop.Height:=TabControl.ClientHeight-25;
end;

constructor TDMContainer.Create(aOwner:TComponent; const aLibraryPath:string);
begin
  inherited Create(aOwner);
  FCommonLibPath:=aLibraryPath;
  Initialize;
end;

procedure TDMContainer.AddPage(DMPageClass:TDMPageClass; Position: Integer;
      const FormName: WideString);
var
  aDMFormX:TDMPage;
  aDMForm:IDMForm;
  aDMToolBar:TDMToolBar;
begin

  aDMFormX:=DMPageClass.Create(Self);
  aDMForm:=aDMFormX as IDMForm;
  aDMForm.FormName:=FormName;

  case Position of
  0:begin
      FFormList0.Add(pointer(aDMForm));
      FFormXList0.Add(pointer(aDMFormX));
    end;
  1:begin
      FFormList1.Add(pointer(aDMForm));
      FFormXList1.Add(pointer(aDMFormX));
    end;
  else
    Exit;
  end;

  aDMForm._AddRef;
  aDMForm.DataModelServer:=FDataModelServer;
//  aDMForm.DMEditorX:=Self as IDMEditorX;
  aDMFormX.Align:=alClient;

  if aDMForm.ToolButtonCount>0 then begin
    aDMToolBar:=TDMToolBar.Create(Self);
    aDMToolBar.Parent:=ControlBar0;
    aDMToolBar.DMForm:=aDMForm;
    aDMToolBar.Init;
    aDMToolBar.Top:=ToolBar1.Top;
    aDMToolBar.Left:=ToolBar1.Width+ToolBar1.Left;
    aDMToolBar.Height:=16;
    aDMToolBar.EdgeBorders:=[];
    aDMToolBar.EdgeInner:=esNone;
    aDMToolBar.EdgeOuter:=esNone;
    FDMToolBars.Add(aDMToolBar);
    
    aDMToolBar.Tag:=FDMToolBars.Count-1;
  end else
    FDMToolBars.Add(nil);

  aDMForm.FormID:=FDMToolBars.Count-1;

  Application.ProcessMessages;
end;

function  TDMContainer.Get_Page(Index, Position: Integer): TDMPage;
begin
  case Position of
  0:Result:=TDMPage(FFormXList0[Index]);
  1:Result:=TDMPage(FFormXList1[Index]);
  else
    Result:=nil;
  end;
end;

procedure TDMContainer.SetDefaultFileName(const aFileName, aPassword:WideString);
begin
  FDefaultFileName:=aFileName;
  FPassword:=aPassword;
end;

procedure TDMContainer.AddMenuItem(ParentHandle, aHandle, aCommand, Pos,
  PX, PY, Left, Bottom: Integer);
var
  DMMenuItem:TDMMenuItem;
begin
  if ParentHandle<>-1 then
    DMMenuItem:=FDMMainMenu.FindByHandle(ParentHandle)
  else
    DMMenuItem:=FDMMainMenu;
  DMMenuItem.AddMenuItem(aHandle, aCommand, Pos, PX, PY, Left, Bottom);
end;

function TDMContainer.Get_Handle: Integer;
begin
  Result:=FDMMainMenu.Handle
end;

procedure TDMContainer.Set_Handle(Value: Integer);
begin
  FDMMainMenu.Handle:=Value
end;


procedure TDMContainer.OnOpenDocument;
begin
   ProxyOpenDocument(nil)
end;

procedure TDMContainer.OnDocumentOperation(const ElementsV: IUnknown;
                              const CollectionV: IUnknown;
                              DMOperation: Integer; nItemIndex: Integer);
begin
   ProxyDocumentOperation(nil, ElementsV, CollectionV,
                          DMOperation, nItemIndex)
end;

procedure TDMContainer.OnCloseDocument;
begin
  ProxyCloseDocument(nil);
end;

procedure TDMContainer.OnCreateDocument;
begin
end;

procedure TDMContainer.OnRefreshDocument(FlagSet: Integer);
begin
  ProxyRefreshDocument(nil, FlagSet);
end;

procedure TDMContainer.OnSelectionChanged(const ElementU: IUnknown);
begin
  ProxySelectionChanged(nil, ElementU)
end;

procedure TDMContainer.OnCallRefDialog(const DMClassCollectionsU: IUnknown; const RefSourceU: IUnknown;
                          const Suffix: WideString; AskName: WordBool);
begin
  ProxyCallRefDialog(nil, DMClassCollectionsU, RefSourceU,
                     Suffix, AskName);
end;

procedure TDMContainer.OnSetControlState(ControlIndex: Integer; Index: Integer; Mode: Integer; State: Integer); safecall;
begin
  ProxySetControlState(nil, ControlIndex, Index, Mode, State);
end;

procedure TDMContainer.OnOperationStepExecuted;
begin
  ProxyOperationStepExecuted(nil);
end;

procedure TDMContainer.OnNextAnalysisStep(Step: Integer);
begin
  ProxyNextAnalysisStep(nil, Step);
end;

procedure TDMContainer.OnNextAnalysisStage(const StageName: WideString; Stage: Integer; StepCount: Integer);
begin
  ProxyNextAnalysisStage(nil, StageName, Stage, StepCount);
end;

procedure TDMContainer.OnCallDialog(Mode: Integer; const Caption: WideString; const Prompt: WideString);
begin
  ProxyCallDialog(nil, Mode, Caption, Prompt);
end;

procedure TDMContainer.OnChangeCurrentObject(const Obj: IUnknown; const DMForm: IUnknown);
begin
  ProxyChangeCurrentObject(nil, Obj, DMForm);
end;

procedure TDMContainer.OnNextLoadStage(const StageName: WideString; Stage: Integer; StepCount: Integer);
begin
  ProxyNextLoadStage(nil, StageName, Stage, StepCount);
end;

procedure TDMContainer.OnStopAnalysis;
begin
  ProxyStopAnalysis(nil)
end;

procedure TDMContainer.OnRefreshElement(const ElementU: IUnknown);
begin
  ProxyRefreshElement(nil, ElementU);
end;

procedure TDMContainer.OnAnalysisError(const ErrorMessage: WideString);
begin
  FErrorMessage:=ErrorMessage;
  DM_PostMessage(Handle, WM_AnalysisError, 0, 0);
end;

procedure TDMContainer.WMAnalysisError(var Message: TMessage);
begin
   ShowMessage(FErrorMessage);
   FDataModelServer.RefreshDocument(rfFast);
end;

  function ExtractLastWord(const S0:string):string;
  var
    S:string;
    L,j:integer;
  begin
    S:=trim(S0);
    L:=length(S);
    j:=Pos(SuffixDivider, S);
    if (j>0) and (L>0) then
      Result:=SuffixDivider+Copy(S, j+1, L-j)
    else
      Result:=''
  end;

procedure TDMContainer.WMRefreshDocument(var Message: TMessage);
var
  j, FlagSet:integer;
begin
  FWaitingForRefresh:=False;
  FlagSet:=Message.LParam;
  try
  for j:=0 to FFormList0.Count-1 do
    Get_Form(j, 0).RefreshDocument(FlagSet);
  for j:=0 to FFormList1.Count-1 do
    Get_Form(j, 1).RefreshDocument(FlagSet)
  except
    raise
  end;
end;

procedure TDMContainer.FormResize(Sender: TObject);
begin
  StatusBar1.Panels[0].Width:=StatusBar1.Width-300;
end;


procedure TDMContainer.ActiveFormCreate(Sender: TObject);
begin
{$IFDEF Outlook}
  CreateOutlookBar
{$ENDIF}
end;

{$IFDEF Outlook}
procedure TDMContainer.CreateOutlookBar;
var
  Button:TfcCustombitBtn;
begin
  OutlookPanel.Width:=120;

  FOutlookBar:=TfcOutlookBar.Create(Self);
  FOutlookBar.Parent:=OutlookPanel;
  FOutlookBar.Align:=alClient;
  FOutlookBar.ButtonSize:=30;
  FOutlookBar.ClickStyle:=bcsRadioGroup;

  FTopOutlookList:=FOutlookBar.OutlookItems.Add.OutlookList;
  FTopOutlookList.ItemSpacing:=20;
  FTopOutlookList.ClickStyle:=csSelect;
  FTopOutlookList.Images:=ImageList2;
//  FTopOutlookList.HotTrackStyle:=hsItemHilite;
  Button:=FOutlookBar.ButtonItems[0].Button;
//  Button.Color:=clNavy;
//  Button.Font.Color:=clWhite;
//  Button.Font.Style:=[fsBold];
  Button.TextOptions.WordWrap:=True;
  Button.Caption:='Верхняя панель';

  FBottomOutlookList:=FOutlookBar.OutlookItems.Add.OutlookList;
  FBottomOutlookList.ItemSpacing:=20;
  FBottomOutlookList.ClickStyle:=csSelect;
  FBottomOutlookList.Images:=ImageList2;
//  FBottomOutlookList.HotTrackStyle:=hsItemHilite;
  Button:=FOutlookBar.ButtonItems[1].Button;
//  Button.Color:=clNavy;
//  Button.Font.Color:=clWhite;
//  Button.Font.Style:=[fsBold];
  Button.TextOptions.WordWrap:=True;
  Button.Caption:='Нижняя панель';
end;

procedure TDMContainer.OutlookListItemsClick(
  OutlookList: TfcCustomOutlookList; Item: TfcOutlookListItem);
var
  aTag:integer;
begin
  aTag:=Item.Tag;
  if OutlookList=FTopOutlookList then begin
    if Get_FormVisible(aTag, 0) then begin
      Set_FormVisible(aTag, 0, False);
      Item.Selected:=False;
    end else begin
      Set_FormVisible(aTag, 0, True);
      Set_ActiveForm(Get_Form(aTag, 0))
    end;
  end else
  if OutlookList=FBottomOutlookList then begin
    if Get_FormVisible(aTag, 1) then begin
      Set_FormVisible(aTag, 1, False);
      Item.Selected:=False;
    end else begin
      Set_FormVisible(aTag, 1, True);
      Set_ActiveForm(Get_Form(aTag, 1))
    end;
  end else begin
  end;
end;
{$ENDIF}

function TDMContainer.Get_OutlookPanelVisible: WordBool;
begin
{$IFDEF Outlook}
  Result:=OutlookPanel.Visible;
{$ENDIF}
end;

procedure TDMContainer.Set_OutlookPanelVisible(Value: WordBool);
begin
{$IFDEF Outlook}
  OutlookPanel.Visible:=Value;
  tbForms.Visible:=not Value;
  if tbForms.Visible then
    tbForms.Left:=Panel4.Width-tbForms.Width-5;
{$ENDIF}
end;

procedure TDMContainer.MakeOutlookBar;
{$IFDEF Outlook}
var
  j:integer;
  Button:TToolButton;
  Item:TfcOutlookListItem;
  BottomFlag:boolean;
{$ENDIF}
begin
{$IFDEF Outlook}
  BottomFlag:=False;
  for j:=0 to tbForms.ButtonCount-1 do begin
    Button:=tbForms.Buttons[j];
    if Button.Style=tbsSeparator then
       BottomFlag:=True
    else begin
      if BottomFlag then begin
        Item:=FBottomOutlookList.Items.Add;
      end else begin
        Item:=FTopOutlookList.Items.Add;
      end;
      Item.OnClick:=OutlookListItemsClick;
      Item.Text:=Button.Hint;
      Item.ImageIndex:=Button.ImageIndex;
      Item.Tag:=Button.Tag;
    end;
  end;
{$ENDIF}
end;


function TDMContainer.Get_LibraryPath: WideString;
begin
  Result:=FCommonLibPath
end;

procedure TDMContainer.Set_LibraryPath(const Value: WideString);
begin
  FCommonLibPath:=Value
end;

function TDMContainer.Get_IniFileName: WideString;
begin
  Result:=FIniFileName
end;

procedure TDMContainer.Set_IniFileName(const Value: WideString);
begin
  FIniFileName:=Value
end;

function TDMContainer.Get_ApplicationVersion: WideString;
begin
  Result:=FApplicationVersion
end;

procedure TDMContainer.Set_ApplicationVersion(const Value: WideString);
begin
  FApplicationVersion:=Value
end;

initialization
finalization
  if  ColorDialog<>nil then
     ColorDialog.Free;

end.
