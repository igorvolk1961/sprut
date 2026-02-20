unit ZoneTypeU;

interface
uses
  Classes,
  FacilityElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TZoneType=class(TFacilityElementType, IZoneType,
                 IDMClassCollections)
  private
    FSafeguardClasses:IDMCollection;

    FNoneSpatialCategories:TList;
    FPointCategories:TList;
    FLineCategories:TList;

    FNoneSpatialClassCollectionIndexes:TList;
    FPointClassCollectionIndexes:TList;
    FLineClassCollectionIndexes:TList;

    function Get_ListOfClass(TypeClassID:integer): IDMCollection;

  protected
    class function GetFields:IDMCollection; override;
    procedure _AddChild(const aChild:IDMElement); override;
    procedure _RemoveChild(const aChild:IDMElement); override;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    class function  GetClassID:integer; override;
    function  Get_ClassCount(Mode:integer): Integer; safecall;
    function  Get_ClassCollection(Index, Mode: Integer): IDMCollection; safecall;
    function Get_DefaultClassCollectionIndex(Index, Mode: Integer): Integer; safecall;
    procedure Set_DefaultClassCollectionIndex(Index, Mode: Integer; Value: Integer); safecall;

    procedure  Initialize; override;
    procedure  _Destroy; override;
  end;

  TZoneTypes=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
  end;

implementation

uses
  SafeguardDatabaseConstU, ZoneKindU, SafeguardElementTypeU,
  SafeguardClassU;

var
  FFields:IDMCollection;

{ TZoneType }

procedure TZoneType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_ZoneKind, Self as IDMElement);
  FSafeguardClasses:=TSafeguardClasses.Create((DataModel as ISafeguardDatabase).DataClassModel as IDMElement);
  FPointCategories:=TList.Create;
  FLineCategories:=TList.Create;
  FNoneSpatialCategories:=TList.Create;

  FNoneSpatialClassCollectionIndexes:=TList.Create;
  FPointClassCollectionIndexes:=TList.Create;
  FLineClassCollectionIndexes:=TList.Create;
end;

procedure TZoneType._Destroy;
begin
  inherited;
  FSafeguardClasses:=nil;
  FPointCategories.Free;
  FLineCategories.Free;
  FNoneSpatialCategories.Free;

  FNoneSpatialClassCollectionIndexes.Free;
  FPointClassCollectionIndexes.Free;
  FLineClassCollectionIndexes.Free;
end;

procedure TZoneType._AddChild(const aChild: IDMElement);
var
  SafeguardClass:ISafeguardClass;
  aCategory:IDMCollection;
begin
  if aChild.QueryInterface(ISafeguardClass, SafeguardClass)<>0 then Exit;

  aCategory:=SafeguardClass.CreateCollection;
  if aCategory=nil then Exit;
  case SafeguardClass.SpatialElementKind of
  0: FPointCategories.Add(pointer(aCategory));
  1: FLineCategories.Add(pointer(aCategory));
  2:begin
      FPointCategories.Add(pointer(aCategory));
      FLineCategories.Add(pointer(aCategory));
    end;
  end;
  if SafeguardClass.OptionalSpatialElement then
    FNoneSpatialCategories.Add(pointer(aCategory));
  aCategory._AddRef;
end;

procedure TZoneType._RemoveChild(const aChild: IDMElement);
var
  SafeguardClass:ISafeguardClass;
  aCategory:IDMCollection;
begin
  if aChild.QueryInterface(ISafeguardClass, SafeguardClass)<>0 then Exit;

  aCategory:=Get_ListOfClass(SafeguardClass.TypeClassID);
  if aCategory=nil then Exit;
  (aCategory as IDMCollection2).DisconnectFrom(Self);
  case SafeguardClass.SpatialElementKind of
  0:FPointCategories.Remove(pointer(aCategory));
  1:FLineCategories.Remove(pointer(aCategory));
  2:begin
      FPointCategories.Remove(pointer(aCategory));
      FLineCategories.Remove(pointer(aCategory));
    end;
  end;
  if SafeguardClass.OptionalSpatialElement then
    FNoneSpatialCategories.Remove(pointer(aCategory));
  aCategory._Release;
end;

class function TZoneType.GetClassID: integer;
begin
  Result:=_ZoneType;
end;

function TZoneType.Get_ListOfClass(
  TypeClassID: integer): IDMCollection;
var
  j:integer;
  aCollection:IDMCollection;
begin
  Result:=nil;
  for j:=0 to FPointCategories.Count-1 do begin
    aCollection:=IDMCollection(FPointCategories[j]);
     if TypeClassID = (aCollection as IDMCollection2).ClassID  then begin
      Result:=aCollection;
      Exit;
    end;
  end;
  for j:=0 to FLineCategories.Count-1 do begin
    aCollection:=IDMCollection(FLineCategories[j]);
     if TypeClassID = (aCollection as IDMCollection2).ClassID  then begin
      Result:=aCollection;
      Exit;
    end;
  end;
  for j:=0 to FNoneSpatialCategories.Count-1 do begin
    aCollection:=IDMCollection(FNoneSpatialCategories[j]);
     if TypeClassID = (aCollection as IDMCollection2).ClassID  then begin
      Result:=aCollection;
      Exit;
    end;
  end;
end;

function TZoneType.Get_CollectionCount: integer;
begin
  Result:=ord(High(TZoneTypeCategory))+1+FPointCategories.Count+
          FLineCategories.Count;
end;

function TZoneType.Get_Collection(Index: Integer): IDMCollection;
var
  j:integer;
begin
  case TZoneTypeCategory(Index)  of
  fztcKinds:
    Result:=inherited Get_Collection(Index);
  fztcSafeguardClasses:
    Result:=FSafeguardClasses;
  else
    begin
      j:=Index-ord(High(TZoneTypeCategory))-1;
      if j<FPointCategories.Count then
        Result:=IDMCollection(FPointCategories[j])
      else begin
        j:=j-FPointCategories.Count;
        Result:=IDMCollection(FLineCategories[j])
      end;
    end;
  end;
end;

procedure TZoneType.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  aElements:IDMCollection;
begin
  case TZoneTypeCategory(Index)  of
  fztcKinds:
    begin
      inherited;
    end;
  fztcSafeguardClasses:
    begin
      aCollectionName:=rsSafeguardClasses;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  else
    begin
      aElements:=Get_Collection(Index);

      aCollectionName:=aElements.ClassAlias[akImenitM];
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelect;
      aLinkType:=ltManyToMany;
    end;
  end;
end;

function TZoneType.Get_ClassCollection(
  Index, Mode: Integer): IDMCollection;
begin
  case Mode of
  0: Result:=IDMCollection(FNoneSpatialCategories[Index]);
  1: Result:=IDMCollection(FPointCategories[Index]);
  2: Result:=IDMCollection(FLineCategories[Index]);
  else
    Result:=nil;
  end;
end;

function TZoneType.Get_ClassCount(Mode:integer): Integer;
begin
  case Mode of
  0:Result:=FNoneSpatialCategories.Count;
  1:Result:=FPointCategories.Count;
  2:Result:=FLineCategories.Count;
  else
    Result:=0;
  end;
end;

class function TZoneType.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TZoneType.Get_DefaultClassCollectionIndex(Index, Mode: Integer): Integer;
var
  ClassCollectionIndexes:TList;
  j, ClassCollectionIndexesCount:integer;
begin
  case Mode of
  0: ClassCollectionIndexes:=FNoneSpatialClassCollectionIndexes;
  1: ClassCollectionIndexes:=FPointClassCollectionIndexes;
  2: ClassCollectionIndexes:=FLineClassCollectionIndexes;
  else
    ClassCollectionIndexes:=nil;
  end;

  ClassCollectionIndexesCount:=ClassCollectionIndexes.Count;
  if ClassCollectionIndexesCount-1 < Index then begin
    for j:=ClassCollectionIndexesCount to Index do
      ClassCollectionIndexes.Add(pointer(-1));
    Result:=-1;
  end else
    Result:=integer(ClassCollectionIndexes[Index])
end;

procedure TZoneType.Set_DefaultClassCollectionIndex(Index, Mode, Value: Integer);
var
  ClassCollectionIndexes:TList;
  j, ClassCollectionIndexesCount:integer;
begin
  case Mode of
  0: ClassCollectionIndexes:=FNoneSpatialClassCollectionIndexes;
  1: ClassCollectionIndexes:=FPointClassCollectionIndexes;
  2: ClassCollectionIndexes:=FLineClassCollectionIndexes;
  else
    ClassCollectionIndexes:=nil;
  end;

  ClassCollectionIndexesCount:=ClassCollectionIndexes.Count;
  if ClassCollectionIndexesCount-1 < Index then
    for j:=ClassCollectionIndexesCount to Index do
      ClassCollectionIndexes.Add(pointer(-1));
  ClassCollectionIndexes[Index]:=pointer(Value);
end;

{ TZoneTypes }

function TZoneTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsZoneType;
end;

class function TZoneTypes.GetElementClass: TDMElementClass;
begin
  Result:=TZoneType;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TZoneType.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
