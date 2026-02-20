unit OutstripU;

interface
uses
  Classes, SysUtils, Windows,
  DataModel_TLB, FacilityModelLib_TLB, SpatialModelLib_TLB,
//  DebugU, 
  SafeguardAnalyzerLib_TLB;


function GetAdversaryVictoryProbability(
  TAdver, TAdverDisp,
  TGuard, TGuardDisp: double):double;


function GetAdversaryVictoryProbability2(
  DelayTime, DelayTimeDispersion,
  DelayTimeSum, DelayTimeDispersionSum,
  GuardDelayTimeFromStart, GuardDelayTimeFromStartDispersion,
  GuardDelayTimeToTarget, GuardDelayTimeToTargetDispersion,
  BattleVictoryProbability, BattleTime, BattleTimeDispersion:double):double;

function GetOutstripProbability(T1, T1Disp, T2, T2Disp:double):double;
function GetOutstripProbability1(TDiff, TDispSum:double):double;
procedure InitCash;
procedure LocalBattleModel(out B, BattleTime:double;
                           var AdversaryCount:integer;
                           const AdversaryGroup:IWarriorGroup;
                           const GuardRecList:TList;
                           const DataModel: IDataModel;
                           const WarriorPathElementE: IDMElement;
                           const Threshold: Integer);
procedure LocalBattleModel2(out B, DelayTime:double;
                            var AdversaryCount:integer;
                            const AdversaryGroup:IWarriorGroup;
                            const GuardGroups:IDMCollection;
                            const DataModel: IDataModel);

implementation

uses
  LaplasGaussFun,
  Math,
  //BattleLineU,
  //BattleUnitU,
  //BattleModelU,
  SgdbLib_TLB,
  BattleModelLib_TLB ;

var
  CashTAdver, CashTGuard:double;
  Factorial:array[0..500] of double;
type
  PGuardRec=^TGuardRec;
  TGuardRec=record
    GuardGroup:Pointer;//IGuardGroup;
    TDiff0:double;
    TDispSum0:double;
    TDiff:double;
    TDispSum:double;
    GuardDelay:double;
    GuardDelayDisp:double;
    Active:boolean;
    PursuitState:integer; // 0 - не преследуют,
  end;                    // 1 - перехватывают и преследуют,
                          // 2 - перехватывают на последнем рубеже и не преследуют,
                          // 3 - гарантрованно прибывают

  PBattleModelMem = ^TBattleModelMem;
  TBattleModelMem = record
    GuardGroup:Pointer;//IGuardGroup;
    time: double;
    MainNotExcess:Double;
    GuardNotExcess:Double;
    MainExact:Double;
    GuardExact:Double;
    MaxMExact:Double;
    DifMLast:Double;
    MaxGExact:Double;
    DifGLast:Double;
  end;

const
  isFirstDetectionOccured=1;
  isNextDetectionOccured=2;
  isLocationKnown=4;
  isIntrusionProved=8;
  isArmedIntrusionProved=16;
  isGoalDefiningPointPassed=32;

  InfinitValue=1000000000;

function GetAdversaryVictoryProbability(
                 TAdver, TAdverDisp,
                 TGuard, TGuardDisp: double): double;
begin
    Result:=GetOutstripProbability(TAdver, TAdverDisp, TGuard, TGuardDisp);
end;


function GetOutstripProbability(T1, T1Disp, T2, T2Disp:double):double;
var
  Q:double;
begin
  if T1>=999999 then
    Result:=0
  else
  if T2=0 then
    Result:=0
  else
  if T1=0 then
    Result:=1
  else
  if T2>=999999 then
    Result:=1
  else
  if T2Disp+T1Disp<>0 then begin
    Q:=(T2-T1)/
      sqrt(T2Disp+T1Disp);
    Result:=LaplasGauss(Q)
  end else begin
    if T2>T1 then
      Result:=1
    else
      Result:=0
  end;
end;

function GetOutstripProbability1(TDiff, TDispSum:double):double;
var
  Q:double;
begin
  if TDispSum<>0 then begin
    Q:=-1*TDiff/sqrt(TDispSum);
    Result:=LaplasGauss(Q)
  end else begin
    if TDiff<=0 then
      Result:=1
    else
      Result:=0
  end;
end;

procedure InitCash;
begin
  CashTAdver:=-999999;
  CashTGuard:=-999999;
end;

procedure LocalBattleModel(out B, BattleTime:double;
                           var AdversaryCount:integer;
                           const AdversaryGroup:IWarriorGroup;
                           const GuardRecList:TList;
                           const DataModel: IDataModel;
                           const WarriorPathElementE:IDMElement;
                           const Threshold: Integer);

var
  GuardRec:PGuardRec;
  i,j,k,l, j0,j1:integer;
  GuardGroup:IGuardGroup;
  GroupW:IWarriorGroup;
  WarriorPathElement: IWarriorPathElement;
  RefPathElement: IRefPathElement;
  GroupE, BattleLineE, BattleUnitE, fArrivalGroupE:IDMElement;
  AdversaryVariant:IAdversaryVariant;
  Potential, GuardPotentialSum, AdversaryPotentialSum:double;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  ResponceTimeDispersionRatio, SomebodyAlive:double;
  SkillCoeff, TimeStep, CurrentTime, StartBattleTime, ArrivalTime:double;
  Unit0, Unit1:ICoordNode;
  BattleModel:IDMAnalyzer;
  BattleLines, BattleUnits, GuardGroups:IDMCollection;
  BattleLines2, BattleUnits2, GuardGroups2:IDMCollection2;
  BattleUnit:IBattleUnit;
  BattleLine:ILine;
  Unk:IUnknown;
  Flag, StartBattle, Direction:Boolean;
  FTimeArray, FProbability, GroupList:TList;
  FMaxTimeStep:double;
  FTimeStep:double;
  tB, TC:Double;

  //вероятность непревышения определенной численности
  function ProbabilityNotExcessNumber(aBattleUnit: IBattleUnit; q:Integer): double;
  var
    WG:IWarriorGroup;
    N, k:Integer;
    P, PA, PD:double;
  begin
    try
      WG:=(aBattleUnit as IDMElement).Ref as IWarriorGroup;
      N:=WG.InitialNumber;
      Result:=0;
      if N<q then
        q:=N;
      for k:=0 to q do begin
        PA:=Power(aBattleUnit.OldAlive, k);
        PD:=Power(1-aBattleUnit.OldAlive, N-k);
        P:=PA*PD*Factorial[N]/(Factorial[k]*Factorial[N-k]);
        Result:=Result+P;
      end;
    except
      raise;
    end;
  end;

  //вероятность, того что осталось определенное количество человек в группе
  function ProbabilityExactNumber(aBattleUnit: IBattleUnit; q:Integer): double;
  var
    WG:IWarriorGroup;
    N:Integer;
    P, PA, PD:double;
  begin
    try
      WG:=(aBattleUnit as IDMElement).Ref as IWarriorGroup;
      N:=WG.InitialNumber;
      PA:=Power(aBattleUnit.OldAlive, q);
      PD:=Power(1-aBattleUnit.OldAlive, N-q);
      P:=PA*PD*Factorial[N]/(Factorial[q]*Factorial[N-q]);
      Result:=P;
    except
      raise;
    end;
  end;

  function NextStep:WordBool;
  var
    //BattleUnits:IDMCollection;
    i,j, j0, j1, wg, wm:integer;
    MinTimeStep, T:double;
    PrevMaxMExact, PrevMainExact,
    PrevMaxGExact, PrevGuardExact,
    PrevDifMLast, PrevDifGLast, PrevPm, PrevPg:Double;
    GroupW:IWarriorGroup;
    BattleUnit, MainBU:IBattleUnit;
    BattleUnitE:IDMElement;
    P, sP, Pmg, Pgm, Pm, Pg:double;
    BattleLine:IBattleLine;
    Mem:PBattleModelMem;
    GrdAbove, AdvAbove: Boolean;
  //  GuardGroup:IGuardGroup;
  begin
    Result:=True;

    if StartBattle then
      TC := CurrentTime - StartBattleTime
    else begin
      CurrentTime:=CurrentTime+TimeStep;
      Exit;
    end;

    CurrentTime:=CurrentTime+TimeStep;
  //Заполнение массива времен
//    GetMem(Mem,SizeOf(TBattleModelMem));
//    FTimeArray.Add(Mem);
//    Mem.time:=CurrentTime;//FCurrentTime;

    MinTimeStep:=FMaxTimeStep;
//    BattleUnits:=Get_BattleUnits;
    try
    for j:=0 to BattleUnits.Count-1 do begin
      BattleUnitE:=BattleUnits.Item[j];
      BattleUnit:=BattleUnitE as IBattleUnit;
      T:=BattleUnit.NextStep(FMaxTimeStep, TimeStep);
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      if (GroupW.QueryInterface(IAdversaryGroup, Unk)=0) and
         (GroupW.Task=0) then begin
        BattleUnit.DefenceLevel := 1;
        //if (BattleUnit.State=busShotNoDefence) then
        //  BattleUnit.State := busShotHalfDefence;
        //if //(BattleUnit.InDefence) or
        //   (BattleUnit.SomebodyAlive<1.e-3) then begin
        //  Result:=False;
        //  Exit;
        //end;
        MainBU := BattleUnit;
      end else if (GroupW.QueryInterface(IGuardGroup, Unk)=0) then begin
        //if (BattleUnit.State=busShotNoDefence) then
        //  BattleUnit.State := busShotHalfDefence;
        BattleUnit.DefenceLevel := 1;
      end;
      if MinTimeStep>T then
        MinTimeStep:=T;
    end;
    except
      raise
    end;

    Pm := ProbabilityNotExcessNumber(MainBU, Threshold);
    for j:=0 to GroupList.Count-1 do begin
      BattleUnitE:=IDMElement(GroupList.Items[j]);
      BattleUnit:=BattleUnitE as IBattleUnit;
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      //Заполнение массива вероятностей
      GetMem(Mem,SizeOf(TBattleModelMem));
      FProbability.Add(Mem);
      Mem.GuardGroup := Pointer(GroupW);
      Mem.time:=TC;//FCurrentTime;
      Mem.MainNotExcess := ProbabilityNotExcessNumber(MainBU, Threshold);
      Pmg:=0; Pgm:=0;
      //расчет вероятности превышения Adversary-Above-Guard
      for j0:=1 to ((MainBU as IDMElement).Ref as IWarriorGroup).InitialNumber do begin
        P := ProbabilityExactNumber(MainBU, j0);
        sP:=0;
        wg := (BattleUnitE.Ref as IWarriorGroup).InitialNumber;
        if wg > j0-1 then
          wg := j0-1;
        for j1:=0 to wg do begin
          sP:=sP+ProbabilityExactNumber(BattleUnit, j1)
        end;
        P:=P*sP;
        Pmg:=Pmg+P;
      end;
      //расчет вероятности превышения Guard-Above-Adversary
      for j0:=1 to GroupW.InitialNumber do begin
        P := ProbabilityExactNumber(BattleUnit, j0);
        sP:=0;
        wm := ((MainBU as IDMElement).Ref as IWarriorGroup).InitialNumber;
        if wm > j0-1 then
          wm := j0-1;
        for j1:=0 to wm do begin
          sP:=sP+ProbabilityExactNumber(MainBU, j1)
        end;
        P:=P*sP;
        Pgm:=Pgm+P;
      end;
      Mem.MainExact:=Pmg;
      Mem.GuardExact:=Pgm;

      Pg := BattleUnit.SomebodyAlive;
      {wg := (BattleUnitE.Ref as IWarriorGroup).InitialNumber;
      if wg>1 then begin
        Pg := BattleUnit.SomebodyAlive;//ProbabilityNotExcessNumber(BattleUnit, 1);
      end else if wg=1 then begin
        Pg := BattleUnit.SomebodyAlive;//ProbabilityNotExcessNumber(BattleUnit, 0);
      end;}
      Mem.GuardNotExcess := Pg;
    end;

    GrdAbove:=True;
    AdvAbove:=True;
    tB := 1;
    i:=GroupList.Count*2;
    for j0:=0 to GroupList.Count-1 do begin
      BattleUnitE:=IDMElement(GroupList.Items[j0]);
      BattleUnit:=BattleUnitE as IBattleUnit;
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      PrevPm:=0;
      PrevMaxMExact:=0;
      PrevMainExact:=0;
      PrevDifMLast:=0;
      PrevPg:=0;
      PrevMaxGExact:=0;
      PrevGuardExact:=0;
      //PrevDifGLast:=0;
      if (FProbability.Count-i)<0 then
        i:=0
      else
        i:=FProbability.Count-i;
      for j1:=i to FProbability.Count-1 do begin
        Mem := FProbability[j1];
        if Mem.GuardGroup = Pointer(GroupW) then begin
          if (Mem.MainExact<1)and
             (Mem.MainExact>PrevMaxMExact) then begin
            Mem.MaxMExact:=Mem.MainExact;
            Mem.DifMLast:=Mem.MainExact-PrevMainExact
          end else if (Mem.MainExact<1) then begin
            Mem.MaxMExact:=PrevMaxMExact;
            Mem.DifMLast:=Mem.MainExact-PrevMainExact;
          end;
          if (Mem.GuardExact<1)and
             (Mem.GuardExact>PrevMaxGExact) then begin
            Mem.MaxGExact:=Mem.GuardExact;
            //Mem.DifGLast:=Mem.GuardExact-PrevGuardExact
          end else if (Mem.GuardExact<1) then begin
            Mem.MaxGExact:=PrevMaxGExact;
            //Mem.DifGLast:=Mem.GuardExact-PrevGuardExact;
          end;

          PrevPm:=Mem.MainNotExcess;
          PrevMaxMExact:=Mem.MaxMExact;
          PrevMainExact:=Mem.MainExact;
          PrevDifMLast:=Mem.DifMLast;
          PrevPg:=Mem.GuardNotExcess;
          PrevMaxGExact:=Mem.MaxGExact;
          PrevGuardExact:=Mem.GuardExact;
          //PrevDifGLast:=Mem.DifGLast;
        end;
      end;
      if (PrevMainExact<0.966) then begin
        AdvAbove := False;
        if (PrevDifMLast<0)and(PrevMaxMExact>0) then begin
          if (PrevGuardExact<0.966)and(PrevPg<0.5)then begin
            tB := PrevPm;
            //GrdAbove := False;
          end else if (PrevGuardExact<0.966)and(PrevPg>0.5)and
                      (GrdAbove)and((1-PrevPm)<1E-12)then
            GrdAbove := False;
        end else if (PrevDifMLast>=0)and(PrevPg>0.5) then
          GrdAbove := False;
      end else if (PrevMainExact>=0.966) then begin
        if (PrevPg>0.5) then begin
          AdvAbove := False;
          GrdAbove := False;
        end;
      end;
    end;
    if (AdvAbove) then begin
      tB := PrevPm;
      Result := False;
    end;
    if (GrdAbove) then begin
      //tB:=1;
      Result := False;
    end;
    if (((MainBU as IDMElement).Ref as IWarriorGroup).InitialNumber=0) then
      Result:=False;
    if (not Result)then
      Exit;

    try
    //BattleLines:=Get_BattleLines;
    //for j:=0 to BattleLines.Count-1 do
    //(BattleLines.Item[j] as IBattleLine).CheckFireLine;
      for j:=0 to BattleLines.Count-1 do
        if (BattleLines.Item[j] as IBattleLine).Visible then begin
          (BattleLines.Item[j] as IBattleLine).IncFireLineCount;
        end;
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
      BattleLine.CalcScoreProbability(TimeStep);
      P:=P+BattleLine.ScoreProbability01+BattleLine.ScoreProbability10;
    end;
    TimeStep:=MinTimeStep;
    if TimeStep<>FMaxTimeStep then
      FMaxTimeStep:=(BattleModel as IBattleModel).DefaultTimeStep
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

var
  GuardArrivalE, GuardGroupE:IDMElement;
  GuardArrival:IGuardArrival;
  GuardGroupW:IWarriorGroup;
  PathArcs:IDMCollection;
  C, NextC, C0, C1, PrevC, FinishNode, StartNode:ICoordNode;
  PathArcKind:integer;
  aLineE, NodeE, LineRef, FacilityStateE, WarriorPathE:IDMElement;
  aLine:ILine;
  Lines:IDMCollection;
  aPathArc:IPathArc;
  InitialLineIndex:integer;
  AnalysisVariant:IAnalysisVariant;
  GuardVariant:IGuardVariant;
  GuardArrivals:IDMCollection;
  GuardArrivals2, WarriorPaths2:IDMCollection2;
  Nodes:IDMCollection;
  FacilityElement:IFacilityElement;
  OldWarriorGroupU:IUnknown;
  PathArcE, aWeaponE:IDMElement;
  aWeaponKind:IWeaponKind;
  PathArcL:ILine;
  T0Min, T1Min, T0, T1, StartDelay,
  dT0, dT1, dT0Best, dT1Best, Dist0, InitialNumber:double;
  Node0, Node1: IVulnerabilityData;
  Boundary:IBoundary;
  CurrZone:IZone;
  Analyzer:ISafeguardAnalyzer;
begin
  B:=0;
  tB:=0; TC:=0;
  BattleTime:=0;
  //AdversaryCount:=0;
  //Exit;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:= FacilityModel as IFMState;

  BattleModel:=FacilityModel.BattleModel as IDMAnalyzer;
  Analyzer:=(BattleModel.Data as IDataModel).Analyzer as ISafeguardAnalyzer;

//    if BattleModel<>nil then
//      BattleModel.Start(0);
  RefPathElement:=WarriorPathElementE as IRefPathElement;
  if RefPathElement.GuardArrivals.Count=0 then Exit;

  try
  FProbability:=TList.Create;
  GroupList:=TList.Create;

  BattleLines:=(BattleModel as IBattleModel).Get_BattleLines;//TBattleLines.Create(BattleModel as IDMElement) as IDMCollection;
  BattleLines2:=BattleLines as IDMCollection2;
  BattleUnits:=(BattleModel as IBattleModel).Get_BattleUnits;//TBattleUnits.Create(BattleModel as IDMElement) as IDMCollection;
  BattleUnits2:=BattleUnits as IDMCollection2;

  (BattleModel as IBattleModel).ClearBattle;
//  (BattleModel as IBattleModel).StartBattle2;
  WarriorPaths2:=FacilityModel.WarriorPaths as IDMCollection2;

  FMaxTimeStep:=(BattleModel as IBattleModel).DefaultTimeStep;
  TimeStep:=FMaxTimeStep;
  CurrentTime:=0;

  LineRef := WarriorPathElementE.Ref;
  for i:=0 to GuardRecList.Count-1 do begin
    GuardRec:=GuardRecList[i];
    if GuardRec.Active then begin
      GuardGroup:=IGuardGroup(GuardRec.GuardGroup);
      GuardGroupW:=GuardGroup as IWarriorGroup;
      GroupE:=GuardGroupW as IDMElement;
      Dist0 := InfinitValue;
      for j0:=0 to GuardGroupW.Weapons.Count-1 do begin
        aWeaponE:=GuardGroupW.Weapons.Item[j0];
        aWeaponKind:=aWeaponE.Ref as IWeaponKind;
        if aWeaponKind.MaxShotDistance<Dist0 then begin
          Dist0 := aWeaponKind.MaxShotDistance;
        end;
      end;
      if Dist0>1000 then
        Dist0 := 5000
      else if (Dist0<=1000)then
        Dist0 := 1000;

      BattleUnitE:=BattleUnits2.CreateElement(False);
      BattleUnits2.Add(BattleUnitE);
      BattleUnitE.Ref:=GroupE;
      BattleUnit:=BattleUnitE as IBattleUnit;
      if WarriorPathE<>nil then
        BattleUnit.Path := (WarriorPathE.SpatialElement as IPolyline).Lines
      else begin
        (GroupE.SpatialElement as ICoordNode).X:=InfinitValue;//FinishNode.X;//InfinitValue;//(BattleUnit as ICoordNode).X:=0;
        (GroupE.SpatialElement as ICoordNode).Y:=Dist0;//(BattleUnit as ICoordNode).Y:=-100;
        (GroupE.SpatialElement as ICoordNode).Z:=0.5;//(BattleUnit as ICoordNode).Z:=0;
        BattleUnit.CurrentNode := GroupE.SpatialElement;
      end;
      TimeStep:=BattleUnit.StartBattle(TimeStep);
      BattleUnit.Kind:=bukGuard;

      break;

    end; //if GuardRec.Active then
  end; //for j:=0 to GuardRecList.Count-1 do



  GroupE:=AdversaryGroup as IDMElement;//AdversaryVariant.AdversaryGroups.Item[j];
  InitialNumber := AdversaryGroup.InitialNumber;
  AdversaryGroup.SetInitialNumber(AdversaryCount);
  BattleUnitE:=BattleUnits2.CreateElement(False);
  BattleUnits2.Add(BattleUnitE);
  BattleUnitE.Ref:=GroupE;
  BattleUnit:=BattleUnitE as IBattleUnit;

  (GroupE.SpatialElement as ICoordNode).X:=InfinitValue;//(BattleUnit as ICoordNode).X:=0;
  (GroupE.SpatialElement as ICoordNode).Y:=0;//(BattleUnit as ICoordNode).Y:=0;
  (GroupE.SpatialElement as ICoordNode).Z:=0.5;//(BattleUnit as ICoordNode).Z:=0;
  BattleUnit.CurrentNode := GroupE.SpatialElement;
  TimeStep:=BattleUnit.StartBattle(TimeStep);

  if (GroupE as IWarriorGroup).Task<>0 then
    BattleUnit.Kind:=bukAdversary
  else
    BattleUnit.Kind:=bukMainGroup;

  for j0:=0 to BattleUnits.Count-2 do begin
    BattleUnitE:=BattleUnits.Item[j0];
    GroupE := BattleUnitE.Ref as IDMElement;
    Unit0 := GroupE.SpatialElement as ICoordNode;
    for j1:=BattleUnits.Count-1 to BattleUnits.Count-1 do begin
      BattleUnitE:=BattleUnits.Item[j1];
      GroupE := BattleUnitE.Ref as IDMElement;
      Unit1 := GroupE.SpatialElement as ICoordNode;

      BattleLineE:=BattleLines2.CreateElement(False);
      BattleLines2.Add(BattleLineE);
      (BattleLineE as IBattleLine).Visible:=false;
      (BattleLineE as IBattleLine).TransparencyCoeff:=1;
      BattleLine:=BattleLineE as ILine;
      BattleLine.C0:=Unit1;
      BattleLine.C1:=Unit0;
    end;
  end;

  StartBattle := False;
  StartBattleTime := 0;
  while NextStep do begin
    If (CurrentTime>3600) then Break;
    for j:=0 to BattleLines.Count-1 do begin
      BattleLineE := BattleLines.Item[j];
      BattleUnitE:=(BattleLineE as ILine).C1 as IDMElement;
      GroupE:=BattleUnitE.Ref;
      GuardGroup:=GroupE as IGuardGroup;
      for i:=0 to GuardRecList.Count-1 do begin
         GuardRec:=GuardRecList[i];
         if GuardRec.Active then begin
           if (GuardGroup=IGuardGroup(GuardRec.GuardGroup)) then begin
             if GuardRec.TDiff<CurrentTime then begin
               if (GroupList.IndexOf(Pointer(BattleUnitE))=-1) then
                 GroupList.Add(Pointer(BattleUnitE));
               if (not StartBattle) then begin
                 StartBattle := true;
                 StartBattleTime := CurrentTime;
               end;
               if (not (BattleLineE as IBattleLine).Visible) then
                 (BattleLineE as IBattleLine).Visible := true;

             end;
             break;
           end; //if (GuardGroup=IGuardGroup(GuardRec.GuardGroup))
         end; //if GuardRec.Active then
      end; //for j:=0 to GuardRecList.Count-1 do
    end;
  end;

{    SomebodyAlive := 0;
    for j:=0 to BattleUnits.Count-1 do begin
      BattleUnitE:=BattleUnits.Item[j];
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      if (GroupW.QueryInterface(IGuardGroup, Unk)=0) and
         ((BattleUnitE as IBattleUnit).SomebodyAlive<1) and
         ((BattleUnitE as IBattleUnit).SomebodyAlive>SomebodyAlive) then
        SomebodyAlive := (BattleUnitE as IBattleUnit).SomebodyAlive;
    end;
}
    if (BattleUnits.Count>0) then begin
      BattleUnitE:=BattleUnits.Item[BattleUnits.Count-1];
      B := tB;
      if CurrentTime<3600 then
        BattleTime:=TC//CurrentTime-StartBattleTime;
      else
        BattleTime:=0;
      AdversaryCount:=Round((BattleUnitE as IBattleUnit).CalcNumber);
    end;

    finally
      for j:=FProbability.Count-1 downto 0 do
        FreeMem(FProbability[j],SizeOf(TBattleModelMem));
      AdversaryGroup.SetInitialNumber(Round(InitialNumber));
      FProbability.Free;
      GroupList.Free;
    end;
end;

procedure LocalBattleModel2(out B, DelayTime:double;
                           var AdversaryCount:integer;
                           const AdversaryGroup:IWarriorGroup;
                           const GuardGroups:IDMCollection;
                           const DataModel: IDataModel);

var
  j,j0,j1:integer;
  GroupE, BattleLineE, BattleUnitE:IDMElement;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  TimeStep, CurrentTime:double;
  Unit0, Unit1:ICoordNode;
  BattleModel:IDMAnalyzer;
  BattleLines, BattleUnits:IDMCollection;
  BattleLines2, BattleUnits2:IDMCollection2;
  BattleUnit:IBattleUnit;
  BattleLine:ILine;
  FProbability, GroupList:TList;
  Unk:IUnknown;
  tB:Double;
  
  //вероятность непревышения определенной численности
  function ProbabilityNotExcessNumber(aBattleUnit: IBattleUnit; q:Integer): double;
  var
    WG:IWarriorGroup;
    N, k:Integer;
    P, PA, PD:double;
  begin
    try
      WG:=(aBattleUnit as IDMElement).Ref as IWarriorGroup;
      N:=WG.InitialNumber;
      Result:=0;
      if N<q then
        q:=N;
      for k:=0 to q do begin
        PA:=Power(aBattleUnit.OldAlive, k);
        PD:=Power(1-aBattleUnit.OldAlive, N-k);
        P:=PA*PD*Factorial[N]/(Factorial[k]*Factorial[N-k]);
        Result:=Result+P;
      end;
    except
      raise;
    end;
  end;

  //вероятность, того что осталось определенное количество человек в группе
  function ProbabilityExactNumber(aBattleUnit: IBattleUnit; q:Integer): double;
  var
    WG:IWarriorGroup;
    N:Integer;
    P, PA, PD:double;
  begin
    try
      WG:=(aBattleUnit as IDMElement).Ref as IWarriorGroup;
      N:=WG.InitialNumber;
      PA:=Power(aBattleUnit.OldAlive, q);
      PD:=Power(1-aBattleUnit.OldAlive, N-q);
      P:=PA*PD*Factorial[N]/(Factorial[q]*Factorial[N-q]);
      Result:=P;
    except
      raise;
    end;
  end;

  function NextStep:WordBool;
  var
    //BattleUnits:IDMCollection;
    i,j, j0, j1, wg, wm:integer;
    MinTimeStep, T:double;
    PrevMaxMExact, PrevMainExact,
    PrevMaxGExact, PrevGuardExact,
    PrevDifMLast, PrevDifGLast, PrevPm, PrevPg:Double;
    GroupW:IWarriorGroup;
    BattleUnit, MainBU:IBattleUnit;
    BattleUnitE:IDMElement;
    P, sP, Pmg, Pgm, Pm, Pg:double;
    BattleLine:IBattleLine;
    Mem:PBattleModelMem;
    GrdAbove, AdvAbove: Boolean;
  //  GuardGroup:IGuardGroup;
  begin
    Result:=True;

    CurrentTime:=CurrentTime+TimeStep;

    try
    for j:=0 to BattleUnits.Count-1 do begin
      BattleUnitE:=BattleUnits.Item[j];
      BattleUnit:=BattleUnitE as IBattleUnit;
      T:=BattleUnit.NextStep(TimeStep, TimeStep);      
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      if (GroupW.QueryInterface(IAdversaryGroup, Unk)=0) and
         (GroupW.Task=0) then begin
        //if (BattleUnit.State=busShotNoDefence) then
        //  BattleUnit.State := busShotHalfDefence;
        MainBU := BattleUnit;
      end else if (GroupW.QueryInterface(IGuardGroup, Unk)=0) then begin
        //if (BattleUnit.State=busShotNoDefence) then
        //  BattleUnit.State := busShotHalfDefence;
      end;
      //if MinTimeStep>T then
      //  MinTimeStep:=T;
    end;
    except
      raise
    end;

    Pm := ProbabilityNotExcessNumber(MainBU, 1);
    for j:=0 to GroupList.Count-1 do begin
      BattleUnitE:=IDMElement(GroupList.Items[j]);
      BattleUnit:=BattleUnitE as IBattleUnit;
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      //Заполнение массива вероятностей
      GetMem(Mem,SizeOf(TBattleModelMem));
      FProbability.Add(Mem);
      Mem.GuardGroup := Pointer(GroupW);
      Mem.time:=CurrentTime;
      Mem.MainNotExcess := ProbabilityNotExcessNumber(MainBU, 1);
      Pmg:=0; Pgm:=0;
      //расчет вероятности превышения Adversary-Above-Guard
      for j0:=1 to ((MainBU as IDMElement).Ref as IWarriorGroup).InitialNumber do begin
        P := ProbabilityExactNumber(MainBU, j0);
        sP:=0;
        wg := (BattleUnitE.Ref as IWarriorGroup).InitialNumber;
        if wg > j0-1 then
          wg := j0-1;
        for j1:=0 to wg do begin
          sP:=sP+ProbabilityExactNumber(BattleUnit, j1)
        end;
        P:=P*sP;
        Pmg:=Pmg+P;
      end;
      //расчет вероятности превышения Guard-Above-Adversary
      for j0:=1 to GroupW.InitialNumber do begin
        P := ProbabilityExactNumber(BattleUnit, j0);
        sP:=0;
        wm := ((MainBU as IDMElement).Ref as IWarriorGroup).InitialNumber;
        if wm > j0-1 then
          wm := j0-1;
        for j1:=0 to wm do begin
          sP:=sP+ProbabilityExactNumber(MainBU, j1)
        end;
        P:=P*sP;
        Pgm:=Pgm+P;
      end;
      Mem.MainExact:=Pmg;
      Mem.GuardExact:=Pgm;

      Pg := BattleUnit.SomebodyAlive;
      {wg := (BattleUnitE.Ref as IWarriorGroup).InitialNumber;
      if wg>1 then begin
        Pg := BattleUnit.SomebodyAlive;//ProbabilityNotExcessNumber(BattleUnit, 1);
      end else if wg=1 then begin
        Pg := BattleUnit.SomebodyAlive;//ProbabilityNotExcessNumber(BattleUnit, 0);
      end;}
      Mem.GuardNotExcess := Pg;
    end;

    GrdAbove:=True;
    AdvAbove:=True;
    tB := 1;
    i:=GroupList.Count*2;
    for j0:=0 to GroupList.Count-1 do begin
      BattleUnitE:=IDMElement(GroupList.Items[j0]);
      BattleUnit:=BattleUnitE as IBattleUnit;
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      PrevPm:=0;
      PrevMaxMExact:=0;
      PrevMainExact:=0;
      PrevDifMLast:=0;
      PrevPg:=0;
      PrevMaxGExact:=0;
      PrevGuardExact:=0;
      //PrevDifGLast:=0;
      if (FProbability.Count-i)<0 then
        i:=0
      else
        i:=FProbability.Count-i;
      for j1:=i to FProbability.Count-1 do begin
        Mem := FProbability[j1];
        if Mem.GuardGroup = Pointer(GroupW) then begin
          if (Mem.MainExact<1)and
             (Mem.MainExact>PrevMaxMExact) then begin
            Mem.MaxMExact:=Mem.MainExact;
            Mem.DifMLast:=Mem.MainExact-PrevMainExact
          end else if (Mem.MainExact<1) then begin
            Mem.MaxMExact:=PrevMaxMExact;
            Mem.DifMLast:=Mem.MainExact-PrevMainExact;
          end;
          if (Mem.GuardExact<1)and
             (Mem.GuardExact>PrevMaxGExact) then begin
            Mem.MaxGExact:=Mem.GuardExact;
            //Mem.DifGLast:=Mem.GuardExact-PrevGuardExact
          end else if (Mem.GuardExact<1) then begin
            Mem.MaxGExact:=PrevMaxGExact;
            //Mem.DifGLast:=Mem.GuardExact-PrevGuardExact;
          end;

          PrevPm:=Mem.MainNotExcess;
          PrevMaxMExact:=Mem.MaxMExact;
          PrevMainExact:=Mem.MainExact;
          PrevDifMLast:=Mem.DifMLast;
          PrevPg:=Mem.GuardNotExcess;
          PrevMaxGExact:=Mem.MaxGExact;
          PrevGuardExact:=Mem.GuardExact;
          //PrevDifGLast:=Mem.DifGLast;
        end;
      end;
      if (PrevMainExact<0.966) then begin
        AdvAbove := False;
        if (PrevDifMLast<0)and(PrevMaxMExact>0) then begin
          if (PrevGuardExact<0.966)and(PrevPg<0.5)then begin
            tB := PrevPm;
            //GrdAbove := False;
          end else if (PrevGuardExact<0.966)and(PrevPg>0.5)and
                      (GrdAbove)and((1-PrevPm)<1E-12)then
            GrdAbove := False;
        end else if (PrevDifMLast>=0)and(PrevPg>0.5) then
          GrdAbove := False;
      end else if (PrevMainExact>=0.966) then begin
        if (PrevPg>0.5) then begin
          AdvAbove := False;
          GrdAbove := False;
        end;
      end;
    end;
    if (AdvAbove) then begin
      tB := PrevPm;
      Result := False;
    end;
    if (GrdAbove) then begin
      //tB:=1;
      Result := False;
    end;
    if (((MainBU as IDMElement).Ref as IWarriorGroup).InitialNumber=0) then
      Result:=False;
    if (not Result)then
      Exit;

    try
      for j:=0 to BattleLines.Count-1 do
        if (BattleLines.Item[j] as IBattleLine).Visible then begin
          (BattleLines.Item[j] as IBattleLine).IncFireLineCount;
        end;
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
      BattleLine.CalcScoreProbability(TimeStep);
      P:=P+BattleLine.ScoreProbability01+BattleLine.ScoreProbability10;
    end;
    TimeStep:=(BattleModel as IBattleModel).DefaultTimeStep;
    if P=0 then
      TimeStep:=TimeStep*1.2;

    for j:=0 to BattleUnits.Count-1 do
      begin
        BattleUnitE:=BattleUnits.Item[j];
        BattleUnit:=BattleUnitE as IBattleUnit;
        BattleUnit.StoreState;
      end;

    for j:=0 to BattleLines.Count-1 do
      (BattleLines.Item[j] as IBattleLine).CalcAliveHope;
  end;

var
  Analyzer:ISafeguardAnalyzer;

begin
  B:=0; tB:=0;
  DelayTime:=0;
  AdversaryCount:=0;
  //Exit;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:= FacilityModel as IFMState;

  BattleModel:=FacilityModel.BattleModel as IDMAnalyzer;
  Analyzer:=(BattleModel.Data as IDataModel).Analyzer as ISafeguardAnalyzer;

  FProbability:=TList.Create;
  GroupList:=TList.Create;

  try

  BattleLines:=(BattleModel as IBattleModel).Get_BattleLines;//TBattleLines.Create(BattleModel as IDMElement) as IDMCollection;
  BattleLines2:=BattleLines as IDMCollection2;
  BattleUnits:=(BattleModel as IBattleModel).Get_BattleUnits;//TBattleUnits.Create(BattleModel as IDMElement) as IDMCollection;
  BattleUnits2:=BattleUnits as IDMCollection2;

  (BattleModel as IBattleModel).ClearBattle;

  TimeStep:=(BattleModel as IBattleModel).DefaultTimeStep;
  CurrentTime:=0;

  for j:=0 to GuardGroups.Count-1 do begin
    GroupE:=GuardGroups.Item[j];
    BattleUnitE:=BattleUnits2.CreateElement(False);
    BattleUnits2.Add(BattleUnitE);
    BattleUnitE.Ref:=GroupE;
    BattleUnit:=BattleUnitE as IBattleUnit;
    (GroupE.SpatialElement as ICoordNode).X:=InfinitValue;//(BattleUnit as ICoordNode).X:=0;
    (GroupE.SpatialElement as ICoordNode).Y:=0;//(BattleUnit as ICoordNode).Y:=0;
    (GroupE.SpatialElement as ICoordNode).Z:=0.5;//(BattleUnit as ICoordNode).Z:=0;
    BattleUnit.CurrentNode := GroupE.SpatialElement;
    TimeStep:=BattleUnit.StartBattle(TimeStep);
    BattleUnit.Kind:=bukGuard;
    GroupList.Add(Pointer(BattleUnitE));
  end;

  GroupE := AdversaryGroup as IDMElement;
  BattleUnitE:=BattleUnits2.CreateElement(False);
  BattleUnits2.Add(BattleUnitE);
  BattleUnitE.Ref:=GroupE;
  BattleUnit:=BattleUnitE as IBattleUnit;
  (GroupE.SpatialElement as ICoordNode).X:=InfinitValue;
  (GroupE.SpatialElement as ICoordNode).Y:=1000;
  (GroupE.SpatialElement as ICoordNode).Z:=0.5;
  BattleUnit.CurrentNode := GroupE.SpatialElement;
  TimeStep:=BattleUnit.StartBattle(TimeStep);
  BattleUnit.Kind:=bukMainGroup;

  for j0:=0 to BattleUnits.Count-2 do begin
    BattleUnitE:=BattleUnits.Item[j0];
    GroupE := BattleUnitE.Ref as IDMElement;
    Unit0 := GroupE.SpatialElement as ICoordNode;
    for j1:=BattleUnits.Count-1 to BattleUnits.Count-1 do begin
      BattleUnitE:=BattleUnits.Item[j1];
      GroupE := BattleUnitE.Ref as IDMElement;
      Unit1 := GroupE.SpatialElement as ICoordNode;

      BattleLineE:=BattleLines2.CreateElement(False);
      BattleLines2.Add(BattleLineE);
      (BattleLineE as IBattleLine).Visible:=false;
      (BattleLineE as IBattleLine).TransparencyCoeff:=1;
      BattleLine:=BattleLineE as ILine;
      BattleLine.C0:=Unit1;
      BattleLine.C1:=Unit0;
    end;
  end;

  while NextStep do begin
    If (CurrentTime>1800) then Break;
    for j:=0 to BattleLines.Count-1 do begin
      BattleLineE := BattleLines.Item[j];
      BattleUnitE:=(BattleLineE as ILine).C1 as IDMElement;
      if (not (BattleLineE as IBattleLine).Visible) then
        (BattleLineE as IBattleLine).Visible := true;
    end;
  end;

  if (BattleUnits.Count>0) then begin
    BattleUnitE:=BattleUnits.Item[BattleUnits.Count-1];
    B:=tB;
    if CurrentTime<1800 then
      DelayTime:=CurrentTime
    else
      DelayTime:=0;
    AdversaryCount:=Round((BattleUnitE as IBattleUnit).CalcNumber);
  end;

  finally
    for j:=FProbability.Count-1 downto 0 do
      FreeMem(FProbability[j],SizeOf(TBattleModelMem));
    FProbability.Free;
    GroupList.Free;
  end;
end;


function GetAdversaryVictoryProbability2(
  DelayTime, DelayTimeDispersion,
  DelayTimeSum, DelayTimeDispersionSum,
  GuardDelayTimeFromStart, GuardDelayTimeFromStartDispersion,
  GuardDelayTimeToTarget, GuardDelayTimeToTargetDispersion,
  BattleVictoryProbability, BattleTime, BattleTimeDispersion:double):double;
var
  F0, F01, F02, F1, FP, FM, FE, tau, mu, Dtau, Dmu, A, B,
  MT0, MT1, MT2, sMT0, BD, sDtau, sDMB:double;
  TAdver, TAdverDisp, TGuard, TGuardDisp,
  R, Q, Q1:double;
begin
  if GuardDelayTimeFromStart>1000000 then begin
    Result:=1;
    Exit;
  end;
  tau:=GuardDelayTimeFromStart-DelayTime;
  Dtau:=GuardDelayTimeFromStartDispersion+DelayTimeDispersion;
  mu:=GuardDelayTimeToTarget-DelayTimeSum;
  Dmu:=GuardDelayTimeToTargetDispersion+DelayTimeDispersionSum;
  sDMB:=sqrt(Dmu+BattleTimeDispersion);
  F01:=LaplasGauss(-tau/sqrt(Dtau));
  F02:=LaplasGauss((mu-BattleTime)/sDMB);
  F0:=BattleVictoryProbability*F01*F02;
  A:=0.7;
  B:=0.8;
  MT0:=A/Dmu+1/Dtau;
  sMT0:=sqrt(MT0);
  sDtau:=sqrt(Dtau);
  MT1:=-A*mu/Dmu+tau/Dtau;
  MT2:=-A*sqr(mu)/(2*Dmu)-sqr(tau)/(2*Dtau);
  BD:=B/sqrt(Dmu);
  if mu<0 then
    FP:=1/(2*sDtau)/sMT0*
        exp(sqr(MT1+BD)/(2*MT0)+MT2+BD*mu)*
        (LaplasGauss(-SMT0*mu-(MT1+BD)/sMT0)-
                 LaplasGauss(-(MT1+BD)/sMT0))
  else
    FP:=0;

  FM:=-1/(2*sDtau)/sMT0*
      exp(sqr(MT1-BD)/(2*MT0)+MT2-BD*mu)*
      LaplasGauss(sMT0*mu+(MT1-BD)/sMT0);
  FE:=LaplasGauss((mu+tau)/sDtau);
  F1:=FP+FM+FE;
  Result:=F0+F1;

  TAdver:=DelayTime+DelayTimeSum;
  TAdverDisp:=DelayTimeDispersion+DelayTimeDispersionSum;
  TGuard:=GuardDelayTimeFromStart+GuardDelayTimeToTarget;
  TGuardDisp:=GuardDelayTimeFromStartDispersion+GuardDelayTimeToTargetDispersion;
  Q:=(TGuard-TAdver)/
    sqrt(TGuardDisp+TAdverDisp);
  Q1:=(mu+tau)/sqrt(Dmu+Dtau);
  R:=LaplasGauss(Q)

end;

var
  j:Integer;
initialization
  InitCash;
  Factorial[0]:=1;
  try
  for j:=1 to 100 do
    Factorial[j]:=Factorial[j-1]*j;
  except
    raise
  end;
end.
