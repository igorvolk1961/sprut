unit ConveyanceTypeU;
{Типы транспортировки}
interface
uses
  SecuritySubjectTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TConveyanceType=class(TSecuritySubjectType, IConveyanceType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TConveyanceTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TConveyanceType }

procedure TConveyanceType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_ConveyanceKind, Self as IDMElement)
end;

class function TConveyanceType.GetClassID: integer;
begin
  Result:=_ConveyanceType
end;

{ TConveyanceTypes }

function TConveyanceTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsConveyanceType;
end;

class function TConveyanceTypes.GetElementClass: TDMElementClass;
begin
  Result:=TConveyanceType;
end;

class function TConveyanceTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IConveyanceType;
end;


function TConveyanceTypes.Get_InstanceClassID: Integer;
begin
  Result:=_Conveyance
end;

end.
