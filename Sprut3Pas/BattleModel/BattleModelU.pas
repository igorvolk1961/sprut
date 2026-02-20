
unit BattleModelU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj,
  Classes, SysUtils, Math, StdVcl,
  FacilityModelLib_TLB,
  DMComObjectU, DataModelU, DMAnalyzerU,
  DataModel_TLB,
  DMServer_TLB, SpatialModelLib_TLB, SgdbLib_TLB,
  SafeguardAnalyzerLib_TLB,
  BattleModelLib_TLB,
  Variants;

function GetDataModelClassObject:IDMClassFactory;

type
  TBattleModelFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;

  TBattleModel = class(TDMAnalyzer, IBattleModel)
  private
    FTimeArray:TList;
    FMainStartNode: IPathNode;
    FNextToMainStartNode: IPathNode;
    FMainGroup:IWarriorGroup;
    FDefaultTimeStep:double;
    FMaxTimeStep:double;
    FTimeStep:double;
    FCurrentTime:double;
    FGuardLayer:IDMElement;
    FAdversaryLayer:IDMElement;
    FBattleLineLayer:IDMElement;
  protected
    function  CreateCollection(aClassID:integer; const aParent:IDMElement): IDMCollection; override; safecall;

    procedure Clear; override;
    function GetStageName:string; override;
    function CalcStepCount:integer; override;
    procedure DoAnalysis; override;

    procedure MakeCollections; override;

    procedure TreatElement(const Element: IDMElement; aMode: Integer); override; safecall;

    function  Get_BattleLayers: IDMCollection; safecall;
    function  Get_BattleLines: IDMCollection; safecall;
    function  Get_BattleUnits: IDMCollection; safecall;
    function  Get_FacilityModel: IUnknown; safecall;
    procedure Set_FacilityModel(const Value: IUnknown); safecall;
    function  Get_StartNode: IUnknown; safecall;
    procedure Set_StartNode(const Value: IUnknown); safecall;
    function  Get_NextToStartNode: IUnknown; safecall;
    procedure Set_NextToStartNode(const Value: IUnknown); safecall;
    function  Get_DefaultTimeStep: Double; safecall;
    procedure Set_DefaultTimeStep(Value: Double); safecall;
    function  Get_CurrentTime:double; safecall;
    function  Get_TimeArray(Index: Integer): Double; safecall;
    function  Get_TimeArrayCount: integer; safecall;

    procedure ClearBattle; safecall;
    procedure StartBattle; safecall;
    procedure StartBattle2; safecall;
    function NextStep:WordBool; safecall;
    function CalcSccessProbabilityOnPath(const PolylineU:IUnknown):double; safecall;

    procedure InitLayers;

    procedure Start(aMode: Integer); override; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

type
  PBattleModelMem = ^TBattleModelMem;

  TBattleModelMem = record
    time: double;
  end;

implementation

uses
  BattleModelConstU,
  BattleUnitU,
  BattleLineU,
  BattleLayerU;

const
  InfinitValue=1000000000;

  
{ TBattleModel }

function TBattleModel.CalcStepCount: integer;
begin
  Result:=100000000
end;

procedure TBattleModel.DoAnalysis;

var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  PolylineU:IUnknown;
  AnalysisVariant:IAnalysisVariant;
  OldState:integer;
  OptimalPathE:IDMElement;


begin

  DMDocument:=(Get_Data as IDataModel).Document as IDMDocument;
  Server:=DMDocument.Server;
  aFacilityModel:=Get_Data as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  OldState:=DMDocument.State;
  
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;

  if AnalysisVariant.WarriorPaths.Count=0 then Exit;
  OptimalPathE:=AnalysisVariant.WarriorPaths.Item[0];
  PolylineU:=OptimalPathE.SpatialElement as IUnknown;

  DMDocument.State:=DMDocument.State or dmfCommiting;
  try
    CalcSccessProbabilityOnPath(PolylineU)
  finally
    DMDocument.State:=OldState;
  end
end;

function TBattleModel.GetStageName: string;
begin
  case FStage of
  0:Result:='Выполняется моделирование боя'+#13+#13+
            'Очистка результатов предыдущего расчета';
  else
    Result:='';
  end;
end;

destructor TBattleModel.Destroy;
var
    j:integer;
begin
  inherited;
  for j:=FTimeArray.Count-1 downto 0 do
    FreeMem(FTimeArray[j],SizeOf(TBattleUnitMem));
  FTimeArray.Free;

  FMainStartNode:=nil;
  FNextToMainStartNode:=nil;
  FMainGroup:=nil;
  FGuardLayer:=nil;
  FAdversaryLayer:=nil;
end;

procedure TBattleModel.Initialize;
begin
  inherited;
  FTimeArray:=TList.Create;
  FDefaultTimeStep:=5;
end;

procedure TBattleModel.MakeCollections;
begin
  inherited;
  AddClass(TBattleUnits);
  AddClass(TBattleLines);
  AddClass(TBattleLayers);

  InitLayers
end;

function TBattleModel.Get_BattleLines: IDMCollection;
begin
  Result:=Collection[_BattleLine]
end;

function TBattleModel.Get_BattleUnits: IDMCollection;
begin
  Result:=Collection[_BattleUnit]
end;

procedure TBattleModel.TreatElement(const Element: IDMElement;
  aMode: Integer);
begin
end;

procedure TBattleModel.Clear;
begin
  inherited;
end;

function TBattleModel.Get_FacilityModel: IUnknown;
begin
  Result:=Get_Data as IUnknown;
end;

procedure TBattleModel.Set_FacilityModel(const Value: IInterface);
var
  FacilityModel:IFacilityModel;
begin
  FDataModel:=pointer(Value as IDataModel);
  FacilityModel:=DataModel as  IFacilityModel;
  FacilityModel.BattleModel:=Self as IUnknown;
end;

function TBattleModel.Get_StartNode: IUnknown;
begin
  Result:=FMainStartNode as IUnknown
end;

procedure TBattleModel.Set_StartNode(const Value: IInterface);
begin
  FMainStartNode:=Value as IPathNode;
end;

procedure TBattleModel.ClearBattle;
var
  j:integer;
  Collection:IDMCollection;
  BattleLineE, BattleUnitE:IDMElement;
begin
  for j:=FTimeArray.Count-1 downto 0 do
    FreeMem(FTimeArray[j],SizeOf(TBattleUnitMem));
  FTimeArray.Clear;

  Collection:=Get_BattleLines;
  while Collection.Count>0 do begin
    BattleLineE:=Collection.Item[0];
    BattleLineE.Clear;
    (Collection as IDMCollection2).Delete(0)
  end;

  Collection:=Get_BattleUnits;
  while Collection.Count>0 do begin
    BattleUnitE:=Collection.Item[0];
    BattleUnitE.Clear;
    (Collection as IDMCollection2).Delete(0)
  end;

  FMaxTimeStep:=FDefaultTimeStep;

  FTimeStep:=FMaxTimeStep;
  FCurrentTime:=0;
end;

procedure TBattleModel.StartBattle;
var
  aGuardVariant:IGuardVariant;
  aAdversaryVariant:IAdversaryVariant;
  Analyzer:ISafeguardAnalyzer;
  j, j0, j1:integer;
  BattleLines2, BattleUnits2:IDMCollection2;
  BattleLineE, BattleUnitE, GroupE, StartPointE:IDMElement;
  Group:IWarriorGroup;
  BattleUnit:IBattleUnit;
  Node, Unit0, Unit1:ICoordNode;
  StartNodeE:IDMElement;
  BattleLine:ILine;
  MainPathP:IPolyline;
  OldCurrentWarriorGroup:IDMElement;
//  Mem:PBattleModelMem;

  function FindNearestNode(const GroupE:IDMElement;
                           const Polyline:IPolyline):IDMElement;
  var
    m:integer;
    Line:ILine;
    C0, C1:IVulnerabilityData;
    MinTime, Time:double;
  begin
    Result:=nil;
    MinTime:=InfinitValue;
    for m:=0 to Polyline.Lines.Count-1 do begin
      Line:=Polyline.Lines.Item[m] as ILine;
      C0:=Line.C0 as IVulnerabilityData;
      C1:=Line.C1 as IVulnerabilityData;
      Time:=C0.DelayTimeToTarget;
      if MinTime>Time then begin
        MinTime:=Time;
        Result:=C0 as IDMElement;
      end;
      Time:=C1.DelayTimeToTarget;
      if MinTime>Time then begin
        MinTime:=Time;
        Result:=C1 as IDMElement;
      end;
    end;
  end;

  procedure MakeBattleUnit(const GroupE:IDMElement; const Kind:integer);
  var
    WarriorPathE:IDMElement;
    PolylineE:IDMElement;
    Polyline:IPolyline;
    T, TimeToTarget, NextTimeToTarget:double;
    i, m, j:integer;
    PathNode:IVulnerabilityData;
    PathArc:IPathArc;
    aLine:ILine;
    aNode:ICoordNode;
    PatrolPathE:IDMElement;
    PatrolPath:IPatrolPath;
    PatrolPathP:IPolyline;
    MaxDist, MinDist, Dist:double;
    WorstNode, NextToMainStartNode:ICoordNode;
    SpatialModel2:ISpatialModel2;
    VolumeE:IDMElement;
    Zone:IZone;
    IsPatrol:boolean;
    FacilityModel:IFacilityModel;
    FacilityModelS:IFMState;
  begin
    FacilityModel:=Get_Data as IFacilityModel;
    FacilityModelS:=FacilityModel as IFMState;
    Group:=GroupE as IWarriorGroup;
    if Group.StartPoint=nil then Exit;

    BattleUnitE:=BattleUnits2.CreateElement(False);
    BattleUnits2.Add(BattleUnitE);
    BattleUnitE.Ref:=GroupE;
    if Kind>=bukGuard then
      BattleUnitE.Parent:=FGuardLayer
    else
      BattleUnitE.Parent:=FAdversaryLayer;

    Node:=BattleUnitE as ICoordNode;

    BattleUnit:=BattleUnitE as IBattleUnit;

    FacilityModelS.CurrentWarriorGroupU:=GroupE;

    IsPatrol:=False;

    if Kind=bukMainGroup then begin

      WarriorPathE:=nil;
      Analyzer.MakePathFrom(FMainStartNode as IDMElement, False,
                    pkFastPath, True, WarriorPathE);
      (WarriorPathE as IWarriorPath).Build(tmToRoot, False, True, nil);
      (WarriorPathE as IWarriorPath).DoAnalysis(nil, True);
      WarriorPathE.Name:=GroupE.Name;
      PolylineE:=WarriorPathE.SpatialElement;
      Polyline:=PolylineE as IPolyline;
      MainPathP:=Polyline;
      BattleUnit.Path:=Polyline.Lines;

      aNode:=FMainStartNode as ICoordNode;
      PathNode:=aNode as IVulnerabilityData;
      TimeToTarget:=PathNode.DelayTimeToTarget;
      for i:=0 to Polyline.Lines.Count-1 do begin
        aLine:=Polyline.Lines.Item[i] as ILine;
        PathArc:=aLine as IPathArc;
        aNode:=aLine.NextNodeTo(aNode);
        PathNode:=aNode as IVulnerabilityData;
        NextTimeToTarget:=PathNode.DelayTimeToTarget;
        PathArc.Value:=TimeToTarget-NextTimeToTarget;
        TimeToTarget:=NextTimeToTarget;
      end;

      BattleUnit.CurrentNode:=FMainStartNode as IDMElement;
      StartNodeE:=FMainStartNode as IDMElement;
    end else begin // Kind<>bukMainGroup
      m:=0;
      PatrolPathE:=nil;
      PatrolPath:=nil;
      while m<FacilityModel.PatrolPaths.Count do begin
        PatrolPathE:=FacilityModel.PatrolPaths.Item[m];
        PatrolPath:=PatrolPathE as IPatrolPath;
        if PatrolPath.WarriorGroup=Group then
          Break
        else
          inc(m);
      end;
      if m<FacilityModel.PatrolPaths.Count then begin
        IsPatrol:=True;
        PatrolPathP:=PatrolPathE.SpatialElement as IPolyline;
        MaxDist:=0;
        WorstNode:=nil;
        NextToMainStartNode:=FNextToMainStartNode as ICoordNode;
        for j:=0 to PatrolPathP.Lines.Count-1 do begin
          aLine:=PatrolPathP.Lines.Item[j] as ILine;
          aNode:=aLine.C0;
          Dist:=sqrt(sqr(aNode.X-NextToMainStartNode.X)+
                     sqr(aNode.Y-NextToMainStartNode.Y)+
                     sqr(aNode.Z-NextToMainStartNode.Z));
          if MaxDist<Dist then begin
            MaxDist:=Dist;
            WorstNode:=aNode;
          end;
          aNode:=aLine.C1;
          Dist:=sqrt(sqr(aNode.X-NextToMainStartNode.X)+
                     sqr(aNode.Y-NextToMainStartNode.Y)+
                     sqr(aNode.Z-NextToMainStartNode.Z));
          if MaxDist<Dist then begin
            MaxDist:=Dist;
            WorstNode:=aNode;
          end;
        end;
        SpatialModel2:=FacilityModel as ISpatialModel2;
        VolumeE:=SpatialModel2.GetVolumeContaining(WorstNode.X, WorstNode.Y, WorstNode.Z) as IDMElement;
        Zone:=VolumeE.Ref as IZone;
        MinDist:=InfinitValue;
        StartNodeE:=nil;
        for j:=0 to Zone.FloorNodes.Count-1 do begin
          aNode:=Zone.FloorNodes.Item[j] as  ICoordNode;
          Dist:=sqrt(sqr(aNode.X-WorstNode.X)+
                     sqr(aNode.X-WorstNode.X)+
                     sqr(aNode.X-WorstNode.X));
          if MinDist>Dist then begin
             MinDist:=Dist;
             StartNodeE:=aNode as IDMElement;
          end;
        end;

        WarriorPathE:=Analyzer.BuildPatrolPath(GroupE, StartNodeE, FNextToMainStartNode as IDMElement);
      end else begin  // IsPatrol=False
        StartPointE:=Group.StartPoint;
        if (StartPointE.SpatialElement<>nil) and
           (StartPointE.SpatialElement.QueryInterface(ICoordNode, aNode)<>0) then
          aNode:=(StartPointE.SpatialElement as ILine).C0;

        StartNodeE:=(StartPointE as IPathNodeArray).PathNodes.Item[0];

        if Kind>=bukGuard then
          case Group.Task of
          gtTakePosition:
            if (Group.FinishPoint<>nil) and
              (PatrolPathE=nil) and
              (Group.StartPoint<>Group.FinishPoint) then
              WarriorPathE:=Group.FastPath as IDMElement
            else
              WarriorPathE:=nil;
          gtInterruptOnDetectionPoint:
            begin
              WarriorPathE:=nil;
              Analyzer.MakePathFrom(FNextToMainStartNode as IDMElement, True,
                                        pkFastPath, True, WarriorPathE);
              if WarriorPathE<>nil then begin
                (WarriorPathE as IWarriorPath).Build(tmFromRoot, False, True, nil);
                (WarriorPathE as IWarriorPath).DoAnalysis(nil, True);
              end;
            end;
          gtStayOnPost,
          gtPatrol:
            WarriorPathE:=nil;
          else
            WarriorPathE:=nil;
          end
        else  // Kind=bukAdversary
          WarriorPathE:=Group.FastPath as IDMElement;
      end; // IsPatrol=False

      if WarriorPathE<>nil then
        BattleUnit.Path:=(WarriorPathE.SpatialElement as IPolyline).Lines
      else
        BattleUnit.Path:=nil;
    end; // Kind<>bukMainGroup

    if (BattleUnit.Path<>nil) and
       (BattleUnit.Path.Count>0) then begin
      aLine:=BattleUnit.Path.Item[0] as ILine;
//      if Kind<>bukAdversary then begin
        if (aLine.C0 as IDMElement)=StartNodeE then
          BattleUnit.CurrentNode:=aLine.C0 as IDMElement
        else
          BattleUnit.CurrentNode:=aLine.C1 as IDMElement
{      end else begin         // исходная точка в бесклнечности
        if (aLine.C0 as IDMElement)=StartNodeE then
          BattleUnit.CurrentNode:=aLine.C1 as IDMElement
        else
          BattleUnit.CurrentNode:=aLine.C0 as IDMElement
      end;
}
    end else begin
      BattleUnit.CurrentNode:=StartNodeE
    end;

    BattleUnit.FacilityModel:=FacilityModel as IDMElement;
    if IsPatrol then
      BattleUnit.Kind:=bukPatrol
    else
      BattleUnit.Kind:=Kind;

    T:=BattleUnit.StartBattle(FTimeStep);
    if FTimeStep>T then
      FTimeStep:=T
  end;

var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  CurrentAnalysisVariant:IAnalysisVariant;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  CurrentAnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if CurrentAnalysisVariant=nil then Exit;
  Analyzer:=(Get_Data as IDataModel).Analyzer as ISafeguardAnalyzer;

  aGuardVariant:=CurrentAnalysisVariant.GuardVariant as IGuardVariant;
  aAdversaryVariant:=CurrentAnalysisVariant.AdversaryVariant as IAdversaryVariant;
  FMainGroup:=CurrentAnalysisVariant.MainGroup;
  OldCurrentWarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  MainPathP:=nil;

  BattleUnits2:=Get_BattleUnits as IDMCollection2;
  for j:=0 to aAdversaryVariant.AdversaryGroups.Count-1 do begin
    GroupE:=aAdversaryVariant.AdversaryGroups.Item[j];
    if GroupE<>(FMainGroup as IDMElement) then
      MakeBattleUnit(GroupE, bukAdversary)
    else
      MakeBattleUnit(GroupE, bukMainGroup)
  end;
  for j:=0 to aGuardVariant.GuardGroups.Count-1 do begin
    GroupE:=aGuardVariant.GuardGroups.Item[j];
    MakeBattleUnit(GroupE, bukGuard);
  end;

  BattleLines2:=Get_BattleLines as IDMCollection2;

  for j0:=0 to aGuardVariant.GuardGroups.Count-1 do begin
    GroupE:=aGuardVariant.GuardGroups.Item[j0];
    Unit0:=GroupE.SpatialElement as ICoordNode;
    for j1:=0 to aAdversaryVariant.AdversaryGroups.Count-1 do begin
      GroupE:=aAdversaryVariant.AdversaryGroups.Item[j1];
      Unit1:=GroupE.SpatialElement as ICoordNode;
      BattleLineE:=BattleLines2.CreateElement(False);
      BattleLines2.Add(BattleLineE);
      BattleLineE.Parent:=FBattleLineLayer;
      BattleLine:=BattleLineE as ILine;
      BattleLine.C0:=Unit0;
      BattleLine.C1:=Unit1;
      (BattleLine as IBattleLine).FacilityModel:=FacilityModel as IDMElement;
    end;
  end;

  FacilityModelS.CurrentWarriorGroupU:=OldCurrentWarriorGroup;
end;

function TBattleModel.NextStep:WordBool;
var
  BattleUnits, BattleLines:IDMCollection;
  j:integer;
  MinTimeStep, T:double;
  Group:IWarriorGroup;
  BattleUnit:IBattleUnit;
  BattleUnitE:IDMElement;
  Unk:IUnknown;
  P:double;
  BattleLine:IBattleLine;
  Mem:PBattleModelMem;
//  GuardGroup:IGuardGroup;
begin
  Result:=True;

  FCurrentTime:=FCurrentTime+FTimeStep;

//Заполнение массива времен
    GetMem(Mem,SizeOf(TBattleModelMem));
    FTimeArray.Add(Mem);
    Mem.time:=FCurrentTime;

  MinTimeStep:=FMaxTimeStep;
  BattleUnits:=Get_BattleUnits;
  try
  for j:=0 to BattleUnits.Count-1 do begin
    BattleUnitE:=BattleUnits.Item[j];
    BattleUnit:=BattleUnitE as IBattleUnit;
    T:=BattleUnit.NextStep(FMaxTimeStep, FTimeStep);
    Group:=BattleUnitE.Ref as IWarriorGroup;
    if (Group.QueryInterface(IAdversaryGroup, Unk)=0) and
       (Group.Task=0) then begin
      if (BattleUnit.InDefence) or
         (BattleUnit.SomebodyAlive<1.e-6) then begin
        Result:=False;
        Exit;
      end;
    end;
    if MinTimeStep>T then
      MinTimeStep:=T;
  end;
  except
    raise
  end;

  try
  BattleLines:=Get_BattleLines;
  for j:=0 to BattleLines.Count-1 do
    (BattleLines.Item[j] as IBattleLine).CheckFireLine;
  except
    raise
  end;  

  for j:=0 to BattleLines.Count-1 do
    (BattleLines.Item[j] as IBattleLine).CalcThreat;
  for j:=0 to BattleUnits.Count-1 do
    (BattleUnits.Item[j] as IBattleUnit).CalcTakeAimTime;
  P:=0;
  for j:=0 to BattleLines.Count-1 do begin
    BattleLine:=BattleLines.Item[j] as IBattleLine;
    BattleLine.CalcScoreProbability(FTimeStep);
    P:=P+BattleLine.ScoreProbability01+BattleLine.ScoreProbability10;
  end;


    FTimeStep:=MinTimeStep;
  if FTimeStep<>FMaxTimeStep then
    FMaxTimeStep:=FDefaultTimeStep
  else
  if P=0 then
    FMaxTimeStep:=FMaxTimeStep*1.2;


  for j:=0 to BattleUnits.Count-1 do
    begin
      BattleUnitE:=BattleUnits.Item[j];
      BattleUnit:=BattleUnitE as IBattleUnit;
      BattleUnit.StoreState;
    end;

  for j:=0 to BattleLines.Count-1 do
    (BattleLines.Item[j] as IBattleLine).CalcAliveHope;

end;

function TBattleModel.Get_DefaultTimeStep: Double;
begin
  Result:=FDefaultTimeStep
end;

procedure TBattleModel.Set_DefaultTimeStep(Value: Double);
begin
  FDefaultTimeStep:=Value
end;

function TBattleModel.Get_CurrentTime: double;
begin
  Result:=FCurrentTime
end;

function TBattleModel.Get_BattleLayers: IDMCollection;
begin
  Result:=Collection[_BattleLayer]
end;

procedure TBattleModel.InitLayers;
var
  Collection2:IDMCollection2;
begin
  inherited;
  Collection2:=Get_BattleLayers as IDMCollection2;

  FAdversaryLayer:=Collection2.CreateElement(False);
  Collection2.Add(FAdversaryLayer);
  (FAdversaryLayer as ILayer).Color:=$0000FF;
  (FAdversaryLayer as ILayer).Visible:=True;
  FAdversaryLayer.Name:='Нарушители';

  FGuardLayer:=Collection2.CreateElement(False);
  Collection2.Add(FGuardLayer);
  (FGuardLayer as ILayer).Color:=$FF0000;
  (FGuardLayer as ILayer).Visible:=True;
  FGuardLayer.Name:='Охрана';

  FBattleLineLayer:=Collection2.CreateElement(False);
  Collection2.Add(FBattleLineLayer);
  (FBattleLineLayer as ILayer).Color:=$0000FF;
  (FBattleLineLayer as ILayer).Visible:=True;
  FBattleLineLayer.Name:='Линии огня';
end;

function TBattleModel.Get_TimeArray(index: integer): double;
begin
  Result:=PBattleModelMem(FTimeArray[index]).time;
end;

function TBattleModel.Get_TimeArrayCount: integer;
begin
  Result:=FTimeArray.Count;
end;

function TBattleModel.Get_NextToStartNode: IUnknown;
begin
  Result:=FNextToMainStartNode as IUnknown
end;

procedure TBattleModel.Set_NextToStartNode(const Value: IInterface);
begin
  FNextToMainStartNode:=Value as IPathNode;
end;


function TBattleModel.CalcSccessProbabilityOnPath(const PolylineU: IUnknown):double;
var
  WarriorGroupE, FacilityStateE, aLineE:IDMElement;
  aLine:ILine;
  T, P, Q:double;
  BattleUnits:IDMCollection;
  MainBattleUnit:IBattleUnit;
  Server:IDataModelServer;
  j, N:integer;
  AnalysisVariant:IAnalysisVariant;
  AnalysisVariantE:IDMElement;
//  Number:integer;

  procedure TreatFacilityElement(const FacilityElement:IFacilityElement;
                                 const C:ICoordNode);
  var
    Direction, m:integer;
    FacilityElementE, BestTacticE:IDMElement;
    FacilityElementPE:IPathElement;
    CV:IVulnerabilityData;
    dT, dTDisp, DetP, dQ:double;
    NoDetPCent,
    NoPrelDetPCent:double;
    NoEvidence:WordBool;
    S:WideString;
    FacilityModelS:IFMState;
    BestTimeSum, BestTimeDispSum:double;
    Position:integer;
  begin
    FacilityModelS:=Get_Data as IFMState;
    CV:=C as IVulnerabilityData;
    FacilityElementPE:=FacilityElement as IPathElement;
    FacilityElementE:=FacilityElement as IDMElement;
    if C=aLine.C1 then
      Direction:=pdFrom0To1  // наоборот, так как перебор линий с конца
    else
      Direction:=pdFrom1To0;

    FacilityModelS.CurrentWarriorGroupU:=WarriorGroupE;
    FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
    FacilityModelS.CurrentLineU:=aLineE;
    FacilityModelS.CurrentNodeDirection:=Direction;

    FacilityModelS.CurrentPathStage:=wpsFastEntry;

    FacilityElementPE.CalcDelayTime(dT, dTDisp, BestTacticE, 0);

    FacilityModelS.CurrentPathStage:=wpsStealthEntry;

    FacilityElementPE.CalcNoDetectionProbability(
                           NoDetPCent,
                           NoPrelDetPCent,
                           NoEvidence,
                           BestTimeSum, BestTimeDispSum,
                           Position,
                           BestTacticE, 0);
    DetP:=1-NoDetPCent;

    T:=T+dT;
    P:=P*(1-DetP);

    if CV<>nil then begin
      Set_StartNode(CV as IUnknown);
      StartBattle;

      m:=0;
      while m<BattleUnits.Count do begin
        if BattleUnits.Item[m].Ref=WarriorGroupE then
          Break
        else
          inc(m)
      end;
      if m<BattleUnits.Count then
        MainBattleUnit:=BattleUnits.Item[m] as  IBattleUnit;

      while NextStep do;

      dQ:=MainBattleUnit.SomebodyAlive;

      S:=Format('Вариант "%s"'#13+
                'Моделирование боевого столкновения.'#13+
                'При обнаружении в точке %d из %d'#13+
                '"%s"'#13+
                'вероятность успеха нарушителей %0.4f',
        [AnalysisVariantE.Name, j, N, FacilityElementE.Name, dQ]);

      Server.NextAnalysisStage(S, 0, 0);

      Q:=Q*(1-DetP)+dQ*DetP;
    end;

  end;

var
  Polyline:IPolyline;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  SpatialModel2:ISpatialModel2;
  C, NextC:ICoordNode;
  CV:IVulnerabilityData;
  LineRef:IDMElement;
  Volume0, Volume1:IVolume;
  FacilityElement0, FacilityElement1, FacilityElement: IFacilityElement;
begin
  Polyline:=PolylineU as IPolyline;

  aFacilityModel:=Get_Data as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  Server:=((Get_Data as IDataModel).Document as IDMDocument).Server;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;
  AnalysisVariantE:=AnalysisVariant as IDMElement;
  WarriorGroupE:=AnalysisVariant.MainGroup as IDMElement;
//  Number:=AnalysisVariant.MainGroup.InitialNumber;
  BattleUnits:=Get_BattleUnits;

  SpatialModel2:=aFacilityModel as ISpatialModel2;
  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;


  T:=0;
  P:=1;
  Q:=1;

  C:=(Polyline.Lines.Item[Polyline.Lines.Count-1] as ILine).C0;
  if (C=(Polyline.Lines.Item[Polyline.Lines.Count-2] as ILine).C0) or
     (C=(Polyline.Lines.Item[Polyline.Lines.Count-2] as ILine).C1) then
    C:=(Polyline.Lines.Item[Polyline.Lines.Count-1] as ILine).C1;
  C.QueryInterface(IVulnerabilityData, CV);
  N:=Polyline.Lines.Count;
  try
  for j:=N-1 downto 0 do begin
    aLineE:=Polyline.Lines.Item[j];
    aLine:=aLineE as ILine;
    NextC:=aLine.NextNodeTo(C);

    LineRef:=aLineE.Ref;

    if LineRef=nil then begin
      Volume0:=SpatialModel2.GetVolumeContaining(C.X, C.Y, C.Z);
      Volume1:=SpatialModel2.GetVolumeContaining(NextC.X, NextC.Y, NextC.Z);
      if Volume0=nil then
        FacilityElement0:=nil;
      if Volume1=nil then
        FacilityElement1:=nil;
      if (Volume0=nil) and
         (Volume1=nil) then
        FacilityElement:=nil
      else begin
        if Volume0=Volume1 then begin
          FacilityElement0:=nil;
          FacilityElement :=(Volume0 as IDMElement).Ref as IFacilityElement;
          FacilityElement1:=nil;
        end else begin
        end;
      end;
    end else begin
      FacilityElement0:=nil;
      LineRef.QueryInterface(IFacilityElement, FacilityElement);
      FacilityElement1:=nil;
    end;
    if FacilityElement0<>nil then
      TreatFacilityElement(FacilityElement0, C);
    if FacilityElement<>nil then
      TreatFacilityElement(FacilityElement, C);
    if FacilityElement1<>nil then
      TreatFacilityElement(FacilityElement1, C);

    C:=NextC;
    C.QueryInterface(IVulnerabilityData, CV);
  end;
  except
    raise
  end;

  AnalysisVariant.BattleSystemEfficiency:=1-Q;
end;

procedure TBattleModel.Start(aMode: Integer);
var
  Document:IDMDocument;
  Server:IDataModelServer;
begin
  Document:=(Get_Data as IDataModel).Document as IDMDocument;
  Server:=Document.Server;
  Document.State:=Document.State or dmfExecuting;
  try
    DoAnalysis;
  finally
    Document.State:=Document.State and not dmfExecuting;
  end;
end;

function TBattleModel.CreateCollection(aClassID: integer; const aParent:IDMElement): IDMCollection;
begin
  Result:= inherited CreateCollection(aClassID, aParent)
end;

procedure TBattleModel.StartBattle2;
var
  aGuardVariant:IGuardVariant;
  aAdversaryVariant:IAdversaryVariant;
  Analyzer:ISafeguardAnalyzer;
  j, j0, j1:integer;
  BattleLines2, BattleUnits2:IDMCollection2;
  BattleLineE, BattleUnitE, GroupE, StartPointE:IDMElement;
  Group:IWarriorGroup;
  BattleUnit:IBattleUnit;
  Node, Unit0, Unit1:ICoordNode;
  StartNodeE:IDMElement;
  BattleLine:ILine;
  MainPathP:IPolyline;
  OldCurrentWarriorGroup:IDMElement;
//  Mem:PBattleModelMem;

  function FindNearestNode(const GroupE:IDMElement;
                           const Polyline:IPolyline):IDMElement;
  var
    m:integer;
    Line:ILine;
    C0, C1:IVulnerabilityData;
    MinTime, Time:double;
  begin
    Result:=nil;
    MinTime:=InfinitValue;
    for m:=0 to Polyline.Lines.Count-1 do begin
      Line:=Polyline.Lines.Item[m] as ILine;
      C0:=Line.C0 as IVulnerabilityData;
      C1:=Line.C1 as IVulnerabilityData;
      Time:=C0.DelayTimeToTarget;
      if MinTime>Time then begin
        MinTime:=Time;
        Result:=C0 as IDMElement;
      end;
      Time:=C1.DelayTimeToTarget;
      if MinTime>Time then begin
        MinTime:=Time;
        Result:=C1 as IDMElement;
      end;
    end;
  end;

  procedure MakeBattleUnit(const GroupE:IDMElement; const Kind:integer);
  var
    WarriorPathE:IDMElement;
    PolylineE:IDMElement;
    Polyline:IPolyline;
    T, TimeToTarget, NextTimeToTarget:double;
    i, m, j:integer;
    PathNode:IVulnerabilityData;
    PathArc:IPathArc;
    aLine:ILine;
    aNode:ICoordNode;
    PatrolPathE:IDMElement;
    PatrolPath:IPatrolPath;
    PatrolPathP:IPolyline;
    MaxDist, MinDist, Dist:double;
    WorstNode, NextToMainStartNode:ICoordNode;
    SpatialModel2:ISpatialModel2;
    VolumeE:IDMElement;
    Zone:IZone;
    IsPatrol:boolean;
    FacilityModel:IFacilityModel;
    FacilityModelS:IFMState;
  begin
    FacilityModel:=Get_Data as IFacilityModel;
    FacilityModelS:=FacilityModel as IFMState;
    Group:=GroupE as IWarriorGroup;
    if Group.StartPoint=nil then Exit;

    BattleUnitE:=BattleUnits2.CreateElement(False);
    BattleUnits2.Add(BattleUnitE);
    BattleUnitE.Ref:=GroupE;
    if Kind>=bukGuard then
      BattleUnitE.Parent:=FGuardLayer
    else
      BattleUnitE.Parent:=FAdversaryLayer;

    Node:=BattleUnitE as ICoordNode;

    BattleUnit:=BattleUnitE as IBattleUnit;

    FacilityModelS.CurrentWarriorGroupU:=GroupE;

    IsPatrol:=False;

    if Kind=bukMainGroup then begin

      WarriorPathE:=nil;
      Analyzer.MakePathFrom(FMainStartNode as IDMElement, False,
                    pkFastPath, True, WarriorPathE);
      (WarriorPathE as IWarriorPath).Build(tmToRoot, False, True, nil);
      (WarriorPathE as IWarriorPath).DoAnalysis(nil, True);
      WarriorPathE.Name:=GroupE.Name;
      PolylineE:=WarriorPathE.SpatialElement;
      Polyline:=PolylineE as IPolyline;
      MainPathP:=Polyline;
      BattleUnit.Path:=Polyline.Lines;

      aNode:=FMainStartNode as ICoordNode;
      PathNode:=aNode as IVulnerabilityData;
      TimeToTarget:=PathNode.DelayTimeToTarget;
      for i:=0 to Polyline.Lines.Count-1 do begin
        aLine:=Polyline.Lines.Item[i] as ILine;
        PathArc:=aLine as IPathArc;
        aNode:=aLine.NextNodeTo(aNode);
        PathNode:=aNode as IVulnerabilityData;
        NextTimeToTarget:=PathNode.DelayTimeToTarget;
        PathArc.Value:=TimeToTarget-NextTimeToTarget;
        TimeToTarget:=NextTimeToTarget;
      end;

      BattleUnit.CurrentNode:=FMainStartNode as IDMElement;
      StartNodeE:=FMainStartNode as IDMElement;
    end else begin // Kind<>bukMainGroup
      m:=0;
      PatrolPathE:=nil;
      PatrolPath:=nil;
      while m<FacilityModel.PatrolPaths.Count do begin
        PatrolPathE:=FacilityModel.PatrolPaths.Item[m];
        PatrolPath:=PatrolPathE as IPatrolPath;
        if PatrolPath.WarriorGroup=Group then
          Break
        else
          inc(m);
      end;
      if m<FacilityModel.PatrolPaths.Count then begin
        IsPatrol:=True;
        PatrolPathP:=PatrolPathE.SpatialElement as IPolyline;
        MaxDist:=0;
        WorstNode:=nil;
        NextToMainStartNode:=FNextToMainStartNode as ICoordNode;
        for j:=0 to PatrolPathP.Lines.Count-1 do begin
          aLine:=PatrolPathP.Lines.Item[j] as ILine;
          aNode:=aLine.C0;
          Dist:=sqrt(sqr(aNode.X-NextToMainStartNode.X)+
                     sqr(aNode.Y-NextToMainStartNode.Y)+
                     sqr(aNode.Z-NextToMainStartNode.Z));
          if MaxDist<Dist then begin
            MaxDist:=Dist;
            WorstNode:=aNode;
          end;
          aNode:=aLine.C1;
          Dist:=sqrt(sqr(aNode.X-NextToMainStartNode.X)+
                     sqr(aNode.Y-NextToMainStartNode.Y)+
                     sqr(aNode.Z-NextToMainStartNode.Z));
          if MaxDist<Dist then begin
            MaxDist:=Dist;
            WorstNode:=aNode;
          end;
        end;
        SpatialModel2:=FacilityModel as ISpatialModel2;
        VolumeE:=SpatialModel2.GetVolumeContaining(WorstNode.X, WorstNode.Y, WorstNode.Z) as IDMElement;
        Zone:=VolumeE.Ref as IZone;
        MinDist:=InfinitValue;
        StartNodeE:=nil;
        for j:=0 to Zone.FloorNodes.Count-1 do begin
          aNode:=Zone.FloorNodes.Item[j] as  ICoordNode;
          Dist:=sqrt(sqr(aNode.X-WorstNode.X)+
                     sqr(aNode.X-WorstNode.X)+
                     sqr(aNode.X-WorstNode.X));
          if MinDist>Dist then begin
             MinDist:=Dist;
             StartNodeE:=aNode as IDMElement;
          end;
        end;

        WarriorPathE:=Analyzer.BuildPatrolPath(GroupE, StartNodeE, FNextToMainStartNode as IDMElement);
      end else begin  // IsPatrol=False
        StartPointE:=Group.StartPoint;
        if (StartPointE.SpatialElement<>nil) and
           (StartPointE.SpatialElement.QueryInterface(ICoordNode, aNode)<>0) then
          aNode:=(StartPointE.SpatialElement as ILine).C0;

        StartNodeE:=(StartPointE as IPathNodeArray).PathNodes.Item[0];

        if Kind>=bukGuard then
          case Group.Task of
          gtTakePosition:
            if (Group.FinishPoint<>nil) and
              (PatrolPathE=nil) and
              (Group.StartPoint<>Group.FinishPoint) then
              WarriorPathE:=Group.FastPath as IDMElement
            else
              WarriorPathE:=nil;
          gtInterruptOnDetectionPoint:
            begin
              WarriorPathE:=nil;
              Analyzer.MakePathFrom(FNextToMainStartNode as IDMElement, True,
                                        pkFastPath, True, WarriorPathE);
              if WarriorPathE<>nil then begin
                (WarriorPathE as IWarriorPath).Build(tmFromRoot, False, True, nil);
                (WarriorPathE as IWarriorPath).DoAnalysis(nil, True);
              end;
            end;
          gtStayOnPost,
          gtPAtrol:
            WarriorPathE:=nil;
          else
            WarriorPathE:=nil;
          end
        else  // Kind=bukAdversary
          WarriorPathE:=Group.FastPath as IDMElement;
      end; // IsPatrol=False

      if WarriorPathE<>nil then
        BattleUnit.Path:=(WarriorPathE.SpatialElement as IPolyline).Lines
      else
        BattleUnit.Path:=nil;
    end; // Kind<>bukMainGroup

    if (BattleUnit.Path<>nil) and
       (BattleUnit.Path.Count>0) then begin
      aLine:=BattleUnit.Path.Item[0] as ILine;
//      if Kind<>bukAdversary then begin
        if (aLine.C0 as IDMElement)=StartNodeE then
          BattleUnit.CurrentNode:=aLine.C0 as IDMElement
        else
          BattleUnit.CurrentNode:=aLine.C1 as IDMElement
{      end else begin         // исходная точка в бесклнечности
        if (aLine.C0 as IDMElement)=StartNodeE then
          BattleUnit.CurrentNode:=aLine.C1 as IDMElement
        else
          BattleUnit.CurrentNode:=aLine.C0 as IDMElement
      end;
}
    end else begin
      BattleUnit.CurrentNode:=StartNodeE
    end;

    BattleUnit.FacilityModel:=FacilityModel as IDMElement;
    if IsPatrol then
      BattleUnit.Kind:=bukPatrol
    else
      BattleUnit.Kind:=Kind;

    T:=BattleUnit.StartBattle(FTimeStep);
    if FTimeStep>T then
      FTimeStep:=T
  end;

var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  CurrentAnalysisVariant:IAnalysisVariant;
begin
  FacilityModel:=Get_Data as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  CurrentAnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if CurrentAnalysisVariant=nil then Exit;
  Analyzer:=(Get_Data as IDataModel).Analyzer as ISafeguardAnalyzer;

  aGuardVariant:=CurrentAnalysisVariant.GuardVariant as IGuardVariant;
  aAdversaryVariant:=CurrentAnalysisVariant.AdversaryVariant as IAdversaryVariant;
  FMainGroup:=CurrentAnalysisVariant.MainGroup;
  OldCurrentWarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  MainPathP:=nil;

  BattleUnits2:=Get_BattleUnits as IDMCollection2;
  for j:=0 to aAdversaryVariant.AdversaryGroups.Count-1 do begin
    GroupE:=aAdversaryVariant.AdversaryGroups.Item[j];
    if GroupE<>(FMainGroup as IDMElement) then
      MakeBattleUnit(GroupE, bukAdversary)
    else
      MakeBattleUnit(GroupE, bukMainGroup)
  end;
  for j:=0 to aGuardVariant.GuardGroups.Count-1 do begin
    GroupE:=aGuardVariant.GuardGroups.Item[j];
    MakeBattleUnit(GroupE, bukGuard);
  end;

  BattleLines2:=Get_BattleLines as IDMCollection2;

  for j0:=0 to aGuardVariant.GuardGroups.Count-1 do begin
    GroupE:=aGuardVariant.GuardGroups.Item[j0];
    Unit0:=GroupE.SpatialElement as ICoordNode;
    for j1:=0 to aAdversaryVariant.AdversaryGroups.Count-1 do begin
      GroupE:=aAdversaryVariant.AdversaryGroups.Item[j1];
      Unit1:=GroupE.SpatialElement as ICoordNode;
      BattleLineE:=BattleLines2.CreateElement(False);
      BattleLines2.Add(BattleLineE);
      BattleLineE.Parent:=FBattleLineLayer;
      BattleLine:=BattleLineE as ILine;
      BattleLine.C0:=Unit0;
      BattleLine.C1:=Unit1;
      (BattleLine as IBattleLine).FacilityModel:=FacilityModel as IDMElement;
    end;
  end;

  FacilityModelS.CurrentWarriorGroupU:=OldCurrentWarriorGroup;
end;

{ TBattleModelFactory }

function TBattleModelFactory.CreateInstance: IUnknown;
begin
  Result:=TBattleModel.Create(nil) as IUnknown;
end;

function GetDataModelClassObject:IDMClassFactory;
begin
  Result:=TBattleModelFactory.Create(nil) as IDMClassFactory;
end;

initialization
//  CreateTypedComObjectFactory(TBattleModel, Class_BattleModel);
end.
