unit CustomWarriorPathU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TCustomWarriorPath=class(TNamedDMElement)
  private
    FSpatialElement:IDMElement;
  protected
    function Get_SpatialElement:IDMElement; override; safecall;
    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
    procedure Set_Selected(Value: WordBool); override;
  end;

implementation

function TCustomWarriorPath.Get_SpatialElement: IDMElement;
begin
  Result:=FSpatialElement
end;

procedure TCustomWarriorPath.Set_Selected(Value: WordBool);
begin
  inherited
end;

procedure TCustomWarriorPath.Set_SpatialElement(const Value: IDMElement);
begin
  FSpatialElement:=Value
end;

end.
