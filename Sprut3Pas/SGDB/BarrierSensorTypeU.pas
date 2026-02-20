unit BarrierSensorTypeU;
{Типы барьерных элементов обнаружения}
interface
uses
  DetectionElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TBarrierSensorType=class(TDetectionElementType, IBarrierSensorType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
    function Get_HasDistantAction:WordBool; override; safecall;
  end;

  TBarrierSensorTypes=class(TSafeguardElementTypes,  IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TBarrierSensorType }

procedure TBarrierSensorType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_BarrierSensorKind, Self as IDMElement);
end;

class function TBarrierSensorType.GetClassID: integer;
begin
  Result:=_BarrierSensorType
end;

function TBarrierSensorType.Get_HasDistantAction: WordBool;
begin
  Result:=True;
end;

{ TBarrierSensorTypes }

function TBarrierSensorTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsBarrierSensorType;
end;

class function TBarrierSensorTypes.GetElementClass: TDMElementClass;
begin
  Result:=TBarrierSensorType;
end;

class function TBarrierSensorTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IBarrierSensorType;
end;

function TBarrierSensorTypes.Get_InstanceClassID: Integer;
begin
  Result:=_BarrierSensor
end;

end.
