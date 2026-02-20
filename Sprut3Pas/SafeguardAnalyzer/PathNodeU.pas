unit PathNodeU;

interface
uses
  Classes, SysUtils,
  DMElementU, CoordNodeU,
  DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardAnalyzerLib_TLB;

type
  PPathRecord=^TPathRecord;
  TPathRecord=record
    CalcMode:integer;
    Subject:IDMElement;
    AnalysisVariant:IDMElement;
    BestDistanceFromRoot: double;
    DistanceFunc: double;
    BestNextArc: IDMElement;
    BestNextNode: IDMElement;
    DistanceFunc1: double;
    DistanceFunc2: double;
    DistanceFunc3: double;
  end;


  TPathNode=class(TCoordNode, IPathNode, IPathNode2, IVulnerabilityData)
  private
    FBestDistance: double;
    FBestNextArc: IDMElement;
    FBestNextNode: IDMElement;
    FDistanceFunc:double;
    FDistanceFunc1:double;
    FDistanceFunc2:double;
    FDistanceFunc3:double;
    FPathRecords:TList;
    FKind:integer;
    FUsed:boolean;
  protected
    class function  GetClassID:integer; override;

    procedure Set_Parent(const Value:IDMElement); override; safecall;

    function Get_BestDistance: double; safecall;
    procedure Set_BestDistance(Value: double); safecall;
    function Get_BestNextArc: IDMElement; safecall;
    procedure Set_BestNextArc(const Value: IDMElement); safecall;
    function Get_BestNextNode: IDMElement; safecall;
    procedure Set_BestNextNode(const Value: IDMElement); safecall;
    function Get_DistanceFunc: double; safecall;
    procedure Set_DistanceFunc(Value: double); safecall;
    function Get_DistanceFunc1: double; safecall;
    procedure Set_DistanceFunc1(Value: double); safecall;
    function Get_DistanceFunc2: double; safecall;
    procedure Set_DistanceFunc2(Value: double); safecall;
    function Get_DistanceFunc3: double; safecall;
    procedure Set_DistanceFunc3(Value: double); safecall;
    function Get_Used:WordBool; safecall;
    procedure Set_Used(Value:WordBool); safecall;
    function  Get_Kind: Integer; safecall;
    procedure Set_Kind(Value: Integer); safecall;

    procedure ResetBestDistance(IsRoot:WordBool); safecall;
    procedure OnUpdateBestDistance(CalcMode:integer); safecall;
    procedure ClearAllRecords; safecall;
    procedure StoreRecord(aCalcMode: integer; const aSubject: IDMElement); safecall;
    procedure RestoreRecord(aCalcMode: integer); safecall;

    function  Get_DelayTimeToTarget: Double; safecall;
    function  Get_DelayTimeToTargetDispersion: double; safecall;
    function  Get_BackPathDelayTime:double; safecall;
    function  Get_BackPathDelayTimeDispersion:double; safecall;
    function  Get_NoDetectionProbabilityFromStart: Double; safecall;
    function  Get_SuccessProbabilityToTarget: Double; safecall;
    function  Get_SuccessProbabilityFromStart: Double; safecall;
    function  Get_RationalProbabilityToTarget: Double; safecall;
    function  Get_BackPathRationalProbability: Double; safecall;

    function  Get_DelayTimeToTarget_NextNode: IDMElement; safecall;
    function  Get_DelayTimeToTarget_NextArc: IDMElement; safecall;
    function  Get_NoDetectionProbabilityFromStart_NextNode: IDMElement; safecall;
    function  Get_NoDetectionProbabilityFromStart_NextArc: IDMElement; safecall;
    function  Get_SuccessProbabilityToTarget_NextNode: IDMElement; safecall;
    function  Get_SuccessProbabilityToTarget_NextArc: IDMElement; safecall;
    function  Get_SuccessProbabilityFromStart_NextNode: IDMElement; safecall;
    function  Get_SuccessProbabilityFromStart_NextArc: IDMElement; safecall;
    function  Get_RationalProbabilityToTarget_NextNode: IDMElement; safecall;
    function  Get_RationalProbabilityToTarget_NextArc: IDMElement; safecall;
    function  Get_BackPathRationalProbability_NextNode: IDMElement; safecall;
    function  Get_BackPathRationalProbability_NextArc: IDMElement; safecall;
    function Get_DelayTimeFromStart: Double; safecall;
    function Get_DelayTimeFromStart_NextNode: IDMElement; safecall;
    function Get_DelayTimeFromStartDispersion: Double; safecall;
    function Get_DelayTimeFromStart_NextArc: IDMElement; safecall;
    function Get_MainDelayTimeFromStart: Double; safecall;
    function Get_MainDelayTimeToTarget: Double; safecall;
    function GetDelayTimeFromStart(const WarriorGroupE: IDMElement; out DelayTime: Double;
                                   out DelayTimeDispersion: Double): WordBool; virtual; safecall;
    function GetDelayTimeToTarget(const WarriorGroupE: IDMElement; out DelayTime: Double;
                                  out DelayTimeDispersion: Double): WordBool; virtual;  safecall;

    procedure MakeFastestPath(const Collection:IDMCollection); safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TPathNodes=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SafeguardAnalyzerConstU;

{ TPathNode }

function TPathNode.Get_BestDistance: double;
begin
  Result:=FBestDistance
end;

function TPathNode.Get_BestNextArc: IDMElement;
begin
  Result:=FBestNextArc
end;

class function TPathNode.GetClassID: integer;
begin
  Result:=_PathNode
end;


procedure TPathNode.OnUpdateBestDistance(CalcMode:integer);
var
  SafeguardAnalyzer:ISafeguardAnalyzer;
begin
  SafeguardAnalyzer:=DataModel as ISafeguardAnalyzer;
  FDistanceFunc:=SafeguardAnalyzer.DistanceFunc;
  FDistanceFunc1:=SafeguardAnalyzer.DistanceFunc1;
  FDistanceFunc2:=SafeguardAnalyzer.DistanceFunc2;
  FDistanceFunc3:=SafeguardAnalyzer.DistanceFunc3;
end;

procedure TPathNode.ResetBestDistance(IsRoot:WordBool);
var
  SafeguardAnalyzer:ISafeguardAnalyzer;
  CalcMode:integer;
begin
  FUsed:=False;
  FBestNextArc:=nil;
  SafeguardAnalyzer:=DataModel as ISafeguardAnalyzer;
  CalcMode:=SafeguardAnalyzer.CalcMode;
  if IsRoot then begin
    case CalcMode of
    admGet_DelayTimeToTarget,
    admGet_BackPathDelayTime,
    admGet_DelayTimeFromStart:
      begin
        FBestDistance:=0;
        FDistanceFunc:=0;
        FDistanceFunc1:=0;
        FDistanceFunc2:=0;
        FDistanceFunc3:=0;
      end;
    admGet_RationalProbabilityToTarget,
    admGet_BackPathRationalProbability:
      begin
        FBestDistance:=-1;
        FDistanceFunc:=-1;
        FDistanceFunc1:=0;
        FDistanceFunc2:=0;
        FDistanceFunc3:=0;
      end;
    admGet_NoDetectionProbability:
      begin
        FBestDistance:=-1;
        FDistanceFunc:=-1;
        FDistanceFunc1:=-1;
        FDistanceFunc2:=-1;
        FDistanceFunc3:=-1;
      end;
    admGet_SuccessProbabilityToTarget:
      begin
        FBestDistance:=-1;
        FDistanceFunc:=-1;
        FDistanceFunc1:=0;
        FDistanceFunc2:=0;
        FDistanceFunc3:=0;
      end;
    admGet_SuccessProbabilityFromStart:
      begin
        FBestDistance:=-1;
        FDistanceFunc:=-1;
        FDistanceFunc1:=-1;
        FDistanceFunc2:=0;
        FDistanceFunc3:=0;
      end;
    admGet_SoundResistance:
      begin
        FBestDistance:=0;
        FDistanceFunc:=0;
        FDistanceFunc1:=0;
        FDistanceFunc2:=0;
        FDistanceFunc3:=0;
      end;
    end;
  end else begin
    FBestDistance:=InfinitValue;
    FDistanceFunc:=InfinitValue;
    FDistanceFunc1:=InfinitValue;
    FDistanceFunc2:=InfinitValue;
    FDistanceFunc3:=InfinitValue;
  end;
end;

procedure TPathNode.Set_BestDistance(Value: double);
begin
  FBestDistance:=Value
end;

procedure TPathNode.Set_BestNextArc(const Value: IDMElement);
begin
  FBestNextArc:=Value
end;

procedure TPathNode.StoreRecord(aCalcMode: integer;
  const aSubject: IDMElement);
var
  PathRecord:PPathRecord;
begin
  GetMem(PathRecord, SizeOf(TPathRecord));
  FillChar(PathRecord^, SizeOf(TPathRecord), 0);
  FPathRecords.Add(PathRecord);
  try
  PathRecord^.CalcMode:=aCalcMode;
  PathRecord^.Subject:=aSubject;
  PathRecord^.AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IDMElement;

  PathRecord^.BestDistanceFromRoot:=FBestDistance;
  PathRecord^.DistanceFunc:=FDistanceFunc;
  PathRecord^.DistanceFunc1:=FDistanceFunc1;
  PathRecord^.DistanceFunc2:=FDistanceFunc2;
  PathRecord^.DistanceFunc3:=FDistanceFunc3;
  PathRecord^.BestNextNode:=FBestNextNode;
  PathRecord^.BestNextArc:=FBestNextArc

  except
    DataModel.HandleError('Error in TPathNode.StoreRecord ID='+IntToStr(ID));
  end
end;

procedure TPathNode.Initialize;
begin
  inherited;
  Set_X(-InfinitValue);
  Set_X(-InfinitValue);
  Set_Z(-InfinitValue);

  FPathRecords:=TList.Create;
  FUsed:=False;
end;

procedure TPathNode._Destroy;
begin
  inherited;
  ClearAllRecords;
  FPathRecords.Free;
end;

procedure TPathNode.ClearAllRecords;
var
  PathRecord:PPathRecord;
  j:integer;
begin
  for j:=0 to FPathRecords.Count-1 do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    PathRecord^.Subject:=nil;
    PathRecord^.AnalysisVariant:=nil;
    PathRecord^.BestNextNode:=nil;
    PathRecord^.BestNextArc:=nil;
    FreeMem(PathRecord, SizeOf(TPathRecord));
  end;
  FPathRecords.Clear;
end;

function TPathNode.Get_DelayTimeToTargetDispersion: double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupU as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.DistanceFunc
  else
    Result:=InfinitValue;
end;

function TPathNode.Get_DelayTimeToTarget: double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupU as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestDistanceFromRoot
  else
    Result:=InfinitValue;
end;

function TPathNode.Get_NoDetectionProbabilityFromStart: double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupU as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_NoDetectionProbability) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=-PathRecord^.BestDistanceFromRoot
  else
    Result:=-InfinitValue;
end;

function TPathNode.Get_SuccessProbabilityToTarget: double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_SuccessProbabilityToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=-PathRecord^.BestDistanceFromRoot
  else
    Result:=-InfinitValue;
end;

function TPathNode.Get_DistanceFunc: double;
begin
  Result:=FDistanceFunc
end;

procedure TPathNode.Set_DistanceFunc(Value: double);
begin
  FDistanceFunc:=Value
end;

function TPathNode.Get_DelayTimeToTarget_NextNode: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextNode
  else
    Result:=nil;
end;

function TPathNode.Get_DelayTimeToTarget_NextArc: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextArc
  else
    Result:=nil;
end;

function TPathNode.Get_SuccessProbabilityToTarget_NextNode: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_SuccessProbabilityToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextNode
  else
    Result:=nil;
end;

function TPathNode.Get_SuccessProbabilityToTarget_NextArc: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_SuccessProbabilityToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextArc
  else
    Result:=nil;
end;

function TPathNode.Get_NoDetectionProbabilityFromStart_NextNode: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_NoDetectionProbability) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextNode
  else
    Result:=nil;
end;

function TPathNode.Get_NoDetectionProbabilityFromStart_NextArc: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_NoDetectionProbability) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextArc
  else
    Result:=nil;
end;

function TPathNode.Get_Kind: Integer;
begin
  Result:=FKind
end;

procedure TPathNode.Set_Kind(Value: Integer);
begin
  FKind:=Value
end;

procedure TPathNode.MakeFastestPath(const Collection: IDMCollection);
var
  PathNode:IPathNode;
  aNode0E, aNode1E:IDMElement;
  aNode0, aNode1, aNode:ICoordNode;
  aPathArcE:IDMElement;
  m:integer;
  Collection2: IDMCollection2;
begin
  Collection2:=Collection as IDMCollection2;
  Collection2.Clear;

  aNode0E:=Self as IDMElement;
  PathNode:=aNode0E as IPathNode;
  aNode0:=aNode0E as ICoordNode;

  while PathNode<>nil do begin
    aNode1E:=PathNode.BestNextArc;
    if aNode1E=PathNode as IDMElement then Break;
    aNode1:=aNode1E as ICoordNode;
    aPathArcE:=nil;
    for m:=0 to aNode0.Lines.Count-1 do begin
      aPathArcE:=aNode0.Lines.Item[m];
      aNode:=(aPathArcE as ILine).NextNodeTo(aNode0);
      if aNode=aNode1 then
        Break;
    end;
    if aPathArcE<>nil then begin
      if Collection.IndexOf(aPathArcE)<>-1 then
        Break;
      Collection2.Add(aPathArcE);
    end;
    aNode0:=aNode1;
    PathNode:=aNode1 as IPathNode;
  end;
end;

function TPathNode.Get_Used: WordBool;
begin
  Result:=FUsed
end;

procedure TPathNode.Set_Used(Value: WordBool);
begin
  FUsed:=Value
end;

procedure TPathNode.RestoreRecord(aCalcMode: integer);
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
  SafeguardAnalyzer:ISafeguardAnalyzer;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=aCalcMode) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then begin
    FBestDistance:=PathRecord^.BestDistanceFromRoot;
    FDistanceFunc:=PathRecord^.DistanceFunc;
    FDistanceFunc1:=PathRecord^.DistanceFunc1;
    FDistanceFunc2:=PathRecord^.DistanceFunc2;
    FDistanceFunc3:=PathRecord^.DistanceFunc3;
    FBestNextNode:=PathRecord^.BestNextNode;
    FBestNextArc:=PathRecord^.BestNextArc;
    SafeguardAnalyzer:=DataModel as ISafeguardAnalyzer;
    SafeguardAnalyzer.CalcMode:=aCalcMode;
    case aCalcMode of
    admGet_DelayTimeToTarget,
    admGet_RationalProbabilityToTarget,
    admGet_BackPathDelayTime,
    admGet_BackPathRationalProbability,
    admGet_DelayTimeFromStart:
       SafeguardAnalyzer.TreeMode:=tmToRoot;
    admGet_NoDetectionProbability:
       SafeguardAnalyzer.TreeMode:=tmFromRoot;
    admGet_SuccessProbabilityToTarget:
       SafeguardAnalyzer.TreeMode:=tmToRoot;
    admGet_SuccessProbabilityFromStart:
       SafeguardAnalyzer.TreeMode:=tmFromRoot;
    end;
  end;
end;

procedure TPathNode.Set_Parent(const Value: IDMElement);
begin
  if Value<>nil then
    inherited;
end;

function TPathNode.Get_SuccessProbabilityFromStart: Double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_SuccessProbabilityFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=-PathRecord^.BestDistanceFromRoot
  else
    Result:=-InfinitValue;
end;

function TPathNode.Get_SuccessProbabilityFromStart_NextNode: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_SuccessProbabilityFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;

  Result:=PathRecord^.BestNextNode
end;

function TPathNode.Get_SuccessProbabilityFromStart_NextArc: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_SuccessProbabilityFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;

  Result:=PathRecord^.BestNextArc
end;

function TPathNode.Get_RationalProbabilityToTarget: Double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_RationalProbabilityToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=-PathRecord^.BestDistanceFromRoot
  else
    Result:=-InfinitValue;
end;

function TPathNode.Get_RationalProbabilityToTarget_NextNode: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_RationalProbabilityToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;

  if j<FPathRecords.Count then
      Result:=PathRecord^.BestNextNode
  else
    Result:=nil;
end;

function TPathNode.Get_RationalProbabilityToTarget_NextArc: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_RationalProbabilityToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;

  if j<FPathRecords.Count then
      Result:=PathRecord^.BestNextArc
  else
    Result:=nil;
end;

function TPathNode.Get_DistanceFunc1: double;
begin
  Result:=FDistanceFunc1
end;

procedure TPathNode.Set_DistanceFunc1(Value: double);
begin
  FDistanceFunc1:=Value
end;

function TPathNode.Get_DistanceFunc2: double;
begin
  Result:=FDistanceFunc2
end;

procedure TPathNode.Set_DistanceFunc2(Value: double);
begin
  FDistanceFunc2:=Value
end;

function TPathNode.Get_DistanceFunc3: double;
begin
  Result:=FDistanceFunc3
end;

procedure TPathNode.Set_DistanceFunc3(Value: double);
begin
  FDistanceFunc3:=Value
end;

function TPathNode.Get_BackPathDelayTimeDispersion: double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_BackPathDelayTime) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
//    if PathRecord^.CalcMode=admGet_BackPathDelayTime then
      Result:=PathRecord^.DistanceFunc
//    else
//      Result:=PathRecord^.DistanceFunc2
  else
    Result:=InfinitValue;
end;

function TPathNode.Get_BackPathDelayTime: double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_BackPathDelayTime) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
//    if PathRecord^.CalcMode=admGet_BackPathDelayTime then
      Result:=PathRecord^.BestDistanceFromRoot
//    else
//      Result:=PathRecord^.DistanceFunc1
  else
    Result:=InfinitValue;
end;

function TPathNode.Get_BackPathRationalProbability: Double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_BackPathRationalProbability) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=-PathRecord^.BestDistanceFromRoot
  else
    Result:=-InfinitValue;
end;

function TPathNode.Get_BackPathRationalProbability_NextNode: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_BackPathRationalProbability) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;

  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextNode
  else
    Result:=nil;

end;

function TPathNode.Get_BackPathRationalProbability_NextArc: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_BackPathRationalProbability) and
       (PathRecord^.AnalysisVariant=AnalysisVariant as IDMElement) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;

  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextArc
  else
    Result:=nil;

end;

function TPathNode.Get_BestNextNode: IDMElement;
begin
  Result:=FBestNextNode
end;

procedure TPathNode.Set_BestNextNode(const Value: IDMElement);
begin
  FBestNextNode:=Value
end;

function TPathNode.Get_DelayTimeFromStart: Double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupU as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestDistanceFromRoot
  else
    Result:=InfinitValue;
end;

function TPathNode.Get_DelayTimeFromStart_NextArc: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextArc
  else
    Result:=nil;
end;

function TPathNode.Get_DelayTimeFromStart_NextNode: IDMElement;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupu as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestNextNode
  else
    Result:=nil;
end;

function TPathNode.Get_DelayTimeFromStartDispersion: Double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentWarriorGroupU as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.DistanceFunc
  else
    Result:=InfinitValue;
end;

function TPathNode.Get_MainDelayTimeFromStart: Double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=AnalysisVariant.MainGroup as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestDistanceFromRoot
  else
    Result:=InfinitValue;
end;

function TPathNode.Get_MainDelayTimeToTarget: Double;
var
  AnalysisVariant:IAnalysisVariant;
  WarriorGroup:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  WarriorGroup:=AnalysisVariant.MainGroup as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroup) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.BestDistanceFromRoot
  else
    Result:=InfinitValue;
end;

function TPathNode.GetDelayTimeFromStart(const WarriorGroupE: IDMElement;
  out DelayTime, DelayTimeDispersion: Double): WordBool;
var
  AnalysisVariant:IAnalysisVariant;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeFromStart) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroupE) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then begin
    DelayTime:=PathRecord^.BestDistanceFromRoot;
    DelayTimeDispersion:=PathRecord^.DistanceFunc;
    Result:=True;
  end else begin
    DelayTime:=InfinitValue;
    DelayTimeDispersion:=InfinitValue;
    Result:=False;
  end
end;

function TPathNode.GetDelayTimeToTarget(const WarriorGroupE: IDMElement;
  out DelayTime, DelayTimeDispersion: Double): WordBool;
var
  AnalysisVariant:IAnalysisVariant;
  j:integer;
  PathRecord:PPathRecord;
begin
  AnalysisVariant:=((DataModel as IDMAnalyzer).Data as IFMState).CurrentAnalysisVariantU as IAnalysisVariant;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if (PathRecord^.CalcMode=admGet_DelayTimeToTarget) and
       (PathRecord^.AnalysisVariant=AnalysisVariant.BaseAnalysisVariant) and
       (PathRecord^.Subject=WarriorGroupE) then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then begin
    DelayTime:=PathRecord^.BestDistanceFromRoot;
    DelayTimeDispersion:=PathRecord^.DistanceFunc;
    Result:=True;
  end else begin
    DelayTime:=InfinitValue;
    DelayTimeDispersion:=InfinitValue;
    Result:=False;
  end
end;

{ TPathNodes }

function TPathNodes.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsPathNode
end;

class function TPathNodes.GetElementClass: TDMElementClass;
begin
  Result:=TPathNode
end;

class function TPathNodes.GetElementGUID: TGUID;
begin
  Result:=IID_IPathNode
end;

end.
