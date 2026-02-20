unit FMDraw_TLB;

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
// File generated on 04.08.2005 11:18:19 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Volkov\Sprut3\bin\FMDraw.ocx (1)
// LIBID: {491302F2-E9FC-4240-8B28-C3D7FB63BDEC}
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
  FMDrawMajorVersion = 1;
  FMDrawMinorVersion = 0;

  LIBID_FMDraw: TGUID = '{491302F2-E9FC-4240-8B28-C3D7FB63BDEC}';

  IID_IFMDrawX: TGUID = '{9BE9D16B-8CD8-4027-B253-7EDF174C4982}';
  CLASS_FMDrawX: TGUID = '{FC6807D6-97FB-433F-95DE-19999D835FF7}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFMDrawX = interface;
  IFMDrawXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FMDrawX = IFMDrawX;


// *********************************************************************//
// Interface: IFMDrawX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BE9D16B-8CD8-4027-B253-7EDF174C4982}
// *********************************************************************//
  IFMDrawX = interface(IDispatch)
    ['{9BE9D16B-8CD8-4027-B253-7EDF174C4982}']
  end;

// *********************************************************************//
// DispIntf:  IFMDrawXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BE9D16B-8CD8-4027-B253-7EDF174C4982}
// *********************************************************************//
  IFMDrawXDisp = dispinterface
    ['{9BE9D16B-8CD8-4027-B253-7EDF174C4982}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TFMDrawX
// Help String      : FMDrawX Control
// Default Interface: IFMDrawX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TFMDrawX = class(TOleControl)
  private
    FIntf: IFMDrawX;
    function  GetControlInterface: IFMDrawX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IFMDrawX read GetControlInterface;
    property  DefaultInterface: IFMDrawX read GetControlInterface;
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

procedure TFMDrawX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{FC6807D6-97FB-433F-95DE-19999D835FF7}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TFMDrawX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IFMDrawX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TFMDrawX.GetControlInterface: IFMDrawX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TFMDrawX]);
end;

end.
