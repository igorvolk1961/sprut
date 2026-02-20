unit ShotBreachRecU;

interface
uses
  SysUtils,
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TShotBreachRec=class(TDMElement, IShotBreachRec)
  private
    FBulletName:String;
    FDemandArmour: Integer;

  protected
    function Get_Name:WideString; override; safecall;
    procedure Set_Name(const Value:WideString); override; safecall;

    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;

    function Get_BulletName: WideString; safecall;
    function Get_DemandArmour: Integer; safecall;

    procedure Initialize; override;
  end;

  TShotBreachRecs=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation
uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TShotDispersionRec }

procedure TShotBreachRec.Initialize;
begin
  inherited;
  FDemandArmour:=1;
end;

class function TShotBreachRec.GetClassID: integer;
begin
  Result:=_ShotBreachRec
end;

function TShotBreachRec.Get_Name: WideString;
var
  sb, sd:String;
begin
  case FDemandArmour of
    0: sb:=rsBulletPS;
    1: sb:=rsBulletLPS;
    2: sb:=rsBulletBZ;
    3: sb:=rsBulletThermo;
    4: sb:=rsBulletB32;
  else
    sb := rsNotDefined;
  end;

  case FDemandArmour of
    0: sd:=rsNoWeaponDefence;
    1: sd:=rsKnifeDefence;
    2: sd:=rsClass1;
    3: sd:=rsClass2;
    4: sd:=rsClass3;
    5: sd:=rsClass4;
    6: sd:=rsClass5;
    7: sd:=rsClass5a;
    8: sd:=rsClass6;
    9: sd:=rsClass6a;
    10: sd:=rsRPGDefence;
    11: sd:=rsGoodRPGDefence;
  else
    sd := rsNoWeaponDefence;
  end;
  if FDemandArmour=-1 then
    Result:=rsNotDefined
  else
    Result:=Format(rsWeaponBreachFormat, [FBulletName, sd]);
end;

function TShotBreachRec.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(wbpBulletName):
    Result:=FBulletName;
  ord(wbpDemandArmour):
    Result:=FDemandArmour;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TShotBreachRec.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(wbpBulletName):
    FBulletName:= Value;
  ord(wbpDemandArmour):
    FDemandArmour:=Value;
  else
    inherited;
  end;
end;

procedure TShotBreachRec.Set_Name(const Value: WideString);
  function ExtractNumber(const S:string):string;
  var
    j, L:integer;
    S1:string;
  begin
    j:=Pos('1',S);
    if j=0 then j:=Pos('2',S);
    if j=0 then j:=Pos('3',S);
    if j=0 then j:=Pos('4',S);
    if j=0 then j:=Pos('5',S);
    if j=0 then j:=Pos('6',S);
    if j=0 then j:=Pos('7',S);
    if j=0 then j:=Pos('8',S);
    if j=0 then j:=Pos('9',S);
    if j=0 then begin
      Result:='';
      Exit;
    end;
    S1:=Copy(S, j, length(S)-j+1);
    L:=Pos(' ',S1);
    if L=0 then
      L:=length(S1)+1;
    Result:=Copy(S1, 1, L-1);
  end;
var
  err:integer;
  D:double;
  S:string;
begin
{  S:=ExtractNumber(Value);
  Val(S, D, err);
  if err=0 then
    FDistance:=D; }
end;

class function TShotBreachRec.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TShotBreachRec.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsBulletPS+
     '|'+rsBulletLPS+
     '|'+rsBulletBZ+
     '|'+rsBulletThermo+
     '|'+rsBulletB32;
  AddField(rsBulletName, '', '', '',
      fvtString, 0, 0, 0,
      ord(wbpBulletName), 0, pkInput);
  S:='|'+rsNoWeaponDefence+
     '|'+rsKnifeDefence+
     '|'+rsClass1+
     '|'+rsClass2+
     '|'+rsClass3+
     '|'+rsClass4+
     '|'+rsClass5+
     '|'+rsClass5a+
     '|'+rsClass6+
     '|'+rsClass6a+
     '|'+rsRPGDefence+
     '|'+rsGoodRPGDefence;
  AddField(rsDemandArmour, S, '', '',
             fvtChoice, 0, 0, 0,
             ord(wbpDemandArmour), 0, pkInput);
end;

function TShotBreachRec.Get_BulletName: WideString;
begin
  Result:=FBulletName
end;

function TShotBreachRec.Get_DemandArmour: Integer;
begin
  Result:=FDemandArmour
end;

{ TShotBreachRecs }

class function TShotBreachRecs.GetElementClass: TDMElementClass;
begin
  Result:=TShotBreachRec;
end;

function TShotBreachRecs.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsShotBreachRec
  else
    Result:=rsShotBreachRecs
end;

class function TShotBreachRecs.GetElementGUID: TGUID;
begin
  Result:=IID_IShotBreachRec;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TShotBreachRec.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
