unit SurfaceSensorKindU;
{Виды поверхностных средств обнаружения}
interface
uses
  DetectionElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TSurfaceSensorKind=class(TDetectionElementKind, ISurfaceSensorKind)
  private
    FContactSensible:boolean;
  protected
    class function  GetClassID:integer; override;

    function  GetFieldValue(Index: integer): OleVariant; override;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function Get_ContactSensible:WordBool; safecall;
  end;

  TSurfaceSensorKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID: TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;
  
var
  FFields:IDMCollection;

{ TSurfaceSensorKind }

class function TSurfaceSensorKind.GetClassID: integer;
begin
  Result:=_SurfaceSensorKind
end;

class function TSurfaceSensorKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TSurfaceSensorKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(sskContactSensible):
    Result:=FContactSensible;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

function TSurfaceSensorKind.Get_ContactSensible: WordBool;
begin
  Result:=FContactSensible
end;

class procedure TSurfaceSensorKind.MakeFields0;
begin
  inherited;
  AddField(rsContactSensible, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(sskContactSensible), 0, pkInput);
end;

procedure TSurfaceSensorKind.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(sskContactSensible):
    FContactSensible:=Value;
  else
    inherited;
  end;
end;

{ TSurfaceSensorKinds }

class function TSurfaceSensorKinds.GetElementClass: TDMElementClass;
begin
  Result:=TSurfaceSensorKind;
end;

class function TSurfaceSensorKinds.GetElementGUID: TGUID;
begin
  Result:=IID_ISurfaceSensorKind;
end;

function TSurfaceSensorKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSurfaceSensorKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TSurfaceSensorKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
