unit fcImager;
{
//
// Components : TfcImager
//
// Copyright (c) 1999 by Woll2Woll Software
// 4/21/99 - RSW - Added CopyToClipboard method
// 8/2/99 - Check if parent is nil in BitmapChange event.
// 9/27/2001-Added SetFocus,TabOrder, and OnEnter/OnExit events. (Only fired when focusable).
// 10/11/2001-Added ProportionalCenter Draw Style.
// 1/16/2002 - Not using gclassname in paint event.
// 3/14/2002 - Correct for painting in a grid when csPaintCopy State.
// 4/9/2002 - Made GetDrawRect public.
// 5/30/2001-PYW- Make certain parent's handle has already been allocated when invalidating parent.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fcCommon, fcBitmap, fcChangeLink, db, dbctrls, stdctrls;

{$i fcIfDef.pas}

type
  TfcImagerDrawStyle = (dsNormal, dsCenter, dsStretch, dsTile, dsProportional, dsProportionalCenter);

  TfcBitmapOptions = class;

  TfcRotate = class(TPersistent)
  private
    FBitmapOptions: TfcBitmapOptions;

    FCenterX: Integer;
    FCenterY: Integer;
    FAngle: Integer;

    procedure SetAngle(Value: Integer);
    procedure SetCenterX(Value: Integer);
    procedure SetCenterY(Value: Integer);
  public
    constructor Create(BitmapOptions: TfcBitmapOptions);
  published
    property CenterX: Integer read FCenterX write SetCenterX;
    property CenterY: Integer read FCenterY write SetCenterY;
    property Angle: Integer read FAngle write SetAngle;
  end;

  TfcAlphaBlend = class(TPersistent)
  private
    FBitmapOptions: TfcBitmapOptions;

    FAmount: Byte;
    FBitmap: TfcBitmap;
    FChanging: Boolean;

    function GetTransparent: Boolean;
    procedure SetAmount(Value: Byte);
    procedure SetBitmap(Value: TfcBitmap);
    procedure SetTransparent(Value: Boolean);
  protected
    procedure BitmapChanged(Sender: TObject); virtual;
  public
    constructor Create(BitmapOptions: TfcBitmapOptions);
    destructor Destroy; override;
  published
    property Amount: Byte read FAmount write SetAmount;
    property Bitmap: TfcBitmap read FBitmap write SetBitmap;
    property Transparent: Boolean read GetTransparent write SetTransparent;
  end;

  TfcWave = class(TPersistent)
  private
    FBitmapOptions: TfcBitmapOptions;
    FXDiv, FYDiv, FRatio: Integer;
    FWrap: Boolean;

    procedure SetXDiv(Value: Integer);
    procedure SetYDiv(Value: Integer);
    procedure SetRatio(Value: Integer);
    procedure SetWrap(Value: Boolean);
  public
    constructor Create(BitmapOptions: TfcBitmapOptions);
  published
    property XDiv: Integer read FXDiv write SetXDiv;
    property YDiv: Integer read FYDiv write SetYDiv;
    property Ratio: Integer read FRatio write SetRatio;
    property Wrap: Boolean read FWrap write SetWrap;
  end;

  TfcBitmapOptions = class(TPersistent)
  private
    FComponent: TComponent;

    FAlphaBlend: TfcAlphaBlend;
    FColor: TColor;
    FContrast: Integer;
    FEmbossed: Boolean;
    FTintColor: TColor;
    FGaussianBlur: Integer;
    FGrayScale: Boolean;
    FHorizontallyFlipped: Boolean;
    FInverted: Boolean;
    FLightness: Integer;
    FRotation: TfcRotate;
    FSaturation: Integer;
    FSharpen: Integer;
    FSponge: Integer;
    FTile: Boolean;
    FVerticallyFlipped: Boolean;
    FWave: TfcWave;

    FOnChange: TNotifyEvent;
    FOrigPicture: TPicture;
    FDestBitmap: TfcBitmap;
    FUpdateLock: Integer;

    // Property Access methods;
    procedure SetColor(Value: TColor);
    procedure SetBooleanProperty(Index: Integer; Value: Boolean);
    procedure SetTintColor(Value: TColor);
    procedure SetIntegralProperty(Index: Integer; Value: Integer);
  public
    constructor Create(AComponent: TComponent);
    destructor Destroy; override;

    procedure BeginUpdate; virtual;
    procedure Changed; virtual;
    procedure EndUpdate;

    property DestBitmap: TfcBitmap read FDestBitmap write FDestBitmap;
    property OrigPicture: TPicture read FOrigPicture write FOrigPicture;
    property Tile: Boolean read FTile write FTile;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property AlphaBlend: TfcAlphaBlend read FAlphaBlend write FAlphaBlend;
    property Color: TColor read FColor write SetColor;
    property Contrast: Integer index 4 read FContrast write SetIntegralProperty;
    property Embossed: Boolean index 0 read FEmbossed write SetBooleanProperty;
    property TintColor: TColor read FTintColor write SetTintColor;
    property GaussianBlur: Integer index 3 read FGaussianBlur write SetIntegralProperty;
    property GrayScale: Boolean index 2 read FGrayScale write SetBooleanProperty;
    property HorizontallyFlipped: Boolean index 3 read FHorizontallyFlipped write SetBooleanProperty;
    property Inverted: Boolean index 1 read FInverted write SetBooleanProperty;
    property Lightness: Integer index 0 read FLightness write SetIntegralProperty;
    property Rotation: TfcRotate read FRotation write FRotation;
    property Saturation: Integer index 1 read FSaturation write SetIntegralProperty;
    property Sharpen: Integer index 5 read FSharpen write SetIntegralProperty;
    property Sponge: Integer index 2 read FSponge write SetIntegralProperty;
    property VerticallyFlipped: Boolean index 4 read FVerticallyFlipped write SetBooleanProperty;
    property Wave: TfcWave read FWave write FWave;
  end;

  TfcCustomImager = class(TGraphicControl)
  private
    { Private declarations }
    FAutoSize: Boolean;
    FBitmapOptions: TfcBitmapOptions;
    FDrawStyle: TfcImagerDrawStyle;
    FEraseBackground: Boolean;
    FPreProcess: Boolean;
    FWorkBitmap: TfcBitmap;
    FPicture: TPicture;
    FChangeLinks: TList;
    FRespectPalette: boolean;
    FTransparent: boolean;  // Keep track in component instead of in picture
                            // This helps databound case support transparency
    FWinControl: TWinControl;
    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FFocusable: boolean;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyDown, FOnKeyUp: TKeyEvent;
    FTabStop: boolean;
    FTabOrder: Integer;
    FFocused: boolean;
    FShowFocusRect: boolean;

    procedure SetTabStop(value: boolean);
    procedure SetTabOrder(value: integer);
    function GetRespectPalette: Boolean;
    function GetSmoothStretching: Boolean;
    function GetTransparent: Boolean;
    function GetTransparentColor: TColor;
    {$ifndef fcDelphi6Up}
    procedure SetAutoSize(Value: Boolean);
    {$endif}
    procedure SetDrawStyle(Value: TfcImagerDrawStyle);
    procedure SetEraseBackground(Value: Boolean);
    procedure SetPreProcess(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetRespectPalette(Value: Boolean);
    procedure SetSmoothStretching(Value: Boolean);
    procedure SetShowFocusRect(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
    procedure SetTransparentColor(Value: TColor);
    procedure NotifyChanges;
    procedure SetFocusable(Value: boolean);
  protected
    {$ifdef fcDelphi6Up}
    procedure SetAutoSize(Value: Boolean); override;
    {$endif}
    Function CreateImagerWinControl: TWinControl; virtual;
    procedure SetParent(Value: TWinControl); override;
    procedure BitmapOptionsChange(Sender: TObject); virtual;
    procedure BitmapChange(Sender: TObject); virtual;
    procedure UpdateAutoSize; virtual;

    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(var Key: Char); virtual;
    procedure DoEnter; virtual;
    procedure DoExit; virtual;

    property EraseBackground: Boolean read FEraseBackground write SetEraseBackground default True;
    property Focused: Boolean read FFocused;
  public
    UpdatingAutoSize: Boolean;
    InSetBounds: boolean;
    Patch: Variant;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function PictureEmpty: Boolean; virtual;
    procedure Invalidate; override;
    procedure RegisterChanges(ChangeLink: TfcChangeLink); virtual;
    procedure Resized; virtual;
    procedure UpdateWorkBitmap; virtual;
    procedure UnRegisterChanges(ChangeLink: TfcChangeLink); virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure CopyToClipboard; virtual;
    procedure PasteFromClipboard; virtual;
    procedure CutToClipboard; virtual;
    procedure SetFocus; virtual;
    function GetColorAtPoint(X,Y:Integer):TColor;
    function GetDrawRect: TRect;

    property Align;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property BitmapOptions: TfcBitmapOptions read FBitmapOptions write FBitmapOptions;
    property DrawStyle: TfcImagerDrawStyle read FDrawStyle write SetDrawStyle;
    property PreProcess: Boolean read FPreProcess write SetPreProcess;
    property Picture: TPicture read FPicture write SetPicture;
    property RespectPalette: Boolean read GetRespectPalette write SetRespectPalette default True;
    property ShowFocusRect: Boolean read FShowFocusRect write SetShowFocusRect default False;
    property SmoothStretching: Boolean read GetSmoothStretching write SetSmoothStretching;
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property TransparentColor: TColor read GetTransparentColor write SetTransparentColor;
    property WorkBitmap: TfcBitmap read FWorkBitmap;
    property Focusable: boolean read FFocusable write SetFocusable default False;
    property TabOrder: integer read FTabOrder write SetTabOrder;
    property TabStop: boolean read FTabStop write SetTabStop default False;
    property OnKeyPress : TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyDown : TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyUp : TKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
  end;

  TfcImager = class(TfcCustomImager)
  published
    { Published declarations }
    property Align;
    property AutoSize;
    property BitmapOptions;
    property DrawStyle;
    property Picture;
    property PreProcess;
    property RespectPalette;
    property SmoothStretching;
    property Transparent;
    property TransparentColor;
    property Visible;
    property Focusable;

    property Anchors;
    property Constraints;
    property OnEndDock;
    property OnStartDock;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property TabOrder;
    property TabStop;
    property OnKeyPress;
    property OnKeyDown;
    property OnKeyUp;
  end;


  TfcDBCustomImager = class(TCustomControl)
  private
    { Private declarations }
    FAutoSize: Boolean;
    FBitmapOptions: TfcBitmapOptions;
    FDrawStyle: TfcImagerDrawStyle;
    FPreProcess: Boolean;
    FWorkBitmap: TfcBitmap;
    FPicture: TPicture;
    FChangeLinks: TList;
    FRespectPalette: boolean;
    FTransparent: boolean;  // Keep track in component instead of in picture
                            // This helps databound case support transparency
    FInResized:boolean;

    function GetRespectPalette: Boolean;
    function GetSmoothStretching: Boolean;
    function GetTransparent: Boolean;
    function GetTransparentColor: TColor;
    {$ifndef fcDelphi6Up}
    procedure SetAutoSize(Value: Boolean);
    {$endif}
    procedure SetDrawStyle(Value: TfcImagerDrawStyle);
    procedure SetPreProcess(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetRespectPalette(Value: Boolean);
    procedure SetSmoothStretching(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
    procedure SetTransparentColor(Value: TColor);
    function GetDrawRect: TRect;
    procedure NotifyChanges;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
  protected
    {$ifdef fcDelphi6Up}
    procedure SetAutoSize(Value: Boolean); override;
    {$endif}
    procedure BitmapOptionsChange(Sender: TObject); virtual;
    procedure BitmapChange(Sender: TObject); virtual;
    procedure UpdateAutoSize; virtual;

    procedure Loaded; override;
    procedure Paint; override;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CreateWnd; override;
  public
    UpdatingAutoSize: Boolean;
    InSetBounds: boolean;
    Patch: Variant;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function PictureEmpty: Boolean; virtual;
    function GetColorAtPoint(X,Y:Integer):TColor;
    procedure Invalidate; override;
    procedure RegisterChanges(ChangeLink: TfcChangeLink); virtual;
    procedure Resized; virtual;
    procedure UpdateWorkBitmap; virtual;
    procedure UnRegisterChanges(ChangeLink: TfcChangeLink); virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Align;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property BitmapOptions: TfcBitmapOptions read FBitmapOptions write FBitmapOptions;
    property DrawStyle: TfcImagerDrawStyle read FDrawStyle write SetDrawStyle;
    property PreProcess: Boolean read FPreProcess write SetPreProcess;
    property Picture: TPicture read FPicture write SetPicture;
    property RespectPalette: Boolean read GetRespectPalette write SetRespectPalette default True;
    property SmoothStretching: Boolean read GetSmoothStretching write SetSmoothStretching;
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property TransparentColor: TColor read GetTransparentColor write SetTransparentColor;

    property WorkBitmap: TfcBitmap read FWorkBitmap;
  end;

  TfcImagerPictureType = (fcptBitmap,fcptJpg,fcptMetafile,fcptIcon);
  type TfcDBImager=class;

  TfcCalcPictureTypeEvent =
    procedure (ImageControl:TfcDBImager;var PictureType:TfcImagerPictureType;var GraphicClassName:String) of object;

  TfcDBImager = class(TfcDBCustomImager)
  private
    FDataLink: TFieldDataLink;
    FPictureLoaded: boolean;
    FAutoDisplay: Boolean;
    FBorderStyle: TBorderStyle;
    FPictureType:TfcImagerPictureType;
    FOnCalcPictureType: TfcCalcPictureTypeEvent;

    procedure SetPictureType(Value:TfcImagerPictureType);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetAutoDisplay(Value: Boolean);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure LoadPicture; virtual;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure DoExit; override;
    procedure Paint; override;
    procedure BitmapChange(Sender: TObject); override;
    function GetPalette: HPALETTE; override;
    function PaletteChanged(Foreground: Boolean): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CopyToClipboard; virtual;
    procedure PasteFromClipboard; virtual;
    procedure CutToClipboard; virtual;
    procedure DoCalcPictureType(var PictureType:TfcImagerPictureType;var GraphicClassName:String); virtual;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;

    property Field: TField read GetField;

  published
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property Ctl3D;
    property Color default clWindow;
    property ParentCtl3D;
    property ParentColor default False;
    property PictureType: TfcImagerPictureType read FPictureType write SetPictureType default fcptBitmap;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;

    property Align;
    property AutoSize;
    property BitmapOptions;
    property DrawStyle;
//    property Picture;
    property PreProcess;
    property RespectPalette;
    property SmoothStretching;
    property Transparent;
    property TransparentColor;
    property Visible;

    property Anchors;
    property Constraints;
    property OnEndDock;
    property OnStartDock;
    property OnClick;
    property OnCalcPictureType: TfcCalcPictureTypeEvent read FOnCalcPictureType write FOnCalcPictureType;

    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property TabOrder;
    property TabStop;
    property OnKeyPress;
    property OnKeyDown;
    property OnKeyUp;
    property OnEnter;
    property OnExit;
  end;

implementation

uses clipbrd;

constructor TfcRotate.Create(BitmapOptions: TfcBitmapOptions);
begin
  inherited Create;
  FCenterX := -1;
  FCenterY := -1;
  FBitmapOptions := BitmapOptions;
end;

procedure TfcRotate.SetCenterX(Value: Integer);
begin
  if FCenterX <> Value then
  begin
    FCenterX := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcRotate.SetCenterY(Value: Integer);
begin
  if FCenterY <> Value then
  begin
    FCenterY := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcRotate.SetAngle(Value: Integer);
begin
  if FAngle <> Value then
  begin
    FAngle := Value;
    FBitmapOptions.Changed;
  end;
end;

constructor TfcAlphaBlend.Create(BitmapOptions: TfcBitmapOptions);
begin
  inherited Create;
  FBitmapOptions := BitmapOptions;
  FBitmap := TfcBitmap.Create;
//  FBitmap.OnChange := BitmapChanged;
end;

destructor TfcAlphaBlend.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TfcAlphaBlend.BitmapChanged(Sender: TObject);
begin
  if FChanging then Exit;
  FChanging := True;
  FBitmapOptions.Changed;
  FChanging := False;
end;

function TfcAlphaBlend.GetTransparent: Boolean;
begin
  result := Bitmap.Transparent;
end;

procedure TfcAlphaBlend.SetTransparent(Value: Boolean);
begin
  Bitmap.Transparent := Value;
end;

procedure TfcAlphaBlend.SetAmount(Value: Byte);
begin
  if FAmount <> Value then
  begin
    FAmount := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcAlphaBlend.SetBitmap(Value: TfcBitmap);
begin
  FBitmap.Assign(Value);
end;

constructor TfcWave.Create(BitmapOptions: TfcBitmapOptions);
begin
  inherited Create;
  FBitmapOptions := BitmapOptions;
end;

procedure TfcWave.SetXDiv(Value: Integer);
begin
  if FXDiv <> Value then
  begin
    FXDiv := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcWave.SetYDiv(Value: Integer);
begin
  if FYDiv <> Value then
  begin
    FYDiv := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcWave.SetRatio(Value: Integer);
begin
  if FRatio <> Value then
  begin
    FRatio := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcWave.SetWrap(Value: Boolean);
begin
  if FWrap <> Value then
  begin
    FWrap := Value;
    FBitmapOptions.Changed;
  end;
end;

constructor TfcBitmapOptions.Create(AComponent: TComponent);
begin
  inherited Create;
  FComponent := AComponent;

  FAlphaBlend := TfcAlphaBlend.Create(self);
  FRotation := TfcRotate.Create(self);
  FColor := clNone;
  FTintColor := clNone;
  FSaturation := -1;
  FWave := TfcWave.Create(self);
end;

destructor TfcBitmapOptions.Destroy;
begin
  FAlphaBlend.Free;                    
  FRotation.Free;
  FWave.Free;
  inherited;
end;

procedure TfcBitmapOptions.Changed;
var TmpBitmap: TfcBitmap;
begin
  if (csLoading in FComponent.ComponentState) or DestBitmap.Empty or ((OrigPicture.Graphic = nil) or OrigPicture.Graphic.Empty) or (FUpdateLock > 0) then Exit;
  if (DestBitmap.Width = OrigPicture.Width) and (DestBitmap.Height = OrigPicture.Height) then
    DestBitmap.Assign(OrigPicture.Graphic)
  else begin
    if Tile then fcTileDraw(OrigPicture.Graphic, DestBitmap.Canvas, Rect(0, 0, DestBitmap.Width, DestBitmap.Height))
    else begin
      TmpBitmap := TfcBitmap.Create;
      TmpBitmap.Assign(OrigPicture.Graphic);
      if FComponent is TfcCustomImager then
         TmpBitmap.SmoothStretching := TfcCustomImager(FComponent).SmoothStretching
      else if FComponent is TfcDBCustomImager then
         TmpBitmap.SmoothStretching := TfcDBCustomImager(FComponent).SmoothStretching;
      try
        DestBitmap.Canvas.StretchDraw(Rect(0, 0, DestBitmap.Width, DestBitmap.Height), TmpBitmap);
      finally
        TmpBitmap.Free;
      end;
    end;
  end;

  if FGrayScale then DestBitmap.GrayScale;
  if FLightness <> 0 then DestBitmap.Brightness(FLightness);
  if (FAlphaBlend.Amount <> 0) and not FAlphaBlend.Bitmap.Empty then
    DestBitmap.AlphaBlend(FAlphaBlend.Bitmap, FAlphaBlend.Amount, True);
  if FColor <> clNone then with fcGetColor(ColorToRGB(FColor)) do
    DestBitmap.Colorize(r, g, b);
  if FTintColor <> clNone then with fcGetColor(ColorToRGB(FTintColor)) do
    DestBitmap.ColorTint(r div 2, g div 2, b div 2);
  if FSponge <> 0 then DestBitmap.Sponge(FSponge);
  if FSaturation <> -1 then DestBitmap.Saturation(FSaturation);
  if FGaussianBlur <> 0 then DestBitmap.GaussianBlur(FGaussianBlur);
  if FEmbossed then DestBitmap.Emboss;
  if FInverted then DestBitmap.Invert;
  if FContrast <> 0 then DestBitmap.Contrast(FContrast);
  if FSharpen <> 0 then DestBitmap.Sharpen(FSharpen);
  if FHorizontallyFlipped then DestBitmap.Flip(True);
  if FVerticallyFlipped then DestBitmap.Flip(False);
  with FWave do if (Ratio <> 0) and (XDiv <> 0) and (YDiv <> 0) then
    DestBitmap.Wave(XDiv, YDiv, Ratio, Wrap);
  if FRotation.Angle <> 0 then with Rotation do
    DestBitmap.Rotate(Point(CenterX, CenterY), Angle);

  if Assigned(FOnChange) then FOnChange(self);
end;

procedure TfcBitmapOptions.BeginUpdate;
begin
  inc(FUpdateLock);
end;

procedure TfcBitmapOptions.EndUpdate;
begin
  if FUpdateLock > 0 then dec(FUpdateLock);
  Changed;
end;

procedure TfcBitmapOptions.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TfcBitmapOptions.SetTintColor(Value: TColor);
begin
  if FTintColor <> Value then
  begin
    FTintColor := Value;
    Changed;
  end;
end;

procedure TfcBitmapOptions.SetIntegralProperty(Index: Integer; Value: Integer);
  procedure DoCheck(StorageVar: PInteger);
  begin
    if StorageVar^ <> Value then
    begin
      StorageVar^ := Value;
      Changed;
    end;
  end;
begin
  case Index of
    0: DoCheck(@FLightness);
    1: DoCheck(@FSaturation);
    2: DoCheck(@FSponge);
    3: DoCheck(@FGaussianBlur);
    4: DoCheck(@FContrast);
    5: DoCheck(@FSharpen);
  end;
end;

type PBoolean = ^Boolean;

type TfcIcon = class(TIcon)
protected
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
end;

type TCheatCanvas=class(TCanvas);

procedure TfcIcon.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
  with Rect.TopLeft do
  begin
    TCheatCanvas(ACanvas).RequiredState([csHandleValid]);
    DrawIconEx(ACanvas.Handle, X, Y, Handle, Rect.Right-Rect.Left, Rect.Bottom-Rect.Top, 0, 0, DI_NORMAL);
  end;
end;

procedure TfcBitmapOptions.SetBooleanProperty(Index: Integer; Value: Boolean);
  procedure DoCheck(StorageVar: PBoolean);
  begin
    if StorageVar^ <> Value then
    begin
      StorageVar^ := Value;
      Changed;
    end;
  end;
begin
  case Index of
    0: DoCheck(@FEmbossed);
    1: DoCheck(@FInverted);
    2: DoCheck(@FGrayScale);
    3: DoCheck(@FHorizontallyFlipped);
    4: DoCheck(@FVerticallyFlipped);
  end;
end;

constructor TfcCustomImager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEraseBackground:= True;
  FPicture := TPicture.Create;
  FPicture.OnChange := BitmapChange;
  FWorkBitmap := TfcBitmap.Create;
  FRespectPalette:= True;
  FWorkBitmap.RespectPalette := True;
  FWorkBitmap.UseHalftonePalette:= True;
  FBitmapOptions := TfcBitmapOptions.Create(self);
  FBitmapOptions.OnChange := BitmapOptionsChange;
  FBitmapOptions.DestBitmap := FWorkBitmap;
  FBitmapOptions.OrigPicture := FPicture;
  ControlStyle := ControlStyle + [csOpaque];
  FPreProcess := True;
  FShowFocusRect:=False;
  FFocusable := False;
  FTabStop := False;
  FChangeLinks := TList.Create;
  Width := 100;
  Height := 100;
end;

destructor TfcCustomImager.Destroy;
begin
  FPicture.Free;
  FPicture:= nil;
  FBitmapOptions.Free;
  FWorkBitmap.Free;
  FChangeLinks.Free;
  inherited Destroy;
end;

function TfcCustomImager.GetDrawRect: TRect;
begin
  case DrawStyle of
    dsNormal: result := Rect(0, 0, Picture.Width, Picture.Height);
    dsCenter: with Point(Width div 2 - FWorkBitmap.Width div 2,
        Height div 2 - FWorkBitmap.Height div 2) do
      result := Rect(x, y, Width - x, Height - y);
    dsTile, dsStretch: result := Rect(0, 0, Width, Height);
    dsProportional: result := fcProportionalRect(Rect(0, 0, Width, Height),
                              FWorkBitmap.Width, FWorkBitmap.Height);
    dsProportionalCenter: result := fcProportionalCenterRect(Rect(0, 0, Width, Height),
                                    FWorkBitmap.Width, FWorkBitmap.Height);
  end
end;

procedure TfcCustomImager.SetDrawStyle(Value: TfcImagerDrawStyle);
begin
  if FDrawStyle <> Value then
  begin
    FDrawStyle := Value;
    BitmapOptions.Tile := FDrawStyle = dsTile;
    Resized;
    Invalidate;
  end;
end;

procedure TfcCustomImager.SetEraseBackground(Value: Boolean);
var r: TRect;
begin
  if FEraseBackground <> Value then
  begin
    FEraseBackground := Value;
    if Parent <> nil then begin
       r:= BoundsRect;
       InvalidateRect(Parent.Handle, @r, True);
    end
  end;
end;

procedure TfcCustomImager.SetParent(Value: TWinControl);
begin
  inherited;
end;

procedure TfcCustomImager.BitmapOptionsChange(Sender: TObject);
var r: TRect;
begin
  if Parent <> nil then
  begin
    r := BoundsRect;
    InvalidateRect(Parent.Handle, @r, Transparent);
  end;
  NotifyChanges;
end;

procedure TfcCustomImager.NotifyChanges;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do with TfcChangeLink(FChangeLinks[i]) do
  begin
    Sender := WorkBitmap;
    Change;
  end;
end;

function TfcCustomImager.GetColorAtPoint(X,Y:Integer):TColor;
begin
  result := clNone;
  if (Canvas <> nil) then result := Canvas.Pixels[X, Y];
end;

procedure TfcCustomImager.BitmapChange(Sender: TObject);
var r: TRect;
begin
  Resized;
  r := BoundsRect;
  if Parent<>nil then { 8/2/99 }
     InvalidateRect(Parent.Handle, @r, True);
  NotifyChanges;
end;

procedure TfcCustomImager.Resized;
begin
  if csLoading in ComponentState then Exit;
  if not PreProcess and not (DrawStyle in [dsNormal, dsCenter]) then
    FWorkBitmap.SetSize(Width, Height)
  else begin
     if BitmapOptions.Rotation.Angle <> 0 then { 10/5/99 }
        FWorkBitmap.SetSize(fcMax(Picture.Width, Picture.Height), fcMax(Picture.Height, Picture.Width))
     else
        FWorkBitmap.SetSize(Picture.Width, Picture.Height)
  end;
  UpdateWorkBitmap;
  UpdateAutoSize;
end;

procedure TfcCustomImager.UpdateAutoSize;
begin
  if FAutoSize and not PictureEmpty and not (csLoading in ComponentState) and (Align = alNone) then
  begin
    UpdatingAutosize := True;
    if (Width <> Picture.Width) or (Height <> Picture.Height) then
      SetBounds(Left, Top, Picture.Width, Picture.Height);
    UpdatingAutosize := False;
  end;
end;

procedure TfcCustomImager.UpdateWorkBitmap;
begin
  if not PictureEmpty and not (csLoading in ComponentState) then
  begin
    if FWorkBitmap.Empty then Resized;
    BitmapOptions.Changed;
  end;
end;

procedure TfcCustomImager.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TfcCustomImager.SetPreProcess(Value: Boolean);
begin
  if FPreProcess <> Value then
  begin
    FPreProcess := Value;
    Resized;
  end;
end;

procedure TfcCustomImager.SetTransparent(Value: Boolean);
begin
  FTransparent:=Value;
  if not PictureEmpty then Picture.Graphic.Transparent := Value;
  Invalidate;
end;

procedure TfcCustomImager.SetTransparentColor(Value: TColor);
begin
  WorkBitmap.TransparentColor := Value;
  UpdateWorkBitmap;
  Invalidate;
  ColorToString(clNone);
end;

function TfcCustomImager.GetRespectPalette;
begin
  result:= FRespectPalette;
end;

function TfcCustomImager.GetSmoothStretching: Boolean;
begin
  result := WorkBitmap.SmoothStretching;
end;

function TfcCustomImager.GetTransparent: Boolean;
begin
  result:= FTransparent;
//  result := False;                   
//  if not PictureEmpty then result := Picture.Graphic.Transparent;
end;

function TfcCustomImager.GetTransparentColor: TColor;
begin
  result := WorkBitmap.TransparentColor;
end;

procedure TfcCustomImager.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateAutoSize;
  end;
end;
{
procedure TfcCustomImager.SetBitmap(Value: TfcBitmap);
begin
  FBitmap.Assign(Value);
end;
}

function TfcCustomImager.PictureEmpty: Boolean;
begin
  result := (FPicture=Nil) or (FPicture.Graphic = nil) or (FPicture.Graphic.Empty);
end;

procedure TfcCustomImager.Invalidate;
var r: TRect;
begin
  if InSetBounds then exit;
  r := BoundsRect;
  if Parent <> nil then InvalidateRect(Parent.Handle, @r, True);
end;

procedure TfcCustomImager.RegisterChanges(ChangeLink: TfcChangeLink);
begin
  FChangeLinks.Add(ChangeLink);
end;

procedure TfcCustomImager.UnRegisterChanges(ChangeLink: TfcChangeLink);
begin
  FChangeLinks.Remove(ChangeLink);
end;

procedure TfcCustomImager.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var SizeChanged: Boolean;
    OldControlStyle: TControlStyle;
begin
  SizeChanged := (AWidth <> Width) or (AHeight <> Height);
  if SizeChanged and not UpdatingAutosize then begin
     InSetBounds:= True; { RSW - Don't erase background when resizing }
     { 5/7/99 - Setting parent to opaque so it doesn't clear background.
       This allows imager to not flicker when resizing imager }
     if Parent<>nil then
     begin
        OldControlStyle:= Parent.ControlStyle;
        Parent.ControlStyle:= Parent.ControlStyle + [csOpaque];
     end;
     inherited;
     if Parent<>nil then Parent.ControlStyle:= OldControlStyle;
     if Visible then Update;
     Resized;
     InSetBounds:= False;
  end
  else inherited;
end;

procedure TfcCustomImager.SetRespectPalette(Value: Boolean);
begin
  FRespectPalette:= Value;
  WorkBitmap.RespectPalette := Value;
  if value then
     if (BitmapOptions.Color<>clNone) or (BitmapOptions.TintColor<>clNone) then
        WorkBitmap.RespectPalette:= False;

  Invalidate;
end;

procedure TfcCustomImager.SetFocus;
begin
   inherited;
   if FWinControl <> nil then
     FWinControl.SetFocus;
end;

procedure TfcCustomImager.SetShowFocusRect(Value: Boolean);
begin
  if Value <> FShowFocusRect then
     FShowFocusRect := Value;
end;

procedure TfcCustomImager.SetSmoothStretching(Value: Boolean);
begin
  WorkBitmap.SmoothStretching := Value;
  UpdateWorkBitmap;
  Invalidate;
end;

procedure TfcCustomImager.Paint;
var r:TRect;
begin
  inherited;
  if csDestroying in ComponentState then exit;

  if FWorkBitmap.Empty and not PictureEmpty then
  begin
    UpdateWorkBitmap;
    Exit;
  end;

  if (csDesigning in ComponentState) and FWorkBitmap.Empty then with Canvas do
  begin
    Pen.Style := psDash;
    Pen.Color := clBlack;
    Brush.Color := clWhite;
    Rectangle(0, 0, Width, Height);
    Exit;
  end;
  if FWorkBitmap.Empty then Exit;

  try
    with GetDrawRect do
      if PreProcess then
        case DrawStyle of
          dsNormal: Canvas.Draw(Left, Top, FWorkBitmap);
          dsCenter: Canvas.Draw(Left, Top, FWorkBitmap);
          dsTile: FWorkBitmap.TileDraw(Canvas, Rect(Left, Top, Right, Bottom));
          dsStretch: Canvas.StretchDraw(Rect(Left, Top, Right, Bottom), FWorkBitmap);
          dsProportional,dsproportionalCenter: Canvas.StretchDraw(Rect(Left, Top, Right, Bottom), FWorkBitmap);
        end
      else Canvas.Draw(Left, Top, FWorkBitmap);
  finally
{    if Transparent then fcTransparentDraw(Canvas, Rect(0, 0, Width, Height), DrawBitmap, DrawBitmap.Canvas.Pixels[0, 0])
    else Canvas.Draw(0, 0, DrawBitmap);}
  end;

  if Focused and ShowFocusRect then begin
    r:= ClientRect;
    Canvas.DrawFocusRect(r);
  end;

end;


(*procedure TfcCustomImager.ParentMessages(var Message: TMessage; var ProcessMessage: Boolean);
var s: TfcCustomImager;
begin
  if csDestroying in ComponentState then exit;

  if not PictureEmpty and ((not EraseBackground) or InSetBounds) and
{     not (csDesigning in ComponentState) and}  { 4/27/99 - Comment out - RSW }
     (Message.Msg = WM_ERASEBKGND) then//and not (DrawStyle in [dsNormal, dsProportional]) {and (Align = alClient) }then { 3/19/99 - Comment out alClient to prevent flicker of form}
  begin
    with TWMEraseBkGnd(Message) do
    begin
      Result := 1;
      ProcessMessage := False;
    end;
  end
end;
*)
procedure TfcCustomImager.Loaded;
begin
  inherited;
  UpdateAutoSize;
  FBitmapOptions.Changed;
end;

procedure TfcCustomImager.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

procedure TfcCustomImager.CutToClipboard;
begin
  if Picture.Graphic <> nil then
  begin
    CopyToClipboard;
    Picture.Graphic := nil;
  end;
end;

procedure TfcCustomImager.CopyToClipboard;
var tempBitmap: TBitmap;
begin
   tempBitmap:= TBitmap.create;
   WorkBitmap.SaveToBitmap(tempBitmap);
   Clipboard.Assign(tempBitmap);
   tempBitmap.Free;
end;

procedure TfcCustomImager.WndProc(var Message: TMessage);
begin
  inherited;
end;

type
 TfcImagerWinControl = class(TWinControl)
 private
    Imager: TfcCustomImager;
 protected
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
 public
    constructor Create(AOwner: TComponent); override;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
 end;

constructor TfcImagerWinControl.Create(AOwner: TComponent);
begin
   inherited;
   ControlStyle := ControlStyle + [csReplicatable];
   Imager:= AOwner as TfcCustomImager;
end;

procedure TfcImagerWinControl.CMEnter(var Message: TCMEnter);
begin
  Imager.DoEnter;
end;

procedure TfcImagerWinControl.CMExit(var Message: TCMExit);
begin
  Imager.DoExit;
end;

procedure TfcImagerWinControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
   inherited KeyDown(Key, Shift);
   Imager.KeyDown(Key, Shift);
end;

procedure TfcImagerWinControl.KeyUp(var Key: Word; Shift: TShiftState);
begin
   inherited KeyUp(Key, Shift);
   Imager.KeyUp(Key, Shift);
end;

procedure TfcImagerWinControl.KeyPress(var Key: Char);
begin
   inherited KeyPress(Key);
   Imager.KeyPress(Key);
end;

constructor TfcDBImager.Create(AOwner: TComponent);
begin
   inherited;
   ControlStyle := ControlStyle + [csReplicatable];
   FPictureType := fcptBitmap;
   FBorderStyle := bsSingle;
   FAutoDisplay:=True;
   FDataLink := TFieldDataLink.Create;
   FDataLink.Control := Self;
   FDataLink.OnDataChange := DataChange;
   FDataLink.OnUpdateData := UpdateData;
end;

destructor TfcDBImager.Destroy;
begin
   FDataLink.Free;
   FDataLink:=nil;
   inherited Destroy;
end;

procedure TfcDBImager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TfcDBImager.LoadPicture;
var j:TGraphic;
  ms:Tmemorystream;
  w:TMetaFile;
  ic:TfcIcon;
  pt:TfcImagerPictureType;
  gclassname:string;
begin
   if FDataLink.Field = nil then begin
      Picture.Assign(nil);
//      WorkBitmap.FreeMemoryImage;
      WorkBitmap.Clear;
      exit;
   end;

  if not FPictureLoaded and (not Assigned(FDataLink.Field) or
    FDataLink.Field.IsBlob) then
  begin
    pt:=PictureType;
    gclassname:='';
    DoCalcPictureType(pt,gclassname);
    case pt of
      fcptBitmap: begin
         try
           Picture.Assign(FDataLink.Field);
         except
         end;
        end;
      fcptJpg:
        begin
//            RegisterClass(TJpegImage);
//            j:=tjpegimage.create;
            if gclassname = '' then gclassname := 'TJPEGImage';
            if (GetClass(gclassname) = nil) then exit;
            j:= TGraphic(TGraphicClass(GetClass(gclassname)).create);
            ms:=tmemorystream.create;
            try
              tblobfield(FDataLink.Field).savetostream(ms);
              ms.seek(sofrombeginning,0);

              with j do begin
{                pixelformat := jf24bit;
                scale := jsfullsize;
                grayscale := False;
                performance := jpbestquality;
                progressivedisplay := True;
                progressiveencoding := True;}
                LoadFromStream(ms);
              end;
              Picture.assign(j);
            finally
               j.free;
               ms.free;
            end;
          end;
      fcptIcon:
        begin
          ic:=tfcIcon.create;
          ms:=tmemorystream.create;
          try
            tblobfield(FDataLink.Field).savetostream(ms);
            ms.seek(sofrombeginning,0);
            with ic do begin
              loadfromstream(ms);
            end;
            Picture.Assign(ic);
          finally
             ic.free;
             ms.free;
          end;
        end;
      fcptMetafile:
        begin
          w:=TMetaFile.create;
          ms:=tmemorystream.create;
          try
            tblobfield(FDataLink.Field).savetostream(ms);
            Picture.assign(w);
            ms.seek(sofrombeginning,0);
            with w do begin
              Picture.Metafile.loadfromstream(ms);
            end;
          finally
             w.free;
             ms.free;
          end;
        end;
      end;

     if Picture.Graphic<>nil then
        Picture.Graphic.Transparent:=Transparent;
    Invalidate;
  end;
end;

procedure TfcDBImager.DataChange(Sender: TObject);
begin
  Picture.Graphic := nil;
  FWorkBitmap.Clear;
  FPictureLoaded := False;
  if FAutoDisplay then LoadPicture;
end;

procedure TfcDBImager.UpdateData(Sender: TObject);
begin
  if Picture.Graphic is TBitmap then
     FDataLink.Field.Assign(Picture.Graphic) else
     FDataLink.Field.Clear;
end;


function TfcDBImager.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TfcDBImager.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TfcDBImager.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TfcDBImager.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TfcDBImager.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TfcDBImager.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TfcDBImager.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TfcDBImager.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TfcDBImager.CutToClipboard;
begin
  if Picture.Graphic <> nil then
    if FDataLink.Edit then
    begin
      CopyToClipboard;
      Picture.Graphic := nil;
    end;
end;

procedure TfcDBImager.CopyToClipboard;
begin
  if Picture.Graphic <> nil then Clipboard.Assign(Picture);
end;

procedure TfcCustomImager.PasteFromClipboard;
begin
  if Clipboard.HasFormat(CF_BITMAP) then
  begin
    Picture.Bitmap.Assign(Clipboard);
    Picture.Graphic.Transparent:=Transparent;
  end
end;

procedure TfcDBImager.PasteFromClipboard;
begin
  if Clipboard.HasFormat(CF_BITMAP) and FDataLink.Edit then
  begin
    Picture.Bitmap.Assign(Clipboard);
    Picture.Graphic.Transparent:=Transparent;
  end
end;

procedure TfcCustomImager.DoEnter;
begin
  try
    if Assigned(FOnEnter) then FOnEnter(Self);
    FFocused := True;
    Invalidate; { Draw the focus marker }
  except
  end;
end;

procedure TfcCustomImager.DoExit;
begin
  try
   if Assigned(FOnExit) then FOnExit(Self);
   FFocused := False;
   Invalidate; { Erase the focus marker }
  except
  end;
end;


procedure TfcDBImager.DoExit;
begin
    try
      FDataLink.UpdateRecord;
    except
      SetFocus;
      raise;
    end;
    Invalidate; { Erase the focus marker }
    inherited;
end;

procedure TfcCustomImager.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnKeyUp) then FOnKeyUp(Self, Key, Shift);
end;

procedure TfcCustomImager.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOnKeyDown) then FOnKeyDown(Self, Key, Shift);
  case Key of
    VK_INSERT:
      if ssShift in Shift then PasteFromClipBoard else
        if ssCtrl in Shift then CopyToClipBoard;
    VK_DELETE:
      if ssShift in Shift then CutToClipBoard;
  end;
end;

procedure TfcCustomImager.KeyPress(var Key: Char);
begin
  if Assigned(FOnKeyPress) then FOnKeyPress(self, Key);
  case Key of
    ^X: CutToClipBoard;
    ^C: CopyToClipBoard;
    ^V: PasteFromClipBoard;
  end;
end;

procedure TfcDBImager.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    ^X: CutToClipBoard;
    ^C: CopyToClipBoard;
    ^V: PasteFromClipBoard;
    #13: LoadPicture;
    #27: FDataLink.Reset;
  end;
end;

procedure TfcCustomImager.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
   inherited;
   if FWinControl<>nil then FWinControl.SetFocus;
end;

Function TfcCustomImager.CreateImagerWinControl: TWinControl;
var WinControl: TWinControl;
begin
   WinControl:= TfcImagerWinControl.create(self);
   with WinControl do begin
      visible:=true;
      Left:=0;
      Top:=0;
      Height:=0;
      Width:=0;
      Parent:=self.Parent;
      TabStop:=self.TabStop;
   end;
   result:= WinControl;
end;

procedure TfcCustomImager.SetFocusable(Value: boolean);
begin
   if Value<>FFocusable then begin
      FFocusable:=Value;
      if (Value or Focusable) then begin
          if (FWinControl=nil) then
             FWinControl:= CreateImagerWinControl;
          FWinControl.TabStop:=TabStop;
      end
      else begin
         if FWinControl <> nil then begin
           FWinControl.Free;
           FWinControl:=nil;
         end;
      end
   end
end;

procedure TfcCustomImager.SetTabStop(Value: boolean);
begin
   if Value<>FTabStop then begin
      FTabStop:=Value;
      if (Value or Focusable)then begin
          if (FWinControl=nil) then
             FWinControl:= CreateImagerWinControl;
          FWinControl.TabStop:=Value;
      end
      else begin
         if FWinControl <> nil then begin
            FWinControl.Free;
            FWinControl:=nil;
         end;
      end
   end
end;

procedure TfcCustomImager.SetTabOrder(Value: integer);
begin
   if Value<>FTabOrder then begin
      FTabOrder:=Value;
      if (Focusable) then begin
          if (FWinControl=nil) then
             FWinControl:= CreateImagerWinControl;
          FWinControl.TabOrder:=Value;
      end
      else begin
         if FWinControl <> nil then begin
           FWinControl.Free;
           FWinControl:=nil;
         end;
      end
   end
end;

procedure TfcDBImager.Paint;
var Form: TCustomForm;
//    tempImager: TfcImager;
    DrawPict: TPicture;
    CenterRect: TRect;
    r: TRect;
    j:TGraphic;
    w:TMetaFile;
    ms:TMemoryStream;
    pt:TfcImagerPictureType;
    ic:TfcIcon;
    {i,}x,y,pad:integer;
    gclassname:string;
//    pal: HPalette;
begin
   if csDestroying in ComponentState then exit;

   // Suggestion to add a new property to disablebitmapoptions.  THen
   // images will always look the same even in the non-csPaintcopy State.
{   if FDisableBitmapOptions and (not Transparent) and
       not ((DrawStyle=dsTile) or (DrawStyle=DsStretch)) then
   begin
      Canvas.Brush.Color:=Color;
      Canvas.FillRect(ClientRect);
   end;}

   if ((csPaintCopy in ControlState) {or FDisableBitmapOptions}) and
      Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
   begin
//      Canvas.Brush.Color:=TEdit(parent).color;
//      Canvas.FillRect(ClientRect);

      DrawPict := TPicture.Create;
      pt:=PictureType;
      gclassname := '';
      DoCalcPictureType(pt,gclassname);
      case pt of
        fcptBitmap: begin
           try
             DrawPict.Assign(FDataLink.Field);
           except
           end;
          end;
        fcptJpg:
          begin
            if gclassname = '' then gclassname := 'TJPEGImage';
            if (GetClass(gclassname) = nil) then exit;
//          j:= TGraphic(TGraphicClass(GetClass('TJPEGImage')).create);
            // 1/16/2002 - Should use gclassname!!
            j:= TGraphicClass(GetClass(gclassname)).create;
            ms:=tmemorystream.create;
            try
              tblobfield(FDataLink.Field).savetostream(ms);
              ms.seek(sofrombeginning,0);

              with j do begin
{                pixelformat := jf24bit;
                scale := jsfullsize;
                grayscale := False;
                performance := jpbestquality;
                progressivedisplay := True;
                progressiveencoding := True;}
                LoadFromStream(ms);
              end;
              DrawPict.assign(j);
            finally
               j.free;
               ms.free;
            end;
          end;
        fcptIcon:
          begin
            ic:=tfcIcon.create;
            ms:=tmemorystream.create;
            try
              tblobfield(FDataLink.Field).savetostream(ms);
              ms.seek(sofrombeginning,0);
              ic.LoadFromStream(ms);
              DrawPict.assign(ic);
            finally
               ic.free;
               ms.free;
            end;
          end;
        fcptMetafile:
          begin
            w:=TMetaFile.create;
            ms:=tmemorystream.create;
            try
              tblobfield(FDataLink.Field).savetostream(ms);
              ms.seek(sofrombeginning,0);
              w.LoadFromStream(ms);
              DrawPict.assign(w);
            finally
               w.free;
               ms.free;
            end;
          end;
        end;


{      case pt of
      fcptBitmap: DrawPict.Graphic.Assign(FDataLink.Field);
//      if DrawPict.Graphic is TBitmap then
//         DrawPict.Bitmap.IgnorePalette := True;

      fcptjpg:
        begin
          j:=tjpegimage.create;
          ms:=tmemorystream.create;
          try
            tblobfield(FDataLink.Field).savetostream(ms);
            Picture.assign(j);
            ms.seek(sofrombeginning,0);
            with j do begin
              pixelformat := jf24bit;
              scale := jsfullsize;
              grayscale := False;
              performance := jpbestquality;
              progressivedisplay := True;
              progressiveencoding := True;
              Picture.Graphic.loadfromstream(ms);
            end;
          finally
             j.free;
             ms.free;
          end;
        end;
      fcptMetaFile:
        begin
          w:= TMetaFile.Create;
          b:=TBitmap.Create;
          ms:=TMemoryStream.Create;
          try
            TBlobField(FDataLink.Field).SaveToStream(ms);
            ms.Seek(soFromBeginning,0);
            with w do begin
              LoadFromStream(ms);
            end;
            b.Width := Width;
            b.Height:= Height;
            b.PixelFormat := pf24bit;
            B.Canvas.Draw(0,0,w);
            DrawPict.Assign(b);
          finally
            w.Free;
            ms.free;
            b.free;
          end;
        end;
      end;}
{


bs:=tblobstream.create(table1picture,bmread);
jpgphoto:=tjpeg...cre
try..
  jpgphoto.loadfromstream(blobstream);
  picture.assign(jpgphoto);
finally
  freee

var jpg:TJpegImage;
stream:TStream;
jpg:=TJpegImage.Create;
Stream:=TMemoryStream.Create;
Table1ImgField.SavetoStream(Stream);
Stream.Position:=0;
jpg.LoadFromStream(Stream);
Image1.pICTURE.gRFAPHIC:=JPG;


tbLOBfIELD* field=(TBlobField*)Table->FieldByName('overlay");
tblobstream*stream=newTBlobstream...
Tjpegimage* image = new TJpegImage
picture.assign(image);
picture.graphic.loadfromstream(stream);
delete(image);

metafile
stream=new(tblobstream(field,bmread);
image1->picture->Metafile->Loadfromstream(stream);

icon
stream=new(tblobstream(field,bmread);
image1->picture->icon->Loadfromstream(stream);


jpg.assign(tblobfield(table1.fieldbyname('picture')));
jpg.dibneeded;
picture.bitmap.assign(jpg);
jpg.free;

field.savetostream(memstream);
memstream.seek(0,0);
jpg.loadfromstream(memstream);
picture.assign(jpg)
jpg.free;
memstream.free;


}
      if DrawPict.Width=0 then exit;

      if Transparent then
         Canvas.CopyMode:= cmSrcAnd
      else
         Canvas.CopyMode:= cmSrcCopy;

      r:= ClientRect;
      r.right:= Width;
      r.bottom:= Height;

      CenterRect:= r;
      CenterRect.Left:= (Width-DrawPict.Width) div 2;
      CenterRect.Top:=  (Height-DrawPict.Height) div 2;

      if (DrawPict.Graphic <> nil) and (DrawPict.Graphic.Palette <> 0) then
      begin
        PaletteChanged(True); // Realizes palette before painting
      end;

      if (not Transparent) and not ((DrawStyle=dsTile) or (DrawStyle=DsStretch)) then
      begin
        Canvas.Brush.Color:=Color;
        Canvas.FillRect(ClientRect);
      end;

      if (DrawPict.Graphic = nil) or DrawPict.Graphic.empty then exit;

      case DrawStyle of
          dsNormal: Canvas.Draw(0, 0, DrawPict.Graphic);
          dsCenter: Canvas.Draw(CenterRect.Left, CenterRect.Top-1, DrawPict.Graphic);
          dsTile, dsStretch: Canvas.StretchDraw(r, DrawPict.Graphic);
          dsProportional: begin
                  //3/14/2002 - Correct for painting in a grid when csPaintCopy State.
                  x:= Trunc(DrawPict.Graphic.Width*(Height / DrawPict.Graphic.Height));
                  y:= Trunc(DrawPict.Graphic.Height*(Width / DrawPict.Graphic.width));
                  if DrawPict.Graphic.Width > DrawPict.Graphic.Height then begin
                     if Height <= y then
                        canvas.stretchdraw(rect(0,0,x,Height),DrawPict.Graphic)
                     else
                        canvas.stretchdraw(rect(0,0,Width,y),DrawPict.Graphic)
                  end
                  else begin
                     if Width <= x then
                       canvas.stretchdraw(rect(0,0,Width,y),DrawPict.Graphic)
                     else canvas.stretchdraw(rect(0,0,x,Height),DrawPict.Graphic);
                  end;
                end;
          dsProportionalCenter:
                begin//!!!!!
                  if (Height>=Width) then
                  begin
                     x:= Trunc(DrawPict.Graphic.Width*(Height / DrawPict.Graphic.Height));
                     y:= Trunc(DrawPict.Graphic.Height*(Width / DrawPict.Graphic.width));
                     if Height <= y then
                     //DrawPict.Graphic.Height > DrawPict.Graphic.Width then
                     begin
//                       i:= Trunc(DrawPict.Graphic.Width*(Height / DrawPict.Graphic.Height));
                       pad := Trunc((Width-x) / 2);
                       canvas.stretchdraw(rect(r.Left+pad,r.Top,r.Left+x+pad,r.Top+Height),DrawPict.Graphic);
                     end
                     else begin
                       y:= Trunc(DrawPict.Graphic.Height*(Width / DrawPict.Graphic.width));
                       pad := Trunc((Height-y) / 2)-1;
                     //  if pt=fcptJpg then dec(pad);
                       canvas.stretchdraw(rect(r.Left,r.Top+pad,r.Left+Width,r.Top+y+pad),DrawPict.Graphic)
                     end;
                  end
                  else begin
                     x:= Trunc(DrawPict.Graphic.Width*(Height / DrawPict.Graphic.Height));
                     y:= Trunc(DrawPict.Graphic.Height*(Width / DrawPict.Graphic.width));
                     if (Width <= x) then
                     begin
                       pad := Trunc((Height-y) / 2);
                     //  if pt=fcptJpg then dec(pad);
                       canvas.stretchdraw(rect(r.Left,r.Top+pad,r.Left+Width,r.Top+y+pad),DrawPict.Graphic)
                     end
                     else begin
                       pad := Trunc((Width-x) / 2)-1;
  //                     if DrawPict.Graphic.Width > DrawPict.Graphic.Height then dec(pad);
                       canvas.stretchdraw(rect(r.Left+pad,r.Top,r.Left+x+pad,r.Top+Height),DrawPict.Graphic);
                     end;
                  end;
                end;

//          dsProportional,dsproportionalcenter: Canvas.StretchDraw(r, DrawPict.Graphic);
      end;
      DrawPict.Free;
      Canvas.CopyMode:= cmSrcCopy;
      exit;
//      Canvas.CopyRect(ClientRect,
//              inherited Canvas, tempRect);

      //    Canvas.Brush.Style := bsClear;
{      tempImager := TfcImager.create(self);
      tempImager.height:= height;
      tempImager.width:=width;
      tempImager.picture.assign(FDataLink.Field);
      if Transparent then
         if not tempImager.PictureEmpty then
            tempImager.Picture.Graphic.Transparent := True;
         tempImager.transparent:=True;

      SetBkMode(Canvas.Handle, windows.TRANSPARENT);
      tempImager.Perform(WM_PAINT, Canvas.Handle, 0);
      SetBkMode(Canvas.Handle, OPAQUE);
      tempImager.Free;
      exit;
}
//      if Picture.Graphic is TBitmap then
//         DrawPict.Bitmap.IgnorePalette := QuickDraw;
   end;

   if not Transparent and not ((DrawStyle=dsTile) or (DrawStyle=DsStretch)) then
   begin
      Canvas.Brush.Color:=Color;
      Canvas.FillRect(ClientRect);
   end;

   inherited;
   Form := GetParentForm(Self);
   if (Form <> nil) and
    (Form.ActiveControl = self) and
     not (csDesigning in ComponentState) and
     not (csPaintCopy in ControlState) then begin
     if not fcisinwwGrid(self) then
     begin
       Canvas.Brush.Color := clWindowFrame;
       r:= ClientRect;
       Canvas.FrameRect(r);
     end
     else begin
     end;
   end;
end;

procedure TfcDBImager.DoCalcPictureType(var PictureType:TfcImagerPictureType;var GraphicClassName:String);
begin
   inherited;
   if Assigned(FOnCalcPictureType) then
      FOnCalcPictureType(Self, PictureType,GraphicClassName);
end;


procedure TfcDBImager.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadPicture;
  end;
end;
                         
procedure TfcDBImager.BitmapChange(Sender: TObject);
begin
  inherited;

  if FPictureLoaded then FDataLink.Modified;
  FPictureLoaded := True;

end;

procedure TfcDBCustomImager.CMEnter(var Message: TCMEnter);
begin
  inherited;
  invalidate; { Draw the focus marker }
end;

procedure TfcDBImager.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TfcDBCustomImager.CMExit(var Message: TCMExit);
begin
  inherited;
  invalidate; { Draw the focus marker }
end;

function TfcDBCustomImager.GetRespectPalette;
begin
  result:= FRespectPalette;
end;

function TfcDBCustomImager.GetSmoothStretching: Boolean;
begin
  result := WorkBitmap.SmoothStretching;
end;

function TfcDBCustomImager.GetTransparent: Boolean;
begin
  result:= FTransparent;
//  result := False;
//  if not PictureEmpty then result := Picture.Graphic.Transparent;
end;


function TfcDBCustomImager.GetTransparentColor: TColor;
begin
  result := WorkBitmap.TransparentColor;
end;

procedure TfcDBCustomImager.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateAutoSize;
  end;
end;

procedure TfcDBCustomImager.SetDrawStyle(Value: TfcImagerDrawStyle);
begin
  if FDrawStyle <> Value then
  begin
    FDrawStyle := Value;
    BitmapOptions.Tile := FDrawStyle = dsTile;
    Resized;
    Invalidate;
  end;
end;

procedure TfcDBCustomImager.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TfcDBCustomImager.SetPreProcess(Value: Boolean);
begin
  if FPreProcess <> Value then
  begin
    FPreProcess := Value;
    Resized;
  end;
end;

procedure TfcDBCustomImager.SetRespectPalette(Value: Boolean);
begin
  FRespectPalette:= Value;
  WorkBitmap.RespectPalette := Value;
  if value then
     if (BitmapOptions.Color<>clNone) or (BitmapOptions.TintColor<>clNone) then
        WorkBitmap.RespectPalette:= False;

  Invalidate;
end;

procedure TfcDBCustomImager.SetSmoothStretching(Value: Boolean);
begin
  WorkBitmap.SmoothStretching := Value;
  UpdateWorkBitmap;
  Invalidate;
end;

procedure TfcDBCustomImager.SetTransparent(Value: Boolean);
begin
  FTransparent:=Value;
  if not PictureEmpty then Picture.Graphic.Transparent := Value;
  if Value then
  begin
     SetWindowLong(Parent.Handle, GWL_STYLE,
       GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
  end;
  Invalidate;
end;

procedure TfcDBCustomImager.SetTransparentColor(Value: TColor);
begin
  WorkBitmap.TransparentColor := Value;
  UpdateWorkBitmap;
  Invalidate;
  ColorToString(clNone);
end;

function TfcDBCustomImager.GetDrawRect: TRect;
begin
  case DrawStyle of
    dsNormal: result := Rect(0, 0, Picture.Width, Picture.Height);
    dsCenter: with Point(Width div 2 - FWorkBitmap.Width div 2,
        Height div 2 - FWorkBitmap.Height div 2) do
      result := Rect(x, y, Width - x, Height - y);
    dsTile, dsStretch: result := Rect(0, 0, Width, Height);
    dsProportional: result := fcProportionalRect(Rect(0, 0, Width, Height), FWorkBitmap.Width, FWorkBitmap.Height);
    dsProportionalCenter: result := fcProportionalCenterRect(Rect(0, 0, Width, Height),
                                    FWorkBitmap.Width, FWorkBitmap.Height);
  end
end;

procedure TfcDBCustomImager.NotifyChanges;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do with TfcChangeLink(FChangeLinks[i]) do
  begin
    Sender := WorkBitmap;
    Change;
  end;
end;

procedure TfcDBCustomImager.BitmapOptionsChange(Sender: TObject);
var r: TRect;
begin
  if Parent <> nil then
  begin
    r := BoundsRect;
    InvalidateRect(Parent.Handle, @r, Transparent);
  end;
  NotifyChanges;
end;

procedure TfcDBCustomImager.BitmapChange(Sender: TObject);
var r: TRect;
begin
  Resized;
  r := BoundsRect;
  //5/30/2001-PYW- Make certain parent's handle has already been allocated.
  if (Parent<>nil) and Parent.HandleAllocated then { 8/2/99 }
     InvalidateRect(Parent.Handle, @r, True);
  NotifyChanges;
end;

procedure TfcDBCustomImager.UpdateAutoSize;
begin
  if FAutoSize and not PictureEmpty and not (csLoading in ComponentState) and (Align = alNone) then
  begin
    UpdatingAutosize := True;
    if (Width <> Picture.Width) or (Height <> Picture.Height) then
      SetBounds(Left, Top, Picture.Width, Picture.Height);
    UpdatingAutosize := False;
  end;
end;

procedure TfcDBCustomImager.Loaded;
begin
  inherited;
  UpdateAutoSize;
  FBitmapOptions.Changed;
end;

procedure TfcDBCustomImager.Paint;
begin
  inherited;
  if csDestroying in ComponentState then exit;

  if FWorkBitmap.Empty and not PictureEmpty then
  begin
    UpdateWorkBitmap;
    Exit;
  end;

  if (csDesigning in ComponentState) and FWorkBitmap.Empty then with Canvas do
  begin
    Pen.Style := psDash;
    Pen.Color := clBlack;
    Brush.Color := clWhite;
    Rectangle(0, 0, Width, Height);
    Exit;
  end;
  if FWorkBitmap.Empty then Exit;

  try
    with GetDrawRect do
      if PreProcess then
        case DrawStyle of
          dsNormal: Canvas.Draw(Left, Top, FWorkBitmap);
          dsCenter: Canvas.Draw(Left, Top, FWorkBitmap);
          dsTile: FWorkBitmap.TileDraw(Canvas, Rect(Left, Top, Right, Bottom));
          dsStretch: Canvas.StretchDraw(Rect(Left, Top, Right, Bottom), FWorkBitmap);
          dsProportional,dsProportionalCenter: Canvas.StretchDraw(Rect(Left, Top, Right, Bottom), FWorkBitmap);
        end
      else Canvas.Draw(Left, Top, FWorkBitmap);
  finally
{    if Transparent then fcTransparentDraw(Canvas, Rect(0, 0, Width, Height), DrawBitmap, DrawBitmap.Canvas.Pixels[0, 0])
    else Canvas.Draw(0, 0, DrawBitmap);}
  end;
end;

constructor TfcDBCustomImager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentColor := False;
  Color:= clWindow;
  FPicture := TPicture.Create;
  FPicture.OnChange := BitmapChange;
  FWorkBitmap := TfcBitmap.Create;
  FRespectPalette:= True;
  FWorkBitmap.RespectPalette := True;
  FWorkBitmap.UseHalftonePalette:= True;
  FBitmapOptions := TfcBitmapOptions.Create(self);
  FBitmapOptions.OnChange := BitmapOptionsChange;
  FBitmapOptions.DestBitmap := FWorkBitmap;
  FBitmapOptions.OrigPicture := FPicture;
  ControlStyle := ControlStyle + [csOpaque];
  FPreProcess := True;
  FChangeLinks := TList.Create;
  Width := 100;
  Height := 100;
end;

destructor TfcDBCustomImager.Destroy;
begin
  FPicture.Free;
  FPicture:= nil;
  FBitmapOptions.Free;
  FWorkBitmap.Free;
  FChangeLinks.Free;
  inherited Destroy;
end;

function TfcDBCustomImager.PictureEmpty: Boolean;
begin
  result := (FPicture=Nil) or (FPicture.Graphic = nil) or (FPicture.Graphic.Empty);
end;

procedure TfcDBCustomImager.Invalidate;
var r: TRect;
begin
  if InSetBounds then exit;
  r := BoundsRect;
  if not HandleAllocated then exit;
  InvalidateRect(Handle, nil, False);
  if Transparent then
    if Parent <> nil then InvalidateRect(Parent.Handle, @r, True);
end;

function TfcDBCustomImager.GetColorAtPoint(X,Y:Integer):TColor;
begin
  result := clNone;
  if (Canvas <> nil) then
     result := Canvas.Pixels[X, Y];

end;

procedure TfcDBCustomImager.RegisterChanges(ChangeLink: TfcChangeLink);
begin
  FChangeLinks.Add(ChangeLink);
end;

procedure TfcDBCustomImager.UnRegisterChanges(ChangeLink: TfcChangeLink);
begin
  FChangeLinks.Remove(ChangeLink);
end;

procedure TfcDBCustomImager.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var SizeChanged: Boolean;
    OldControlStyle: TControlStyle;
begin
  SizeChanged := (AWidth <> Width) or (AHeight <> Height);
  if SizeChanged and not UpdatingAutosize then begin
     InSetBounds:= True; { RSW - Don't erase background when resizing }
     { 5/7/99 - Setting parent to opaque so it doesn't clear background.
       This allows imager to not flicker when resizing imager }
     if Parent<>nil then
     begin
        OldControlStyle:= Parent.ControlStyle;
        Parent.ControlStyle:= Parent.ControlStyle + [csOpaque];
     end;
     inherited;
     if Parent<>nil then Parent.ControlStyle:= OldControlStyle;
     if Visible then Update;
     Resized;
     InSetBounds:= False;
  end
  else inherited;
end;

{procedure TfcDBCustomImager.SetRespectPalette(Value: Boolean);
begin
  FRespectPalette:= Value;
  WorkBitmap.RespectPalette := Value;
  if value then
     if (BitmapOptions.Color<>clNone) or (BitmapOptions.TintColor<>clNone) then
        WorkBitmap.RespectPalette:= False;

  Invalidate;
end;
}
procedure TfcDBImager.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  LoadPicture;
  inherited;
end;

procedure TfcDBImager.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(key,Shift);
  case Key of
    VK_INSERT:
      if ssShift in Shift then PasteFromClipBoard else
        if ssCtrl in Shift then CopyToClipBoard;
    VK_DELETE:
      if ssShift in Shift then CutToClipBoard;
  end;
end;

procedure TfcDBCustomImager.UpdateWorkBitmap;
begin
  if not PictureEmpty and not (csLoading in ComponentState) then
  begin
    if FWorkBitmap.Empty then Resized;
    BitmapOptions.Changed;
  end;
end;

procedure TfcDBCustomImager.Resized;
begin
  if csLoading in ComponentState then Exit;
  if (Picture.Graphic = nil) or (picture.graphic.empty) then exit;
  if not PreProcess and not (DrawStyle in [dsNormal, dsCenter]) then
    FWorkBitmap.SetSize(Width, Height)
  else begin
     if BitmapOptions.Rotation.Angle <> 0 then { 10/5/99 }
        FWorkBitmap.SetSize(fcMax(Picture.Width, Picture.Height), fcMax(Picture.Height, Picture.Width))
     else
        FWorkBitmap.SetSize(Picture.Width, Picture.Height)
  end;
  if not FInResized then begin
    FInResized := True;
    UpdateWorkBitmap;
    FInResized := False;
  end
  else BitmapOptions.Changed;
  UpdateAutoSize;
end;

procedure TfcDBCustomImager.CreateWnd;
begin
   inherited CreateWnd;
   if Transparent then
   begin
      SetWindowLong(Parent.Handle, GWL_STYLE,
       GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
   end;
end;

procedure TfcDBCustomImager.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if Transparent or fcIsClass(parent.classtype, 'TCustomGrid') then
    Message.result:= 1
  else inherited;
end;

procedure TfcDBImager.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if TabStop and CanFocus then SetFocus;
  inherited;
end;

procedure TfcDBImager.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TfcDBImager.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if FBorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
        ExStyle := ExStyle or WS_EX_CLIENTEDGE
      else
        Style := Style or WS_BORDER;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

function TfcDBImager.GetPalette: HPALETTE;
begin
  Result := 0;
  if Picture.Graphic is TBitmap then
    Result := TBitmap(FPicture.Graphic).Palette;
end;

function TfcDBImager.PaletteChanged(Foreground: Boolean): Boolean;
var
  OldPalette, Palette: HPALETTE;
  WindowHandle: HWnd;
  DC: HDC;
begin
  Result := False;

  if (not Visible) and not fcIsClass(parent.classtype, 'TCustomGrid') then exit;

  Palette := GetPalette;
  if Palette <> 0 then
  begin
    DC := GetDeviceContext(WindowHandle);
    OldPalette := SelectPalette(DC, Palette, not Foreground);
    if RealizePalette(DC) <> 0 then Invalidate;
    SelectPalette(DC, OldPalette, True);
    ReleaseDC(WindowHandle, DC);
    Result := True;
  end;
end;

procedure TfcDBImager.SetPictureType(Value: TfcImagerPictureType);
begin
  if Value <> FPictureType then begin
     FPictureType := Value;
     FPicture.Graphic.Free;
     Resized;
  end;
end;

function TfcDBImager.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TfcDBImager.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;


  procedure TfcDBimager.WMEraseBkgnd(var Message: TWmEraseBkgnd);
  begin
     message.result:=1;
  end;


end.
