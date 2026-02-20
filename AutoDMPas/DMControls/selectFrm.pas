unit SelectFrm;

interface

uses
  DM_Windows,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmSelect = class(TForm)
    cbElement: TComboBox;
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    lElement: TLabel;
    procedure cbElementKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSelect: TfmSelect;

implementation
uses
  MyForms;
  
{$R *.dfm}

procedure TfmSelect.cbElementKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_SPACE then begin
     cbElement.ItemIndex:=-1;
     cbElement.Text:='';
     Key:=0;
   end;
end;

procedure TfmSelect.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

procedure TfmSelect.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
