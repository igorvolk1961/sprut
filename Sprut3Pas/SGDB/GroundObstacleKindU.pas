unit GroundObstacleKindU;
//Виды препятствий
interface
uses
  DelayElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TGroundObstacleKind=class(TDelayElementKind, IGroundObstacleKind)
  private
  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

  end;

  TGroundObstacleKinds=class(TDMCollection)
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

{ TGroundObstacleKind }

class function TGroundObstacleKind.GetClassID: integer;
begin
  Result:=_GroundObstacleKind
end;

class function TGroundObstacleKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TGroundObstacleKind.MakeFields0;
begin
  inherited;
end;

function TGroundObstacleKind.GetFieldValue(Code: integer): OleVariant;
begin
    Result:=inherited GetFieldValue(Code);
end;

procedure TGroundObstacleKind.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
    inherited;
end;

{ TGroundObstacleKinds }

class function TGroundObstacleKinds.GetElementClass: TDMElementClass;
begin
  Result:=TGroundObstacleKind;
end;

class function TGroundObstacleKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IGroundObstacleKind;
end;

function TGroundObstacleKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsGroundObstacleKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TGroundObstacleKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
