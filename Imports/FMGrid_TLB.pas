unit FMGrid_TLB;

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
// File generated on 03.04.05 0:13:00 from Type Library described below.

// ************************************************************************  //
// Type Lib: G:\USERS\VOLKOV\SPRUT3\BIN\FMGRID.OCX (1)
// LIBID: {B3E86C90-FD28-4267-959F-952A4B380798}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
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
  FMGridMajorVersion = 1;
  FMGridMinorVersion = 0;

  LIBID_FMGrid: TGUID = '{B3E86C90-FD28-4267-959F-952A4B380798}';

  IID_IFMGridX: TGUID = '{EB32BCC0-B478-406A-BE17-E04648F10A7C}';
  CLASS_FMGridX: TGUID = '{0C3874C4-1BA4-46FC-A397-4B5CD97C333B}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFMGridX = interface;
  IFMGridXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FMGridX = IFMGridX;


// *********************************************************************//
// Interface: IFMGridX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EB32BCC0-B478-406A-BE17-E04648F10A7C}
// *********************************************************************//
  IFMGridX = interface(IDispatch)
    ['{EB32BCC0-B478-406A-BE17-E04648F10A7C}']
  end;

// *********************************************************************//
// DispIntf:  IFMGridXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EB32BCC0-B478-406A-BE17-E04648F10A7C}
// *********************************************************************//
  IFMGridXDisp = dispinterface
    ['{EB32BCC0-B478-406A-BE17-E04648F10A7C}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TFMGridX
// Help String      : 
// Default Interface: IFMGridX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TFMGridX = class(TOleControl)
  private
    FIntf: IFMGridX;
    function  GetControlInterface: IFMGridX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IFMGridX read GetControlInterface;
    property  DefaultInterface: IFMGridX read GetControlInterface;
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

procedure TFMGridX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{0C3874C4-1BA4-46FC-A397-4B5CD97C333B}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TFMGridX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IFMGridX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TFMGridX.GetControlInterface: IFMGridX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TFMGridX]);
end;

end.
