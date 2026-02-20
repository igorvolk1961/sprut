unit BattleModelLib_TLB;

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
// File generated on 27.02.2007 13:51:45 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\Sprut3\bin\BattleModelLib.dll (1)
// LIBID: {B0B71422-81B5-11D6-9728-0050BA51A6D3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v1.0 DataModel, (D:\users\Volkov\AutoDM\AutoDMPas\DataModel\DataModel.tlb)
//   (3) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
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

uses Windows, ActiveX, Classes, DataModel_TLB, Graphics, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  BattleModelLibMajorVersion = 1;
  BattleModelLibMinorVersion = 0;

  LIBID_BattleModelLib: TGUID = '{B0B71422-81B5-11D6-9728-0050BA51A6D3}';

  IID_IBattleModel: TGUID = '{B0B71425-81B5-11D6-9728-0050BA51A6D3}';
  CLASS_BattleModel: TGUID = '{B0B71428-81B5-11D6-9728-0050BA51A6D3}';
  IID_IBattleLine: TGUID = '{B0B7142A-81B5-11D6-9728-0050BA51A6D3}';
  IID_IBattleUnit: TGUID = '{B0B7142C-81B5-11D6-9728-0050BA51A6D3}';
  IID_IBattleLayer: TGUID = '{AF88C760-2839-11D3-BBF3-B9643FC4B836}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TBattleModelClass
type
  TBattleModelClass = TOleEnum;
const
  _BattleUnit = $00000000;
  _BattleLine = $00000001;
  _BattleLayer = $00000002;

// Constants for enum TBattleUnitKind
type
  TBattleUnitKind = TOleEnum;
const
  bukAdversary = $00000000;
  bukMainGroup = $00000001;
  bukGuard = $00000002;
  bukPatrol = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IBattleModel = interface;
  IBattleModelDisp = dispinterface;
  IBattleLine = interface;
  IBattleLineDisp = dispinterface;
  IBattleUnit = interface;
  IBattleUnitDisp = dispinterface;
  IBattleLayer = interface;
  IBattleLayerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  BattleModel = IBattleModel;


// *********************************************************************//
// Interface: IBattleModel
// Flags:     (320) Dual OleAutomation
// GUID:      {B0B71425-81B5-11D6-9728-0050BA51A6D3}
// *********************************************************************//
  IBattleModel = interface(IUnknown)
    ['{B0B71425-81B5-11D6-9728-0050BA51A6D3}']
    function Get_BattleLines: IDMCollection; safecall;
    function Get_BattleUnits: IDMCollection; safecall;
    function Get_FacilityModel: IUnknown; safecall;
    procedure Set_FacilityModel(const Value: IUnknown); safecall;
    procedure StartBattle; safecall;
    function Get_StartNode: IUnknown; safecall;
    procedure Set_StartNode(const Value: IUnknown); safecall;
    function NextStep: WordBool; safecall;
    function Get_DefaultTimeStep: Double; safecall;
    procedure Set_DefaultTimeStep(Value: Double); safecall;
    function Get_CurrentTime: Double; safecall;
    function Get_NextToStartNode: IUnknown; safecall;
    procedure Set_NextToStartNode(const Value: IUnknown); safecall;
    function Get_TimeArray(Index: Integer): Double; safecall;
    function Get_TimeArrayCount: Integer; safecall;
    function CalcSccessProbabilityOnPath(const Polyline: IUnknown): Double; safecall;
    procedure ClearBattle; safecall;
    procedure StartBattle2; safecall;
    property BattleLines: IDMCollection read Get_BattleLines;
    property BattleUnits: IDMCollection read Get_BattleUnits;
    property FacilityModel: IUnknown read Get_FacilityModel write Set_FacilityModel;
    property StartNode: IUnknown read Get_StartNode write Set_StartNode;
    property DefaultTimeStep: Double read Get_DefaultTimeStep write Set_DefaultTimeStep;
    property CurrentTime: Double read Get_CurrentTime;
    property NextToStartNode: IUnknown read Get_NextToStartNode write Set_NextToStartNode;
    property TimeArray[Index: Integer]: Double read Get_TimeArray;
    property TimeArrayCount: Integer read Get_TimeArrayCount;
  end;

// *********************************************************************//
// DispIntf:  IBattleModelDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {B0B71425-81B5-11D6-9728-0050BA51A6D3}
// *********************************************************************//
  IBattleModelDisp = dispinterface
    ['{B0B71425-81B5-11D6-9728-0050BA51A6D3}']
    property BattleLines: IDMCollection readonly dispid 1;
    property BattleUnits: IDMCollection readonly dispid 2;
    property FacilityModel: IUnknown dispid 3;
    procedure StartBattle; dispid 4;
    property StartNode: IUnknown dispid 5;
    function NextStep: WordBool; dispid 6;
    property DefaultTimeStep: Double dispid 7;
    property CurrentTime: Double readonly dispid 8;
    property NextToStartNode: IUnknown dispid 9;
    property TimeArray[Index: Integer]: Double readonly dispid 29;
    property TimeArrayCount: Integer readonly dispid 10;
    function CalcSccessProbabilityOnPath(const Polyline: IUnknown): Double; dispid 11;
    procedure ClearBattle; dispid 12;
    procedure StartBattle2; dispid 13;
  end;

// *********************************************************************//
// Interface: IBattleLine
// Flags:     (320) Dual OleAutomation
// GUID:      {B0B7142A-81B5-11D6-9728-0050BA51A6D3}
// *********************************************************************//
  IBattleLine = interface(IUnknown)
    ['{B0B7142A-81B5-11D6-9728-0050BA51A6D3}']
    procedure CalcThreat; safecall;
    function Get_FacilityModel: IDMElement; safecall;
    procedure Set_FacilityModel(const Value: IDMElement); safecall;
    function Get_Threat01: Double; safecall;
    function Get_Threat10: Double; safecall;
    procedure CheckFireLine; safecall;
    procedure CalcScoreProbability(TimeStep: Double); safecall;
    function Get_ScoreProbability01: Double; safecall;
    function Get_ScoreProbability10: Double; safecall;
    procedure CalcAliveHope; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure Set_TransparencyCoeff(Param1: Double); safecall;
    procedure IncFireLineCount; safecall;
    property FacilityModel: IDMElement read Get_FacilityModel write Set_FacilityModel;
    property Threat01: Double read Get_Threat01;
    property Threat10: Double read Get_Threat10;
    property ScoreProbability01: Double read Get_ScoreProbability01;
    property ScoreProbability10: Double read Get_ScoreProbability10;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property TransparencyCoeff: Double write Set_TransparencyCoeff;
  end;

// *********************************************************************//
// DispIntf:  IBattleLineDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {B0B7142A-81B5-11D6-9728-0050BA51A6D3}
// *********************************************************************//
  IBattleLineDisp = dispinterface
    ['{B0B7142A-81B5-11D6-9728-0050BA51A6D3}']
    procedure CalcThreat; dispid 1;
    property FacilityModel: IDMElement dispid 2;
    property Threat01: Double readonly dispid 4;
    property Threat10: Double readonly dispid 5;
    procedure CheckFireLine; dispid 6;
    procedure CalcScoreProbability(TimeStep: Double); dispid 7;
    property ScoreProbability01: Double readonly dispid 8;
    property ScoreProbability10: Double readonly dispid 9;
    procedure CalcAliveHope; dispid 10;
    property Visible: WordBool dispid 3;
    property TransparencyCoeff: Double writeonly dispid 11;
    procedure IncFireLineCount; dispid 101;
  end;

// *********************************************************************//
// Interface: IBattleUnit
// Flags:     (320) Dual OleAutomation
// GUID:      {B0B7142C-81B5-11D6-9728-0050BA51A6D3}
// *********************************************************************//
  IBattleUnit = interface(IUnknown)
    ['{B0B7142C-81B5-11D6-9728-0050BA51A6D3}']
    function Get_Path: IDMCollection; safecall;
    procedure Set_Path(const Value: IDMCollection); safecall;
    function Get_State: Integer; safecall;
    procedure Set_State(Value: Integer); safecall;
    function StartBattle(DefaultTimeStep: Double): Double; safecall;
    function NextStep(TimeStep: Double; DefaultTimeStep: Double): Double; safecall;
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    function Get_CurrentNode: IDMElement; safecall;
    procedure Set_CurrentNode(const Value: IDMElement); safecall;
    function Get_FacilityModel: IDMElement; safecall;
    procedure Set_FacilityModel(const Value: IDMElement); safecall;
    function Get_NextNode: IDMElement; safecall;
    function Get_FireLineCount: Integer; safecall;
    procedure Set_FireLineCount(Value: Integer); safecall;
    function Get_ThreatSum: Double; safecall;
    procedure Set_ThreatSum(Value: Double); safecall;
    function Get_TakeAimTimeMax: Double; safecall;
    function GetHitPMax(Distance: Double; AimState: Integer; GunFlag: WordBool): Double; safecall;
    function GetHitPMin(Distance: Double; AimState: Integer; GunFlag: WordBool): Double; safecall;
    function Get_NewAlive: Double; safecall;
    procedure Set_NewAlive(Value: Double); safecall;
    function Get_OldAlive: Double; safecall;
    procedure Set_OldAlive(Value: Double); safecall;
    function Get_TakeAimTime: Double; safecall;
    procedure CalcTakeAimTime; safecall;
    function Get_EvadeFactor: Double; safecall;
    function Get_ASum: Double; safecall;
    procedure Set_ASum(Value: Double); safecall;
    function Get_BSum: Double; safecall;
    procedure Set_BSum(Value: Double); safecall;
    function Get_ShotDistance: Double; safecall;
    function Get_TakeAimTimeMin: Double; safecall;
    function Get_ShotForce: Integer; safecall;
    function Get_HideState: Integer; safecall;
    function Get_InDefence: WordBool; safecall;
    procedure Set_InDefence(Value: WordBool); safecall;
    function Get_WeaponGroupDamage: WordBool; safecall;
    function Get_AliveArray(Index: Integer): Double; safecall;
    procedure LastStep; safecall;
    function Get_AliveArrayCount: Integer; safecall;
    procedure StoreState; safecall;
    function Get_Alive: Double; safecall;
    procedure Set_Alive(Value: Double); safecall;
    function Get_AliveHope: Double; safecall;
    procedure Set_AliveHope(Value: Double); safecall;
    function Get_NumberArray(Index: Integer): Double; safecall;
    function Get_UsefulTimeArray(Index: Integer): Double; safecall;
    function Get_Pdef: Double; safecall;
    procedure Set_Pdef(Value: Double); safecall;
    function Get_Pgun: Double; safecall;
    procedure Set_Pgun(Value: Double); safecall;
    function Get_Pveh: Integer; safecall;
    procedure Set_Pveh(Value: Integer); safecall;
    function Get_TakeAimTimeMaxG: Integer; safecall;
    function Get_ShotForceG: Integer; safecall;
    function Get_ShotDistanceG: Double; safecall;
    function Get_TakeAimTimeG: Double; safecall;
    function Get_TakeAimTimeMinG: Double; safecall;
    function Get_WeaponCount: Integer; safecall;
    function Get_WeaponCountG: Integer; safecall;
    function Get_SomebodyAlive: Double; safecall;
    procedure Set_SomebodyAlive(Value: Double); safecall;
    function CalcNumber: Double; safecall;
    function Get_DefenceLevel: Integer; safecall;
    procedure Set_DefenceLevel(Value: Integer); safecall;
    property Path: IDMCollection read Get_Path write Set_Path;
    property State: Integer read Get_State write Set_State;
    property Kind: Integer read Get_Kind write Set_Kind;
    property CurrentNode: IDMElement read Get_CurrentNode write Set_CurrentNode;
    property FacilityModel: IDMElement read Get_FacilityModel write Set_FacilityModel;
    property NextNode: IDMElement read Get_NextNode;
    property FireLineCount: Integer read Get_FireLineCount write Set_FireLineCount;
    property ThreatSum: Double read Get_ThreatSum write Set_ThreatSum;
    property TakeAimTimeMax: Double read Get_TakeAimTimeMax;
    property NewAlive: Double read Get_NewAlive write Set_NewAlive;
    property OldAlive: Double read Get_OldAlive write Set_OldAlive;
    property TakeAimTime: Double read Get_TakeAimTime;
    property EvadeFactor: Double read Get_EvadeFactor;
    property ASum: Double read Get_ASum write Set_ASum;
    property BSum: Double read Get_BSum write Set_BSum;
    property ShotDistance: Double read Get_ShotDistance;
    property TakeAimTimeMin: Double read Get_TakeAimTimeMin;
    property ShotForce: Integer read Get_ShotForce;
    property HideState: Integer read Get_HideState;
    property InDefence: WordBool read Get_InDefence write Set_InDefence;
    property WeaponGroupDamage: WordBool read Get_WeaponGroupDamage;
    property AliveArray[Index: Integer]: Double read Get_AliveArray;
    property AliveArrayCount: Integer read Get_AliveArrayCount;
    property Alive: Double read Get_Alive write Set_Alive;
    property AliveHope: Double read Get_AliveHope write Set_AliveHope;
    property NumberArray[Index: Integer]: Double read Get_NumberArray;
    property UsefulTimeArray[Index: Integer]: Double read Get_UsefulTimeArray;
    property Pdef: Double read Get_Pdef write Set_Pdef;
    property Pgun: Double read Get_Pgun write Set_Pgun;
    property Pveh: Integer read Get_Pveh write Set_Pveh;
    property TakeAimTimeMaxG: Integer read Get_TakeAimTimeMaxG;
    property ShotForceG: Integer read Get_ShotForceG;
    property ShotDistanceG: Double read Get_ShotDistanceG;
    property TakeAimTimeG: Double read Get_TakeAimTimeG;
    property TakeAimTimeMinG: Double read Get_TakeAimTimeMinG;
    property WeaponCount: Integer read Get_WeaponCount;
    property WeaponCountG: Integer read Get_WeaponCountG;
    property SomebodyAlive: Double read Get_SomebodyAlive write Set_SomebodyAlive;
    property DefenceLevel: Integer read Get_DefenceLevel write Set_DefenceLevel;
  end;

// *********************************************************************//
// DispIntf:  IBattleUnitDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {B0B7142C-81B5-11D6-9728-0050BA51A6D3}
// *********************************************************************//
  IBattleUnitDisp = dispinterface
    ['{B0B7142C-81B5-11D6-9728-0050BA51A6D3}']
    property Path: IDMCollection dispid 1;
    property State: Integer dispid 3;
    function StartBattle(DefaultTimeStep: Double): Double; dispid 5;
    function NextStep(TimeStep: Double; DefaultTimeStep: Double): Double; dispid 6;
    property Kind: Integer dispid 7;
    property CurrentNode: IDMElement dispid 8;
    property FacilityModel: IDMElement dispid 9;
    property NextNode: IDMElement readonly dispid 11;
    property FireLineCount: Integer dispid 10;
    property ThreatSum: Double dispid 12;
    property TakeAimTimeMax: Double readonly dispid 13;
    function GetHitPMax(Distance: Double; AimState: Integer; GunFlag: WordBool): Double; dispid 15;
    function GetHitPMin(Distance: Double; AimState: Integer; GunFlag: WordBool): Double; dispid 16;
    property NewAlive: Double dispid 17;
    property OldAlive: Double dispid 18;
    property TakeAimTime: Double readonly dispid 20;
    procedure CalcTakeAimTime; dispid 21;
    property EvadeFactor: Double readonly dispid 24;
    property ASum: Double dispid 25;
    property BSum: Double dispid 26;
    property ShotDistance: Double readonly dispid 2;
    property TakeAimTimeMin: Double readonly dispid 14;
    property ShotForce: Integer readonly dispid 19;
    property HideState: Integer readonly dispid 23;
    property InDefence: WordBool dispid 4;
    property WeaponGroupDamage: WordBool readonly dispid 27;
    property AliveArray[Index: Integer]: Double readonly dispid 28;
    procedure LastStep; dispid 29;
    property AliveArrayCount: Integer readonly dispid 30;
    procedure StoreState; dispid 31;
    property Alive: Double dispid 32;
    property AliveHope: Double dispid 34;
    property NumberArray[Index: Integer]: Double readonly dispid 37;
    property UsefulTimeArray[Index: Integer]: Double readonly dispid 38;
    property Pdef: Double dispid 35;
    property Pgun: Double dispid 36;
    property Pveh: Integer dispid 39;
    property TakeAimTimeMaxG: Integer readonly dispid 40;
    property ShotForceG: Integer readonly dispid 41;
    property ShotDistanceG: Double readonly dispid 42;
    property TakeAimTimeG: Double readonly dispid 43;
    property TakeAimTimeMinG: Double readonly dispid 44;
    property WeaponCount: Integer readonly dispid 45;
    property WeaponCountG: Integer readonly dispid 46;
    property SomebodyAlive: Double dispid 33;
    function CalcNumber: Double; dispid 101;
    property DefenceLevel: Integer dispid 22;
  end;

// *********************************************************************//
// Interface: IBattleLayer
// Flags:     (320) Dual OleAutomation
// GUID:      {AF88C760-2839-11D3-BBF3-B9643FC4B836}
// *********************************************************************//
  IBattleLayer = interface(IUnknown)
    ['{AF88C760-2839-11D3-BBF3-B9643FC4B836}']
  end;

// *********************************************************************//
// DispIntf:  IBattleLayerDisp
// Flags:     (320) Dual OleAutomation
// GUID:      {AF88C760-2839-11D3-BBF3-B9643FC4B836}
// *********************************************************************//
  IBattleLayerDisp = dispinterface
    ['{AF88C760-2839-11D3-BBF3-B9643FC4B836}']
  end;

// *********************************************************************//
// The Class CoBattleModel provides a Create and CreateRemote method to          
// create instances of the default interface IBattleModel exposed by              
// the CoClass BattleModel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBattleModel = class
    class function Create: IBattleModel;
    class function CreateRemote(const MachineName: string): IBattleModel;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TBattleModel
// Help String      : BattleModel
// Default Interface: IBattleModel
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TBattleModelProperties= class;
{$ENDIF}
  TBattleModel = class(TOleServer)
  private
    FIntf:        IBattleModel;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TBattleModelProperties;
    function      GetServerProperties: TBattleModelProperties;
{$ENDIF}
    function      GetDefaultInterface: IBattleModel;
  protected
    procedure InitServerData; override;
    function Get_BattleLines: IDMCollection;
    function Get_BattleUnits: IDMCollection;
    function Get_FacilityModel: IUnknown;
    procedure Set_FacilityModel(const Value: IUnknown);
    function Get_StartNode: IUnknown;
    procedure Set_StartNode(const Value: IUnknown);
    function Get_DefaultTimeStep: Double;
    procedure Set_DefaultTimeStep(Value: Double);
    function Get_CurrentTime: Double;
    function Get_NextToStartNode: IUnknown;
    procedure Set_NextToStartNode(const Value: IUnknown);
    function Get_TimeArray(Index: Integer): Double;
    function Get_TimeArrayCount: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IBattleModel);
    procedure Disconnect; override;
    procedure StartBattle;
    function NextStep: WordBool;
    function CalcSccessProbabilityOnPath(const Polyline: IUnknown): Double;
    procedure ClearBattle;
    procedure StartBattle2;
    property DefaultInterface: IBattleModel read GetDefaultInterface;
    property BattleLines: IDMCollection read Get_BattleLines;
    property BattleUnits: IDMCollection read Get_BattleUnits;
    property FacilityModel: IUnknown read Get_FacilityModel write Set_FacilityModel;
    property StartNode: IUnknown read Get_StartNode write Set_StartNode;
    property CurrentTime: Double read Get_CurrentTime;
    property NextToStartNode: IUnknown read Get_NextToStartNode write Set_NextToStartNode;
    property TimeArray[Index: Integer]: Double read Get_TimeArray;
    property TimeArrayCount: Integer read Get_TimeArrayCount;
    property DefaultTimeStep: Double read Get_DefaultTimeStep write Set_DefaultTimeStep;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TBattleModelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TBattleModel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TBattleModelProperties = class(TPersistent)
  private
    FServer:    TBattleModel;
    function    GetDefaultInterface: IBattleModel;
    constructor Create(AServer: TBattleModel);
  protected
    function Get_BattleLines: IDMCollection;
    function Get_BattleUnits: IDMCollection;
    function Get_FacilityModel: IUnknown;
    procedure Set_FacilityModel(const Value: IUnknown);
    function Get_StartNode: IUnknown;
    procedure Set_StartNode(const Value: IUnknown);
    function Get_DefaultTimeStep: Double;
    procedure Set_DefaultTimeStep(Value: Double);
    function Get_CurrentTime: Double;
    function Get_NextToStartNode: IUnknown;
    procedure Set_NextToStartNode(const Value: IUnknown);
    function Get_TimeArray(Index: Integer): Double;
    function Get_TimeArrayCount: Integer;
  public
    property DefaultInterface: IBattleModel read GetDefaultInterface;
  published
    property DefaultTimeStep: Double read Get_DefaultTimeStep write Set_DefaultTimeStep;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoBattleModel.Create: IBattleModel;
begin
  Result := CreateComObject(CLASS_BattleModel) as IBattleModel;
end;

class function CoBattleModel.CreateRemote(const MachineName: string): IBattleModel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BattleModel) as IBattleModel;
end;

procedure TBattleModel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{B0B71428-81B5-11D6-9728-0050BA51A6D3}';
    IntfIID:   '{B0B71425-81B5-11D6-9728-0050BA51A6D3}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TBattleModel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IBattleModel;
  end;
end;

procedure TBattleModel.ConnectTo(svrIntf: IBattleModel);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TBattleModel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TBattleModel.GetDefaultInterface: IBattleModel;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TBattleModel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TBattleModelProperties.Create(Self);
{$ENDIF}
end;

destructor TBattleModel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TBattleModel.GetServerProperties: TBattleModelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TBattleModel.Get_BattleLines: IDMCollection;
begin
    Result := DefaultInterface.BattleLines;
end;

function TBattleModel.Get_BattleUnits: IDMCollection;
begin
    Result := DefaultInterface.BattleUnits;
end;

function TBattleModel.Get_FacilityModel: IUnknown;
begin
    Result := DefaultInterface.FacilityModel;
end;

procedure TBattleModel.Set_FacilityModel(const Value: IUnknown);
begin
  Exit;
end;

function TBattleModel.Get_StartNode: IUnknown;
begin
    Result := DefaultInterface.StartNode;
end;

procedure TBattleModel.Set_StartNode(const Value: IUnknown);
begin
  Exit;
end;

function TBattleModel.Get_DefaultTimeStep: Double;
begin
    Result := DefaultInterface.DefaultTimeStep;
end;

procedure TBattleModel.Set_DefaultTimeStep(Value: Double);
begin
  Exit;
end;

function TBattleModel.Get_CurrentTime: Double;
begin
    Result := DefaultInterface.CurrentTime;
end;

function TBattleModel.Get_NextToStartNode: IUnknown;
begin
    Result := DefaultInterface.NextToStartNode;
end;

procedure TBattleModel.Set_NextToStartNode(const Value: IUnknown);
begin
  Exit;
end;

function TBattleModel.Get_TimeArray(Index: Integer): Double;
begin
    Result := DefaultInterface.TimeArray[Index];
end;

function TBattleModel.Get_TimeArrayCount: Integer;
begin
    Result := DefaultInterface.TimeArrayCount;
end;

procedure TBattleModel.StartBattle;
begin
  DefaultInterface.StartBattle;
end;

function TBattleModel.NextStep: WordBool;
begin
  Result := DefaultInterface.NextStep;
end;

function TBattleModel.CalcSccessProbabilityOnPath(const Polyline: IUnknown): Double;
begin
  Result := DefaultInterface.CalcSccessProbabilityOnPath(Polyline);
end;

procedure TBattleModel.ClearBattle;
begin
  DefaultInterface.ClearBattle;
end;

procedure TBattleModel.StartBattle2;
begin
  DefaultInterface.StartBattle2;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TBattleModelProperties.Create(AServer: TBattleModel);
begin
  inherited Create;
  FServer := AServer;
end;

function TBattleModelProperties.GetDefaultInterface: IBattleModel;
begin
  Result := FServer.DefaultInterface;
end;

function TBattleModelProperties.Get_BattleLines: IDMCollection;
begin
    Result := DefaultInterface.BattleLines;
end;

function TBattleModelProperties.Get_BattleUnits: IDMCollection;
begin
    Result := DefaultInterface.BattleUnits;
end;

function TBattleModelProperties.Get_FacilityModel: IUnknown;
begin
    Result := DefaultInterface.FacilityModel;
end;

procedure TBattleModelProperties.Set_FacilityModel(const Value: IUnknown);
begin
  Exit;
end;

function TBattleModelProperties.Get_StartNode: IUnknown;
begin
    Result := DefaultInterface.StartNode;
end;

procedure TBattleModelProperties.Set_StartNode(const Value: IUnknown);
begin
  Exit;
end;

function TBattleModelProperties.Get_DefaultTimeStep: Double;
begin
    Result := DefaultInterface.DefaultTimeStep;
end;

procedure TBattleModelProperties.Set_DefaultTimeStep(Value: Double);
begin
  Exit;
end;

function TBattleModelProperties.Get_CurrentTime: Double;
begin
    Result := DefaultInterface.CurrentTime;
end;

function TBattleModelProperties.Get_NextToStartNode: IUnknown;
begin
    Result := DefaultInterface.NextToStartNode;
end;

procedure TBattleModelProperties.Set_NextToStartNode(const Value: IUnknown);
begin
  Exit;
end;

function TBattleModelProperties.Get_TimeArray(Index: Integer): Double;
begin
    Result := DefaultInterface.TimeArray[Index];
end;

function TBattleModelProperties.Get_TimeArrayCount: Integer;
begin
    Result := DefaultInterface.TimeArrayCount;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TBattleModel]);
end;

end.
