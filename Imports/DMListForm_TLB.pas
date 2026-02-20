unit DMListForm_TLB;

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
// File generated on 25.09.03 18:52:10 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\USERS\VOLKOV\AUTODM\BIN\DMLISTFORM.OCX (1)
// LIBID: {28339802-66F9-11D6-93C4-0050BA51A4A4}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TDMListFormX) : Error reading control bitmap
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
  DMListFormMajorVersion = 1;
  DMListFormMinorVersion = 0;

  LIBID_DMListForm: TGUID = '{28339802-66F9-11D6-93C4-0050BA51A4A4}';

  IID_IDMListFormX: TGUID = '{87548200-6742-11D6-93C4-0050BA51A4A4}';
  CLASS_DMListFormX: TGUID = '{87548203-6742-11D6-93C4-0050BA51A4A4}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMListFormX = interface;
  IDMListFormXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMListFormX = IDMListFormX;


// *********************************************************************//
// Interface: IDMListFormX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {87548200-6742-11D6-93C4-0050BA51A4A4}
// *********************************************************************//
  IDMListFormX = interface(IDispatch)
    ['{87548200-6742-11D6-93C4-0050BA51A4A4}']
    procedure SetState(ClassIndex: Integer; SubKindIndex: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMListFormXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {87548200-6742-11D6-93C4-0050BA51A4A4}
// *********************************************************************//
  IDMListFormXDisp = dispinterface
    ['{87548200-6742-11D6-93C4-0050BA51A4A4}']
    procedure SetState(ClassIndex: Integer; SubKindIndex: Integer); dispid 1;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDMListFormX
// Help String      : 
// Default Interface: IDMListFormX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TDMListFormX = class(TOleControl)
  private
    FIntf: IDMListFormX;
    function  GetControlInterface: IDMListFormX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SetState(ClassIndex: Integer; SubKindIndex: Integer);
    property  ControlInterface: IDMListFormX read GetControlInterface;
    property  DefaultInterface: IDMListFormX read GetControlInterface;
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

procedure TDMListFormX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{87548203-6742-11D6-93C4-0050BA51A4A4}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDMListFormX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDMListFormX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDMListFormX.GetControlInterface: IDMListFormX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TDMListFormX.SetState(ClassIndex: Integer; SubKindIndex: Integer);
begin
  DefaultInterface.SetState(ClassIndex, SubKindIndex);
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDMListFormX]);
end;

end.
