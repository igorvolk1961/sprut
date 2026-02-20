unit DetailsControl_TLB;

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
// File generated on 05.09.03 13:12:20 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\Sprut3\bin\DetailsControl.ocx (1)
// LIBID: {6E3795B0-DF7F-11D7-98B1-0050BA51A6D3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TDetailsControlX) : Error reading control bitmap
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
  DetailsControlMajorVersion = 1;
  DetailsControlMinorVersion = 0;

  LIBID_DetailsControl: TGUID = '{6E3795B0-DF7F-11D7-98B1-0050BA51A6D3}';

  IID_IDetailsControlX: TGUID = '{6E3795B1-DF7F-11D7-98B1-0050BA51A6D3}';
  CLASS_DetailsControlX: TGUID = '{6E3795B3-DF7F-11D7-98B1-0050BA51A6D3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDetailsControlX = interface;
  IDetailsControlXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DetailsControlX = IDetailsControlX;


// *********************************************************************//
// Interface: IDetailsControlX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6E3795B1-DF7F-11D7-98B1-0050BA51A6D3}
// *********************************************************************//
  IDetailsControlX = interface(IDispatch)
    ['{6E3795B1-DF7F-11D7-98B1-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IDetailsControlXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6E3795B1-DF7F-11D7-98B1-0050BA51A6D3}
// *********************************************************************//
  IDetailsControlXDisp = dispinterface
    ['{6E3795B1-DF7F-11D7-98B1-0050BA51A6D3}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDetailsControlX
// Help String      : DetailsControlX Control
// Default Interface: IDetailsControlX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDetailsControlX = class(TOleControl)
  private
    FIntf: IDetailsControlX;
    function  GetControlInterface: IDetailsControlX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IDetailsControlX read GetControlInterface;
    property  DefaultInterface: IDetailsControlX read GetControlInterface;
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

procedure TDetailsControlX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{6E3795B3-DF7F-11D7-98B1-0050BA51A6D3}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDetailsControlX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDetailsControlX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDetailsControlX.GetControlInterface: IDetailsControlX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDetailsControlX]);
end;

end.
