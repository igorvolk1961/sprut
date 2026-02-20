unit AnalysisVariantU;

interface
uses
  Classes, SysUtils, Variants,
  DMElementU, SorterU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardElementU, OvercomingBoundaryU;

type
  TExtraTargets=class(TSafeguardElements)
  protected
    class function GetElementGUID:TGUID; override;
    function Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

  TAnalysisVariant=class(TNamedDMElement, IAnalysisVariant, IDMReporter)
  private

    FMainGroup:IWarriorGroup;

    FFacilityState:Variant;
    FAdversaryVariant:Variant;
    FGuardVariant:Variant;
    FGuardStrategy:integer;

    FBattleSystemEfficiency:double;
    FBattleAdversarySuccessProbability:double;

    FWarriorPaths:IDMCollection;
    FCriticalPoints:IDMCollection;
    FExtraTargets:IDMCollection;

    FUserDefinedResponceTime:boolean;
    FResponceTime:double;
    FUserDefinedResponceTimeDispersionRatio:boolean;
    FResponceTimeDispersionRatio:double;
    FResponceTimeDispersion:double;

    FFalseAlarmPeriod:double;

    FBaseAnalysisVariant:IDMElement;
    FVariantWeight:double;
    FPrice:double;
    FMaxPathCount:integer;

    procedure MakeRecomendations(ReportLevel:integer; const Report:IDMText);
    procedure ClearWarriorPaths;
    procedure SetResponceTimeDispersion;
    procedure FindMainGroup;

  protected
    FSystemEfficiency:double;
    FBestAdversarySuccessProbability:double;

    procedure Clear; override;
    procedure ClearOp; override;

    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;

    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function GetClassID:integer; override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
    procedure AfterLoading2; override;
    procedure Loaded; override;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;


    procedure Set_MainGroup(const Value:IWarriorGroup); safecall;
    function  Get_MainGroup:IWarriorGroup; safecall;

    procedure Set_AdversaryVariant(const Value: IDMElement); safecall;
    procedure Set_FacilityState(const Value: IDMElement); safecall;
    procedure Set_GuardVariant(const Value: IDMElement); safecall;
    function Get_AdversaryVariant: IDMElement; safecall;
    function Get_FacilityState: IDMElement; safecall;
    function Get_GuardVariant: IDMElement; safecall;
    function Get_WarriorPaths:IDMCollection; safecall;
    function Get_CriticalPoints:IDMCollection; safecall;
    function Get_ExtraTargets:IDMCollection; safecall;
    function Get_BaseAnalysisVariant:IDMElement; safecall;
    procedure Set_BaseAnalysisVariant(const Value:IDMElement); safecall;

    function  Get_BattleSystemEfficiency: double; safecall;
    procedure Set_BattleSystemEfficiency(Value: double); safecall;

    function Get_UserDefinedResponceTime:WordBool; safecall;
    function Get_ResponceTime:double; safecall;
    procedure Set_ResponceTime(Value:double); safecall;

    function  Get_ResponceTimeDispersion:double; safecall;
    procedure Set_ResponceTimeDispersion(Value:double); safecall;

    function Get_UserDefinedResponceTimeDispersionRatio:WordBool; safecall;
    function Get_ResponceTimeDispersionRatio:double; safecall;
    procedure Set_ResponceTimeDispersionRatio(Value:double); safecall;

    function Get_GuardStrategy:integer; safecall;
    function Get_FalseAlarmPeriod: Double; safecall;
    procedure Set_FalseAlarmPeriod(Value: Double); safecall;
    function  Get_VariantWeight:double; safecall;
    procedure Set_VariantWeight(Value:double); safecall;
    function  Get_Price:double; safecall;
    procedure Set_Price(Value:double); safecall;
    function  Get_MaxPathCount:integer; safecall;

    procedure CalcSystemEfficiency; virtual; safecall;
    procedure InitAnalysis; safecall;
    procedure CalculateFieldValues; override;
    procedure BuildReport(
        ReportLevel: Integer; TabCount: Integer; Mode: Integer;
        const Report: IDMText); override;
    function Get_ReportModeCount:integer; override; safecall;
    function Get_ReportModeName(Index:integer):WideString; override; safecall;

  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;


  TAnalysisVariants=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

  TCriticalPointSorter=class(TSorter)
  protected
    function  Get_Duplicates: WordBool; override; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

  TWarriorPathSorter=class(TSorter)
  protected
    function  Get_Duplicates: WordBool; override; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

implementation
uses
  FacilityModelConstU,
  FMRecomendationU;

var
  FFields:IDMCollection;

{ TAnalysisVariant }

procedure TAnalysisVariant.Initialize;
var
  aState:IDMElement;
  S:string;
  aFacilityModel:IFacilityModel;
  aCollection:IDMCollection2;
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;

  aFacilityModel:=DataModel as IFacilityModel;

  if not DataModel.IsLoading then begin
    if aFacilityModel.FacilityStates.Count=0 then begin
      aCollection:=aFacilityModel.FacilityStates as IDMCollection2;
      S:=aCollection.MakeDefaultName(nil);
      aState:=aCollection.CreateElement(False);
      aCollection.Add(aState);
      aState.Name:=S;
    end else begin
      aState:=aFacilityModel.FacilityStates.Item[0];
    end;

    Set_FacilityState(aState);
    Set_AdversaryVariant(aFacilityModel.AdversaryVariants.Item[0]);
    Set_GuardVariant(aFacilityModel.GuardVariants.Item[0]);
  end;

  FWarriorPaths:=DataModel.CreateCollection(_WarriorPath, SelfE);
  FCriticalPoints:=DataModel.CreateCollection(_CriticalPoint, SelfE);
  FExtraTargets:=TExtraTargets.Create(SelfE) as IDMCollection;
end;

procedure TAnalysisVariant._Destroy;
begin
  inherited;
  FWarriorPaths:=nil;
  FExtraTargets:=nil;
  FMainGroup:=nil;
  FCriticalPoints:=nil;
  FBaseAnalysisVariant:=nil
end;

class function TAnalysisVariant.GetClassID: integer;
begin
  Result:=_AnalysisVariant;
end;

function TAnalysisVariant.Get_FacilityState: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FFacilityState;
  Result:=Unk as IDMElement
end;

function TAnalysisVariant.Get_AdversaryVariant: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FAdversaryVariant;
  Result:=Unk as IDMElement
end;

function TAnalysisVariant.Get_GuardVariant: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FGuardVariant;
  Result:=Unk as IDMElement
end;

procedure TAnalysisVariant.Set_FacilityState(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FFacilityState:=Unk;
end;

procedure TAnalysisVariant.Set_AdversaryVariant(
  const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FAdversaryVariant:=Unk;
end;

procedure TAnalysisVariant.Set_GuardVariant(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FGuardVariant:=Unk;
end;

procedure TAnalysisVariant.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  aFacilityModel:IFacilityModel;
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  aFacilityModel:=DataModel as IFacilityModel;
  case Code of
  ord(avpFacilityState):
    theCollection:=aFacilityModel.FacilityStates;
  ord(avpAdversaryVariant):
    theCollection:=aFacilityModel.AdversaryVariants;
  ord(avpGuardVariant):
    theCollection:=aFacilityModel.GuardVariants;
  else
    begin
      inherited;
      Exit;
    end;
  end;
  if aCollection=nil then
    aCollection:=theCollection
  else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;
    if theCollection=nil then Exit;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

function TAnalysisVariant.Get_CollectionCount: integer;
begin
  Result:=3;
end;

procedure TAnalysisVariant.CalcSystemEfficiency;
var
  BestWarriorPath:IWarriorPath;
  FacilityModel:IFacilityModel;
  FacilityState:IFacilityState;
  ModificationStage:integer;
begin
  if FWarriorPaths.Count>0 then begin
    BestWarriorPath:=FWarriorPaths.Item[0] as IWarriorPath;
    FBestAdversarySuccessProbability:=BestWarriorPath.RationalProbability;
    FSystemEfficiency:=1-FBestAdversarySuccessProbability;
  end else begin
    FSystemEfficiency:=-InfinitValue;
    FBestAdversarySuccessProbability:=-InfinitValue;
  end;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityState:=Get_FacilityState as IFacilityState;
  ModificationStage:=FacilityState.ModificationStage;
  FacilityModel.CalcPrice(ModificationStage);
end;

function TAnalysisVariant.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(avpFacilityState):
    Result:=FFacilityState;
  ord(avpAdversaryVariant):
    Result:=FAdversaryVariant;
  ord(avpGuardStrategy):
    Result:=FGuardStrategy;
  ord(avpGuardVariant):
    Result:=FGuardVariant;
  ord(avpUserDefinedResponceTime):
    Result:=FUserDefinedResponceTime;
  ord(avpResponceTime):
    Result:=FResponceTime;
  ord(avpUserDefinedResponceTimeDispersionRatio):
    Result:=FUserDefinedResponceTimeDispersionRatio;
  ord(avpResponceTimeDispersionRatio):
    Result:=FResponceTimeDispersionRatio;
  ord(avpVariantWeight):
    Result:=FVariantWeight;
  ord(avpSystemEfficiency):
    Result:=FSystemEfficiency;
  ord(avpBestAdversarySuccessProbability):
    Result:=FBestAdversarySuccessProbability;
  ord(avpBattleSystemEfficiency):
    Result:=FBattleSystemEfficiency;
  ord(avpBattleAdversarySuccessProbability):
    Result:=FBattleAdversarySuccessProbability;
  ord(avpFalseAlarmPeriod):
    Result:=FFalseAlarmPeriod;
  ord(avpPrice):
    Result:=FPrice;
  ord(avpMaxPathCount):
    Result:=FMaxPathCount;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TAnalysisVariant.SetResponceTimeDispersion;
var
  aFacilityModel:IFacilityModel;
  ResponceTimeDispersionRatio:double;
begin
  if (not FUserDefinedResponceTimeDispersionRatio) and
    (DataModel<>nil) then begin
    aFacilityModel:=DataModel as IFacilityModel;
    ResponceTimeDispersionRatio:=aFacilityModel.ResponceTimeDispersionRatio
  end else
    ResponceTimeDispersionRatio:=FResponceTimeDispersionRatio;
  FResponceTimeDispersion:=sqr(ResponceTimeDispersionRatio*FResponceTime);
end;

procedure TAnalysisVariant.SetFieldValue(Code: integer;
  Value: OleVariant);

  procedure UpdateUserDefinedElements;
  var
     Document:IDMDocument;
  begin
     if DataModel=nil then Exit;
     if not DataModel.IsLoading and
        not DataModel.IsCopying then begin
       Document:=DataModel.Document as IDMDocument;
       if Document.Server=nil then Exit;
       (Document.Server as IDataModelServer).RefreshElement(Self as IUnknown);
     end;
  end;
begin
  case Code of
  ord(avpFacilityState):
    FFacilityState:=Value;
  ord(avpAdversaryVariant):
    begin
      FAdversaryVariant:=Value;
      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (Get_AdversaryVariant<>nil) then
        FindMainGroup;
    end;
  ord(avpGuardStrategy):
    FGuardStrategy:=Value;
  ord(avpGuardVariant):
    FGuardVariant:=Value;
  ord(avpUserDefinedResponceTime):
    begin
      FUserDefinedResponceTime:=Value;
      UpdateUserDefinedElements
    end;
  ord(avpResponceTime):
    begin
      FResponceTime:=Value;
      SetResponceTimeDispersion;
    end;
  ord(avpUserDefinedResponceTimeDispersionRatio):
    begin
      FUserDefinedResponceTimeDispersionRatio:=Value;
      SetResponceTimeDispersion;
      UpdateUserDefinedElements
    end;
  ord(avpResponceTimeDispersionRatio):
    begin
      FResponceTimeDispersionRatio:=Value;
      SetResponceTimeDispersion;
    end;
  ord(avpVariantWeight):
    FVariantWeight:=Value;
  ord(avpSystemEfficiency):
    FSystemEfficiency:=Value;
  ord(avpBestAdversarySuccessProbability):
    FBestAdversarySuccessProbability:=Value;
  ord(avpBattleSystemEfficiency):
     FBattleSystemEfficiency:=Value;
  ord(avpBattleAdversarySuccessProbability):
    FBattleAdversarySuccessProbability:=Value;
  ord(avpFalseAlarmPeriod):
    FFalseAlarmPeriod:=Value;
  ord(avpPrice):
    FPrice:=Value;
  ord(avpMaxPathCount):
    FMaxPathCount:=Value;
  else
    inherited
  end;
end;

class function TAnalysisVariant.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TAnalysisVariant.MakeFields0;
begin
  inherited;
  AddField(rsFacilityState, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(avpFacilityState), 0, pkInput);
  AddField(rsAdversaryVariant, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(avpAdversaryVariant), 0, pkInput);
  AddField(rsGuardVariant, '', '', 'Grd',
                 fvtElement, 0, 0, 0,
                 ord(avpGuardVariant), 0, pkInput);
  AddField(rsGuardStrategy, '|Предотвращение доступа|Сдерживание', '', '',
                 fvtChoice, 0, 0, 0,
                 ord(avpGuardStrategy), 0, pkInput);
  AddField(rsUserDefinedResponceTimeDispersionRatio, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(avpUserDefinedResponceTimeDispersionRatio), 0, pkUserDefined);
  AddField(rsResponceTimeDispersionRatio, '%0.3f', '', '',
                 fvtFloat, 0.13, 0, 1,
                 ord(avpResponceTimeDispersionRatio), 2, pkUserDefined);
  AddField(rsSystemEfficiency, '%0.4f', '', '',
                 fvtFloat, 0, 0, 1,
                 ord(avpSystemEfficiency), 1, pkOutput);
  AddField(rsAdversarySuccessProbability, '%0.4f', '', '',
                 fvtFloat, 0, 0, 1,
                 ord(avpBestAdversarySuccessProbability), 1, pkOutput);
{
  AddField(rsBattleSystemEfficiency, '%0.4f', '', '',
                 fvtFloat, 0, 0, 1,
                 ord(avpBattleSystemEfficiency), 1, pkAdditional);
  AddField(rsBattleAdversarySuccessProbability, '%0.4f', '', '',
                 fvtFloat, 0, 0, 1,
                 ord(avpBattleAdversarySuccessProbability), 1, pkAdditional);
}
  AddField(rsUserDefinedResponceTime, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(avpUserDefinedResponceTime), 0, pkUserDefined);
  AddField(rsResponceTime, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(avpResponceTime), 2, pkOutput or pkUserDefined);
  AddField(rsFalseAlarmPeriod, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(avpFalseAlarmPeriod), 1, pkOutput);
{
  AddField(rsVariantWeight, '%0.4f', '', '',
                 fvtFloat, 1, 0, 0,
                 ord(avpVariantWeight), 0, pkPrice);
  AddField(rsPrice1, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(avpPrice), 1, pkPrice);
}
  AddField(rsMaxPathCount, '%d', '', '',
                 fvtInteger, 1, 0, 0,
                 ord(avpMaxPathCount), 0, pkAdditional);
end;

function TAnalysisVariant.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:Result:=FWarriorPaths;
  1:Result:=FCriticalPoints;
  2:Result:=FExtraTargets;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

procedure TAnalysisVariant.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:begin
      aCollectionName:=rsVariantBoundaryWarriorPaths;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoDontCopy or leoOperation1;
      aLinkType:=ltOneToMany;
    end;
  1:begin
      aCollectionName:=rsCriticalPoints;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoDontCopy;
      aLinkType:=ltOneToMany;
    end;
  2:begin
      aCollectionName:=rsExtraTargets;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  else
    inherited;
  end;
end;

function TAnalysisVariant.Get_WarriorPaths: IDMCollection;
begin
  Result:=FWarriorPaths
end;

function TAnalysisVariant.Get_MainGroup: IWarriorGroup;
begin
  Result:=FMainGroup
end;

procedure TAnalysisVariant.InitAnalysis;
begin
  FMainGroup:=nil;

  ClearWarriorPaths;
  FindMainGroup;
  if FMainGroup=nil then
    DataModel.HandleError('Ни одной группе нарушителей не поставлена основная задача');
end;

procedure TAnalysisVariant.FindMainGroup;
var
  j:integer;
  WarriorGroup:IWarriorGroup;
  AdversaryVariant:IAdversaryVariant;
begin
  AdversaryVariant:=Get_AdversaryVariant as IAdversaryVariant;
  if AdversaryVariant=nil then Exit;
  AdversaryVariant.Prepare;
  for j:=AdversaryVariant.AdversaryGroups.Count-1 downto 0 do begin
    WarriorGroup:=AdversaryVariant.AdversaryGroups.Item[j] as IWarriorGroup;
    case WarriorGroup.Task of
    0: Set_MainGroup(WarriorGroup);
    end;
  end;
end;

function TAnalysisVariant.Get_ResponceTime: double;
begin
  Result:=FResponceTime
end;

function TAnalysisVariant.Get_UserDefinedResponceTime: WordBool;
begin
  Result:=FUserDefinedResponceTime
end;

procedure TAnalysisVariant.Set_ResponceTime(Value: double);
begin
  FResponceTime:=Value
end;

function TAnalysisVariant.Get_ResponceTimeDispersion: double;
begin
  Result:=FResponceTimeDispersion
end;

procedure TAnalysisVariant.Set_ResponceTimeDispersion(Value: double);
begin
  FResponceTimeDispersion:=Value
end;

function TAnalysisVariant.Get_GuardStrategy: integer;
begin
  Result:=FGuardStrategy
end;

function TAnalysisVariant.Get_ExtraTargets: IDMCollection;
begin
  Result:=FExtraTargets
end;

procedure TAnalysisVariant.CalculateFieldValues;
var
  Server:IDataModelServer;
  FacilityModelS:IFMState;
  Document:IDMDocument;
begin
  inherited;
  FacilityModelS:=DataModel as IFMState;
  FacilityModelS.CurrentAnalysisVariantU:=Self as IUnknown;

  Document:=DataModel.Document as IDMDocument;
  Server:=Document.Server;

  Server.RefreshElement(Self as IUnknown);
end;

function TAnalysisVariant.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(avpGuardVariant):
    Result:=False;
  ord(avpResponceTimeDispersionRatio):
    Result:=FUserDefinedResponceTimeDispersionRatio;
  else
    Result:=inherited FieldIsVisible(Code)
  end;  
end;

function TAnalysisVariant.Get_CriticalPoints: IDMCollection;
begin
  Result:=FCriticalPoints
end;

procedure TAnalysisVariant.BuildReport(ReportLevel, TabCount,
  Mode: Integer; const Report: IDMText);
var
  S, S1:string;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  j:integer;
  Reporter:IDMReporter;
begin
  aFacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=DataModel as IFMState;

  Report.AddLine('$B');
  S:=Format('Вариант анализа - "%s".',
           [Name]);
  Report.AddLine(S);
  Report.AddLine('$N');

  S:=Format(#9'Состояние системы "%s".',
           [Get_FacilityState.Name]);
  Report.AddLine(S);

  if FUserDefinedResponceTime then
    S1:='задано явно'
  else
    S1:='получено путем расчета';
   S:=Format(#9'Время реагирования %0.0f с  (%s).',
           [FResponceTime, S1]);
  Report.AddLine(S);

  if FGuardStrategy=0 then
    S1:='предотвращение доступа'
  else
    S1:='сдерживание';

  S:=Format(#9'Стратегия защиты - "%s".',
           [S1]);
  Report.AddLine(S);

  S:=Format(#9'Вариант угрозы - "%s".',
           [Get_AdversaryVariant.Name]);
  Report.AddLine(S);

  if aFacilityModel.DelayTimeDispersionRatio=0 then
    S1:='детерминированны'
  else
    S1:='распределены по нормальному закону';
  S:=Format(#9'Времена задержки нарушителя и время реагирования %s.',
           [S1]);
  Report.AddLine(S);

  if FWarriorPaths.Count=0 then Exit;

    Report.AddLine('$B');
    S:=Format(#9'Вероятность своевременного перехвата нарушителя %0.4f.',
           [FSystemEfficiency]);
    Report.AddLine(S);
    Report.AddLine('$N');

    S:=#9'Оптимальный маршрут нарушителя:';
    Report.AddLine(S);

    FacilityModelS.CurrentFacilityStateU:=Get_FacilityState;
    if FMainGroup=nil then
      FindMainGroup;
    FacilityModelS.CurrentWarriorGroupU:=FMainGroup;
    FacilityModelS.CurrentPathStage:=0;

    Reporter:=FWarriorPaths.Item[0] as IDMReporter;
    case Mode of
    0: Reporter.BuildReport(0, TabCount+2, 1, Report);
    1: Reporter.BuildReport(1, TabCount+2, 1, Report);
    2:begin
        Reporter.BuildReport(0, TabCount+2, 1, Report);
        S:=#9'Альтернативные маршруты нарушителя от каждого из участков внешнего периметра объекта:';
        Report.AddLine(S);
        for j:=1 to FWarriorPaths.Count-1 do begin
          Reporter:=FWarriorPaths.Item[j] as IDMReporter;
          Reporter.BuildReport(0, TabCount+2, 1, Report)
        end;
      end;
    end;
end;

procedure TAnalysisVariant.MakeRecomendations(ReportLevel: integer;
  const Report: IDMText);
var
  j:integer;
  Recomendations:IDMCollection;
begin
  Recomendations:=(DataModel as IFacilityModel).FMRecomendations;
  for j:=0 to Recomendations.Count-1 do begin
    Report.AddLine(Recomendations.Item[j].Name);
  end;
end;

function TAnalysisVariant.Get_FalseAlarmPeriod: Double;
begin
  Result:=FFalseAlarmPeriod
end;

procedure TAnalysisVariant.Set_FalseAlarmPeriod(Value: Double);
begin
  FFalseAlarmPeriod:=Value
end;

procedure TAnalysisVariant.Set_BattleSystemEfficiency(
  Value: double);
begin
  FBattleSystemEfficiency:=Value;
  FBattleAdversarySuccessProbability:=1-Value;
end;

function TAnalysisVariant.Get_BattleSystemEfficiency: double;
begin
  Result:=FBattleSystemEfficiency
end;

procedure TAnalysisVariant.ClearWarriorPaths;
var
  WarriorPaths2, CriticalPoints2:IDMCollection2;
  WarriorPathE, CriticalPointE:IDMElement;
begin
  if DataModel=nil then Exit;

  WarriorPaths2:=(DataModel as IFacilityModel).WarriorPaths as IDMCollection2;
  while FWarriorPaths.Count>0 do begin
    WarriorPathE:=FWarriorPaths.Item[FWarriorPaths.Count-1];
    WarriorPathE.Clear;
    WarriorPaths2.Remove(WarriorPathE);
  end;

  CriticalPoints2:=(DataModel as IFacilityModel).CriticalPoints as IDMCollection2;
  while FCriticalPoints.Count>0 do begin
    CriticalPointE:=FCriticalPoints.Item[FCriticalPoints.Count-1];
    if CriticalPointE.Selected then
      CriticalPointE.Selected:=False;
    CriticalPointE.Clear;
    CriticalPoints2.Remove(CriticalPointE);
  end;

end;

procedure TAnalysisVariant.ClearOp;
begin
  inherited;
  ClearWarriorPaths;
end;

procedure TAnalysisVariant.Clear;
begin
  ClearWarriorPaths;
  inherited;
end;

procedure TAnalysisVariant.AfterLoading2;
var
  Sorter:ISorter;
begin
  inherited;
  
  Sorter:=TWarriorPathSorter.Create(nil) as ISorter;
  (FWarriorPaths as IDMCollection2).Sort(Sorter);

  Sorter:=TCriticalPointSorter.Create(nil) as ISorter;
  (FCriticalPoints as IDMCollection2).Sort(Sorter);
end;

function TAnalysisVariant.Get_UserDefinedResponceTimeDispersionRatio: WordBool;
begin
  Result:=FUserDefinedResponceTimeDispersionRatio
end;

function TAnalysisVariant.Get_ResponceTimeDispersionRatio: double;
begin
  Result:=FResponceTimeDispersionRatio
end;

procedure TAnalysisVariant.Set_ResponceTimeDispersionRatio(Value: double);
begin
  FResponceTimeDispersionRatio:=Value
end;

procedure TAnalysisVariant.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  aCollection2:=aCollection as IDMCollection2;
  SourceCollection:=(DataModel as IFacilityModel).ExtraTargets;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do
    aCollection2.Add(SourceCollection.Item[j]);
end;

function TAnalysisVariant.Get_BaseAnalysisVariant: IDMElement;
begin
  Result:=FBaseAnalysisVariant
end;

procedure TAnalysisVariant.Set_BaseAnalysisVariant(
  const Value: IDMElement);
begin
  FBaseAnalysisVariant:=Value
end;

function TAnalysisVariant.Get_VariantWeight: double;
begin
  Result:=FVariantWeight
end;

procedure TAnalysisVariant.Set_VariantWeight(Value: double);
begin
  FVariantWeight:=Value
end;

function TAnalysisVariant.Get_Price: double;
begin
  Result:=FPrice
end;

procedure TAnalysisVariant.Set_Price(Value: double);
begin
  FPrice:=Value
end;

function TAnalysisVariant.Get_ReportModeCount: integer;
begin
  Result:=3
end;

function TAnalysisVariant.Get_ReportModeName(Index: integer): WideString;
begin
  case Index of
  0: Result:='Сводка результатов';
  1: Result:='Описание маршрута нарушителей';
  2: Result:='Обзор альтернативных маршрутов нарушителей';
  else
    Result:=inherited Get_ReportModeName(Index);
  end;
end;

procedure TAnalysisVariant.Set_MainGroup(const Value: IWarriorGroup);
begin
  if FMainGroup=Value then Exit;
  if FMainGroup<>nil then
    FMainGroup.Task:=0;
  FMainGroup:=Value;
end;

procedure TAnalysisVariant.Loaded;
begin
  inherited;
  FindMainGroup;
end;

function TAnalysisVariant.Get_MaxPathCount: integer;
begin
  Result:=FMaxPathCount
end;

{ TAnalysisVariants }

class function TAnalysisVariants.GetElementClass: TDMElementClass;
begin
  Result:=TAnalysisVariant;
end;

function TAnalysisVariants.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsAnalysisVariant
  else
    Result:=rsAnalysisVariants;
end;

class function TAnalysisVariants.GetElementGUID: TGUID;
begin
  Result:=IID_IAnalysisVariant;
end;

{ TExtraTargets }

class function TExtraTargets.GetElementGUID: TGUID;
begin
  Result:=IID_IPathNodeArray
end;

function TExtraTargets.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsTarget;
end;

{ TCriticalPointSorter }

function TCriticalPointSorter.Compare(const Key1,
  Key2: IDMElement): Integer;
var
  P1, P2, R1, R2:double;
begin
  if Key1.DataModel.IsLoading then begin
    Result:=inherited Compare(Key1, Key2);
    Exit;
  end;
  P1:=(Key1 as ICriticalPoint).InterruptionProbability;
  P2:=(Key2 as ICriticalPoint).InterruptionProbability;
  if P1<P2 then
    Result:=-1
  else if P1>P2 then
    Result:=+1
  else begin
    R1:=(Key1 as ICriticalPoint).TimeRemainder;
    R2:=(Key2 as ICriticalPoint).TimeRemainder;
    if R1<R2 then
      Result:=-1
    else if R1>R2 then
      Result:=+1
    else
      Result:=0;
  end;
end;

function TCriticalPointSorter.Get_Duplicates: WordBool;
begin
  Result:=True
end;

{ TWarriorPathSorter }

function TWarriorPathSorter.Compare(const Key1, Key2: IDMElement): Integer;
var
  P1, P2:double;
begin
  if Key1.DataModel.IsLoading then begin
    Result:=inherited Compare(Key1, Key2);
    Exit;
  end;
//  P1:=(Key1 as IWarriorPath).SuccessProbability;
//  P2:=(Key2 as IWarriorPath).SuccessProbability;
  P1:=(Key1 as IWarriorPath).RationalProbability;
  P2:=(Key2 as IWarriorPath).RationalProbability;
{
  if abs(P2-P1)<0.0001 then begin
    P1:=(Key1 as IWarriorPath).DelayTime;
    P2:=(Key2 as IWarriorPath).DelayTime;
    if P1<P2 then
      Result:=-1
    else if P1>P2 then
      Result:=+1
    else
      Result:=0;
  end else
}  
  if P1>P2 then
    Result:=-1
  else if P1<P2 then
    Result:=+1
end;

function TWarriorPathSorter.Get_Duplicates: WordBool;
begin
  Result:=True
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TAnalysisVariant.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
