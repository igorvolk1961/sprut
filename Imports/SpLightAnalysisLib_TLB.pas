unit SpLightAnalysisLib_TLB;

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
// File generated on 16.03.2007 13:55:26 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\Projects\Sprutik\bin\SpLightAnalysis.dll (1)
// LIBID: {31849C58-3544-480A-82E1-7E5007C4B4EE}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
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

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SpLightAnalysisLibMajorVersion = 1;
  SpLightAnalysisLibMinorVersion = 0;

  LIBID_SpLightAnalysisLib: TGUID = '{31849C58-3544-480A-82E1-7E5007C4B4EE}';

  IID_ISpLightAnalysis: TGUID = '{1D2DF900-AF6F-4165-B78D-75FA19B039D9}';
  CLASS_SpLightAnalysis: TGUID = '{8F85863A-7EA2-4081-A70B-D45CBBDFE26B}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISpLightAnalysis = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SpLightAnalysis = ISpLightAnalysis;


// *********************************************************************//
// Interface: ISpLightAnalysis
// Flags:     (256) OleAutomation
// GUID:      {1D2DF900-AF6F-4165-B78D-75FA19B039D9}
// *********************************************************************//
  ISpLightAnalysis = interface(IUnknown)
    ['{1D2DF900-AF6F-4165-B78D-75FA19B039D9}']
  end;

// *********************************************************************//
// The Class CoSpLightAnalysis provides a Create and CreateRemote method to          
// create instances of the default interface ISpLightAnalysis exposed by              
// the CoClass SpLightAnalysis. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSpLightAnalysis = class
    class function Create: ISpLightAnalysis;
    class function CreateRemote(const MachineName: string): ISpLightAnalysis;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSpLightAnalysis
// Help String      : 
// Default Interface: ISpLightAnalysis
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSpLightAnalysisProperties= class;
{$ENDIF}
  TSpLightAnalysis = class(TOleServer)
  private
    FIntf:        ISpLightAnalysis;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSpLightAnalysisProperties;
    function      GetServerProperties: TSpLightAnalysisProperties;
{$ENDIF}
    function      GetDefaultInterface: ISpLightAnalysis;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISpLightAnalysis);
    procedure Disconnect; override;
    property DefaultInterface: ISpLightAnalysis read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSpLightAnalysisProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSpLightAnalysis
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSpLightAnalysisProperties = class(TPersistent)
  private
    FServer:    TSpLightAnalysis;
    function    GetDefaultInterface: ISpLightAnalysis;
    constructor Create(AServer: TSpLightAnalysis);
  protected
  public
    property DefaultInterface: ISpLightAnalysis read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoSpLightAnalysis.Create: ISpLightAnalysis;
begin
  Result := CreateComObject(CLASS_SpLightAnalysis) as ISpLightAnalysis;
end;

class function CoSpLightAnalysis.CreateRemote(const MachineName: string): ISpLightAnalysis;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SpLightAnalysis) as ISpLightAnalysis;
end;

procedure TSpLightAnalysis.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8F85863A-7EA2-4081-A70B-D45CBBDFE26B}';
    IntfIID:   '{1D2DF900-AF6F-4165-B78D-75FA19B039D9}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSpLightAnalysis.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ISpLightAnalysis;
  end;
end;

procedure TSpLightAnalysis.ConnectTo(svrIntf: ISpLightAnalysis);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSpLightAnalysis.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSpLightAnalysis.GetDefaultInterface: ISpLightAnalysis;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSpLightAnalysis.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSpLightAnalysisProperties.Create(Self);
{$ENDIF}
end;

destructor TSpLightAnalysis.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSpLightAnalysis.GetServerProperties: TSpLightAnalysisProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSpLightAnalysisProperties.Create(AServer: TSpLightAnalysis);
begin
  inherited Create;
  FServer := AServer;
end;

function TSpLightAnalysisProperties.GetDefaultInterface: ISpLightAnalysis;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TSpLightAnalysis]);
end;

end.
