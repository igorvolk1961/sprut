unit AnalysisProgressFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  DMServer_TLB;

type
  TfmAnalysisProgress = class(TForm)
    Panel1: TPanel;
    btStop: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ProgressBar: TProgressBar;
    LStageName: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    procedure btStopClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    Server:IDataModelServer;
  end;

var
  fmAnalysisProgress: TfmAnalysisProgress;

implementation

{$R *.dfm}

procedure TfmAnalysisProgress.btStopClick(Sender: TObject);
begin
  Server.StopAnalysis;
  Close;
end;

procedure TfmAnalysisProgress.FormActivate(Sender: TObject);
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

end.
