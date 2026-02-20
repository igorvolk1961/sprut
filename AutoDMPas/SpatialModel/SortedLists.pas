unit SortedLists;

interface
uses
  Classes;

type

  TSortedList=class(TList)
  private
    function Search(Key: pointer; var Index: Integer): Boolean;
  protected
    function Compare(Key1, Key2:pointer):integer; virtual;
  public
    function CanSort:boolean;
    procedure AddValue(Value:pointer);
    function Duplicates: Boolean;
  end;

implementation

{TSortedList}

function TSortedList.Duplicates: Boolean;
begin
  Result:=False;
end;

function TSortedList.CanSort: boolean;
begin
  Result:=True;
end;

function TSortedList.Compare(Key1, Key2: pointer): integer;
begin
  Result:=-1
end;

procedure TSortedList.AddValue(Value: pointer);
var
  I:integer;
begin
  if CanSort then begin
    if not Search(Value, I) or Duplicates then
      Insert(I, Value)
  end else begin
    I:=Count;
    Insert(I, Value);
  end;
end;

function TSortedList.Search(Key: pointer;
  var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Search := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Compare(Items[I], Key);

    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;

      if C = 0 then
      begin
        Search := True;
        if not Duplicates then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

end.
