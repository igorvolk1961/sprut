unit BattleLineU;

interface
uses
  Classes, SysUtils, Math, Graphics,
  DMElementU, LineU,
  DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  BattleModelLib_TLB;

const
  DangerLevel0=0.0001;
    
type
  TBattleLine=class(TLine, IBattleLine)
  private
    FFacilityModel:IFacilityModel;
    FSeparatingAreas:IDMCollection;
    FVisible:boolean;
    FThreat01: Double;
    FThreat10: Double;
    FTransparencyCoeff: Double;
    FScoreProbability01: Double;
    FScoreProbability10: Double;
    FBattleUnit0: IBattleUnit;
    FBattleUnit1: IBattleUnit;
  protected
    class function  GetClassID:integer; override;
    function  Get_FacilityModel: IDMElement; safecall;
    procedure Set_FacilityModel(const Value: IDMElement); safecall;
    procedure CalcThreat; safecall;
    procedure CalcAliveHope; safecall;
    procedure CalcScoreProbability(TimeStep:double); safecall;
    procedure CheckFireLine; safecall;
    function  Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure Set_TransparencyCoeff(Value: Double); safecall;
    function  Get_Threat01: Double; safecall;
    function  Get_Threat10: Double; safecall;
    function  Get_ScoreProbability01: Double; safecall;
    function  Get_ScoreProbability10: Double; safecall;
    procedure Set_C0(const Value:ICoordNode); override;
    procedure Set_C1(const Value:ICoordNode); override;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    procedure IncFireLineCount; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TBattleLines=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  BattleModelConstU;

{ TBattleLine }

procedure TBattleLine.CalcThreat;
var
  Length:double;

  function DoCalcThreat(aUnit0, aUnit1:IBattleUnit):double;
  var
    HitPMax, HitPMin, aThreat, HitPMaxG: double;
    Unit0State, Unit1State:integer;
  begin
    if aUnit0.ShotForce>aUnit1.DefenceLevel then begin
      Unit1State:=busShotNoDefence;
    end else
    if aUnit0.ShotForce=aUnit1.DefenceLevel then begin
      Unit1State:=aUnit1.State;
      if aUnit0.WeaponGroupDamage then begin
        Unit1State:=Unit1State-2;
        if Unit1State<0 then
          Unit1State:=busShotNoDefence;
      end;
    end else begin  // if aUnit0.ShotForce<aUnit1.DefenceLevel
      Unit1State:=aUnit1.State;
    end;

    HitPMax:=aUnit0.GetHitPMax(Length, Unit1State, False);
    HitPMaxG:=aUnit0.GetHitPMax(Length, Unit1State, True);

    aThreat:=aUnit0.OldAlive*(HitPMax+HitPMaxG)/aUnit0.FireLineCount*FTransparencyCoeff;
    if ((aUnit0 as IDMElement).Ref.ClassID=_AdversaryGroup) then begin
      if ((aUnit0 as IDMElement).Ref as IWarriorGroup).Task=MainGroup then
        Result:=aUnit0.OldAlive
      else
        Result:=aThreat;
    end else
      Result:=aThreat;

    aUnit1.ThreatSum:=aUnit1.ThreatSum+Result;

    if aUnit0.ShotForce>aUnit1.DefenceLevel then begin
      Unit0State:=busShotNoDefence;
    end else
    if aUnit0.ShotForce=aUnit1.DefenceLevel then begin
      Unit0State:=aUnit0.State;
      if aUnit0.WeaponGroupDamage then begin
        Unit0State:=Unit0State-2;
        if Unit0State<0 then
          Unit0State:=busShotNoDefence;
      end;
    end else begin  // if aUnit0.ShotForce<aUnit1.DefenceLevel
      Unit0State:=aUnit0.State;
    end;

    if Unit0State<>busHide then begin
      HitPMin:=aUnit1.GetHitPMin(Length, Unit0State, False);
      HitPMax:=aUnit1.GetHitPMax(Length, Unit0State, False);

      aUnit1.ASum:=aUnit1.ASum+HitPMin*aThreat;
      aUnit1.BSum:=aUnit1.BSum+(HitPMax-HitPMin)*aThreat/
                 (aUnit1.TakeAimTimeMax-aUnit1.TakeAimTimeMin);
    end;
  end;

begin
  if not FVisible then Exit;
  Length:=Get_Length;
  FThreat01:=DoCalcThreat(FBattleUnit0, FBattleUnit1);
  FThreat10:=DoCalcThreat(FBattleUnit1, FBattleUnit0);
end;

procedure TBattleLine.CalcAliveHope;
var
  Length:double;

  procedure DoCalcAliveHope(aUnit0, aUnit1:IBattleUnit);
  var
    HitPMax, aThreat, P: double;
    WeaponCount:integer;
    WarriorGroup0:IWarriorGroup;
  begin
    WarriorGroup0:=(aUnit0 as IDMElement).Ref as IWarriorGroup;
    WeaponCount:=aUnit0.WeaponCount;

    HitPMax:=aUnit0.GetHitPMax(Length, busShotNoDefence, False);

    aThreat:=aUnit0.OldAlive*HitPMax/aUnit0.FireLineCount*FTransparencyCoeff;

    P:=Power(1-aThreat, WeaponCount);

    aUnit1.AliveHope:=aUnit1.AliveHope*P;

  end;

begin
  if not FVisible then Exit;
  Length:=Get_Length;
  DoCalcAliveHope(FBattleUnit0, FBattleUnit1);
  DoCalcAliveHope(FBattleUnit1, FBattleUnit0);
end;

procedure TBattleLine.CalcScoreProbability(TimeStep:double);
var
  Length:double;

  function DoCalcScoreProbability(aUnit0, aUnit1:IBattleUnit;
                      Threat:double):double;
  var
    Base, Exponent,
    HitPMax, HitPMin, HitPHide, HitPHideD, Pdef1, HitP, P,
    T0, T1, T0Max, T1Max, T0Min, T1Min,
    HideFactor: double;
    WeaponCount, WeaponCountG, N1:integer;
    WarriorGroup0, WarriorGroup1:IWarriorGroup;
    UnitState, UnitHideState:integer;
    Pgun0, T0MaxG, T0MinG, T0G, HitPMinG, HitPMaxG, HitPG, ScoreG:double;
    BaseG, ExponentG, PG:double;
  begin
//    0 стрел€ет по 1

    WarriorGroup0:=(aUnit0 as IDMElement).Ref as IWarriorGroup;
    WarriorGroup1:=(aUnit1 as IDMElement).Ref as IWarriorGroup;

    T0:=aUnit0.TakeAimTime;
    T1:=aUnit1.TakeAimTime;
    T0Max:=aUnit0.TakeAimTimeMax;
    T1Max:=aUnit1.TakeAimTimeMax;
    T0Min:=aUnit0.TakeAimTimeMin;
    T1Min:=aUnit1.TakeAimTimeMin;
    if T1Max<T1Min then
      T1Max:=T1Min;
    if T0Max<T0Min then
      T0Max:=T0Min;

    if T0>T0Max then
      T0:=T0Max;
    if T0<T0Min then
      T0:=T0Min;

    if T1>T1Max then
      T1:=T1Max;
    if T1<T1Min then
      T1:=T1Min;

    Pgun0:=aUnit0.Pgun;
    if Pgun0<>0 then begin
      T0G:=aUnit0.TakeAimTimeG;
      T0MaxG:=aUnit0.TakeAimTimeMaxG;
      T0MinG:=aUnit0.TakeAimTimeMinG;
      if T0MaxG<T0MinG then
        T0MaxG:=T0MinG;
      if T0G>T0MaxG then
        T0G:=T0MaxG;
      if T0G<T0MinG then
        T0G:=T0MinG;
    end else begin
      T0G:=0;
      T0MaxG:=0;
      T0MinG:=0;
    end;

    WeaponCount:=aUnit0.WeaponCount;
    WeaponCountG:=aUnit0.WeaponCountG;
    N1:=WarriorGroup1.InitialNumber;


    if aUnit0.ShotForce>aUnit1.DefenceLevel then begin
      UnitState:=busShotNoDefence;
      UnitHideState:=aUnit1.HideState;
      if aUnit0.WeaponGroupDamage then begin
        UnitHideState:=UnitHideState-3;
        if UnitHideState<0 then
          UnitHideState:=busShotNoDefence;
      end;
    end else
    if aUnit0.ShotForce=aUnit1.DefenceLevel then begin
      UnitState:=aUnit1.State;
      UnitHideState:=aUnit1.HideState;
      if aUnit0.WeaponGroupDamage then begin
        UnitState:=UnitState-2;
        if UnitState<0 then
          UnitState:=busShotNoDefence;
        UnitHideState:=UnitHideState-2;
        if UnitHideState<0 then
          UnitHideState:=busShotNoDefence;
      end;
    end else begin  // if aUnit0.ShotForce<aUnit1.DefenceLevel
      UnitState:=aUnit1.State;
      UnitHideState:=aUnit1.HideState;
    end;

    HitPMin:=aUnit0.GetHitPMin(Length, UnitState, False);
    if Pgun0<>0 then
      HitPMinG:=aUnit0.GetHitPMin(Length, UnitState, True)
    else
      HitPMinG:=0;

    if aUnit0.State=busShotRun then begin
      HitP:=HitPMin;
      if Pgun0<>0 then
        HitPG:=HitPMinG
      else
        HitPG:=0;
    end else begin
      HitPMax:=aUnit0.GetHitPMax(Length, UnitState, False);
      HitP:=HitPMin+(HitPMax-HitPMin)*(T0-T0Min)/(T0Max-T0Min);
      if Pgun0<>0 then begin
        HitPMaxG:=aUnit0.GetHitPMax(Length, UnitState, True);
        HitPG:=HitPMinG+(HitPMaxG-HitPMinG)*(T0G-T0MinG)/(T0MaxG-T0MinG)
      end else
        HitPG:=0;
    end;

    if UnitHideState=busHide then
      HitPHide:=0
    else
      HitPHide:=aUnit0.GetHitPMin(Length, UnitHideState, False);

    HideFactor:=1-T1/T1Max;

    if aUnit0.ThreatSum>0 then begin
      if Pgun0<>0 then begin
        ScoreG:=aUnit0.OldAlive*Threat/aUnit0.ThreatSum*
                (HitPG*(1-HideFactor)+HitPHide*HideFactor)*
                FTransparencyCoeff;
        if ScoreG<1 then begin
          BaseG:=1-ScoreG;
          ExponentG:=WeaponCountG*TimeStep/T0MaxG;
          PG:=Power(BaseG, ExponentG);
          aUnit1.PDef:=aUnit1.PDef*PG;
        end else
          aUnit1.PDef:=0;
      end;

      Pdef1:=aUnit1.Pdef;
      HitPHideD:=Pdef1*HitPHide+(1-Pdef1)*HitP;

      Result:=aUnit0.OldAlive*Threat/aUnit0.ThreatSum*
              (1-aUnit1.EvadeFactor)/N1*
              (HitP*(1-HideFactor)+HitPHideD*HideFactor)*
              FTransparencyCoeff
    end else begin
      if Pgun0<>0 then begin
        ScoreG:=aUnit0.OldAlive/aUnit0.FireLineCount*
                (HitPG*(1-HideFactor)+HitPHide*HideFactor)*
                FTransparencyCoeff;
        if ScoreG<1 then begin
          BaseG:=1-ScoreG;
          ExponentG:=WeaponCountG*TimeStep/T0MaxG;
          PG:=Power(BaseG, ExponentG);
          aUnit1.PDef:=aUnit1.PDef*PG;
        end else
          aUnit1.PDef:=0;
      end;

      Pdef1:=aUnit1.Pdef;
      HitPHideD:=Pdef1*HitPHide+(1-Pdef1)*HitP;

      Result:=aUnit0.OldAlive/aUnit0.FireLineCount*
              (1-aUnit1.EvadeFactor)/N1*
              (HitP*(1-HideFactor)+HitPHideD*HideFactor)*
              FTransparencyCoeff;
    end;

    if Result<1 then begin
      Base:=1-Result;
      Exponent:=WeaponCount*TimeStep/T0Max;
      P:=Power(Base, Exponent);
      aUnit1.Alive:=aUnit1.Alive*P;
      if (aUnit1.Kind=bukGuard) and
         (WarriorGroup1.Task=gtInterruptOnDetectionPoint) and
         (Result>DangerLevel0) then begin
        aUnit1.InDefence:=True;
        aUnit1.State:=busShotChestDefence;
      end else
      if aUnit1.Kind=bukPatrol then begin
        aUnit1.InDefence:=True;
        aUnit1.State:=busShotChestDefence;
      end;
    end else
      aUnit1.Alive:=0;
  end;

begin
  if not FVisible then Exit;
  Length:=Get_Length;
  FScoreProbability01:=DoCalcScoreProbability(FBattleUnit0, FBattleUnit1,
                                              FThreat10);
  FScoreProbability10:=DoCalcScoreProbability(FBattleUnit1, FBattleUnit0,
                                              FThreat01);
end;

procedure TBattleLine.CheckFireLine;
var
  C0, C1:ICoordNode;
  CurrentNode0E, NextNode0E,
  CurrentNode1E, NextNode1E, Ref0, Ref1, CRef, NRef:IDMElement;
  CN, NN: ICoordNode;
  j:integer;
  DC, DN, X0, Y0, Z0, X1, Y1, Z1:double;
  Volume, VolumeC, VolumeN:IVolume;
  Area:IArea;
  BattleModel:  IBattleModel;
  GuardGroup:   IGuardGroup;
begin
  C0:=Get_C0;
  C1:=Get_C1;

//ќбеспечение времени прибыти€ охраны
  BattleModel:=DataModel as IBattleModel;
  if ((C0 as IDMElement).Ref.QueryInterface(IGuardGroup,GuardGroup)=0) and
     (GuardGroup.StartDelay>BattleModel.CurrentTime) then
    begin
     FVisible:=False;
     Exit;
    end;
  BattleModel:=DataModel as IBattleModel;
  if ((C1 as IDMElement).Ref.QueryInterface(IGuardGroup,GuardGroup)=0) and
     (GuardGroup.StartDelay>BattleModel.CurrentTime) then
    begin
     FVisible:=False;
     Exit;
    end;

  CurrentNode0E:=FBattleUnit0.CurrentNode;
  if CurrentNode0E.Ref=nil then begin
    FVisible:=False;
    Exit;
  end;
  CurrentNode1E:=FBattleUnit1.CurrentNode;
  if CurrentNode1E.Ref=nil then begin
    FVisible:=False;
    Exit;
  end;
  NextNode0E:=FBattleUnit0.NextNode;
  NextNode1E:=FBattleUnit1.NextNode;
  if NextNode0E.Ref=nil then begin
    FVisible:=False;
    Exit;
  end;
  if NextNode1E.Ref=nil then begin
    FVisible:=False;
    Exit;
  end;

  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Z;

  if CurrentNode0E.Ref=NextNode0E.Ref then
    Ref0:=CurrentNode0E.Ref
  else begin
    if (CurrentNode0E.Ref.ClassID=_Zone) or
       (CurrentNode0E.Ref.ClassID=_GlobalZone) then begin
      CRef:=CurrentNode0E.Ref;
      VolumeC:=CRef.SpatialElement as IVolume
    end else
    if CurrentNode0E.Ref.ClassID=_CoordNode then begin
      CRef:=CurrentNode0E.Ref.Ref;
      VolumeC:=CRef.SpatialElement as IVolume
    end else
    if CurrentNode0E.Ref.Parent<>nil then begin
      CRef:=CurrentNode0E.Ref;
      VolumeC:=CRef.Parent.SpatialElement as IVolume
    end else begin
      FVisible:=False;
      CRef:=nil;
      Exit;
    end;

    if (NextNode0E.Ref.ClassID=_Zone) or
       (NextNode0E.Ref.ClassID=_GlobalZone) then begin
      NRef:=NextNode0E.Ref;
      VolumeN:=NRef.SpatialElement as IVolume
    end else
    if NextNode0E.Ref.ClassID=_CoordNode then begin
      NRef:=NextNode0E.Ref.Ref;
      VolumeN:=NRef.SpatialElement as IVolume
    end else
    if NextNode0E.Ref.Parent<>nil then begin
      NRef:=NextNode0E.Ref;
      VolumeN:=NRef.Parent.SpatialElement as IVolume
    end else begin
      FVisible:=False;
      NRef:=nil;
      Exit;
    end;

    j:=0;
    while j<VolumeC.Areas.Count do
      if VolumeN.Areas.IndexOf(VolumeC.Areas.Item[j])<>-1 then
        Break
      else
        inc(j);
    if j<VolumeC.Areas.Count then begin
      CN:=CurrentNode0E as ICoordNode;
      DC:=sqr(X0-CN.X)+sqr(Y0-CN.Y)+sqr(Z0-CN.Z);
      NN:=NextNode0E as ICoordNode;
      DN:=sqr(X0-NN.X)+sqr(Y0-NN.Y)+sqr(Z0-NN.Z);
      if DC<=DN then
        Ref0:=CRef
      else
        Ref0:=NRef
    end else begin
      Volume:=(FFacilityModel as ISpatialModel2).GetVolumeContaining(X0, Y0, Z0);
      if Volume<>nil then
        Ref0:=(Volume as IDMElement).Ref
      else begin
        FVisible:=False;
        Exit;
      end;
    end;
  end;

  try
  if (Ref0.ClassID=_Zone)  then begin
    Volume:=Ref0.SpatialElement as IVolume;
    if (Z0>Volume.MaxZ) and
       (Volume.TopAreas.Count>0) then begin
      Area:=Volume.TopAreas.Item[0] as IArea;
      Volume:=Area.Volume0;
      if Volume<>nil then
        Ref0:=(Volume as IDMElement).Ref
      else
        Z0:=Volume.MaxZ;
    end;
  end;
  except
    raise
  end;

  if CurrentNode1E.Ref=NextNode1E.Ref then
    Ref1:=CurrentNode1E.Ref
  else begin
    if (CurrentNode1E.Ref.ClassID=_Zone) or
       (CurrentNode1E.Ref.ClassID=_GlobalZone) then begin
      CRef:=CurrentNode1E.Ref;
      VolumeC:=CRef.SpatialElement as IVolume
    end else
    if CurrentNode1E.Ref.ClassID=_CoordNode then begin
      CRef:=CurrentNode1E.Ref.Ref;
      VolumeC:=CRef.SpatialElement as IVolume
    end else
    if CurrentNode1E.Ref.Parent<>nil then begin
      CRef:=CurrentNode1E.Ref;
      VolumeC:=CurrentNode1E.Ref.Parent.SpatialElement as IVolume
    end else begin
      FVisible:=False;
      CRef:=nil;
      Exit;
    end;

    if (NextNode1E.Ref.ClassID=_Zone) or
       (NextNode1E.Ref.ClassID=_GlobalZone) then begin
      NRef:=NextNode1E.Ref;
      VolumeN:=NRef.SpatialElement as IVolume
    end else
    if NextNode1E.Ref.ClassID=_CoordNode then begin
      NRef:=NextNode1E.Ref.Ref;
      VolumeN:=NRef.SpatialElement as IVolume
    end else
    if NextNode1E.Ref.Parent<>nil then begin
      NRef:=NextNode1E.Ref;
      VolumeN:=NRef.Parent.SpatialElement as IVolume
    end else begin
      FVisible:=False;
      Exit;
    end;

    j:=0;
    while j<VolumeC.Areas.Count do
      if VolumeN.Areas.IndexOf(VolumeC.Areas.Item[j])<>-1 then
        Break
      else
        inc(j);
    if j<VolumeC.Areas.Count then begin
      CN:=CurrentNode1E as ICoordNode;
      DC:=sqr(X1-CN.X)+sqr(Y1-CN.Y)+sqr(Z1-CN.Z);
      NN:=NextNode1E as ICoordNode;
      DN:=sqr(X1-NN.X)+sqr(Y1-NN.Y)+sqr(Z1-NN.Z);
      if DC<=DN then
        Ref1:=CRef
      else
        Ref1:=NRef
    end else begin
      Volume:=(FFacilityModel as ISpatialModel2).GetVolumeContaining(X1, Y1, Z1);
      if Volume<>nil then
        Ref1:=(Volume as IDMElement).Ref
      else begin
        FVisible:=False;
        Exit;
      end;
    end;
  end;

  try
  if (Ref1.ClassID=_Zone) then begin
    Volume:=Ref1.SpatialElement as IVolume;
    if (Z1>Volume.MaxZ) and
       (Volume.TopAreas.Count>0)then begin
      Area:=Volume.TopAreas.Item[0] as IArea;
      if Area.Volume0<>nil then begin
        Volume:=Area.Volume0;
        Ref1:=(Volume as IDMElement).Ref;
      end else
        Z1:=Volume.MaxZ;
    end;
  end;
  except
    raise
  end;

  if not FFacilityModel.FindSeparatingAreas(
                           X0, Y0, Z0,
                           X1, Y1, Z1,
                           Ref0, Ref1,
                           1, FSeparatingAreas, FTransparencyCoeff, nil, nil) then begin
    FFacilityModel.FindSeparatingAreas(
                           X1, Y1, Z1,
                           X0, Y0, Z0,
                           Ref1, Ref0,
                           1, FSeparatingAreas, FTransparencyCoeff, nil, nil);
  end;

  FVisible:=(FTransparencyCoeff<>0);

  if FVisible then begin
    FBattleUnit0.FireLineCount:=FBattleUnit0.FireLineCount+1;
    FBattleUnit1.FireLineCount:=FBattleUnit1.FireLineCount+1;
  end;
end;

procedure TBattleLine.IncFireLineCount;
begin
  if FVisible then begin
    FBattleUnit0.FireLineCount:=FBattleUnit0.FireLineCount+1;
    FBattleUnit1.FireLineCount:=FBattleUnit1.FireLineCount+1;
  end;
end;

class function TBattleLine.GetClassID: integer;
begin
  Result:=_BattleLine
end;


function TBattleLine.Get_FacilityModel: IDMElement;
begin
  Result:=FFacilityModel as IDMElement
end;

function TBattleLine.Get_Threat01: Double;
begin
  Result:=FThreat01
end;

function TBattleLine.Get_Threat10: Double;
begin
  Result:=FThreat10
end;

function TBattleLine.Get_ScoreProbability01: Double;
begin
  Result:=FScoreProbability01
end;

function TBattleLine.Get_ScoreProbability10: Double;
begin
  Result:=FScoreProbability10
end;

function TBattleLine.Get_Visible: WordBool;
begin
  Result:=FVisible
end;

procedure TBattleLine.Draw(const aPainter:IUnknown; DrawSelected:integer);
begin
  if FVisible and
    (FScoreProbability01<>0) and
    (FScoreProbability01<>0) then begin

    if (FScoreProbability01>FScoreProbability10) then
      Color:=clBlue
    else
    if (FScoreProbability01<FScoreProbability10) then
      Color:=clRed
    else
      Color:=clBlack;
    inherited;
  end;
end;

procedure TBattleLine.Initialize;
begin
  inherited;
  FSeparatingAreas:=DataModel.CreateCollection(-1, Self as IDMElement);
end;

procedure TBattleLine.Set_C0(const Value: ICoordNode);
begin
  inherited;
  FBattleUnit0:=Value as IBattleUnit;
end;

procedure TBattleLine.Set_C1(const Value: ICoordNode);
begin
  inherited;
  FBattleUnit1:=Value as IBattleUnit;
end;

procedure TBattleLine.Set_FacilityModel(const Value: IDMElement);
begin
  FFacilityModel:=Value as IFacilityModel 
end;

procedure TBattleLine._Destroy;
begin
  inherited;
  FSeparatingAreas:=nil;
  FBattleUnit0:=nil;
  FBattleUnit1:=nil;
end;

procedure TBattleLine.Set_Visible(Value: WordBool);
begin
  FVisible := Value;
end;

procedure TBattleLine.Set_TransparencyCoeff(Value: Double);
begin
  FTransparencyCoeff := Value;
end;

{ TBattleLines }

function TBattleLines.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsBattleLine
end;

class function TBattleLines.GetElementClass: TDMElementClass;
begin
  Result:=TBattleLine
end;

class function TBattleLines.GetElementGUID: TGUID;
begin
  Result:=IID_IBattleLine
end;

end.
