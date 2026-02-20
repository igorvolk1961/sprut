unit DMOpenGL_TLB;

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
// File generated on 11.06.02 9:20:52 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\AutoDM\bin\DMOpenGL.ocx (1)
// LIBID: {D2815C20-4323-11D6-96DE-0050BA51A6D3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
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
  DMOpenGLMajorVersion = 1;
  DMOpenGLMinorVersion = 0;

  LIBID_DMOpenGL: TGUID = '{D2815C20-4323-11D6-96DE-0050BA51A6D3}';

  IID_IDMOpenGLX: TGUID = '{D2815C21-4323-11D6-96DE-0050BA51A6D3}';
  CLASS_DMOpenGLX: TGUID = '{D2815C23-4323-11D6-96DE-0050BA51A6D3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMOpenGLX = interface;
  IDMOpenGLXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMOpenGLX = IDMOpenGLX;


// *********************************************************************//
// Interface: IDMOpenGLX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D2815C21-4323-11D6-96DE-0050BA51A6D3}
// *********************************************************************//
  IDMOpenGLX = interface(IDispatch)
    ['{D2815C21-4323-11D6-96DE-0050BA51A6D3}']
  end;

// *********************************************************************//
// DispIntf:  IDMOpenGLXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D2815C21-4323-11D6-96DE-0050BA51A6D3}
// *********************************************************************//
  IDMOpenGLXDisp = dispinterface
    ['{D2815C21-4323-11D6-96DE-0050BA51A6D3}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDMOpenGLX
// Help String      : DMOpenGLX Control
// Default Interface: IDMOpenGLX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDMOpenGLX = class(TOleControl)
  private
    FIntf: IDMOpenGLX;
    function  GetControlInterface: IDMOpenGLX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IDMOpenGLX read GetControlInterface;
    property  DefaultInterface: IDMOpenGLX read GetControlInterface;
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

procedure TDMOpenGLX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{D2815C23-4323-11D6-96DE-0050BA51A6D3}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDMOpenGLX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDMOpenGLX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDMOpenGLX.GetControlInterface: IDMOpenGLX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDMOpenGLX]);
end;

end.
