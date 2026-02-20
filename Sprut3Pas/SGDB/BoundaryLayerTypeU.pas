unit BoundaryLayerTypeU;

interface
uses
  Classes, CustomModelElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TBoundaryLayerType=class(TCustomModelElementType, IBoundaryLayerType,
                           IDMClassCollections, IVisualElement)
  private
    FParents:IDMCollection;
    FSafeguardClasses:IDMCollection;

    FCategories:TList;

    FImage:Variant;
    FImage2:Variant;
    
    FAlwaysShowImage:boolean;
    FDefaultHeight:double;
    FTactics:IDMCollection;
    FIsZone:Boolean;

    FSubBoundaryKinds:IDMCollection;

    FClassCollectionIndexes:TList;

    function Get_Category(Index: integer): IDMCollection;
    function Get_ListOfClass(TypeClassID:integer): IDMCollection;

    property Category[Index:integer]:IDMCollection
           read Get_Category;
  protected
    class function  GetClassID:integer; override;

    function Get_Parents:IDMCollection; override;
    function Get_Image: IElementImage; safecall;
    function Get_Image2: IElementImage; safecall;
    function Get_AlwaysShowImage:WordBool; safecall;
    function Get_DefaultHeight:double; safecall;
    function Get_IsZone:WordBool; safecall;
    function Get_Tactics:IDMCollection; safecall;
    function Get_SubBoundaryKinds:IDMCollection; safecall;

    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class procedure MakeFields0; override;
    class function GetFields:IDMCollection; override;
    procedure  GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override; safecall;
    procedure _AddChild(const aChild:IDMElement); override;
    procedure _RemoveChild(const aChild:IDMElement); override;
    procedure Loaded; override;
    procedure Set_Parent(const Value:IDMElement); override; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function  Get_ClassCount(Mode:integer): Integer; safecall;
    function  Get_ClassCollection(Index, Mode: Integer): IDMCollection; safecall;
    function Get_DefaultClassCollectionIndex(Index, Mode: Integer): Integer; safecall;
    procedure Set_DefaultClassCollectionIndex(Index, Mode: Integer; Value: Integer); safecall;
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TBoundaryLayerTypes=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer):  WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU, SafeguardClassU;

var
  FFields:IDMCollection;

{ TBoundaryLayerType }

procedure TBoundaryLayerType.Initialize;
var
  SafeguardDatabase:ISafeguardDatabase;
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);
  FTactics:=DataModel.CreateCollection(_Tactic, SelfE);
  FSubBoundaryKinds:=DataModel.CreateCollection(_BoundaryKind, SelfE);

  SafeguardDatabase:=DataModel as ISafeguardDatabase;
  FSafeguardClasses:=TSafeguardClasses.Create(SafeguardDatabase.DataClassModel as IDMElement) as IDMCollection;

  FCategories:=TList.Create;

  FClassCollectionIndexes:=TList.Create;
end;

procedure TBoundaryLayerType._Destroy;
begin
  inherited;
  FParents:=nil;
  FTactics:=nil;
  FSubBoundaryKinds:=nil;
  FSafeguardClasses:=nil;

  FCategories.Free;
  
  FClassCollectionIndexes.Free;
end;

class function TBoundaryLayerType.GetClassID: integer;
begin
  Result:=_BoundaryLayerType
end;

function TBoundaryLayerType.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

function TBoundaryLayerType.Get_CollectionCount: integer;
begin
  Result:=ord(High(TBoundaryLayerTypeCategory))+1+FCategories.Count;
end;

function TBoundaryLayerType.Get_Collection(Index: Integer): IDMCollection;
var
  j:integer;
begin
  case TBoundaryLayerTypeCategory(Index) of
  dltcTactics:
    Result:=FTactics;
  dltcSubBoundaryKinds:
    Result:=FSubBoundaryKinds;
  dltcSafeguardClasses:
    Result:=FSafeguardClasses;
  else
    begin
      j:=Index-ord(High(TBoundaryLayerTypeCategory))-1;
      Result:=Category[j];
    end;
  end;
end;

procedure TBoundaryLayerType.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  aElements:IDMCollection;
  j:integer;
begin
  case TBoundaryLayerTypeCategory(Index) of
  dltcTactics:
    begin
      aCollectionName:=rsTactic;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelect or leoRename;
      aLinkType:=ltManyToMany;
    end;
  dltcSubBoundaryKinds:
    begin
      aCollectionName:=rsSubBoundaryKind;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelect or leoRename;
      aLinkType:=ltManyToMany;
    end;
  dltcSafeguardClasses:
    begin
      aCollectionName:=rsSafeguardClasses;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect or leoMove;
      aLinkType:=ltManyToMany;
    end;
  else
    begin
      j:=Index-ord(High(TBoundaryLayerTypeCategory))-1;
      aElements:=Category[j];

      aCollectionName:=aElements.ClassAlias[akImenitM];
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelect or leoRename;
      aLinkType:=ltManyToMany;
    end
  end;
end;

procedure TBoundaryLayerType.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  0, ord(cnstImage2):theCollection:=(DataModel as IDMElement).Collection[_ElementImage];
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
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

function TBoundaryLayerType.Get_Image: IElementImage;
var
  Unk:IUnknown;
begin
  Unk:=FImage;
  Result:=Unk as IElementImage
end;

class function TBoundaryLayerType.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TBoundaryLayerType.MakeFields0;
begin
  inherited;
  AddField(rsImage, '', '', '',
                 fvtElement, -1, 0, 0,
                 0, 0, pkView);
  AddField(rsImage2, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(cnstImage2), 0, pkView);
  AddField(rsDefaultHeight, '%0.2f', '', '',
                 fvtFloat, -1, 0, 0,
                 1, 0, pkInput);
  AddField(rsIsZone, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 2, 0, pkInput);
  AddField(rsAlwaysShowImage, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 3, 0, pkView);
end;

function TBoundaryLayerType.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  0:Result:=FImage;
  1:Result:=FDefaultHeight;
  2:Result:=FIsZone;
  3:Result:=FAlwaysShowImage;
  ord(cnstImage2):Result:=FImage2;
  else
    Result:=inherited GetFieldValue(Index)
  end;
end;

procedure TBoundaryLayerType.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  0: FImage:=Value;
  1: FDefaultHeight:=Value;
  2: FIsZone:=Value;
  3: FAlwaysShowImage:=Value;
  ord(cnstImage2): FImage2:=Value;
  else
    inherited
  end;
end;

function TBoundaryLayerType.Get_Tactics: IDMCollection;
begin
  Result:=FTactics
end;

procedure TBoundaryLayerType._AddChild(const aChild: IDMElement);
var
  SafeguardClass:ISafeguardClass;
  aCategory:IDMCollection;
begin
  if aChild.QueryInterface(ISafeguardClass, SafeguardClass)<>0 then Exit;

  aCategory:=SafeguardClass.CreateCollection;
  FCategories.Add(pointer(aCategory));
  aCategory._AddRef;
end;

procedure TBoundaryLayerType._RemoveChild(const aChild: IDMElement);
var
  SafeguardClass:ISafeguardClass;
  aCategory:IDMCollection;
begin
  if aChild.QueryInterface(ISafeguardClass, SafeguardClass)<>0 then Exit;

  aCategory:=Get_ListOfClass(SafeguardClass.TypeClassID);
  if aCategory=nil then Exit;
  (aCategory as IDMCollection2).DisconnectFrom(Self);
  FCategories.Remove(pointer(aCategory));
  aCategory._Release;
end;

function TBoundaryLayerType.Get_Category(Index: integer): IDMCollection;
begin
  Result:=IDMCollection(FCategories[Index]);
end;

function TBoundaryLayerType.Get_ClassCollection(
  Index, Mode: Integer): IDMCollection;
begin
  Result:=IDMCollection(FCategories[Index]);
end;

function TBoundaryLayerType.Get_ClassCount(Mode:integer): Integer;
begin
  Result:=FCategories.Count
end;

function TBoundaryLayerType.Get_ListOfClass(
  TypeClassID: integer): IDMCollection;
var
  j:integer;
  aCollection:IDMCollection;
begin
  Result:=nil;
  for j:=0 to FCategories.Count-1 do begin
    aCollection:=IDMCollection(Category[j]);
    if TypeClassID = (aCollection as IDMCollection2).ClassID  then begin
      Result:=aCollection;
      Exit;
    end;
  end;
end;

function TBoundaryLayerType.Get_DefaultClassCollectionIndex(
  Index, Mode: Integer): Integer;
var
  j, ClassCollectionIndexesCount:integer;
begin
  ClassCollectionIndexesCount:=FClassCollectionIndexes.Count;
  if ClassCollectionIndexesCount-1 < Index then begin
    for j:=ClassCollectionIndexesCount to Index do
      FClassCollectionIndexes.Add(pointer(-1));
    Result:=-1;
  end else
    Result:=integer(FClassCollectionIndexes[Index])
end;

procedure TBoundaryLayerType.Set_DefaultClassCollectionIndex(Index, Mode,
  Value: Integer);
var
  j, ClassCollectionIndexesCount:integer;
begin
  ClassCollectionIndexesCount:=FClassCollectionIndexes.Count;
  if ClassCollectionIndexesCount-1 < Index then
    for j:=ClassCollectionIndexesCount to Index do
      FClassCollectionIndexes.Add(pointer(-1));
  FClassCollectionIndexes[Index]:=pointer(Value);
end;

function TBoundaryLayerType.Get_DefaultHeight: double;
begin
  Result:=FDefaultHeight
end;

function TBoundaryLayerType.Get_IsZone: WordBool;
begin
  Result:=FIsZone
end;

function TBoundaryLayerType.Get_AlwaysShowImage: WordBool;
begin
  Result:=FAlwaysShowImage
end;

procedure TBoundaryLayerType.Loaded;
begin
  inherited;
  if Parent<>nil then begin
    AddParent(Parent);
    Parent:=nil;
  end;
end;

function TBoundaryLayerType.Get_SubBoundaryKinds: IDMCollection;
begin
  Result:=FSubBoundaryKinds
end;

procedure TBoundaryLayerType.Set_Parent(const Value: IDMElement);
begin
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Value=nil then Exit;
  AddParent(Value);
end;

function TBoundaryLayerType.Get_Image2: IElementImage;
var
  Unk:IUnknown;
begin
  Unk:=FImage2;
  Result:=Unk as IElementImage
end;

{ TBoundaryLayerTypes }

class function TBoundaryLayerTypes.GetElementClass: TDMElementClass;
begin
  Result:=TBoundaryLayerType;
end;

class function TBoundaryLayerTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IBoundaryLayerType;
end;

function TBoundaryLayerTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsBoundaryLayerType;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TBoundaryLayerType.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
