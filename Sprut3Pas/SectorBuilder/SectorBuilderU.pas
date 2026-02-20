unit SectorBuilderU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj,
  Classes, Dialogs, SectorBuilderLib_TLB, StdVcl, SysUtils, math,
  DMServer_TLB, FacilityModelLib_TLB, DataModel_TLB, SpatialModelLib_TLB,
  SgdbLib_TLB;

type
  TSectorBuilder = class(TDM_AutoObject, ISectorBuilder)
  private
    FFacilityModel:IFacilityModel;

    FZoneCount     :integer;     //кол.зон в элементе объекта
    StepFlag:integer;
    MaxNodeCount:integer;

    FDoubleList:TList;
    FPlusList:TList;

    procedure BuildSectors; safecall;
    procedure DoBuildSectors(const ZoneCollection:IDMCollection);

    function AreaDivided(const ExternalArea:IArea;
                         const DMDocument:IDMDocument;
                         var aLineNew:ILine):boolean;
    function ConnectInnerZones(const ZoneE:IDMElement;
                               const OuterVAreas:IDMCollection;
                                const NewAreaList:TList;
                                const aDMDocument:IDMDocument):boolean;

    function MakeBorders(const VAreas:IDMCollection;const Zmin:double;
                    const NodesList, Borders, ExternalBorders:TList):integer;
    procedure PointsIndexs(IndBegin, Number: integer;
                           const NodesList, Borders:TList;
                           var Stat: integer);
    function ConvexChecking(const NodesList, ExternalBorders:TList; var n:integer):boolean;
    procedure Checking(var ExternalArea:IArea;
                const NewAreaList, NodesList, Borders, ExternalBorders:TList);
    procedure InNodesList(var ControlNode:ICoordNode;
                            Line:ILine; const NodesList, Borders:TList);
    function Sort_Node(Line:ILine;var ControlNode:ICoordNode):boolean;
    function ConvertCoord(aNode1,aNode2,aNode3:ICoordNode;
                               const NodesList:TList;
                               var Xi,Yi:double; var Angle180:boolean):double;
    function ControlPositionA(x0,y0,x1,y1:Real;
                          const ExternalBorders:TList):boolean;
    function GetLoopDirectionFlag
            (const CA, CB, CIn0, COut0, CIn1, COut1: ICoordNode): boolean;
    procedure Indexs(Index: integer; const NodesList:TList; var iOut, iIn: integer);
    procedure SetJoining(StepFlag,Number,Index,ItemIndex:integer;
          const NodesList, Borders, ExternalBorders:TList;DivAngle:Double;
          var L1min:Double; var i1,i2,Stat:integer);
    function Crossing_Node(Node1X,Node1Y,Node2X,Node2Y,Node3X,Node3Y,Node4X,Node4Y:Double):boolean;
    function CrossingLine(Node1,Node2,Node3,Node4:ICoordNode):boolean;
    function BuildLine(const DMDocument:IDMDocument;
              StepFlag, Number: integer; const NodesList, Borders, ExternalBorders:TList;
               var k0, k1: integer; var LineNew: ILine;ExternalArea:IArea): boolean;
    function Get_FacilityModel: IUnknown; safecall;
    procedure Set_FacilityModel(const Value: IUnknown); safecall;
    procedure ReorderLines(const Lines: TList);
//    procedure ReorderLinesM(const Lines: TList);
    function Tetta(Point1, Point2, Point3, Point4: ICoordNode): extended;
    procedure DoubleLineDelete1;
  public
    destructor Destroy; override;
  end;

implementation

type
  PCoordRec=^TCoordRec;
  TCoordRec=record
   FNumber:integer;
   FConvex:boolean;
   FNode:TList;
   FBorder:TList;
   ControlNode:integer;
  end;

function TSectorBuilder.ConnectInnerZones(const ZoneE: IDMElement;
                                          const OuterVAreas:IDMCollection;
                                           const NewAreaList:TList;
                                           const aDMDocument:IDMDocument):boolean;
var
  j, j1, j2, i, m, k, aIndBegin, Stat, mm, mt:integer;
  aZoneNumber:integer;
  aCount, MaxCount:integer;
  unConvexCount:integer;

  aExternalArea:IArea;
  Zone, aZone, theZone:IZone;

  Borders         :TList;
  ExternalBorders :TList;
  NodesList       :TList;
  ZoneList, GroupZoneList, SubOutlineList:TList;
  aNode:ICoordNode;
  aArea, theArea:IArea;
  aZoneE, theZoneE, aAreaE, theAreaE:IDMElement;
  theVolume, Volume, aVolume:IVolume;
  BottomAreaCount:integer;
  GroupZoneE:IDMElement;
  GroupZoneU:IUnknown;
  GroupZone:IZone;
  DMOperationManager:IDMOperationManager;
  OldState:integer;
  Zmin,Zi:double;
  Outline, aOutline, InnerVAreas:IDMCollection;
  Outline2, aOutline2, InnerVAreas2:IDMCollection2;
  OutlineList, aAreaList, theAreaList:TList;
  GroupFlag, DeleteFlag:boolean;
  BLine:ILine;
  DownArea:IArea;
  C0, C1:ICoordNode;
  DataModel:IDataModel;
begin
  Result:=False;

  if OuterVAreas.Count=0 then Exit;

  Borders:=TList.Create;
  ExternalBorders:=TList.Create;
  NodesList:=TList.Create;
  GroupZoneList:=TList.Create;
  ZoneList:=TList.Create;
  OutlineList:=TList.Create;
  SubOutlineList:=TList.Create;

  aZoneNumber:=0;
  aIndBegin:=0;
  StepFlag:=0;
  MaxNodeCount:=100;

  Zone:=ZoneE as IZone;
  theVolume:=ZoneE.SpatialElement as IVolume;
  DataModel:=FFacilityMOdel as IDataModel;

  DMOperationManager:=aDMDocument as IDMOperationManager;

  try

  Zmin:=9.99e+99;          (* Zmin-нижняя граница внешней зоны  *)
  for j:=0 to OuterVAreas.Count-1 do begin
   aArea:=OuterVAreas.Item[j] as IArea;
   for k:=0 to aArea.BottomLines.Count-1 do begin  { Zmin-нижн.граница внеш.зоны }
    Zi:=((aArea.BottomLines.Item[k])as ILine).C0.Z;
    Zmin:=min(Zmin,Zi);
   end;
  end;

  for j:=0 to Zone.Zones.Count-1 do begin
    aZoneE:=Zone.Zones.Item[j];
    aZone:=aZoneE as IZone;
    Outline:=DataModel.CreateCollection(-1, nil);
    Outline2:=Outline as IDMCollection2;
    OutlineList.Add(pointer(Outline));
    Outline._AddRef;
    for m:=0 to aZone.VAreas.Count-1 do begin
      aAreaE:=aZone.VAreas.Item[m];
      Outline2.Add(aAreaE)
    end;
  end; //for j:=0 to Zone.Zones.Count-1

  GroupFlag:=True;
  while GroupFlag do begin
    GroupFlag:=False;
    j:=0;
    while j<OutlineList.Count do begin
      Outline:=IDMCollection(OutlineList[j]);
      Outline2:=Outline as IDMCollection2;
      j1:=j+1;
      while j1<OutlineList.Count do begin
        aOutline:=IDMCollection(OutlineList[j1]);
        aOutline2:=aOutline as IDMCollection2;
        m:=0;
        while m<aOutline.Count do begin   // поиск общих границ
          aAreaE:=aOutline.Item[m];
          if Outline.IndexOf(aAreaE)<>-1 then
            Break
          else
            inc(m);
        end;  //while m<aOutline.Count
        if m<aOutline.Count then begin// смежные контуры
          for j2:=0 to aOutline.Count-1 do begin
            aAreaE:=aOutline.Item[j2];
            i:=Outline.IndexOf(aAreaE);
            if i<>-1 then           //объединение смежных контуров
              Outline2.Delete(i)
            else
              Outline2.Add(aAreaE);
          end;
          aOutline2.Clear;
          aOutline._Release;

          GroupFlag:=True;

          OutlineList.Delete(j1);
        end else                    // не смежные контуры
          inc(j1)
      end; //while j1<OutlineList.Count
      inc(j);
    end; //while j<OutlineList.Count
  end; //while GroupFlag

  j:=0;
  while j<OutlineList.Count do begin  // поиск контуров, смежных с внешним контуром
    Outline:=IDMCollection(OutlineList[j]);
    Outline2:=Outline as IDMCollection2;
    m:=0;
    while m<Outline.Count do begin  // поиск границ, общих с внешним контуром
      aAreaE:=Outline.Item[m];
      aArea:=aAreaE as IArea;
      if (OuterVAreas.IndexOf(aAreaE)<>-1) then
        Break
      else
        inc(m);
    end;
    if m<Outline.Count then begin //смежный с внешним контуром
      Outline2.Clear;             // исключение контура, смежного с внешним контуром
      Outline._Release;
      OutlineList.Delete(j);
    end else                          //не смежный с внешним контуром
      inc(j)
  end;  //while j<OutlineList.Count

  j:=0;
  while j<OutlineList.Count do begin  // удаление плоскостей, не опирающихся на базовую плоскость
    Outline:=IDMCollection(OutlineList[j]);
    Outline2:=Outline as IDMCollection2;
    m:=0;
    while m<Outline.Count do begin
      aAreaE:=Outline.Item[m];
      aArea:=aAreaE as IArea;
      DeleteFlag:=True;
      if ((aArea.Volume0=theVolume) or
          (aArea.Volume1=theVolume)) and
         (aArea.BottomLines.Count>0) then begin
        BLine:=aArea.BottomLines.Item[0] as ILine;
        DownArea:=BLine.GetVerticalArea(bdDown);
        if (DownArea=nil) or
           ((DownArea.Volume0<>theVolume) and
            (DownArea.Volume1<>theVolume)) then
          DeleteFlag:=False;
      end;
      if DeleteFlag then
        Outline2.Delete(m)
      else
        inc(m)
    end;
    if Outline.Count=0 then begin
      Outline2.Clear;
      Outline._Release;
      OutlineList.Delete(j);
    end else
      inc(j)
  end;  //while j<OutlineList.Count

  aCount:=MakeBorders(OuterVAreas, Zmin, NodesList, Borders, ExternalBorders);

  PointsIndexs(aIndBegin,aZoneNumber, NodesList, Borders,  Stat);
  aIndBegin:=aIndBegin + aCount;
  inc(aZoneNumber);

  try
  for j:=0 to OutlineList.Count-1 do begin
    Outline:=IDMCollection(OutlineList[j]);
    Outline2:=Outline as IDMCollection2;
    SubOutlineList.Clear;
    for j1:=0 to Outline.Count-1 do begin
      theAreaE:=Outline.Item[j1];
      theArea:=theAreaE as IArea;
      C0:=theArea.C0;
      C1:=theArea.C1;
      m:=0;
      mm:=-1;
      while m<SubOutlineList.Count do begin
        aAreaList:=SubOutlineList[m];
        aArea:=IArea(aAreaList[0]);
        if (aArea.C0=C0) or
           (aArea.C1=C0) or
           (aArea.C0=C1) or
           (aArea.C1=C1) then begin
          if mm<>-1 then begin
            theAreaList:=SubOutlineList[mm];
            for j2:=0 to aAreaList.Count-1 do begin
              aArea:=IArea(aAreaList[j2]);
              if mt=1 then
                theAreaList.Add(pointer(aArea))
              else
                theAreaList.Insert(0, pointer(aArea))
            end;
            SubOutlineList.Delete(m);
            aAreaList.Free;
          end else begin
            mm:=m;
            mt:=0;
            aAreaList.Insert(0, pointer(theArea));
            inc(m)
          end;
        end else begin
          aArea:=IArea(aAreaList[aAreaList.Count-1]);
          if (aArea.C0=C0) or
             (aArea.C1=C0) or
             (aArea.C0=C1) or
             (aArea.C1=C1) then begin
            if mm<>-1 then begin
              theAreaList:=SubOutlineList[mm];
              for j2:=aAreaList.Count-1 downto 0 do begin
                aArea:=IArea(aAreaList[j2]);
                if mt=1 then
                  theAreaList.Add(pointer(aArea))
                else
                  theAreaList.Insert(0, pointer(aArea))
            end;
              SubOutlineList.Delete((m));
              aAreaList.Free;
            end else begin
              mm:=m;
              mt:=1;
              aAreaList.Add(pointer(theArea));
              inc(m);
            end;
          end else  // if (aArea.C0=C0) or
            inc(m);
        end;  // if (aArea.C0=C0) or
      end; // while m<SubOutlineList.Count
      if (mm=-1) then begin
        aAreaList:=TList.Create;
        aAreaList.Add(pointer(theArea));
        SubOutlineList.Add(aAreaList);
      end;
    end; // for j1:=0 to Outline.Count-1

    MaxCount:=0;
    theAreaList:=nil;
    for m:=0 to SubOutlineList.Count-1 do begin
      aAreaList:=SubOutlineList[m];
      if MaxCount<aAreaList.Count then begin
        MaxCount:=aAreaList.Count;
        theAreaList:=aAreaList;
      end;
    end;
    Outline2.Clear;
    for m:=0 to theAreaList.Count-1 do begin
      aArea:=IArea(theAreaList[m]);
      Outline2.Add(aArea as IDMElement);
    end;

    aCount:=MakeBorders(Outline, Zmin, NodesList,
                        Borders, ExternalBorders);
    PointsIndexs(aIndBegin,aZoneNumber, NodesList, Borders, Stat);
    aIndBegin:=aIndBegin + aCount;
    inc(aZoneNumber);
  end; // for j:=0 to OutlineList.Count-1
  FZoneCount:=aZoneNumber;            //всего контуров
  except
    DataModel.HandleError
      ('Error in ConnectInnerZones');
  end;

  if (FZoneCount>1) then begin
    ConvexChecking(NodesList, ExternalBorders, unConvexCount); // контроль выпуклости
    if unConvexCount>0  then
    begin
      Volume:=ZoneE.SpatialElement as IVolume;
      BottomAreaCount:=0;
      if Volume.BottomAreas.Count=1 then begin
        Result:=True;
        for j:=0 to Volume.BottomAreas.Count-1 do begin
          aExternalArea:=Volume.BottomAreas.Item[j] as IArea;
          Checking(aExternalArea, NewAreaList, NodesList, Borders, ExternalBorders);      // контроль  пересечения
        end;
      end;
    end;
  end;
  try
  for j:=0 to NodesList.Count-1 do begin
    aNode:=ICoordNode(NodesList[j]);
    FreeMem(pointer(aNode.Tag), SizeOf(TCoordRec));
    aNode.Tag:=0;
  end;
  except
    DataModel.HandleError
      ('Error in ConnectInnerZones');
  end;
  finally
    ExternalBorders.Free;
    Borders.Free;
    NodesList.Free;
    GroupZoneList.Free;
    ZoneList.Free;

    for j:=0 to SubOutlineList.Count-1 do begin
      aAreaList:=SubOutlineList[j];
      aAreaList.Free;
    end;
    SubOutlineList.Free;

    for j:=0 to OutlineList.Count-1 do begin
      Outline:=IDMCollection(OutlineList[j]);
      Outline._Release;
    end;
    OutlineList.Free;
  end;
end;

function TSectorBuilder.Get_FacilityModel: IUnknown;
begin
  Result:=FFacilityModel as IUnknown;
end;

procedure TSectorBuilder.Set_FacilityModel(const Value: IUnknown);
begin
  FFacilityModel:=Value as IFacilityModel;
end;
//----------------------------------------------------------
procedure TSectorBuilder.BuildSectors;
var
  DataModel:IDataModel;
  DMDocument:IDMDocument;
  ZoneCollection:IDMCollection;
  ZoneCollection2:IDMCollection2;
  Element:IDMElement;
begin
  DataModel:=FFacilityModel as IDataModel;
  DMDocument:=DataModel.Document as IDMDocument;
  if DMDocument.SelectionCount=0 then
    Exit
  else begin
    Element:=DMDocument.SelectionItem[0] as IDMElement;
    if Element.ClassID=_Volume then begin
      ZoneCollection:=DataModel.CreateCollection(-1, nil);
      ZoneCollection2:=ZoneCollection as IDMCollection2;
      while DMDocument.SelectionCount>0 do begin
        Element:=DMDocument.SelectionItem[0] as IDMElement;
        ZoneCollection2.Add(Element.Ref);
        Element.Selected:=False
      end;
    end else
      Exit
  end;

  DoBuildSectors(ZoneCollection)
end;


procedure TSectorBuilder.DoBuildSectors(const ZoneCollection:IDMCollection);
var
  VolumeBuilder:IVolumeBuilder;
  DMOperationManager:IDMOperationManager;
  j, m, i, OldAreaCount, ZoneCollectionCount:integer;
  ZoneE:IDMElement;
  Area, aArea:IArea;
  AreaE:IDMElement;
  AreaP:IPolyline;
  DividedFlag:boolean;
  AreaList:TList;
  DMDocument:IDMDocument;
  aLine:ILine;
  SafeguardDatabase:ISafeguardDatabase;
  BoundaryTypeE, VirtualBoundaryKindE:IDMElement;
  Volume, aVolume, GlobalVolume:IVolume;
  aVolumeE, ZoneKindE, aZoneE, aAreaE, aBoundaryE,
  TopBoundaryE, aCommonZoneE, GlobalVolumeE:IDMElement;
  aVolumeHeight:double;
  ZoneU, aZoneU, aCommonZoneU, aBoundaryU:IUnknown;
  aCommonZone:IZone;
  Zone:IZone;
  S, S1:string;
  DataModel:IDataModel;
  SpatialModel2:ISpatialModel2;
  OuterVAreas:IDMCollection;
  OuterVAreas2:IDMCollection2;
  BaseAreas:IDMCollection;
  BaseAreas2:IDMCollection2;
  AddFlag:WordBool;
  BLine:ILine;
  DownArea:IArea;
begin
  DataModel:=FFacilityModel as IDataModel;
  SpatialModel2:=FFacilityModel as ISpatialModel2;
  DMDocument:=DataModel.Document as IDMDocument;
  VolumeBuilder:=DMDocument as IVolumeBuilder;
  DMOperationManager:=DMDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, 'Разбиение зон на секторы');

  GlobalVolumeE:=FFacilityModel.Enviroments.SpatialElement;
  GlobalVolume:=GlobalVolumeE as IVolume;
  SafeguardDatabase:=FFacilityModel.SafeguardDatabase as ISafeguardDatabase;
  BoundaryTypeE:=SafeguardDatabase.BoundaryTypes.Item[2];
  VirtualBoundaryKindE:=BoundaryTypeE.Collection[0].Item[0];

  AreaList:=TList.Create;
  FDoubleList:=TList.Create;
  FPlusList:=TList.Create;

  StepFlag:=0;

  for j:=0 to ZoneCollection.Count-1 do begin
    ZoneE:=ZoneCollection.Item[j];
    Zone:=ZoneE as IZone;
    AddFlag:=False;
    Zone.MakeHVAreas(nil, nil, AddFlag);
  end;

  OuterVAreas:=DataModel.CreateCollection(-1, nil);
  OuterVAreas2:=OuterVAreas as IDMCollection2;
  BaseAreas:=DataModel.CreateCollection(-1, nil);
  BaseAreas2:=BaseAreas as IDMCollection2;

  ZoneCollectionCount:=ZoneCollection.Count;
  for j:=0 to ZoneCollectionCount-1 do begin
    ZoneE:=ZoneCollection.Item[j];
    Zone:=ZoneE as IZone;
    ZoneU:=ZoneE as IUnknown;
    ZoneKindE:=ZoneE.Ref;
    Volume:=ZoneE.SpatialElement as IVolume;

    aVolumeHeight:=Volume.MaxZ-Volume.MinZ;

    if Volume.TopAreas.Count>0 then
      TopBoundaryE:=Volume.TopAreas.Item[0].Ref
    else
      TopBoundaryE:=nil;

    AreaList.Clear;
    FDoubleList.Clear;
    FPlusList.Clear;
    OuterVAreas2.Clear;

    for m:=0 to Volume.Areas.Count-1 do begin
      Area:=Volume.Areas.Item[m] as IArea;
      if Area.IsVertical then begin
        if Area.BottomLines.Count>0 then begin
          BLine:=Area.BottomLines.Item[0] as ILine;
          DownArea:=BLine.GetVerticalArea(bdDown);
          if DownArea=nil then
            OuterVAreas2.Add(Area as IDMElement)
          else
          if (DownArea.Volume0<>Volume) and
             (DownArea.Volume1<>Volume) then
            OuterVAreas2.Add(Area as IDMElement)
        end
      end else
      if Area.Volume0=Volume then
        AreaList.Add(pointer(Area));
    end;
    OldAreaCount:=AreaList.Count;

    if AreaList.Count>0 then begin
     if ConnectInnerZones(ZoneE, OuterVAreas, AreaList, DMDocument) then begin
      DMOperationManager.AddElement( nil,
                          FFacilityModel.Zones, '', ltOneToMany, aCommonZoneU, True);
      DMOperationManager.ChangeRef( nil, '#'+ZoneE.Name,
                        ZoneKindE as IUnknown, aCommonZoneU);
     end else
      aCommonZoneU:=ZoneU;
     aCommonZoneE:=aCommonZoneU as IDMElement;
     aCommonZone:=aCommonZoneE as IZone;
     if ZoneE<>aCommonZoneE then begin
       DMOperationManager.ChangeParent( nil,
                      ZoneE as IUnknown, aCommonZoneU);
     end;

     m:=0;
     while m<AreaList.Count do
     begin
      Area:=IArea(AreaList[m]);
      DividedFlag:=True;
      while DividedFlag do begin
        DividedFlag:=AreaDivided(Area, DMDocument, aLine);
        if DividedFlag then begin
          aArea:=(aLine as IDMElement).Parents.Item[0] as IArea;
          if AreaList.IndexOf(pointer(aArea))=-1 then
            AreaList.Add(pointer(aArea));
          aArea:=(aLine as IDMElement).Parents.Item[1] as IArea;
          if AreaList.IndexOf(pointer(aArea))=-1 then
            AreaList.Add(pointer(aArea));
        end;
      end;
      inc(m);
     end;

     DoubleLineDelete1;

     if OldAreaCount<AreaList.Count then begin

       m:=0;
       while m<Volume.Areas.Count do begin
         Area:=Volume.Areas.Item[m] as IArea;
         if Area.IsVertical then begin
           if Area.Volume0=Volume then
             Area.Volume0:=nil
           else
           if Area.Volume1=Volume then
             Area.Volume1:=nil
         end else
          inc(m)
       end;


       try
       for m:=0 to AreaList.Count-1 do begin
         S:=Format('%s /%d',[ZoneE.Name, m]);
         AreaE:=IArea(AreaList[m]) as IDMElement;
         BaseAreas2.Clear;
         BaseAreas2.Add(AreaE);
         aVolumeE:=VolumeBuilder.BuildVolume(BaseAreas, aVolumeHeight, bdUp, nil, False);

         aZoneU:=DMOperationManager.CreateClone(ZoneE);
         aZoneE:=aZoneU as IDMElement;
         aZoneE.Name:=S;
         aVolumeE.Ref:=aZoneE;

         aVolume:=aVolumeE as IVolume;
         for i:=0 to aVolume.Areas.Count-1 do begin
           aAreaE:=aVolume.Areas.Item[i];
           if aAreaE.Ref=nil then begin
             aArea:=aAreaE as IArea;
             DMOperationManager.AddElement( nil,
                            FFacilityModel.Boundaries, '', ltOneToMany, aBoundaryU, True);
             if aArea.IsVertical then
               DMOperationManager.ChangeRef( nil,
                              VirtualBoundaryKindE.Name,
                              VirtualBoundaryKindE as IUnknown, aBoundaryU)
             else begin
               DMOperationManager.PasteToElement(TopBoundaryE, aBoundaryU, False, True);
               S1:=Format('%s /%d',[TopBoundaryE.Name, m]);
               DMOperationManager.RenameElement(aBoundaryU, S1);
             end;
             aBoundaryE:=aBoundaryU as IDMElement;
             aAreaE.Ref:=aBoundaryE;
           end;
         end;

         VolumeBuilder.CheckHAreas(Volume, aVolume, bdUp, False);

         DMOperationManager.ChangeParent( nil,
                           aCommonZoneU, aZoneU);
       end;  //for m:=0 to AreaList.Count-1
       except
         DataModel.HandleError
           ('Error in DoBuildSectors');
       end;

       try
       m:=0;
       while m<Volume.TopAreas.Count do begin
         AreaE:=Volume.TopAreas.Item[m];
         Area:=AreaE as IArea;
         if Area.Volume1=Volume then begin
           AreaP:=AreaE as IPolyline;
           Area.Volume0:=nil;
           Area.Volume1:=nil;
           DMOperationManager.DeleteElement( nil, nil, ltOneToMany,
                             Area as IUnknown);
         end else
           inc(m)
       end; // while m:=0 to Volume.TopAreas.Count
       except
         DataModel.HandleError
           ('Error in DoBuildSectors');
       end;
       if ZoneE<>aCommonZoneE then begin
         DMOperationManager.UpdateElement(
                        ZoneE.SpatialElement as IUnknown);
       end;
      end; //   if OldAreaCount<AreaList.Count then begin
    end; // if AreaList.Count>0

  end; //for j:=0 to ZoneCollectionCount-1

  for j:=0 to ZoneCollectionCount-1 do begin
    ZoneE:=ZoneCollection.Item[j];
    aVolumeE:=ZoneE.SpatialElement;
    aVolume:=aVolumeE as IVolume;
    Zone:=ZoneE as IZone;
    m:=0;
    while m<aVolume.Areas.Count do begin
      AreaE:=aVolume.Areas.Item[m];
      Area:=AreaE as IArea;
      if Area.IsVertical then begin
          inc(m);

        if (Area.Volume1<>nil) and
           (GlobalVolume.Areas.IndexOf(AreaE)<>-1) then
          AreaE.RemoveParent(GlobalVolumeE)
      end else
        inc(m);
    end;

    for m:=0 to OuterVAreas.Count-1 do begin
      AreaE:=OuterVAreas.Item[m];
      Area:=AreaE as IArea;
      if aVolume.Areas.IndexOf(AreaE)=-1 then
        AreaE.AddParent(aVolumeE);
      if (Area.Volume1=nil) and
        (GlobalVolume.Areas.IndexOf(AreaE)=-1) then
          AreaE.AddParent(GlobalVolumeE);
    end;

    AddFlag:=False;
    Zone.MakeHVAreas(nil, nil, AddFlag);
    DMOperationManager.UpdateElement( aVolumeE);
  end;

  AreaList.Free;
  FDoubleList.Free;
  FPlusList.Free;
  DMDocument.Server.RefreshDocument(rfFrontBack);
  if aCommonZoneE<>nil then
    DMDocument.Server.DocumentOperation(aCommonZoneE, nil,
                          leoAdd, -1);
end;

destructor TSectorBuilder.Destroy;
begin
  inherited;
  FFacilityModel:=nil;
end;


procedure TSectorBuilder.Indexs(Index:integer; const NodesList:TList;
                               var iOut,iIn:integer);
var
    aNode    :ICoordNode;
    bCoordRec:PCoordRec;
begin
     aNode:=ICoordNode(NodesList.Items[Index]);
     bCoordRec:=PCoordRec(pointer(aNode.Tag));
     iOut:=integer(bCoordRec^.FNode.Items[0]);
     iIn:=integer(bCoordRec^.FNode.Items[1]);

end;

//_________________________________________________________________________
function TSectorBuilder.CrossingLine(Node1,Node2,Node3,Node4:ICoordNode):boolean;
var
 P1X,P1Y,P2X,P2Y,P3X,P3Y,P4X,P4Y:Double;
begin
     P1X:=Node1.X;
     P1Y:=Node1.Y;
     P2X:=Node2.X;
     P2Y:=Node2.Y;
     P3X:=Node3.X;
     P3Y:=Node3.Y;
     P4X:=Node4.X;
     P4Y:=Node4.Y;
     result:=Crossing_Node(P1X,P1Y, P2X,P2Y, P3X,P3Y, P4X,P4Y);
end;

function TSectorBuilder.Crossing_Node(Node1X,Node1Y, Node2X,Node2Y,
                Node3X,Node3Y, Node4X,Node4Y:Double):boolean;
// Result=True -пересечение есть
var
   X1,Y1,X2,Y2,X3,Y3,X4,Y4,dX12,dY12,dX34,dY34,d12,d34:double;
   a,b,x,y:double;
   dx1,dy1,X1n,Lx1:double;
   dx2,dy2,X2n,Lx2:double;

   function CoordConvert(dXi,dYi,dX,dY:double; var Lx0:double):double;
   begin
     Lx0:=(Trunc((Sqrt(dX*dX+dY*dY))*100))/100;
     Result:=(Trunc(((dX/Lx0)*dXi+(dY/Lx0)*dYi)*100))/100;
   end;

begin  { function Crossing __________________________________________}
     Node1X:=(Trunc(Node1X*100))/100;
     Node1Y:=(Trunc(Node1Y*100))/100;
     Node2X:=(Trunc(Node2X*100))/100;
     Node2Y:=(Trunc(Node2Y*100))/100;
     Node3X:=(Trunc(Node3X*100))/100;
     Node3Y:=(Trunc(Node3Y*100))/100;
     Node4X:=(Trunc(Node4X*100))/100;
     Node4Y:=(Trunc(Node4Y*100))/100;

  if (((Node1X=Node3X)
       and(Node1Y=Node3Y))
             or
      ((Node1X=Node4X)
       and(Node1Y=Node4Y))) then begin
    if (((Node2X=Node3X)
        and(Node2Y=Node3Y))
             or
       ((Node2X=Node4X)
        and(Node2Y=Node4Y))) then begin
     Result:=True;
     Exit;
    end else
     Result:=False;
     Exit;
  end else begin
   if Node1X>Node2X then begin
     X1:=Node2X;
     Y1:=Node2Y;
     X2:=Node1X;
     Y2:=Node1Y
    end
    else begin
     X1:=Node1X;
     Y1:=Node1Y;
     X2:=Node2X;
     Y2:=Node2Y
    end;

   if Node3X>Node4X then begin
     X3:=Node4X;
     Y3:=Node4Y;
     X4:=Node3X;
     Y4:=Node3Y
    end
    else begin
     X3:=Node3X;
     Y3:=Node3Y;
     X4:=Node4X;
     Y4:=Node4Y
    end;

    dX12:=X2-X1;
    dY12:=Y2-Y1;

    dX34:=X4-X3;
    dY34:=Y4-Y3;

    d12:=dX12/dY12;
    d34:=dX34/dY34;

    dX12:=abs(dX12);
    dX34:=abs(dX34);

    if d12=d34 then   //паралл.
     if (dX12=0)or(dX34=0)then
     begin  //верт.
       a:= x3;    // здесь a -это x на векторе 2 в точке x3
       b:= x1;
       if a=b then
       begin
        x:=x3;
        y:=y3
       end
       else
       begin
        x:=99.99E99;
        y:=99.99E99
       end
     end   //верт.
     else
     begin                 //наклон или горизонт.(не верт.)
       a := y3-x3*(1/d34); // здесь b это y на векторе 1 в точке x3
       b:= y1-x1*(1/d12);
       if a=b then
       begin
        if x1<=x3 then
        begin
         x:=x4;
         y:=y4
        end
        else
        begin
         x:=x1;
         y:=y1
        end
       end
       else
       begin
        x:=99.99E99;
        y:=99.99E99
       end
    end
    else       //не паралл.
     if (dY12=0)or(dY34=0)then  //горизонт. 1 или 2
      if (dY12=0) then
      begin   //горизонт. 1
       y:=y1;
       x:=(y-y3)*d34+x3
      end
      else
      begin   //горизонт. 2
       y:=y3;
       x:=(y-y1)*d12+x1
      end
     else
     begin   //наклон
      y:=(y1*d12-y3*d34-x1+x3)/(d12-d34);
      x:=(y-y1)*d12+x1;
     end;

    dx1:=(x-x1);
    dy1:=(y-y1);
    X1n:=CoordConvert(dx1,dy1,dX12,dY12,Lx1);

    dx2:=(x-x3);
    dy2:=(y-y3);
    X2n:=CoordConvert(dx2,dy2,dX34,dY34,Lx2);
// если Result=True -пересечение есть
    Result:=(((X1n=0)or(X1n=Lx1))and((X2n>0)and(X2n<Lx2)))
             or(((X1n>0)and(X1n<Lx1))and((X2n>0)and(X2n<Lx2)))
             or(((X2n=0)or(X2n=Lx2))and((X1n>0)and(X1n<Lx1)));
//___________________________
  end;
end; { function Crossing ________________________________________ __}

function  AngleDifference(Node1,Node2:ICoordNode;NodesList:TList):double;
var
  bCoordRec:PCoordRec;
  Node0,Node3:ICoordNode;
  A2, A0, A3, A30, B:double;
  X0, Y0, X1, Y1, X2, Y2, X3, Y3,
  L12, L10, L13:double;
begin
  bCoordRec:=PCoordRec(pointer(Node1.Tag));
  Node0 :=ICoordNode(NodesList[integer(bCoordRec^.FNode[0])]);
  Node3 :=ICoordNode(NodesList[integer(bCoordRec^.FNode[1])]);
  X0:=Node0.X;
  Y0:=Node0.Y;
  X1:=Node1.X;
  Y1:=Node1.Y;
  X2:=Node2.X;
  Y2:=Node2.Y;
  X3:=Node3.X;
  Y3:=Node3.Y;
  L12:=sqrt(sqr(X2-X1)+sqr(Y2-Y1));
  L10:=sqrt(sqr(X0-X1)+sqr(Y0-Y1));
  L13:=sqrt(sqr(X3-X1)+sqr(Y3-Y1));

  if abs(L12)<1.e-9 then
    A2:=90
  else
  if abs((X2-X1)/L12-1)<1.e-9 then
    A2:=0
  else
  if abs((X2-X1)/L12+1)<1.e-9 then
    A2:=180
  else
    A2:=arccos((X2-X1)/L12)/pi*180;
  if Y2-Y1<0 then
    A2:=-A2;

  if abs(L10)<1.e-9 then
    A0:=90
  else
  if abs((X0-X1)/L10-1)<1.e-9 then
    A0:=0
  else
  if abs((X0-X1)/L10+1)<1.e-9 then
    A0:=180
  else
    A0:=arccos((X0-X1)/L10)/pi*180;
  if Y0-Y1<0 then
    A0:=-A0;

  if abs(L13)<1.e-9 then
    A3:=90
  else
  if abs((X3-X1)/L13-1)<1.e-9 then
    A3:=0
  else
  if abs((X3-X1)/L13+1)<1.e-9 then
    A3:=180
  else
    A3:=arccos((X3-X1)/L13)/pi*180;
  if Y3-Y1<0 then
    A3:=-A3;

  A30:=abs(A3-A0);
  B:=0.5*(A3+A0);
  if A30<180 then begin
    B:=B-180;
    if B<-180 then
      B:=360+B;
  end;
  Result:=abs(B-A2)
end;


procedure TSectorBuilder.SetJoining(StepFlag,Number,
             Index,ItemIndex:integer; const NodesList, Borders, ExternalBorders:TList;
             DivAngle:Double; var L1min:Double; var i1,i2,Stat:integer);
{Stat= 0 -нужно соединить
 Stat=-1 -нельзя соединить(пересечение)
 Stat=-2 -ненужно соединять            }
var
 bCoordRec1:PCoordRec;
 bCoordRec2:PCoordRec;
 aNumber1,aNumber2,aNumb:integer;
 aControlNode1,aControlNode2:integer;
 aConvex1,Flag:boolean;
 dX,dY:double;
 L1:double;
 aNode1,aNode2:ICoordNode;

 function CrossingsChecking(Node1,Node2:ICoordNode; const Borders:TList):boolean;
 var
  aCount:integer;
  i,aID1,aID2,aID3,aID4:integer;
  aLine:ILine;
  aNode3,aNode4:ICoordNode;
 begin { function CrossingsChecking __________________________________}
  aCount:=Borders.Count;
  aID1:=(Node1 as IDMElement).ID;
  aID2:=(Node2 as IDMElement).ID;
  result:=True;
  for i:=0 to aCount-1 do
  begin
   aLine:=ILine(Borders.Items[i]);
   aNode3:=aLine.C0;
   aNode4:=aLine.C1;
   aID3:=(aNode3 as IDMElement).ID;
   aID4:=(aNode4 as IDMElement).ID;
   if not((aID3=aID1)  //если нет общего узла
      or  (aID4=aID1)
      or  (aID3=aID2)
      or  (aID4=aID2)) then
    if CrossingLine(Node1,Node2,aNode3,aNode4) then
    begin
     result:=False;
     Exit;
    end
  end;
 end;  { function CrossingsChecking ___________________________________}

 function AreaChecking(Node1,Node2:ICoordNode):boolean;
// True - если внутри обл.
 var
  x0,y0,x1,y1,xk,yk:Real;
 begin { function AreaChecking __________________________________}

     x0:=Node1.X;
     y0:=Node1.Y;
     x1:=Node2.X;
     y1:=Node2.Y;

     dX:=x1-x0;
     dY:=y1-y0;

     xk:=x0+dX/2;  //xk,yk -центр.точка
     yk:=y0+dY/2;

     if xk<>x0 then
     begin
      x1:=0;  //xk,y max -вертикаль
      y1:=1E12;
     end
     else
     begin
      x1:=1E12;  //x max, yk -горизонталь
      y1:=0;
     end;

     result:=ControlPositionA(xk,yk,x1,y1, ExternalBorders) ;


 end;  { function AreaChecking ___________________________________}

 function PointChecking(Node1,Node2:ICoordNode):boolean;
 // True - если не пересек.Duble-line
 var
  aPoint1,aPoint2:ICoordNode;
  bCoordRec1:PCoordRec;
  bCoordRec2:PCoordRec;
  function NodeChoice(Node:ICoordNode):boolean;
  var
   a,b,c,sign:double;
   aNode3,aNode4:ICoordNode;
   bCoordRec:PCoordRec;
  begin
   a:=aNode2.Y-aNode1.Y;
   b:=-(aNode2.X-aNode1.X);
   c:=-b*aNode1.Y-a*aNode1.X;

   bCoordRec:=PCoordRec(pointer(Node.Tag));
   aNode3:=ICoordNode(NodesList.Items[integer(bCoordRec^.FNode.Items[0])]);
   aNode4:=ICoordNode(NodesList.Items[integer(bCoordRec^.FNode.Items[1])]);

   sign:=(a*aNode3.X + b*aNode3.Y + c)*(a*aNode4.X + b*aNode4.Y + c);

   if sign<0 then
   begin
    result:=True;
   end
   else
    result:=False;
  end;

//--------------
 begin  { function PointChecking __________________________________}

   if aControlNode1<>-1 then   //если Node1 парная
    aPoint1:=Node1
   else
    if aControlNode2<>-1 then  //если Node1 парная
     aPoint1:=Node2
    else
    begin
     result:=True;
     Exit;
    end;

    if not NodeChoice(aPoint1)then  //проверить 1-ю точк.пары
    begin
     result:=False;
     Exit;
    end
    else
    begin
     bCoordRec1:=PCoordRec(pointer(aPoint1.Tag));
     aPoint2:=ICoordNode(NodesList.Items[integer(bCoordRec1.FNode.Items[0])]); //пара сзади
     bCoordRec2:=PCoordRec(pointer(aPoint2.Tag));
     if bCoordRec2.ControlNode=-1 then
     begin
      aPoint2:=ICoordNode(NodesList.Items[integer(bCoordRec1.FNode.Items[1])]);  //пара впереди
      bCoordRec2:=PCoordRec(pointer(aPoint2.Tag));
      if bCoordRec2.ControlNode=-1 then
      begin
       result:=False;
       Exit;
      end
     end;
    end;

    if  NodeChoice(aPoint2)then //проверить 2-ю точк.пары
     result:=True
    else
     result:=False;

 end;  { function PointChecking ___________________________________}

begin  { procedure SetJoining  (Варианты.vi  )_________________________}

 aNode1:=ICoordNode(NodesList.Items[Index]);
 bCoordRec1:=PCoordRec(pointer(aNode1.Tag));
 aConvex1 :=bCoordRec1.FConvex;
 aControlNode1:=bCoordRec1.ControlNode;

 aNode2:=ICoordNode(NodesList.Items[ItemIndex]);
 bCoordRec2:=PCoordRec(pointer(aNode2.Tag));
 aControlNode2:=bCoordRec2.ControlNode;

 case StepFlag of
  0:begin
       aNumber1 :=bCoordRec1.FNumber;                     // свойство - Number
       aNumber2 :=bCoordRec2.FNumber;                     // свойство - Number
       Flag:=((aNumber2=0)
            and(aNumber1=Number)
            and(not aConvex1));
     end;
  1:begin
       aNumber1 :=bCoordRec1.FNumber;                     // свойство - Number
       aNumber2 :=bCoordRec2.FNumber;                     // свойство - Number
       Flag:=((aNumber2=0)
            and(aNumber1=Number)
            and(not aConvex1));
     end;
  2: Flag:=(not aConvex1);
  3: begin aNumb:=trunc((NodesList.Count)/2);
      if aNumb>(NodesList.Count-1) then
       aNumb:=aNumb-(NodesList.Count-1);
      Flag:=(ItemIndex=aNumb);
     end;
 (* -1: begin
      aNumber1 :=bCoordRec1.FNumber;   //  внутр.зона не имеет связи с внешней
      aNumber2 :=bCoordRec2.FNumber;
      Flag:=((aNumber2<>Number)
            and(aNumber1=Number)
            and(not aConvex1));
      StepFlag:=0;
     end;   *)
  else Flag:=False;
 end;

 if Flag then   //
 begin
  if CrossingsChecking(aNode1,aNode2, Borders) then // если не пересек.
  begin
   if AreaChecking(aNode1,aNode2) then     //если внутри обл.
   begin
    if PointChecking(aNode1,aNode2) then     //если не пересек.W-line
    begin
//     dX:=aNode1.X-aNode2.X;
//     dY:=aNode1.Y-aNode2.Y;
//     aL:=Sqrt(dX*dX+dY*dY);
     L1:=AngleDifference(aNode1,aNode2,NodesList);
     if L1<L1min then begin                                //min
       L1min:=L1;
       i1:=Index;
       i2:=ItemIndex
      end;
     Stat:=0;
    end            // не пересек.W-line
   else
   begin           //  пересек.W-line
     Stat:=-12;
   end;
   end             // внутри обл.
   else
   begin           // внe обл.
     Stat:=-11;
   end;
  end              // не пересек.
  else
  begin            //пересекается
     Stat:=-10;
  end;
 end           // нужно соединять
 else
 begin         // не нужно соединять
   Stat:=-2;
 end;
end; { procedure SetJoining (Варианты.vi  )______________________}

function TSectorBuilder.Tetta(Point1,Point2,Point3,Point4:ICoordNode):extended;
 //Угол Tetta между прямыми (Point1-Point2) и (Point3-Point4).
 //Result=Arctg(Tetta) (в действ.квадранте от -Pi до +Pi)
var
 A1,A2,B1,B2:extended;
begin
         A1:=Point1.Y-Point2.Y;
         B1:=Point1.X-Point2.X;
         A2:=Point3.Y-Point4.Y;
         B2:=Point3.X-Point4.X;
         result:=abs(ArcTan2((A1*B2-A2*B1),(A1*A2+B1*B2)))*360/(2*Pi);
end;

//____________________________________________________________________
procedure TSectorBuilder.Checking(var ExternalArea:IArea;
                  const NewAreaList, NodesList, Borders, ExternalBorders:TList);
var
 aDMDocument:IDMDocument;
 aVolumeBuilder:IVolumeBuilder;
 aDMOperationManager:IDMOperationManager;
 aSpatialModel:ISpatialModel;
 aNode0:ICoordNode;
 aStartExternalAreaE:IDMElement;
 aLineE:IDMElement;
 aLineNew,aLinePlus,aLineDouble:ILine;
 aLines2:IDMCollection2;
 aCoordNode2:IDMCollection2;
 Ik,I1,I2,k0,k1:integer;
 aLineCount:integer;
 aCount,aNumbersCount:integer;
 Stat:integer;
 aNode:ICoordNode;
 aNode0_Plus,aNode1_Plus:ICoordNode;
 bCoordRec:PCoordRec;
 aNumber:integer;
 L1min:double;
//_______________

    procedure MoveOutBordersInArea(NumbersCount:Integer);

    var
     i,aNodesListCount:integer;
     Ik,i0,Ip,I1,m:integer;
     aCount:integer;
     aLine,aLinePlus,aLineDouble:ILine;
     aLineE,aLinePlusE:IDMElement;
     aNode:ICoordNode;
     aLineList:TList;
//............................
     procedure UpDateElement(Line1,Line2:ILine;i:integer);
      var
       OldNode,NewNode:ICoordNode;
     begin

      if (Line1.C0.X=Line2.C0.X)
          and (Line1.C0.Y=Line2.C0.Y) then
      begin
       OldNode:=Line1.C0;
       Line1.C0:=nil;
       Line1.C0:=Line2.C0;
       NewNode:=Line2.C0;
      end
      else
       if (Line1.C0.X=Line2.C1.X)
          and (Line1.C0.Y=Line2.C1.Y) then
       begin
        OldNode:=Line1.C0;
        Line1.C0:=nil;
        Line1.C0:=Line2.C1;
        NewNode:=Line2.C1;
       end
       else
        if (Line1.C1.X=Line2.C0.X)
          and (Line1.C1.Y=Line2.C0.Y) then
        begin
         OldNode:=Line1.C1;
         Line1.C1:=nil;
         Line1.C1:=Line2.C0;
         NewNode:=Line2.C0;
        end
        else
         if (Line1.C1.X=Line2.C1.X)
           and (Line1.C1.Y=Line2.C1.Y) then
         begin
          OldNode:=Line1.C1;
          Line1.C1:=nil;
          Line1.C1:=Line2.C1;
          NewNode:=Line2.C1;
         end;

     end;
//...........................
    function Path(var i,Ip:integer;var PrevNode:ICoordNode;var LineDouble:ILine):boolean;
    var
     bCoordRec_I:PCoordRec;
     bCoordRec_Ip:PCoordRec;
     aNodeI,aNodeIp,aNodeIn0,aNodeOut0,aNodeIn,aNodeOut:IcoordNode;
     aLineIn0,aLineIn,aLineOut:ILine;
    begin

     aNodeI:=ICoordNode(NodesList[i]);            //i0
     bCoordRec_I:=PCoordRec(pointer(aNodeI.Tag));

     aNodeOut0:=ICoordNode(NodesList[integer(bCoordRec_I.FNode[0])]); //Out0
     aNodeIn0:=ICoordNode(NodesList[integer(bCoordRec_I.FNode[1])]);  //In0

     aLineIn0:=ILine((bCoordRec_I.FBorder[1]));           //Line_In0

     i:=integer(bCoordRec_I.FNode[Ip]);

     aNodeIp:=ICoordNode(NodesList[i]);  //Node_Plus
     bCoordRec_Ip:=PCoordRec(pointer(aNodeIp.Tag));

     aNodeOut:=ICoordNode(NodesList[integer(bCoordRec_Ip.FNode[0])]);          //iOut
     aNodeIn:=ICoordNode(NodesList[integer(bCoordRec_Ip.FNode[1])]);           //iIn


     aLineOut   :=ILine((bCoordRec_Ip.FBorder[0]));    //LineOut
     aLineIn    :=ILine((bCoordRec_Ip.FBorder[1]));    //LineOut
     LineDouble:=ILine((bCoordRec_Ip.FBorder[2]));    //Line_Plus

     UpDateElement(aLineIn0,LineDouble,0);

     if GetLoopDirectionFlag(aNodeI, aNodeIp, aNodeIn0,
                           aNodeOut0, aNodeIn, aNodeOut) then begin
      result:=False;        //  вперед
      if (aLineOut.C0.X=LineDouble.C0.X)
          and (aLineOut.C0.Y=LineDouble.C0.Y) then begin
       aLineOut.C0:=nil;
       aLineOut.C0:=LineDouble.C0;
      end else begin
       aLineOut.C1:=nil;
       aLineOut.C1:=LineDouble.C0;
      end;

     end else begin
      result:=True;         // назад
      if (aLineIn.C0.X=LineDouble.C0.X)
          and (aLineIn.C0.Y=LineDouble.C0.Y) then begin
       aLineIn.C0:=nil;
       aLineIn.C0:=LineDouble.C0;
      end else begin
       aLineIn.C1:=nil;
       aLineIn.C1:=LineDouble.C0;
      end;
     end;

     PrevNode:= LineDouble.C1;

    end;
//...........................
   procedure UpDate(aNode0:ICoordNode;aLineList:TList);
   var
    i:integer;
    aLine:ILine;
    aNodeC0,aNodeC1,aControlNode:ICoordNode;
   begin
    aLine:=ILine(aLineList.Items[0]);
   (aLine as IDMElement).AddParent(aStartExternalAreaE);

    aNodeC0:=aLine.C0;
    aNodeC1:=aLine.C1;

    if aNodeC0=aNode0 then
     aControlNode:=aNodeC1
    else
     aControlNode:=aNodeC0;

    for i:=1 to aLineList.Count-1 do
    begin
     aLine:=ILine(aLineList.Items[i]);

     aNodeC0:=aLine.C0;
     aNodeC1:=aLine.C1;
     if (aControlNode=aNodeC0)
        or(aControlNode=aNodeC1)then
     begin
      (aLine as IDMElement).AddParent(aStartExternalAreaE);
      if aNodeC0=aControlNode then
       aControlNode:=aNodeC1
      else
       aControlNode:=aNodeC0;
     end
     else
     begin
      if (aControlNode.X=aNodeC0.X)and(aControlNode.Y=aNodeC0.Y)
          or(aControlNode.X=aNodeC1.X)and(aControlNode.Y=aNodeC1.Y)then
      begin
       if (aControlNode.X=aNodeC0.X)and(aControlNode.Y=aNodeC0.Y) then
       begin
        aLine.C0:=nil;
        aLine.C0:=aControlNode;
        aControlNode:=aNodeC1;
       end
       else
       begin
        aLine.C1:=nil;
        aLine.C1:=aControlNode;
        aControlNode:=aNodeC0;
       end;
      (aLine as IDMElement).AddParent(aStartExternalAreaE);
      end;
     end;
    end;

//  Borders.Clear;
//  ExternalBorders.Clear;
//  NodesList.Clear;
//  aCount:=MakeBorders(ZoneExt.VAreas, Zmim, NodesList, Borders, ExternalBorders);
//  PointsIndexs(aIndBegin,aZoneNumber, NodesList, Borders,  Stat);
   end;  //___UpDate(aNode0:ICoordNode;aLineList:TList)____
 //__________________________
    var
     aP1,aP2,aP3:ICoordNode;
     MaxTetta,aTetta:extended;
     aPrevNode,aNextNode:ICoordNode;
     bCoordRecI:PCoordRec;          //указ.на тек.точку обхода по внеш.контуру
     bCoordRec:PCoordRec;           //указ.на тек.точку обхода по внутр.контуру
     aExternalAreaE:IDMElement;
     aDMOperationManager:IDMOperationManager;
     N:integer;

    begin
     aDMOperationManager:=((FFacilityModel as IDataModel).Document as IDMDocument)as IDMOperationManager;

     aLineList:=TList.Create;
     aExternalAreaE:=ExternalArea as IDMElement;
      while ExternalArea.BottomLines.Count>0 do  // очистить обл.
      begin
       aLineE:=ExternalArea.BottomLines.Item[0];
       aLineE.RemoveParent(aStartExternalAreaE);
      end;

     aNodesListCount:=NodesList.Count;
     aLineCount:=aNodesListCount+2*(NumbersCount-1);

     i0:=0;

     repeat
      aNode:=ICoordNode(NodesList.Items[i0]);
      aPrevNode:=aNode;
      bCoordRecI:=PCoordRec(pointer(aNode.Tag));
      aCount:=bCoordRecI.FNode.Count;

      aP1:=ICoordNode(NodesList.Items[integer(bCoordRecI.FNode.Items[0])]);
      aP2:=aNode;           //тек.точка ветвления

      if aCount>2 then begin
       while aCount>2 do begin      //Count>2
        Ip :=2;
                                                       //точка откуда пришло
        MaxTetta:=360;
        for i:=2 to aCount-1 do begin
         aP3:=ICoordNode(NodesList.Items[integer(bCoordRecI.FNode.Items[i])]);
                                                         //точка куда ветвится
         aTetta:=Tetta(aP1,aP2,aP3,aP2);
         if aTetta<MaxTetta then begin
          MaxTetta:=aTetta;
          aNextNode:=aP3;
          Ip:=i;
         end;   //if aTetta
        end;    //for i:
        aLinePlus:=ILine(bCoordRecI.FBorder.Items[Ip]);
        aLinePlus.C0:=nil;
        aLinePlus.C1:=nil;
        aLinePlus.C0:=aPrevNode;
        aLinePlus.C1:=aNextNode;
        aLinePlusE:=aLinePlus as IDMElement;
        aLinePlusE.AddParent(aStartExternalAreaE);
        aLineList.Add(pointer(aLinePlus));
        if (aNode.X=aLinePlus.C0.X)and(aNode.Y=aLinePlus.C0.Y) then
           bCoordRecI.ControlNode:=((aLinePlus.C0 as IDMElement).ID)
        else
           bCoordRecI.ControlNode:=((aLinePlus.C1 as IDMElement).ID);
        Ik:=i0;
        if Path(Ik,Ip,aPrevNode,aLineDouble) then
         I1:=0     //Patch=True (нужно перемещаться назад)
        else
         I1:=1;    //Patch=False (нужно перемещаться вперед)

        m:=Ik;
        N:=0;
        repeat
          bCoordRec:=PCoordRec(pointer(ICoordNode(NodesList.Items[Ik]).Tag));
          aLine:=ILine(bCoordRec^.FBorder.Items[I1]);
         (aLine as IDMElement).AddParent(aStartExternalAreaE);
          aLineList.Add(pointer(aLine));
          Ik:=integer(bCoordRec^.FNode.Items[I1]);
          inc(N);
          if N=NodesList.Count then Break;
        until m=Ik;

       (aLineDouble as IDMElement).AddParent(aStartExternalAreaE);
        aLineList.Add(pointer(aLineDouble));
        aNode:=ICoordNode(NodesList.Items[I]); //??????????????????
        bCoordRec:=PCoordRec(pointer(aNode.Tag));

        if (aNode.X=aLineDouble.C0.X)and(aNode.Y=aLineDouble.C0.Y) then begin
           bCoordRec.ControlNode:=((aLineDouble.C0 as IDMElement).ID);
        end else begin
           bCoordRec.ControlNode:=((aLineDouble.C1 as IDMElement).ID);
        end; //else

        UpDateElement(aLine,aLineDouble,Ik);


        bCoordRecI.FNode.Delete(Ip);
        bCoordRecI.FBorder.Delete(Ip);
        aCount:=bCoordRecI.FNode.Count;
       end;  //while aCount>2
      end    //If Count > 2
       else  begin           //____________________________________________
                                                  //Count < = 2
       aLineE:=ILine(Borders.Items[i0])as IDMElement;
       aLineE.AddParent(aStartExternalAreaE);
       aLineList.Add(pointer(aLineE as ILine));
       i0:=integer(bCoordRecI.FNode.Items[1]);
      end;
//______________________________________________________________________________
     until (aLineList.Count>=aLineCount);


     aNode0:=ICoordNode(NodesList[0]);
     UpDate(aNode0,aLineList);

//     aDMOperationManager:=((FFacilityModel as IDataModel).Document as IDMDocument)as IDMOperationManager;
//     aDMOperationManager.UpdateElement(False,True,aExternalAreaE);
     aLineList.Free;

    end;

//_____________________
  function BuildLine(StepFlag,Number:integer; var k0,k1:integer;
                       var LineNew:ILine):boolean;
  var
  Index,IndexOut,IndexIn,ItemIndex:integer;
  aNode:ICoordNode;
  Flag:boolean;
    function CrosingCheck:boolean;
    //проверка допустимости соединеия:
    //нельзя -сама с собой,с той откуда пришла,с той куда уйдет и им парными
    var
    aNode1:ICoordNode;
    begin
      if not((ItemIndex=IndexOut)or(ItemIndex=Index)or(ItemIndex=IndexIn)) then
      begin                                       // c i, iOut, iIn
       result:=True;
       if not(ItemIndex=bCoordRec^.ControlNode) then  //<>парн.т.Index
       begin
        aNode1:=ICoordNode(NodesList.Items[IndexOut]);
        bCoordRec:=PCoordRec(pointer(aNode1.Tag));
        if not(ItemIndex=bCoordRec^.ControlNode) then  //<>парн.т.IndexOut
        begin
         aNode1:=ICoordNode(NodesList.Items[IndexIn]);
         bCoordRec:=PCoordRec(pointer(aNode1.Tag));
         if (ItemIndex=bCoordRec^.ControlNode)then    //=парн.т.IndexIn
           result:=False;
        end               //<>парн.т.IndexOut
        else              //=парн.т.IndexOut
         result:=False;
       end                //<>парн.т.Index
       else               //=парн.т.Index
        result:=False;
      end                // <>c i, iOut, iIn
      else               // =c i, iOut, iIn
       result:=False;

    end;
//______________________
  var
    NewArea:IArea;
    aLineU:IUnknown;
    aP1,aP2,aP3:ICoordNode;
    DivAngle:double;
  begin
   result:=False;

     L1min:=99.99E99;
     I1:=-1;
     I2:=-1;
    Flag:=False;
   aCount:=NodesList.Count;
   for Index:=0 to aCount-1 do begin
    aNode:=ICoordNode(NodesList.Items[Index]);
    bCoordRec:=PCoordRec(pointer(aNode.Tag));
    Indexs(Index, NodesList, IndexOut,IndexIn);

    aP1:=ICoordNode(NodesList.Items[IndexOut]);  //точка откуда пришло
    aP2:=aNode;                                  //тек.точка ветвления
    aP3:=ICoordNode(NodesList.Items[IndexIn]);   //куда уйдет
    DivAngle:=Tetta(aP2,aP1,aP2,aP3);
    if (not bCoordRec^.FConvex)and(DivAngle<180) then
     DivAngle:=360-DivAngle;

    DivAngle:=DivAngle/2;

     for ItemIndex:=0 to aCount-1 do begin
      if CrosingCheck then begin
       SetJoining(StepFlag,Number,Index,ItemIndex,
                  NodesList, Borders, ExternalBorders,DivAngle,
                       L1min,I1,I2,Stat);
       if Stat=0 then begin
        Flag:=True;
       end;
      end;
     end;    //for ItemIndex
   end;    //For Index

    if Flag then begin //___________
     result:=True;

     if I1<I2 then begin
      k0:=I1;
      k1:=I2;
     end else begin
      k0:=I2;
      k1:=I1;
     end;

     aLines2:= aSpatialModel.Lines as IDMCollection2;    //

     aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                         aSpatialModel.Lines, '', ltOneToMany, aLineU, True);
     aLineE:=aLineU as IDMElement;

     LineNew:=aLineE as ILine;

     aNode0_Plus:=ICoordNode(NodesList.Items[k0]);
     aNode1_Plus:=ICoordNode(NodesList.Items[k1]);
     LineNew.C0:=aNode0_Plus;
     LineNew.C1:=aNode1_Plus;
     bCoordRec:=PCoordRec(pointer(aNode0_Plus.Tag));
     bCoordRec^.FConvex:=True;

     if bCoordRec^.FBorder=nil then
      bCoordRec^.FBorder:=TList.Create;
     if  StepFlag=0 then
       bCoordRec^.FNode.Add(pointer(k1));

     bCoordRec:=PCoordRec(pointer(aNode1_Plus.Tag));
     bCoordRec^.FConvex:=True;                       // свойство - Convex

     if bCoordRec^.FBorder=nil then
      bCoordRec^.FBorder:=TList.Create;

     if  StepFlag=0 then
     begin
      bCoordRec^.FNode.Add(pointer(k0));
     end;

     if StepFlag=1 then
     begin
      Borders.Add(pointer(LineNew));      // линию в список aBorders  !

      try

      aVolumeBuilder.UpdateAreas(LineNew as IDMElement);
      if not((LineNew as IDMElement).Parents.Count=0) then begin
       NewArea:=(LineNew as IDMElement).Parents.Item[0] as IArea;
       if NewArea=ExternalArea then
        NewArea:=(LineNew as IDMElement).Parents.Item[1] as IArea;
       NewAreaList.Add(pointer(NewArea));
      end else begin

       ShowMessage('сбой в программе, возможно из-за некорректности объекта');
       Exit;

      end;       ////// !!!!!!!


   (*   ShowMessage( (LineNew as IDMElement).Name
           +' - '+ (ExternalArea as IDMElement).Name
           +' '#13#10' '+
           ((LineNew as IDMElement).Parents.Item[0] as IDMElement).Name+'  '+
           ((LineNew as IDMElement).Parents.Item[1] as IDMElement).Name);  *)
      except
         (aSpatialModel as IDataModel).HandleError
           ('Error in TSectorBuilder.Checking');

      end;
     end;
    end;  //Flag
  end;
 //__________________________
  function NodeChoice(Node:ICoordNode):boolean;
  var
   a,b,c,sign:double;
   aNode1,aNode2:ICoordNode;
   aLine:ILine;
  begin
   a:=aLineNew.C1.Y-aLineNew.C0.Y;
   b:=aLineNew.C1.X-aLineNew.C0.X;
   c:=a*aLineNew.C0.X-b*aLineNew.C0.Y;

   aNode1:=ICoordNode(NodesList.Items[integer(bCoordRec^.FNode.Items[1])]);
   aLine:=ILine(FDoubleList[Ik]);
   aNode2:=aLine.C0;

   sign:=(a*aNode1.X + b*aNode1.Y + c)*(a*aNode2.X + b*aNode2.Y + c);

   if sign<0 then
   begin
    result:=True;
    aNode:=aLine.C1;
   end
   else
    result:=False;
  end;

var
  aLineU, aNode0U, aNode1U:IUnknown;
  aNode0E, aNode1E:IDMElement;
begin

 aDMDocument:=(FFacilityModel as IDataModel).Document as IDMDocument;
 aVolumeBuilder:=aDMDocument as IVolumeBuilder;
 aDMOperationManager:=aDMDocument as IDMOperationManager;

 aSpatialModel:=aDMDocument.DataModel as ISpatialModel;
 aCount:=NodesList.Count;
 if aCount <3 then Exit;  //меньше 3-x точек

 aStartExternalAreaE:=ExternalArea as IDMElement;

 aNumbersCount:=FZoneCount;

  for Ik:=1 to aNumbersCount-1 do  begin    //  кроме одной(внешней)
//  for Ik:=1 to 1 do  begin    //  кроме одной(внешней)
    aNumber:=Ik;

    if not BuildLine(StepFlag,aNumber,k0,k1,aLinePlus) then begin
 //    if not BuildLine(-1,aNumber,k0,k1,aLinePlus) then begin
      ShowMessage('Невозможно разбить на секторы "'+aStartExternalAreaE.Name+
             '".'#10#13'  Узлы периметра одной из внутренних зон (областей)'+
                      ' не имеют выхода'#10#13'  к узлам периметра внешней зоны');
      Exit;
     end;

    Borders.Add(pointer(aLinePlus));      // линию в список aBorders  !

    FPlusList.Add(pointer(aLinePlus));

    aNode:=ICoordNode(NodesList.Items[k0]);
    bCoordRec:=PCoordRec(pointer(aNode.Tag));
    bCoordRec^.FBorder.Add(pointer(Borders.Items[Borders.Count-1]));

    aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                         aSpatialModel.Lines, '', ltOneToMany, aLineU, True);
    aLineE:=aLineU as IDMElement;

    aLineDouble:=aLineE as ILine;

    aCoordNode2:= aSpatialModel.CoordNodes as IDMCollection2;

    aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                         aSpatialModel.CoordNodes, '', ltOneToMany, aNode0U, True);
    aNode0E:=aNode0U as IDMElement;

    aLineDouble.C0:=aNode0E as ICoordNode;

    aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                         aSpatialModel.CoordNodes, '', ltOneToMany, aNode1U, True);
    aNode1E:=aNode1U as IDMElement;

    aLineDouble.C1:=aNode1E as ICoordNode;

    aLineDouble.C0.X:=aLinePlus.C1.X;
    aLineDouble.C0.Y:=aLinePlus.C1.Y;
    aLineDouble.C1.X:=aLinePlus.C0.X;
    aLineDouble.C1.Y:=aLinePlus.C0.Y;
{
    VPlusLine0:=aLinePlus.C0.GetVerticalLine(bdUp);
    TopPlusC0:=VPlusLine0.C1;

    aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                           aSpatialModel.Lines, '', ltOneToMany, VDoubleLine1U);
    VDoubleLine1E:=VDoubleLine1U as IDMElement;
    VDoubleLine1:=VDoubleLine1E as ILine;
    VDoubleLine1.C0:=aLineDouble.C1;

    aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                         aSpatialModel.CoordNodes, '', ltOneToMany, TopDoubleC1U);
    TopDoubleC1E:=TopDoubleC1U as IDMElement;
    TopDoubleC1:=TopDoubleC1E as ICoordNode;

    VDoubleLine1.C1:=TopDoubleC1;

    TopDoubleC1.X:=TopPlusC0.X;
    TopDoubleC1.Y:=TopPlusC0.Y;
    TopDoubleC1.Z:=TopPlusC0.Z;

    VPlusLine1:=aLinePlus.C1.GetVerticalLine(bdUp);
    TopPlusC1:=VPlusLine1.C1;

    aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                         aSpatialModel.Lines, '', ltOneToMany, VDoubleLine0U);
    VDoubleLine0E:=VDoubleLine0U as IDMElement;
    VDoubleLine0:=VDoubleLine0E as ILine;
    VDoubleLine0.C0:=aLineDouble.C0;

    aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                         aSpatialModel.CoordNodes, '', ltOneToMany, TopDoubleC0U);
    TopDoubleC0E:=TopDoubleC0U as IDMElement;
    TopDoubleC0:=TopDoubleC0E as ICoordNode;

    VDoubleLine0.C1:=TopDoubleC0;

    TopDoubleC0.X:=TopPlusC1.X;
    TopDoubleC0.Y:=TopPlusC1.Y;
    TopDoubleC0.Z:=TopPlusC1.Z;
}
    Borders.Add(pointer(aLineDouble)); // линию в список Border

    FDoubleList.Add(pointer(aLineDouble));

    aNode:=ICoordNode(NodesList.Items[k1]);
    bCoordRec:=PCoordRec(pointer(aNode.Tag));
    bCoordRec^.FBorder.Add(pointer(Borders.Items[Borders.Count-1]));

  end;

  MoveOutBordersInArea(aNumbersCount); { TODO -o  Гол. -c  закладка :   MoveOutBordersInArea }
{
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
  for j:=0 to FPlusList.Count-1 do begin
   aLinePlus:=ILine(FPlusList[j]);
   aLineDouble:=ILine(FDoubleList[j]);
//   try
    VPlusLine0:=aLinePlus.C0.GetVerticalLine(bdUp);
    BottomPlusC0:=VPlusLine0.C0;
    TopPlusC0:=VPlusLine0.C1;

    VPlusLine1:=aLinePlus.C1.GetVerticalLine(bdUp);
    BottomPlusC1:=VPlusLine1.C0;
    TopPlusC1:=VPlusLine1.C1;

    VDoubleLine0:=aLineDouble.C0.GetVerticalLine(bdUp);
    BottomDoubleC0:=VDoubleLine0.C0;
    TopDoubleC0:=VDoubleLine0.C1;

    VDoubleLine1:=aLineDouble.C1.GetVerticalLine(bdUp);
    BottomDoubleC1:=VDoubleLine1.C0;
    TopDoubleC1:=VDoubleLine1.C1;

    aSideArea:=nil;
    for m:=0 to BottomDoubleC0.Lines.Count-1 do begin
      BottomLine:=BottomDoubleC0.Lines.Item[m] as ILine;
      aSideArea:=BottomLine.GetVerticalArea(bdUp);
      if (BottomLine<>aLineDouble) and
         (aSideArea<>nil) then begin
        k:=0;
        TopLine:=nil;
        while k<aSideArea.TopLines.Count do begin
          TopLine:=aSideArea.TopLines.Item[k] as ILine;
          if TopLine.C0=TopPlusC1 then begin
            TopLine.C0:=TopDoubleC0;
            Break
          end else
          if TopLine.C1=TopPlusC1 then begin
            TopLine.C1:=TopDoubleC0;
            Break
          end else
            inc(k)
        end;
      end;
    end;
    (VPlusLine1 as IDMElement).RemoveParent(aSideArea as IDMElement);
    (VDoubleLine0 as IDMElement).AddParent(aSideArea as IDMElement);

    for m:=0 to BottomDoubleC1.Lines.Count-1 do begin
      BottomLine:=BottomDoubleC1.Lines.Item[m] as ILine;
      aSideArea:=BottomLine.GetVerticalArea(bdUp);
      if (BottomLine<>aLineDouble) and
         (aSideArea<>nil) then begin
        k:=0;
        TopLine:=nil;
        while k<aSideArea.TopLines.Count do begin
          TopLine:=aSideArea.TopLines.Item[k] as ILine;
          if (TopLine.C0=TopPlusC0)then begin
            TopLine.C0:=TopDoubleC1;
            Break
          end else
          if (TopLine.C1=TopPlusC0)then begin
            TopLine.C1:=TopDoubleC1;
            Break
          end else
            inc(k)
        end;
      end;
    end;
    (VPlusLine0 as IDMElement).RemoveParent(aSideArea as IDMElement);
    (VDoubleLine1 as IDMElement).AddParent(aSideArea as IDMElement);
  end;

//    except
//      raise
//    end;
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
}

(*  StepFlag:=1;
  for Ik:=1 to aNumbersCount-1 do     //  кроме одной(внешней)
  begin
    aNumber:=Ik;
    BuildLine(StepFlag,aNumber,k0,k1,aLinePlus)
  end;

//******************************************************
*)
end;
//____________________________________________________________________

function TSectorBuilder.BuildLine(const DMDocument:IDMDocument;
        StepFlag,Number:integer; const NodesList, Borders, ExternalBorders:TList;
         var k0,k1:integer; var LineNew:ILine;ExternalArea:IArea):boolean;
var
  Index,IndexOut,IndexIn,ItemIndex:integer;
  aNode:ICoordNode;
  Flag:boolean;
  aCount:integer;
  L1min:double;
  I1,I2,Stat:integer;
  bCoordRec:PCoordRec;
  aLineE:IDMElement;
  aNode0_Plus,aNode1_Plus:ICoordNode;
  aVolumeBuilder:IVolumeBuilder;
  aDMOperationManager:IDMOperationManager;
  aSpatialModel:ISpatialModel;

    function CrosingCheck:boolean;
    //проверка допустимости соединеия:
    //нельзя -сама с собой,с той откуда пришла,с той куда уйдет и им парными
    var
     aNode1:ICoordNode;
     bCoordRec1:PCoordRec;
    begin
      if not((ItemIndex=IndexOut)or(ItemIndex=Index)or(ItemIndex=IndexIn)) then
      begin                                       // c i, iOut, iIn
       result:=True;
       if not(ItemIndex=bCoordRec^.ControlNode) then  //<>парн.т.Index
       begin
        aNode1:=ICoordNode(NodesList.Items[IndexOut]);
        bCoordRec1:=PCoordRec(pointer(aNode1.Tag));
        if not(ItemIndex=bCoordRec1^.ControlNode) then  //<>парн.т.IndexOut
        begin
         aNode1:=ICoordNode(NodesList.Items[IndexIn]);
         bCoordRec1:=PCoordRec(pointer(aNode1.Tag));
         if (ItemIndex=bCoordRec1^.ControlNode)then  //=парн.т.IndexIn
           result:=False;
        end               //<>парн.т.IndexOut
        else              //=парн.т.IndexOut
         result:=False;
       end                //<>парн.т.Index
       else               //=парн.т.Index
        result:=False;
      end                // <>c i, iOut, iIn
      else               // =c i, iOut, iIn
       result:=False;

    end;
//______________________

var
  aLineU:IUnknown;
  aNewArea:IArea;
  aNewAreaE, ExternalAreaE:IDMElement;
  aP1,aP2,aP3:ICoordNode;
  DivAngle:double;
begin
   result:=False;

     L1min:=99.99E99;
     I1:=-1;
     I2:=-1;
    Flag:=False;
   aCount:=NodesList.Count;
   for Index:=0 to aCount-1 do
   begin
    aNode:=ICoordNode(NodesList.Items[Index]);
    bCoordRec:=PCoordRec(pointer(aNode.Tag));
    Indexs(Index, NodesList, IndexOut,IndexIn);

    aP1:=ICoordNode(NodesList.Items[IndexOut]);        //точка откуда пришло
    aP2:=aNode;                                        //тек.точка ветвления
    aP3:=ICoordNode(NodesList.Items[IndexIn]);         //куда уйдет
    DivAngle:=Tetta(aP2,aP1,aP2,aP3);
    if (not bCoordRec^.FConvex)and(DivAngle<180) then
     DivAngle:=360-DivAngle;

    DivAngle:=DivAngle/2;
//    if not bCoordRec^.FConvex then
//    begin
     for ItemIndex:=0 to aCount-1 do begin
      if CrosingCheck then begin
       SetJoining(StepFlag,Number,Index,ItemIndex,
                  NodesList, Borders, ExternalBorders,DivAngle,
                       L1min,i1,i2,Stat);
       if Stat=0 then
        Flag:=True;
      end;
     end;    //for

   (*    if Stat=0 then
       begin
        result:=True;
        if StepFlag>1 then    // сокращ.цикла поиска
         break;
       end;
                 *)
//    end;   //FConvex
   end;     //For

//___________
   if Flag then begin
   
    result:=True;

    if I1<I2 then begin
     k0:=I1;
     k1:=i2;
    end else begin
     k0:=I2;
     k1:=i1;
    end;

    aSpatialModel:=DMDocument.DataModel as ISpatialModel;
    aDMOperationManager:=DMDocument as IDMOperationManager;
    aDMOperationManager.AddElement( FFacilityModel.BuildSectorLayer,
                         aSpatialModel.Lines, '', ltOneToMany, aLineU, True);
    aLineE:=aLineU as IDMElement;

    LineNew:=aLineE as ILine;

     aNode0_Plus:=ICoordNode(NodesList.Items[k0]);
     aNode1_Plus:=ICoordNode(NodesList.Items[k1]);
     LineNew.C0:=aNode0_Plus;
     LineNew.C1:=aNode1_Plus;
     bCoordRec:=PCoordRec(pointer(aNode0_Plus.Tag));
     bCoordRec^.FConvex:=True;

     if bCoordRec^.FBorder=nil then
       bCoordRec^.FBorder:=TList.Create;
     if StepFlag=0 then
       bCoordRec^.FNode.Add(pointer(k1));

     bCoordRec:=PCoordRec(pointer(aNode1_Plus.Tag));
     bCoordRec^.FConvex:=True;                       // свойство - Convex

     if bCoordRec^.FBorder=nil then
       bCoordRec^.FBorder:=TList.Create;

     if StepFlag=0 then begin
       bCoordRec^.FNode.Add(pointer(k0));
     end;

     if StepFlag>0 then begin
       Borders.Add(pointer(LineNew));      // линию в список aBorders  !

       aVolumeBuilder:=DMDocument as IVolumeBuilder;
       aNewArea:=aVolumeBuilder.LineDivideArea(LineNew.C0, LineNew.C1,ExternalArea);

       (LineNew as IDMElement).AddParent(ExternalArea as IDMElement);

       ExternalAreaE:=ExternalArea as IDMElement;
       aNewAreaE:=aNewArea as IDMElement;

       (LineNew as IDMElement).AddParent(aNewAreaE);

       aDMOperationManager.UpdateElement( ExternalAreaE);
       aDMOperationManager.UpdateElement( aNewAreaE);
       aDMOperationManager.UpdateCoords( ExternalAreaE);
       aDMOperationManager.UpdateCoords( aNewAreaE);

       if ExternalArea.Volume0<>nil then
        aDMOperationManager.UpdateElement( ExternalArea.Volume0 as IDMElement);

       if ExternalArea.Volume1<>nil then
        aDMOperationManager.UpdateElement( ExternalArea.Volume1 as IDMElement);

     (*  ShowMessage((LineNew as IDMElement).Name +'.-.'+ ExternalAreaE.Name +' / '+
                     aNewAreaE.Name);   *)

     end;

    end;  //Flag
//___________
end;


//______________________________
function TSectorBuilder.ConvertCoord(aNode1,aNode2,aNode3:ICoordNode;
                               const NodesList:TList;
                               var Xi,Yi:double; var Angle180:boolean):double;
var
 dX,dY,dXi,dYi,dX2,dY2,Lx0,L1,L2,x0,y0,xk,delta,L:double;
begin
    dX:=(aNode3.X-aNode2.X);
    dY:=(aNode3.Y-aNode2.Y);
    dXi:=(aNode1.X-aNode2.X);
    dYi:=(aNode1.Y-aNode2.Y);
    dX2:=(aNode3.X-aNode1.X);
    dY2:=(aNode3.Y-aNode1.Y);

    Lx0:=Sqrt(dX*dX+dY*dY);
    x0:=dX/Lx0*dXi+dY/Lx0*dYi;   // x*cos + y*sin
    y0:=dX/Lx0*dYi-dY/Lx0*dXi;   // x*(-sin) + y*cos

    Angle180:=(abs(y0)<1);

    L1 :=Sqrt(dXi*dXi+dYi*dYi);
    L2 :=Sqrt(dX2*dX2+dY2*dY2);
    L:=L1/L2;
    xk:=L*Lx0/(1+L);    //xk- точка, делящая отрезок dX в отношении L1/l2

    delta:=1;            //отступ вдоль биссектрисы на 1 см
    if  not (y0>delta) then
     delta:=y0*0.1;

    x0:=(((xk-x0)*delta)/y0)+x0;       //коорд.(в лок.осях)внутр.контрольной точки
    y0:=y0-delta;

    Xi:=round((aNode2.X+x0*dX/Lx0-y0*dY/Lx0)*1000)/1000; //в действ.осях
    Yi:=round((aNode2.Y+x0*dY/Lx0+y0*dX/Lx0)*1000)/1000;
    Result:=Xi;
end;

//___________________________________________
function TSectorBuilder.ConvexChecking(const NodesList, ExternalBorders:TList; var n:integer):boolean;
var
 bCoordRec:PCoordRec;
 bCoordRec0:PCoordRec;
 i,k,iOut,iIn,aCount:integer;
 aNode1,aNode2,aNode3:ICoordNode;
 x0,y0,x1,y1,Ymax:double;
 Angle180:boolean;
begin
 n:=0;
 aCount:=NodesList.Count;

 Result:=False;
 if aCount<3 then Exit;

 Ymax:= -9999E99;
 for i:=0  to aCount-1 do
 begin
  aNode1:=ICoordNode(NodesList.Items[i]);
  Ymax:=max(Ymax,aNode1.Y);
 end;

 result:=True;
 for i:=0 to aCount-1 do
 begin
  Indexs(i,NodesList,iOut,iIn);
  aNode1:=ICoordNode(NodesList.Items[i]);
  bCoordRec:=PCoordRec(pointer(aNode1.Tag));

  aNode2:=ICoordNode(NodesList.Items[iOut]);
  aNode3:=ICoordNode(NodesList.Items[iIn]);
  x0:=ConvertCoord(aNode1,aNode2,aNode3,NodesList, x0,y0, Angle180);
  x1:=x0;
  y1:=Ymax;

  if Angle180 then
    bCoordRec^.FConvex:=True
  else
    bCoordRec^.FConvex:=ControlPositionA(x0,y0,x1,y1, ExternalBorders);

  if not bCoordRec^.FConvex then begin
   result:=False;
   n:=n+1;
  end;
 end;

 for i:=0 to aCount-1 do
 begin
  aNode1:=ICoordNode(NodesList.Items[i]);
  bCoordRec0:=PCoordRec(pointer(aNode1.Tag));
  for k:=0 to aCount-1 do
  begin
   aNode2:=ICoordNode(NodesList.Items[k]);
   bCoordRec:=PCoordRec(pointer(aNode2.Tag));
   if (aNode1.X=aNode2.X)and(aNode1.Y=aNode2.Y)and(i<>k) then
   begin
    bCoordRec0.ControlNode:=k;
    bCoordRec^.ControlNode:=i;
   end;
  end;
 end;
end;


function TSectorBuilder.ControlPositionA(x0,y0,x1,y1:Real;
                          const ExternalBorders:TList):boolean;
var
 aCount:integer;
 i,kC:integer;
 aLine:ILine;
 P1x,P1Y,P2X,P2Y:double;
begin
  aCount:=ExternalBorders.Count;
  kC:=0;          //число пересечений
  for i:=0 to aCount-1 do
  begin
   aLine:=ILine(ExternalBorders.Items[i]);
   P1X:=aLine.C0.X;
   P1Y:=aLine.C0.Y;
   P2X:=aLine.C1.X;
   P2Y:=aLine.C1.Y;

   if Crossing_Node(x0,y0, x1,y1+100, P1X,P1Y, P2X,P2Y) then
   begin
     kC:=kC+1;
   end;
  end;
  if (kC div 2)=(kC/2) then
   result:=False
  else
   result:=True;
end;  { function CrossingsVolum ___________________________________}


function TSectorBuilder.MakeBorders(const VAreas:IDMCollection; const Zmin:double;
          const NodesList, Borders, ExternalBorders:TList):integer;
var
   i,j:integer;
   aArea:IArea;
   aLine,aLine1:ILine;
   aControlNode:ICoordNode;
   aList:TList;
begin
   result:=0;
   aList:=TList.Create;

   for j:=0  to VAreas.Count-1 do begin
    aArea:=VAreas.Item[j] as IArea;
    for i:=0  to aArea.BottomLines.Count-1 do begin
     aLine:=aArea.BottomLines.Item[i] as ILine;
      (* добавить линии, лежащие на Zmin-нижней границе внешней зоны  *)
     if aLine.C0.Z=Zmin then begin   { TODO :   линии, лежащие на Zmin-нижней границе }
//       if aLine.C0.Z=0 then begin
      aList.Add(pointer(aLine));
      inc(result);
     end;
    end;    // i:=0 - aArea.BottomLines.Count-1
   end;     // j:=0 - VAreas.Count-1

   ReorderLines(aList);

try
   aLine:=ILine(aList.Items[0]);
   aLine1:=ILine(aList.Items[1]);
except

  raise
end;

   if (aLine.C1=aLine1.C0)or(aLine.C1=aLine1.C1) then
   begin
    aControlNode:=aLine.C0;
   end
   else
   begin
    aControlNode:=aLine.C1;
   end;

   for i:=0  to aList.Count-1 do
   begin
    aLine:=ILine(aList.Items[i]);
    ExternalBorders.Add(pointer(aLine));
    InNodesList(aControlNode,aLine, NodesList, Borders);
   end;

   aList.Free;
end;

procedure TSectorBuilder.ReorderLines(const Lines:TList);
var
  j:integer;
  Line:ILine;
  TMPList:TList;
  C0, C1:ICoordNode;
  OldCount:integer;
begin
  if Lines.Count<2 then Exit;
  TMPList:=TList.Create;
  Line:=ILine(Lines.Items[0]);
  C0:=Line.C0;
  C1:=Line.C1;
  TMPList.Add(pointer(Line));
  Lines.Delete(0);

  while Lines.Count>0 do begin
    j:=0;
    OldCount:=Lines.Count;
    while j<Lines.Count do begin
      Line:=ILine(Lines.Items[j]);
      if C0=Line.C0 then begin
        C0:=Line.C1;
        TMPList.Insert(0, pointer(Line));
        Lines.Delete(j);
        Break
      end else
      if C1=Line.C0 then begin
        C1:=Line.C1;
        TMPList.Add(pointer(Line));
        Lines.Delete(j);
        Break
      end else
      if C0=Line.C1 then begin
        C0:=Line.C0;
        TMPList.Insert(0, pointer(Line));
        Lines.Delete(j);
        Break
      end else
      if C1=Line.C1 then begin
        C1:=Line.C0;
        TMPList.Add(pointer(Line));
        Lines.Delete(j);
        Break
      end else
        inc(j);
    end;
    if (Lines.Count=OldCount) and
       (OldCount<>0) then Break;
  end;

  for j:=0 to TMPList.Count-1 do
    Lines.Add(TMPList.Items[j]);

  TMPList.Free
end;

//_____________________________________________________________

function TSectorBuilder.Sort_Node(Line:ILine;var ControlNode:ICoordNode):boolean;
   //Опред.тек. точки многоугольника
   // если тек.узел С0 -True, С1 -False, начинать всегда с С0
begin
     if Line.C0=ControlNode then begin
      Result:=True;
      ControlNode:=Line.C1;
     end
     else
     if Line.C1=ControlNode then begin
       Result:=False;
       ControlNode:=Line.C0;
     end else
       Result:=False;
end;

procedure TSectorBuilder.InNodesList(var ControlNode:ICoordNode;
             Line:ILine; const NodesList, Borders:TList);
var
   aNode:ICoordNode;
   bCoordRec:PCoordRec;
begin
      Borders.Add(pointer(Line));          // линию в список Borders
//______________________
      if Sort_Node(Line,ControlNode) then
      begin
       aNode:=Line.C0 as ICoordNode;
      end
      else
      begin
       aNode:=Line.C1 as ICoordNode;
      end;
//__________________
      NodesList.Add(pointer(aNode));         // в список NodeList

      GetMem(bCoordRec,SizeOf(TCoordRec));
      aNode.Tag:=integer(pointer(bCoordRec));// связать с Tag доп.свойства(CoordRec)
      bCoordRec^.FNode:=nil;
      bCoordRec^.FBorder:=nil;
end;


//___________
procedure TSectorBuilder.PointsIndexs(IndBegin,Number:integer;
                  const NodesList, Borders:TList;
                   var Stat: integer);
var
   aNode:ICoordNode;
   bCoordRec:PCoordRec;
   aCount:integer;
   aiOut,aiIn:integer;
   i:integer;
begin
  {IndexOut,Index,IndexIn связаны циклически, как I-1, I, I+1
   Stat=-1 Error,
   Stat= 1 тек.точка 1-я в списке,
   Stat= 2 -последняя,
   Stat= 0 -любая другая  }

   aCount:= NodesList.Count;
   if (aCount-IndBegin)>=3 then
    begin
     for i:=IndBegin  to aCount-1 do
      begin
       if i=IndBegin then
        begin
         aiOut:=aCount-1;
         aiIn:=i+1;
         Stat:=1;
        end
       else
        if i=aCount-1 then
         begin
          aiOut:=i-1;
          aiIn:=IndBegin;
          Stat:=2;
         end
        else
         begin
          aiOut:=i-1;
          aiIn:=i+1;
          Stat:=0;
         end;
      aNode:=ICoordNode(NodesList.Items[i]);
      bCoordRec:=PCoordRec(pointer(aNode.Tag));
      bCoordRec^.FNumber   :=Number;                  // уст.свойство - Number

       if bCoordRec^.FNode=nil then
        bCoordRec^.FNode:=TList.Create
       else
        bCoordRec^.FNode.Clear;

       bCoordRec^.FNode.Add(pointer(aiOut));
       bCoordRec^.FNode.Add(pointer(aiIn));

       bCoordRec^.ControlNode:=-1;

       if bCoordRec^.FBorder=nil then
        bCoordRec^.FBorder:=TList.Create
       else
        bCoordRec^.FBorder.Clear;

       bCoordRec^.FBorder.Add(pointer(ILine(Borders.Items[aiOut])));
       bCoordRec^.FBorder.Add(pointer(ILine(Borders.Items[i])));
     end;
   end
   else
   begin
    Stat:=-1;
   end;
end;

function TSectorBuilder.GetLoopDirectionFlag(const CA, CB, CIn0, COut0,
  CIn1, COut1: ICoordNode): boolean;
var
  LAB, LIn0A, LOut0A, LIn1B, LOut1B,
  sinIn0, cosIn0, sinOut0, cosOut0,
  sinIn1, cosIn1, sinOut1, cosOut1,
  sinAB, cosAB, sinBA, cosBA,
  sinIn0B, cosIn0B,  sinIn0Out0, cosIn0Out0,
  sinAIn1, cosAIn1,  sinAOut1, cosAOut1:double;
  In0B, In0Out0,
  AIn1, AOut1,
  DA, DB:double;
begin
  LAB:=sqrt(sqr(CB.X-CA.X)+sqr(CB.Y-CA.Y){+sqr(CB.Z-CA.Z)});
  LIn0A:=sqrt(sqr(CIn0.X-CA.X)+sqr(CIn0.Y-CA.Y){+sqr(CIn0.Z-CA.Z)});
  LOut0A:=sqrt(sqr(COut0.X-CA.X)+sqr(COut0.Y-CA.Y){+sqr(COut0.Z-CA.Z)});
  LIn1B:=sqrt(sqr(CIn1.X-CB.X)+sqr(CIn1.Y-CB.Y){+sqr(CIn1.Z-CB.Z)});
  LOut1B:=sqrt(sqr(COut1.X-CB.X)+sqr(COut1.Y-CB.Y){+sqr(COut1.Z-CB.Z)});
  sinIn0:=(CIn0.Y-CA.Y)/LIn0A;
  cosIn0:=(CIn0.X-CA.X)/LIn0A;
  sinOut0:=(COut0.Y-CA.Y)/LOut0A;
  cosOut0:=(COut0.X-CA.X)/LOut0A;
  sinIn1:=(CIn1.Y-CB.Y)/LIn1B;
  cosIn1:=(CIn1.X-CB.X)/LIn1B;
  sinOut1:=(COut1.Y-CB.Y)/LOut1B;
  cosOut1:=(COut1.X-CB.X)/LOut1B;
  sinAB:=(CB.Y-CA.Y)/LAB;
  cosAB:=(CB.X-CA.X)/LAB;
  sinBA:=-sinAB;
  cosBA:=-cosAB;

  sinIn0B:=sinAB*cosIn0-cosAB*sinIn0;
  cosIn0B:=cosAB*cosIn0+sinAB*sinIn0;
  sinIn0Out0:=sinOut0*cosIn0-cosOut0*sinIn0;
  cosIn0Out0:=cosOut0*cosIn0+sinOut0*sinIn0;
  sinAIn1:=sinIn1*cosBA-cosIn1*sinBA;
  cosAIn1:=cosIn1*cosBA+sinIn1*sinBA;
  sinAOut1:=sinOut1*cosBA-cosOut1*sinBA;
  cosAOut1:=cosOut1*cosBA+sinOut1*sinBA;

  In0B:=arccos(cosIn0B);
  if  sinIn0B<0 then
    In0B:=2*pi-In0B;
  In0Out0:=arccos(cosIn0Out0);
  if  sinIn0Out0<0 then
    In0Out0:=2*pi-In0Out0;
  AIn1:=arccos(cosAIn1);
  if  sinAIn1<0 then
    AIn1:=2*pi-AIn1;
  AOut1:=arccos(cosAOut1);
  if  sinAOut1<0 then
    AOut1:=2*pi-AOut1;

  DA:=In0Out0-In0B;
  DB:=AOut1-AIn1;

  if DA>=0 then
    Result:=(DB<0)
  else
    Result:=(DB>=0);
end;

function TSectorBuilder.AreaDivided(const ExternalArea: IArea;
                             const DMDocument:IDMDocument;
                             var aLineNew:ILine):boolean;
var
 i,j:integer;
 aLine,aLine1:ILine;
 aLineCount:integer;
 aControlNode:ICoordNode;
 aZoneNumber,aIndBegin,Stat:integer;
 k0,k1,NoConvexCount,aNumber:integer;

 ExternalBorders:TList;
 Borders:TList;
 NodesList:TList;

 aNode:ICoordNode;

begin

  ExternalBorders:=TList.Create;
  Borders:=TList.Create;
  NodesList:=TList.Create;

  try

  aIndBegin:=0;

    aLineCount:=ExternalArea.BottomLines.Count;

    if aLineCount<3 then begin
     ShowMessage('Error Обл. '+IntToStr((ExternalArea as IDMElement).ID)
         +' линий -'+IntToStr(aLineCount));
     Exit;
    end;

    aLine:=ExternalArea.BottomLines.Item[0] as ILine;
    aLine1:=ExternalArea.BottomLines.Item[1] as ILine;
    if (aLine.C1=aLine1.C0)or(aLine.C1=aLine1.C1) then
    begin
     aControlNode:=aLine.C0;
    end
    else
    begin
     aControlNode:=aLine.C1;
    end;

    for i:=0  to aLineCount-1 do
    begin
     aLine:=ExternalArea.BottomLines.Item[i] as ILine;
     ExternalBorders.Add(pointer(aLine));  // в список ExternalBorders
     InNodesList(aControlNode,aLine, NodesList, Borders);// в список NodeList
    end;

    aZoneNumber:=1;
    PointsIndexs(aIndBegin,aZoneNumber, NodesList, Borders, Stat);

//***************************************************
    if (not ConvexChecking(NodesList, ExternalBorders, NoConvexCount)) // контроль выпуклости
           or (ExternalBorders.Count>MaxNodeCount) then   //узлов > допустимого
    begin
     if (NoConvexCount>0) then   // не выпукл. > 0
      StepFlag:=2
     else
      StepFlag:=3;

     aNumber:=0;
     aLineNew:=nil;
     BuildLine(DMDocument,StepFlag,aNumber,
               NodesList, Borders, ExternalBorders,
               k0,k1,aLineNew,ExternalArea);
     if aLineNew<>nil then begin
      result:=True;
     end else
      result:=False;
    end
    else
    begin
     Result:=False;
    end;

  finally
    for j:=0 to NodesList.Count-1 do begin
      aNode:=ICoordNode(NodesList[j]);
      FreeMem(pointer(aNode.Tag), SizeOf(TCoordRec));
      aNode.Tag:=0;
    end;

    ExternalBorders.Free;
    Borders.Free;
    NodesList.Free;
  end;
end;

procedure TSectorBuilder.DoubleLineDelete1;
var
 PlusNode0, PlusNode1, DoubleNode0, DoubleNode1:ICoordNode;
 BottomAreaE:IDMElement;
 TheLine:ILine;
 aDoubleLineE, aPlusLineE:IDMElement;
 aDoubleLine, aPlusLine:ILine;
 Ik,aNumbersCount:integer;
 aDMDocument:IDMDocument;
 aDMOperationManager:IDMOperationManager;
begin
 aDMDocument:=(FFacilityModel as IDataModel).Document as IDMDocument;
 aDMOperationManager:=aDMDocument as IDMOperationManager;

 aNumbersCount:=FDoubleList.Count;
 for Ik:=0 to aNumbersCount-1 do
 begin
       aDoubleLine:=ILine(FDoubleList.Items[Ik]);
       aDoubleLineE:=aDoubleLine as IDMElement;
       DoubleNode0:=aDoubleLine.C0;
       DoubleNode1:=aDoubleLine.C1;
       aDoubleLine.C0:=nil;
       aDoubleLine.C1:=nil;

       aPlusLine:=ILine(FPlusList.Items[Ik]);
       aPlusLineE:=aPlusLine as IDMElement;
       PlusNode0:=aPlusLine.C0;
       PlusNode1:=aPlusLine.C1;

       if DoubleNode0=PlusNode0 then Continue;
       if DoubleNode0=PlusNode1 then Continue;
       if DoubleNode1=PlusNode0 then Continue;
       if DoubleNode1=PlusNode1 then Continue;

       while  DoubleNode0.Lines.Count>0 do begin
         theLine:=DoubleNode0.Lines.Item[0] as ILine;
         if  theLine.C0=DoubleNode0 then
            theLine.C0:=PlusNode1
         else
            theLine.C1:=PlusNode1;
       end;
       while DoubleNode1.Lines.Count>0 do begin
         theLine:=DoubleNode1.Lines.Item[0] as ILine;
         if  theLine.C0=DoubleNode1 then
            theLine.C0:=PlusNode0
         else
            theLine.C1:=PlusNode0;
       end;
       while aDoubleLineE.Parents.Count>0 do begin
         BottomAreaE:=aDoubleLineE.Parents.Item[0];
         aDoubleLineE.RemoveParent(BottomAreaE);
         aPlusLineE.AddParent(BottomAreaE);
         aDMOperationManager.UpdateElement( BottomAreaE);
       end;

       aDMOperationManager.DeleteElement( nil, nil, ltOneToMany, aDoubleLineE as IUnknown);
       aDMOperationManager.DeleteElement( nil, nil, ltOneToMany, DoubleNode0 as IUnknown);
       aDMOperationManager.DeleteElement( nil, nil, ltOneToMany, DoubleNode1 as IUnknown);
  end;
end;

initialization
  CreateAutoObjectFactory(TSectorBuilder, Class_SectorBuilder);
end.
