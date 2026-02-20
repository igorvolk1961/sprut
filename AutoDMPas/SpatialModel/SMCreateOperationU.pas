unit SMCreateOperationU;

interface
uses
   Classes, Dialogs, SysUtils, PainterLib_TLB,
   SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB , Math, Variants,
   SMOperationU, SMOperationConstU, DMElementU, CustomSMDocumentU;

type
  TSMCreateOperation=class(TSMOperation)
  protected
    FBaseNode:ICoordNode;
  public
    constructor Create(aOperationCode:integer;
                 const aOperationManager:TCustomSMDocument); override;
    destructor Destroy; override;
    procedure Init; override;
    procedure Set_BaseNode(const Value:ICoordNode;
                           const Painter:IPainter);
    function  GetBaseNode:ICoordNode; override;
    procedure SetTypeVolume(SMDocument:TCustomSMDocument;
                          DMOperationManager:IDMOperationManager;
                          RefElement,RefParent:IDMElement;
                          const BaseAreas:IDMCollection;
                          BaseVolumeFlag:WordBool);
  end;

  TCreateCoordNodeOperation=class(TSMCreateOperation)
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TCustomCreateLineOperation=class(TSMCreateOperation)
  private
  protected
   FLineE:IDMElement;
   FNLine:ILine;
   FDivideAreaFlag:boolean;
  public
    constructor Create(aOperationCode:integer;
                 const aOperationManager:TCustomSMDocument); override;
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    destructor Destroy; override;
  end;

  TCreateLineOperation=class(TCustomCreateLineOperation)
  private
    FLineList0:TList;
    FLineList1:TList;
  protected
  public
    constructor Create(aOperationCode:integer;
                 const aOperationManager:TCustomSMDocument); override;
    destructor Destroy; override;
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TCreatePolyLineOperation=class(TCreateLineOperation)
  protected
    FLines:TList;
    FLineCount:integer;
    FEmptyTransaction:boolean;
    FStep:integer;
    FIndex0:integer;
  public
    constructor Create(aOperationCode:integer;
                 const aOperationManager:TCustomSMDocument); override;
    destructor Destroy; override;
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Stop(const SMDocument:TCustomSMDocument;ShiftState: Integer); override;
//    procedure FindNodes(const Lines:IDMCollection; out C0,C1:ICoordNode);
//
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
    procedure Undo(const SMDocument: TCustomSMDocument); override;
    procedure Redo(const SMDocument: TCustomSMDocument); override;
  end;

  TCreateClosedPolyLineOperation=class(TCreatePolyLineOperation)
  private
    FFirstNode:ICoordNode;
    FDone:boolean;
  public
    function  GetFirstNode:ICoordNode; override;

    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TCreateRectangleOperation=class(TSMCreateOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TCreateInclinedRectangleOperation=class(TSMCreateOperation)
  private
    FGangle:double;
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TCreateCurvedLineOperation=class(TSMCreateOperation)
  private
    FEndNode:ICoordNode;
    FX:double;
    FY:double;
    FZ:double;
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TCreateEllipseOperation=class(TSMCreateOperation)
  private
    FEndNode:ICoordNode;

    FPX0:double;
    FPY0:double;
    FPZ0:double;
    FPX1:double;
    FPY1:double;
    FPZ1:double;
    FPX3:double;
    FPY3:double;
    FPZ3:double;
    FPX4:double;
    FPY4:double;
    FPZ4:double;
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TCreateImageRectOperation=class(TSMCreateOperation)
  private
    FPictureFilename:string;
  public
    constructor Create1(aOperationCode:integer;
                        aPictureFilename:string;
                        const aOperationManager:TCustomSMDocument);
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TCreateCircleOperation=class(TSMOperation)
  private
  protected
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  function FindWallNodes(var C0, C1:ICoordNode;
                         const aCurrentLines:IDMCollection;
                         const LineList0, LineList1:TList):boolean;

implementation
uses
  Graphics, SpatialModelConstU, Geometry, LinkListU;

{ TSMCreateOperation } 

constructor TSMCreateOperation.Create(aOperationCode:integer;
                 const aOperationManager:TCustomSMDocument);
begin
  inherited;
  FBaseNode:=nil;
end;

destructor TSMCreateOperation.Destroy;
begin
  inherited;
  FBaseNode:=nil;
end;

function TSMCreateOperation.GetBaseNode: ICoordNode;
begin
  Result:=FBaseNode
end;

procedure TSMCreateOperation.Init;
begin
  inherited;
  FBaseNode:=nil;
end;

procedure TSMCreateOperation.Set_BaseNode(const Value:ICoordNode;
                                          const Painter:IPainter);
begin
 if Value<>nil Then begin
  FBaseNode:=Value;
  X0:=Value.X;
  Y0:=Value.Y;
  Z0:=Value.Z;
 end; 
end;

{ TCustomCreateLineOperation }

constructor TCustomCreateLineOperation.Create(aOperationCode: integer;
  const aOperationManager: TCustomSMDocument);
begin
  inherited;
  FDivideAreaFlag:=True;
end;

destructor TCustomCreateLineOperation.Destroy;
begin
  inherited;
  FLineE:=nil;
  FNLine:=nil;
end;

procedure TCustomCreateLineOperation.Drag(const SMDocument:TCustomSMDocument);
begin
  DragLine(SMDocument);
end;

procedure TCustomCreateLineOperation.Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer);
var
  NextNode:ICoordNode;
  aLine:ILine;
  aNode:ICoordNode;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  LineU:IUnknown;
  VolumeBuilder:IVolumeBuilder;
  m:integer;
begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  VolumeBuilder:=SMDocument as IVolumeBuilder;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  if CurrentStep=0 then begin
     DMOperationManager.StartTransaction(nil, leoAdd, rsCreateLine);

     aNode:=SMDocument.GetSnapNode(FNLine, nil, False,0);
     Set_BaseNode(aNode, Painter);
     CurrentStep:=1;
     Drag(SMDocument);
  end else begin
     NextNode:=SMDocument.GetSnapNode(FNLine, FBaseNode, False,0);

     if NextNode=nil then Exit;
     m:=0;
     while m<NextNode.Lines.Count do begin
       aLine:=NextNode.Lines.Item[m] as ILine;
       if aLine.NextNodeTo(NextNode)=FBaseNode then
         Break
       else
         inc(m)
     end;
     if m<NextNode.Lines.Count then begin
       DMDocument.Server.CallDialog(sdmShowMessage, 'Ошибка', 'Между данными точками уже создана линия');
       NextNode:=nil;
       Exit;
     end;

     DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                         SpatialModel.Lines, '', ltOneToMany, LineU, True);
     FLineE:=LineU as IDMElement;
     aLine:=FLineE as ILine;

     aLine.C0:=FBaseNode;
     aLine.C1:=NextNode;

     FLineE.Draw(Painter, 0);

     if FDivideAreaFlag then
       VolumeBuilder.UpdateAreas(FLineE);

     CurrentStep:=-1;
  end;
end;

{ TCreatePolyLineOperation }

constructor TCreatePolyLineOperation.Create(aOperationCode: integer;
  const aOperationManager: TCustomSMDocument);
begin
  inherited;
  FLines:=TList.Create;
  FEmptyTransaction:=True;
end;

destructor TCreatePolyLineOperation.Destroy;
begin
  inherited;
  FLines.Free;
end;


procedure TCreatePolyLineOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  aNode:ICoordNode;
  NLine, aLine:ILine;
  aLineE:IDMElement;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  LineU:IUnknown;
//_______________
  aCurrentLines:IDMCollection;
  j, m, aLinesCount:integer;
  C0, C1, C2:ICoordNode;
  aNewAreaE:IDMElement;
  aArea, aNewArea:IArea;
  Flag:boolean;
  DataModel:IDataModel;
//______________
begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  if CurrentStep=0 then begin
     DMOperationManager.StartTransaction(nil, leoAdd, rsCreatePolyLine);
     FEmptyTransaction:=True;

     aNode:=SMDocument.GetSnapNode(NLine, nil, False,0);
     Set_BaseNode(aNode, Painter);
     CurrentStep:=1;
     Drag(SMDocument);
  end else begin
     if FLineCount<FLines.Count then begin
       while FLineCount<FLines.Count do
         FLines.Delete(FLineCount);
       if not FEmptyTransaction then
         DMOperationManager.StartTransaction(nil, leoAdd, rsCreatePolyLine);
         FEmptyTransaction:=True;
     end;


     aNode:=SMDocument.GetSnapNode(NLine, FBaseNode, False,0);
     if aNode=nil then Exit;
     m:=0;
     while m<aNode.Lines.Count do begin
       aLine:=aNode.Lines.Item[m] as ILine;
       if aLine.NextNodeTo(aNode)=FBaseNode then
         Break
       else
         inc(m)
     end;
     if m<aNode.Lines.Count then begin
       DMDocument.Server.CallDialog(sdmShowMessage, 'Ошибка', 'Между данными точками уже создана линия');
       aNode:=nil;
       Exit;
     end;

     DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                         SpatialModel.Lines, '', ltOneToMany, LineU, True);
     FEmptyTransaction:=False;
     aLineE:=LineU as IDMElement;
     aLine:=aLineE as ILine;

     aLine.C0:=FBaseNode;
     aLine.C1:=aNode;

     aLineE.Draw(Painter, 0);
     FLines.Add(pointer(aLineE));

     Set_BaseNode(aNode, Painter);

     inc(FLineCount);
//________________

  aLinesCount:=FLines.Count;
  try
   aCurrentLines:=DataModel.CreateCollection(-1, nil);
   for j:=FIndex0 to aLinesCount-1 do
    (aCurrentLines as IDMCollection2).Add(IDMElement(FLines.Items[j]));
   SMDocument.FindEndedNodes(aCurrentLines,C0,C1,C2);
   if (C0<>nil) and
      (C1<>nil) then begin

     aArea:=SMDocument.Find_DivideAreaWithNodes(C0,C1,C2, aCurrentLines, aNewArea);
     if (aArea<>nil) and
        (aNewArea<>nil) then begin
        aNewAreaE:=aNewArea as IDMElement;

        SMDocument.Lines_AddParent(aCurrentLines, aArea);  {опред. владельцев для aCurrentLines  }
        SMDocument.Lines_AddParent(aCurrentLines, aNewArea);

        FIndex0:=aLinesCount;

     end else begin   //if aArea=nil
       FLineList0.Clear;
       FLineList1.Clear;

       Flag:=FindWallNodes(C0, C1, aCurrentLines, FLineList0, FLineList1);

       if Flag then begin
         for m:=0 to FLineList0.Count-1 do begin
           aLineE:=IDMElement(FLineList0[m]);
           (aCurrentLines as IDMCollection2).Insert(0, aLineE);
         end;
         for m:=0 to FLineList1.Count-1 do begin
           aLineE:=IDMElement(FLineList1[m]);
           (aCurrentLines as IDMCollection2).Add(aLineE);
         end;

         m:=aCurrentLines.Count div 2;
         C2:=(aCurrentLines.Item[m] as ILine).C0;
         if (C2=C0) or (C2=C1) then
           C2:=(aCurrentLines.Item[m] as ILine).C1;

         aArea:=SMDocument.Find_DivideAreaWithNodes(C0,C1,C2, aCurrentLines, aNewArea);
         if (aArea<>nil) and
            (aNewArea<>nil) then begin

           aNewAreaE:=aNewArea as IDMElement;

           SMDocument.Lines_AddParent(aCurrentLines,aArea);  {опред. владельцев для aCurrentLines  }
           SMDocument.Lines_AddParent(aCurrentLines,aNewArea);

           FIndex0:=aLinesCount;
         end;
       end else
         XXX:=0;
     end;
   end;
  except
    raise
  end;
   Drag(SMDocument);
   DMOperationManager.StartTransaction(nil, leoAdd, rsCreatePolyLine);
   FEmptyTransaction:=True;
   FStep:=1;      // Execute закончило- для обр. Stop
  end;  //
  SMDocument.OperationStepExecutedFlag:=True;
end;


procedure TCreatePolyLineOperation.GetStepHint(aStep: integer;
  var Hint: string;  var ACursor: integer);
begin
   case CurrentStep of
    -1, 0:begin Hint:=rsPolyLineOperation + rsAction + rsPolyLineStep1;
            ACursor:=cr_Pen_Polyline; end;
    1:begin Hint:=rsPolyLineOperation + rsAction + rsPolyLineStep2;
            ACursor:=cr_Pen_Polyline; end;
    else begin Hint:=rsPolyLineOperation + rsErrOperation;
            ACursor:=0; end;
   end;
end;

   { New 23 03 04 - рабочая версия   }
procedure TCreatePolyLineOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState: Integer);
var
  DMOperationManager:IDMOperationManager;

  aCurrentLines:IDMCollection;
  aCurrentLines2:IDMCollection2;
  aCurrentCollection:IDMCollection;

  j,i, OldState:integer;
  DMDocument:IDMDocument;
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  BLineGroupList:TList;
  aLineE, aRefArea:IDMElement;
  BuildDirection:integer;
begin
  inherited;

  if FStep<>1 then  Exit;

  if FLines.Count=0 then Exit;


  DMOperationManager:=SMDocument as IDMOperationManager;

  DMOperationManager.StartTransaction(nil, leoAdd, rsBuildVerticalArea);

  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;

  FStep:=-2;
//_________
  OldState:=DMDocument.State;
  try

  aCurrentLines:=DataModel.CreateCollection(-1, nil);
  aCurrentLines2:=aCurrentLines as IDMCollection2;
  for j:=0 to FLines.Count-1 do begin
    aLineE:=IDMElement(FLines[j]);
    aCurrentLines2.Add(aLineE);
  end;
  for j:=0 to FLineList0.Count-1 do begin
    aLineE:=IDMElement(FLineList0[j]);
    aCurrentLines2.Insert(0, aLineE);
  end;
  for j:=0 to FLineList1.Count-1 do begin
    aLineE:=IDMElement(FLineList1[j]);
    aCurrentLines2.Add(aLineE);
  end;

      {разбить PolyLine на отрезки (BLineGroupList), замыкающие по одному объему}
  BLineGroupList:=TList.Create;
  if not(SMDocument.PolyLine_IsClosedVolume(aCurrentLines,BLineGroupList))
                                                                   then begin
    DMDocument.State:=OldState;
    CurrentStep:=-1;
    Exit;
  end;

 aRefArea:=nil;
 for i:=0 to BLineGroupList.Count-1 do begin
   aCurrentCollection:=IDMCollection(BLineGroupList[i]);
//   if aRefArea<>nil then
//     aRefArea:=DMOperationManager.CreateClone(aRefArea) as IDMElement;
    {BuildVerticalArea по тек. объему}
   BuildDirection:=SpatialModel2.BuildDirection;
   if SMDocument.PolyLine_BuildVerticalArea(aCurrentCollection,
        OperationCode, BuildDirection, aRefArea)=nil then begin
     DMDocument.State:=OldState;
     CurrentStep:=-1;
     Exit;
   end;
   aCurrentCollection._Release;
 end;//for i

 if BLineGroupList.Count>0 then
   SpatialModel2.UpdateVolumes;

 BLineGroupList.Free;

 finally
   DMDocument.State:=OldState;
 end;
 CurrentStep:=-2;
end;

procedure TCreatePolyLineOperation.Redo(const SMDocument: TCustomSMDocument);
var
  Painter:IPainter;
  aLine:ILine;
  aNode:ICoordNode;
begin
  Painter:=SMDocument.PainterU as IPainter;
  inherited;
  inc(FLineCount);
  if FLineCount-1<FLines.Count then begin
    aLine:=IDMElement(FLines[FLineCount-1]) as ILine;
    aNode:=aLine.C1;
    Set_BaseNode(aNode, Painter);
  end;
end;

procedure TCreatePolyLineOperation.Undo(const SMDocument: TCustomSMDocument);
var
  Painter:IPainter;
  aLine:ILine;
  aNode:ICoordNode;
begin
  Painter:=SMDocument.PainterU as IPainter;
  inherited;
  if FEmptyTransaction then begin
    Drag(SMDocument);
    FEmptyTransaction:=False;
  end else begin
    dec(FLineCount);
    if (FLineCount>0) and
       (FLineCount-1<FLines.Count) then begin
      aLine:=IDMElement(FLines[FLineCount-1]) as ILine;
      aNode:=aLine.C1;
      Set_BaseNode(aNode, Painter);
    end
  end;
  if FLineCount=0 then begin
    CurrentStep:=0;
  end else
  if FLineCount<0 then
    FLineCount:=0;
end;

{ TCreateClosedPolyLineOperation }

procedure TCreateClosedPolyLineOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
begin
  inherited;
  if FLineCount=0 then
    FFirstNode:=FBaseNode
  else
  if FFirstNode=FBaseNode then begin
    FDone:=True;
    Stop(SMDocument, ShiftState);
  end;
end;

function TCreateClosedPolyLineOperation.GetFirstNode: ICoordNode;
begin
  Result:=FFirstNode
end;

procedure TCreateClosedPolyLineOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  inherited;
   case CurrentStep of
    -1, 0:begin Hint:=rsClosedPolyLineOperation + rsAction + rsPolyLineStep1;
            ACursor:=cr_Pen_Closed; end;
    1:begin Hint:=rsClosedPolyLineOperation + rsAction + rsPolyLineStep2;
            ACursor:=cr_Pen_Closed; end;
    else begin Hint:=rsClosedPolyLineOperation + rsErrOperation;
            ACursor:=0; end;
   end;

end;

procedure TCreateClosedPolyLineOperation.Stop(
  const SMDocument: TCustomSMDocument;ShiftState: Integer);
var
  aLineE:IDMElement;
  aLine:ILine;
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  LineU:IUnknown;
  AreaU:IUnknown;
  BaseAreaE:IDMElement;
  j, ClassID:integer;
  aRefElement, RefParent:IDMElement;
  BaseAreas:IDMCollection;
  GlobalData:IGlobalData;
begin
  Drag(SMDocument);
  if CurrentStep<>0 then
    CurrentStep:=-2
  else
    Exit;
  if FLineCount>1 then begin
     Painter:=SMDocument.PainterU as IPainter;
     DataModel:=(SMDocument as IDMDocument).DataModel as IDataModel;
     SpatialModel:=DataModel as ISpatialModel;
     DMOperationManager:=SMDocument as IDMOperationManager;
     if not FDone then begin
       DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                         SpatialModel.Lines, '', ltOneToMany, LineU, True);
       aLineE:=LineU as IDMElement;
       aLine:=aLineE as ILine;

       aLine.C0:=FBaseNode;
       aLine.C1:=FFirstNode;

       aLineE.Draw(Painter, 0);
     end;
//_________________
       { TODO -o Gol : PolyLine - BuildVolume }
   ClassID:=_Volume;
   if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
     GlobalData.GlobalValue[1]:=0;
     GlobalData.GlobalValue[2]:=0;
     GlobalData.GlobalIntf[1]:=nil;
   end;

   if ((ShiftState and sShift)<>0) and
      (SMDocument.CreateRefElement(ClassID,
                           OperationCode, nil,aRefElement, RefParent, True)) then begin

    DMOperationManager.AddElement( aLineE.Parent,
          (SpatialModel as ISpatialModel2).Areas, '', ltOneToMany, AreaU, True);

    BaseAreaE:=AreaU as IDMElement;

    for j:=0 to FLines.Count-1 do begin     //первые элем. (из списка по Execute)
     aLineE:=IDMElement(FLines.Items[j]);
     DMOperationManager.AddElementParent( BaseAreaE, aLineE);
    end;

     aLineE:=aLine as IDMElement;           //последний элем. ( по Stop)
     DMOperationManager.AddElementParent( BaseAreaE, aLineE);

    BaseAreas:=DataModel.CreateCollection(-1, nil);
    (BaseAreas as IDMCollection2).Add(BaseAreaE);
    SetTypeVolume(SMDocument,DMOperationManager,aRefElement,RefParent,
                  BaseAreas, True);

   end;

  end else
  CurrentStep:=-1;
end;

{ TCreateRectangleOperation }

procedure TCreateRectangleOperation.Drag(
  const SMDocument: TCustomSMDocument);
var
  Painter:IPainter;
  View:IView;
begin
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  DragRect(SMDocument, -2*View.ZAngle);
end;

procedure TCreateRectangleOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  EndNodeE, N0E, N1E:IDMElement;
  N0, N1:ICoordNode;
  LineB0E, LineB1E, LineA0E, LineA1E:IDMElement;
  LineB0, LineB1, LineA0, LineA1:ILine;
  cosA, sinA, cosB, sinB, cosC, sinC, L, A, B:double;
  NLine, aLine:ILine;
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  EndNode, aNode:ICoordNode;
  DMOperationManager:IDMOperationManager;
  i, ClassID:integer;
  DMDocument:IDMDocument;
  NodeU:IUnknown;
  LineU:IUnknown;

  aRefElement, RefParent:IDMElement;
  BaseAreaE:IDMElement;
  Polyline:IPolyline;
  Lines2:IDMCollection2;
  OldGlueNodeMode:boolean;
  GN:ICoordNode;
  ExceptNodes:IDMCollection;
  ExceptNodes2:IDMCollection2;
  BaseAreas:IDMCollection;
  GlobalData:IGlobalData;
  View:IView;
begin
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
      DMOperationManager.StartTransaction(nil, leoAdd, rsCreateRectangle);

      aNode:=SMDocument.GetSnapNode(NLine, nil, False,0);
      Set_BaseNode(aNode, Painter);
      CurrentStep:=1;
      Drag(SMDocument);
    end;
  1:begin
      Drag(SMDocument);

      EndNode:=SMDocument.GetSnapNode(NLine, FBaseNode, False,0);
      if EndNode=nil then Exit;
      EndNodeE:=EndNode as IDMElement;

      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
      N0E:=NodeU as IDMElement;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
      N1E:=NodeU as IDMElement;

      N0:=N0E as ICoordNode;
      N1:=N1E as ICoordNode;

      L:=sqrt(sqr(EndNode.X-FBaseNode.X)+sqr(EndNode.Y-FBaseNode.Y));
      if L=0 then begin
        cosA:=1;
        sinA:=0;
      end else begin
        cosA:=(EndNode.X-FBaseNode.X)/L;
        sinA:=(EndNode.Y-FBaseNode.Y)/L;
      end;
      cosB:=cos(View.Zangle*PI/180);
      sinB:=sin(View.Zangle*PI/180);
      cosC:=cosA*cosB-sinA*sinB;
      sinC:=sinA*cosB+cosA*sinB;
      A:=L*cosC;
      B:=L*sinC;

      N0.X:=FBaseNode.X+A*cosB;
      N0.Y:=FBaseNode.Y-A*sinB;
      N0.Z:=SMDocument.CurrZ;
      N1.X:=FBaseNode.X+B*sinB;
      N1.Y:=FBaseNode.Y+B*cosB;
      N1.Z:=SMDocument.CurrZ;

      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineB0E:=LineU as IDMElement;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineB1E:=LineU as IDMElement;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineA0E:=LineU as IDMElement;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineA1E:=LineU as IDMElement;
      LineB0:=LineB0E as ILine;
      LineB1:=LineB1E as ILine;
      LineA0:=LineA0E as ILine;
      LineA1:=LineA1E as ILine;

      LineB0.C0:=FBaseNode;
      LineB0.C1:=N0;
      LineB1.C0:=FBaseNode;
      LineB1.C1:=N1;
      LineA0.C0:=N0;
      LineA0.C1:=EndNode;
      LineA1.C0:=N1;
      LineA1.C1:=EndNode;

      OldGlueNodeMode:=SMDocument.GlueNodeMode;
      SMDocument.GlueNodeMode:=True;

      ExceptNodes:=DataModel.CreateCollection(-1, nil);
      ExceptNodes2:=ExceptNodes as IDMCollection2;
      ExceptNodes2.Add(FBaseNode as IDMElement);
      ExceptNodes2.Add(EndNodeE);
      ExceptNodes2.Add(N0E);
      ExceptNodes2.Add(N1E);

      i:=0;
      while i<FBaseNode.Lines.Count do begin
        aLine:=FBaseNode.Lines.Item[i] as ILine;
        if aLine.C0=FBaseNode then begin
          aNode:=aLine.C1;
        end else begin
          aNode:=aLine.C0;
        end;
        GN:=SMDocument.GlueNode(aNode, ExceptNodes);
        if GN<>nil then begin
          if EndNode.X=aNode.X then
            EndNode.X:=GN.X;
          if EndNode.Y=aNode.Y then
            EndNode.Y:=GN.Y;
        end;

        if FBaseNode.Lines.IndexOf(aLine as IDMElement)<>-1 then
          inc(i);
      end;
      i:=0;
      while i<EndNode.Lines.Count do begin
        aLine:=EndNode.Lines.Item[i] as ILine;
        if aLine.C0=EndNode then begin
          aNode:=aLine.C1;
        end else begin
          aNode:=aLine.C0;
        end;

        GN:=SMDocument.GlueNode(aNode, ExceptNodes);
        if GN<>nil then begin
          if EndNode.X=aNode.X then
            EndNode.X:=GN.X;
          if EndNode.Y=aNode.Y then
            EndNode.Y:=GN.Y;
        end;

        if EndNode.Lines.IndexOf(aLine as IDMElement)<>-1 then
          inc(i);
      end;

      LineB0E.Draw(Painter, 0);
      LineB1E.Draw(Painter, 0);
      LineA0E.Draw(Painter, 0);
      LineA1E.Draw(Painter, 0);

    { TODO -o Gol : BuildVolume }
      ClassID:=_Volume;
      if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
        GlobalData.GlobalValue[1]:=0;
        GlobalData.GlobalValue[2]:=0;
        GlobalData.GlobalIntf[1]:=nil;
      end;

      if ((ShiftState and sShift)<>0) and(SMDocument.CreateRefElement(ClassID,
                               OperationCode, nil,aRefElement, RefParent, True)) then begin

        BaseAreaE:=((SpatialModel as ISpatialModel2).Areas as IDMCollection2).CreateElement(False);
        Polyline:=BaseAreaE as IPolyline;
        Lines2:=Polyline.Lines as IDMCollection2;
        Lines2.Add(LineB0E);
        Lines2.Add(LineB1E);
        Lines2.Add(LineA0E);
        Lines2.Add(LineA1E);

        BaseAreas:=DataModel.CreateCollection(-1, nil);
        (BaseAreas as IDMCollection2).Add(BaseAreaE);
        SetTypeVolume(SMDocument,DMOperationManager,aRefElement,RefParent,
                        BaseAreas, True);

      end;

      SMDocument.GlueNodeMode:=OldGlueNodeMode;

      CurrentStep:=-1;
    end;
  end;
  SMDocument.OperationStepExecutedFlag:=True;
end;

procedure TCreateRectangleOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
    -1, 0:begin Hint:=rsRectangleOperation + rsAction + rsRectangleStep1;
            ACursor:=cr_Pen_Rect; end;
    1:begin Hint:=rsRectangleOperation + rsAction + rsRectangleStep2;
            ACursor:=cr_Pen_Rect; end;
    else begin Hint:=rsRectangleOperation + rsErrOperation;
            ACursor:=0; end;
   end;

end;

{ TCreateCurvedLineOperation }

procedure TCreateCurvedLineOperation.Drag(
  const SMDocument: TCustomSMDocument);
var
  WorldPointList:Variant;
  APX, APY, APZ:double;
  Painter:IPainter;
begin

  if SMDocument.DontDragMouse<>0 then begin
    SMDocument.DontDragMouse:=SMDocument.DontDragMouse+1;
    if SMDocument.DontDragMouse=10 then
      SMDocument.DontDragMouse:=0;
    Exit;
  end;

  Painter:=SMDocument.PainterU as IPainter;


  case CurrentStep of
  1:DragLine(SMDocument);
  2:begin
      APX:=SMDocument.CurrX;
      APY:=SMDocument.CurrY;
      APZ:=SMDocument.CurrZ;

      WorldPointList:=VarArrayCreate([0,11], varDouble);
      WorldPointList[0]:=X0;
      WorldPointList[1]:=Y0;
      WorldPointList[2]:=Z0;
      WorldPointList[3]:=APX;
      WorldPointList[4]:=APY;
      WorldPointList[5]:=APZ;
      WorldPointList[6]:=APX;
      WorldPointList[7]:=APY;
      WorldPointList[8]:=APZ;
      WorldPointList[9]:=FX1;
      WorldPointList[10]:=FY1;
      WorldPointList[11]:=FZ1;
      Painter.PenStyle:=ord(psDot);
      Painter.PenMode:=ord(pmNotXor);
      Painter.DrawCurvedLine(WorldPointList);
    end;
  3:begin
      APX:=SMDocument.CurrX;
      APY:=SMDocument.CurrY;
      APZ:=SMDocument.CurrZ;

      WorldPointList:=VarArrayCreate([0,11], varDouble);
      WorldPointList[0]:=X0;
      WorldPointList[1]:=Y0;
      WorldPointList[2]:=Z0;
      WorldPointList[3]:=FX;
      WorldPointList[4]:=FY;
      WorldPointList[5]:=FZ;
      WorldPointList[6]:=APX;
      WorldPointList[7]:=APY;
      WorldPointList[8]:=APZ;
      WorldPointList[9]:=FX1;
      WorldPointList[10]:=FY1;
      WorldPointList[11]:=FZ1;
      Painter.PenStyle:=ord(psDot);
      Painter.PenMode:=ord(pmNotXor);
      Painter.DrawCurvedLine(WorldPointList);
    end;
  end;
end;

procedure TCreateCurvedLineOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  CurvedLineE, LineE, aRefArea:IDMElement;
  CurvedLine:ICurvedLine;
  CurvedLineL:ILine;
  aNode, C0, C1, C2:ICoordNode;
  NLine, Line:ILine;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  CurvedLineU, LineU, CU:IUnknown;
  N, m, BuildDirection:integer;
  Server:IDataModelServer;
  t, t2, t3, q, q2, q3, WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, WZ2, WX3, WY3, WZ3,
  WWX1, WWY1, WWZ1:double;
  LineCollection:IDMCollection;
  LineCollection2:IDMCollection2;
  aArea, aNewArea:IArea;
begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
     DMOperationManager.StartTransaction(nil, leoAdd, rsCreateCurvedLine);

     aNode:=SMDocument.GetSnapNode(NLine, nil, False,0);
     Set_BaseNode(aNode, Painter);
     CurrentStep:=1;
    end;
  1:begin
     Drag(SMDocument);
     FEndNode:=SMDocument.GetSnapNode(NLine, FBaseNode, False,0);
     if FEndNode=nil then Exit;
     CurrentStep:=2;
     Drag(SMDocument);
    end;
  2:begin
       FX:=SMDocument.CurrX;
     FY:=SMDocument.CurrY;
     FZ:=SMDocument.CurrZ;
     CurrentStep:=3;
    end;
  3:begin

      Server:=DMDocument.Server;
      Server.EventData1:=6;
      Server.EventData2:=0;
      Server.EventData3:=24;
      Server.CallDialog(sdmIntegerInput, 'Построение кривой линии',
         'Число аппроксимирующих отрезков');
      if Server.EventData3=-1 then
        N:=0
      else
        N:=Server.EventData1;
      if N=0 then begin
        DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                            SpatialModel.CurvedLines, '', ltOneToMany, CurvedLineU, True);
        CurvedLineE:=CurvedLineU as IDMElement;
        CurvedLine:=CurvedLineE as ICurvedLine;
        CurvedLineL:=CurvedLineE as ILine;

        CurvedLineL.C0:=FBaseNode;
        CurvedLineL.C1:=FEndNode;
        CurvedLine.P0X:=FX;
        CurvedLine.P0Y:=FY;
        CurvedLine.P0Z:=FZ;
        CurvedLine.P1X:=SMDocument.CurrX;
        CurvedLine.P1Y:=SMDocument.CurrY;
        CurvedLine.P1Z:=SMDocument.CurrZ;

        CurvedLineE.Draw(Painter, 0);
      end else begin
        WX0:=FBaseNode.X;
        WY0:=FBaseNode.Y;
        WZ0:=FBaseNode.Z;
        WX1:=FX;
        WY1:=FY;
        WZ1:=FZ;
        WX2:=SMDocument.CurrX;
        WY2:=SMDocument.CurrY;
        WZ2:=SMDocument.CurrZ;
        WX3:=FEndNode.X;
        WY3:=FEndNode.Y;
        WZ3:=FEndNode.Z;

        C0:=FBaseNode;

        LineCollection:=TDMCollection.Create(nil) as IDMCollection;
        LineCollection2:=LineCollection as IDMCollection2;
        for m:=1 to N do begin
          t:=m/N;
          q:=1-t;
          t2:=sqr(t);
          q2:=sqr(q);
          t3:=t2*t;
          q3:=q2*q;

          WWX1:=q3*WX0+3*q2*t*WX1+3*q*t2*WX2+t3*WX3;
          WWY1:=q3*WY0+3*q2*t*WY1+3*q*t2*WY2+t3*WY3;
          WWZ1:=q3*WZ0+3*q2*t*WZ1+3*q*t2*WZ2+t3*WZ3;
          DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                            SpatialModel.Lines, '', ltOneToMany, LineU, True);
          Line:=LineU as ILine;
          if m=N then
            C1:=FEndNode
          else begin
            DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                            SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
            C1:=CU as ICoordNode;
            C1.X:=WWX1;
            C1.Y:=WWY1;
            C1.Z:=WWZ1;
          end;
          Line.C0:=C0;
          Line.C1:=C1;

          C0:=C1;
          LineE:=Line as IDMElement;
          LineCollection2.Add(LineE);
        end;

        SMDocument.FindEndedNodes(LineCollection,C0,C1,C2);
        if (C0<>nil) and
           (C1<>nil) then begin
          aArea:=SMDocument.Find_DivideAreaWithNodes(C0,C1,C2, LineCollection, aNewArea);
          if (aArea<>nil) and
             (aNewArea<>nil) then begin
             SMDocument.Lines_AddParent(LineCollection, aArea);
             SMDocument.Lines_AddParent(LineCollection, aNewArea);
             BuildDirection:=SpatialModel2.BuildDirection;
             if SMDocument.PolyLine_BuildVerticalArea(LineCollection,
                        OperationCode, BuildDirection, aRefArea)<>nil then
               SpatialModel2.UpdateVolumes;
           end;
         end;
       end;
      CurrentStep:=-1;
    end;
  end;
  SMDocument.OperationStepExecutedFlag:=True;
end;

procedure TCreateCurvedLineOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
    -1, 0:begin Hint:=rsCurvedLineOperation + rsAction + rsCurvedLineStep1;
            ACursor:=cr_Pen_Curved; end;
    1:begin Hint:=rsCurvedLineOperation + rsAction + rsCurvedLineStep2;
            ACursor:=cr_Pen_Curved; end;
    2:begin Hint:=rsCurvedLineOperation + rsAction + rsCurvedLineStep3;
            ACursor:=cr_Pen_Curved; end;
    3:begin Hint:=rsCurvedLineOperation + rsAction + rsCurvedLineStep4;
            ACursor:=cr_Pen_Curved; end;
    else begin Hint:=rsCurvedLineOperation + rsErrOperation;
            ACursor:=0; end;
    end;        
end;

{ TCreateEllipseOperation }

procedure TCreateEllipseOperation.Drag(
  const SMDocument: TCustomSMDocument);
var
  D, dx, dy, dz, dr:double;
  WorldPointList:Variant;
  Painter:IPainter;
begin
  Painter:=SMDocument.PainterU as IPainter;

  case CurrentStep of
  1:DragLine(SMDocument);
  2:begin
      D:=DistanceFromLine(FBaseNode.X, FBaseNode.Y, FBaseNode.Z,
                          FEndNode.X, FEndNode.Y, FEndNode.Z,
                          SMDocument.CurrX,
                          SMDocument.CurrY,
                          SMDocument.CurrZ)/3*4;
      dx:=FBaseNode.X-FEndNode.X;
      dy:=FBaseNode.Y-FEndNode.Y;
      dz:=FBaseNode.Z-FEndNode.Z;

      dr:=sqrt(dx*dx+dy*dy+dz*dz);
      if SMDocument.CurrZ=FBaseNode.Z then begin
        FPX0:=FBaseNode.X+D*dy/dr;
        FPY0:=FBaseNode.Y-D*dx/dr;
        FPZ0:=FBaseNode.Z;
        FPX1:=FEndNode.X+D*dy/dr;
        FPY1:=FEndNode.Y-D*dx/dr;
        FPZ1:=FEndNode.Z;
      end else begin
        FPX0:=FBaseNode.X+D*dz/dr;
        FPY0:=FBaseNode.Y;
        FPZ0:=FBaseNode.Z-D*dx/dr;
        FPX1:=FEndNode.X+D*dz/dr;
        FPY1:=FEndNode.Y;
        FPZ1:=FEndNode.Z-D*dx/dr;
      end;

      WorldPointList:=VarArrayCreate([0,11], varDouble);

      WorldPointList[0]:=X0;
      WorldPointList[1]:=Y0;
      WorldPointList[2]:=Z0;
      WorldPointList[3]:=FPX0;
      WorldPointList[4]:=FPY0;
      WorldPointList[5]:=FPZ0;
      WorldPointList[6]:=FPX1;
      WorldPointList[7]:=FPY1;
      WorldPointList[8]:=FPZ1;
      WorldPointList[9]:=FX1;
      WorldPointList[10]:=FY1;
      WorldPointList[11]:=FZ1;
      Painter.DrawCurvedLine(WorldPointList);

      if SMDocument.CurrZ=FBaseNode.Z then begin
        FPX3:=FBaseNode.X-D*dy/dr;
        FPY3:=FBaseNode.Y+D*dx/dr;
        FPZ3:=FBaseNode.Z;
        FPX4:=FEndNode.X-D*dy/dr;
        FPY4:=FEndNode.Y+D*dx/dr;
        FPZ4:=FEndNode.Z;
      end else begin
        FPX3:=FBaseNode.X-D*dz/dr;
        FPY3:=FBaseNode.Y;
        FPZ3:=FBaseNode.Z+D*dx/dr;
        FPX4:=FEndNode.X-D*dz/dr;
        FPY4:=FEndNode.Y;
        FPZ4:=FEndNode.Z+D*dx/dr;
      end;

      WorldPointList[0]:=X0;
      WorldPointList[1]:=Y0;
      WorldPointList[2]:=Z0;
      WorldPointList[3]:=FPX3;
      WorldPointList[4]:=FPY3;
      WorldPointList[5]:=FPZ3;
      WorldPointList[6]:=FPX4;
      WorldPointList[7]:=FPY4;
      WorldPointList[8]:=FPZ4;
      WorldPointList[9]:=FX1;
      WorldPointList[10]:=FY1;
      WorldPointList[11]:=FZ1;
      Painter.DrawCurvedLine(WorldPointList);
    end;
  end;
end;

procedure TCreateEllipseOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  CurvedLine0E, CurvedLine1E:IDMElement;
  CurvedLine0, CurvedLine1:ICurvedLine;
  CurvedLine0L, CurvedLine1L:ILine;
  aNode:ICoordNode;
  NLine:ILine;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  CurvedLineU, LineU, CU: IUnknown;
  OldSnapMode:integer;
  N:integer;
  Server:IDataModelServer;
  t, t2, t3, q, q2, q3, WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, WZ2, WX3, WY3, WZ3,
  WWX1, WWY1, WWZ1:double;
  C0, C1:ICoordNode;
  Line:ILine;

  procedure DoMakeArcApproximation;
  var
    m:integer;
  begin
    C0:=FBaseNode;
    for m:=1 to N do begin
      t:=m/N;
      q:=1-t;
      t2:=sqr(t);
      q2:=sqr(q);
      t3:=t2*t;
      q3:=q2*q;

      WWX1:=q3*WX0+3*q2*t*WX1+3*q*t2*WX2+t3*WX3;
      WWY1:=q3*WY0+3*q2*t*WY1+3*q*t2*WY2+t3*WY3;
      WWZ1:=q3*WZ0+3*q2*t*WZ1+3*q*t2*WZ2+t3*WZ3;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                        SpatialModel.Lines, '', ltOneToMany, LineU, True);
      Line:=LineU as ILine;
      if m=N then
        C1:=FEndNode
      else begin
        DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                        SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
        C1:=CU as ICoordNode;
        C1.X:=WWX1;
        C1.Y:=WWY1;
        C1.Z:=WWZ1;
      end;
      Line.C0:=C0;
      Line.C1:=C1;

      C0:=C1;
    end;
  end;

begin
  OldSnapMode:=SMDocument.SnapMode;
  SMDocument.SnapMode:=smoSnapNone;
  DMDocument:=SMDocument as IDMDocument;
  Painter:=SMDocument.PainterU as IPainter;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
     DMOperationManager.StartTransaction(nil, leoAdd, rsCreateEllipse);

     aNode:=SMDocument.GetSnapNode(NLine, nil, False,0);
     Set_BaseNode(aNode, Painter);
     CurrentStep:=1;
    end;
  1:begin
     Drag(SMDocument);
     FEndNode:=SMDocument.GetSnapNode(NLine, FBaseNode, False,0);
     if FEndNode=nil then Exit;
     FX1:=FEndNode.X;
     FY1:=FEndNode.Y;
     FZ1:=FEndNode.Z;
     CurrentStep:=2;
     Drag(SMDocument);
    end;
  2:begin

      Drag(SMDocument);

      Server:=DMDocument.Server;
      Server.EventData1:=12;
      Server.EventData2:=0;
      Server.EventData3:=48;
      Server.CallDialog(sdmIntegerInput, 'Построение эллипса',
         'Число аппроксимирующих отрезков');
      if Server.EventData3=-1 then
        N:=0
      else
        N:=Server.EventData1;
      if N=0 then begin
        DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.CurvedLines, '', ltOneToMany, CurvedLineU, True);
        CurvedLine0E:=CurvedLineU as IDMElement;
        CurvedLine0:=CurvedLine0E as ICurvedLine;
        CurvedLine0L:=CurvedLine0E as ILine;

        CurvedLine0L.C0:=FBaseNode;
        CurvedLine0L.C1:=FEndNode;
        CurvedLine0.P0X:=FPX0;
        CurvedLine0.P0Y:=FPY0;
        CurvedLine0.P0Z:=FPZ0;
        CurvedLine0.P1X:=FPX1;
        CurvedLine0.P1Y:=FPY1;
        CurvedLine0.P1Z:=FPZ1;

        CurvedLine0E.Draw(Painter, 0);

        DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.CurvedLines, '', ltOneToMany, CurvedLineU, True);
        CurvedLine1E:=CurvedLineU as IDMElement;
        CurvedLine1:=CurvedLine1E as ICurvedLine;
        CurvedLine1L:=CurvedLine1E as ILine;

        CurvedLine1L.C0:=FBaseNode;
        CurvedLine1L.C1:=FEndNode;
        CurvedLine1.P0X:=FPX3;
        CurvedLine1.P0Y:=FPY3;
        CurvedLine1.P0Z:=FPZ3;
        CurvedLine1.P1X:=FPX4;
        CurvedLine1.P1Y:=FPY4;
        CurvedLine1.P1Z:=FPZ4;

        CurvedLine1E.Draw(Painter, 0);
      end else begin
        N:=N div 2 + N mod 2;

        WX0:=FBaseNode.X;
        WY0:=FBaseNode.Y;
        WZ0:=FBaseNode.Z;
        WX3:=FEndNode.X;
        WY3:=FEndNode.Y;
        WZ3:=FEndNode.Z;

        WX1:=FPX0;
        WY1:=FPY0;
        WZ1:=FPZ0;
        WX2:=FPX1;
        WY2:=FPY1;
        WZ2:=FPZ1;
        DoMakeArcApproximation;
        WX1:=FPX3;
        WY1:=FPY3;
        WZ1:=FPZ3;
        WX2:=FPX4;
        WY2:=FPY4;
        WZ2:=FPZ4;
        DoMakeArcApproximation;
      end;

      CurrentStep:=-1;
    end;
  end;
  SMDocument.SnapMode:=OldSnapMode;
  SMDocument.OperationStepExecutedFlag:=True;
end;

procedure TCreateEllipseOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
    -1, 0:begin Hint:=rsEllipseOperation + rsAction + rsEllipseStep1;
            ACursor:=cr_Pen_Ellips; end;
    1:begin Hint:=rsEllipseOperation + rsAction + rsEllipseStep2;
            ACursor:=cr_Pen_Ellips; end;
    2:begin Hint:=rsEllipseOperation + rsSizeAction + rsEllipseStep3;
            ACursor:=cr_Pen_Ellips; end;
    else begin Hint:=rsEllipseOperation + rsErrOperation;
            ACursor:=0; end;
   end;
end;

{ TCreateInclinedRectangleOperation }

procedure TCreateInclinedRectangleOperation.Drag(
  const SMDocument: TCustomSMDocument);
begin
  case CurrentStep of
  1: DragLine(SMDocument);
  2: DragRect(SMDocument, FGangle);
  end;
end;

procedure TCreateInclinedRectangleOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  EndNodeE, N0E, N1E:IDMElement;
  N0, N1:ICoordNode;
  LineB0E, LineB1E, LineA0E, LineA1E:IDMElement;
  LineB0, LineB1, LineA0, LineA1:ILine;
  rr, dx, dy, dz, cosB, sinB, cosG, sinG, cosA, sinA, B, A, G:double;
  WX2, WY2, WZ2, WX3, WY3, WZ3:double;
  NLine, aLine:ILine;
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  EndNode, aNode:ICoordNode;
  DMOperationManager:IDMOperationManager;
  i, ClassID:integer;
  DMDocument:IDMDocument;
  NodeU:IUnknown;
  LineU:IUnknown;

  AreaU:IUnknown;
  BaseAreaE:IDMElement;
//  Height:double;
  {VolumeE,} aRefElement, RefParent:IDMElement;
  ExceptNodes:IDMCollection;
  ExceptNodes2:IDMCollection2;
  BaseAreas:IDMCollection;
  GlobalData:IGlobalData;
  View:IView;
begin
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
      DMOperationManager.StartTransaction(nil, leoAdd, rsCreateInclinedRectangle);

      aNode:=SMDocument.GetSnapNode(NLine, nil, False,0);
      Set_BaseNode(aNode, Painter);
      CurrentStep:=1;
      Drag(SMDocument);
    end;
  1:begin
      Drag(SMDocument);
      dx:=FX1-X0;
      dy:=FY1-Y0;
      dz:=FZ1-Z0;
      rr:=dx*dx+dy*dy+dz*dz;
      if rr<>0 then begin
        rr:=sqrt(rr);
        cosG:=dx/rr;
        sinG:=dy/rr;
        G:=arccos(cosG)/3.1415926*180;
        if sinG<0 then
          G:=-G;
        FGAngle:=G-View.ZAngle;
        CurrentStep:=2;
      end;
    end;
  2:begin
      EndNode:=SMDocument.GetSnapNode(NLine, FBaseNode, False,0);
      if EndNode=nil then Exit;
      EndNodeE:=EndNode as IDMElement;

      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
      N0E:=NodeU as IDMElement;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
      N1E:=NodeU as IDMElement;
      N0:=N0E as ICoordNode;
      N1:=N1E as ICoordNode;

      dx:=FX1-X0;
      dy:=FY1-Y0;
      dz:=FZ1-Z0;
      rr:=dx*dx+dy*dy+dz*dz;
      if rr=0 then Exit;
      rr:=sqrt(rr);
      cosB:=dx/rr;
      sinB:=dy/rr;
      G:=FGAngle+View.ZAngle;
      cosG:=cos(G/180*3.1415926);
      sinG:=sin(G/180*3.1415926);
      cosA:=cosG*cosB+sinG*sinB;
      sinA:=sinG*cosB-cosG*sinB;
      B:=rr*cosA;
      A:=rr*sinA;
      WX2:=X0+B*cosG;
      WY2:=Y0+B*sinG;
      WZ2:=Z0;
      WX3:=X0+A*sinG;
      WY3:=Y0-A*cosG;
      WZ3:=Z0;

      N0.X:=WX2;
      N0.Y:=WY2;
      N0.Z:=WZ2;

      N1.X:=WX3;
      N1.Y:=WY3;
      N1.Z:=WZ3;

      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineB0E:=LineU as IDMElement;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineB1E:=LineU as IDMElement;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineA0E:=LineU as IDMElement;
      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineA1E:=LineU as IDMElement;
      LineB0:=LineB0E as ILine;
      LineB1:=LineB1E as ILine;
      LineA0:=LineA0E as ILine;
      LineA1:=LineA1E as ILine;

      LineB0.C0:=FBaseNode;
      LineB0.C1:=N0;
      LineB1.C0:=FBaseNode;
      LineB1.C1:=N1;
      LineA0.C0:=N0;
      LineA0.C1:=EndNode;
      LineA1.C0:=N1;
      LineA1.C1:=EndNode;

      LineB0E.Draw(Painter, 0);
      LineB1E.Draw(Painter, 0);
      LineA0E.Draw(Painter, 0);
      LineA1E.Draw(Painter, 0);


      ExceptNodes:=DataModel.CreateCollection(-1, nil);
      ExceptNodes2:=ExceptNodes as IDMCollection2;
      ExceptNodes2.Add(FBaseNode as IDMElement);
      ExceptNodes2.Add(EndNodeE);
      ExceptNodes2.Add(N0E);
      ExceptNodes2.Add(N1E);

      i:=0;
      while i<FBaseNode.Lines.Count do begin
        aLine:=FBaseNode.Lines.Item[i] as ILine;
        if aLine.C0=FBaseNode then
          aNode:=aLine.C1
        else
          aNode:=aLine.C0;
        SMDocument.GlueNode(aNode, ExceptNodes);
        if FBaseNode.Lines.IndexOf(aLine as IDMElement)<>-1 then
          inc(i);
      end;
      i:=0;
      while i<EndNode.Lines.Count do begin
        aLine:=EndNode.Lines.Item[i] as ILine;
        if aLine.C0=EndNode then
          aNode:=aLine.C1
        else
          aNode:=aLine.C0;
        SMDocument.GlueNode(aNode, ExceptNodes);
        if EndNode.Lines.IndexOf(aLine as IDMElement)<>-1 then
          inc(i);
      end;
      { TODO -o Гол. : InclineRectangl добавить опер.постр.объема }
      ClassID:=_Volume;
      if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
        GlobalData.GlobalValue[1]:=0;
        GlobalData.GlobalValue[2]:=0;
        GlobalData.GlobalIntf[1]:=nil;
      end;

      if ((ShiftState and sShift)<>0) and(SMDocument.CreateRefElement(ClassID,
                               OperationCode, nil,aRefElement, RefParent, True)) then begin

        DMOperationManager.AddElement( LineB0E.Parent,
                  (SpatialModel as ISpatialModel2).Areas, '', ltOneToMany, AreaU, True);

        BaseAreaE:=AreaU as IDMElement;

        DMOperationManager.AddElementParent( BaseAreaE, LineB0E);
        DMOperationManager.AddElementParent( BaseAreaE, LineB1E);
        DMOperationManager.AddElementParent( BaseAreaE, LineA0E);
        DMOperationManager.AddElementParent( BaseAreaE, LineA1E);

        BaseAreas:=DataModel.CreateCollection(-1, nil);
        (BaseAreas as IDMCollection2).Add(BaseAreaE);
        SetTypeVolume(SMDocument,DMOperationManager,aRefElement,RefParent,
                      BaseAreas, True);
//------------------

      end;
      CurrentStep:=-1;
    end;
  end;
  SMDocument.OperationStepExecutedFlag:=True;
end;

procedure TCreateInclinedRectangleOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
    -1, 0:begin Hint:=rsInclinedRectangleOperation + rsAction + rsInclinedRectangleStep1;
            ACursor:=cr_Pen_Incl; end;
    1:begin Hint:=rsInclinedRectangleOperation + rsAction + rsInclinedRectangleStep2;
            ACursor:=cr_Pen_Incl; end;
    2:begin Hint:=rsInclinedRectangleOperation + rsAction + rsInclinedRectangleStep3;
            ACursor:=cr_Pen_Incl; end;
    else begin Hint:=rsInclinedRectangleOperation + rsErrOperation;
            ACursor:=0; end;
   end;
end;

{ TCreateImageRectOperation }

constructor TCreateImageRectOperation.Create1(aOperationCode: integer;
  aPictureFilename:string;
  const aOperationManager:TCustomSMDocument);
begin
  inherited Create(aOperationCode, aOperationManager);
  FPictureFilename:=aPictureFilename;
end;

procedure TCreateImageRectOperation.Drag(
  const SMDocument: TCustomSMDocument);
var
  Painter:IPainter;
  View:IView;
begin
  Painter:=SMDocument.PainterU as IPainter;
  if (Painter=nil) then Exit;
  View:=Painter.ViewU as IView;
  DragRect(SMDocument, -2*View.ZAngle);
end;

procedure TCreateImageRectOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  EndNodeE:IDMElement;
  NLine:ILine;
  ImageRectE:IDMElement;
  ImageRect:IImageRect;
  ImageRectL:ILine;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  EndNode, aNode:ICoordNode;
  DMOperationManager:IDMOperationManager;
//__________________
  sgn:integer;
  X, Y, R:double;
  ImageRectU:IUnknown;
  View:IView;
begin
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  SpatialModel:=(SMDocument as IDMDocument).DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
      DMOperationManager.StartTransaction(nil, leoAdd, rsCreateImageRect);

      aNode:=SMDocument.GetSnapNode(NLine, nil, False,0);
      Set_BaseNode(aNode, Painter);
      CurrentStep:=1;
      Drag(SMDocument);
    end;
  1:begin
      EndNode:=SMDocument.GetSnapNode(NLine, FBaseNode, False,0);
      if EndNode=nil then Exit;
      EndNodeE:=EndNode as IDMElement;

      DMOperationManager.AddElement(
                          SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.ImageRects, '', ltOneToMany, ImageRectU, True);
      ImageRectE:=ImageRectU as IDMElement;

      ImageRect:=ImageRectE as IImageRect;
      ImageRectL:=ImageRectE as ILine;
      ImageRect.PictureFilename:=FPictureFilename;

      ImageRectL.C0:=FBaseNode;
      ImageRectL.C1:=EndNode;
      ImageRect.Angle:=View.Zangle;

//________________________________
     with View do begin
     If View.ZAngle<>0 then  begin
//   преобразование в новые коорд.- ось Х горизонтальна - (поворот =0)
       X :=  cosZ*(EndNode.X-FBaseNode.X) - SinZ*(EndNode.Y-FBaseNode.Y);
       Y :=  sinZ*(EndNode.X-FBaseNode.X) + CosZ*(EndNode.Y-FBaseNode.Y);
       EndNode.X := FBaseNode.X + X;
       EndNode.Y := FBaseNode.Y + Y;
     end;
//..........................
 {    if EndNode.Y-FBaseNode.Y<>0 then begin
       R:=ImageRect.PictureWidth/ImageRect.PictureHeight;  //по мах размеру рамки
       if abs((EndNode.X-FBaseNode.X)/(EndNode.Y-FBaseNode.Y))<R then begin
         if EndNode.X-FBaseNode.X>0 then
           sgn:=+1
         else
           sgn:=-1;
         EndNode.X:=round(FBaseNode.X+sgn*abs(EndNode.Y-FBaseNode.Y)*R)
     end else begin
         if EndNode.Y-FBaseNode.Y>0 then
           sgn:=+1
         else
           sgn:=-1;
         EndNode.Y:=round(FBaseNode.Y+sgn*abs(EndNode.X-FBaseNode.X)/R)
        end;
     end;    }

     if EndNode.Y-FBaseNode.Y<>0 then begin
       R:=ImageRect.PictureHeight/ImageRect.PictureWidth; //по мин размеру рамки
       if abs((EndNode.Y-FBaseNode.Y)/(EndNode.X-FBaseNode.X))<R then begin
         if EndNode.X-FBaseNode.X>0 then
           sgn:=+1
         else
           sgn:=-1;
         EndNode.X:=round(FBaseNode.X+sgn*abs(EndNode.Y-FBaseNode.Y)/R)
     end else begin
         if EndNode.Y-FBaseNode.Y>0 then
           sgn:=+1
         else
           sgn:=-1;
         EndNode.Y:=round(FBaseNode.Y+sgn*abs(EndNode.X-FBaseNode.X)*R)
        end;
     end;

//..........................
     If View.ZAngle<>0 then  begin   //..
//   преобразование в старые коорд.- ось Х с поворотом)
       X :=  cosZ*(EndNode.X-FBaseNode.X) + sinZ*(EndNode.Y-FBaseNode.Y);
       Y :=  -SinZ*(EndNode.X-FBaseNode.X) + cosZ*(EndNode.Y-FBaseNode.Y);
       EndNode.X := FBaseNode.X + X;
       EndNode.Y := FBaseNode.Y + Y;
//............................
//       C3X:=FBaseNode.X + cosZ*(EndNode.X-FBaseNode.X)- sinZ*(EndNode.Y-FBaseNode.Y);     // в нов.корд. угол 0
//       C3Y:=FBaseNode.Y;
//       X := CosZ*(C3X-FBaseNode.X) + SinZ*(C3Y-FBaseNode.Y);
//       Y := -SinZ*(C3X-FBaseNode.X) + CosZ*(C3Y-FBaseNode.Y);
//       C3X := FBaseNode.X + X;  // возврат в старые
//       C3Y := FBaseNode.Y + Y;
//       C4X:=FBaseNode.X;                                          //  в нов.корд.
//       C4Y:=FBaseNode.Y + sinZ*(EndNode.X-FBaseNode.X)+ cosZ*(EndNode.Y-FBaseNode.Y);     //
//       X := cosZ*(C4X-FBaseNode.X) + sinZ*(C4Y-FBaseNode.Y);
//       Y := -sinZ*(C4X-FBaseNode.X) + cosZ*(C4Y-FBaseNode.Y);
//       C4X := FBaseNode.X + X;  //  возврат в старые
//       C4Y := FBaseNode.Y + Y;
      end else begin
//       C3X := EndNode.X ;
//       C3Y := FBaseNode.Y;
//       C4X := FBaseNode.X;
//       C4Y := EndNode.Y;
     end;

     end;
//________________________________

     DMOperationManager.UpdateCoords( ImageRectE);


{
      ImageRect.C3X:=C3X;
      ImageRect.C3Y:=C3Y;
      ImageRect.C4X:=C4X;
      ImageRect.C4Y:=C4Y;
}
{
      Painter.DrawPicture(ImageRectL.C0.X, ImageRectL.C0.Y, ImageRectL.C0.Z,
          ImageRectL.C1.X, ImageRectL.C1.Y, ImageRectL.C1.Z,
          ImageRect.C3X, ImageRect.C3Y, ImageRectL.C0.Z,
          ImageRect.C4X, ImageRect.C4Y, ImageRectL.C1.Z, 0,
          FPictureHandle, FPictureFMT);
}
      CurrentStep:=-1;
    end;
  end;
//  (SMDocument as IDMDocument).Server.RefreshDocument;   //это RePaint
  SMDocument.OperationStepExecutedFlag:=True;
end;



procedure TCreateImageRectOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
    -1, 0:begin Hint:=rsImageRectOperation + rsAction + rsRectangleStep1;
            ACursor:=cr_Pen_Image; end;
    1:begin Hint:=rsImageRectOperation + rsAction + rsRectangleStep2;
            ACursor:=cr_Pen_Image; end;
    else begin Hint:=rsImageRectOperation + rsErrOperation;
            ACursor:=0; end;
   end;
end;

{ TCreateCoordNodeOperation }

procedure TCreateCoordNodeOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='Укажите точку размещения объекта';
  ACursor:=cr_Pen_Target;
end;

procedure TCreateCoordNodeOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  DMDocument:IDMDocument;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  aNodeE, aRefElement, RefParent:IDMElement;
  aNode:ICoordNode;
  NLine:ILine;
  OldSnapMode, ClassID, nItemIndex:integer;
  aCollection:IDMCollection;
  DataModel:IDataModel;
  GlobalData:IGlobalData;
begin
  OldSnapMode:=SMDocument.SnapMode;
  SMDocument.SnapMode:=smoSnapNone;

  DMDocument:=SMDocument as IDMDocument;
  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  DMDocument.ClearSelection(nil);

  DMOperationManager.StartTransaction(nil, leoAdd, rsCreateCoordNode);
  ClassID:=_CoordNode;
  if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
    GlobalData.GlobalValue[1]:=0;
    GlobalData.GlobalValue[2]:=0;
    GlobalData.GlobalIntf[1]:=nil;
  end;

  if SMDocument.CreateRefElement(ClassID, OperationCode, nil,
                  aRefElement, RefParent, True) then begin
    if RefParent<>nil then begin
      aNode:=SMDocument.GetSnapNode(NLine, nil, False,0);
      aNodeE:=aNode as IDMElement;
      aNodeE.Ref:=aRefElement;
      DMOperationManager.ChangeParent( nil, RefParent, aRefElement);
      aNodeE.Draw(Painter, 1);
      CurrentStep:=-1;

      aCollection:=RefParent.GetCollectionForChild(aRefElement);
      if aCollection<>nil then
        nItemIndex:=aCollection.IndexOf(aRefElement)
      else
        nItemIndex:=-1;
      SMDocument.SetDocumentOperation(aRefElement, aCollection,
                          leoAdd, nItemIndex);

    end else
      DMOperationManager.Undo;
  end;
  SMDocument.SnapMode:=OldSnapMode;
end;

procedure TSMCreateOperation.SetTypeVolume(SMDocument:TCustomSMDocument;
                               DMOperationManager:IDMOperationManager;
                               RefElement,RefParent:IDMElement;
                               const BaseAreas:IDMCollection;
                               BaseVolumeFlag:WordBool);
var
 DMDocument:IDMDocument;
 VolumeE:IDMElement;
 Volume, ParentVolume:IVolume;
 Area:IArea;
 Height:double;
 ParentVolumeE:IDMElement;
// OldState:integer;
 VolumeBuilder:IVolumeBuilder;

 procedure CreateVolumeAreaRefElements(const SMDocument: TCustomSMDocument;
                                   const VolumeE:IDMElement; BaseVolumeFlag:WordBool);
 var
  DMDocument:IDMDocument;
  SpatialModel2:ISpatialModel2;
  DMOperationManager:IDMOperationManager;
  aParent:IDMElement;
  j:integer;
  Volume:IVolume;
  AreaRef, AreaRefRef, AreaE:IDMElement;
  aName:WideString;
  aCollection:IDMCollection;
  Painter:IPainter;
  AreaU:IUnknown;
//  OldState:integer;
 begin
  DMDocument:=SMDocument as IDMDocument;
  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;
  SpatialModel2:=DMDocument.DataModel as ISpatialModel2;
  Volume:=VolumeE as IVolume;

  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 0, BaseVolumeFlag,
            aCollection, aName, AreaRefRef);
  if AreaRefRef<>nil then begin
    for j:=0 to Volume.BottomAreas.Count-1 do begin
      AreaE:=Volume.BottomAreas.Item[j];
      if AreaE.Ref=nil then begin
        DMOperationManager.AddElementRef(
                  nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaU, True);
        AreaRef:=AreaU as IDMElement;
        AreaE.Ref:=AreaRef;
        AreaRef.Draw(Painter,0);
      end;
    end;
  end;
  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 1, BaseVolumeFlag,
                           aCollection, aName, AreaRefRef);
  if AreaRefRef<>nil then begin
    for j:=0 to Volume.TopAreas.Count-1 do begin
      AreaE:=Volume.TopAreas.Item[j];
      if AreaE.Ref=nil then begin
        DMOperationManager.AddElementRef(
                  nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaU, True);
        AreaRef:=AreaU as IDMElement;
        AreaE.Ref:=AreaRef;
        AreaRef.Draw(Painter,0);
      end;
    end;
  end;
  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 2, BaseVolumeFlag,
                           aCollection, aName, AreaRefRef);
  if AreaRefRef<>nil then begin
    for j:=0 to Volume.Areas.Count-1 do begin
      AreaE:=Volume.Areas.Item[j];
      if (AreaE.Ref=nil) and
       (AreaE as IArea).IsVertical then begin
        DMOperationManager.AddElementRef(
                  nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaU, True);
        AreaRef:=AreaU as IDMElement;
        AreaE.Ref:=AreaRef;
        AreaRef.Draw(Painter,0);
      end;
    end;
  end;
  aParent:=VolumeE.Ref.Parent;
  DMOperationManager.ChangeParent( nil, aParent, VolumeE.Ref);
       //нужно обновить границы у Parent
 end;
var
  SpatialModel2:ISpatialModel2;
  BuildDirection:integer;
begin
  Area:=BaseAreas.Item[0] as IArea;

  DMDocument:=SMDocument as IDMDocument;
  VolumeBuilder:=SMDocument as IVolumeBuilder;
  try

  SpatialModel2:=(DMDocument.DataModel as ISpatialModel)as ISpatialModel2;
  Height:=SpatialModel2.DefaultVolumeHeight*100;
  BuildDirection:=SpatialModel2.BuildDirection;

  if (((BuildDirection=bdUp)  and
                              (Area.Volume0=nil)) or
      ((BuildDirection=bdDown) and
                              (Area.Volume1=nil))) then begin

    if RefParent<>nil then begin
     ParentVolumeE:=RefParent.SpatialElement;
     ParentVolume:=ParentVolumeE as IVolume;
    end;

    VolumeE:=VolumeBuilder.BuildVolume(BaseAreas, Height,
                                       BuildDirection, ParentVolume, True);
    if VolumeE<>nil then
      VolumeE.Ref:=RefElement;

    Volume:=VolumeE as IVolume;

    CreateVolumeAreaRefElements(SMDocument, VolumeE, BaseVolumeFlag);
    VolumeBuilder.CheckHAreas(ParentVolume, Volume, BuildDirection, False);
    DMOperationManager.ChangeParent( nil, RefParent, RefElement);

  end;

  finally
  end;
  SMDocument.SetDocumentOperation(VolumeE, nil, leoAdd, -1);
end;

{ TCreateLineOperation }

constructor TCreateLineOperation.Create(aOperationCode: integer;
  const aOperationManager: TCustomSMDocument);
begin
  inherited;
  FLineList0:=TList.Create;
  FLineList1:=TList.Create;
end;

destructor TCreateLineOperation.Destroy;
begin
  FLineList0.Free;
  FLineList1.Free;
  inherited;
end;

procedure TCreateLineOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);

  function Find_DivideAreaWithNodes(const theLine:ILine;
                                    BuildDirection:integer):boolean;
  var
    C0, C1:ICoordNode;
    m:integer;
    aLine:ILine;
  begin
    Result:=False;

    C0:=theLine.C0;
    m:=0;
    while m<C0.Lines.Count do begin
      aLine:=C0.Lines.Item[m] as ILine;
      if aLine.GetVerticalArea(BuildDirection)<>nil then
        Break
      else
        inc(m)
    end;
    if m=C0.Lines.Count then Exit;

    C1:=theLine.C1;
    m:=0;
    while m<C1.Lines.Count do begin
      aLine:=C1.Lines.Item[m] as ILine;
      if aLine.GetVerticalArea(BuildDirection)<>nil then
        Break
      else
        inc(m)
    end;
    if m=C1.Lines.Count then Exit;

    Result:=True;
  end;

var
  theLine:ILine;
  DMDocument:IDMDocument;
  BuildDirection:integer;
  Painter:IPainter;
  DataModel:IDataModel;
  SpatialModel2:ISpatialModel2;
  aCurrentLines:IDMCollection;
  aArea, aNewArea:IArea;
  C0, C1:ICoordNode;
//  EnabledBuildDirection:integer;
  aRefArea:IDMElement;
begin
  if CurrentStep=0 then begin
    inherited;
  end else
  if CurrentStep=1 then begin
    inherited;
    if FLineE=nil then Exit;

    DMDocument:=SMDocument as IDMDocument;
    DataModel:=DMDocument.DataModel as IDataModel;
    SpatialModel2:=DataModel as ISpatialModel2;

    Painter:=SMDocument.PainterU as IPainter;
    theLine:=FLineE as ILine;

    aCurrentLines:=DataModel.CreateCollection(-1, nil);
    (aCurrentLines as IDMCollection2).Add(FLineE);

    BuildDirection:=0;
    SpatialModel2.BuildDirection:=BuildDirection;
    SpatialModel2.EnabledBuildDirection:=1;

    if (FLineE.Parents.Count=0) and
        not Find_DivideAreaWithNodes(theLine, BuildDirection) then begin;
       C0:=theLine.C0;
       C1:=theLine.C1;
       SMDocument.LineDivideArea1(C0, C1, aCurrentLines, aArea, aNewArea, True)
    end;

  if SMDocument.PolyLine_BuildVerticalArea(aCurrentLines,
        OperationCode, BuildDirection, aRefArea)=nil then begin
    CurrentStep:=-1;
    Exit;
  end else
    SpatialModel2.UpdateVolumes;

      SpatialModel2.UpdateVolumes;

  end;
end;


procedure TCreateLineOperation.GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);
begin
   case CurrentStep of
    -1, 0:begin Hint:=rsLineOperation + rsAction + rsLineStep1;
            ACursor:=cr_Pen_Line; end;
    1:begin Hint:=rsLineOperation + rsAction + rsLineStep2;
            ACursor:=cr_Pen_Line; end;
    else begin Hint:= rsLineOperation + rsErrOperation;
            ACursor:=0; end;
   end;
end;


function FindWallNodes1(var C0, C1:ICoordNode;
                         const aCurrentLines:IDMCollection;
                         const LineList0, LineList1:TList):boolean;
var
  aLineE, theLineE:IDMElement;
  aLine, theLine:ILine;
  m:integer;
begin
  Result:=True;
  theLineE:=aCurrentLines.Item[0];
  while C0.Lines.Count=2 do begin
    aLineE:=C0.Lines.Item[0];
    if theLineE=aLineE then
      theLineE:=C0.Lines.Item[1]
    else
      theLineE:=aLineE;
    LineList0.Add(pointer(theLineE));
    theLine:=theLineE as ILine;
    if theLine.C0=C0 then
      C0:=theLine.C1
    else
      C0:=theLine.C0;
  end;
  if C0.Lines.Count<2 then
    Result:=False
  else begin
    m:=0;
    while m<C0.Lines.Count do begin
      aLine:=C0.Lines.Item[m] as ILine;
      if aLine.GetVerticalArea(bdUp)<>nil then
        Break
      else
        inc(m)
    end;
    if m=C0.Lines.Count then
      Result:=False;
  end;

  if Result then begin
    theLineE:=aCurrentLines.Item[aCurrentLines.Count-1];
    while C1.Lines.Count=2 do begin
      aLineE:=C1.Lines.Item[0];
      if theLineE=aLineE then
        theLineE:=C1.Lines.Item[1]
      else
        theLineE:=aLineE;
      LineList1.Add(pointer(theLineE));
      theLine:=theLineE as ILine;
      if theLine.C0=C1 then
        C1:=theLine.C1
      else
        C1:=theLine.C0;
    end;
    if C1.Lines.Count<2 then
      Result:=False
    else begin
      m:=0;
      while m<C1.Lines.Count do begin
        aLine:=C1.Lines.Item[m] as ILine;
        if aLine.GetVerticalArea(bdUp)<>nil then
          Break
        else
          inc(m)
      end;
      if m=C1.Lines.Count then
        Result:=False;
    end;
  end;
end;

type
  PNodeRec=^TNodeRec;
  TNodeRec=record
    Signatura:byte;
    Used:boolean;
    Node:pointer;
    LineE:pointer;
    NextNodeRec:PNodeRec;
    Distance:double;
  end;

function FindWallNodes(var C0, C1:ICoordNode;
                         const aCurrentLines:IDMCollection;
                         const LineList0, LineList1:TList):boolean;
var
  NodeRecList:TList;

  procedure AddToLeafList(const Line:ILine;
                          const NearestFromRootNodeRec:PNodeRec;
                          const LeafList:TLinkList);
  var
    aNode, Node: ICoordNode;
    NewDistance: double;
    aNodeRec:PNodeRec;
  begin
    Node:=ICoordNode(NearestFromRootNodeRec.Node);
    aNode:=Line.NextNodeTo(Node);

    if aNode.Tag<>0 then begin
      aNodeRec:=PNodeRec(pointer(aNode.Tag));
      if aNodeRec.Signatura<>$88 then
        aNodeRec:=nil
      else
      if aNodeRec.Used then
        Exit;
    end else
      aNodeRec:=nil;

    if aNodeRec=nil then begin
      GetMem(aNodeRec, SizeOf(TNodeRec));
      NodeRecList.Add(aNodeRec);
      aNodeRec.Signatura:=$88;
      aNodeRec.Used:=False;
      aNodeRec.Node:=pointer(aNode);
      aNodeRec.LineE:=nil;
      aNodeRec.NextNodeRec:=nil;
      aNodeRec.Distance:=0;
      aNode.Tag:=integer(aNodeRec);
    end;

    NewDistance:=Line.Length+NearestFromRootNodeRec.Distance;

    if aNodeRec.NextNodeRec<>nil then begin
      if NewDistance<aNodeRec.Distance then begin
        aNodeRec.NextNodeRec:=NearestFromRootNodeRec;
        aNodeRec.LineE:=pointer(Line as IDMElement);
        aNodeRec.Distance:=NewDistance;
      end;
    end else begin
      aNodeRec.NextNodeRec:=NearestFromRootNodeRec;
      aNodeRec.LineE:=pointer(Line as IDMElement);
      aNodeRec.Distance:=NewDistance;
      LeafList.Add(pointer(aNodeRec));
    end;

  end;  {AddToLeafList}

  function FindNearestFromRootNode(LeafList:TLinkList):PNodeRec;
  var
    ALink:TLink;
    SmallestDistance:double;
  begin
    ALink:=LeafList.first;
    SmallestDistance:=InfinitValue;
    Result:=nil;
    while (ALink<>nil) do begin
      if PNodeRec(ALink.body).Distance<SmallestDistance then begin
        SmallestDistance:=PNodeRec(ALink.body).Distance;
        Result:=PNodeRec(ALink.body);
      end;
      ALink:=ALink.next;
    end
  end;

  function DoFindWallNode(var C:ICoordNode;
                         const aCurrentLines:IDMCollection;
                         const LineList:TList;
                         BuildDirection:integer):boolean;
  var
    NodeRec, NearestFromRootNodeRec:PNodeRec;
    LeafList:TLinkList;
    Node, NewC, C0, C1:ICoordNode;
    Line, aLine:ILine;
    LineE:IDMElement;
    j:integer;
  begin
    Result:=False;

    NodeRecList.Clear;
    LeafList:=TLinkList.Create;

    GetMem(NodeRec, SizeOf(TNodeRec));
    NodeRecList.Add(NodeRec);
    NodeRec.Signatura:=$88;
    NodeRec.Used:=False;
    NodeRec.Node:=pointer(C);
    NodeRec.LineE:=nil;
    NodeRec.NextNodeRec:=nil;
    NodeRec.Distance:=0;
    C.Tag:=integer(NodeRec);

    LeafList.Add(NodeRec);
    NearestFromRootNodeRec:=NodeRec;
    Node:=C;

    j:=0;
    while j<Node.Lines.Count do begin
      aLine:=Node.Lines.Item[j] as ILine;
      if aLine.GetVerticalArea(BuildDirection)<>nil then
        Break
      else
        inc(j)
    end;
    if j=Node.Lines.Count then begin
      while (LeafList.First<>nil) do begin

        for j:=0 to Node.Lines.Count-1 do begin
          LineE:=Node.Lines.Item[j];
          Line:=LineE as ILine;
          C0:=Line.C0;
          C1:=Line.C1;
          if ((abs(C0.X-C1.X)>0.1) or
              (abs(C0.Y-C1.Y)>0.1)) and
             (aCurrentLines.IndexOf(LineE)=-1) then begin
            AddToLeafList(Line, NearestFromRootNodeRec, LeafList);
          end;
        end;
        LeafList.Delete(pointer(NearestFromRootNodeRec));
        NearestFromRootNodeRec.Used:=True;
        NearestFromRootNodeRec:=FindNearestFromRootNode(LeafList);
        if NearestFromRootNodeRec=nil then
          Break;
        Node:=ICoordNode(NearestFromRootNodeRec.Node);

        j:=0;
        while j<Node.Lines.Count do begin
          aLine:=Node.Lines.Item[j] as ILine;
          if aLine.GetVerticalArea(BuildDirection)<>nil then
            Break
          else
            inc(j)
        end;
        if j<Node.Lines.Count then
          Break
      end;
    end;  

    if (LeafList.First<>nil) and
     (NearestFromRootNodeRec<>nil) then begin
      NodeRec:=NearestFromRootNodeRec;
      Node:=ICoordNode(NodeRec.Node);
      Result:=True;
      NewC:=Node;
      while Node<>C do begin
        LineList.Insert(0, pointer(NodeRec.LineE));
        NodeRec:=NodeRec.NextNodeRec;
        Node:=ICoordNode(NodeRec.Node);
      end;
      C:=NewC;
    end;

    for j:=0 to NodeRecList.Count-1 do begin
      NodeRec:=NodeRecList[j];
      Node:=ICoordNode(NodeRec.Node);
      Node.Tag:=0;
      FreeMem(NodeRec, SizeOf(TNodeRec))
    end;
  end;

begin
  NodeRecList:=TList.Create;
  Result:=DoFindWallNode(C0, aCurrentLines, LineList0, bdUp);
  if Result then
    Result:=DoFindWallNode(C1, aCurrentLines, LineList1, bdUp)
  else begin
    Result:=DoFindWallNode(C0, aCurrentLines, LineList0, bdDown);
    if Result then
      Result:=DoFindWallNode(C1, aCurrentLines, LineList1, bdDown)
  end;
  NodeRecList.Free;
end;

{ TCreateCircleOperation }

procedure TCreateCircleOperation.Drag(const SMDocument: TCustomSMDocument);
begin
  DragCircle(SMDocument);
end;

procedure TCreateCircleOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  CircleU:IUnknown;
  CircleE:IDMElement;
  Circle:ICircle;
  N, m:integer;
  Server:IDataModelServer;
  R, dA, WWX1, WWY1, WWZ1:double;
  CU, LineU:IUnknown;
  C0, C1, BaseNode:ICoordNode;
  Line:ILine;
begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  if CurrentStep=0 then begin
     DMOperationManager.StartTransaction(nil, leoAdd, rsCreateLine);

     FX0:=SMDocument.CurrX;
     FY0:=SMDocument.CurrY;
     FZ0:=SMDocument.CurrZ;
     CurrentStep:=1;
     Drag(SMDocument);
  end else begin
    R:=sqrt(sqr(FX1-FX0)+
            sqr(FY1-FY0)+
            sqr(FZ1-FZ0));

    Server:=DMDocument.Server;
    Server.EventData1:=12;
    Server.EventData2:=0;
    Server.EventData3:=48;
    Server.CallDialog(sdmIntegerInput, 'Построение эллипса',
       'Число аппроксимирующих отрезков');
    if Server.EventData3=-1 then
      N:=0
    else
      N:=Server.EventData1;
    if N=0 then begin

      DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                         SpatialModel.Circles, '', ltOneToMany, CircleU, True);
      CircleE:=CircleU as IDMElement;
      Circle:=CircleE as ICircle;
      Circle.X:=FX0;
      Circle.Y:=FY0;
      Circle.Z:=FZ0;
      Circle.Radius:=R;
      CircleE.Draw(Painter, 0);
    end else begin
      dA:=2*pi/N;
      C0:=nil;
      for m:=0 to N do begin
        WWX1:=FX0+cos(dA*m)*R;
        WWY1:=FY0+sin(dA*m)*R;
        WWZ1:=FZ0;
        if m=0 then begin
          DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                        SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
          C0:=CU as ICoordNode;
          C0.X:=WWX1;
          C0.Y:=WWY1;
          C0.Z:=WWZ1;
          BaseNode:=C0;
        end else begin
          DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.Lines, '', ltOneToMany, LineU, True);
          Line:=LineU as ILine;
          if m<N then begin
            DMOperationManager.AddElement( SpatialModel.CurrentLayer as IDMElement,
                          SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
            C1:=CU as ICoordNode;
            C1.X:=WWX1;
            C1.Y:=WWY1;
            C1.Z:=WWZ1;
          end else
            C1:=BaseNode;
          Line.C0:=C0;
          Line.C1:=C1;
          C0:=C1;
        end;
      end;
    end;
    CurrentStep:=-1;
  end;
end;

procedure TCreateCircleOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  inherited;
   case CurrentStep of
    -1, 0:begin Hint:=rsCircleOperation + rsAction + rsCircleStep1;
            ACursor:=cr_Pen_Circle; end;
    1:begin Hint:=rsCircleOperation + rsAction0 + rsCircleStep2;
            ACursor:=cr_Pen_Circle; end;
    else begin Hint:=rsCircleOperation + rsErrOperation;
            ACursor:=0; end;
   end;
end;

end.


