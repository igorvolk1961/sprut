unit LockKindU;
{Виды замков}
interface
uses
  DelayElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TLockKind=class(TDelayElementKind, ILockKind)
  private
    FForceEc:double;
    FCriminalEc:double;
    FOpeningTime:double;
    FAccessControl:boolean;

    FTL1:double;
    FTL2:double;
    FTM1:double;
    FTM2:double;
    FTH1:double;
    FTH2:double;
  protected
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;

    function Get_ForceEc: double; safecall;
    function Get_CriminalEc: double; safecall;
    function Get_OpeningTime:double; safecall;
    function Get_AccessControl:WordBool; safecall;
  end;

  TLockKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TLockKind }

class function TLockKind.GetClassID: integer;
begin
  Result:=_LockKind
end;

function TLockKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(lkEc):
    Result:=FForceEc;
  ord(lkCriminalEc):
    Result:=FCriminalEc;
  ord(lkOpeningTime):
    Result:=FOpeningTime;
  ord(lkAccessControl):
    Result:=FAccessControl;
  ord(cnstTHL1):
    Result:=FTL1;                 //310
  ord(cnstTHL2):
    Result:=FTL2;                 //311
  ord(cnstTHM1):
    Result:=FTM1;                 //312
  ord(cnstTHM2):
    Result:=FTM2;                 //313
  ord(cnstTHH1):
    Result:=FTH1;                 //314
  ord(cnstTHH2):
    Result:=FTH2;                 //315
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TLockKind.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(lkEc):
    FForceEc:=Value;
  ord(lkCriminalEc):
    FCriminalEc:=Value;
  ord(lkOpeningTime):
    FOpeningTime:=Value;
  ord(lkAccessControl):
    FAccessControl:=Value;
  ord(cnstTHL1):
    FTL1:=Value;                 //310
  ord(cnstTHL2):
    FTL2:=Value;                 //311
  ord(cnstTHM1):
    FTM1:=Value;                 //312
  ord(cnstTHM2):
    FTM2:=Value;                 //313
  ord(cnstTHH1):
    FTH1:=Value;                 //314
  ord(cnstTHH2):
    FTH2:=Value;                 //315
  else
    inherited;
  end;
end;

class function TLockKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TLockKind.MakeFields0;
begin
  inherited;
  AddField(rsEc, '%4.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(lkEc), 0, pkInput);
  AddField(rsCriminalEc, '%4.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(lkCriminalEc), 0, pkInput);
  AddField(rsOpeningTime, '%4.0f', '', '',
                 fvtFloat, 2, 0, 0,
                 ord(lkOpeningTime), 0, pkInput);
  AddField(rsLockAccessControl, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(lkAccessControl), 0, pkInput);
  AddField(rsTL1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHL1), 0, pkInput);

  AddField(rsTL2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHL2), 0, pkInput);

  AddField(rsTM1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHM1), 0, pkInput);

  AddField(rsTM2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHM2), 0, pkInput);

  AddField(rsTH1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHH1), 0, pkInput);

  AddField(rsTH2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHH2), 0, pkInput);
end;

function TLockKind.Get_ForceEc: double;
begin
  Result:=FForceEc
end;

function TLockKind.Get_CriminalEc: double;
begin
  Result:=FCriminalEc
end;

function TLockKind.Get_OpeningTime: double;
begin
  Result:=FOpeningTime
end;

function TLockKind.Get_AccessControl: WordBool;
begin
  Result:=FAccessControl
end;

{ TLockKinds }

function TLockKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLockKind;
end;

class function TLockKinds.GetElementClass: TDMElementClass;
begin
  Result:=TLockKind;
end;

class function TLockKinds.GetElementGUID: TGUID;
begin
  Result:=IID_ILockKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TLockKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
