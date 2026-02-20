unit DMElementU;

interface
uses
  DM_Windows, DM_ComObj,
  Classes, SysUtils, Math,
  DataModel_TLB, MyDB, Variants,
  DMServer_TLB, DMComObjectU;

const
  InfinitValue=1000000000;
  SuffixDivider='/';
var
  NilUnk:IUnknown=nil;
  XXX:integer;
  LocalDecimalSeparator:Char;

const
  mpParameterValueType=0;
  mpParameterDefaultValue=1;
  mpParameterMinValue=2;
  mpParameterMaxValue=3;
  mpParameterValueFormat=4;
  mpParameterCode=5;
  mpParameterModifier=6;
  mpParameterLevel=7;
  mpParameterHint=8;
  mpParameterShortName=8;

  pkInput = $00000001;
  pkOutput = $00000002;
  pkUserDefined = $00000004;
  pkComment = $00000008;
  pkView = $00000010;
  pkAnalysis = $00000020;
  pkAdditional1 = $00000040;
  pkAdditional2 = $00000080;

  pkPrice = $00000040;
  pkAdditional = $00000080;

  pkDontSave = $10000000;
  pkChart    = $20000000;
  pkDontShow = $40000000;

  esExists=1;
  esSelected=2;

resourcestring
  rsParameterValueType    ='Тип параметра';
  rsParameterDefaultValue ='Значение параметра по умолчанию';
  rsParameterMinValue     ='Минимальное значение параметра';
  rsParametermaxValue     ='Максимальное значение параметра';
  rsParameterValueDimension='Размерность параметра';
  rsParameterValueFormat  ='Формат параметра';
  rsParameterCode         ='Код параметра';
  rsParameterModifier       ='Доступ к параметру';
  rsParameterLevel        ='Уровень параметра';
  rsParameterHint         ='Подсказка';
  rsParameterShortName    ='Сокращенное имя';
  rsValue                 ='Значение';
  rsDMArrayDimensions     ='Параметры способа';
  rsDMArrayValues         ='Вектор значений';
  rsValueMatrix           ='Матрица значений';
  rsDimValues             ='Варианты значений параметра';
  rsDimensionIndex        ='Индекс размерности';
  rsDimensionIndex_       ='Индекс размерности_';
  rsDMBackRefHolder       ='Тип элемента модели';
  rsInteger               ='Целое число';
  rsFloat                 ='Число с плавающей точкой';
  rsBoolean               ='Логическое значение';
  rsString                ='Строка';
  rsElement               ='Элемент модели';
  rsText                  ='Текст';
  rsColor                 ='Цвет';
  rsFile                  ='Файл';
  rsChoice                ='Выбор из списка';
  rsReadWrite             ='Чтение и запись';
  rsReadOnly              ='Только чтение';
  rsUserDefined           ='Запись возможна по условию';
  rsInputParameters       ='Исходные данные';
  rsOutputParameters      ='Результаты';
  rsUserDefinedParameters ='Данные пользователя';
  rsComments              ='Примечания';
  rsViewParameters        ='Вид';
  rsPriceParameters       ='Стоимостные параметры';
  rsAnalysisParameters    ='Параметры анализа';
  rsAdditionalParameters  ='Прочие данные';

type
  MyException=class(Exception);

  TDMElementClass=class of TDMElement;
  TDMElement=class(TDMComObject, IDMElement, IDMTreeNode, IDMElementXML)
  private
    FRef:pointer;
    FID:integer;
    FState:byte;
    procedure SaveParentToRecordSet(const aRecordSetU: IUnknown);
    procedure SaveRefToRecordSet(const aRecordSetU: IUnknown);
    procedure SaveFieldValuesToRecordSet(const aRecordSetU: IUnknown);
    procedure LoadParentFromRecordSet(const aRecordSetU: IUnknown);
    procedure LoadRefFromRecordSet(const aRecordSetU: IUnknown);
    procedure LoadFieldValuesFromRecordSet(const aRecordSetU: IUnknown);
    procedure LoadedParent;
    procedure LoadedRef;
    procedure LoadedFieldValues;
    function SearchNewRef(const DataModelE: IDMElement; aRefClassID, aRefID: integer): WordBool;
  protected
    FParent:pointer;
    
//  IDMElement
    function  Get_Name: WideString; virtual; safecall;
    procedure Set_Name(const Value: WideString); virtual; safecall;
    function  Get_Parent: IDMElement; safecall;
    procedure Set_Parent(const Value: IDMElement); virtual; safecall;
    function  Get_MainParent: IDMElement; virtual; safecall;
    function  Get_Ref: IDMElement; safecall;
    procedure Set_Ref(const Value: IDMElement);  virtual; safecall;
    function  Get_SpatialElement: IDMElement; virtual; safecall;
    procedure Set_SpatialElement(const Value: IDMElement); virtual; safecall;
    function  Get_ID: Integer; safecall;
    procedure Set_ID(Value: Integer); safecall;
    function  Get_OwnerCollection: IDMCollection; virtual; safecall;
    function  Get_ClassID: Integer; safecall;
    procedure Clear; override; safecall;
    procedure DisconnectFrom(const aElement:IDMElement); virtual; safecall;
    procedure AddParent(const aParent:IDMElement); virtual; safecall;
    procedure RemoveParent(const aParent:IDMElement); virtual; safecall;
    procedure AddChild(const aChild:IDMElement); virtual; safecall;
    procedure RemoveChild(const aChild:IDMElement); virtual; safecall;
    function GetCollectionForChild(const aChild: IDMElement): IDMCollection; virtual; safecall;
    function  Includes(const aElement: IDMElement): WordBool; safecall;
    procedure SaveToRecordSet(const aRecordSetU:IUnknown); virtual; safecall;
    procedure LoadFromRecordSet(const aRecordSetU:IUnknown); virtual; safecall;
    procedure SaveParentsToRecordSet(const aRecordSetU: IUnknown); safecall;
    procedure AddParentFromRecordSet(const aRecordSetU: IUnknown); safecall;
    procedure LoadDataFromRecordSet(const aRecordSetU: IUnknown); safecall;
    procedure Loaded; virtual; safecall;
    function  Get_CollectionCount: Integer; virtual; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; virtual; safecall;
    function  Get_CollectionU(Index: Integer): IUnknown; virtual; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); virtual; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); virtual; safecall;
    function  Get_Parents: IDMCollection; virtual; safecall;
    procedure Set_DefaultSubKindIndex(Value: integer); virtual; safecall;
    function  Get_DefaultSubKindIndex: integer; virtual; safecall;
    function  Get_SubKinds: IDMCollection; virtual; safecall;
    function  Get_BackRefCount: Integer; virtual; safecall;
    procedure _AddBackRef(const aElement: IDMElement); virtual; safecall;
    procedure _RemoveBackRef(const aElement: IDMElement); virtual; safecall;
    function  Get_FieldCount: Integer; virtual; safecall;
    function  Get_FieldName(Index: Integer): WideString; virtual; safecall;
    function  Get_FieldFormat(Index: Integer): WideString; virtual; safecall;
    function  Get_Field(Index: Integer): IDMField; virtual; safecall;
    function  Get_FieldValue(Index: Integer): OleVariant; virtual; safecall;
    procedure Set_FieldValue(Index: Integer; Value: OleVariant); virtual; safecall;
    function  Get_FieldCount_: Integer; virtual; safecall;
    function  Get_Field_(Index: Integer): IDMField; virtual; safecall;
    function  Get_FieldValue_(Index: Integer): OleVariant; virtual; safecall;
    procedure Set_FieldValue_(Index: Integer; Value: OleVariant); virtual; safecall;
    function  GetFieldValue(Code: integer): OleVariant; virtual; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); virtual; safecall;
    procedure CalculateFieldValues; virtual; safecall;
    procedure GetFieldValueSource(Code: Integer; var aCollection: IDMCollection); virtual; safecall;
    function  Get_FieldCategoryCount:integer; virtual; safecall;
    function  Get_FieldCategory(Index:integer):WideString; virtual; safecall;
    procedure ClearOp; virtual; safecall;
    function  GetCopyLinkMode(const aLink: IDMElement): Integer; virtual; safecall;
    function  Get_BuildIn: WordBool; virtual; safecall;
    procedure Set_BuildIn(Value: WordBool); virtual; safecall;
    function  FieldIsVisible(Code:integer):WordBool; virtual; safecall;
    function  FieldIsReadOnly(Index:integer):WordBool; virtual; safecall;
    function  Get_Selected: WordBool; virtual; safecall;
    procedure Set_Selected(Value: WordBool); virtual; safecall;
    function  Get_Exists: WordBool; virtual; safecall;
    procedure Set_Exists(Value: WordBool); virtual; safecall;
    procedure BuildReport(ReportLevel: Integer; TabCount: Integer; Mode: Integer;
                          const Report: IDMText); virtual; safecall;
    function Get_ReportModeCount:integer; virtual; safecall;
    function Get_ReportModeName(Index:integer):WideString; virtual; safecall;
    function  Get_UserDefineded: WordBool; virtual; safecall;
    function  Get_IsEmpty: WordBool; virtual; safecall;
    function  Get_IsSelectable: WordBool; virtual; safecall;
    function  Get_SelectRef: WordBool; virtual; safecall;
    function  Get_SelectParent: WordBool; virtual; safecall;

    property Name: WideString read Get_Name write Set_Name;
    property Parent: IDMElement read Get_Parent write Set_Parent;
    property Ref: IDMElement read Get_Ref write Set_Ref;
    property SpatialElement: IDMElement read Get_SpatialElement write Set_SpatialElement;
    property ID: Integer read Get_ID write Set_ID;
    property OwnerCollection: IDMCollection read Get_OwnerCollection;
    property ClassID: Integer read Get_ClassID;
    property DataModel: IDataModel read Get_DataModel;
    property FieldCount: Integer read Get_FieldCount;
//    property Field[Index: Integer]: IDMField read Get_Field;
//    закоментировано, для исключения конфликта с DAO_TLB 
    property CollectionCount: Integer read Get_CollectionCount;
    property Collection[Index: Integer]: IDMCollection read Get_Collection;
    property Parents: IDMCollection read Get_Parents;
    property SubKinds: IDMCollection read Get_SubKinds;
    property BackRefCount: Integer read Get_BackRefCount;
    property FieldValue[Index: Integer]: OleVariant read Get_FieldValue write Set_FieldValue;
    property BuildIn: WordBool read Get_BuildIn write Set_BuildIn;
    property Selected: WordBool read Get_Selected write Set_Selected;
    property Exists: WordBool read Get_Exists write Set_Exists;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); virtual; safecall;
    procedure Update;  virtual; safecall;
    procedure UpdateCoords;  virtual; safecall;
    procedure AfterLoading1; virtual; safecall;
    procedure AfterLoading2; virtual; safecall;
    procedure JoinSpatialElements(const aElement:IDMElement); virtual; safecall;
    procedure BeforeDeletion; virtual; safecall;
    function  Get_Presence:integer; virtual; safecall;
    procedure Set_Presence(Value: Integer); virtual; safecall;
    procedure AfterCopyFrom(const SourceElement:IDMElement); virtual; safecall;
    procedure AfterCopyFrom2; virtual; safecall;
    function  CompartibleWith(const aElement:IDMElement):WordBool; virtual; safecall;

// реализация интерфейса IDMTreeNode
    function  Get_DrawItalic: WordBool; safecall;
    property  DrawItalic: WordBool read Get_DrawItalic;

    procedure WriteRefToXML(aXML:IDMXML);
    procedure WriteParentToXML(aXML:IDMXML);
    procedure WriteFieldValuesToXML(aXML:IDMXML);
    procedure WriteCollectionsToXML(aXML:IDMXML); virtual;

//IDMElementXML
    procedure DoWriteToXML(const aXMLU: IUnknown); safecall;
    procedure WriteToXML(const aXMLU: IUnknown; WriteInstance:WordBool); safecall;

//  защищенные методы
    function GetDeletedObjectsClassID:integer; virtual;
    function GetDefaultName:string; virtual;
    procedure Initialize; override;
    procedure _Destroy; virtual;
    procedure _AddChild(const aChild:IDMElement); virtual;
    procedure _RemoveChild(const aChild:IDMElement); virtual;
    procedure MakeFieldValues; virtual;
    procedure SetUnkValue(var U: Variant; const Value: OleVariant);
    function GetParameterValues:IDMCollection; virtual;
    function GetParameters:IDMCollection; virtual;
    function IsSimilarTo(const aElement:IDMElement):WordBool; safecall;

//  методы класса
    class function  StoredName: WordBool; virtual;
    class function  GetClassID: Integer; virtual;
    class function  GetFields:IDMCollection; virtual;
    class procedure MakeFields;
    class procedure MakeFields0; virtual;
    class procedure MakeFields1; virtual;
    class procedure AddField(
     aName, aValueFormat, aHint, aShortName: String;
     aValueType: Integer;
     aDefaultValue, aMinValue, aMaxValue: Double;
     aCode, aModifier, aLevel: Integer);
  public
    constructor Create(aDataModel:IDataModel); virtual;
    destructor Destroy; override;
  end;

  TNamedDMElement=class(TDMElement, IDMElement)
  private
    FName:string;
  protected
// реализация интерфейса IDMElement
    function  Get_Name: WideString; override; safecall;
    procedure Set_Name(const Value: WideString); override; safecall;
    class function  StoredName: WordBool; override;
  end;

  TCustomDMCollection=class(TDMComObject, IDMCollection, IDMCollectionXML)
  protected
// реализация интерфейса IDMCollection
    function  Get_Count: Integer; virtual; safecall;
    function  Get_Item(Index: Integer): IDMElement; virtual;  safecall;
    function  Get_ClassAlias(Index: Integer): WideString; virtual; safecall;
    function  Get_ClassID: Integer; virtual; safecall;
    function  IndexOf(const aElement: IDMElement): Integer; virtual; safecall;
    function  Get_Parent: IDMElement; safecall;
    procedure Set_Parent(const Value: IDMElement); virtual; safecall;
    function  Get_DataModel: IDataModel; override; safecall;
    function  Get_HasFields:WordBool; virtual; safecall;

    class function GetElementClass: TDMElementClass; virtual;

//IDMCollectionXML
    procedure WriteToXML(const aXMLU: IUnknown;
                         WriteInstances:WordBool; Index:integer); safecall;

    property ElementClass:TDMElementClass read GetElementClass;
  public
    constructor Create(const aParent:IDMElement);
  end;

  TDMText=class(TDMComObject, IDMText)
  private
    FLines:TStringList;
  protected
// реализация интерфейса IDMText
    function  Get_LineCount: Integer; safecall;
    function  Get_Line(Index: Integer): WideString; safecall;
    procedure AddLine(const Value: WideString); safecall;
    procedure ClearLines; safecall;

    procedure Initialize; override;
  public
    destructor Destroy; override;
  end;

  TDMCollection=class(TCustomDMCollection, IDMCollection2, IDMCollection3, IDMTreeNode)
  private
    FList:TList;
  protected
// реализация интерфейса IDMCollection
    function  Get_Count: Integer; override; safecall;
    function  Get_Item(Index: Integer): IDMElement; override; safecall;
    function IndexOf(const aElement: IDMElement):integer; override; safecall;
// реализация интерфейса IDMCollection2
    function  GetItemByID(aID: Integer): IDMElement; virtual; safecall;
    function  GetItemByRef(const aRef: IDMElement): IDMElement; safecall;
    function  GetItemByRefParent(const aElement: IDMElement): IDMElement; safecall;
    function  GetItemByName(const aName: WideString): IDMElement; safecall;
    function  ShiftElement(const aElement: IDMElement; Shift: Integer): Integer; safecall;
    function  Get_ClassID: Integer; override; safecall;
    function  MakeDefaultName(const ParentElement: IDMElement): WideString; safecall;
    function  CreateElement(BuildIn: WordBool): IDMElement; virtual; safecall;
    procedure Add(const aElement: IDMElement); virtual; safecall;
    procedure Insert(Index: Integer; const aElement: IDMElement); virtual; safecall;
    procedure Remove(const aElement: IDMElement); virtual; safecall;
    procedure Clear; override; safecall;
    procedure DisconnectFrom(const aParent: IDMElement); virtual; safecall;
    procedure Sort(const Sorter:ISorter); safecall;
    procedure Delete(Index: Integer); virtual; safecall;
    procedure Move(OldIndex: Integer; NewIndex: Integer); virtual; safecall;
    function  Get_ElementContainer:IDMCollection; virtual; safecall;
    procedure SaveToDatabase(const aDatabaseU: IUnknown); virtual; safecall;
    procedure Loaded; safecall;
    procedure LoadFromDatabase(const aDatabaseU:IUnknown); virtual; safecall;
    procedure LoadedFromDatabase(const aDatabaseU:IUnknown); virtual; safecall;
    function  MakeParentsTable(const aDatabaseU: IUnknown): IUnknown; safecall;
    function  CanContain(const aElement: IDMElement): WordBool; virtual; safecall;
    function  IsEqualTo(const aCollection:IDMCollection):WordBool; safecall;
    function  Get_StoredNames: WordBool; safecall;
    function IsSimilarTo(const aCollection:IDMCollection; LinkType:integer):WordBool; safecall;
    function GetItemSimilarTo(const aElement:IDMElement):IDMElement; safecall;

    property Count: Integer read Get_Count;
    property Item[Index: Integer]: IDMElement read Get_Item;
    property ClassAlias[Index: Integer]: WideString read Get_ClassAlias;
    property ClassID: Integer read Get_ClassID;
// реализация интерфейса IDMCollection3
    function  Get_ClassAlias2(Index: Integer): WideString; virtual; safecall;

// реализация интерфейса IDMTreeNode
    function  Get_DrawItalic: WordBool; safecall;
    property DrawItalic: WordBool read Get_DrawItalic;

// защищенные методы
    class function  GetElementGUID:TGUID; virtual;
// защищенные свойства
    procedure Initialize; override;
  public
    destructor Destroy; override;
  end;

  TDMCollectionClass=class of TDMCollection;

  TSortedCollection=class(TDMCollection)
  private
    function Search(const Key: IDMElement; var Index: Integer): Boolean;
  public
    FSorter:ISorter;
    procedure Add(const aElement: IDMElement); override; safecall;
    destructor Destroy; override;
  end;

  TSortedByIDCollection=class(TSortedCollection)
  private
    function SearchID(aID:integer; var Index: Integer): Boolean;
  protected
// реализация интерфейса IDMCollection2
    function  GetItemByID(aID: Integer): IDMElement; override; safecall;
    procedure Initialize; override;
  public
  end;

  TDMField=class(TNamedDMElement, IDMField)
  private
    FValueFormat: String;
    FHint: String;
    FShortName: String;
    FValueType: Integer;
    FDefaultValue: Double;
    FMinValue: Double;
    FMaxValue: Double;
    FCode:integer;
    FModifier: Integer;
    FLevel: Integer;
  protected
// реализация интерфейса IDMField
    function  Get_ValueType: Integer; virtual; safecall;
    function  Get_DefaultValue: Double; virtual; safecall;
    function  Get_MinValue: Double; virtual; safecall;
    function  Get_MaxValue: Double; virtual; safecall;
    function  Get_ValueFormat: WideString; virtual; safecall;
    function  Get_Modifier: Integer; virtual; safecall;
    function  Get_Level: Integer; virtual; safecall;
    function  Get_Code: Integer; virtual; safecall;
    function  Get_Hint: WideString; virtual; safecall;
    function  Get_ShortName: WideString; virtual; safecall;

    procedure Set_ValueType(Value: Integer); virtual; safecall;
    procedure Set_DefaultValue(Value: Double); virtual; safecall;
    procedure Set_MinValue(Value: Double); virtual; safecall;
    procedure Set_MaxValue(Value: Double); virtual; safecall;
    procedure Set_ValueFormat(const Value: WideString); virtual; safecall;
    procedure Set_Modifier(Value: Integer); virtual; safecall;
    procedure Set_Level(Value: Integer); virtual; safecall;
    procedure Set_Code(Value: Integer); virtual; safecall;
    procedure Set_Hint(const Value: WideString); virtual; safecall;
    procedure Set_ShortName(const Value: WideString); virtual; safecall;

// реализация интерфейса IDMElement
    function  Get_OwnerCollection: IDMCollection; override; safecall;
  end;

  TDMFields=class(TDMCollection)
  protected
// реализация интерфейса IDMCollection
    procedure DisconnectFrom(const aParent: IDMElement); override; safecall;
// защищенные методы
    class function GetElementClass: TDMElementClass; override;
  end;

  TDMParameter=class(TDMField)
  private
    FParents:IDMCollection;
  protected
    function  Get_Parents: IDMCollection; override; safecall;
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TDMParameterValue=class(TDMElement, IDMParameterValue)
  private
    FValue:OleVariant;
  protected
    function  Get_Value: OleVariant; safecall;
    procedure Set_Value(aValue: OleVariant); safecall;
    function  Get_Parameter: IDMField; safecall;
    function Get_FieldValue(Index: integer): OleVariant; override;
    procedure Set_FieldValue(Index: integer; aValue: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    property Value: OleVariant read Get_Value write Set_Value;
    property Parameter: IDMField read Get_Parameter;
  end;

  TDMArrayDimItem=class(TDMParameter)
  private
  protected
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function Get_Code: Integer; override;
    function Get_Level: Integer; override;
    function Get_Modifier: Integer; override;
    function Get_ValueFormat: WideString; override;
    function Get_ValueType: Integer; override;
  end;

  TDMArrayDimension=class(TNamedDMElement, IDMArrayDimension)
  private
  protected
    FSubArrayIndex:integer;
    FNextDimensionIndex:integer;
    FDimItems:IDMCollection;
    function Get_DimItems:IDMCollection; safecall;
    function Get_SubArrayIndex:integer; safecall;
    function  Get_NextDimensionIndex:integer; safecall;
    procedure Set_NextDimensionIndex(Value:integer); safecall;
    procedure SetNextDimensionIndexes;

    procedure _AddChild(const aChild:IDMElement); override;
    procedure _RemoveChild(const aChild:IDMElement); override;
    procedure Set_Parent(const Value:IDMElement); override;

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

  TDMArray=class(TNamedDMElement, IDMArray)
  private
    FArrayValue:IDMArrayValue;
    FSubArrayList:TList;
  protected
    FDimensions:IDMCollection;
    function  Get_Dimensions: IDMCollection; safecall;
    function  Get_ArrayValue: IDMArrayValue; safecall;
    procedure BuildNextDimensionIndexes; safecall;
    function  Get_SubArrayCount:integer; safecall;
    function  Get_SubArrayDimensionIndex(Index:integer):integer; safecall;

    function  CreateValue:IDMElement; virtual; safecall;
    procedure RemoveValue(const aValue:IDMElement); virtual; safecall;

    procedure AddChild(const aChild:IDMElement); override;
    procedure RemoveChild(const aChild:IDMElement); override;
    procedure Clear; override;
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

  TDMArrayValue=class(TDMElement, IDMArrayValue, IDMCollection)
  private
    FValue:double;
    FDimensionIndex:integer;
  protected
    FArrayValues:IDMCollection;

    class procedure MakeFields0; override;
    class function GetFields:IDMCollection; override;
    function  Get_FieldCount: Integer; override; safecall;
    function  Get_Field(Index: Integer): IDMField; override; safecall;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;

    function  Get_ArrayValues:IDMCollection; safecall;
    function  Get_Name:WideString; override; safecall;
    function  Get_Value: Double; safecall;
    procedure Set_Value(aValue: Double); safecall;
    procedure InsertValues; safecall;
    procedure DeleteValues(aValueIndex, aDimensionIndex:integer); safecall;
    function Get_DMArray: IDMArray; safecall;
    function Get_DimensionIndex:integer; safecall;
    procedure Set_DimensionIndex(aDimensionIndex:integer); safecall;

    function  Get_CollectionCount: Integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function  Get_Count: Integer; safecall;
    function  Get_Item(Index: Integer): IDMElement; safecall;
    function  Get_ClassAlias(Index: Integer): WideString; safecall;
    function  IndexOf(const aElement: IDMElement): Integer; safecall;
    function  Get_HasFields:WordBool; virtual; safecall;


    procedure Initialize; override;
    procedure _Destroy; override;

  end;

  TDMBackRefHolder=class(TDMElement, IDMBackRefHolder)
  private
    FBackRefs:IDMCollection;
    FOverCount:integer;
  protected
    function Get_BackRefs:IDMCollection; safecall;
    function Get_OverCount:integer; safecall;
    procedure Set_OverCount(Value:integer); safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;


  TDMBackRefHolders=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

const
  ElementLinkSignature=$FFFE;
type
  PElementLinkRecord=^TElementLinkRecord;
  TElementLinkRecord=record
    Signature:integer;
    ModelID:integer;
    ClassID:integer;
    ID:integer;
  end;

implementation
uses
  ComServ,
  DataModelU,
  SorterU;

var
  FParameterFields:IDMCollection;
  FParameterValueFields:IDMCollection;
  FDMArrayValueFields:IDMCollection;
  FDMArrayDimItemFields:IDMCollection;

{ TDMElement }

function TDMElement.Get_OwnerCollection: IDMCollection;
var
  ClassID:integer;
  aDataModel:IDMElement;
begin
  ClassID:=Get_ClassID;
  if ClassID=-1 then
    Result:=nil
  else begin
    aDataModel:=Get_DataModel as IDMElement;
    try
    if aDataModel<>nil then
      Result:=(Get_DataModel as IDMElement).Collection[ClassID]
    else
      Result:=nil
    except
      raise
    end    
  end;
end;

function TDMElement.Get_ID: Integer;
begin
  Result:=FID;
end;

procedure TDMElement.Set_ID(Value: Integer);
begin
  FID:=Value
end;

function TDMElement.Get_Name: WideString;
begin
  if FRef<>nil then
    Result:=Ref.Name
  else
    Result:=GetDefaultName
end;

procedure TDMElement.Set_Name(const Value: WideString);
begin
end;


function TDMElement.Get_Parent: IDMElement;
begin
  Result:=IDMElement(FParent)
end;

procedure TDMElement.Set_Parent(const Value: IDMElement);
begin
  try
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
  except
    raise
  end  
end;

function TDMElement.Get_Ref: IDMElement;
//var
//  ElementLinkRecord:PElementLinkRecord;
begin
{  try
  if FRef=nil then begin
    Result:=nil;
    Exit;
  end;
  ElementLinkRecord:=FRef;
  if ElementLinkRecord^.Signature=ElementLinkSignature then
    Result:=nil
  else
}
    Result:=IDMElement(FRef);
{
  except
    raise
  end;
}      
end;

procedure TDMElement.Set_Ref(const Value: IDMElement);
begin
  if FRef=pointer(Value) then Exit;

  if (FRef<>nil) then begin
      if (DataModel=nil) or
         not DataModel.IsLoading or
        (((DataModel.Document as IDMDocument).State and dmfLoadingTransactions)<>0) then begin
      IDMElement(FRef)._RemoveBackRef(Self as IDMElement);
      IDMElement(FRef)._Release;
    end;
  end;

  FRef:=pointer(Value);

  if Value<>nil then begin
    Value._AddBackRef(Self as IDMElement);
    Value._AddRef;
  end;
end;

function TDMElement.GetDefaultName: string;
begin
  try
  if OwnerCollection<>nil then
    Result:=OwnerCollection.ClassAlias[akImenit] + ' '+IntToStr(FID)
  else
    Result:=ClassName + ' '+IntToStr(FID)
  except
    raise
  end
end;

function TDMElement.Get_DrawItalic: WordBool;
begin
  Result:=False
end;

function TDMElement.Get_ClassID: Integer;
begin
  Result:=GetClassID
end;

constructor TDMElement.Create(aDataModel: IDataModel);
begin
  inherited;
  FState:=FState or esExists
end;

procedure TDMElement.Clear;
var
  j:integer;
  Collection2:IDMCollection2;
  Collection:IDMCollection;
  SelfElement, OldSpatialElement:IDMElement;
  DMField:IDMField;
begin
  Set_Exists(False);
  
  if DataModel=nil then Exit;
try
  Parent:=nil;
  Ref:=nil;
except
  raise
end;
  if SpatialElement<>nil then begin
    OldSpatialElement:=SpatialElement;
    SpatialElement:=nil;
    OldSpatialElement.Ref:=nil;
  end;
  SelfElement:=Self as IDMElement;

  if Parents<>nil then
    while Parents.Count>0 do
      RemoveParent(Parents.Item[0]);

try
  if Get_OwnerCollection<>nil then
    for j:=0 to FieldCount-1 do begin
      DMField:=Get_Field(j);
      if (DMField<>nil) and
         (DMField.ValueType=fvtElement) then
        FieldValue[j]:=NilUnk;
    end;
except
  raise
end;

  j:=0;
  try
  while j<CollectionCount do begin
    Collection:=Get_Collection(j);
    if (Collection<>nil) and
       (Collection.QueryInterface(IDMCollection2, Collection2)=0) then
      Collection2.DisconnectFrom(SelfElement);
    inc(j)
  end;
  SelfElement:=nil;
  except
    raise
  end;  
  inherited;
end;

destructor TDMElement.Destroy;
begin
  if (ID=-1) and
     (ClassID=2) then
    XXX:=0;
  try
  inherited;
  _Destroy;
  except
    raise
  end;
end;

procedure TDMElement._Destroy;
begin
end;

procedure TDMElement.DisconnectFrom(const aElement: IDMElement);
begin
  if Parents<>nil then
    RemoveParent(aElement);

  if Ref=aElement then
    Ref:=nil;

  if Parent=aElement then
    Parent:=nil;
end;

procedure TDMElement.AddParent(const aParent: IDMElement);
begin
  if aParent=nil then Exit;
  if Parents=nil then Exit;
  if Parents.IndexOf(aParent)=-1 then begin
    (Parents as IDMCollection2).Add(aParent);
    aParent.AddChild(Self as IDMElement);
  end;
end;

procedure TDMElement.RemoveParent(const aParent: IDMElement);
var
  j:integer;
begin
  if aParent=nil then Exit;
  if Parents=nil then Exit;
  j:=Parents.IndexOf(aParent);
  if j<>-1 then begin
    (Parents as IDMCollection2).Delete(j);
    try
    aParent.RemoveChild(Self as IDMElement)
    except
      raise
    end
  end;
end;

function TDMElement.GetCollectionForChild(const aChild: IDMElement):IDMCollection;
var
  j:integer;
  Collection:IDMCollection;
  Collection2:IDMCollection2;
begin
  j:=0;
  while j<CollectionCount do begin
    Collection:=Get_Collection(j);
    if (Collection<>nil) and
       (Collection.QueryInterface(IDMCollection2, Collection2)=0) and
       Collection2.CanContain(aChild) then
      Break
    else
      inc(j)
  end;
  if j<CollectionCount then
    Result:=Collection
  else
    Result:=nil
end;

procedure TDMElement.AddChild(const aChild: IDMElement);
var
  Collection:IDMCollection;
  Collection2:IDMCollection2;
begin
  Collection:=GetCollectionForChild(aChild);
  if Collection<>nil then begin
    Collection2:=Collection as IDMCollection2;
    Collection2.Add(aChild);
    _AddChild(aChild);
  end else begin
    Collection2:=GetParameterValues as IDMCollection2;
    if (Collection2<>nil) and
       Collection2.CanContain(aChild) then
      Collection2.Add(aChild);
  end;
end;

procedure TDMElement.RemoveChild(const aChild: IDMElement);
var
  Collection:IDMCollection;
  Collection2:IDMCollection2;
begin
  try
  Collection:=GetCollectionForChild(aChild);
  Collection2:=Collection as IDMCollection2;
  if Collection<>nil then begin
    _RemoveChild(aChild);
    Collection2.Remove(aChild);
  end else begin
    Collection2:=GetParameterValues as IDMCollection2;
    if (Collection2<>nil) and
       Collection2.CanContain(aChild) then
      Collection2.Remove(aChild);
  end;
  except
    raise
  end;
end;

procedure TDMElement._AddChild(const aChild: IDMElement);
begin
end;

procedure TDMElement._RemoveChild(const aChild: IDMElement);
begin
end;

function TDMElement.Includes(const aElement: IDMElement): WordBool;
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

procedure TDMElement.Initialize;
begin
  inherited;
  FID:=-1;
  MakeFieldValues;
end;

procedure TDMElement.MakeFieldValues;
var
  Field:IDMField;
  j:integer;
  DefaultValue:Variant;
  aCollection:IDMCollection;
begin
  try
  if Get_OwnerCollection=nil then Exit;
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

procedure TDMElement.GetFieldValueSource(
  Code: Integer; var aCollection: IDMCollection);
begin
  aCollection:=nil
end;

procedure TDMElement.CalculateFieldValues;
begin
end;

function TDMElement.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=nil;
end;

procedure TDMElement.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString;
  out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections;
  out aOperations, aLinkType: Integer);
var
  aCollection:IDMCollection;
begin
  aRefSource:=nil;
  aCollection:=Get_Collection(Index);
  if aCollection<>nil then
    aCollectionName:=aCollection.Get_ClassAlias(akImenitM)
  else
    aCollectionName:='';
  aClassCollections:=nil;
  aOperations:=leoAdd or leoDelete or leoRename;
  aLinkType:=ltOneToMany;
end;

function TDMElement.Get_CollectionCount: Integer;
begin
  Result:=0
end;

procedure TDMElement.SaveParentsToRecordSet(const aRecordSetU:IUnknown);
var
  m:integer;
  aParent:IDMElement;
begin
  for m:=0 to Parents.Count-1 do begin
    aParent:=Parents.Item[m];
    MyDBAddRecord(aRecordSetU);
    MyDBSetFieldValue(aRecordSetU, 'ID', ID);
    if aParent.DataModel=Get_DataModel then
      MyDBSetFieldValue(aRecordSetU, 'ParentModelID', -1)
    else
      MyDBSetFieldValue(aRecordSetU, 'ParentModelID',
                     (aParent.DataModel as IDMElement).ID);
    MyDBSetFieldValue(aRecordSetU, 'ParentClassID', aParent.ClassID);
    MyDBSetFieldValue(aRecordSetU, 'ParentID', aParent.ID);
    MyDBUpdateRecordSet(aRecordSetU);
  end;
end;

procedure TDMElement.SaveParentToRecordSet(const aRecordSetU: IUnknown);
begin
  if Parent=nil then begin
    MyDBSetFieldValue(aRecordSetU, 'ParentModelID', -1);
    MyDBSetFieldValue(aRecordSetU, 'ParentClassID', -1);
    MyDBSetFieldValue(aRecordSetU, 'ParentID', -1);
  end else begin
    if Parent.DataModel=Get_DataModel then
      MyDBSetFieldValue(aRecordSetU, 'ParentModelID', -1)
    else
      MyDBSetFieldValue(aRecordSetU, 'ParentModelID',
                     (Parent.DataModel as IDMElement).ID);
    MyDBSetFieldValue(aRecordSetU, 'ParentClassID', Parent.ClassID);
    MyDBSetFieldValue(aRecordSetU, 'ParentID', Parent.ID);
  end;
end;

procedure TDMElement.SaveRefToRecordSet(const aRecordSetU: IUnknown);
begin
  if Ref=nil then begin
    MyDBSetFieldValue(aRecordSetU, 'RefModelID', -1);
    MyDBSetFieldValue(aRecordSetU, 'RefClassID', -1);
    MyDBSetFieldValue(aRecordSetU, 'RefID', -1);
  end else begin
    if Ref.DataModel=Get_DataModel then
      MyDBSetFieldValue(aRecordSetU, 'RefModelID', -1)
    else
      MyDBSetFieldValue(aRecordSetU, 'RefModelID',
                     (Ref.DataModel as IDMElement).ID);
    MyDBSetFieldValue(aRecordSetU, 'RefClassID', Ref.ClassID);
    MyDBSetFieldValue(aRecordSetU, 'RefID', Ref.ID);
  end;
end;

procedure TDMElement.SaveFieldValuesToRecordSet(const aRecordSetU: IUnknown);
var
  aElement:IDMElement;
  DMField:IDMField;
  S, FieldName:string;
  m:integer;
  Unk:IUnknown;
  Frmt:string;
  F:double;
  V:variant;
  Fields:IDMCollection;
begin
  try
  Fields:=GetFields;
  if Fields=nil then Exit;
  for m:=0 to Fields.Count-1 do begin
    DMField:=Get_Field(m);
    if (DMField.Level and pkDontSave)<>0 then
      Continue;

    S:='P'+IntToStr(m)+' '+(DMField as IDMElement).Name;
    FieldName:=Copy(S, 1, 64);
    case DMField.ValueType of
    fvtFloat:
      begin
        Frmt:=DMField.ValueFormat;
        F:=FieldValue[m];
        if IsNAN(F) then
          F:=-InfinitValue;
        if IsInfinite(F) then
          F:=InfinitValue;
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

procedure TDMElement.SaveToRecordSet(const aRecordSetU:IUnknown);
begin
  if not BuildIn then begin
    MyDBAddRecord(aRecordSetU);
    MyDBSetFieldValue(aRecordSetU, 'ID', ID);
    if StoredName then
      MyDBSetFieldValue(aRecordSetU, 'Name', Name);

    SaveRefToRecordSet(aRecordSetU);

    SaveParentToRecordSet(aRecordSetU);

    SaveFieldValuesToRecordSet(aRecordSetU);
  end;

end;

procedure TDMElement.LoadParentFromRecordSet(const aRecordSetU: IUnknown);
var
  ParentModelID, ParentClassID, ParentID:integer;
  aDataModel:IDMElement;
  ElementLinkRecord:PElementLinkRecord;
  aParent:IDMElement;
begin
  ParentModelID:=MyDBGetFieldValue(aRecordSetU, 'ParentModelID');
  ParentClassID:=MyDBGetFieldValue(aRecordSetU, 'ParentClassID');
  ParentID:=     MyDBGetFieldValue(aRecordSetU, 'ParentID');

  if ParentModelID=-1 then
    aDataModel:=Get_DataModel as IDMElement
  else
    aDataModel:=Get_DataModel.SubModel[ParentModelID] as IDMElement;

  if (ParentID<>-1) and (aDataModel<>nil) then begin
      aParent:=(aDataModel as IDMHash).GetFromHash(ParentClassID, ParentID);
      if aParent<>nil then
        Parent:=aParent
      else begin
        GetMem(ElementLinkRecord, SizeOf(TElementLinkRecord));
        ElementLinkRecord.Signature:=ElementLinkSignature;
        ElementLinkRecord.ModelID:=ParentModelID;
        ElementLinkRecord.ClassID:=ParentClassID;
        ElementLinkRecord.ID:=ParentID;
        FParent:=ElementLinkRecord;
      end;
  end else
  if (aDataModel<>nil) then
    Parent:=(aDataModel as IDataModel).GetDefaultParent(ClassID)
end;

procedure TDMElement.LoadRefFromRecordSet(const aRecordSetU: IUnknown);
var
  RefModelID, RefClassID, RefID:integer;
  aDataModel:IDMElement;
  ElementLinkRecord:PElementLinkRecord;
  aRef:IDMElement;
begin
  try
  RefModelID:=MyDBGetFieldValue(aRecordSetU, 'RefModelID');
  RefClassID:=MyDBGetFieldValue(aRecordSetU, 'RefClassID');
  RefID:=     MyDBGetFieldValue(aRecordSetU, 'RefID');

  if RefModelID=-1 then
    aDataModel:=Get_DataModel as IDMElement
  else
    aDataModel:=Get_DataModel.SubModel[RefModelID] as IDMElement;

  if (RefID<>-1) and
     (aDataModel<>nil) then begin
      aRef:=(aDataModel as IDMHash).GetFromHash(RefClassID, RefID);

      if aRef<>nil then
        Ref:=aRef
      else begin
        GetMem(ElementLinkRecord, SizeOf(TElementLinkRecord));
        ElementLinkRecord.Signature:=ElementLinkSignature;
        ElementLinkRecord.ModelID:=RefModelID;
        ElementLinkRecord.ClassID:=RefClassID;
        ElementLinkRecord.ID:=RefID;
        FRef:=ElementLinkRecord;
      end;
  end else
    Ref:=nil;
  except
    raise
  end;    
end;

procedure TDMElement.LoadFieldValuesFromRecordSet(const aRecordSetU: IUnknown);
var
  aCollection:IDMCollection;
  ElementLinkRecord:PElementLinkRecord;
  aID, aClassID, K, m:integer;
  aElement:IDMElement;
  DMField:IDMField;
  FieldName, Num:string;
  B:boolean;
  Fields:IDMCollection;
  aDataModel:IDataModel;
  aValue:OleVariant;
begin
  Fields:=GetFields;
  if Fields=nil then Exit;
  for m:=0 to Fields.Count-1 do begin
    DMField:=Get_Field(m);
    if (DMField.Level and pkDontSave)<>0 then
      Continue;
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
          ElementLinkRecord:=FRef;
          if (FRef=nil) or
             (ElementLinkRecord.Signature<>ElementLinkSignature) then
            GetFieldValueSource(DMField.Code, aCollection);
          if (aCollection<>nil) and
            (aCollection.Count>0) then begin
            aDataModel:=aCollection.Item[0].DataModel;
            aClassID:=aCollection.ClassID;
            aElement:=(aDataModel as IDMHash).GetFromHash(aClassID, aID);
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

procedure TDMElement.LoadFromRecordSet(const aRecordSetU:IUnknown);
var
  aValue:OleVariant;
begin
  ID:=MyDBGetFieldValue(aRecordSetU, 'ID');
  if StoredName and
     MyDBFindFieldValue(aRecordSetU, 'Name', aValue) and
     not VarIsNull(aValue) then
      Name:=aValue;
  try
  LoadRefFromRecordSet(aRecordSetU);
  LoadParentFromRecordSet(aRecordSetU);
  LoadFieldValuesFromRecordSet(aRecordSetU);
  except
    raise
  end;
end;

procedure TDMElement.LoadedParent;
var
  ParentModelID, ParentClassID, ParentID:integer;
  aDataModel, aParent:IDMElement;
  ElementLinkRecord:PElementLinkRecord;
begin
  try
  if FParent<>nil then begin
    ElementLinkRecord:=FParent;
    if ElementLinkRecord^.Signature=ElementLinkSignature then begin
      ParentModelID:=  ElementLinkRecord.ModelID;
      ParentClassID:=  ElementLinkRecord.ClassID;
      ParentID:=  ElementLinkRecord.ID;

      if ParentModelID=-1 then
        aDataModel:=Get_DataModel as IDMElement
      else
        aDataModel:=Get_DataModel.SubModel[ParentModelID] as IDMElement;

      if ParentID<>-1 then begin
        FParent:=nil;
          aParent:=(aDataModel as IDMHash).GetFromHash(ParentClassID, ParentID);
          Parent:=aParent;
      end;
      FreeMem(ElementLinkRecord, SizeOf(TElementLinkRecord));
    end;
  end;
  except
    raise
  end  
end;

procedure TDMElement.LoadedRef;
var
  RefModelID, RefClassID, RefID:integer;
  DataModelE:IDMElement;
  ElementLinkRecord:PElementLinkRecord;
begin
  if (ClassID=23) and
     (ID=1927) then
    XXX:=0; 
  if FRef<>nil then begin
    ElementLinkRecord:=FRef;
    if ElementLinkRecord^.Signature=ElementLinkSignature then begin
      RefModelID:=  ElementLinkRecord.ModelID;
      RefClassID:=  ElementLinkRecord.ClassID;
      RefID:=  ElementLinkRecord.ID;

      if RefModelID=-1 then
        DataModelE:=Get_DataModel as IDMElement
      else
        DataModelE:=Get_DataModel.SubModel[RefModelID] as IDMElement;

      if RefID<>-1 then begin
        FRef:= nil;
        Ref:=(DataModelE as IDMHash).GetFromHash(RefClassID, RefID);
        if Ref = nil then begin
          if not SearchNewRef(DataModelE, RefClassID, RefID) then
        end;
      end;
      FreeMem(ElementLinkRecord, SizeOf(TElementLinkRecord));
    end;
  end;
end;

procedure TDMElement.LoadedFieldValues;
var
  aCollection:IDMCollection;
  ElementLinkRecord:PElementLinkRecord;
  K, aClassID, aID, m:integer;
  DMField:IDMField;
  FieldName:string;
  aElement:IDMElement;
  aDataModel:IDataModel;
begin
  for m:=0 to FieldCount-1 do begin
    DMField:=Get_Field(m);
    FieldName:=(DMField as IDMElement).Name;
    case DMField.ValueType of
    fvtElement:
      begin
        if not VarIsNull(FieldValue[m]) and
           not VarIsEmpty(FieldValue[m]) and
          (VarType(FieldValue[m])= varInteger) then begin
          K:=FieldValue[m];
          ElementLinkRecord:=PElementLinkRecord(pointer(K));
          if ElementLinkRecord^.Signature=ElementLinkSignature then begin
            aID:=  ElementLinkRecord.ID;
            aCollection:=nil;
            GetFieldValueSource(DMField.Code, aCollection);
            if (aCollection<>nil) and
              (aCollection.Count>0)then begin
              aDataModel:=aCollection.Item[0].DataModel;
              aClassID:=aCollection.ClassID;
              aElement:=(aDataModel as IDMHash).GetFromHash(aClassID, aID);
              FieldValue[m]:=aElement;
            end else
              FieldValue[m]:=NilUnk;
            FreeMem(ElementLinkRecord, SizeOf(TElementLinkRecord));
          end;
        end;
      end;
    end;
  end;
end;

procedure TDMElement.Loaded;
begin
  LoadedParent;
  LoadedRef;
  LoadedFieldValues;
  Update;
end;

procedure TDMElement.LoadDataFromRecordSet(
  const aRecordSetU:IUnknown);
begin
end;

procedure TDMElement.AddParentFromRecordSet(
  const aRecordSetU:IUnknown);
var
  aParent:IDMElement;
  ParentModelID, ParentClassID, ParentID:integer;
  aDataModel:IDMElement;
begin
  ParentModelID:=MyDBGetFieldValue(aRecordSetU, 'ParentModelID');
  ParentClassID:=MyDBGetFieldValue(aRecordSetU, 'ParentClassID');
  ParentID:=     MyDBGetFieldValue(aRecordSetU, 'ParentID');

  if ParentModelID=-1 then
    aDataModel:=Get_DataModel as IDMElement
  else
    aDataModel:=Get_DataModel.SubModel[ParentModelID] as IDMElement;

  if ParentID<>-1 then begin
    aParent:=(aDataModel as IDMHash).GetFromHash(ParentClassID, ParentID);
  end else
    aParent:=(aDataModel as IDataModel).GetDefaultParent(ClassID);
  if aParent<>nil then
    AddParent(aParent);
end;


procedure TDMElement.SetUnkValue(var U:Variant; const Value: OleVariant);
var
  Unk:IUnknown;
  BackRef:IDMElement;
begin
  if (VarType(U)=varUnknown) then begin
    Unk:=U;
    if (Unk<>nil) and
       (Unk.QueryInterface(IDMElement, BackRef)=0) then
      BackRef._RemoveBackRef(Self as IDMElement);
  end;
  U:=Value;
  if (VarType(Value)=varUnknown) then begin
    Unk:=U;
    if (Unk<>nil) and
      (Unk.QueryInterface(IDMElement, BackRef)=0) then
      BackRef._AddBackRef(Self as IDMElement);
  end;
end;

procedure TDMElement._AddBackRef(const aElement: IDMElement);
begin
end;

procedure TDMElement._RemoveBackRef(const aElement: IDMElement);
begin
end;

function TDMElement.Get_BackRefCount: Integer;
begin
  Result:=-1
end;

function TDMElement.Get_Field(Index: Integer): IDMField;
begin
  try
  if (GetFields<>nil) and
    (Index<GetFields.Count) then
    Result:=GetFields.Item[Index] as IDMField
  else
    Result:=nil;
  except
    raise
  end  
end;

function TDMElement.Get_FieldCount: Integer;
begin
  if GetFields<>nil then
    Result:=GetFields.Count
  else
    Result:=0
end;

class function TDMElement.GetFields: IDMCollection;
begin
  Result:=nil
end;

function TDMElement.Get_FieldValue(Index: Integer): OleVariant;
var
  Field:IDMField;
begin
  Field:=Get_Field(Index);
  Result:=GetFieldValue(Field.Code)
end;

function TDMElement.GetParameters: IDMCollection;
begin
  Result:=nil
end;

function TDMElement.GetParameterValues: IDMCollection;
begin
  Result:=nil
end;

function TDMElement.Get_Parents: IDMCollection;
begin
  Result:=nil
end;

function TDMElement.Get_SubKinds: IDMCollection;
begin
  Result:=nil
end;

procedure TDMElement.Set_FieldValue(Index: Integer;
  Value: OleVariant);
var
  Field:IDMField;
begin
  Field:=Get_Field(Index);
  SetFieldValue(Field.Code, Value);
end;

class procedure TDMElement.AddField(
  aName, aValueFormat, aHint, aShortName: String;
  aValueType: Integer;
  aDefaultValue, aMinValue, aMaxValue: Double;
  aCode, aModifier, aLevel: Integer);
var
  Field:TDMField;
begin
  Field:=TDMField.Create(nil);
  with Field do begin
    FName:=aName;
    FValueFormat:=aValueFormat;
    FHint:=aHint;
    FShortName:=aShortName;
    FValueType:=aValueType;
    FDefaultValue:=aDefaultValue;
    FMinValue:=aMinValue;
    FMaxValue:=aMaxValue;
    FCode:=aCode;
    FModifier:=aModifier;
    FLevel:=aLevel;
  end;
  (GetFields as IDMCollection2).Add(Field as IDMElement);
end;

procedure TDMElement.ClearOp;
begin
end;

function TDMElement.GetCopyLinkMode(
  const aLink: IDMElement): Integer;
var
  DM1, DM2:IDMElement;
begin
  if aLink=nil then
    Result:=clmNil
  else begin
    DM1:=aLink.DataModel as IDMElement;
    while DM1.DataModel<>nil do
       DM1:=DM1.DataModel as IDMElement;

    DM2:=DataModel as IDMElement;
    while DM2.DataModel<>nil do
       DM2:=DM2.DataModel as IDMElement;

    if DM1<>DM2 then
      Result:=clmOldLink
    else
      Result:=clmDefault
  end
end;

function TDMElement.Get_BuildIn: WordBool;
begin
  Result:=False
end;

procedure TDMElement.Set_BuildIn(Value: WordBool);
begin
  if Value then
    Set_DataModel(nil)
end;

class function TDMElement.GetClassID: Integer;
begin
  Result:=-1
end;

function TDMElement.FieldIsVisible(Code:integer): WordBool;
begin
  Result:=True
end;

procedure TDMElement.Draw(const aPainter: IUnknown; DrawSelected: integer);
begin
  try
  if SpatialElement<>nil then
    SpatialElement.Draw(aPainter, DrawSelected)
  except
    raise
  end;    
end;

function TDMElement.Get_SpatialElement: IDMElement;
begin
  Result:=nil
end;

procedure TDMElement.Set_SpatialElement(const Value: IDMElement);
begin
end;

function TDMElement.Get_Selected: WordBool;
begin
  if (SpatialElement=nil) or
     (SpatialElement.DataModel<>DataModel)  then begin
    Result:=((FState and esSelected)<>0)
  end else
    Result:=SpatialElement.Selected
end;

procedure TDMElement.Set_Selected(Value: WordBool);
var
  Document:IDMDocument;
begin
  if (SpatialElement=nil) or
     (SpatialElement.DataModel<>DataModel)  then begin
    if Value then
      FState:=FState or esSelected
    else
      FState:=FState and not esSelected;

    if DataModel=nil then Exit;
    Document:=DataModel.Document as IDMDocument;
    if Document=nil then begin
      Document:=(DataModel as IDMElement).DataModel.Document as IDMDocument;
      if Document=nil then Exit;
    end;
    if Value then
      Document.Select(Self as IDMElement)
    else
      Document.UnSelect(Self as IDMElement)
  end else
    SpatialElement.Selected:=Value;
end;

procedure TDMElement.Update;
begin
end;

function TDMElement.GetFieldValue(Code: integer): OleVariant;
begin
  Result:=NilUnk
end;

procedure TDMElement.SetFieldValue(Code: integer; Value: OleVariant);
begin
end;

function TDMElement.Get_Field_(Index: Integer): IDMField;
begin
  if Index<Get_FieldCount_ then
    Result:=Get_Field(Index)
  else
    Result:=nil
end;

function TDMElement.Get_FieldCount_: Integer;
begin
  Result:=Get_FieldCount
end;

function TDMElement.Get_FieldValue_(Index: Integer): OleVariant;
begin
  Result:=Get_FieldValue(Index)
end;

procedure TDMElement.Set_FieldValue_(Index: Integer; Value: OleVariant);
begin
  Set_FieldValue(Index, Value)
end;

function TDMElement.Get_MainParent: IDMElement;
begin
  Result:=IDMElement(FParent)
end;

procedure TDMElement.AfterLoading1;
begin
end;

procedure TDMElement.AfterLoading2;
begin
end;

procedure TDMElement.BuildReport(ReportLevel: Integer; TabCount: Integer;  Mode: Integer;
                                 const Report: IDMText);
var
  S:WideString;
  j:integer;
  Collection:IDMCollection;
begin
  S:='';
  for j:=0 to TabCount-1 do
    S:=S+#9;
  Collection:=Get_OwnerCollection;
  if Collection<>nil then
    S:=S+Format('%s "%s"',
         [Collection.ClassAlias[0], Name])
  else
    S:=S+Format('"%s"',
         [Name]);
  Report.AddLine(S);
end;

class function TDMElement.StoredName: WordBool;
begin
  Result:=False
end;

procedure TDMElement.JoinSpatialElements(const aElement: IDMElement);
begin
end;

function TDMElement.Get_CollectionU(Index: Integer): IUnknown;
begin
  Result:=nil;
end;

procedure TDMElement.BeforeDeletion;
begin
end;

function TDMElement.Get_UserDefineded: WordBool;
begin
  Result:=False
end;

function TDMElement.Get_IsEmpty: WordBool;
begin
  Result:=False
end;

procedure TDMElement.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  aCollection2:=aCollection as IDMCollection2;
  SourceCollection:=(Get_Collection(Index) as IDMCollection2).ElementContainer;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do
    aCollection2.Add(SourceCollection.Item[j]);
end;

function TDMElement.Get_Presence: integer;
begin
  Result:=0
end;

procedure TDMElement.Set_Presence(Value: Integer);
begin
end;

class procedure TDMElement.MakeFields0;
begin
end;

class procedure TDMElement.MakeFields1;
begin
end;

class procedure TDMElement.MakeFields;
begin
  MakeFields0;
  MakeFields1;
end;

procedure TDMElement.UpdateCoords;
begin
end;

procedure TDMElement.AfterCopyFrom(const SourceElement: IDMElement);
begin
end;

function TDMElement.Get_ReportModeName(Index:integer):WideString;
begin
  Result:='';
end;

function TDMElement.Get_ReportModeCount: integer;
begin
  Result:=0;
end;

function TDMElement.Get_FieldCategory(Index: integer): WideString;
begin
  case Index of
  0: Result:=rsInputParameters;
  1: Result:=rsOutputParameters;
  2: Result:=rsUserDefinedParameters;
  3: Result:=rsComments;
  4: Result:=rsViewParameters;
  5: Result:=rsAnalysisParameters;
  6: Result:=rsPriceParameters;
  7: Result:=rsAdditionalParameters;
  else
    Result:='';
  end;
end;

function TDMElement.Get_FieldCategoryCount: integer;
begin
  Result:=8
end;

function TDMElement.Get_Exists: WordBool;
begin
  Result:=((FState and esExists)<>0)
end;

procedure TDMElement.Set_Exists(Value: WordBool);
begin
  if Value then
    FState:=FState or esExists
  else
    FState:=FState and not esExists;
end;

function TDMElement.Get_DefaultSubKindIndex: integer;
begin
  Result:=-1
end;

procedure TDMElement.Set_DefaultSubKindIndex(Value: integer);
begin
end;

function TDMElement.FieldIsReadOnly(Index: integer): WordBool;
begin
  case Get_Field_(Index).Modifier of
  1:Result:=True;
  2:begin
      if (Index<>0) and
         (Get_FieldValue_(Index-1)=True) then
        Result:=False
      else
        Result:=True;
    end;
  else
    Result:=False;
  end;
end;

function TDMElement.SearchNewRef(const DataModelE: IDMElement; aRefClassID, aRefID: integer): WordBool;
var
  ClassCollection: IDMCollection;
  aElement:IDMElement;
  InstanceClassID, nCount, i:Integer;
  RefClassID, RefID: Integer;
begin
  Result := False;
  if DataModelE=nil then Exit;

  InstanceClassID:=GetDeletedObjectsClassID;

  if InstanceClassID<>-1 then begin

    ClassCollection:=DataModelE.Collection[InstanceClassID];
    if ClassCollection=nil then Exit;
    nCount := ClassCollection.Count;
    for i:=0 to nCount-1 do begin
      aElement := ClassCollection.Item[i];
      RefClassID := (aElement as IDMelement).FieldValue[0];
      RefID := (aElement as IDMelement).FieldValue[1];
      if (RefClassID=aRefClassID) and (RefID=aRefID) then begin
        Ref := (aElement as IDMelement).Ref;
        Result := True;
        Break;
      end;
    end;
  end;

end;

function TDMElement.GetDeletedObjectsClassID: integer;
begin
  Result:=-1
end;

function TDMElement.CompartibleWith(const aElement:IDMElement): WordBool;
var
  Collection02, Collection12:IDMCollection2;
begin
  Result:=False;
  Collection02:=Get_OwnerCollection as IDMCollection2;
  if Collection02=nil then  Exit;

  Collection12:=aElement.OwnerCollection as IDMCollection2;
  if Collection12=nil then  Exit;
  
  Result:=Collection02.CanContain(aElement) or
          Collection12.CanContain(Self as IDMElement)
end;

function TDMElement.Get_FieldName(Index: Integer): WideString;
var
  FieldE:IDMElement;
begin
  FieldE:=Get_Field_(Index) as IDMElement;
  Result:=FieldE.Name
end;

procedure TDMElement.AfterCopyFrom2;
begin
end;

function TDMElement.Get_FieldFormat(Index: Integer): WideString;
var
  Field:IDMField;
begin
  Field:=Get_Field_(Index);
  Result:=Field.ValueFormat
end;

function TDMElement.Get_IsSelectable: WordBool;
begin
  Result:=True
end;

function TDMElement.IsSimilarTo(const aElement: IDMElement): WordBool;
var
  j:integer;
  Value, aValue:Variant;
  Collection2:IDMCollection2;
  aCollection, Fields:IDMCollection;
  DMField:IDMField;
  Elem, aElem, aRef:IDMElement;
  Unk:IUnknown;
  aCollectionName: WideString;
  aRefSource: IDMCollection;
  aClassCollections: IDMClassCollections;
  aOperations, aLinkType:integer;
begin
  try
  Result:=False;
  if aElement=nil then Exit;
  if Name<>aElement.Name then Exit;
  aRef:=aElement.Ref;
  if ((Ref<>nil) and (aRef=nil)) or
     ((Ref=nil) and (aRef<>nil)) or
     ((Ref<>nil) and (aRef<>nil) and (Ref.Name<>aRef.Name)) then Exit;
  Fields:=GetFields;
  if Fields<>nil then begin
    for j:=0 to Fields.Count-1 do begin
      DMField:=GetFields.Item[j] as IDMField;
      Value:=Get_FieldValue(j);
      aValue:=aElement.Get_FieldValue(j);
      if DMField.ValueType=fvtElement then begin
        Unk:=Value;
        Elem:=Unk as IDMElement;
        Unk:=aValue;
        aElem:=Unk as IDMElement;
        if ((Elem<>nil) and (aElem=nil)) or
           ((Elem=nil) and (aElem<>nil)) or
           ((Elem<>nil) and (aElem<>nil) and (Elem.Name<>aElem.Name)) then Exit;
      end else
        if not VarSameValue(Value,aValue) then Exit;
    end;
  end;  
  for j:=0 to CollectionCount-1 do begin
    Collection2:=Get_Collection(j) as IDMCollection2;
    aCollection:=aElement.Get_Collection(j);
     GetCollectionProperties(j,
              aCollectionName, aRefSource, aClassCollections, aOperations,
                            aLinkType);
    if not Collection2.IsSimilarTo(aCollection, aLinkType) then Exit;
  end;
  Result:=True;
  except
    raise
  end
end;

function TDMElement.Get_SelectRef: WordBool;
begin
  Result:=(Ref<>nil) and
         (DataModel=Ref.DataModel) and
         (Self as IDMElement<>Ref.SpatialElement)
end;

procedure TDMElement.DoWriteToXML(const aXMLU: IInterface);
var
  aXML:IDMXML;
  CollectionXML:IDMCollectionXML;
begin
  try
  aXML:=aXMLU as IDMXML;
  aXML.IncLevel;
  if StoredName then
    aXML.WriteXMLLine(Name);
  if Ref<>nil then
    WriteRefToXML(aXML);
  if Parent<>nil then
    WriteParentToXML(aXML);
  WriteFieldValuesToXML(aXML);
  if (Parents<>nil) and
     (Parents.Count<>0) then begin
    CollectionXML:=Parents as IDMCollectionXML;
    CollectionXML.WriteToXML(aXML, False, -1);
  end;
  aXML.DecLevel;
  except
    raise
  end;
end;

procedure TDMElement.WriteCollectionsToXML(aXML: IDMXML);
var
  j:integer;
  CollectionXML:IDMCollectionXML;
  aCollectionName: WideString;
  aRefSource: IDMCollection;
  aClassCollections: IDMClassCollections;
  aOperations: Integer;
  aLinkType:Integer;
begin
  for j:=0 to CollectionCount-1 do begin
    CollectionXML:=Collection[j] as IDMCollectionXML;
    GetCollectionProperties(j, aCollectionName,  aRefSource, aClassCollections,
                            aOperations, aLinkType);
      case aLinkType of
      ltOneToMany:
        CollectionXML.WriteToXML(aXML, True, j);
      ltManyToMany:
        CollectionXML.WriteToXML(aXML, False, j);
      end;
  end;
end;

procedure TDMElement.WriteFieldValuesToXML(aXML: IDMXML);
var
  j:integer;
  FieldE:IDMElement;
  Fields:IDMCollection;
  Field:IDMField;
  S:string;
  Unk:IUnknown;
  V:OleVariant;
  aElement, aDataModelE:IDMElement;
  F:double;
begin
  try
  Fields:=GetFields;
  for j:=0 to FieldCount-1 do begin
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
        else begin
          if (aElement.DataModel=DataModel) or
             (aElement.DataModel=nil) then
            S:=Format('<FLN ID="%d" CID="%d"/>',[aElement.ID, aElement.ClassID])
          else begin
            aDataModelE:=aElement.DataModel as IDMElement;
            S:=Format('<FLN ID="%d" CID="%d" MID="%d"/>',
                  [aElement.ID, aElement.ClassID, aDataModelE.ID])
          end;
          aXML.WriteXMLLine(S);
        end;
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
  except
    raise
  end  
end;

procedure TDMElement.WriteParentToXML(aXML: IDMXML);
var
  S:string;
begin
  if Parent=nil then Exit;
  S:=Format('<PRN ID="%d" CID="%d"/>',[Parent.ID, Parent.ClassID]);
  aXML.WriteXMLLine(S);
end;

procedure TDMElement.WriteRefToXML(aXML: IDMXML);
var
  S:string;
  DataModelE:IDMElement;
begin
  if Ref=nil then Exit;
  if Ref.DataModel=DataModel then
    S:=Format('<REF ID="%d" CID="%d"/>',[Ref.ID, Ref.ClassID])
  else begin
    DataModelE:=Ref.DataModel as IDMElement;
    S:=Format('<REF ID="%d" CID="%d" MID="%d"/>',
              [Ref.ID, Ref.ClassID, DataModelE.ID])
  end;
  aXML.WriteXMLLine(S);
end;

procedure TDMElement.WriteToXML(const aXMLU: IInterface;
  WriteInstance: WordBool);
var
  S:string;
  aXML:IDMXML;
begin
  aXML:=aXMLU as IDMXML;

  if WriteInstance then begin
    S:=Format('<ELM ID="%d" CID="%d">', [ID, ClassID]);
    aXML.WriteXMLLine(S);
    DoWriteToXML(aXMLU);
    S:='</ELM>';
    aXML.WriteXMLLine(S);
  end else begin
    S:=Format('<LNK ID="%d" CID="%d"/>', [ID, ClassID]);
    aXML.WriteXMLLine(S);
  end;

end;

function TDMElement.Get_SelectParent: WordBool;
begin
  Result:=False
end;

{ TNamedDMElement }

function TNamedDMElement.Get_Name: WideString;
begin
  Result:=FName;
end;

procedure TNamedDMElement.Set_Name(const Value: WideString);
begin
  FName:=Value;
end;

class function TNamedDMElement.StoredName: WordBool;
begin
  Result:=True
end;

{ TDMCollection }

procedure TDMCollection.Initialize;
begin
  inherited;
  FList:=TList.Create;
end;

destructor TDMCollection.Destroy;
var
  aElement:IDMElement;
  j:integer;
begin
  inherited;

  for j:=0 to FList.Count-1 do begin
    aElement:=IDMElement(FList[j]);
    if aElement<>nil then
      aElement._Release;
  end;

  FList.Free;
end;

function TDMCollection.Get_ClassID: Integer;
begin
  if ElementClass<>nil then
    Result:=ElementClass.GetClassID
  else
    Result:=-1
end;

function TDMCollection.Get_Count: Integer;
begin
  Result:=FList.Count
end;

function TDMCollection.Get_Item(Index: Integer): IDMElement;
begin
  if Index=Count then
    Result:=IDMElement(FList[0])
  else
  if Index=-1 then
    Result:=IDMElement(FList[Count-1])
  else
    Result:=IDMElement(FList[Index]);
end;

function TDMCollection.IndexOf(const aElement: IDMElement): Integer;
var
  p:pointer;
begin
  p:=pointer(aElement);
  Result:=FList.IndexOf(p);
end;

function TDMCollection.ShiftElement(const aElement: IDMElement;
  Shift: Integer): Integer;
var
  j:integer;
  p:pointer;
begin
  if Shift=0 then Exit;
  p:=pointer(aElement);
  j:=FList.IndexOf(p);
  if (Shift<0) and (j+Shift<0) then
    Result:=0
  else if (Shift>0) and (j+Shift>FList.Count-1) then
    Result:=FList.Count-1
  else
    Result:=j+Shift;
  if j=Result then Exit;
  FList.Move(j, Result);
end;

function TDMCollection.Get_DrawItalic: WordBool;
begin
  Result:=False
end;

function TDMCollection.MakeDefaultName(
  const ParentElement: IDMElement): WideString;
begin
  if Get_StoredNames then
    Result:=ClassAlias[akImenit]+' '+IntToStr(Get_DataModel.NextID[ClassID])
  else
    Result:=''
end;

function TDMCollection.CreateElement(BuildIn: WordBool): IDMElement;
var
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel;
  Result:=ElementClass.Create(aDataModel) as IDMElement;

  if BuildIn then begin
    Result.BuildIn:=True;
    Result.ID:=-1;
  end else begin
    if ClassID<>-1 then begin
      Result.ID:=aDataModel.NextID[ClassID];
      aDataModel.NextID[ClassID]:=Result.ID+1;
    end else
      Result.ID:=Count;
  end;
  if Result.ID=5625 then
    XXX:=0;
end;

procedure TDMCollection.Add(const aElement: IDMElement);
var
  p:pointer;
  I:integer;
begin
  p:=pointer(aElement);
  I:=FList.Count;
  FList.Insert(I, P);
  if p=nil then Exit;
  aElement._AddRef;
end;

procedure TDMCollection.Insert(Index:integer; const aElement: IDMElement);
var
  p:pointer;
begin
  p:=pointer(aElement);
  FList.Insert(Index,p);
  aElement._AddRef;
end;

procedure TDMCollection.Remove(const aElement: IDMElement);
var
  p:pointer;
  j:integer;
begin
  p:=pointer(aElement);
  j:=FList.IndexOf(P);
  if j=-1 then Exit;
  FList.Delete(j);
  aElement._Release;
end;

procedure TDMCollection.Clear;
var
  j:integer;
  aElement:IDMElement;
begin
  for j:=0 to FList.Count-1 do begin
    aElement:=IDMElement(FList[j]);
    if aElement<>nil then begin
      aElement._Release;
      aElement:=nil;
    end;
  end;
  FList.Clear;
end;

procedure TDMCollection.Delete(Index: Integer);
var
  aElement:IDMElement;
begin
  aElement:=IDMElement(FList[Index]);
  FList.Delete(Index);
  if aElement=nil then Exit;
  aElement._Release;
end;

procedure TDMCollection.Move(OldIndex, NewIndex: Integer);
begin
  FList.Move(OldIndex, NewIndex);
end;

procedure TDMCollection.Sort(const Sorter:ISorter);
var
  j:integer;
  SortedCollection2:IDMCollection2;
  SortedCollection:TSortedCollection;
begin
  SortedCollection:=TSortedCollection.Create(nil);
  SortedCollection.FSorter:=Sorter;
  SortedCollection2:=SortedCollection as IDMCollection2;
  for j:=Count-1 downto 0 do
    SortedCollection2.Add(Item[j]);
  Clear;
  for j:=0 to SortedCollection.Count-1 do
    Add(SortedCollection.Item[j]);
  SortedCollection2.Clear;
end;

function TDMCollection.Get_ElementContainer: IDMCollection;
var
  ID:integer;
begin
  ID:=ClassID;
  Result:=(Get_DataModel as IDMElement).Collection[ID]
end;

function TDMCollection.MakeParentsTable(const aDatabaseU: IUnknown):IUnknown;
var
  TableName:OleVariant;
  FieldList:TStringList;
begin
  TableName:=ClassAlias[akImenit]+'_P';
  FieldList:=TStringList.Create;
  FieldList.AddObject('ID', pointer(fvtInteger));
  FieldList.AddObject('ParentModelID', pointer(fvtInteger));
  FieldList.AddObject('ParentClassID', pointer(fvtInteger));
  FieldList.AddObject('ParentID', pointer(fvtInteger));
  MyDBCreateTable(aDataBaseU, TableName, FieldList, '');
  Result:=MyDBOpenRecordset(aDataBaseU, TableName, True);
  FieldList.Free;
end;


procedure TDMCollection.SaveToDatabase(const aDatabaseU:IUnknown);
var
  TableName:OleVariant;
  DMField:IDMField;
  DMFields:IDMCollection;
  j:integer;
  Element:IDMElement;
  S, FieldName:string;
  aRecordSetU, aRecordSetP:IUnknown;
  FieldList:TStringList;

  procedure MakeFields(const FieldList:TStringList);
  var
    j:integer;
    OldName:string;
  begin
    FieldList.AddObject('ID', pointer(fvtInteger));
    FieldList.AddObject('ParentModelID', pointer(fvtInteger));
    FieldList.AddObject('ParentClassID', pointer(fvtInteger));
    FieldList.AddObject('ParentID', pointer(fvtInteger));
    FieldList.AddObject('RefModelID', pointer(fvtInteger));
    FieldList.AddObject('RefClassID', pointer(fvtInteger));
    FieldList.AddObject('RefID', pointer(fvtInteger));

    OldName:=Item[0].Name;
    Item[0].Name:='Test Name';
    if Item[0].Name='Test Name' then
      FieldList.AddObject('Name', pointer(fvtString));
    Item[0].Name:=OldName;

    if DMFields<>nil then
      for j:=0 to DMFields.Count-1 do begin
        DMField:=DMFields.Item[j] as IDMField;
        S:='P'+IntToStr(j)+' '+(DMField as IDMElement).Name;
        FieldName:=Copy(S, 1, 64);
        FieldList.AddObject(FieldName, pointer(DMField.ValueType));
      end;
  end;

begin
  if Count=0 then Exit;
  try
  DMFields:=ElementClass.GetFields;

  TableName:=ClassAlias[akImenitM];

  FieldList:=TStringList.Create;
  MakeFields(FieldList);
  MyDBCreateTable(aDataBaseU, TableName, FieldList, 'ID');
  aRecordSetU:=MyDBOpenRecordset(aDataBaseU, TableName, True);
  FieldList.Free;


  aRecordSetP:=nil;
  for j:=0 to Count-1 do begin
    Element:=Item[j];

    Element.SaveToRecordSet(aRecordSetU);

    if (aRecordSetP=nil) and
       (Element.Parents<>nil) then
      aRecordSetP:=MakeParentsTable(aDataBaseU);
    if aRecordSetP<>nil then
      Element.SaveParentsToRecordSet(aRecordSetP);

    MyDBUpdateRecordSet(aRecordSetU);
  end;

  MyDBCloseRecordset(aRecordSetU);
  if aRecordSetP<>nil then
    MyDBCloseRecordset(aRecordSetP);
  except
   raise
  end
end;

procedure TDMCollection.LoadFromDatabase(const aDatabaseU: IUnknown);
var
  aRecordSetU:IUnknown;
  TableName:WideString;
  Element:IDMElement;
  MaxID:integer;
  DMHash:IDMHash;
begin
  DMHash:=Get_DataModel as IDMHash;

  TableName:=ClassAlias[akImenitM];

  aRecordSetU:=MyDBOpenRecordset(aDataBaseU, TableName, False);
  if aRecordSetU=nil then Exit;

  MaxID:=-1;
  try
  while not MyDBRecordSetEOF(aRecordSetU) do begin
    Element:=CreateElement(False);
    Element.LoadFromRecordSet(aRecordSetU);
    Add(Element);
    DMHash.AddToHash(Element);
    
    if MaxID<Element.ID then
      MaxID:=Element.ID;
    MyDBRecordSetMoveNext(aRecordSetU);
  end;
  except
    raise
  end;
  MyDBCloseRecordSet(aRecordSetU);

  Get_DataModel.NextID[ClassID]:=MaxID+1;
end;

procedure TDMCollection.LoadedFromDatabase(const aDataBaseU:IUnknown);
var
  aRecordSetP:IUnknown;
  TableNameP:WideString;
  Element:IDMElement;
  j, aID:integer;
  aCollection2:IDMCollection2;
  DMHash:IDMHash;
begin
  try
{
  for j:=0 to FList.Count-1 do begin
    Element:=IDMElement(FList[j]);
    try
    Element.Loaded;
    except
      XXX:=0;
    end;
  end;
}

  TableNameP:=ClassAlias[akImenit]+'_P';
  aRecordSetP:=MyDBOpenRecordset(aDataBaseU, TableNameP, False);
  if aRecordSetP=nil then Exit;
  if Get_DataModel.QueryInterface(IDMHash, DMHash)=0 then
    aCollection2:=nil
  else
    aCollection2:=Self as IDMCollection2;


  while not MyDBRecordSetEOF(aRecordSetP) do begin
    aID:=MyDBGetFieldValue(aRecordSetP, 'ID');

    if DMHash=nil then
      Element:=aCollection2.GetItemByID(aID)
    else
      Element:=DMHash.GetFromHash(ClassID, aID);
      
    Element.AddParentFromRecordSet(aRecordSetP);
    MyDBRecordSetMoveNext(aRecordSetP);
  end;
  except
    raise
  end  
end;

function TDMCollection.GetItemByID(aID: Integer): IDMElement;
var
  j:integer;
begin
  j:=0;
  while j<FList.Count do begin
    Result:=IDMElement(FList[j]);
    if Result.ID=aID then
      Exit
    else
      inc(j);
  end;
  Result:=nil;
end;

function TDMCollection.CanContain(const aElement: IDMElement): WordBool;
var
  Unk:IUnknown;
begin
  Result:=(aElement.QueryInterface(GetElementGUID, Unk)=0)
end;

class function TDMCollection.GetElementGUID: TGUID;
var
  aGUID:TGUID;
begin
  Result:=aGUID;
end;

procedure TDMCollection.DisconnectFrom(const aParent: IDMElement);
var
  j, N:integer;
  aElement:IDMElement;
begin
  try
  if aParent=Get_DataModel as IDMElement then begin
    for j:=0 to FList.Count-1 do begin
      aElement:=IDMElement(FList[j]);
      aElement.Clear;
      aElement._Release;
      aElement:=nil;
    end;
    FList.Clear;
  end else begin
    j:=0;
    N:=FList.Count;
    while j<FList.Count do begin
      aElement:=IDMElement(FList[j]);
      if aElement.DataModel<>nil then begin
        aElement.DisconnectFrom(aParent);
        if N=FList.Count then begin
          aElement._Release;
          FList.Delete(j);
        end;
      end else begin
        aElement._Release;
        FList.Delete(j);
      end;
      aElement:=nil;
      N:=FList.Count;
    end;
  end;
  except
    raise
  end
end;

function TDMCollection.GetItemByRef(const aRef: IDMElement): IDMElement;
var
  j:integer;
begin
  j:=0;
  while j<FList.Count do begin
    Result:=IDMElement(FList[j]);
    if Result.Ref=aRef then
      Exit
    else
      inc(j);
  end;
  Result:=nil;
end;

function TDMCollection.IsEqualTo(const aCollection: IDMCollection): WordBool;
var
  j:integer;
begin
  Result:=False;
  if Count<>aCollection.Count then Exit;
  for j:=0 to aCollection.Count-1 do
    if IndexOf(aCollection.Item[j])=-1 then Exit;
  Result:=True;
end;

function TDMCollection.GetItemByRefParent(
  const aElement: IDMElement): IDMElement;
var
  j:integer;
begin
  j:=0;
  while j<FList.Count do begin
    Result:=IDMElement(FList[j]);
    if (Result.Ref<>nil) and
       (Result.Ref.Parent=aElement) then
      Exit
    else
      inc(j);
  end;
  Result:=nil;
end;

function TDMCollection.Get_StoredNames: WordBool;
begin
  Result:=GetElementClass.StoredName
end;

function TDMCollection.GetItemByName(const aName: WideString): IDMElement;
var
  j:integer;
begin
  j:=0;
  while j<FList.Count do begin
    Result:=IDMElement(FList[j]);
    if Result.Name=aName then
      Exit
    else
      inc(j);
  end;
  Result:=nil;
end;

function TDMCollection.Get_ClassAlias2(Index: Integer): WideString;
begin
  Result:=Get_ClassAlias(Index)
end;

function TDMCollection.IsSimilarTo(const aCollection: IDMCollection; LinkType:integer): WordBool;
var
  j, aCount:integer;
  aItem:IDMElement;
begin
  try
  Result:=False;
  aCount:=Get_Count;
  if aCount<>aCollection.Count then Exit;
  for j:=0 to aCount-1 do begin
    aItem:=aCollection.Item[j];
    if LinkType=ltOneToMany then begin
      if not Item[j].IsSimilarTo(aItem) then Exit;
    end else
    if Item[j].Name<>aItem.Name then Exit;
  end;
  Result:=True;
  except
    raise
  end;
end;

function TDMCollection.GetItemSimilarTo(
  const aElement: IDMElement): IDMElement;
var
  j, aCount:integer;
  Element:IDMElement;
begin
  aCount:=Get_Count;
  j:=0;
  while j<aCount do begin
    Element:=Get_Item(j);
    if Element=aElement then
      Break
    else
    if Element.IsSimilarTo(aElement) then
      Break
    else
      inc(j)
  end;
  if j<aCount then
    Result:=Element
  else
    Result:=nil
end;

procedure TDMCollection.Loaded;
var
  Element:IDMElement;
  j:integer;
begin
  for j:=0 to FList.Count-1 do begin
    Element:=IDMElement(FList[j]);
    try
    Element.Loaded;
    except
      XXX:=0;
    end;
  end;
end;

{ TDMField }

function TDMField.Get_Code: Integer;
begin
  Result:=FCode
end;

function TDMField.Get_DefaultValue: Double;
begin
  Result:=FDefaultValue
end;

function TDMField.Get_Hint: WideString;
begin
  Result:=FHint
end;

function TDMField.Get_Level: Integer;
begin
  Result:=FLevel
end;

function TDMField.Get_MaxValue: Double;
begin
  Result:=FMaxValue
end;

function TDMField.Get_MinValue: Double;
begin
  Result:=FMinValue
end;

function TDMField.Get_Modifier: Integer;
begin
  Result:=FModifier
end;

function TDMField.Get_OwnerCollection: IDMCollection;
begin
  Result:=nil
end;

function TDMField.Get_ShortName: WideString;
begin
  if FShortName<>'' then
    Result:=FShortName
  else
    Result:=Name
end;

function TDMField.Get_ValueFormat: WideString;
begin
  Result:=FValueFormat
end;

function TDMField.Get_ValueType: Integer;
begin
  Result:=FValueType
end;

procedure TDMField.Set_Code(Value: Integer);
begin
  FCode:=Value
end;

procedure TDMField.Set_DefaultValue(Value: Double);
begin
  FDefaultValue:=Value
end;

procedure TDMField.Set_Hint(const Value: WideString);
begin
  FHint:=Value
end;

procedure TDMField.Set_Level(Value: Integer);
begin
  FLevel:=Value
end;

procedure TDMField.Set_MaxValue(Value: Double);
begin
  FMaxValue:=Value
end;

procedure TDMField.Set_MinValue(Value: Double);
begin
  FMinValue:=Value
end;

procedure TDMField.Set_Modifier(Value: Integer);
begin
  FModifier:=Value
end;

procedure TDMField.Set_ShortName(const Value: WideString);
begin
  FShortName:=Value
end;

procedure TDMField.Set_ValueFormat(const Value: WideString);
begin
  FValueFormat:=Value
end;

procedure TDMField.Set_ValueType(Value: Integer);
begin
  FValueType:=Value
end;

{ TDMFields }

procedure TDMFields.DisconnectFrom(const aParent: IDMElement);
var
  j:integer;
  aElement:IDMElement;
begin
  for j:=0 to FList.Count-1 do begin
    aElement:=IDMElement(FList[j]);
    aElement.Clear;
    aElement._Release;
    aElement:=nil;
  end;
end;

class function TDMFields.GetElementClass: TDMElementClass;
begin
  Result:=TDMField
end;

{ TDMParameter }

class function TDMParameter.GetFields: IDMCollection;
begin
  Result:=FParameterFields;
end;

function TDMParameter.Get_Parents: IDMCollection;
begin
  Result:=FParents
end;

procedure TDMParameter.Initialize;
begin
  inherited;
  FParents:=TDMCollection.Create(Self as IDMElement)
end;

class procedure TDMParameter.MakeFields0;
var
  S:WideString;
begin
  S:='|'+rsInteger+
     '|'+rsFloat+
     '|'+rsBoolean+
     '|'+rsString+
     '|'+rsElement+
     '|'+rsText+
     '|'+rsColor+
     '|'+rsFile+
     '|'+rsChoice;
  inherited;
  AddField(rsParameterValueType, S, '', '',
      fvtChoice, 0, 0, 0,
      ord(mpParameterValueType), 0, pkInput);
  AddField(rsParameterDefaultValue, '%6.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(mpParameterDefaultValue), 0, pkInput);
  AddField(rsParameterMinValue, '%6.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(mpParameterMinValue), 0, pkInput);
  AddField(rsParameterMaxValue, '%6.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(mpParameterMaxValue), 0, pkInput);
  AddField(rsParameterValueFormat, '', '', '',
      fvtString, 0, 0, 0,
      ord(mpParameterValueFormat), 0, pkInput);
  AddField(rsParameterCode, '%2d', '', '',
      fvtInteger, 0, 0, 0,
      ord(mpParameterCode), 0, pkInput);
  S:='|'+rsReadWrite+
     '|'+rsReadOnly+
     '|'+rsUserDefined;
  AddField(rsParameterModifier, S, '', '',
      fvtChoice, 0, 0, 0,
      ord(mpParameterModifier), 0, pkInput);
  AddField(rsParameterLevel, '%2d', '', '',
      fvtInteger, 0, 0, 0,
      ord(mpParameterLevel), 0, pkInput);
  AddField(rsParameterHint, '', '', '',
      fvtString, 0, 0, 0,
      ord(mpParameterHint), 0, pkInput);
  AddField(rsParameterShortName, '', '', '',
      fvtString, 0, 0, 0,
      ord(mpParameterShortName), 0, pkInput);
end;

function TDMParameter.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  mpParameterValueType:
    Result:=FValueType;
  mpParameterDefaultValue:
    Result:=FDefaultValue;
  mpParameterMinValue:
    Result:=FMinValue;
  mpParameterMaxValue:
    Result:=FMaxValue;
  mpParameterValueFormat:
    Result:=FValueFormat;
  mpParameterCode:
    Result:=FCode;
  mpParameterModifier:
    Result:=FModifier;
  mpParameterLevel:
    Result:=FLevel;
  mpParameterHint:
    Result:=FHint;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TDMParameter.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  mpParameterValueType:
    FValueType:=Value;
  mpParameterDefaultValue:
    FDefaultValue:=Value;
  mpParameterMinValue:
    FMinValue:=Value;
  mpParameterMaxValue:
    FMaxValue:=Value;
  mpParameterValueFormat:
    FValueFormat:=Value;
  mpParameterCode:
    FCode:=Value;
  mpParameterModifier:
    FModifier:=Value;
  mpParameterLevel:
    FLevel:=Value;
  mpParameterHint:
    FHint:=Value;
  else
    inherited;
  end;
end;

procedure TDMParameter._Destroy;
begin
  inherited;
  FParents:=nil
end;

{ TDMParameterValue }

class function TDMParameterValue.GetFields: IDMCollection;
begin
  Result:=FParameterValueFields;
end;

function TDMParameterValue.Get_Parameter: IDMField;
begin
  Result:=Ref as IDMField
end;

function TDMParameterValue.Get_Value: OleVariant;
begin
  Result:=FValue
end;

procedure TDMParameterValue.Set_Value(aValue: OleVariant);
begin
  FValue:=aValue
end;

class procedure TDMParameterValue.MakeFields0;
begin
  inherited;
  AddField(rsValue, '%6.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 0, 0, pkInput);
end;

function TDMParameterValue.Get_FieldValue(Index: integer): OleVariant;
begin
  case Index of
  0:Result:=FValue;
  else
    Result:=inherited Get_FieldValue(Index);
  end;
end;

procedure TDMParameterValue.Set_FieldValue(Index: integer;
  aValue: OleVariant);
begin
  case Index of
  0:FValue:=aValue;
  else
    inherited;
  end;
end;

{ TCustomDMCollection }

function TCustomDMCollection.Get_Count: Integer;
begin
  Result:=0
end;

function TCustomDMCollection.Get_Item(Index: Integer): IDMElement;
begin
  Result:=nil
end;

function TCustomDMCollection.Get_DataModel: IDataModel;
var
  aParent:IDMElement;
  aDataModel:IDataModel;
begin
  aParent:=Get_Parent;
  if aParent=nil then
    Result:=nil
  else begin
    if aParent.QueryInterface(IDataModel, aDataModel)=0 then
      Result:=aDataModel
    else
      Result:=aParent.DataModel;
  end;
end;

function TCustomDMCollection.Get_Parent: IDMElement;
begin
  Result:=IDMElement(FOwner)
end;

procedure TCustomDMCollection.Set_Parent(const Value: IDMElement);
begin
  FOwner:=pointer(Value)
end;

constructor TCustomDMCollection.Create(const aParent: IDMElement);
begin
  FRefCount := 1;
  FOwner:=pointer(aParent);
  Initialize;
  Dec(FRefCount);
end;

function TCustomDMCollection.Get_ClassAlias(Index: Integer): WideString;
var
  S:string;
  L:integer;
begin
  S:=ClassName;
  L:=length(S);
  Result:=Copy(S, 2, L-1)
end;

function TCustomDMCollection.IndexOf(const aElement: IDMElement): Integer;
var
  j:integer;
begin
  Result:=-1;
  j:=0;
  while j<Get_Count do
    if Get_Item(j)=aElement then
      Break
    else
      inc(j);
  if j<Get_Count then
    Result:=j
  else
    Result:=-1;
end;

function TCustomDMCollection.Get_ClassID: Integer;
var
  ElementClass: TDMElementClass;
begin
  ElementClass:=GetElementClass;
  if ElementClass=nil then
    Result:=-1
  else
    Result:=ElementClass.GetClassID
end;

class function TCustomDMCollection.GetElementClass: TDMElementClass;
begin
  Result:=nil
end;

procedure TCustomDMCollection.WriteToXML(const aXMLU: IInterface;
  WriteInstances: WordBool; Index: integer);
var
  S:string;
  aXML:IDMXML;
  j:integer;
  Element:IDMElement;
  ElementXML:IDMElementXML;
begin
  aXML:=aXMLU as IDMXML;

  S:=Format('<LST ID="%d">',[Index]);
  aXML.WriteXMLLine(S);
  aXML.IncLevel;
  for j:=0 to Get_Count-1 do begin
    Element:=Get_Item(j);
    if (not Element.BuildIn) and
       (Element.ID<>-1) then begin
      ElementXML:=Element as IDMElementXML;
      ElementXML.WriteToXML(aXML, WriteInstances);
    end;  
  end;
  aXML.DecLevel;
  S:='</LST>';
  aXML.WriteXMLLine(S);
end;

function TCustomDMCollection.Get_HasFields: WordBool;
begin
  Result:=False
end;

{ TDMArrayValue }

procedure TDMArrayValue._Destroy;
begin
  inherited;
  FArrayValues:=nil;
end;

function TDMArrayValue.Get_Value: Double;
begin
  Result:=FValue
end;

procedure TDMArrayValue.Initialize;
begin
  inherited;
end;

function TDMArrayValue.Get_DMArray: IDMArray;
var
  aParent:IDMElement;
begin
  try
  if Parent=nil then begin
    Result:=nil;
    Exit;
  end;
  aParent:=Parent;
  while (aParent<>nil) and
        (aParent.QueryInterface(IDMArray, Result)<>0) do
    aParent:=aParent.Parent;
  except
    raise
  end
end;

procedure TDMArrayValue.InsertValues;
var
  DMArray:IDMArray;
  aArrayValue, ParentArrayValue:IDMArrayValue;
  aArrayValueE:IDMElement;
  NextDimension, Dimension :IDMArrayDimension;
  j, j0, N, NextDimensionIndex:integer;
begin
  DMArray:=Get_DMArray;
  if FDimensionIndex<>-1 then begin
    Dimension:=DMArray.Dimensions.Item[FDimensionIndex] as IDMArrayDimension;
    NextDimensionIndex:=Dimension.NextDimensionIndex
  end else begin
    Dimension:=nil;
    NextDimensionIndex:=0;
  end;

  if (Dimension<>nil) and
     (Dimension.SubArrayIndex=-1) then begin
    ParentArrayValue:=Parent as IDMArrayValue;
    j:=ParentArrayValue.ArrayValues.IndexOf(Self as IDMElement);
    NextDimensionIndex:=DMArray.SubArrayDimensionIndex[j];
  end;

  if NextDimensionIndex>DMArray.Dimensions.Count-1 then Exit;

  NextDimension:=DMArray.Dimensions.Item[NextDimensionIndex] as IDMArrayDimension;

  N:=NextDimension.DimItems.Count;
  j0:=FArrayValues.Count;

  for j:=j0 to N-1 do begin
    aArrayValueE:=DMArray.CreateValue;
    aArrayValueE.Parent:=Self as IDMElement;
    (aArrayValueE as IDMArrayValue).DimensionIndex:=NextDimensionIndex;
  end;

  for j:=0 to FArrayValues.Count-1 do begin
    aArrayValue:=FArrayValues.Item[j] as IDMArrayValue;
    aArrayValue.InsertValues
  end;
end;

procedure TDMArrayValue.DeleteValues(aValueIndex, aDimensionIndex:integer);
var
  DMArray:IDMArray;
  aArrayValue, ParentArrayValue:IDMArrayValue;
  aArrayValueE:IDMElement;
  Dimension:IDMArrayDimension;
  j, NextDimensionIndex:integer;
begin
  DMArray:=Get_DMArray;
  if FDimensionIndex<>-1 then begin
    Dimension:=DMArray.Dimensions.Item[FDimensionIndex] as IDMArrayDimension;
    NextDimensionIndex:=Dimension.NextDimensionIndex
  end else begin
    Dimension:=nil;
    NextDimensionIndex:=0;
  end;

  if (Dimension<>nil) and
     (Dimension.SubArrayIndex=-1) then begin
    ParentArrayValue:=Parent as IDMArrayValue;
    j:=ParentArrayValue.ArrayValues.IndexOf(Self as IDMElement);
    NextDimensionIndex:=DMArray.SubArrayDimensionIndex[j];
  end;

  if NextDimensionIndex>DMArray.Dimensions.Count-1 then Exit;

  if aDimensionIndex=NextDimensionIndex  then begin
    aArrayValueE:=FArrayValues.Item[aValueIndex];
    DMArray.RemoveValue(aArrayValueE);
  end else
  if NextDimensionIndex<DMArray.Dimensions.Count-1 then
    for j:=0 to FArrayValues.Count-1 do begin
      aArrayValue:=FArrayValues.Item[j] as IDMArrayValue;
      aArrayValue.DeleteValues(aValueIndex, aDimensionIndex)
    end;
end;

function TDMArrayValue.Get_DimensionIndex: integer;
begin
  Result:=FDimensionIndex
end;

procedure TDMArrayValue.Set_DimensionIndex(aDimensionIndex: integer);
begin
  FDimensionIndex:=aDimensionIndex
end;

function TDMArrayValue.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FArrayValues
end;

function TDMArrayValue.Get_CollectionCount: Integer;
begin
  Result:=1
end;

procedure TDMArrayValue.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  aRefSource:=nil;
  aCollectionName:=rsDMArrayValues;
  aClassCollections:=nil;
  aOperations:=0;
  aLinkType:=ltOneToMany;
end;

function TDMArrayValue.Get_Name: WideString;
var
  DMArray:IDMArray;
  Dimension:IDMArrayDimension;
  j:integer;
begin
  DMArray:=Get_DMArray;
  if (DMArray<>nil) and
     (FDimensionIndex<>-1) and
     (FDimensionIndex<DMArray.Dimensions.Count)then begin
    Dimension:=DMArray.Dimensions.Item[FDimensionIndex] as IDMArrayDimension;
    j:=(Parent as IDMArrayValue).ArrayValues.IndexOf(Self as IDMElement);
    Result:=Dimension.DimItems.Item[j].Name
  end else
    Result:=''  
end;

function TDMArrayValue.Get_ArrayValues: IDMCollection;
begin
  Result:=FArrayValues
end;

class procedure TDMArrayValue.MakeFields0;
begin
  inherited;
  AddField(rsValue, '%0.4f', '', '',
      fvtFloat, 0, 0, 0,
      0, 0, pkInput);
  AddField(rsDimensionIndex, '%1d', '', '',
      fvtInteger, 0, 0, 0,
      1, 1, pkOutput);
end;

class function TDMArrayValue.GetFields: IDMCollection;
begin
  Result:=FDMArrayValueFields
end;

function TDMArrayValue.GetFieldValue(Code: integer): OleVariant;
var
  DMArray:IDMArray;
  aArrayValue:IDMArrayValue;
  aDimension, NextDimension:IDMArrayDimension;
  NextDimensionIndex:integer;
begin
  try
  if DataModel.IsLoading or
     DataModel.IsCopying then
    case Code of
    0:Result:=FValue;
    1:Result:=FDimensionIndex;
    else
      Result:=-1;
    end
  else begin
    DMArray:=Get_DMArray;
    if DMArray=nil then
      case Code of
      0:Result:=FValue;
      1:Result:=FDimensionIndex;
      else
        Result:=-1;
      end
    else begin
      aDimension:=DMArray.Dimensions.Item[FDimensionIndex] as IDMArrayDimension;
      NextDimensionIndex:=aDimension.NextDimensionIndex;
      if NextDimensionIndex>DMArray.Dimensions.Count-1 then
        NextDimension:=nil
      else
        NextDimension:=DMArray.Dimensions.Item[NextDimensionIndex] as IDMArrayDimension;
      if (NextDimension<>nil) and
         (NextDimension.NextDimensionIndex>DMArray.Dimensions.Count-1) then begin
        if Code<FArrayValues.Count then begin
          aArrayValue:=FArrayValues.Item[Code] as IDMArrayValue;
          Result:=aArrayValue.Value;
        end else
          Result:=-1;
      end else begin
        case Code of
        0:Result:=FValue;
        1:Result:=FDimensionIndex;
        else
          Result:=-1;
        end
      end;  // if (NextDimension<>nil) and ...
    end;  // if DMArray=nil
  end;  // DataModel.IsLoading or ...
  except
    raise
  end;
end;

procedure TDMArrayValue.SetFieldValue(Code: integer; Value: OleVariant);
var
  DMArray:IDMArray;
  aArrayValue:IDMArrayValue;
  aDimension, NextDimension:IDMArrayDimension;
  NextDimensionIndex:integer;
begin
  if DataModel.IsLoading or
     DataModel.IsCopying then
    case Code of
    0:FValue:=Value;
    1:FDimensionIndex:=Value;
    end
  else begin
    DMArray:=Get_DMArray;
    if DMArray=nil then
      case Code of
      0:FValue:=Value;
      1:FDimensionIndex:=Value;
      end
    else begin
      aDimension:=DMArray.Dimensions.Item[FDimensionIndex] as IDMArrayDimension;
      NextDimensionIndex:=aDimension.NextDimensionIndex;
      if NextDimensionIndex>DMArray.Dimensions.Count-1 then
        NextDimension:=nil
      else
        NextDimension:=DMArray.Dimensions.Item[NextDimensionIndex] as IDMArrayDimension;
      if (NextDimension<>nil) and
         (NextDimension.NextDimensionIndex>DMArray.Dimensions.Count-1) then begin
        aArrayValue:=FArrayValues.Item[Code] as IDMArrayValue;
        aArrayValue.Value:=Value;
      end else begin
        case Code of
        0:FValue:=Value;
        1:FDimensionIndex:=Value;
        end
      end;  // if (NextDimension<>nil) and ...
    end;  // if DMArray=nil
  end;  //  if DataModel.IsLoading or ...
end;

function TDMArrayValue.Get_ClassAlias(Index: Integer): WideString;
begin
  Result:=FArrayValues.ClassAlias[Index]
end;

function TDMArrayValue.Get_Count: Integer;
begin
  Result:=FArrayValues.Count
end;

function TDMArrayValue.Get_Item(Index: Integer): IDMElement;
begin
  Result:=FArrayValues.Item[Index]
end;

function TDMArrayValue.IndexOf(const aElement: IDMElement): Integer;
begin
  Result:=FArrayValues.IndexOf(aElement)
end;

function TDMArrayValue.Get_Field(Index: Integer): IDMField;
var
  DMArray:IDMArray;
  aDimension, NextDimension:IDMArrayDimension;
  NextDimensionIndex:integer;
begin
  try
  if DataModel.IsLoading or
     DataModel.IsCopying then
    Result:=inherited Get_Field(Index)
  else begin
    DMArray:=Get_DMArray;
    if DMArray=nil then
      Result:=inherited Get_Field(Index)
    else begin
      aDimension:=DMArray.Dimensions.Item[FDimensionIndex] as IDMArrayDimension;
      NextDimensionIndex:=aDimension.NextDimensionIndex;
      if NextDimensionIndex>DMArray.Dimensions.Count-1 then
        NextDimension:=nil
      else
        NextDimension:=DMArray.Dimensions.Item[NextDimensionIndex] as IDMArrayDimension;
      if (NextDimension<>nil) and
         (NextDimension.NextDimensionIndex>DMArray.Dimensions.Count-1) then begin
        Result:=NextDimension.DimItems.Item[Index] as IDMField
      end else
        Result:=inherited Get_Field(Index)
    end;  // if DMArray=nil
  end;
  except
    raise
  end;  
end;

function TDMArrayValue.Get_FieldCount: Integer;
var
  DMArray:IDMArray;
  aDimension, NextDimension:IDMArrayDimension;
  NextDimensionIndex:integer;
begin
  if DataModel.IsLoading or
     DataModel.IsCopying then
    Result:=inherited Get_FieldCount
  else begin
    DMArray:=Get_DMArray;
    if DMArray=nil then
      Result:=inherited Get_FieldCount
    else
    if FDimensionIndex<>-1 then begin
      aDimension:=DMArray.Dimensions.Item[FDimensionIndex] as IDMArrayDimension;
      NextDimensionIndex:=aDimension.NextDimensionIndex;
      if NextDimensionIndex>DMArray.Dimensions.Count-1 then
        NextDimension:=nil
      else
        NextDimension:=DMArray.Dimensions.Item[NextDimensionIndex] as IDMArrayDimension;
      if (NextDimension<>nil) and
         (NextDimension.NextDimensionIndex>DMArray.Dimensions.Count-1) then begin
        Result:=NextDimension.DimItems.Count
      end else
        Result:=inherited Get_FieldCount
    end else  // if DMArray=nil
      Result:=inherited Get_FieldCount
  end;
end;

procedure TDMArrayValue.Set_Value(aValue: Double);
begin
  FValue:=aValue
end;

function TDMArrayValue.Get_HasFields: WordBool;
begin
 Result:=False
end;

{ TDMArrayDimension }

procedure TDMArrayDimension._Destroy;
begin
  inherited;
  FDimItems:=nil
end;

procedure TDMArrayDimension.Initialize;
begin
  inherited;
end;

procedure TDMArrayDimension._AddChild(const aChild: IDMElement);
var
  DMArray:IDMArray;
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;

  DMArray:=Parent as IDMArray;
  DMArray.ArrayValue.InsertValues;
end;

procedure TDMArrayDimension._RemoveChild(const aChild: IDMElement);
var
  DMArray:IDMArray;
  aValueIndex, aDimensionIndex:integer;
begin
  aValueIndex:=FDimItems.IndexOf(aChild);
  inherited;
  if Parent=nil then Exit;
  DMArray:=Parent as IDMArray;
  aDimensionIndex:=DMArray.Dimensions.IndexOf(Self as IDMElement);
  if DMArray.ArrayValue=nil then Exit;
  DMArray.ArrayValue.DeleteValues(aValueIndex, aDimensionIndex);
end;

function TDMArrayDimension.Get_DimItems: IDMCollection;
begin
  Result:=FDimItems
end;

function TDMArrayDimension.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FDimItems      
end;

function TDMArrayDimension.Get_CollectionCount: Integer;
begin
  Result:=1
end;

procedure TDMArrayDimension.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  aRefSource:=nil;
  aCollectionName:=rsDimValues;
  aClassCollections:=nil;
  aOperations:=leoAdd or leoDelete or leoRename;
  aLinkType:=ltOneToMany;
end;

function TDMArrayDimension.Get_SubArrayIndex: integer;
begin
  Result:=FSubArrayIndex
end;

function TDMArrayDimension.Get_NextDimensionIndex: integer;
begin
  Result:=FNextDimensionIndex
end;

procedure TDMArrayDimension.Set_NextDimensionIndex(Value:integer);
begin
  FNextDimensionIndex:=Value
end;

procedure TDMArrayDimension.SetNextDimensionIndexes;
var
  DMArray:IDMArray;
begin
  if Parent=nil then Exit;
  DMArray:=Parent as IDMArray;
  DMArray.BuildNextDimensionIndexes
end;

procedure TDMArrayDimension.Set_Parent(const Value: IDMElement);
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  SetNextDimensionIndexes;
end;

{TDMArrayDimItem}

function TDMArrayDimItem.Get_Code: Integer;
begin
  Result:=(Parent as  IDMArrayDimension).DimItems.IndexOf(Self as IDMElement)
end;

function TDMArrayDimItem.Get_Level: Integer;
begin
  Result:=0;
end;

function TDMArrayDimItem.Get_Modifier: Integer;
begin
  Result:=0
end;

function TDMArrayDimItem.Get_ValueFormat: WideString;
begin
  Result:='%0.4f'
end;

function TDMArrayDimItem.Get_ValueType: Integer;
begin
  Result:=fvtFloat
end;

class procedure TDMArrayDimItem.MakeFields0;
begin
  AddField(rsParameterDefaultValue, '%6.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(mpParameterDefaultValue), 0, pkInput);
  AddField(rsParameterMinValue, '%6.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(mpParameterMinValue), 0, pkInput);
  AddField(rsParameterMaxValue, '%6.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(mpParameterMaxValue), 0, pkInput);
  AddField(rsParameterHint, '', '', '',
      fvtString, 0, 0, 0,
      ord(mpParameterHint), 0, pkInput);
  AddField(rsParameterShortName, '', '', '',
      fvtString, 0, 0, 0,
      ord(mpParameterShortName), 0, pkInput);
end;

class function TDMArrayDimItem.GetFields: IDMCollection;
begin
  Result:=FDMArrayDimItemFields
end;

{ TDMArray }

procedure TDMArray._Destroy;
begin
  inherited;
  FDimensions:=nil;
  FArrayValue:=nil;
  FSubArrayList.Free;
end;

function TDMArray.Get_ArrayValue: IDMArrayValue;
begin
  Result:=FArrayValue
end;

function TDMArray.Get_Dimensions: IDMCollection;
begin
  Result:=FDimensions
end;

procedure TDMArray.Initialize;
var
  aArrayValueE:IDMElement;
begin
  inherited;
  FSubArrayList:=TList.Create;
  if DataModel.IsLoading then Exit;
  aArrayValueE:=CreateValue;
  aArrayValueE.Parent:=Self as IDMElement;
  (aArrayValueE as IDMArrayValue).DimensionIndex:=-1;
end;

function TDMArray.CreateValue: IDMElement;
begin
  Result:=nil
end;

procedure TDMArray.RemoveValue(const aValue: IDMElement);
begin
end;

function TDMArray.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0: Result:=FDimensions;
  1: if FArrayValue<>nil then
       Result:=(FArrayValue as IDMElement).Collection[0]
     else
       Result:=nil
  end;
end;

function TDMArray.Get_CollectionCount: Integer;
begin
  Result:=2
end;

procedure TDMArray.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:begin
      aRefSource:=nil;
      aCollectionName:=rsDMArrayDimensions;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoRename or leoDelete;
      aLinkType:=ltOneToMany;
    end;
  1:begin
      aRefSource:=nil;
      aCollectionName:=rsValueMatrix;
      aClassCollections:=nil;
      aOperations:=leoDontCopy;
      aLinkType:=ltOneToMany;
    end;
  end;
end;

procedure TDMArray.AddChild(const aChild: IDMElement);
var
  aArrayValue:IDMArrayValue;
begin
  if aChild.QueryInterface(IDMArrayValue, aArrayValue)=0 then
    FArrayValue:=aArrayValue
  else
    inherited;
end;

procedure TDMArray.RemoveChild(const aChild: IDMElement);
var
  aArrayValue:IDMArrayValue;
begin
  try
  if aChild.QueryInterface(IDMArrayValue, aArrayValue)=0 then begin
      FArrayValue:=nil
  end else
    inherited;
  except
    raise
  end
end;

procedure TDMArray.Clear;
begin
  FArrayValue:=nil;
  inherited;
end;

procedure TDMArray.BuildNextDimensionIndexes;
var
  aDimension, PrevDimension, LastDimension:IDMArrayDimension;
  j, N:integer;
begin
  FSubArrayList.Clear;

  PrevDimension:=nil;
  LastDimension:=nil;
  N:=FDimensions.Count;
  for j:=0 to FDimensions.Count-1 do begin
    aDimension:=FDimensions.Item[j] as IDMArrayDimension;
    if PrevDimension<>nil then begin
      if PrevDimension.SubArrayIndex<>aDimension.SubArrayIndex then begin
        if aDimension.SubArrayIndex<>-1 then
          FSubArrayList.Add(pointer(j));
        if LastDimension<>nil then
          LastDimension.NextDimensionIndex:=N;
        LastDimension:=aDimension;
      end else begin
        LastDimension.NextDimensionIndex:=j;
        LastDimension:=aDimension;
      end;
    end else begin
      if aDimension.SubArrayIndex<>-1 then
        FSubArrayList.Add(pointer(j));
      LastDimension:=aDimension;
    end;
    PrevDimension:=aDimension;
  end;
  if LastDimension<>nil then
    LastDimension.NextDimensionIndex:=N;
end;

function TDMArray.Get_SubArrayCount: integer;
begin
  Result:=FSubArrayList.Count;
end;

function TDMArray.Get_SubArrayDimensionIndex(Index: integer): integer;
begin
  Result:=integer(FSubArrayList[Index])
end;

{ TDMBackRefHolder }

function TDMBackRefHolder.Get_BackRefs: IDMCollection;
begin
  Result:=FBackRefs
end;

procedure TDMBackRefHolder._Destroy;
begin
  inherited;
  FBackRefs:=nil;
end;

procedure TDMBackRefHolder.Initialize;
begin
  inherited;
  FBackRefs:=TDMCollection.Create(Self as IDMElement) as IDMCollection;
end;

function TDMBackRefHolder.Get_OverCount: integer;
begin
  REsult:=FOverCount
end;

procedure TDMBackRefHolder.Set_OverCount(Value: integer);
begin
  FOverCount:=Value
end;

{ TDMBackRefHolders }

function TDMBackRefHolders.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsDMBackRefHolder
end;

class function TDMBackRefHolders.GetElementClass: TDMElementClass;
begin
  Result:=TDMBackRefHolder
end;

class function TDMBackRefHolders.GetElementGUID: TGUID;
begin
  Result:=IID_IDMBackRefHolder
end;

{ TDMText }

procedure TDMText.AddLine(const Value: WideString);
begin
  FLines.Add(Value)
end;

procedure TDMText.ClearLines;
begin
  FLines.Clear;
end;

procedure TDMText.Initialize;
begin
  inherited;
  FLines:=TStringList.Create;
end;

destructor TDMText.Destroy;
begin
  inherited;
  FLines.Free;
end;

function TDMText.Get_Line(Index: Integer): WideString;
begin
  Result:=FLines[Index]
end;

function TDMText.Get_LineCount: Integer;
begin
  Result:=FLines.Count
end;

{ TSortedCollection }

procedure TSortedCollection.Add(const aElement: IDMElement);
var
  p:pointer;
  I:integer;
begin
  p:=pointer(aElement);

  if FSorter<>nil then begin
    if not Search(aElement, I) or FSorter.Duplicates then
      FList.Insert(I, P)
  end else begin
    I:=FList.Count;
    FList.Insert(I, P);
  end;

  aElement._AddRef;
end;

destructor TSortedCollection.Destroy;
begin
  inherited;
  FSorter:=nil;
end;

function TSortedCollection.Search(const Key: IDMElement;
  var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Search := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := FSorter.Compare(Item[I], Key);

    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;

      if C = 0 then
      begin
        Search := True;
        if not FSorter.Duplicates then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

{ TSortedByIDCollection }

function TSortedByIDCollection.GetItemByID(aID: Integer): IDMElement;
var
  Index:integer;
begin
  if SearchID(aID, Index) then
    Result:=Get_Item(Index)
  else
    Result:=nil
end;

procedure TSortedByIDCollection.Initialize;
begin
  inherited;
  FSorter:=TSorter.Create(nil) as ISorter
end;

function TSortedByIDCollection.SearchID(aID: integer; var Index: Integer): Boolean;
var
  L, H, I, C, ItemID: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;

    ItemID:=Get_Item(I).ID;
    if ItemID<aID then
      C:=-1
    else
    if ItemID>aID then
      C:=+1
    else
      C:=0;

    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;

      if C = 0 then
      begin
        Result := True;
//        if not Sorter.Duplicates then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

initialization
  FParameterFields:=TDMFields.Create(nil) as IDMCollection;
  FParameterValueFields:=TDMFields.Create(nil) as IDMCollection;
  FDMArrayValueFields:=TDMFields.Create(nil) as IDMCollection;
  FDMArrayDimItemFields:=TDMFields.Create(nil) as IDMCollection;
  TDMParameter.MakeFields;
  TDMParameterValue.MakeFields;
  TDMArrayValue.MakeFields;
  TDMArrayDimItem.MakeFields;

  LocalDecimalSeparator:=DecimalSeparator;
  DecimalSeparator:='.';

finalization
  (FParameterFields as IDMCollection2).Clear;
  (FParameterValueFields as IDMCollection2).Clear;
  (FDMArrayValueFields as IDMCollection2).Clear;
  (FDMArrayDimItemFields as IDMCollection2).Clear;
  FParameterFields:=nil;
  FParameterValueFields:=nil;
  FDMArrayValueFields:=nil;
  FDMArrayDimItemFields:=nil
end.
