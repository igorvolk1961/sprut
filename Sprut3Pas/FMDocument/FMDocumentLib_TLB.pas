unit FMDocumentLib_TLB;

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
// File generated on 02.10.2007 13:10:28 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\Sprut3\Sprut3Pas\FMDocument\FMDocumentLib.tlb (1)
// LIBID: {15B14D70-7F11-4C3C-B61F-F1D46EE5328D}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
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
  FMDocumentLibMajorVersion = 1;
  FMDocumentLibMinorVersion = 0;

  LIBID_FMDocumentLib: TGUID = '{15B14D70-7F11-4C3C-B61F-F1D46EE5328D}';

  IID_IFMDocument: TGUID = '{F38AAA68-3925-4B51-B41D-8111C1EA82FA}';
  CLASS_FMDocument: TGUID = '{CD03FC56-20EE-438A-ACEA-C9C279D4ADDE}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFMDocument = interface;
  IFMDocumentDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FMDocument = IFMDocument;


// *********************************************************************//
// Interface: IFMDocument
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F38AAA68-3925-4B51-B41D-8111C1EA82FA}
// *********************************************************************//
  IFMDocument = interface(IDispatch)
    ['{F38AAA68-3925-4B51-B41D-8111C1EA82FA}']
    procedure BuildPerimeterZone; safecall;
  end;

// *********************************************************************//
// DispIntf:  IFMDocumentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F38AAA68-3925-4B51-B41D-8111C1EA82FA}
// *********************************************************************//
  IFMDocumentDisp = dispinterface
    ['{F38AAA68-3925-4B51-B41D-8111C1EA82FA}']
    procedure BuildPerimeterZone; dispid 1;
  end;

// *********************************************************************//
// The Class CoFMDocument provides a Create and CreateRemote method to          
// create instances of the default interface IFMDocument exposed by              
// the CoClass FMDocument. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFMDocument = class
    class function Create: IFMDocument;
    class function CreateRemote(const MachineName: string): IFMDocument;
  end;

implementation

uses ComObj;

class function CoFMDocument.Create: IFMDocument;
begin
  Result := CreateComObject(CLASS_FMDocument) as IFMDocument;
end;

class function CoFMDocument.CreateRemote(const MachineName: string): IFMDocument;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FMDocument) as IFMDocument;
end;

end.
