unit VolumeLinkFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmVolumeLink = class(TForm)
    rgLinkType: TRadioGroup;
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    chbVolumeIsOuter: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmVolumeLink: TfmVolumeLink;

implementation

{$R *.dfm}

end.
