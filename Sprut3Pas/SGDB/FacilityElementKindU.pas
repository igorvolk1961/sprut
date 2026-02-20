unit FacilityElementKindU;

interface
uses
  ModelElementKindU, DataModel_TLB;

type
  TFacilityElementKind=class(TModelElementKind)
  private
    FBackRefCount:integer;
  protected
    function  Get_BackRefCount: Integer; override; safecall;
    procedure _AddBackRef(const aElement: IDMElement); override; safecall;
    procedure _RemoveBackRef(const aElemen: IDMElement); override; safecall;
  end;

implementation

{ TFacilityElementKind }

procedure TFacilityElementKind._AddBackRef(const aElement: IDMElement);
begin
  inherited;
  inc(FBackRefCount)
end;

procedure TFacilityElementKind._RemoveBackRef(const aElemen: IDMElement);
begin
  inherited;
  dec(FBackRefCount)
end;

function TFacilityElementKind.Get_BackRefCount: Integer;
begin
  Result:=FBackRefCount
end;

end.
