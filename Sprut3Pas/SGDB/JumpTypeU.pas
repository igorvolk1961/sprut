unit JumpTypeU;
{Типы линейных местных объектов}
interface
uses
  LocalObjectTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TJumpType=class(TLocalObjectType, IJumpType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TJumpTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, JumpKindU;

{ TJumpType }

procedure TJumpType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_JumpKind, Self as IDMElement);
end;

class function TJumpType.GetClassID: integer;
begin
  Result:=_JumpType
end;

{ TJumpTypes }

function TJumpTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsJumpType;
end;

class function TJumpTypes.GetElementClass: TDMElementClass;
begin
  Result:=TJumpType;
end;

class function TJumpTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IJumpType;
end;


function TJumpTypes.Get_InstanceClassID: Integer;
begin
  Result:=_Jump
end;

end.
