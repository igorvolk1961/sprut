unit StartPointTypeU;
{Типы точек старта}
interface
uses
  SafeguardElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TStartPointType=class(TSafeguardElementType, IStartPointType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TStartPointTypes=class(TDMCollection, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, StartPointKindU;

{ TStartPointType }

procedure TStartPointType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_StartPointKind, Self as IDMElement)
end;

class function TStartPointType.GetClassID: integer;
begin
  Result:=_StartPointType
end;

{ TStartPointTypes }

function TStartPointTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsStartPointType;
end;

class function TStartPointTypes.GetElementClass: TDMElementClass;
begin
  Result:=TStartPointType;
end;

class function TStartPointTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IStartPointType;
end;


function TStartPointTypes.Get_InstanceClassID: Integer;
begin
  Result:=_StartPoint
end;

end.
