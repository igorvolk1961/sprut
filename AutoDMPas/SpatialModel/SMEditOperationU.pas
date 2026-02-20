unit SMEditOperationU;

interface
uses
   Classes,  Math, Variants, SysUtils,
   SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB, PainterLib_TLB,
   DMElementU, SMOperationU, SMSelectOperationU, CustomSMDocumentU, SMOperationConstU;

type
  TSMEditOperation=class(TSMOperation)
  private
  public
  end;

  TDeleteSelectedOperation=class(TSMEditOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TBreakLineOperation=class(TSMEditOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TDoubleBreakLineOperation=class(TSMEditOperation)
  private
    FDistance:double;
    procedure SetDistance(const Value: double);
  public
    property Distance:double read FDistance write SetDistance;
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TTrimExtendToSelectedOperation=class(TSMEditOperation)
  private
  public
    procedure Execute(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  TIntersectSelectedOperation=class(TSelectLineOperation)
  private
  public
    procedure Stop(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

  implementation
uses
  SpatialModelConstU, Geometry, DMUtils;

{ TDeleteSelectedOperation }

procedure TDeleteSelectedOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);

var
  DMOperationManager:IDMOperationManager;

      procedure JoinAreas(const Area0, Area1:IArea; const Line:ILine);

        function NodeConnecting(const Line0, Line1:ILine):ICoordNode;
        begin
          if (Line0.C0=Line1.C0) or
             (Line0.C0=Line1.C1) then
            Result:=Line0.C0
          else
          if (Line0.C1=Line1.C0) or
             (Line0.C1=Line1.C1) then
            Result:=Line0.C1
          else
            Result:=nil;
        end;

      var
        k1, k2, k, n:integer;
        aLine:ILine;
        Area0P, Area1P:IPolyline;
        aLineE, LineE, Area0E, Area1E:IDMElement;
        Volume0E, Volume1E:IDMElement;
      begin
        Area0P:=Area0 as IPolyline;
        Area1P:=Area1 as IPolyline;
        Area0E:=Area0 as IDMElement;
        Area1E:=Area1 as IDMElement;
        LineE:=Line as IDMElement;
        Volume0E:=Area0.Volume0 as IDMElement;
        Volume1E:=Area0.Volume1 as IDMElement;
        Area0.Volume0:=nil;
        Area0.Volume1:=nil;
        k1:=Area1P.Lines.IndexOf(LineE);
        k2:=Area0P.Lines.IndexOf(LineE);
        LineE.RemoveParent(Area1E);
        LineE.RemoveParent(Area0E);
        if NodeConnecting(Area1P.Lines.Item[k1] as ILine,
                          Area0P.Lines.Item[k2] as ILine)<>nil then begin
          k:=k2;
          while k<Area0P.Lines.Count do begin
            aLineE:=Area0P.Lines.Item[k];
            aLine:=aLineE as ILine;
            n:=Area1P.Lines.IndexOf(aLineE);
            if n=-1 then begin
              aLineE.AddParent(Area1E);
              DMOperationManager.MoveElement( Area1P.Lines,
                                 aLineE, k1, False);
            end else begin
              aLineE.RemoveParent(Area1E);
              if n<=k1 then
                dec(k1);
            end;
            inc(k);
          end;
          k:=0;
          while k<k2 do begin
            aLineE:=Area0P.Lines.Item[k];
            aLine:=aLineE as ILine;
            n:=Area1P.Lines.IndexOf(aLineE);
            if n=-1 then begin
              aLineE.AddParent(Area1E);
              DMOperationManager.MoveElement( Area1P.Lines,
                                 aLineE, k1, False);
            end else begin
              aLineE.RemoveParent(Area1E);
              if n<=k1 then
                dec(k1);
            end;
            inc(k);
          end;
        end else begin
          k:=k2-1;
          while k>=0 do begin
            aLineE:=Area0P.Lines.Item[k];
            aLine:=aLineE as ILine;
            n:=Area1P.Lines.IndexOf(aLineE);
            if n=-1 then begin
              aLineE.AddParent(Area1E);
              if k1<>-1 then
                DMOperationManager.MoveElement( Area1P.Lines,
                                 aLineE, k1, False);
            end else begin
              aLineE.RemoveParent(Area1E);
              if n<=k1 then
                dec(k1);
            end;
            dec(k);
          end;
          k:=Area0P.Lines.Count-1;
          while k>=k2 do begin
            aLineE:=Area0P.Lines.Item[k];
            aLine:=aLineE as ILine;
            n:=Area1P.Lines.IndexOf(aLineE);
            if n=-1 then begin
              aLineE.AddParent(Area1E);
              if k1<>-1 then
                DMOperationManager.MoveElement( Area1P.Lines,
                                 aLineE, k1, False);
            end else begin
              aLineE.RemoveParent(Area1E);
              if n<=k1 then
                dec(k1);
            end;
            dec(k);
          end;
        end;
        while Area0P.Lines.Count>0 do begin
          aLineE:=Area0P.Lines.Item[0];
          aLineE.RemoveParent(Area0E);
        end;
        DMOperationManager.DeleteElement( nil, nil, ltOneToMany, Area0E);
        DMOperationManager.UpdateElement( Area1E);
        DMOperationManager.UpdateCoords( Area1E);
        if Volume0E<>nil then
          DMOperationManager.UpdateElement( Volume0E);
        if Volume1E<>nil then
          DMOperationManager.UpdateElement( Volume1E);
      end;

      function IsObsoletNode(const Line:ILine; const C:ICoordNode):boolean;
      var
        i:integer;
        aLine0, aLine1, aLine:ILine;
        aLineE:IDMElement;
        D:double;
      begin
        Result:=False;
        if C.Lines.Count=1 then begin
          Result:=True;
          Exit;
        end else
        if C.Lines.Count<>3 then Exit;
        aLine0:=nil;
        aLine1:=nil;
        for i:=0 to 2 do begin
          aLineE:=C.Lines.Item[i];
          aLine:=aLineE as ILine;
          if (aLine<>Line) and
             not aLineE.Selected then begin
            if aLine0=nil then
              aLine0:=aLine
            else
              aLine1:=aLine
          end;
        end;
        if aLine1<>nil then begin
           if aLine1.C1=C then
             D:=abs((aLine1.C0.Y-aLine0.C1.Y)*(aLine0.C0.X-aLine0.C1.X)-
                  (aLine0.C0.Y-aLine0.C1.Y)*(aLine1.C0.X-aLine0.C1.X))
           else
             D:=abs((aLine1.C1.Y-aLine0.C1.Y)*(aLine0.C0.X-aLine0.C1.X)-
                  (aLine0.C0.Y-aLine0.C1.Y)*(aLine1.C1.X-aLine0.C1.X));
           Result:= (D<1)
        end
      end;

var
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  j:integer;
  Element :IDMElement;
  DMCollection, OwnerCollection:IDMCollection;
begin
  DMCollection:=TDMCollection.Create(nil) as IDMCollection;
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  DMOperationManager:=SMDocument as IDMOperationManager;
  Element:=nil;
  for j:=0 to DMDocument.SelectionCount-1 do begin
    Element:=DMDocument.SelectionItem[j] as IDMElement;
    (DMCollection as IDMCollection2).Add(Element)
  end;

  if DMCollection.Count>0 then begin
     OwnerCollection:=Element.OwnerCollection;

     DMOperationManager.StartTransaction(nil, leoDelete, rsDeleteSelected);
    DMOperationManager.DeleteElements(DMCollection, True);
    (DMCollection as IDMCollection2).Clear;
  end;


  DMOperationManager.FinishTransaction(Element, nil, leoDelete);
  Server:=DMDocument.Server;
  Server.RefreshDocument(rfAll);   //  Repaint;
  CurrentStep:=-1;
  SMDocument.SetDocumentOperation(nil, OwnerCollection,
                          leoDelete, -1);
end;

procedure TDeleteSelectedOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  inherited;

end;

{ TDoubleBreakLineOperation }

procedure TDoubleBreakLineOperation.SetDistance(const Value: double);
begin
  FDistance := Value;
end;

procedure TDoubleBreakLineOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  SMOperationManager:ISMOperationManager;
  DMDocument:IDMDocument;
  Area:IArea;
  AreaE, aRef, aParent:IDMElement;
  DMClassCollections:IDMClassCollections;
  Suffix, aName:WideString;
  V:Variant;
  Server:IDataModelServer;
  aCollection, RefSource:IDMCollection;
  Unk:IUnknown;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  GlobalData:IGlobalData;
  OldSnapMode:integer;
  BLine:ILine;
  X, Y, Z, W, X0, Y0, X1, Y1, OldCurrZ:double;
  AreaUp, AreaDown:IArea;
  C0, C1, NNode:ICoordNode;
begin
  CurrentStep:=-1;
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  DMOperationManager:=SMDocument as IDMOperationManager;
  SMOperationManager:=SMDocument as ISMOperationManager;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;

  OldSnapMode:=SMDocument.SnapMode;
  case OldSnapMode of
  smoSnapNone:
    SMDocument.SnapMode:=smoSnapToNearestOnLine;
  end;
  SMDocument.GetSnapPoint(X, Y, Z, BLine, NNode, nil, False, 0);
  SMDocument.SnapMode:=OldSnapMode;
  if BLine=nil then Exit;
  SpatialModel2.EnabledBuildDirection:=0;
  AreaUp:=BLine.GetVerticalArea(bdUp);
  if AreaUp<>nil then
    SpatialModel2.EnabledBuildDirection:=SpatialModel2.EnabledBuildDirection+1;
  AreaDown:=BLine.GetVerticalArea(bdDown);
  if AreaDown<>nil then
    SpatialModel2.EnabledBuildDirection:=SpatialModel2.EnabledBuildDirection+2;
  if SpatialModel2.EnabledBuildDirection=0 then Exit;

  DMOperationManager.StartTransaction(nil, leoAdd, rsDoubleBreakLine);

  SpatialModel2.GetRefElementParent(_Area, OperationCode, 0, 0, 0, aParent,
                       DMClassCollections, RefSource, aCollection);
  Suffix:='';
  Server:=DMDocument.Server;
  Server.EventData1:=null;
  Server.EventData2:=(aCollection as IDMCollection2).MakeDefaultName(aParent);
  Server.EventData3:=-1;

  if SpatialModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
    GlobalData.GlobalValue[1]:=0;
    GlobalData.GlobalValue[2]:=1;
    GlobalData.GlobalValue[3]:=BLine.Length;
    if AreaUp<>nil then begin
      C0:=AreaUp.C0;
      C1:=AreaUp.C1;
    end else begin
      C0:=AreaDown.C0;
      C1:=AreaDown.C1;
    end;
    X0:=C0.X;
    Y0:=C0.Y;
    X1:=C1.X;
    Y1:=C1.Y;
    W:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
    GlobalData.GlobalValue[4]:=W;
  end;

  Server.CallRefDialog(DMClassCollections, RefSource, Suffix, True);
  V:=Server.EventData1;
  if VarIsNull(V) then
    aRef:=nil
  else begin
    Unk:=V;
    aRef:=Unk as IDMElement;
  end;
  aName:=Server.EventData2;
  if (aRef=nil) or
    (trim(aName)='') then begin
    DMOperationManager.Undo;
    SMDocument.SnapMode:=OldSnapMode;
    Exit;
  end;

  OldSnapMode:=SMDocument.SnapMode;
  if SMDocument.SnapMode<>smoSnapToMiddleOfLine then
    SMDocument.SnapMode:=smoSnapNone;

  Area:=SMDocument.InsertVerticalArea(nil);

  if Area=nil then begin
    SMDocument.SnapMode:=OldSnapMode;
    Exit;
  end;

  AreaE:=Area as IDMElement;

  SMDocument.ChangeRefRef( aCollection,
                        aName, aRef, AreaE.Ref);
  DMOperationManager.UpdateElement( AreaE.Ref);
  AreaE.Ref.Draw(Painter, 0);
  SMDocument.SetDocumentOperation(AreaE.Ref, nil, leoAdd, -1);

  if SpatialModel2.BuildWallsOnAllLevels then begin
    OldCurrZ:=SMDocument.CurrZ;
    while Area<>nil do begin
      Z:=Area.MaxZ;
      (SMDocument as ISMDocument).SetCurrXYZ(X, Y, Z);
      Area:=SMDocument.InsertVerticalArea(nil);
      if Area<>nil then begin
        AreaE:=Area as IDMElement;
        aName:=IncElementNumber(aName);
        SMDocument.ChangeRefRef( aCollection,
                        aName, aRef, AreaE.Ref);
      end;
    end;
    (SMDocument as ISMDocument).SetCurrXYZ(X, Y, OldCurrZ);
  end;


  SMDocument.SnapMode:=OldSnapMode;
end;

procedure TDoubleBreakLineOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  inherited;
  Hint:='СОЗДАНИЕ ПРОЕМОВ: Укажите центральную точку проема';
  ACursor:=CR_Build_DOOR;
end;

{ TTrimExtendToSelectedOperation }

procedure TTrimExtendToSelectedOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  Line, aLine:ILine;
  aC:ICoordNode;
  LineE, aLineE, aLine1E, aCE:IDMElement;
  aLine1:ILine;
  PX, PY, PZ, D:double;
  P0X, P0Y, P0Z, P1X, P1Y, P1Z,
  P2X, P2Y, P2Z, P3X, P3Y, P3Z:double;
  j:integer;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  LineU:IUnknown;
  VolumeBuilder:IVolumeBuilder;
  UpdateVolumesFlag:boolean;
begin
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  SpatialModel:=DMDocument.DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  DMOperationManager:=SMDocument as IDMOperationManager;
  VolumeBuilder:=SMDocument as IVolumeBuilder;

  LineE:=SMDocument.NearestLine;
  if LineE=nil then Exit;
  if DMDocument.SelectionCount=0 then Exit;

  Line:=LineE as ILine;
  P0X:=Line.C0.X;
  P0Y:=Line.C0.Y;
  P0Z:=Line.C0.Z;
  P1X:=Line.C1.X;
  P1Y:=Line.C1.Y;
  P1Z:=Line.C1.Z;

  DMOperationManager.StartTransaction(nil, leoAdd, rsTrimExtend);

  UpdateVolumesFlag:=False;

  for j:=0 to DMDocument.SelectionCount-1 do
    if DMDocument.SelectionItem[j].QueryInterface(ILine, aLine)=0 then  begin
      aLineE:=aLine as IDMElement;
      if Line.C0=aLine.C0 then Continue;
      if Line.C0=aLine.C1 then Continue;
      if Line.C1=aLine.C0 then Continue;
      if Line.C1=aLine.C1 then Continue;
      P2X:=aLine.C0.X;
      P2Y:=aLine.C0.Y;
      P2Z:=aLine.C0.Z;
      P3X:=aLine.C1.X;
      P3Y:=aLine.C1.Y;
      P3Z:=aLine.C1.Z;
      if LineCanIntersectLine(P0X, P0Y, P0Z,
                              P1X, P1Y, P1Z,
                              P2X, P2Y, P2Z,
                              P3X, P3Y, P3Z,
                              PX,  PY,  PZ) and
        ((P2X-PX)*(P3X-PX)+
         (P2Y-PY)*(P3Y-PY)+
         (P2Z-PZ)*(P3Z-PZ)<=1.e-9) then begin

        D:=Line.C0.DistanceFrom(PX, PY, PZ);
        if D<Line.C1.DistanceFrom(PX, PY, PZ) then
          aC:=Line.C0
        else
          aC:=Line.C1;
        aCE:=aC as IDMElement;

        LineE.Draw(Painter, -1);
        aC.X:=PX;
        aC.Y:=PY;
        aC.Z:=PZ;

        if (aLine.C0.X-PX=0) and
           (aLine.C0.Y-PY=0) and
           (aLine.C0.Z-PZ=0) then
          SMDocument.ReplaceCoordNode(aLine.C0, aC)
        else
        if (aLine.C1.X-PX=0) and
           (aLine.C1.Y-PY=0) and
           (aLine.C1.Z-PZ=0) then
          SMDocument.ReplaceCoordNode(aLine.C1, aC)
        else begin
          DMOperationManager.AddElement( aLineE.Parent,
                         SpatialModel.Lines, '', ltOneToMany, LineU, True);
          aLine1E:=LineU as IDMElement;
          aLine1:=aLine1E as ILine;
          aLine1.C0:=aC;
          aLine1.C1:=aLine.C1;
          aLine1.Thickness:=aLine.Thickness;
          aLine1.Style:=aLine.Style;
          (aLine1 as ISpatialElement).Color:=(aLine as ISpatialElement).Color;

          aLine.C1:=aC;

          if VolumeBuilder.UpdateAreas(aC as IDMElement) then
            UpdateVolumesFlag:=True;

          aLine1E.Selected:=True;
        end;

        if UpdateVolumesFlag then
          SpatialModel2.UpdateVolumes;

        LineE.Draw(Painter, 0);
      end;
    end;
  CurrentStep:=-1;
end;

procedure TTrimExtendToSelectedOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  inherited;
  Hint:='ПРОДЛЕНИЕ/УСЕЧЕНИЕ: Укажите продляемый/усекаемый отрезок';
  ACursor:=CR_TOOL_TRIM;
end;

{ TIntersectSelectedOperation }

procedure TIntersectSelectedOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='СОЗДАНИЕ УЗЛОВ: Укажите пересекающиеся отрезки (F6 - создать узлы в точка пересечения)';
  ACursor:=cr_Tool_Sect;
end;

procedure TIntersectSelectedOperation.Stop(
  const SMDocument: TCustomSMDocument; ShiftState: integer);

var
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  j:integer;
  Collection2:IDMCollection2;
begin
  if (ShiftState and sProgram)<>0 then begin
    CurrentStep:=-2;
    Exit;
  end;

  DMDocument:=SMDocument as IDMDocument;
  DMOperationManager:=SMDocument as IDMOperationManager;
  if DMDocument.SelectionCount<2 then Exit;
  DMOperationManager.StartTransaction(nil, leoAdd, rsIntersectSelected);
  Collection2:=TDMCollection.Create(nil) as IDMCollection2;
  for j:=0 to DMDocument.SelectionCount-1 do
    Collection2.Add(DMDocument.SelectionItem[j] as IDMElement);
  SMDocument.IntersectLines(Collection2 as IDMCollection);

  CurrentStep:=-2;
end;

{ TBreakLineOperation }

procedure TBreakLineOperation.Execute(
  const SMDocument: TCustomSMDocument; ShiftState: integer);
var
  Painter:IPainter;
  DMOperationManager:IDMOperationManager;
  DMDocument:IDMDocument;
  Line:ILine;
  Node0:ICoordNode;
  DividingLine:ILine;
  OldSnapMode:integer;
begin
  OldSnapMode:=SMDocument.SnapMode;
  try
  SMDocument.SnapMode:=smoSnapNone;
  Painter:=SMDocument.PainterU as IPainter;
  DMDocument:=SMDocument as IDMDocument;
  DMOperationManager:=SMDocument as IDMOperationManager;

  case SMDocument.SnapMode of
  smoSnapNone, smoSnapOrtToLine:
    SMDocument.SnapMode:=smoSnapToNearestOnLine;
  end;
  SMDocument.AutoSnapNode:=False;

  DMOperationManager.StartTransaction(nil, leoAdd, rsBreakLine);

  Node0:=SMDocument.GetSnapNode(Line, nil, False, 0);
  SMDocument.AutoSnapNode:=True;

  CurrentStep:=-1;

  if Node0=nil then begin
    SMDocument.SnapMode:=smoSnapNone;
    Exit;
  end;

  (Node0 as IDMElement).Draw(Painter, 0);

  SMDocument.DivideVerticalArea(Node0, bdUp, DividingLine);
  if DividingLine=nil then begin
    SMDocument.SnapMode:=smoSnapNone;
    Exit;
  end;

  (DividingLine as IDMElement).Draw(Painter, 0);

  finally
    SMDocument.SnapMode:=OldSnapMode;
  end;
end;

procedure TBreakLineOperation.GetStepHint(aStep: integer; var Hint: string;
  var ACursor: integer);
begin
  inherited;
  Hint:='ДОБАВЛЕНИЕ УЗЛОВ: Укажите положение нового узла ';
  ACursor:=CR_PEN_BREAK;
end;
end.
