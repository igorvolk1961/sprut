unit UndergroundObstacleTypeU;
//Типы препятствий
interface
uses
  DelayElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TUndergroundObstacleType=class(TDelayElementType, IUndergroundObstacleType)
  protected
    class function  GetClassID:integer; override;

    procedure Initialize; override;
  end;

  TUndergroundObstacleTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TUndergroundObstacleType }

procedure TUndergroundObstacleType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_UndergroundObstacleKind, Self as IDMElement);
end;

class function TUndergroundObstacleType.GetClassID: integer;
begin
  Result:=_UndergroundObstacleType
end;

{ TUndergroundObstacleTypes }

function TUndergroundObstacleTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsUndergroundObstacleType;
end;

class function TUndergroundObstacleTypes.GetElementClass: TDMElementClass;
begin
  Result:=TUndergroundObstacleType
end;

class function TUndergroundObstacleTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IUndergroundObstacleType
end;

function TUndergroundObstacleTypes.Get_InstanceClassID: Integer;
begin
  Result:=_UndergroundObstacle
end;

end.
