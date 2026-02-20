unit PathRoadU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB,
  DMServer_TLB,
  SafeguardAnalyzerLib_TLB;

type

  TPathRoad=class(TDMElement, IPathRoad)
  private
    FRoad:IDMElement;
  protected
    class function  GetClassID:integer; override;
    procedure Set_Road(const Value: IDMElement); safecall;
    function  Get_Road: IDMElement; safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TPathRoads=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SafeguardAnalyzerConstU;

{ TPathRoad }

class function TPathRoad.GetClassID: integer;
begin
  Result:=_PathRoad;
end;

function TPathRoad.Get_Road: IDMElement;
begin
  Result:=FRoad
end;

procedure TPathRoad.Set_Road(const Value: IDMElement);
begin
  FRoad:=Value;
end;

procedure TPathRoad.Initialize;
begin
  inherited;
end;

procedure TPathRoad._Destroy;
begin
  inherited;
  FRoad:=nil;
end;

{ TPathRoads }

class function TPathRoads.GetElementClass: TDMElementClass;
begin
  Result:=TPathRoad;
end;

function TPathRoads.Get_ClassAlias(Index:integer): WideString;
begin
    Result:=rsPathRoad
end;

class function TPathRoads.GetElementGUID: TGUID;
begin
  Result:=IID_IPathRoad;
end;

end.
