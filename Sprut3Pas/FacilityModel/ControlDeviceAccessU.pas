unit ControlDeviceAccessU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  AccessU;

type
  TControlDeviceAccess=class(TAccess, IControlDeviceAccess)
  private
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    procedure Set_Parent(const Value:IDMElement); override;

  end;

  TControlDeviceAccesses=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  FacilityStateU;

var
  FFields:IDMCollection;

{ TControlDeviceAccess }

class function TControlDeviceAccess.GetClassID: integer;
begin
  Result:=_ControlDeviceAccess;
end;

class function TControlDeviceAccess.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TControlDeviceAccess.MakeFields0;
var
  S:WideString;
begin
  S:='|'+rsLimitedControlDeviceAccess+
     '|'+rsFullControlDeviceAccess;
  AddField(rsAccessType, S, '', '',
                 fvtChoice, 0, 0, 0,
                 0, 0, pkInput);
end;

procedure TControlDeviceAccess.Set_Parent(const Value: IDMElement);
var
  AdversaryVariant:IAdversaryVariant;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IAdversaryVariant,AdversaryVariant)=0)  then
    Set_Parent(AdversaryVariant.AdversaryGroups.Item[0])
  else
    inherited;
end;

{ TControlDeviceAccesses }

class function TControlDeviceAccesses.GetElementClass: TDMElementClass;
begin
  Result:=TControlDeviceAccess;
end;


function TControlDeviceAccesses.Get_ClassAlias(Index: integer): WideString;
begin
    Result:=rsControlDeviceAccess
end;

class function TControlDeviceAccesses.GetElementGUID: TGUID;
begin
  Result:=IID_IControlDeviceAccess;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TControlDeviceAccess.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
