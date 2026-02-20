unit LoadModulFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TfmLoadModul = class(TForm)
    Panel3: TPanel;
    Panel4: TPanel;
    LStageName: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel2: TPanel;
    procedure FormActivate(Sender: TObject);
  private
  public
    procedure NextModul(const ModulName: WideString);
  end;

var
  fmLoadModul: TfmLoadModul;

implementation

{$R *.dfm}

procedure TfmLoadModul.FormActivate(Sender: TObject);
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

procedure TfmLoadModul.NextModul(const ModulName:WideString);
begin
  LStageName.Caption:='Загружается модуль'+#13+'"'+ModulName+'"';
  Invalidate;
  Application.ProcessMessages;
end;

end.
