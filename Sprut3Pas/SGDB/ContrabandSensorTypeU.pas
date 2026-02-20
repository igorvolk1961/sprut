unit ContrabandSensorTypeU;
{Типы средств обнаружения контрабанды}
interface
uses
  DetectionElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TContrabandSensorType=class(TDetectionElementType, IContrabandSensorType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TContrabandSensorTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TContrabandSensorType }

procedure TContrabandSensorType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_ContrabandSensorKind, Self as IDMElement);
end;

class function TContrabandSensorType.GetClassID: integer;
begin
  Result:=_ContrabandSensorType
end;

{ TContrabandSensorTypes }

function TContrabandSensorTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsContrabandSensorType;
end;

class function TContrabandSensorTypes.GetElementClass: TDMElementClass;
begin
  Result:=TContrabandSensorType;
end;

class function TContrabandSensorTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IContrabandSensorType;
end;

function TContrabandSensorTypes.Get_InstanceClassID: Integer;
begin
  Result:=_ContrabandSensor
end;

end.
