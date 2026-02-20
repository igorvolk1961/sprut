unit CommunicationDeviceTypeU;
{Типы приемно-контрольных устройств}
interface
uses
  SecurityEquipmentTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU; 

type
  TCommunicationDeviceType=class(TSecurityEquipmentType, ICommunicationDeviceType)
  protected
    procedure Initialize; override;
    class function  GetClassID:integer; override;
  end;

  TCommunicationDeviceTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TCommunicationDeviceType }

procedure TCommunicationDeviceType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_CommunicationDeviceKind, Self as IDMElement)
end;

class function TCommunicationDeviceType.GetClassID: integer;
begin
  Result:=_CommunicationDeviceType
end;

{ TCommunicationDeviceTypes }

function TCommunicationDeviceTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsCommunicationDeviceType;
end;

class function TCommunicationDeviceTypes.GetElementClass: TDMElementClass;
begin
  Result:=TCommunicationDeviceType;
end;

class function TCommunicationDeviceTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ICommunicationDeviceType;
end;

function TCommunicationDeviceTypes.Get_InstanceClassID: Integer;
begin
  Result:=_ControlDevice
end;

end.
