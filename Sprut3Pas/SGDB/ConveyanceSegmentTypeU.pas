unit ConveyanceSegmentTypeU;
{Типы участков маршрута транспортировки}
interface
uses
  SecuritySubjectTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TConveyanceSegmentType=class(TSecuritySubjectType, IConveyanceSegmentType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TConveyanceSegmentTypes=class(TDMCollection, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TConveyanceSegmentType }

procedure TConveyanceSegmentType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_ConveyanceSegmentKind, Self as IDMElement)
end;

class function TConveyanceSegmentType.GetClassID: integer;
begin
  Result:=_ConveyanceSegmentType
end;

{ TConveyanceSegmentTypes }

function TConveyanceSegmentTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsConveyanceSegmentType;
end;

class function TConveyanceSegmentTypes.GetElementClass: TDMElementClass;
begin
  Result:=TConveyanceSegmentType;
end;

class function TConveyanceSegmentTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IConveyanceSegmentType;
end;


function TConveyanceSegmentTypes.Get_InstanceClassID: Integer;
begin
//  Result:=_ConveyanceSegment
  Result:=-1
end;

end.
