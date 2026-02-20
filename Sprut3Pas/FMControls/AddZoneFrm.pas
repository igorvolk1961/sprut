unit AddZoneFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AddRefFrm, StdCtrls, ExtCtrls,
  DataModel_TLB, DMServer_TLB, SgdbLib_TLB,
  FacilityModelLib_TLB, SpatialModelLib_TLB;

const
  InfinitValue=1000000000;
  rsInfinit='Бесконечна';

type
  TfmAddZone = class(TfmAddRef)
    btMoreLess: TButton;
    Panel2: TPanel;
    rgBuildDirection: TRadioGroup;
    Label3: TLabel;
    Label4: TLabel;
    edPedestrialVelocity: TEdit;
    Label6: TLabel;
    edTransparencyDist: TEdit;
    chbPersonalPresence: TComboBox;
    Label7: TLabel;
    edPersonalCount: TEdit;
    Label1: TLabel;
    edHeight: TEdit;
    rgVehicleVelocity: TRadioGroup;
    Label10: TLabel;
    edBoundaryKind: TComboBox;
    PanelRoadCover: TPanel;
    Label8: TLabel;
    edRoadCover: TComboBox;
    PanelVehicleVelocity: TPanel;
    Label5: TLabel;
    edVehicleVelocity: TEdit;
    Label2: TLabel;
    edCategory: TEdit;
    chbBuildJoinedVolume: TCheckBox;
    procedure btMoreLessClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edKindChange(Sender: TObject);
    procedure edSubKindChange(Sender: TObject);
    procedure rgVehicleVelocityClick(Sender: TObject);
    procedure edTransparencyDistChange(Sender: TObject);
    procedure edTransparencyDistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edTransparencyDistKeyPress(Sender: TObject; var Key: Char);
    procedure btHelpClick(Sender: TObject);
  private
    FFlag:boolean;
    FErr:integer;
    FTransparencyDist: double;
  protected
  public
    property TransparencyDist:double read FTransparencyDist;
  end;

var
  fmAddZone: TfmAddZone;

implementation

{$R *.dfm}

procedure TfmAddZone.btMoreLessClick(Sender: TObject);
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

procedure TfmAddZone.FormActivate(Sender: TObject);
begin
  if Panel2.Visible then
    Height:=Panel1.Height+Panel2.Height+GetSystemMetrics(SM_CYCAPTION)+4
  else
    Height:=Panel1.Height+GetSystemMetrics(SM_CYCAPTION)+4;
end;

procedure TfmAddZone.EditChange(Sender: TObject);
var
  D:double;
  Err:integer;
  Edit:TEdit;
begin
  Edit:=Sender as TEdit;
  Val(Edit.Text, D, Err);
  if Err=0 then begin
    Edit.Font.Color:=clBlack;
    FErr:=FErr and not Edit.Tag;
  end else begin
    Edit.Font.Color:=clRed;
    FErr:=FErr or Edit.Tag;
  end;
end;

procedure TfmAddZone.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=(FErr=0) or (ModalResult<>mrOK)
end;

procedure TfmAddZone.edKindChange(Sender: TObject);
var
  j:integer;
  DataModelE:IDMElement;
  FacilityModel:IFacilityModel;
  SpatialModel2:ISpatialModel2;
begin
  inherited;

  DataModelE:=GetDataModel as IDMElement;
  FacilityModel:=DataModelE as IFacilityModel;
  SpatialModel2:=DataModelE as ISpatialModel2;

  j:=edKind.ItemIndex;
  case j of
  0: begin
       edHeight.Text:=Format('%0.2f',[FacilityModel.DefaultOpenZoneHeight]);
     end;
  1: begin
       edHeight.Text:=Format('%0.2f',[SpatialModel2.DefaultVolumeHeight]);
     end;
  end;
end;

procedure TfmAddZone.edSubKindChange(Sender: TObject);
var
  j:integer;
  ZoneKindE, BoundaryKindE, aBoundaryKindE, BoundaryTypeE,
  DataModelE, SafeguardDatabaseE:IDMElement;
  ZoneKind:IZoneKind;
  BoundaryTypes, BoundaryKinds:IDMCollection;
  aBoundaryKind:IBoundaryKind;
begin
  inherited;
  j:=edSubKind.ItemIndex;
  ZoneKindE:=IDMELement(pointer(edSubKind.Items.Objects[j]));
  ZoneKind:=ZoneKindE as IZoneKind;

  edBoundaryKind.Clear;
  BoundaryKindE:=ZoneKind.DefaultSideBoundaryKind;
  edBoundaryKind.AddItem(BoundaryKindE.Name,
                         pointer(BoundaryKindE));

  if edKind.ItemIndex=0 then begin
    DataModelE:=GetDataModel as IDMElement;
    SafeguardDatabaseE:=DataModelE.Ref;
    BoundaryTypes:=SafeguardDatabaseE.Collection[_BoundaryType];
    BoundaryTypeE:=BoundaryTypes.Item[btVirtual];
    BoundaryKinds:=BoundaryTypeE.Collection[0];
    for j:=0 to BoundaryKinds.Count-1 do begin
      aBoundaryKindE:=BoundaryKinds.Item[j];
      aBoundaryKind:=aBoundaryKindE as IBoundaryKind;
      if (aBoundaryKind.Orientation=1) and
         (aBoundaryKindE<>BoundaryKindE) then
        edBoundaryKind.AddItem(aBoundaryKindE.Name,
                                     pointer(aBoundaryKindE));
    end;
  end;  

  edBoundaryKind.ItemIndex:=0;

  edCategory.Text:=IntToStr(ZoneKind.DefaultCategory);
  chbPersonalPresence.ItemIndex:=0;
  if ZoneKind.DefaultTransparencyDist<>InfinitValue then
    edTransparencyDist.Text:=Format('%0.0f',[ZoneKind.DefaultTransparencyDist])
  else
    edTransparencyDist.Text:=rsInfinit;
  edPedestrialVelocity.Text:=Format('%0.2f',[ZoneKind.PedestrialMovementVelocity]);
  edRoadCover.ItemIndex:=ZoneKind.RoadCover;
  rgVehicleVelocity.ItemIndex:=0;
  rgVehicleVelocity.OnClick(rgVehicleVelocity);
end;

procedure TfmAddZone.rgVehicleVelocityClick(Sender: TObject);
var
  j:integer;
begin
  j:=rgVehicleVelocity.ItemIndex;
  if j=0 then begin
    PanelVehicleVelocity.Visible:=False;
//    PanelRoadCover.Visible:=True;
  end else begin
    PanelVehicleVelocity.Visible:=True;
//    PanelRoadCover.Visible:=False;
  end;
end;

procedure TfmAddZone.edTransparencyDistChange(Sender: TObject);
var
  Err:integer;
  Edit:TEdit;
  D:double;
begin
  Edit:=Sender as TEdit;
  if Edit.Text=rsInfinit then begin
    FTransparencyDist:=InfinitValue;
    Edit.Font.Color:=clBlack;
    FErr:=FErr and not Edit.Tag;
    Exit
  end;
  Val(Edit.Text, D, Err);
  if Err=0 then begin
    Edit.Font.Color:=clBlack;
    FErr:=FErr and not Edit.Tag;
    FTransparencyDist:=D;
  end else begin
    Edit.Font.Color:=clRed;
    FErr:=FErr or Edit.Tag;
  end;
end;

procedure TfmAddZone.edTransparencyDistKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case char(Key) of
  '0'..'9','.':
    if edTransparencyDist.Text=rsInfinit then
      edTransparencyDist.Text:='';
  else
    begin
      Key:=0;
      FTransparencyDist:=InfinitValue
    end;
  end;
end;

procedure TfmAddZone.edTransparencyDistKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Key of
  '0'..'9','.':
    if edTransparencyDist.Text=rsInfinit then
      edTransparencyDist.Text:='';
  else
    begin
      Key:=#0;
      edTransparencyDist.Text:=rsInfinit;
    end;
  end;
end;

procedure TfmAddZone.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
