unit PainterLib_TLB;

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
// File generated on 19.07.2007 18:05:08 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\AutoDM\bin\PainterLib.dll (1)
// LIBID: {F949EC5E-E93E-46C1-B4CA-CD540C4E3512}
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
  PainterLibMajorVersion = 1;
  PainterLibMinorVersion = 0;

  LIBID_PainterLib: TGUID = '{F949EC5E-E93E-46C1-B4CA-CD540C4E3512}';

  IID_IPainter: TGUID = '{F4F11495-54EE-4730-80C1-3579EAE51FB1}';
  CLASS_Painter: TGUID = '{2E1FDC40-4EF1-4DD7-AA69-92B6375291FB}';
  IID_IPainter3: TGUID = '{48AB0E2B-34B3-4FF5-AC5A-E2187CB1E146}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IPainter = interface;
  IPainterDisp = dispinterface;
  IPainter3 = interface;
  IPainter3Disp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Painter = IPainter;


// *********************************************************************//
// Interface: IPainter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F4F11495-54EE-4730-80C1-3579EAE51FB1}
// *********************************************************************//
  IPainter = interface(IDispatch)
    ['{F4F11495-54EE-4730-80C1-3579EAE51FB1}']
    function Get_ViewU: IUnknown; safecall;
    procedure Set_ViewU(const Value: IUnknown); safecall;
    function Get_PenColor: Integer; safecall;
    procedure Set_PenColor(Value: Integer); safecall;
    function Get_PenMode: Integer; safecall;
    procedure Set_PenMode(Value: Integer); safecall;
    procedure DrawPoint(WX: Double; WY: Double; WZ: Double); safecall;
    procedure DrawLine(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; WZ1: Double); safecall;
    procedure DrawCurvedLine(PointArray: OleVariant); safecall;
    procedure DrawPolygon(const Lines: IDMCollection; Vertical: WordBool); safecall;
    procedure DrawPicture(P0X: Double; P0Y: Double; P0Z: Double; P1X: Double; P1Y: Double; 
                          P1Z: Double; P3X: Double; P3Y: Double; P3Z: Double; P4X: Double; 
                          P4Y: Double; P4Z: Double; aAngle: Double; PictureHandle: LongWord; 
                          PictureFMT: Integer; Alpha: Integer); safecall;
    function Get_PenStyle: Integer; safecall;
    procedure Set_PenStyle(Value: Integer); safecall;
    function Get_PenWidth: Double; safecall;
    procedure Set_PenWidth(Value: Double); safecall;
    function Get_BrushColor: Integer; safecall;
    procedure Set_BrushColor(Value: Integer); safecall;
    function Get_BrushStyle: Integer; safecall;
    procedure Set_BrushStyle(Value: Integer); safecall;
    function Get_HHeight: Integer; safecall;
    procedure Set_HHeight(Value: Integer); safecall;
    function Get_HWidth: Integer; safecall;
    procedure Set_HWidth(Value: Integer); safecall;
    function Get_VWidth: Integer; safecall;
    procedure Set_VWidth(Value: Integer); safecall;
    procedure DrawAxes(XP: Integer; YP: Integer; ZP: Integer); safecall;
    procedure SetRangePix; safecall;
    function Get_VHeight: Integer; safecall;
    procedure Set_VHeight(Value: Integer); safecall;
    procedure DrawRangeMarks; safecall;
    function Get_DmaxPix: Integer; safecall;
    procedure Set_DmaxPix(Value: Integer); safecall;
    function Get_DminPix: Integer; safecall;
    procedure Set_DminPix(Value: Integer); safecall;
    function Get_ZmaxPix: Integer; safecall;
    procedure Set_ZmaxPix(Value: Integer); safecall;
    function Get_ZminPix: Integer; safecall;
    procedure Set_ZminPix(Value: Integer); safecall;
    function Get_HCanvasHandle: Integer; safecall;
    procedure Set_HCanvasHandle(Value: Integer); safecall;
    function Get_VCanvasHandle: Integer; safecall;
    procedure Set_VCanvasHandle(Value: Integer); safecall;
    procedure WP_To_P(WX: Double; WY: Double; WZ: Double; out PX: Integer; out PY: Integer; 
                      out PZ: Integer); safecall;
    procedure P_To_WP(PX: Integer; PY: Integer; Tag: Integer; out WX: Double; out WY: Double; 
                      out WZ: Double); safecall;
    procedure DrawRectangle(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; 
                            WZ1: Double; Angle: Double); safecall;
    function Get_LocalViewU: IUnknown; safecall;
    procedure Set_LocalViewU(const Value: IUnknown); safecall;
    procedure DrawText(WX: Double; WY: Double; WZ: Double; const Text: WideString; 
                       TextSize: Double; const FontName: WideString; FontSize: Integer; 
                       FontColor: Integer; FontStyle: Integer; ScaleMode: Integer); safecall;
    function Get_LayerIndex: Integer; safecall;
    procedure Set_LayerIndex(Value: Integer); safecall;
    function Get_UseLayers: WordBool; safecall;
    procedure DrawArc(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; WZ1: Double; 
                      WX2: Double; WY2: Double; WZ2: Double); safecall;
    procedure SetLimits; safecall;
    function LineIsVisible(aCanvasTag: Integer; var X0: Double; var Y0: Double; var Z0: Double; 
                           var X1: Double; var Y1: Double; var Z1: Double; FittoCanvas: WordBool; 
                           CanvasLevel: Integer): WordBool; safecall;
    function Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    procedure DrawCircle(WX: Double; WY: Double; WZ: Double; R: Double; R_In_Pixels: WordBool); safecall;
    procedure InsertBlock(const ElementU: IUnknown); safecall;
    procedure CloseBlock; safecall;
    procedure DrawTexture(const TextureName: WideString; var TextureNum: Integer; X0: Double; 
                          Y0: Double; Z0: Double; X1: Double; Y1: Double; Z1: Double; x2: Double; 
                          y2: Double; z2: Double; x3: Double; y3: Double; z3: Double; NX: Double; 
                          NY: Double; NZ: Double; MX: Double; MY: Double); safecall;
    function CheckVisiblePoint(aCanvasTag: Integer; X: Double; Y: Double; Z: Double): WordBool; safecall;
    procedure Clear; safecall;
    procedure GetTextExtent(const Text: WideString; out Width: Double; out Height: Double); safecall;
    procedure SetFont(const FontName: WideString; FontSize: Integer; FontStyle: Integer; 
                      FontColor: Integer); safecall;
    function Get_IsPrinter: WordBool; safecall;
    procedure Set_IsPrinter(Value: WordBool); safecall;
    property ViewU: IUnknown read Get_ViewU write Set_ViewU;
    property PenColor: Integer read Get_PenColor write Set_PenColor;
    property PenMode: Integer read Get_PenMode write Set_PenMode;
    property PenStyle: Integer read Get_PenStyle write Set_PenStyle;
    property PenWidth: Double read Get_PenWidth write Set_PenWidth;
    property BrushColor: Integer read Get_BrushColor write Set_BrushColor;
    property BrushStyle: Integer read Get_BrushStyle write Set_BrushStyle;
    property HHeight: Integer read Get_HHeight write Set_HHeight;
    property HWidth: Integer read Get_HWidth write Set_HWidth;
    property VWidth: Integer read Get_VWidth write Set_VWidth;
    property VHeight: Integer read Get_VHeight write Set_VHeight;
    property DmaxPix: Integer read Get_DmaxPix write Set_DmaxPix;
    property DminPix: Integer read Get_DminPix write Set_DminPix;
    property ZmaxPix: Integer read Get_ZmaxPix write Set_ZmaxPix;
    property ZminPix: Integer read Get_ZminPix write Set_ZminPix;
    property HCanvasHandle: Integer read Get_HCanvasHandle write Set_HCanvasHandle;
    property VCanvasHandle: Integer read Get_VCanvasHandle write Set_VCanvasHandle;
    property LocalViewU: IUnknown read Get_LocalViewU write Set_LocalViewU;
    property LayerIndex: Integer read Get_LayerIndex write Set_LayerIndex;
    property UseLayers: WordBool read Get_UseLayers;
    property Mode: Integer read Get_Mode write Set_Mode;
    property IsPrinter: WordBool read Get_IsPrinter write Set_IsPrinter;
  end;

// *********************************************************************//
// DispIntf:  IPainterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F4F11495-54EE-4730-80C1-3579EAE51FB1}
// *********************************************************************//
  IPainterDisp = dispinterface
    ['{F4F11495-54EE-4730-80C1-3579EAE51FB1}']
    property ViewU: IUnknown dispid 1;
    property PenColor: Integer dispid 2;
    property PenMode: Integer dispid 3;
    procedure DrawPoint(WX: Double; WY: Double; WZ: Double); dispid 7;
    procedure DrawLine(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; WZ1: Double); dispid 8;
    procedure DrawCurvedLine(PointArray: OleVariant); dispid 9;
    procedure DrawPolygon(const Lines: IDMCollection; Vertical: WordBool); dispid 10;
    procedure DrawPicture(P0X: Double; P0Y: Double; P0Z: Double; P1X: Double; P1Y: Double; 
                          P1Z: Double; P3X: Double; P3Y: Double; P3Z: Double; P4X: Double; 
                          P4Y: Double; P4Z: Double; aAngle: Double; PictureHandle: LongWord; 
                          PictureFMT: Integer; Alpha: Integer); dispid 11;
    property PenStyle: Integer dispid 4;
    property PenWidth: Double dispid 5;
    property BrushColor: Integer dispid 6;
    property BrushStyle: Integer dispid 12;
    property HHeight: Integer dispid 13;
    property HWidth: Integer dispid 14;
    property VWidth: Integer dispid 17;
    procedure DrawAxes(XP: Integer; YP: Integer; ZP: Integer); dispid 22;
    procedure SetRangePix; dispid 23;
    property VHeight: Integer dispid 28;
    procedure DrawRangeMarks; dispid 32;
    property DmaxPix: Integer dispid 33;
    property DminPix: Integer dispid 34;
    property ZmaxPix: Integer dispid 35;
    property ZminPix: Integer dispid 36;
    property HCanvasHandle: Integer dispid 37;
    property VCanvasHandle: Integer dispid 38;
    procedure WP_To_P(WX: Double; WY: Double; WZ: Double; out PX: Integer; out PY: Integer; 
                      out PZ: Integer); dispid 15;
    procedure P_To_WP(PX: Integer; PY: Integer; Tag: Integer; out WX: Double; out WY: Double; 
                      out WZ: Double); dispid 16;
    procedure DrawRectangle(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; 
                            WZ1: Double; Angle: Double); dispid 18;
    property LocalViewU: IUnknown dispid 19;
    procedure DrawText(WX: Double; WY: Double; WZ: Double; const Text: WideString; 
                       TextSize: Double; const FontName: WideString; FontSize: Integer; 
                       FontColor: Integer; FontStyle: Integer; ScaleMode: Integer); dispid 20;
    property LayerIndex: Integer dispid 21;
    property UseLayers: WordBool readonly dispid 24;
    procedure DrawArc(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; WZ1: Double; 
                      WX2: Double; WY2: Double; WZ2: Double); dispid 25;
    procedure SetLimits; dispid 26;
    function LineIsVisible(aCanvasTag: Integer; var X0: Double; var Y0: Double; var Z0: Double; 
                           var X1: Double; var Y1: Double; var Z1: Double; FittoCanvas: WordBool; 
                           CanvasLevel: Integer): WordBool; dispid 27;
    property Mode: Integer dispid 30;
    procedure DrawCircle(WX: Double; WY: Double; WZ: Double; R: Double; R_In_Pixels: WordBool); dispid 29;
    procedure InsertBlock(const ElementU: IUnknown); dispid 31;
    procedure CloseBlock; dispid 39;
    procedure DrawTexture(const TextureName: WideString; var TextureNum: Integer; X0: Double; 
                          Y0: Double; Z0: Double; X1: Double; Y1: Double; Z1: Double; x2: Double; 
                          y2: Double; z2: Double; x3: Double; y3: Double; z3: Double; NX: Double; 
                          NY: Double; NZ: Double; MX: Double; MY: Double); dispid 40;
    function CheckVisiblePoint(aCanvasTag: Integer; X: Double; Y: Double; Z: Double): WordBool; dispid 41;
    procedure Clear; dispid 42;
    procedure GetTextExtent(const Text: WideString; out Width: Double; out Height: Double); dispid 43;
    procedure SetFont(const FontName: WideString; FontSize: Integer; FontStyle: Integer; 
                      FontColor: Integer); dispid 44;
    property IsPrinter: WordBool dispid 45;
  end;

// *********************************************************************//
// Interface: IPainter3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {48AB0E2B-34B3-4FF5-AC5A-E2187CB1E146}
// *********************************************************************//
  IPainter3 = interface(IDispatch)
    ['{48AB0E2B-34B3-4FF5-AC5A-E2187CB1E146}']
    function Get_CanvasSet: Integer; safecall;
    procedure Set_CanvasSet(Value: Integer); safecall;
    procedure FastDraw; safecall;
    procedure ResizeBack(Flag: Integer); safecall;
    procedure FlipFrontBack; safecall;
    procedure SaveCenterPos; safecall;
    procedure FlipBackCanvas; safecall;
    procedure GetTextExtent(const Text: WideString; out Width: Double; out Height: Double); safecall;
    procedure SetFont(const FontName: WideString; FontSize: Integer; FontStyle: Integer; 
                      FontColor: Integer); safecall;
    function Get_IsPrinter: WordBool; safecall;
    procedure Set_IsPrinter(Value: WordBool); safecall;
    property CanvasSet: Integer read Get_CanvasSet write Set_CanvasSet;
    property IsPrinter: WordBool read Get_IsPrinter write Set_IsPrinter;
  end;

// *********************************************************************//
// DispIntf:  IPainter3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {48AB0E2B-34B3-4FF5-AC5A-E2187CB1E146}
// *********************************************************************//
  IPainter3Disp = dispinterface
    ['{48AB0E2B-34B3-4FF5-AC5A-E2187CB1E146}']
    property CanvasSet: Integer dispid 1;
    procedure FastDraw; dispid 2;
    procedure ResizeBack(Flag: Integer); dispid 3;
    procedure FlipFrontBack; dispid 4;
    procedure SaveCenterPos; dispid 5;
    procedure FlipBackCanvas; dispid 6;
    procedure GetTextExtent(const Text: WideString; out Width: Double; out Height: Double); dispid 8;
    procedure SetFont(const FontName: WideString; FontSize: Integer; FontStyle: Integer; 
                      FontColor: Integer); dispid 9;
    property IsPrinter: WordBool dispid 10;
  end;

// *********************************************************************//
// The Class CoPainter provides a Create and CreateRemote method to          
// create instances of the default interface IPainter exposed by              
// the CoClass Painter. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPainter = class
    class function Create: IPainter;
    class function CreateRemote(const MachineName: string): IPainter;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPainter
// Help String      : Painter Object
// Default Interface: IPainter
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPainterProperties= class;
{$ENDIF}
  TPainter = class(TOleServer)
  private
    FIntf:        IPainter;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPainterProperties;
    function      GetServerProperties: TPainterProperties;
{$ENDIF}
    function      GetDefaultInterface: IPainter;
  protected
    procedure InitServerData; override;
    function Get_ViewU: IUnknown;
    procedure Set_ViewU(const Value: IUnknown);
    function Get_PenColor: Integer;
    procedure Set_PenColor(Value: Integer);
    function Get_PenMode: Integer;
    procedure Set_PenMode(Value: Integer);
    function Get_PenStyle: Integer;
    procedure Set_PenStyle(Value: Integer);
    function Get_PenWidth: Double;
    procedure Set_PenWidth(Value: Double);
    function Get_BrushColor: Integer;
    procedure Set_BrushColor(Value: Integer);
    function Get_BrushStyle: Integer;
    procedure Set_BrushStyle(Value: Integer);
    function Get_HHeight: Integer;
    procedure Set_HHeight(Value: Integer);
    function Get_HWidth: Integer;
    procedure Set_HWidth(Value: Integer);
    function Get_VWidth: Integer;
    procedure Set_VWidth(Value: Integer);
    function Get_VHeight: Integer;
    procedure Set_VHeight(Value: Integer);
    function Get_DmaxPix: Integer;
    procedure Set_DmaxPix(Value: Integer);
    function Get_DminPix: Integer;
    procedure Set_DminPix(Value: Integer);
    function Get_ZmaxPix: Integer;
    procedure Set_ZmaxPix(Value: Integer);
    function Get_ZminPix: Integer;
    procedure Set_ZminPix(Value: Integer);
    function Get_HCanvasHandle: Integer;
    procedure Set_HCanvasHandle(Value: Integer);
    function Get_VCanvasHandle: Integer;
    procedure Set_VCanvasHandle(Value: Integer);
    function Get_LocalViewU: IUnknown;
    procedure Set_LocalViewU(const Value: IUnknown);
    function Get_LayerIndex: Integer;
    procedure Set_LayerIndex(Value: Integer);
    function Get_UseLayers: WordBool;
    function Get_Mode: Integer;
    procedure Set_Mode(Value: Integer);
    function Get_IsPrinter: WordBool;
    procedure Set_IsPrinter(Value: WordBool);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IPainter);
    procedure Disconnect; override;
    procedure DrawPoint(WX: Double; WY: Double; WZ: Double);
    procedure DrawLine(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; WZ1: Double);
    procedure DrawCurvedLine(PointArray: OleVariant);
    procedure DrawPolygon(const Lines: IDMCollection; Vertical: WordBool);
    procedure DrawPicture(P0X: Double; P0Y: Double; P0Z: Double; P1X: Double; P1Y: Double; 
                          P1Z: Double; P3X: Double; P3Y: Double; P3Z: Double; P4X: Double; 
                          P4Y: Double; P4Z: Double; aAngle: Double; PictureHandle: LongWord; 
                          PictureFMT: Integer; Alpha: Integer);
    procedure DrawAxes(XP: Integer; YP: Integer; ZP: Integer);
    procedure SetRangePix;
    procedure DrawRangeMarks;
    procedure WP_To_P(WX: Double; WY: Double; WZ: Double; out PX: Integer; out PY: Integer; 
                      out PZ: Integer);
    procedure P_To_WP(PX: Integer; PY: Integer; Tag: Integer; out WX: Double; out WY: Double; 
                      out WZ: Double);
    procedure DrawRectangle(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; 
                            WZ1: Double; Angle: Double);
    procedure DrawText(WX: Double; WY: Double; WZ: Double; const Text: WideString; 
                       TextSize: Double; const FontName: WideString; FontSize: Integer; 
                       FontColor: Integer; FontStyle: Integer; ScaleMode: Integer);
    procedure DrawArc(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; WZ1: Double; 
                      WX2: Double; WY2: Double; WZ2: Double);
    procedure SetLimits;
    function LineIsVisible(aCanvasTag: Integer; var X0: Double; var Y0: Double; var Z0: Double; 
                           var X1: Double; var Y1: Double; var Z1: Double; FittoCanvas: WordBool; 
                           CanvasLevel: Integer): WordBool;
    procedure DrawCircle(WX: Double; WY: Double; WZ: Double; R: Double; R_In_Pixels: WordBool);
    procedure InsertBlock(const ElementU: IUnknown);
    procedure CloseBlock;
    procedure DrawTexture(const TextureName: WideString; var TextureNum: Integer; X0: Double; 
                          Y0: Double; Z0: Double; X1: Double; Y1: Double; Z1: Double; x2: Double; 
                          y2: Double; z2: Double; x3: Double; y3: Double; z3: Double; NX: Double; 
                          NY: Double; NZ: Double; MX: Double; MY: Double);
    function CheckVisiblePoint(aCanvasTag: Integer; X: Double; Y: Double; Z: Double): WordBool;
    procedure Clear;
    procedure GetTextExtent(const Text: WideString; out Width: Double; out Height: Double);
    procedure SetFont(const FontName: WideString; FontSize: Integer; FontStyle: Integer; 
                      FontColor: Integer);
    property DefaultInterface: IPainter read GetDefaultInterface;
    property ViewU: IUnknown read Get_ViewU write Set_ViewU;
    property LocalViewU: IUnknown read Get_LocalViewU write Set_LocalViewU;
    property UseLayers: WordBool read Get_UseLayers;
    property PenColor: Integer read Get_PenColor write Set_PenColor;
    property PenMode: Integer read Get_PenMode write Set_PenMode;
    property PenStyle: Integer read Get_PenStyle write Set_PenStyle;
    property PenWidth: Double read Get_PenWidth write Set_PenWidth;
    property BrushColor: Integer read Get_BrushColor write Set_BrushColor;
    property BrushStyle: Integer read Get_BrushStyle write Set_BrushStyle;
    property HHeight: Integer read Get_HHeight write Set_HHeight;
    property HWidth: Integer read Get_HWidth write Set_HWidth;
    property VWidth: Integer read Get_VWidth write Set_VWidth;
    property VHeight: Integer read Get_VHeight write Set_VHeight;
    property DmaxPix: Integer read Get_DmaxPix write Set_DmaxPix;
    property DminPix: Integer read Get_DminPix write Set_DminPix;
    property ZmaxPix: Integer read Get_ZmaxPix write Set_ZmaxPix;
    property ZminPix: Integer read Get_ZminPix write Set_ZminPix;
    property HCanvasHandle: Integer read Get_HCanvasHandle write Set_HCanvasHandle;
    property VCanvasHandle: Integer read Get_VCanvasHandle write Set_VCanvasHandle;
    property LayerIndex: Integer read Get_LayerIndex write Set_LayerIndex;
    property Mode: Integer read Get_Mode write Set_Mode;
    property IsPrinter: WordBool read Get_IsPrinter write Set_IsPrinter;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPainterProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPainter
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPainterProperties = class(TPersistent)
  private
    FServer:    TPainter;
    function    GetDefaultInterface: IPainter;
    constructor Create(AServer: TPainter);
  protected
    function Get_ViewU: IUnknown;
    procedure Set_ViewU(const Value: IUnknown);
    function Get_PenColor: Integer;
    procedure Set_PenColor(Value: Integer);
    function Get_PenMode: Integer;
    procedure Set_PenMode(Value: Integer);
    function Get_PenStyle: Integer;
    procedure Set_PenStyle(Value: Integer);
    function Get_PenWidth: Double;
    procedure Set_PenWidth(Value: Double);
    function Get_BrushColor: Integer;
    procedure Set_BrushColor(Value: Integer);
    function Get_BrushStyle: Integer;
    procedure Set_BrushStyle(Value: Integer);
    function Get_HHeight: Integer;
    procedure Set_HHeight(Value: Integer);
    function Get_HWidth: Integer;
    procedure Set_HWidth(Value: Integer);
    function Get_VWidth: Integer;
    procedure Set_VWidth(Value: Integer);
    function Get_VHeight: Integer;
    procedure Set_VHeight(Value: Integer);
    function Get_DmaxPix: Integer;
    procedure Set_DmaxPix(Value: Integer);
    function Get_DminPix: Integer;
    procedure Set_DminPix(Value: Integer);
    function Get_ZmaxPix: Integer;
    procedure Set_ZmaxPix(Value: Integer);
    function Get_ZminPix: Integer;
    procedure Set_ZminPix(Value: Integer);
    function Get_HCanvasHandle: Integer;
    procedure Set_HCanvasHandle(Value: Integer);
    function Get_VCanvasHandle: Integer;
    procedure Set_VCanvasHandle(Value: Integer);
    function Get_LocalViewU: IUnknown;
    procedure Set_LocalViewU(const Value: IUnknown);
    function Get_LayerIndex: Integer;
    procedure Set_LayerIndex(Value: Integer);
    function Get_UseLayers: WordBool;
    function Get_Mode: Integer;
    procedure Set_Mode(Value: Integer);
    function Get_IsPrinter: WordBool;
    procedure Set_IsPrinter(Value: WordBool);
  public
    property DefaultInterface: IPainter read GetDefaultInterface;
  published
    property PenColor: Integer read Get_PenColor write Set_PenColor;
    property PenMode: Integer read Get_PenMode write Set_PenMode;
    property PenStyle: Integer read Get_PenStyle write Set_PenStyle;
    property PenWidth: Double read Get_PenWidth write Set_PenWidth;
    property BrushColor: Integer read Get_BrushColor write Set_BrushColor;
    property BrushStyle: Integer read Get_BrushStyle write Set_BrushStyle;
    property HHeight: Integer read Get_HHeight write Set_HHeight;
    property HWidth: Integer read Get_HWidth write Set_HWidth;
    property VWidth: Integer read Get_VWidth write Set_VWidth;
    property VHeight: Integer read Get_VHeight write Set_VHeight;
    property DmaxPix: Integer read Get_DmaxPix write Set_DmaxPix;
    property DminPix: Integer read Get_DminPix write Set_DminPix;
    property ZmaxPix: Integer read Get_ZmaxPix write Set_ZmaxPix;
    property ZminPix: Integer read Get_ZminPix write Set_ZminPix;
    property HCanvasHandle: Integer read Get_HCanvasHandle write Set_HCanvasHandle;
    property VCanvasHandle: Integer read Get_VCanvasHandle write Set_VCanvasHandle;
    property LayerIndex: Integer read Get_LayerIndex write Set_LayerIndex;
    property Mode: Integer read Get_Mode write Set_Mode;
    property IsPrinter: WordBool read Get_IsPrinter write Set_IsPrinter;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoPainter.Create: IPainter;
begin
  Result := CreateComObject(CLASS_Painter) as IPainter;
end;

class function CoPainter.CreateRemote(const MachineName: string): IPainter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Painter) as IPainter;
end;

procedure TPainter.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2E1FDC40-4EF1-4DD7-AA69-92B6375291FB}';
    IntfIID:   '{F4F11495-54EE-4730-80C1-3579EAE51FB1}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPainter.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IPainter;
  end;
end;

procedure TPainter.ConnectTo(svrIntf: IPainter);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPainter.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPainter.GetDefaultInterface: IPainter;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPainter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPainterProperties.Create(Self);
{$ENDIF}
end;

destructor TPainter.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPainter.GetServerProperties: TPainterProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TPainter.Get_ViewU: IUnknown;
begin
    Result := DefaultInterface.ViewU;
end;

procedure TPainter.Set_ViewU(const Value: IUnknown);
begin
  Exit;
end;

function TPainter.Get_PenColor: Integer;
begin
    Result := DefaultInterface.PenColor;
end;

procedure TPainter.Set_PenColor(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_PenMode: Integer;
begin
    Result := DefaultInterface.PenMode;
end;

procedure TPainter.Set_PenMode(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_PenStyle: Integer;
begin
    Result := DefaultInterface.PenStyle;
end;

procedure TPainter.Set_PenStyle(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_PenWidth: Double;
begin
    Result := DefaultInterface.PenWidth;
end;

procedure TPainter.Set_PenWidth(Value: Double);
begin
  Exit;
end;

function TPainter.Get_BrushColor: Integer;
begin
    Result := DefaultInterface.BrushColor;
end;

procedure TPainter.Set_BrushColor(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_BrushStyle: Integer;
begin
    Result := DefaultInterface.BrushStyle;
end;

procedure TPainter.Set_BrushStyle(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_HHeight: Integer;
begin
    Result := DefaultInterface.HHeight;
end;

procedure TPainter.Set_HHeight(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_HWidth: Integer;
begin
    Result := DefaultInterface.HWidth;
end;

procedure TPainter.Set_HWidth(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_VWidth: Integer;
begin
    Result := DefaultInterface.VWidth;
end;

procedure TPainter.Set_VWidth(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_VHeight: Integer;
begin
    Result := DefaultInterface.VHeight;
end;

procedure TPainter.Set_VHeight(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_DmaxPix: Integer;
begin
    Result := DefaultInterface.DmaxPix;
end;

procedure TPainter.Set_DmaxPix(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_DminPix: Integer;
begin
    Result := DefaultInterface.DminPix;
end;

procedure TPainter.Set_DminPix(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_ZmaxPix: Integer;
begin
    Result := DefaultInterface.ZmaxPix;
end;

procedure TPainter.Set_ZmaxPix(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_ZminPix: Integer;
begin
    Result := DefaultInterface.ZminPix;
end;

procedure TPainter.Set_ZminPix(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_HCanvasHandle: Integer;
begin
    Result := DefaultInterface.HCanvasHandle;
end;

procedure TPainter.Set_HCanvasHandle(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_VCanvasHandle: Integer;
begin
    Result := DefaultInterface.VCanvasHandle;
end;

procedure TPainter.Set_VCanvasHandle(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_LocalViewU: IUnknown;
begin
    Result := DefaultInterface.LocalViewU;
end;

procedure TPainter.Set_LocalViewU(const Value: IUnknown);
begin
  Exit;
end;

function TPainter.Get_LayerIndex: Integer;
begin
    Result := DefaultInterface.LayerIndex;
end;

procedure TPainter.Set_LayerIndex(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_UseLayers: WordBool;
begin
    Result := DefaultInterface.UseLayers;
end;

function TPainter.Get_Mode: Integer;
begin
    Result := DefaultInterface.Mode;
end;

procedure TPainter.Set_Mode(Value: Integer);
begin
  Exit;
end;

function TPainter.Get_IsPrinter: WordBool;
begin
    Result := DefaultInterface.IsPrinter;
end;

procedure TPainter.Set_IsPrinter(Value: WordBool);
begin
  Exit;
end;

procedure TPainter.DrawPoint(WX: Double; WY: Double; WZ: Double);
begin
  DefaultInterface.DrawPoint(WX, WY, WZ);
end;

procedure TPainter.DrawLine(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; 
                            WZ1: Double);
begin
  DefaultInterface.DrawLine(WX0, WY0, WZ0, WX1, WY1, WZ1);
end;

procedure TPainter.DrawCurvedLine(PointArray: OleVariant);
begin
  DefaultInterface.DrawCurvedLine(PointArray);
end;

procedure TPainter.DrawPolygon(const Lines: IDMCollection; Vertical: WordBool);
begin
  DefaultInterface.DrawPolygon(Lines, Vertical);
end;

procedure TPainter.DrawPicture(P0X: Double; P0Y: Double; P0Z: Double; P1X: Double; P1Y: Double; 
                               P1Z: Double; P3X: Double; P3Y: Double; P3Z: Double; P4X: Double; 
                               P4Y: Double; P4Z: Double; aAngle: Double; PictureHandle: LongWord; 
                               PictureFMT: Integer; Alpha: Integer);
begin
  DefaultInterface.DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z, P3X, P3Y, P3Z, P4X, P4Y, P4Z, aAngle, 
                               PictureHandle, PictureFMT, Alpha);
end;

procedure TPainter.DrawAxes(XP: Integer; YP: Integer; ZP: Integer);
begin
  DefaultInterface.DrawAxes(XP, YP, ZP);
end;

procedure TPainter.SetRangePix;
begin
  DefaultInterface.SetRangePix;
end;

procedure TPainter.DrawRangeMarks;
begin
  DefaultInterface.DrawRangeMarks;
end;

procedure TPainter.WP_To_P(WX: Double; WY: Double; WZ: Double; out PX: Integer; out PY: Integer; 
                           out PZ: Integer);
begin
  DefaultInterface.WP_To_P(WX, WY, WZ, PX, PY, PZ);
end;

procedure TPainter.P_To_WP(PX: Integer; PY: Integer; Tag: Integer; out WX: Double; out WY: Double; 
                           out WZ: Double);
begin
  DefaultInterface.P_To_WP(PX, PY, Tag, WX, WY, WZ);
end;

procedure TPainter.DrawRectangle(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; 
                                 WZ1: Double; Angle: Double);
begin
  DefaultInterface.DrawRectangle(WX0, WY0, WZ0, WX1, WY1, WZ1, Angle);
end;

procedure TPainter.DrawText(WX: Double; WY: Double; WZ: Double; const Text: WideString; 
                            TextSize: Double; const FontName: WideString; FontSize: Integer; 
                            FontColor: Integer; FontStyle: Integer; ScaleMode: Integer);
begin
  DefaultInterface.DrawText(WX, WY, WZ, Text, TextSize, FontName, FontSize, FontColor, FontStyle, 
                            ScaleMode);
end;

procedure TPainter.DrawArc(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; 
                           WZ1: Double; WX2: Double; WY2: Double; WZ2: Double);
begin
  DefaultInterface.DrawArc(WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, WZ2);
end;

procedure TPainter.SetLimits;
begin
  DefaultInterface.SetLimits;
end;

function TPainter.LineIsVisible(aCanvasTag: Integer; var X0: Double; var Y0: Double; 
                                var Z0: Double; var X1: Double; var Y1: Double; var Z1: Double; 
                                FittoCanvas: WordBool; CanvasLevel: Integer): WordBool;
begin
  Result := DefaultInterface.LineIsVisible(aCanvasTag, X0, Y0, Z0, X1, Y1, Z1, FittoCanvas, 
                                           CanvasLevel);
end;

procedure TPainter.DrawCircle(WX: Double; WY: Double; WZ: Double; R: Double; R_In_Pixels: WordBool);
begin
  DefaultInterface.DrawCircle(WX, WY, WZ, R, R_In_Pixels);
end;

procedure TPainter.InsertBlock(const ElementU: IUnknown);
begin
  DefaultInterface.InsertBlock(ElementU);
end;

procedure TPainter.CloseBlock;
begin
  DefaultInterface.CloseBlock;
end;

procedure TPainter.DrawTexture(const TextureName: WideString; var TextureNum: Integer; X0: Double; 
                               Y0: Double; Z0: Double; X1: Double; Y1: Double; Z1: Double; 
                               x2: Double; y2: Double; z2: Double; x3: Double; y3: Double; 
                               z3: Double; NX: Double; NY: Double; NZ: Double; MX: Double; 
                               MY: Double);
begin
  DefaultInterface.DrawTexture(TextureName, TextureNum, X0, Y0, Z0, X1, Y1, Z1, x2, y2, z2, x3, y3, 
                               z3, NX, NY, NZ, MX, MY);
end;

function TPainter.CheckVisiblePoint(aCanvasTag: Integer; X: Double; Y: Double; Z: Double): WordBool;
begin
  Result := DefaultInterface.CheckVisiblePoint(aCanvasTag, X, Y, Z);
end;

procedure TPainter.Clear;
begin
  DefaultInterface.Clear;
end;

procedure TPainter.GetTextExtent(const Text: WideString; out Width: Double; out Height: Double);
begin
  DefaultInterface.GetTextExtent(Text, Width, Height);
end;

procedure TPainter.SetFont(const FontName: WideString; FontSize: Integer; FontStyle: Integer; 
                           FontColor: Integer);
begin
  DefaultInterface.SetFont(FontName, FontSize, FontStyle, FontColor);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPainterProperties.Create(AServer: TPainter);
begin
  inherited Create;
  FServer := AServer;
end;

function TPainterProperties.GetDefaultInterface: IPainter;
begin
  Result := FServer.DefaultInterface;
end;

function TPainterProperties.Get_ViewU: IUnknown;
begin
    Result := DefaultInterface.ViewU;
end;

procedure TPainterProperties.Set_ViewU(const Value: IUnknown);
begin
  Exit;
end;

function TPainterProperties.Get_PenColor: Integer;
begin
    Result := DefaultInterface.PenColor;
end;

procedure TPainterProperties.Set_PenColor(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_PenMode: Integer;
begin
    Result := DefaultInterface.PenMode;
end;

procedure TPainterProperties.Set_PenMode(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_PenStyle: Integer;
begin
    Result := DefaultInterface.PenStyle;
end;

procedure TPainterProperties.Set_PenStyle(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_PenWidth: Double;
begin
    Result := DefaultInterface.PenWidth;
end;

procedure TPainterProperties.Set_PenWidth(Value: Double);
begin
  Exit;
end;

function TPainterProperties.Get_BrushColor: Integer;
begin
    Result := DefaultInterface.BrushColor;
end;

procedure TPainterProperties.Set_BrushColor(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_BrushStyle: Integer;
begin
    Result := DefaultInterface.BrushStyle;
end;

procedure TPainterProperties.Set_BrushStyle(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_HHeight: Integer;
begin
    Result := DefaultInterface.HHeight;
end;

procedure TPainterProperties.Set_HHeight(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_HWidth: Integer;
begin
    Result := DefaultInterface.HWidth;
end;

procedure TPainterProperties.Set_HWidth(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_VWidth: Integer;
begin
    Result := DefaultInterface.VWidth;
end;

procedure TPainterProperties.Set_VWidth(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_VHeight: Integer;
begin
    Result := DefaultInterface.VHeight;
end;

procedure TPainterProperties.Set_VHeight(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_DmaxPix: Integer;
begin
    Result := DefaultInterface.DmaxPix;
end;

procedure TPainterProperties.Set_DmaxPix(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_DminPix: Integer;
begin
    Result := DefaultInterface.DminPix;
end;

procedure TPainterProperties.Set_DminPix(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_ZmaxPix: Integer;
begin
    Result := DefaultInterface.ZmaxPix;
end;

procedure TPainterProperties.Set_ZmaxPix(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_ZminPix: Integer;
begin
    Result := DefaultInterface.ZminPix;
end;

procedure TPainterProperties.Set_ZminPix(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_HCanvasHandle: Integer;
begin
    Result := DefaultInterface.HCanvasHandle;
end;

procedure TPainterProperties.Set_HCanvasHandle(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_VCanvasHandle: Integer;
begin
    Result := DefaultInterface.VCanvasHandle;
end;

procedure TPainterProperties.Set_VCanvasHandle(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_LocalViewU: IUnknown;
begin
    Result := DefaultInterface.LocalViewU;
end;

procedure TPainterProperties.Set_LocalViewU(const Value: IUnknown);
begin
  Exit;
end;

function TPainterProperties.Get_LayerIndex: Integer;
begin
    Result := DefaultInterface.LayerIndex;
end;

procedure TPainterProperties.Set_LayerIndex(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_UseLayers: WordBool;
begin
    Result := DefaultInterface.UseLayers;
end;

function TPainterProperties.Get_Mode: Integer;
begin
    Result := DefaultInterface.Mode;
end;

procedure TPainterProperties.Set_Mode(Value: Integer);
begin
  Exit;
end;

function TPainterProperties.Get_IsPrinter: WordBool;
begin
    Result := DefaultInterface.IsPrinter;
end;

procedure TPainterProperties.Set_IsPrinter(Value: WordBool);
begin
  Exit;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TPainter]);
end;

end.
