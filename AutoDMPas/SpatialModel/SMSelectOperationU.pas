unit SMSelectOperationU;

interface
uses
   DM_Windows,
   Classes, SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB , PainterLib_TLB,
   Math, Variants,
   DMElementU, SMOperationU, SMOperationConstU, CustomSMDocumentU, Graphics;

const
    sofVLine=1;
    sofNode=2;
    sofVArea=4;
    sofHLine=8;
    sofVolume=16;
    sofHArea=32;
    sofImage=64;
    sofOutline=128;

type
  TSelectOperationCode=(
    socVLine,
    socNode,
    socVArea,
    socHLine,
    socVolume,
    socHArea,
    socImage
   );

  TSMSelectOperation=class(TSMOperation)
  private
    function GetFlagSet:integer; virtual;
    procedure DoSelectNode(const NodeE: IDMElement; const Painter:IPainter;
                        ShiftState:integer);
    function GetNodeElement(const NodeE: IDMElement;
                        ShiftState:integer): IDMElement;
  protected
    FLastSelected:pointer;
    FList:TList;
    FSelectedElementList:TList;
    FTMPArea:pointer;
    FImageRect:pointer;
    FCircle:pointer;
    FLastSelectOperationCode:integer;
    procedure SelectAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); virtual;
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); virtual;
    procedure SelectClosedPolylineAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer);

    procedure SelectNodeAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer; const aNodeE:IDMElement); virtual;
    procedure SelectNodeByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); virtual;
    procedure SelectVLineAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); virtual;
    procedure SelectVLineByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); virtual;
    procedure SelectHLineAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer; const aLineE:IDMElement); virtual;
    procedure SelectHLineByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); virtual;
    procedure SelectVAreaAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); virtual;
    procedure SelectVAreaByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); virtual;
    procedure SelectHAreaAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); virtual;
    procedure SelectHAreaByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); virtual;
    procedure SelectVolumeAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); virtual;
    procedure SelectVolumeByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); virtual;
  public
    constructor Create(aOperationCode:integer;
                 const aOperationManager:TCustomSMDocument); override;
    destructor Destroy; override;

    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TSelectLineOperation=class(TSMSelectOperation)
  private
  protected
    function GetFlagSet:integer; override;
    procedure SelectAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); override;
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); override;
  public
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;

  TSelectVerticalAreaOperation=class(TSelectLineOperation)
  private
  protected
    function GetFlagSet:integer; override;
    procedure SelectAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); override;
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); override;
  public
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;


  TCustomSelectClosedPolyLineOperation=class(TSMSelectOperation)
  private
  protected
    function GetFlagSet:integer; override;
  public
    procedure SelectAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); override;
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); override;
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;

  TSelectClosedPolylineOperation=class(TCustomSelectClosedPolyLineOperation)
  private
  protected
  public
    procedure SelectAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); override;
  end;

  TSelectVolumeOperation=class(TCustomSelectClosedPolyLineOperation)
  private
  protected
    function GetFlagSet:integer; override;
  public
    procedure SelectAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); override;
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); override;
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;

  TSelectCoordNodeOperation=class(TSMSelectOperation)
  private
  protected
    function GetFlagSet:integer; override;
  public
    procedure SelectAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); override;
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); override;
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;

  TSelectVerticalLineOperation=class(TSelectCoordNodeOperation)
  private
  protected
    function GetFlagSet:integer; override;
  public
    procedure SelectAtPoint(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer); override;
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); override;
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;

  TSelectImageOperation=class(TSMSelectOperation)
  private
  protected
    function GetFlagSet:integer; override;
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;


  TSelectLabelOperation=class(TSMSelectOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                    ShiftState: integer); override;
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;

  TSelectAllOperation=class(TSelectVerticalLineOperation)
  private
  protected
    function GetFlagSet:integer; override;
  public
    constructor Create(aOperationCode:integer;
                 const aOperationManager:TCustomSMDocument); override;
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); override;
    procedure GetStepHint(aStep: integer; var Hint: string;
      var ACursor: integer); override;
  end;

implementation

{ TSMSelectOperation }

procedure TSMSelectOperation.Drag(
  const SMDocument: TCustomSMDocument);
var
  Painter:IPainter;
  View:IView;
begin
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  if View=nil then Exit;
  DragRect(SMDocument, -2*View.ZAngle);
end;

procedure TSMSelectOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState:integer);
var
  DMDocument:IDMDocument;
begin
  DMDocument:=SMDocument as IDMDocument;
  if DMDocument.SelectionCount=0 then
    DMDocument.UndoSelection
  else
    DMDocument.ClearSelection(nil);
end;

{ TSMSelectOperation }

procedure TSMSelectOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  DMDocument:IDMDocument;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  View:IView;
  MaxX, MinX, MaxY, MinY, MaxZ, MinZ, W:double;
  Tag, OldState, OldSelectState, FlagSet:integer;
  LastSelectedE:IDMElement;
  aDataModel:IDataModel;
begin
  FlagSet:=GetFlagSet;
  if (CurrentStep=0) and
     ((sShift and ShiftState)=0) then
    SelectAtPoint(SMDocument, ShiftState, FlagSet)
  else begin
    DMDocument:=SMDocument as IDMDocument;
    aDataModel:=DMDocument.DataModel as IDataModel;
    SpatialModel:=aDataModel as ISpatialModel;
    Painter:=SMDocument.PainterU as IPainter;
    View:=Painter.ViewU as IView;

    CurrentStep:=CurrentStep+1;
    if CurrentStep=1 then begin
      X0:=SMDocument.CurrX;
      Y0:=SMDocument.CurrY;
      Z0:=SMDocument.CurrZ;
    end else
    if CurrentStep=2 then begin
      MaxX:=X0;
      MinX:=SMDocument.CurrX;
      if MinX>MaxX then begin
        W:=MaxX;
        MaxX:=MinX;
        MinX:=W
      end;
      MaxY:=Y0;
      MinY:=SMDocument.CurrY;
      if MinY>MaxY then begin
        W:=MaxY;
        MaxY:=MinY;
        MinY:=W
      end;
      MaxZ:=Z0;
      MinZ:=SMDocument.CurrZ;
      if MinZ>MaxZ then begin
        W:=MaxZ;
        MaxZ:=MinZ;
        MinZ:=W
      end;

      if SMDocument.HWindowFocused then
        Tag:=1
      else
      if SMDocument.VWindowFocused then
        Tag:=2
      else begin
        Exit;
      end;

      FLastSelected:=nil;
      OldState:=aDataModel.State;
      OldSelectState:=OldState and dmfSelecting;
      aDataModel.State:=aDataModel.State or dmfSelecting;
      try
      SelectByFrame(SMDocument, ShiftState, FlagSet, Tag,
             MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
      finally
        aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
      end;
      LastSelectedE:=IDMElement(FLastSelected);
      DMDocument.Server.SelectionChanged(LastSelectedE);
      Drag(SMDocument);
      CurrentStep:=0;
    end;
  end;

  inherited;
end;

function TSelectLineOperation.GetFlagSet: integer;
begin
  Result:=sofVLine
end;

procedure TSelectLineOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
    Hint:=rsSelectAction;
    if (DM_GetKeyState(VK_MENU)<0)then
      ACursor:=CR_HAND_HLINE
    else
      ACursor:=CR_HAND_VAREA
 end;

procedure TSelectLineOperation.SelectAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
begin
  SelectHLineAtPoint(SMDocument, ShiftState, FlagSet, nil)
end;

procedure TSelectLineOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer;
        Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double);
begin
  SelectHLineByFrame(SMDocument, ShiftState, FlagSet,
        Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
end;

procedure TSMSelectOperation.SelectAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
begin
end;

procedure TSMSelectOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer;
  MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
begin
end;

constructor TSMSelectOperation.Create(aOperationCode: integer;
  const aOperationManager: TCustomSMDocument);
begin
  inherited;
  FSelectedElementList:=TList.Create;
  FLastSelectOperationCode:=ord(socVolume)
end;

destructor TSMSelectOperation.Destroy;
begin
  inherited;
  FSelectedElementList.Free;
end;

procedure TSMSelectOperation.SelectHAreaAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
var
  j, OldState, OldSelectState:integer;
  TMPArea, aArea:IArea;
  aVolume:IVolume;
  aAreaE, aLineE, aImageRectE, aCircleE:IDMElement;
  TMPAreaP, aAreaP:IPolyline;
  DMDocument:IDMDocument;
  SpatialModel2:ISpatialModel2;
  SelectedAreaList:TList;
  Painter:IPainter;
  aAreaS:ISpatialElement;
  aDataModel:IDataModel;

  function GetVolumeBottom(const aVolume:IVolume):IDMElement;
  var
    j:integer;
    BArea:IArea;
    aAreaS:ISpatialElement;
  begin
    Result:=nil;
    j:=0;
    while j<aVolume.BottomAreas.Count do begin
      BArea:=aVolume.BottomAreas.Item[j] as IArea;
      if BArea.ProjectionContainsPoint(X0, Y0, 0) then
        Break
      else
        inc(j)
    end;
    if j<aVolume.BottomAreas.Count then begin
      aArea:=BArea;
      aAreaS:=aArea as ISpatialElement;
      if aAreaS.Layer.Selectable then
        Result:=aArea as IDMElement
    end;
  end;
begin
  DMDocument:=SMDocument as IDMDocument;
  aDataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel2:=aDataModel as ISpatialModel2;
  Painter:=SMDocument.PainterU as IPainter;

  SelectedAreaList:=SMDocument.SelectedAreaList;

  TMPArea:=IArea(FTMPArea);
  aImageRectE:=IDMElement(FImageRect);
  aCircleE:=IDMElement(FCircle);

  if TMPArea=nil then begin
    aVolume:=SpatialModel2.GetVolumeContaining(X0, Y0, Z0);
    if aVolume<>nil then
      aAreaE:=GetVolumeBottom(aVolume)
    else
      aAreaE:=nil
  end else begin // if FTMPArea<>nil
    aArea:=SpatialModel2.GetAreaEqualTo(TMPArea);
    aAreaS:=aArea as ISpatialElement;
    if (aArea<>nil) and
       aAreaS.Layer.Selectable then
      aAreaE:=aArea as IDMElement
    else begin
      aVolume:=SpatialModel2.GetVolumeContaining(X0, Y0, Z0);
      if aVolume<>nil then begin
        aAreaE:=GetVolumeBottom(aVolume);
        aArea:=aAreaE as IArea;
        if (aArea<>nil) and
           (aArea.MinZ=TMPArea.MinZ) then
          aAreaE:=nil;
      end else
        aAreaE:=nil
    end;
  end; // if FTMPArea<>nil

  if (sCtrl and ShiftState)=0 then begin
    if aCircleE<>nil then
      DMDocument.ClearSelection(aCircleE)
    else
    if aImageRectE<>nil then
      DMDocument.ClearSelection(aImageRectE)
    else
      DMDocument.ClearSelection(nil);
  end;

  TMPAreaP:=TMPArea as IPolyline;

  if aAreaE<>nil then begin
    if FSelectedElementList.IndexOf(pointer(aAreaE))=-1 then begin
      aAreaE.Selected:=True;
      FLastSelected:=pointer(aAreaE);
      FLastSelectOperationCode:=ord(socHArea);
    end else
    if (sCtrl and ShiftState)<>0 then begin
      aAreaE.Selected:=False;
      FLastSelected:=pointer(aAreaE);
      FLastSelectOperationCode:=ord(socHArea);
    end;

    j:=SelectedAreaList.IndexOf(pointer(aAreaE));
    if j<>-1 then
      SelectedAreaList.Delete(j)
    else
      SelectedAreaList.Add(pointer(aAreaE));
    if not aAreaE.Selected then
      aAreaE.Draw(Painter, 0)
  end else // if aArea<>nil
  if TMPAreaP<>nil  then begin
    OldState:=aDataModel.State;
    OldSelectState:=OldState and dmfSelecting;
    aDataModel.State:=OldState or dmfSelecting;
    try
    aLineE:=nil;
    for j:=0 to TMPAreaP.Lines.Count-1 do begin
      aLineE:=TMPAreaP.Lines.Item[j];
      if FSelectedElementList.IndexOf(pointer(aLineE))=-1 then begin
        aLineE.Selected:=True;
        FLastSelectOperationCode:=ord(socHLine);
      end else
      if (sCtrl and ShiftState)<>0 then begin
        aLineE.Selected:=False;
        FLastSelectOperationCode:=ord(socHLine);
      end;
      FLastSelected:=pointer(aLineE);
    end;

    j:=0;
    while j<SelectedAreaList.Count do begin
      aAreaE:=IDMElement(SelectedAreaList[j]);
      aAreaP:=aAreaE as IPolyline;
      if (aAreaP.Lines as IDMCollection2).IsEqualTo(TMPAreaP.Lines) then
        Break
      else
        inc(j);
    end;
    if j<SelectedAreaList.Count then
      SelectedAreaList.Delete(j)
    else
      SelectedAreaList.Add(pointer(TMPArea as IDMElement));

    finally
      aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
    end;
    DMDocument.Server.SelectionChanged(aLineE);
  end; // if TMPAreaP<>nil
end;

procedure TSMSelectOperation.SelectHAreaByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer; MaxX,
  MinX, MaxY, MinY, MaxZ, MinZ: double);
  var
    Painter:IPainter;
    View:IView;
    SelectedAreaList:TList;

  procedure DoSelectByFrame(const AreaE:IDMElement; Tag:integer;
                     MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
  var
    m:integer;
    AreaP:IPolyline;
    AreaS:ISpatialElement;
    aLineE:IDMElement;
    aLine:ILine;
    aX0, aY0, aZ0, aX1, aY1, aZ1:double;
    j:integer;
  begin
    AreaP:=AreaE as IPolyline;
    AreaS:=AreaE as ISpatialElement;
    if not AreaS.Layer.Selectable then Exit;
    for m:=0 to AreaP.Lines.Count-1 do begin
      aLineE:=AreaP.Lines.Item[m];
      aLine:=aLineE as ILine;

      aX0:=aLine.C0.X;
      aY0:=aLine.C0.Y;
      aZ0:=aLine.C0.Z;
      aX1:=aLine.C1.X;
      aY1:=aLine.C1.Y;
      aZ1:=aLine.C1.Z;
      if View.PointIsVisible(aX0,aY0,aZ0,1) and
         View.PointIsVisible(aX1,aY1,aZ1,1) and
         View.PointIsVisible(aX0,aY0,aZ0,2) and
         View.PointIsVisible(aX1,aY1,aZ1,2) then
        case Tag of
        1:if not
           ((aX0<=MaxX) and
            (aX0>=MinX) and
            (aY0<=MaxY) and
            (aY0>=MinY) and
            (aX1<=MaxX) and
            (aX1>=MinX) and
            (aY1<=MaxY) and
            (aY1>=MinY)) then Exit;
        2:if not
           ((aX0<=MaxX) and
            (aX0>=MinX) and
            (aZ0<=MaxZ) and
            (aZ0>=MinZ) and
            (aX1<=MaxX) and
            (aX1>=MinX) and
            (aZ1<=MaxZ) and
            (aZ1>=MinZ)) then Exit;
        end
      else
        Exit;
    end;  //for m:=0 to AreaP.Lines.Count-1

    AreaE.Selected:=not AreaE.Selected;
    FLastSelected:=pointer(AreaE);

    j:=SelectedAreaList.IndexOf(pointer(AreaE));
    if j<>-1 then
      SelectedAreaList.Delete(j)
    else
      SelectedAreaList.Add(pointer(AreaE));

  end;

var
  j:integer;
  aAreaE:IDMElement;
  aArea:IArea;
  DMDocument:IDMDocument;
  SpatialModel2:ISpatialModel2;
begin
  DMDocument:=SMDocument as IDMDocument;
  SpatialModel2:=DMDocument.DataModel as ISpatialModel2;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;

  SelectedAreaList:=SMDocument.SelectedAreaList;

  for j:=0 to SpatialModel2.Areas.Count-1 do begin
    aAreaE:=SpatialModel2.Areas.Item[j];
    aArea:=aAreaE as IArea;
    if not aArea.IsVertical then
      DoSelectByFrame(aAreaE, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  end;
end;

procedure TSMSelectOperation.SelectHLineAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer; const aLineE:IDMElement);
var
  i:integer;
  DMDocument:IDMDocument;
  LineE, aParent:IDMElement;
  CheckLineFlag:boolean;
begin
  DMDocument:=SMDocument as IDMDocument;

  CheckLineFlag:=True;
  if ((sofOutline and FlagSet)<>0) then
    CheckLineFlag:=False;

  if CheckLineFlag then begin
    if aLineE=nil then
      LineE:=SMDocument.NearestLine
    else
      LineE:=aLineE;
  end else
    LineE:=nil;

  if LineE<>nil then begin
    if LineE.Parents.Count=0 then begin
      if (sCtrl and ShiftState)=0 then
       DMDocument.ClearSelection(LineE);
      LineE.Selected:=not LineE.Selected;
      FLastSelectOperationCode:=ord(socHLine);
    end else
    if (DMDocument.SelectionCount>0) and
       ((DMDocument.SelectionItem[0] as IDMElement).ClassID=_Line) then begin
      if (sCtrl and ShiftState)=0 then
       DMDocument.ClearSelection(LineE);
      LineE.Selected:=not LineE.Selected;
      FLastSelectOperationCode:=ord(socHLine);
    end else begin
      i:=0;
      while i<LineE.Parents.Count do begin
        aParent:=LineE.Parents.Item[i];
        if ((aParent.ClassID=_Polyline) or
           (aParent.ClassID=_LineGroup)) and
           (not aParent.Selected) then begin
          if (sCtrl and ShiftState)=0 then
            DMDocument.ClearSelection(LineE);
          aParent.Selected:=not aParent.Selected;
          FLastSelectOperationCode:=ord(socHLine);
          Break;
        end else
          inc(i)
      end;
      if i=LineE.Parents.Count then begin
        if (sCtrl and ShiftState)=0 then
          DMDocument.ClearSelection(LineE);
        LineE.Selected:=not LineE.Selected;
        FLastSelectOperationCode:=ord(socHLine);
      end;
    end;
  end else
  if (sofVolume and FlagSet)<>0 then
    SelectVolumeAtPoint(SMDocument, ShiftState, FlagSet)
  else
  if (sofHArea and FlagSet)<>0 then begin
    SelectClosedPolylineAtPoint(SMDocument, ShiftState, FlagSet);
    SelectHAreaAtPoint(SMDocument, ShiftState, FlagSet)
  end;
end;

procedure TSMSelectOperation.SelectHLineByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer; MaxX,
  MinX, MaxY, MinY, MaxZ, MinZ: double);
var
  View:IView;

  procedure DoSelectByFrame(LineE:IDMElement; Tag:integer;
            MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double);
  var
    aX0, aY0, aZ0, aX1, aY1, aZ1:double;
    LineS:ISpatialElement;
    Line:ILine;
  begin
    LineS:=LineE as ISpatialElement;
    Line:=LineE as ILine;
    if not LineS.Layer.Selectable then Exit;
    aX0:=Line.C0.X;
    aY0:=Line.C0.Y;
    aZ0:=Line.C0.Z;
    aX1:=Line.C1.X;
    aY1:=Line.C1.Y;
    aZ1:=Line.C1.Z;
{
    if View.PointIsVisible(aX0,aY0,aZ0,1) and
       (View.PointIsVisible(aX1,aY1,aZ1,1) or
        ((aX0=aX1) and (aY0=aY1))) and
       View.PointIsVisible(aX0,aY0,aZ0,2) and
       (View.PointIsVisible(aX1,aY1,aZ1,2) or
        ((aX0=aX1) and (aY0=aY1))) then
}
    if View.PointIsVisible(aX0,aY0,aZ0,1) and
       View.PointIsVisible(aX1,aY1,aZ1,1) and
       View.PointIsVisible(aX0,aY0,aZ0,2) and
       View.PointIsVisible(aX1,aY1,aZ1,2) then
      case Tag of
      1:if not
          ((aX0<=MaxX) and
           (aX0>=MinX) and
           (aY0<=MaxY) and
           (aY0>=MinY) and
           (aX1<=MaxX) and
           (aX1>=MinX) and
           (aY1<=MaxY) and
           (aY1>=MinY)) then
          Exit;
      2:if not
           ((aX0<=MaxX) and
            (aX0>=MinX) and
            (aZ0<=MaxZ) and
            (aZ0>=MinZ) and
            (aX1<=MaxX) and
            (aX1>=MinX) and
            (aZ1<=MaxZ) and
            (aZ1>=MinZ)) then
          Exit;
      end
    else
      Exit;

    LineE.Selected:=not LineE.Selected;
    FLastSelected:=pointer(LineE);
  end;

var
  j:integer;
  LineE:IDMElement;
  DMDocument:IDMDocument;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
begin
  DMDocument:=SMDocument as IDMDocument;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;

  for j:=0 to SpatialModel.Lines.Count-1 do begin
    LineE:=SpatialModel.Lines.Item[j];
    DoSelectByFrame(LineE, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  end;
  for j:=0 to SpatialModel.CurvedLines.Count-1 do begin
    LineE:=SpatialModel.CurvedLines.Item[j];
    DoSelectByFrame(LineE, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  end;
end;

procedure TSMSelectOperation.SelectNodeAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer; const aNodeE:IDMElement);
var
  NodeE, aElement:IDMElement;
  DMDocument:IDMDocument;
  NodeS:ISpatialElement;
  Painter:IPainter;
begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;

  if aNodeE=nil then
    NodeE:=SMDocument.NearestNode
  else
    NodeE:=aNodeE;

  if (sCtrl and ShiftState)=0 then begin
    aElement:=GetNodeElement(NodeE, ShiftState);
    if aElement<>nil then
      DMDocument.ClearSelection(aElement);
  end;
  
  NodeS:=NodeE as ISpatialElement;
  if (NodeS<>nil) and
      NodeS.Layer.Selectable then
    DoSelectNode(NodeE, Painter, ShiftState)
  else
  if (sofVArea and FlagSet)<>0 then
    SelectVAreaAtPoint(SMDocument, ShiftState, FlagSet)
end;

function TSelectCoordNodeOperation.GetFlagSet: integer;
begin
  Result:=sofNode
end;

procedure TSelectCoordNodeOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
    Hint:=rsSelectAction;
    if (DM_GetKeyState(VK_MENU)<0)then
      ACursor:=CR_HAND_ARROW
    else
      ACursor:=CR_HAND_VLine
end;

procedure TSelectCoordNodeOperation.SelectAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
begin
  SelectNodeAtPoint(SMDocument, ShiftState, FlagSet, nil)
end;

procedure TSelectCoordNodeOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag:integer;
   MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
begin
  SelectNodeByFrame(SMDocument, ShiftState, FlagSet,
        Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
end;

procedure TSMSelectOperation.SelectNodeByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer; MaxX,
  MinX, MaxY, MinY, MaxZ, MinZ: double);
var
  Painter:IPainter;
  View:IView;

  procedure DoSelectByFrame(NodeE:IDMElement; Tag:integer;
            MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double);
  var
    aX0, aY0, aZ0:double;
    NodeS:ISpatialElement;
    Node:ICoordNode;
  begin
    NodeS:=NodeE as ISpatialElement;
    Node:=NodeE as ICoordNode;
    if not NodeS.Layer.Selectable then Exit;
    aX0:=Node.X;
    aY0:=Node.Y;
    aZ0:=Node.Z;
    if View.PointIsVisible(aX0,aY0,aZ0,1) and
       View.PointIsVisible(aX0,aY0,aZ0,2) then
      case Tag of
      1:if not
          ((aX0<=MaxX) and
           (aX0>=MinX) and
           (aY0<=MaxY) and
           (aY0>=MinY)) then
          Exit;
      2:if not
          ((aX0<=MaxX) and
           (aX0>=MinX) and
           (aZ0<=MaxZ) and
           (aZ0>=MinZ)) then
          Exit;
      end
    else
      Exit;

    DoSelectNode(NodeE, Painter, ShiftState);
  end;

var
  j:integer;
  SpatialModel:ISpatialModel;
  DMDocument:IDMDocument;
  NodeE:IDMElement;
begin
  DMDocument:=SMDocument as IDMDocument;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;

  for j:=0 to SpatialModel.CoordNodes.Count-1 do begin
    NodeE:=SpatialModel.CoordNodes.Item[j];
    DoSelectByFrame(NodeE, Tag,
            MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
  end;
end;

procedure TSMSelectOperation.SelectVAreaAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
var
  LineE, AreaE, SubElement:IDMElement;
  Line:ILine;
  Area:IArea;
  AreaS:ISpatialElement;
  DMDocument:IDMDocument;
begin
  if (sAlt and ShiftState)<>0 then begin
    if (sofHLine+FlagSet)<>0 then
      SelectHLineAtPoint(SMDocument, ShiftState, FlagSet, nil)
  end else begin
    DMDocument:=SMDocument as IDMDocument;

    LineE:=SMDocument.NearestLine;
    if LineE<>nil then begin
      Line:=LineE as ILine;
      Area:=Line.GetVerticalArea(bdUp);
      AreaS:=Area as  ISpatialElement;
      if (Area<>nil) and
         AreaS.Layer.Selectable then
        AreaE:=Area as IDMElement
      else
        AreaE:=nil;

      if AreaE<>nil then begin
        SubElement:=SMDocument.GetSubElement;
        if SubElement=nil then begin
          if (sCtrl and ShiftState)=0 then
            DMDocument.ClearSelection(AreaE);
          AreaE.Selected:=not AreaE.Selected
        end else begin
          if (sCtrl and ShiftState)=0 then
            DMDocument.ClearSelection(SubElement);
          SubElement.Selected:=not SubElement.Selected;
        end;
        FLastSelectOperationCode:=ord(socVArea);
      end else begin
        if (sofHLine+FlagSet)<>0 then
          SelectHLineAtPoint(SMDocument, ShiftState, FlagSet, LineE);
      end
    end else
    if (sofVolume and FlagSet)<>0 then
      SelectVolumeAtPoint(SMDocument, ShiftState, FlagSet)
    else
    if (sCtrl and ShiftState)=0 then
      DMDocument.ClearSelection(nil);
  end;
end;

procedure TSMSelectOperation.SelectVAreaByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer; MaxX,
  MinX, MaxY, MinY, MaxZ, MinZ: double);
var
  Painter:IPainter;
  View:IView;

  procedure DoSelectByFrame(AreaE:IDMElement; Tag:integer;
            MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double);
  var
    aX0, aY0, aZ0, aX1, aY1, aZ1:double;
    AreaS:ISpatialElement;
    Area:IArea;
    C0, C1:ICoordNode;
  begin
    Area:=AreaE as IArea;
    if not Area.IsVertical then Exit;
    AreaS:=AreaE as ISpatialElement;
    if not AreaS.Layer.Selectable then Exit;
    C0:=Area.C0;
    C1:=Area.C1;
    if C0=nil then Exit;
    if C1=nil then Exit;
    aX0:=C0.X;
    aY0:=C0.Y;
    aZ0:=C0.Z;
    aX1:=C1.X;
    aY1:=C1.Y;
    aZ1:=C1.Z;

    if View.PointIsVisible(aX0,aY0,aZ0,1) and
       View.PointIsVisible(aX1,aY1,aZ1,1) and
       View.PointIsVisible(aX0,aY0,aZ0,2) and
       View.PointIsVisible(aX1,aY1,aZ1,2) then
      case Tag of
      1:if not
          ((aX0<=MaxX) and
           (aX0>=MinX) and
           (aY0<=MaxY) and
           (aY0>=MinY) and
           (aX1<=MaxX) and
           (aX1>=MinX) and
           (aY1<=MaxY) and
           (aY1>=MinY)) then
          Exit;
      2:if not
          ((aX0<=MaxX) and
           (aX0>=MinX) and
           (aZ0<=MaxZ) and
           (aZ0>=MinZ) and
           (aX1<=MaxX) and
           (aX1>=MinX) and
           (aZ1<=MaxZ) and
           (aZ1>=MinZ)) then
         Exit;
      end
    else
      Exit;

    AreaE.Selected:=not AreaE.Selected;
    FLastSelected:=pointer(AreaE);
  end;

var
  j:integer;
  AreaE:IDMElement;
  DMDocument:IDMDocument;
  SpatialModel2:ISpatialModel2;
begin
  if (sAlt and ShiftState)<>0 then
    SelectHLineByFrame(SMDocument, ShiftState, FlagSet,
                      Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
  else begin
    DMDocument:=SMDocument as IDMDocument;
    SpatialModel2:=DMDocument.DataModel as ISpatialModel2;
    Painter:=SMDocument.PainterU as IPainter;
    View:=Painter.ViewU as IView;

    for j:=0 to SpatialModel2.Areas.Count-1 do begin
      AreaE:=SpatialModel2.Areas.Item[j];
      DoSelectByFrame(AreaE, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
    end;
    if FLastSelected=nil then
      SelectHLineByFrame(SMDocument, ShiftState, FlagSet,
                      Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
  end;
end;

procedure TSMSelectOperation.SelectVLineAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
var
  NodeE, LineE, aAreaE, SubElement:IDMElement;
  DMDocument:IDMDocument;
  SMOperationManager:ISMOperationManager;
  Node:ICoordNode;
  Line:ILine;
  LineS:ISpatialElement;
  aArea:IArea;
  j:integer;
  C0, C1:ICoordNode;
  X0, Y0, X1, Y1, MinDistance, CurrX, CurrY:double;
  Painter:IPainter;
  View:IView;
begin
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;

  if (sAlt and ShiftState)<>0 then begin
    if (sofNode+FlagSet)<>0 then
      SelectNodeAtPoint(SMDocument, ShiftState, FlagSet, nil)
  end else begin
    DMDocument:=SMDocument as IDMDocument;
    SMOperationManager:=DMDocument as ISMOperationManager;

    NodeE:=SMDocument.NearestNode;
    if NodeE<>nil then begin
      Node:=NodeE as ICoordNode;
      Line:=Node.GetVerticalLine(bdUp);
      LineS:=Line as ISpatialElement;
      if (LineS<>nil) and
          LineS.Layer.Selectable then
        LineE:=Line as IDMElement
      else
        LineE:=nil;

      if LineE<>nil then begin
        aAreaE:=nil;
        j:=0;
        while j<LineE.Parents.Count do begin
          aAreaE:=LineE.Parents.Item[j];
          if aAreaE.QueryInterface(IArea, aArea)=0 then begin
            C0:=aArea.C0;
            C1:=aArea.C1;
            if (C0<>nil) and
               (C1<>nil) then begin
              X0:=C0.X;
              Y0:=C0.Y;
              X1:=C1.X;
              Y1:=C1.Y;
              CurrX:=SMDocument.CurrX;
              CurrY:=SMDocument.CurrY;
              MinDistance:=SMOperationManager.SnapDistance*View.RevScaleX;
              if (sqrt(sqr(CurrX-X0)+sqr(CurrY-Y0))<MinDistance) and
                 (sqrt(sqr(CurrX-X1)+sqr(CurrY-Y1))<MinDistance) then
                Break
              else
                inc(j);
            end else
              inc(j)
          end else
            inc(j);
        end;
        if j<LineE.Parents.Count then begin
          if (sCtrl and ShiftState)=0 then
            DMDocument.ClearSelection(aAreaE);
          aAreaE.Selected:=not aAreaE.Selected;
          FLastSelectOperationCode:=ord(socVArea);
        end else begin
          if (sCtrl and ShiftState)=0 then
            DMDocument.ClearSelection(LineE);
          LineE.Selected:=not LineE.Selected;
          FLastSelectOperationCode:=ord(socVLine);
        end;
      end else begin
        if (sofNode+FlagSet)<>0 then
          SelectNodeAtPoint(SMDocument, ShiftState, FlagSet, NodeE)
      end;
    end else begin
      SubElement:=SMDocument.GetSubElement;
      if SubElement=nil then begin
        if (sofVArea and FlagSet)<>0 then
          SelectVAreaAtPoint(SMDocument, ShiftState, FlagSet)
        else
          DMDocument.ClearSelection(nil);
      end else begin
        if (sCtrl and ShiftState)=0 then
          DMDocument.ClearSelection(SubElement);
        SubElement.Selected:=not SubElement.Selected;
      end;
    end;
  end;
end;

procedure TSMSelectOperation.SelectVLineByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer; MaxX,
  MinX, MaxY, MinY, MaxZ, MinZ: double);
var
  View:IView;

  procedure DoSelectByFrame(NodeE:IDMElement; Tag:integer;
            MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double);
  var
    aX0, aY0, aZ0:double;
    LineS:ISpatialElement;
    Node:ICoordNode;
    Line:ILine;
    LineE:IDMElement;
  begin
    Node:=NodeE as ICoordNode;
    aX0:=Node.X;
    aY0:=Node.Y;
    aZ0:=Node.Z;
    if View.PointIsVisible(aX0,aY0,aZ0,1) and
       View.PointIsVisible(aX0,aY0,aZ0,2) then begin
      if (aX0<=MaxX) and
        (aX0>=MinX) and
        (aY0<=MaxY) and
        (aY0>=MinY) then begin
         Line:=Node.GetVerticalLine(bdUp);
         LineS:=Line as ISpatialElement;
         if (LineS<>nil) and
            (LineS.Layer.Selectable) then begin
           LineE:=Line as IDMElement;
           LineE.Selected:=not LineE.Selected;
           FLastSelected:=pointer(LineE);
         end;
      end;
    end;
  end;

var
  Painter:IPainter;
  DMDocument:IDMDocument;
  SpatialModel:ISpatialModel;
  j:integer;
  NodeE:IDMElement;
begin
  if (sAlt and ShiftState)<>0 then
    SelectNodeByFrame(SMDocument, ShiftState, FlagSet, Tag,
       MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
  else begin
    Painter:=SMDocument.PainterU as IPainter;
    View:=Painter.ViewU as IView;
    DMDocument:=SMDocument as IDMDocument;
    SpatialModel:=DMDocument.DataModel as ISpatialModel;

    for j:=0 to SpatialModel.CoordNodes.Count-1 do begin
      NodeE:=SpatialModel.CoordNodes.Item[j];
      DoSelectByFrame(NodeE, Tag,
            MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
    end;

    if FLastSelected=nil then
      SelectNodeByFrame(SMDocument, ShiftState, FlagSet, Tag,
       MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
  end;
end;

procedure TSMSelectOperation.SelectVolumeAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
var
  aVolume:IVolume;
  aVolumeE, aImageRectE, aCircleE:IDMElement;
  aVolumeS:ISpatialElement;
  DMDocument:IDMDocument;
  aDataModel:IDataModel;
  SpatialModel2:ISpatialModel2;
  j:integer;
  TMPArea:IArea;
  Server:IDataModelServer;

begin
  FLastSelected:=nil;

  DMDocument:=SMDocument as IDMDocument;
  aDataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel2:=aDataModel as ISpatialModel2;

  FSelectedElementList.Clear;
  for j:=0 to DMDocument.SelectionCount-1 do
    FSelectedElementList.Add(pointer(DMDocument.SelectionItem[j] as IDMElement));

  X0:=SMDocument.CurrX;
  Y0:=SMDocument.CurrY;
  Z0:=SMDocument.CurrZ;

  aDataModel.State:=aDataModel.State or dmfCommiting;
  TMPArea:=SpatialModel2.BuildAreaSurrounding(X0, Y0, Z0);
  aDataModel.State:=aDataModel.State and not dmfCommiting;

  FTMPArea:=pointer(TMPArea);

  if (sAlt and ShiftState)<>0 then begin
    if (sofHArea+FlagSet)<>0 then
      SelectHAreaAtPoint(SMDocument, ShiftState, FlagSet)
  end else begin

    aVolume:=SpatialModel2.GetVolumeContaining(X0, Y0, Z0);
    aVolumeS:=aVolume as ISpatialElement;
    if (aVolume<>nil) and
      aVolumeS.Layer.Selectable then begin
      aVolumeE:=aVolume as IDMElement;
    end else
      aVolumeE:=nil;
      
    if aVolumeE=nil then begin
      aImageRectE:=SMDocument.NearestImage;
      aCircleE:=SMDocument.NearestCircle;
    end else begin
      aImageRectE:=nil;
      aCircleE:=nil;
    end;

    FImageRect:=pointer(aImageRectE);
    FCircle:=pointer(aCircleE);

    if (sCtrl and ShiftState)=0 then begin
      if aVolumeE<>nil then
        DMDocument.ClearSelection(aVolumeE)
      else
      if aCircleE<>nil then
        DMDocument.ClearSelection(aCircleE)
      else
      if aImageRectE<>nil then
        DMDocument.ClearSelection(aImageRectE)
      else
        DMDocument.ClearSelection(nil)
    end;

    if aVolumeE=nil then begin
       if (sofHArea+FlagSet)<>0 then
      SelectHAreaAtPoint(SMDocument, ShiftState, FlagSet)
    end else begin
      aVolumeE.Selected:=not aVolumeE.Selected;
      FLastSelectOperationCode:=ord(socVolume);
      FLastSelected:=pointer(aVolumeE);
    end;
  end;

  if (FLastSelected=nil) then begin
    if (aCircleE<>nil) then begin
      aCircleE.Selected:=not aCircleE.Selected;
      FLastSelectOperationCode:=ord(socVolume);
    end else
    if (aImageRectE<>nil) then begin
      aImageRectE.Selected:=not aImageRectE.Selected;
      FLastSelectOperationCode:=ord(socImage);
    end;
    Server:=DMDocument.Server as IDataModelServer;
    Server.RefreshDocument(rfFrontBack);
  end;
end;

procedure TSMSelectOperation.SelectVolumeByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer; MaxX,
  MinX, MaxY, MinY, MaxZ, MinZ: double);
var
  Painter:IPainter;
  View:IView;
  aCollection:IDMCollection;
  SpatialModel2:ISpatialModel2;

  procedure DoSelectCircleByFrame(const aCircleE:IDMElement; Tag:integer;
                     MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
  var
    aCircleS:ISpatialElement;
    aCircle:ICircle;
    aX0, aY0, aZ0:double;
  begin
    aCircleS:=aCircleE as ISpatialElement;
    if not aCircleS.Layer.Selectable then Exit;

    aCircle:=aCircleE as ICircle;

    aX0:=aCircle.X;
    aY0:=aCircle.Y;
    aZ0:=aCircle.Z;
    if View.PointIsVisible(aX0,aY0,aZ0,1) and
       View.PointIsVisible(aX0,aY0,aZ0,2) then
      case Tag of
      1:if not
         ((aX0<=MaxX) and
          (aX0>=MinX) and
          (aY0<=MaxY) and
          (aY0>=MinY)) then Exit;
      2:if not
         ((aX0<=MaxX) and
          (aX0>=MinX) and
          (aZ0<=MaxZ) and
          (aZ0>=MinZ)) then Exit;
      end
    else
      Exit;

    aCircleE.Selected:=not aCircleE.Selected;
    FLastSelected:=pointer(aCircleE);
  end;

  procedure DoSelectLineByFrame(const aLineE:IDMElement; Tag:integer;
                     MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
  var
    aLineS:ISpatialElement;
    aLine:ILine;
    aX0, aY0, aZ0, aX1, aY1, aZ1:double;
  begin
    aLineS:=aLineE as ISpatialElement;
    if not aLineS.Layer.Selectable then Exit;

    aLine:=aLineE as ILine;

    aX0:=aLine.C0.X;
    aY0:=aLine.C0.Y;
    aZ0:=aLine.C0.Z;
    aX1:=aLine.C1.X;
    aY1:=aLine.C1.Y;
    aZ1:=aLine.C1.Z;
    if View.PointIsVisible(aX0,aY0,aZ0,1) and
       View.PointIsVisible(aX1,aY1,aZ1,1) and
       View.PointIsVisible(aX0,aY0,aZ0,2) and
       View.PointIsVisible(aX1,aY1,aZ1,2) then
      case Tag of
      1:if not
         ((aX0<=MaxX) and
          (aX0>=MinX) and
          (aY0<=MaxY) and
          (aY0>=MinY) and
          (aX1<=MaxX) and
          (aX1>=MinX) and
          (aY1<=MaxY) and
          (aY1>=MinY)) then Exit;
      2:if not
         ((aX0<=MaxX) and
          (aX0>=MinX) and
          (aZ0<=MaxZ) and
          (aZ0>=MinZ) and
          (aX1<=MaxX) and
          (aX1>=MinX) and
          (aZ1<=MaxZ) and
          (aZ1>=MinZ)) then Exit;
      end
    else
      Exit;

    aLineE.Selected:=not aLineE.Selected;
    FLastSelected:=pointer(aLineE);
  end;


  procedure DoSelectByFrame(const VolumeE:IDMElement; Tag:integer;
                     MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
  var
    m:integer;
    VolumeS:ISpatialElement;
    Volume:IVolume;
    aLineE:IDMElement;
    aLine:ILine;
    aX0, aY0, aZ0, aX1, aY1, aZ1:double;
  begin
    VolumeS:=VolumeE as ISpatialElement;
    Volume:=VolumeE as IVolume;
    if not VolumeS.Layer.Selectable then Exit;
    (aCollection as IDMCollection2).Clear;
    SpatialModel2.MakeVolumeOutline(Volume, aCollection);
    for m:=0 to aCollection.Count-1 do begin
      aLineE:=aCollection.Item[m];
      aLine:=aLineE as ILine;

      aX0:=aLine.C0.X;
      aY0:=aLine.C0.Y;
      aZ0:=aLine.C0.Z;
      aX1:=aLine.C1.X;
      aY1:=aLine.C1.Y;
      aZ1:=aLine.C1.Z;
      if View.PointIsVisible(aX0,aY0,aZ0,1) and
         (View.PointIsVisible(aX1,aY1,aZ1,1) or
          ((aX0=aX1) and (aY0=aY1))) and
         View.PointIsVisible(aX0,aY0,aZ0,2) and
         (View.PointIsVisible(aX1,aY1,aZ1,2) or
          ((aX0=aX1) and (aY0=aY1))) then
        case Tag of
        1:if not
           ((aX0<=MaxX) and
            (aX0>=MinX) and
            (aY0<=MaxY) and
            (aY0>=MinY) and
            (aX1<=MaxX) and
            (aX1>=MinX) and
            (aY1<=MaxY) and
            (aY1>=MinY)) then Exit;
        2:if not
           ((aX0<=MaxX) and
            (aX0>=MinX) and
            (aZ0<=MaxZ) and
            (aZ0>=MinZ) and
            (aX1<=MaxX) and
            (aX1>=MinX) and
            (aZ1<=MaxZ) and
            (aZ1>=MinZ)) then Exit;
        end
      else
        Exit;
    end;  //for m:=0 to AreaP.Lines.Count-1

    VolumeE.Selected:=not VolumeE.Selected;
    FLastSelected:=pointer(VolumeE);
  end;

var
  j:integer;
  aVolumeE, aImageRectE, aCircleE:IDMElement;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
begin
  if (sAlt and ShiftState)<>0 then
    SelectHAreaByFrame(SMDocument, ShiftState, FlagSet, Tag,
       MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
  else begin
    DMDocument:=SMDocument as IDMDocument;
    DataModel:=DMDocument.DataModel as IDataModel;
    SpatialModel:=DataModel as ISpatialModel;
    SpatialModel2:=DataModel as ISpatialModel2;
    Painter:=SMDocument.PainterU as IPainter;
    View:=Painter.ViewU as IView;

    aCollection:=DataModel.CreateCollection(-1, nil);

    for j:=0 to SpatialModel2.Volumes.Count-1 do begin
      aVolumeE:=SpatialModel2.Volumes.Item[j];
      DoSelectByFrame(aVolumeE, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
    end;
    (aCollection as IDMCollection2).Clear;

    if FLastSelected=nil then
      SelectHAreaByFrame(SMDocument, ShiftState, FlagSet, Tag,
         MaxX, MinX, MaxY, MinY, MaxZ, MinZ);

    if FLastSelected<>nil then Exit;

    for j:=0 to SpatialModel.Circles.Count-1 do begin
      aCircleE:=SpatialModel.Circles.Item[j];
      DoSelectCircleByFrame(aCircleE, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
    end;
    if FLastSelected=nil then begin
      for j:=0 to SpatialModel.ImageRects.Count-1 do begin
        aImageRectE:=SpatialModel.ImageRects.Item[j];
        DoSelectLineByFrame(aImageRectE, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
      end;
    end;
    if FLastSelected<>nil then begin
      Server:=DMDocument.Server as IDataModelServer;
      Server.RefreshDocument(rfFrontBack);
    end;
  end;
end;

procedure TSMSelectOperation.DoSelectNode(const NodeE: IDMElement;
  const Painter: IPainter; ShiftState: integer);
var
  aElement:IDMElement;
begin
  aElement:=GetNodeElement(NodeE, ShiftState);
  aElement.Selected:=not aElement.Selected;
  FLastSelected:=pointer(aElement);
  FLastSelectOperationCode:=ord(socNode);
  if not aElement.Selected then begin
    if aElement.ClassID=_CoordNode then
      aElement.Draw(Painter, -1)
  end;
end;

function TSMSelectOperation.GetNodeElement(const NodeE: IDMElement;
  ShiftState: integer): IDMElement;
var
  aLineE:IDMElement;
  Node:ICoordNode;
  j:integer;
  aLine:ILine;
begin
  if NodeE=nil then
    Result:=nil
  else
  if (NodeE.Ref<>nil) and
     (NodeE.Ref.SpatialElement=NodeE) then
    Result:=NodeE.Ref
  else
  if (sAlt and ShiftState)=0 then begin
    Node:=NodeE as ICoordNode;
    aLineE:=nil;
    j:=0;
    while j<Node.Lines.Count do begin
      aLineE:=Node.Lines.Item[j];
      aLine:=aLineE as ILine;
      if (aLineE.Ref<>nil) and
         (aLine.C0=Node) then
        Break
      else
        inc(j)
    end;
    if j<Node.Lines.Count then
       Result:=aLineE.Ref
    else
      Result:=NodeE
  end else
    Result:=NodeE
end;

function TSMSelectOperation.GetFlagSet: integer;
begin
  Result:=0
end;

procedure TSMSelectOperation.GetStepHint(aStep: integer; var Hint: string;
  var ACursor: integer);
begin
  Hint:=rsSelectAction;
  ACursor:=CR_HAND_ARROW;
end;

{ TSelectImageOperation }
procedure TSelectImageOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  aDataModel:IDataModel;
  aSpatialModel:ISpatialModel;
  aDMDocument: IDMDocument;
  aImage:IDMElement;
  i, Tag:integer;
  W, MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double;
  Painter:IPainter;
  View:IView;

    procedure DoSelect(Image:IDMElement);
    begin
      Image.Selected:=not Image.Selected;
    end;

    procedure DoSelectByFrame(Image:IDMElement; Tag:integer;
            MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double);
    var
      X0, Y0, Z0, X1, Y1, Z1:double;
      aLine:ILine;
      Layer:ILayer;
   begin
    aLine:=Image as ILine;
    Layer:=Image.Parent as ILayer;
    if not Layer.Selectable then Exit;
    X0:=aLine.C0.X;
    Y0:=aLine.C0.Y;
    Z0:=aLine.C0.Z;
    X1:=aLine.C1.X;
    Y1:=aLine.C1.Y;
    Z1:=aLine.C1.Z;
    if View.PointIsVisible(X0,Y0,Z0,1) and
       View.PointIsVisible(X1,Y1,Z1,1) and
       View.PointIsVisible(X0,Y0,Z0,2) and
       View.PointIsVisible(X1,Y1,Z1,2) then
    case Tag of
    1:begin
       if (X0<=MaxX) and
          (X0>=MinX) and
          (Y0<=MaxY) and
          (Y0>=MinY) and
          (X1<=MaxX) and
          (X1>=MinX) and
          (Y1<=MaxY) and
          (Y1>=MinY) then
        DoSelect(aImage);
      end;
    2:begin
       if (X0<=MaxX) and
          (X0>=MinX) and
          (Z0<=MaxZ) and
          (Z0>=MinZ) and
          (X1<=MaxX) and
          (X1>=MinX) and
          (Z1<=MaxZ) and
          (Z1>=MinZ) then
        DoSelect(aImage);
      end;
    end;
  end;

var
  OldState, OldSelectState:integer;
begin
  aDMDocument:=SMDocument as IDMDocument;
  aDataModel:=aDMDocument.DataModel as IDataModel;
  aSpatialModel:=aDataModel as ISpatialModel;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;

  if (CurrentStep=0) and
     ((sShift and ShiftState)=0) then begin
    aImage:=SMDocument.NearestImage;
    if (sCtrl and ShiftState)=0 then
      aDMDocument.ClearSelection(aImage);
    if (aImage<>nil) and
        aSpatialModel.CurrentLayer.Selectable then
      DoSelect(aImage);

  end else begin
    CurrentStep:=CurrentStep+1;
    if CurrentStep=1 then begin
      X0:=SMDocument.CurrX;
      Y0:=SMDocument.CurrY;
      Z0:=SMDocument.CurrZ;
    end else
    if CurrentStep=2 then begin
      MaxX:=X0;
      MinX:=SMDocument.CurrX;
      if MinX>MaxX then begin
        W:=MaxX;
        MaxX:=MinX;
        MinX:=W
      end;
      MaxY:=Y0;
      MinY:=SMDocument.CurrY;
      if MinY>MaxY then begin
        W:=MaxY;
        MaxY:=MinY;
        MinY:=W
      end;
      MaxZ:=Z0;
      MinZ:=SMDocument.CurrZ;
      if MinZ>MaxZ then begin
        W:=MaxZ;
        MaxZ:=MinZ;
        MinZ:=W
      end;       

      if SMDocument.HWindowFocused then
        Tag:=1
      else
      if SMDocument.VWindowFocused then
        Tag:=2
      else
        Exit;

      aImage:=nil;
      OldState:=aDataModel.State;
      OldSelectState:=OldState and dmfSelecting;
      aDataModel.State:=OldState or dmfSelecting;
      try
      for i:=0 to aSpatialModel.ImageRects.Count-1 do begin
        aImage:=aSpatialModel.ImageRects.Item[i];
        DoSelectByFrame(aImage, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
      end;
      finally
        aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
      end;
      aDMDocument.Server.SelectionChanged(aImage);
      Drag(SMDocument);
      CurrentStep:=0;
   end;
  end;
  aDMDocument.Server.RefreshDocument(rfFrontBack);   //это RePaint

  inherited;
end;


function TSelectImageOperation.GetFlagSet: integer;
begin
  Result:=sofImage
end;

procedure TSelectImageOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
    Hint:=rsSelectAction;
    ACursor:=CR_HAND_HAREA;
end;


{ TCustomSelectClosedPolyLineOperation }

function TCustomSelectClosedPolyLineOperation.GetFlagSet: integer;
begin
  Result:=sofHArea
end;

procedure TCustomSelectClosedPolyLineOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
    Hint:=rsSelectAction;
    if (DM_GetKeyState(VK_MENU)<0)then
      ACursor:=CR_HAND_HAREA
    else
      ACursor:=CR_HAND_ZONE
end;

procedure TCustomSelectClosedPolyLineOperation.SelectAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
begin  
  SelectHAreaAtPoint(SMDocument, ShiftState, FlagSet)
end;

procedure TCustomSelectClosedPolyLineOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer;
  MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
begin
  SelectHAreaByFrame(SMDocument, ShiftState, FlagSet,
        Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
end;

{ TSelectVolumeOperation }

function TSelectVolumeOperation.GetFlagSet: integer;
begin
  Result:=sofVolume
end;

procedure TSelectVolumeOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  inherited;
  Hint:=rsSelectAction;
  if (DM_GetKeyState(VK_MENU)<0)then
    ACursor:=CR_HAND_HAREA
  else
    ACursor:=CR_HAND_ZONE
end;

procedure TSelectVolumeOperation.SelectAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
begin
  SelectVolumeAtPoint(SMDocument, ShiftState, FlagSet)
end;

procedure TSelectVolumeOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer;
  MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
begin
  SelectVolumeByFrame(SMDocument, ShiftState, FlagSet,
        Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
end;

{ TSelectVerticalAreaOperation }

function TSelectVerticalAreaOperation.GetFlagSet: integer;
begin
  Result:=sofVLine+sofVArea
end;

procedure TSelectVerticalAreaOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:=rsSelectAction;
  if (DM_GetKeyState(VK_MENU)<0)then
    ACursor:=CR_HAND_HLINE
  else
    ACursor:=CR_HAND_VAREA
end;

procedure TSelectVerticalAreaOperation.SelectAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
begin
  SelectVAreaAtPoint(SMDocument, ShiftState, FlagSet)
end;

procedure TSelectVerticalAreaOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer;
        Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double);
begin
  SelectVAreaByFrame(SMDocument, ShiftState, FlagSet,
        Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
end;

{ TSelectVerticalLineOperation }

function TSelectVerticalLineOperation.GetFlagSet: integer;
begin
  Result:=sofNode+sofVLine
end;

procedure TSelectVerticalLineOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
    Hint:=rsSelectAction;
    if (DM_GetKeyState(VK_MENU)<0)then
      ACursor:=CR_HAND_ARROW
    else
      ACursor:=CR_HAND_VLINE
end;

procedure TSelectVerticalLineOperation.SelectAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
begin
  SelectVLineAtPoint(SMDocument, ShiftState, FlagSet)
end;

procedure TSelectVerticalLineOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer; MaxX,
  MinX, MaxY, MinY, MaxZ, MinZ: double);
begin
  SelectVLineByFrame(SMDocument, ShiftState, FlagSet,
        Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ)
end;

{ TSelectLabelOperation }

procedure TSelectLabelOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  aDataModel:IDataModel;
  aSpatialModel:ISpatialModel;
  aSpatialModel2:ISpatialModel2;
  aDMDocument: IDMDocument;
  aLabelE:IDMElement;
  i, Tag:integer;
  W, MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double;
  Painter:IPainter;
  View:IView;

    procedure DoSelect(aLabelE:IDMElement);
     var
      aLabel:ISMLabel;
    begin
      aLabel:=aLabelE as ISMLabel;
      aLabelE.Selected:=not aLabelE.Selected;
    end;

    procedure DoSelectByFrame(LabelE:IDMElement; Tag:integer;
            MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double);
    var
      X0, Y0, Z0:double;
      aLabelN:ICoordNode;
   begin
    aLabelN:=LabelE as ICoordNode;
    if not aSpatialModel.CurrentLayer.Selectable then Exit;
    X0:=aLabelN.X;
    Y0:=aLabelN.Y;
    Z0:=aLabelN.Z;
    if View.PointIsVisible(X0,Y0,Z0,1) then
    case Tag of
    1:begin
       if (X0<=MaxX) and
          (X0>=MinX) and
          (Y0<=MaxY) and
          (Y0>=MinY) then
        DoSelect(LabelE);
      end;
    2:begin
       if (X0<=MaxX) and
          (X0>=MinX) and
          (Z0<=MaxZ) and
          (Z0>=MinZ) then
        DoSelect(LabelE);
      end;
    end;
  end;

var
  OldState, OldSelectState:integer;
begin
  aDMDocument:=SMDocument as IDMDocument;
  aDataModel:=aDMDocument.DataModel as IDataModel;
  aSpatialModel:=aDataModel as ISpatialModel;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;

  if (CurrentStep=0) and
     ((sShift and ShiftState)=0) then begin
    aLabelE:=SMDocument.NearestLabel;
    if (sCtrl and ShiftState)=0 then
      aDMDocument.ClearSelection(aLabelE as ISMLabel);
    if (aLabelE<>nil) and
        aSpatialModel.CurrentLayer.Selectable then
      DoSelect(aLabelE);

  end else begin
    CurrentStep:=CurrentStep+1;
    if CurrentStep=1 then begin
      X0:=SMDocument.CurrX;
      Y0:=SMDocument.CurrY;
      Z0:=SMDocument.CurrZ;
    end else
    if CurrentStep=2 then begin
      MaxX:=X0;
      MinX:=SMDocument.CurrX;
      if MinX>MaxX then begin
        W:=MaxX;
        MaxX:=MinX;
        MinX:=W
      end;
      MaxY:=Y0;
      MinY:=SMDocument.CurrY;
      if MinY>MaxY then begin
        W:=MaxY;
        MaxY:=MinY;
        MinY:=W
      end;
      MaxZ:=Z0;
      MinZ:=SMDocument.CurrZ;
      if MinZ>MaxZ then begin
        W:=MaxZ;
        MaxZ:=MinZ;
        MinZ:=W
      end;

      if SMDocument.HWindowFocused then
        Tag:=1
      else
      if SMDocument.VWindowFocused then
        Tag:=2
      else
        Exit;

      aLabelE:=nil;
      OldState:=aDataModel.State;
      OldSelectState:=OldState and dmfSelecting;
      aDataModel.State:=OldState or dmfSelecting;
      try
      for i:=0 to aSpatialModel2.Labels.Count-1 do begin
        aLabelE:=aSpatialModel2.Labels.Item[i];
        DoSelectByFrame(aLabelE, Tag, MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
      end;
      finally
        aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
      end;  
      aDMDocument.Server.SelectionChanged(aLabelE);
      Drag(SMDocument);
      CurrentStep:=0;
   end;
  end;
  aDMDocument.Server.RefreshDocument(rfFrontBack);   //это RePaint

  inherited;
end;

procedure TSelectLabelOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
    Hint:=rsLabelOperation + rsSelectAction;
    ACursor:=CR_HAND_TEXT;
 end;

{ TSelectLineOperation }

{ TSelectClosedPolyLineOperation }

procedure TSelectClosedPolyLineOperation.SelectAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
begin
  SelectClosedPolylineAtPoint(SMDocument, ShiftState, FlagSet);
  inherited;
end;

procedure TSMSelectOperation.SelectClosedPolylineAtPoint(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet: integer);
var
  DMDocument:IDMDocument;
  SpatialModel2:ISpatialModel2;
  TMPArea:IArea;
  j:integer;
  aDataModel:IDataModel;
begin
  DMDocument:=SMDocument as IDMDocument;
  aDataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel2:=aDataModel as ISpatialModel2;

  FSelectedElementList.Clear;
  for j:=0 to DMDocument.SelectionCount-1 do
    FSelectedElementList.Add(pointer(DMDocument.SelectionItem[j] as IDMElement));

  X0:=SMDocument.CurrX;
  Y0:=SMDocument.CurrY;
  Z0:=SMDocument.CurrZ;

  aDataModel.State:=aDataModel.State or dmfCommiting;
  TMPArea:=SpatialModel2.BuildAreaSurrounding(X0, Y0, Z0);
  aDataModel.State:=aDataModel.State and not dmfCommiting;

  FTMPArea:=pointer(TMPArea);
  FImageRect:=pointer(SMDocument.NearestImage);
  FCircle:=pointer(SMDocument.NearestCircle);
end;

{ TSelectAllOperation }

constructor TSelectAllOperation.Create(aOperationCode: integer;
  const aOperationManager: TCustomSMDocument);
begin
  inherited;
end;

function TSelectAllOperation.GetFlagSet: integer;
begin
  Result:=sofVLine+sofNode+sofVArea+sofHLine+sofVolume+sofHArea+sofImage
end;

procedure TSelectAllOperation.GetStepHint(aStep: integer; var Hint: string;
  var ACursor: integer);
begin
  Hint:=rsSelectAction;
  ACursor:=CR_HAND_ARROW;
end;

procedure TSelectAllOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer; MaxX,
  MinX, MaxY, MinY, MaxZ, MinZ: double);
begin
  case FLastSelectOperationCode of
  ord(socVLine):
    SelectVLineByFrame(SMDocument, ShiftState, FlagSet, Tag,
        MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  ord(socNode):
    SelectNodeByFrame(SMDocument, ShiftState, FlagSet, Tag,
        MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  ord(socVArea):
    SelectVAreaByFrame(SMDocument, ShiftState, FlagSet, Tag,
        MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  ord(socHLine):
    SelectHLineByFrame(SMDocument, ShiftState, FlagSet, Tag,
        MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  ord(socVolume):
    SelectVolumeByFrame(SMDocument, ShiftState, FlagSet, Tag,
        MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  ord(socHArea):
    SelectHAreaByFrame(SMDocument, ShiftState, FlagSet, Tag,
        MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  end;
end;

end.
