unit IntegerInputFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TfmIntegerInput = class(TForm)
    LPrompt: TLabel;
    edValue: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    edText: TEdit;
    procedure FormShow(Sender: TObject);
    procedure edTextChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FValue: integer;
    FErr:integer;
    procedure SetValue(const aValue: integer);
    { Private declarations }
  public
    property Value:integer read FValue write SetValue;
  end;

var
  fmIntegerInput: TfmIntegerInput;

implementation
uses
  MyForms;

{$R *.dfm}

procedure TfmIntegerInput.SetValue(const aValue: integer);
begin
  FValue := aValue;
  edValue.Value:=aValue;
end;

procedure TfmIntegerInput.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

procedure TfmIntegerInput.edTextChange(Sender: TObject);
var
  S:string;
  D:Double;
begin
  S:=edText.Text;
  Val(S, D, FErr);
  if  FErr=0 then begin
    edText.Font.Color:=clBlack
  end else
    edText.Font.Color:=clRed
end;

procedure TfmIntegerInput.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=(FErr=0) or (ModalResult<>mrOK)
end;

end.
