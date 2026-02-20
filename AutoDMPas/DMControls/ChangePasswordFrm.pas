unit ChangePasswordFrm;

interface

uses
  DM_Windows,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TfmChangePassword = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edOldPassword: TEdit;
    edNewPassword: TEdit;
    edNewPassword1: TEdit;
    miOK: TButton;
    Button1: TButton;
    Timer1: TTimer;
    btLayout: TSpeedButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btLayoutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FEngilshLayout:boolean;
  public
    { Public declarations }
  end;

var
  fmChangePassword: TfmChangePassword;

implementation

{$R *.dfm}

procedure TfmChangePassword.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if edNewPassword.Text=edNewPassword1.Text then
    CanClose:=True
  else begin
    ShowMessage('Ошибка подтверждения пароля');
    CanClose:=False
  end;
end;

procedure TfmChangePassword.btLayoutClick(Sender: TObject);
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

procedure TfmChangePassword.FormShow(Sender: TObject);
var
  LayoutName:array [0..255] of char;
begin
  DM_GetKeyboardLayoutName(LayoutName);
  FEngilshLayout:=(LayoutName='00000409');
  if FEngilshLayout then
    btLayout.Caption:='En'
  else
    btLayout.Caption:='Ru';
  Timer1.Enabled:=True;
end;

procedure TfmChangePassword.Timer1Timer(Sender: TObject);
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

procedure TfmChangePassword.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled:=False;
end;

end.
