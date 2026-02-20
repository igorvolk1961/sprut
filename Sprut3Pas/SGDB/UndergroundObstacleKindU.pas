unit UndergroundObstacleKindU;
//Виды препятствий
interface
uses
  DelayElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TUndergroundObstacleKind=class(TDelayElementKind, IUndergroundObstacleKind)
  private
    FDefaultMineDepth:double;
    FGroundType: Integer;
  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function Get_DefaultMineDepth:double; safecall;
    function  Get_GroundType: Integer; safecall;
  end;

  TUndergroundObstacleKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID: TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TUndergroundObstacleKind }

class function TUndergroundObstacleKind.GetClassID: integer;
begin
  Result:=_UndergroundObstacleKind
end;

class function TUndergroundObstacleKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TUndergroundObstacleKind.Get_DefaultMineDepth: double;
begin
  Result:=FDefaultMineDepth
end;

class procedure TUndergroundObstacleKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsDefaultMineDepth, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(uokDefaultMineDepth), 0, pkInput);
  S:='|'+rsLightGround+
     '|'+rsStounGround+
     '|'+rsRockGround;
  AddField(rsGroundType, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(uokGroundType), 0, pkInput);
end;

function TUndergroundObstacleKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(uokDefaultMineDepth):
    Result:=FDefaultMineDepth;
  ord(uokGroundType):
    Result:=FGroundType;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TUndergroundObstacleKind.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(uokDefaultMineDepth):
    FDefaultMineDepth:=Value;
  ord(uokGroundType):
    FGroundType:=Value;
  else
    inherited
  end;
end;

function TUndergroundObstacleKind.Get_GroundType: Integer;
begin
  Result:=FGroundType
end;

{ TUndergroundObstacleKinds }

class function TUndergroundObstacleKinds.GetElementClass: TDMElementClass;
begin
  Result:=TUndergroundObstacleKind;
end;

class function TUndergroundObstacleKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IUndergroundObstacleKind;
end;

function TUndergroundObstacleKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsUndergroundObstacleKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TUndergroundObstacleKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
