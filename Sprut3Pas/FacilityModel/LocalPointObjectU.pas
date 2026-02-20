unit LocalPointObjectU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardElementU;

type

  TLocalPointObject=class(TSafeguardElement, ILocalPointObject)
  protected
    class function  GetClassID:integer; override;
  end;

  TLocalPointObjects=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TLocalPointObjects }

class function TLocalPointObject.GetClassID: integer;
begin
  Result:=_LocalPointObject;
end;

{ TLocalPointObjects }

class function TLocalPointObjects.GetElementClass: TDMElementClass;
begin
  Result:=TLocalPointObject;
end;

function TLocalPointObjects.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsLocalPointObject;
end;

class function TLocalPointObjects.GetElementGUID: TGUID;
begin
  Result:=IID_ILocalPointObject;
end;


end.
