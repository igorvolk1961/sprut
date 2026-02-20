unit AddBoundaryLayerFrm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DataModel_TLB, DMServer_TLB, ExtCtrls, DMEditor_TLB,
  AddRefFrm, SgdbLib_TLB;

type
  TfmAddBoundaryLayer = class(TfmAddRef)
    Label1: TLabel;
    edDistance: TEdit;
    pHeight: TPanel;
    Label2: TLabel;
    edHeight: TEdit;
    btMoreLess: TButton;
    Panel2: TPanel;
    chbDrawJoint: TCheckBox;
    procedure edKindChange(Sender: TObject);
    procedure edDistanceChange(Sender: TObject);
    procedure edHeightChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btMoreLessClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    Err1:integer;
    Err2:integer;
    FFlag:boolean;
  protected
  public
  end;

var
  fmAddBoundaryLayer: TfmAddBoundaryLayer;

implementation
{$R *.DFM}

procedure TfmAddBoundaryLayer.edKindChange(Sender: TObject);
var
  BoundaryLayerType:IBoundaryLayerType;
  H:double;
begin
  inherited;
  BoundaryLayerType:=FElementKind as IBoundaryLayerType;
  H:=BoundaryLayerType.DefaultHeight;
  edHeight.Text:=Format('%0.2f',[H]);
  pHeight.Visible:=(H>0);
  edDistance.Text:='1';
end;

procedure TfmAddBoundaryLayer.edDistanceChange(Sender: TObject);
var
  D:double;
begin
  Val(edDistance.Text, D, Err1);
  if Err1=0 then
    edDistance.Font.Color:=clBlack
  else
    edDistance.Font.Color:=clRed
end;

procedure TfmAddBoundaryLayer.edHeightChange(Sender: TObject);
var
  D:double;
begin
  Val(edHeight.Text, D, Err2);
  if Err2=0 then
    edHeight.Font.Color:=clBlack
  else
    edHeight.Font.Color:=clRed
end;

procedure TfmAddBoundaryLayer.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:=((Err1=0) and (Err2=0)) or
            (ModalResult<>mrOK)
end;

procedure TfmAddBoundaryLayer.btMoreLessClick(Sender: TObject);
begin
  FFlag:=not FFlag;
  if FFlag then begin
    btMoreLess.Caption:='Меньше';
    Panel2.Visible:=True;
    Height:=Panel1.Height+Panel2.Height+GetSystemMetrics(SM_CYCAPTION)+4;
  end else begin
    btMoreLess.Caption:='Больше';
    Panel2.Visible:=False;
    Height:=Panel1.Height+GetSystemMetrics(SM_CYCAPTION)+4;
  end;
end;

procedure TfmAddBoundaryLayer.FormActivate(Sender: TObject);
begin
  inherited;
  chbDrawJoint.Checked:=False;
end;

procedure TfmAddBoundaryLayer.btHelpClick(Sender: TObject);
begin
//  inherited;
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
