unit FMDocumentLib_TLB;

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
// File generated on 02.05.2007 13:56:30 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\volkov\Sprut3\bin\FMDocumentLib.dll (1)
// LIBID: {15B14D70-7F11-4C3C-B61F-F1D46EE5328D}
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
  FMDocumentLibMajorVersion = 1;
  FMDocumentLibMinorVersion = 0;

  LIBID_FMDocumentLib: TGUID = '{15B14D70-7F11-4C3C-B61F-F1D46EE5328D}';

  IID_IFMDocument: TGUID = '{F38AAA68-3925-4B51-B41D-8111C1EA82FA}';
  CLASS_FMDocument: TGUID = '{CD03FC56-20EE-438A-ACEA-C9C279D4ADDE}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFMDocument = interface;
  IFMDocumentDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FMDocument = IFMDocument;


// *********************************************************************//
// Interface: IFMDocument
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F38AAA68-3925-4B51-B41D-8111C1EA82FA}
// *********************************************************************//
  IFMDocument = interface(IDispatch)
    ['{F38AAA68-3925-4B51-B41D-8111C1EA82FA}']
    procedure BuildPerimeterZone; safecall;
  end;

// *********************************************************************//
// DispIntf:  IFMDocumentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F38AAA68-3925-4B51-B41D-8111C1EA82FA}
// *********************************************************************//
  IFMDocumentDisp = dispinterface
    ['{F38AAA68-3925-4B51-B41D-8111C1EA82FA}']
    procedure BuildPerimeterZone; dispid 1;
  end;

// *********************************************************************//
// The Class CoFMDocument provides a Create and CreateRemote method to          
// create instances of the default interface IFMDocument exposed by              
// the CoClass FMDocument. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFMDocument = class
    class function Create: IFMDocument;
    class function CreateRemote(const MachineName: string): IFMDocument;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TFMDocument
// Help String      : FMDocument Object
// Default Interface: IFMDocument
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TFMDocumentProperties= class;
{$ENDIF}
  TFMDocument = class(TOleServer)
  private
    FIntf:        IFMDocument;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TFMDocumentProperties;
    function      GetServerProperties: TFMDocumentProperties;
{$ENDIF}
    function      GetDefaultInterface: IFMDocument;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IFMDocument);
    procedure Disconnect; override;
    procedure BuildPerimeterZone;
    property DefaultInterface: IFMDocument read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TFMDocumentProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TFMDocument
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TFMDocumentProperties = class(TPersistent)
  private
    FServer:    TFMDocument;
    function    GetDefaultInterface: IFMDocument;
    constructor Create(AServer: TFMDocument);
  protected
  public
    property DefaultInterface: IFMDocument read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoFMDocument.Create: IFMDocument;
begin
  Result := CreateComObject(CLASS_FMDocument) as IFMDocument;
end;

class function CoFMDocument.CreateRemote(const MachineName: string): IFMDocument;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FMDocument) as IFMDocument;
end;

procedure TFMDocument.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{CD03FC56-20EE-438A-ACEA-C9C279D4ADDE}';
    IntfIID:   '{F38AAA68-3925-4B51-B41D-8111C1EA82FA}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TFMDocument.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IFMDocument;
  end;
end;

procedure TFMDocument.ConnectTo(svrIntf: IFMDocument);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TFMDocument.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TFMDocument.GetDefaultInterface: IFMDocument;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TFMDocument.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TFMDocumentProperties.Create(Self);
{$ENDIF}
end;

destructor TFMDocument.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TFMDocument.GetServerProperties: TFMDocumentProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TFMDocument.BuildPerimeterZone;
begin
  DefaultInterface.BuildPerimeterZone;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TFMDocumentProperties.Create(AServer: TFMDocument);
begin
  inherited Create;
  FServer := AServer;
end;

function TFMDocumentProperties.GetDefaultInterface: IFMDocument;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TFMDocument]);
end;

end.
