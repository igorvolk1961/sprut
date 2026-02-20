unit VolumeSensorTypeU;
{Типы объемных  элементов обнаружения}
interface
uses
  DetectionElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TVolumeSensorType=class(TDetectionElementType, IVolumeSensorType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
    function Get_HasDistantAction:WordBool; override; safecall;
  end;

  TVolumeSensorTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TVolumeSensorType }

procedure TVolumeSensorType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_VolumeSensorKind, Self as IDMElement);
end;

class function TVolumeSensorType.GetClassID: integer;
begin
  Result:=_VolumeSensorType
end;

function TVolumeSensorType.Get_HasDistantAction: WordBool;
begin
  Result:=True;
end;

{ TVolumeSensorTypes }

function TVolumeSensorTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsVolumeSensorType;
end;

class function TVolumeSensorTypes.GetElementClass: TDMElementClass;
begin
  Result:=TVolumeSensorType;
end;

class function TVolumeSensorTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IVolumeSensorType;
end;

function TVolumeSensorTypes.Get_InstanceClassID: Integer;
begin
  Result:=_VolumeSensor
end;

end.
