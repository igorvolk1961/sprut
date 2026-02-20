unit BarrierSensorU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SensorU;

type
  TBarrierSensor=class(TSensor, IBarrierSensor)
  protected
    class function  GetClassID:integer; override;
  end;

  TBarrierSensors=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TBarrierSensor }

class function TBarrierSensor.GetClassID: integer;
begin
  Result:=_BarrierSensor;
end;

{ TBarrierSensors }

class function TBarrierSensors.GetElementClass: TDMElementClass;
begin
  Result:=TBarrierSensor;
end;

function TBarrierSensors.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsBarrierSensor;
end;

class function TBarrierSensors.GetElementGUID: TGUID;
begin
  Result:=IID_IBarrierSensor;
end;

end.
