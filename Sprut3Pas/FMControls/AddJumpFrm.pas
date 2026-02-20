unit AddJumpFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AddRefFrm, StdCtrls, ExtCtrls,
  DataModel_TLB, DMServer_TLB, SgdbLib_TLB;

type
  TfmAddJump = class(TfmAddRef)
    btMoreLess: TButton;
    Panel2: TPanel;
    PanelWidth: TPanel;
    Label1: TLabel;
    edWidth: TEdit;
    Label3: TLabel;
    edBoundaryLayerType: TComboBox;
    procedure btMoreLessClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edWidthChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edSubKindChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    FFlag:boolean;
    Err1:integer;
    Err2:integer;
  protected
    procedure FillSubKinds; override;
  public
    { Public declarations }
  end;

var
  fmAddJump: TfmAddJump;

implementation

{$R *.dfm}

procedure TfmAddJump.btMoreLessClick(Sender: TObject);
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

procedure TfmAddJump.FillSubKinds;
var
  m:integer;
  BoundaryKindE:IDMElement;
  BoundaryKind:IBoundaryKind;
  GlobalData:IGlobalData;
  IsVertical:boolean;
begin
  GlobalData:=DataModel as IGlobalData;
  for m:=0 to FSubKinds.Count-1 do begin
    BoundaryKindE:=FSubKinds.Item[m];
    BoundaryKind:=BoundaryKindE as IBoundaryKind;
    edSubKind.Items.AddObject(BoundaryKindE.Name,
                      pointer(BoundaryKindE));
  end;
end;

procedure TfmAddJump.FormActivate(Sender: TObject);
begin
  if Panel2.Visible then
    Height:=Panel1.Height+Panel2.Height+GetSystemMetrics(SM_CYCAPTION)+4
  else
    Height:=Panel1.Height+GetSystemMetrics(SM_CYCAPTION)+4;
end;

procedure TfmAddJump.edWidthChange(Sender: TObject);
var
  D:double;
begin
  Val(edWidth.Text, D, Err1);
  if Err1=0 then
    edWidth.Font.Color:=clBlack
  else
    edWidth.Font.Color:=clRed
end;

procedure TfmAddJump.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=((Err1=0) and (Err2=0)) or
            (ModalResult<>mrOK)
end;

procedure TfmAddJump.edSubKindChange(Sender: TObject);
var
  BoundaryKind:IBoundaryKind;
  BoundaryLayerTypeE:IDMElement;
  j:integer;
begin
  inherited;
  BoundaryKind:=FElementSubKind as IBoundaryKind;
  edBoundaryLayerType.Clear;
  for j:=0 to BoundaryKind.BoundaryLayerTypes.Count-1 do begin
    BoundaryLayerTypeE:=BoundaryKind.BoundaryLayerTypes.Item[j];
    edBoundaryLayerType.Items.AddObject(BoundaryLayerTypeE.Name, pointer(BoundaryLayerTypeE));
  end;
  edBoundaryLayerType.ItemIndex:=0;
end;

procedure TfmAddJump.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
