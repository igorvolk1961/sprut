unit AutoCadExp_TLB;

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
// File generated on 23.09.2005 17:55:56 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Volkov\Sprut3\bin\AutoCadExp.dll (1)
// LIBID: {3863D59D-CED5-4412-9B84-329AC2AB0BB0}
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
  AutoCadExpMajorVersion = 1;
  AutoCadExpMinorVersion = 0;

  LIBID_AutoCadExp: TGUID = '{3863D59D-CED5-4412-9B84-329AC2AB0BB0}';

  IID_IAutoCadExport: TGUID = '{F5408B93-3BF1-4122-AE03-35F1026A2AF2}';
  CLASS_AutoCadExport: TGUID = '{21446030-6065-4878-88A4-406F4BE63611}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IAutoCadExport = interface;
  IAutoCadExportDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AutoCadExport = IAutoCadExport;


// *********************************************************************//
// Interface: IAutoCadExport
// Flags:     (320) Dual OleAutomation
// GUID:      {F5408B93-3BF1-4122-AE03-35F1026A2AF2}
// *********************************************************************//
  IAutoCadExport = interface(IUnknown)
    ['{F5408B93-3BF1-4122-AE03-35F1026A2AF2}']
    function Get_SpatialModel: IUnknown; safecall;
    procedure Set_SpatialModel(const Value: IUnknown); safecall;
    procedure SaveToFile(const FileName: WideString); safecall;
    property SpatialModel: IUnknown read Get_SpatialModel write Set_SpatialModel;
  end;

// *********************************************************************//
// DispIntf:  IAutoCadExportDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {F5408B93-3BF1-4122-AE03-35F1026A2AF2}
// *********************************************************************//
  IAutoCadExportDisp = dispinterface
    ['{F5408B93-3BF1-4122-AE03-35F1026A2AF2}']
    property SpatialModel: IUnknown dispid 1;
    procedure SaveToFile(const FileName: WideString); dispid 2;
  end;

// *********************************************************************//
// The Class CoAutoCadExport provides a Create and CreateRemote method to          
// create instances of the default interface IAutoCadExport exposed by              
// the CoClass AutoCadExport. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAutoCadExport = class
    class function Create: IAutoCadExport;
    class function CreateRemote(const MachineName: string): IAutoCadExport;
  end;

implementation

uses ComObj;

class function CoAutoCadExport.Create: IAutoCadExport;
begin
  Result := CreateComObject(CLASS_AutoCadExport) as IAutoCadExport;
end;

class function CoAutoCadExport.CreateRemote(const MachineName: string): IAutoCadExport;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AutoCadExport) as IAutoCadExport;
end;

end.
