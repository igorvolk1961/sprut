unit DMGLib_TLB;

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

// PASTLWTR : $Revision:   1.130  $
// File generated on 27.05.04 17:07:00 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\Projects\dmg\DMGLib.dll (1)
// LIBID: {E1EDF780-37BB-11D7-9B9F-EFD92989C560}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\STDOLE2.TLB)
//   (2) v1.0 DataModel, (D:\Users\Volkov\AutoDM\AutoDMPas\DataModel\DataModel.tlb)
//   (3) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses ActiveX, Classes, DataModel_TLB, Graphics, OleServer, StdVCL, Variants, 
Windows;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DMGLibMajorVersion = 1;
  DMGLibMinorVersion = 0;

  LIBID_DMGLib: TGUID = '{E1EDF780-37BB-11D7-9B9F-EFD92989C560}';

  IID_IDMGenerator: TGUID = '{E1EDF781-37BB-11D7-9B9F-EFD92989C560}';
  CLASS_DMGenerator: TGUID = '{E1EDF783-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgProject: TGUID = '{E1EDF786-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgUnit: TGUID = '{E1EDF788-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgClass: TGUID = '{E1EDF78A-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgInterface: TGUID = '{E1EDF78C-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgEnum: TGUID = '{E1EDF790-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgField: TGUID = '{E1EDF792-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgCollection: TGUID = '{E1EDF794-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgMethod: TGUID = '{E1EDF796-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgMethodParameter: TGUID = '{E1EDF798-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgInterfaceRealization: TGUID = '{E1EDF79A-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgEnumConst: TGUID = '{E1EDF79C-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgObject: TGUID = '{E1EDF79E-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgRepresentation: TGUID = '{E1EDF7A0-37BB-11D7-9B9F-EFD92989C560}';
  IID_IdmgBaseClass: TGUID = '{60885920-3BCA-11D7-9B9F-BB98BDEEA460}';
  IID_IdmgProperty: TGUID = '{71618E80-41F9-11D7-9B9F-D0162EC1B760}';
  IID_IdmgMethodRealization: TGUID = '{6175CB20-45F6-11D7-9B9F-F1254AC3BF60}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TDMGClasses
type
  TDMGClasses = TOleEnum;
const
  _dmgProject = $00000000;
  _dmgUnit = $00000001;
  _dmgClass = $00000002;
  _dmgInterface = $00000003;
  _dmgEnum = $00000004;
  _dmgField = $00000005;
  _dmgCollection = $00000006;
  _dmgMethod = $00000007;
  _dmgMethodParameter = $00000008;
  _dmgInterfaceRealization = $00000009;
  _dmgEnumConst = $0000000A;
  _dmgObject = $0000000B;
  _dmgRepresentation = $0000000C;
  _dmgBaseClass = $0000000D;
  _dmgProperty = $0000000E;
  _dmgMethodRealization = $0000000F;

// Constants for enum TValueModifier
type
  TValueModifier = TOleEnum;
const
  vmNone = $00000000;
  vmConst = $00000001;
  vmVar = $00000002;
  vmOut = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMGenerator = interface;
  IDMGeneratorDisp = dispinterface;
  IdmgProject = interface;
  IdmgProjectDisp = dispinterface;
  IdmgUnit = interface;
  IdmgUnitDisp = dispinterface;
  IdmgClass = interface;
  IdmgClassDisp = dispinterface;
  IdmgInterface = interface;
  IdmgInterfaceDisp = dispinterface;
  IdmgEnum = interface;
  IdmgEnumDisp = dispinterface;
  IdmgField = interface;
  IdmgFieldDisp = dispinterface;
  IdmgCollection = interface;
  IdmgCollectionDisp = dispinterface;
  IdmgMethod = interface;
  IdmgMethodDisp = dispinterface;
  IdmgMethodParameter = interface;
  IdmgMethodParameterDisp = dispinterface;
  IdmgInterfaceRealization = interface;
  IdmgInterfaceRealizationDisp = dispinterface;
  IdmgEnumConst = interface;
  IdmgEnumConstDisp = dispinterface;
  IdmgObject = interface;
  IdmgObjectDisp = dispinterface;
  IdmgRepresentation = interface;
  IdmgRepresentationDisp = dispinterface;
  IdmgBaseClass = interface;
  IdmgBaseClassDisp = dispinterface;
  IdmgProperty = interface;
  IdmgPropertyDisp = dispinterface;
  IdmgMethodRealization = interface;
  IdmgMethodRealizationDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMGenerator = IDMGenerator;


// *********************************************************************//
// Interface: IDMGenerator
// Flags:     (320) Dual OleAutomation
// GUID:      {E1EDF781-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IDMGenerator = interface(IUnknown)
    ['{E1EDF781-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_dmgProjects: IDMCollection; safecall;
    function  Get_dmgUnits: IDMCollection; safecall;
    function  Get_dmgClasses: IDMCollection; safecall;
    function  Get_dmgInterfaces: IDMCollection; safecall;
    function  Get_dmgEnums: IDMCollection; safecall;
    function  Get_dmgFields: IDMCollection; safecall;
    function  Get_dmgCollections: IDMCollection; safecall;
    function  Get_dmgMethods: IDMCollection; safecall;
    function  Get_dmgMethodParameters: IDMCollection; safecall;
    function  Get_dmgInterfaceRealizations: IDMCollection; safecall;
    function  Get_dmgEnumConsts: IDMCollection; safecall;
    function  Get_dmgObjects: IDMCollection; safecall;
    function  Get_dmgRepresentations: IDMCollection; safecall;
    function  Get_dmgBaseClasses: IDMCollection; safecall;
    function  Get_dmgProperties: IDMCollection; safecall;
    function  Get_dmgMethodRealizations: IDMCollection; safecall;
    property dmgProjects: IDMCollection read Get_dmgProjects;
    property dmgUnits: IDMCollection read Get_dmgUnits;
    property dmgClasses: IDMCollection read Get_dmgClasses;
    property dmgInterfaces: IDMCollection read Get_dmgInterfaces;
    property dmgEnums: IDMCollection read Get_dmgEnums;
    property dmgFields: IDMCollection read Get_dmgFields;
    property dmgCollections: IDMCollection read Get_dmgCollections;
    property dmgMethods: IDMCollection read Get_dmgMethods;
    property dmgMethodParameters: IDMCollection read Get_dmgMethodParameters;
    property dmgInterfaceRealizations: IDMCollection read Get_dmgInterfaceRealizations;
    property dmgEnumConsts: IDMCollection read Get_dmgEnumConsts;
    property dmgObjects: IDMCollection read Get_dmgObjects;
    property dmgRepresentations: IDMCollection read Get_dmgRepresentations;
    property dmgBaseClasses: IDMCollection read Get_dmgBaseClasses;
    property dmgProperties: IDMCollection read Get_dmgProperties;
    property dmgMethodRealizations: IDMCollection read Get_dmgMethodRealizations;
  end;

// *********************************************************************//
// DispIntf:  IDMGeneratorDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {E1EDF781-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IDMGeneratorDisp = dispinterface
    ['{E1EDF781-37BB-11D7-9B9F-EFD92989C560}']
    property dmgProjects: IDMCollection readonly dispid 1;
    property dmgUnits: IDMCollection readonly dispid 2;
    property dmgClasses: IDMCollection readonly dispid 3;
    property dmgInterfaces: IDMCollection readonly dispid 4;
    property dmgEnums: IDMCollection readonly dispid 5;
    property dmgFields: IDMCollection readonly dispid 6;
    property dmgCollections: IDMCollection readonly dispid 7;
    property dmgMethods: IDMCollection readonly dispid 8;
    property dmgMethodParameters: IDMCollection readonly dispid 9;
    property dmgInterfaceRealizations: IDMCollection readonly dispid 10;
    property dmgEnumConsts: IDMCollection readonly dispid 11;
    property dmgObjects: IDMCollection readonly dispid 12;
    property dmgRepresentations: IDMCollection readonly dispid 13;
    property dmgBaseClasses: IDMCollection readonly dispid 14;
    property dmgProperties: IDMCollection readonly dispid 15;
    property dmgMethodRealizations: IDMCollection readonly dispid 16;
  end;

// *********************************************************************//
// Interface: IdmgProject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF786-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgProject = interface(IDispatch)
    ['{E1EDF786-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_dmgClasses: IDMCollection; safecall;
    function  Get_dmgObjects: IDMCollection; safecall;
    function  Get_FilePath: WideString; safecall;
    function  Get_DataModelAlias: WideString; safecall;
    function  Get_DataModelFileExt: WideString; safecall;
    function  Get_RefDataModel: IdmgClass; safecall;
    function  Get_dmgInterfaces: IDMCollection; safecall;
    procedure LoadStrings(const FileName: WideString); safecall;
    procedure LoadField(const Line: WideString; j0: Integer); safecall;
    function  Get_BaseDataModel: IdmgClass; safecall;
    procedure Set_BaseDataModel(const Value: IdmgClass); safecall;
    property dmgClasses: IDMCollection read Get_dmgClasses;
    property dmgObjects: IDMCollection read Get_dmgObjects;
    property FilePath: WideString read Get_FilePath;
    property DataModelAlias: WideString read Get_DataModelAlias;
    property DataModelFileExt: WideString read Get_DataModelFileExt;
    property RefDataModel: IdmgClass read Get_RefDataModel;
    property dmgInterfaces: IDMCollection read Get_dmgInterfaces;
    property BaseDataModel: IdmgClass read Get_BaseDataModel write Set_BaseDataModel;
  end;

// *********************************************************************//
// DispIntf:  IdmgProjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF786-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgProjectDisp = dispinterface
    ['{E1EDF786-37BB-11D7-9B9F-EFD92989C560}']
    property dmgClasses: IDMCollection readonly dispid 1;
    property dmgObjects: IDMCollection readonly dispid 2;
    property FilePath: WideString readonly dispid 3;
    property DataModelAlias: WideString readonly dispid 4;
    property DataModelFileExt: WideString readonly dispid 5;
    property RefDataModel: IdmgClass readonly dispid 7;
    property dmgInterfaces: IDMCollection readonly dispid 8;
    procedure LoadStrings(const FileName: WideString); dispid 9;
    procedure LoadField(const Line: WideString; j0: Integer); dispid 10;
    property BaseDataModel: IdmgClass dispid 11;
  end;

// *********************************************************************//
// Interface: IdmgUnit
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF788-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgUnit = interface(IDispatch)
    ['{E1EDF788-37BB-11D7-9B9F-EFD92989C560}']
  end;

// *********************************************************************//
// DispIntf:  IdmgUnitDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF788-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgUnitDisp = dispinterface
    ['{E1EDF788-37BB-11D7-9B9F-EFD92989C560}']
  end;

// *********************************************************************//
// Interface: IdmgClass
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF78A-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgClass = interface(IDispatch)
    ['{E1EDF78A-37BB-11D7-9B9F-EFD92989C560}']
    procedure LoadFromFile(const FileName: WideString; const aProjectE: IDMElement); safecall;
    function  Get_Alias: WideString; safecall;
    function  Get_AliasPlural: WideString; safecall;
    function  Get_HasParents: Integer; safecall;
    function  Get_Descendants: IDMCollection; safecall;
    function  Get_dmgCollections: IDMCollection; safecall;
    function  Get_dmgFields: IDMCollection; safecall;
    function  Get_dmgInterfaceRealizations: IDMCollection; safecall;
    procedure LoadedFromFile; safecall;
    function  Get_Prefix: WideString; safecall;
    property Alias: WideString read Get_Alias;
    property AliasPlural: WideString read Get_AliasPlural;
    property HasParents: Integer read Get_HasParents;
    property Descendants: IDMCollection read Get_Descendants;
    property dmgCollections: IDMCollection read Get_dmgCollections;
    property dmgFields: IDMCollection read Get_dmgFields;
    property dmgInterfaceRealizations: IDMCollection read Get_dmgInterfaceRealizations;
    property Prefix: WideString read Get_Prefix;
  end;

// *********************************************************************//
// DispIntf:  IdmgClassDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF78A-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgClassDisp = dispinterface
    ['{E1EDF78A-37BB-11D7-9B9F-EFD92989C560}']
    procedure LoadFromFile(const FileName: WideString; const aProjectE: IDMElement); dispid 1;
    property Alias: WideString readonly dispid 2;
    property AliasPlural: WideString readonly dispid 3;
    property HasParents: Integer readonly dispid 4;
    property Descendants: IDMCollection readonly dispid 5;
    property dmgCollections: IDMCollection readonly dispid 6;
    property dmgFields: IDMCollection readonly dispid 7;
    property dmgInterfaceRealizations: IDMCollection readonly dispid 8;
    procedure LoadedFromFile; dispid 9;
    property Prefix: WideString readonly dispid 10;
  end;

// *********************************************************************//
// Interface: IdmgInterface
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF78C-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgInterface = interface(IDispatch)
    ['{E1EDF78C-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_dmgMethods: IDMCollection; safecall;
    function  Get_dmgProperties: IDMCollection; safecall;
    property dmgMethods: IDMCollection read Get_dmgMethods;
    property dmgProperties: IDMCollection read Get_dmgProperties;
  end;

// *********************************************************************//
// DispIntf:  IdmgInterfaceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF78C-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgInterfaceDisp = dispinterface
    ['{E1EDF78C-37BB-11D7-9B9F-EFD92989C560}']
    property dmgMethods: IDMCollection readonly dispid 1;
    property dmgProperties: IDMCollection readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IdmgEnum
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF790-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgEnum = interface(IDispatch)
    ['{E1EDF790-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_dmgEnumConsts: IDMCollection; safecall;
    property dmgEnumConsts: IDMCollection read Get_dmgEnumConsts;
  end;

// *********************************************************************//
// DispIntf:  IdmgEnumDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF790-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgEnumDisp = dispinterface
    ['{E1EDF790-37BB-11D7-9B9F-EFD92989C560}']
    property dmgEnumConsts: IDMCollection readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IdmgField
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF792-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgField = interface(IDispatch)
    ['{E1EDF792-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_Alias: WideString; safecall;
    procedure Set_Alias(const Value: WideString); safecall;
    function  Get_ValueType: Integer; safecall;
    procedure Set_ValueType(Value: Integer); safecall;
    function  Get_DefaultValue: Double; safecall;
    procedure Set_DefaultValue(Value: Double); safecall;
    function  Get_MinValue: Double; safecall;
    procedure Set_MinValue(Value: Double); safecall;
    function  Get_MaxValue: Double; safecall;
    procedure Set_MaxValue(Value: Double); safecall;
    function  Get_Code: Integer; safecall;
    procedure Set_Code(Value: Integer); safecall;
    function  Get_Modifier: Integer; safecall;
    procedure Set_Modifier(Value: Integer); safecall;
    function  Get_ValueSourceKind: Integer; safecall;
    procedure Set_ValueSourceKind(Value: Integer); safecall;
    function  Get_ValueSource: IDMElement; safecall;
    procedure Set_ValueSource(const Value: IDMElement); safecall;
    property Alias: WideString read Get_Alias write Set_Alias;
    property ValueType: Integer read Get_ValueType write Set_ValueType;
    property DefaultValue: Double read Get_DefaultValue write Set_DefaultValue;
    property MinValue: Double read Get_MinValue write Set_MinValue;
    property MaxValue: Double read Get_MaxValue write Set_MaxValue;
    property Code: Integer read Get_Code write Set_Code;
    property Modifier: Integer read Get_Modifier write Set_Modifier;
    property ValueSourceKind: Integer read Get_ValueSourceKind write Set_ValueSourceKind;
    property ValueSource: IDMElement read Get_ValueSource write Set_ValueSource;
  end;

// *********************************************************************//
// DispIntf:  IdmgFieldDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF792-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgFieldDisp = dispinterface
    ['{E1EDF792-37BB-11D7-9B9F-EFD92989C560}']
    property Alias: WideString dispid 1;
    property ValueType: Integer dispid 2;
    property DefaultValue: Double dispid 3;
    property MinValue: Double dispid 4;
    property MaxValue: Double dispid 5;
    property Code: Integer dispid 6;
    property Modifier: Integer dispid 7;
    property ValueSourceKind: Integer dispid 8;
    property ValueSource: IDMElement dispid 9;
  end;

// *********************************************************************//
// Interface: IdmgCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF794-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgCollection = interface(IDispatch)
    ['{E1EDF794-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_Alias: WideString; safecall;
    procedure Set_Alias(const Value: WideString); safecall;
    function  Get_RefSourceKind: Integer; safecall;
    procedure Set_RefSourceKind(Value: Integer); safecall;
    function  Get_RefSource: IDMElement; safecall;
    procedure Set_RefSource(const Value: IDMElement); safecall;
    function  Get_LinkType: Integer; safecall;
    procedure Set_LinkType(Value: Integer); safecall;
    property Alias: WideString read Get_Alias write Set_Alias;
    property RefSourceKind: Integer read Get_RefSourceKind write Set_RefSourceKind;
    property RefSource: IDMElement read Get_RefSource write Set_RefSource;
    property LinkType: Integer read Get_LinkType write Set_LinkType;
  end;

// *********************************************************************//
// DispIntf:  IdmgCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF794-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgCollectionDisp = dispinterface
    ['{E1EDF794-37BB-11D7-9B9F-EFD92989C560}']
    property Alias: WideString dispid 1;
    property RefSourceKind: Integer dispid 2;
    property RefSource: IDMElement dispid 3;
    property LinkType: Integer dispid 4;
  end;

// *********************************************************************//
// Interface: IdmgMethod
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF796-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgMethod = interface(IDispatch)
    ['{E1EDF796-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_dmgMethodParameters: IDMCollection; safecall;
    property dmgMethodParameters: IDMCollection read Get_dmgMethodParameters;
  end;

// *********************************************************************//
// DispIntf:  IdmgMethodDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF796-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgMethodDisp = dispinterface
    ['{E1EDF796-37BB-11D7-9B9F-EFD92989C560}']
    property dmgMethodParameters: IDMCollection readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IdmgMethodParameter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF798-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgMethodParameter = interface(IDispatch)
    ['{E1EDF798-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_ValueType: Integer; safecall;
    procedure Set_ValueType(Value: Integer); safecall;
    function  Get_ValueInterface: IdmgInterface; safecall;
    procedure Set_ValueInterface(const Value: IdmgInterface); safecall;
    function  Get_ValueModifier: Integer; safecall;
    procedure Set_ValueModifier(Value: Integer); safecall;
    property ValueType: Integer read Get_ValueType write Set_ValueType;
    property ValueInterface: IdmgInterface read Get_ValueInterface write Set_ValueInterface;
    property ValueModifier: Integer read Get_ValueModifier write Set_ValueModifier;
  end;

// *********************************************************************//
// DispIntf:  IdmgMethodParameterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF798-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgMethodParameterDisp = dispinterface
    ['{E1EDF798-37BB-11D7-9B9F-EFD92989C560}']
    property ValueType: Integer dispid 1;
    property ValueInterface: IdmgInterface dispid 2;
    property ValueModifier: Integer dispid 3;
  end;

// *********************************************************************//
// Interface: IdmgInterfaceRealization
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF79A-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgInterfaceRealization = interface(IDispatch)
    ['{E1EDF79A-37BB-11D7-9B9F-EFD92989C560}']
    function  Get_dmgMethodRealizations: IDMCollection; safecall;
    property dmgMethodRealizations: IDMCollection read Get_dmgMethodRealizations;
  end;

// *********************************************************************//
// DispIntf:  IdmgInterfaceRealizationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF79A-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgInterfaceRealizationDisp = dispinterface
    ['{E1EDF79A-37BB-11D7-9B9F-EFD92989C560}']
    property dmgMethodRealizations: IDMCollection readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IdmgEnumConst
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF79C-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgEnumConst = interface(IDispatch)
    ['{E1EDF79C-37BB-11D7-9B9F-EFD92989C560}']
  end;

// *********************************************************************//
// DispIntf:  IdmgEnumConstDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF79C-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgEnumConstDisp = dispinterface
    ['{E1EDF79C-37BB-11D7-9B9F-EFD92989C560}']
  end;

// *********************************************************************//
// Interface: IdmgObject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF79E-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgObject = interface(IDispatch)
    ['{E1EDF79E-37BB-11D7-9B9F-EFD92989C560}']
  end;

// *********************************************************************//
// DispIntf:  IdmgObjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF79E-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgObjectDisp = dispinterface
    ['{E1EDF79E-37BB-11D7-9B9F-EFD92989C560}']
  end;

// *********************************************************************//
// Interface: IdmgRepresentation
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF7A0-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgRepresentation = interface(IDispatch)
    ['{E1EDF7A0-37BB-11D7-9B9F-EFD92989C560}']
  end;

// *********************************************************************//
// DispIntf:  IdmgRepresentationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E1EDF7A0-37BB-11D7-9B9F-EFD92989C560}
// *********************************************************************//
  IdmgRepresentationDisp = dispinterface
    ['{E1EDF7A0-37BB-11D7-9B9F-EFD92989C560}']
  end;

// *********************************************************************//
// Interface: IdmgBaseClass
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {60885920-3BCA-11D7-9B9F-BB98BDEEA460}
// *********************************************************************//
  IdmgBaseClass = interface(IDispatch)
    ['{60885920-3BCA-11D7-9B9F-BB98BDEEA460}']
  end;

// *********************************************************************//
// DispIntf:  IdmgBaseClassDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {60885920-3BCA-11D7-9B9F-BB98BDEEA460}
// *********************************************************************//
  IdmgBaseClassDisp = dispinterface
    ['{60885920-3BCA-11D7-9B9F-BB98BDEEA460}']
  end;

// *********************************************************************//
// Interface: IdmgProperty
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {71618E80-41F9-11D7-9B9F-D0162EC1B760}
// *********************************************************************//
  IdmgProperty = interface(IDispatch)
    ['{71618E80-41F9-11D7-9B9F-D0162EC1B760}']
    function  Get_ValueType: Integer; safecall;
    procedure Set_ValueType(Value: Integer); safecall;
    function  Get_ValueInterface: IdmgInterface; safecall;
    procedure Set_ValueInterface(const Value: IdmgInterface); safecall;
    function  Get_ReadOnly: WordBool; safecall;
    procedure Set_ReadOnly(Value: WordBool); safecall;
    property ValueType: Integer read Get_ValueType write Set_ValueType;
    property ValueInterface: IdmgInterface read Get_ValueInterface write Set_ValueInterface;
    property ReadOnly: WordBool read Get_ReadOnly write Set_ReadOnly;
  end;

// *********************************************************************//
// DispIntf:  IdmgPropertyDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {71618E80-41F9-11D7-9B9F-D0162EC1B760}
// *********************************************************************//
  IdmgPropertyDisp = dispinterface
    ['{71618E80-41F9-11D7-9B9F-D0162EC1B760}']
    property ValueType: Integer dispid 1;
    property ValueInterface: IdmgInterface dispid 2;
    property ReadOnly: WordBool dispid 3;
  end;

// *********************************************************************//
// Interface: IdmgMethodRealization
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6175CB20-45F6-11D7-9B9F-F1254AC3BF60}
// *********************************************************************//
  IdmgMethodRealization = interface(IDispatch)
    ['{6175CB20-45F6-11D7-9B9F-F1254AC3BF60}']
  end;

// *********************************************************************//
// DispIntf:  IdmgMethodRealizationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6175CB20-45F6-11D7-9B9F-F1254AC3BF60}
// *********************************************************************//
  IdmgMethodRealizationDisp = dispinterface
    ['{6175CB20-45F6-11D7-9B9F-F1254AC3BF60}']
  end;

// *********************************************************************//
// The Class CoDMGenerator provides a Create and CreateRemote method to          
// create instances of the default interface IDMGenerator exposed by              
// the CoClass DMGenerator. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDMGenerator = class
    class function Create: IDMGenerator;
    class function CreateRemote(const MachineName: string): IDMGenerator;
  end;

implementation

uses ComObj;

class function CoDMGenerator.Create: IDMGenerator;
begin
  Result := CreateComObject(CLASS_DMGenerator) as IDMGenerator;
end;

class function CoDMGenerator.CreateRemote(const MachineName: string): IDMGenerator;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DMGenerator) as IDMGenerator;
end;

end.
