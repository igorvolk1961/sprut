unit BarrierKindU;
{Виды барьеров}
interface
uses
  DelayElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TBarrierKind=class(TDelayElementKind, IBarrierKind, ILockKind)
  private
    FEc:double;

    FTHL1:double;
    FTHL2:double;
    FTHM1:double;
    FTHM2:double;
    FTHH1:double;
    FTHH2:double;

    FTDL1:double;
    FTDL2:double;
    FTDM1:double;
    FTDM2:double;
    FTDH1:double;
    FTDH2:double;

    FTEL1:double;
    FTEL2:double;
    FTEM1:double;
    FTEM2:double;
    FTEH1:double;
    FTEH2:double;

    FTSL1:double;
    FTSL2:double;
    FTSM1:double;
    FTSM2:double;
    FTSH1:double;
    FTSH2:double;

    FTNorm:double;

    FIsTransparent:boolean;
    FSoundResistance:double;
    FIsFragile:boolean;
    FDefaultWidth:double;
    FContainLock:boolean;
    FUseElevation:boolean;
    FTexture:Variant;
  protected
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code:Integer; var aCollection: IDMCollection); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;
    function Get_Ec: double; safecall;
    function Get_IsTransparent: WordBool; safecall;
    function Get_IsFragile: WordBool; safecall;
    function Get_SoundResistance:double; safecall;
    function Get_DefaultWidth:double; safecall;
    function Get_ContainLock: WordBool; safecall;
    function Get_UseElevation: WordBool; safecall;
    function Get_Texture:ITexture; safecall;

//ILock

    function Get_ForceEc: Double; safecall;
    function Get_CriminalEc: Double; safecall;
    function Get_OpeningTime: Double; safecall;
    function Get_AccessControl: WordBool; safecall;
  end;

  TBarrierKinds=class(TDMCollection)
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

{ TBarrierKind }

class function TBarrierKind.GetClassID: integer;
begin
  Result:=_BarrierKind
end;

function TBarrierKind.Get_IsTransparent: WordBool;
begin
  Result:=FIsTransparent
end;

function TBarrierKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  -1:
    Result:=InfinitValue;
  ord(bkEc):
    Result:=FEc;
  ord(bkTransparent):
    Result:=FIsTransparent;
  ord(bkFragile):
    Result:=FIsFragile;
  ord(bkSoundResistance):
    Result:=FSoundResistance;
  ord(bkDefaultWidth):
    Result:=FDefaultWidth;
  ord(bkContainLock):
    Result:=FContainLock;
  ord(bkUseElevation):
    Result:=FUseElevation;
  ord(bkTexture):
    Result:=FTexture;
  ord(cnstTHL1):
    Result:=FTHL1;                 //310
  ord(cnstTHL2):
    Result:=FTHL2;                 //311
  ord(cnstTHM1):
    Result:=FTHM1;                 //312
  ord(cnstTHM2):
    Result:=FTHM2;                 //313
  ord(cnstTHH1):
    Result:=FTHH1;                 //314
  ord(cnstTHH2):
    Result:=FTHH2;                 //315
  ord(cnstTDL1):
    Result:=FTDL1;                 //316
  ord(cnstTDL2):
    Result:=FTDL2;                 //317
  ord(cnstTDM1):
    Result:=FTDM1;                 //318
  ord(cnstTDM2):
    Result:=FTDM2;                 //319
  ord(cnstTDH1):
    Result:=FTDH1;                 //320
  ord(cnstTDH2):
    Result:=FTDH2;                 //321
  ord(cnstTEL1):
    Result:=FTEL1;                 //322
  ord(cnstTEL2):
    Result:=FTEL2;                 //323
  ord(cnstTEM1):
    Result:=FTEM1;                 //324
  ord(cnstTEM2):
    Result:=FTEM2;                 //325
  ord(cnstTEH1):
    Result:=FTEH1;                 //326
  ord(cnstTEH2):
    Result:=FTEH2;                 //327
  ord(cnstTSL1):
    Result:=FTSL1;                 //328
  ord(cnstTSL2):
    Result:=FTSL2;                 //329
  ord(cnstTSM1):
    Result:=FTSM1;                 //330
  ord(cnstTSM2):
    Result:=FTSM2;                 //331
  ord(cnstTSH1):
    Result:=FTSH1;                 //332
  ord(cnstTSH2):
    Result:=FTSH2;                 //333
  ord(cnstTNorm):
    Result:=FTNorm;                 //334
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TBarrierKind.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(bkEc):
    FEc:=Value;
  ord(bkTransparent):
    FIsTransparent:=Value;
  ord(bkFragile):
    FIsFragile:=Value;
  ord(bkSoundResistance):
    FSoundResistance:=Value;
  ord(bkDefaultWidth):
    FDefaultWidth:=Value;
  ord(bkContainLock):
    FContainLock:=Value;
  ord(bkUseElevation):
    FUseElevation:=Value;
  ord(bkTexture):
    FTexture:=Value;
  ord(cnstTHL1):
    FTHL1:=Value;                 //310
  ord(cnstTHL2):
    FTHL2:=Value;                 //311
  ord(cnstTHM1):
    FTHM1:=Value;                 //312
  ord(cnstTHM2):
    FTHM2:=Value;                 //313
  ord(cnstTHH1):
    FTHH1:=Value;                 //314
  ord(cnstTHH2):
    FTHH2:=Value;                 //315
  ord(cnstTDL1):
    FTDL1:=Value;                 //316
  ord(cnstTDL2):
    FTDL2:=Value;                 //317
  ord(cnstTDM1):
    FTDM1:=Value;                 //318
  ord(cnstTDM2):
    FTDM2:=Value;                 //319
  ord(cnstTDH1):
    FTDH1:=Value;                 //320
  ord(cnstTDH2):
    FTDH2:=Value;                 //321
  ord(cnstTEL1):
    FTEL1:=Value;                 //322
  ord(cnstTEL2):
    FTEL2:=Value;                 //323
  ord(cnstTEM1):
    FTEM1:=Value;                 //324
  ord(cnstTEM2):
    FTEM2:=Value;                 //325
  ord(cnstTEH1):
    FTEH1:=Value;                 //326
  ord(cnstTEH2):
    FTEH2:=Value;                 //327
  ord(cnstTSL1):
    FTSL1:=Value;                 //328
  ord(cnstTSL2):
    FTSL2:=Value;                 //329
  ord(cnstTSM1):
    FTSM1:=Value;                 //330
  ord(cnstTSM2):
    FTSM2:=Value;                 //331
  ord(cnstTSH1):
    FTSH1:=Value;                 //332
  ord(cnstTSH2):
    FTSH2:=Value;                 //333
  ord(cnstTNorm):
    FTNorm:=Value;                 //334
  else
    inherited;
  end;
end;

class function TBarrierKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TBarrierKind.MakeFields0;
begin
  inherited;
  AddField(rsEc, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bkEc), 0, pkInput);
  AddField(rsTransparent, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(bkTransparent), 0, pkInput);
  AddField(rsFragile, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(bkFragile), 0, pkInput);
  AddField(rsSoundResistance, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bkSoundResistance), 0, pkInput);
  AddField(rsDefaultWidth, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(bkDefaultWidth), 0, pkInput);
  AddField(rsContainLock, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(bkContainLock), 0, pkInput);
  AddField(rsUseElevation, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(bkUseElevation), 0, pkInput);
  AddField(rsTexture, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(bkTexture), 0, pkView);

  AddField(rsTHL1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHL1), 0, pkInput);

  AddField(rsTHL2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHL2), 0, pkInput);

  AddField(rsTHM1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHM1), 0, pkInput);

  AddField(rsTHM2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHM2), 0, pkInput);

  AddField(rsTHH1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHH1), 0, pkInput);

  AddField(rsTHH2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTHH2), 0, pkInput);

  AddField(rsTDL1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTDL1), 0, pkInput);

  AddField(rsTDL2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTDL2), 0, pkInput);

  AddField(rsTDM1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTDM1), 0, pkInput);

  AddField(rsTDM2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTDM2), 0, pkInput);

  AddField(rsTDH1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTDH1), 0, pkInput);

  AddField(rsTDH2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTDH2), 0, pkInput);

  AddField(rsTEL1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTEL1), 0, pkInput);

  AddField(rsTEL2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTEL2), 0, pkInput);

  AddField(rsTEM1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTEM1), 0, pkInput);

  AddField(rsTEM2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTEM2), 0, pkInput);

  AddField(rsTEH1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTEH1), 0, pkInput);

  AddField(rsTEH2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTEH2), 0, pkInput);

  AddField(rsTSL1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTSL1), 0, pkInput);

  AddField(rsTSL2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTSL2), 0, pkInput);

  AddField(rsTSM1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTSM1), 0, pkInput);

  AddField(rsTSM2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTSM2), 0, pkInput);

  AddField(rsTSH1, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTSH1), 0, pkInput);

  AddField(rsTSH2, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTSH2), 0, pkInput);

  AddField(rsTNorm, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstTNorm), 0, pkInput);

end;

function TBarrierKind.Get_Ec: double;
begin
  Result:=FEc
end;

function TBarrierKind.Get_SoundResistance: double;
begin
  Result:=FSoundResistance
end;

function TBarrierKind.Get_IsFragile: WordBool;
begin
  Result:=FIsFragile
end;

function TBarrierKind.Get_DefaultWidth: double;
begin
  Result:=FDefaultWidth
end;

function TBarrierKind.Get_ContainLock: WordBool;
begin
  Result:=FContainLock
end;

function TBarrierKind.Get_UseElevation: WordBool;
begin
  Result:=FUseElevation
end;

function TBarrierKind.Get_AccessControl: WordBool;
begin
  Result:=False
end;

function TBarrierKind.Get_CriminalEc: Double;
begin
  Result:=FEc
end;

function TBarrierKind.Get_ForceEc: Double;
begin
  Result:=FEc
end;

function TBarrierKind.Get_OpeningTime: Double;
begin
  Result:=GetFieldValue(104);
end;

function TBarrierKind.Get_Texture: ITexture;
var
  unk:IUnknown;
begin
  unk:=FTexture;
  Result:=unk as ITexture;
end;

procedure TBarrierKind.GetFieldValueSource(Code: Integer;
  var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(bkTexture):
    theCollection:=(DataModel as IDMElement).Collection[_Texture];
  else
    begin
      inherited;
      Exit;
    end;
  end;
  if aCollection=nil then
    aCollection:=theCollection
  else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;
    if theCollection=nil then Exit;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

{ TBarrierKinds }

class function TBarrierKinds.GetElementClass: TDMElementClass;
begin
  Result:=TBarrierKind;
end;

class function TBarrierKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IBarrierKind;
end;

function TBarrierKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsBarrierKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TBarrierKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
