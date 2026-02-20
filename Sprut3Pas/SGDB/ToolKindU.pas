unit ToolKindU;
interface
uses
  WarriorAttributeKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TToolKind=class(TWarriorAttributeKind, IToolKind)
  private
    FBaseEc:double;
    FCoeffEc:double;
    FMass:double;
    FMaxLength:double;
    FHasMetall:boolean;
    FSoundPower:double;
    FKind:integer;
    function Get_BaseEc: double; safecall;
    function Get_CoeffEc: double; safecall;
  protected
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;

    function Get_HasMetall: WordBool; safecall;
    function Get_Mass: double; safecall;
    function Get_MaxLength: double; safecall;
    function Get_SoundPower:double; safecall;
    function Get_Kind:integer; safecall;
  end;

  TToolKinds=class(TDMCollection)
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

{ TToolKind }

class function TToolKind.GetClassID: integer;
begin
  Result:=_ToolKind;
end;

function TToolKind.Get_BaseEc: double;
begin
  Result:=FBaseEc
end;

function TToolKind.Get_CoeffEc: double;
begin
  Result:=FCoeffEc
end;

function TToolKind.Get_HasMetall: WordBool;
begin
  Result:=FHasMetall
end;

function TToolKind.Get_Mass: double;
begin
  Result:=FMass
end;

function TToolKind.Get_MaxLength: double;
begin
  Result:=FMaxLength
end;

class function TToolKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TToolKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(tkToolBaseEc):
    Result:=FBaseEc;
  ord(tkToolCoeffEc):
    Result:=FCoeffEc;
  ord(tkMass):
    Result:=FMass;
  ord(tkMaxLength):
    Result:=FMaxLength;
  ord(tkHasMetall):
    Result:=FHasMetall;
  ord(tkSoundPower):
    Result:=FSoundPower;
  ord(tkKind):
    Result:=FKind;
  ord(tkIsDefault):
    Result:=FIsDefault;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TToolKind.SetFieldValue(Index: integer; Value: OleVariant);
begin
  case Index of
  ord(tkToolBaseEc):
    FBaseEc:=Value;
  ord(tkToolCoeffEc):
    FCoeffEc:=Value;
  ord(tkMass):
    FMass:=Value;
  ord(tkMaxLength):
    FMaxLength:=Value;
  ord(tkHasMetall):
    FHasMetall:=Value;
  ord(tkSoundPower):
    FSoundPower:=Value;
  ord(tkKind):
    FKind:=Value;
  ord(tkIsDefault):
    FIsDefault:=Value;
  else
    inherited;
  end;
end;

class procedure TToolKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsToolBaseEc, '%0.0f', '', '',
      fvtFloat, 0, 0, 0,
      ord(tkToolBaseEc), 0, pkInput);
  AddField(rsToolCoeffEc, '%0.1f', '', '',
      fvtFloat, 0, 0, 0,
      ord(tkToolCoeffEc), 0, pkInput);
  AddField(rsMass, '%8.3f', '', '',
      fvtFloat, 0, 0, 0,
      ord(tkMass), 0, pkInput);
  AddField(rsMaxSize, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(tkMaxLength), 0, pkInput);
  AddField(rsHasMetall, '', '', '',
      fvtBoolean, 1, 0, 0,
      ord(tkHasMetall), 0, pkInput);
  AddField(rsSoundPower, '%0.1f', '', '',
      fvtFloat, 0, 0, 0,
      ord(tkSoundPower), 0, pkInput);
  S:='|'+rsHandTool+
     '|'+rsDriveTool+
     '|'+rsExposive;
  AddField(rsToolKind, S, '', '',
      fvtChoice, 0, 0, 0,
      ord(tkKind), 0, pkInput);
  AddField(rsIsDefault, '', '', '',
             fvtBoolean, 0, 0, 0,
             ord(tkIsDefault), 0, pkInput);
end;

function TToolKind.Get_SoundPower: double;
begin
  Result:=FSoundPower
end;

function TToolKind.Get_Kind: integer;
begin
  Result:=FKind
end;

{ TToolKinds }

function TToolKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsToolKind;
end;

class function TToolKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IToolKind;
end;

class function TToolKinds.GetElementClass: TDMElementClass;
begin
  Result:=TToolKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TToolKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
