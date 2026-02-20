unit CurrentOptionsFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  DataModel_TLB, FacilityModelLib_TLB, ComCtrls;

type
  TfmCurrentOptions = class(TForm)
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbPathStage: TComboBox;
    cbTactic: TComboBox;
    cbFacilityState: TComboBox;
    cbGroupType: TComboBox;
    cbGroup: TComboBox;
    cbAnalysisVariant: TComboBox;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cbDefaultReactionMode: TComboBox;
    pCriticalFalseAlarmPeriod: TPanel;
    Label8: TLabel;
    edCriticalFalseAlarmPeriod: TEdit;
    cbUseBattleModel: TCheckBox;
    cbBuildAllVerticalWays: TCheckBox;
    cbFindCriticalPointsFlag: TCheckBox;
    Label9: TLabel;
    cbDontBreakWalls: TCheckBox;
    edDelayTimeDispersionRatio: TEdit;
    edResponceTimeDispersionRatio: TEdit;
    procedure cbPathStageChange(Sender: TObject);
    procedure cbGroupTypeChange(Sender: TObject);
    procedure cbAnalysisVariantChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFacilityModel: IUnknown;
    { Private declarations }
    procedure SetFacilityModel(const Value: IUnknown);
  public
    property FacilityModel:IUnknown read FFacilityModel write SetFacilityModel;
    procedure UpdateCurrentOptions;
  end;

var
  fmCurrentOptions: TfmCurrentOptions;

implementation
uses
  MyForms;

{$R *.dfm}

{ TfmCurrentOptions }

procedure TfmCurrentOptions.SetFacilityModel(const Value: IUnknown);
var
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  j:integer;
begin
  FFacilityModel := Value;
  aFacilityModel:=FFacilityModel as IFacilityModel;
  if aFacilityModel=nil then Exit;
  FacilityModelS:=aFacilityModel as IFMState;

  cbAnalysisVariant.Clear;
  for j:=0 to aFacilityModel.AnalysisVariants.Count-1 do
    cbAnalysisVariant.Items.AddObject(aFacilityModel.AnalysisVariants.Item[j].Name+
            Format(', Tð=%0.0f ñ', [(aFacilityModel.AnalysisVariants.Item[j] as IAnalysisVariant).ResponceTime]),
                            pointer(aFacilityModel.AnalysisVariants.Item[j]));
  cbAnalysisVariant.ItemIndex:=aFacilityModel.AnalysisVariants.IndexOf(FacilityModelS.CurrentAnalysisVariantU as IDMElement);

  cbFacilityState.Clear;
  for j:=0 to aFacilityModel.FacilityStates.Count-1 do
    cbFacilityState.Items.AddObject(aFacilityModel.FacilityStates.Item[j].Name,
                            pointer(aFacilityModel.FacilityStates.Item[j]));
//  cbFacilityState.ItemIndex:=aFacilityModel.FacilityStates.IndexOf(FacilityModelS.CurrentFacilityStateU as IDMElement);
//  cbGroupTypeChange(cbGroupType);

  cbAnalysisVariantChange(cbAnalysisVariant);

  cbPathStage.ItemIndex:=FacilityModels.CurrentPathStage;

  cbPathStageChange(cbPathStage);

  edDelayTimeDispersionRatio.Text:=Format('%0.2f',    [aFacilityModel.DelayTimeDispersionRatio]);
  edResponceTimeDispersionRatio.Text:=Format('%0.2f', [aFacilityModel.ResponceTimeDispersionRatio]);

  cbDefaultReactionMode.ItemIndex:=aFacilityModel.DefaultReactionMode;
  edCriticalFalseAlarmPeriod.Text:=Format('%0.1f',
    [aFacilityModel.CriticalFalseAlarmPeriod]);

  cbUseBattleModel.Checked:=aFacilityModel.UseBattleModel;
  cbFindCriticalPointsFlag.Checked:=aFacilityModel.FindCriticalPointsFlag;
  cbBuildAllVerticalWays.Checked:=aFacilityModel.BuildAllVerticalWays;
end;

procedure TfmCurrentOptions.UpdateCurrentOptions;
var
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  j, E:integer;
  D:double;
begin
  aFacilityModel:=FFacilityModel as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  if aFacilityModel=nil then Exit;

  j:=cbAnalysisVariant.ItemIndex;
  if j<>-1 then
    FacilityModelS.CurrentAnalysisVariantU:=IDMElement(pointer(cbAnalysisVariant.Items.Objects[j])) as IAnalysisVariant;

  j:=cbFacilityState.ItemIndex;
  if j<>-1 then
    FacilityModelS.CurrentFacilityStateU:=IDMElement(pointer(cbFacilityState.Items.Objects[j]));

  j:=cbGroup.ItemIndex;
  if j<>-1 then
    FacilityModelS.CurrentWarriorGroupU:=IDMElement(pointer(cbGroup.Items.Objects[j]));

  FacilityModelS.CurrentPathStage:=cbPathStage.ItemIndex;
  j:=cbTactic.ItemIndex;
  if j<>-1 then
    aFacilityModel.CurrentTactic:=IDMElement(pointer(cbTactic.Items.Objects[j]));

  Val(edDelayTimeDispersionRatio.Text, D, E);
  if (E=0) and
     (D>=0) and (D<=1) then
    aFacilityModel.DelayTimeDispersionRatio:=D;

  Val(edResponceTimeDispersionRatio.Text, D, E);
  if (E=0) and
     (D>=0) and (D<=1) then
    aFacilityModel.ResponceTimeDispersionRatio:=D;

  aFacilityModel.DefaultReactionMode:=cbDefaultReactionMode.ItemIndex;
  Val(edCriticalFalseAlarmPeriod.Text, D, E);
  if E=0 then
    aFacilityModel.CriticalFalseAlarmPeriod:=D;

  aFacilityModel.UseBattleModel:=cbUseBattleModel.Checked;
  aFacilityModel.FindCriticalPointsFlag:=cbFindCriticalPointsFlag.Checked;
  aFacilityModel.BuildAllVerticalWays:=cbBuildAllVerticalWays.Checked;
end;

procedure TfmCurrentOptions.cbPathStageChange(Sender: TObject);
var
  j:integer;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  TacticE:IDMElement;
begin
  aFacilityModel:=FFacilityModel as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  if aFacilityModel=nil then Exit;

  FacilityModelS.CurrentPathStage:=cbPathStage.ItemIndex;
  cbTactic.Clear;
  for j:=0 to aFacilityModel.CurrentZoneTactics.Count-1 do begin
    TacticE:=aFacilityModel.CurrentZoneTactics.Item[j];
    cbTactic.Items.AddObject(TacticE.Name, pointer(TacticE))
  end;
  for j:=0 to aFacilityModel.CurrentBoundaryTactics.Count-1 do begin
    TacticE:=aFacilityModel.CurrentBoundaryTactics.Item[j];
    cbTactic.Items.AddObject(TacticE.Name, pointer(TacticE))
  end;
  cbTactic.ItemIndex:=cbTactic.Items.IndexOfObject(pointer(aFacilityModel.CurrentTactic));
  if cbTactic.ItemIndex=-1 then
    cbTactic.ItemIndex:=0;
end;

procedure TfmCurrentOptions.cbGroupTypeChange(Sender: TObject);
var
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  j:integer;
  AnalysisVariant:IAnalysisVariant;
  AdversaryVariant:IAdversaryVariant;
begin
  aFacilityModel:=FFacilityModel as IFacilityModel;
  if aFacilityModel=nil then Exit;
  FacilityModelS:=aFacilityModel as IFMState;;

  cbGroup.Clear;
  case cbGroupType.ItemIndex of
  0:begin
      j:=cbAnalysisVariant.ItemIndex;
      AnalysisVariant:=aFacilityModel.AnalysisVariants.Item[j] as IAnalysisVariant;
      AdversaryVariant:=AnalysisVariant.AdversaryVariant as IAdversaryVariant;

      for j:=0 to AdversaryVariant.AdversaryGroups.Count-1 do
        cbGroup.Items.AddObject(AdversaryVariant.AdversaryGroups.Item[j].Name,
                        pointer(AdversaryVariant.AdversaryGroups.Item[j]));
        cbGroup.ItemIndex:=aFacilityModel.AdversaryGroups.IndexOf(FacilityModelS.CurrentWarriorGroupU as IDMElement);
    end;
  1:begin
      for j:=0 to aFacilityModel.GuardGroups.Count-1 do
        cbGroup.Items.AddObject(aFacilityModel.GuardGroups.Item[j].Name,
                        pointer(aFacilityModel.GuardGroups.Item[j]));
        cbGroup.ItemIndex:=aFacilityModel.GuardGroups.IndexOf(FacilityModelS.CurrentWarriorGroupU as IDMElement);
    end;
  end;
end;

procedure TfmCurrentOptions.cbAnalysisVariantChange(Sender: TObject);
var
  j:integer;
  AnalysisVariant:IAnalysisVariant;
  aFacilityStateE:IDMElement;
  aFacilityModel:IFacilityModel;
begin
  aFacilityModel:=FFacilityModel as IFacilityModel;
  if aFacilityModel=nil then Exit;

  j:=cbAnalysisVariant.ItemIndex;
  if j=-1 then Exit;
  AnalysisVariant:=aFacilityModel.AnalysisVariants.Item[j] as IAnalysisVariant;
  aFacilityStateE:=AnalysisVariant.FacilityState;
  cbFacilityState.ItemIndex:=aFacilityModel.FacilityStates.IndexOf(aFacilityStateE);
  cbGroupTypeChange(cbGroupType);
end;

procedure TfmCurrentOptions.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

end.
