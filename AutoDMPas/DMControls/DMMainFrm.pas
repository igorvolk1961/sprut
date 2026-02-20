unit DMMainFrm;

// СПРУТ-ИСТА
// Абстрактный предок классов, реализующих головные модули программ,
// в которых используется DMContainer

interface

//{$INCLUDE SprutikDef.inc}
//{$DEFINE TRIAL}

uses
  DM_Windows, Types,
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Menus,
  Dialogs, IniFiles,
  ExtCtrls, ActiveX, ImgList,
  DdeMan, Buttons,
  DMServer_TLB, DataModel_TLB, DMEditor_TLB, SpatialModelLib_TLB,
  DMContainerU, CustomHelloFrm, Registry;

type
  TfmDMMain = class(TForm)
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
    miCreateCircle: TMenuItem;
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
    procedure miMainMenuClick(Sender: TObject);
    procedure miUndoSelectionClick(Sender: TObject);
    procedure miWriteMacrosClick(Sender: TObject);
    procedure miLoadMacrosClick(Sender: TObject);
    procedure DrawMenuItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure miWriteMacrosLabelClick(Sender: TObject);
    procedure miOutlookPanelClick(Sender: TObject);
    procedure miActionClick(Sender: TObject);
    procedure miSelectTopEdgesClick(Sender: TObject);
  private
    FLastMenuItem:TMenuItem;

    procedure ReadLastSavedFiles;
    procedure miOpenLastClick(Sender: TObject);

    procedure ProxyVisibleFormChanged(Sender: TObject; Index, Position: Integer; Visible:WordBool);
  protected
    FDMContainer: TDMContainer;
    FDMEditor:  IDMEditorX;
    Flag:boolean;
    FDataBaseFileName:string;
    FRegistryKey:string;
//    FSafeguardSynthesis:ISafeguardSynthesis;
    FDebugMode:integer;
    FAskPassword:boolean;
    FCommonLibPath:string;
    FIniFileName:string;

    function CreateContainer:TDMContainer; virtual;

{$IFDEF Demo}
    procedure WriteMacrosMenuEvent(Sender: TObject);
{$ENDIF}
    procedure miTutorialClick1(Sender: TObject);
    procedure LoadModuls; virtual;
    function AddMenuItem(aTag, aGroupIndex: integer;
      const S: string): TMenuItem;
    procedure AddFormButtons; virtual;
    procedure SetMenuTags; virtual;
    procedure RegisterIcon; virtual;
    function GetHelloForm: TfmCustomHello; virtual;
    function GetAboutBoxForm:TForm; virtual;
    function GetRegistryForm: TForm; virtual;
    function GetRegistryKey: string; virtual;
    function GetApplicationKey: string; virtual;
    procedure SetFormModes; virtual;
    procedure SetEditorForms; virtual;
    procedure GetDBEditorParams(var DocumentProgID, ProgID,
              DataModelAlias, DataModelFileExt,
              DataBaseFileNameParam, DataBaseFileName:string); virtual;
    procedure GetDMEditorParams(var DocumentProgID, ProgID,
              DataModelAlias, DataModelFileExt,
              AnalyzerProgID:string); virtual;
    function GetRegistryApplication:boolean; virtual;
    function GetIniFileName:string; virtual;

    procedure SetRegKeyAccess(Key2: string);
    procedure Initialize; virtual;

  public
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
    property DMEditor:IDMEditorX read FDMEditor;

    function GetApplicationVersion:String; virtual;
  end;

var
  fmDMMain: TfmDMMain;

implementation
uses
  LoadModulFrm, ConfirmationFrm,
  MainPasswordFrm, ChangePasswordFrm, SpeechEngine,
  RegistryFrm, ErrorsFrm, TrialFrm;

{$R *.dfm}
{$R FormBtn.res}

procedure TfmDMMain.miNewClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.NewDataModel;
end;

procedure TfmDMMain.miOpenClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.LoadDataModel('', True);
end;

procedure TfmDMMain.miSaveClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.SaveDataModel;
end;

procedure TfmDMMain.miSaveAsClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.SaveDataModelAs
end;

procedure TfmDMMain.miCloseClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  try
    FDMEditor.CloseDataModel
  except
  end;
end;

procedure TfmDMMain.miExitClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  Close
end;

procedure TfmDMMain.FormDestroy(Sender: TObject);
begin
  FDMEditor:=nil;
end;

procedure TfmDMMain.miImportRasterClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.DoAction(dmbaImportRaster, False);
end;

procedure TfmDMMain.mUndoClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.DoAction(dmbaUndo, False);
end;

procedure TfmDMMain.miRedoClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.DoAction(dmbaRedo, False);
end;

procedure TfmDMMain.miCopyClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.DoAction(dmbaCopy, False);
end;

procedure TfmDMMain.miPasteClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.DoAction(dmbaPaste, False);
end;

procedure TfmDMMain.miDeleteClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.DoAction(dmbaDelete, True);
end;

procedure TfmDMMain.miImportVectorClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.DoAction(dmbaImportVector, False);
  FDMEditor.DoAction(smoZoomSelection+800, False);
end;

type
  TDateBuffer = record
    case integer of
    0: (pDate:array[0..9] of char);
    1: (dDate:extended);
  end;

function CheckMemLabel(ptrStart: pointer; strlabel: string; var point: pointer;
                       K:integer): boolean;
 var
  ptrCurrent: pointer;
  currarray: array [1..30] of byte;
  lookarray: array [1..30] of byte;
  i, L: integer;
  ptrEnd: pointer;
begin
 Result := false;
 point := ptrStart;
 ptrEnd:=pointer(Integer(ptrStart) + 10000);
 //Load labels
 L:=length(strlabel);
 for i := 1 to L do begin
  lookarray[i] := byte(strlabel[i]);
  currarray[i] := 0;
 end;
 lookarray[K]:=$20;
 //Look for label
 ptrCurrent := ptrStart;
 while ptrCurrent <> ptrEnd do begin
  for i := 1 to L-1 do
   currarray[i] := currarray[i + 1];
  currarray[L] := Byte(ptrCurrent^);
  Result := true;
  for i := 1 to L do
   Result := Result and (currarray[i] = lookarray[i]);
  if Result then begin
   //point points to the last byte of label
   point := ptrCurrent;
   break;
  end;
  Inc(Integer(ptrCurrent));
 end;
 if ptrCurrent = ptrEnd then
   point:=nil;
end;

procedure TfmDMMain.FormActivate(Sender: TObject);
var
  IniFile:TIniFile;
  S:string;
  Server:IDataModelServer;
  Password:string;
  PrmCount, j:integer;
  HelloForm:TfmCustomHello;
  RegistryForm:TfmRegistry;
  DocumentProgID, ProgID, DataModelAlias,
  DataModelFileExt, DataBaseFileNameParam, DataBaseFileName, AnalyzerProgID:string;
  DatabaseU:IUnknown;
  Document:IDMDocument;
  aDataModel:IDataModel;
  FirstStart:boolean;
  CurrDate, LastFileDate:TDateTime;
  Remainder:extended;
  aDateBuffer:TDateBuffer;
  pDateText:array[0..20] of char;
  DateText, DateText1, LastFileName:string;
  RegistryApplicationFlag, RegistryKeyExists, IniFileExists:boolean;
  aWinDir,  aOS, aCLSID:string;
  pOS:array[0..10] of char;
  aRegistry:TRegistry;
  iRemainder, L:integer;
  StartPoint, StopPoint, ptrAddr:pointer;
  dwOldProtect: DWORD;
  Label LabelA, LabelB;
begin
  if csDesigning in ComponentState then Exit;
  if Flag then Exit;

{$IFDEF TRIAL}
  CheckMemLabel(@TfmDMMain.FormActivate, 'Модуль_инициализации', StartPoint, 7);
  CheckMemLabel(@TfmDMMain.FormActivate, 'Конец модуля_инициализации', StopPoint, 13);
  ptrAddr := pointer(integer(StartPoint)+1);
  StopPoint:=pointer(integer(StopPoint)-30);

  DM_VirtualProtect(@TfmDMMain.FormActivate, 4096, PAGE_READWRITE, @dwOldProtect);
  S:=Name;
  L:=length(S);
  j:=1;
  while ptrAddr <> StopPoint do begin
    byte(ptrAddr^) := byte(ptrAddr^) xor byte(S[j]);
    if j=L then
      j:=1
    else
      inc(j);
    inc(Integer(ptrAddr));
  end;
  DM_VirtualProtect(@TfmDMMain.FormActivate, 4096, dwOldProtect, @dwOldProtect);
{$ENDIF}

  goto LabelA;
  asm
    DB 'Модуль инициализации    ';
  end;
  LabelA:

  FRegistryKey:=GetRegistryKey;

  aRegistry:=TRegistry.Create;
  aRegistry.RootKey:=HKEY_LOCAL_MACHINE;
  aCLSID:='SOFTWARE\Classes\CLSID\{1EA5EF5C-1E86-4728-B854-6EFE581501C7}';

  aOS:=GetEnvironmentVariable('OS');
  aOS:=Copy(aOS, 1, 10);
  StrPCopy(pOS, aOS);

  aWinDir:=GetEnvironmentVariable('windir');
  FIniFileName:=aWinDir+'\'+GetIniFileName;
  RegistryKeyExists:=aRegistry.OpenKey(aCLSID, False);
  IniFileExists:=FileExists(FIniFileName);
  try

  IniFile:=TIniFile.Create(FIniFileName);

  RegistryApplicationFlag:=GetRegistryApplication;
  if RegistryApplicationFlag then begin
    FirstStart:=not IniFileExists and
                not RegistryKeyExists;

    if IniFileExists then
      DateText:=IniFile.ReadString(FRegistryKey,'Password0', '')
    else
      DateText:='Error';

    CurrDate:=trunc(Date);

    if FirstStart then begin
      aDateBuffer.dDate:=CurrDate;
      for j:=0 to 9 do
         aDateBuffer.pDate[j]:=char(ord(aDateBuffer.pDate[j]) xor ord(pOS[j]));
      BinToHex(aDateBuffer.pDate, pDateText, 10);

      DateText:=pDateText;
      IniFile.WriteString(FRegistryKey,'Password0', DateText);
      if aRegistry.OpenKey(aCLSID, True) then begin
        aRegistry.WriteString('Password0', DateText);
        aRegistry.CloseKey;
      end;
      RegistryApplicationFlag:=False; // temporary bypath of registration
    end else
    if DateText='' then begin // if IniFileExists but there is no "Password0"
    end else begin
      if not IniFileExists then begin
        ShowMessage('Обнаружена попытка взлома защиты. Программа будет закрыта. (1)');
        Close;
        Exit;
      end;
      if not RegistryKeyExists then begin
        ShowMessage('Обнаружена попытка взлома защиты. Программа будет закрыта. (2)');
        Close;
        Exit;
      end;

      DateText1:=aRegistry.ReadString('Password0');
      if (DateText<>DateText1) then begin
        ShowMessage('Обнаружена попытка взлома защиты. Программа будет закрыта. (3)');
        Close;
        Exit;
      end;

      DateText:=Lowercase(DateText);
      StrPCopy(pDateText, DateText);
      HexToBin(pDateText, aDateBuffer.pDate, 10);
      for j:=0 to 9 do
         aDateBuffer.pDate[j]:=char(ord(aDateBuffer.pDate[j]) xor ord(pOS[j]));

      if (CurrDate<aDateBuffer.dDate) then begin
        ShowMessage('Обнаружена попытка взлома защиты. Программа будет закрыта. (4)');
        Close;
        Exit;
      end;

      j:=9;
      while j>=0 do begin
        LastFileName:=IniFile.ReadString(FRegistryKey,'Entry '+IntToStr(j), '');
        if (LastFileName='') or (not FileExists(LastFileName)) then
          dec(j)
        else
          break;
      end;
      if j>=0 then begin
        LastFileDate:=trunc(FileDateToDateTime(FileAge(LastFileName)));
        if (CurrDate<LastFileDate) then begin
          ShowMessage('Обнаружена попытка взлома защиты. Программа будет закрыта. (5)');
          Close;
          Exit;
        end;
      end;

      Remainder:=aDateBuffer.dDate+6*15 - CurrDate;
      RegistryApplicationFlag := Remainder<=0;  // temporary bypath of registration
      if not RegistryApplicationFlag then begin
        iRemainder:=round(Remainder);
        case iRemainder of
        1,21,31,41,51,61,71,81:
          S:='остался %d день';
        2,3,4,22,23,24,32,33,34,42,43,44,52,53,54,62,63,64,72,73,74,82,83,84:
          S:='осталось %d дня';
        else
          S:='осталось %d дней';
        end;
        if (fmTrial=nil) then
          fmTrial:=TfmTrial.Create(self);
        fmTrial.Label1.Caption:=Format('До конца ознакомительного периода '+S,
                           [iRemainder]);
        RegistryApplicationFlag:=(fmTrial.ShowModal=mrYes);
      end;
    end;
  end;
  finally
  aRegistry.Free;
  end;

  S:=IniFile.ReadString(FRegistryKey, 'CommonLib Path', '');
  if S='' then begin
    FCommonLibPath:=ExpandFileName('..\..\CommonLib\');
    IniFile.WriteString(FRegistryKey,'CommonLib Path', FCommonLibPath);
  end else
    FCommonLibPath:=S;

  HelloForm:=GetHelloForm;
  if HelloForm<>nil then begin
    HelloForm.Show;
    if not FAskPassword then
      HelloForm.Timer1.Enabled:=True;
  end;

  Set8087CW($133F);


  try
  if RegistryApplicationFlag then begin
    RegistryForm:=GetRegistryForm as TfmRegistry;
    if RegistryForm<>nil then begin
      RegistryForm.ApplicationKey:=GetApplicationKey;
      if (not RegistryForm.CheckRegistry(FRegistryKey)) then begin
        if RegistryForm.ShowModal<>mrOk then begin
          Close;
          Exit;
        end else if (not RegistryForm.CheckRegistry(FRegistryKey)) then begin
          Close;
          Exit;
        end;
        IniFile.DeleteKey(FRegistryKey,'Password0');
      end;
    end;
    IniFile.DeleteKey(FRegistryKey,'Password0');
  end;
  finally
{$IFDEF Registry}
    if RegistryForm<>nil then
      RegistryForm.Close;
{$ENDIF}
  end;

//  InstallSpeechAPI;

  if FAskPassword then begin
    if fmMainPassword=nil then
      fmMainPassword:=TfmMainPassword.Create(Self);
    if fmMainPassword.ShowModal<>mrOk then begin
      Close;
      Exit;
    end;
    Password:=fmMainPassword.edPassword.Text;
  end;

  goto LabelB;
  asm
    DB 'Конец модуля инициализации  ';
  end;
  LabelB:

  try

  Flag:=True;
  DecimalSeparator:='.';

  FDMContainer:=CreateContainer;
  FDMContainer.Parent:=Self;
  FDMContainer.Align:=alClient;
  FDMContainer.OnVisibleFormChanged:=ProxyVisibleFormChanged;
  FDMEditor:=FDMContainer as IDMEditorX;

{$IFDEF Demo}
  (FDMEditor as IDMMacrosManager).MainFormHandle:=Handle;
{$ENDIF}

  FDMEditor.RegistryKey:=FRegistryKey;
  FDMEditor.IniFileName:=FIniFileName;
  FDMEditor.ApplicationVersion:=GetApplicationVersion;

  Server:=FDMEditor.DataModelServer as IDataModelServer;
  Server.Events:=FDMEditor as IDMServerEvents;

  try

  S:=IniFile.ReadString(FRegistryKey, 'Debug Mode', '');
  if S='' then begin
    FDebugMode:=0;
    IniFile.WriteString(FRegistryKey,'Debug Mode', '0');
  end else
    FDebugMode:=StrToInt(S);

  if IniFile.ValueExists(FRegistryKey,'Password Required') then begin
    FDMEditor.PasswordRequired:=IniFile.ReadBool(FRegistryKey, 'Password Required', False);
    miPasswordRequired.Checked:=FDMEditor.PasswordRequired;
  end else begin
    IniFile.WriteBool(FRegistryKey, 'Password Required', False);
    FDMEditor.PasswordRequired:=False;
    miPasswordRequired.Checked:=False;
  end;

  if IniFile.ValueExists(FRegistryKey, 'OutlookPanel Visible') then begin
    FDMEditor.OutlookPanelVisible:=IniFile.ReadBool(FRegistryKey, 'OutlookPanel Visible', False);
    miOutlookPanel.Checked:=FDMEditor.OutlookPanelVisible;
  end else begin
    IniFile.WriteBool(FRegistryKey, 'OutlookPanel Visible', False);
    FDMEditor.OutlookPanelVisible:=False;
    miOutlookPanel.Checked:=False;
  end;

  GetDBEditorParams(DocumentProgID, ProgID, DataModelAlias,
                  DataModelFileExt, DataBaseFileNameParam, DataBaseFileName);
  if (DocumentProgID<>'') and
     (ProgID<>'') then begin

    FDataBaseFileName:=IniFile.ReadString(FRegistryKey, DataBaseFileNameParam,'');
    if (FDataBaseFileName='') or
       (not FileExists(FDataBaseFileName)) then begin
      FDataBaseFileName:=ExtractFilePath(Application.ExeName)+DataBaseFileName;
      IniFile.WriteString(FRegistryKey, DataBaseFileNameParam, FDataBaseFileName);
    end;

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


  finally
    IniFile.UpdateFile;
    IniFile.Free;
  end;

  try
    RegisterIcon;
  except
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
    if FAskPassword and
      (HelloForm<>nil) then
      HelloForm.Close;
  end;

end;

procedure TfmDMMain.miTopPanelViewClick(Sender: TObject);
var
  MenuItem:TMenuItem;
begin
  MenuItem:=Sender as TMenuItem;
  if FDMEditor.FormVisible[MenuItem.Tag, pnTop]<>MenuItem.Checked then
    FDMEditor.FormVisible[MenuItem.Tag, pnTop]:=MenuItem.Checked;
end;

procedure TfmDMMain.miBottomPanelViewClick(Sender: TObject);
var
  MenuItem:TMenuItem;
begin
  MenuItem:=Sender as TMenuItem;
  if FDMEditor.FormVisible[MenuItem.Tag, pnBottom]<>MenuItem.Checked then
    FDMEditor.FormVisible[MenuItem.Tag, pnBottom]:=MenuItem.Checked;
end;

procedure TfmDMMain.miErrorsClick(Sender: TObject);
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

procedure TfmDMMain.ReadLastSavedFiles;
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

procedure TfmDMMain.miOpenLastClick(Sender: TObject);
var
  S:string;
begin
  S:=TMenuItem(Sender).Caption;
  S:=Copy(S, 4, length(S)-3);
  FDMEditor.LoadDataModel(S, True);
end;

procedure TfmDMMain.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfmDMMain.N18Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TfmDMMain.N20Click(Sender: TObject);
var
  AboutBoxForm:TForm;
begin
  AboutBoxForm:=GetAboutBoxForm;
  if GetAboutBoxForm<>nil then
    AboutBoxForm.ShowModal
end;

destructor TfmDMMain.Destroy;
begin
  try
  inherited;
  except
  end;
end;

procedure TfmDMMain.SaveTransactions1Click(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  DMOperationManager:IDMOperationManager;
begin
  if not SaveTransDialog.Execute then Exit;
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  DMOperationManager:=DataModelServer.CurrentDocument as IDMOperationManager;
  DMOperationManager.SaveTransactions(SaveTransDialog.FileName);
end;

procedure TfmDMMain.LoadTransactions1Click(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  DMOperationManager:IDMOperationManager;
begin
  if not OpenTransDialog.Execute then Exit;
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  DMOperationManager:=DataModelServer.CurrentDocument as IDMOperationManager;
  DMOperationManager.LoadTransactions(OpenTransDialog.FileName);
end;

procedure TfmDMMain.miTutorialClick1(Sender: TObject);
begin
end;

procedure TfmDMMain.miPrintClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  if PrinterSetupDialog1.Execute then
    FDMEditor.DoAction(dmbaPrint, True);
end;

procedure TfmDMMain.miFindClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.DoAction(dmbaFind, True);
end;

procedure TfmDMMain.miSelectAllNodesClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  SMDocument:ISMDocument;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  SMDocument:=DataModelServer.CurrentDocument as ISMDocument;
  SMDocument.SelectAllNodes;
end;

procedure TfmDMMain.miDuplicateActiveFormClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  FDMEditor.DuplicateActiveForm
end;

procedure TfmDMMain.miChangePasswordClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
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

procedure TfmDMMain.miPasswordRequiredClick(Sender: TObject);
var
  IniFile:TIniFile;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.PasswordRequired:=miPasswordRequired.Checked;

  IniFile:=TIniFile.Create(GetIniFileName);
  IniFile.WriteBool(FRegistryKey, 'Password Required', FDMEditor.PasswordRequired);
  IniFile.UpdateFile;
  IniFile.Free;
end;

procedure TfmDMMain.SystemExecuteMacro(Sender: TObject; Msg: TStrings);
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

procedure TfmDMMain.miMainMenuClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
end;

procedure TfmDMMain.ProxyVisibleFormChanged(Sender: TObject; Index,
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

procedure TfmDMMain.miUndoSelectionClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  Document.UndoSelection;
end;

procedure TfmDMMain.miWriteMacrosClick(Sender: TObject);
begin
{$IFDEF Demo}
  (FDMEditor as IDMMacrosManager).SwitchWriteMacros;
{$ENDIF}
end;

procedure TfmDMMain.miLoadMacrosClick(Sender: TObject);
begin
{$IFDEF Demo}
  OpenMacrosDialog.InitialDir:=ExtractFilePath(Application.ExeName);

  if not OpenMacrosDialog.Execute then Exit;
  (FDMEditor as IDMMacrosManager).LoadMacros(OpenMacrosDialog.FileName);

  (FDMEditor as IDMMacrosManager).PlayFirstStep(1);
{$ENDIF}
end;

{$IFDEF Demo}
procedure TfmDMMain.WriteMacrosMenuEvent(Sender: TObject);
var
  DMMacrosManager:IDMMacrosManager;
  MenuItem:TMenuItem;
  Command:integer;
begin
  DMMacrosManager:=(FDMEditor as IDMMacrosManager);
  if not DMMacrosManager.IsWritingMacros then Exit;
  MenuItem:=Sender as TMenuItem;
  if not MenuItem.Visible then Exit;
  Command:=MenuItem.Command;
  DMMacrosManager.WriteMacrosEvent(mrMenuEvent, -1, Command, meLClick, -1, -1, '');
end;
{$ENDIF}

procedure TfmDMMain.DrawMenuItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
(*
var
  DMMenu:IDMMenu;
  MenuItem:TMenuItem;
  aHeight, PX, PY, aLeft, aBottom:integer;
  aHandle, aCommand:LongWord;

  procedure AddChildMenuItems(theMenuItem:TMenuItem);
  var
    j:integer;
    aHandle, ParentHandle, aCommand:LongWord;
    aMenuItem:TMenuItem;
  begin
    ParentHandle:=theMenuItem.Handle;
    for j:=0 to theMenuItem.Count-1 do begin
      aMenuItem:=theMenuItem.Items[j];
      if aMenuItem.Caption<>'-' then begin
        aHandle:=aMenuItem.Handle;
        aCommand:=aMenuItem.Command;
        PY:=PY+aHeight;
        aBottom:=aBottom+aHeight;
        DMMenu.AddMenuItem(ParentHandle, aHandle, aCommand, j, PX, PY, aLeft, aBottom);
      end else begin
        PY:=PY+aHeight*2 div 3;
        aBottom:=aBottom+aHeight*2 div 3;
      end;
    end;
  end;
*)
begin
(*
  if FDMEditor=nil then Exit;
  MenuItem:=Sender as TMenuItem;
{$R-}
  aHandle:=MenuItem.Handle;
{$R+}
  aCommand:=MenuItem.Command;
  aHeight:=aRect.Bottom-aRect.Top;
  PX:=(aRect.Right+aRect.Left) div 2;
  PY:=(aRect.Bottom+aRect.Top) div 2;
  aLeft:=aRect.Left;
  aBottom:=aRect.Bottom;

  DMMenu:=(FDMEditor as IDMMenu);
  DMMenu.AddMenuItem(-1, aHandle, aCommand,
                MenuItem.MenuIndex, PX, PY, aLeft, aBottom);
  PY:=PY+3;
  aBottom:=aBottom+3;

  if Win32Platform = VER_PLATFORM_WIN32_NT then
    inc(aHeight);

  AddChildMenuItems(MenuItem);

  if Sender=miHelp then begin
    DMMenu.Handle:=MainMenu1.Handle;
    MainMenu1.OwnerDraw:=False;
  end;
*)  
end;


procedure TfmDMMain.miWriteMacrosLabelClick(Sender: TObject);
//var
//  DMMacrosManager:IDMMacrosManager;
begin
{$IFDEF Demo}
  DMMacrosManager:=FDMEditor as IDMMacrosManager;
  DMMacrosManager.WriteMacrosState;
{$ENDIF}
end;

procedure TfmDMMain.LoadModuls;
begin
end;

function TfmDMMain.GetHelloForm: TfmCustomHello;
begin
  Result:=nil
end;

function TfmDMMain.GetRegistryKey:string;
begin
  Result:='SOFTWARE\';
end;

procedure TfmDMMain.GetDBEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, DataBaseFileNameParam, DataBaseFileName: string);
begin
  DocumentProgID:='';
  ProgID:='';
  DataModelAlias:='';
  DataModelFileExt:='';
  DataBaseFileNameParam:='';
  DataBaseFileName:='';
end;

procedure TfmDMMain.GetDMEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, AnalyzerProgID: string);
begin
  DocumentProgID:='DMServer.DMDocument';
  ProgID:='';
  DataModelAlias:='Объект';
  DataModelFileExt:='spm';
  AnalyzerProgID:='';
end;

function TfmDMMain.AddMenuItem(aTag, aGroupIndex:integer; const S:string):TMenuItem;
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

procedure TfmDMMain.AddFormButtons;
begin
end;

procedure TfmDMMain.RegisterIcon;
begin
end;

procedure TfmDMMain.SetEditorForms;
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

function TfmDMMain.GetAboutBoxForm: TForm;
begin
  Result:=nil
end;

procedure TfmDMMain.miOutlookPanelClick(Sender: TObject);
var
  IniFile:TIniFile;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.OutlookPanelVisible:=miOutlookPanel.Checked;
  IniFile:=TIniFile.Create(FIniFileName);
  IniFile.WriteBool(FRegistryKey, 'OutlookPanel Visible', FDMEditor.OutlookPanelVisible);
  IniFile.UpdateFile;
  IniFile.Free;

end;

procedure TfmDMMain.Initialize;
begin
  FAskPassword:=False;
  FLastMenuItem:=nil;
end;

function TfmDMMain.CreateContainer: TDMContainer;
begin
  Result:=TDMContainer.Create(Self, FCommonLibPath);
end;

constructor TfmDMMain.Create(aOwner: TComponent);
begin
  inherited;
  Initialize;
  Application.HintHidePause:=60000;
  Application.HintPause:=1000;
end;

procedure TfmDMMain.SetFormModes;
begin
end;

function TfmDMMain.GetRegistryForm: TForm;
begin
  Result:=TfmRegistry.Create(Application, FIniFileName);
end;

procedure TfmDMMain.SetMenuTags;
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
  miCreateCircle.Tag:=smoCreateCircle;
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

procedure TfmDMMain.miActionClick(Sender: TObject);
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


procedure TfmDMMain.SetRegKeyAccess(Key2: string);
var
  pAbsSD: PSECURITY_DESCRIPTOR;
  TempKey: HKey;
  ErrorCode: Integer;

begin
  if DM_GetOSVersion<VER_PLATFORM_WIN32_NT then Exit;
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

procedure TfmDMMain.miSelectTopEdgesClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  VolumeBuilder:IVolumeBuilder;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  VolumeBuilder:=DataModelServer.CurrentDocument as IVolumeBuilder;
  VolumeBuilder.SelectTopEdges;
end;

function TfmDMMain.GetApplicationKey: string;
begin
  Result:='';
end;

function TfmDMMain.GetRegistryApplication: boolean;
begin
  Result:=True;
end;

function TfmDMMain.GetIniFileName: string;
begin
  Result:='ISTA.ini'
end;

function TfmDMMain.GetApplicationVersion: String;
begin
  Result:='1.0.0';
end;

end.
