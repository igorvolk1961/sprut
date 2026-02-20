unit SafeguardSynthesisLib_TLB;

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
// File generated on 12.11.03 15:42:09 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\Sprut3\bin\SafeguardSynthesisLib.dll (1)
// LIBID: {F9B3E8EE-07FC-11D8-BBF3-0010603BA6C9}
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
  SafeguardSynthesisLibMajorVersion = 1;
  SafeguardSynthesisLibMinorVersion = 0;

  LIBID_SafeguardSynthesisLib: TGUID = '{F9B3E8EE-07FC-11D8-BBF3-0010603BA6C9}';

  IID_ISafeguardSynthesis: TGUID = '{F9B3E8EF-07FC-11D8-BBF3-0010603BA6C9}';
  IID_IEquipmentVariant: TGUID = '{F9B3E8F2-07FC-11D8-BBF3-0010603BA6C9}';
  IID_IEquipmentElement: TGUID = '{F9B3E8F4-07FC-11D8-BBF3-0010603BA6C9}';
  CLASS_SafeguardSynthesis: TGUID = '{F9B3E8F6-07FC-11D8-BBF3-0010603BA6C9}';
  IID_IRecomendation: TGUID = '{DEDE6D11-0849-11D8-98E1-0050BA51A6D3}';
  IID_IRecomendationVariant: TGUID = '{7925B300-0BF0-11D8-BBF3-0010603BA6C9}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TSafeguardSynthesisClass
type
  TSafeguardSynthesisClass = TOleEnum;
const
  _EquipmentVariant = $00000000;
  _EquipmentElement = $00000001;
  _Recomendation = $00000002;
  _RecomendationVariant = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISafeguardSynthesis = interface;
  ISafeguardSynthesisDisp = dispinterface;
  IEquipmentVariant = interface;
  IEquipmentVariantDisp = dispinterface;
  IEquipmentElement = interface;
  IEquipmentElementDisp = dispinterface;
  IRecomendation = interface;
  IRecomendationDisp = dispinterface;
  IRecomendationVariant = interface;
  IRecomendationVariantDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SafeguardSynthesis = ISafeguardSynthesis;


// *********************************************************************//
// Interface: ISafeguardSynthesis
// Flags:     (320) Dual OleAutomation
// GUID:      {F9B3E8EF-07FC-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  ISafeguardSynthesis = interface(IUnknown)
    ['{F9B3E8EF-07FC-11D8-BBF3-0010603BA6C9}']
    function  Get_EquipmentVariants: IDMCollection; safecall;
    function  Get_EquipmentElements: IDMCollection; safecall;
    function  Get_FacilityModel: IDataModel; safecall;
    procedure Set_FacilityModel(const Value: IDataModel); safecall;
    function  Get_EtalonModel: IDataModel; safecall;
    procedure Set_EtalonModel(const Value: IDataModel); safecall;
    function  Get_CurrentEquipmentVariant: IDMElement; safecall;
    procedure Set_CurrentEquipmentVariant(const Value: IDMElement); safecall;
    procedure BuildEquipmentVariants; safecall;
    function  Get_Recomendations: IDMCollection; safecall;
    function  Get_RecomendationVariants: IDMCollection; safecall;
    function  Get_TerminateFlag: WordBool; safecall;
    procedure Set_TerminateFlag(Value: WordBool); safecall;
    procedure Analysis; safecall;
    property EquipmentVariants: IDMCollection read Get_EquipmentVariants;
    property EquipmentElements: IDMCollection read Get_EquipmentElements;
    property FacilityModel: IDataModel read Get_FacilityModel write Set_FacilityModel;
    property EtalonModel: IDataModel read Get_EtalonModel write Set_EtalonModel;
    property CurrentEquipmentVariant: IDMElement read Get_CurrentEquipmentVariant write Set_CurrentEquipmentVariant;
    property Recomendations: IDMCollection read Get_Recomendations;
    property RecomendationVariants: IDMCollection read Get_RecomendationVariants;
    property TerminateFlag: WordBool read Get_TerminateFlag write Set_TerminateFlag;
  end;

// *********************************************************************//
// DispIntf:  ISafeguardSynthesisDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {F9B3E8EF-07FC-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  ISafeguardSynthesisDisp = dispinterface
    ['{F9B3E8EF-07FC-11D8-BBF3-0010603BA6C9}']
    property EquipmentVariants: IDMCollection readonly dispid 1;
    property EquipmentElements: IDMCollection readonly dispid 2;
    property FacilityModel: IDataModel dispid 3;
    property EtalonModel: IDataModel dispid 4;
    property CurrentEquipmentVariant: IDMElement dispid 5;
    procedure BuildEquipmentVariants; dispid 6;
    property Recomendations: IDMCollection readonly dispid 7;
    property RecomendationVariants: IDMCollection readonly dispid 8;
    property TerminateFlag: WordBool dispid 9;
    procedure Analysis; dispid 10;
  end;

// *********************************************************************//
// Interface: IEquipmentVariant
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F9B3E8F2-07FC-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  IEquipmentVariant = interface(IDispatch)
    ['{F9B3E8F2-07FC-11D8-BBF3-0010603BA6C9}']
    function  Get_RecomendationVariants: IDMCollection; safecall;
    procedure MakePersistantState; safecall;
    function  Get_TotalPrice: Double; safecall;
    procedure Set_TotalPrice(Value: Double); safecall;
    function  Get_TotalEfficiency: Double; safecall;
    procedure Set_TotalEfficiency(Value: Double); safecall;
    procedure Connect; safecall;
    procedure Disconnect; safecall;
    procedure Analysis; safecall;
    property RecomendationVariants: IDMCollection read Get_RecomendationVariants;
    property TotalPrice: Double read Get_TotalPrice write Set_TotalPrice;
    property TotalEfficiency: Double read Get_TotalEfficiency write Set_TotalEfficiency;
  end;

// *********************************************************************//
// DispIntf:  IEquipmentVariantDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F9B3E8F2-07FC-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  IEquipmentVariantDisp = dispinterface
    ['{F9B3E8F2-07FC-11D8-BBF3-0010603BA6C9}']
    property RecomendationVariants: IDMCollection readonly dispid 1;
    procedure MakePersistantState; dispid 4;
    property TotalPrice: Double dispid 5;
    property TotalEfficiency: Double dispid 2;
    procedure Connect; dispid 3;
    procedure Disconnect; dispid 6;
    procedure Analysis; dispid 7;
  end;

// *********************************************************************//
// Interface: IEquipmentElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F9B3E8F4-07FC-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  IEquipmentElement = interface(IDispatch)
    ['{F9B3E8F4-07FC-11D8-BBF3-0010603BA6C9}']
    function  Get_SafeguardElement: IDMElement; safecall;
    procedure Set_SafeguardElement(const Value: IDMElement); safecall;
    procedure MakePersistantState; safecall;
    property SafeguardElement: IDMElement read Get_SafeguardElement write Set_SafeguardElement;
  end;

// *********************************************************************//
// DispIntf:  IEquipmentElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F9B3E8F4-07FC-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  IEquipmentElementDisp = dispinterface
    ['{F9B3E8F4-07FC-11D8-BBF3-0010603BA6C9}']
    property SafeguardElement: IDMElement dispid 4;
    procedure MakePersistantState; dispid 7;
  end;

// *********************************************************************//
// Interface: IRecomendation
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DEDE6D11-0849-11D8-98E1-0050BA51A6D3}
// *********************************************************************//
  IRecomendation = interface(IDispatch)
    ['{DEDE6D11-0849-11D8-98E1-0050BA51A6D3}']
    function  Get_CurrentVariantIndex: Integer; safecall;
    procedure Set_CurrentVariantIndex(Value: Integer); safecall;
    function  Get_Priority: Integer; safecall;
    procedure Set_Priority(Value: Integer); safecall;
    function  Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    function  Get_Price: Double; safecall;
    procedure Set_Price(Value: Double); safecall;
    function  Get_RecomendationVariant(Index: Integer): IDMElement; safecall;
    function  Get_ParentElement: IDMElement; safecall;
    procedure Set_ParentElement(const Value: IDMElement); safecall;
    property CurrentVariantIndex: Integer read Get_CurrentVariantIndex write Set_CurrentVariantIndex;
    property Priority: Integer read Get_Priority write Set_Priority;
    property Kind: Integer read Get_Kind write Set_Kind;
    property Price: Double read Get_Price write Set_Price;
    property RecomendationVariant[Index: Integer]: IDMElement read Get_RecomendationVariant;
    property ParentElement: IDMElement read Get_ParentElement write Set_ParentElement;
  end;

// *********************************************************************//
// DispIntf:  IRecomendationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DEDE6D11-0849-11D8-98E1-0050BA51A6D3}
// *********************************************************************//
  IRecomendationDisp = dispinterface
    ['{DEDE6D11-0849-11D8-98E1-0050BA51A6D3}']
    property CurrentVariantIndex: Integer dispid 1;
    property Priority: Integer dispid 2;
    property Kind: Integer dispid 3;
    property Price: Double dispid 4;
    property RecomendationVariant[Index: Integer]: IDMElement readonly dispid 5;
    property ParentElement: IDMElement dispid 6;
  end;

// *********************************************************************//
// Interface: IRecomendationVariant
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7925B300-0BF0-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  IRecomendationVariant = interface(IDispatch)
    ['{7925B300-0BF0-11D8-BBF3-0010603BA6C9}']
    function  Get_EquipmentElements: IDMCollection; safecall;
    procedure Connect; safecall;
    procedure Disconnect; safecall;
    property EquipmentElements: IDMCollection read Get_EquipmentElements;
  end;

// *********************************************************************//
// DispIntf:  IRecomendationVariantDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7925B300-0BF0-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  IRecomendationVariantDisp = dispinterface
    ['{7925B300-0BF0-11D8-BBF3-0010603BA6C9}']
    property EquipmentElements: IDMCollection readonly dispid 1;
    procedure Connect; dispid 2;
    procedure Disconnect; dispid 3;
  end;

// *********************************************************************//
// The Class CoSafeguardSynthesis provides a Create and CreateRemote method to          
// create instances of the default interface ISafeguardSynthesis exposed by              
// the CoClass SafeguardSynthesis. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSafeguardSynthesis = class
    class function Create: ISafeguardSynthesis;
    class function CreateRemote(const MachineName: string): ISafeguardSynthesis;
  end;

implementation

uses ComObj;

class function CoSafeguardSynthesis.Create: ISafeguardSynthesis;
begin
  Result := CreateComObject(CLASS_SafeguardSynthesis) as ISafeguardSynthesis;
end;

class function CoSafeguardSynthesis.CreateRemote(const MachineName: string): ISafeguardSynthesis;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SafeguardSynthesis) as ISafeguardSynthesis;
end;

end.
