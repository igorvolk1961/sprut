unit DelayElementTypeU;

interface
uses
  SafeguardElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TDelayElementType=class(TSafeguardElementType)
  protected
    function Get_CanDelay:WordBool; override; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TDelayElementType }

function TDelayElementType.Get_CanDelay: WordBool;
begin
  Result:=True;
end;

end.
