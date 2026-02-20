unit LightDeviceTypeU;
{Типы осветительных устройств}
interface
uses
  SecurityEquipmentTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TLightDeviceType=class(TSecurityEquipmentType, ILightDeviceType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
    function Get_HasDistantAction:WordBool; override; safecall;
  end;

  TLightDeviceTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, LightDeviceKindU;

{ TLightDeviceType }

procedure TLightDeviceType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_LightDeviceKind, Self as IDMElement);
end;

class function TLightDeviceType.GetClassID: integer;
begin
  Result:=_LightDeviceType
end;

function TLightDeviceType.Get_HasDistantAction: WordBool;
begin
  Result:=True;
end;

{ TLightDeviceTypes }

function TLightDeviceTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLightDeviceType;
end;

class function TLightDeviceTypes.GetElementClass: TDMElementClass;
begin
  Result:=TLightDeviceType;
end;

class function TLightDeviceTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ILightDeviceType
end;

function TLightDeviceTypes.Get_InstanceClassID: Integer;
begin
  Result:=_LightDevice
end;

end.
