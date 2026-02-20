unit VehicleKindU;

interface
uses
  WarriorAttributeKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TVehicleKind=class(TWarriorAttributeKind, IVehicleKind)
  private
    FVelocity1: double;
    FVelocity2: double;
    FVelocity3: double;
    FDefenceLevel: integer;
    FWidth: double;
    FWeaponKinds:IDMCollection;

    function Get_Velocity1: double;safecall;
    function Get_Velocity2: double;safecall;
    function Get_Velocity3: double;safecall;
    function Get_DefenceLevel:integer; safecall;
    function Get_Width: double;
  protected
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    class function  GetClassID:integer; override;

    property Velocity:double read Get_Velocity1;
    property Velocity2:double read Get_Velocity2;
    property Velocity3:double read Get_Velocity3;
    property Width:double read Get_Width;
    function Get_WeaponKinds:IDMCollection; safecall;

    function GetVelocity(const ZoneKind:IZoneKind):double; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TVehicleKinds=class(TDMCollection)
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

{ TVehicleKind }

class function TVehicleKind.GetClassID: integer;
begin
  Result:=_VehicleKind
end;

function TVehicleKind.Get_Velocity1: double;
var
  aVehicleType:IVehicleType;
begin
  aVehicleType:=Parent as IVehicleType;
  Result:=FVelocity1
end;

function TVehicleKind.Get_Velocity2: double;
var
  aVehicleType:IVehicleType;
begin
  aVehicleType:=Parent as IVehicleType;
  if aVehicleType.TypeCode=0 then
    Result:=FVelocity2
  else
    Result:=0;
end;

function TVehicleKind.Get_Velocity3: double;
var
  aVehicleType:IVehicleType;
begin
  aVehicleType:=Parent as IVehicleType;
  if aVehicleType.TypeCode=0 then
    Result:=FVelocity3
  else
    Result:=0;
end;

function TVehicleKind.Get_DefenceLevel: integer;
begin
  Result:=FDefenceLevel;
end;

function TVehicleKind.Get_Width: double;
begin
  Result:=FWidth;
end;

function TVehicleKind.GetVelocity(const ZoneKind: IZoneKind): double;
var
  aVehicleType:IVehicleType;
begin
  aVehicleType:=Parent as IVehicleType;

  case aVehicleType.TypeCode of
  0:if ZoneKind.CarMovementEnabled then
      case ZoneKind.RoadCover of
      0: Result:=0;
      1: Result:=Get_Velocity1;
      2: Result:=Get_Velocity2;
      3: Result:=Get_Velocity3;
      else Result:=0;
      end
    else
      Result:=0;
  1:if ZoneKind.AirMovementEnabled then
      Result:=Get_Velocity1
    else
      Result:=0;
  2:if ZoneKind.WaterMovementEnabled then
      Result:=Get_Velocity1
    else
      Result:=0;
  3:if ZoneKind.UnderWaterMovementEnabled then
      Result:=Get_Velocity1
    else
      Result:=0;
  else
      Result:=0;
  end;
end;

class function TVehicleKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TVehicleKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsVehicleVelocity1, '%6.1f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vkVehicleVelocity1), 0, pkInput);
  AddField(rsVehicleVelocity2, '%6.1f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vkVehicleVelocity2), 0, pkInput);
  AddField(rsVehicleVelocity3, '%6.1f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vkVehicleVelocity3), 0, pkInput);
  S:='|'+rsNoWeaponDefence+
     '|'+rsKnifeDefence+
     '|'+rsGunDefence+
     '|'+rsRPGDefence+
     '|'+rsGoodRPGDefence;
  AddField(rsVehicleDefenceLevel, S, '', '',
      fvtChoice, 0, 0, 0,
      ord(vkVehicleDefenceLevel), 0, pkInput);
  AddField(rsVehicleWidth, '%6.1f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vkVehicleWidth), 0, pkInput);
end;

function TVehicleKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(vkVehicleVelocity1):
    Result:=FVelocity1;
  ord(vkVehicleVelocity2):
    Result:=FVelocity2;
  ord(vkVehicleVelocity3):
    Result:=FVelocity3;
  ord(vkVehicleDefenceLevel):
    Result:=FDefenceLevel;
  ord(vkVehicleWidth):
    Result:=FWidth;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TVehicleKind.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(vkVehicleVelocity1):
    FVelocity1:=Value;
  ord(vkVehicleVelocity2):
    FVelocity2:=Value;
  ord(vkVehicleVelocity3):
    FVelocity3:=Value;
  ord(vkVehicleDefenceLevel):
    FDefenceLevel:=Value;
  ord(vkVehicleWidth):
    FWidth:=Value;
  else
    inherited;
  end;
end;

function TVehicleKind.Get_WeaponKinds: IDMCollection;
begin
   Result:=FWeaponKinds
end;

procedure TVehicleKind._Destroy;
begin
  inherited;
  FWeaponKinds:=nil;
end;

procedure TVehicleKind.Initialize;
begin
  inherited;
  FWeaponKinds:=DataModel.CreateCollection(_WeaponKind, Self as IDMElement);
end;

function TVehicleKind.Get_CollectionCount: integer;
begin
  Result:=1
end;

function TVehicleKind.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FWeaponKinds
end;

procedure TVehicleKind.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
      aCollectionName:=rsWeaponKind;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelect or leoRename;
      aLinkType:=ltManyToMany;
end;

procedure TVehicleKind.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
  SafeguardDatabase:ISafeguardDatabase;
begin
  SafeguardDatabase:=DataModel as ISafeguardDatabase;
  SourceCollection:=SafeguardDatabase.WeaponKinds;

  aCollection2:=aCollection as IDMCollection2;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do
    aCollection2.Add(SourceCollection.Item[j]);
end;

{ TVehicleKinds }

class function TVehicleKinds.GetElementClass: TDMElementClass;
begin
  Result:=TVehicleKind;
end;

function TVehicleKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsVehicleKind;
end;

class function TVehicleKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IVehicleKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TVehicleKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
