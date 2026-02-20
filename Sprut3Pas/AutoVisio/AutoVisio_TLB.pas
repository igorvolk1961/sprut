unit AutoVisio_TLB;

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
// File generated on 02.10.2007 13:11:05 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\Sprut3\Sprut3Pas\AutoVisio\AutoVisio.tlb (1)
// LIBID: {D8E50A80-CA28-11D6-A355-000347704B63}
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
  AutoVisioMajorVersion = 1;
  AutoVisioMinorVersion = 0;

  LIBID_AutoVisio: TGUID = '{D8E50A80-CA28-11D6-A355-000347704B63}';

  IID_IVisioExport: TGUID = '{D8E50A87-CA28-11D6-A355-000347704B63}';
  CLASS_VisioExport: TGUID = '{3383E3C8-CA34-11D6-A355-000347704B63}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IVisioExport = interface;
  IVisioExportDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  VisioExport = IVisioExport;


// *********************************************************************//
// Interface: IVisioExport
// Flags:     (320) Dual OleAutomation
// GUID:      {D8E50A87-CA28-11D6-A355-000347704B63}
// *********************************************************************//
  IVisioExport = interface(IUnknown)
    ['{D8E50A87-CA28-11D6-A355-000347704B63}']
    function Get_SpatialModel: IUnknown; safecall;
    procedure Set_SpatialModel(const Value: IUnknown); safecall;
    procedure SaveToFile(const FileName: WideString); safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(Value: Integer); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(Value: Integer); safecall;
    function Get_Form: Integer; safecall;
    procedure Set_Form(Value: Integer); safecall;
    property SpatialModel: IUnknown read Get_SpatialModel write Set_SpatialModel;
    property Height: Integer read Get_Height write Set_Height;
    property Width: Integer read Get_Width write Set_Width;
    property Form: Integer read Get_Form write Set_Form;
  end;

// *********************************************************************//
// DispIntf:  IVisioExportDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {D8E50A87-CA28-11D6-A355-000347704B63}
// *********************************************************************//
  IVisioExportDisp = dispinterface
    ['{D8E50A87-CA28-11D6-A355-000347704B63}']
    property SpatialModel: IUnknown dispid 1;
    procedure SaveToFile(const FileName: WideString); dispid 2;
    property Height: Integer dispid 3;
    property Width: Integer dispid 5;
    property Form: Integer dispid 6;
  end;

// *********************************************************************//
// The Class CoVisioExport provides a Create and CreateRemote method to          
// create instances of the default interface IVisioExport exposed by              
// the CoClass VisioExport. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVisioExport = class
    class function Create: IVisioExport;
    class function CreateRemote(const MachineName: string): IVisioExport;
  end;

implementation

uses ComObj;

class function CoVisioExport.Create: IVisioExport;
begin
  Result := CreateComObject(CLASS_VisioExport) as IVisioExport;
end;

class function CoVisioExport.CreateRemote(const MachineName: string): IVisioExport;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VisioExport) as IVisioExport;
end;

end.
