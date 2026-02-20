unit SurfaceSensorU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SensorU;

type
  TSurfaceSensor=class(TSensor, ISurfaceSensor)
  private
    FSensorDistance:double;
  protected
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure AfterLoading2; override; safecall;

    class function  GetClassID:integer; override;
    function  ShowInLayerName: WordBool; override; safecall; safecall;
  end;

  TSurfaceSensors=class(TDMCollection)
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

{ TSurfaceSensor }

class function TSurfaceSensor.GetClassID: integer;
begin
  Result:=_SurfaceSensor;
end;

class function TSurfaceSensor.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TSurfaceSensor.MakeFields0;
begin
  inherited;
  AddField(rsSensorDistance, '%6.2f', '', '',
                 fvtFloat, 20, 0, InfinitValue,
                 ord(sspSensorDistance), 0, pkInput);
end;

function TSurfaceSensor.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(sspSensorDistance):
    Result:=FSensorDistance;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TSurfaceSensor.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(sspSensorDistance):
    FSensorDistance:=Value;
  else
    inherited;
  end;
end;

procedure TSurfaceSensor.Set_Parent(const Value: IDMElement);
begin
  inherited;
end;

procedure TSurfaceSensor.AfterLoading2;
begin
  inherited;
end;

function TSurfaceSensor.ShowInLayerName: WordBool;
begin
  Result:=True
end;

{ TSurfaceSensors }

class function TSurfaceSensors.GetElementClass: TDMElementClass;
begin
  Result:=TSurfaceSensor;
end;

function TSurfaceSensors.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsSurfaceSensor;
end;

class function TSurfaceSensors.GetElementGUID: TGUID;
begin
  Result:=IID_ISurfaceSensor;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TSurfaceSensor.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
