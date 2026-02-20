unit DMBrowser_TLB;

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
// File generated on 04.08.2005 11:17:31 from Type Library described below.

// ************************************************************************  //
// Type Lib: c:\Users\Volkov\AutoDM\bin\DMBrowser.ocx (1)
// LIBID: {47118732-1F7D-11D6-9340-0050BA51A6D3}
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
  DMBrowserMajorVersion = 1;
  DMBrowserMinorVersion = 0;

  LIBID_DMBrowser: TGUID = '{47118732-1F7D-11D6-9340-0050BA51A6D3}';

  IID_IDMBrowserX: TGUID = '{5311CE61-0694-11D5-845E-C1351F961A12}';
  CLASS_DMBrowserX: TGUID = '{47118730-1F7D-11D6-9340-0050BA51A6D3}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TDetailMode
type
  TDetailMode = TOleEnum;
const
  dmdList = $00000000;
  dmdTable = $00000001;

// Constants for enum TParameterKind
type
  TParameterKind = TOleEnum;
const
  pkInput = $00000001;
  pkOutput = $00000002;
  pkUserDefined = $00000004;
  pkComment = $00000008;
  pkView = $00000010;
  pkAnalysis = $00000020;
  pkAdditional1 = $00000040;
  pkAdditional2 = $00000080;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMBrowserX = interface;
  IDMBrowserXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMBrowserX = IDMBrowserX;


// *********************************************************************//
// Interface: IDMBrowserX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5311CE61-0694-11D5-845E-C1351F961A12}
// *********************************************************************//
  IDMBrowserX = interface(IDispatch)
    ['{5311CE61-0694-11D5-845E-C1351F961A12}']
    function Get_CurrentElement: IUnknown; safecall;
    procedure Set_CurrentElement(const Value: IUnknown); safecall;
    function Get_DetailMode: Integer; safecall;
    procedure Set_DetailMode(Value: Integer); safecall;
    property CurrentElement: IUnknown read Get_CurrentElement write Set_CurrentElement;
    property DetailMode: Integer read Get_DetailMode write Set_DetailMode;
  end;

// *********************************************************************//
// DispIntf:  IDMBrowserXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5311CE61-0694-11D5-845E-C1351F961A12}
// *********************************************************************//
  IDMBrowserXDisp = dispinterface
    ['{5311CE61-0694-11D5-845E-C1351F961A12}']
    property CurrentElement: IUnknown dispid 28;
    property DetailMode: Integer dispid 2;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDMBrowserX
// Help String      : DMBrowserX Control
// Default Interface: IDMBrowserX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDMBrowserX = class(TOleControl)
  private
    FIntf: IDMBrowserX;
    function  GetControlInterface: IDMBrowserX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_CurrentElement: IUnknown;
    procedure Set_CurrentElement(const Value: IUnknown);
  public
    property  ControlInterface: IDMBrowserX read GetControlInterface;
    property  DefaultInterface: IDMBrowserX read GetControlInterface;
    property CurrentElement: IUnknown index 28 read GetIUnknownProp write SetIUnknownProp;
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
    property DetailMode: Integer index 2 read GetIntegerProp write SetIntegerProp stored False;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TDMBrowserX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{47118730-1F7D-11D6-9340-0050BA51A6D3}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDMBrowserX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDMBrowserX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDMBrowserX.GetControlInterface: IDMBrowserX;
begin
  CreateControl;
  Result := FIntf;
end;

function TDMBrowserX.Get_CurrentElement: IUnknown;
begin
    Result := DefaultInterface.CurrentElement;
end;

procedure TDMBrowserX.Set_CurrentElement(const Value: IUnknown);
begin
  Exit;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDMBrowserX]);
end;

end.
