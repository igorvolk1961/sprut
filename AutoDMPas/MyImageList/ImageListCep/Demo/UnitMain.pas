unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, ImageListCep, FormImageListCep,
  ToolWin, ActnList, StdActns
  {, pngimage, jpeg}; // Добавление поддерживаемых форматов

type
  TDemo = class(TForm)
    ImageListCep1: TImageListCep;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    ActionList1: TActionList;
    Action1: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    WindowClose1: TWindowClose;
    ToolButton2: TToolButton;
    procedure FormPaint(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ImageListCep1Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure WindowClose1Execute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure WindowClose1Update(Sender: TObject);
  private
    { Private declarations }
  
  public
    { Public declarations }
  end;

  TTFormDlgSILEx = class (TFormDlgSIL)
  protected
    function LoadFiles(Ext: String; Instance: hinst; FileNames: string; Width,
      Height: integer; var Bitmap: TBitmap):boolean; override;
  end;

var
  Demo: TDemo;

implementation

{$R *.dfm}

procedure TDemo.FormPaint(Sender: TObject);
var i, X, Y: integer;
begin
  X := (Width-ScrollBar1.Width-TrackBar1.Width-ImageListCep1.Width)div(2)+
       TrackBar1.Width;
  Y := Label1.Top+Label1.Height+8;
  for I := ScrollBar1.Position to ImageListCep1.Count - 1 do
  begin
    ImageListCep1.Draw(Canvas,X,Y,I);
    Canvas.Font := Font;
    Canvas.TextOut(X-24,Y-2,Inttostr(I));
    inc(Y,ImageListCep1.Height+8);
    if Y>=ClientHeight then exit;
  end;
end;

procedure TDemo.FormResize(Sender: TObject);
begin
 Repaint;
end;

procedure TDemo.ImageListCep1Change(Sender: TObject);
begin
  if TrackBar1.Position<>ImageListCep1.Width then
    TrackBar1.Position := ImageListCep1.Width;
  if ScrollBar1.Max <> (ImageListCep1.Count - 1) then
    ScrollBar1.Max := ImageListCep1.Count - 1;
  Repaint;
  ToolBar1.Height := ImageListCep1.Height+10;
  ToolBar1.ButtonWidth := ImageListCep1.Width + 7;
  ToolBar1.ButtonHeight := ImageListCep1.Height + 6;
end;

procedure TDemo.ScrollBar1Change(Sender: TObject);
begin
  Invalidate;
end;

procedure TDemo.TrackBar1Change(Sender: TObject);
begin
  ImageListCep1.Width := TrackBar1.Position;
  ImageListCep1.Height := TrackBar1.Position;
  Label1.Caption := 'Paзмер: ' + inttostr(ImageListCep1.Width) + ' x ' +
                    inttostr(ImageListCep1.Height);
end;

procedure TDemo.WindowClose1Execute(Sender: TObject);
begin
  Close;
end;

procedure TDemo.WindowClose1Update(Sender: TObject);
begin
  WindowClose1.Enabled := true;
end;

procedure TDemo.Action1Execute(Sender: TObject);
var F:TFormDlgSIL;
begin
  F := TTFormDlgSILEx.Create(nil);
  try
    F.ImageListCep := ImageListCep1;
    F.ShowModal;
  finally
    FreeAndNil(F);
  end;
end;

{ TTFormDlgSILEx }

function TTFormDlgSILEx.LoadFiles(Ext: String; Instance: hinst;
  FileNames: string; Width, Height: integer; var Bitmap: TBitmap):boolean;
begin
  // Здесь можно на свое усмотрение изменять загружаемое изображение
  result := inherited LoadFiles(Ext,Instance, FileNames, Width, Height, Bitmap);
end;

end.
