unit MacrosManagerU;

interface
uses
  Classes, DM_Messages, Controls, ComCtrls, ExtCtrls, StdCtrls, Types,
  SysUtils, Dialogs, Forms, Graphics,
  DM_Windows,
  DMEditor_TLB, DMServer_TLB, DataModel_TLB,
  DMUtils, DMMenu, Speech;

type
  PMacrosStepRecord=^TMacrosStepRecord;
  TMacrosStepRecord=record
    RecordKind: Integer;
    FormID: Integer;
    ControlID: Integer;
    EventID: Integer;
    P1: Integer;
    P2: Integer;
  end;

  PMacrosStageRecord=^TMacrosStageRecord;
  TMacrosStageRecord=record
    Pos:integer;
    Transaction:integer;
  end;


  TMacrosManager = class(TComponent{DM_AutoObject}, IDMMacrosManager, ITTSNotifySinkA)
  private
    FDMContainer:TControl;

    FSaveDialog1:TSaveDialog;

    FSpeechFlag:boolean;
    FSpeechEngine:IUnknown;
    FMayBeInterrupted:boolean;

    FCurrMenuItem:TDMMenuItem;
    FMainFormHandle:integer;
    
    FMacrosTimer: TTimer;
    FWritingMacros:boolean;
    FMacrosFile:Text;
    FMacrosStepRecordList:TStringList;
    FMacrosStageRecordList:TList;
    FLessonRecordList:TList;
    FMacrosPos:integer;
    FMacrosIndex:integer;
    FLastMacrosIndex:integer;
    FMacrosP0: TPoint;
    FMacrosP1: TPoint;
    FMacrosStepRecord:PMacrosStepRecord;
    FMacrosStepText:string;
    FMacrosPhase:integer;
    FMacrosTimerInterval:integer;
    FMacrosLargePauseInterval:integer;
    FMacrosSmallPauseInterval:integer;
    FIsPlaying: WordBool;
    FMacrosControlHandle:integer;
    FMacrosTypeString:String;
    FMacrosTypePos:integer;
    FMacrosTimerKind:integer;
    FMacrosCursorSpeed:double;
    FTTSNotifySinkKey:Cardinal;
    FMacrosPausedWhileSpeeking:boolean;
    FDemoShowText: WordBool;
    FDemoSpeech: WordBool;
    FLessonFileName:WideString;
    FCursorStep: integer;
    FCursorStepCount:integer;

    procedure MacrosTimerTimer(Sender: TObject);
  protected
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

    procedure CloseActiveWindow;
    procedure ClearMacrosStepList;
    procedure ClearMacrosStageList;
    procedure ClearLessonList;
    procedure LoadLessonModel(const FileName:string);
    procedure PlayColorDialog(Color:integer);
    procedure InitSwitchFormMacros(FormIndex, FormPosition:integer);
    function  DoPlayNextStep:boolean;
    procedure GoToPrevMacros;
    procedure GoToNextMacros;
    procedure SetLesson(LessonIndex:integer);
    function Get_SpeechEngine: IUnknown; safecall;
    procedure Set_SpeechEngine(const Value: IUnknown); safecall;
    procedure Say(const Text: WideString; CanWait, MaybeInterrupted,
      MacrosPaused: WordBool); safecall;
    function Get_SpeechFlag: WordBool; safecall;
    procedure Set_SpeechFlag(Value: WordBool); safecall;
    procedure WriteAddRefMacros(aParentID, aID:integer); safecall;
    procedure Write_AddRefMacros(aParentClassID, aParentID, aID:integer); safecall;
    function Get_MainFormHandle: Integer; safecall;
    procedure Set_MainFormHandle(Value: Integer); safecall;

// ITTSNotifySinkA
    function AttribChanged(dwAttribute: DWORD): HResult; stdcall;
    function AudioStart(qTimeStamp: QWORD): HResult; stdcall;
    function AudioStop(qTimeStamp: QWORD): HResult; stdcall;
    function Visual(qTimeStamp: QWORD; cIPAPhoneme: AnsiChar; cEnginePhoneme: AnsiChar;
      dwHints: DWORD; pTTSMouth: PTTSMOUTH): HResult; stdcall;


    procedure ShowDemoNavigator;
    procedure InitMacrosStep(ControlID, EventID, X, Y:integer;
                   const WS:WideString);
    procedure InitComboBoxEvent(ControlID, EventID, X, Y:integer;
                   const WS:WideString);
    procedure DoMacrosStep(ControlID, EventID:integer);
    procedure DoDialogEvent(ControlID, aItemIndex:integer);
  public
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
  end;


implementation
uses
  DemoNavigatorFrm, DemoMenuFrm, DMContainerU, _AddRefFrm, AddRefFrm;

{ TMacrosManager }

function EnumChildProc1(hChild:integer; PhChild:PInteger):BOOL; stdcall;
var
  PS:array[0..255] of char;
  hParent:integer;
begin
  DM_GetClassName(hChild, PS, 255);
  if (PS='Edit') or (PS='TEdit') then begin
    hParent:=DM_GetParent(hChild);
    DM_GetClassName(hParent, PS, 255);
    if (PS<>'ComboBox') and (PS<>'TComboBox') then begin
      PhChild^:=hChild;
      Result:=False
    end else
      Result:=True
  end else
    Result:=True
end;

function EnumChildProc2(hChild:integer; PhChild:PInteger):BOOL; stdcall;
var
  PS:array[0..255] of char;
  R:integer;
begin
  DM_GetClassName(hChild, PS, 255);
  if PS='Static' then begin
    R:=DM_GetWindowText(hChild, PS, 255);
    if R=0 then begin
      PhChild^:=hChild;
      Result:=False
    end else
      Result:=True
  end else
    Result:=True
end;

const
  BaseColor:array[0..47,0..2] of byte=
  ((255,128,128),(255,255,128),(128,255,128),(0,255,128), (128,255,255),(0,128,255),  (255,128,192),(255,128,255),
   (255,0,0),    (255,255,0),  (128,255,0),  (0,255,64),  (0,255,255),  (0,128,192), (128,128,192),(255,0,255),
   (128,64,64),  (255,128,64), (0,255,0),    (0,128,128), (0,64,128),   (128,128,255),(128,0,64),  (255,0,128),
   (128,0,0),    (255,128,0),  (0,128,0),    (0,128,64),  (0,0,255),    (0,0,160),    (128,0,128), (128,0,125),
   (64,0,0),     (128,64,0),   (0,64,0),     (0,64,64),   (0,0,128),    (0,0,64),     (64,0,64),   (64,0,128),
   (0,0,0),      (128,128,0),  (128,128,128),(128,128,128),(64,128,128),(192,192,192),(64,0,64),   (255,255,255));


function TMacrosManager.Get_DemoShowText: WordBool;
begin
  Result:=FDemoShowText
end;

function TMacrosManager.Get_DemoSpeech: WordBool;
begin
  Result:=FDemoSpeech
end;

function TMacrosManager.Get_IsPlaying: WordBool;
begin
  Result:=FIsPlaying
end;

function TMacrosManager.Get_IsWritingMacros: WordBool;
begin
  Result:=FWritingMacros
end;

function TMacrosManager.Get_MacrosCursorSpeed: Double;
begin
  Result:=FMacrosCursorSpeed
end;

function TMacrosManager.Get_MacrosPauseInterval: Integer;
begin
  Result:=FMacrosLargePauseInterval
end;

procedure TMacrosManager.LoadMacros(const FileName: WideString);
var
  aMacrosFile:TextFile;
  MacrosStep:PMacrosStepRecord;
  MacrosStage:PMacrosStageRecord;
  S:string;
  Value:double;
  RecordKind, FormID, ControlID, EventID, P1, P2:integer;
begin
  AssignFile(aMacrosFile, FileName);
  Reset(aMacrosFile);

  ClearMacrosStageList;
  ClearMacrosStepList;
  FMacrosPos:=0;
  while not EOF(aMacrosFile) do begin
    Readln(aMacrosFile, S);
    if (S<>'') and
       (S[1]<>'/') then begin
      ExtractValueFromString(S, Value);
      RecordKind:=round(Value);
      ExtractValueFromString(S, Value);
      FormID:=round(Value);
      ExtractValueFromString(S, Value);
      ControlID:=round(Value);
      ExtractValueFromString(S, Value);
      EventID:=round(Value);
      ExtractValueFromString(S, Value);
      P1:=round(Value);
      ExtractValueFromString(S, Value);
      P2:=round(Value);
      S:=trim(S);
      if (S<>'') and (S[1]='/') then
        S:='';
      if RecordKind=mrNextStage then begin
        GetMem(MacrosStage, SizeOf(TMacrosStageRecord));
        MacrosStage^.Pos:=FMacrosPos;
        MacrosStage^.Transaction:=EventID;
        FMacrosStageRecordList.Add(MacrosStage);
      end;
      if RecordKind=mrChangePrevRecord then begin
        MacrosStep:=pointer(FMacrosStepRecordList.Objects[FMacrosPos-1]);
        MacrosStep^.P2:=P2;
        FMacrosStepRecordList.AddObject('', nil);
      end else begin
        GetMem(MacrosStep, SizeOf(TMacrosStepRecord));
        FMacrosStepRecordList.AddObject(S, pointer(MacrosStep));
        MacrosStep^.RecordKind:=RecordKind;
        MacrosStep^.FormID:=FormID;
        MacrosStep^.ControlID:=ControlID;
        MacrosStep^.EventID:=EventID;
        MacrosStep^.P1:=P1;
        MacrosStep^.P2:=P2;
      end;
    end else
      FMacrosStepRecordList.AddObject('', nil);
    inc(FMacrosPos);
  end;
  CloseFile(aMacrosFile);
  FMacrosPos:=0;
  FMacrosIndex:=-1;
  FLastMacrosIndex:=-1;
end;

procedure TMacrosManager.PauseMacros(Interval: Integer);
begin
  FCursorStepCount:=0;
  FCursorStep:=0;
  FMacrosTimerKind:=2;
  FMacrosTimer.Interval:=Interval;
  FMacrosTimer.Enabled:=True;
end;

procedure TMacrosManager.PlayFirstStep(StartPos: Integer);
begin
  if StartPos>FMacrosStepRecordList.Count then Exit;
  FIsPlaying:=True;
  FMacrosPos:=StartPos-1;
  PlayNextStep;
end;

procedure TMacrosManager.PlayInputDialog(const WS: WideString);
var
  hWind:integer;
  PhEdit:Pinteger;
begin
  hWind:=DM_GetActiveWindow;
  FMacrosControlHandle:=0;
  PhEdit:=@FMacrosControlHandle;
  DM_EnumChildWindows(hWind, @EnumChildProc1, integer(PhEdit));
  if FMacrosControlHandle<>0 then begin
    FMacrosTypeString:=WS;
    FMacrosTypePos:=0;
    FCursorStepCount:=0;
    FCursorStep:=0;
    FMacrosTimerKind:=1;
    FMacrosTimer.Interval:=FMacrosSmallPauseInterval;
    FMacrosTimer.Enabled:=True;
  end;
end;

procedure TMacrosManager.PlayNextStep;
begin
  while DoPlayNextStep do
end;

procedure TMacrosManager.Set_DemoShowText(Value: WordBool);
begin
  FDemoShowText:=Value
end;

procedure TMacrosManager.Set_DemoSpeech(Value: WordBool);
begin
  FDemoSpeech:=Value
end;

procedure TMacrosManager.Set_MacrosCursorSpeed(Value: Double);
begin
  FMacrosCursorSpeed:=Value
end;

procedure TMacrosManager.Set_MacrosPauseInterval(Value: Integer);
begin
  FMacrosLargePauseInterval:=Value
end;

procedure TMacrosManager.SetMenuItemPos(Command, X, Y: Integer);
var
  CursorStepLength:integer;
begin
  if not FIsPlaying then Exit;
  if FMacrosTimerKind<>3 then Exit;
  if Command<>FCurrMenuItem.Command then Exit;
  FMacrosTimerKind:=0;
  FMacrosTimer.Enabled:=False;
  CursorStepLength:=16;
  StartMacrosStep(X, Y, CursorStepLength);
end;

procedure TMacrosManager.ShowDemoMenu(const FileName: WideString);
var
  ShowMenu:boolean;
begin
  if fmDemoMenu=nil then begin
    fmDemoMenu:=TfmDemoMenu.Create(Self);
    fmDemoMenu.MacrosManager:=Self as IDMMacrosManager;
//    ClearLessonRecordList;
//    fmDemoMenu.LoadLessons(FileName, FLessonRecordList);
  end;
    ClearLessonList;
    fmDemoMenu.LoadLessons(FileName, FLessonRecordList);
  ShowMenu:=True;
  while ShowMenu do begin
    ShowMenu:=False;
    if fmDemoMenu.ShowModal=dmrStartLesson then begin
      SetLesson(fmDemoMenu.CurrentLessonIndex);
      if fmDemoNavigator=nil then
        fmDemoNavigator:=TfmDemoNavigator.Create(Self);
      PlayNextStep;
    end else begin
      Set_SpeechEngine(nil);
      FSpeechFlag:=False;
    end;
  end;
end;

procedure TMacrosManager.StartMacrosStep(X1, Y1,
  CursorStepLength: Integer);
var
  L:double;
begin
  DM_GetCursorPos(FMacrosP0);
  FMacrosP1.X:=X1;
  FMacrosP1.Y:=Y1;
  L:=sqrt(sqr(X1-FMacrosP0.X)+sqr(Y1-FMacrosP0.Y));
  FCursorStepCount:=round(L) div CursorStepLength;
  FCursorStep:=0;
  FMacrosTimerKind:=0;
  FMacrosTimer.Interval:=round(FMacrosTimerInterval/FMacrosCursorSpeed);
  FMacrosTimer.Enabled:=True;
end;

procedure TMacrosManager.SwitchWriteMacros;
var
  N:integer;
  S1, S, Makros:string;
  Document:IDMDocument;
  DataModelServer:IDataModelServer;
  DMContainerX:IDMEditorX;
begin
  DMContainerX:=FDMContainer as IDMEditorX;
  DataModelServer:=DMContainerX.DataModelServer as IDataModelServer;
  if not FWritingMacros then begin
    Makros:='Макрос';
    N:=1;
    S1:=IntToStr(N);
    S:=Makros+S1;

    while FileExists(S) do begin
      inc(N);
      S1:=IntToStr(N);
      S:=Makros+S1;
    end;
    FSaveDialog1.FileName:=S;

    Document:=DataModelServer.CurrentDocument;
    FSaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);

    if not FSaveDialog1.Execute then Exit;
    S:=FSaveDialog1.FileName;
    AssignFile(FMacrosFile, S);
    Rewrite(FMacrosFile);
    FWritingMacros:=True;
    WriteMacrosState;
  end else begin
    CloseFile(FMacrosFile);
    ShowMessage('Макрос записан');
    DataModelServer.RefreshDocument(rfFrontBack);
    FWritingMacros:=False;
  end;
end;

procedure TMacrosManager.WriteMacrosEvent(RecordKind, FormID, ControlID,
  EventID, P1, P2: Integer; const S: WideString);
var
  F:string;
begin
  if not FWritingMacros then Exit;
  F:=Format('%d %d %d %d %d %d %s', [RecordKind, FormID, ControlID, EventID,
      P1, P2, S]);
  Writeln(FMacrosFile, F);
end;

procedure TMacrosManager.WriteMacrosState;
var
  DMMacrosPlayer:IDMMacrosPlayer;
  DMForm:IDMForm;
  TransactionCount:integer;
  DMOperationManager:IDMOperationManager;
  DataModelServer:IDataModelServer;
  DMContainer:TDMContainer;
  DMContainerX:IDMEditorX;
begin
  DMContainer:=FDMContainer as TDMContainer;
  DMContainerX:=DMContainer as IDMEditorX;
  DataModelServer:=DMContainerX.DataModelServer as IDataModelServer;
  DMOperationManager:=(DataModelServer.CurrentDocument as IDMOperationManager);
  TransactionCount:=DMOperationManager.TransactionCount;
  WriteMacrosEvent(mrNextStage, -1, -1, TransactionCount, -1, -1, '');
  if DMContainer.ActiveDMToolBar<>nil then
    DMContainer.ActiveDMToolBar.WriteMacrosState;
  if DMContainer.Form0<>nil then begin
    DMForm:=IDMForm(DMContainer.Form0);
    WriteMacrosEvent(mrSetEditorState, DMForm.FormID, 0, -1, -1, -1, '');
    DMMacrosPlayer:=DMForm as IDMMacrosPlayer;
    DMMacrosPlayer.WriteMacrosState;
  end else
    WriteMacrosEvent(mrSetEditorState, -1, 0, -1, -1, -1, '');
  if DMContainer.Form1<>nil then begin
    DMForm:=IDMForm(DMContainer.Form1);
    WriteMacrosEvent(mrSetEditorState, DMForm.FormID, 1, -1, -1, -1, '');
    DMMacrosPlayer:=DMForm as IDMMacrosPlayer;
    DMMacrosPlayer.WriteMacrosState;
  end else
    WriteMacrosEvent(mrSetEditorState, -1, 1, -1, -1, -1, '');
  WriteMacrosEvent(mrStopMacros, -1, -1, -1, -1, -1, '');
end;

constructor TMacrosManager.Create(aOwner: TComponent);
begin
  inherited;
  FMacrosTimer:=TTimer.Create(Self);
  FMacrosTimer.Enabled:=False;
  FMacrosTimer.OnTimer:=MacrosTimerTimer;
  FSaveDialog1:=TSaveDialog.Create(Self);

  if not (Owner is TDMContainer) then Exit;
  
  FDMContainer:=Owner as TDMContainer;

  FMacrosStepRecordList:=TStringList.Create;
  FMacrosStageRecordList:=TList.Create;
  FLessonRecordList:=TList.Create;
  FMacrosTimerInterval:=10;
  FMacrosLargePauseInterval:=1000;
  FMacrosSmallPauseInterval:=300;
  FMacrosCursorSpeed:=0.2;
  FDemoShowText:=True;
  FDemoSpeech:=True;

end;

destructor TMacrosManager.Destroy;
begin
  inherited;

  ClearMacrosStepList;
  FMacrosStepRecordList.Free;
  ClearMacrosStageList;
  FMacrosStageRecordList.Free;
  ClearLessonList;
  FLessonRecordList.Free;
  
  FSpeechEngine:=nil;
end;

procedure TMacrosManager.MacrosTimerTimer(Sender: TObject);
var
  X, Y, RecordKind, FormID, EventID, ControlID, Pos, MainMenuHandle,
  aLeft, aBottom, hMenu, aCommand, aItemIndex, FormIndex, FormPosition:integer;
  aFlags:Word;
  S:string;
  PS:array[0..255] of char;
  lParam:PChar;
  WaitCommandInterval:integer;
  DMMacrosPlayer:IDMMacrosPlayer;
  theForm:IDMForm;
  DMContainer:TDMContainer;
begin
  try
  DMContainer:=FDMContainer as TDMContainer;
  RecordKind:=FMacrosStepRecord.RecordKind;
  FormID:=FMacrosStepRecord.FormID;
  ControlID:=FMacrosStepRecord.ControlID;
  EventID:=FMacrosStepRecord.EventID;
  if FormID<>-1 then begin
    DMContainer.GetForm(FormID, theForm, FormIndex, FormPosition);
    DMMacrosPlayer:=theForm as IDMMacrosPlayer;
  end;

  case FMacrosTimerKind of
  0:begin
      if (FCursorStepCount<>0) and   // Mouse
         (FMacrosPhase<=0) then begin
        inc(FCursorStep);
        X:=round(FMacrosP0.X+(FMacrosP1.X-FMacrosP0.X)*FCursorStep/FCursorStepCount);
        Y:=round(FMacrosP0.Y+(FMacrosP1.Y-FMacrosP0.Y)*FCursorStep/FCursorStepCount);
        DM_SetCursorPos(X, Y);
      end;
      if FCursorStep=FCursorStepCount then begin
        FCursorStepCount:=0;
        FCursorStep:=0;
        FMacrosTimer.Enabled:=False;
        Application.ProcessMessages;

        if FormID=-1 then begin
          case RecordKind of
          mrFormEvent:
            begin
              DoMacrosStep(ControlID, EventID);
              PlayNextStep;
            end;
          mrToolBarEvent:
            begin
              if EventID=meLClick then begin
                if FMacrosPhase>0 then begin
                  FMacrosPhase:=0;
                  DMContainer.ActiveDMToolBar.DoMacrosStep
                end else begin
                  FMacrosPhase:=1;
                  FMacrosTimer.Interval:=FMacrosLargePauseInterval;
                  FMacrosTimer.Enabled:=True;
                end;
              end else
                DMContainer.ActiveDMToolBar.DoMacrosStep
            end;
          mrMenuEvent:
            begin
              Pos:=FCurrMenuItem.Pos;
              MainMenuHandle:=DMContainer.DMMainMenu.Handle;
              hMenu:=DM_GetSubMenu(MainMenuHandle, Pos);
              if FCurrMenuItem.MenuItems.Count>0 then begin
                PauseMacros(FMacrosSmallPauseInterval);

                aLeft:=FCurrMenuItem.Left;
                aBottom:=FCurrMenuItem.Bottom;
                aFlags:=TPM_LeftAlign or TPM_LeftButton;
                DM_TrackPopupMenu(hMenu, aFlags, aLeft, aBottom, 0 { reserved },
                         FMainFormHandle, nil);
              end else
              if EventID=meLClick then begin
                aCommand:=FCurrMenuItem.Command;
                WaitCommandInterval:=FMacrosStepRecord.P2;
                if WaitCommandInterval=-1 then begin
                  FMacrosPhase:=0;
                  DM_SendMessage(FMainFormHandle, WM_Command, aCommand, 0);
                  PlayNextStep;
                end else begin
                  PauseMacros(WaitCommandInterval);
                  DM_SendMessage(FMainFormHandle, WM_Command, aCommand, 0);
                end;
              end;
            end;
          mrDialogEvent:
            begin
              aItemIndex:=FMacrosStepRecord.P1;
              DoDialogEvent(ControlID, aItemIndex);
              PlayNextStep;
            end;
          end; //case RecordKind of
        end else  //if FormID<>-1
          PlayNextStep;
      end; //if FCursorStep=FCursorStepCount
    end;
  1:begin  // Type in standard dialog
      if FMacrosTypePos<=length(FMacrosTypeString) then begin
        S:=Copy(FMacrosTypeString, 1, FMacrosTypePos);
        lParam:=StrPCopy(PS, S);
        DM_SendMessage(FMacrosControlHandle, WM_SetText, 0, integer(lParam));
        inc(FMacrosTypePos);
      end else begin
        if FormID<>-1 then
          DMMacrosPlayer.CloseActiveWindow
        else
          CloseActiveWindow;
        FMacrosTimerKind:=0;
      end;
    end;
  2:begin // Pause
      FMacrosTimer.Enabled:=False;
      FMacrosTimerKind:=0;
      RecordKind:=FMacrosStepRecord.RecordKind;
      case RecordKind of
      mrStopMacros:
        ShowDemoNavigator;
      else
        PlayNextStep;
      end;
    end;
  end;
  except
    raise
  end;
end;

procedure TMacrosManager.ClearLessonList;
var
  j:integer;
  Lesson:PLessonRecord;
begin
  for j:=0 to FLessonRecordList.Count-1 do begin
    Lesson:=FLessonRecordList[j];
    if Lesson<>nil then
      FreeMem(Lesson, SizeOf(TLessonRecord))
  end;
  FLessonRecordList.Clear;
end;

procedure TMacrosManager.ClearMacrosStageList;
var
  j:integer;
  MacrosStage:PMacrosStageRecord;
begin
  for j:=0 to FMacrosStageRecordList.Count-1 do begin
    MacrosStage:=FMacrosStageRecordList[j];
    if MacrosStage<>nil then
      FreeMem(MacrosStage, SizeOf(TMacrosStageRecord))
  end;
  FMacrosStageRecordList.Clear;
end;

procedure TMacrosManager.ClearMacrosStepList;
var
  j:integer;
  MacrosStep:PMacrosStepRecord;
begin
  for j:=0 to FMacrosStepRecordList.Count-1 do begin
    MacrosStep:=pointer(FMacrosStepRecordList.Objects[j]);
    if MacrosStep<>nil then
      FreeMem(MacrosStep, SizeOf(TMacrosStepRecord))
  end;
  FMacrosStepRecordList.Clear;
end;

function TMacrosManager.DoPlayNextStep: boolean;
var
  DMMacrosPlayer:IDMMacrosPlayer;
  RecordKind, FormID, ControlID, EventID, X, Y:integer;
  theForm:IDMForm;
  FormIndex, FormPosition:integer;
  WS:WideString;
  PauseFlag:boolean;
  CursorStepLength:integer;
  DMContainer:TDMContainer;
  DMContainerX:IDMEditorX;
  AddRefForm:TfmAddRef;
begin
  DMContainer:=FDMContainer as TDMContainer;
  DMContainerX:=DMContainer as IDMEditorX;
  AddRefForm:=DMContainer.AddRefForm;
  try
  Result:=False;
  if FMacrosPos=FMacrosStepRecordList.Count then begin
    FIsPlaying:=False;
    Exit;
  end;

  DMContainer:=FDMContainer as TDMContainer;
  FMacrosStepRecord:=nil;
  while FMacrosStepRecord=nil do begin
    FMacrosStepRecord:=pointer(FMacrosStepRecordList.Objects[FMacrosPos]);
    FMacrosStepText:=FMacrosStepRecordList[FMacrosPos];
    inc(FMacrosPos);
  end;
  RecordKind:=FMacrosStepRecord.RecordKind;
  FormID:=FMacrosStepRecord.FormID;
  ControlID:=FMacrosStepRecord.ControlID;
  EventID:=FMacrosStepRecord.EventID;
  X:=FMacrosStepRecord.P1;
  Y:=FMacrosStepRecord.P2;
  WS:=FMacrosStepText;
  case RecordKind of
  mrFormEvent:
    begin
      if FormID<>-1 then begin
        DMContainer.GetForm(FormID, theForm, FormIndex, FormPosition);
        DMMacrosPlayer:=theForm as IDMMacrosPlayer;
        if DMContainerX.FormVisible[FormIndex, FormPosition] then
          Result:=DMMacrosPlayer.DoMacrosStep(RecordKind, ControlID, EventID, X, Y, WS)
        else
          InitSwitchFormMacros(FormIndex, FormPosition)
      end else begin
        InitMacrosStep(ControlID, EventID, X, Y, WS);
      end;
    end;
  mrToolBarEvent:
    DMContainer.ActiveDMToolBar.InitMacrosStep(ControlID, EventID);
  mrPause:
    begin
      PauseFlag:=(X>0);
      if FDemoSpeech then begin
        if WS<>'' then begin
          case Y of
          0:  Say(WS, False, False, PauseFlag);
          1:  Say(WS, False, True, PauseFlag);
          2:  Say(WS, True,  False, PauseFlag);
          3:  Say(WS, True,  True, PauseFlag);
          end;
        end;
        if PauseFlag then
          PauseMacros(X);
        if EventID=1 then
          Result:=True;
      end else
        PauseMacros(FMacrosLargePauseInterval)
    end;
  mrMenuEvent:
    if FormID<>-1 then begin
      DMContainer.GetForm(FormID, theForm, FormIndex, FormPosition);
      DMMacrosPlayer:=theForm as IDMMacrosPlayer;
      Result:=DMMacrosPlayer.DoMacrosStep(RecordKind, ControlID, EventID, X, Y, WS);
    end else begin
      FCurrMenuItem:=DMContainer.DMMainMenu.FindByCommand(ControlID);
      X:=FCurrMenuItem.PX;
      Y:=FCurrMenuItem.PY;
      CursorStepLength:=8;
      StartMacrosStep(X, Y, CursorStepLength)
    end;
  mrDialogEvent:
    begin
      if FormID<>-1 then begin
        DMContainer.GetForm(FormID, theForm, FormIndex, FormPosition);
        DMMacrosPlayer:=theForm as IDMMacrosPlayer;
        Result:=DMMacrosPlayer.DoMacrosStep(RecordKind, ControlID, EventID, X, Y, WS);
        if WS<>'' then
          PlayInputDialog(WS)
        else
        if EventID=ColorDialogEventId then
          PlayColorDialog(round(X))
      end else begin
        case ControlID of
        deAddRefInit:begin
//            if AddRefForm=nil then begin
//              AddRefForm:=TfmAddRefForm.Create(Self);
//              AddRefForm.DMEditorX:=Self as IDMEditorX;
//            end;
            Result:=True;
          end;
        deAddRefName:
          PlayInputDialog(WS);
        de_AddRefInit:begin
            if fm_AddRef=nil then begin
              fm_AddRef:=Tfm_AddRef.Create(Self);
              fm_AddRef.DMEditorX:=Self as IDMEditorX;
            end;
            fm_AddRef.LastClassIndex:=EventID;
            Result:=True;
          end;
        de_AddRefName:
          PlayInputDialog(WS);
        deDelete:
          CloseActiveWindow;
        deInputName:
          PlayInputDialog(WS);
        deInputInteger:
          PlayInputDialog(WS);
        else
          InitComboBoxEvent(ControlID, EventID, X, Y, WS);
        end;
      end;
    end;
  mrSetFormState:
    if FormID<>-1 then begin
      DMContainer.GetForm(FormID, theForm, FormIndex, FormPosition);
      DMMacrosPlayer:=theForm as IDMMacrosPlayer;
      DMMacrosPlayer.SetMacrosState(ControlID, EventID, X, Y);
      Result:=True;
    end;
  mrSetToolBarState:
    begin
      DMContainer.ActiveDMToolBar.SetMacrosState(ControlID, EventID, X, Y);
      Result:=True;
    end;
  mrSetEditorState:
    begin
      FormPosition:=ControlID;
      if FormID=-1 then begin
        case FormPosition of
        0:begin
            if DMContainer.Form0<>nil then begin
              FormIndex:=DMContainer.FormList0.IndexOf(DMContainer.Form0);
              DMContainerX.FormVisible[FormIndex, FormPosition]:=False;
            end;
          end;
        1:begin
            if DMContainer.Form1<>nil then begin
              FormIndex:=DMContainer.FormList1.IndexOf(DMContainer.Form1);
              DMContainerX.FormVisible[FormIndex, FormPosition]:=False;
            end;
          end;
        end;
      end else begin
        case FormPosition of
        0:if DMContainer.Form0=nil then begin
            DMContainer.GetForm(FormID, theForm, FormIndex, FormPosition);
            DMContainerX.FormVisible[FormIndex, FormPosition]:=True;
          end;
        1:if DMContainer.Form1=nil then begin
            DMContainer.GetForm(FormID, theForm, FormIndex, FormPosition);
            DMContainerX.FormVisible[FormIndex, FormPosition]:=True;
          end;
        end;
      end;
      Result:=True;
    end;
  mrStopMacros:
    begin
      FIsPlaying:=False;
      inc(FMacrosIndex);
      PauseMacros(500)
    end;
  else
    Result:=True;
  end; //case RecordKind of
  except
    raise
  end;
end;

procedure TMacrosManager.GoToNextMacros;
var
  MacrosStage:PMacrosStageRecord;
  OldState, j, Transaction0, Transaction1:integer;
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  DataModelServer:IDataModelServer;
  DMContainer:TDMContainer;
  DMContainerX:IDMEditorX;
  aDataModel:IDataModel;
begin
  DMContainer:=FDMContainer as TDMContainer;
  DMContainerX:=DMContainer as IDMEditorX;
  DataModelServer:=DMContainerX.DataModelServer as IDataModelServer;
  if FMacrosIndex+1<FMacrosStageRecordList.Count then begin
    DMDocument:=DataModelServer.CurrentDocument;
    aDataModel:=DMDocument.DataModel as IDataModel;
    OldState:=aDataModel.State;
    aDataModel.State:=aDataModel.State or dmfAuto;

    MacrosStage:=PMacrosStageRecord(FMacrosStageRecordList[FMacrosIndex+1]);
    FMacrosPos:=MacrosStage^.Pos+1;
    Transaction1:=MacrosStage.Transaction;

    DMOperationManager:=DataModelServer.CurrentDocument as IDMOperationManager;
    try

    if FLastMacrosIndex<>-1 then begin
      DMOperationManager.LoadTransactions(FLessonFileName);
      for j:=0 to Transaction1-1 do
        DMOperationManager.Redo;
    end else begin
      MacrosStage:=PMacrosStageRecord(FMacrosStageRecordList[FMacrosIndex]);
      Transaction0:=MacrosStage.Transaction;

      for j:=Transaction0 to Transaction1-1 do
        DMOperationManager.Redo;
    end;

    finally
      aDataModel.State:=OldState;
      DataModelServer.RefreshDocument(rfFrontBack);
    end;
  end;
end;

procedure TMacrosManager.GoToPrevMacros;
var
  MacrosStage:PMacrosStageRecord;
  OldState, j, Transaction0, Transaction1:integer;
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  DataModelServer:IDataModelServer;
  DMContainer:TDMContainer;
  DMContainerX:IDMEditorX;
  aDataModel:IDataModel;
begin
  DMContainer:=FDMContainer as TDMContainer;
  DMContainerX:=DMContainer as IDMEditorX;
  DataModelServer:=DMContainerX.DataModelServer as IDataModelServer;
  MacrosStage:=PMacrosStageRecord(FMacrosStageRecordList[FMacrosIndex]);
  Transaction0:=MacrosStage.Transaction;
  dec(FMacrosIndex);
  if FMacrosIndex>=0 then begin
    DMDocument:=DataModelServer.CurrentDocument;
    aDataModel:=DMDocument.DataModel as IDataModel;
    OldState:=aDataModel.State;
    aDataModel.State:=aDataModel.State or dmfAuto;

    MacrosStage:=PMacrosStageRecord(FMacrosStageRecordList[FMacrosIndex]);
    dec(FMacrosIndex);
    FMacrosPos:=MacrosStage^.Pos+1;
    Transaction1:=MacrosStage.Transaction;

    DMOperationManager:=DMDocument as IDMOperationManager;
    try
    for j:=Transaction1 to Transaction0-1 do
      DMOperationManager.Undo;
    finally
      aDataModel.State:=OldState;
      DataModelServer.RefreshDocument(rfFrontBack);
    end;
  end;
end;

procedure TMacrosManager.InitSwitchFormMacros(FormIndex,
  FormPosition: integer);
var
  j, aPosition, CursorStepLength:integer;
  ToolButton:TToolButton;
  P:TPoint;
  DMContainer:TDMContainer;
begin
  DMContainer:=FDMContainer as TDMContainer;
  aPosition:=0;
  ToolButton:=nil;
  for j:=0 to DMContainer.tbForms.ButtonCount-1 do begin
    ToolButton:=DMContainer.tbForms.Buttons[j];
    if ToolButton.Tag=-1 then
      aPosition:=1
    else
    if (ToolButton.Tag=FormIndex) and
         (aPosition=FormPosition) then
      Break
  end;
  if j<DMContainer.tbForms.ButtonCount then begin
    P.X:=ToolButton.Width div 2;
    P.Y:=ToolButton.Height div 2;
    P:=ToolButton.ClientToScreen(P);
    FMacrosControlHandle:=DMContainer.tbForms.Handle;
    FMacrosPhase:=-2;
    CursorStepLength:=16;
    StartMacrosStep(P.X, P.Y, CursorStepLength);
  end;
end;

procedure TMacrosManager.PlayColorDialog(Color: integer);
var
  hWind, X, Y, dX, dY, CursorStepLength, j, m, k:integer;
  PhColorGrid:Pinteger;
  R:TRect;
  aColor:TColor;
begin
  hWind:=DM_GetActiveWindow;
  FMacrosControlHandle:=0;
  PhColorGrid:=@FMacrosControlHandle;
  DM_EnumChildWindows(hWind, @EnumChildProc2, integer(PhColorGrid));
  if FMacrosControlHandle<>0 then begin
    DM_GetWindowRect(FMacrosControlHandle, R);
    dX:=(R.Right-R.Left) div 8;
    dY:=(R.Bottom-R.Top) div 6;
    j:=0;
    m:=0;
    while j<6 do begin
      m:=0;
      while m<8 do begin
        k:=8*j+m;
        aColor:=BaseColor[k,0]+(BaseColor[k,1] shl 8)+(BaseColor[k,2] shl 16);
        if aColor=Color then
          Break
        else
          inc(m);
      end;
      if m<8 then
        Break
      else
        inc(j);
    end;
    X:=R.Left+m*dX+(dX div 2);
    Y:=R.Top+ j*dY+(dY div 2);
    CursorStepLength:=8;
    StartMacrosStep(X, Y, CursorStepLength)
  end;
end;

procedure TMacrosManager.SetLesson(LessonIndex: integer);
var
  Lesson:PLessonRecord;
  S1, S2, S3, Path:WideString;
  DMOperationManager:IDMOperationManager;
  DataModelServer:IDataModelServer;
  DMContainer:TDMContainer;
  DMContainerX:IDMEditorX;
begin
  DMContainer:=FDMContainer as TDMContainer;
  DMContainerX:=DMContainer as IDMEditorX;
  DataModelServer:=DMContainerX.DataModelServer as IDataModelServer;
  Lesson:=PLessonRecord(FLessonRecordList[LessonIndex]);
  S1:=Lesson^.ModelFileName;
  S2:=Lesson^.MacrosFileName;
  S3:=Lesson^.TransactionFileName;
  Path:=ExtractFilePath(Application.ExeName);
  if S1<>'' then begin
    S1:=Path+S1;
    LoadLessonModel(S1);
  end;
  if S2<>'' then begin
    S2:=Path+S2;
    LoadMacros(S2);
  end;
  if S3<>'' then begin
    FLessonFileName:=Path+S3;
    DMOperationManager:=DataModelServer.CurrentDocument as IDMOperationManager;
    DMOperationManager.LoadTransactions(FLessonFileName);
  end;
end;

function TMacrosManager.Get_SpeechEngine: IUnknown;
begin
  Result:=FSpeechEngine
end;

function TMacrosManager.Get_SpeechFlag: WordBool;
begin

end;

procedure TMacrosManager.Say(const Text: WideString; CanWait,
  MaybeInterrupted, MacrosPaused: WordBool);
var
  SpeechEngine:ITTSCentral;
  SData: TSData;
  S:string;
begin
  if not FSpeechFlag then Exit;
  SpeechEngine:=FSpeechEngine as ITTSCentral;
  if SpeechEngine=nil then Exit;

  if FMaybeInterrupted and not
     CanWait then
    SpeechEngine.AudioReset;
  FMaybeInterrupted:=MaybeInterrupted;
  FMacrosPausedWhileSpeeking:=MacrosPaused;

  S:=Text;
  SData.dwSize := length(S) + 1;
  SData.pData := pChar(S);
  SpeechEngine.TextData(CHARSET_TEXT, 1, SData, nil, IID_ITTSBufNotifySink);

end;

procedure TMacrosManager.Set_SpeechEngine(const Value: IInterface);
var
  TTSCentral:ITTSCentral;
  TTSNotifySinkA:ITTSNotifySinkA;
begin
  TTSNotifySinkA:=Self as ITTSNotifySinkA;
  if Value<>nil then begin
    TTSCentral:=Value as ITTSCentral;
    TTSCentral.Register(pointer(TTSNotifySinkA), IID_ITTSNotifySinkA, FTTSNotifySinkKey);
    FSpeechFlag:=True;
    FSpeechEngine:=Value
  end else begin
    if FSpeechEngine<>nil then begin
      TTSCentral:=FSpeechEngine as ITTSCentral;
      TTSCentral.UnRegister(FTTSNotifySinkKey);
      FSpeechEngine:=nil;
    end;
    FSpeechFlag:=False;
  end;
end;

procedure TMacrosManager.Set_SpeechFlag(Value: WordBool);
begin
  FSpeechFlag:=Value;
end;

function TMacrosManager.AttribChanged(dwAttribute: DWORD): HResult;
begin
  Result:=0
end;

function TMacrosManager.AudioStart(qTimeStamp: QWORD): HResult;
begin
  Result:=0
end;

function TMacrosManager.AudioStop(qTimeStamp: QWORD): HResult;
begin
  Result:=0;
  if not FMacrosPausedWhileSpeeking then Exit;
  FMacrosTimer.Enabled:=False;
  FMacrosPhase:=0;
  PlayNextStep;
end;

function TMacrosManager.Visual(qTimeStamp: QWORD; cIPAPhoneme,
  cEnginePhoneme: AnsiChar; dwHints: DWORD; pTTSMouth: PTTSMOUTH): HResult;
begin
  Result:=0
end;

procedure TMacrosManager.ShowDemoNavigator;
begin
   if fmDemoNavigator=nil then
     fmDemoNavigator:=TfmDemoNavigator.Create(Self);
     
   if FMacrosIndex=0 then
     fmDemoNavigator.btPrev.Enabled:=False
   else
     fmDemoNavigator.btPrev.Enabled:=True;

   if FMacrosIndex=FMacrosStageRecordList.Count-1 then
     fmDemoNavigator.btNext.Enabled:=False
   else
     fmDemoNavigator.btNext.Enabled:=True;
     
   case fmDemoNavigator.ShowModal of
   dmrPrev:
     begin
       GoToPrevMacros;
       PlayNextStep;
     end;
   dmrMenu:
     begin
       if fmDemoMenu.ShowModal=dmrStartLesson then begin
         SetLesson(fmDemoMenu.CurrentLessonIndex);
         PlayNextStep;
       end else begin
         Set_SpeechEngine(nil);
         FSpeechFlag:=False;
       end;
     end;
   dmrShow:
     begin
       FIsPlaying:=True;
       if FLastMacrosIndex=-1 then
         FLastMacrosIndex:=FMacrosIndex;
       PlayNextStep;
     end;
   dmrNext:
     begin
       GoToNextMacros;
       PlayNextStep;
     end;
   end;
end;

procedure TMacrosManager.DoDialogEvent(ControlID, aItemIndex: integer);
var
  ComboBox:TComboBox;
  j:integer;
  Element:IDMElement;
  AddRefForm:TfmAddRef;
  DMContainer:TDMContainer;
begin
  DMContainer:=FDMContainer as TDMContainer;
  AddRefForm:=DMContainer.AddRefForm;
  case ControlID of
  deAddRefKind:    ComboBox:=AddRefForm.edKind;
  deAddRefSubKind: ComboBox:=AddRefForm.edSubKind;
  de_AddRefClass:  ComboBox:=fm_AddRef.edClassCollection;
  de_AddRefKind:   ComboBox:=fm_AddRef.edKind;
  de_AddRefSubKind:ComboBox:=fm_AddRef.edSubKind;
  else
    ComboBox:=nil;
  end;

  if ComboBox<>nil then begin
    DM_SendMessage(ComboBox.Handle, CB_SHOWDROPDOWN, ord(False), 0);
    if ControlID=de_AddRefClass then
      ComboBox.ItemIndex:=aItemIndex
    else begin
      j:=0;
      while j<ComboBox.Items.Count do begin
        Element:=IDMElement(pointer(ComboBox.Items.Objects[j]));
        if Element.ID=aItemIndex then
          Break
        else
          inc(j)
      end;
      if j<ComboBox.Items.Count then
        ComboBox.ItemIndex:=j
    end;
    ComboBox.OnChange(ComboBox);
  end;
end;

procedure TMacrosManager.DoMacrosStep(ControlID, EventID: integer);
var
  MacrosControl:TWinControl;
  AddRefForm:TfmAddRef;
  DMContainer:TDMContainer;
begin
  DMContainer:=FDMContainer as TDMContainer;
  AddRefForm:=DMContainer.AddRefForm;
  case ControlID of
  deAddRefKind:    MacrosControl:=AddRefForm.edKind;
  deAddRefSubKind: MacrosControl:=AddRefForm.edSubKind;
  de_AddRefClass:  MacrosControl:=fm_AddRef.edClassCollection;
  de_AddRefKind:   MacrosControl:=fm_AddRef.edKind;
  de_AddRefSubKind:MacrosControl:=fm_AddRef.edSubKind;
  else
    MacrosControl:=nil;
  end;

  if MacrosControl<>nil then
    DM_SendMessage(MacrosControl.Handle, CB_SHOWDROPDOWN, ord(True), 0);
end;

procedure TMacrosManager.InitComboBoxEvent(ControlID, EventID, X,
  Y: integer; const WS: WideString);
var
  CursorStepLength:integer;
  MacrosControl:TWinControl;
  R:TRect;
  H, j0, j, aX, aY:integer;
  AddRefForm:TfmAddRef;
  DMContainer:TDMContainer;
begin
  DMContainer:=FDMContainer as TDMContainer;
  AddRefForm:=DMContainer.AddRefForm;
  case ControlID of
  -1,7,12:
    PlayInputDialog(WS);
  else
    begin
      case ControlID of
      5:MacrosControl:=AddRefForm.edKind;
      6:MacrosControl:=AddRefForm.edSubKind;
      9:MacrosControl:=fm_AddRef.edClassCollection;
      10:MacrosControl:=fm_AddRef.edKind;
      11:MacrosControl:=fm_AddRef.edSubKind;
      else
        MacrosControl:=nil;
      end;
      DM_SendMessage(MacrosControl.Handle, CB_GETDROPPEDCONTROLRECT, 0, integer(@R));
      H:=DM_SendMessage(MacrosControl.Handle, CB_GETITEMHEIGHT, 0, 0);
      j0:=DM_SendMessage(MacrosControl.Handle, CB_GETTOPINDEX, 0, 0);
      j:=X;
      if j<j0 then
       DM_SendMessage(MacrosControl.Handle, CB_SETTOPINDEX, j, 0)
      else
      if (j-j0+2)*H>(R.Bottom-R.Top) then begin
       j0:=j+2-((R.Bottom-R.Top) div H);
       DM_SendMessage(MacrosControl.Handle, CB_SETTOPINDEX, j0, 0)
      end;
      aX:=R.Left+((R.Right - R.Left) div 5);
      aY:=R.Top+H*(j-j0+1) + H div 2;
      CursorStepLength:=8;
      StartMacrosStep(aX, aY, CursorStepLength);
    end;
  end;
end;

procedure TMacrosManager.InitMacrosStep(ControlID, EventID, X, Y: integer;
  const WS: WideString);
var
  P:TPoint;
  CursorStepLength:integer;
  MacrosControl:TWinControl;
  AddRefForm:TfmAddRef;
  DMContainer:TDMContainer;
begin
  DMContainer:=FDMContainer as TDMContainer;
  AddRefForm:=DMContainer.AddRefForm;
  case EventID of
  meMouseMove:
    begin
      case ControlID of
      5:begin
          MacrosControl:=AddRefForm.edKind;
          P.X:=MacrosControl.Width - 5;
        end;
      6:begin
          MacrosControl:=AddRefForm.edSubKind;
          P.X:=MacrosControl.Width - 5;
        end;
      7:begin
          MacrosControl:=AddRefForm.edName;
          P.X:=MacrosControl.Width div 2;
        end;
      9:begin
          MacrosControl:=fm_AddRef.edClassCollection;
          P.X:=MacrosControl.Width - 5;
        end;
      10:begin
           MacrosControl:=fm_AddRef.edKind;
           P.X:=MacrosControl.Width - 5;
         end;
      11:begin
           MacrosControl:=fm_AddRef.edSubKind;
           P.X:=MacrosControl.Width - 5;
         end;
      12:begin
           MacrosControl:=fm_AddRef.edName;
           P.X:=MacrosControl.Width div 2;
         end;
      else
        MacrosControl:=nil;
      end;
      P.Y:=MacrosControl.Height div 2;
      P:=MacrosControl.ClientToScreen(P);
      CursorStepLength:=16;
      StartMacrosStep(P.X, P.Y, CursorStepLength);
    end;
  end;
end;

procedure TMacrosManager.Write_AddRefMacros(aParentClassID, aParentID,
  aID: integer);
var
  WS:WideString;
  R:TRect;
  P:TPoint;
  DMContainer:TDMContainer;
begin
  DMContainer:=FDMContainer as TDMContainer;
  if DMContainer.LastClassIndex<>fm_AddRef.LastClassIndex then begin
    R:=fm_AddRef.edClassCollection.BoundsRect;
    P.X:=R.Right-15;
    P.Y:=(R.Top+R.Bottom) div 2;
    P:=fm_AddRef.edClassCollection.ClientToScreen(P);
    WriteMacrosEvent(mrFormEvent, -1, 10,
         meMouseMove, P.X, P.Y, '');
    WriteMacrosEvent(mrDialogEvent, -1, de_AddRefClass,
        -1, aParentClassID, -1, '');
  end;

  R:=fm_AddRef.edKind.BoundsRect;
  P.X:=R.Right-15;
  P.Y:=(R.Top+R.Bottom) div 2;
  P:=fm_AddRef.edKind.ClientToScreen(P);
  WriteMacrosEvent(mrFormEvent, -1, 10,
       meMouseMove, P.X, P.Y, '');
  WriteMacrosEvent(mrDialogEvent, -1, de_AddRefKind,
      -1, aParentID, -1, '');

    R:=fm_AddRef.edSubKind.BoundsRect;
    P.X:=R.Right-15;
    P.Y:=(R.Top+R.Bottom) div 2;
    P:=fm_AddRef.edSubKind.ClientToScreen(P);
    WriteMacrosEvent(mrFormEvent, -1, 11,
         meMouseMove, P.X, P.Y, '');
    WriteMacrosEvent(mrDialogEvent, -1, de_AddRefSubKind,
        -1, aID,-1, '');
        
  WS:=fm_AddRef.edName.Text;

  R:=fm_AddRef.edName.BoundsRect;
  P.X:=R.Left+((R.Right - R.Left) div 5);
  P.Y:=(R.Top+R.Bottom) div 2;
  P:=fm_AddRef.edSubKind.ClientToScreen(P);
  WriteMacrosEvent(mrFormEvent, -1, 12,
         meMouseMove, P.X, P.Y, '');
  WriteMacrosEvent(mrDialogEvent, -1, de_AddRefName,
        -1, -1,-1, WS);
end;

procedure TMacrosManager.WriteAddRefMacros(aParentID, aID: integer);
var
  WS:WideString;
  R:TRect;
  P:TPoint;
  DMContainer:TDMContainer;
  AddRefForm:TfmAddRef;
begin
  DMContainer:=FDMContainer as TDMContainer;
  AddRefForm:=DMContainer.AddRefForm;
  R:=AddRefForm.edKind.BoundsRect;
  P.X:=R.Right-15;
  P.Y:=(R.Top+R.Bottom) div 2;
  P:=AddRefForm.edKind.ClientToScreen(P);
  WriteMacrosEvent(mrFormEvent, -1, 5,
       meMouseMove, P.X, P.Y, '');
  WriteMacrosEvent(mrDialogEvent, -1, deAddRefKind,
      -1, aParentID, -1, '');

  R:=AddRefForm.edSubKind.BoundsRect;
  P.X:=R.Right-15;
  P.Y:=(R.Top+R.Bottom) div 2;
  P:=AddRefForm.edSubKind.ClientToScreen(P);
  WriteMacrosEvent(mrFormEvent, -1, 6,
       meMouseMove, P.X, P.Y, '');
  WriteMacrosEvent(mrPause, -1, -1, 1, 500, -1, '');
  WriteMacrosEvent(mrDialogEvent, -1, deAddRefSubKind,
      -1, aID,-1, '');
  WS:=AddRefForm.edName.Text;

  R:=AddRefForm.edName.BoundsRect;
  P.X:=R.Left+((R.Right - R.Left) div 5);
  P.Y:=(R.Top+R.Bottom) div 2;
  P:=AddRefForm.edSubKind.ClientToScreen(P);
  WriteMacrosEvent(mrFormEvent, -1, 7,
         meMouseMove, P.X, P.Y, '');
  WriteMacrosEvent(mrPause, -1, -1, 1, 500, -1, '');
  WriteMacrosEvent(mrDialogEvent, -1, deAddRefName,
        -1, -1,-1, WS);
end;

function TMacrosManager.Get_MainFormHandle: Integer;
begin
  Result:=FMainFormHandle
end;

procedure TMacrosManager.Set_MainFormHandle(Value: Integer);
begin
  FMainFormHandle:=Value
end;

procedure TMacrosManager.CloseActiveWindow;
var
  hWind:integer;
  theActiveForm:TForm;
  m:integer;
  Component:TComponent;
  Button:TButton;
begin
  hWind:=DM_GetActiveWindow;
  theActiveForm:=Screen.ActiveForm;
  if theActiveForm=nil then
    DM_DestroyWindow(hWind)
  else
  if theActiveForm.Handle<>DWORD(hWind) then
    DM_DestroyWindow(hWind)
  else begin
    Button:=nil;
    m:=0;
    while m<theActiveForm.ComponentCount do begin
      Component:=theActiveForm.Components[m];
      if (Component is TButton) then begin
        Button:=Component as TButton;
        if (Button.ModalResult=mrOK) or
           (Button.ModalResult=mrYes) then
          Break
        else
          inc(m)
      end else
        inc(m)
    end;
    if m<theActiveForm.ComponentCount then
      Button.Click
    else
      theActiveForm.Close;
  end;
end;

procedure TMacrosManager.LoadLessonModel(const FileName:string);
begin
end;

end.
