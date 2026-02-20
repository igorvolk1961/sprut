unit ToolU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  WarriorAttributeU;

type
  TTool=class(TWarriorAttribute, ITool)
  public
    class function  GetClassID:integer; override;
  end;

  TTools=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TTool }

class function TTool.GetClassID: integer;
begin
  Result:=_Tool;
end;

{ TTools }

class function TTools.GetElementClass: TDMElementClass;
begin
  Result:=TTool;
end;


function TTools.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsTool
  else  
    Result:=rsTools;
end;

class function TTools.GetElementGUID: TGUID;
begin
  Result:=IID_ITool;
end;

end.
