unit DeleteConfFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmDeleteConfirm = class(TForm)
    LConfirm: TLabel;
    btYes: TButton;
    btYesToAll: TButton;
    btSkip: TButton;
    btCancel: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDeleteConfirm: TfmDeleteConfirm;

implementation

{$R *.dfm}

procedure TfmDeleteConfirm.FormShow(Sender: TObject);
begin
  btYes.SetFocus
end;

end.
