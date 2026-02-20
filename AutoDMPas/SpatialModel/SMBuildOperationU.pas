unit SMBuildOperationU;

interface
uses
   Classes, SysUtils, Dialogs, Graphics,
   SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB , PainterLib_TLB,
   Math, Variants,
   SMOperationU, DMElementU, SMSelectOperationU, SMCreateOperationU,
   CustomSMDocumentU, SMOperationConstU;

const
  sdmVDivideVolume    = $000000F1;

type

  TBuildVolumeOperation=class(TSelectClosedPolyLineOperation)
  private
    FDone:boolean;
  public
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
    function GetModelCheckFlag:boolean; override;
  end;

  TBuildAreaOperation=class(TSelectClosedPolyLineOperation)
  private
    FDone:boolean;
  public
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TBuildVerticalAreaOperation=class(TSelectLineOperation)
  private
    FDone:boolean;
  public
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
    function GetModelCheckFlag:boolean; override;
  end;

  TBuildLineObjectOperation=class(TCustomCreateLineOperation)
  private
    FArea0:IArea;
    FArea1:IArea;
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TBuildArrayObjectOperation=class(TCreateLineOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure Drag(const SMDocument:TCustomSMDocument); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TBuildPolylineObjectOperation=class(TSelectLineOperation)
  private
    FDone:boolean;
  public
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TDivideVolumeOperation=class(TSelectVolumeOperation)
  private
    FDone:boolean;
  public
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
    function GetModelCheckFlag:boolean; override;
  end;

  TOutlineSelectedOperation=class(TSelectLineOperation)
  private
    FDone:boolean;
  public
    procedure Stop(const SMDocument:TCustomSMDocument; ShiftState:integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

function CreateArea(const aCollection:IDMCollection;
                        const DMOperationManager:IDMOperationManager;
                        const SpatialModel2:ISpatialModel2):IDMElement;
procedure CreateVolumeAreaRefElements(const SMDocument: TCustomSMDocument;
                                      const VolumeE, RefParent:IDMElement;
                                      ChangeRefFlag, BaseVolumeFlag:WordBool);

procedure MoveAreas(const DestVolume, SourceVolume:IVolume;
                    aArea, CuttingArea:IArea);

implementation
uses
  SpatialModelConstU, Geometry, Outlines;

{ TSMBuildVolumeOperation }


function TBuildVolumeOperation.GetModelCheckFlag: boolean;
begin
  Result:=True
end;

procedure TBuildVolumeOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='СОЗДАНИЕ ЗОН: Укажите замкнутый контур в основании зоны (SHIFT - выделение рамкой, CTRL - добавить к выделению, F6 - создать объект)';
  ACursor:=cr_Build_Zone;
end;

procedure TBuildVolumeOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState:integer);
var
  DMOperationManager:IDMOperationManager;
  VolumeBuilder:IVolumeBuilder;
  DMDocument:IDMDocument;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  Area:IArea;
  VolumeE, BaseAreaE, aRefElement, RefParent,
  aElement:IDMElement;
  m, i, N, ClassID, OldState1, SelectedAreaListCount:integer;
  Height:double;
  Volume, ParentVolume:IVolume;
  aLineE, aAreaE, ParentVolumeE:IDMElement;
  AreaList:TList;
  SelectedAreaList:TList;
  AreaP, aAreaP:IPolyline;
  VArea:IArea;
  BaseAreas:IDMCollection;
  BaseAreas2:IDMCollection2;
  PX, PY, PZ:double;
  DMClassCollections:IDMClassCollections;
  RefSource, aCollection: IDMCollection;
  Flag:boolean;
  BuildDirection:integer;

  procedure ProceedVolume(const VolumeE, RefParent:IDMElement);
  var
    k:integer;
  begin
    if N>1 then
      aRefElement:=DMOperationManager.CreateClone(aRefElement) as IDMElement;
    inc(N);
    if VolumeE<>nil then
      VolumeE.Ref:=aRefElement;

    if RefParent=nil then Exit; 

    CreateVolumeAreaRefElements(SMDocument, VolumeE, RefParent, False, False);

    Volume:=VolumeE as IVolume;

    if (ParentVolume<>nil) then begin
      if  (Volume.BottomAreas.Count>0) then begin
        AreaP:=Volume.BottomAreas.Item[0] as IPolyline;

        m:=0;
        while m<ParentVolume.BottomAreas.Count do begin
          aAreaE:=ParentVolume.BottomAreas.Item[m];
          aAreaP:=aAreaE as IPolyline;

          OldState1:=DMDocument.State;
          DMDocument.State:=DMDocument.State or dmfCommiting;

          Flag:=OutlineContainsOutline(aAreaP.Lines, AreaP.Lines);

          DMDocument.State:=OldState1;

          if Flag then begin
            i:=0;
            while i<AreaP.Lines.Count do begin
              aLineE:=AreaP.Lines.Item[i];
              if aAreaP.Lines.IndexOf(aLineE)<>-1 then begin  // зона граничит с внешней зоной
                for k:=0 to AreaP.Lines.Count-1 do begin     // включаем границы внутренней зоны во внешнюю зону
                  aLineE:=AreaP.Lines.Item[k];
                  if aAreaP.Lines.IndexOf(aLineE)=-1 then begin
                    aLineE.AddParent(aAreaE);
                    VArea:=(aLineE as ILine).GetVerticalArea(bdUp);
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
        end;

      end;


      if  (Volume.TopAreas.Count>0) then begin
        AreaP:=Volume.TopAreas.Item[0] as IPolyline;
        m:=0;
        while m<ParentVolume.TopAreas.Count do begin
          aAreaE:=ParentVolume.TopAreas.Item[m];
          aAreaP:=aAreaE as IPolyline;

          OldState1:=DMDocument.State;
          DMDocument.State:=DMDocument.State or dmfCommiting;

          Flag:=OutlineContainsOutline(aAreaP.Lines, AreaP.Lines);

          DMDocument.State:=OldState1;

          if Flag then begin
            i:=0;
            while i<AreaP.Lines.Count do begin
              aLineE:=AreaP.Lines.Item[i];
              if aAreaP.Lines.IndexOf(aLineE)<>-1 then begin  // зона граничит с внешней зоной
                for k:=0 to AreaP.Lines.Count-1 do begin     // включаем границы внутренней зоны во внешнюю зону
                  aLineE:=AreaP.Lines.Item[k];
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
        end;
      end;
    end;
    DMOperationManager.ChangeParent( nil, RefParent, aRefElement);
    if ParentVolume<>nil then
      VolumeBuilder.CheckHAreas(ParentVolume, Volume, BuildDirection, False);
    DMOperationManager.UpdateElement(aRefElement);
  end;

  function CheckBuildDirection(aBuildDirection:integer):boolean;
  var
    SelectedAreaListCount, j:integer;
    Area:IArea;
  begin
    Result:=True;
    SelectedAreaListCount:=SelectedAreaList.Count;
    j:=0;
    while j<SelectedAreaListCount do begin
      Area:=IDMElement(SelectedAreaList[j]) as IArea;
      if ((aBuildDirection=bdUp)  and
          ((Area.Volume0=nil) or (Area.Volume0.BottomAreas.Count>1))) or
         ((aBuildDirection=bdDown) and
           ((Area.Volume1=nil) or (Area.Volume1.TopAreas.Count>1))) then
        Exit
      else
        inc(j)
    end;
    Result:=False;
  end;

var
  EnabledBuildDirection:integer;
  DataModel:IDataModel;
  GlobalData:IGlobalData;
  OldState, OldSelectState:integer;
begin
  if FDone then Exit;

  DMDocument:=SMDocument as IDMDocument;

  VolumeBuilder:=SMDocument as IVolumeBuilder;

  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    FDone:=True;
    Exit;
  end;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel2:=DataModel as ISpatialModel2;

  if DMDocument.SelectionCount=0 then Exit;

  SelectedAreaList:=SMDocument.SelectedAreaList;
  if SelectedAreaList.Count=0 then Exit;

  BaseAreas:=TDMCollection.Create(nil) as IDMCollection;
  BaseAreas2:=BaseAreas as IDMCollection2;

  EnabledBuildDirection:=0;
  if CheckBuildDirection(bdUp) then
    EnabledBuildDirection:=EnabledBuildDirection or 1;
  if CheckBuildDirection(bdDown) then
    EnabledBuildDirection:=EnabledBuildDirection or 2;
  SpatialModel2.EnabledBuildDirection:=EnabledBuildDirection;

  if EnabledBuildDirection=0 then Exit;

  OldState:=DMDocument.State;
  OldSelectState:=OldState and dmfSelecting;
  DMDocument.State:=DMDocument.State or dmfSelecting;
  try

  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;
  VolumeE:=nil;
  N:=1;

  DMOperationManager.StartTransaction(nil, leoAdd, rsBuildVolume);
  ClassID:=_Volume;

  if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
    GlobalData.GlobalValue[1]:=0;
    GlobalData.GlobalValue[2]:=0;
    GlobalData.GlobalIntf[1]:=nil;
  end;

  if not SMDocument.CreateRefElement(ClassID, OperationCode, nil,
                  aRefElement, RefParent, True) then begin
    DMDocument.State:=DMDocument.State and not dmfSelecting or OldSelectState;
    DMDocument.ClearSelection(nil);
    Exit;
  end else
    BuildDirection:=SpatialModel2.BuildDirection;

  if RefParent<>nil then begin
    ParentVolumeE:=RefParent.SpatialElement;
    ParentVolume:=ParentVolumeE as IVolume;
  end;

  AreaList:=TList.Create;

  Height:=SpatialModel2.DefaultVolumeHeight*100;
  if SpatialModel2.BuildJoinedVolume then begin
    while SelectedAreaList.Count<>0 do begin
      BaseAreaE:=IDMElement(SelectedAreaList[0]);
      Area:=BaseAreaE as IArea;
      SelectedAreaList.Delete(0);
      if ((BuildDirection=bdUp)  and
          ((Area.Volume0=nil) or (Area.Volume0.BottomAreas.Count>1))) or
         ((BuildDirection=bdDown) and
           ((Area.Volume1=nil) or (Area.Volume1.TopAreas.Count>1))) then begin
        BaseAreas2.Add(BaseAreaE);
      end;
    end;

    VolumeE:=VolumeBuilder.BuildVolume(BaseAreas, Height,
                 BuildDirection, ParentVolume, True);
    ProceedVolume(VolumeE, RefParent);
    VolumeE.Draw(Painter, 0);
  end else begin
    while DMDocument.SelectionCount>0 do begin
      aElement:=DMDocument.SelectionItem[DMDocument.SelectionCount-1] as IDMElement;
      aElement.Selected:=False;  // ClearSelection использовать нельзя,
    end;                         // т.к. там вызывается ClearSelectedAreaList

    SelectedAreaListCount:=SelectedAreaList.Count;
    while SelectedAreaList.Count<>0 do begin
      BaseAreaE:=IDMElement(SelectedAreaList[0]);
      BaseAreaE.Selected:=True;
      Area:=BaseAreaE as IArea;
      SelectedAreaList.Delete(0);
      if ((BuildDirection=bdUp)  and
          ((Area.Volume0=nil) or (Area.Volume0.BottomAreas.Count>1))) or
         ((BuildDirection=bdDown) and
           ((Area.Volume1=nil) or (Area.Volume1.TopAreas.Count>1))) then begin

        if SelectedAreaListCount>1 then begin
          Area.GetCentralPoint(PX, PY, PZ);
          SpatialModel2.GetRefElementParent(ClassID, OperationCode, PX, PY, PZ, RefParent,
                           DMClassCollections, RefSource, aCollection);

          if RefParent<>nil then begin
            ParentVolumeE:=RefParent.SpatialElement;
            ParentVolume:=ParentVolumeE as IVolume;
          end;
        end;

        BaseAreas2.Clear;
        BaseAreas2.Add(BaseAreaE);
        VolumeE:=VolumeBuilder.BuildVolume(BaseAreas, Height,
                 BuildDirection, ParentVolume, True);
        ProceedVolume(VolumeE, RefParent);
        BaseAreaE.Selected:=False;

        VolumeE.Draw(Painter, 0);
      end;
    end;
  end;  //while SelectedAreaList.Count<>0


  DMDocument.ClearSelection(nil);

  AreaList.Free;

  SpatialModel2.UpdateVolumes;

  finally
    DMDocument.State:=DMDocument.State and not dmfSelecting or OldSelectState;
  end;
  if VolumeE<>nil then
    SMDocument.SetDocumentOperation(VolumeE, nil,
                          leoAdd, -1);
  CurrentStep:=-2;
  FDone:=True;
end;

{ TBuildLineObjectOperation }

const
    loBoundary0=11;
    loZone0    =12;
    loBoundary1=13;
    loZone1    =14;
    loWidth    =15;

procedure TBuildLineObjectOperation.Execute(const SMDocument: TCustomSMDocument;
                                                            ShiftState: integer);
var
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  aRefElement, RefParent, VolumeRef:IDMElement;
  Area0E, Area1E:IDMElement;
  aList:TList;
  ClassID:integer;
  Volume:IVolume;
  Line:ILine;
  C0, C1:ICoordNode;
  X, Y, Z:double;
  GlobalData:IGlobalData;

  Procedure FindParent(const Volume:IVolume);
    var
      j,y:integer;
      NextParent:IDMElement;
    begin
      if Volume=nil then Exit;
      NextParent:=(Volume as IDMElement).Ref;
       repeat
           y:=-1;
           for j:=0 to aList.Count-1 do
             if Pointer(NextParent)=aList[j] then
               y:=j;
           if y<>-1 then Break;
           NextParent:=NextParent.Parent;
       until (y>-1) or (NextParent=nil);

       for j:=y-1 downto 0 do
           aList.Delete(j);
    end;

begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  DMOperationManager:=SMDocument as IDMOperationManager;

  FDivideAreaFlag:=False;

  if CurrentStep=0 then begin
     SMDocument.BreakLineInSnapNode:=False;
     inherited;
     SMDocument.BreakLineInSnapNode:=True;

     if FNLine=nil then
       FArea0:=nil
     else
       FArea0:=FNLine.GetVerticalArea(bdUp);
  end else begin
    SMDocument.BreakLineInSnapNode:=False;
    inherited;
    SMDocument.BreakLineInSnapNode:=True;

     if FNLine=nil then
       FArea1:=nil
     else
       FArea1:=FNLine.GetVerticalArea(bdUp);

     ClassID:=_Line;

      if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
        GlobalData.GlobalValue[1]:=0;
        GlobalData.GlobalValue[2]:=0;
        GlobalData.GlobalIntf[1]:=nil;
      end;

     if SMDocument.CreateRefElement(ClassID, OperationCode, nil,
              aRefElement, RefParent, True) then begin
       FLineE.Ref:=aRefElement;
       Line:=FLineE as ILine;
       C0:=Line.C0;
       C1:=Line.C1;

       X:=C0.X;
       Y:=C0.Y;
       Z:=C0.Z;
       if FArea0<>nil then begin
         Area0E:=FArea0 as IDMElement;
         aRefElement.SetFieldValue(loBoundary0, Area0E.Ref as IUnknown);
{
         if C1.X>C0.X then
           X:=X+1
         else
           X:=X-1;

         if C1.Y>C0.Y then
           Y:=Y+1
         else
           Y:=Y-1;

         if C1.Z>C0.Z then
           Z:=Z+1
         else
           Z:=Z-1;

         if FArea0.Volume0=nil then
           Volume:=FArea0.Volume1
         else if FArea0.Volume1=nil then
           Volume:=FArea0.Volume0
         else begin
           Volume:=FArea0.Volume1;
           if Volume=SpatialModel2.GetVolumeContaining(X, Y, Z) then
             Volume:=FArea0.Volume0;
         end;
}
         Volume:=nil;
       end else begin
         Volume:=SpatialModel2.GetVolumeContaining(X, Y, Z);
       end;

       if Volume=nil then
         VolumeRef:=nil
       else
         VolumeRef:=(Volume as IDMElement).Ref;

       aRefElement.SetFieldValue(loZone0, VolumeRef);

       X:=C1.X;
       Y:=C1.Y;
       Z:=C1.Z;
       if FArea1<>nil then begin
         Area1E:=FArea1 as IDMElement;
         aRefElement.SetFieldValue(loBoundary1, Area1E.Ref as IUnknown);
{
         if C0.X>C1.X then
           X:=X+1
         else
           X:=X-1;

         if C0.Y>C1.Y then
           Y:=Y+1
         else
           Y:=Y-1;

         if C0.Z>C1.Z then
           Z:=Z+1
         else
           Z:=Z-1;

         if FArea1.Volume0=nil then
           Volume:=FArea1.Volume1
         else if FArea1.Volume1=nil then
           Volume:=FArea1.Volume0
         else begin
           Volume:=FArea1.Volume1;
           if Volume=SpatialModel2.GetVolumeContaining(X, Y, Z) then
             Volume:=FArea1.Volume0;
         end;
}
         Volume:=nil;
       end else begin
         Volume:=SpatialModel2.GetVolumeContaining(X, Y, Z);
       end;

       if Volume=nil then
         VolumeRef:=nil
       else
         VolumeRef:=(Volume as IDMElement).Ref;

       aRefElement.SetFieldValue(loZone1, VolumeRef);

       aRefElement.SetFieldValue(loWidth, SpatialModel2.DefaultObjectWidth);

       SMDocument.AfterRefElementCreation(aRefElement);

       aRefElement.Draw(Painter, 0);

     SMDocument.SetDocumentOperation(aRefElement, nil,
                          leoAdd, -1);
     end else
       DMOperationManager.Undo;
  end;
end;

procedure TBuildLineObjectOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  case CurrentStep of
  -1, 0:
    begin
      Hint:='СОЗДАНИЕ ПЕРЕХОДОВ МЕЖДУ ЗОНАМИ: Укажите точку входа в переход';
      ACursor:=cr_Pen_Stairs;
    end;
  1:begin
      Hint:='СОЗДАНИЕ ПЕРЕХОДОВ МЕЖДУ ЗОНАМИ: Укажите точку выхода из перехода (CTRL -  строить параллельно сторонам экрана)';
      ACursor:=cr_Pen_Stairs;
    end;
  else
    inherited
  end;
end;

{ TDivideVolumeOperation }

function TDivideVolumeOperation.GetModelCheckFlag: boolean;
begin
  Result:=True
end;

procedure TDivideVolumeOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='ДЕЛЕНИЕ ЗОНЫ ПО ВЕРТИКАЛИ: Укажите разбиваемую зону (SHIFT - выделение рамкой, CTRL - добавить к выделению, F6 - выполнить операцию)';
  ACursor:=cr_Build_DivV;
end;

procedure TDivideVolumeOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState:integer);
var
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  VolumeBuilder:IVolumeBuilder;
  N, j, VDivideKind:integer;
  aVolumeE,
  NewVolumeE:IDMElement;
  aVolume:IVolume;
  Height:double;
  LineList, VolumeList:TList;
  RefParent:IDMElement;
  aCaption, aPrompt:WideString;
  NewVolumes:IDMCollection;
  NewVolumes2:IDMCollection2;

  TmpList:TList;
  RefElement:IDMELement;
begin
  if FDone then Exit;

  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    FDone:=True;
    Exit;
  end;

  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  if DMDocument.SelectionCount=0 then Exit;
  if DMDocument.SelectionItem[0].QueryInterface(IVolume, aVolume)<>0 then Exit;

  DMOperationManager:=SMDocument as IDMOperationManager;
  VolumeBuilder:=SMDocument as IVolumeBuilder;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  LineList:=TList.Create;
  TmpList:=TList.Create;

  Server:=DMDocument.Server;
  aCaption:=rsDivideVolume;
  aPrompt:=rsSubVolumeHeight;
  Server.EventData1:=(aVolume.MaxZ-aVolume.MinZ)/2/100;
  Server.EventData3:=0;
  Server.CallDialog(sdmVDivideVolume, aCaption, aPrompt);
  if Server.EventData3=-1 then Exit;
  VDivideKind:=Server.EventData3;

  Height:=Server.EventData1*100;
  if VDivideKind=0 then begin
    N:=2;
  end else begin
    N:=Server.EventData1;
    if N=0 then Exit;
  end;

  DMOperationManager.StartTransaction(nil, leoAdd, rsDivideVolume);
  VolumeList:=TList.Create;

  while DMDocument.SelectionCount>0 do begin
    aVolumeE:=DMDocument.SelectionItem[0] as IDMElement;
    VolumeList.Add(pointer(aVolumeE));
    aVolumeE.Selected:=False;
  end;

  NewVolumes:=TDMCollection.Create(nil) as IDMCollection;
  NewVolumes2:=NewVolumes as IDMCollection2;

  DMDocument.Server.EventData3:=0;
  DMDocument.Server.CallDialog(sdmPleaseWait, '', 'Деление зон по вертикали');

  try
  for j:=0 to VolumeList.Count-1 do begin
    aVolumeE:=IDMElement(VolumeList[j]);
    aVolume:=aVolumeE as IVolume;

    RefElement:=DMOperationManager.CreateClone(aVolumeE.Ref) as IDMElement;
    RefParent:=aVolumeE.Ref.Parent;

    if VDivideKind=1 then
      Height:=(aVolume.MaxZ-aVolume.MinZ)/N;

    SMDocument.DivideVolume(aVolume, Height, ShiftState,
                         N, bdUp, bdUp, True,  RefElement,
                         RefParent, NewVolumes);
  end; // for j:=0 to VolumeList.Count-1
  finally
    DMDocument.Server.EventData3:=-1;  // закрыть диалог
    DMDocument.Server.CallDialog(sdmPleaseWait, '', '');
  end;

  SpatialModel2.UpdateVolumes;

  LineList.Free;
  TmpList.Free;
  VolumeList.Free;
  SMDocument.SetDocumentoperation(NewVolumeE, nil, leoAdd, -1);
  CurrentStep:=-2;
  FDone:=True;
end;

{ TBuildArrayObjectOperation }

procedure TBuildArrayObjectOperation.Drag(
  const SMDocument: TCustomSMDocument);
var
  OldSnapMode:integer;
begin
  OldSnapMode:=SMDocument.SnapMode;
  SMDocument.SnapMode:=smoSnapNone;
  inherited;
  SMDocument.SnapMode:=OldSnapMode;
end;

procedure TBuildArrayObjectOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  DMDocument:IDMDocument;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  aRefElement, RefParent:IDMElement;
  Collection2:IDMCollection2;
  Line:ILine;
  OldSnapMode:integer;
  ClassID:integer;
  DataModel:IDataModel;
  GlobalData:IGlobalData;
begin
  OldSnapMode:=SMDocument.SnapMode;
  SMDocument.SnapMode:=smoSnapNone;

  case CurrentStep of
  0: inherited;
  1: begin
       inherited;
       Line:=FLineE as ILine;
       DMDocument:=SMDocument as IDMDocument;
       DMOperationManager:=SMDocument as IDMOperationManager;
       DataModel:=DMDocument.DataModel as IDataModel;
       Painter:=SMDocument.PainterU as IPainter;
       Collection2:=TDMCollection.Create(nil) as IDMCollection2;
       Collection2.Add(Line.C0 as IDMElement);
       ClassID:=_Line;
        if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
          GlobalData.GlobalValue[1]:=0;
          GlobalData.GlobalValue[2]:=0;
          GlobalData.GlobalIntf[1]:=nil;
        end;

       if SMDocument.CreateRefElement(ClassID, OperationCode,
              Collection2 as IDMCollection, aRefElement, RefParent, True) then begin
         Collection2.Clear;
         if aRefElement=nil then begin
           DMOperationManager.Undo;
           SMDocument.SnapMode:=OldSnapMode;
           Exit;
         end;
         FLineE.Ref:=aRefElement;
         DMOperationManager.ChangeParent( nil, RefParent, aRefElement);
         aRefElement.Draw(Painter, 0);
         CurrentStep:=-1;

         SMDocument.SetDocumentOperation(aRefElement, nil,
                          leoAdd, -1);
       end;
     end else
       DMOperationManager.Undo;
  end;
  SMDocument.SnapMode:=OldSnapMode;
end;

procedure TBuildArrayObjectOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  case CurrentStep of
  -1, 0:
    begin
      Hint:='Укажите точку размещения объекта';
      ACursor:=cr_Pen_Sensor;
    end;
  1:begin
      Hint:='Укажите направление оси области действия (CTRL - строить параллельно сторонам экрана)';
      ACursor:=cr_Pen_Sensor;
    end;
  else
    inherited
  end;
end;

{ TBuildPolylineObjectOperation }

procedure TBuildPolylineObjectOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
   case CurrentStep of
    -1, 0:
       begin
         Hint:='Укажите начальную точку';
         ACursor:=cr_Build_Road;
       end;
    1:begin
        Hint:='Укажите следующую точку (CTRL - строить параллельно сторонам экрана, F6 - создать объект)';
         ACursor:=cr_Build_Road;
      end;
    else
      inherited
   end;
end;

procedure TBuildPolylineObjectOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState:integer);
var
  DMDocument:IDMDocument;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  LineE, PolylineE, aRefElement, RefParent,  ParentElement:IDMElement;
  PolyLineU:IUnknown;
  OldState, OldSelectState, ClassID:integer;
  DataModel:IDataModel;
  GlobalData:IGlobalData;
begin
  if FDone then Exit;

  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    FDone:=True;
    Exit;
  end;

  DMDocument:=SMDocument as IDMDocument;
  DataModel:=DMDocument.DataModel as IDataModel;
  if DMDocument.SelectionCount=0 then Exit;

  LineE:=DMDocument.SelectionItem[0] as IDMElement;
  if LineE.ClassID<>_Line then Exit;

  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;

  DMOperationManager.StartTransaction(nil, leoAdd, rsBuildPolylineObject);
  ClassID:=_Polyline;
  if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
    GlobalData.GlobalValue[1]:=0;
    GlobalData.GlobalValue[2]:=0;
    GlobalData.GlobalIntf[1]:=nil;
  end;

  if not SMDocument.CreateRefElement(ClassID, OperationCode, nil,
             aRefElement, RefParent, True) then Exit;

  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  if ClassID=_Polyline then
    DMOperationManager.AddElement( LineE.Parent,
                            SpatialModel.PolyLines, '', ltOneToMany, PolyLineU, True)
  else
  if ClassID=_LineGroup then
    DMOperationManager.AddElement( LineE.Parent,
                            SpatialModel.LineGroups, '', ltOneToMany, PolyLineU, True)
  else
    Exit;
  PolyLineE:=PolyLineU as IDMElement;
  PolylineE.Ref:=aRefElement;

  OldState:=DMDocument.State;
  OldSelectState:=OldState and dmfSelecting;
  DMDocument.State:=DMDocument.State or dmfSelecting;
  try
  while DMDocument.SelectionCount<>0 do begin
    LineE:=DMDocument.SelectionItem[0] as IDMElement;
    LineE.Selected:=False;
    LineE.AddParent(PolyLineE);
  end;
  DMOperationManager.UpdateElement(PolyLineE);
  finally
    DMDocument.State:=DMDocument.State and not dmfSelecting or OldSelectState;
  end;

  if RefParent<>nil then
    DMOperationManager.ChangeParent( nil, RefParent, aRefElement )
  else begin
    ParentElement:=(DMDocument.DataModel as IDataModel).GetDefaultParent(aRefElement.ClassID);
    DMOperationManager.ChangeParent( nil, ParentElement, aRefElement );
  end;
  aRefElement.Draw(Painter, 0);

  DMDocument.Server.SelectionChanged(PolylineE);
  SMDocument.SetDocumentOperation(aRefElement, nil,
                          leoAdd, -1);
  DMDocument.State:=DMDocument.State and not dmfSelecting or OldSelectState;
  CurrentStep:=-2;
  FDone:=True;
end;

{ TOutlineSelectedOperation }

procedure TOutlineSelectedOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='УДВОЕНИЕ КОНТУРА: Укажите дублируемые линии (SHIFT - выделение рамкой, CTRL - добавить к выделению, F6 - выполнить операцию)';
  ACursor:=cr_Tool_Out;
end;

procedure TOutlineSelectedOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  DMDocument:IDMDocument;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  j:integer;
  aCaption, aPrompt:string;
  NewLineE:IDMElement;
  NewLinesList:TList;

  procedure BuildNodesList(LinesList, NodesList:TList);
  var
   j,aCount:integer;
   aLine1:ILine;


  var
   m:integer;
   aElement:IDMElement;
   Line:ILine;
   Polyline:IPolyline;
  begin
     aCount:=DMDocument.SelectionCount;
     if aCount=0 then Exit;

     aElement:=DMDocument.SelectionItem[0] as IDMElement;
                                    {DMDocument.Selection -->  LinesList}
     if aElement.QueryInterface(ILine, Line)=0 then begin
       for j:=0 to aCount-1 do begin
          aLine1:=DMDocument.SelectionItem[j] as ILine;
          LinesList.Add(pointer(aLine1));
       end;
     end else
     if aElement.QueryInterface(IPolyLine, PolyLine)=0 then begin
       for j:=0 to aCount-1 do begin
          PolyLine:=DMDocument.SelectionItem[j] as IPolyLine;
          for m:=0 to PolyLine.Lines.Count-1 do begin
            aLine1:=PolyLine.Lines.Item[m] as ILine;
            LinesList.Add(pointer(aLine1));
          end;
       end
     end else
       Exit;

  end;


  var
   k:integer;
   Value:string;
   L:double;
   LinesList, NodesList:TList;
begin
  if FDone then Exit;

  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    FDone:=True;
    Exit;
  end;                           

  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  if DMDocument.SelectionCount=0 then Exit;
  DMOperationManager:=SMDocument as IDMOperationManager;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;

  aCaption:=rsOutline;
  aPrompt:=rsOutLineShift;
  Value:='5';
  if not InputQuery(aCaption,aPrompt,Value) then Exit;
  val(value,L,k);
  if k <> 0 then
    MessageDlg('ошибка в поз.: ' + IntToStr(k), mtWarning, [mbOk], 0)
  else
    L:=L*100;

  DMOperationManager.StartTransaction(nil, leoAdd, rsOutline);

//  aElement:=DMDocument.SelectionItem[0] as IDMElement;

  NodesList:=TList.Create;       {Info обрабат-x точек}
  LinesList:=TList.Create;       {List обрабат-x Line}
  NewLinesList:=TList.Create;               {NewList сп.построенных New Line}

  BuildNodesList(LinesList,NodesList);      //создать списки выдел.линий и точек

  BuildOutline(LinesList,NodesList, NewLinesList, L, SpatialModel, DMOperationManager);


  for j:=0 to NewLinesList.Count-1 do begin
   NewLineE:=ILine(NewLinesList[j]) as IDMElement;
   NewLineE.Draw(Painter, 0);
  end;

  FDone:=True;
  CurrentStep:=-2;

  LinesList.Free;
  NodesList.Free;
end;

procedure MoveAreas(const DestVolume, SourceVolume:IVolume;
                    aArea, CuttingArea:IArea);
var
  DestVolumeE, SourceVolumeE, aAreaE, CuttingAreaE, NextAreaE:IDMElement;
  aAreaP, CuttingAreaP:IPolyline;
  aLineE:IDMElement;
  NextArea:IArea;
  j, m:integer;
begin
  try
  DestVolumeE:=DestVolume as IDMElement;
  SourceVolumeE:=SourceVolume as IDMElement;
  aAreaE:=aArea as IDMElement;
  CuttingAreaE:=CuttingArea as IDMElement;
  aAreaP:=aArea as IPolyline;
  CuttingAreaP:=CuttingArea as IPolyline;

  if aArea.Volume0=SourceVolume then
    aArea.Volume0:=DestVolume
  else
    aArea.Volume1:=DestVolume;
  for j:=0 to aAreaP.Lines.Count-1 do begin
    aLineE:=aAreaP.Lines.Item[j];
    if CuttingAreaP.Lines.IndexOf(aLineE)=-1 then begin
      m:=0;
      while m<aLineE.Parents.Count do begin
        NextAreaE:=aLineE.Parents.Item[m];
        if (NextAreaE.QueryInterface(IArea, NextArea)=0) and
           (NextAreaE<>aAreaE) and
           (SourceVolume.Areas.IndexOf(NextAreaE)<>-1) then
          MoveAreas(DestVolume, SourceVolume, NextArea, CuttingArea)
        else
          inc(m)
      end;
    end;
  end;
  except
    raise
  end;
end;


function TBuildVerticalAreaOperation.GetModelCheckFlag: boolean;
begin
  Result:=True
end;

procedure TBuildVerticalAreaOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='ДЕЛЕНИЕ ЗОНЫ ПО ГОРИЗОНТАЛИ: Укажите линии в основании рубежа (SHIFT - выделение рамкой, CTRL - добавить к выделению, F6 - выполнить операцию)';
  ACursor:=cr_Build_DivH;
end;

procedure TBuildVerticalAreaOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState:integer);
var
  aDocument:IDMDocument;
  aElement:IDMElement;
  aElementS:ISpatialElement;
  aSelectionCount:integer;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  aCurrentCollection, BLinesCol:IDMCollection;
  BLineGroupList:TList;
  aLines2:IDMCollection;
  DMOperationManager:IDMOperationManager;
  aLineE:IDMElement;
  aRefElement:IDMElement;
  aLine:ILine;
  j:integer;
  OldState, OldSelectState:integer;
  aLinesCount:integer;

  SpatialModel:ISpatialModel;
  BuildDirection:integer;
  DataModel:IDataModel;

   function VerticalAreaPresenceCheck(const Lines:IDMCollection;
                                            Direction:integer):boolean ;
   var
    j:integer;
    aLine:ILine;
   begin
    Result:=True;

    for j:=0 to Lines.Count-1 do begin
     aLine:=Lines.Item[j] as ILine;
     if aLine.GetVerticalArea(Direction)<>nil then begin
      Result:=False;
      break;
     end;
    end; //for j

   end; //function


begin
  if FDone then Exit;

  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    FDone:=True;
    Exit;
  end;

  aDocument:=SMDocument as IDMDocument;
  aSelectionCount:= aDocument.SelectionCount;
  if aSelectionCount=0 then Exit;

  BLineGroupList:=TList.Create;

  DMOperationManager:=SMDocument as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsBuildVerticalArea);
//___________
//  if aSelectionCount>1 then begin;
  BLinesCol:=TDMCollection.Create(nil) as IDMCollection;
  aLines2:=TDMCollection.Create(nil) as IDMCollection;
  for j:=0 to aSelectionCount-1 do begin
   aElement:=aDocument.SelectionItem[j] as IDMElement;
   if aElement.QueryInterface(ISpatialElement, aElementS)<>0 then  Exit;
   if aElement.Parents.Count<2 then Exit;
   if aElement.QueryInterface(ILine, aLine)=0 then begin
     aLineE:=aLine as IDMElement;
     (BLinesCol as IDMCollection2).Add(aLineE);
   end else
     Exit;
  end;

  OldState:=aDocument.State;
  OldSelectState:=aDocument.State and dmfSelecting;
  aDocument.State:=aDocument.State or dmfSelecting;
  try
  Painter:=SMDocument.PainterU as IPainter;
  DataModel:=aDocument.DataModel as IDataMOdel;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;

  BuildDirection:=0;
  SpatialModel2.BuildDirection:=BuildDirection;
  SpatialModel2.EnabledBuildDirection:=1;

  SMDocument.ReorderGroupLines(BLinesCol,aLines2);

     {разбить PolyLine на отрезки (Lines), замыкающие по одному объему}
  if SMDocument.PolyLine_IsClosedVolume(BLinesCol,BLineGroupList)then begin
   if BLineGroupList<>nil then begin
//__________
     aLinesCount:=BLinesCol.Count;
     if aLinesCount=0 then begin
       aDocument.State:=OldState;
       Exit;
     end;

     aRefElement:=nil;

     for j:=0 to BLineGroupList.Count-1 do begin
       aCurrentCollection:=IDMCollection(BLineGroupList[j]);

       if not VerticalAreaPresenceCheck(aCurrentCollection, BuildDirection) then begin
         aDocument.State:=OldState;
         CurrentStep:=-1;
         Continue;
       end else
       if SMDocument.PolyLine_BuildVerticalArea(aCurrentCollection,
             OperationCode, BuildDirection, aRefElement)=nil then begin
         aDocument.State:=OldState;
         CurrentStep:=-1;
         Exit;
       end;
       aCurrentCollection._Release;
     end; //for j:=0 to Lines.Count-1
   end; // if Lines<>nil

   SpatialModel2.UpdateVolumes;

  end else begin
   CurrentStep:=-1;
   Exit;
  end; // if SMDocument.PolyLine_IsClosedVolume(

  finally
    BLineGroupList.Free;
    aDocument.State:=aDocument.State and not dmfSelecting or OldSelectState
  end;
  CurrentStep:=-2;
end;

function CreateArea(const aCollection: IDMCollection;
                        const DMOperationManager:IDMOperationManager;
                        const SpatialModel2:ISpatialModel2):IDMElement;
var
  LineE:IDMElement;
  AreaU:IUnknown;
  j:integer;
begin
  if aCollection.Count=0 then Exit;
  LineE:=aCollection.Item[0];
  DMOperationManager.AddElement( LineE.Parent,
                         SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
  Result:=AreaU as IDMElement;
  for j:=0 to aCollection.Count-1 do begin
    LineE:=aCollection.Item[j];
    DMOperationManager.AddElementParent( Result, LineE);
  end;
end;

procedure CreateVolumeAreaRefElements(const SMDocument: TCustomSMDocument;
                                          const VolumeE, RefParent:IDMElement;
                                          ChangeRefFlag, BaseVolumeFlag:WordBool);
var
  DMDocument:IDMDocument;
  SpatialModel2:ISpatialModel2;
  DMOperationManager:IDMOperationManager;
  j:integer;
  Volume:IVolume;
  AreaRef, aAreaRefRef, AreaRefRef, AreaE, LayerKindE:IDMElement;
  aName:WideString;
  aCollection:IDMCollection;
  Painter:IPainter;
  AreaRefU:IUnknown;
  Area:IArea;
  DataModel:IDataModel;
begin
  DMDocument:=SMDocument as IDMDocument;
  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel2:=DataModel as ISpatialModel2;
  Volume:=VolumeE as IVolume;

  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 0, BaseVolumeFlag,
                        aCollection, aName, aAreaRefRef);
  if aAreaRefRef<>nil then begin
    for j:=0 to Volume.BottomAreas.Count-1 do begin
      AreaE:=Volume.BottomAreas.Item[j];
      Area:=AreaE as IArea;
      AreaRef:=AreaE.Ref;
      AreaRefRef:=aAreaRefRef;

      aName:=Format('%s %s%s',[DataModel.GetDefaultName(AreaRefRef),
                           SuffixDivider, VolumeE.Name]);
      if AreaRef=nil then begin
        DMOperationManager.AddElementRef(
                    nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaRefU, True);
        AreaRef:=AreaRefU as IDMElement;
        AreaE.Ref:=AreaRef;
        AreaRef.Draw(Painter,0);
      end else
      if (Area.Volume1=nil) or
        (AreaRef.Ref=nil) then begin
        DMOperationManager.ChangeRef(nil, aName, AreaRefRef, AreaRef);
        DMOperationManager.UpdateCoords(AreaE);
        AreaRef.Draw(Painter,0);
      end;
    end;
  end;

  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 1, BaseVolumeFlag,
                           aCollection, aName, aAreaRefRef);
  if aAreaRefRef<>nil then begin
    for j:=0 to Volume.TopAreas.Count-1 do begin
      AreaE:=Volume.TopAreas.Item[j];
      Area:=AreaE as IArea;
      AreaRef:=AreaE.Ref;
      AreaRefRef:=aAreaRefRef;

      aName:=Format('%s %s%s',[DataModel.GetDefaultName(AreaRefRef),
                           SuffixDivider, VolumeE.Name]);
      if AreaRef=nil then begin
        DMOperationManager.AddElementRef(
                  nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaRefU, True);
        AreaRef:=AreaRefU as IDMElement;
        AreaE.Ref:=AreaRef;
        AreaRef.Draw(Painter,0);
      end else
      if (Area.Volume0=nil) or
         (AreaRef.Ref=nil) then begin
        DMOperationManager.ChangeRef(nil, aName, AreaRefRef, AreaRef);
        DMOperationManager.UpdateCoords(AreaE);
        AreaRef.Draw(Painter,0);
      end;
    end;
  end;

  SpatialModel2.GetDefaultAreaRefRef(VolumeE, 2, BaseVolumeFlag,
                           aCollection, aName, aAreaRefRef);
  if aAreaRefRef<>nil then begin
    for j:=0 to Volume.Areas.Count-1 do begin
      AreaE:=Volume.Areas.Item[j];
      Area:=AreaE as IArea;
      AreaRef:=AreaE.Ref;
      if Area.IsVertical then begin

        LayerKindE:=AreaE.Parent.Ref;
        if LayerKindE=nil then
          AreaRefRef:=aAreaRefRef
        else
          AreaRefRef:=LayerKindE;

        aName:=Format('%s %s%s',[DataModel.GetDefaultName(AreaRefRef),
                           SuffixDivider, VolumeE.Name]);
        if AreaRef=nil then begin
          DMOperationManager.AddElementRef(
                  nil, aCollection, aName, AreaRefRef, ltOneToMany, AreaRefU, True);
          AreaRef:=AreaRefU as IDMElement;
          AreaE.Ref:=AreaRef;
          DMOperationManager.UpdateCoords(AreaE);
          AreaRef.Draw(Painter,0);
        end else
        if ChangeRefFlag  or
          (AreaRef.Ref=nil) then begin
          DMOperationManager.ChangeRef(nil, aName, AreaRefRef, AreaRef);
          DMOperationManager.UpdateCoords(AreaE);
          AreaRef.Draw(Painter,0);
        end;
      end;
    end;
  end;
//  DMOperationManager.ChangeParent( nil, RefParent, VolumeE.Ref);
       //нужно обновить границы у Parent
end;


{ TBuildAreaOperation }

procedure TBuildAreaOperation.GetStepHint(aStep: integer; var Hint: string;
  var ACursor: integer);
begin
  Hint:='СОЗДАНИЕ ПЛОСКОСТИ: Укажите замкнутый контур (F6 - создать объект)';
  ACursor:=cr_Hand_HArea;
end;

procedure TBuildAreaOperation.Stop(const SMDocument: TCustomSMDocument;
  ShiftState: integer);
var
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  AreaS:ISpatialElement;
  Unk, AreaU:IUnknown;
  DataModel:IDataModel;
  LineE:IDMElement;
  S:string;
  j, Color, OldState, OldSelectState:integer;
  Server:IDataModelServer;
begin
  if FDone then Exit;

  DMDocument:=SMDocument as IDMDocument;

  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    FDone:=True;
    Exit;
  end;
  DataModel:=DMDocument.DataModel as IDataModel;
  SpatialModel2:=DataModel as ISpatialModel2;

  if SMDocument.SelectedAreaList.Count=0 then Exit;
  if DMDocument.SelectionCount=0 then Exit;
  if DMDocument.SelectionCount<3 then Exit;
  if DMDocument.SelectionItem[0].QueryInterface(ILine, Unk)<>0 then Exit;
  LineE:=Unk as IDMElement;

  Server:=DMDocument.Server;
  Server.EventData3:=-1;
  Server.CallDialog(sdmColorInput,'', '');
  if Server.EventData3=-1 then begin
    Exit;
  end;  
  Color:=Server.EventData3;

  OldState:=DMDocument.State;
  OldSelectState:=OldState and dmfSelecting;
  DMDocument.State:=DMDocument.State or dmfSelecting;
  try

  DMOperationManager:=SMDocument as IDMOperationManager;
  Painter:=SMDocument.PainterU as IPainter;

  DMOperationManager.StartTransaction(nil, leoAdd, rsBuildArea);

  S:=LineE.Parent.Name+' '+IntToStr(SpatialModel2.Areas.Count);
  DMOperationManager.AddElement(LineE.Parent, SpatialModel2.Areas, S, ltOneToMany, AreaU, True);
  for j:=0 to DMDocument.SelectionCount-1 do begin
    LineE:=DMDocument.SelectionItem[j] as IDMElement;
    DMOperationManager.AddElementParent(AreaU, LineE);
  end;

  AreaS:=AreaU as ISpatialElement;
  AreaS.Color:=Color;

  DMDocument.ClearSelection(nil);

  finally
    DMDocument.State:=DMDocument.State and not dmfSelecting or OldSelectState;
  end;
  CurrentStep:=-2;
  FDone:=True;
end;

end.
