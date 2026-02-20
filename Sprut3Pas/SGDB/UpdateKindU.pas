unit UpdateKindU;

interface
uses
  SysUtils,
  ModelElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type

  TUpdateKind=class(TNamedDMElement, IUpdateKind)
  private
    //FParents:IDMCollection;

    FOldRefID:integer;
    FNewRefID:integer;

  protected
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    class function  GetClassID:integer; override;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function Get_OldRefID: integer; safecall;
    function Get_NewRefID: integer; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TUpdateKinds=class(TDMCollection)
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

{ TUpdateKind }

procedure TUpdateKind.Initialize;
begin
  inherited;
end;

procedure TUpdateKind._Destroy;
begin
  inherited;
//  FShotDispersionRecs:=nil;
end;

class function TUpdateKind.GetClassID: integer;
begin
  Result:=_UpdateKind
end;


function TUpdateKind.Get_CollectionCount: integer;
begin
  Result:=1;
end;

function TUpdateKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(uOldRefElement):
    Result:=FOldRefID;
  ord(uNewRefElement):
    Result:=FNewRefID;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TUpdateKind.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(uOldRefElement):
    FOldRefID:=Value;
  ord(uNewRefElement):
    FNewRefID:=Value;
  else
    inherited;
  end;
end;

class function TUpdateKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TUpdateKind.MakeFields0;
//var
//  S:WideString;
begin
  inherited;
  AddField(rsUpdateOldRef, '%d', '', '',
             fvtInteger, 0, 0, 0,
             ord(uOldRefElement), 0, pkInput);
  AddField(rsUpdateNewRef, '%d', '', '',
             fvtInteger, 0, 0, 0,
             ord(uNewRefElement), 0, pkInput);
end;


{
procedure TUpdateKind.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  aCollectionName:=FShotDispersionRecs.ClassAlias[akImenitM];
  aOperations:=leoAdd or leoDelete or leoRename;
  aRefSource:=nil;
  aClassCollections:=nil;
  aLinkType:=ltOneToMany;
end;

function  TUpdateKind.GetScoreProbability(Distance: double; State: Integer; AimState: Integer): Double;
var
  ShotDispersionRec0, ShotDispersionRec1:IShotDispersionRec;
  D0, D1, P0, P1:double;
  j:integer;
begin
  if Distance=0 then
    Result:=1
  else if Distance>FMaxShotDistance*100 then
    Result:=0
  else
  if FShotDispersionRecs.Count<2 then begin
    if Distance<=FPreciseShotDistance*100 then
      Result:=1
    else
      Result:=1-(Distance-FPreciseShotDistance*100)/(FMaxShotDistance*100-FPreciseShotDistance*100);
    if State=busShotRun then
      Result:=0.5*Result;

    case AimState of
    busShotHalfDefence:
      Result:=0.5*Result;
    busShotChestDefence:
      Result:=0.25*Result;
    busShotHeadDefence:
      Result:=0.1*Result;
    busShotRun:
      Result:=0.5*Result;
    busHide:
      Result:=0;
    end;

  end else begin
    D1:=0;
    j:=0;
    while j<FShotDispersionRecs.Count do begin
      ShotDispersionRec1:=FShotDispersionRecs.Item[j] as IShotDispersionRec;
      D1:=ShotDispersionRec1.Distance*100;
      if Distance<D1 then
        Break
      else begin
        inc(j);
        if j<FShotDispersionRecs.Count then
          ShotDispersionRec0:=ShotDispersionRec1;
      end;
    end;
    P1:=ShotDispersionRec1.GetScoreProbability(State, AimState);
    if j=0 then begin
      D0:=0;
      P0:=1;
    end else begin
      D0:=ShotDispersionRec0.Distance*100;
      P0:=ShotDispersionRec0.GetScoreProbability(State, AimState);
    end;
    Result:=P0+(P1-P0)*(Distance-D0)/(D1-D0);
    if Result<0 then
      Result:=0;
  end;
end;
}

procedure TUpdateKind.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;

end;

function TUpdateKind.Get_NewRefID: integer;
begin
  Result:=FNewRefID
end;

function TUpdateKind.Get_OldRefID: integer;
begin
  Result:=FOldRefID
end;

function TUpdateKind.Get_Collection(Index: Integer): IDMCollection;
begin

end;

{ TUpdateKinds }

class function TUpdateKinds.GetElementClass: TDMElementClass;
begin
  Result:=TUpdateKind;
end;

class function TUpdateKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IUpdateKind;
end;

function TUpdateKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsUpdateKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TUpdateKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
