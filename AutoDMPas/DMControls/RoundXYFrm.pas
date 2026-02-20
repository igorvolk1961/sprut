unit RoundXYFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmRoundXY = class(TForm)
    Label1: TLabel;
    edD: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure edDChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FErr:integer;
  public

  end;

var
  fmRoundXY: TfmRoundXY;

implementation

{$R *.dfm}

procedure TfmRoundXY.edDChange(Sender: TObject);
var
  D:double;
begin
  Val(edD.Text, D, FErr);
  if FErr=0 then
    edD.Font.Color:=clBlack
  else
    edD.Font.Color:=clRed
end;

procedure TfmRoundXY.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=(FErr=0)
end;

end.
