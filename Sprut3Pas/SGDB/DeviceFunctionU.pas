unit DeviceFunctionU;
{Функции устройств}
interface
uses
  DeviceCharacteristicU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TDeviceFunction=class(TDeviceCharacteristic, IDeviceFunction)
  protected
    class function  GetClassID:integer; override;
  end;

  TDeviceFunctions=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TDeviceFunction }

class function TDeviceFunction.GetClassID: integer;
begin
  Result:=_DeviceFunction
end;

{ TDeviceFunctions }

function TDeviceFunctions.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsDeviceFunction;
end;

class function TDeviceFunctions.GetElementClass: TDMElementClass;
begin
  Result:=TDeviceFunction;
end;

class function TDeviceFunctions.GetElementGUID: TGUID;
begin
  Result:=IID_IDeviceFunction;
end;


end.
