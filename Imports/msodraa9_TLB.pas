unit msodraa9_TLB;

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
// File generated on 11.02.02 15:53:29 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\PROGRA~1\MICROS~1\Office\MSODRAA9.DLL (1)
// LIBID: {FB6BA82F-E616-11D1-8D27-00AA00B5BADA}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v2.1 Office, (D:\Distrib\Office2000\PFILES\MSOFFICE\OFFICE\MSO9.DLL)
//   (3) v1.0 AddInDesignerObjects, (C:\Program Files\Common Files\Designer\MSADDNDR.DLL)
//   (4) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TShapeSelect) : Server C:\Program Files\Microsoft Office\Office\MSODRAA9.DLL contains no icons
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

uses ActiveX, AddInDesignerObjects_TLB, Classes, Graphics, Office_TLB, OleServer, StdVCL, 
Variants, Windows;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  msodraa9MajorVersion = 1;
  msodraa9MinorVersion = 0;

  LIBID_msodraa9: TGUID = '{FB6BA82F-E616-11D1-8D27-00AA00B5BADA}';

  IID__ShapeSelect: TGUID = '{FB6BA827-E616-11D1-8D27-00AA00B5BADA}';
  CLASS_ShapeSelect: TGUID = '{FB6BA828-E616-11D1-8D27-00AA00B5BADA}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _ShapeSelect = interface;
  _ShapeSelectDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ShapeSelect = _ShapeSelect;


// *********************************************************************//
// Interface: _ShapeSelect
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {FB6BA827-E616-11D1-8D27-00AA00B5BADA}
// *********************************************************************//
  _ShapeSelect = interface(IDispatch)
    ['{FB6BA827-E616-11D1-8D27-00AA00B5BADA}']
    function  Get_ButtonHandler: _CommandBarButton; safecall;
    procedure GhostMethod__ShapeSelect_32_0; safecall;
    procedure _Set_ButtonHandler(const ButtonHandler: _CommandBarButton); safecall;
    property ButtonHandler: _CommandBarButton read Get_ButtonHandler;
  end;

// *********************************************************************//
// DispIntf:  _ShapeSelectDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {FB6BA827-E616-11D1-8D27-00AA00B5BADA}
// *********************************************************************//
  _ShapeSelectDisp = dispinterface
    ['{FB6BA827-E616-11D1-8D27-00AA00B5BADA}']
    property ButtonHandler: _CommandBarButton dispid 1073938435;
    procedure GhostMethod__ShapeSelect_32_0; dispid 1610743809;
  end;

// *********************************************************************//
// The Class CoShapeSelect provides a Create and CreateRemote method to          
// create instances of the default interface _ShapeSelect exposed by              
// the CoClass ShapeSelect. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShapeSelect = class
    class function Create: _ShapeSelect;
    class function CreateRemote(const MachineName: string): _ShapeSelect;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TShapeSelect
// Help String      : 
// Default Interface: _ShapeSelect
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TShapeSelectProperties= class;
{$ENDIF}
  TShapeSelect = class(TOleServer)
  private
    FIntf:        _ShapeSelect;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TShapeSelectProperties;
    function      GetServerProperties: TShapeSelectProperties;
{$ENDIF}
    function      GetDefaultInterface: _ShapeSelect;
  protected
    procedure InitServerData; override;
    function  Get_ButtonHandler: _CommandBarButton;
    procedure _Set_ButtonHandler(const ButtonHandler: _CommandBarButton);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ShapeSelect);
    procedure Disconnect; override;
    property  DefaultInterface: _ShapeSelect read GetDefaultInterface;
    property ButtonHandler: _CommandBarButton read Get_ButtonHandler write _Set_ButtonHandler;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TShapeSelectProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TShapeSelect
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TShapeSelectProperties = class(TPersistent)
  private
    FServer:    TShapeSelect;
    function    GetDefaultInterface: _ShapeSelect;
    constructor Create(AServer: TShapeSelect);
  protected
    function  Get_ButtonHandler: _CommandBarButton;
    procedure _Set_ButtonHandler(const ButtonHandler: _CommandBarButton);
  public
    property DefaultInterface: _ShapeSelect read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoShapeSelect.Create: _ShapeSelect;
begin
  Result := CreateComObject(CLASS_ShapeSelect) as _ShapeSelect;
end;

class function CoShapeSelect.CreateRemote(const MachineName: string): _ShapeSelect;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShapeSelect) as _ShapeSelect;
end;

procedure TShapeSelect.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{FB6BA828-E616-11D1-8D27-00AA00B5BADA}';
    IntfIID:   '{FB6BA827-E616-11D1-8D27-00AA00B5BADA}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TShapeSelect.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ShapeSelect;
  end;
end;

procedure TShapeSelect.ConnectTo(svrIntf: _ShapeSelect);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TShapeSelect.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TShapeSelect.GetDefaultInterface: _ShapeSelect;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TShapeSelect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TShapeSelectProperties.Create(Self);
{$ENDIF}
end;

destructor TShapeSelect.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TShapeSelect.GetServerProperties: TShapeSelectProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function  TShapeSelect.Get_ButtonHandler: _CommandBarButton;
begin
  Result := DefaultInterface.ButtonHandler;
end;

procedure TShapeSelect._Set_ButtonHandler(const ButtonHandler: _CommandBarButton);
  { Warning: The property ButtonHandler has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ButtonHandler := ButtonHandler;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TShapeSelectProperties.Create(AServer: TShapeSelect);
begin
  inherited Create;
  FServer := AServer;
end;

function TShapeSelectProperties.GetDefaultInterface: _ShapeSelect;
begin
  Result := FServer.DefaultInterface;
end;

function  TShapeSelectProperties.Get_ButtonHandler: _CommandBarButton;
begin
  Result := DefaultInterface.ButtonHandler;
end;

procedure TShapeSelectProperties._Set_ButtonHandler(const ButtonHandler: _CommandBarButton);
  { Warning: The property ButtonHandler has a setter and a getter whose
  types do not match. Delphi was unable to generate a property of
  this sort and so is using a Variant to set the property instead. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ButtonHandler := ButtonHandler;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TShapeSelect]);
end;

end.
