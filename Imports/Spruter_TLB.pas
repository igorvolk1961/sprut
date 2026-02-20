unit Spruter_TLB;

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
// File generated on 07.10.02 1:40:45 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\USERS\VOLKOV\SPRUT3\BIN\SPRUTER.EXE (1)
// LIBID: {A94DCB31-CEBF-11D6-9773-0050BA51A6D3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses ActiveX, Classes, Graphics, OleServer, StdVCL, Variants, Windows;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SpruterMajorVersion = 1;
  SpruterMinorVersion = 0;

  LIBID_Spruter: TGUID = '{A94DCB31-CEBF-11D6-9773-0050BA51A6D3}';

  IID_ISpruterApp: TGUID = '{A94DCB32-CEBF-11D6-9773-0050BA51A6D3}';
  CLASS_SpruterApp: TGUID = '{A94DCB34-CEBF-11D6-9773-0050BA51A6D3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISpruterApp = interface;
  ISpruterAppDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SpruterApp = ISpruterApp;


// *********************************************************************//
// Interface: ISpruterApp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A94DCB32-CEBF-11D6-9773-0050BA51A6D3}
// *********************************************************************//
  ISpruterApp = interface(IDispatch)
    ['{A94DCB32-CEBF-11D6-9773-0050BA51A6D3}']
    function  Get_DMEditorX: IUnknown; safecall;
    property DMEditorX: IUnknown read Get_DMEditorX;
  end;

// *********************************************************************//
// DispIntf:  ISpruterAppDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A94DCB32-CEBF-11D6-9773-0050BA51A6D3}
// *********************************************************************//
  ISpruterAppDisp = dispinterface
    ['{A94DCB32-CEBF-11D6-9773-0050BA51A6D3}']
    property DMEditorX: IUnknown readonly dispid 4;
  end;

// *********************************************************************//
// The Class CoSpruterApp provides a Create and CreateRemote method to          
// create instances of the default interface ISpruterApp exposed by              
// the CoClass SpruterApp. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSpruterApp = class
    class function Create: ISpruterApp;
    class function CreateRemote(const MachineName: string): ISpruterApp;
  end;

implementation

uses ComObj;

class function CoSpruterApp.Create: ISpruterApp;
begin
  Result := CreateComObject(CLASS_SpruterApp) as ISpruterApp;
end;

class function CoSpruterApp.CreateRemote(const MachineName: string): ISpruterApp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SpruterApp) as ISpruterApp;
end;

end.
