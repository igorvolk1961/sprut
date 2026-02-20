unit MainPasswordFrm;

interface

uses
  DM_Windows,
  Forms, SysUtils, Variants, Classes, ExtCtrls, StdCtrls,
  Controls, Buttons;

type
  TfmMainPassword = class(TForm)
    Label1: TLabel;
    edPassword: TEdit;
    btOK: TButton;
    btCancel: TButton;
    Timer1: TTimer;
    btLayout: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btLayoutClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FEngilshLayout:boolean;
  public
    { Public declarations }
  end;

var
  fmMainPassword: TfmMainPassword;

implementation

{$R *.dfm}

procedure TfmMainPassword.FormShow(Sender: TObject);
var
  LayoutName:array [0..255] of char;
begin
  edPassword.Text:='';
  edPassword.SetFocus;

  DM_GetKeyboardLayoutName(LayoutName);
  FEngilshLayout:=(LayoutName='00000409');
  if FEngilshLayout then
    btLayout.Caption:='En'
  else
    btLayout.Caption:='Ru';

  Timer1.Enabled:=True;
end;

procedure TfmMainPassword.btLayoutClick(Sender: TObject);
begin
  FEngilshLayout:=not FEngilshLayout;
  if FEngilshLayout then begin
    btLayout.Caption:='En';
    DM_LoadKeyboardLayout('00000409',
          KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end else begin
    btLayout.Caption:='Ru';
    DM_LoadKeyboardLayout('00000419',
          KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;
end;

procedure TfmMainPassword.Timer1Timer(Sender: TObject);
var
  LayoutName:array [0..255] of char;
begin
  DM_GetKeyboardLayoutName(LayoutName);
  FEngilshLayout:=(LayoutName='00000409');
  if FEngilshLayout then
    btLayout.Caption:='En'
  else
    btLayout.Caption:='Ru'
end;

procedure TfmMainPassword.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled:=False;
end;

end.
