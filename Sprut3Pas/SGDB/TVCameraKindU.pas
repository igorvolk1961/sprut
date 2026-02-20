unit TVCameraKindU;
{Виды  телекамер  }
interface
uses
  SecurityEquipmentKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TTVCameraKind=class(TSecurityEquipmentKind, ITVCameraKind, IObserverKind)
  private
    FViewAngle:double;
    FViewLength:double;
    FObservationMethod:IOvercomeMethod;
    procedure FindObservationMethod;
  protected
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;

    procedure AfterLoading2; override; safecall;

    function Get_ViewAngle:double; safecall;
    function Get_ViewLength:double; safecall;
// IObserverKind
    function Get_ObservationMethod: IOvercomeMethod; safecall;

    procedure _Destroy; override;
  end;

  TTVCameraKinds=class(TDMCollection)
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

{ TTVCameraKind }

class function TTVCameraKind.GetClassID: integer;
begin
  Result:=_TVCameraKind
end;

class function TTVCameraKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TTVCameraKind.MakeFields0;
begin
  inherited;
  AddField(rsViewAngle, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(tvViewAngle), 0, pkInput);
  AddField(rsViewLength, '%0.1f', '', '',
           fvtFloat, 0, 0, 0,
           ord(tvViewLength), 0, pkInput);
end;

function TTVCameraKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(tvViewAngle):
    Result:=FViewAngle;
  ord(tvViewLength):
    Result:=FViewLength;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TTVCameraKind.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(tvViewAngle):
    FViewAngle:=Value;
  ord(tvViewLength):
    FViewLength:=Value;
  else
    inherited;
  end;
end;

function TTVCameraKind.Get_ViewAngle: double;
begin
  Result:=FViewAngle
end;

function TTVCameraKind.Get_ViewLength: double;
begin
  Result:=FViewLength
end;

procedure TTVCameraKind._Destroy;
begin
  inherited;
  FObservationMethod:=nil
end;

procedure TTVCameraKind.FindObservationMethod;
var
  SafeguardElementType:ISafeguardElementType;
  j:integer;
  OvercomeMethod:IOvercomeMethod;
begin
  SafeguardElementType:=Parent as ISafeguardElementType;
  j:=0;
  OvercomeMethod:=nil;
  while j<SafeguardElementType.OvercomeMethods.Count do begin
    OvercomeMethod:=SafeguardElementType.OvercomeMethods.Item[j] as IOvercomeMethod;
    if OvercomeMethod.ObserverParam then
      Break
    else
      inc(j)
  end;
  if j<SafeguardElementType.OvercomeMethods.Count then
    FObservationMethod:=OvercomeMethod
end;

function TTVCameraKind.Get_ObservationMethod: IOvercomeMethod;
begin
  Result:=FObservationMethod
end;

procedure TTVCameraKind.AfterLoading2;
begin
  inherited;
  FindObservationMethod;
end;

{ TTVCameraKinds }

function TTVCameraKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsTVCameraKind;
end;

class function TTVCameraKinds.GetElementClass: TDMElementClass;
begin
  Result:=TTVCameraKind;
end;

class function TTVCameraKinds.GetElementGUID: TGUID;
begin
  Result:=IID_ITVCameraKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TTVCameraKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
