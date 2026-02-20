unit FMDocumentU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj, Classes, SysUtils,
  FMDocumentLib_TLB, FacilityModelLib_TLB, SgdbLib_TLB,
  SpatialModelLib_TLB, DataModel_TLB, DMServer_TLB, PainterLib_TLB,
  SectorBuilderLib_TLB, DMComObjectU,
  CustomSMDocumentU, StdVcl;

function GetDMDocumentClassObject:IDMClassFactory;

type
  TFMDocumentFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;

  TFMDocument = class(TCustomSMDocument, IFMDocument)
  private
    FSubElement:pointer;
  protected
    procedure StartOperation(aOperationCode: Integer); override; safecall;

    procedure BuildPerimeterZone; safecall;
    function Get_NearestLine: IDMElement; override;
    function Get_NearestNode: IDMElement; override;
    procedure OnCreateRefElement(ClassID: integer;
      const RefElementU: IUnknown); override; safecall;
    procedure AddElementRef(const ParentElementU: IUnknown;
                            const CollectionU: IUnknown;
                            const aName: WideString;
                            const aRefU: IUnknown; aLinkType: Integer;
                            out aElementU: IUnknown; SetParentFlag:WordBool); override; safecall;
    function AreaIsObsolet(const AreaE:IDMElement):WordBool; override; safecall;
  public
    procedure AfterRefElementCreation(const aElement: IDMElement); override;

    function CreateRefElement(var ClassID:integer; OperationCode: Integer;
      const Collection: IDMCollection; out RefElement,
      RefParent: IDMElement; SetParentFlag:WordBool): WordBool; override;
    procedure ChangeRefRef(const Collection: IDMCollection;
                        const aName: WideString;
                        const aRef, aElement: IDMElement); override;
    function GetSubElement:IDMElement; override;
  end;

implementation
uses
  SpatialModelConstU, FacilityModelConstU, OutLines, Geometry,
  SMBuildSectorsOperationU;

procedure TFMDocument.BuildPerimeterZone;

procedure ProceedVolume(
                        const VolumeE, RefElement, RefParent:IDMElement;
                        const ParentVolume:IVolume;
                        BaseVolumeFlag:WordBool);
var
  Volume:IVolume;
  aAreaE,aLineE:IDMElement;
  aAreaP,AreaP:IPolyLine;
  VArea:IArea;
  k, m, i, OldState1:integer;
  Flag:boolean;

  procedure CreateVolumeAreaRefElements(const VolumeE:IDMElement; ChangeRefFlag:WordBool);
var
  SpatialModel2:ISpatialModel2;
  aParent:IDMElement;
  j:integer;
  Volume:IVolume;
  AreaRef, AreaRefRef, AreaE:IDMElement;
  aName:WideString;
  aCollection:IDMCollection;
  Painter:IPainter;
  AreaRefU:IUnknown;
  Area:IArea;
  DataModel:IDataModel;
begin
  Painter:=Get_PainterU as IPainter;
  DataModel:=Get_DataModel as IDataModel;
  SpatialModel2:=DataModel as ISpatialModel2;
  Volume:=VolumeE as IVolume;

  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 0, BaseVolumeFlag,
                        aCollection, aName, AreaRefRef);
  if AreaRefRef<>nil then begin
    for j:=0 to Volume.BottomAreas.Count-1 do begin
      AreaE:=Volume.BottomAreas.Item[j];
      Area:=AreaE as IArea;
      AreaRef:=AreaE.Ref;
      aName:=Format('%s %s%s',[DataModel.GetDefaultName(AreaRefRef),
                           '/', VolumeE.Name]);
      if AreaRef=nil then begin
        AddElementRef(
                    nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaRefU, True);
        AreaRef:=AreaRefU as IDMElement;
        AreaE.Ref:=AreaRef;
        AreaRef.Draw(Painter,0);
      end else
      if (Area.Volume1=nil) or
        (AreaRef.Ref=nil) then begin
        ChangeRef(nil, aName, AreaRefRef, AreaRef);
        UpdateCoords(AreaE);
        AreaRef.Draw(Painter,0);
      end;
    end;
  end;

  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 1, BaseVolumeFlag,
                           aCollection, aName, AreaRefRef);
  if AreaRefRef<>nil then begin
    for j:=0 to Volume.TopAreas.Count-1 do begin
      AreaE:=Volume.TopAreas.Item[j];
      Area:=AreaE as IArea;
      AreaRef:=AreaE.Ref;
      aName:=Format('%s %s%s',[DataModel.GetDefaultName(AreaRefRef),
                           '/', VolumeE.Name]);
      if AreaRef=nil then begin
        AddElementRef(
                  nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaRefU, True);
        AreaRef:=AreaRefU as IDMElement;
        AreaE.Ref:=AreaRef;
        AreaRef.Draw(Painter,0);
      end else
      if (Area.Volume0=nil) or
         (AreaRef.Ref=nil) then begin
        ChangeRef(nil, aName, AreaRefRef, AreaRef);
        UpdateCoords(AreaE);
        AreaRef.Draw(Painter,0);
      end;
    end;
  end;

  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 2, BaseVolumeFlag,
                           aCollection, aName, AreaRefRef);
  if AreaRefRef<>nil then begin
    for j:=0 to Volume.Areas.Count-1 do begin
      AreaE:=Volume.Areas.Item[j];
      Area:=AreaE as IArea;
      AreaRef:=AreaE.Ref;
      if Area.IsVertical then begin
        aName:=Format('%s %s%s',[DataModel.GetDefaultName(AreaRefRef),
                           '/', VolumeE.Name]);
        if AreaRef=nil then begin
          AddElementRef(
                  nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaRefU, True);
          AreaRef:=AreaRefU as IDMElement;
          AreaE.Ref:=AreaRef;
          UpdateCoords(AreaE);
          AreaRef.Draw(Painter,0);
        end else
        if ChangeRefFlag  or
          (AreaRef.Ref=nil) then begin
          ChangeRef(nil, aName, AreaRefRef, AreaRef);
          UpdateCoords(AreaE);
          AreaRef.Draw(Painter,0);
        end;
      end;
    end;
  end;
  aParent:=VolumeE.Ref.Parent;
  ChangeParent( nil, aParent, VolumeE.Ref);
       //нужно обновить границы у Parent
  end;

begin
    if VolumeE=nil then Exit;
    if RefParent=nil then Exit;

    Volume:=VolumeE as IVolume;
    if ParentVolume=Volume then Exit;

    VolumeE.Ref:=RefElement;

    AreaP:=Volume.BottomAreas.Item[0] as IPolyline;

    CreateVolumeAreaRefElements(VolumeE, False);

    if (ParentVolume<>nil) then begin

      CheckHAreas(ParentVolume, Volume, bdUp, False);

      if  (Volume.BottomAreas.Count>0) then begin
        AreaP:=Volume.BottomAreas.Item[0] as IPolyline;

        m:=0;
        while m<ParentVolume.BottomAreas.Count do begin
          aAreaE:=ParentVolume.BottomAreas.Item[m];
          aAreaP:=aAreaE as IPolyline;

          OldState1:=FState;
          FState:=FState or dmfCommiting;
          Flag:=OutlineContainsOutline(aAreaP.Lines, AreaP.Lines);
          FState:=OldState1;

          if Flag then begin
            i:=0;
            while i<AreaP.Lines.Count do begin
              aLineE:=AreaP.Lines.Item[i];
              if aAreaP.Lines.IndexOf(aLineE)<>-1 then begin  // зона граничит с внешней зоной
                k:=0;
                while k<AreaP.Lines.Count-1 do begin     // включаем границы внутренней зоны во внешнюю зону
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

          OldState1:=FState;
          FState:=FState or dmfCommiting;
          Flag:=OutlineContainsOutline(aAreaP.Lines, AreaP.Lines);
          FState:=OldState1;

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

            if i<AreaP.Lines.Count then
              Break
            else
              inc(m)
          end else
            inc(m)
        end; // while m<ParentVolume.TopAreas.Count
      end; // if  (Volume.TopAreas.Count>0)
    end;  // if (ParentVolume<>nil)
    ChangeParent( nil, RefParent, RefElement);
    if ParentVolume<>nil then
       CheckHAreas(ParentVolume, Volume, bdUp, False);
    UpdateElement(RefElement);
end;

var
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  j, m, k, i, Indx:integer;
  SelectedElement, VAreaE, BoundaryE, BoundaryLayerE,
  ZoneE, Zone0E, Zone1E, theZoneE, theVolumeE, aAreaE, AreaRef, VolumeRef,
  OldAreaE,  NewVolumeE, aBoundaryE, NewBoundaryE, OldBoundaryE:IDMElement;
  VArea, NextArea, aArea, BottomArea, OldArea, NewArea:IArea;
  theVolume, NewVolume, aVolume0, aVolume1:IVolume;
  Zone:IZone;
  Boundary, aBoundary, NewBoundary, OldBoundary:IBoundary;
  BoundaryLayerType:IBoundaryLayerType;
  BoundaryLayer, PrevBoundaryLayer:IBoundaryLayer;
  OldAreaList, NewBottomAreaList, NewLineList, OldBoundaryList:TList;
  AreaU, LineU, CU: IUnknown;
  BottomAreaE, aLineE, LineE, Line0E, Line1E, aLine0E, aLine1E, LineLayerE, AreaLayerE:IDMElement;
  Line, Line0, Line1, NextLine, PrevLine, FirstLine, aLine0, aLine1, aLine:ILine;
  FirstC, C0, C1, CC0, CC1, aC:ICoordNode;
  X0, Y0, Z0, X1, Y1, Z1, XX0, YY0, ZZ0, XX1, YY1, ZZ1, L0, L1,
  PrevL, FirstL, Height:double;
  aName, VirtualName:WideString;
  AreaCollection:IDMCollection;
  AreaCollection2:IDMCollection2;
  SafeguardDataBase:ISafeguardDataBase;
  BoundaryTypes:IDMCollection;
  BoundaryTypeE:IDMElement;
  VirtualBoundaryTypeE:IDMElement;
begin
  if Get_SelectionCount=0 then Exit;
  SelectedElement:=Get_SelectionItem(0) as IDMElement;
  if SelectedElement.ClassID<>_Volume then Exit;

  StartTransaction(nil, leoAdd, rsBuildVolume);

  DataModel:=Get_DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  SafeguardDataBase:=(DataModel as IDMElement).Ref as ISafeguardDataBase;

  OldAreaList:=TList.Create;
  OldBoundaryList:=TList.Create;
  NewBottomAreaList:=TList.Create;
  NewLineList:=TList.Create;
  AreaCollection:=DataModel.CreateCollection(-1, nil);
  AreaCollection2:=AreaCollection as IDMCollection2;
  try
  for j:=0 to Get_SelectionCount-1 do begin
    SelectedElement:=Get_SelectionItem(j) as IDMElement;
    if SelectedElement.ClassID=_Volume then begin
      ZoneE:=SelectedElement.Ref;
      Zone:=ZoneE as IZone;
      PrevLine:=nil;
      NextLine:=nil;
      FirstLine:=nil;
      PrevL:=-1;
      FirstL:=-1;
      PrevBoundaryLayer:=nil;
      for m:=0 to Zone.VAreas.Count-1 do begin
        VAreaE:=Zone.VAreas.Item[m];
        VArea:=VAreaE as IArea;
        if VArea.BottomLines.Count=0 then Continue;

        BoundaryE:=VAreaE.Ref;
        Boundary:=BoundaryE as IBoundary;
        k:=0;
        while k<Boundary.BoundaryLayers.Count-1 do begin // Count-1, так как самый внутренний слой отделять не имеет смысла
          BoundaryLayerE:=Boundary.BoundaryLayers.Item[k];
          BoundaryLayerType:=BoundaryLayerE.Ref as IBoundaryLayerType;
          if BoundaryLayerType.IsZone then
            Break
          else
            inc(k);
        end;

        if k=Boundary.BoundaryLayers.Count-1 then begin
          NextLine:=nil;  // если очередной рубеж не содержит слой-зону
        end else begin
          BoundaryLayerE:=Boundary.BoundaryLayers.Item[k+1];  // слой, следующий за слоем-зоной

          CC0:=VArea.C0;
          CC1:=VArea.C1;
          XX0:=CC0.X;
          YY0:=CC0.Y;
          ZZ0:=CC0.Z;
          XX1:=CC1.X;
          YY1:=CC1.Y;
          ZZ1:=CC1.Z;

          BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
          X0:=BoundaryLayer.X0;
          Y0:=BoundaryLayer.Y0;
          Z0:=ZZ0;
          X1:=BoundaryLayer.X1;
          Y1:=BoundaryLayer.Y1;
          Z1:=ZZ1;

          L0:=sqrt(sqr(X0-XX0)+sqr(Y0-YY0));
          L1:=sqrt(sqr(X1-XX1)+sqr(Y1-YY1));

          LineLayerE:=VArea.BottomLines.Item[0].Parent;
          AddElement(LineLayerE,
                      SpatialModel.Lines, '', ltOneToMany, LineU, True);
          Line:=LineU as ILine;

          if (m<>Zone.VAreas.Count-1) or
             (FirstLine=nil) then begin
            AddElement(LineLayerE,
                      SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
            AddElement(LineLayerE,
                      SpatialModel.Lines, '', ltOneToMany, LineU, True);
            if PrevLine<>nil then begin
              if PrevLine.C1=CC1 then begin
                Line1:=PrevLine;
                C1:=PrevLine.C0;
                C0:=CU as ICoordNode;
                C0.X:=X0;
                C0.Y:=Y0;
                C0.Z:=Z0;
                Line0:=LineU as ILine;
                Line0.C0:=C0;   // c0->c1 направление наружу
                Line0.C1:=CC0;
                NextLine:=Line0;
              end else begin  // if PrevLine.C1=CC0
                Line0:=PrevLine;
                C0:=PrevLine.C0;
                C1:=CU as ICoordNode;
                C1.X:=X1;
                C1.Y:=Y1;
                C1.Z:=Z1;
                Line1:=LineU as ILine;
                Line1.C0:=C1;   // c0->c1 направление наружу
                Line1.C1:=CC1;
                NextLine:=Line1;
              end;  // if PrevLine.C1...
            end else begin // if PrevLine=nil
              C0:=CU as ICoordNode;
              C0.X:=X0;
              C0.Y:=Y0;
              C0.Z:=Z0;
              Line0:=LineU as ILine;
              Line0.C0:=C0;   // c0->c1 направление наружу
              Line0.C1:=CC0;
              AddElement(LineLayerE,
                      SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
              AddElement(LineLayerE,
                      SpatialModel.Lines, '', ltOneToMany, LineU, True);
              C1:=CU as ICoordNode;
              C1.X:=X1;
              C1.Y:=Y1;
              C1.Z:=Z1;
              Line1:=LineU as ILine;
              Line1.C0:=C1;   // c0->c1 направление наружу
              Line1.C1:=CC1;

              NextArea:=Zone.VAreas.Item[m+1] as IArea;  // следующая граница
              if (NextArea.C0=CC0) or
                 (NextArea.C1=CC0) then
                NextLine:=Line0
              else
                NextLine:=Line1;
            end; // if PrevLine=nil
            if m=0 then begin
              if NextLine=Line0 then
                FirstLine:=Line1
              else
                FirstLine:=Line0;
              FirstL:=FirstLine.Length;
            end;
          end else begin  //if (m=Zone.VAreas.Count-1) and (FirstLine<>nil)
            if PrevLine<>nil then begin
              if PrevLine.C1=CC1 then begin
                Line1:=PrevLine;
                C1:=PrevLine.C0;
                Line0:=FirstLine;
                C0:=FirstLine.C0;
              end else begin  // if PrevLine.C1=CC0
                Line0:=PrevLine;
                C0:=PrevLine.C0;
                Line1:=FirstLine;
                C1:=FirstLine.C0;
              end;  // if PrevLine.C1...
            end else begin // if PrevLine=nil
              if FirstLine.C1=CC0 then begin
                Line0:=FirstLine;
                C0:=FirstLine.C0;
                AddElement(LineLayerE,
                        SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
                AddElement(LineLayerE,
                        SpatialModel.Lines, '', ltOneToMany, LineU, True);
                C1:=CU as ICoordNode;
                C1.X:=X1;
                C1.Y:=Y1;
                C1.Z:=Z1;
                Line1:=LineU as ILine;
                Line1.C0:=C1;   // c0->c1 направление наружу
                Line1.C1:=CC1;
              end else begin  // if FirstLine.C1=CC1
                Line1:=FirstLine;
                C1:=FirstLine.C0;
                AddElement(LineLayerE,
                        SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
                AddElement(LineLayerE,
                        SpatialModel.Lines, '', ltOneToMany, LineU, True);
                C0:=CU as ICoordNode;
                C0.X:=X0;
                C0.Y:=Y0;
                C0.Z:=Z0;
                Line0:=LineU as ILine;
                Line0.C0:=C0;   // c0->c1 направление наружу
                Line0.C1:=CC0;
              end;
            end; // if PrevLine=nil

            if (FirstLine.C1=CC0) and
               (abs(FirstL-L0)>1) then begin
              AddElement(LineLayerE,
                  SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
              AddElement(LineLayerE,
                  SpatialModel.Lines, '', ltOneToMany, LineU, True);
              aC:=CU as ICoordNode;
              aC.X:=X0;
              aC.Y:=Y0;
              aC.Z:=Z0;
              aLine0:=LineU as ILine;
              if FirstL<L0 then begin
                aLine0.C0:=aC;
                aLine0.C1:=C0;
              end else begin  // if FirstL>L0
                FirstLine.C0:=aC;
                aLine0.C0:=C0;
                aLine0.C1:=aC;
              end;
              C0:=aC;
            end else // if (abs...
              aLine0:=nil;

            if (FirstLine.C1=CC1) and
               (abs(FirstL-L1)>1) then begin
              AddElement(LineLayerE,
                  SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
              AddElement(LineLayerE,
                  SpatialModel.Lines, '', ltOneToMany, LineU, True);
              aC:=CU as ICoordNode;
              aC.X:=X1;
              aC.Y:=Y1;
              aC.Z:=Z1;
              aLine1:=LineU as ILine;
              if FirstL<L1 then begin
                aLine1.C0:=aC;
                aLine1.C1:=C1;
              end else begin // if FirstL>L1
                FirstLine.C0:=aC;
                aLine1.C0:=C1;
                aLine1.C1:=aC;
              end;
              C1:=aC;
            end else  // if (abs...
              aLine1:=nil;

          end;  //if (m=Zone.VAreas.Count-1) and (FirstLine<>nil)

          if PrevLine<>nil then begin
            if (PrevLine.C1=CC0) and
               (abs(PrevL-L0)>1) then begin
              AddElement(LineLayerE,
                  SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
              AddElement(LineLayerE,
                  SpatialModel.Lines, '', ltOneToMany, LineU, True);
              aC:=CU as ICoordNode;
              aC.X:=X0;
              aC.Y:=Y0;
              aC.Z:=Z0;
              aLine0:=LineU as ILine;
              if PrevL<L0 then begin
                aLine0.C0:=aC;
                aLine0.C1:=C0;
              end else begin
                PrevLine.C0:=aC;
                aLine0.C0:=C0;
                aLine0.C1:=aC;
              end;
              C0:=aC;
            end else // if (abs...
              aLine0:=nil;

            if (PrevLine.C1=CC1) and
               (abs(PrevL-L1)>1) then begin
              AddElement(LineLayerE,
                  SpatialModel.CoordNodes, '', ltOneToMany, CU, True);
              AddElement(LineLayerE,
                  SpatialModel.Lines, '', ltOneToMany, LineU, True);
              aC:=CU as ICoordNode;
              aC.X:=X1;
              aC.Y:=Y1;
              aC.Z:=Z1;
              aLine1:=LineU as ILine;
              if PrevL<L1 then begin
                aLine1.C0:=aC;
                aLine1.C1:=C1;
              end else begin // if PrevL>L1
                PrevLine.C0:=aC;
                aLine1.C0:=C1;
                aLine1.C1:=aC;
              end;
              C1:=aC;
            end else  // if (abs...
              aLine1:=nil;
          end; // if PrevL<>-1

          Line.C0:=C0;
          Line.C1:=C1;

          LineE:=Line as IDMElement;
          Line0E:=Line0 as IDMElement;
          Line1E:=Line1 as IDMElement;
          aLine0E:=aLine0 as IDMElement;
          aLine1E:=aLine1 as IDMElement;

          Zone0E:=Boundary.Zone0;
          Zone1E:=Boundary.Zone1;
          if ZoneE=Zone0E then
            theZoneE:=Zone0E
          else
          if ZoneE=Zone1E then
            theZoneE:=Zone1E
         else
          if Zone.Contains(Zone0E) then
            theZoneE:=Zone0E
          else
          if Zone.Contains(Zone1E) then
            theZoneE:=Zone1E
          else begin
            Get_Server.CallDialog(2, '', 'Error in BuildPerimeterZone');
            Exit;
          end;
          theVolumeE:=theZoneE.SpatialElement;
          theVolume:=theVolumeE as IVolume;

          AreaLayerE:=VAreaE.Parent;
          AddElement(AreaLayerE,
                   SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
          BottomAreaE:=AreaU as IDMElement;
          BottomArea:=BottomAreaE as IArea;
          OldAreaE:=nil;
          for k:=0 to VArea.BottomLines.Count-1 do begin
            aLineE:=VArea.BottomLines.Item[k];
            i:=0;
            while i<aLineE.Parents.Count do begin
              aAreaE:=aLineE.Parents.Item[i];
              if aAreaE.QueryInterface(IArea, aArea)=0 then
                if (not aArea.IsVertical) and
                   (aArea.Volume0=theVolume) then begin
                  OldAreaE:=aAreaE;
                  RemoveElementParent(OldAreaE, aLineE);
                end else
                  inc(i)
              else
                inc(i)
            end;
            AddElementParent(BottomAreaE, aLineE);
          end;
          OldArea:=OldAreaE as IArea;

          AddElementParent(BottomAreaE, Line1);
          if aLine1<>nil then
            AddElementParent(BottomAreaE, aLine1);
          AddElementParent(BottomAreaE, Line);
          if aLine0<>nil then
            AddElementParent(BottomAreaE, aLine0);
          AddElementParent(BottomAreaE, Line0);
          if OldAreaE<>nil then begin
            AreaRef:=CreateClone(OldAreaE.Ref) as IDMElement;
            aName:=VAreaE.Name+'_';
            ChangeRef(nil, aName, AreaRef, BottomAreaE);
            BottomArea.Volume0:=OldArea.Volume0;
            BottomArea.Volume1:=OldArea.Volume1;
          end;
          UpdateElement(BottomAreaE);

          if OldAreaE<>nil then begin
            AddElementParent(OldAreaE, LineE);

            if Line0E.Parents.IndexOf(OldAreaE)=-1 then
              AddElementParent(OldAreaE, Line0E)
            else
              RemoveElementParent(OldAreaE, Line0E);

            if Line1E.Parents.IndexOf(OldAreaE)=-1 then
              AddElementParent(OldAreaE, Line1E)
            else
              RemoveElementParent(OldAreaE, Line1E);

            if aLine0E<>nil then begin
              if aLine0E.Parents.IndexOf(OldAreaE)=-1 then
                AddElementParent(OldAreaE, aLine0E)
              else
                RemoveElementParent(OldAreaE, aLine0E);
            end;

            if aLine1E<>nil then begin
              if aLine1E.Parents.IndexOf(OldAreaE)=-1 then
                AddElementParent(OldAreaE, aLine1E)
              else
                RemoveElementParent(OldAreaE, aLine1E);
            end;
            if OldAreaList.IndexOf(pointer(OldAreaE))=-1 then
              OldAreaList.Add(pointer(OldAreaE));
          end; // if aAreaE<>nil

          OldBoundaryList.Add(pointer(BoundaryE));
          NewBottomAreaList.Add(pointer(BottomAreaE));
          NewLineList.Add(pointer(LineE));
        end; // if k<Boundary.BoundaryLayers.Count-1

        PrevLine:=NextLine;
        if PrevLine<>nil then
          PrevL:=PrevLine.Length
        else
          PrevL:=-1;

      end; // for m:=0 to Zone.VAreas.Count-1
    end;  // if SelectedElement.ClassID=_Volume
  end;  // for j:=0 to Get_SelectionCount-1

  for j:=0 to OldAreaList.Count-1 do begin
    OldAreaE:=IDMElement(OldAreaList[j]);
    UpdateElement(OldAreaE);
  end;

  BoundaryTypes:=SafeguardDatabase.BoundaryTypes;
  BoundaryTypeE:=BoundaryTypes.Item[2]; // условные границы
  VirtualBoundaryTypeE:=BoundaryTypeE.SubKinds.Item[0];
  VirtualName:=VirtualBoundaryTypeE.Name;

  for j:=0 to NewBottomAreaList.Count-1 do begin
    BottomAreaE:=IDMElement(NewBottomAreaList[j]);
    AreaCollection2.Clear;
    AreaCollection2.Add(BottomAreaE);
    Height:=theVolume.MaxZ-theVolume.MinZ;
    NewVolumeE:=BuildVolume(AreaCollection, Height, bdUp,
                theVolume, False);
    NewVolume:=NewVolumeE as IVolume;
    VolumeRef:=CreateClone(theVolumeE.Ref) as IDMElement;
    aName:=BottomAreaE.Name+'#';
         ChangeRef(nil, aName, VolumeRef, NewVolumeE);
    if NewVolumeE<>nil then begin
      ProceedVolume(NewVolumeE, VolumeRef, ZoneE,
                    theVolume, False);
      UpdateElement(NewVolumeE);
      OldBoundaryE:=nil;
      for m:=0 to NewVolume.Areas.Count-1 do begin
        aAreaE:=NewVolume.Areas.Item[m];
        aArea:=aAreaE as IArea;
        if aArea.IsVertical then begin
          aBoundaryE:=aAreaE.Ref;
          if OldBoundaryList.IndexOf(pointer(aBoundaryE))<>-1 then
            OldBoundaryE:=aBoundaryE
          else begin
            aLineE:=aArea.BottomLines.Item[0];
            if NewLineList.IndexOf(pointer(aLineE))<>-1 then begin
              aLine:=aLineE as ILine;
              NewArea:=aLine.GetVerticalArea(bdUp);

              aVolume0:=NewArea.Volume0;
              aVolume1:=NewArea.Volume1;

              NewArea.Volume0:=aVolume1; // меняем местами, так как направление
              NewArea.Volume1:=aVolume0; // движения через рубежи сохраняется

              NewBoundaryE:=(NewArea as IDMElement).Ref;
            end else begin
              aName:=VirtualName+' '+IntToStr(aBoundaryE.ID);
              ChangeRef(nil, aName, VirtualBoundaryTypeE, aBoundaryE);
            end;
          end;
        end;
      end;
      OldBoundary:=OldBoundaryE as IBoundary;
      NewBoundary:=NewBoundaryE as IBoundary;

      BoundaryLayerE:=NewBoundary.BoundaryLayers.Item[0];
      DeleteElement(NewBoundaryE, nil, ltOneToMany, BoundaryLayerE);

      k:=0;
      while k<OldBoundary.BoundaryLayers.Count-1 do begin // Count-1, так как самый внутренний слой отделять не имеет смысла
        BoundaryLayerE:=OldBoundary.BoundaryLayers.Item[k];
        BoundaryLayerType:=BoundaryLayerE.Ref as IBoundaryLayerType;
        if BoundaryLayerType.IsZone then
          Break
        else
          inc(k);
      end;
      while OldBoundary.BoundaryLayers.Count>k+1 do begin
        BoundaryLayerE:=OldBoundary.BoundaryLayers.Item[k+1];
        ChangeParent(nil, NewBoundaryE, BoundaryLayerE);
      end;
      BoundaryLayerE:=NewBoundary.BoundaryLayers.Item[0];
      ChangeFieldValue(BoundaryLayerE, blpDistanceFromPrev, True, 0);
    end;
  end;

  for j:=0 to OldBoundaryList.Count-1 do begin
    aBoundaryE:=IDMElement(OldBoundaryList[j]);
    aAreaE:=aBoundaryE.SpatialElement;
    aArea:=aAreaE as IArea;

    aVolume0:=aArea.Volume0;
    aVolume1:=aArea.Volume1;

    if (aVolume0<>nil) and (aVolume1<>nil) then begin
      aArea.Volume0:=aVolume1; // ???
      aArea.Volume1:=aVolume0; // ???
    end;

    UpdateCoords(aBoundaryE);
  end;

  Get_Server.RefreshDocument(rfFrontBack);

  finally
    OldAreaList.Free;
    OldBoundaryList.Free;
    NewBottomAreaList.Free;
    NewLineList.Free;
  end;
end;


procedure TFMDocument.ChangeRefRef(const Collection: IDMCollection;
  const aName: WideString; const aRef, aElement: IDMElement);
var
  Boundary:IBoundary;
  BoundaryLayerE, BoundaryLayerTypeE, LayerE:IDMElement;
  GlobalData:IGlobalData;
  j:integer;
begin
  inherited;

  Boundary:=aElement as IBoundary;
  BoundaryLayerE:=Boundary.BoundaryLayers.Item[0];

  GlobalData:=Get_DataModel as IGlobalData;
  BoundaryLayerTypeE:=GlobalData.GlobalIntf[1] as IDMElement;

  if BoundaryLayerTypeE<>BoundaryLayerE.Ref then begin
    ChangeRef(nil, '', BoundaryLayerTypeE, BoundaryLayerE);

    j:=round(GlobalData.GlobalValue[1]);
    ChangeFieldValue(Boundary, ord(bopFlowIntencity), True, j);
  end;

  LayerE:=GlobalData.GlobalIntf[2] as IDMElement;
  if LayerE<>nil then
    aElement.SpatialElement.Parent:=LayerE;
end;

function TFMDocument.CreateRefElement(var ClassID: integer;
  OperationCode: Integer; const Collection: IDMCollection; out RefElement,
  RefParent: IDMElement; SetParentFlag:WordBool): WordBool;
begin
  Result:=inherited CreateRefElement(ClassID,
        OperationCode, Collection, RefElement, RefParent, SetParentFlag);
  if Result then
    OnCreateRefElement(ClassID, RefElement)
end;

procedure TFMDocument.OnCreateRefElement(ClassID: integer;
  const  RefElementU: IUnknown);
var
  RefElement, LayerE: IDMElement;
  Boundary:IBoundary;
  Zone:IZone;
  BoundaryLayerE, BoundaryLayerTypeE:IDMElement;
  GlobalData:IGlobalData;
  K:integer;
  D:double;
begin
  inherited;
  RefElement:=RefElementU as IDMElement;

  GlobalData:=Get_DataModel as IGlobalData;
  if (ClassID=_Area) and
     (RefElement.QueryInterface(IBoundary, Boundary)=0) then begin

    BoundaryLayerE:=Boundary.BoundaryLayers.Item[0];

    BoundaryLayerTypeE:=GlobalData.GlobalIntf[1] as IDMElement;

    if (BoundaryLayerTypeE<>nil) and
       (BoundaryLayerTypeE<>BoundaryLayerE.Ref) then
      ChangeRef(nil, '', BoundaryLayerTypeE, BoundaryLayerE);

    K:=round(GlobalData.GlobalValue[1]);
    if K>=0 then
      ChangeFieldValue(Boundary, ord(bopFlowIntencity), True, K);

    LayerE:=GlobalData.GlobalIntf[2] as IDMElement;
    if (LayerE<>nil) and
       (RefElement.SpatialElement<>nil) then
      RefElement.SpatialElement.Parent:=LayerE;
  end else
  if (ClassID=_Volume) and
     (RefElement.QueryInterface(IZone, Zone)=0) then begin

    K:=round(GlobalData.GlobalValue[1]);
    if K>=0 then
      ChangeFieldValue(Zone, ord(zpZoneCategory), True, K);

    K:=round(GlobalData.GlobalValue[2]);
    if K>=0 then
      ChangeFieldValue(Zone, ord(zpPersonalPresence), True, K);

    K:=round(GlobalData.GlobalValue[3]);
    if K>=0 then
      ChangeFieldValue(Zone, ord(zpPersonalCount), True, K);

    D:=round(GlobalData.GlobalValue[4]);
    if D>=0 then
      ChangeFieldValue(Zone, ord(zpTransparencyDist), True, D);

    D:=round(GlobalData.GlobalValue[5]);
    if D>=0 then
      ChangeFieldValue(Zone, ord(zpPedestrialVelocity), True, D);

    K:=round(GlobalData.GlobalValue[6]);
    if K>=0 then
      ChangeFieldValue(Zone, ord(zpUserDefinedVehicleVelocity), True, K);

    D:=round(GlobalData.GlobalValue[7]);
    if D>=0 then
      ChangeFieldValue(Zone, ord(zpVehicleVelocity), True, D);
  end else
  if (ClassID=_Line) and
     (RefElement.QueryInterface(IBoundary, Boundary)=0) then begin

    BoundaryLayerE:=Boundary.BoundaryLayers.Item[0];

    BoundaryLayerTypeE:=GlobalData.GlobalIntf[1] as IDMElement;

    if (BoundaryLayerTypeE<>nil) and
       (BoundaryLayerTypeE=BoundaryLayerE.Ref) then
      Exit;
    ChangeRef(nil, '', BoundaryLayerTypeE, BoundaryLayerE);
  end;
end;

function TFMDocument.GetSubElement: IDMElement;
begin
  Result:=IDMElement(FSubElement)
end;

function TFMDocument.Get_NearestLine: IDMElement;
var
  Tag, j:integer;
  aDistance, aDistance1, MinDistance:double;
  Line:ILine;
  Area:IArea;
  Boundary:IBoundary;
  BoundaryLayerE:IDMElement;
  BoundaryLayer:IBoundaryLayer;
  P0X, P0Y, P1X, P1Y, WX, WY, WX0, WY0:double;
  Painter:IPainter;
  View:IView;
begin
  FSubElement:=nil;

  if (FShiftState and sCtrl)<>0 then begin
    Result:=inherited Get_NearestLine;
    Exit;
  end;

  if Get_HWindowFocused then
    Tag:=1
  else
  if Get_VWindowFocused then
    Tag:=2
  else begin
    Result:=nil;
    Exit;
  end;

  aDistance:=InfinitValue;
  Result:=GetNearestLine(FCurrX, FCurrY, FCurrZ, Tag, nil, False,
                         aDistance) as IDMElement;
  if Result=nil then Exit;

  Painter:=Get_PainterU as IPainter;
  View:=Painter.ViewU as IView;

  MinDistance:=Get_SnapDistance*View.RevScaleX;

  Line:=Result as ILine;
  Area:=Line.GetVerticalArea(bdUp);
  if Area=nil then begin
    if aDistance>MinDistance then
      Result:=nil;
  end else begin
    Boundary:=(Area as IDMElement).Ref as IBoundary;
    if Boundary=nil then Exit;

    if aDistance<=MinDistance then begin
      if Boundary.BoundaryLayers.Count>1 then begin
        BoundaryLayerE:=Boundary.BoundaryLayers.Item[1];
        BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
        P0X:=BoundaryLayer.X0;
        P0Y:=BoundaryLayer.Y0;
        P1X:=BoundaryLayer.X1;
        P1Y:=BoundaryLayer.Y1;
        PerpendicularFrom0(P0X, P0Y, P1X, P1Y, FCurrX, FCurrY, WX, WY);
        aDistance1:=sqrt(sqr(WX-FCurrX)+sqr(WY-FCurrY));
        if aDistance1>MinDistance then
          FSubElement:=pointer(Boundary.BoundaryLayers.Item[0]);
      end;
      Exit;
    end else
    if Boundary.BoundaryLayers.Count<2 then begin
      Result:=nil;
      Exit;
    end;

    WX0:=FOrtBaseX;
    WY0:=FOrtBaseY;

    j:=1;
    while j<Boundary.BoundaryLayers.Count do begin
      BoundaryLayerE:=Boundary.BoundaryLayers.Item[j];
      BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
      P0X:=BoundaryLayer.X0;
      P0Y:=BoundaryLayer.Y0;
      P1X:=BoundaryLayer.X1;
      P1Y:=BoundaryLayer.Y1;
      PerpendicularFrom0(P0X, P0Y, P1X, P1Y, FCurrX, FCurrY, WX, WY);
      aDistance1:=sqrt(sqr(WX-FCurrX)+sqr(WY-FCurrY));
      if aDistance1<MinDistance then begin
        FSubElement:=pointer(Boundary.BoundaryLayers.Item[j]);
        Break;
      end else
        inc(j);
    end;
    if j=Boundary.BoundaryLayers.Count then begin
      if ((FCurrX-WX0)*(FCurrX-WX)+(FCurrY-WY0)*(FCurrY-WY))>0 then
        Result:=nil;
    end;
  end;
end;

procedure TFMDocument.AddElementRef(const ParentElementU,
  CollectionU: IInterface; const aName: WideString;
  const aRefU: IInterface; aLinkType: Integer; out aElementU: IInterface; SetParentFlag:WordBool);
var
  GlobalData:IGlobalData;
  aElementE:IDMElement;
  D:double;
  K:integer;
begin
  inherited;
  GlobalData:=Get_DataModel as IGlobalData;
  aElementE:=aElementU as IDMElement;
  case aElementE.ClassID of
  _BoundaryLayer:
    begin
      D:=GlobalData.GlobalValue[1];
      ChangeFieldValue(aElementE, ord(blpDistanceFromPrev), True, D);

      D:=GlobalData.GlobalValue[2];
      ChangeFieldValue(aElementE, ord(blpHeight0), True, D);

      K:=round(GlobalData.GlobalValue[3]);
      ChangeFieldValue(aElementE, ord(blpDrawJoint0), True, K);
      ChangeFieldValue(aElementE, ord(blpDrawJoint1), True, K);
    end;
  end;
end;

procedure TFMDocument.StartOperation(aOperationCode: Integer);
var
  PrevOperation:TObject;
begin
  case aOperationCode of
  smoBuildSectors:
    begin
      PrevOperation:=FCurrentOperation;
      FCurrentOperation:=TBuildSectorsOperation.Create(aOperationCode, Self);
      PrevOperation.Free;
      FLastOperation:=FCurrentOperation;
      FLastViewMode:=0;
      Get_Server.OperationStepExecuted;   //сообщение серверу о начале операции
    end;
  else
    inherited
  end;
end;

function TFMDocument.AreaIsObsolet(const AreaE: IDMElement): WordBool;
var
  BoundaryKind2:IBoundaryKind2;
begin
  BoundaryKind2:=AreaE.Ref.Ref as IBoundaryKind2;
  Result:=BoundaryKind2.LayerKind=lkHidden
end;

procedure TFMDocument.AfterRefElementCreation(const aElement: IDMElement);
var
  Jump:IJump;
begin
  inherited;
  if aElement=nil then Exit;
  if aElement.QueryInterface(IJump, Jump)=0 then
    Jump.SetZones;
end;

function TFMDocument.Get_NearestNode: IDMElement;
var
  Tag:integer;
  aDistance, MinDistance:double;
  FacilityModel:IFacilityModel;
  Element:IDMElement;

  procedure GetNearestElement(const Collection:IDMCollection);
  var
    j:integer;
    WX, WY, WZ:double;
    ElementSE:ISafeguardElement;
  begin
    try
    for j:=0 to Collection.Count-1 do begin
      Element:=Collection.Item[j];
      ElementSE:=Element as ISafeguardElement;
      if (Element.SpatialElement=nil) and
          ElementSE.ShowSymbol then begin
        ElementSE.GetCoord(WX, WY, WZ);
        aDistance:=sqrt(sqr(WX-FCurrX)+sqr(WY-FCurrY));
        if aDistance<MinDistance then begin
          MinDistance:=aDistance;
          FSubElement:=pointer(Element);
        end;
      end;
    end;
    except
      raise
    end;
  end;
var
  Painter:IPainter;
  View:IView;
begin
  FSubElement:=nil;

  if Get_HWindowFocused then
    Tag:=1
  else
  if Get_VWindowFocused then
    Tag:=2
  else begin
    Result:=nil;
    Exit;
  end;

  aDistance:=0;
  Result:=GetNearestNode(FCurrX, FCurrY, FCurrZ, Tag, nil, False,
                         aDistance) as IDMElement;

  Painter:=Get_PainterU as IPainter;
  View:=Painter.ViewU as IView;
  MinDistance:=Get_SnapDistance*View.RevScaleX;

  if aDistance<MinDistance then Exit;

  FacilityModel:=Get_DataModel as IFacilityModel;

  aDistance:=InfinitValue;
  GetNearestElement(FacilityModel.VolumeSensors);
  GetNearestElement(FacilityModel.TVCameras);
end;

{ TFMDocumentFactory }

function TFMDocumentFactory.CreateInstance: IUnknown;
begin
  Result:=TFMDocument.Create(nil) as IUnknown;
end;

function GetDMDocumentClassObject:IDMClassFactory;
begin
  Result:=TFMDocumentFactory.Create(nil) as IDMClassFactory;
end;

initialization
//  CreateAutoObjectFactory(TFMDocument, Class_FMDocument);
finalization
end.
