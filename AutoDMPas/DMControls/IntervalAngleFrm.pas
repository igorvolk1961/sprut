unit IntervalAngleFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmInputValue = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ed_Value: TEdit;
    btOk: TButton;
    btClose: TButton;
    procedure btOkClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure InputValueFrmCreate;
    procedure ed_ValueChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    ValueFlag: boolean;
    ValueOld: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmInputValue: TfmInputValue;

implementation

{$R *.dfm}
procedure TfmInputValue.InputValueFrmCreate;
begin
     ed_Value.Text:='1';
     ValueFlag := True;
end;
procedure TfmInputValue.btOkClick(Sender: TObject);
begin
  If not ValueFlag then Exit;
//   If  not ed_Value.Visible then
//     ed_Value.Text := '1';
  Close;
end;

procedure TfmInputValue.btCloseClick(Sender: TObject);
begin
   If  not ed_Value.Visible then
     ed_Value.Text := '-1';
   Close;
end;

procedure TfmInputValue.ed_ValueChange(Sender: TObject);
var
 C:integer;
 Z:double;
begin
  if not ed_Value.Modified then Exit;
  Val(ed_Value.Text,Z,C);
  if (C<>0) or (Z<>Z) then begin
      ed_Value.Font.Color:=clRed;
      ValueFlag := False;
      Exit;
   end else
      ed_Value.Font.Color:=clWindowText;
   ValueFlag := True;
end;

procedure TfmInputValue.FormActivate(Sender: TObject);
begin
   ValueOld := ed_Value.Text;
end;

end.
