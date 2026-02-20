unit DMGameLib_TLB;

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
// File generated on 24.11.02 13:23:36 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\USERS\VOLKOV\AUTODM\BIN\DMGAMELIB.DLL (1)
// LIBID: {02E7A620-FFA9-11D6-9B9F-F151FC154660}
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
  DMGameLibMajorVersion = 1;
  DMGameLibMinorVersion = 0;

  LIBID_DMGameLib: TGUID = '{02E7A620-FFA9-11D6-9B9F-F151FC154660}';

  IID_IDMGame: TGUID = '{02E7A621-FFA9-11D6-9B9F-F151FC154660}';
  CLASS_DMGame: TGUID = '{02E7A623-FFA9-11D6-9B9F-F151FC154660}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDMGame = interface;
  IDMGameDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DMGame = IDMGame;


// *********************************************************************//
// Interface: IDMGame
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {02E7A621-FFA9-11D6-9B9F-F151FC154660}
// *********************************************************************//
  IDMGame = interface(IDispatch)
    ['{02E7A621-FFA9-11D6-9B9F-F151FC154660}']
    function  Get_FacilityModel: IUnknown; safecall;
    procedure Set_FacilityModel(const Value: IUnknown); safecall;
    procedure BuildWorld(const FileName: WideString); safecall;
    property FacilityModel: IUnknown read Get_FacilityModel write Set_FacilityModel;
  end;

// *********************************************************************//
// DispIntf:  IDMGameDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {02E7A621-FFA9-11D6-9B9F-F151FC154660}
// *********************************************************************//
  IDMGameDisp = dispinterface
    ['{02E7A621-FFA9-11D6-9B9F-F151FC154660}']
    property FacilityModel: IUnknown dispid 1;
    procedure BuildWorld(const FileName: WideString); dispid 2;
  end;

// *********************************************************************//
// The Class CoDMGame provides a Create and CreateRemote method to          
// create instances of the default interface IDMGame exposed by              
// the CoClass DMGame. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDMGame = class
    class function Create: IDMGame;
    class function CreateRemote(const MachineName: string): IDMGame;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDMGame
// Help String      : DMGame Object
// Default Interface: IDMGame
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDMGameProperties= class;
{$ENDIF}
  TDMGame = class(TOleServer)
  private
    FIntf:        IDMGame;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDMGameProperties;
    function      GetServerProperties: TDMGameProperties;
{$ENDIF}
    function      GetDefaultInterface: IDMGame;
  protected
    procedure InitServerData; override;
    function  Get_FacilityModel: IUnknown;
    procedure Set_FacilityModel(const Value: IUnknown);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDMGame);
    procedure Disconnect; override;
    procedure BuildWorld(const FileName: WideString);
    property  DefaultInterface: IDMGame read GetDefaultInterface;
    property FacilityModel: IUnknown read Get_FacilityModel write Set_FacilityModel;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDMGameProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDMGame
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDMGameProperties = class(TPersistent)
  private
    FServer:    TDMGame;
    function    GetDefaultInterface: IDMGame;
    constructor Create(AServer: TDMGame);
  protected
    function  Get_FacilityModel: IUnknown;
    procedure Set_FacilityModel(const Value: IUnknown);
  public
    property DefaultInterface: IDMGame read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoDMGame.Create: IDMGame;
begin
  Result := CreateComObject(CLASS_DMGame) as IDMGame;
end;

class function CoDMGame.CreateRemote(const MachineName: string): IDMGame;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DMGame) as IDMGame;
end;

procedure TDMGame.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{02E7A623-FFA9-11D6-9B9F-F151FC154660}';
    IntfIID:   '{02E7A621-FFA9-11D6-9B9F-F151FC154660}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDMGame.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IDMGame;
  end;
end;

procedure TDMGame.ConnectTo(svrIntf: IDMGame);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDMGame.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDMGame.GetDefaultInterface: IDMGame;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDMGame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDMGameProperties.Create(Self);
{$ENDIF}
end;

destructor TDMGame.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDMGame.GetServerProperties: TDMGameProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function  TDMGame.Get_FacilityModel: IUnknown;
begin
  Result := DefaultInterface.FacilityModel;
end;

procedure TDMGame.Set_FacilityModel(const Value: IUnknown);
begin
  DefaultInterface.FacilityModel := Value;
end;

procedure TDMGame.BuildWorld(const FileName: WideString);
begin
  DefaultInterface.BuildWorld(FileName);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDMGameProperties.Create(AServer: TDMGame);
begin
  inherited Create;
  FServer := AServer;
end;

function TDMGameProperties.GetDefaultInterface: IDMGame;
begin
  Result := FServer.DefaultInterface;
end;

function  TDMGameProperties.Get_FacilityModel: IUnknown;
begin
  Result := DefaultInterface.FacilityModel;
end;

procedure TDMGameProperties.Set_FacilityModel(const Value: IUnknown);
begin
  DefaultInterface.FacilityModel := Value;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TDMGame]);
end;

end.
