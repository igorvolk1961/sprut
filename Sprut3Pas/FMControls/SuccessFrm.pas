unit SuccessFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmSuccess = class(TForm)
    Label1: TLabel;
    LBoundary: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LCount: TLabel;
    Label3: TLabel;
    LElement: TLabel;
    LSuccess: TLabel;
    LSuccessLabel: TLabel;
    btOK: TButton;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSuccess: TfmSuccess;

implementation
uses
  MyForms;

{$R *.dfm}

procedure TfmSuccess.btOKClick(Sender: TObject);
begin
  Close
end;

procedure TfmSuccess.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

end.
