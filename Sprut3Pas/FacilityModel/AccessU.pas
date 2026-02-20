unit AccessU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TAccess=class(TDMElement, IAccess)
  private
    FAccessType:integer;
    FAccessRegion:integer;
    FFacilityStates:IDMCollection;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function GetFieldValue(Index: integer): OleVariant; override;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override;
    class procedure MakeFields0; override;

    procedure Set_Parent(const Value:IDMElement); override;

    function  Get_AccessType: Integer; safecall;
    function  Get_AccessRegion: Integer; safecall;
    function  Get_FacilityStates:IDMCollection; safecall;

    function  Get_CollectionCount: Integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TAccesses=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  FacilityStateU;

var
  FFields:IDMCollection;

{ TAccess }

class function TAccess.GetClassID: integer;
begin
  Result:=_Access;
end;

procedure TAccess._Destroy;
begin
  inherited;
  FFacilityStates:=nil;
end;

procedure TAccess.Initialize;
begin
  inherited;
  FFacilityStates:=TFacilityStates.Create(Self as IDMElement) as  IDMCollection;
end;

class function TAccess.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TAccess.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsLimitedAccess+
     '|'+rsFullAccess;
  AddField(rsAccessType, S, '', '',
                 fvtChoice, 1, 0, 0,
                 0, 0, pkInput);
  S:='|'+rsAllInnerZones+
     '|'+rsEqualInnerZones;
  AddField(rsAccessRegion, S, '', '',
                 fvtChoice, 1, 0, 0,
                 1, 0, pkInput);
end;

function TAccess.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  0: Result:=FAccessType;
  1: Result:=FAccessRegion;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TAccess.SetFieldValue(Index: integer; Value: OleVariant);
begin
  case Index of
  0: FAccessType:=Value;
  1: FAccessRegion:=Value;
  else
    inherited;
  end;
end;

function TAccess.Get_AccessType: Integer;
begin
  Result:=FAccessType
end;

function TAccess.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FFacilityStates
end;

function TAccess.Get_CollectionCount: Integer;
begin
  Result:=1
end;

procedure TAccess.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
//      aRefSource:=(DataModel as IFacilityModel).FacilityStates;
      aRefSource:=nil;
      aCollectionName:=rsAccessTimes;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
end;

function TAccess.Get_FacilityStates: IDMCollection;
begin
  Result:=FFacilityStates
end;

procedure TAccess.Set_Parent(const Value: IDMElement);
var
  AdversaryVariant:IAdversaryVariant;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IAdversaryVariant,AdversaryVariant)=0)  then
    Set_Parent(AdversaryVariant.AdversaryGroups.Item[0])
  else
    inherited;
end;

function TAccess.Get_AccessRegion: Integer;
begin
  Result:=FAccessRegion
end;

{ TAccesses }

class function TAccesses.GetElementClass: TDMElementClass;
begin
  Result:=TAccess;
end;


function TAccesses.Get_ClassAlias(Index: integer): WideString;
begin
    Result:=rsAccess
end;

class function TAccesses.GetElementGUID: TGUID;
begin
  Result:=IID_IAccess;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TAccess.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
