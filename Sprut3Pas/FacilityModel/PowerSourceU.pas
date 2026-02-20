unit PowerSourceU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CabelNodeU;

type
  TPowerSource=class(TCabelNode, IPowerSource)
  protected
    class function  GetClassID:integer; override;
  end;

  TPowerSources=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TPowerSource }

class function TPowerSource.GetClassID: integer;
begin
  Result:=_PowerSource;
end;

{ TPowerSources }

class function TPowerSources.GetElementClass: TDMElementClass;
begin
  Result:=TPowerSource;
end;

function TPowerSources.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsPowerSource;
end;

class function TPowerSources.GetElementGUID: TGUID;
begin
  Result:=IID_IPowerSource;
end;

end.
