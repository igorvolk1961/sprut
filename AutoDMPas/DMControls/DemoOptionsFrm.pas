unit DemoOptionsFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfmDemoOptions = class(TForm)
    chbSpeech: TCheckBox;
    chbShowText: TCheckBox;
    Label1: TLabel;
    trCursorSpeed: TTrackBar;
    Label2: TLabel;
    trPauseInterval: TTrackBar;
    btOK: TButton;
    btCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDemoOptions: TfmDemoOptions;

implementation

{$R *.dfm}

end.
