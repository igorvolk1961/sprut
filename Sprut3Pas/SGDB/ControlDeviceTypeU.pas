unit ControlDeviceTypeU;
{Типы коммутрующих устройств}
interface
uses
  SecuritySubjectTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TControlDeviceType=class(TSecuritySubjectType, IControlDeviceType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TControlDeviceTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TControlDeviceType }

procedure TControlDeviceType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_ControlDeviceKind, Self as IDMElement)
end;

class function TControlDeviceType.GetClassID: integer;
begin
  Result:=_ControlDeviceType
end;

{ TControlDeviceTypes }

function TControlDeviceTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsControlDeviceType;
end;

class function TControlDeviceTypes.GetElementClass: TDMElementClass;
begin
  Result:=TControlDeviceType;
end;

class function TControlDeviceTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IControlDeviceType;
end;


function TControlDeviceTypes.Get_InstanceClassID: Integer;
begin
  Result:=_ControlDevice
end;

end.
