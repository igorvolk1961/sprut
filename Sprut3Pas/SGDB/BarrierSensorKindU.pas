unit BarrierSensorKindU;
{Виды барьерных элементов обнаружения}
interface
uses
  DetectionElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TBarrierSensorKind=class(TDetectionElementKind, IBarrierSensorKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TBarrierSensorKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TBarrierSensorKind }

class function TBarrierSensorKind.GetClassID: integer;
begin
  Result:=_BarrierSensorKind
end;

{ TBarrierSensorKinds }

function TBarrierSensorKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsBarrierSensorKind;
end;

class function TBarrierSensorKinds.GetElementClass: TDMElementClass;
begin
  Result:=TBarrierSensorKind;
end;

class function TBarrierSensorKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IBarrierSensorKind;
end;

end.
