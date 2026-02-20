unit PathArcU;

interface
uses
  Classes, SysUtils, Math, Dialogs,
  DMElementU, LineU,
  DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardAnalyzerLib_TLB;//, DebugU;

type
  TPathArc=class(TLine, IPathArc2, IPathArc)
  private
    FFacilityState: IDMElement;
    FKind: integer;
    FValue:double;
    FEnabled:boolean;
    FDelayTime:double;

  protected
    class function  GetClassID:integer; override;

    procedure Set_Ref(const Value:IDMElement); override; safecall;
    procedure Set_Parent(const Value:IDMElement); override; safecall;

//  IPathArc

    function  Get_FacilityState: IDMElement; safecall;
    procedure Set_FacilityState(const Value: IDMElement); safecall;
    function  Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;

//  IPathArc2

    function  Get_Value:double; safecall;
    procedure Set_Value(Value: double); safecall;
    function  Get_Enabled:WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function  NewDistanceFromRoot(const PrevNodeE, NextNodeE: IDMElement): double; safecall;
    function  Get_DelayTime:double; safecall;
    procedure OnUpdateBestDistance(CalcMode:integer); safecall;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    procedure Set_Selected(Value: WordBool); override;

    procedure Initialize; override;
  end;

  TPathArcs=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SafeguardAnalyzerConstU, Geometry;
  
{ TPathArc }

class function TPathArc.GetClassID: integer;
begin
  Result:=_PathArc
end;


function TPathArc.Get_FacilityState: IDMElement;
begin
  Result:=FFacilityState
end;

procedure TPathArc.Set_FacilityState(const Value: IDMElement);
begin
  FFacilityState:=Value
end;

function TPathArc.Get_Kind: Integer;
begin
  Result:=FKind
end;

procedure TPathArc.Set_Kind(Value: Integer);
begin
  FKind:=Value
end;

function TPathArc.Get_Value: double;
begin
  Result:=FValue
end;

procedure TPathArc.Set_Value(Value: double);
begin
  FValue:=Value
end;

procedure TPathArc.Draw(const aPainter:IUnknown; DrawSelected:integer);
var
  C0, C1:ICoordNode;
  Painter:IPainter;
  X, Y, Z:double;
  S:string;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  if C0.Z<=-InfinitValue then Exit;
  if C1.Z<=-InfinitValue then Exit;
  if not FEnabled then Exit;
  inherited;

  Painter:=aPainter as IPainter;
  X:=0.5*(C0.X+C1.X);
  Y:=0.5*(C0.Y+C1.Y);
  Z:=0.5*(C0.Z+C1.Z);
  S:=IntToStr(ID);
  Painter.DrawText(X, Y, Z, S, 0,
   'Arial', 8, 0, 0, 0);
//   'Arial', 40, 0, 0, 0);

end;

procedure TPathArc.Set_Ref(const Value:IDMElement);
begin
  case id of
  3621:
   xxx:=0;
  end;

  inherited
end;

procedure TPathArc.Set_Selected(Value: WordBool);
var
  OldRef:IDMElement;
begin
  OldRef:=Ref;
  Ref:=nil;
  inherited;
  Ref:=OldRef;
end;

function TPathArc.NewDistanceFromRoot(const PrevNodeE, NextNodeE: IDMElement): double;
var
  SafeguardAnalyzer:ISafeguardAnalyzer;
  PrevNode2, NextNode2, aPrevNode2, aNextNode2:IPathNode2;
  PrevNode, NextNode, aPrevNode, aNextNode:IPathNode;
  NodeDirection, PathStage:integer;
  PrevNodeC, NextNodeC, C0, C1:ICoordNode;
  PathElement:IPathElement;
  PathNodeV:IVulnerabilityData;
  PathNoDetectionProbability, FuncNoDetectionProbability,
  PathSuccessProbability,
  DelayTime, DelayTimeDispersion,
  PathSoundResistance, FuncSoundResistance,
  OutstripProbability:double;
  FacilityModelS:IFMState;
  GuardStrategy:integer;
  BestTacticE:IDMElement;
  aPathArcE:IDMElement;
  aPathArcL:ILine;
  aPathArc2:IPathArc2;
  aPathArc:IPathArc;
  j, j0, j1:integer;
  aPrevNodeE, aNextNodeE:IDMElement;
  PathArcs2,PathNodes2:IDMCollection2;
  Zone2:IZone2;
  PathArcs:IDMCollection;
  aZone:IZone;
  NextBoundary:IBoundary;
  NextBoundaryE:IDMElement;
  NoDetP, NoPrelDetP:double;
  NoEvidence:WordBool;
begin
  PrevNode:=PrevNodeE as IPathNode;
  PrevNode2:=PrevNodeE as IPathNode2;
  NextNode:=NextNodeE as IPathNode;
  NextNode2:=NextNodeE as IPathNode2;
  Result:=PrevNode.BestDistance;

  SafeguardAnalyzer:=DataModel as ISafeguardAnalyzer;
  SafeguardAnalyzer.DistanceFunc:=PrevNode2.DistanceFunc;
  SafeguardAnalyzer.DistanceFunc1:=PrevNode2.DistanceFunc1;
  SafeguardAnalyzer.DistanceFunc2:=PrevNode2.DistanceFunc2;
  SafeguardAnalyzer.DistanceFunc3:=PrevNode2.DistanceFunc3;


  PathElement:=Ref as IPathElement;
  if PathElement=nil then Exit;


  PrevNodeC:=PrevNodeE as ICoordNode;
  if PrevNodeC.Z<=-InfinitValue then  Exit;  //если исходящий узел является точкой старта, то выходим

  NextNodeC:=NextNodeE as ICoordNode;

  if NextNodeC.Z<=-InfinitValue then begin  //если входящий узел является точкой старта, то выходим
    Result:=InfinitValue;
    Exit;
  end;

  C0:=Get_C0;
  C1:=Get_C1;
  if C0.Z<=-InfinitValue then Exit;
  if C1.Z<=-InfinitValue then Exit;

  try
  if FKind=pakRZone then begin
    Zone2:=Ref as IZone2;
    if (not Zone2.IsConvex) or
       (Zone2.InnerZoneOutlineCount>0) then begin
      PathArcs2:=SafeguardAnalyzer.PathArcs as IDMCollection2;
      PathNodes2:=SafeguardAnalyzer.PathNodes as IDMCollection2;

      if SafeguardAnalyzer.TreeMode=tmFromRoot then begin
        Zone2.MakeRoundaboutPath(PrevNodeE, NextNodeE,
                                 PathArcs2,PathNodes2);
        PathArcs:=(Zone2 as IFacilityElement).PathArcs;
        j0:=0;
        j1:=PathArcs.Count;
      end else begin
        Zone2.MakeRoundaboutPath(NextNodeE, PrevNodeE,
                                 PathArcs2,PathNodes2);
        PathArcs:=(Zone2 as IFacilityElement).PathArcs;
        j0:=PathArcs.Count-1;
        j1:=-1;
      end;

      if PathArcs.Count>0 then begin
        aPrevNode:=nil;

//              if (SafeguardAnalyzer.CalcMode=admGet_RationalProbabilityToTarget) then
//                writeln(DebugFile, Format('%d', [id]));

        j:=j0;
        while j<>j1 do begin  // проходим по пути обхода препятствий
          aPathArcE:=PathArcs.Item[j];
          aPathArc2:=aPathArcE as IPathArc2;
          aPathArcL:=aPathArcE as ILine;
          aPathArc:=aPathArcE as IPathArc;
          aPathArc.Kind:=pakTMP;
          if j=j0 then begin
            if j1>j0 then
              aPrevNodeE:=aPathArcL.C0 as IDMElement
            else
              aPrevNodeE:=aPathArcL.C1 as IDMElement;
            aPrevNode:=aPrevNodeE as IPathNode;
            aPrevNode2:=aPrevNodeE as IPathNode2;
            aPrevNode.BestDistance:=PrevNode.BestDistance;
            aPrevNode2.DistanceFunc:=PrevNode2.DistanceFunc;
            aPrevNode2.DistanceFunc1:=PrevNode2.DistanceFunc1;
            aPrevNode2.DistanceFunc2:=PrevNode2.DistanceFunc2;
            aPrevNode2.DistanceFunc3:=PrevNode2.DistanceFunc3;
          end;
          aNextNodeE:=aPathArcL.NextNodeTo(aPrevNodeE as ICoordNode) as IDMElement;
          aNextNode:=aNextNodeE as IPathNode;
          aNextNode2:=aNextNodeE as IPathNode2;
          aNextNode.BestDistance:=aPathArc2.NewDistanceFromRoot(aPrevNodeE, aNextNodeE);
          aNextNode2.OnUpdateBestDistance(SafeguardAnalyzer.CalcMode);
{
              if (SafeguardAnalyzer.CalcMode=admGet_RationalProbabilityToTarget) then
                writeln(DebugFile, Format('j=%5d d=%-9.2f x=%-9.0f y=%-9.0f',
                          [j, aNextNode.DistanceFunc1,
                          (aNextNode as ICoordNode).x,
                          (aNextNode as ICoordNode).y]));
}

          aPrevNodeE:=aNextNodeE;
          if j1>j0 then
            inc(j)
          else
            dec(j)
        end;

        Result:=aNextNode.BestDistance;

        Zone2.ClearRoundaboutPath;
        Exit;
      end else
        Zone2.ClearRoundaboutPath;
    end; // if (not Zone2.IsConvex) or ...
  end;  // if FKind=pakRZone
  except
    DataModel.HandleError('Error in TPathArc.NewDistanceFromRoot ID='+IntToStr(ID));
  end;


  try
  case SafeguardAnalyzer.CalcMode of
  admGet_SuccessProbabilityToTarget:
    PathNodeV:=PrevNodeC as IVulnerabilityData;
  admGet_RationalProbabilityToTarget:
    PathNodeV:=PrevNodeC as IVulnerabilityData;
  admGet_BackPathRationalProbability:
    PathNodeV:=PrevNodeC as IVulnerabilityData;
  admGet_SuccessProbabilityFromStart:
    PathNodeV:=NextNodeC as IVulnerabilityData;
  else
    PathNodeV:=nil;
  end;

  if (Ref.QueryInterface(IZone, aZone)=0) and
     (PrevNodeC<>nil) and
     (PrevNodeC.Lines.Count>0) and
     (PrevNodeC.Lines.Item[0].Ref.QueryInterface(IBoundary, NextBoundary)=0) then
    NextBoundaryE:=NextBoundary as IDMElement
  else
    NextBoundaryE:=nil;

  FacilityModelS:=(SafeguardAnalyzer as IDMAnalyzer).Data as IFMState;
  FacilityModelS.CurrentFacilityStateU:=FFacilityState;

  if SafeguardAnalyzer.TreeMode=tmToRoot then begin
    if (PrevNodeC=C1) or
       (NextNodeC=C0) then
      NodeDirection:=pdFrom0To1
    else
      NodeDirection:=pdFrom1To0;
  end else begin
    if (PrevNodeC=C1) or
       (NextNodeC=C0) then
      NodeDirection:=pdFrom1To0
    else
      NodeDirection:=pdFrom0To1;
  end;
  PathStage:=SafeguardAnalyzer.PathStage;
  FacilityModelS.CurrentNodeDirection:=NodeDirection;
  FacilityModelS.CurrentPathArcKind:=FKind;
  FacilityModelS.CurrentPathStage:=PathStage;
  FacilityModelS.CurrentFacilityStateU:=FFacilityState;
  FacilityModelS.CurrentLineU:=Self as IUnknown;

  if FacilityModelS.CurrentAnalysisVariantU<>nil then
    GuardStrategy:=(FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant).GuardStrategy
  else
    GuardStrategy:=0;

  case SafeguardAnalyzer.CalcMode of
  admGet_DelayTimeToTarget,
  admGet_BackPathDelayTime,
  admGet_DelayTimeFromStart:
    begin
      PathElement.CalcDelayTime(FDelayTime, DelayTimeDispersion, BestTacticE, 0);

      Result:=PrevNode.BestDistance+FDelayTime;
      SafeguardAnalyzer.DistanceFunc:=PrevNode2.DistanceFunc+DelayTimeDispersion;
    end;
  admGet_NoDetectionProbability:
    begin
      PathNoDetectionProbability:=-PrevNode.BestDistance;
      PathElement.CalcPathNoDetectionProbability(
                          PathNoDetectionProbability,
                          NoDetP, NoPrelDetP, NoEvidence, 0);
      Result:=-PathNoDetectionProbability;
    end;
  admGet_RationalProbabilityToTarget,
  admGet_BackPathRationalProbability,
  admGet_SuccessProbabilityToTarget,
  admGet_SuccessProbabilityFromStart:
    begin
      PathSuccessProbability:=-PrevNode.BestDistance;

      DelayTime:=PrevNode2.DistanceFunc1;
      DelayTimeDispersion:=PrevNode2.DistanceFunc2;
      if (GuardStrategy=1) and
         (PathStage<>wpsFastExit) and
         (PathStage<>wpsStealthExit) and
         (DelayTime=0) then begin
          DelayTime:=DelayTime + FacilityModelS.TotalBackPathDelayTime;
          DelayTimeDispersion:=DelayTimeDispersion + FacilityModelS.TotalBackPathDelayTimeDispersion;
      end;
      PathElement.CalcPathSuccessProbability(
                                  PathSuccessProbability,
                                  OutstripProbability,
                                  DelayTime, DelayTimeDispersion, 0);
      Result:=-PathSuccessProbability;
      SafeguardAnalyzer.DistanceFunc1:=DelayTime;
      SafeguardAnalyzer.DistanceFunc2:=DelayTimeDispersion;
    end;
  admGet_SoundResistance:
    begin
      PathSoundResistance:=PrevNode.BestDistance;
      FuncSoundResistance:=PrevNode2.DistanceFunc;
      PathElement.CalcPathSoundResistance(
                                    PathSoundResistance, FuncSoundResistance);
      Result:=PathSoundResistance;
      SafeguardAnalyzer.DistanceFunc:=FuncSoundResistance;
    end;
  else;
  end;
  SafeguardAnalyzer.PathStage:=PathStage;
  except
    DataModel.HandleError('Error in TPathArc.NewDistanceFromRoot ID='+IntToStr(ID));
  end;
end;

function TPathArc.Get_Enabled: WordBool;
var
  PathElement:IPathElement;
begin
  Result:=FEnabled;
  if not Result then Exit;
  PathElement:=Ref as IPathElement;
  if PathElement=nil then
    Result:=False
  else
    Result:=not PathElement.Disabled
end;

procedure TPathArc.Set_Enabled(Value: WordBool);
begin
  FEnabled:=Value
end;

procedure TPathArc.Initialize;
var
  Unk:IUnknown;
begin
  inherited;
  FEnabled:=True;
  if DataModel=nil then Exit;
  if (DataModel as IDMElement).QueryInterface(ISpatialModel, Unk)<>0 then Exit;
  Parent:=SpatialModel.CurrentLayer as IDMElement;
end;

procedure TPathArc.Set_Parent(const Value: IDMElement);
begin
  if Value<>nil then
    inherited;
end;

function TPathArc.Get_DelayTime: double;
begin
  Result:=FDelayTime
end;

procedure TPathArc.OnUpdateBestDistance(CalcMode: integer);
begin
end;

{ TPathArcs }

function TPathArcs.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsPathArc
end;

class function TPathArcs.GetElementClass: TDMElementClass;
begin
  Result:=TPathArc
end;

class function TPathArcs.GetElementGUID: TGUID;
begin
  Result:=IID_IPathArc2
end;

end.
