unit HTTSLib_TLB;

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
// File generated on 24.01.04 0:59:35 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\WINDOWS\speech\Vtext.dll (1)
// LIBID: {2398E321-5C6E-11D1-8C65-0060081841DE}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\stdvcl40.dll)
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
  HTTSLibMajorVersion = 1;
  HTTSLibMinorVersion = 0;

  LIBID_HTTSLib: TGUID = '{2398E321-5C6E-11D1-8C65-0060081841DE}';

  DIID__TextToSpeechEvents: TGUID = '{2398E331-5C6E-11D1-8C65-0060081841DE}';
  IID_ITextToSpeech: TGUID = '{2398E32E-5C6E-11D1-8C65-0060081841DE}';
  CLASS_TextToSpeech: TGUID = '{2398E32F-5C6E-11D1-8C65-0060081841DE}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _TextToSpeechEvents = dispinterface;
  ITextToSpeech = interface;
  ITextToSpeechDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  TextToSpeech = ITextToSpeech;


// *********************************************************************//
// DispIntf:  _TextToSpeechEvents
// Flags:     (4096) Dispatchable
// GUID:      {2398E331-5C6E-11D1-8C65-0060081841DE}
// *********************************************************************//
  _TextToSpeechEvents = dispinterface
    ['{2398E331-5C6E-11D1-8C65-0060081841DE}']
    procedure ClickIn(x: Integer; y: Integer); dispid 1;
    procedure ClickOut(x: Integer; y: Integer); dispid 2;
    procedure AttribChanged(attrib: Integer); dispid 3;
    procedure SpeakingStarted; dispid 4;
    procedure SpeakingDone; dispid 5;
    procedure Speak(const Text: WideString; const App: WideString; thetype: Integer); dispid 6;
    procedure Visual(Phoneme: Smallint; EnginePhoneme: Smallint; hints: Integer; 
                     MouthHeight: Smallint; bMouthWidth: Smallint; bMouthUpturn: Smallint; 
                     bJawOpen: Smallint; TeethUpperVisible: Smallint; TeethLowerVisible: Smallint; 
                     TonguePosn: Smallint; LipTension: Smallint); dispid 7;
  end;

// *********************************************************************//
// Interface: ITextToSpeech
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2398E32E-5C6E-11D1-8C65-0060081841DE}
// *********************************************************************//
  ITextToSpeech = interface(IDispatch)
    ['{2398E32E-5C6E-11D1-8C65-0060081841DE}']
    function Get_initialized: Integer; safecall;
    procedure Set_initialized(pVal: Integer); safecall;
    procedure Speak(const Text: WideString); safecall;
    procedure StopSpeaking; safecall;
    procedure FastForward; safecall;
    procedure Pause; safecall;
    procedure Resume; safecall;
    procedure Rewind; safecall;
    function Get_Device: Integer; safecall;
    procedure Set_Device(pVal: Integer); safecall;
    function Get_Enabled: Integer; safecall;
    procedure Set_Enabled(pVal: Integer); safecall;
    function Get_IsSpeaking: Integer; safecall;
    function Get_Speed: Integer; safecall;
    procedure Set_Speed(pVal: Integer); safecall;
    function Get_TTSMode: WideString; safecall;
    procedure Set_TTSMode(const pVal: WideString); safecall;
    procedure AboutDlg(hWnd: Integer; const title: WideString); safecall;
    procedure GeneralDlg(hWnd: Integer; const title: WideString); safecall;
    procedure LexiconDlg(hWnd: Integer; const title: WideString); safecall;
    procedure TranslateDlg(hWnd: Integer; const title: WideString); safecall;
    function Get_FindEngine(const EngineId: WideString; const MfgName: WideString; 
                            const ProductName: WideString; const ModeID: WideString; 
                            const ModeName: WideString; LanguageID: Integer; 
                            const dialect: WideString; const Speaker: WideString; 
                            const Style: WideString; Gender: Integer; Age: Integer; 
                            Features: Integer; Interfaces: Integer; EngineFeatures: Integer; 
                            RankEngineID: Integer; RankMfgName: Integer; RankProductName: Integer; 
                            RankModeID: Integer; RankModeName: Integer; RankLanguage: Integer; 
                            RankDialect: Integer; RankSpeaker: Integer; RankStyle: Integer; 
                            RankGender: Integer; RankAge: Integer; RankFeatures: Integer; 
                            RankInterfaces: Integer; RankEngineFeatures: Integer): Integer; safecall;
    function Get_CountEngines: Integer; safecall;
    function ModeName(index: SYSINT): WideString; safecall;
    function MfgName(index: SYSINT): WideString; safecall;
    function ProductName(index: SYSINT): WideString; safecall;
    function ModeID(index: SYSINT): WideString; safecall;
    function Speaker(index: SYSINT): WideString; safecall;
    function Style(index: SYSINT): WideString; safecall;
    function Gender(index: SYSINT): Integer; safecall;
    function Age(index: SYSINT): Integer; safecall;
    function Features(index: SYSINT): Integer; safecall;
    function Interfaces(index: SYSINT): Integer; safecall;
    function EngineFeatures(index: SYSINT): Integer; safecall;
    function LanguageID(index: SYSINT): Integer; safecall;
    function dialect(index: SYSINT): WideString; safecall;
    function Get_MouthHeight: Smallint; safecall;
    procedure Set_MouthHeight(pVal: Smallint); safecall;
    function Get_MouthWidth: Smallint; safecall;
    procedure Set_MouthWidth(pVal: Smallint); safecall;
    function Get_MouthUpturn: Smallint; safecall;
    procedure Set_MouthUpturn(pVal: Smallint); safecall;
    function Get_JawOpen: Smallint; safecall;
    procedure Set_JawOpen(pVal: Smallint); safecall;
    function Get_TeethUpperVisible: Smallint; safecall;
    procedure Set_TeethUpperVisible(pVal: Smallint); safecall;
    function Get_TeethLowerVisible: Smallint; safecall;
    procedure Set_TeethLowerVisible(pVal: Smallint); safecall;
    function Get_TonguePosn: Smallint; safecall;
    procedure Set_TonguePosn(pVal: Smallint); safecall;
    function Get_LipTension: Smallint; safecall;
    procedure Set_LipTension(pVal: Smallint); safecall;
    function Get_LastError: Integer; safecall;
    procedure Set_LastError(pVal: Integer); safecall;
    function Get_SuppressExceptions: Smallint; safecall;
    procedure Set_SuppressExceptions(pVal: Smallint); safecall;
    procedure Select(index: Integer); safecall;
    function Get_LipType: Smallint; safecall;
    procedure Set_LipType(pVal: Smallint); safecall;
    function Get_CurrentMode: Integer; safecall;
    procedure Set_CurrentMode(pVal: Integer); safecall;
    function Get_hWnd: Integer; safecall;
    function Find(const RankList: WideString): Integer; safecall;
    property initialized: Integer read Get_initialized write Set_initialized;
    property Device: Integer read Get_Device write Set_Device;
    property Enabled: Integer read Get_Enabled write Set_Enabled;
    property IsSpeaking: Integer read Get_IsSpeaking;
    property Speed: Integer read Get_Speed write Set_Speed;
    property TTSMode: WideString read Get_TTSMode write Set_TTSMode;
    property FindEngine[const EngineId: WideString; const MfgName: WideString; 
                        const ProductName: WideString; const ModeID: WideString; 
                        const ModeName: WideString; LanguageID: Integer; const dialect: WideString; 
                        const Speaker: WideString; const Style: WideString; Gender: Integer; 
                        Age: Integer; Features: Integer; Interfaces: Integer; 
                        EngineFeatures: Integer; RankEngineID: Integer; RankMfgName: Integer; 
                        RankProductName: Integer; RankModeID: Integer; RankModeName: Integer; 
                        RankLanguage: Integer; RankDialect: Integer; RankSpeaker: Integer; 
                        RankStyle: Integer; RankGender: Integer; RankAge: Integer; 
                        RankFeatures: Integer; RankInterfaces: Integer; RankEngineFeatures: Integer]: Integer read Get_FindEngine;
    property CountEngines: Integer read Get_CountEngines;
    property MouthHeight: Smallint read Get_MouthHeight write Set_MouthHeight;
    property MouthWidth: Smallint read Get_MouthWidth write Set_MouthWidth;
    property MouthUpturn: Smallint read Get_MouthUpturn write Set_MouthUpturn;
    property JawOpen: Smallint read Get_JawOpen write Set_JawOpen;
    property TeethUpperVisible: Smallint read Get_TeethUpperVisible write Set_TeethUpperVisible;
    property TeethLowerVisible: Smallint read Get_TeethLowerVisible write Set_TeethLowerVisible;
    property TonguePosn: Smallint read Get_TonguePosn write Set_TonguePosn;
    property LipTension: Smallint read Get_LipTension write Set_LipTension;
    property LastError: Integer read Get_LastError write Set_LastError;
    property SuppressExceptions: Smallint read Get_SuppressExceptions write Set_SuppressExceptions;
    property LipType: Smallint read Get_LipType write Set_LipType;
    property CurrentMode: Integer read Get_CurrentMode write Set_CurrentMode;
    property hWnd: Integer read Get_hWnd;
  end;

// *********************************************************************//
// DispIntf:  ITextToSpeechDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2398E32E-5C6E-11D1-8C65-0060081841DE}
// *********************************************************************//
  ITextToSpeechDisp = dispinterface
    ['{2398E32E-5C6E-11D1-8C65-0060081841DE}']
    property initialized: Integer dispid 1;
    procedure Speak(const Text: WideString); dispid 2;
    procedure StopSpeaking; dispid 3;
    procedure FastForward; dispid 4;
    procedure Pause; dispid 5;
    procedure Resume; dispid 6;
    procedure Rewind; dispid 7;
    property Device: Integer dispid 8;
    property Enabled: Integer dispid 9;
    property IsSpeaking: Integer readonly dispid 10;
    property Speed: Integer dispid 11;
    property TTSMode: WideString dispid 12;
    procedure AboutDlg(hWnd: Integer; const title: WideString); dispid 13;
    procedure GeneralDlg(hWnd: Integer; const title: WideString); dispid 14;
    procedure LexiconDlg(hWnd: Integer; const title: WideString); dispid 15;
    procedure TranslateDlg(hWnd: Integer; const title: WideString); dispid 16;
    property FindEngine[const EngineId: WideString; const MfgName: WideString; 
                        const ProductName: WideString; const ModeID: WideString; 
                        const ModeName: WideString; LanguageID: Integer; const dialect: WideString; 
                        const Speaker: WideString; const Style: WideString; Gender: Integer; 
                        Age: Integer; Features: Integer; Interfaces: Integer; 
                        EngineFeatures: Integer; RankEngineID: Integer; RankMfgName: Integer; 
                        RankProductName: Integer; RankModeID: Integer; RankModeName: Integer; 
                        RankLanguage: Integer; RankDialect: Integer; RankSpeaker: Integer; 
                        RankStyle: Integer; RankGender: Integer; RankAge: Integer; 
                        RankFeatures: Integer; RankInterfaces: Integer; RankEngineFeatures: Integer]: Integer readonly dispid 17;
    property CountEngines: Integer readonly dispid 18;
    function ModeName(index: SYSINT): WideString; dispid 19;
    function MfgName(index: SYSINT): WideString; dispid 20;
    function ProductName(index: SYSINT): WideString; dispid 21;
    function ModeID(index: SYSINT): WideString; dispid 22;
    function Speaker(index: SYSINT): WideString; dispid 23;
    function Style(index: SYSINT): WideString; dispid 24;
    function Gender(index: SYSINT): Integer; dispid 25;
    function Age(index: SYSINT): Integer; dispid 26;
    function Features(index: SYSINT): Integer; dispid 27;
    function Interfaces(index: SYSINT): Integer; dispid 28;
    function EngineFeatures(index: SYSINT): Integer; dispid 29;
    function LanguageID(index: SYSINT): Integer; dispid 30;
    function dialect(index: SYSINT): WideString; dispid 31;
    property MouthHeight: Smallint dispid 49;
    property MouthWidth: Smallint dispid 50;
    property MouthUpturn: Smallint dispid 51;
    property JawOpen: Smallint dispid 52;
    property TeethUpperVisible: Smallint dispid 53;
    property TeethLowerVisible: Smallint dispid 54;
    property TonguePosn: Smallint dispid 55;
    property LipTension: Smallint dispid 56;
    property LastError: Integer dispid 59;
    property SuppressExceptions: Smallint dispid 60;
    procedure Select(index: Integer); dispid 61;
    property LipType: Smallint dispid 62;
    property CurrentMode: Integer dispid 63;
    property hWnd: Integer readonly dispid 64;
    function Find(const RankList: WideString): Integer; dispid 65;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TTextToSpeech
// Help String      : Microsoft Voice Text Class
// Default Interface: ITextToSpeech
// Def. Intf. DISP? : No
// Event   Interface: _TextToSpeechEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TTextToSpeechClickIn = procedure(Sender: TObject; x: Integer; y: Integer) of object;
  TTextToSpeechClickOut = procedure(Sender: TObject; x: Integer; y: Integer) of object;
  TTextToSpeechAttribChanged = procedure(Sender: TObject; attrib: Integer) of object;
  TTextToSpeechSpeak = procedure(Sender: TObject; const Text: WideString; const App: WideString; 
                                                  thetype: Integer) of object;
  TTextToSpeechVisual = procedure(Sender: TObject; Phoneme: Smallint; EnginePhoneme: Smallint; 
                                                   hints: Integer; MouthHeight: Smallint; 
                                                   bMouthWidth: Smallint; bMouthUpturn: Smallint; 
                                                   bJawOpen: Smallint; TeethUpperVisible: Smallint; 
                                                   TeethLowerVisible: Smallint; 
                                                   TonguePosn: Smallint; LipTension: Smallint) of object;

  TTextToSpeech = class(TOleControl)
  private
    FOnClickIn: TTextToSpeechClickIn;
    FOnClickOut: TTextToSpeechClickOut;
    FOnAttribChanged: TTextToSpeechAttribChanged;
    FOnSpeakingStarted: TNotifyEvent;
    FOnSpeakingDone: TNotifyEvent;
    FOnSpeak: TTextToSpeechSpeak;
    FOnVisual: TTextToSpeechVisual;
    FIntf: ITextToSpeech;
    function  GetControlInterface: ITextToSpeech;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_FindEngine(const EngineId: WideString; const MfgName: WideString; 
                            const ProductName: WideString; const ModeID: WideString; 
                            const ModeName: WideString; LanguageID: Integer; 
                            const dialect: WideString; const Speaker: WideString; 
                            const Style: WideString; Gender: Integer; Age: Integer; 
                            Features: Integer; Interfaces: Integer; EngineFeatures: Integer; 
                            RankEngineID: Integer; RankMfgName: Integer; RankProductName: Integer; 
                            RankModeID: Integer; RankModeName: Integer; RankLanguage: Integer; 
                            RankDialect: Integer; RankSpeaker: Integer; RankStyle: Integer; 
                            RankGender: Integer; RankAge: Integer; RankFeatures: Integer; 
                            RankInterfaces: Integer; RankEngineFeatures: Integer): Integer;
  public
    procedure Speak(const Text: WideString);
    procedure StopSpeaking;
    procedure FastForward;
    procedure Pause;
    procedure Resume;
    procedure Rewind;
    procedure AboutDlg(hWnd: Integer; const title: WideString);
    procedure GeneralDlg(hWnd: Integer; const title: WideString);
    procedure LexiconDlg(hWnd: Integer; const title: WideString);
    procedure TranslateDlg(hWnd: Integer; const title: WideString);
    function ModeName(index: SYSINT): WideString;
    function MfgName(index: SYSINT): WideString;
    function ProductName(index: SYSINT): WideString;
    function ModeID(index: SYSINT): WideString;
    function Speaker(index: SYSINT): WideString;
    function Style(index: SYSINT): WideString;
    function Gender(index: SYSINT): Integer;
    function Age(index: SYSINT): Integer;
    function Features(index: SYSINT): Integer;
    function Interfaces(index: SYSINT): Integer;
    function EngineFeatures(index: SYSINT): Integer;
    function LanguageID(index: SYSINT): Integer;
    function dialect(index: SYSINT): WideString;
    procedure Select(index: Integer);
    function Find(const RankList: WideString): Integer;
    property  ControlInterface: ITextToSpeech read GetControlInterface;
    property  DefaultInterface: ITextToSpeech read GetControlInterface;
    property IsSpeaking: Integer index 10 read GetIntegerProp;
    property FindEngine[const EngineId: WideString; const MfgName: WideString; 
                        const ProductName: WideString; const ModeID: WideString; 
                        const ModeName: WideString; LanguageID: Integer; const dialect: WideString; 
                        const Speaker: WideString; const Style: WideString; Gender: Integer; 
                        Age: Integer; Features: Integer; Interfaces: Integer; 
                        EngineFeatures: Integer; RankEngineID: Integer; RankMfgName: Integer; 
                        RankProductName: Integer; RankModeID: Integer; RankModeName: Integer; 
                        RankLanguage: Integer; RankDialect: Integer; RankSpeaker: Integer; 
                        RankStyle: Integer; RankGender: Integer; RankAge: Integer; 
                        RankFeatures: Integer; RankInterfaces: Integer; RankEngineFeatures: Integer]: Integer read Get_FindEngine;
    property CountEngines: Integer index 18 read GetIntegerProp;
    property hWnd: Integer index 64 read GetIntegerProp;
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
    property initialized: Integer index 1 read GetIntegerProp write SetIntegerProp stored False;
    property Device: Integer index 8 read GetIntegerProp write SetIntegerProp stored False;
    property Enabled: Integer index 9 read GetIntegerProp write SetIntegerProp stored False;
    property Speed: Integer index 11 read GetIntegerProp write SetIntegerProp stored False;
    property TTSMode: WideString index 12 read GetWideStringProp write SetWideStringProp stored False;
    property MouthHeight: Smallint index 49 read GetSmallintProp write SetSmallintProp stored False;
    property MouthWidth: Smallint index 50 read GetSmallintProp write SetSmallintProp stored False;
    property MouthUpturn: Smallint index 51 read GetSmallintProp write SetSmallintProp stored False;
    property JawOpen: Smallint index 52 read GetSmallintProp write SetSmallintProp stored False;
    property TeethUpperVisible: Smallint index 53 read GetSmallintProp write SetSmallintProp stored False;
    property TeethLowerVisible: Smallint index 54 read GetSmallintProp write SetSmallintProp stored False;
    property TonguePosn: Smallint index 55 read GetSmallintProp write SetSmallintProp stored False;
    property LipTension: Smallint index 56 read GetSmallintProp write SetSmallintProp stored False;
    property LastError: Integer index 59 read GetIntegerProp write SetIntegerProp stored False;
    property SuppressExceptions: Smallint index 60 read GetSmallintProp write SetSmallintProp stored False;
    property LipType: Smallint index 62 read GetSmallintProp write SetSmallintProp stored False;
    property CurrentMode: Integer index 63 read GetIntegerProp write SetIntegerProp stored False;
    property OnClickIn: TTextToSpeechClickIn read FOnClickIn write FOnClickIn;
    property OnClickOut: TTextToSpeechClickOut read FOnClickOut write FOnClickOut;
    property OnAttribChanged: TTextToSpeechAttribChanged read FOnAttribChanged write FOnAttribChanged;
    property OnSpeakingStarted: TNotifyEvent read FOnSpeakingStarted write FOnSpeakingStarted;
    property OnSpeakingDone: TNotifyEvent read FOnSpeakingDone write FOnSpeakingDone;
    property OnSpeak: TTextToSpeechSpeak read FOnSpeak write FOnSpeak;
    property OnVisual: TTextToSpeechVisual read FOnVisual write FOnVisual;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TTextToSpeech.InitControlData;
const
  CEventDispIDs: array [0..6] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005, $00000006,
    $00000007);
  CControlData: TControlData2 = (
    ClassID: '{2398E32F-5C6E-11D1-8C65-0060081841DE}';
    EventIID: '{2398E331-5C6E-11D1-8C65-0060081841DE}';
    EventCount: 7;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80040154*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnClickIn) - Cardinal(Self);
end;

procedure TTextToSpeech.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as ITextToSpeech;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TTextToSpeech.GetControlInterface: ITextToSpeech;
begin
  CreateControl;
  Result := FIntf;
end;

function TTextToSpeech.Get_FindEngine(const EngineId: WideString; const MfgName: WideString; 
                                      const ProductName: WideString; const ModeID: WideString; 
                                      const ModeName: WideString; LanguageID: Integer; 
                                      const dialect: WideString; const Speaker: WideString; 
                                      const Style: WideString; Gender: Integer; Age: Integer; 
                                      Features: Integer; Interfaces: Integer; 
                                      EngineFeatures: Integer; RankEngineID: Integer; 
                                      RankMfgName: Integer; RankProductName: Integer; 
                                      RankModeID: Integer; RankModeName: Integer; 
                                      RankLanguage: Integer; RankDialect: Integer; 
                                      RankSpeaker: Integer; RankStyle: Integer; 
                                      RankGender: Integer; RankAge: Integer; RankFeatures: Integer; 
                                      RankInterfaces: Integer; RankEngineFeatures: Integer): Integer;
begin
    Result := DefaultInterface.FindEngine[EngineId, MfgName, ProductName, ModeID, ModeName, 
                                          LanguageID, dialect, Speaker, Style, Gender, Age, 
                                          Features, Interfaces, EngineFeatures, RankEngineID, 
                                          RankMfgName, RankProductName, RankModeID, RankModeName, 
                                          RankLanguage, RankDialect, RankSpeaker, RankStyle, 
                                          RankGender, RankAge, RankFeatures, RankInterfaces, 
                                          RankEngineFeatures];
end;

procedure TTextToSpeech.Speak(const Text: WideString);
begin
  DefaultInterface.Speak(Text);
end;

procedure TTextToSpeech.StopSpeaking;
begin
  DefaultInterface.StopSpeaking;
end;

procedure TTextToSpeech.FastForward;
begin
  DefaultInterface.FastForward;
end;

procedure TTextToSpeech.Pause;
begin
  DefaultInterface.Pause;
end;

procedure TTextToSpeech.Resume;
begin
  DefaultInterface.Resume;
end;

procedure TTextToSpeech.Rewind;
begin
  DefaultInterface.Rewind;
end;

procedure TTextToSpeech.AboutDlg(hWnd: Integer; const title: WideString);
begin
  DefaultInterface.AboutDlg(hWnd, title);
end;

procedure TTextToSpeech.GeneralDlg(hWnd: Integer; const title: WideString);
begin
  DefaultInterface.GeneralDlg(hWnd, title);
end;

procedure TTextToSpeech.LexiconDlg(hWnd: Integer; const title: WideString);
begin
  DefaultInterface.LexiconDlg(hWnd, title);
end;

procedure TTextToSpeech.TranslateDlg(hWnd: Integer; const title: WideString);
begin
  DefaultInterface.TranslateDlg(hWnd, title);
end;

function TTextToSpeech.ModeName(index: SYSINT): WideString;
begin
  Result := DefaultInterface.ModeName(index);
end;

function TTextToSpeech.MfgName(index: SYSINT): WideString;
begin
  Result := DefaultInterface.MfgName(index);
end;

function TTextToSpeech.ProductName(index: SYSINT): WideString;
begin
  Result := DefaultInterface.ProductName(index);
end;

function TTextToSpeech.ModeID(index: SYSINT): WideString;
begin
  Result := DefaultInterface.ModeID(index);
end;

function TTextToSpeech.Speaker(index: SYSINT): WideString;
begin
  Result := DefaultInterface.Speaker(index);
end;

function TTextToSpeech.Style(index: SYSINT): WideString;
begin
  Result := DefaultInterface.Style(index);
end;

function TTextToSpeech.Gender(index: SYSINT): Integer;
begin
  Result := DefaultInterface.Gender(index);
end;

function TTextToSpeech.Age(index: SYSINT): Integer;
begin
  Result := DefaultInterface.Age(index);
end;

function TTextToSpeech.Features(index: SYSINT): Integer;
begin
  Result := DefaultInterface.Features(index);
end;

function TTextToSpeech.Interfaces(index: SYSINT): Integer;
begin
  Result := DefaultInterface.Interfaces(index);
end;

function TTextToSpeech.EngineFeatures(index: SYSINT): Integer;
begin
  Result := DefaultInterface.EngineFeatures(index);
end;

function TTextToSpeech.LanguageID(index: SYSINT): Integer;
begin
  Result := DefaultInterface.LanguageID(index);
end;

function TTextToSpeech.dialect(index: SYSINT): WideString;
begin
  Result := DefaultInterface.dialect(index);
end;

procedure TTextToSpeech.Select(index: Integer);
begin
  DefaultInterface.Select(index);
end;

function TTextToSpeech.Find(const RankList: WideString): Integer;
begin
  Result := DefaultInterface.Find(RankList);
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TTextToSpeech]);
end;

end.
