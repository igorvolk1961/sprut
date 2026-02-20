unit GuardPostTypeU;
{ Типы постов охраны}
interface
uses
  SecurityElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TGuardPostType=class(TSecurityElementType, IGuardPostType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TGuardPostTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, GuardPostKindU;

{ TGuardPostType }

procedure TGuardPostType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_GuardPostKind, Self as IDMElement)
end;

class function TGuardPostType.GetClassID: integer;
begin
  Result:=_GuardPostType
end;

{ TGuardPostTypes }

function TGuardPostTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsGuardPostType;
end;

class function TGuardPostTypes.GetElementClass: TDMElementClass;
begin
  Result:=TGuardPostType;
end;

class function TGuardPostTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardPostType;
end;


function TGuardPostTypes.Get_InstanceClassID: Integer;
begin
  Result:=_GuardPost
end;

end.
