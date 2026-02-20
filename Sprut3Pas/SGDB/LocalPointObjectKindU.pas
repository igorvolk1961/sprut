unit LocalPointObjectKindU;
{Виды точечных местных объектов}
interface
uses
  LocalObjectKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TLocalPointObjectKind=class(TLocalObjectKind, ILocalPointObjectKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TLocalPointObjectKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TLocalPointObjectKind }

class function TLocalPointObjectKind.GetClassID: integer;
begin
  Result:=_LocalPointObjectKind
end;

{ TLocalPointObjectKinds }

function TLocalPointObjectKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLocalPointObjectKind;
end;

class function TLocalPointObjectKinds.GetElementClass: TDMElementClass;
begin
  Result:=TLocalPointObjectKind;
end;

class function TLocalPointObjectKinds.GetElementGUID: TGUID;
begin
  Result:=IID_ILocalPointObjectKind;
end;


end.
