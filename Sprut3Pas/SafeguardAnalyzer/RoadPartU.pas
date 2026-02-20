unit RoadPartU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB,
  DMServer_TLB,
  SafeguardAnalyzerLib_TLB,
  FacilityModelLib_TLB, SpatialModelLib_TLB;

type

  TRoadPart=class(TDMElement, IRoadPart, IPathElement)
  private
    FRoad:IRoad;
  protected
    class function  GetClassID:integer; override;
    procedure Set_Road(const Value: IRoad); safecall;
    function  Get_Road: IRoad; safecall;
    function  Get_Name: WideString; override; safecall;

    procedure CalcDelayTime(out DelayTime, DelayTimeDispersion: Double;
                            out BestTacticE:IDMElement; AddDelay:double); virtual; safecall;
    procedure CalcNoDetectionProbability(
                           out NoDetP, NoPrelDetP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                           out BestTacticE:IDMElement; AddDelay:double); virtual; safecall;
    procedure CalcPathNoDetectionProbability(
                      var PathNoDetectionProbability:double;
                      out NoDetP, NoPrelDetP:double;
                      out NoEvidence: WordBool; AddDelay:double); virtual; safecall;
    procedure CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out OutstripProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                          AddDelay:double); virtual; safecall;
    procedure CalcPathSoundResistance(
                      var PathSoundResistance,
                          FuncSoundResistance: double); virtual; safecall;
    procedure DoCalcDelayTime(const TacticU:IUnknown;
                      out DelayTime, DelayTimeDisparsion:double; AddDelay:double); virtual; safecall;
    procedure DoCalcNoDetectionProbability(const TacticU:IUnknown;
                          DetectionTime:double;
                      out NoDetP, NoPrelDetP:double;
                      out NoEvidence:WordBool;
                      out BestTimeSum, BestTimeDispSum:double;
                      out Position:integer; AddDelay:double); virtual; safecall;
    procedure DoCalcPathSuccessProbability(const TacticU:IUnknown;
                          DetectionTime:double;
                      var SuccessProbability:double;
                     out OutstripProbability: double;
                     out StealthT: Double;
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner:double;
                          AddDelay:double); virtual; safecall;
    function  Get_Disabled:WordBool; safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TRoadParts=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SafeguardAnalyzerConstU;

{ TRoadPart }

class function TRoadPart.GetClassID: integer;
begin
  Result:=_RoadPart;
end;

function TRoadPart.Get_Road: IRoad;
begin
  Result:=FRoad
end;

procedure TRoadPart.Set_Road(const Value: IRoad);
begin
  FRoad:=Value;
end;

procedure TRoadPart.Initialize;
begin
  inherited;
end;

procedure TRoadPart._Destroy;
begin
  inherited;
  FRoad:=nil;
end;

function TRoadPart.Get_Name: WideString;
begin
  if Ref=nil then
    Result:=inherited Get_Name +' / ' + (FRoad as IDMElement).Name
  else
    Result:=rsRoadPart + ' '+IntToStr(ID)+' / ' +
           (FRoad as IDMElement).Name+' / '+
           Ref.Name;
end;

procedure TRoadPart.CalcDelayTime(out DelayTime, DelayTimeDispersion: Double;
                                  out BestTacticE:IDMElement; AddDelay:double);
var
  PathElement:IPathElement;
begin
  PathElement:=Ref as IPathElement;
  if PathElement<>nil then
    PathElement.CalcDelayTime(DelayTime, DelayTimeDispersion, BestTacticE, AddDelay);
end;

procedure TRoadPart.CalcPathNoDetectionProbability(
                      var PathNoDetectionProbability:double;
                      out NoDetP, NoPrelDetP:double;
                      out NoEvidence: WordBool; AddDelay:double);
var
  PathElement:IPathElement;
begin
  PathElement:=Ref as IPathElement;
  if PathElement<>nil then
    PathElement.CalcPathNoDetectionProbability(
                      PathNoDetectionProbability,
                      NoDetP, NoPrelDetP, NoEvidence, AddDelay);
end;

procedure TRoadPart.CalcPathSoundResistance(
                      var PathSoundResistance,
                          FuncSoundResistance: double);
var
  Line:ILine;
  Analyzer:IDMAnalyzer;
  FacilityModelS:IFMState;
begin
  Analyzer:=DataModel as IDMAnalyzer;
  FacilityModelS:=Analyzer.Data as IFMState;
  Line:=FacilityModelS.CurrentLineU as ILine;
  FuncSoundResistance:=FuncSoundResistance+Line.Length
end;

procedure TRoadPart.CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out OutstripProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                          AddDelay:double);
var
  PathElement:IPathElement;
begin
  PathElement:=Ref as IPathElement;
  if PathElement<>nil then
    PathElement.CalcPathSuccessProbability(
                       SuccessProbability,
                       OutstripProbability,
                       DelayTimeSum,
                       DelayTimeDispersionSum, AddDelay);
end;

procedure TRoadPart.CalcNoDetectionProbability(
  out NoDetP, NoPrelDetP: double;
  out NoEvidence:WordBool;
  out BestTimeSum, BestTimeDispSum:double;
  out Position:integer;
  out BestTacticE:IDMElement; AddDelay:double);
var
  PathElement:IPathElement;
begin
  PathElement:=Ref as IPathElement;
  if PathElement<>nil then
    PathElement.CalcNoDetectionProbability(
       NoDetP,
       NoPrelDetP,
       NoEvidence, 
       BestTimeSum, BestTimeDispSum,
       Position,
       BestTacticE, AddDelay)
end;

procedure TRoadPart.DoCalcDelayTime(const TacticU: IInterface;
  out DelayTime, DelayTimeDisparsion: double; AddDelay:double);
var
  PathElement:IPathElement;
begin
  PathElement:=Ref as IPathElement;
  if PathElement<>nil then
    PathElement.DoCalcDelayTime(TacticU, DelayTime, DelayTimeDisparsion, AddDelay)
end;

procedure TRoadPart.DoCalcNoDetectionProbability(const TacticU: IInterface;
      DetectionTime:double;
  out NoDetP,
      NoPrelDetP:double;
  out NoEvidence:WordBool;
  out BestTimeSum, BestTimeDispSum: double;
  out Position:integer; AddDelay:double);
var
  PathElement:IPathElement;
begin
  PathElement:=Ref as IPathElement;
  if PathElement<>nil then
    PathElement.DoCalcNoDetectionProbability(TacticU,
           DetectionTime,
           NoDetP, NoPrelDetP,
           NoEvidence ,BestTimeSum, BestTimeDispSum, Position, AddDelay)
end;

procedure TRoadPart.DoCalcPathSuccessProbability(const TacticU: IInterface;
                          DetectionTime:double;
                      var SuccessProbability:double;
                      out OutstripProbability: double;
                      out StealthT: Double;
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner:double;
                          AddDelay:double);
var
  PathElement:IPathElement;
begin
  PathElement:=Ref as IPathElement;
  if PathElement<>nil then
    PathElement.DoCalcPathSuccessProbability(TacticU,
     DetectionTime,
     SuccessProbability,
     OutstripProbability, StealthT,
     DelayTimeSumOuter, DelayTimeDispersionSumOuter,
     DelayTimeSumInner, DelayTimeDispersionSumInner, AddDelay)
end;

function TRoadPart.Get_Disabled: WordBool;
begin
  Result:=False
end;

{ TRoadParts }

class function TRoadParts.GetElementClass: TDMElementClass;
begin
  Result:=TRoadPart;
end;

function TRoadParts.Get_ClassAlias(Index:integer): WideString;
begin
    Result:=rsRoadPart
end;

class function TRoadParts.GetElementGUID: TGUID;
begin
  Result:=IID_IRoadPart;
end;

end.
