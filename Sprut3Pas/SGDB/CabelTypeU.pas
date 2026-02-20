unit CabelTypeU;
{Типы  кабелей}
interface
uses
  SecurityEquipmentTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TCabelType=class(TSecurityEquipmentType, ICabelType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TCabelTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TCabelType }

procedure TCabelType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_CabelKind, Self as IDMElement)
end;

class function TCabelType.GetClassID: integer;
begin
  Result:=_CabelType
end;

{ TCabelTypes }

function TCabelTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsCabelType;
end;

class function TCabelTypes.GetElementClass: TDMElementClass;
begin
  Result:=TCabelType;
end;

class function TCabelTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ICabelType;
end;


function TCabelTypes.Get_InstanceClassID: Integer;
begin
  Result:=_Cabel
end;

end.
