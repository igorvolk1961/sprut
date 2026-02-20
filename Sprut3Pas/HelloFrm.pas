unit HelloFrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, CustomHelloFrm;

type
  TfmHello = class(TfmCustomHello)
  private
    { Private declarations }
  end;

var
  fmHello: TfmHello;

implementation

{$R *.DFM}

end.
