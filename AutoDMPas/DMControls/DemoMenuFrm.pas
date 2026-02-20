unit DemoMenuFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ToolWin, ComCtrls, DMEditor_TLB,
  fcButton, fcShapeBtn, fcClearPanel, fcButtonGroup, fcImgBtn, fcLabel;

const
  dmrStartLesson=1;
  dmrStopDemo=2;

type

  PLessonRecord=^TLessonRecord;
  TLessonRecord=record
    ModelFileName:  ShortString;
    MacrosFileName:  ShortString;
    TransactionFileName:  ShortString;
  end;

  TfmDemoMenu = class(TForm)
    Panel2: TPanel;
    pBottom: TPanel;
    Memo1: TMemo;
    procedure FormResize(Sender: TObject);
    procedure btLessonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    lTitle:TfcLabel;
    lSubTitle:TfcLabel;

    bgLessons:TfcButtonGroup;
    btStart:TfcShapeBtn;
    btExit:TfcShapeBtn;
    btOptions:TfcShapeBtn;
    btHelp:TfcShapeBtn;

    FLessonList:TStringList;
    FCurrentLessonIndex: integer;
    FMacrosManager:pointer;
    function GetMacrosManager: IDMMacrosManager;
    procedure SetMacrosManager(const Value: IDMMacrosManager);
    procedure btOptionsClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  public
    property MacrosManager:IDMMacrosManager read GetMacrosManager write SetMacrosManager ;
    property CurrentLessonIndex:integer read FCurrentLessonIndex;
    procedure LoadLessons(const FileName:string;
                          const LessonRecordList:TList);
  end;

var
  fmDemoMenu: TfmDemoMenu;

implementation

uses DemoOptionsFrm;

{$R *.dfm}

procedure TfmDemoMenu.FormCreate(Sender: TObject);
begin
  FLessonList:=TStringList.Create;


  lSubTitle:=TfcLabel.Create(Self);
  lSubTitle.Align:=alTop;
  lSubTitle.Parent:=Self;
  lSubTitle.Font.Name:='Arial';
  lSubTitle.Font.Charset:=204;
  lSubTitle.Font.Style:=[fsBold, fsItalic];
  lSubTitle.Font.Size:=18;
  lSubTitle.AutoSize:=False;
  lSubTitle.Height:=50;
  lSubTitle.TextOptions.Alignment:=taCenter;

  lTitle:=TfcLabel.Create(Self);
  lTitle.Align:=alTop;
  lTitle.Parent:=Self;
  lTitle.Font.Name:='Arial';
  lTitle.Font.Charset:=204;
  lTitle.Font.Style:=[fsBold, fsItalic];
  lTitle.Font.Size:=24;
  lTitle.AutoSize:=False;
  lTitle.Height:=145;
  lTitle.TextOptions.WordWrap:=True;
  lTitle.TextOptions.Alignment:=taCenter;

  bgLessons:=TfcButtonGroup.Create(Self);
  bgLessons.Align:=alClient;
  bgLessons.Parent:=Self;
  bgLessons.ButtonClassName:='TfcShapeBtn';
  bgLessons.ClickStyle:=bcsRadioGroup;

  btStart:=TfcShapeBtn.Create(Self);
  btStart.Parent:=pBottom;
  btStart.Shape:=bsRoundRect;
  btStart.Height:=25;
  btStart.Width:=128;
  btStart.Top:=10;
  btStart.Left:=10;
  btStart.Default:=True;
  btStart.ModalResult:=dmrStartLesson;
  btStart.Caption:='Начать урок';

  btExit:=TfcShapeBtn.Create(Self);
  btExit.Parent:=pBottom;
  btExit.Shape:=bsRoundRect;
  btExit.Height:=25;
  btExit.Width:=128;
  btExit.Top:=10;
  btExit.Left:=149;
  btExit.ModalResult:=dmrStopDemo;
  btExit.Caption:='Выход';

  btOptions:=TfcShapeBtn.Create(Self);
  btOptions.Parent:=pBottom;
  btOptions.Shape:=bsRoundRect;
  btOptions.Height:=25;
  btOptions.Width:=128;
  btOptions.Top:=10;
  btOptions.Left:=428;
  btOptions.Caption:='Параметры';
  btOptions.OnClick:=btOptionsClick;

  btHelp:=TfcShapeBtn.Create(Self);
  btHelp.Parent:=pBottom;
  btHelp.Shape:=bsRoundRect;
  btHelp.Height:=25;
  btHelp.Width:=128;
  btHelp.Top:=10;
  btHelp.Left:=568;
  btHelp.Caption:='Справка';
  btHelp.OnClick:=btHelpClick;
end;

procedure TfmDemoMenu.FormResize(Sender: TObject);
begin
  pBottom.Left:=(Panel2.Width-pBottom.Width) div 2;
end;

procedure TfmDemoMenu.btLessonClick(Sender: TObject);
begin
  FCurrentLessonIndex:=(Sender as TControl).Tag;
  Memo1.Text:=FLessonList[FCurrentLessonIndex];
end;

procedure TfmDemoMenu.FormDestroy(Sender: TObject);
begin
  FLessonList.Free;
end;

procedure TfmDemoMenu.LoadLessons(const FileName: string;
                          const LessonRecordList:TList);
var
  F:TextFile;
  S, S0, S1, S2, S3:string;
  Button, FirstButton:TfcShapeBtn;
  j:integer;
  Lesson:PLessonRecord;
begin
  while FLessonList.Count>0 do begin
    Button:=pointer(FLessonList.Objects[0]);
    FLessonList.Delete(0);
    Button.Parent:=nil;
    Button.Free;
  end;

  AssignFile(F, FileName);
  Reset(F);
  Readln(F, S);
  lTitle.Caption:=S;
  Readln(F, S);
  lSubTitle.Caption:=S;
  j:=0;
  FirstButton:=nil;
  while not EOF(F) do begin
    Readln(F, S);
    Readln(F, S0);
    Readln(F, S1);
    Readln(F, S2);
    Readln(F, S3);
    Button:=bgLessons.ButtonItems.Add.Button as TfcShapeBtn;
    if j=0 then
      FirstButton:=Button;
    Button.Tag:=j;
    Button.TextOptions.Alignment:=taLeftJustify;
    Button.Shape:=bsRoundRect;
    Button.Offsets.TextX:=10;
    Button.Caption:=S;
    Button.OnClick:=btLessonClick;
    GetMem(Lesson, SizeOf(TLessonRecord));
    Lesson^.ModelFileName:=S1;
    Lesson^.MacrosFileName:=S2;
    Lesson^.TransactionFileName:=S3;
    LessonRecordList.Add(Lesson);
    FLessonList.AddObject(S0, pointer(Button));
    inc(j);
  end;
  CloseFile(F);
  if FirstButton<>nil then begin
    FirstButton.Down:=True;
    FirstButton.Click;
  end;  
end;

function TfmDemoMenu.GetMacrosManager: IDMMacrosManager;
begin
  Result:=IDMMacrosManager(FMacrosManager)
end;

procedure TfmDemoMenu.SetMacrosManager(const Value: IDMMacrosManager);
begin
  FMacrosManager:=pointer(Value)
end;

procedure TfmDemoMenu.btOptionsClick(Sender: TObject);
begin
  if fmDemoOptions=nil then
    fmDemoOptions:=TfmDemoOptions.Create(Self);

  fmDemoOptions.chbSpeech.Checked:=MacrosManager.DemoSpeech;
  fmDemoOptions.chbShowText.Checked:=MacrosManager.DemoShowText;

  fmDemoOptions.trCursorSpeed.Position:=round(ln(MacrosManager.MacrosCursorSpeed)*10);
  fmDemoOptions.trPauseInterval.Position:=MacrosManager.MacrosPauseInterval;

  if fmDemoOptions.ShowModal<>mrOK then Exit;

  MacrosManager.DemoSpeech:=fmDemoOptions.chbSpeech.Checked;
  MacrosManager.DemoShowText:=fmDemoOptions.chbShowText.Checked;

 MacrosManager.MacrosCursorSpeed:=exp(fmDemoOptions.trCursorSpeed.Position/10);

 MacrosManager.MacrosPauseInterval:=fmDemoOptions.trPauseInterval.Position;
end;

procedure TfmDemoMenu.btHelpClick(Sender: TObject);
begin
end;

end.
