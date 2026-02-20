unit BoundaryPathU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomWarriorPathU;

type
  TBoundaryPath=class(TCustomWarriorPath)
  end;

  TBoundaryPaths=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TBoundaryPaths }

class function TBoundaryPaths.GetElementClass: TDMElementClass;
begin
  Result:=TBoundaryPath;
end;

function TBoundaryPaths.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsBoundaryPath
  else  
    Result:=rsBoundaryPaths;
end;

class function TBoundaryPaths.GetElementGUID: TGUID;
begin
  Result:=IID_IBoundaryPath;
end;

end.
