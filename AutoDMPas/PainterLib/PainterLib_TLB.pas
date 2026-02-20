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
// File generated on 02.10.2007 13:12:15 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\Volkov\AutoDM\AutoDMPas\PainterLib\PainterLib.tlb (1)
// LIBID: {F949EC5E-E93E-46C1-B4CA-CD540C4E3512}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
//   (2) v1.0 DataModel, (D:\users\Volkov\AutoDM\AutoDMPas\DataModel\DataModel.tlb)
//   (3) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, DataModel_TLB, Graphics, StdVCL, Variants;
  

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

end.
