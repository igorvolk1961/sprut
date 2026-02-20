unit PerimeterSensorKindU;
{Виды периметровых систем}
interface
uses
  DetectionElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TPerimeterSensorKind=class(TDetectionElementKind, IPerimeterSensorKind)
  private
    FLength:double;
    FZoneWidth:double;
  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function Get_Length:double; safecall;
    function Get_ZoneWidth:double; safecall;
  end;

  TPerimeterSensorKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;


{ TPerimeterSensorKind }

class function TPerimeterSensorKind.GetClassID: integer;
begin
  Result:=_PerimeterSensorKind
end;

class function TPerimeterSensorKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TPerimeterSensorKind.Get_ZoneWidth: double;
begin
  Result:=FZoneWidth
end;

function TPerimeterSensorKind.Get_Length: double;
begin
  Result:=FLength
end;

class procedure TPerimeterSensorKind.MakeFields0;
begin
  inherited;
  AddField(rsZoneLength, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(pskLength), 0, pkInput);
  AddField(rsZoneHalfWidth, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(pskZoneWidth), 0, pkInput);
end;

function TPerimeterSensorKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(pskLength):
    Result:=FLength;
  ord(pskZoneWidth):
    Result:=FZoneWidth;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TPerimeterSensorKind.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(pskLength):
    FLength:=Value;
  ord(pskZoneWidth):
    FZoneWidth:=Value;
  else
    inherited;
  end;
end;

{ TPerimeterSensorKinds }

function TPerimeterSensorKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsPerimeterSensorKind;
end;

class function TPerimeterSensorKinds.GetElementClass: TDMElementClass;
begin
  Result:=TPerimeterSensorKind;
end;

class function TPerimeterSensorKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IPerimeterSensorKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TPerimeterSensorKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
