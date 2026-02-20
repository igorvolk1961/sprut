unit SpatialModelLib_TLB;

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
// File generated on 07.06.2007 20:09:11 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\users\volkov\AutoDM\bin\SpatialModelLib.dll (1)
// LIBID: {62264B07-E560-11D5-92FE-0050BA51A6D3}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v1.0 DataModel, (D:\users\volkov\AutoDM\AutoDMPas\DataModel\DataModel.tlb)
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
  SpatialModelLibMajorVersion = 1;
  SpatialModelLibMinorVersion = 0;

  LIBID_SpatialModelLib: TGUID = '{62264B07-E560-11D5-92FE-0050BA51A6D3}';

  IID_ISMDocument: TGUID = '{62264B1A-E560-11D5-92FE-0050BA51A6D3}';
  DIID_ISMDocumentEvents: TGUID = '{62264B1C-E560-11D5-92FE-0050BA51A6D3}';
  IID_IPainter: TGUID = '{62264B16-E560-11D5-92FE-0050BA51A6D3}';
  IID_ISpatialModel2: TGUID = '{62264B3F-E560-11D5-92FE-0050BA51A6D3}';
  IID_ISMOperationManager: TGUID = '{B82E1AD7-F3AA-11D5-930A-0050BA51A6D3}';
  IID_ILayer: TGUID = '{62264B21-E560-11D5-92FE-0050BA51A6D3}';
  IID_ICurvedLine: TGUID = '{62264B27-E560-11D5-92FE-0050BA51A6D3}';
  IID_IImageRect: TGUID = '{62264B31-E560-11D5-92FE-0050BA51A6D3}';
  IID_ISMFont: TGUID = '{802DBCB3-8370-11D6-972A-0050BA51A6D3}';
  IID_ICoordNode: TGUID = '{62264B23-E560-11D5-92FE-0050BA51A6D3}';
  IID_ILine: TGUID = '{62264B25-E560-11D5-92FE-0050BA51A6D3}';
  IID_IPolyline: TGUID = '{62264B29-E560-11D5-92FE-0050BA51A6D3}';
  IID_IArea: TGUID = '{62264B2B-E560-11D5-92FE-0050BA51A6D3}';
  IID_IVolume: TGUID = '{62264B2D-E560-11D5-92FE-0050BA51A6D3}';
  IID_IView: TGUID = '{62264B2F-E560-11D5-92FE-0050BA51A6D3}';
  IID_ISpatialElement: TGUID = '{62264B33-E560-11D5-92FE-0050BA51A6D3}';
  IID_ISpatialModel: TGUID = '{A51797CF-578B-4A2B-AD7F-7B97A2AF45EF}';
  IID_ISMLabel: TGUID = '{802DBCB1-8370-11D6-972A-0050BA51A6D3}';
  IID_ILineGroup: TGUID = '{7FB0B801-1864-11D9-9A07-0050BA51A6D3}';
  CLASS_Painter: TGUID = '{62264B18-E560-11D5-92FE-0050BA51A6D3}';
  CLASS_SMDocument: TGUID = '{62264B1E-E560-11D5-92FE-0050BA51A6D3}';
  CLASS_SpatialModel: TGUID = '{62264B0A-E560-11D5-92FE-0050BA51A6D3}';
  IID_IVolumeBuilder: TGUID = '{43380B81-916F-11D9-9A87-0050BA51A6D3}';
  IID_IVolume2: TGUID = '{8B8E7D43-E149-11D9-9ADE-0050BA51A6D3}';
  IID_IPainter3: TGUID = '{CBDE9B2B-A453-4229-A8FE-EECF9D504B78}';
  IID_ISpatialModel3: TGUID = '{A3DA6407-0BA8-4FB5-A446-55B6CA0F2FE7}';
  IID_ICircle: TGUID = '{EF731B99-BB53-4682-BC39-1E85B9294F4D}';
  IID_IRotater: TGUID = '{5765BAA6-4851-4EC7-977D-A5CA5867179E}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum SpatialModelClass
type
  SpatialModelClass = TOleEnum;
const
  _Layer = $00000000;
  _SMFont = $00000001;
  _CoordNode = $00000002;
  _Line = $00000003;
  _CurvedLine = $00000004;
  _PolyLine = $00000005;
  _Area = $00000006;
  _SMLabel = $00000007;
  _Volume = $00000008;
  _View = $00000009;
  _ImageRect = $0000000A;
  _LineGroup = $00000069;
  _Circle = $0000006E;

// Constants for enum ShiftState
type
  ShiftState = TOleEnum;
const
  sShift = $00000001;
  sAlt = $00000002;
  sCtrl = $00000004;
  sLeft = $00000008;
  sRight = $00000010;
  sMiddle = $00000020;
  sDouble = $00000040;
  sProgram = $00000041;

// Constants for enum TSMOperation
type
  TSMOperation = TOleEnum;
const
  smoSelectLine = $00000000;
  smoSelectClosedPolyLine = $00000001;
  smoSelectCoordNode = $00000002;
  smoCreateLine = $00000003;
  smoCreatePolyLine = $00000004;
  smoCreateClosedPolyLine = $00000005;
  smoCreateRectangle = $00000006;
  smoCreateCurvedLine = $00000007;
  smoCreateEllipse = $00000008;
  smoCreateCoordNode = $00000009;
  smoDeleteSelected = $0000000A;
  smoMoveSelected = $0000000B;
  smoScaleSelected = $0000000C;
  smoRotateSelected = $0000000D;
  smoBreakLine = $0000000E;
  smoTrimExtendToSelected = $0000000F;
  smoIntersectSelected = $00000010;
  smoSelectVerticalArea = $00000011;
  smoSelectVolume = $00000012;
  smoCreateImageRect = $00000013;
  smoZoomIn = $00000014;
  smoZoomOut = $00000015;
  smoViewPan = $00000016;
  smoCreateInclinedRectangle = $00000017;
  smoBuildVolume = $00000018;
  smoSelectVerticalLine = $00000019;
  smoDoubleBreakLine = $0000001A;
  smoSelectImage = $0000001B;
  smoBuildArrayObject = $0000001C;
  smoBuildLineObject = $0000001D;
  smoBuildVerticalArea = $0000001E;
  smoDivideVolume = $0000001F;
  smoBuildPolylineObject = $00000020;
  smoSideView = $00000021;
  smoPalette = $00000022;
  smoBuildRelief = $00000023;
  smoZoomSelection = $00000024;
  smoOutlineSelected = $00000025;
  smoSelectLabel = $00000026;
  smoSelectAll = $00000027;
  smoBuildSectors = $00000028;
  smoBuildArea = $00000029;
  smoMirrorSelected = $0000002A;
  smoCreateCircle = $0000002B;

// Constants for enum TReorderLinesResult
type
  TReorderLinesResult = TOleEnum;
const
  rlrError = $FFFFFFFF;
  rlrNothingSpecial = $00000000;
  rlrPolyline = $00000001;
  rlrClosedPolyline = $00000002;

// Constants for enum TBuildDirection
type
  TBuildDirection = TOleEnum;
const
  bdUp = $00000000;
  bdDown = $00000001;

// Constants for enum TSnapMode
type
  TSnapMode = TOleEnum;
const
  smoSnapNone = $00000064;
  smoSnapToNode = $00000065;
  smoSnapOrtToLine = $00000066;
  smoSnapToNearestOnLine = $00000067;
  smoSnapToMiddleOfLine = $00000068;
  smoSnapToLocalGrid = $00000069;

// Constants for enum TMiscAction
type
  TMiscAction = TOleEnum;
const
  smoRedraw = $0000006E;
  smoCrossline = $0000006F;
  smoLastView = $00000070;

// Constants for enum TSMFontStyle
type
  TSMFontStyle = TOleEnum;
const
  _fsBold = $00000000;
  _fsItalic = $00000001;
  _fsUnderline = $00000002;
  _fsStrikeOut = $00000003;

// Constants for enum TViewStoredParam
type
  TViewStoredParam = TOleEnum;
const
  vspZ_ZMin_ZMax = $00000001;
  vspX_Y_Scale = $00000002;
  vspAngle_DMin_DMax = $00000004;

// Constants for enum TAreaFlag
type
  TAreaFlag = TOleEnum;
const
  afIsVertical = $00000001;
  afVolume0IsOuter = $00000002;
  afVolume1IsOuter = $00000004;
  afEmpty = $00000008;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISMDocument = interface;
  ISMDocumentDisp = dispinterface;
  ISMDocumentEvents = dispinterface;
  IPainter = interface;
  IPainterDisp = dispinterface;
  ISpatialModel2 = interface;
  ISpatialModel2Disp = dispinterface;
  ISMOperationManager = interface;
  ISMOperationManagerDisp = dispinterface;
  ILayer = interface;
  ILayerDisp = dispinterface;
  ICurvedLine = interface;
  ICurvedLineDisp = dispinterface;
  IImageRect = interface;
  IImageRectDisp = dispinterface;
  ISMFont = interface;
  ISMFontDisp = dispinterface;
  ICoordNode = interface;
  ICoordNodeDisp = dispinterface;
  ILine = interface;
  ILineDisp = dispinterface;
  IPolyline = interface;
  IPolylineDisp = dispinterface;
  IArea = interface;
  IAreaDisp = dispinterface;
  IVolume = interface;
  IVolumeDisp = dispinterface;
  IView = interface;
  IViewDisp = dispinterface;
  ISpatialElement = interface;
  ISpatialElementDisp = dispinterface;
  ISpatialModel = interface;
  ISpatialModelDisp = dispinterface;
  ISMLabel = interface;
  ISMLabelDisp = dispinterface;
  ILineGroup = interface;
  ILineGroupDisp = dispinterface;
  IVolumeBuilder = interface;
  IVolumeBuilderDisp = dispinterface;
  IVolume2 = interface;
  IVolume2Disp = dispinterface;
  IPainter3 = interface;
  IPainter3Disp = dispinterface;
  ISpatialModel3 = interface;
  ISpatialModel3Disp = dispinterface;
  ICircle = interface;
  ICircleDisp = dispinterface;
  IRotater = interface;
  IRotaterDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Painter = IPainter;
  SMDocument = ISMDocument;
  SpatialModel = ISpatialModel2;


// *********************************************************************//
// Interface: ISMDocument
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B1A-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISMDocument = interface(IDispatch)
    ['{62264B1A-E560-11D5-92FE-0050BA51A6D3}']
    function Get_Painter: IPainter; safecall;
    procedure Set_Painter(const Value: IPainter); safecall;
    function Get_CurrX: Double; safecall;
    function Get_CurrY: Double; safecall;
    function Get_CurrZ: Double; safecall;
    function Get_CurrPX: Integer; safecall;
    function Get_CurrPY: Integer; safecall;
    function Get_CurrPZ: Integer; safecall;
    function Get_HWindowFocused: WordBool; safecall;
    procedure Set_HWindowFocused(Value: WordBool); safecall;
    function Get_VWindowFocused: WordBool; safecall;
    procedure Set_VWindowFocused(Value: WordBool); safecall;
    procedure SetCurrXYZ(aCurrX: Double; aCurrY: Double; aCurrZ: Double); safecall;
    procedure MouseMove(ShiftState: Integer; XP: Integer; YP: Integer; Tag: Integer); safecall;
    procedure MouseDown(ShiftState: Integer); safecall;
    function Get_ShowAxesMode: WordBool; safecall;
    procedure Set_ShowAxesMode(Value: WordBool); safecall;
    procedure ShowAxes; safecall;
    procedure SaveView(const aView: IView); safecall;
    procedure RestoreView; safecall;
    procedure ZoomSelection; safecall;
    procedure MouseDrag; safecall;
    procedure SelectAllNodes; safecall;
    function Get_DontDragMouse: SYSINT; safecall;
    procedure Set_DontDragMouse(Value: SYSINT); safecall;
    function Get_P0X: Integer; safecall;
    function Get_P0Y: Integer; safecall;
    function Get_P0Z: Integer; safecall;
    property Painter: IPainter read Get_Painter write Set_Painter;
    property CurrX: Double read Get_CurrX;
    property CurrY: Double read Get_CurrY;
    property CurrZ: Double read Get_CurrZ;
    property CurrPX: Integer read Get_CurrPX;
    property CurrPY: Integer read Get_CurrPY;
    property CurrPZ: Integer read Get_CurrPZ;
    property HWindowFocused: WordBool read Get_HWindowFocused write Set_HWindowFocused;
    property VWindowFocused: WordBool read Get_VWindowFocused write Set_VWindowFocused;
    property ShowAxesMode: WordBool read Get_ShowAxesMode write Set_ShowAxesMode;
    property DontDragMouse: SYSINT read Get_DontDragMouse write Set_DontDragMouse;
    property P0X: Integer read Get_P0X;
    property P0Y: Integer read Get_P0Y;
    property P0Z: Integer read Get_P0Z;
  end;

// *********************************************************************//
// DispIntf:  ISMDocumentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B1A-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISMDocumentDisp = dispinterface
    ['{62264B1A-E560-11D5-92FE-0050BA51A6D3}']
    property Painter: IPainter dispid 1;
    property CurrX: Double readonly dispid 3;
    property CurrY: Double readonly dispid 4;
    property CurrZ: Double readonly dispid 5;
    property CurrPX: Integer readonly dispid 6;
    property CurrPY: Integer readonly dispid 7;
    property CurrPZ: Integer readonly dispid 8;
    property HWindowFocused: WordBool dispid 9;
    property VWindowFocused: WordBool dispid 10;
    procedure SetCurrXYZ(aCurrX: Double; aCurrY: Double; aCurrZ: Double); dispid 11;
    procedure MouseMove(ShiftState: Integer; XP: Integer; YP: Integer; Tag: Integer); dispid 12;
    procedure MouseDown(ShiftState: Integer); dispid 13;
    property ShowAxesMode: WordBool dispid 14;
    procedure ShowAxes; dispid 15;
    procedure SaveView(const aView: IView); dispid 2;
    procedure RestoreView; dispid 16;
    procedure ZoomSelection; dispid 17;
    procedure MouseDrag; dispid 18;
    procedure SelectAllNodes; dispid 19;
    property DontDragMouse: SYSINT dispid 20;
    property P0X: Integer readonly dispid 21;
    property P0Y: Integer readonly dispid 22;
    property P0Z: Integer readonly dispid 23;
  end;

// *********************************************************************//
// DispIntf:  ISMDocumentEvents
// Flags:     (4096) Dispatchable
// GUID:      {62264B1C-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISMDocumentEvents = dispinterface
    ['{62264B1C-E560-11D5-92FE-0050BA51A6D3}']
  end;

// *********************************************************************//
// Interface: IPainter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B16-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IPainter = interface(IDispatch)
    ['{62264B16-E560-11D5-92FE-0050BA51A6D3}']
    function Get_View: IView; safecall;
    procedure Set_View(const Value: IView); safecall;
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
    function Get_LocalView: IView; safecall;
    procedure Set_LocalView(const Value: IView); safecall;
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
    property View: IView read Get_View write Set_View;
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
    property LocalView: IView read Get_LocalView write Set_LocalView;
    property LayerIndex: Integer read Get_LayerIndex write Set_LayerIndex;
    property UseLayers: WordBool read Get_UseLayers;
    property Mode: Integer read Get_Mode write Set_Mode;
    property IsPrinter: WordBool read Get_IsPrinter write Set_IsPrinter;
  end;

// *********************************************************************//
// DispIntf:  IPainterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B16-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IPainterDisp = dispinterface
    ['{62264B16-E560-11D5-92FE-0050BA51A6D3}']
    property View: IView dispid 1;
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
    property LocalView: IView dispid 19;
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
// Interface: ISpatialModel2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B3F-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISpatialModel2 = interface(IDispatch)
    ['{62264B3F-E560-11D5-92FE-0050BA51A6D3}']
    function Get_Areas: IDMCollection; safecall;
    function Get_Volumes: IDMCollection; safecall;
    function Get_Views: IDMCollection; safecall;
    function Get_RenderAreasMode: Integer; safecall;
    procedure Set_RenderAreasMode(Value: Integer); safecall;
    function Get_DefaultVolumeHeight: Double; safecall;
    procedure Set_DefaultVolumeHeight(Value: Double); safecall;
    function BuildAreaSurrounding(WX: Double; WY: Double; WZ: Double): IArea; safecall;
    function GetAreaEqualTo(const aArea: IArea): IArea; safecall;
    function GetVolumeContaining(PX: Double; PY: Double; PZ: Double): IVolume; safecall;
    procedure CalcLimits; safecall;
    function Get_MinX: Double; safecall;
    function Get_MinY: Double; safecall;
    function Get_MinZ: Double; safecall;
    function Get_MaxX: Double; safecall;
    function Get_MaxY: Double; safecall;
    function Get_MaxZ: Double; safecall;
    procedure GetRefElementParent(ClassID: Integer; OperationCode: Integer; PX: Double; PY: Double; 
                                  PZ: Double; out aParent: IDMElement; 
                                  out DMClassCollections: IDMClassCollections; 
                                  out RefSource: IDMCollection; out aCollection: IDMCollection); safecall;
    procedure GetDefaultAreaRefRef(const VolumeE: IDMElement; Mode: Integer; 
                                   BaseVolumeFlag: WordBool; out aCollection: IDMCollection; 
                                   out aName: WideString; out AreaRefRef: IDMElement); safecall;
    function Get_DefaultVerticalAreaWidth: Double; safecall;
    procedure Set_DefaultVerticalAreaWidth(Value: Double); safecall;
    function Get_Fonts: IDMCollection; safecall;
    function Get_Labels: IDMCollection; safecall;
    function Get_CurrentFont: ISMFont; safecall;
    procedure Set_CurrentFont(const Value: ISMFont); safecall;
    procedure CheckVolumeContent(const NewVolmes: IDMCollection; const Volume: IVolume; 
                                 Mode: Integer); safecall;
    function CanDeleteNow(const aElement: IDMElement; const DeleteCollection: IDMCollection): WordBool; safecall;
    function Get_ReliefLayer: IDMElement; safecall;
    procedure Set_ReliefLayer(const Value: IDMElement); safecall;
    function Get_BuildVerticalLine: WordBool; safecall;
    procedure Set_BuildVerticalLine(Value: WordBool); safecall;
    function Get_DefaultObjectWidth: Double; safecall;
    procedure Set_DefaultObjectWidth(Value: Double); safecall;
    function Get_BuildJoinedVolume: WordBool; safecall;
    procedure Set_BuildJoinedVolume(Value: WordBool); safecall;
    function Get_AreasOrdered: WordBool; safecall;
    procedure Set_AreasOrdered(Value: WordBool); safecall;
    function Get_DrawOrdered: WordBool; safecall;
    procedure Set_DrawOrdered(Value: WordBool); safecall;
    function Get_LocalGridCell: Double; safecall;
    procedure Set_LocalGridCell(Value: Double); safecall;
    function Get_ChangeLengthDirection: Integer; safecall;
    procedure Set_ChangeLengthDirection(Value: Integer); safecall;
    function Get_EdgeNodeDeletionAllowed: WordBool; safecall;
    procedure UpdateVolumes; safecall;
    procedure MakeVolumeOutline(const aVolume: IVolume; const aCollection: IDMCollection); safecall;
    procedure CalcVolumeMinMaxZ(const Volume: IVolume); safecall;
    procedure GetUpperLowerVolumeParams(const VolumeRef: IDMElement; 
                                        out UpperVolumeRefRef: IDMElement; 
                                        out LowerVolumeRefRef: IDMElement; 
                                        out VolumeHeight: Double; out UpperVolumeHeight: Double; 
                                        out LowerVolumeHeight: Double; 
                                        out UpperVolumeUseSpecLayer: WordBool; 
                                        out LowerUseSpecLayer: WordBool; 
                                        out TopAreaUseSpecLayer: WordBool); safecall;
    function Get_VerticalBoundaryLayer: IDMElement; safecall;
    procedure Set_VerticalBoundaryLayer(const Value: IDMElement); safecall;
    function GetColVolumeContaining(PX: Double; PY: Double; PZ: Double; 
                                    const ColAreas: IDMCollection; const Volumes: IDMCollection): WordBool; safecall;
    procedure GetInnerVolumes(const VolumeE: IDMElement; const InnerVolumes: IDMCollection); safecall;
    function Get_BuildDirection: Integer; safecall;
    procedure Set_BuildDirection(Value: Integer); safecall;
    function Get_BuildWallsOnAllLevels: WordBool; safecall;
    procedure Set_BuildWallsOnAllLevels(Value: WordBool); safecall;
    function Get_EnabledBuildDirection: Integer; safecall;
    procedure Set_EnabledBuildDirection(Value: Integer); safecall;
    function Get_FastDraw: WordBool; safecall;
    function GetOuterVolume(const VolumeE: IDMElement): IDMElement; safecall;
    property Areas: IDMCollection read Get_Areas;
    property Volumes: IDMCollection read Get_Volumes;
    property Views: IDMCollection read Get_Views;
    property RenderAreasMode: Integer read Get_RenderAreasMode write Set_RenderAreasMode;
    property DefaultVolumeHeight: Double read Get_DefaultVolumeHeight write Set_DefaultVolumeHeight;
    property MinX: Double read Get_MinX;
    property MinY: Double read Get_MinY;
    property MinZ: Double read Get_MinZ;
    property MaxX: Double read Get_MaxX;
    property MaxY: Double read Get_MaxY;
    property MaxZ: Double read Get_MaxZ;
    property DefaultVerticalAreaWidth: Double read Get_DefaultVerticalAreaWidth write Set_DefaultVerticalAreaWidth;
    property Fonts: IDMCollection read Get_Fonts;
    property Labels: IDMCollection read Get_Labels;
    property CurrentFont: ISMFont read Get_CurrentFont write Set_CurrentFont;
    property ReliefLayer: IDMElement read Get_ReliefLayer write Set_ReliefLayer;
    property BuildVerticalLine: WordBool read Get_BuildVerticalLine write Set_BuildVerticalLine;
    property DefaultObjectWidth: Double read Get_DefaultObjectWidth write Set_DefaultObjectWidth;
    property BuildJoinedVolume: WordBool read Get_BuildJoinedVolume write Set_BuildJoinedVolume;
    property AreasOrdered: WordBool read Get_AreasOrdered write Set_AreasOrdered;
    property DrawOrdered: WordBool read Get_DrawOrdered write Set_DrawOrdered;
    property LocalGridCell: Double read Get_LocalGridCell write Set_LocalGridCell;
    property ChangeLengthDirection: Integer read Get_ChangeLengthDirection write Set_ChangeLengthDirection;
    property EdgeNodeDeletionAllowed: WordBool read Get_EdgeNodeDeletionAllowed;
    property VerticalBoundaryLayer: IDMElement read Get_VerticalBoundaryLayer write Set_VerticalBoundaryLayer;
    property BuildDirection: Integer read Get_BuildDirection write Set_BuildDirection;
    property BuildWallsOnAllLevels: WordBool read Get_BuildWallsOnAllLevels write Set_BuildWallsOnAllLevels;
    property EnabledBuildDirection: Integer read Get_EnabledBuildDirection write Set_EnabledBuildDirection;
    property FastDraw: WordBool read Get_FastDraw;
  end;

// *********************************************************************//
// DispIntf:  ISpatialModel2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B3F-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISpatialModel2Disp = dispinterface
    ['{62264B3F-E560-11D5-92FE-0050BA51A6D3}']
    property Areas: IDMCollection readonly dispid 7;
    property Volumes: IDMCollection readonly dispid 8;
    property Views: IDMCollection readonly dispid 10;
    property RenderAreasMode: Integer dispid 12;
    property DefaultVolumeHeight: Double dispid 13;
    function BuildAreaSurrounding(WX: Double; WY: Double; WZ: Double): IArea; dispid 14;
    function GetAreaEqualTo(const aArea: IArea): IArea; dispid 15;
    function GetVolumeContaining(PX: Double; PY: Double; PZ: Double): IVolume; dispid 16;
    procedure CalcLimits; dispid 17;
    property MinX: Double readonly dispid 18;
    property MinY: Double readonly dispid 19;
    property MinZ: Double readonly dispid 20;
    property MaxX: Double readonly dispid 21;
    property MaxY: Double readonly dispid 22;
    property MaxZ: Double readonly dispid 23;
    procedure GetRefElementParent(ClassID: Integer; OperationCode: Integer; PX: Double; PY: Double; 
                                  PZ: Double; out aParent: IDMElement; 
                                  out DMClassCollections: IDMClassCollections; 
                                  out RefSource: IDMCollection; out aCollection: IDMCollection); dispid 24;
    procedure GetDefaultAreaRefRef(const VolumeE: IDMElement; Mode: Integer; 
                                   BaseVolumeFlag: WordBool; out aCollection: IDMCollection; 
                                   out aName: WideString; out AreaRefRef: IDMElement); dispid 25;
    property DefaultVerticalAreaWidth: Double dispid 2;
    property Fonts: IDMCollection readonly dispid 9;
    property Labels: IDMCollection readonly dispid 26;
    property CurrentFont: ISMFont dispid 27;
    procedure CheckVolumeContent(const NewVolmes: IDMCollection; const Volume: IVolume; 
                                 Mode: Integer); dispid 28;
    function CanDeleteNow(const aElement: IDMElement; const DeleteCollection: IDMCollection): WordBool; dispid 29;
    property ReliefLayer: IDMElement dispid 30;
    property BuildVerticalLine: WordBool dispid 31;
    property DefaultObjectWidth: Double dispid 32;
    property BuildJoinedVolume: WordBool dispid 33;
    property AreasOrdered: WordBool dispid 1;
    property DrawOrdered: WordBool dispid 3;
    property LocalGridCell: Double dispid 4;
    property ChangeLengthDirection: Integer dispid 6;
    property EdgeNodeDeletionAllowed: WordBool readonly dispid 5;
    procedure UpdateVolumes; dispid 34;
    procedure MakeVolumeOutline(const aVolume: IVolume; const aCollection: IDMCollection); dispid 35;
    procedure CalcVolumeMinMaxZ(const Volume: IVolume); dispid 36;
    procedure GetUpperLowerVolumeParams(const VolumeRef: IDMElement; 
                                        out UpperVolumeRefRef: IDMElement; 
                                        out LowerVolumeRefRef: IDMElement; 
                                        out VolumeHeight: Double; out UpperVolumeHeight: Double; 
                                        out LowerVolumeHeight: Double; 
                                        out UpperVolumeUseSpecLayer: WordBool; 
                                        out LowerUseSpecLayer: WordBool; 
                                        out TopAreaUseSpecLayer: WordBool); dispid 37;
    property VerticalBoundaryLayer: IDMElement dispid 38;
    function GetColVolumeContaining(PX: Double; PY: Double; PZ: Double; 
                                    const ColAreas: IDMCollection; const Volumes: IDMCollection): WordBool; dispid 39;
    procedure GetInnerVolumes(const VolumeE: IDMElement; const InnerVolumes: IDMCollection); dispid 40;
    property BuildDirection: Integer dispid 11;
    property BuildWallsOnAllLevels: WordBool dispid 41;
    property EnabledBuildDirection: Integer dispid 42;
    property FastDraw: WordBool readonly dispid 43;
    function GetOuterVolume(const VolumeE: IDMElement): IDMElement; dispid 44;
  end;

// *********************************************************************//
// Interface: ISMOperationManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B82E1AD7-F3AA-11D5-930A-0050BA51A6D3}
// *********************************************************************//
  ISMOperationManager = interface(IDispatch)
    ['{B82E1AD7-F3AA-11D5-930A-0050BA51A6D3}']
    procedure DoOperationStep(ShiftState: Integer); safecall;
    procedure StartOperation(OperationCode: Integer); safecall;
    procedure StopOperation(ShiftState: Integer); safecall;
    function Get_SnapDistance: Integer; safecall;
    procedure Set_SnapDistance(Value: Integer); safecall;
    function Get_OperationCode: Integer; safecall;
    function ReorderLines(const aCollection: IDMCollection): Integer; safecall;
    procedure CalcSelectionLimits(out MinX: Double; out MinY: Double; out MinZ: Double; 
                                  out MaxX: Double; out MaxY: Double; out MaxZ: Double); safecall;
    function Get_PictureFileName: WideString; safecall;
    procedure Set_PictureFileName(const Value: WideString); safecall;
    function Get_VirtualX: Double; safecall;
    function Get_VirtualY: Double; safecall;
    function Get_VirtualZ: Double; safecall;
    function Get_OperationStep: Integer; safecall;
    procedure Set_OperationStep(Value: Integer); safecall;
    function Get_OperationX0: Double; safecall;
    procedure Set_OperationX0(Value: Double); safecall;
    function Get_OperationY0: Double; safecall;
    procedure Set_OperationY0(Value: Double); safecall;
    function Get_OperationZ0: Double; safecall;
    procedure Set_OperationZ0(Value: Double); safecall;
    procedure MouseDrag; safecall;
    procedure MoveAreas(const DestVolume: IVolume; const SourceVolume: IVolume; const aArea: IArea; 
                        const CuttingArea: IArea); safecall;
    function Get_SnapMode: Integer; safecall;
    procedure Set_SnapMode(Value: Integer); safecall;
    procedure AddZView(MinZ: Double; MaxZ: Double); safecall;
    property SnapDistance: Integer read Get_SnapDistance write Set_SnapDistance;
    property OperationCode: Integer read Get_OperationCode;
    property PictureFileName: WideString read Get_PictureFileName write Set_PictureFileName;
    property VirtualX: Double read Get_VirtualX;
    property VirtualY: Double read Get_VirtualY;
    property VirtualZ: Double read Get_VirtualZ;
    property OperationStep: Integer read Get_OperationStep write Set_OperationStep;
    property OperationX0: Double read Get_OperationX0 write Set_OperationX0;
    property OperationY0: Double read Get_OperationY0 write Set_OperationY0;
    property OperationZ0: Double read Get_OperationZ0 write Set_OperationZ0;
    property SnapMode: Integer read Get_SnapMode write Set_SnapMode;
  end;

// *********************************************************************//
// DispIntf:  ISMOperationManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B82E1AD7-F3AA-11D5-930A-0050BA51A6D3}
// *********************************************************************//
  ISMOperationManagerDisp = dispinterface
    ['{B82E1AD7-F3AA-11D5-930A-0050BA51A6D3}']
    procedure DoOperationStep(ShiftState: Integer); dispid 3;
    procedure StartOperation(OperationCode: Integer); dispid 2;
    procedure StopOperation(ShiftState: Integer); dispid 4;
    property SnapDistance: Integer dispid 23;
    property OperationCode: Integer readonly dispid 26;
    function ReorderLines(const aCollection: IDMCollection): Integer; dispid 28;
    procedure CalcSelectionLimits(out MinX: Double; out MinY: Double; out MinZ: Double; 
                                  out MaxX: Double; out MaxY: Double; out MaxZ: Double); dispid 31;
    property PictureFileName: WideString dispid 33;
    property VirtualX: Double readonly dispid 38;
    property VirtualY: Double readonly dispid 39;
    property VirtualZ: Double readonly dispid 40;
    property OperationStep: Integer dispid 45;
    property OperationX0: Double dispid 46;
    property OperationY0: Double dispid 47;
    property OperationZ0: Double dispid 48;
    procedure MouseDrag; dispid 44;
    procedure MoveAreas(const DestVolume: IVolume; const SourceVolume: IVolume; const aArea: IArea; 
                        const CuttingArea: IArea); dispid 61;
    property SnapMode: Integer dispid 1;
    procedure AddZView(MinZ: Double; MaxZ: Double); dispid 6;
  end;

// *********************************************************************//
// Interface: ILayer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B21-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ILayer = interface(IDispatch)
    ['{62264B21-E560-11D5-92FE-0050BA51A6D3}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_Color: Integer; safecall;
    procedure Set_Color(Value: Integer); safecall;
    function Get_Style: Integer; safecall;
    procedure Set_Style(Value: Integer); safecall;
    function Get_Selectable: WordBool; safecall;
    procedure Set_Selectable(Value: WordBool); safecall;
    function Get_Expand: WordBool; safecall;
    procedure Set_Expand(Value: WordBool); safecall;
    function Get_SpatialElements: IDMCollection; safecall;
    function Get_LineWidth: Integer; safecall;
    procedure Set_LineWidth(Value: Integer); safecall;
    function Get_CanDelete: WordBool; safecall;
    procedure Set_CanDelete(Value: WordBool); safecall;
    function Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Color: Integer read Get_Color write Set_Color;
    property Style: Integer read Get_Style write Set_Style;
    property Selectable: WordBool read Get_Selectable write Set_Selectable;
    property Expand: WordBool read Get_Expand write Set_Expand;
    property SpatialElements: IDMCollection read Get_SpatialElements;
    property LineWidth: Integer read Get_LineWidth write Set_LineWidth;
    property CanDelete: WordBool read Get_CanDelete write Set_CanDelete;
    property Kind: Integer read Get_Kind write Set_Kind;
  end;

// *********************************************************************//
// DispIntf:  ILayerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B21-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ILayerDisp = dispinterface
    ['{62264B21-E560-11D5-92FE-0050BA51A6D3}']
    property Visible: WordBool dispid 3;
    property Color: Integer dispid 4;
    property Style: Integer dispid 1;
    property Selectable: WordBool dispid 2;
    property Expand: WordBool dispid 5;
    property SpatialElements: IDMCollection readonly dispid 6;
    property LineWidth: Integer dispid 7;
    property CanDelete: WordBool dispid 8;
    property Kind: Integer dispid 9;
  end;

// *********************************************************************//
// Interface: ICurvedLine
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B27-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ICurvedLine = interface(IDispatch)
    ['{62264B27-E560-11D5-92FE-0050BA51A6D3}']
    function Get_P0X: Double; safecall;
    procedure Set_P0X(Value: Double); safecall;
    function Get_P0Y: Double; safecall;
    procedure Set_P0Y(Value: Double); safecall;
    function Get_P0Z: Double; safecall;
    procedure Set_P0Z(Value: Double); safecall;
    function Get_P1X: Double; safecall;
    procedure Set_P1X(Value: Double); safecall;
    function Get_P1Y: Double; safecall;
    procedure Set_P1Y(Value: Double); safecall;
    function Get_P1Z: Double; safecall;
    procedure Set_P1Z(Value: Double); safecall;
    property P0X: Double read Get_P0X write Set_P0X;
    property P0Y: Double read Get_P0Y write Set_P0Y;
    property P0Z: Double read Get_P0Z write Set_P0Z;
    property P1X: Double read Get_P1X write Set_P1X;
    property P1Y: Double read Get_P1Y write Set_P1Y;
    property P1Z: Double read Get_P1Z write Set_P1Z;
  end;

// *********************************************************************//
// DispIntf:  ICurvedLineDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B27-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ICurvedLineDisp = dispinterface
    ['{62264B27-E560-11D5-92FE-0050BA51A6D3}']
    property P0X: Double dispid 1;
    property P0Y: Double dispid 2;
    property P0Z: Double dispid 3;
    property P1X: Double dispid 4;
    property P1Y: Double dispid 5;
    property P1Z: Double dispid 6;
  end;

// *********************************************************************//
// Interface: IImageRect
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B31-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IImageRect = interface(IDispatch)
    ['{62264B31-E560-11D5-92FE-0050BA51A6D3}']
    procedure RotatePicture(Angle: Double); safecall;
    function Get_PictureWidth: Integer; safecall;
    function Get_PictureHeight: Integer; safecall;
    function Get_C3X: Double; safecall;
    procedure Set_C3X(Value: Double); safecall;
    function Get_C3Y: Double; safecall;
    procedure Set_C3Y(Value: Double); safecall;
    function Get_C4X: Double; safecall;
    procedure Set_C4X(Value: Double); safecall;
    function Get_C4Y: Double; safecall;
    procedure Set_C4Y(Value: Double); safecall;
    function Get_PictureHandle: LongWord; safecall;
    procedure Set_PictureHandle(Value: LongWord); safecall;
    function Get_Angle: Double; safecall;
    procedure Set_Angle(Value: Double); safecall;
    function Get_PictureFileName: WideString; safecall;
    procedure Set_PictureFileName(const Value: WideString); safecall;
    function Get_PictureFMT: Integer; safecall;
    procedure Set_PictureFMT(Value: Integer); safecall;
    function Get_Alpha: Integer; safecall;
    procedure Set_Alpha(Value: Integer); safecall;
    property PictureWidth: Integer read Get_PictureWidth;
    property PictureHeight: Integer read Get_PictureHeight;
    property C3X: Double read Get_C3X write Set_C3X;
    property C3Y: Double read Get_C3Y write Set_C3Y;
    property C4X: Double read Get_C4X write Set_C4X;
    property C4Y: Double read Get_C4Y write Set_C4Y;
    property PictureHandle: LongWord read Get_PictureHandle write Set_PictureHandle;
    property Angle: Double read Get_Angle write Set_Angle;
    property PictureFileName: WideString read Get_PictureFileName write Set_PictureFileName;
    property PictureFMT: Integer read Get_PictureFMT write Set_PictureFMT;
    property Alpha: Integer read Get_Alpha write Set_Alpha;
  end;

// *********************************************************************//
// DispIntf:  IImageRectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B31-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IImageRectDisp = dispinterface
    ['{62264B31-E560-11D5-92FE-0050BA51A6D3}']
    procedure RotatePicture(Angle: Double); dispid 1;
    property PictureWidth: Integer readonly dispid 3;
    property PictureHeight: Integer readonly dispid 4;
    property C3X: Double dispid 6;
    property C3Y: Double dispid 7;
    property C4X: Double dispid 8;
    property C4Y: Double dispid 9;
    property PictureHandle: LongWord dispid 10;
    property Angle: Double dispid 11;
    property PictureFileName: WideString dispid 2;
    property PictureFMT: Integer dispid 5;
    property Alpha: Integer dispid 12;
  end;

// *********************************************************************//
// Interface: ISMFont
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {802DBCB3-8370-11D6-972A-0050BA51A6D3}
// *********************************************************************//
  ISMFont = interface(IDispatch)
    ['{802DBCB3-8370-11D6-972A-0050BA51A6D3}']
    function Get_Size: Integer; safecall;
    procedure Set_Size(Value: Integer); safecall;
    function Get_Color: Integer; safecall;
    procedure Set_Color(Value: Integer); safecall;
    function Get_Style: Integer; safecall;
    procedure Set_Style(Value: Integer); safecall;
    property Size: Integer read Get_Size write Set_Size;
    property Color: Integer read Get_Color write Set_Color;
    property Style: Integer read Get_Style write Set_Style;
  end;

// *********************************************************************//
// DispIntf:  ISMFontDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {802DBCB3-8370-11D6-972A-0050BA51A6D3}
// *********************************************************************//
  ISMFontDisp = dispinterface
    ['{802DBCB3-8370-11D6-972A-0050BA51A6D3}']
    property Size: Integer dispid 2;
    property Color: Integer dispid 3;
    property Style: Integer dispid 4;
  end;

// *********************************************************************//
// Interface: ICoordNode
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B23-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ICoordNode = interface(ICoord)
    ['{62264B23-E560-11D5-92FE-0050BA51A6D3}']
    function Get_Lines: IDMCollection; safecall;
    function DistanceFrom(WX: Double; WY: Double; WZ: Double): Double; safecall;
    function Get_Tag: Integer; safecall;
    procedure Set_Tag(Value: Integer); safecall;
    function Get_TagRef: IDMElement; safecall;
    procedure Set_TagRef(const Value: IDMElement); safecall;
    function GetVerticalLine(Direction: Integer): ILine; safecall;
    property Lines: IDMCollection read Get_Lines;
    property Tag: Integer read Get_Tag write Set_Tag;
    property TagRef: IDMElement read Get_TagRef write Set_TagRef;
  end;

// *********************************************************************//
// DispIntf:  ICoordNodeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B23-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ICoordNodeDisp = dispinterface
    ['{62264B23-E560-11D5-92FE-0050BA51A6D3}']
    property Lines: IDMCollection readonly dispid 5;
    function DistanceFrom(WX: Double; WY: Double; WZ: Double): Double; dispid 4;
    property Tag: Integer dispid 6;
    property TagRef: IDMElement dispid 7;
    function GetVerticalLine(Direction: Integer): ILine; dispid 8;
    property X: Double dispid 1;
    property Y: Double dispid 2;
    property Z: Double dispid 3;
  end;

// *********************************************************************//
// Interface: ILine
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B25-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ILine = interface(IDispatch)
    ['{62264B25-E560-11D5-92FE-0050BA51A6D3}']
    function Get_Thickness: Double; safecall;
    procedure Set_Thickness(Value: Double); safecall;
    function Get_Style: Integer; safecall;
    procedure Set_Style(Value: Integer); safecall;
    function NextNodeTo(const aNode: ICoordNode): ICoordNode; safecall;
    function Get_C0: ICoordNode; safecall;
    procedure Set_C0(const Value: ICoordNode); safecall;
    function Get_C1: ICoordNode; safecall;
    procedure Set_C1(const Value: ICoordNode); safecall;
    function InLineWith(WP1: Double; WP2: Double; WP3: Double; Side: Integer; Plain: Integer): SYSINT; safecall;
    function Get_Length: Double; safecall;
    procedure Set_Length(Value: Double); safecall;
    procedure PerpendicularFrom(WX0: Double; WY0: Double; WZ0: Double; out WX: Double; 
                                out WY: Double; out WZ: Double); safecall;
    function DistanceFrom(WX: Double; WY: Double; WZ: Double; out WX0: Double; out WY0: Double; 
                          out WZ0: Double; out OrtBaseOnLine: WordBool): Double; safecall;
    function GetVerticalArea(Direction: Integer): IArea; safecall;
    function Get_ZAngle: Double; safecall;
    procedure Set_ZAngle(Value: Double); safecall;
    function Get_IsVertical: WordBool; safecall;
    function Get_CC0(Direction: Integer): ICoordNode; safecall;
    procedure Set_CC0(Direction: Integer; const Value: ICoordNode); safecall;
    function Get_CC1(Direction: Integer): ICoordNode; safecall;
    procedure Set_CC1(Direction: Integer; const Value: ICoordNode); safecall;
    property Thickness: Double read Get_Thickness write Set_Thickness;
    property Style: Integer read Get_Style write Set_Style;
    property C0: ICoordNode read Get_C0 write Set_C0;
    property C1: ICoordNode read Get_C1 write Set_C1;
    property Length: Double read Get_Length write Set_Length;
    property ZAngle: Double read Get_ZAngle write Set_ZAngle;
    property IsVertical: WordBool read Get_IsVertical;
    property CC0[Direction: Integer]: ICoordNode read Get_CC0 write Set_CC0;
    property CC1[Direction: Integer]: ICoordNode read Get_CC1 write Set_CC1;
  end;

// *********************************************************************//
// DispIntf:  ILineDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B25-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ILineDisp = dispinterface
    ['{62264B25-E560-11D5-92FE-0050BA51A6D3}']
    property Thickness: Double dispid 2;
    property Style: Integer dispid 4;
    function NextNodeTo(const aNode: ICoordNode): ICoordNode; dispid 5;
    property C0: ICoordNode dispid 6;
    property C1: ICoordNode dispid 7;
    function InLineWith(WP1: Double; WP2: Double; WP3: Double; Side: Integer; Plain: Integer): SYSINT; dispid 1;
    property Length: Double dispid 3;
    procedure PerpendicularFrom(WX0: Double; WY0: Double; WZ0: Double; out WX: Double; 
                                out WY: Double; out WZ: Double); dispid 9;
    function DistanceFrom(WX: Double; WY: Double; WZ: Double; out WX0: Double; out WY0: Double; 
                          out WZ0: Double; out OrtBaseOnLine: WordBool): Double; dispid 8;
    function GetVerticalArea(Direction: Integer): IArea; dispid 10;
    property ZAngle: Double dispid 11;
    property IsVertical: WordBool readonly dispid 12;
    property CC0[Direction: Integer]: ICoordNode dispid 13;
    property CC1[Direction: Integer]: ICoordNode dispid 14;
  end;

// *********************************************************************//
// Interface: IPolyline
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B29-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IPolyline = interface(IDispatch)
    ['{62264B29-E560-11D5-92FE-0050BA51A6D3}']
    function Get_Lines: IDMCollection; safecall;
    property Lines: IDMCollection read Get_Lines;
  end;

// *********************************************************************//
// DispIntf:  IPolylineDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B29-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IPolylineDisp = dispinterface
    ['{62264B29-E560-11D5-92FE-0050BA51A6D3}']
    property Lines: IDMCollection readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IArea
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B2B-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IArea = interface(IDispatch)
    ['{62264B2B-E560-11D5-92FE-0050BA51A6D3}']
    function Get_IsVertical: WordBool; safecall;
    procedure Set_IsVertical(Value: WordBool); safecall;
    function Get_TopLines: IDMCollection; safecall;
    function Get_BottomLines: IDMCollection; safecall;
    function Get_Volume0: IVolume; safecall;
    procedure Set_Volume0(const Value: IVolume); safecall;
    function Get_Volume1: IVolume; safecall;
    procedure Set_Volume1(const Value: IVolume); safecall;
    procedure CalcMinMaxZ; safecall;
    function ProjectionContainsPoint(P1: Double; P2: Double; Plain: Integer): WordBool; safecall;
    function IntersectLine(L0X: Double; L0Y: Double; L0Z: Double; L1X: Double; L1Y: Double; 
                           L1Z: Double; out PX: Double; out PY: Double; out PZ: Double): WordBool; safecall;
    procedure GetCentralPoint(out PX: Double; out PY: Double; out PZ: Double); safecall;
    function Get_MaxZ: Double; safecall;
    procedure Set_MaxZ(Value: Double); safecall;
    function Get_MinZ: Double; safecall;
    procedure Set_MinZ(Value: Double); safecall;
    function Get_Style: Integer; safecall;
    procedure Set_Style(Value: Integer); safecall;
    function Get_NX: Double; safecall;
    function Get_NY: Double; safecall;
    function Get_NZ: Double; safecall;
    function Get_C0: ICoordNode; safecall;
    function Get_C1: ICoordNode; safecall;
    function Get_Square: Double; safecall;
    function GetDistanceFrom(X: Double; Y: Double; Z: Double): Double; safecall;
    function Get_Volume0IsOuter: WordBool; safecall;
    procedure Set_Volume0IsOuter(Value: WordBool); safecall;
    function Get_Volume1IsOuter: WordBool; safecall;
    procedure Set_Volume1IsOuter(Value: WordBool); safecall;
    function Get_Flags: Integer; safecall;
    procedure Set_Flags(Value: Integer); safecall;
    function Get_Vol0(Direction: Integer): IVolume; safecall;
    procedure Set_Vol0(Direction: Integer; const Value: IVolume); safecall;
    function Get_Vol1(Direction: Integer): IVolume; safecall;
    procedure Set_Vol1(Direction: Integer; const Value: IVolume); safecall;
    function Get_Vol0IsOuter(Direction: Integer): WordBool; safecall;
    procedure Set_Vol0IsOuter(Direction: Integer; Value: WordBool); safecall;
    function Get_Vol1IsOuter(Direction: Integer): WordBool; safecall;
    procedure Set_Vol1IsOuter(Direction: Integer; Value: WordBool); safecall;
    function Get_BLines(Direction: Integer): IDMCollection; safecall;
    function Get_TLines(Direction: Integer): IDMCollection; safecall;
    function Get_MxZ(Direction: Integer): Double; safecall;
    procedure Set_MxZ(Direction: Integer; Value: Double); safecall;
    function Get_MnZ(Direction: Integer): Double; safecall;
    procedure Set_MnZ(Direction: Integer; Value: Double); safecall;
    property IsVertical: WordBool read Get_IsVertical write Set_IsVertical;
    property TopLines: IDMCollection read Get_TopLines;
    property BottomLines: IDMCollection read Get_BottomLines;
    property Volume0: IVolume read Get_Volume0 write Set_Volume0;
    property Volume1: IVolume read Get_Volume1 write Set_Volume1;
    property MaxZ: Double read Get_MaxZ write Set_MaxZ;
    property MinZ: Double read Get_MinZ write Set_MinZ;
    property Style: Integer read Get_Style write Set_Style;
    property NX: Double read Get_NX;
    property NY: Double read Get_NY;
    property NZ: Double read Get_NZ;
    property C0: ICoordNode read Get_C0;
    property C1: ICoordNode read Get_C1;
    property Square: Double read Get_Square;
    property Volume0IsOuter: WordBool read Get_Volume0IsOuter write Set_Volume0IsOuter;
    property Volume1IsOuter: WordBool read Get_Volume1IsOuter write Set_Volume1IsOuter;
    property Flags: Integer read Get_Flags write Set_Flags;
    property Vol0[Direction: Integer]: IVolume read Get_Vol0 write Set_Vol0;
    property Vol1[Direction: Integer]: IVolume read Get_Vol1 write Set_Vol1;
    property Vol0IsOuter[Direction: Integer]: WordBool read Get_Vol0IsOuter write Set_Vol0IsOuter;
    property Vol1IsOuter[Direction: Integer]: WordBool read Get_Vol1IsOuter write Set_Vol1IsOuter;
    property BLines[Direction: Integer]: IDMCollection read Get_BLines;
    property TLines[Direction: Integer]: IDMCollection read Get_TLines;
    property MxZ[Direction: Integer]: Double read Get_MxZ write Set_MxZ;
    property MnZ[Direction: Integer]: Double read Get_MnZ write Set_MnZ;
  end;

// *********************************************************************//
// DispIntf:  IAreaDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B2B-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IAreaDisp = dispinterface
    ['{62264B2B-E560-11D5-92FE-0050BA51A6D3}']
    property IsVertical: WordBool dispid 1;
    property TopLines: IDMCollection readonly dispid 2;
    property BottomLines: IDMCollection readonly dispid 3;
    property Volume0: IVolume dispid 4;
    property Volume1: IVolume dispid 5;
    procedure CalcMinMaxZ; dispid 8;
    function ProjectionContainsPoint(P1: Double; P2: Double; Plain: Integer): WordBool; dispid 10;
    function IntersectLine(L0X: Double; L0Y: Double; L0Z: Double; L1X: Double; L1Y: Double; 
                           L1Z: Double; out PX: Double; out PY: Double; out PZ: Double): WordBool; dispid 9;
    procedure GetCentralPoint(out PX: Double; out PY: Double; out PZ: Double); dispid 11;
    property MaxZ: Double dispid 6;
    property MinZ: Double dispid 7;
    property Style: Integer dispid 12;
    property NX: Double readonly dispid 13;
    property NY: Double readonly dispid 14;
    property NZ: Double readonly dispid 15;
    property C0: ICoordNode readonly dispid 16;
    property C1: ICoordNode readonly dispid 17;
    property Square: Double readonly dispid 18;
    function GetDistanceFrom(X: Double; Y: Double; Z: Double): Double; dispid 19;
    property Volume0IsOuter: WordBool dispid 20;
    property Volume1IsOuter: WordBool dispid 21;
    property Flags: Integer dispid 22;
    property Vol0[Direction: Integer]: IVolume dispid 23;
    property Vol1[Direction: Integer]: IVolume dispid 24;
    property Vol0IsOuter[Direction: Integer]: WordBool dispid 25;
    property Vol1IsOuter[Direction: Integer]: WordBool dispid 26;
    property BLines[Direction: Integer]: IDMCollection readonly dispid 27;
    property TLines[Direction: Integer]: IDMCollection readonly dispid 28;
    property MxZ[Direction: Integer]: Double dispid 29;
    property MnZ[Direction: Integer]: Double dispid 30;
  end;

// *********************************************************************//
// Interface: IVolume
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B2D-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IVolume = interface(IDispatch)
    ['{62264B2D-E560-11D5-92FE-0050BA51A6D3}']
    function Get_Areas: IDMCollection; safecall;
    function Get_TopAreas: IDMCollection; safecall;
    function Get_BottomAreas: IDMCollection; safecall;
    function Get_MaxZ: Double; safecall;
    procedure Set_MaxZ(Value: Double); safecall;
    function Get_MinZ: Double; safecall;
    procedure Set_MinZ(Value: Double); safecall;
    function ContainsPoint(PX: Double; PY: Double; PZ: Double): WordBool; safecall;
    function ContainsVolume(const aVolume: IVolume): WordBool; safecall;
    function AdjacentTo(const aVolume: IVolume): WordBool; safecall;
    function Get_TAreas(Direction: Integer): IDMCollection; safecall;
    function Get_BAreas(Direction: Integer): IDMCollection; safecall;
    property Areas: IDMCollection read Get_Areas;
    property TopAreas: IDMCollection read Get_TopAreas;
    property BottomAreas: IDMCollection read Get_BottomAreas;
    property MaxZ: Double read Get_MaxZ write Set_MaxZ;
    property MinZ: Double read Get_MinZ write Set_MinZ;
    property TAreas[Direction: Integer]: IDMCollection read Get_TAreas;
    property BAreas[Direction: Integer]: IDMCollection read Get_BAreas;
  end;

// *********************************************************************//
// DispIntf:  IVolumeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B2D-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IVolumeDisp = dispinterface
    ['{62264B2D-E560-11D5-92FE-0050BA51A6D3}']
    property Areas: IDMCollection readonly dispid 1;
    property TopAreas: IDMCollection readonly dispid 2;
    property BottomAreas: IDMCollection readonly dispid 5;
    property MaxZ: Double dispid 3;
    property MinZ: Double dispid 4;
    function ContainsPoint(PX: Double; PY: Double; PZ: Double): WordBool; dispid 6;
    function ContainsVolume(const aVolume: IVolume): WordBool; dispid 7;
    function AdjacentTo(const aVolume: IVolume): WordBool; dispid 9;
    property TAreas[Direction: Integer]: IDMCollection readonly dispid 8;
    property BAreas[Direction: Integer]: IDMCollection readonly dispid 10;
  end;

// *********************************************************************//
// Interface: IView
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B2F-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IView = interface(IDispatch)
    ['{62264B2F-E560-11D5-92FE-0050BA51A6D3}']
    function Get_CX: Double; safecall;
    procedure Set_CX(Value: Double); safecall;
    function Get_CY: Double; safecall;
    procedure Set_CY(Value: Double); safecall;
    function Get_CZ: Double; safecall;
    procedure Set_CZ(Value: Double); safecall;
    function Get_ZAngle: Double; safecall;
    procedure Set_ZAngle(Value: Double); safecall;
    function Get_CosZ: Double; safecall;
    function Get_SinZ: Double; safecall;
    function Get_Zmin: Double; safecall;
    procedure Set_Zmin(Value: Double); safecall;
    function Get_Zmax: Double; safecall;
    procedure Set_Zmax(Value: Double); safecall;
    function Get_Dmin: Double; safecall;
    procedure Set_Dmin(Value: Double); safecall;
    function Get_Dmax: Double; safecall;
    procedure Set_Dmax(Value: Double); safecall;
    function Get_CurrX0: Double; safecall;
    procedure Set_CurrX0(Value: Double); safecall;
    function Get_CurrY0: Double; safecall;
    procedure Set_CurrY0(Value: Double); safecall;
    function Get_CurrZ0: Double; safecall;
    procedure Set_CurrZ0(Value: Double); safecall;
    function Get_RevScale: Double; safecall;
    procedure Set_RevScale(Value: Double); safecall;
    function PointIsVisible(X: Double; Y: Double; Z: Double; Tag: Integer): WordBool; safecall;
    procedure Duplicate(const aView: IView); safecall;
    function Get_StoredParam: Integer; safecall;
    procedure Set_StoredParam(Value: Integer); safecall;
    function Get_TAngle: Double; safecall;
    procedure Set_TAngle(Value: Double); safecall;
    function Get_CosT: Double; safecall;
    function Get_SinT: Double; safecall;
    function Get_RevScaleX: Double; safecall;
    procedure Set_RevScaleX(Value: Double); safecall;
    function Get_RevScaleY: Double; safecall;
    procedure Set_RevScaleY(Value: Double); safecall;
    function Get_RevScaleZ: Double; safecall;
    procedure Set_RevScaleZ(Value: Double); safecall;
    property CX: Double read Get_CX write Set_CX;
    property CY: Double read Get_CY write Set_CY;
    property CZ: Double read Get_CZ write Set_CZ;
    property ZAngle: Double read Get_ZAngle write Set_ZAngle;
    property CosZ: Double read Get_CosZ;
    property SinZ: Double read Get_SinZ;
    property Zmin: Double read Get_Zmin write Set_Zmin;
    property Zmax: Double read Get_Zmax write Set_Zmax;
    property Dmin: Double read Get_Dmin write Set_Dmin;
    property Dmax: Double read Get_Dmax write Set_Dmax;
    property CurrX0: Double read Get_CurrX0 write Set_CurrX0;
    property CurrY0: Double read Get_CurrY0 write Set_CurrY0;
    property CurrZ0: Double read Get_CurrZ0 write Set_CurrZ0;
    property RevScale: Double read Get_RevScale write Set_RevScale;
    property StoredParam: Integer read Get_StoredParam write Set_StoredParam;
    property TAngle: Double read Get_TAngle write Set_TAngle;
    property CosT: Double read Get_CosT;
    property SinT: Double read Get_SinT;
    property RevScaleX: Double read Get_RevScaleX write Set_RevScaleX;
    property RevScaleY: Double read Get_RevScaleY write Set_RevScaleY;
    property RevScaleZ: Double read Get_RevScaleZ write Set_RevScaleZ;
  end;

// *********************************************************************//
// DispIntf:  IViewDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B2F-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  IViewDisp = dispinterface
    ['{62264B2F-E560-11D5-92FE-0050BA51A6D3}']
    property CX: Double dispid 1;
    property CY: Double dispid 2;
    property CZ: Double dispid 3;
    property ZAngle: Double dispid 4;
    property CosZ: Double readonly dispid 5;
    property SinZ: Double readonly dispid 6;
    property Zmin: Double dispid 9;
    property Zmax: Double dispid 10;
    property Dmin: Double dispid 11;
    property Dmax: Double dispid 12;
    property CurrX0: Double dispid 13;
    property CurrY0: Double dispid 14;
    property CurrZ0: Double dispid 15;
    property RevScale: Double dispid 16;
    function PointIsVisible(X: Double; Y: Double; Z: Double; Tag: Integer): WordBool; dispid 19;
    procedure Duplicate(const aView: IView); dispid 17;
    property StoredParam: Integer dispid 18;
    property TAngle: Double dispid 21;
    property CosT: Double readonly dispid 22;
    property SinT: Double readonly dispid 23;
    property RevScaleX: Double dispid 7;
    property RevScaleY: Double dispid 24;
    property RevScaleZ: Double dispid 25;
  end;

// *********************************************************************//
// Interface: ISpatialElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B33-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISpatialElement = interface(IDispatch)
    ['{62264B33-E560-11D5-92FE-0050BA51A6D3}']
    function Get_Layer: ILayer; safecall;
    procedure Set_Layer(const Value: ILayer); safecall;
    function Get_Color: Integer; safecall;
    procedure Set_Color(Value: Integer); safecall;
    property Layer: ILayer read Get_Layer write Set_Layer;
    property Color: Integer read Get_Color write Set_Color;
  end;

// *********************************************************************//
// DispIntf:  ISpatialElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {62264B33-E560-11D5-92FE-0050BA51A6D3}
// *********************************************************************//
  ISpatialElementDisp = dispinterface
    ['{62264B33-E560-11D5-92FE-0050BA51A6D3}']
    property Layer: ILayer dispid 1;
    property Color: Integer dispid 2;
  end;

// *********************************************************************//
// Interface: ISpatialModel
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A51797CF-578B-4A2B-AD7F-7B97A2AF45EF}
// *********************************************************************//
  ISpatialModel = interface(IDispatch)
    ['{A51797CF-578B-4A2B-AD7F-7B97A2AF45EF}']
    function Get_Layers: IDMCollection; safecall;
    function Get_CoordNodes: IDMCollection; safecall;
    function Get_Lines: IDMCollection; safecall;
    function Get_CurvedLines: IDMCollection; safecall;
    function Get_Polylines: IDMCollection; safecall;
    function Get_ImageRects: IDMCollection; safecall;
    function Get_CurrentLayer: ILayer; safecall;
    procedure Set_CurrentLayer(const Value: ILayer); safecall;
    function Get_LineGroups: IDMCollection; safecall;
    function Get_Circles: IDMCollection; safecall;
    property Layers: IDMCollection read Get_Layers;
    property CoordNodes: IDMCollection read Get_CoordNodes;
    property Lines: IDMCollection read Get_Lines;
    property CurvedLines: IDMCollection read Get_CurvedLines;
    property Polylines: IDMCollection read Get_Polylines;
    property ImageRects: IDMCollection read Get_ImageRects;
    property CurrentLayer: ILayer read Get_CurrentLayer write Set_CurrentLayer;
    property LineGroups: IDMCollection read Get_LineGroups;
    property Circles: IDMCollection read Get_Circles;
  end;

// *********************************************************************//
// DispIntf:  ISpatialModelDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A51797CF-578B-4A2B-AD7F-7B97A2AF45EF}
// *********************************************************************//
  ISpatialModelDisp = dispinterface
    ['{A51797CF-578B-4A2B-AD7F-7B97A2AF45EF}']
    property Layers: IDMCollection readonly dispid 1;
    property CoordNodes: IDMCollection readonly dispid 2;
    property Lines: IDMCollection readonly dispid 3;
    property CurvedLines: IDMCollection readonly dispid 4;
    property Polylines: IDMCollection readonly dispid 5;
    property ImageRects: IDMCollection readonly dispid 8;
    property CurrentLayer: ILayer dispid 7;
    property LineGroups: IDMCollection readonly dispid 6;
    property Circles: IDMCollection readonly dispid 9;
  end;

// *********************************************************************//
// Interface: ISMLabel
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {802DBCB1-8370-11D6-972A-0050BA51A6D3}
// *********************************************************************//
  ISMLabel = interface(IDispatch)
    ['{802DBCB1-8370-11D6-972A-0050BA51A6D3}']
    function Get_Font: ISMFont; safecall;
    procedure Set_Font(const Value: ISMFont); safecall;
    function Get_LabelScaleMode: Integer; safecall;
    procedure Set_LabelScaleMode(Value: Integer); safecall;
    function Get_LabelSize: Double; safecall;
    procedure Set_LabelSize(Value: Double); safecall;
    function Get_LabeldX: Double; safecall;
    procedure Set_LabeldX(Value: Double); safecall;
    function Get_LabeldY: Double; safecall;
    procedure Set_LabeldY(Value: Double); safecall;
    function Get_LabeldZ: Double; safecall;
    procedure Set_LabeldZ(Value: Double); safecall;
    property Font: ISMFont read Get_Font write Set_Font;
    property LabelScaleMode: Integer read Get_LabelScaleMode write Set_LabelScaleMode;
    property LabelSize: Double read Get_LabelSize write Set_LabelSize;
    property LabeldX: Double read Get_LabeldX write Set_LabeldX;
    property LabeldY: Double read Get_LabeldY write Set_LabeldY;
    property LabeldZ: Double read Get_LabeldZ write Set_LabeldZ;
  end;

// *********************************************************************//
// DispIntf:  ISMLabelDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {802DBCB1-8370-11D6-972A-0050BA51A6D3}
// *********************************************************************//
  ISMLabelDisp = dispinterface
    ['{802DBCB1-8370-11D6-972A-0050BA51A6D3}']
    property Font: ISMFont dispid 1;
    property LabelScaleMode: Integer dispid 10;
    property LabelSize: Double dispid 11;
    property LabeldX: Double dispid 13;
    property LabeldY: Double dispid 14;
    property LabeldZ: Double dispid 2;
  end;

// *********************************************************************//
// Interface: ILineGroup
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7FB0B801-1864-11D9-9A07-0050BA51A6D3}
// *********************************************************************//
  ILineGroup = interface(IDispatch)
    ['{7FB0B801-1864-11D9-9A07-0050BA51A6D3}']
    function Get_Lines: IDMCollection; safecall;
    procedure ReorderLines(const Lines: IDMCollection); safecall;
    property Lines: IDMCollection read Get_Lines;
  end;

// *********************************************************************//
// DispIntf:  ILineGroupDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7FB0B801-1864-11D9-9A07-0050BA51A6D3}
// *********************************************************************//
  ILineGroupDisp = dispinterface
    ['{7FB0B801-1864-11D9-9A07-0050BA51A6D3}']
    property Lines: IDMCollection readonly dispid 1;
    procedure ReorderLines(const Lines: IDMCollection); dispid 2;
  end;

// *********************************************************************//
// Interface: IVolumeBuilder
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {43380B81-916F-11D9-9A87-0050BA51A6D3}
// *********************************************************************//
  IVolumeBuilder = interface(IDispatch)
    ['{43380B81-916F-11D9-9A87-0050BA51A6D3}']
    function BuildVolume(const BaseAreas: IDMCollection; Height: Double; Direction: Integer; 
                         const ParentVolume: IVolume; AddView: WordBool): IDMElement; safecall;
    procedure CheckHAreas(const ParentVolume: IVolume; const Volume: IVolume; 
                          BuildDirection: Integer; CommonVolumeFlag: WordBool); safecall;
    function UpdateAreas(const Element: IDMElement): WordBool; safecall;
    function LineDivideArea(const C0: ICoordNode; const C1: ICoordNode; const aArea: IArea): IArea; safecall;
    procedure IntersectSurface; safecall;
    function AreaIsObsolet(const AreaE: IDMElement): WordBool; safecall;
    procedure SelectTopEdges; safecall;
  end;

// *********************************************************************//
// DispIntf:  IVolumeBuilderDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {43380B81-916F-11D9-9A87-0050BA51A6D3}
// *********************************************************************//
  IVolumeBuilderDisp = dispinterface
    ['{43380B81-916F-11D9-9A87-0050BA51A6D3}']
    function BuildVolume(const BaseAreas: IDMCollection; Height: Double; Direction: Integer; 
                         const ParentVolume: IVolume; AddView: WordBool): IDMElement; dispid 1;
    procedure CheckHAreas(const ParentVolume: IVolume; const Volume: IVolume; 
                          BuildDirection: Integer; CommonVolumeFlag: WordBool); dispid 2;
    function UpdateAreas(const Element: IDMElement): WordBool; dispid 3;
    function LineDivideArea(const C0: ICoordNode; const C1: ICoordNode; const aArea: IArea): IArea; dispid 4;
    procedure IntersectSurface; dispid 5;
    function AreaIsObsolet(const AreaE: IDMElement): WordBool; dispid 6;
    procedure SelectTopEdges; dispid 7;
  end;

// *********************************************************************//
// Interface: IVolume2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8B8E7D43-E149-11D9-9ADE-0050BA51A6D3}
// *********************************************************************//
  IVolume2 = interface(IDispatch)
    ['{8B8E7D43-E149-11D9-9ADE-0050BA51A6D3}']
    function Get_OuterVolume: IVolume; safecall;
    function Get_InnerVolumeCount: Integer; safecall;
    function Get_InnerVolume(Index: Integer): IVolume; safecall;
    property OuterVolume: IVolume read Get_OuterVolume;
    property InnerVolumeCount: Integer read Get_InnerVolumeCount;
    property InnerVolume[Index: Integer]: IVolume read Get_InnerVolume;
  end;

// *********************************************************************//
// DispIntf:  IVolume2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8B8E7D43-E149-11D9-9ADE-0050BA51A6D3}
// *********************************************************************//
  IVolume2Disp = dispinterface
    ['{8B8E7D43-E149-11D9-9ADE-0050BA51A6D3}']
    property OuterVolume: IVolume readonly dispid 1;
    property InnerVolumeCount: Integer readonly dispid 2;
    property InnerVolume[Index: Integer]: IVolume readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IPainter3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CBDE9B2B-A453-4229-A8FE-EECF9D504B78}
// *********************************************************************//
  IPainter3 = interface(IDispatch)
    ['{CBDE9B2B-A453-4229-A8FE-EECF9D504B78}']
    function Get_CanvasSet: Integer; safecall;
    procedure Set_CanvasSet(Value: Integer); safecall;
    procedure FastDraw; safecall;
    procedure ResizeBack(Flag: Integer); safecall;
    procedure FlipFrontBack; safecall;
    procedure SaveCenterPos; safecall;
    procedure FlipBackCanvas; safecall;
    property CanvasSet: Integer read Get_CanvasSet write Set_CanvasSet;
  end;

// *********************************************************************//
// DispIntf:  IPainter3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CBDE9B2B-A453-4229-A8FE-EECF9D504B78}
// *********************************************************************//
  IPainter3Disp = dispinterface
    ['{CBDE9B2B-A453-4229-A8FE-EECF9D504B78}']
    property CanvasSet: Integer dispid 1;
    procedure FastDraw; dispid 3;
    procedure ResizeBack(Flag: Integer); dispid 4;
    procedure FlipFrontBack; dispid 5;
    procedure SaveCenterPos; dispid 6;
    procedure FlipBackCanvas; dispid 2;
  end;

// *********************************************************************//
// Interface: ISpatialModel3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A3DA6407-0BA8-4FB5-A446-55B6CA0F2FE7}
// *********************************************************************//
  ISpatialModel3 = interface(IDispatch)
    ['{A3DA6407-0BA8-4FB5-A446-55B6CA0F2FE7}']
    function Get_DrawThreadTerminated: WordBool; safecall;
    procedure Set_DrawThreadTerminated(Value: WordBool); safecall;
    function Get_DrawThreadFinished: WordBool; safecall;
    procedure Set_DrawThreadFinished(Value: WordBool); safecall;
    property DrawThreadTerminated: WordBool read Get_DrawThreadTerminated write Set_DrawThreadTerminated;
    property DrawThreadFinished: WordBool read Get_DrawThreadFinished write Set_DrawThreadFinished;
  end;

// *********************************************************************//
// DispIntf:  ISpatialModel3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A3DA6407-0BA8-4FB5-A446-55B6CA0F2FE7}
// *********************************************************************//
  ISpatialModel3Disp = dispinterface
    ['{A3DA6407-0BA8-4FB5-A446-55B6CA0F2FE7}']
    property DrawThreadTerminated: WordBool dispid 1;
    property DrawThreadFinished: WordBool dispid 3;
  end;

// *********************************************************************//
// Interface: ICircle
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EF731B99-BB53-4682-BC39-1E85B9294F4D}
// *********************************************************************//
  ICircle = interface(IDispatch)
    ['{EF731B99-BB53-4682-BC39-1E85B9294F4D}']
    function Get_X: Double; safecall;
    procedure Set_X(Value: Double); safecall;
    function Get_Y: Double; safecall;
    procedure Set_Y(Value: Double); safecall;
    function Get_Z: Double; safecall;
    procedure Set_Z(Value: Double); safecall;
    function Get_Radius: Double; safecall;
    procedure Set_Radius(Value: Double); safecall;
    property X: Double read Get_X write Set_X;
    property Y: Double read Get_Y write Set_Y;
    property Z: Double read Get_Z write Set_Z;
    property Radius: Double read Get_Radius write Set_Radius;
  end;

// *********************************************************************//
// DispIntf:  ICircleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EF731B99-BB53-4682-BC39-1E85B9294F4D}
// *********************************************************************//
  ICircleDisp = dispinterface
    ['{EF731B99-BB53-4682-BC39-1E85B9294F4D}']
    property X: Double dispid 1;
    property Y: Double dispid 2;
    property Z: Double dispid 3;
    property Radius: Double dispid 4;
  end;

// *********************************************************************//
// Interface: IRotater
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5765BAA6-4851-4EC7-977D-A5CA5867179E}
// *********************************************************************//
  IRotater = interface(IDispatch)
    ['{5765BAA6-4851-4EC7-977D-A5CA5867179E}']
    procedure Rotate(X0: Double; Y0: Double; CosA: Double; SinA: Double); safecall;
  end;

// *********************************************************************//
// DispIntf:  IRotaterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5765BAA6-4851-4EC7-977D-A5CA5867179E}
// *********************************************************************//
  IRotaterDisp = dispinterface
    ['{5765BAA6-4851-4EC7-977D-A5CA5867179E}']
    procedure Rotate(X0: Double; Y0: Double; CosA: Double; SinA: Double); dispid 1;
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
    function Get_View: IView;
    procedure Set_View(const Value: IView);
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
    function Get_LocalView: IView;
    procedure Set_LocalView(const Value: IView);
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
    property UseLayers: WordBool read Get_UseLayers;
    property View: IView read Get_View write Set_View;
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
    property LocalView: IView read Get_LocalView write Set_LocalView;
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
    function Get_View: IView;
    procedure Set_View(const Value: IView);
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
    function Get_LocalView: IView;
    procedure Set_LocalView(const Value: IView);
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
    property View: IView read Get_View write Set_View;
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
    property LocalView: IView read Get_LocalView write Set_LocalView;
    property LayerIndex: Integer read Get_LayerIndex write Set_LayerIndex;
    property Mode: Integer read Get_Mode write Set_Mode;
    property IsPrinter: WordBool read Get_IsPrinter write Set_IsPrinter;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoSMDocument provides a Create and CreateRemote method to          
// create instances of the default interface ISMDocument exposed by              
// the CoClass SMDocument. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSMDocument = class
    class function Create: ISMDocument;
    class function CreateRemote(const MachineName: string): ISMDocument;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSMDocument
// Help String      : SMDocument Object
// Default Interface: ISMDocument
// Def. Intf. DISP? : No
// Event   Interface: ISMDocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSMDocumentProperties= class;
{$ENDIF}
  TSMDocument = class(TOleServer)
  private
    FIntf:        ISMDocument;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSMDocumentProperties;
    function      GetServerProperties: TSMDocumentProperties;
{$ENDIF}
    function      GetDefaultInterface: ISMDocument;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Painter: IPainter;
    procedure Set_Painter(const Value: IPainter);
    function Get_CurrX: Double;
    function Get_CurrY: Double;
    function Get_CurrZ: Double;
    function Get_CurrPX: Integer;
    function Get_CurrPY: Integer;
    function Get_CurrPZ: Integer;
    function Get_HWindowFocused: WordBool;
    procedure Set_HWindowFocused(Value: WordBool);
    function Get_VWindowFocused: WordBool;
    procedure Set_VWindowFocused(Value: WordBool);
    function Get_ShowAxesMode: WordBool;
    procedure Set_ShowAxesMode(Value: WordBool);
    function Get_DontDragMouse: SYSINT;
    procedure Set_DontDragMouse(Value: SYSINT);
    function Get_P0X: Integer;
    function Get_P0Y: Integer;
    function Get_P0Z: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISMDocument);
    procedure Disconnect; override;
    procedure SetCurrXYZ(aCurrX: Double; aCurrY: Double; aCurrZ: Double);
    procedure MouseMove(ShiftState: Integer; XP: Integer; YP: Integer; Tag: Integer);
    procedure MouseDown(ShiftState: Integer);
    procedure ShowAxes;
    procedure SaveView(const aView: IView);
    procedure RestoreView;
    procedure ZoomSelection;
    procedure MouseDrag;
    procedure SelectAllNodes;
    property DefaultInterface: ISMDocument read GetDefaultInterface;
    property CurrX: Double read Get_CurrX;
    property CurrY: Double read Get_CurrY;
    property CurrZ: Double read Get_CurrZ;
    property CurrPX: Integer read Get_CurrPX;
    property CurrPY: Integer read Get_CurrPY;
    property CurrPZ: Integer read Get_CurrPZ;
    property P0X: Integer read Get_P0X;
    property P0Y: Integer read Get_P0Y;
    property P0Z: Integer read Get_P0Z;
    property Painter: IPainter read Get_Painter write Set_Painter;
    property HWindowFocused: WordBool read Get_HWindowFocused write Set_HWindowFocused;
    property VWindowFocused: WordBool read Get_VWindowFocused write Set_VWindowFocused;
    property ShowAxesMode: WordBool read Get_ShowAxesMode write Set_ShowAxesMode;
    property DontDragMouse: SYSINT read Get_DontDragMouse write Set_DontDragMouse;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSMDocumentProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSMDocument
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSMDocumentProperties = class(TPersistent)
  private
    FServer:    TSMDocument;
    function    GetDefaultInterface: ISMDocument;
    constructor Create(AServer: TSMDocument);
  protected
    function Get_Painter: IPainter;
    procedure Set_Painter(const Value: IPainter);
    function Get_CurrX: Double;
    function Get_CurrY: Double;
    function Get_CurrZ: Double;
    function Get_CurrPX: Integer;
    function Get_CurrPY: Integer;
    function Get_CurrPZ: Integer;
    function Get_HWindowFocused: WordBool;
    procedure Set_HWindowFocused(Value: WordBool);
    function Get_VWindowFocused: WordBool;
    procedure Set_VWindowFocused(Value: WordBool);
    function Get_ShowAxesMode: WordBool;
    procedure Set_ShowAxesMode(Value: WordBool);
    function Get_DontDragMouse: SYSINT;
    procedure Set_DontDragMouse(Value: SYSINT);
    function Get_P0X: Integer;
    function Get_P0Y: Integer;
    function Get_P0Z: Integer;
  public
    property DefaultInterface: ISMDocument read GetDefaultInterface;
  published
    property Painter: IPainter read Get_Painter write Set_Painter;
    property HWindowFocused: WordBool read Get_HWindowFocused write Set_HWindowFocused;
    property VWindowFocused: WordBool read Get_VWindowFocused write Set_VWindowFocused;
    property ShowAxesMode: WordBool read Get_ShowAxesMode write Set_ShowAxesMode;
    property DontDragMouse: SYSINT read Get_DontDragMouse write Set_DontDragMouse;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoSpatialModel provides a Create and CreateRemote method to          
// create instances of the default interface ISpatialModel2 exposed by              
// the CoClass SpatialModel. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSpatialModel = class
    class function Create: ISpatialModel2;
    class function CreateRemote(const MachineName: string): ISpatialModel2;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSpatialModel
// Help String      : SpatialModel
// Default Interface: ISpatialModel2
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSpatialModelProperties= class;
{$ENDIF}
  TSpatialModel = class(TOleServer)
  private
    FIntf:        ISpatialModel2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSpatialModelProperties;
    function      GetServerProperties: TSpatialModelProperties;
{$ENDIF}
    function      GetDefaultInterface: ISpatialModel2;
  protected
    procedure InitServerData; override;
    function Get_Areas: IDMCollection;
    function Get_Volumes: IDMCollection;
    function Get_Views: IDMCollection;
    function Get_RenderAreasMode: Integer;
    procedure Set_RenderAreasMode(Value: Integer);
    function Get_DefaultVolumeHeight: Double;
    procedure Set_DefaultVolumeHeight(Value: Double);
    function Get_MinX: Double;
    function Get_MinY: Double;
    function Get_MinZ: Double;
    function Get_MaxX: Double;
    function Get_MaxY: Double;
    function Get_MaxZ: Double;
    function Get_DefaultVerticalAreaWidth: Double;
    procedure Set_DefaultVerticalAreaWidth(Value: Double);
    function Get_Fonts: IDMCollection;
    function Get_Labels: IDMCollection;
    function Get_CurrentFont: ISMFont;
    procedure Set_CurrentFont(const Value: ISMFont);
    function Get_ReliefLayer: IDMElement;
    procedure Set_ReliefLayer(const Value: IDMElement);
    function Get_BuildVerticalLine: WordBool;
    procedure Set_BuildVerticalLine(Value: WordBool);
    function Get_DefaultObjectWidth: Double;
    procedure Set_DefaultObjectWidth(Value: Double);
    function Get_BuildJoinedVolume: WordBool;
    procedure Set_BuildJoinedVolume(Value: WordBool);
    function Get_AreasOrdered: WordBool;
    procedure Set_AreasOrdered(Value: WordBool);
    function Get_DrawOrdered: WordBool;
    procedure Set_DrawOrdered(Value: WordBool);
    function Get_LocalGridCell: Double;
    procedure Set_LocalGridCell(Value: Double);
    function Get_ChangeLengthDirection: Integer;
    procedure Set_ChangeLengthDirection(Value: Integer);
    function Get_EdgeNodeDeletionAllowed: WordBool;
    function Get_VerticalBoundaryLayer: IDMElement;
    procedure Set_VerticalBoundaryLayer(const Value: IDMElement);
    function Get_BuildDirection: Integer;
    procedure Set_BuildDirection(Value: Integer);
    function Get_BuildWallsOnAllLevels: WordBool;
    procedure Set_BuildWallsOnAllLevels(Value: WordBool);
    function Get_EnabledBuildDirection: Integer;
    procedure Set_EnabledBuildDirection(Value: Integer);
    function Get_FastDraw: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISpatialModel2);
    procedure Disconnect; override;
    function BuildAreaSurrounding(WX: Double; WY: Double; WZ: Double): IArea;
    function GetAreaEqualTo(const aArea: IArea): IArea;
    function GetVolumeContaining(PX: Double; PY: Double; PZ: Double): IVolume;
    procedure CalcLimits;
    procedure GetRefElementParent(ClassID: Integer; OperationCode: Integer; PX: Double; PY: Double; 
                                  PZ: Double; out aParent: IDMElement; 
                                  out DMClassCollections: IDMClassCollections; 
                                  out RefSource: IDMCollection; out aCollection: IDMCollection);
    procedure GetDefaultAreaRefRef(const VolumeE: IDMElement; Mode: Integer; 
                                   BaseVolumeFlag: WordBool; out aCollection: IDMCollection; 
                                   out aName: WideString; out AreaRefRef: IDMElement);
    procedure CheckVolumeContent(const NewVolmes: IDMCollection; const Volume: IVolume; 
                                 Mode: Integer);
    function CanDeleteNow(const aElement: IDMElement; const DeleteCollection: IDMCollection): WordBool;
    procedure UpdateVolumes;
    procedure MakeVolumeOutline(const aVolume: IVolume; const aCollection: IDMCollection);
    procedure CalcVolumeMinMaxZ(const Volume: IVolume);
    procedure GetUpperLowerVolumeParams(const VolumeRef: IDMElement; 
                                        out UpperVolumeRefRef: IDMElement; 
                                        out LowerVolumeRefRef: IDMElement; 
                                        out VolumeHeight: Double; out UpperVolumeHeight: Double; 
                                        out LowerVolumeHeight: Double; 
                                        out UpperVolumeUseSpecLayer: WordBool; 
                                        out LowerUseSpecLayer: WordBool; 
                                        out TopAreaUseSpecLayer: WordBool);
    function GetColVolumeContaining(PX: Double; PY: Double; PZ: Double; 
                                    const ColAreas: IDMCollection; const Volumes: IDMCollection): WordBool;
    procedure GetInnerVolumes(const VolumeE: IDMElement; const InnerVolumes: IDMCollection);
    function GetOuterVolume(const VolumeE: IDMElement): IDMElement;
    property DefaultInterface: ISpatialModel2 read GetDefaultInterface;
    property Areas: IDMCollection read Get_Areas;
    property Volumes: IDMCollection read Get_Volumes;
    property Views: IDMCollection read Get_Views;
    property MinX: Double read Get_MinX;
    property MinY: Double read Get_MinY;
    property MinZ: Double read Get_MinZ;
    property MaxX: Double read Get_MaxX;
    property MaxY: Double read Get_MaxY;
    property MaxZ: Double read Get_MaxZ;
    property Fonts: IDMCollection read Get_Fonts;
    property Labels: IDMCollection read Get_Labels;
    property EdgeNodeDeletionAllowed: WordBool read Get_EdgeNodeDeletionAllowed;
    property FastDraw: WordBool read Get_FastDraw;
    property RenderAreasMode: Integer read Get_RenderAreasMode write Set_RenderAreasMode;
    property DefaultVolumeHeight: Double read Get_DefaultVolumeHeight write Set_DefaultVolumeHeight;
    property DefaultVerticalAreaWidth: Double read Get_DefaultVerticalAreaWidth write Set_DefaultVerticalAreaWidth;
    property CurrentFont: ISMFont read Get_CurrentFont write Set_CurrentFont;
    property ReliefLayer: IDMElement read Get_ReliefLayer write Set_ReliefLayer;
    property BuildVerticalLine: WordBool read Get_BuildVerticalLine write Set_BuildVerticalLine;
    property DefaultObjectWidth: Double read Get_DefaultObjectWidth write Set_DefaultObjectWidth;
    property BuildJoinedVolume: WordBool read Get_BuildJoinedVolume write Set_BuildJoinedVolume;
    property AreasOrdered: WordBool read Get_AreasOrdered write Set_AreasOrdered;
    property DrawOrdered: WordBool read Get_DrawOrdered write Set_DrawOrdered;
    property LocalGridCell: Double read Get_LocalGridCell write Set_LocalGridCell;
    property ChangeLengthDirection: Integer read Get_ChangeLengthDirection write Set_ChangeLengthDirection;
    property VerticalBoundaryLayer: IDMElement read Get_VerticalBoundaryLayer write Set_VerticalBoundaryLayer;
    property BuildDirection: Integer read Get_BuildDirection write Set_BuildDirection;
    property BuildWallsOnAllLevels: WordBool read Get_BuildWallsOnAllLevels write Set_BuildWallsOnAllLevels;
    property EnabledBuildDirection: Integer read Get_EnabledBuildDirection write Set_EnabledBuildDirection;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSpatialModelProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSpatialModel
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSpatialModelProperties = class(TPersistent)
  private
    FServer:    TSpatialModel;
    function    GetDefaultInterface: ISpatialModel2;
    constructor Create(AServer: TSpatialModel);
  protected
    function Get_Areas: IDMCollection;
    function Get_Volumes: IDMCollection;
    function Get_Views: IDMCollection;
    function Get_RenderAreasMode: Integer;
    procedure Set_RenderAreasMode(Value: Integer);
    function Get_DefaultVolumeHeight: Double;
    procedure Set_DefaultVolumeHeight(Value: Double);
    function Get_MinX: Double;
    function Get_MinY: Double;
    function Get_MinZ: Double;
    function Get_MaxX: Double;
    function Get_MaxY: Double;
    function Get_MaxZ: Double;
    function Get_DefaultVerticalAreaWidth: Double;
    procedure Set_DefaultVerticalAreaWidth(Value: Double);
    function Get_Fonts: IDMCollection;
    function Get_Labels: IDMCollection;
    function Get_CurrentFont: ISMFont;
    procedure Set_CurrentFont(const Value: ISMFont);
    function Get_ReliefLayer: IDMElement;
    procedure Set_ReliefLayer(const Value: IDMElement);
    function Get_BuildVerticalLine: WordBool;
    procedure Set_BuildVerticalLine(Value: WordBool);
    function Get_DefaultObjectWidth: Double;
    procedure Set_DefaultObjectWidth(Value: Double);
    function Get_BuildJoinedVolume: WordBool;
    procedure Set_BuildJoinedVolume(Value: WordBool);
    function Get_AreasOrdered: WordBool;
    procedure Set_AreasOrdered(Value: WordBool);
    function Get_DrawOrdered: WordBool;
    procedure Set_DrawOrdered(Value: WordBool);
    function Get_LocalGridCell: Double;
    procedure Set_LocalGridCell(Value: Double);
    function Get_ChangeLengthDirection: Integer;
    procedure Set_ChangeLengthDirection(Value: Integer);
    function Get_EdgeNodeDeletionAllowed: WordBool;
    function Get_VerticalBoundaryLayer: IDMElement;
    procedure Set_VerticalBoundaryLayer(const Value: IDMElement);
    function Get_BuildDirection: Integer;
    procedure Set_BuildDirection(Value: Integer);
    function Get_BuildWallsOnAllLevels: WordBool;
    procedure Set_BuildWallsOnAllLevels(Value: WordBool);
    function Get_EnabledBuildDirection: Integer;
    procedure Set_EnabledBuildDirection(Value: Integer);
    function Get_FastDraw: WordBool;
  public
    property DefaultInterface: ISpatialModel2 read GetDefaultInterface;
  published
    property RenderAreasMode: Integer read Get_RenderAreasMode write Set_RenderAreasMode;
    property DefaultVolumeHeight: Double read Get_DefaultVolumeHeight write Set_DefaultVolumeHeight;
    property DefaultVerticalAreaWidth: Double read Get_DefaultVerticalAreaWidth write Set_DefaultVerticalAreaWidth;
    property CurrentFont: ISMFont read Get_CurrentFont write Set_CurrentFont;
    property ReliefLayer: IDMElement read Get_ReliefLayer write Set_ReliefLayer;
    property BuildVerticalLine: WordBool read Get_BuildVerticalLine write Set_BuildVerticalLine;
    property DefaultObjectWidth: Double read Get_DefaultObjectWidth write Set_DefaultObjectWidth;
    property BuildJoinedVolume: WordBool read Get_BuildJoinedVolume write Set_BuildJoinedVolume;
    property AreasOrdered: WordBool read Get_AreasOrdered write Set_AreasOrdered;
    property DrawOrdered: WordBool read Get_DrawOrdered write Set_DrawOrdered;
    property LocalGridCell: Double read Get_LocalGridCell write Set_LocalGridCell;
    property ChangeLengthDirection: Integer read Get_ChangeLengthDirection write Set_ChangeLengthDirection;
    property VerticalBoundaryLayer: IDMElement read Get_VerticalBoundaryLayer write Set_VerticalBoundaryLayer;
    property BuildDirection: Integer read Get_BuildDirection write Set_BuildDirection;
    property BuildWallsOnAllLevels: WordBool read Get_BuildWallsOnAllLevels write Set_BuildWallsOnAllLevels;
    property EnabledBuildDirection: Integer read Get_EnabledBuildDirection write Set_EnabledBuildDirection;
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
    ClassID:   '{62264B18-E560-11D5-92FE-0050BA51A6D3}';
    IntfIID:   '{62264B16-E560-11D5-92FE-0050BA51A6D3}';
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

function TPainter.Get_View: IView;
begin
    Result := DefaultInterface.View;
end;

procedure TPainter.Set_View(const Value: IView);
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

function TPainter.Get_LocalView: IView;
begin
    Result := DefaultInterface.LocalView;
end;

procedure TPainter.Set_LocalView(const Value: IView);
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

function TPainterProperties.Get_View: IView;
begin
    Result := DefaultInterface.View;
end;

procedure TPainterProperties.Set_View(const Value: IView);
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

function TPainterProperties.Get_LocalView: IView;
begin
    Result := DefaultInterface.LocalView;
end;

procedure TPainterProperties.Set_LocalView(const Value: IView);
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

class function CoSMDocument.Create: ISMDocument;
begin
  Result := CreateComObject(CLASS_SMDocument) as ISMDocument;
end;

class function CoSMDocument.CreateRemote(const MachineName: string): ISMDocument;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SMDocument) as ISMDocument;
end;

procedure TSMDocument.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{62264B1E-E560-11D5-92FE-0050BA51A6D3}';
    IntfIID:   '{62264B1A-E560-11D5-92FE-0050BA51A6D3}';
    EventIID:  '{62264B1C-E560-11D5-92FE-0050BA51A6D3}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSMDocument.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as ISMDocument;
  end;
end;

procedure TSMDocument.ConnectTo(svrIntf: ISMDocument);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TSMDocument.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TSMDocument.GetDefaultInterface: ISMDocument;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSMDocument.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSMDocumentProperties.Create(Self);
{$ENDIF}
end;

destructor TSMDocument.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSMDocument.GetServerProperties: TSMDocumentProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TSMDocument.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
  end; {case DispID}
end;

function TSMDocument.Get_Painter: IPainter;
begin
    Result := DefaultInterface.Painter;
end;

procedure TSMDocument.Set_Painter(const Value: IPainter);
begin
  Exit;
end;

function TSMDocument.Get_CurrX: Double;
begin
    Result := DefaultInterface.CurrX;
end;

function TSMDocument.Get_CurrY: Double;
begin
    Result := DefaultInterface.CurrY;
end;

function TSMDocument.Get_CurrZ: Double;
begin
    Result := DefaultInterface.CurrZ;
end;

function TSMDocument.Get_CurrPX: Integer;
begin
    Result := DefaultInterface.CurrPX;
end;

function TSMDocument.Get_CurrPY: Integer;
begin
    Result := DefaultInterface.CurrPY;
end;

function TSMDocument.Get_CurrPZ: Integer;
begin
    Result := DefaultInterface.CurrPZ;
end;

function TSMDocument.Get_HWindowFocused: WordBool;
begin
    Result := DefaultInterface.HWindowFocused;
end;

procedure TSMDocument.Set_HWindowFocused(Value: WordBool);
begin
  Exit;
end;

function TSMDocument.Get_VWindowFocused: WordBool;
begin
    Result := DefaultInterface.VWindowFocused;
end;

procedure TSMDocument.Set_VWindowFocused(Value: WordBool);
begin
  Exit;
end;

function TSMDocument.Get_ShowAxesMode: WordBool;
begin
    Result := DefaultInterface.ShowAxesMode;
end;

procedure TSMDocument.Set_ShowAxesMode(Value: WordBool);
begin
  Exit;
end;

function TSMDocument.Get_DontDragMouse: SYSINT;
begin
    Result := DefaultInterface.DontDragMouse;
end;

procedure TSMDocument.Set_DontDragMouse(Value: SYSINT);
begin
  Exit;
end;

function TSMDocument.Get_P0X: Integer;
begin
    Result := DefaultInterface.P0X;
end;

function TSMDocument.Get_P0Y: Integer;
begin
    Result := DefaultInterface.P0Y;
end;

function TSMDocument.Get_P0Z: Integer;
begin
    Result := DefaultInterface.P0Z;
end;

procedure TSMDocument.SetCurrXYZ(aCurrX: Double; aCurrY: Double; aCurrZ: Double);
begin
  DefaultInterface.SetCurrXYZ(aCurrX, aCurrY, aCurrZ);
end;

procedure TSMDocument.MouseMove(ShiftState: Integer; XP: Integer; YP: Integer; Tag: Integer);
begin
  DefaultInterface.MouseMove(ShiftState, XP, YP, Tag);
end;

procedure TSMDocument.MouseDown(ShiftState: Integer);
begin
  DefaultInterface.MouseDown(ShiftState);
end;

procedure TSMDocument.ShowAxes;
begin
  DefaultInterface.ShowAxes;
end;

procedure TSMDocument.SaveView(const aView: IView);
begin
  DefaultInterface.SaveView(aView);
end;

procedure TSMDocument.RestoreView;
begin
  DefaultInterface.RestoreView;
end;

procedure TSMDocument.ZoomSelection;
begin
  DefaultInterface.ZoomSelection;
end;

procedure TSMDocument.MouseDrag;
begin
  DefaultInterface.MouseDrag;
end;

procedure TSMDocument.SelectAllNodes;
begin
  DefaultInterface.SelectAllNodes;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSMDocumentProperties.Create(AServer: TSMDocument);
begin
  inherited Create;
  FServer := AServer;
end;

function TSMDocumentProperties.GetDefaultInterface: ISMDocument;
begin
  Result := FServer.DefaultInterface;
end;

function TSMDocumentProperties.Get_Painter: IPainter;
begin
    Result := DefaultInterface.Painter;
end;

procedure TSMDocumentProperties.Set_Painter(const Value: IPainter);
begin
  Exit;
end;

function TSMDocumentProperties.Get_CurrX: Double;
begin
    Result := DefaultInterface.CurrX;
end;

function TSMDocumentProperties.Get_CurrY: Double;
begin
    Result := DefaultInterface.CurrY;
end;

function TSMDocumentProperties.Get_CurrZ: Double;
begin
    Result := DefaultInterface.CurrZ;
end;

function TSMDocumentProperties.Get_CurrPX: Integer;
begin
    Result := DefaultInterface.CurrPX;
end;

function TSMDocumentProperties.Get_CurrPY: Integer;
begin
    Result := DefaultInterface.CurrPY;
end;

function TSMDocumentProperties.Get_CurrPZ: Integer;
begin
    Result := DefaultInterface.CurrPZ;
end;

function TSMDocumentProperties.Get_HWindowFocused: WordBool;
begin
    Result := DefaultInterface.HWindowFocused;
end;

procedure TSMDocumentProperties.Set_HWindowFocused(Value: WordBool);
begin
  Exit;
end;

function TSMDocumentProperties.Get_VWindowFocused: WordBool;
begin
    Result := DefaultInterface.VWindowFocused;
end;

procedure TSMDocumentProperties.Set_VWindowFocused(Value: WordBool);
begin
  Exit;
end;

function TSMDocumentProperties.Get_ShowAxesMode: WordBool;
begin
    Result := DefaultInterface.ShowAxesMode;
end;

procedure TSMDocumentProperties.Set_ShowAxesMode(Value: WordBool);
begin
  Exit;
end;

function TSMDocumentProperties.Get_DontDragMouse: SYSINT;
begin
    Result := DefaultInterface.DontDragMouse;
end;

procedure TSMDocumentProperties.Set_DontDragMouse(Value: SYSINT);
begin
  Exit;
end;

function TSMDocumentProperties.Get_P0X: Integer;
begin
    Result := DefaultInterface.P0X;
end;

function TSMDocumentProperties.Get_P0Y: Integer;
begin
    Result := DefaultInterface.P0Y;
end;

function TSMDocumentProperties.Get_P0Z: Integer;
begin
    Result := DefaultInterface.P0Z;
end;

{$ENDIF}

class function CoSpatialModel.Create: ISpatialModel2;
begin
  Result := CreateComObject(CLASS_SpatialModel) as ISpatialModel2;
end;

class function CoSpatialModel.CreateRemote(const MachineName: string): ISpatialModel2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SpatialModel) as ISpatialModel2;
end;

procedure TSpatialModel.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{62264B0A-E560-11D5-92FE-0050BA51A6D3}';
    IntfIID:   '{62264B3F-E560-11D5-92FE-0050BA51A6D3}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSpatialModel.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ISpatialModel2;
  end;
end;

procedure TSpatialModel.ConnectTo(svrIntf: ISpatialModel2);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSpatialModel.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSpatialModel.GetDefaultInterface: ISpatialModel2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSpatialModel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSpatialModelProperties.Create(Self);
{$ENDIF}
end;

destructor TSpatialModel.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSpatialModel.GetServerProperties: TSpatialModelProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TSpatialModel.Get_Areas: IDMCollection;
begin
    Result := DefaultInterface.Areas;
end;

function TSpatialModel.Get_Volumes: IDMCollection;
begin
    Result := DefaultInterface.Volumes;
end;

function TSpatialModel.Get_Views: IDMCollection;
begin
    Result := DefaultInterface.Views;
end;

function TSpatialModel.Get_RenderAreasMode: Integer;
begin
    Result := DefaultInterface.RenderAreasMode;
end;

procedure TSpatialModel.Set_RenderAreasMode(Value: Integer);
begin
  Exit;
end;

function TSpatialModel.Get_DefaultVolumeHeight: Double;
begin
    Result := DefaultInterface.DefaultVolumeHeight;
end;

procedure TSpatialModel.Set_DefaultVolumeHeight(Value: Double);
begin
  Exit;
end;

function TSpatialModel.Get_MinX: Double;
begin
    Result := DefaultInterface.MinX;
end;

function TSpatialModel.Get_MinY: Double;
begin
    Result := DefaultInterface.MinY;
end;

function TSpatialModel.Get_MinZ: Double;
begin
    Result := DefaultInterface.MinZ;
end;

function TSpatialModel.Get_MaxX: Double;
begin
    Result := DefaultInterface.MaxX;
end;

function TSpatialModel.Get_MaxY: Double;
begin
    Result := DefaultInterface.MaxY;
end;

function TSpatialModel.Get_MaxZ: Double;
begin
    Result := DefaultInterface.MaxZ;
end;

function TSpatialModel.Get_DefaultVerticalAreaWidth: Double;
begin
    Result := DefaultInterface.DefaultVerticalAreaWidth;
end;

procedure TSpatialModel.Set_DefaultVerticalAreaWidth(Value: Double);
begin
  Exit;
end;

function TSpatialModel.Get_Fonts: IDMCollection;
begin
    Result := DefaultInterface.Fonts;
end;

function TSpatialModel.Get_Labels: IDMCollection;
begin
    Result := DefaultInterface.Labels;
end;

function TSpatialModel.Get_CurrentFont: ISMFont;
begin
    Result := DefaultInterface.CurrentFont;
end;

procedure TSpatialModel.Set_CurrentFont(const Value: ISMFont);
begin
  Exit;
end;

function TSpatialModel.Get_ReliefLayer: IDMElement;
begin
    Result := DefaultInterface.ReliefLayer;
end;

procedure TSpatialModel.Set_ReliefLayer(const Value: IDMElement);
begin
  Exit;
end;

function TSpatialModel.Get_BuildVerticalLine: WordBool;
begin
    Result := DefaultInterface.BuildVerticalLine;
end;

procedure TSpatialModel.Set_BuildVerticalLine(Value: WordBool);
begin
  Exit;
end;

function TSpatialModel.Get_DefaultObjectWidth: Double;
begin
    Result := DefaultInterface.DefaultObjectWidth;
end;

procedure TSpatialModel.Set_DefaultObjectWidth(Value: Double);
begin
  Exit;
end;

function TSpatialModel.Get_BuildJoinedVolume: WordBool;
begin
    Result := DefaultInterface.BuildJoinedVolume;
end;

procedure TSpatialModel.Set_BuildJoinedVolume(Value: WordBool);
begin
  Exit;
end;

function TSpatialModel.Get_AreasOrdered: WordBool;
begin
    Result := DefaultInterface.AreasOrdered;
end;

procedure TSpatialModel.Set_AreasOrdered(Value: WordBool);
begin
  Exit;
end;

function TSpatialModel.Get_DrawOrdered: WordBool;
begin
    Result := DefaultInterface.DrawOrdered;
end;

procedure TSpatialModel.Set_DrawOrdered(Value: WordBool);
begin
  Exit;
end;

function TSpatialModel.Get_LocalGridCell: Double;
begin
    Result := DefaultInterface.LocalGridCell;
end;

procedure TSpatialModel.Set_LocalGridCell(Value: Double);
begin
  Exit;
end;

function TSpatialModel.Get_ChangeLengthDirection: Integer;
begin
    Result := DefaultInterface.ChangeLengthDirection;
end;

procedure TSpatialModel.Set_ChangeLengthDirection(Value: Integer);
begin
  Exit;
end;

function TSpatialModel.Get_EdgeNodeDeletionAllowed: WordBool;
begin
    Result := DefaultInterface.EdgeNodeDeletionAllowed;
end;

function TSpatialModel.Get_VerticalBoundaryLayer: IDMElement;
begin
    Result := DefaultInterface.VerticalBoundaryLayer;
end;

procedure TSpatialModel.Set_VerticalBoundaryLayer(const Value: IDMElement);
begin
  Exit;
end;

function TSpatialModel.Get_BuildDirection: Integer;
begin
    Result := DefaultInterface.BuildDirection;
end;

procedure TSpatialModel.Set_BuildDirection(Value: Integer);
begin
  Exit;
end;

function TSpatialModel.Get_BuildWallsOnAllLevels: WordBool;
begin
    Result := DefaultInterface.BuildWallsOnAllLevels;
end;

procedure TSpatialModel.Set_BuildWallsOnAllLevels(Value: WordBool);
begin
  Exit;
end;

function TSpatialModel.Get_EnabledBuildDirection: Integer;
begin
    Result := DefaultInterface.EnabledBuildDirection;
end;

procedure TSpatialModel.Set_EnabledBuildDirection(Value: Integer);
begin
  Exit;
end;

function TSpatialModel.Get_FastDraw: WordBool;
begin
    Result := DefaultInterface.FastDraw;
end;

function TSpatialModel.BuildAreaSurrounding(WX: Double; WY: Double; WZ: Double): IArea;
begin
  Result := DefaultInterface.BuildAreaSurrounding(WX, WY, WZ);
end;

function TSpatialModel.GetAreaEqualTo(const aArea: IArea): IArea;
begin
  Result := DefaultInterface.GetAreaEqualTo(aArea);
end;

function TSpatialModel.GetVolumeContaining(PX: Double; PY: Double; PZ: Double): IVolume;
begin
  Result := DefaultInterface.GetVolumeContaining(PX, PY, PZ);
end;

procedure TSpatialModel.CalcLimits;
begin
  DefaultInterface.CalcLimits;
end;

procedure TSpatialModel.GetRefElementParent(ClassID: Integer; OperationCode: Integer; PX: Double; 
                                            PY: Double; PZ: Double; out aParent: IDMElement; 
                                            out DMClassCollections: IDMClassCollections; 
                                            out RefSource: IDMCollection; 
                                            out aCollection: IDMCollection);
begin
  DefaultInterface.GetRefElementParent(ClassID, OperationCode, PX, PY, PZ, aParent, 
                                       DMClassCollections, RefSource, aCollection);
end;

procedure TSpatialModel.GetDefaultAreaRefRef(const VolumeE: IDMElement; Mode: Integer; 
                                             BaseVolumeFlag: WordBool; 
                                             out aCollection: IDMCollection; out aName: WideString; 
                                             out AreaRefRef: IDMElement);
begin
  DefaultInterface.GetDefaultAreaRefRef(VolumeE, Mode, BaseVolumeFlag, aCollection, aName, 
                                        AreaRefRef);
end;

procedure TSpatialModel.CheckVolumeContent(const NewVolmes: IDMCollection; const Volume: IVolume; 
                                           Mode: Integer);
begin
  DefaultInterface.CheckVolumeContent(NewVolmes, Volume, Mode);
end;

function TSpatialModel.CanDeleteNow(const aElement: IDMElement; 
                                    const DeleteCollection: IDMCollection): WordBool;
begin
  Result := DefaultInterface.CanDeleteNow(aElement, DeleteCollection);
end;

procedure TSpatialModel.UpdateVolumes;
begin
  DefaultInterface.UpdateVolumes;
end;

procedure TSpatialModel.MakeVolumeOutline(const aVolume: IVolume; const aCollection: IDMCollection);
begin
  DefaultInterface.MakeVolumeOutline(aVolume, aCollection);
end;

procedure TSpatialModel.CalcVolumeMinMaxZ(const Volume: IVolume);
begin
  DefaultInterface.CalcVolumeMinMaxZ(Volume);
end;

procedure TSpatialModel.GetUpperLowerVolumeParams(const VolumeRef: IDMElement; 
                                                  out UpperVolumeRefRef: IDMElement; 
                                                  out LowerVolumeRefRef: IDMElement; 
                                                  out VolumeHeight: Double; 
                                                  out UpperVolumeHeight: Double; 
                                                  out LowerVolumeHeight: Double; 
                                                  out UpperVolumeUseSpecLayer: WordBool; 
                                                  out LowerUseSpecLayer: WordBool; 
                                                  out TopAreaUseSpecLayer: WordBool);
begin
  DefaultInterface.GetUpperLowerVolumeParams(VolumeRef, UpperVolumeRefRef, LowerVolumeRefRef, 
                                             VolumeHeight, UpperVolumeHeight, LowerVolumeHeight, 
                                             UpperVolumeUseSpecLayer, LowerUseSpecLayer, 
                                             TopAreaUseSpecLayer);
end;

function TSpatialModel.GetColVolumeContaining(PX: Double; PY: Double; PZ: Double; 
                                              const ColAreas: IDMCollection; 
                                              const Volumes: IDMCollection): WordBool;
begin
  Result := DefaultInterface.GetColVolumeContaining(PX, PY, PZ, ColAreas, Volumes);
end;

procedure TSpatialModel.GetInnerVolumes(const VolumeE: IDMElement; const InnerVolumes: IDMCollection);
begin
  DefaultInterface.GetInnerVolumes(VolumeE, InnerVolumes);
end;

function TSpatialModel.GetOuterVolume(const VolumeE: IDMElement): IDMElement;
begin
  Result := DefaultInterface.GetOuterVolume(VolumeE);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSpatialModelProperties.Create(AServer: TSpatialModel);
begin
  inherited Create;
  FServer := AServer;
end;

function TSpatialModelProperties.GetDefaultInterface: ISpatialModel2;
begin
  Result := FServer.DefaultInterface;
end;

function TSpatialModelProperties.Get_Areas: IDMCollection;
begin
    Result := DefaultInterface.Areas;
end;

function TSpatialModelProperties.Get_Volumes: IDMCollection;
begin
    Result := DefaultInterface.Volumes;
end;

function TSpatialModelProperties.Get_Views: IDMCollection;
begin
    Result := DefaultInterface.Views;
end;

function TSpatialModelProperties.Get_RenderAreasMode: Integer;
begin
    Result := DefaultInterface.RenderAreasMode;
end;

procedure TSpatialModelProperties.Set_RenderAreasMode(Value: Integer);
begin
  Exit;
end;

function TSpatialModelProperties.Get_DefaultVolumeHeight: Double;
begin
    Result := DefaultInterface.DefaultVolumeHeight;
end;

procedure TSpatialModelProperties.Set_DefaultVolumeHeight(Value: Double);
begin
  Exit;
end;

function TSpatialModelProperties.Get_MinX: Double;
begin
    Result := DefaultInterface.MinX;
end;

function TSpatialModelProperties.Get_MinY: Double;
begin
    Result := DefaultInterface.MinY;
end;

function TSpatialModelProperties.Get_MinZ: Double;
begin
    Result := DefaultInterface.MinZ;
end;

function TSpatialModelProperties.Get_MaxX: Double;
begin
    Result := DefaultInterface.MaxX;
end;

function TSpatialModelProperties.Get_MaxY: Double;
begin
    Result := DefaultInterface.MaxY;
end;

function TSpatialModelProperties.Get_MaxZ: Double;
begin
    Result := DefaultInterface.MaxZ;
end;

function TSpatialModelProperties.Get_DefaultVerticalAreaWidth: Double;
begin
    Result := DefaultInterface.DefaultVerticalAreaWidth;
end;

procedure TSpatialModelProperties.Set_DefaultVerticalAreaWidth(Value: Double);
begin
  Exit;
end;

function TSpatialModelProperties.Get_Fonts: IDMCollection;
begin
    Result := DefaultInterface.Fonts;
end;

function TSpatialModelProperties.Get_Labels: IDMCollection;
begin
    Result := DefaultInterface.Labels;
end;

function TSpatialModelProperties.Get_CurrentFont: ISMFont;
begin
    Result := DefaultInterface.CurrentFont;
end;

procedure TSpatialModelProperties.Set_CurrentFont(const Value: ISMFont);
begin
  Exit;
end;

function TSpatialModelProperties.Get_ReliefLayer: IDMElement;
begin
    Result := DefaultInterface.ReliefLayer;
end;

procedure TSpatialModelProperties.Set_ReliefLayer(const Value: IDMElement);
begin
  Exit;
end;

function TSpatialModelProperties.Get_BuildVerticalLine: WordBool;
begin
    Result := DefaultInterface.BuildVerticalLine;
end;

procedure TSpatialModelProperties.Set_BuildVerticalLine(Value: WordBool);
begin
  Exit;
end;

function TSpatialModelProperties.Get_DefaultObjectWidth: Double;
begin
    Result := DefaultInterface.DefaultObjectWidth;
end;

procedure TSpatialModelProperties.Set_DefaultObjectWidth(Value: Double);
begin
  Exit;
end;

function TSpatialModelProperties.Get_BuildJoinedVolume: WordBool;
begin
    Result := DefaultInterface.BuildJoinedVolume;
end;

procedure TSpatialModelProperties.Set_BuildJoinedVolume(Value: WordBool);
begin
  Exit;
end;

function TSpatialModelProperties.Get_AreasOrdered: WordBool;
begin
    Result := DefaultInterface.AreasOrdered;
end;

procedure TSpatialModelProperties.Set_AreasOrdered(Value: WordBool);
begin
  Exit;
end;

function TSpatialModelProperties.Get_DrawOrdered: WordBool;
begin
    Result := DefaultInterface.DrawOrdered;
end;

procedure TSpatialModelProperties.Set_DrawOrdered(Value: WordBool);
begin
  Exit;
end;

function TSpatialModelProperties.Get_LocalGridCell: Double;
begin
    Result := DefaultInterface.LocalGridCell;
end;

procedure TSpatialModelProperties.Set_LocalGridCell(Value: Double);
begin
  Exit;
end;

function TSpatialModelProperties.Get_ChangeLengthDirection: Integer;
begin
    Result := DefaultInterface.ChangeLengthDirection;
end;

procedure TSpatialModelProperties.Set_ChangeLengthDirection(Value: Integer);
begin
  Exit;
end;

function TSpatialModelProperties.Get_EdgeNodeDeletionAllowed: WordBool;
begin
    Result := DefaultInterface.EdgeNodeDeletionAllowed;
end;

function TSpatialModelProperties.Get_VerticalBoundaryLayer: IDMElement;
begin
    Result := DefaultInterface.VerticalBoundaryLayer;
end;

procedure TSpatialModelProperties.Set_VerticalBoundaryLayer(const Value: IDMElement);
begin
  Exit;
end;

function TSpatialModelProperties.Get_BuildDirection: Integer;
begin
    Result := DefaultInterface.BuildDirection;
end;

procedure TSpatialModelProperties.Set_BuildDirection(Value: Integer);
begin
  Exit;
end;

function TSpatialModelProperties.Get_BuildWallsOnAllLevels: WordBool;
begin
    Result := DefaultInterface.BuildWallsOnAllLevels;
end;

procedure TSpatialModelProperties.Set_BuildWallsOnAllLevels(Value: WordBool);
begin
  Exit;
end;

function TSpatialModelProperties.Get_EnabledBuildDirection: Integer;
begin
    Result := DefaultInterface.EnabledBuildDirection;
end;

procedure TSpatialModelProperties.Set_EnabledBuildDirection(Value: Integer);
begin
  Exit;
end;

function TSpatialModelProperties.Get_FastDraw: WordBool;
begin
    Result := DefaultInterface.FastDraw;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TPainter, TSMDocument, TSpatialModel]);
end;

end.
