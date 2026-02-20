unit SafeguardAnalyzerU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj,
  Classes, SysUtils, Math, StdVcl,
  FacilityModelLib_TLB,
  DMComObjectU, SorterU, DataModelU, DMAnalyzerU,
  DataModel_TLB,
  DMServer_TLB, SpatialModelLib_TLB, SgdbLib_TLB,
  SafeguardSynthesisLib_TLB, SafeguardAnalyzerLib_TLB,
  Variants; //, DebugU;


const
  wpsStealthEntry=0;
  wpsFastEntry=1;
  wpsStealthExit=2;
  wpsFastExit=3;

  pdDirectPath=0;
  pdReversedPath=1;
  pdDirectTMPPath=2;

function GetDataModelClassObject:IDMClassFactory;

type
  TSafeguardAnalyzerFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;


  ESafeguardAnalyzerException=class(Exception)
  end;

  TGuardArrivalTimeSorter=class(TSorter)
  protected
    function Compare(const Key1, Key2:IDMElement):integer; override; safecall;
  end;

  TSafeguardAnalyzer = class(TDMAnalyzer, ISafeguardAnalyzer, ISpatialModel)
  private
    FAnalysisVariant:IAnalysisVariant;
    FDisabledPathNodes:IDMCollection;

    FPathStage:integer;

    FCalcMode:integer;
    FTreeMode:integer;
    FCurrentWarriorGroup:IWarriorGroup;
    FResponceTime:double;
    FResponceTimeDispersion:double;
    FDistanceFunc:double;
    FDistanceFunc1:double;
    FDistanceFunc2:double;
    FDistanceFunc3:double;

    FGraphLayer:IDMElement;
    FOptimalPathLayer:IDMElement;  //оптимальный, быстрый в случае обнаружения
    FRationalPathLayer:IDMElement; //рациональный, от которого он не отклоняется даже если обнаружен
    FFastPathLayer:IDMElement;     //быстрый маршрут
    FStealthPathLayer:IDMElement;  //скрытный маршрут

    FPathGraphConnectors:IDMCollection;
    FBaseGraph:IDMElement;

    FCompareDistanceFunc1:boolean;

    function ExecuteStage(FirstVariantFlag,
                          OldFacilityState, OldAdversaryVariant, OldTarget:boolean; var N: integer):boolean;
    procedure ClearTree;
    procedure ClearCash;
    procedure ConnectPathGraphs(const PathGraphE, NextPathGraphE,
                                ExtraTargetE:IDMElement);
    procedure BuildSoundResistanceTree;
    procedure FindGuardFinishPoints;
    procedure BuildGuardPaths;
    procedure CalcResponceTime;
    procedure BuildSupportGroupPaths;
    procedure BuildAdversaryStealthTreeFromStart;
    procedure BuildAdversaryFastTreeToTarget;
    procedure BuildAdversaryFastTreeFromStart;
    procedure BuildAdversaryFastBackPathTree;
    procedure BuildAdversaryRationalTreeToTarget;
    procedure BuildAdversaryRationalBackPathTree;
    procedure CalcVulnerability;
    procedure FindCriticalPoints;
    function  GetPathNodeForGraph(
              const SafeguardElementA:IPathNodeArray;
              const PathGraph:IDMElement):IPathNode;
    procedure CalcBattleModel;

    procedure BuildTree(const RootNode:IPathNode);
    procedure ChangeFacilityState;
    procedure ChangePathGraphState(const AnalysisVariantE:IDMElement);
    procedure ChangeBackPathGraphState(const AnalysisVariantE, PathE:IDMElement);
    procedure BuildBackPath(const Element:IDMElement);
    procedure ClearBackPathGraphState;
    procedure EstimateTotalBackPathDelayTime(const NodeE:IDMElement);

    procedure Terminate(const Text:string);
    procedure ClearGuardModel;

  protected
    function  CreateCollection(aClassID:integer; const aParent:IDMElement): IDMCollection; override; safecall;
    procedure HandleError(const ErrorMessage:WideString); override; safecall;

    procedure Update; override;
    procedure Clear; override;
    function GetStageName:string; override;
    function CalcStepCount:integer; override;
    procedure DoAnalysis; override;
    procedure SetTerminateFlag(Value:boolean); override;

    function  MakePathFrom(const NodeE: IDMElement; Reversed: WordBool;
                           PathKind: Integer; UseStoredRecords:WordBool;
                           var WarriorPathE: IDMElement): IDMElement; safecall;

    function  Get_CalcMode: Integer; safecall;
    procedure  Set_CalcMode(Value: Integer); safecall;
    function  Get_TreeMode:Integer; safecall;
    procedure  Set_TreeMode(Value: Integer); safecall;
    function  Get_CurrentWarriorGroup: IDMElement; safecall;
    function Get_PathNodes:IDMCollection; safecall;
    function Get_PathArcs:IDMCollection; safecall;
    function Get_Paths:IDMCollection; safecall;
    function Get_PathLayers:IDMCollection; safecall;
    function Get_VerticalWays:IDMCollection; safecall;

    function Get_PathStage:integer; safecall;
    procedure Set_PathStage(Value:integer); safecall;
    function Get_ResponceTime:double; safecall;
    function Get_ResponceTimeDispersion:double; safecall;
    procedure Set_ResponceTimeDispersion(Value:double); safecall;
    function  Get_DistanceFunc:double; safecall;
    procedure Set_DistanceFunc(Value:double); safecall;
    function  Get_DistanceFunc1:double; safecall;
    procedure Set_DistanceFunc1(Value:double); safecall;
    function  Get_DistanceFunc2:double; safecall;
    procedure Set_DistanceFunc2(Value:double); safecall;
    function  Get_DistanceFunc3:double; safecall;
    procedure Set_DistanceFunc3(Value:double); safecall;

    procedure MakeBoundaryPaths(const BoundaryE:IDMElement);
    procedure MakeGuardPostPaths(const GuardPostE:IDMElement);

    function Get_AnalysisVariant:IDMElement; safecall;

    procedure MakeCollections; override;

    function  Get_Layers: IDMCollection; safecall;
    function  Get_CoordNodes: IDMCollection; safecall;
    function  Get_Lines: IDMCollection; safecall;
    function  Get_CurvedLines: IDMCollection; safecall;
    function  Get_Polylines: IDMCollection; safecall;
    function  Get_LineGroups: IDMCollection; safecall;
    function  Get_Circles: IDMCollection; safecall;
    function  Get_ImageRects: IDMCollection; safecall;
    function  Get_RoadParts: IDMCollection; safecall;
    function  Get_CurrentLayer: ILayer; safecall;
    procedure Set_CurrentLayer(const Value: ILayer); safecall;
    procedure TreatElement(const Element: IDMElement; aMode: Integer); override; safecall;
    function BuildPatrolPath(const GroupE, StartNodeE, FinishNodeE:IDMElement):IDMElement; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;

    function  Get_PathGraphs: IDMCollection; safecall;

    property AnalysisVariant:IAnalysisVariant read FAnalysisVariant write FAnalysisVariant;
    property BaseGraph:IDMElement read FBaseGraph write FBaseGraph;
    property PathNodes:IDMCollection read Get_PathNodes;
    property PathArcs:IDMCollection read Get_PathArcs;
    property VerticalWays:IDMCollection read Get_VerticalWays;
    property RoadParts: IDMCollection read Get_RoadParts;
  end;

  TFMRecomendationSorter=class(TSorter)
  protected
    function  Get_Duplicates: WordBool; override; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

  TWarriorPathSorter=class(TSorter)
  protected
    function  Get_Duplicates: WordBool; override; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

  TCriticalPointSorter=class(TSorter)
  protected
    function  Get_Duplicates: WordBool; override; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

implementation

uses
  PathNodeU,
  PathArcU,
  PathU,
  PathLayerU,
  PathGraphU,
  RoadPartU,
  VerticalWayU,
  SafeguardAnalyzerConstU,
  FacilityModelConstU,
  LinkListU,
  SyncObjs,
  GraphBuilderU;

const
  stageCheckFacilityModel=0;
  stageClear=1;
  stageChangeFacilityState=2;
  stageBuildPathGraph=3;
  stageBuildSoundResistanceTree=4;
  stageBuildAdversaryFastTreeToTarget=5;
  stageBuildAdversaryFastTreeFromStart=6;
  stageBuildAdversaryFastBackPathTree=7;
  stageFindGuardFinishPoints=8;
  stageBuildGuardPaths=9;
  stageBuildSupportGroupPaths=10;
  stageCalcFalseAlarmPeriod=11;
  stageBuildAdversaryStealthTreeFromStart=12;
  stageBuildAdversaryRationalTreeToTarget=13;
  stageBuildAdversaryRationalBackPathTree=14;
  stageCalcVulnerability=15;
  stageCalcSystemEfficiency=16;
  stageBattleModel=17;
  stageFindCriticalPoints=18;
  stageMakeRecomendations=19;

  MaxStage=18;

  InfinitValue=1000000000;

var
  WriteFlag:integer=0;
  XXX:integer;

{ TSafeguardAnalyzer }

function TSafeguardAnalyzer.CalcStepCount: integer;
begin
  Result:=100000000
end;

procedure TSafeguardAnalyzer.DoAnalysis;
var
  j, m, N:integer;
  Document:IDMDocument;
  Server:IDataModelServer;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  FirstVariantFlag, OldFacilityState, OldAdversaryVariant, OldTarget:boolean;
  LastAnalysisVariant:IAnalysisVariant;
  AnalysisMode:integer;
begin
//      Rewrite(DebugFile);

  AnalysisMode:=Get_Mode;
  Document:=(Get_Data as IDataModel).Document as IDMDocument;
  Server:=Document.Server;
  FacilityModel:=Get_Data as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  Document.State:=Document.State or dmfCommiting;
  try
  try
  if AnalysisMode=-2 then begin
     Server.NextAnalysisStage(rsSafeguardSynthesis, 0, 0);
    (FacilityModel.SafeguardSynthesis as ISafeguardSynthesis).BuildEquipmentVariants;
     Server.NextAnalysisStage('', -1, -1);
     Exit;
  end else
  if AnalysisMode=3 then begin
     Server.NextAnalysisStage(rsClear, 0, 0);
     ClearTree;
     for j:=0 to FacilityModel.AnalysisVariants.Count-1 do
       (FacilityModel.AnalysisVariants.Item[j] as IAnalysisVariant).InitAnalysis;
     Server.NextAnalysisStage('', -1, -1);
     Exit;
  end else
  if AnalysisMode<>-1 then
    MakePathGraphs(Self)
  else
  if Get_PathGraphs.Count=0 then begin
    Set_Mode(1);
    MakePathGraphs(Self);
  end;

  m:=0;
  for j:=0 to FacilityModel.AnalysisVariants.Count-1 do
  if (Document.SelectionCount=0) or
     ((Document.SelectionItem[0] as IDMElement).ClassID<>_AnalysisVariant) or
      FacilityModel.AnalysisVariants.Item[j].Selected then begin
    if m=0 then begin
      FirstVariantFlag:=True;
      LastAnalysisVariant:=nil;
    end else begin
      FirstVariantFlag:=False;
      LastAnalysisVariant:=FAnalysisVariant;
    end;
    inc(m);


    FAnalysisVariant:=FacilityModel.AnalysisVariants.Item[j] as IAnalysisVariant;
    FAnalysisVariant.BaseAnalysisVariant:=nil;

    OldTarget:=False;
    if (LastAnalysisVariant<>nil) and
       (LastAnalysisVariant.FacilityState=FAnalysisVariant.FacilityState) and
       (LastAnalysisVariant.GuardVariant=FAnalysisVariant.GuardVariant) and
       ((LastAnalysisVariant.ExtraTargets as IDMCollection2).IsEqualTo(FAnalysisVariant.ExtraTargets)) then begin
      OldFacilityState:=True;
      if FAnalysisVariant.MainGroup.FinishPoint=LastAnalysisVariant.MainGroup.FinishPoint then
        OldTarget:=True;
        
      FAnalysisVariant.FalseAlarmPeriod:=LastAnalysisVariant.FalseAlarmPeriod;
      if LastAnalysisVariant.AdversaryVariant=FAnalysisVariant.AdversaryVariant then begin
        OldAdversaryVariant:=True;
        FAnalysisVariant.BaseAnalysisVariant:=LastAnalysisVariant.BaseAnalysisVariant;
      end else begin
        OldAdversaryVariant:=False;
        FAnalysisVariant.BaseAnalysisVariant:=FAnalysisVariant as IDMElement;
      end;
    end else begin
      OldFacilityState:=False;
      OldAdversaryVariant:=False;
      FAnalysisVariant.BaseAnalysisVariant:=FAnalysisVariant as IDMElement;
    end;

    FacilityModelS.CurrentAnalysisVariantU:=FAnalysisVariant;

    N:=FacilityModel.Zones.Count+
       FacilityModel.Boundaries.Count;
    if FirstVariantFlag then
      N:=N+FacilityModel.GuardGroups.Count+
           FacilityModel.AdversaryGroups.Count;

    FStage:=0;
    while FStage<=MaxStage do begin
      if TerminateFlag then Break;
      Server.NextAnalysisStage(GetStageName, FStage, N);
//                    writeln(DebugFile, 'Step: ', GetStageName);
      if not ExecuteStage(FirstVariantFlag,
        OldFacilityState, OldAdversaryVariant, OldTarget, N) then Break;
      inc(FStage);
    end;
  end;
  if FStage>MaxStage then begin
    Server.NextAnalysisStage(GetStageName, FStage, 0);
    FacilityModel.MakeRecomendations;
  end else
    Server.NextAnalysisStage('', FStage, 0);
  except
    on E:Exception do begin
      Document.State:=Document.State and not dmfExecuting;
      Server.AnalysisError(E.Message);
    end;
  end
  finally
    RestoreZoneNodes(Self);
    Document.State:=Document.State and not dmfCommiting;
    Server.NextAnalysisStage(GetStageName, -1, -1);
    SetTerminateFlag(True);
//        CloseFile(DebugFile);
  end;
end;

function TSafeguardAnalyzer.GetStageName: string;
var
  S:string;
begin
  if FAnalysisVariant<>nil then
     S:='Вариант "'+(FAnalysisVariant as IDMElement).Name+'."'+#13+#13;
  case FStage of
  stageCheckFacilityModel:
    Result:=S+'Проверка корректности модели';
  stageClear:
    Result:=S+'Очистка результатов предыдущего анализа';
  stageChangeFacilityState:
    Result:=S+'Обновление данных модели';
  stageBuildPathGraph:
    Result:=S+'Построение графа маршрутов';
  stageBuildSoundResistanceTree:
    Result:=S+'Анализ распространения звука';
  stageBuildAdversaryFastTreeToTarget:
    Result:=S+'Поиск наиболее быстрых маршрутов нарушителей до цели';
  stageBuildAdversaryFastTreeFromStart:
    Result:=S+'Поиск наиболее быстрых маршрутов нарушителей от точки старота';
  stageBuildAdversaryFastBackPathTree:
    Result:=S+'Поиск наиболее быстрых маршрутов отхода нарушителей от цели';
  stageFindGuardFinishPoints:
    Result:=S+'Поиск маршрутов сил охраны к цели';
  stageBuildGuardPaths:
    Result:=S+'Поиск маршрутов сил охраны от мест дислокации';
  stageBuildSupportGroupPaths:
    Result:=S+'Поиск маршрутов групп огневого прикрытия нарушителей';
  stageCalcFalseAlarmPeriod:
    Result:=S+'Вычисление частоты ложных тревог';
  stageBuildAdversaryStealthTreeFromStart:
    Result:=S+'Поиск наиболее скрытных маршрутов нарушителей от точки старта';
{
  stageBuildAdversarySuccessTreeToTarget:
    Result:=S+'Поиск оптимальных маршрутов нарушителей до цели';
  stageBuildAdversarySuccessTreeFromStart:
    Result:=S+'Поиск оптимального маршрута нарушителей';
}
  stageBuildAdversaryRationalTreeToTarget:
    Result:=S+'Поиск рациональных маршрутов нарушителей до цели';
  stageBuildAdversaryRationalBackPathTree:
    Result:=S+'Поиск рациональных маршрутов отхода нарушителей от цели';
  stageCalcVulnerability:
    Result:=S+'Расчет поля показателей уязвимости';
  stageCalcSystemEfficiency:
    Result:=S+'Расчет обобщенных показателей уязвимости';
  stageBattleModel:
    Result:=S+'Моделирование боевого столкновения';
  stageFindCriticalPoints:
    Result:=S+'Поиск критических точек обнаружения';
  stageMakeRecomendations:
    Result:=S+'Определение приоритетов модернизации элементов СФЗ';
  else
    Result:='';
  end;
end;

destructor TSafeguardAnalyzer.Destroy;
begin
  inherited;
  FAnalysisVariant:=nil;
  FDisabledPathNodes:=nil;
  FGraphLayer:=nil;
  FOptimalPathLayer:=nil;
  FRationalPathLayer:=nil;
  FFastPathLayer:=nil;
  FStealthPathLayer:=nil;

  FPathGraphConnectors:=nil;
  FBaseGraph:=nil;
end;

procedure TSafeguardAnalyzer.ChangeFacilityState;
var
  BoundaryE, aZoneE, JumpE,
  GuardPostE, TVCameraE, VolumeSensorE, PatrolPathE, TargetE,
  LightDeviceE, SurfaceSensorE, PerimeterSensorE:IDMElement;
  j:integer;
  aFacilityModel:IFacilityModel;
begin
  aFacilityModel:=Get_Data as IFacilityModel;

  for j:=0 to aFacilityModel.Zones.Count-1 do begin
    aZoneE:=aFacilityModel.Zones.Item[j];
    aZoneE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.Boundaries.Count-1 do begin
    BoundaryE:=aFacilityModel.Boundaries.Item[j];
    BoundaryE.AfterLoading1;
    BoundaryE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.Jumps.Count-1 do begin
    JumpE:=aFacilityModel.Jumps.Item[j];
    JumpE.AfterLoading1;
    JumpE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.Targets.Count-1 do begin
    TargetE:=aFacilityModel.Targets.Item[j];
    TargetE.AfterLoading1;
    TargetE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.GuardPosts.Count-1 do begin
    GuardPostE:=aFacilityModel.GuardPosts.Item[j];
    GuardPostE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.TVCameras.Count-1 do begin
    TVCameraE:=aFacilityModel.TVCameras.Item[j];
    TVCameraE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.VolumeSensors.Count-1 do begin
    VolumeSensorE:=aFacilityModel.VolumeSensors.Item[j];
    VolumeSensorE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.SurfaceSensors.Count-1 do begin
    SurfaceSensorE:=aFacilityModel.SurfaceSensors.Item[j];
    SurfaceSensorE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.LightDevices.Count-1 do begin
    LightDeviceE:=aFacilityModel.LightDevices.Item[j];
    LightDeviceE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.PerimeterSensors.Count-1 do begin
    PerimeterSensorE:=aFacilityModel.PerimeterSensors.Item[j];
    PerimeterSensorE.AfterLoading2;
  end;

  for j:=0 to aFacilityModel.PatrolPaths.Count-1 do begin
    PatrolPathE:=aFacilityModel.PatrolPaths.Item[j];
    PatrolPathE.AfterLoading2;
  end;

end;

function TSafeguardAnalyzer.ExecuteStage(
        FirstVariantFlag, OldFacilityState, OldAdversaryVariant, OldTarget:boolean;
        var N:integer):boolean;
var
  m:integer;
  FacilityModel:IFacilityModel;
  FacilityState:IFacilityState;
  PrevAnalyzerE:IDMElement;
  PathNodes:IDMCollection;
  PathNode2:IPathNode2;
  AnalysisMode:integer;
begin
  AnalysisMode:=Get_Mode;
  Result:=True;
  FacilityModel:=Get_Data as IFacilityModel;
  FCompareDistanceFunc1:=False;
  case FStage of
  stageClear:
    begin
      PrevAnalyzerE:=Get_PrevAnalyzer as IDMelement;
      if PrevAnalyzerE<>nil then begin
        PrevAnalyzerE.Clear;
        Set_PrevAnalyzer(nil);
      end;

      if FirstVariantFlag then begin
        if AnalysisMode<>-1 then
          ClearTree
        else begin

          PathNodes:=Get_PathNodes;
          for m:=0 to PathNodes.Count-1 do begin
            PathNode2:=PathNodes.Item[m] as IPathNode2;
            PathNode2.ClearAllRecords;
          end;
        end;
      end;

      FAnalysisVariant.InitAnalysis;
    end;
  stageChangeFacilityState:
    if not OldFacilityState then
      ChangeFacilityState;
  stageBuildPathGraph:
    begin
      if FirstVariantFlag and
         (AnalysisMode<>-1) then
        BuildPathGraph(Self);

      ChangePathGraphState(FAnalysisVariant as IDMElement);

      FacilityState:=FBaseGraph as IFacilityState;

      N:=0;
      for m:=0 to FacilityModel.Zones.Count-1 do
        N:=N+(FacilityModel.Zones.Item[m] as IFacilityElement).PathArcs.Count;
      for m:=0 to FacilityModel.Boundaries.Count-1 do
        N:=N+(FacilityModel.Boundaries.Item[m] as IFacilityElement).PathArcs.Count;
      N:=N*Get_PathGraphs.Count;
    end;
  stageBuildSoundResistanceTree:
    begin
      if AnalysisMode=0 then begin    // прохождение звука не рассчитывается, если не требуется весь расчет
        Result:=False;
        Exit;
      end;
      if not OldFacilityState then
        BuildSoundResistanceTree;
    end;
  stageBuildAdversaryFastTreeToTarget:
    if not OldAdversaryVariant then begin
      ClearCash;
      BuildAdversaryFastTreeToTarget;
    end;
  stageBuildAdversaryFastTreeFromStart:
    begin
      if not FAnalysisVariant.UserDefinedResponceTime then begin
        if not OldTarget then begin
          BuildAdversaryFastTreeFromStart;
        end;
      end
    end;
  stageBuildAdversaryFastBackPathTree: //быстрого обратного пути
    if FAnalysisVariant.GuardStrategy=1 then
     BuildAdversaryFastBackPathTree;
  stageFindGuardFinishPoints:
    begin
      if not FAnalysisVariant.UserDefinedResponceTime then begin
        if not OldTarget then
          FindGuardFinishPoints;
      end
    end;
  stageBuildGuardPaths:
    begin
      ClearGuardModel;
      if AnalysisMode=0 then begin
        Result:=False;
        Exit;
      end;
      if not FAnalysisVariant.UserDefinedResponceTime then begin
        if not OldTarget then
          BuildGuardPaths;
        CalcResponceTime;
      end
    end;
  stageBuildSupportGroupPaths:
    if not OldAdversaryVariant then
      BuildSupportGroupPaths;
  stageCalcFalseAlarmPeriod:
    begin
      FacilityModel.CalcFalseAlarmPeriod(FAnalysisVariant.FacilityState);
      FAnalysisVariant.FalseAlarmPeriod:=FacilityModel.FalseAlarmPeriod;
    end;
  stageBuildAdversaryStealthTreeFromStart:
    begin
      if not OldAdversaryVariant then
        BuildAdversaryStealthTreeFromStart;
    end;
  stageBuildAdversaryRationalTreeToTarget:
    begin
      BuildAdversaryRationalTreeToTarget;
    end;
  stageBuildAdversaryRationalBackPathTree: //рационального обратного пути
    if FAnalysisVariant.GuardStrategy=1 then
      BuildAdversaryRationalBackPathTree;
  stageCalcVulnerability:
    CalcVulnerability;
  stageCalcSystemEfficiency:
      FAnalysisVariant.CalcSystemEfficiency;
  stageBattleModel:
      if FacilityModel.UseBattleModel then
        CalcBattleModel;
  stageFindCriticalPoints:
      if FacilityModel.FindCriticalPointsFlag then
        FindCriticalPoints;
  end;
end;

procedure TSafeguardAnalyzer.ClearTree;
var
  m, j:integer;
  FacilityModel:IFacilityModel;
  Document:IDMDocument;
  Server:IDataModelServer;
  Collection:IDMCollection;
  PathArcE, PathNodeE:IDMElement;
begin
  Document:=(Get_Data as IDataModel).Document as IDMDocument;
  Server:=Document.Server;
  FacilityModel:=Get_Data as IFacilityModel;
  (FDisabledPathNodes as IDMCollection2).Clear;

  while FPathGraphConnectors.Count>0 do begin
    PathArcE:=FPathGraphConnectors.Item[0];
    (FPathGraphConnectors as IDMCollection2).Remove(PathArcE)
  end;

  Collection:=Get_PathArcs;
  while Collection.Count>0 do begin
    PathArcE:=Collection.Item[0];
    PathArcE.Clear;
    (Collection as IDMCollection2).Delete(0)
  end;

  Collection:=Get_PathNodes;
  while Collection.Count>0 do begin
    PathNodeE:=Collection.Item[0];
    PathNodeE.Clear;
    (Collection as IDMCollection2).Delete(0)
  end;

  for j:=0 to Get_PathGraphs.Count-1 do begin
    for m:=0 to FacilityModel.Zones.Count-1 do
      ((FacilityModel.Zones.Item[m] as IFacilityElement).PathArcs as IDMCollection2).Clear;
    for m:=0 to FacilityModel.Targets.Count-1 do
    ((FacilityModel.Targets.Item[m] as IFacilityElement).PathArcs as IDMCollection2).Clear;
    for m:=0 to FacilityModel.Boundaries.Count-1 do
    ((FacilityModel.Boundaries.Item[m] as IFacilityElement).PathArcs as IDMCollection2).Clear;
    for m:=0 to FacilityModel.Jumps.Count-1 do
    ((FacilityModel.Jumps.Item[m] as IFacilityElement).PathArcs as IDMCollection2).Clear;
    for m:=0 to FacilityModel.Targets.Count-1 do
    ((FacilityModel.Targets.Item[m] as IFacilityElement).PathArcs as IDMCollection2).Clear;
  end;

  for m:=0 to FacilityModel.StartPoints.Count-1 do
    ((FacilityModel.StartPoints.Item[m] as IPathNodeArray).PathNodes as IDMCollection2).Clear;
  for m:=0 to FacilityModel.ControlDevices.Count-1 do
    ((FacilityModel.ControlDevices.Item[m] as IPathNodeArray).PathNodes as IDMCollection2).Clear;
  for m:=0 to FacilityModel.GuardPosts.Count-1 do
    ((FacilityModel.GuardPosts.Item[m] as IPathNodeArray).PathNodes as IDMCollection2).Clear;
  for m:=0 to FacilityModel.Targets.Count-1 do
    ((FacilityModel.Targets.Item[m] as IPathNodeArray).PathNodes as IDMCollection2).Clear;
  for m:=0 to FacilityModel.AdversaryGroups.Count-1 do
    (FacilityModel.AdversaryGroups.Item[m] as IWarriorGroup).ClearAllPaths;
  for m:=0 to FacilityModel.GuardGroups.Count-1 do
    (FacilityModel.GuardGroups.Item[m] as IWarriorGroup).ClearAllPaths;

end;

procedure TSafeguardAnalyzer.Initialize;
var
  PathLayers2:IDMCollection2;
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FDisabledPathNodes:=CreateCollection(-1, SelfE);
  DecimalSeparator:='.';
  PathLayers2:=Get_PathLayers as IDMCollection2;

  FGraphLayer:=PathLayers2.CreateElement(True);
  (FGraphLayer as ILayer).Color:=$808080;

  FOptimalPathLayer:=PathLayers2.CreateElement(True);
  (FOptimalPathLayer as ILayer).Color:=$FF00FF;
  (FOptimalPathLayer as ILayer).Style:=2;

  FRationalPathLayer:=PathLayers2.CreateElement(True);
  (FRationalPathLayer as ILayer).Color:=$880088;
  (FRationalPathLayer as ILayer).Style:=2;

  FFastPathLayer:=PathLayers2.CreateElement(True);
  (FFastPathLayer as ILayer).Color:=$0000FF;
  (FFastPathLayer as ILayer).Style:=2;

  FStealthPathLayer:=PathLayers2.CreateElement(True);
  (FStealthPathLayer as ILayer).Color:=$FF0000;
  (FStealthPathLayer as ILayer).Style:=2;

  FPathGraphConnectors:=CreateCollection(-1, SelfE);
end;


procedure TSafeguardAnalyzer.MakeCollections;
begin
  inherited;
  AddClass(TPathNodes);
  AddClass(TPathArcs);
  AddClass(TPaths);
  AddClass(TPathLayers);
  AddClass(TPathGraphs);
  AddClass(TRoadParts);
  AddClass(TVerticalWays);
end;

function TSafeguardAnalyzer.Get_PathArcs: IDMCollection;
begin
  Result:=Collection[_PathArc]
end;

function TSafeguardAnalyzer.Get_RoadParts: IDMCollection;
begin
  Result:=Collection[_RoadPart]
end;

function TSafeguardAnalyzer.Get_PathNodes: IDMCollection;
begin
  Result:=Collection[_PathNode]
end;

function TSafeguardAnalyzer.Get_Paths: IDMCollection;
begin
  Result:=Collection[_Path]
end;

function TSafeguardAnalyzer.Get_PathLayers: IDMCollection;
begin
  Result:=Collection[_PathLayer]
end;

function TSafeguardAnalyzer.Get_PathGraphs: IDMCollection;
begin
  Result:=Collection[_PathGraph]
end;

procedure TSafeguardAnalyzer.ClearGuardModel;
var
  GuardArrivals2, AlarmGroups2:IDMCollection2;
  FacilityModel:IFacilityModel;
  GuardModel:IGuardModel;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  GuardModel:=FacilityModel as IGuardModel;

  AlarmGroups2:=GuardModel.AlarmGroups as IDMCollection2;
  AlarmGroups2.Clear;

  GuardArrivals2:=GuardModel.GuardArrivals as IDMCollection2;
  GuardArrivals2.Clear;
end;

procedure TSafeguardAnalyzer.BuildGuardPaths;
var
  j, m:integer;
  GroupW:IWarriorGroup;
  GroupG:IGuardGroup;
  GroupG2:IGuardGroup2;
  StartNodeE, FinishNodeE,
  GroupE, StartPointE, ObserverE:IDMElement;
  Observer:IObserver;
  StartNode, FinishNode:IPathNode;
  GuardVariant:IGuardVariant;
  PathNodeArray:IPathNodeArray;
  FacilityModel:IFacilityModel;
  GuardArrivals, AlarmGroups:IDMCollection;
  GuardArrivals2, AlarmGroups2:IDMCollection2;
  Sorter:ISorter;
  PathNode2:IPathNode2;
  BoundaryFE:IFacilityElement;
  PathArcL:ILine;
  GuardModel:IGuardModel;
  ResponceTimeDispersionRatio:double;
  GuardPostDDE:IDistantDetectionElement;
  Boundary:IBoundary;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  GuardModel:=FacilityModel as IGuardModel;
  AlarmGroups:=GuardModel.AlarmGroups;
  AlarmGroups2:=AlarmGroups as IDMCollection2;
  GuardArrivals:=GuardModel.GuardArrivals;
  GuardArrivals2:=GuardArrivals as IDMCollection2;
  GuardArrivals2.Clear;
  if FAnalysisVariant.UserDefinedResponceTimeDispersionRatio then
    ResponceTimeDispersionRatio:=FAnalysisVariant.ResponceTimeDispersionRatio
  else
    ResponceTimeDispersionRatio:=FacilityModel.ResponceTimeDispersionRatio;

  GuardVariant:=FAnalysisVariant.GuardVariant as IGuardVariant;
  for j:=0 to GuardVariant.GuardGroups.Count-1 do begin

    if TerminateFlag then Exit;

    GroupE:=GuardVariant.GuardGroups.Item[j];
    GroupW:=GroupE as IWarriorGroup;
    GroupG:=GroupE as IGuardGroup;
    GroupG2:=GroupE as IGuardGroup2;

    StartPointE:=GroupW.StartPoint;

    if ((GroupW.Task=gtInterruptOnDetectionPoint) or
        (GroupW.Task=gtInterruptOnTarget) or
        (GroupW.Task=gtInterruptOnExit))and
       (StartPointE<>nil) then begin
      if not GroupG.UserDefinedArrivalTime then begin
        FPathStage:=wpsFastEntry;
        if StartPointE.Parent.ClassID=_Zone then begin
          PathNodeArray:=StartPointE as IPathNodeArray;
          if PathNodeArray=nil then
            StartNode:=nil
          else begin
            if PathNodeArray.PathNodes.Count>0 then
              StartNode:=PathNodeArray.PathNodes.Item[0] as IPathNode
            else
              StartNode:=nil;
          end;
        end else begin
          BoundaryFE:=StartPointE.Parent.Parent as IFacilityElement;
          if BoundaryFE.PathArcs.Count=0 then
             Continue;
          PathArcL:=BoundaryFE.PathArcs.Item[0] as ILine;
          StartNode:=PathArcL.C0 as IPathNode;
        end;
        PathNodeArray:=GroupW.FinishPoint as IPathNodeArray;
        if (PathNodeArray=nil) then
          PathNodeArray:=FAnalysisVariant.MainGroup.FinishPoint as IPathNodeArray;

        FinishNode:=GroupG2.LastNode as IPathNode;

        StartNodeE:=StartNode as IDMElement;
        FinishNodeE:=FinishNode as IDMElement;

        if (StartNode<>nil) and
           (FinishNode<>StartNode) then begin
          FCurrentWarriorGroup:=GroupW;
          FCalcMode:=admGet_DelayTimeFromStart;
          FTreeMode:=tmFromRoot;

          for m:=0 to Get_PathNodes.Count-1 do begin
            PathNode2:=Get_PathNodes.Item[m] as IPathNode2;
            PathNode2.ResetBestDistance(False);
          end;

          (FDisabledPathNodes as IDMCollection2).Clear;

          BuildTree(StartNode);

          if GroupW.Task=gtInterruptOnDetectionPoint then begin
            AlarmGroups2.Add(GroupE);
            for m:=0 to Get_PathNodes.Count-1 do
              (Get_PathNodes.Item[m] as IPathNode2).StoreRecord(admGet_DelayTimeFromStart, GroupE);
            GroupW.ArrivalTime:=InfinitValue;
            GroupW.ArrivalTimeDispersion:=InfinitValue;
          end else begin // if GroupW.Task<>gtInterruptOnDetectionPoint
            if FinishNode<>nil then begin
              if FinishNode.BestDistance>=InfinitValue then begin
                GroupW.ArrivalTime:=InfinitValue;
                GroupW.ArrivalTimeDispersion:=InfinitValue
              end else begin
                GroupW.ArrivalTime:=FinishNode.BestDistance+GroupG.StartDelay+GroupG2.TimeLimit;
                GroupW.ArrivalTimeDispersion:=(FinishNode as IPathNode2).DistanceFunc+
                              sqr(ResponceTimeDispersionRatio*GroupG.StartDelay);
                GuardArrivals2.Add(GroupE)
              end;
            end else begin
              GroupW.ArrivalTime:=-InfinitValue;
              GroupW.ArrivalTimeDispersion:=-InfinitValue;
            end;
          end; // if GroupW.Task<>gtInterruptOnDetectionPoint

        end else begin // if (StartNode=nil) or ...
          GroupW.ArrivalTime:=InfinitValue;
          GroupW.ArrivalTimeDispersion:=InfinitValue;
        end; // if (StartNode=nil) or ...
      end else begin //if GroupG.UserDefinedArrivalTime
        GroupW.ArrivalTimeDispersion:=
                           sqr(ResponceTimeDispersionRatio*GroupW.ArrivalTime);
        GuardArrivals2.Add(GroupE)
      end;
    end // (GroupW.Task=gtInterruptOnDetectionPoint) or...
    else if (GroupW.Task=gtStayOnPost) then begin
      GuardPostDDE:= GroupW.StartPoint as IDistantDetectionElement;
      for m:=0 to GuardPostDDE.Observers.Count-1 do begin
        ObserverE:=GuardPostDDE.Observers.Item[m];
        Observer:=ObserverE as IObserver;
        if (Observer.ObservationKind=obsGuardPost) and
           (ObserverE.Parent.QueryInterface(IBoundary, Boundary)=0) then begin
          Boundary.BlockGroup:=GroupW as IDMElement;
          GroupW.ArrivalTime:=GroupG.StartDelay;
        end;
      end;
    end;
  end; // for j:=0 to GuardVariant.GuardGroups.Count-1

  Sorter:=TGuardArrivalTimeSorter.Create(nil) as ISorter;
  GuardArrivals2.Sort(Sorter);
end; // BuildGuardPaths

function TSafeguardAnalyzer.GetPathNodeForGraph(
    const SafeguardElementA:IPathNodeArray;
    const PathGraph:IDMElement):IPathNode;
var
  aPathNode:ICoordNode;
  j:integer;
begin
  Result:=nil;
  if SafeguardElementA=nil then Exit;
  aPathNode:=nil;
  j:=0;
  while j<SafeguardElementA.PathNodes.Count do begin
    aPathNode:=SafeguardElementA.PathNodes.Item[j] as ICoordNode;
    if aPathNode.Lines.Count<>0 then begin
      if (aPathNode.Lines.Item[0] as IPathArc).FacilityState=PathGraph then
        Break
      else
        inc(j)
    end else
      inc(j);
  end;
  if j<SafeguardElementA.PathNodes.Count then
    Result:=aPathNode as IPathNode
end;

procedure TSafeguardAnalyzer.BuildAdversaryFastTreeToTarget;
var
  StartNode, FinishNode:IPathNode;
  j:integer;
  SafeguardElementA:IPathNodeArray;
  PathNode2:IPathNode2;
begin
  if TerminateFlag then Exit;

  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  FCalcMode:=admGet_DelayTimeToTarget;
  FTreeMode:=tmToRoot;

  FPathStage:=wpsFastEntry;

  SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);
  SafeguardElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
  FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);
  (FDisabledPathNodes as IDMCollection2).Clear;
  if StartNode<>nil then
    (FDisabledPathNodes as IDMCollection2).Add(StartNode as IDMElement);

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode2:=Get_PathNodes.Item[j] as IPathNode2;
    PathNode2.ResetBestDistance(False);
  end;

  if FinishNode<>nil then
    BuildTree(FinishNode);

  if FinishNode=nil then
    Terminate('Не задана цель нарушителей')
  else
  if StartNode.BestNextArc=nil then
    Terminate('Проникнуть к цели при заданных условиях невозможно');

  for j:=0 to Get_PathNodes.Count-1 do
    (Get_PathNodes.Item[j] as IPathNode2).StoreRecord(admGet_DelayTimeToTarget,
                                                   FCurrentWarriorGroup as IDMElement)
end;

procedure TSafeguardAnalyzer.BuildAdversaryFastTreeFromStart;
var
  StartNode, FinishNode:IPathNode;
  j:integer;
  SafeguardElementA:IPathNodeArray;
  PathNode:IPathNode;
  PathNode2:IPathNode2;
begin
  if TerminateFlag then Exit;

  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  FCalcMode:=admGet_DelayTimeFromStart;
  FTreeMode:=tmFromRoot;

  FPathStage:=wpsFastEntry;

  SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  SafeguardElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
  FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  (FDisabledPathNodes as IDMCollection2).Clear;
  if FinishNode<>nil then
    (FDisabledPathNodes as IDMCollection2).Add(FinishNode as IDMElement);

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode2:=Get_PathNodes.Item[j] as IPathNode2;
    PathNode2.ResetBestDistance(False);
  end;

  if StartNode<>nil then
    BuildTree(StartNode)
  else
    Terminate('Проникнуть на территорию объекта при заданных ограничениях невозможно');

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode2:=Get_PathNodes.Item[j] as IPathNode2;
    PathNode2.StoreRecord(admGet_DelayTimeFromStart, FCurrentWarriorGroup as IDMElement);
    PathNode:=PathNode2 as IPathNode;
  end;
end;

procedure TSafeguardAnalyzer.BuildSoundResistanceTree;
var
  j, m, n:integer;
  StartNode:IPathNode;
  GuardVariant:IGuardVariant;
  SafeguardElement:ISafeguardElement;
  SafeguardElementA:IPathNodeArray;
  FacilityModel:IFacilityModel;
  Boundary2:IBoundary2;
  StartPoints:TList;
  StartPointE:IDMElement;
  PathNode2:IPathNode2;

  procedure DoCalcSound(const Boundary2:IBoundary2;
                        OnlyInnerGuard:boolean);
  var
    k, j, m:integer;
    SoundResistanceSum,  L, SoundResistance:double;
    BoundaryE, ZoneE:IDMElement;
    BoundaryF:IFacilityElement;
    Boundary:IBoundary;
    BoundaryLayerSU:ISafeguardUnit;
    SafeguardElementE:IDMElement;

    PathArcL:ILine;
    PathArc:IPathArc;
    PathNode0, PathNode1:IPathNode;
    PathNode02, PathNode12:IPathNode2;

    function SoundInZone(const ZoneE:IDMElement):double;
    var
      Zone, aZone:IZone;
      Volume, aVolume:IVolume;
      j:integer;
      aAreaE:IDMElement;
      aArea:IArea;
      aSoundResistance:double;
      aBoundaryFB:IFieldBarrier;
    begin
      Result:=InfinitValue;
      if ZoneE=nil then Exit;
      Zone:=ZoneE as IZone;
      if Zone.PersonalPresence=2 then begin // постоянно
        Result:=0;
        Exit;
      end;
      Volume:=ZoneE.SpatialElement as IVolume;
      for j:=0 to Volume.Areas.Count-1 do begin
        aAreaE:=Volume.Areas.Item[j];
        aArea:=aAreaE as IArea;
        aVolume:=aArea.Volume0;
        if aVolume=Volume then
          aVolume:=aArea.Volume1;
        if aVolume<>nil then begin
          aZone:=(aVolume as IDMElement).Ref as IZone;
          if aZone.PersonalPresence=2 then begin // постоянно
            aBoundaryFB:=aAreaE.Ref as IFieldBarrier;
            aSoundResistance:=aBoundaryFB.SoundResistance;
            if Result>aSoundResistance then
              Result:=aSoundResistance;
          end;
        end;
      end;
    end;
  begin
    BoundaryE:=Boundary2 as IDMElement;
    Boundary:=BoundaryE as IBoundary;
    if not OnlyInnerGuard then begin
      ZoneE:=Boundary.Zone0;
      Boundary2.NearestSoundResistanceSum0:=SoundInZone(ZoneE);
      ZoneE:=Boundary.Zone1;
      Boundary2.NearestSoundResistanceSum1:=SoundInZone(ZoneE);
    end;

    if BoundaryE.Ref.Parent.ID=btEntryPoint then begin
      // проверяем наличие контролеров непосредственно на рубеже
      for j:=0 to Boundary.BoundaryLayers.Count-1 do begin
        BoundaryLayerSU:=Boundary.BoundaryLayers.Item[j] as ISafeguardUnit;
        m:=0;
        while m<BoundaryLayerSU.SafeguardElements.Count do begin
          SafeguardElementE:=BoundaryLayerSU.SafeguardElements.Item[m];
          if (SafeguardElementE.ClassID=_GuardPost) and
             (SafeguardElementE as ISafeguardElement).InWorkingState then begin
            Break
          end else
            inc(m)
        end;
        if m<BoundaryLayerSU.SafeguardElements.Count then begin
          Boundary2.SoundResistanceSum0:=0;  // контролер на посту все слышит
          Boundary2.SoundResistanceSum1:=0;
          Exit;
        end;
      end;
    end;

    if OnlyInnerGuard then Exit;

    BoundaryF:=Boundary2 as IFacilityElement;
    for k:=0 to BoundaryF.PathArcs.Count-1 do begin
      PathArcL:=BoundaryF.PathArcs.Item[k] as ILine;
      PathArc:=PathArcL as IPathArc;
      if PathArc.FacilityState=FBaseGraph then begin

        PathNode0:=PathArcL.C0 as IPathNode;
        PathNode02:=PathNode0 as IPathNode2;
        L:=PathNode02.DistanceFunc/100;
        if L<>0 then
          SoundResistance:=20*log10(L)
        else
          SoundResistance:=0;
        SoundResistanceSum:=PathNode0.BestDistance+SoundResistance;
        if Boundary2.SoundResistanceSum0>SoundResistanceSum then
          Boundary2.SoundResistanceSum0:=SoundResistanceSum;

        PathNode1:=PathArcL.C1 as IPathNode;
        PathNode12:=PathNode1 as IPathNode2;
        L:=PathNode12.DistanceFunc/100;
        if L<>0 then
          SoundResistance:=20*log10(L)
        else
          SoundResistance:=0;
        SoundResistanceSum:=PathNode1.BestDistance+SoundResistance;
        if Boundary2.SoundResistanceSum1>SoundResistanceSum then
          Boundary2.SoundResistanceSum1:=SoundResistanceSum;
      end;
    end;
  end;

begin
  StartPoints:=TList.Create;

  GuardVariant:=FAnalysisVariant.GuardVariant as IGuardVariant;
  FacilityModel:=Get_Data as IFacilityModel;

  for m:=0 to FacilityModel.Boundaries.Count-1 do begin
    Boundary2:=FacilityModel.Boundaries.Item[m] as IBoundary2;
    Boundary2.ResetSoundResistance;
  end;

  for m:=0 to FacilityModel.Targets.Count-1 do begin
    Boundary2:=FacilityModel.Targets.Item[m] as IBoundary2;
    Boundary2.ResetSoundResistance;
  end;

  for m:=0 to FacilityModel.Jumps.Count-1 do begin
    Boundary2:=FacilityModel.Jumps.Item[m] as IBoundary2;
    Boundary2.ResetSoundResistance;
  end;

  for j:=0 to FacilityModel.GuardPosts.Count-1 do begin
    StartPointE:=FacilityModel.GuardPosts.Item[j];
    SafeguardElement:=StartPointE as ISafeguardElement;
    if SafeguardElement.InWorkingState then
      StartPoints.Add(pointer(StartPointE));
  end;

  for j:=0 to StartPoints.Count-1 do begin
    if TerminateFlag then begin
      StartPoints.Free;
      Exit;
    end;

    FPathStage:=-1;

    SafeguardElementA:=IDMElement(StartPoints[j]) as IPathNodeArray;
    if SafeguardElement=nil then
      StartNode:=nil
    else begin
      if SafeguardElementA.PathNodes.Count>0 then begin
        n:=SafeguardElementA.PathNodes.Count-1;
        StartNode:=SafeguardElementA.PathNodes.Item[n] as IPathNode;
      end else
        StartNode:=nil
    end;

    for m:=0 to Get_PathNodes.Count-1 do begin
      PathNode2:=Get_PathNodes.Item[m] as IPathNode2;
      PathNode2.ResetBestDistance(False);
    end;

    if (StartNode<>nil) then begin
//      FCurrentWarriorGroup:=GroupW;
      FCurrentWarriorGroup:=nil;
      FCalcMode:=admGet_SoundResistance;
      FTreeMode:=tmToRoot;

     (FDisabledPathNodes as IDMCollection2).Clear;
      if StartNode<>nil then
        BuildTree(StartNode);
    end;

    for m:=0 to FacilityModel.Boundaries.Count-1 do begin
      Boundary2:=FacilityModel.Boundaries.Item[m] as IBoundary2;
      DoCalcSound(Boundary2, False);
    end;

    for m:=0 to FacilityModel.Targets.Count-1 do begin
      Boundary2:=FacilityModel.Targets.Item[m] as IBoundary2;
      DoCalcSound(Boundary2, False);
    end;

    for m:=0 to FacilityModel.Jumps.Count-1 do begin
      Boundary2:=FacilityModel.Jumps.Item[m] as IBoundary2;
      DoCalcSound(Boundary2, False);
    end;

  end; //for j:=0 to StartPoints.Count-1

  if StartPoints.Count=0 then begin
// проверяем только наличие контролеров на рубежах
    for m:=0 to FacilityModel.Boundaries.Count-1 do begin
      Boundary2:=FacilityModel.Boundaries.Item[m] as IBoundary2;
      DoCalcSound(Boundary2, True);
    end;
  end;

  StartPoints.Free;
end;

procedure TSafeguardAnalyzer.BuildAdversaryStealthTreeFromStart;
var
  StartNode, FinishNode:IPathNode;
  j:integer;
  SafeguardElementA:IPathNodeArray;
  PathNode2:IPathNode2;
begin
  if TerminateFlag then Exit;

  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  FCalcMode:=admGet_NoDetectionProbability;
  FTreeMode:=tmFromRoot;

  FPathStage:=wpsStealthEntry;

  SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  SafeguardElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
  FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  (FDisabledPathNodes as IDMCollection2).Clear;
  if FinishNode<>nil then
    (FDisabledPathNodes as IDMCollection2).Add(FinishNode as IDMElement);

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode2:=Get_PathNodes.Item[j] as IPathNode2;
    PathNode2.ResetBestDistance(False);
  end;

  if StartNode<>nil then
    BuildTree(StartNode)
  else
    Terminate('Проникнуть на территорию объекта при заданных ограничениях невозможно');

  for j:=0 to Get_PathNodes.Count-1 do
    (Get_PathNodes.Item[j] as IPathNode2).StoreRecord(admGet_NoDetectionProbability,
                                                   FCurrentWarriorGroup as IDMElement);
end;
(*
procedure TSafeguardAnalyzer.BuildAdversarySuccessTreeToTarget;
var
  StartNode, FinishNode:IPathNode;
  j:integer;
  SafeguardElementA:IPathNodeArray;
begin
  if TerminateFlag then Exit;

  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  FCalcMode:=admGet_SuccessProbabilityToTarget;
  FTreeMode:=tmToRoot;

  FPathStage:=wpsStealthEntry;

  FResponceTime:=FAnalysisVariant.ResponceTime;
  FResponceTimeDispersion:=FAnalysisVariant.ResponceTimeDispersion;

  SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  SafeguardElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
  FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  (FDisabledPathNodes as IDMCollection2).Clear;
  if StartNode<>nil then
    (FDisabledPathNodes as IDMCollection2).Add(StartNode as IDMElement);

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode:=Get_PathNodes.Item[j] as IPathNode;
    PathNode.ResetBestDistance(False);
  end;


  if FinishNode<>nil then
    BuildTree(FinishNode);

  for j:=0 to Get_PathNodes.Count-1 do
    (Get_PathNodes.Item[j] as IPathNode).StoreRecord(admGet_SuccessProbabilityToTarget,
                                            FCurrentWarriorGroup as IDMElement)
end;

procedure TSafeguardAnalyzer.BuildAdversarySuccessTreeFromStart;
var
  StartNode, FinishNode:IPathNode;
  j:integer;
  SafeguardElementA:IPathNodeArray;
begin
  if TerminateFlag then Exit;

  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  FCalcMode:=admGet_SuccessProbabilityFromStart;
  FTreeMode:=tmFromRoot;

{
  if FAnalysisVariant.GuardStrategy=0 then
    FPathStage:=wpsStealthExit
  else
}
  FPathStage:=wpsStealthEntry;

  FResponceTime:=FAnalysisVariant.ResponceTime;
  FResponceTimeDispersion:=FAnalysisVariant.ResponceTimeDispersion;

  SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

//  if FAnalysisVariant.GuardStrategy=0 then begin
    SafeguardElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
    FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);
{
  end else begin
    SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
    FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBackPathGraph)
  end;
}
  (FDisabledPathNodes as IDMCollection2).Clear;
  if StartNode<>nil then
    (FDisabledPathNodes as IDMCollection2).Add(StartNode as IDMElement);

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode:=Get_PathNodes.Item[j] as IPathNode;
    PathNode.ResetBestDistance(False);
  end;

  if StartNode<>nil then
    BuildTree(StartNode);

  for j:=0 to Get_PathNodes.Count-1 do
    (Get_PathNodes.Item[j] as IPathNode).StoreRecord(admGet_SuccessProbabilityFromStart,
                                            FCurrentWarriorGroup as IDMElement)
end;
*)

procedure TSafeguardAnalyzer.BuildSupportGroupPaths;
var
  j, m:integer;
  GroupW:IWarriorGroup;
  GroupE, FastPathE:IDMElement;
  StartNode, FinishNode:IPathNode;
  AdversaryVariant:IAdversaryVariant;
  SafeguardElementA:IPathNodeArray;
  FastPath:IWarriorPath;
  PathNode2:IPathNode2;
begin
  AdversaryVariant:=FAnalysisVariant.AdversaryVariant as IAdversaryVariant;
  FPathStage:=wpsFastEntry;

  for j:=0 to AdversaryVariant.AdversaryGroups.Count-1 do begin
    if TerminateFlag then Exit;

    GroupE:=AdversaryVariant.AdversaryGroups.Item[j];
    GroupW:=GroupE as IWarriorGroup;
    if GroupW.Task=2 then begin

      SafeguardElementA:=GroupW.StartPoint as IPathNodeArray;
      if SafeguardElementA<>nil then
        StartNode:=SafeguardElementA.PathNodes.Item[0] as IPathNode
      else
        StartNode:=nil;
      SafeguardElementA:=GroupW.FinishPoint as IPathNodeArray;
      if SafeguardElementA<>nil then
        FinishNode:=SafeguardElementA.PathNodes.Item[0] as IPathNode
      else
        FinishNode:=nil;

      for m:=0 to Get_PathNodes.Count-1 do begin
        PathNode2:=Get_PathNodes.Item[m] as IPathNode2;
        PathNode2.ResetBestDistance(False);
      end;

      if (StartNode<>nil) and
         (FinishNode<>nil) and
         (FinishNode<>StartNode) then begin
        FCurrentWarriorGroup:=GroupW;
        FCalcMode:=admGet_DelayTimeToTarget;
        FTreeMode:=tmToRoot;

        (FDisabledPathNodes as IDMCollection2).Clear;
        if StartNode<>nil then begin
          BuildTree(StartNode);
          for m:=0 to Get_PathNodes.Count-1 do
            (Get_PathNodes.Item[m] as IPathNode2).StoreRecord(admGet_DelayTimeToTarget,
                                                   FCurrentWarriorGroup as IDMElement)
        end;

        if FinishNode.BestDistance>InfinitValue then begin begin
          GroupW.ArrivalTime:=InfinitValue;
          GroupW.ArrivalTimeDispersion:=InfinitValue;
        end end else begin
          GroupW.ArrivalTime:=FinishNode.BestDistance;
          GroupW.ArrivalTimeDispersion:=(FinishNode as IPathNode2).DistanceFunc;
          FastPathE:=nil;
          MakePathFrom(FinishNode as IDMElement, True,
                            pkFastPath, False, FastPathE);
          FastPathE.Name:=GroupE.Name;
          FastPath:=FastPathE as IWarriorPath;
          GroupW.StorePath(FastPath);
        end;



      end else begin
        GroupW.ArrivalTime:=InfinitValue;
        GroupW.ArrivalTimeDispersion:=InfinitValue;
      end;

    end;
  end;
end;

procedure TSafeguardAnalyzer.CalcVulnerability;
var
  j, m:integer;
  BoundaryE:IDMElement;
  Zone:IZone;
  ZoneF:IFacilityElement;
  Node, NodeR, StartNode:ICoordNode;
  FinishNode:IPathNode;
  SpatialModel2:ISpatialModel2;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  StartElementA, FinishElementA:IPathNodeArray;
  BoundaryPathE, BoundaryPath_RE, BoundaryPath_BE:IDMElement;
  BoundaryPath_R, BoundaryPath_B, BoundaryPath:IWarriorPath;
  BoundaryV:IVulnerabilityData;
  aLineE:IDMElement;
  Polyline:IPolyline;
  BoundaryList:TList;
  OldFacilityStateE:IDMElement;
  InitialPathElementE, WarriorPathElementE: IDMElement;
  WarriorPaths2, theWarriorPaths2:IDMCollection2;
  Sorter:ISorter;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  SpatialModel2:=FacilityModel as ISpatialModel2;
  FacilityModelS:=FacilityModel as IFMState;
  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  WarriorPaths2:=FacilityModel.WarriorPaths as IDMCollection2;
  OldFacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  try
  FacilityModelS.CurrentFacilityStateU:=FBaseGraph;

  for j:=0 to FacilityModel.Zones.Count-1 do begin
    Zone:=FacilityModel.Zones.Item[j] as IZone;
    if Zone.Zones.Count=0 then begin
      ZoneF:=Zone as IFacilityElement;
      ZoneF.CalcVulnerability;
    end;
  end;

  for j:=0 to FacilityModel.Boundaries.Count-1 do
    (FacilityModel.Boundaries.Item[j] as IFacilityElement).CalcVulnerability;
  for j:=0 to FacilityModel.Jumps.Count-1 do
    (FacilityModel.Jumps.Item[j] as IFacilityElement).CalcVulnerability;
  for j:=0 to FacilityModel.Targets.Count-1 do
    (FacilityModel.Targets.Item[j] as IFacilityElement).CalcVulnerability;
//  for j:=0 to FacilityModel.ControlDevices.Count-1 do
//    (FacilityModel.ControlDevices.Item[j] as IFacilityElement).CalcVulnerability;

  StartElementA:=FAnalysisVariant.MainGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(StartElementA, FBaseGraph) as ICoordNode;

  FinishElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
  if FinishElementA=nil then Exit;
  FinishNode:=GetPathNodeForGraph(FinishElementA, FBaseGraph);

  BoundaryList:=TList.Create;
  for j:=0 to StartNode.Lines.Count-1 do begin
    Node:=(StartNode.Lines.Item[j] as ILine).C0;
    aLineE:=Node.Lines.Item[0];
    BoundaryE:=aLineE.Ref;
    if BoundaryList.IndexOf(pointer(BoundaryE))=-1 then
      BoundaryList.Add(pointer(BoundaryE));
  end;


  for j:=0 to BoundaryList.Count-1 do begin
    BoundaryE:=IDMElement(BoundaryList[j]);
    if BoundaryE.ID=562 then
      XXX:=0;
    BoundaryV:=BoundaryE as IVulnerabilityData;

    if FAnalysisVariant.GuardStrategy<>0 then begin
      if FinishNode<>nil then begin
        BoundaryPath_BE:=nil;

        MakePathFrom(FinishNode as IDMElement, True,
                     pkRationalBackPath, True, BoundaryPath_BE);

        BoundaryPath_B:=BoundaryPath_BE as IWarriorPath;
        if BoundaryPath_B<>nil then begin
          BoundaryPath_B.Build(tmToRoot, True, False, nil);

          BuildBackPath(StartNode as IDMElement);
          BoundaryPath_B.DoAnalysis(nil, False); // состояние средств охраны должно быть уже изменено
          ClearBackPathGraphState;
          InitialPathElementE:=
             BoundaryPath_B.WarriorPathElements.Item[0];
        end;
      end else begin
        BoundaryPath_BE:=nil;
        BoundaryPath_B:=nil;
        InitialPathElementE:=nil;
      end;
    end else begin
      BoundaryPath_BE:=nil;
      BoundaryPath_B:=nil;
      InitialPathElementE:=nil;
    end;

    NodeR:=BoundaryV.RationalProbabilityToTarget_NextNode as ICoordNode;
    if NodeR<>nil then begin
      BoundaryPath_RE:=nil;
      MakePathFrom(NodeR as IDMElement, False,
                           pkRationalPath, True, BoundaryPath_RE);
      BoundaryPath_R:=BoundaryPath_RE as IWarriorPath;
      if BoundaryPath_R<>nil then begin
        if FAnalysisVariant.GuardStrategy=0 then begin
          BoundaryPath_R.Build(tmToRoot, False, True, nil);
          BoundaryPath_R.DoAnalysis(nil, True);
        end else begin
          BoundaryPath_R.Build(tmToRoot, False, True, nil);

          while BoundaryPath_B.WarriorPathElements.Count>0 do begin
            WarriorPathElementE:=BoundaryPath_B.WarriorPathElements.Item[0];
            WarriorPathElementE.Parent:=BoundaryPath_RE;
          end;

          BoundaryPath_R.DoAnalysis(InitialPathElementE, True);

        end;
      end;

    end else begin
      BoundaryPath_R:=nil;
    end;

    if BoundaryPath_BE<>nil then begin
      BoundaryPath_BE.Clear;
      WarriorPaths2.Remove(BoundaryPath_BE);
    end;

    if BoundaryPath_RE<>nil then begin
      BoundaryPath_RE.Parent:=FAnalysisVariant as IDMElement;
      BoundaryPath_RE.Name:=BoundaryE.Name;
    end;
  end; //for j:=0 to BoundaryList.Count-1

  theWarriorPaths2:=FAnalysisVariant.WarriorPaths as IDMCollection2;
  Sorter:=TWarriorPathSorter.Create(nil) as ISorter;

  theWarriorPaths2.Sort(Sorter);

  while FAnalysisVariant.WarriorPaths.Count>FAnalysisVariant.MaxPathCount do begin
    BoundaryPathE:=FAnalysisVariant.WarriorPaths.Item[FAnalysisVariant.WarriorPaths.Count-1];
    BoundaryPathE.Clear;
    WarriorPaths2.Remove(BoundaryPathE);
  end;

  if FAnalysisVariant.WarriorPaths.Count<>0 then begin
    BoundaryPathE:=FAnalysisVariant.WarriorPaths.Item[0];
    Polyline:=BoundaryPathE.SpatialElement as IPolyline;
    if Polyline<>nil then
      for m:=0 to Polyline.Lines.Count-1 do
        Polyline.Lines.Item[m].Parent:=FOptimalPathLayer;
  end;
  for j:=0 to FAnalysisVariant.WarriorPaths.Count-1 do begin
    BoundaryPathE:=FAnalysisVariant.WarriorPaths.Item[j];
    BoundaryPath:=BoundaryPathE as IWarriorPath;
    BoundaryPath.GuardTacticFlag:=True;
    BoundaryPath.Analysis;
  end;

  finally
    FacilityModelS.CurrentFacilityStateU:=OldFacilityStateE;
  end;
end;

procedure TSafeguardAnalyzer.ChangePathGraphState(const AnalysisVariantE:IDMElement);
var
  AnalysisVariant:IAnalysisVariant;
  j, m, k, N, R, i:integer;
  FacilityModel:IFacilityModel;
  FacilityState, PathGraphF:IFacilityState;
  PathGraph, NextPathGraph:IPathGraph;
  FacilityStateE, ExtraTargetE, TargetE, ElementStateE,
  ExtraSubStateE, NextExtraSubStateE,
  NewExtraTargetStateE, ExtraTargetStateE,
  PathGraphE, NextPathGraphE:IDMElement;
  SafeguardElementStates2:IDMCollection2;
  ExtraSubState, NextExtraSubState:IFacilitySubState;
  PathGraphs:IDMCollection;
  Difference, PathGraphCount:integer;
  PathArc:IPathArc2;
  ElementStateS:ISafeguardElementState;
  ElementType:ISafeguardElementType;
  Element:IDMElement;
  ElementStateCount, ExtraTargetCount:integer;
begin
  PathGraphs:=Get_PathGraphs;
  if PathGraphs.Count=0 then Exit;
  FBaseGraph:=PathGraphs.Item[0];

  AnalysisVariant:=AnalysisVariantE as IAnalysisVariant;

  ExtraTargetCount:=FAnalysisVariant.ExtraTargets.Count;
  PathGraphCount:=1;
  for m:=0 to ExtraTargetCount-1 do
    PathGraphCount:=PathGraphCount*2;

  for j:=0 to FPathGraphConnectors.Count-1 do begin
    PathArc:=FPathGraphConnectors.Item[j] as IPathArc2;
    PathArc.Enabled:=False;
  end;

  FacilityStateE:=AnalysisVariant.FacilityState;
  FacilityState:=FacilityStateE as IFacilityState;
  FacilityModel:=(Get_Data as IFacilityModel);
  SafeguardElementStates2:=FacilityModel.SafeguardElementStates as IDMCollection2;
  for j:=0 to PathGraphs.Count-1 do begin
    PathGraphE:=PathGraphs.Item[j];
    PathGraph:=PathGraphE as IPathGraph;
    PathGraphF:=PathGraph as IFacilityState;
    PathGraphF.Kind:=2;  // признак возмущенное состояния

    PathGraphE.Ref:=FacilityStateE;
    PathGraphE.Name:=FacilityStateE.Name+'\';

    PathGraphF.ModificationStage:=FacilityState.ModificationStage;

    ExtraSubStateE:=PathGraph.ExtraSubState;
    if ExtraSubStateE<>nil then begin
      ExtraSubState:=ExtraSubStateE as IFacilitySubState;
      while ExtraSubState.ElementStates.Count>0 do begin
        ElementStateE:=ExtraSubState.ElementStates.Item[0];
        ElementStateE.Clear;
      end;
    end;

    if j<=PathGraphCount then begin
      N:=j;
      i:=0;  //  двоичная позиция
      while N>0 do begin   //перевод номера подграфа в двоичный код
        R:=N mod 2;        //его возмущенного состоянмя
        if R=1 then begin
          if i<AnalysisVariant.ExtraTargets.Count then begin
            ElementStateE:=SafeguardElementStates2.CreateElement(False);
            ElementStateE.Ref:=ExtraSubStateE;
            Element:=AnalysisVariant.ExtraTargets.Item[i];
            ElementStateE.Parent:=Element;
            ElementStateS:=ElementStateE as ISafeguardElementState;
            ElementType:=Element.Ref.Parent as ISafeguardElementType;
            ElementStateS.DeviceState0:=ElementType.DeviceStates.Item[1]; // не [0] - значит возмущенное состояние
            ElementStateS.DeviceState1:=ElementStateS.DeviceState0;
            PathGraphE.Name:=PathGraphE.Name+ElementStateE.Parent.Name+'\';
          end;
        end;
        N:=N div 2;
       inc(i);
      end;
    end;
  end;

  for j:=0 to PathGraphCount-1 do begin
    PathGraphE:=PathGraphs.Item[j];
    PathGraph:=PathGraphE as IPathGraph;
    ExtraSubStateE:=PathGraph.ExtraSubState;
    ExtraSubState:=ExtraSubStateE as IFacilitySubState;
    if ExtraSubState<>nil then
      ElementStateCount:=ExtraSubState.ElementStates.Count
    else
      ElementStateCount:=0;
    for m:=j+1 to PathGraphCount-1 do begin
      NextPathGraphE:=PathGraphs.Item[m];
      NextPathGraph:=NextPathGraphE as IPathGraph;
      NextExtraSubStateE:=NextPathGraph.ExtraSubState;
      NextExtraSubState:=NextExtraSubStateE as IFacilitySubState;
      if NextExtraSubState.ElementStates.Count=
             ElementStateCount+1 then begin
        NewExtraTargetStateE:=nil;
        Difference:=0;
        for k:=0 to NextExtraSubState.ElementStates.Count-1 do begin
          ExtraTargetStateE:=NextExtraSubState.ElementStates.Item[k];
          if (ExtraSubState=nil) or
             (ExtraSubState.ElementStates.IndexOf(ExtraTargetStateE)=-1) then begin
            NewExtraTargetStateE:=ExtraTargetStateE;
            inc(Difference);
            if Difference=2 then Break;
          end;
        end;
        if Difference=1 then begin
          ExtraTargetE:=NewExtraTargetStateE.Parent;
          ConnectPathGraphs(PathGraphE, NextPathGraphE, ExtraTargetE);
        end;
      end
    end;
    if AnalysisVariant.MainGroup<>nil then begin
      TargetE:=AnalysisVariant.MainGroup.FinishPoint;
      if TargetE<>nil then begin
        if PathGraphE<>FBaseGraph then
          NextPathGraphE:=FBaseGraph
        else
          NextPathGraphE:=nil;
        NextPathGraph:=NextPathGraphE as IPathGraph;
        ConnectPathGraphs(PathGraphE, NextPathGraphE, TargetE);
      end;
    end;
  end;

  (FBaseGraph as IFacilityState).Kind:=0;
end;

procedure TSafeguardAnalyzer.BuildTree(const RootNode: IPathNode);
  procedure AddToLeafList(const PathArc:ILine;
                          const NearestFromRootNode, NextNode:ICoordNode;
                          const LeafList:TLinkList);
  var
    aPathNode: IPathNode;
    aPathNode2: IPathNode2;
    NewDistance: double;
    PathArc2:IPathArc2;
    PathArcE, PrevNodeE, NextNodeE:IDMElement;
  begin
    aPathNode:=NextNode as IPathNode;
    aPathNode2:=aPathNode as IPathNode2;
    if aPathNode2.Used then Exit;

    PathArcE:=PathArc as IDMElement;
    PathArc2:=PathArc as  IPathArc2;

    PrevNodeE:=NearestFromRootNode as IDMElement;
    NextNodeE:=NextNode as IDMElement;
    NewDistance:=PathArc2.NewDistanceFromRoot(PrevNodeE, NextNodeE);
    if aPathNode.BestNextArc<>nil then begin
      if FCompareDistanceFunc1 and
          (abs(NewDistance-aPathNode.BestDistance)<1.e-6) then begin
        if FDistanceFunc1<aPathNode2.DistanceFunc1 then begin
          aPathNode.BestNextArc:=PathArcE;
          aPathNode.BestNextNode:=NearestFromRootNode as IDMElement;
          aPathNode.BestDistance:=NewDistance;
          aPathNode2.OnUpdateBestDistance(FCalcMode);
          PathArc2.OnUpdateBestDistance(FCalcMode);
        end;
      end else
      if NewDistance<aPathNode.BestDistance then begin
        aPathNode.BestNextArc:=PathArcE;
        aPathNode.BestNextNode:=NearestFromRootNode as IDMElement;
        aPathNode.BestDistance:=NewDistance;
        aPathNode2.OnUpdateBestDistance(FCalcMode);
        PathArc2.OnUpdateBestDistance(FCalcMode);
      end;
    end else begin
      aPathNode.BestNextArc:=PathArcE;
      aPathNode.BestNextNode:=NearestFromRootNode as IDMElement;
      aPathNode.BestDistance:=NewDistance;
      aPathNode2.OnUpdateBestDistance(FCalcMode);
      PathArc2.OnUpdateBestDistance(FCalcMode);
      if FDisabledPathNodes.IndexOf(aPathNode as IDMElement)=-1 then
        LeafList.Add(pointer(aPathNode));
    end;
  end;  {AddToLeafList}

  function FindNearestFromRootNode(LeafList:TLinkList):IPathNode;
  var
    ALink:TLink;
    SmallestDistance, Distance, DistanceFunc1, BestDistanceFunc1:double;
    aPathNode:IPathNode;
    aPathNode2:IPathNode2;
  begin
    ALink:=LeafList.first;
    SmallestDistance:=InfinitValue;
    BestDistanceFunc1:=InfinitValue;
    Result:=nil;
    while (ALink<>nil) do begin
      aPathNode:=IPathNode(ALink.body);
      aPathNode2:=aPathNode as IPathNode2;
      Distance:=aPathNode.BestDistance;
      if FCompareDistanceFunc1 and
         (abs(Distance-SmallestDistance)<1.e-6) then begin
         DistanceFunc1:=aPathNode2.DistanceFunc1;
         if DistanceFunc1<BestDistanceFunc1 then begin
           BestDistanceFunc1:=DistanceFunc1;
           Result:=aPathNode;
         end;
      end else
      if Distance<SmallestDistance then begin
        SmallestDistance:=Distance;
        BestDistanceFunc1:=aPathNode2.DistanceFunc1;
        Result:=aPathNode;
      end;
      ALink:=ALink.next;
    end
  end;


var
  j, m:integer;
  LeafList: TLinkList;
  NearestFromRootNode: IPathNode;
  Node, ZoneNode, NextNode:ICoordNode;
  FacilityModelS:IFMState;
  FacilityModel:IFacilityModel;
  PathArcInE, PathArcOutE:IDMElement;
  PathArcIn, PrevArc:IPathArc;
  PathArcIn2, PathArcOut2:IPathArc2;
  PathArcInL, PathArcOutL:ILine;
  PrevArcIsRZone:boolean;
  RootNode2:IPathNode2;
//  PrevID:integer;
begin
  RootNode2:=RootNode as IPathNode2;
  FacilityModelS:=Get_Data as IFMState;
  FacilityModelS.CurrentPathStage:=FPathStage;
  FacilityModelS.CurrentWarriorGroupU:=FCurrentWarriorGroup;

  FacilityModel:=FacilityModelS as IFacilityModel;
  FacilityModel.Reset(FBaseGraph);

  LeafList:=TLinkList.Create;
  RootNode2.ResetBestDistance(True);
  RootNode.BestNextArc:=nil;
  LeafList.Add(pointer(RootNode));
  NearestFromRootNode:=RootNode;
  TerminateFlag:=False;
  try
  while (LeafList.First<>nil) and
        not TerminateFlag  do begin

    Node:=NearestFromRootNode as ICoordNode;

    PrevArc:=NearestFromRootNode.BestNextArc as IPathArc;
    if PrevArc<>nil then begin
      PrevArcIsRZone:=(PrevArc.Kind=pakRZone);
//      PrevID:=NearestFromRootNode.BestNextArc.ID;
    end else begin
      PrevArcIsRZone:=False;
//      PrevID:=-1;
    end;
(*
                if (FStage=stageBuildAdversaryRationalTreeToTarget) {and
                   (WriteFlag=1)} then
                   writeln(DebugFile, Format('Node=%-5d Prev=%-5d d0=%-16.7f d1=%-9.2f x0=%-9.0f y0=%-9.0f', [
                         (Node as IDMElement).ID,
                         PrevID,
                         (Node as IPathNode).BestDistance,
                         (Node as IPathNode).DistanceFunc1,
                         (Node as ICoordNode).X,
                         (Node as ICoordNode).Y
                         ]));
*)
    for j:=0 to Node.Lines.Count-1 do begin
      PathArcInE:=Node.Lines.Item[j];
{
                if (FStage=stageBuildAdversaryRationalTreeToTarget) then begin
                   if (WriteFlag=0) and
                      (PathArcInE.Ref.ClassID=_Zone) and
                      (PathArcInE.Ref.ID=178) then
                     WriteFlag:=1;
                   if (WriteFlag=1) and
                      (PathArcInE.Ref.ClassID=_Boundary) and
                      ((PathArcInE.Ref.ID=2) or (PathArcInE.Ref.ID=6)) then
                     WriteFlag:=0;
                end;
}

      PathArcIn2:=PathArcInE as IPathArc2;
      if PathArcIn2.Enabled then begin
        PathArcIn:=PathArcIn2 as IPathArc;
        PathArcInL:=PathArcIn2 as ILine;
        NextNode:=PathArcInL.NextNodeTo(Node);
        if PathArcIn.Kind=pakRZone then begin
          if not PrevArcIsRZone then begin
            ZoneNode:=NextNode;
            ZoneNode.X:=Node.X;
            ZoneNode.Y:=Node.Y;
            ZoneNode.Z:=Node.Z;
            for m:=0 to ZoneNode.Lines.Count-1 do begin
              PathArcOutE:=ZoneNode.Lines.Item[m];

              PathArcOut2:=PathArcOutE as IPathArc2;
              if PathArcOut2.Enabled then begin
                PathArcOutL:=PathArcOut2 as ILine;
                NextNode:=PathArcOutL.NextNodeTo(ZoneNode);
                if NextNode<>Node then begin
                  AddToLeafList(PathArcOutL, Node, NextNode, LeafList);
(*
                if (FStage=stageBuildAdversaryRationalTreeToTarget) and
//                   (WriteFlag=1) and
                     (not (NextNode as IPathNode).Used)then
                     writeln(DebugFile, Format('NextNode=-%5d id0=%-5d id1=%-5d RefID=%-5d d0=%-16.7f d1=%-9.2f x1=%-9.0f y1=%-9.0f', [
                         (NextNode as IDMElement).ID,
                         PathArcInE.ID,
                         PathArcOutE.ID,
                         PathArcInE.Ref.ID,
                         (NextNode as IPathNode).BestDistance,
                         (NextNode as IPathNode).DistanceFunc1,
                         (NextNode as ICoordNode).X,
                         (NextNode as ICoordNode).Y
                         ]));
*)
                end
              end;
            end;
          end;
        end else begin
          AddToLeafList(PathArcInL, Node, NextNode, LeafList);
(*
                if (FStage=stageBuildAdversaryRationalTreeToTarget) and
//                   (WriteFlag=1) and
                   (not (NextNode as IPathNode).Used)then
                   writeln(DebugFile, Format('NextNode=-%5d id0=%-5d id1=%-5d RefID=%-5d d0=%-16.7f d1=%-9.2f', [
                         (NextNode as IDMElement).ID,
                         PathArcInE.ID,
                         -1,
                         PathArcInE.Ref.ID,
                         (NextNode as IPathNode).BestDistance,
                         (NextNode as IPathNode).DistanceFunc1
                         ]));
*)
        end;

      end;
    end;
    LeafList.Delete(pointer(NearestFromRootNode));
    (NearestFromRootNode as IPathNode2).Used:=True;
    NearestFromRootNode:=FindNearestFromRootNode(LeafList);
    if NearestFromRootNode=nil then Break;
  end;
  except
    on E:Exception do
      HandleError('Ошибка в процедуре BuildTree');
  end;
  LeafList.Free;
end;


function TSafeguardAnalyzer.Get_CalcMode: Integer;
begin
  Result:=FCalcMode
end;

function TSafeguardAnalyzer.Get_CurrentWarriorGroup: IDMElement;
begin
  Result:=FCurrentWarriorGroup as IDMElement
end;

function TSafeguardAnalyzer.Get_PathStage: integer;
begin
  Result:=FPathStage
end;

function TSafeguardAnalyzer.Get_ResponceTime: double;
begin
  Result:=FResponceTime
end;

function TSafeguardAnalyzer.Get_ResponceTimeDispersion: double;
begin
  Result:=FResponceTimeDispersion
end;

procedure TSafeguardAnalyzer.Set_ResponceTimeDispersion(Value: double);
begin
  FResponceTimeDispersion:=Value
end;

function TSafeguardAnalyzer.Get_CoordNodes: IDMCollection;
begin
  Result:=Collection[_PathNode]
end;

function TSafeguardAnalyzer.Get_CurrentLayer: ILayer;
begin
  Result:=FGraphLayer as ILayer
end;

function TSafeguardAnalyzer.Get_CurvedLines: IDMCollection;
begin
  Result:=nil
end;

function TSafeguardAnalyzer.Get_Layers: IDMCollection;
begin
  Result:=Collection[_PathLayer]
end;

function TSafeguardAnalyzer.Get_Lines: IDMCollection;
begin
  Result:=Collection[_PathArc]
end;

function TSafeguardAnalyzer.Get_Polylines: IDMCollection;
begin
  Result:=Collection[_Path]
end;

procedure TSafeguardAnalyzer.Set_CurrentLayer(const Value: ILayer);
begin
end;

function TSafeguardAnalyzer.Get_ImageRects: IDMCollection;
begin
  Result:=nil
end;

function TSafeguardAnalyzer.Get_DistanceFunc: double;
begin
  Result:=FDistanceFunc
end;

procedure TSafeguardAnalyzer.Set_DistanceFunc(Value: double);
begin
  FDistanceFunc:=Value
end;

procedure TSafeguardAnalyzer.MakeBoundaryPaths(
  const BoundaryE: IDMElement);
var
  Node0E:IDMElement;
  WarriorPathE:IDMElement;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  BoundaryV:IVulnerabilityData;
  Unk:IUnknown;
  Polyline:IPolyline;
  j:integer;
  WarriorPath:IWarriorPath;
  Boundary:IBoundary;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  BoundaryV:=BoundaryE as IVulnerabilityData;
  Boundary:=BoundaryE as IBoundary;

  while Boundary.WarriorPaths.Count>0 do begin
    WarriorPathE:=Boundary.WarriorPaths.Item[0];
    WarriorPathE.Clear;
    (FacilityModel.WarriorPaths as IDMCollection2).Remove(WarriorPathE);
  end;

  if FacilityModels.CurrentWarriorGroupU=nil then Exit;

  if FacilityModelS.CurrentWarriorGroupU.QueryInterface(IGuardGroup, Unk)=0 then Exit;

  Node0E:=BoundaryV.RationalProbabilityToTarget_NextNode;
  if Node0E<>nil then begin
    WarriorPathE:=nil;
    MakePathFrom(Node0E, False,
                 pkRationalPath, True, WarriorPathE);
    if WarriorPathE<>nil then begin
      WarriorPath:=WarriorPathE as IWarriorPath;
      WarriorPath.Build(tmToRoot, False, True, nil);
      WarriorPath.DoAnalysis(nil, True);
      WarriorPathE.Name:=rsRationalPath;
      WarriorPathE.Parent:=BoundaryE;
      Polyline:=WarriorPathE.SpatialElement as IPolyline;
     for j:=0 to Polyline.Lines.Count-1 do
        Polyline.Lines.Item[j].Parent:=FRationalPathLayer;
    end;
  end;

  Node0E:=BoundaryV.DelayTimeToTarget_NextNode;
  WarriorPathE:=nil;
  MakePathFrom(Node0E, False,
                   pkFastPath, True, WarriorPathE);
  if WarriorPathE<>nil then begin
    (WarriorPathE as IWarriorPath).Build(tmToRoot, False, True, nil);
    (WarriorPathE as IWarriorPath).DoAnalysis(nil, True);
    WarriorPathE.Name:=rsFastPath;
    WarriorPathE.Parent:=BoundaryE;
    Polyline:=WarriorPathE.SpatialElement as IPolyline;
    for j:=0 to Polyline.Lines.Count-1 do
      Polyline.Lines.Item[j].Parent:=FFastPathLayer;
  end;

  Node0E:=BoundaryV.NoDetectionProbabilityFromStart_NextNode;
  WarriorPathE:=nil;
  MakePathFrom(Node0E, False,
            pkStealthPath, True, WarriorPathE);
  if WarriorPathE<>nil then begin
    (WarriorPathE as IWarriorPath).Build(tmFromRoot, False, True, nil);
    (WarriorPathE as IWarriorPath).DoAnalysis(nil, True);
    WarriorPathE.Name:=rsStealthPath;
    WarriorPathE.Parent:=BoundaryE;
    Polyline:=WarriorPathE.SpatialElement as IPolyline;
    for j:=0 to Polyline.Lines.Count-1 do
      Polyline.Lines.Item[j].Parent:=FStealthPathLayer;
  end;
end;

procedure TSafeguardAnalyzer.TreatElement(const Element: IDMElement;
  aMode: Integer);
var
  Unk:IUnknown;
begin
  if aMode=0 then begin
    if Element.QueryInterface(IBoundary, Unk)=0 then
//      MakeBoundaryPaths(Element)
    else
    if Element.QueryInterface(IGuardPost, Unk)=0 then
//      MakeGuardPostPaths(Element)
  end else begin
    if (Element.QueryInterface(IPathArc, Unk)=0) and
       (Element.Ref<>nil) and
       (Element.Ref.QueryInterface(ITarget, Unk)=0)then
      BuildBackPath(Element)
  end;
end;

procedure TSafeguardAnalyzer.CalcResponceTime;
var
  j:integer;
  GroupW:IWarriorGroup;
  GroupE:IDMElement;
  AdversaryVariant:IAdversaryVariant;
  Potential, GuardPotentialSum, AdversaryPotentialSum:double;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  GuardModel:IGuardModel;
  GuardArrivals:IDMCollection;
  Boundary:IBoundary;
begin
  FacilityModel:=DataModel as IFacilityModel;
  GuardModel:=FacilityModel as IGuardModel;
  GuardArrivals:=GuardModel.GuardArrivals;
  FacilityModelS:=FacilityModel as IFMState;

// находим суммарный боевой потенциал нарушителей
  AdversaryVariant:=FAnalysisVariant.AdversaryVariant as IAdversaryVariant;
  AdversaryPotentialSum:=0;
  for j:=0 to AdversaryVariant.AdversaryGroups.Count-1 do begin
    GroupE:=AdversaryVariant.AdversaryGroups.Item[j];
    GroupW:=GroupE as IWarriorGroup;
    Potential:=GroupW.GetPotential;
    AdversaryPotentialSum:=AdversaryPotentialSum+Potential;
  end;
  (FacilityModel as IGuardModel).AdversaryPotentialSum:=AdversaryPotentialSum;

// ищем момент прихода подразделения охраны, обеспечивающего победу (превышение боевого потенциала)
  if GuardArrivals.Count=0 then begin
    FAnalysisVariant.ResponceTime:=InfinitValue;
    FAnalysisVariant.ResponceTimeDispersion:=0;
  end else begin
    GuardPotentialSum:=0;
    GroupW:=nil;
    j:=0;
    while j<GuardArrivals.Count do begin
      GroupE:=GuardArrivals.Item[j];
      GroupW:=GroupE as IWarriorGroup;
      Potential:=GroupW.GetPotential;
      GuardPotentialSum:=GuardPotentialSum+Potential;
      if GuardPotentialSum>=AdversaryPotentialSum then
        Break
      else
        inc(j)
    end;
    FAnalysisVariant.ResponceTime:=GroupW.ArrivalTime;
    FAnalysisVariant.ResponceTimeDispersion:=GroupW.ArrivalTimeDispersion;

    FacilityModelS.CurrentReactionTime:=GroupW.ArrivalTime;
    FacilityModelS.CurrentReactionTimeDispersion:=GroupW.ArrivalTimeDispersion;
  end;

  try
  for j:=0 to FacilityModel.Boundaries.Count-1 do begin
    Boundary:=FacilityModel.Boundaries.Item[j] as IBoundary;
    Boundary.CalcGuardTactic;
  end;
  for j:=0 to FacilityModel.Jumps.Count-1 do begin
    Boundary:=FacilityModel.Jumps.Item[j] as IBoundary;
    Boundary.CalcGuardTactic;
  end;
  for j:=0 to FacilityModel.Targets.Count-1 do begin
    Boundary:=FacilityModel.Targets.Item[j] as IBoundary;
    Boundary.CalcGuardTactic;
  end;
  except
    raise
  end;
//  for j:=0 to FacilityModel.ControlDevices.Count-1 do
//    Boundary:=FacilityModel.ControlDevices.Item[j] as IBoundary;
//    Boundary.CalcGuardTactic;
//  end;
end;


procedure TSafeguardAnalyzer.ConnectPathGraphs(const PathGraphE,
  NextPathGraphE, ExtraTargetE: IDMElement);
var
  PathNode, NextPathNode, aPathNode:ICoordNode;
  PathArcE:IDMElement;
  PathArcL:ILine;
  PathArc:IPathArc;
  ExtraTargetA:IPathNodeArray;
  j:integer;
begin
  ExtraTargetA:=ExtraTargetE as IPathNodeArray;
  for j:=0 to ExtraTargetA.PathNodes.Count-1 do begin
    aPathNode:=ExtraTargetA.PathNodes.Item[j] as ICoordNode;
    if (aPathNode.Lines.Item[0] as IPathArc).FacilityState = PathGraphE then
      PathNode:=aPathNode
    else
    if (aPathNode.Lines.Item[0] as IPathArc).FacilityState = NextPathGraphE then
      NextPathNode:=aPathNode;
  end;
  if PathNode=nil then Exit;
  if NextPathNode=nil then Exit;

  PathArc:=nil;
  j:=0;
  while j<PathNode.Lines.Count do begin
    PathArcE:=PathNode.Lines.Item[j];
    PathArcL:=PathArcE as ILine;
    if NextPathNode=PathArcL.NextNodeTo(PathNode) then begin
      PathArc:=PathArcE as IPathArc;
      Break
    end else
      inc(j)
  end;

  if j=PathNode.Lines.Count then begin
    PathArcE:=(Get_PathArcs as IDMCollection2).CreateElement(False);
    PathArc:=PathArcE as IPathArc;
    PathArcL:=PathArcE as ILine;
    (FPathGraphConnectors as IDMCollection2).Add(PathArcE);
    PathArcL.C0:=PathNode;
    PathArcL.C1:=NextPathNode;
    PathArcE.Ref:=ExtraTargetE;
    PathArc.FacilityState:=PathGraphE;
    PathArc.Kind:=pakChangeFacilityState;
  end else
    (PathArc as IPathArc2).Enabled:=True;

end;


procedure TSafeguardAnalyzer.Clear;
begin
  inherited;
  ClearTree;
end;

function TSafeguardAnalyzer.Get_TreeMode: Integer;
begin
  Result:=FTreeMode
end;

function TSafeguardAnalyzer.Get_AnalysisVariant: IDMElement;
begin
  Result:=FAnalysisVariant as IDMElement
end;

procedure TSafeguardAnalyzer.FindCriticalPoints;
var
  j:integer;
  PathArcE, aPathArcE:IDMElement;
  PathArcL:ILine;
  PathArc2:IPathArc2;
  PathArcs:IDMCollection;
  V0, V1, V:IVulnerabilityData;
  T0, T1, dT:double;
  ResponceTime:double;
  aElement, AnalysisVariantE:IDMElement;
  CriticalPoints2, theCriticalPoints2, WarriorPaths2:IDMCollection2;
  CriticalPointE:IDMElement;
  CriticalPoint:ICriticalPoint;
  CriticalPoints:IDMCollection;
  m:integer;
  FacilityModel:IFacilityModel;
  WarriorPathE, WarriorPath1E:IDMElement;
  aNode, C0, C1:ICoordNode;
  PathP:IPolyline;
  PathE:IDMElement;
  Recomendations2:IDMCollection2;
  Sorter:ISorter;
begin
  PathArcs:=Get_PathArcs;
  ResponceTime:=FAnalysisVariant.ResponceTime;
  AnalysisVariantE:=FAnalysisVariant as IDMElement;
  FacilityModel:=Get_Data as IFacilityModel;

  WarriorPaths2:=FacilityModel.WarriorPaths as IDMCollection2;

  CriticalPoints:=FacilityModel.CriticalPoints;
  CriticalPoints2:=CriticalPoints as IDMCollection2;

  theCriticalPoints2:=FAnalysisVariant.CriticalPoints as IDMCollection2;

  try
  for j:=0 to PathArcs.Count-1 do begin
    PathArcE:=PathArcs.Item[j];
    PathArcL:=PathArcE as ILine;
    PathArc2:=PathArcE as IPathArc2;
    V0:=PathArcL.C0 as IVulnerabilityData;
    V1:=PathArcL.C1 as IVulnerabilityData;
    T0:=V0.DelayTimeToTarget;
    T1:=V1.DelayTimeToTarget;
    dT:=PathArc2.DelayTime;
    if T1>T0 then begin
      T1:=T0;
      V:=V1;
      V1:=V0;
      V0:=V;
      C0:=PathArcL.C0;
      C1:=PathArcL.C1;
    end else begin
      C0:=PathArcL.C1;
      C1:=PathArcL.C0;
    end;

    if (T1+dT>=ResponceTime) and
       (T1<ResponceTime) then begin
      if (V0.NoDetectionProbabilityFromStart_NextArc<>nil) then begin
        aElement:=PathArcE.Ref;
        if theCriticalPoints2.GetItemByRef(aElement)=nil then begin
          CriticalPointE:=CriticalPoints2.CreateElement(False);
          CriticalPointE.Ref:=aElement;
          CriticalPoint:=CriticalPointE as ICriticalPoint;

          CriticalPoint.DelayTimeToTarget:=T1;
          CriticalPoint.InterruptionProbability:=1-V0.NoDetectionProbabilityFromStart;
          CriticalPoint.TimeRemainder:=T1+dT-ResponceTime;

//          WarriorPathE:=MakeFastPathFrom(C0 as IDMElement, False);
          WarriorPathE:=nil;
          MakePathFrom(C0 as IDMElement, True,
                           pkFastPath, True, WarriorPathE);

          PathE:=WarriorPathE.SpatialElement;
          PathP:=PathE as IPolyline;

          aPathArcE:=nil;
          for m:=0 to C0.Lines.Count-1 do begin
            aPathArcE:=C0.Lines.Item[m];
            aNode:=(aPathArcE as ILine).NextNodeTo(C0);
            if aNode=C1 then
              Break;
          end;
          if aPathArcE<>nil then begin
            if PathP.Lines.IndexOf(aPathArcE)<>-1 then
              Break;
            aPathArcE.AddParent(PathE);
          end;

          WarriorPath1E:=WarriorPathE;
          MakePathFrom(C1 as IDMElement, False,
                            pkStealthPath, True, WarriorPathE);

          if WarriorPathE<>nil then begin
             CriticalPoints2.Add(CriticalPointE);
            (WarriorPathE as IWarriorPath).Build(tmToRoot, True, True, nil);
            (WarriorPathE as IWarriorPath).DoAnalysis(nil, True);

            WarriorPathE.Parent:=CriticalPointE;
            CriticalPointE.Parent:=AnalysisVariantE;

            CriticalPoint.MakeRecomendations(rcDelayTime);
          end else begin
            WarriorPath1E.Clear;
            WarriorPaths2.Remove(WarriorPath1E);
          end;
        end;
      end;
    end;
  end;

  Sorter:=TCriticalPointSorter.Create(nil) as ISorter;
  theCriticalPoints2.Sort(Sorter);

  Recomendations2:=FacilityModel.FMRecomendations as IDMCollection2;
  Sorter:=TFMRecomendationSorter.Create(nil) as ISorter;
  Recomendations2.Sort(Sorter);

  except
    on E:Exception do
      HandleError('Ошибка в процедуре FindCriticalPoints');
  end;

end;

function TSafeguardAnalyzer.BuildPatrolPath(
  const GroupE, StartNodeE, FinishNodeE:IDMElement):IDMElement;
var
  FinishNode:IPathNode;
  j:integer;
  PathNode2:IPathNode2;
begin
  if FinishNodeE=nil then Exit;
  FinishNode:=FinishNodeE as IPathNode;

  FCurrentWarriorGroup:=GroupE as IWarriorGroup;
  FCalcMode:=admGet_DelayTimeToTarget;
  FTreeMode:=tmToRoot;

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode2:=Get_PathNodes.Item[j] as IPathNode2;
    PathNode2.ResetBestDistance(False);
  end;

  (FDisabledPathNodes as IDMCollection2).Clear;
  BuildTree(FinishNode);

  Result:=nil;
  MakePathFrom(StartNodeE, False,
                    pkFastPath, False, Result);
  Result.Name:=GroupE.Name;
end;

procedure TSafeguardAnalyzer.MakeGuardPostPaths(
  const GuardPostE: IDMElement);
var
  WarriorPathE:IDMElement;
  FacilityModel:IFacilityModel;
  GuardPost:IGuardPost;
  GuardGroupW:IWarriorGroup;
  Polyline:IPolyline;
  j, m:integer;
  GuardGroupPath:IWarriorPath;
  WarriorPaths2, Paths2:IDMCollection2;
  PathArcE, PathE:IDMElement;
begin
  FacilityModel:=Get_Data as IFacilityModel;

  GuardPost:=GuardPostE as IGuardPost;
  for m:=0 to GuardPost.WarriorGroups.Count-1 do begin
    GuardGroupW:=GuardPost.WarriorGroups.Item[m] as IWarriorGroup;

    WarriorPaths2:=FacilityModel.WarriorPaths as IDMCollection2;

    while GuardPostE.Collection[2].Count>0 do begin
      WarriorPathE:=GuardPostE.Collection[2].Item[0];
      WarriorPathE.Clear;
      WarriorPaths2.Remove(WarriorPathE);
    end;

    WarriorPathE:=WarriorPaths2.CreateElement(False);
    WarriorPaths2.Add(WarriorPathE);
    WarriorPathE.Name:=rsFastPath;
    WarriorPathE.Parent:=GuardPostE;

    Paths2:=Get_Paths as  IDMCollection2;
    PathE:=Paths2.CreateElement(False);
    Paths2.Add(PathE);
    PathE.Ref:=WarriorPathE;

    GuardGroupPath:=GuardGroupW.FastPath;
    if GuardGroupPath<>nil then begin
      Polyline:=(GuardGroupPath as IDMElement).SpatialElement as IPolyline;
      for j:=0 to Polyline.Lines.Count-1 do begin
        PathArcE:=Polyline.Lines.Item[j];
        PathArcE.Parent:=FFastPathLayer;
        PathArcE.AddParent(PathE);
      end;
    end;
  end;

  if WarriorPathE<>nil then
    (WarriorPathE as IWarriorPath).Kind:=_wpkGuard;
end;

function TSafeguardAnalyzer.Get_VerticalWays: IDMCollection;
begin
  Result:=Collection[_VerticalWay]
end;


procedure TSafeguardAnalyzer.CalcBattleModel;
var
  FacilityModel:IFacilityModel;
  BattleModel:IDMAnalyzer;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  BattleModel:=FacilityModel.BattleModel as IDMAnalyzer;
  if BattleModel<>nil then
    BattleModel.Start(0);
end;

procedure TSafeguardAnalyzer.Set_CalcMode(Value: Integer);
begin
  FCalcMode:=Value
end;

procedure TSafeguardAnalyzer.Set_TreeMode(Value: Integer);
begin
  FTreeMode:=Value
end;

procedure TSafeguardAnalyzer.Set_PathStage(Value: integer);
begin
  FPathStage:=Value;
end;

procedure TSafeguardAnalyzer.BuildAdversaryRationalTreeToTarget;
var
  StartNode, FinishNode:IPathNode;
  j:integer;
  SafeguardElementA:IPathNodeArray;
  PathNode2:IPathNode2;
begin
  if TerminateFlag then Exit;

  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  FCalcMode:=admGet_RationalProbabilityToTarget;
  FTreeMode:=tmToRoot;

  FCompareDistanceFunc1:=True;

  FPathStage:=wpsStealthEntry;

  FResponceTime:=FAnalysisVariant.ResponceTime;
  FResponceTimeDispersion:=FAnalysisVariant.ResponceTimeDispersion;

  SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  SafeguardElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
  FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  (FDisabledPathNodes as IDMCollection2).Clear;
  if StartNode<>nil then
    (FDisabledPathNodes as IDMCollection2).Add(StartNode as IDMElement);

  if FAnalysisVariant.GuardStrategy=1 then
    EstimateTotalBackPathDelayTime(StartNode as IDMElement); // оценка на основе

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode2:=Get_PathNodes.Item[j] as IPathNode2;
    PathNode2.ResetBestDistance(False);
  end;
                                                             // кратчайшего маршрута
  if FinishNode<>nil then
    BuildTree(FinishNode);

  if FAnalysisVariant.GuardStrategy=1 then
    EstimateTotalBackPathDelayTime(StartNode as IDMElement);  // уточняем на основе 
                                                              // рационального маршрута
  for j:=0 to Get_PathNodes.Count-1 do
    (Get_PathNodes.Item[j] as IPathNode2).StoreRecord(admGet_RationalProbabilityToTarget,
                                            FCurrentWarriorGroup as IDMElement)
end;

function TSafeguardAnalyzer.Get_DistanceFunc1: double;
begin
  Result:=FDistanceFunc1
end;

procedure TSafeguardAnalyzer.Set_DistanceFunc1(Value: double);
begin
  FDistanceFunc1:=Value
end;

function TSafeguardAnalyzer.Get_DistanceFunc2: double;
begin
  Result:=FDistanceFunc2
end;

procedure TSafeguardAnalyzer.Set_DistanceFunc2(Value: double);
begin
  FDistanceFunc2:=Value
end;

function TSafeguardAnalyzer.Get_DistanceFunc3: double;
begin
  Result:=FDistanceFunc3
end;

procedure TSafeguardAnalyzer.Set_DistanceFunc3(Value: double);
begin
  FDistanceFunc3:=Value
end;

procedure TSafeguardAnalyzer.Update;
var
  FacilityModelS:IFMState;
  AnalysisVariantE:IDMElement;
begin
  FacilityModelS:=Get_Data as IFMState;
  AnalysisVariantE:=FacilityModelS.CurrentAnalysisVariantU as IDMElement;
  ChangePathGraphState(AnalysisVariantE)
end;

procedure TSafeguardAnalyzer.SetTerminateFlag(Value: boolean);
var
  FacilityModel:IFacilityModel;
  SafeguardSynthesis:ISafeguardSynthesis;
begin
  inherited;
  FacilityModel:=Get_Data as IFacilityModel;
  SafeguardSynthesis:=(FacilityModel.SafeguardSynthesis as ISafeguardSynthesis);
  if SafeguardSynthesis<>nil then
    SafeguardSynthesis.TerminateFlag:=Value;
end;

function TSafeguardAnalyzer.MakePathFrom(const NodeE: IDMElement;
  Reversed: WordBool; PathKind: Integer; UseStoredRecords:WordBool;
  var WarriorPathE: IDMElement): IDMElement;
var
  aNode0V:IVulnerabilityData;
  aNode0E, aNode1E:IDMElement;
  aNode0, aNode1:ICoordNode;
  aNode0P:IPathNode;
  aPathArcE, PathE:IDMElement;
  aPathArc:IPathArc;
  PathP:IPolyline;
  j:integer;
  FacilityModel:IFacilityModel;
  SpatialModel:ISpatialModel;
  WarriorPaths2, Paths2, PathNodes2:IDMCollection2;
  WarriorPath:IWarriorPath;
  TMPArcList, TMPNodeList:TList;
  RationalPathFlag:boolean;
  V0, V1:IVulnerabilityData;
  aPathNode0, aPathNode1:IPathNode;
  aPathArcL:ILine;
  D:double;
begin
  Result:=nil;
  if NodeE=nil then Exit;

  aNode0E:=NodeE;
  aNode0V:=NodeE as IVulnerabilityData;
  aNode0P:=NodeE as IPathNode;
  aNode0:=NodeE as ICoordNode;

  if UseStoredRecords then
    case PathKind of
    pkFastPath:
      begin
        aPathArcE:=aNode0V.DelayTimeToTarget_NextArc;
        aNode1E:=aNode0V.DelayTimeToTarget_NextNode;
      end;
    pkStealthPath:
      begin
        aPathArcE:=aNode0V.NoDetectionProbabilityFromStart_NextArc;
        aNode1E:=aNode0V.NoDetectionProbabilityFromStart_NextNode;
      end;
    pkRationalPath:
      begin
        aPathArcE:=aNode0V.RationalProbabilityToTarget_NextArc;
        aNode1E:=aNode0V.RationalProbabilityToTarget_NextNode;
      end;
    pkRationalBackPath:
      begin
        aPathArcE:=aNode0V.BackPathRationalProbability_NextArc;
        aNode1E:=aNode0V.BackPathRationalProbability_NextNode;
      end;
    else
      begin
        aPathArcE:=nil;
        aNode1E:=nil;
      end;
    end
  else begin
    aPathArcE:=aNode0P.BestNextArc;
    aNode1E:=aNode0P.BestNextNode;
  end;
  if aPathArcE=nil then Exit;
  if aNode1E=nil then Exit;

  aPathArcL:=aPathArcE as ILine;
  aNode1:=aNode1E as ICoordNode;

  SpatialModel:=Get_Data as ISpatialModel;
  FacilityModel:=SpatialModel as IFacilityModel;

  WarriorPaths2:=FacilityModel.WarriorPaths as IDMCollection2;
  Paths2:=Get_Paths as  IDMCollection2;
  if WarriorPathE=nil then begin
    WarriorPathE:=WarriorPaths2.CreateElement(False);
    WarriorPaths2.Add(WarriorPathE);
    PathE:=Paths2.CreateElement(True);
    Paths2.Add(PathE);
    PathE.Ref:=WarriorPathE;
  end else
    PathE:=WarriorPathE.SpatialElement;
  WarriorPath:=WarriorPathE as IWarriorPath;

  Result:=WarriorPathE;
  PathP:=PathE as IPolyline;

  PathNodes2:=WarriorPath.PathNodes as IDMCollection2;
  WarriorPath.FirstNode:=NodeE;

  TMPArcList:=TList.Create;
  TMPNodeList:=TList.Create;
  RationalPathFlag:=True;
  while aNode0V<>nil do begin
    if UseStoredRecords then
      case PathKind of
      pkFastPath:
        begin
          aPathArcE:=aNode0V.DelayTimeToTarget_NextArc;
          aNode1E:=aNode0V.DelayTimeToTarget_NextNode;
        end;
      pkStealthPath:
        begin
          aPathArcE:=aNode0V.NoDetectionProbabilityFromStart_NextArc;
          aNode1E:=aNode0V.NoDetectionProbabilityFromStart_NextNode;
        end;
      pkRationalPath:
        begin
          if RationalPathFlag then begin
            aPathArcE:=aNode0V.RationalProbabilityToTarget_NextArc;
            aNode1E:=aNode0V.RationalProbabilityToTarget_NextNode;
          end else begin
            D:=aNode0V.RationalProbabilityToTarget;
            if D>0.999 then begin
              RationalPathFlag:=False;
              aPathArcE:=aNode0V.DelayTimeToTarget_NextArc;
              aNode1E:=aNode0V.DelayTimeToTarget_NextNode;
            end;
          end;
        end;
      pkRationalBackPath:
        begin
          aPathArcE:=aNode0V.BackPathRationalProbability_NextArc;
          aNode1E:=aNode0V.BackPathRationalProbability_NextNode;
        end;
      else
        begin
          aPathArcE:=nil;
          aNode1E:=nil;
        end;
      end
    else begin
      aPathArcE:=aNode0P.BestNextArc;
      aNode1E:=aNode0P.BestNextNode;
    end;
    if aPathArcE=nil then
      Break;
    if aNode1E=nil then
      Break;

    aPathArc:=aPathArcE as IPathArc;
    aPathArcL:=aPathArcE as ILine;
    aNode1:=aNode1E as ICoordNode;

    if TMPArcList.IndexOf(pointer(aPathArcE))<>-1 then begin
      Result:=nil;
      Break;
    end;
    TMPArcList.Add(pointer(aPathArcE));
    TMPNodeList.Add(pointer(aNode1E));
    if (PathKind=pkFastPath) and
        not UseStoredRecords then begin
      aPathArcE.Parent:=FFastPathLayer;
      if not Reversed then begin     // to Root
        V0:=aNode0 as IVulnerabilityData;
        V1:=aNode1 as IVulnerabilityData;
        aPathArc.Value:=abs(V0.DelayTimeToTarget-V1.DelayTimeToTarget);
      end else begin
        aPathNode0:=aNode0 as IPathNode;
        aPathNode1:=aNode1 as IPathNode;
        aPathArc.Value:=abs(aPathNode1.BestDistance-aPathNode0.BestDistance);
      end;
    end;

    aNode0:=aNode1;
    aNode0V:=aNode1 as IVulnerabilityData;
    aNode0P:=aNode1 as IPathNode;
  end;  // while aNodeV<>nil

  if not Reversed then begin
    for j:=0 to TMPArcList.Count-1 do begin
      aPathArcE:=IDMElement(TMPArcList[j]);
      aNode1E:=IDMElement(TMPNodeList[j]);
      aPathArcE.AddParent(PathE);
      PathNodes2.Add(aNode1E);
    end;
  end else begin
    for j:=TMPArcList.Count-1 downto 0 do begin
      aPathArcE:=IDMElement(TMPArcList[j]);
      aNode1E:=IDMElement(TMPNodeList[j]);
      aPathArcE.AddParent(PathE);
      PathNodes2.Add(aNode1E);
    end;
  end;

  if PathP.Lines.Count=0 then begin
    WarriorPaths2.Remove(WarriorPathE);
    Paths2.Remove(PathE);
    PathE.Clear;
    WarriorPathE.Clear;
    WarriorPathE:=nil;
    Result:=nil;
  end;

  if Result<>nil then begin
    WarriorPath:=Result as IWarriorPath;

    case PathKind of
    pkFastPath:
      WarriorPath.Kind:=_wpkFast;
    pkStealthPath:
      WarriorPath.Kind:=_wpkStealth;
    pkRationalPath,
    pkRationalBackPath:
        WarriorPath.Kind:=_wpkRational;
    end;
  end;

  TMPArcList.Free;
  TMPNodeList.Free;
end;

procedure TSafeguardAnalyzer.BuildBackPath(const Element: IDMElement);
var
  NodeE, WarriorPathE, PathE:IDMElement;
  FacilityModel:IFacilityModel;
  WarriorPaths2, Paths2:IDMCollection2;
  Line:ILine;
begin
  if Element.QueryInterface(ILine, Line)=0 then
    NodeE:=Line.C0 as IDMElement
  else
    NodeE:=Element;

  FacilityModel:=Get_Data as IFacilityModel;
  WarriorPaths2:=FacilityModel.WarriorPaths as IDMCollection2;
  WarriorPathE:=WarriorPaths2.CreateElement(False);
  Paths2:=Get_Paths as  IDMCollection2;
  PathE:=Paths2.CreateElement(True);
  PathE.Ref:=WarriorPathE;

  try
    MakePathFrom(NodeE, False,
              pkRationalPath, True, WarriorPathE);
    ChangeBackPathGraphState(FAnalysisVariant as IDMElement, PathE);
  finally
    PathE.Clear;
    WarriorPathE.Clear;
  end;
end;

procedure TSafeguardAnalyzer.ChangeBackPathGraphState(
  const AnalysisVariantE, PathE: IDMElement);
var
  AnalysisVariant:IAnalysisVariant;
  j, k, ExtraTargetCount, PathGraphCount:integer;
  FacilityModel:IFacilityModel;
  FacilityState, PathGraphF:IFacilityState;
  PathGraph:IPathGraph;
  PathArcE, FacilityStateE, ElementStateE,
  BackPathSubStateE:IDMElement;
  SafeguardElementStates2:IDMCollection2;
  BackPathSubState:IFacilitySubState;
  FacilityElement:IFacilityElement;
  PathP:IPolyline;
  PathGraphs:IDMCollection;
begin

  AnalysisVariant:=AnalysisVariantE as IAnalysisVariant;
  FacilityStateE:=AnalysisVariant.FacilityState;
  FacilityState:=FacilityStateE as IFacilityState;
  FacilityModel:=(Get_Data as IFacilityModel);
  SafeguardElementStates2:=FacilityModel.SafeguardElementStates as IDMCollection2;

  PathGraphs:=Get_PathGraphs;

  ExtraTargetCount:=FAnalysisVariant.ExtraTargets.Count;
  PathGraphCount:=1;
  for k:=0 to ExtraTargetCount-1 do
    PathGraphCount:=PathGraphCount*2;

  for k:=0 to PathGraphCount-1 do begin
    PathGraph:=PathGraphs.Item[k] as IPathGraph;
    PathGraphF:=PathGraph as IFacilityState;

    BackPathSubStateE:=PathGraph.BackPathSubState;
    if BackPathSubStateE<>nil then begin
      BackPathSubState:=BackPathSubStateE as IFacilitySubState;
      while BackPathSubState.ElementStates.Count>0 do begin
        ElementStateE:=BackPathSubState.ElementStates.Item[0];
        ElementStateE.Clear;
      end;

      PathGraphF.AddSubState(BackPathSubStateE);

      PathP:=PathE as IPolyline;
      for j:=0 to PathP.Lines.Count-1 do begin
        PathArcE:=PathP.Lines.Item[j];
        if PathArcE.Ref.QueryInterface(IFacilityElement, FacilityElement)=0 then
          FacilityElement.MakeBackPathElementStates(BackPathSubStateE)
      end;
    end;
  end;
end;

procedure TSafeguardAnalyzer.ClearBackPathGraphState;
var
  k, ExtraTargetCount, PathGraphCount:integer;
  PathGraphF:IFacilityState;
  PathGraph:IPathGraph;
  ElementStateE,
  BackPathSubStateE:IDMElement;
  BackPathSubState:IFacilitySubState;
  PathGraphs:IDMCollection;
begin
  PathGraphs:=Get_PathGraphs;

  ExtraTargetCount:=FAnalysisVariant.ExtraTargets.Count;
  PathGraphCount:=1;
  for k:=0 to ExtraTargetCount-1 do
    PathGraphCount:=PathGraphCount*2;

  for k:=0 to PathGraphCount-1 do begin
    PathGraph:=PathGraphs.Item[k] as IPathGraph;
    PathGraphF:=PathGraph as IFacilityState;

    BackPathSubStateE:=PathGraph.BackPathSubState;
    if BackPathSubStateE<>nil then begin
      BackPathSubState:=BackPathSubStateE as IFacilitySubState;
      while BackPathSubState.ElementStates.Count>0 do begin
        ElementStateE:=BackPathSubState.ElementStates.Item[0];
        ElementStateE.Clear;
      end;

      PathGraphF.RemoveSubState(BackPathSubStateE);

    end;
  end;
end;


procedure TSafeguardAnalyzer.BuildAdversaryRationalBackPathTree;
var
  StartNode, FinishNode:IPathNode;
  j:integer;
  SafeguardElementA:IPathNodeArray;
  PathNode2:IPathNode2;
begin
  if TerminateFlag then Exit;

  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  FCalcMode:=admGet_BackPathRationalProbability;
  FTreeMode:=tmToRoot;
  FCompareDistanceFunc1:=True;

  FPathStage:=wpsStealthExit;

  FResponceTime:=FAnalysisVariant.ResponceTime;
  FResponceTimeDispersion:=FAnalysisVariant.ResponceTimeDispersion;

  SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  SafeguardElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
  FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  (FDisabledPathNodes as IDMCollection2).Clear;
  if FinishNode<>nil then
    (FDisabledPathNodes as IDMCollection2).Add(FinishNode as IDMElement);

  BuildBackPath(StartNode as IDMElement);

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode2:=Get_PathNodes.Item[j] as IPathNode2;
    PathNode2.ResetBestDistance(False);
  end;

  if StartNode<>nil then
    BuildTree(StartNode);

  ClearBackPathGraphState;

  for j:=0 to Get_PathNodes.Count-1 do
    (Get_PathNodes.Item[j] as IPathNode2).StoreRecord(admGet_BackPathRationalProbability,
                                            FCurrentWarriorGroup as IDMElement)
end;

procedure TSafeguardAnalyzer.BuildAdversaryFastBackPathTree;
var
  StartNode, FinishNode:IPathNode;
  j:integer;
  SafeguardElementA:IPathNodeArray;
  PathNode2:IPathNode2;
begin
  if TerminateFlag then Exit;

  FCurrentWarriorGroup:=FAnalysisVariant.MainGroup;
  FCalcMode:=admGet_BackPathDelayTime;
  FTreeMode:=tmToRoot;

  FPathStage:=wpsFastExit;

  SafeguardElementA:=FCurrentWarriorGroup.StartPoint as IPathNodeArray;
  StartNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  SafeguardElementA:=FCurrentWarriorGroup.FinishPoint as IPathNodeArray;
  FinishNode:=GetPathNodeForGraph(SafeguardElementA, FBaseGraph);

  (FDisabledPathNodes as IDMCollection2).Clear;
  if FinishNode<>nil then
    (FDisabledPathNodes as IDMCollection2).Add(FinishNode as IDMElement);

  BuildBackPath(StartNode as IDMElement);

  for j:=0 to Get_PathNodes.Count-1 do begin
    PathNode2:=Get_PathNodes.Item[j] as IPathNode2;
    PathNode2.ResetBestDistance(False);
  end;

  if StartNode<>nil then
    BuildTree(StartNode);

  ClearBackPathGraphState;

  for j:=0 to Get_PathNodes.Count-1 do
    (Get_PathNodes.Item[j] as IPathNode2).StoreRecord(admGet_BackPathDelayTime,
                                                   FCurrentWarriorGroup as IDMElement)
end;

procedure TSafeguardAnalyzer.EstimateTotalBackPathDelayTime(const NodeE:IDMElement);
var
  WarriorPathE, PathE, PathArcE:IDMElement;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  WarriorPaths2, Paths2:IDMCollection2;
  T, TDisp, aDelayTime, aDelayTimeDispersion:double;
  PathP:IPolyline;
  j, NodeDirection:integer;
  PathElement:IPathElement;
  PathArc:IPathArc;
  PathArcL:ILine;
  PrevNode:ICoordNode;
  BestTacticE:IDMElement;
  PathNodes:IDMCollection;
  WarriorPath:IWarriorPath;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  WarriorPaths2:=FacilityModel.WarriorPaths as IDMCollection2;
  WarriorPathE:=WarriorPaths2.CreateElement(False);
  WarriorPath:=WarriorPathE as IWarriorPath;
  Paths2:=Get_Paths as  IDMCollection2;
  PathE:=Paths2.CreateElement(True);
  PathE.Ref:=WarriorPathE;

  try
    MakePathFrom(NodeE, False,
              pkFastPath, True, WarriorPathE);
    ChangeBackPathGraphState(FAnalysisVariant as IDMElement, PathE);

    FacilityModelS.CurrentPathStage:=wpsFastExit;;

    PrevNode:=NodeE as ICoordNode;

    T:=0;
    TDisp:=0;

    PathP:=PathE as IPolyline;
    PathNodes:=WarriorPath.PathNodes;
    for j:=0 to PathP.Lines.Count-1 do begin
      PathArcE:=PathP.Lines.Item[j];
      PathArc:=PathArcE as IPathArc;
      PathArcL:=PathArcE as ILine;

      PathElement:=PathArcE.Ref as IPathElement;

      if PrevNode=PathArcL.C0 then
        NodeDirection:=pdFrom1To0
      else
        NodeDirection:=pdFrom0To1;

      FacilityModelS.CurrentNodeDirection:=NodeDirection;
      FacilityModelS.CurrentPathArcKind:=PathArc.Kind;
      FacilityModelS.CurrentFacilityStateU:=PathArc.FacilityState;
      FacilityModelS.CurrentLineU:=PathArc;

      if PrevNode.Z>-InfinitValue then begin
        PathElement.CalcDelayTime(aDelayTime, aDelayTimeDispersion, BestTacticE, 0);
        T:=T+aDelayTime;
        TDisp:=TDisp+aDelayTimeDispersion;
      end;

      PrevNode:=PathNodes.Item[j] as ICoordNode;
    end;

    FacilityModelS.TotalBackPathDelayTime:=T;
    FacilityModelS.TotalBackPathDelayTimeDispersion:=TDisp;

    ClearBackPathGraphState;
  finally
    if PathE<>nil then
      PathE.Clear;
    if WarriorPathE<>nil then
      WarriorPathE.Clear;
  end;
end;

function TSafeguardAnalyzer.Get_LineGroups: IDMCollection;
begin
  Result:=nil
end;

procedure TSafeguardAnalyzer.Terminate(const Text: string);
begin
  FErrorDescription:=Text;
  SetTerminateFlag(True);
end;

function TSafeguardAnalyzer.CreateCollection(
  aClassID: integer; const aParent:IDMElement): IDMCollection;
begin
  Result:= inherited CreateCollection(aClassID, aParent)
end;

procedure TSafeguardAnalyzer.HandleError(const ErrorMessage: WideString);
var
  Document:IDMDocument;
  Server:IDataModelServer;
begin
  Document:=(Get_Data as IDataModel).Document as IDMDocument;
  Server:=Document.Server;
  Server.AnalysisError(ErrorMessage);
  Abort;
end;

function TSafeguardAnalyzer.Get_Circles: IDMCollection;
begin
  Result:=nil
end;



procedure ProcessZone1(const EnviromentE: IDMElement; out FinishNode:IPathNode);
var
  GlobalZone:IGlobalZone;
  Zone:IZone;
  AreaE:IDMElement;
  m:integer;
  BoundaryFE:IFacilityElement;
  PathArc2:IPathArc2;
  PathArcL:ILine;
  Node0, Node1:IPathNode;
  Node02, Node12:IPathNode2;
  T0, T1:double;
  TMin0:double;
begin
  GlobalZone:=EnviromentE as IGlobalZone;
  if GlobalZone.LargestZone<>nil then
    Zone:=GlobalZone.LargestZone as IZone
  else
    Zone:=EnviromentE as IZone;
  TMin0:=InfinitValue;
  for m:=0 to Zone.VAreas.Count-1 do begin
    AreaE:=Zone.VAreas.Item[m];
    BoundaryFE:=AreaE.Ref as IFacilityElement;
    if BoundaryFE.PathArcs.Count>0 then begin
      PathArc2:=BoundaryFE.PathArcs.Item[0] as IPathArc2;
      if PathArc2.Enabled then begin
        PathArcL:=PathArc2 as ILine;
        Node0:=PathArcL.C0 as IPathNode;
        Node1:=PathArcL.C1 as IPathNode;
        Node02:=Node0 as IPathNode2;
        Node12:=Node1 as IPathNode2;
        T0:=Node02.MainDelayTimeToTarget;
        T1:=Node12.MainDelayTimeToTarget;
        if (T0<=T1) and
           ((Node0 as IDMElement).Ref<>EnviromentE)  then begin
          if Tmin0>T1 then begin
            Tmin0:=T1;
            FinishNode:=Node0;
          end;
        end else begin
          if Tmin0>T0 then begin
            Tmin0:=T0;
            FinishNode:=Node1;
          end;
        end;
      end;
    end;
  end;
end; //  ProcessZone1;


procedure ProcessZone(const aZoneE:IDMElement; const aVolume:IVolume;
                      const BoundaryFE:IFacilityElement;
                      const GroupW:IWarriorGroup; const VolumeList:TList;
                      var Tmin:double; out FinishNode:IPathNode);
var
  PathArc2:IPathArc2;
  PathArcL:ILine;
  Node0, Node1:IPathNode;
  Node02, Node12:IPathNode2;
  T0, T1, TS0, TS1:double;
  Boundary:IBoundary;
begin
  if BoundaryFE.PathArcs.Count=0 then Exit;
  PathArc2:=BoundaryFE.PathArcs.Item[0] as IPathArc2;
  if not PathArc2.Enabled then Exit;
  try
  if GroupW.GetAccessTypeToZone(aZoneE, True)<>0 then begin
    PathArcL:=PathArc2 as ILine;
    Node0:=PathArcL.C0 as IPathNode;
    Node1:=PathArcL.C1 as IPathNode;
    Node02:=Node0 as IPathNode2;
    Node12:=Node1 as IPathNode2;
    TS0:=Node02.MainDelayTimeFromStart;
    TS1:=Node12.MainDelayTimeFromStart;
    T0:=Node02.MainDelayTimeToTarget;
    T1:=Node12.MainDelayTimeToTarget;
    if T0>T1 then begin
      if (Tmin>T0) and
         (TS0<InfinitValue/1000) then begin
        Tmin:=T0;
        FinishNode:=Node0;
      end;
    end else begin
      if (Tmin>T1) and
         (TS1<InfinitValue/1000) then begin
        Tmin:=T1;
        FinishNode:=Node1;
      end;
    end;

// Дальше группа не идет, значит она блокирует нарушителей на этом рубеже
  Boundary:=BoundaryFE as IBoundary;
  Boundary.BlockGroup:=GroupW as IDMElement;

  end else begin// if GroupW.GetAccessTypeToZone(aZoneE, True)<>0
    if VolumeList.IndexOf(pointer(aVolume))=-1 then
      VolumeList.Add(pointer(aVolume));
  end;
  except
    raise
  end;
end; // ProcessZone

procedure ProcessVolume(Volume:IVolume; const AreaList, VolumeList:TList;
                        var Tmin:double; out FinishNode:IPathNode);
var
  k:integer;
  Area:IArea;
  AreaE, aZoneE, ZoneE, Zone0E, Zone1E, JumpE:IDMElement;
  aVolume, Volume0, Volume1:IVolume;
  BoundaryFE:IFacilityElement;
  Zone:IZone;
  Jump:IJump;


var
  GroupW:IWarriorGroup;
begin
  try
  ZoneE:=(Volume as IDMElement).Ref;
  Zone:=ZoneE as IZone;

  for k:=0 to Volume.Areas.Count-1 do begin
    AreaE:=Volume.Areas.Item[k];
    if AreaList.IndexOf(pointer(AreaE))=-1 then begin
      AreaList.Add(pointer(AreaE));
      Area:=AreaE as IArea;
      Volume0:=Area.Volume0;
      Volume1:=Area.Volume1;
      if Volume0=Volume then
        aVolume:=Volume1
      else
        aVolume:=Volume0;
      if aVolume<>nil then begin
        aZoneE:=(aVolume as IDMElement).Ref;        // проверяем, является ли этот рубеж
        BoundaryFE:=AreaE.Ref as IFacilityElement;  // границей между зоной, в которую
        ProcessZone(aZoneE, aVolume, BoundaryFE,    // охрана допущена и зоной, и зоной,
                    GroupW, VolumeList, Tmin, FinishNode); // в которую она не допущена
      end; // if aVolume<>nil
    end; // if AreaList.IndexOf(pointer(AreaE))=-1
  end; // for k:=0 to Volume.Areas.Count-1 do

  for k:=0 to Zone.Jumps.Count-1 do begin
    JumpE:=Zone.Jumps.Item[k];
    Jump:=JumpE as IJump;
    if AreaList.IndexOf(pointer(JumpE))=-1 then begin
      AreaList.Add(pointer(JumpE));
      Zone0E:=Jump.Zone0;
      Zone1E:=Jump.Zone1;
      if Zone0E=ZoneE then
        aZoneE:=Zone1E
      else
        aZoneE:=Zone0E;
      aVolume:=aZoneE.SpatialElement as IVolume;         // проверяем, является ли этот переход
      BoundaryFE:=Jump as IFacilityElement;              // границей между зоной, в которую
      ProcessZone(aZoneE, aVolume, BoundaryFE,           // охрана допущена и зоной, и зоной,
                  GroupW, VolumeList, Tmin, FinishNode); // в которую она не допущена
    end;
  end;
  except
    raise
  end;
end; // ProcessVolume

procedure TSafeguardAnalyzer.FindGuardFinishPoints;
var
  j:integer;
  GroupW:IWarriorGroup;
  GroupG:IGuardGroup;
  GroupG2:IGuardGroup2;
  FinishNodeE, GroupE:IDMElement;
  FinishNode:IPathNode;
  GuardVariant:IGuardVariant;
  PathNodeArray:IPathNodeArray;
  FacilityModel:IFacilityModel;
  FinishPointE, ZoneE:IDMElement;
  AreaList, VolumeList:TList;
  Tmin:double;
  Volume:IVolume;
  GuardModel:IGuardModel;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  GuardModel:=FacilityModel as IGuardModel;
  AreaList:=TList.Create;
  VolumeList:=TList.Create;
  GuardVariant:=FAnalysisVariant.GuardVariant as IGuardVariant;
  for j:=0 to GuardVariant.GuardGroups.Count-1 do begin

    if TerminateFlag then Exit;

    GroupE:=GuardVariant.GuardGroups.Item[j];
    GroupW:=GroupE as IWarriorGroup;
    GroupG:=GroupE as IGuardGroup;
    GroupG2:=GroupE as IGuardGroup2;

    FPathStage:=wpsFastEntry;

    if (GroupW.Task=gtInterruptOnDetectionPoint) or
       (GroupW.Task=gtInterruptOnTarget) or
       (GroupW.Task=gtInterruptOnExit)then begin
      if FAnalysisVariant.GuardStrategy=0 then begin
        FinishPointE:=FAnalysisVariant.MainGroup.FinishPoint;
        ZoneE:=FinishPointE.Parent;
        if GroupW.GetAccessTypeToZone(ZoneE, True)<>0 then begin // охрана допущена к цели
          PathNodeArray:=FinishPointE as IPathNodeArray;
          if PathNodeArray=nil then begin
            FinishNode:=nil
          end else begin
            if PathNodeArray.PathNodes.Count>0 then
              FinishNode:=PathNodeArray.PathNodes.Item[0] as IPathNode
            else
              FinishNode:=nil;
          end;
          Tmin:=0;
        end else begin                    // охрана не допущена к цели
          Tmin:=InfinitValue;
          FinishNode:=nil;

          AreaList.Clear;
          VolumeList.Clear;
          Volume:=ZoneE.SpatialElement as IVolume;
          VolumeList.Add(pointer(Volume));
          while VolumeList.Count>0 do begin
            Volume:=IVolume(VolumeList[0]);        // ищем точку входа нарушителей
            ProcessVolume(Volume, AreaList, VolumeList, // в зону, недоступную охране,
                          Tmin, FinishNode);      // и время их движения от этой точки до цели
            VolumeList.Delete(0);
          end;
        end; // if GroupW.GetAccessTypeToZone(ZoneE, True)<>0
      end else begin // if FAnalysisVariant.GuardStrategy=1
        Tmin:=0;
        FinishNode:=nil;
        ZoneE:=FacilityModel.Enviroments;
        ProcessZone1(ZoneE, FinishNode); // ищем точку выхода нарушителей с Объекта
      end;

      FinishNodeE:=FinishNode as IDMElement;

      GroupG2.LastNode:=FinishNodeE; // Точка входа нарушителей в зону, не доступную данному подразделению охраны
      GroupG2.TimeLimit:=Tmin;       // Запас времени у нарушителей, связанный с отсутствием доступа у охраны
    end; // if (GroupW.Task=gtInterruptOnTarget) or ...

  end; // for j:=0 to GuardVariant.GuardGroups.Count-1
  AreaList.Free;
  VolumeList.Free;
end;  // FindGuardFinishPoints

procedure TSafeguardAnalyzer.ClearCash;
var
  j:integer;
  Boundary:IBoundary;
  aFacilityModel:IFacilityModel;
begin
  aFacilityModel:=Get_Data as IFacilityModel;

  for j:=0 to aFacilityModel.Boundaries.Count-1 do begin
    Boundary:=aFacilityModel.Boundaries.Item[j] as IBoundary;
    Boundary.ClearCash(True);
  end;

  for j:=0 to aFacilityModel.Jumps.Count-1 do begin
    Boundary:=aFacilityModel.Jumps.Item[j] as IBoundary;
    Boundary.ClearCash(True);
  end;

  for j:=0 to aFacilityModel.Targets.Count-1 do begin
    Boundary:=aFacilityModel.Targets.Item[j]as IBoundary;
    Boundary.ClearCash(True);
  end;
end;

{ TGuardArrivalTimeSorter }

function TGuardArrivalTimeSorter.Compare(const Key1,
  Key2: IDMElement): integer;
var
  GuardGroup1, GuardGroup2:IWarriorGroup;
  T1, T2:double;
begin
  GuardGroup1:=Key1 as IWarriorGroup;
  GuardGroup2:=Key2 as IWarriorGroup;
  T1:=GuardGroup1.ArrivalTime;
  T2:=GuardGroup2.ArrivalTime;
  if T1<T2 then
    Result:=-1
  else
  if T1>T2 then
    Result:=+1
  else
    Result:=0
end;

{ TFMRecomendationSorter }

function TFMRecomendationSorter.Compare(const Key1,
  Key2: IDMElement): Integer;
var
  P1, P2:double;
begin
  if Key1.DataModel.IsLoading then begin
    Result:=inherited Compare(Key1, Key2);
    Exit;
  end;
  P1:=(Key1 as IFMRecomendation).Priority;
  P2:=(Key2 as IFMRecomendation).Priority;
  if P1<P2 then
    Result:=-1
  else if P1>P2 then
    Result:=+1
  else begin
    Result:=0;
  end;
end;

function TFMRecomendationSorter.Get_Duplicates: WordBool;
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

  P1:=(Key1 as IWarriorPath).RationalProbability;
  P2:=(Key2 as IWarriorPath).RationalProbability;

  if P1>P2 then
    Result:=-1
  else if P1<P2 then
    Result:=+1
  else begin
    P1:=(Key1 as IWarriorPath).DelayTime;
    P2:=(Key2 as IWarriorPath).DelayTime;
    if P1<P2 then
      Result:=-1
    else if P1>P2 then
      Result:=+1
    else
      Result:=0;
  end;
end;

function TWarriorPathSorter.Get_Duplicates: WordBool;
begin
  Result:=True
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


{ TSafeguardAnalyzerFactory }

function TSafeguardAnalyzerFactory.CreateInstance: IUnknown;
begin
  Result:=TSafeguardAnalyzer.Create(nil) as IUnknown;
end;

function GetDataModelClassObject:IDMClassFactory;
begin
  Result:=TSafeguardAnalyzerFactory.Create(nil) as IDMClassFactory
end;

initialization
//  CreateTypedComObjectFactory(TSafeguardAnalyzer, Class_SafeguardAnalyzer);
end.
