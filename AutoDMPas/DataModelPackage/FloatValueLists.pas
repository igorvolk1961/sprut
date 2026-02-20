unit FloatValueLists;

interface
uses
  Classes;

type
  PDouble=^double;

  TFloatValueList=class(TList)
  private
    function GetFloatValue(Index: integer): double;
    procedure SetFloatValue(Index: integer; const Value: double);
  public
    destructor Destroy; override;
    property FloatValue[Index:integer]:double
            read GetFloatValue write SetFloatValue; default;
    procedure AddValue(Value:double); virtual;
    procedure FreeValues;
  end;

  TSortedFloatValueList=class(TFloatValueList)
  private
    function Search(Key: pointer; var Index: Integer): Boolean;
  protected
    function Compare(Key1, Key2:pointer):integer;
  public
    function CanSort:boolean;
    procedure AddValue(Value:double); override;
    function Duplicates: Boolean;
  end;

implementation

{ TFloatValueList }

destructor TFloatValueList.Destroy;
begin
  FreeValues;
  inherited Destroy;
end;

procedure TFloatValueList.AddValue(Value: double);
var
  FloatValue:PDouble;
begin
  GetMem(FloatValue, SizeOf(double));
  FloatValue^:=Value;
  Add(FloatValue);
end;

function TFloatValueList.GetFloatValue(Index: integer): double;
begin
  Result:=PDouble(Items[Index])^
end;

procedure TFloatValueList.SetFloatValue(Index: integer;
  const Value: double);
begin
  PDouble(Items[Index])^:=Value;
end;

procedure TFloatValueList.FreeValues;
var j:integer;
begin
  for j:=0 to Count-1 do
    FreeMem(Items[j], SizeOf(double));
  Clear;
end;

{TSortedFloatValueList}

function TSortedFloatValueList.Duplicates: Boolean;
begin
  Result:=False;
end;

function TSortedFloatValueList.CanSort: boolean;
begin
  Result:=True;
end;

function TSortedFloatValueList.Compare(Key1, Key2: pointer): integer;
var FloatValue1, FloatValue2:double;
begin
  FloatValue1:=PDouble(Key1)^;
  FloatValue2:=PDouble(Key2)^;
  if FloatValue1<FloatValue2 then
    Result:=-1
  else if FloatValue1>FloatValue2 then
    Result:=+1
  else
    Result:=0
end;

procedure TSortedFloatValueList.AddValue(Value: double);
var
  FloatValue:PDouble;
  I:integer;
begin
  GetMem(FloatValue, SizeOf(double));
  FloatValue^:=Value;

  if CanSort then begin
    if not Search(FloatValue, I) or Duplicates then
      Insert(I, FloatValue)
  end else begin
    I:=Count;
    Insert(I, FloatValue);
  end;
end;

function TSortedFloatValueList.Search(Key: pointer;
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
