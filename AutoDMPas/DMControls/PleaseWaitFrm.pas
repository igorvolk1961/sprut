unit PleaseWaitFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmPleaseWait = class(TForm)
    Label1: TLabel;
    Bevel1: TBevel;
    LPrompt: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPleaseWait: TfmPleaseWait;

implementation

{$R *.dfm}

end.
