unit ContrabandSensorKindU;
{Виды средств обнаружения контрабанды}
interface
uses
  DetectionElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TContrabandSensorKind=class(TDetectionElementKind, IContrabandSensorKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TContrabandSensorKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TContrabandSensorKind }

class function TContrabandSensorKind.GetClassID: integer;
begin
  Result:=_ContrabandSensorKind
end;

{ TContrabandSensorKinds }

function TContrabandSensorKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsContrabandSensorKind;
end;

class function TContrabandSensorKinds.GetElementClass: TDMElementClass;
begin
  Result:=TContrabandSensorKind;
end;

class function TContrabandSensorKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IContrabandSensorKind;
end;

end.
