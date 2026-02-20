unit StartPointKindU;
{Виды точек старта}
interface
uses
  SafeguardElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TStartPointKind=class(TSafeguardElementKind, IStartPointKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TStartPointKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TStartPointKind }

class function TStartPointKind.GetClassID: integer;
begin
  Result:=_StartPointKind
end;


{ TStartPointKinds }

function TStartPointKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsStartPointKind;
end;

class function TStartPointKinds.GetElementClass: TDMElementClass;
begin
  Result:=TStartPointKind;
end;

class function TStartPointKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IStartPointKind;
end;

end.
