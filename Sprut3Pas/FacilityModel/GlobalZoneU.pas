unit GlobalZoneU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  ZoneU;

type
  TGlobalZone=class(TZone, IGlobalZone)
  private
    FRoads:IDMCollection;
    FCabels:IDMCollection;
    FFacilityStates:IDMCollection;
  protected
    class function  GetClassID:integer; override;
    procedure Set_SpatialElement(const Element:IDMElement); override;

    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class procedure MakeFields0; override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    procedure Clear; override;

    function Get_LargestZone:IDMElement; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TGlobalZones=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  RoadU, CabelU, FacilityStateU;

var
  FFields:IDMCollection;

{ TGlobalZone }

class function TGlobalZone.GetClassID: integer;
begin
  Result:=_GlobalZone;
end;

function TGlobalZone.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:Result:=FZones;
  1:Result:=FJumps;
  2:Result:=FRoads;
  3:Result:=FCabels;
  4:Result:=FFacilityStates;
  else
    Result:=Get_Collection(Index)
  end;
end;

function TGlobalZone.Get_CollectionCount: integer;
begin
  Result:=5
end;

procedure TGlobalZone.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:inherited GetCollectionProperties(1, // Zones
      aCollectionName, aRefSource, aClassCollections, aOperations, aLinkType);
  1:inherited GetCollectionProperties(5, // Jumps
      aCollectionName, aRefSource, aClassCollections, aOperations, aLinkType);
  2:begin
      aCollectionName:=rsRoads;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoDelete or leoRename;
      aLinkType:=ltOneToMany;
    end;
  3:begin
      aCollectionName:=rsCabels;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoDelete or leoRename;
      aLinkType:=ltOneToMany;
    end;
  4:begin
      aCollectionName:=rsFacilityStates;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoDelete or leoRename or leoMove;
      aLinkType:=ltOneToMany;
    end;
  end;
end;

destructor TGlobalZone.Destroy;
begin
  inherited;
  FRoads:=nil;
  FCabels:=nil;
  FFacilityStates:=nil;
end;

procedure TGlobalZone.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FRoads:=DataModel.CreateCollection(_Road, SelfE);
  FCabels:=DataModel.CreateCollection(_Cabel, SelfE);
  FFacilityStates:=DataModel.CreateCollection(_FacilityState, SelfE);
end;

procedure TGlobalZone.Set_SpatialElement(const Element: IDMElement);
begin
  inherited;

end;

procedure TGlobalZone.Clear;
begin
  if SpatialElement<>nil then
    SpatialElement.Clear;
  inherited;
end;

function TGlobalZone.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(gzpLargestZone):
    Result:=True;
  else
    Result:=False;
  end;
end;

function TGlobalZone.Get_LargestZone: IDMElement;
var
  GuardVariant:IGuardVariant;
  DataModelE:IDMElement;
begin
  DataModelE:=DataModel as IDMElement;
  GuardVariant:=DataModelE.Collection[_GuardVariant].Item[0] as IGuardVariant;
  Result:=GuardVariant.LargestZone
end;

procedure TGlobalZone.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
begin
      inherited;
end;

class procedure TGlobalZone.MakeFields0;
begin
  inherited;
end;

function TGlobalZone.GetFieldValue(Code: integer): OleVariant;
begin
    Result:=inherited GetFieldValue(Code)
end;

procedure TGlobalZone.SetFieldValue(Code: integer; Value: OleVariant);
begin
    inherited;
end;

class function TGlobalZone.GetFields: IDMCollection;
begin
  Result:=FFields
end;

{ TGlobalZones }

class function TGlobalZones.GetElementClass: TDMElementClass;
begin
  Result:=TGlobalZone;
end;


function TGlobalZones.Get_ClassAlias(Index: integer): WideString;
begin
    Result:=rsFacilityEnviroments
end;

class function TGlobalZones.GetElementGUID: TGUID;
begin
  Result:=IID_IGlobalZone;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TGlobalZone.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
