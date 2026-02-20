unit CustomHelloFrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmCustomHello = class(TForm)
    LTop: TLabel;
    LBottom: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Image4: TImage;
    Timer1: TTimer;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  end;

var
  fmCustomHello: TfmCustomHello;

implementation

{$R *.DFM}

procedure TfmCustomHello.FormActivate(Sender: TObject);
begin
  Top:=0;
  Left:=0;
  Height:=Screen.Height;
  Width:=Screen.Width;
end;

procedure TfmCustomHello.Panel1Resize(Sender: TObject);
begin
  if Panel1.Width>Panel1.Height/160*270 then begin
    Image1.Height:=Panel1.Height;
    Image1.Width:=round(Image1.Height/160*270);
    Image1.Top:=0;
    Image1.Left:=Panel1.Width-Image1.Width;
  end else begin
    Image1.Width:=Panel1.Width;
    Image1.Height:=round(Image1.Width/240*170);
    Image1.Top:=0;
    Image1.Left:=0;
  end;
end;

procedure TfmCustomHello.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  Close
end;

procedure TfmCustomHello.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Exit
end;

procedure TfmCustomHello.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Exit
end;

end.
