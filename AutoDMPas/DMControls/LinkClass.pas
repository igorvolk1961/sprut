unit LinkClass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmLinkClass = class(TForm)
    rgClass: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLinkClass: TfmLinkClass;

implementation

{$R *.dfm}

end.
