unit CommunicationDeviceU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CabelNodeU;

type
  TCommunicationDevice=class(TCabelNode, ICommunicationDevice)
  private
    FConnectionTime:double;
    FSecret:boolean;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure Set_Ref(const Value:IDMElement); override; safecall;

    function  GetAssessProbability: double; safecall;
    function  Get_ConnectionTime:double; safecall;
    function  Get_Secret:WordBool; safecall;
  end;

  TCommunicationDevices=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TCommunicationDevice }

class function TCommunicationDevice.GetClassID: integer;
begin
  Result:=_CommunicationDevice;
end;

class function TCommunicationDevice.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TCommunicationDevice.MakeFields0;
begin
  inherited;
  AddField(rsConnectionTime, '%0.0f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cdConnectionTime), 0, pkInput);
  AddField(rsSecret, '', '', '',
           fvtBoolean, 0, 0, 0,
           ord(cdSecret), 0, pkInput);
end;

function TCommunicationDevice.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cdConnectionTime):
    Result:=FConnectionTime;
  ord(cdSecret):
    Result:=FSecret;
  else
     Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TCommunicationDevice.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(cdConnectionTime):
    FConnectionTime:=Value;
  ord(cdSecret):
    FSecret:=Value;
  else
    inherited;
  end;
end;

procedure TCommunicationDevice.Set_Ref(const Value: IDMElement);
var
  CommunicationDeviceKind:ICommunicationDeviceKind;
begin
  inherited;
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Ref=nil then Exit;

  CommunicationDeviceKind:=Ref as ICommunicationDeviceKind;
  FConnectionTime:=CommunicationDeviceKind.ConnectionTime;
end;

function TCommunicationDevice.GetAssessProbability: double;
var
  CommunicationDeviceKind:ICommunicationDeviceKind;
begin
  if InWorkingState then begin
    CommunicationDeviceKind:=Ref as ICommunicationDeviceKind;
    if CommunicationDeviceKind.Duplex then
      Result:=0.99
    else
      Result:=0;
  end else
    Result:=0
end;

function TCommunicationDevice.Get_ConnectionTime: double;
begin
  Result:=FConnectionTime
end;

function TCommunicationDevice.Get_Secret: WordBool;
begin
  Result:=FSecret
end;

{ TCommunicationDevices }

class function TCommunicationDevices.GetElementClass: TDMElementClass;
begin
  Result:=TCommunicationDevice;
end;

function TCommunicationDevices.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsCommunicationDevice;
end;

class function TCommunicationDevices.GetElementGUID: TGUID;
begin
  Result:=IID_ICommunicationDevice;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TCommunicationDevice.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
