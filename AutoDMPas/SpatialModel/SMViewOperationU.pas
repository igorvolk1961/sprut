unit SMViewOperationU;

interface
uses
   DM_Windows,
   SpatialModelLib_TLB, DMServer_TLB, PainterLib_TLB,
   DataModel_TLB ,
   Math, Variants,
   SMOperationU, SMOperationConstU, SysUtils, CustomSMDocumentU;

type
  TSMViewOperation=class(TSMOperation)
  private
    FOldOperationStep:integer;
  public
    constructor Create1(aOperationCode:integer;
      const aOperationManager:TCustomSMDocument;
      OldOperationStep:integer);

    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
  end;

  TZoomInOperation=class(TSMViewOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TZoomOutOperation=class(TZoomInOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TViewPanOperation=class(TSMViewOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

implementation
uses
  SpatialModelConstU;

{ TZoomInOperation }

procedure TZoomInOperation.Drag(
  const SMDocument: TCustomSMDocument);
begin
  DragRect(SMDocument, 0)
end;

procedure TZoomInOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  Painter:IPainter;
  View:IView;
  DMOperationManager:IDMOperationManager;
begin
  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  if (CurrentStep=0) and
     ((sShift and ShiftState)=0) then begin
//    if FOldOperationStep<=0 then
//      DMOperationManager.StartTransaction(nil, leoAdd, rsChangeView);
    View:=Painter.ViewU as IView;
    View.CX:=SMDocument.CurrX;
    View.CY:=SMDocument.CurrY;
    View.CZ:=SMDocument.CurrZ;
    View.RevScale:=View.RevScale/2;
    (SMDocument as IDMDocument).Server.RefreshDocument(rfFrontBack);
  end else
    case CurrentStep of
    0:begin
        X0:=SMDocument.CurrX;
        Y0:=SMDocument.CurrY;
        Z0:=SMDocument.CurrZ;
        CurrentStep:=1;
      end;
    1:begin
//        if FOldOperationStep<=0 then
//          DMOperationManager.StartTransaction(nil, leoAdd, rsChangeView);
        View.CX:=(X0+FX1)/2;
        View.CY:=(Y0+FY1)/2;
        View.CZ:=(Z0+FZ1)/2;
        if FY1<>Y0 then begin
           if Painter.HHeight/Painter.HWidth>Abs((FY1-Y0)/(FX1-X0)) then
              View.RevScale:=Abs(FX1-X0)/Painter.HWidth
           else
              View.RevScale:=Abs(FY1-Y0)/Painter.HHeight
        end else
        if FZ1<>Z0 then begin
           if Painter.VHeight/Painter.VWidth>Abs((FZ1-Z0)/(FX1-X0)) then
             View.RevScale:=Abs(FX1-X0)/Painter.VWidth
           else
             View.RevScale:=Abs(FZ1-Z0)/Painter.VHeight;
        end;
        (SMDocument as IDMDocument).Server.RefreshDocument(rfFrontBack);
        CurrentStep:=0;
      end;
    end;
end;

procedure TZoomInOperation.GetStepHint(aStep: integer; var Hint: string;
  var ACursor: integer);
begin
   case CurrentStep of
    -1, 0: if (DM_GetKeyState(VK_Shift)<0)then begin
         Hint:=rsZoomInHintHead + rsZoomHintStep1_Shift;
         ACursor:=cr_HandZoomIn;
       end else begin
         Hint:=rsZoomInHintHead + rsZoomHintStep0;
         ACursor:=cr_ZoomIn;
       end;
    1:begin Hint:=rsZoomInHintHead + rsZoomHintStep2_Shift;
         ACursor:= cr_HandZoomIn;
      end;
    else begin
      Hint:=rsZoomInHintHead + rsErrOperation;
      ACursor:=0;
    end;
   end;
end;

{ TViewPanOperation }

procedure TViewPanOperation.Drag(
  const SMDocument: TCustomSMDocument);
begin
  DragLine(SMDocument);
end;

procedure TViewPanOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  Painter:IPainter;
  Painter3:IPainter3;
  View:IView;
  DMOperationManager:IDMOperationManager;
begin
  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;
  if Painter.QueryInterface(IPainter3, Painter3)=0 then
    Painter3.SaveCenterPos;
  case CurrentStep of
  0:begin
      X0:=SMDocument.CurrX;
      Y0:=SMDocument.CurrY;
      Z0:=SMDocument.CurrZ;
      CurrentStep:=1;
    end;
  1:begin
//      if FOldOperationStep<=0 then
//        DMOperationManager.StartTransaction(nil, leoAdd, rsChangeView);
      View:=Painter.ViewU as IView;
      View.CX:=View.CX+X0-FX1;
      View.CY:=View.CY+Y0-FY1;
      View.CZ:=View.CZ+Z0-FZ1;
      (SMDocument as IDMDocument).Server.RefreshDocument(rfFastBack);
      CurrentStep:=0;
    end;
  end;
end;

procedure TViewPanOperation.GetStepHint(aStep: integer; var Hint: string;
  var ACursor: integer);
begin
   case CurrentStep of
    -1, 0: if (DM_GetKeyState(VK_CONTROL)<0)then begin
              Hint:=rsPanHintHead + rsPanHintStep1_Ctrl;
              ACursor:=cr_Hand_Move; end
            else begin
              Hint:=rsPanHintHead + rsPanHintStep1;
              ACursor:=cr_Hand_Move;end;
    1: if (DM_GetKeyState(VK_CONTROL)<0)then begin
              Hint:=rsPanHintHead + rsPanHintStep2_Ctrl;
              ACursor:=cr_Hand_Move; end
            else begin
              Hint:=rsPanHintHead + rsPanHintStep2;
              ACursor:=cr_Hand_Move;end;
    else
      begin
        Hint:=rsPanHintHead + rsErrOperation;
        ACursor:=0;
      end;
   end;
end;

{ TZoomOutOperation }

procedure TZoomOutOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  Painter:IPainter;
  View:IView;
  k:double;
  DMOperationManager:IDMOperationManager;
begin
  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  if (CurrentStep=0) and
     ((sShift and ShiftState)=0) then begin
//    if FOldOperationStep<=0 then
//      DMOperationManager.StartTransaction(nil, leoAdd, rsChangeView);
    View:=Painter.ViewU as IView;
    View.RevScale:=View.RevScale*2;
    (SMDocument as IDMDocument).Server.RefreshDocument(rfFrontBack);
  end else
    case CurrentStep of
    0:begin
        X0:=SMDocument.CurrX;
        Y0:=SMDocument.CurrY;
        Z0:=SMDocument.CurrZ;
        CurrentStep:=1;
      end;
    1:begin
//        if FOldOperationStep<=0 then
//          DMOperationManager.StartTransaction(nil, leoAdd, rsChangeView);
        k:=0;
        if FY1<>Y0 then begin
          if Painter.HHeight/Painter.HWidth>Abs((FY1-Y0)/(FX1-X0)) then
            k:=Abs(FX1-X0)/View.RevScale/Painter.HWidth
          else
            k:=Abs(FY1-Y0)/View.RevScale/Painter.HHeight
        end else
        if FZ1<>Z0 then begin
          if Painter.VHeight/Painter.VWidth>Abs((FZ1-Z0)/(FX1-X0)) then
            k:=Abs(FX1-X0)/View.RevScale/Painter.VWidth
          else
            k:=Abs(FZ1-Z0)/View.RevScale/Painter.VHeight;
        end;
        if k<>0 then begin
          View.RevScale:=View.RevScale/k;
          View.CX:=View.CX*(1+1/k)-(X0+FX1)/2/k;
          View.CY:=View.CY*(1+1/k)-(Y0+FY1)/2/k;
          View.CZ:=View.CZ*(1+1/k)-(Z0+FZ1)/2/k;
        end;
        (SMDocument as IDMDocument).Server.RefreshDocument(rfFrontBack);
        CurrentStep:=0;
      end;
    end;
end;

procedure TZoomOutOperation.GetStepHint(aStep: integer; var Hint: string;
  var ACursor: integer);
begin
   case CurrentStep of
    -1, 0: if (DM_GetKeyState(VK_Shift)<0)then begin
         Hint:=rsZoomOutHintHead + rsZoomHintStep1_Shift;
         ACursor:=cr_HandZoomOut;
       end else begin
         Hint:=rsZoomInHintHead + rsZoomHintStep0;
         ACursor:=cr_ZoomOut;
       end;
    1:begin
         Hint:=rsZoomOutHintHead + rsZoomHintStep2_Shift;
         ACursor:= cr_HandZoomOut;
      end;
    else begin
         Hint:=rsZoomOutHintHead + rsErrOperation;
         ACursor:=0;
    end;
   end;
end;

{ TSMViewOperation }

constructor TSMViewOperation.Create1(aOperationCode: integer;
  const aOperationManager: TCustomSMDocument; OldOperationStep: integer);
begin
  inherited Create(aOperationCode, aOperationManager);
  FOldOperationStep:=OldOperationStep;
end;

procedure TSMViewOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState:integer);
begin
  Drag(SMDocument);
  CurrentStep:=-2;
end;

end.
