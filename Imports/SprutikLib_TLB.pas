unit SprutikLib_TLB;

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
// File generated on 31.10.2005 17:29:55 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Volkov\Projects\Sprutik\bin\SprutikLib.dll (1)
// LIBID: {0D418640-AFE4-11D8-99A7-0050BA51A6D3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SprutikLibMajorVersion = 1;
  SprutikLibMinorVersion = 0;

  LIBID_SprutikLib: TGUID = '{0D418640-AFE4-11D8-99A7-0050BA51A6D3}';

  IID_ISprutik: TGUID = '{0D41864E-AFE4-11D8-99A7-0050BA51A6D3}';
  IID_IBoundary: TGUID = '{0D418646-AFE4-11D8-99A7-0050BA51A6D3}';
  CLASS_Sprutik: TGUID = '{0D418643-AFE4-11D8-99A7-0050BA51A6D3}';
  IID_ICalcVariant: TGUID = '{7E658263-B51E-11D8-99AC-0050BA51A6D3}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TSprutikConst
type
  TSprutikConst = TOleEnum;
const
  _CalcVariant = $00000000;
  _Boundary = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISprutik = interface;
  ISprutikDisp = dispinterface;
  IBoundary = interface;
  IBoundaryDisp = dispinterface;
  ICalcVariant = interface;
  ICalcVariantDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Sprutik = ISprutik;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PDouble1 = ^Double; {*}


// *********************************************************************//
// Interface: ISprutik
// Flags:     (320) Dual OleAutomation
// GUID:      {0D41864E-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  ISprutik = interface(IUnknown)
    ['{0D41864E-AFE4-11D8-99A7-0050BA51A6D3}']
    procedure Calc; safecall;
  end;

// *********************************************************************//
// DispIntf:  ISprutikDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {0D41864E-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  ISprutikDisp = dispinterface
    ['{0D41864E-AFE4-11D8-99A7-0050BA51A6D3}']
    procedure Calc; dispid 1;
  end;

// *********************************************************************//
// Interface: IBoundary
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0D418646-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  IBoundary = interface(IDispatch)
    ['{0D418646-AFE4-11D8-99A7-0050BA51A6D3}']
    function Get_DelayTime: Double; safecall;
    function Get_DelayTimeDev: Double; safecall;
    function Get_DetectionPeriod: Double; safecall;
    function Get_DetectionProbability: Double; safecall;
    function Get_NoDetP: Double; safecall;
    procedure Set_NoDetP(Value: Double); safecall;
    function Get_OutstripP: Double; safecall;
    procedure Set_OutstripP(Value: Double); safecall;
    procedure CalcSuccessP(var SuccessP: Double; var DelayTimeSum: Double; 
                           var DelayTimeDispersionSum: Double; ReactionTime: Double; 
                           ReactionTimeDispersion: Double); safecall;
    function Get_DetectionPosition: Integer; safecall;
    property DelayTime: Double read Get_DelayTime;
    property DelayTimeDev: Double read Get_DelayTimeDev;
    property DetectionPeriod: Double read Get_DetectionPeriod;
    property DetectionProbability: Double read Get_DetectionProbability;
    property NoDetP: Double read Get_NoDetP write Set_NoDetP;
    property OutstripP: Double read Get_OutstripP write Set_OutstripP;
    property DetectionPosition: Integer read Get_DetectionPosition;
  end;

// *********************************************************************//
// DispIntf:  IBoundaryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0D418646-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  IBoundaryDisp = dispinterface
    ['{0D418646-AFE4-11D8-99A7-0050BA51A6D3}']
    property DelayTime: Double readonly dispid 1;
    property DelayTimeDev: Double readonly dispid 2;
    property DetectionPeriod: Double readonly dispid 5;
    property DetectionProbability: Double readonly dispid 6;
    property NoDetP: Double dispid 7;
    property OutstripP: Double dispid 8;
    procedure CalcSuccessP(var SuccessP: Double; var DelayTimeSum: Double; 
                           var DelayTimeDispersionSum: Double; ReactionTime: Double; 
                           ReactionTimeDispersion: Double); dispid 11;
    property DetectionPosition: Integer readonly dispid 3;
  end;

// *********************************************************************//
// Interface: ICalcVariant
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7E658263-B51E-11D8-99AC-0050BA51A6D3}
// *********************************************************************//
  ICalcVariant = interface(IDispatch)
    ['{7E658263-B51E-11D8-99AC-0050BA51A6D3}']
    function Get_ReactionTime: Double; safecall;
    function Get_ReactionTimeDev: Double; safecall;
    function Get_SuccessP: Double; safecall;
    procedure Set_SuccessP(Value: Double); safecall;
    function Get_Efficiency: Double; safecall;
    procedure Set_Efficiency(Value: Double); safecall;
    procedure Calc; safecall;
    function Get_BoundariesU: IUnknown; safecall;
    property ReactionTime: Double read Get_ReactionTime;
    property ReactionTimeDev: Double read Get_ReactionTimeDev;
    property SuccessP: Double read Get_SuccessP write Set_SuccessP;
    property Efficiency: Double read Get_Efficiency write Set_Efficiency;
    property BoundariesU: IUnknown read Get_BoundariesU;
  end;

// *********************************************************************//
// DispIntf:  ICalcVariantDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7E658263-B51E-11D8-99AC-0050BA51A6D3}
// *********************************************************************//
  ICalcVariantDisp = dispinterface
    ['{7E658263-B51E-11D8-99AC-0050BA51A6D3}']
    property ReactionTime: Double readonly dispid 1;
    property ReactionTimeDev: Double readonly dispid 2;
    property SuccessP: Double dispid 3;
    property Efficiency: Double dispid 4;
    procedure Calc; dispid 5;
    property BoundariesU: IUnknown readonly dispid 6;
  end;

// *********************************************************************//
// The Class CoSprutik provides a Create and CreateRemote method to          
// create instances of the default interface ISprutik exposed by              
// the CoClass Sprutik. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSprutik = class
    class function Create: ISprutik;
    class function CreateRemote(const MachineName: string): ISprutik;
  end;

implementation

uses ComObj;

class function CoSprutik.Create: ISprutik;
begin
  Result := CreateComObject(CLASS_Sprutik) as ISprutik;
end;

class function CoSprutik.CreateRemote(const MachineName: string): ISprutik;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Sprutik) as ISprutik;
end;

end.
