unit SGViewU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB, SpatialModelLib_TLB,
  ViewU;

type
  TSGView=class(TView)
  private
  protected
    class function  GetClassID:integer; override;
  end;

  TSGViews=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function  GetElementGUID:TGUID; override;
  end;

implementation

{ TSGView }

class function TSGView.GetClassID: integer;
begin
  Result:=_SGView
end;

{ TSGViews }

class function TSGViews.GetElementClass: TDMElementClass;
begin
  Result:=TSGView
end;

class function TSGViews.GetElementGUID: TGUID;
begin
  Result:=IID_IView
end;

end.
