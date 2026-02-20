unit WeaponU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  WarriorAttributeU;

type
  TWeapon=class(TWarriorAttribute, IWeapon)
  private
    FCount:integer;
    FShotBreach: Variant;
  public
    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;

    procedure Set_Parent(const Value:IDMElement); override; safecall;
    function  Get_Count:integer; safecall;
    procedure Set_Count(Value:integer); safecall;

    function Get_ShotBreach: IUnknown; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;

    procedure MakeDefaultAttribute; virtual;
  end;

  TWeapons=class(TDMCollection)
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

{ TWeapon }

class function TWeapon.GetClassID: integer;
begin
  Result:=_Weapon;
end;

class function TWeapon.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TWeapon.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  0: Result:=FCount;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TWeapon.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  1: begin
    if (Ref<>nil) then
      theCollection:=(Ref as IWeaponKind).ShotBreachRecs as IDMCollection;
  end
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

function TWeapon.Get_Count: integer;
begin
  Result:=FCount
end;

function TWeapon.Get_ShotBreach: IUnknown;
begin
  Result := FShotBreach;
end;

procedure TWeapon.Initialize;
begin
  inherited;

  if not DataModel.IsLoading then
    MakeDefaultAttribute;
end;

procedure TWeapon.MakeDefaultAttribute;
begin
end;

class procedure TWeapon.MakeFields0;
begin
  AddField(rsCount, '%d', '', '',
           fvtInteger, 0, 0, 0,
           0, 0, pkInput);
end;

procedure TWeapon.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  0: FCount:=Value;
  else
    inherited;
  end;
end;

procedure TWeapon.Set_Count(Value: integer);
begin
  FCount:=Value
end;

procedure TWeapon.Set_Parent(const Value: IDMElement);
var
  WarriorGroup:IWarriorGroup;
begin
  inherited;
  if Parent=nil then Exit;
  WarriorGroup:=Parent as IWarriorGroup;
  if Ref=nil then
    FCount:=WarriorGroup.InitialNumber
  else begin
    if Ref.Parent.ID=wtArmWeapon then      // стрелковое оружие 
      FCount:=WarriorGroup.InitialNumber
    else
      FCount:=1
  end;
end;

procedure TWeapon._Destroy;
begin
  inherited;
end;

{ TWeapons }

class function TWeapons.GetElementClass: TDMElementClass;
begin
  Result:=TWeapon;
end;


function TWeapons.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsWeapon
  else
    Result:=rsWeapons;
end;

class function TWeapons.GetElementGUID: TGUID;
begin
  Result:=IID_IWeapon;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TWeapon.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
