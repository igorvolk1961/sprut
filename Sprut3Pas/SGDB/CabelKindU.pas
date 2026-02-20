unit CabelKindU;
{Виды кабелей}
interface
uses
  SecurityEquipmentKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TCabelKind=class(TSecurityEquipmentKind, ICabelKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TCabelKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TCabelKind }

class function TCabelKind.GetClassID: integer;
begin
  Result:=_CabelKind
end;

{ TCabelKinds }

function TCabelKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsCabelKind;
end;

class function TCabelKinds.GetElementClass: TDMElementClass;
begin
  Result:=TCabelKind;
end;

class function TCabelKinds.GetElementGUID: TGUID;
begin
  Result:=IID_ICabelKind;
end;

end.
