unit ConfirmationFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmConfirmation = class(TForm)
    LText: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    function GetText: string;
    procedure SetText(const Value: string);
    { Private declarations }
  public
    property Text:string read GetText write SetText;
  end;

var
  fmConfirmation: TfmConfirmation;

implementation

{$R *.dfm}

{ TfmConfirmation }

function TfmConfirmation.GetText: string;
begin
  Result:=LText.Caption
end;

procedure TfmConfirmation.SetText(const Value: string);
begin
  LText.Caption:=Value
end;

end.
