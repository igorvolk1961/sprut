unit ExportFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmExport = class(TForm)
    Button1: TButton;
    Button2: TButton;
    btHelp: TButton;
    RadioGroup1: TRadioGroup;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExport: TfmExport;

implementation

uses
  MyForms;

{$R *.dfm}

procedure TfmExport.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmExport.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

procedure TfmExport.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
