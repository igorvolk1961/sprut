unit GuardGroupStateU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TGuardGroupState=class(TDMElement, IGuardGroupState)
  private
    FUserDefinedArrivalTime: boolean;
    FArrivalTime: Double;
    FUserDefinedBattleResult: boolean;
    FDefenceBattleP: Double;
    FAttackBattleP: Double;
    FDefenceBattleT: Double;
    FAttackBattleT: Double;
  protected
    class function GetClassID:integer; override;

    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function Get_Name:WideString; override;

    function Get_UserDefinedArrivalTime: WordBool; safecall;
    function Get_ArrivalTime: Double; safecall;
    function Get_UserDefinedBattleResult: WordBool; safecall;
    function Get_DefenceBattleP: Double; safecall;
    procedure Set_DefenceBattleP(Value: Double); safecall;
    function Get_AttackBattleP: Double; safecall;
    procedure Set_AttackBattleP(Value: Double); safecall;
    function Get_DefenceBattleT: Double; safecall;
    procedure Set_DefenceBattleT(Value: Double); safecall;
    function Get_AttackBattleT: Double; safecall;
    procedure Set_AttackBattleT(Value: Double); safecall;
  end;

  TGuardGroupStates=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TGuardGroupState }

function TGuardGroupState.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
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

procedure TGuardGroupState.SetFieldValue(Code:integer; Value:OleVariant);
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

class function TGuardGroupState.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TGuardGroupState.MakeFields0;
begin
  inherited;
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

class function TGuardGroupState.GetClassID: integer;
begin
  Result:=_GuardGroupState
end;

function TGuardGroupState.Get_Name: WideString;
var S:string;
begin
  S:=inherited Get_Name;
  if Parent<>nil then
    Result:=S+' ('+Parent.Name+', '+Ref.Name+')'
end;


function TGuardGroupState.Get_AttackBattleP: Double;
begin
  Result:=FAttackBattleP
end;

function TGuardGroupState.Get_AttackBattleT: Double;
begin
  Result:=FAttackBattleT
end;

function TGuardGroupState.Get_DefenceBattleP: Double;
begin
  Result:=FDefenceBattleP
end;

function TGuardGroupState.Get_DefenceBattleT: Double;
begin
  Result:=FDefenceBattleT
end;

function TGuardGroupState.Get_UserDefinedArrivalTime: WordBool;
begin
  Result:=FUserDefinedArrivalTime
end;

function TGuardGroupState.Get_UserDefinedBattleResult: WordBool;
begin
  Result:=FUserDefinedBattleResult
end;

procedure TGuardGroupState.Set_AttackBattleP(Value: Double);
begin
  FAttackBattleP:=Value
end;

procedure TGuardGroupState.Set_AttackBattleT(Value: Double);
begin
  FAttackBattleT:=Value
end;

procedure TGuardGroupState.Set_DefenceBattleP(Value: Double);
begin
  FDefenceBattleP:=Value
end;

procedure TGuardGroupState.Set_DefenceBattleT(Value: Double);
begin
  FDefenceBattleT:=Value
end;


function TGuardGroupState.Get_ArrivalTime: Double;
begin
  Result:=FArrivalTime
end;

{ TGuardGroupStates }

class function TGuardGroupStates.GetElementClass: TDMElementClass;
begin
  Result:=TGuardGroupState;
end;

function TGuardGroupStates.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsGuardGroupState
  else  
    Result:=rsGuardGroupStates;
end;

class function TGuardGroupStates.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardGroupState;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TGuardGroupState.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
