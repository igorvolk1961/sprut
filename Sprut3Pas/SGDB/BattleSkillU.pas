unit BattleSkillU;
{Погодные условия}
interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TBattleSkill=class(TNamedDMElement, IBattleSkill)
  private
    FTakeAimTime: Double;
    FSkillLevel:integer;
    FStillStillScoringFactor: Double;
    FRunStillScoringFactor: Double;
    FStillRunScoringFactor: Double;
    FRunRunScoringFactor: Double;
    FRunEvadeFactor: Double;
    FStillEvadeFactor: Double;
    FDefaultAcceptableRisk: Double;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;

    function  Get_SkillLevel:integer; safecall;
    function  Get_TakeAimTime: Double; safecall;
    function  Get_StillStillScoringFactor: Double; safecall;
    function  Get_RunStillScoringFactor: Double; safecall;
    function  Get_StillRunScoringFactor: Double; safecall;
    function  Get_RunRunScoringFactor: Double; safecall;
    function  Get_RunEvadeFactor: Double; safecall;
    function  Get_StillEvadeFactor: Double; safecall;
    function  Get_DefaultAcceptableRisk: Double; safecall;
  end;

  TBattleSkills=class(TDMCollection)
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

{ TBattleSkill }

class function TBattleSkill.GetClassID: integer;
begin
  Result:=_BattleSkill
end;

class function TBattleSkill.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TBattleSkill.Get_DefaultAcceptableRisk: Double;
begin
  Result:=FDefaultAcceptableRisk
end;

function TBattleSkill.Get_RunEvadeFactor: Double;
begin
  Result:=FRunEvadeFactor
end;

function TBattleSkill.Get_RunRunScoringFactor: Double;
begin
  Result:=FRunRunScoringFactor
end;

function TBattleSkill.Get_RunStillScoringFactor: Double;
begin
  Result:=FRunStillScoringFactor
end;

function TBattleSkill.Get_StillEvadeFactor: Double;
begin
  Result:=FStillEvadeFactor
end;

function TBattleSkill.Get_StillRunScoringFactor: Double;
begin
  Result:=FStillRunScoringFactor
end;

function TBattleSkill.Get_StillStillScoringFactor: Double;
begin
  Result:=FStillStillScoringFactor
end;

function TBattleSkill.Get_TakeAimTime: Double;
begin
  Result:=FTakeAimTime
end;

class procedure TBattleSkill.MakeFields0;
begin
  inherited;
  AddField(rsSkillLevel, '%df', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(bspSkillLevel), 0, pkInput);
  AddField(rsTakeAimTime, '%4.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bspTakeAimTime), 0, pkInput);
  AddField(rsStillStillScoringFactor, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bspStillStillScoringFactor), 0, pkInput);
  AddField(rsRunStillScoringFactor, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bspRunStillScoringFactor), 0, pkInput);
  AddField(rsStillRunScoringFactor, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bspStillRunScoringFactor), 0, pkInput);
  AddField(rsRunRunScoringFactor, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bspRunRunScoringFactor), 0, pkInput);
  AddField(rsRunEvadeFactor, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bspRunEvadeFactor), 0, pkInput);
  AddField(rsStillEvadeFactor, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bspStillEvadeFactor), 0, pkInput);
  AddField(rsDefaultAcceptableRisk, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bspDefaultAcceptableRisk), 0, pkInput);
end;

function TBattleSkill.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(bspSkillLevel):
    Result:=FSkillLevel;
  ord(bspTakeAimTime):
    Result:=FTakeAimTime;
  ord(bspStillStillScoringFactor):
    Result:=FStillStillScoringFactor;
  ord(bspRunStillScoringFactor):
    Result:=FRunStillScoringFactor;
  ord(bspStillRunScoringFactor):
    Result:=FStillRunScoringFactor;
  ord(bspRunRunScoringFactor):
    Result:=FRunRunScoringFactor;
  ord(bspRunEvadeFactor):
    Result:=FRunEvadeFactor;
  ord(bspStillEvadeFactor):
    Result:=FStillEvadeFactor;
  ord(bspDefaultAcceptableRisk):
    Result:=FDefaultAcceptableRisk;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TBattleSkill.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(bspSkillLevel):
    FSkillLevel:=Value;
  ord(bspTakeAimTime):
    FTakeAimTime:=Value;
  ord(bspStillStillScoringFactor):
    FStillStillScoringFactor:=Value;
  ord(bspRunStillScoringFactor):
    FRunStillScoringFactor:=Value;
  ord(bspStillRunScoringFactor):
    FStillRunScoringFactor:=Value;
  ord(bspRunRunScoringFactor):
    FRunRunScoringFactor:=Value;
  ord(bspRunEvadeFactor):
    FRunEvadeFactor:=Value;
  ord(bspStillEvadeFactor):
    FStillEvadeFactor:=Value;
  ord(bspDefaultAcceptableRisk):
    FDefaultAcceptableRisk:=Value;
  else
    inherited;
  end;
end;

function TBattleSkill.Get_SkillLevel: integer;
begin
  Result:=FSkillLevel
end;

{ TBattleSkills }

function TBattleSkills.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsBattleSkill;
end;

class function TBattleSkills.GetElementClass: TDMElementClass;
begin
  Result:=TBattleSkill;
end;

class function TBattleSkills.GetElementGUID: TGUID;
begin
  Result:=IID_IBattleSkill;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TBattleSkill.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
