unit DetectionElementKindU;

interface
uses
  SafeguardElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TDetectionElementKind=class(TSafeguardElementKind, IDetectionElementKind)
  private
    FDetectionProbability:double;
    FFalseAlarmPeriod:double;
    FReliabilityTime:double;
    FDefaultDetectionPosition:integer;
  protected
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function Get_StandardDetectionProbability: double; safecall;
    function Get_StandardFalseAlarmPeriod: double; safecall;
    function Get_ReliabilityTime: double; safecall;
    function Get_DefaultDetectionPosition:integer; safecall;
  end;

implementation
uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TDetectionElementKind }

function TDetectionElementKind.Get_StandardDetectionProbability: double;
begin
  Result:=FDetectionProbability
end;

class function TDetectionElementKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TDetectionElementKind.MakeFields0;
var
  S:string;
begin
  inherited;
  AddField(rsDetectionProbability, '%6.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(dekDetectionProbability), 0, pkInput);
  AddField(rsFalseAlarmPeriod, '%6.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(dekFalseAlarmPeriod), 0, pkInput);
  AddField(rsReliabilityTime, '%6.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(dekReliabilityTime), 0, pkInput);
  S:='|'+rsOuter+
     '|'+rsCentral+
     '|'+rsInner;
  AddField(rsDefaultDetectionPosition, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(cnstDefaultDetectionPosition), 0, pkInput);
end;

function TDetectionElementKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(dekDetectionProbability):
    Result:=FDetectionProbability;
  ord(dekFalseAlarmPeriod):
    Result:=FFalseAlarmPeriod;
  ord(dekReliabilityTime):
    Result:=FReliabilityTime;
  ord(cnstDefaultDetectionPosition):
    Result:=FDefaultDetectionPosition;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TDetectionElementKind.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(dekDetectionProbability):
    FDetectionProbability:=Value;
  ord(dekFalseAlarmPeriod):
    FFalseAlarmPeriod:=Value;
  ord(dekReliabilityTime):
    FReliabilityTime:=Value;
  ord(cnstDefaultDetectionPosition):
    FDefaultDetectionPosition:=Value;
  else
    inherited;
  end;
end;

function TDetectionElementKind.Get_StandardFalseAlarmPeriod: double;
begin
  Result:=FFalseAlarmPeriod
end;

function TDetectionElementKind.Get_ReliabilityTime: double;
begin
  Result:=FReliabilityTime
end;

function TDetectionElementKind.Get_DefaultDetectionPosition: integer;
begin
  Result:=FDefaultDetectionPosition
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TDetectionElementKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
