unit SkillU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  WarriorAttributeU;

type
  TSkill=class(TWarriorAttribute, ISkill)
  private
    FLevel:integer;
  public
    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;

    function Get_Level:integer; safecall;
  end;

  TSkills=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TSkill }

class function TSkill.GetClassID: integer;
begin
  Result:=_Skill;
end;

function TSkill.Get_Level: integer;
begin
  Result:=FLevel;
end;

class procedure TSkill.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsLowLevel+
     '|'+rsMediumLevel+
     '|'+rsHighLevel;
  AddField(rsSkillLevel, S, '', '',
                 fvtChoice, 1, 0, 0,
                 0, 0, pkInput);
end;

function TSkill.GetFieldValue(Code: integer): OleVariant;
begin
  Result:=FLevel
end;

procedure TSkill.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  0:FLevel:=Value
  else
    inherited
  end;    
end;

class function TSkill.GetFields: IDMCollection;
begin
  Result:=FFields
end;

{ TSkills }

class function TSkills.GetElementClass: TDMElementClass;
begin
  Result:=TSkill;
end;


function TSkills.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsSkill
  else
    Result:=rsSkills;
end;

class function TSkills.GetElementGUID: TGUID;
begin
  Result:=IID_ISkill;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TSkill.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
