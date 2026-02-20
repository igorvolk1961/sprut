unit JumpKindU;
{Виды линейных местных объектов}
interface
uses
  LocalObjectKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TJumpKind=class(TLocalObjectKind, IJumpKind)
  private
    FDefault:integer;
  protected
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;

    class function  GetClassID:integer; override;
    function Get_Default:integer; safecall;
  end;

  TJumpKinds=class(TDMCollection)
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
  
{ TJumpKind }

class function TJumpKind.GetClassID: integer;
begin
  Result:=_JumpKind
end;

class function TJumpKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TJumpKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(jkDefault):
    Result:=FDefault;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

function TJumpKind.Get_Default: integer;
begin
  Result:=FDefault
end;

class procedure TJumpKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsNot+
     '|'+rsDefaultForStair+
     '|'+rsDefaultForElevator;
  AddField(rsJumpDefault, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(jkDefault), 0, pkInput);
end;

procedure TJumpKind.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(jkDefault):
    FDefault:=Value;
  else
    inherited;
  end;
end;

{ TJumpKinds }

function TJumpKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsJumpKind;
end;

class function TJumpKinds.GetElementClass: TDMElementClass;
begin
  Result:=TJumpKind;
end;

class function TJumpKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IJumpKind;
end;


initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TJumpKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
