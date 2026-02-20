unit GuardPostKindU;
{Виды постов охраны}
interface
uses
  SecurityElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TGuardPostKind=class(TSecurityElementKind, IGuardPostKind, IObserverKind)
  private
    FDefenceLevel:integer;
    FOpenedDefenceState:integer;
    FHidedDefenceState:integer;
    FObservationMethod:IOvercomeMethod;
    procedure FindObservationMethod;
  protected
    function  GetFieldValue(Index: integer): OleVariant; override;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override;
    class procedure MakeFields0; override;
    class function GetFields:IDMCollection; override;
    class function  GetClassID:integer; override;

    procedure AfterLoading2; override; safecall;

    function Get_DefenceLevel: integer; safecall;
    function Get_OpenedDefenceState: integer; safecall;
    function Get_HidedDefenceState: integer; safecall;

// IObserverKind
    function Get_ObservationMethod: IOvercomeMethod; safecall;

    procedure _Destroy; override;
  end;

  TGuardPostKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TGuardPostKind }

class function TGuardPostKind.GetClassID: integer;
begin
  Result:=_GuardPostKind
end;

class procedure TGuardPostKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsNoWeaponDefence+
     '|'+rsKnifeDefence+
     '|'+rsGunDefence+
     '|'+rsRPGDefence+
     '|'+rsGoodRPGDefence;
  AddField(rsDefenceLevel, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(gpkDefenceLevel), 0, pkInput);
  S:='|'+rsNoDefence+
     '|'+rsRunning+
     '|'+rsHalfHeightDefence+
     '|'+rsChestHeightDefence+
     '|'+rsHeadHeightDefence+
     '|'+rsFullDefence;
  AddField(rsOpenedDefenceState, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(gpkOpenedDefenceState), 0, pkInput);
  AddField(rsHidedDefenceState, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(gpkHidedDefenceState), 0, pkInput);
end;

class function TGuardPostKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TGuardPostKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(gpkDefenceLevel):
    Result:=FDefenceLevel;
  ord(gpkOpenedDefenceState):
    Result:=FOpenedDefenceState;
  ord(gpkHidedDefenceState):
    Result:=FHidedDefenceState;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TGuardPostKind.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(gpkDefenceLevel):
    FDefenceLevel:=Value;
  ord(gpkOpenedDefenceState):
    FOpenedDefenceState:=Value;
  ord(gpkHidedDefenceState):
    FHidedDefenceState:=Value;
  else
    inherited;
  end;
end;

function TGuardPostKind.Get_DefenceLevel: integer;
begin
  Result:=FDefenceLevel
end;

function TGuardPostKind.Get_OpenedDefenceState: integer;
begin
  Result:=FOpenedDefenceState
end;

function TGuardPostKind.Get_HidedDefenceState: integer;
begin
  Result:=FHidedDefenceState
end;

procedure TGuardPostKind.FindObservationMethod;
var
  SafeguardElementType:ISafeguardElementType;
  j:integer;
  OvercomeMethod:IOvercomeMethod;
begin
  SafeguardElementType:=Parent as ISafeguardElementType;
  j:=0;
  OvercomeMethod:=nil;
  while j<SafeguardElementType.OvercomeMethods.Count do begin
    OvercomeMethod:=SafeguardElementType.OvercomeMethods.Item[j] as IOvercomeMethod;
    if OvercomeMethod.ObserverParam then
      Break
    else
      inc(j)
  end;
  if j<SafeguardElementType.OvercomeMethods.Count then
    FObservationMethod:=OvercomeMethod
end;

function TGuardPostKind.Get_ObservationMethod: IOvercomeMethod;
begin
  Result:=FObservationMethod
end;

procedure TGuardPostKind._Destroy;
begin
  inherited;
  FObservationMethod:=nil
end;

procedure TGuardPostKind.AfterLoading2;
begin
  inherited;
  FindObservationMethod
end;

{ TGuardPostKinds }

function TGuardPostKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsGuardPostKind;
end;

class function TGuardPostKinds.GetElementClass: TDMElementClass;
begin
  Result:=TGuardPostKind;
end;

class function TGuardPostKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardPostKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TGuardPostKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
