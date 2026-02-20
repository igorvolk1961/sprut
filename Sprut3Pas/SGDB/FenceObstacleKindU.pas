unit FenceObstacleKindU;
//Виды препятствий
interface
uses
  DelayElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TFenceObstacleKind=class(TDelayElementKind, IFenceObstacleKind)
  private
    FDefaultWidth:double;
  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function  Get_DefaultWidth: Double; safecall;
  end;

  TFenceObstacleKinds=class(TDMCollection)
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

{ TFenceObstacleKind }

class function TFenceObstacleKind.GetClassID: integer;
begin
  Result:=_FenceObstacleKind
end;

class function TFenceObstacleKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TFenceObstacleKind.Get_DefaultWidth: double;
begin
  Result:=FDefaultWidth
end;

class procedure TFenceObstacleKind.MakeFields0;
begin
  inherited;
  AddField(rsDefaultWidth, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(fokDefaultWidth), 0, pkInput);
end;

function TFenceObstacleKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(fokDefaultWidth):
    Result:=FDefaultWidth;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TFenceObstacleKind.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(fokDefaultWidth):
    FDefaultWidth:=Value;
  else
    inherited;
  end;
end;

{ TFenceObstacleKinds }

class function TFenceObstacleKinds.GetElementClass: TDMElementClass;
begin
  Result:=TFenceObstacleKind;
end;

class function TFenceObstacleKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IFenceObstacleKind;
end;

function TFenceObstacleKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsFenceObstacleKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TFenceObstacleKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
