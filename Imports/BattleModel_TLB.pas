unit BattleModel_TLB;

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
// File generated on 15.06.99 15:31:17 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\users\volkov\AutoDM\bin\BattleModel.ocx (1)
// LIBID: {B9803AB4-232F-11D3-BBF3-F082DE565936}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TBattleModelX) : Registry key CLSID\{B9803AB9-232F-11D3-BBF3-F082DE565936}\ToolboxBitmap32 not found
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
  BattleModelMajorVersion = 1;
  BattleModelMinorVersion = 0;

  LIBID_BattleModel: TGUID = '{B9803AB4-232F-11D3-BBF3-F082DE565936}';

  IID_IBattleModelX: TGUID = '{B9803AB5-232F-11D3-BBF3-F082DE565936}';
  CLASS_BattleModelX: TGUID = '{B9803AB9-232F-11D3-BBF3-F082DE565936}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IBattleModelX = interface;
  IBattleModelXDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  BattleModelX = IBattleModelX;


// *********************************************************************//
// Interface: IBattleModelX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B9803AB5-232F-11D3-BBF3-F082DE565936}
// *********************************************************************//
  IBattleModelX = interface(IDispatch)
    ['{B9803AB5-232F-11D3-BBF3-F082DE565936}']
  end;

// *********************************************************************//
// DispIntf:  IBattleModelXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B9803AB5-232F-11D3-BBF3-F082DE565936}
// *********************************************************************//
  IBattleModelXDisp = dispinterface
    ['{B9803AB5-232F-11D3-BBF3-F082DE565936}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TBattleModelX
// Help String      : BattleModelX Control
// Default Interface: IBattleModelX
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TBattleModelX = class(TOleControl)
  private
    FIntf: IBattleModelX;
    function  GetControlInterface: IBattleModelX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    property  ControlInterface: IBattleModelX read GetControlInterface;
    property  DefaultInterface: IBattleModelX read GetControlInterface;
  published
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TBattleModelX.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{B9803AB9-232F-11D3-BBF3-F082DE565936}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80040154*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TBattleModelX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IBattleModelX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TBattleModelX.GetControlInterface: IBattleModelX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TBattleModelX]);
end;

end.
