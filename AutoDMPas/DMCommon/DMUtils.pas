unit DMUtils;

interface

uses
  SysUtils;

function ExtractValueFromString(var S:string; var Value:double):boolean;
function ExtractQuoteFromString(var S:string):string;
function IncElementNumber(const Name:string):string;

implementation


function ExtractValueFromString(var S:string; var Value:double):boolean;
var
  j, L, Err:integer;
  S0:string;
begin
  S:=trim(S);
  L:=length(S);
  j:=Pos(' ', S);
  if j=0 then begin
    S0:=S;
    S:='';
  end else begin
    S0:=Copy(S, 1, j-1);
    S:=trim(Copy(S, j+1, L-j));
  end;
  Val(S0, Value, Err);
  Result:=(Err=0);
end;

function ExtractQuoteFromString(var S:string):string;
var
  j:integer;
begin
  Result:='';
  j:=Pos('"', S);
  if j=0 then Exit;
  S:=Copy(S, j+1, length(S)-j);
  j:=Pos('"', S);
  if j=0 then Exit;
  Result:=Copy(S, 1, j-1);
  S:=Copy(S, j+1, length(S)-j);
end;

function IncElementNumber(const Name:string):string;
var
  j, L, N, Err:integer;
  S0, S1:string;
begin
  L:=length(Name);
  j:=L;
  while j>0 do
    if Name[j] in ['0'..'9'] then
      dec(j)
    else
      Break;
  if j<L then begin
    S0:=Copy(Name, 1, j);
    S1:=Copy(Name, j+1, L-j);
    Val(S1, N, Err);
    inc(N);
    Result:=S0+IntToStr(N);
  end else
    Result:=Name+' 2'
end;


end.
