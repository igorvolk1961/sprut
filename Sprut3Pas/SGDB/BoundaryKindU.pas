unit BoundaryKindU;

interface
uses
  FacilityElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TBoundaryKind=class(TFacilityElementKind, IBoundaryKind, IBoundaryKind2)
  private
    FParents:IDMCollection;
    FBoundaryLayerTypes:IDMCollection;
    FPathKind:integer;
    FHighPath:boolean;                       
    FDontCross:boolean;
    FOrientation:integer;
    FDefaultBottomEdgeHeight:double;
    FLayerKind:integer;
  protected
    function Get_Parents:IDMCollection; override; safecall;

    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;

    function Get_BoundaryLayerTypes:IDMCollection; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function Get_PathKind:integer; safecall;
    function Get_HighPath:WordBool; safecall;
    function Get_DontCross:WordBool; safecall;
    function Get_Orientation:integer; safecall;
    function Get_DefaultBottomEdgeHeight:double; safecall;
    function Get_LayerKind:integer; safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TBoundaryKinds=class(TDMCollection)
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
  
{ TBoundaryKind }

procedure TBoundaryKind.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);
  FBoundaryLayerTypes:=DataModel.CreateCollection(_BoundaryLayerType, SelfE);
end;

procedure TBoundaryKind._Destroy;
begin
  inherited;
  FParents:=nil;
  FBoundaryLayerTypes:=nil
end;

class function TBoundaryKind.GetClassID: integer;
begin
  Result:=_BoundaryKind
end;

function TBoundaryKind.Get_CollectionCount: integer;
begin
  Result:=ord(High(TBoundaryKindCategory))+1;
end;

function TBoundaryKind.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

function TBoundaryKind.Get_Collection(Index: Integer): IDMCollection;
begin
  case TBoundaryKindCategory(Index) of
  zbkcBoundaryLayerTypes:
    Result:=FBoundaryLayerTypes;
  else
    Result:=inherited Get_Collection(Index);
  end;
end;

procedure TBoundaryKind.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case TBoundaryKindCategory(Index) of
  zbkcBoundaryLayerTypes:
    begin
      aCollectionName:=rsBoundaryLayerTypes;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelect or leoRename or leoMove;
      aLinkType:=ltManyToMany;
    end;
  else
    inherited;
  end;
end;

function TBoundaryKind.Get_BoundaryLayerTypes: IDMCollection;
begin
  Result:=FBoundaryLayerTypes
end;

class function TBoundaryKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TBoundaryKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  1: Result:=FPathKind;
  2: Result:=FHighPath;
  3: Result:=FDontCross;
  4: Result:=FOrientation;
  5: Result:=FDefaultBottomEdgeHeight;
  6: Result:=FLayerKind;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TBoundaryKind.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  1: FPathKind:=Value;
  2: FHighPath:=Value;
  3: FDontCross:=Value;
  4: FOrientation:=Value;
  5: FDefaultBottomEdgeHeight:=Value;
  6: FLayerKind:=Value;
  else
    inherited
  end;
end;

class procedure TBoundaryKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsVOne+
     '|'+rsVMany+
     '|'+rsHOne+
     '|'+rsHMany;
  AddField(rsPathKind, S, '', '',
                 fvtChoice, 0, 0, 0,
                 1, 0, pkInput);
  AddField(rsHighPath, '', '', '',
                 fvtBoolean, 1, 0, 0,
                 2, 0, pkInput);
  AddField(rsDontCross, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 3, 0, pkInput);
  S:='|'+rsAny+
     '|'+rsVertical+
     '|'+rsNotVertical+
     '|'+rsNone;
  AddField(rsOrientation, S, '', '',
                 fvtChoice, 0, 0, 0,
                 4, 0, pkInput);
  AddField(rsDefaultBottomEdgeHeight, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 5, 0, pkInput);
  S:='|'+rsVirtual+
     '|'+rsHidden+
     '|'+rsWall+
     '|'+rsDoor+
     '|'+rsWindow+
     '|'+rsFencil;
  AddField(rsLayerKind, S, '', '',
                 fvtChoice, -1, 0, 0,
                 6, 0, pkInput);
end;

function TBoundaryKind.Get_PathKind: integer;
begin
  Result:=FPathKind
end;

function TBoundaryKind.Get_HighPath: WordBool;
begin
  Result:=FHighPath
end;

function TBoundaryKind.Get_DontCross: WordBool;
begin
  Result:=FDontCross
end;

function TBoundaryKind.Get_Orientation: integer;
begin
  Result:=FOrientation
end;

function TBoundaryKind.Get_DefaultBottomEdgeHeight: double;
begin
  Result:=FDefaultBottomEdgeHeight;
end;

function TBoundaryKind.Get_LayerKind: integer;
begin
  Result:=FLayerKind
end;

{ TBoundaryKinds }

class function TBoundaryKinds.GetElementClass: TDMElementClass;
begin
  Result:=TBoundaryKind;
end;

class function TBoundaryKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IBoundaryKind;
end;

function TBoundaryKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsBoundaryKind;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TBoundaryKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
