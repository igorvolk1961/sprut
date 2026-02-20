unit PowerSourceTypeU;
{Типы Источников Питания }
interface
uses
  SecurityEquipmentTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TPowerSourceType=class(TSecurityEquipmentType, IPowerSourceType)
  protected
    procedure Initialize; override;
    class function  GetClassID:integer; override;
  end;

  TPowerSourceTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, PowerSourceKindU;

{ TPowerSourceType }

procedure TPowerSourceType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_PowerSourceKind, Self as IDMElement)
end;

class function TPowerSourceType.GetClassID: integer;
begin
  Result:=_PowerSourceType
end;

{ TPowerSourceTypes }

function TPowerSourceTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsPowerSourceType;
end;

class function TPowerSourceTypes.GetElementClass: TDMElementClass;
begin
  Result:=TPowerSourceType;
end;

class function TPowerSourceTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IPowerSourceType;
end;

function TPowerSourceTypes.Get_InstanceClassID: Integer;
begin
  Result:=_PowerSourceTYpe
end;

end.
