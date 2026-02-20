unit BuildFMVolumeOperationU;

interface
uses
   Classes, SysUtils, Dialogs, Graphics,
   SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB , PainterLib_TLB,
   Math, Variants,
   SMOperationU, DMElementU, SMSelectOperationU, SMCreateOperationU,
   CustomSMDocumentU, SMBuildOperationU, SMOperationConstU;


type

  TBuildFMVolumeOperation=class(TSelectLineOperation)
  private
    FDone:boolean;
    FDeletedAreaList:TList;
    procedure ProceedVolume(const SMDocument: TCustomSMDocument;
                        const VolumeE, RefElement, RefParent:IDMElement;
                        const ParentVolume:IVolume;
                        BaseVolumeFlag:WordBool);
  protected
    function GetFlagSet: integer; override;
  public
    procedure SelectByFrame(const SMDocument:TCustomSMDocument;
                      ShiftState, FlagSet: integer;
                      Tag:integer; MaxX, MinX, MaxY, MinY, MaxZ, MinZ:double); override;
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure Init; override;
    destructor Destroy; override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
    function GetModelCheckFlag:boolean; override;
  end;

function AreaFillingVolumeCheck(const SMDocument:TCustomSMDocument;
                                const SpecifiedAreas:TList;
                                const ParentVolume:IVolume;
                                BuildDirection:integer):boolean ;
procedure ExitWithMessage;
function ParametersOfBuilding(const SMDocument:TCustomSMDocument;
            const RefElement:IDMElement;
            const ParentVolume, TopVolume,BottomVolume:IVolume;
            BuildDirection:integer;
            var Height,TopHeight,BottomHeight:double;
            var TopRef, BottomRef,
                UpperVolumeLayerE, LowerVolumeLayerE, TopAreaLayerE:IDMElement):integer ;
procedure SelectedAreaListSorter(const SMDocument:TCustomSMDocument;
                              const SpatialModel2:ISpatialModel2;
                              const SelectedAreaList, AreaGroups:TList);
procedure SetLineLayers(const VolumeE, VertLayerE, TopLayerE:IDMElement);
function FindVolumeBorder(const C0:ICoordNode;const Direct:integer):WordBool ;
function FindEndingNodes(const SMDocument: TCustomSMDocument;
                         const Collection:IDMCollection;J,K:integer;
                         out C2,C3:ICoordNode):boolean;

implementation
uses
  SpatialModelConstU, Geometry, Outlines, ReorderLinesU;

{ TSMBuildVolumeOperation }

procedure MakeOutline(const AreaList, LineList :TList);
var
  j, m, k:integer;
  aAreaP:IPolyline;
  aLineE:IDMElement;
begin
  LineList.Clear;
  for j:=0 to AreaList.Count-1 do begin
    aAreaP:=IDMElement(AreaList[j]) as IPolyline;
    for m:=0 to aAreaP.Lines.Count-1 do begin
      aLineE:=aAreaP.Lines.Item[m];
      k:=LineList.IndexOf(pointer(aLineE));
      if k=-1 then
        LineList.Add(pointer(aLineE))
      else
        LineList.Delete(k);
    end;
  end;
end;

function AreaFillingVolumeCheck(const SMDocument:TCustomSMDocument;
                                const SpecifiedAreas:TList;
                                const ParentVolume:IVolume;
                                BuildDirection:integer):boolean ;
{Определяет заполняют ли Area весь объем (Result=True)}
var
  LineList1:TList;
  LineList2:IDMCollection;
  aAreaE,aLineE:IDMElement;
  aAreaP:IPolyLine;
  m,i,k:integer;
begin
  if ParentVolume=nil then begin
    Result:=True;
    Exit;
  end;

  LineList1:=TList.Create;
  LineList2:=TDMCollection.Create(nil) as IDMCollection;

  // a)Определим внешний контур SpecifiedAreas
  for m:=0 to SpecifiedAreas.Count-1 do begin
    aAreaE:=IDMElement(pointer(SpecifiedAreas[m]));
    aAreaP:=aAreaE as IPolyline;
    for k:=0 to aAreaP.Lines.Count-1 do begin
      aLineE:=aAreaP.Lines.Item[k];
      i:=LineList2.IndexOf(aLineE);
      if i=-1 then
        (LineList2 as IDMCollection2).Add(aLineE)
      else
        (LineList2 as IDMCollection2).Delete(i);
    end;
  end;

  // b)Определим внешний контур Volume
  if (BuildDirection=bdUp) then
    for m:=0 to ParentVolume.BottomAreas.Count-1 do begin
      aAreaE:=ParentVolume.BottomAreas.Item[m];
      aAreaP:=aAreaE as IPolyline;
      for k:=0 to aAreaP.Lines.Count-1 do begin
        aLineE:=aAreaP.Lines.Item[k];
        i:=LineList1.IndexOf(pointer(aLineE));
        if i=-1 then
          LineList1.Add(pointer(aLineE))
        else
          LineList1.Delete(i);
      end;
    end
  else
    for m:=0 to ParentVolume.TopAreas.Count-1 do begin
      aAreaE:=ParentVolume.TopAreas.Item[m];
      aAreaP:=aAreaE as IPolyline;
      for k:=0 to aAreaP.Lines.Count-1 do begin
        aLineE:=aAreaP.Lines.Item[k];
        i:=LineList1.IndexOf(pointer(aLineE));
        if i=-1 then
          LineList1.Add(pointer(aLineE))
        else
          LineList1.Delete(i);
      end;
    end;

    if LineList1.Count=LineList2.Count then begin  {если кол.линий одинаково}
      for k:=0 to LineList2.Count-1 do begin
        aLineE:=LineList2.Item[k];
        i:=LineList1.IndexOf(pointer(aLineE));
        if i<>-1 then           //эта линия есть
          LineList1.Delete(i);
      end;
      if LineList1.Count=0 then //и все линии совпали
        Result:=True
      else
        Result:=False;
    end else
      Result:=False;
end; //function AreaFillingVolumeCheck

procedure  ExitWithMessage;
begin
 ShowMessage('Задано недопустимое построение. Проверьте Ваши действия.');
 Exit;
end; //procedure ExitWithMessage

function ParametersOfBuilding(const SMDocument:TCustomSMDocument;
            const RefElement:IDMElement;
            const ParentVolume, TopVolume,BottomVolume:IVolume;
            BuildDirection:integer;
            var Height,TopHeight,BottomHeight:double;
            var TopRef, BottomRef,
                UpperVolumeLayerE, LowerVolumeLayerE, TopAreaLayerE:IDMElement):integer ;
{Определение для TopVolume-RefElement-BottomVolume парамтров
 автопостроения зон сверху и снизу:
 Height,TopHeight,BottomHeight - высота
 TopAreaLayerE,UpperVolumeLayerE,LowerVolumeLayerE - слой.

 Result=3 строить зоны сверху и снизу
 Result=2         снизу
 Result=1         сверху
 Result=0  зоны не строить                                             }
var
 DMOperationManager:IDMOperationManager;
 DataModel:IDataModel;
 SpatialModel:ISpatialModel;
 SpatialModel2:ISpatialModel2;
 TopVolumeE,BottomVolumeE:IDMElement;
 TopRefRef,BottomRefRef:IDMElement;
 UpperVolumeUseSpecLayer,LowerVolumeUseSpecLayer,
 TopAreaUseSpecLayer:WordBool;
 aDefaultHeight:double;                                 //Н
 AllowedHeight,AllowedTopHeight,AllowedBottomHeight:double;//допуст.Н
 aCurrZ:double;                  //Z допуст.Н
 aFreeTopHeight,aFreeBottomHeight:double;               //свобод.Н
 Flag:boolean;
begin

 DMOperationManager:=SMDocument as IDMOperationManager;
 DataModel:=(SMDocument as IDMDocument).DataModel as IDataModel;
 SpatialModel:=DataModel as ISpatialModel;
 SpatialModel2:=SpatialModel as ISpatialModel2;
 Result:=0;
 aCurrZ:=SMDocument.CurrZ;
 aDefaultHeight:=SpatialModel2.DefaultVolumeHeight*100;

 SpatialModel2.GetUpperLowerVolumeParams(RefElement,TopRefRef,BottomRefRef,
                           AllowedHeight,AllowedTopHeight,AllowedBottomHeight,
                           UpperVolumeUseSpecLayer,LowerVolumeUseSpecLayer,
                           TopAreaUseSpecLayer);
 if AllowedHeight=-1 then
  Height:=aDefaultHeight
 else
  Height:=AllowedHeight-aCurrZ;

 if UpperVolumeUseSpecLayer then
   UpperVolumeLayerE:=SpatialModel2.VerticalBoundaryLayer
 else
   UpperVolumeLayerE:=nil;

 if LowerVolumeUseSpecLayer then
   LowerVolumeLayerE:=SpatialModel2.VerticalBoundaryLayer
 else
   LowerVolumeLayerE:=nil;

 if TopAreaUseSpecLayer then
   TopAreaLayerE:=SpatialModel2.VerticalBoundaryLayer
 else
   TopAreaLayerE:=nil;

 if AllowedTopHeight=-1 then
   TopHeight:=aDefaultHeight
 else begin
   if BuildDirection=bdUp then
     TopHeight:=AllowedTopHeight-(aDefaultHeight+aCurrZ)
   else
     TopHeight:=AllowedTopHeight-aCurrZ;
 end;

 if (ParentVolume as IDMElement).Ref.Parent=nil then
  Flag:=True          //строить можно
 else
 if TopVolume=nil then //сверху зоны нет
  Flag:=True          //строить можно
 else begin
   if TopVolume<>nil then begin
     TopVolumeE:=TopVolume as IDMElement;
     aFreeTopHeight:=TopVolume.MaxZ-TopVolume.MinZ;
   end else begin
     TopVolumeE:=ParentVolume as IDMElement;
     aFreeTopHeight:=ParentVolume.MaxZ-ParentVolume.MinZ;
   end;
   if BuildDirection=bdUp then
     TopHeight:=aFreeTopHeight-Height
   else
     TopHeight:=0;
   if TopHeight>1E-0 then
    Flag:=True         //строить можно
   else begin
    Height:=Height+TopHeight; //если Н не доходит(<1 см),достроим Н до верха
    Flag:=False;
   end;
 end;

 if (TopRefRef<>nil)and Flag then begin  //строить нужно и можно
  TopRef:=DMOperationManager.CreateClone(RefElement) as IDMElement;
  TopRef.Ref:=TopRefRef;
  TopRef.Name:=DataModel.GetDefaultName(TopRefRef);

  inc(Result);
 end else //begin
  TopHeight:=0;

 if AllowedBottomHeight=-1 then
   BottomHeight:=aDefaultHeight
 else begin
   if BuildDirection=bdUp then
     BottomHeight:=AllowedBottomHeight+aCurrZ
   else
     BottomHeight:=AllowedBottomHeight-(aDefaultHeight-aCurrZ);
 end;

 if BottomVolume=nil then //внизу зоны нет
  Flag:=True          //строить можно
 else begin
  BottomVolumeE:=BottomVolume as IDMElement;
   aFreeBottomHeight:=BottomVolume.MaxZ-BottomVolume.MinZ;
   if BuildDirection=bdDown then
     BottomHeight:=aFreeBottomHeight-Height
   else
     BottomHeight:=0;
   if BottomHeight>1E-0 then
    Flag:=True         //строить можно
   else begin
    Height:=Height+BottomHeight; //если Н не доходит(<1 см),достроим Н до низа
    Flag:=False;
   end;
 end;

 if (BottomRefRef<>nil)and Flag then begin  //строить нужно и можно
  BottomRef:=DMOperationManager.CreateClone(RefElement) as IDMElement;
  BottomRef.Ref:=BottomRefRef;
  BottomRef.Name:=DataModel.GetDefaultName(BottomRefRef);

  inc(Result,2);
 end else begin
  BottomHeight:=0;
  LowerVolumeLayerE:=SpatialModel.CurrentLayer as IDMElement;
 end;

end; //function ParametersOfBuilding

procedure DoSelectedAreaListSorter(SelectedAreaList, AreaGroups:TList);
var
  k, j, m, i:integer;
  AreaE, aLineE:IDMElement;
  AreaP:IPolyline;
  LineGroupList, aLineList, aAreaList, LineList, AreaList:TList;
  p:pointer;
begin
    LineGroupList:=TList.Create;
    for k:=0 to SelectedAreaList.Count-1 do begin
      AreaE:=IDMElement(SelectedAreaList[k]);
      AreaP:=AreaE as IPolyline;
      aLineList:=nil;
      j:=0;
      while j<LineGroupList.Count do begin
        aLineList:=LineGroupList[j];
        m:=0;
        while m<AreaP.Lines.Count do begin
          aLineE:=AreaP.Lines.Item[m];
          if aLineList.IndexOf(pointer(aLineE))<>-1 then
            Break
          else
            inc(m)
        end;
        if m<AreaP.Lines.Count then
          Break
        else
          inc(j);
      end;
      if j=LineGroupList.Count then begin
        aLineList:=TList.Create;
        LineGroupList.Add(aLineList);

        aAreaList:=TList.Create;
        AreaGroups.Add(aAreaList);
      end else
        aAreaList:=AreaGroups[j];

      aAreaList.Add(pointer(AreaE));

      for m:=0 to AreaP.Lines.Count-1 do begin
        aLineE:=AreaP.Lines.Item[m];
        i:=aLineList.IndexOf(pointer(aLineE));
        if i=-1 then
          aLineList.Add(pointer(aLineE))
        else
          aLineList.Delete(i);
      end;

      inc(j);
      while j<LineGroupList.Count do begin
        LineList:=LineGroupList[j];
        m:=0;
        while m<AreaP.Lines.Count do begin
          aLineE:=AreaP.Lines.Item[m];
          if LineList.IndexOf(pointer(aLineE))<>-1 then
            Break
          else
            inc(m)
        end;
        if m<AreaP.Lines.Count then begin
          while LineList.Count>0 do begin
            p:=LineList[LineList.Count-1];
            aLineList.Add(p);
            LineList.Delete(LineList.Count-1);
          end;
          LineList.Free;
          LineGroupList.Delete(j);

          AreaList:=AreaGroups[j];
          while AreaList.Count>0 do begin
            p:=AreaList[AreaList.Count-1];
            aAreaList.Add(p);
            AreaList.Delete(AreaList.Count-1);
          end;
          AreaList.Free;
          AreaGroups.Delete(j);
        end else
          inc(j)
      end;

    end;

    while LineGroupList.Count>0 do begin
      aLineList:=LineGroupList[LineGroupList.Count-1];
      aLineList.Free;
      LineGroupList.Delete(LineGroupList.Count-1);
    end;
end;

procedure SelectedAreaListSorter(const SMDocument:TCustomSMDocument;
                              const SpatialModel2:ISpatialModel2;
                              const SelectedAreaList, AreaGroups:TList);
  {Сортировка выдел. плоскостей по их объемам}
var
  VolumeList, aAreaList:TList;
//  aParentVolume,
  aVolume, Volume:IVolume;
  Area:IArea;
  k, j:integer;
  AreaE:IDMElement;
  PX, PY, PZ:double;
begin

  if SpatialModel2.BuildJoinedVolume then begin
    DoSelectedAreaListSorter(SelectedAreaList, AreaGroups);
  end else begin
    VolumeList:=TList.Create;
    for k:=0 to SelectedAreaList.Count-1 do begin
      AreaE:=IDMElement(SelectedAreaList[k]);
      Area:=AreaE as IArea;
      Area.GetCentralPoint(PX, PY, PZ);
      Volume:=SpatialModel2.GetVolumeContaining(PX, PY, PZ);
      j:=0;
      while j<VolumeList.Count do begin
        aVolume:=IVolume(VolumeList[j]);
        if aVolume=Volume then
          break
        else
          inc(j)
      end;
      if j<VolumeList.Count then
        aAreaList:=AreaGroups[j]
      else begin
        aAreaList:=TList.Create;
        AreaGroups.Add(aAreaList);
        VolumeList.Add(pointer(Volume));
      end;
      aAreaList.Add(pointer(AreaE));
    end;
    VolumeList.Free;
  end;
end; //procedure SelectedAreaListSorter

procedure SetLineLayers(const VolumeE, VertLayerE, TopLayerE:IDMElement);
var
  aVolume:IVolume;
  aArea:IArea;
  aLineE, aAreaE, OldLayerE:IDMElement;
  j,k:integer;
  OldLayersList:TList;
begin
  if VolumeE=nil then Exit;

  aVolume:=VolumeE as IVolume;

  OldLayersList:=TList.Create;
  if VertLayerE<>nil then begin
    for j:=0 to aVolume.Areas.Count-1 do begin
      aAreaE:=aVolume.Areas.Item[j];
      aArea:=aAreaE as IArea;
      if aArea.IsVertical then begin
        OldLayerE:=nil;
        for k:=0 to aArea.BottomLines.Count-1 do begin // запоминаем слои нижних линий
           aLineE:=aArea.BottomLines.Item[k];
           OldLayerE:=aLineE.Parent;
           OldLayersList.Add(pointer(OldLayerE));
        end;
        aAreaE.Parent:=VertLayerE;                          // слой нижних линий изменяется

        for k:=0 to aArea.BottomLines.Count-1 do begin  // восстанавливаем слои нижних линий
           aLineE:=aArea.BottomLines.Item[k];
           OldLayerE:=IDMElement(OldLayersList[k]);
           aLineE.Parent:=OldLayerE;
        end;
      end; //for k
    end;  //j
  end else begin // if VertLayerE<>nil
    for j:=0 to aVolume.Areas.Count-1 do begin
      aAreaE:=aVolume.Areas.Item[j];
      aArea:=aAreaE as IArea;
      if aArea.IsVertical then begin
        if aArea.BottomLines.Count>0 then begin
          aLineE:=aArea.BottomLines.Item[0];
          aAreaE.Parent:=aLineE.Parent;
        end;
      end;
    end;
  end;
  OldLayersList.Free;

  if TopLayerE<>nil then
    for j:=0 to aVolume.TopAreas.Count-1 do begin
      aAreaE:=aVolume.TopAreas.Item[j];
      aAreaE.Parent:=TopLayerE;
    end;
end; //function SetLineLayers

function FindVolumeBorder(const C0:ICoordNode;const Direct:integer):WordBool ;
var
 j,k:integer;
 aLineE:IDMElement;
 aArea:IArea;
begin
  Result:=False;
  for j:=0 to C0.Lines.Count-1 do begin
    aLineE:=C0.Lines.Item[j];
    for k:=0 to aLineE.Parents.Count-1 do
      if aLineE.Parents.Item[k].QueryInterface(IArea, aArea)=0 then
      case Direct of
      bdUp  :if(aArea.IsVertical)
               and(aArea.BottomLines.IndexOf(aLineE)<>-1 )then begin
              Result:=True;
              break;
             end;
      bdDown:if(aArea.IsVertical)
               and(aArea.TopLines.IndexOf(aLineE)<>-1 )then begin
              Result:=True;
              break;
             end;
      end; //case
    if Result then
      break;
  end;
end; //function FindVolumeBorder()

function FindEndingNodes(const SMDocument: TCustomSMDocument;
                         const Collection:IDMCollection;J,K:integer;
                         out C2,C3:ICoordNode):boolean;
{из Collection (от j до K) извлекается  часть aLines
и для нее находятся конечн.узлы C2,C3}
var
   i:integer;
   aLines:IDMCollection;
   aLineE:IDMElement;
   C0:ICoordNode;
begin
  Result:=True;
  aLines:=TDMCollection.Create(nil) as IDMCollection;
  for i:=J to K do begin
    aLineE:=Collection.Item[i];
    if aLineE.Parents.Count<2 then
      Result:=False;
   (aLines as IDMCollection2).Add(IDMElement(aLineE));
  end;
  SMDocument.FindEndedNodes(aLines,C2,C3,C0);
end; //function FindEndingNodes


procedure TBuildFMVolumeOperation.ProceedVolume(const SMDocument: TCustomSMDocument;
                        const VolumeE, RefElement, RefParent:IDMElement;
                        const ParentVolume:IVolume;
                        BaseVolumeFlag:WordBool);
var
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  VolumeBuilder:IVolumeBuilder;
  Volume:IVolume;
  aAreaE,aLineE:IDMElement;
  aAreaP,AreaP:IPolyLine;
  VArea, aArea:IArea;
  k, m, i, j, OldState1:integer;
  Flag:boolean;
  BuildDirection:integer;
  SpatialModel2:ISpatialModel2;
  DataModel:IDataModel;
begin
    if VolumeE=nil then Exit;
    if RefParent=nil then Exit;

    Volume:=VolumeE as IVolume;
    if ParentVolume=Volume then Exit;

    VolumeE.Ref:=RefElement;

    AreaP:=Volume.BottomAreas.Item[0] as IPolyline;

    CreateVolumeAreaRefElements(SMDocument, VolumeE, RefParent, False, BaseVolumeFlag);

    DMDocument:=SMDocument as IDMDocument;
    DMOperationManager:=DMDocument as IDMOperationManager;
    VolumeBuilder:=DMDocument as IVolumeBuilder;
    DataModel:=DMDocument.DataModel as IDataModel;
    SpatialModel2:=DataModel as ISpatialModel2;
    BuildDirection:=SpatialModel2.BuildDirection;

    if (ParentVolume<>nil) then begin

      SMDocument.CheckHAreas(ParentVolume, Volume, BuildDirection, True);

      if  (Volume.BottomAreas.Count>0) then begin
        AreaP:=Volume.BottomAreas.Item[0] as IPolyline;

        m:=0;
        while m<ParentVolume.BottomAreas.Count do begin
          aAreaE:=ParentVolume.BottomAreas.Item[m];
          aAreaP:=aAreaE as IPolyline;

          OldState1:=DataModel.State;
          DataModel.State:=DataModel.State or dmfCommiting;
          Flag:=OutlineContainsOutline(aAreaP.Lines, AreaP.Lines);
          DataModel.State:=OldState1;

          if Flag then begin
            i:=0;
            while i<AreaP.Lines.Count do begin
              aLineE:=AreaP.Lines.Item[i];
              if aAreaP.Lines.IndexOf(aLineE)<>-1 then begin  // зона граничит с внешней зоной
                k:=0;
                while k<AreaP.Lines.Count do begin     // включаем границы внутренней зоны во внешнюю зону
                  aLineE:=AreaP.Lines.Item[k];
                  inc(k);
                  if aAreaP.Lines.IndexOf(aLineE)=-1 then begin
                    aLineE.AddParent(aAreaE);
                    VArea:=(aLineE as ILine).GetVerticalArea(bdUp);
                    if VArea.Volume1=nil then begin
                      VArea.Volume1IsOuter:=False;
                      VArea.Volume1:=ParentVolume;
                    end;
                  end else
                    aLineE.RemoveParent(aAreaE);
                end;
                Break;
              end else
                inc(i);
            end;

            if i<AreaP.Lines.Count then
              Break
            else
              inc(m)
          end else
            inc(m)
        end; // while m<ParentVolume.BottomAreas.Count
      end;  // if  (Volume.BottomAreas.Count>0)


      if  (Volume.TopAreas.Count>0) then begin
        AreaP:=Volume.TopAreas.Item[0] as IPolyline;
        m:=0;
        while m<ParentVolume.TopAreas.Count do begin
          aAreaE:=ParentVolume.TopAreas.Item[m];
          aAreaP:=aAreaE as IPolyline;

          OldState1:=DataModel.State;
          DataModel.State:=DataModel.State or dmfCommiting;
          Flag:=OutlineContainsOutline(aAreaP.Lines, AreaP.Lines);
          DataModel.State:=OldState1;

          if Flag then begin
            i:=0;
            while i<AreaP.Lines.Count do begin
              aLineE:=AreaP.Lines.Item[i];
              if aAreaP.Lines.IndexOf(aLineE)<>-1 then begin  // зона граничит с внешней зоной
                k:=0;
                while k<AreaP.Lines.Count do begin     // включаем границы внутренней зоны во внешнюю зону
                 aLineE:=AreaP.Lines.Item[k];
                 inc(k);
                 if aAreaP.Lines.IndexOf(aLineE)=-1 then begin
                   aLineE.AddParent(aAreaE);
                   VArea:=(aLineE as ILine).GetVerticalArea(bdDown);
                   if VArea.Volume1=nil then
                     VArea.Volume1:=ParentVolume;
                 end else
                   aLineE.RemoveParent(aAreaE);
                end;
                Break;
              end else
                inc(i);
            end;

            if aAreaP.Lines.Count=0 then begin
              if FDeletedAreaList.IndexOf(pointer(aAreaE))=-1 then begin
                 aArea:=aAreaE as IArea;
                 aArea.Volume0:=nil;
                 aArea.Volume1:=nil;
                 FDeletedAreaList.Add(pointer(aAreaE))
              end;
            end;

            if i<AreaP.Lines.Count then
              Break
            else
              inc(m);

          end else
            inc(m)
        end; // while m<ParentVolume.TopAreas.Count
      end; // if  (Volume.TopAreas.Count>0)
    end;  // if (ParentVolume<>nil)

    for j:=0 to Volume.Areas.Count-1 do begin
      aAreaE:=Volume.Areas.Item[j];
      if VolumeBuilder.AreaIsObsolet(aAreaE) and
         (FDeletedAreaList.IndexOf(pointer(aAreaE))=-1) then
        FDeletedAreaList.Add(pointer(aAreaE))
    end;
    try
    DMOperationManager.ChangeParent( nil, RefParent, RefElement);
    DMOperationManager.UpdateElement(RefElement);
    except
      raise
    end
end;

destructor TBuildFMVolumeOperation.Destroy;
begin
  inherited;
  FDeletedAreaList.Free;
end;

function TBuildFMVolumeOperation.GetFlagSet: integer;
begin
  Result:=sofOutline+sofHArea
end;

procedure TBuildFMVolumeOperation.Init;
begin
  inherited;
  FDeletedAreaList:=TList.Create;
end;

procedure TBuildFMVolumeOperation.SelectByFrame(
  const SMDocument: TCustomSMDocument; ShiftState, FlagSet, Tag: integer;
  MaxX, MinX, MaxY, MinY, MaxZ, MinZ: double);
var
  aFlagSet:integer;
  DMDocument:IDMDocument;
begin
  aFlagSet:=sofHArea;
  SelectHAreaByFrame(SMDocument, ShiftState, aFlagSet, Tag,
    MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
  DMDocument:=SMDocument as IDMDocument;
  if DMDocument.SelectionCount>0 then
    Exit;
  aFlagSet:=sofHLine;
  SelectHLineByFrame(SMDocument, ShiftState, aFlagSet, Tag,
    MaxX, MinX, MaxY, MinY, MaxZ, MinZ);
end;

procedure TBuildFMVolumeOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState:integer);
var
  DMOperationManager:IDMOperationManager;
  SMOperationManager:ISMOperationManager;
  DMDocument:IDMDocument;
  VolumeBuilder:IVolumeBuilder;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  DataModel:IDataModel;
  Painter:IPainter;
  BaseVolumeFlag:WordBool;
  BuildDirection:integer;

  procedure BuildInParentVolume(const theAreaList, LineList:TList;
                       Direction:integer;
                       Height:double;
                       const RefElement, RefParent:IDMElement;
                       const NewVolumes:IDMCollection;
                       const ParentVolume:IVolume;
                       BuildJoinedVolume, AddView:WordBool);

    function FindAcceptableArea(const Lines:IDMCollection; const AreaList:TList):integer;
    var
      j, m, N, m1, m2, k:integer;
      aLineE:IDMElement;
      aLine:ILine;
      C0, C1, theC1, theC0, aC0, aC1:ICoordNode;
      aAreaP:IPolyline;

    begin
// нельзя начинать с области, разделяющей исходный объем на несвязные части,
// либо образующей вложенный контур
      Result:=0;

      while Result<AreaList.Count do begin
        aAreaP:=IDMElement(AreaList[Result]) as IPolyline;
        N:=aAreaP.Lines.Count;
        j:=0;
        while j<N do begin
          aLineE:=aAreaP.Lines.Item[j];
          if Lines.IndexOf(aLineE)<>-1 then begin
            m1:=j; // первое касание ?
            m2:=j; // последнее касание ?
            if j=0 then begin // ищем первое касание  с другого конца списка
              m:=N-1;
              while m>0 do begin
                aLineE:=aAreaP.Lines.Item[m];
                if Lines.IndexOf(aLineE)=-1 then
                  Break
                else
                  dec(m)
              end;
              if m=0 then // область касается всеми сторонами (такое может быть
                Exit      // только если она единственная)
              else
              if m<>N-1 then
                m1:=m+1;
            end;

            aLineE:=aAreaP.Lines.Item[m1];
            aLine:=aLineE as ILine;
            theC0:=aLine.C0;
            theC1:=aLine.C1;

            m:=m2+1;
            while m<N do begin   // ищем последнее касание
              aLineE:=aAreaP.Lines.Item[m];
              if Lines.IndexOf(aLineE)=-1 then
                Break
              else
                inc(m)
            end;
            if (m=N) and
               (m1=0) then // область касается всеми сторонами (такое может быть
              Exit;     // только если она единственная)

            if m=N then
              m:=1
            else
            if m=N-1 then
              m:=0
            else
              inc(m);  // уже знаем, что m-я линия не касается
            while m<>m1 do begin // проверяем, есть ли еще касания (теперь хотя бы концом)
              aLineE:=aAreaP.Lines.Item[m];
              aLine:=aLineE as ILine;
              aC0:=aLine.C0;
              aC1:=aLine.C1;
              k:=0;
              while k<Lines.Count do begin
                aLineE:=Lines.Item[k];
                aLine:=aLineE as ILine;
                C0:=aLine.C0;
                C1:=aLine.C1;
                if (C0=aC0) and (C0<>theC0) and (C0<>theC1) then Break
                else if (C1=aC0) and (C1<>theC0) and (C1<>theC1)  then Break
                else if (C0=aC1) and (C0<>theC0) and (C0<>theC1)  then Break
                else if (C1=aC1) and (C1<>theC0) and (C1<>theC1)  then Break
                else
                  inc(k)
              end;
              if k<Lines.Count then
                Break
              else
                inc(m);
              if m=N then
                m:=0;
            end;
            if m=m1 then
              Exit // других касаний нет
            else
              Break;
          end else
            inc(j);
        end;
        inc(Result)  // область не годится, ищем дальше
      end;
      Result:=0;  // не нашли
    end;

  var
    BaseAreaE,VolumeE, LineE, aAreaE:IDMElement;
    BaseAreaP:IPolyline;
    Area:IArea;
    BaseAreas, Lines:IDMCollection;
    Lines2:IDMCollection2;
    N, j, m, k:integer;
    aRefElement:IDMElement;
    AreaGroups, AreaList:TList;
  begin
    if LineList=nil then Exit;
    BaseAreas:=TDMCollection.Create(nil) as IDMCollection;
    Lines:=TDMCollection.Create(nil) as IDMCollection;
    Lines2:=Lines as IDMCollection2;
    for m:=0 to LineList.Count-1 do begin
      LineE:=IDMElement(LineList[m]);
      Lines2.Add(LineE);
    end;
    ReorderLines0(Lines, nil);

    if BuildJoinedVolume then begin
      AreaGroups:=TList.Create;
      DoSelectedAreaListSorter(theAreaList, AreaGroups);

      N:=0;
      for m:=0 to AreaGroups.Count-1 do begin
        (BaseAreas as IDMCollection2).Clear;
        AreaList:=AreaGroups[m];
        while AreaList.Count<>0 do begin
          BaseAreaE:=IDMElement(AreaList[0]);
          Area:=BaseAreaE as IArea;
          AreaList.Delete(0);
          if ((Direction=bdUp)and((Area.Volume0=nil)or(Area.Volume0.BottomAreas.Count>1))) or
             ((Direction=bdDown)and((Area.Volume1=nil)or(Area.Volume1.TopAreas.Count>1)))then begin
            (BaseAreas as IDMCollection2).Add(BaseAreaE);
          end;
        end;

        VolumeE:=VolumeBuilder.BuildVolume(BaseAreas, Height, Direction,
                                         ParentVolume, AddView);
        if N=0 then
          aRefElement:=RefElement
        else
          aRefElement:=DMOperationManager.CreateClone(aRefElement) as IDMElement;
        inc(N);
        if VolumeE<>nil then begin
          ProceedVolume(SMDocument, VolumeE, aRefElement,RefParent,
                     ParentVolume, BaseVolumeFlag);
          DMOperationManager.UpdateElement(VolumeE);
          (NewVolumes as IDMCollection2).Add(VolumeE);
        end;
      end;

      while AreaGroups.Count>0 do begin
        AreaList:=TList(AreaGroups[0]);
        AreaList.Free;
        AreaGroups.Delete(0);
      end; //while
      AreaGroups.Free;
    end else begin // if not BuildJoinedVolume
      N:=0;
      while theAreaList.Count<>0 do begin
        j:=FindAcceptableArea(Lines, theAreaList);
        BaseAreaE:=IDMElement(theAreaList[j]);

        BaseAreaP:=BaseAreaE as IPolyline;
        for m:=0 to BaseAreaP.Lines.Count-1 do begin
          LineE:=BaseAreaP.Lines.Item[m];
          k:=Lines.IndexOf(LineE);
          if k=-1 then
            Lines2.Add(LineE)
          else
            Lines2.Delete(k);
        end;

        ReorderLines0(Lines, nil);

        Area:=BaseAreaE as IArea;
        theAreaList.Delete(j);
        if ((Direction=bdUp)and((Area.Volume0=nil)or(Area.Volume0.BottomAreas.Count>1))) or
           ((Direction=bdDown)and((Area.Volume1=nil)or(Area.Volume1.TopAreas.Count>1)))then begin //!!!!!

          (BaseAreas as IDMCollection2).Clear;
          (BaseAreas as IDMCollection2).Add(BaseAreaE);
          VolumeE:=VolumeBuilder.BuildVolume(BaseAreas, Height,Direction,
                                             ParentVolume, True);

          if N=0 then
            aRefElement:=RefElement
          else
            aRefElement:=DMOperationManager.CreateClone(aRefElement) as IDMElement;
          inc(N);
          if VolumeE<>nil then begin
            ProceedVolume(SMDocument, VolumeE,aRefElement,RefParent,
                          ParentVolume, BaseVolumeFlag);
            DMOperationManager.UpdateElement(VolumeE);
            (NewVolumes as IDMCollection2).Add(VolumeE);
          end;
        end;
      end; //while SelectedAreaList.Count<>0
    end;

    if ParentVolume<>nil then
      for j:=0 to ParentVolume.Areas.Count-1 do begin
        aAreaE:=ParentVolume.Areas.Item[j];
        DMOperationManager.UpdateElement(aAreaE);
        DMOperationManager.UpdateCoords(aAreaE);
      end;
  end; //function BuildInParentVolume(...)

  procedure BuildVolumes(const theAreaList, LineList:TList;
                         Direction:integer;
                         Height:double;
                         const RefElement, RefParent, VertLayerE, TopLayerE:IDMElement;
                         const NewVolumes:IDMCollection;
                         const ParentVolume:IVolume;
                         BuildJoinedVolume, CheckParentVolumes, AddView:WordBool);

  var
    Area:IArea;
    AreaList:TList;
    aAreaE:IDMElement;
    ParentVolumes:IDMCollection;
    ParentVolumeE:IDMElement;
    aParentVolumeE:IDMElement;
    aParentVolume:IVolume;
    VHAreas:IDMCollection;
    aRefParent:IDMElement;
    j,i:integer;
    NewVolumeE:IDMElement;
    NewVolume:IVolume;
  begin
   (NewVolumes as IDMCollection2).Clear;
    AreaList:=TList.Create;
    VHAreas:=TDMCollection.Create(nil) as IDMCollection;
    ParentVolumes:=TDMCollection.Create(nil) as IDMCollection;
    {список объемов внутри которых будут строиться нов.объемы}
    if CheckParentVolumes then begin
      for j:=0 to theAreaList.Count-1 do begin
        Area:=IDMElement(theAreaList[j]) as IArea;
        case Direction of
        bdUp  :if Area.Volume0<>nil then begin
             ParentVolumeE:=(Area.Volume0 as IDMElement);
             if ParentVolumes.IndexOf(ParentVolumeE)=-1 then
              (ParentVolumes as IDMCollection2).Add(ParentVolumeE);
            end;
        bdDown:if Area.Volume1<>nil then begin
             ParentVolumeE:=(Area.Volume1 as IDMElement);
             if ParentVolumes.IndexOf(ParentVolumeE)=-1 then
              (ParentVolumes as IDMCollection2).Add(ParentVolumeE);
            end;
        end; //case
      end; // for
    end;  // if CheckParentVolumes

    if ParentVolumes.Count<>0 then begin

      for i:=0 to ParentVolumes.Count-1 do begin
        aParentVolumeE:=ParentVolumes.Item[i];
        aParentVolume:=aParentVolumeE as IVolume;
        aRefParent:=aParentVolumeE.Ref;

        for j:=0 to theAreaList.Count-1 do begin
          aAreaE:=IDMElement(theAreaList[j]);
          if AreaList.IndexOf(pointer(aAreaE))=-1 then begin
            Area:=aAreaE as IArea;
            if Direction=bdUp then begin
              if Area.Volume0=aParentVolume then
                AreaList.Add(theAreaList[j]);
            end else
            if Area.Volume1=aParentVolume then begin
              AreaList.Add(theAreaList[j]);
            end;
          end;
        end; //for j

        BuildInParentVolume(AreaList, LineList, Direction,Height,
                        RefElement,aRefParent,
                        NewVolumes, aParentVolume, BuildJoinedVolume, AddView);
(*
        if aParentVolume<>nil then begin
  {CheckTopAreas объемов, внутри которых построены нов.объемы}
          for k:=0 to NewVolumes.Count-1 do begin
            Volume:= NewVolumes.Item[k] as IVolume;
            SMDocument.CheckHAreas(aParentVolume, Volume, BuildDirection);
          end; //for k
        end; // if aParentVolume<>nil
*)        
      end; // for i
    end else begin // if ParentVolumes.Count=0
      for j:=0 to theAreaList.Count-1 do begin
        aAreaE:=IDMElement(theAreaList[j]);
        if AreaList.IndexOf(pointer(aAreaE))=-1 then
          AreaList.Add(theAreaList[j]);
      end; //for j
      BuildInParentVolume(AreaList, LineList, Direction,Height,
                     RefElement,RefParent,
                     NewVolumes, ParentVolume, BuildJoinedVolume, AddView);
    end;

   AreaList.Free;

   for j:=0 to NewVolumes.Count-1 do begin
     NewVolumeE:=NewVolumes.Item[j];
     NewVolume:=NewVolumeE as IVolume;
     CreateVolumeAreaRefElements(SMDocument,NewVolumeE, RefParent,
                        False, BaseVolumeFlag);//уст.границы Volume
     SetLineLayers(NewVolumeE, VertLayerE, TopLayerE);
     NewVolumeE.Draw(Painter, 0);
   end;
 end; //function BuildVolumes

  procedure BuildInVolume(const SpecifiedAreas:TList;
                          const ParentVolume:IVolume;
                          const RefElement,RefParent,
                          AdditionalRefE, VertLayerE, TopLayerE:IDMElement;
                          BuildDirection:integer;
                          var NewVolume:IVolume;
                          BuildJoinedVolume, AddView:WordBool);
  var
   SpatialModel:ISpatialModel;
   SpatialModel2:ISpatialModel2;
   aRefParent:IDMElement;
   SeparateVolumeE,ParentVolumeE, aParentVolumeE, NewVolumeE, aRefElement:IDMElement;
   SeparateVolume, aParentVolume:IVolume;
   NewVolumes, Volumes:IDMCollection;
   BaseHeight,Height:double;
   K, j, m, i, l:integer;
   MinZ, MaxZ:double;
   VolumeOutline:IDMCollection;
   LineE, TopLineE, aAreaE, VAreaE, aVolumeE:IDMElement;
   aArea, VArea, TopVArea:IArea;
   DeletedAreas:IDMCollection;
   DeletedAreas2:IDMCollection2;
   LineList:TList;
  begin
    if (SpecifiedAreas=nil)or(SpecifiedAreas.Count=0)
         or(ParentVolume=nil)
            or(RefElement=nil)
               or(RefParent=nil)   then Exit;

    ParentVolumeE:=ParentVolume as IDMElement;
    SpatialModel:=DMDocument.DataModel as ISpatialModel;
    SpatialModel2:=SpatialModel as ISpatialModel2;

    if BuildDirection=bdUp then
      Height:=SpatialModel2.DefaultVolumeHeight*100
    else
      Height:=ParentVolume.MaxZ-SpatialModel2.DefaultVolumeHeight*100-
                                                     ParentVolume.MinZ;
    BaseHeight:=ParentVolume.MaxZ-ParentVolume.MinZ;

    aRefParent:=ParentVolumeE.Ref.Parent;

    //если сверху достаточно места
    if BaseHeight<Height then begin
      ShowMessage('Высота строящегося объема больше имеющегося пространства'#10#13''
                        +' для построения.'#10#13'Измените величину "Высота '
                        +'новой зоны".');
      Exit;
    end;

    LineList:=TList.Create;
    MakeOutline(SpecifiedAreas, LineList);

    Volumes:=TDMCollection.Create(nil) as IDMCollection;

    if not AreaFillingVolumeCheck(SMDocument, SpecifiedAreas,
                                  ParentVolume, BuildDirection)then begin
     //если SpecifiedAreas не заполняют весь ParentVolume, постоим SeparateVolume
     //и если BaseHeight>Heigh делить будем SeparateVolume

      BaseVolumeFlag:=True;
      BuildVolumes(SpecifiedAreas, LineList, BuildDirection, BaseHeight,
                             AdditionalRefE, aRefParent, VertLayerE, TopLayerE,
                             Volumes, ParentVolume,
                             True, True, AddView);
      if Volumes.Count>0 then begin
        SeparateVolumeE:=Volumes.Item[0];
        SeparateVolume:=SeparateVolumeE as IVolume;
        if SeparateVolumeE<>nil then begin
          SMDocument.CheckHAreas(ParentVolume, SeparateVolume, BuildDirection, False);
        end else
          SeparateVolume:=ParentVolume;   // делить ParentVolume
      end else
        SeparateVolume:=ParentVolume;
    end else begin
       SeparateVolume:=ParentVolume;
       SeparateVolumeE:=SeparateVolume as IDMElement;
       (Volumes as IDMCollection2).Add(SeparateVolumeE);
    end;

    if BaseHeight>Height then begin
                            {разделим SeparateVolume, NewVolume <- RefElement}
      if SeparateVolume=ParentVolume then
        aRefParent:=ParentVolumeE.Ref.Parent
      else
        aRefParent:=RefParent;

      if AddView then begin
        if BuildDirection=bdUp then begin
          MinZ:=SeparateVolume.MinZ;
          MaxZ:=MinZ+Height;
        end else begin
          MinZ:=SeparateVolume.MinZ+Height;
          MaxZ:=SeparateVolume.MaxZ;
        end;
        SMDocument.AddZView(MinZ, MaxZ)
      end;

      K:=2; // горизонт.делить на 2 части
      for i:=0 to Volumes.Count-1 do begin
         SeparateVolumeE:=Volumes.Item[i];
         SeparateVolume:=SeparateVolumeE as IVolume;
         if i<>0 then
           aRefElement:=DMOperationManager.CreateClone(RefElement) as IDMElement
         else
           aRefElement:=RefElement;

        if BuildDirection=bdUp then begin
          SMDocument.DivideVolume(SeparateVolume,Height,0,K, bdDown, bdUp, True, aRefElement,
                                                aRefParent,NewVolumes); // NewVolumes - выходной параметр
          NewVolumeE:=NewVolumes.Item[0];
        end else begin
          SMDocument.DivideVolume(SeparateVolume,Height,0,K, bdUp, bdDown, False, nil,
                                                  aRefParent,NewVolumes);
          NewVolumeE:=SeparateVolumeE;
          NewVolumeE.Ref:=aRefElement;
          SeparateVolumeE:=NewVolumes.Item[0];
          SeparateVolume:=SeparateVolumeE as IVolume;
        end;

        NewVolume:=NewVolumeE as IVolume;

        if SeparateVolumeE.Ref.Parent<>aRefParent then
          SeparateVolumeE.Ref.Parent:=aRefParent;
        if NewVolumeE.Ref.Parent<>aRefParent then
          NewVolumeE.Ref.Parent:=aRefParent;

        if NewVolume<>nil then begin
          aParentVolumeE:=aRefParent.SpatialElement;
          if aParentVolumeE<>nil then begin
           aParentVolume:=aParentVolumeE as IVolume;
           SMDocument.CheckHAreas(aParentVolume, NewVolume, BuildDirection, False);
          end;
        end;

        CreateVolumeAreaRefElements(SMDocument,NewVolumeE, RefParent,
                 True, BaseVolumeFlag);//уст.границы Volume
        DMOperationManager.UpdateElement(NewVolumeE);

        if (NewVolumeE<>nil) then begin
          if (NewVolumeE.Ref.Ref.Parent.ID=0) then
            SetLineLayers(NewVolumeE,VertLayerE, TopLayerE)
          else
            SetLineLayers(NewVolumeE,nil, nil);
          NewVolumeE.Draw(Painter, 0);
        end;

                                               // слияние надстроенных областей
        VolumeOutline:=TDMCollection.Create(nil) as IDMCollection;
        DeletedAreas:=TDMCollection.Create(nil) as IDMCollection;
        DeletedAreas2:=DeletedAreas as IDMCollection2;
        SpatialModel2.MakeVolumeOutline(SeparateVolume, VolumeOutline);
        for j:=0 to VolumeOutline.Count-1 do begin
          LineE:=VolumeOutline.Item[j];
          VArea:=(LineE as ILine).GetVerticalArea(bdUp);
          VAreaE:=VArea as IDMElement;
          if (VArea<>nil) and
             (VAreaE.Parent=VertLayerE) then begin
            aArea:=nil;
            m:=0;
            while m<LineE.Parents.Count do begin
              aAreaE:=LineE.Parents.Item[m];
              if aAreaE.QueryInterface(IArea, aArea)=0 then begin
                if (not aArea.IsVertical) and
                   (aArea.Volume0<>SeparateVolume) then
                  break
                else
                  inc(m)
              end else
                inc(m)
            end;
            if m<LineE.Parents.Count then begin
              aVolumeE:=aArea.Volume0 as IDMElement;
              if (aVolumeE<>nil) and
                 (aVolumeE.Ref.Ref=SeparateVolumeE.Ref.Ref) then begin
                l:=0;
                while l<VArea.TopLines.Count do begin
                  TopLineE:=VArea.TopLines.Item[l];
                  TopVArea:=(TopLineE as ILine).GetVerticalArea(bdUp);
                  if TopVArea=nil then
                    inc(l)
                  else
                    Break
                end;
                if l=VArea.TopLines.Count then
                  DeletedAreas2.Add(VAreaE);
              end;
            end;
          end; // if VArea<>nil
        end; //for j:=0 to VolumeOutline.Count-1
        if DeletedAreas.Count>0 then
          DMOperationManager.DeleteElements(DeletedAreas, False);
      end; // m:=0 to Volumes.Count-1
    end; // if BaseHeight>Height

    if (SpecifiedAreas.Count>1) and
       (not BuildJoinedVolume) then begin

      aRefElement:=DMOperationManager.CreateClone(RefElement) as IDMElement;

      SpecifiedAreas.Delete(0);
      BaseVolumeFlag:=True;
      BuildVolumes(SpecifiedAreas, LineList, BuildDirection, Height,
                             aRefElement,aRefParent, nil, nil,
                             NewVolumes, NewVolume,    // NewVolumes - входной параметр
                             False, False, AddView);
      for j:=0 to NewVolume.Areas.Count-1 do begin
        aAreaE:=NewVolume.Areas.Item[j];
        DMOperationManager.UpdateElement(aAreaE);
        DMOperationManager.UpdateCoords(aAreaE);
      end;

      for j:=0 to ParentVolume.Areas.Count-1 do begin
        aAreaE:=ParentVolume.Areas.Item[j];
        DMOperationManager.UpdateElement(aAreaE);
        DMOperationManager.UpdateCoords(aAreaE);
      end;

    end;
    LineList.Free;
  end; //procedure BuildInVolume

var
  aVolumeE, NewVolumeE,ParentVolumeE, BaseVolumeE:IDMElement;
  RefParent, RefParent0:IDMElement;
  TopRefElement:IDMElement;
  i, m, N:integer;
  Height:double;
  aVolume,NewVolume,ParentVolume, aParentVolume, BaseVolume:IVolume;
  TopVolume, BottomVolume:IVolume;
  AreaList:TList;
  SelectedAreaList:TList;
  BaseAreas:IDMCollection;

  aNewVolumes:IDMCollection;
  aTopNewVolumes:IDMCollection;
  aBottomNewVolumes:IDMCollection;

  SpecifiedAreas:TList;
  AreaGroups:TList;
  TopVolumeE:IDMElement;
  TopHeight,BottomHeight:double;
  RefElement,BottomRefElement:IDMElement;
  UpperVolumeLayerE, LowerVolumeLayerE, TopAreaLayerE:IDMElement;
  BottomVolumeE:IDMElement;
  aMode:integer;
  CurrentLayer:ILayer;
  BaseArea, aArea:IArea;
  BaseAreaE, aRefElement, aElement:IDMElement;
  ClassID:integer;
  PX, PY, PZ:double;
  DMClassCollections:IDMClassCollections;
  RefSource, aCollection:IDMCollection;
  LineList:TList;
  EnabledBuildDirection:integer;
  GlobalData:IGlobalData;
  EnableJoinVolumes:boolean;
  Unk:IUnknown;

  function CheckBuildDirection(aBuildDirection:integer; AreaGroups:TList):boolean;
  var
    SpecifiedAreas:TList;
    BaseAreaE, BaseVolumeE:IDMElement;
    BaseArea:IArea;
    BaseVolume, TopVolume, BottomVolume:IVolume;
    j:integer;
  begin
    Result:=True;
    j:=0;
    while j<AreaGroups.Count do begin
      SpecifiedAreas:=TList(AreaGroups[j]);
      BaseAreaE:=IDMElement(pointer(SpecifiedAreas[0]));
      BaseArea:=BaseAreaE as IArea;

      BaseVolume:=nil;

      TopVolume:=BaseArea.Volume0;
      if TopVolume<>nil then begin
        TopVolumeE:=TopVolume as IDMElement;
        if (aBuildDirection=bdUp)then
          BaseVolume:=TopVolume;
      end;

      BottomVolume:=BaseArea.Volume1;
      if BottomVolume<>nil then begin
        BottomVolumeE:=BottomVolume as IDMElement;
        if (aBuildDirection=bdDown)then
          BaseVolume:=BottomVolume;
      end;

      BaseVolumeE:=BaseVolume as IDMElement;
      
      if (BaseVolume=nil) or
         ((aBuildDirection=bdUp)and(BaseArea.Volume0.BottomAreas.Count>1)) or
         ((aBuildDirection=bdDown)and(BaseArea.Volume1.TopAreas.Count>1)) or
         (BaseVolumeE.Ref.Ref.Parent.ID=0)then    // всю открытую зону застраиваем
        Exit
      else
        inc(j)
    end;
    Result:=False;
  end;

  procedure MakeSelectedAreaList(SelectedAreaList:TList);
  var
    LineList, BuisyList, UsedList:TList;

    procedure DoMakeAreaList(const theArea:IArea);
    var
      j, i:integer;
      Area, aArea:IArea;
      theAreaE:IDMElement;
      theAreaP:IPolyline;
      LineE:IDMELement;
      Line:ILine;
      C0, C1:ICoordNode;
      X0, Y0, X1, Y1, theX, theY, theZ,
      W0X, W0Y, W1X, W1Y,
      X, Y, cosX, cosY, ProjL:double;
      TMPList:TList;
    begin
      theAreaE:=theArea as IDMElement;
      SelectedAreaList.Add(pointer(theAreaE));
      theAreaP:=theArea as IPolyline;

      TMPList:=TList.Create;
      for j:=0 to theAreaP.Lines.Count-1 do begin
        LineE:=theAreaP.Lines.Item[j];
        if (LineList.IndexOf(pointer(LineE))<>-1) and
           (BuisyList.IndexOf(pointer(LineE))=-1) then begin
          TMPList.Add(pointer(LineE));
          BuisyList.Add(pointer(LineE));
        end;
      end;

      for j:=0 to TMPList.Count-1 do begin
        LineE:=IDMElement(TMPList[j]);
        i:=UsedList.IndexOf(pointer(LineE));
        if i=-1 then begin
          UsedList.Add(pointer(LineE));

          Line:=LineE as ILine;
          C0:=Line.C0;
          C1:=Line.C1;
          X0:=C0.X;
          Y0:=C0.Y;
          X1:=C1.X;
          Y1:=C1.Y;

          X:=0.5*(X1+X0);
          Y:=0.5*(Y1+Y0);
          ProjL:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
          cosX:=(X1-X0)/ProjL;
          cosY:=(Y1-Y0)/ProjL;

          W0X:=X-5*cosY;
          W0Y:=Y+5*cosX;
          W1X:=X+5*cosY;
          W1Y:=Y-5*cosX;

          if theArea.ProjectionContainsPoint(W0X, W0Y, 0) then begin
            theX:=W1X;
            theY:=W1Y;
          end else begin
            theX:=W0X;
            theY:=W0Y;
          end;
          theZ:=C0.Z;

          DataModel.State:=DataModel.State or dmfCommiting;
          aArea:=SpatialModel2.BuildAreaSurrounding(theX, theY, theZ);
          DataModel.State:=DataModel.State and not dmfCommiting;

          if aArea<>nil then begin
            Area:=SpatialModel2.GetAreaEqualTo(aArea);
            if Area=nil then
              DoMakeAreaList(aArea)
          end;

        end // if LineList.IndexOf(pointer(LineE))<>-1
      end; // for j:=0 to theAreaP.Lines.Count

      TMPList.Free;

      for j:=0 to theAreaP.Lines.Count-1 do begin
        LineE:=theAreaP.Lines.Item[j];
        i:=UsedList.IndexOf(pointer(LineE));
        if i=-1 then
          UsedList.Add(pointer(LineE));
      end;


    end;

  var
    j:integer;
    LineE:IDMElement;
    MinX, MinY, MinZ, MaxX, MaxY, MaxZ,
    theX, theY, theZ:Double;
    theArea, Area:IArea;


  begin
    SMOperationManager.CalcSelectionLimits(MinX, MinY, MinZ, MaxX, MaxY, MaxZ);
    if MaxZ<>MinZ then Exit;

    theX:=0.5*(MinX+MaxX);
    theY:=0.5*(MinY+MaxY);
    theZ:=MinZ;

    DataModel.State:=DataModel.State or dmfCommiting;
    theArea:=SpatialModel2.BuildAreaSurrounding(theX, theY, theZ);
    DataModel.State:=DataModel.State and not dmfCommiting;
    if theArea=nil then Exit;

    Area:=SpatialModel2.GetAreaEqualTo(theArea);
    if Area<>nil then Exit;

    LineList:=TList.Create;
    BuisyList:=TList.Create;
    UsedList:=TList.Create;
    try
    for j:=0 to DMDocument.SelectionCount-1 do begin
      LineE:=DMDocument.SelectionItem[j] as IDMElement;
      LineList.Add(pointer(LineE));
    end;

    DoMakeAreaList(theArea);

    finally
      LineList.Free;
      BuisyList.Free;
      UsedList.Free;
    end;
  end;


  procedure CheckParentVolume(var ParentVolume:IVolume; const LineList:TList);
  var
    aOutline, Outline:IDMCollection;
    aOutline2:IDMCollection2;
    j:integer;
    LineE:IDMElement;
  begin
    Outline:=TDMCollection.Create(nil) as IDMCollection;
    SpatialModel2.MakeVolumeOutline(ParentVolume, Outline);
    aOutline:=TDMCollection.Create(nil) as IDMCollection;
    aOutline2:=aOutline as IDMCollection2;
    for j:=0 to LineList.Count-1 do begin
      LineE:=IDMElement(LineList[j]);
      aOutline2.Add(LineE)
    end;
    if OutlineContainsOutline(Outline, aOutline) then Exit;
    ParentVolume:=SpatialModel2.GetOuterVolume(ParentVolume as IDMElement) as IVolume;
  end;

var
  Element, AreaE:IDMElement;
  BuildJoinedVolume:WordBool;
  Area:IArea;
  OldState, OldSelectState:integer;
  DeletedAreas:IDMCollection;
  DeletedAreas2:IDMCollection2;
  j:integer;
  aAreaE:IDMElement;
  View:IView;
begin
  if FDone then Exit;

  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    FDone:=True;
    Exit;
  end;

  ClassID:=_Volume;

  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel2:=DataModel as ISpatialModel2;
  SpatialModel:=SpatialModel2 as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  SMOperationManager:=SMDocument as ISMOperationManager;

  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  CurrentLayer:=SpatialModel.CurrentLayer;

  VolumeBuilder:=SMDocument as IVolumeBuilder;

  if DMDocument.SelectionCount=0 then Exit;

  SelectedAreaList:=SMDocument.SelectedAreaList;
  if SelectedAreaList.Count=0 then begin
    if DMDocument.SelectionCount=0 then Exit;
    Element:=DMDocument.SelectionItem[0] as IDMElement;
    if Element.QueryInterface(ILine, Unk)=0 then
      MakeSelectedAreaList(SelectedAreaList)
    else
      Exit;
    if SelectedAreaList.Count=0 then Exit;
  end;

  RefElement:=nil;

  AreaList:=TList.Create;
  LineList:=TList.Create;
  AreaGroups:=TList.Create;
  aNewVolumes:=TDMCollection.Create(nil) as IDMCollection;
  BaseAreas:=TDMCollection.Create(nil) as IDMCollection;
  aTopNewVolumes:=TDMCollection.Create(nil) as IDMCollection;
  aBottomNewVolumes:=TDMCollection.Create(nil) as IDMCollection;

  try
  DMOperationManager.StartTransaction(nil, leoAdd, rsBuildVolume);

  DMDocument.Server.EventData3:=0;
  DMDocument.Server.CallDialog(sdmPleaseWait, '', 'Подготовка к построению зон');
  try
  SelectedAreaListSorter(SMDocument, SpatialModel2,
                      SelectedAreaList, AreaGroups);

  EnableJoinVolumes:=
    (DMDocument.SelectionCount>1) and
    (DMDocument.SelectionItem[0].QueryInterface(IArea, Unk)=0);

  OldState:=DataModel.State;
  OldSelectState:=OldState and dmfSelecting;
  DataModel.State:=OldState or dmfSelecting;
  try
  while DMDocument.SelectionCount>0 do begin
    aElement:=DMDocument.SelectionItem[DMDocument.SelectionCount-1] as IDMElement;
    aElement.Selected:=False;  // ClearSelection использовать нельзя,
    aElement.Draw(Painter, 0); // т.к. там вызывается ClearSelectedAreaList
  end;
  finally
    DataModel.State:=DataModel.State and not dmfSelecting or OldSelectState;
  end;

  EnabledBuildDirection:=0;
  if CheckBuildDirection(bdUp, AreaGroups) then
    EnabledBuildDirection:=EnabledBuildDirection or 1;
  if CheckBuildDirection(bdDown, AreaGroups) then
    EnabledBuildDirection:=EnabledBuildDirection or 2;
  SpatialModel2.EnabledBuildDirection:=EnabledBuildDirection;

  finally
    DMDocument.Server.EventData3:=-1;  // закрыть диалог
    DMDocument.Server.CallDialog(sdmPleaseWait, '', '');
  end;

  if EnabledBuildDirection=0 then begin
    DMDocument.Server.SelectionChanged(nil);
    Exit;
  end;

  BuildDirection:=SpatialModel2.BuildDirection;

  N:=1;

  RefElement:=nil;
  RefParent:=nil;
  while AreaGroups.Count>0 do begin
    SpecifiedAreas:=TList(AreaGroups[0]);

    BaseAreaE:=IDMElement(pointer(SpecifiedAreas[0]));
    BaseArea:=BaseAreaE as IArea;

    TopVolume:=BaseArea.Volume0;
    TopVolumeE:=TopVolume as IDMElement;
    BottomVolume:=BaseArea.Volume1;
    BottomVolumeE:=BottomVolume as IDMElement;

    if ((TopVolume<>nil) and
          ((TopVolume.BottomAreas.Count>1) or
           (TopVolumeE.Ref.Ref.Parent.ID=0)))  or   // всю открытую зону застраиваем
       ((BottomVolume<>nil) and
          ((BottomVolume.TopAreas.Count>1) or
           (BottomVolumeE.Ref.Ref.Parent.ID=0))) or
       (TopVolume=nil) or (BottomVolume=nil)    then begin
      if N=1 then begin
        if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
          GlobalData.GlobalValue[1]:=0;
          GlobalData.GlobalValue[2]:=0;
          GlobalData.GlobalValue[3]:=ord(EnableJoinVolumes);
          GlobalData.GlobalIntf[1]:=nil;
        end;

        if not SMDocument.CreateRefElement(ClassID, OperationCode, nil,
                                         RefElement, RefParent0, True) then begin
          Exit;
        end else begin
          DMDocument.Server.EventData3:=0;
          DMDocument.Server.CallDialog(sdmPleaseWait, '', 'Построение зон');
          BuildDirection:=SpatialModel2.BuildDirection;
          BuildJoinedVolume:=SpatialModel2.BuildJoinedVolume;
        end;

      end else begin
        RefElement:=DMOperationManager.CreateClone(RefElement) as IDMElement;
        inc(N);
      end;
    end else begin
      TList(pointer(AreaGroups[0])).Free;
      AreaGroups.Delete(0);
      Continue;
    end;

    BaseVolume:=nil;
    if TopVolume<>nil then begin
      if (BuildDirection=bdUp)then
        BaseVolume:=TopVolume;
    end;
    if BottomVolume<>nil then begin
      if (BuildDirection=bdDown)then
        BaseVolume:=BottomVolume;
    end;
    if (BaseVolume<>nil)then
      BaseVolumeE:=BaseVolume as IDMElement;

    MakeOutline(SpecifiedAreas, LineList);

    BaseArea.GetCentralPoint(PX, PY, PZ);
    if BuildDirection=bdDown then
      PZ:=PZ-10;

    OldState:=DataModel.State;
    OldSelectState:=OldState and dmfSelecting;
    DataModel.State:=DataModel.State or dmfSelecting;
    try
    BaseAreaE.Selected:=True;
    SpatialModel2.GetRefElementParent(ClassID, OperationCode, PX, PY, PZ, RefParent,
                   DMClassCollections, RefSource, aCollection);
    BaseAreaE.Selected:=False;
    finally
      DataModel.State:=DataModel.State and not dmfSelecting or OldSelectState;
    end;

    if RefParent<>nil then begin
      ParentVolumeE:=RefParent.SpatialElement;
      ParentVolume:=ParentVolumeE as IVolume;
    end;

    CheckParentVolume(ParentVolume, LineList);

    if BuildDirection=bdUp then begin
      if TopVolumeE<>nil then
        RefParent:=TopVolumeE.Ref.Parent;
    end else
      if BottomVolumeE<>nil then
        RefParent:=BottomVolumeE.Ref.Parent;

    aMode:=ParametersOfBuilding(SMDocument, RefElement, ParentVolume, TopVolume,BottomVolume,
                                       BuildDirection, Height, TopHeight,BottomHeight,
                                       TopRefElement,BottomRefElement,
                                       UpperVolumeLayerE,LowerVolumeLayerE,
                                       TopAreaLayerE);

    (BaseAreas as IDMCollection2).Clear;
    (aNewVolumes as IDMCollection2).Clear;
    SMDocument.NewZView:=nil;

//        начало построения
//==========================================================================
    if (TopVolume=nil)and(BottomVolume=nil) then begin
//------------------------------------------------------------------------//
  {если вверху и внизу "пусто" - строим последовательным порядком}
//------------------------------------------------------------------------//
                       {основное построение}
      BaseVolumeFlag:=True;
      BuildVolumes(SpecifiedAreas, LineList, BuildDirection,Height,
                             RefElement,RefParent, nil, TopAreaLayerE,
                             aNewVolumes, ParentVolume,
                             BuildJoinedVolume, True, True);
      if aNewVolumes.Count=0 then
        ExitWithMessage
      else begin
        if aMode<>0 then begin
   {если нужно автo. достроить вверх и-или вниз
                                        (TopRefElement/BottomRefElement)<>nil}
          if TopRefElement<>nil then begin
            AreaList.Clear;
            for i:=0 to aNewVolumes.Count-1 do begin
              NewVolumeE:=aNewVolumes.Item[i];
              NewVolume:=NewVolumeE as IVolume;
              DMOperationManager.UpdateElement(NewVolumeE);
                                         { достроить Up от NewVolume.TopAreas}
              for m:=0 to NewVolume.TopAreas.Count-1 do
                AreaList.Add(pointer(NewVolume.TopAreas.Item[m]));
            end; // i
            MakeOutline(AreaList, LineList);

            aArea:=NewVolume.TopAreas.Item[0] as IArea;
            aArea.GetCentralPoint(PX, PY, PZ);
            aParentVolume:=SpatialModel2.GetVolumeContaining(PX, PY, PZ);
            BaseVolumeFlag:=False;
            BuildVolumes(AreaList, LineList, bdUp,TopHeight,
                                 TopRefElement,RefParent,UpperVolumeLayerE, nil,
                                 aTopNewVolumes, aParentVolume, True, True, True);
//                                 aTopNewVolumes, aParentVolume, True, True, False);

            if aTopNewVolumes.Count=0 then
              ExitWithMessage
            else begin
              aVolumeE:=aTopNewVolumes.Item[0];
              DMOperationManager.UpdateElement(aVolumeE);
            end;
          end;  // TopRefElement<>nil

          if BottomRefElement<>nil then begin
            AreaList.Clear;
            for i:=0 to aNewVolumes.Count-1 do begin
              NewVolumeE:=aNewVolumes.Item[i];
              NewVolume:=NewVolumeE as IVolume;
              DMOperationManager.UpdateElement(NewVolumeE);
                                           { достроить Down от NewVolume.BottomAreas}
              for m:=0 to NewVolume.BottomAreas.Count-1 do
                AreaList.Add(pointer(NewVolume.BottomAreas.Item[m]));
            end; // i
            MakeOutline(AreaList, LineList);

            aArea:=NewVolume.BottomAreas.Item[0] as IArea;
            aArea.GetCentralPoint(PX, PY, PZ);
            aParentVolume:=SpatialModel2.GetVolumeContaining(PX, PY, PZ-10);
            BaseVolumeFlag:=False;
            BuildVolumes(AreaList, LineList, bdDown,BottomHeight,
                             BottomRefElement,RefParent,LowerVolumeLayerE, nil,
                             aBottomNewVolumes, aParentVolume, True, True, False);
            if aBottomNewVolumes.Count=0 then
              ExitWithMessage
            else begin
              aVolumeE:=aBottomNewVolumes.Item[0];
              DMOperationManager.UpdateElement(aVolumeE);
            end;
          end;  // BottomRefElement<>nil
        end;    //   aMode<>0
      end;     //aNewVolumes.Count>0
    end else    {(TopVolume<>nil)or(BottomVolume<>nil)}
    if BuildDirection=bdUp then begin
      if TopVolume=nil then begin
    //-----------------------------------------------------------------------
    //     если при построении вверх сверху "пусто"
    //-----------------------------------------------------------------------
                {основное построение}
        BaseVolumeFlag:=True;
        BuildVolumes(SpecifiedAreas, LineList, BuildDirection,Height,
                                RefElement,RefParent, nil, TopAreaLayerE,
                                aNewVolumes, ParentVolume,
                                BuildJoinedVolume, True, True);
        if aNewVolumes.Count=0 then
          ExitWithMessage
        else begin
          NewVolumeE:=aNewVolumes.Item[0];    {NewVolume с новым RefElement}
          NewVolume:=NewVolumeE as IVolume;
          DMOperationManager.UpdateElement(NewVolumeE);
        end;

        if TopRefElement<>nil then begin
          AreaList.Clear;
                                          { достроить Up от NewVolume.TopAreas}
          for m:=0 to NewVolume.TopAreas.Count-1 do begin
            AreaE:=NewVolume.TopAreas.Item[m];
            Area:=AreaE as IArea;
            if Area.Volume0=nil then
              AreaList.Add(pointer(AreaE));
          end;
          if AreaList.Count>0 then begin
            MakeOutline(AreaList, LineList);

            BaseVolumeFlag:=False;
            BuildVolumes(AreaList, LineList, bdUp,TopHeight,
                                TopRefElement,RefParent,UpperVolumeLayerE, nil,
                                aNewVolumes, ParentVolume, True, True, False);
            if aNewVolumes.Count=0 then
              ExitWithMessage
            else begin
              aVolumeE:=aNewVolumes.Item[0];
              DMOperationManager.UpdateElement(aVolumeE);
            end;
          end;
        end;  // TopRefElement<>nil

      end else begin {TopVolume<>nil}
     //-----------------------------------------------------------------------
     //     если при построении вверх, вверху не "пусто"
     //-----------------------------------------------------------------------
     { - делаем основное построение }
        if (TopRefElement=nil) then begin
     {если не нужно авт. достраивать вверх - делаем основное построение }
          if (TopVolume.MaxZ-TopVolume.MinZ)<=Height then begin
          {если задано строить по всей высоте }
            BaseVolumeFlag:=True;
            BuildVolumes(SpecifiedAreas, LineList, BuildDirection,Height,
                         RefElement,RefParent, nil, nil,
                         aNewVolumes, ParentVolume,
                         BuildJoinedVolume, True, True);
            if aNewVolumes.Count=0 then
              ExitWithMessage
            else begin
              NewVolumeE:=aNewVolumes.Item[0];    {NewVolume с новым RefElement}
              NewVolume:=NewVolumeE as IVolume;
              DMOperationManager.UpdateElement(NewVolumeE);
            end;
          end else begin
          {если задано строить ниже существ.  высоты }
            aRefElement:=DMOperationManager.CreateClone(RefElement) as IDMElement;
            BuildInVolume(SpecifiedAreas,BaseVolume,aRefElement,RefParent,
                          RefElement, nil, nil,  BuildDirection,
                          NewVolume, BuildJoinedVolume, True);
            if NewVolume=nil then
              ExitWithMessage
            else begin
              NewVolumeE:=NewVolume as IDMElement;
              DMOperationManager.UpdateElement(NewVolumeE);
            end;
          end;  {(..MaxZ-..MinZ)-...Height>0}
        end else begin  {TopRefElement<>nil}
     {если нужно авт. достроить вверх - основное построение -вставкой }
          BuildInVolume(SpecifiedAreas,BaseVolume,RefElement,RefParent,
                        TopRefElement,UpperVolumeLayerE, nil, BuildDirection,
                        NewVolume, BuildJoinedVolume, True);
          if NewVolume=nil then
            ExitWithMessage
          else begin
            NewVolumeE:=NewVolume as IDMElement;
            DMOperationManager.UpdateElement(NewVolumeE);
          end;
        end;
      end;  // {TopVolume<>nil}

      if (BottomRefElement<>nil) then begin
   {если нужно авт. достраивать вниз: достроить Down от NewVolume.BottomAreas}
        AreaList.Clear;
        for m:=0 to NewVolume.BottomAreas.Count-1 do
          AreaList.Add(pointer(NewVolume.BottomAreas.Item[m]));
        MakeOutline(AreaList, LineList);

        if BottomVolume=nil then begin
          BaseVolumeFlag:=False;
          BuildVolumes(AreaList, LineList, bdDown,BottomHeight,
                       BottomRefElement,RefParent,LowerVolumeLayerE, nil,
                       aNewVolumes, ParentVolume, True, True, False);
          if aNewVolumes.Count=0 then
            ExitWithMessage
          else begin
            aVolumeE:=aNewVolumes.Item[0];    {NewVolume с новым RefElement}
            DMOperationManager.UpdateElement(aVolumeE);
          end;
        end else begin    {BottomVolume<>nil}
          if (BottomVolume.MaxZ-BottomVolume.MinZ)<=BottomHeight then begin
        {если задано строить по всей высоте }
            BaseVolumeFlag:=False;
            BuildVolumes(AreaList, LineList, bdDown,BottomHeight,
                         BottomRefElement,RefParent, nil, nil,
                         aNewVolumes, ParentVolume, True, True, False);
            if aNewVolumes.Count=0 then
              ExitWithMessage
            else begin
              aVolumeE:=aNewVolumes.Item[0];    {NewVolume с новым RefElement}
              DMOperationManager.UpdateElement(aVolumeE);
            end;
          end else begin  //(.MaxZ-..MinZ)-TopHeight>0
       {если задано строить ниже существ.  высоты }
            aRefElement:=DMOperationManager.CreateClone(BottomVolumeE.Ref) as IDMElement;
            BuildInVolume(AreaList,BottomVolume,aRefElement,RefParent,
                          BottomRefElement, nil, nil, BuildDirection,
                          aVolume, True, False);
            if aVolume=nil then
              ExitWithMessage
            else begin
              aVolumeE:=aVolume as IDMElement;
              DMOperationManager.UpdateElement(aVolumeE);
            end;
          end;     //(..MaxZ-..MinZ)-BottomHeight>0
        end;     {BottomVolume<>nil}
      end;       //BottomRefElement<>nil
    end else begin  //===============BuildDirection=bdDown======================
      if BottomVolume=nil then begin
     //-----------------------------------------------------------------------
     //     если при построении вниз, внизу  "пусто"
     //-----------------------------------------------------------------------
                {основное построение}
        BaseVolumeFlag:=True;
        BuildVolumes(SpecifiedAreas, LineList, BuildDirection,Height,
                     RefElement,RefParent, nil, nil,
                     aNewVolumes, ParentVolume,
                     BuildJoinedVolume, True, True);
        if aNewVolumes.Count=0 then
          ExitWithMessage
        else begin
         NewVolumeE:=aNewVolumes.Item[0];   {NewVolume с новым RefElement}
         NewVolume:=NewVolumeE as IVolume;
         DMOperationManager.UpdateElement(NewVolumeE);
        end;
                   {если нужно автo. достроить вниз (BottomRefElement<>nil}
        if BottomRefElement<>nil then begin
          AreaList.Clear;
                                    { достроить Down от NewVolume.BottomAreas}
          for m:=0 to NewVolume.BottomAreas.Count-1 do begin
            AreaE:=NewVolume.BottomAreas.Item[m];
            Area:=AreaE as IArea;
            if Area.Volume1=nil then
              AreaList.Add(pointer(AreaE));
          end;
          if AreaList.Count>0 then begin
            MakeOutline(AreaList, LineList);

            BaseVolumeFlag:=False;
            BuildVolumes(AreaList, LineList, bdDown,BottomHeight,
                               BottomRefElement,RefParent, LowerVolumeLayerE, nil,
                               aNewVolumes, ParentVolume, True, True, False);
            if aNewVolumes.Count=0 then
              ExitWithMessage
            else begin
              aVolumeE:=aNewVolumes.Item[0];
              DMOperationManager.UpdateElement(aVolumeE);
            end;
          end;
        end;  // BottomRefElement<>nil

      end else begin {BottomVolume<>nil}
    //--------------------------------------------------------------------------
    //   если при построении вниз внизу не "пусто"
    //--------------------------------------------------------------------------
     { - делаем основное построение }
        if BottomRefElement=nil then begin
       {если не нужно авт. достроить вниз  }
          if (BottomVolume.MaxZ-BottomVolume.MinZ)<=Height then begin
           {если задано строить  вниз по всей высоте }
            BaseVolumeFlag:=True;
            BuildVolumes(SpecifiedAreas, LineList,BuildDirection,Height,
                         RefElement,RefParent, nil, nil,
                         aNewVolumes, ParentVolume,
                         BuildJoinedVolume, True, True);
            if aNewVolumes.Count=0 then
              ExitWithMessage
            else begin
              NewVolumeE:=aNewVolumes.Item[0];
              NewVolume:=NewVolumeE as IVolume;
              DMOperationManager.UpdateElement(NewVolumeE);
            end;
          end else begin
          {если задано строить ниже существ.  высоты }
            aRefElement:=DMOperationManager.CreateClone(RefElement) as IDMElement;
            BuildInVolume(SpecifiedAreas,BaseVolume,aRefElement,RefParent,
                           RefElement, nil, nil, BuildDirection,
                           NewVolume, BuildJoinedVolume, True);
            if NewVolume=nil then
              ExitWithMessage
            else begin
              NewVolumeE:=NewVolume as IDMElement;
              DMOperationManager.UpdateElement(NewVolumeE);
            end;
          end;  {(..MaxZ-..MinZ)-...Height>0}
        end else begin {BottomRefElement<>nil}
       {если нужно авт. достроить вниз - основное построение -вставкой }
          BuildInVolume(SpecifiedAreas,BaseVolume,RefElement,RefParent,
                         BottomRefElement, LowerVolumeLayerE, nil, BuildDirection,
                         NewVolume, BuildJoinedVolume, True);
          if NewVolume=nil then
            ExitWithMessage
          else begin
            NewVolumeE:=NewVolume as IDMElement;
            DMOperationManager.UpdateElement(NewVolumeE);
          end;
        end;
      end;  // {BottomVolume<>nil}

      if TopRefElement<>nil then begin
   {если нужно авт. достраивать вверх: достроить Up от NewVolume.TopAreas}
        AreaList.Clear;
        for m:=0 to NewVolume.TopAreas.Count-1 do
          AreaList.Add(pointer(NewVolume.TopAreas.Item[m]));
        MakeOutline(AreaList, LineList);

        if TopVolume=nil then begin
          BaseVolumeFlag:=False;
          BuildVolumes(AreaList, LineList, bdUp,TopHeight,
                       TopRefElement,RefParent, UpperVolumeLayerE, nil,
                       aNewVolumes, ParentVolume, True, True, False);
          if aNewVolumes.Count=0 then
            ExitWithMessage
          else begin
            aVolumeE:=aNewVolumes.Item[0];
            DMOperationManager.UpdateElement(aVolumeE);
          end;
        end else begin     {TopVolume<>nil}
          if (TopVolume.MaxZ-TopVolume.MinZ)<=TopHeight then begin
        {если задано строить по всей высоте }
            BaseVolumeFlag:=False;
            BuildVolumes(AreaList, LineList, bdUp,TopHeight,
                         TopRefElement,RefParent, nil, nil,
                         aNewVolumes, ParentVolume, True, True, False);
            if aNewVolumes.Count=0 then
              ExitWithMessage
            else begin
              aVolumeE:=aNewVolumes.Item[0];    {NewVolume с новым RefElement}
              DMOperationManager.UpdateElement(aVolumeE);
            end;
          end else begin  //(.MaxZ-..MinZ)-TopHeight>0
          {если задано строить ниже существ.  высоты }
            aRefElement:=DMOperationManager.CreateClone(TopVolumeE.Ref) as IDMElement;
            BuildInVolume(AreaList,TopVolume,aRefElement,RefParent,
                          TopRefElement, nil, nil, BuildDirection,
                          aVolume, True, False);
            if aVolume=nil then
              ExitWithMessage
            else begin
              aVolumeE:=aVolume as IDMElement;
              DMOperationManager.UpdateElement(aVolumeE);
            end;
          end;    //(TopVolume.MaxZ-..MinZ)-TopHeight>0
        end;     {TopVolume<>nil}
      end;      {TopRefElement<>nil}
    end;        {Down}

    TList(pointer(AreaGroups[0])).Free;
    AreaGroups.Delete(0);
    inc(N);
    SpatialModel.CurrentLayer:=CurrentLayer;
  end; // while AreaGroups.Count>0
  AreaList.Free;
  LineList.Free;

  DeletedAreas:=TDMCollection.Create(nil) as IDMCollection;
  DeletedAreas2:=DeletedAreas as IDMCollection2;
  for j:=0 to FDeletedAreaList.Count-1 do begin
    aAreaE:=IDMElement(FDeletedAreaList[j]);
    DeletedAreas2.Add(aAreaE);
  end;
  DMOperationManager.DeleteElements(DeletedAreas, False);

  SpatialModel2.UpdateVolumes;

  if aNewVolumes.Count>0 then
    NewVolumeE:=aNewVolumes.Item[0];
  if NewVolumeE<>nil then
    SMDocument.SetDocumentOperation(NewVolumeE, nil,
                          leoAdd, -1);

  if SMDocument.NewZView<>nil then
    View.Duplicate(IDMElement(SMDocument.NewZView) as IView);

  finally
    SMDocument.SelectedAreaList.Clear;
    DataModel.State:=DataModel.State or dmfModified;
    DMDocument.Server.SelectionChanged(nil);

    while AreaGroups.Count>0 do begin
      SpecifiedAreas:=TList(AreaGroups[0]);
      SpecifiedAreas.Free;
      AreaGroups.Delete(0);
    end; //while
    AreaGroups.Free;

    CurrentStep:=-2;
    FDone:=True;

    DMDocument.Server.EventData3:=-1;  // закрыть диалог
    DMDocument.Server.CallDialog(sdmPleaseWait, '', '');
  end; //try

end;

procedure TBuildFMVolumeOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='СОЗДАНИЕ ЗОН: Укажите замкнутый контур в основании зоны (SHIFT - выделение рамкой, CTRL - добавить к выделению, F6 - создать объект)';
  ACursor:=cr_Build_Zone;
end;

procedure TBuildFMVolumeOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
begin
  inherited;

end;

function TBuildFMVolumeOperation.GetModelCheckFlag: boolean;
begin
  Result:=True
end;

end.
