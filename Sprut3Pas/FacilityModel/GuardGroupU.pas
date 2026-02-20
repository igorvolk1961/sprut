unit GuardGroupU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  WarriorGroupU;

type
  TGuardGroup=class(TWarriorGroup, IGuardGroup, IGuardGroup2)
  private
    FParamReferences:IDMCollection;

    FDelayedArrivalTime:double;
    FStartDelay:double;
    FStartCondition: Integer;
    FPursuitKind: Integer;
    FAltFinishPoint: Variant;
    FTimeLimit:double;
    FLastNode:IDMELement;
    FUserDefinedArrivalTime: boolean;
    FUserDefinedBattleResult: boolean;
    FDefenceBattleP: Double;
    FAttackBattleP: Double;
    FDefenceBattleT: Double;
    FAttackBattleT: Double;

  protected
    FStates:IDMCollection;

    procedure _AddBackRef(const aValue:IDMElement); override; safecall;
    procedure _RemoveBackRef(const aValue:IDMElement); override; safecall;

    procedure Set_Parent(const aValue:IDMElement); override; safecall;
    function  Get_MainParent:IDMElement; override;

    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function Get_FieldName(Code: integer): WideString; override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;

    class function GetClassID:integer; override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
    
    function Get_ParamReferences:IDMCollection;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;

    function  Get_StartDelay: double; safecall;
    procedure Set_StartDelay(Value: double); safecall;
    function Get_StartCondition: Integer; safecall;
    function Get_PursuitKind: Integer; safecall;
    function Get_AltFinishPoint: IDMElement; safecall;
    function GetAccessTypeToZone(const ZoneE:IDMElement;
                                 InCurrentState:WordBool):integer; override; safecall;
    function  Get_DelayedArrivalTime:double; safecall;
    procedure Set_DelayedArrivalTime(Value:double); safecall;

    function Get_UserDefinedArrivalTime: WordBool; safecall;
    function Get_ArrivalTime: Double; override; safecall;
    function Get_UserDefinedBattleResult: WordBool; safecall;
    function Get_DefenceBattleP: Double; safecall;
    procedure Set_DefenceBattleP(Value: Double); safecall;
    function Get_AttackBattleP: Double; safecall;
    procedure Set_AttackBattleP(Value: Double); safecall;
    function Get_DefenceBattleT: Double; safecall;
    procedure Set_DefenceBattleT(Value: Double); safecall;
    function Get_AttackBattleT: Double; safecall;
    procedure Set_AttackBattleT(Value: Double); safecall;

// IGuardGroup2

    function  Get_TimeLimit:double; safecall;
    procedure Set_TimeLimit(Value:double); safecall;
    function  Get_LastNode:IDMELement; safecall;
    procedure Set_LastNode(const Value:IDMELement); safecall;


    function  GetCurrentState:IGuardGroupState;

    procedure Initialize; override;
    procedure _Destroy; override;

  end;

  TGuardGroups=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation
uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TGuardGroup }


class function TGuardGroup.GetClassID: integer;
begin
  Result:=_GuardGroup;
end;

function TGuardGroup.Get_ParamReferences: IDMCollection;
begin
  Result:=FParamReferences;
end;

procedure TGuardGroup.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(wapStartPoint):
    theCollection:=(DataModel as IFacilityModel).GuardPosts;
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

procedure TGuardGroup._AddBackRef(const aValue: IDMElement);
var
  GuardPost:IGuardPost;
  GuardPostE:IDMElement;
begin
  if aValue.QueryInterface(IGuardPost, GuardPost)=0 then begin
    GuardPostE:=GuardPost as IDMElement;
    if GuardPostE=Get_StartPoint then Exit;
    Set_StartPoint(GuardPostE);
  end else
    inherited;
end;

procedure TGuardGroup._RemoveBackRef(const aValue: IDMElement);
var
  GuardPost:IGuardPost;
  GuardPostE:IDMElement;
begin
  if aValue.QueryInterface(IGuardPost, GuardPost)=0 then begin
    inherited;
    GuardPostE:=GuardPost as IDMElement;
    if GuardPostE=Get_StartPoint then Exit;
    Set_StartPoint(nil);
  end;
end;

function TGuardGroup.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(gpStartDelay):
    Result:=FStartDelay;
  ord(gpStartCondition):
    Result:=FStartCondition;
  ord(gpPursuitKind):
    Result:=FPursuitKind;
  ord(gpUserDefinedArrivalTime):
    Result:=FUserDefinedArrivalTime;
  ord(gpArrivalTime):
    Result:=FArrivalTime;
  ord(gpUserDefinedBattleResult):
    Result:=FUserDefinedBattleResult;
  ord(gpDefenceBattleP):
    Result:=FDefenceBattleP;
  ord(gpAttackBattleP):
    Result:=FAttackBattleP;
  ord(gpDefenceBattleT):
    Result:=FDefenceBattleT;
  ord(gpAttackBattleT):
    Result:=FAttackBattleT
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TGuardGroup.SetFieldValue(Code: integer; Value: OleVariant);
  procedure UpdateUserDefinedElements;
  var
    j:integer;
    FacilityModel:IFacilityModel;
    UserDefinedElements:IDMCollection;
    UserDefinedElements2:IDMCollection2;
    Document:IDMDocument;
  begin
      FacilityModel:=DataModel as IFacilityModel;
      UserDefinedElements:=FacilityModel.UserDefinedElements;
      UserDefinedElements2:=UserDefinedElements as IDMCollection2;
      j:=UserDefinedElements.IndexOf(Self as IDMElement);
      if Value then begin
        if j=-1 then
          UserDefinedElements2.Add(Self as IDMElement);
      end else begin
        if j<>-1 then
          UserDefinedElements2.Remove(Self as IDMElement);
      end;
     if not DataModel.IsLoading and
        not DataModel.IsCopying then begin
       Document:=DataModel.Document as IDMDocument;
       if Document.Server<>nil then
         (Document.Server as IDataModelServer).RefreshElement(Self as IUnknown);
     end;
  end;
begin
  case Code of
  ord(gpStartDelay):
    FStartDelay:=Value ;
  ord(gpStartCondition):
    FStartCondition:=Value;
  ord(gpPursuitKind):
    FPursuitKind:=Value;
  ord(gpUserDefinedArrivalTime):
    begin
      FUserDefinedArrivalTime:=Value;
      UpdateUserDefinedElements;
    end;
  ord(gpArrivalTime):
    FArrivalTime:=Value;
  ord(gpUserDefinedBattleResult):
    begin
      FUserDefinedBattleResult:=Value;
      UpdateUserDefinedElements;
    end;
  ord(gpDefenceBattleP):
    FDefenceBattleP:=Value;
  ord(gpAttackBattleP):
    FAttackBattleP:=Value;
  ord(gpDefenceBattleT):
    FDefenceBattleT:=Value;
  ord(gpAttackBattleT):
    FAttackBattleT:=Value;
  else
    inherited;
  end;
end;

class function TGuardGroup.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TGuardGroup.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:=
//    '|'+rsTakePosition+
    '|'+rsInterruptOnDetectionPoint+
    '|'+rsPatrol+
    '|'+rsStayOnPost+
    '|'+rsInterruptOnTarget+
    '|'+rsInterruptOnExit;
  AddField(rsTask, S, '', '',
//                 fvtChoice, 4, 0, 0,
                 fvtChoice, 4, 1, 5,
                 ord(gpTask), 0, pkInput);
  AddField(rsStartDelay, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gpStartDelay), 0, pkInput);
  S:=
    '|'+rsAlarm+
    '|'+rsGoalDefiningPointPassed+
    '|'+rsIntrusionProved;
//    '|'+rsArmedIntrusionProved;
  AddField(rsStartCondition, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(gpStartCondition), 0, pkInput);
  S:=
    '|'+rsNever+
    '|'+rsAlways+
    '|'+rsUntilGoalDefiningPoint;
//    '|'+rsUntilObstacleAndStay;
//    '|'+rsUntilObstacleAndTurn;
  AddField(rsPursuitKind, S, '', '',
                 fvtChoice, 1, 0, 0,
                 ord(gpPursuitKind), 0, pkInput);
                 
  AddField(rsUserDefinedArrivalTime1, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(gpUserDefinedArrivalTime), 0, pkUserDefined);
  AddField(rsArrivalTime, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gpArrivalTime), 2, pkUserDefined);
  AddField(rsUserDefinedBattleResult, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(gpUserDefinedBattleResult), 0, pkUserDefined);
  AddField(rsDefenceBattleP, '%0.2f', '', '',
                 fvtFloat, 1, 0, 1,
                 ord(gpDefenceBattleP), 0, pkUserDefined);
  AddField(rsAttackBattleP, '%0.2f', '', '',
                 fvtFloat, 1, 0, 1,
                 ord(gpAttackBattleP), 0, pkUserDefined);
  AddField(rsDefenceBattleT, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gpDefenceBattleT), 0, pkUserDefined);
  AddField(rsAttackBattleT, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gpAttackBattleT), 0, pkUserDefined);
end;

function TGuardGroup.Get_StartDelay: double;
begin
  Result:=FStartDelay
end;

procedure TGuardGroup.Set_StartDelay(Value: double);
begin
  FStartDelay:=Value
end;

function TGuardGroup.Get_AltFinishPoint: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FAltFinishPoint;
  Result:=Unk as IDMElement
end;

function TGuardGroup.Get_PursuitKind: Integer;
begin
  Result:=FPursuitKind
end;

function TGuardGroup.Get_StartCondition: Integer;
begin
  Result:=FStartCondition
end;

procedure TGuardGroup.Set_Parent(const aValue: IDMElement);
var
  GuardVariantE, SelfE:IDMElement;
  GuardVariant:IGuardVariant;
  GuardVariants:IDMCollection;
  DMOperationManager:IDMOperationManager;
begin
  if (aValue=nil) or
     (aValue.QueryInterface(IGuardVariant, GuardVariant)=0) then
    inherited
  else begin
    GuardVariants:=(DataModel as IDMElement).Collection[_GuardVariant];
    if GuardVariants.Count=0 then Exit;
    GuardVariantE:=GuardVariants.Item[0];
    Set_Parent(GuardVariantE);
    SelfE:=Self as IDMElement;
    DMOperationManager:=DataModel.Document as IDMOperationManager;
    DMOperationManager.ChangeFieldValue(SelfE, ord(gpStartPoint), True, aValue);
  end;
end;

function TGuardGroup.Get_MainParent: IDMElement;
var
  GuardPost:IGuardPost;
begin
  GuardPost:=Get_StartPoint as IGuardPost;
  if GuardPost<>nil then
    Result:=GuardPost as IDMElement
  else
    Result:=inherited Get_MainParent
end;

function TGuardGroup.Get_FieldName(Code: integer): WideString;
var
  Field:IDMField;
begin
  Field:=Get_Field_(Code);
  case Field.Code of
  ord(gpStartPoint):
    Result:=rsDisposition;
  ord(gpStartDelay):
    begin
      case Get_Task of
      gtStayOnPost:
        Result:=rsTakeDefencePositionTime;
      else
        Result:=inherited Get_FieldName(Code)
      end;
    end;
  else
    Result:=inherited Get_FieldName(Code)
  end;
end;

function TGuardGroup.GetAccessTypeToZone(const ZoneE: IDMElement;
  InCurrentState: WordBool): integer;
begin
  if FAccesses.Count<>0 then
    Result:=inherited GetAccessTypeToZone(ZoneE, InCurrentState)
  else
    Result:=1
end;

procedure TGuardGroup._Destroy;
begin
  inherited;
  FLastNode:=nil;
  FStates:=nil;
end;

function TGuardGroup.Get_LastNode: IDMELement;
begin
  Result:=FLastNode
end;

function TGuardGroup.Get_TimeLimit: double;
begin
  Result:=FTimeLimit
end;

procedure TGuardGroup.Set_LastNode(const Value: IDMELement);
begin
  FLastNode:=Value
end;

procedure TGuardGroup.Set_TimeLimit(Value: double);
begin
  FTimeLimit:=Value
end;

function TGuardGroup.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(gpStartCondition):
    case Get_Task of
    gtTakePosition:                  Result:=True;
    gtInterruptOnDetectionPoint:     Result:=False;
    gtPatrol:                        Result:=False;
    gtStayOnPost:                    Result:=False;
    gtInterruptOnTarget:             Result:=True;
    gtInterruptOnExit:               Result:=True;
    else
      Result:=True;
    end;
  ord(gpPursuitKind):
    case Get_Task of
    gtInterruptOnDetectionPoint:Result:=True;
    else
      Result:=False;
    end;
  ord(gpArrivalTime):
    Result:=FUserDefinedArrivalTime;
  ord(gpDefenceBattleP),
  ord(gpAttackBattleP),
  ord(gpDefenceBattleT),
  ord(gpAttackBattleT):
    Result:=FUserDefinedBattleResult;
  else
    Result:=inherited FieldIsVisible(Code);
  end;
end;

function TGuardGroup.Get_DelayedArrivalTime: double;
begin
  Result:=FDelayedArrivalTime
end;

procedure TGuardGroup.Set_DelayedArrivalTime(Value: double);
begin
  FDelayedArrivalTime:=Value
end;

function TGuardGroup.Get_AttackBattleP: Double;
var
  State:IGuardGroupState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.AttackBattleP
  else
    Result:=FAttackBattleP
end;

function TGuardGroup.Get_AttackBattleT: Double;
var
  State:IGuardGroupState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.AttackBattleT
  else
    Result:=FAttackBattleT
end;

function TGuardGroup.Get_DefenceBattleP: Double;
var
  State:IGuardGroupState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.DefenceBattleP
  else
    Result:=FDefenceBattleP
end;

function TGuardGroup.Get_DefenceBattleT: Double;
var
  State:IGuardGroupState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.DefenceBattleT
  else
    Result:=FDefenceBattleT
end;

function TGuardGroup.Get_UserDefinedArrivalTime: WordBool;
begin
  Result:=FUserDefinedArrivalTime
end;

function TGuardGroup.Get_UserDefinedBattleResult: WordBool;
begin
  Result:=FUserDefinedBattleResult
end;

procedure TGuardGroup.Set_AttackBattleP(Value: Double);
begin
  FAttackBattleP:=Value
end;

procedure TGuardGroup.Set_AttackBattleT(Value: Double);
begin
  FAttackBattleT:=Value
end;

procedure TGuardGroup.Set_DefenceBattleP(Value: Double);
begin
  FDefenceBattleP:=Value
end;

procedure TGuardGroup.Set_DefenceBattleT(Value: Double);
begin
  FDefenceBattleT:=Value
end;

procedure TGuardGroup.Initialize;
begin
  inherited;
  FStates:=DataModel.CreateCollection(_GuardGroupState, Self as IDMElement);
end;

function TGuardGroup.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  ord(gcStates):
    Result:=FStates;
  else
    Result:=inherited Get_Collection(Index)
  end;  
end;

function TGuardGroup.Get_CollectionCount: integer;
begin
  Result:=ord(high(TGuardCategory))+1
end;

procedure TGuardGroup.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;
  case Index of
  ord(gcStates):
    begin
        aCollectionName:=rsElementStates;
        if DataModel<>nil then
          aRefSource:=(DataModel as IFacilityModel).FacilitySubStates
        else
          aRefSource:=nil;
        aClassCollections:=nil;
        aOperations:=leoAdd or leoSelectRef;
        aLinkType:=ltOneToMany;
    end;
  end;
end;

procedure TGuardGroup.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  aCollection2:=aCollection as IDMCollection2;
  SourceCollection:=(DataModel as IFacilityModel).FacilitySubStates;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do
    aCollection2.Add(SourceCollection.Item[j]);
end;

function TGuardGroup.Get_ArrivalTime: Double;
var
  State:IGuardGroupState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.ArrivalTime
  else
    Result:=FArrivalTime
end;

function TGuardGroup.GetCurrentState: IGuardGroupState;
var
  j, m:integer;
  FacilityState:IFacilityState;
  SubStateE:IDMElement;
begin
  Result:=nil;
  if FStates.Count=0 then Exit;
  FacilityState:=DataModel.CurrentState as IFacilityState;
  if FacilityState=nil then Exit;
  j:=FacilityState.SubStateCount-1;
  m:=-1;
  while j>=0 do begin
    SubStateE:=FacilityState.SubState[j];
    m:=0;
    while m<FStates.Count do
      if FStates.Item[m].Ref=SubStateE then
        Break
      else
        inc(m);
    if m<FStates.Count then
      Break
    else
      dec(j);
  end;
  if j>=0 then
    Result:=FStates.Item[m] as IGuardGroupState
end;

{ TGuardGroups }

class function TGuardGroups.GetElementClass: TDMElementClass;
begin
  Result:=TGuardGroup;
end;

function TGuardGroups.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsGuardGroup
  else
    Result:=rsGuardGroups;
end;

class function TGuardGroups.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardGroup;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TGuardGroup.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
