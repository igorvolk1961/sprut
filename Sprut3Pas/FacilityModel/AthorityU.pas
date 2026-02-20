unit AthorityU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  WarriorAttributeU;

type
  TAthority=class(TWarriorAttribute, IAthority)
  public
    class function  GetClassID:integer; override;
  end;

  TAthorities=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TAthority }

class function TAthority.GetClassID: integer;
begin
  Result:=_Athority;
end;

{ TAthorities }

class function TAthorities.GetElementClass: TDMElementClass;
begin
  Result:=TAthority;
end;


function TAthorities.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsAthority
  else
    Result:=rsAthorities;
end;

class function TAthorities.GetElementGUID: TGUID;
begin
  Result:=IID_IAthority;
end;

end.
