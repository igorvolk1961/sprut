unit fcpanel;
{
//
// Components : TwwCustomTransparentPanel
//              Supporting component for transparent navigator
//
// Copyright (c) 1999-2001 by Woll2Woll Software
//
// Revision History:
// 10/23/2001-Handle refresh of text when caption changes.
// 11/1/2001 - PYW - Invalidate when setting captionindent or FullBorder.
// 12/19/01 - PYW - Don't call invalidate unless framing or transparent in cmenter, cmexit
//
}
{$i fcIfDef.pas}

interface

uses Windows, Messages, SysUtils, Classes, Controls, Forms,
  CommCtrl, StdCtrls, Buttons, ExtCtrls, Graphics, fcframe;

type
  TfcCustomPanel = class(TCustomPanel)
  private
    FFrame: TfcEditframe;
    FFocused: boolean;
    procedure WMEraseBkGnd(var Message:TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMMove(var Message: TWMMove); Message WM_Move;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    // Property Storage Variables
    FTransparent: Boolean;

    procedure ClipChildren(Value: Boolean);
    procedure CreateWnd; override;

    // Property Access Methods
    procedure SetTransparent(Value: Boolean); virtual;

    // Overridden methods
    procedure Paint; override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetParent(AParent:TWinControl); override;
    function IsTransparent: boolean; virtual;
    function InvalidateNeeded:boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;

    property Frame: TfcEditFrame read FFrame write FFrame;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
  end;

  TfcCustomGroupBox = class(TCustomGroupBox)
  private
    FBorderAroundLabel: boolean;
    FFrame: TfcEditframe;
    FFocused: boolean;
    FCaptionIndent: integer;
    FFullBorder: boolean;
    procedure SetCaptionIndent(Value:Integer);
    procedure SetFullBorder(Value:Boolean);
    procedure WMEraseBkGnd(var Message:TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMMove(var Message: TWMMove); Message WM_Move;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    // Property Storage Variables
    FTransparent: Boolean;

    procedure ClipChildren(Value: Boolean);
    procedure CreateWnd; override;
    procedure Paint; override;
    // Property Access Methods
    procedure SetTransparent(Value: Boolean); virtual;

    // Overridden methods
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetParent(AParent:TWinControl); override;
    function IsTransparent: boolean; virtual;
    function InvalidateNeeded:boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;

    property CaptionIndent: integer read FCaptionIndent write SetCaptionIndent default 8;
    property BorderAroundLabel: boolean read FBorderAroundLabel write FBorderAroundLabel default False;
    property FullBorder: boolean read FFullBorder write SetFullBorder default False;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property Frame: TfcEditFrame read FFrame write FFrame;
  end;

  TfcPanel = class(TfcCustomPanel)
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Frame;
    property Locked;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TfcGroupBox = class(TfcCustomGroupBox)
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderAroundLabel;
    property Caption;
    property CaptionIndent;
    property Color;
    property Constraints;
    property Ctl3D;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Frame;
    property FullBorder;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDockDrop;
    property OnDockOver;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

uses fccommon;

constructor TfcCustomPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFrame:= TfcEditFrame.create(self);
  FTransparent := False;
end;

destructor TfcCustomPanel.Destroy;
begin
  FFrame.Free;
  inherited Destroy;
end;

procedure TfcCustomPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  if IsTransparent then
     Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TfcCustomPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TfcCustomPanel.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  if IsTransparent then Message.result:=1
  else inherited;
end;

procedure TfcCustomPanel.WMMove(var Message: TWMMove);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TfcCustomPanel.ClipChildren(Value: Boolean);
//var tc: TWinControl;
begin
  if (Parent <> nil) then
  begin
      SetWindowLong(Parent.Handle, GWL_STYLE,
        GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
      if HandleAllocated then
        SetWindowLong(Handle, GWL_STYLE,
          GetWindowLong(Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
//    tc:= self;
//
    // Only disable parent clipping, don't enable it
//    while (tc.parent<>nil) do begin
//        SetWindowLong(tc.Parent.Handle, GWL_STYLE,
//          GetWindowLong(tc.Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
//      if tc.parent is TCustomForm then break;
//      tc:= tc.parent;
//      break;
//    end;
  end
end;

procedure TfcCustomPanel.SetParent(AParent:TWinControl);
begin
  inherited SetParent(AParent);

  // Without this, the panel would be transparent indeed, but you would see through the form into the background apps
//  ClipChildren(not FTransparent);
end;

procedure TfcCustomPanel.Invalidate;
var TempRect:TRect;
    r: TRect;
begin
//  inherited;
//  exit;
  if IsTransparent and (Parent <> nil) and Parent.HandleAllocated then
  begin
    GetUpdateRect(Handle, r, False);
    tempRect:= BoundsRect;
    tempRect:= Rect(TempRect.Left + r.Left, TempRect.Top + r.Top,
                    TempRect.Left + r.Right, TempRect.Top + R.Bottom);
    InvalidateRect(Parent.Handle, @TempRect, False);
   // 10/23/01 - The following code causes a transpareant panel to not be transparent in some cases
   // when the form first comes up.  In fact only 1 panel seems to exhibit this problem
   // when having multiple panels or groupboxes.

{    if not fcIsTransparentParent(self) then
       Parent.Update; // Seems necessary for transparent panel in transparent panel when
}
    if (r.left=r.right) and (r.top=r.bottom) then
      InvalidateRect(Handle, nil, False)
    else InvalidateRect(Handle, @r, False);
  end
  else inherited Invalidate;
end;

procedure TfcCustomPanel.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;

    if IsTransparent then ControlStyle := ControlStyle - [csOpaque]
    else begin
       ControlStyle := ControlStyle + [csOpaque];
    end;

    if not (csLoading in ComponentState) and HandleAllocated and
       not (csDesigning in ComponentState) then
    begin
      Invalidate;
      ClipChildren(not Value);
      RecreateWnd;
    end
  end;
end;

Function TfcCustomPanel.IsTransparent: boolean;
begin
   result:= FTransparent and not (csDesigning in ComponentState);
end;

//10/23/2001-Handle refresh of text when caption changes.
procedure TfcCustomPanel.CMTextChanged(var Message: TMessage);
begin
  if (not (csDesigning in ComponentState)) or FTransparent then
     Frame.RefreshTransparentText(True);
  inherited;
end;


procedure TfcCustomPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect: TRect;
  TopColor, BottomColor: TColor;
  FontHeight: Integer;
  Flags: Longint;
  TempRect: TRect;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin
  Rect := GetClientRect;

  if Frame.IsFrameEffective then
  begin
     if (Frame.NonFocusColor<>clNone) and (not FFocused) then
        Canvas.Brush.Color := Frame.NonFocusColor
     else Canvas.Brush.Color := Color;
     if not Transparent then Canvas.FillRect(Rect);
     fcDrawEdge(self, Frame, Canvas, FFocused);
  end
  else begin
     if BevelOuter <> bvNone then
     begin
       AdjustColors(BevelOuter);
       Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
     end;
     Frame3D(Canvas, Rect, Color, Color, BorderWidth);
     if BevelInner <> bvNone then
     begin
       AdjustColors(BevelInner);
       Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
     end;
  end;

  with Canvas do
  begin
    if not Transparent then
    begin
       TempRect:= Rect;
       if not Frame.IsFrameEffective then
       begin
          Brush.Color := Color;
          FillRect(TempRect);
       end;
    end;
    Brush.Style := bsClear;
    Font := Self.Font;
    FontHeight := TextHeight('W');
    with Rect do
    begin
      Top := ((Bottom + Top) - FontHeight) div 2;
      Bottom := Top + FontHeight;
    end;
    Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Alignment];
    Flags := DrawTextBiDiModeFlags(Flags);
    if Frame.IsFrameEffective then
    begin
       if (Frame.NonFocusFontColor<>clNone) and (not FFocused) then
          Font.Color := Frame.NonFocusFontColor
    end;
    DrawText(Handle, PChar(Caption), -1, Rect, Flags);
  end;
end;

constructor TfcCustomGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCaptionIndent := 8;
  FTransparent := False;
  BorderAroundLabel:= false;
  FFullBorder := False;
  FFrame:= TfcEditFrame.create(self);
end;

destructor TfcCustomGroupBox.Destroy;
begin
  FFrame.Free;
  inherited Destroy;
end;

procedure TfcCustomGroupBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  if IsTransparent then
     Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TfcCustomGroupBox.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TfcCustomGroupBox.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  if IsTransparent then Message.result:=1
  else if not Frame.IsFrameEffective then inherited
//  else message.result:=1
  else if Frame.IsFrameEffective and
       (Frame.NonFocusColor<>clNone) then message.result:=1
  else if BorderAroundLabel then message.result:=1 // Don't paint outside text if true
  else inherited;
end;

procedure TfcCustomGroupBox.WMMove(var Message: TWMMove);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TfcCustomGroupBox.ClipChildren(Value: Boolean);
begin
  if (Parent <> nil) then
  begin
      SetWindowLong(Parent.Handle, GWL_STYLE,
        GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
      if HandleAllocated then
        SetWindowLong(Handle, GWL_STYLE,
          GetWindowLong(Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
  end;
end;

procedure TfcCustomGroupBox.SetParent(AParent:TWinControl);
begin
  inherited SetParent(AParent);

  // Without this, the panel would be transparent indeed, but you would see through the form into the background apps
//  ClipChildren(not FTransparent);
end;

procedure TfcCustomGroupBox.CMTextChanged(var Message: TMessage);
begin
  if (not (csDesigning in ComponentState)) or FTransparent then
     Frame.RefreshTransparentText(True);
  inherited;
end;


procedure TfcCustomGroupBox.Invalidate;
var TempRect:TRect;
    r: TRect;
begin
  if IsTransparent and (Parent <> nil) and Parent.HandleAllocated then
  begin
    GetUpdateRect(Handle, r, False);
    tempRect:= BoundsRect;
    tempRect:= Rect(TempRect.Left + r.Left, TempRect.Top + r.Top,
                    TempRect.Left + r.Right, TempRect.Top + R.Bottom);
    InvalidateRect(Parent.Handle, @TempRect, False);


   // 10/23/01 - The following code causes a transpareant panel to not be transparent in some cases
   // when the form first comes up.  In fact only 1 panel seems to exhibit this problem
   // when having multiple panels or groupboxes.

  {    if not fcIsTransparentParent(self) then
       Parent.Update; // Seems necessary for transparent panel in transparent panel when
                      // using splitter between two panels
}
    if (r.left=r.right) and (r.top=r.bottom) then
//      InvalidateRect(Handle, nil, False)  // 7/11/01 - If this code there than 1stclass combos in us cause flicker when dropped-down
    else InvalidateRect(Handle, @r, False);
  end
  else inherited Invalidate;
end;

procedure TfcCustomGroupBox.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;

    if IsTransparent then ControlStyle := ControlStyle - [csOpaque]
    else begin
       ControlStyle := ControlStyle + [csOpaque];
    end;

    if not (csLoading in ComponentState) and HandleAllocated and
       not (csDesigning in ComponentState) then
    begin
      Invalidate;
      ClipChildren(not Value);
      RecreateWnd;
    end
  end;
end;

procedure TfcCustomGroupBox.SetCaptionIndent(Value:Integer);
begin
   if FCaptionIndent <> Value then begin
      FCaptionIndent := fcMax(3,Value);
      Invalidate; // 11/1/2001 - PYW - Invalidate Whole thing.
 //   if (not (csDesigning in ComponentState)) or FTransparent then
 //      Frame.RefreshTransparentText(True);
   end;
end;

procedure TfcCustomGroupBox.SetFullBorder(Value:Boolean);
begin
   if FFullBorder <> Value then begin
      FFullBorder := Value;
      Invalidate; // 11/1/2001 - PYW - Invalidate Whole thing.
//      if (not (csDesigning in ComponentState)) or FTransparent then
//         Frame.RefreshTransparentText(True);
   end;
end;

Function TfcCustomGroupBox.IsTransparent: boolean;
begin
   result:= FTransparent and not (csDesigning in ComponentState);
end;

procedure TfcCustomGroupBox.CreateWnd;
begin
   inherited;
   ClipChildren(not FTransparent);
end;

procedure TfcCustomPanel.CreateWnd;
begin
   inherited;
   ClipChildren(not FTransparent);
end;

procedure TfcCustomGroupBox.Paint;
var
  H: Integer;
  TempRect, R, TextR, FillR: TRect;
  Flags,Pad: Longint;
  Text: string;
  StartText, EndText: integer;

  Function GetRect: TRect;
  begin
     with Canvas do begin
       Font := Self.Font;
       if Text = '' then
         H:= 2
       else begin
          if BorderAroundLabel then
             H := TextHeight('0') + 2 // Add 2 if we are showing border around caption
          else H := TextHeight('0');
       end;
//       if FullBorder and BorderAroundLabel then
       if FullBorder then begin
          if BorderAroundLabel then
             Result := Rect(0, H - 2, Width, Height)
          else Result := Rect(0, H+1, Width, Height);
       end
       else Result := Rect(0, H div 2 - 1, Width, Height);
     end;
  end;

begin
   Text:= Caption;
   if Text='' then exit;

   if text = '' then
      H:= 2
   else
      H:= Canvas.TextHeight('0');

   Pad:=1;

   if not UseRightToLeftAlignment then
     TextR := Rect(CaptionIndent, 0, 0, H)
   else
     TextR := Rect(R.Right - Canvas.TextWidth(Text) - CaptionIndent, 0, 0, H);

   with Canvas do begin
     R:= GetRect;

     if Text = '' then begin
        StartText:= 0;
        EndText:= 0;
     end
     else begin
        StartText:= TextR.Left;
        EndText:= TextR.Left + Canvas.TextWidth(Text);
     end;

     if Frame.IsFrameEffective then
     begin
        if (Frame.NonFocusColor<>clNone) and (not FFocused) then
            Brush.Color := Frame.NonFocusColor
        else Brush.Color := Color;
     end
     else Brush.Color:= Color;

     TempRect:= TextR;
     TempRect.Bottom := TempRect.Bottom+1;
     TempRect.Left:= StartText-3;
     TempRect.Right:= EndText+2;
     if not Transparent then begin
        FillR := r;
        InflateRect(FillR,-1,-1);
        FillRect(FillR);
     end;

     if BorderAroundLabel then
     begin
       if not Transparent then
          FillRect(TempRect);
       Brush.Color := clBtnHighlight;
       Pen.Color:= clBtnHighlight;
       PolyLine([Point(StartText-2, r.Top+1), Point(StartText-2, 1),
                 Point(EndText+2, 1), Point(EndText+2, r.Top)]);

//       PolyLine([Point(StartText-3, r.Top), Point(StartText-3, TextR.Bottom+1),
//                 Point(EndText+2, Textr.Bottom+1), Point(EndText+2, Textr.Top)]);

       Brush.Color := clBtnShadow;
       Pen.Color:= clBtnShadow;
       PolyLine([Point(StartText-3, r.Top), Point(StartText-3, 0),
                 Point(EndText+1, 0), Point(EndText+1, r.Top+1)]);

//       PolyLine([Point(StartText-2, r.Top+1), Point(StartText-2, TextR.Bottom),
//                 Point(EndText+1, TextR.Bottom), Point(EndText+1, r.Top+1)]);
     end
     else if FullBorder then begin
       Pad := 0;
       Brush.Color := clBtnHighlight;
       Pen.Color:= clBtnHighlight;
       PolyLine([Point(StartText-2, r.Top+1), Point(EndText+1, r.Top+1)]);

       Brush.Color := clBtnShadow;
       Pen.Color:= clBtnShadow;
       PolyLine([Point(StartText-3, r.Top), Point(EndText+2, r.Top)]);
     end;
     if Ctl3D then
     begin
       Inc(R.Left);
       Inc(R.Top);
       Brush.Color := clBtnHighlight;
       Pen.Color:= clBtnHighlight;
       if Text = '' then begin
          PolyLine([Point(0, r.top), Point(r.left, r.top), Point(r.left, r.bottom-1),
                 Point(r.right-1, r.bottom-1), Point(r.right-1, r.top),
                 Point(0, r.top)]);
       end
       else begin
          PolyLine([Point(TextR.Left-3, r.top), Point(r.left, r.top), Point(r.left, r.bottom-1),
                 Point(r.right-1, r.bottom-1), Point(r.right-1, r.top),
                 Point(TextR.Left + Canvas.TextWidth(Text)+Pad, r.top)]);

       end;
       OffsetRect(R, -1, -1);
       Brush.Color := clBtnShadow;
       Pen.Color:= clBtnShadow;
     end else
       Brush.Color := clWindowFrame;

     PolyLine([Point(StartText-3, r.top), Point(r.left, r.top), Point(r.left, r.bottom-1),
                 Point(r.right-1, r.bottom-1), Point(r.right-1, r.top),
                 Point(EndText+1, r.top)]);

   end;

   if not UseRightToLeftAlignment then
     R := Rect(CaptionIndent, 0, 0, H)
   else
     R := Rect(R.Right - Canvas.TextWidth(Text) - CaptionIndent, 0, 0, H);
   Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);

   if text = '' then exit;
   if BorderAroundLabel then R.Top:= R.Top + 1;

   Canvas.Font.Color:= Font.Color;
   if Frame.IsFrameEffective then
   begin
      if (Frame.NonFocusFontColor<>clNone) and (not FFocused) then
         Canvas.Font.Color := Frame.NonFocusFontColor
   end;

   with Canvas do begin
      SetBkMode(Handle, windows.TRANSPARENT);
      DrawText(Handle, PChar(Text), Length(Text), R, Flags or DT_CALCRECT);
      SetBkMode(Handle, windows.TRANSPARENT);
      DrawText(Handle, PChar(Text), Length(Text), R, Flags);
   end
end;

{
procedure TfcCustomGroupBox.Paint;
var
  H: Integer;
  R: TRect;
  Flags: Longint;
begin
  with Canvas do
  begin
    Font := Self.Font;
    H := TextHeight('0');
    R := Rect(0, H div 2 - 1, Width, Height);
    if Ctl3D then
    begin
      Inc(R.Left);
      Inc(R.Top);
      Brush.Color := clBtnHighlight;
      FrameRect(R);
      OffsetRect(R, -1, -1);
      Brush.Color := clBtnShadow;
    end else
      Brush.Color := clWindowFrame;
    FrameRect(R);
    if Text <> '' then
    begin
      if not UseRightToLeftAlignment then
        R := Rect(8, 0, 0, H)
      else                         
        R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
      Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
      DrawText(Handle, PChar(Text), Length(Text), R, Flags or DT_CALCRECT);
      Brush.Color := Color;
      Brush.Style := bsClear;
      DrawText(Handle, PChar(Text), Length(Text), R, Flags);
    end;
  end;
end;
}

function TfcCustomPanel.InvalidateNeeded:boolean;
begin
  result := False;
  if Frame.Enabled then
    if (Frame.NonFocusColor <> clNone) then begin
       if (Color <> Frame.NonFocusColor) then result := True;
    end
    else if (Frame.NonFocusFontColor <> clNone) then begin
       if (Font.Color <> Frame.NonFocusFontColor) then result := True;
    end;
end;

procedure TfcCustomPanel.CMEnter(var Message: TCMEnter);
var r,r2:TRect;
begin
   inherited;
   FFocused:= True;
   if invalidateneeded then invalidate;

   if Frame.Enabled then
   if (Frame.FocusBorders * Frame.NonFocusBorders <> Frame.FocusBorders) or
      (Frame.FocusStyle <> Frame.NonFocusStyle) then
   begin
     r:= ClientRect;
     r2:= Rect(r.left+2,r.top+2,r.right-2,r.bottom-2);
     ValidateRect(handle,@r2);
     InvalidateRect(handle, @r, False);
   end;
end;

procedure TfcCustomPanel.CMExit(var Message: TCMExit);
var r,r2:Trect;
begin
   inherited;
   FFocused:= False;
   if invalidateneeded then invalidate;

   if Frame.Enabled then
   if (Frame.FocusBorders * Frame.NonFocusBorders <> Frame.FocusBorders) or
      (Frame.FocusStyle <> Frame.NonFocusStyle) then
   begin
     r:= ClientRect;
     r2:= Rect(r.left+2,r.top+2,r.right-2,r.bottom-2);
     ValidateRect(handle,@r2);
     InvalidateRect(handle, @r, False);
   end;
end;

procedure TfcCustomGroupBox.CMEnter(var Message: TCMEnter);
begin
   inherited;
   FFocused:= True;
   if InvalidateNeeded then invalidate;
end;

function TfcCustomGroupBox.InvalidateNeeded:boolean;
begin
  result := False;
  if Frame.Enabled then
    if (Frame.NonFocusColor <> clNone) then begin
       if (Color <> Frame.NonFocusColor) then result := True;
    end
    else if (Frame.NonFocusFontColor <> clNone) then begin
       if (Font.Color <> Frame.NonFocusFontColor) then result := True;
    end;
end;

procedure TfcCustomGroupBox.CMExit(var Message: TCMExit);
begin
   inherited;
   FFocused:= False;
   if InvalidateNeeded then invalidate;
end;

end.

