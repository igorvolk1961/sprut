unit PriceControl_TLB;

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

// PASTLWTR : $Revision:   1.130  $
// File generated on 26.06.03 13:31:35 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\USERS\Volkov\Sprut3\bin\PriceControl.ocx (1)
// LIBID: {89603401-4890-11D7-B289-0050BA51DB91}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TPriceControlX) : Error reading control bitmap
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants, 
Windows;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  PriceControlMajorVersion = 1;
  PriceControlMinorVersion = 0;

  LIBID_PriceControl: TGUID = '{89603401-4890-11D7-B289-0050BA51DB91}';

  IID_IPriceControlX: TGUID = '{89603402-4890-11D7-B289-0050BA51DB91}';
  CLASS_PriceControlX: TGUID = '{89603404-4890-11D7-B289-0050BA51DB91}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IPriceControlX = interface;
  IPriceControlXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  PriceControlX = IPriceControlX;


// *********************************************************************//
// Interface: IPriceControlX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {89603402-4890-11D7-B289-0050BA51DB91}
// *********************************************************************//
  IPriceControlX = interface(IDispatch)
    ['{89603402-4890-11D7-B289-0050BA51DB91}']
  end;

// *********************************************************************//
// DispIntf:  IPriceControlXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {89603402-4890-11D7-B289-0050BA51DB91}
// *********************************************************************//
  IPriceControlXDisp = dispinterface
    ['{89603402-4890-11D7-B289-0050BA51DB91}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TPriceControlX
// Help String      : PriceControlX Control
// Default Interface: IPriceControlX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TPriceControlX = class(TOleControl)
  private
    FIntf: IPriceControlX;
    function  GetControlInterface: IPriceControlX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IPriceControlX read GetControlInterface;
    property  DefaultInterface: IPriceControlX read GetControlInterface;
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

procedure TPriceControlX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{89603404-4890-11D7-B289-0050BA51DB91}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TPriceControlX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IPriceControlX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TPriceControlX.GetControlInterface: IPriceControlX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TPriceControlX]);
end;

end.
