unit fcimageform;
{
//
// Components : TfcImageForm
//
// Copyright (c) 1999 by Woll2Woll Software
//
// History:
// 5/10/99  PYW  Checked for click or mousedown event assigned for a control on a caption bar.
// 4/14/00  PYW  Use Window system command for dragging instead.
// 10/4/00 - RSW New ifRenderWithTImage property
// 1/8/2002 - PYW - Don't use perform.  Use postMessage instead.  More reliable.
//                  When drag full windows was true, perform didn't work and window would not drag.
// 5/24/2002 - Allow clicking on Caption Control to bring form to front.
//
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, fcCommon, fcimage;

type

  TfcImageFormOption = (ifUseWindowsDrag, ifNoPaletteDither);
  // 10/4/00 -
  // ifRenderWithTImage will use Delphi's TImage code to paint,
  // otherwise use TfcBitmap.  This property is only releveant in
  // 256 color for palette switching.
  TfcImageFormOptions = set of TfcImageFormOption;

  TfcCustomImageForm = class(TfcCustomImage)
  private
    FDragTolerance: Integer;
    FTransparentColor: TColor;
    FRegion: HRgn;
    FCaptionBarControl:TControl;
//    FCaptureMessageClass: TfcCaptureMessageClass;
    FOptions: TfcImageFormOptions;

    LastFocusRect: TRect;    procedure ReadRegions(Reader: TStream);
    procedure WriteRegions(Writer: TStream);
    function GetPicture: TPicture;
    procedure SetPicture(Value: TPicture);
    procedure SetOptions(Value: TFcImageFormOptions);
    procedure SetCaptionBarControl(Value: TControl);
  protected
    DraggingForm: Boolean;
    procedure DestroyWnd;

    procedure Paint; override;
    function GetTransparentColor: TColor;
    procedure DrawFocusRect(DC: HDC; FocusRect: TRect); virtual;
    procedure WndProc(var Message: TMessage); override;

    procedure FormMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DefineProperties(Filer: TFiler);override;
    procedure SetParent(Value:TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure AfterFormWndProc(var Message: TMessage); virtual;

    procedure MouseLoop(X, Y: Integer); virtual;
    procedure MouseLoop_MouseMove(X, Y: Integer; ACursorPos: TPoint;
      var FirstTime: Boolean; var FocusRect: TRect; OriginalRect:TRect); virtual;
    procedure MouseLoop_MouseUp(X, Y: Integer; ACursorPos: TPoint;
      OriginalRect, FocusRect: TRect); virtual;
    function GetDragFullWindows: Boolean; virtual;

  public
    Patch: Variant;
    constructor Create(Aowner:TComponent); override;
    destructor Destroy; override;


    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ApplyBitmapRegion; virtual;
    procedure ScaleRegion(xFact, yFact:Single);virtual;

    property RegionData: HRgn read FRegion stored True;
    property CaptionBarControl: TControl read FCaptionBarControl write SetCaptionBarControl;
    property DragTolerance: Integer read FDragTolerance write FDragTolerance;
    property Picture: TPicture read GetPicture write SetPicture;
    property TransparentColor: TColor read FTransparentColor write FTransparentColor default clNone;
    property Options: TfcImageFormOptions read FOptions write SetOptions default [];
  end;

  TfcImageForm = class(TfcCustomImageForm)
  published
    property Options;

    property Align;
    property AutoSize;
    property Picture;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property CaptionBarControl;
    property DragTolerance;
    property TransparentColor;
  end;

implementation

{$r fcFrmBtn.RES}

var MouseHook : HHOOK;
    HookCount: integer;
    InHook: boolean;

function wwMouseHookProc(nCode: Integer; wParam: Integer; lParam: Integer): LResult; stdcall;
var ac: TWinControl;
    form: TCustomForm;
    ptControl,mouseControl: TControl;

    i: integer;
    imageform: TfcCustomImageForm;
    ClickOrMouseDownAssigned,PtInDragControl:boolean;
    currentpt:TPoint;
begin
  result := CallNextHookEx(MouseHook, nCode, wParam, lParam);
  if InHook then exit;

  with PMouseHookStruct(lParam)^ do
  begin
    if (wParam = WM_LBUTTONDOWN) or (wParam = WM_NCLBUTTONDOWN) then
    begin
       ac:= Screen.ActiveControl;
       if ac=nil then exit;           // 5/24/2002 - Apparently necessary when trayicons are used.
       ac:= GetParentForm(ac);
       if ac=nil then exit;
       form := TCustomForm(ac);

//       mousecontrol:= ac.ControlAtPos(  Point(pt.x, pt.y), True);
       mousecontrol:= FindControl(PMouseHookStruct(lparam)^.hwnd);
       ptinDragControl := (mousecontrol <> nil);  //Initialize to True and set to False when control should not drag form.

       with form do begin
         for i:= 0 to controlcount-1 do
         begin
            if fcIsClass(controls[i].ClassType, 'TfcCustomImageForm') then
            begin
              imageForm:= TfcCustomImageForm(Controls[i]);

              ClickOrMouseDownAssigned := False;
              if Mousecontrol <> nil then begin
                 if (imageform.captionbarcontrol = nil) or (imageform.captionbarcontrol.parent = form) then begin
                    currentpt:= Form.ScreenToClient(pt);
                    ptControl := Form.ControlAtPos(currentpt,True);
                 end
                 else begin
                    currentpt:= imageform.captionbarcontrol.parent.ScreenToClient(pt);
                    ptControl := imageform.captionbarcontrol.parent.controlatpos(currentpt,True);
                 end;

                 if ptControl <> nil then  //Control that was clicked on.  Check if Click or mousedown assigned.
                    ClickOrMouseDownAssigned := Assigned(TButton(ptControl).OnClick) or
                                                Assigned(TButton(ptControl).OnMouseDown);

                 if (imageform.CaptionBarControl = nil) then begin
                    currentpt:= form.ScreenToClient(pt);
                    ptinDragControl := PtInRect(form.boundsrect,currentpt);
                 end
                 else begin
                    currentpt:= TButton(imageform.CaptionBarControl).ScreenToClient(pt);
                    ptinDragControl := PtInRect(imageform.CaptionBarControl.boundsrect,currentpt);
                 end;

                 if ptinDragControl then
                    ptinDragControl := ((imageform.captionbarcontrol<>nil) and (mousecontrol = imageform.captionbarcontrol.parent));
              end;

              currentpt:= form.ScreenToClient(pt);

              InHook:= True;
              //Check if the caption control is defined.  If so, then check if the caption control was clicked on or if
              //a different control was clicked on in the caption that has an onclick event.  Use cheating cast.
               if ((imageform.CaptionBarControl <> nil) and (not ClickOrMouseDownAssigned) and ptInDragControl) or
                  ((imageform.CaptionBarControl <> nil) and (mouseControl = imageform.CaptionBarControl)) or
                  ((imageform.CaptionBarControl = nil) and (not ClickOrMouseDownAssigned) and (mousecontrol = form)) then begin
                  BringToFront;  //5/24/2002 - Allow clicking on Caption Control to bring form to front.
                  ImageForm.FormMouseDown(mbLeft, [ssleft], currentpt.x, currentpt.y);
                  result := 1;
               end;
//              ImageForm.CaptionBarControl.ControlState:=
//                 ImageForm.CaptionBarControl.ControlState - [cslButtonDown];
              InHook:= False;
            end
         end
       end
    end;
  end;
end;

constructor TfcCustomImageForm.Create(Aowner:TComponent);
begin
  inherited;
  FDragTolerance := 5;
  FRegion := 0;
  Align := alClient;
  FTransparentColor := clNone;
//  FCaptureMessageClass := nil;
  FOptions:= [];
  if not (csDesigning in ComponentState) then
  begin
    if (MouseHook=0) and (HookCount=0) then
       MouseHook := SetWindowsHookEx(WH_MOUSE, @wwMouseHookProc, HINSTANCE, GetCurrentThreadID);
    inc(HookCount);
  end;
end;

destructor TfcCustomImageForm.Destroy;
begin
  if FRegion <> 0 then DeleteObject(FRegion);
  if not (csDesigning in ComponentState) then
  begin
     Dec(HookCount);
     if (HookCount<=0) and (MouseHook<>0) then
     begin
        UnhookWindowsHookEx(MouseHook);
        MouseHook:= 0;
     end;
  end;

//  if FCaptureMessageClass <> nil then FCaptureMessageClass.Free;
//  FCaptureMessageClass:= nil;
  inherited Destroy;
end;

procedure TfcCustomImageForm.DestroyWnd;
begin
  if FRegion <> 0 then
  begin
    SetWindowRgn(GetParentForm(self).Handle, 0, False);
    DeleteObject(FRegion);
    FRegion := 0;
  end;
end;

// 10/26/98 - Added check to use windows setting for dragging of form when UseWindowsDrag is set.
function TfcCustomImageForm.GetDragFullWindows: Boolean;
var s: integer;
begin
  s:= 0;
  if ifUseWindowsDrag in Options then
    SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, Pointer(@s), 0);
  result:= (s<>0);
end;

procedure TfcCustomImageForm.ScaleRegion(xFact, yFact:Single);
var
   size:integer;
   rgndata: pRGNData;
//   stat: integer;
   newregion,existingrgn:HRgn;
   xform:TXForm;
begin
    existingrgn := CreateRectRgn(0,0,1,1);
    GetWindowRgn(GetParentForm(self).handle,existingrgn);
    Size := GetRegionData(existingrgn, 0, nil);
    if Size > 0 then
    begin
      Getmem(RgnData,size);
      try
        GetRegionData(existingrgn, Size, RgnData);
        FillChar(Xform,sizeof(xform),0);
        xform.eM11 := xfact;
        xform.em22 := yfact;
        newRegion := ExtCreateRegion(@xform,size,rgndata^);

        SetWindowRgn(GetParentForm(self).Handle, 0, False);
        if FRegion <> 0 then DeleteObject(FRegion);

        SetWindowRgn(GetParentForm(self).Handle,newRegion,true)
      finally
        FreeMem(RgnData);
        DeleteObject(existingrgn);
      end;
    end;
end;

procedure TfcCustomImageForm.AfterFormWndProc(var Message: TMessage);
var AControl: TControl;
    ClickOrMouseDownAssigned:Boolean;
begin
  if not (csDesigning in componentstate) then
  case Message.Msg of
    WM_DESTROY: DestroyWnd;

    WM_LBUTTONDOWN:  //Needed to capture mouse messages from caption control
      with TWMMouse(Message) do begin
        AControl := Parent.ControlAtPos(Point(XPos, YPos), True);

        //Check if the caption control is defined.  If so, then check if the caption control was clicked on or if
        //a different control was clicked on in the caption that has an onclick event.  Use cheating cast.
        //3/11/99-PYW-Don't Drag if a different control has an OnMouseDown event as well.
        //5/15/2001-PYW-Handle when acontrol =nil.
        if AControl <> nil then
           ClickOrMouseDownAssigned := Assigned(TButton(AControl).OnClick) or
                                       Assigned(TButton(AControl).OnMouseDown)
        else ClickOrMouseDownAssigned:= false;
        //5/10/99-PYW-Checked for click or mousedown event assigned for a control on a caption bar.
        //5/15/2001-PYW-Handle when acontrol is nil.  Allow dragging in this case.
        if ((FCaptionBarControl <> nil) and not ClickOrMouseDownAssigned) or
           ((FCaptionBarControl <> nil) and (AControl = CaptionBarControl)) or
           ((FCaptionBarControl = nil) and (AControl = self))or
           (AControl = nil) then
          FormMouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
      end;
  end;
end;

procedure TfcCustomImageForm.FormMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const SC_DragMove = $F012;
var p: TPoint;
    ParentForm: TCustomForm;
begin
{  if (FCaptionBarControl <> nil) then
    with FCaptionBarControl do
      if not (PtinRect(Rect(Left, Top, Width + Left, Height + Top), Point(x, y))) then
        Exit;}

  if ssLeft in Shift then begin
     ParentForm:= GetParentForm(self);
     if GetDragFullWindows then begin  //4/14/00 - PYW - Use Window system command for dragging instead.
        ReleaseCapture;
//        ParentForm.perform(WM_SysCommand, SC_DragMove, 0);
        //1/8/2002 - Don't use perform.  Use postMessage instead.  More reliable.
        Postmessage(ParentForm.Handle,WM_SysCommand, SC_DragMove, 0);
        exit;
     end;
     if TForm(ParentForm).FormStyle = fsMDIChild then
     begin
        p:= ClientToScreen(Point(x,y));
        p.x:= p.x - ParentForm.left;
        p.y:= p.y - ParentForm.Top;
     end else p := Point(x, y);
     MouseLoop(p.x, p.y)
  end
  else SendMessage(Parent.Handle, WM_SYSCOMMAND, SC_KEYMENU, 0);
end;

procedure TfcCustomImageForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FCaptionBarControl) then
    FCaptionBarControl := nil;
end;

procedure TfcCustomImageForm.MouseLoop(X, Y: Integer);
var ACursor: TPoint;
    Msg: TMsg;
    FirstTime: Boolean;
    OriginalRect, FocusRect: TRect;
begin
  FirstTime := True;
  with Parent do OriginalRect := Rect(Left, Top, Left + Width, Top + Height);
  FocusRect := Rect(0, 0, 0, 0);
  with GetParentForm(self) do
  begin
    SetCapture(Handle);
    try
      while GetCapture = Handle do
      begin
        GetCursorPos(ACursor);
        case Integer(GetMessage(Msg, 0, 0, 0)) of
          -1: Break;
          0: begin
            PostQuitMessage(Msg.WParam);
            Break;
          end;
        end;
        case Msg.Message of
          WM_MOUSEMOVE: MouseLoop_MouseMove(X, Y, ACursor, FirstTime, FocusRect, OriginalRect);
          WM_LBUTTONUP: begin
            MouseLoop_MouseUp(X, Y, ACursor, OriginalRect, FocusRect);

            TranslateMessage(Msg);   // So OnMouseUp fires
            DispatchMessage(Msg);

            if GetCapture = Handle then ReleaseCapture;
          end;
          else begin // 12/07/98 - Following code needed to prevent eating of messages.
            TranslateMessage(Msg);
            DispatchMessage(Msg);
          end;
        end;
      end;
    finally
      if GetCapture = Handle then ReleaseCapture;
    end;
  end;
end;

procedure TfcCustomImageForm.MouseLoop_MouseMove(X, Y: Integer; ACursorPos: TPoint;
  var FirstTime: Boolean; var FocusRect: TRect; OriginalRect:TRect);
var DC: HDC;
    p: TPoint;
    Msg: TMsg;
    PaintFocusRect: TRect;
begin
  p := ClientToScreen(Point(x, y));
  if (Abs(ACursorPos.X - p.x) <= DragTolerance) and
     (Abs(ACursorPos.Y - p.y) <= DragTolerance) then
    Exit;

  with GetParentForm(self) do
  begin
    // 10/26/98 - Added Check For Full Windows Drag option on ImageForm.
    if not GetDragFullWindows then
    begin
      DC := GetDC(0);

      try
        if FirstTime then
        begin
          DraggingForm := True;
        end else begin
          DrawFocusRect(DC, LastFocusRect); { Hide previous focus rect }
        end;
        FocusRect := Rect(ACursorPos.x - x, ACursorPos.y - y, ACursorPos.x - x + Width, ACursorPos.y - y + Height);
        if TForm(GetParentForm(self)).FormStyle = fsMDIChild then
        begin
           PaintFocusRect:= FocusRect;
           PaintFocusRect.Left:= PaintFocusRect.Left + ClientToScreen(Point(0,0)).x - Left;
           PaintFocusRect.Top:= PaintFocusRect.Top+ ClientToScreen(Point(0,0)).y - Top;
           PaintFocusRect.Right:= PaintFocusRect.Left+ Width;
           PaintFocusRect.Bottom:= PaintFocusRect.Top + Height;
        end
        else begin
           PaintFocusRect:= FocusRect;
        end;
        DrawFocusRect(DC, PaintFocusRect);
        LastFocusRect:= PaintFocusRect;
        FirstTime:= False;
      finally
        ReleaseDC(0, DC);
      end;
    end else begin //10/26/98 - Drag Full Windows.
      DraggingForm := True;
      sleep(10);
      while PeekMessage(Msg, Handle, WM_MOUSEMOVE, WM_MOUSEMOVE, PM_REMOVE) do;
      GetCursorPos(ACursorPos);
      SetWindowPos(Handle, 0, ACursorPos.x - x, ACursorPos.y - y, 0, 0,
           SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
    end;
  end;
end;

procedure TfcCustomImageForm.MouseLoop_MouseUp(X, Y: Integer; ACursorPos: TPoint;
  OriginalRect, FocusRect: TRect);
var DC: HDC;
begin
  if not DraggingForm then Exit;
  DraggingForm:= False;

  with GetParentForm(self) do
  begin
    if not GetDragFullWindows then
    begin
      DC := GetDC(0);
      try
         DrawFocusRect(DC, LastFocusRect);
//        if TForm(GetParentForm(self)).FormStyle = fsMDIChild then
//           Windows.DrawFocusRect(DC, LastFocusRect)
//        else
//           Windows.DrawFocusRect(DC, FocusRect);
      finally
        ReleaseDC(0, DC);
      end;

      SetWindowPos(Handle, 0, FocusRect.Left, FocusRect.top, 0, 0, SWP_NOZORDER {or SWP_NOMOVE }or
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
//      RedrawWindow(GetDesktopWindow, @OriginalRect, 0, RDW_UPDATENOW or
//        RDW_ALLCHILDREN or RDW_INVALIDATE);

      if GetCapture = Handle then ReleaseCapture;
    end;
  end;
end;

procedure TfcCustomImageForm.ReadRegions(Reader: TStream);
var
   rgnsize:integer;
   rgndata: pRGNData;
begin
  Reader.Read(RgnSize, 4);

  if RgnSize <> 0 then
  begin
    GetMem(RgnData, RgnSize);
    try
      Reader.Read(RgnData^,rgnSize);
      FRegion := ExtCreateRegion(nil, RgnSize, RgnData^);

      if not (csDesigning in ComponentState) and (FRegion<>0) then
        SetWindowRgn(parent.handle,Fregion,true)
    finally
      FreeMem(RgnData);
    end;
  end else begin
    FRegion := 0;
    ApplyBitmapRegion;
  end
end;

procedure TfcCustomImageForm.WriteRegions(Writer: TStream);
var
   size:integer;
   rgndata: pRGNData;
   stat: integer;
begin
  ApplyBitmapRegion;
  if (FRegion <> 0) then
  begin
    Size := GetRegionData(FRegion, 0, nil);
    Writer.Write(Size, SizeOf(Size));
    if Size > 0 then
    begin
      Getmem(RgnData,size);
      try
        Stat := GetRegionData(FRegion, Size, RgnData);
        if Stat > 0 then Writer.Write(RgnData^, Size);
      finally
        FreeMem(RgnData);
      end;
    end;
  end else begin
    Size := 0;
    Writer.Write(Size, SizeOf(Size));
  end;
end;

procedure TfcCustomImageForm.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('RegionData', ReadRegions, WriteRegions, True);
end;

procedure TfcCustomImageForm.SetParent(Value: TWinControl);
begin
  if (Value <> nil) and not (Value is TCustomForm) then
    Value := GetParentForm(Value);

  inherited SetParent(value);

  if Parent <> nil then
    SetWindowLong(Parent.Handle, GWL_STYLE,
      GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);

  if Value<>Nil then TForm(Value).BorderStyle:= bsNone;
(*
  if (Value<>nil) and { 5/13/99 }
     (FCaptureMessageClass = nil) and not (csDesigning in ComponentState) then
  begin
    FCaptureMessageClass := TfcCaptureMessageClass.Create(Owner);
    FCaptureMessageClass.WindowHandle := Value.Handle;
    FCaptureMessageClass.Enabled := True;
    FCaptureMessageClass.OnWndProc := AfterFormWndProc;
  end;
*)
end;

procedure TfcCustomImageForm.ApplyBitmapRegion;
//var tempBitmap: TBitmap;
begin
  SetWindowRgn(GetParentForm(self).Handle, 0, False);
  if FRegion <> 0 then DeleteObject(FRegion);

{ This would work for JPG, but JPG would leave non-transparent areas where the intention
  is to be transparent. Thus we do not support JPG }
{  tempBitmap:= TBitmap.create;
  tempBitmap.assign(picture.graphic);
  FRegion := fcCreateRegionFromBitmap(tempbitmap, tempbitmap.canvas.pixels[0,0]);
  tempBitmap.free;
}
  FRegion := fcCreateRegionFromBitmap(Picture.Bitmap, GetTransparentColor);
  if not (csDesigning in ComponentState) then
     SetWindowRgn(GetParentForm(self).Handle, FRegion, True);

end;

function TfcCustomImageForm.GetPicture: TPicture;
begin
  result := inherited Picture;
end;

function TfcCustomImageForm.GetTransparentColor: TColor;
begin
   result := FTransparentColor;
   if FTransparentColor=clNone then
   begin
      if (Picture.Bitmap<>Nil) then
         result:= Picture.Bitmap.Canvas.Pixels[0,Picture.Bitmap.height-1]
   end
   else result:= FTransparentColor;
end;

procedure TfcCustomImageForm.SetPicture(Value: TPicture);
begin
  inherited Picture := Value;

  if (Value <> nil) and (Value.Width > 0) and (Value.height > 0) then
  begin
    (Parent as TCustomForm).ClientWidth := Value.Width;
    (Parent as TCustomForm).ClientHeight := Value.Height;
  end;
  Invalidate;
end;

procedure TfcCustomImageForm.SetOptions(Value: TFcImageFormOptions);
begin
  FOptions:= Value;
end;

procedure TfcCustomImageForm.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  // Added to support autosizing of the form
  if AutoSize then with GetParentForm(self) do
  begin
    ClientWidth := AWidth;
    ClientHeight := AHeight;
  end;
end;

procedure TfcCustomImageForm.DrawFocusRect(DC: HDC; FocusRect: TRect);
begin
   Windows.DrawFocusRect(DC, FocusRect);
   InflateRect(FocusRect, -1, -1);
   Windows.DrawFocusRect(DC, FocusRect);
   InflateRect(FocusRect, -1, -1);
   Windows.DrawFocusRect(DC, FocusRect);
end;

procedure TfcCustomImageForm.SetCaptionBarControl(Value: TControl);
begin
   if Value<>FCaptionBarControl then
   begin
//      if CaptionBarControl<>nil then
//         CaptionBarControl.WindowProc:= FLastCaptionWindowProc;

      FCaptionBarControl:= Value;

//      if (CaptionBarControl<>nil) and (not (csDesigning in componentstate)) then
//      begin
//         FLastCaptionWindowProc:= CaptionBarControl.WindowProc;
//         CaptionBarControl.WindowProc:= CaptionWindowProc;
//      end
   end
end;

procedure TfcCustomImageForm.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TfcCustomImageForm.Paint;
begin
   if ifNoPaletteDither in Options then
      BasePatch[0]:= True;
   inherited;
end;

end.
