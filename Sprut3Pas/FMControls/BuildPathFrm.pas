unit BuildPathFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  DataModel_TLB, FacilityModelLib_TLB;

type
  TfmBuildPath = class(TForm)
    edName: TEdit;
    rgPathKind: TRadioGroup;
    chbAnalisysVariant: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    pGuardGroup: TPanel;
    Label3: TLabel;
    chbGuardGroup: TComboBox;
    procedure FormDestroy(Sender: TObject);
    procedure chbAnalisysVariantChange(Sender: TObject);
    procedure chbGuardGroupChange(Sender: TObject);
    procedure rgPathKindClick(Sender: TObject);
  private
    FFacilityModel:IFacilityModel;
    procedure SetFacilityModel(const Value: IFacilityModel);
  public
    property FacilityModel:IFacilityModel read FFacilityModel write SetFacilityModel;
  end;

var
  fmBuildPath: TfmBuildPath;

implementation

{$R *.dfm}

{ TfmBuildPath }

{ TfmBuildPath }

procedure TfmBuildPath.SetFacilityModel(const Value: IFacilityModel);
var
  j:integer;
  AnalysisVariantE:IDMElement;
  FacilityModelS:IFMState;
  GuardGroupE:IDMElement;
  GuardGroupW:IWarriorGroup;
begin
  FFacilityModel := Value;
  chbAnalisysVariant.Clear;
  for j:=0 to FFacilityModel.AnalysisVariants.Count-1 do begin
    AnalysisVariantE:=FFacilityModel.AnalysisVariants.Item[j];
    chbAnalisysVariant.Items.AddObject(AnalysisVariantE.Name, pointer(AnalysisVariantE))
  end;
  FacilityModelS:=FFacilityModel as IFMState;
  AnalysisVariantE:=FacilityModelS.CurrentAnalysisVariantU as IDMElement;
  chbAnalisysVariant.ItemIndex:=FFacilityModel.AnalysisVariants.IndexOf(AnalysisVariantE);

  chbGuardGroup.Clear;
  for j:=0 to FFacilityModel.GuardGroups.Count-1 do begin
    GuardGroupE:=FFacilityModel.GuardGroups.Item[j];
    GuardGroupW:=GuardGroupE as IWarriorGroup;
    case GuardGroupW.Task of
    gtInterruptOnDetectionPoint,
    gtInterruptOnTarget,
    gtInterruptOnExit:
      chbGuardGroup.Items.AddObject(GuardGroupE.Name, pointer(GuardGroupE))
    end;
  end;
end;

procedure TfmBuildPath.FormDestroy(Sender: TObject);
begin
  FFacilityModel := nil;
end;

procedure TfmBuildPath.chbAnalisysVariantChange(Sender: TObject);
var
  FacilityModelS:IFMState;
  j:integer;
  AnalysisVariant:IAnalysisVariant;
begin
  j:=chbAnalisysVariant.ItemIndex;
  if j=-1 then Exit;
  FacilityModelS:=FFacilityModel as IFMState;
  AnalysisVariant:=FFacilityModel.AnalysisVariants.Item[j] as IAnalysisVariant;
  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariant;
  FacilityModelS.CurrentWarriorGroupU:=AnalysisVariant.MainGroup;
end;

procedure TfmBuildPath.chbGuardGroupChange(Sender: TObject);
var
  j:integer;
  GuardGroupE:IDMELement;
  FacilityModelS:IFMState;
begin
  j:=chbGuardGroup.ItemIndex;
  if j=-1 then Exit;
  GuardGroupE:=IDMElement(pointer(chbGuardGroup.Items.Objects[j]));
  FacilityModelS:=FFacilityModel as IFMState;
  FacilityModelS.CurrentWarriorGroupU:=GuardGroupE;
end;

procedure TfmBuildPath.rgPathKindClick(Sender: TObject);
var
  FacilityModelS:IFMState;
  AnalysisVariant:IAnalysisVariant;
  j:integer;
begin
  case rgPathKind.ItemIndex of
  0, 1, 2:
    begin
      j:=chbAnalisysVariant.ItemIndex;
      pGuardGroup.Visible:=False;
      FacilityModelS:=FFacilityModel as IFMState;
      AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
      FacilityModelS.CurrentWarriorGroupU:=AnalysisVariant.MainGroup;
    end
  else
    begin
      pGuardGroup.Visible:=True;
      chbGuardGroupChange(nil);
    end;
  end;
end;

end.
