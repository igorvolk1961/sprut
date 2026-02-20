unit StairBuilderFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmStairBuilder = class(TForm)
    rgStairClockwise: TRadioGroup;
    edStairWidth: TEdit;
    Label3: TLabel;
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    procedure edStairWidthChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btHelpClick(Sender: TObject);
  private
    ErrorFlag1:boolean;
    ErrorFlag2:boolean;
  public
    { Public declarations }
  end;

var
  fmStairBuilder: TfmStairBuilder;

implementation

{$R *.dfm}

procedure TfmStairBuilder.edStairWidthChange(Sender: TObject);
var
  D:double;
  Err:integer;
begin
  Val(edStairWidth.Text, D, Err);
  ErrorFlag1:=(Err<>0);
  if ErrorFlag1 then
    edStairWidth.Font.Color:=clRed
  else
    edStairWidth.Font.Color:=clBlack;
  btOK.Enabled:=not ErrorFlag1 and not ErrorFlag2
end;

procedure TfmStairBuilder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=not ErrorFlag1 and not ErrorFlag2 or
            (ModalResult<>mrOK)
end;

procedure TfmStairBuilder.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
