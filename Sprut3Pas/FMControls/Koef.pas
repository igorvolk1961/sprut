unit Koef;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TKoefFrm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edD: TEdit;
    edTZSR: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OK: TButton;
    Cancel: TButton;
    Bevel1: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    edCurrencyRate: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edPNR: TEdit;
    Label17: TLabel;
    procedure OKClick(Sender: TObject);
    procedure edDKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    KD,KTZSR, KPNR:double;
  end;

var
  KoefFrm: TKoefFrm;

implementation

{$R *.dfm}

procedure TKoefFrm.OKClick(Sender: TObject);
begin
  KD:=StrToFloat(edD.Text);
  KTZSR:=StrToFloat(edTZSR.Text);
  KPNR:=StrToFloat(edPNR.Text);
end;

procedure TKoefFrm.edDKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9',#8: ;
    #13:KoefFrm.OK.SetFocus;
    '.',',':
      begin
        if Key='.' then Key:=',';
        if Pos(',',(Sender as TEdit).Text)<>0 then Key:=Chr(0);
      end
  else
    Key:=Chr(0);
  end;
end;


end.
