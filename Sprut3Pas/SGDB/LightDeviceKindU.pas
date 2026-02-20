unit LightDeviceKindU;
{Виды осветительных устройств}
interface
uses
  SecurityEquipmentKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TLightDeviceKind=class(TSecurityEquipmentKind, ILightDeviceKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TLightDeviceKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TLightDeviceKind }

class function TLightDeviceKind.GetClassID: integer;
begin
  Result:=_LightDeviceKind
end;

{ TLightDeviceKinds }

function TLightDeviceKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLightDeviceKind;
end;

class function TLightDeviceKinds.GetElementClass: TDMElementClass;
begin
  Result:=TLightDeviceKind;
end;

class function TLightDeviceKinds.GetElementGUID: TGUID;
begin
  Result:=IID_ILightDeviceKind;
end;


end.
