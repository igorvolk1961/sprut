unit OutstripU;

interface
uses
  Classes, SysUtils,
  DataModel_TLB, FacilityModelLib_TLB, SpatialModelLib_TLB;
//  DebugU;

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
                           var AdversaryCount:double;
                           const AdversaryGroup:IWarriorGroup;
                           const GuardRecList:TList;
                           const DataModel: IDataModel;
                           const WarriorPathElementE: IDMElement);
implementation

uses
  LaplasGaussFun,
  //BattleLineU,
  //BattleUnitU,
  //BattleModelU,
  SgdbLib_TLB,
  CoordNodeU,
  SpatialModelConstU, BattleModelLib_TLB ;

var
  CashTAdver, CashTGuard, CashResult:double;

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
    TDiff0, TDispSum0, TDiff, TDispSum, BattleTime, dT, dTDisp,
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
      PrevGuardRecList:TList):double;
    var
      WarriorPathElementE, FacilityElementE:IDMElement;
      WarriorPathElement:IWarriorPathElement;
      FacilityElement:IFacilityElement;
      PathElement:IPathElement;
      GuardRecList:TList;
      m, j, k, InfoState1:integer;
      SumW, ProdNoDetP:double;
    begin
      Result:=0;
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
          Q:=DoGetGuardVictoryProbability(InfoState1, k, GuardRecList);
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
                    InfoState1, CurrJ+1, GuardRecList)
      else
        Q0:=0;
      if ProdNotU<>1 then
        LocalBattleModel(B, BattleTime, AdversaryCount, AdversaryGroup,
                         GuardRecList, DataModel, WarriorPathElementE)
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


      if ProdNotU<>1 then
//Вычисляем вероятность успеха охраны в случае локального поражения в бою
        Q1:=DoGetGuardVictoryProbability(
                    InfoState1, CurrJ+1, GuardRecList)
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
    InfoState, j:integer;
  begin
    FacilityModelS:=DataModel as IFMState;
    GuardRecList:=TList.Create;
    TargetGuardRecList:=TList.Create;
    try
    FacilityModelS.CurrentPathStage:=wpsFastEntry;
    OldWarriorGroupU:=FacilityModelS.CurrentWarriorGroupU;
    AdversaryGroup:=OldWarriorGroupU as IWarriorGroup;
    AdversaryCount:=AdversaryGroup.InitialNumber;
    InfoState:=isFirstDetectionOccured or isLocationKnown;

//          writeln(DebugFile);
//          writeln(DebugFile,'Начало.'+WarriorPathElements.Item[0].Name+' '+
//                 IntToStr(StartPathElementJ));

    Result:=DoGetGuardVictoryProbability(
              InfoState, StartPathElementJ, GuardRecList);
    finally
      FacilityModelS.CurrentWarriorGroupU:=OldWarriorGroupU;
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
                           var AdversaryCount:double;
                           const AdversaryGroup:IWarriorGroup;
                           const GuardRecList:TList;
                           const DataModel: IDataModel;
                           const WarriorPathElementE:IDMElement);

var
  GuardRec:PGuardRec;
  i,j,j0,j1:integer;
  GuardGroup:IGuardGroup;
  GroupW:IWarriorGroup;
  GroupE, BattleLineE, BattleUnitE:IDMElement;
  FacilityModel:IFacilityModel;
  SomebodyAlive:double;
  TimeStep, CurrentTime, StartBattleTime:double;
  Unit0, Unit1:ICoordNode;
  BattleModel:IDMAnalyzer;
  BattleLines, BattleUnits, CoordNodes:IDMCollection;
  BattleLines2, BattleUnits2, CoordNodes2:IDMCollection2;
  BattleUnit:IBattleUnit;
  BattleLine:ILine;
  Unk:IUnknown;
  StartBattle:Boolean;
  FMaxTimeStep:double;
  FTimeStep:double;

  function NextStep:WordBool;
  var
    //BattleUnits:IDMCollection;
    j:integer;
    MinTimeStep, T:double;
    Group:IWarriorGroup;
    BattleUnit:IBattleUnit;
    BattleUnitE:IDMElement;
    P:double;
    BattleLine:IBattleLine;
//    Mem:PBattleModelMem;
  //  GuardGroup:IGuardGroup;
  begin
    Result:=True;

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
      Group:=BattleUnitE.Ref as IWarriorGroup;
      if (Group.QueryInterface(IAdversaryGroup, Unk)=0) and
         (Group.Task=0) then begin
        if (BattleUnit.State=busShotNoDefence) then
          BattleUnit.State := busShotHalfDefence;
        if //(BattleUnit.InDefence) or
           (BattleUnit.SomebodyAlive<1.e-3) then begin
          Result:=False;
          Exit;
        end;
      end else if (Group.QueryInterface(IGuardGroup, Unk)=0) then begin
        if (BattleUnit.State=busShotNoDefence) then
          BattleUnit.State := busShotHalfDefence;
      end;
      if MinTimeStep>T then
        MinTimeStep:=T;
    end;
    except
      raise
    end;

    try
//    BattleLines:=Get_BattleLines;
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

begin
  B:=0.99;
  BattleTime:=150;
  AdversaryCount:=0;
  Exit;
  
  FacilityModel:=DataModel as IFacilityModel;

  BattleModel:=FacilityModel.BattleModel as IDMAnalyzer;
//    if BattleModel<>nil then
//      BattleModel.Start(0);

  BattleLines:=(BattleModel as IBattleModel).Get_BattleLines;//TBattleLines.Create(BattleModel as IDMElement) as IDMCollection;
  BattleLines2:=BattleLines as IDMCollection2;
  BattleUnits:=(BattleModel as IBattleModel).Get_BattleUnits;//TBattleUnits.Create(BattleModel as IDMElement) as IDMCollection;
  BattleUnits2:=BattleUnits as IDMCollection2;
  CoordNodes:=TCoordNodes.Create(FacilityModel as IDMElement) as IDMCollection;
  CoordNodes2:=CoordNodes as IDMCollection2;
  (BattleModel as IBattleModel).ClearBattle;
//  (BattleModel as IBattleModel).StartBattle2;

    FMaxTimeStep:=(BattleModel as IBattleModel).DefaultTimeStep;
    TimeStep:=FMaxTimeStep;
    CurrentTime:=0;

    GroupE:=AdversaryGroup as IDMElement;//AdversaryVariant.AdversaryGroups.Item[j];
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

    for j:=0 to GuardRecList.Count-1 do begin
      GuardRec:=GuardRecList[j];
      if GuardRec.Active then begin

        GuardGroup:=IGuardGroup(GuardRec.GuardGroup);// as IDMElement;
        GroupE:=GuardGroup as IDMElement;
        BattleUnitE:=BattleUnits2.CreateElement(False);
        BattleUnits2.Add(BattleUnitE);
        BattleUnitE.Ref:=GroupE;
        BattleUnit:=BattleUnitE as IBattleUnit;

        (GroupE.SpatialElement as ICoordNode).X:=InfinitValue;//(BattleUnit as ICoordNode).X:=0;
        (GroupE.SpatialElement as ICoordNode).Y:=-5000;//(BattleUnit as ICoordNode).Y:=-100;
        (GroupE.SpatialElement as ICoordNode).Z:=0.5;//(BattleUnit as ICoordNode).Z:=0;
        BattleUnit.CurrentNode := GroupE.SpatialElement;
        TimeStep:=BattleUnit.StartBattle(TimeStep);
        if GuardRec.TDiff >= TimeStep then
          BattleUnit.State := busShotRun
        else if GuardRec.TDiff<TimeStep then
          BattleUnit.State := busShotHalfDefence;

        BattleUnit.Kind:=bukGuard;
      //MakeBattleUnit(GroupE, bukGuard);
      end;
    end;


    for j0:=0 to 0 do begin
      BattleUnitE:=BattleUnits.Item[j0];
      GroupE := BattleUnitE.Ref as IDMElement;
      Unit0 := GroupE.SpatialElement as ICoordNode;
      for j1:=1 to BattleUnits.Count-1 do begin
        BattleUnitE:=BattleUnits.Item[j1];
        GroupE := BattleUnitE.Ref as IDMElement;
        Unit1 := GroupE.SpatialElement as ICoordNode;

        BattleLineE:=BattleLines2.CreateElement(False);
        BattleLines2.Add(BattleLineE);
        (BattleLineE as IBattleLine).Visible:=false;
        (BattleLineE as IBattleLine).TransparencyCoeff:=1;
        BattleLine:=BattleLineE as ILine;
        BattleLine.C0:=Unit0;
        BattleLine.C1:=Unit1;
//        (BattleLine as IBattleLine).FacilityModel:=FacilityModel as IDMElement;
      end;
    end;
//    {//эти комментарии для StartBattle2
//    j:=0;
//    while j<BattleLines.Count do begin
//      BattleLineE := BattleLines.Item[j];
//    end;}
    StartBattle := False;
    StartBattleTime := 0;
    while NextStep do begin
      If (CurrentTime>86400) then Break;
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

    SomebodyAlive := 0;
    for j:=0 to BattleUnits.Count-1 do begin
      BattleUnitE:=BattleUnits.Item[j];
      GroupW:=BattleUnitE.Ref as IWarriorGroup;
      if (GroupW.QueryInterface(IGuardGroup, Unk)=0) and
         ((BattleUnitE as IBattleUnit).SomebodyAlive<1) and
         ((BattleUnitE as IBattleUnit).SomebodyAlive>SomebodyAlive) then
        SomebodyAlive := (BattleUnitE as IBattleUnit).SomebodyAlive;
    end;

    if (BattleUnits.Count>0) then begin
      BattleUnitE:=BattleUnits.Item[0];
      B := SomebodyAlive;
      if CurrentTime<86400 then
        BattleTime:=CurrentTime-StartBattleTime;
      AdversaryCount := (BattleUnitE as IBattleUnit).CalcNumber;
    end;

end;

initialization
  InitCash;
end.
