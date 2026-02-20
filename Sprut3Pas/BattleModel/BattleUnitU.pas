unit BattleUnitU;

interface
uses
  Classes, SysUtils, Math,
  DMElementU, CoordNodeU,
  DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  BattleModelLib_TLB, SafeguardAnalyzerLib_TLB;

const
  AliveHopeMin=0.95;

var
  Factorial:array[0..500] of double;


type
  TBattleUnit=class(TCoordNode, IBattleUnit)
  private
    FAliveArray:TList;
    FFacilityModel:IFacilityModel;
    FPath:IDMCollection;
    FOldAlive: Double;
    FNewAlive: Double;
    FAlive: Double;
    FSomebodyAlive: Double;
    FState: Integer;
    FHideState:integer;
    FPrevState:integer;
    FPrevHideState:integer;
    FKind:integer;
    FInDefence: boolean;
    FCurrentLine:ILine;

    FCurrentNode:ICoordNode;
    FNextNode:ICoordNode;

    FTimeToNextNode0:double;
    FTimeToNextNode:double;
    FCurrentLineIndex:integer;
    FLineCount:integer;

    FLineChange:boolean;

    FX0:double;
    FY0:double;
    FZ0:double;
    FX1:double;
    FY1:double;
    FZ1:double;
    FC0X:double;
    FC0Y:double;
    FC0Z:double;
    FC1X:double;
    FC1Y:double;
    FC1Z:double;

    FFireLineCount: Integer;
    FThreatSum: double;
    FAliveHope: double;
    FASum: double;
    FBSum: double;
    FTakeAimTimeMax: double;
    FTakeAimTimeMin: double;
    FTakeAimTime: double;
    FWeaponCount:integer;

    FBattleSkill:IBattleSkill;
    FWeaponKind:IWeaponKind;
    FWeaponKindG:IWeaponKind;
    FShotDistance:double;
    FShotForce:integer;
    FDefenceLevel:integer;
    FVehicleDefenceLevel:integer;
    FUsefulTime:double;

    FPdef: Double;
    FPgun: Double;
    FPveh: Integer;
    FTakeAimTimeMaxG: Integer;
    FShotForceG: Integer;
    FShotDistanceG: double;
    FTakeAimTimeG: double;
    FTakeAimTimeMinG: double;
    FWeaponCountG:integer;

    procedure CalcVehicleDefenceLevel;

  protected
    function CalcNumber:double; safecall;
    class function  GetClassID:integer; override;
    procedure Set_Ref(const Value:IDMElement); override;

    function  Get_Path:IDMCollection; safecall;
    procedure Set_Path(const Value:IDMCollection); safecall;
    function  Get_OldAlive: Double; safecall;
    procedure Set_OldAlive(Value: Double); safecall;
    function  Get_NewAlive: Double; safecall;
    procedure Set_NewAlive(Value: Double); safecall;
    function  Get_Alive: Double; safecall;
    procedure Set_Alive(Value: Double); safecall;
    function  Get_AliveHope: Double; safecall;
    procedure Set_AliveHope(Value: Double); safecall;
    function  Get_SomebodyAlive: Double; safecall;
    procedure Set_SomebodyAlive(Value: Double); safecall;
    function  Get_State: Integer; safecall;
    procedure Set_State(Value: Integer); safecall;
    function  Get_CurrentNode: IDMElement; safecall;
    procedure Set_CurrentNode(const Value: IDMElement); safecall;
    function  Get_NextNode: IDMElement; safecall;
    function  Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    function  Get_FacilityModel: IDMElement; safecall;
    procedure Set_FacilityModel(const Value: IDMElement); safecall;
    function  Get_InDefence: WordBool; safecall;
    procedure Set_InDefence(Value: WordBool); safecall;
    function  Get_WeaponGroupDamage: WordBool; safecall;

    function StartBattle(DefaultTimeStep:double):double; safecall;
    function NextStep(DefaultTimeStep, TimeStep:double):double; safecall;
    procedure StoreState; safecall;
    procedure LastStep; safecall;
    function  Get_FireLineCount: Integer; safecall;
    procedure Set_FireLineCount(Value: Integer); safecall;
    function  Get_ShotDistance:double; safecall;
    function  Get_ThreatSum: double; safecall;
    procedure Set_ThreatSum(Value: double); safecall;
    function  Get_ASum: double; safecall;
    procedure Set_ASum(Value: double); safecall;
    function  Get_BSum: double; safecall;
    procedure Set_BSum(Value: double); safecall;
    function  Get_TakeAimTimeMax: double; safecall;
    function  Get_TakeAimTimeMin: double; safecall;
    function  GetHitPMax(Distance: Double; AimState: Integer; GunFlag:WordBool): Double; safecall;
    function  GetHitPMin(Distance: Double; AimState: Integer; GunFlag:WordBool): Double; safecall;
    function  Get_TakeAimTime: Double; safecall;
    procedure CalcTakeAimTime; safecall;
    function  Get_EvadeFactor: Double; safecall;
    function  Get_ShotForce:integer; safecall;
    function  Get_DefenceLevel:integer; safecall;
    procedure  Set_DefenceLevel(Value:integer); safecall;
    function  Get_HideState:integer; safecall;
    function  Get_AliveArray(Index: Integer): Double; safecall;
    function  Get_NumberArray(Index: Integer): Double; safecall;
    function  Get_UsefulTimeArray(Index: Integer): Double; safecall;
    function  Get_AliveArrayCount: Integer; safecall;
    function  Get_Pdef: Double; safecall;
    procedure Set_Pdef(Value: Double); safecall;
    function  Get_Pgun: Double; safecall;
    procedure Set_Pgun(Value: Double); safecall;
    function  Get_Pveh: Integer; safecall;
    procedure Set_Pveh(Value: Integer); safecall;
    function  Get_TakeAimTimeMaxG: Integer; safecall;
    function  Get_ShotForceG: Integer; safecall;
    function  Get_ShotDistanceG: double; safecall;
    function  Get_TakeAimTimeG: double; safecall;
    function  Get_TakeAimTimeMinG: double; safecall;
    function  Get_WeaponCount:integer; safecall;
    function  Get_WeaponCountG:integer; safecall;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;


  TBattleUnits=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

type
  PBattleUnitMem = ^TBattleUnitMem;

  TBattleUnitMem = record
    Alive: double;
    Number:double;
    UsefulTime:double;
  end;

implementation
uses
  BattleModelConstU;

{ TBattleUnit }

class function TBattleUnit.GetClassID: integer;
begin
  Result:=_BattleUnit
end;

procedure TBattleUnit.Initialize;
begin
  inherited;
  FAliveArray:=TList.Create;
end;

function TBattleUnit.Get_Path: IDMCollection;
begin
  Result:=FPath
end;

procedure TBattleUnit.Set_Path(const Value: IDMCollection);
begin
  FPath:=Value
end;

procedure TBattleUnit._Destroy;
var
  j:integer;
begin
  inherited;
  for j:=0 to FAliveArray.Count-1 do
    FreeMem(FAliveArray[j],SizeOf(TBattleUnitMem));
  FAliveArray.Free;
  FPath:=nil;
  FFacilityModel:=nil;
  FCurrentLine:=nil;
  FCurrentNode:=nil;
  FNextNode:=nil;
  FBattleSkill:=nil;
  FWeaponKind:=nil;
  FWeaponKindG:=nil;
end;

function TBattleUnit.Get_OldAlive: Double;
begin
  Result:=FOldAlive
end;

function TBattleUnit.Get_State: Integer;
begin
  Result:=FState
end;

procedure TBattleUnit.Set_OldAlive(Value: Double);
begin
  FOldAlive:=Value
end;

procedure TBattleUnit.Set_State(Value: Integer);
begin
  FState := Value;
end;

procedure TBattleUnit.CalcVehicleDefenceLevel;
var
  Zone:IZone;
  RoadPart:IRoadPart;
  WarriorGroup:IWarriorGroup;
  VP, VV:double;
  VehicleKind:IVehicleKind;
begin
  WarriorGroup:=Ref as IWarriorGroup;
  if WarriorGroup.Vehicles.Count>0 then begin
    if (FCurrentLine as IDMElement).Ref.ClassID=_Zone then begin
      Zone:=(FCurrentLine as IDMElement).Ref as IZone;
      VP:=Zone.PedestrialVelocity;
      VV:=Zone.VehicleVelocity;
    end else
    if (FCurrentLine as IDMElement).Ref.ClassID=_RoadPart then begin
      RoadPart:=(FCurrentLine as IDMElement).Ref as IRoadPart;
      VP:=RoadPart.Road.PedestrialVelocity;
      VV:=RoadPart.Road.VehicleVelocity;
    end else begin
      VP:=0;
      VV:=0;
    end;
    if VV<VP then begin
      VehicleKind:=WarriorGroup.Vehicles.Item[0].Ref as IVehicleKind;
      FVehicleDefenceLevel:=VehicleKind.DefenceLevel;
    end else
      FVehicleDefenceLevel:=0;
  end;
end;

function TBattleUnit.NextStep(DefaultTimeStep, TimeStep:double):double;
var
  C1:ICoordNode;
  X, Y, Z, D:double;
  GuardPost:IGuardPost;
  GuardPostKind:IGuardPostKind;
  PathNode0, PathNode1:IVulnerabilityData;
  GuardGroup:IGuardGroup;
  BattleModel:IBattleModel;
  FirePosition:ITarget;
  FirePositionKindE:IDMElement;
  FacilityModelS:IFMState;
begin
  FFireLineCount:=0;
  FThreatSum:=0;
  FASum:=0;
  FBSum:=0;
  FAlive:=FOldAlive;

//Обеспечение времени прибытия охраны
  BattleModel:=DataModel as IBattleModel;
  FacilityModelS:=FFacilityModel as IFMState;

  if (Ref.QueryInterface(IGuardGroup,GuardGroup)=0) and
     (GuardGroup.StartDelay>BattleModel.CurrentTime) then  begin
    Result:=GuardGroup.StartDelay-BattleModel.CurrentTime;
    FState:= busStartDelay;
    FPrevState:=FState;
    Exit;
  end;

  if FState= busStartDelay then begin
    FState:= busShotRun;
    FHideState:= FState;
    FPrevState:=FState;
    FPrevHideState:=FState;
  end;


  FX0:=FX1;
  FY0:=FY1;
  FZ0:=FZ1;

  if FLineChange then begin
    FLineChange:=False;

    FCurrentNode:=FNextNode;

    if FInDefence then begin
      if (FCurrentNode as IDMElement).Ref.QueryInterface(IGuardPost, GuardPost)=0 then begin
        GuardPostKind:=(FCurrentNode as IDMElement).Ref.Ref as IGuardPostKind;
        FState:=GuardPostKind.OpenedDefenceState;
        FHideState:=GuardPostKind.HidedDefenceState;
        FPrevState:=FState;
        FPrevHideState:=FHideState;
        FDefenceLevel:=GuardPostKind.DefenceLevel;
        if FDefenceLevel<FVehicleDefenceLevel then
          FDefenceLevel:=FVehicleDefenceLevel;
      end else
      if (FCurrentNode as IDMElement).Ref.QueryInterface(ITarget, FirePosition)=0 then begin
        FirePositionKindE:=(FCurrentNode as IDMElement).Ref.Ref;
        if FirePositionKindE.Parent.ID=2 then begin
          FState:=FirePositionKindE.GetFieldValue(100);
          FHideState:=FirePositionKindE.GetFieldValue(101);
          FPrevState:=FState;
          FPrevHideState:=FHideState;
          FDefenceLevel:=FirePositionKindE.GetFieldValue(102);
          if FDefenceLevel<FVehicleDefenceLevel then
            FDefenceLevel:=FVehicleDefenceLevel;
        end else begin
          FState:=busShotChestDefence;
          FHideState:=busShotChestDefence;
          FPrevState:=FState;
          FPrevHideState:=FHideState;
          FDefenceLevel:=FVehicleDefenceLevel;
        end;
      end else begin
        FState:=busShotChestDefence;
        FPrevState:=FState;
        FHideState:=busShotChestDefence;
        FPrevHideState:=FHideState;
        FDefenceLevel:=FVehicleDefenceLevel;
      end;
    end else begin
      FNextNode:=FCurrentLine.NextNodeTo(FCurrentNode);
      C1:=FNextNode as ICoordNode;

      FC0X:=FC1X;
      FC0Y:=FC1Y;
      FC0Z:=FC1Z;

      FC1X:=C1.X;
      FC1Y:=C1.Y;
      FC1Z:=C1.Z;

      if (FCurrentLine as IDMElement).Ref.ClassID=_Boundary then begin
        FState:=busShotHalfDefence;
        FHideState:=busShotHalfDefence;
        FPrevState:=FState;
        FPrevHideState:=FHideState;
        FDefenceLevel:=FVehicleDefenceLevel;
      end else begin
        FState:=busShotRun;
        FHideState:=busShotRun;
        FPrevState:=FState;
        FPrevHideState:=FHideState;
        FDefenceLevel:=FVehicleDefenceLevel;
      end;
    end;
  end;

  if not FInDefence then begin
    if abs(TimeStep-FTimeToNextNode)<0.001 then begin
      FLineChange:=True;

      FX1:=FC1X;
      FY1:=FC1Y;
      FZ1:=FC1Z;

      inc(FCurrentLineIndex);
      if FCurrentLineIndex<FLineCount then begin
        FCurrentLine:=FPath.Item[FCurrentLineIndex] as ILine;

        CalcVehicleDefenceLevel;

        PathNode0:=FCurrentLine.C0 as IVulnerabilityData;
        PathNode1:=FCurrentLine.C1 as IVulnerabilityData;

        FacilityModelS.CurrentWarriorGroupU:=Ref;
        if FKind<>bukPatrol then
          FTimeToNextNode0:=abs(PathNode1.DelayTimeToTarget-PathNode0.DelayTimeToTarget)
        else
          FTimeToNextNode0:=abs((PathNode1 as IPathNode).BestDistance-
                                (PathNode0 as IPathNode).BestDistance);

        FTimeToNextNode:=FTimeToNextNode0;
      end else begin
        FInDefence:=True;
        FTimeToNextNode:=DefaultTimeStep;
      end;
    end else begin
      if FTimeToNextNode0>0 then begin
        D:=FTimeToNextNode/FTimeToNextNode0;
        FX1:=FC1X+(FC0X-FC1X)*D;
        FY1:=FC1Y+(FC0Y-FC1Y)*D;
        FZ1:=FC1Z+(FC0Z-FC1Z)*D;
      end else begin
        FX1:=FC1X;
        FY1:=FC1Y;
        FZ1:=FC1Z;
      end;
      if FAliveHope>AliveHopeMin then begin
        FTimeToNextNode:=FTimeToNextNode-TimeStep;
        FState:=FPrevState;
        FHideState:=FPrevHideState;
        FUsefulTime:=FUsefulTime+TimeStep;
      end else begin
        if FState<busShotChestDefence then begin
          FPrevState:=FState;
          FState:=busShotChestDefence;
        end;
        if FHideState<busShotChestDefence then begin
          FPrevHideState:=FHideState;
          FState:=busShotChestDefence;
        end;
      end;

      if FTimeToNextNode<0 then
        FTimeToNextNode:=0;
    end;

    X:=0.5*(FX0+FX1);
    Y:=0.5*(FY0+FY1);
    Z:=0.5*(FZ0+FZ1);

    if FTimeToNextNode<DefaultTimeStep then
      Result:=FTimeToNextNode
    else
      Result:=DefaultTimeStep

  end else begin
    X:=FX1;
    Y:=FY1;
    Z:=FZ1;
    Result:=DefaultTimeStep;
  end;

  Set_X(X);
  Set_Y(Y);
  Set_Z(Z);
end;

function TBattleUnit.StartBattle(DefaultTimeStep:double):double;
var
  C0, C1:ICoordNode;
  X, Y, Z:double;
  WarriorGroup:IWarriorGroup;
  GuardPost:IGuardPost;
  GuardPostKind:IGuardPostKind;
  PathNode0, PathNode1:IVulnerabilityData;
  FacilityModelS:IFMState;
begin
  FacilityModelS:=FFacilityModel as IFMState;
  WarriorGroup:=Ref as IWarriorGroup;

  FOldAlive:=1;
  FNewAlive:=1;
  FSomebodyAlive:=1;
  FPdef:=1;

  if (FPath<>nil) and
     (FPath.Count>0) then begin
    if FKind<>bukAdversary then
      FCurrentLineIndex:=0
    else begin           // точка старта на бесконечности
      if (FCurrentNode as IDMElement).Ref.SpatialElement=nil then begin
        FCurrentLine:=FPath.Item[0] as ILine;

        CalcVehicleDefenceLevel;

        FCurrentNode:=FCurrentLine.NextNodeTo(FCurrentNode);
        FCurrentLineIndex:=1;
      end else
        FCurrentLineIndex:=0;
    end;
    FLineCount:=FPath.Count;
    FCurrentLine:=FPath.Item[FCurrentLineIndex] as ILine;

    CalcVehicleDefenceLevel;
    if WarriorGroup.Vehicles.Count>0 then
      FPveh:=1;

    FNextNode:=FCurrentLine.NextNodeTo(FCurrentNode);

    PathNode0:=FCurrentLine.C0 as IVulnerabilityData;
    PathNode1:=FCurrentLine.C1 as IVulnerabilityData;

    FacilityModelS.CurrentWarriorGroupU:=Ref;
    if FKind<>bukPatrol then
      FTimeToNextNode0:=abs(PathNode1.DelayTimeToTarget-PathNode0.DelayTimeToTarget)
    else
      FTimeToNextNode0:=abs((PathNode1 as IPathNode).BestDistance-
                            (PathNode0 as IPathNode).BestDistance);

    FTimeToNextNode:=FTimeToNextNode0;
    if FTimeToNextNode<=DefaultTimeStep then
      Result:=FTimeToNextNode
    else
      Result:=DefaultTimeStep;

    FInDefence:=False;

    FState:=busShotRun;
    FHideState:=busShotRun;
    FPrevState:=FState;
    FPrevHideState:=FHideState;
    FDefenceLevel:=FVehicleDefenceLevel;
  end else begin
    FCurrentLine:=nil;
    FNextNode:=FCurrentNode;
    FTimeToNextNode:=0;
    Result:=DefaultTimeStep;

    FInDefence:=True;

    if WarriorGroup.StartPoint.QueryInterface(IGuardPost, GuardPost)<>0 then begin
      FState:=busShotNoDefence;
      FHideState:=busShotNoDefence;
      FPrevState:=FState;
      FPrevHideState:=FHideState;
      FDefenceLevel:=FVehicleDefenceLevel;
    end else begin
      GuardPostKind:=WarriorGroup.StartPoint.Ref as IGuardPostKind;
      FState:=GuardPostKind.OpenedDefenceState;
      FHideState:=GuardPostKind.HidedDefenceState;
      FPrevState:=FState;
      FPrevHideState:=FHideState;
      FDefenceLevel:=GuardPostKind.DefenceLevel;
      if FDefenceLevel<FVehicleDefenceLevel then
        FDefenceLevel:=FVehicleDefenceLevel;
    end;
  end;
    C0:=FCurrentNode as ICoordNode;
    C1:=FNextNode as ICoordNode;
    FC0X:=C0.X;
    FC0Y:=C0.Y;
    FC0Z:=C0.Z;

    FC1X:=C1.X;
    FC1Y:=C1.Y;
    FC1Z:=C1.Z;

    FX1:=FC0X;
    FY1:=FC0Y;
    FZ1:=FC0Z;

    X:=FX1;
    Y:=FY1;
    Z:=FZ1;


  Set_X(X);
  Set_Y(Y);
  Set_Z(Z);

end;

function TBattleUnit.Get_CurrentNode: IDMElement;
begin
  Result:=FCurrentNode as IDMElement
end;

procedure TBattleUnit.Set_CurrentNode(const Value: IDMElement);
begin
  FCurrentNode:=Value as ICoordNode
end;

function TBattleUnit.Get_Kind: Integer;
begin
  Result:=FKind
end;

procedure TBattleUnit.Set_Kind(Value: Integer);
begin
  FKind:=Value
end;

function TBattleUnit.Get_FacilityModel: IDMElement;
begin
  Result:=FFacilityModel as IDMElement
end;

procedure TBattleUnit.Set_FacilityModel(const Value: IDMElement);
begin
  FFacilityModel:=Value as IFacilityModel
end;

function TBattleUnit.Get_InDefence: WordBool;
begin
  Result:=FInDefence
end;

function TBattleUnit.Get_NextNode: IDMElement;
begin
  Result:=FNextNode as IDMElement
end;

function TBattleUnit.Get_FireLineCount: Integer;
begin
  Result:=FFireLineCount
end;

procedure TBattleUnit.Set_FireLineCount(Value: Integer);
begin
  FFireLineCount:=Value
end;

function TBattleUnit.Get_ThreatSum: double;
begin
  Result:=FThreatSum
end;

procedure TBattleUnit.Set_ThreatSum(Value: double);
begin
  FThreatSum:=Value
end;

function TBattleUnit.Get_TakeAimTimeMax: double;
begin
  Result:=FTakeAimTimeMax
end;

function TBattleUnit.GetHitPMax(Distance: Double; AimState: Integer;
                                GunFlag:WordBool): Double;
var
  WeaponScoreP:double;
  aWeaponKind:IWeaponKind;
begin   //!!!!!!!!!!!!!!!
  Result:=0;

  if GunFlag then
    aWeaponKind:=FWeaponKindG
  else
    aWeaponKind:=FWeaponKind;

  if aWeaponKind=nil then Exit;
  WeaponScoreP:=aWeaponKind.GetScoreProbability(Distance, FState, AimState);

  case FState of
  busShotRun:
    case AimState of
    busShotRun:   Result:=WeaponScoreP*FBattleSkill.RunRunScoringFactor;
    busHide:      Result:=0;
    else          Result:=WeaponScoreP*FBattleSkill.RunStillScoringFactor;
    end;
  busHide:
    Result:=0
  else
    case AimState of
    busShotRun:   Result:=WeaponScoreP*FBattleSkill.StillRunScoringFactor;
    busHide:      Result:=0;
    else          Result:=WeaponScoreP*FBattleSkill.StillStillScoringFactor;
    end;
  end;
end;

function TBattleUnit.GetHitPMin(Distance: Double; AimState: Integer;
                                GunFlag:WordBool): Double;
var
  WeaponScoreP:double;
  aWeaponKind:IWeaponKind;
begin
  Result:=0;
  if GunFlag then
    aWeaponKind:=FWeaponKindG
  else
    aWeaponKind:=FWeaponKind;

  if aWeaponKind=nil then Exit;

  case FState of
  busHide:
    Result:=0
  else
    begin
      WeaponScoreP:=aWeaponKind.GetScoreProbability(Distance, busShotRun, AimState);
      case AimState of
      busShotRun:   Result:=WeaponScoreP*FBattleSkill.RunRunScoringFactor;
      busHide:      Result:=0;
      else          Result:=WeaponScoreP*FBattleSkill.RunStillScoringFactor;
      end;
    end;
  end;
end;

procedure TBattleUnit.Set_Ref(const Value: IDMElement);
var
  WarriorGroup:IWarriorGroup;
  j, m:integer;
  aWeaponKind:IWeaponKind;
  aVehicleKind:IVehicleKind;
  aWeaponE:IDMElement;
begin
  inherited;
  if Value=nil then Exit;

  WarriorGroup:=Value as IWarriorGroup;

  FBattleSkill:=WarriorGroup.BattleSkill as IBattleSkill;
  FTakeAimTimeMax:=FBattleSkill.TakeAimTime;
  FWeaponKind:=nil;
  FShotDistance:=0;
  FShotForce:=0;
  FTakeAimTimeMin:=0;

  FWeaponKindG:=nil;
  FShotDistanceG:=0;
  FShotForceG:=0;
  FTakeAimTimeMinG:=0;

  for j:=0 to WarriorGroup.Weapons.Count-1 do begin
    aWeaponE:=WarriorGroup.Weapons.Item[j];
    aWeaponKind:=aWeaponE.Ref as IWeaponKind;
    if aWeaponKind.ShotForce>=2 then begin // пробивает защиту от срелкового оружия
      FWeaponKindG:=aWeaponKind;
      FWeaponCountG:=(aWeaponE as IWeapon).Count;
    end else begin
      FWeaponKind:=aWeaponKind;
      FWeaponCount:=(aWeaponE as IWeapon).Count;
    end;
  end;

  for m:=0 to WarriorGroup.Vehicles.Count-1 do begin
    aVehicleKind:=WarriorGroup.Vehicles.Item[m].Ref as IVehicleKind;
    for j:=0 to aVehicleKind.WeaponKinds.Count-1 do begin
      aWeaponKind:=aVehicleKind.WeaponKinds.Item[j] as IWeaponKind;
      if aWeaponKind.ShotForce>=2 then  // пробивает защиту от срелкового оружия
        FWeaponKindG:=aWeaponKind;
        FWeaponCountG:=1;
    end;
  end;

  if FWeaponKind<>nil then begin
    FShotDistance:=FWeaponKind.MaxShotDistance;
    FShotForce:=FWeaponKind.ShotForce;
    FTakeAimTimeMin:=60/FWeaponKind.ShotRate;
  end;
  if FWeaponKindG<>nil then begin
    FShotDistanceG:=FWeaponKindG.MaxShotDistance;
    FShotForceG:=FWeaponKindG.ShotForce;
    FTakeAimTimeMinG:=60/FWeaponKindG.ShotRate;
    FPgun:=1;
  end;
end;

function TBattleUnit.Get_NewAlive: Double;
begin
  Result:=FNewAlive
end;

procedure TBattleUnit.Set_NewAlive(Value: Double);
begin
  FNewAlive:=Value
end;

procedure TBattleUnit.CalcTakeAimTime;
begin
  FTakeAimTime:=(FBSum/FThreatSum-FASum)/(2*FBSum);
  if FTakeAimTime<0 then
    FTakeAimTime:=0
end;

function TBattleUnit.Get_TakeAimTime: Double;
begin
  Result:=FTakeAimTime
end;

function TBattleUnit.Get_EvadeFactor: Double;
begin
  case FState of
  busShotRun: Result:=FBattleSkill.RunEvadeFactor;
  else    Result:=FBattleSkill.StillEvadeFactor;
  end;
end;

function TBattleUnit.Get_ASum: double;
begin
  Result:=FASum
end;

function TBattleUnit.Get_BSum: double;
begin
  Result:=FBSum
end;

procedure TBattleUnit.Set_ASum(Value: double);
begin
  FASum:=Value
end;

procedure TBattleUnit.Set_BSum(Value: double);
begin
  FBSum:=Value
end;

function TBattleUnit.Get_ShotDistance: double;
begin
  Result:=FShotDistance
end;

function TBattleUnit.Get_TakeAimTimeMin: double;
begin
  Result:=FTakeAimTimeMin
end;

function TBattleUnit.Get_DefenceLevel: integer;
begin
  Result:=FDefenceLevel
end;

procedure TBattleUnit.Set_DefenceLevel(Value:integer);
begin
  FDefenceLevel:=Value
end;

function TBattleUnit.Get_HideState: integer;
begin
  Result:=FHideState
end;

function TBattleUnit.Get_ShotForce: integer;
begin
  Result:=FShotForce
end;

procedure TBattleUnit.Set_InDefence(Value: WordBool);
begin
  FInDefence:=Value
end;

function TBattleUnit.Get_WeaponGroupDamage: WordBool;
begin
  Result:=False;
  if FWeaponKind=nil then Exit;
  Result:=FWeaponKind.GroupDamage;
end;

procedure TBattleUnit.Draw(const aPainter: IInterface;
  DrawSelected: integer);
begin
  inherited;

end;

function TBattleUnit.Get_AliveArray(index: integer): double;
begin
  Result:=PBattleUnitMem(FAliveArray[index]).alive;
end;

procedure TBattleUnit.LastStep;
var
    Mem: PBattleUnitMem;
begin
    GetMem(Mem,SizeOf(TBattleUnitMem));
    FAliveArray.Add(Mem);
    Mem.Alive:=FSomebodyAlive;
    Mem.Number:=CalcNumber;
    Mem.UsefulTime:=FUsefulTime;
end;


function TBattleUnit.Get_AliveArrayCount: Integer;
begin
  Result:=FAliveArray.Count;
end;

procedure TBattleUnit.StoreState;
var
  Mem: PBattleUnitMem;
  WarriorGroup:IWarriorGroup;
begin
     FOldAlive:=FAlive;
     GetMem(Mem,SizeOf(TBattleUnitMem));
     FAliveArray.Add(Mem);
     WarriorGroup:=Ref as IWarriorGroup;
     FSomebodyAlive:=1-Power(1-FAlive, WarriorGroup.InitialNumber);
     Mem.alive:=FSomebodyAlive;
     Mem.Number:=CalcNumber;
     Mem.UsefulTime:=FUsefulTime;
     FAliveHope:=1;
end;

function TBattleUnit.Get_Alive: Double;
begin
  Result:=FAlive
end;

procedure TBattleUnit.Set_Alive(Value: Double);
begin
  FAlive:=Value
end;

function TBattleUnit.Get_SomebodyAlive: Double;
begin
  Result:=FSomebodyAlive;
end;

function TBattleUnit.Get_AliveHope: Double;
begin
  Result:=FAliveHope
end;

procedure TBattleUnit.Set_AliveHope(Value: Double);
begin
  FAliveHope:=Value;
end;

function TBattleUnit.CalcNumber: double;
var
  WarriorGroup:IWarriorGroup;
  N, j:integer;
  V, S, P, PA, PD:double;
begin
  WarriorGroup:=Ref as IWarriorGroup;
  N:=WarriorGroup.InitialNumber;
  Result:=0;
  S:=0;
  for j:=0 to N do begin
    PA:=Power(FOldAlive, j);
    PD:=Power(1-FOldAlive, N-j);
    P:=PA*PD*Factorial[N]/(Factorial[j]*Factorial[N-j]);
    V:=j*P;
    S:=S+P;
    Result:=Result+V;
  end;
//  Result:=Result/S;
end;

function TBattleUnit.Get_NumberArray(Index: Integer): Double;
begin
  Result:=PBattleUnitMem(FAliveArray[index]).Number;
end;

function TBattleUnit.Get_UsefulTimeArray(Index: Integer): Double;
begin
  Result:=PBattleUnitMem(FAliveArray[index]).UsefulTime;
end;

function TBattleUnit.Get_Pdef: Double;
begin
  Result:=FPdef
end;

function TBattleUnit.Get_Pgun: Double;
begin
  Result:=FPgun
end;

function TBattleUnit.Get_Pveh: Integer;
begin
  Result:=FPveh
end;

function TBattleUnit.Get_ShotDistanceG: double;
begin
  Result:=FShotDistanceG
end;

function TBattleUnit.Get_ShotForceG: Integer;
begin
  Result:=FShotForceG
end;

function TBattleUnit.Get_TakeAimTimeG: double;
begin
  Result:=FTakeAimTimeG
end;

function TBattleUnit.Get_TakeAimTimeMaxG: Integer;
begin
  Result:=FTakeAimTimeMaxG
end;

function TBattleUnit.Get_TakeAimTimeMinG: double;
begin
  Result:=FTakeAimTimeMinG
end;

procedure TBattleUnit.Set_Pdef(Value: Double);
begin
  FPdef:=Value
end;

procedure TBattleUnit.Set_Pgun(Value: Double);
begin
  FPgun:=Value
end;

procedure TBattleUnit.Set_Pveh(Value: Integer);
begin
  FPveh:=Value
end;

function TBattleUnit.Get_WeaponCount: integer;
begin
  Result:=FWeaponCount
end;

function TBattleUnit.Get_WeaponCountG: integer;
begin
  Result:=FWeaponCountG
end;

procedure TBattleUnit.Set_SomebodyAlive(Value: Double);
begin
  FSomebodyAlive := Value;
end;

{ TBattleUnits }

function TBattleUnits.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsBattleUnit
end;

class function TBattleUnits.GetElementClass: TDMElementClass;
begin
  Result:=TBattleUnit
end;

class function TBattleUnits.GetElementGUID: TGUID;
begin
  Result:=IID_IBattleUnit
end;

var
  j:integer;
initialization
  Factorial[0]:=1;
  try
  for j:=1 to 500 do
    Factorial[j]:=Factorial[j-1]*j;
  except
    raise
  end;    
end.
