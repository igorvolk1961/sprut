unit SurfaceSensorTypeU;
{Типы поверхностных средств обнаружения}
interface
uses
  DetectionElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TSurfaceSensorType=class(TDetectionElementType, ISurfaceSensorType)
  public
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TSurfaceSensorTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, SurfaceSensorKindU;

{ TSurfaceSensorType }

procedure TSurfaceSensorType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_SurfaceSensorKind, Self as IDMElement);
end;

class function TSurfaceSensorType.GetClassID: integer;
begin
  Result:=_SurfaceSensorType
end;

{ TSurfaceSensorTypes }

function TSurfaceSensorTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSurfaceSensorType;
end;

class function TSurfaceSensorTypes.GetElementClass: TDMElementClass;
begin
  Result:=TSurfaceSensorType;
end;

class function TSurfaceSensorTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ISurfaceSensorType
end;

function TSurfaceSensorTypes.Get_InstanceClassID: Integer;
begin
  Result:=_SurfaceSensor
end;

end.
