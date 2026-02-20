unit TargetU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomTargetU;

type
  TTarget=class(TCustomTarget, ITarget)
  private
    FMass: Double;
    FMaxSize: Double;
    FMinSize: Double;
    FHasMetall: boolean;
    FRadiation: Integer;
    FWarriorGroups:IDMCollection;
    function DoCalcNoDistantDetectionProbability(const TacticE: IDMElement;
      Side: integer; const Zone0E, Zone1E: IDMElement; var aPS,
      aNoFailureP, aNoEvidDetP: double): double;
    function DoCalcNoDistantDetectionProbability0(
      const TacticE: IDMElement; Side: integer; const Zone0E,
      Zone1E: IDMElement; var aPS: double): double;
  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    procedure _AddBackRef(const Value:IDMElement); override;
    procedure _RemoveBackRef(const Value:IDMElement); override;
    procedure Set_Parent(const Value:IDMElement); override; safecall;

    procedure CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                            out BestTacticE:IDMElement; AddDelay:double); override;

    function  Get_Mass: Double; safecall;
    function  Get_MaxSize: Double; safecall;
    function  Get_MinSize: Double; safecall;
    function  Get_HasMetall: WordBool; safecall;
    function  Get_Radiation: Integer; safecall;

    procedure Set_Ref(const Value: IDMElement); override; safecall;

    procedure CalcExternalDelayTime(out dT, dTDisp: double; out BestTacticE:IDMElement); override;

    procedure CalcNoDetectionProbability(
                           out NoDetP, NoFailureP:double;
                           out NoEvidDetP:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                           out BestTacticE:IDMElement; AddDelay:double); override;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TTargets=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  CalcDetectionProbabilityLib;

var
  FFields:IDMCollection;

{ TTarget }

class function TTarget.GetClassID: integer;
begin
  Result:=_Target;
end;

class function TTarget.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TTarget.Get_MaxSize: Double;
begin
  Result:=FMaxSize
end;

function TTarget.Get_Mass: Double;
begin
  Result:=FMass
end;

function TTarget.Get_HasMetall: WordBool;
begin
  Result:=FHasMetall
end;

function TTarget.Get_Radiation: Integer;
begin
  Result:=FRadiation
end;

function TTarget.Get_MinSize: Double;
begin
  Result:=FMinSize
end;

class procedure TTarget.MakeFields0;
begin
  inherited;
  AddField(rsMass, '%0.3f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(tpMass), 0, pkInput);
  AddField(rsMaxSize, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(tpMaxSize), 0, pkInput);
  AddField(rsMinSize, '%0.3f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(tpMinSize), 0, pkInput);
  AddField(rsHasMetall, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tpHasMetall), 0, pkInput);
  AddField(rsRadiation, '|Нет излучения|Гамма-излучение|Нейтронное излучение|Гамма-нейтронное излучение', '', 'R',
                 fvtChoice, 0, 0, 0,
                 ord(tpRadiation), 0, pkInput);
end;

function TTarget.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(tpMass):
    Result:=FMass;
  ord(tpMaxSize):
    Result:=FMaxSize;
  ord(tpMinSize):
    Result:=FMinSize;
  ord(tpHasMetall):
    Result:=FMass;
  ord(tpRadiation):
    Result:=FRadiation;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TTarget.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(tpMass):
    FMass:=Value;
  ord(tpMaxSize):
    FMaxSize:=Value;
  ord(tpMinSize):
    FMinSize:=Value;
  ord(tpHasMetall):
    FMass:=Value;
  ord(tpRadiation):
    FRadiation:=Value;
  else
    inherited;
  end;
end;

procedure TTarget.Set_Ref(const Value: IDMElement);
var
  FacilityModel:IFacilityModel;
  j:integer;
  AdversaryGroupW:IWarriorGroup;
  AdversaryGroup:IAdversaryGroup;
  TargetKind:ITargetKind;
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if Value=nil then Exit;
  TargetKind:=Value as ITargetKind;
  FacilityModel:=DataModel as IFacilityModel;
  for j:=0 to FacilityModel.AdversaryGroups.Count-1 do begin
    AdversaryGroupW:=FacilityModel.AdversaryGroups.Item[j] as IWarriorGroup;
    AdversaryGroup:=AdversaryGroupW as IAdversaryGroup;
    case AdversaryGroupW.Task of
    0:if AdversaryGroupW.FinishPoint=nil then
        AdversaryGroupW.FinishPoint:=Self as IDMElement;
    1:if AdversaryGroupW.FinishPoint=nil then
        AdversaryGroupW.FinishPoint:=Self as IDMElement;
    end;
  end;
end;

procedure TTarget._Destroy;
begin
  inherited;
  FWarriorGroups:=nil;
end;

procedure TTarget.Initialize;
begin
  inherited;
  FWarriorGroups:=DataModel.CreateCollection(-1, Self as IDMElement);
end;

function TTarget.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(tpUserDefinedDelayTime):
    Result:=False;
  ord(tpUserDefinedDetectionProbability):
    Result:=False;
  ord(bopFlowIntencity):
    Result:=False;
  ord(tpMass),
  ord(tpMaxSize),
  ord(tpMinSize),
  ord(tpHasMetall),
  ord(tpRadiation):
    Result:=(Ref.Parent.ID=btEntryPoint);
  else
    Result:=inherited FieldIsVisible(Code);
  end;
end;

procedure TTarget._AddBackRef(const Value: IDMElement);
var
  WarriorGroup:IWarriorGroup;
begin
  if Value.DataModel<>DataModel then Exit;
  if Value.Parent=nil then Exit;
  
  inherited;

  if Value.QueryInterface(IWarriorGroup, WarriorGroup)=0 then begin
    if FWarriorGroups.IndexOf(Value)=-1 then
      (FWarriorGroups as IDMCollection2).Add (Value);
  end;
end;

procedure TTarget._RemoveBackRef(const Value: IDMElement);
var
  GuardGroup:IWarriorGroup;
  j:integer;
begin
  if Value.DataModel<>DataModel then Exit;
  if Value.Parent=nil then Exit;

  if Value.QueryInterface(IWarriorGroup, GuardGroup)=0 then begin
    inherited;
    j:=FWarriorGroups.IndexOf(Value);
    if j<>-1 then
      (FWarriorGroups as IDMCollection2).Delete(j);
  end;
end;

procedure TTarget.Set_Parent(const Value: IDMElement);
var
  WarriorGroup:IWarriorGroup;
  j:integer;
  OldParent:IDMElement;
begin
  OldParent:=Parent;
  inherited;
  if OldParent=Value then Exit;
  if Value=nil then begin
    for j:=0 to FWarriorGroups.Count-1 do begin
      WarriorGroup:=FWarriorGroups.Item[j] as IWarriorGroup;
      if WarriorGroup.FinishPoint=(Self as IDMElement) then
        WarriorGroup.FinishPoint:=nil;
    end;
  end;
end;

procedure TTarget.CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                                out BestTacticE:IDMElement; AddDelay:double);
var
  AdversaryGroup:IAdversaryGroup;
  FacilityModelS:IFMState;
  WarriorGroupE:IDMElement;
begin
  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  if  WarriorGroupE.QueryInterface(IAdversaryGroup, AdversaryGroup)=0 then begin
    if not AdversaryGroup.TargetAccessRequired then begin
      FacilityModelS.DelayFlag:=False;
      inherited;
      FacilityModelS.DelayFlag:=True;
    end else
      inherited;
  end else begin
    DelayTime:=0;
    DelayTimeDispersion:=0;
    BestTacticE:=nil;
  end;
end;

procedure TTarget.CalcNoDetectionProbability(
                           out NoDetP, NoFailureP:double;
                           out NoEvidDetP:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                           out BestTacticE:IDMElement; AddDelay:double);
var
  AdversaryGroup:IAdversaryGroup;
  FacilityModelS:IFMState;
  WarriorGroupE:IDMElement;
begin
  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  if  WarriorGroupE.QueryInterface(IAdversaryGroup, AdversaryGroup)=0 then begin
    if not AdversaryGroup.TargetAccessRequired then begin
      FacilityModelS.DelayFlag:=False;
      inherited;
      FacilityModelS.DelayFlag:=True;
    end else
      inherited;
  end;
end;

procedure TTarget.CalcExternalDelayTime(out dT, dTDisp: double;
  out BestTacticE:IDMElement);
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  DelayTimeDispersionRatio:double;
  AdversaryGroup:IAdversaryGroup;
begin
  FacilityModelS:=DataModel as IFMState;

  dT:=0;
  dTDisp:=0;
  if  FacilityModelS.CurrentWarriorGroupU.QueryInterface(IAdversaryGroup, AdversaryGroup)=0 then begin
    case  FacilityModelS.CurrentPathStage of
    wpsStealthEntry,
    wpsFastEntry:
      begin
        if AdversaryGroup.UserDefinedTargetDelayDispersionRatio then
          DelayTimeDispersionRatio:=AdversaryGroup.TargetDelayDispersionRatio
        else begin
          FacilityModel:=DataModel as IFacilityModel;
          DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;
        end;
        dT:=AdversaryGroup.TargetDelayTime;
        dTDisp:=sqr(DelayTimeDispersionRatio*dT);
      end;
    end;
  end;
end;

function TTarget.DoCalcNoDistantDetectionProbability(
      const TacticE:IDMElement;
      Side: integer;
      const Zone0E, Zone1E:IDMElement;
      var aPS, aNoFailureP, aNoEvidDetP: double): double;
var
  WarriorGroupE:IDMElement;

  function CalcNoDistantDetection(const SafeguardElements:IDMCollection; aTime:double):double;
  var
    m:integer;
    SafeguardElement:ISafeguardElement;
//    DetP:double;
  begin
    Result:=1;
    for m:=0 to SafeguardElements.Count-1 do begin
      SafeguardElement:=SafeguardElements.Item[m].Ref as ISafeguardElement;
//      SafeguardElement.CalcDetectionProbability(TacticE, aTime, DetP, BestTime);
//      Result:=Result*(1-DetP);
    end;
  end;

  function CalcNoPatrolDetection(const ZoneE:IDMElement;
                       aTime:double):double; safecall;
  var
    PatrolPeriod:double;
    Zone:IZone;
  begin
      if ZoneE=nil then Exit;
      Zone:=ZoneE as IZone;
      PatrolPeriod:=(Zone as IFacilityElement).PatrolPeriod;
      if PatrolPeriod=InfinitValue then Exit;
      if PatrolPeriod=0 then Exit;
      Result:=exp(-aTime/PatrolPeriod);

  end;

var
  AdversaryGroup:IAdversaryGroup;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  DetPf, DetPg, DetPtv, DetPptr, FieldValue, T, NoDetP0:double;
  ZoneE:IDMElement;
  Zone:IZone;
begin
  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  Result:=1;
  aPS:=0;
  aNoFailureP:=1;
  aNoEvidDetP:=1;

  if Side<>0 then Exit;

  DetPf:=0;
  DetPg:=0;
  DetPtv:=0;
  DetPptr:=0;

  if  WarriorGroupE.QueryInterface(IAdversaryGroup, AdversaryGroup)=0 then begin
    case  FacilityModelS.CurrentPathStage of
    wpsStealthEntry,
    wpsFastEntry:
      begin
        FacilityModel:=DataModel as IFacilityModel;
        T:=AdversaryGroup.TargetDelayTime;

        FieldValue:=AdversaryGroup.TargetFieldValue;
        if (FieldValue<>0) and
           (FacilityModel.GuardPosts.Count>0) then // для рубежа сохранено минимальное ослабление звука
          DetPf:=GetFieldDetectionProbability
                 (nil,  // звук
                  Self as IDMElement,
                  FieldValue, T)
        else
          DetPf:=0;

        ZoneE:=Get_Zone0;
        Zone:=ZoneE as IZone;

        if Zone<>nil then begin
          NoDetP0:=CalcNoDistantDetection(Zone.Observers, T);
          DetPg:=1-NoDetP0;

          NoDetP0:=CalcNoPatrolDetection(ZoneE, T);
          DetPptr:=1-NoDetP0;
        end;
      end;
    end;

    Result:=Result*(1-DetPf)*(1-DetPg)*(1-DetPtv)*(1-DetPptr);
  end;
end;

function TTarget.DoCalcNoDistantDetectionProbability0(
      const TacticE:IDMElement;
      Side: integer;
      const Zone0E, Zone1E:IDMElement;
      var aPS: double): double;
var
  WarriorGroupE:IDMElement;

  function CalcNoDistantDetection(const SafeguardElements:IDMCollection; aTime:double):double;
  var
    m:integer;
    SafeguardElement:ISafeguardElement;
//    DetP, BestTime:double;
  begin
    Result:=1;
    for m:=0 to SafeguardElements.Count-1 do begin
      SafeguardElement:=SafeguardElements.Item[m].Ref as ISafeguardElement;
//      SafeguardElement.CalcDetectionProbability(TacticE, aTime, DetP, BestTime);
//      Result:=Result*(1-DetP);
    end;
  end;

  function CalcNoPatrolDetection(const ZoneE:IDMElement;
                       aTime:double):double; safecall;
  var
    PatrolPeriod:double;
    Zone:IZone;
  begin
      if ZoneE=nil then Exit;
      Zone:=ZoneE as IZone;
      PatrolPeriod:=(Zone as IFacilityElement).PatrolPeriod;
      if PatrolPeriod=InfinitValue then Exit;
      if PatrolPeriod=0 then Exit;
      Result:=exp(-aTime/PatrolPeriod);

  end;

var
  AdversaryGroup:IAdversaryGroup;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  DetPf, DetPg, DetPtv, DetPptr, FieldValue, T, NoDetP0:double;
  ZoneE:IDMElement;
  Zone:IZone;
begin
  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  Result:=1;
//  BestPS:=0;
  aPS:=0;

  if Side<>0 then Exit;

  DetPf:=0;
  DetPg:=0;
  DetPtv:=0;
  DetPptr:=0;

  if  WarriorGroupE.QueryInterface(IAdversaryGroup, AdversaryGroup)=0 then begin
    case  FacilityModelS.CurrentPathStage of
    wpsStealthEntry,
    wpsFastEntry:
      begin
        FacilityModel:=DataModel as IFacilityModel;
        T:=AdversaryGroup.TargetDelayTime;

        FieldValue:=AdversaryGroup.TargetFieldValue;
        if (FieldValue<>0) and
           (FacilityModel.GuardPosts.Count>0) then // для рубежа сохранено минимальное ослабление звука
          DetPf:=GetFieldDetectionProbability
                 (nil,  // звук
                  Self as IDMElement,
                  FieldValue, T)
        else
          DetPf:=0;

        ZoneE:=Get_Zone0;
        Zone:=ZoneE as IZone;

        NoDetP0:=CalcNoDistantDetection(Zone.Observers, T);
        DetPg:=1-NoDetP0;

        NoDetP0:=CalcNoPatrolDetection(ZoneE, T);
        DetPptr:=1-NoDetP0;
      end;
    end;

    Result:=(1-DetPf)*(1-DetPg)*(1-DetPtv)*(1-DetPptr);
  end;
end;

{ TTargets }

class function TTargets.GetElementClass: TDMElementClass;
begin
  Result:=TTarget;
end;

function TTargets.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsTarget;
end;

class function TTargets.GetElementGUID: TGUID;
begin
  Result:=IID_ITarget;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TTarget.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
