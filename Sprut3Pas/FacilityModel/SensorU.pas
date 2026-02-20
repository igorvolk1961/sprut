unit SensorU;

interface
uses
  DM_Windows,
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DetectionElementU;

type
  TCalcFalseAlarmPeriod = procedure (SafeguardElement: IDMElement;
            var FalseAlarmPeriod: double);

  TSensor=class(TDetectionElement, ISensor)
  private
    FUserDefinedFalseAlarmPeriod:boolean;
    FFalseAlarmPeriod:double;
    FDisableFalseAlarm:boolean;
    function CalcStandardFalseAlarmPeriod:double;
  protected
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function Get_DisableFalseAlarm: boolean;
    function Get_FalseAlarmPeriod: double; safecall;
    procedure Set_FalseAlarmPeriod(const Value: double);
    function Get_UserDefinedFalseAlarmPeriod: WordBool; safecall;
    procedure CalcFalseAlarmPeriod; safecall;
    function  Get_UserDefineded: WordBool; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  CalcDetectionProbabilityLib,
  CabelU;

var
  FFields:IDMCollection;
  Flag:boolean;

{ TSensor }

procedure TSensor.CalcFalseAlarmPeriod;
var
  DoCalcFalseAlarmPeriod:TCalcFalseAlarmPeriod;
  ProcName:array[0..255] of Char;
  SensorType:IDetectionElementType;
begin
  if FUserDefinedFalseAlarmPeriod then  Exit;

  if Ref.Parent.QueryInterface(IDetectionElementType, SensorType)=0 then
  with SensorType do
    if CalcFalseAlarmPeriodHandle<>0 then begin
      StrPCopy(ProcName, CalcFalseAlarmPeriodProc);
     @DoCalcFalseAlarmPeriod:=DM_GetProcAddress(CalcFalseAlarmPeriodHandle,
                                   ProcName);
      if @DoCalcFalseAlarmPeriod<>nil then
        DoCalcFalseAlarmPeriod(Self, FFalseAlarmPeriod)
      else begin
        DataModel.HandleError(Format
        ('Ошибка в прцедуре TSensor.Get_FalseAlarmPeriod ID=%d ClassID=%d', [ID, ClassID]));
      end;
    end else
      FFalseAlarmPeriod:=CalcStandardFalseAlarmPeriod
  else
    FFalseAlarmPeriod:=InfinitValue
end;


function TSensor.Get_DisableFalseAlarm: boolean;
begin
  Result:=FDisableFalseAlarm
end;

function TSensor.Get_FalseAlarmPeriod: double;
begin
  Result:=FFalseAlarmPeriod
end;

procedure TSensor.Set_FalseAlarmPeriod(const Value: double);
begin
  FFalseAlarmPeriod:=Value
end;

function TSensor.Get_UserDefinedFalseAlarmPeriod: WordBool;
begin
  Result:=FUserDefinedFalseAlarmPeriod
end;

function TSensor.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(spUserDefinedFalseAlarmPeriod):
    Result:=FUserDefinedFalseAlarmPeriod;
  ord(spFalseAlarmPeriod):
    Result:=FFalseAlarmPeriod;
  ord(spDisableFalseAlarm):
    Result:=FDisableFalseAlarm;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TSensor.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  if Flag then Exit;
  Flag:=True;
  try
  case Code of
  ord(spUserDefinedFalseAlarmPeriod):
    begin
      FUserDefinedFalseAlarmPeriod:=Value;
      UpdateUserDefinedElements(Value);
    end;
  ord(spFalseAlarmPeriod):
    FFalseAlarmPeriod:=Value;
  ord(spDisableFalseAlarm):
    FDisableFalseAlarm:=Value;
  else
    inherited;
  end;
  finally
    Flag:=False;
  end;
end;

class function TSensor.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TSensor.MakeFields0;
begin
  inherited;
  AddField(rsUserDefinedFalseAlarmPeriod, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(spUserDefinedFalseAlarmPeriod), 0, pkUserDefined);
  AddField(rsFalseAlarmPeriod, '%9.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(spFalseAlarmPeriod), 0, pkUserDefined);
  AddField(rsDisableFalseAlarm, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(spDisableFalseAlarm), 0, pkInput);
end;

function TSensor.CalcStandardFalseAlarmPeriod: double;
var
  SensorKind:IDetectionElementKind;
begin
  SensorKind:=Ref as IDetectionElementKind;
  Result:=SensorKind.StandardFalseAlarmPeriod;
  if Result<=0 then
    Result:=InfinitValue
end;

function TSensor.Get_UserDefineded: WordBool;
begin
  Result:=(inherited Get_UserDefineded) or
    FUserDefinedFalseAlarmPeriod
end;

function TSensor.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(spUserDefinedFalseAlarmPeriod):
    Result:=True;
  ord(spFalseAlarmPeriod):
    Result:=Get_UserDefinedFalseAlarmPeriod;
  ord(spDisableFalseAlarm):
    Result:=False;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TSensor.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
