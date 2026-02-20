unit DrawToolBarXControl1_TLB;

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
// File generated on 26.02.02 17:56:43 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\GOL\DrawToolBarX\DrawToolBarXControl1.ocx (1)
// LIBID: {BDBBEC45-2AC0-11D6-9385-0050BA51A4A4}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
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
  DrawToolBarXControl1MajorVersion = 1;
  DrawToolBarXControl1MinorVersion = 0;

  LIBID_DrawToolBarXControl1: TGUID = '{BDBBEC45-2AC0-11D6-9385-0050BA51A4A4}';

  IID_IDrawToolBarX: TGUID = '{BDBBEC46-2AC0-11D6-9385-0050BA51A4A4}';
  DIID_IDrawToolBarXEvents: TGUID = '{BDBBEC48-2AC0-11D6-9385-0050BA51A4A4}';
  CLASS_DrawToolBarX: TGUID = '{BDBBEC4A-2AC0-11D6-9385-0050BA51A4A4}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDrawToolBarX = interface;
  IDrawToolBarXDisp = dispinterface;
  IDrawToolBarXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DrawToolBarX = IDrawToolBarX;


// *********************************************************************//
// Interface: IDrawToolBarX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BDBBEC46-2AC0-11D6-9385-0050BA51A4A4}
// *********************************************************************//
  IDrawToolBarX = interface(IDispatch)
    ['{BDBBEC46-2AC0-11D6-9385-0050BA51A4A4}']
    function  Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  IDrawToolBarXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BDBBEC46-2AC0-11D6-9385-0050BA51A4A4}
// *********************************************************************//
  IDrawToolBarXDisp = dispinterface
    ['{BDBBEC46-2AC0-11D6-9385-0050BA51A4A4}']
    property Visible: WordBool dispid 5;
    procedure SetSubComponent(IsSubComponent: WordBool); dispid 21;
  end;

// *********************************************************************//
// DispIntf:  IDrawToolBarXEvents
// Flags:     (4096) Dispatchable
// GUID:      {BDBBEC48-2AC0-11D6-9385-0050BA51A4A4}
// *********************************************************************//
  IDrawToolBarXEvents = dispinterface
    ['{BDBBEC48-2AC0-11D6-9385-0050BA51A4A4}']
    procedure OnClick; dispid 1;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDrawToolBarX
// Help String      : DrawToolBarX Control
// Default Interface: IDrawToolBarX
// Def. Intf. DISP? : No
// Event   Interface: IDrawToolBarXEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDrawToolBarX = class(TOleControl)
  private
    FOnClick: TNotifyEvent;
    FIntf: IDrawToolBarX;
    function  GetControlInterface: IDrawToolBarX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SetSubComponent(IsSubComponent: WordBool);
    property  ControlInterface: IDrawToolBarX read GetControlInterface;
    property  DefaultInterface: IDrawToolBarX read GetControlInterface;
  published
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property Visible: WordBool index 5 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TDrawToolBarX.InitControlData;
const
  CEventDispIDs: array [0..0] of DWORD = (
    $00000001);
  CControlData: TControlData2 = (
    ClassID: '{BDBBEC4A-2AC0-11D6-9385-0050BA51A4A4}';
    EventIID: '{BDBBEC48-2AC0-11D6-9385-0050BA51A4A4}';
    EventCount: 1;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnClick) - Cardinal(Self);
end;

procedure TDrawToolBarX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDrawToolBarX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDrawToolBarX.GetControlInterface: IDrawToolBarX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TDrawToolBarX.SetSubComponent(IsSubComponent: WordBool);
begin
  DefaultInterface.SetSubComponent(IsSubComponent);
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDrawToolBarX]);
end;

end.
