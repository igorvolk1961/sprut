unit ZoneStateU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  ElementStateU;

type
  TZoneState=class(TElementState, IZoneState)
  private
    FPersonalPresence: Integer;
    FPersonalCount: Integer;
    FTransparencyDist: Double;
    FUserDefinedVehicleVelocity:boolean;
    FVehicleVelocity:Double;
    FPedestrialVelocity:Double;
  protected
    class function GetClassID:integer; override;

    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function Get_PersonalPresence: Integer; safecall;
    function Get_PersonalCount: Integer; safecall;
    function Get_TransparencyDist: Double; safecall;
    function Get_UserDefinedVehicleVelocity:WordBool; safecall;
    function Get_VehicleVelocity:Double; safecall;
    procedure Set_VehicleVelocity(Value:Double); safecall;
    function Get_PedestrialVelocity:Double; safecall;

    procedure Set_Parent(const Value:IDMElement); override;safecall;
  end;

  TZoneStates=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TZoneState }

function TZoneState.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(zsPersonalPresence):
    Result:=FPersonalPresence;
  ord(zsPersonalCount):
    Result:=FPersonalCount;
  ord(zsTransparencyDist):
    Result:=FTransparencyDist;
  ord(zsUserDefinedVehicleVelocity):
    Result:=FUserDefinedVehicleVelocity;
  ord(zsVehicleVelocity):
    Result:=FVehicleVelocity;
  ord(zsPedestrialVelocity):
    Result:=FPedestrialVelocity;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TZoneState.SetFieldValue(Code:integer; Value:OleVariant);
begin
  case Code of
  ord(zsPersonalPresence):
    FPersonalPresence:=Value;
  ord(zsPersonalCount):
    FPersonalCount:=Value;
  ord(zsTransparencyDist):
    FTransparencyDist:=Value;
  ord(zsUserDefinedVehicleVelocity):
    FUserDefinedVehicleVelocity:=Value;
  ord(zsVehicleVelocity):
    FVehicleVelocity:=Value;
  ord(zsPedestrialVelocity):
    FPedestrialVelocity:=Value;
  else
    inherited
  end;
end;

class function TZoneState.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TZoneState.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsPersonalNeverPresent+
     '|'+rsPersonalMayPresent+
     '|'+rsPersonalAlwaysPresent;
  AddField(rsPersonalPresence, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(zsPersonalPresence), 0, pkInput);
  AddField(rsPersonalCount, '%0d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(zsPersonalCount), 0, pkInput);
  AddField(rsTransparencyDist, '%0.2f', '', '',
                 fvtFloat, InfinitValue, 0, InfinitValue,
                 ord(zsTransparencyDist), 0, pkInput);
  AddField(rsUserDefinedVehicleVelocity, '', '', '',
           fvtBoolean, 0, 0, 1,
           ord(zsUserDefinedVehicleVelocity), 0, pkUserDefined);
  AddField(rsVehicleVelocity, '%0.2f', '', '',
           fvtFloat, 0, 0, 0,
           ord(zsVehicleVelocity), 2, pkUserDefined);
  AddField(rsPedestrialVelocity, '%0.2f', '', '',
           fvtFloat, 0, 0, 0,
           ord(zsPedestrialVelocity), 0, pkInput);
end;

class function TZoneState.GetClassID: integer;
begin
  Result:=_ZoneState
end;

function TZoneState.Get_PedestrialVelocity: Double;
begin
  Result:=FPedestrialVelocity
end;

function TZoneState.Get_PersonalCount: Integer;
begin
  Result:=FPersonalCount
end;

function TZoneState.Get_PersonalPresence: Integer;
begin
  Result:=FPersonalPresence
end;

function TZoneState.Get_TransparencyDist: Double;
begin
  Result:=FTransparencyDist
end;

function TZoneState.Get_UserDefinedVehicleVelocity: WordBool;
begin
  Result:=FUserDefinedVehicleVelocity
end;

function TZoneState.Get_VehicleVelocity: Double;
begin
  Result:=FVehicleVelocity
end;

procedure TZoneState.Set_VehicleVelocity(Value: Double);
begin
  FVehicleVelocity:=Value
end;

procedure TZoneState.Set_Parent(const Value: IDMElement);
var
  Zone:IZone;
begin
  inherited;
  if Value=nil then Exit;
  if DataModel.IsCopying then Exit;
  Zone:=Value as IZone;
  FTransparencyDist:=Zone.TransparencyDist;
  FVehicleVelocity:=Zone.VehicleVelocity;
  FPedestrialVelocity:=Zone.PedestrialVelocity;
end;

{ TZoneStates }

class function TZoneStates.GetElementClass: TDMElementClass;
begin
  Result:=TZoneState;
end;

function TZoneStates.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsZoneState
  else  
    Result:=rsZoneStates;
end;

class function TZoneStates.GetElementGUID: TGUID;
begin
  Result:=IID_IZoneState;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TZoneState.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
