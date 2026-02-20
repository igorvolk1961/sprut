unit NamedSpatialElementU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TNamedSpatialElement=class(TNamedDMElement)
  private
    FSpatialElement:IDMElement;
  protected
    function Get_SpatialElement:IDMElement; override; safecall;
    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
  end;

implementation

function TNamedSpatialElement.Get_SpatialElement: IDMElement;
begin
  Result:=FSpatialElement
end;

procedure TNamedSpatialElement.Set_SpatialElement(const Value: IDMElement);
begin
  FSpatialElement:=Value
end;

end.
