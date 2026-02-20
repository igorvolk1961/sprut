unit TransnetAnalyzerLib_TLB;

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

// PASTLWTR : 1.2
// File generated on 02.12.2005 12:13:52 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Users\Volkov\Transnet\TransnetPas\TransnetAnalyzerLib\TransnetAnalyzerLib.tlb (1)
// LIBID: {9279309C-F981-4927-886D-D5A62783B2A6}
// LCID: 0
// Helpfile: 
// HelpString: TransnetAnalyzerLib Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TTransnetAnalyzer) : No Server registered for this CoClass
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
  TransnetAnalyzerLibMajorVersion = 1;
  TransnetAnalyzerLibMinorVersion = 0;

  LIBID_TransnetAnalyzerLib: TGUID = '{9279309C-F981-4927-886D-D5A62783B2A6}';

  IID_ITransnetAnalyzer: TGUID = '{F52159AF-B3D9-4E23-9D56-740EF3FFC829}';
  CLASS_TransnetAnalyzer: TGUID = '{0B702CF2-5FB9-42A5-A35B-29FFEF1BEEA4}';
  IID_IVector: TGUID = '{135B9EF4-4B01-4FDC-BB83-86C2F1D956C5}';
  IID_IMatrix: TGUID = '{2DD2C2A1-98B9-4458-9793-70742BC5ABC1}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TTransnetAnalyzerConst
type
  TTransnetAnalyzerConst = TOleEnum;
const
  _Vector = $00000000;
  _Matrix = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ITransnetAnalyzer = interface;
  ITransnetAnalyzerDisp = dispinterface;
  IVector = interface;
  IVectorDisp = dispinterface;
  IMatrix = interface;
  IMatrixDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  TransnetAnalyzer = ITransnetAnalyzer;


// *********************************************************************//
// Interface: ITransnetAnalyzer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F52159AF-B3D9-4E23-9D56-740EF3FFC829}
// *********************************************************************//
  ITransnetAnalyzer = interface(IDispatch)
    ['{F52159AF-B3D9-4E23-9D56-740EF3FFC829}']
    function Get_Vectors: IUnknown; safecall;
    function Get_Matrixs: IUnknown; safecall;
    property Vectors: IUnknown read Get_Vectors;
    property Matrixs: IUnknown read Get_Matrixs;
  end;

// *********************************************************************//
// DispIntf:  ITransnetAnalyzerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F52159AF-B3D9-4E23-9D56-740EF3FFC829}
// *********************************************************************//
  ITransnetAnalyzerDisp = dispinterface
    ['{F52159AF-B3D9-4E23-9D56-740EF3FFC829}']
    property Vectors: IUnknown readonly dispid 201;
    property Matrixs: IUnknown readonly dispid 202;
  end;

// *********************************************************************//
// Interface: IVector
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {135B9EF4-4B01-4FDC-BB83-86C2F1D956C5}
// *********************************************************************//
  IVector = interface(IDispatch)
    ['{135B9EF4-4B01-4FDC-BB83-86C2F1D956C5}']
    procedure Adding(Value: Double); safecall;
    procedure Substracting(Value: Double); safecall;
    function Get_Item(aCol: SYSINT): Double; safecall;
    procedure Set_Item(aCol: SYSINT; Value: Double); safecall;
    procedure NullingAllElements; safecall;
    procedure AddElement(Value: Double); safecall;
    procedure AddEmptyElement; safecall;
    procedure DeleteElement; safecall;
    function Get_Count: SYSINT; safecall;
    property Item[aCol: SYSINT]: Double read Get_Item write Set_Item;
    property Count: SYSINT read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IVectorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {135B9EF4-4B01-4FDC-BB83-86C2F1D956C5}
// *********************************************************************//
  IVectorDisp = dispinterface
    ['{135B9EF4-4B01-4FDC-BB83-86C2F1D956C5}']
    procedure Adding(Value: Double); dispid 201;
    procedure Substracting(Value: Double); dispid 202;
    property Item[aCol: SYSINT]: Double dispid 203;
    procedure NullingAllElements; dispid 204;
    procedure AddElement(Value: Double); dispid 205;
    procedure AddEmptyElement; dispid 206;
    procedure DeleteElement; dispid 207;
    property Count: SYSINT readonly dispid 208;
  end;

// *********************************************************************//
// Interface: IMatrix
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2DD2C2A1-98B9-4458-9793-70742BC5ABC1}
// *********************************************************************//
  IMatrix = interface(IDispatch)
    ['{2DD2C2A1-98B9-4458-9793-70742BC5ABC1}']
    function Get_Vectors: IUnknown; safecall;
    function Get_ColumnCount: SYSINT; safecall;
    function Get_RowCount: SYSINT; safecall;
    procedure Adding(Value: Double); safecall;
    procedure Substracting(Value: Double); safecall;
    procedure Nulling; safecall;
    procedure Transposed(var aMatrix: IMatrix); safecall;
    procedure Squarte(var aMatrix: IMatrix); safecall;
    procedure AddRow(const aElement: IUnknown); safecall;
    function Get_CellValue(aRow: SYSINT; aColumn: SYSINT): Double; safecall;
    procedure Set_CellValue(aRow: SYSINT; aColumn: SYSINT; Value: Double); safecall;
    function AddColumn: SYSINT; safecall;
    procedure Resize(nRow: SYSINT; nCol: SYSINT); safecall;
    procedure AddingInPos(nRow: SYSINT; nCol: SYSINT; Value: Double); safecall;
    property Vectors: IUnknown read Get_Vectors;
    property ColumnCount: SYSINT read Get_ColumnCount;
    property RowCount: SYSINT read Get_RowCount;
    property CellValue[aRow: SYSINT; aColumn: SYSINT]: Double read Get_CellValue write Set_CellValue;
  end;

// *********************************************************************//
// DispIntf:  IMatrixDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2DD2C2A1-98B9-4458-9793-70742BC5ABC1}
// *********************************************************************//
  IMatrixDisp = dispinterface
    ['{2DD2C2A1-98B9-4458-9793-70742BC5ABC1}']
    property Vectors: IUnknown readonly dispid 201;
    property ColumnCount: SYSINT readonly dispid 202;
    property RowCount: SYSINT readonly dispid 203;
    procedure Adding(Value: Double); dispid 205;
    procedure Substracting(Value: Double); dispid 206;
    procedure Nulling; dispid 207;
    procedure Transposed(var aMatrix: IMatrix); dispid 208;
    procedure Squarte(var aMatrix: IMatrix); dispid 209;
    procedure AddRow(const aElement: IUnknown); dispid 210;
    property CellValue[aRow: SYSINT; aColumn: SYSINT]: Double dispid 204;
    function AddColumn: SYSINT; dispid 211;
    procedure Resize(nRow: SYSINT; nCol: SYSINT); dispid 212;
    procedure AddingInPos(nRow: SYSINT; nCol: SYSINT; Value: Double); dispid 1;
  end;

// *********************************************************************//
// The Class CoTransnetAnalyzer provides a Create and CreateRemote method to          
// create instances of the default interface ITransnetAnalyzer exposed by              
// the CoClass TransnetAnalyzer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTransnetAnalyzer = class
    class function Create: ITransnetAnalyzer;
    class function CreateRemote(const MachineName: string): ITransnetAnalyzer;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTransnetAnalyzer
// Help String      : 
// Default Interface: ITransnetAnalyzer
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTransnetAnalyzerProperties= class;
{$ENDIF}
  TTransnetAnalyzer = class(TOleServer)
  private
    FIntf:        ITransnetAnalyzer;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTransnetAnalyzerProperties;
    function      GetServerProperties: TTransnetAnalyzerProperties;
{$ENDIF}
    function      GetDefaultInterface: ITransnetAnalyzer;
  protected
    procedure InitServerData; override;
    function Get_Vectors: IUnknown;
    function Get_Matrixs: IUnknown;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ITransnetAnalyzer);
    procedure Disconnect; override;
    property DefaultInterface: ITransnetAnalyzer read GetDefaultInterface;
    property Vectors: IUnknown read Get_Vectors;
    property Matrixs: IUnknown read Get_Matrixs;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTransnetAnalyzerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTransnetAnalyzer
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTransnetAnalyzerProperties = class(TPersistent)
  private
    FServer:    TTransnetAnalyzer;
    function    GetDefaultInterface: ITransnetAnalyzer;
    constructor Create(AServer: TTransnetAnalyzer);
  protected
    function Get_Vectors: IUnknown;
    function Get_Matrixs: IUnknown;
  public
    property DefaultInterface: ITransnetAnalyzer read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoTransnetAnalyzer.Create: ITransnetAnalyzer;
begin
  Result := CreateComObject(CLASS_TransnetAnalyzer) as ITransnetAnalyzer;
end;

class function CoTransnetAnalyzer.CreateRemote(const MachineName: string): ITransnetAnalyzer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TransnetAnalyzer) as ITransnetAnalyzer;
end;

procedure TTransnetAnalyzer.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0B702CF2-5FB9-42A5-A35B-29FFEF1BEEA4}';
    IntfIID:   '{F52159AF-B3D9-4E23-9D56-740EF3FFC829}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTransnetAnalyzer.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ITransnetAnalyzer;
  end;
end;

procedure TTransnetAnalyzer.ConnectTo(svrIntf: ITransnetAnalyzer);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TTransnetAnalyzer.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TTransnetAnalyzer.GetDefaultInterface: ITransnetAnalyzer;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTransnetAnalyzer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTransnetAnalyzerProperties.Create(Self);
{$ENDIF}
end;

destructor TTransnetAnalyzer.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTransnetAnalyzer.GetServerProperties: TTransnetAnalyzerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TTransnetAnalyzer.Get_Vectors: IUnknown;
begin
    Result := DefaultInterface.Vectors;
end;

function TTransnetAnalyzer.Get_Matrixs: IUnknown;
begin
    Result := DefaultInterface.Matrixs;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTransnetAnalyzerProperties.Create(AServer: TTransnetAnalyzer);
begin
  inherited Create;
  FServer := AServer;
end;

function TTransnetAnalyzerProperties.GetDefaultInterface: ITransnetAnalyzer;
begin
  Result := FServer.DefaultInterface;
end;

function TTransnetAnalyzerProperties.Get_Vectors: IUnknown;
begin
    Result := DefaultInterface.Vectors;
end;

function TTransnetAnalyzerProperties.Get_Matrixs: IUnknown;
begin
    Result := DefaultInterface.Matrixs;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TTransnetAnalyzer]);
end;

end.
