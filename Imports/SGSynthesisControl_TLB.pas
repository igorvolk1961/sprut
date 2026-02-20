unit SGSynthesisControl_TLB;

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
// File generated on 26.10.03 22:58:25 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\USERS\VOLKOV\SPRUT3\BIN\SGSYNTHESISCONTROL.OCX (1)
// LIBID: {F9B3E8F8-07FC-11D8-BBF3-0010603BA6C9}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TSGSynthesisControlX) : Error reading control bitmap
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
  SGSynthesisControlMajorVersion = 1;
  SGSynthesisControlMinorVersion = 0;

  LIBID_SGSynthesisControl: TGUID = '{F9B3E8F8-07FC-11D8-BBF3-0010603BA6C9}';

  IID_ISGSynthesisControlX: TGUID = '{F9B3E8F9-07FC-11D8-BBF3-0010603BA6C9}';
  CLASS_SGSynthesisControlX: TGUID = '{F9B3E8FB-07FC-11D8-BBF3-0010603BA6C9}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISGSynthesisControlX = interface;
  ISGSynthesisControlXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SGSynthesisControlX = ISGSynthesisControlX;


// *********************************************************************//
// Interface: ISGSynthesisControlX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F9B3E8F9-07FC-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  ISGSynthesisControlX = interface(IDispatch)
    ['{F9B3E8F9-07FC-11D8-BBF3-0010603BA6C9}']
    function  Get_SafeguardSynthesis: IUnknown; safecall;
    procedure Set_SafeguardSynthesis(const Value: IUnknown); safecall;
    property SafeguardSynthesis: IUnknown read Get_SafeguardSynthesis write Set_SafeguardSynthesis;
  end;

// *********************************************************************//
// DispIntf:  ISGSynthesisControlXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F9B3E8F9-07FC-11D8-BBF3-0010603BA6C9}
// *********************************************************************//
  ISGSynthesisControlXDisp = dispinterface
    ['{F9B3E8F9-07FC-11D8-BBF3-0010603BA6C9}']
    property SafeguardSynthesis: IUnknown dispid 1;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TSGSynthesisControlX
// Help String      : SGSynthesisControlX Control
// Default Interface: ISGSynthesisControlX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TSGSynthesisControlX = class(TOleControl)
  private
    FIntf: ISGSynthesisControlX;
    function  GetControlInterface: ISGSynthesisControlX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function  Get_SafeguardSynthesis: IUnknown;
    procedure Set_SafeguardSynthesis(const Value: IUnknown);
  public
    property  ControlInterface: ISGSynthesisControlX read GetControlInterface;
    property  DefaultInterface: ISGSynthesisControlX read GetControlInterface;
    property SafeguardSynthesis: IUnknown index 1 read GetIUnknownProp write SetIUnknownProp;
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

procedure TSGSynthesisControlX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{F9B3E8FB-07FC-11D8-BBF3-0010603BA6C9}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TSGSynthesisControlX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as ISGSynthesisControlX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TSGSynthesisControlX.GetControlInterface: ISGSynthesisControlX;
begin
  CreateControl;
  Result := FIntf;
end;

function  TSGSynthesisControlX.Get_SafeguardSynthesis: IUnknown;
begin
  Result := DefaultInterface.SafeguardSynthesis;
end;

procedure TSGSynthesisControlX.Set_SafeguardSynthesis(const Value: IUnknown);
begin
  DefaultInterface.SafeguardSynthesis := Value;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TSGSynthesisControlX]);
end;

end.
