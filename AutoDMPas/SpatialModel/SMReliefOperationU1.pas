unit SMReliefOperationU1;

interface
uses
   Classes,  Math, Variants, SysUtils,Dialogs,
   SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB,
   DMElementU, SMEditOperationU,
   CustomSMDocumentU;

type

  TBuildReliefOperation=class(TSMEditOperation)
  private

    function MakeNodesList(const SMDocument:TCustomSMDocument;
                            const UsedNodes,SelectLines:IDMCollection): integer;

  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
  end;

implementation

uses
  SpatialModelConstU;

{ TBuildReliefOperation }
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII//
function TBuildReliefOperation.MakeNodesList(const SMDocument:TCustomSMDocument;
           const UsedNodes,SelectLines:IDMCollection):integer;
var
 aDocument:IDMDocument;
 aSelectCount:integer;
 aElement0:IDMElement;
 aElement0S:ISpatialElement;
 aNode,aNode1,aNode2:ICoordNode;
 aNode1E,aNode2E:IDMElement;
 aLine:ILine;
 aArea:IArea;
 aAreaP:IPolyLine;
 j,i:integer;
 aID:integer;
begin
 result:=0;
 aDocument:=(SMDocument as IDMDocument).Server.CurrentDocument;
 aSelectCount:= aDocument.SelectionCount;
 if aSelectCount=0 then Exit;

 for j:=0 to aSelectCount-1 do begin
  aElement0:=aDocument.SelectionItem[j] as IDMElement;     // j-й элемент
  if aElement0.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
//_________________ точка
  if aElement0.QueryInterface(ICoordNode, aNode)=0 then begin
   (UsedNodes as IDMCollection2).Add(aNode as IDMElement);
  end else
//_________________ линия
  if aElement0.QueryInterface(ILine, aLine)=0 then begin
   if aLine.C0.Z=aLine.C1.Z then begin
    if (SelectLines.IndexOf(aLine as IDMElement)=-1) then
      (SelectLines as IDMCollection2).Add(aLine as IDMElement);
    aNode1E:=aLine.C0 as IDMElement;
    aNode2E:=aLine.C1 as IDMElement;
    if aNode1E=aNode2E then begin
     if (UsedNodes.IndexOf((aNode1E))=-1) then
      (UsedNodes as IDMCollection2).Add(aNode1 as IDMElement)
    end else begin
     if (UsedNodes.IndexOf(aNode1E)=-1) then
      (UsedNodes as IDMCollection2).Add(aNode1E);
     if (UsedNodes.IndexOf(aNode2E)=-1) then
      (UsedNodes as IDMCollection2).Add(aNode2E);
    end;
   end else begin
    aID := aElement0.ID;
    ShowMessage('выделенный элемент - '+IntToStr(aID)+
               '   вертикальная линия,'#10#13' проверьте выделение');
    Exit;
   end
  end else
//_________________  область
  if aElement0.QueryInterface(IArea, aArea)=0 then begin
    if not aArea.IsVertical then begin
      aAreaP:=aArea as IPolyLine;
      aLine:=((aAreaP.Lines.Item[0])as ILine);
      aNode1:=aLine.C0;

      (UsedNodes as IDMCollection2).Add(aNode1 as IDMElement);

      aNode2:=aLine.C1;
      for i:=1 to aAreaP.Lines.Count-1 do begin   //по числу лин.в плоск.
       aLine:=(aAreaP.Lines.Item[i])as ILine;
       if (aLine.C0=aNode2)then begin
        aNode1:=aLine.C0;
        aNode2:=aLine.C1;
       end else begin
        aNode1:=aLine.C1;
        aNode2:=aLine.C0;
       end;

       (UsedNodes as IDMCollection2).Add(aNode1 as IDMElement);
      end;   //for i:=0 to aAreaP.Lines.Count-1

     end;     // not IsVertical
//______________________________
  end else begin
   aID := aElement0.ID;
   ShowMessage('выделенный элемент - '+IntToStr(aID)+
               '   не является линией или точкой,'#10#13' проверьте выделение');
  end;
 end;   //for j:=0 to aSelectCount-1

 result:=UsedNodes.Count;
end;

procedure TBuildReliefOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
 j,i,k,m,n,p,t:integer;
 aNodesListCount:integer;
 aNode0,aNode:ICoordNode;
 aLineE:IDMElement;
 aLine,aLineJ:ILine;
 aArea,aAreaJ:IArea;
 aAreaE,aAreaJE:IDMElement;
 aAreaP,aAreaJP:IPolyLine;
 aVolume0:IVolume;
 aProcAreasList:TList;
 aNewLines:IDMCollection;
 UsedNodes:IDMCollection;
 SelectLines:IDMCollection;
 Server: IDataModelServer;
 DMOperationManager:IDMOperationManager;
 BLine0E, BLine1E:IDMElement;
 aTmpNodesList:TList;
 SlopAreaFlag:boolean;
 SelectLinesNumber:integer;
 SelectNodesNumber:integer;
begin
 DMOperationManager:=SMDocument as IDMOperationManager;
 aProcAreasList:=TList.Create;              {сп.обработ-x.горизонт.плоск.}
 aTmpNodesList:=TList.Create;               {сп.узлов горизонт.плоск.}
 aNewLines :=TDMCollection.Create(nil) as IDMCollection; {сп.всех новых Lines}
 UsedNodes :=TDMCollection.Create(nil) as IDMCollection;
 SelectLines :=TDMCollection.Create(nil) as IDMCollection;

  {Создать список внешних (Z=0) и внутренних узлов (Z<>0)}
 aNodesListCount:=MakeNodesList(SMDocument, UsedNodes,SelectLines);
 if aNodesListCount=0 then Exit;

 DMOperationManager.StartTransaction(nil, leoAdd, rsBuildRelief);
 for j:=0 to aNodesListCount-1 do begin      {для  узлов}
  BLine0E:=nil;
  BLine1E:=nil;
  aNode0:=UsedNodes.Item[j] as ICoordNode;
  for i:=0 to aNode0.Lines.Count-1 do begin     {перебрать список выходящ. линий}
   aLineE:=aNode0.Lines.Item[i];
    for k:=0 to aLineE.Parents.Count-1 do begin   {для линий перебрать связан.плоскости}
     aAreaE:=aLineE.Parents.Item[k];
     aArea:=aAreaE as IArea;
     aVolume0:=aArea.Volume0;
     if (not (aAreaE as IArea).IsVertical) {не IsVertical,не наклон.,нет в списке}
         and (aArea.MaxZ=aArea.MinZ)
         and (aVolume0<>nil)
         and (aProcAreasList.IndexOf(pointer(aAreaE))=-1) then begin
//_____________________
       { проверяем нет ли уже наклонной плоскости}
       SlopAreaFlag:=False;
       for m:=0 to aVolume0.Areas.Count-1 do begin //по числу лин.в исх.горизонт.плоск.
         aAreaJ:=aVolume0.Areas.Item[m] as IArea;
         if  not aAreaJ.IsVertical then
          if aAreaJ.MaxZ<>aAreaJ.MinZ then begin
           SlopAreaFlag:=True;
           break;
          end;
       end;  //m
       if not SlopAreaFlag then begin
       { проверяем нужна ли наклонная плоск.  (SelectLinesNumber>1)
         и можно ли обработать горизонт.плоск. (если SelectNodesNumber>2 верт.плоск.
           то Stat=1, общий Stat=1* N плоск.)}
        aAreaP:=aArea as IPolyLine;
        aTmpNodesList.Clear;
        SelectLinesNumber:=0;
        for m:=0 to aAreaP.Lines.Count-1 do begin //по числу лин.в исх.горизонт.плоск.
         aLineJ:=(aAreaP.Lines.Item[m])as ILine;
         aAreaJ:=aLineJ.GetVerticalArea(bdUp);     //верт.плоск.Up через линию
         if aAreaJ<>nil then begin
          aAreaJP:=aAreaJ as IPolyLine;
          for n:=0 to aAreaJP.Lines.Count-1 do begin //по числу лин.в верт.плоск.
           aLine:=(aAreaJP.Lines.Item[n])as ILine;
           for t:=0 to SelectLines.Count-1 do begin
            if aLine=SelectLines.Item[t] as ILine then begin
             inc(SelectLinesNumber);
             break;
            end;
           end; // t
           for p:=0 to UsedNodes.Count-1 do begin
            aNode:=UsedNodes.Item[p] as ICoordNode;
            if ((aNode=aLine.C0)or(aNode=aLine.C1))
                and (aTmpNodesList.IndexOf(pointer(aNode))=-1) then
              aTmpNodesList.Add(pointer(aNode));      {если нет в списке}
           end;  //p
          end;  //n
         end;  //aArea<>nil
        end;   //m
        if (SelectLinesNumber>1)
           and (aTmpNodesList.Count>=aAreaP.Lines.Count) then begin
//______________________
         SMDocument.BuildReliefArea(aAreaE as IArea, aNewLines,
                UsedNodes, BLine0E, BLine1E);
        aProcAreasList.Add(pointer(aAreaE));
       end;
      end;   //  not SlopAreaFlag
     end;   //  not IsVertical  IndexOf
    end;   //  k  -Parents.Count
  end;    //  i  -Lines.Count
 end;    //  j  -Nodes.Count


 aProcAreasList.Free;

 Server:=(SMDocument as IDMDocument).Server as IDataModelServer;
 Server.RefreshDocument(rfFrontBack);   //  Repaint;
 CurrentStep:=-1;
end;
end.
