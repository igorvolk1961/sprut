unit AddBoundaryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AddRefFrm, StdCtrls, ExtCtrls,
  SpatialModelLib_TLB, DataModel_TLB, DMServer_TLB, SgdbLib_TLB;

type
  TfmAddBoundary = class(TfmAddRef)
    btMoreLess: TButton;
    Panel2: TPanel;
    PanelWidth: TPanel;
    Label1: TLabel;
    edWidth: TEdit;
    Label3: TLabel;
    edBoundaryLayerType: TComboBox;
    PanelFlowIntencity: TPanel;
    Label2: TLabel;
    chbFlowIntencity: TComboBox;
    Panel4: TPanel;
    rgBuildDirection: TRadioGroup;
    Panel3: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    edOldWidth: TEdit;
    rgMode: TRadioGroup;
    edOldLength: TEdit;
    rgBuildWallsOnAllLevels: TRadioGroup;
    chbUseLayer: TCheckBox;
    edLayer: TComboBox;
    procedure btMoreLessClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edWidthChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edSubKindChange(Sender: TObject);
    procedure edKindChange(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject); override;
    procedure chbUseLayerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FFlag:boolean;
    Err1:integer;
    Err2:integer;
    FUseLayerChecked:boolean;
  protected
    procedure FillSubKinds; override;
  public
    { Public declarations }
  end;

var
  fmAddBoundary: TfmAddBoundary;

implementation

{$R *.dfm}

procedure TfmAddBoundary.btMoreLessClick(Sender: TObject);
var
  GlobalData:IGlobalData;
  H:integer;
begin
  FFlag:=not FFlag;
  if FFlag then begin
    btMoreLess.Caption:='Меньше';
    Panel2.Visible:=True;
    GlobalData:=DataModel as IGlobalData;
    H:=Panel1.Height+Panel2.Height+GetSystemMetrics(SM_CYCAPTION)+4;
    if GlobalData.GlobalValue[2]=1 then begin
      H:=H+Panel3.Height;
      Panel3.Visible:=True;
    end else
      Panel3.Visible:=False;
  end else begin
    btMoreLess.Caption:='Больше';
    Panel2.Visible:=False;
    Panel3.Visible:=False;
    H:=Panel1.Height+GetSystemMetrics(SM_CYCAPTION)+4;
  end;
  Height:=H;
end;

procedure TfmAddBoundary.FillSubKinds;
var
  m:integer;
  BoundaryKindE:IDMElement;
  BoundaryKind:IBoundaryKind;
  GlobalData:IGlobalData;
  IsVertical:boolean;
begin
  GlobalData:=DataModel as IGlobalData;
  if GlobalData.GlobalValue[1]=2 then begin
    inherited;
    Exit;
  end;
  IsVertical:=(GlobalData.GlobalValue[1]=0);
  for m:=0 to FSubKinds.Count-1 do begin
    BoundaryKindE:=FSubKinds.Item[m];
    BoundaryKind:=BoundaryKindE as IBoundaryKind;
    if (IsVertical and
       (BoundaryKind.Orientation=1)) or
       (not IsVertical and
       (BoundaryKind.Orientation=2))
       then
      edSubKind.Items.AddObject(BoundaryKindE.Name,
                      pointer(BoundaryKindE));
  end;
end;

procedure TfmAddBoundary.FormActivate(Sender: TObject);
var
  H, j:integer;
  GlobalData:IGlobalData;
begin
  GlobalData:=DataModel as IGlobalData;
  if Panel2.Visible then begin
    H:=Panel1.Height+Panel2.Height+GetSystemMetrics(SM_CYCAPTION)+4;
    if GlobalData.GlobalValue[2]=1 then
      H:=H+Panel3.Height
  end else
    H:=Panel1.Height+GetSystemMetrics(SM_CYCAPTION)+4;
  Height:=H;
end;

procedure TfmAddBoundary.edWidthChange(Sender: TObject);
var
  D:double;
begin
  Val(edWidth.Text, D, Err1);
  if Err1=0 then
    edWidth.Font.Color:=clBlack
  else
    edWidth.Font.Color:=clRed
end;

procedure TfmAddBoundary.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=((Err1=0) and (Err2=0)) or
            (ModalResult<>mrOK)
end;

procedure TfmAddBoundary.edSubKindChange(Sender: TObject);
var
  BoundaryKind:IBoundaryKind;
  BoundaryLayerTypeE, LayerE:IDMElement;
  j:integer;
  SpatialModel:ISpatialModel;
begin
  inherited;
  if FElementSubKind=nil then Exit;
  BoundaryKind:=FElementSubKind as IBoundaryKind;
  edBoundaryLayerType.Clear;
  for j:=0 to BoundaryKind.BoundaryLayerTypes.Count-1 do begin
    BoundaryLayerTypeE:=BoundaryKind.BoundaryLayerTypes.Item[j];
    edBoundaryLayerType.Items.AddObject(BoundaryLayerTypeE.Name, pointer(BoundaryLayerTypeE));
  end;
  edBoundaryLayerType.ItemIndex:=0;

  SpatialModel:=DataModel as ISpatialModel;
  edLayer.Clear;
  for j:=0 to SpatialModel.Layers.Count-1 do begin
    LayerE:=SpatialModel.Layers.Item[j];
    edLayer.Items.AddObject(LayerE.Name, pointer(LayerE));
  end;

  j:=0;
  while j<edLayer.Items.Count do begin
    LayerE:=IDMElement(pointer(edLayer.Items.Objects[j]));
    if LayerE.Ref=FElementSubKind then
      Break
    else
      inc(j)
  end;
  if j<edLayer.Items.Count then begin
    edLayer.ItemIndex:=j;
    chbUseLayer.Checked:=FUseLayerChecked;
  end else begin
    edLayer.ItemIndex:=-1;
    FUseLayerChecked:=chbUseLayer.Checked;
    chbUseLayer.Checked:=False;
  end;
end;

procedure TfmAddBoundary.edKindChange(Sender: TObject);
begin
  inherited;
  PanelFlowIntencity.Visible:=(edKind.ItemIndex=btEntryPoint)
end;

procedure TfmAddBoundary.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

procedure TfmAddBoundary.FormCreate(Sender: TObject);
begin
  inherited;
  FUseLayerChecked:=True;
end;

procedure TfmAddBoundary.chbUseLayerMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FUseLayerChecked:=chbUseLayer.Checked;
end;

end.
