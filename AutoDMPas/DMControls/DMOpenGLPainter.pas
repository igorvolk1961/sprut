unit DMOpenGLPainter;

interface
uses
  Windows,
  DM_Windows, DM_Messages,
  Classes, SysUtils, Graphics, Forms, ExtCtrls, OpenGL,
  DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB, DMServer_TLB, Textures;

type
  TOpenGLPainter=class(TPanel, IPainter)
  private
    FViewHolder:IPainter;
    FSpatialModel:ISpatialModel;
    FLayerRefTypes: IDMCollection;
    FDC : HDC;
    Fhrc: HGLRC;
    FOpenGLInited:boolean;
    FR, FG, FB:integer;


    FPenWidth:double;
    FFrameMode: boolean;
//    FTextureNum:GLUint;
    procedure DrawObjects;
    procedure SetFrameMode(const Value: boolean);
  protected
    procedure Paint; override;
    procedure Resize; override;

    function Get_ViewU: IUnknown; safecall;
    procedure Set_ViewU(const Value: IUnknown); safecall;
    function Get_PenColor: Integer; safecall;
    procedure Set_PenColor(Value: Integer); safecall;
    function Get_PenMode: Integer; safecall;
    procedure Set_PenMode(Value: Integer); safecall;
    procedure Clear; safecall;
    procedure DrawPoint(WX: Double; WY: Double; WZ: Double); safecall;
    procedure DrawLine(WX0: Double; WY0: Double; WZ0: Double; WX1: Double; WY1: Double; WZ1: Double); safecall;
    procedure DrawCurvedLine(PointArray: OleVariant); safecall;
    procedure DrawPolygon(const Lines: IDMCollection; Vertical: WordBool); safecall;
    procedure DrawPicture(P0X: Double; P0Y: Double; P0Z: Double; P1X: Double; P1Y: Double;
                          P1Z: Double; P3X: Double; P3Y: Double; P3Z: Double; P4X: Double;
                          P4Y: Double; P4Z: Double; aAngle: Double; BMPHandle: LongWord; FMT, Alpha: Integer); safecall;
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
                           CanvasLevel: integer): WordBool; safecall;
    function Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    procedure DrawCircle(WX: Double; WY: Double; WZ: Double; R: Double; R_In_Pixels: WordBool); safecall;
    procedure InsertBlock(const ElementU: IUnknown); safecall;
    procedure CloseBlock; safecall;
    function CheckVisiblePoint(aCanvasTag: Integer; X, Y, Z: Double): WordBool;
      safecall;
    procedure GetTextExtent(const Text: WideString; out Width, Height: Double);
      safecall;
    procedure SetFont(const FontName: WideString; FontSize, FontStyle,
      FontColor: Integer); safecall;
    function Get_IsPrinter: WordBool; safecall;
    procedure Set_IsPrinter(Value: WordBool); safecall;
  public
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;

    procedure InitOpenGL;

    property SpatialModel:ISpatialModel read FSpatialModel write FSpatialModel;
    property ViewHolder:IPainter read FViewHolder write FViewHolder;
    procedure DrawTexture(const TextureName: WideString;
                          var TextureNum: Integer; x0, y0, z0, x1, y1, z1, x2,
                          y2, z2, x3, y3, z3, NX, NY, NZ, MX, MY: Double); safecall;
    property FrameMode:boolean read FFrameMode write SetFrameMode;
  end;

procedure ColorToOpenGL(Color: TColor; var R,G,B:integer);
procedure SetDCPixelFormat (hdc : HDC);
procedure PrepareImages(const TextureName:WideString; out Texture:GLuint);

procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;

const
    GLScale=100;

implementation

var
//  FTextures:array[0..1] of GLuint;
  TCX:array[0..3] of double=(0, 0, 1, 1);
  TCY:array[0..3] of double=(0, 1, 1, 0);
//  XA, YA, ZA:array[0..3] of double;



{ TOpenGLPainter }

procedure TOpenGLPainter.CloseBlock;
begin

end;

constructor TOpenGLPainter.Create(aOwner: TComponent);
begin
  inherited;

end;

destructor TOpenGLPainter.Destroy;
begin
  DM_wglMakeCurrent(FDC, 0);
  DM_wglDeleteContext(Fhrc);
  DM_DeleteDC (FDC);
  inherited;

  FViewHolder:=nil;
  FSpatialModel:=nil;
  FLayerRefTypes:=nil;
end;

procedure TOpenGLPainter.DrawArc(WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2,
  WZ2: Double);
begin

end;

procedure TOpenGLPainter.DrawAxes(XP, YP, ZP: Integer);
begin

end;

procedure TOpenGLPainter.DrawCircle(WX, WY, WZ, R: Double;
  R_In_Pixels: WordBool);
begin

end;

procedure TOpenGLPainter.DrawCurvedLine(PointArray: OleVariant);
begin

end;

procedure TOpenGLPainter.DrawLine(WX0, WY0, WZ0, WX1, WY1, WZ1: Double);
var
  X0, Y0, Z0, X1, Y1, Z1: Double;
  RevScale:double;
begin
  RevScale:=(FViewHolder.ViewU as IView).RevScale;

  if FPenWidth=0 then
    FPenWidth:=1;
  glLineWidth(FPenWidth);
  X0:=WX0/RevScale/GLScale;
  Y0:=WY0/RevScale/GLScale;
  Z0:=WZ0/RevScale/GLScale;
  X1:=WX1/RevScale/GLScale;
  Y1:=WY1/RevScale/GLScale;
  Z1:=WZ1/RevScale/GLScale;
  glBegin(GL_LINES);
    glColor3i(FR, FG, FB);
    glVertex3f(X0, Y0, Z0);
    glVertex3f(X1, Y1, Z1);
  glEnd;
end;

procedure TOpenGLPainter.DrawObjects;
 var
   SpatialModel2:ISpatialModel2;
   i, j: integer;
   Line: ILine;
   LineSE: ISpatialElement;
   LineE:IDMElement;
   Clr:TColor;
   Selected:boolean;
   Area:IArea;
   AreaE, AreaRef:IDMElement;
   DrawSelected:integer;

   OpenGLPainter:IPainter;
begin

  SpatialModel2:=FSpatialModel as ISpatialModel2;

  OpenGLPainter:=Self as IPainter;


  if not FFrameMode then begin
    glEnable(GL_TEXTURE_2D);

    for i:=0 to SpatialModel2.Areas.Count -1 do begin
      AreaE:= SpatialModel2.Areas.Item[i];
      AreaRef:=AreaE.Ref;
      if AreaRef=nil then Exit;
      if AreaRef.Ref.Parent.ID=2 then
        Continue;

      if AreaRef.Selected then
        DrawSelected:=1
      else
       DrawSelected:=0;
      AreaRef.Draw(OpenGLPainter, DrawSelected);
    end;
    glDisable(GL_TEXTURE_2D);
  end;

  if FSpatialModel<>nil then begin
    For i:=0 to FSpatialModel.Lines.Count -1 do begin

      LineE:= FSpatialModel.Lines.Item[i];
      LineSE:=LineE as ISpatialElement;
      if not LineSE.Layer.Visible then Continue;

      Line:= LineE as ILine;

      Selected:=(Line as IDMElement).Selected;
      if not Selected then
        for j:=0 to LineE.Parents.Count-1 do
          if LineE.Parents.Item[j].QueryInterface(IArea, Area)=0 then begin
            AreaE:=Area as IDMElement;
            Selected:=AreaE.Selected;
            if Selected then Break
            else begin
              if (Area.Volume0<>nil) and
                 (Area.Volume0 as iDMElement).Selected then Break;
              if (Area.Volume1<>nil) and
                 (Area.Volume1 as iDMElement).Selected then Break;
            end;
          end; // if Line.Parents[j] is IArea

      if Selected then begin
        FR:=0;
        FG:=128;
        FB:=0;
      end else begin
        Clr:=LineSE.Layer.Color;
        ColorToOpenGL(Clr, FR, FG, FB);
      end;

      if LineE.Selected then
        DrawSelected:=1
      else
        DrawSelected:=0;

      LineE.Draw(OpenGLPainter, DrawSelected);
    end; //For i:=0 to SpatialModel0.Lines.Count -1
  end;   //if SpatialModel0<>nil

end;

procedure TOpenGLPainter.DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z, P3X,
  P3Y, P3Z, P4X, P4Y, P4Z, aAngle: Double; BMPHandle: LongWord; FMT, Alpha: Integer);
begin
end;

procedure TOpenGLPainter.DrawPoint(WX, WY, WZ: Double);
begin
end;

procedure TOpenGLPainter.DrawPolygon(const Lines: IDMCollection;
  Vertical: WordBool);
begin
end;

procedure TOpenGLPainter.DrawRangeMarks;
begin
end;

procedure TOpenGLPainter.DrawRectangle(WX0, WY0, WZ0, WX1, WY1, WZ1,
  Angle: Double);
begin
end;

procedure TOpenGLPainter.DrawText(WX, WY, WZ: Double;
  const Text: WideString; TextSize: Double; const FontName: WideString;
  FontSize, FontColor, FontStyle, ScaleMode: Integer);
begin
end;

function TOpenGLPainter.Get_BrushColor: Integer;
begin
end;

function TOpenGLPainter.Get_BrushStyle: Integer;
begin
end;

function TOpenGLPainter.Get_DmaxPix: Integer;
begin
end;

function TOpenGLPainter.Get_DminPix: Integer;
begin
end;

function TOpenGLPainter.Get_HCanvasHandle: Integer;
begin
end;

function TOpenGLPainter.Get_HHeight: Integer;
begin
end;

function TOpenGLPainter.Get_HWidth: Integer;
begin
end;

function TOpenGLPainter.Get_LayerIndex: Integer;
begin
end;

function TOpenGLPainter.Get_LocalViewU: IUnknown;
begin
end;

function TOpenGLPainter.Get_Mode: Integer;
begin
end;

function TOpenGLPainter.Get_PenColor: Integer;
begin
end;

function TOpenGLPainter.Get_PenMode: Integer;
begin
end;

function TOpenGLPainter.Get_PenStyle: Integer;
begin
end;

function TOpenGLPainter.Get_PenWidth: Double;
begin
  Result:=FPenWidth
end;

function TOpenGLPainter.Get_UseLayers: WordBool;
begin
end;

function TOpenGLPainter.Get_VCanvasHandle: Integer;
begin
end;

function TOpenGLPainter.Get_VHeight: Integer;
begin
end;

function TOpenGLPainter.Get_ViewU: IUnknown;
begin
end;

function TOpenGLPainter.Get_VWidth: Integer;
begin
end;

function TOpenGLPainter.Get_ZmaxPix: Integer;
begin
end;

function TOpenGLPainter.Get_ZminPix: Integer;
begin
end;

procedure TOpenGLPainter.InitOpenGL;
begin
  if FOpenGLInited then Exit;

  FDC := DM_GetDC (Handle);
  SetDCPixelFormat(FDC);
  Fhrc := DM_wglCreateContext(FDC);
  DM_wglMakeCurrent(FDC, Fhrc);
  glEnable(GL_DEPTH_TEST);// разрешаем тест глубины
  glClearColor (1.0, 1.0, 1.0, 1.0);

//  PrepareImages(TextureName);

  FOpenGLInited:=True;

  FFrameMode:=True
end;

procedure TOpenGLPainter.InsertBlock(const ElementU: IInterface);
begin
end;

function TOpenGLPainter.LineIsVisible(aCanvasTag: Integer; var X0, Y0, Z0,
  X1, Y1, Z1: Double; FittoCanvas: WordBool;
  CanvasLevel: integer): WordBool;
begin
end;

procedure TOpenGLPainter.Paint;
begin
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // очистка буфера цвета
  DrawObjects;
  DM_SwapBuffers(FDC);
end;

procedure TOpenGLPainter.P_To_WP(PX, PY, Tag: Integer; out WX, WY,
  WZ: Double);
begin
end;

procedure TOpenGLPainter.Resize;
begin
  DM_InvalidateRect(Handle, nil, False);
end;

 {Перевод цвета из TColor в OpenGL}
procedure ColorToOpenGL(Color: TColor; var R,G,B:integer);
var
  aColor:TColor;
begin
  aColor:=ColorToRGB(Color);
  R:=DM_GetRValue(aColor);
  G:=DM_GetGValue(aColor);
  B:=DM_GetBValue(aColor);
end;

{Формат пикселя}
procedure SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;

 nPixelFormat := DM_ChoosePixelFormat (hdc, @pfd);
 DM_SetPixelFormat (hdc, nPixelFormat, @pfd);
end;

procedure PrepareImages(const TextureName:WideString; out Texture:GLuint);
var
   Path, Filename: String;
begin
   Path:=ExtractFilePath(Application.ExeName);
   Filename:=Path+TextureName;
   LoadTexture(Filename, Texture, False);
end;

procedure TOpenGLPainter.Set_BrushColor(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_BrushStyle(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_DmaxPix(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_DminPix(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_HCanvasHandle(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_HHeight(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_HWidth(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_LayerIndex(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_LocalViewU(const Value: IUnknown);
begin

end;

procedure TOpenGLPainter.Set_Mode(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_PenColor(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_PenMode(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_PenStyle(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_PenWidth(Value: Double);
begin
  FPenWidth:=Value
end;

procedure TOpenGLPainter.Set_VCanvasHandle(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_VHeight(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_ViewU(const Value: IUnknown);
begin

end;

procedure TOpenGLPainter.Set_VWidth(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_ZmaxPix(Value: Integer);
begin

end;

procedure TOpenGLPainter.Set_ZminPix(Value: Integer);
begin

end;

procedure TOpenGLPainter.SetLimits;
begin

end;

procedure TOpenGLPainter.SetRangePix;
begin

end;

procedure TOpenGLPainter.WP_To_P(WX, WY, WZ: Double; out PX, PY,
  PZ: Integer);
begin
end;

procedure TOpenGLPainter.DrawTexture(const TextureName: WideString;
                                     var TextureNum: Integer; x0, y0, z0,
                x1, y1, z1, x2, y2, z2, x3, y3, z3, NX, NY, NZ, MX, MY: Double);
var
  XA, YA, ZA:array[0..3] of double;
  RevScale:double;
  j:integer;
  Texture:GLuint;
begin
  RevScale:=(FViewHolder.ViewU as IView).RevScaleX;

  XA[0]:=x0/RevScale/GLScale;
  YA[0]:=y0/RevScale/GLScale;
  ZA[0]:=z0/RevScale/GLScale;
  XA[1]:=x1/RevScale/GLScale;
  YA[1]:=y1/RevScale/GLScale;
  ZA[1]:=z1/RevScale/GLScale;
  XA[2]:=x2/RevScale/GLScale;
  YA[2]:=y2/RevScale/GLScale;
  ZA[2]:=z2/RevScale/GLScale;
  XA[3]:=x3/RevScale/GLScale;
  YA[3]:=y3/RevScale/GLScale;
  ZA[3]:=z3/RevScale/GLScale;

  if TextureNum=-1 then begin
//  if FTextureNum=999999999 then begin
     PrepareImages(TextureName, Texture);
     TextureNum:=Texture;
  end;

  glBindTexture(GL_TEXTURE_2D, TextureNum);

  glBegin (GL_QUADS);
//  glNormal3f(NX, NY, NZ);
    For j:=0 to 3 do begin
      glTexCoord2f(TCX[j]*MX,TCY[j]*MY);
      glVertex3f(XA[j],YA[j],ZA[j]);
    end;
  glEnd;

end;

procedure TOpenGLPainter.SetFrameMode(const Value: boolean);
begin
  FFrameMode := Value;
  Paint;
end;

function TOpenGLPainter.CheckVisiblePoint(aCanvasTag: Integer; X, Y,
  Z: Double): WordBool;
begin

end;

procedure TOpenGLPainter.Clear;
begin
end;

procedure TOpenGLPainter.GetTextExtent(const Text: WideString; out Width,
  Height: Double);
begin
end;

procedure TOpenGLPainter.SetFont(const FontName: WideString; FontSize,
  FontStyle, FontColor: Integer);
begin
end;

function TOpenGLPainter.Get_IsPrinter: WordBool;
begin
  Result:=False
end;

procedure TOpenGLPainter.Set_IsPrinter(Value: WordBool);
begin

end;

end.
