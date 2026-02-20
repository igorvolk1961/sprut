unit PathLayerU;

interface
uses
  Classes, SysUtils,
  DMElementU, LayerU,
  DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardAnalyzerLib_TLB;

type

  TPathLayer=class(TLayer, IPathLayer)
  private
  protected
    class function  GetClassID:integer; override;

    procedure Clear; override; safecall;
  end;

  TPathLayers=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SafeguardAnalyzerConstU;

{ TPathLayer }


procedure TPathLayer.Clear;
var
  SpatialElements2:IDMCollection2;
begin
  SpatialElements2:=SpatialElements as IDMCollection2;
  SpatialElements2.Clear;
  inherited;
end;

class function TPathLayer.GetClassID: integer;
begin
  Result:=_PathLayer
end;


{ TPathLayers }

function TPathLayers.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsPathLayer
end;

class function TPathLayers.GetElementClass: TDMElementClass;
begin
  Result:=TPathLayer
end;

class function TPathLayers.GetElementGUID: TGUID;
begin
  Result:=IID_IPathLayer
end;

end.
