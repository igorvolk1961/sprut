unit Spruter3_TLB;

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
// File generated on 08.11.02 16:21:57 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\USERS\VOLKOV\SPRUT3\BIN\SPRUTER3.EXE (1)
// LIBID: {F2BF6A40-F273-11D6-9B9F-BB45E830B860}
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

interface

uses ActiveX, Classes, Graphics, OleServer, StdVCL, Variants, Windows;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  Spruter3MajorVersion = 1;
  Spruter3MinorVersion = 0;

  LIBID_Spruter3: TGUID = '{F2BF6A40-F273-11D6-9B9F-BB45E830B860}';

  IID_ISpruter: TGUID = '{F2BF6A41-F273-11D6-9B9F-BB45E830B860}';
  CLASS_Spruter: TGUID = '{F2BF6A43-F273-11D6-9B9F-BB45E830B860}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISpruter = interface;
  ISpruterDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Spruter = ISpruter;


// *********************************************************************//
// Interface: ISpruter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F2BF6A41-F273-11D6-9B9F-BB45E830B860}
// *********************************************************************//
  ISpruter = interface(IDispatch)
    ['{F2BF6A41-F273-11D6-9B9F-BB45E830B860}']
    function  Get_FacilityModel: IUnknown; safecall;
    property FacilityModel: IUnknown read Get_FacilityModel;
  end;

// *********************************************************************//
// DispIntf:  ISpruterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F2BF6A41-F273-11D6-9B9F-BB45E830B860}
// *********************************************************************//
  ISpruterDisp = dispinterface
    ['{F2BF6A41-F273-11D6-9B9F-BB45E830B860}']
    property FacilityModel: IUnknown readonly dispid 1;
  end;

// *********************************************************************//
// The Class CoSpruter provides a Create and CreateRemote method to          
// create instances of the default interface ISpruter exposed by              
// the CoClass Spruter. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSpruter = class
    class function Create: ISpruter;
    class function CreateRemote(const MachineName: string): ISpruter;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSpruter
// Help String      : Spruter Object
// Default Interface: ISpruter
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSpruterProperties= class;
{$ENDIF}
  TSpruter = class(TOleServer)
  private
    FIntf:        ISpruter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSpruterProperties;
    function      GetServerProperties: TSpruterProperties;
{$ENDIF}
    function      GetDefaultInterface: ISpruter;
  protected
    procedure InitServerData; override;
    function  Get_FacilityModel: IUnknown;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISpruter);
    procedure Disconnect; override;
    property  DefaultInterface: ISpruter read GetDefaultInterface;
    property FacilityModel: IUnknown read Get_FacilityModel;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSpruterProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSpruter
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSpruterProperties = class(TPersistent)
  private
    FServer:    TSpruter;
    function    GetDefaultInterface: ISpruter;
    constructor Create(AServer: TSpruter);
  protected
    function  Get_FacilityModel: IUnknown;
  public
    property DefaultInterface: ISpruter read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoSpruter.Create: ISpruter;
begin
  Result := CreateComObject(CLASS_Spruter) as ISpruter;
end;

class function CoSpruter.CreateRemote(const MachineName: string): ISpruter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Spruter) as ISpruter;
end;

procedure TSpruter.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{F2BF6A43-F273-11D6-9B9F-BB45E830B860}';
    IntfIID:   '{F2BF6A41-F273-11D6-9B9F-BB45E830B860}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSpruter.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ISpruter;
  end;
end;

procedure TSpruter.ConnectTo(svrIntf: ISpruter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSpruter.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSpruter.GetDefaultInterface: ISpruter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSpruter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSpruterProperties.Create(Self);
{$ENDIF}
end;

destructor TSpruter.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSpruter.GetServerProperties: TSpruterProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function  TSpruter.Get_FacilityModel: IUnknown;
begin
  Result := DefaultInterface.FacilityModel;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSpruterProperties.Create(AServer: TSpruter);
begin
  inherited Create;
  FServer := AServer;
end;

function TSpruterProperties.GetDefaultInterface: ISpruter;
begin
  Result := FServer.DefaultInterface;
end;

function  TSpruterProperties.Get_FacilityModel: IUnknown;
begin
  Result := DefaultInterface.FacilityModel;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TSpruter]);
end;

end.
