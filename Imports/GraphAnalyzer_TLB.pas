unit GraphAnalyzer_TLB;

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
// File generated on 21.04.03 17:36:19 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\USERS\VOLKOV\SPRUT3\BIN\GRAPHANALYZER.OCX (1)
// LIBID: {85568600-741E-11D7-9BA0-AE0A5B1DB260}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TGraphAnalyzerX) : Error reading control bitmap
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  GraphAnalyzerMajorVersion = 1;
  GraphAnalyzerMinorVersion = 0;

  LIBID_GraphAnalyzer: TGUID = '{85568600-741E-11D7-9BA0-AE0A5B1DB260}';

  IID_IGraphAnalyzerX: TGUID = '{85568601-741E-11D7-9BA0-AE0A5B1DB260}';
  CLASS_GraphAnalyzerX: TGUID = '{85568605-741E-11D7-9BA0-AE0A5B1DB260}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IGraphAnalyzerX = interface;
  IGraphAnalyzerXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  GraphAnalyzerX = IGraphAnalyzerX;


// *********************************************************************//
// Interface: IGraphAnalyzerX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {85568601-741E-11D7-9BA0-AE0A5B1DB260}
// *********************************************************************//
  IGraphAnalyzerX = interface(IDispatch)
    ['{85568601-741E-11D7-9BA0-AE0A5B1DB260}']
  end;

// *********************************************************************//
// DispIntf:  IGraphAnalyzerXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {85568601-741E-11D7-9BA0-AE0A5B1DB260}
// *********************************************************************//
  IGraphAnalyzerXDisp = dispinterface
    ['{85568601-741E-11D7-9BA0-AE0A5B1DB260}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TGraphAnalyzerX
// Help String      : 
// Default Interface: IGraphAnalyzerX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TGraphAnalyzerX = class(TOleControl)
  private
    FIntf: IGraphAnalyzerX;
    function  GetControlInterface: IGraphAnalyzerX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IGraphAnalyzerX read GetControlInterface;
    property  DefaultInterface: IGraphAnalyzerX read GetControlInterface;
  published
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TGraphAnalyzerX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{85568605-741E-11D7-9BA0-AE0A5B1DB260}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TGraphAnalyzerX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IGraphAnalyzerX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TGraphAnalyzerX.GetControlInterface: IGraphAnalyzerX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TGraphAnalyzerX]);
end;

end.
