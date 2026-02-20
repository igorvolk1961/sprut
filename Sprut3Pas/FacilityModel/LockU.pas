unit LockU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DelayElementU;

type
  TLock=class(TDelayElement, ILock)
  private
    FParents:IDMCollection;
    FAccessControl:boolean;
    FKeyLock:boolean;
    FHandLock:boolean;
    FKeyStorage:integer;
    FLockAccessibility:integer;
  protected
    function Get_Parents:IDMCollection; override;
    function DoCalcDelayTime(const OvercomeMethodE:IDMElement):double; override;
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function Get_Name:WideString; override;
    class procedure MakeFields0; override;

    procedure AddParent(const Value:IDMElement); override;
    procedure RemoveParent(const Value:IDMElement); override;
    
    procedure Set_Ref(const Value:IDMElement); override; safecall;
    function Get_AccessControl:WordBool; safecall;
    function Get_KeyLock:WordBool; safecall;
    function Get_HandLock:WordBool; safecall;

//IInsiderTarget
    function Get_ControledByInsider: WordBool; safecall;
  public
    procedure Initialize; override;

  end;

  TLocks=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  CalcDelayTimeLib;

var
  FFields:IDMCollection;

{ TLock }

procedure TLock.Initialize;
begin
  inherited;
  FParents:=DataModel.CreateCollection(-1, Self as IDMElement);
end;

function TLock.DoCalcDelayTime(const OvercomeMethodE:IDMElement): double;
var
  AdversaryGroup:IAdversaryGroup;
  LockKind:ILockKind;
  OvercomeMethod:IOvercomeMethod;
  WarriorGroupE:IDMElement;
  FacilityModelS:IFMState;
begin
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  Result:=0;
  if OvercomeMethod=nil then Exit;

  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  case OvercomeMethod.DelayProcCode of
  dpcEc:
    Result:=CalcDelayTimeByEc(WarriorGroupE,
                      OvercomeMethod, (Ref as ILockKind).ForceEc);
  dpcCriminalEc:
    Result:=CalcDelayTimeByEc(WarriorGroupE,
                      OvercomeMethod, (Ref as ILockKind).CriminalEc);
  dpcUseKey:
    begin
      LockKind:=Ref as ILockKind;
      if WarriorGroupE.ClassID=_AdversaryGroup then begin
        AdversaryGroup:=WarriorGroupE as IAdversaryGroup;
        if AdversaryGroup.Locks.IndexOf(Self as IDMElement)<>-1 then
          Result:=LockKind.OpeningTime
        else
          Result:=InfinitValue/1000
      end else begin
        Result:=LockKind.OpeningTime
      end;
    end;
   dpcCodeMatrix:
     begin
       Result:=inherited DoCalcDelayTime(OvercomeMethodE);
       if (Ref.Parent as IModelElementType).TypeID<100 then
         Result:=Result*60;
     end;
  else
    Result:=inherited DoCalcDelayTime(OvercomeMethodE);
  end;
end;

function TLock.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

class function TLock.GetClassID: integer;
begin
  Result:=_Lock;
end;

function TLock.Get_AccessControl: WordBool;
begin
  Result:=FAccessControl
end;

class function TLock.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TLock.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsLockAccessControl, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(lpAccessControl), 0, pkInput);
  S:='|'+rsKeyInControledRoom+
     '|'+rsKeyAtPerson+
     '|'+rsKeyInDefendedRoom;
  AddField(rsKeyStorage, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(lpKeyStorage), 0, pkInput);
  S:='|'+rsOuterLockAccessibility+
     '|'+rsInnerLockAccessibility+
     '|'+rsOuterInnerLockAccessibility+
     '|'+rsNoLockAccessibility;
  AddField(rsLockAccessibility, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(lpLockAccessibility), 0, pkInput);
end;

function TLock.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(lpAccessControl):
    Result:=FAccessControl;
  ord(lpKeyStorage):
    Result:=FKeyStorage;
  ord(lpLockAccessibility):
    Result:=FLockAccessibility;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TLock.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(lpAccessControl):
    FAccessControl:=Value;
  ord(lpKeyStorage):
    FKeyStorage:=Value;
  ord(lpLockAccessibility):
    FLockAccessibility:=Value;
  else
    inherited;
  end;
end;

procedure TLock.Set_Ref(const Value: IDMElement);
begin
  inherited;
  if Value=nil then Exit;
  FAccessControl:=(Value as ILockKind).AccessControl
end;

function TLock.Get_Name: WideString;
begin
  Result:=inherited Get_Name;
  if Parent=nil then Exit;
  if Parent.Parent=nil then Exit;
  Result:=Result+'/'+Parent.Parent.Name;
end;

function TLock.Get_HandLock: WordBool;
begin
  Result:=FHandLock
end;

function TLock.Get_KeyLock: WordBool;
begin
  Result:=FKeyLock
end;

function TLock.Get_ControledByInsider: WordBool;
var
  FacilityModelS:IFMState;
  AnalysisVariant:IAnalysisVariant;
  AdversaryVariant:IAdversaryVariant;
begin
  FacilityModelS:=DataModel as IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  AdversaryVariant:=AnalysisVariant.AdversaryVariant as IAdversaryVariant;
  Result:=(AdversaryVariant.Locks.IndexOf(Self as IDMElement)<>-1)
end;

procedure TLock.AddParent(const Value: IDMElement);
var
  AdversaryVariant:IAdversaryVariant;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IAdversaryVariant,AdversaryVariant)=0)  then
    AddParent(AdversaryVariant.AdversaryGroups.Item[0])
  else
    inherited;
end;

procedure TLock.RemoveParent(const Value: IDMElement);
var
  AdversaryVariant:IAdversaryVariant;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IAdversaryVariant,AdversaryVariant)=0)  then
    RemoveParent(AdversaryVariant.AdversaryGroups.Item[0])
  else
    inherited;
end;

{ TLocks }

class function TLocks.GetElementClass: TDMElementClass;
begin
  Result:=TLock;
end;

function TLocks.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsLock;
end;

class function TLocks.GetElementGUID: TGUID;
begin
  Result:=IID_ILock;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TLock.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
