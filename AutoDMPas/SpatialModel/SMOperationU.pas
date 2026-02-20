unit SMOperationU;

interface
uses
  SpatialModelLib_TLB, DMServer_TLB, PainterLib_TLB, CustomSMDocumentU;

type
  TSMOperationClass=class of TSMOperation;

  TSMOperation=class
  private
    FOperationCode:integer;
    FCurrentStep:integer;
    FOperationManager:TCustomSMDocument;
    procedure SetCurrentStep(const Value: integer);
  protected
    FX0:double;
    FY0:double;
    FZ0:double;
    FX1:double;
    FY1:double;
    FZ1:double;

    procedure DragRect(const SMDocument:TCustomSMDocument; Angle:double);
    procedure DragLine(const SMDocument:TCustomSMDocument);
    procedure DragCircle(const SMDocument:TCustomSMDocument);

    procedure SetX0(const Value: double);
    procedure SetY0(const Value: double);
    procedure SetZ0(const Value: double);
  public
    constructor Create(aOperationCode:integer; const aOperationManager:TCustomSMDocument); virtual;
    destructor Destroy; override;
//    constructor Create(aOperationCode:integer; var Hint:string;ACursor:integer); virtual;
    property OperationCode:integer read FOperationCode write FOperationCode;
    property CurrentStep:integer read FCurrentStep write SetCurrentStep;
    property X0:double read FX0 write SetX0;
    property Y0:double read FY0 write SetY0;
    property Z0:double read FZ0 write SetZ0;

    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);virtual;
    function  GetBaseNode:ICoordNode; virtual;
    function  GetFirstNode:ICoordNode; virtual;
    procedure Drag(const SMDocument:TCustomSMDocument); virtual;
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); virtual;
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); virtual;
    procedure Init; virtual;
    procedure Undo(const SMDocument: TCustomSMDocument); virtual;
    procedure Redo(const SMDocument: TCustomSMDocument); virtual;
    function GetModelCheckFlag:boolean; virtual;
  end;

implementation
uses
  Graphics, Math;

{ TSMOperation }


procedure TSMOperation.GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);
begin
  Hint:='Текст подсказки пока не определен';
  ACursor:=0;
end;

procedure TSMOperation.Execute(const SMDocument:TCustomSMDocument;
                               ShiftState: integer);
begin
end;

procedure TSMOperation.Drag(const SMDocument:TCustomSMDocument);
begin
end;

procedure TSMOperation.Stop(const SMDocument:TCustomSMDocument; ShiftState:integer);
begin
  Drag(SMDocument);
  if CurrentStep<>0 then
    CurrentStep:=-1;
  inherited;
end;

procedure TSMOperation.DragLine(const SMDocument:TCustomSMDocument);
var
  Painter:IPainter;
begin
  if FCurrentStep>0 then begin
    if SMDocument.DontDragMouse<>0 then begin
      SMDocument.DontDragMouse:=SMDocument.DontDragMouse+1;
      if SMDocument.DontDragMouse=10 then
        SMDocument.DontDragMouse:=0;
    end else begin
      FX1:=SMDocument.VirtualX;
      FY1:=SMDocument.VirtualY;
      FZ1:=SMDocument.VirtualZ;
      Painter:=SMDocument.PainterU as IPainter;
      Painter.PenStyle:=ord(psDot);
      Painter.PenMode:=ord(pmNotXor);
      Painter.PenColor:=clBlack;
      Painter.DrawLine(FX0, FY0, FZ0, FX1, FY1, FZ1);
    end;
  end;
end;

procedure TSMOperation.DragRect(const SMDocument:TCustomSMDocument; Angle:double);
var
  Painter:IPainter;
begin
  if FCurrentStep>0 then begin
    if SMDocument.DontDragMouse<>0 then begin
      SMDocument.DontDragMouse:=SMDocument.DontDragMouse+1;
      if SMDocument.DontDragMouse=10 then
        SMDocument.DontDragMouse:=0;
    end else begin
      FX1:=SMDocument.VirtualX;
      FY1:=SMDocument.VirtualY;
      FZ1:=SMDocument.VirtualZ;
      Painter:=SMDocument.PainterU as IPainter;
      Painter.PenStyle:=ord(psDot);
      Painter.PenMode:=ord(pmNotXor);
      Painter.PenColor:=clBlack;
      Painter.DrawRectangle(FX0, FY0, FZ0, FX1, FY1, FZ1, Angle);
    end;
  end;
end;

function TSMOperation.GetBaseNode: ICoordNode;
begin
  Result:=nil
end;

procedure TSMOperation.Init;
begin
end;

constructor TSMOperation.Create(aOperationCode: integer; const aOperationManager:TCustomSMDocument);
//constructor TSMOperation.Create(aOperationCode: integer; var Hint:string;ACursor:integer);
begin
  inherited Create;
  Init;
  FOperationCode:=aOperationCode;
  FOperationManager:=aOperationManager
end;

destructor TSMOperation.Destroy;
begin
  inherited;
  FOperationManager:=nil
end;

procedure TSMOperation.SetX0(const Value: double);
begin
  FX0 := Value;
  FOperationManager.OperationX0:=Value
end;

procedure TSMOperation.SetY0(const Value: double);
begin
  FY0 := Value;
  FOperationManager.OperationY0:=Value
end;

procedure TSMOperation.SetZ0(const Value: double);
begin
  FZ0 := Value;
  FOperationManager.OperationZ0:=Value
end;

procedure TSMOperation.SetCurrentStep(const Value: integer);
begin
  try
  FCurrentStep := Value;
  FOperationManager.OperationStep:=Value
  except
    raise
  end;
end;

procedure TSMOperation.Redo(const SMDocument: TCustomSMDocument);
begin
end;

procedure TSMOperation.Undo(const SMDocument: TCustomSMDocument);
begin
end;

function TSMOperation.GetFirstNode: ICoordNode;
begin
  Result:=nil
end;

procedure TSMOperation.DragCircle(const SMDocument: TCustomSMDocument);
var
  Painter:IPainter;
  R:double;
begin
  if FCurrentStep>0 then begin
    if SMDocument.DontDragMouse<>0 then begin
      SMDocument.DontDragMouse:=SMDocument.DontDragMouse+1;
      if SMDocument.DontDragMouse=10 then
        SMDocument.DontDragMouse:=0;
    end else begin
      FX1:=SMDocument.VirtualX;
      FY1:=SMDocument.VirtualY;
      FZ1:=SMDocument.VirtualZ;
      R:=sqrt(sqr(FX1-FX0)+sqr(FY1-FY0)+sqr(FZ1-FZ0));
      Painter:=SMDocument.PainterU as IPainter;
      Painter.PenStyle:=ord(psDot);
      Painter.PenMode:=ord(pmNotXor);
      Painter.PenColor:=clBlack;
      Painter.DrawCircle(FX0, FY0, FZ0, R, False);
    end;
  end;
end;

function TSMOperation.GetModelCheckFlag: boolean;
begin
  Result:=False
end;

end.
