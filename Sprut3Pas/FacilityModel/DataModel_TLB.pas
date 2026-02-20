unit DataModel_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130.1.0.1.0.1.6  $
// File generated on 13.03.2008 19:30:34 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\AutoDM\AutoDMPas\DataModel\DataModel.tlb (1)
// LIBID: {5648DD20-C6D0-11D4-845E-A2D7FAE1C80C}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
// Parent TypeLibrary:
//   (0) v1.0 FacilityModelLib, (D:\users\Volkov\Sprut3\Sprut3Pas\FacilityModel\FacilityModelLib.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DataModelMajorVersion = 1;
  DataModelMinorVersion = 0;

  LIBID_DataModel: TGUID = '{5648DD20-C6D0-11D4-845E-A2D7FAE1C80C}';

  IID_IDMElement: TGUID = '{5648DD23-C6D0-11D4-845E-A2D7FAE1C80C}';
  IID_IDMCollection2: TGUID = '{5648DD29-C6D0-11D4-845E-A2D7FAE1C80C}';
  IID_IDMField: TGUID = '{67119562-C7E9-11D4-845E-CE4ADA5ECC0C}';
  IID_IDataModel: TGUID = '{70518C65-CC8B-11D4-845E-D449CD2DD60B}';
  IID_IDMTreeNode: TGUID = '{26925A20-F47A-11D4-845E-B13DB9051F0F}';
  IID_IDMInstanceSource: TGUID = '{E04727E0-0B70-11D5-BF52-006008957155}';
  IID_IDMClassCollections: TGUID = '{E210552E-0CB6-11D5-845E-F2408CA64311}';
  IID_IDMParameterValue: TGUID = '{240A7C82-62B4-11D5-845E-F7A4DD3C9D0B}';
  IID_ISorter: TGUID = '{ECD017C1-E945-11D5-9302-0050BA51A6D3}';
  IID_IDMAnalyzer: TGUID = '{94727083-3593-11D6-96CA-0050BA51A6D3}';
  IID_IDMCollection: TGUID = '{15818BF2-8495-47F8-B2F4-82763BFC0FAC}';
  IID_IDMError: TGUID = '{6CEBAD61-58D2-11D6-96FA-0050BA51A6D3}';
  IID_IDMArray: TGUID = '{0D8D0F51-60B3-11D6-96FE-0050BA51A6D3}';
  IID_IDMArrayValue: TGUID = '{0D8D0F55-60B3-11D6-96FE-0050BA51A6D3}';
  IID_IDMArrayDimension: TGUID = '{0D8D0F57-60B3-11D6-96FE-0050BA51A6D3}';
  IID_IDMBackRefHolder: TGUID = '{87548205-6742-11D6-93C4-0050BA51A4A4}';
  IID_IDMText: TGUID = '{4B950751-7CFA-11D6-9723-0050BA51A6D3}';
  IID_IDMElement3: TGUID = '{7FB0B803-1864-11D9-9A07-0050BA51A6D3}';
  IID_IDMReporter: TGUID = '{3332AF60-249F-11D9-9BA1-B48E93F7C560}';
  IID_IDMElement2: TGUID = '{88208FEF-9D3C-4EF4-AF98-E641E514EF62}';
  IID_IRefCounter: TGUID = '{C519E92D-84C6-48DF-8B97-75F2E09C68EC}';
  IID_IDMCollection3: TGUID = '{5F10AD5A-23DA-4CB4-B79E-A6C844930D47}';
  IID_IGlobalData: TGUID = '{3006983A-93A5-4B3E-9F95-83D42E4F47DA}';
  IID_IDMElement4: TGUID = '{3E789F7A-D059-4867-B876-C21945A57B95}';
  IID_ICoord: TGUID = '{C6ACC7DD-47C4-4465-82E7-F68B8A5D75E4}';
  IID_IDMHash: TGUID = '{F0FE660E-D9E0-4B33-9B4F-68C777049AB0}';
  IID_IDMClassFactory: TGUID = '{8F570E4D-3C7E-46D5-8CBE-8AF392C7E433}';
  IID_IDMElementXML: TGUID = '{8FBFFEFF-4870-47E4-9EAF-E177E9EC632D}';
  IID_IDataModelXML: TGUID = '{9A1C1FE5-B7CA-4338-9E10-405C1188398D}';
  IID_IDMCollectionXML: TGUID = '{1FA73A76-3BF0-47F2-A780-3E7175224D04}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum DMFieldValueTypes
type
  DMFieldValueTypes = TOleEnum;
const
  fvtInteger = $00000000;
  fvtFloat = $00000001;
  fvtBoolean = $00000002;
  fvtString = $00000003;
  fvtElement = $00000004;
  fvtText = $00000005;
  fvtColor = $00000006;
  fvtFile = $00000007;
  fvtChoice = $00000008;

// Constants for enum DMFieldModifiers
type
  DMFieldModifiers = TOleEnum;
const
  pmIn = $00000000;
  pmOut = $00000001;
  pmInOut = $00000002;

// Constants for enum DMLinkTypes
type
  DMLinkTypes = TOleEnum;
const
  ltOneToMany = $00000000;
  ltManyToMany = $00000001;
  ltBackRefs = $00000002;
  ltParents = $00000003;
  ltIndirect = $00000004;

// Constants for enum DMOperations
type
  DMOperations = TOleEnum;
const
  leoAdd = $00000001;
  leoDelete = $00000002;
  leoRename = $00000004;
  leoSelect = $00000008;
  leoChangeRef = $00000010;
  leoChangeParent = $00000020;
  leoChangeFieldValue = $00000040;
  leoOperation1 = $00000080;
  leoOperation2 = $00000100;
  leoExecute = $00000200;
  leoPaste = $00000400;
  leoDontCopy = $00000800;
  leoMove = $00001000;
  leoSelectRef = $00002000;
  leoPasteProps = $00004000;
  leoColOperation = $00008000;

// Constants for enum CopyLinkMode
type
  CopyLinkMode = TOleEnum;
const
  clmDefault = $00000000;
  clmNil = $00000001;
  clmOldLink = $00000002;
  clmNewLink = $00000003;
  clmExistingLink = $00000004;

// Constants for enum TAliasKind
type
  TAliasKind = TOleEnum;
const
  akImenit = $00000000;
  akRodit = $00000001;
  akDatel = $00000002;
  akVinit = $00000003;
  akTvorit = $00000004;
  akPredl = $00000005;
  akImenitM = $00000006;
  akRoditM = $00000007;
  akDatelM = $00000008;
  akVinitM = $00000009;
  akTvoritM = $0000000A;
  akPredlM = $0000000B;

// Constants for enum TReportMode
type
  TReportMode = TOleEnum;
const
  rmAnalysis = $00000000;
  rmSynthes = $00000001;

// Constants for enum DMFieldKind
type
  DMFieldKind = TOleEnum;
const
  fkInputData = $00000000;
  fkOutputData = $00000001;
  fkUserData = $00000002;
  fkText = $00000003;
  fkImage = $00000004;
  fkShowParam = $00000005;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMElement = interface;
  IDMElementDisp = dispinterface;
  IDMCollection2 = interface;
  IDMCollection2Disp = dispinterface;
  IDMField = interface;
  IDMFieldDisp = dispinterface;
  IDataModel = interface;
  IDataModelDisp = dispinterface;
  IDMTreeNode = interface;
  IDMTreeNodeDisp = dispinterface;
  IDMInstanceSource = interface;
  IDMInstanceSourceDisp = dispinterface;
  IDMClassCollections = interface;
  IDMClassCollectionsDisp = dispinterface;
  IDMParameterValue = interface;
  IDMParameterValueDisp = dispinterface;
  ISorter = interface;
  ISorterDisp = dispinterface;
  IDMAnalyzer = interface;
  IDMAnalyzerDisp = dispinterface;
  IDMCollection = interface;
  IDMCollectionDisp = dispinterface;
  IDMError = interface;
  IDMErrorDisp = dispinterface;
  IDMArray = interface;
  IDMArrayDisp = dispinterface;
  IDMArrayValue = interface;
  IDMArrayValueDisp = dispinterface;
  IDMArrayDimension = interface;
  IDMArrayDimensionDisp = dispinterface;
  IDMBackRefHolder = interface;
  IDMBackRefHolderDisp = dispinterface;
  IDMText = interface;
  IDMTextDisp = dispinterface;
  IDMElement3 = interface;
  IDMElement3Disp = dispinterface;
  IDMReporter = interface;
  IDMReporterDisp = dispinterface;
  IDMElement2 = interface;
  IDMElement2Disp = dispinterface;
  IRefCounter = interface;
  IRefCounterDisp = dispinterface;
  IDMCollection3 = interface;
  IDMCollection3Disp = dispinterface;
  IGlobalData = interface;
  IGlobalDataDisp = dispinterface;
  IDMElement4 = interface;
  IDMElement4Disp = dispinterface;
  ICoord = interface;
  ICoordDisp = dispinterface;
  IDMHash = interface;
  IDMHashDisp = dispinterface;
  IDMClassFactory = interface;
  IDMClassFactoryDisp = dispinterface;
  IDMElementXML = interface;
  IDMElementXMLDisp = dispinterface;
  IDataModelXML = interface;
  IDataModelXMLDisp = dispinterface;
  IDMCollectionXML = interface;
  IDMCollectionXMLDisp = dispinterface;

// *********************************************************************//
// Interface: IDMElement
// Flags:     (320) Dual OleAutomation
// GUID:      {5648DD23-C6D0-11D4-845E-A2D7FAE1C80C}
// *********************************************************************//
  IDMElement = interface(IUnknown)
    ['{5648DD23-C6D0-11D4-845E-A2D7FAE1C80C}']
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_Parent: IDMElement; safecall;
    procedure Set_Parent(const Value: IDMElement); safecall;
    function Get_Ref: IDMElement; safecall;
    procedure Set_Ref(const Value: IDMElement); safecall;
    function Get_ID: Integer; safecall;
    procedure Set_ID(Value: Integer); safecall;
    function Get_OwnerCollection: IDMCollection; safecall;
    function Get_ClassID: Integer; safecall;
    procedure Clear; safecall;
    procedure DisconnectFrom(const aParent: IDMElement); safecall;
    procedure AddChild(const aElement: IDMElement); safecall;
    procedure RemoveChild(const aElement: IDMElement); safecall;
    procedure AddParent(const aParent: IDMElement); safecall;
    procedure RemoveParent(const aParent: IDMElement); safecall;
    function Includes(const aElement: IDMElement): WordBool; safecall;
    procedure Loaded; safecall;
    procedure LoadFromRecordset(const aRecordsetU: IUnknown); safecall;
    procedure SaveToRecordset(const aRecordsetU: IUnknown); safecall;
    procedure AddParentFromRecordset(const aRecordsetU: IUnknown); safecall;
    procedure LoadDataFromRecordset(const aRecordsetU: IUnknown); safecall;
    function Get_FieldCount: Integer; safecall;
    function Get_Field(Index: Integer): IDMField; safecall;
    procedure CalculateFieldValues; safecall;
    function Get_CollectionCount: Integer; safecall;
    function Get_Collection(Index: Integer): IDMCollection; safecall;
    procedure GetCollectionProperties(Index: Integer; out aName: WideString; 
                                      out aRefSource: IDMCollection; 
                                      out aClassCollections: IDMClassCollections; 
                                      out aOperations: Integer; out aLinkType: Integer); safecall;
    function Get_Parents: IDMCollection; safecall;
    function Get_SubKinds: IDMCollection; safecall;
    function Get_BackRefCount: Integer; safecall;
    procedure _AddBackRef(const aElement: IDMElement); safecall;
    procedure _RemoveBackRef(const aElemen: IDMElement); safecall;
    function Get_FieldValue(Index: Integer): OleVariant; safecall;
    procedure Set_FieldValue(Index: Integer; Value: OleVariant); safecall;
    procedure ClearOp; safecall;
    function GetCopyLinkMode(const aLink: IDMElement): Integer; safecall;
    function Get_BuildIn: WordBool; safecall;
    procedure Set_BuildIn(Value: WordBool); safecall;
    procedure SaveParentsToRecordSet(const aRecordsetU: IUnknown); safecall;
    function FieldIsVisible(Code: Integer): WordBool; safecall;
    procedure Draw(const Painter: IUnknown; DrawSelected: Integer); safecall;
    function Get_SpatialElement: IDMElement; safecall;
    procedure Set_SpatialElement(const Value: IDMElement); safecall;
    function Get_Selected: WordBool; safecall;
    procedure Set_Selected(Value: WordBool); safecall;
    procedure Update; safecall;
    procedure SetFieldValue(Code: Integer; Value: OleVariant); safecall;
    function GetFieldValue(Code: Integer): OleVariant; safecall;
    function Get_FieldCount_: Integer; safecall;
    function Get_Field_(Index: Integer): IDMField; safecall;
    function Get_FieldValue_(Index: Integer): OleVariant; safecall;
    procedure Set_FieldValue_(Index: Integer; Value: OleVariant); safecall;
    function Get_MainParent: IDMElement; safecall;
    procedure AfterLoading1; safecall;
    procedure AfterLoading2; safecall;
    procedure JoinSpatialElements(const aElement: IDMElement); safecall;
    procedure BeforeDeletion; safecall;
    function Get_UserDefineded: WordBool; safecall;
    function Get_IsEmpty: WordBool; safecall;
    procedure GetFieldValueSource(Index: Integer; var aCollection: IDMCollection); safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); safecall;
    function Get_Presence: Integer; safecall;
    procedure Set_Presence(Value: Integer); safecall;
    procedure UpdateCoords; safecall;
    procedure AfterCopyFrom(const DestElement: IDMElement); safecall;
    function Get_FieldCategoryCount: Integer; safecall;
    function Get_FieldCategory(Index: Integer): WideString; safecall;
    function Get_Exists: WordBool; safecall;
    procedure Set_Exists(Value: WordBool); safecall;
    function Get_DefaultSubKindIndex: Integer; safecall;
    procedure Set_DefaultSubKindIndex(Value: Integer); safecall;
    function GetCollectionForChild(const aChild: IDMElement): IDMCollection; safecall;
    function FieldIsReadOnly(Index: Integer): WordBool; safecall;
    function Get_DataModel: IDataModel; safecall;
    function CompartibleWith(const aElement: IDMElement): WordBool; safecall;
    function Get_FieldName(Index: Integer): WideString; safecall;
    procedure AfterCopyFrom2; safecall;
    function Get_FieldFormat(Index: Integer): WideString; safecall;
    function Get_IsSelectable: WordBool; safecall;
    function IsSimilarTo(const aElement: IDMElement): WordBool; safecall;
    function Get_SelectRef: WordBool; safecall;
    function Get_SelectParent: WordBool; safecall;
    property Name: WideString read Get_Name write Set_Name;
    property Parent: IDMElement read Get_Parent write Set_Parent;
    property Ref: IDMElement read Get_Ref write Set_Ref;
    property ID: Integer read Get_ID write Set_ID;
    property OwnerCollection: IDMCollection read Get_OwnerCollection;
    property ClassID: Integer read Get_ClassID;
    property FieldCount: Integer read Get_FieldCount;
    property Field[Index: Integer]: IDMField read Get_Field;
    property CollectionCount: Integer read Get_CollectionCount;
    property Collection[Index: Integer]: IDMCollection read Get_Collection;
    property Parents: IDMCollection read Get_Parents;
    property SubKinds: IDMCollection read Get_SubKinds;
    property BackRefCount: Integer read Get_BackRefCount;
    property FieldValue[Index: Integer]: OleVariant read Get_FieldValue write Set_FieldValue;
    property BuildIn: WordBool read Get_BuildIn write Set_BuildIn;
    property SpatialElement: IDMElement read Get_SpatialElement write Set_SpatialElement;
    property Selected: WordBool read Get_Selected write Set_Selected;
    property FieldCount_: Integer read Get_FieldCount_;
    property Field_[Index: Integer]: IDMField read Get_Field_;
    property FieldValue_[Index: Integer]: OleVariant read Get_FieldValue_ write Set_FieldValue_;
    property MainParent: IDMElement read Get_MainParent;
    property UserDefineded: WordBool read Get_UserDefineded;
    property IsEmpty: WordBool read Get_IsEmpty;
    property Presence: Integer read Get_Presence write Set_Presence;
    property FieldCategoryCount: Integer read Get_FieldCategoryCount;
    property FieldCategory[Index: Integer]: WideString read Get_FieldCategory;
    property Exists: WordBool read Get_Exists write Set_Exists;
    property DefaultSubKindIndex: Integer read Get_DefaultSubKindIndex write Set_DefaultSubKindIndex;
    property DataModel: IDataModel read Get_DataModel;
    property FieldName[Index: Integer]: WideString read Get_FieldName;
    property FieldFormat[Index: Integer]: WideString read Get_FieldFormat;
    property IsSelectable: WordBool read Get_IsSelectable;
    property SelectRef: WordBool read Get_SelectRef;
    property SelectParent: WordBool read Get_SelectParent;
  end;

// *********************************************************************//
// DispIntf:  IDMElementDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {5648DD23-C6D0-11D4-845E-A2D7FAE1C80C}
// *********************************************************************//
  IDMElementDisp = dispinterface
    ['{5648DD23-C6D0-11D4-845E-A2D7FAE1C80C}']
    property Name: WideString dispid 1;
    property Parent: IDMElement dispid 3;
    property Ref: IDMElement dispid 4;
    property ID: Integer dispid 2;
    property OwnerCollection: IDMCollection readonly dispid 10;
    property ClassID: Integer readonly dispid 11;
    procedure Clear; dispid 22;
    procedure DisconnectFrom(const aParent: IDMElement); dispid 5;
    procedure AddChild(const aElement: IDMElement); dispid 6;
    procedure RemoveChild(const aElement: IDMElement); dispid 7;
    procedure AddParent(const aParent: IDMElement); dispid 8;
    procedure RemoveParent(const aParent: IDMElement); dispid 9;
    function Includes(const aElement: IDMElement): WordBool; dispid 12;
    procedure Loaded; dispid 17;
    procedure LoadFromRecordset(const aRecordsetU: IUnknown); dispid 15;
    procedure SaveToRecordset(const aRecordsetU: IUnknown); dispid 16;
    procedure AddParentFromRecordset(const aRecordsetU: IUnknown); dispid 18;
    procedure LoadDataFromRecordset(const aRecordsetU: IUnknown); dispid 19;
    property FieldCount: Integer readonly dispid 20;
    property Field[Index: Integer]: IDMField readonly dispid 21;
    procedure CalculateFieldValues; dispid 24;
    property CollectionCount: Integer readonly dispid 29;
    property Collection[Index: Integer]: IDMCollection readonly dispid 30;
    procedure GetCollectionProperties(Index: Integer; out aName: WideString; 
                                      out aRefSource: IDMCollection; 
                                      out aClassCollections: IDMClassCollections; 
                                      out aOperations: Integer; out aLinkType: Integer); dispid 31;
    property Parents: IDMCollection readonly dispid 33;
    property SubKinds: IDMCollection readonly dispid 35;
    property BackRefCount: Integer readonly dispid 36;
    procedure _AddBackRef(const aElement: IDMElement); dispid 37;
    procedure _RemoveBackRef(const aElemen: IDMElement); dispid 38;
    property FieldValue[Index: Integer]: OleVariant dispid 23;
    procedure ClearOp; dispid 25;
    function GetCopyLinkMode(const aLink: IDMElement): Integer; dispid 26;
    property BuildIn: WordBool dispid 27;
    procedure SaveParentsToRecordSet(const aRecordsetU: IUnknown); dispid 14;
    function FieldIsVisible(Code: Integer): WordBool; dispid 32;
    procedure Draw(const Painter: IUnknown; DrawSelected: Integer); dispid 34;
    property SpatialElement: IDMElement dispid 39;
    property Selected: WordBool dispid 40;
    procedure Update; dispid 41;
    procedure SetFieldValue(Code: Integer; Value: OleVariant); dispid 42;
    function GetFieldValue(Code: Integer): OleVariant; dispid 43;
    property FieldCount_: Integer readonly dispid 44;
    property Field_[Index: Integer]: IDMField readonly dispid 45;
    property FieldValue_[Index: Integer]: OleVariant dispid 46;
    property MainParent: IDMElement readonly dispid 47;
    procedure AfterLoading1; dispid 48;
    procedure AfterLoading2; dispid 49;
    procedure JoinSpatialElements(const aElement: IDMElement); dispid 51;
    procedure BeforeDeletion; dispid 52;
    property UserDefineded: WordBool readonly dispid 53;
    property IsEmpty: WordBool readonly dispid 54;
    procedure GetFieldValueSource(Index: Integer; var aCollection: IDMCollection); dispid 28;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); dispid 55;
    property Presence: Integer dispid 56;
    procedure UpdateCoords; dispid 57;
    procedure AfterCopyFrom(const DestElement: IDMElement); dispid 58;
    property FieldCategoryCount: Integer readonly dispid 50;
    property FieldCategory[Index: Integer]: WideString readonly dispid 59;
    property Exists: WordBool dispid 62;
    property DefaultSubKindIndex: Integer dispid 60;
    function GetCollectionForChild(const aChild: IDMElement): IDMCollection; dispid 61;
    function FieldIsReadOnly(Index: Integer): WordBool; dispid 63;
    property DataModel: IDataModel readonly dispid 13;
    function CompartibleWith(const aElement: IDMElement): WordBool; dispid 64;
    property FieldName[Index: Integer]: WideString readonly dispid 65;
    procedure AfterCopyFrom2; dispid 66;
    property FieldFormat[Index: Integer]: WideString readonly dispid 67;
    property IsSelectable: WordBool readonly dispid 68;
    function IsSimilarTo(const aElement: IDMElement): WordBool; dispid 69;
    property SelectRef: WordBool readonly dispid 71;
    property SelectParent: WordBool readonly dispid 70;
  end;

// *********************************************************************//
// Interface: IDMCollection2
// Flags:     (320) Dual OleAutomation
// GUID:      {5648DD29-C6D0-11D4-845E-A2D7FAE1C80C}
// *********************************************************************//
  IDMCollection2 = interface(IUnknown)
    ['{5648DD29-C6D0-11D4-845E-A2D7FAE1C80C}']
    function ShiftElement(const aElement: IDMElement; Shift: Integer): Integer; safecall;
    function MakeDefaultName(const ParentElement: IDMElement): WideString; safecall;
    function CreateElement(BuildIn: WordBool): IDMElement; safecall;
    procedure Add(const aElement: IDMElement); safecall;
    procedure Remove(const aElement: IDMElement); safecall;
    procedure Insert(Index: Integer; const aElement: IDMElement); safecall;
    procedure Clear; safecall;
    procedure DisconnectFrom(const aParent: IDMElement); safecall;
    procedure Sort(const Sorter: ISorter); safecall;
    procedure Delete(Index: Integer); safecall;
    procedure Move(OldIndex: Integer; NewIndex: Integer); safecall;
    function Get_ElementContainer: IDMCollection; safecall;
    procedure SaveToDatabase(const aDatabaseU: IUnknown); safecall;
    procedure LoadFromDatabase(const aDatabaseU: IUnknown); safecall;
    procedure LoadedFromDataBase(const aDatabaseU: IUnknown); safecall;
    function CanContain(const aElement: IDMElement): WordBool; safecall;
    function MakeParentsTable(const aDatabaseU: IUnknown): IUnknown; safecall;
    function IsEqualTo(const aCollection: IDMCollection): WordBool; safecall;
    function Get_ClassID: Integer; safecall;
    function Get_StoredNames: WordBool; safecall;
    function GetItemByID(Index: Integer): IDMElement; safecall;
    function GetItemByRef(const aRef: IDMElement): IDMElement; safecall;
    function GetItemByRefParent(const aElement: IDMElement): IDMElement; safecall;
    function GetItemByName(const aName: WideString): IDMElement; safecall;
    function IsSimilarTo(const aCollection: IDMCollection; LinkType: Integer): WordBool; safecall;
    function GetItemSimilarTo(const aElement: IDMElement): IDMElement; safecall;
    procedure Loaded; safecall;
    property ElementContainer: IDMCollection read Get_ElementContainer;
    property ClassID: Integer read Get_ClassID;
    property StoredNames: WordBool read Get_StoredNames;
  end;

// *********************************************************************//
// DispIntf:  IDMCollection2Disp
// Flags:     (320) Dual OleAutomation
// GUID:      {5648DD29-C6D0-11D4-845E-A2D7FAE1C80C}
// *********************************************************************//
  IDMCollection2Disp = dispinterface
    ['{5648DD29-C6D0-11D4-845E-A2D7FAE1C80C}']
    function ShiftElement(const aElement: IDMElement; Shift: Integer): Integer; dispid 7;
    function MakeDefaultName(const ParentElement: IDMElement): WideString; dispid 10;
    function CreateElement(BuildIn: WordBool): IDMElement; dispid 11;
    procedure Add(const aElement: IDMElement); dispid 12;
    procedure Remove(const aElement: IDMElement); dispid 13;
    procedure Insert(Index: Integer; const aElement: IDMElement); dispid 15;
    procedure Clear; dispid 16;
    procedure DisconnectFrom(const aParent: IDMElement); dispid 17;
    procedure Sort(const Sorter: ISorter); dispid 18;
    procedure Delete(Index: Integer); dispid 20;
    procedure Move(OldIndex: Integer; NewIndex: Integer); dispid 21;
    property ElementContainer: IDMCollection readonly dispid 22;
    procedure SaveToDatabase(const aDatabaseU: IUnknown); dispid 23;
    procedure LoadFromDatabase(const aDatabaseU: IUnknown); dispid 24;
    procedure LoadedFromDataBase(const aDatabaseU: IUnknown); dispid 26;
    function CanContain(const aElement: IDMElement): WordBool; dispid 27;
    function MakeParentsTable(const aDatabaseU: IUnknown): IUnknown; dispid 28;
    function IsEqualTo(const aCollection: IDMCollection): WordBool; dispid 6;
    property ClassID: Integer readonly dispid 1;
    property StoredNames: WordBool readonly dispid 2;
    function GetItemByID(Index: Integer): IDMElement; dispid 4;
    function GetItemByRef(const aRef: IDMElement): IDMElement; dispid 5;
    function GetItemByRefParent(const aElement: IDMElement): IDMElement; dispid 8;
    function GetItemByName(const aName: WideString): IDMElement; dispid 9;
    function IsSimilarTo(const aCollection: IDMCollection; LinkType: Integer): WordBool; dispid 3;
    function GetItemSimilarTo(const aElement: IDMElement): IDMElement; dispid 14;
    procedure Loaded; dispid 19;
  end;

// *********************************************************************//
// Interface: IDMField
// Flags:     (320) Dual OleAutomation
// GUID:      {67119562-C7E9-11D4-845E-CE4ADA5ECC0C}
// *********************************************************************//
  IDMField = interface(IUnknown)
    ['{67119562-C7E9-11D4-845E-CE4ADA5ECC0C}']
    function Get_ValueType: Integer; safecall;
    procedure Set_ValueType(Value: Integer); safecall;
    function Get_DefaultValue: Double; safecall;
    procedure Set_DefaultValue(Value: Double); safecall;
    function Get_MinValue: Double; safecall;
    procedure Set_MinValue(Value: Double); safecall;
    function Get_MaxValue: Double; safecall;
    procedure Set_MaxValue(Value: Double); safecall;
    function Get_ValueFormat: WideString; safecall;
    procedure Set_ValueFormat(const Value: WideString); safecall;
    function Get_Modifier: Integer; safecall;
    procedure Set_Modifier(Value: Integer); safecall;
    function Get_Level: Integer; safecall;
    procedure Set_Level(Value: Integer); safecall;
    function Get_Hint: WideString; safecall;
    procedure Set_Hint(const Value: WideString); safecall;
    function Get_ShortName: WideString; safecall;
    procedure Set_ShortName(const Value: WideString); safecall;
    function Get_Code: Integer; safecall;
    procedure Set_Code(Value: Integer); safecall;
    property ValueType: Integer read Get_ValueType write Set_ValueType;
    property DefaultValue: Double read Get_DefaultValue write Set_DefaultValue;
    property MinValue: Double read Get_MinValue write Set_MinValue;
    property MaxValue: Double read Get_MaxValue write Set_MaxValue;
    property ValueFormat: WideString read Get_ValueFormat write Set_ValueFormat;
    property Modifier: Integer read Get_Modifier write Set_Modifier;
    property Level: Integer read Get_Level write Set_Level;
    property Hint: WideString read Get_Hint write Set_Hint;
    property ShortName: WideString read Get_ShortName write Set_ShortName;
    property Code: Integer read Get_Code write Set_Code;
  end;

// *********************************************************************//
// DispIntf:  IDMFieldDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {67119562-C7E9-11D4-845E-CE4ADA5ECC0C}
// *********************************************************************//
  IDMFieldDisp = dispinterface
    ['{67119562-C7E9-11D4-845E-CE4ADA5ECC0C}']
    property ValueType: Integer dispid 1;
    property DefaultValue: Double dispid 2;
    property MinValue: Double dispid 3;
    property MaxValue: Double dispid 4;
    property ValueFormat: WideString dispid 12;
    property Modifier: Integer dispid 13;
    property Level: Integer dispid 14;
    property Hint: WideString dispid 15;
    property ShortName: WideString dispid 16;
    property Code: Integer dispid 17;
  end;

// *********************************************************************//
// Interface: IDataModel
// Flags:     (320) Dual OleAutomation
// GUID:      {70518C65-CC8B-11D4-845E-D449CD2DD60B}
// *********************************************************************//
  IDataModel = interface(IUnknown)
    ['{70518C65-CC8B-11D4-845E-D449CD2DD60B}']
    procedure BuildGenerations(Mode: Integer; const aElement: IDMElement); safecall;
    procedure GetRootObject(Mode: Integer; RootIndex: Integer; out RootObject: IUnknown; 
                            out RootObjectName: WideString; out aOperations: Integer; 
                            out aLinkType: Integer); safecall;
    function Get_RootObjectCount(Mode: Integer): Integer; safecall;
    function Get_NextID(aClassID: Integer): Integer; safecall;
    procedure Set_NextID(aClassID: Integer; Value: Integer); safecall;
    function Get_Document: IUnknown; safecall;
    procedure Set_Document(const Value: IUnknown); safecall;
    function Get_IsLoading: WordBool; safecall;
    function Get_IsExecuting: WordBool; safecall;
    function Get_InUndoRedo: WordBool; safecall;
    procedure SaveToDatabase(const aDatabaseU: IUnknown); safecall;
    procedure LoadFromDatabase(const aDatabaseU: IUnknown); safecall;
    procedure LoadedFromDataBase(const aDatabaseU: IUnknown); safecall;
    function Get_SubModel(Index: Integer): IDataModel; safecall;
    function CreateElement(aClassID: Integer): IDMElement; safecall;
    procedure RemoveElement(const aElement: IDMElement); safecall;
    function Get_IsCopying: WordBool; safecall;
    procedure Init; safecall;
    function Get_States: IDMCollection; safecall;
    function Get_CurrentState: IDMElement; safecall;
    procedure Set_CurrentState(const Value: IDMElement); safecall;
    function Get_GenerationCount: Integer; safecall;
    function Get_Generation(Index: Integer): IDMElement; safecall;
    function Get_Analyzer: IDMAnalyzer; safecall;
    procedure Set_Analyzer(const Value: IDMAnalyzer); safecall;
    function Import(const FileName: WideString): Integer; safecall;
    function GetDefaultParent(ClassID: Integer): IDMElement; safecall;
    procedure CorrectErrors; safecall;
    function Get_Errors: IDMCollection; safecall;
    function Get_BackRefHolders: IDMCollection; safecall;
    function Get_IsDestroying: WordBool; safecall;
    function Get_Report: IDMText; safecall;
    function GetDefaultElement(ClassID: Integer): IDMElement; safecall;
    function GetDefaultName(const aRef: IDMElement): WideString; safecall;
    function Get_IsChanging: WordBool; safecall;
    function Get_IndexCollection(Index: Integer): IDMCollection; safecall;
    procedure BeforePaste; safecall;
    procedure AfterPaste; safecall;
    function Get_EmptyBackRefHolder: IDMElement; safecall;
    procedure Set_EmptyBackRefHolder(const Value: IDMElement); safecall;
    function CreateCollection(aClassID: Integer; const aParent: IDMElement): IDMCollection; safecall;
    function Get_XXXRefCount: Integer; safecall;
    procedure Set_XXXRefCount(Value: Integer); safecall;
    procedure HandleError(const ErrorMessage: WideString); safecall;
    procedure CheckErrors; safecall;
    procedure AfterMoveInCollection(const aCollection: IDMCollection); safecall;
    function Get_Warnings: IDMCollection; safecall;
    function GetElementCollectionCount(const aElement: IDMElement): Integer; safecall;
    function GetElementFieldVisible(const aElement: IDMElement; Code: Integer): WordBool; safecall;
    function Get_ApplicationVersion: WideString; safecall;
    procedure Set_ApplicationVersion(const Value: WideString); safecall;
    property RootObjectCount[Mode: Integer]: Integer read Get_RootObjectCount;
    property NextID[aClassID: Integer]: Integer read Get_NextID write Set_NextID;
    property Document: IUnknown read Get_Document write Set_Document;
    property IsLoading: WordBool read Get_IsLoading;
    property IsExecuting: WordBool read Get_IsExecuting;
    property InUndoRedo: WordBool read Get_InUndoRedo;
    property SubModel[Index: Integer]: IDataModel read Get_SubModel;
    property IsCopying: WordBool read Get_IsCopying;
    property States: IDMCollection read Get_States;
    property CurrentState: IDMElement read Get_CurrentState write Set_CurrentState;
    property GenerationCount: Integer read Get_GenerationCount;
    property Generation[Index: Integer]: IDMElement read Get_Generation;
    property Analyzer: IDMAnalyzer read Get_Analyzer write Set_Analyzer;
    property Errors: IDMCollection read Get_Errors;
    property BackRefHolders: IDMCollection read Get_BackRefHolders;
    property IsDestroying: WordBool read Get_IsDestroying;
    property Report: IDMText read Get_Report;
    property IsChanging: WordBool read Get_IsChanging;
    property IndexCollection[Index: Integer]: IDMCollection read Get_IndexCollection;
    property EmptyBackRefHolder: IDMElement read Get_EmptyBackRefHolder write Set_EmptyBackRefHolder;
    property XXXRefCount: Integer read Get_XXXRefCount write Set_XXXRefCount;
    property Warnings: IDMCollection read Get_Warnings;
    property ApplicationVersion: WideString read Get_ApplicationVersion write Set_ApplicationVersion;
  end;

// *********************************************************************//
// DispIntf:  IDataModelDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {70518C65-CC8B-11D4-845E-D449CD2DD60B}
// *********************************************************************//
  IDataModelDisp = dispinterface
    ['{70518C65-CC8B-11D4-845E-D449CD2DD60B}']
    procedure BuildGenerations(Mode: Integer; const aElement: IDMElement); dispid 1;
    procedure GetRootObject(Mode: Integer; RootIndex: Integer; out RootObject: IUnknown; 
                            out RootObjectName: WideString; out aOperations: Integer; 
                            out aLinkType: Integer); dispid 2;
    property RootObjectCount[Mode: Integer]: Integer readonly dispid 3;
    property NextID[aClassID: Integer]: Integer dispid 5;
    property Document: IUnknown dispid 4;
    property IsLoading: WordBool readonly dispid 6;
    property IsExecuting: WordBool readonly dispid 7;
    property InUndoRedo: WordBool readonly dispid 8;
    procedure SaveToDatabase(const aDatabaseU: IUnknown); dispid 9;
    procedure LoadFromDatabase(const aDatabaseU: IUnknown); dispid 10;
    procedure LoadedFromDataBase(const aDatabaseU: IUnknown); dispid 11;
    property SubModel[Index: Integer]: IDataModel readonly dispid 12;
    function CreateElement(aClassID: Integer): IDMElement; dispid 14;
    procedure RemoveElement(const aElement: IDMElement); dispid 15;
    property IsCopying: WordBool readonly dispid 16;
    procedure Init; dispid 17;
    property States: IDMCollection readonly dispid 18;
    property CurrentState: IDMElement dispid 19;
    property GenerationCount: Integer readonly dispid 20;
    property Generation[Index: Integer]: IDMElement readonly dispid 21;
    property Analyzer: IDMAnalyzer dispid 22;
    function Import(const FileName: WideString): Integer; dispid 23;
    function GetDefaultParent(ClassID: Integer): IDMElement; dispid 24;
    procedure CorrectErrors; dispid 25;
    property Errors: IDMCollection readonly dispid 26;
    property BackRefHolders: IDMCollection readonly dispid 27;
    property IsDestroying: WordBool readonly dispid 28;
    property Report: IDMText readonly dispid 29;
    function GetDefaultElement(ClassID: Integer): IDMElement; dispid 30;
    function GetDefaultName(const aRef: IDMElement): WideString; dispid 31;
    property IsChanging: WordBool readonly dispid 32;
    property IndexCollection[Index: Integer]: IDMCollection readonly dispid 33;
    procedure BeforePaste; dispid 34;
    procedure AfterPaste; dispid 35;
    property EmptyBackRefHolder: IDMElement dispid 13;
    function CreateCollection(aClassID: Integer; const aParent: IDMElement): IDMCollection; dispid 36;
    property XXXRefCount: Integer dispid 37;
    procedure HandleError(const ErrorMessage: WideString); dispid 38;
    procedure CheckErrors; dispid 39;
    procedure AfterMoveInCollection(const aCollection: IDMCollection); dispid 40;
    property Warnings: IDMCollection readonly dispid 41;
    function GetElementCollectionCount(const aElement: IDMElement): Integer; dispid 42;
    function GetElementFieldVisible(const aElement: IDMElement; Code: Integer): WordBool; dispid 43;
    property ApplicationVersion: WideString dispid 44;
  end;

// *********************************************************************//
// Interface: IDMTreeNode
// Flags:     (320) Dual OleAutomation
// GUID:      {26925A20-F47A-11D4-845E-B13DB9051F0F}
// *********************************************************************//
  IDMTreeNode = interface(IUnknown)
    ['{26925A20-F47A-11D4-845E-B13DB9051F0F}']
    function Get_DrawItalic: WordBool; safecall;
    property DrawItalic: WordBool read Get_DrawItalic;
  end;

// *********************************************************************//
// DispIntf:  IDMTreeNodeDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {26925A20-F47A-11D4-845E-B13DB9051F0F}
// *********************************************************************//
  IDMTreeNodeDisp = dispinterface
    ['{26925A20-F47A-11D4-845E-B13DB9051F0F}']
    property DrawItalic: WordBool readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IDMInstanceSource
// Flags:     (320) Dual OleAutomation
// GUID:      {E04727E0-0B70-11D5-BF52-006008957155}
// *********************************************************************//
  IDMInstanceSource = interface(IUnknown)
    ['{E04727E0-0B70-11D5-BF52-006008957155}']
    function Get_InstanceClassID: Integer; safecall;
    property InstanceClassID: Integer read Get_InstanceClassID;
  end;

// *********************************************************************//
// DispIntf:  IDMInstanceSourceDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {E04727E0-0B70-11D5-BF52-006008957155}
// *********************************************************************//
  IDMInstanceSourceDisp = dispinterface
    ['{E04727E0-0B70-11D5-BF52-006008957155}']
    property InstanceClassID: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IDMClassCollections
// Flags:     (320) Dual OleAutomation
// GUID:      {E210552E-0CB6-11D5-845E-F2408CA64311}
// *********************************************************************//
  IDMClassCollections = interface(IUnknown)
    ['{E210552E-0CB6-11D5-845E-F2408CA64311}']
    function Get_ClassCount(Mode: Integer): Integer; safecall;
    function Get_ClassCollection(Index: Integer; Mode: Integer): IDMCollection; safecall;
    function Get_DefaultClassCollectionIndex(Index: Integer; Mode: Integer): Integer; safecall;
    procedure Set_DefaultClassCollectionIndex(Index: Integer; Mode: Integer; Value: Integer); safecall;
    property ClassCount[Mode: Integer]: Integer read Get_ClassCount;
    property ClassCollection[Index: Integer; Mode: Integer]: IDMCollection read Get_ClassCollection;
    property DefaultClassCollectionIndex[Index: Integer; Mode: Integer]: Integer read Get_DefaultClassCollectionIndex write Set_DefaultClassCollectionIndex;
  end;

// *********************************************************************//
// DispIntf:  IDMClassCollectionsDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {E210552E-0CB6-11D5-845E-F2408CA64311}
// *********************************************************************//
  IDMClassCollectionsDisp = dispinterface
    ['{E210552E-0CB6-11D5-845E-F2408CA64311}']
    property ClassCount[Mode: Integer]: Integer readonly dispid 1;
    property ClassCollection[Index: Integer; Mode: Integer]: IDMCollection readonly dispid 2;
    property DefaultClassCollectionIndex[Index: Integer; Mode: Integer]: Integer dispid 3;
  end;

// *********************************************************************//
// Interface: IDMParameterValue
// Flags:     (320) Dual OleAutomation
// GUID:      {240A7C82-62B4-11D5-845E-F7A4DD3C9D0B}
// *********************************************************************//
  IDMParameterValue = interface(IUnknown)
    ['{240A7C82-62B4-11D5-845E-F7A4DD3C9D0B}']
    function Get_Value: OleVariant; safecall;
    procedure Set_Value(Value: OleVariant); safecall;
    function Get_Parameter: IDMField; safecall;
    property Value: OleVariant read Get_Value write Set_Value;
    property Parameter: IDMField read Get_Parameter;
  end;

// *********************************************************************//
// DispIntf:  IDMParameterValueDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {240A7C82-62B4-11D5-845E-F7A4DD3C9D0B}
// *********************************************************************//
  IDMParameterValueDisp = dispinterface
    ['{240A7C82-62B4-11D5-845E-F7A4DD3C9D0B}']
    property Value: OleVariant dispid 1;
    property Parameter: IDMField readonly dispid 3;
  end;

// *********************************************************************//
// Interface: ISorter
// Flags:     (320) Dual OleAutomation
// GUID:      {ECD017C1-E945-11D5-9302-0050BA51A6D3}
// *********************************************************************//
  ISorter = interface(IUnknown)
    ['{ECD017C1-E945-11D5-9302-0050BA51A6D3}']
    function Get_Duplicates: WordBool; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; safecall;
    property Duplicates: WordBool read Get_Duplicates;
  end;

// *********************************************************************//
// DispIntf:  ISorterDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {ECD017C1-E945-11D5-9302-0050BA51A6D3}
// *********************************************************************//
  ISorterDisp = dispinterface
    ['{ECD017C1-E945-11D5-9302-0050BA51A6D3}']
    property Duplicates: WordBool readonly dispid 1;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; dispid 2;
  end;

// *********************************************************************//
// Interface: IDMAnalyzer
// Flags:     (320) Dual OleAutomation
// GUID:      {94727083-3593-11D6-96CA-0050BA51A6D3}
// *********************************************************************//
  IDMAnalyzer = interface(IUnknown)
    ['{94727083-3593-11D6-96CA-0050BA51A6D3}']
    procedure Start(aMode: Integer); safecall;
    procedure Stop; safecall;
    procedure Continue; safecall;
    function Get_Data: IDMElement; safecall;
    procedure Set_Data(const Value: IDMElement); safecall;
    function Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    procedure TreatElement(const aElement: IDMElement; aMode: Integer); safecall;
    function Get_Report: IDMText; safecall;
    function Get_PrevAnalyzer: IUnknown; safecall;
    procedure Set_PrevAnalyzer(const Value: IUnknown); safecall;
    function Get_ErrorDescription: WideString; safecall;
    property Data: IDMElement read Get_Data write Set_Data;
    property Mode: Integer read Get_Mode write Set_Mode;
    property Report: IDMText read Get_Report;
    property PrevAnalyzer: IUnknown read Get_PrevAnalyzer write Set_PrevAnalyzer;
    property ErrorDescription: WideString read Get_ErrorDescription;
  end;

// *********************************************************************//
// DispIntf:  IDMAnalyzerDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {94727083-3593-11D6-96CA-0050BA51A6D3}
// *********************************************************************//
  IDMAnalyzerDisp = dispinterface
    ['{94727083-3593-11D6-96CA-0050BA51A6D3}']
    procedure Start(aMode: Integer); dispid 1;
    procedure Stop; dispid 2;
    procedure Continue; dispid 3;
    property Data: IDMElement dispid 5;
    property Mode: Integer dispid 6;
    procedure TreatElement(const aElement: IDMElement; aMode: Integer); dispid 4;
    property Report: IDMText readonly dispid 7;
    property PrevAnalyzer: IUnknown dispid 8;
    property ErrorDescription: WideString readonly dispid 9;
  end;

// *********************************************************************//
// Interface: IDMCollection
// Flags:     (320) Dual OleAutomation
// GUID:      {15818BF2-8495-47F8-B2F4-82763BFC0FAC}
// *********************************************************************//
  IDMCollection = interface(IUnknown)
    ['{15818BF2-8495-47F8-B2F4-82763BFC0FAC}']
    function Get_Count: Integer; safecall;
    function Get_Item(Index: Integer): IDMElement; safecall;
    function Get_ClassAlias(Index: Integer): WideString; safecall;
    function IndexOf(const aElement: IDMElement): Integer; safecall;
    function Get_ClassID: Integer; safecall;
    function Get_Parent: IDMElement; safecall;
    procedure Set_Parent(const Value: IDMElement); safecall;
    function Get_DataModel: IDataModel; safecall;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: IDMElement read Get_Item;
    property ClassAlias[Index: Integer]: WideString read Get_ClassAlias;
    property ClassID: Integer read Get_ClassID;
    property Parent: IDMElement read Get_Parent write Set_Parent;
    property DataModel: IDataModel read Get_DataModel;
  end;

// *********************************************************************//
// DispIntf:  IDMCollectionDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {15818BF2-8495-47F8-B2F4-82763BFC0FAC}
// *********************************************************************//
  IDMCollectionDisp = dispinterface
    ['{15818BF2-8495-47F8-B2F4-82763BFC0FAC}']
    property Count: Integer readonly dispid 1;
    property Item[Index: Integer]: IDMElement readonly dispid 2;
    property ClassAlias[Index: Integer]: WideString readonly dispid 3;
    function IndexOf(const aElement: IDMElement): Integer; dispid 4;
    property ClassID: Integer readonly dispid 5;
    property Parent: IDMElement dispid 6;
    property DataModel: IDataModel readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IDMError
// Flags:     (320) Dual OleAutomation
// GUID:      {6CEBAD61-58D2-11D6-96FA-0050BA51A6D3}
// *********************************************************************//
  IDMError = interface(IUnknown)
    ['{6CEBAD61-58D2-11D6-96FA-0050BA51A6D3}']
    function Get_Code: Integer; safecall;
    procedure Set_Code(Value: Integer); safecall;
    function Get_Level: Integer; safecall;
    procedure Set_Level(Value: Integer); safecall;
    function Get_Correctable: WordBool; safecall;
    property Code: Integer read Get_Code write Set_Code;
    property Level: Integer read Get_Level write Set_Level;
    property Correctable: WordBool read Get_Correctable;
  end;

// *********************************************************************//
// DispIntf:  IDMErrorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {6CEBAD61-58D2-11D6-96FA-0050BA51A6D3}
// *********************************************************************//
  IDMErrorDisp = dispinterface
    ['{6CEBAD61-58D2-11D6-96FA-0050BA51A6D3}']
    property Code: Integer dispid 1;
    property Level: Integer dispid 2;
    property Correctable: WordBool readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IDMArray
// Flags:     (320) Dual OleAutomation
// GUID:      {0D8D0F51-60B3-11D6-96FE-0050BA51A6D3}
// *********************************************************************//
  IDMArray = interface(IUnknown)
    ['{0D8D0F51-60B3-11D6-96FE-0050BA51A6D3}']
    function Get_Dimensions: IDMCollection; safecall;
    function Get_ArrayValue: IDMArrayValue; safecall;
    function CreateValue: IDMElement; safecall;
    procedure RemoveValue(const aValue: IDMElement); safecall;
    procedure BuildNextDimensionIndexes; safecall;
    function Get_SubArrayCount: Integer; safecall;
    function Get_SubArrayDimensionIndex(Index: Integer): Integer; safecall;
    property Dimensions: IDMCollection read Get_Dimensions;
    property ArrayValue: IDMArrayValue read Get_ArrayValue;
    property SubArrayCount: Integer read Get_SubArrayCount;
    property SubArrayDimensionIndex[Index: Integer]: Integer read Get_SubArrayDimensionIndex;
  end;

// *********************************************************************//
// DispIntf:  IDMArrayDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {0D8D0F51-60B3-11D6-96FE-0050BA51A6D3}
// *********************************************************************//
  IDMArrayDisp = dispinterface
    ['{0D8D0F51-60B3-11D6-96FE-0050BA51A6D3}']
    property Dimensions: IDMCollection readonly dispid 1;
    property ArrayValue: IDMArrayValue readonly dispid 3;
    function CreateValue: IDMElement; dispid 2;
    procedure RemoveValue(const aValue: IDMElement); dispid 4;
    procedure BuildNextDimensionIndexes; dispid 5;
    property SubArrayCount: Integer readonly dispid 6;
    property SubArrayDimensionIndex[Index: Integer]: Integer readonly dispid 7;
  end;

// *********************************************************************//
// Interface: IDMArrayValue
// Flags:     (320) Dual OleAutomation
// GUID:      {0D8D0F55-60B3-11D6-96FE-0050BA51A6D3}
// *********************************************************************//
  IDMArrayValue = interface(IUnknown)
    ['{0D8D0F55-60B3-11D6-96FE-0050BA51A6D3}']
    procedure InsertValues; safecall;
    procedure DeleteValues(aValueIndex: Integer; aDimensionIndex: Integer); safecall;
    function Get_DimensionIndex: Integer; safecall;
    procedure Set_DimensionIndex(Value: Integer); safecall;
    function Get_ArrayValues: IDMCollection; safecall;
    function Get_Value: Double; safecall;
    procedure Set_Value(Value: Double); safecall;
    function Get_DMArray: IDMArray; safecall;
    property DimensionIndex: Integer read Get_DimensionIndex write Set_DimensionIndex;
    property ArrayValues: IDMCollection read Get_ArrayValues;
    property Value: Double read Get_Value write Set_Value;
    property DMArray: IDMArray read Get_DMArray;
  end;

// *********************************************************************//
// DispIntf:  IDMArrayValueDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {0D8D0F55-60B3-11D6-96FE-0050BA51A6D3}
// *********************************************************************//
  IDMArrayValueDisp = dispinterface
    ['{0D8D0F55-60B3-11D6-96FE-0050BA51A6D3}']
    procedure InsertValues; dispid 1;
    procedure DeleteValues(aValueIndex: Integer; aDimensionIndex: Integer); dispid 5;
    property DimensionIndex: Integer dispid 4;
    property ArrayValues: IDMCollection readonly dispid 6;
    property Value: Double dispid 2;
    property DMArray: IDMArray readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IDMArrayDimension
// Flags:     (320) Dual OleAutomation
// GUID:      {0D8D0F57-60B3-11D6-96FE-0050BA51A6D3}
// *********************************************************************//
  IDMArrayDimension = interface(IUnknown)
    ['{0D8D0F57-60B3-11D6-96FE-0050BA51A6D3}']
    function Get_DimItems: IDMCollection; safecall;
    function Get_SubArrayIndex: Integer; safecall;
    function Get_NextDimensionIndex: Integer; safecall;
    procedure Set_NextDimensionIndex(Value: Integer); safecall;
    property DimItems: IDMCollection read Get_DimItems;
    property SubArrayIndex: Integer read Get_SubArrayIndex;
    property NextDimensionIndex: Integer read Get_NextDimensionIndex write Set_NextDimensionIndex;
  end;

// *********************************************************************//
// DispIntf:  IDMArrayDimensionDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {0D8D0F57-60B3-11D6-96FE-0050BA51A6D3}
// *********************************************************************//
  IDMArrayDimensionDisp = dispinterface
    ['{0D8D0F57-60B3-11D6-96FE-0050BA51A6D3}']
    property DimItems: IDMCollection readonly dispid 1;
    property SubArrayIndex: Integer readonly dispid 2;
    property NextDimensionIndex: Integer dispid 3;
  end;

// *********************************************************************//
// Interface: IDMBackRefHolder
// Flags:     (320) Dual OleAutomation
// GUID:      {87548205-6742-11D6-93C4-0050BA51A4A4}
// *********************************************************************//
  IDMBackRefHolder = interface(IUnknown)
    ['{87548205-6742-11D6-93C4-0050BA51A4A4}']
    function Get_BackRefs: IDMCollection; safecall;
    function Get_OverCount: Integer; safecall;
    procedure Set_OverCount(Value: Integer); safecall;
    property BackRefs: IDMCollection read Get_BackRefs;
    property OverCount: Integer read Get_OverCount write Set_OverCount;
  end;

// *********************************************************************//
// DispIntf:  IDMBackRefHolderDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {87548205-6742-11D6-93C4-0050BA51A4A4}
// *********************************************************************//
  IDMBackRefHolderDisp = dispinterface
    ['{87548205-6742-11D6-93C4-0050BA51A4A4}']
    property BackRefs: IDMCollection readonly dispid 1;
    property OverCount: Integer dispid 2;
  end;

// *********************************************************************//
// Interface: IDMText
// Flags:     (320) Dual OleAutomation
// GUID:      {4B950751-7CFA-11D6-9723-0050BA51A6D3}
// *********************************************************************//
  IDMText = interface(IUnknown)
    ['{4B950751-7CFA-11D6-9723-0050BA51A6D3}']
    function Get_LineCount: Integer; safecall;
    function Get_Line(Index: Integer): WideString; safecall;
    procedure AddLine(const Value: WideString); safecall;
    procedure ClearLines; safecall;
    property LineCount: Integer read Get_LineCount;
    property Line[Index: Integer]: WideString read Get_Line;
  end;

// *********************************************************************//
// DispIntf:  IDMTextDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {4B950751-7CFA-11D6-9723-0050BA51A6D3}
// *********************************************************************//
  IDMTextDisp = dispinterface
    ['{4B950751-7CFA-11D6-9723-0050BA51A6D3}']
    property LineCount: Integer readonly dispid 1;
    property Line[Index: Integer]: WideString readonly dispid 2;
    procedure AddLine(const Value: WideString); dispid 3;
    procedure ClearLines; dispid 4;
  end;

// *********************************************************************//
// Interface: IDMElement3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7FB0B803-1864-11D9-9A07-0050BA51A6D3}
// *********************************************************************//
  IDMElement3 = interface(IDispatch)
    ['{7FB0B803-1864-11D9-9A07-0050BA51A6D3}']
    function Get_SpatialElementClassID: Integer; safecall;
    property SpatialElementClassID: Integer read Get_SpatialElementClassID;
  end;

// *********************************************************************//
// DispIntf:  IDMElement3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7FB0B803-1864-11D9-9A07-0050BA51A6D3}
// *********************************************************************//
  IDMElement3Disp = dispinterface
    ['{7FB0B803-1864-11D9-9A07-0050BA51A6D3}']
    property SpatialElementClassID: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IDMReporter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3332AF60-249F-11D9-9BA1-B48E93F7C560}
// *********************************************************************//
  IDMReporter = interface(IDispatch)
    ['{3332AF60-249F-11D9-9BA1-B48E93F7C560}']
    procedure BuildReport(ReportLevel: Integer; TabCount: Integer; ReportMode: Integer; 
                          const Report: IDMText); safecall;
    function Get_ReportModeCount: Integer; safecall;
    function Get_ReportModeName(Index: Integer): WideString; safecall;
    property ReportModeCount: Integer read Get_ReportModeCount;
    property ReportModeName[Index: Integer]: WideString read Get_ReportModeName;
  end;

// *********************************************************************//
// DispIntf:  IDMReporterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3332AF60-249F-11D9-9BA1-B48E93F7C560}
// *********************************************************************//
  IDMReporterDisp = dispinterface
    ['{3332AF60-249F-11D9-9BA1-B48E93F7C560}']
    procedure BuildReport(ReportLevel: Integer; TabCount: Integer; ReportMode: Integer; 
                          const Report: IDMText); dispid 1;
    property ReportModeCount: Integer readonly dispid 2;
    property ReportModeName[Index: Integer]: WideString readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IDMElement2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {88208FEF-9D3C-4EF4-AF98-E641E514EF62}
// *********************************************************************//
  IDMElement2 = interface(IDispatch)
    ['{88208FEF-9D3C-4EF4-AF98-E641E514EF62}']
    function GetOperationName(Index: Integer; OpID: Integer): WideString; safecall;
    function DoOperation(Index: Integer; OpID: Integer; var Param1: OleVariant; 
                         var Param2: OleVariant; var Param3: OleVariant): WordBool; safecall;
    function GetShortCut(Index: Integer; OpID: Integer): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMElement2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {88208FEF-9D3C-4EF4-AF98-E641E514EF62}
// *********************************************************************//
  IDMElement2Disp = dispinterface
    ['{88208FEF-9D3C-4EF4-AF98-E641E514EF62}']
    function GetOperationName(Index: Integer; OpID: Integer): WideString; dispid 1;
    function DoOperation(Index: Integer; OpID: Integer; var Param1: OleVariant; 
                         var Param2: OleVariant; var Param3: OleVariant): WordBool; dispid 2;
    function GetShortCut(Index: Integer; OpID: Integer): WideString; dispid 4;
  end;

// *********************************************************************//
// Interface: IRefCounter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C519E92D-84C6-48DF-8B97-75F2E09C68EC}
// *********************************************************************//
  IRefCounter = interface(IDispatch)
    ['{C519E92D-84C6-48DF-8B97-75F2E09C68EC}']
    function Get_RefCount: Integer; safecall;
    property RefCount: Integer read Get_RefCount;
  end;

// *********************************************************************//
// DispIntf:  IRefCounterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C519E92D-84C6-48DF-8B97-75F2E09C68EC}
// *********************************************************************//
  IRefCounterDisp = dispinterface
    ['{C519E92D-84C6-48DF-8B97-75F2E09C68EC}']
    property RefCount: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IDMCollection3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5F10AD5A-23DA-4CB4-B79E-A6C844930D47}
// *********************************************************************//
  IDMCollection3 = interface(IDispatch)
    ['{5F10AD5A-23DA-4CB4-B79E-A6C844930D47}']
    function Get_ClassAlias2(Index: Integer): WideString; safecall;
    property ClassAlias2[Index: Integer]: WideString read Get_ClassAlias2;
  end;

// *********************************************************************//
// DispIntf:  IDMCollection3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5F10AD5A-23DA-4CB4-B79E-A6C844930D47}
// *********************************************************************//
  IDMCollection3Disp = dispinterface
    ['{5F10AD5A-23DA-4CB4-B79E-A6C844930D47}']
    property ClassAlias2[Index: Integer]: WideString readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IGlobalData
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3006983A-93A5-4B3E-9F95-83D42E4F47DA}
// *********************************************************************//
  IGlobalData = interface(IDispatch)
    ['{3006983A-93A5-4B3E-9F95-83D42E4F47DA}']
    function Get_GlobalValue(Intex: Integer): Double; safecall;
    procedure Set_GlobalValue(Intex: Integer; Value: Double); safecall;
    function Get_GlobalIntf(Index: Integer): IUnknown; safecall;
    procedure Set_GlobalIntf(Index: Integer; const Value: IUnknown); safecall;
    property GlobalValue[Intex: Integer]: Double read Get_GlobalValue write Set_GlobalValue;
    property GlobalIntf[Index: Integer]: IUnknown read Get_GlobalIntf write Set_GlobalIntf;
  end;

// *********************************************************************//
// DispIntf:  IGlobalDataDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3006983A-93A5-4B3E-9F95-83D42E4F47DA}
// *********************************************************************//
  IGlobalDataDisp = dispinterface
    ['{3006983A-93A5-4B3E-9F95-83D42E4F47DA}']
    property GlobalValue[Intex: Integer]: Double dispid 1;
    property GlobalIntf[Index: Integer]: IUnknown dispid 4;
  end;

// *********************************************************************//
// Interface: IDMElement4
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3E789F7A-D059-4867-B876-C21945A57B95}
// *********************************************************************//
  IDMElement4 = interface(IDispatch)
    ['{3E789F7A-D059-4867-B876-C21945A57B95}']
    function AddRefElementRef(const aCollection: IDMCollection; const aName: WideString; 
                              const aRef: IDMElement): IDMElement; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMElement4Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3E789F7A-D059-4867-B876-C21945A57B95}
// *********************************************************************//
  IDMElement4Disp = dispinterface
    ['{3E789F7A-D059-4867-B876-C21945A57B95}']
    function AddRefElementRef(const aCollection: IDMCollection; const aName: WideString; 
                              const aRef: IDMElement): IDMElement; dispid 1;
  end;

// *********************************************************************//
// Interface: ICoord
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C6ACC7DD-47C4-4465-82E7-F68B8A5D75E4}
// *********************************************************************//
  ICoord = interface(IDispatch)
    ['{C6ACC7DD-47C4-4465-82E7-F68B8A5D75E4}']
    function Get_X: Double; safecall;
    procedure Set_X(Value: Double); safecall;
    function Get_Y: Double; safecall;
    procedure Set_Y(Value: Double); safecall;
    function Get_Z: Double; safecall;
    procedure Set_Z(Value: Double); safecall;
    property X: Double read Get_X write Set_X;
    property Y: Double read Get_Y write Set_Y;
    property Z: Double read Get_Z write Set_Z;
  end;

// *********************************************************************//
// DispIntf:  ICoordDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C6ACC7DD-47C4-4465-82E7-F68B8A5D75E4}
// *********************************************************************//
  ICoordDisp = dispinterface
    ['{C6ACC7DD-47C4-4465-82E7-F68B8A5D75E4}']
    property X: Double dispid 1;
    property Y: Double dispid 2;
    property Z: Double dispid 3;
  end;

// *********************************************************************//
// Interface: IDMHash
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F0FE660E-D9E0-4B33-9B4F-68C777049AB0}
// *********************************************************************//
  IDMHash = interface(IDispatch)
    ['{F0FE660E-D9E0-4B33-9B4F-68C777049AB0}']
    procedure AddToHash(const aElement: IDMElement); safecall;
    function GetFromHash(aClassID: Integer; aID: Integer): IDMElement; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMHashDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F0FE660E-D9E0-4B33-9B4F-68C777049AB0}
// *********************************************************************//
  IDMHashDisp = dispinterface
    ['{F0FE660E-D9E0-4B33-9B4F-68C777049AB0}']
    procedure AddToHash(const aElement: IDMElement); dispid 1;
    function GetFromHash(aClassID: Integer; aID: Integer): IDMElement; dispid 2;
  end;

// *********************************************************************//
// Interface: IDMClassFactory
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8F570E4D-3C7E-46D5-8CBE-8AF392C7E433}
// *********************************************************************//
  IDMClassFactory = interface(IDispatch)
    ['{8F570E4D-3C7E-46D5-8CBE-8AF392C7E433}']
    function CreateInstance: IUnknown; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMClassFactoryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8F570E4D-3C7E-46D5-8CBE-8AF392C7E433}
// *********************************************************************//
  IDMClassFactoryDisp = dispinterface
    ['{8F570E4D-3C7E-46D5-8CBE-8AF392C7E433}']
    function CreateInstance: IUnknown; dispid 1;
  end;

// *********************************************************************//
// Interface: IDMElementXML
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8FBFFEFF-4870-47E4-9EAF-E177E9EC632D}
// *********************************************************************//
  IDMElementXML = interface(IDispatch)
    ['{8FBFFEFF-4870-47E4-9EAF-E177E9EC632D}']
    procedure WriteToXML(const aDMXML: IUnknown; WriteInstance: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMElementXMLDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8FBFFEFF-4870-47E4-9EAF-E177E9EC632D}
// *********************************************************************//
  IDMElementXMLDisp = dispinterface
    ['{8FBFFEFF-4870-47E4-9EAF-E177E9EC632D}']
    procedure WriteToXML(const aDMXML: IUnknown; WriteInstance: WordBool); dispid 1;
  end;

// *********************************************************************//
// Interface: IDataModelXML
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9A1C1FE5-B7CA-4338-9E10-405C1188398D}
// *********************************************************************//
  IDataModelXML = interface(IDispatch)
    ['{9A1C1FE5-B7CA-4338-9E10-405C1188398D}']
    procedure ProcessXMLString(const S: WideString; TagFlag: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IDataModelXMLDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9A1C1FE5-B7CA-4338-9E10-405C1188398D}
// *********************************************************************//
  IDataModelXMLDisp = dispinterface
    ['{9A1C1FE5-B7CA-4338-9E10-405C1188398D}']
    procedure ProcessXMLString(const S: WideString; TagFlag: WordBool); dispid 1;
  end;

// *********************************************************************//
// Interface: IDMCollectionXML
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1FA73A76-3BF0-47F2-A780-3E7175224D04}
// *********************************************************************//
  IDMCollectionXML = interface(IDispatch)
    ['{1FA73A76-3BF0-47F2-A780-3E7175224D04}']
    procedure WriteToXML(const aDMXML: IUnknown; WriteInstance: WordBool; Index: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMCollectionXMLDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1FA73A76-3BF0-47F2-A780-3E7175224D04}
// *********************************************************************//
  IDMCollectionXMLDisp = dispinterface
    ['{1FA73A76-3BF0-47F2-A780-3E7175224D04}']
    procedure WriteToXML(const aDMXML: IUnknown; WriteInstance: WordBool; Index: Integer); dispid 1;
  end;

implementation

uses ComObj;

end.
