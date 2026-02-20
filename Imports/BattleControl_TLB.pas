unit BattleControl_TLB;

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
// File generated on 03.12.02 10:09:42 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\USERS\Volkov\Sprut3\bin\BattleControl.ocx (1)
// LIBID: {B9803AB4-232F-11D3-BBF3-F082DE565936}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TBattleControlX) : Error reading control bitmap
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
  BattleControlMajorVersion = 1;
  BattleControlMinorVersion = 0;

  LIBID_BattleControl: TGUID = '{B9803AB4-232F-11D3-BBF3-F082DE565936}';

  IID_IBattleControlX: TGUID = '{B9803AB5-232F-11D3-BBF3-F082DE565936}';
  CLASS_BattleControlX: TGUID = '{B9803AB9-232F-11D3-BBF3-F082DE565936}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IBattleControlX = interface;
  IBattleControlXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  BattleControlX = IBattleControlX;


// *********************************************************************//
// Interface: IBattleControlX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B9803AB5-232F-11D3-BBF3-F082DE565936}
// *********************************************************************//
  IBattleControlX = interface(IDispatch)
    ['{B9803AB5-232F-11D3-BBF3-F082DE565936}']
    function  Get_BattleModel: IUnknown; safecall;
    procedure Set_BattleModel(const Value: IUnknown); safecall;
    property BattleModel: IUnknown read Get_BattleModel write Set_BattleModel;
  end;

// *********************************************************************//
// DispIntf:  IBattleControlXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B9803AB5-232F-11D3-BBF3-F082DE565936}
// *********************************************************************//
  IBattleControlXDisp = dispinterface
    ['{B9803AB5-232F-11D3-BBF3-F082DE565936}']
    property BattleModel: IUnknown dispid 1;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TBattleControlX
// Help String      : BattleControlX Control
// Default Interface: IBattleControlX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TBattleControlX = class(TOleControl)
  private
    FIntf: IBattleControlX;
    function  GetControlInterface: IBattleControlX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function  Get_BattleModel: IUnknown;
    procedure Set_BattleModel(const Value: IUnknown);
  public
    property  ControlInterface: IBattleControlX read GetControlInterface;
    property  DefaultInterface: IBattleControlX read GetControlInterface;
    property BattleModel: IUnknown index 1 read GetIUnknownProp write SetIUnknownProp;
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

procedure TBattleControlX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{B9803AB9-232F-11D3-BBF3-F082DE565936}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TBattleControlX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IBattleControlX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TBattleControlX.GetControlInterface: IBattleControlX;
begin
  CreateControl;
  Result := FIntf;
end;

function  TBattleControlX.Get_BattleModel: IUnknown;
begin
  Result := DefaultInterface.BattleModel;
end;

procedure TBattleControlX.Set_BattleModel(const Value: IUnknown);
begin
  DefaultInterface.BattleModel := Value;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TBattleControlX]);
end;

end.
