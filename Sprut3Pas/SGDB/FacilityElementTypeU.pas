unit FacilityElementTypeU;

interface
uses
  ModelElementTypeU;

type
  TFacilityElementType=class(TModelElementType)
  protected
    function CanRenameInstance:boolean; override;
  end;

implementation

{ TFacilityElementType }

function TFacilityElementType.CanRenameInstance: boolean;
begin
  Result:=True;
end;

end.
