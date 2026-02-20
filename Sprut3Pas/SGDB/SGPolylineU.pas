unit SGPolylineU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB, SpatialModelLib_TLB,
  PolylineU;

type
  TSGPolyline=class(TPolyline)
  private
  protected
    class function  GetClassID:integer; override;
  end;

  TSGPolylines=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function  GetElementGUID:TGUID; override;
  end;

implementation

{ TSGPolyline }

class function TSGPolyline.GetClassID: integer;
begin
  Result:=_SGPolyline
end;

{ TSGPolylines }

class function TSGPolylines.GetElementClass: TDMElementClass;
begin
  Result:=TSGPolyline
end;

class function TSGPolylines.GetElementGUID: TGUID;
begin
  Result:=IID_IPolyline
end;

end.
