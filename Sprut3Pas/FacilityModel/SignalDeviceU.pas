unit SignalDeviceU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CabelNodeU;

type
  TSignalDevice=class(TCabelNode, ISignalDevice)
  protected
    class function  GetClassID:integer; override;
  end;

  TSignalDevices=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TSignalDevice }

class function TSignalDevice.GetClassID: integer;
begin
  Result:=_SignalDevice;
end;

{ TSignalDevices }

class function TSignalDevices.GetElementClass: TDMElementClass;
begin
  Result:=TSignalDevice;
end;

function TSignalDevices.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsSignalDevice;
end;

class function TSignalDevices.GetElementGUID: TGUID;
begin
  Result:=IID_ISignalDevice;
end;

end.
