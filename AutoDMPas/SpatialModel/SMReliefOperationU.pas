unit SMReliefOperationU;

interface
uses
   Classes,  Math, Variants, SysUtils,Dialogs,
   SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB, PainterLib_TLB, 
   DMElementU, SMSelectOperationU, SMOperationConstU,
   CustomSMDocumentU;

const
  sdmBuildRelief = $000000F0;

type

  TBuildReliefOperation=class(TSelectVerticalAreaOperation)
  private
    FDone:boolean;
  public
    procedure Stop(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

implementation

uses
  SpatialModelConstU;

{ TBuildReliefOperation }

procedure TBuildReliefOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='МОДЕЛИРОВАНИЕ РЕЛЬЕФА: Укажите смыкаемый рубеж (SHIFT - выделение рамкой, CTRL - добавить к выделению, F6 - выполнить операцию)';
  ACursor:=cr_Build_Relief;
end;

procedure TBuildReliefOperation.Stop(const SMDocument: TCustomSMDocument;
  ShiftState: integer);
var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  aDataModel:IDataModel;
  DeleteCollection:IDMCollection;
  DeleteCollection2:IDMCollection2;
  AreaE:IDMElement;
  aCaption, aPrompt:WideString;
  GlobalData:IGlobalData;
  DeleteVAreaDirection:integer;
  j:integer;
  Area:IArea;
  NodeList, TmpList, AreaList:TList;

  procedure CheckDoubleLines(const aLine:ILine);
  var
    C0, C1:ICoordNode;
    m:integer;
    theLineE:IDMElement;
    theLine:ILine;

    procedure DeleteDoubleLine;
    var
      aLineE, aAreaE:IDMElement;
      aAreaP:IPOlyline;

      procedure DeleteNulArea;
      var
        aArea:IArea;
        LineE, VolumeE:IDMElement;
      begin
        aArea:=aAreaE as IArea;
        if aArea.Volume0<>nil then begin
          VolumeE:=aArea.Volume0 as IDMElement;
          aArea.Volume0:=nil;
          DMOperationManager.UpdateElement(VolumeE);
        end;
        if aArea.Volume1<>nil then begin
          VolumeE:=aArea.Volume1 as IDMElement;
          aArea.Volume1:=nil;
          DMOperationManager.UpdateElement(VolumeE);
        end;
        while aAreaP.Lines.Count>0  do begin
          LineE:=aAreaP.Lines.Item[0];
          LineE.RemoveParent(aAreaE);
        end;
        if TMPList.IndexOf(pointer(aAreaE))=-1 then
          TMPList.Add(pointer(aAreaE));
      end;

    begin
      aLineE:=aLine as IDMElement;
      while theLineE.Parents.Count>0 do begin
        aAreaE:=theLineE.Parents.Item[0];
        aAreaE.Draw(Painter, -1);
        theLineE.RemoveParent(aAreaE);
        aAreaP:=aAreaE as IPolyline;
        if aAreaP.Lines.IndexOf(aLineE)<>-1 then
          DeleteNulArea
        else begin
          aLineE.AddParent(aAreaE);
          if AreaList.IndexOf(pointer(aAreaE))=-1 then
            AreaList.Add(pointer(aAreaE));
        end;
      end;
      theLine.C0:=nil;
      theLine.C1:=nil;
      if TMPList.IndexOf(pointer(theLineE))=-1 then
        TMPList.Add(pointer(theLineE));
    end;

  begin
    C0:=aLine.C0;
    C1:=aLine.C1;
    m:=0;
    while m<C1.Lines.Count do begin
      theLineE:=C1.Lines.Item[m];
      theLine:=theLineE as ILine;
      if theLine<>aLine then begin
        if theLine.C0=C1 then begin
          if theLine.C1=C0 then
            DeleteDoubleLine
          else
            inc(m)
        end else begin// if theLine.C1=C1
          if theLine.C0=C0 then
            DeleteDoubleLine
          else
            inc(m)
        end;
      end else
        inc(m)
    end;
  end;

  procedure ProcessNode(const C:ICoordNode);
  var
    CUp, FixedNode, DeleteNode:ICoordNode;
    VLine, VLineUp, aLine:ILine;
    m:integer;
    DeleteNodeE, VLineE, VLineUpE, aAreaE:IDMElement;
  begin
    if C<>nil then
      VLine:=C.GetVerticalLine(bdUp)
    else
      VLine:=nil;
    if VLine=nil then Exit;

    CUp:=VLine.C1;
    VLineUp:=CUp.GetVerticalLine(bdUp);
    if VLineUp<>nil then begin
      VLineUpE:=VLineUp as IDMElement;
      if VLineUpE.Parents.IndexOf(AreaE)<>-1 then
        Exit;
      for m:=0 to VLineUpE.Parents.Count-1 do begin
        aAreaE:=VLineUpE.Parents.Item[m];
        aAreaE.Draw(Painter, -1);
        if AreaList.IndexOf(pointer(aAreaE))=-1 then
          AreaList.Add(pointer(aAreaE));
      end;
    end;

    VLineE:=VLine as IDMElement;
    VLineE.Draw(Painter, -1);

    for m:=0 to VLineE.Parents.Count-1 do begin
      aAreaE:=VLineE.Parents.Item[m];
      aAreaE.Draw(Painter, -1);
    end;

    VLine.C0:=nil;
    VLine.C1:=nil;

    if DeleteVAreaDirection=0 then begin
      FixedNode:=C;
      DeleteNode:=CUp;
    end else begin
      FixedNode:=CUp;
      DeleteNode:=C;
    end;

    while DeleteNode.Lines.Count>0 do begin
      aLine:=DeleteNode.Lines.Item[0] as ILine;
      if aLine.C0=DeleteNode then
        aLine.C0:=FixedNode
      else
        aLine.C1:=FixedNode;
      CheckDoubleLines(aLine);
    end;

    m:=0;
    while m<VLineE.Parents.Count do begin
      aAreaE:=VLineE.Parents.Item[0];
      VLineE.RemoveParent(aAreaE);
      DMOperationManager.UpdateElement(aAreaE);
      DMOperationManager.UpdateCoords(aAreaE);
      aAreaE.Draw(Painter, 0);
    end;

    DeleteNodeE:=DeleteNode as IDMElement;
    DeleteCollection2.Add(DeleteNodeE);
    DeleteCollection2.Add(VLineE);
  end;

var
  C0, C1:ICoordNode;
  aAreaE, Element:IDMELement;
  OldState, OldSelectState:integer;
  FixedLines, DeleteLines, Areas:IDMCollection;
  Areas2:IDMCollection2;
begin
  if FDone then Exit;

  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    FDone:=True;
    Exit;
  end;

  DMDocument:=SMDocument as IDMDocument;
  aDataModel:=DMDocument.DataModel as IDataModel;
  if DMDocument.SelectionCount=0 then Exit;

  AreaE:=DMDocument.SelectionItem[0] as IDMElement;
  if AreaE.ClassID<>_Area then Exit;
  Area:=AreaE as IArea;
  if not Area.IsVertical then Exit;

  Painter:=SMDocument.PainterU as IPainter;

  DMOperationManager:=SMDocument as IDMOperationManager;

  aCaption:='Построение рельефа местности';
  aPrompt:='';

  Server:=DMDocument.Server;
  Server.EventData3:=0;
  Server.CallDialog(sdmBuildRelief, aCaption, aPrompt);
  Server.RefreshDocument(rfFast);

  if Server.EventData3=-1 then
    Exit;

  if aDataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
    DeleteVAreaDirection:=round(GlobalData.GlobalValue[1]);
  end else
    Exit;

  DeleteCollection:=aDataModel.CreateCollection(-1, nil);
  DeleteCollection2:=DeleteCollection as IDMCollection2;
  Areas:=aDataModel.CreateCollection(-1, nil);
  Areas2:=Areas as IDMCollection2;
  TmpList:=TList.Create;
  AreaList:=TList.Create;

  for j:=0 to DMDocument.SelectionCount-1 do begin
    AreaE:=DMDocument.SelectionItem[j] as IDMElement;
    Areas2.Add(AreaE);
  end;

  DMDocument.ClearSelection(nil);

  NodeList:=TList.Create;
  for j:=0 to Areas.Count-1 do begin
    AreaE:=Areas.Item[j] as IDMElement;
    AreaE.Draw(Painter, -1);

    Area:=AreaE as IArea;
    if Area.IsVertical then begin
      C0:=Area.C0;
      C1:=Area.C1;

      if DeleteVAreaDirection=0 then begin
        FixedLines:=Area.BottomLines;
        DeleteLines:=Area.TopLines;
      end else begin
        FixedLines:=Area.TopLines;
        DeleteLines:=Area.BottomLines;
      end;

      if FixedLines.Count<>1 then
        Continue;
      if DeleteLines.Count<>1 then
        Continue;

      if NodeList.IndexOf(pointer(C0))=-1 then
        NodeList.Add(pointer(C0));
      if NodeList.IndexOf(pointer(C1))=-1 then
        NodeList.Add(pointer(C1));
    end;
  end;

  DMOperationManager.StartTransaction(nil, leoDelete, rsDeleteVertical);

  for j:=0 to NodeList.Count-1 do begin
    C0:=ICoordNode(NodeList[j]);
    ProcessNode(C0);
  end;
  NodeList.Free;

  for j:=0 to TMPList.Count-1 do begin
    Element:=IDMElement(TMPList[j]);
    DeleteCollection2.Add(Element);
  end;
  TmpList.Free;

  for j:=0 to AreaList.Count-1 do begin
    aAreaE:=IDMElement(AreaList[j]);
    if TMPList.IndexOf(pointer(aAreaE))=-1 then begin
      DMOperationManager.UpdateElement(aAreaE);
      DMOperationManager.UpdateCoords(aAreaE);
      aAreaE.Draw(Painter, 0);
    end;
  end;
  AreaList.Free;

  OldState:=aDataModel.State;
  OldSelectState:=OLdState and dmfSelecting;
  aDataModel.State:=OldState or dmfSelecting;
  try
    DMOperationManager.DeleteElements(DeleteCollection, False);
  finally
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
  end;

  SMDocument.SetDocumentOperation(nil, nil,
                          leoDelete, -1);

  CurrentStep:=-2;
  FDone:=True;
end;

end.
