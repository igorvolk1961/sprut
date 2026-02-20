unit FacilityStateU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type

  TFacilityState=class(TNamedDMElement, IFacilityState)
  private
    FParents: IDMCollection;
    FGraphIndex:integer;
    FSubStates:IDMCollection;
    FModificationStage:integer;
    FKind:integer;
  protected
    class procedure MakeFields0; override;

    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;

    function  Get_Parents: IDMCollection; override; safecall;

    function Get_ModificationStage:integer; safecall;
    procedure Set_ModificationStage(Value:integer); safecall;
    function  Get_SubStateCount: integer; safecall;
    function  Get_SubState(Index:integer): IDMElement; safecall;
    procedure AddSubState(const aSubState:IDMElement); safecall;
    procedure RemoveSubState(const aSubState:IDMElement); safecall;
    function  Get_GraphIndex: Integer; safecall;
    procedure Set_GraphIndex(Value: Integer); safecall;
    function  Get_Kind:integer; safecall;
    procedure Set_Kind(Value:integer); safecall;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TFacilityStates=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  FacilityModelConstU, FacilitySubStateU;

var
  FFields:IDMCollection;

{ TFacilityState }

class function TFacilityState.GetClassID: integer;
begin
  Result:=_FacilityState;
end;

function TFacilityState.Get_GraphIndex: Integer;
begin
  Result:=FGraphIndex
end;

procedure TFacilityState.Set_GraphIndex(Value: Integer);
begin
  FGraphIndex:=Value
end;

procedure TFacilityState.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);
  FSubStates:=DataModel.CreateCollection(_FacilitySubState, SelfE);
end;

procedure TFacilityState._Destroy;
begin
  inherited;
  FSubStates:=nil;
end;

function TFacilityState.Get_CollectionCount: integer;
begin
  Result:=1
end;

function TFacilityState.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FSubStates
end;

procedure TFacilityState.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  aCollectionName:=rsFacilitySubStates;
  aRefSource:=nil;
  aClassCollections:=nil;
  aOperations:=leoAdd or leoSelect or leoRename;
  aLinkType:=ltManyToMany;
end;

class function TFacilityState.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TFacilityState.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  0:Result:=FModificationStage;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TFacilityState.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  0: FModificationStage:=Value;
  else
    inherited
  end;
end;

class procedure TFacilityState.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+'Исходное состояние'+
     '|'+'1-я очередь модернизации'+
     '|'+'2-я очередь модернизации'+
     '|'+'3-я очередь модернизации';
  AddField(rsModificationStage, S, '', '',
                 fvtChoice, 0, 0, 0,
                 0,0, pkInput);
end;

function TFacilityState.Get_Parents: IDMCollection;
begin
  Result:=FParents
end;

function TFacilityState.Get_ModificationStage: integer;
begin
 Result:=FModificationStage
end;

procedure TFacilityState.Set_ModificationStage(Value: integer);
begin
  FModificationStage:=Value
end;

function TFacilityState.Get_Kind: integer;
begin
  Result:=FKind
end;

procedure TFacilityState.Set_Kind(Value: integer);
begin
  FKind:=Value
end;

function TFacilityState.Get_SubState(Index:integer): IDMElement;
begin
  Result:=FSubStates.Item[Index]
end;

function TFacilityState.Get_SubStateCount: integer;
begin
  Result:=FSubStates.Count
end;

procedure TFacilityState.AddSubState(const aSubState: IDMElement);
var
  j:integer;
begin
  j:=FSubStates.IndexOf(aSubState);
  if j=-1 then
    (FSubStates as IDMCollection2).Add(aSubState)
end;

procedure TFacilityState.RemoveSubState(const aSubState: IDMElement);
var
  j:integer;
begin
  j:=FSubStates.IndexOf(aSubState);
  if j<>1 then
    (FSubStates as IDMCollection2).Delete(j)
end;

{ TFacilityStates }

class function TFacilityStates.GetElementClass: TDMElementClass;
begin
  Result:=TFacilityState;
end;

function TFacilityStates.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsFacilityState
  else  
    Result:=rsFacilityStates;
end;

class function TFacilityStates.GetElementGUID: TGUID;
begin
  Result:=IID_IFacilityState;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TFacilityState.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
