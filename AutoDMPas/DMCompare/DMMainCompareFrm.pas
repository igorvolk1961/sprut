unit DMMainCompareFrm;

// СПРУТ-ИСТА
// Абстрактный предок классов, реализующих головные модули программ,
// в которых используется DMComparator

interface

uses
  DM_Windows, Types,
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Menus,
  Dialogs, Registry,
  ExtCtrls, ActiveX, ImgList,
  DdeMan, Buttons,
  DMServer_TLB, DataModel_TLB, DMEditor_TLB, DMBrowser_TLB, SpatialModelLib_TLB,
  DMComparatorU;

type
  TfmDMMainCompare = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    miNew: TMenuItem;
    miOpen: TMenuItem;
    miSave: TMenuItem;
    miSaveAs: TMenuItem;
    N6: TMenuItem;
    miClose: TMenuItem;
    miExit: TMenuItem;
    N2: TMenuItem;
    miImportRaster: TMenuItem;
    miImportVector: TMenuItem;
    N3: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miDelete: TMenuItem;
    miView: TMenuItem;
    N4: TMenuItem;
    mUndo: TMenuItem;
    miRedo: TMenuItem;
    N5: TMenuItem;
    miHelp: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    ImageList1: TImageList;
    N14: TMenuItem;
    miOpenLast: TMenuItem;
    Demo1: TMenuItem;
    SaveTransactions1: TMenuItem;
    LoadTransactions1: TMenuItem;
    OpenTransDialog: TOpenDialog;
    SaveTransDialog: TSaveDialog;
    N16: TMenuItem;
    miPrint: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    N22: TMenuItem;
    miFind: TMenuItem;
    N24: TMenuItem;
    miSelectAllNodes: TMenuItem;
    miDuplicateActiveForm: TMenuItem;
    miPasswordRequired: TMenuItem;
    miChangePassword: TMenuItem;
    System: TDdeServerConv;
    DdeServerItem1: TDdeServerItem;
    btCloseDocument: TSpeedButton;
    miUndoSelection: TMenuItem;
    miWriteMacros: TMenuItem;
    miLoadMacros: TMenuItem;
    miPlayMacros: TMenuItem;
    OpenMacrosDialog: TOpenDialog;
    miWriteMacrosLabel: TMenuItem;
    miOutlookPanel: TMenuItem;
    ExportDialog: TSaveDialog;
    miModel: TMenuItem;
    N25: TMenuItem;
    N27: TMenuItem;
    N29: TMenuItem;
    miCreateLine: TMenuItem;
    miCreatePolyline: TMenuItem;
    miCreateClosedPolyline: TMenuItem;
    miCreateRectangle: TMenuItem;
    miCreateInclinedRectangle: TMenuItem;
    miBuildVolume: TMenuItem;
    miBuildDoor: TMenuItem;
    miDivideVolumeByVertical: TMenuItem;
    miDivideVolumeByHorizontal: TMenuItem;
    miBuildArrayObject: TMenuItem;
    miBuildPolylineObject: TMenuItem;
    miBuildCoordNode: TMenuItem;
    miIntersectSelected: TMenuItem;
    miBuildRelief: TMenuItem;
    miMoveSelected: TMenuItem;
    miRotateSelected: TMenuItem;
    miScaleSelected: TMenuItem;
    miTrimExtendToSelected: TMenuItem;
    miOutlineSelected: TMenuItem;
    N9: TMenuItem;
    miSelectLabel: TMenuItem;
    miSelectVolume: TMenuItem;
    miSelectLine: TMenuItem;
    miSelectNode: TMenuItem;
    miSelect: TMenuItem;
    N12: TMenuItem;
    N42: TMenuItem;
    miZoomSelection: TMenuItem;
    miViewPan: TMenuItem;
    miZoomOut: TMenuItem;
    miZoomIn: TMenuItem;
    miCreateCurvedLine: TMenuItem;
    miCreateEllipse: TMenuItem;
    miBreakLine: TMenuItem;
    N10: TMenuItem;
    miLastView: TMenuItem;
    miRedraw: TMenuItem;
    miSideView: TMenuItem;
    miPalette: TMenuItem;
    N43: TMenuItem;
    miSnap: TMenuItem;
    miSnapNone: TMenuItem;
    miSnapOrtToLine: TMenuItem;
    miSnapToNearestOnLine: TMenuItem;
    miSnapToMiddleOfLine: TMenuItem;
    miSnapToLocalGrid: TMenuItem;
    miSnapToNode: TMenuItem;
    N8: TMenuItem;
    N11: TMenuItem;
    N7: TMenuItem;
    N13: TMenuItem;
    miBuildJumps: TMenuItem;
    N15: TMenuItem;
    miSelectTopEdges: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure miNewClick(Sender: TObject);
    procedure miOpenClick(Sender: TObject);
    procedure miSaveClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miImportRasterClick(Sender: TObject);
    procedure mUndoClick(Sender: TObject);
    procedure miRedoClick(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure miImportVectorClick(Sender: TObject);
    procedure miTopPanelViewClick(Sender: TObject);
    procedure miBottomPanelViewClick(Sender: TObject);
    procedure miErrorsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N18Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure SaveTransactions1Click(Sender: TObject);
    procedure LoadTransactions1Click(Sender: TObject);
    procedure miPrintClick(Sender: TObject);
    procedure miFindClick(Sender: TObject);
    procedure miSelectAllNodesClick(Sender: TObject);
    procedure miDuplicateActiveFormClick(Sender: TObject);
    procedure miChangePasswordClick(Sender: TObject);
    procedure miPasswordRequiredClick(Sender: TObject);
    procedure SystemExecuteMacro(Sender: TObject; Msg: TStrings);
    procedure miUndoSelectionClick(Sender: TObject);
    procedure miOutlookPanelClick(Sender: TObject);
    procedure miActionClick(Sender: TObject);
    procedure miSelectTopEdgesClick(Sender: TObject);
  private
    FLastMenuItem:TMenuItem;

    procedure ReadLastSavedFiles;
    procedure miOpenLastClick(Sender: TObject);

    procedure ProxyVisibleFormChanged(Sender: TObject; Index, Position: Integer; Visible:WordBool);
  protected
    FDMComparator: TDMComparator;
    FDMEditor:  IDMEditorX;
    Flag:boolean;
    FDataBaseFileName:string;
    FRegistryKey:string;
//    FSafeguardSynthesis:ISafeguardSynthesis;
    FDebugMode:integer;
    FAskPassword:boolean;

    function CreateComparator:TDMComparator; virtual;
    procedure WriteMacrosMenuEvent(Sender: TObject);
    procedure miTutorialClick1(Sender: TObject);
    procedure LoadModuls; virtual;
    function AddMenuItem(aTag, aGroupIndex: integer;
      const S: string): TMenuItem;
    procedure AddFormButtons; virtual;
    procedure SetMenuTags; virtual;
    procedure RegisterIcon(Registry:TRegistry); virtual;
    function GetHelloForm: TForm; virtual;
    function GetAboutBoxForm:TForm; virtual;
    function GetRegistryForm: TForm; virtual;
    function GetRegistryKey: string; virtual;
    procedure SetFormModes; virtual;
    procedure SetEditorForms; virtual;
    procedure GetDBEditorParams(var DocumentProgID, ProgID,
              DataModelAlias, DataModelFileExt,
              DataBaseFileNameParam, DataBaseFileName:string); virtual;
    procedure GetDMEditorParams(var DocumentProgID, ProgID,
              DataModelAlias, DataModelFileExt,
              AnalyzerProgID:string); virtual;
    procedure SetRegKeyAccess(Key2: string);
    procedure Initialize; virtual;
  public
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
    property DMEditor:IDMEditorX read FDMEditor;
  end;

var
  fmDMMainCompare: TfmDMMainCompare;

implementation
uses
  LoadModulFrm, ConfirmationFrm,
  MainPasswordFrm, ChangePasswordFrm, SpeechEngine, ErrorsFrm, RegistryFrm;

{$R *.dfm}
//{$R FormBtn.res}

procedure TfmDMMainCompare.miNewClick(Sender: TObject);
begin
  FDMEditor.NewDataModel;
end;

procedure TfmDMMainCompare.miOpenClick(Sender: TObject);
begin
  FDMEditor.LoadDataModel('', True);
end;

procedure TfmDMMainCompare.miSaveClick(Sender: TObject);
begin
  FDMEditor.SaveDataModel
end;

procedure TfmDMMainCompare.miSaveAsClick(Sender: TObject);
begin
  FDMEditor.SaveDataModelAs
end;

procedure TfmDMMainCompare.miCloseClick(Sender: TObject);
begin
  try
    FDMEditor.CloseDataModel
  except
  end;
end;

procedure TfmDMMainCompare.miExitClick(Sender: TObject);
begin
  Close
end;

procedure TfmDMMainCompare.FormDestroy(Sender: TObject);
begin
  FDMEditor:=nil;
end;

procedure TfmDMMainCompare.miImportRasterClick(Sender: TObject);
begin
  FDMEditor.DoAction(dmbaImportRaster, False);
end;

procedure TfmDMMainCompare.mUndoClick(Sender: TObject);
begin
  FDMEditor.DoAction(dmbaUndo, False);
end;

procedure TfmDMMainCompare.miRedoClick(Sender: TObject);
begin
  FDMEditor.DoAction(dmbaRedo, False);
end;

procedure TfmDMMainCompare.miCopyClick(Sender: TObject);
begin
  FDMEditor.DoAction(dmbaCopy, False);
end;

procedure TfmDMMainCompare.miPasteClick(Sender: TObject);
begin
  FDMEditor.DoAction(dmbaPaste, False);
end;

procedure TfmDMMainCompare.miDeleteClick(Sender: TObject);
begin
  FDMEditor.DoAction(dmbaDelete, True);
end;

procedure TfmDMMainCompare.miImportVectorClick(Sender: TObject);
begin
  FDMEditor.DoAction(dmbaImportVector, False);
  FDMEditor.DoAction(smoZoomSelection+800, False);
end;

procedure TfmDMMainCompare.FormActivate(Sender: TObject);
var
  Registry: TRegistry;
  S:string;
  Server:IDataModelServer;
  Password:string;
  PrmCount, j:integer;
  HelloForm:TForm;
  RegistryForm:TfmRegistry;
  DocumentProgID, ProgID, DataModelAlias,
  DataModelFileExt, DataBaseFileNameParam, DataBaseFileName, AnalyzerProgID:string;
  DatabaseU:IUnknown;
  Document:IDMDocument;
  aDataModel:IDataModel;
begin
  if csDesigning in ComponentState then Exit;
  if Flag then Exit;

  FRegistryKey:=GetRegistryKey;

  HelloForm:=GetHelloForm;
  if HelloForm<>nil then
    HelloForm.Show;

//   Демо-версия не требует регистрации

  RegistryForm:=GetRegistryForm as TfmRegistry;
  try
  if RegistryForm<>nil then
    if (not RegistryForm.CheckRegistry(FRegistryKey)) then begin
      if RegistryForm.ShowModal<>mrOk then begin
        Close;
        Exit;
      end else if (not RegistryForm.CheckRegistry(FRegistryKey)) then begin
        Close;
        Exit;
      end;
    end;


//  InstallSpeechAPI;

  try

  if FAskPassword then begin
    if fmMainPassword=nil then
      fmMainPassword:=TfmMainPassword.Create(Self);
    if fmMainPassword.ShowModal<>mrOk then begin
      Close;
      Exit;
    end;
    Password:=fmMainPassword.edPassword.Text;
  end;

  Flag:=True;
  DecimalSeparator:='.';

  FDMComparator:=CreateComparator;
  FDMComparator.Parent:=Self;
  FDMComparator.Align:=alClient;
  FDMComparator.OnVisibleFormChanged:=ProxyVisibleFormChanged;
  FDMEditor:=FDMComparator as IDMEditorX;
  FDMEditor.RegistryKey:=FRegistryKey;

  Server:=FDMEditor.DataModelServer as IDataModelServer;
  Server.Events:=FDMEditor as IDMServerEvents;

  Registry:=TRegistry.Create;

  try

  Registry.RootKey:=HKEY_LOCAL_MACHINE;

  Registry.OpenKey(FRegistryKey,True);
  SetRegKeyAccess(FRegistryKey);

  S:=Registry.ReadString('Debug Mode');
  if S='' then begin
    FDebugMode:=0;
    Registry.WriteString('Debug Mode', '0');
  end else
    FDebugMode:=StrToInt(S);

  if Registry.ValueExists('Password Required') then begin
    FDMEditor.PasswordRequired:=Registry.ReadBool('Password Required');
    miPasswordRequired.Checked:=FDMEditor.PasswordRequired;
  end else begin
    Registry.WriteBool('Password Required', False);
    FDMEditor.PasswordRequired:=False;
    miPasswordRequired.Checked:=False;
  end;

  if Registry.ValueExists('OutlookPanel Visible') then begin
    FDMEditor.OutlookPanelVisible:=Registry.ReadBool('OutlookPanel Visible');
    miOutlookPanel.Checked:=FDMEditor.OutlookPanelVisible;
  end else begin
    Registry.WriteBool('OutlookPanel Visible', False);
    FDMEditor.OutlookPanelVisible:=False;
    miOutlookPanel.Checked:=False;
  end;

  Registry.CloseKey;

  GetDBEditorParams(DocumentProgID, ProgID, DataModelAlias,
                  DataModelFileExt, DataBaseFileNameParam, DataBaseFileName);
  if (DocumentProgID<>'') and
     (ProgID<>'') then begin

    Registry.RootKey:=HKEY_LOCAL_MACHINE;
    Registry.OpenKey(FRegistryKey,True);
    FDataBaseFileName:=Registry.ReadString(DataBaseFileNameParam);
    if FDataBaseFileName='' then begin
      FDataBaseFileName:=ExtractFilePath(Application.ExeName)+DataBaseFileName;
      Registry.WriteString(DataBaseFileNameParam, FDataBaseFileName);
    end;
    Registry.CloseKey;

    FDMEditor.SetDefaultFileName(FDataBaseFileName, Password);

    FDMEditor.DocumentProgID:=DocumentProgID;
    FDMEditor.ProgID:=ProgID;
    FDMEditor.DataModelAlias:=DataModelAlias;
    FDMEditor.DataModelFileExt:=DataModelFileExt;
    FDMEditor.SetDefaultFileName('', '');

    Document:=Server.CurrentDocument;
    if Document=nil then  begin
      Close;
      Exit;
    end;

    aDataModel:=FDMEditor.DataModel as IDataModel;
    DatabaseU:=aDataModel;
    aDataModel.State:=aDataModel.State or dmfAuto;
    Server.CloseCurrentDocument;
    aDataModel.State:=aDataModel.State and not dmfAuto;
  end else begin
    DatabaseU:=nil;
  end;

  try
    RegisterIcon(Registry);
  except
  end;

  finally
    Registry.Free;
  end;

  if fmLoadModul=nil then
    fmLoadModul:=TfmLoadModul.Create(Self);
  fmLoadModul.Show;
  try

  LoadModuls;
  AddFormButtons;
  SetMenuTags;

  SetFormModes;
  FDMEditor.MakeOutlookBar;

  if DatabaseU<>nil then
    FDMEditor.RefDataModel:=DatabaseU;

  GetDMEditorParams(DocumentProgID, ProgID, DataModelAlias,
                  DataModelFileExt, AnalyzerProgID);

  if AnalyzerProgID<>'' then
    FDMEditor.AnalyzerProgID:=AnalyzerProgID;

  FDMEditor.DocumentProgID:=DocumentProgID;
  FDMEditor.ProgID:=ProgID;
  FDMEditor.DataModelAlias:=DataModelAlias;
  FDMEditor.DataModelFileExt:=DataModelFileExt;

  SetEditorForms;

  ReadLastSavedFiles;

  PrmCount:=ParamCount;
  if PrmCount>0 then begin
    for j:=1 to PrmCount do begin
      S:=ParamStr(j);
      if S[1]<>'-' then begin
        try
          FDMEditor.LoadDataModel(S, True);
        except
        end;
      end;
    end;
  end;
  finally
    if fmLoadModul<>nil then
      fmLoadModul.Close;
  end;

  finally
    if HelloForm<>nil then
      HelloForm.Close;
  end;

//   Демо-версия не требует регистрации

  finally
    if RegistryForm<>nil then
      RegistryForm.Close;
  end;

end;

procedure TfmDMMainCompare.miTopPanelViewClick(Sender: TObject);
var
  MenuItem:TMenuItem;
begin
  MenuItem:=Sender as TMenuItem;
  if FDMEditor.FormVisible[MenuItem.Tag, pnTop]<>MenuItem.Checked then
    FDMEditor.FormVisible[MenuItem.Tag, pnTop]:=MenuItem.Checked;
end;

procedure TfmDMMainCompare.miBottomPanelViewClick(Sender: TObject);
var
  MenuItem:TMenuItem;
begin
  MenuItem:=Sender as TMenuItem;
  if FDMEditor.FormVisible[MenuItem.Tag, pnBottom]<>MenuItem.Checked then
    FDMEditor.FormVisible[MenuItem.Tag, pnBottom]:=MenuItem.Checked;
end;

procedure TfmDMMainCompare.miErrorsClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
begin
  if fmErrors=nil then
    fmErrors:=TfmErrors.Create(nil);
  fmErrors.DataModel:=FDMEditor.DataModel as IDataModel;
  fmErrors.CheckModel;
  if fmErrors.lbErrors.Count>0 then
    fmErrors.ShowModal;
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  DataModelServer.RefreshDocument(rfFast);
end;

procedure TfmDMMainCompare.ReadLastSavedFiles;
var
  N, j:integer;
  MenuItem:TMenuItem;
begin
  miOpenLast.Clear;
  N:=FDMEditor.LastSavedFileCount;
  for j:=0 to N-1 do begin
    MenuItem:=TMenuItem.Create(Self);
    MenuItem.AutoHotkeys:=maManual;
    MenuItem.Caption:=IntToStr(j)+' '+FDMEditor.LastSavedFile[N-1-j];
    MenuItem.OnClick:=miOpenLastClick;
    miOpenLast.Add(MenuItem);
  end;
end;

procedure TfmDMMainCompare.miOpenLastClick(Sender: TObject);
var
  S:string;
begin
  S:=TMenuItem(Sender).Caption;
  S:=Copy(S, 4, length(S)-3);
  FDMEditor.LoadDataModel(S, True);
end;

procedure TfmDMMainCompare.FormClose(Sender: TObject; var Action: TCloseAction);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  j:integer;
begin
  Action:=caFree;
  if FDMEditor=nil then Exit;
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  if (DataModelServer<>nil) then
  for j:=0 to DataModelServer.DocumentCount-1 do begin
    Document:=DataModelServer.Document[j];
    if ((Document.State and dmfModified)<>0) then begin
      if fmConfirmation=nil then
        fmConfirmation:=TfmConfirmation.Create(Self);
      fmConfirmation.Text:='Данные документа '+
                  (Document.DataModel as IDMElement).Name+
                  ' не сохранены.  Закрыть документ без сохранения?';
      if fmConfirmation.ShowModal = mrNo then begin
        DataModelServer.RefreshDocument(rfFast);
        Action:=caNone;
        Exit;
      end;
    end;
  end;
end;

procedure TfmDMMainCompare.N18Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TfmDMMainCompare.N20Click(Sender: TObject);
var
  AboutBoxForm:TForm;
begin
  AboutBoxForm:=GetAboutBoxForm;
  if GetAboutBoxForm<>nil then
    AboutBoxForm.ShowModal
end;

destructor TfmDMMainCompare.Destroy;
begin
  try
  inherited;
  except
  end;
end;

procedure TfmDMMainCompare.SaveTransactions1Click(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  DMOperationManager:IDMOperationManager;
begin
  if not SaveTransDialog.Execute then Exit;
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  DMOperationManager:=DataModelServer.CurrentDocument as IDMOperationManager;
  DMOperationManager.SaveTransactions(SaveTransDialog.FileName);
end;

procedure TfmDMMainCompare.LoadTransactions1Click(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  DMOperationManager:IDMOperationManager;
begin
  if not OpenTransDialog.Execute then Exit;
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  DMOperationManager:=DataModelServer.CurrentDocument as IDMOperationManager;
  DMOperationManager.LoadTransactions(OpenTransDialog.FileName);
end;

procedure TfmDMMainCompare.miTutorialClick1(Sender: TObject);
begin
end;

procedure TfmDMMainCompare.miPrintClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    FDMEditor.DoAction(dmbaPrint, True);
end;

procedure TfmDMMainCompare.miFindClick(Sender: TObject);
begin
  FDMEditor.DoAction(dmbaFind, True);
end;

procedure TfmDMMainCompare.miSelectAllNodesClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  SMDocument:ISMDocument;
begin
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  SMDocument:=DataModelServer.CurrentDocument as ISMDocument;
  SMDocument.SelectAllNodes;
end;

procedure TfmDMMainCompare.miDuplicateActiveFormClick(Sender: TObject);
begin
  FDMEditor.DuplicateActiveForm
end;

procedure TfmDMMainCompare.miChangePasswordClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
begin
  if fmChangePassword=nil then
    fmChangePassword:=TfmChangePassword.Create(Self);
  if fmChangePassword.ShowModal<>mrOK then Exit;

  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  if fmChangePassword.edOldPassword.Text<>Document.Password then
    ShowMessage('Неправильный пароль')
  else
    Document.Password:=fmChangePassword.edNewPassword.Text
end;

procedure TfmDMMainCompare.miPasswordRequiredClick(Sender: TObject);
var
  Registry:TRegistry;
begin
  FDMEditor.PasswordRequired:=miPasswordRequired.Checked;

  Registry:=TRegistry.Create;
  try
    Registry.RootKey:=HKEY_LOCAL_MACHINE;

    Registry.OpenKey(FRegistryKey,True);

    Registry.WriteBool('Password Required', FDMEditor.PasswordRequired);

    Registry.CloseKey;
  finally
    Registry.Free;
  end;

end;

procedure TfmDMMainCompare.SystemExecuteMacro(Sender: TObject; Msg: TStrings);
var
  S, S1:string;
  j:integer;
  DataModelServer:IDataModelServer;
begin
  S:=Msg[0];
  S1:=Copy(S, 2, 4);
  if S1='Open' then begin
    S:=Copy(S, 8, length(S)-7);
    j:=Pos('"', S);
    if j<>0 then begin
      S:=Copy(S,1,j-1);
      if FDMEditor<>nil then begin
        FDMEditor.LoadDataModel(S, True);
        DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
        DataModelServer.RefreshDocument(rfFront);
      end;
    end;
  end;
end;

procedure TfmDMMainCompare.ProxyVisibleFormChanged(Sender: TObject; Index,
  Position: Integer; Visible: WordBool);
var
  MenuItem:TMenuItem;
  j:integer;
begin
  j:=0;
  MenuItem:=nil;
  while j<miView.Count do begin
    MenuItem:=miView.Items[j];
    if MenuItem.RadioItem and
       (MenuItem.GroupIndex=Position+1) and
       (MenuItem.Tag=Index) then
      Break
    else
      inc(j);
  end;
  if j<miView.Count then begin
    MenuItem.Checked:=Visible;
    MenuItem.OnClick(MenuItem);
  end;
end;

procedure TfmDMMainCompare.miUndoSelectionClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
begin
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  Document.UndoSelection;
end;

procedure TfmDMMainCompare.WriteMacrosMenuEvent(Sender: TObject);
begin
end;

procedure TfmDMMainCompare.LoadModuls;
begin
end;

function TfmDMMainCompare.GetHelloForm:TForm;
begin
  Result:=nil
end;

function TfmDMMainCompare.GetRegistryKey:string;
begin
  Result:='SOFTWARE\ISTA';
end;

procedure TfmDMMainCompare.GetDBEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, DataBaseFileNameParam, DataBaseFileName: string);
begin
  DocumentProgID:='';
  ProgID:='';
  DataModelAlias:='';
  DataModelFileExt:='';
  DataBaseFileNameParam:='';
  DataBaseFileName:='';
end;

procedure TfmDMMainCompare.GetDMEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, AnalyzerProgID: string);
begin
  DocumentProgID:='DMServer.DMDocument';
  ProgID:='';
  DataModelAlias:='Объект';
  DataModelFileExt:='spm';
  AnalyzerProgID:='';
end;

function TfmDMMainCompare.AddMenuItem(aTag, aGroupIndex:integer; const S:string):TMenuItem;
begin
  Result:=TMenuItem.Create(Self);
  Result.Caption:=S;
  Result.Tag:=aTag;
  Result.AutoCheck:=True;
  Result.GroupIndex:=aGroupIndex;
  if aGroupIndex>0 then
    Result.RadioItem:=True;
  if aGroupIndex=1 then
    Result.OnClick:=miTopPanelViewClick
  else
  if aGroupIndex=2 then
    Result.OnClick:=miBottomPanelViewClick;
  miView.Insert(0,Result);
end;

procedure TfmDMMainCompare.AddFormButtons;
begin
end;

procedure TfmDMMainCompare.RegisterIcon(Registry:TRegistry);
begin
end;

procedure TfmDMMainCompare.SetEditorForms;
begin
  if FDMEditor.FormCount[pnTop]>0 then
    FDMEditor.FormVisible[0, pnTop]:=True;
  if FDMEditor.FormCount[pnBottom]>0 then
    FDMEditor.FormVisible[0, pnBottom]:=True;

  if FDMEditor.FormCount[pnTop]>0 then
    FDMEditor.ActiveForm:=FDMEditor.Form[0, pnTop]
  else
  if FDMEditor.FormCount[pnBottom]>0 then
    FDMEditor.ActiveForm:=FDMEditor.Form[0, pnBottom]
end;

function TfmDMMainCompare.GetAboutBoxForm: TForm;
begin
  Result:=nil
end;

procedure TfmDMMainCompare.miOutlookPanelClick(Sender: TObject);
var
  Registry:TRegistry;
begin
  FDMEditor.OutlookPanelVisible:=miOutlookPanel.Checked;

  Registry:=TRegistry.Create;
  try
    Registry.RootKey:=HKEY_LOCAL_MACHINE;

    Registry.OpenKey(FRegistryKey,True);

    Registry.WriteBool('OutlookPanel Visible', FDMEditor.OutlookPanelVisible);

    Registry.CloseKey;
  finally
    Registry.Free;
  end;

end;

procedure TfmDMMainCompare.Initialize;
begin
  FAskPassword:=False;
  FLastMenuItem:=nil;
end;

function TfmDMMainCompare.CreateComparator: TDMComparator;
begin
  Result:=TDMComparator.Create(Self);
end;

constructor TfmDMMainCompare.Create(aOwner: TComponent);
begin
  inherited;
  Initialize;
end;

procedure TfmDMMainCompare.SetFormModes;
begin
end;

function TfmDMMainCompare.GetRegistryForm: TForm;
begin
  Result:=nil
end;

procedure TfmDMMainCompare.SetMenuTags;
begin
  miSelect.Tag:=smoSelectAll;
  miSelectNode.Tag:=smoSelectVerticalLine;
  miSelectLine.Tag:=smoSelectVerticalArea;
  miSelectVolume.Tag:=smoSelectVolume;
  miSelectLabel.Tag:=smoSelectLabel;
  miZoomIn.Tag:=smoZoomIn;
  miZoomOut.Tag:=smoSelectLabel;
  miViewPan.Tag:=smoViewPan;
  miZoomSelection.Tag:=smoZoomSelection;
  miLastView.Tag:=smoLastView;
  miRedraw.Tag:=smoRedraw;
  miSideView.Tag:=smoSideView;
  miPalette.Tag:=smoPalette;

  miCreateLine.Tag:=smoCreateLine;
  miCreatePolyLine.Tag:=smoCreatePolyLine;
  miCreateClosedPolyLine.Tag:=smoCreateClosedPolyLine;
  miCreateRectangle.Tag:=smoCreateRectangle;
  miCreateInclinedRectangle.Tag:=smoCreateInclinedRectangle;
  miCreateCurvedLine.Tag:=smoCreateCurvedLine;
  miCreateEllipse.Tag:=smoCreateEllipse;
  miBreakLine.Tag:=smoBreakLine;

  miMoveSelected.Tag:=smoMoveSelected;
  miRotateSelected.Tag:=smoRotateSelected;
  miScaleSelected.Tag:=smoScaleSelected;
  miTrimExtendToSelected.Tag:=smoTrimExtendToSelected;
  miOutlineSelected.Tag:=smoOutlineSelected;

  miBuildVolume.Tag:=smoBuildVolume;
  miBuildDoor.Tag:=smoDoubleBreakLine;
  miDivideVolumeByHorizontal.Tag:=smoDivideVolume;
  miDivideVolumeByVertical.Tag:=smoBuildVerticalArea;
  miBuildArrayObject.Tag:=smoBuildArrayObject;
  miBuildPolylineObject.Tag:=smoBuildPolylineObject;
  miBuildCoordNode.Tag:=smoCreateCoordNode;
  miIntersectSelected.Tag:=smoIntersectSelected;
  miBuildRelief.Tag:=smoBuildRelief;
  miBuildJumps.Tag:=smoBuildLineObject;

  miSnapNone.Tag:=smoSnapNone;
  miSnapOrtToLine.Tag:=smoSnapOrtToLine;
  miSnapToNearestOnLine.Tag:=smoSnapToNearestOnLine;
  miSnapToMiddleOfLine.Tag:=smoSnapToMiddleOfLine;
  miSnapToLocalGrid.Tag:=smoSnapToLocalGrid;
  miSnapToNode.Tag:=smoSnapToNode;

end;

procedure TfmDMMainCompare.miActionClick(Sender: TObject);
var
  OperationCode:integer;
  Server:IDataModelServer;
  MenuItem:TMenuItem;
begin
  MenuItem:=Sender as TMenuItem;
  if not MenuItem.AutoCheck then begin
     MenuItem.Checked:=True;
     if (FLastMenuItem<>nil) and
       (FLastMenuItem.GroupIndex<>MenuItem.GroupIndex) then
      FLastMenuItem.Checked:=False;
  end;
  OperationCode:=MenuItem.Tag;
  Server:=FDMEditor.DataModelServer as IDataModelServer;
  Server.SetControlState(0, -OperationCode, csClick, 1);
  Server.SetControlState(0, -OperationCode, csChecked, 1);
  FLastMenuItem:=MenuItem;
end;


procedure TfmDMMainCompare.SetRegKeyAccess(Key2: string);
var
  pAbsSD: PSECURITY_DESCRIPTOR;
  TempKey: HKey;
  ErrorCode: Integer;

begin
  TempKey := 0;
  ErrorCode := DM_RegOpenKeyEx(HKEY_LOCAL_MACHINE, PChar(Key2), 0, KEY_ALL_ACCESS, TempKey);
  if ErrorCode <> ERROR_SUCCESS then begin
    ShowMessage('Can''t get required access for key: '+Key2);
    Exit;
  end;
  GetMem(pAbsSD,SECURITY_DESCRIPTOR_MIN_LENGTH);
  DM_InitializeSecurityDescriptor(pAbsSD,1);
  if not DM_SetSecurityDescriptorDacl(pAbsSD,true,nil,false) then begin
    ShowMessage('SetSecurityDescriptorDacl is wrong!');
  end else
  if DM_RegSetKeySecurity(TempKey, DACL_SECURITY_INFORMATION, pAbsSD)<> ERROR_SUCCESS then
    ShowMessage('RegSetKeySecurity is wrong!');

  Dispose(pAbsSD);
  if DM_RegCloseKey(TempKey)<> ERROR_SUCCESS then
    ShowMessage('Can''t close the key!');
end;

procedure TfmDMMainCompare.miSelectTopEdgesClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  VolumeBuilder:IVolumeBuilder;
begin
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  VolumeBuilder:=DataModelServer.CurrentDocument as IVolumeBuilder;
  VolumeBuilder.SelectTopEdges;
end;

end.
