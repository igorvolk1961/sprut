unit PerimeterSensorTypeU;
{Типы периметровых систем}
interface
uses
  DetectionElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TPerimeterSensorType=class(TDetectionElementType, IPerimeterSensorType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
    function Get_HasDistantAction:WordBool; override; safecall;
  end;

  TPerimeterSensorTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, PerimeterSensorKindU;

{ TPerimeterSensorType }

procedure TPerimeterSensorType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_PerimeterSensorKind, Self as IDMElement);
end;

class function TPerimeterSensorType.GetClassID: integer;
begin
  Result:=_PerimeterSensorType
end;

function TPerimeterSensorType.Get_HasDistantAction: WordBool;
begin
  Result:=True;
end;

{ TPerimeterSensorTypes }

function TPerimeterSensorTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsPerimeterSensorType;
end;

class function TPerimeterSensorTypes.GetElementClass: TDMElementClass;
begin
  Result:=TPerimeterSensorType;
end;

class function TPerimeterSensorTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IPerimeterSensorType;
end;

function TPerimeterSensorTypes.Get_InstanceClassID: Integer;
begin
  Result:=_PerimeterSensor
end;

end.
