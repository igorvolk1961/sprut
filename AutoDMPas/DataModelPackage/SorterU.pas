unit SorterU;

interface
uses
  DMComObjectU, DataModel_TLB;

type  
  TSorter=class(TDMComObject, ISorter)
  protected
    function  Get_Duplicates: WordBool; virtual; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; virtual; safecall;
    property Duplicates: WordBool read Get_Duplicates;
  end;


implementation
{ TSorter }

function TSorter.Compare(const Key1, Key2: IDMElement): Integer;
begin
  if Key1.ID<Key2.ID then
    Result:=-1
  else
  if Key1.ID>Key2.ID then
    Result:=+1
  else
    Result:=0
end;


function TSorter.Get_Duplicates: WordBool;
begin
  Result:=True
end;

end.
