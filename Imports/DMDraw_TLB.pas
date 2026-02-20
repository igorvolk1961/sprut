unit DMDraw_TLB;

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
// File generated on 04.08.2005 11:18:03 from Type Library described below.

// ************************************************************************  //
// Type Lib: c:\Users\Volkov\AutoDM\bin\DMDraw.ocx (1)
// LIBID: {0AEBC068-EE45-11D5-9306-0050BA51A6D3}
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
  DMDrawMajorVersion = 1;
  DMDrawMinorVersion = 0;

  LIBID_DMDraw: TGUID = '{0AEBC068-EE45-11D5-9306-0050BA51A6D3}';

  IID_IDMDrawX: TGUID = '{0AEBC069-EE45-11D5-9306-0050BA51A6D3}';
  CLASS_DMDrawX: TGUID = '{0AEBC06D-EE45-11D5-9306-0050BA51A6D3}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TxMouseButton
type
  TxMouseButton = TOleEnum;
const
  mbLeft = $00000000;
  mbRight = $00000001;
  mbMiddle = $00000002;

// Constants for enum TDrawPopupMenuItem
type
  TDrawPopupMenuItem = TOleEnum;
const
  dmgmiEdit = $00000000;
  dmgmiUp = $00000001;
  dmgmiDown = $00000002;
  dmgmiLeft = $00000003;
  dmgmiRight = $00000004;
  dmgmiShiftUp = $00000005;
  dmgmiShiftDown = $00000006;
  dmgmiShiftLeft = $00000007;
  dmgmiShiftRight = $00000008;
  dmgmiSpace = $00000009;
  dmgmiEscape = $0000000A;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMDrawX = interface;
  IDMDrawXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMDrawX = IDMDrawX;


// *********************************************************************//
// Interface: IDMDrawX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0AEBC069-EE45-11D5-9306-0050BA51A6D3}
// *********************************************************************//
  IDMDrawX = interface(IDispatch)
    ['{0AEBC069-EE45-11D5-9306-0050BA51A6D3}']
    procedure SetPanelRatio(Ratio: Double); safecall;
    procedure SetOptionsPage(const PageName: WideString); safecall;
    procedure SetView(const ViewName: WideString); safecall;
    procedure SetLayer(const LayerName: WideString); safecall;
    procedure SetCentralPoint(X: Double; Y: Double); safecall;
  end;

// *********************************************************************//
// DispIntf:  IDMDrawXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0AEBC069-EE45-11D5-9306-0050BA51A6D3}
// *********************************************************************//
  IDMDrawXDisp = dispinterface
    ['{0AEBC069-EE45-11D5-9306-0050BA51A6D3}']
    procedure SetPanelRatio(Ratio: Double); dispid 1;
    procedure SetOptionsPage(const PageName: WideString); dispid 2;
    procedure SetView(const ViewName: WideString); dispid 3;
    procedure SetLayer(const LayerName: WideString); dispid 4;
    procedure SetCentralPoint(X: Double; Y: Double); dispid 5;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDMDrawX
// Help String      : DMDrawX Control
// Default Interface: IDMDrawX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDMDrawX = class(TOleControl)
  private
    FIntf: IDMDrawX;
    function  GetControlInterface: IDMDrawX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SetPanelRatio(Ratio: Double);
    procedure SetOptionsPage(const PageName: WideString);
    procedure SetView(const ViewName: WideString);
    procedure SetLayer(const LayerName: WideString);
    procedure SetCentralPoint(X: Double; Y: Double);
    property  ControlInterface: IDMDrawX read GetControlInterface;
    property  DefaultInterface: IDMDrawX read GetControlInterface;
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

procedure TDMDrawX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{0AEBC06D-EE45-11D5-9306-0050BA51A6D3}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDMDrawX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDMDrawX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDMDrawX.GetControlInterface: IDMDrawX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TDMDrawX.SetPanelRatio(Ratio: Double);
begin
  DefaultInterface.SetPanelRatio(Ratio);
end;

procedure TDMDrawX.SetOptionsPage(const PageName: WideString);
begin
  DefaultInterface.SetOptionsPage(PageName);
end;

procedure TDMDrawX.SetView(const ViewName: WideString);
begin
  DefaultInterface.SetView(ViewName);
end;

procedure TDMDrawX.SetLayer(const LayerName: WideString);
begin
  DefaultInterface.SetLayer(LayerName);
end;

procedure TDMDrawX.SetCentralPoint(X: Double; Y: Double);
begin
  DefaultInterface.SetCentralPoint(X, Y);
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDMDrawX]);
end;

end.
