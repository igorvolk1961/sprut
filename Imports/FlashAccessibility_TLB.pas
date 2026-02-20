unit FlashAccessibility_TLB;

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
// File generated on 02.03.05 13:07:26 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\WINNT\System32\macromed\flash\Flash.ocx\2 (1)
// LIBID: {57A0E746-3863-4D20-A811-950C84F1DB9B}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
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
  FlashAccessibilityMajorVersion = 1;
  FlashAccessibilityMinorVersion = 0;

  LIBID_FlashAccessibility: TGUID = '{57A0E746-3863-4D20-A811-950C84F1DB9B}';

  IID_IFlashAccessibility: TGUID = '{57A0E747-3863-4D20-A811-950C84F1DB9B}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFlashAccessibility = interface;
  IFlashAccessibilityDisp = dispinterface;

// *********************************************************************//
// Interface: IFlashAccessibility
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {57A0E747-3863-4D20-A811-950C84F1DB9B}
// *********************************************************************//
  IFlashAccessibility = interface(IDispatch)
    ['{57A0E747-3863-4D20-A811-950C84F1DB9B}']
    procedure SuppressInessentialEvents; safecall;
    procedure CopyDescriptionIntoName; safecall;
    procedure HaltEvents; safecall;
    procedure ResumeEvents; safecall;
    procedure HaltEvents_ProcessScope; safecall;
    procedure ResumeEvents_ProcessScope; safecall;
    function GetFlashAX: IDispatch; safecall;
  end;

// *********************************************************************//
// DispIntf:  IFlashAccessibilityDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {57A0E747-3863-4D20-A811-950C84F1DB9B}
// *********************************************************************//
  IFlashAccessibilityDisp = dispinterface
    ['{57A0E747-3863-4D20-A811-950C84F1DB9B}']
    procedure SuppressInessentialEvents; dispid 1001;
    procedure CopyDescriptionIntoName; dispid 1002;
    procedure HaltEvents; dispid 1003;
    procedure ResumeEvents; dispid 1004;
    procedure HaltEvents_ProcessScope; dispid 1005;
    procedure ResumeEvents_ProcessScope; dispid 1006;
    function GetFlashAX: IDispatch; dispid 1007;
  end;

implementation

uses ComObj;

end.
