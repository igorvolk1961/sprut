unit PositionSensorKindU;
{Виды позиционных элементов обнаружения}
interface
uses
  DetectionElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TPositionSensorKind=class(TDetectionElementKind, IPositionSensorKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TPositionSensorKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TPositionSensorKind }

class function TPositionSensorKind.GetClassID: integer;
begin
  Result:=_PositionSensorKind
end;

{ TPositionSensorKinds }

function TPositionSensorKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsPositionSensorKind;
end;

class function TPositionSensorKinds.GetElementClass: TDMElementClass;
begin
  Result:=TPositionSensorKind;
end;

class function TPositionSensorKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IPositionSensorKind;
end;

end.
