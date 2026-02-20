unit FacilitySubStateU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomSafeguardElementU;

type

  TFacilitySubState=class(TNamedDMElement, IFacilitySubState)
  private
    FParents:IDMCollection;
  protected
    FElementStates:IDMCollection;
    function  Get_Parents: IDMCollection; override;

    class function  GetClassID:integer; override;
    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure _AddBackRef(const Value:IDMElement); override; safecall;
    procedure _RemoveBackRef(const Value:IDMElement); override; safecall;
    procedure Clear; override; safecall;

    Function Get_ElementStates:IDMCollection; safecall;

  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TFacilitySubStates=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  FacilityModelConstU,
  ElementStateU;

{ TFacilitySubState }

procedure TFacilitySubState.Initialize;
var
 SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);
  FElementStates:=DataModel.CreateCollection(-4, SelfE);
end;

class function TFacilitySubState.GetClassID: integer;
begin
  Result:=ord(_FacilitySubState);
end;

procedure TFacilitySubState._Destroy;
begin
  inherited;
  FParents:=nil;
  FElementStates:=nil;
end;

function TFacilitySubState.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FElementStates
end;

function TFacilitySubState.Get_CollectionCount: integer;
begin
  Result:=1
end;

function TFacilitySubState.Get_Parents: IDMCollection;
begin
  Result:=FParents
end;

procedure TFacilitySubState.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  aCollectionName:=rsElementSubStates;
  aRefSource:=nil;
  aClassCollections:=nil;
  aOperations:=leoDontCopy;
  aLinkType:=ltOneToMany;
end;

procedure TFacilitySubState._AddBackRef(const Value: IDMElement);
begin
  inherited;
  if FElementStates.IndexOf(Value)=-1 then
    (FElementStates as IDMCollection2).Add(Value)
end;

procedure TFacilitySubState._RemoveBackRef(const Value: IDMElement);
var
  j:integer;
begin
  inherited;
  j:=FElementStates.IndexOf(Value);
  if j<>-1 then
    (FElementStates as IDMCollection2).Delete(j)
end;

procedure TFacilitySubState.Clear;
begin
  inherited;
end;

function TFacilitySubState.Get_ElementStates: IDMCollection;
begin
  Result:=FElementStates
end;

{ TFacilitySubStates }

function TFacilitySubStates.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsFacilitySubState
  else  
    Result:=rsFacilitySubStates;
end;

class function TFacilitySubStates.GetElementClass: TDMElementClass;
begin
  Result:=TFacilitySubState;
end;

class function TFacilitySubStates.GetElementGUID: TGUID;
begin
  Result:=IID_IFacilitySubState;
end;

end.
