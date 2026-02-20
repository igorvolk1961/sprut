unit FenceObstacleU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DelayElementU;

type
  TFenceObstacle=class(TDelayElement, IFenceObstacle)
  private
    FWidth:double;
  protected
    function Get_Width:double; safecall;

    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Set_Ref(const Value:IDMElement); override; safecall;
  end;

  TFenceObstacles=class(TDMCollection)
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

{ TFenceObstacle }

class function TFenceObstacle.GetClassID: integer;
begin
  Result:=_FenceObstacle;
end;

class function TFenceObstacle.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TFenceObstacle.Get_Width: double;
begin
  Result:=FWidth
end;

class procedure TFenceObstacle.MakeFields0;
begin
  inherited;
  AddField(rsWidth, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(fopWidth), 0, pkInput);
end;

function TFenceObstacle.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(fopWidth):
    Result:=FWidth;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TFenceObstacle.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(fopWidth):
    FWidth:=Value;
  else
    inherited;
  end;
end;

procedure TFenceObstacle.Set_Ref(const Value: IDMElement);
begin
  inherited;
  if Value=nil then Exit;
  FWidth:=(Value as IFenceObstacleKind).DefaultWidth
end;

{ TFenceObstacles }

class function TFenceObstacles.GetElementClass: TDMElementClass;
begin
  Result:=TFenceObstacle;
end;

function TFenceObstacles.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsFenceObstacle;
end;

class function TFenceObstacles.GetElementGUID: TGUID;
begin
  Result:=IID_IFenceObstacle;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TFenceObstacle.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
