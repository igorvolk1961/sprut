unit MSISYSLib_TLB;

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
// File generated on 23.01.04 22:59:57 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\PROGRAM FILES\COMMON FILES\MICROSOFT SHARED\MSINFO\MSISYS.OCX (1)
// LIBID: {A3BE0BAB-8D9C-11D0-8A91-00AA0069B846}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
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
  MSISYSLibMajorVersion = 1;
  MSISYSLibMinorVersion = 0;

  LIBID_MSISYSLib: TGUID = '{A3BE0BAB-8D9C-11D0-8A91-00AA0069B846}';

  DIID__DMsiSys: TGUID = '{A3BE0BAC-8D9C-11D0-8A91-00AA0069B846}';
  DIID__DMsiSysEvents: TGUID = '{A3BE0BAD-8D9C-11D0-8A91-00AA0069B846}';
  CLASS_MsiSys: TGUID = '{A3BE0BAE-8D9C-11D0-8A91-00AA0069B846}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DMsiSys = dispinterface;
  _DMsiSysEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MsiSys = _DMsiSys;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PInteger1 = ^Integer; {*}


// *********************************************************************//
// DispIntf:  _DMsiSys
// Flags:     (4112) Hidden Dispatchable
// GUID:      {A3BE0BAC-8D9C-11D0-8A91-00AA0069B846}
// *********************************************************************//
  _DMsiSys = dispinterface
    ['{A3BE0BAC-8D9C-11D0-8A91-00AA0069B846}']
    property MSInfoView: Integer dispid 1;
    procedure MSInfoRefresh(fForSave: WordBool; var pCancel: Integer); dispid 2;
    function MSInfoLoadFile(const szFileName: WideString): WordBool; dispid 3;
    procedure MSInfoSelectAll; dispid 4;
    procedure MSInfoCopy; dispid 5;
    procedure MSInfoUpdateView; dispid 6;
    function MSInfoGetData(dwMSInfoView: Integer; var pBuffer: Integer; dwLength: Integer): Integer; dispid 7;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  _DMsiSysEvents
// Flags:     (4096) Dispatchable
// GUID:      {A3BE0BAD-8D9C-11D0-8A91-00AA0069B846}
// *********************************************************************//
  _DMsiSysEvents = dispinterface
    ['{A3BE0BAD-8D9C-11D0-8A91-00AA0069B846}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMsiSys
// Help String      : System Information Control
// Default Interface: _DMsiSys
// Def. Intf. DISP? : Yes
// Event   Interface: _DMsiSysEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TMsiSys = class(TOleControl)
  private
    FIntf: _DMsiSys;
    function  GetControlInterface: _DMsiSys;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure MSInfoRefresh(fForSave: WordBool; var pCancel: Integer);
    function MSInfoLoadFile(const szFileName: WideString): WordBool;
    procedure MSInfoSelectAll;
    procedure MSInfoCopy;
    procedure MSInfoUpdateView;
    function MSInfoGetData(dwMSInfoView: Integer; var pBuffer: Integer; dwLength: Integer): Integer;
    procedure AboutBox;
    property  ControlInterface: _DMsiSys read GetControlInterface;
    property  DefaultInterface: _DMsiSys read GetControlInterface;
  published
    property  TabStop;
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
    property MSInfoView: Integer index 1 read GetIntegerProp write SetIntegerProp stored False;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TMsiSys.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{A3BE0BAE-8D9C-11D0-8A91-00AA0069B846}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TMsiSys.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DMsiSys;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMsiSys.GetControlInterface: _DMsiSys;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TMsiSys.MSInfoRefresh(fForSave: WordBool; var pCancel: Integer);
begin
  DefaultInterface.MSInfoRefresh(fForSave, pCancel);
end;

function TMsiSys.MSInfoLoadFile(const szFileName: WideString): WordBool;
begin
  Result := DefaultInterface.MSInfoLoadFile(szFileName);
end;

procedure TMsiSys.MSInfoSelectAll;
begin
  DefaultInterface.MSInfoSelectAll;
end;

procedure TMsiSys.MSInfoCopy;
begin
  DefaultInterface.MSInfoCopy;
end;

procedure TMsiSys.MSInfoUpdateView;
begin
  DefaultInterface.MSInfoUpdateView;
end;

function TMsiSys.MSInfoGetData(dwMSInfoView: Integer; var pBuffer: Integer; dwLength: Integer): Integer;
begin
  Result := DefaultInterface.MSInfoGetData(dwMSInfoView, pBuffer, dwLength);
end;

procedure TMsiSys.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TMsiSys]);
end;

end.
