unit DMBrowserOptions;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmDMBrowserOptions = class(TForm)
    chbHideEmptyCollections: TCheckBox;
    rgDetailMode: TRadioGroup;
    miOK: TButton;
    miCancel: TButton;
    miHelp: TButton;
  private
  public
  end;

var
  frmDMBrowserOptions:TfrmDMBrowserOptions;
  
implementation

{$R *.DFM}

end.
