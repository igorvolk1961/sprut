unit SprutikAnalysisLib_TLB;

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
// File generated on 31.10.2005 17:29:33 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Volkov\Projects\Sprutik\bin\SprutikAnalysisLib.dll (1)
// LIBID: {0D418649-AFE4-11D8-99A7-0050BA51A6D3}
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
  SprutikAnalysisLibMajorVersion = 1;
  SprutikAnalysisLibMinorVersion = 0;

  LIBID_SprutikAnalysisLib: TGUID = '{0D418649-AFE4-11D8-99A7-0050BA51A6D3}';

  IID_ISprutikAnalysis: TGUID = '{0D41864A-AFE4-11D8-99A7-0050BA51A6D3}';
  CLASS_SprutikAnalysis: TGUID = '{0D41864C-AFE4-11D8-99A7-0050BA51A6D3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISprutikAnalysis = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SprutikAnalysis = ISprutikAnalysis;


// *********************************************************************//
// Interface: ISprutikAnalysis
// Flags:     (256) OleAutomation
// GUID:      {0D41864A-AFE4-11D8-99A7-0050BA51A6D3}
// *********************************************************************//
  ISprutikAnalysis = interface(IUnknown)
    ['{0D41864A-AFE4-11D8-99A7-0050BA51A6D3}']
  end;

// *********************************************************************//
// The Class CoSprutikAnalysis provides a Create and CreateRemote method to          
// create instances of the default interface ISprutikAnalysis exposed by              
// the CoClass SprutikAnalysis. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSprutikAnalysis = class
    class function Create: ISprutikAnalysis;
    class function CreateRemote(const MachineName: string): ISprutikAnalysis;
  end;

implementation

uses ComObj;

class function CoSprutikAnalysis.Create: ISprutikAnalysis;
begin
  Result := CreateComObject(CLASS_SprutikAnalysis) as ISprutikAnalysis;
end;

class function CoSprutikAnalysis.CreateRemote(const MachineName: string): ISprutikAnalysis;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SprutikAnalysis) as ISprutikAnalysis;
end;

end.
