unit DCOMPayDoxServer_TLB;

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

// PASTLWTR : 1.2
// File generated on 09.06.2005 10:48:51 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Documents and Settings\ashemis\Desktop\test\DCOMPayDoxServer\DCOMPayDoxServer.tlb (1)
// LIBID: {8236DE5D-A233-430B-8734-70F2FF8BC32D}
// LCID: 0
// Helpfile: 
// HelpString: DCOMPayDoxServer Library
// DepndLst: 
//   (1) v2.0 stdole, (D:\WINNT\system32\STDOLE2.TLB)
// Errors:
//   Hint: TypeInfo 'DCOMPayDoxServer' changed to 'DCOMPayDoxServer_'
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
  DCOMPayDoxServerMajorVersion = 1;
  DCOMPayDoxServerMinorVersion = 0;

  LIBID_DCOMPayDoxServer: TGUID = '{8236DE5D-A233-430B-8734-70F2FF8BC32D}';

  IID_IDCOMPayDoxServer: TGUID = '{E282895E-95AB-454B-AEDC-6DB85899C53D}';
  CLASS_DCOMPayDoxServer_: TGUID = '{25C817A1-868F-4EA5-BF3B-D5BFE25B2967}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDCOMPayDoxServer = interface;
  IDCOMPayDoxServerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DCOMPayDoxServer_ = IDCOMPayDoxServer;


// *********************************************************************//
// Interface: IDCOMPayDoxServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E282895E-95AB-454B-AEDC-6DB85899C53D}
// *********************************************************************//
  IDCOMPayDoxServer = interface(IDispatch)
    ['{E282895E-95AB-454B-AEDC-6DB85899C53D}']
    function AreYouThere: WordBool; safecall;
    function ConnectToPayDox: WordBool; safecall;
    procedure SendNotification; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDCOMPayDoxServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E282895E-95AB-454B-AEDC-6DB85899C53D}
// *********************************************************************//
  IDCOMPayDoxServerDisp = dispinterface
    ['{E282895E-95AB-454B-AEDC-6DB85899C53D}']
    function AreYouThere: WordBool; dispid 201;
    function ConnectToPayDox: WordBool; dispid 202;
    procedure SendNotification; dispid 203;
  end;

// *********************************************************************//
// The Class CoDCOMPayDoxServer_ provides a Create and CreateRemote method to          
// create instances of the default interface IDCOMPayDoxServer exposed by              
// the CoClass DCOMPayDoxServer_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDCOMPayDoxServer_ = class
    class function Create: IDCOMPayDoxServer;
    class function CreateRemote(const MachineName: string): IDCOMPayDoxServer;
  end;

implementation

uses ComObj;

class function CoDCOMPayDoxServer_.Create: IDCOMPayDoxServer;
begin
  Result := CreateComObject(CLASS_DCOMPayDoxServer_) as IDCOMPayDoxServer;
end;

class function CoDCOMPayDoxServer_.CreateRemote(const MachineName: string): IDCOMPayDoxServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DCOMPayDoxServer_) as IDCOMPayDoxServer;
end;

end.
