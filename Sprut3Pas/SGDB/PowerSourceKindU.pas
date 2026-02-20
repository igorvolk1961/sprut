unit PowerSourceKindU;
{Виды источников питания}
interface
uses
  SecurityEquipmentKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TPowerSourceKind=class(TSecurityEquipmentKind, IPowerSourceKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TPowerSourceKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TPowerSourceKind }

class function TPowerSourceKind.GetClassID: integer;
begin
  Result:=_PowerSourceKind
end;

{ TPowerSourceKinds }

function TPowerSourceKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsPowerSourceKind;
end;

class function TPowerSourceKinds.GetElementClass: TDMElementClass;
begin
  Result:=TPowerSourceKind;
end;

class function TPowerSourceKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IPowerSourceKind;
end;

end.
