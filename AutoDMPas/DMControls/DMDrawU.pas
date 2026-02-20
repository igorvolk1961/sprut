unit DMDrawU;

{$WARN SYMBOL_PLATFORM OFF}

interface

//{$INCLUDE SprutDef.inc}

uses
  DM_Windows, DM_Messages, Types, Variants,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, ImgList, Menus, Printers, Buttons, ExtCtrls, ComCtrls,
  StdCtrls, Grids, ToolWin, Spin,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU, PainterLib_TLB,
  SpatialModelLib_TLB, DMDrawConstU, ClipBrd, Math,
  DrawToolsConstU, JPEG;

const
  SaveViewDialogEventId=8886;
  CreateLayerDialogEventId=8887;
  ColorDialogEventId=8888;

  FrontCanvas=1;
  BackCanvas=2;
  BackCanvas2=4;

type

  TPainterPanel = class(TPanel)
  private
    FPainter: IPainter;
    procedure Set_Painter(const Value: IPainter);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
  public
    constructor Create(aOwner:TComponent); override;
    destructor  Destroy; override;
    property  Painter:IPainter read FPainter write Set_Painter;
    procedure Mouse_Move(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Mouse_Down(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
    procedure Mouse_Up(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
    procedure Key_Up(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;

  TStylePanel = class(TPanel)
  published
   property Canvas;
  public
   Color: TColor;
   Style: integer;
   Thickness: integer;
   ElementCount: integer;
   LayersCount: integer;
   procedure Paint; override;
  end;

  TDataModelRefs = class(TList)
  private
    function Get_DataModels(Index:integer):IDataModel;
  public
    property DataModels[Index:integer]:IDataModel read Get_DataModels; default;
  end;

  TDMDraw = class(TDMPage)
    ColorDialog1: TColorDialog;
    PopupMenu1: TPopupMenu;
    miEdit1: TMenuItem;
    miSpace1: TMenuItem;
    miEscape1: TMenuItem;
    pm_sbZAngle: TPopupMenu;
    mi_IntrvAngele: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    pmMinmaxD: TPopupMenu;
    mi_MinmaxD: TMenuItem;
    N4: TMenuItem;
    mi_Dmax: TMenuItem;
    mi_Dmin: TMenuItem;
    pmMinmaxZ: TPopupMenu;
    mi_IntervalDZ_2: TMenuItem;
    mi_IntervalZ: TMenuItem;
    MenuItem3: TMenuItem;
    mi_Zmax: TMenuItem;
    mi_Zmin: TMenuItem;
    ControlBar1: TControlBar;
    PanelInfo: TPanel;
    PageControl: TPageControl;
    tsXYZ: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    edX: TEdit;
    edZ: TEdit;
    edScale: TEdit;
    sbScale: TSpinButton;
    edZAngle: TEdit;
    sbZAngle: TSpinButton;
    tsSection: TTabSheet;
    LDmax: TLabel;
    Label4: TLabel;
    LDMin: TLabel;
    Label6: TLabel;
    Label16: TLabel;
    edDmax: TEdit;
    edZmax: TEdit;
    edDmin: TEdit;
    edZmin: TEdit;
    pm_Layers: TPopupMenu;
    mi_AddLayer: TMenuItem;
    mi_DeleteLayer: TMenuItem;
    N1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    miPalette: TMenuItem;
    mi_RenameView: TMenuItem;
    mi_RenameLayer: TMenuItem;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    Splitter1: TSplitter;
    Panel0: TPanel;
    Splitter2: TSplitter;
    PanelVert: TPanel;
    pnZRange: TPanel;
    spZmax: TSplitter;
    spZmin: TSplitter;
    pnZmax: TPanel;
    pnZmin: TPanel;
    PanelZ: TPanel;
    PanelHoriz: TPanel;
    pnDRange: TPanel;
    spDMax: TSplitter;
    spDmin: TSplitter;
    pnDmax: TPanel;
    pnDmin: TPanel;
    PanelX: TPanel;
    PanelY: TPanel;
    pn_PointParam: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    lb_ID: TLabel;
    ed_Y: TEdit;
    ed_X: TEdit;
    ed_Z: TEdit;
    pn_AreaParam: TPanel;
    lb_AreaZmax: TLabel;
    lb_AreaZmin: TLabel;
    lb_TopLinesCount: TLabel;
    lb_BottomLinesCount: TLabel;
    lb_Volums: TLabel;
    ed_MinZ: TEdit;
    ed_MaxZ: TEdit;
    pn_LineParam: TPanel;
    lb_ID0: TLabel;
    lb_ID1: TLabel;
    lb_Len: TLabel;
    Image1: TImage;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lb_Equal: TLabel;
    ed_X0: TEdit;
    ed_Y0: TEdit;
    ed_X1: TEdit;
    ed_Y1: TEdit;
    ed_Z0: TEdit;
    ed_Z1: TEdit;
    ed_Length: TEdit;
    ed_ZAngle: TEdit;
    pn_VolumeParam: TPanel;
    lb_AreasCount: TLabel;
    lb_TopAreasCount: TLabel;
    lb_BottomAreasCount: TLabel;
    ld_AreaMaxZ: TLabel;
    lb_AreaMinZ: TLabel;
    ed_VolumeMinZ: TEdit;
    ed_VolumeMaxZ: TEdit;
    sb_ScrollZ: TScrollBar;
    sb_ScrollY: TScrollBar;
    sb_ScrollX: TScrollBar;
    Label7: TLabel;
    Label11: TLabel;
    tsViews: TTabSheet;
    Panel3: TPanel;
    btAddView: TButton;
    btDelView: TButton;
    btUpdateView: TButton;
    btRestoreView: TButton;
    sgViews: TStringGrid;
    tsLayers: TTabSheet;
    Panel1: TPanel;
    bt_SetOne: TButton;
    bt_SetCurLayer: TButton;
    Button2: TButton;
    Button3: TButton;
    bt_SetAll: TButton;
    sgLayers: TStringGrid;
    tsProperties: TTabSheet;
    pn_Param: TPanel;
    pn_ObjectName: TPanel;
    lb_SelectCount: TLabel;
    lb_ClassAlias: TLabel;
    lbSelLayer: TLabel;
    cb_SelectLayer: TComboBox;
    sbZ: TSpinButton;
    pPolar: TPanel;
    Label8: TLabel;
    Label10: TLabel;
    edPAngle: TEdit;
    edPLength: TEdit;
    btJoinLayer: TButton;
    tsHistory: TTabSheet;
    lsTransactions: TListBox;
    pn_ParentParam: TPanel;
    lb_Parents: TListBox;
    pn_HeadParent: TPanel;
    lb_HeadParent: TLabel;
    pn_SelectedParam: TPanel;
    pmRapair: TPopupMenu;
    miRepairAdd: TMenuItem;
    miRepairRemove: TMenuItem;
    miRepairSelect: TMenuItem;
    miCreateLink: TMenuItem;
    pn_LabelParam: TPanel;
    lb_Label: TLabel;
    ed_Name: TEdit;
    lb_AreaSize1: TLabel;
    ed_AreaSize1: TEdit;
    btF5: TBitBtn;
    btF6: TBitBtn;
    btF4: TBitBtn;
    chbChangeLengthDirection: TComboBox;
    Label2: TLabel;
    Label9: TLabel;
    chbChangeWidthDirection: TComboBox;
    Timer1: TTimer;
    edY: TEdit;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Panel4: TPanel;
    s_but_CrossLine: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    cbLayerRef: TComboBox;
    pn_ImageRectParam: TPanel;
    lb_IID0: TLabel;
    lb_IID1: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    SpeedButton4: TSpeedButton;
    ed_IX0: TEdit;
    ed_IY0: TEdit;
    ed_IX1: TEdit;
    ed_IY1: TEdit;
    ed_IZ0: TEdit;
    ed_IZ1: TEdit;
    ed_Alpha: TEdit;
    Timer2: TTimer;
    Label12: TLabel;
    lb_Height: TLabel;        //таб.видов

    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure CoolBar1DockOver(Sender: TObject; Source: TDragDockObject;
              X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ControlBar1DockOver(Sender: TObject; Source: TDragDockObject;
              X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tbShowAxesClick(Sender: TObject);
    procedure tbAddViewClck(Sender: TObject);
    procedure edZangleChange(Sender: TObject);
    procedure cbViewsChange(Sender: TObject);
    procedure edXYZKeyPress(Sender: TObject; var Key: Char);
    procedure miKeyClick(Sender: TObject);
    procedure CreateLayer(Sender: TObject);
    procedure DeleteLayer(Sender: TObject);
    procedure PanelLayerStyleClick(Sender: TObject);
    procedure PanelLayerStyleMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edXYZEnter(Sender: TObject);
    procedure edXYZExit(Sender: TObject);
    procedure sbScaleUpClick(Sender: TObject);
    procedure sbScaleDownClick(Sender: TObject);
    procedure edScaleChange(Sender: TObject);
    procedure HPanelResize(Sender: TObject);
    procedure VPanelResize(Sender: TObject);
    procedure spDminMoved(Sender: TObject);
    procedure spDMaxMoved(Sender: TObject);
    procedure spZmaxMoved(Sender: TObject);
    procedure spZminMoved(Sender: TObject);
    procedure pnRangeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edDmaxChange(Sender: TObject);
    procedure edDminChange(Sender: TObject);
    procedure edZmaxChange(Sender: TObject);
    procedure edZminChange(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure sbDMaxDownClick(Sender: TObject);
    procedure sbDMaxUpClick(Sender: TObject);
    procedure sbDMinDownClick(Sender: TObject);
    procedure sbDMinUpClick(Sender: TObject);
    procedure sbZMaxDownClick(Sender: TObject);
    procedure sbZMaxUpClick(Sender: TObject);
    procedure sbZMinDownClick(Sender: TObject);
    procedure sbZMinUpClick(Sender: TObject);
    procedure sbZAngleDownClick(Sender: TObject);
    procedure sbZAngleUpClick(Sender: TObject);
    procedure mi_IntrvAngeleClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure mi_IntervalDZClick(Sender: TObject);
    procedure mi_IntervalDClick(Sender: TObject);
    procedure mi_IntervalZClick(Sender: TObject);
    procedure cbLayersDblClick(Sender: TObject);
    procedure tbRepaintClick(Sender: TObject);
    procedure ToolBarExit(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure sb_ScrollYChange(Sender: TObject);
    procedure sb_ScrollXChange(Sender: TObject);
    procedure sb_ScrollZChange(Sender: TObject);
    procedure sb_ScrollZEnter(Sender: TObject);
    procedure sb_ScrollZExit(Sender: TObject);
    procedure sb_ScrollYEnter(Sender: TObject);
    procedure sb_ScrollYExit(Sender: TObject);
    procedure sb_ScrollXExit(Sender: TObject);
    procedure sb_ScrollXEnter(Sender: TObject);
    procedure PanelInfoEnter(Sender: TObject);
    procedure PanelInfoExit(Sender: TObject);
    procedure edIntrvDZChange(Sender: TObject);
    procedure edIntrvThicknessChange(Sender: TObject);
    procedure edInrvZminChange(Sender: TObject);
    procedure edIntrvZmaxChange(Sender: TObject);
//    procedure edIntrvAngeleChange(Sender: TObject);
    procedure sgLayersDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure PanelHorizMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DelLayerClick(Sender: TObject);
    procedure btDelViewClick(Sender: TObject);
    procedure sgViewsDblClick(Sender: TObject);
    procedure cb_SelectListClick(Sender: TObject);
    procedure SelectLayerChange(Sender: TObject);
    procedure ed_PointChangeKeyPress(Sender: TObject; var Key: Char);
    procedure ed_AreaChangeKeyPress(Sender: TObject; var Key: Char);
    procedure ed_VolumeChangeKeyPress(Sender: TObject; var Key: Char);
    procedure ed_YDblClick(Sender: TObject);
    procedure ed_CoordDblClick(Sender: TObject);
    procedure bt_SetCurLayerClick(Sender: TObject);
    procedure bt_SetAllClick(Sender: TObject);
    procedure bt_SetOneClick(Sender: TObject);
    procedure sgLayersDblClick(Sender: TObject);
    procedure s_but_CrossLineClick(Sender: TObject);
    procedure Panel0CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure btRestoreViewClick(Sender: TObject);
    procedure btUpdateViewClick(Sender: TObject);
    procedure sgLayersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbZDownClick(Sender: TObject);
    procedure edZDblClick(Sender: TObject);
    procedure sbZUpClick(Sender: TObject);
    procedure btJoinLayerClick(Sender: TObject);
    procedure sgLayersSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure lsTransactionsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lsTransactionsDblClick(Sender: TObject);
    procedure edXYZKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPLengthKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ed_LineChangeKeyPress(Sender: TObject; var Key: Char);
    procedure edPLengthChange(Sender: TObject);
    procedure edXYZChange(Sender: TObject);
    procedure ts3DMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miRepairAddClick(Sender: TObject);
    procedure miRepairRemoveClick(Sender: TObject);
    procedure miRepairSelectClick(Sender: TObject);
    procedure lb_ParentsDblClick(Sender: TObject);
    procedure lb_HeadParentClick(Sender: TObject);
    procedure ed_NameKeyPress(Sender: TObject; var Key: Char);
    procedure ControlBar1Click(Sender: TObject);
    procedure PanelClick(Sender: TObject);
    procedure mi_RenameLayerClick(Sender: TObject);
    procedure mi_RenameViewClick(Sender: TObject);
    procedure sgViewsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgViewsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgViewsExit(Sender: TObject);
    procedure sgLayersExit(Sender: TObject);
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cb_SelectLayerClick(Sender: TObject);
    procedure btF5Click(Sender: TObject);
    procedure btF6Click(Sender: TObject);
    procedure btF4Click(Sender: TObject);
    procedure chbChangeLengthDirectionChange(Sender: TObject);
    procedure sb_ScrollScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure sgViewsRowMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure Splitter2CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure Panel0Resize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure miPaletteClick(Sender: TObject);
    procedure sgLayersRowMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure edPLengthKeyPress(Sender: TObject; var Key: Char);
    procedure edPAngleKeyPress(Sender: TObject; var Key: Char);
    procedure edZAngleKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbLayerRefChange(Sender: TObject);
    procedure cbLayerRefKeyPress(Sender: TObject; var Key: Char);
    procedure cbLayerRefExit(Sender: TObject);
    procedure ed_AlphaKeyPress(Sender: TObject; var Key: Char);
    procedure Timer2Timer(Sender: TObject);
  private
//    FEvents: IDMDrawXEvents;

    FDataModels:TDataModelRefs;

    FPainter: IPainter;
    FLayerRefTypes: IDMCollection;

    FEditMode: boolean;
    FChangingCurrentPoint:boolean;
    FChangingView:boolean;
    FChangingSelection:boolean;
    FOnUpdateViewList: TNotifyEvent;
    FRangeChangedFlag:boolean;
    FSettingRangeMarksFlag:boolean;
    FLastKey:Word;

//    FPanelLayerStyle: TStylePanel;
    FHPainterPanel:TPainterPanel;
    FVPainterPanel:TPainterPanel;
    FDrawRangeMarksFlag:boolean;
    FCursorType:integer;
    FIncrementZ:double;
    FIntervalAngle:extended;
    FIntervalHeight:extended;
    FIntervalThickness:extended;
    FIntervalDmax:extended;
    FIntervalDmin:extended;
    FIntervalZmax:extended;
    FIntervalZmin:extended;
    FIntervalValue:double;
    FScrollXOld:integer;
    FScrollYOld:integer;
    FScrollZOld:integer;
    FScrollXFlag:boolean;
    FScrollYFlag:boolean;
    FScrollZFlag:boolean;

    FOldLayoutName:array [0..255] of char;

    FLastDrawElement:IDMElement;
    FPaintFlag:boolean;

    FMacrosCurrX: double;
    FMacrosCurrY: double;
    FMacrosCurrZ: double;

    FRefreshFlagSet:integer;
    FSplitterMoved:boolean;
    FHVRatio:double;
    FWaitForTimer:boolean;
    
    procedure CreatePainter;
    procedure OnChangeSelection;

    procedure OnDragLine(Length, Angle:double);
    procedure LoadRasterImage(var aGraphicFileName:string);
    procedure LoadVectorImage(var aGraphicFileName:string);
    procedure Set_SpatialModel(const Value: ISpatialModel);
    procedure SetRangeEditors;
    procedure SetHRangeMarks;
    procedure SetVRangeMarks;
    procedure DoPaint;
    procedure PainterPanelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PainterPanelKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetOperationButton;
    procedure SetLayers;
    procedure SetViews;
    procedure Set_ParamVisionSelection(Control: integer);
    procedure OnChangeView;
    procedure JoinLayer(const DestLayerE, SourceLayerE: IDMElement);
    procedure RenameView;
    procedure RenameLayer;
    procedure ChangeLineWidth;

{$IFDEF Demo}
    procedure WriteClickControlMacros(Sender: TObject);
    procedure WriteSelectCellMacros(Sender: TObject; aCol, aRow:integer);
    procedure WriteDblClickControlMacros(Sender: TObject);
    procedure WriteSpeedButtonDownMacros(Sender: TObject);
    procedure WriteSpeedButtonUpMacros(Sender: TObject);
    procedure WriteRadioButtonMacros(Sender: TObject);
    procedure WriteKeyDownMacros(Sender: TObject; Key: Integer);
    procedure InitFindTabSheetMacros;
    procedure InitControlEventMacros;
    procedure InitStringGridEventMacros;
{$ENDIF Demo}
    procedure DoCreateView(const S:string);
    procedure DoCreateLayer(const S:string);
    procedure SetTransformButtons;
    procedure Panoram;
  protected
    FSpatialModel:ISpatialModel;
    FOldPaletteWidth:integer;
    FOldPanelVertHeight:integer;

    procedure DocumentOperation(ElementsV,
      CollectionV: OleVariant; DMOperation, nItemIndex: Integer); override; safecall;
    procedure UpdateDocument; override; safecall;
    procedure OpenDocument; override; safecall;
    procedure RefreshDocument(FlagSet:integer); override; safecall;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;
    procedure GetFocus; override;

    procedure PrintPainterPanel;
    procedure WMChangeSelection(var Message: TMessage); message WM_ChangeSelection;
//    procedure SelectionChanged(DMElement:OleVariant); override; safecall;
    procedure WMDragLine(var Message: TMessage); message WM_DragLine;
    procedure PrintPainter(aCanvasTag:integer);
    procedure DrawElement(aElement:IDMElement);
    procedure DeleteSelected; override;
    procedure CopyToBuffer; override;
    function PasteFromBuffer:boolean; override;
    function READChange(Sender:TObject):double;
    function DoAction(ActionCode: integer):WordBool; override; safecall;
    function  Get_ToolButtonCount: Integer; override; safecall;
    procedure GetToolButtonProperties(Index:integer;
                                      var aToolBarTag: Integer; var aButtonImageIndex: Integer;
                                      var aButtonTag: Integer; var aStyle: Integer;
                                      var aMode: Integer; var aGroup:Integer;
                                      var aHint: WideString); override; safecall;
    function  Get_ToolButtonImageCount: Integer; override; safecall;
    function  Get_ToolButtonImage(Index:integer): WideString; override; safecall;
    function  Get_InstanceHandle: Integer; override; safecall;

    procedure CheckDocumentState; override; safecall;
    
    procedure SetPanelRatio(Ratio: Double); virtual; safecall;
    procedure SetOptionsPage(const PageName: WideString); virtual; safecall;
    procedure SetView(const ViewName: WideString); virtual; safecall;
    procedure SetLayer(const LayerName: WideString); virtual; safecall;
    procedure SetCentralPoint(X, Y: Double); virtual; safecall;
    procedure ShowLayerKinds; virtual;

{$IFDEF Demo}
    function DoMacrosStep(RecordKind, ControlID: Integer; EventID: Integer;
                  X: Integer; Y: Integer; const S:WideString):WordBool; override; safecall;
    procedure WriteMacrosState; override; safecall;
    procedure SetMacrosState(ParamID, Z, X, Y:integer); override; safecall;
{$ENDIF}
  public
    FDragging:boolean;

    procedure Initialize; override;
    destructor Destroy; override;
    function WantChildKey(Child: TControl; var Message: TMessage): Boolean; override;

    procedure CallRefresh(FlagSet:integer);
  end;


var
  FShiftState:integer;
  HPanel:TPainterPanel;
  VPanel:TPainterPanel;


implementation

uses
  MyWin, ComObj,
  IntervalAngleFrm,
  LayerPropertiesFrm, DZFrm,
  DrawPrintOptionsFrm, LayerListFrm, IDInputFrm, VolumeLinkFrm,
  SpatialModelConstU, LinkClass;

{$R *.DFM}
{$R DMDrawCursors.RES}
{$R DrawTools.RES}


procedure CheckText(aEdit:TEdit);
var
  D:double;
  C:integer;
begin
  Val(aEdit.Text,D,C);
  if (C<>0) then begin
    aEdit.Font.Color:=clRed;
    Exit
  end else
    aEdit.Font.Color:=0;
end;

procedure TPainterPanel.Set_Painter(const Value: IPainter);
var
  Painter3:IPainter3;
begin
  FPainter := Value;
  case Tag of
  1: begin
        FPainter.HHeight:=Height;
        FPainter.HWidth:=Width;
        if FPainter.QueryInterface(IPainter3, Painter3)=0 then
          Painter3.ResizeBack(1);
     end;
  2: begin
        FPainter.VHeight:=Height;
        FPainter.VWidth:=Width;
        if FPainter.QueryInterface(IPainter3, Painter3)=0 then
          Painter3.ResizeBack(2);
      end;
  end;
end;

procedure TPainterPanel.CMMouseEnter(var Message: TMessage);
var
  SMDocument:ISMDocument;
  DMDrawX:TDMDraw;
begin
  inherited;
  DMDrawX:=TDMDraw(Owner);
  DMDrawX.Timer2.Enabled:=False;
  SMDocument:=(DMDrawX.Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  if SMDocument.ShowAxesMode then
     SMDocument.ShowAxes;
  if DMDrawX.FDrawRangeMarksFlag then begin
     DMDrawX.FDrawRangeMarksFlag:=False;
     Painter.DrawRangeMarks;
      if DMDrawX.FRangeChangedFlag then begin
        DMDrawX.FRangeChangedFlag:=False;
//        DMDrawX.Repaint;
      end;
  end;
end;

procedure TPainterPanel.CMMouseLeave(var Message: TMessage);
var
  SMDocument:ISMDocument;
  DMDraw:TDMDraw;
begin
  DMDraw:=TDMDraw(Owner);
  SMDocument:=(DMDraw.Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  if SMDocument.ShowAxesMode then
     SMDocument.ShowAxes;
  if Self<>DMDraw.FHPainterPanel then Exit;
  DMDraw.Panoram;
  DMDraw.Timer2.Enabled:=True;
end;

{ TCustomDMDrawX }

procedure TDMDraw.Initialize;
begin
  inherited Initialize;
  cbLayerRef.Ctl3D:=False;
  cbLayerRef.Height:=15;
  
//  OnActivate := ActivateEvent;
end;
{
procedure TCustomDMDrawX.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;
}

//*********************************************
constructor TPainterPanel.Create(aOwner: TComponent);
begin
  inherited;
  OnMouseMove:=Mouse_Move;
  OnMouseDown:=Mouse_Down;
  OnMouseUp:=Mouse_Up;
  OnKeyUp:=Key_Up;

  Screen.Cursors[cr_Pen] := DM_LoadCursor(HInstance, 'CR_PEN');
  Screen.Cursors[cr_Pen_Line] := DM_LoadCursor(HInstance, 'CR_PEN_LINE');
  Screen.Cursors[cr_Pen_Polyline] := DM_LoadCursor(HInstance, 'CR_PEN_POLYLINE');
  Screen.Cursors[cr_Pen_Curved] := DM_LoadCursor(HInstance, 'CR_PEN_CURVED');
  Screen.Cursors[cr_Pen_Closed] := DM_LoadCursor(HInstance, 'CR_PEN_CLOSED');
  Screen.Cursors[cr_Pen_Rect] := DM_LoadCursor(HInstance, 'CR_PEN_RECT');
  Screen.Cursors[cr_Pen_Incl] := DM_LoadCursor(HInstance, 'CR_PEN_INCL');
  Screen.Cursors[cr_Pen_Ellips] := DM_LoadCursor(HInstance, 'CR_PEN_ELLIPS');
  Screen.Cursors[cr_Pen_Circle] := DM_LoadCursor(HInstance, 'CR_PEN_CIRCLE');
  Screen.Cursors[cr_Pen_Image] := DM_LoadCursor(HInstance, 'CR_PEN_IMAGE');
  Screen.Cursors[cr_Pen_Break] := DM_LoadCursor(HInstance, 'CR_PEN_BREAK');
  Screen.Cursors[cr_Pen_Door] := DM_LoadCursor(HInstance, 'CR_PEN_DOOR');
  Screen.Cursors[cr_Pen_Stairs] := DM_LoadCursor(HInstance, 'CR_PEN_STAIRS');
  Screen.Cursors[cr_Pen_Sensor] := DM_LoadCursor(HInstance, 'CR_PEN_SENSOR');
  Screen.Cursors[cr_Pen_Target] := DM_LoadCursor(HInstance, 'CR_PEN_TARGET');

  Screen.Cursors[cr_Hand_Arrow] := DM_LoadCursor(HInstance, 'cr_HAND_ARROW');
  Screen.Cursors[cr_Hand_HLine] := DM_LoadCursor(HInstance, 'cr_HAND_HLINE');
  Screen.Cursors[cr_Hand_VLine] := DM_LoadCursor(HInstance, 'cr_HAND_VLINE');
  Screen.Cursors[cr_Hand_HArea] := DM_LoadCursor(HInstance, 'cr_HAND_HArea');
  Screen.Cursors[cr_Hand_VArea] := DM_LoadCursor(HInstance, 'cr_HAND_VArea');
  Screen.Cursors[cr_Hand_Zone] := DM_LoadCursor(HInstance, 'cr_HAND_ZONE');
  Screen.Cursors[cr_Hand_Text] := DM_LoadCursor(HInstance, 'cr_HAND_TEXT');

  Screen.Cursors[cr_HandMoveArrow] := DM_LoadCursor(HInstance, 'cr_HandMoveArrow');
  Screen.Cursors[cr_Hand_Move] := DM_LoadCursor(HInstance, 'cr_Hand_Move');
  Screen.Cursors[cr_Tool_Move] := DM_LoadCursor(HInstance, 'cr_TOOL_MOVE');
  Screen.Cursors[cr_Tool_Scale] := DM_LoadCursor(HInstance, 'cr_TOOL_SCALE');
  Screen.Cursors[cr_Tool_Rotate] := DM_LoadCursor(HInstance, 'cr_TOOL_ROTATE');
  Screen.Cursors[cr_Tool_Mirror] := DM_LoadCursor(HInstance, 'cr_TOOL_MIRROR');
  Screen.Cursors[cr_Tool_Trim] := DM_LoadCursor(HInstance, 'cr_TOOL_TRIM');
  Screen.Cursors[cr_Tool_Out] := DM_LoadCursor(HInstance, 'cr_TOOL_OUT');
  Screen.Cursors[cr_Tool_Sect] := DM_LoadCursor(HInstance, 'cr_TOOL_SECT');

  Screen.Cursors[cr_ZoomIn] := DM_LoadCursor(HInstance, 'cr_ZoomIn');
  Screen.Cursors[cr_ZoomOut] := DM_LoadCursor(HInstance, 'cr_ZoomOut');
  Screen.Cursors[cr_HandZoomIn] := DM_LoadCursor(HInstance, 'cr_HandZoomIn');
  Screen.Cursors[cr_HandZoomOut] := DM_LoadCursor(HInstance, 'cr_HandZoomOut');
  Screen.Cursors[cr_HandV] := DM_LoadCursor(HInstance, 'cr_HandV');
  Screen.Cursors[cr_HandG] := DM_LoadCursor(HInstance, 'cr_HandG');

  Screen.Cursors[cr_Build_Zone] := DM_LoadCursor(HInstance, 'cr_Build_ZONE');
  Screen.Cursors[cr_Build_DivV] := DM_LoadCursor(HInstance, 'cr_Build_DIVV');
  Screen.Cursors[cr_Build_DivH] := DM_LoadCursor(HInstance, 'cr_Build_Wall');
  Screen.Cursors[cr_Build_Door] := DM_LoadCursor(HInstance, 'cr_Build_DOOR');
  Screen.Cursors[cr_Build_Road] := DM_LoadCursor(HInstance, 'cr_Build_ROAD');
  Screen.Cursors[cr_Build_Relief] := DM_LoadCursor(HInstance, 'cr_Build_RELIEF');
  Screen.Cursors[cr_Build_Sectors] := DM_LoadCursor(HInstance, 'cr_Build_SECTORS');

  Cursor := cr_Pen;
end;

procedure TPainterPanel.Mouse_Move(Sender: TObject; Shift: TShiftState;
                 X, Y: Integer);
var
  s:string;
  X0, Y0, Z0, X1, Y1, Z1, XM, YM, ZM, L, A, cos_A, D:double;
  aShiftState:integer;
  aCursor:integer;
  SMDocument:ISMDocument;
  DMDocument:IDMDocument;
  SMOperationManager:ISMOperationManager;
  DMDrawX:TDMDraw;
  DMMacrosManager:IDMMacrosManager;
  aDataModel:IDataModel;
begin
  try
  DMDrawX:=TDMDraw(Owner);
  DMDocument:=(DMDrawX.Get_DataModelServer as IDataModelServer).CurrentDocument;
  if DMDocument=nil then Exit;
  aDataModel:=DMDocument.DataModel as IDataModel;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  SMDocument:=DMDocument as ISMDocument;
  SMOperationManager:=DMDocument as ISMOperationManager;
  aCursor:=DMDocument.Cursor;  //запрос сервера о курсоре тек.шага
  if Cursor<>crHourGlass then
    Cursor:=aCursor;  // уст.курсор тек.шага

  aShiftState:=0;
  if ssShift in Shift then
    aShiftState:=aShiftState or sShift;
  if ssCtrl in Shift then
    aShiftState:=aShiftState or sCtrl;
  if ssAlt in Shift then
    aShiftState:=aShiftState or sAlt;
  if ssLeft in Shift then
    aShiftState:=aShiftState or sLeft;
  if ssRight in Shift then
    aShiftState:=aShiftState or sRight;

{$IFDEF Demo}
  DMMacrosManager:=DMDrawX.Get_DMEditorX as IDMMacrosManager;
  if DMMacrosManager.IsPlaying then
    aShiftState:=FShiftState
{$ENDIF}

  SMDocument.MouseMove(aShiftState, X, Y, TComponent(Sender).Tag);

  if  DMDrawX.FDrawRangeMarksFlag then begin
    DMDrawX.FDrawRangeMarksFlag:=False;    // установка линий
    FPainter.DrawRangeMarks;
  end;

  if DMDrawX.FChangingCurrentPoint then Exit;
  DMDrawX.FChangingCurrentPoint:=True;

  D:=sqrt(sqr(SMDocument.CurrPX-SMDocument.P0X)+sqr(SMDocument.CurrPY-SMDocument.P0Y));
  if (D>20) and
     (ssLeft in Shift) then
    DMDrawX.FDragging:=True;


  X1:=SMDocument.CurrX;
  Y1:=SMDocument.CurrY;
  Z1:=SMDocument.CurrZ;
  XM:=X1/100;
  YM:=Y1/100;
  ZM:=Z1/100;

  DMDrawX.edX.Text:=Format('%0.2f',[XM]);
  DMDrawX.edY.Text:=Format('%0.2f',[YM]);
  DMDrawX.edZ.Text:=Format('%0.2f',[ZM]);
  DMDrawX.edX.Font.Color:=clBlack;
  DMDrawX.edY.Font.Color:=clBlack;
  DMDrawX.edZ.Font.Color:=clBlack;


  if SMOperationManager.OperationStep>0 then begin
    X0:=SMOperationManager.OperationX0;
    Y0:=SMOperationManager.OperationY0;
    Z0:=SMOperationManager.OperationZ0;
    L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0)+sqr(Z1-Z0));
    if L=0 then
      A:=0
    else begin
      cos_A:=(X1-X0)/L;
      A:=arccos(cos_A)/3.1415926*180;
      if Y1-Y0<0 then
        A:=-A;
    end;
    DMDrawX.edPLength.Text:=Format('%0.2f',[L/100]);
    DMDrawX.edPAngle.Text:=Format('%0.2f',[A]);
    DMDrawX.edPLength.Font.Color:=clBlack;
    DMDrawX.edPAngle.Font.Color:=clBlack;
    DMDrawX.pPolar.Visible:=True
  end else begin
    DMDrawX.pPolar.Visible:=False
  end;
  DMDrawX.FChangingCurrentPoint:=False;

  except
    raise
  end
end;

procedure TPainterPanel.Mouse_Down(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  SMDocument:ISMDocument;
  DMDocument:IDMDocument;
  DMDrawX:TDMDraw;
  DMForm:IDMForm;
  XX, YY:integer;
  FormID:integer;
  aDataModel:IDataModel;
begin
  DMDrawX:=TDMDraw(Owner);
  DMForm:=DMDrawX as IDMForm;
  DMDocument:=(DMDrawX.Get_DataModelServer as IDataModelServer).CurrentDocument;
  aDataModel:=DMDocument.DataModel as IDataModel;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  if DMForm.DMEditorX.ActiveForm<>DMForm then
    DMForm.DMEditorX.ActiveForm:=DMForm;

  SetFocus;

  FShiftState:=0;
  if ssShift in Shift then
    FShiftState:=FShiftState or sShift;
  if ssCtrl in Shift then
    FShiftState:=FShiftState or sCtrl;
  if ssAlt in Shift then
    FShiftState:=FShiftState or sAlt;
  if ssLeft in Shift then
    FShiftState:=FShiftState or sLeft;
  if ssRight in Shift then
    FShiftState:=FShiftState or sRight;
  SMDocument:=DMDocument as ISMDocument;

{$R-}
  XX:=round(SMDocument.CurrX*10);
  YY:=round(SMDocument.CurrY*10);
{$R+}
  FormID:=DMForm.FormID;

{$IFDEF Demo}
  (DMDrawX.Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -1, meMouseMove, XX, YY, '');
  if ssRight in Shift then begin
   (DMDrawX.Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrPause, -1, -1, 1, 500, -1, '');
   (DMDrawX.Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -1, meRClick, -1, -1, '')
  end else
  if ssLeft in Shift then
   (DMDrawX.Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -1, meLClick, -1, -1, '');
{$ENDIF}


  SMDocument.MouseDown(FShiftState);

  FShiftState:=0;
end;

procedure TStylePanel.Paint;
begin
  inherited Paint;
   Canvas.Brush.Color:= clWhite;
   Canvas.FillRect(Rect(0,0,Width,Height));


   if ((Style=-2)or(Style=-1))and(ElementCount>1)then
     Canvas.Pen.Color:=clSilver
   else
     if (Color=-2)or(Color=-1) then
       Canvas.Pen.Color:=clBlack
     else
       Canvas.Pen.Color := Color;

   Canvas.Pen.Style := TPenStyle(Style);
   Canvas.Pen.Width := 0;  //Thickness;
   Canvas.MoveTo(0,Round(Height/2));
   Canvas.LineTo(Width,Round(Height/2));
end;

function TDataModelRefs.Get_DataModels(Index:integer):IDataModel;
begin
  Result:=IDataModel(Items[Index]);
end;

//*********************************************************************

procedure TDMDraw.FormCreate(Sender: TObject);
begin
  DecimalSeparator:='.';
  CreatePainter;
  if fmInputValue=nil then
    fmInputValue:=TfmInputValue.Create(Self);
  fmInputValue.InputValueFrmCreate;
  FDataModels:=TDataModelRefs.Create;
  FEditMode:=True;
  PanelVert.Height:=3;
//  with PopupMenu1 do begin
//    Items[1].ShortCut:=ShortCut(VK_F5,[]);
//    Items[2].ShortCut:=ShortCut(VK_F6,[]);
//  end;
  spDmax.Align:=alNone;
  spZmax.Align:=alNone;
  spDmin.Align:=alNone;
  spZmin.Align:=alNone;

  FDrawRangeMarksFlag:=False;

  Application.ProcessMessages;

  spDmax.Top:=50;
  spZmax.Top:=50;
  spDmin.Top:=pnDRange.Height-50;
  spZmin.Top:=pnZRange.Height-50;

  Application.ProcessMessages;

  spDmax.Align:=alTop;
  spZmax.Align:=alTop;
  spDmin.Align:=alBottom;
  spZmin.Align:=alBottom;

  pn_PointParam.Parent:=pn_SelectedParam;
  pn_LineParam.Parent:=pn_SelectedParam;
  pn_ImageRectParam.Parent:=pn_SelectedParam;
  pn_AreaParam.Parent:=pn_SelectedParam;
  pn_VolumeParam.Parent:=pn_SelectedParam;
  pn_LabelParam.Parent:=pn_SelectedParam;

  pn_PointParam.Align:=alClient;
  pn_LineParam.Align:=alClient;
  pn_ImageRectParam.Align:=alClient;
  pn_AreaParam.Align:=alClient;
  pn_VolumeParam.Align:=alClient;
  pn_LabelParam.Align:=alClient;

  pn_ObjectName.Parent:=pn_Param;
  pn_ObjectName.Align:=alTop;

  pn_ParentParam.Align:=alClient;
  lb_Parents.Align:=alClient;

  FScrollXOld:=0;
  FScrollYOld:=0;
  FScrollZOld:=0;
  FScrollXFlag:=True;
  FScrollYFlag:=True;
  FScrollZFlag:=True;

  Set_ParamVisionSelection(0);
  FIntervalValue := 1;
  FIntervalAngle := 5;
  FIntervalHeight:=1;
  FIncrementZ:=1.5;

  sgLayers.Cells[0,0] := 'N';
  sgLayers.Cells[1,0] := 'Слой';
  sgLayers.Cells[7,0] := 'Рубеж';

  sgViews.Cells[1,0] := 'Вид';
  sgViews.Cells[2,0] := 'Z';
  sgViews.Cells[3,0] := 'M';
  sgViews.Cells[4,0] := 'A';

end;

type
  TGetDMClassFactory=function:IDMClassFactory;

procedure TDMDraw.CreatePainter;
var
  H:HMODULE;
  F:TGetDMClassFactory;
  LibName:array[0..255] of Char;
  LibraryPath, PainterFileName:string;
  aPainterFactory:IDMClassFactory;
begin

//   FPainter:=CreateComObject(CLASS_Painter) as IPainter;

   LibraryPath:=Get_DMEditorX.LibraryPath;
   PainterFileName:=LibraryPath+'PainterLib.dll';
   StrPCopy(LibName, PainterFileName);
   H:=DM_LoadLibrary(LibName);
   @F:=DM_GetProcAddress(H, 'GetPainterClassObject');
   aPainterFactory:=F;
   FPainter:=aPainterFactory.CreateInstance as IPainter;

   FHPainterPanel:=TPainterPanel.Create(Self);
   FHPainterPanel.Tag :=1;
   FHPainterPanel.Parent:= PanelHoriz;
   FHPainterPanel.Align:=alClient;
   FHPainterPanel.PopupMenu:=PopupMenu1;
   FHPainterPanel.Painter:=FPainter;
   FHPainterPanel.Color:=clWhite;
   FHPainterPanel.BevelOuter:=bvNone;
   FHPainterPanel.OnResize:=HPanelResize;
   FHPainterPanel.OnKeyDown:=PainterPanelKeyDown;
   FHPainterPanel.OnKeyUp:=PainterPanelKeyUp;

   FVPainterPanel:=TPainterPanel.Create(Self);
   FVPainterPanel.Parent:= PanelVert;
   FVPainterPanel.Align:=alClient;
   FVPainterPanel.PopupMenu:=PopupMenu1;
   FVPainterPanel.Painter:=FPainter;
   FVPainterPanel.Color:=clWhite;
   FVPainterPanel.BevelOuter:=bvNone;
   FVPainterPanel.OnResize:=VPanelResize;
   FVPainterPanel.OnKeyDown:=PainterPanelKeyDown;
   FVPainterPanel.OnKeyUp:=PainterPanelKeyUp;

   HPanel:=FHPainterPanel;
   VPanel:=FVPainterPanel;

end;

procedure TDMDraw.FormPaint(Sender: TObject);
var
  H:HWnd;
  Document:IDMDocument;
  Painter3:IPainter3;
  OldCanvasSet:integer;
  SpatialModel2:ISpatialModel2;
  FastDrawEnabled:WordBool;
begin

  try
  Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if Document=nil then Exit;
  if Document.State and dmfAuto<>0 then Exit;
  FastDrawEnabled:=(GetDataModel as  ISpatialModel2).FastDraw;
  except
    raise
  end;

  try
{$R-}
  H:=FHPainterPanel.Handle;
  FPainter.HCanvasHandle:=FHPainterPanel.GetDeviceContext(H);
  H:=FVPainterPanel.Handle;
  FPainter.VCanvasHandle:=FVPainterPanel.GetDeviceContext(H);
{$R+}
  except
    raise
  end;

  if FPainter.ViewU=nil then Exit;
  if FWaitForTimer then Exit;

  FWaitForTimer:=True;
  Timer1.Enabled:=True;

  if FPainter.QueryInterface(IPainter3, Painter3)=0 then begin
    OldCanvasSet:=Painter3.CanvasSet;

    if ((FRefreshFlagSet and rfFront)<>0) or
       (not FastDrawEnabled) then begin
      FHPainterPanel.Repaint;
      FVPainterPanel.Repaint;

      Painter3.CanvasSet:=FrontCanvas;
      try
        DoPaint;
      finally
        Painter3.CanvasSet:=OldCanvasSet;
      end;
    end else
    if (FRefreshFlagSet and rfFast)<>0 then begin
      FHPainterPanel.Repaint;
      FVPainterPanel.Repaint;
      Painter3.FastDraw;
    end;

    if ((FRefreshFlagSet and rfBack)<>0) and
       FastDrawEnabled then begin
      Painter3.CanvasSet:=BackCanvas2;
      try
        DoPaint;
        Painter3.FlipBackCanvas;
      finally
        Painter3.CanvasSet:=OldCanvasSet;
      end;
    end;

  end else
    DoPaint;

end;

procedure TDMDraw.DoPaint;
var
  i,j, DrawSelected: integer;
  aDataModel:IDataModel;
  aDataModelE, Element:IDMElement;
  DMDocument:IDMDocument;
  SMDocument:ISMDocument;
  ImageRect:IImageRect;
  SpatialModel3:ISpatialModel3;
begin
  FPaintFlag:=True;
  try
  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;

  FPainter.Clear;

  if FSpatialModel.QueryInterface(ISpatialModel3, SpatialModel3)=0 then begin
    SpatialModel3.DrawThreadTerminated:=False;
    SpatialModel3.DrawThreadFinished:=False;
  end;

  for j:=0 to DMDocument.SelectionCount-1 do begin
    if SpatialModel3.DrawThreadTerminated then Exit;

    Element:=DMDocument.SelectionItem[j] as IDMElement;
    if Element.QueryInterface(IImageRect, ImageRect)=0 then begin
      if (Element.Ref<>nil) and
         (Element.Ref.SpatialElement=Element) then
        Element.Ref.Draw(FPainter, 1)
      else
        Element.Draw(FPainter, 1);
    end;
  end;

  for i:=0 to FDataModels.Count-1 do begin
    if SpatialModel3.DrawThreadTerminated then Exit;

    aDataModel:=IDataModel(FDataModels[i]);
    aDataModelE:=aDataModel as IDMElement;
    if aDataModelE.Selected then
      DrawSelected:=1
    else
      DrawSelected:=0;
    aDataModelE.Draw(FPainter, DrawSelected);
  end;

  for j:=0 to DMDocument.SelectionCount-1 do begin
    if SpatialModel3.DrawThreadTerminated then Exit;

    Element:=DMDocument.SelectionItem[j] as IDMElement;
    if Element.QueryInterface(IImageRect, ImageRect)<>0 then begin
      if (Element.Ref<>nil) and
         (Element.Ref.SpatialElement=Element) then
        Element.Ref.Draw(FPainter, 1)
      else
        Element.Draw(FPainter, 1);
    end;
  end;

  SpatialModel3.DrawThreadFinished:=True;

  SMDocument:=DMDocument as ISMDocument;
  if SMDocument.ShowAxesMode then
     SMDocument.ShowAxes;
  finally
    FPaintFlag:=False;
  end;
end;

procedure TDMDraw.CallRefresh(FlagSet:integer);
var
  Server:IDataModelServer;
begin
  if FChangingView then Exit;
  FChangingView:=True;
  Server:=Get_DataModelServer as IDataModelServer;
  try
  Server.RefreshDocument(FlagSet);   //  Repaint;
  finally
    CheckDocumentState;
    FChangingView:=False;
  end;
end;

procedure TDMDraw.OnChangeView;
var
  DMDocument:IDMDocument;
  OldState:integer;
  View:IView;
  aDataModel:IDataModel;
begin
  if FPainter.ViewU=nil then Exit;
  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  aDataModel:=GetDataModel;
  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting;

  FChangingView:=True;
  try
  try
  View:=FPainter.ViewU as IView;
  with View do begin
     edZ.Text:=Format('%0.2f',[CurrZ0/100]);
     edZAngle.Text:=Format('%0.0f',[ZAngle]);
     edDmin.Text:=Format('%-1.2f',[Dmin/100]);
     edDmax.Text:=Format('%-1.2f',[Dmax/100]);
     edZmin.Text:=Format('%-1.2f',[Zmin/100]);
     edZmax.Text:=Format('%-1.2f',[Zmax/100]);
     edScale.Text:=IntToStr(round(RevScale*30));
  end;
  FPainter.SetRangePix;
  FPainter.SetLimits;
  SetHRangeMarks;
  SetVRangeMarks;
  finally
    aDataModel.State:=OldState;
  end;

  FCursorType:=0;
  if Assigned(FOnUpdateViewList) then
   FOnUpdateViewList(Self);
  finally
    FChangingView:=False;
  end;
end;

procedure TDMDraw.CoolBar1DockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept:=Source.Control is TToolBar;
end;

procedure TDMDraw.ControlBar1DockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept:=Source.Control is TToolBar;
end;


procedure TDMDraw.tbShowAxesClick(Sender: TObject);
var
  SMDocument:ISMDocument;
begin
  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  SMDocument.ShowAxesMode:=TToolButton(Sender).Down;
  SMDocument.ShowAxes;
end;

procedure TDMDraw.DoCreateView(const S:string);
var
  SpatialModel2:ISpatialModel2;
  aDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  ViewE:IDMElement;
  View:IView;
  ViewU:IUnknown;
begin
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  DMOperationManager:=aDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsCreateView);

  DMOperationManager.AddElement( nil,
                    SpatialModel2.Views, '', ltOneToMany, ViewU, True);
  ViewE:=ViewU as IDMElement;

  ViewE.Name:=S;
  View:=ViewE as IView;
  View.Duplicate(FPainter.ViewU as IView);
  View.StoredParam:=7;
  SetViews;                   //таб.видов

  if Assigned(FOnUpdateViewList) then
     FOnUpdateViewList(Self);
//  CallRefresh(rfFast);
end;

procedure TDMDraw.tbAddViewClck(Sender: TObject);
var
  S:string;
  SpatialModel2:ISpatialModel2;
  aDocument:IDMDocument;
  KeyboardState:TKeyboardState;
  FormID:integer;
begin
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  S:=rsView+' #'+
     IntToStr(SpatialModel2.Views.Count);
  DM_GetKeyboardLayoutName(FOldLayoutName);
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDocument.State and dmfDemo)<>0 then begin
    DM_LoadKeyboardLayout('00000419',  //Russion
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

    DM_GetKeyboardState(KeyboardState);
    KeyboardState[VK_CAPITAL]:=0;
    DM_SetKeyboardState(KeyboardState);
  end;

  if InputQuery(rsSaveViewCaption, rsSaveViewPrompt, S)
     and (length(trim(S))>0) then begin
    S:=trim(S);
{$IFDEF Demo}
    FormID:=Get_FormID;
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrChangePrevRecord,
                -1, -1, -1, -1, 500, '');
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
                -1, -1, meKeyDown, -1, -1, S);
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
                FormID, -1, SaveViewDialogEventId, -1, -1, S);
{$ENDIF}
    DoCreateView(S);
  end;
  CallRefresh(rfFast);
  if (aDocument.State and dmfDemo)<>0 then begin
    DM_LoadKeyboardLayout(FOldLayoutName,
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;
end;

procedure TDMDraw.SetViews;     //таб.видов
var
  i:integer;
  ViewE:IDMElement;
  aView:IView;
  ParamViews:integer;
   ParamZ:string;
   ParamScale:string;
   ParamAngle:string;

  procedure Get_ViewsParam;
  begin
   case ParamViews of
     0:begin ParamZ:='-';
        ParamScale:='-';
        ParamAngle:='-' end ;
     1:begin ParamZ:='+';
        ParamScale:='-';
        ParamAngle:='-' end ;
     2:begin ParamZ:='-';
        ParamScale:='+';
        ParamAngle:='-' end ;
     3:begin ParamZ:='+';
        ParamScale:='+';
        ParamAngle:='-' end ;
     4:begin ParamZ:='-';
        ParamScale:='-';
        ParamAngle:='+' end ;
     5:begin ParamZ:='+';
        ParamScale:='-';
        ParamAngle:='+' end ;
     6:begin ParamZ:='-';
        ParamScale:='+';
        ParamAngle:='+' end ;
     7:begin ParamZ:='+';
        ParamScale:='+';
        ParamAngle:='+' end;
   else
     begin ParamZ:='-';
        ParamScale:='-';
        ParamAngle:='-' end ;
   end;
  end;

var
  SpatialModel2:ISpatialModel2;
  OldRow, OldCol:integer;
begin
  sgViews.Options:=sgViews.Options - [goAlwaysShowEditor];
  sgViews.Options:=sgViews.Options - [goEditing];
  OldRow:=sgViews.Row;
  OldCol:=sgViews.Col;
  sgViews.RowCount:=2;
  
  if FSpatialModel=nil then Exit;
  if FSpatialModel.QueryInterface(ISpatialModel2, SpatialModel2)<>0 then Exit;

  if(SpatialModel2.Views.Count>1) then begin
   for i:=1 to SpatialModel2.Views.Count-1 do begin
    ViewE:=SpatialModel2.Views.Item[i];
    aView:=(ViewE as IView);
    ParamViews:=aView.StoredParam;
    Get_ViewsParam;
    if i>1 then
      sgViews.RowCount:=sgViews.RowCount+1;
      sgViews.Cells[0,i] := IntToStr(i);
      sgViews.Cells[1,i] := ViewE.Name;
      sgViews.Cells[2,i] :=ParamZ;
      sgViews.Cells[3,i] :=ParamScale;
      sgViews.Cells[4,i] :=ParamAngle; end
   end
  else begin
    sgViews.Cells[0,1] := IntToStr(0);
    sgViews.Cells[1,1] := '"Вид по умолчанию"';
    sgViews.Cells[2,1] :='+';
    sgViews.Cells[3,1] :='+';
    sgViews.Cells[4,1] :='+';
  end;
  if OldCol<sgViews.ColCount then
    sgViews.Col:=OldCol;
  if OldRow<sgViews.RowCount then
    sgViews.Row:=OldRow;
end;

procedure TDMDraw.SetLayers;
var
  i, k:integer;
  LayerE:IDMElement;
  Layer:ILayer;
begin
  sgLayers.Options:=sgLayers.Options - [goAlwaysShowEditor];
  sgLayers.Options:=sgLayers.Options - [goEditing];
  cb_SelectLayer.Items.Clear;

  sgLayers.RowCount := FSpatialModel.Layers.Count+1;
  for i:=0 to FSpatialModel.Layers.Count-1 do begin
    LayerE:=FSpatialModel.Layers.Item[i];

    cb_SelectLayer.Items.AddObject(LayerE.Name, pointer(LayerE));

    Layer:=LayerE as ILayer;
    k:=i+1;
    sgLayers.Cells[0,k] := IntToStr(k);
    sgLayers.Objects[0,k] := pointer(LayerE);
    sgLayers.Cells[1,k] := LayerE.Name;
    if Layer.Visible then
       sgLayers.Cells[2,k]:='+'
    else
       sgLayers.Cells[2,k]:='-';

    if Layer.Selectable then
       sgLayers.Cells[3,k]:='+'
    else
       sgLayers.Cells[3,k]:='-';

    sgLayers.Cells[6,k]:=IntToStr(Layer.LineWidth);

    if LayerE.Ref=nil then
     sgLayers.Cells[7,k]:=''
    else
     sgLayers.Cells[7,k]:=LayerE.Ref.Name

  end;
  sgLayers.Invalidate;
end;

procedure TDMDraw.Set_SpatialModel(const Value: ISpatialModel);
var
  DataModel:IDataModel;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  SpatialModel2:ISpatialModel2;
begin
  DataModel:=FSpatialModel as IDataModel;
  if FDataModels.IndexOf(pointer(DataModel))<>-1 then
     FDataModels.Remove(pointer(DataModel));
  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  SMOperationManager:=SMDocument as ISMOperationManager;
  FSpatialModel:=Value;
  DataModel:=Value as IDataModel;
  SpatialModel2:=FSpatialModel as ISpatialModel2;

  if FDataModels.IndexOf(pointer(DataModel))=-1 then
     FDataModels.Add(pointer(DataModel));

  if SpatialModel2.Views.Count>0 then begin
    FPainter.ViewU:=SpatialModel2.Views.Item[0];
    SMDocument.SaveView(FPainter.ViewU as IView);
  end;

  SetLayers;

  if Assigned(FOnUpdateViewList) then
     FOnUpdateViewList(Self);

  if not (SMOperationManager.OperationCode in [
               smoSelectAll,
               smoSelectLine,
               smoSelectVerticalLine,
               smoSelectClosedPolyLine,
               smoSelectImage,
               smoSelectLabel,
               smoSelectCoordNode,
               smoSelectVerticalArea,
               smoSelectVolume]) then
    SMOperationManager.StopOperation(sProgram);

  SetRangeEditors;

  SetViews;

  chbChangeLengthDirection.ItemIndex:=SpatialModel2.ChangeLengthDirection;
  chbChangeWidthDirection.ItemIndex:=SpatialModel2.ChangeLengthDirection;
end;

procedure TDMDraw.edZangleChange(Sender: TObject);
var
 C:integer;
 Z:double;
 i:integer;
 ImageRectE:IDMElement;
 View:IView;
begin
  if FChangingView then Exit;
  if not edZAngle.Modified then Exit;
  if FPainter.ViewU=nil then Exit;
  Val(edZAngle.Text,Z,C);
  if C<>0 then begin
    edZAngle.Font.Color:=clRed;
    Exit;
  end else
    edZAngle.Font.Color:=clWindowText;
  View:=FPainter.ViewU as IView;
  View.Zangle:=Z;
  (FSpatialModel as ISpatialModel2).AreasOrdered:=False;
  if Z=0 then begin
    LDMax.Caption:='Ymax, м';
    LDMin.Caption:='Ymin, м'
  end else begin
    LDMax.Caption:='Dmax, м';
    LDMin.Caption:='Dmin, м'
  end;
  for i:=0 to FSpatialModel.ImageRects.Count-1 do begin
    ImageRectE:=FSpatialModel.ImageRects.Item[i];
    if (ImageRectE.Parent<>nil) and
       (ImageRectE as ISpatialElement).Layer.Visible then
    (ImageRectE as IImageRect).RotatePicture
           (View.ZAngle-(ImageRectE as IImageRect).Angle);
  end;
  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.sbScaleUpClick(Sender: TObject);
var
  View:IView;
begin
  if FChangingView then Exit;
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
{$IFDEF Demo}
  WriteSpeedButtonUpMacros(Sender);
{$ENDIF}
  View.RevScale:=View.RevScale*2;
  FChangingView:=True;
  edScale.Text:=IntToStr(round(View.RevScale*30));
  FChangingView:=False;

  CallRefresh(rfFrontBack);

end;

procedure TDMDraw.sbScaleDownClick(Sender: TObject);
var
  D:double;
  View:IView;
begin
  if FChangingView then Exit;
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
{$IFDEF Demo}
  WriteSpeedButtonDownMacros(Sender);
{$ENDIF}
  D:=View.RevScale/2;
  if D<1 then D:=1;
  View.RevScale:=D;
  FChangingView:=True;
  edScale.Text:=IntToStr(round(View.RevScale*30));
  FChangingView:=False;

  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.edScaleChange(Sender: TObject);
var
  D:double;
  Err:integer;
  View:IView;
begin
  if FChangingView then Exit;
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if Err<>0 then
    edScale.Font.Color:=clRed
  else begin
    if D<1 then  begin
      D:=1;
      edScale.Text:='1';
    end;
    D:=D/30;
    edScale.Font.Color:=clBlack;
    View.RevScale:=D;
    CallRefresh(rfFrontBack);
  end;
end;

procedure TDMDraw.cbViewsChange(Sender: TObject);
var
  SpatialModel2:ISpatialModel2;
  View:IView;
begin
  if FChangingView then Exit;
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  if TComboBox(Sender).ItemIndex>0 then begin
    with SpatialModel2.Views.Item[TComboBox(Sender).ItemIndex] as IView do begin
      View.CX:=CX;
      View.CY:=CY;
      View.CZ:=CZ;
      View.RevScale:=RevScale;
      View.Zangle:=Zangle;
      View.Zmin:=Zmin;
      View.Zmax:=Zmax;
      View.Dmin:=Dmin;
      View.Dmax:=Dmax;
      SpatialModel2.AreasOrdered:=False;

      if Assigned(FOnUpdateViewList) then
         FOnUpdateViewList(Self);
    end;
    FPainter.SetRangePix;
    SetHRangeMarks;
    SetVRangeMarks;
    SetRangeEditors;
    CallRefresh(rfFrontBack);
  end;
end;

procedure FindAndClick(ToolBar:TToolBar; ToolButton:TComponent);
var j:integer;
begin
  j:=0;
  while (j<ToolBar.ButtonCount) and
        (ToolBar.Buttons[j].Tag<>ToolButton.Tag)do
    inc(j);
  if j<ToolBar.ButtonCount then begin
    if ToolButton is TMenuItem then
      ToolBar.Buttons[j].Down:=(ToolButton as TMenuItem).Checked
    else
      ToolBar.Buttons[j].Down:=(ToolButton as TToolButton).Down;
  end;
end;

procedure TDMDraw.PrintPainterPanel;
var
  HBMP:HBITMAP;
  PanelDC:HDC;
  aBitmap:TBitmap;
  aPrinter:TPrinter;
  R:TRect;
  XC, YC, W, H:integer;
  aPainterPanel:TPainterPanel;
begin
  aPainterPanel := FHPainterPanel;
  PanelDC:=FHPainterPanel.Canvas.Handle;
  if PanelDC=0 then Exit;
  HBMP:=CopyBits(PanelDC, aPainterPanel.Width, aPainterPanel.Height);
  try
    if HBMP = 0 then
      GDIError
     else begin
       aBitmap:=TBitmap.Create;
      try
        aBitmap.LoadFromClipboardFormat(CF_BITMAP, HBMP, 0);
        aBitmap.SaveToFile('Test.bmp');

        aPrinter:=Printer;
        aPrinter.BeginDoc;
          XC:=aPrinter.PageWidth div 2;
          YC:=aPrinter.PageHeight div 2;
          W:=round(aPrinter.PageWidth*0.9);
          H:=round(aPrinter.PageHeight/aPrinter.PageWidth*aBitmap.Width);
          if H>round(aPrinter.PageHeight*0.9) then begin
            H:=round(aPrinter.PageHeight*0.9);
            W:=round(aPrinter.PageWidth/aPrinter.PageHeight*aBitmap.Height);
          end;
          R.Top:=YC-(H div 2);
          R.Left:=XC-(W div 2);
          R.Bottom:=YC+(H div 2);
          R.Right:=XC+(W div 2);
          aPrinter.Canvas.StretchDraw(R, aBitmap);
        aPrinter.EndDoc;

      finally
        aBitmap.Free;
      end;
    end
  finally
    DM_DeleteObject(HBMP);
  end;
end;

procedure TDMDraw.edXYZKeyPress(Sender: TObject; var Key: Char);
var
(*
  D:double;
  Err:integer;
  S:string;
  PX, PY, PZ:double;
  SMDocument:ISMDocument;
*)  
  aKey:word;
begin
  if Key=',' then
    Key:='.';

  if Key<>#13 then Exit;
  aKey:=VK_F4;
  edXYZKeyDown(Sender, aKey, []);
(*
  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as ISMDocument;

  Val(TEdit(Sender).Text, D, Err);
  with SMDocument do begin
    if Err<>0 then begin
      case TEdit(Sender).Tag of
      1: Str((CurrX/100):1:2,S);
      2: Str((CurrY/100):1:2,S);
      3: Str((CurrZ/100):1:2,S);
      end;
      TEdit(Sender).Text:=S;
    end;

//    ShowAxes;

    PX:=CurrX;
    PY:=CurrY;
    PZ:=CurrZ;
    case TEdit(Sender).Tag of
    1: PX:=D*100;
    2: PY:=D*100;
    3: PZ:=D*100;
    end;

    SetCurrXYZ(PX, PY, PZ);

  end;
*)  
end;

procedure TDMDraw.PainterPanelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  XM, YM, ZM, SX, SY:integer;
  SMDocument:ISMDocument;
  D, FormID:integer;
  aPanel:TPainterPanel;
  P:TPoint;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;

{$IFDEF Demo}
  if (FLastKey<>Key) then begin
    FormID:=Get_FormID;
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -1, meKeyDown, Key, -1, '');
  end;
{$ENDIF}
  FLastKey:=Key;

  if Shift=[ssShift] then
    D:=1
  else
    D:=8;

  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  XM:=SMDocument.CurrPX;
  YM:=SMDocument.CurrPY;
  ZM:=SMDocument.CurrPZ;

  if SMDocument.HWindowFocused then
    case Key of
    VK_UP:   YM:=YM-D;
    VK_DOWN: YM:=YM+D;
    VK_LEFT: XM:=XM-D;
    VK_RIGHT:XM:=XM+D;
    end
  else
  if SMDocument.VWindowFocused then
    case Key of
    VK_UP:   ZM:=ZM-D;
    VK_DOWN: ZM:=ZM+D;
    VK_LEFT: XM:=XM-D;
    VK_RIGHT:XM:=XM+D;
    end;

  case Key of
  VK_BACK:
    if Shift=[ssAlt] then
      (SMDocument as IDMOperationManager).Undo;
  VK_DELETE:
      (SMDocument as ISMOperationManager).StartOperation(smoDeleteSelected);
  VK_F4:
    begin
      if PageControl.ActivePage<>tsXYZ then
        PageControl.ActivePage:=tsXYZ;
      edX.SetFocus;
      FHPainterPanel.OnMouseDown:=nil;
      FHPainterPanel.OnMouseMove:=nil;
      FVPainterPanel.OnMouseDown:=nil;
      FVPainterPanel.OnMouseMove:=nil;
      if SMDocument.HWindowFocused then begin
        View.CurrX0:=SMDocument.CurrX;
        View.CurrY0:=SMDocument.CurrY;
      end else
      if SMDocument.VWindowFocused then
        View.CurrZ0:=SMDocument.CurrZ;
    end;
  VK_F7:
      if PageControl.ActivePage<>tsViews then
        PageControl.ActivePage:=tsViews;
  VK_F8:
      if PageControl.ActivePage<>tsLayers then
        PageControl.ActivePage:=tsLayers;
  VK_F11:
      if PageControl.ActivePage<>tsProperties then
        PageControl.ActivePage:=tsProperties;
  VK_UP,
  VK_DOWN,
  VK_LEFT,
  VK_RIGHT:
    begin
      if SMDocument.HWindowFocused then begin
        aPanel:=FHPainterPanel;
        P:=aPanel.ClientToScreen(Point(0,0));
        aPanel.Mouse_Move(aPanel, [], XM,YM);
        SX:=XM+P.X;
        SY:=YM+P.Y;
      end else begin
        aPanel:=FVPainterPanel;
        P:=aPanel.ClientToScreen(Point(0,0));
        aPanel.Mouse_Move(aPanel, [], XM,ZM);
        SX:=XM+P.X;
        SY:=ZM+P.Y;
      end;
     DM_SetCursorPos(SX, SY);
    end;
  VK_F5: SMDocument.MouseDown(sLeft);
  VK_F6: SMDocument.MouseDown(sRight);
  VK_ESCAPE: SMDocument.MouseDown(sProgram);
  90:  // Z
    if Shift=[ssShift, ssCtrl] then
      (SMDocument as IDMOperationManager).Redo;
  end;
end;

procedure TDMDraw.PainterPanelKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  FormID:integer;
begin
  case Key of
  VK_Shift, VK_Control, VK_MENU:
    begin
      FLastKey:=0;
{$IFDEF Demo}
      FormID:=Get_FormID;
      (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -1, meKeyUp, Key, -1, '');
{$ENDIF}
    end;
  end;            
end;

procedure TDMDraw.miKeyClick(Sender: TObject);
var
  XM, YM, ZM, SX, SY:integer;
  SMDocument:ISMDocument;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  XM:=SMDocument.CurrPX;
  YM:=SMDocument.CurrPY;
  ZM:=SMDocument.CurrPZ;

  if SMDocument.HWindowFocused then
    case -TMenuItem(Sender).Tag of
    2:YM:=YM-8;
    3:YM:=YM+8;
    4:XM:=XM-8;
    5:XM:=XM+8;
    6:YM:=YM-1;
    7:YM:=YM+1;
    8:XM:=XM-1;
    9:XM:=XM+1;
    end
  else
  if SMDocument.VWindowFocused then
    case -TMenuItem(Sender).Tag of
    2:ZM:=ZM-8;
    3:ZM:=ZM+8;
    4:XM:=XM-8;
    5:XM:=XM+8;
    6:ZM:=ZM-1;
    7:ZM:=ZM+1;
    8:XM:=XM-1;
    9:XM:=XM+1;
  end;

  case -TMenuItem(Sender).Tag of
  1..9:
    if PageControl.ActivePage<>tsXYZ then
      PageControl.ActivePage:=tsXYZ;
  end;


  case -TMenuItem(Sender).Tag of
  1:begin
      edX.SetFocus;
      FHPainterPanel.OnMouseDown:=nil;
      FHPainterPanel.OnMouseMove:=nil;
      FVPainterPanel.OnMouseDown:=nil;
      FVPainterPanel.OnMouseMove:=nil;
      View.CurrX0:=SMDocument.CurrX;
      if SMDocument.HWindowFocused then begin
        View.CurrY0:=SMDocument.CurrY;
      end else
      if SMDocument.VWindowFocused then
        View.CurrZ0:=SMDocument.CurrZ;
    end;
  2..9:begin
       SMDocument.MouseMove(0, XM, YM, 1);
       SMDocument.MouseMove(0, XM, ZM, 2);
       SX:=XM+Left;
       SY:=YM+Top;
       DM_SetCursorPos(SX, SY);
      end;
  10: SMDocument.MouseDown(sLeft);
  11: SMDocument.MouseDown(sRight);
  end;
end;

procedure TDMDraw.DoCreateLayer(const S:string);
var
  LayerE:IDMElement;
  LayerU, SpatialElementU:IUnknown;
  Server:IDataModelServer;
  DMOperationManager:IDMOperationManager;
  aDocument:IDMDocument;
  j:integer;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=Server.CurrentDocument;

  DMOperationManager:=aDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsCreateLayer);
  DMOperationManager.AddElement( nil,
                      FSpatialModel.Layers, '', ltOneToMany, LayerU, True);
  LayerE:=LayerU as IDMElement;
  LayerE.Name:=S;

  if (aDocument.SelectionCount>0) and
     (aDocument.SelectionItem[0].QueryInterface(ISpatialElement, SpatialElementU)=0) then begin
    DMOperationManager.StartTransaction(nil, leoAdd, rsChangeLayer);
    for j:=0 to aDocument.SelectionCount-1 do begin
      SpatialElementU:=aDocument.SelectionItem[j];
      DMOperationManager.ChangeParent(nil, LayerU, SpatialElementU);
    end
  end else
    FSpatialModel.CurrentLayer:=LayerE as ILayer;

  Server.DocumentOperation(LayerE, nil, leoAdd, 0);
end;

procedure TDMDraw.CreateLayer(Sender: TObject);
var
  S:string;
  aDocument:IDMDocument;
  Server:IDataModelServer;
  KeyboardState:TKeyboardState;
  FormID:integer;
begin
  S:=FSpatialModel.Layers.ClassAlias[akImenit]+' #'+IntToStr(FSpatialModel.Layers.Count);
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=Server.CurrentDocument;
  if (aDocument.State and dmfDemo)<>0 then begin
    DM_GetKeyboardLayoutName(FOldLayoutName);
    DM_LoadKeyboardLayout('00000419',  //Russion
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

    DM_GetKeyboardState(KeyboardState);
    KeyboardState[VK_CAPITAL]:=0;
    DM_SetKeyboardState(KeyboardState);
  end;

  if InputQuery(rsCreateLayerCaption, rsCreateLayerPrompt, S) and
     (length(trim(S))>0) then begin

{$IFDEF Demo}
   FormID:=Get_FormID;
   (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrChangePrevRecord,
                -1, -1, -1, -1, 500, '');
   (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
                -1, -1, meKeyDown, -1, -1, S);
   (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
                FormID, -1, CreateLayerDialogEventId, -1, -1, S);
{$ENDIF}
   S:=Trim(S);
   DoCreateLayer(S);
  end;
  CallRefresh(rfFast);
  if (aDocument.State and dmfDemo)<>0 then begin
    DM_LoadKeyboardLayout(FOldLayoutName,
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;
end;

procedure TDMDraw.DeleteLayer(Sender: TObject);
var
  DMOperationManager:IDMOperationManager;
  SMDocument:ISMDocument;
  Server:IDataModelServer;
  LayerE:IDMElement;
  j:integer;
  begin
   j:=sgLayers.Row-1;
   if j=-1 then Exit;
   LayerE:=FSpatialModel.Layers.Item[j];

   Server:=Get_DataModelServer as IDataModelServer;
   DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
   SMDocument:=DMOperationManager as ISMDocument;
   DMOperationManager.StartTransaction(nil, leoDelete, rsDeleteLayer);

   if FSpatialModel.CurrentLayer=LayerE as ILayer then
     FSpatialModel.CurrentLayer:=FSpatialModel.Layers.Item[0] as ILayer;

   LayerE.ClearOp;
   DMOperationManager.DeleteElement( nil, nil, ltOneToMany, LayerE);
   Server.DocumentOperation(LayerE, nil, leoDelete, 0);
   FormPaint(Sender);
end;

procedure TDMDraw.PanelLayerStyleClick(Sender: TObject);
{
var
 aDocument:IDMDocument;
 aCount:integer;
 aElement:IDMElement;
 aElement0S:ISpatialElement;
 aElement0L:ILine;
 j:integer;
}
begin
{
  FPanelLayerStyle.BevelOuter:=bvRaised;

  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  aCount:= aDocument.SelectionCount;

  for j:=0 to aCount-1 do begin
   aElement:=aDocument.SelectionItem[j] as IDMElement;
   if aElement.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
   if(GetKeyState(VK_CONTROL)<0) then begin
    FPanelLayerStyle.Style := -1;
    FPanelLayerStyle.Color:=clSilver; end
   else begin
    if (FPanelLayerStyle.Style>3) then
     FPanelLayerStyle.Style:=0
    else FPanelLayerStyle.Style:=FPanelLayerStyle.Style+1;
//________
    if aElement.QueryInterface(ILine, aElement0L)=0 then
     if (FPanelLayerStyle.Style<>-2)
         and(FPanelLayerStyle.Style<>-1) then
      aElement0L.Style:=FPanelLayerStyle.Style;
   end;
//________
  end;
  FPanelLayerStyle.Paint;
}
end;

procedure TDMDraw.PanelLayerStyleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  FPanelLayerStyle.BevelOuter:=bvLowered;
end;

//>>>>>>>>>>>>>>>>>>>>>>>          >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

procedure TDMDraw.edXYZEnter(Sender: TObject);
var
  KeyboardState:TKeyboardState;
  Server:IDataModelServer;
  aDocument:IDMDocument;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=Server.CurrentDocument;
  if (aDocument.State and dmfDemo)<>0 then begin
    DM_GetKeyboardLayoutName(FOldLayoutName);
    DM_LoadKeyboardLayout('00000409',    //English
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

    DM_GetKeyboardState(KeyboardState);
    KeyboardState[VK_CAPITAL]:=0;
    DM_SetKeyboardState(KeyboardState);
  end;

  FHPainterPanel.OnMouseDown:=nil;
  FHPainterPanel.OnMouseMove:=nil;
  FVPainterPanel.OnMouseDown:=nil;
  FVPainterPanel.OnMouseMove:=nil;
end;

procedure TDMDraw.edXYZExit(Sender: TObject);
var
  Server:IDataModelServer;
  aDocument:IDMDocument;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=Server.CurrentDocument;
  if (aDocument.State and dmfDemo)<>0 then begin
    DM_LoadKeyboardLayout(FOldLayoutName,
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;
  FHPainterPanel.OnMouseDown:=FHPainterPanel.Mouse_Down;
  FHPainterPanel.OnMouseMove:=FHPainterPanel.Mouse_Move;
  FVPainterPanel.OnMouseDown:=FVPainterPanel.Mouse_Down;
  FVPainterPanel.OnMouseMove:=FVPainterPanel.Mouse_Move;
end;

procedure TDMDraw.WMChangeSelection(var Message: TMessage);
begin
  OnChangeSelection;
end;

procedure TDMDraw.WMDragLine(var Message: TMessage);
var
  L, A:double;
begin
  L:=Message.WParam;
  A:=Message.LParam;
  OnDragLine(L, A);
end;

procedure TDMDraw.Set_ParamVisionSelection(Control: integer);
begin
//*********************************
  Case Control of
    0: begin
        pn_ObjectName.Visible :=False;
        pn_Param.Visible :=False;
        pn_PointParam.Visible :=False;
        pn_LineParam.Visible  :=False;
        pn_ImageRectParam.Visible:=False;
        pn_AreaParam.Visible  :=False;
        pn_VolumeParam.Visible:=False;
        pn_LabelParam.Visible:=False;
       end;
    _CoordNode:begin
       pn_PointParam.Visible :=True;
       pn_Param.Visible :=True;
       pn_ObjectName.Visible :=True;
       pn_LineParam.Visible  :=False;
       pn_ImageRectParam.Visible:=False;
       pn_AreaParam.Visible  :=False;
       pn_VolumeParam.Visible:=False;
       pn_LabelParam.Visible:=False;
      end;
    _Line:begin
       pn_Param.Visible :=True;
       pn_ObjectName.Visible :=True;
       pn_LineParam.Visible  :=True;
       pn_ImageRectParam.Visible:=False;
       pn_PointParam.Visible :=False;
       pn_AreaParam.Visible  :=False;
       pn_VolumeParam.Visible:=False;
       pn_LabelParam.Visible:=False;
      end;
    _ImageRect:begin
       pn_Param.Visible :=True;
       pn_ObjectName.Visible :=True;
       pn_LineParam.Visible  :=False;
       pn_ImageRectParam.Visible:=True;
       pn_PointParam.Visible :=False;
       pn_AreaParam.Visible  :=False;
       pn_VolumeParam.Visible:=False;
       pn_LabelParam.Visible:=False;
      end;
    _Polyline,
    _LineGroup:begin
       pn_ObjectName.Visible :=True;
       pn_Param.Visible :=True;
       pn_AreaParam.Visible  :=False;
       pn_PointParam.Visible :=False;
       pn_LineParam.Visible  :=False;
       pn_ImageRectParam.Visible:=False;
       pn_VolumeParam.Visible:=False;
       pn_LabelParam.Visible:=False;
      end;
    _Area:begin
       pn_ObjectName.Visible :=True;
       pn_AreaParam.Visible  :=True;
       pn_Param.Visible :=True;
       pn_PointParam.Visible :=False;
       pn_ImageRectParam.Visible:=False;
       pn_ImageRectParam.Visible  :=True;
       pn_VolumeParam.Visible:=False;
       pn_LabelParam.Visible:=False;
      end;
    _SMLabel:begin
       pn_PointParam.Visible :=False;
       pn_Param.Visible :=True;
       pn_ObjectName.Visible :=True;
       pn_LineParam.Visible  :=False;
       pn_ImageRectParam.Visible:=False;
       pn_AreaParam.Visible  :=False;
       pn_VolumeParam.Visible:=False;
       pn_LabelParam.Visible:=True;
      end;
    _Volume:begin
       pn_VolumeParam.Visible:=True;
       pn_Param.Visible :=True;
       pn_ObjectName.Visible :=True;
       pn_PointParam.Visible :=False;
       pn_LineParam.Visible  :=False;
       pn_ImageRectParam.Visible:=False;
       pn_AreaParam.Visible  :=False;
       pn_LabelParam.Visible:=False;
      end;
   else
  end;
end;

// 9.4.02  new ___________________________
procedure TDMDraw.OnChangeSelection;
var
 aDocument:IDMDocument;
 aElement0, aElementC, aParent, aVolumeE:IDMElement;
 aElement0S:ISpatialElement;
 aNode:ICoordNode;
 aElement0L, aLine:ILine;
 aArea:IArea;
 aVolume, aVolume0, aVolume1:IVolume;
 aLabel:ISMLabel;

 j, k, m, m0:integer;
 aParents:array[0..100] of string;     // размерность ??
 aCount, aLayersCount, aClassID, aID:integer;
 aLayerName, bLayerName, aClassAlias:string;
 aX0, aY0, aZ0, aX1, aY1, aZ1, aMinZ, aMaxZ, aZAngle:Real;
 LSum, aAreaLength:double;
 aLabelName, S:string;
 Lines:IDMCollection;
 ImageRect, aImageRect:IImageRect;
begin
  try
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  aCount:= aDocument.SelectionCount;

  SetTransformButtons;

  if aCount=0 then begin
    Set_ParamVisionSelection(0);
    lb_Parents.Clear;
    Exit
  end;
//---------------
  aElement0:=aDocument.SelectionItem[0] as IDMElement;     // 1-й элемент
  if aElement0.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;

  FChangingSelection:=True; // ???????????

  m0:=cb_SelectLayer.Items.IndexOfObject(pointer(aElement0.Parent));
  cb_SelectLayer.ItemIndex:=m0;

  aClassID := aElement0.ClassID;
  aID := aElement0.ID;
  aLayersCount:=1;

  miCreateLink.Visible:=False;

  case aClassID of
  _CoordNode:aClassAlias:= 'Узел';
  _Area:     aClassAlias:= 'Плоская область';
  _Volume:   aClassAlias:= 'Объемная область';
  else
  aClassAlias := aElement0.OwnerCollection.ClassAlias[akImenit];
  end;

  if (aCount=1) then begin
   lb_ClassAlias.Caption:=aClassAlias+' ' + IntToStr(aID);
   if aElement0.Ref<>nil then
     lb_ClassAlias.Caption:=lb_ClassAlias.Caption+
                 ' ('+IntToStr(aElement0.Ref.ID)+')';
  end else
   lb_ClassAlias.Caption:=aClassAlias;

  aX0:=0;
  aY0:=0;
  aZ0:=0;
  aX1:=0;
  ay1:=0;
  aZ1:=0;
  aMinZ:=0;
  aMaxZ:=0;
  aAreaLength:=0;
  aZAngle:=0;

//_________________ узел
  if aElement0.QueryInterface(ICoordNode, aNode)=0 then begin
   aClassID:=_CoordNode;
   aX0 := aNode.X;
   ed_X.Text := Format('%0.2f',[aX0/100]);
   aY0 := aNode.Y;
   ed_Y.Text := Format('%0.2f',[aY0/100]);
   aZ0 := aNode.Z;
   ed_Z.Text := Format('%0.2f',[aZ0/100]);
   if (aCount>1) then
    lb_ID.Caption:='узел '+ IntToStr((aNode As IDMElement).ID)
   else
    lb_ID.Caption:='';
  end else
//_________________ растр
  if aElement0.QueryInterface(IImageRect, ImageRect)=0 then begin
    aElement0L:=ImageRect as ILine;
    if aElement0L.C0=nil then Exit;
    if aElement0L.C1=nil then Exit;
    aClassID:=_ImageRect;
    aX0 := aElement0L.C0.X;
    ed_IX0.Text := Format('%0.2f',[aX0/100]);
    aY0 := aElement0L.C0.Y;
    ed_IY0.Text := Format('%0.2f',[aY0/100]);
    aZ0 := aElement0L.C0.Z;
    ed_IZ0.Text := Format('%0.2f',[aZ0/100]);
    aElementC:=(aElement0L.C0 as IDMElement);
    lb_IID0.Caption:='узел '+ IntToStr(aElementC.ID);
    aX1 := aElement0L.C1.X;
    ed_IX1.Text := Format('%0.2f',[aX1/100]);
    aY1 := aElement0L.C1.Y;
    ed_IY1.Text := Format('%0.2f',[aY1/100]);
    aZ1 := aElement0L.C1.Z;
    ed_IZ1.Text := Format('%0.2f',[aZ1/100]);
    aElementC:=(aElement0L.C1 as IDMElement);
    lb_IID1.Caption:='узел '+ IntToStr(aElementC.ID);

    ed_Alpha.Text:=IntToStr(ImageRect.Alpha);

    aLayerName:=aElement0.Parent.Name;
    aParents[0]:=aLayerName;
  end else
//_________________ линия
  if aElement0.QueryInterface(ILine, aElement0L)=0 then begin
    if aElement0L.C0=nil then Exit;
    if aElement0L.C1=nil then Exit;
    aClassID:=_Line;
    aX0 := aElement0L.C0.X;
    ed_X0.Text := Format('%0.2f',[aX0/100]);
    aY0 := aElement0L.C0.Y;
    ed_Y0.Text := Format('%0.2f',[aY0/100]);
    aZ0 := aElement0L.C0.Z;
    ed_Z0.Text := Format('%0.2f',[aZ0/100]);
    aElementC:=(aElement0L.C0 as IDMElement);
    lb_ID0.Caption:='узел '+ IntToStr(aElementC.ID);
    aX1 := aElement0L.C1.X;
    ed_X1.Text := Format('%0.2f',[aX1/100]);
    aY1 := aElement0L.C1.Y;
    ed_Y1.Text := Format('%0.2f',[aY1/100]);
    aZ1 := aElement0L.C1.Z;
    ed_Z1.Text := Format('%0.2f',[aZ1/100]);
    aElementC:=(aElement0L.C1 as IDMElement);
    lb_ID1.Caption:='узел '+ IntToStr(aElementC.ID);

    LSum:=0;
    for j:=0 to aCount-1 do begin    // i-й элемент
      if aDocument.SelectionItem[j].QueryInterface(ILine, aLine)=0 then begin
        LSum:=LSum+aLine.Length;
      end;
    end;
    ed_Length.Text:=Format('%0.2f',[LSum/100]);

    aZAngle:=aElement0L.ZAngle;
    ed_ZAngle.Text:= Format('%0.2f',[aZAngle]);

    aLayerName:=aElement0.Parent.Name;
    aParents[0]:=aLayerName;
  end else
//_________________  область
  if aElement0.QueryInterface(IArea, aArea)=0 then begin
    aClassID:=_Area;
    aMinZ:=aArea.MinZ;
    ed_MinZ.Text := Format('%0.2f',[aMinZ/100]);
    aMaxZ:=aArea.MaxZ;
    ed_MaxZ.Text := Format('%0.2f',[aMaxZ/100]);
    if aArea.IsVertical then begin
      lb_BottomLinesCount.Caption :='линий: внизу -'+ IntToStr(aArea.BottomLines.Count);
      lb_TopLinesCount.Caption :='вверху -'+ IntToStr(aArea.TopLines.Count);
    end else begin
      lb_BottomLinesCount.Caption :='линий: '+ IntToStr(aArea.BottomLines.Count);
      lb_TopLinesCount.Caption :='';
    end;

    aVolume0:=aArea.Volume0;
    aVolume1:=aArea.Volume1;

    if aVolume0<>nil then
     lb_Volums.Caption := 'между объемами: '
            + IntToStr((aVolume0 as IDMElement).ID) + ' - '
    else
     lb_Volums.Caption := 'между объемами: <пусто> - ';

    if aVolume1<>nil then
     lb_Volums.Caption := lb_Volums.Caption
            + IntToStr((aVolume1 as IDMElement).ID)
    else
     lb_Volums.Caption := lb_Volums.Caption + '<пусто>';

   if not aArea.IsVertical then begin
     ed_AreaSize1.Visible:=False;
     lb_AreaSize1.Visible:=False;
   end else begin
     if aArea.BottomLines.Count>0 then
       Lines:=aArea.BottomLines
     else
       Lines:=aArea.TopLines;
     aAreaLength:=0;
     for m:=0 to Lines.Count-1 do begin
       aLine:=Lines.Item[m] as ILine;
       aAreaLength:=aAreaLength+aLine.Length;
     end;
     ed_AreaSize1.Text:=Format('%0.2f',[aAreaLength/100]);

     ed_AreaSize1.Visible:=True;
     lb_AreaSize1.Visible:=True;
     if (aArea.TopLines.Count=1)and(aArea.BottomLines.Count=1)then
       ed_AreaSize1.Enabled:=True
     else
       ed_AreaSize1.Enabled:=False;
   end;
  end else
//_________________ объем
  if aElement0.QueryInterface(IVolume, aVolume)=0 then begin
    miCreateLink.Visible:=True;
    aClassID:=_Volume;
    aMinZ:=aVolume.MinZ;
    ed_VolumeMinZ.Text := Format('%0.2f',[aMinZ/100]);
    aMaxZ:=aVolume.MaxZ;
    ed_VolumeMaxZ.Text := Format('%0.2f',[aMaxZ/100]);
    lb_Height.Caption :=Format('%0.2f',[(aMaxZ-aMinZ)/100]);
    lb_AreasCount.Caption :='плоскостей - '+  IntToStr(aVolume.Areas.Count);
    if aVolume.Areas.Count>0 then begin
      lb_TopAreasCount.Caption :='вверху - '+ IntToStr(aVolume.TopAreas.Count);
      lb_BottomAreasCount.Caption :='внизу - '+ IntToStr(aVolume.BottomAreas.Count);
    end else begin
      lb_TopAreasCount.Caption :='';
      lb_BottomAreasCount.Caption :='';
    end;
  end else {begin}
   //_________________ метка
  if aElement0.QueryInterface(ISMLabel, aLabel)=0 then begin
    aClassID:=_SMLabel;
    if aLabel<>nil then
     if (aCount>1) then begin
       lb_Label.Visible:=False;
       ed_Name.Visible:=False;
     end else begin
       lb_Label.Visible:=True;;
       ed_Name.Visible:=True;;
       lb_Label.Caption:='имя метки '+ IntToStr((aLabel As IDMElement).ID);
       aLabelName:=(aLabel As IDMElement).Name;
       ed_Name.Text:=aLabelName;
     end;
  end;

//________________________
  lb_Parents.Clear;
  if aCount=1 then begin
    case aClassID of
    2: ;
    3: ;
    6: aClassAlias:='Плоская область';
    8: aClassAlias:='Объемная область';
    end;
    lb_Parents.Tag:=0;
    lb_HeadParent.Caption:='Владельцы выделенного элемента';
    if aElement0.Parents<>nil then begin
      for k:=0 to aElement0.Parents.Count-1 do begin
       aParent:=aElement0.Parents.Item[k];
       lb_Parents.Items.AddObject(IntToStr(aParent.ID)+' :'
                           + aParent.Name, pointer(aParent))
      end;
    end else
    if aElement0.QueryInterface(IArea, aArea)=0 then begin
      lb_HeadParent.Caption:='Объемы, разделяемые плоскостью';
      if aArea.Volume0<>nil then begin
        aVolumeE:=aArea.Volume0 as IDMElement;
        S:=IntToStr(aVolumeE.ID)+' :'
                           + aVolumeE.Name;
        if aArea.Volume0IsOuter then
          S:=S+'. Внешний';
        lb_Parents.Items.AddObject(S, pointer(aVolumeE))
      end;
      if aArea.Volume1<>nil then begin
        aVolumeE:=aArea.Volume1 as IDMElement;
        S:=IntToStr(aVolumeE.ID)+' :'
                           + aVolumeE.Name;
        if aArea.Volume1IsOuter then
          S:=S+'. Внешний';
        lb_Parents.Items.AddObject(S, pointer(aVolumeE))
      end;
    end else
    if aElement0.QueryInterface(ICoordNode, aNode)=0 then begin
      lb_HeadParent.Caption:='Входящие линии';
      for k:=0 to aNode.Lines.Count-1 do begin
        aParent:=aNode.Lines.Item[k];
          lb_Parents.Items.AddObject(IntToStr(aParent.ID)+' :'
                         + aParent.Name, pointer(aParent));
      end;
    end else
    if aElement0.QueryInterface(IVolume, aVolume)=0 then begin
      lb_HeadParent.Caption:='Плоскости';
      for k:=0 to aVolume.Areas.Count-1 do begin
        aParent:=aVolume.Areas.Item[k];
          lb_Parents.Items.AddObject(IntToStr(aParent.ID)+' :'
                         + aParent.Name, pointer(aParent));
      end;
    end else
    if aElement0.QueryInterface(ISMLabel, aLabel)=0 then begin
     aParent:=aElement0.Ref;
     if aParent<>nil then
       lb_Parents.Items.AddObject(IntToStr(aParent.ID)+' :'
                           + aParent.Name, pointer(aParent))
    end;
  end else begin
    lb_HeadParent.Caption:='Выделенные элементы';
    lb_Parents.Items.AddObject(IntToStr(aElement0.ID)+' :'
                           + aElement0.Name, pointer(aElement0))
  end;
//________________________


  for j:=1 to aCount-1 do begin    // i-й элемент
    aElement0:=aDocument.SelectionItem[j] as IDMElement;
    if aElement0.QueryInterface(ISpatialElement, aElement0S)<>0 then  Exit;

    m:=cb_SelectLayer.Items.IndexOfObject(pointer(aElement0.Parent));
    if m<>m0 then
      cb_SelectLayer.ItemIndex:=-1;

//_________________ узел
    if aElement0.QueryInterface(ICoordNode, aNode)=0 then begin
      aClassID:=_CoordNode;
      if aNode.X<>aX0 then
        ed_X.Text := '';
      if aNode.Y<>aY0 then
       ed_Y.Text := '';
      if aNode.Z<>aZ0 then
       ed_Z.Text := '';

      if (aCount>1) then
       lb_ID.Caption:='узел '+ IntToStr((aNode As IDMElement).ID)
      else
       lb_ID.Caption:='';
    end else
    if aElement0.QueryInterface(IImageRect, aImageRect)=0 then begin
      aClassID:=_ImageRect;

      bLayerName:=aElement0.Parent.Name;
      aLayerName:='no';
      for  k:=0  to aLayersCount-1 do
        if bLayerName=aParents[k] then
          aLayerName:='yes';

        if aLayerName<>'yes' then begin
          aParents[aLayersCount]:=bLayerName;
          aLayersCount:=aLayersCount+1;
          cb_SelectLayer.Text:=''
        end;

        aElement0L:=ImageRect as ILine;

        if aElement0L.C0<>nil then begin
          if aElement0L.C0.X<>aX0 then
            ed_X0.Text := '';
          if aElement0L.C0.Y<>aY0 then
            ed_Y0.Text := '';
          if aElement0L.C0.Z<>aZ0 then
            ed_Z0.Text := '';
        end else begin
          ed_X0.Text := 'Error';
          ed_Y0.Text := 'Error';
          ed_Z0.Text := 'Error';
        end;

        if aElement0L.C1<>nil then begin
          if aElement0L.C1.X<>aX1 then
            ed_X1.Text := '';
          if aElement0L.C1.Y<>aY1 then
            ed_Y1.Text := '';
          if aElement0L.C1.Z<>aZ1 then
            ed_Z1.Text := '';
        end else begin
          ed_X1.Text := 'Error';
          ed_Y1.Text := 'Error';
          ed_Z1.Text := 'Error';
        end;

        if aImageRect.Alpha<>ImageRect.Alpha then
          ed_Alpha.Text:='';
    end else
    if aElement0.QueryInterface(ILine, aElement0L)=0 then begin
      aClassID:=_Line;

      bLayerName:=aElement0.Parent.Name;
      aLayerName:='no';
      for  k:=0  to aLayersCount-1 do
        if bLayerName=aParents[k] then
          aLayerName:='yes';

        if aLayerName<>'yes' then begin
          aParents[aLayersCount]:=bLayerName;
          aLayersCount:=aLayersCount+1;
          cb_SelectLayer.Text:=''
        end;

        if aElement0L.C0<>nil then begin
          if aElement0L.C0.X<>aX0 then
            ed_X0.Text := '';
          if aElement0L.C0.Y<>aY0 then
            ed_Y0.Text := '';
          if aElement0L.C0.Z<>aZ0 then
            ed_Z0.Text := '';
        end else begin
          ed_X0.Text := 'Error';
          ed_Y0.Text := 'Error';
          ed_Z0.Text := 'Error';
        end;

        if aElement0L.C1<>nil then begin
          if aElement0L.C1.X<>aX1 then
            ed_X1.Text := '';
          if aElement0L.C1.Y<>aY1 then
            ed_Y1.Text := '';
          if aElement0L.C1.Z<>aZ1 then
            ed_Z1.Text := '';
        end else begin
          ed_X1.Text := 'Error';
          ed_Y1.Text := 'Error';
          ed_Z1.Text := 'Error';
        end;

        if (aElement0L.C0<>nil) and
           (aElement0L.C1<>nil) then begin
          if aElement0L.ZAngle<>aZAngle then
            ed_ZAngle.Text := '';
        end;

    end else
//_________________  область
    if aElement0.QueryInterface(IArea, aArea)=0 then begin
      aClassID:=_Area;
      if aArea.MinZ<>aMinZ then
        ed_MinZ.Text := '';
      if aArea.MaxZ<>aMaxZ then
        ed_MaxZ.Text := '';

      if (aArea.BottomLines.Count=1) and
         (aArea.TopLines.Count=1) then begin
        ed_AreaSize1.Visible:=True;
        lb_AreaSize1.Visible:=True;
        aLine:=aArea.BottomLines.Item[0] as ILine;
        if aLine.Length<>aAreaLength then
          ed_AreaSize1.Text := '';
      end else begin
        ed_AreaSize1.Visible:=False;
        lb_AreaSize1.Visible:=False;
      end;

     if (aArea.Volume0<>aVolume0) or
        (aArea.Volume1<>aVolume1) then
       lb_Volums.Caption := ''

  //_________________ объем
    end else
    if aElement0.QueryInterface(IVolume, aVolume)=0 then begin
      aClassID:=_Volume;
      if aVolume.MinZ<>aMinZ then
       ed_VolumeMinZ.Text := '';
      if aVolume.MaxZ<>aMaxZ then
       ed_VolumeMaxZ.Text := '';
    end else
   //_________________ метка
    if aElement0.QueryInterface(ISMLabel, aLabel)=0 then begin
      aClassID:=_SMLabel;
      if (aLabel as IDMElement).Name<>aLabelName then
        ed_Name.Text := '';

      if (aCount>1) then begin
        lb_Label.Visible:=False;
        ed_Name.Visible:=False
      end else begin
        lb_Label.Visible:=True;
        ed_Name.Visible:=True;
        lb_Label.Caption:='имя метки '+ IntToStr((aLabel As IDMElement).ID);
      end;
    end;

    lb_Parents.Items.AddObject(IntToStr(aElement0.ID)+' :'
                           + aElement0.Name, pointer(aElement0))
  end;
  Set_ParamVisionSelection(aClassID);

  lb_SelectCount.Caption:='объектов:'+IntToStr(aCount)+' ('+IntToStr(aLayersCount)+' сл.)';       //панель Info

  FChangingSelection:=False;   // ??????
  except
    raise
  end;
end;


procedure TDMDraw.OnDragLine(Length, Angle:double);
begin
end;

procedure TDMDraw.LoadRasterImage(var aGraphicFileName:string);
var
  S:string;
  KeyboardState:TKeyboardState;
  Server:IDataModelServer;
  OldForceCurrentDirectory:boolean;
  Document:IDMDocument;
begin
  OldForceCurrentDirectory:=ForceCurrentDirectory;
  ForceCurrentDirectory:=True;
  try
  Server:=Get_DataModelServer as IDataModelServer;

  Document:=Server.CurrentDocument;
  if Uppercase(Server.InitialDir)<>'DEMO' then
    OpenDialog1.InitialDir:=Server.InitialDir
  else
    OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName)+'DEMO';

  OpenDialog1.DefaultExt := GraphicExtension(TBitmap);
  S := 'JPEG (*.jpg)|*.jpg|Bitmaps (*.bmp)|*.bmp';
  OpenDialog1.Filename := '';
  OpenDialog1.Filter := S;


  if (Document.State and dmfDemo)<>0 then begin
    DM_GetKeyboardLayoutName(FOldLayoutName);
    DM_LoadKeyboardLayout('00000409',    //English
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

    DM_GetKeyboardState(KeyboardState);
    KeyboardState[VK_CAPITAL]:=0;
    DM_SetKeyboardState(KeyboardState);
  end;

  if OpenDialog1.Execute then begin begin
    aGraphicFileName:=OpenDialog1.FileName;
    OpenDialog1.InitialDir:=ExtractFilePath(aGraphicFileName);
    Server.InitialDir:=OpenDialog1.InitialDir;
  end end else
    aGraphicFileName:='';

  CallRefresh(rfFast);
  if (Document.State and dmfDemo)<>0 then begin
    DM_LoadKeyboardLayout(FOldLayoutName,
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;
  finally
   ForceCurrentDirectory:=OldForceCurrentDirectory;
  end;
end;

destructor TPainterPanel.Destroy;
begin
  inherited;
end;

procedure TDMDraw.spDMaxMoved(Sender: TObject);
var
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
   with FPainter do begin
     DrawRangeMarks;
     DmaxPix := pnDmax.Height;
     edDmax.Text:=Format('%-1.2f',[View.Dmax/100]);
     DrawRangeMarks;
     FRangeChangedFlag:=True;
  end;
end;

procedure TDMDraw.spDminMoved(Sender: TObject);
var
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
   with FPainter do begin
     DrawRangeMarks;
     DminPix := pnDRange.Height                      
        - spDmin.Height - pnDmin.Height;

     edDmin.Text:=Format('%-1.2f',[View.Dmin/100]);
     DrawRangeMarks;
     FRangeChangedFlag:=True;
  end;
end;


procedure TDMDraw.spZmaxMoved(Sender: TObject);
var
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
   with FPainter do begin
     DrawRangeMarks;
     ZmaxPix := PnZMax.Height;

     edZmax.Text:=Format('%-1.2f',[View.Zmax/100]);

     DrawRangeMarks;
     FRangeChangedFlag:=True;
  end;
end;

procedure TDMDraw.spZminMoved(Sender: TObject);
var
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
   with FPainter do begin
     DrawRangeMarks;
     ZminPix := pnZRange.Height
        - spZMin.Height - pnZMin.Height;

     edZmin.Text:=Format('%-1.2f',[View.Zmin/100]);
     DrawRangeMarks;
     FRangeChangedFlag:=True;
  end;
end;

procedure TDMDraw.pnRangeMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  SMDocument:ISMDocument;  
begin
   if not FDrawRangeMarksFlag then begin
     SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as ISMDocument;
     SMDocument.DontDragMouse:=1;
     FDrawRangeMarksFlag:=True;    // установка линий
     FPainter.DrawRangeMarks;
   end;
end;

function GetSplitterPos(p,H,H1,H2,SplitterPos:integer):integer;
var
  Hmax,pSize:integer;
begin
  Result := -1;
  pSize := H-2; //2 пикс.толщ.рамки
  Hmax := pSize-((1+H1+H2));
  if SplitterPos<1 then
   case p of
    1:Result := 1;
    2:Result := Hmax-1
   end
  else
   if SplitterPos>Hmax then
    case p of
     1:Result := Hmax-1;
     2:Result := 1
    end
   else
    case p of
     1:Result := SplitterPos;
     2:Result := pSize-(SplitterPos+H2)
    end;
end;

procedure TDMDraw.chbChangeLengthDirectionChange(Sender: TObject);
var
  SpatialModel2:ISpatialModel2;
  j:integer;
begin
 SpatialModel2:=FSpatialModel as ISpatialModel2;
 j:=TCombobox(Sender).ItemIndex;
 SpatialModel2.ChangeLengthDirection:=j;
 if Sender<>chbChangeLengthDirection then
   chbChangeLengthDirection.ItemIndex:=j;
 if Sender<>chbChangeWidthDirection then
   chbChangeWidthDirection.ItemIndex:=j;
end;


procedure TDMDraw.SetHRangeMarks;
var
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if FSettingRangeMarksFlag then Exit;
  FSettingRangeMarksFlag:=True;

  pnDmax.Height := GetSplitterPos(1,pnDRange.Height,
             spDmax.Height,spDmin.Height,FPainter.DmaxPix);
  pnDmin.Height := GetSplitterPos(2,pnDRange.Height,
            spDmax.Height,spDmin.Height,FPainter.DminPix);
  FSettingRangeMarksFlag:=False;
end;

procedure TDMDraw.SetVRangeMarks;
var
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if FSettingRangeMarksFlag then Exit;
  FSettingRangeMarksFlag:=True;

  pnZMax.Height := GetSplitterPos(1,pnZRange.Height,
            spZMax.Height,spZMin.Height,FPainter.ZmaxPix);
  pnZMin.Height := GetSplitterPos(2,pnZRange.Height,
            spZMax.Height,spZMin.Height,FPainter.ZminPix);
  FSettingRangeMarksFlag:=False;
end;

procedure TDMDraw.SetRangeEditors;
var
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  edDmin.Text:=Format('%-1.2f',[View.Dmin/100]);
  edDmax.Text:=Format('%-1.2f',[View.Dmax/100]);
  edZmin.Text:=Format('%-1.2f',[View.Zmin/100]);
  edZmax.Text:=Format('%-1.2f',[View.Zmax/100]);
end;

procedure TDMDraw.edDmaxChange(Sender:TObject);
var
  C,C1:integer;
  D,D1:double;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if FChangingView then Exit;
  if not edDmax.Modified then Exit;

  FPainter.DrawRangeMarks;

  Val(edDmax.Text,D,C);
  Val(edDmin.Text,D1,C1);
  if (C<>0) then begin
    edDmax.Font.Color:=clRed;
    Exit;
  end;
  if (D<D1) then begin
    edDmax.Font.Color:=clRed;
    edDmin.Font.Color:=clRed;
    Exit;
  end else begin
    edDmax.Font.Color:=clWindowText;
    edDmin.Font.Color:=clWindowText;
  end;
  View.Dmax:=D*100.0;
  FRangeChangedFlag:=True;
  FPainter.SetRangePix;
  SetHRangeMarks;
                       { TODO -o Гол. -c warning :  ! }
     FPainter.DrawRangeMarks;
     FDrawRangeMarksFlag:=True;
end;

procedure TDMDraw.edDminChange(Sender: TObject);
var
  C,C1:integer;
  D,D1:double;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if FChangingView then Exit;
  if not edDmin.Modified then Exit;

  FPainter.DrawRangeMarks;

  Val(edDmin.Text,D,C);
  Val(edDmax.Text,D1,C1);
  if (C<>0)  then begin
    edDmin.Font.Color:=clRed;
    Exit;
  end;
  if (D>D1) then begin
    edDmin.Font.Color:= clRed;
    edDmax.Font.Color:= clRed;
    Exit;
  end else begin
     edDmin.Font.Color:=clWindowText;
     edDmax.Font.Color:=clWindowText;
  end;
  View.Dmin:=D*100.0;
  FPainter.SetRangePix;
  SetHRangeMarks;
 { TODO -oГол. -cwarning : ! ! ! ! }
     FPainter.DrawRangeMarks;
     FDrawRangeMarksFlag:=True;
end;

procedure TDMDraw.edZmaxChange(Sender: TObject);
var
  C,C1:integer;
  Z,Z1:double;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if FChangingView then Exit;
  if not edZmax.Modified then Exit;

  FPainter.DrawRangeMarks;

  Val(edZmax.Text,Z,C);
  Val(edZmin.Text,Z1,C1);
  if (C<>0)  then begin
    edZmax.Font.Color:=clRed;
    Exit;
  end;
  if (Z<Z1) then begin
    edZmax.Font.Color:=clRed;
    edZmin.Font.Color:=clRed;
    Exit;
  end else begin
    edZmax.Font.Color:=clWindowText;
    edZmin.Font.Color:=clWindowText;
  end;
  View.Zmax:=Z*100.0;
  FRangeChangedFlag:=True;
  FPainter.SetRangePix;
  SetVRangeMarks;
  { TODO -oГол. -cwarning : ! ! ! ! }
     FPainter.DrawRangeMarks;
     FDrawRangeMarksFlag:=True;
end;

procedure TDMDraw.edZminChange(Sender: TObject);
var
  C,C1:integer;
  Z,Z1:double;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if FChangingView then Exit;
  if not edZmin.Modified then Exit;

  FPainter.DrawRangeMarks;

  Val(edZmin.Text,Z,C);
  Val(edZmax.Text,Z1,C1);
  if (C<>0) then begin
    edZmin.Font.Color:=clRed;
    Exit;
  end;
  if (Z>Z1) then begin
    edZmin.Font.Color:=clRed;
    edZmax.Font.Color:=clRed;
    Exit;
  end else begin
    edZmin.Font.Color:=clWindowText;
    edZmax.Font.Color:=clWindowText;
  end;
  View.Zmin:=Z*100.0;
  FRangeChangedFlag:=True;
  FPainter.SetRangePix;
  SetVRangeMarks;
{ TODO -oГол. -cwarning : ! ! ! ! }
     FPainter.DrawRangeMarks;
     FDrawRangeMarksFlag:=True;
end;

procedure TDMDraw.HPanelResize(Sender: TObject);
var
  Painter3:IPainter3;
  SpatialModel2:ISpatialModel2;
//  H:HWnd;
//  D:double;

begin
//  H:=FHPainterPanel.Handle;
//{$R-}
//  FPainter.HCanvasHandle:=FHPainterPanel.GetDeviceContext(H);
//{$R+}
  FPainter.HWidth:=FHPainterPanel.Width;
  FPainter.HHeight:=FHPainterPanel.Height;

  SpatialModel2:=GetDataModel as ISpatialModel2;
  if (FPainter.QueryInterface(IPainter3, Painter3)=0) and
     SpatialModel2.FastDraw  then
    Painter3.ResizeBack(1);
  FPainter.SetLimits;
  SetHRangeMarks;
//  D:=1-PanelVert.Height/(Panel0.Height-Splitter2.Height);
//  lPanelRatio.Caption:=FloatToStr(D);
end;

procedure TDMDraw.VPanelResize(Sender: TObject);
var
  Painter3:IPainter3;
  SpatialModel2:ISpatialModel2;
//  H:HWnd;
begin
//  H:=FVPainterPanel.Handle;
//{$R-}
//  FPainter.VCanvasHandle:=FVPainterPanel.GetDeviceContext(H);
//{$R+}
  FPainter.VWidth:=FVPainterPanel.Width;
  FPainter.VHeight:=FVPainterPanel.Height;

  SpatialModel2:=GetDataModel as ISpatialModel2;
  if (FPainter.QueryInterface(IPainter3, Painter3)=0) and 
     SpatialModel2.FastDraw  then
    Painter3.ResizeBack(2);
  FPainter.SetLimits;
  SetVRangeMarks;
end;

procedure TDMDraw.Splitter1Moved(Sender: TObject);
begin
  if not FSplitterMoved then Exit;
  FSplitterMoved:=False;

  DoPaint;
  FHVRatio:=1-PanelVert.Height/Panel0.Height;
//  FHVRatio:=1-PanelVert.Height/(Panel0.Height-Splitter2.Height);
//  lPanelRatio.Caption:=FloatToStr(FHVRatio);
  FPainter.SetLimits;
end;

procedure TDMDraw.sbDMaxDownClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
{$IFDEF Demo}
  WriteSpeedButtonDownMacros(Sender);
{$ENDIF}
  Val(edDmax.Text,D,C);
  D := D - FIntervalDmax;
  edDmax.Text:=Format('%-1.2f',[D]);
  edDmax.Modified := True;
  edDmax.OnChange(nil);
end;

procedure TDMDraw.sbDMaxUpClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
{$IFDEF Demo}
  WriteSpeedButtonUpMacros(Sender);
{$ENDIF}
  Val(edDmax.Text,D,C);
  D := D + FIntervalDmax;
  edDmax.Text:=Format('%-1.2f',[D]);
  edDmax.Modified := True;
  edDmax.OnChange(nil);
end;

procedure TDMDraw.sbDMinDownClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
{$IFDEF Demo}
  WriteSpeedButtonDownMacros(Sender);
{$ENDIF}
  Val(edDMin.Text,D,C);
  D := D - FIntervalDmin;
  edDMin.Text:=Format('%-1.2f',[D]);
  edDMin.Modified := True;
  edDMin.OnChange(nil);
end;

procedure TDMDraw.sbDMinUpClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
{$IFDEF Demo}
  WriteSpeedButtonUpMacros(Sender);
{$ENDIF}
  Val(edDMin.Text,D,C);
  D := D + FIntervalDmin;
  edDMin.Text:=Format('%-1.2f',[D]);
  edDMin.Modified := True;
  edDMin.OnChange(nil);
end;

procedure TDMDraw.sbZMaxDownClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
{$IFDEF Demo}
  WriteSpeedButtonDownMacros(Sender);
{$ENDIF}
  Val(edZMax.Text,D,C);
  D := D - FIntervalZmax;
  edZmax.Text:=Format('%-1.2f',[D]);
  edZmax.Modified := True;
  edZmax.OnChange(nil);
end;

procedure TDMDraw.sbZMaxUpClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
{$IFDEF Demo}
  WriteSpeedButtonUpMacros(Sender);
{$ENDIF}
  Val(edZmax.Text,D,C);
  D := D + FIntervalZmax;
  edZmax.Text:=Format('%-1.2f',[D]);
  edZmax.Modified := True;
  edZmax.OnChange(nil);
end;

procedure TDMDraw.sbZMinDownClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
{$IFDEF Demo}
  WriteSpeedButtonDownMacros(Sender);
{$ENDIF}
  Val(edZMin.Text,D,C);
  D := D - FIntervalZmin;
  edZMin.Text:=Format('%-1.2f',[D]);
  edZMin.Modified := True;
  edZMin.OnChange(nil);
end;

procedure TDMDraw.sbZMinUpClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
{$IFDEF Demo}
  WriteSpeedButtonUpMacros(Sender);
{$ENDIF}
  Val(edZMin.Text,D,C);
  D := D + FIntervalZmin;
  edZMin.Text:=Format('%-1.2f',[D]);
  edZMin.Modified := True;
  edZMin.OnChange(nil);
end;

procedure TDMDraw.sbZAngleDownClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
  if FChangingView then Exit;
{$IFDEF Demo}
  WriteSpeedButtonDownMacros(Sender);
{$ENDIF}
  Val(edZAngle.Text,D,C);
  D := D - FIntervalAngle;
  edZAngle.Text:=Format('%-1.2f',[D]);
  edZAngle.Modified := True;
  edZAngle.OnChange(nil);
end;

procedure TDMDraw.sbZAngleUpClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
  if FChangingView then Exit;
{$IFDEF Demo}
  WriteSpeedButtonUpMacros(Sender);
{$ENDIF}
  Val(edZAngle.Text,D,C);
  D := D + FIntervalAngle;
  edZAngle.Text:=Format('%-1.2f',[D]);
  edZAngle.Modified := True;
  edZAngle.OnChange(nil);
end;
//_____________________________________________________


procedure TDMDraw.mi_IntrvAngeleClick(Sender: TObject);
begin
  if fmInputValue=nil then
    fmInputValue:=TfmInputValue.Create(Self);
  fmInputValue.Caption := 'Угол';
  fmInputValue.Label1.Caption := 'шаг в град';
  fmInputValue.ed_Value.Text := Format('%0.2f',[FIntervalAngle]);
  if fmInputValue.ShowModal=mrOK then
    FIntervalAngle := StrToFloat(fmInputValue.ed_Value.Text);
  CallRefresh(rfFast);
end;

procedure TDMDraw.N2Click(Sender: TObject);
begin
  if fmInputValue=nil then
    fmInputValue:=TfmInputValue.Create(Self);
  fmInputValue.Caption := 'Высота';
  fmInputValue.Label1.Caption := 'шаг в (м)';
  fmInputValue.ed_Value.Text := Format('%0.2f',[FIntervalHeight]);
  if fmInputValue.ShowModal=mrOK then
    FIntervalHeight := StrToFloat(fmInputValue.ed_Value.Text);
  CallRefresh(rfFast);
end;

procedure TDMDraw.N3Click(Sender: TObject);
var
   Tick: extended;
begin
  if fmInputValue=nil then
    fmInputValue:=TfmInputValue.Create(Self);
  fmInputValue.Caption := 'Толщина';
  fmInputValue.Label1.Caption := 'шаг в (см)';
  Tick := FIntervalThickness*100.;
  fmInputValue.ed_Value.Text := Format('%0.2f',[Tick]);
  if fmInputValue.ShowModal=mrOK then
    FIntervalThickness := StrToFloat(fmInputValue.ed_Value.Text)/100.;
  CallRefresh(rfFast);
end;

procedure TDMDraw.mi_IntervalDZClick(Sender: TObject);
begin
  if fmInputValue=nil then
    fmInputValue:=TfmInputValue.Create(Self);
  fmInputValue.Caption := 'Шаг max и min дальности и высоты';
  fmInputValue.Label1.Caption := 'шаг  в (м)';
  fmInputValue.ed_Value.Text := Format('%0.2f',[FIntervalDmax]);
  if fmInputValue.ShowModal=mrOK then begin
    FIntervalDmax := StrToFloat(fmInputValue.ed_Value.Text);
    FIntervalDmin := FIntervalDmax;
    FIntervalZmax := FIntervalDmax;
    FIntervalZmin := FIntervalDmax;
  end;
  CallRefresh(rfFast);
end;

procedure TDMDraw.mi_IntervalDClick(Sender: TObject);
begin
  if fmInputValue=nil then
    fmInputValue:=TfmInputValue.Create(Self);
  fmInputValue.Caption := 'Шаг max и min дальности';
  fmInputValue.Label1.Caption := 'шаг в (см)';
  fmInputValue.ed_Value.Text := Format('%0.2f',[FIntervalDmax]);
  if fmInputValue.ShowModal=mrOK then begin
    FIntervalDmax := StrToFloat(fmInputValue.ed_Value.Text);
    FIntervalDmin := FIntervalDmax;
  end;
  CallRefresh(rfFast);
end;

procedure TDMDraw.mi_IntervalZClick(Sender: TObject);
begin
  if fmInputValue=nil then
    fmInputValue:=TfmInputValue.Create(Self);
  fmInputValue.Caption := 'Шаг max и min высоты';
  fmInputValue.Label1.Caption := 'шаг в (см)';
  fmInputValue.ed_Value.Text := Format('%0.2f',[FIntervalZmax]);
  if fmInputValue.ShowModal=mrOK then begin
    FIntervalZmax := StrToFloat(fmInputValue.ed_Value.Text);
    FIntervalZmin := FIntervalDmax;
  end;
  CallRefresh(rfFast);
end;

procedure TDMDraw.PrintPainter(aCanvasTag: integer);
var
  OldCanvasHandle:HDC;
  OldWidth, OldHeight:integer;
  OldRevScale:double;
  Painter3:IPainter3;
  SpatialModel2:ISpatialModel2;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
{$R-}
  Printer.PrinterIndex:=-1;

  SpatialModel2:=GetDataModel as ISpatialModel2;
  case aCanvasTag of
  0: begin
     OldCanvasHandle:=FPainter.HCanvasHandle;
     OldWidth:=FPainter.HWidth;
     OldHeight:=FPainter.HHeight;
     FPainter.HWidth:=Printer.PageWidth;
     FPainter.HHeight:=Printer.PageHeight;
     if (FPainter.QueryInterface(IPainter3, Painter3)=0) and
        SpatialModel2.FastDraw then
       Painter3.ResizeBack(0);
     end;
  else begin
     OldCanvasHandle:=FPainter.VCanvasHandle;
     OldWidth:=FPainter.VWidth;
     OldHeight:=FPainter.VHeight;
     FPainter.VWidth:=Printer.PageWidth;
     FPainter.VHeight:=Printer.PageHeight;
     if (FPainter.QueryInterface(IPainter3, Painter3)=0) and
         SpatialModel2.FastDraw then
       Painter3.ResizeBack(0);
     end;
  end;
  OldRevScale:=View.RevScale;
  View.RevScale:=View.RevScale*OldWidth/Printer.PageWidth;

  Printer.BeginDoc;
  try
    case aCanvasTag of
    0:   FPainter.HCanvasHandle:=Printer.Canvas.Handle;
    else FPainter.VCanvasHandle:=Printer.Canvas.Handle;
    end;
    FPainter.IsPrinter:=True;
    DoPaint;
  finally
    FPainter.IsPrinter:=False;
    Printer.EndDoc;

    case aCanvasTag of
    0: begin
         FPainter.HWidth:=OldWidth;
         FPainter.HHeight:=OldHeight;
         if (FPainter.QueryInterface(IPainter3, Painter3)=0) and
           SpatialModel2.FastDraw then
           Painter3.ResizeBack(1);
         FPainter.HCanvasHandle:=OldCanvasHandle;
       end;
    1: begin
         FPainter.VWidth:=OldWidth;
         FPainter.VHeight:=OldHeight;
         if (FPainter.QueryInterface(IPainter3, Painter3)=0) and
           SpatialModel2.FastDraw then
           Painter3.ResizeBack(2);
         FPainter.VCanvasHandle:=OldCanvasHandle;
       end;
    end;
    View.RevScale:=OldRevScale;
  end;
  Invalidate;
{$R+}
end;

procedure TDMDraw.DrawElement(aElement: IDMElement);
begin
  aElement.Draw(FPainter, ord(aElement.Selected))
end;

procedure TDMDraw.cbLayersDblClick(Sender: TObject);
var
  Layer:IDMElement;
begin
  if fmLayerProperties=nil then begin
    fmLayerProperties:=TfmLayerProperties.Create(Self);
    fmLayerProperties.LayerRefTypes:=FLayerRefTypes;
  end;
  Layer:=FSpatialModel.CurrentLayer as IDMElement;
  fmLayerProperties.edName.Text:=Layer.Name;
  fmLayerProperties.LayerRef:=Layer.Ref;
  fmLayerProperties.chbExpand.Checked:=FSpatialModel.CurrentLayer.Expand;
  if fmLayerProperties.ShowModal=mrOK then begin
    Layer.Name:=fmLayerProperties.edName.Text;
    Layer.Ref:=fmLayerProperties.LayerRef;
    FSpatialModel.CurrentLayer.Expand:=fmLayerProperties.chbExpand.Checked;
  end;
  CallRefresh(rfFast);
end;

procedure TDMDraw.DocumentOperation(ElementsV,
  CollectionV: OleVariant; DMOperation, nItemIndex: Integer);
var
  Element:IDMElement;
  Unk:IUnknown;
  Layer:ILayer;
  View:IView;
  aCollection:IDMCollection;
begin
  if not Visible then Exit;
  inherited;
  Unk:=ElementsV;
  if Unk=nil then Exit;
  if Unk.QueryInterface(IDMElement, Element)=0 then
    Element:=Unk as IDMElement
  else begin
    aCollection:=Unk as IDMCollection;
    if aCollection.Count>0 then
      Element:=aCollection.Item[0]
    else
      Exit;
  end;

  if Element.QueryInterface(ILayer, Layer)=0 then
    SetLayers
  else
  if Element.QueryInterface(IView, View)=0 then begin
    SetViews;
    OnChangeView;
    CallRefresh(rfFrontBack);
  end;
end;

procedure TDMDraw.SetTransformButtons;
var
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  FormID, B:integer;
  U:IUnknown;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;

  if (DMDocument.SelectionCount>0) and
     ((DMDocument.SelectionItem[0].QueryInterface(ISpatialElement, U)=0) or
      (DMDocument.SelectionItem[0].QueryInterface(ICoord, U)=0)) then
    B:=1
  else
    B:=0;

  FormID:=Get_FormID;
  Server.SetControlState(FormID, btnMoveSelected,
                         csEnabled, B);
  Server.SetControlState(FormID, btnScaleSelected,
                         csEnabled, B);
  Server.SetControlState(FormID, btnTrimExtendToSelected,
                         csEnabled, B);
  Server.SetControlState(FormID, btnRotateSelected,
                         csEnabled, B);
  Server.SetControlState(FormID, btnZoomSelection,
                         csEnabled, B);
end;

procedure TDMDraw.OpenDocument;
var
  aDataModel:IDataMOdel;
  DMDocument:IDMDocument;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  Server:IDataModelServer;
  FormID:integer;
begin
  if not Visible then Exit;
  inherited;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  aDataModel:=DMDocument.DataModel as IDataModel;
  Set_SpatialModel(aDataModel as ISpatialModel);
  SMDocument:=DMDocument as ISMDocument;
  SMOperationManager:=DMDocument as ISMOperationManager;
  SMDocument.PainterU:=FPainter;

  FormID:=Get_FormID;

  SMDocument.DrawToolBarIndex:=FormID;
  
  if SMOperationManager.OperationCode=-1 then begin
    Server.SetControlState(FormID, btnSnapOrtToLine,
                           csChecked, 1);
    Server.SetControlState(FormID, btnSnapOrtToLine,
                           csClick, 1);
    Server.SetControlState(FormID, btnSelectAll,
                           csClick, 1);
    Server.SetControlState(FormID, btnSideView,
                           csChecked, 1);
    Server.SetControlState(FormID, btnPalette,
                           csChecked, 1);
  end else
    SetOperationButton;

  SetTransformButtons;
  
  CheckDocumentState;

  CallRefresh(rfFrontBack);

  FLastDrawElement:=nil;
end;

destructor TDMDraw.Destroy;
begin
  inherited;
  FDataModels.Free;
  FSpatialModel:=nil;
  FPainter:=nil;
  FLayerRefTypes:=nil;
  FLastDrawElement:=nil;
end;

procedure TDMDraw.tbRepaintClick(Sender: TObject);
begin
  FormPaint(Sender)
end;

function TDMDraw.WantChildKey(Child: TControl;
  var Message: TMessage): Boolean;
begin
  Result :=inherited WantChildKey(Child, Message);
end;

procedure TPainterPanel.CMWantSpecialKey(var Message: TCMWantSpecialKey);
var
  ShiftState:TShiftState;
begin
  inherited;
  Message.Result := 1;
  ShiftState := KeyDataToShiftState(Message.KeyData);
  KeyDown(Message.CharCode, ShiftState);
end;

procedure TDMDraw.RefreshDocument(FlagSet:integer);
var
  SMDocument:ISMDocument;
  Painter3:IPainter3;
  OldCanvasSet, CanvasSet:integer;
begin
  if not Visible then Exit;
  OnChangeView;
  FRefreshFlagSet:=FlagSet;
  Repaint;
  FRefreshFlagSet:=rfFront;
end;

procedure TDMDraw.ToolBarExit(Sender: TObject);
begin
  TControl(Sender).Visible:=False
end;

procedure TDMDraw.SetOperationButton;
var
  SMOperationManager:ISMOperationManager;
  Server:IDataModelServer;
  FormID:integer;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  SMOperationManager:=Server.CurrentDocument as ISMOperationManager;

  FormID:=Get_FormID;
  try
  Server.SetControlState(FormID, -SMOperationManager.OperationCode,
                           csChecked, 1);
  Server.SetControlState(FormID, -SMOperationManager.SnapMode,
                           csChecked, 1);
  except
    raise
  end                           
end;

procedure TDMDraw.ToolButton10Click(Sender: TObject);
var
  SMDocument:ISMDocument;
begin
  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  SMDocument.RestoreView;

  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.SelectionChanged(DMElement:OleVariant);
begin
  if not Visible then Exit;
  OnChangeSelection;
end;

procedure TDMDraw.CopyToBuffer;
begin
  inherited;
end;

function TDMDraw.PasteFromBuffer:boolean;
var
  CanPaste:WordBool;
  DMDocument:IDMDocument;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  DMOperationManager:IDMOperationManager;
  Painter:IPainter;
  View:IView;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  aElement,LayerE, NodeE:IDMElement;
  Node:ICoordNode;
  Layer:ILayer;
  N,N1,j,m, L, OldState, OldSelectState:integer;
  X, Y, CX, CY, CZ:double;
  RefParent, SourceLayerE, DestLayerE: IDMElement;
  DMClassCollections:IDMClassCollections;
  RefSource, aCollection : IDMCollection;
  CopyBuffer:IDMCopyBuffer;
  S:string;
  Server:IDataModelServer;
  SourceElement:IDMElement;
  Unk:IUnknown;
  ParentCollection:IDMCollection;
  ClassID:integer;
  SpatialModelE:IDMElement;
  aDataModel:IDataModel;
begin
  Result:=False;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  CopyBuffer:=Server as IDMCopyBuffer;
  if CopyBuffer.BufferCount=0 then Exit;

  SourceElement:=CopyBuffer.Buffer[0] as IDMElement;
  if SourceElement.ClassID=_Area then Exit;
  if SourceElement.QueryInterface(ISpatialElement, Unk)<>0 then Exit;

  aDataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=aDataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  SMDocument:=DMDocument as ISMDocument;
  SMOperationManager:=DMDocument as ISMOperationManager;
  DMOperationManager:=DMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  CX:=View.CX;
  CY:=View.CY;
  CZ:=SMDocument.CurrZ;
  Layer:=SpatialModel.CurrentLayer;
  LayerE:=Layer as IDMElement;

  if DMDocument.SelectionCount>0 then Exit;

  try
  DMDocument.ClearSelection(nil);

  aElement:=CopyBuffer.Buffer[0] as IDMElement;

  SpatialModel2.GetRefElementParent(aElement.ClassID,
                         SMOperationManager.OperationCode, CX, CY, CZ,
                         RefParent, DMClassCollections, RefSource, aCollection);

  N:=SpatialModel.CoordNodes.Count;
  L:=SpatialModel.Layers.Count;
  ClassID:=SourceElement.ClassID;
  SpatialModelE:=SpatialModel as IDMElement;
  ParentCollection:=SpatialModelE.Collection[ClassID];
  CopyBuffer.Paste(LayerE,
    ParentCollection, ltOneToMany, True, CanPaste);

  N1:=SpatialModel.CoordNodes.Count;
  if N=N1 then Exit;
    X:=0;
    Y:=0;
    for j:=N to N1-1 do begin
      NodeE:=SpatialModel.CoordNodes.Item[j];
      Node:=NodeE as ICoordNode;
      X:=X+Node.X;
      Y:=Y+Node.Y;
    end;
    X:=X/(N1-N);
    Y:=Y/(N1-N);

    OldState:=aDataModel.State;
    OldSelectState:=OldState and dmfSelecting;
    aDataModel.State:=OldState or dmfSelecting;

    NodeE:=nil;
    try
    for j:=N to N1-1 do begin
      NodeE:=SpatialModel.CoordNodes.Item[j];
      Node:=NodeE as ICoordNode;
      Node.X:=Node.X-(X-CX);
      Node.Y:=Node.Y-(Y-CY);
      NodeE.Selected:=True;
    end;
    finally
      aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
    end;
    Server.SelectionChanged(NodeE);

    for j:=N to N1-1 do begin
      NodeE:=SpatialModel.CoordNodes.Item[j];
      Node:=NodeE as ICoordNode;
      for m:=0 to Node.Lines.Count-1 do
        Node.Lines.Item[m].Draw(Painter, 0);
      NodeE.Draw(Painter, 1);
    end;

  OldState:=aDataModel.State;
  aDataModel.State:=aDataModel.State or dmfCopying;
  if RefParent<>nil then begin
    for j:=0 to CopyBuffer.LastCopyCount-1 do begin
      aElement:=CopyBuffer.LastCopy[j] as IDMElement;
      if (aElement.Ref<>nil) and
         (aElement.Ref.SpatialElement=aElement) then begin
        aElement:=aElement.Ref;
        DMOperationManager.ChangeParent( nil, RefParent, aElement);
      end;
    end;
  end;
  aDataModel.State:=OldState;

  j:=L;
  while j<FSpatialModel.Layers.Count do begin
    SourceLayerE:=FSpatialModel.Layers.Item[j];
    S:=SourceLayerE.Name;
    m:=0;
    while m<L do begin
      DestLayerE:=FSpatialModel.Layers.Item[m];
      if DestLayerE.Name=S then
        Break
      else
        inc(m)
    end;
    if m<L then
      JoinLayer(DestLayerE, SourceLayerE)
    else
      inc(j)
  end;

  SetLayers;
  except
    raise
  end;

  for j:=0 to SpatialModel2.Areas.Count-1 do
    SpatialModel2.Areas.Item[j].AfterCopyFrom(nil);

  CallRefresh(rfFrontBack); //    Repaint;

  Result:=True;
end;

procedure TDMDraw.sb_ScrollXChange(Sender: TObject);
var
  SpatialModel3:ISpatialModel3;
  D:double;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  If FScrollXFlag then begin

    if FSpatialModel.QueryInterface(ISpatialModel3, SpatialModel3)=0 then
      SpatialModel3.DrawThreadTerminated:=True;
    D:=((sb_ScrollX.Position-FScrollXOld))*FPainter.HWidth*View.RevScale/
                                           (sb_ScrollX.Max-sb_ScrollX.Min);
    View.CX:=View.CX+D*View.CosZ;
    View.CY:=View.CY-D*View.SinZ;
    FScrollXOld:=sb_ScrollX.Position;
    CallRefresh(rfFastBack); //    Repaint;
  end;
end;

procedure TDMDraw.GetFocus;
begin
  FHPainterPanel.SetFocus;
end;


procedure TPainterPanel.Key_Up(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_MENU then
    Key:=0
end;

procedure TPainterPanel.Mouse_Up(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  DMDrawX:TDMDraw;
  aShift: TShiftState;
begin
  DMDrawX:=TDMDraw(Owner);
  if not DMDrawX.FDragging then Exit;
  DMDrawX.FDragging:=False;
  aShift:=aShift+[ssLeft];
  Mouse_Down(Sender, Button, aShift, X, Y)
end;

procedure TDMDraw.sb_ScrollYChange(Sender: TObject);
var
  SpatialModel3:ISpatialModel3;
  D:double;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  If FScrollYFlag then begin

    if FSpatialModel.QueryInterface(ISpatialModel3, SpatialModel3)=0 then
      SpatialModel3.DrawThreadTerminated:=True;
    D:=((sb_ScrollY.Position-FScrollYOld))*FPainter.HHeight*View.RevScale/
                                           (sb_ScrollY.Max-sb_ScrollY.Min);
    View.CX:=View.CX-D*View.SinZ;
    View.CY:=View.CY-D*View.CosZ;
    FScrollYOld:=sb_ScrollY.Position;
    CallRefresh(rfFastBack); //    Repaint;
  end;
end;

procedure TDMDraw.sb_ScrollZChange(Sender: TObject);
var
  SpatialModel3:ISpatialModel3;
  D:double;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  If FScrollZFlag then begin

    if FSpatialModel.QueryInterface(ISpatialModel3, SpatialModel3)=0 then
      SpatialModel3.DrawThreadTerminated:=True;
    D:=((sb_ScrollZ.Position-FScrollZOld))*FPainter.VHeight*View.RevScale/
                                           (sb_ScrollZ.Max-sb_ScrollZ.Min);
    View.CZ:=View.CZ-D;
    FScrollZOld:=sb_ScrollZ.Position;
    CallRefresh(rfFastBack); //    Repaint;
  end;
end;

procedure TDMDraw.sb_ScrollXExit(Sender: TObject);
begin
  FScrollXFlag:=False;
  FScrollXOld:=0;
  sb_ScrollX.Position:=0;
end;

procedure TDMDraw.sb_ScrollYExit(Sender: TObject);
begin
  FScrollYFlag:=False;
  FScrollYOld:=0;
  sb_ScrollY.Position:=0;
end;

procedure TDMDraw.sb_ScrollZExit(Sender: TObject);
begin
  FScrollZFlag:=False;
  FScrollZOld:=0;
  sb_ScrollZ.Position:=0;
end;

procedure TDMDraw.sb_ScrollXEnter(Sender: TObject);
begin
  FScrollXFlag:=True;
end;

procedure TDMDraw.sb_ScrollYEnter(Sender: TObject);
begin
  FScrollYFlag:=True;
end;

procedure TDMDraw.sb_ScrollZEnter(Sender: TObject);
begin
  FScrollZFlag:=True;
end;

procedure TDMDraw.PanelInfoEnter(Sender: TObject);
begin
  PanelInfo.Font.Color:= clNavy;
end;

procedure TDMDraw.PanelInfoExit(Sender: TObject);
begin
  PanelInfo.Font.Color:= clWindowText;
end;

function TDMDraw.READChange(Sender:TObject):double;
var
  edName:TEdit;
  C:integer;
  D:double;
begin
  edName:=TEdit(Sender);
  Result := 0;
  if not edName.Modified then Exit;
  Val(edName.Text,D,C);
  if C<>0 then begin
    edName.Font.Color:=clRed;
    Exit;
  end else
    edName.Font.Color:=clWindowText;
  Result := D;
end;

procedure TDMDraw.edIntrvDZChange(Sender: TObject);
var
  edName: TObject;
begin
 edName := Sender;
 FIntervalDmax := READChange(edName);
 FIntervalDmin := READChange(edName);
 FIntervalZmax := READChange(edName);
 FIntervalZmin := READChange(edName);
end;

procedure TDMDraw.edIntrvThicknessChange(Sender: TObject);
var
  edName:TObject;
begin
 edName := Sender;
 FIntervalDmin := READChange(edName);
end;

procedure TDMDraw.edIntrvZmaxChange(Sender: TObject);
var
  edName:TObject;
begin
 edName := Sender;
 FIntervalZmax := READChange(edName);
end;

procedure TDMDraw.edInrvZminChange(Sender: TObject);
var
  edName:TObject;
begin
 edName := Sender;
 FIntervalZmin := READChange(edName);
end;

procedure TDMDraw.sgLayersDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
 I, H:integer;
 Bitmap:TBitmap;
 R:TRect;
begin
 try
 if aRow=0 then begin
   if aCol>1 then begin
     i:=aCol-2;
     Bitmap:=TBitmap.Create;
     ImageList1.GetBitmap(i, Bitmap);
     sgLayers.Canvas.Draw(Rect.Left, Rect.Top,  Bitmap);
     Bitmap.Free;
     Exit;
   end
 end else
 if (gdFixed in State) then Exit;
 if FSpatialModel=nil then Exit;
 if Get_DMEditorX.Changing then Exit;
 if(FSpatialModel as IDataModel).Document=nil then Exit;
 if FSpatialModel.Layers.Count=0 then Exit;
 I:=ARow-1;
 case aCol of
 1:begin
     if (I<>-1) and
        ((FSpatialModel.Layers.Item[I] as ILayer)=FSpatialModel.CurrentLayer) then begin
       sgLayers.Canvas.Brush.Color:=$0000E600;
       sgLayers.Canvas.FillRect(Rect);
       R:=sgLayers.CellRect(aCol,aRow);
       sgLayers.Canvas.TextOut(R.Left+1, R.Top+1,sgLayers.Cells[aCol,aRow]);
     end;
   end;
 4:begin
    sgLayers.Canvas.Brush.Color:=clWindow;
    sgLayers.Canvas.FillRect(Rect);
    H:=(Rect.Bottom-Rect.Top) div 2;
    sgLayers.Canvas.Pen.Color:=(FSpatialModel.Layers.Item[I] as ILayer).Color;
    sgLayers.Canvas.Pen.Style:=TPenStyle((FSpatialModel.Layers.Item[I] as ILayer).Style);
    sgLayers.Canvas.MoveTo(Rect.Left, Rect.Top+H);
    sgLayers.Canvas.LineTo(Rect.Right, Rect.Top+H);
    sgLayers.Canvas.Pen.Style:=psSolid;
   end;
 5:begin
      sgLayers.Canvas.Brush.Color:=(FSpatialModel.Layers.Item[I] as ILayer).Color;
      sgLayers.Canvas.FillRect(Rect);
   end;
  end;
  except
    raise
  end;  
end;
//____________________________________

procedure TDMDraw.sgLayersDblClick(Sender: TObject);
var
  I,j, D:integer;
  Server:IDataModelServer;
  DMOperationManager:IDMOperationManager;

 function SetLayersItem(k, Row:integer) :boolean;
 begin
  If sgLayers.Cells[k,Row]='+' then
   begin
     Result :=False;
     sgLayers.Cells[k,Row]:='-';
   end
   else begin
     Result :=True;
     sgLayers.Cells[k,Row]:='+';
   end;
 end;

var
  LayerE:IDMElement;
  Layer:ILayer;
  FormID:integer;
  Key: Word;
begin
 if FPaintFlag then Exit;
{$IFDEF Demo}
 WriteDblClickControlMacros(Sender);
{$ENDIF}
 with Sender as TStringGrid do
 begin
  If not(Row>0) then Exit;
  I:=Row-1;
  LayerE:=FSpatialModel.Layers.Item[I];
  Layer:=LayerE as ILayer;

  if(DM_GetKeyState(VK_MENU)<0) then begin
   FSpatialModel.CurrentLayer:=Layer;
  end;

  Server:=Get_DataModelServer as IDataModelServer;
  DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
  case Col of
  2..5:
    DMOperationManager.StartTransaction(nil, leoAdd, rsChangeLayerProperty);
  end;

  case Col of
   1:begin
       bt_SetCurLayer.Click;
     end;
   2:begin
       Layer.Visible:= SetLayersItem(2,Row);
       CallRefresh(rfFrontBack);
     end;
   3:begin
       Layer.Selectable:=SetLayersItem(3,Row);
     end;
   4:begin
       D:=Layer.Style;
       inc(D);
       if D=5 then
         D:=6
       else
       if D=7 then
         D:=1;
       Layer.Style:=D;
       sgLayers.Invalidate;
       CallRefresh(rfFrontBack);
     end;
   5:begin
       If ColorDialog1.Execute then begin
{$IFDEF Demo}
           FormID:=Get_FormID;
           (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
                -1, -1, meMouseMove, ColorDialog1.Color, I, '');
           (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
                FormID, -1, ColorDialogEventId, ColorDialog1.Color, I, '');
{$ENDIF}
         Layer.Color := ColorDialog1.Color;
         sgLayers.Invalidate;
         CallRefresh(rfFrontBack);
       end;
     end;
   7:begin
       Key:=VK_RETURN;
       sgLayersKeyDown(sgLayers,  Key, []);
     end;
   end; // case
 end;

end;

procedure TDMDraw.PanelHorizMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   if FDrawRangeMarksFlag then begin
     FDrawRangeMarksFlag:=False;       // сброс линий
     FPainter.DrawRangeMarks;
   end;
end;

procedure TDMDraw.DelLayerClick(Sender: TObject);
var
 aString:string;
 LayerE:IDMElement;
 Layer:ILayer;
 Res:word;
begin
    LayerE:=FSpatialModel.Layers.Item[sgLayers.Row-1];
    Layer:=LayerE as ILayer;
    if not Layer.CanDelete then begin
      ShowMessage('Тематический слой   "'
             +(LayerE.name)+'" не может быть удален');
      CallRefresh(rfFast);
      Exit;
    end;

    aString:=IntToStr(Layer.SpatialElements.Count);
    Res:=MessageDlg('Тематический слой  "'
             +(LayerE.name)+'", содержащий '+aString+' элементов.'#10#13''
             +'Вы действительно хотите его удалить?',
              mtWarning,mbOkCancel, 0);
    CallRefresh(rfFast);
  If Res=mrOk then
    DeleteLayer(Sender);
end;

function TDMDraw.DoAction(ActionCode: integer):WordBool;
var
  aGraphicFileName:string;
  DMDocument:IDMDocument;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  DMOperationManager:IDMOperationManager;
  OperationCode:integer;
  Server:IDataModelServer;
  FormID:integer;
begin
  Result:=False;
  FormID:=Get_FormID;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;

  if (GetDataModel.State and dmfFrozen)<>0 then Exit;
  if not Visible then Exit;

  DMOperationManager:=DMDocument as IDMOperationManager;
  SMDocument:=DMDocument as ISMDocument;
  SMOperationManager:=DMDocument as ISMOperationManager;
  if ActionCode<100 then
    case ActionCode of
    dmbaImportRaster:
      begin
         LoadRasterImage(aGraphicFileName);
         if aGraphicFileName<>'' then begin
           ShowMessage('Укажите координаты двух противоположных углов рамки,'#13+
                       ' в которую следует вписать растровое изображение');
{$IFDEF Demo}
           FormID:=Get_FormID;
           (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrChangePrevRecord,
                -1, -1, -1, -1, 500, '');
           (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
                -1, -1, meKeyDown, -1, -1, aGraphicFileName);
           (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
                FormID, -1, ActionCode, -1, -1, aGraphicFileName);
{$ENDIF}
           SMOperationManager.PictureFileName:=aGraphicFileName;
           SMOperationManager.StartOperation(smoCreateImageRect);
           Result:=True;
         end;
      end;
    dmbaImportVector:
      begin
        LoadVectorImage(aGraphicFileName);
        if aGraphicFileName<>'' then begin
{$IFDEF Demo}
          (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrChangePrevRecord,
                -1, -1, -1, -1, 500, '');
          (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
               -1, -1, meKeyDown, -1, -1, aGraphicFileName);
          (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrDialogEvent,
               FormID, -1, ActionCode, -1, -1, aGraphicFileName);
{$ENDIF}
          (DMDocument.DataModel as IDataModel).Import(aGraphicFileName);
        end;
      end;
    dmbaPrint:
      begin
        if frmDrawPrintOptions=nil then
          frmDrawPrintOptions:=TfrmDrawPrintOptions.Create(Self);
        if frmDrawPrintOptions.ShowModal=mrOK then begin
          CallRefresh(rfFast);
          PrintPainter(frmDrawPrintOptions.CanvasTag)
        end else
          CallRefresh(rfFast);
      end;
    else
      Result:=inherited DoAction(ActionCode);
    end
  else
  if (ActionCode<1000) and
     (ActionCode>=800) then begin
    OperationCode:=ActionCode-800;

    Get_DMEditorX.ActiveForm:=Self as IDMForm;

    if not (OperationCode in [smoZoomIn, smoZoomOut, smoViewPan, smoLastView, smoZoomSelection,
              smoSnapNone, smoSnapToNode,smoSnapToNearestOnLine,
              smoSnapToMiddleOfLine, smoSnapOrtToLine,
              smoRedraw, smoSideView, smoPalette]) then begin
      if not (SMOperationManager.OperationCode in [
        smoSelectAll,
        smoSelectCoordNode, smoSelectVolume,
        smoSelectLine, smoSelectVerticalLine,
        smoSelectClosedPolyline, smoSelectVerticalArea,
        smoSelectImage,smoSelectLabel,
        smoBuildVerticalArea, smoBuildVolume, smoBuildPolylineObject,
        smoDivideVolume, smoOutlineSelected, smoBuildSectors]) then
      SMOperationManager.StopOperation(0)
    end else
    if (OperationCode in [smoLastView, smoZoomSelection]) and
       (SMOperationManager.OperationStep<=0) then
     DMOperationManager.StartTransaction(nil, leoAdd, rsChangeView);
    case OperationCode of
    smoSnapNone,
    smoSnapToNode,
    smoSnapToNearestOnLine,
    smoSnapToMiddleOfLine,
    smoSnapToLocalGrid,
    smoSnapOrtToLine:
      begin
        SMOperationManager.SnapMode:=OperationCode;
        Result:=True;
      end;
    smoRedraw:
      begin
        CallRefresh(rfFrontBack);
        SMDocument.MouseDrag;
        Result:=True;
      end;
    smoLastView:
      begin
        SMDocument.RestoreView;
        CallRefresh(rfFrontBack);
        Result:=True;
      end;
    smoZoomSelection:
      begin
        SMDocument.ZoomSelection;
        CallRefresh(rfFrontBack);
        Result:=True;
      end;
    smoCrossline:
      begin
        SMDocument.ShowAxesMode:=
          not SMDocument.ShowAxesMode;
        SMDocument.ShowAxes;
        Result:=True;
      end;
    smoSideView:
      begin
        if PanelVert.Height>1 then begin
          FOldPanelVertHeight:=PanelVert.Height;
          PanelVert.Height:=1;
        end else
          PanelVert.Height:=FOldPanelVertHeight;
        CallRefresh(rfFrontBack);
        Result:=True;
      end;
    smoPalette:
      begin
        if PanelInfo.Width>1 then begin
           FOldPaletteWidth:=PanelInfo.Width;
          PanelInfo.Width:=1;
        end else
           PanelInfo.Width:=FOldPaletteWidth;
        Result:=True;
      end;
    else
      begin
        SMOperationManager.StartOperation(OperationCode);
        Result:=True;
      end;
    end;

    case OperationCode of
    smoDeleteSelected:
      SMOperationManager.DoOperationStep(0);
    end;

    case OperationCode of
    smoCreateLine,
    smoCreatePolyLine,
    smoCreateClosedPolyLine,
    smoCreateRectangle,
    smoCreateCurvedLine,
    smoCreateEllipse,
    smoCreateCoordNode:
        DMDocument.ClearSelection(nil);
    end;
  end;

end;

procedure TDMDraw.btDelViewClick(Sender: TObject);
var
 ViewE:IDMElement;
 Res:word;
 SpatialModel2:ISpatialModel2;
 Server:IDataModelServer;
 DMOperationManager:IDMOperationManager;
 SMDocument:ISMDocument;
begin
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  if sgViews.Row>SpatialModel2.Views.Count-1 then begin
    SetViews;
    Exit;
  end;

  if sgViews.Row>0 then begin
    ViewE:=SpatialModel2.Views.Item[sgViews.Row];
    Res:=MessageDlg('Вид  "'
             +(sgViews.Cells[1,sgViews.Row])+'"'#10#13''
             +'Вы действительно хотите его удалить?',
              mtWarning,mbOkCancel, 0);
    If Res=mrOk then begin

      Server:=Get_DataModelServer as IDataModelServer;
      DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
      SMDocument:=DMOperationManager as ISMDocument;
      DMOperationManager.StartTransaction(nil, leoDelete, rsDeleteView);
      DMOperationManager.DeleteElement( nil, nil, ltOneToMany, ViewE);

      SetViews;                    //отобразить в таб.видов
    end
  end else
    MessageDlg('Базовый вид ("Вид по умолчанию")'#10#13'удалять нельзя',
            mtWarning,[mbOk], 0);
end;

procedure TDMDraw.sgViewsDblClick(Sender: TObject);
var
 aParam:integer;
 SpatialModel2:ISpatialModel2;
 DMOperationManager:IDMOperationManager;
 ViewE:IDMElement;
begin
 if FPaintFlag then Exit;

{$IFDEF Demo}
 WriteDblClickControlMacros(Sender);
{$ENDIF}

 SpatialModel2:=FSpatialModel as ISpatialModel2;
 with Sender as TStringGrid do
 begin
  If not(Row>0) then Exit;
  aParam:=(SpatialModel2.Views.Item[Row] as IView).StoredParam;
  case Col of
   1:btRestoreView.Click;
   2:If sgViews.Cells[2,Row]='+' then
      begin aParam :=aParam-1;
          sgViews.Cells[2,Row]:='-';end
      else begin aParam :=aParam+1;
          sgViews.Cells[2,Row]:='+'; end;
   3:If sgViews.Cells[3,Row]='+' then
      begin aParam :=aParam-2;
          sgViews.Cells[3,Row]:='-';end
      else begin aParam :=aParam+2;
          sgViews.Cells[3,Row]:='+'; end;
   4:If sgViews.Cells[4,Row]='+'
      then begin aParam :=aParam-4;
                 sgViews.Cells[4,Row]:='-'; end
      else begin aParam :=aParam+4;
           sgViews.Cells[4,Row]:='+';end;
   end;

  DMOperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoChangeFieldValue, rsChangeView);
  ViewE:=SpatialModel2.Views.Item[Row];
  DMOperationManager.ChangeFieldValue(ViewE, ord(vStoredParam), True, aParam);
 end;
end;

procedure TDMDraw.DeleteSelected;
var
  SMOperationManager:ISMOperationManager;
begin
  SMOperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as ISMOperationManager;
  SMOperationManager.StartOperation(smoDeleteSelected);
end;

procedure TDMDraw.cb_SelectListClick(Sender: TObject);
begin
  OnChangeSelection;
end;

procedure TDMDraw.SelectLayerChange(Sender: TObject);
var
 aDocument:IDMDocument;
 aCount:integer;
 aElement:IDMElement;
 aElement0S:ISpatialElement;
 j,aItemIndex, aTag:integer;
 DMOperationManager:IDMOperationManager;
 Server:IDataModelServer;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  DMOperationManager:=aDocument as IDMOperationManager;
  aCount:= aDocument.SelectionCount;

  DMOperationManager.StartTransaction(nil, 0, rsChangeLayerProperty);

  aTag:=(Sender as TComponent).Tag;
  for j:=0 to aCount-1 do begin
   aElement:=aDocument.SelectionItem[j] as IDMElement;
   if aElement.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
   case aTag of
     1: begin
         aItemIndex:=(Sender as TComboBox).ItemIndex;
         aElement.Parent := FSpatialModel.Layers.Item[aItemIndex];
        end;
   end;
  end;
  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.LoadVectorImage(var aGraphicFileName:string);
var
  Document:IDMDocument;
  S:string;
  KeyboardState:TKeyboardState;
  Server:IDataModelServer;
  OldForceCurrentDirectory:boolean;
begin
  OldForceCurrentDirectory:=ForceCurrentDirectory;
  ForceCurrentDirectory:=True;
  try
  Server:=Get_DataModelServer as IDataModelServer;

  Document:=Server.CurrentDocument;
  if Uppercase(Server.InitialDir)<>'DEMO' then
    OpenDialog1.InitialDir:=Server.InitialDir
  else
    OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName)+'DEMO';

  OpenDialog1.DefaultExt := GraphicExtension(TBitmap);
  S := 'AutoCAD DXF (*.dxf)|*.dxf';
  OpenDialog1.Filename := '';
  OpenDialog1.Filter := S;

  if (Document.State and dmfDemo)<>0 then begin
    DM_GetKeyboardLayoutName(FOldLayoutName);
    DM_LoadKeyboardLayout('00000409',    //English
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

    DM_GetKeyboardState(KeyboardState);
    KeyboardState[VK_CAPITAL]:=0;
    DM_SetKeyboardState(KeyboardState);
  end;

  if OpenDialog1.Execute then begin
     aGraphicFileName:=OpenDialog1.FileName;
     OpenDialog1.InitialDir:=ExtractFilePath(aGraphicFileName);
     Server.InitialDir:=OpenDialog1.InitialDir;
  end;

  if (Document.State and dmfDemo)<>0 then begin
     DM_LoadKeyboardLayout(FOldLayoutName,
       KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;
 finally
   ForceCurrentDirectory:=OldForceCurrentDirectory;
 end;
end;

procedure TDMDraw.ed_PointChangeKeyPress(Sender: TObject; var Key: Char);
var
 i,C, m, k:integer;
 D:double;
 aValue:double;
 aEdit:TEdit;
 aDocument:IDMDocument;
 aNode:ICoordNode;
 Line:ILine;
 NodeE, LineE, AreaE:IDMElement;
 aElement0S:ISpatialElement;
 DMOperationManager:IDMOperationManager;
 AreaList:TList;
begin
  if Key=',' then
    Key:='.';
    
  if Key<>#13 then Exit;

 aEdit:=(Sender as TEdit);
 if not aEdit.Modified then Exit;

 aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
 if aDocument.SelectionCount=0 then Exit;

 DMOperationManager:=aDocument as IDMOperationManager;
 DMOperationManager.StartTransaction(nil, 0, rsPointChange);          //подготовка "отката"

  Val(aEdit.Text,D,C);
  if (C<>0) then begin
    aEdit.Font.Color:=clRed;
    Exit end
  else
    aEdit.Font.Color:=0;

  aValue:=D*100;

 AreaList:=TList.Create;
 for i:=0 to aDocument.SelectionCount-1 do begin    // i-й элемент
  NodeE:=aDocument.SelectionItem[i] as IDMElement;
  if NodeE.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
  if NodeE.QueryInterface(ICoordNode, aNode)=0 then begin
   case aEdit.Tag of
    1:begin aNode.X := aValue;
      ed_X.Text := Format('%0.2f',[aNode.X/100]) end;
    2:begin aNode.Y := aValue;
      ed_Y.Text := Format('%0.2f',[aNode.Y/100]) end;
    3:begin aNode.Z := aValue;
      ed_Z.Text := Format('%0.2f',[aNode.Z/100]) end;
   else
   end;
  end;

   if NodeE.Ref<>nil then
     DMOperationManager.UpdateCoords(NodeE.Ref);
   for m:=0 to aNode.Lines.Count-1 do begin
     LineE:=aNode.Lines.Item[m];
     if LineE.Ref<>nil then
       DMOperationManager.UpdateCoords(LineE.Ref);
     Line:=LineE as ILine;
     for k:=0 to LineE.Parents.Count-1 do begin
       AreaE:=LineE.Parents.Item[k];
       if AreaList.IndexOf(pointer(AreaE))=-1 then
         AreaList.Add(pointer(AreaE));
     end;
   end;
 end;

  for i:=0 to AreaList.Count-1 do begin
    AreaE:=IDMElement(AreaList[i]);
    if AreaE.Ref<>nil then
      DMOperationManager.UpdateCoords(AreaE.Ref);
  end;
  AreaList.Free;

  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.ed_AreaChangeKeyPress(Sender: TObject; var Key: Char);
var
 C:integer;
 D:double;
 aValue, aValueOld:double;
 aEdit:TEdit;
 aDocument:IDMDocument;
 aNode:ICoordNode;
 aElement0, aElement, NodeE, aLineE, AreaE:IDMElement;
 aElement0S:ISpatialElement;
 aElement0L, Line, aLine:ILine;
 aArea:IArea;
 DMOperationManager:IDMOperationManager;
 i, j, aCount, aTag, k, m:integer;
 EqualZFlag:boolean;
 AreaList:TList;
begin
  if Key=',' then
    Key:='.';

 if Key<>#13 then Exit;

 aEdit:=(Sender as TEdit);
 if not aEdit.Modified then Exit;

 aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
 if aDocument.SelectionCount=0 then Exit;

 Val(aEdit.Text,D,C);
 if (C<>0) then begin
   aEdit.Font.Color:=clRed;
   Exit end
 else
   aEdit.Font.Color:=clBlack;

  aValue:=D*100;


 DMOperationManager:=aDocument as IDMOperationManager;
 DMOperationManager.StartTransaction(nil, 0, rsAreaChange);          //подготовка "отката"
//___________
 aValueOld:=0;
 aCount:=0;
 AreaList:=TList.Create;
 for i:=0 to aDocument.SelectionCount-1 do begin    // i-й элемент
   aElement0:=aDocument.SelectionItem[i] as IDMElement;
   if aElement0.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
   if aElement0.QueryInterface(IArea, aArea)=0 then begin
     if aArea.MinZ=aArea.MaxZ Then
       EqualZFlag:=true
     else EqualZFlag:=False;

     aTag:=aEdit.Tag;
   case aTag of
   1:begin
      aValueOld:= aArea.MinZ;
      aArea.MinZ:= aValue;
      ed_MinZ.Text := Format('%0.2f',[aValue/100]);
      if EqualZFlag then begin
        ed_MaxZ.Text:=ed_MinZ.Text;
        aArea.MaxZ := aValue end;
      aCount:=aArea.BottomLines.Count;
     end;
   2:begin
      aValueOld:= aArea.MaxZ;
      aArea.MaxZ := aValue;
      ed_MaxZ.Text := Format('%0.2f',[aValue/100]);
      if EqualZFlag then begin
        ed_MinZ.Text:=ed_MaxZ.Text;
        aArea.MinZ := aValue end;
      aCount:=aArea.TopLines.Count;
     end;
   3:begin
//     if aArea.IsVertical then
      if (aArea.BottomLines.Count=1) and
         (aArea.TopLines.Count=1) then begin
       Line:=aArea.TopLines.Item[0]as ILine;
       aValueOld:= Line.Length;
       Line.Length := aValue;
       Line:=aArea.BottomLines.Item[0]as ILine;
       Line.Length := aValue;
       ed_AreaSize1.Text := Format('%0.2f',[aValue/100]);

       aNode:=Line.C0;
       NodeE:=aNode as IDMElement;
       if NodeE.Ref<>nil then
         DMOperationManager.UpdateCoords(NodeE.Ref);
       for m:=0 to aNode.Lines.Count-1 do begin
         aLineE:=aNode.Lines.Item[m];
         if aLineE.Ref<>nil then
           DMOperationManager.UpdateCoords(aLineE.Ref);
         aLine:=aLineE as ILine;
         for k:=0 to aLineE.Parents.Count-1 do begin
           AreaE:=aLineE.Parents.Item[k];
           if AreaList.IndexOf(pointer(AreaE))=-1 then
             AreaList.Add(pointer(AreaE));
         end;
       end;

       aNode:=Line.C1;
       NodeE:=aNode as IDMElement;
       if NodeE.Ref<>nil then
         DMOperationManager.UpdateCoords(NodeE.Ref);
       for m:=0 to aNode.Lines.Count-1 do begin
         aLineE:=aNode.Lines.Item[m];
         if aLineE.Ref<>nil then
           DMOperationManager.UpdateCoords(aLineE.Ref);
         aLine:=aLineE as ILine;
         for k:=0 to aLineE.Parents.Count-1 do begin
           AreaE:=aLineE.Parents.Item[k];
           if AreaList.IndexOf(pointer(AreaE))=-1 then
             AreaList.Add(pointer(AreaE));
         end;
       end; // for m:=0 to aNode.Lines.Count-1
      end; // if (aArea.TopLines.Count=1)and(aArea.BottomLines.Count=1)
     end;
   else
   end; // case

   for j:=0 to aCount-1 do begin
   case aTag of
    1:aElement:=aArea.BottomLines.Item[j];
    2:aElement:=aArea.TopLines.Item[j];
    else
   end;
   if aElement.QueryInterface(ILine, aElement0L)=0 then begin
    if aElement0L.C0.Z=aValueOld then begin
     aElement0L.C0.Z :=aValue;
     aElement:=(aElement0L.C0 as IDMElement);
     if aElement.QueryInterface(ICoordNode, aNode)=0 then aNode.Z :=aValue;
    end;
    if aElement0L.C1.Z=aValueOld then begin
      aElement0L.C1.Z :=aValue;
      aElement:=(aElement0L.C1 as IDMElement);
      if aElement.QueryInterface(ICoordNode, aNode)=0 then aNode.Z :=aValue;
    end;
   end;
  end;
 end;
 end;

 for i:=0 to AreaList.Count-1 do begin
   AreaE:=IDMElement(AreaList[i]);
   if AreaE.Ref<>nil then
     DMOperationManager.UpdateCoords(AreaE.Ref);
 end;
 AreaList.Free;

  CallRefresh(rfFrontBack);
end;


procedure TDMDraw.ed_VolumeChangeKeyPress(Sender: TObject; var Key: Char);
var
 C:integer;
 D:double;
 aValue, aValueOld:double;
 aEdit:TEdit;
 aDocument:IDMDocument;
 aNode:ICoordNode;
 aElement0, aElement:IDMElement;
 aElement0S:ISpatialElement;
 aElement0L:ILine;
 aVolume:IVolume;
 aArea:IArea;
 DMOperationManager:IDMOperationManager;
 i, j, k, aCount, aLineCount, aTag:integer;
begin
  if Key=',' then
    Key:='.';
    
 if Key<>#13 then Exit;

 aEdit:=(Sender as TEdit);
 if not aEdit.Modified then Exit;

 aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
 if aDocument.SelectionCount=0 then Exit;

 Val(aEdit.Text,D,C);
 if (C<>0) then begin
  aEdit.Font.Color:=clRed;
  Exit end
 else
  aEdit.Font.Color:=clBlack;

 aValue:=D*100;
 aValueOld:=0;
 aCount:=0;
 aLineCount:=0;

 DMOperationManager:=aDocument as IDMOperationManager;
 DMOperationManager.StartTransaction(nil, 0, rsVolumeChange);          //подготовка "отката"
 for i:=0 to aDocument.SelectionCount-1 do begin    // i-й элемент
  aElement0:=aDocument.SelectionItem[i] as IDMElement;
  if aElement0.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
  if aElement0.QueryInterface(IVolume, aVolume)=0 then begin
   aTag:=aEdit.Tag;
   case aTag of
    1:begin
      aValueOld:= aVolume.MinZ;
      aVolume.MinZ:= aValue;
      ed_VolumeMinZ.Text := Format('%0.2f',[aValue/100]);
      aCount:=aVolume.BottomAreas.Count;
      end;
    2:begin
      aValueOld:= aVolume.MaxZ;
      aVolume.MaxZ := aValue;
      ed_VolumeMaxZ.Text := Format('%0.2f',[aValue/100]);
      aCount:=aVolume.TopAreas.Count;
     end;
    else
   end;

   case aTag of
    1:aCount:=aVolume.BottomAreas.Count;
    2:aCount:=aVolume.TopAreas.Count;
    else
   end;

   for j:=0 to aCount-1 do begin
    case aTag of
     1:aElement0:=aVolume.BottomAreas.Item[j];
     2:aElement0:=aVolume.TopAreas.Item[j];
     else
    end;
    if aElement0.QueryInterface(IArea, aArea)=0 then begin
     case aTag of
      1:aLineCount:=aArea.BottomLines.Count;
      2:aLineCount:=aArea.TopLines.Count;
      else
     end;
    for k:=0 to aLineCount-1 do begin
     case aTag of
      1:aElement:=aArea.BottomLines.Item[k];
      2:aElement:=aArea.TopLines.Item[k];
      else
     end;
     if aElement.QueryInterface(ILine, aElement0L)=0 then begin
      if aElement0L.C0.Z=aValueOld then begin
       aElement0L.C0.Z :=aValue;
       aElement:=(aElement0L.C0 as IDMElement);
       if aElement.QueryInterface(ICoordNode, aNode)=0 then aNode.Z :=aValue;
      end;
      if aElement0L.C1.Z=aValueOld then begin
       aElement0L.C1.Z :=aValue;
       aElement:=(aElement0L.C1 as IDMElement);
       if aElement.QueryInterface(ICoordNode, aNode)=0 then aNode.Z :=aValue;
      end;
     end;
    end;
   end;
  end;
 end;

  CallRefresh(rfFrontBack);
 end;
end;

procedure TDMDraw.ed_YDblClick(Sender: TObject);
//_____________________________________________________
//      усреднение  коорд.для выделенных элем.
{ TODO : нужно изменить имя на более общее }
//_____________________________________________________
var
 i,aCount, m, k:integer;
 aValue:double;
 aEdit:TEdit;
 aDocument:IDMDocument;
 aNode:ICoordNode;
 Line:ILine;
 aElement0, NodeE, LineE, AreaE:IDMElement;
 aElement0S:ISpatialElement;
 DMOperationManager:IDMOperationManager;
 AreaList:TList;
begin

 aEdit:=(Sender as TEdit);

 aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
 if aDocument.SelectionCount=0 then Exit;

 DMOperationManager:=aDocument as IDMOperationManager;
 DMOperationManager.StartTransaction(nil, 0, rsAlingPoint);          //подготовка "отката"
 aCount:=aDocument.SelectionCount;
 aValue:=0;
 for i:=0 to aCount-1 do begin    // i-й элемент
  aElement0:=aDocument.SelectionItem[i] as IDMElement;
  if aElement0.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
  if aElement0.QueryInterface(ICoordNode, aNode)=0 then begin
   case aEdit.Tag of
    1:aValue:=aValue+aNode.X;
    2:aValue:=aValue+aNode.Y;
    3:aValue:=aValue+aNode.Z;
   else
   end;
  end;
 end;

 aValue:=aValue/aCount;
 AreaList:=TList.Create;
 for i:=0 to aCount-1 do begin    // i-й элемент
   NodeE:=aDocument.SelectionItem[i] as IDMElement;
   if NodeE.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
   if NodeE.QueryInterface(ICoordNode, aNode)=0 then begin
     case aEdit.Tag of
     1:begin aNode.X := aValue;
         ed_X.Text := Format('%0.2f',[aNode.X/100]) end;
      2:begin aNode.Y := aValue;
         ed_Y.Text := Format('%0.2f',[aNode.Y/100]) end;
      3:begin aNode.Z := aValue;
         ed_Z.Text := Format('%0.2f',[aNode.Z/100]) end;
      else
      end;
   end;

   if NodeE.Ref<>nil then
     DMOperationManager.UpdateCoords(NodeE.Ref);
   for m:=0 to aNode.Lines.Count-1 do begin
     LineE:=aNode.Lines.Item[m];
     if LineE.Ref<>nil then
       DMOperationManager.UpdateCoords(LineE.Ref);
     Line:=LineE as ILine;
     for k:=0 to LineE.Parents.Count-1 do begin
       AreaE:=LineE.Parents.Item[k];
       if AreaList.IndexOf(pointer(AreaE))=-1 then
         AreaList.Add(pointer(AreaE));
     end;
   end;
 end;

  for i:=0 to AreaList.Count-1 do begin
    AreaE:=IDMElement(AreaList[i]);
    if AreaE.Ref<>nil then
      DMOperationManager.UpdateCoords(AreaE.Ref);
  end;
  AreaList.Free;

  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.ed_CoordDblClick(Sender: TObject);
 { TODO :
нужно изменить имя на более общее
-это проц.для элем.линии-
и нужно создать то же для обл.и объема }
var
 i,aCount, k, m:integer;
 aValue:double;
 aEdit:TEdit;
 aDocument:IDMDocument;
 aElement0, NodeE, LineE, aLineE, AreaE:IDMElement;
 aElement0S:ISpatialElement;
 Line, aLine:ILine;
 aNode:ICoordNode;
 DMOperationManager:IDMOperationManager;
 AreaList:TList;
begin

 aEdit:=(Sender as TEdit);

 aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
 aCount:=aDocument.SelectionCount;
 if aCount=0 then Exit;

 DMOperationManager:=aDocument as IDMOperationManager;
 DMOperationManager.StartTransaction(nil, 0, rsAlingPoint);          //подготовка "отката"
 aValue:=0;
 for i:=0 to aCount-1 do begin    // i-й элемент
  aElement0:=aDocument.SelectionItem[i] as IDMElement;
  if aElement0.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
  if aElement0.QueryInterface(ILine, Line)=0 then begin
   case aEdit.Tag of
    1: aValue:= aValue+Line.C0.X;
    2: aValue:= aValue+Line.C0.Y;
    3: aValue:= aValue+Line.C1.Z ;
    4: aValue:= aValue+Line.C1.X ;
    5: aValue:= aValue+Line.C1.Y ;
    6: aValue:= aValue+Line.C1.Z ;
    7: aValue:= aValue+Line.Length ;
    8: aValue:= aValue+Line.ZAngle;
    else
   end;
  end;
 end;
 aValue:= aValue/aCount;
 AreaList:=TList.Create;
 for i:=0 to aCount-1 do begin    // i-й элемент
   LineE:=aDocument.SelectionItem[i] as IDMElement;
   if LineE.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
   if LineE.QueryInterface(ILine, Line)=0 then begin
     case aEdit.Tag of
     1:begin Line.C0.X := aValue;
        ed_X0.Text := Format('%0.2f',[Line.C0.X/100]) end;
     2:begin Line.C0.Y := aValue;
        ed_Y0.Text := Format('%0.2f',[Line.C0.Y/100]) end;
     3:begin Line.C0.Z := aValue;
        ed_Z0.Text := Format('%0.2f',[Line.C0.Z/100]) end;
     4:begin Line.C1.X := aValue;
        ed_X1.Text := Format('%0.2f',[Line.C1.X/100]) end;
     5:begin Line.C1.Y := aValue;
        ed_Y1.Text := Format('%0.2f',[Line.C1.Y/100]) end;
     6:begin Line.C1.Z := aValue;
        ed_Z1.Text := Format('%0.2f',[Line.C1.Z/100]) end;
     7:begin Line.Length := aValue;
        ed_Length.Text:= Format('%0.2f',[Line.Length/100]) end;
     8:begin Line.ZAngle := aValue/100;
        ed_ZAngle.Text:= Format('%0.2f',[Line.ZAngle]) end;
     else
     end;
   end;

   aNode:=Line.C0;
   NodeE:=aNode as IDMElement;
   if NodeE.Ref<>nil then
     DMOperationManager.UpdateCoords(NodeE.Ref);
   for m:=0 to aNode.Lines.Count-1 do begin
     aLineE:=aNode.Lines.Item[m];
     if aLineE.Ref<>nil then
       DMOperationManager.UpdateCoords(aLineE.Ref);
     aLine:=aLineE as ILine;
     for k:=0 to aLineE.Parents.Count-1 do begin
       AreaE:=aLineE.Parents.Item[k];
       if AreaList.IndexOf(pointer(AreaE))=-1 then
         AreaList.Add(pointer(AreaE));
     end;
   end;

   aNode:=Line.C1;
   NodeE:=aNode as IDMElement;
   if NodeE.Ref<>nil then
     DMOperationManager.UpdateCoords(NodeE.Ref);
   for m:=0 to aNode.Lines.Count-1 do begin
     aLineE:=aNode.Lines.Item[m];
     if aLineE.Ref<>nil then
       DMOperationManager.UpdateCoords(aLineE.Ref);
     aLine:=aLineE as ILine;
     for k:=0 to aLineE.Parents.Count-1 do begin
       AreaE:=aLineE.Parents.Item[k];
       if AreaList.IndexOf(pointer(AreaE))=-1 then
         AreaList.Add(pointer(AreaE));
     end;
   end;

 end;

 for i:=0 to AreaList.Count-1 do begin
   AreaE:=IDMElement(AreaList[i]);
   if AreaE.Ref<>nil then
     DMOperationManager.UpdateCoords(AreaE.Ref);
 end;
 AreaList.Free;


 CallRefresh(rfFrontBack);
end;

function TDMDraw.Get_ToolButtonCount: Integer;
begin
  Result:=ButtonArrayCount
end;

function TDMDraw.Get_ToolButtonImage(Index:integer): WideString;
begin
  Result:=ButtonImageArray[Index]
end;

function TDMDraw.Get_ToolButtonImageCount: Integer;
begin
  Result:=ButtonImageArrayCount
end;

procedure TDMDraw.GetToolButtonProperties(Index:integer;
  var aToolBarTag, aButtonImageIndex, aButtonTag, aStyle, aMode, aGroup: Integer;
  var aHint: WideString);
begin
  try
  aToolBarTag:=ButtonArray[Index, 0];
  aButtonImageIndex:=ButtonArray[Index, 1];
  aButtonTag:=ButtonArray[Index, 2];
  aStyle:=ButtonArray[Index, 3];
  aMode:=ButtonArray[Index, 4];
  aGroup:=ButtonArray[Index, 5];
  aHint:=ButtonHintArray[Index];
  except
    raise
  end;
end;

function TDMDraw.Get_InstanceHandle: Integer;
begin
  Result:=HInstance
end;

procedure TDMDraw.bt_SetCurLayerClick(Sender: TObject);
var
  aRow:integer;
  CurrentLayerE:IDMElement;
begin
  aRow:=sgLayers.Row-1;
  CurrentLayerE:=FSpatialModel.Layers.Item[aRow];

  FSpatialModel.CurrentLayer:=CurrentLayerE as ILayer;
  sgLayers.Invalidate;
end;

procedure TDMDraw.bt_SetAllClick(Sender: TObject);
var
 j,aCol:integer;
begin
  aCol:=sgLayers.Col;
 for j:=0 to FSpatialModel.Layers.Count-1 do begin
  case aCol of
    2:(FSpatialModel.Layers.Item[j] as ILayer).Visible:=True;
    3:(FSpatialModel.Layers.Item[j] as ILayer).Selectable:=True;
    else
     Exit;
  end;
  sgLayers.Cells[aCol,j+1]:='+';
 end;
  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.bt_SetOneClick(Sender: TObject);
var
 j,aCol,aRow:integer;
begin
  aCol:=sgLayers.Col;

  for j:=0 to FSpatialModel.Layers.Count-1 do begin
    case aCol of
     2: (FSpatialModel.Layers.Item[j] as ILayer).Visible:=False;
     3: (FSpatialModel.Layers.Item[j] as ILayer).Selectable:=False;
     else
       Exit;
    end;
    sgLayers.Cells[aCol,j+1]:='-';
  end;
  aRow:=sgLayers.Row;
  case aCol of
    2:(FSpatialModel.Layers.Item[aRow-1] as ILayer).Visible:=True;
    3:(FSpatialModel.Layers.Item[aRow-1] as ILayer).Selectable:=True;
  end;
  sgLayers.Cells[aCol,aRow]:='+';
  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.s_but_CrossLineClick(Sender: TObject);
var
  SMDocument:ISMDocument;
begin
 SMDocument:=
  (Get_DataModelServer as IDataModelServer).CurrentDocument as ISMDocument;
 SMDocument.ShowAxesMode:=s_but_CrossLine.Down;
 SMDocument.ShowAxes;
 DoAction(smoCrossline);
end;

procedure TDMDraw.Panel0CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
 Resize:=True;
 PanelVert.Height:=PanelVert.Height*NewHeight div Panel0.Height;
end;

procedure TDMDraw.Panel0Resize(Sender: TObject);
begin
//  PanelVert.Height:=round((1-FHVRatio)*Panel0.Height);
end;

procedure TDMDraw.btRestoreViewClick(Sender: TObject);
var
  aDataModel:IDataModel;
  SpatialModel2:ISpatialModel2;
  DMDocument:IDMDocument;
  SMDocument:ISMDocument;
  DMOperationManager:IDMOperationManager;
  ViewE:IDMElement;
  View, theView:IView;
  CurrX, CurrY, CurrZ:double;
  OldState:integer;
begin
  theView:=FPainter.ViewU as IView;
  if theView=nil then Exit;
  if FChangingView then Exit;
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  aDataModel:=SpatialModel2 as IDataModel;

  if sgViews.Row>SpatialModel2.Views.Count-1 then begin
    SetViews;
    Exit;
  end;

  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  SMDocument:=DMDocument as ISMDocument;
  DMOperationManager:=SMDocument as IDMOperationManager;

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfExecuting;
  try
  CurrZ:=SMDocument.CurrZ;
  ViewE:=SpatialModel2.Views.Item[sgViews.Row];
  View:=ViewE as IView;
  if (vspZ_ZMin_ZMax and View.StoredParam) <> 0 then begin
    theView.CZ:=View.CZ;
    CurrZ:=View.CurrZ0;
    theView.CurrZ0:=CurrZ;
    SMDocument.SetCurrXYZ(CurrZ, CurrZ, CurrZ);
    edZ.Text:=Format('%0.2f',[CurrZ/100]);
    theView.CZ:=CurrZ;
    theView.Zmin:=View.Zmin;
    theView.Zmax:=View.Zmax;
  end;
  if (vspX_Y_Scale and View.StoredParam) <> 0 then begin
    theView.CX:=View.CX;
    theView.CY:=View.CY;
    CurrX:=View.CurrX0;
    CurrY:=View.CurrY0;
    theView.CurrX0:=CurrX;
    theView.CurrY0:=CurrY;
    SMDocument.SetCurrXYZ(CurrX, CurrY, CurrZ);
    edX.Text:=Format('%0.2f',[CurrX/100]);
    edY.Text:=Format('%0.2f',[CurrY/100]);
    theView.RevScale:=View.RevScale;
  end;
  if (vspAngle_Dmin_Dmax and View.StoredParam) <> 0 then begin
    theView.Zangle:=View.Zangle;
    theView.Dmin:=View.Dmin;
    theView.Dmax:=View.Dmax;
    SpatialModel2.AreasOrdered:=False;
  end;

  if Assigned(FOnUpdateViewList) then
     FOnUpdateViewList(Self);

  FPainter.SetRangePix;
  SetHRangeMarks;
  SetVRangeMarks;
  SetRangeEditors;

  finally
    aDataModel.State:=aDataModel.State and not dmfExecuting;
  end;

  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.btUpdateViewClick(Sender: TObject);
var
  aView:IView;
  SpatialModel2:ISpatialModel2;
  StoredParam:integer;
begin
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  if sgViews.Row>SpatialModel2.Views.Count-1 then begin
    SetViews;
    Exit;
  end;
  aView:=SpatialModel2.Views.Item[sgViews.Row] as IView;
  StoredParam:=aView.StoredParam;
  aView.Duplicate(FPainter.ViewU as IView);
  aView.StoredParam:=StoredParam;

  if Assigned(FOnUpdateViewList) then
     FOnUpdateViewList(Self);

//  CallRefresh(rfFrontBack);
end;

procedure TDMDraw.RenameLayer;
var
  Server:IDataModelServer;
  DMOperationManager:IDMOperationManager;
begin
  if FSpatialModel.Layers.Item[sgLayers.Row-1].Name=sgLayers.Cells[1,sgLayers.Row] then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsChangeLayerProperty);
  FSpatialModel.Layers.Item[sgLayers.Row-1].Name :=sgLayers.Cells[1,sgLayers.Row];
  SetLayers;
end;

procedure TDMDraw.ShowLayerKinds;
begin
end;

procedure TDMDraw.sgLayersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FPaintFlag then Exit;

{$IFDEF Demo}
  WriteKeyDownMacros(Sender, Key);
{$ENDIF}

  case Key of
  VK_RETURN:
    begin
    case sgLayers.Col of
    1:RenameLayer;
    6:ChangeLineWidth;
    7:ShowLayerKinds;
    end;
  end;
  VK_INSERT:
    mi_AddLayer.Click;
  VK_DELETE:
    mi_DeleteLayer.Click;
  ord('N'):
    if Shift=[ssCtrl] then
      mi_RenameLayer.Click;
  end;
end;

procedure TDMDraw.sbZDownClick(Sender: TObject);
var
  S:string;
  Z :double;
  E:integer;
  Key:word;
begin
{$IFDEF Demo}
  WriteSpeedButtonDownMacros(Sender);
{$ENDIF}
  S:=edZ.Text;
  Val(S, Z, E);
  if E<>0 then Exit;
  Z:=Z-FIncrementZ;
  edZ.Text:=Format('%0.2f',[Z]);
  Key:=VK_F4;
  edXYZKeyDown(edZ, Key, []);
end;

procedure TDMDraw.sbZUpClick(Sender: TObject);
var
  S:string;
  Z :double;
  E:integer;
  Key:word;
begin
{$IFDEF Demo}
  WriteSpeedButtonUpMacros(Sender);
{$ENDIF}
  S:=edZ.Text;
  Val(S, Z, E);
  if E<>0 then Exit;
  Z:=Z+FIncrementZ;
  edZ.Text:=Format('%0.2f',[Z]);
  Key:=VK_F4;
  edXYZKeyDown(edZ, Key, []);
end;

procedure TDMDraw.edZDblClick(Sender: TObject);
begin
  if fmDZ=nil then begin
    fmDZ:=TfmDZ.Create(Self)
  end;
  fmDZ.IncrementZ:=FIncrementZ;
  if fmDZ.ShowModal=mrOK then
    FIncrementZ:=fmDZ.IncrementZ;
  CallRefresh(rfFast);
end;

procedure TDMDraw.btJoinLayerClick(Sender: TObject);
var
  j, j0:integer;
  SourceLayerE, DestLayerE:IDMElement;
  DMOperationManager:IDMOperationManager;
  Server:IDataModelServer;
begin
  if fmLayerList=nil then begin
    fmLayerList:=TfmLayerList.Create(Self);
  end;
  fmLayerList.lbLayers.Clear;

  for j:=0 to FSpatialModel.Layers.Count-1 do begin
    fmLayerList.lbLayers.Items.Add(FSpatialModel.Layers.Item[j].Name);
  end;

  if fmLayerList.ShowModal=mrOK then begin
    j0:=sgLayers.Row-1;
    SourceLayerE:=FSpatialModel.Layers.Item[j0];

    j:=fmLayerList.lbLayers.ItemIndex;
    DestLayerE:=FSpatialModel.Layers.Item[j];

    Server:=Get_DataModelServer as IDataModelServer;
    DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
    DMOperationManager.StartTransaction(nil, leoAdd, rsJoinLayer);

    JoinLayer(DestLayerE, SourceLayerE);
    
    Server.DocumentOperation(SourceLayerE, nil, leoDelete, 0);
  end;
  CallRefresh(rfFast);
end;

procedure TDMDraw.JoinLayer(const DestLayerE, SourceLayerE:IDMElement);
var
  SourceLayer:ILayer;
  DMOperationManager:IDMOperationManager;
  Server:IDataModelServer;
  Element:IDMElement;
  Document:IDMDocument;
  OldState:integer;
begin

  SourceLayer:=SourceLayerE as ILayer;

  Server:=Get_DataModelServer as IDataModelServer;
  Document:=Server.CurrentDocument as IDMDocument;
  DMOperationManager:=Document as IDMOperationManager;
  OldState:=Document.State;
  Document.State:=Document.State or dmfCopying;
  try
  while SourceLayer.SpatialElements.Count>0 do begin
    Element:=SourceLayer.SpatialElements.Item[0];
    Element.Parent:=DestLayerE;
  end;
  SourceLayerE.ClearOp;
  DMOperationManager.DeleteElement( nil, nil, ltOneToMany, SourceLayerE);
  finally
    Document.State:=OldState;
  end;
end;

procedure TDMDraw.sgLayersSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if FPaintFlag then Exit;
{$IFDEF Demo}
  WriteSelectCellMacros(Sender, aCol, aRow);
{$ENDIF}
  inherited;
  if (goEditing in sgLayers.Options) then begin
    if (sgLayers.Col=1) then
      RenameLayer
    else
    if (sgLayers.Col=6) then
      ChangeLineWidth;
    sgLayers.Options:=sgLayers.Options - [goAlwaysShowEditor];
    sgLayers.Options:=sgLayers.Options - [goEditing];
  end else
  if (aCol<>sgLayers.Col) or
     (aRow<>sgLayers.Row) then begin
    sgLayers.Options:=sgLayers.Options - [goAlwaysShowEditor];
    sgLayers.Options:=sgLayers.Options - [goEditing];
  end;
  if aCol=6 then
    sgLayers.Options:=sgLayers.Options + [goEditing];
  bt_SetAll.Enabled:=((aCol=2) or (aCol=3));
  bt_SetOne.Enabled:=((aCol=2) or (aCol=3));
end;

procedure TDMDraw.CheckDocumentState;
var
  j:integer;
  Server:IDataModelServer;
  DMOperationManager:IDMOperationManager;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
  if DMOperationManager=nil then Exit;

  lsTransactions.Clear;
  for j:=0 to DMOperationManager.TransactionCount-1 do begin
    lsTransactions.Items.Add(DMOperationManager.TransactionName[j])
  end;
  
  SetViews;
end;

procedure TDMDraw.lsTransactionsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  DMOperationManager:IDMOperationManager;
begin
  DMOperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      IDMOperationManager;
  if Index<=DMOperationManager.CurrentTransactionIndex then
    lsTransactions.Canvas.Font.Color:=clBlack
  else
    lsTransactions.Canvas.Font.Color:=clSilver;
  lsTransactions.Canvas.Brush.Color:=clWhite;
  lsTransactions.Canvas.FillRect(Rect);
  lsTransactions.Canvas.TextOut(Rect.Left, Rect.Top,
    Format('%d %s',[Index, lsTransactions.Items[Index]]));
end;

procedure TDMDraw.lsTransactionsDblClick(Sender: TObject);
var
  j0, N, j:integer;
  DMOperationManager:IDMOperationManager;
begin
  DMOperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      IDMOperationManager;
  j0:=lsTransactions.ItemIndex;
  N:=DMOperationManager.CurrentTransactionIndex;
  if j0<=N then
    for j:=j0 to N do
      DMOperationManager.Undo
  else
    for j:=N+1 to j0 do
      DMOperationManager.Redo
end;

procedure TDMDraw.edXYZKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  WPX, WPY, WPZ:double;
  Err1, Err2, Err3:integer;
  X, Y, Z, X0, Y0, Z0, L, A, cos_A:double;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;

{$IFDEF Demo}
  WriteKeyDownMacros(Sender, Key);
{$ENDIF}
  if (FLastKey<>Key) then begin
  end;
  FLastKey:=Key;

  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  SMOperationManager:=SMDocument as ISMOperationManager;

  case Key of
  VK_F4, VK_F5, VK_F6:
    begin
      Val(trim(edX.Text), X, Err1);
      Val(trim(edY.Text), Y, Err2);
      Val(trim(edZ.Text), Z, Err3);
      if Err1 or Err2 or Err3<>0 then begin
        TEdit(Sender).Font.Color:=clRed;
        Exit;
      end else
        TEdit(Sender).Font.Color:=clWindowText;
      View.CurrX0:=X*100;
      View.CurrY0:=Y*100;
      View.CurrZ0:=Z*100;
      WPX:=X*100;
      WPY:=Y*100;
      WPZ:=Z*100;
      SMDocument.SetCurrXYZ(WPX,WPY, WPZ);

      X0:=SMOperationManager.OperationX0;
      Y0:=SMOperationManager.OperationY0;
      Z0:=SMOperationManager.OperationZ0;
      L:=sqrt(sqr(WPX-X0)+sqr(WPY-Y0)+sqr(WPZ-Z0));
      if L=0 then
        A:=0
      else begin
        cos_A:=(WPX-X0)/L;
        A:=arccos(cos_A)/3.1415926*180;
        if WPY-Y0<0 then
          A:=-A;
      end;

      FChangingCurrentPoint:=True;
      edPLength.Text:=Format('%0.2f',[L/100]);
      edPAngle.Text:=Format('%0.2f',[A]);
      edPLength.Font.Color:=clBlack;
      edPAngle.Font.Color:=clBlack;
      FChangingCurrentPoint:=False;

      FHPainterPanel.SetFocus;
      case Key of
      VK_F4:
        begin
          FHPainterPanel.OnMouseDown:=FHPainterPanel.Mouse_Down;
          FHPainterPanel.OnMouseMove:=FHPainterPanel.Mouse_Move;
          FVPainterPanel.OnMouseDown:=FVPainterPanel.Mouse_Down;
          FVPainterPanel.OnMouseMove:=FVPainterPanel.Mouse_Move;
          Key:=0;
        end;
      VK_F5: SMDocument.MouseDown(sLeft);
      VK_F6: SMDocument.MouseDown(sRight);
      end;
    end;
  else
    Exit;
  end;
  CheckText(edX);
  CheckText(edY);
  CheckText(edZ);
  CheckText(edPLength);
  CheckText(edPAngle);
end;

procedure TDMDraw.edPLengthKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Err1, Err2:integer;
  X, Y, Z, L, Angle, cosZ, sinZ:double;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  S:string;
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;

{$IFDEF Demo}
  WriteKeyDownMacros(Sender, Key);
{$ENDIF}
  if (FLastKey<>Key) then begin
  end;
  FLastKey:=Key;

  case Key of
  VK_F4, VK_F5, VK_F6:
  begin
    SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as ISMDocument;
    SMOperationManager:=SMDocument as ISMOperationManager;
    Val(trim(edPLength.Text), L, Err1);
    Val(trim(edPAngle.Text), Angle, Err2);
    if Err1 or Err2 <> 0 then begin
      TEdit(Sender).Font.Color:=clRed;
      Exit;
    end else
      TEdit(Sender).Font.Color:=clWindowText;
    cosZ:=cos(Angle/180*pi);
    sinZ:=sin(Angle/180*pi);
    X:=SMOperationManager.OperationX0+L*100*cosZ;
    Y:=SMOperationManager.OperationY0+L*100*sinZ;
    Z:=SMDocument.CurrZ;
    edX.Text:=Format('%0.2f',[X/100]);
    edY.Text:=Format('%0.2f',[Y/100]);
    edX.Font.Color:=clBlack;
    edY.Font.Color:=clBlack;

    View.CurrX0:=X;
    View.CurrY0:=Y;

    SMDocument.SetCurrXYZ(X,Y,Z);

    FHPainterPanel.SetFocus;
    case Key of
    VK_F4:
      begin
        FHPainterPanel.OnMouseDown:=FHPainterPanel.Mouse_Down;
        FHPainterPanel.OnMouseMove:=FHPainterPanel.Mouse_Move;
        FVPainterPanel.OnMouseDown:=FVPainterPanel.Mouse_Down;
        FVPainterPanel.OnMouseMove:=FVPainterPanel.Mouse_Move;
        Key:=0;
      end;
    VK_F5: SMDocument.MouseDown(sLeft);
    VK_F6: SMDocument.MouseDown(sRight);
    end;
  end;
  else
    Exit;
  end;
end;

procedure TDMDraw.ed_LineChangeKeyPress(Sender: TObject; var Key: Char);
var
 i,C, k, m:integer;
 D:double;
 aValue:double;
 aEdit:TEdit;
 aDocument:IDMDocument;
 NodeE, LineE, aLineE, AreaE:IDMElement;
 aElement0S:ISpatialElement;
 Line, aLine:ILine;
 aNode:ICoordNode;
 DMOperationManager:IDMOperationManager;
 AreaList:TList;
begin
  if Key=',' then
    Key:='.';

 if Key<>#13 then Exit;

 aEdit:=(Sender as TEdit);
 if not aEdit.Modified then Exit;

 aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;

 if aDocument.SelectionCount=0 then Exit;

 Val(aEdit.Text,D,C);
 if (C<>0) then begin
   aEdit.Font.Color:=clRed;
   Exit
 end else
   aEdit.Font.Color:=0;

 aValue:=D*100;

 DMOperationManager:=aDocument as IDMOperationManager;
 DMOperationManager.StartTransaction(nil, 0, rsLineChange);          //подготовка "отката"
 AreaList:=TList.Create;
 for i:=0 to aDocument.SelectionCount-1 do begin    // i-й элемент
  LineE:=aDocument.SelectionItem[i] as IDMElement;
  if LineE.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
  if LineE.QueryInterface(ILine, Line)=0 then begin
   case aEdit.Tag of
    1:begin Line.C0.X := aValue;
      ed_X0.Text := Format('%0.2f',[Line.C0.X/100]) end;
    2:begin Line.C0.Y := aValue;
      ed_Y0.Text := Format('%0.2f',[Line.C0.Y/100]) end;
    3:begin Line.C0.Z := aValue;
      ed_Z0.Text := Format('%0.2f',[Line.C0.Z/100]) end;
    4:begin Line.C1.X := aValue;
      ed_X1.Text := Format('%0.2f',[Line.C1.X/100]) end;
    5:begin Line.C1.Y := aValue;
      ed_Y1.Text := Format('%0.2f',[Line.C1.Y/100]) end;
    6:begin Line.C1.Z := aValue;
      ed_Z1.Text := Format('%0.2f',[Line.C1.Z/100]) end;
    7:begin Line.Length := aValue;
      ed_Length.Text:= Format('%0.2f',[Line.Length/100]) end;
    8:begin Line.ZAngle := aValue/100;
      ed_ZAngle.Text:= Format('%0.2f',[Line.ZAngle]) end;
    else
   end;
  end;

   aNode:=Line.C0;
   NodeE:=aNode as IDMElement;
   if NodeE.Ref<>nil then
     DMOperationManager.UpdateCoords(NodeE.Ref);
   for m:=0 to aNode.Lines.Count-1 do begin
     aLineE:=aNode.Lines.Item[m];
     if aLineE.Ref<>nil then
       DMOperationManager.UpdateCoords(aLineE.Ref);
     aLine:=aLineE as ILine;
     for k:=0 to aLineE.Parents.Count-1 do begin
       AreaE:=aLineE.Parents.Item[k];
       if AreaList.IndexOf(pointer(AreaE))=-1 then
         AreaList.Add(pointer(AreaE));
     end;
   end;

   aNode:=Line.C1;
   NodeE:=aNode as IDMElement;
   if NodeE.Ref<>nil then
     DMOperationManager.UpdateCoords(NodeE.Ref);
   for m:=0 to aNode.Lines.Count-1 do begin
     aLineE:=aNode.Lines.Item[m];
     if aLineE.Ref<>nil then
       DMOperationManager.UpdateCoords(aLineE.Ref);
     aLine:=aLineE as ILine;
     for k:=0 to aLineE.Parents.Count-1 do begin
       AreaE:=aLineE.Parents.Item[k];
       if AreaList.IndexOf(pointer(AreaE))=-1 then
         AreaList.Add(pointer(AreaE));
     end;
   end;

 end;

 for i:=0 to AreaList.Count-1 do begin
   AreaE:=IDMElement(AreaList[i]);
   if AreaE.Ref<>nil then
     DMOperationManager.UpdateCoords(AreaE.Ref);
 end;
 AreaList.Free;


 CallRefresh(rfFrontBack);
end;

procedure TDMDraw.edPLengthChange(Sender: TObject);
var
  Err1, Err2:integer;
  X, Y, Z, L, Angle, cosZ, sinZ:double;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  S:string;
  View:IView;
begin
  if FPainter=nil then Exit;
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if FChangingCurrentPoint then Exit;

  FChangingCurrentPoint:=True;
  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  SMOperationManager:=SMDocument as ISMOperationManager;
  Val(trim(edPLength.Text), L, Err1);
  Val(trim(edPAngle.Text), Angle, Err2);
  if Err1 or Err2 <> 0 then begin
    TEdit(Sender).Font.Color:=clRed;
    FChangingCurrentPoint:=False;
    Exit;
  end else
    TEdit(Sender).Font.Color:=clWindowText;
  cosZ:=cos(Angle/180*pi);
  sinZ:=sin(Angle/180*pi);
  X:=SMOperationManager.OperationX0+L*100*cosZ;
  Y:=SMOperationManager.OperationY0+L*100*sinZ;
  Z:=SMDocument.CurrZ;
  edX.Text:=Format('%0.2f',[X/100]);
  edY.Text:=Format('%0.2f',[Y/100]);
  edX.Font.Color:=clBlack;
  edY.Font.Color:=clBlack;

  View.CurrX0:=X;
  View.CurrY0:=Y;

  SMDocument.SetCurrXYZ(X,Y,Z);
  FChangingCurrentPoint:=False;
end;

procedure TDMDraw.edXYZChange(Sender: TObject);
var
  WPX, WPY, WPZ:double;
  Err:integer;
  Edit:TEdit;
  X, Y, Z, X0, Y0, Z0, L, A, cos_A:double;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  XM, YM, ZM:integer;
  View:IView;
begin
  if FPainter=nil then Exit;
  View:=FPainter.ViewU as IView;
  if View=nil then Exit;
  if FChangingCurrentPoint then Exit;

  Edit:=SEnder as TEdit;
  FChangingCurrentPoint:=True;

  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as
                      ISMDocument;
  SMOperationManager:=SMDocument as ISMOperationManager;
  Val(trim(Edit.Text), X, Err);
  if Err<>0 then begin
    Edit.Font.Color:=clRed;
    FChangingCurrentPoint:=False;
    Exit;
  end else begin
    Edit.Font.Color:=clWindowText;
  end;
//  FPainter.View.CurrX0:=X*100;
//  FPainter.View.CurrY0:=Y*100;
//  FPainter.View.CurrZ0:=Z*100;
  WPX:=X*100;
  WPY:=Y*100;
  WPZ:=Z*100;

//  SMDocument.SetCurrXYZ(WPX,WPY, WPZ);

  X0:=SMOperationManager.OperationX0;
  Y0:=SMOperationManager.OperationY0;
  Z0:=SMOperationManager.OperationZ0;
  L:=sqrt(sqr(WPX-X0)+sqr(WPY-Y0)+sqr(WPZ-Z0));
  if L=0 then
    A:=0
  else begin
    cos_A:=(WPX-X0)/L;
    A:=arccos(cos_A)/3.1415926*180;
    if WPY-Y0<0 then
      A:=-A;
  end;
  edPLength.Text:=Format('%0.2f',[L/100]);
  edPAngle.Text:=Format('%0.2f',[A]);
  edPLength.Font.Color:=clBlack;
  edPAngle.Font.Color:=clBlack;

  FChangingCurrentPoint:=False;
end;

procedure TDMDraw.SetPanelRatio(Ratio: Double);
begin
  PanelVert.Height:=round((Panel0.Height-Splitter2.Height)*(1-Ratio));
  CallRefresh(rfFrontBack)
end;

procedure TDMDraw.SetOptionsPage(const PageName: WideString);
var
  j:integer;
begin
  j:=0;
  while j<PageControl.PageCount do
    if PageControl.Pages[j].Caption=PageName then
      Break
    else
      inc(j);
  if j<PageControl.PageCount then
    PageControl.ActivePageIndex:=j;
end;

procedure TDMDraw.SetView(const ViewName: WideString);
var
  SpatialModel2:ISpatialModel2;
  j:integer;
begin
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  j:=0;
  while j<SpatialModel2.Views.Count do
    if  SpatialModel2.Views.Item[j].Name=ViewName then
      Break
    else
      inc(j);
  if j<SpatialModel2.Views.Count then begin
    sgViews.Row:=j+1;
    btRestoreView.Click;
  end;
end;

procedure TDMDraw.ts3DMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
{  if (ssCtrl in Shift) and
     (ssShift in Shift) then
    lPanelRatio.Visible:=not lPanelRatio.Visible;
}    
end;

procedure TDMDraw.SetLayer(const LayerName: WideString);
var
  SpatialModel:ISpatialModel;
  j:integer;
begin
  SpatialModel:=FSpatialModel as ISpatialModel;
  j:=0;
  while j<SpatialModel.Layers.Count do
    if  SpatialModel.Layers.Item[j].Name=LayerName then
      Break
    else
      inc(j);
  if j<SpatialModel.Layers.Count then begin
    sgLayers.Row:=j+1;
    bt_SetCurLayer.Click;
  end;
end;

procedure TDMDraw.miRepairAddClick(Sender: TObject);
var
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  Element, aElement:IDMElement;
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  aCollection2:IDMCollection2;
  aID:integer;
  Area:IArea;
  Volume:IVolume;
  Err:integer;
begin
  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if DMDocument.SelectionCount<>1 then Exit;
  if frmIdInput=nil then
    frmIdInput:=TfrmIdInput.Create(Self);
  if frmIdInput.ShowModal<>mrOK then begin
    CallRefresh(rfFast);
    Exit;
  end;
  CallRefresh(rfFast);
  DMOperationManager:=DMDocument as IDMOperationManager;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  Val(frmIdInput.edID.Text, aID, Err);
  Element:=DMDocument.SelectionItem[0] as IDMElement;
  case Element.ClassID of
  _Line:
    begin
      if (Element.Parents.Count>0) then begin
        if (Element.Parents.Item[0].ClassID=_Area) then
          aCollection2:=SpatialModel2.Areas as IDMCollection2
        else
        if (Element.Parents.Item[0].ClassID=_Polyline) then
          aCollection2:=SpatialModel.Polylines as IDMCollection2
        else
          aCollection2:=SpatialModel.LineGroups as IDMCollection2;
      end
      else begin
        if fmLinkClass=nil then
          fmLinkClass:=TfmLinkClass.Create(Self);
        if fmLinkClass.ShowModal<>mrOK then
          Exit;
        if fmLinkClass.rgClass.ItemIndex=0 then
          aCollection2:=SpatialModel2.Areas as IDMCollection2
        else
        if fmLinkClass.rgClass.ItemIndex=1 then
          aCollection2:=SpatialModel.Polylines as IDMCollection2
        else
          aCollection2:=SpatialModel.LineGroups as IDMCollection2
      end;
      aElement:=aCollection2.GetItemByID(aID);
      if aElement=nil then Exit;
      if Element.Parents.IndexOf(aElement)<>-1 then Exit;

      DMOperationManager.StartTransaction(nil, leoAdd, rsAddLink);
      DMOperationManager.AddElementParent(aElement, Element);
      DMOperationManager.UpdateElement(aElement);
    end;
  _Area:
    if lb_Parents.Tag=0 then begin
      aCollection2:=SpatialModel2.Volumes as IDMCollection2;
      if aID=-1 then begin
        aElement:=DataModel.GetDefaultParent(_Area);
        Volume:=aElement as IVolume;
      end else begin
        aElement:=aCollection2.GetItemByID(aID);
        if aElement=nil then Exit;
        Volume:=aElement as IVolume;
      end;

      Area:=Element as IArea;

      if fmVolumeLink=nil then
        fmVolumeLink:=TfmVolumeLink.Create(Self);
      if Volume=Area.Volume0 then begin
        fmVolumeLink.rgLinkType.ItemIndex:=0;
        fmVolumeLink.chbVolumeIsOuter.Checked:=Area.Volume0IsOuter;
      end else
      if Volume=Area.Volume1 then begin
        fmVolumeLink.rgLinkType.ItemIndex:=1;
        fmVolumeLink.chbVolumeIsOuter.Checked:=Area.Volume1IsOuter;
      end;

      if fmVolumeLink.ShowModal<>mrOK then begin
        CallRefresh(rfFast);
        Exit;
      end;
      CallRefresh(rfFast);
      DMOperationManager.StartTransaction(nil, leoAdd, rsAddLink);

      case fmVolumeLink.rgLinkType.ItemIndex of
      0:begin
          Area.Volume0IsOuter:=fmVolumeLink.chbVolumeIsOuter.Checked;
          Area.Volume0:=Volume;
        end;
      1:begin
          Area.Volume1IsOuter:=fmVolumeLink.chbVolumeIsOuter.Checked;
          Area.Volume1:=Volume;
        end;
      end;

      DMOperationManager.UpdateElement(aElement);
    end else begin
      aCollection2:=SpatialModel.Lines as IDMCollection2;
      aElement:=aCollection2.GetItemByID(aID);
      if aElement=nil then Exit;
      if aElement.Parents.IndexOf(Element)<>-1 then Exit;

      DMOperationManager.StartTransaction(nil, leoAdd, rsAddLink);
      DMOperationManager.AddElementParent(Element, aElement);
      DMOperationManager.UpdateElement(Element);
    end;
  _Polyline,
  _LineGroup:
    begin
      aCollection2:=SpatialModel.Lines as IDMCollection2;
      aElement:=aCollection2.GetItemByID(aID);
      if aElement=nil then Exit;
      if aElement.Parents.IndexOf(Element)<>-1 then Exit;

      DMOperationManager.StartTransaction(nil, leoAdd, rsAddLink);
      DMOperationManager.AddElementParent(Element, aElement);
      DMOperationManager.UpdateElement(Element);
    end;
  _Volume:
    begin
      aCollection2:=SpatialModel2.Areas  as IDMCollection2;
      aElement:=aCollection2.GetItemByID(aID);
      if aElement=nil then Exit;
      Volume:=Element as IVolume;
      Area:=aElement as IArea;
      if Area.Volume0=Volume then Exit;
      if Area.Volume1=Volume then Exit;

      if fmVolumeLink=nil then
        fmVolumeLink:=TfmVolumeLink.Create(Self);
      if fmVolumeLink.ShowModal<>mrOK then begin
        CallRefresh(rfFast);
        Exit;
      end;
      CallRefresh(rfFast);
      DMOperationManager.StartTransaction(nil, leoAdd, rsAddLink);

      case fmVolumeLink.rgLinkType.ItemIndex of
      0:begin
          Area.Volume0IsOuter:=fmVolumeLink.chbVolumeIsOuter.Checked;
          Area.Volume0:=Volume;
        end;
      1:begin
          Area.Volume1IsOuter:=fmVolumeLink.chbVolumeIsOuter.Checked;
          Area.Volume1:=Volume;
        end;
      end;

      DMOperationManager.UpdateElement(Element);
    end;
  else
    Exit;
  end;
  OnChangeSelection;
end;

procedure TDMDraw.miRepairRemoveClick(Sender: TObject);
var
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  Element, aElement:IDMElement;
  j:integer;
  Area:IArea;
  Volume:IVolume;
begin
  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if DMDocument.SelectionCount<>1 then Exit;
  j:=lb_Parents.ItemIndex;
  if j=-1 then Exit;

  DMOperationManager:=DMDocument as IDMOperationManager;

  Element:=DMDocument.SelectionItem[0] as IDMElement;
  aElement:=IDMElement(pointer(lb_Parents.Items.Objects[j]));

  case Element.ClassID of
  _Line:
    begin
      DMOperationManager.StartTransaction(nil, leoDelete, rsRemoveLink);
      DMOperationManager.RemoveElementParent(aElement, Element);
      DMOperationManager.UpdateElement(aElement);
    end;
  _Area:
    if lb_Parents.Tag=0 then begin
      Area:=Element as IArea;
      Volume:=aElement as IVolume;
      DMOperationManager.StartTransaction(nil, leoDelete, rsRemoveLink);
      if Area.Volume0=Volume then
        Area.Volume0:=nil
      else
      if Area.Volume1=Volume then
        Area.Volume1:=nil
      else
        DMOperationManager.RemoveElementParent(aElement, Element);
      DMOperationManager.UpdateElement(aElement);
    end else begin
      DMOperationManager.StartTransaction(nil, leoDelete, rsRemoveLink);
      DMOperationManager.RemoveElementParent(Element, aElement);
      DMOperationManager.UpdateElement(Element);
    end;
  _Volume:
    begin
      Volume:=Element as IVolume;
      Area:=aElement as IArea;
      DMOperationManager.StartTransaction(nil, leoDelete, rsRemoveLink);
      if Area.Volume0=Volume then
        Area.Volume0:=nil
      else
      if Area.Volume0=Volume then
        Area.Volume1:=nil
      else
        DMOperationManager.RemoveElementParent(Element, aElement);
      DMOperationManager.UpdateElement(Element);
    end;
  else
    Exit;
  end;

  OnChangeSelection;
end;

procedure TDMDraw.miRepairSelectClick(Sender: TObject);
var
  DMDocument:IDMDocument;
  SMDocument:ISMDocument;
  Painter:IPainter;
  aElement:IDMElement;
  j:integer;
begin
  j:=lb_Parents.ItemIndex;
  if j=-1 then Exit;

  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  SMDocument:=DMDocument as ISMDocument;
  Painter:=SMDocument.PainterU as IPainter;

  aElement:=IDMElement(pointer(lb_Parents.Items.Objects[j]));
  aElement.Selected:=True;
  DMDocument.ClearSelection(aElement);
end;

procedure TDMDraw.lb_ParentsDblClick(Sender: TObject);
var
  DMDocument:IDMDocument;
  SMDocument:ISMDocument;
  Painter:IPainter;
  aElement:IDMElement;
  j:integer;
begin
  j:=lb_Parents.ItemIndex;
  if j=-1 then Exit;

  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  SMDocument:=DMDocument as ISMDocument;
  Painter:=SMDocument.PainterU as IPainter;

  aElement:=IDMElement(pointer(lb_Parents.Items.Objects[j]));
  if FLastDrawElement<>nil then begin
    FLastDrawElement.Draw(Painter, 0);
  end;
  if aElement<>FLastDrawElement then begin
    aElement.Draw(Painter, 1);
    FLastDrawElement:=aElement;
  end else
    FLastDrawElement:=nil;
end;

procedure TDMDraw.lb_HeadParentClick(Sender: TObject);
var
  DMDocument:IDMDocument;
  Element, aElement, aParent, aVolumeE, NodeE:IDMElement;
  j, k:integer;
  Polyline:IPolyline;
  LineGroup:ILineGroup;
  Lines:IDMCollection;
  aArea:IArea;
  S:WideString;
  Line:ILine;
begin
  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if DMDocument.SelectionCount<>1 then Exit;
  Element:=DMDocument.SelectionItem[0] as IDMElement;
  if Element.QueryInterface(ILineGroup, LineGroup)=0 then begin
    Lines:=LineGroup.Lines;

    if lb_Parents.Tag=0 then begin
      lb_Parents.Clear;
      lb_Parents.Tag:=1;
      lb_HeadParent.Caption:='Линии контура';
      for j:=0 to Lines.Count-1 do begin
        aElement:=Lines.Item[j];
        lb_Parents.Items.AddObject(IntToStr(aElement.ID)+' :'
                           + aElement.Name, pointer(aElement))
      end;
    end else begin
      if Element.Parents<>nil then begin
        lb_Parents.Clear;
        lb_Parents.Tag:=0;
        lb_HeadParent.Caption:='Владельцы выделенного элемента';
        for k:=0 to Element.Parents.Count-1 do begin
         aParent:=Element.Parents.Item[k];
         lb_Parents.Items.AddObject(IntToStr(aParent.ID)+' :'
                           + aParent.Name, pointer(aParent))
        end;
      end else
      if Element.QueryInterface(IArea, aArea)=0 then begin
        lb_Parents.Clear;
        lb_Parents.Tag:=0;
        lb_HeadParent.Caption:='Объемы, разделяемые плоскостью';
        if aArea.Volume0<>nil then begin
          aVolumeE:=aArea.Volume0 as IDMElement;
          S:=IntToStr(aVolumeE.ID)+' :'
                             + aVolumeE.Name;
          if aArea.Volume0IsOuter then
            S:=S+'. Внешний';
          lb_Parents.Items.AddObject(S, pointer(aVolumeE))
        end;
        if aArea.Volume1<>nil then begin
          aVolumeE:=aArea.Volume1 as IDMElement;
          S:=IntToStr(aVolumeE.ID)+' :'
                           + aVolumeE.Name;
          if aArea.Volume1IsOuter then
            S:=S+'. Внешний';
          lb_Parents.Items.AddObject(S, pointer(aVolumeE))
        end;
      end;
    end
  end else
  if Element.QueryInterface(ILine, Line)=0 then begin
    if lb_Parents.Tag=1 then begin
      lb_Parents.Clear;
      lb_Parents.Tag:=0;
      lb_HeadParent.Caption:='Владельцы выделенной линии';
      for k:=0 to Element.Parents.Count-1 do begin
       aParent:=Element.Parents.Item[k];
       lb_Parents.Items.AddObject(IntToStr(aParent.ID)+' :'
                         + aParent.Name, pointer(aParent))
      end;
    end else begin
      lb_Parents.Clear;
      lb_Parents.Tag:=1;
      lb_HeadParent.Caption:='Узлы на концах линии';
      if Line.C0<>nil then begin
        NodeE:=Line.C0 as IDMElement;
        S:=IntToStr(NodeE.ID)+' :'
                           + NodeE.Name;
        lb_Parents.Items.AddObject(S, pointer(NodeE))
      end;
      if Line.C1<>nil then begin
        NodeE:=Line.C1 as IDMElement;
        S:=IntToStr(NodeE.ID)+' :'
                           + NodeE.Name;
        lb_Parents.Items.AddObject(S, pointer(NodeE))
      end;
    end;

  end else
    Exit;
end;

procedure TDMDraw.ed_NameKeyPress(Sender: TObject; var Key: Char);
var
 aDocument:IDMDocument;
 aEdit:TEdit;
 aLabel:IDMElement;
 AcOUNT:Integer;
begin
  inherited;
 if Key<>#13 then Exit;

 aEdit:=(Sender as TEdit);
 if not aEdit.Modified then Exit;

 aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
 aCount:=aDocument.SelectionCount;
 if (aCount=0)or(aCount>1) then begin
  ed_Name.Text:='';
  Exit;
 end;

 aLabel:=aDocument.SelectionItem[0] as IDMElement;     // 1-й элемент
 aLabel.Name:=ed_Name.Text;

 (aDocument.Server as IDataModelServer).RefreshDocument(rfFrontBack);  //  Repaint;


end;

procedure TDMDraw.SetCentralPoint(X, Y: Double);
var
  View:IView;
begin
  View:=FPainter.ViewU as IView;
  View.CX:=X;
  View.CY:=Y;
  (Get_DataModelServer as IDataModelServer).RefreshDocument(rfFrontBack);
end;

procedure TDMDraw.ControlBar1Click(Sender: TObject);
begin
  Get_DMEditorX.ActiveForm:=Self as IDMForm;
end;

procedure TDMDraw.PanelClick(Sender: TObject);
begin
  if FPaintFlag then Exit;
  if Get_DMEditorX.ActiveForm<>Self as IDMForm then
    Get_DMEditorX.ActiveForm:=Self as IDMForm;
end;

procedure TDMDraw.mi_RenameLayerClick(Sender: TObject);
begin
  sgLayers.Col:=1;
//  sgLayers.Options:=sgLayers.Options + [goAlwaysShowEditor];
  sgLayers.Options:=sgLayers.Options + [goEditing];
  sgLayers.EditorMode:=True;
end;

procedure TDMDraw.mi_RenameViewClick(Sender: TObject);
begin
  sgViews.Col:=1;
//  sgViews.Options:=sgViews.Options + [goAlwaysShowEditor];
  sgViews.Options:=sgViews.Options + [goEditing];
  sgViews.EditorMode:=True;
end;

procedure TDMDraw.sgViewsSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if FPaintFlag then Exit;
{$IFDEF Demo}
  WriteSelectCellMacros(Sender, aCol, aRow);
{$ENDIF}
  inherited;
  if (sgViews.Col=1) and
     (goEditing in sgViews.Options) then begin
    RenameView;
    sgViews.Options:=sgViews.Options - [goAlwaysShowEditor];
    sgViews.Options:=sgViews.Options - [goEditing];
  end else
  if (aCol<>sgViews.Col) or
     (aRow<>sgViews.Row) then begin
    sgViews.Options:=sgViews.Options - [goAlwaysShowEditor];
    sgViews.Options:=sgViews.Options - [goEditing];
  end;
end;

procedure TDMDraw.RenameView;
var
  Server:IDataModelServer;
  DMOperationManager:IDMOperationManager;
begin
  if (FSpatialModel as ISpatialModel2).Views.Item[sgViews.Row].Name=sgViews.Cells[1,sgViews.Row] then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsChangeView);
  (FSpatialModel as ISpatialModel2).Views.Item[sgViews.Row].Name :=sgViews.Cells[1,sgViews.Row];
  SetViews;
end;

procedure TDMDraw.sgViewsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FPaintFlag then Exit;

{$IFDEF Demo}
  WriteKeyDownMacros(Sender, Key);
{$ENDIF}

  case Key of
  VK_RETURN:
    begin
    case sgViews.Col of
    1:RenameView;
    end;
  end;
  VK_INSERT:
    btAddView.Click;
  VK_DELETE:
    btDelView.Click;
  ord('N'):
    if Shift=[ssCtrl] then
      mi_RenameView.Click;
  end;
end;

procedure TDMDraw.sgViewsExit(Sender: TObject);
begin
  if (sgViews.Col=1) and
     (goEditing in sgViews.Options) then
    RenameView;
end;

procedure TDMDraw.sgLayersExit(Sender: TObject);
begin
  if goEditing in sgLayers.Options then begin
    if (sgLayers.Col=1) then
      RenameLayer
    else
    if (sgLayers.Col=6) then
      ChangeLineWidth
  end;
end;

procedure TDMDraw.ChangeLineWidth;
var
  Server:IDataModelServer;
  DMOperationManager:IDMOperationManager;
  aLayer:ILayer;
  D, E:integer;
begin
  aLayer:=(FSpatialModel.Layers.Item[sgLayers.Row-1] as ILayer);
  if IntToStr(aLayer.LineWidth)=sgLayers.Cells[6,sgLayers.Row] then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsChangeLayerProperty);
  Val(sgLayers.Cells[6,sgLayers.Row], D, E);
  if E=0 then begin
    (FSpatialModel.Layers.Item[sgLayers.Row-1] as ILayer).LineWidth :=D;
    FormPaint(Self);
  end else
    sgLayers.Cells[6,sgLayers.Row]:=IntToStr((FSpatialModel.Layers.Item[sgLayers.Row-1] as ILayer).LineWidth);
end;

procedure TDMDraw.UpdateDocument;
begin
  OpenDocument
end;

procedure TDMDraw.btF5Click(Sender: TObject);
var
  Key:word;
begin
  Key:=VK_F5;
  edXYZKeyDown(edX, Key, [])
end;

procedure TDMDraw.btF6Click(Sender: TObject);
var
  Key:word;
begin
  Key:=VK_F6;
  edXYZKeyDown(edX, Key, [])
end;

procedure TDMDraw.btF4Click(Sender: TObject);
var
  Key:word;
begin
  Key:=VK_F4;
  edXYZKeyDown(edX, Key, [])
end;

procedure TDMDraw.sb_ScrollScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  aScroll:TScrollBar;
  Sign, Step:integer;
begin
  aScroll:=SEnder as TScrollBar;

  if (ScrollPos=aScroll.Min) or
    (ScrollPos=aScroll.Max) then begin

     case ScrollCode of
     scLineUp: Step:=aScroll.SmallChange;
     scLineDown: Step:=-aScroll.SmallChange;
     scPageUp: Step:=aScroll.LargeChange;
     scPageDown: Step:=-aScroll.LargeChange;
     else
       Exit;
     end;

     ScrollPos:=0;
     if aScroll=sb_ScrollX then
       FScrollXOld:=Step
     else
     if aScroll=sb_ScrollY then
       FScrollYOld:=Step
     else
     if aScroll=sb_ScrollZ then
       FScrollZOld:=Step
  end;
end;

procedure TDMDraw.sgViewsRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var
  Server:IDataModelServer;
  DMOperationManager:IDMOperationManager;
  SpatialModel2:ISpatialModel2;
  Views:IDMCollection;
  ViewE:IDMElement;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsChangeLayerProperty);
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  Views:=SpatialModel2.Views;
  ViewE:=Views.Item[FromIndex];
  DMOperationManager.MoveElement(Views, ViewE, ToIndex, True);
end;

procedure TDMDraw.Splitter2CanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
  inherited;
  FSplitterMoved:=True;
end;

procedure TDMDraw.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  FWaitForTimer:=False;

end;

procedure TDMDraw.miPaletteClick(Sender: TObject);
begin
  DoAction(smoPalette);
end;

procedure TDMDraw.sgLayersRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var
  Server:IDataModelServer;
  DMOperationManager:IDMOperationManager;
  SpatialModel:ISpatialModel;
  Layers:IDMCollection;
  LayerE:IDMElement;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMOperationManager:=Server.CurrentDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsChangeLayerProperty);
  SpatialModel:=FSpatialModel as ISpatialModel;
  Layers:=SpatialModel.Layers;
  LayerE:=Layers.Item[FromIndex-1];
  DMOperationManager.MoveElement(Layers, LayerE, ToIndex-1, True);
end;

procedure TDMDraw.edPLengthKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=',' then
    Key:='.';
   
end;

procedure TDMDraw.edPAngleKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=',' then
    Key:='.';
end;

procedure TDMDraw.edZAngleKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=',' then
    Key:='.';
end;

procedure TDMDraw.SpeedButton1Click(Sender: TObject);
var
  aWinControl:TWinControl;
  Ch:Char;
begin
  aWinControl:=Screen.ActiveControl;
  Ch:=#13;
  if (aWinControl is TEdit) then
    (aWinControl as TEdit).OnKeyPress(aWinControl, Ch)
end;

procedure TDMDraw.cbLayerRefChange(Sender: TObject);
var
  m, aCol, aRow:integer;
  aLayerE, aLayerRef:IDMElement;
  OperationManager:IDMOperationManager;
  V:Variant;
  aDocument:IDMDocument;
begin
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDocument.State and dmfFrozen)<>0 then Exit;

  OperationManager:=aDocument as IDMOperationManager;
  m:=cbLayerRef.ItemIndex;

  aCol:=sgLayers.Col;
  aRow:=sgLayers.Row;

  if sgLayers.Col<>0 then begin
    aLayerE:=IDMElement(pointer(sgLayers.Objects[0, aRow]));
  end else
    aLayerE:=nil;

  if (m=-1) then begin
    sgLayers.Cells[aCol, aRow]:='';
    V:=Null;
  end else begin
    aLayerRef:=IDMElement(pointer(cbLayerRef.Items.Objects[m]));
    V:=aLayerRef;
  end;

  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  OperationManager:=aDocument as IDMOperationManager;
  OperationManager.StartTransaction(nil, leoChangeFieldValue,
                                    rsChangeLayerProperty);
  OperationManager.ChangeRef(nil, aLayerE.Name, aLayerRef, aLayerE);

  sgLayers.Cells[aCol, aRow]:=cbLayerRef.Text;
  cbLayerRef.Visible:=False;
  if Visible and
     (Sender=cbLayerRef) then
    sgLayers.SetFocus;
end;

procedure TDMDraw.cbLayerRefKeyPress(Sender: TObject; var Key: Char);
var
  OperationManager:IDMOperationManager;
  B:boolean;
  V:Variant;
  aLayerE, NilElement:IDMElement;
  aDocument:IDMDocument;
begin
   case key of
   #13:
     begin
       sgLayers.Cells[sgLayers.Col, sgLayers.Row]:=cbLayerRef.Text;
       cbLayerRef.Visible:=False;
       if Visible then
         sgLayers.SetFocus;
       Key:=#0;
     end;
   #32:
     begin

       if sgLayers.Col<>0 then
         aLayerE:=IDMElement(pointer(sgLayers.Objects[0, sgLayers.Row]))
       else
         aLayerE:=nil;

       OperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as IDMOperationManager;
       cbLayerRef.ItemIndex:=-1;
       cbLayerRef.Text:='';
       NilElement:=nil;
       V:=NilElement as IUnknown;

       aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
       OperationManager:=aDocument as IDMOperationManager;
       OperationManager.StartTransaction(nil, leoChangeFieldValue,
                                     rsChangeLayerProperty);
       OperationManager.ChangeRef(nil, aLayerE.Name, V, aLayerE);

       cbLayerRef.Visible:=False;
       if Visible then
         sgLayers.SetFocus;
       Key:=#0;
     end;
   end;
end;

procedure TDMDraw.cbLayerRefExit(Sender: TObject);
begin
  cbLayerRefChange(nil);
  cbLayerRef.Visible:=False;
end;

procedure TDMDraw.ed_AlphaKeyPress(Sender: TObject; var Key: Char);
var
 C, Value:integer;
 aEdit:TEdit;
 aDocument:IDMDocument;
 aNode:ICoordNode;
 aElement0, aElement:IDMElement;
 aElement0S:ISpatialElement;
 aElement0L:ILine;
 aImageRect:IImageRect;
 DMOperationManager:IDMOperationManager;
 i, j, k, aCount, aImageCount, aTag:integer;
begin
  case Key of
  '0'..'9': Exit;
  #13:begin end;
  else
    begin
      Key:=#0;
      Exit;
    end;
  end;


 aEdit:=(Sender as TEdit);
 if not aEdit.Modified then Exit;

 aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
 if aDocument.SelectionCount=0 then Exit;

 Val(aEdit.Text,Value,C);
 if (C<>0) then begin
  aEdit.Font.Color:=clRed;
  Exit
 end else
 if (Value>=0) and (Value<256) then
  aEdit.Font.Color:=clBlack
 else begin
  aEdit.Font.Color:=clRed;
  Exit
 end;

 DMOperationManager:=aDocument as IDMOperationManager;
 DMOperationManager.StartTransaction(nil, 0, rsLineChange);          //подготовка "отката"
 for i:=0 to aDocument.SelectionCount-1 do begin    // i-й элемент
   aElement0:=aDocument.SelectionItem[i] as IDMElement;
   if aElement0.QueryInterface(IImageRect, aImageRect)=0 then
      aImageRect.Alpha:=Value;
 end;

 CallRefresh(rfFrontBack);
end;

procedure TDMDraw.Panoram;
var
  SMDocument:ISMDocument;
  ScrollPos:integer;
  ScrollCode:TScrollCode;
begin

  if not FDragging then Exit;
  SMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument as ISMDocument;
  if SMDocument.CurrPX<=0 then begin
     ScrollPos:=sb_ScrollX.Position;
     ScrollCode:=scLineUp;
     sb_ScrollScroll(sb_ScrollX, ScrollCode, ScrollPos);
     sb_ScrollX.Position:=ScrollPos-sb_ScrollX.SmallChange;
     ScrollCode:=scEndScroll;
     sb_ScrollScroll(sb_ScrollX, ScrollCode, ScrollPos);
  end;
  if SMDocument.CurrPY<=0 then begin
     ScrollPos:=sb_ScrollY.Position;
     ScrollCode:=scLineUp;
     sb_ScrollScroll(sb_ScrollY, ScrollCode, ScrollPos);
     sb_ScrollY.Position:=ScrollPos-sb_ScrollY.SmallChange;
     ScrollCode:=scEndScroll;
     sb_ScrollScroll(sb_ScrollY, ScrollCode, ScrollPos);
  end;
  if SMDocument.CurrPX>=FPainter.HWidth then begin
     ScrollPos:=sb_ScrollX.Position;
     ScrollCode:=scLineUp;
     sb_ScrollScroll(sb_ScrollX, ScrollCode, ScrollPos);
     sb_ScrollX.Position:=ScrollPos+sb_ScrollX.SmallChange;
     ScrollCode:=scEndScroll;
     sb_ScrollScroll(sb_ScrollX, ScrollCode, ScrollPos);
  end;
  if SMDocument.CurrPY>=FPainter.HHeight then begin
     ScrollPos:=sb_ScrollY.Position;
     ScrollCode:=scLineUp;
     sb_ScrollScroll(sb_ScrollY, ScrollCode, ScrollPos);
     sb_ScrollY.Position:=ScrollPos+sb_ScrollY.SmallChange;
     ScrollCode:=scEndScroll;
     sb_ScrollScroll(sb_ScrollY, ScrollCode, ScrollPos);
  end;
end;

procedure TDMDraw.Timer2Timer(Sender: TObject);
begin
  Panoram;
end;


procedure TDMDraw.cb_SelectLayerClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteClickControlMacros(Sender);
{$ENDIF}
  PanelClick(Sender)
end;

procedure TDMDraw.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
{$IFDEF Demo}
  WriteClickControlMacros(Sender)
{$ENDIF}
end;

{$IFDEF Demo}
function TDMDraw.DoMacrosStep(RecordKind, ControlID, EventID, X, Y: Integer;
          const S:WideString):WordBool;
var
  DMDocument:IDMDocument;
  SMDocument:ISMDocument;
  SMOperationManager:ISMOperationManager;
  CurrX, CurrY, CurrZ:double;
  Painter:IPainter;
  Panel:TPanel;
  DMMacrosManager:IDMMacrosManager;
  PX1, PY1, PZ1, CursorStepLength:integer;
  P1, P:TPoint;
  Key, Col, Row, WaitCommandInterval:integer;
  aParent:TControl;
  StartSelPos, EndSelPos:integer;
  StringGrid:TStringGrid;
  Layer:ILayer;
  S1:string;
begin
  Result:=inherited DoMacrosStep(RecordKind, ControlID, EventID, X, Y, S);

  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  SMDocument:=DMDocument as ISMDocument;
  SMOperationManager:=DMDocument as ISMOperationManager;
  DMMacrosManager:=Get_DMEditorX as IDMMacrosManager;

  case EventID of
  meLClick:
    if FMacrosControlID=-1 then begin
      if FMacrosString<>'' then
        DMMacrosManager.Say(FMacrosString, False, True, False);
      SMDocument.SetCurrXYZ(FMacrosCurrX, FMacrosCurrY, FMacrosCurrZ);
      FHPainterPanel.SetFocus;
      SMDocument.MouseDown(FShiftState or sLeft);
    end else begin
      FMacrosControl:=Components[FMacrosControlID] as TWinControl;

      if FMacrosControl is TEdit then begin
        DM_SendMessage(FMacrosControl.Handle, WM_LButtonDown, 0, 0);
        DM_SendMessage(FMacrosControl.Handle, WM_LButtonUp, 0, 0);
        DM_SendMessage(FMacrosControl.Handle, EM_SetSel, 0, -1);
      end else
      if FMacrosControl is TStringGrid then begin
        StringGrid:=FMacrosControl as TStringGrid;
        Col:=round(FMacrosX);
        Row:=round(FMacrosY);
        StringGrid.Col:=Col;
        StringGrid.Row:=Row;
//        R:=StringGrid.CellRect(Col, Row);
//        PS.X:=(R.Left+R.Right) div 2;
//        PS.Y:=(R.Top+R.Bottom) div 2;
//        SendMessage(FMacrosControl.Handle, WM_LButtonDown, 0, integer((@PS)^));
//        SendMessage(FMacrosControl.Handle, WM_LButtonUp, 0, integer((@PS)^));
      end else begin
        WaitCommandInterval:=round(FMacrosY);
        if WaitCommandInterval<>-1 then begin
          DMMacrosManager:=Get_DMEditorX as IDMMacrosManager;
          DMMacrosManager.PauseMacros(WaitCommandInterval);
          Result:=False;
        end;
        DM_SendMessage(FMacrosControl.Handle, WM_LButtonDown, 0, 0);
        DM_SendMessage(FMacrosControl.Handle, WM_LButtonUp, 0, 0);
      end;
    end;
  meRClick:
    if FMacrosControlID=-1 then begin
      SMDocument.SetCurrXYZ(FMacrosCurrX, FMacrosCurrY, FMacrosCurrZ);
      FHPainterPanel.SetFocus;
      WaitCommandInterval:=round(FMacrosY);
      if WaitCommandInterval<>-1 then begin
        DMMacrosManager:=Get_DMEditorX as IDMMacrosManager;
        DMMacrosManager.PauseMacros(WaitCommandInterval);
        Result:=False;
      end;
      SMDocument.MouseDown(FShiftState or sRight);
    end else begin
    end;
  meDoubleClick:
    if FMacrosControlID=-1 then begin
    end else begin
      FMacrosControl:=Components[FMacrosControlID] as TWinControl;
      if (FMacrosControl=sgLayers) and
         (round(Y)=5) then begin
        Result:=False;
        DMMacrosManager.PauseMacros(500);
        DM_SendMessage(FMacrosControl.Handle, WM_LButtonDblClk, 0, 0);
      end else begin
        DM_SendMessage(FMacrosControl.Handle, WM_LButtonDblClk, 0, 0);
      end;
    end;
  meMouseMove:
    if FMacrosControlID=-1 then begin
      Result:=False;
      CurrX:=X/10;
      if SMDocument.HWindowFocused then begin
        CurrY:=Y/10;
        CurrZ:=SMDocument.CurrZ;
        Panel:=FHPainterPanel;
      end else begin
        CurrY:=SMDocument.CurrY;
        CurrZ:=Y/10;
        Panel:=FVPainterPanel;
      end;

      Painter:=SMDocument.Painter;
      Painter.WP_To_P(CurrX, CurrY, CurrZ, PX1, PY1, PZ1);
      P.X:=PX1;
      if SMDocument.HWindowFocused then
        P.Y:=PY1
      else
        P.Y:=PZ1;

      P1:=Panel.ClientToScreen(P);
      FMacrosCurrX:=CurrX;
      FMacrosCurrY:=CurrY;
      FMacrosCurrZ:=CurrZ;

      if SMOperationManager.OperationStep<1 then
        CursorStepLength:=16
      else
        CursorStepLength:=8;

      DMMacrosManager.StartMacrosStep(P1.X, P1.Y, CursorStepLength);
    end else begin
      Result:=False;
      FMacrosControl:=Components[FMacrosControlID] as TWinControl;
      if FMacrosControl is TStringGrid then
        InitStringGridEventMacros
      else
        InitControlEventMacros
    end;
  meKeyDown:
    if FMacrosControlID=-1 then begin
      if FMacrosString<>'' then
        DMMacrosManager.Say(FMacrosString, False, True, False);
      Key:=X;
      case Key of
      VK_SHIFT:   FShiftState:=FShiftState+sShift;
      VK_CONTROL: FShiftState:=FShiftState+sCtrl;
      VK_MENU:    FShiftState:=FShiftState+sAlt
      else
        begin
          Result:=False;
          DMMacrosManager.PauseMacros(500);
          if SMDocument.HWindowFocused then
            DM_SendMessage(FHPainterPanel.Handle, WM_KeyDown, Key, 0)
          else
            DM_SendMessage(FVPainterPanel.Handle, WM_KeyDown, Key, 0)
        end;
      end;
    end else begin
      FMacrosControl:=Components[FMacrosControlID] as TWinControl;
      Key:=X;
      if FMacrosControl is TEdit then begin
        DM_SendMessage(FMacrosControl.Handle, EM_GetSel,
                    integer(@StartSelPos), integer(@EndSelPos));
        if StartSelPos<>EndSelPos then
          DM_SendMessage(FMacrosControl.Handle, WM_SetText, 0, 0);
      end;
      Result:=False;
      DMMacrosManager.PauseMacros(500);
      DM_SendMessage(FMacrosControl.Handle, WM_KeyDown, Key, 0);
    end;
  meKeyUp:
    if FMacrosControlID=-1 then begin
      Key:=X;
      case Key of
      VK_SHIFT:   FShiftState:=FShiftState-sShift;
      VK_CONTROL: FShiftState:=FShiftState-sCtrl;
      VK_MENU:    FShiftState:=FShiftState-sAlt
      end;
    end else begin
    end;
  meDummy1:
    begin
      FMacrosControl:=Components[FMacrosControlID] as TWinControl;
      aParent:=FMacrosControl.Parent;
      while not (aParent is TTabSheet) do
        aParent:=aParent.Parent;
      if TTabSheet(aParent).PageIndex<>PageControl.ActivePageIndex then begin
        Result:=False;
        FMacrosControl:=aParent as TWinControl;
        InitFindTabSheetMacros;
      end;
    end;
  meDummy2:
    begin
      FMacrosControl:=Components[FMacrosControlID] as TWinControl;
      aParent:=FMacrosControl.Parent;
      while not (aParent is TTabSheet) do
        aParent:=aParent.Parent;
      PageControl.ActivePageIndex:=(aParent as TTabSheet).PageIndex;
    end;
  dmbaImportRaster:
    begin
      SMOperationManager.PictureFileName:=FMacrosString;
      SMOperationManager.StartOperation(smoCreateImageRect);
    end;
  dmbaImportVector:
    begin
      S1:=FMacrosString;
     (DMDocument.DataModel as IDataModel).Import(S1);
    end;
  SaveViewDialogEventId:
    begin
    end;
  CreateLayerDialogEventId:
    begin
    end;
  ColorDialogEventId:
    begin
      DM_DestroyWindow(ColorDialog1.Handle);
      Layer:=FSpatialModel.Layers.Item[round(FMacrosY)] as ILayer;
      Layer.Color:=round(FMacrosX);
      sgLayers.Invalidate;
    end;
  end; // case RecordKind of
end;

procedure TDMDraw.WriteClickControlMacros(Sender: TObject);
var
  Control:TControl;
  FormID:integer;
begin
  FormID:=Get_FormID;
  Control:=Sender as  TControl;
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meDummy1, -1, -1, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meDummy2, -1, -1, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meMouseMove, -1, -1, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meLClick, -1, -1, '')
end;

procedure TDMDraw.WriteSelectCellMacros(Sender: TObject; aCol, aRow:integer);
var
  Control:TControl;
  FormID:integer;
begin
  FormID:=Get_FormID;
  Control:=Sender as  TControl;
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meDummy1, -1, -1, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meDummy2, -1, -1, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meMouseMove,
              aCol, aRow, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meLClick,
              aCol, aRow, '');
end;

procedure TDMDraw.WriteSpeedButtonDownMacros(Sender: TObject);
begin
end;

procedure TDMDraw.WriteSpeedButtonUpMacros(Sender: TObject);
begin
end;

procedure TDMDraw.WriteRadioButtonMacros(Sender: TObject);
begin
end;

procedure TDMDraw.InitControlEventMacros;
var
  P:TPoint;
  CursorStepLength:integer;
  DMMacrosManager:IDMMacrosManager;
begin
  DMMacrosManager:=Get_DMEditorX as IDMMacrosManager;
  P.X:=FMacrosControl.Width div 2;
  P.Y:=FMacrosControl.Height div 2;
  P:=FMacrosControl.ClientToScreen(P);
  CursorStepLength:=16;
  DMMacrosManager.StartMacrosStep(P.X, P.Y, CursorStepLength);
end;

procedure TDMDraw.InitFindTabSheetMacros;
var
  TabSheet:TTabSheet;
  PageControl:TPageControl;
  R:TRect;
  P:TPoint;
  CursorStepLength:integer;
  DMMacrosManager:IDMMacrosManager;
begin
  DMMacrosManager:=Get_DMEditorX as IDMMacrosManager;
  TabSheet:=FMacrosControl as TTabSheet;
  PageControl:=TabSheet.PageControl;
  R:=PageControl.TabRect(TabSheet.PageIndex);
  P.X:=(R.Left+R.Right) div 2;
  P.Y:=(R.Top+R.Bottom) div 2;
  P:=PageControl.ClientToScreen(P);
  CursorStepLength:=16;
  DMMacrosManager.StartMacrosStep(P.X, P.Y, CursorStepLength);
end;

procedure TDMDraw.WriteKeyDownMacros(Sender: TObject; Key: Integer);
var
  Control:TControl;
  FormID:integer;
begin
  FormID:=Get_FormID;
  Control:=TControl(Sender);
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meKeyDown, Key, -1, '');
end;

procedure TDMDraw.WriteMacrosState;
var
  FormID, X, Y, Z:integer;
begin
  FormID:=Get_FormID;
  X:=round(Panel0.Width/Width*10);
  Y:=round((1-PanelVert.Height/(Panel0.Height-Splitter2.Height))*10);
  Z:=PageControl.ActivePageIndex;
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrSetFormState,
              FormID, 0, Z, X, Y, '');
  Z:=FSpatialModel.Layers.IndexOf(FSpatialModel.CurrentLayer as IDMElement);
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrSetFormState,
              FormID, 1, Z, 0, 0, '');
  X:=round(FPainter.View.CX);
  Y:=round(FPainter.View.CY);
  Z:=round(FPainter.View.CZ);
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrSetFormState,
              FormID, 4, Z, X, Y, '');
  X:=round(FPainter.View.CurrX0);
  Y:=round(FPainter.View.CurrY0);
  Z:=round(FPainter.View.CurrZ0);
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrSetFormState,
              FormID, 5, Z, X, Y, '');
  X:=round(FPainter.View.RevScale);
  Y:=round(FPainter.View.ZAngle);
  Z:=round(FPainter.View.Zmin);
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrSetFormState,
              FormID, 6, Z, X, Y, '');
  X:=round(FPainter.View.DMin);
  Y:=round(FPainter.View.DMax);
  Z:=round(FPainter.View.Zmax);
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrSetFormState,
              FormID, 7, Z, X, Y, '');
end;

procedure TDMDraw.SetMacrosState(ParamID, Z, X, Y: integer);
var
  SMOperationManager:ISMOperationManager;
  SpatialModel2:ISpatialModel2;
begin
  SMOperationManager:=
  (Get_DataModelServer as IDataModelServer).CurrentDocument as ISMOperationManager;
  SpatialModel2:=FSpatialModel as ISpatialModel2;
  case ParamID of
  0:begin
     PanelInfo.Width:=round((1-X/10)*Width);
     PanelVert.Height:=round((1-Y/10)*(Panel0.Height-Splitter2.Height));
     PageControl.ActivePageIndex:=Z;
    end;
  1:begin
      FSpatialModel.CurrentLayer:=FSpatialModel.Layers.Item[Z] as ILayer;
    end;
  2:begin
    end;
  3:begin
    end;
  4:begin
      FPainter.View.CX:=X;
      FPainter.View.CY:=Y;
      FPainter.View.CZ:=Z;
    end;
  5:begin
      FPainter.View.CurrX0:=X;
      FPainter.View.CurrY0:=Y;
      FPainter.View.CurrZ0:=Z;
    end;
  6:begin
      FPainter.View.RevScale:=X;
      FPainter.View.ZAngle:=Y;
      FPainter.View.Zmin:=Z;
      SpatialModel2.AreasOrdered:=False;
    end;
  7:begin
      FPainter.View.DMin:=X;
      FPainter.View.DMax:=Y;
      FPainter.View.Zmax:=Z;
    end;
  end;
  inherited;
end;

procedure TDMDraw.WriteDblClickControlMacros(Sender: TObject);
var
  Control:TControl;
  FormID:integer;
  StringGrid:TStringGrid;
begin
  FormID:=Get_FormID;
  Control:=Sender as  TControl;

  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meDummy1, -1, -1, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meDummy2, -1, -1, '');
  if Sender is TStringGrid then begin
    StringGrid:=Sender as TStringGrid;

    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meDoubleClick,
              StringGrid.Col, StringGrid.Row, '')
  end else
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, Control.ComponentIndex, meDoubleClick,
              -1, -1, '')
end;

procedure TDMDraw.InitStringGridEventMacros;
var
  R:TRect;
  P:TPoint;
  DMMacrosManager:IDMMacrosManager;
  CursorStepLength, Col, Row:integer;
  StringGrid:TStringGrid;
begin
  DMMacrosManager:=Get_DMEditorX as IDMMacrosManager;
  StringGrid:=FMacrosControl as TStringGrid;
  Col:=round(FMacrosX);
  Row:=round(FMacrosY);
  if Col<StringGrid.LeftCol then
    StringGrid.LeftCol:=Col
  else
  if Col>(StringGrid.LeftCol+StringGrid.VisibleColCount-1) then
    StringGrid.LeftCol:=Col-StringGrid.VisibleColCount+1;
  if Row<StringGrid.TopRow then
    StringGrid.TopRow:=Row
  else
  if Row>(StringGrid.TopRow+StringGrid.VisibleRowCount-1) then
    StringGrid.TopRow:=Row-StringGrid.VisibleRowCount+1;
  R:=(FMacrosControl as TStringGrid).CellRect(Col, Row);
  P.X:=(R.Left+R.Right) div 2;
  P.Y:=(R.Top+R.Bottom) div 2;
  P:=FMacrosControl.ClientToScreen(P);
  CursorStepLength:=16;
  DMMacrosManager.StartMacrosStep(P.X, P.Y, CursorStepLength);
end;
{$ENDIF}

end.





