unit DrawPrintOptionsFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmDrawPrintOptions = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    rgCanvasTag: TRadioGroup;
    procedure FormShow(Sender: TObject);
  private
    function GetCanvasTag: integer;
  public
    property CanvasTag:integer read GetCanvasTag;
  end;

var
  frmDrawPrintOptions: TfrmDrawPrintOptions;

implementation
uses
  MyForms;

{$R *.dfm}

{ TfmDrawPrintOptions }

function TfrmDrawPrintOptions.GetCanvasTag: integer;
begin
  Result := rgCanvasTag.ItemIndex;
end;

procedure TfrmDrawPrintOptions.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

end.
