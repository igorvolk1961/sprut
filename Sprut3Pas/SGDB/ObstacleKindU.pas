unit ObstacleKindU;
//Виды препятствий
interface
uses
  DelayElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TObstacleKind=class(TDelayElementKind, IObstacleKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TObstacleKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID: TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TObstacleKind }

class function TObstacleKind.GetClassID: integer;
begin
  Result:=_ObstacleKind
end;

{ TObstacleKinds }

class function TObstacleKinds.GetElementClass: TDMElementClass;
begin
  Result:=TObstacleKind;
end;

class function TObstacleKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IObstacleKind;
end;

function TObstacleKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsObstacleKind;
end;

end.
