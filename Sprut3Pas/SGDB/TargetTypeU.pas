unit TargetTypeU;
{Типы целей}
interface
uses
  SecuritySubjectTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TTargetType=class(TSecuritySubjectType, ITargetType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TTargetTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TTargetType }

procedure TTargetType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_TargetKind, Self as IDMElement)
end;

class function TTargetType.GetClassID: integer;
begin
  Result:=_TargetType
end;

{ TTargetTypes }

function TTargetTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsTargetType;
end;

class function TTargetTypes.GetElementClass: TDMElementClass;
begin
  Result:=TTargetType;
end;

class function TTargetTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ITargetType;
end;


function TTargetTypes.Get_InstanceClassID: Integer;
begin
  Result:=_Target
end;

end.
