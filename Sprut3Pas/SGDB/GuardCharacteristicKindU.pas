unit GuardCharacteristicKindU;

interface
uses
  WarriorAttributeKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TGuardCharacteristicKind=class(TWarriorAttributeKind, IGuardCharacteristicKind)
  private
    FInControlSectorDetectionProbability:double;
    FOutOfControlSectorDetectionProbability:double;
    FSoundDetectionProbability:double;
    function Get_InControlSectorDetectionProbability: double;
    function Get_OutOfControlSectorDetectionProbability: double;
    function Get_SoundDetectionProbability: double;
  protected
    function GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    class function  GetClassID:integer; override;

    property InControlSectorDetectionProbability:double
      read Get_InControlSectorDetectionProbability;
    property OutOfControlSectorDetectionProbability:double
      read Get_OutOfControlSectorDetectionProbability;
    property SoundDetectionProbability:double
      read Get_SoundDetectionProbability;
  end;

  TGuardCharacteristicKinds=class(TDMCollection)
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

{ TGuardCharacteristicKind }

class function TGuardCharacteristicKind.GetClassID: integer;
begin
  Result:=_GuardCharacteristicKind
end;

class function TGuardCharacteristicKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TGuardCharacteristicKind.Get_InControlSectorDetectionProbability: double;
begin
  Result:=FInControlSectorDetectionProbability
end;

function TGuardCharacteristicKind.Get_OutOfControlSectorDetectionProbability: double;
begin
  Result:=FOutOfControlSectorDetectionProbability
end;

function TGuardCharacteristicKind.Get_SoundDetectionProbability: double;
begin
  Result:=FSoundDetectionProbability
end;

class procedure TGuardCharacteristicKind.MakeFields0;
begin
  inherited;
  AddField(rsInControlSectorDetectionProbability, '%7.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gcInControlSectorDetectionProbability), 0, pkInput);
  AddField(rsOutOfControlSectorDetectionProbability, '%7.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gcOutOfControlSectorDetectionProbability), 0, pkInput);
  AddField(rsSoundDetectionProbability, '%7.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(gcSoundDetectionProbability), 0, pkInput);
end;

function TGuardCharacteristicKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(gcInControlSectorDetectionProbability):
    Result:=FInControlSectorDetectionProbability;
  ord(gcOutOfControlSectorDetectionProbability):
    Result:=FOutOfControlSectorDetectionProbability;
  ord(gcSoundDetectionProbability):
    Result:=FSoundDetectionProbability;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TGuardCharacteristicKind.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(gcInControlSectorDetectionProbability):
    FInControlSectorDetectionProbability:=Value;
  ord(gcOutOfControlSectorDetectionProbability):
    FOutOfControlSectorDetectionProbability:=Value;
  ord(gcSoundDetectionProbability):
    FSoundDetectionProbability:=Value;
  else
    inherited;
  end;
end;

{ TGuardCharacteristicKinds }

class function TGuardCharacteristicKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardCharacteristicKind;
end;

function TGuardCharacteristicKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsGuardCharacteristicKind;
end;

class function TGuardCharacteristicKinds.GetElementClass: TDMElementClass;
begin
  Result:=TGuardCharacteristicKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TGuardCharacteristicKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
