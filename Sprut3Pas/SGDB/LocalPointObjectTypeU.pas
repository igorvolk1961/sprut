unit LocalPointObjectTypeU;
{Типы точечных местных объектов}
interface
uses
  LocalObjectTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TLocalPointObjectType=class(TLocalObjectType, ILocalPointObjectType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TLocalPointObjectTypes=class(TDMCollection, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TLocalPointObjectType }

procedure TLocalPointObjectType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_LocalPointObjectKind, Self as IDMElement)
end;

class function TLocalPointObjectType.GetClassID: integer;
begin
  Result:=_LocalPointObjectType
end;

{ TLocalPointObjectTypes }

function TLocalPointObjectTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLocalPointObjectType;
end;

class function TLocalPointObjectTypes.GetElementClass: TDMElementClass;
begin
  Result:=TLocalPointObjectType;
end;

class function TLocalPointObjectTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ILocalPointObjectType;
end;


function TLocalPointObjectTypes.Get_InstanceClassID: Integer;
begin
  Result:=_LocalPointObject
end;

end.
