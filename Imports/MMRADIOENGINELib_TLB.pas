unit MMRADIOENGINELib_TLB;

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
// File generated on 23.01.04 22:58:02 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\PROGRAM FILES\MUSICMATCH\MUSICMATCH JUKEBOX\MMRADIOENGINE.DLL (1)
// LIBID: {0C5D39A3-460B-11D4-ADE1-0050DACD3DB9}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TRadioEngineObj) : Server C:\PROGRAM FILES\MUSICMATCH\MUSICMATCH JUKEBOX\MMRADIOENGINE.DLL contains no icons
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
  MMRADIOENGINELibMajorVersion = 1;
  MMRADIOENGINELibMinorVersion = 0;

  LIBID_MMRADIOENGINELib: TGUID = '{0C5D39A3-460B-11D4-ADE1-0050DACD3DB9}';

  IID_IRadioEngine: TGUID = '{0C5D39AF-460B-11D4-ADE1-0050DACD3DB9}';
  CLASS_RadioEngineObj: TGUID = '{0C5D39B0-460B-11D4-ADE1-0050DACD3DB9}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IRadioEngine = interface;
  IRadioEngineDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  RadioEngineObj = IRadioEngine;


// *********************************************************************//
// Interface: IRadioEngine
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0C5D39AF-460B-11D4-ADE1-0050DACD3DB9}
// *********************************************************************//
  IRadioEngine = interface(IDispatch)
    ['{0C5D39AF-460B-11D4-ADE1-0050DACD3DB9}']
    procedure ChangeStation(const strStationID: WideString); safecall;
    procedure StartSession(const strStationID: WideString; const strStatioName: WideString; 
                           const strAudioFormatDesc: WideString; const strClientCaps: WideString; 
                           const strUserInfo: WideString; pFuncStatusCallback: Integer); safecall;
    procedure RefreshSequence(const strAudiFormat: WideString; const strUserInfo: WideString); safecall;
    procedure StopSession; safecall;
    procedure OpenStream(nTrackID: SYSINT); safecall;
    function GetStreamBitRate: SYSINT; safecall;
    function GetStreamTotalSizeBytes: SYSINT; safecall;
    function GetStreamNumChannels: SYSINT; safecall;
    function GetStreamFrequency: Integer; safecall;
    procedure ReadStream(lBytesToRead: Integer; plBuffer: Integer; out pStatus: SYSINT; 
                         out pBytesRead: Integer); safecall;
    procedure CloseStream; safecall;
    function GetNextTrackID: SYSINT; safecall;
    function GetTrackName(nTrackID: SYSINT): WideString; safecall;
    function GetArtistName(nTrackID: SYSINT): WideString; safecall;
    function GetAlbumName(nTrackID: SYSINT): WideString; safecall;
    function GetClipUrl(nTrackID: SYSINT): WideString; safecall;
    function GetSkippable(nTrackID: SYSINT): Integer; safecall;
    function GetDisplayDelay(nTrackID: SYSINT): SYSINT; safecall;
    function GetArtUrl(nTrackID: SYSINT): WideString; safecall;
    procedure AckNotified(nMessage: SYSINT); safecall;
    function GetTrackUrl(nTrackID: SYSINT): WideString; safecall;
    function GetWebUrl(nTrackID: SYSINT): WideString; safecall;
    function GetText(nTrackID: SYSINT): WideString; safecall;
    function GetAFD(nTrackID: SYSINT): WideString; safecall;
    function GetQuality(nTrackID: SYSINT): WideString; safecall;
    function GetBrowserStr(nTrackID: SYSINT): WideString; safecall;
    function GetStreamFormat: WideString; safecall;
    function GetRadioCacheStatus(out pfMaxSize: Double; out pfSafetyMargin: Double; 
                                 out pfCurSize: Double): SYSINT; safecall;
    procedure SetRadioCacheStatus(fMaxSize: Double; fSafetyMargin: Double); safecall;
    function GetAlbumID(nTrackID: SYSINT): SYSINT; safecall;
    function GetArtistID(nTrackID: SYSINT): SYSINT; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRadioEngineDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0C5D39AF-460B-11D4-ADE1-0050DACD3DB9}
// *********************************************************************//
  IRadioEngineDisp = dispinterface
    ['{0C5D39AF-460B-11D4-ADE1-0050DACD3DB9}']
    procedure ChangeStation(const strStationID: WideString); dispid 1;
    procedure StartSession(const strStationID: WideString; const strStatioName: WideString; 
                           const strAudioFormatDesc: WideString; const strClientCaps: WideString; 
                           const strUserInfo: WideString; pFuncStatusCallback: Integer); dispid 2;
    procedure RefreshSequence(const strAudiFormat: WideString; const strUserInfo: WideString); dispid 3;
    procedure StopSession; dispid 4;
    procedure OpenStream(nTrackID: SYSINT); dispid 5;
    function GetStreamBitRate: SYSINT; dispid 6;
    function GetStreamTotalSizeBytes: SYSINT; dispid 7;
    function GetStreamNumChannels: SYSINT; dispid 8;
    function GetStreamFrequency: Integer; dispid 9;
    procedure ReadStream(lBytesToRead: Integer; plBuffer: Integer; out pStatus: SYSINT; 
                         out pBytesRead: Integer); dispid 10;
    procedure CloseStream; dispid 11;
    function GetNextTrackID: SYSINT; dispid 12;
    function GetTrackName(nTrackID: SYSINT): WideString; dispid 13;
    function GetArtistName(nTrackID: SYSINT): WideString; dispid 14;
    function GetAlbumName(nTrackID: SYSINT): WideString; dispid 15;
    function GetClipUrl(nTrackID: SYSINT): WideString; dispid 16;
    function GetSkippable(nTrackID: SYSINT): Integer; dispid 17;
    function GetDisplayDelay(nTrackID: SYSINT): SYSINT; dispid 18;
    function GetArtUrl(nTrackID: SYSINT): WideString; dispid 19;
    procedure AckNotified(nMessage: SYSINT); dispid 20;
    function GetTrackUrl(nTrackID: SYSINT): WideString; dispid 21;
    function GetWebUrl(nTrackID: SYSINT): WideString; dispid 22;
    function GetText(nTrackID: SYSINT): WideString; dispid 23;
    function GetAFD(nTrackID: SYSINT): WideString; dispid 24;
    function GetQuality(nTrackID: SYSINT): WideString; dispid 25;
    function GetBrowserStr(nTrackID: SYSINT): WideString; dispid 26;
    function GetStreamFormat: WideString; dispid 27;
    function GetRadioCacheStatus(out pfMaxSize: Double; out pfSafetyMargin: Double; 
                                 out pfCurSize: Double): SYSINT; dispid 28;
    procedure SetRadioCacheStatus(fMaxSize: Double; fSafetyMargin: Double); dispid 29;
    function GetAlbumID(nTrackID: SYSINT): SYSINT; dispid 31;
    function GetArtistID(nTrackID: SYSINT): SYSINT; dispid 30;
  end;

// *********************************************************************//
// The Class CoRadioEngineObj provides a Create and CreateRemote method to          
// create instances of the default interface IRadioEngine exposed by              
// the CoClass RadioEngineObj. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRadioEngineObj = class
    class function Create: IRadioEngine;
    class function CreateRemote(const MachineName: string): IRadioEngine;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRadioEngineObj
// Help String      : RadioEngineObj Class
// Default Interface: IRadioEngine
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TRadioEngineObjProperties= class;
{$ENDIF}
  TRadioEngineObj = class(TOleServer)
  private
    FIntf:        IRadioEngine;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TRadioEngineObjProperties;
    function      GetServerProperties: TRadioEngineObjProperties;
{$ENDIF}
    function      GetDefaultInterface: IRadioEngine;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IRadioEngine);
    procedure Disconnect; override;
    procedure ChangeStation(const strStationID: WideString);
    procedure StartSession(const strStationID: WideString; const strStatioName: WideString; 
                           const strAudioFormatDesc: WideString; const strClientCaps: WideString; 
                           const strUserInfo: WideString; pFuncStatusCallback: Integer);
    procedure RefreshSequence(const strAudiFormat: WideString; const strUserInfo: WideString);
    procedure StopSession;
    procedure OpenStream(nTrackID: SYSINT);
    function GetStreamBitRate: SYSINT;
    function GetStreamTotalSizeBytes: SYSINT;
    function GetStreamNumChannels: SYSINT;
    function GetStreamFrequency: Integer;
    procedure ReadStream(lBytesToRead: Integer; plBuffer: Integer; out pStatus: SYSINT; 
                         out pBytesRead: Integer);
    procedure CloseStream;
    function GetNextTrackID: SYSINT;
    function GetTrackName(nTrackID: SYSINT): WideString;
    function GetArtistName(nTrackID: SYSINT): WideString;
    function GetAlbumName(nTrackID: SYSINT): WideString;
    function GetClipUrl(nTrackID: SYSINT): WideString;
    function GetSkippable(nTrackID: SYSINT): Integer;
    function GetDisplayDelay(nTrackID: SYSINT): SYSINT;
    function GetArtUrl(nTrackID: SYSINT): WideString;
    procedure AckNotified(nMessage: SYSINT);
    function GetTrackUrl(nTrackID: SYSINT): WideString;
    function GetWebUrl(nTrackID: SYSINT): WideString;
    function GetText(nTrackID: SYSINT): WideString;
    function GetAFD(nTrackID: SYSINT): WideString;
    function GetQuality(nTrackID: SYSINT): WideString;
    function GetBrowserStr(nTrackID: SYSINT): WideString;
    function GetStreamFormat: WideString;
    function GetRadioCacheStatus(out pfMaxSize: Double; out pfSafetyMargin: Double; 
                                 out pfCurSize: Double): SYSINT;
    procedure SetRadioCacheStatus(fMaxSize: Double; fSafetyMargin: Double);
    function GetAlbumID(nTrackID: SYSINT): SYSINT;
    function GetArtistID(nTrackID: SYSINT): SYSINT;
    property DefaultInterface: IRadioEngine read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TRadioEngineObjProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TRadioEngineObj
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TRadioEngineObjProperties = class(TPersistent)
  private
    FServer:    TRadioEngineObj;
    function    GetDefaultInterface: IRadioEngine;
    constructor Create(AServer: TRadioEngineObj);
  protected
  public
    property DefaultInterface: IRadioEngine read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoRadioEngineObj.Create: IRadioEngine;
begin
  Result := CreateComObject(CLASS_RadioEngineObj) as IRadioEngine;
end;

class function CoRadioEngineObj.CreateRemote(const MachineName: string): IRadioEngine;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RadioEngineObj) as IRadioEngine;
end;

procedure TRadioEngineObj.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0C5D39B0-460B-11D4-ADE1-0050DACD3DB9}';
    IntfIID:   '{0C5D39AF-460B-11D4-ADE1-0050DACD3DB9}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRadioEngineObj.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IRadioEngine;
  end;
end;

procedure TRadioEngineObj.ConnectTo(svrIntf: IRadioEngine);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRadioEngineObj.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRadioEngineObj.GetDefaultInterface: IRadioEngine;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TRadioEngineObj.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TRadioEngineObjProperties.Create(Self);
{$ENDIF}
end;

destructor TRadioEngineObj.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TRadioEngineObj.GetServerProperties: TRadioEngineObjProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TRadioEngineObj.ChangeStation(const strStationID: WideString);
begin
  DefaultInterface.ChangeStation(strStationID);
end;

procedure TRadioEngineObj.StartSession(const strStationID: WideString; 
                                       const strStatioName: WideString; 
                                       const strAudioFormatDesc: WideString; 
                                       const strClientCaps: WideString; 
                                       const strUserInfo: WideString; pFuncStatusCallback: Integer);
begin
  DefaultInterface.StartSession(strStationID, strStatioName, strAudioFormatDesc, strClientCaps, 
                                strUserInfo, pFuncStatusCallback);
end;

procedure TRadioEngineObj.RefreshSequence(const strAudiFormat: WideString; 
                                          const strUserInfo: WideString);
begin
  DefaultInterface.RefreshSequence(strAudiFormat, strUserInfo);
end;

procedure TRadioEngineObj.StopSession;
begin
  DefaultInterface.StopSession;
end;

procedure TRadioEngineObj.OpenStream(nTrackID: SYSINT);
begin
  DefaultInterface.OpenStream(nTrackID);
end;

function TRadioEngineObj.GetStreamBitRate: SYSINT;
begin
  Result := DefaultInterface.GetStreamBitRate;
end;

function TRadioEngineObj.GetStreamTotalSizeBytes: SYSINT;
begin
  Result := DefaultInterface.GetStreamTotalSizeBytes;
end;

function TRadioEngineObj.GetStreamNumChannels: SYSINT;
begin
  Result := DefaultInterface.GetStreamNumChannels;
end;

function TRadioEngineObj.GetStreamFrequency: Integer;
begin
  Result := DefaultInterface.GetStreamFrequency;
end;

procedure TRadioEngineObj.ReadStream(lBytesToRead: Integer; plBuffer: Integer; out pStatus: SYSINT; 
                                     out pBytesRead: Integer);
begin
  DefaultInterface.ReadStream(lBytesToRead, plBuffer, pStatus, pBytesRead);
end;

procedure TRadioEngineObj.CloseStream;
begin
  DefaultInterface.CloseStream;
end;

function TRadioEngineObj.GetNextTrackID: SYSINT;
begin
  Result := DefaultInterface.GetNextTrackID;
end;

function TRadioEngineObj.GetTrackName(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetTrackName(nTrackID);
end;

function TRadioEngineObj.GetArtistName(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetArtistName(nTrackID);
end;

function TRadioEngineObj.GetAlbumName(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetAlbumName(nTrackID);
end;

function TRadioEngineObj.GetClipUrl(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetClipUrl(nTrackID);
end;

function TRadioEngineObj.GetSkippable(nTrackID: SYSINT): Integer;
begin
  Result := DefaultInterface.GetSkippable(nTrackID);
end;

function TRadioEngineObj.GetDisplayDelay(nTrackID: SYSINT): SYSINT;
begin
  Result := DefaultInterface.GetDisplayDelay(nTrackID);
end;

function TRadioEngineObj.GetArtUrl(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetArtUrl(nTrackID);
end;

procedure TRadioEngineObj.AckNotified(nMessage: SYSINT);
begin
  DefaultInterface.AckNotified(nMessage);
end;

function TRadioEngineObj.GetTrackUrl(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetTrackUrl(nTrackID);
end;

function TRadioEngineObj.GetWebUrl(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetWebUrl(nTrackID);
end;

function TRadioEngineObj.GetText(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetText(nTrackID);
end;

function TRadioEngineObj.GetAFD(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetAFD(nTrackID);
end;

function TRadioEngineObj.GetQuality(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetQuality(nTrackID);
end;

function TRadioEngineObj.GetBrowserStr(nTrackID: SYSINT): WideString;
begin
  Result := DefaultInterface.GetBrowserStr(nTrackID);
end;

function TRadioEngineObj.GetStreamFormat: WideString;
begin
  Result := DefaultInterface.GetStreamFormat;
end;

function TRadioEngineObj.GetRadioCacheStatus(out pfMaxSize: Double; out pfSafetyMargin: Double; 
                                             out pfCurSize: Double): SYSINT;
begin
  Result := DefaultInterface.GetRadioCacheStatus(pfMaxSize, pfSafetyMargin, pfCurSize);
end;

procedure TRadioEngineObj.SetRadioCacheStatus(fMaxSize: Double; fSafetyMargin: Double);
begin
  DefaultInterface.SetRadioCacheStatus(fMaxSize, fSafetyMargin);
end;

function TRadioEngineObj.GetAlbumID(nTrackID: SYSINT): SYSINT;
begin
  Result := DefaultInterface.GetAlbumID(nTrackID);
end;

function TRadioEngineObj.GetArtistID(nTrackID: SYSINT): SYSINT;
begin
  Result := DefaultInterface.GetArtistID(nTrackID);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TRadioEngineObjProperties.Create(AServer: TRadioEngineObj);
begin
  inherited Create;
  FServer := AServer;
end;

function TRadioEngineObjProperties.GetDefaultInterface: IRadioEngine;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TRadioEngineObj]);
end;

end.
