unit DZFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmDZ = class(TForm)
    edDZ: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure edDZChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FErr:integer;
    FIncrementZ:double;
    procedure SetIncrementZ(const Value: double);
  public
    property IncrementZ:double read FIncrementZ write SetIncrementZ;
  end;

var
  fmDZ: TfmDZ;

implementation
uses
  MyForms;

{$R *.dfm}

{ TfmDZ }

procedure TfmDZ.SetIncrementZ(const Value: double);
begin
  FIncrementZ := Value;
end;

procedure TfmDZ.edDZChange(Sender: TObject);
var
  S:string;
  D:double;
begin
  S:=edDZ.Text;
  Val(S, D, FErr);
  if FErr=0 then begin
    edDZ.Font.Color:=clBlack;
    FIncrementZ:=D;
  end else
    edDZ.Font.Color:=clRed
end;

procedure TfmDZ.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

procedure TfmDZ.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=(FErr=0) or (ModalResult<>mrOK)
end;

end.
