unit ToolSkillU;
{Погодные условия}
interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TToolSkill=class(TNamedDMElement, IToolSkill)
  private
   FDelayTimeFactor:double;
   FNoDetectionProbabilityFactor:double;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields; override;
    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;

   function Get_DelayTimeFactor:double; safecall;
   function Get_NoDetectionProbabilityFactor:double; safecall;
  end;

  TToolSkills=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TToolSkill }

class function TToolSkill.GetClassID: integer;
begin
  Result:=_ToolSkill
end;

class function TToolSkill.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TToolSkill.MakeFields;
begin
  inherited;
  AddField(rsDelayTimeFactor, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(tspDelayTimeFactor), 0, pkInput);
  AddField(rsNoDetectionProbabilityFactor, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(tspNoDetectionProbabilityFactor), 0, pkInput);
end;

function TToolSkill.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(tspDelayTimeFactor):
    Result:=FDelayTimeFactor;
  ord(tspNoDetectionProbabilityFactor):
    Result:=FNoDetectionProbabilityFactor;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TToolSkill.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(tspDelayTimeFactor):
    FDelayTimeFactor:=Value;
  ord(tspNoDetectionProbabilityFactor):
    FNoDetectionProbabilityFactor:=Value;
  else
    inherited;
  end;
end;

function TToolSkill.Get_DelayTimeFactor: double;
begin
  Result:=FDelayTimeFactor
end;

function TToolSkill.Get_NoDetectionProbabilityFactor: double;
begin
  Result:=FNoDetectionProbabilityFactor
end;

{ TToolSkills }

function TToolSkills.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsToolSkill;
end;

class function TToolSkills.GetElementClass: TDMElementClass;
begin
  Result:=TToolSkill;
end;

class function TToolSkills.GetElementGUID: TGUID;
begin
  Result:=IID_IToolSkill;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TToolSkill.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
