unit WeaponKindU;

interface
uses
  SysUtils,
  WarriorAttributeKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type

  TWeaponKind=class(TWarriorAttributeKind, IWeaponKind)
  private
    FParents:IDMCollection;

    FShotDispersionRecs:IDMCollection;
    FShotBreachRecs:IDMCollection;

    FMaxShotDistance:double;
    FPreciseShotDistance:double;
    FShotRate:double;
    FMass:double;
    FMaxLength:double;
    FHasMetall:boolean;
    FShotForce:integer;
    FShotCapacity:integer;
    FCartridgeCountPerHit: Integer;
    FGroupDamage:boolean;
    FSoundPower:double;

  protected
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    class function  GetClassID:integer; override;

    function Get_Parents:IDMCollection; override;
    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function Get_Capacity: integer; safecall;
    function Get_ShotRate: double; safecall;
    function Get_HasMetall: WordBool; safecall;
    function Get_Mass: double; safecall;
    function Get_MaxLength: double; safecall;
    function Get_ShotCapacity: integer; safecall;
    function Get_MaxShotDistance: double; safecall;
    function Get_PreciseShotDistance: double; safecall;
    function Get_ShotForce: integer; safecall;
    function Get_CartridgeCountPerHit: Integer; safecall;
    function Get_GroupDamage:WordBool; safecall;
    function Get_SoundPower:double; safecall;
    function Get_ShotBreachRecs:IUnknown; safecall;

    function  GetScoreProbability(Distance: double; State: Integer; AimState: Integer): Double; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TWeaponKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU, ShotDispersionRecU;

var
  FFields:IDMCollection;

{ TWeaponKind }

procedure TWeaponKind.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);
  FShotDispersionRecs:=DataModel.CreateCollection(_ShotDispersionRec, SelfE);
  FShotBreachRecs:=DataModel.CreateCollection(_ShotBreachRec, SelfE);
end;

procedure TWeaponKind._Destroy;
begin
  inherited;
  FShotDispersionRecs:=nil;
  FShotBreachRecs:=nil;
end;

class function TWeaponKind.GetClassID: integer;
begin
  Result:=_WeaponKind
end;


function TWeaponKind.Get_CollectionCount: integer;
begin
  Result:=2;
end;

function TWeaponKind.Get_Capacity: integer;
begin
  Result:=30;
end;

function TWeaponKind.Get_ShotRate: double;
begin
  Result:=FShotRate
end;

function TWeaponKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(wpMaxShotDistance):
    Result:=FMaxShotDistance;
  ord(wpPreciseShotDistance):
    Result:=FPreciseShotDistance;
  ord(wpShotRate):
    Result:=FShotRate;
  ord(wpMass):
    Result:=FMass;
  ord(wpMaxLength):
    Result:=FMaxLength;
  ord(wpHasMetall):
    Result:=FHasMetall;
  ord(wpShotForce):
    Result:=FShotForce;
  ord(wpShotCapacity):
    Result:=FShotCapacity;
  ord(wpCartridgeCountPerHit):
    Result:=FCartridgeCountPerHit;
  ord(wpGroupDamage):
    Result:=FGroupDamage;
  ord(wpIsDefault):
    Result:=FIsDefault;
  ord(wpSoundPower):
    Result:=FSoundPower;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TWeaponKind.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(wpMaxShotDistance):
    FMaxShotDistance:=Value;
  ord(wpPreciseShotDistance):
    FPreciseShotDistance:=Value;
  ord(wpShotRate):
    FShotRate:=Value;
  ord(wpMass):
    FMass:=Value;
  ord(wpMaxLength):
    FMaxLength:=Value;
  ord(wpHasMetall):
    FHasMetall:=Value;
  ord(wpShotForce):
    FShotForce:=Value;
  ord(wpShotCapacity):
    FShotCapacity:=Value;
  ord(wpCartridgeCountPerHit):
    FCartridgeCountPerHit:=Value;
  ord(wpGroupDamage):
    FGroupDamage:=Value;
  ord(wpIsDefault):
    FIsDefault:=Value;
  ord(wpSoundPower):
    FSoundPower:=Value;
  else
    inherited;
  end;
end;

class function TWeaponKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TWeaponKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsMaxShotDistance, '%0.0f', '', '',
             fvtFloat, 0, 0, 0,
             ord(wpMaxShotDistance), 0, pkInput);
  AddField(rsPreciseShotDistance, '%0.0f', '', '',
             fvtFloat, 0, 0, 0,
             ord(wpPreciseShotDistance), 0, pkInput);
  AddField(rsShotRate, '%d', '', '',
             fvtInteger, 0, 0, 0,
             ord(wpShotRate), 0, pkInput);
  AddField(rsMass, '%0.2f', '', '',
             fvtFloat, 0, 0, 0,
             ord(wpMass), 0, pkInput);
  AddField(rsMaxSize, '%0.2f', '', '',
             fvtFloat, 0, 0, 0,
             ord(wpMaxLength), 0, pkInput);
  AddField(rsHasMetall, '', '', '',
             fvtBoolean, 0, 0, 0,
             ord(wpHasMetall), 0, pkInput);
//  S:='|'+rsNoWeaponDefence+
//     '|'+rsKnifeDefence+
//     '|'+rsGunDefence+
//     '|'+rsRPGDefence+
//     '|'+rsGoodRPGDefence;
//  AddField(rsShotForce, S, '', '',
//             fvtChoice, 0, 0, 0,
//             ord(wpShotForce), 0, pkInput);
  AddField(rsShotCapacity, '%d', '', '',
             fvtInteger, 0, 0, 0,
             ord(wpShotCapacity), 0, pkInput);
  AddField(rsCartridgeCountPerHit, '%d', '', '',
             fvtInteger, 1, 0, 0,
             ord(wpCartridgeCountPerHit), 0, pkInput);
  AddField(rsGroupDamage, '', '', '',
             fvtBoolean, 0, 0, 0,
             ord(wpGroupDamage), 0, pkInput);
  AddField(rsIsDefault, '', '', '',
             fvtBoolean, 0, 0, 0,
             ord(wpIsDefault), 0, pkInput);
  AddField(rsSoundPower, '%0.1f', '', '',
             fvtFloat, 0, 0, 0,
             ord(wpSoundPower), 0, pkInput);
end;

function TWeaponKind.Get_HasMetall: WordBool;
begin
  Result:=FHasMetall
end;

function TWeaponKind.Get_Mass: double;
begin
  Result:=FMass
end;

function TWeaponKind.Get_MaxLength: double;
begin
  Result:=FMaxLength
end;

function TWeaponKind.Get_ShotCapacity: integer;
begin
  Result:=FShotCapacity
end;

function TWeaponKind.Get_MaxShotDistance: double;
begin
  Result:=FMaxShotDistance
end;

function TWeaponKind.Get_PreciseShotDistance: double;
begin
  Result:=FPreciseShotDistance
end;

function TWeaponKind.Get_ShotForce: integer;
begin
  Result:=FShotForce
end;

function TWeaponKind.Get_CartridgeCountPerHit: integer;
begin
  Result:=FCartridgeCountPerHit
end;

function TWeaponKind.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
    0: Result:=FShotDispersionRecs;
    1: Result:=FShotBreachRecs;
  end;
end;

procedure TWeaponKind.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:
    begin
      aCollectionName:=FShotDispersionRecs.ClassAlias[akImenitM];
      aOperations:=leoAdd or leoDelete or leoRename;
      aRefSource:=nil;
      aClassCollections:=nil;
      aLinkType:=ltOneToMany;
    end;
  1:
    begin
      aCollectionName:=FShotBreachRecs.ClassAlias[akImenitM];
      aOperations:=leoAdd or leoDelete or leoRename;
      aRefSource:=nil;
      aClassCollections:=nil;
      aLinkType:=ltOneToMany;
    end;
  end;
end;

function  TWeaponKind.GetScoreProbability(Distance: double; State: Integer; AimState: Integer): Double;
var
  ShotDispersionRec0, ShotDispersionRec1:IShotDispersionRec;
  D0, D1, P0, P1:double;
  j:integer;
begin
  if Distance=0 then
    Result:=1
  else if Distance>FMaxShotDistance*100 then
    Result:=0
  else
  if FShotDispersionRecs.Count<2 then begin
    if Distance<=FPreciseShotDistance*100 then
      Result:=1
    else
      Result:=1-(Distance-FPreciseShotDistance*100)/(FMaxShotDistance*100-FPreciseShotDistance*100);
    if State=busShotRun then
      Result:=0.5*Result;

    case AimState of
    busShotHalfDefence:
      Result:=0.5*Result;
    busShotChestDefence:
      Result:=0.25*Result;
    busShotHeadDefence:
      Result:=0.1*Result;
    busShotRun:
      Result:=0.5*Result;
    busHide:
      Result:=0;
    end;

  end else begin
    D1:=0;
    j:=0;
    while j<FShotDispersionRecs.Count do begin
      ShotDispersionRec1:=FShotDispersionRecs.Item[j] as IShotDispersionRec;
      D1:=ShotDispersionRec1.Distance*100;
      if Distance<D1 then
        Break
      else begin
        inc(j);
        if j<FShotDispersionRecs.Count then
          ShotDispersionRec0:=ShotDispersionRec1;
      end;
    end;
    P1:=ShotDispersionRec1.GetScoreProbability(State, AimState);
    if j=0 then begin
      D0:=0;
      P0:=1;
    end else begin
      D0:=ShotDispersionRec0.Distance*100;
      P0:=ShotDispersionRec0.GetScoreProbability(State, AimState);
    end;
    Result:=P0+(P1-P0)*(Distance-D0)/(D1-D0);
    if Result<0 then
      Result:=0;
  end;
end;

function TWeaponKind.Get_GroupDamage:WordBool;
begin
  Result:=FGroupDamage
end;

function TWeaponKind.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

function TWeaponKind.Get_SoundPower: double;
begin
  Result:=FSoundPower
end;

function TWeaponKind.Get_ShotBreachRecs: IUnknown;
begin
  Result:=FShotBreachRecs as IUnknown
end;

{ TWeaponKinds }

class function TWeaponKinds.GetElementClass: TDMElementClass;
begin
  Result:=TWeaponKind;
end;

class function TWeaponKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IWeaponKind;
end;

function TWeaponKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsWeaponKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TWeaponKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
