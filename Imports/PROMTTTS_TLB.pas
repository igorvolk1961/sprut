unit PROMTTTS_TLB;

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
// File generated on 11.01.04 15:35:47 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\PROGRAM FILES\X-TRANSLATOR PLATINUM\PROMTTTS.DLL (1)
// LIBID: {7680F032-F654-11D2-AFA3-00E0290CC6B9}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
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
  PROMTTTSMajorVersion = 1;
  PROMTTTSMinorVersion = 0;

  LIBID_PROMTTTS: TGUID = '{7680F032-F654-11D2-AFA3-00E0290CC6B9}';

  IID_IPromt5TextToSpeech: TGUID = '{7680F03F-F654-11D2-AFA3-00E0290CC6B9}';
  CLASS_TextToSpeech: TGUID = '{7680F041-F654-11D2-AFA3-00E0290CC6B9}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IPromt5TextToSpeech = interface;
  IPromt5TextToSpeechDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  TextToSpeech = IPromt5TextToSpeech;


// *********************************************************************//
// Interface: IPromt5TextToSpeech
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7680F03F-F654-11D2-AFA3-00E0290CC6B9}
// *********************************************************************//
  IPromt5TextToSpeech = interface(IDispatch)
    ['{7680F03F-F654-11D2-AFA3-00E0290CC6B9}']
    procedure Initialize(Client: OleVariant; ParentRegKey: OleVariant; RegKeyName: OleVariant); safecall;
    procedure Speak(Language: Smallint; const Text: WideString; Tagged: OleVariant; 
                    NotifyInterface: OleVariant); safecall;
    procedure Stop; safecall;
    function IsLanguageAvailable(Language: Smallint): Integer; safecall;
    procedure DlgSetup; safecall;
  end;

// *********************************************************************//
// DispIntf:  IPromt5TextToSpeechDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7680F03F-F654-11D2-AFA3-00E0290CC6B9}
// *********************************************************************//
  IPromt5TextToSpeechDisp = dispinterface
    ['{7680F03F-F654-11D2-AFA3-00E0290CC6B9}']
    procedure Initialize(Client: OleVariant; ParentRegKey: OleVariant; RegKeyName: OleVariant); dispid 1;
    procedure Speak(Language: Smallint; const Text: WideString; Tagged: OleVariant; 
                    NotifyInterface: OleVariant); dispid 2;
    procedure Stop; dispid 3;
    function IsLanguageAvailable(Language: Smallint): Integer; dispid 4;
    procedure DlgSetup; dispid 5;
  end;

// *********************************************************************//
// The Class CoTextToSpeech provides a Create and CreateRemote method to          
// create instances of the default interface IPromt5TextToSpeech exposed by              
// the CoClass TextToSpeech. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTextToSpeech = class
    class function Create: IPromt5TextToSpeech;
    class function CreateRemote(const MachineName: string): IPromt5TextToSpeech;
  end;

implementation

uses ComObj;

class function CoTextToSpeech.Create: IPromt5TextToSpeech;
begin
  Result := CreateComObject(CLASS_TextToSpeech) as IPromt5TextToSpeech;
end;

class function CoTextToSpeech.CreateRemote(const MachineName: string): IPromt5TextToSpeech;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TextToSpeech) as IPromt5TextToSpeech;
end;

end.
