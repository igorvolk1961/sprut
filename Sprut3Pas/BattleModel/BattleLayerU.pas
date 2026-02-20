unit BattleLayerU;

interface
uses
  Classes, SysUtils, Math, 
  DMElementU, LayerU,
  DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  BattleModelLib_TLB;

type
  TBattleLayer=class(TLayer, IBattleLayer)
  private
  protected
    class function  GetClassID:integer; override;
  end;

  TBattleLayers=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  BattleModelConstU;
  
{ TBattleLayer }

class function TBattleLayer.GetClassID: integer;
begin
  Result:=_BattleLayer
end;


{ TBattleLayers }

function TBattleLayers.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsBattleLayer
end;

class function TBattleLayers.GetElementClass: TDMElementClass;
begin
  Result:=TBattleLayer
end;

class function TBattleLayers.GetElementGUID: TGUID;
begin
  Result:=IID_IBattleLayer
end;

end.
