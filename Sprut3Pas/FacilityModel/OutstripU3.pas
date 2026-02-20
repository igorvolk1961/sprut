unit OutstripU;

interface
uses
  Classes, SysUtils,
  DataModel_TLB, FacilityModelLib_TLB, SpatialModelLib_TLB,
//  DebugU,
  SafeguardAnalyzerLib_TLB;

function GetAdversaryVictoryProbability(
  TAdver, TAdverDisp,
  TGuard, TGuardDisp: double;
  const WarriorPathElements:IDMCollection;
  const DataModel:IDataModel;
  StartPathElementJ:integer): double;

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
procedure LocalBattleModel2(out DelayTime:double;
                            var AdversaryCount:integer;
                            const AdversaryGroup:IWarriorGroup;
                            const GuardGroup:IWarriorGroup;
                            const DataModel: IDataModel);

implementation

uses
  LaplasGaussFun,
  Math,
  //BattleLineU,
  //BattleUnitU,
  //BattleModelU,
  SgdbLib_TLB,
  CoordNodeU,
  SpatialModelConstU, BattleModelLib_TLB ;

var
  CashTAdver, CashTGuard, CashResult:double;
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

function GetAdversaryVictoryProbability(
                 TAdver, TAdverDisp,
                 TGuard, TGuardDisp: double;
           const WarriorPathElements:IDMCollection;
           const DataModel:IDataModel;
                 StartPathElementJ:integer): double;

  function GetCashResult:boolean;
  begin
    Result:=False;
    if TAdver<>CashTAdver then Exit;
    if TGuard<>CashTGuard then Exit;
    Result:=True;
  end;

  procedure SaveResult;
  begin
    CashTAdver:=TAdver;
    CashTGuard:=TGuard;
    CashResult:=Result;
  end;

  function GetGuardVictoryProbability:double;
  var
    GuardRec, PrevGuardRec, TargetGuardRec:PGuardRec;
    GuardGroupE, GuardArrivalE, BestTacticE:IDMElement;
    GuardGroup:IGuardGroup;
    GuardArrival:IGuardArrival;
    ProdNotU, U, B, Q0, Q1, GuardDelay, GuardDelayDisp,
    TDiff0, TDispSum0, TDiff, TDispSum, BattleTime, dT, dTDisp, adT, adTDisp,
    aP, W, Q, Y, LG, BB,
    AdversaryCount:double;
    AdversaryGroup:IWarriorGroup;
    FacilityModelS:IFMState;
    DelayGuard:boolean;
    GuardGroupW:IWarriorGroup;
    ArrivalFlag, StartFlag, TargetFlag:boolean;
    Task, StartCondition, PursuitKind, PursuitState:integer;
    TargetGuardRecList:TList;
    Boundary:IBoundary;
    Zone0E, Zone1E, aWarriorPathElementE, aFacilityElementE:IDMElement;
    aWarriorPathElement:IWarriorPathElement;
    aPathElement:IPathElement;

    function DoGetGuardVictoryProbability(
      InfoState, CurrJ:integer;
      PrevGuardRecList:TList;
      PrevAdversaryCount:integer):double;
    var
      WarriorPathElementE, FacilityElementE:IDMElement;
      WarriorPathElement:IWarriorPathElement;
      FacilityElement:IFacilityElement;
      PathElement:IPathElement;
      GuardRecList:TList;
      m, j, k, InfoState1:integer;
      SumW, ProdNoDetP:double;
    begin
      if CurrJ >= WarriorPathElements.Count then Exit;
      WarriorPathElementE:=WarriorPathElements.Item[CurrJ];
      WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
      (FacilityModelS.CurrentLineU as ILine).C0.X := WarriorPathElement.X0;
      (FacilityModelS.CurrentLineU as ILine).C0.Y := WarriorPathElement.Y0;
      (FacilityModelS.CurrentLineU as ILine).C0.Z := WarriorPathElement.Z0;
      (FacilityModelS.CurrentLineU as ILine).C1.X := WarriorPathElement.X1;
      (FacilityModelS.CurrentLineU as ILine).C1.Y := WarriorPathElement.Y1;
      (FacilityModelS.CurrentLineU as ILine).C1.Z := WarriorPathElement.Z1;
      FacilityElementE:=WarriorPathElementE.Ref;
      FacilityElement:=FacilityElementE as IFacilityElement;
      PathElement:=FacilityElementE as IPathElement;
      dT:=WarriorPathElement.dT;
      dTDisp:=WarriorPathElement.dTDisp;

      GuardRecList:=TList.Create;
      try
// Добавляем в список преследующие подразделения
      for m:=0 to PrevGuardRecList.Count-1 do begin
        PrevGuardRec:=PrevGuardRecList[m];
        GetMem(GuardRec, SizeOf(TGuardRec));
        GuardRecList.Add(GuardRec);
        GuardGroup:=IGuardGroup(PrevGuardRec.GuardGroup);
        GuardRec.GuardGroup:=Pointer(GuardGroup);
        if (InfoState and isLocationKnown)<>0 then begin
          GuardRec.TDiff0:=PrevGuardRec.TDiff-dT;  // преследуем
          GuardRec.TDispSum0:=PrevGuardRec.TDispSum+dTDisp;
        end else begin
          GuardRec.TDiff0:=PrevGuardRec.TDiff;  // ждем обнаружения и не двигаемся
          GuardRec.TDispSum0:=PrevGuardRec.TDispSum;
        end;
        GuardRec.TDiff:=GuardRec.TDiff0;
        GuardRec.TDispSum:=GuardRec.TDispSum0;
        GuardRec.Active:=PrevGuardRec.Active;
        GuardRec.PursuitState:=PrevGuardRec.PursuitState;
        FacilityModelS.CurrentWarriorGroupU:=GuardGroup;
        PathElement.CalcDelayTime(GuardDelay, GuardDelayDisp,
                                  BestTacticE, False);
        GuardRec.GuardDelay:=GuardDelay;
        GuardRec.GuardDelayDisp:=GuardDelayDisp;
      end; // for m:=0 to PrevGuardRecList.Count-1


      if (InfoState and isLocationKnown)=0 then begin
        for m:=0 to GuardRecList.Count-1 do begin
          GuardRec:=GuardRecList[m];
          GuardRec.TDiff:=GuardRec.TDiff+GuardRec.GuardDelay;  // ждем обнаружения и не двигаемся
          GuardRec.TDispSum:=GuardRec.TDispSum+GuardRec.GuardDelayDisp;
        end; // for m:=0 to GuardRecList.Count-1

        SumW:=0;
        ProdNoDetP:=1;
        for k:=CurrJ to WarriorPathElements.Count-1 do begin
          aWarriorPathElementE:=WarriorPathElements.Item[k];
          aWarriorPathElement:=aWarriorPathElementE as IWarriorPathElement;
          aP:=aWarriorPathElement.P;

          InfoState1:=InfoState or isNextDetectionOccured or isLocationKnown;
          Q:=DoGetGuardVictoryProbability(InfoState1, k, GuardRecList,PrevAdversaryCount);
          W:=ProdNoDetP*aP*Q;
          ProdNoDetP:=ProdNoDetP*(1-aP);
          SumW:=SumW+W;

          if k<WarriorPathElements.Count-1 then begin
            aFacilityElementE:=aWarriorPathElementE.Ref;
            aPathElement:=aFacilityElementE as IPathElement;
            for m:=0 to GuardRecList.Count-1 do begin
              GuardRec:=GuardRecList[m];
              FacilityModelS.CurrentWarriorGroupU:=IGuardGroup(GuardRec.GuardGroup);
              aPathElement.CalcDelayTime(GuardDelay, GuardDelayDisp,
                                  BestTacticE, False);
              GuardRec.TDiff:=GuardRec.TDiff+GuardDelay;  // ждем обнаружения и не двигаемся
              GuardRec.TDispSum:=GuardRec.TDispSum+GuardDelayDisp;
            end; // for m:=0 to GuardRecList.Count-1
          end;
        end;

      end else
        SumW:=0;

// Добавляем в список подразделения, стартующие на перехват
      for j:=0 to WarriorPathElement.GuardArrivals.Count-1 do begin
        GuardArrivalE:=WarriorPathElement.GuardArrivals.Item[j];
        GuardArrival:=GuardArrivalE as IGuardArrival;
        GuardGroupE:=GuardArrivalE.Ref;
        GuardGroup:=GuardGroupE as IGuardGroup;
        GuardGroupW:=GuardGroupE as IWarriorGroup;
        Task:=GuardGroupW.Task;
        StartCondition:=GuardGroup.StartCondition;
        PursuitKind:=GuardGroup.PursuitKind;
        StartFlag:=(StartCondition=scAlarm) or
                   ((StartCondition=scGoalDefiningPointPassed) and
                    ((InfoState and isGoalDefiningPointPassed)<>0)) or
                   ((StartCondition=scIntrusionProved) and
                    ((InfoState and isIntrusionProved)<>0)) or
                   ((StartCondition=scArmedIntrusionProved) and
                    ((InfoState and isArmedIntrusionProved)<>0));
        ArrivalFlag:=(Task=gtStayOnPost) or
                    ((Task=gtTakePosition) and StartFlag) or
                    ((Task=gtInterruptOnExit) and StartFlag) or
                    ((Task=gtInterruptOnFirstDetectionPoint) and StartFlag and
                     ((InfoState and isFirstDetectionOccured)<>0)) or
                    ((Task=gtInterruptOnNextDetectionPoint) and StartFlag and
                     ((InfoState and isNextDetectionOccured)<>0)) or
                    ((Task=gtInterruptOnTarget) and StartFlag and
                     ((InfoState and isGoalDefiningPointPassed)<>0)) or
                    ((Task=gtInterruptOnTargetExit) and StartFlag and
                     ((InfoState and isGoalDefiningPointPassed)<>0)) or
                    ((Task=gtInterruptOnPath) and StartFlag and
                     ((InfoState and isGoalDefiningPointPassed)<>0));
        if ArrivalFlag then begin
          m:=0;
          while m<PrevGuardRecList.Count do begin
            PrevGuardRec:=PrevGuardRecList[m];
            if PrevGuardRec.GuardGroup=Pointer(GuardGroup) then
              Break
            else
              inc(m)
          end;
          if m=PrevGuardRecList.Count then begin
            GetMem(GuardRec, SizeOf(TGuardRec));
            GuardRecList.Add(GuardRec);
            GuardRec.GuardGroup:=Pointer(GuardGroup);
            if Task=gtStayOnPost then begin
              GuardRec.TDiff0:=GuardGroup.StartDelay;
              GuardRec.TDispSum0:=0;   //??????????????
              DelayGuard:=False;
            end else
            if GuardArrival.ArrivalTime0<GuardArrival.ArrivalTime1 then begin
              GuardRec.TDiff0:=GuardArrival.ArrivalTime0-dT;
              GuardRec.TDispSum0:=GuardArrival.ArrivalTimeDispersion0+dTDisp;
              DelayGuard:=(WarriorPathElement.Direction=pdFrom0To1);
            end else begin
              GuardRec.TDiff0:=GuardArrival.ArrivalTime1-dT;
              GuardRec.TDispSum0:=GuardArrival.ArrivalTimeDispersion1+dTDisp;
              DelayGuard:=(WarriorPathElement.Direction=pdFrom1To0);
            end;

            GuardRec.TDiff:=GuardRec.TDiff0;
            GuardRec.TDispSum:=GuardRec.TDispSum0;
            GuardRec.Active:=True;
            if (Task=gtStayOnPost) or
               (Task=gtTakePosition) or
               (Task=gtInterruptOnExit) then
              GuardRec.PursuitState:=3
            else
              GuardRec.PursuitState:=1;

            if DelayGuard then begin
              FacilityModelS.CurrentWarriorGroupU:=GuardGroup;
              PathElement.CalcDelayTime(GuardDelay, GuardDelayDisp,
                                  BestTacticE, False);
            end else begin
              GuardDelay:=0;
              GuardDelayDisp:=0;
            end;
            GuardRec.GuardDelay:=GuardDelay;
            GuardRec.GuardDelayDisp:=GuardDelayDisp;
          end;  // if m=PrevGuardRecList.Count
        end; // if ArrivalFlag
      end; // for j:=0 to WarriorPathElement.GuardArrivals.Count-1

      {TargetFlag:=False;
      if FacilityElementE.ClassID=_Boundary then begin
        Boundary:=FacilityElementE as IBoundary;
        Zone0E:=Boundary.Zone0;
        Zone1E:=Boundary.Zone1;
        if (Zone0E<>nil) and           // последний доступный охране рубеж
           (Zone1E<>nil) then          // (рубеж перехвата у цели)
          TargetFlag:=(GuardGroupW.GetAccessTypeToZone(Zone0E,False)<>
                       GuardGroupW.GetAccessTypeToZone(Zone1E,False));
      end else
      if FacilityElementE.ClassID=_Target then
        TargetFlag:=True;}

// Если это рубеж перехвата у цели, то добавляем в список подразделения,
// сменившие тактику преследования на тактику перехвата у цели
      for j:=0 to TargetGuardRecList.Count-1 do begin
        GuardRec:=TargetGuardRecList[j];
        GuardGroup:=IGuardGroup(GuardRec.GuardGroup);
        GuardGroupW:=GuardGroup as IWarriorGroup;

        TargetFlag:=False;
        if FacilityElementE.ClassID=_Boundary then begin
          Boundary:=FacilityElementE as IBoundary;
          Zone0E:=Boundary.Zone0;
          Zone1E:=Boundary.Zone1;
          if (Zone0E<>nil) and           // последний доступный охране рубеж
             (Zone1E<>nil) then          // (рубеж перехвата у цели)
            TargetFlag:=(GuardGroupW.GetAccessTypeToZone(Zone0E,False)<>
                       GuardGroupW.GetAccessTypeToZone(Zone1E,False));
        end else
        if FacilityElementE.ClassID=_Target then
          TargetFlag:=True;

        if TargetFlag then begin
          m:=0;
          while m<GuardRecList.Count do begin
            PrevGuardRec:=GuardRecList[m];
            if PrevGuardRec.GuardGroup=Pointer(GuardGroup) then
              Break
            else
              inc(m)
          end;
          if m=GuardRecList.Count then
            raise Exception.Create('Error 1 in GetAdversaryVictoryProbability')
          else begin
            PrevGuardRec.Active:=True;
            PrevGuardRec.TDiff0:=GuardRec.TDiff0;
            PrevGuardRec.TDispSum0:=GuardRec.TDispSum0;
            PrevGuardRec.TDiff:=GuardRec.TDiff0;
            PrevGuardRec.TDispSum:=GuardRec.TDispSum0;
            PrevGuardRec.PursuitState:=2;
          end;
        end;  // if TargetFlag
      end;  // for j:=0 to TargetGuardRecList.Count-1

      ProdNotU:=1;
// Вычисляем вероятность неперехвата на данном рубеже
// определяем возможность преследования и учитываем задержку охраны на рубеже
      for m:=0 to GuardRecList.Count-1 do begin
        GuardRec:=GuardRecList[m];
        if GuardRec.Active then begin
          TDiff0:=GuardRec.TDiff0;
          TDispSum0:=GuardRec.TDispSum0;
          if (GuardRec.PursuitState=3) or              // либо прибывают сюда всегда
             (((InfoState and isLocationKnown)<>0) and  // либо известно, что нарушители здесь
              ((GuardRec.PursuitState=1) or (GuardRec.PursuitState=2))) then begin
        // Вычисляем вероятность неперехвата на данном рубеже
        // и корректируем мат.ожидание запаздывания
            Y:=-1*TDiff0/sqrt(TDispSum0);
            LG:=LaplasGauss(Y);//=
            if LG<>1 then begin
              BB:=1/sqrt(2*pi)*exp(-sqr(Y)/2)/(1-LG);//коэф, исп для получ МО и Д усеч зак
              TDiff:=TDiff0+BB*sqrt(TDispSum0);
            end else begin
              BB:=0;
              TDiff:=TDiff0;
            end;
            TDispSum:=TDispSum0*(1-BB*BB);
            U:=GetOutstripProbability1(TDiff, TDispSum);
            ProdNotU:=ProdNotU*(1-U);
          end else begin // if GuardRec.PursuitState=1
            TDiff:=TDiff0;
            TDispSum:=TDispSum0;
          end;

          GuardGroup:=IGuardGroup(GuardRec.GuardGroup);
          GuardGroupW:=GuardGroup as IWarriorGroup;
          GuardDelay:=GuardRec.GuardDelay;
          GuardDelayDisp:=GuardRec.GuardDelayDisp;

          if (GuardGroupW.Task=gtStayOnPost) or
             (GuardGroup.PursuitKind=pkNever) or
             (GuardRec.PursuitState=2) then
            PursuitState:=0
          else
            PursuitState:=1;

          if  ((GuardGroup.PursuitKind=pkUntilGoalDefiningPoint) and
              FacilityElement.GoalDefinding) or
            ((GuardGroup.PursuitKind=pkUntilObstacleAndStay) and
              (GuardDelay>999999)) then begin
// формируем список подразделений, меняющих такитку преследования на тактику перехвата у цели
            GetMem(TargetGuardRec, SizeOf(TGuardRec));
            TargetGuardRecList.Add(TargetGuardRec);
            TargetGuardRec.GuardGroup:=Pointer(GuardGroup);
//            TargetGuardRec.TDiff:=;
//            TargetGuardRec.TDispSum:=;
            if (GuardGroup.PursuitKind=pkUntilObstacleAndStay) and
               (GuardDelay>999999) then begin
              GuardDelay:=dT;          // для отладки приняты те же значения, что и у нарушителей
              GuardDelayDisp:=dTDisp;
              GuardRec.GuardDelay:=GuardDelay;
              GuardRec.GuardDelayDisp:=GuardDelayDisp;
              PursuitState:=1;         // для отладки преследование продолжается
            end else
              PursuitState:=0;
          end;
          GuardRec.PursuitState:=PursuitState;

          GuardRec.TDiff:=TDiff+GuardDelay;
          GuardRec.TDispSum:=TDispSum+GuardDelayDisp;

        end; // if GuardRec.Active
      end; // for m:=0 to GuardRecList.Count-1

      InfoState1:=InfoState;
      if FacilityElement.GoalDefinding then begin
        InfoState1:=InfoState1 or isGoalDefiningPointPassed;
        InfoState1:=InfoState1 or isLocationKnown;
      end else
      if (InfoState1 and isGoalDefiningPointPassed)=0 then
        InfoState1:=InfoState1 and not isLocationKnown;
      if (InfoState1 and isFirstDetectionOccured)<>0 then
        InfoState1:=InfoState1 and not isFirstDetectionOccured;
      if (InfoState1 and isNextDetectionOccured)<>0 then
        InfoState1:=InfoState1 and not isNextDetectionOccured;

//Вычисляем вероятность успеха охраны в случае неудачи перехвата на данном рубеже
      if ProdNotU<>0 then
        Q0:=DoGetGuardVictoryProbability(
                    InfoState1, CurrJ+1, GuardRecList, PrevAdversaryCount)
      else
        Q0:=0;
      if ProdNotU<>1 then
        LocalBattleModel(B, BattleTime, PrevAdversaryCount, AdversaryGroup,
                         GuardRecList, DataModel, WarriorPathElementE, 1)
      else
        B:=0;

      for m:=0 to GuardRecList.Count-1 do begin
        GuardRec:=GuardRecList[m];
        if GuardRec.Active then begin
          TDiff0:=GuardRec.TDiff0;
          if TDiff0<BattleTime then
            GuardRec.Active:=False // все охранники, прибывшие до победы нарушителей - убиты
          else begin
            TDispSum0:=GuardRec.TDispSum0;
            Y:=-1*(TDiff0-BattleTime)/sqrt(TDispSum0);
            LG:=LaplasGauss(Y);    // опоздавшие охранники преследуют нарушителей
            if LG<>1 then begin
              BB:=1/sqrt(2*pi)*exp(-sqr(Y)/2)/(1-LG);
              TDiff:=TDiff0+BB*sqrt(TDispSum0);
            end else begin
              BB:=0;
              TDiff:=TDiff0;
            end;
            TDispSum:=TDispSum0*(1-BB*BB);

            GuardDelay:=GuardRec.GuardDelay;
            GuardDelayDisp:=GuardRec.GuardDelayDisp;

            GuardRec.TDiff:=TDiff+GuardDelay;
            GuardRec.TDispSum:=TDispSum+GuardDelayDisp;
          end;
        end;
      end; // for m:=0 to GuardRecList.Count-1

      InfoState1:=InfoState1 or isArmedIntrusionProved;


      if (ProdNotU<>1)and(B<>1) then
//Вычисляем вероятность успеха охраны в случае локального поражения в бою
        Q1:=DoGetGuardVictoryProbability(
                    InfoState1, CurrJ+1, GuardRecList, PrevAdversaryCount)
      else
        Q1:=0;

//Вычисляем общую вероятность успеха охраны
      Q:=ProdNotU*Q0+
              (1-ProdNotU)*(B+(1-B)*Q1);
      Result:=1-(1-Q)*(1-SumW)
      finally
        for j:=0 to GuardRecList.Count-1 do begin
          GuardRec:=GuardRecList[j];
          FreeMem(GuardRec, SizeOf(TGuardRec));
        end;
        GuardRecList.Free;
      end;
    end;

  var
    GuardRecList:TList;
    OldWarriorGroupU:IUnknown;
    InfoState, OldPathStage, j:integer;
  begin
    FacilityModelS:=DataModel as IFMState;
    GuardRecList:=TList.Create;
    TargetGuardRecList:=TList.Create;
    try
    OldPathStage:=FacilityModelS.CurrentPathStage;
    FacilityModelS.CurrentPathStage:=wpsFastEntry;
    OldWarriorGroupU:=FacilityModelS.CurrentWarriorGroupU;
    AdversaryGroup:=OldWarriorGroupU as IWarriorGroup;
    AdversaryCount:=AdversaryGroup.InitialNumber;
    InfoState:=isFirstDetectionOccured or isLocationKnown;

//          writeln(DebugFile);
//          writeln(DebugFile,'Начало.'+WarriorPathElements.Item[0].Name+' '+
//                 IntToStr(StartPathElementJ));

    Result:=DoGetGuardVictoryProbability(
              InfoState, StartPathElementJ, GuardRecList, AdversaryGroup.InitialNumber);
    finally
      FacilityModelS.CurrentWarriorGroupU:=OldWarriorGroupU;
      FacilityModelS.CurrentPathStage:=OldPathStage;
      GuardRecList.Free;

      for j:=0 to TargetGuardRecList.Count-1 do begin
        GuardRec:=TargetGuardRecList[j];
        FreeMem(GuardRec, SizeOf(TGuardRec));
      end;
      TargetGuardRecList.Free;
    end;
//    CloseFile(DebugFile);
//    Append(DebugFile);
  end;

var
  GuardVictoryProbability:double;
begin

  if GetCashResult then begin
    Result:=CashResult;
    Exit;
  end;

  if (StartPathElementJ<>-1) and
     (WarriorPathElements<>nil) then begin
     GuardVictoryProbability:=GetGuardVictoryProbability;
     Result:=1-GuardVictoryProbability
  end else
    Result:=GetOutstripProbability(TAdver, TAdverDisp, TGuard, TGuardDisp);

  SaveResult;
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
  GroupE, BattleLineE, BattleUnitE, fArrivalGroupE:IDMElement;
  AdversaryVariant:IAdversaryVariant;
  Potential, GuardPotentialSum, AdversaryPotentialSum:double;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  ResponceTimeDispersionRatio, SomebodyAlive:double;
  SkillCoeff, TimeStep, CurrentTime, StartBattleTime, ArrivalTime:double;
  Unit0, Unit1:ICoordNode;
  BattleModel:IDMAnalyzer;
  BattleLines, BattleUnits, GuardGroups, CoordNodes:IDMCollection;
  BattleLines2, BattleUnits2, GuardGroups2, CoordNodes2:IDMCollection2;
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
      Result:=0;
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
        if (BattleUnit.State=busShotNoDefence) then
          BattleUnit.State := busShotHalfDefence;
        //if //(BattleUnit.InDefence) or
        //   (BattleUnit.SomebodyAlive<1.e-3) then begin
        //  Result:=False;
        //  Exit;
        //end;
        MainBU := BattleUnit;
      end else if (GroupW.QueryInterface(IGuardGroup, Unk)=0) then begin
        if (BattleUnit.State=busShotNoDefence) then
          BattleUnit.State := busShotHalfDefence;
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
  PathNodes:IPathNodes;
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
  WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
  if WarriorPathElement.GuardArrivals.Count=0 then Exit;

  try
  FProbability:=TList.Create;
  GroupList:=TList.Create;

  BattleLines:=(BattleModel as IBattleModel).Get_BattleLines;//TBattleLines.Create(BattleModel as IDMElement) as IDMCollection;
  BattleLines2:=BattleLines as IDMCollection2;
  BattleUnits:=(BattleModel as IBattleModel).Get_BattleUnits;//TBattleUnits.Create(BattleModel as IDMElement) as IDMCollection;
  BattleUnits2:=BattleUnits as IDMCollection2;
  CoordNodes:=TCoordNodes.Create(FacilityModel as IDMElement) as IDMCollection;
  CoordNodes2:=CoordNodes as IDMCollection2;

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

procedure LocalBattleModel2(out DelayTime:double;
                           var AdversaryCount:integer;
                           const AdversaryGroup:IWarriorGroup;
                           const GuardGroup:IWarriorGroup;
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
      Result:=0;
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
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      if (GroupW.QueryInterface(IAdversaryGroup, Unk)=0) and
         (GroupW.Task=0) then begin
        if (BattleUnit.State=busShotNoDefence) then
          BattleUnit.State := busShotHalfDefence;
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
    //tB := 1;
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
            //tB := PrevPm;
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
      //tB := PrevPm;
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
  DelayTime:=0;
  AdversaryCount:=0;
  //Exit;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:= FacilityModel as IFMState;

  BattleModel:=FacilityModel.BattleModel as IDMAnalyzer;
  Analyzer:=(BattleModel.Data as IDataModel).Analyzer as ISafeguardAnalyzer;

  try
  FProbability:=TList.Create;
  GroupList:=TList.Create;

  BattleLines:=(BattleModel as IBattleModel).Get_BattleLines;//TBattleLines.Create(BattleModel as IDMElement) as IDMCollection;
  BattleLines2:=BattleLines as IDMCollection2;
  BattleUnits:=(BattleModel as IBattleModel).Get_BattleUnits;//TBattleUnits.Create(BattleModel as IDMElement) as IDMCollection;
  BattleUnits2:=BattleUnits as IDMCollection2;

  (BattleModel as IBattleModel).ClearBattle;

  TimeStep:=(BattleModel as IBattleModel).DefaultTimeStep;
  CurrentTime:=0;

  GroupE:=GuardGroup as IDMElement;
  BattleUnitE:=BattleUnits2.CreateElement(False);
  BattleUnits2.Add(BattleUnitE);
  BattleUnitE.Ref:=GroupE;
  BattleUnit:=BattleUnitE as IBattleUnit;
  //(GroupE.SpatialElement as ICoordNode).X:=InfinitValue;//(BattleUnit as ICoordNode).X:=0;
  //(GroupE.SpatialElement as ICoordNode).Y:=0;//(BattleUnit as ICoordNode).Y:=0;
  //(GroupE.SpatialElement as ICoordNode).Z:=0.5;//(BattleUnit as ICoordNode).Z:=0;
  BattleUnit.CurrentNode := GroupE.SpatialElement;
  TimeStep:=BattleUnit.StartBattle(TimeStep);
  BattleUnit.Kind:=bukGuard;
  GroupList:=TList.Create;
  GroupList.Add(Pointer(BattleUnitE));
  FProbability:=TList.Create;

  GroupE := AdversaryGroup as IDMElement;
  BattleUnitE:=BattleUnits2.CreateElement(False);
  BattleUnits2.Add(BattleUnitE);
  BattleUnitE.Ref:=GroupE;
  BattleUnit:=BattleUnitE as IBattleUnit;
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
