unit WarriorPathU;

interface
uses
  Classes, SysUtils,  Graphics, Math,
  DMElementU, SorterU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  NamedSpatialElementU, SpatialModelConstU;

type
  TWarriorPath=class(TNamedSpatialElement, IWarriorPath, IDMReporter, IDMElement2)
  private
    FKind:integer;
    FDelayTime:double;
    FDelayTimeDispersion:double;
    FNoDetectionProbability:double;

    FRationalProbability:double;
    FOvercomingBoundaries:IDMCollection;
    FCriticalPoint:Variant;
    FResponceTimeRemainder:double;
    FGuardTacticFlag:boolean;

    FFirstNode:IDMElement;
    FPathNodes:IDMCollection;

    function SavePath:boolean;
  protected
    FWarriorPathElements:IDMCollection;

    function GetWarriorPathElementClassID: integer; virtual;
    procedure ChangeBackPath;
    procedure ClearBackPath;

    class function GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure _AddBackRef(const aElement:IDMElement); override;
    procedure Clear; override;
    procedure ClearOp; override;

    procedure AfterLoading2; override;

    procedure Set_Selected(Value: WordBool); override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function  Get_DelayTime: Double; safecall;
    function  Get_DelayTimeDispersion:double; safecall;
    function  Get_NoDetectionProbability: Double; safecall;
    function  Get_RationalProbability: Double; safecall;
    function  Get_Kind:integer; safecall;
    procedure Set_Kind(Value:integer); safecall;
    function  Get_CriticalPoint:IDMElement; safecall;
    procedure Set_CriticalPoint(const Value:IDMElement); safecall;
    function Get_OvercomingBoundaries: IDMCollection; safecall;

    procedure Build(TreeMode:integer; Reverse, DirectPath:WordBool; const InitialPathElementE:IDMElement); virtual; safecall;
    procedure  DoAnalysis(const InitialPathElementE:IDMElement;
                         DirectPath:WordBool); virtual; safecall;
    procedure  Analysis; virtual; safecall;

    function  Get_WarriorPathElements:IDMCollection; safecall;
    function  Get_FirstNode:IDMElement; safecall;
    procedure Set_FirstNode(const Value:IDMElement); safecall;
    function  Get_PathNodes: IDMCollection; safecall;
    function Get_GuardTacticFlag:WordBool; safecall;
    procedure Set_GuardTacticFlag(Value: WordBool); safecall;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    procedure BuildReport(ReportLevel: Integer; TabCount: Integer; Mode: Integer;
                          const Report: IDMText); override; safecall;
    function Get_ReportModeCount:integer; override; safecall;
    function Get_ReportModeName(Index:integer):WideString; override; safecall;
    function GetResponceTime:double; virtual;
    function GetResponceTimeDispersion:double; virtual;
    
//IDMElement2
    function GetOperationName(ColIndex, Index: Integer): WideString; safecall;
    function DoOperation(ColIndex, Index: Integer; var Param1: OleVariant; var Param2: OleVariant;
                         var Param3: OleVariant): WordBool; safecall;
    function GetShortCut(ColIndex, Index: Integer): WideString; safecall;
    procedure Rebuild(RefreshDocument:WordBool);
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TWarriorPaths=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  public
    procedure Initialize; override;
  end;

  TWarriorPathElementSorter=class(TSorter)
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields, FSeparatingAreas:IDMCollection;
  GBackPathSubStateE:IDMElement;

const
  wpnDelayTimeDispersion=6;

{ TWarriorPath }

class function TWarriorPath.GetClassID: integer;
begin
  Result:=_WarriorPath
end;

function TWarriorPath.Get_CollectionCount: integer;
begin
  Result:=2;
end;

function TWarriorPath.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:Result:=FWarriorPathElements;
  1:Result:=FOvercomingBoundaries;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

procedure TWarriorPath.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:begin
    aCollectionName:=rsWarriorPathLines;
    aRefSource:=nil;
    aClassCollections:=nil;
    aOperations:=0;
    aLinkType:=ltIndirect;
    end;
  1:begin
    aCollectionName:=rsOvercomingBoundaries;
    aRefSource:=nil;
    aClassCollections:=nil;
    aOperations:=0;
    aLinkType:=ltOneToMany;
    end;
  end;
end;

class function TWarriorPath.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TWarriorPath.MakeFields0;
begin
  inherited;
  AddField(rsSystemEfficiency, '%0.4f', '', '',
                 fvtFloat, 0, 0, 1,
                 ord(wpSystemEfficiency), 1, pkOutput or pkDontSave);
  AddField(rsPathRationalProbability, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpPathRationalProbability), 1, pkOutput);
  AddField(rsPathNoDetectionProbability, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpPathNoDetectionProbability), 1, pkOutput);
  AddField(rsPathDelayTime, '%0.1f', '', '',
                 fvtFloat, InfinitValue, 0, 0,
                 ord(wpPathDelayTime), 1, pkOutput);
  AddField(rsCriticalPoint, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(wpCriticalPoint), 1, pkOutput);
  AddField(rsResponceTimeRemainder, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpResponceTimeRemainder), 1, pkOutput);
  AddField(rsGuardTacticFlag, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 constGuardTacticFlag, 0, pkInput);

end;

function TWarriorPath.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(wpSystemEfficiency):
    Result:=1-FRationalProbability;
  ord(wpPathRationalProbability):
    Result:=FRationalProbability;
  ord(wpPathNoDetectionProbability):
    Result:=FNoDetectionProbability;
  ord(wpPathDelayTime):
    Result:=FDelayTime;
  ord(wpCriticalPoint):
    Result:=FCriticalPoint;
  ord(wpResponceTimeRemainder):
    Result:=FResponceTimeRemainder;
  constGuardTacticFlag:
    Result:=FGuardTacticFlag;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TWarriorPath.SetFieldValue(Code: integer;
  Value: OleVariant);
var
  OldBool:boolean;
begin
  case Code of
  ord(wpSystemEfficiency):
    begin end;
  ord(wpPathRationalProbability):
    FRationalProbability:=Value;
  ord(wpPathNoDetectionProbability):
    FNoDetectionProbability:=Value;
  ord(wpPathDelayTime):
    FDelayTime:=Value;
  ord(wpCriticalPoint):
    FCriticalPoint:=Value;
  ord(wpResponceTimeRemainder):
    FResponceTimeRemainder:=Value;
  constGuardTacticFlag:
    begin
      OldBool:=FGuardTacticFlag;
      FGuardTacticFlag:=Value;
      if (not DataModel.IsLoading) and
         (not DataModel.IsCopying) and
         (OldBool<>FGuardTacticFlag) then begin
        Analysis;
      end;
    end;
  else
    inherited;
  end;
end;


procedure TWarriorPath.Build(TreeMode:integer; Reverse, DirectPath:WordBool;
                             const InitialPathElementE:IDMElement);
var
  WarriorPathElements2:IDMCollection2;
  C, NextC:ICoordNode;
  j, PathArcKind:integer;
  aLineE, LineRef, WarriorPathElementE, FacilityStateE:IDMElement;
  aLine:ILine;
  Lines:IDMCollection;
  aPathArc:IPathArc;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  InitialLineIndex:integer;
  AnalysisVariant:IAnalysisVariant;
  GuardVariant:IGuardVariant;
  GuardArrivals:IDMCollection;
  GuardArrivals2:IDMCollection2;
  PathNodes:IDMCollection;

  procedure MakeGuardArrivals(const Boundary:IBoundary;
                              Currj:integer);
  var
    j, m:integer;
    GuardGroupE, GuardArrivalE:IDMElement;
    GuardGroupW:IWarriorGroup;
    GuardGroup:IGuardGroup;
    GuardArrival:IGuardArrival;
    PathArcE:IDMElement;
    PathArcL:ILine;
    T0Min, T1Min, T0, T1, StartDelay,
    dT0, dT1, dT0Best, dT1Best:double;
    Node0, Node1: IVulnerabilityData;
    OldWarriorGroupU:IUnknown;
    FacilityElement:IFacilityElement;
    Task:integer;

    function DoArrive:boolean;
    var
      Zone0E, Zone1E:IDMElement;

      function PointOnPath(const PointE:IDMElement):boolean;
      var
        C, C0, C1:ICoordNode;
        X0, Y0, Z0, X1, Y1, Z1, L, TransparencyCoeff:double;
      begin
        Result:=False;
        if PointE=nil then Exit;
        C:=PointE.SpatialElement as ICoordNode;
        if C=nil then begin
          Result:=(PointE.Parent.Parent=Boundary as IDMElement);
          Exit;
        end;
        X0:=C.X;
        Y0:=C.Y;
        Z0:=C.Z;
        C0:=aLine.C0;
        C1:=aLine.C1;
        X1:=0.5*(C0.X+C1.X);
        Y1:=0.5*(C0.Y+C1.Y);
        Z1:=0.5*(C0.Z+C1.Z);
        L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0)+sqr(Z1-Z0));
        if L>5000 then Exit;
        (FSeparatingAreas as IDMCollection2).Clear;
        try
        if FacilityModel.FindSeparatingAreas(X0, Y0, Z0, X1, Y1, Z1,
               PointE, LineRef, 1,
               FSeparatingAreas, TransparencyCoeff,
               nil, LineRef.SpatialElement) then Exit;
        except
          DataModel.HandleError('Error in TWarriorPath.Build');
        end;
        Result:=True
      end;
    begin
      case Task of
      gtTakePosition:
        Result:=PointOnPath(GuardGroupW.FinishPoint);
      gtInterruptOnDetectionPoint:
        Result:=True;
      gtPatrol:
        Result:=PointOnPath(GuardGroupW.StartPoint);
      gtStayOnPost:
        Result:=PointOnPath(GuardGroupW.StartPoint);
      gtInterruptOnTarget:
        begin
          Zone0E:=Boundary.Zone0;
          Zone1E:=Boundary.Zone1;
          if (Zone0E<>nil) and
             (Zone1E<>nil) then begin
            Result:=(GuardGroupW.GetAccessTypeToZone(Zone0E,False)<>
                     GuardGroupW.GetAccessTypeToZone(Zone1E,False))
          end else
          if Reverse then
             Result:=(Currj=0)
          else begin
            if InitialPathElementE<>nil then
              Result:=(Currj=InitialLineIndex-1)
            else
              Result:=(Currj=Lines.Count-1);
          end;
        end;
      gtInterruptOnExit:
        if InitialPathElementE<>nil then begin
          if Reverse then
             Result:=(Currj=0)
          else
             Result:=(Currj=Lines.Count-1);
        end else begin
          Result:=False;
          Exit;
        end;
      end;
    end;
  begin
    FacilityElement:=Boundary as IFacilityElement;
    for j:=0 to GuardVariant.GuardGroups.Count-1 do begin
      GuardGroupE:=GuardVariant.GuardGroups.Item[j];
      GuardGroupW:=GuardGroupE as IWarriorGroup;
      GuardGroup:=GuardGroupE as IGuardGroup;
      Task:=GuardGroupW.Task;
      if DoArrive then begin
        OldWarriorGroupU:=FacilityModelS.CurrentWarriorGroupU;
        if GuardGroupW.Task=gtStayOnPost then begin
          T0Min:=0;
          T1Min:=0;
          dT0Best:=0;
          dT1Best:=0;
        end else begin
          StartDelay:=GuardGroup.StartDelay;
          FacilityModelS.CurrentWarriorGroupU:=GuardGroupE;
          T0Min:=InfinitValue;
          T1Min:=InfinitValue;
          dT0Best:=0;
          dT1Best:=0;
          for m:=0 to FacilityElement.PathArcs.Count-1 do begin
            PathArcE:=FacilityElement.PathArcs.Item[m];
            PathArcL:=PathArcE as ILine;
            Node0:=PathArcL.C0 as IVulnerabilityData;
            Node1:=PathArcL.C1 as IVulnerabilityData;
            T0:=Node0.DelayTimeFromStart+StartDelay;
            T1:=Node1.DelayTimeFromStart+StartDelay;
            dT0:=Node0.DelayTimeFromStartDispersion;
            dT1:=Node1.DelayTimeFromStartDispersion;
            if T0Min>T0 then begin
              T0Min:=T0;
              dT0Best:=dT0;
            end;
            if T1Min>T1 then begin
              T1Min:=T1;
              dT1Best:=dT1;
            end;
          end;
        end;
        if (T0Min<InfinitValue) or
           (T1Min<InfinitValue) then begin
          GuardArrivalE:=GuardArrivals2.CreateElement(False);
          GuardArrivals2.Add(GuardArrivalE);
          GuardArrivalE.Ref:=GuardGroupE;
          GuardArrivalE.Parent:=WarriorPathElementE;
          GuardArrival:=GuardArrivalE as IGuardArrival;
          GuardArrival.ArrivalTime0:=T0Min;
          GuardArrival.ArrivalTime1:=T1Min;
          GuardArrival.ArrivalTimeDispersion0:=dT0Best;
          GuardArrival.ArrivalTimeDispersion1:=dT1Best;
          GuardArrival.UserDefinedArrivalTime:=gatCalculatedFromStart;
        end;
        FacilityModelS.CurrentWarriorGroupU:=OldWarriorGroupU;
      end;
    end;
  end;

  procedure BuildWarriorPathElement(Currj:integer);
  var
    Boundary:IBoundary;
    RefPathElement:IRefPathElement;
    WarriorPathElement:IWarriorPathElement;
  begin
    WarriorPathElementE:=WarriorPathElements2.CreateElement(False);
    WarriorPathElements2.Add(WarriorPathElementE);
    WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
    RefPathElement:=WarriorPathElementE as IRefPathElement;
    WarriorPathElementE.Ref:=LineRef;
    WarriorPathElementE.Parent:=Self as IDMElement;
    RefPathElement.N:=j;
    RefPathElement.PathArcKind:=PathArcKind;
    if C=aLine.C0 then begin
      RefPathElement.X0:=C.X;
      RefPathElement.Y0:=C.Y;
      RefPathElement.Z0:=C.Z;
      RefPathElement.X1:=NextC.X;
      RefPathElement.Y1:=NextC.Y;
      RefPathElement.Z1:=NextC.Z;
    end else begin
      RefPathElement.X0:=NextC.X;
      RefPathElement.Y0:=NextC.Y;
      RefPathElement.Z0:=NextC.Z;
      RefPathElement.X1:=C.X;
      RefPathElement.Y1:=C.Y;
      RefPathElement.Z1:=C.Z;
    end;
    RefPathElement.Ref0:=(aLine.C0 as IDMElement).Ref;
    RefPathElement.Ref1:=(aLine.C1 as IDMElement).Ref;
    WarriorPathElement.FacilityState:=FacilityStateE;

    if aLineE.Ref.QueryInterface(IBoundary, Boundary)=0 then
      MakeGuardArrivals(Boundary, Currj);

    if TreeMode=tmToRoot then begin
      if C=aLine.C0 then
        RefPathElement.Direction:=pdFrom0To1
      else
        RefPathElement.Direction:=pdFrom1To0;
    end else begin
      if C=aLine.C0 then
        RefPathElement.Direction:=pdFrom1To0
      else
        RefPathElement.Direction:=pdFrom0To1;
    end;

    C:=NextC;
  end;
var
 j0, j1, dj, m:integer;
 Zone2:IZone2;
 StartNodeE, FinishNodeE, DataModelE:IDMElement;
 PathArcs:IDMCollection;
 ArcFactory, NodeFactory:IDMCollection2;
 OldNextC:ICoordNode;
begin
  if SpatialElement=nil then Exit;
  Lines:=(SpatialElement as IPolyline).Lines;
  if Lines.Count=0 then Exit;
  PathNodes:=Get_PathNodes;

  if InitialPathElementE=nil then
    InitialLineIndex:=Lines.Count
  else
    InitialLineIndex:=FWarriorPathElements.IndexOf(InitialPathElementE);

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;
  GuardVariant:=AnalysisVariant.GuardVariant as IGuardVariant;
  WarriorPathElements2:=FacilityModel.WarriorPathElements as IDMCollection2;
  GuardArrivals:=(FacilityModel as IDMElement).Collection[_GuardArrival];
  GuardArrivals2:=GuardArrivals as IDMCollection2;
  DataModelE:=DataModel as IDMElement;
  ArcFactory:=DataModelE.Collection[_Line] as IDMCollection2;
  NodeFactory:=DataModelE.Collection[_CoordNode] as IDMCollection2;

  if Reverse then begin
    C:=PathNodes.Item[InitialLineIndex-1] as ICoordNode;
    j0:=InitialLineIndex-1;
    j1:=-1;
    dj:=-1;
  end else begin
    C:=Get_FirstNode as ICoordNode;
    j0:=0;
    j1:=InitialLineIndex;
    dj:=+1;
  end;

  j:=j0;
  while j<>j1 do begin
    aLineE:=Lines.Item[j];
    NextC:=PathNodes.Item[j] as ICoordNode;
    aLine:=aLineE as ILine;
    if aLineE.QueryInterface(IPathArc, aPathArc)=0 then begin
      PathArcKind:=aPathArc.Kind;
      FacilityStateE:=aPathArc.FacilityState;
      FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
    end else begin
      PathArcKind:=0;
      FacilityStateE:=nil;
    end;
    LineRef:=aLineE.Ref;

    if PathArcKind=pakRZone then begin
      Zone2:=LineRef as IZone2;
      if (not Zone2.IsConvex) or
        (Zone2.InnerZoneOutlineCount>0) then begin

        StartNodeE:=C as IDMElement;
        FinishNodeE:=NextC as IDMElement;

        OldNextC:=NextC;
        Zone2.MakeRoundaboutPath(StartNodeE, FinishNodeE,
                                 ArcFactory, NodeFactory);
        PathArcs:=(Zone2 as IFacilityElement).PathArcs;
        if PathArcs.Count>0 then begin
          C:=nil;
          for m:=0 to PathArcs.Count-1 do begin  // проходим по пути обхода препятствий
            aLineE:=PathArcs.Item[m];
            aLine:=aLineE as ILine;

            if m=0 then
              C:=aLine.C0;

            NextC:=aLine.NextNodeTo(C);
            BuildWarriorPathElement(j);
          end;
          NextC:=OldNextC;
        end else
          BuildWarriorPathElement(j);
        Zone2.ClearRoundaboutPath;
      end else
        BuildWarriorPathElement(j);
    end else
      BuildWarriorPathElement(j);

    j:=j+dj;
  end;

end;

procedure TWarriorPath.Analysis;
var
  aInitialPathElementE: IDMElement;
  aInitialPathElement:IWarriorPathElement;
  j:integer;
  theWarriorPathElements:IDMCollection;
begin
  theWarriorPathElements:=Get_WarriorPathElements;
  if theWarriorPathElements=nil then Exit;

  j:=0;
  while j<theWarriorPathElements.Count do begin
    if theWarriorPathElements.Item[j].Ref.ClassID=_Target then
      Break
    else
      inc(j);
  end;
  inc(j);
  if j<theWarriorPathElements.Count-1 then begin
    aInitialPathElementE:=theWarriorPathElements.Item[j];
    aInitialPathElement:=aInitialPathElementE as IWarriorPathElement;
    aInitialPathElement.Reset;
    DoAnalysis(aInitialPathElementE, False); // определяем изменяемые средства охраны
    ChangeBackPath;                          // изменяем состояние средств охраны
    DoAnalysis(aInitialPathElementE, False); // обратная ветвь маршрута
    ClearBackPath;                           // восстанавливаем исходное состояние средств охраны
    DoAnalysis(aInitialPathElementE, True);  // прямая ветвь маршрута
  end else
    DoAnalysis(nil, True);
end;

procedure TWarriorPath.DoAnalysis(const InitialPathElementE:IDMElement;
                                DirectPath:WordBool);
var
  Lines2, CoordNodes2:IDMCollection2;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  FastPathStage, StealthPathStage:integer;
  ReactionTime, T, P, FuncT, FuncP, R, FuncR,
  T1, FuncT1:double;
  SpatialModel:ISpatialModel;
  AnalysisVariant:IAnalysisVariant;
  j, StartPathElementJ:integer;
  SelfE:IDMElement;
  CriticalPointPassed, TargetPassed:boolean;

  procedure TreatElement(const Element:IDMElement;
                         const WarriorPathElementE: IDMElement;
                         const NextBoundaryE:IDMElement);
  var
    PathElement:IPathElement;
    SuccessProbability,
    OutstripP, dT, dTDisp:double;
    aLineE, LineRef, FacilityStateE, C0E, C1E, BestTacticE:IDMElement;
    aLine:ILine;
    PathArcKind, NodeDirection:integer;
    WarriorPathElement:IWarriorPathElement;
    RefPathElement:IRefPathElement;
    FacilityElement:IFacilityElement;
  begin
    try
    WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
    RefPathElement:=WarriorPathElementE as IRefPathElement;
    WarriorPathElement.T:=T;
    WarriorPathElement.TDisp:=FuncT;
    WarriorPathElement.dT:=0;
    WarriorPathElement.R:=R;
    WarriorPathElement.R0:=FuncR;
    WarriorPathElement.OutstripProbabilityR:=1;

    if RefPathElement.Z0<=-InfinitValue then Exit;
    if RefPathElement.Z1<=-InfinitValue then Exit;


    SelfE:=Self as IDMElement;
    LineRef:=WarriorPathElementE.Ref;
    PathArcKind:=RefPathElement.PathArcKind;

    NodeDirection:=RefPathElement.Direction;

    aLineE:=Lines2.CreateElement(False);
    aLineE.Ref:=LineRef;
    aLine:=aLineE as ILine;

    C0E:=CoordNodes2.CreateElement(False);
    aLine.C0:=C0E as ICoordNode;
    aLine.C0.X:=RefPathElement.X0;
    aLine.C0.Y:=RefPathElement.Y0;
    aLine.C0.Z:=RefPathElement.Z0;
    C0E.Ref:=RefPathElement.Ref0;

    C1E:=CoordNodes2.CreateElement(False);
    aLine.C1:=C1E as ICoordNode;
    aLine.C1.X:=RefPathElement.X1;
    aLine.C1.Y:=RefPathElement.Y1;
    aLine.C1.Z:=RefPathElement.Z1;
    C1E.Ref:=RefPathElement.Ref1;

    FacilityStateE:=WarriorPathElement.FacilityState;
    if FacilityStateE=nil then begin
      if (Parent<>nil) and
         (Parent.QueryInterface(IAnalysisVariant, AnalysisVariant)=0) then
        FacilityStateE:=AnalysisVariant.FacilityState
      else
        FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
    end;
    if (FacilityModelS.CurrentFacilityStateU as IDMElement)<>FacilityStateE then
      FacilityModelS.CurrentFacilityStateU:=FacilityStateE;

    FacilityModelS.CurrentLineU:=aLineE;
    FacilityModelS.CurrentPathArcKind:=PathArcKind;
    FacilityModelS.CurrentNodeDirection:=NodeDirection;

    if not CriticalPointPassed then
      RefPathElement.PathStage:=0       // скрытно
    else
      RefPathElement.PathStage:=psfFast; // быстро
    if TargetPassed then
      RefPathElement.PathStage:=RefPathElement.PathStage+psfBack; // (флаг обратно)


    if Element.QueryInterface(IPathElement, PathElement)=0 then begin

      if Element.id=562 then
        XXX:=0;

      FacilityModelS.CurrentPathStage:=FastPathStage;
      PathElement.CalcDelayTime(dT, dTDisp, BestTacticE, 0);

      WarriorPathElement.dT:=dT;

      FacilityModelS.CurrentPathStage:=StealthPathStage;
      T1:=T;
      FuncT1:=FuncT;
      SuccessProbability:=R;

      if Element.QueryInterface(IFacilityElement, FacilityElement)=0 then begin
        if FacilityElement.GoalDefinding then
          StartPathElementJ:=-1
        else
          StartPathElementJ:=j;
      end else
        StartPathElementJ:=-1;

      if Element.id=0 then
        XXX:=0;  

      PathElement.CalcPathSuccessProbability(
        SuccessProbability,OutstripP,
        T1, FuncT1, 0);

      WarriorPathElement.T:=T1;
      WarriorPathElement.TDisp:=FuncT1;
      WarriorPathElement.R:=SuccessProbability;
      WarriorPathElement.OutstripProbabilityR:=OutstripP;

      R:=SuccessProbability;

      if (ReactionTime>=T) and
         (ReactionTime<T1) then begin
        Set_CriticalPoint(WarriorPathElementE);
        FResponceTimeRemainder:=T1-ReactionTime;
        CriticalPointPassed:=False;
        RefPathElement.PathStage:=RefPathElement.PathStage+psfCriticalPoint
      end;
      if Element.ClassID=_Target then begin
        TargetPassed:=False;
        RefPathElement.PathStage:=RefPathElement.PathStage+psfTarget
      end;

      T:=T1;
      FuncT:=FuncT1;
    end;

    aLine.C0:=nil;
    aLine.C1:=nil;
    except
      raise
    end;

  end;

  procedure TreatElement1(const Element:IDMElement;
                         const WarriorPathElementE, NextWarriorPathElementE: IDMElement);
  var
    PathElement:IPathElement;
    PP, NoDetP, NoFailureP:double;
    NoEvidence:WordBool;
    aLineE, LineRef, FacilityStateE, C0E, C1E:IDMElement;
    aLine:ILine;
    PathArcKind, NodeDirection:integer;
    WarriorPathElement, NextWarriorPathElement:IWarriorPathElement;
    RefPathElement:IRefPathElement;
    AnalysisVariant:IAnalysisVariant;
  begin
    WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
    NextWarriorPathElement:=NextWarriorPathElementE as IWarriorPathElement;
    RefPathElement:=WarriorPathElementE as IRefPathElement;

    WarriorPathElement.P:=P;
    WarriorPathElement.P0:=FuncP;
    WarriorPathElement.NoDetP:=1;
    WarriorPathElement.NoFailureP:=1;
    WarriorPathElement.NoEvidence:=True;


    if RefPathElement.Z0<=-InfinitValue then Exit;
    if RefPathElement.Z1<=-InfinitValue then Exit;

    LineRef:=WarriorPathElementE.Ref;
    PathArcKind:=RefPathElement.PathArcKind;

    if DirectPath then
      NodeDirection:=RefPathElement.Direction
    else
      NodeDirection:=1-RefPathElement.Direction;


    aLineE:=Lines2.CreateElement(False);
    aLineE.Ref:=LineRef;
    aLine:=aLineE as ILine;

    C0E:=CoordNodes2.CreateElement(False);
    aLine.C0:=C0E as ICoordNode;
    aLine.C0.X:=RefPathElement.X0;
    aLine.C0.Y:=RefPathElement.Y0;
    aLine.C0.Z:=RefPathElement.Z0;
    C0E.Ref:=RefPathElement.Ref0;

    C1E:=CoordNodes2.CreateElement(False);
    aLine.C1:=C1E as ICoordNode;
    aLine.C1.X:=RefPathElement.X1;
    aLine.C1.Y:=RefPathElement.Y1;
    aLine.C1.Z:=RefPathElement.Z1;
    C1E.Ref:=RefPathElement.Ref1;

    FacilityStateE:=WarriorPathElement.FacilityState;
    if FacilityStateE=nil then begin
      if (Parent<>nil) and
         (Parent.QueryInterface(IAnalysisVariant, AnalysisVariant)=0) then
        FacilityStateE:=AnalysisVariant.FacilityState
      else
        FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
    end;
    if (FacilityModelS.CurrentFacilityStateU as IDMElement)<>FacilityStateE then
      FacilityModelS.CurrentFacilityStateU:=FacilityStateE;


    FacilityModelS.CurrentLineU:=aLineE;
    FacilityModelS.CurrentPathArcKind:=PathArcKind;
    FacilityModelS.CurrentNodeDirection:=NodeDirection;

    if Element.QueryInterface(IPathElement, PathElement)=0 then begin
      PP:=P;

      FacilityModelS.CurrentPathStage:=StealthPathStage;
      if Element.ID=562 then
        XXX:=0;

      PathElement.CalcPathNoDetectionProbability(
                                    PP, NoDetP, NoFailureP, NoEvidence, 0);
      WarriorPathElement.P:=PP;
      WarriorPathElement.NoDetP:=NoDetP;
      WarriorPathElement.NoFailureP:=NoFailureP;
      WarriorPathElement.NoEvidence:=NoEvidence;
      P:=PP;
    end;

    aLine.C0:=nil;
    aLine.C1:=nil;

  end;

var
  j1, j0, m:integer;
  Volume0, Volume1:IVolume;
  SpatialModel2:ISpatialModel2;

  Element, Element0, Element1:IDMElement;
  WarriorPathElementE, NextWarriorPathElementE:IDMElement;
  WarriorPathElement:IWarriorPathElement;
  RefPathElement:IRefPathElement;
  Document:IDMDocument;
  OldState:integer;
  LineRef:IDMElement;
  OldCurrentLayer:ILayer;
  InitialPathElement:IWarriorPathElement;
  NoDetP:double;
  NextBoundaryE, aRef:IDMElement;
  aBoundary:IBoundary;
  NextZone, PrevZone, Zone:IZone;
begin
  InitialPathElement:=InitialPathElementE as IWarriorPathElement;
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  SpatialModel2:=DataModel as ISpatialModel2;
  SpatialModel:=DataModel as ISpatialModel;
  Lines2:=SpatialModel.Lines as IDMCollection2;
  CoordNodes2:=SpatialModel.CoordNodes as IDMCollection2;
  Set_CriticalPoint(nil);
  FResponceTimeRemainder:=-InfinitValue;

  if FacilityModelS.CurrentWarriorGroupU=nil then Exit;

  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;
  ReactionTime:=GetResponceTime;
  FacilityModelS.CurrentReactionTime:=ReactionTime;
  FacilityModelS.CurrentReactionTimeDispersion:=GetResponceTimeDispersion;

  OldCurrentLayer:=SpatialModel.CurrentLayer;
  SpatialModel.CurrentLayer:=nil;

  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfChanging;
  try

  if InitialPathElement=nil then begin
    T:=0;
    R:=1;
    FuncT:=0;
    FuncP:=1;
    FuncR:=1;
    j0:=0;
    j1:=FWarriorPathElements.Count-1
  end else begin
    if DirectPath then begin
      T:=InitialPathElement.T;
      R:=InitialPathElement.R;
      FuncT:=InitialPathElement.TDisp;
      FuncP:=InitialPathElement.P0;
      FuncR:=InitialPathElement.R0;
      j0:=0;
      j1:=FWarriorPathElements.IndexOf(InitialPathElementE)-1;
    end else begin
      T:=0;
      R:=1;
      FuncT:=0;
      FuncP:=1;
      FuncR:=1;
      j0:=FWarriorPathElements.IndexOf(InitialPathElementE);
      j1:=FWarriorPathElements.Count-1;
    end;
  end;
  P:=1;

  if DirectPath then begin
    FastPathStage:=wpsFastEntry;
    StealthPathStage:=wpsStealthEntry;
  end else begin
    FastPathStage:=wpsFastExit;
    StealthPathStage:=wpsStealthExit;
  end;

  CriticalPointPassed:=True;  // идем в обратном порядке
  TargetPassed:=True;

  NextBoundaryE:=nil;
  for j:=j1 downto j0 do begin
    WarriorPathElementE:=FWarriorPathElements.Item[j];
    WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
    RefPathElement:=WarriorPathElementE as  IRefPathElement;
    LineRef:=WarriorPathElementE.Ref;

    if LineRef.QueryInterface(IZone, Zone)=0 then begin
      NextZone:=Zone;
      PrevZone:=Zone;
    end else begin
      NextZone:=nil;
      m:=j+1;
      while m<j1+1 do begin
        aRef:=FWarriorPathElements.Item[m].Ref;
        if aRef.QueryInterface(IZone, NextZone)=0 then
          break
        else
          inc(m);
      end;
      PrevZone:=nil;
      m:=j-1;
      while m>j0-1 do begin
        aRef:=FWarriorPathElements.Item[m].Ref;
        if aRef.QueryInterface(IZone, PrevZone)=0 then
          break
        else
          dec(m);
      end;
    end;
    FacilityModelS.CurrentZone0U:=NextZone;
    FacilityModelS.CurrentZone1U:=PrevZone;

    Element0:=nil;
    Element1:=nil;

    if LineRef=nil then begin
      with RefPathElement do begin
        Volume0:=SpatialModel2.GetVolumeContaining(X0, Y0, Z0);
        Volume1:=SpatialModel2.GetVolumeContaining(X1, Y1, Z1);
      end;

      if (Volume0=nil) and
         (Volume1=nil) then
        Element:=nil
      else begin
        if Volume0=Volume1 then
          Element :=(Volume0 as IDMElement).Ref
        else begin
          Element:=nil;
          if Volume0<>nil then
            Element0:=(Volume0 as IDMElement).Ref;
          if Volume1<>nil then
            Element1:=(Volume1 as IDMElement).Ref;
        end;
      end;
      if Element0<>nil then
        TreatElement(Element0, WarriorPathElementE, NextBoundaryE);
      if Element<>nil then
        TreatElement(Element, WarriorPathElementE, NextBoundaryE);
      if Element1<>nil then
        TreatElement(Element1, WarriorPathElementE, NextBoundaryE);
    end else
      TreatElement(LineRef, WarriorPathElementE, NextBoundaryE);

    if WarriorPathElementE.Ref.QueryInterface(IBoundary, aBoundary)=0 then
      NextBoundaryE:=aBoundary as IDMElement
    else
      NextBoundaryE:=nil
  end;

  for j:=j0 to j1 do begin
    WarriorPathElementE:=FWarriorPathElements.Item[j];
    WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;

    if j<>j1 then
      NextWarriorPathElementE:=FWarriorPathElements.Item[j+1]
    else
      NextWarriorPathElementE:=nil;

    LineRef:=WarriorPathElementE.Ref;

    if LineRef.QueryInterface(IZone, Zone)=0 then begin
      NextZone:=Zone;
      PrevZone:=Zone;
    end else begin
      NextZone:=nil;
      m:=j+1;
      while m<j1+1 do begin
        aRef:=FWarriorPathElements.Item[m].Ref;
        if aRef.QueryInterface(IZone, NextZone)=0 then
          break
        else
          inc(m);
      end;
      PrevZone:=nil;
      m:=j-1;
      while m>j0-1 do begin
        aRef:=FWarriorPathElements.Item[m].Ref;
        if aRef.QueryInterface(IZone, PrevZone)=0 then
          break
        else
          dec(m);
      end;
    end;
    FacilityModelS.CurrentZone0U:=NextZone;
    FacilityModelS.CurrentZone1U:=PrevZone;

    Element0:=nil;
    Element1:=nil;

    if LineRef=nil then begin
      with RefPathElement do begin
        Volume0:=SpatialModel2.GetVolumeContaining(X0, Y0, Z0);
        Volume1:=SpatialModel2.GetVolumeContaining(X1, Y1, Z1);
      end;

      if (Volume0=nil) and
         (Volume1=nil) then
        Element:=nil
      else begin
        if Volume0=Volume1 then
          Element :=(Volume0 as IDMElement).Ref
        else begin
          Element:=nil;
          if Volume0<>nil then
            Element0:=(Volume0 as IDMElement).Ref;
          if Volume1<>nil then
            Element1:=(Volume1 as IDMElement).Ref;
        end;
      end;
      if Element0<>nil then
        TreatElement1(Element0, WarriorPathElementE, NextWarriorPathElementE);
      if Element<>nil then
        TreatElement1(Element, WarriorPathElementE, NextWarriorPathElementE);
      if Element1<>nil then
        TreatElement1(Element1, WarriorPathElementE, NextWarriorPathElementE);
    end else
      TreatElement1(LineRef, WarriorPathElementE, NextWarriorPathElementE);
  end;

  for j:=j1+1 to FWarriorPathElements.Count-1 do begin
    WarriorPathElementE:=FWarriorPathElements.Item[j];
    WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
    NoDetP:=WarriorPathElement.NoDetP;
    P:=P*NoDetP;
    WarriorPathElement.P:=P;
  end;

  finally
    SpatialModel.CurrentLayer:=OldCurrentLayer;
    Document.State:=OldState;
  end;

  FDelayTime:=T;
  FDelayTimeDispersion:=FuncT;
  FNoDetectionProbability:=P;
  FRationalProbability:=R;

  if Get_CriticalPoint=nil then
    FResponceTimeRemainder:=T-ReactionTime;
end;

function  TWarriorPath.Get_DelayTime: Double;
begin
  Result:=FDelayTime
end;

function  TWarriorPath.Get_NoDetectionProbability: Double; safecall;
begin
  Result:=FNoDetectionProbability
end;

function  TWarriorPath.Get_RationalProbability: Double; safecall;
begin
  Result:=FRationalProbability
end;

const
  _Path=2;
  
procedure TWarriorPath._AddBackRef(const aElement:IDMElement);
begin
  if aElement.ClassID=_LineGroup then
    Set_SpatialElement(aElement)
  else
  if aElement.ClassID=_Polyline then
    Set_SpatialElement(aElement)
  else
  if aElement.ClassID=2 then
    Set_SpatialElement(aElement);
end;

procedure TWarriorPath.Initialize;
var
  WarriorPathElementClassID:integer;
begin
  inherited;
  WarriorPathElementClassID:=GetWarriorPathElementClassID;
  FWarriorPathElements:=DataModel.CreateCollection(WarriorPathElementClassID, Self as IDMElement);
  FOvercomingBoundaries:=DataModel.CreateCollection(_OvercomingBoundary, Self as IDMElement);
  FPathNodes:=DataModel.CreateCollection(-1, Self as IDMElement);
end;

function TWarriorPath.GetWarriorPathElementClassID:integer;
begin
 Result:=_WarriorPathElement
end;

destructor TWarriorPath.Destroy;
begin
  inherited;
  FWarriorPathElements:=nil;
  FOvercomingBoundaries:=nil;
  FFirstNode:=nil;
  FPathNodes:=nil;
end;


procedure TWarriorPath.Clear;
var
  WarriorPathElements2:IDMCollection2;
  WarriorPathElementE:IDMElement;
begin
  if DataModel<>nil then begin
    WarriorPathElements2:=(DataModel as IFacilityModel).WarriorPathElements as IDMCollection2;
    while FWarriorPathElements.Count>0 do begin
      WarriorPathElementE:=FWarriorPathElements.Item[FWarriorPathElements.Count-1];
      WarriorPathElementE.Clear;
      WarriorPathElements2.Remove(WarriorPathElementE);
    end;
  end;
  
  inherited;
end;

procedure TWarriorPath.ClearOp;
begin
  inherited;
end;

function TWarriorPath.Get_Kind: integer;
begin
  Result:=FKind
end;

procedure TWarriorPath.Set_Kind(Value: integer);
begin
  FKind:=Value
end;

procedure TWarriorPath.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  j:integer;
  Painter:IPainter;
  Layer:ILayer;
  AnalysisVariant:IAnalysisVariant;
  FacilityModelS:IFMState;
begin
  if SpatialElement<>nil then begin
    Layer:=SpatialElement.Parent as ILayer;
    if Layer=nil then Exit;
    if not Layer.Visible then Exit;
  end;

  if (Parent<>nil) and
     (Parent.QueryInterface(IAnalysisVariant, AnalysisVariant)=0) then begin
    FacilityModelS:=DataModel as IFMState;
    if (not Selected) and
       (AnalysisVariant<>FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant) then
      Exit;
  end;
  
  Painter:=aPainter as IPainter;

  Painter.PenMode:=ord(pmCopy);
  Painter.PenWidth:=0;
  Painter.PenStyle:=2;

  for j:=0 to FWarriorPathElements.Count-1 do
    FWarriorPathElements.Item[j].Draw(aPainter, DrawSelected);
end;

procedure TWarriorPath.Set_Selected(Value: WordBool);
var
  Document:IDMDocument;
  Painter:IUnknown;
begin
  inherited;
  if SpatialElement<>nil then Exit;
  if DataModel=nil then Exit;
  if DataModel.InUndoRedo then Exit;
  Document:=DataModel.Document as IDMDocument;
  Painter:=(Document as ISMDocument).PainterU;
  if Painter=nil then Exit;
  if Get_Selected then
    Draw(Painter, 1)
  else
    Draw(Painter, 0);
end;

function TWarriorPath.Get_WarriorPathElements: IDMCollection;
begin
  Result:=FWarriorPathElements
end;

function TWarriorPath.Get_DelayTimeDispersion: double;
begin
  Result:=FDelayTimeDispersion
end;

procedure TWarriorPath.BuildReport(ReportLevel, TabCount, Mode: Integer;
  const Report: IDMText);
var
  S, S0, Tabs, MaxLenS, ModeName:WideString;
  MaxLen, Len, Len0,
  j, m,
  GuardDelaysCount, NodeDirection, PathArcKind, OldState,
  WarriorPathStage, FastPathStage, StealthPathStage:integer;
  FacilityStateE,
  WarriorGroupE, WarriorPathElementE:IDMElement;
  WarriorGroup:IWarriorGroup;
  FacilityModelS:IFMState;
  FacilityModel:IFacilityModel;
  SpatialModel:ISpatialModel;
  WarriorPathElement:IWarriorPathElement;
  T, TDisp, dT, dTDisp, dT0, dTDisp0, DetP, NoDetP,
  NoDetPer, NoFailureP,
  DelayTimeDispersionRatio, PedestrialVelocity:double;
  NoEvidence:WordBool;
  PathElementE,
  BoundaryLayerE, Zone0E, Zone1E, BestTacticE, ElementStateE:IDMElement;
  Zone:IZone;
  Boundary:IBoundary;
  Target:ITarget;
  SafeguardElement:ISafeguardElement;
  PathElement, PathElement1:IPathElement;
  FacilityElement:IFacilityElement;
  Document:IDMDocument;
  OldCurrentLayer:ILayer;
  DirectPath:boolean;
  FacilityState:IFacilityState;
  Observers:IDMCollection;

  TMPLine:ILine;
  TMPC0, TMPC1:ICoordNode;
  TMPLineE, TMPC0E, TMPC1E, BackPathSubStateE:IDMElement;
  BackPathSubState:IFacilitySubState;
  BestTimeSum, BestTimeDispSum:double;
  Position:integer;

  procedure SetWarriorPathElement;
  var
    RefPathElement:IRefPathElement;
  begin
    RefPathElement:=WarriorPathElementE as IRefPathElement;
    PathElementE:=WarriorPathElementE.Ref;
    PathElement:=PathElementE as IPathElement;

    PathArcKind:=RefPathElement.PathArcKind;
    NodeDirection:=RefPathElement.Direction;

    TMPLineE.Ref:=PathElementE;
    TMPC0.X:=RefPathElement.X0;
    TMPC0.Y:=RefPathElement.Y0;
    TMPC0.Z:=RefPathElement.Z0;
    TMPC0E.Ref:=RefPathElement.Ref0;
    TMPC1.X:=RefPathElement.X1;
    TMPC1.Y:=RefPathElement.Y1;
    TMPC1.Z:=RefPathElement.Z1;
    TMPC1E.Ref:=RefPathElement.Ref1;
    FacilityModelS.CurrentLineU:=TMPLineE;
    FacilityModelS.CurrentPathArcKind:=PathArcKind;
    FacilityModelS.CurrentNodeDirection:=NodeDirection;
  end;

  procedure CalcSafeguadCount;
  var
    m:integer;
  begin
    GuardDelaysCount:=0;
    for m:=0 to Observers.Count-1 do begin
      SafeguardElement:=Observers.Item[m] as ISafeguardElement;
      if SafeguardElement.IsPresent then
        inc(GuardDelaysCount);
    end;
  end;

  procedure MakeHeader(CommentMode:integer);
  var
    j:integer;
  begin
    S:=Format('| %-'+MaxLenS+'s', [ModeName]);
    S:=S+' |   T, с';
    case WarriorPathStage of
    wpsStealthEntry,
    wpsStealthExit:
      S:=S+' |    P  ';
    end;
    case CommentMode of
    0: S:=S+' | Наилучшая тактика';
    1: S:=S+' | Примечания';
    end;

    Len0:=Length(S);
    S0:='';
    for j:=1 to Len0 do
      S0:=S0+'_';
    Report.AddLine(S0);

    S0:='|';
    for j:=1 to MaxLen+2 do
      S0:=S0+'_';
    S0:=S0+'|';
    for j:=1 to 8 do
      S0:=S0+'_';
    case WarriorPathStage of
    wpsStealthEntry,
    wpsStealthExit:
      begin
        S0:=S0+'|';
        for j:=1 to 8 do
          S0:=S0+'_';
      end;
    end;
    S0:=S0+'|';
    for j:=1 to Len0-MaxLen-22 do
      S0:=S0+'_';

    Report.AddLine(S);
    Report.AddLine(S0);
  end;

begin
  FacilityModelS:=DataModel as IFMState;
  if FacilityModelS=nil then Exit;
  FacilityModel:=FacilityModelS as IFacilityModel;
  SpatialModel:=FacilityModel as ISpatialModel;

  ModeName:=Get_ReportModeName(Mode);

  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  FacilityState:=FacilityStateE as IFacilityState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  WarriorGroup:=WarriorGroupE as IWarriorGroup;

  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  OldCurrentLayer:=SpatialModel.CurrentLayer;
  SpatialModel.CurrentLayer:=nil;

  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfChanging;
  try

  TMPLineE:=(SpatialModel.Lines as IDMCollection2).CreateElement(True);
  TMPC0E:=(SpatialModel.CoordNodes as IDMCollection2).CreateElement(True);
  TMPC1E:=(SpatialModel.CoordNodes as IDMCollection2).CreateElement(True);
  TMPLine:=TMPLineE as ILine;;
  TMPC0:=TMPC0E as ICoordNode;
  TMPC1:=TMPC1E as ICoordNode;
  TMPLine.C0:=TMPC0;
  TMPLine.C1:=TMPC1;

  BackPathSubStateE:=(FacilityModel.FacilitySubStates as IDMCollection2).CreateElement(True);
  BackPathSubState:=BackPathSubStateE as IFacilitySubState;

  Tabs:='';
  for j:=0 to TabCount-1 do
    Tabs:=Tabs+#9;
  S:=Tabs+'Маршрут "'+Name+'" ';
  Report.AddLine(S);
  Tabs:=Tabs+#9;
  S:=Tabs+Format('Минимальное время прохождения всего маршрута %6.0fc',[FDelayTime]);
  Report.AddLine(S);
  S:=Tabs+Format('Вероятность необнаружения на всем маршруте %6.4f',[FNoDetectionProbability]);
  Report.AddLine(S);
  S:=Tabs+Format('Вероятность успеха нарушителей %6.4f',[FRationalProbability]);
  Report.AddLine(S);
  if ReportLevel=0 then
    Exit;

  S:='"'+WarriorGroupE.Name+'"  "'+FacilityStateE.Name+'" ';
  case WarriorPathStage of
  wpsStealthEntry:
    S:=S+'Скрытное прохождение';
  wpsFastEntry:
    S:=S+'Быстрое прохождение';
  wpsStealthExit:
    S:=S+'Скрытное прохождение';
  wpsFastExit:
    S:=S+'Быстрое прохождение';
  end;
  Report.AddLine(S);
  Report.AddLine('');

  case Mode of
  0:begin
      MaxLen:=Length(ModeName)+1;
      for j:=0 to FWarriorPathElements.Count-1 do begin
        Len:=Length(FWarriorPathElements.Item[j].Name);
        if MaxLen<Len then MaxLen:=Len;
      end;
      MaxLenS:=IntToStr(MaxLen);

      MakeHeader(1);

      for j:=0 to FWarriorPathElements.Count-1 do begin
        WarriorPathElementE:=FWarriorPathElements.Item[j];

        SetWarriorPathElement;

        S:=Format('| %-'+MaxLenS+'s', [WarriorPathElementE.Name]);
        dT:=WarriorPathElement.dT;
        NoDetP:=WarriorPathElement.NoDetP;
        DetP:=1-NoDetP;
        S:=S+Format(' | %6.0f', [dT]);
        S:=S+Format(' | %6.4f |', [DetP]);
        Report.AddLine(S);
      end; //for j:=0 to WarriorPath.WarriorPathElements.Count-1
    end;
  1:begin
      MaxLen:=Length(ModeName)+1;
      try
      for j:=0 to FWarriorPathElements.Count-1 do begin
        WarriorPathElementE:=FWarriorPathElements.Item[j];
        PathElementE:=WarriorPathElementE.Ref;

        if PathElementE=nil then begin
          Len:=Length(WarriorPathElementE.Name);
          if MaxLen<Len then MaxLen:=Len;
        end else
        if PathElementE.QueryInterface(IZone, Zone)=0 then begin
          Len:=Length(PathElementE.Name);
          if MaxLen<Len then MaxLen:=Len;
        end else
        if PathElementE.QueryInterface(IBoundary, Boundary)=0 then begin
          if NodeDirection=pdFrom0To1 then begin
            Zone0E:=Boundary.Zone0;
            Zone1E:=Boundary.Zone1;
          end else begin
            Zone1E:=Boundary.Zone0;
            Zone0E:=Boundary.Zone1;
          end;
          Observers:=Boundary.Observers;

          CalcSafeguadCount;
          if PathElementE.Ref.Parent.ID<>btVirtual then begin // не условная граница
            for m:=0 to Boundary.BoundaryLayers.Count-1 do begin
              Len:=Length(Boundary.BoundaryLayers.Item[m].Name);
              if MaxLen<Len then MaxLen:=Len;
            end;
          end;
        end else
        if PathElementE.QueryInterface(ITarget, Target)=0 then begin
          Len:=Length('Операции с целевым предметом');
          if MaxLen<Len then MaxLen:=Len;
        end;
      end;
      except
        DataModel.HandleError('Error in TWarriorPath.BuildReport');
      end;

      MaxLenS:=IntToStr(MaxLen);

      MakeHeader(0);
      DirectPath:=True;
      try
      for j:=0 to FWarriorPathElements.Count-1 do begin
        WarriorPathElementE:=FWarriorPathElements.Item[j];

        SetWarriorPathElement;
        if DirectPath then begin
          StealthPathStage:=wpsStealthEntry;
          FastPathStage:=wpsFastEntry;
        end else begin
          StealthPathStage:=wpsStealthExit;
          FastPathStage:=wpsFastExit;
        end;

        if PathElementE=nil then begin
          S:=Format('| %-'+MaxLenS+'s', [WarriorPathElementE.Name]);
          S:=S+' |    ?  ';
          S:=S+' |    ?  ';
          S:=S+' | Движение по дороге (данные не сохранены)';
          Report.AddLine(S);
        end else
        if PathElementE.QueryInterface(IZone, Zone)=0 then begin
          FacilityModelS.CurrentPathStage:=FastPathStage;
          PathElement.CalcDelayTime(dT, dTDisp, BestTacticE, 0);
          FacilityModelS.CurrentPathStage:=StealthPathStage;
          PathElement.CalcNoDetectionProbability(
              NoDetPer, NoFailureP, NoEvidence,
              BestTimeSum, BestTimeDispSum,
              Position,
              BestTacticE, 0);
          NoDetP:=NoDetPer;
          DetP:=1-NoDetP;
          S:=Format('| %-'+MaxLenS+'s', [WarriorPathElementE.Name]);
          S:=S+Format(' | %6.0f', [dT]);
          S:=S+Format(' | %6.4f', [DetP]);
          if BestTacticE<>nil then
            S:=S+' | '+BestTacticE.Name
          else
            S:=S+' | Тактика не определена';
          Report.AddLine(S);
        end else
        if PathElementE.QueryInterface(IBoundary, Boundary)=0 then begin
          if NodeDirection=pdFrom0To1 then begin
            Zone0E:=Boundary.Zone0;
            Zone1E:=Boundary.Zone1;
          end else begin
            Zone1E:=Boundary.Zone0;
            Zone0E:=Boundary.Zone1;
          end;
          Observers:=Boundary.Observers;

          CalcSafeguadCount;
          if TMPLine<>nil then begin
            PedestrialVelocity:=5;
            T:=TMPLine.Length/(PedestrialVelocity*100);
            TDisp:=sqr(DelayTimeDispersionRatio*T);
            if Boundary.BoundaryLayers.Count>0 then begin
              dT0:=T/Boundary.BoundaryLayers.Count;
              dTDisp0:=TDisp/Boundary.BoundaryLayers.Count;
            end else begin
              dT0:=T;
              dTDisp0:=TDisp;
            end;
          end else begin
            dT0:=0;
            dTDisp0:=0;
          end;

          if PathElementE.Ref.Parent.ID<>btVirtual then begin // не условная граница
            for m:=0 to Boundary.BoundaryLayers.Count-1 do begin
              BoundaryLayerE:=Boundary.BoundaryLayers.Item[m];
              PathElement1:=BoundaryLayerE as IPathElement;

              FacilityModelS.CurrentPathStage:=FastPathStage;
              PathElement1.CalcDelayTime(dT, dTDisp, BestTacticE, 0);
              dT:=dT+dT0;
              dTDisp:=dTDisp+dTDisp0;

              FacilityModelS.CurrentPathStage:=StealthPathStage;
              PathElement1.CalcNoDetectionProbability(
                  NoDetPer, NoFailureP, NoEvidence,
                  BestTimeSum, BestTimeDispSum,
                  Position, BestTacticE, 0);
              NoDetP:=NoDetPer;
              DetP:=1-NoDetP;
              S:=Format('| %-'+MaxLenS+'s', [BoundaryLayerE.Name]);
              S:=S+Format(' | %6.0f', [dT]);
              S:=S+Format(' | %6.4f', [DetP]);
              if BestTacticE<>nil then
                S:=S+' | '+BestTacticE.Name
              else
                S:=S+' | Тактика не определена';
              Report.AddLine(S);
            end;
          end;
            if (GuardDelaysCount>0) then begin
            FacilityModelS.CurrentPathStage:=FastPathStage;
            Boundary.CalcExternalDelayTime(dT, dTDisp, BestTacticE);
            FacilityModelS.CurrentPathStage:=StealthPathStage;
            S:=Format('| %-'+MaxLenS+'s', ['Отход от рубежа '+WarriorPathElementE.Name]);
            S:=S+Format(' | %6.0f', [dT]);
            S:=S+' | 0';
            if BestTacticE<>nil then
              S:=S+' | '+BestTacticE.Name
            else
              S:=S+' | Тактика не определена';
            Report.AddLine(S);
          end; // if (VolumeSensorsCount1>0) or (GuardDelaysCount>0) then begin
        end; // if PathElementE.QueryInterface(IBoundary, Boundary)=0
        if DirectPath and
         (PathElementE<>nil) and
         (PathElementE.QueryInterface(IFacilityElement, FacilityElement)=0) then
          FacilityElement.MakeBackPathElementStates(BackPathSubStateE);
        if (PathElementE<>nil) and
           (PathElementE.QueryInterface(ITarget, Target)=0) then begin
          if DirectPath and
             (j<FWarriorPathElements.Count-1) then begin // возврат
            Boundary:=PathElementE as IBoundary;
            FacilityModelS.CurrentPathStage:=FastPathStage;
            Boundary.CalcExternalDelayTime(dT, dTDisp, BestTacticE);
            FacilityModelS.CurrentPathStage:=StealthPathStage;

            S:=Format('| %-'+MaxLenS+'s', ['Операции с целевым предметом']);
            S:=S+Format(' | %6.0f', [dT]);
            S:=S+Format(' | %6.4f', [0]);
            S:=S+' | ';
            Report.AddLine(S);

            DirectPath:=False;
            FacilityState.AddSubState(BackPathSubStateE);
          end;
        end;
      end; // for j:=0 to WarriorPath.WarriorPathElements.Count-1
      finally
        FacilityState.RemoveSubState(BackPathSubStateE);
        while BackPathSubState.ElementStates.Count>0 do begin
          ElementStateE:=BackPathSubState.ElementStates.Item[0];
          ElementStateE.Clear;
        end;
      end;
    end;
  end;  // case Mode

  finally
    SpatialModel.CurrentLayer:=OldCurrentLayer;
    Document.State:=OldState;
  end;
end;

function TWarriorPath.Get_ReportModeCount: integer;
begin
  Result:=2;
end;

function TWarriorPath.Get_ReportModeName(Index: integer): WideString;
begin
  case Index of
  0:Result:='Участки маршрута';
  1:Result:='Последовательность действий';
  else
    Result:=inherited Get_ReportModeName(Index);
  end;
end;

function TWarriorPath.GetResponceTime: double;
var
  AnalysisVariant:IAnalysisVariant;
  FacilityModelS:IFMState;
begin
  Result:=0;
  FacilityModelS:=DataModel as IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;
  Result:=AnalysisVariant.ResponceTime;
end;

function TWarriorPath.GetResponceTimeDispersion: double;
var
  AnalysisVariant:IAnalysisVariant;
  FacilityModelS:IFMState;
begin
  Result:=0;
  FacilityModelS:=DataModel as IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;
  Result:=AnalysisVariant.ResponceTimeDispersion;
end;

procedure TWarriorPath.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(wpCriticalPoint):
    theCollection:=(DataModel as IDMElement).Collection[_WarriorPathElement];
  else
    begin
      inherited
    end;
  end;

  if aCollection=nil then
    aCollection:=theCollection
  else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;
    if theCollection=nil then Exit;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

function TWarriorPath.Get_CriticalPoint: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FCriticalPoint;
  Result:=Unk as IDMElement
end;

procedure TWarriorPath.Set_CriticalPoint(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FCriticalPoint:=Unk;
end;

function TWarriorPath.DoOperation(ColIndex, Index: Integer; var Param1, Param2,
  Param3: OleVariant): WordBool;
begin
  Result:=False;
  case Index of
  0: Rebuild(False);
  1: if not SavePath then Exit;
  else
    Exit;
  end;
  Result:=True;
end;

function TWarriorPath.GetOperationName(ColIndex, Index: Integer): WideString;
begin
  case Index of
  0:Result:='Анализировать маршрут';
  1:Result:='Сохранить маршрут';
  else
    Result:='';
  end
end;

function TWarriorPath.SavePath: boolean;
var
  Document:IDMDocument;
  Server:IDataModelServer;
  OperationManager:IDMOperationManager;
  UserDefinedPaths, LineGroups, Lines, CoordNodes:IDMCollection;
  Unk:IUnknown;
  LayerE, LineGroupE, aLineE, LineE, UserDefinedPathE:IDMElement;
  theLineGroup:ILineGroup;
  j:integer;
  aLine, Line:ILine;
  aC0, aC1, C0, C1, oldC0, oldC1, lastC0, lastC1:ICoordNode;
  X, Y, Z,
  oldX0, oldY0, oldZ0, oldX1, oldY1, oldZ1,
  X0, Y0, Z0, X1, Y1, Z1:double;
  WarriorPathElementE, aWarriorPathElementE:IDMElement;
  aWarriorPathElement:IWarriorPathElement;
  aRefPathElement:IRefPathElement;
begin
  Document:=DataModel.Document as IDMDocument;
  Server:=Document.Server;
  OperationManager:=Document as IDMOperationManager;
  LayerE:=(DataModel as IFacilityModel).UserDefinedPathLayer;

  Lines:=(DataModel as IDMElement).Collection[_Line];
  CoordNodes:=(DataModel as IDMElement).Collection[_CoordNode];
  LineGroups:=(DataModel as IDMElement).Collection[_LineGroup];

  OperationManager.AddElement(LayerE, LineGroups, '', ltOneToMany, Unk, True);
  LineGroupE:=Unk as IDMElement;

  if SpatialElement<>nil then begin
    theLineGroup:=SpatialElement as ILineGroup;

    oldC0:=nil;
    oldC1:=nil;
    lastC0:=nil;
    lastC1:=nil;
    for j:=0 to theLineGroup.Lines.Count-1 do  begin
      aLineE:=theLineGroup.Lines.Item[j];
      aLine:=aLineE as ILine;

      OperationManager.AddElement(LayerE, Lines, '', ltOneToMany, Unk, True);
      LineE:=Unk as IDMElement;
      Line:=LineE as ILine;

      OperationManager.AddElementParent(LineGroupE ,LineE);

      aC0:=aLine.C0;
      aC1:=aLine.C1;

      if aC0=oldC0 then
        C0:=lastC0
      else
      if aC0=oldC1 then
        C0:=lastC1
      else begin
        X:=aC0.X;
        Y:=aC0.Y;
        Z:=aC0.Z;
        OperationManager.AddElement(LayerE, CoordNodes, '', ltOneToMany, Unk, True);
        OperationManager.ChangeFieldValue(Unk, ord(cooX), True, X);
        OperationManager.ChangeFieldValue(Unk, ord(cooY), True, Y);
        OperationManager.ChangeFieldValue(Unk, ord(cooZ), True, Z);
        C0:=Unk as ICoordNode;
      end;

      if aC1=oldC0 then
        C1:=lastC0
      else
      if aC1=oldC1 then
        C1:=lastC1
      else begin
        X:=aC1.X;
        Y:=aC1.Y;
        Z:=aC1.Z;
        OperationManager.AddElement(LayerE, CoordNodes, '', ltOneToMany, Unk, True);
        OperationManager.ChangeFieldValue(Unk, ord(cooX), True, X);
        OperationManager.ChangeFieldValue(Unk, ord(cooY), True, Y);
        OperationManager.ChangeFieldValue(Unk, ord(cooZ), True, Z);
        C1:=Unk as ICoordNode;
      end;

      OperationManager.ChangeFieldValue(Line, ord(linC0), True, C0);
      OperationManager.ChangeFieldValue(Line, ord(linC1), True, C1);

      oldC0:=aC0;
      oldC1:=aC1;
      lastC0:=C0;
      lastC1:=C1;
    end;
  end  else begin // if SpatialElement=nil

    oldX0:=-InfinitValue;
    oldY0:=-InfinitValue;
    oldZ0:=-InfinitValue;
    oldX1:=-InfinitValue;
    oldY1:=-InfinitValue;
    oldZ1:=-InfinitValue;
    lastC0:=nil;
    lastC1:=nil;
    for j:=0 to FWarriorPathElements.Count-1 do  begin
      aWarriorPathElementE:=FWarriorPathElements.Item[j];
      aWarriorPathElement:=aWarriorPathElementE as IWarriorPathElement;
      aRefPathElement:=aWarriorPathElementE as IRefPathElement;

      OperationManager.AddElement(LayerE, Lines, '', ltOneToMany, Unk, True);
      LineE:=Unk as IDMElement;
      Line:=LineE as ILine;

      OperationManager.AddElementParent(LineGroupE ,LineE);

      X0:=aRefPathElement.X0;
      Y0:=aRefPathElement.Y0;
      Z0:=aRefPathElement.Z0;
      X1:=aRefPathElement.X1;
      Y1:=aRefPathElement.Y1;
      Z1:=aRefPathElement.Z1;

      if (X0=oldX0) and
         (Y0=oldY0) and
         (Z0=oldZ0) then
        C0:=lastC0
      else
      if (X0=oldX1) and
         (Y0=oldY1) and
         (Z0=oldZ1) then
        C0:=lastC1
      else begin
        OperationManager.AddElement(LayerE, CoordNodes, '', ltOneToMany, Unk, True);
        OperationManager.ChangeFieldValue(Unk, ord(cooX), True, X0);
        OperationManager.ChangeFieldValue(Unk, ord(cooY), True, Y0);
        OperationManager.ChangeFieldValue(Unk, ord(cooZ), True, Z0);
        C0:=Unk as ICoordNode;
      end;

      if (X1=oldX0) and
         (Y1=oldY0) and
         (Z1=oldZ0) then
        C1:=lastC0
      else
      if (X1=oldX1) and
         (Y1=oldY1) and
         (Z1=oldZ1) then
        C1:=lastC1
      else begin
        OperationManager.AddElement(LayerE, CoordNodes, '', ltOneToMany, Unk, True);
        OperationManager.ChangeFieldValue(Unk, ord(cooX), True, X1);
        OperationManager.ChangeFieldValue(Unk, ord(cooY), True, Y1);
        OperationManager.ChangeFieldValue(Unk, ord(cooZ), True, Z1);
        C1:=Unk as ICoordNode;
      end;

      OperationManager.ChangeFieldValue(Line, ord(linC0), True, C0);
      OperationManager.ChangeFieldValue(Line, ord(linC1), True, C1);

      oldX0:=X0;
      oldY0:=Y0;
      oldZ0:=Z0;
      oldX1:=X1;
      oldY1:=Y1;
      oldZ1:=Z1;
      lastC0:=C0;
      lastC1:=C1;
    end;
  end;

  UserDefinedPaths:=(DataModel as IDMElement).Collection[_UserDefinedPath];

  OperationManager.AddElement(nil, UserDefinedPaths, Name, ltOneToMany, Unk, True);
  UserDefinedPathE:=Unk as IDMElement;
  OperationManager.ChangeRef(nil, '', UserDefinedPathE, LineGroupE);

  for j:=0 to FWarriorPathElements.Count-1 do  begin
    aWarriorPathElementE:=FWarriorPathElements.Item[j];
    Unk:=OperationManager.CreateClone(aWarriorPathElementE);
    WarriorPathElementE:=Unk as IDMElement;
    OperationManager.ChangeParent(nil, UserDefinedPathE, WarriorPathElementE);
  end;

  Result:=True;
end;

procedure TWarriorPath.AfterLoading2;
var
  WarriorPathElements2:IDMCollection2;
  Sorter:ISorter;
begin
  inherited;
  WarriorPathElements2:=FWarriorPathElements as IDMCollection2;
  Sorter:=TWarriorPathElementSorter.Create(nil) as ISorter;
  WarriorPathElements2.Sort(Sorter);
end;

procedure TWarriorPath.Rebuild(RefreshDocument:WordBool);
var
  Document:IDMDocument;
begin
  if (not DataModel.IsLoading) and
     (not DataModel.IsCopying) and
     (Get_WarriorPathElements<>nil) then begin
    Build(tmToRoot, False, True, nil);
    DoAnalysis(nil, True);
    Document:=DataModel.Document as IDMDocument;
    (Document.Server as IDataModelServer).RefreshElement(Self as IUnknown);
    if RefreshDocument then
      (Document.Server as IDataModelServer).RefreshDocument(rfFrontBack);
  end;
end;

function TWarriorPath.Get_OvercomingBoundaries: IDMCollection;
begin
  Result:=FOvercomingBoundaries
end;

function TWarriorPath.Get_FirstNode: IDMElement;
begin
  Result:=FFirstNode;
end;

function TWarriorPath.Get_PathNodes: IDMCollection;
begin
  Result:=FPathNodes;
end;

procedure TWarriorPath.Set_FirstNode(const Value: IDMElement);
begin
  FFirstNode:=Value

end;

procedure TWarriorPath.ChangeBackPath;
var
  SubStates2:IDMCollection2;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  j:integer;
  theWarriorPathElements:IDMCollection;
  FacilityElementE:IDMElement;
  FacilityElement:IFacilityElement;
  FacilityState:IFacilityState;
begin
  if GBackPathSubStateE=nil then begin
    FacilityModel:=DataModel as IFacilityModel;
    SubStates2:=FacilityModel.FacilitySubStates as IDMCollection2;
    GBackPathSubStateE:=SubStates2.CreateElement(False);
    GBackPathSubStateE.Name:='Выведенные из строя средства защиты';
  end else
    GBackPathSubStateE.Clear;

  FacilityModelS:=DataModel as IFMState;
  FacilityState:=FacilityModelS.CurrentFacilityStateU as IFacilityState;
  FacilityState.AddSubState(GBackPathSubStateE);

  theWarriorPathElements:=Get_WarriorPathElements;
  j:=0;
  while j<theWarriorPathElements.Count do begin
    FacilityElementE:=theWarriorPathElements.Item[j].Ref;
    if FacilityElementE.QueryInterface(IFacilityElement, FacilityElement)=0 then
       FacilityElement.MakeBackPathElementStates(GBackPathSubStateE);
    if FacilityElementE.ClassID=_Target then
      Break
    else
      inc(j);
  end;
end;

procedure TWarriorPath.ClearBackPath;
var
  BackPathSubState:IFacilitySubState;
  ElementStateE:IDMElement;
  FacilityModelS:IFMState;
  FacilityState:IFacilityState;
begin
  FacilityModelS:=DataModel as IFMState;
  FacilityState:=FacilityModelS.CurrentFacilityStateU as IFacilityState;
  FacilityState.RemoveSubState(GBackPathSubStateE);

  BackPathSubState:=GBackPathSubStateE as IFacilitySubState;
  while BackPathSubState.ElementStates.Count>0 do begin
    ElementStateE:=BackPathSubState.ElementStates.Item[0];
    ElementStateE.Clear;
  end;
end;

function TWarriorPath.GetShortCut(ColIndex, Index: Integer): WideString;
begin
  Result:='';
end;

function TWarriorPath.Get_GuardTacticFlag: WordBool;
begin
  Result:=FGuardTacticFlag
end;

procedure TWarriorPath.Set_GuardTacticFlag(Value: WordBool);
begin
  FGuardTacticFlag:=Value
end;

{ TWarriorPaths }

class function TWarriorPaths.GetElementClass: TDMElementClass;
begin
  Result:=TWarriorPath;
end;

function TWarriorPaths.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsWarriorPath;
end;

class function TWarriorPaths.GetElementGUID: TGUID;
begin
  Result:=IID_IWarriorPath;
end;

procedure TWarriorPaths.Initialize;
begin
  inherited;
end;

{ TWarriorPathSorter }

{ TWarriorPathElementSorter }

function TWarriorPathElementSorter.Compare(const Key1,
  Key2: IDMElement): Integer;
//var
//  WarriorPathElement1, WarriorPathElement2:IWarriorPathElement;
begin
{
  WarriorPathElement1:=Key1 as IWarriorPathElement;
  WarriorPathElement2:=Key2 as IWarriorPathElement;
  if WarriorPathElement1.T>WarriorPathElement2.T then
    Result:=-1
  else
  if WarriorPathElement1.T<WarriorPathElement2.T then
    Result:=+1
  else
  if WarriorPathElement1.P>WarriorPathElement2.P then
    Result:=-1
  else
  if WarriorPathElement1.P<WarriorPathElement2.P then
    Result:=+1
  else
}
  if (Key1 as IRefPathElement).N<(Key2 as IRefPathElement).N then
    Result:=-1
  else
  if (Key1 as IRefPathElement).N>(Key2 as IRefPathElement).N then
    Result:=+1
  else
    Result:=0
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TWarriorPath.MakeFields;

  FSeparatingAreas:=TDMCollection.Create(nil) as IDMCollection;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
  FSeparatingAreas:=nil;
  if GBackPathSubStateE<>nil then begin
    GBackPathSubStateE.Clear;
    GBackPathSubStateE:=nil;
  end;
end.
