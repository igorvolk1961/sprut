unit VehicleU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  WarriorAttributeU;

type
  TVehicle=class(TWarriorAttribute, IVehicle)
  public
    class function  GetClassID:integer; override;
  end;

  TVehicles=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TVehicle }

class function TVehicle.GetClassID: integer;
begin
  Result:=_Vehicle;
end;

{ TVehicles }

class function TVehicles.GetElementClass: TDMElementClass;
begin
  Result:=TVehicle;
end;


function TVehicles.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsVehicle
  else  
    Result:=rsVehicles;
end;

class function TVehicles.GetElementGUID: TGUID;
begin
  Result:=IID_IVehicle;
end;

end.
