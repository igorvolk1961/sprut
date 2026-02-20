unit SecurityElementTypeU;

interface
uses
  SafeguardElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TSecurityElementType=class(TSafeguardElementType)
  protected
    function Get_HasDistantAction:WordBool; override; safecall;
    function Get_CanDetect:WordBool; override; safecall;
    function Get_CanDelay:WordBool; override; safecall;

  end;

implementation

{ TSecurityElementType }

function TSecurityElementType.Get_CanDelay: WordBool;
begin
  Result:=True;
end;

function TSecurityElementType.Get_CanDetect: WordBool;
begin
  Result:=True;
end;

function TSecurityElementType.Get_HasDistantAction: WordBool;
begin
  Result:=True;
end;

end.
