unit ActiveSafeguardKindU;
{Виды активных средств защиты}
interface
uses
  DelayElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TActiveSafeguardKind=class(TDelayElementKind, IActiveSafeguardKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TActiveSafeguardKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TActiveSafeguardKind }

class function TActiveSafeguardKind.GetClassID: integer;
begin
  Result:=_ActiveSafeguardKind
end;

{ TActiveSafeguardKinds }

function TActiveSafeguardKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsActiveSafeguardKind;
end;

class function TActiveSafeguardKinds.GetElementClass: TDMElementClass;
begin
  Result:=TActiveSafeguardKind;
end;

class function TActiveSafeguardKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IActiveSafeguardKind;
end;

end.
