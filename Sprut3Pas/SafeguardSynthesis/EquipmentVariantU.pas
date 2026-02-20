unit EquipmentVariantU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, FacilityModelLib_TLB,
  SafeguardSynthesisLib_TLB;

type
  TEquipmentVariant=class(TNamedDMElement, IEquipmentVariant)
  private
    FRecomendationVariants:IDMCollection;
    FTotalPrice:double;
    FTotalEfficiency:double;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    procedure Analysis; safecall;

    function  Get_RecomendationVariants:IDMCollection; safecall;
    procedure MakePersistantState; safecall;
    function  Get_TotalPrice:double; safecall;
    procedure Set_TotalPrice(Value:double); safecall;
    function  Get_TotalEfficiency:double; safecall;
    procedure Set_TotalEfficiency(Value:double); safecall;
    procedure Connect; safecall;
    procedure Disconnect; safecall;

    function  Get_CollectionCount: Integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TEquipmentVariants=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  SafeguardSynthesisConstU,
  RecomendationVariantU;

var
  FFields:IDMCollection;

{ TEquipmentVariant }

class function TEquipmentVariant.GetClassID: integer;
begin
  Result:=_EquipmentVariant;
end;

procedure TEquipmentVariant._Destroy;
begin
  inherited;
  FRecomendationVariants:=nil;
end;

procedure TEquipmentVariant.Initialize;
begin
  inherited;
  FRecomendationVariants:=TRecomendationVariants.Create(Self as IDMElement) as  IDMCollection;
end;

class function TEquipmentVariant.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TEquipmentVariant.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FRecomendationVariants
end;

function TEquipmentVariant.Get_CollectionCount: Integer;
begin
  Result:=1
end;

procedure TEquipmentVariant.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
   aRefSource:=nil;
   aCollectionName:=rsRecomendationVariants;
   aClassCollections:=nil;
   aOperations:=0;
   aLinkType:=ltManyToMany;
end;

function TEquipmentVariant.Get_RecomendationVariants: IDMCollection;
begin
  Result:=FRecomendationVariants
end;

function TEquipmentVariant.Get_TotalPrice: double;
begin
  Result:=FTotalPrice
end;

procedure TEquipmentVariant.MakePersistantState;
begin
end;

procedure TEquipmentVariant.Set_TotalPrice(Value: double);
begin
  FTotalPrice:=Value
end;

function TEquipmentVariant.Get_TotalEfficiency: double;
begin
  Result:=FTotalEfficiency
end;

procedure TEquipmentVariant.Set_TotalEfficiency(Value: double);
begin
  FTotalEfficiency:=Value
end;

procedure TEquipmentVariant.Connect;
var
  j:integer;
  RecomendationVariant:IRecomendationVariant;
begin
  for j:=0 to FRecomendationVariants.Count-1 do begin
    RecomendationVariant:=FRecomendationVariants.Item[j] as IRecomendationVariant;
    RecomendationVariant.Connect;
  end;
end;

procedure TEquipmentVariant.Disconnect;
var
  j:integer;
  RecomendationVariant:IRecomendationVariant;
begin
  for j:=0 to FRecomendationVariants.Count-1 do begin
    RecomendationVariant:=FRecomendationVariants.Item[j] as IRecomendationVariant;
    RecomendationVariant.Disconnect;
  end;
end;

procedure TEquipmentVariant.Analysis;
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  aEfficiency, WeightSumm:double;
  j, OldModificationStage:integer;
  AnalysisVariantE :IDMElement;
  AnalysisVariant, OldAnalysisVariant:IAnalysisVariant;
  FacilityState:IFacilityState;
begin
  FacilityModel:=(DataModel as ISafeguardSynthesis).FacilityModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  OldAnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  try
  if FacilityModel.TotalEfficiencyCalcMode=0 then begin
    FTotalEfficiency:=1;
    for j:=0 to FacilityModel.AnalysisVariants.Count-1 do begin
      AnalysisVariantE:=FacilityModel.AnalysisVariants.Item[j];
      AnalysisVariant:=AnalysisVariantE as IAnalysisVariant;
      if AnalysisVariant.VariantWeight>0 then begin
        FacilityState:=AnalysisVariant.FacilityState as IFacilityState;
        OldModificationStage:=FacilityState.ModificationStage;
        try
        FacilityState.ModificationStage:=2;  // 2-й этап модернизации
        FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariant;
        FacilityModel.CalcEfficiency;
        aEfficiency:=FacilityModel.TotalEfficiency;
        if FTotalEfficiency>aEfficiency then
          FTotalEfficiency:=aEfficiency;
        finally
          FacilityState.ModificationStage:=OldModificationStage;
        end;
      end;
    end;
  end else begin
    FTotalEfficiency:=0;
    WeightSumm:=0;
    for j:=0 to FacilityModel.AnalysisVariants.Count-1 do begin
      AnalysisVariantE:=FacilityModel.AnalysisVariants.Item[j];
      AnalysisVariant:=AnalysisVariantE as IAnalysisVariant;
      if AnalysisVariant.VariantWeight>0 then begin
        FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariant;
        FacilityModel.CalcEfficiency;
        aEfficiency:=FacilityModel.TotalEfficiency;
        FTotalEfficiency:=FTotalEfficiency+aEfficiency*AnalysisVariant.VariantWeight;
        WeightSumm:=WeightSumm+AnalysisVariant.VariantWeight;
      end;
      if WeightSumm<>0 then
        FTotalEfficiency:=FTotalEfficiency/WeightSumm
      else
        FTotalEfficiency:=0;
    end;
  end;
  FacilityModel.CalcPrice(2);  // 2-й этап модернизации (с учетом рекомендаций)
  FTotalPrice:=FacilityModel.TotalPrice;
  finally
    FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariant;
  end;
end;

{ TEquipmentVariants }

class function TEquipmentVariants.GetElementClass: TDMElementClass;
begin
  Result:=TEquipmentVariant;
end;


function TEquipmentVariants.Get_ClassAlias(Index: integer): WideString;
begin
    Result:=rsEquipmentVariant
end;

class function TEquipmentVariants.GetElementGUID: TGUID;
begin
  Result:=IID_IEquipmentVariant;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TEquipmentVariant.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
