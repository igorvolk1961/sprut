unit SectorBuilderLib_TLB;

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
// File generated on 02.10.2007 13:10:54 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\Sprut3\Sprut3Pas\SectorBuilder\SectorBuilderLib.tlb (1)
// LIBID: {8F475681-01D7-11D7-97B7-0050BA51A6D3}
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
  SectorBuilderLibMajorVersion = 1;
  SectorBuilderLibMinorVersion = 0;

  LIBID_SectorBuilderLib: TGUID = '{8F475681-01D7-11D7-97B7-0050BA51A6D3}';

  IID_ISectorBuilder: TGUID = '{8F475682-01D7-11D7-97B7-0050BA51A6D3}';
  CLASS_SectorBuilder: TGUID = '{8F475684-01D7-11D7-97B7-0050BA51A6D3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISectorBuilder = interface;
  ISectorBuilderDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SectorBuilder = ISectorBuilder;


// *********************************************************************//
// Interface: ISectorBuilder
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8F475682-01D7-11D7-97B7-0050BA51A6D3}
// *********************************************************************//
  ISectorBuilder = interface(IDispatch)
    ['{8F475682-01D7-11D7-97B7-0050BA51A6D3}']
    function Get_FacilityModel: IUnknown; safecall;
    procedure Set_FacilityModel(const Value: IUnknown); safecall;
    procedure BuildSectors; safecall;
    property FacilityModel: IUnknown read Get_FacilityModel write Set_FacilityModel;
  end;

// *********************************************************************//
// DispIntf:  ISectorBuilderDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8F475682-01D7-11D7-97B7-0050BA51A6D3}
// *********************************************************************//
  ISectorBuilderDisp = dispinterface
    ['{8F475682-01D7-11D7-97B7-0050BA51A6D3}']
    property FacilityModel: IUnknown dispid 1;
    procedure BuildSectors; dispid 2;
  end;

// *********************************************************************//
// The Class CoSectorBuilder provides a Create and CreateRemote method to          
// create instances of the default interface ISectorBuilder exposed by              
// the CoClass SectorBuilder. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSectorBuilder = class
    class function Create: ISectorBuilder;
    class function CreateRemote(const MachineName: string): ISectorBuilder;
  end;

implementation

uses ComObj;

class function CoSectorBuilder.Create: ISectorBuilder;
begin
  Result := CreateComObject(CLASS_SectorBuilder) as ISectorBuilder;
end;

class function CoSectorBuilder.CreateRemote(const MachineName: string): ISectorBuilder;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SectorBuilder) as ISectorBuilder;
end;

end.
