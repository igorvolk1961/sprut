unit GroundObstacleTypeU;
//Типы препятствий
interface
uses
  DelayElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TGroundObstacleType=class(TDelayElementType, IGroundObstacleType)
  protected
    class function  GetClassID:integer; override;

    procedure Initialize; override;
  end;

  TGroundObstacleTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, GroundObstacleKindU;

{ TGroundObstacleType }

procedure TGroundObstacleType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_GroundObstacleKind, Self as IDMElement);
end;

class function TGroundObstacleType.GetClassID: integer;
begin
  Result:=_GroundObstacleType
end;

{ TGroundObstacleTypes }

function TGroundObstacleTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsGroundObstacleType;
end;

class function TGroundObstacleTypes.GetElementClass: TDMElementClass;
begin
  Result:=TGroundObstacleType
end;

class function TGroundObstacleTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IGroundObstacleType
end;

function TGroundObstacleTypes.Get_InstanceClassID: Integer;
begin
  Result:=_GroundObstacle
end;

end.
