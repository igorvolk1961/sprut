unit OpenGLfrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Spin, Menus, OpenGL, mmSystem,
  DataModel_TLB, SpatialModelLib_TLB;
   //mmSystem
type
  TfmOpenGL = class(TForm)
    Panel1: TPanel;
    SpinEdit1: TSpinEdit;
    PopupMenu1: TPopupMenu;
    Down1: TMenuItem;
    Up1: TMenuItem;
    Left1: TMenuItem;
    Right1: TMenuItem;
    Label5: TLabel;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    edZAngle: TEdit;
    sbZAngle: TSpinButton;
    Label3: TLabel;

    //procedure btnFrustumClick(Sender: TObject);
    procedure btnOrtho2DClick(Sender: TObject);
    procedure btnOrthoClick(Sender: TObject);
  //  procedure btnPerspectiveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LookAtClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Down1Click(Sender: TObject);
    procedure Up1Click(Sender: TObject);
    procedure Left1Click(Sender: TObject);
    procedure Right1Click(Sender: TObject);
    procedure Ambient1Click(Sender: TObject);
    procedure Diffuse1Click(Sender: TObject);
    procedure Specular1Click(Sender: TObject);
    procedure MatAmbient1Click(Sender: TObject);
    procedure edZAngleChange(Sender: TObject);
    procedure sbZAngleDownClick(Sender: TObject);
    procedure sbZAngleUpClick(Sender: TObject);
  private
    FSpatialModel0:ISpatialModel;
    FSpatialModel1:ISpatialModel;
    DC : HDC;
    hrc: HGLRC;
   // procedure SetDCPixelFormat(hdc : HDC);
    procedure PrepareImage(bmap: string);

    //Bitmap : TBitmap;
    //Bits : Array[0..63,0..63,0..2]of GLubyte;
   // procedure BmpTexture;
   // uTimerID : uint;
    //LightPos : Array[0..3]of GLfloat;
   // Delta :GLfloat;
  public
   Ambient, Specular, Diffuse : Array [0..3] of GLfloat;
    MaterialAmbient, MaterialSpecular,
    MaterialDiffuse, MaterialEmission : Array [0..3] of GLfloat;
    SHININESS : GLfloat;
  procedure InitialDock(PanelCode: integer);{ Public declarations }
  procedure Set_SpatialModel0(const Value: ISpatialModel);
  procedure Set_SpatialModel1(const Value: ISpatialModel);

  property SpatialModel0:ISpatialModel read FSpatialModel0 write Set_SpatialModel0;
  property SpatialModel1:ISpatialModel read FSpatialModel1 write Set_SpatialModel1;
  end;

var
  fmOpenGL: TfmOpenGL;

implementation

uses DrawFrm;

{$R *.DFM}

procedure TfmOpenGL.InitialDock(PanelCode:integer);
var
  j:integer;
  DockSite:TWinControl;
begin
  DockSite:=nil;
  case PanelCode of
  1:
    for j:=0 to Application.MainForm.ControlCount-1 do
      if Application.MainForm.Controls[j] is TPageControl then begin
        DockSite:=TWinControl(Application.MainForm.Controls[j]);
        Break;
      end;
  2:
    for j:=0 to Application.MainForm.ControlCount-1 do
      if Application.MainForm.Controls[j] is TPageControl then
        DockSite:=TWinControl(Application.MainForm.Controls[j]);
  end;
  if (DockSite<>nil) and
     (DockSite<>HostDockSite)then
    ManualDock(DockSite);
end;

procedure TfmOpenGL.Set_SpatialModel0(const Value: ISpatialModel);
begin
  FSpatialModel0:=Value;
  Refresh;
end;

procedure TfmOpenGL.Set_SpatialModel1(const Value: ISpatialModel);
begin
  FSpatialModel1:=Value;
  Refresh;
end;





{=======================================================================

Перерисовка окна}
const
  GLScale=100;
  var
  FF : double;
//  angX : integer;
  //eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz :Gldouble;
  eyex1, eyey1, eyez1,
  centerx1, centery1, centerz1: GLDouble;
//  Near1,Far1: GLDouble;
  RevScale, XE, YE:double;
  r,g,b : byte;
//  R1,G1,B1 : GLFloat;
  LightPos : Array[0..3]of GLfloat;
  //Bitmap : TBitmap;
 // bits : Array[0..63,0..63,0..2]of GLubyte;
  Delta :GLfloat;
{==========================================================================}
{ procedure TfmOpenGL.BmpTexture;
var
  i, j: Integer;
begin
  bitmap := TBitmap.Create;
   //bitmap.LoadFromFile('gold.bmp');  // загрузка текстуры из файла
    //bitmap.LoadFromFile('..\WinArc.bmp');
    //bitmap.LoadFromFile('..\..\..\..\OpenGL\Chapter4\WinArc.bmp');
    bitmap.LoadFromFile('КирпичиБ.bmp');
   {--- заполнение битового массива ---}
 { For i := 0 to 63 do
      For j := 0 to 63 do begin
        bits [i, j, 0] := GetRValue(bitmap.Canvas.Pixels[i,j]);
        bits [i, j, 1] := GetGValue(bitmap.Canvas.Pixels[i,j]);
        bits [i, j, 2] := GetBValue(bitmap.Canvas.Pixels[i,j]);
    end;

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA,
                 64, 64,     // здесь задается размер текстуры
                 0, GL_RGB, GL_UNSIGNED_BYTE, @bits);
  //  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
    glEnable(GL_TEXTURE_2D);

end;  }

{=======================================================================  }
  {Подготовка текстуры}
type
  PPixelArray = ^TPixelArray;
  TPixelArray = array [0..0] of Byte;

procedure TfmOpenGL.PrepareImage(bmap: string);
var
  Bitmap : TBitmap;
  Data : PPixelArray;
  BMInfo : TBitmapInfo;
  I, ImageSize : Integer;
  Temp : Byte;
  MemDC : HDC;
begin
  Bitmap := TBitmap.Create;
  Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName)+bmap);
  with BMinfo.bmiHeader do begin
    FillChar (BMInfo, SizeOf(BMInfo), 0);
    biSize := sizeof (TBitmapInfoHeader);
    biBitCount := 24;
    biWidth := Bitmap.Width;
    biHeight := Bitmap.Height;
    ImageSize := biWidth * biHeight;
    biPlanes := 1;
    biCompression := BI_RGB;
    MemDC := CreateCompatibleDC (0);
    GetMem (Data, ImageSize*3);
    try
      GetDIBits (MemDC, Bitmap.Handle, 0, biHeight, Data,
                 BMInfo, DIB_RGB_COLORS);
{$R-}
     For I := 0 to ImageSize - 1 do begin
          Temp := Data[I * 3];
          Data[I * 3] := Data[I*3 + 2];
          Data[I * 3 + 2] := Temp;
      end;
{$R+}
     glTexImage2d(GL_TEXTURE_2D, 0, 3, biWidth,
                   biHeight, 0, GL_RGB, GL_UNSIGNED_BYTE, Data);
    finally
      FreeMem (Data);
      DeleteDC (MemDC);
      Bitmap.Free;
    end;
  end;
end;


{======================================================================= }
 {Перевод цвета из TColor в OpenGL}
procedure ColorToGL (Color : TColor; var R1, G1, B1 : GLFloat);
begin
 R1 := (Color mod $100) / 255;
 G1 := ((Color div $100) mod $100) / 255;
 B1 := (Color div $10000) / 255;
end;
  procedure Zvet(Color: TColor);
 // const R=0000FF
  //var r, g, b : byte;

  begin
       Color:=ColorToRGB(Color);
       r:=GetRValue(Color);
       g:=GetGValue(Color);
       b:=GetBValue(Color);

   end;

   procedure Axes;

   begin
   glPushMatrix;
   glBegin (GL_Lines);
   glColor3f(1,0,0) ;  // ось X
   glVertex3f(0,0,0);
   glVertex3f(1,0,0);
   glColor3f(0,1,0);   // ось Y
   glVertex3f(0,0,0);
   glVertex3f(0,1,0);
   glColor3f(0,0,1);   // ось Z
   glVertex3f(0,0,0);
   glVertex3f(0,0,1);
   glEnd;
   glPopMatrix;
   end;

  { procedure FNTimeCallBack(uTimerID, uMessage: UINT;dwUser, dw1, dw2: DWORD) stdcall;
begin
    LightPos[0] := LightPos[0] + Delta;
    If LightPos[0] > 30.0
       then Delta := -1.0
       else If (LightPos[0] < -30.0) then
            Delta := 1.0;
    InvalidateRect(Handle, nil, False);
end; }
{===========================================================================}
{Формат пикселя}
procedure SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat (hdc, nPixelFormat, @pfd);
end;

{=======================================================================  }
 procedure TfmOpenGL.FormActivate(Sender: TObject);
// var
// wrkPointer : Pointer;
// sWidth, tHeight: GLsizei;
begin
 DC := GetDC (Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 glEnable (GL_LIGHTING);
 glEnable (GL_LIGHT0);
 glEnable(GL_DEPTH_TEST);
 glClearColor (1.0, 1.0, 1.0, 1.0);
 //glClearColor (0.5, 0.5, 0.75, 1.0); // цвет фона - фиолетовый
 glEnable(GL_COLOR_MATERIAL);

 //glColor3f (1.0, 0.0, 0.5);          // текущий цвет примитивов
 //glColor3f (1.0, 0.0, 0.0);
 glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);
//  angX:=10;
 // Delta:=1.0;
  LightPos[0]:=8.0;
  LightPos[1]:=10.0;
  LightPos[2]:=-20.0;
  LightPos[3]:=1.0;
 { SHININESS:=20;
   MaterialAmbient [0] := 0.2;
 MaterialAmbient [1] := 0.2;
 MaterialAmbient [2] := 0.2;
 MaterialAmbient [3] := 1.0;

 MaterialDiffuse [0] := 0.8;
 MaterialDiffuse [1] := 0.8;
 MaterialDiffuse [2] := 0.8;
 MaterialDiffuse [3] := 1.0;

 MaterialSpecular [0] := 1.0;
 MaterialSpecular [1] := 0.0;
 MaterialSpecular [2] := 0.0;
 MaterialSpecular [3] := 0.0;

 MaterialEmission [0] := 0.0;
 MaterialEmission [1] := 0.0;
 MaterialEmission [2] := 0.0;
 MaterialEmission [3] := 1.0;

 Ambient [0] := 0.0;
 Ambient [1] := 0.0;
 Ambient [2] := 0.0;
 Ambient [3] := 1.0;

 Diffuse [0] := 1.0;
 Diffuse [1] := 1.0;
 Diffuse [2] := 1.0;
 Diffuse [3] := 1.0;

 Specular [0] := 1.0;
 Specular [1] := 1.0;
 Specular [2] := 1.0;
 Specular [3] := 1.0;  }
 //uTimerID:=TimeSetEvent(15,0,@FNTimeCallBack,0,TIME_PERIODIC);
    { Up1.ShortCut:=ShortCut(VK_Up,[]);
     Down1.ShortCut:=ShortCut(VK_Down,[]) ;
     Left1.ShortCut:=ShortCut(VK_Left,[]) ;
     Right1.ShortCut:=ShortCut(VK_Right,[]) ;  }

// BmpTexture;




// PrepareImage('Gold.bmp');
//  PrepareImage('КирпичиБ.bmp');
 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
 glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
 glEnable(GL_TEXTURE_2D);
 glEnable(GL_DEPTH_TEST);
end;

procedure TfmOpenGL.FormPaint(Sender: TObject);
{type
 TVector = Array [0..2] of GLdouble;
const
 Cube : Array [0..7] of TVector = ((1.0, 1.0, 1.0),
                         (-1.0, 1.0, 1.0),(-1.0, -1.0, 1.0),
                         (1.0, -1.0, 1.0),(1.0, 1.0, -1.0),
                          (1.0, -1.0, -1.0),(-1.0, -1.0, -1.0),(-1.0, 1.0, -1.0));  }
 const
MaterialRed :   Array[0..3] of GLfloat= (1.0, 0.0, 0.0, 0.0);
 var
    i, j, m : integer;
//   C0T, C1T, C00T :TCoord;
   X0, Y0, Z0, X1, Y1, Z1, RevScale:double;
//   X00T, Y00T, Z00T, C0TX, C0TY, C0TZ, C1TX, C1TY, C1TZ : double;
   Line: ILine;
   LineSE: ISpatialElement;
   LineE:IDMElement;
   Clr:TColor;
   Selected:boolean;
   Area:IArea;
   AreaE:IDMElement;
   Volume:IVolume;
   Polyline:IPolyline;

//   NX, NY, NZ  :double;

    procedure ShowLine(Line:ILine; Width, RevScale, GLScale: double);
    begin
      glLineWidth(Width);
      X0:=Line.C0.X/RevScale/GLScale;
      Y0:=Line.C0.Y/RevScale/GLScale;
      Z0:=Line.C0.Z/RevScale/GLScale;
      X1:=Line.C1.X/RevScale/GLScale;
      Y1:=Line.C1.Y/RevScale/GLScale;
      Z1:=Line.C1.Z/RevScale/GLScale;
      glBegin(GL_LINE_STRIP);
        glVertex3f(X0, Y0, Z0);
        glVertex3f(X1, Y1, Z1);
      glEnd;
    end;

begin
 glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // очистка буфера цвета

 glLightfv(GL_Light0, GL_POSITION, @LightPos);

  //GL_DEPTH_BUFFER_BIT
 //Axes;
 RevScale:=fmDraw.Painter.View.RevScaleX;

 //glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @MaterialRed);

  glLightfv(GL_LIGHT0, GL_AMBIENT, @Ambient);
  glLightfv(GL_LIGHT0, GL_DIFFUSE, @Diffuse);
  glLightfv(GL_LIGHT0, GL_SPECULAR, @Specular);

  glMaterialfv (GL_FRONT, GL_AMBIENT, @MaterialAmbient);
  glMaterialfv (GL_FRONT, GL_DIFFUSE, @MaterialDiffuse);
  glMaterialfv (GL_FRONT, GL_SPECULAR, @MaterialSpecular);
  glMaterialfv (GL_FRONT, GL_EMISSION, @MaterialEmission);
  glMaterialf(GL_FRONT, GL_SHININESS, SHININESS);
 // PrepareImage('Gold.bmp');
 //  BmpTexture;
 {
 For i:=0 to SpatialModel.Areas.Count -1 do begin

           Area:= SpatialModel.Areas[i];
           //ColorToGL(Area.Lines[0].Color,R1,G1,B1);    //
            Zvet(Area.Lines[0].Color);
           glColor3f(R1,G1,B1);

           NX:=Area.NX;
           NY:=Area.NY; //inaccessible value
           NZ:=Area.NZ;

           C00T:= Area.Lines[0].C0  ;
           if (C00T=Area.Lines[1].C0) or (C00T=Area.Lines[1].C1) Then
           C00T:=Area.Lines[0].C1;

           X00T:=C00T.X/RevScale/GLScale;
           Y00T:=C00T.Y/RevScale/GLScale;
           Z00T:=C00T.Z/RevScale/GLScale;

           glBegin (GL_TRIANGLE_FAN);

           //glColor3f(1,0,0);

             glColor3f(r,g,b);
           //glColor3f(R1,G1,B1);
           glNormal3f(NX, NY, NZ);

           glVertex3f(X00T,Y00T,Z00T);
           For j:=1 to Area.Lines.Count -2 do begin
             C0T:=Area.Lines[j].C0;
             C1T:= Area.Lines[j].C1;
             C0TX:=C0T.X/RevScale/GLScale;
             C0TY:=C0T.Y/RevScale/GLScale;
             C0TZ:=C0T.Z/RevScale/GLScale;
             C1TX:=C1T.X/RevScale/GLScale;
             C1TY:=C1T.Y/RevScale/GLScale;
             C1TZ:=C1T.Z/RevScale/GLScale;
             glVertex3f(C0TX,C0TY,C0TZ);
             glVertex3f(C1TX,C1TY,C1TZ);
           end;
             glEnd;
 end;
}

  if SpatialModel0<>nil then begin
    For i:=0 to SpatialModel0.Lines.Count -1 do begin

      LineE:= SpatialModel0.Lines.Item[i];
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
              for m:=0 to AreaE.Parents.Count-1 do
                if AreaE.Parents.Item[m].QueryInterface(IVolume, Volume)=0 then begin
                  Selected:=(Volume as IDMElement).Selected;
                  if Selected then Break
                end;
                if Selected then Break
            end;
          end; // if Line.Parents[j] is IArea

      if Selected then
         glColor3f(0, 255., 0)
      else begin
        if LineSE.Color =0 then
          Clr:=LineSE.Layer.Color
        else
          Clr:=LineSE.Color;
        Zvet(Clr);
        glColor3f(r,g,b);
      end;

      ShowLine(Line, 1, RevScale, GLScale);
    end; //For i:=0 to SpatialModel0.Lines.Count -1
  end;   //if SpatialModel0<>nil

  if SpatialModel1<>nil then begin
    for j:=0 to SpatialModel1.Polylines.Count-1 do begin
      Polyline:=SpatialModel1.Polylines.Item[j] as IPolyline;
      for m:=0 to Polyline.Lines.Count-1 do begin
        Line:= Polyline.Lines.Item[m] as ILine;
        LineSE:=Line as ISpatialElement;
        if not LineSE.Layer.Visible then Continue;
{        if Line.Color =0 then
          Clr:=Line.Layer.Color
        else
          Clr:=Line.Color;
        Zvet(Clr);
        glColor3f(r,g,b);
}
        glColor3f(255,0,0);
        ShowLine(Line, 1, RevScale, GLScale);
      end
    end;
  end;

  //Оси
{
   glBegin (GL_Lines);
   glColor3f(1,0,0) ;  // ось X
   glVertex3f(0,0,0);
   glVertex3f(1,0,0);
   glColor3f(0,1,0);   // ось Y
   glVertex3f(0,0,0);
   glVertex3f(0,1,0);
   glColor3f(0,0,1);   // ось Z
   glVertex3f(0,0,0);
   glVertex3f(0,0,1);
   glEnd;
}

// BmpTexture;
  SwapBuffers(DC);

end;

{=======================================================================

Создание формы}
procedure TfmOpenGL.FormCreate(Sender: TObject);
begin
{
 DC := GetDC (Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 glClearColor (0.5, 0.5, 0.75, 1.0); // цвет фона
 glColor3f (1.0, 0.0, 0.5);          // текущий цвет примитивов
 glPolygonMode (GL_FRONT_AND_BACK, GL_LINE);
}
end;

{=======================================================================
Конец работы приложения}
procedure TfmOpenGL.FormDestroy(Sender: TObject);
begin
 wglMakeCurrent(0, 0);
 wglDeleteContext(hrc);
 ReleaseDC (Handle, DC);
 DeleteDC (DC);
end;

procedure TfmOpenGL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 If Key = VK_ESCAPE then Close;
 if Key = VK_Down then begin
 //angX:= angX - 10;
 //FormResize(nil);
 //LightPos[0]:=LightPos[0] + Delta;
 //LightPos[1]:=LightPos[1] + Delta;
 end;
   if Key = VK_Up then begin
 //angX:= angX + 10;
 //FormResize(nil);
 //LightPos[0]:=LightPos[0] - Delta;
 //LightPos[1]:=LightPos[1] - Delta;
 end;

end;

procedure TfmOpenGL.FormResize(Sender: TObject);
begin
 {wglMakeCurrent(0, 0);
 wglDeleteContext(hrc);
 ReleaseDC (Handle, DC);
 DeleteDC (DC);  }


 DC := GetDC (Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 glEnable (GL_LIGHTING);
 glEnable (GL_LIGHT0);
 glEnable(GL_DEPTH_TEST);
 //glClearColor (0.5, 0.5, 0.75, 1.0); // цвет фона
  glClearColor (1.0, 1.0, 1.0, 1.0);
 glEnable(GL_COLOR_MATERIAL);

 //glColor3f (1.0, 0.0, 0.5);          // текущий цвет примитивов
 glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);


 glViewport(Panel1.Width, 0,Width-Panel1.Width, ClientHeight);
 //InvalidateRect(Handle, nil, False);
// BmpTexture;
// PrepareImage('КирпичиБ.bmp');

 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
 glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
 glEnable(GL_TEXTURE_2D);


 LookAtClick(nil);
 InvalidateRect(Handle, nil, False);
end;

procedure TfmOpenGL.btnOrthoClick(Sender: TObject);
begin
 glLoadIdentity;
 glOrtho (-2, 2, -2, 2, 0, 15.0);  // задаем перспективу
 glTranslatef (0.0, 0.0, -10.0);   // перенос объекта - ось Z
 //glRotatef (30.0, 1.0, 0.0, 0.0);  // поворот объекта - ось X
 //glRotatef (60.0, 0.0, 1.0, 0.0);  // поворот объекта - ось Y
 InvalidateRect(Handle, nil, False);
end;

procedure TfmOpenGL.btnOrtho2DClick(Sender: TObject);
begin
 glLoadIdentity;
 gluOrtho2D (-2, 2, -2, 2);  // задаем перспективу
 //glRotatef (30.0, 1.0, 0.0, 0.0);  // поворот объекта - ось X
 //glRotatef (60.0, 0.0, 1.0, 0.0);  // поворот объекта - ось Y

 InvalidateRect(Handle, nil, False);
end;

{procedure TfmOpenGL.btnFrustumClick(Sender: TObject);
var
 //AngX, AngY, AngZ : GlFloat;
 //Left, Right, Top, Bottom : GlFloat;
begin
 glLoadIdentity;
// X:=StrToFloat(Edit1.Text);
 //Left:= StrToFloat(Edit1.Text);     // Left
// Right:= StrToFloat(Edit2.Text);     // Right
 //Top:= StrToFloat(Edit3.Text);    //    Top
 //Bottom:=StrToFloat(Edit4.Text);   //  Bottom
 //glFrustum (Left, Right, Top, Bottom, 3, 15); // задаем перспективу
 glTranslatef (0.0, 0.0, -8.0);     // перенос объекта - ось Z
 RevScale:=fmDraw.Painter.View.RevScaleX;
  with fmDraw.Painter.View, fmDraw.Painter.Canvas.ClipRect do begin
    XE:=CentralPoint.X+
      (-(Bottom-(Bottom-Top)/2)*sin(Zangle*PI/180))*RevScale;
    YE:=CentralPoint.Y-
      (+(Bottom-(Bottom-Top)/2)*cos(Zangle*PI/180))*RevScale;
  end;
  eyex1:=XE/RevScale/GLScale;
  eyey1:=YE/RevScale/GLScale;
  eyez1:=SpinEdit4.Value*100/RevScale/GLScale;
  centerx1:=fmDraw.Painter.View.CentralPoint.X/RevScale/GLScale;
  centery1:=fmDraw.Painter.View.CentralPoint.Y/RevScale/GLScale;
  centerz1:=SpinEdit5.Value*100/RevScale/GLScale;
 gluLookAt (eyex1, eyey1, eyez1,
            centerx1, centery1, centerz1,
            0, 0, 1);
 //glRotatef (AngX, 1.0, 0.0, 0.0);   // поворот объекта - ось X
 //glRotatef (AngY, 0.0, 1.0, 0.0);   // поворот объекта - ось Y
 //glRotatef (AngZ, 0.0, 0.0, 1.0);  // поворот объекта - ось z
 InvalidateRect(Handle, nil, False);
end;


{procedure TfmOpenGL.btnPerspectiveClick(Sender: TObject);
begin
 glLoadIdentity;
 // задаем перспективу
 gluPerspective(angX,           // угол видимости в направлении оси Y
                ClientWidth / ClientHeight, // угол видимости в направлении оси X - через аспект
                1.0,            // расстояние от наблюдателя до ближней плоскости отсечения
                15.0);          // расстояние от наблюдателя до дальней плоскости отсечения
 glTranslatef (0.0, 0.0, -10.0);   // перенос объекта - ось Z
 glTranslatef (0.0, 10.0, 0.0);

 glRotatef (30.0, 1.0, 0.0, 0.0);  // поворот объекта - ось X
 glRotatef (60.0, 0.0, 1.0, 0.0);  // поворот объекта - ось Y

 InvalidateRect(Handle, nil, False);
end;  }



procedure TfmOpenGL.LookAtClick(Sender: TObject);
    //var FF :GLdouble;

  //aLine:TLine;
  //eyex1, eyey1, eyez1,
  //centerx1, centery1, centerz1,Near1,Far1: GLDouble;
  //RevScale, XE, YE:double;
begin

 glLoadIdentity;
 try
 if SpinEdit1.Text<>'' then
   FF:=SpinEdit1.Value;
// Near1:=SpinEdit2.Value;
// Far1:=SpinEdit3.Value;
 except
   Raise
 end;
{
 if RadioGroup1.ItemIndex =0 then
 glFrustum (-1, 1, -1, 1, 5, 20)
 else
 //gluPerspective (FF,1, Near1, Far1);
} 
 gluPerspective (FF,(Width-Panel1.Width)/ClientHeight, 1, 30);
 glTranslatef (0.0, 0.0, -10.0);

  RevScale:=fmDraw.Painter.View.RevScaleX;
  with fmDraw.Painter.View, fmDraw.Painter do begin
    XE:=CX+
      (-HHeight*sin(Zangle*PI/180))*RevScale;
//      (-(Bottom-(Bottom-Top)/2)*sin(Zangle*PI/180))*RevScale;
    YE:=CY-
      (+HHeight*cos(Zangle*PI/180))*RevScale;
//      (+(Bottom-(Bottom-Top)/2)*cos(Zangle*PI/180))*RevScale;
  end;
  eyex1:=XE/RevScale/GLScale;
  eyey1:=YE/RevScale/GLScale;
  if SpinEdit4.Text<>'' then
    eyez1:=SpinEdit4.Value*100/RevScale/GLScale;
  centerx1:=fmDraw.Painter.View.CX/RevScale/GLScale;
  centery1:=fmDraw.Painter.View.CY/RevScale/GLScale;
  if SpinEdit5.Text<>'' then
    centerz1:=SpinEdit5.Value*100/RevScale/GLScale;
  gluLookAt (eyex1, eyey1, eyez1,
            centerx1, centery1, centerz1,
            0, 0, 1);
// glRotatef (-60.0, 1.0, 0.0, 0.0);
// glRotatef (30.0, 0.0, 0.0, 1.0);
 InvalidateRect(Handle, nil, False);
end;

procedure TfmOpenGL.Button1Click(Sender: TObject);
begin
 {eyex:=StrToFloat(Edit4.Text);
 eyey:=StrToFloat(Edit5.Text);
 eyez:=StrToFloat(Edit6.Text);
 centerx:=StrTofloat(Edit7.Text);
 centery:=StrToFloat(Edit8.Text);
 centerz:=StrToFloat(Edit9.Text); }

 end;

procedure TfmOpenGL.SpinEdit4Change(Sender: TObject);
begin
  try
    eyez1:=SpinEdit4.Value*100/RevScale/GLScale;
    LookAtClick(nil);
  except
  end;
end;

procedure TfmOpenGL.SpinEdit5Change(Sender: TObject);
begin
  try
    centerz1:=SpinEdit5.Value*100/RevScale/GLScale;
    LookAtClick(nil);
  except
  end;
end;

procedure TfmOpenGL.SpinEdit1Change(Sender: TObject);
begin
  try
   FF:=SpinEdit1.Value;
    LookAtClick(nil);
  except
  end;  
end;

procedure TfmOpenGL.RadioGroup1Click(Sender: TObject);
begin
  LookAtClick(nil);
end;

procedure TfmOpenGL.Panel2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetFocus;
end;

procedure TfmOpenGL.Down1Click(Sender: TObject);
begin
 //LightPos[0]:=LightPos[0] - Delta;
 //LightPos[1]:=LightPos[1] - Delta;
end;

procedure TfmOpenGL.Up1Click(Sender: TObject);
begin
 //LightPos[0]:=LightPos[0] + Delta;
 //LightPos[1]:=LightPos[1] + Delta;
end;

procedure TfmOpenGL.Left1Click(Sender: TObject);
begin
 LightPos[0]:=LightPos[0] - Delta;
 LightPos[1]:=LightPos[1] - Delta;
end;

procedure TfmOpenGL.Right1Click(Sender: TObject);
begin
 LightPos[0]:=LightPos[0] + Delta;
 LightPos[1]:=LightPos[1] + Delta;
end;

procedure TfmOpenGL.Ambient1Click(Sender: TObject);
begin
{if ColorDialog1.Execute then
   ColorToGL(ColorDialog1.Color, Ambient[0], Ambient[1],Ambient[2]);
end;
  // if ClorDialog1.Execute then
  // Zvet(ColorDialog1.Color);
  // Ambient[0]:=r;
  //Ambient[1]:=g;
  //Ambient[2]:=b;  }
   end;
procedure TfmOpenGL.Diffuse1Click(Sender: TObject);
begin
{   if ColorDialog1.Execute then
  ColorToGL(ColorDialog1.Color, Diffuse[0], Diffuse[1],Diffuse[2]);
  }
end;

procedure TfmOpenGL.Specular1Click(Sender: TObject);
begin
{if ColorDialog1.Execute then
   ColorToGL(ColorDialog1.Color, Specular[0], Specular[1],Specular[2]);
}
end;

procedure TfmOpenGL.MatAmbient1Click(Sender: TObject);
begin
//if ColorDialog1.Execute then
//ColorToGL(ColorDialog1.Color, MaterialAmbient[0], MaterialAmbient[1],MaterialAmbient[2]);
end;

procedure TfmOpenGL.edZAngleChange(Sender: TObject);
begin
  fmDraw.edZAngle.Text:=edZAngle.Text;
  fmDraw.edZAngle.Modified:=True;
  fmDraw.ViewZangleChange(fmDraw.edZangle)
end;

procedure TfmOpenGL.sbZAngleDownClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
  Val(edZAngle.Text,D,C);
  D := D - 5;
  edZAngle.Text:=Format('%-1.2f',[D]);
  edZAngle.Modified := True;
  edZAngle.OnChange(nil);
end;

procedure TfmOpenGL.sbZAngleUpClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
  Val(edZAngle.Text,D,C);
  D := D + 5;
  edZAngle.Text:=Format('%-1.2f',[D]);
  edZAngle.Modified := True;
  edZAngle.OnChange(nil);
end;

end.

