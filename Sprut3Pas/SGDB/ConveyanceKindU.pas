unit ConveyanceKindU;
{Виды транспортировки}
interface
uses
  SecuritySubjectKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TConveyanceKind=class(TSecuritySubjectKind, IConveyanceKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TConveyanceKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TConveyanceKind }

class function TConveyanceKind.GetClassID: integer;
begin
  Result:=_ConveyanceKind
end;

{ TConveyanceKinds }

function TConveyanceKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsConveyanceKind;
end;

class function TConveyanceKinds.GetElementClass: TDMElementClass;
begin
  Result:=TConveyanceKind;
end;

class function TConveyanceKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IConveyanceKind;
end;


end.
