unit DMOpenGLU;
//___________________________________вариант  Volkov_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows,
  DM_Windows, DM_Messages,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU, PainterLib_TLB,
  SpatialModelLib_TLB, ClipBrd, OpenGL, mmSystem, DMOpenGLPainter;

type

  TDMOpenGL = class(TDMPage)
    ControlBar1: TControlBar;
    Panel1: TPanel;
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edDistance: TSpinEdit;
    edEyeHeight: TSpinEdit;
    edTargetHeight: TSpinEdit;
    edZAngle: TEdit;
    sbZAngle: TSpinButton;
    Splitter1: TSplitter;
    btUp: TSpeedButton;
    btDown: TSpeedButton;
    btRight: TSpeedButton;
    btLeft: TSpeedButton;
    chbFrameMode: TCheckBox;

    procedure FormCreate(Sender: TObject);
    procedure edEyeHeightChange(Sender: TObject);
    procedure edDistanceChange(Sender: TObject);
    procedure edZAngleChange(Sender: TObject);
    procedure edTargetHeightChange(Sender: TObject);
    procedure sbZAngleDownClick(Sender: TObject);
    procedure sbZAngleUpClick(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btUpClick(Sender: TObject);
    procedure btDownClick(Sender: TObject);
    procedure btLeftClick(Sender: TObject);
    procedure btRightClick(Sender: TObject);
    procedure chbFrameModeClick(Sender: TObject);
  private
    FChangingView:boolean;

    Panel0:TOpenGLPainter;

    FEditMode: boolean;

    FIntervalAngle:double;

    procedure CallRefresh(FlagSet:integer);
    procedure LookAt;
    procedure ResetEye;

  protected
    procedure OpenDocument; override; safecall;
    procedure RefreshDocument(FlagSet:integer); override; safecall;
    procedure DocumentOperation(ElementsV,
      CollectionV: OleVariant; DMOperation, nItemIndex: Integer); override;
    procedure RefreshElement(DMElement:OleVariant); override; safecall;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;

  public
    destructor Destroy; override;
  end;

var
  DMOpenGL:TDMOpenGL;
implementation

{$R *.dfm}

var
    FDistance, FRevScale : double;
    Feyex1, Feyey1, Feyez1, Fcenterx1, Fcentery1, Fcenterz1: GLDouble;

function gluBuild2DMipmaps(Target: GLenum; Components, Width, Height: GLint; Format, atype: GLenum; Data: Pointer): GLint; stdcall; external glu32;
procedure glGenTextures(n: GLsizei; var textures: GLuint); stdcall; external opengl32;
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;

{ TDMOpenGLX }

{======================================================================= }
procedure TDMOpenGL.FormCreate(Sender: TObject);
begin
  DecimalSeparator:='.';

  FEditMode:=True;
  Panel0:=TOpenGLPainter.Create(Self);
  Panel0.Parent:=Self;
  Panel0.Align:=alClient;
  (Panel0 as IPainter)._AddRef;

  FIntervalAngle:=5;

end;

procedure TDMOpenGL.OpenDocument;
var
  aDataModel:IDataMOdel;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  SMDocument:ISMDocument;
  View:IView;
begin
  inherited;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  aDataModel:=DMDocument.DataModel as IDataModel;
  SMDocument:=DMDocument as ISMDocument;

  Panel0.SpatialModel:=aDataModel as ISpatialModel;
  if SMDocument.PainterU=nil then Exit;

  Panel0.ViewHolder:=SMDocument.PainterU as IPainter;

  View:=Panel0.ViewHolder.ViewU as IView;
  FRevScale:=View.RevScaleX;

  FDistance:=edDistance.Value;
  Feyez1:=edEyeHeight.Value*100/FRevScale/GLScale;
  Fcenterz1:=edTargetHeight.Value*100/FRevScale/GLScale;

  ResetEye;
end;

procedure TDMOpenGL.LookAt;
var
   R:double;
begin
{
  if Panel0.ViewHolder=nil then begin
    Server:=Get_DataModelServer as IDataModelServer;
    if Server=nil then Exit;
    SMDocument:=Server.CurrentDocument as ISMDocument;
    if SMDocument=nil then Exit;
    if SMDocument.Painter<>nil then
      Panel0.ViewHolder:=SMDocument.Painter
    else
      Exit;
  end;
}
  glViewport(0, 0, Panel0.Width, Panel0.Height);
  glMatrixMode (GL_PROJECTION);
  glLoadIdentity;
  R:=Panel0.Width/Panel0.Height;
  gluPerspective (FDistance ,R, 1, 30);
  glTranslatef (0.0, 0.0, -10.0);

  gluLookAt (Feyex1, Feyey1, Feyez1,
            Fcenterx1, Fcentery1, Fcenterz1,
            0, 0, 1);
  Panel0.Invalidate;
end;

procedure TDMOpenGL.ResetEye;
var
   View:IView;
   HHeight:integer;
   XE, YE:double;
begin
  if Panel0.ViewHolder=nil then Exit;
  View:=Panel0.ViewHolder.ViewU as IView;
  FRevScale:=View.RevScaleX;

  HHeight:=Panel0.ViewHolder.HHeight;

  with View do begin
    XE:=CX+
      (-HHeight*sin(Zangle*PI/180))*FRevScale;
    YE:=CY-
      (+HHeight*cos(Zangle*PI/180))*FRevScale;
  end;
  Feyex1:=XE/FRevScale/GLScale;
  Feyey1:=YE/FRevScale/GLScale;

  Fcenterx1:=View.CX/FRevScale/GLScale;
  Fcentery1:=View.CY/FRevScale/GLScale;

  LookAt;
end;

{ TOpenGLPanel }

procedure TDMOpenGL.edEyeHeightChange(Sender: TObject);
begin
  try
    Feyez1:=edEyeHeight.Value*100/FRevScale/GLScale;
    ResetEye;
  except
  end;
end;

procedure TDMOpenGL.edDistanceChange(Sender: TObject);
begin
  try
   FDistance:=edDistance.Value;
    ResetEye;
  except
  end;
end;

procedure TDMOpenGL.edZAngleChange(Sender: TObject);
var
 C:integer;
 Z:double;
begin
  try
    if FChangingView then Exit;
    if not edZAngle.Modified then Exit;
    Val(edZAngle.Text,Z,C);
    if C<>0 then begin
      edZAngle.Font.Color:=clRed;
      Exit;
    end else
      edZAngle.Font.Color:=clWindowText;
    (Panel0.ViewHolder.ViewU as IView).Zangle:=Z;
    CallRefresh(rfFrontBack);
  except
  end;
end;

procedure TDMOpenGL.edTargetHeightChange(Sender: TObject);
begin
  try
    Fcenterz1:=edTargetHeight.Value*100/FRevScale/GLScale;
    ResetEye;
  except
  end;
end;

procedure TDMOpenGL.RefreshDocument(FlagSet:integer);
begin
  if not Visible then Exit;
  ResetEye;
end;

procedure TDMOpenGL.sbZAngleDownClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
  if FChangingView then Exit;
  Val(edZAngle.Text,D,C);
  D := D - FIntervalAngle;
  edZAngle.Text:=Format('%-1.2f',[D]);
  edZAngle.Modified := True;
  edZAngle.OnChange(nil);
end;

procedure TDMOpenGL.sbZAngleUpClick(Sender: TObject);
var
  C:integer;
  D:double;
begin
  if FChangingView then Exit;
  Val(edZAngle.Text,D,C);
  D := D + FIntervalAngle;
  edZAngle.Text:=Format('%-1.2f',[D]);
  edZAngle.Modified := True;
  edZAngle.OnChange(nil);
end;

procedure TDMOpenGL.CallRefresh(FlagSet:integer);
var
  Server:IDataModelServer;
begin
  if FChangingView then Exit;
  FChangingView:=True;
  Server:=Get_DataModelServer as IDataModelServer;
  Server.RefreshDocument(FlagSet);   //  Repaint;
  FChangingView:=False;
end;

procedure TDMOpenGL.SpinEdit2Change(Sender: TObject);
var
 C:integer;
 Z:double;
begin
  if FChangingView then Exit;
  if not edZAngle.Modified then Exit;
  Val(edZAngle.Text,Z,C);
  if C<>0 then begin
    edZAngle.Font.Color:=clRed;
    Exit;
  end else
    edZAngle.Font.Color:=clWindowText;
  (Panel0.ViewHolder.ViewU as IView).Zangle:=Z;
  CallRefresh(rfFrontBack);
end;

destructor TDMOpenGL.Destroy;
begin
  try
    inherited;
    
  except
  end
end;

procedure TDMOpenGL.DocumentOperation(ElementsV, CollectionV: OleVariant;
  DMOperation, nItemIndex: Integer);
begin
  if not Visible then Exit;
  ResetEye
end;

procedure TDMOpenGL.RefreshElement(DMElement: OleVariant);
begin
  inherited;

end;

procedure TDMOpenGL.SelectionChanged(DMElement: OleVariant);
begin
  if not Visible then Exit;
  ResetEye
end;

procedure TDMOpenGL.FormPaint(Sender: TObject);
var
  Server:IDataModelServer;
  SMDocument:ISMDocument;
begin
  Panel0.InitOpenGL;

  if Panel0.ViewHolder=nil then begin
    Server:=Get_DataModelServer as IDataModelServer;
    SMDocument:=Server.CurrentDocument as ISMDocument;
    if SMDocument.PainterU<>nil then
      Panel0.ViewHolder:=SMDocument.PainterU as IPainter
  end;

end;

procedure TDMOpenGL.FormResize(Sender: TObject);
begin
  inherited;
  ResetEye;
end;

procedure TDMOpenGL.btUpClick(Sender: TObject);
var
  Step:double;
  View:IView;
begin
  View:=Panel0.ViewHolder.ViewU as IView;
  Step:=20/FRevScale/GLScale;
  Feyex1:=Feyex1+Step*sin(View.Zangle*PI/180)*FRevScale;
  Feyey1:=Feyey1+Step*cos(View.Zangle*PI/180)*FRevScale;
  Fcenterx1:=Fcenterx1+Step*sin(View.Zangle*PI/180)*FRevScale;
  Fcentery1:=Fcentery1+Step*cos(View.Zangle*PI/180)*FRevScale;
  LookAt;
end;

procedure TDMOpenGL.btDownClick(Sender: TObject);
var
  Step:double;
  View:IView;
begin
  View:=Panel0.ViewHolder.ViewU as IView;
  Step:=20/FRevScale/GLScale;
  Feyex1:=Feyex1-Step*sin(View.Zangle*PI/180)*FRevScale;
  Feyey1:=Feyey1-Step*cos(View.Zangle*PI/180)*FRevScale;
  Fcenterx1:=Fcenterx1-Step*sin(View.Zangle*PI/180)*FRevScale;
  Fcentery1:=Fcentery1-Step*cos(View.Zangle*PI/180)*FRevScale;
  LookAt;
end;

procedure TDMOpenGL.btLeftClick(Sender: TObject);
var
  Step:double;
  View:IView;
begin
  View:=Panel0.ViewHolder.ViewU as IView;
  Step:=20/FRevScale/GLScale;
  Feyex1:=Feyex1-Step*cos(View.Zangle*PI/180)*FRevScale;
  Feyey1:=Feyey1+Step*sin(View.Zangle*PI/180)*FRevScale;
  Fcenterx1:=Fcenterx1-Step*cos(View.Zangle*PI/180)*FRevScale;
  Fcentery1:=Fcentery1+Step*sin(View.Zangle*PI/180)*FRevScale;
  LookAt;
end;

procedure TDMOpenGL.btRightClick(Sender: TObject);
var
  Step:double;
  View:IView;
begin
  View:=Panel0.ViewHolder.ViewU as IView;
  Step:=20/FRevScale/GLScale;
  Feyex1:=Feyex1+Step*cos(View.Zangle*PI/180)*FRevScale;
  Feyey1:=Feyey1-Step*sin(View.Zangle*PI/180)*FRevScale;
  Fcenterx1:=Fcenterx1+Step*cos(View.Zangle*PI/180)*FRevScale;
  Fcentery1:=Fcentery1-Step*sin(View.Zangle*PI/180)*FRevScale;
  LookAt;
end;

procedure TDMOpenGL.chbFrameModeClick(Sender: TObject);
begin
  Panel0.FrameMode:=chbFrameMode.Checked
end;

end.
