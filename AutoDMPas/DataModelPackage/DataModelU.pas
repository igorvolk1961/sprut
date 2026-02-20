unit DataModelU;

interface
uses
  Classes, Forms, DM_ComObj,
  DMComObjectU, DMElementU,
  DataModel_TLB, MyDB, DMServer_TLB, Variants,
  EZDSLHsh;

const
  rsLoadingFile='Загружается';
  rsLoading='Загружается таблица';
  rsLoaded='Восстанавливаются основные связи таблицы';
  rsAfterLoading1='Восстанавливаются вторичные связи таблицы';
  rsAfterLoading2='Обрабатываются данные таблицы';
  rsApplicationVersion='Версия приложения';

  constApplicationVersion=10000;
type
  TDataModel=class(
{$IFDEF MICROSOFT_COM}
                   TDMTypedComObject,
{$ELSE}
                   TDMComObject,
{$ENDIF}
                   IDataModel, IDataModel2, IDMElement,
                   IDataModelXML, IDMElementXML, IDMHash)
  private
    FState:integer;
    FXXXRefCount:integer;

    FAnalyzer:pointer;
    FParent:pointer;
    FRef:pointer;
    FID:integer;
    FName:string;
    FSelected:boolean;
    FExists:boolean;

    FCollectionList:TList;
    FClassList:TList;
    FNextIDList:TList;
    FDocument:IUnknown;

    FHashList:TList;

    FGenerations:TList;

    FXMLStack:TList;
    FXMLFieldCode:integer;
    FNextLoadStageCaption:string;
    FApplicationVersion:string;
  protected
    FDataModel:pointer;
// реализация интерфейса IDataModel
    function  Get_State:integer; safecall;
    procedure Set_State(Value:integer); safecall;

    function  Get_RootObjectCount(Mode:integer): Integer; virtual; safecall;
    procedure GetRootObject(Mode, RootIndex: Integer; out RootObject: IUnknown;
                            out RootObjectName: WideString; out aOperations: Integer;
                            out aLinkType: Integer); virtual; safecall;
    function  Get_Document: IUnknown; safecall;
    procedure Set_Document(const Value: IUnknown); safecall;
    function  Get_Analyzer:IDMAnalyzer; safecall;
    procedure Set_Analyzer(const Value:IDMAnalyzer); safecall;
    function  Get_NextID(aClassID: Integer): Integer; safecall;
    procedure Set_NextID(aClassID: Integer; Value: Integer); safecall;
    function  Get_IsChanging: WordBool; safecall;
    function  Get_IsLoading: WordBool; safecall;
    function  Get_IsExecuting: WordBool; safecall;
    function  Get_InUndoRedo: WordBool; safecall;
    function  Get_IsCopying: WordBool; safecall;
    function  Get_IsDestroying: WordBool; safecall;
    procedure SaveToDatabase(const aDatabaseU: IUnknown); virtual; safecall;
    procedure LoadFromDatabase(const aDatabaseU: IUnknown); virtual; safecall;
    procedure LoadedFromDataBase(const aDatabaseU: IUnknown);virtual;  safecall;
    procedure SaveFieldValuesToRecordSet(const aRecordSetU: IUnknown);
    procedure LoadFieldValuesFromRecordSet(const aRecordSetU: IUnknown);
    function  Get_IndexCollection(Index: Integer): IDMCollection; safecall;
    procedure BeforePaste; virtual; safecall;
    procedure AfterPaste; virtual; safecall;
    procedure AfterMoveInCollection(const aCollection:IDMCollection); virtual; safecall;

    function  CreateCollection(aClassID:integer; const aParent:IDMElement): IDMCollection; virtual; safecall;
    function  CreateElement(aClassID:integer): IDMElement; safecall;
    procedure RemoveElement(const aElement:IDMElement); safecall;
    procedure Init; virtual; safecall;
    function  Get_States: IDMCollection; virtual; safecall;
    function  Get_CurrentState: IDMElement; virtual; safecall;
    procedure Set_CurrentState(const Value: IDMElement); virtual; safecall;
    function  Get_GenerationCount: Integer; safecall;
    function  Get_Generation(Index: Integer): IDMElement; safecall;
    procedure BuildGenerations(Mode:integer; const aElement: IDMElement); safecall;
    function Import(const FileName:WideString):integer; virtual; safecall;
    function GetDefaultParent(ClassID:integer): IDMElement; virtual; safecall;
    function GetDefaultElement(ClassID:integer): IDMElement; virtual; safecall;
    function  Get_BackRefHolders: IDMCollection; virtual; safecall;
    function Get_EmptyBackRefHolder:IDMElement; virtual; safecall;
    procedure Set_EmptyBackRefHolder(const Value: IDMElement); virtual; safecall;
    function Get_Report: IDMText; virtual; safecall;
    function  GetDefaultName(const aRef: IDMElement): WideString; virtual; safecall;
    function GetElementCollectionCount(const aElement: IDMElement): Integer; virtual; safecall;
    function GetElementFieldVisible(const aElement: IDMElement; Code: Integer): WordBool; virtual; safecall;
    function Get_ApplicationVersion:WideString; safecall;
    procedure Set_ApplicationVersion(const Value:WideString); safecall;

// реализация интерфейса IDMElement
    function  Get_DataModel: IDataModel; override; safecall;
    procedure Set_DataModel(const Value: IDataModel); override; safecall;
    function  Get_Name: WideString; virtual; safecall;
    procedure Set_Name(const Value: WideString); virtual; safecall;
    function  Get_Parent: IDMElement; safecall;
    procedure Set_Parent(const Value: IDMElement); safecall;
    function  Get_MainParent: IDMElement; safecall;
    function  Get_Ref: IDMElement; safecall;
    procedure Set_Ref(const Value: IDMElement); safecall;
    function  Get_SpatialElement: IDMElement; virtual; safecall;
    procedure Set_SpatialElement(const Value: IDMElement); virtual; safecall;
    function  Get_ID: Integer; safecall;
    procedure Set_ID(Value: Integer); safecall;
    function  Get_OwnerCollection: IDMCollection; virtual; safecall;
    function  Get_ClassAlias: WideString; safecall;
    function  Get_ClassID: Integer; safecall;
    procedure DisconnectFrom(const aParent:IDMElement); safecall;
    procedure AddParent(const aParent:IDMElement); safecall;
    procedure RemoveParent(const aParent:IDMElement); safecall;
    procedure AddChild(const aChild:IDMElement); safecall;
    procedure RemoveChild(const aChild:IDMElement);  safecall;
    function GetCollectionForChild(const aChild: IDMElement): IDMCollection; safecall;
    function  Includes(const aElement: IDMElement): WordBool; safecall;
    procedure SaveToRecordSet(const aRecordSetU:IUnknown); safecall;
    procedure LoadFromRecordSet(const aRecordSetU:IUnknown); safecall;
    procedure SaveParentsToRecordSet(const aRecordSetU: IUnknown); safecall;
    procedure AddParentFromRecordSet(const aRecordSetU: IUnknown); safecall;
    procedure LoadDataFromRecordSet(const aRecordSetU: IUnknown); safecall;
    procedure Loaded; virtual; safecall;

    function  Get_Parents: IDMCollection; virtual; safecall;
    procedure Set_DefaultSubKindIndex(Value: integer); safecall;
    function  Get_DefaultSubKindIndex: integer; safecall;
    function  Get_SubKinds: IDMCollection; virtual; safecall;
    function  Get_BackRefCount: Integer; virtual; safecall;
    procedure _AddBackRef(const aElement: IDMElement); virtual; safecall;
    procedure _RemoveBackRef(const aElemen: IDMElement); virtual; safecall;
    function  Get_FieldCount: Integer; virtual; safecall;
    function  Get_Field(Index: Integer): IDMField; virtual; safecall;
    function  Get_FieldName(Index: Integer): WideString; virtual; safecall;
    function  Get_FieldFormat(Index: Integer): WideString; virtual; safecall;
    function  Get_FieldValue(Index: Integer): OleVariant; virtual; safecall;
    procedure Set_FieldValue(Index: Integer; Value: OleVariant); virtual; safecall;
    function  Get_FieldCount_: Integer; virtual; safecall;
    function  Get_Field_(Index: Integer): IDMField; virtual; safecall;
    function  Get_FieldValue_(Index: Integer): OleVariant; virtual; safecall;
    procedure Set_FieldValue_(Index: Integer; Value: OleVariant); virtual; safecall;
    function  GetFieldValue(Code: Integer): OleVariant; virtual; safecall;
    procedure SetFieldValue(Code: Integer; Value: OleVariant); virtual; safecall;
    procedure CalculateFieldValues; virtual; safecall;
    procedure GetFieldValueSource(Code: Integer; var aCollection: IDMCollection); virtual; safecall;
    function  Get_FieldCategoryCount:integer; virtual; safecall;
    function  Get_FieldCategory(Index:integer):WideString; virtual; safecall;
    procedure ClearOp; safecall;
    function  GetCopyLinkMode(const aLink: IDMElement): Integer; virtual; safecall;
    procedure JoinSpatialElements(const aElement:IDMElement); virtual; safecall;
    procedure BeforeDeletion; virtual; safecall;
    function  Get_UserDefineded: WordBool;safecall;
    function  Get_IsSelectable: WordBool; safecall;
    function  Get_SelectRef: WordBool; safecall;
    function  Get_SelectParent: WordBool; safecall;

    procedure Clear; override; safecall;
    function  Get_CollectionCount: Integer; virtual; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; virtual; safecall;
    function  Get_CollectionU(Index: Integer): IUnknown; virtual; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                out aCollectionName: WideString;
                                out aRefSource: IDMCollection;
                                out aClassCollections: IDMClassCollections;
                                out aOperations: Integer; out aLinkType: Integer); virtual; safecall;
    procedure MakeSelectSource(Index: Integer; const aRefSource: IDMCollection); virtual; safecall;
    function  Get_BuildIn: WordBool; safecall;
    procedure Set_BuildIn(Value: WordBool); safecall;
    function Get_SubModel(Index: integer): IDataModel; virtual; safecall;
    function  FieldIsVisible(Index:integer):WordBool; safecall;
    function  FieldIsReadOnly(Index:integer):WordBool; virtual; safecall;
    function  Get_Selected: WordBool; safecall;
    procedure Set_Selected(Value: WordBool); safecall;
    function  Get_Exists: WordBool; virtual; safecall;
    procedure Set_Exists(Value: WordBool); virtual; safecall;
    procedure Update; virtual; safecall;
    procedure UpdateCoords;  virtual; safecall;
    function Get_Errors:IDMCollection; virtual; safecall;
    function Get_Warnings:IDMCollection; virtual; safecall;
    procedure BuildReport(ReportLevel: Integer; TabCount: Integer;  Mode: Integer;
                            const Report: IDMText); virtual; safecall;
    function  Get_IsEmpty: WordBool; safecall;
    function  Get_Presence:integer; virtual; safecall;
    procedure Set_Presence(Value: Integer); virtual; safecall;

    property Name: WideString read Get_Name write Set_Name;
    property Parent: IDMElement read Get_Parent write Set_Parent;
    property Ref: IDMElement read Get_Ref write Set_Ref;
    property SpatialElement: IDMElement read Get_SpatialElement write Set_SpatialElement;
    property ID: Integer read Get_ID write Set_ID;
    property OwnerCollection: IDMCollection read Get_OwnerCollection;
    property ClassAlias: WideString read Get_ClassAlias;
    property ClassID: Integer read Get_ClassID;
    property DataModel: IDataModel read Get_DataModel;
    property FieldCount: Integer read Get_FieldCount;
    property CollectionCount: Integer read Get_CollectionCount;
    property Collection[Index: Integer]: IDMCollection read Get_Collection;
    property Parents: IDMCollection read Get_Parents;
    property SubKinds: IDMCollection read Get_SubKinds;
    property BackRefCount: Integer read Get_BackRefCount;
    property FieldValue[Index: Integer]: OleVariant read Get_FieldValue write Set_FieldValue;
    property Selected: WordBool read Get_Selected write Set_Selected;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); virtual; safecall;

    procedure CheckErrors; virtual; safecall;
    procedure CorrectErrors; virtual; safecall;
    procedure AfterLoading1; virtual;  safecall;
    procedure AfterLoading2; virtual;  safecall;
    procedure AfterCopyFrom(const SourceElement:IDMElement); virtual; safecall;
    procedure AfterCopyFrom2; virtual; safecall;
    function  CompartibleWith(const aElement:IDMElement):WordBool; safecall;
    procedure HandleError(const ErrorMessage:WideString); virtual; safecall;

//  защищенные методы
    procedure MakeCollections; virtual;
    procedure AddCollection(const aCollection:IDMCollection);
    procedure AddClass(const CollectionClass:TDMCollectionClass);
    procedure MakeFieldValues; virtual;

//  защищенные методы
    procedure _AddChild(aChild:IDMElement); virtual;
    procedure _RemoveChild(aChild:IDMElement); virtual;


//  защищенные свойства
    property CollectionList: TList read FCollectionList;


    class function GetClassID:integer; virtual;
    class procedure MakeFields; virtual;
    class function  GetFields:IDMCollection; virtual;
    class procedure AddField(
     aName, aValueFormat, aHint, aShortName: String;
     aValueType: Integer;
     aDefaultValue, aMinValue, aMaxValue: Double;
     aCode, aModifier, aLevel: Integer);
    function Get_XXXRefCount:integer; safecall;
    procedure Set_XXXRefCount(Value:integer); safecall;
    function IsSimilarTo(const aElement:IDMElement):WordBool; safecall;

    function KeepHash:boolean; virtual;

    procedure WriteRefToXML(aXML:IDMXML);
    procedure WriteFieldValuesToXML(aXML:IDMXML);
    procedure WriteCollectionsToXML(aXML:IDMXML); virtual;

//IDataModelXML
    procedure ProcessXMLString(const S:WideString; TagFlag:WordBool); safecall;
//IDMElementXML
    procedure DoWriteToXML(const aXMLU: IUnknown); safecall;
    procedure WriteToXML(const aXMLU: IUnknown; WriteInstance:WordBool); safecall;
//IDMHash
    procedure AddToHash(const aElement: IDMElement); safecall;
    function GetFromHash(aClassID: Integer; aID: Integer): IDMElement; safecall;
    procedure MakeHashTables; virtual; safecall;
    procedure DeleteHashTables; virtual; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation
uses
  SysUtils,
  LoadProgressFrm;

{ TDataModel }

destructor TDataModel.Destroy;
var
  j:integer;
  Collection:IDMCollection;
begin
  inherited;
  try
  for j:=0 to FCollectionList.Count-1 do begin
    Collection:=IDMCollection(FCollectionList[j]);
    if Collection<>nil then
      Collection._Release;
  end;
  except
    raise
  end;
  FCollectionList.Free;
  FClassList.Free;
  FNextIDList.Free;
  FGenerations.Free;

  FHashList.Free;
  FXMLStack.Free;
end;

function  TDataModel.Get_Collection(Index: Integer): IDMCollection; safecall;
begin
  Result:=IDMCollection(FCollectionList[Index])
end;

function TDataModel.Get_CollectionCount: Integer;
begin
  Result:=FCollectionList.Count
end;

procedure TDataModel.Initialize;
begin
  inherited;

  FCollectionList:=TList.Create;
  FClassList:=TList.Create;
  FNextIDList:=TList.Create;
  FGenerations:=TList.Create;

  FHashList:=TList.Create;
  FXMLStack:=TList.Create;

  MakeCollections;
  MakeFieldValues;

  FApplicationVersion:='1.0.0';

end;

procedure TDataModel.MakeCollections;
begin
end;

procedure TDataModel.AddCollection(const aCollection: IDMCollection);
var
  Index, j, N:integer;
begin
  Index:=(aCollection as IDMCollection2).ClassID;
  N:=FCollectionList.Count-1;
  if N<Index then
    for j:=N+1 to Index do begin
      FCollectionList.Add(nil);
      FClassList.Add(nil);
      FNextIDList.Add(nil);
    end;
  FCollectionList[Index]:=pointer(aCollection);
  (aCollection as IUnknown)._AddRef
end;

procedure TDataModel.AddClass(const CollectionClass: TDMCollectionClass);
var
  aCollection: IDMCollection;
  Index:integer;
begin
  aCollection:=CollectionClass.Create(Self as IDMElement) as IDMCollection;
  AddCollection(aCollection);
  Index:=(aCollection as IDMCollection2).ClassID;
  FClassList[Index]:=pointer(CollectionClass);
end;


procedure TDataModel.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString;
  out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections;
  out aOperations: Integer; out aLinkType: Integer);
var
  aCollection: IDMCollection;
begin
  aCollection:=Get_Collection(Index);
  if aCollection<>nil then begin
    aCollectionName:=aCollection.ClassAlias[akImenitM];
    aOperations:=leoAdd or leoDelete or leoRename;
  end else begin
    aCollectionName:='Не определено';
    aOperations:=0;
  end;
  aRefSource:=nil;
  aClassCollections:=nil;
  aLinkType:=ltOneToMany;
end;

function TDataModel.Get_RootObjectCount(Mode:integer): Integer;
begin
  Result:=CollectionCount
end;

procedure TDataModel.GetRootObject(Mode, RootIndex: Integer; out RootObject: IUnknown;
                            out RootObjectName: WideString; out aOperations: Integer;
                            out aLinkType: Integer);
var
  aRefSource:IDMCollection;
  aClassCollections:IDMClassCollections;
begin
  try
    GetCollectionProperties(RootIndex,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
    RootObject:=Collection[RootIndex];
  except
    raise
  end    
end;

function TDataModel.Get_Document: IUnknown;
var
  aDataModel:IDataModel;
begin
  Result:=FDocument;
end;

procedure TDataModel.Set_Document(const Value: IUnknown);
begin
  FDocument:=Value
end;

procedure TDataModel.Clear;
var
  j, OldState:integer;
  Collection:IDMCollection;
  SelfElement:IDMElement;
  HashTable:THashTable;
begin
  Parent:=nil;
  Ref:=nil;
  SelfElement:=Self as IDMElement;
  OldState:=FState;
  FState:=FState or dmfDestroying;

  try
  if Parents<>nil then
    while Parents.Count>0 do
      RemoveParent(Parents.Item[0]);

  if Get_OwnerCollection<>nil then
    for j:=0 to FieldCount-1 do
      if Get_Field(j).ValueType=fvtElement then
        FieldValue[j]:=Null;

  SelfElement:=Self as IDMElement;
  try
  for j:=0 to CollectionCount-1 do begin
    Collection:=Get_Collection(j);
    if Collection<>nil then
      (Collection as IDMCollection2).DisconnectFrom(SelfElement);
  end;
  except
    raise
  end;
  SelfElement:=nil;

  if KeepHash and
    (FHashList.Count>0)then begin
    for j:=0 to CollectionCount-1 do begin
      HashTable:=FHashList[j];
      HashTable.Empty;
      HashTable.Free;
    end;
    FHashList.Free;
    FHashList:=nil;
  end;

  inherited;

  finally
    FState:=OldState;
  end;
  FDocument:=nil;
end;

procedure TDataModel._AddBackRef(const aElement: IDMElement);
begin
end;

procedure TDataModel._RemoveBackRef(const aElemen: IDMElement);
begin
end;

procedure TDataModel.AddChild(const aChild: IDMElement);
var
  j:integer;
  Collection:IDMCollection2;
begin
  j:=0;
  while j<CollectionCount do begin
    Collection:=Get_Collection(j) as IDMCollection2;
    if Collection.CanContain(aChild) then
      Break
    else
      inc(j)
  end;
  if j<CollectionCount then begin
    Collection.Add(aChild);
    _AddChild(aChild);
  end;
end;

procedure TDataModel.AddParent(const aParent: IDMElement);
var
  Parents2:IDMCollection2;
begin
  if aParent=nil then Exit;
  if Parents=nil then Exit;
  Parents2:=Parents as IDMCollection2;
  if (Parents2 as IDMCollection).IndexOf(aParent)=-1 then begin
    Parents2.Add(aParent);
    aParent.AddChild(Self as IDMElement);
  end;
end;

procedure TDataModel.AddParentFromRecordSet(const aRecordSetU: IUnknown);
begin
end;

procedure TDataModel.CalculateFieldValues;
begin
end;

procedure TDataModel.DisconnectFrom(const aParent: IDMElement);
begin
  if Parents<>nil then
    RemoveParent(aParent);

  if Ref=aParent then
    Ref:=nil;

  if Parent=aParent then
    Parent:=nil;
end;

function TDataModel.Get_BackRefCount: Integer;
begin
  Result:=-1
end;

function TDataModel.Get_ClassAlias: WideString;
begin
  Result:=''
end;

function TDataModel.Get_ClassID: Integer;
begin
  Result:=GetClassID
end;

function TDataModel.Get_Field(Index: Integer): IDMField;
begin
  if GetFields<>nil then
    Result:=GetFields.Item[Index] as IDMField
  else
    Result:=nil
end;

function TDataModel.Get_FieldCount: Integer;
begin
  if GetFields<>nil then
    Result:=GetFields.Count
  else
    Result:=0
end;

function TDataModel.Get_FieldValue(Index: Integer): OleVariant;
var
  Field:IDMField;
begin
  Field:=Get_Field(Index);
  Result:=GetFieldValue(Field.Code)
end;

procedure TDataModel.GetFieldValueSource(Code: Integer; var aCollection: IDMCollection);
begin
  aCollection:=nil
end;

function TDataModel.Get_ID: Integer;
begin
  Result:=FID;
end;

function TDataModel.Get_Name: WideString;
begin
  Result:=FName;
end;

function TDataModel.Get_OwnerCollection: IDMCollection;
var
  ClassID:integer;
begin
  ClassID:=GetClassID;
  if ClassID=-1 then
    Result:=nil
  else
    Result:=(Get_DataModel as IDMElement).Collection[ClassID]
end;

function TDataModel.Get_Parent: IDMElement;
begin
  Result:=IDMElement(FParent)
end;

function TDataModel.Get_Parents: IDMCollection;
begin
  Result:=nil
end;

function TDataModel.Get_Ref: IDMElement;
begin
  Result:=IDMElement(FRef);
end;

function TDataModel.Get_SubKinds: IDMCollection;
begin
  Result:=nil
end;

function TDataModel.Includes(const aElement: IDMElement): WordBool;
var
  aParent, SelfElement:IDMElement;
begin
  SelfElement:=Self as IDMElement;
  Result:=True;
  if aElement=SelfElement then Exit;
  aParent:=aElement;
  while aParent<>nil do begin
    aParent:=aParent.Parent;
    if aParent=SelfElement then Exit;
  end;
  Result:=False;
end;

procedure TDataModel.LoadDataFromRecordSet(const aRecordSetU: IUnknown);
begin
end;

procedure TDataModel.Loaded;
var
  j:integer;
  aCollection:IDMCollection;
  S:string;
  Document:IDMDocument;
  Server:IDataModelServer;
begin
  Document:=Get_Document as IDMDocument;
  Server:=Document.Server as IDataModelServer;
  for j:=0 to CollectionCount-1 do begin
    aCollection:=Collection[j];
    if aCollection<>nil then begin
       if ((FState and dmfFrozen)=0) then begin
          S:=rsLoaded+#13+'"'+aCollection.ClassAlias[0]+'"';
          NextLoadStage('', S, j, 0);
       end;
      (aCollection as IDMCollection2).Loaded;
    end;
  end;
end;

procedure TDataModel.LoadFromRecordSet(const aRecordSetU: IUnknown);
begin
  ID:=MyDBGetFieldValue(aRecordSetU, 'ID');
  try
  LoadFieldValuesFromRecordSet(aRecordSetU);
  except
    raise
  end;
end;

procedure TDataModel.RemoveChild(const aChild: IDMElement);
var
  j:integer;
  Collection:IDMCollection2;
begin
  j:=0;
  while j<CollectionCount do begin
    Collection:=Get_Collection(j) as IDMCollection2;
    if Collection.CanContain(aChild) then
      Break
    else
      inc(j)
  end;
  if j<CollectionCount then begin
    Collection.Remove(aChild);
    _RemoveChild(aChild);
  end;
end;

procedure TDataModel.RemoveParent(const aParent: IDMElement);
var
  j:integer;
  Parents2:IDMCollection2;
begin
  if aParent=nil then Exit;
  if Parents=nil then Exit;
  Parents2:=Parents as IDMCollection2;
  j:=(Parents2 as IDMCollection).IndexOf(aParent);
  if j<>-1 then begin
    Parents2.Delete(j);
    aParent.RemoveChild(Self as IDMElement)
  end;
end;

procedure TDataModel.SaveFieldValuesToRecordSet(const aRecordSetU: IUnknown);
var
  aElement:IDMElement;
  DMField:IDMField;
  S, FieldName:string;
  m, N:integer;
  Unk:IUnknown;
  Frmt:string;
  F:double;
  V:variant;
begin
  try
  N:=Get_FieldCount;
  for m:=0 to N-1 do begin
    DMField:=Get_Field(m);
    S:='P'+IntToStr(m)+' '+(DMField as IDMElement).Name;
    FieldName:=Copy(S, 1, 64);
    case DMField.ValueType of
    fvtFloat:
      begin
        Frmt:=DMField.ValueFormat;
        F:=FieldValue[m];
        DecimalSeparator:=LocalDecimalSeparator;
        MyDBSetFieldValue(aRecordSetU, FieldName, Format(Frmt,[F]));
        DecimalSeparator:='.';
      end;
    fvtString:
        MyDBSetFieldValue(aRecordSetU, FieldName, FieldValue[m]);
    fvtElement:
      begin
        V:=FieldValue[m];
        if VarIsNull(V) or
           VarIsEmpty(V) then
          MyDBSetFieldValue(aRecordSetU, FieldName, -1)
        else begin
          Unk:=V;
          aElement:=Unk as IDMElement;
          if aElement<>nil then
            MyDBSetFieldValue(aRecordSetU, FieldName, aElement.ID)
          else
            MyDBSetFieldValue(aRecordSetU, FieldName, -1);
        end
      end;
    else
      MyDBSetFieldValue(aRecordSetU, FieldName, FieldValue[m]);
    end;
  end;
  except
    raise
  end
end;

procedure TDataModel.SaveToRecordSet(const aRecordSetU: IUnknown);
begin
  MyDBAddRecord(aRecordSetU);
  MyDBSetFieldValue(aRecordSetU, 'ID', ID);
  MyDBSetFieldValue(aRecordSetU, 'Name', Name);

  SaveFieldValuesToRecordSet(aRecordSetU);

end;

procedure TDataModel.Set_FieldValue(Index: Integer; Value: OleVariant);
var
  Field:IDMField;
begin
  Field:=Get_Field(Index);
  SetFieldValue(Field.Code, Value);
end;

procedure TDataModel.Set_ID(Value: Integer);
begin
  FID:=Value
end;

procedure TDataModel.Set_Name(const Value: WideString);
begin
  FName:=Value;
end;

procedure TDataModel.Set_Parent(const Value: IDMElement);
begin
  if FParent=pointer(Value) then Exit;
  if (Get_DataModel as IDMElement)=Value then Exit;

  if FParent<>nil then begin
    IDMElement(FParent).RemoveChild(Self as IDMElement);
    IDMElement(FParent)._Release;
  end;

  FParent:=pointer(Value);

  if Value=nil then
//    Clear
  else begin
    Value._AddRef;
    Value.AddChild(Self as IDMElement);
  end;
end;

procedure TDataModel.Set_Ref(const Value: IDMElement);
begin
  if FRef=pointer(Value) then Exit;

  if FRef<>nil then begin
    IDMElement(FRef)._RemoveBackRef(Self as IDMElement);
    IDMElement(FRef)._Release;
  end;

  FRef:=pointer(Value);

  if Value<>nil then begin
    Value._AddRef;
    Value._AddBackRef(Self as IDMElement);
  end;
end;

procedure TDataModel._AddChild(aChild: IDMElement);
begin
end;

procedure TDataModel._RemoveChild(aChild: IDMElement);
begin
end;

class function TDataModel.GetClassID: integer;
begin
  Result:=-1
end;

function TDataModel.Get_DataModel: IDataModel;
begin
  Result:=IDataModel(FDataModel);
end;

function TDataModel.Get_NextID(aClassID: Integer): Integer;
begin
  Result:=integer(FNextIDList[aClassID])
end;

procedure TDataModel.Set_NextID(aClassID, Value: Integer);
begin
  FNextIDList[aClassID]:=pointer(Value)
end;

procedure TDataModel.ClearOp;
begin
end;

function TDataModel.Get_InUndoRedo: WordBool;
begin
  Result:=((FState and dmfCommiting)<>0) or
          ((FState and dmfRollBacking)<>0)
end;

function TDataModel.Get_IsExecuting: WordBool;
begin
  Result:=((FState and dmfExecuting)<>0)
end;

function TDataModel.Get_IsLoading: WordBool;
begin
  Result:=((FState and dmfLoading)<>0) or
          (not Get_IsChanging and
           ((FState and dmfLoadingTransactions)<>0));  // не при загрузке файла транзакций
end;

function TDataModel.GetCopyLinkMode(const aLink: IDMElement): Integer;
begin
  Result:=clmDefault
end;

function TDataModel.Get_BuildIn: WordBool;
begin
  Result:=False
end;

procedure TDataModel.Set_BuildIn(Value: WordBool);
begin
end;

procedure TDataModel.LoadedFromDataBase(const aDatabaseU: IUnknown);
var
  j:integer;
  Document:IDMDocument;
  Server:IDataModelServer;
  aCollection:IDMCollection;
  S:string;

  HashTable:THashTable;
begin
  Document:=Get_Document as IDMDocument;
  Server:=Document.Server as IDataModelServer;
  try
  try
    for j:=0 to CollectionCount-1 do begin
      aCollection:=Collection[j];
      if aCollection<>nil then begin
         if ((FState and dmfFrozen)=0) then begin
            S:=rsLoaded+#13+'"'+aCollection.ClassAlias[0]+'"';
            NextLoadStage('', S, j, 0);
//           Server.NextLoadStage(S, j, 0);
         end;
        (aCollection as IDMCollection2).Loaded;
        (aCollection as IDMCollection2).LoadedFromDatabase(aDataBaseU);
      end;
    end;
  finally

    if not KeepHash then
      DeleteHashTables;
  end;
  except
    raise
  end
end;

procedure TDataModel.MakeHashTables;
var
  j:integer;
  HashTable:THashTable;
begin
  for j:=0 to FCollectionList.Count-1 do begin
    HashTable:=THashTable.Create(False);
    FHashList.Add(HashTable);
  end;
end;

procedure TDataModel.DeleteHashTables;
var
  j:integer;
  HashTable:THashTable;
begin
  for j:=0 to FHashList.Count-1 do begin
    HashTable:=FHashList[j];
    HashTable.Empty;
    HashTable.Free;
  end;
  FHashList.Free;
  FHashList:=nil;
end;

procedure TDataModel.LoadFromDatabase(const aDatabaseU: IUnknown);
var
  j:integer;
  TableName:WideString;
  Document:IDMDocument;
  Server:IDataModelServer;
  aCollection:IDMCollection;
  Caption, Filename, S:string;
  aRecordSetU:IUnknown;
begin
  Document:=Get_Document as IDMDocument;
  Server:=Document.Server as IDataModelServer;
  try
    MakeHashTables;
    FileName:=ExtractFileName((Document.DataModel as IDMElement).Name);
    Caption:=rsLoadingFile+' '+FileName;
    for j:=0 to CollectionCount-1 do begin
      aCollection:=Collection[j];
      if aCollection<>nil then begin
         if ((FState and dmfFrozen)=0) then begin
            S:=rsLoading+#13+'"'+aCollection.ClassAlias[0]+'"';
            NextLoadStage(Caption, S, j, 0);
         end;
        (aCollection as IDMCollection2).LoadFromDatabase(aDataBaseU);
      end;
    end;
  except
    raise
  end;

  TableName:='_Объект';

  aRecordSetU:=MyDBOpenRecordset(aDataBaseU, TableName, False);

  try
  while not MyDBRecordSetEOF(aRecordSetU) do begin
    LoadFromRecordSet(aRecordSetU);
    MyDBRecordSetMoveNext(aRecordSetU);
  end;
  finally
    MyDBCloseRecordSet(aRecordSetU);
  end;
end;

procedure TDataModel.SaveToDatabase(const aDatabaseU: IUnknown);
var
  j:integer;
  TableName, aTableName:OleVariant;
  aRecordSetU:IUnknown;
  Element:IDMElement;
  FieldList:TStringList;

  procedure MakeGlobalFields(const FieldList:TStringList);
  var
    j, N:integer;
    DMField:IDMField;
    S, FieldName:string;
  begin
    FieldList.AddObject('ID', pointer(fvtInteger));
    FieldList.AddObject('Name', pointer(fvtString));

    N:=Get_FieldCount;
    for j:=0 to N-1 do begin
      DMField:=Get_Field(j);
      S:='P'+IntToStr(j)+' '+(DMField as IDMElement).Name;
      FieldName:=Copy(S, 1, 64);
      FieldList.AddObject(FieldName, pointer(DMField.ValueType));
    end;
  end;  

begin
  TableName:='_Таблицы';
  FieldList:=TStringList.Create;
  FieldList.AddObject('ClassID', pointer(fvtInteger));
  FieldList.AddObject('Таблица', pointer(fvtString));
  MyDBCreateTable(aDataBaseU, TableName, FieldList, 'ClassID');

  aRecordSetU:=MyDBOpenRecordset(aDataBaseU, TableName, True);

  for j:=0 to CollectionCount-1 do
    if (Collection[j]<>nil) and
       (Collection[j].Count>0) then begin
      (Collection[j] as IDMCollection2).SaveToDatabase(aDataBaseU);
      Element:=Collection[j].Item[0];
      MyDBAddRecord(aRecordSetU);
      MyDBSetFieldValue(aRecordSetU, 'ClassID', Element.ClassID);
      aTableName:=Collection[j].ClassAlias[akImenitM];
      MyDBSetFieldValue(aRecordSetU, 'Таблица', aTableName);
      MyDBUpdateRecordSet(aRecordSetU);
    end;

  MyDBCloseRecordset(aRecordSetU);

  TableName:='_Объект';

  FieldList.Clear;
  MakeGlobalFields(FieldList);
  MyDBCreateTable(aDataBaseU, TableName, FieldList, '');
  FieldList.Free;

  aRecordSetU:=MyDBOpenRecordset(aDataBaseU, TableName, True);
  SaveToRecordSet(aRecordSetU);
  MyDBUpdateRecordSet(aRecordSetU);
  MyDBCloseRecordset(aRecordSetU);
end;

procedure TDataModel.SaveParentsToRecordSet(const aRecordSetU: IUnknown);
begin
end;

function TDataModel.Get_SubModel(Index: integer): IDataModel;
begin
  case Index of
  -1: Result:=Self;
   0: Result:=DataModel;
  else
    begin
      if DataModel<>nil then
        Result:=DataModel.SubModel[Index]
      else
        Result:=nil
    end
  end;
end;

function TDataModel.FieldIsVisible(Index: integer): WordBool;
begin
  Result:=True
end;

procedure TDataModel.Draw(const aPainter: IInterface;
  DrawSelected: integer);
begin
  if SpatialElement<>nil then
    SpatialElement.Draw(aPainter, DrawSelected)
end;

function TDataModel.Get_SpatialElement: IDMElement;
begin
  Result:=nil
end;

procedure TDataModel.Set_SpatialElement(const Value: IDMElement);
begin
end;

function TDataModel.Get_Selected: WordBool;
begin
  Result:=FSelected
end;

procedure TDataModel.Set_Selected(Value: WordBool);
begin
  FSelected:=Value
end;

function TDataModel.CreateElement(aClassID: integer): IDMElement;
var
  OperationManager:IDMOperationManager;
  aElementU:IUnknown;
begin
  OperationManager:=Get_Document as IDMOperationManager;
  OperationManager.AddElement(nil,
           Collection[aClassID], '', ltOneToMany, aElementU, False);
  Result:=aElementU as IDMElement;
end;

procedure TDataModel.RemoveElement(const aElement: IDMElement);
var
  OperationManager:IDMOperationManager;
begin
  OperationManager:=Get_Document as IDMOperationManager;
  OperationManager.DeleteElement(nil, nil, ltOneToMany,
                                 aElement as IUnknown);
end;

function TDataModel.Get_IsCopying: WordBool;
begin
  Result:=((FState and dmfCopying)<>0)
end;

procedure TDataModel.Init;
begin
end;

procedure TDataModel.Update;
begin
end;

function TDataModel.Get_CurrentState: IDMElement;
begin
  Result:=nil
end;

function TDataModel.Get_States: IDMCollection;
begin
  Result:=nil
end;

procedure TDataModel.Set_CurrentState(const Value: IDMElement);
begin
end;

function TDataModel.Get_Generation(Index: Integer): IDMElement;
begin
    Result:=IDMElement(FGenerations[Index])
end;

function TDataModel.Get_GenerationCount: Integer;
begin
  Result:=FGenerations.Count
end;

procedure TDataModel.BuildGenerations(Mode:integer; const aElement: IDMElement);
var
  ParentElement, RootElement, Element, MainParent:IDMElement;
  Collection:IDMCollection;
  RootObject:IUnknown;
  j, N:integer;
  RootObjectName: WideString;
  aOperations, aLinkType: Integer;
begin
  FGenerations.Clear;

  ParentElement:=aElement;
  while ParentElement<>nil do begin
    FGenerations.Insert(0, pointer(ParentElement));
    MainParent:=ParentElement.MainParent;
    if MainParent<>nil then
      ParentElement:=MainParent
    else
      ParentElement:=nil;
  end;

  if FGenerations.Count=0 then Exit;
  RootElement:=IDMElement(FGenerations[0]);
  N:=Get_RootObjectCount(Mode);
  j:=0;
  while j<N do begin
    GetRootObject(Mode, j, RootObject,
                  RootObjectName, aOperations, aLinkType);
    if RootObject=nil then
      inc(j)
    else
    if RootObject.QueryInterface(IDMElement, Element)=0 then begin
      if Element=RootElement then
        Break
      else
        inc(j);
    end else
    if RootObject.QueryInterface(IDMCollection, Collection)=0 then begin
      if Collection.IndexOf(RootElement)<>-1 then
        Break
      else
        inc(j);
    end;
  end;
  if j=N then
    FGenerations.Clear;
end;

function TDataModel.GetFieldValue(Code: Integer): OleVariant;
begin
  case Code of
  ord(constApplicationVersion):
    Result:=FApplicationVersion;
  else  
    Result:=NilUnk
  end
end;

procedure TDataModel.SetFieldValue(Code: Integer; Value: OleVariant);
begin
  case Code of
  ord(constApplicationVersion):
    FApplicationVersion:=Value;
  end
end;

function TDataModel.Get_Field_(Index: Integer): IDMField;
begin
  Result:=Get_Field(Index)
end;

function TDataModel.Get_FieldCount_: Integer;
begin
  Result:=Get_FieldCount
end;

function TDataModel.Get_FieldValue_(Index: Integer): OleVariant;
begin
  Result:=Get_FieldValue(Index)
end;

procedure TDataModel.Set_FieldValue_(Index: Integer; Value: OleVariant);
begin
  Set_FieldValue(Index, Value)
end;

function TDataModel.Get_MainParent: IDMElement;
begin
  Result:=IDMElement(FParent)
end;

function TDataModel.Get_Analyzer: IDMAnalyzer;
begin
  Result:=IDMAnalyzer(FAnalyzer)
end;

procedure TDataModel.Set_Analyzer(const Value: IDMAnalyzer);
begin
  FAnalyzer:=pointer(Value)
end;

function TDataModel.Import(const FileName:WideString):integer;
begin
  Result:=0;
end;

function TDataModel.GetDefaultParent(ClassID: integer): IDMElement;
begin
  Result:=nil
end;

procedure TDataModel.CorrectErrors;
begin
end;

function TDataModel.Get_Errors: IDMCollection;
begin
  Result:=nil
end;

function TDataModel.Get_Warnings: IDMCollection;
begin
  Result:=nil
end;

function TDataModel.Get_BackRefHolders: IDMCollection;
begin
  Result:=nil
end;

procedure TDataModel.AfterLoading1;
var
  j, m:integer;
  aCollection:IDMCollection;
  Document:IDMDocument;
  Server:IDataModelServer;
  Executing:boolean;
  S:string;
begin
  Document:=Get_Document as IDMDocument;
  Server:=Document.Server as IDataModelServer;
  Executing:=Get_IsExecuting;
  try
    for j:=0 to CollectionCount-1 do begin
      aCollection:=Collection[j];
      if aCollection<>nil then begin
        if not Executing and
          ((FState and dmfFrozen)=0) then begin
            S:=rsAfterLoading1+#13+'"'+aCollection.ClassAlias[0]+'"';
            NextLoadStage('', S, j, 0);

//          Server.NextLoadStage(rsAfterLoading1+#13+'"'+
//                         aCollection.ClassAlias[0]+'"', j, 0);
        end;
        for m:=0 to aCollection.Count-1 do begin
          aCollection.Item[m].AfterLoading1
        end;
      end;
    end;
  except
    raise
  end
end;

procedure TDataModel.AfterLoading2;
var
  j, m:integer;
  aCollection:IDMCollection;
  Document:IDMDocument;
  Server:IDataModelServer;
  Executing:boolean;
  S:string;
begin
  Document:=Get_Document as IDMDocument;
  Server:=Document.Server as IDataModelServer;
  Executing:=Get_IsExecuting;
  try
    for j:=0 to CollectionCount-1 do begin
      aCollection:=Collection[j];
      if aCollection<>nil then begin
        if not Executing and
          ((FState and dmfFrozen)=0) then begin
          S:=rsAfterLoading2+#13+'"'+aCollection.ClassAlias[0]+'"';
          NextLoadStage('', S, j, 0);
//          Server.NextLoadStage(rsAfterLoading2+#13+'"'+
//                         aCollection.ClassAlias[0]+'"', j, 0);
        end;
        for m:=0 to aCollection.Count-1 do
          aCollection.Item[m].AfterLoading2
      end;
    end;
  except
    raise
  end;
  NextLoadStage('', '', -1, -1);
end;

function TDataModel.Get_IsDestroying: WordBool;
begin
  Result:=((FState and dmfDestroying)<>0)
end;

procedure TDataModel.BuildReport(ReportLevel, TabCount: Integer;  Mode: Integer;
  const Report: IDMText);
begin
end;

function TDataModel.Get_Report: IDMText;
begin
  Result:=nil
end;

procedure TDataModel.JoinSpatialElements(const aElement: IDMElement);
begin
  inherited;
end;

function TDataModel.Get_CollectionU(Index: Integer): IUnknown;
begin
  Result:=IDMCollection(FCollectionList[Index]) as IUnknown
end;

function TDataModel.GetDefaultElement(ClassID: integer): IDMElement;
begin
  Result:=nil
end;

procedure TDataModel.BeforeDeletion;
begin
end;

function TDataModel.GetDefaultName(const aRef: IDMElement): WideString;
var
  BackRefHolders2,BackRefs2:IDMCollection2;
  BackRefHolderE:IDMElement;
  BackRefHolder:IDMBackRefHolder;
  BackRefCount:integer;
begin
  BackRefHolders2:=Get_BackRefHolders as IDMCollection2;
  if BackRefHolders2=nil then
    Result:=aRef.Name
  else begin
    BackRefHolderE:=BackRefHolders2.GetItemByRef(aRef);
    BackRefHolder:=BackRefHolderE as IDMBackRefHolder;
    if BackRefHolder=nil then begin
      Result:=Format('%s %d',[aRef.Name, 0]);
      Exit;
    end;
    BackRefCount:=BackRefHolder.BackRefs.Count;
    if BackRefCount<BackRefHolder.OverCount then
      BackRefCount:=BackRefHolder.OverCount;
    BackRefs2:=BackRefHolder.BackRefs as IDMCollection2;
    Result:=Format('%s %d',[aRef.Name, BackRefCount]);
    while BackRefs2.GetItemByName(Result)<>nil do begin
      inc(BackRefCount);
      Result:=Format('%s %d',[aRef.Name, BackRefCount]);
      BackRefHolder.OverCount:=BackRefCount;
    end;
  end;

end;

function TDataModel.Get_UserDefineded: WordBool;
begin
  Result:=False
end;

function TDataModel.Get_IsChanging: WordBool;
begin
  Result:=((FState and dmfChanging)<>0)
end;

function TDataModel.Get_IsEmpty: WordBool;
begin
  Result:=False
end;

class procedure TDataModel.MakeFields;
begin
  AddField(rsApplicationVersion, '1.0.0', '', '',
                 fvtString, 0, 0, 0,
                 constApplicationVersion, 1, pkInput);
end;

class function TDataModel.GetFields: IDMCollection;
begin
  Result:=nil
end;

class procedure TDataModel.AddField(aName, aValueFormat, aHint,
  aShortName: String; aValueType: Integer; aDefaultValue, aMinValue,
  aMaxValue: Double; aCode, aModifier, aLevel: Integer);
var
  Field:IDMField;
begin
  Field:=TDMField.Create(nil) as IDMField;
  with Field do begin
    (Field as IDMElement).Name:=aName;
    ValueFormat:=aValueFormat;
    Hint:=aHint;
    ShortName:=aShortName;
    ValueType:=aValueType;
    DefaultValue:=aDefaultValue;
    MinValue:=aMinValue;
    MaxValue:=aMaxValue;
    Code:=aCode;
    Modifier:=aModifier;
    Level:=aLevel;
  end;
  (GetFields as IDMCollection2).Add(Field as IDMElement);
end;

procedure TDataModel.LoadFieldValuesFromRecordSet(
  const aRecordSetU: IUnknown);
var
  aCollection:IDMCollection;
  ElementLinkRecord:PElementLinkRecord;
  aID, K, m, N, aClassID:integer;
  aElement:IDMElement;
  DMField:IDMField;
  FieldName, Num:string;
  B:boolean;
  aValue:OleVariant;
  aDMHash:IDMHash;
begin
  N:=Get_FieldCount;
  for m:=0 to N-1 do begin
    DMField:=Get_Field(m);
    Num:=IntToStr(m);
    FieldName:=(DMField as IDMElement).Name;
    FieldName:=Copy(FieldName, 1, 64-length(Num)-2);
    if not MyDBFindFieldValue(aRecordSetU, FieldName, aValue) then
      Continue;

    case DMField.ValueType of
    fvtElement:
      begin
        aID:=aValue;
        if aID=-1 then
          FieldValue[m]:=NilUnk
        else begin
          aCollection:=nil;
          GetFieldValueSource(DMField.Code, aCollection);
          if (aCollection<>nil) and
            (aCollection.Count>0) then begin
            aClassID:=aCollection.ClassID;
            if aClassID<>-1 then begin
              aDMHash:=aCollection.DataModel as IDMHash;
              aElement:=aDMHash.GetFromHash(aClassID, aID);
            end else
              aElement:=(aCollection as IDMCollection2).GetItemByID(aID);
            if aElement<>nil then
              FieldValue[m]:=aElement
            else begin
              GetMem(ElementLinkRecord, SizeOf(TElementLinkRecord));
              ElementLinkRecord.Signature:=ElementLinkSignature;
              ElementLinkRecord.ModelID:=-1;
              ElementLinkRecord.ClassID:=-1;
              ElementLinkRecord.ID:=aID;
              K:=integer(pointer(ElementLinkRecord));
              FieldValue[m]:=K;
            end;
          end else begin
            GetMem(ElementLinkRecord, SizeOf(TElementLinkRecord));
            ElementLinkRecord.Signature:=ElementLinkSignature;
            ElementLinkRecord.ModelID:=-1;
            ElementLinkRecord.ClassID:=-1;
            ElementLinkRecord.ID:=aID;
            K:=integer(pointer(ElementLinkRecord));
            FieldValue[m]:=K;
          end;
        end;
      end;
    fvtBoolean:
      begin
        B:=aValue;
        FieldValue[m]:=B;
      end;
    else
    if not VarIsNull(aValue) then
      FieldValue[m]:=aValue;
    end;
  end;
end;

function TDataModel.Get_IndexCollection(Index: Integer): IDMCollection;
begin
  Result:=nil
end;

procedure TDataModel.MakeSelectSource(Index: Integer;
  const aRefSource: IDMCollection);
begin
end;

procedure TDataModel.AfterPaste;
begin

end;

procedure TDataModel.BeforePaste;
begin

end;

function TDataModel.Get_Presence: integer;
begin
  Result:=0
end;

procedure TDataModel.Set_Presence(Value: Integer);
begin

end;

function TDataModel.Get_EmptyBackRefHolder: IDMElement;
begin
  Result:=nil
end;

procedure TDataModel.Set_EmptyBackRefHolder(const Value: IDMElement);
begin
end;

procedure TDataModel.UpdateCoords;
begin
end;

procedure TDataModel.AfterCopyFrom(const SourceElement: IDMElement);
begin
end;

function TDataModel.Get_FieldCategory(Index: integer): WideString;
begin
  Result:='Настройки'
end;

function TDataModel.Get_FieldCategoryCount: integer;
begin
  Result:=1;
end;

function TDataModel.Get_Exists: WordBool;
begin
  Result:=FExists
end;

procedure TDataModel.Set_Exists(Value: WordBool);
begin
  FExists:=Value
end;

function TDataModel.Get_DefaultSubKindIndex: integer;
begin
  Result:=-1
end;

procedure TDataModel.Set_DefaultSubKindIndex(Value: integer);
begin
end;

function TDataModel.GetCollectionForChild(
  const aChild: IDMElement): IDMCollection;
begin
  Result:=Collection[aChild.ClassID]
end;

function TDataModel.CreateCollection(aClassID: integer; const aParent:IDMElement): IDMCollection;
var
  CollectionClass:TDMCollectionClass;
begin
  if aClassID=-1 then
    Result:=TDMCollection.Create(aParent) as IDMCollection
  else begin
    CollectionClass:=TDMCollectionClass(FClassList[aClassID]);
    Result:=CollectionClass.Create(aParent) as IDMCollection;
  end;
end;

procedure TDataModel.MakeFieldValues;
var
  Field:IDMField;
  j:integer;
  DefaultValue:Variant;
  aCollection:IDMCollection;
begin
  try
  for j:=0 to FieldCount-1 do begin
    Field:=Get_Field(j);
    case Field.ValueType of
    fvtInteger, fvtFloat, fvtBoolean, fvtColor, fvtChoice:
      FieldValue[j]:=Field.DefaultValue;
    fvtString:
      FieldValue[j]:=Field.ValueFormat;
    fvtElement:
      begin
        if Field.DefaultValue=-1 then
          DefaultValue:=NilUnk
        else begin
          aCollection:=nil;
          GetFieldValueSource(Field.Code, aCollection);
          if (aCollection<>nil) and
             (Field.DefaultValue<aCollection.Count) then
            DefaultValue:=aCollection.Item[round(Field.DefaultValue)]
          else
            DefaultValue:=NilUnk;
        end;
        FieldValue[j]:=DefaultValue;
      end;
    else
      FieldValue[j]:='';
    end;
  end;
  except
    raise
  end;
end;

function TDataModel.FieldIsReadOnly(Index: integer): WordBool;
begin
  Result:=False
end;

function TDataModel.Get_XXXRefCount: integer;
begin
  Result:=FXXXRefCount
end;

procedure TDataModel.Set_XXXRefCount(Value: integer);
begin
  FXXXRefCount:=Value
end;

procedure TDataModel.Set_DataModel(const Value: IDataModel);
begin
  FDataModel:=pointer(Value)
end;

function TDataModel.CompartibleWith(const aElement: IDMElement): WordBool;
begin
  Result:=False
end;

procedure TDataModel.HandleError(const ErrorMessage:WideString);
begin
  raise Exception.Create(ErrorMessage);
end;

procedure TDataModel.CheckErrors;
begin
end;

function TDataModel.Get_FieldName(Index: Integer): WideString;
var
  FieldE:IDMElement;
begin
  FieldE:=Get_Field_(Index) as IDMElement;
  Result:=FieldE.Name
end;

procedure TDataModel.AfterCopyFrom2;
begin
end;

function TDataModel.Get_FieldFormat(Index: Integer): WideString;
var
  Field:IDMField;
begin
  Field:=Get_Field_(Index);
  Result:=Field.ValueFormat
end;

function TDataModel.Get_IsSelectable: WordBool;
begin
  Result:=True
end;

function TDataModel.IsSimilarTo(const aElement: IDMElement): WordBool;
begin
  Result:=False;
end;

procedure TDataModel.AfterMoveInCollection;
begin
end;

function TDataModel.Get_SelectRef: WordBool;
begin
  Result:=False
end;

function TDataModel.GetElementCollectionCount(
  const aElement: IDMElement): Integer;
begin
   if aElement<>nil then
     Result:=aElement.CollectionCount
   else
     Result:=0
end;

function TDataModel.GetElementFieldVisible(const aElement: IDMElement;
  Code: Integer): WordBool;
begin
  try
   if aElement<>nil then
     Result:=aElement.FieldIsVisible(Code)
   else
     Result:=False
  except
    raise
  end;  
end;

procedure TDataModel.AddToHash(const aElement: IDMElement);
var
  aClassID, aID:integer;
  HashTable:THashTable;
begin
  if aElement=nil then Exit;
  aClassID:=aElement.ClassID;
  aID:=aElement.ID;
  HashTable:=FHashList[aClassID];
  HashTable.Insert(IntToStr(aID), pointer(aElement));
end;

function TDataModel.GetFromHash(aClassID, aID: Integer): IDMElement;
var
  HashTable:THashTable;
  P:pointer;
begin
  HashTable:=FHashList[aClassID];
  if HashTable.Search(IntToStr(aID), P) then
    Result:=IDMElement(P)
  else
    Result:=nil
end;

function TDataModel.KeepHash: boolean;
begin
  Result:=False;
end;


procedure TDataModel.WriteToXML(const aXMLU: IInterface; WriteInstance:WordBool);
var
  S:string;
  aXML:IDMXML;
begin
  aXML:=aXMLU as IDMXML;
  S:=Format('<MDL ID="%d">',[ID]);
  aXML.WriteXMLLine(S);
  DoWriteToXML(aXML);
  S:='</MDL>';
  aXML.WriteXMLLine(S);
end;

procedure TDataModel.WriteCollectionsToXML(aXML:IDMXML);
var
  j:integer;
begin
  for j:=0 to CollectionCount-1 do begin
    if (Collection[j]<>nil) and
       (Collection[j].Count>0) then begin
      (Collection[j] as IDMCollectionXML).WriteToXML(aXML, True, j);
    end;
  end;      
end;

procedure TDataModel.WriteFieldValuesToXML(aXML:IDMXML);
var
  j, N:integer;
  FieldE:IDMElement;
  Field:IDMField;
  S:string;
  Unk:IUnknown;
  V:OleVariant;
  F:double;
  aElement:IDMElement;
begin
  N:=Get_FieldCount;
  for j:=0 to N-1 do begin
    Field:=Get_Field(j);
    FieldE:=Field as IDMElement;
    V:=FieldValue[j];

    S:=Format('<FLD ID="%d">',[Field.Code]);
    aXML.WriteXMLLine(S);
    aXML.IncLevel;
    case Field.ValueType of
    fvtFloat:
      begin
        F:=V;
        S:=Format(Field.ValueFormat, [F]);
        aXML.WriteXMLLine(S);
      end;
    fvtElement:
      begin
        Unk:=V;
        aElement:=Unk as IDMElement;
        if aElement=nil then
          S:='nil'
        else
          S:=Format('<FLN ID="%d" CID="%d"/>',[aElement.ID, aElement.ClassID]);
        aXML.WriteXMLLine(S);
      end;
    else
      begin
        S:=V;
        aXML.WriteXMLLine(S);
      end;
    end;
    aXML.DecLevel;
    S:='</FLD>';
    aXML.WriteXMLLine(S);
  end;
end;

procedure TDataModel.WriteRefToXML(aXML: IDMXML);
var
  S:string;
begin
  if Ref=nil then Exit;
  S:=Format('<REF ID="%d" CID="%d"/>',[Ref.ID, Ref.ClassID]);
  aXML.WriteXMLLine(S);
end;

procedure TDataModel.ProcessXMLString(const S: WideString;
  TagFlag: WordBool);
var
  Element, aElement:IDMElement;
  N, aID, aCID, aMID, j, j1, L:integer;
  S1, SS:string;
  aCollection:IDMCollection;
  aCollection2:IDMCollection2;
  ElmFlag, RefFlag, PrnFlag, FldFlag, LstFlag, LnkFlag, FlnFlag:boolean;
  SubModelE:IDMElement;
  V:OleVariant;
  Unk:IUnknown;
  HashTable:THashTable;
  aDMHash:IDMHash;
begin
  N:=FXMLStack.Count;
  L:=length(S);
  if N>0 then
    Element:=IDMElement(FXMLStack[N-1])
  else
    Element:=nil;

  try
  if not TagFlag then begin
    if FXMLFieldCode<>-1 then begin
      if S='True' then
        V:=True
      else
      if S='False' then
        V:=False
      else
        V:=S;

      Element.SetFieldValue(FXMLFieldCode, V);
    end else begin
      Element.Name:=S;
      if Element.QueryInterface(IDataModel, Unk)=0 then begin
        SS:=ExtractFileName(S);
        FNextLoadStageCaption:=rsLoadingFile+' '+SS;
      end;
    end;
  end else begin
    if Pos('MDL', S)=1 then begin
       FXMLStack.Add(pointer(Self as IDMElement));
       FXMLFieldCode:=-1;

       for j:=0 to CollectionCount-1 do begin
         HashTable:=THashTable.Create(False);
         FHashList.Add(HashTable);
       end;

    end else
    if Pos('/', S)=1 then
       FXMLStack.Delete(N-1)
    else begin
      ElmFlag:=(Pos('ELM', S)=1);
      RefFlag:=(Pos('REF', S)=1);
      PrnFlag:=(Pos('PRN', S)=1);
      FldFlag:=(Pos('FLD', S)=1);
      FlnFlag:=(Pos('FLN', S)=1);
      LstFlag:=(Pos('LST', S)=1);
      LnkFlag:=(Pos('LNK', S)=1);
      if ElmFlag or
         RefFlag or
         PrnFlag or
         FldFlag or
         FlnFlag or
         LstFlag or
         LnkFlag then begin
       if (S[L]<>'/') and
          not ElmFlag then
         FXMLStack.Add(pointer(Element));

       if not FlnFlag then
         FXMLFieldCode:=-1;

        j:=Pos('ID=', S);
        if j<>0 then begin
          S1:=System.Copy(S, j+4, L-j-3);
          j1:=Pos('"', S1);
          SS:=System.Copy(S1, 1, j1-1);
          aID:=StrToInt(SS);
        end else
          aID:=-1;

        if aID>=0 then begin
          if FldFlag then
            FXMLFieldCode:=aID;

          j:=Pos('CID=', S);
          if j<>0 then begin
            S1:=System.Copy(S, j+5, L-j-4);
            j1:=Pos('"', S1);
            SS:=System.Copy(S1, 1, j1-1);
            aCID:=StrToInt(SS);
          end else
            aCID:=-1;

          if LstFlag then begin
            aCollection:=Get_Collection(aID);
            SS:=rsLoading+#13+'"'+aCollection.ClassAlias[0]+'"';
            NextLoadStage(FNextLoadStageCaption, SS, j, 0);
          end;

          if aCID>=0 then begin

            j:=Pos('MID=', S);
            if j<>0 then begin
              S1:=System.Copy(S, j+5, L-j-4);
              j1:=Pos('"', S1);
              SS:=System.Copy(S1, 1, j1-1);
              aMID:=StrToInt(SS);
            end else
              aMID:=-1;

            if aMID=-1 then begin
              aCollection:=Get_Collection(aCID);
              aDMHash:=Self as IDMHash;
            end else begin
              SubModelE:=Get_SubModel(aMID) as IDMElement;
              aCollection:=SubModelE.Collection[aCID];
              aDMHash:=SubModelE as IDMHash;
            end;
            aCollection2:=aCollection as IDMCollection2;
//            aElement:=aCollection2.GetItemByID(aID);
            aElement:=aDMHash.GetFromHash(aCID, aID);
            if aElement=nil then begin
              aElement:=aCollection2.CreateElement(False);
              aCollection2.Add(aElement);
              aElement.ID:=aID;
              AddToHash(aElement);
            end;
            if ElmFlag then begin
              FXMLStack.Add(pointer(aElement));
              if Element.QueryInterface(IDataModel, Unk)<>0 then
                aElement.Parent:=Element;
            end else
            if RefFlag then
              Element.Ref:=aElement
            else
            if PrnFlag then
              Element.Parent:=aElement
            else
            if LnkFlag then
//              aElement.AddParent(Element)
              Element.AddParent(aElement)
            else
            if FlnFlag then begin
              Element.SetFieldValue(FXMLFieldCode, aElement);
            end;
          end;
        end;
      end;
    end;
  end;
  except
    raise
  end;
end;

procedure TDataModel.DoWriteToXML(const aXMLU: IInterface);
var
  aXML:IDMXML;
begin
  aXML:=aXMLU as IDMXML;

  aXML.IncLevel;
  aXML.WriteXMLLine(Name);

  if Ref<>nil then
    WriteRefToXML(aXML);
  WriteFieldValuesToXML(aXML);
  WriteCollectionsToXML(aXML);
  aXML.DecLevel;
end;


function TDataModel.Get_SelectParent: WordBool;
begin
  Result:=False
end;

function TDataModel.Get_ApplicationVersion: WideString;
begin
  Result:=FApplicationVersion
end;

procedure TDataModel.Set_ApplicationVersion(const Value: WideString);
begin
  FApplicationVersion:=Value
end;

function TDataModel.Get_State: integer;
begin
  Result:=FState;
end;

procedure TDataModel.Set_State(Value: integer);
begin
  FState:=Value;
end;

end.
