unit DMChart_TLB;

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
// File generated on 11.06.02 9:20:12 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\AutoDM\bin\DMChart.ocx (1)
// LIBID: {BB44ED00-4ED7-11D6-9B9F-E3C910114CA3}
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
  DMChartMajorVersion = 1;
  DMChartMinorVersion = 0;

  LIBID_DMChart: TGUID = '{BB44ED00-4ED7-11D6-9B9F-E3C910114CA3}';

  IID_IDMChartX: TGUID = '{BB44ED01-4ED7-11D6-9B9F-E3C910114CA3}';
  CLASS_DMChartX: TGUID = '{BB44ED03-4ED7-11D6-9B9F-E3C910114CA3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMChartX = interface;
  IDMChartXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMChartX = IDMChartX;


// *********************************************************************//
// Interface: IDMChartX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BB44ED01-4ED7-11D6-9B9F-E3C910114CA3}
// *********************************************************************//
  IDMChartX = interface(IDispatch)
    ['{BB44ED01-4ED7-11D6-9B9F-E3C910114CA3}']
  end;

// *********************************************************************//
// DispIntf:  IDMChartXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BB44ED01-4ED7-11D6-9B9F-E3C910114CA3}
// *********************************************************************//
  IDMChartXDisp = dispinterface
    ['{BB44ED01-4ED7-11D6-9B9F-E3C910114CA3}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDMChartX
// Help String      : DMChartX Control
// Default Interface: IDMChartX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDMChartX = class(TOleControl)
  private
    FIntf: IDMChartX;
    function  GetControlInterface: IDMChartX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IDMChartX read GetControlInterface;
    property  DefaultInterface: IDMChartX read GetControlInterface;
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

procedure TDMChartX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{BB44ED03-4ED7-11D6-9B9F-E3C910114CA3}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDMChartX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDMChartX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDMChartX.GetControlInterface: IDMChartX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDMChartX]);
end;

end.
