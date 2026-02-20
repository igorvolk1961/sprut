unit IDInputFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TfrmIdInput = class(TForm)
    Label1: TLabel;
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    edID: TEdit;
    procedure edIDChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FErr:integer;
  public
    { Public declarations }
  end;

var
  frmIdInput: TfrmIdInput;

implementation

{$R *.dfm}

procedure TfrmIdInput.edIDChange(Sender: TObject);
var
  S:string;
  D:Double;
begin
  S:=edID.Text;
  Val(S, D, FErr);
  if  FErr=0 then begin
    if round(D)=D then
      edID.Font.Color:=clBlack
    else
      edID.Font.Color:=clRed
  end else
    edID.Font.Color:=clRed
end;

procedure TfrmIdInput.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=(FErr=0) or (ModalResult<>mrOK)
end;

end.
