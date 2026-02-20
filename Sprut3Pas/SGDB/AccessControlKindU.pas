unit AccessControlKindU;
{Виды средств контроля доступа}
interface
uses
  DetectionElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TAccessControlKind=class(TDetectionElementKind, IAccessControlKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TAccessControlKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TAccessControlKind }

class function TAccessControlKind.GetClassID: integer;
begin
  Result:=_AccessControlKind
end;

{ TAccessControlKinds }

function TAccessControlKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsAccessControlKind;
end;

class function TAccessControlKinds.GetElementClass: TDMElementClass;
begin
  Result:=TAccessControlKind;
end;

class function TAccessControlKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IAccessControlKind;
end;

end.
