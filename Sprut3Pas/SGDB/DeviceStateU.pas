unit DeviceStateU;

interface
uses
  DeviceCharacteristicU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TDeviceState=class(TDeviceCharacteristic, IDeviceState)
  private
    FParents:IDMCollection;
  protected
    function Get_Parents:IDMCollection; override; safecall;
    class function  GetClassID:integer; override;
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TDeviceStates=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TDeviceState }

procedure TDeviceState.Initialize;
begin
  inherited;
  FParents:=DataModel.CreateCollection(-1, Self as IDMElement)
end;

procedure TDeviceState._Destroy;
begin
  inherited;
  FParents:=nil
end;

class function TDeviceState.GetClassID: integer;
begin
  Result:=_DeviceState
end;


function TDeviceState.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

{ TDeviceStates }

class function TDeviceStates.GetElementClass: TDMElementClass;
begin
  Result:=TDeviceState;
end;

class function TDeviceStates.GetElementGUID: TGUID;
begin
  Result:=IID_IDeviceState;
end;

function TDeviceStates.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsDeviceState;
end;

end.
