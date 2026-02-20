unit ShotDispersionRecU;

interface
uses
  SysUtils,
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TShotDispersionRec=class(TDMElement, IShotDispersionRec)
  private
    FDistance:double;
    FCartridgeCountPerScore_Still_Head: Integer;
    FCartridgeCountPerScore_Still_Chest: Integer;
    FCartridgeCountPerScore_Still_Half: Integer;
    FCartridgeCountPerScore_Still_Full: Integer;
    FCartridgeCountPerScore_Still_Run: Integer;
    FCartridgeCountPerScore_Run_Head: Integer;
    FCartridgeCountPerScore_Run_Chest: Integer;
    FCartridgeCountPerScore_Run_Half: Integer;
    FCartridgeCountPerScore_Run_Full: Integer;
    FCartridgeCountPerScore_Run_Run: Integer;

    FVerticalDeviation1:double;
    FHorizontalDeviation1:double;
    FVerticalDeviation2:double;
    FHorizontalDeviation2:double;

  protected
    function Get_Name:WideString; override; safecall;
    procedure Set_Name(const Value:WideString); override; safecall;

    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;

    function Get_HorizontalDeviation1: double; safecall;
    function Get_HorizontalDeviation2: double; safecall;
    function Get_VerticalDeviation1: double; safecall;
    function Get_VerticalDeviation2: double; safecall;
    function Get_Distance: double; safecall;
    function  Get_CartridgeCountPerScore_Still_Head: Integer; safecall;
    function  Get_CartridgeCountPerScore_Still_Chest: Integer; safecall;
    function  Get_CartridgeCountPerScore_Still_Half: Integer; safecall;
    function  Get_CartridgeCountPerScore_Still_Full: Integer; safecall;
    function  Get_CartridgeCountPerScore_Still_Run: Integer; safecall;
    function  Get_CartridgeCountPerScore_Run_Head: Integer; safecall;
    function  Get_CartridgeCountPerScore_Run_Chest: Integer; safecall;
    function  Get_CartridgeCountPerScore_Run_Half: Integer; safecall;
    function  Get_CartridgeCountPerScore_Run_Full: Integer; safecall;
    function  Get_CartridgeCountPerScore_Run_Run: Integer; safecall;
    function  GetScoreProbability(State, AimState:integer): Double; safecall;

    property Distance:double
      read Get_Distance;
    property VerticalDeviation1:double
      read Get_VerticalDeviation1;
    property HorizontalDeviation1:double
      read Get_HorizontalDeviation1;
    property VerticalDeviation2:double
      read Get_VerticalDeviation2;
    property HorizontalDeviation2:double
      read Get_HorizontalDeviation2;

    procedure Initialize; override;
  end;

  TShotDispersionRecs=class(TDMCollection)
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

procedure TShotDispersionRec.Initialize;
begin
  inherited;
  FDistance:=-1;
end;

class function TShotDispersionRec.GetClassID: integer;
begin
  Result:=_ShotDispersionRec
end;

function TShotDispersionRec.Get_HorizontalDeviation1: double;
begin
  Result:=FHorizontalDeviation1
end;

function TShotDispersionRec.Get_HorizontalDeviation2: double;
begin
  Result:=FHorizontalDeviation2
end;

function TShotDispersionRec.Get_Name: WideString;
begin
  if FDistance=-1 then
    Result:=rsNotDefined
  else
    Result:=Format(rsMediumDeviationFormat, [FDistance]);
end;

function TShotDispersionRec.Get_VerticalDeviation1: double;
begin
  Result:=FVerticalDeviation1
end;

function TShotDispersionRec.Get_VerticalDeviation2: double;
begin
  Result:=FVerticalDeviation2
end;

function TShotDispersionRec.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(wdpWeaponDistance):
    Result:=FDistance;
  ord(wdpCartridgeCountPerScore_Still_Head):
    Result:=FCartridgeCountPerScore_Still_Head;
  ord(wdpCartridgeCountPerScore_Still_Chest):
    Result:=FCartridgeCountPerScore_Still_Chest;
  ord(wdpCartridgeCountPerScore_Still_Half):
    Result:=FCartridgeCountPerScore_Still_Half;
  ord(wdpCartridgeCountPerScore_Still_Full):
    Result:=FCartridgeCountPerScore_Still_Full;
  ord(wdpCartridgeCountPerScore_Still_Run):
    Result:=FCartridgeCountPerScore_Still_Run;
  ord(wdpCartridgeCountPerScore_Run_Head):
    Result:=FCartridgeCountPerScore_Run_Head;
  ord(wdpCartridgeCountPerScore_Run_Chest):
    Result:=FCartridgeCountPerScore_Run_Chest;
  ord(wdpCartridgeCountPerScore_Run_Half):
    Result:=FCartridgeCountPerScore_Run_Half;
  ord(wdpCartridgeCountPerScore_Run_Full):
    Result:=FCartridgeCountPerScore_Run_Full;
  ord(wdpCartridgeCountPerScore_Run_Run):
    Result:=FCartridgeCountPerScore_Run_Run;
  ord(wdpWeaponVerticalDeviation1):
    Result:=FVerticalDeviation1;
  ord(wdpWeaponHorizontalDeviation1):
    Result:=FHorizontalDeviation1;
  ord(wdpWeaponVerticalDeviation2):
    Result:=FVerticalDeviation2;
  ord(wdpWeaponHorizontalDeviation2):
    Result:=FHorizontalDeviation2;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TShotDispersionRec.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(wdpWeaponDistance):
    FDistance:=Value;
  ord(wdpCartridgeCountPerScore_Still_Head):
    FCartridgeCountPerScore_Still_Head:=Value;
  ord(wdpCartridgeCountPerScore_Still_Chest):
    FCartridgeCountPerScore_Still_Chest:=Value;
  ord(wdpCartridgeCountPerScore_Still_Half):
    FCartridgeCountPerScore_Still_Half:=Value;
  ord(wdpCartridgeCountPerScore_Still_Full):
    FCartridgeCountPerScore_Still_Full:=Value;
  ord(wdpCartridgeCountPerScore_Still_Run):
    FCartridgeCountPerScore_Still_Run:=Value;
  ord(wdpCartridgeCountPerScore_Run_Head):
    FCartridgeCountPerScore_Run_Head:=Value;
  ord(wdpCartridgeCountPerScore_Run_Chest):
    FCartridgeCountPerScore_Run_Chest:=Value;
  ord(wdpCartridgeCountPerScore_Run_Half):
    FCartridgeCountPerScore_Run_Half:=Value;
  ord(wdpCartridgeCountPerScore_Run_Full):
    FCartridgeCountPerScore_Run_Full:=Value;
  ord(wdpCartridgeCountPerScore_Run_Run):
    FCartridgeCountPerScore_Run_Run:=Value;
  ord(wdpWeaponVerticalDeviation1):
    FVerticalDeviation1:=Value;
  ord(wdpWeaponHorizontalDeviation1):
    FHorizontalDeviation1:=Value;
  ord(wdpWeaponVerticalDeviation2):
    FVerticalDeviation2:=Value;
  ord(wdpWeaponHorizontalDeviation2):
    FHorizontalDeviation2:=Value;
  else
    inherited;
  end;
end;

procedure TShotDispersionRec.Set_Name(const Value: WideString);
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
  S:=ExtractNumber(Value);
  Val(S, D, err);
  if err=0 then
    FDistance:=D;
end;

class function TShotDispersionRec.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TShotDispersionRec.MakeFields0;
begin
  inherited;
  AddField(rsWeaponDistance, '%5.0f', '', '',
      fvtFloat, 0, 0, 0,
      ord(wdpWeaponDistance), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Still_Head, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Still_Head), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Still_Chest, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Still_Chest), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Still_Half, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Still_Half), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Still_Full, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Still_Full), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Still_Run, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Still_Run), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Run_Head, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Run_Head), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Run_Chest, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Run_Chest), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Run_Half, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Run_Half), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Run_Full, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Run_Full), 0, pkInput);
  AddField(rsCartridgeCountPerScore_Run_Run, '%d', '', '',
      fvtInteger, 1, 0, 0,
      ord(wdpCartridgeCountPerScore_Run_Run), 0, pkInput);
  AddField(rsWeaponVerticalDeviation1, '%5.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(wdpWeaponVerticalDeviation1), 0, pkInput);
  AddField(rsWeaponHorizontalDeviation1, '%5.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(wdpWeaponVerticalDeviation1), 0, pkInput);
  AddField(rsWeaponVerticalDeviation2, '%5.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(wdpWeaponVerticalDeviation1), 0, pkInput);
  AddField(rsWeaponHorizontalDeviation2, '%5.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(wdpWeaponVerticalDeviation1), 0, pkInput);
end;

function TShotDispersionRec.Get_Distance: double;
begin
  Result:=FDistance
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Still_Head: Integer;
begin
  Result:=FCartridgeCountPerScore_Still_Head
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Still_Chest: Integer;
begin
  Result:=FCartridgeCountPerScore_Still_Chest
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Still_Half: Integer;
begin
  Result:=FCartridgeCountPerScore_Still_Half
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Still_Full: Integer;
begin
  Result:=FCartridgeCountPerScore_Still_Full
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Still_Run: Integer;
begin
  Result:=FCartridgeCountPerScore_Still_Run
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Run_Head: Integer;
begin
  Result:=FCartridgeCountPerScore_Run_Head
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Run_Chest: Integer;
begin
  Result:=FCartridgeCountPerScore_Run_Chest
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Run_Half: Integer;
begin
  Result:=FCartridgeCountPerScore_Run_Half
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Run_Full: Integer;
begin
  Result:=FCartridgeCountPerScore_Run_Full
end;

function TShotDispersionRec.Get_CartridgeCountPerScore_Run_Run: Integer;
begin
  Result:=FCartridgeCountPerScore_Run_Run
end;

function TShotDispersionRec.GetScoreProbability(State, AimState:integer): Double;
var
  N:integer;
  WeaponKind:IWeaponKind;
begin
  case State of
  busShotRun, busShotNoDefence:
    case AimState of
    busShotRun:         N:=FCartridgeCountPerScore_Run_Run;
    busShotNoDefence:   N:=FCartridgeCountPerScore_Run_Full;
    busShotHalfDefence: N:=FCartridgeCountPerScore_Run_Half;
    busShotChestDefence:N:=FCartridgeCountPerScore_Run_Chest;
    busShotHeadDefence: N:=FCartridgeCountPerScore_Run_Head;
    else                N:=InfinitValue;
    end;
  else
    case AimState of
    busShotRun:         N:=FCartridgeCountPerScore_Still_Run;
    busShotNoDefence:   N:=FCartridgeCountPerScore_Still_Full;
    busShotHalfDefence: N:=FCartridgeCountPerScore_Still_Half;
    busShotChestDefence:N:=FCartridgeCountPerScore_Still_Chest;
    busShotHeadDefence: N:=FCartridgeCountPerScore_Still_Head;
    else                N:=InfinitValue;
    end;
  end;
  if (N=0) or
     (N=InfinitValue) then
    Result:=0
  else begin
    WeaponKind:=Parent as IWeaponKind;
    Result:=WeaponKind.CartridgeCountPerHit/N
  end;
end;

{ TShotDispersionRecs }

class function TShotDispersionRecs.GetElementClass: TDMElementClass;
begin
  Result:=TShotDispersionRec;
end;

function TShotDispersionRecs.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsShotDispersionRec
  else
    Result:=rsShotDispersionRecs
end;

class function TShotDispersionRecs.GetElementGUID: TGUID;
begin
  Result:=IID_IShotDispersionRec;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TShotDispersionRec.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
