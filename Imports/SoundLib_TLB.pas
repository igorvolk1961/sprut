unit SoundLib_TLB;

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
// File generated on 23.01.04 23:02:26 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\PROGRAM FILES\MPLAYER\SYSTEM\SOUND.OCX (1)
// LIBID: {DFBFC963-D71B-11CE-AF7E-444553540000}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
// Errors:
//   Hint: Parameter 'string' of _DSound.DiagnosticWindow changed to 'string_'
// ************************************************************************ //
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
  SoundLibMajorVersion = 1;
  SoundLibMinorVersion = 0;

  LIBID_SoundLib: TGUID = '{DFBFC963-D71B-11CE-AF7E-444553540000}';

  DIID__DSound: TGUID = '{DFBFC961-D71B-11CE-AF7E-444553540000}';
  DIID__DSoundEvents: TGUID = '{DFBFC962-D71B-11CE-AF7E-444553540000}';
  CLASS_Sound: TGUID = '{DFBFC960-D71B-11CE-AF7E-444553540000}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DSound = dispinterface;
  _DSoundEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Sound = _DSound;


// *********************************************************************//
// DispIntf:  _DSound
// Flags:     (4112) Hidden Dispatchable
// GUID:      {DFBFC961-D71B-11CE-AF7E-444553540000}
// *********************************************************************//
  _DSound = dispinterface
    ['{DFBFC961-D71B-11CE-AF7E-444553540000}']
    property GulpName: WideString dispid 1;
    property Broadcast: WordBool dispid 2;
    property CodecType: Smallint dispid 3;
    function IsPlaying: WordBool; dispid 4;
    function IsReceiving: WordBool; dispid 5;
    function IsRecording: WordBool; dispid 6;
    function IsSoundWaiting: WordBool; dispid 7;
    function StartPlay(wOptions: Smallint): WordBool; dispid 8;
    function StartReceive: WordBool; dispid 9;
    function StartRecord: WordBool; dispid 10;
    function StopPlay: WordBool; dispid 11;
    function StopReceive: WordBool; dispid 12;
    function StopRecord: WordBool; dispid 13;
    function Attach(Game: Smallint): WordBool; dispid 14;
    function InsertPlayer(a_lPlayer: Integer): WordBool; dispid 15;
    function RemovePlayer(a_lPlayer: Integer): WordBool; dispid 16;
    function Detach: WordBool; dispid 17;
    function RemoveAllPlayers: WordBool; dispid 18;
    function PlayWaveFile(sync: Integer; override: Integer; const fileName: WideString): Integer; dispid 19;
    function DiagnosticWindow(command: Integer; const string_: WideString): Integer; dispid 20;
    function SetMicPreAmp(level: Integer): Integer; dispid 21;
    function SetSoundPath(const path: WideString): Integer; dispid 22;
    function EnableVUMeter(status: Integer; hWnd: Integer): Integer; dispid 23;
    function Clear: Integer; dispid 24;
    function EnableSpamControl(cmd: Integer; maxSpeechSeconds: Integer; pauseSeconds: Integer): Integer; dispid 25;
    function IsSpamRecharging: Integer; dispid 26;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  _DSoundEvents
// Flags:     (4096) Dispatchable
// GUID:      {DFBFC962-D71B-11CE-AF7E-444553540000}
// *********************************************************************//
  _DSoundEvents = dispinterface
    ['{DFBFC962-D71B-11CE-AF7E-444553540000}']
    procedure OnBeginPhrase(Player: Integer); dispid 1;
    procedure OnEndPhrase(Player: Integer); dispid 2;
    procedure OnAdvisory(cmd: Integer; arg1: Integer; arg2: Integer; const msg: WideString); dispid 3;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TSound
// Help String      : Sound Control
// Default Interface: _DSound
// Def. Intf. DISP? : Yes
// Event   Interface: _DSoundEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TSoundOnBeginPhrase = procedure(Sender: TObject; Player: Integer) of object;
  TSoundOnEndPhrase = procedure(Sender: TObject; Player: Integer) of object;
  TSoundOnAdvisory = procedure(Sender: TObject; cmd: Integer; arg1: Integer; arg2: Integer; 
                                                const msg: WideString) of object;

  TSound = class(TOleControl)
  private
    FOnBeginPhrase: TSoundOnBeginPhrase;
    FOnEndPhrase: TSoundOnEndPhrase;
    FOnAdvisory: TSoundOnAdvisory;
    FIntf: _DSound;
    function  GetControlInterface: _DSound;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function IsPlaying: WordBool;
    function IsReceiving: WordBool;
    function IsRecording: WordBool;
    function IsSoundWaiting: WordBool;
    function StartPlay(wOptions: Smallint): WordBool;
    function StartReceive: WordBool;
    function StartRecord: WordBool;
    function StopPlay: WordBool;
    function StopReceive: WordBool;
    function StopRecord: WordBool;
    function Attach(Game: Smallint): WordBool;
    function InsertPlayer(a_lPlayer: Integer): WordBool;
    function RemovePlayer(a_lPlayer: Integer): WordBool;
    function Detach: WordBool;
    function RemoveAllPlayers: WordBool;
    function PlayWaveFile(sync: Integer; override: Integer; const fileName: WideString): Integer;
    function DiagnosticWindow(command: Integer; const string_: WideString): Integer;
    function SetMicPreAmp(level: Integer): Integer;
    function SetSoundPath(const path: WideString): Integer;
    function EnableVUMeter(status: Integer; hWnd: Integer): Integer;
    function Clear: Integer;
    function EnableSpamControl(cmd: Integer; maxSpeechSeconds: Integer; pauseSeconds: Integer): Integer;
    function IsSpamRecharging: Integer;
    procedure AboutBox;
    property  ControlInterface: _DSound read GetControlInterface;
    property  DefaultInterface: _DSound read GetControlInterface;
  published
    property GulpName: WideString index 1 read GetWideStringProp write SetWideStringProp stored False;
    property Broadcast: WordBool index 2 read GetWordBoolProp write SetWordBoolProp stored False;
    property CodecType: Smallint index 3 read GetSmallintProp write SetSmallintProp stored False;
    property OnBeginPhrase: TSoundOnBeginPhrase read FOnBeginPhrase write FOnBeginPhrase;
    property OnEndPhrase: TSoundOnEndPhrase read FOnEndPhrase write FOnEndPhrase;
    property OnAdvisory: TSoundOnAdvisory read FOnAdvisory write FOnAdvisory;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TSound.InitControlData;
const
  CEventDispIDs: array [0..2] of DWORD = (
    $00000001, $00000002, $00000003);
  CControlData: TControlData2 = (
    ClassID: '{DFBFC960-D71B-11CE-AF7E-444553540000}';
    EventIID: '{DFBFC962-D71B-11CE-AF7E-444553540000}';
    EventCount: 3;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80040112*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnBeginPhrase) - Cardinal(Self);
end;

procedure TSound.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DSound;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TSound.GetControlInterface: _DSound;
begin
  CreateControl;
  Result := FIntf;
end;

function TSound.IsPlaying: WordBool;
begin
  Result := DefaultInterface.IsPlaying;
end;

function TSound.IsReceiving: WordBool;
begin
  Result := DefaultInterface.IsReceiving;
end;

function TSound.IsRecording: WordBool;
begin
  Result := DefaultInterface.IsRecording;
end;

function TSound.IsSoundWaiting: WordBool;
begin
  Result := DefaultInterface.IsSoundWaiting;
end;

function TSound.StartPlay(wOptions: Smallint): WordBool;
begin
  Result := DefaultInterface.StartPlay(wOptions);
end;

function TSound.StartReceive: WordBool;
begin
  Result := DefaultInterface.StartReceive;
end;

function TSound.StartRecord: WordBool;
begin
  Result := DefaultInterface.StartRecord;
end;

function TSound.StopPlay: WordBool;
begin
  Result := DefaultInterface.StopPlay;
end;

function TSound.StopReceive: WordBool;
begin
  Result := DefaultInterface.StopReceive;
end;

function TSound.StopRecord: WordBool;
begin
  Result := DefaultInterface.StopRecord;
end;

function TSound.Attach(Game: Smallint): WordBool;
begin
  Result := DefaultInterface.Attach(Game);
end;

function TSound.InsertPlayer(a_lPlayer: Integer): WordBool;
begin
  Result := DefaultInterface.InsertPlayer(a_lPlayer);
end;

function TSound.RemovePlayer(a_lPlayer: Integer): WordBool;
begin
  Result := DefaultInterface.RemovePlayer(a_lPlayer);
end;

function TSound.Detach: WordBool;
begin
  Result := DefaultInterface.Detach;
end;

function TSound.RemoveAllPlayers: WordBool;
begin
  Result := DefaultInterface.RemoveAllPlayers;
end;

function TSound.PlayWaveFile(sync: Integer; override: Integer; const fileName: WideString): Integer;
begin
  Result := DefaultInterface.PlayWaveFile(sync, override, fileName);
end;

function TSound.DiagnosticWindow(command: Integer; const string_: WideString): Integer;
begin
  Result := DefaultInterface.DiagnosticWindow(command, string_);
end;

function TSound.SetMicPreAmp(level: Integer): Integer;
begin
  Result := DefaultInterface.SetMicPreAmp(level);
end;

function TSound.SetSoundPath(const path: WideString): Integer;
begin
  Result := DefaultInterface.SetSoundPath(path);
end;

function TSound.EnableVUMeter(status: Integer; hWnd: Integer): Integer;
begin
  Result := DefaultInterface.EnableVUMeter(status, hWnd);
end;

function TSound.Clear: Integer;
begin
  Result := DefaultInterface.Clear;
end;

function TSound.EnableSpamControl(cmd: Integer; maxSpeechSeconds: Integer; pauseSeconds: Integer): Integer;
begin
  Result := DefaultInterface.EnableSpamControl(cmd, maxSpeechSeconds, pauseSeconds);
end;

function TSound.IsSpamRecharging: Integer;
begin
  Result := DefaultInterface.IsSpamRecharging;
end;

procedure TSound.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TSound]);
end;

end.
