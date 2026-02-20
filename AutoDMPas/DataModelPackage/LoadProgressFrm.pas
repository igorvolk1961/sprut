unit LoadProgressFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  DMServer_TLB;

type
  TfmLoadProgress = class(TForm)
    Panel3: TPanel;
    Panel4: TPanel;
    ProgressBar: TProgressBar;
    LStageName: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel2: TPanel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    Server:IDataModelServer;
  end;

procedure NextLoadStage(const Caption, StageName:WideString; Stage, StepCount:integer);
  
var
  fmLoadProgress: TfmLoadProgress;

implementation

{$R *.dfm}

procedure TfmLoadProgress.FormActivate(Sender: TObject);
var
  j, W, H, L, T, MaxW, MaxH, MinL, MinT:integer;
begin
  MaxW:=Width;
  MaxH:=Height;
  MinL:=9999;
  MinT:=9999;
  for j:=0 to ControlCount-1 do begin
    W:=Controls[j].Width+Controls[j].Left+10;
    H:=Controls[j].Height+Controls[j].Top;
    L:=Controls[j].Left;
    T:=Controls[j].Top;
    if MaxW<W then
      MaxW:=W;
    if MaxH<H then
      MaxH:=H;
    if MinL>L then
      MinL:=L;
    if MinT>T then
      MinT:=T;
  end;
  Width:=MaxW-MinL+10;
  Height:=MaxH-MinT+10;
end;

procedure NextLoadStage(const Caption, StageName:WideString; Stage, StepCount:integer);
begin
  if Stage=-1 then begin
    fmLoadProgress.Close;
    fmLoadProgress.Free;
    fmLoadProgress:=nil;
    Exit;
  end;

  if fmLoadProgress=nil then begin
    fmLoadProgress:=TfmLoadProgress.Create(nil);
    fmLoadProgress.Caption:=Caption;
    fmLoadProgress.Show;
  end;

  fmLoadProgress.LStageName.Caption:=StageName;
  fmLoadProgress.ProgressBar.Max:=StepCount;
  fmLoadProgress.ProgressBar.Position:=0;
  fmLoadProgress.Invalidate;

  Application.ProcessMessages;
end;

end.
