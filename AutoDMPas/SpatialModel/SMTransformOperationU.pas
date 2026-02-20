unit SMTransformOperationU;

interface
uses
   SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB , PainterLib_TLB, Math, Variants,
   SMOperationU, SMOperationConstU, Graphics, CustomSMDocumentU, Geometry;

type

  TSMTransformOperation=class(TSMOperation)
  protected
    FBaseNode:ICoordNode;
  public
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    function  GetBaseNode:ICoordNode; override;
    destructor Destroy; override;
    procedure Init; override;
  end;

  TMoveSelectedOperation=class(TSMTransformOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TMirrorSelectedOperation=class(TSMTransformOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TSMTransformOperation2=class(TSMTransformOperation)
  private
    FRX:double;
    FRY:double;
    FRZ:double;
    FDone:boolean;
  public
    procedure Drag(const SMDocument:TCustomSMDocument); override;
  end;


  TScaleSelectedOperation=class(TSMTransformOperation2)
  private
    FReferenceLength:double;
    FScaleRatio:double;
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TRotateSelectedOperation=class(TSMTransformOperation2)
  private
    Fsin_A0:double;
    Fcos_A0:double;
    Fsin_RefA:double;
    Fcos_RefA:double;
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

implementation
uses
  Classes,
  SpatialModelConstU;


destructor TSMTransformOperation.Destroy;
begin
  inherited;
  FBaseNode:=nil;
end;

procedure TSMTransformOperation.Drag(
  const SMDocument: TCustomSMDocument);
begin
  DragLine(SMDocument);
end;

{ TMoveSelectedOperation }

procedure TMoveSelectedOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);

var
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  i, j, m, k: integer;
  NodeList:TList;
  LineList:TList;
  AreaList:TList;
  VolumeList:TList;
  ImageRectList:TList;
  Line:ILine;
  Coord, theCoord:ICoord;
  NodeE, VolumeE:IDMElement;
  DrawSelected:integer;
  DX, DY, DZ:double;
  Polyline:IPolyline;
  Volume:IVolume;
  Area:IArea;
  CurvedLine:ICurvedLine;
  CurvedLineE:IDMElement;
  ImageRect:IImageRect;
  ImageRectE:IDMElement;
  aLabel:ISMLabel;
  LineE, AreaE:IDMElement;
  NLine:ILine;
  NNode, Node:ICoordNode;

  X, Y, Z:double;
  ErrorCount:integer;
  DataModel:IDataModel;
  Flag:boolean;

  procedure AddLineToNodeList;
  begin
    if NodeList.IndexOf(pointer(Line.C0))=-1 then
      NodeList.Add(pointer(Line.C0));
    if NodeList.IndexOf(pointer(Line.C1))=-1 then
       NodeList.Add(pointer(Line.C1));
    if DMDocument.SelectionItem[i].QueryInterface(ICurvedLine, CurvedLine)=0 then begin
      CurvedLineE:=CurvedLine as IDMElement;
      CurvedLineE.Draw(Painter, -1);
      CurvedLine.P0X:=CurvedLine.P0X+DX;
      CurvedLine.P0Y:=CurvedLine.P0Y+DY;
      CurvedLine.P0Z:=CurvedLine.P0Z+DZ;
      CurvedLine.P1X:=CurvedLine.P1X+DX;
      CurvedLine.P1Y:=CurvedLine.P1Y+DY;
      CurvedLine.P1Z:=CurvedLine.P1Z+DZ;
    end;
  end;

begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
     DMOperationManager.StartTransaction(nil, leoAdd, rsMoveSelected);

     SMDocument.GetSnapPoint(X, Y, Z, NLine, NNode, nil, False, 0);
     FBaseNode:=NNode;
     
     X0:=SMDocument.VirtualX;
     Y0:=SMDocument.VirtualY;
     Z0:=SMDocument.VirtualZ;
     CurrentStep:=1;
    end;
  1:begin
      Drag(SMDocument);

      DX:=FX1-X0;
      DY:=FY1-Y0;
      DZ:=FZ1-Z0;
      if (DX=0) and (DY=0) and (DZ=0) then Exit;

      NodeList:=TList.Create;
      LineList:=TList.Create;
      AreaList:=TList.Create;
      VolumeList:=TList.Create;
      ImageRectList:=TList.Create;

      theCoord:=nil;
      Flag:=False;
      if (DMDocument.SelectionCount=1) and
         ((ShiftState and sAlt)=0) and
         (DZ=0) then begin
         if ((DMDocument.SelectionItem[0]).QueryInterface(ICoord, theCoord)=0) then
           Flag:=True
         else
         if ((DMDocument.SelectionItem[0]).QueryInterface(ILine, Line)=0) then begin
           theCoord:=Line.C0;
           Coord:=Line.C1;
           if (abs(theCoord.X-Coord.X)<1) and (abs(theCoord.Y-Coord.Y)<1) then
             Flag:=True
         end;
       end;

      if Flag then begin
         X:=theCoord.X;
         Y:=theCoord.Y;
         NodeList.Add(pointer(theCoord));
         for i:=0 to SpatialModel.CoordNodes.Count-1 do begin
           Coord:=SpatialModel.CoordNodes.Item[i] as ICoord;
           if  (Coord<>theCoord) then begin
             if (DX<>0) and (DY<>0) then begin
               if (abs(Coord.X-X)<1) and (abs(Coord.Y-Y)<1) then
                 NodeList.Add(pointer(Coord));
             end else
             if (DX<>0) then begin
               if (abs(Coord.X-X)<1) then
                 NodeList.Add(pointer(Coord));
             end else
             if (DY<>0) then begin
               if (abs(Coord.Y-Y)<1) then
                 NodeList.Add(pointer(Coord));
             end;
           end;
         end;
      end else begin
        for i:=0 to DMDocument.SelectionCount-1 do begin
         if DMDocument.SelectionItem[i].QueryInterface(IVolume, Volume)=0 then
            for k:=0 to Volume.Areas.Count-1 do begin
              Polyline:=Volume.Areas.Item[k] as IPolyline;
              for m:=0 to Polyline.Lines.Count-1 do begin
                Line:=Polyline.Lines.Item[m] as ILine;
                AddLineToNodeList
              end;
            end
          else
          if DMDocument.SelectionItem[i].QueryInterface(IPolyline, Polyline)=0 then
            for m:=0 to Polyline.Lines.Count-1 do begin
              Line:=Polyline.Lines.Item[m] as ILine;
              AddLineToNodeList;
            end
          else
          if DMDocument.SelectionItem[i].QueryInterface(ILine, Line)=0 then
            AddLineToNodeList
          else
          if DMDocument.SelectionItem[i].QueryInterface(ICoord, Coord)=0 then begin
            if NodeList.IndexOf(pointer(Coord))=-1 then
               NodeList.Add(pointer(Coord));
          end else
          if DMDocument.SelectionItem[i].QueryInterface(ISMLabel, aLabel)=0 then begin
            aLabel.LabeldX:=aLabel.LabeldX+DX;
            aLabel.LabeldY:=aLabel.LabeldY+DY;
          end else
        end;
      end;

      for i:=0 to NodeList.Count-1 do begin
        Coord:=ICoord(NodeList[i]);
        if Coord.QueryInterface(ICoordNode, Node)=0 then begin
          for j:=0 to Node.Lines.Count-1 do
            if Node.Lines.Item[j].QueryInterface(ICurvedLine, CurvedLine)<>0 then
              Node.Lines.Item[j].Draw(Painter, -1);
        end;
        (Coord as IDMElement).Draw(Painter, -1);
      end;

      if DataModel.Errors<>nil then begin
        DataModel.CheckErrors;
        ErrorCount:=DataModel.Errors.Count;
      end;

      for i:=0 to NodeList.Count-1 do begin
        Coord:=ICoord(NodeList[i]);
        Coord.X:=Coord.X+DX;
        Coord.Y:=Coord.Y+DY;
        Coord.Z:=Coord.Z+DZ;
      end;

      for i:=0 to NodeList.Count-1 do begin
        Coord:=ICoord(NodeList[i]);
        if Coord.QueryInterface(ICoordNode, Node)=0 then
          SMDocument.GlueNode(Node, nil);
      end;

      for i:=0 to NodeList.Count-1 do begin
        Coord:=ICoord(NodeList[i]);
        if Coord.QueryInterface(ICoordNode, Node)=0 then begin
          for j:=0 to Node.Lines.Count-1 do begin
            if Node.Lines.Item[j].Selected then
              DrawSelected:=1
            else
              DrawSelected:=0;
            Node.Lines.Item[j].Draw(Painter, DrawSelected);
          end;
          for m:=0 to Node.Lines.Count-1 do begin
            LineE:=Node.Lines.Item[m];
            if LineE.Ref<>nil then
              DMOperationManager.UpdateCoords(LineE.Ref);
            Line:=LineE as ILine;

            if LineE.QueryInterface(IImageRect, ImageRect)=0 then begin
              ImageRectE:=ImageRect as IDMElement;
              if ImageRectList.IndexOf(pointer(ImageRectE))=-1 then
                ImageRectList.Add(pointer(ImageRectE));
            end else begin
              for k:=0 to LineE.Parents.Count-1 do begin
                AreaE:=LineE.Parents.Item[k];
                if AreaList.IndexOf(pointer(AreaE))=-1 then
                  AreaList.Add(pointer(AreaE));

                if AreaE.QueryInterface(IArea, Area)=0 then begin;
                  VolumeE:=Area.Volume0 as IDMElement;
                  if (VolumeE<>nil) and
                     (VolumeList.IndexOf(pointer(VolumeE))=-1) then
                    VolumeList.Add(pointer(VolumeE));

                  VolumeE:=Area.Volume1 as IDMElement;
                  if (VolumeE<>nil) and
                     (VolumeList.IndexOf(pointer(VolumeE))=-1) then
                    VolumeList.Add(pointer(VolumeE));
                end;
              end;
            end;
          end;
        end;

        NodeE:=Coord as IDMElement;
        if NodeE.Selected then
          DrawSelected:=1
        else
          DrawSelected:=0;
        NodeE.Draw(Painter, DrawSelected);

        if NodeE.Ref<>nil then
          DMOperationManager.UpdateCoords(NodeE.Ref);
      end;

      for i:=0 to AreaList.Count-1 do begin
        AreaE:=IDMElement(AreaList[i]);
        DMOperationManager.UpdateCoords(AreaE);
        if AreaE.Ref<>nil then
          DMOperationManager.UpdateCoords(AreaE.Ref);
        if AreaE.Selected then
          AreaE.Draw(Painter, 1);
      end;

      for i:=0 to VolumeList.Count-1 do begin
        VolumeE:=IDMElement(VolumeList[i]);
        DMOperationManager.UpdateCoords(VolumeE);
        if VolumeE.Selected then
          VolumeE.Draw(Painter, 1);
      end;

      for i:=0 to ImageRectList.Count-1 do begin
        ImageRectE:=IDMElement(ImageRectList[i]);
        DMOperationManager.UpdateCoords(ImageRectE);
        if ImageRectE.Selected then
          ImageRectE.Draw(Painter, 1);
      end;

      DMDocument.Server.RefreshDocument(rfFrontBack);

      NodeList.Free;
      LineList.Free;
      AreaList.Free;
      VolumeList.Free;
      ImageRectList.Free;
      CurrentStep:=-1;

      if DataModel.Errors<>nil then begin
        DataModel.CheckErrors;
        if DataModel.Errors.Count-ErrorCount>0 then begin
          DMDocument.Server.CallDialog(sdmShowMessage, '',
          'Операция выполнена с ошибками. Рекомендуется проверить корректность модели');
        end;
      end;

    end;
  end;
end;

procedure TMoveSelectedOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
   -1, 0:
     begin
       Hint:='ПЕРЕМЕЩЕНИЕ: Укажите начало вектора перемещения';
       ACursor:=CR_TOOL_MOVE;
     end;
   1:begin
       Hint:='ПЕРЕМЕЩЕНИЕ: Укажите конец вектора перемещения (CTRL - перемещение параллельно сторонам экрана)';
       ACursor:=CR_TOOL_MOVE;
     end;
   else
     inherited;
   end;
end;

{ TRotateSelectedOperation }

procedure TRotateSelectedOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);

var
  dx, dy, dz, rr, r:double;
  NX, NY, NZ, sin_A1, cos_A1:double;
  PX, PY, PZ:double;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  i, j, k, m: integer;
  NodeList:TList;
  LineList:TList;
  AreaList:TList;
  ImageRectList:TList;
  VolumeList:TList;
  Line:ILine;
  CurvedLine:ICurvedLine;
  Coord:ICoord;
  NodeE, CurvedLineE:IDMElement;
  DrawSelected:integer;
  Polyline:IPolyline;
  Volume:IVolume;
  ImageRect:IImageRect;
  ImageRectE:IDMElement;
  aAngle:double;
  LineE, AreaE:IDMElement;
  NLine:ILine;
  NNode, Node:ICoordNode;
  X, Y, Z:double;
  DataModel:IDataModel;
  ErrorCount:integer;
  Rotater:IRotater;
  Area:IArea;
  VolumeE:IDMElement;

  procedure AddLineToNodeList;
  begin
    if NodeList.IndexOf(pointer(Line.C0))=-1 then
      NodeList.Add(pointer(Line.C0));
    if NodeList.IndexOf(pointer(Line.C1))=-1 then
       NodeList.Add(pointer(Line.C1));
    if DMDocument.SelectionItem[i].QueryInterface(ICurvedLine, CurvedLine)=0 then begin
      CurvedLineE:=CurvedLine as IDMElement;
      CurvedLineE.Draw(Painter, -1);
      PX:=X0+(CurvedLine.P0X-X0)*Fcos_RefA+(CurvedLine.P0Y-Y0)*Fsin_RefA;
      PY:=Y0-(CurvedLine.P0X-X0)*Fsin_RefA+(CurvedLine.P0Y-Y0)*Fcos_RefA;
      PZ:=CurvedLine.P0Z;
      CurvedLine.P0Y:=PY;
      CurvedLine.P0Z:=PZ;
      PX:=X0+(CurvedLine.P1X-X0)*Fcos_RefA+(CurvedLine.P1Y-Y0)*Fsin_RefA;
      PY:=Y0-(CurvedLine.P1X-X0)*Fsin_RefA+(CurvedLine.P1Y-Y0)*Fcos_RefA;
      PZ:=CurvedLine.P0Z;
      CurvedLine.P1X:=PX;
      CurvedLine.P1Y:=PY;
      CurvedLine.P1Z:=PZ;
    end;
  end;

begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
      DMOperationManager.StartTransaction(nil, leoAdd, rsRotateSelected);

      SMDocument.GetSnapPoint(X, Y, Z, NLine, NNode, nil, False, 0);
      FBaseNode:=NNode;

      X0:=SMDocument.VirtualX;
      Y0:=SMDocument.VirtualY;
      Z0:=SMDocument.VirtualZ;
      CurrentStep:=1;
    end;
  1:begin
      FRX:=SMDocument.VirtualX;
      FRY:=SMDocument.VirtualY;
      FRZ:=SMDocument.VirtualZ;
      dx:=FRX-X0;
      dy:=FRY-Y0;
      dz:=FRZ-Z0;
      rr:=dx*dx+dy*dy+dz*dz;
      if rr<>0 then begin
        r:=sqrt(rr);
        Fcos_A0:=dx/r;
        Fsin_A0:=dy/r;
//        Drag(SMDocument);
        CurrentStep:=2;
      end;
    end;
  2:begin
      NX:=SMDocument.VirtualX;
      NY:=SMDocument.VirtualY;
      NZ:=SMDocument.VirtualZ;
      dx:=NX-X0;
      dy:=NY-Y0;
      dz:=NZ-Z0;
      rr:=dx*dx+dy*dy+dz*dz;
      if rr<>0 then begin
        r:=sqrt(rr);
        cos_A1:=dx/r;
        sin_A1:=dy/r;
        Fcos_RefA:=+(cos_A1*Fcos_A0+sin_A1*Fsin_A0);
        Fsin_RefA:=-(sin_A1*Fcos_A0-cos_A1*Fsin_A0);

        FDone:=True;
        Drag(SMDocument);

        NodeList:=TList.Create;
        LineList:=TList.Create;
        AreaList:=TList.Create;
        ImageRectList:=TList.Create;
        VolumeList:=TList.Create;
        for i:=0 to DMDocument.SelectionCount-1 do begin
          if DMDocument.SelectionItem[i].QueryInterface(IVolume, Volume)=0 then
            for k:=0 to Volume.Areas.Count-1 do begin
              Polyline:=Volume.Areas.Item[k] as IPolyline;
              for m:=0 to Polyline.Lines.Count-1 do begin
                Line:=Polyline.Lines.Item[m] as ILine;
                AddLineToNodeList;
              end;
            end
          else
          if DMDocument.SelectionItem[i].QueryInterface(IPolyline, Polyline)=0 then
            for m:=0 to Polyline.Lines.Count-1 do begin
              Line:=Polyline.Lines.Item[m] as ILine;
              AddLineToNodeList;
            end
          else
          if DMDocument.SelectionItem[i].QueryInterface(ILine, Line)=0 then
            AddLineToNodeList
          else
          if DMDocument.SelectionItem[i].QueryInterface(ICoord, Coord)=0 then begin
            if NodeList.IndexOf(pointer(Coord))=-1 then
               NodeList.Add(pointer(Coord));
          end
        end;

        for i:=0 to NodeList.Count-1 do begin
          Coord:=ICoord(NodeList[i]);
          if Coord.QueryInterface(ICoordNode, Node)=0 then begin
            for j:=0 to Node.Lines.Count-1 do
              if Node.Lines.Item[j].QueryInterface(ICurvedLine, CurvedLine)<>0 then
                Node.Lines.Item[j].Draw(Painter, -1);
          end;
          (Coord as IDMElement).Draw(Painter, -1);
        end;

        if DataModel.Errors<>nil then begin
          DataModel.CheckErrors;
          ErrorCount:=DataModel.Errors.Count;
        end;

        for i:=0 to NodeList.Count-1 do begin
          Coord:=ICoord(NodeList[i]);
          if Coord.QueryInterface(IRotater, Rotater)=0 then
            Rotater.Rotate(X0, Y0, Fcos_RefA, Fsin_RefA);
        end;

        for i:=0 to NodeList.Count-1 do begin
          Coord:=ICoord(NodeList[i]);
          if Coord.QueryInterface(ICoordNode, Node)=0 then
            SMDocument.GlueNode(Node, nil);
        end;

        for i:=0 to NodeList.Count-1 do begin
          Coord:=ICoord(NodeList[i]);
          NodeE:=Coord as IDMElement;
          if Coord.QueryInterface(ICoordNode, Node)=0 then begin
            for j:=0 to Node.Lines.Count-1 do begin
              if Node.Lines.Item[j].Selected then
                DrawSelected:=1
              else
                DrawSelected:=0;
              if Node.Lines.Item[j].QueryInterface(IImageRect, ImageRect)<>0 then
                Node.Lines.Item[j].Draw(Painter, DrawSelected);
            end;
            if NodeE.Ref<>nil then
              DMOperationManager.UpdateCoords(NodeE.Ref);
              for m:=0 to Node.Lines.Count-1 do begin
                LineE:=Node.Lines.Item[m];
                if LineE.Ref<>nil then
                  DMOperationManager.UpdateCoords(LineE.Ref);
                Line:=LineE as ILine;

               if LineE.QueryInterface(IImageRect, ImageRect)=0 then begin
                 ImageRectE:=ImageRect as IDMElement;
                 if ImageRectList.IndexOf(pointer(ImageRectE))=-1 then
                   ImageRectList.Add(pointer(ImageRectE));
               end else begin
                 for k:=0 to LineE.Parents.Count-1 do begin
                   AreaE:=LineE.Parents.Item[k];
                   if AreaList.IndexOf(pointer(AreaE))=-1 then
                     AreaList.Add(pointer(AreaE));

                  if AreaE.QueryInterface(IArea, Area)=0 then begin;
                    VolumeE:=Area.Volume0 as IDMElement;
                    if (VolumeE<>nil) and
                       (VolumeList.IndexOf(pointer(VolumeE))=-1) then
                      VolumeList.Add(pointer(VolumeE));

                    VolumeE:=Area.Volume1 as IDMElement;
                    if (VolumeE<>nil) and
                       (VolumeList.IndexOf(pointer(VolumeE))=-1) then
                      VolumeList.Add(pointer(VolumeE));
                  end;
                 end;
               end;
             end;
           end;
        end;
        if NodeE.Selected then
          DrawSelected:=1
        else
          DrawSelected:=0;
        NodeE.Draw(Painter, DrawSelected);

        for i:=0 to AreaList.Count-1 do begin
          AreaE:=IDMElement(AreaList[i]);
          DMOperationManager.UpdateCoords(AreaE);
          if AreaE.Ref<>nil then
            DMOperationManager.UpdateCoords(AreaE.Ref);
        end;

        for i:=0 to VolumeList.Count-1 do begin
          VolumeE:=IDMElement(VolumeList[i]);
          if VolumeE.Ref<>nil then begin
            if VolumeE.Ref.QueryInterface(IRotater, Rotater)=0 then
              Rotater.Rotate(X0, Y0, Fcos_RefA, Fsin_RefA);
            if VolumeE.Selected then
              VolumeE.Ref.Draw(Painter, 1)
            else
              VolumeE.Ref.Draw(Painter, 0)
          end;
        end;

        for i:=0 to ImageRectList.Count-1 do begin
          ImageRectE:=IDMElement(ImageRectList[i]);
          ImageRect:=ImageRectE as IImageRect;
          aAngle := ArcCos(Fcos_RefA)*180/Pi;
          If Fsin_RefA<0 then  aAngle :=-aAngle;
          ImageRect.Angle :=ImageRect.Angle + aAngle;
          DMOperationManager.UpdateCoords(ImageRectE);
        end;

        NodeList.Free;
        LineList.Free;
        AreaList.Free;
        ImageRectList.Free;
        VolumeList.Free;
        CurrentStep:=-1;

        if DataModel.Errors<>nil then begin
          DataModel.CheckErrors;
          if DataModel.Errors.Count-ErrorCount>0 then begin
            DMDocument.Server.CallDialog(sdmShowMessage, '',
            'Операция выполнена с ошибками. Рекомендуется проверить корректность модели');
          end;
        end;

      end;
    end;
  end;
end;

procedure TRotateSelectedOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
   -1, 0:
     begin
       Hint:='ПОВОРОТ: Укажите центр поворота';
       ACursor:=CR_TOOL_ROTATE;
     end;
   1:begin
       Hint:='ПОВОРОТ: Укажите исходное направление (CTRL - поворот на угол кратный 90 град.)';
       ACursor:=CR_TOOL_ROTATE;
     end;
   2:begin
       Hint:='ПОВОРОТ: Укажите конечное направление (CTRL - поворот на угол кратный 90 град.)';
       ACursor:=CR_TOOL_ROTATE;
     end;
   else
     inherited;
   end;
end;

{ TScaleSelectedOperation }

procedure TScaleSelectedOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  dx, dy, dz, rr:double;
  NX, NY, NZ, NewLength:double;
  PX, PY, PZ:double;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  i, j, k, m: integer;
  NodeList:TList;
  LineList:TList;
  AreaList:TList;
  VolumeList:TList;
  ImageRectList:TList;
  Line:ILine;
  CurvedLine:ICurvedLine;
  Coord:ICoord;
  NodeE, CurvedLineE:IDMElement;
  DrawSelected:integer;
  Polyline:IPolyline;
  Volume:IVolume;
  ImageRect:IImageRect;
  ImageRectE:IDMElement;
  LineE, AreaE, VolumeE:IDMElement;
  NLine:ILine;
  NNode, Node:ICoordNode;
  X, Y, Z:double;
  Circle:ICircle;
  DataModel:IDataModel;
  ErrorCount:integer;
  Area:IArea;

  procedure AddLineToNodeList;
  begin
    if NodeList.IndexOf(pointer(Line.C0))=-1 then
      NodeList.Add(pointer(Line.C0));
    if NodeList.IndexOf(pointer(Line.C1))=-1 then
       NodeList.Add(pointer(Line.C1));
    if DMDocument.SelectionItem[i].QueryInterface(ICurvedLine, CurvedLine)=0 then begin
      CurvedLineE:=CurvedLine as IDMElement;
      CurvedLineE.Draw(Painter, -1);
      PX:=X0+(CurvedLine.P0X-X0)*FScaleRatio;
      PY:=Y0+(CurvedLine.P0Y-Y0)*FScaleRatio;
      PZ:=CurvedLine.P0Z;
      CurvedLine.P0X:=PX;
      CurvedLine.P0Y:=PY;
      CurvedLine.P0Z:=PZ;
      PX:=X0+(CurvedLine.P1X-X0)*FScaleRatio;
      PY:=Y0+(CurvedLine.P1Y-Y0)*FScaleRatio;
      PZ:=CurvedLine.P0Z;
      CurvedLine.P1X:=PX;
      CurvedLine.P1Y:=PY;
      CurvedLine.P1Z:=PZ;
    end;
  end;

begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
      DMOperationManager.StartTransaction(nil, leoAdd, rsScaleSelected);

      SMDocument.GetSnapPoint(X, Y, Z, NLine, NNode, nil, False, 0);
      FBaseNode:=NNode;

      X0:=SMDocument.VirtualX;
      Y0:=SMDocument.VirtualY;
      Z0:=SMDocument.VirtualZ;
      CurrentStep:=1;
    end;
  1:begin
      FRX:=SMDocument.VirtualX;
      FRY:=SMDocument.VirtualY;
      FRZ:=SMDocument.VirtualZ;
      dx:=FRX-X0;
      dy:=FRY-Y0;
      dz:=FRZ-Z0;
      rr:=dx*dx+dy*dy+dz*dz;
      if rr<>0 then begin
        FReferenceLength:=sqrt(rr);
//        Drag(SMDocument);
        CurrentStep:=2;
      end;
    end;
  2:begin
      NX:=SMDocument.VirtualX;
      NY:=SMDocument.VirtualY;
      NZ:=SMDocument.VirtualZ;
      dx:=NX-X0;
      dy:=NY-Y0;
      dz:=NZ-Z0;
      rr:=dx*dx+dy*dy+dz*dz;
      if rr<>0 then begin
        NewLength:=sqrt(rr);
        FScaleRatio:=NewLength/FReferenceLength;

        FDone:=True;
        Drag(SMDocument);

        NodeList:=TList.Create;
        LineList:=TList.Create;
        AreaList:=TList.Create;
        VolumeList:=TList.Create;
        ImageRectList:=TList.Create;
        for i:=0 to DMDocument.SelectionCount-1 do begin
          if DMDocument.SelectionItem[i].QueryInterface(IVolume, Volume)=0 then
            for k:=0 to Volume.Areas.Count-1 do begin
              Polyline:=Volume.Areas.Item[k] as IPolyline;
              for m:=0 to Polyline.Lines.Count-1 do begin
                Line:=Polyline.Lines.Item[m] as ILine;
                AddLineToNodeList;
              end;
            end
          else
          if DMDocument.SelectionItem[i].QueryInterface(IPolyline, Polyline)=0 then
            for m:=0 to Polyline.Lines.Count-1 do begin
              Line:=Polyline.Lines.Item[m] as ILine;
              AddLineToNodeList;
            end
          else
          if DMDocument.SelectionItem[i].QueryInterface(ILine, Line)=0 then
            AddLineToNodeList
          else
          if DMDocument.SelectionItem[i].QueryInterface(ICoord, Coord)=0 then begin
            if NodeList.IndexOf(pointer(Coord))=-1 then
               NodeList.Add(pointer(Coord));
          end
        end;

        for i:=0 to NodeList.Count-1 do begin
          Coord:=ICoord(NodeList[i]);
          if Coord.QueryInterface(ICoordNode, Node)=0 then begin
            for j:=0 to Node.Lines.Count-1 do
              if Node.Lines.Item[j].QueryInterface(ICurvedLine, CurvedLine)<>0 then
                Node.Lines.Item[j].Draw(Painter, -1);
          end;
          (Coord as IDMElement).Draw(Painter, -1);
        end;

        if DataModel.Errors<>nil then begin
          DataModel.CheckErrors;
          ErrorCount:=DataModel.Errors.Count;
        end;

        for i:=0 to NodeList.Count-1 do begin
          Coord:=ICoord(NodeList[i]);
          if Coord.QueryInterface(ICoordNode, Node)=0 then begin
            PX:=X0+(Node.X-X0)*FScaleRatio;
            PY:=Y0+(Node.Y-Y0)*FScaleRatio;
            PZ:=Node.Z;
            Node.X:=PX;
            Node.Y:=PY;
            Node.Z:=PZ;
          end;  
          if Coord.QueryInterface(ICircle, Circle)=0 then
            Circle.Radius:=Circle.Radius*FScaleRatio
        end;

        for i:=0 to NodeList.Count-1 do begin
          Coord:=ICoord(NodeList[i]);
          if Coord.QueryInterface(ICoordNode, Node)=0 then
            SMDocument.GlueNode(Node, nil);
        end;

        for i:=0 to NodeList.Count-1 do begin
          Coord:=ICoord(NodeList[i]);
          if Coord.QueryInterface(ICoordNode, Node)=0 then begin
            for j:=0 to Node.Lines.Count-1 do begin
              if Node.Lines.Item[j].Selected then
                DrawSelected:=1
              else
                DrawSelected:=0;
              Node.Lines.Item[j].Draw(Painter, DrawSelected);
            end;
            for m:=0 to Node.Lines.Count-1 do begin
              LineE:=Node.Lines.Item[m];
              if LineE.Ref<>nil then
                DMOperationManager.UpdateCoords(LineE.Ref);
              Line:=LineE as ILine;

              if LineE.QueryInterface(IImageRect, ImageRect)=0 then begin
                ImageRectE:=ImageRect as IDMElement;
                if ImageRectList.IndexOf(pointer(ImageRectE))=-1 then
                  ImageRectList.Add(pointer(ImageRectE));
              end else begin
                for k:=0 to LineE.Parents.Count-1 do begin
                  AreaE:=LineE.Parents.Item[k];
                  if AreaList.IndexOf(pointer(AreaE))=-1 then
                    AreaList.Add(pointer(AreaE));

                  if AreaE.QueryInterface(IArea, Area)=0 then begin;
                    VolumeE:=Area.Volume0 as IDMElement;
                    if (VolumeE<>nil) and
                       (VolumeList.IndexOf(pointer(VolumeE))=-1) then
                      VolumeList.Add(pointer(VolumeE));

                    VolumeE:=Area.Volume1 as IDMElement;
                    if (VolumeE<>nil) and
                       (VolumeList.IndexOf(pointer(VolumeE))=-1) then
                      VolumeList.Add(pointer(VolumeE));
                  end;
                end;
              end;
            end;
          end;

          NodeE:=Coord as IDMElement;
          if NodeE.Ref<>nil then
            DMOperationManager.UpdateCoords(NodeE.Ref);
          if NodeE.Selected then
            DrawSelected:=1
          else
            DrawSelected:=0;
          NodeE.Draw(Painter, DrawSelected);
        end;


        for i:=0 to AreaList.Count-1 do begin
          AreaE:=IDMElement(AreaList[i]);
          DMOperationManager.UpdateCoords(AreaE);
          if AreaE.Ref<>nil then
            DMOperationManager.UpdateCoords(AreaE.Ref);
          if AreaE.Selected then
            AreaE.Draw(Painter, 1);
        end;

        for i:=0 to VolumeList.Count-1 do begin
          VolumeE:=IDMElement(VolumeList[i]);
          if VolumeE.Ref<>nil then begin
            if VolumeE.Selected then
              VolumeE.Ref.Draw(Painter, 1)
            else
              VolumeE.Ref.Draw(Painter, 0)
          end;
        end;

        for i:=0 to ImageRectList.Count-1 do begin
          ImageRectE:=IDMElement(ImageRectList[i]);
          DMOperationManager.UpdateCoords(ImageRectE);
          if ImageRectE.Selected then
            ImageRectE.Draw(Painter, 1);
        end;

        NodeList.Free;
        LineList.Free;
        AreaList.Free;
        VolumeList.Free;
        ImageRectList.Free;
        CurrentStep:=-1;

        if DataModel.Errors<>nil then begin
          DataModel.CheckErrors;
          if DataModel.Errors.Count-ErrorCount>0 then begin
            DMDocument.Server.CallDialog(sdmShowMessage, '',
            'Операция выполнена с ошибками. Рекомендуется проверить корректность модели');
          end;
        end;
      end;
    end;
  end;
end;

procedure TScaleSelectedOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
   -1, 0:
     begin
       Hint:='ИЗМЕНЕНИЕ РАЗМЕРА: Укажите базовую точку масштабирования';
       ACursor:=CR_TOOL_SCALE;
     end;
   1:begin
       Hint:='ИЗМЕНЕНИЕ РАЗМЕРА: Укажите исходный размер отрезка';
       ACursor:=CR_TOOL_SCALE;
     end;
   2:begin
       Hint:='ИЗМЕНЕНИЕ РАЗМЕРА: Укажите конечный размер отрезка';
       ACursor:=CR_TOOL_SCALE;
     end;
   else
     inherited;
   end;
end;

{ TSMTransformOperation2 }

procedure TSMTransformOperation2.Drag(
  const SMDocument: TCustomSMDocument);
var
  Painter:IPainter;
begin
  if CurrentStep=2 then begin
    Painter:=SMDocument.PainterU as IPainter;
    Painter.PenStyle:=ord(psDot);
    if not FDone then
      Painter.PenMode:=ord(pmCopy)
    else
      Painter.PenMode:=ord(pmNotXor);
    Painter.PenColor:=clBlack;
    Painter.DrawLine(X0, Y0, Z0, FRX, FRY, FRX);
  end;
  inherited;
end;

function TSMTransformOperation.GetBaseNode: ICoordNode;
begin
  Result:=FBaseNode
end;

procedure TSMTransformOperation.Init;
begin
  inherited;
  FBaseNode:=nil;
end;

procedure TSMTransformOperation.Stop(const SMDocument: TCustomSMDocument;
  ShiftState: integer);
var
  DMDocument:IDMDocument;
begin
  inherited;
  if ((ShiftState and sRight)<>0) then begin
    if (CurrentStep<>-1)  then begin
      DMDocument:=SMDocument as IDMDocument;
      if DMDocument.SelectionCount>0 then
        DMDocument.ClearSelection(nil)
      else
      if (CurrentStep=0) then
        DMDocument.UndoSelection
    end;
  end;  
end;

{ TMirrorSelectedOperation }

procedure TMirrorSelectedOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);

var
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  i, j, m, k: integer;
  NodeList:TList;
  LineList:TList;
  AreaList:TList;
  VolumeList:TList;
  ImageRectList:TList;
  Line:ILine;
  Coord:ICoord;
  NodeE, VolumeE:IDMElement;
  DrawSelected:integer;
  Polyline:IPolyline;
  Volume:IVolume;
  Area:IArea;
  CurvedLine:ICurvedLine;
  CurvedLineE:IDMElement;
  ImageRect:IImageRect;
  ImageRectE:IDMElement;
  aLabel:ISMLabel;
  LineE, AreaE:IDMElement;
  NLine:ILine;
  NNode, Node:ICoordNode;
  X, Y, Z, PX, PY, WX, WY:double;

  procedure AddLineToNodeList;
  begin
    if NodeList.IndexOf(pointer(Line.C0))=-1 then
      NodeList.Add(pointer(Line.C0));
    if NodeList.IndexOf(pointer(Line.C1))=-1 then
       NodeList.Add(pointer(Line.C1));
    if DMDocument.SelectionItem[i].QueryInterface(ICurvedLine, CurvedLine)=0 then begin
      CurvedLineE:=CurvedLine as IDMElement;
      CurvedLineE.Draw(Painter, -1);
      WX:=CurvedLine.P0X;
      WY:=CurvedLine.P0Y;
      PerpendicularFrom0(X0, Y0, FX1, FY1, WX, WY, PX, PY);
      CurvedLine.P0X:=WX+2*(PX-WX);
      CurvedLine.P0Y:=WY+2*(PY-WY);

      WX:=CurvedLine.P1X;
      WY:=CurvedLine.P1Y;
      PerpendicularFrom0(X0, Y0, FX1, FY1, WX, WY, PX, PY);
      CurvedLine.P1X:=WX+2*(PX-WX);
      CurvedLine.P1Y:=WY+2*(PY-WY);
    end;
  end;

begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  case CurrentStep of
  0:begin
     DMOperationManager.StartTransaction(nil, leoAdd, rsMoveSelected);

     SMDocument.GetSnapPoint(X, Y, Z, NLine, NNode, nil, False, 0);
     FBaseNode:=NNode;

     X0:=SMDocument.VirtualX;
     Y0:=SMDocument.VirtualY;
     Z0:=SMDocument.VirtualZ;
     CurrentStep:=1;
    end;
  1:begin
      Drag(SMDocument);

      NodeList:=TList.Create;
      LineList:=TList.Create;
      AreaList:=TList.Create;
      VolumeList:=TList.Create;
      ImageRectList:=TList.Create;
      for i:=0 to DMDocument.SelectionCount-1 do begin
        if DMDocument.SelectionItem[i].QueryInterface(IVolume, Volume)=0 then
          for k:=0 to Volume.Areas.Count-1 do begin
            Polyline:=Volume.Areas.Item[k] as IPolyline;
            for m:=0 to Polyline.Lines.Count-1 do begin
              Line:=Polyline.Lines.Item[m] as ILine;
              AddLineToNodeList
            end;
          end
        else
        if DMDocument.SelectionItem[i].QueryInterface(IPolyline, Polyline)=0 then
          for m:=0 to Polyline.Lines.Count-1 do begin
            Line:=Polyline.Lines.Item[m] as ILine;
            AddLineToNodeList;
          end
        else
        if DMDocument.SelectionItem[i].QueryInterface(ILine, Line)=0 then
          AddLineToNodeList
        else
        if DMDocument.SelectionItem[i].QueryInterface(ICoord, Coord)=0 then begin
          if NodeList.IndexOf(pointer(Coord))=-1 then
             NodeList.Add(pointer(Coord));
        end else
        if DMDocument.SelectionItem[i].QueryInterface(ISMLabel, aLabel)=0 then begin
          WX:=aLabel.LabeldX;
          WY:=aLabel.LabeldY;
          PerpendicularFrom0(X0, Y0, FX1, FY1, WX, WY, PX, PY);
          aLabel.LabeldX:=WX+2*(PX-WX);
          aLabel.LabeldY:=WY+2*(PY-WY);
        end else
      end;

      for i:=0 to NodeList.Count-1 do begin
        Coord:=ICoord(NodeList[i]);
        if Coord.QueryInterface(ICoordNode, Node)=0 then begin
          for j:=0 to Node.Lines.Count-1 do
            if Node.Lines.Item[j].QueryInterface(ICurvedLine, CurvedLine)<>0 then
              Node.Lines.Item[j].Draw(Painter, -1);
        end;
        (Coord as IDMElement).Draw(Painter, -1);
      end;

      for i:=0 to NodeList.Count-1 do begin
        Coord:=ICoord(NodeList[i]);
        if Coord.QueryInterface(ICoordNode, Node)=0 then begin
          WX:=Node.X;
          WY:=Node.Y;
          PerpendicularFrom0(X0, Y0, FX1, FY1, WX, WY, PX, PY);
          Node.X:=WX+2*(PX-WX);
          Node.Y:=WY+2*(PY-WY);
        end;
      end;

      for i:=0 to NodeList.Count-1 do begin
        Coord:=ICoord(NodeList[i]);
        if Coord.QueryInterface(ICoordNode, Node)=0 then
          SMDocument.GlueNode(Node, nil);
      end;

      for i:=0 to NodeList.Count-1 do begin
        Coord:=ICoord(NodeList[i]);
        if Coord.QueryInterface(ICoordNode, Node)=0 then begin
          for j:=0 to Node.Lines.Count-1 do begin
            if Node.Lines.Item[j].Selected then
              DrawSelected:=1
            else
              DrawSelected:=0;
            Node.Lines.Item[j].Draw(Painter, DrawSelected);
          end;

          for m:=0 to Node.Lines.Count-1 do begin
            LineE:=Node.Lines.Item[m];
            if LineE.Ref<>nil then
              DMOperationManager.UpdateCoords(LineE.Ref);
            Line:=LineE as ILine;

            if LineE.QueryInterface(IImageRect, ImageRect)=0 then begin
              ImageRectE:=ImageRect as IDMElement;
              if ImageRectList.IndexOf(pointer(ImageRectE))=-1 then
                ImageRectList.Add(pointer(ImageRectE));
            end else begin
              for k:=0 to LineE.Parents.Count-1 do begin
                AreaE:=LineE.Parents.Item[k];
                if AreaList.IndexOf(pointer(AreaE))=-1 then
                  AreaList.Add(pointer(AreaE));

                if AreaE.QueryInterface(IArea, Area)=0 then begin;
                  VolumeE:=Area.Volume0 as IDMElement;
                  if (VolumeE<>nil) and
                     (VolumeList.IndexOf(pointer(VolumeE))=-1) then
                    VolumeList.Add(pointer(VolumeE));

                  VolumeE:=Area.Volume1 as IDMElement;
                  if (VolumeE<>nil) and
                     (VolumeList.IndexOf(pointer(VolumeE))=-1) then
                    VolumeList.Add(pointer(VolumeE));
                end;
              end;
            end;
          end;
        end;

        NodeE:=Node as IDMElement;
        if NodeE.Ref<>nil then
          DMOperationManager.UpdateCoords(NodeE.Ref);
        if NodeE.Selected then
          DrawSelected:=1
        else
          DrawSelected:=0;
        NodeE.Draw(Painter, DrawSelected);
      end;

      for i:=0 to AreaList.Count-1 do begin
        AreaE:=IDMElement(AreaList[i]);
        DMOperationManager.UpdateCoords(AreaE);
        if AreaE.Ref<>nil then
          DMOperationManager.UpdateCoords(AreaE.Ref);
        if AreaE.Selected then
          AreaE.Draw(Painter, 1);
      end;

      for i:=0 to VolumeList.Count-1 do begin
        VolumeE:=IDMElement(VolumeList[i]);
        DMOperationManager.UpdateCoords(VolumeE);
        if VolumeE.Selected  then
          VolumeE.Draw(Painter, 1);
      end;

      for i:=0 to ImageRectList.Count-1 do begin
        ImageRectE:=IDMElement(ImageRectList[i]);
        DMOperationManager.UpdateCoords(ImageRectE);
        if ImageRectE.Selected then
          ImageRectE.Draw(Painter, 1);
      end;

      DMDocument.Server.RefreshDocument(rfFrontBack);

      NodeList.Free;
      LineList.Free;
      AreaList.Free;
      VolumeList.Free;
      ImageRectList.Free;
      CurrentStep:=-1;
    end;
  end;
end;

procedure TMirrorSelectedOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
   -1, 0:
     begin
       Hint:='ЗЕРКАЛЬНОЕ ОТРАЖЕНИЕ: Укажите первую точку на оси симметрии';
       ACursor:=CR_TOOL_MIRROR;
     end;
   1:begin
       Hint:='ЗЕРКАЛЬНОЕ ОТРАЖЕНИЕ: Укажите вторую точку на оси симметрии (CTRL - отразить параллельно сторонам экрана)';
       ACursor:=CR_TOOL_MIRROR;
     end;
   else
     inherited;
   end;
end;

end.
