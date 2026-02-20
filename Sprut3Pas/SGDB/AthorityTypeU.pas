unit AthorityTypeU;

interface
uses
  WarriorAttributeKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TAthorityType=class(TNamedDMElement, IAthorityType)
  private
    FParents:IDMCollection;
  protected
    class function  GetClassID:integer; override;
    function Get_Parents:IDMCollection; override; safecall;

    procedure Initialize; override;
  end;

  TAthorityTypes=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TAthorityType }

class function TAthorityType.GetClassID: integer;
begin
  Result:=_AthorityType
end;

function TAthorityType.Get_Parents: IDMCollection;
begin
  Result:=FParents
end;

procedure TAthorityType.Initialize;
begin
  inherited;
  FParents:=DataModel.CreateCollection(-1, Self as IDMElement);
end;

{ TAthorityTypes }

class function TAthorityTypes.GetElementClass: TDMElementClass;
begin
  Result:=TAthorityType;
end;

class function TAthorityTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IAthorityType;
end;

function TAthorityTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsAthorityType;
end;

end.
