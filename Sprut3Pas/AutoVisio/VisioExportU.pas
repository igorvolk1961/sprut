unit VisioExportU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj, DM_ActiveX,
  Types, Classes, SysUtils,
  AutoVisio_TLB, StdVcl, SpatialModelLib_Tlb, PainterLib_TLB,
  Visio_TLB, DataModel_TLB, Math, Variants, Graphics, DMServer_TLB;

const
  InfinitValue=999999;

type
 TPointF=record
   X:double;
   Y:double;
   Z:double;
 end;

 TPointArrayF=array[0..4] of TPointF;

type
  TVisioExport = class(TDM_AutoObject, IVisioExport, IPainter)
  Private
    FSpatialModel:ISpatialModel;
    FWidth:integer;
    FHeight:integer;
    FForm:integer;
    FCanvasTag:integer;
    FMode:integer;
    FK:double;
    FPageX:double;
    FPageY:double;
    FGx0:double;
    FGx1:double;
    FGy0:double;
    FGy1:double;
    FLayerIndex: integer;

    FVApplication:IVApplication;
    FVDocument:IVDocument;
    FVPage:IVPage;

    FView:IView;
    FLocalView:IView;

    FPenStyle:integer;
    FPenColor:integer;
    FPenMode:integer;
    FPenWidth:integer;
    FBrushStyle:integer;
    FBrushColor:integer;


    FXmax:double;
    FXmin:double;
    FYmax:double;
    FYmin:double;
    FZmax:double;
    FZmin:double;
    
//    FFont:TFont;

    procedure BuildLine(x0, y0, x1, y1: double);
    procedure BuildBezier(const PointArray: array of TPointF);
    procedure BuildArc(const PointArray: array of TPointF);
  protected
    function Get_SpatialModel: IUnknown; safecall;
    procedure SaveToFile(const FileName: WideString); safecall;
    procedure Set_SpatialModel(const Value: IUnknown); safecall;
    function Get_Height: Integer; safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Height(Value: Integer); safecall;
    procedure Set_Width(Value: Integer); safecall;
    function Get_Form: Integer; safecall;
    procedure Set_Form(Value: Integer); safecall;

    function Get_ViewU: IUnknown; safecall;
    procedure Set_ViewU(const Value: IUnknown); safecall;
    function Get_PenColor: Integer; safecall;
    procedure Set_PenColor(Value: Integer); safecall;
    function Get_PenMode: Integer; safecall;
    procedure Set_PenMode(Value: Integer); safecall;
    procedure Clear; safecall;
    procedure DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z, P3X, P3Y, P3Z, P4X,
      P4Y, P4Z, aAngle: Double; PictureHandle: LongWord; PictureFMT, Alpha: Integer); safecall;
    procedure DrawCurvedLine(VarPointArray: OleVariant); safecall;
    procedure DrawLine(WX0, WY0, WZ0, WX1, WY1, WZ1: Double); safecall;
    procedure DrawArc(WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, WZ2: Double); safecall;
    procedure DrawPoint(WX, WY, WZ: Double); safecall;
    procedure DrawCircle(WX: Double; WY: Double; WZ: Double; R: Double; R_In_Pixels: WordBool); safecall;
    procedure DrawPolygon(const Lines: IDMCollection; Vertical: WordBool);
      safecall;
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
    procedure DrawAxes(XP, YP, ZP:integer); safecall;
    procedure SetRangePix; safecall;
    procedure DrawRangeMarks; safecall;
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
    procedure DrawRectangle(WX0, WY0, WZ0, WX1, WY1, WZ1, Angle: Double);
      safecall;
    function Get_LocalViewU: IUnknown; safecall;
    procedure Set_LocalViewU(const Value: IUnknown); safecall;
    procedure DrawText(WX, WY, WZ: Double; const Text: WideString;
      TextSize: Double; const FontName: WideString; FontSize, FontColor,
      FontStyle, ScaleMode: Integer); safecall;  public
    function Get_LayerIndex: Integer; safecall;
    procedure Set_LayerIndex(Value: Integer); safecall;
    function Get_UseLayers: WordBool; safecall;
    procedure SetLimits; safecall;
    function  LineIsVisible(aCanvasTag:integer;
                            var X0,Y0,Z0, X1,Y1,Z1:double; FitToCanvas:WordBool;
                            CanvasLevel: integer):WordBool; safecall;
    function Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    procedure CloseBlock; safecall;
    procedure InsertBlock(const ElementU: IUnknown); safecall;
    procedure DrawTexture(const TextureName: WideString;
             var TextureNum: Integer; x0, y0, z0, x1, y1, z1, x2,
             y2, z2, x3, y3, z3, NX, NY, NZ, MX, MY: Double); safecall;
    function CheckVisiblePoint(aCanvasTag: Integer; X, Y, Z: Double): WordBool;
      safecall;
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

implementation

destructor TVisioExport.Destroy;
begin
  inherited;
  FSpatialModel:=nil;
  FVApplication:=nil;
  FVDocument:=nil;
  FVPage:=nil;
end;

function TVisioExport.Get_SpatialModel: IUnknown;
begin
    Result:=FSpatialModel as IUnknown;
end;

procedure TVisioExport.BuildLine(x0,y0,x1,y1:double);
var
  VShape:IVShape;
  LS:integer;
  VLayer:IVLayer;
begin
  if (((x0>FGx0)and(x1<FGx1))or
      ((x0<FGx1)and(x1>FGx0))) and
     (((y0>FGy0)and(y1<FGy1))or
      ((y0<FGy1)and(y1>FGy0))) then begin
    VShape:=FVPage.DrawLine(x0,y0,x1,y1);
    VLayer:=FVPage.Layers.Item[FLayerIndex+1];
    VLayer.Add(VShape,0);

    if FPenStyle=6 then
      LS:=1
    else
      LS:=FPenStyle+1;

    VShape.Cells['LinePattern'].Formula:=IntToStr(LS);
    if FPenWidth<>0 then
      VShape.Cells['LineWeight'].Formula:=Format('%0.3f pt.',[FPenWidth*0.24])
    else
      VShape.Cells['LineWeight'].Formula:=Format('%0.3f pt.',[0.12])
  end;
end;

procedure TVisioExport.SaveToFile(const FileName: WideString);
var
        k1,k2:double;
        L, j:integer;
        LayerE:IDMElement;
        Layer:ILayer;
        VLayer:IVLayer;
        aRed, aGreen, aBlue:integer;
        OldDecimalSeparator:char;
        DMDocument:IDMDocument;
        aElement:IDMElement;
        aPainter:IPainter;
        Unk:IUnknown;
begin
        OldDecimalSeparator:=DecimalSeparator;
        DecimalSeparator:=',';
        aPainter:=Self as IPainter;
//        FVApplication:=CreateComObject(CLASS_VisioApplication) as IVApplication;
        FVApplication:=DM_CreateOleObject('Visio.InvisibleApp') as IVApplication;
        FVDocument:=FVApplication.Documents.Add('');
        FVPage:=FVDocument.Pages.Item[1];
        try

        (FSpatialModel as ISpatialModel2).CalcLimits;

        FPageX:=FVPage.PageSheet.Cells['PageWidth'].ResultIU;
        FPageY:=FVPage.PageSheet.Cells['PageHeight'].ResultIU;

//          RS:=FView.RevScale;

          K1:=FPageX/(fWidth);
          K2:=FPageY/(fHeight);
          if k1>k2 then
            FK:=k2
          else
            FK:=k1;

          FGx0:=FPageX/2-FK*fWidth/2;
          FGx1:=FPageX/2+FK*fWidth/2;
          FGy0:=FPageY/2-FK*fHeight/2;
          FGy1:=FPageY/2+FK*fHeight/2;
{
                FVPage.DrawLine(FGx0,FGy0,FGx1,FGy0);
                FVPage.DrawLine(FGx0,FGy1,FGx1,FGy1);
                FVPage.DrawLine(FGx0,FGy0,FGx0,FGy1);
                FVPage.DrawLine(FGx1,FGy0,FGx1,FGy1);
}

//Определение границ MaxY - MinY
{            if FForm=0 then begin
                    Zmin:=FView.Zmin;
                    Zmax:=FView.Zmax;
            end
            else begin
                    Zmin:=FView.Dmin;
                    Zmax:=FView.Dmax;
            end;
}
//Создание СЛОЕВ

        for L:=0 to FSpatialModel.Layers.Count-1 do begin
          LayerE:=FSpatialModel.Layers.Item[L];
          Layer:=LayerE as ILayer;
          VLayer:=FVPage.Layers.Add(LayerE.Name);

          aRed:=Layer.Color and $0000FF;
          aGreen:=(Layer.Color and $00FF00) div 256;
          aBlue:=(Layer.Color and $FF0000) div 65536;

          VLayer.CellsC[visLayerVisible].ResultIU:=Ord(Layer.Visible);
          VLayer.CellsC[visLayerPrint].ResultIU:=Ord(Layer.Visible);
          VLayer.CellsC[visLayerLock].ResultIU:=Ord(not Layer.Selectable);
          VLayer.CellsC[visLayerColor].Formula:=Format('RGB(%d;%d;%d)',[aRed, aGreen, aBlue]);
        end;

        for j:=0 to (FSpatialModel as ISpatialModel).ImageRects.Count-1 do begin
          aElement:=(FSpatialModel as ISpatialModel).ImageRects.Item[j];
          if aElement.Selected then
            aElement.Draw(aPainter, 1);
        end;

        (FSpatialModel as IDMElement).Draw(aPainter, 0);
        DMDocument:=(FSpatialModel as IDataModel).Document as IDMDocument;

        for j:=0 to DMDocument.SelectionCount-1 do begin
          aElement:=DMDocument.SelectionItem[j] as IDMElement;
          if aElement.QueryInterface(IImageRect, Unk)<>0 then begin
            if (aElement.Ref<>nil) and
               (aElement.Ref.SpatialElement=aElement) then
              aElement.Ref.Draw(aPainter, 1)
            else
              aElement.Draw(aPainter, 1);
          end;
        end;

        FVDocument.SaveAs(FileName);
        FVApplication.Quit;
        DecimalSeparator:=OldDecimalSeparator;

        finally
          FVDocument:=nil;
          FVApplication:=nil;
          FVPage:=nil;
        end;
end;

procedure TVisioExport.Set_SpatialModel(const Value: IUnknown);
begin
    FSpatialModel:=Value as ISpatialModel;
end;

function TVisioExport.Get_Height: Integer;
begin
  Result:=FHeight
end;

function TVisioExport.Get_Width: Integer;
begin
  Result:=FWidth;
end;

procedure TVisioExport.Set_Height(Value: Integer);
begin
  FHeight:=Value
end;

procedure TVisioExport.Set_Width(Value: Integer);
begin
  FWidth:=Value;
end;

function TVisioExport.Get_Form: Integer;
begin
  Result:=FForm;
end;

procedure TVisioExport.Set_Form(Value: Integer);
begin
  FForm:=Value;
  FCanvasTag:=Value+1;
end;

function TVisioExport.Get_ViewU: IUnknown;
begin
  Result:=FView
end;

procedure TVisioExport.Set_ViewU(const Value: IUnknown);
begin
  FView:=Value as IView
end;

function TVisioExport.Get_PenColor: Integer;
begin
  Result:=FPenColor
end;

procedure TVisioExport.Set_PenColor(Value: Integer);
begin
  FPenColor:=Value
end;

function TVisioExport.Get_PenMode: Integer;
begin
  Result:=FPenMode
end;

procedure TVisioExport.Set_PenMode(Value: Integer);
begin
  FPenMode:=Value
end;

type
  TPointsArray3=array [0..2,0..1] of double;

procedure TVisioExport.DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z, P3X, P3Y, P3Z,
  P4X, P4Y, P4Z, aAngle: Double; PictureHandle: LongWord; PictureFMT, Alpha: Integer);
  procedure OutDrawBitMap(dAngle,
            X0,Y0,Z0,X1,Y1,Z1,X3,Y3,Z3,X4,Y4,Z4,
            XC,YC,ZC:double; P0X, P0Y, P0Z, P1X, P1Y, P1Z:double;
            Graphic:TGraphic; aAngle:double);
  var
    P00X, P00Y, P00Z,
    P10X, P10Y, P10Z,
    P01X, P01Y, P01Z,
    P11X, P11Y, P11Z,
    Xmax, Xmin, Ymax, Ymin:double;
    Rect:TRect;
    PointsArray3:TPointsArray3;
    iRes:integer;
    bRes:LongBool;
  begin
     with FView do begin
      P00X:=FPageX/2+
          FK*((X0-XC)*cosZ-
           (Y0-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
       1:P00Y:=FPageY/2+
            FK*((X0-XC)*sinZ+
             (Y0-YC)*cosZ)/RevScaleY;
      else
       P00Y:=FPageY/2+
        FK*(Z0-ZC)/RevScaleY;
      end;

      P10X:=FPageX/2+
         FK*((X1-XC)*cosZ
         -(Y1-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
       1:P10Y:=FPageY/2+
            FK*((X1-XC)*sinZ
            +(Y1-YC)*cosZ)/RevScaleY;
      else
       P10Y:=FPageY/2+
        FK*(Z1-ZC)/RevScaleY;
      end;
      P01X:=FPageX/2.+
          FK*((X3-XC)*cosZ-
           (Y3-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
       1: P01Y:=FPageY/2+
            FK*((X3-XC)*sinZ+
             (Y3-YC)*cosZ)/RevScaleX;
      else
       P01Y:=FPageY/2+
        FK*(Z3-ZC)/RevScaleY;
      end;
       P11X:=FPageX/2+
         FK*((X4-XC)*cosZ
         -(Y4-YC)*sinZ)/RevScaleY;
      case FCanvasTag of
       1: P11Y:=FPageY/2+
            FK*((X4-XC)*sinZ+
             (Y4-YC)*cosZ)/RevScaleY;
      else
       P11Y:=FPageY/2+
        FK*(Z4-ZC)/RevScaleY;
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
//        StretchDraw(Rect, Graphic)    ??????????????????????????
      end else
      if Graphic is TBitmap then begin
         PointsArray3[0][0]:=FPageX/2+
              FK*((P0X-XC)*cosZ-
               (P0Y-YC)*sinZ)/RevScaleX;
         PointsArray3[0][1]:=FPageY/2+
              FK*((P0X-XC)*sinZ+
               (P0Y-YC)*cosZ)/RevScaleY;

         PointsArray3[1][0]:=FPageX/2+
              FK*((P3X-XC)*cosZ-
               (P3Y-YC)*sinZ)/RevScaleX;
         PointsArray3[1][1]:=FPageY/2+
              FK*((P3X-XC)*sinZ+
               (P3Y-YC)*cosZ)/RevScaleY;

         PointsArray3[2][0]:=FPageX/2+
              FK*((P4X-XC)*cosZ-
               (P4Y-YC)*sinZ)/RevScaleX;
         PointsArray3[2][1]:=FPageY/2+
              FK*((P4X-XC)*sinZ+
               (P4Y-YC)*cosZ)/RevScaleY;
{ ???????????????????????????????????????????????????????
         iRes:=SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
         if iRes=0 then
          GDIError;
         bRes:=PlgBlt(Canvas.Handle, PointsArray3,
            (Graphic as TBitmap).Canvas.Handle, 0, 0,
            (Graphic as TBitmap).Width,
            (Graphic as TBitmap).Height,
            0, 0, 0);
         if not bRes then
          GDIError;
}
      end;
    end;
  end;


var
  dAngle:double;
  X0, Y0, Z0, X1, Y1, Z1,X3, Y3, Z3, X4, Y4, Z4, XC, YC, ZC, RX, RY, RZ,
  XT, YT, ZT:double;
begin
{       ???????????????????????????????????????
  if FGraphic=nil then
  if PictureFMT=cf_BITMAP then
    FGraphic:=TBitMap.Create
  else
  if PictureFMT=cf_JPEG then
    FGraphic:=TJPEGImage.Create;
  FGraphic.LoadFromClipboardFormat(cf_BitMap, PictureHandle, 0);
}
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
    XT:=P0X*RX*FLocalView.cosT-P0Z*RZ*FLocalView.sinT;
    YT:=P0Y*RY;
    ZT:=P0X*RX*FLocalView.sinT+P0Z*RZ*FLocalView.cosT;
    X0:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y0:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;

    XT:=P1X*RX*FLocalView.cosT-P1Z*RZ*FLocalView.sinT;
    YT:=P1Y*RY;
    ZT:=P1X*RX*FLocalView.sinT+P1Z*RZ*FLocalView.cosT;
    X1:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y1:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z1:=ZT+FLocalView.CZ;

    XT:=P3X*RX*FLocalView.cosT-P3Z*RZ*FLocalView.sinT;
    YT:=P3Y*RY;
    ZT:=P3X*RX*FLocalView.sinT+P3Z*RZ*FLocalView.cosT;
    X3:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y3:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z3:=ZT+FLocalView.CZ;

    XT:=P4X*RX*FLocalView.cosT-P4Z*RZ*FLocalView.sinT;
    YT:=P4Y*RY;
    ZT:=P4X*RX*FLocalView.sinT+P4Z*RZ*FLocalView.cosT;
    X4:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y4:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z4:=ZT*RZ+FLocalView.CZ;
  end;

//  XC:=FView.CX;
//  YC:=FView.CY;
  ZC:=FView.CZ;

//  OutDrawBitMap(dAngle, X0,Y0,Z0,X1,Y1,Z1,X3,Y3,Z3,X4,Y4,Z4,
//           XC,YC,ZC, P0X,P0Y,P0Z,P1X,P1Y,P1Z,FGraphic, aAngle);

end;


procedure TVisioExport.DrawCurvedLine(VarPointArray: OleVariant);
 procedure OutDrawCurvedLine(VarPointArray: OleVariant);
 var
   j, N:integer;
   XX, YY, ZZ, XC, YC, ZC, RX, RY, RZ, X, Y, Z, XT, YT, ZT:double;
   VarPointArrayCount:integer;
   P:TPointF;
   PointArrayF:TPointArrayF;
 begin
   XC:=FView.CX;
   YC:=FView.CY;
   ZC:=FView.CZ;

   VarPointArrayCount:=VarArrayHighBound(VarPointArray, 1)+1;
   N:=VarPointArrayCount div 3;
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

      XT:=X*RX*FLocalView.cosT-Z*RZ*FLocalView.sinT;
      YT:=Y*RY;
      ZT:=X*RX*FLocalView.sinT+Z*RZ*FLocalView.cosT;

      XX:=(XT*FLocalView.cosZ-
           YT*FLocalView.sinZ)+FLocalView.CX;
      YY:=(XT*FLocalView.sinZ+
           YT*FLocalView.cosZ)+FLocalView.CY;
      ZZ:=ZT+FLocalView.CZ;
     end;
     with FView do begin
      P.X:=FPageX/2+
            FK*((XX-XC)*cosZ-
             (YY-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
      1:
      P.Y:=FPageY/2+
              FK*((XX-XC)*sinZ+
               (YY-YC)*cosZ)/RevScaleY;

      else
        P.Y:=FPageY/2+
          FK*(ZZ-ZC)/RevScaleY;
      end;

     end;
     if not CheckVisiblePoint(1, XX,YY,ZZ) then Exit;
     PointArrayF[j]:=P;
   end;
   BuildBezier(Slice(PointArrayF, N));
 end;
begin
  try
   if (FMode=0) or (FCanvasTag=FMode) then
     OutDrawCurvedLine(VarPointArray);
  except
    raise
  end;   
end;

procedure TVisioExport.DrawLine(WX0, WY0, WZ0, WX1, WY1, WZ1: Double);
var
  X0, Y0, Z0, X1, Y1, Z1, XC, YC, ZC, RX, RY, RZ:double;
   procedure OutDrawLine;
   var
    SX0, SY0, SX1, SY1:double;
 begin
   try
   if (not CheckVisiblePoint(1, X0,Y0,Z0)) then Exit;
   if (not CheckVisiblePoint(1, X1,Y1,Z1)) then Exit;
     with FView do begin
      SX0:=FPageX/2+
          FK*((X0-XC)*cosZ-
           (Y0-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
       1: SY0:=FPageY/2+
            FK*((X0-XC)*sinZ+
             (Y0-YC)*cosZ)/RevScaleY;
      else SY0:=FPageY/2+
            FK*(Z0-ZC)/RevScaleY;
      end;
       SX1:=FPageX/2+
         FK*((X1-XC)*cosZ
         -(Y1-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
       1:SY1:=FPageY/2+
            FK*((X1-XC)*sinZ
            +(Y1-YC)*cosZ)/RevScaleY;
      else
       SY1:=FPageY/2+
        FK*(Z1-ZC)/RevScaleY;
       end;
     end;

     if (abs(SX1-SX0)<>0) or
        (abs(SY1-SY0)<>0) then
       BuildLine(SX0, SY0, SX1, SY1);
  except
    raise
  end
 end;
//____________________
var
  XT, YT, ZT:double;
begin
  try
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

    XT:=WX0*RX*FLocalView.cosT-WZ0*RZ*FLocalView.sinT;
    YT:=WY0*RY;
    ZT:=WX0*RX*FLocalView.sinT+WZ0*RZ*FLocalView.cosT;

    X0:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y0:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;

    XT:=WX1*RX*FLocalView.cosT-WZ1*RZ*FLocalView.sinT;
    YT:=WY1*RY;
    ZT:=WX1*RX*FLocalView.sinT+WZ1*RZ*FLocalView.cosT;

    X1:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y1:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z1:=ZT+FLocalView.CZ;
  end;

  XC:=FView.CX;
  YC:=FView.CY;
  ZC:=FView.CZ;

  if (FMode=0) or (FCanvasTag=FMode) then
    OutDrawLine;
  except
    raise
  end;  
end;

procedure TVisioExport.DrawPoint(WX, WY, WZ: Double);
var
 X0, Y0, Z0, RX, RY, RZ:double;

 procedure OutDrawPoint;
 var
  SX, SY, SZ:double;
 begin
  if not CheckVisiblePoint(1, X0,Y0,Z0) then Exit;

   with FView do begin
     SX:=FPageX/2+
          FK*((X0-CX)*cosZ
          -(Y0-CY)*sinZ)/RevScaleX;
    If FCanvasTag=1 then begin
     SY:=FPageY/2+
         FK*((X0-CX)*sinZ
            +(Y0-CY)*cosZ)/RevScaleY;
//     Ellipse(SX-2, SY-2, SX+2, SY+2); ????????????????????????
    end
    else begin
     SZ:=FPageY/2+
        FK*(Z0-CZ)/RevScaleY;
//     Ellipse(SX-2, SZ-2, SX+2, SZ+2);  ??????????????????????
    end;
   end;
 end;

var
  XT, YT, ZT:double;
begin
  if FLocalView=nil then begin
    X0:=WX;
    Y0:=WY;
    Z0:=WZ;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;
    XT:=WX*RX*FLocalView.cosT-WZ*RZ*FLocalView.sinT;
    YT:=WY*RY;
    ZT:=WX*RX*FLocalView.sinT+WZ*RZ*FLocalView.cosT;
    X0:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y0:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;
  end;
  if (FMode=0) or (FCanvasTag=FMode) then
    OutDrawPoint;
end;

procedure TVisioExport.DrawPolygon(const Lines: IDMCollection;
  Vertical: WordBool);
var
  j, CanvasTag, OldColor, OldStyle:integer;
  C:ICoordNode;
  Points:array of TPointF;
  Line, NLine:ILine;
  Q, MinX, MaxX, MinY, MaxY, X, Y, Z, RX, RY, RZ,
  XT, YT, ZT:double;
begin
  if not Vertical then begin
    CanvasTag:=1;
  end else begin
    CanvasTag:=2;
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
  end else begin
    RX:=1;
    RY:=1;
    RZ:=1;
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
      XT:=C.X*RX*FLocalView.cosT-C.Z*RZ*FLocalView.sinT;
      YT:=C.Y*RY;
      ZT:=C.X*RX*FLocalView.sinT+C.Z*RZ*FLocalView.cosT;
      X:=(XT*FLocalView.cosZ-
          YT*FLocalView.sinZ)+FLocalView.CX;
      Y:=(XT*FLocalView.sinZ+
          YT*FLocalView.cosZ)+FLocalView.CY;
      Z:=ZT+FLocalView.CZ;
    end;
    if not CheckVisiblePoint(1, X,Y,Z) then Exit;
    Q:=FPageX/2+
               FK*((X-FView.CX)*FView.CosZ-
                (Y-FView.CY)*FView.SinZ)/FView.RevScaleX;
    Points[j].X:=Q;
    case CanvasTag of
    1:begin
        Q:=FPageY/2+
               FK*((X-FView.CX)*FView.SinZ+
                (Y-FView.CY)*FView.CosZ)/FView.RevScaleY;
        Points[j].Y:=Q;
      end
    else
      begin
        Q:=FPageY/2+
              FK*(Z-FView.CZ)/FView.RevScaleY;
        Points[j].Y:=Q;
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
//  Polygon(Points); ???????????????????????
end;

function TVisioExport.Get_PenStyle: Integer;
begin
  Result:=FPenStyle
end;

procedure TVisioExport.Set_PenStyle(Value: Integer);
begin
  FPenStyle:=Value
end;

function TVisioExport.Get_PenWidth: Double;
begin
  Result:=FPenWidth
end;

procedure TVisioExport.Set_PenWidth(Value: Double);
begin
  FPenWidth:=round(Value)
end;

function TVisioExport.Get_BrushColor: Integer;
begin
  Result:=FBrushColor
end;

procedure TVisioExport.Set_BrushColor(Value: Integer);
begin
  FBrushColor:=Value
end;

function TVisioExport.Get_BrushStyle: Integer;
begin
  Result:=FBrushStyle
end;

procedure TVisioExport.Set_BrushStyle(Value: Integer);
begin
  FBrushStyle:=Value
end;

function TVisioExport.CheckVisiblePoint(aCanvasTag:integer; X, Y,  Z: double): WordBool;
var
  D0:double;
begin
  Result:=False;
  with FView do
  case FCanvasTag of
   1:if FLocalView=nil then
      Result:=(Z>=Zmin)and(Z<=Zmax)
     else
      Result:=(FLocalView.CZ>=Zmin)and(FLocalView.CZ<=Zmax);
   2: begin D0:=Y*cosZ+X*sinZ;
      Result:=(D0>=Dmin)and(D0<=Dmax) end;
  end;
end;

function TVisioExport.Get_HHeight: Integer;
begin
  Result:=FHeight
end;

function TVisioExport.Get_HWidth: Integer;
begin
  Result:=FWidth
end;

function TVisioExport.Get_VWidth: Integer;
begin
  Result:=FWidth
end;

procedure TVisioExport.Set_HHeight(Value: Integer);
begin
  FHeight:=Value
end;

procedure TVisioExport.Set_HWidth(Value: Integer);
begin
  FWidth:=Value
end;

procedure TVisioExport.Set_VWidth(Value: Integer);
begin
  FWidth:=Value
end;

procedure TVisioExport.DrawAxes(XP, YP, ZP:integer);
begin
end;

procedure TVisioExport.SetRangePix;
begin
end;

function TVisioExport.Get_VHeight: Integer;
begin
  Result:=FHeight
end;

procedure TVisioExport.Set_VHeight(Value: Integer);
begin
  FHeight:=Value
end;

procedure TVisioExport.DrawRangeMarks;
begin
end;

function TVisioExport.Get_DmaxPix: Integer;
begin
  Result:=0
end;

function TVisioExport.Get_DminPix: Integer;
begin
  Result:=0
end;

function TVisioExport.Get_ZmaxPix: Integer;
begin
  Result:=0
end;

function TVisioExport.Get_ZminPix: Integer;
begin
  Result:=0
end;

procedure TVisioExport.Set_DmaxPix(Value: Integer);
begin
end;

procedure TVisioExport.Set_DminPix(Value: Integer);
begin
end;

procedure TVisioExport.Set_ZmaxPix(Value: Integer);
begin
end;

procedure TVisioExport.Set_ZminPix(Value: Integer);
begin
end;

function TVisioExport.Get_HCanvasHandle: Integer;
begin
  Result:=0
end;

function TVisioExport.Get_VCanvasHandle: Integer;
begin
  Result:=0
end;

procedure TVisioExport.Set_HCanvasHandle(Value: Integer);
begin
end;

procedure TVisioExport.Set_VCanvasHandle(Value: Integer);
begin
end;

procedure TVisioExport.Initialize;
begin
  inherited;
  FPenMode:=ord(pmCopy);
  FPenStyle:=ord(psSolid);
end;

procedure TVisioExport.DragLine(PX0, PY0, PZ0, PX1, PY1, PZ1: Integer);
begin
end;

procedure TVisioExport.DragRect(PX0, PY0, PZ0, PX1, PY1, PZ1: Integer);
begin
end;

procedure TVisioExport.WP_To_P(WX, WY, WZ:double;
                       out PX, PY, PZ:integer);
begin
end;


procedure TVisioExport.P_To_WP(PX, PY, Tag: Integer; out WX, WY, WZ: Double);
begin
end;

procedure TVisioExport.DragCurvedLine(VarPointArray: OleVariant);
begin
end;

procedure TVisioExport.DrawRectangle(WX0, WY0, WZ0, WX1, WY1, WZ1,
  Angle: Double);
begin
end;

function TVisioExport.Get_LocalViewU: IUnknown;
begin
  Result:=FLocalView
end;

procedure TVisioExport.Set_LocalViewU(const Value: IUnknown);
begin
  FLocalView:=Value as IView
end;

procedure TVisioExport.DrawText(WX, WY, WZ: Double; const Text: WideString;
  TextSize: Double; const FontName: WideString; FontSize, FontColor,
  FontStyle, ScaleMode: Integer);
var
 X0, Y0, Z0, RX, RY, RZ:double;

 procedure OutDrawText;
 var
  SX, SY, SZ:double;
  Style:TFontStyles;
  VShape:IVShape;
  VLayer:IVLayer;
  VCharacters:IVCharacters;
  H, W:double;
 begin
  if not CheckVisiblePoint(1, X0,Y0,Z0) then Exit;

   Style:=[];
   if (_fsBold and FontStyle)<>0 then
     Style:=Style+[fsBold];
   if (_fsItalic and FontStyle)<>0 then
     Style:=Style+[fsItalic];
   if (_fsUnderline and FontStyle)<>0 then
     Style:=Style+[fsUnderline];
   if (_fsStrikeOut and FontStyle)<>0 then
     Style:=Style+[fsStrikeOut];

   H:=FK*TextSize/FView.RevScaleX;
   W:=H*Length(Text);

   with FView do begin
     SX:=FPageX/2+
          FK*((X0-CX)*cosZ
          -(Y0-CY)*sinZ)/RevScaleX;
    If FCanvasTag=1 then begin
      SY:=FPageY/2+
         FK*((X0-CX)*sinZ
            +(Y0-CY)*cosZ)/RevScaleY;
      VShape:=FVPage.DrawRectangle(SX,SY,SX+W,SY-H);

    end
    else begin
      SZ:=FPageY/2+
        FK*(Z0-CZ)/RevScaleY;
      VShape:=FVPage.DrawRectangle(SX,SZ,SX+W,SZ-H);
    end;
    VShape.Text:=Text;
    VLayer:=FVPage.Layers.Item[FLayerIndex+1];
    VLayer.Add(VShape,0);
    VShape.Cells['LinePattern'].Formula:='0';
    VShape.CellsSRC[visSectionParagraph, visRowParagraph, visHorzAlign].Formula:='0';
   end;
 end;
var
  XT, YT, ZT:double;
begin
  try
  if FLocalView=nil then begin
    X0:=WX;
    Y0:=WY;
    Z0:=WZ;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;
    XT:=WX*RX*FLocalView.cosT-WZ*RZ*FLocalView.sinT;
    YT:=WY*RY;
    ZT:=WX*RX*FLocalView.sinT+WZ*RZ*FLocalView.cosT;
    X0:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y0:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;
  end;
  if (FMode=0) or (FCanvasTag=FMode) then
    OutDrawText;
  except
    raise
  end;  
end;

procedure TVisioExport.BuildBezier(const PointArray: array of TPointF);
var
  VShape:IVShape;
  xyArray: PDM_SafeArray;
  VarBound: TVarArrayBound;
  VLayer:IVLayer;

  xyArrayV:Variant;

  LS:integer;
  degree, Flags: Smallint;
  j:integer;
  x0, y0, x1, y1:double;
  ix:array[0..0] of integer;
begin
  x0:=PointArray[0].X;
  y0:=PointArray[0].Y;
  x1:=PointArray[3].X;
  y1:=PointArray[3].Y;
  if (((x0>FGx0)and(x1<FGx1))or
      ((x0<FGx1)and(x1>FGx0))) and
     (((y0>FGy0)and(y1<FGy1))or
      ((y0<FGy1)and(y1>FGy0))) then begin

    VarBound.LowBound:=1;
    VarBound.ElementCount := 8;

    degree:=3;
    Flags:=0;

    xyArray:=DM_SafeArrayCreate(VT_R8, 1, VarBound);
//      xyArrayV:=VarArrayCreate([1,8], VT_R8)
    try

    for j:=0 to 3 do begin

      ix[0]:=j*2+1;
      DM_SafeArrayPutElement(xyArray,  ix, PointArray[j].X);
      ix[0]:=j*2+2;
      DM_SafeArrayPutElement(xyArray,  ix, PointArray[j].Y);

    end;
    VShape:=FVPage.DrawBezier(xyArray, degree, Flags);
    VLayer:=FVPage.Layers.Item[FLayerIndex+1];
    VLayer.Add(VShape,0);

    finally
      DM_SafeArrayDestroy(xyArray);
    end;

    if FPenStyle=6 then
      LS:=1
    else
      LS:=FPenStyle+1;

    VShape.Cells['LinePattern'].Formula:=IntToStr(LS);
    if FPenWidth<>0 then
      VShape.Cells['LineWeight'].Formula:=Format('%0.3f pt.',[FPenWidth*0.24]);
  end;
end;

function TVisioExport.Get_LayerIndex: Integer;
begin
  Result:=FLayerIndex
end;

procedure TVisioExport.Set_LayerIndex(Value: Integer);
begin
  FLayerIndex:=Value
end;

function TVisioExport.Get_UseLayers: WordBool;
begin
  Result:=True
end;

procedure TVisioExport.DrawArc(WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2,
  WZ2: Double);
 {WX0,WY0,WZ0 -центр окружн., WX1,WY1,WZ1 -центральн.точка дуги на окружн.,
  WX0, WY0, WZ0 - WX2, WY2, WZ2 -направл.на котором лежит 1-я точка дуги,
  2-я точка дуги вычисл.симетрично относит.центр.}
var
 xC,yC,zC:Double;
 R,dX1,dY1,NewX2,NewY2,cos,sin:double;
 NewX3,NewY3,x1,y1,z1,x2,y2,z2,x3,y3,z3:double;
 XT, YT, ZT:double;
 RX, RY, RZ:double;
//___________
   procedure OutDrawArc;
   var
    Canvas:TCanvas;
    N:integer;
    P:TPointF;
    PointArrayF:TPointArrayF;
   begin
   if (not CheckVisiblePoint(1, X2,Y2,Z2)) then Exit;
   if (not CheckVisiblePoint(1, X3,Y3,Z3)) then Exit;
     with FView do begin
      P.X:=FPageX/2+
              FK*((X1-XC)*cosZ-(Y1-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
      1:P.Y:=FPageY/2+
              FK*((X1-XC)*sinZ+(Y1-YC)*cosZ)/RevScaleY;
      else
        P.Y:=FPageY/2+FK*(Z1-ZC)/RevScaleY;
      end;
      PointArrayF[1]:=P;

      P.X:=FPageX/2+
            FK*((X2-XC)*cosZ-(Y2-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
      1:P.Y:=FPageY/2+
              FK*((X2-XC)*sinZ+(Y2-YC)*cosZ)/RevScaleY;
      else
        P.Y:=FPageY/2+FK*(Z2-ZC)/RevScaleY;
      end;
      PointArrayF[0]:=P;

      P.X:=FPageX/2+
            FK*((X3-XC)*cosZ-(Y3-YC)*sinZ)/RevScaleX;
      case FCanvasTag of
      1:P.Y:=FPageY/2+
             FK*((X3-XC)*sinZ+(Y3-YC)*cosZ)/RevScaleY;
      else
        P.Y:=FPageY/2+
             FK*(Z3-ZC)/RevScaleY;
      end;
      PointArrayF[2]:=P;
     end;

     N:=3;
     BuildArc(Slice(PointArrayF, N));

   end;
//____________________
begin
 dX1:=WX1-WX0;
 dY1:=WY1-WY0;
 R:=sqrt(sqr(dX1) + sqr(dY1));
 cos:=FView.CosZ;
 sin:=FView.SinZ;

 x1:=WX1;   //вершина дуги
 y1:=WY1;
 z1:=WZ1;

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

    XT:=x1*RX*FLocalView.cosT-z1*RZ*FLocalView.sinT;
    YT:=y1*RY;
    ZT:=x1*RX*FLocalView.sinT+z1*RZ*FLocalView.cosT;

    x1:=(XT*FLocalView.cosZ-YT*FLocalView.sinZ)+FLocalView.CX;
    y1:=(XT*FLocalView.sinZ+YT*FLocalView.cosZ)+FLocalView.CY;
    z1:=ZT+FLocalView.CZ;

    XT:=x2*RX*FLocalView.cosT-z2*RZ*FLocalView.sinT;
    YT:=y2*RY;
    ZT:=x2*RX*FLocalView.sinT+z2*RZ*FLocalView.cosT;

    x2:=(XT*FLocalView.cosZ-YT*FLocalView.sinZ)+FLocalView.CX;
    y2:=(XT*FLocalView.sinZ+YT*FLocalView.cosZ)+FLocalView.CY;
    z2:=ZT+FLocalView.CZ;

    XT:=x3*RX*FLocalView.cosT-z3*RZ*FLocalView.sinT;
    YT:=y3*RY;
    ZT:=x3*RX*FLocalView.sinT+z3*RZ*FLocalView.cosT;

    x3:=(XT*FLocalView.cosZ-YT*FLocalView.sinZ)+FLocalView.CX;
    y3:=(XT*FLocalView.sinZ+YT*FLocalView.cosZ)+FLocalView.CY;
    z3:=ZT+FLocalView.CZ;
  end;

  XC:=FView.CX;
  YC:=FView.CY;
  ZC:=FView.CZ;

  try
    if (FMode=0) or (FCanvasTag=FMode) then
      OutDrawArc;
  except
    raise
  end
end;

procedure TVisioExport.BuildArc(const PointArray: array of TPointF);
var
  VShape:IVShape;
  LS:integer;
  VLayer:IVLayer;

  xyArray: PDM_SafeArray;
  VarBound: TVarArrayBound;

  xyArrayV:Variant;

  tolerance, Flags: Smallint;
  j:integer;
  x0, y0, x1, y1:double;
  ix:array[0..0] of integer;
begin
  x0:=PointArray[0].X;
  y0:=PointArray[0].Y;
  x1:=PointArray[2].X;
  y1:=PointArray[2].Y;
  if (((x0>FGx0)and(x1<FGx1))or
      ((x0<FGx1)and(x1>FGx0))) and
     (((y0>FGy0)and(y1<FGy1))or
      ((y0<FGy1)and(y1>FGy0))) then begin

    VarBound.LowBound:=1;
    VarBound.ElementCount := 6;

    tolerance:=0;
    Flags:=visSplineDoCircles;

    xyArray:=DM_SafeArrayCreate(VT_R8, 1, VarBound);
    try

    for j:=0 to 2 do begin

      ix[0]:=j*2+1;
      DM_SafeArrayPutElement(xyArray,  ix, PointArray[j].X);
      ix[0]:=j*2+2;
      DM_SafeArrayPutElement(xyArray,  ix, PointArray[j].Y);

    end;
    VShape:=FVPage.DrawSpline(xyArray, tolerance, Flags);
    VLayer:=FVPage.Layers.Item[FLayerIndex+1];
    VLayer.Add(VShape,0);

    finally
      DM_SafeArrayDestroy(xyArray);
    end;

    if FPenStyle=6 then
      LS:=1
    else
      LS:=FPenStyle+1;

    VShape.Cells['LinePattern'].Formula:=IntToStr(LS);
    if FPenWidth<>0 then
      VShape.Cells['LineWeight'].Formula:=Format('%0.3f pt.',[FPenWidth*0.24]);
  end;
end;

procedure TVisioExport.SetLimits;
begin
end;

function TVisioExport.LineIsVisible(aCanvasTag: integer;
  var X0, Y0, Z0, X1, Y1, Z1: double; FitToCanvas:WordBool;
  CanvasLevel: integer): WordBool;
begin
  Result:=True
end;

function TVisioExport.Get_Mode: Integer;
begin
  Result:=FMode
end;

procedure TVisioExport.Set_Mode(Value: Integer);
begin
  FMode:=Value
end;

procedure TVisioExport.DrawCircle(WX, WY, WZ, R: Double;
  R_In_Pixels: WordBool);
begin

end;

procedure TVisioExport.CloseBlock;
begin
end;

procedure TVisioExport.InsertBlock(const ElementU: IInterface);
begin
end;

procedure TVisioExport.DrawTexture(const TextureName: WideString;
                             var TextureNum: Integer; x0, y0, z0, x1, y1, z1, x2,
                             y2, z2, x3, y3, z3, NX, NY, NZ, MX, MY: Double);
begin
end;

procedure TVisioExport.Clear;
begin
end;

procedure TVisioExport.GetTextExtent(const Text: WideString; out Width,
  Height: Double);
begin
end;

procedure TVisioExport.SetFont(const FontName: WideString; FontSize,
  FontStyle, FontColor: Integer);
begin
end;

function TVisioExport.Get_IsPrinter: WordBool;
begin
  Result:=False
end;

procedure TVisioExport.Set_IsPrinter(Value: WordBool);
begin
end;

initialization
  CreateAutoObjectFactory(TVisioExport, Class_VisioExport);
end.
