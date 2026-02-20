unit ToolTypeU;
interface
uses
  WarriorAttributeTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TToolType=class(TWarriorAttributeType, IToolType)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
  end;

  TToolTypes=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation
uses
  ToolKindU, SafeguardDatabaseConstU;

{ TToolType }

procedure TToolType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_ToolKind, Self as IDMElement);
end;

class function TToolType.GetClassID: integer;
begin
  Result:=_ToolType
end;


{ TToolTypes }

function TToolTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsToolType;
end;

class function TToolTypes.GetElementClass: TDMElementClass;
begin
  Result:=TToolType;
end;

class function TToolTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IToolType;
end;

end.
