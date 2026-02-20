unit CommunicationDeviceKindU;
{Виды приемно-контрольных устройств}
interface
uses
  SecurityEquipmentKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TCommunicationDeviceKind=class(TSecurityEquipmentKind, ICommunicationDeviceKind)
  private
    FDuplex:boolean;
    FConnectionTime:double;
  protected
    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;

    function  Get_Duplex:WordBool; safecall;
    function  Get_ConnectionTime:double; safecall;
  end;

  TCommunicationDeviceKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TCommunicationDeviceKind }

class function TCommunicationDeviceKind.GetClassID: integer;
begin
  Result:=_CommunicationDeviceKind
end;

class function TCommunicationDeviceKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TCommunicationDeviceKind.MakeFields0;
begin
  inherited;
  AddField(rsDuplex, '', '', '',
           fvtBoolean, 0, 0, 0,
           ord(cdkDuplex), 0, pkInput);
  AddField(rsConnectionTime, '%0.0f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cdkConnectionTime), 0, pkInput);
end;

function TCommunicationDeviceKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cdkDuplex):
    Result:=FDuplex;
  ord(cdkConnectionTime):
    Result:=FConnectionTime;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TCommunicationDeviceKind.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(cdkDuplex):
    FDuplex:=Value;
  ord(cdkConnectionTime):
    FConnectionTime:=Value;
  else
    inherited;
  end;
end;

function TCommunicationDeviceKind.Get_ConnectionTime: double;
begin
  Result:=FConnectionTime
end;

function TCommunicationDeviceKind.Get_Duplex: WordBool;
begin
  Result:=FDuplex
end;

{ TCommunicationDeviceKinds }

function TCommunicationDeviceKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsCommunicationDeviceKind;
end;

class function TCommunicationDeviceKinds.GetElementClass: TDMElementClass;
begin
  Result:=TCommunicationDeviceKind;
end;

class function TCommunicationDeviceKinds.GetElementGUID: TGUID;
begin
  Result:=IID_ICommunicationDeviceKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TCommunicationDeviceKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
