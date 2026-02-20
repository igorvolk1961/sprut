unit MacrosPositionFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TfmMacrosPosition = class(TForm)
    Button1: TButton;
    edStartPos: TSpinEdit;
    Label1: TLabel;
    fmMacrosPosition: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMacrosPosition: TfmMacrosPosition;

implementation

{$R *.dfm}

end.
