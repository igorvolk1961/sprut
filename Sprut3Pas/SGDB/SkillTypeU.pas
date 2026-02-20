unit SkillTypeU;

interface
uses
  WarriorAttributeTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TSkillType=class(TNamedDMElement, ISkillType)
  private
    FParents:IDMCollection;
  protected
    class function  GetClassID:integer; override;
    function Get_Parents:IDMCollection; override; safecall;

    procedure Initialize; override;
  end;

  TSkillTypes=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TSkillType }

procedure TSkillType.Initialize;
begin
  inherited;
  FParents:=DataModel.CreateCollection(-1, Self as IDMElement);
end;

class function TSkillType.GetClassID: integer;
begin
  Result:=_SkillType
end;


function TSkillType.Get_Parents: IDMCollection;
begin
  Result:=FParents
end;

{ TSkillTypes }

class function TSkillTypes.GetElementClass: TDMElementClass;
begin
  Result:=TSkillType;
end;

class function TSkillTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ISkillType;
end;

function TSkillTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSkillType;
end;

end.
