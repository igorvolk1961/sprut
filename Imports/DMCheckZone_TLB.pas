unit DMCheckZone_TLB;

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
// File generated on 20.08.2002 15:47:02 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Volkov\AutoDM\bin\DMCheckZone.ocx (1)
// LIBID: {9A023281-8431-11D6-972B-0050BA51A6D3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\System32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TDMCheckZoneX) : Error reading control bitmap
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
  DMCheckZoneMajorVersion = 1;
  DMCheckZoneMinorVersion = 0;

  LIBID_DMCheckZone: TGUID = '{9A023281-8431-11D6-972B-0050BA51A6D3}';

  IID_IDMCheckZoneX: TGUID = '{9A023282-8431-11D6-972B-0050BA51A6D3}';
  CLASS_DMCheckZoneX: TGUID = '{9A023284-8431-11D6-972B-0050BA51A6D3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMCheckZoneX = interface;
  IDMCheckZoneXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMCheckZoneX = IDMCheckZoneX;


// *********************************************************************//
// Interface: IDMCheckZoneX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9A023282-8431-11D6-972B-0050BA51A6D3}
// *********************************************************************//
  IDMCheckZoneX = interface(IDispatch)
    ['{9A023282-8431-11D6-972B-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IDMCheckZoneXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9A023282-8431-11D6-972B-0050BA51A6D3}
// *********************************************************************//
  IDMCheckZoneXDisp = dispinterface
    ['{9A023282-8431-11D6-972B-0050BA51A6D3}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDMCheckZoneX
// Help String      : DMCheckZoneX Control
// Default Interface: IDMCheckZoneX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDMCheckZoneX = class(TOleControl)
  private
    FIntf: IDMCheckZoneX;
    function  GetControlInterface: IDMCheckZoneX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IDMCheckZoneX read GetControlInterface;
    property  DefaultInterface: IDMCheckZoneX read GetControlInterface;
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

procedure TDMCheckZoneX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{9A023284-8431-11D6-972B-0050BA51A6D3}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDMCheckZoneX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDMCheckZoneX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDMCheckZoneX.GetControlInterface: IDMCheckZoneX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDMCheckZoneX]);
end;

end.
