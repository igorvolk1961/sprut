unit DMReport_TLB;

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
// File generated on 25.10.04 12:41:53 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\volkov\AutoDM\bin\DMReport.ocx (1)
// LIBID: {BB44ED08-4ED7-11D6-9B9F-E3C910114CA3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TDMReportX) : Error reading control bitmap
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
  DMReportMajorVersion = 1;
  DMReportMinorVersion = 0;

  LIBID_DMReport: TGUID = '{BB44ED08-4ED7-11D6-9B9F-E3C910114CA3}';

  IID_IDMReportX: TGUID = '{BB44ED09-4ED7-11D6-9B9F-E3C910114CA3}';
  CLASS_DMReportX: TGUID = '{BB44ED0B-4ED7-11D6-9B9F-E3C910114CA3}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMReportX = interface;
  IDMReportXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMReportX = IDMReportX;


// *********************************************************************//
// Interface: IDMReportX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BB44ED09-4ED7-11D6-9B9F-E3C910114CA3}
// *********************************************************************//
  IDMReportX = interface(IDispatch)
    ['{BB44ED09-4ED7-11D6-9B9F-E3C910114CA3}']
  end;

// *********************************************************************//
// DispIntf:  IDMReportXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BB44ED09-4ED7-11D6-9B9F-E3C910114CA3}
// *********************************************************************//
  IDMReportXDisp = dispinterface
    ['{BB44ED09-4ED7-11D6-9B9F-E3C910114CA3}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDMReportX
// Help String      : DMChartX Control
// Default Interface: IDMReportX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDMReportX = class(TOleControl)
  private
    FIntf: IDMReportX;
    function  GetControlInterface: IDMReportX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IDMReportX read GetControlInterface;
    property  DefaultInterface: IDMReportX read GetControlInterface;
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

procedure TDMReportX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{BB44ED0B-4ED7-11D6-9B9F-E3C910114CA3}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDMReportX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDMReportX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDMReportX.GetControlInterface: IDMReportX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDMReportX]);
end;

end.
