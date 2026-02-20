unit Painter;

{$WARN SYMBOL_PLATFORM OFF}
{$R-}
{$Q-}

interface

uses
  DM_Windows, DM_ComObj, DM_ActiveX,
  Types, Printers, Forms,
  Classes, Graphics, Menus, Math,
  SpatialModelLib_TLB, PainterLib_TLB,
  StdVcl, Variants, JPEG,
  DMComObjectU, DataModel_TLB;

const
  CF_JPEG=CF_MAX+1;

  FrontCanvas=1;
  BackCanvas=2;
  BackCanvas2=4;
  BackCanvasFactor=3;
  InfinitValue=1000000000;

var
  XXX:integer;

function GetPainterClassObject:IDMClassFactory;

type
  TPainterFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;

  TPainter = class(TDMComObject, IPainter, IPainter3)
//  TPainter = class(TDM_AutoObject, IPainter, IPainter3)
  private
    FCanvasLocked:boolean;
    FView:IView;
    FLocalView:IView;
    FMode:integer;

    FHCanvas:TCanvas;
    FVCanvas:TCanvas;

    FPenStyle:integer;
    FPenColor:integer;
    FPenMode:integer;
    FPenWidth:integer;
    FBrushStyle:integer;
    FBrushColor:integer;
//    FFont:TFont;

    FHHeight:integer;
    FVHeight:integer;
    FHWidth:integer;
    FVWidth:integer;

    FDmaxPix:integer;
    FDminPix:integer;
    FZmaxPix:integer;
    FZminPix:integer;

    FXmax:double;
    FXmin:double;
    FYmax:double;
    FYmin:double;
    FZmax:double;
    FZmin:double;
    FXmaxB:double;
    FXminB:double;
    FYmaxB:double;
    FYminB:double;
    FZmaxB:double;
    FZminB:double;


    FGraphic:TGraphic;

    FCanvasSet: integer;

    FBackLocked:boolean;

    FHBackBitmap:TBitmap;
    FVBackBitmap:TBitmap;
    FHBackBitmap2:TBitmap;
    FVBackBitmap2:TBitmap;

    FBackCX:double;
    FBackCY:double;
    FBackCZ:double;
    FHTMPIndex:integer;
    FVTMPIndex:integer;

    FRedrawFlag:boolean;
    
    FIsPrinter:boolean;

    procedure SetCanvasLocked(const Value: boolean);
    property  CanvasLocked:boolean read FCanvasLocked write SetCanvasLocked;
    procedure UpdateFont;
  protected
    function CheckVisiblePoint(aCanvasTag: Integer; X, Y, Z: Double): WordBool;
      safecall;
    function Get_ViewU: IUnknown; safecall;
    procedure Set_ViewU(const Value: IUnknown); safecall;
    function Get_PenColor: Integer; safecall;
    procedure Set_PenColor(Value: Integer); safecall;
    function Get_PenMode: Integer; safecall;
    procedure Set_PenMode(Value: Integer); safecall;
    procedure Clear; safecall;
    procedure DrawLine(WX0, WY0, WZ0, WX1, WY1, WZ1: Double); safecall;
    procedure DrawCurvedLine(VarPointArray: OleVariant); safecall;
    procedure DrawRectangle(WX0, WY0, WZ0, WX1, WY1, WZ1, Angle: Double);  safecall;
    procedure DrawPoint(WX, WY, WZ: Double); safecall;
    procedure DrawPolygon(const Lines: IDMCollection; Vertical: WordBool);
      safecall;
    procedure DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z, P3X, P3Y, P3Z, P4X,
      P4Y, P4Z, aAngle: Double; PictureHandle: LongWord; PictureFMT,
      Alpha: Integer); safecall;
    procedure DrawArc(WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, WZ2:double); safecall;
    procedure DrawText(WX, WY, WZ: Double; const Text: WideString;
      TextSize: Double; const FontName: WideString; FontSize, FontColor,
      FontStyle, ScaleMode: Integer); safecall;
    procedure DrawCircle(WX, WY, WZ, R: Double; R_In_Pixels: WordBool);  safecall;
    procedure DrawAxes(XP, YP, ZP:integer); safecall;
    procedure DrawRangeMarks; safecall;

    procedure DragLine(PX0: Integer; PY0: Integer; PZ0: Integer; PX1: Integer; PY1: Integer;
                       PZ1: Integer); safecall;
    procedure DragRect(PX0: Integer; PY0: Integer; PZ0: Integer; PX1: Integer; PY1: Integer;
                       PZ1: Integer); safecall;
    procedure DragCurvedLine(VarPointArray: OleVariant); safecall;

    function Get_PenStyle: Integer; safecall;
    procedure Set_PenStyle(Value: Integer); safecall;
    function Get_PenWidth: Double; safecall;
    procedure Set_PenWidth(Value: Double); safecall;
    function Get_BrushColor: Integer; safecall;
    function Get_BrushStyle: Integer; safecall;
    procedure Set_BrushColor(Value: Integer); safecall;
    procedure Set_BrushStyle(Value: Integer); safecall;
    function Get_HHeight: Integer; safecall;
    function Get_HWidth: Integer; safecall;
    function Get_VWidth: Integer; safecall;
    function Get_VHeight: Integer; safecall;
    procedure Set_HHeight(Value: Integer); safecall;
    procedure Set_HWidth(Value: Integer); safecall;
    procedure Set_VWidth(Value: Integer); safecall;
    procedure Set_VHeight(Value: Integer); safecall;
    procedure SetRangePix; safecall;
    function Get_DmaxPix: Integer; safecall;
    function Get_DminPix: Integer; safecall;
    function Get_ZmaxPix: Integer; safecall;
    function Get_ZminPix: Integer; safecall;
    procedure Set_DmaxPix(Value: Integer); safecall;
    procedure Set_DminPix(Value: Integer); safecall;
    procedure Set_ZmaxPix(Value: Integer); safecall;
    procedure Set_ZminPix(Value: Integer); safecall;
    function Get_HCanvasHandle: Integer; safecall;
    function Get_VCanvasHandle: Integer; safecall;
    procedure Set_HCanvasHandle(Value: Integer); safecall;
    procedure Set_VCanvasHandle(Value: Integer); safecall;
    procedure WP_To_P(WX, WY, WZ: Double; out PX, PY, PZ: Integer); safecall;
    procedure P_To_WP(PX, PY, Tag: Integer; out WX, WY, WZ: Double); safecall;
    function Get_LocalViewU: IUnknown; safecall;
    procedure Set_LocalViewU(const Value: IUnknown); safecall;
    function Get_LayerIndex: Integer; safecall;
    procedure Set_LayerIndex(Value: Integer); safecall;
    function Get_UseLayers: WordBool; safecall;
    procedure SetLimits; safecall;
    function LineIsVisible(aCanvasTag: Integer; var X0, Y0, Z0, X1, Y1,
      Z1: Double; FittoCanvas: WordBool; CanvasLevel: Integer): WordBool;
      safecall;
    function Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    procedure CloseBlock; safecall;
    procedure InsertBlock(const ElementU: IUnknown); safecall;
    procedure DrawTexture(const TextureName: WideString;
      var TextureNum: Integer; X0, Y0, Z0, X1, Y1, Z1, x2, y2, z2, x3, y3,
      z3, NX, NY, NZ, MX, MY: Double); safecall;

//IPainter3
    function Get_CanvasSet: integer; safecall;
    procedure Set_CanvasSet(Value: integer); safecall;
    procedure FastDraw; safecall;
    procedure ResizeBack(Flag:integer); safecall;
    procedure FlipFrontBack; safecall;
    procedure SaveCenterPos; safecall;
    procedure FlipBackCanvas; safecall;
    procedure GetTextExtent(const Text: WideString; out Width, Height: Double);
      safecall;
    procedure SetFont(const FontName: WideString; FontSize, FontStyle,
      FontColor: Integer); safecall;
    function Get_IsPrinter: WordBool; safecall;
    procedure Set_IsPrinter(Value: WordBool); safecall;

  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  procedure GDIError;

implementation

function TPainter.Get_ViewU: IUnknown;
begin
  Result:=FView
end;

procedure TPainter.Set_ViewU(const Value: IUnknown);
begin
  FView:=Value as IView
end;

function TPainter.Get_PenColor: Integer;
begin
  Result:=FPenColor
end;

procedure TPainter.Set_PenColor(Value: Integer);
begin
  FPenColor:=Value
end;

function TPainter.Get_PenMode: Integer;
begin
  Result:=FPenMode
end;

procedure TPainter.Set_PenMode(Value: Integer);
begin
  FPenMode:=Value
end;

type
  TPointsArray3=array [0..2,0..1] of integer;

procedure TPainter.DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z, P3X, P3Y, P3Z,
  P4X, P4Y, P4Z, aAngle: Double; PictureHandle: LongWord; PictureFMT,
  Alpha: Integer);
procedure DoDrawBitMap(aCanvasTag:integer; dAngle,
            X0,Y0,Z0,X1,Y1,Z1,X3,Y3,Z3,X4,Y4,Z4,
            XC,YC,ZC:double; P0X, P0Y, P0Z, P1X, P1Y, P1Z:double;
            Graphic:TGraphic; aAngle:double; CanvasLevel:integer);
  var
    Canvas:TCanvas;
    Width, Height:integer;
    P00X, P00Y, P00Z,
    P10X, P10Y, P10Z,
    P01X, P01Y, P01Z,
    P11X, P11Y, P11Z,
    Xmax, Xmin, Ymax, Ymin:double;
    Rect:TRect;
    PointsArray3:TPointsArray3;
    iRes:integer;
    bRes:LongBool;
    XDest, YDest:integer;
    blendFunction:TblendFunction;
    Bitmap:TBitmap;
  begin
   if (not CheckVisiblePoint(aCanvasTag,X0,Y0,Z0)) then Exit;
   if (not CheckVisiblePoint(aCanvasTag,X1,Y1,Z1)) then Exit;
   if aCanvasTag=1 then begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FHCanvas;
         Width:=FHWidth;
         Height:=FHHeight
       end;
     BackCanvas:begin
         Canvas := FHBackBitmap.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FHBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     end;
   end else begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FVCanvas;
         Width:=FVWidth;
         Height:=FVHeight
       end;
     BackCanvas:begin
         Canvas := FVBackBitmap.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FVBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     end;
   end;

    with Canvas do begin
     with FView do begin
      if cosZ<>1 then begin
        P00X:=Round(Width/2+
            ((X0-XC)*cosZ-
             (Y0-YC)*sinZ)/RevScaleX);
        case aCanvasTag of
         1:P00Y:=Round(Height/2-
              ((X0-XC)*sinZ+
               (Y0-YC)*cosZ)/RevScaleY);
        else
         P00Y:=Round(Height/2-
          (Z0-ZC)/RevScaleY);
        end;

        P10X:=Round(Width/2+
           ((X1-XC)*cosZ
           -(Y1-YC)*sinZ)/RevScaleX);
        case aCanvasTag of
         1:P10Y:=Round(Height/2-
              ((X1-XC)*sinZ
              +(Y1-YC)*cosZ)/RevScaleY);
        else
         P10Y:=Round(Height/2-
          (Z1-ZC)/RevScaleY);
        end;
        P01X:=Round(Width/2.+
            ((X3-XC)*cosZ-
             (Y3-YC)*sinZ)/RevScaleX);
        case aCanvasTag of
         1: P01Y:=Round(Height/2-
              ((X3-XC)*sinZ+
               (Y3-YC)*cosZ)/RevScaleX);
        else
         P01Y:=Round(Height/2-
          (Z3-ZC)/RevScaleY);
        end;
         P11X:=Round(Width/2+
           ((X4-XC)*cosZ
           -(Y4-YC)*sinZ)/RevScaleY);
        case aCanvasTag of
         1: P11Y:=Round(Height/2-
              ((X4-XC)*sinZ+
               (Y4-YC)*cosZ)/RevScaleY);
        else
         P11Y:=Round(Height/2-
          (Z4-ZC)/RevScaleY);
        end;
      end else begin  // if cosZ=1
        P00X:=Round(Width/2+
            (X0-XC)/RevScaleX);
        case aCanvasTag of
         1:P00Y:=Round(Height/2-
              (Y0-YC)/RevScaleY);
        else
         P00Y:=Round(Height/2-
          (Z0-ZC)/RevScaleY);
        end;

        P10X:=Round(Width/2+
           (X1-XC)/RevScaleX);
        case aCanvasTag of
         1:P10Y:=Round(Height/2-
              (Y1-YC)*cosZ/RevScaleY);
        else
         P10Y:=Round(Height/2-
          (Z1-ZC)/RevScaleY);
        end;
        P01X:=Round(Width/2.+
            (X3-XC)/RevScaleX);
        case aCanvasTag of
         1: P01Y:=Round(Height/2-
              (Y3-YC)/RevScaleX);
        else
         P01Y:=Round(Height/2-
          (Z3-ZC)/RevScaleY);
        end;
         P11X:=Round(Width/2+
           (X4-XC)/RevScaleY);
        case aCanvasTag of
         1: P11Y:=Round(Height/2-
              (Y4-YC)/RevScaleY);
        else
         P11Y:=Round(Height/2-
          (Z4-ZC)/RevScaleY);
        end;
      end;

      Xmin := min(P00X, P01X);
      Xmin := min(Xmin, P11X);
      Xmin := min(Xmin, P10X);

      Xmax := max(P10X, P01X);
      Xmax := max(Xmax, P11X);
      Xmax := max(Xmax, P00X);

      Ymin := min(P00Y, P01Y);
      Ymin := min(Ymin, P11Y);
      Ymin := min(Ymin, P10Y);

      Ymax := max(P10Y, P01Y);
      Ymax := max(Ymax, P11Y);
      Ymax := max(Ymax, P00Y);

      try
      Rect.TopLeft.X :=round(Xmin);
      Rect.TopLeft.Y := round(Ymin);
      Rect.BottomRight.X := round(Xmax);
      Rect.BottomRight.Y := round(Ymax);
      except
        raise
      end;

      if abs(Rect.TopLeft.X)>=10000 then Exit;
      if abs(Rect.TopLeft.Y)>=10000 then Exit;
      if abs(Rect.BottomRight.X)>=10000 then Exit;
      if abs(Rect.BottomRight.Y)>=10000 then Exit;

      if dAngle=0 then begin
        if OsVersion>= VER_PLATFORM_WIN32_NT then begin
          blendFunction.BlendOp:=0;
          blendFunction.BlendFlags:=0;
          blendFunction.SourceConstantAlpha:=Alpha;
          blendFunction.AlphaFormat:=0;

//          if Graphic is TBitmap then
            Bitmap:=Graphic as TBitmap;
//          else
//            Bitmap:=(Graphic as TJPEGImage).Bitmap;

          bRes:=AlphaBlend(Canvas.Handle,
                       Rect.Left, Rect.Top,
                       Rect.Right-Rect.Left, Rect.Bottom-Rect.Top,
                       Bitmap.Canvas.Handle,
                       0, 0,
                       Bitmap.Width,
                       Bitmap.Height,
                       blendFunction);
         if not bRes then
           GDIError;
        end else
          StretchDraw(Rect, Graphic);
      end else
      if Graphic is TBitmap then begin
         if cosZ<>1 then begin
           PointsArray3[0][0]:=Round(Width/2+
                ((P0X-XC)*cosZ-
                 (P0Y-YC)*sinZ)/RevScaleX);
           PointsArray3[0][1]:=Round(Height/2-
                ((P0X-XC)*sinZ+
                 (P0Y-YC)*cosZ)/RevScaleY);

           PointsArray3[1][0]:=Round(Width/2+
                ((P3X-XC)*cosZ-
                 (P3Y-YC)*sinZ)/RevScaleX);
           PointsArray3[1][1]:=Round(Height/2-
                ((P3X-XC)*sinZ+
                 (P3Y-YC)*cosZ)/RevScaleY);

           PointsArray3[2][0]:=Round(Width/2+
                ((P4X-XC)*cosZ-
                 (P4Y-YC)*sinZ)/RevScaleX);
           PointsArray3[2][1]:=Round(Height/2-
                ((P4X-XC)*sinZ+
                 (P4Y-YC)*cosZ)/RevScaleY);
         end else begin // if cosZ=1
           XDest:=Round(Width/2+
                (P0X-XC)/RevScaleX);
           YDest:=Round(Height/2-
                (P0Y-YC)/RevScaleY);

           PointsArray3[0][0]:=XDest;
           PointsArray3[0][1]:=YDest;

           PointsArray3[1][0]:=Round(Width/2+
                (P3X-XC)/RevScaleX);
           PointsArray3[1][1]:=Round(Height/2-
                (P3Y-YC)/RevScaleY);

           PointsArray3[2][0]:=Round(Width/2+
                (P4X-XC)/RevScaleX);
           PointsArray3[2][1]:=Round(Height/2-
                (P4Y-YC)/RevScaleY);
         end;
         Canvas.Pen.Color:=clBlack;

           iRes:=DM_SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
           if iRes=0 then
            GDIError;
           bRes:=DM_PlgBlt(Canvas.Handle, PointsArray3,
              (Graphic as TBitmap).Canvas.Handle, 0, 0,
              (Graphic as TBitmap).Width,
              (Graphic as TBitmap).Height,
              0, 0, 0);
           if not bRes then
            GDIError;
        end;
      end;
    end;
  end;


var
  dAngle:double;
  X0, Y0, Z0, X1, Y1, Z1,X3, Y3, Z3, X4, Y4, Z4, XC, YC, ZC, RX, RY, RZ,
  XT, YT, ZT:double;
  LVcosT, LVsinT, LVcosZ, LVsinZ, LVDX, LVDY, XSign:double;
  aGraphic:TGraphic;
begin
//  if FGraphic=nil then begin
    if PictureFMT=cf_BITMAP then begin
           aGraphic:=TBitMap.Create;
//      FGraphic:=TBitMap.Create;
    end else
    if PictureFMT=cf_JPEG then
           aGraphic:=TJPEGImage.Create;
//      FGraphic:=TJPEGImage.Create;
//  end;

           aGraphic.LoadFromClipboardFormat(cf_BitMap, PictureHandle, 0);
//  FGraphic.LoadFromClipboardFormat(cf_BitMap, PictureHandle, 0);

  dAngle:=FView.ZAngle-aAngle;

  if FLocalView=nil then begin
    X0:=P0X;
    Y0:=P0Y;
    Z0:=P0Z;
    X1:=P1X;
    Y1:=P1Y;
    Z1:=P1Z;
    X3:=P3X;
    Y3:=P3Y;
    Z3:=P3Z;
    X4:=P4X;
    Y4:=P4Y;
    Z4:=P4Z;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XSign:=FLocalView.CurrZ0;
    if XSign=0 then
      XSign:=1;
    LVDX:=FLocalView.CurrX0;
    LVDY:=FLocalView.CurrY0;
    LVcosT:=FLocalView.cosT;
    LVsinT:=FLocalView.sinT;
    LVcosZ:=FLocalView.cosZ;
    LVsinZ:=FLocalView.sinZ;

    if LVcosT<>1 then begin
      XT:=P0X*RX*LVcosT-P0Z*RZ*LVsinT;
      YT:=P0Y*RY;
      ZT:=P0X*RX*LVsinT+P0Z*RZ*LVcosT;
    end else begin
      XT:=P0X*RX;
      YT:=P0Y*RY;
      ZT:=P0Z*RZ;
    end;

    X0:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y0:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;

    if LVcosT<>1 then begin
      XT:=P1X*RX*LVcosT-P1Z*RZ*LVsinT;
      YT:=P1Y*RY;
      ZT:=P1X*RX*LVsinT+P1Z*RZ*LVcosT;
    end else begin
      XT:=P1X*RX;
      YT:=P1Y*RY;
      ZT:=P1Z*RZ;
    end;

    X1:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y1:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z1:=ZT+FLocalView.CZ;

    if LVcosT<>1 then begin
      XT:=P3X*RX*LVcosT-P3Z*RZ*LVsinT;
      YT:=P3Y*RY;
      ZT:=P3X*RX*LVsinT+P3Z*RZ*LVcosT;
    end else begin
      XT:=P3X*RX;
      YT:=P3Y*RY;
      ZT:=P3Z*RZ;
    end;

    X3:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y3:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z3:=ZT+FLocalView.CZ;

    if LVcosT<>1 then begin
      XT:=P4X*RX*LVcosT-P4Z*RZ*LVsinT;
      YT:=P4Y*RY;
      ZT:=P4X*RX*LVsinT+P4Z*RZ*LVcosT;
    end else begin
      XT:=P4X*RX;
      YT:=P4Y*RY;
      ZT:=P4Z*RZ;
    end;

    X4:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y4:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z4:=ZT*RZ+FLocalView.CZ;
  end;

  XC:=FView.CX;
  YC:=FView.CY;
  ZC:=FView.CZ;

  if (FCanvasSet and FrontCanvas)<>0 then begin
    if (FMode=0) or (FMode=2) then
      DoDrawBitMap(1, dAngle, X0,Y0,Z0,X1,Y1,Z1,X3,Y3,Z3,X4,Y4,Z4,
                    XC,YC,ZC, P0X,P0Y,P0Z,P1X,P1Y,P1Z,aGraphic, aAngle, FrontCanvas);
//             XC,YC,ZC, P0X,P0Y,P0Z,P1X,P1Y,P1Z,FGraphic, aAngle, FrontCanvas);
  end;
  if (FCanvasSet and BackCanvas)<>0 then begin
    if (FMode=0) or (FMode=2) then
      DoDrawBitMap(1, dAngle, X0,Y0,Z0,X1,Y1,Z1,X3,Y3,Z3,X4,Y4,Z4,
                    XC,YC,ZC, P0X,P0Y,P0Z,P1X,P1Y,P1Z,aGraphic, aAngle, BackCanvas);
//             XC,YC,ZC, P0X,P0Y,P0Z,P1X,P1Y,P1Z,FGraphic, aAngle, BackCanvas);
  end;
  if (FCanvasSet and BackCanvas2)<>0 then begin
    if (FMode=0) or (FMode=2) then
      DoDrawBitMap(1, dAngle, X0,Y0,Z0,X1,Y1,Z1,X3,Y3,Z3,X4,Y4,Z4,
                    XC,YC,ZC, P0X,P0Y,P0Z,P1X,P1Y,P1Z,aGraphic, aAngle, BackCanvas2);
//             XC,YC,ZC, P0X,P0Y,P0Z,P1X,P1Y,P1Z,FGraphic, aAngle, BackCanvas2);
  end;
        aGraphic.Free;
end;

var
 PointArray:array[0..100] of TPoint;

procedure TPainter.DrawCurvedLine(VarPointArray: OleVariant);
 procedure DoDrawCurvedLine(aCanvasTag:integer; VarPointArray: OleVariant; CanvasLevel:integer);
 var
   j, N:integer;
   X0,Y0,Z0, X1,Y1,Z1,
   XX, YY, ZZ, XC, YC, ZC,
   RX, RY, RZ, X, Y, Z, XT, YT, ZT:double;
   Width, Height, VarPointArrayCount:integer;
   P:TPoint;
   Canvas:TCanvas;
   LVcosT, LVsinT, LVcosZ, LVsinZ, LVDX, LVDY, XSign:double;
 begin

   if aCanvasTag=1 then begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FHCanvas;
         Width:=FHWidth;
         Height:=FHHeight
       end;
     BackCanvas:begin
         Canvas := FHBackBitmap.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FHBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     end;
   end else begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FVCanvas;
         Width:=FVWidth;
         Height:=FVHeight
       end;
     BackCanvas:begin
         Canvas := FVBackBitmap.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FVBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     end;
   end;

  with Canvas do begin
   Pen.Color:=FPenColor;
//   Pen.Width:=Trunc(FPenWidth/FView.RevScaleX);
   Pen.Width:=FPenWidth;
   case FPenStyle of
   1: Pen.Style := psDash;
   2: Pen.Style := psDot;
   3: Pen.Style := psDashDot;
   4: Pen.Style := psDashDotDot;
   else Pen.Style := psSolid;
   end;
   Pen.Mode:=TPenMode(FPenMode);
   XC:=FView.CX;
   YC:=FView.CY;
   ZC:=FView.CZ;

   VarPointArrayCount:=VarArrayHighBound(VarPointArray, 1)+1;
   N:=VarPointArrayCount div 3;

   X0:=0;
   Y0:=0;
   Z0:=0;
   X1:=0;
   Y1:=0;
   Z1:=0;

   if FLocalView<>nil then begin
     XSign:=FLocalView.CurrZ0;
     if XSign=0 then
       XSign:=1;
     LVDX:=FLocalView.CurrX0;
     LVDY:=FLocalView.CurrY0;
     LVcosT:=FLocalView.cosT;
     LVsinT:=FLocalView.sinT;
     LVcosZ:=FLocalView.cosZ;
     LVsinZ:=FLocalView.sinZ;
   end else begin
     LVDX:=0;
     LVDY:=0;
     LVcosT:=0;
     LVsinT:=0;
     LVcosZ:=0;
     LVsinZ:=0;
   end;

   for j:=0 to N-1 do begin
     X:=VarPointArray[3*j];
     Y:=VarPointArray[3*j+1];
     Z:=VarPointArray[3*j+2];
     if FLocalView=nil then begin
       XX:=X;
       YY:=Y;
       ZZ:=Z;
     end else begin
      RX:=1/FLocalView.RevScaleX;
      RY:=1/FLocalView.RevScaleY;
      RZ:=1/FLocalView.RevScaleZ;

      if LVcosT<>1 then begin
        XT:=X*RX*LVcosT-Z*RZ*LVsinT;
        YT:=Y*RY;
        ZT:=X*RX*LVsinT+Z*RZ*LVcosT;
      end else begin
        XT:=X*RX;
        YT:=Y*RY;
        ZT:=Z*RZ;
      end;

      XX:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
      YY:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
      ZZ:=ZT+FLocalView.CZ;
     end;

     if j=0 then begin
       X0:=XX;
       Y0:=YY;
       Z0:=ZZ;
     end else
     if j=N-1 then begin
       X1:=XX;
       Y1:=YY;
       Z1:=ZZ;
     end;

     with FView do begin
       if cosZ<>1 then begin
         P.X:=Round(Width/2+
              ((XX-XC)*cosZ-
               (YY-YC)*sinZ)/RevScaleX);
         case aCanvasTag of
         1:
         P.Y:=Round(Height/2-
                ((XX-XC)*sinZ+
                 (YY-YC)*cosZ)/RevScaleY);
         else
           P.Y:=Round(Height/2-
            (ZZ-ZC)/RevScaleY);
         end;
       end else begin
         P.X:=Round(Width/2+
              (XX-XC)/RevScaleX);
         case aCanvasTag of
         1:
         P.Y:=Round(Height/2-
                (YY-YC)/RevScaleY);
         else
           P.Y:=Round(Height/2-
            (ZZ-ZC)/RevScaleY);
         end;
       end;
     end;
     if not CheckVisiblePoint(aCanvasTag,XX,YY,ZZ) then Exit;
     PointArray[j]:=P;
   end;

   if (not LineIsVisible(aCanvasTag,X0,Y0,Z0,X1,Y1,Z1, True, CanvasLevel)) then Exit;

   PolyBezier(Slice(PointArray, N));

   Pen.Width:=1;
  end;
 end;
begin
  if (FCanvasSet and FrontCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
       DoDrawCurvedLine(1,VarPointArray, FrontCanvas);
    if (FMode=0) or (FMode=2) then
       DoDrawCurvedLine(2,VarPointArray, FrontCanvas);
  end;
  if (FCanvasSet and BackCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
       DoDrawCurvedLine(1,VarPointArray, BackCanvas);
    if (FMode=0) or (FMode=2) then
       DoDrawCurvedLine(2,VarPointArray, BackCanvas);
  end;
  if (FCanvasSet and BackCanvas2)<>0 then begin
    if (FMode=0) or (FMode=1) then
       DoDrawCurvedLine(1,VarPointArray, BackCanvas2);
    if (FMode=0) or (FMode=2) then
       DoDrawCurvedLine(2,VarPointArray, BackCanvas2);
  end;
end;

function TPainter.LineIsVisible(aCanvasTag: Integer; var X0, Y0, Z0, X1,
  Y1, Z1: Double; FittoCanvas: WordBool; CanvasLevel: Integer): WordBool;
var
  CrossingFlag:boolean;
  function GetLineIsVisible(aXMax, aYMax, aZMax,
                            aXMin, aYMin, aZMin:double): WordBool;
  var
    aX, aY, aZ:double;
  begin
    Result:=True;
    CrossingFlag:=False;
    if aCanvasTag=1 then begin
      if (X0<=aXMax) and (X0>=aXMin) and
         (Y0<=aYMax) and (Y0>=aYMin) then Exit;
      if (X1<=aXMax) and (X1>=aXMin) and
         (Y1<=aYMax) and (Y1>=aYMin) then Exit;

      CrossingFlag:=True;
      if (X0=X1) then begin
        if (Y0-aYMax)*(Y1-aYMax)<=0 then Exit;
        if (Y0-aYMin)*(Y1-aYMin)<=0 then Exit;
      end else begin
        aY:=Y0+(Y1-Y0)*(aXMax-X0)/(X1-X0);
        if ((Y0-aY)*(Y1-aY)<=0) and
           (aY<=aYMax) and (aY>=aYMin) then Exit;
        aY:=Y0+(Y1-Y0)*(aXMin-X0)/(X1-X0);
        if ((Y0-aY)*(Y1-aY)<=0) and
           (aY<=aYMax) and (aY>=aYMin) then Exit;
      end;

      if (Y0=Y1) then begin
        if (X0-aXMax)*(X1-aXMax)<=0 then Exit;
        if (X0-aXMin)*(X1-aXMin)<=0 then Exit;
      end else begin
        aX:=X0+(X1-X0)*(aYMax-Y0)/(Y1-Y0);
        if ((X0-aX)*(X1-aX)<=0) and
           (aX<=aXMax) and (aX>=aXMin) then Exit;
        aX:=X0+(X1-X0)*(aYMin-Y0)/(Y1-Y0);
        if ((X0-aX)*(X1-aX)<=0) and
           (aX<=aXMax) and (aX>=aXMin) then Exit;
      end;

    end else begin
      if (X0<=aXMax) and (X0>=aXMin) and
         (Z0<=aZMax) and (Z0>=aZMin) then Exit;
      if (X1<=aXMax) and (X1>=aXMin) and
         (Z1<=aZMax) and (Z1>=aZMin) then Exit;

      CrossingFlag:=True;
      if (X0=X1) then begin
        if (Z0-aZMax)*(Z1-aZMax)<=0 then Exit;
        if (Z0-aZMin)*(Z1-aZMin)<=0 then Exit;
      end else begin
        aZ:=Z0+(Z1-Z0)*(aXMax-X0)/(X1-X0);
        if ((Z0-aZ)*(Z1-aZ)<=0) and
           (aZ<=aZMax) and (aZ>=aZMin) then Exit;
        aZ:=Z0+(Z1-Z0)*(aXMin-X0)/(X1-X0);
        if ((Z0-aZ)*(Z1-aZ)<=0) and
           (aZ<=aZMax) and (aZ>=aZMin) then Exit;
      end;
    end;
    Result:=False;
  end;
var
  aXMax, aYMax, aZMax, aXMin, aYMin, aZMin:double;
begin
  if CanvasLevel=FrontCanvas then begin
    aXMax:=FXMax;
    aYMax:=FYMax;
    aZMax:=FZMax;
    aXMin:=FXMin;
    aYMin:=FYMin;
    aZMin:=FZMin;
  end else begin
    aXMax:=FXMaxB;
    aYMax:=FYMaxB;
    aZMax:=FZMaxB;
    aXMin:=FXMinB;
    aYMin:=FYMinB;
    aZMin:=FZMinB;
  end;

  Result:=GetLineIsVisible(aXMax, aYMax, aZMax,
                           aXMin, aYMin, aZMin);

  if not Result then Exit;
  if not CrossingFlag then Exit;
  if not FitToCanvas then Exit;

  if X0<aXMin then begin
    Y0:=Y1+(Y0-Y1)*(aXMin-X1)/(X0-X1);
    X0:=aXMin;
  end else
  if X0>aXMax then begin
    Y0:=Y1+(Y0-Y1)*(aXMax-X1)/(X0-X1);
    X0:=aXMax;
  end;

  if X1<aXMin then begin
    Y1:=Y0+(Y1-Y0)*(aXMin-X0)/(X1-X0);
    X1:=aXMin;
  end else
  if X1>aXMax then begin
    Y1:=Y0+(Y1-Y0)*(aXMax-X0)/(X1-X0);
    X1:=aXMax;
  end;

  if Y0<aYMin then begin
    X0:=X1+(X0-X1)*(aYMin-Y1)/(Y0-Y1);
    Y0:=aYMin;
  end else
  if Y0>aYMax then begin
    X0:=X1+(X0-X1)*(aYMax-Y1)/(Y0-Y1);
    Y0:=aYMax;
  end;

  if Y1<aYMin then begin
    X1:=X0+(X1-X0)*(aYMin-Y0)/(Y1-Y0);
    Y1:=aYMin;
  end else
  if Y1>aYMax then begin
    X1:=X0+(X1-X0)*(aYMax-Y0)/(Y1-Y0);
    Y1:=aYMax;
  end;
end;

procedure TPainter.DrawLine(WX0, WY0, WZ0, WX1, WY1, WZ1: Double);
var
  X0, Y0, Z0, X1, Y1, Z1, XC, YC, ZC, RX, RY, RZ:double;
 procedure DoDrawLine(aCanvasTag:integer; CanvasLevel:integer);
 var
   SX0, SY0, SX1, SY1:integer;
   Canvas:TCanvas;
   Width, Height:integer;
   W2, H2:double;
 begin
   try
   if (not CheckVisiblePoint(aCanvasTag,X0,Y0,Z0)) then Exit;
   if (not CheckVisiblePoint(aCanvasTag,X1,Y1,Z1)) then Exit;
   if (not LineIsVisible(aCanvasTag,X0,Y0,Z0,X1,Y1,Z1, True, CanvasLevel)) then Exit;
   if aCanvasTag=1 then begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FHCanvas;
         Width:=FHWidth;
         Height:=FHHeight
       end;
     BackCanvas:begin
         Canvas := FHBackBitmap.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FHBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     end;
   end else begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FVCanvas;
         Width:=FVWidth;
         Height:=FVHeight
       end;
     BackCanvas:begin
         Canvas := FVBackBitmap.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FVBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     end;
   end;
   W2:=Width/2;
   H2:=Height/2;

    with Canvas do begin
     Pen.Color:=FPenColor;
//     Pen.Width:=Trunc(FPenWidth/FView.RevScaleX);
     Pen.Width:=FPenWidth;
     case FPenStyle of
      1: Pen.Style := psDash;
      2: Pen.Style := psDot;
      3: Pen.Style := psDashDot;
      4: Pen.Style := psDashDotDot;
     else Pen.Style := psSolid;
     end;
     Pen.Mode:=TPenMode(FPenMode);
     with FView do begin
      if cosZ<>1 then begin
        SX0:=Round(W2+
            ((X0-XC)*cosZ-
             (Y0-YC)*sinZ)/RevScaleX);
        case aCanvasTag of
         1: SY0:=Round(H2-
              ((X0-XC)*sinZ+
               (Y0-YC)*cosZ)/RevScaleY);
        else SY0:=Round(H2-
              (Z0-ZC)/RevScaleY);
        end;
         SX1:=Round(W2+
           ((X1-XC)*cosZ
           -(Y1-YC)*sinZ)/RevScaleX);
        case aCanvasTag of
         1:SY1:=Round(H2-
              ((X1-XC)*sinZ
              +(Y1-YC)*cosZ)/RevScaleY);
        else
         SY1:=Round(H2-
          (Z1-ZC)/RevScaleY);
       end;
     end else begin // if cosZ=1
        SX0:=Round(W2+
            (X0-XC)/RevScaleX);
        case aCanvasTag of
         1: SY0:=Round(H2-
              (Y0-YC)/RevScaleY);
        else SY0:=Round(H2-
              (Z0-ZC)/RevScaleY);
        end;
         SX1:=Round(W2+
           (X1-XC)/RevScaleX);
        case aCanvasTag of
         1:SY1:=Round(H2-
              (Y1-YC)/RevScaleY);
        else
         SY1:=Round(H2-
          (Z1-ZC)/RevScaleY);
         end;
       end;
     end;

     if (SX1<>SX0) or
        (SY1<>SY0) then begin

         MoveTo(SX0, SY0);
         LineTo(SX1, SY1);
         Pen.Width:=0;
     end;
    end;
  except
    raise
  end
 end;
//____________________
var
  XT, YT, ZT:double;
  LVcosT, LVsinT, LVcosZ, LVsinZ, LVDX, LVDY, XSign:double;
begin
  if (WX0>41900) and (WX0<41200) and
     (WX1>41900) and (WX1<41200) and
     (WY0=WY1) and
     (trunc(WY0)=-76512) then
    XXX:=0;

  if FLocalView=nil then begin
    X0:=WX0;
    Y0:=WY0;
    Z0:=WZ0;
    X1:=WX1;
    Y1:=WY1;
    Z1:=WZ1;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XSign:=FLocalView.CurrZ0;
    if XSign=0 then
      XSign:=1;
    LVDX:=FLocalView.CurrX0;
    LVDY:=FLocalView.CurrY0;
    LVcosT:=FLocalView.cosT;
    LVsinT:=FLocalView.sinT;
    LVcosZ:=FLocalView.cosZ;
    LVsinZ:=FLocalView.sinZ;

    if LVcosT<>1 then begin
      XT:=WX0*RX*LVcosT-WZ0*RZ*LVsinT;
      YT:=WY0*RY;
      ZT:=WX0*RX*LVsinT+WZ0*RZ*LVcosT;
    end else begin
      XT:=WX0*RX;
      YT:=WY0*RY;
      ZT:=WZ0*RZ;
    end;

    X0:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y0:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;

    if LVcosT<>1 then begin
      XT:=WX1*RX*LVcosT-WZ1*RZ*LVsinT;
      YT:=WY1*RY;
      ZT:=WX1*RX*LVsinT+WZ1*RZ*LVcosT;
    end else begin
      XT:=WX1*RX;
      YT:=WY1*RY;
      ZT:=WZ1*RZ;
    end;

    X1:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y1:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z1:=ZT+FLocalView.CZ;
  end;

  XC:=FView.CX;
  YC:=FView.CY;
  ZC:=FView.CZ;
  if (FCanvasSet and FrontCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawLine(1, FrontCanvas);
    if (FMode=0) or (FMode=2) then
      DoDrawLine(2, FrontCanvas);
  end;
  if (FCanvasSet and BackCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawLine(1, BackCanvas);
    if (FMode=0) or (FMode=2) then
      DoDrawLine(2, BackCanvas);
  end;
  if (FCanvasSet and BackCanvas2)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawLine(1, BackCanvas2);
    if (FMode=0) or (FMode=2) then
      DoDrawLine(2, BackCanvas2);
  end;
end;

procedure TPainter.DrawPoint(WX, WY, WZ: Double);
var
 X0, Y0, Z0, RX, RY, RZ:double;

 procedure DoDrawPoint(aCanvasTag:integer; CanvasLevel:integer);
 var
  Canvas:TCanvas;
  Width, Height:integer;
  SX, SY, SZ:integer;
 begin
   if not CheckVisiblePoint(aCanvasTag,X0,Y0,Z0) then Exit;

   if aCanvasTag=1 then begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FHCanvas;
         Width:=FHWidth;
         Height:=FHHeight
       end;
     BackCanvas:begin
         Canvas := FHBackBitmap.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FHBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     end;
   end else begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FVCanvas;
         Width:=FVWidth;
         Height:=FVHeight
       end;
     BackCanvas:begin
         Canvas := FVBackBitmap.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FVBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     end;
   end;

  with Canvas do begin
    Pen.Color:=FPenColor;
    Pen.Width:=1;
    Pen.Style := psSolid;
    Pen.Mode:=TPenMode(FPenMode);
   with FView do begin
     SX:=Round(Width/2+
          ((X0-CX)*cosZ
          -(Y0-CY)*sinZ)/RevScaleX);
      If aCanvasTag=1 then begin
       SY:=Round(Height/2-
         ((X0-CX)*sinZ
            +(Y0-CY)*cosZ)/RevScaleY);
       Ellipse(SX-2, SY-2, SX+2, SY+2);
      end
      else begin
       SZ:=Round(Height/2-
          (Z0-CZ)/RevScaleY);
       Ellipse(SX-2, SZ-2, SX+2, SZ+2);
      end;
   end;
   Pen.Width:=0;
  end;
 end;
var
  XT, YT, ZT:double;
  LVcosT, LVsinT, LVcosZ, LVsinZ, LVDX, LVDY, XSign:double;
begin
  if FLocalView=nil then begin
    X0:=WX;
    Y0:=WY;
    Z0:=WZ;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XSign:=FLocalView.CurrZ0;
    if XSign=0 then
      XSign:=1;
    LVDX:=FLocalView.CurrX0;
    LVDY:=FLocalView.CurrY0;
    LVcosT:=FLocalView.cosT;
    LVsinT:=FLocalView.sinT;
    LVcosZ:=FLocalView.cosZ;
    LVsinZ:=FLocalView.sinZ;

    XT:=WX*RX*LVcosT-WZ*RZ*LVsinT;
    YT:=WY*RY;
    ZT:=WX*RX*LVsinT+WZ*RZ*LVcosT;
    X0:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y0:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;
  end;

  if (FCanvasSet and FrontCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawPoint(1, FrontCanvas);
    if (FMode=0) or (FMode=2) then
      DoDrawPoint(2, FrontCanvas);
  end;
  if (FCanvasSet and BackCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawPoint(1, BackCanvas);
    if (FMode=0) or (FMode=2) then
      DoDrawPoint(2, BackCanvas);
  end;
  if (FCanvasSet and BackCanvas2)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawPoint(1, BackCanvas2);
    if (FMode=0) or (FMode=2) then
      DoDrawPoint(2, BackCanvas2);
  end;
end;

procedure TPainter.DrawPolygon(const Lines: IDMCollection;
  Vertical: WordBool);
var
  Canvas:TCanvas;
  j, Width, Height, CanvasTag, OldBrushColor, OldPenColor, OldStyle, OldPenWidth:integer;
  C:ICoordNode;
  Points:array of TPoint;
  Line, NLine:ILine;
  Q, MinX, MaxX, MinY, MaxY, X, Y, Z, RX, RY, RZ,
  XT, YT, ZT:double;
  LVcosT, LVsinT, LVcosZ, LVsinZ, LVDX, LVDY, XSign:double;
begin
  if not Vertical then begin
    CanvasTag:=1;
    Canvas:=FHCanvas;
    Width:=FHWidth;
    Height:=FHHeight;
  end else begin
    CanvasTag:=2;
    Canvas:=FVCanvas;
    Width:=FVWidth;
    Height:=FVHeight;
  end;
  SetLength(Points, Lines.Count);
  C:=nil;
  MinX:=InfinitValue;
  MinY:=InfinitValue;
  MaxX:=-InfinitValue;
  MaxY:=-InfinitValue;
  if FLocalView<>nil then begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XSign:=FLocalView.CurrZ0;
    if XSign=0 then
      XSign:=1;
    LVDX:=FLocalView.CurrX0;
    LVDY:=FLocalView.CurrY0;
    LVcosT:=FLocalView.cosT;
    LVsinT:=FLocalView.sinT;
    LVcosZ:=FLocalView.cosZ;
    LVsinZ:=FLocalView.sinZ;

  end else begin
    RX:=1;
    RY:=1;
    RZ:=1;

    LVDX:=0;
    LVDY:=0;
    LVcosT:=0;
    LVsinT:=0;
    LVcosZ:=0;
    LVsinZ:=0;
  end;
  
  for j:=0 to Lines.Count-1 do begin
    Line:=Lines.Item[j] as ILine;
    if j>0 then begin
      if C=Line.C0 then
        C:=Line.C1
      else
        C:=Line.C0;
    end else begin
      NLine:=Lines.Item[1] as ILine;
      if (Line.C0=NLine.C0) or
         (Line.C0=NLine.C1) then
        C:=Line.C0
      else
        C:=Line.C1
    end;
    if FLocalView=nil then begin
      X:=C.X;
      Y:=C.Y;
      Z:=C.Z;
    end else begin
      XT:=C.X*RX*LVcosT-C.Z*RZ*LVsinT;
      YT:=C.Y*RY;
      ZT:=C.X*RX*LVsinT+C.Z*RZ*LVcosT;
      X:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
      Y:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
      Z:=ZT+FLocalView.CZ;
    end;
    if not CheckVisiblePoint(CanvasTag,X,Y,Z) then Exit;
    Q:=Width/2+
               ((X-FView.CX)*FView.CosZ-
                (Y-FView.CY)*FView.SinZ)/FView.RevScaleX;
    Points[j].X:=round(Q);
    case CanvasTag of
    1:begin
        Q:=Height/2-
               ((X-FView.CX)*FView.SinZ+
                (Y-FView.CY)*FView.CosZ)/FView.RevScaleY;
        Points[j].Y:=round(Q);
      end
    else
      begin
        Q:=Height/2-
              (Z-FView.CZ)/FView.RevScaleY;
        Points[j].Y:=round(Q);
      end;
    end;
    if MinX>Points[j].X then
      MinX:=Points[j].X;
    if MinY>Points[j].Y then
      MinY:=Points[j].Y;
    if MaxX<Points[j].X then
      MaxX:=Points[j].X;
    if MaxY<Points[j].Y then
      MaxY:=Points[j].Y;
  end;
  if (MaxX-MinX)>62800 then Exit;
  if (MaxY-MinY)>62800 then Exit;
  OldBrushColor:=Canvas.Brush.Color;
  OldPenColor:=Canvas.Pen.Color;
  OldPenWidth:=Canvas.Pen.Width;
  OldStyle:=ord(Canvas.Brush.Style);
  Canvas.Brush.Color:=FBrushColor;
  Canvas.Pen.Color:=FPenColor;
  Canvas.Pen.Width:=FPenWidth;
  Canvas.Brush.Style:=TBrushStyle(FBrushStyle);
  Canvas.Pen.Mode:=TPenMode(FPenMode);
    Canvas.Polygon(Points);
  Canvas.Brush.Color:=OldBrushColor;
  Canvas.Pen.Color:=OldPenColor;
  Canvas.Pen.Width:=OldPenWidth;
  Canvas.Brush.Style:=TBrushStyle(OldStyle);
end;

function TPainter.Get_PenStyle: Integer;
begin
  Result:=FPenStyle
end;

procedure TPainter.Set_PenStyle(Value: Integer);
begin
  FPenStyle:=Value
end;

function TPainter.Get_PenWidth: Double;
begin
  Result:=FPenWidth
end;

procedure TPainter.Set_PenWidth(Value: Double);
begin
  FPenWidth:=round(Value)
end;

function TPainter.Get_BrushColor: Integer;
begin
  Result:=FBrushColor
end;

procedure TPainter.Set_BrushColor(Value: Integer);
begin
  FBrushColor:=Value
end;

function TPainter.Get_BrushStyle: Integer;
begin
  Result:=FBrushStyle
end;

procedure TPainter.Set_BrushStyle(Value: Integer);
begin
  FBrushStyle:=Value
end;

function TPainter.CheckVisiblePoint(aCanvasTag: Integer; X, Y,
  Z: Double): WordBool;
var
  D0:double;
begin
  Result:=False;
  with FView do
  case aCanvasTag of
   1:if FLocalView=nil then
      Result:=(Z>=Zmin)and(Z<=Zmax)
     else
      Result:=(FLocalView.CZ>=Zmin)and(FLocalView.CZ<=Zmax);
   2: begin D0:=Y*cosZ+X*sinZ;
      Result:=(D0>=Dmin)and(D0<=Dmax) end;
  end;
end;

function TPainter.Get_HHeight: Integer;
begin
  Result:=FHHeight
end;

function TPainter.Get_HWidth: Integer;
begin
  Result:=FHWidth
end;

function TPainter.Get_VWidth: Integer;
begin
  Result:=FVWidth
end;

procedure TPainter.Set_HHeight(Value: Integer);
begin
  FHHeight:=Value;
end;

procedure TPainter.Set_HWidth(Value: Integer);
begin
  FHWidth:=Value;
end;

procedure TPainter.Set_VWidth(Value: Integer);
begin
  FVWidth:=Value;
end;

procedure TPainter.DrawAxes(XP, YP, ZP:integer);
var
 Canvas:TCanvas;
  procedure DoDrawAxes(aCanvasTag:integer);
  begin
    If aCanvasTag=1 then
      Canvas := FHCanvas
    else
      Canvas := FVCanvas;

    with Canvas do
    begin
      Pen.Mode:=pmNotXOR;
      Pen.Style:=psDot;
        If aCanvasTag=1 then begin
          MoveTo(Canvas.ClipRect.Left, YP);
          LineTo(Canvas.ClipRect.Right,YP);
        end else begin
          MoveTo(Canvas.ClipRect.Left, ZP);
          LineTo(Canvas.ClipRect.Right,ZP);
        end;
        MoveTo(XP,Canvas.ClipRect.Top);
        LineTo(XP,Canvas.ClipRect.Bottom);
      Pen.Color:=clBlack;
      Pen.Mode:=pmCopy;
      Pen.Style:=psSolid;
     end;
  end;
begin
  DoDrawAxes(1);
  DoDrawAxes(2);
end;

procedure TPainter.SetRangePix;
var
  Q:double;
begin
  with FView do begin
    Q:=CY*cosZ+CX*sinZ;
    FDmaxPix := FHHeight div 2-Round((Dmax-Q)/RevScaleY);
    FDminPix := FHHeight div 2-Round((Dmin-Q)/RevScaleY);
    Q:=FView.CZ;
    FZmaxPix := FVHeight div 2-Round((Zmax-Q)/RevScaleY);
    FZminPix := FVHeight div 2-Round((Zmin-Q)/RevScaleY);
  end;
end;

function TPainter.Get_VHeight: Integer;
begin
  Result:=FVHeight
end;

procedure TPainter.Set_VHeight(Value: Integer);
begin
  FVHeight:=Value;
end;

procedure TPainter.DrawRangeMarks;
  procedure DrawMarks(const aCanvas:TCanvas; PosTop,PosBot:integer);
  begin
    if FView=nil then Exit;
    with aCanvas do begin
      aCanvas.Pen.Color:=clBlack;
      aCanvas.Pen.Mode:=pmNotXOR;
      aCanvas.Pen.Style:=psDot;
        aCanvas.MoveTo(aCanvas.ClipRect.TopLeft.x,     PosTop);
        aCanvas.LineTo(aCanvas.ClipRect.BottomRight.x, PosTop);
        aCanvas.MoveTo(aCanvas.ClipRect.TopLeft.x,     PosBot);
        aCanvas.LineTo(aCanvas.ClipRect.BottomRight.x, PosBot);
      aCanvas.Pen.Mode:= pmCopy;
      aCanvas.Pen.Style:=psSolid;
    end;
  end;
begin
  DrawMarks(FHCanvas,FDmaxPix,FDminPix);
  DrawMarks(FVCanvas,FZmaxPix,FZminPix);
end;

function TPainter.Get_DmaxPix: Integer;
begin
  Result:=FDmaxPix
end;

function TPainter.Get_DminPix: Integer;
begin
  Result:=FDminPix
end;

function TPainter.Get_ZmaxPix: Integer;
begin
  Result:=FZmaxPix
end;

function TPainter.Get_ZminPix: Integer;
begin
  Result:=FZminPix
end;

procedure TPainter.Set_DmaxPix(Value: Integer);
begin
  FDmaxPix:=Value;
  with FView do
    Dmax:=(CX*sinZ+CY*cosZ)+
          (FHHeight div 2 - FDmaxPix)*RevScaleY;
end;

procedure TPainter.Set_DminPix(Value: Integer);
begin
  FDminPix:=Value;
  with FView do
    Dmin:=(CX*sinZ+CY*cosZ)+
          (FHHeight div 2 - FDminPix)*RevScaleY;
end;

procedure TPainter.Set_ZmaxPix(Value: Integer);
begin
  FZmaxPix:=Value;
  with FView do
    Zmax:=CZ+
         (FVHeight div 2 - FZmaxPix)*RevScaleY;
end;

procedure TPainter.Set_ZminPix(Value: Integer);
begin
  FZminPix:=Value;
  with FView do
    Zmin:=CZ+
         (FVHeight div 2 - FZminPix)*RevScaleY;
end;

function TPainter.Get_HCanvasHandle: Integer;
begin
  Result:=FHCanvas.Handle
end;

function TPainter.Get_VCanvasHandle: Integer;
begin
  Result:=FVCanvas.Handle
end;

procedure TPainter.Set_HCanvasHandle(Value: Integer);
var
  H:HDC;
begin
  H:=HDC(Value);
  FHCanvas.Handle:=H;
end;

procedure TPainter.Set_VCanvasHandle(Value: Integer);
var
  H:HDC;
begin
  H:=HDC(Value);
  FVCanvas.Handle:=H
end;

destructor TPainter.Destroy;
begin
  inherited;
  FHCanvas.Free;
  FVCanvas.Free;

  FHBackBitmap.Free;
  FVBackBitmap.Free;
  FHBackBitmap2.Free;
  FVBackBitmap2.Free;
end;

procedure TPainter.Initialize;
begin
  inherited;
  FHCanvas:=TCanvas.Create;
  FVCanvas:=TCanvas.Create;
  FPenMode:=ord(pmCopy);
  FPenStyle:=ord(psSolid);
  TPicture.RegisterClipboardFormat(cf_JPEG, TJPEGImage);

  FCanvasSet:=FrontCanvas + BackCanvas;

  FHTMPIndex:=0;
  FVTMPIndex:=0;

  FHBackBitmap:=TBitmap.Create;
  FVBackBitmap:=TBitmap.Create;
  FHBackBitmap2:=TBitmap.Create;
  FVBackBitmap2:=TBitmap.Create;
end;

procedure TPainter.DragLine(PX0, PY0, PZ0, PX1, PY1, PZ1: Integer);
begin
  FHCanvas.Pen.Mode:=pmNotXor;
  FHCanvas.Pen.Style:=psDot;
  FHCanvas.Pen.Color:=clBlack;
    FHCanvas.MoveTo(PX0,PY0);
    FHCanvas.LineTo(PX1,PY1);
  FHCanvas.Pen.Mode:=TPenMode(FPenMode);
  FHCanvas.Pen.Style:=TPenStyle(FPenStyle);

  FVCanvas.Pen.Mode:=pmNotXor;
  FVCanvas.Pen.Style:=psDot;
  FVCanvas.Pen.Color:=clBlack;
    FVCanvas.MoveTo(PX0,PZ0);
    FVCanvas.LineTo(PX1,PZ1);
  FVCanvas.Pen.Mode:=TPenMode(FPenMode);
  FVCanvas.Pen.Style:=TPenStyle(FPenStyle);
end;

procedure TPainter.DragRect(PX0, PY0, PZ0, PX1, PY1, PZ1: Integer);
begin
  FHCanvas.Pen.Mode:=pmNotXor;
  FHCanvas.Pen.Style:=psDot;
  FHCanvas.Pen.Color:=clBlack;
    FHCanvas.MoveTo(PX0,PY0);
    FHCanvas.LineTo(PX0,PY1);
    FHCanvas.LineTo(PX1,PY1);
    if PY0<>PY1 then begin
      FHCanvas.MoveTo(PX0,PY0);
      FHCanvas.LineTo(PX1,PY0);
      FHCanvas.LineTo(PX1,PY1);
    end;
  FHCanvas.Pen.Mode:=TPenMode(FPenMode);
  FHCanvas.Pen.Style:=TPenStyle(FPenStyle);

  FVCanvas.Pen.Mode:=pmNotXor;
  FVCanvas.Pen.Style:=psDot;
  FVCanvas.Pen.Color:=clBlack;
    FVCanvas.MoveTo(PX0,PZ0);
    FVCanvas.LineTo(PX0,PZ1);
    FVCanvas.LineTo(PX1,PZ1);
    if PZ0<>PZ1 then begin
      FVCanvas.MoveTo(PX0,PZ0);
      FVCanvas.LineTo(PX1,PZ0);
      FVCanvas.LineTo(PX1,PZ1);
    end;
  FVCanvas.Pen.Mode:=TPenMode(FPenMode);
  FVCanvas.Pen.Style:=TPenStyle(FPenStyle);
end;

procedure TPainter.WP_To_P(WX, WY, WZ:double;
                       out PX, PY, PZ:integer);
var
  DX, DY, DZ, RevScale, cosZ, sinZ:double;
begin
  DX:=WX-FView.CX;
  DY:=WY-FView.CY;
  DZ:=WZ-FView.CZ;
  RevScale:=FView.RevScale;
  cosZ:=FView.cosZ;
  sinZ:=FView.sinZ;
  PX:=Round(FHWidth/2 +(DX*cosZ-DY*sinZ)/RevScale);
  PY:=Round(FHHeight/2-(DX*sinZ+DY*cosZ)/RevScale);
  PZ:=Round(FVHeight/2- DZ/RevScale);
end;


procedure TPainter.P_To_WP(PX, PY, Tag: Integer; out WX, WY, WZ: Double);
var
  RevScale, cosZ, sinZ:double;
begin
  RevScale:=FView.RevScale;
  cosZ:=FView.cosZ;
  sinZ:=FView.sinZ;
  if Tag=1 then begin
    WX:=FView.CX+(+(PX-FHWidth/2)*cosZ-(PY-FHHeight/2)*sinZ)*RevScale;
    WY:=FView.CY-(+(PX-FHWidth/2)*sinZ+(PY-FHHeight/2)*cosZ)*RevScale;
  end else begin
    WX:=FView.CX+(+(PX-FHWidth/2)*cosZ)*RevScale;
    WZ:=FView.CZ-(PY-FVHeight/2)*RevScale;
  end;
end;

procedure TPainter.DragCurvedLine(VarPointArray: OleVariant);
var
  j, N, VarPointArrayCount:integer;
  P:TPoint;
begin
   VarPointArrayCount:=VarArrayHighBound(VarPointArray, 1)+1;
   N:=VarPointArrayCount div 3;

  FHCanvas.Pen.Mode:=pmNotXor;
  FHCanvas.Pen.Style:=psDot;
  FHCanvas.Pen.Color:=clBlack;
  for j:=0 to N-1 do begin
    P.X:=VarPointArray[3*j];
    P.Y:=VarPointArray[3*j+1];
    PointArray[j]:=P;
  end;
    FHCanvas.PolyBezier(Slice(PointArray, N));
  FHCanvas.Pen.Mode:=TPenMode(FPenMode);
  FHCanvas.Pen.Style:=TPenStyle(FPenStyle);

  FVCanvas.Pen.Mode:=pmNotXor;
  FVCanvas.Pen.Style:=psDot;
  FVCanvas.Pen.Color:=clBlack;
  for j:=0 to N-1 do begin
    P.X:=VarPointArray[3*j];
    P.Y:=VarPointArray[3*j+2];
    PointArray[j]:=P;
  end;
    FVCanvas.PolyBezier(Slice(PointArray, N));
  FVCanvas.Pen.Mode:=TPenMode(FPenMode);
  FVCanvas.Pen.Style:=TPenStyle(FPenStyle);
end;

procedure TPainter.DrawRectangle(WX0, WY0, WZ0, WX1, WY1, WZ1,
  Angle: Double);
var
  rr, dx, dy, dz, cosB, sinB, cosG, sinG, cosA, sinA, B, A, G:double;
  WX2, WY2, WZ2, WX3, WY3, WZ3:double;
begin
  dx:=WX1-WX0;
  dy:=WY1-WY0;
  dz:=WZ1-WZ0;
  rr:=dx*dx+dy*dy+dz*dz;
  if rr=0 then Exit;
  rr:=sqrt(rr);
  cosB:=dx/rr;
  sinB:=dy/rr;
  G:=Angle+FView.ZAngle;
  cosG:=cos(G/180*3.1415926);
  sinG:=sin(G/180*3.1415926);
  cosA:=cosG*cosB+sinG*sinB;
  sinA:=sinG*cosB-cosG*sinB;
  B:=rr*cosA;
  A:=rr*sinA;
  WX2:=WX0+B*cosG;
  WY2:=WY0+B*sinG;
  WZ2:=WZ0;
  WX3:=WX0+A*sinG;
  WY3:=WY0-A*cosG;
  WZ3:=WZ0;
  DrawLine(WX0, WY0, WZ0, WX2, WY2, WZ2);
  DrawLine(WX0, WY0, WZ0, WX3, WY3, WZ3);
  DrawLine(WX2, WY2, WZ2, WX1, WY1, WZ1);
  DrawLine(WX3, WY3, WZ3, WX1, WY1, WZ1);
end;

function TPainter.Get_LocalViewU: IUnknown;
begin
  Result:=FLocalView
end;

procedure TPainter.Set_LocalViewU(const Value: IUnknown);
begin
  FLocalView:=Value as IView
end;

procedure GDIError;
begin
end;

procedure TPainter.DrawText(WX, WY, WZ: Double; const Text: WideString;
  TextSize: Double; const FontName: WideString; FontSize, FontColor,
  FontStyle, ScaleMode: Integer);
var
 X0, Y0, Z0, RX, RY, RZ:double;

 procedure DoDrawPoint(aCanvasTag:integer; CanvasLevel:integer);
 var
  Canvas:TCanvas;
  Width, Height:integer;
  SX, SY, SZ:integer;
  Style:TFontStyles;
 begin
   if not CheckVisiblePoint(aCanvasTag,X0,Y0,Z0) then Exit;

   if aCanvasTag=1 then begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FHCanvas;
         Width:=FHWidth;
         Height:=FHHeight
       end;
     BackCanvas:begin
         Canvas := FHBackBitmap.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FHBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     end;
   end else begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FVCanvas;
         Width:=FVWidth;
         Height:=FVHeight
       end;
     BackCanvas:begin
         Canvas := FVBackBitmap.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FVBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     end;
   end;

  with Canvas do begin
   Font.Name:=FontName;
   Font.Color:=FontColor;

   Style:=[];
   if (_fsBold and FontStyle)<>0 then
     Style:=Style+[fsBold];
   if (_fsItalic and FontStyle)<>0 then
     Style:=Style+[fsItalic];
   if (_fsUnderline and FontStyle)<>0 then
     Style:=Style+[fsUnderline];
   if (_fsStrikeOut and FontStyle)<>0 then
     Style:=Style+[fsStrikeOut];
   Font.Style:=Style;

   case ScaleMode of
   0:Font.Size:=FontSize;
   1:begin
       Font.Size:=-round(TextSize/FView.RevScaleX);
       if Font.Size=0 then
         Exit;
     end;
   end;

   FBrushStyle:=1;

   UpdateFont;

    with FView do begin
      SX:=Round(Width/2+
          ((X0-CX)*cosZ
          -(Y0-CY)*sinZ)/RevScaleX);
      If aCanvasTag=1 then begin
        SY:=Round(Height/2-
         ((X0-CX)*sinZ
            +(Y0-CY)*cosZ)/RevScaleY);
       TextOut(SX, SY, Text);
      end
      else begin
        SZ:=Round(Height/2-
          (Z0-CZ)/RevScaleY);
        TextOut(SX, SZ, Text);
      end;
    end;
  Pen.Width:=0;
  end;
 end;
var
  XT, YT, ZT:double;
  LVcosT, LVsinT, LVcosZ, LVsinZ, LVDX, LVDY, XSign:double;
begin
  if FLocalView=nil then begin
    X0:=WX;
    Y0:=WY;
    Z0:=WZ;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XSign:=FLocalView.CurrZ0;
    if XSign=0 then
      XSign:=1;
    LVDX:=FLocalView.CurrX0;
    LVDY:=FLocalView.CurrY0;
    LVcosT:=FLocalView.cosT;
    LVsinT:=FLocalView.sinT;
    LVcosZ:=FLocalView.cosZ;
    LVsinZ:=FLocalView.sinZ;


    XT:=WX*RX*LVcosT-WZ*RZ*LVsinT;
    YT:=WY*RY;
    ZT:=WX*RX*LVsinT+WZ*RZ*LVcosT;
    X0:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y0:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;
  end;

  if (FCanvasSet and FrontCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawPoint(1, FrontCanvas);
  end;
  if (FCanvasSet and BackCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawPoint(1, BackCanvas);
  end;
  if (FCanvasSet and BackCanvas2)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawPoint(1, BackCanvas2);
  end;
end;

function TPainter.Get_LayerIndex: Integer;
begin

end;

procedure TPainter.Set_LayerIndex(Value: Integer);
begin

end;

function TPainter.Get_UseLayers: WordBool;
begin
  Result:=False
end;

procedure TPainter.DrawArc(WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, WZ2: Double);
 {WX0,WY0,WZ0 -центр окружн., WX1,WY1,WZ1 -центральн.точка дуги на окружн.,
  WX0, WY0, WZ0 - WX2, WY2, WZ2 -направл.на котором лежит 1-я точка дуги,
  2-я точка дуги вычисл.симетрично относит.центр.}
var
 x0,y0,z0,x1,y1,z1,xC,yC,zC:Double;
 R,dX1,dY1,NewX2,NewY2,cos,sin:double;
 NewX3,NewY3,x2,y2,z2,x3,y3,z3:double;
 XT, YT, ZT:double;
 RX, RY, RZ:double;
//___________
   procedure DoDrawArc(aCanvasTag:integer; CanvasLevel:integer);
   var
    SX0, SY0, SX1, SY1, SX2, SY2, SX3, SY3:integer;
    Canvas:TCanvas;
    Width, Height:integer;
 begin
   try
   if (not CheckVisiblePoint(aCanvasTag,X0,Y0,Z0)) then Exit;
   if (not CheckVisiblePoint(aCanvasTag,X1,Y1,Z1)) then Exit;
//   if (not LineIsVisible(aCanvasTag,X0,Y0,Z0,X1,Y1,Z1)) then Exit;
   if aCanvasTag=1 then begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FHCanvas;
         Width:=FHWidth;
         Height:=FHHeight
       end;
     BackCanvas:begin
         Canvas := FHBackBitmap.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FHBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     end;
   end else begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FVCanvas;
         Width:=FVWidth;
         Height:=FVHeight
       end;
     BackCanvas:begin
         Canvas := FVBackBitmap.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FVBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     end;
   end;

    with Canvas do begin
     Pen.Color:=FPenColor;
     Pen.Width:=FPenWidth;
     case FPenStyle of
      1: Pen.Style := psDash;
      2: Pen.Style := psDot;
      3: Pen.Style := psDashDot;
      4: Pen.Style := psDashDotDot;
     else Pen.Style := psSolid;
     end;
     Pen.Mode:=TPenMode(FPenMode);
     with FView do begin
      SX0:=Round(Width/2+((X0-XC)*cosZ-(Y0-YC)*sinZ)/RevScaleX);
      SX1:=Round(Width/2+((X1-XC)*cosZ-(Y1-YC)*sinZ)/RevScaleX);
      SX2:=Round(Width/2+((X2-XC)*cosZ-(Y2-YC)*sinZ)/RevScaleX);
      SX3:=Round(Width/2+((X3-XC)*cosZ-(Y3-YC)*sinZ)/RevScaleX);
      case aCanvasTag of
       1: begin
           SY0:=Round(Height/2-((X0-XC)*sinZ+(Y0-YC)*cosZ)/RevScaleY);
           SY1:=Round(Height/2-((X1-XC)*sinZ+(Y1-YC)*cosZ)/RevScaleY);
           SY2:=Round(Height/2-((X2-XC)*sinZ+(Y2-YC)*cosZ)/RevScaleX);
           SY3:=Round(Height/2-((X3-XC)*sinZ+(Y3-YC)*cosZ)/RevScaleX);
          end else begin
           SY0:=Round(Height/2-(Z0-ZC)/RevScaleY);
           SY1:=Round(Height/2-(Z1-ZC)/RevScaleY);
           SY2:=Round(Height/2-(Z2-ZC)/RevScaleY);
           SY3:=Round(Height/2-(Z3-ZC)/RevScaleY);
          end;
      end;

     end;
     if (abs(SX1-SX0)<>0) or
        (abs(SY1-SY0)<>0) then begin
         Canvas.Arc(Sx0,Sy0,Sx1,Sy1,SX2,SY2,SX3,SY3);
       Pen.Width:=0;
     end;
    end;
  except
    raise
  end
 end;

var
  LVcosT, LVsinT, LVcosZ, LVsinZ, LVDX, LVDY, XSign:double;
begin
 dX1:=WX1-WX0;
 dY1:=WY1-WY0;
 R:=sqrt(sqr(dX1) + sqr(dY1));
 cos:=FView.CosZ;

 if cos=1 then begin
  x0:=WX0-R;  //x0,y0-x1,y1 коорд.углов описыв.квадрата
  y0:=WY0+R;
  Z0:=WZ0;

  x1:=WX0+R;
  y1:=WY0-R;
  Z1:=WZ1;
 end else begin
  sin:=FView.SinZ;
  x0:=((-R)*cos + (R)*sin);  //x0,y0-x1,y1 коорд.углов описыв.квадрата
  y0:=-(-R)*sin + (R)*cos;
  z0:=WZ0;

  x1:=((R)*cos + (-R)*sin);
  y1:=-(R)*sin + (-R)*cos;

  x0:=(WX0)+x0;
  y0:=(WY0)+y0;
  x1:=(WX0)+x1;
  y1:=(WY0)+y1;
  z1:=WZ1;
 end;

 x2:=WX2;   //1 точка дуги
 y2:=WY2;
 z2:=WZ2;

 {опред.2-ю точку дуги в нов.коорд.}
 if R=0 then Exit;
 cos:=dX1/R;
 sin:=dY1/R;
 NewX2:=(WX2-WX0)*cos + (WY2-WY0)*sin;
 NewY2:=-(WX2-WX0)*sin + (WY2-WY0)*cos;
 NewX3:=NewX2;
 NewY3:=-NewY2;
 {преобраз.в cтар.коорд. 2-ю точку дуги}
 x3:=WX0 + NewX3*cos - NewY3*sin;   //
 y3:=WY0 + NewX3*sin + NewY3*cos;
 Z3:=WZ2;

  if FLocalView<>nil then begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XSign:=FLocalView.CurrZ0;
    if XSign=0 then
      XSign:=1;
    LVDX:=FLocalView.CurrX0;
    LVDY:=FLocalView.CurrY0;
    LVcosT:=FLocalView.cosT;
    LVsinT:=FLocalView.sinT;
    LVcosZ:=FLocalView.cosZ;
    LVsinZ:=FLocalView.sinZ;

    XT:=x0*RX*LVcosT-z0*RZ*LVsinT;
    YT:=y0*RY;
    ZT:=x0*RX*LVsinT+z0*RZ*LVcosT;

    x0:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    y0:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    z0:=ZT+FLocalView.CZ;

    XT:=x1*RX*LVcosT-z1*RZ*LVsinT;
    YT:=y1*RY;
    ZT:=x1*RX*LVsinT+z1*RZ*LVcosT;

    x1:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    y1:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    z1:=ZT+FLocalView.CZ;

    XT:=x2*RX*LVcosT-z2*RZ*LVsinT;
    YT:=y2*RY;
    ZT:=x2*RX*LVsinT+z2*RZ*LVcosT;

    x2:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    y2:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    z2:=ZT+FLocalView.CZ;

    XT:=x3*RX*LVcosT-z3*RZ*LVsinT;
    YT:=y3*RY;
    ZT:=x3*RX*LVsinT+z3*RZ*LVcosT;

    x3:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    y3:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    z3:=ZT+FLocalView.CZ;
  end;

  XC:=FView.CX;
  YC:=FView.CY;
  ZC:=FView.CZ;

  if (FCanvasSet and FrontCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawArc(1, FrontCanvas);
    if (FMode=0) or (FMode=2) then
      DoDrawArc(2, FrontCanvas);
  end;
  if (FCanvasSet and BackCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawArc(1, BackCanvas);
    if (FMode=0) or (FMode=2) then
      DoDrawArc(2, BackCanvas);
  end;
  if (FCanvasSet and BackCanvas2)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawArc(1, BackCanvas2);
    if (FMode=0) or (FMode=2) then
      DoDrawArc(2, BackCanvas2);
  end;
end;

procedure TPainter.SetLimits;
var
  RevScale, cosZ, sinZ:double;
  CX, CY, CZ,
  X0, Y0, X1, Y1,
  X2, Y2, X3, Y3: double;
begin
  if FView=nil then Exit;
  RevScale:=FView.RevScale;
  cosZ:=FView.cosZ;
  sinZ:=FView.sinZ;
  CX:=FView.CX;
  CY:=FView.CY;
  CZ:=FView.CZ;
  
  X0:=CX+(FHWidth/2*cosZ-FHHeight/2*sinZ)*RevScale;
  Y0:=CY-(FHWidth/2*sinZ+FHHeight/2*cosZ)*RevScale;
  X1:=CX+(FHWidth/2*cosZ+FHHeight/2*sinZ)*RevScale;
  Y1:=CY-(FHWidth/2*sinZ-FHHeight/2*cosZ)*RevScale;
  X2:=CX+(-FHWidth/2*cosZ-FHHeight/2*sinZ)*RevScale;
  Y2:=CY-(-FHWidth/2*sinZ+FHHeight/2*cosZ)*RevScale;
  X3:=CX+(-FHWidth/2*cosZ+FHHeight/2*sinZ)*RevScale;
  Y3:=CY-(-FHWidth/2*sinZ-FHHeight/2*cosZ)*RevScale;

  FXmax:=X0;
  if FXmax<X1 then FXmax:=X1;
  if FXmax<X2 then FXmax:=X2;
  if FXmax<X3 then FXmax:=X3;

  FYmax:=Y0;
  if FYmax<Y1 then FYmax:=Y1;
  if FYmax<Y2 then FYmax:=Y2;
  if FYmax<Y3 then FYmax:=Y3;

  FXmin:=X0;
  if FXmin>X1 then FXmin:=X1;
  if FXmin>X2 then FXmin:=X2;
  if FXmin>X3 then FXmin:=X3;

  FYmin:=Y0;
  if FYmin>Y1 then FYmin:=Y1;
  if FYmin>Y2 then FYmin:=Y2;
  if FYmin>Y3 then FYmin:=Y3;

  FZmax:=CZ+FVHeight/2*RevScale;
  FZmin:=CZ-FVHeight/2*RevScale;

  X0:=CX+(FHWidth/2*cosZ-FHHeight/2*sinZ)*RevScale*BackCanvasFactor;
  Y0:=CY-(FHWidth/2*sinZ+FHHeight/2*cosZ)*RevScale*BackCanvasFactor;
  X1:=CX+(FHWidth/2*cosZ+FHHeight/2*sinZ)*RevScale*BackCanvasFactor;
  Y1:=CY-(FHWidth/2*sinZ-FHHeight/2*cosZ)*RevScale*BackCanvasFactor;
  X2:=CX+(-FHWidth/2*cosZ-FHHeight/2*sinZ)*RevScale*BackCanvasFactor;
  Y2:=CY-(-FHWidth/2*sinZ+FHHeight/2*cosZ)*RevScale*BackCanvasFactor;
  X3:=CX+(-FHWidth/2*cosZ+FHHeight/2*sinZ)*RevScale*BackCanvasFactor;
  Y3:=CY-(-FHWidth/2*sinZ-FHHeight/2*cosZ)*RevScale*BackCanvasFactor;

  FXmaxB:=X0;
  if FXmaxB<X1 then FXmaxB:=X1;
  if FXmaxB<X2 then FXmaxB:=X2;
  if FXmaxB<X3 then FXmaxB:=X3;

  FYmaxB:=Y0;
  if FYmaxB<Y1 then FYmaxB:=Y1;
  if FYmaxB<Y2 then FYmaxB:=Y2;
  if FYmaxB<Y3 then FYmaxB:=Y3;

  FXminB:=X0;
  if FXminB>X1 then FXminB:=X1;
  if FXminB>X2 then FXminB:=X2;
  if FXminB>X3 then FXminB:=X3;

  FYminB:=Y0;
  if FYminB>Y1 then FYminB:=Y1;
  if FYminB>Y2 then FYminB:=Y2;
  if FYminB>Y3 then FYminB:=Y3;

  FZmaxB:=CZ+FVHeight/2*RevScale*BackCanvasFactor;
  FZminB:=CZ-FVHeight/2*RevScale*BackCanvasFactor;

end;

function TPainter.Get_Mode: Integer;
begin
  Result:=FMode
end;

procedure TPainter.Set_Mode(Value: Integer);
begin
  FMode:=Value
end;

procedure TPainter.DrawCircle(WX, WY, WZ, R: Double;
  R_In_Pixels: WordBool);
var
 X0, Y0, Z0, RX, RY, RZ:double;

 procedure DoDrawCircle(aCanvasTag:integer; CanvasLevel:integer);
 var
  Canvas:TCanvas;
  Width, Height:integer;
  SX, SY, SZ, SR:integer;
  OldBrushStyle:TBrushStyle;
 begin
   if not CheckVisiblePoint(aCanvasTag,X0,Y0,Z0) then Exit;

   if aCanvasTag=1 then begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FHCanvas;
         Width:=FHWidth;
         Height:=FHHeight
       end;
     BackCanvas:begin
         Canvas := FHBackBitmap.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FHBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FHWidth;
         Height:=BackCanvasFactor*FHHeight
       end;
     end;
   end else begin
     case CanvasLevel of
     FrontCanvas:begin
         Canvas := FVCanvas;
         Width:=FVWidth;
         Height:=FVHeight
       end;
     BackCanvas:begin
         Canvas := FVBackBitmap.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     else // BackCanvas2
       begin
         Canvas := FVBackBitmap2.Canvas;
         Width:=BackCanvasFactor*FVWidth;
         Height:=BackCanvasFactor*FVHeight
       end;
     end;
   end;

   with Canvas do begin
     Pen.Color:=FPenColor;
     Pen.Width:=1;
     case FPenStyle of
     1: Pen.Style := psDash;
     2: Pen.Style := psDot;
     3: Pen.Style := psDashDot;
     4: Pen.Style := psDashDotDot;
     else Pen.Style := psSolid;
     end;
     OldBrushStyle:=Brush.Style;
     Brush.Style:=bsClear;
     Pen.Mode:=TPenMode(FPenMode);
     with FView do begin
       SX:=Round(Width/2+
          ((X0-CX)*cosZ
          -(Y0-CY)*sinZ)/RevScaleX);
       if R_In_Pixels then
         SR:=round(R)
       else
         SR:=round(R/RevScaleX);
         If aCanvasTag=1 then begin
           SY:=Round(Height/2-
              ((X0-CX)*sinZ
                +(Y0-CY)*cosZ)/RevScaleY);
           Ellipse(SX-SR, SY-SR, SX+SR, SY+SR);
         end
         else begin
           SZ:=Round(Height/2-
               (Z0-CZ)/RevScaleY);
           Ellipse(SX-SR, SZ-SR, SX+SR, SZ+SR);
         end;
       Pen.Width:=0;
       Brush.Style:=OldBrushStyle;
     end;
   end;
 end;
var
  XT, YT, ZT:double;
  LVcosT, LVsinT, LVcosZ, LVsinZ, LVDX, LVDY, XSign:double;
begin
  if FLocalView=nil then begin
    X0:=WX;
    Y0:=WY;
    Z0:=WZ;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XSign:=FLocalView.CurrZ0;
    if XSign=0 then
      XSign:=1;
    LVDX:=FLocalView.CurrX0;
    LVDY:=FLocalView.CurrY0;
    LVcosT:=FLocalView.cosT;
    LVsinT:=FLocalView.sinT;
    LVcosZ:=FLocalView.cosZ;
    LVsinZ:=FLocalView.sinZ;

    XT:=WX*RX*LVcosT-WZ*RZ*LVsinT;
    YT:=WY*RY;
    ZT:=WX*RX*LVsinT+WZ*RZ*LVcosT;
    X0:=((XT+LVDX)*XSign*LVcosZ-(YT+LVDY)*LVsinZ)+FLocalView.CX;
    Y0:=((XT+LVDX)*XSign*LVsinZ+(YT+LVDY)*LVcosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;
  end;

  if (FCanvasSet and FrontCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawCircle(1, FrontCanvas);
//    if (FMode=0) or (FMode=2) then
//      DoDrawCircle(2, FrontCanvas);
  end;
  if (FCanvasSet and BackCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawCircle(1, BackCanvas);
//    if (FMode=0) or (FMode=2) then
//      DoDrawCircle(2, BackCanvas);
  end;
  if (FCanvasSet and BackCanvas2)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoDrawCircle(1, BackCanvas2);
//    if (FMode=0) or (FMode=2) then
//      DoDrawCircle(2, BackCanvas2);
  end;
end;

procedure TPainter.CloseBlock;
begin
end;

procedure TPainter.InsertBlock(const ElementU: IUnknown);
begin
end;

procedure TPainter.SetCanvasLocked(const Value: boolean);
begin
{
  FCanvasLocked := Value;
  if Value then begin
    FHCanvas.Lock;
    FVCanvas.Lock;
  end else begin
    FHCanvas.UnLock;
    FVCanvas.UnLock;
  end;
}
end;

procedure TPainter.DrawTexture(const TextureName: WideString;
  var TextureNum: Integer; X0, Y0, Z0, X1, Y1, Z1, x2, y2, z2, x3, y3, z3,
  NX, NY, NZ, MX, MY: Double);
begin
end;

procedure TPainter.FastDraw;
var
  SourceR, DestR:TRect;
  View:IView;
  CX, CY, CZ:double;
  dPX, dPY, dPZ:integer;
begin
  View:=Get_ViewU as IView;
  CX:=View.CX;
  CY:=View.CY;
  CZ:=View.CZ;

  DestR.Left:=0;
  DestR.Top:=0;

  dPX:=round((CX-FBackCX)/View.RevScale);

  SourceR.Left:=FHWidth+dPX;
  SourceR.Right:=2*FHWidth+dPX;

//-------------------------------------------------------
  dPY:=round((CY-FBackCY)/View.RevScale);

  DestR.Right:=FHWidth;
  DestR.Bottom:=FHHeight;

  SourceR.Top:=FHHeight-dPY;
  SourceR.Bottom:=2*FHHeight-dPY;

  FHCanvas.CopyRect(DestR, FHBackBitmap.Canvas, SourceR);

//-------------------------------------------------------
  dPZ:=round((CZ-FBackCZ)/View.RevScale);

  DestR.Right:=FVWidth;
  DestR.Bottom:=FVHeight;

  SourceR.Top:=FVHeight-dPZ;
  SourceR.Bottom:=2*FVHeight-dPZ;

  FVCanvas.CopyRect(DestR, FVBackBitmap.Canvas, SourceR);
end;

function TPainter.Get_CanvasSet: integer;
begin
  Result:=FCanvasSet
end;

procedure TPainter.Set_CanvasSet(Value: integer);
begin
  FCanvasSet:=Value
end;

procedure TPainter.ResizeBack(Flag:integer);
begin

  if (1 and Flag)<>0 then begin
    FHBackBitmap.Free;
    FHBackBitmap2.Free;
    FHBackBitmap:=TBitmap.Create;
    FHBackBitmap2:=TBitmap.Create;
    FHBackBitmap.Height:=FHHeight*BackCanvasFactor;
    FHBackBitmap.Width:=FHWidth*BackCanvasFactor;
    FHBackBitmap2.Height:=FHHeight*BackCanvasFactor;
    FHBackBitmap2.Width:=FHWidth*BackCanvasFactor;
  end;
  if (2 and Flag)<>0 then begin
    FVBackBitmap.Free;
    FVBackBitmap2.Free;
    FVBackBitmap:=TBitmap.Create;
    FVBackBitmap2:=TBitmap.Create;
    FVBackBitmap.Height:=FVHeight*BackCanvasFactor;
    FVBackBitmap.Width:=FVWidth*BackCanvasFactor;
    FVBackBitmap2.Height:=FVHeight*BackCanvasFactor;
    FVBackBitmap2.Width:=FVWidth*BackCanvasFactor;
  end;

  FBackLocked:=(Flag=0);
end;

procedure TPainter.FlipFrontBack;
begin
end;

procedure TPainter.Clear;
   procedure DoClear(aCanvasTag:integer; CanvasLevel:integer);
   var
     Canvas:TCanvas;
     Width, Height:integer;
     R:TRect;
     OldColor:TColor;
     OldStyle:TBrushStyle;
   begin
     if aCanvasTag=1 then begin
       case CanvasLevel of
       FrontCanvas:
         begin
           Canvas := FHCanvas;
           Width:=FHWidth;
           Height:=FHHeight
         end;
       BackCanvas:
         begin
           Canvas := FHBackBitmap.Canvas;
           Width:=BackCanvasFactor*FHWidth;
           Height:=BackCanvasFactor*FHHeight
         end;
       else // BackCanvas2
         begin
           Canvas := FHBackBitmap2.Canvas;
           Width:=BackCanvasFactor*FHWidth;
           Height:=BackCanvasFactor*FHHeight
         end;
       end;
     end else begin
       case CanvasLevel of
       FrontCanvas:
         begin
           Canvas := FVCanvas;
           Width:=FVWidth;
           Height:=FVHeight
         end;
       BackCanvas:
         begin
           Canvas := FVBackBitmap.Canvas;
           Width:=BackCanvasFactor*FVWidth;
           Height:=BackCanvasFactor*FVHeight
         end;
       else // BackCanvas2
         begin
           Canvas := FVBackBitmap2.Canvas;
           Width:=BackCanvasFactor*FVWidth;
           Height:=BackCanvasFactor*FVHeight
         end;
       end;
     end;

     R.Left:=0;
     R.Top:=0;
     R.Right:=Width;
     R.Bottom:=Height;
     OldColor:=Canvas.Brush.Color;
     OldStyle:=Canvas.Brush.Style;
     Canvas.Brush.Color:=clWhite;
     Canvas.Brush.Style:=bsSolid;
     Canvas.FillRect(R);
     Canvas.Brush.Color:=OldColor;
     Canvas.Brush.Style:=OldStyle;
   end;
begin
  if (FCanvasSet and FrontCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoClear(1, FrontCanvas);
    if (FMode=0) or (FMode=2) then
      DoClear(2, FrontCanvas);
  end;
  if (FCanvasSet and BackCanvas)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoClear(1, BackCanvas);
    if (FMode=0) or (FMode=2) then
      DoClear(2, BackCanvas);
  end;
  if (FCanvasSet and BackCanvas2)<>0 then begin
    if (FMode=0) or (FMode=1) then
      DoClear(1, BackCanvas2);
    if (FMode=0) or (FMode=2) then
      DoClear(2, BackCanvas2);
  end;
end;

procedure TPainter.SaveCenterPos;
begin
  FBackCX:=FView.CX;
  FBackCY:=FView.CY;
  FBackCZ:=FView.CZ;
end;

procedure TPainter.FlipBackCanvas;
var
  H, W:integer;
begin
  H:=FHBackBitmap.Height;
  W:=FHBackBitmap.Width;
  FHBackBitmap.Free;
  FHBackBitmap:=FHBackBitmap2;
  FHBackBitmap2:=TBitmap.Create;
  FHBackBitmap2.Height:=H;
  FHBackBitmap2.Width:=W;

  H:=FVBackBitmap.Height;
  W:=FVBackBitmap.Width;
  FVBackBitmap.Free;
  FVBackBitmap:=FVBackBitmap2;
  FVBackBitmap2:=TBitmap.Create;
  FVBackBitmap2.Height:=H;
  FVBackBitmap2.Width:=W;

  if FRedrawFlag then begin
    FRedrawFlag:=False;
    FastDraw;
  end;

  FBackCX:=FView.CX;
  FBackCY:=FView.CY;
  FBackCZ:=FView.CZ;

end;

procedure TPainter.GetTextExtent(const Text: WideString; out Width,
  Height: Double);
var
  Canvas:TCanvas;
  Size:TSize;
  RevScale:double;
  S:string;
begin
  Canvas := FHBackBitmap.Canvas;
  S:=Text;
  Size:=Canvas.TextExtent(S);
  RevScale:=FView.RevScale;
  Width:=Size.cx*RevScale;
  Height:=Size.cy*RevScale;
end;

procedure TPainter.SetFont(const FontName: WideString; FontSize, FontStyle,
  FontColor: Integer);
var
  Canvas:TCanvas;
  Style:TFontStyles;
begin
  Canvas := FHBackBitmap.Canvas;
  Canvas.Font.Name:=FontName;

  case FontSize of
  0: Canvas.Font.Size:=FontSize;
  else
     Canvas.Font.Size:=FontSize;
  end;

   Style:=[];
   if (_fsBold and FontStyle)<>0 then
     Style:=Style+[fsBold];
   if (_fsItalic and FontStyle)<>0 then
     Style:=Style+[fsItalic];
   if (_fsUnderline and FontStyle)<>0 then
     Style:=Style+[fsUnderline];
   if (_fsStrikeOut and FontStyle)<>0 then
     Style:=Style+[fsStrikeOut];
   Canvas.Font.Style:=Style;

  Canvas.Font.Color:=FontColor;
end;

procedure TPainter.UpdateFont;
var
  FontSize: Integer;
  PixelsPerInch:integer;
begin
   if FIsPrinter then
     PixelsPerInch:=DM_GetDeviceCaps(Printer.Handle, LOGPIXELSY)
   else
     PixelsPerInch:=Screen.PixelsPerInch;
  if  PixelsPerInch<> FHCanvas.Font.PixelsPerInch then
  begin
    FontSize := FHCanvas.Font.Size;
    FHCanvas.Font.PixelsPerInch := PixelsPerInch;
    FHCanvas.Font.Size := FontSize;
    FVCanvas.Font.PixelsPerInch := PixelsPerInch;
    FVCanvas.Font.Size := FontSize;
  end;
end;

function TPainter.Get_IsPrinter: WordBool;
begin
  Result:=FIsPrinter
end;

procedure TPainter.Set_IsPrinter(Value: WordBool);
begin
  FIsPrinter:=Value
end;

{ TPainterFactory }

function TPainterFactory.CreateInstance: IUnknown;
begin
  Result:=TPainter.Create(nil) as IUnknown
end;

function GetPainterClassObject:IDMClassFactory;
begin
  Result:=TPainterFactory.Create(nil) as IDMClassFactory
end;

initialization
//  CreateAutoObjectFactory(TPainter, Class_Painter);
end.
