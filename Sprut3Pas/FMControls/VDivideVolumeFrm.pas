unit VDivideVolumeFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmVDivideVolume = class(TForm)
    rgKind: TRadioGroup;
    PanelH: TPanel;
    Label1: TLabel;
    edH: TEdit;
    Label2: TLabel;
    PanelN: TPanel;
    Label3: TLabel;
    edN: TEdit;
    btOK: TButton;
    Button1: TButton;
    btHelp: TButton;
    procedure edHChange(Sender: TObject);
    procedure edNChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rgKindClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    FErr:integer;
    FValue:double;
    procedure SetValue(const Value: double);
  public
    property Value:double read FValue write SetValue;
  end;

var
  fmVDivideVolume: TfmVDivideVolume;

implementation

{$R *.dfm}

procedure TfmVDivideVolume.edHChange(Sender: TObject);
var
  S:string;
begin
  S:=edH.Text;
  Val(S, FValue, FErr);
  if  FErr=0 then begin
    edH.Font.Color:=clBlack
  end else
    edH.Font.Color:=clRed
end;

procedure TfmVDivideVolume.edNChange(Sender: TObject);
var
  S:string;
begin
  S:=edN.Text;
  Val(S, FValue, FErr);
  if  FErr=0 then begin
    if (round(FValue)=FValue) and
       (FValue<>0)then
      edN.Font.Color:=clBlack
    else
      edN.Font.Color:=clRed
  end else
    edN.Font.Color:=clRed
end;

procedure TfmVDivideVolume.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=(FErr=0) or (ModalResult<>mrOK)
end;

procedure TfmVDivideVolume.rgKindClick(Sender: TObject);
begin
  if rgKind.ItemIndex=0 then begin
    edN.Text:='2';
    edN.Enabled:=False;
    PanelH.Visible:=True;
    edHChange(edH);
  end else begin
    edN.Enabled:=True;
    PanelH.Visible:=False;
    edNChange(edN);
  end;

end;

procedure TfmVDivideVolume.SetValue(const Value: double);
begin
  edH.Text:=Format('%0.2f',[Value]);
end;

procedure TfmVDivideVolume.FormActivate(Sender: TObject);
begin
  rgKind.ItemIndex:=0;
  rgKindClick(rgKind);
end;

procedure TfmVDivideVolume.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
