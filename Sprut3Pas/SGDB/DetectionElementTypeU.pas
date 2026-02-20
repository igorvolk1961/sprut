unit DetectionElementTypeU;

interface
uses
  SafeguardElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TDetectionElementType=class(TSafeguardElementType, IDetectionElementType)
  private
    FCalcFalseAlarmPeriodHandle: integer;

    FCalcFalseAlarmPeriodProc:string;
    FCalcFalseAlarmPeriodLib:string;
  protected
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function Get_CanDetect:WordBool; override; safecall;
    function Get_CanDelay:WordBool; override; safecall;
    function Get_CalcFalseAlarmPeriodLib: WideString; safecall;
    function Get_CalcFalseAlarmPeriodProc: WideString; safecall;
    function Get_CalcFalseAlarmPeriodHandle: integer; safecall;
    procedure Set_CalcFalseAlarmPeriodHandle(Value: integer); safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;
  Flag:boolean;

{ TDetectionElementType }

function TDetectionElementType.Get_CanDelay: WordBool;
begin
  Result:=True;
end;

function TDetectionElementType.Get_CanDetect: WordBool;
begin
  Result:=True;
end;

function TDetectionElementType.Get_CalcFalseAlarmPeriodLib: WideString;
begin
  Result:=FCalcFalseAlarmPeriodLib
end;

function TDetectionElementType.Get_CalcFalseAlarmPeriodProc: WideString;
begin
  Result:=FCalcFalseAlarmPeriodProc
end;

function TDetectionElementType.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(depCalcFalseAlarmPeriodProc):
    Result:=FCalcFalseAlarmPeriodProc;
  ord(depCalcFalseAlarmPeriodLib):
    Result:=FCalcFalseAlarmPeriodLib;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TDetectionElementType.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  if Flag then Exit;
  Flag:=True;
  case Index of
  ord(depCalcFalseAlarmPeriodProc):
    FCalcFalseAlarmPeriodProc:=Value;
  ord(depCalcFalseAlarmPeriodLib):
    FCalcFalseAlarmPeriodLib:=Value;
  else
    inherited;
  end;
  Flag:=False;
end;

class function TDetectionElementType.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TDetectionElementType.MakeFields0;
begin
  inherited;
  AddField(rsCalcFalseAlarmPeriodProc, '', '', '',
                 fvtString, 0, 0, 0,
                 ord(depCalcFalseAlarmPeriodProc), 0, pkInput);
  AddField(rsCalcFalseAlarmPeriodLib, '', '', '',
                 fvtString, 0, 0, 0,
                 ord(depCalcFalseAlarmPeriodLib), 0, pkInput);
end;

function TDetectionElementType.Get_CalcFalseAlarmPeriodHandle: integer;
begin
  Result:=FCalcFalseAlarmPeriodHandle
end;

procedure TDetectionElementType.Set_CalcFalseAlarmPeriodHandle(
  Value: integer);
begin
  FCalcFalseAlarmPeriodHandle:=Value
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TDetectionElementType.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
