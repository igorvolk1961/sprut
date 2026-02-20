unit ContrabandSensorU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DetectionElementU;

type
  TContrabandSensor=class(TDetectionElement, IContrabandSensor)
  private
    FUseAlways:integer;
  protected
    class function  GetClassID:integer; override;

    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  FieldIsVisible(Code: integer):WordBool; override; safecall;

    function Get_UseAlways:integer; safecall;

    function ShowInLayerName:WordBool; override;
  end;

  TContrabandSensors=class(TDMCollection)
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

{ TContrabandSensor }

class function TContrabandSensor.GetClassID: integer;
begin
  Result:=_ContrabandSensor;
end;

class function TContrabandSensor.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TContrabandSensor.Get_UseAlways: integer;
begin
  Result:=FUseAlways
end;

class procedure TContrabandSensor.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+'Выборочно'+
     '|'+'Обязательно';
  AddField(rsUseAlways, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(csUseAlways), 0, pkInput);
end;

function TContrabandSensor.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(csUseAlways):
    Result:=FUseAlways;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TContrabandSensor.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(csUseAlways):
    FUseAlways:=Value;
  else
    inherited;
  end;
end;

function TContrabandSensor.ShowInLayerName: WordBool;
begin
  Result:=False
end;

function TContrabandSensor.FieldIsVisible(Code: integer): WordBool;
begin
  Result:=inherited FieldIsVisible(Code)
end;

{ TContrabandSensors }

class function TContrabandSensors.GetElementClass: TDMElementClass;
begin
  Result:=TContrabandSensor;
end;

function TContrabandSensors.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsContrabandSensor;
end;

class function TContrabandSensors.GetElementGUID: TGUID;
begin
  Result:=IID_IContrabandSensor;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TContrabandSensor.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
