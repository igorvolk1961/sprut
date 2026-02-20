unit GuardArrivalU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB,
  FacilityModelLib_TLB;

type
  TGuardArrival=class(TDMElement, IGuardArrival)
  private
    FArrivalTime0:double;
    FArrivalTime1:double;
    FArrivalTimeDispersion0:double;
    FArrivalTimeDispersion1:double;
    FUserDefinedArrivalTime:integer;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsReadOnly(Index:integer):WordBool; override; safecall;
    class procedure MakeFields0; override;
    function Get_ArrivalTime0:double; safecall;
    procedure Set_ArrivalTime0(Value:double); safecall;
    function Get_ArrivalTime1:double; safecall;
    procedure Set_ArrivalTime1(Value:double); safecall;
    function Get_UserDefinedArrivalTime:integer; safecall;
    procedure Set_UserDefinedArrivalTime(Value:integer); safecall;
    function Get_ArrivalTimeDispersion0:double; safecall;
    procedure Set_ArrivalTimeDispersion0(Value:double); safecall;
    function Get_ArrivalTimeDispersion1:double; safecall;
    procedure Set_ArrivalTimeDispersion1(Value:double); safecall;
  public
    destructor Destroy; override;
  end;

  TGuardArrivals=class(TDMCollection)
  private
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TGuardArrival }



{ TGuardArrival }

destructor TGuardArrival.Destroy;
begin
  inherited;
end;

function TGuardArrival.FieldIsReadOnly(Index: integer): WordBool;
var
  Code:integer;
begin
  Code:=Get_Field_(Index).Code;
  case Code of
  ord(gaArrivalTime0),
  ord(gaArrivalTime1):
    Result:=(FUserDefinedArrivalTime=0) or
            (FUserDefinedArrivalTime=2)
  else
    Result:=inherited FieldIsReadOnly(Index)
  end;
end;

class function TGuardArrival.GetClassID: integer;
begin
  Result:=_GuardArrival
end;

class function TGuardArrival.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TGuardArrival.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(gaArrivalTime0):
    Result:=FArrivalTime0;
  ord(gaArrivalTime1):
    Result:=FArrivalTime1;
  ord(gaUserDefinedArrivalTime):
    Result:=FUserDefinedArrivalTime;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

function TGuardArrival.Get_ArrivalTime0: double;
begin
  Result:=FArrivalTime0
end;

function TGuardArrival.Get_ArrivalTime1: double;
begin
  Result:=FArrivalTime1
end;

function TGuardArrival.Get_ArrivalTimeDispersion0: double;
begin
  Result:=FArrivalTimeDispersion0
end;

function TGuardArrival.Get_ArrivalTimeDispersion1: double;
begin
  Result:=FArrivalTimeDispersion1
end;

function TGuardArrival.Get_UserDefinedArrivalTime: integer;
begin
  Result:=FUserDefinedArrivalTime
end;

class procedure TGuardArrival.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsArrivalTime0, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gaArrivalTime0), 0, pkInput);
  AddField(rsArrivalTime1, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gaArrivalTime1), 0, pkInput);
  S:='|'+rsCalculatedFromStart+
     '|'+rsUserDefinedFromStart+
     '|'+rsCalculatedFromPrev+
     '|'+rsUserDefinedFromPrev;
  AddField(rsUserDefinedArrivalTime, S, '', '',
                 fvtChoice, 1, 0, 0,
                 ord(gaUserDefinedArrivalTime), 1, pkInput);

end;

procedure TGuardArrival.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(gaArrivalTime0):
    FArrivalTime0:=Value;
  ord(gaArrivalTime1):
    FArrivalTime1:=Value;
  ord(gaUserDefinedArrivalTime):
    FUserDefinedArrivalTime:=Value;
  else
    inherited
  end;
end;

procedure TGuardArrival.Set_ArrivalTime0(Value: double);
begin
  FArrivalTime0:=Value
end;

procedure TGuardArrival.Set_ArrivalTime1(Value: double);
begin
  FArrivalTime1:=Value
end;

procedure TGuardArrival.Set_ArrivalTimeDispersion0(Value: double);
begin
  FArrivalTimeDispersion0:=Value
end;

procedure TGuardArrival.Set_ArrivalTimeDispersion1(Value: double);
begin
  FArrivalTimeDispersion1:=Value
end;

procedure TGuardArrival.Set_UserDefinedArrivalTime(Value: integer);
begin
  FUserDefinedArrivalTime:=Value
end;

{ TGuardArrivals }

function TGuardArrivals.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsGuardArrival
end;

class function TGuardArrivals.GetElementClass: TDMElementClass;
begin
  Result:=TGuardArrival
end;

class function TGuardArrivals.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardArrival
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TGuardArrival.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
