unit CustomModelElementTypeU;

interface
uses
  DMElementU;

type
  TCustomModelElementType=class(TNamedDMElement)
  protected
    function CanRenameInstance:boolean; virtual;
  end;

implementation

{ TCustomModelElementType }

function TCustomModelElementType.CanRenameInstance: boolean;
begin
  Result:=False;
end;

end.
