unit TechnicalServiceU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, FacilityModelLib_TLB;

type
  TTechnicalService=class(TNamedDMElement, ITechnicalService)
  private
    FPeriod:double;
    FControl:integer;
    FTesting:integer;
  public
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;
    function Get_Period:double; safecall;
    function Get_Control:integer; safecall;
    function Get_Testing:integer; safecall;
  end;

  TTechnicalServices=class(TDMCollection)
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

{ TTechnicalService }

class function TTechnicalService.GetClassID: integer;
begin
  Result:=_TechnicalService;
end;

function TTechnicalService.Get_Control: integer;
begin
  Result:=FControl
end;

function TTechnicalService.Get_Period: double;
begin
  Result:=FPeriod
end;

function TTechnicalService.Get_Testing: integer;
begin
  Result:=FTesting
end;

class function TTechnicalService.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TTechnicalService.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsTechnicalServicePeriod, '%0.0f', '', '',
                 fvtFloat, 90, 0, 0,
                 ord(tsPeriod), 0, pkInput);

  S:='|'+rsTechnicalServiceNoControl+
     '|'+rsTechnicalServiceGuardControl+
     '|'+rsTechnicalServiceSpecControl;
  AddField(rsTechnicalServiceControl, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(tsControl), 0, pkInput);

  S:='|'+rsTechnicalServiceNoTesting+
     '|'+rsTechnicalServiceDoTesting;
  AddField(rsTechnicalServiceTesting, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(tsTesting), 0, pkInput);
end;

function TTechnicalService.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(tsPeriod): Result:=FPeriod;
  ord(tsControl): Result:=FControl;
  ord(tsTesting): Result:=FTesting;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TTechnicalService.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(tsPeriod):  FPeriod:=Value;
  ord(tsControl): FControl:=Value;
  ord(tsTesting): FTesting:=Value;
  else
    inherited;
  end;
end;

{ TTechnicalServices }

class function TTechnicalServices.GetElementClass: TDMElementClass;
begin
  Result:=TTechnicalService;
end;


function TTechnicalServices.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsTechnicalService
end;

class function TTechnicalServices.GetElementGUID: TGUID;
begin
  Result:=IID_ITechnicalService;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TTechnicalService.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
