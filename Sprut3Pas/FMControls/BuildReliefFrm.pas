unit BuildReliefFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmBuildRelief = class(TForm)
    rgDeleteVAreaDirection: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    btHelp: TButton;
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBuildRelief: TfmBuildRelief;

implementation

{$R *.dfm}

procedure TfmBuildRelief.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
