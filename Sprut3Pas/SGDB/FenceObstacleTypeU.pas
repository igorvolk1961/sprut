unit FenceObstacleTypeU;
//Типы препятствий
interface
uses
  DelayElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TFenceObstacleType=class(TDelayElementType, IFenceObstacleType)
  protected
    class function  GetClassID:integer; override;

    procedure Initialize; override;
  end;

  TFenceObstacleTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, FenceObstacleKindU;

{ TFenceObstacleType }

procedure TFenceObstacleType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_FenceObstacleKind, Self as IDMElement);
end;

class function TFenceObstacleType.GetClassID: integer;
begin
  Result:=_FenceObstacleType
end;

{ TFenceObstacleTypes }

function TFenceObstacleTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsFenceObstacleType;
end;

class function TFenceObstacleTypes.GetElementClass: TDMElementClass;
begin
  Result:=TFenceObstacleType
end;

class function TFenceObstacleTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IFenceObstacleType
end;

function TFenceObstacleTypes.Get_InstanceClassID: Integer;
begin
  Result:=_FenceObstacle
end;

end.
