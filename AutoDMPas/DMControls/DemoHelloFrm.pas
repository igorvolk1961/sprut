unit DemoHelloFrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmDemoHello = class(TForm)
    LTop: TLabel;
    LBottom: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Image3: TImage;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
  private
    { Private declarations }
  end;

var
  fmDemoHello: TfmDemoHello;

implementation

{$R *.DFM}

procedure TfmDemoHello.FormActivate(Sender: TObject);
begin
  Top:=0;
  Left:=0;
  Height:=Screen.Height;
  Width:=Screen.Width;
end;

procedure TfmDemoHello.Panel1Resize(Sender: TObject);
begin
  Image1.Width:=round(Image1.Height/288*472);
end;

end.
