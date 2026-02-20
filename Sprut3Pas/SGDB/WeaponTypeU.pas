unit WeaponTypeU;

interface
uses
  WarriorAttributeTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TWeaponType=class(TWarriorAttributeType, IWeaponType)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
  end;

  TWeaponTypes=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU, WeaponKindU;

{ TWeaponType }

procedure TWeaponType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_WeaponKind, Self as IDMElement);
end;

class function TWeaponType.GetClassID: integer;
begin
  Result:=_WeaponType
end;

{ TWeaponTypes }

function TWeaponTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsWeaponType;
end;

class function TWeaponTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IWeaponType;
end;

class function TWeaponTypes.GetElementClass: TDMElementClass;
begin
  Result:=TWeaponType;
end;

end.
