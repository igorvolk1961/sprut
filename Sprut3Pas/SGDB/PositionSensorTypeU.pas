unit PositionSensorTypeU;
{Виды позиционных средств обнаружения}
interface
uses
  DetectionElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TPositionSensorType=class(TDetectionElementType, IPositionSensorType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TPositionSensorTypes=class(TSafeguardElementTypes , IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, PositionSensorKindU;

{ TPositionSensorType }

procedure TPositionSensorType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_PositionSensorKind, Self as IDMElement);
end;

class function TPositionSensorType.GetClassID: integer;
begin
  Result:=_PositionSensorType
end;

{ TPositionSensorTypes }

function TPositionSensorTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsPositionSensorType;
end;

class function TPositionSensorTypes.GetElementClass: TDMElementClass;
begin
  Result:=TPositionSensorType;
end;

class function TPositionSensorTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IPositionSensorType;
end;

function TPositionSensorTypes.Get_InstanceClassID: Integer;
begin
  Result:=_PositionSensor
end;

end.
