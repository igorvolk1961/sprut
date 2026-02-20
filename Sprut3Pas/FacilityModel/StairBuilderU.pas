unit StairBuilderU;

interface
uses
  Classes, SysUtils,
  DataModel_TLB, DMServer_TLB, SpatialModelLib_TLB,
  FacilityModelLib_TLB, SgdbLib_TLB, Geometry;

  procedure BuildStairProc(const DataModel:IDataModel);

implementation
uses
  SpatialModelConstU,
  FacilityModelConstU;

function CompareArea(p1, p2:pointer):integer;
var
  Area1, Area2:IArea;
  Z1, Z2:double;
begin
  Area1:=IDMElement(p1) as IArea;
  Area2:=IDMElement(p2) as IArea;
  Z1:=Area1.MinZ;
  Z2:=Area2.MinZ;
  if Z1<Z2 then
    Result:=-1
  else
  if Z1>Z2 then
    Result:=+1
  else begin
    Z1:=Area1.MaxZ;
    Z2:=Area2.MaxZ;
    if Z1>Z2 then
      Result:=-1
    else
    if Z1<Z2 then
      Result:=+1
    else
      Result:=0
  end;
end;

procedure BuildStairProc(const DataModel:IDataModel);
var
  Server:IDataModelServer;
  Document:IDMDocument;
  SMOperationManager:ISMOperationManager;
  DMOperationManager:IDMOperationManager;
  Element, VolumeE, aAreaE, aBoundaryE:IDMElement;
  Volume, aVolume:IVolume;
  VolumeGroupList, VolumeList, aVolumeList,
  AreaList, BottomAreaList, TopInAreaList, TopOutAreaList:TList;
  j, m, m0, k, i, l, BottomM, TopM, N:integer;
  Found:boolean;
  aArea, Area:IArea;
  bZ, tZ, aZ,
  bNX, bNY, toNX, toNY, tiNX, tiNY,
  aNX, aNY, X, Y, aX, aY, bL, toL, tiL, aL, cL, cs, sn,
  bX0, bY0, bX1, bY1,
  toX0, toY0, toX1, toY1, tiX0, tiY0, tiX1, tiY1,
  aX0, aY0, aX1, aY1, CX, CY, CZ:double;
  C0, C1, aC0, aC1, C, aC:ICoordNode;
  TurnCos:double;
  StairBuilder:IStairBuilder;
  aLineE, aLine1E, aLineParent:IDMElement;
  BoundaryE:IDMElement;
  aLine, aLine1:ILine;
  AddTopOutAreaFlag:boolean;
  StairSide:integer;
  SpatialModel:ISpatialModel;
  FacilityModel:IFacilityModel;
  Lines, Nodes, Jumps, JumpKinds:IDMCollection;
  StairParent,  JumpRefE, JumpKindE:IDMElement;
  JumpKind:IJumpKind;

  procedure CreateStair(var  StairSide:integer;
                  bX0,  bY0,  bX1,  bY1, bZ,
                  tX0, tY0, tX1, tY1, tZ:double;
                  BottomAreaList, TopInAreaList:TList);
  var
    L, D, bX, bY, tX, tY,
    X0, Y0, X1, Y1:double;
    j, StairSide1:integer;
    LineU, NodeU, JumpU:IUnknown;
    C0, C1:ICoordNode;
    Line:ILine;
    JumpE:IDMElement;
    S:string;
    aAreaE, Area0Ref, Area1Ref:IDMElement;
    Area0, Area1, aArea:IArea;
  begin
    L:=sqrt(sqr(bX1-bX0)+sqr(bY1-bY0));
    D:=0.5*StairBuilder.StairWidth*100;
    if D>0.5*L then
      D:=0.5*L;
    if StairSide=0 then begin
      bX:=bX0+(bX1-bX0)/L*D;
      bY:=bY0+(bY1-bY0)/L*D;
    end else begin
      bX:=bX1+(bX0-bX1)/L*D;
      bY:=bY1+(bY0-bY1)/L*D;
    end;

    if (sqr(tX0-bX0)+sqr(tY0-bY0))<(sqr(tX0-bX1)+sqr(tY0-bY1)) then
      StairSide1:=StairSide      // положение противоположного конца марша
    else
      StairSide1:=1-StairSide;

    PerpendicularFrom0(tX0, tY0, tX1, tY1, bX, bY, tX, tY);

    if ((tX-tX0)*(tX-tX1)>0) or
       ((tY-tY0)*(tY-tY1)>0) then begin   // если попали мимо

      L:=sqrt(sqr(tX1-tX0)+sqr(tY1-tY0));
      D:=0.5*StairBuilder.StairWidth*100;
      if D>0.5*L then
        D:=0.5*L;
      if StairSide1=0 then begin
        tX:=tX0+(tX1-tX0)/L*D;
        tY:=tY0+(tY1-tY0)/L*D;
      end else begin
        tX:=tX1+(tX0-tX1)/L*D;
        tY:=tY1+(tY0-tY1)/L*D;
      end;
      PerpendicularFrom0(bX0, bY0, bX1, bY1, tX, tY, bX, bY);
    end;

    aAreaE:=nil;
    j:=0;
    while j<BottomAreaList.Count do begin
      aAreaE:=IDMElement(BottomAreaList[j]);
      aArea:=aAreaE as IArea;
      C0:=aArea.C0;
      C1:=aArea.C1;
      X0:=C0.X;
      Y0:=C0.Y;
      X1:=C1.X;
      Y1:=C1.Y;
      if (X0-bX)*(X1-bX)+(Y0-bY)*(Y1-bY)<0 then
        Break
      else
        inc(j)
    end;
    if j<BottomAreaList.Count then begin
      Area0Ref:=aAreaE.Ref;
      Area0:=aAreaE as IArea;
    end else begin
      Area0Ref:=nil;
      Area0:=nil;
    end;

    aAreaE:=nil;
    j:=0;
    while j<TopInAreaList.Count do begin
      aAreaE:=IDMElement(TopInAreaList[j]);
      aArea:=aAreaE as IArea;
      C0:=aArea.C0;
      C1:=aArea.C1;
      X0:=C0.X;
      Y0:=C0.Y;
      X1:=C1.X;
      Y1:=C1.Y;
      if (X0-tX)*(X1-tX)+(Y0-tY)*(Y1-tY)<0 then
        Break
      else
        inc(j)
    end;
    if j<TopInAreaList.Count then begin
      Area1Ref:=aAreaE.Ref;
      Area1:=aAreaE as IArea;
    end else begin
      Area1Ref:=nil;
      Area1:=nil;
    end;

    DMOperationManager.AddElement(StairParent, Lines,'', ltOneToMany, LineU, True);
    Line:=LineU as ILine;
    DMOperationManager.AddElement(StairParent, Nodes,'', ltOneToMany, NodeU, True);
    C0:=NodeU as ICoordNode;
    DMOperationManager.AddElement(StairParent, Nodes,'', ltOneToMany, NodeU, True);
    C1:=NodeU as ICoordNode;
    Line.C0:=C0;
    Line.C1:=C1;
    C0.X:=bX;
    C0.Y:=bY;
    C0.Z:=bZ;
    C1.X:=tX;
    C1.Y:=tY;
    C1.Z:=tZ;

    DMOperationManager.AddElement(nil, Jumps,'', ltOneToMany, JumpU, True);
    JumpE:=JumpU as IDMElement;
    S:=DataModel.GetDefaultName(JumpRefE);
    DMOperationManager.ChangeRef(nil, S, JumpRefE, JumpE);
    DMOperationManager.ChangeRef(nil, S, JumpE, LineU);

    JumpE.SetFieldValue(ord(loBoundary0), Area0Ref as IUnknown);
    JumpE.SetFieldValue(ord(loBoundary1), Area1Ref as IUnknown);

    if (Area0.Volume0<>nil) and
       (VolumeList.IndexOf(pointer(Area0.Volume0))=-1) then
      JumpE.SetFieldValue(ord(loZone0), (Area0.Volume0 as IDMElement).Ref as IUnknown)
    else
    if (Area0.Volume1<>nil) and
       (VolumeList.IndexOf(pointer(Area0.Volume1))=-1) then
      JumpE.SetFieldValue(ord(loZone0), (Area0.Volume1 as IDMElement).Ref as IUnknown);

    if (Area1.Volume0<>nil) and
       (VolumeList.IndexOf(pointer(Area1.Volume0))=-1) then
      JumpE.SetFieldValue(ord(loZone1), (Area1.Volume0 as IDMElement).Ref as IUnknown)
    else
    if (Area1.Volume1<>nil) and
       (VolumeList.IndexOf(pointer(Area1.Volume1))=-1) then
      JumpE.SetFieldValue(ord(loZone1), (Area1.Volume1 as IDMElement).Ref as IUnknown);

    JumpE.SetFieldValue(ord(loWidth), StairBuilder.StairWidth);

    StairSide:=1-StairSide1; // следующий марш начинается у противоположной стены
  end;

begin
  Document:=DataModel.Document as IDMDocument;
  Server:=Document.Server;
  DMOperationManager:=Document as IDMOperationManager;
  SMOperationManager:=Document as ISMOperationManager;
  if Document.SelectionCount=0 then Exit;
  Element:=Document.SelectionItem[0] as IDMElement;
  if Element.ClassID<>_Volume then Exit;

  StairBuilder:=DataModel as IStairBuilder;
  TurnCos:=abs(cos(StairBuilder.StairTurnAngle/180*pi));

  SpatialModel:=DataModel as ISpatialModel;
  FacilityModel:=DataModel as IFacilityModel;
  Lines:=SpatialModel.Lines;
  Nodes:=SpatialModel.CoordNodes;
  StairParent:=SpatialModel.CurrentLayer as IDMElement;
  Jumps:=FacilityModel.Jumps;

  JumpKinds:=(DataModel as IDMElement).Ref.Collection[_JumpKind];
  Element:=nil;
  j:=0;
  while j<JumpKinds.Count do begin
    JumpKindE:=JumpKinds.Item[j];
    JumpKind:=JumpKindE as IJumpKind;
    if JumpKind.Default=1 then
      Break
    else
      inc(j);
  end;
  if j<JumpKinds.Count then
    JumpRefE:=JumpKindE
  else
    Exit;  

  VolumeGroupList:=TList.Create;
  AreaList:=TList.Create;
  BottomAreaList:=TList.Create;
  TopInAreaList:=TList.Create;
  TopOutAreaList:=TList.Create;
  try

  for j:=0 to Document.SelectionCount-1 do begin
    VolumeE:=Document.SelectionItem[j] as IDMElement;
    Volume:=VolumeE as IVolume;

    BottomM:=-1;
    TopM:=-1;
    for m:=0 to VolumeGroupList.Count-1 do begin
      VolumeList:=VolumeGroupList[m];

      Found:=False;
      if BottomM=-1 then begin
        aVolume:=IVolume(VolumeList[0]);
        k:=0;
        while k<aVolume.BottomAreas.Count do begin
          aAreaE:=aVolume.BottomAreas.Item[k];
          if Volume.TopAreas.IndexOf(aAreaE)<>-1 then
            Break
          else
            inc(k)
        end;
        if k<aVolume.BottomAreas.Count then begin
          VolumeList.Insert(0, pointer(Volume));
          BottomM:=m;
          Found:=True;
        end
      end;

      if (not Found) and
         (TopM=-1) then begin
        aVolume:=IVolume(VolumeList[VolumeList.Count-1]);
        k:=0;
        while k<aVolume.TopAreas.Count do begin
          aAreaE:=aVolume.TopAreas.Item[k];
          if Volume.BottomAreas.IndexOf(aAreaE)<>-1 then
            Break
          else
            inc(k)
        end;
        if k<aVolume.TopAreas.Count then begin
          VolumeList.Add(pointer(Volume));
          TopM:=m;
        end;
      end;
    end;

    if (BottomM=-1) and
       (TopM=-1) then begin
      VolumeList:=TList.Create;
      VolumeList.Add(pointer(Volume));
      VolumeGroupList.Add(VolumeList);
    end else
    if (BottomM<>-1) and
       (TopM<>-1) then begin
      aVolumeList:=VolumeGroupList[BottomM];
      VolumeList:=VolumeGroupList[TopM];
      for m:=1 to aVolumeList.Count-1 do begin
        aVolume:=IVolume(aVolumeList[m]);
        VolumeList.Add(pointer(aVolume));
      end;
      VolumeGroupList.Delete(BottomM);
      aVolumeList.Free;
    end;
  end;

  DMOperationManager.StartTransaction(nil, leoAdd, rsBuildLineObject);

  for j:=0 to VolumeGroupList.Count-1 do begin
    VolumeList:=VolumeGroupList[j];
    AreaList.Clear;

// формируем список условных границ для одной лестницы
    for m:=0 to VolumeList.Count-1 do begin
      Volume:=IVolume(VolumeList[m]);
      if m=0 then begin
        if Volume.BottomAreas.Count=0 then
          DataModel.HandleError('Error in BuildStairProc. Volume.BottomAreas.Count=0')
        else begin
          aAreaE:=Volume.BottomAreas.Item[0];
          aArea:=aAreaE as IArea;
          aArea.GetCentralPoint(CX, CY, CZ);
        end;
      end;
      for k:=0 to Volume.Areas.Count-1 do begin
        aAreaE:=Volume.Areas.Item[k];
        aArea:=aAreaE as IArea;
        if aArea.IsVertical then begin
          aBoundaryE:=aAreaE.Ref;
          if aBoundaryE.Ref.Parent.ID=btVirtual then begin
            l:=0;
            while l<aArea.BottomLines.Count do begin
              aLineE:=aArea.BottomLines.Item[l];
              i:=0;
              while i<aLineE.Parents.Count do begin
                aLineParent:=aLineE.Parents.Item[i];
                if (aLineParent<>aAreaE) and
                   (aLineParent.ClassID=_Area) then begin
                  Area:=aLineParent as IArea;
                  BoundaryE:=aLineParent.Ref;
                  if (not Area.IsVertical) and
                     (BoundaryE.Ref.Parent.ID<>btVirtual) then
                    Break
                  else
                    inc(i);
                end else
                  inc(i);
              end;
              if i<aLineE.Parents.Count then
                Break
              else
                inc(l)
            end;
            if l<aArea.BottomLines.Count then
              AreaList.Add(pointer(aAreaE));
          end;
        end;
      end;
      AreaList.Sort(@CompareArea);
    end;

    tZ  :=0;
    toNX:=0;
    toNY:=0;
    toX0:=0;
    toY0:=0;
    toX1:=0;
    toY1:=0;
    toL :=0;
    BottomAreaList.Clear;
    TopInAreaList.Clear;
    TopOutAreaList.Clear;
    N:=0;
    m:=0;
    while m<AreaList.Count do begin // внешией цикл
// берем нижнюю плоскость
      if N=0 then begin
        aAreaE:=IDMElement(AreaList[m]);
        aArea:=aAreaE as IArea;
        BottomAreaList.Add(pointer(aAreaE));
        bZ:=aArea.MinZ;
        bNX:=aArea.NX;
        bNY:=aArea.NY;
        C0:=aArea.C0;
        C1:=aArea.C1;
        bX0:=C0.X;
        bY0:=C0.Y;
        bX1:=C1.X;
        bY1:=C1.Y;
        if bX0>bX1 then begin
          bX0:=C1.X;
          bY0:=C1.Y;
          bX1:=C0.X;
          bY1:=C0.Y;
        end else
        if bX1=bX0 then begin
          if bY0>bY1 then begin
            bY0:=C1.Y;
            bY1:=C0.Y;
          end;
        end;
        bL:=sqrt(sqr(bX1-bX0)+sqr(bY1-bY0));
        inc(m);
      end else begin // if (BottomAreaList.Count>0) and ...
        BottomAreaList.Clear;
        for i:=0 to TopOutAreaList.Count-1 do
          BottomAreaList.Add(TopOutAreaList[i]);  // используем уже найденные плоскости
        TopOutAreaList.Clear;
        TopInAreaList.Clear;

        bZ :=tZ;
        bNX:=toNX;
        bNY:=toNY;
        bX0:=toX0;
        bY0:=toY0;
        bX1:=toX1;
        bY1:=toY1;
        bL :=toL;
      end; // if (BottomAreaList.Count>0)

// ищем верхнюю плоскость
      while m<AreaList.Count do begin // внутренний цикл
        aAreaE:=IDMElement(AreaList[m]);
        aArea:=aAreaE as IArea;
        aZ:=aArea.MinZ;
        aNX:=aArea.NX;
        aNY:=aArea.NY;

        aC0:=aArea.C0;
        aC1:=aArea.C1;
        aX0:=aC0.X;
        aY0:=aC0.Y;
        aX1:=aC1.X;
        aY1:=aC1.Y;
        if aX0>aX1 then begin
          aX0:=aC1.X;
          aY0:=aC1.Y;
          aX1:=aC0.X;
          aY1:=aC0.Y;
        end else
        if aX1=aX0 then begin
          if aY0>aY1 then begin
            aY0:=aC1.Y;
            aY1:=aC0.Y;
          end;
        end;
        aL:=sqrt(sqr(aX1-aX0)+sqr(aY1-aY0));

        if aZ>bZ+10 then begin// очередной уровень
// это либо вход на верхний уровень, либо выход с него еще выше, либо ни то, ни другое
          AddTopOutAreaFlag:=False;
          X:=0.5*(aX0+aX1);
          Y:=0.5*(aY0+aY1);
          if abs(1-abs(bNX*aNX+bNY*aNY))<0.02 then begin // если плоскости параллельны
            cL:=sqrt(sqr(X-bX0)+sqr(Y-bY0));
            cs:=abs((bX1-bX0)*(X-bX0)+(bY1-bY0)*(Y-bY0))/(bL*cL);
            if (1-cs)>0.02 then begin// если плоскости смещены
              TopInAreaList.Add(pointer(aAreaE));
              if abs(StairBuilder.StairTurnAngle)=180 then begin// при повороте на 180 град.
                AddTopOutAreaFlag:=True;  // вход и выход с уровня
              end;                                    // осуществляются через одну плоскость
            end else
            if StairBuilder.StairTurnAngle=0 then begin
              AddTopOutAreaFlag:=True;
            end;
          end else
          if (abs(bNX*aNX+bNY*aNY)<0.02) and // если плоскости перпендикулярны
            (abs(StairBuilder.StairTurnAngle)=90) then begin
            if TopOutAreaList.Count=0 then        // если первая плоскость выхода,
              AddTopOutAreaFlag:=True // то добавляем в любом случае
            else begin
              cL:=sqrt(sqr(X-toX0)+sqr(Y-toY0));
              cs:=abs((toX1-toX0)*(X-toX0)+(toY1-toY0)*(Y-toY0))/(toL*cL);
              if (1-cs)<0.02 then // если плоскость не смещена относительно первой
                AddTopOutAreaFlag:=True
            end;
          end;
          if TopInAreaList.Count=1 then begin // если нашли вход
            tZ  :=aZ;
            tiNX:=aNX;
            tiNY:=aNY;
            tiX0:=aX0;
            tiY0:=aY0;
            tiX1:=aX1;
            tiY1:=aY1;
            tiL:=aL;
            tiL:=sqrt(sqr(tiX1-tiX0)+sqr(tiY1-tiY0));
          end;
          if AddTopOutAreaFlag then begin
            TopOutAreaList.Add(pointer(aAreaE));
            if TopOutAreaList.Count=1 then begin
              tZ  :=aZ;
              toNX:=aNX;
              toNY:=aNY;
              toX0:=aX0;
              toY0:=aY0;
              toX1:=aX1;
              toY1:=aY1;
              toL:=sqrt(sqr(toX1-toX0)+sqr(toY1-toY0));
            end else begin
              if toX0>aX0 then begin  // определяем крайние координаты
                toX0:=aX0;            // нижней плоскости
                toY0:=aY0;
              end else
              if toX0=aX0 then begin
                if toY0>aY0 then
                  toY0:=aY0;
              end;

              if toX1<aX1 then begin
                toX1:=aX1;
                toY1:=aY1;
              end else
              if toX1=aX1 then begin
                if toY1>aY1 then
                  toY1:=aY1;
              end;
              toL:=sqrt(sqr(toX1-toX0)+sqr(toY1-toY0));
            end;
          end;

          if TopInAreaList.Count=0 then
            inc(m)  // продолжаем поиск входа на очередноq уровень
          else
            Break;  // нашли очередной уровень
        end else begin // if Z1<=Z0+10
          inc(m); // пропускаем плоскости на том же уровне
                  // (сюда попадаем только при обработке нижнего уровня)
          if abs(1-abs(bNX*aNX+bNY*aNY))<0.02 then begin // если плоскости параллельны
            X:=0.5*(aX0+aX1);
            Y:=0.5*(aY0+aY1);
            cL:=sqrt(sqr(X-bX0)+sqr(Y-bY0));
            cs:=abs((bX1-bX0)*(X-bX0)+(bY1-bY0)*(Y-bY0))/(bL*cL);
            if (1-cs)<0.02 then begin // если в одной плоскости
              BottomAreaList.Add(pointer(aAreaE));

              if bX0>aX0 then begin  // определяем крайние координаты
                bX0:=aX0;            // нижней плоскости
                bY0:=aY0;
              end else
              if bX0=aX0 then begin
                if bY0>aY0 then
                  bY0:=aY0;
              end;

              if bX1<aX1 then begin
                bX1:=aX1;
                bY1:=aY1;
              end else
              if bX1=aX1 then begin
                if bY1<aY1 then
                  bY1:=aY1;
              end;
              bL:=sqrt(sqr(bX1-bX0)+sqr(bY1-bY0));
            end   // if (1-cs)<0.02
          end;  // if abs(1-abs(bNX*aNX+bNY*aNY))<0.02
        end;  // if Z1<=Z0+10
      end;  // while m<AreaList.Count
      if m=AreaList.Count then
        Break; // добрались до самого верха. Переходим к следующей лестнице


// определяем крайние координаты
// верхней плоскости и заполняем ее
      inc(m);
      while m<AreaList.Count do begin
        aAreaE:=IDMElement(AreaList[m]);
        aArea:=aAreaE as IArea;
        aZ:=aArea.MinZ;
        aNX:=aArea.NX;
        aNY:=aArea.NY;

        aC0:=aArea.C0;
        aC1:=aArea.C1;
        aX0:=aC0.X;
        aY0:=aC0.Y;
        aX1:=aC1.X;
        aY1:=aC1.Y;
        if aX0>aX1 then begin
          aX0:=aC1.X;
          aY0:=aC1.Y;
          aX1:=aC0.X;
          aY1:=aC0.Y;
        end else
        if aX1=aX0 then begin
          if aY0>aY1 then begin
            aY0:=aC1.Y;
            aY1:=aC0.Y;
          end;
        end;
        aL:=sqrt(sqr(aX1-aX0)+sqr(aY1-aY0));
        if aZ>tZ+10 then
          Break // уже следующий уровень
        else begin // if aZ<=tZ+10
          inc(m);
          X:=0.5*(aX0+aX1);
          Y:=0.5*(aY0+aY1);
          AddTopOutAreaFlag:=False;
          if abs(1-abs(bNX*aNX+bNY*aNY))<0.02 then begin // если плоскости параллельны
            cL:=sqrt(sqr(X-bX0)+sqr(Y-bY0));
            cs:=abs((bX1-bX0)*(X-bX0)+(bY1-bY0)*(Y-bY0))/(bL*cL);
            if (1-cs)>0.02 then begin// если плоскости смещены
              TopInAreaList.Add(pointer(aAreaE));

              if tiX0>aX0 then begin  // определяем крайние координаты
                tiX0:=aX0;            // нижней плоскости
                tiY0:=aY0;
              end else
              if tiX0=aX0 then begin
                if tiY0>aY0 then
                  tiY0:=aY0;
              end;

              if tiX1<aX1 then begin
                tiX1:=aX1;
                tiY1:=aY1;
              end else
              if tiX1=aX1 then begin
                if tiY1<aY1 then
                  tiY1:=aY1;
              end;
              tiL:=sqrt(sqr(tiX1-tiX0)+sqr(tiY1-tiY0));

              if abs(StairBuilder.StairTurnAngle)=180 then begin// при повороте на 180 град.
                AddTopOutAreaFlag:=True;  // вход и выход с уровня
              end;                                    // осуществляются через одну плоскость
            end else
            if StairBuilder.StairTurnAngle=0 then begin
              AddTopOutAreaFlag:=True;
            end;
          end else
          if (abs(bNX*aNX+bNY*aNY)<0.02) and // если плоскости перпендикулярны
            (abs(StairBuilder.StairTurnAngle)=90) then begin
            if TopOutAreaList.Count=0 then  // если первая плоскость выхода,
              AddTopOutAreaFlag:=True  // то добавляем в любом случае
            else begin
              cL:=sqrt(sqr(X-toX0)+sqr(Y-toY0));
              cs:=abs((toX1-toX0)*(X-toX0)+(toY1-toY0)*(Y-toY0))/(toL*cL);
              if (1-cs)<0.02 then // если плоскость не смещена относительно первой
                AddTopOutAreaFlag:=True
            end;
          end;
          if AddTopOutAreaFlag then begin
            TopOutAreaList.Add(pointer(aAreaE));
            if TopOutAreaList.Count=1 then begin
              tZ  :=aZ;
              toNX:=aNX;
              toNY:=aNY;
              toX0:=aX0;
              toY0:=aY0;
              toX1:=aX1;
              toY1:=aY1;
              toL:=aL;
            end else begin
              if toX0>aX0 then begin  // определяем крайние координаты
                toX0:=aX0;            // нижней плоскости
                toY0:=aY0;
              end else
              if toX0=aX0 then begin
                if toY0>aY0 then
                  toY0:=aY0;
              end;

              if toX1<aX1 then begin
                toX1:=aX1;
                toY1:=aY1;
              end else
              if toX1=aX1 then begin
                if toY1<aY1 then
                  toY1:=aY1;
              end;
              toL:=sqrt(sqr(toX1-toX0)+sqr(toY1-toY0));
            end;
          end;
        end;  // if aZ<=tZ+10
      end;  // while m<AreaList.Count

//------------------------------------------------------------
// начинаем построение лестничного марша
//------------------------------------------------------------
      if (N=0) or // если строим первый марш, либо если угол между маршами не 180
         (abs(StairBuilder.StairTurnAngle)<>180) then begin
// определяем, с какой стороны отрезка (bX0, bY0) - (bX1, bY1)
// нужно начинать лестничный марш
        C:=nil;
        k:=0;       // ищем узел, соответствующий (bX1, bY1)
        while k<BottomAreaList.Count do begin
          aAreaE:=IDMElement(BottomAreaList[k]);
          aArea:=aAreaE as IArea;
          C0:=aArea.C0;
          C1:=aArea.C1;
          if (C0.X=bX1) and
             (C0.Y=bY1) then begin
            C:=C0;
            Break;
          end else
          if (C1.X=bX1) and
             (C1.Y=bY1) then begin
            C:=C1;
            Break;
          end else
            inc(k)
        end; // while k<BottomAreaList.Count
        if k=BottomAreaList.Count then
          DataModel.HandleError('Error1 in BuildStairProc');

        aLineE:=nil;
        l:=0;       // ищем краевую линию, исходящую из узла
        while l<C.Lines.Count do begin
          aLineE:=C.Lines.Item[l];
          aLine:=aLineE as ILine;
          aC:=aLine.NextNodeTo(C);
          X:=aC.X;
          Y:=aC.Y;
          cL:=aLine.Length;
          if abs(1-abs((X-bX1)*(bX0-bX1)+(Y-bY1)*(bY0-bY1))/(bL*cL))<0.02 then
            Break
          else
            inc(l);
        end; // while l<C.Lines.Count
        if l=C.Lines.Count then
          DataModel.HandleError('Error2 in BuildStairProc');

        //синус угла направления на центр плоскости относительно краевой линии
        sn:=((CY-bY1)*(bX0-bX1)+(CX-bX1)*(bY0-bY1));
        if sn>0 then begin
          if StairBuilder.StairTurnAngle>0 then
            StairSide:=0
          else
            StairSide:=1
        end else begin
          if StairBuilder.StairTurnAngle>0 then
            StairSide:=1
          else
            StairSide:=0
        end;
      end; // if N=0

      CreateStair(StairSide,
                  bX0,  bY0,  bX1,  bY1, bZ,
                  tiX0, tiY0, tiX1, tiY1, tZ,
                  BottomAreaList, TopInAreaList);
      inc(N);
    end;  // while m<AreaList.Count

    VolumeList.Free;
  end; // for j:=0 to VolumeGroupList.Count-1


  finally
    VolumeGroupList.Free;
    AreaList.Free;
    BottomAreaList.Free;
    TopInAreaList.Free;
    TopOutAreaList.Free;
    Server.DocumentOperation(nil,nil,leoAdd, -1);
  end;

end;

end.
