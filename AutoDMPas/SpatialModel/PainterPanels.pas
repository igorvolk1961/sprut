unit PainterPanels;

interface
uses
  Classes, Graphics, Controls, ExtCtrls,
  SpatialModelLib_TLB;

type  
  TPainterPanel = class(TPanel)
  private
    FPainter: IPainter;
    procedure Set_Painter(const Value: IPainter);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(aOwner:TComponent); override;
    destructor  Destroy; override;
    property  Painter:IPainter read FPainter write Set_Painter;
    procedure Mouse_Move(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Mouse_Down(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
  end;

  TStylePanel = class(TPanel)
  published
   property Canvas;
  public
   Color: TColor;
   Style: integer;
   procedure Paint; override;
  end;

implementation
uses
  DMDrawImpl1;

constructor TPainterPanel.Create(aOwner: TComponent);
begin
  inherited;
  OnMouseMove:=Mouse_Move;
  OnMouseDown:=Mouse_Down;
end;

procedure TPainterPanel.Mouse_Move(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  s:string;
  XM, YM, ZM:double;
  aShift:integer;
begin
//  case (TDMDrawX(Owner) as IDMDraw).CursorType of    // внимание проба
//  1:Cursor:=crHandPoint;
//  else
//    Cursor:=crDefault;
//  end;

  aShift:=0;
  if ssShift in Shift then
    aShift:=aShift or sShift;
  if ssCtrl in Shift then
    aShift:=aShift or sCtrl;
  if ssAlt in Shift then
    aShift:=aShift or sAlt;

  Painter.MouseMove(TComponent(Sender).Tag, aShift, X, Y);
  XM:=Painter.CurrX/100;
  YM:=Painter.CurrY/100;
  ZM:=Painter.CurrZ/100;
  Str(XM:1:2,s);
//IIIIIIIIIIIIIIIIIIIIIIIIIIIII
  TfmDraw(Owner).edX.Text:=s;
  Str(YM:1:2,s);
  TfmDraw(Owner).edY.Text:=s;
  Str(ZM:1:2,s);
  TfmDraw(Owner).edZ.Text:=s;
//__________________________________________________________________
end;

procedure TPainterPanel.Mouse_Down(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aShift:integer;
begin
  SetFocus;

  aShift:=0;
  if ssShift in Shift then
    aShift:=aShift or sShift;
  if ssCtrl in Shift then
    aShift:=aShift or sCtrl;
  if ssAlt in Shift then
    aShift:=aShift or sAlt;
    
  Painter.MouseDown(TComponent(Sender).Tag, ord(Button), aShift, X, Y);
end;

procedure TStylePanel.Paint;
begin;
  inherited Paint;
  with Canvas do begin
    case Style of
      1: Pen.Style:=psDash;
      2: Pen.Style:=psDot;
      3: Pen.Style:=psDashDot;
      4: Pen.Style:=psDashDotDot;
    else Pen.Style:=psSolid;
    end;
    Pen.Width:=0;
    Pen.Color:=Color;
    MoveTo(ClipRect.Left+4,ClipRect.Top+3);
    LineTo(ClipRect.Right-4,ClipRect.Top+3);
    Pen.Style:=psSolid;
  end;
  TfmDraw(Owner).FormPaint(nil);
end;

end.
