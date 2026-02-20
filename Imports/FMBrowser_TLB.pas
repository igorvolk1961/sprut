unit FMBrowser_TLB;

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
// File generated on 04.08.2005 11:17:50 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Volkov\Sprut3\bin\FMBrowser.ocx (1)
// LIBID: {08EF9D01-9C93-4C40-BAF0-8169A4B33325}
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
  FMBrowserMajorVersion = 1;
  FMBrowserMinorVersion = 0;

  LIBID_FMBrowser: TGUID = '{08EF9D01-9C93-4C40-BAF0-8169A4B33325}';

  IID_IFMBrowserX: TGUID = '{5CDF38DA-83C0-4FC0-B3D8-41A8A1B4EB86}';
  CLASS_FMBrowserX: TGUID = '{D6BBE1FF-1647-4777-BF41-0436400FB2F6}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFMBrowserX = interface;
  IFMBrowserXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FMBrowserX = IFMBrowserX;


// *********************************************************************//
// Interface: IFMBrowserX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5CDF38DA-83C0-4FC0-B3D8-41A8A1B4EB86}
// *********************************************************************//
  IFMBrowserX = interface(IDispatch)
    ['{5CDF38DA-83C0-4FC0-B3D8-41A8A1B4EB86}']
  end;

// *********************************************************************//
// DispIntf:  IFMBrowserXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5CDF38DA-83C0-4FC0-B3D8-41A8A1B4EB86}
// *********************************************************************//
  IFMBrowserXDisp = dispinterface
    ['{5CDF38DA-83C0-4FC0-B3D8-41A8A1B4EB86}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TFMBrowserX
// Help String      : FMBrowserX Control
// Default Interface: IFMBrowserX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TFMBrowserX = class(TOleControl)
  private
    FIntf: IFMBrowserX;
    function  GetControlInterface: IFMBrowserX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IFMBrowserX read GetControlInterface;
    property  DefaultInterface: IFMBrowserX read GetControlInterface;
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

procedure TFMBrowserX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{D6BBE1FF-1647-4777-BF41-0436400FB2F6}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TFMBrowserX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IFMBrowserX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TFMBrowserX.GetControlInterface: IFMBrowserX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TFMBrowserX]);
end;

end.
