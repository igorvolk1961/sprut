unit DrawOptionsFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  DataModel_TLB, FacilityModelLib_TLB, SpatialModelLib_TLB;

type
  TfrmDrawOptions = class(TForm)
    cbShowOptimalPathFromStart: TCheckBox;
    cbShowOptimalPathFromBoundary: TCheckBox;
    cbShowFastPathFromBoundary: TCheckBox;
    cbShowStealthPathToBoundary: TCheckBox;
    cbShowFastGuardPathToBoundary: TCheckBox;
    cbShowText: TCheckBox;
    cbShowSymbols: TCheckBox;
    cbShowDetectionZones: TCheckBox;
    rgRenderAreas: TRadioGroup;
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    cbShowGraph: TCheckBox;
    cbBuildSectorLayer: TCheckBox;
    cbDrawOrdered: TCheckBox;
    procedure FormShow(Sender: TObject);
  private
    FFacilityModel: IUnknown;
    procedure SetFacilityModel(const Value: IUnknown);
    { Private declarations }
  public
    property FacilityModel:IUnknown read FFacilityModel write SetFacilityModel;
    procedure UpdateDrawOptions;
  end;

var
  frmDrawOptions: TfrmDrawOptions;

implementation
uses
  MyForms;

{$R *.dfm}

{ TfmDrawOptions }

procedure TfrmDrawOptions.SetFacilityModel(const Value: IUnknown);
var
  aFacilityModel:IVulnerabilityMap;
  aSpatialModel2:ISpatialModel2;
begin
  FFacilityModel := Value;
  aFacilityModel:=FFacilityModel as IVulnerabilityMap;
  if aFacilityModel=nil then Exit;
  aSpatialModel2:=FFacilityModel as ISpatialModel2;
  cbShowOptimalPathFromStart.Checked:=aFacilityModel.ShowOptimalPathFromStart;
  cbShowOptimalPathFromBoundary.Checked:=aFacilityModel.ShowOptimalPathFromBoundary;
  cbShowFastPathFromBoundary.Checked:=aFacilityModel.ShowFastPathFromBoundary;
  cbShowStealthPathToBoundary.Checked:=aFacilityModel.ShowStealthPathToBoundary;
  cbShowFastGuardPathToBoundary.Checked:=aFacilityModel.ShowFastGuardPathToBoundary;
  cbShowGraph.Checked:=aFacilityModel.ShowGraph;
  cbShowText.Checked:=aFacilityModel.ShowText;
  cbShowSymbols.Checked:=aFacilityModel.ShowSymbols;
  cbShowDetectionZones.Checked:=aFacilityModel.ShowDetectionZones;
  cbBuildSectorLayer.Checked:=((aFacilityModel as IFacilityModel).BuildSectorLayer as ILayer).Visible;
  rgRenderAreas.ItemIndex:=aSpatialModel2.RenderAreasMode;
  cbDrawOrdered.Checked:=aSpatialModel2.DrawOrdered;
end;

procedure TfrmDrawOptions.UpdateDrawOptions;
var
  aFacilityModel:IVulnerabilityMap;
  aSpatialModel2:ISpatialModel2;
begin
  aFacilityModel:=FFacilityModel as IVulnerabilityMap;
  if aFacilityModel=nil then Exit;
  aSpatialModel2:=FFacilityModel as ISpatialModel2;
  aFacilityModel.ShowOptimalPathFromStart:=cbShowOptimalPathFromStart.Checked;
  aFacilityModel.ShowOptimalPathFromBoundary:=cbShowOptimalPathFromBoundary.Checked;
  aFacilityModel.ShowFastPathFromBoundary:=cbShowFastPathFromBoundary.Checked;
  aFacilityModel.ShowStealthPathToBoundary:=cbShowStealthPathToBoundary.Checked;
  aFacilityModel.ShowFastGuardPathToBoundary:=cbShowFastGuardPathToBoundary.Checked;
  aFacilityModel.ShowGraph:=cbShowGraph.Checked;
  aFacilityModel.ShowText:=cbShowText.Checked;
  aFacilityModel.ShowSymbols:=cbShowSymbols.Checked;
  aFacilityModel.ShowDetectionZones:=cbShowDetectionZones.Checked;
  aSpatialModel2.RenderAreasMode:=rgRenderAreas.ItemIndex;
  ((aFacilityModel as IFacilityModel).BuildSectorLayer as ILayer).Visible:=cbBuildSectorLayer.Checked;
  ((aFacilityModel as IFacilityModel).BuildSectorLayer as ILayer).Selectable:=cbBuildSectorLayer.Checked;
  aSpatialModel2.DrawOrdered:=cbDrawOrdered.Checked;
end;

procedure TfrmDrawOptions.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

end.
