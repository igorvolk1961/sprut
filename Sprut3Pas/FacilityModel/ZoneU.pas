unit ZoneU;

interface
uses
  Classes, SysUtils, Math, Dialogs,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  FacilityElementU, SprutikLib_TLB;

const
  Week=3600*24*7;

type
  THBoundaries=class(TCustomDMCollection)
  protected
// реализация интерфейса IDMCollection
    function  Get_Count: Integer; override; safecall;
    function  Get_Item(Index: Integer): IDMElement; override; safecall;
  end;

  TVBoundaries=class(TCustomDMCollection)
  protected
// реализация интерфейса IDMCollection
    function  Get_Count: Integer; override; safecall;
    function  Get_Item(Index: Integer): IDMElement; override; safecall;
  end;

  TZone=class(TFacilityElement, IZone, IZone2, IZone3, IPathElement,
              ISafeguardUnit, ISafeguardUnit2, IRotater, IWayElement)
  private
    FBuildIn: boolean;
    FParents:IDMCollection;

    FSafeguardElements:IDMCollection;

    FFloorNodes:IDMCollection;
    FCentralNode:IDMElement;
    FZoneNode:IDMElement;
    FLinkedZone:IZone;

    FRelativeDelayTimeToTarget:double;
    FHBoundaries:IDMCollection;
    FVBoundaries:IDMCollection;

    FCategory: Integer;
    FPersonalPresence: Integer;
    FPersonalCount: Integer;

    FPatrolPeriod:double;
    FPatrolPaths:IDMCollection;
    FObservers:IDMCollection;

    FTransparencyDist: Double;

    FUserDefinedVehicleVelocity:boolean;
    FVehicleVelocity:Double;
    FPedestrialVelocity:Double;

    FHAreas:IDMCollection;
    FVAreas:IDMCollection;

    FIsConvex:boolean;
    FOutline:IDMCollection;
    FInnerZoneOutlines:TList;

    FSettingParent:boolean;

    procedure UpdateDependingElements
             (const DependingSafeguardElementList,
                    theDependingSafeguardElementList,
                    BestOvercomeMethodList,
                    theBestOvercomeMethodList: TList);
    procedure UpdateDependingElementBestMethods
             (const theDependingSafeguardElementList,
                    theBestOvercomeMethodList: TList);
    function AcceptableTactic(const TacticU:IUnknown):WordBool;
    procedure CalcObservationPeriod(out ObservationPeriod, UserDefinedNoDetP:double);
    procedure SetCurrentDirection;
  protected
    FZones:IDMCollection;
    FJumps:IDMCollection;

    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;
    class procedure MakeFields0; override;

    procedure Set_Selected(Value:WordBool); override; safecall;
    procedure Update; override; safecall;
    procedure UpdateCoords; override; safecall;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;

    
    function  GetCopyLinkMode(const aLink: IDMElement): Integer; override; safecall;
    function  Get_Parents:IDMCollection; override; safecall;
    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure Set_SpatialElement(const Value: IDMElement); override; safecall;
    procedure Set_Ref(const Value: IDMElement); override; safecall;

    procedure AfterLoading2; override;
    procedure Set_Name(const Value:WideString); override; safecall;
    function  Get_BuildIn: WordBool; override; safecall;
    procedure Set_BuildIn(Value: WordBool); override; safecall;
    function  Get_FloorNodes:IDMCollection;  safecall;
    function  Get_CentralNode:IDMElement;  safecall;
    procedure Set_CentralNode(const Value:IDMElement);  safecall;
    function  Get_ZoneNode:IDMElement;  safecall;
    procedure Set_ZoneNode(const Value:IDMElement);  safecall;
    function  Get_IsEmpty: WordBool; override; safecall;

    class function GetFields:IDMCollection; override;

    procedure CalculateFieldValues; override;

    function Get_SafeguardElements:IDMCollection; safecall;

    procedure AddChild(const aChild:IDMElement); override;
    procedure RemoveChild(const aChild:IDMElement); override;
    procedure _AddChild(const aChild:IDMElement); override;
    procedure _RemoveChild(const aChild:IDMElement); override;

    function  Get_UserDefineded: WordBool; override; safecall;
    procedure _AddBackRef(const aElement:IDMElement); override;

    procedure Clear; override;

    class function  GetClassID:integer; override;

    function GetMovementDelayTime(var MovementKind:integer): double; safecall;
    procedure DoCalcDelayTime(const TacticU:IUnknown;
                      out DelayTime, DelayTimeDispersion:double; AddDelay:double); override; safecall;

    procedure DoCalcNoDetectionProbability(const TacticU:IUnknown;
                              ObservationPeriod:double;
                           out NoDetP, NoFailureP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                                AddDelay:double); override; safecall;

    procedure CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                            out BestTacticE:IDMElement; AddDelay:double); override;
    procedure CalcNoDetectionProbability(
                           out NoDetP, NoFailureP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                           out BestTacticE:IDMElement;
                                AddDelay:double); override;
    procedure DoCalcPathSuccessProbability(const TacticU:IUnknown;
                          ObservationPeriod:double;
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability,
                          StealthT: double;
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner:double;
                                AddDelay:double); override; safecall;
    procedure CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                                AddDelay:double); override; safecall;
   procedure CalcPathSoundResistance(
                      var PathSoundResistance,
                          FuncSoundResistance: double); override; safecall;
    function Get_InstallPrice:integer;
//           метод, возвращающий стоимость оборудования
//           данного сектора зоны
    function Get_MaintenancePrice:integer;
//           метод, возвращающий стоимость эксплуатации в течении года
//           данного сектора зоны
    function Contains(const aElement:IDMElement):WordBool; safecall;

    procedure MakeLinkedZone;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    function Get_Zones:IDMCollection; safecall;
    procedure Set_LinkedZone(const Value: IZone); safecall;
    function  Get_LinkedZone:IZone; safecall;
    procedure Set_RelativeDelayTimeToTarget(Value:double); safecall;
    function  Get_RelativeDelayTimeToTarget:double; safecall;
    procedure Set_Category(Value:integer); safecall;
    function  Get_Category: Integer; safecall;

    function  Get_PersonalPresence: Integer; safecall;
    function  Get_PersonalCount: Integer; safecall;
    function  Get_TransparencyDist: Double; safecall;
    function Get_UserDefinedVehicleVelocity:boolean; safecall;
    function Get_VehicleVelocity:Double; safecall;
    procedure Set_VehicleVelocity(Value:Double); safecall;
    function Get_PedestrialVelocity:Double; safecall;

    function  Get_VisualControl: Integer; override; safecall;
    function  Get_PatrolPeriod:double; override; safecall;
    function  Get_PatrolPaths: IDMCollection; safecall;
    function  Get_Observers:IDMCollection; safecall;
    procedure CalcPatrolPeriod; safecall;

    procedure MakeHVAreas(const theHAreas, theVAreas:IDMCollection;
                           var AddFlag:WordBool); safecall;
    function  Get_HAreas:IDMCollection; safecall;
    function  Get_VAreas:IDMCollection; safecall;
    function  Get_Jumps:IDMCollection; safecall;
    procedure CalcFalseAlarmPeriod; override; safecall;

    procedure MakePersistant(const SubStateE:IDMElement); safecall;
    function GetMaxVelocity(var VehicleKindE:IDMElement;
                            var PedestrialVelocity:double;
                            var MovementKind:integer): double; safecall;
    procedure MakeBackPathElementStates(const SubStateE:IDMElement); override; safecall;
    procedure CalcVulnerability; override; safecall;
    procedure BuildReport(
        ReportLevel: Integer; TabCount: Integer; Mode: Integer;
        const Report: IDMText); override;
    function Get_ReportModeCount:integer; override; safecall;
    function Get_ReportModeName(Index:integer):WideString; override; safecall;

// IZone2
    function Get_IsConvex: WordBool; safecall;
    function Get_Outline: IDMCollection; safecall;
    function Get_InnerZoneOutlineCount: Integer; safecall;
    function Get_InnerZoneOutline(Index: Integer): IDMCollection; safecall;
    procedure MakeOutlinePath(const OutlineFactory, NodeFactory:IDMCollection2); safecall;
    procedure MakeRoundaboutPath(const theStartNodeE, theFinishNodeE: IDMElement;
                                const ArcFactory: IDMCollection2; const NodeFactory: IDMCollection2); safecall;
    procedure ClearRoundaboutPath; safecall;

    procedure Initialize; override;
// IZone23
    procedure Set_Length(Value: double); virtual; safecall;
    function Get_Length: double; virtual; safecall;
// IRotater
    procedure Rotate(X0, Y0, cosA, sinA:double); safecall;
  public
    destructor Destroy; override;
//  IWayElement
    function Get_DelayTimeFast: Double; safecall;
    function Get_DelayTimeDev: Double; safecall;
    function Get_FailureProbabilityFast: Double; safecall;
    function Get_FailureProbabilityStealth: Double; safecall;
    function Get_AlarmGroupDelayTime: Double; safecall;
    function Get_AlarmGroupArrivalTime: Double; safecall;
    function Get_AlarmGroupArrivalTimeDev: Double; safecall;
    function Get_BlockGroupStart: Integer; safecall;
    function Get_BlockGroupArrivalTime: Double; safecall;
    function Get_BlockGroupArrivalTimeDev: Double; safecall;
    function Get_PointsToTarget: WordBool; safecall;
    procedure Set_PointsToTarget(Value: WordBool); safecall;
    function Get_DelayTimeStealth: Double; safecall;
    function Get_DetectionProbabilityFast: Double; safecall;
    function Get_DetectionProbabilityStealth: Double; safecall;
    function Get_SingleDetectionProbabilityFast: Double; safecall;
    function Get_SingleDetectionProbabilityStealth: Double; safecall;
    function Get_EvidenceFast: WordBool; safecall;
    function Get_EvidenceStealth: WordBool; safecall;
    function Get_ObservationPeriod:double; safecall;
    function Get_TacticFastU:IUnknown; safecall;
    function Get_TacticStealthU:IUnknown; safecall;
  end;

  TZones=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

  POutlineCrossectionRec=^TOutlineCrossectionRec;
  TOutlineCrossectionRec=record
    XX:double;
    YY:double;
    X:double;
    Y:double;
    Line:pointer;
    InnerFlag:boolean;
    OutlineJ:integer;
  end;


procedure ClearTmpPathLists;

implementation
uses
  FacilityModelConstU, SpatialModelConstU, OutstripU, ReorderLinesU,
  Geometry, Outlines;
var
  FFields:IDMCollection;
  DependingSafeguardElementList, theDependingSafeguardElementList,
  BestOvercomeMethodList, theBestOvercomeMethodList,
  OutlineCrossectionList, TMPPathArcList, TMPPathNodeList:TList;

{ TZone }

procedure TZone.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);

  FStates:=DataModel.CreateCollection(_ZoneState, SelfE);
  FVBoundaries:=TVBoundaries.Create(SelfE) as IDMCollection;
  FHBoundaries:=THBoundaries.Create(SelfE) as IDMCollection;
  FZones:=DataModel.CreateCollection(_Zone, SelfE);
  FSafeguardElements:=DataModel.CreateCollection(-3, SelfE);
  FJumps:=DataModel.CreateCollection(_Jump, SelfE);
  FObservers:=DataModel.CreateCollection(_Observer, SelfE);

  FFloorNodes:=DataModel.CreateCollection(-1, SelfE);
  FPatrolPaths:=DataModel.CreateCollection(-1, SelfE);

  FVAreas:=DataModel.CreateCollection(-1, SelfE);
  FHAreas:=DataModel.CreateCollection(-1, SelfE);

  FLinkedZone:=Self as IZone;

  FOutline:=DataModel.CreateCollection(-1, SelfE);
  FInnerZoneOutlines:=TList.Create;
end;

destructor TZone.Destroy;
var
  j:integer;
  aOutline:IDMCollection;
begin
  inherited Destroy;
  FSafeguardElements:=nil;
  FJumps:=nil;

  FFloorNodes:=nil;
  FCentralNode:=nil;
  FZoneNode:=nil;

  FLinkedZone:=nil;

  FPatrolPaths:=nil;
  FObservers:=nil;

  FVAreas:=nil;
  FHAreas:=nil;

  FOutline:=nil;
  for j:=0 to FInnerZoneOutlines.Count-1 do begin
    aOutline:=IDMCollection(FInnerZoneOutlines[j]);
    (aOutline as IDMCollection2).Clear;
    aOutline._Release;
  end;
  FInnerZoneOutlines.Free;
end;

procedure TZone.Clear;
begin
  (Get_PathArcs as IDMCollection2).Clear;
  (FFloorNodes as IDMCollection2).Clear;
  FCentralNode:=nil;
  FZoneNode:=nil;
  FLinkedZone:=nil;

  if (SpatialElement<>nil) and
     (SpatialElement.Ref<>nil) then begin
    ((DataModel as ISpatialModel2).Volumes as IDMCollection2).Remove(SpatialElement);
    SpatialElement.Clear;
  end;
  inherited;
end;

class function TZone.GetClassID: integer;
begin
  Result:=_Zone;
end;


function TZone.GetMovementDelayTime(var MovementKind:integer): double;
var
  VehicleKindE:IDMElement;
  PedestrialVelocity, MaxVelocity:double;
  Line:ILine;
  Distance:double;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  Volume:IVolume;
begin
  Result:=0;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  Line:=FacilityModelS.CurrentLineU as ILine;

  if Line=nil then Exit;

  Volume:=SpatialElement as IVolume;
  if Volume<>nil then
    Distance:=Line.Length
  else
    Distance:=Get_Length;

  if Distance=0 then
    Result:=0
  else begin
    try
    MaxVelocity:=GetMaxVelocity(VehicleKindE, PedestrialVelocity, MovementKind);
    if MaxVelocity=0 then begin
      Result:=InfinitValue;
      MovementKind:=_MovementImpossible;
    end else
    if MaxVelocity=InfinitValue then
      Result:=0
    else
      Result:=Distance/MaxVelocity
    except
      on E:Exception do
        DataModel.HandleError('Error in GetMovementDelayTime. ZoneID='+IntToStr(ID));
    end;
  end;

end;

procedure TZone.DoCalcDelayTime(const TacticU:IUnknown;
                      out DelayTime, DelayTimeDispersion:double; AddDelay:double); safecall;
var
  Tactic:ITactic;
  j, MovementKind:integer;
  SafeguardElementE, SafeguardElementTypeE, ZoneE:IDMElement;
  SafeguardElement:ISafeguardElement;
  SafeguardElementType:ISafeguardElementType;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  ZoneDelayTimeDispersionRatio:double;
  DirectPathFlag:WordBool;
  aDelayTime, aDelayTimeDispersion:double;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;

  Tactic:=TacticU as ITactic;
  ZoneE:=Self as IDMElement;
  DirectPathFlag:=True;
  FacilityModelS.CurrentDirectPathFlag:=DirectPathFlag;

  ZoneDelayTimeDispersionRatio:=FacilityModel.ZoneDelayTimeDispersionRatio;

  DelayTime:=GetMovementDelayTime(MovementKind);
  DelayTimeDispersion:=sqr(ZoneDelayTimeDispersionRatio*DelayTime);

  if DelayTime<InfinitValue then begin

    for j:=0 to FSafeguardElements.Count-1 do begin
      SafeguardElementE:=FSafeguardElements.Item[j];
      if (SafeguardElementE.QueryInterface(ISafeguardElement, SafeguardElement)=0) then begin
        SafeguardElementTypeE:=SafeguardElementE.Ref.Parent;
        SafeguardElementType:=SafeguardElementTypeE as ISafeguardElementType;
        if (SafeguardElementE.ClassID<>_GuardPost) and
          Tactic.DependsOn(SafeguardElementTypeE) and
          SafeguardElementType.CanDelay then begin
          SafeguardElement.CalcDelayTime(TacticU, aDelayTime, aDelayTimeDispersion);
          DelayTime:=DelayTime+aDelayTime;
          DelayTimeDispersion:=DelayTimeDispersion+aDelayTimeDispersion;
        end;
      end;
    end; //for j:=0 to FSafeguardElements.Count-1
  end;  //if aTime<InfinitValue
  if DelayTime>InfinitValue/1000 then
    DelayTime:=InfinitValue/1000;
end;

procedure TZone.CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                              out BestTacticE:IDMElement; AddDelay:double);
var
  k, MovementKind:integer;
  aDelayTime, aDelayTimeDispersion:double;
  TacticE:IDMElement;
  FacilityModel:IFacilityModel;
  DelayTimeDispersionRatio:double;
begin
  inherited;
  if ID=-1 then Exit;
  if Ref=nil then Exit;

  SetCurrentDirection;

  FacilityModel:=DataModel as IFacilityModel;

  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  if FacilityModel.CurrentZoneTactics.Count=0 then begin
    DelayTime:=GetMovementDelayTime(MovementKind);
    DelayTimeDispersion:=sqr(DelayTimeDispersionRatio*DelayTime);
  end else begin // if FacilityModel.CurrentZoneTactics.Count<>0
    DelayTime:=InfinitValue/1000;
    DelayTimeDispersion:=0;
    for k:=0 to FacilityModel.CurrentZoneTactics.Count-1 do begin
      TacticE:=FacilityModel.CurrentZoneTactics.Item[k];

      DoCalcDelayTime(TacticE,
                      aDelayTime, aDelayTimeDispersion, AddDelay);

      if DelayTime>aDelayTime then  begin
        DelayTime:=aDelayTime;
        DelayTimeDispersion:=aDelayTimeDispersion;
        BestTacticE:=TacticE;
        if DelayTime=0 then
          Break
      end;
    end;  //for k:=0 to FacilityModel.CurrentZoneTactics.Count

    if DelayTime>InfinitValue/1000 then
      DelayTime:=InfinitValue/1000;
  end; //if FacilityModel.CurrentZoneTactics.Count<>0

end;

procedure TZone.CalcNoDetectionProbability(
                           out NoDetP, NoFailureP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                           out BestTacticE:IDMElement;
                                AddDelay:double);
var
  FacilityModel:IFacilityModel;
  MaxNoDetP, aNoDetP, aNoFailureP:double;
  aNoEvidence:WordBool;
  TacticE:IDMElement;
  k:integer;
  ObservationPeriod, UserDefinedNoDetP:double;

begin
  inherited;

  if ID=-1 then Exit;
  if Ref=nil then Exit;

  SetCurrentDirection;

  FacilityModel:=DataModel as IFacilityModel;
  if FacilityModel.CurrentZoneTactics.Count=0 then
    NoDetP:=0
  else begin

    DependingSafeguardElementList.Clear;
    BestOvercomeMethodList.Clear;

    CalcObservationPeriod(ObservationPeriod, UserDefinedNoDetP);

    MaxNoDetP:=-1;
    for k:=0 to FacilityModel.CurrentZoneTactics.Count-1 do begin
      TacticE:=FacilityModel.CurrentZoneTactics.Item[k];
      theDependingSafeguardElementList.Clear;
      theBestOvercomeMethodList.Clear;
      DoCalcNoDetectionProbability(TacticE, ObservationPeriod,
           aNoDetP, aNoFailureP, aNoEvidence,
           BestTimeSum, BestTimeDispSum, Position, AddDelay);
      if MaxNoDetP<aNoDetP then begin
        MaxNoDetP:=aNoDetP;

        NoDetP:=aNoDetP;
        NoFailureP:=aNoFailureP;
        NoEvidence:=aNoEvidence;
        BestTacticE:=TacticE;
        if MaxNoDetP=1 then
          Break
      end;
    end;
    NoDetP:=MaxNoDetP;
  end;
end;

procedure TZone.DoCalcNoDetectionProbability(const TacticU:IUnknown;
                               ObservationPeriod:double;
                           out NoDetP, NoFailureP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                                AddDelay:double);

var
  ZoneE, ZoneTypeE:IDMElement;
  DelayTime:double;
  m:integer;
  ObservationElementE:IDMElement;
  SafeguardElement:ISafeguardElement;
  aDetP, aNoDetP, BestTime:double;
  OvercomeMethod:IOvercomeMethod;
  OvercomeMethodE:IDMElement;
  DelayTimeDispersionRatio:double;
  MovementKind:integer;
  FacilityModel:IFacilityModel;
  PS:double;
  TVCamera:ITVCamera;
  Flag:boolean;
begin
  NoDetP:=0;
  NoFailureP:=1;
  NoEvidence:=True;
  try

  DelayTime:=GetMovementDelayTime(MovementKind);
  if DelayTime>=InfinitValue/1000 then Exit;

  FacilityModel:=DataModel as IFacilityModel;
  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  ZoneE:=Self as IDMElement;
  ZoneTypeE:=Ref.Parent;

  BestTimeSum:=DelayTime;
  BestTimeDispSum:=sqr(DelayTimeDispersionRatio*DelayTime);

  NoDetP:=1;
  Position:=0;
  PS:=0;
  try
  for m:=0 to FObservers.Count-1 do begin
    ObservationElementE:=FObservers.Item[m].Ref;
    if ObservationElementE.ClassID=_TVCamera then begin
      TVCamera:=ObservationElementE as ITVCamera;
      Flag:=TVCamera.MotionSensor;
    end else
      Flag:=ObservationElementE.ClassID<>_GuardPost;
    if Flag then begin
      SafeguardElement:=ObservationElementE as ISafeguardElement;
      SafeguardElement.CalcDetectionProbability(TacticU, aDetP, BestTime);
      BestTimeSum:=BestTimeSum+BestTime;
      BestTimeDispSum:=BestTimeDispSum+sqr(DelayTimeDispersionRatio*BestTime);
      aNoDetP:=1-aDetP;
      OvercomeMethodE:=SafeguardElement.CurrOvercomeMethod;
      OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
      if OvercomeMethod<>nil then begin
        theDependingSafeguardElementList.Add(pointer(ObservationElementE));
        theBestOvercomeMethodList.Add(pointer(OvercomeMethodE));
      end;

      NoDetP:=NoDetP*aNoDetP;
      if OvercomeMethod<>nil then begin
        if OvercomeMethod.AssessRequired then
          PS:=PS+aDetP/aNoDetP;
        if OvercomeMethod.Failure then begin
          NoFailureP:=NoFailureP*aNoDetP;
          NoEvidence:=NoEvidence and not OvercomeMethod.Evidence;
        end;
      end;
    end; // if ObservationElementE.ClassID<>_GuardPost 
  end; // for m:=0 to FObservers.Count-1
  except
    on E:Exception do
      DataModel.HandleError
       ('Error in DoCalcNoDetectionProbability. ZoneID='+IntToStr(ID));
  end;

  if BestTimeSum>InfinitValue/1000 then begin
    BestTimeSum:=InfinitValue/1000;
    NoDetP:=0;
  end else begin
    if (ObservationPeriod>0) and (ObservationPeriod<InfinitValue) then
      NoDetP:=NoDetP*exp(-BestTimeSum/ObservationPeriod);
  end;

  except
      on E:Exception do
        DataModel.HandleError
          ('Error in DoCalcNoDetectionProbability. ZoneID='+IntToStr(ID));
  end;
end;

function TZone.Get_InstallPrice: integer;
begin
  Result:=0
end;

function TZone.Get_MaintenancePrice: integer;
//           метод, возвращающий стоимость эксплуатации в течении года
//           данного сектора зоны
begin
  Result:=0
end;

function TZone.Get_CollectionCount: integer;
begin
  Result:=ord(High(TZoneCategory))+1
end;

function TZone.Contains(const aElement: IDMElement): WordBool;
var
  Outer:IDMElement;
  Polyline:IPolyline;
  Area:IArea;
  Volume:IVolume;
  j, m:integer;
  Line:ILine;
  C0, C1:ICoordNode;
  MinZ, MaxZ:double;
  Layer:ILayer;
  SpatialModel2:ISpatialModel2;
  SelfE:IDMElement;
begin
  Result:=False;
  if SpatialElement<>nil then begin
    Layer:=SpatialElement.Parent as ILayer;
    if (Layer<>nil) and
        not Layer.Selectable then Exit;
  end;
  SpatialModel2:=DataModel as ISpatialModel2;
  case aElement.ClassID of
  _Line:
    begin
      Volume:=SpatialElement as IVolume;
      if Volume=nil then Exit;
      MinZ:=Volume.MinZ;
      MaxZ:=Volume.MaxZ;

      Line:=aElement as ILine;
      C0:=Line.C0;
      C1:=Line.C1;

      if MinZ>C0.Z  then Exit;
      if MaxZ<=C0.Z+1.e-6 then Exit;
      if MinZ>C1.Z  then Exit;
      if MaxZ<=C1.Z+1.e-6 then Exit;

      m:=0;
      while m<Volume.Areas.Count do begin
        Area:=Volume.Areas.Item[m] as IArea;
        if not Area.IsVertical and
           (Area.ProjectionContainsPoint(C0.X, C0.Y, 0)) then
          Break
        else
         inc(m)
      end;
      if m=Volume.Areas.Count then
        Exit;

      m:=0;
      while m<Volume.Areas.Count do begin
        Area:=Volume.Areas.Item[m] as IArea;
        if not Area.IsVertical and
           (Area.ProjectionContainsPoint(C1.X, C1.Y, 0)) then
          Break
        else
         inc(m)
      end;
      if m=Volume.Areas.Count then
        Exit;
      Result:=True;
    end;
  _Area:
    begin
      Volume:=SpatialElement as IVolume;
      if Volume=nil then Exit;
      MinZ:=Volume.MinZ;
      MaxZ:=Volume.MaxZ;

      Polyline:=aElement as IPolyline;
      j:=0;
      while j<Polyline.Lines.Count do begin
        Line:=Polyline.Lines.Item[j] as ILine;
        C0:=Line.C0;
        C1:=Line.C1;

        case SpatialModel2.BuildDirection of
        0:begin
            if MinZ>C0.Z  then Exit;
            if MaxZ<=C0.Z then Exit;
            if MinZ>C1.Z  then Exit;
            if MaxZ<=C1.Z then Exit;
          end;
        1:begin
            if MinZ>=C0.Z  then Exit;
            if MaxZ<C0.Z then Exit;
            if MinZ>=C1.Z  then Exit;
            if MaxZ<C1.Z then Exit;
          end;
        end;

        m:=0;
        while m<Volume.Areas.Count do begin
          Area:=Volume.Areas.Item[m] as IArea;
          if not Area.IsVertical and
             (Area.ProjectionContainsPoint(C0.X, C0.Y, 0)) then
            Break
          else
           inc(m)
        end;
        if m=Volume.Areas.Count then
          Exit;

        m:=0;
        while m<Volume.Areas.Count do begin
          Area:=Volume.Areas.Item[m] as IArea;
          if not Area.IsVertical and
             (Area.ProjectionContainsPoint(C1.X, C1.Y, 0)) then
            Break
          else
           inc(m)
        end;
        if m=Volume.Areas.Count then
          Exit;

        inc(j);
      end;
      Result:=True;
     end;
  _Zone,
  _GlobalZone:
    begin
      Outer:=aElement;
      SelfE:=Self as IDMElement;
      while Outer<>nil do begin
        if SelfE=Outer then begin
          Result:=True;
          Exit;
        end;
        Outer:=Outer.Parent;
      end;
    end;
  end;
end;

function TZone.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

class function TZone.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TZone.Get_Collection(Index: Integer): IDMCollection;
begin
  case TZoneCategory(Index) of
  zscStates:
      Result:=FStates;
  zscZones:
    Result:=FZones;
  zscSafeguardElements:
    Result:=FSafeguardElements;
  zscObservers:
    Result:=FObservers;
  zscVBoundaries:
    Result:=FVBoundaries;
  zscHBoundaries:
    Result:=FHBoundaries;
  zscJumps:
    Result:=FJumps;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

procedure TZone.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  SafeguardDatabase:ISafeguardDatabase;
begin
  SafeguardDatabase:=(DataModel as IFacilityModel).SafeguardDatabase as ISafeguardDatabase;
  case TZoneCategory(Index) of
  zscStates:
    begin
      aCollectionName:=rsElementStates;
      if DataModel<>nil then
        aRefSource:=(DataModel as IFacilityModel).FacilitySubStates
      else
        aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  zscZones:
    begin
      aCollectionName:=rsZones;
      aRefSource:=SafeguardDatabase.ZoneTypes;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoDelete or leoChangeParent or leoChangeRef or
                          leoRename or leoMove;
      aLinkType:=ltOneToMany;
    end;
  zscSafeguardElements:
    begin
      try
      aCollectionName:=rsSafeguardsAndTargets;
      aRefSource:=nil;
      aLinkType:=ltOneToMany;

      if Ref<>nil then begin
        aClassCollections:=Ref.Parent as IDMClassCollections;
        aOperations:=leoAdd or leoDelete or leoChangeParent or leoChangeRef or leoRename;
      end else begin
        aClassCollections:=nil;
        aOperations:=0;
      end;
      except
        on E:Exception do
          DataModel.HandleError('Error in GetCollectionProperties. ZoneID='+IntToStr(ID));
      end;
    end;
  zscObservers:
    begin
      aCollectionName:='Элементы системы охраны, действующие в зоне';
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=0;
      aLinkType:=ltOneToMany;
    end;
  zscVBoundaries:
    begin
      aCollectionName:=rsVBoundaries;
      aRefSource:=((DataModel as IDMElement).Ref as ISafeguardDatabase).BoundaryTypes;
      aClassCollections:=nil;
      aOperations:=leoRename or leoChangeRef or leoDontCopy or leoExecute or leoOperation2 or leoPasteProps;
      aLinkType:=ltIndirect;
     end;
  zscHBoundaries:
    begin
      aCollectionName:=rsHBoundaries;
      aRefSource:=((DataModel as IDMElement).Ref as ISafeguardDatabase).BoundaryTypes;
      aClassCollections:=nil;
      aOperations:=leoRename or leoChangeRef or leoDontCopy or leoExecute;
      aLinkType:=ltIndirect;
     end;
  zscJumps:
    begin
      aCollectionName:=rsJumps;
      aRefSource:=((DataModel as IDMElement).Ref as ISafeguardDatabase).JumpKinds;
      aClassCollections:=nil;
      aOperations:=leoRename or leoChangeRef  or leoDontCopy or leoExecute or leoOperation2;
      aLinkType:=ltManyToMany;
    end;
  else
    inherited;
  end;
end;

procedure TZone.Draw(const aPainter:IUnknown; DrawSelected: integer);
var
  j:integer;
  Volume:IVolume;
  Area:IArea;
  AreaE:IDMElement;
begin
  Volume:=SpatialElement as IVolume;
  if Volume=nil then Exit;
  if SpatialElement.Parent=nil then Exit;
  if (not (SpatialElement.Parent as ILayer).Visible) and
     not Selected then Exit;
  if DrawSelected<>2 then begin
    if Volume.Areas.Count>0 then
      for j:=0 to Volume.Areas.Count-1 do begin
        AreaE:=Volume.Areas.Item[j];
        Area:=AreaE as IArea;
        if Area.IsVertical then
          AreaE.Draw(aPainter, DrawSelected)
      end
    else
      for j:=0 to FZones.Count-1 do
        FZones.Item[j].Draw(aPainter, DrawSelected);

    for j:=0 to FJumps.Count-1 do
      FJumps.Item[j].Draw(aPainter, DrawSelected);

  end;

  for j:=0 to FSafeguardElements.Count-1 do
    FSafeguardElements.Item[j].Draw(aPainter, DrawSelected);

  if (Get_SMLabel<>nil) and
     (DataModel as IVulnerabilityMap).ShowText then
    Get_SMLabel.Draw(aPainter, DrawSelected);
end;

class procedure TZone.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsZoneCategory, '%0d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(zpZoneCategory), 0, pkInput);
  S:='|'+rsPersonalNeverPresent+
     '|'+rsPersonalMayPresent+
     '|'+rsPersonalAlwaysPresent;
  AddField(rsPersonalPresence, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(zpPersonalPresence), 0, pkInput);
  AddField(rsPersonalCount, '%0d', '', 'Pnd',
                 fvtInteger, 0, 0, 0,
                 ord(zpPersonalCount), 0, pkInput);
  AddField(rsTransparencyDist, '%0.2f', '', '',
                 fvtFloat, InfinitValue, 0, InfinitValue,
                 ord(zpTransparencyDist), 0, pkInput);
  AddField(rsUserDefinedVehicleVelocity, '', '', '',
           fvtBoolean, 0, 0, 1,
           ord(zpUserDefinedVehicleVelocity), 0, pkUserDefined);
  AddField(rsVehicleVelocity, '%0.2f', '', '',
           fvtFloat, 0, 0, 0,
           ord(zpVehicleVelocity), 2, pkUserDefined);
  AddField(rsPedestrialVelocity, '%0.2f', '', '',
           fvtFloat, 0, 0, 0,
           ord(zpPedestrialVelocity), 0, pkInput);
end;

function TZone.Get_SafeguardElements: IDMCollection;
begin
  Result:=FSafeguardElements
end;

function TZone.Get_Zones: IDMCollection;
begin
  Result:=FZones
end;

procedure TZone.MakeLinkedZone;
var
  j, m:integer;
  NextZone:IZone;
  aLinkedZone:IZone;
  Boundary:IBoundary;
  Volume:IVolume;
  FacilityModel:IFacilityModel;
begin
  if SpatialElement=nil then Exit;
  FacilityModel:=DataModel as IFacilityModel;
  Volume:=SpatialElement as IVolume;
  for j:=0 to Volume.Areas.Count-1 do begin
    Boundary:=Volume.Areas.Item[j].Ref as IBoundary;
    if (Boundary<>nil) and
       (Boundary as IFieldBarrier).HasNoFieldBarrier then begin

      if Boundary.Zone0=Self as IDMElement then
        NextZone:=Boundary.Zone1 as IZone
      else
        NextZone:=Boundary.Zone0 as IZone;

      if NextZone=nil then Continue;

      if FLinkedZone=Self as IZone then begin
        aLinkedZone:=(FacilityModel.Zones as IDMCollection2).CreateElement(False) as IZone;
        Set_LinkedZone(aLinkedZone);
      end;

      if FLinkedZone.Zones.IndexOf(NextZone as IDMElement)=-1 then begin
        if (NextZone.LinkedZone<>NextZone) and
           (NextZone.LinkedZone<>Self as IZone) then begin
          aLinkedZone:=NextZone.LinkedZone;
          for m:=0 to aLinkedZone.Zones.Count-1 do
            (aLinkedZone.Zones.Item[m] as IZone).LinkedZone:=FLinkedZone;
        end;
      end;
    end;
  end;
end;

procedure TZone.Set_LinkedZone(const Value: IZone);
begin
  if FLinkedZone = Value then Exit;
  FLinkedZone := Value;
  AddParent(FLinkedZone as IDMElement);
end;

function TZone.Get_LinkedZone: IZone;
begin
  Result:=FLinkedZone
end;

function TZone.Get_RelativeDelayTimeToTarget: double;
begin
  Result:=FRelativeDelayTimeToTarget
end;

procedure TZone.Set_RelativeDelayTimeToTarget(Value: double);
begin
  FRelativeDelayTimeToTarget:=Value
end;


procedure TZone.Set_Parent(const Value: IDMElement);
var
  ParentZoneS:ISafeguardUnit;
  ParentZone, aZone:IZone;
  aZoneE:IDMElement;
  aVolume, Volume, ParentVolume:IVolume;
  j,  m:integer;
  PX, PY, PZ:double;
  SafeguardElementE, ParentZoneE, OldParentZoneE:IDMElement;
  Line:ILine;
  Node:ICoordNode;
  OldState:integer;
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  AreaE:IDMElement;
  Area:IArea;
  Flags:integer;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  FacilityModel:IFacilityModel;
  VolumeU:IUnknown;
  VolumeE, BoundaryE:IDMElement;
  AddFlag:WordBool;
begin
  if FSettingParent then begin
    FSettingParent:=False;
    raise Exception.Create(Format('Error! Double ettempt to set parent zone for Zone.ID=%d',[ID]));
    Exit;
  end;
  FSettingParent:=True;
  try
  DMDocument:=DataModel.Document as IDMDocument;
  DMOperationManager:=DMDocument as IDMOperationManager;
  FacilityModel:=DataModel as IFacilityModel;

  OldParentZoneE:=Parent;

  ParentZoneE:=Value;
  ParentZone:=Value as IZone;
  ParentZoneS:=Value as ISafeguardUnit;
  if Value<>nil then
    ParentVolume:=Value.SpatialElement as IVolume
  else
    ParentVolume:=nil;
  Volume:=SpatialElement as IVolume;

  if DataModel.IsChanging and
     not DataModel.IsLoading then begin
    if (Volume<>nil) and
       (ParentVolume<>nil) and
       (ParentZoneE<>FacilityModel.Enviroments) and
        Volume.ContainsVolume(ParentVolume) then begin
      DMOperationManager.ChangeParent( nil, ParentZoneE.Parent, Self as IDMElement);
      AddFlag:=False;
      (Parent as IZone).MakeHVAreas(nil, nil, AddFlag);
      FSettingParent:=False;
      Exit;
    end;
  end;

  inherited;

  if not DataModel.IsChanging then begin
    FSettingParent:=False;
    Exit;
  end;
  if DataModel.IsLoading then  begin
    FSettingParent:=False;
    Exit;
  end;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=DataModel as ISpatialModel2;

  if OldParentZoneE<>nil then begin
    ParentVolume:=OldParentZoneE.SpatialElement as IVolume;
    if ParentVolume<>nil then
      SpatialModel2.CalcVolumeMinMaxZ(ParentVolume);
  end;

  if Value=nil then  begin
    FSettingParent:=False;
    Exit;
  end;

  if Volume=nil then begin
    DMOperationManager.AddElement(SpatialModel.CurrentLayer as IDMElement,
                                  SpatialModel2.Volumes, '', ltOneToMany,
                                  VolumeU, True);
    VolumeE:=VolumeU as IDMElement;
    Volume:=VolumeE as IVolume;
    DMOperationManager.ChangeRef(nil, '', Self as IUnknown, VolumeU);
    SpatialModel2.CalcVolumeMinMaxZ(Volume);
  end;

  if ParentVolume=nil then  begin
    FSettingParent:=False;
    Exit;
  end;

  if DataModel.IsCopying then begin
    for j:=0 to FVBoundaries.Count-1 do begin
      BoundaryE:=FVBoundaries.Item[j];
      Area:=BoundaryE.SpatialElement as IArea;
      if Area.Volume1=nil then begin
        Area.Volume1IsOuter:=True;
        Area.Volume1:=ParentVolume;
      end else
      if Area.Volume0=nil then begin
        Area.Volume0IsOuter:=True;
        Area.Volume0:=ParentVolume;
      end;
    end;
    FSettingParent:=False;
    Exit;
  end;

  if ParentVolume.MinZ>Volume.MinZ then
    ParentVolume.MinZ:=Volume.MinZ;
  if ParentVolume.MaxZ<Volume.MaxZ then
    ParentVolume.MaxZ:=Volume.MaxZ;

  if DataModel.IsExecuting then  begin
    FSettingParent:=False;
    Exit;
  end;

//  if Name[1]<>'#' then begin //не является зоной, объединяющей секторы
    OldState:=DMDocument.State;
    DMDocument.State:=DMDocument.State and not dmfExecuting; // восстановление передачи в Parent границ зоны

    try
    j:=0;
    while j<ParentZone.Zones.Count do begin
      aZoneE:=ParentZone.Zones.Item[j];
      if aZoneE<>Self as IDMElement then begin
        aVolume:=aZoneE.SpatialElement as IVolume;
        if Volume.ContainsVolume(aVolume) then begin
          DMOperationManager.ChangeParent( nil, Self as IDMElement, aZoneE);
          aZone:=aZoneE as IZone;
          for m:=0 to aZone.VAreas.Count-1 do begin
            AreaE:=aZone.VAreas.Item[m];
            Area:=AreaE as IArea;
            if (Area.Volume0=nil) or
               (Area.Volume0=ParentVolume) then begin
              Flags:=Area.Flags or afVolume0IsOuter;
              DMOperationManager.ChangeFieldValue(Area, ord(areFlags), True, Flags);
              DMOperationManager.ChangeFieldValue(Area, ord(areVolume0), True, Volume);
            end;
            if (Area.Volume1=nil) or
               (Area.Volume1=ParentVolume) then begin
              Flags:=Area.Flags or afVolume1IsOuter;
              DMOperationManager.ChangeFieldValue(Area, ord(areFlags), True, Flags);
              DMOperationManager.ChangeFieldValue(Area, ord(areVolume1), True, Volume);
            end;
          end;
        end else
          inc(j)
      end else
        inc(j)
    end;
    finally
      DMDocument.State:=OldState;
    end;
//  end;

  while ParentZoneE<>nil do begin
    ParentZoneS:=ParentZoneE as ISafeguardUnit;
    j:=0;
    while j<ParentZoneS.SafeguardElements.Count do begin
      SafeguardElementE:=ParentZoneS.SafeguardElements.Item[j];
      if SafeguardElementE.SpatialElement<>nil then begin
        if SafeguardElementE.SpatialElement.QueryInterface(ILine, Line)=0 then
          Node:=Line.C0
        else
          Node:=SafeguardElementE.SpatialElement as ICoordNode;
        PX:=Node.X;
        PY:=Node.Y;
        PZ:=Node.Z;
        if FZones.Count=0 then begin
          if Volume.ContainsPoint(PX, PY, PZ) then
            DMOperationManager.ChangeParent( nil, Self as IDMElement, SafeguardElementE)
          else
            inc(j)
        end else begin
          m:=0;
          while m<FZones.Count do begin
            aZoneE:=FZones.Item[m];
            aVolume:=aZoneE.SpatialElement as IVolume;
           if (aVolume<>nil) and
               aVolume.ContainsPoint(PX, PY, PZ) then begin
              DMOperationManager.ChangeParent( nil, aZoneE, SafeguardElementE);
              Break
            end;
            inc(m)
          end;
          if m=FZones.Count then
            inc(j)
        end;
      end else   //if SafeguardElementE.SpatialElement=nil
        inc(j)
    end; //while j<ParentZone.SafeguardElements.Count
    ParentZoneE:=ParentZoneE.Parent;
  end;
  finally
    FSettingParent:=False
  end;  
end;

function TZone.Get_BuildIn: WordBool;
begin
  Result:=FBuildIn
end;

procedure TZone.Set_BuildIn(Value: WordBool);
begin
  inherited;
  FBuildIn:=Value
end;

function TZone.Get_FloorNodes: IDMCollection;
begin
  Result:=FFloorNodes
end;

function TZone.Get_CentralNode: IDMElement;
begin
  Result:=FCentralNode
end;

procedure TZone.Set_CentralNode(const Value: IDMElement);
begin
  FCentralNode:=Value
end;

procedure TZone._AddChild(const aChild: IDMElement);
var
  Jump:IJump;
  JumpB:IBoundary;
begin
  inherited;
  case aChild.ClassID of
  _Jump:
    if (not DataModel.IsLoading) and
       (not DataModel.IsCopying) then begin
      Jump:=aChild as IJump;
      JumpB:=Jump as IBoundary;
      if JumpB.Zone0=nil then begin
        JumpB.Zone0:=Self as IDMElement;
        if FVBoundaries.Count>0 then
          Jump.Boundary0:=FVBoundaries.Item[0];
      end else
      if JumpB.Zone1=nil then begin
        JumpB.Zone1:=Self as IDMElement;
        if FVBoundaries.Count>0 then
          Jump.Boundary1:=FVBoundaries.Item[0];
      end;
    end;
  end;

end;

procedure TZone._RemoveChild(const aChild: IDMElement);
begin
  inherited;
  case aChild.ClassID of
  _Jump:
    if (aChild as IBoundary).Zone0=Self as IDMElement then
      (aChild as IBoundary).Zone0:=nil
    else
      (aChild as IBoundary).Zone1:=nil;
  end;

end;

function TZone.Get_Category: Integer;
begin
  Result:=FCategory
end;

function TZone.Get_PersonalCount: Integer;
var
  State:IZoneState;
begin
  State:=GetCurrentState as IZoneState;
  if State<>nil then
    Result:=State.PersonalCount
  else
    Result:=FPersonalCount
end;

function TZone.Get_PersonalPresence: Integer;
var
  State:IZoneState;
begin
  State:=GetCurrentState as IZoneState;
  if State<>nil then
    Result:=State.PersonalPresence
  else
    Result:=FPersonalPresence
end;

function TZone.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(zpZoneCategory):
    Result:=FCategory;
  ord(zpPersonalPresence):
    Result:=FPersonalPresence;
  ord(zpPersonalCount):
    Result:=FPersonalCount;
  ord(zpTransparencyDist):
    Result:=FTransparencyDist;
  ord(zpUserDefinedVehicleVelocity):
    Result:=FUserDefinedVehicleVelocity;
  ord(zpVehicleVelocity):
    Result:=FVehicleVelocity;
  ord(zpPedestrialVelocity):
    Result:=FPedestrialVelocity;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TZone.SetFieldValue(Code: integer; Value: OleVariant);
  procedure UpdateUserDefinedElements;
  var
    j:integer;
    FacilityModel:IFacilityModel;
    UserDefinedElements:IDMCollection;
    UserDefinedElements2:IDMCollection2;
    Document:IDMDocument;
  begin
      FacilityModel:=DataModel as IFacilityModel;
      UserDefinedElements:=FacilityModel.UserDefinedElements;
      UserDefinedElements2:=UserDefinedElements as IDMCollection2;
      j:=UserDefinedElements.IndexOf(Self as IDMElement);
      if Value then begin
        if j=-1 then
          UserDefinedElements2.Add(Self as IDMElement);
      end else begin
        if j<>-1 then
          UserDefinedElements2.Remove(Self as IDMElement);
      end;
     if not DataModel.IsLoading and
        not DataModel.IsCopying then begin
       Document:=DataModel.Document as IDMDocument;
       if Document.Server<>nil then
         (Document.Server as IDataModelServer).RefreshElement(Self as IUnknown);
     end;
  end;
begin
  case Code of
  ord(zpZoneCategory):
    Set_Category(Value);
  ord(zpPersonalPresence):
    FPersonalPresence:=Value;
  ord(zpPersonalCount):
    FPersonalCount:=Value;
  ord(zpTransparencyDist):
    FTransparencyDist:=Value;
  ord(zpUserDefinedVehicleVelocity):
    begin
      FUserDefinedVehicleVelocity:=Value;
      UpdateUserDefinedElements;
    end;  
  ord(zpVehicleVelocity):
    FVehicleVelocity:=Value;
  ord(zpPedestrialVelocity):
    FPedestrialVelocity:=Value;
  else
    inherited
  end;
end;

procedure TZone.Set_Ref(const Value: IDMElement);
var
  ZoneKind:IZoneKind;
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  aElement:IDMElement;
  j:integer;
  CreatingFlag:boolean;
  AddFlag:WordBool;
begin
  CreatingFlag:=(Ref=nil) and (SpatialElement=nil);
  inherited;
  if Ref=nil then Exit;
  ZoneKind:=Value as IZoneKind;
  Set_Category(ZoneKind.DefaultCategory);
  FTransparencyDist:=ZoneKind.DefaultTransparencyDist;
  FPedestrialVelocity:=ZoneKind.PedestrialMovementVelocity;

  if CreatingFlag then begin

    DMDocument:=DataModel.Document as IDMDocument;
    DMOperationManager:=DMDocument as IDMOperationManager;

    if DMDocument.SelectionCount<2 then Exit;

    aElement:=DMDocument.SelectionItem[0] as IDMElement;
    if (aElement.ClassID<>_Volume) and
       (aElement.ClassID<>_Zone) then Exit;
    for j:=0 to DMDocument.SelectionCount-1 do begin
      aElement:=DMDocument.SelectionItem[j] as IDMElement;
      if aElement.ClassID=_Volume then
        DMOperationManager.ChangeParent(nil,
                  Self as IDMElement, aElement.Ref)
      else
      if aElement.ClassID=_Zone then
        DMOperationManager.ChangeParent(nil,
                  Self as IDMElement, aElement);
      AddFlag:=False;            
      MakeHVAreas(nil, nil, AddFlag);
    end;
  end;

end;

procedure TZone.Set_Category(Value: integer);
var
  j, m, k:integer;
  aZone:IZone;
  BoundaryE:IDMElement;
  Boundary:IBoundary;
  BoundaryLayerSU:ISafeguardUnit;
  SafeguardElementIM, BoundaryLayerIM:IImager;
begin
  FCategory:=Value;
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if DataModel.IsDestroying then Exit;
  if FZones=nil then Exit;
  for j:=0 to FZones.Count-1 do begin
    aZone:=FZones.Item[j] as  IZone;
    if aZone.Category<Value then
      aZone.Category:=Value
  end;
  for j:=0 to FVBoundaries.Count-1 do begin
    try
    BoundaryE:=FVBoundaries.Item[j];
    if (BoundaryE<>nil) and
       (BoundaryE.ClassID=_Boundary) then begin
      BoundaryE.UpdateCoords;
      Boundary:=BoundaryE as IBoundary;
      for m:=0 to Boundary.BoundaryLayers.Count-1 do begin
        BoundaryLayerSU:=Boundary.BoundaryLayers.Item[m] as ISafeguardUnit;
        BoundaryLayerIM:=BoundaryLayerSU as IImager;
        BoundaryLayerIM.CorrectDrawingDirection;
        for k:=0 to BoundaryLayerSU.SafeguardElements.Count-1 do begin
          SafeguardElementIM:=BoundaryLayerSU.SafeguardElements.Item[k] as IImager;
          SafeguardElementIM.CorrectDrawingDirection;
        end;
      end;
    end;  
    except
      raise
    end;
  end;
end;

function TZone.Get_VisualControl: Integer;
var
  j:integer;
  Element:IDMElement;
begin
  j:=0;
  while j<FSafeguardElements.Count do begin
    Element:=FSafeguardElements.Item[j];
    case Element.ClassID of
    _GuardPost,
    _TVCamera:
      Break
    else
      inc(j);
    end;
  end;
  if j=FSafeguardElements.Count then
    Result:=0
  else
    case Element.ClassID of
    _GuardPost:
      Result:=2;
    _TVCamera:
      Result:=1;
    else
      Result:=0;
    end
end;

function TZone.Get_PatrolPeriod: double;
begin
  Result:=FPatrolPeriod
end;

function TZone.Get_PatrolPaths: IDMCollection;
begin
  Result:=FPatrolPaths
end;

procedure TZone.CalcPatrolPeriod;
var
  aR, R, T:double;
  j:integer;
  PatrolPath:IPatrolPath;
begin
  R:=0;
  for j:=0 to FPatrolPaths.Count-1 do begin
    PatrolPath:=FPatrolPaths.Item[j] as IPatrolPath;
    T:=PatrolPath.Period*3600;
    if T=0 then
      aR:=1/Week
    else
      aR:=1/T;
    R:=R+aR;
  end;
  case Get_PersonalPresence of
  1: R:=R+1/3600;  //  1 раз в час  (иногда)
  2: R:=R+1/600;   //  1 раз в 10 мин  (постоянно)
  end;
  if R=0 then
    FPatrolPeriod:=Week
  else
    FPatrolPeriod:=1/R
end;

procedure TZone.AfterLoading2;
begin
  inherited;
  CalcPatrolPeriod;
end;

function TZone.Get_TransparencyDist: Double;
var
  State:IZoneState;
begin
  State:=GetCurrentState as IZoneState;
  if State<>nil then
    Result:=State.TransparencyDist
  else
    Result:=FTransparencyDist
end;

function TZone.Get_Observers: IDMCollection;
begin
  Result:=FObservers
end;

procedure TZone._AddBackRef(const aElement: IDMElement);
begin
  inherited;
end;

procedure TZone.Set_Name(const Value: WideString);
var
  j, m:integer;
  BoundaryE:IDMElement;
  S, aName, theName:string;
  Volume:IVolume;
begin
  inherited;
  Volume:=SpatialElement as IVolume;
  if Volume=nil then Exit;

  theName:=Value;
  for j:=0 to Volume.Areas.Count-1 do begin
    BoundaryE:=Volume.Areas.Item[j].Ref;
    if BoundaryE<>nil then begin
      aName:=BoundaryE.Name;
      m:=Pos('/', aName);
      if m<>0 then begin
        S:=Copy(aName, 1, m);
        aName:=S+theName;
        BoundaryE.Name:=aName;
      end;
    end;  
  end;
end;

procedure TZone.CalculateFieldValues;
var
  FacilityModelS:IFMState;
  WarriorGroup:IWarriorGroup;
  j:integer;
  VehicleKind:IVehicleKind;
  Velocity:double;
  ZoneKind:IZoneKind;
  aVehicleVelocity:double;
begin
  inherited;
  if DataModel=nil then Exit;
  FacilityModelS:=DataModel as  IFMState;
  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;
  if WarriorGroup=nil then Exit;
  ZoneKind:=Ref as IZoneKind;
  if ZoneKind=nil then Exit;
  if Get_UserDefinedVehicleVelocity then Exit;

  aVehicleVelocity:=0;
  for j:=0 to WarriorGroup.Vehicles.Count-1 do begin
    VehicleKind:=WarriorGroup.Vehicles.Item[j].Ref as IVehicleKind;
    Velocity:=VehicleKind.GetVelocity(ZoneKind);
    if aVehicleVelocity<Velocity then
      aVehicleVelocity:=Velocity
  end;
  Set_VehicleVelocity(aVehicleVelocity);
end;

procedure TZone.CalcFalseAlarmPeriod;
var
  FalseAlarmFrequency, F, T:double;
  j:integer;
  Sensor:ISensor;
begin
  FalseAlarmFrequency:=0;
  try
  for j:=0 to FObservers.Count-1 do begin
    if FObservers.Item[j].Ref.QueryInterface(ISensor, Sensor)=0 then begin
      Sensor.CalcFalseAlarmPeriod;
      T:=Sensor.FalseAlarmPeriod;
      if T<>0 then begin
        F:=1./T;
        FalseAlarmFrequency:=FalseAlarmFrequency+F;
      end;
    end;
  end;
  except
      on E:Exception do
        DataModel.HandleError
        ('Error in GetCollectionProperties. ZoneID='+IntToStr(ID));
  end;
  if FalseAlarmFrequency<>0 then
    Set_FalseAlarmPeriod(1./FalseAlarmFrequency)
  else
    Set_FalseAlarmPeriod(0)
end;

function TZone.Get_UserDefineded: WordBool;
begin
  Result:=(inherited Get_UserDefineded) or
    FUserDefinedVehicleVelocity
end;

function TZone.Get_PedestrialVelocity: Double;
var
  State:IZoneState;
begin
  State:=GetCurrentState as IZoneState;
  if State<>nil then
    Result:=State.PedestrialVelocity
  else
    Result:=FPedestrialVelocity
end;

function TZone.Get_UserDefinedVehicleVelocity: boolean;
var
  State:IZoneState;
begin
  State:=GetCurrentState as IZoneState;
  if State<>nil then
    Result:=State.UserDefinedVehicleVelocity
  else
    Result:=FUserDefinedVehicleVelocity
end;

function TZone.Get_VehicleVelocity: Double;
var
  State:IZoneState;
begin
  State:=GetCurrentState as IZoneState;
  if State<>nil then
    Result:=State.VehicleVelocity
  else
    Result:=FVehicleVelocity
end;

procedure TZone.Set_VehicleVelocity(Value: Double);
var
  State:IZoneState;
begin
  State:=GetCurrentState as IZoneState;
  if State<>nil then
    State.VehicleVelocity:=Value
  else
    FVehicleVelocity:=Value
end;

procedure TZone.CalcPathSoundResistance(var PathSoundResistance, FuncSoundResistance: Double);
begin
  inherited
end;

function TZone.Get_IsEmpty: WordBool;
begin
  Result:=(FZones.Count=0)
end;

procedure TZone.MakeHVAreas(const theHAreas, theVAreas: IDMCollection;
                           var AddFlag:WordBool); safecall;
var
  j, m:integer;
  Volume, aVolume:IVolume;
  Area:IArea;
  AreaE, aZoneE:IDMElement;
  theHAreas2, theVAreas2, HAreas2, VAreas2:IDMCollection2;
  aZone:IZone;
  aAddFlag:WordBool;
begin
  if id=8618 then
    XXX:=0;
  HAreas2:=FHAreas as IDMCollection2;
  VAreas2:=FVAreas as IDMCollection2;

  HAreas2.Clear;
  VAreas2.Clear;

  Volume:=SpatialElement as IVolume;

  if (Volume<>nil) and
     (Volume.Areas.Count>0) then begin
    for j:=0 to Volume.Areas.Count-1 do begin
      AreaE:=Volume.Areas.Item[j];
      Area:=AreaE as IArea;
      if Area.IsVertical then begin
        VAreas2.Add(AreaE);
      end else begin
        HAreas2.Add(AreaE);
      end;
    end;

    for j:=0 to FZones.Count-1 do begin
      aZoneE:=FZones.Item[j] as IDMElement;
      aVolume:=aZoneE.SpatialElement as IVolume;
      aZone:=aZoneE as IZone;
//      if (aVolume<>nil) and
//         (not Volume.ContainsVolume(aVolume)) then // внутренняя зона, смежная с внешней границей
//        aAddFlag:=True
//      else
        aAddFlag:=False;
      aZone.MakeHVAreas(FHAreas, FVAreas, aAddFlag)
    end;
  end else begin
    aAddFlag:=False;
    for j:=0 to FZones.Count-1 do begin
      aZone:=FZones.Item[j] as IZone;
      aZone.MakeHVAreas(FHAreas, FVAreas, aAddFlag)
    end;
  end;

  if theHAreas<>nil then begin
    theHAreas2:=theHAreas as IDMCollection2;

    if theHAreas.Count=0 then
      AddFlag:=True
    else
      for j:=0 to FHAreas.Count-1 do begin
        AreaE:=FHAreas.Item[j];
        m:=theHAreas.IndexOf(AreaE);
        if m<>-1 then begin
          AddFlag:=True;
          Break
        end;
      end;

    if AddFlag then
      for j:=0 to FHAreas.Count-1 do begin
        AreaE:=FHAreas.Item[j];
        m:=theHAreas.IndexOf(AreaE);
        if m<>-1 then
          theHAreas2.Delete(m)
        else
          theHAreas2.Add(AreaE);
      end;
  end;

  if theVAreas<>nil then begin
    theVAreas2:=theVAreas as IDMCollection2;

    if theVAreas.Count=0 then
      AddFlag:=True
    else
      for j:=0 to FVAreas.Count-1 do begin
        AreaE:=FVAreas.Item[j];
        m:=theVAreas.IndexOf(AreaE);
        if m<>-1 then begin
          AddFlag:=True;
          Break
        end;
      end;

    if AddFlag then
      for j:=0 to FVAreas.Count-1 do begin
        AreaE:=FVAreas.Item[j];
        m:=theVAreas.IndexOf(AreaE);
        if m<>-1 then
          theVAreas2.Delete(m)
        else
          theVAreas2.Add(AreaE)
      end;
  end;
end;

procedure TZone.Set_Selected(Value: WordBool); // ???????????
var
  Painter:IUnknown;
  Document:IDMDocument;
begin
  if Selected=Value then Exit;
  inherited;
  if SpatialElement<>nil then Exit;  // так не бывает !!!!
  if DataModel=nil then Exit;
  if DataModel.InUndoRedo then Exit;
  Document:=DataModel.Document as IDMDocument;
  if Document=nil then Exit;
  Painter:=(Document as ISMDocument).PainterU;
  Draw(Painter, -1);
  if Get_Selected then
    Draw(Painter, 1)
  else
    Draw(Painter, 0)
end;

procedure TZone.Update;
var
  aAddFlag:WordBool;
begin
  inherited;
  if not DataModel.IsLoading then begin
    aAddFlag:=False;
    MakeHVAreas(nil, nil, aAddFlag);
  end;
end;

function TZone.Get_Jumps: IDMCollection;
begin
  Result:=FJumps;
end;

procedure TZone.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
  JumpE:IDMElement;
  Jump:IJump;
  JumpB:IBoundary;
begin
  aCollection2:=aCollection as IDMCollection2;

  aCollection2.Clear;
  case TZoneCategory(Index) of
  zscJumps:
    begin
      SourceCollection:=(DataModel as IFacilityModel).Jumps;
      for j:=0 to SourceCollection.Count-1 do begin
        JumpE:=SourceCollection.Item[j];
        Jump:=JumpE as IJump;
        JumpB:=JumpE as IBoundary;
        if (JumpB.Zone1=nil) or
           (JumpB.Zone0=nil) then
          aCollection2.Add(JumpE);
      end;
    end;
  zscStates:
    begin
      SourceCollection:=(DataModel as IFacilityModel).FacilitySubStates;
      for j:=0 to SourceCollection.Count-1 do
        aCollection2.Add(SourceCollection.Item[j]);
    end;
  else
    SourceCollection:=nil;
  end;

end;

function TZone.GetCopyLinkMode(const aLink: IDMElement): Integer;
var
  Jump:IJump;
begin
  if aLink=nil then
    Result:=clmNil
  else
  if aLink.QueryInterface(IJump, Jump)=0then
    Result:=clmNewLink
  else
    Result:=inherited GetCopyLinkMode(aLink);
end;

procedure TZone.AddChild(const aChild: IDMElement);
var
  Unk:IUnknown;
  j:integer;
  FacilityModel:IFacilityModel;
begin
  inherited;
  if aChild.QueryInterface(ISafeguardElement, Unk)=0 then Exit;
  case aChild.ClassID of
  _Target,
  _GuardPost,
  _ControlDevice:
    begin
      j:=FSafeguardElements.IndexOf(aChild);
      if j=-1 then
        (FSafeguardElements as IDMCollection2).Add(aChild);

     FacilityModel:=DataModel as IFacilityModel;
     j:=FacilityModel.ExtraTargets.IndexOf(aChild);
     if j=-1 then
       (FacilityModel.ExtraTargets as IDMCollection2).Add(aChild);
    end;
  end;

  case aChild.ClassID of
  _GuardPost,
  _ControlDevice:
    begin
     FacilityModel:=DataModel as IFacilityModel;
     j:=FacilityModel.ExtraTargets.IndexOf(aChild);
     if j=-1 then
       (FacilityModel.ExtraTargets as IDMCollection2).Add(aChild);
    end;
  end;
end;

procedure TZone.RemoveChild(const aChild: IDMElement);
var
  Unk:IUnknown;
  j:integer;
  FacilityModel:IFacilityModel;
begin
  inherited;
  if aChild.QueryInterface(ISafeguardElement, Unk)=0 then Exit;
  case aChild.ClassID of
  _Target,
  _GuardPost,
  _ControlDevice:
    begin
      j:=FSafeguardElements.IndexOf(aChild);
      if j<>-1 then
        (FSafeguardElements as IDMCollection2).Delete(j)
    end;
  end;

  case aChild.ClassID of
  _GuardPost,
  _ControlDevice:
    begin
     FacilityModel:=DataModel as IFacilityModel;
     j:=FacilityModel.ExtraTargets.IndexOf(aChild);
     if j<>-1 then
       (FacilityModel.ExtraTargets as IDMCollection2).Delete(j);
    end;
  end;
end;

procedure TZone.MakePersistant(const SubStateE:IDMElement);
var
  j:integer;
  SafeguardElementE, SafeguardElementStateE:IDMElement;
  FacilityModel:IFacilityModel;
  DMOperationManager:IDMOperationManager;
  Unk:IUnknown;
  SafeguardElementStates:IDMCollection;
begin
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  FacilityModel:=DataModel as IFacilityModel;
  SafeguardElementStates:=FacilityModel.SafeguardElementStates;
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    if SafeguardElementE.Presence=2 then begin   // 2-й этап модернизации  (рекомендация)
      DMOperationManager.AddElement(SafeguardElementE,
        SafeguardElementStates, '', ltOneToMany, Unk, True);
      SafeguardElementStateE:=Unk as IDMElement;
      SafeguardElementStateE.Ref:=SubStateE;
      SafeguardElementE.Presence:=1;            // 1-й этап модернизации   (запомненное состояние)
    end;
  end;
end;

function TZone.GetMaxVelocity(
  var VehicleKindE: IDMElement;
  var PedestrialVelocity:double;
  var MovementKind:integer): double;
var
  FacilityModelS:IFMState;
  j, NodeDirection, WarriorPathStage:integer;
  Velocity, Distance:double;
  ZoneKind:IZoneKind;
  aVehicleKindE, LineE:IDMElement;
  aVehicleKind:IVehicleKind;
  aVehicleType:IVehicleType;
  JumpKind:IJumpKind;
  C0, C1:ICoordNode;
  sinA, AngleCoeff, WeightCoeff, ClimbWeightCoeff, Coeff, KM_H, M_S:double;
  RoadPart:IRoadPart;
  Road:IRoad;
  Line:ILine;
  WarriorGroup:IWarriorGroup;
  Target:ITarget;
  Volume:IVolume;

  function GetClimbVelocity:double;
  begin
    if NodeDirection=pdFrom0to1 then begin      // Вверх, так как
                                            // для строго вертикальных маршрутов 0 всегда внизу
      if Distance>500 then
        Result:=0
      else begin
        Result:=0.4 // м/c
      end
    end else begin                            //Вниз
      if Distance>1500 then
        Result:=0
      else begin
        Result:=1  // м/c
      end
    end;
    if Result>PedestrialVelocity then
      Result:=PedestrialVelocity
  end;

begin
  try
  Result:=0;
  MovementKind:=_PedestrialFast;
  PedestrialVelocity:=Get_PedestrialVelocity;
  VehicleKindE:=nil;
  FacilityModelS:=DataModel as IFMState;
  Line:=FacilityModelS.CurrentLineU as ILine;
  if Line=nil then Exit;
  LineE:=Line as IDMElement;
  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;
  NodeDirection:=FacilityModelS.CurrentNodeDirection;
  WarriorPathStage:=FacilityModelS.CurrentPathStage;

  Volume:=SpatialElement as IVolume;
  if Volume<>nil then
    Distance:=Line.Length
  else
    Distance:=Get_Length;
  if Distance=0 then begin
    Result:=InfinitValue;
    MovementKind:=_MovementImpossible;
    Exit;
  end;

  case WarriorPathStage of
  wpsStealthEntry, wpsFastEntry:
    begin
      WeightCoeff:=1;
      ClimbWeightCoeff:=1;
    end;
  wpsStealthExit, wpsFastExit:
    begin
      Target:=WarriorGroup.FinishPoint as ITarget;
      WeightCoeff:=(70+Target.Mass/WarriorGroup.InitialNumber)/70;
      ClimbWeightCoeff:=10;
    end;
  else
    begin
      WeightCoeff:=1;
      ClimbWeightCoeff:=1;
    end
  end;

  ZoneKind:=Ref as IZoneKind;

  C0:=Line.C0;
  C1:=Line.C1;
  sinA:=abs(C1.Z-C0.Z)/Distance;
  if sinA<=0.95 then begin
    AngleCoeff:=1-sqr(sinA);
    Coeff:=AngleCoeff/WeightCoeff;  // км/ч -> см/с
  end else
    Coeff:=1/ClimbWeightCoeff;
  KM_H:=100000/3600;
  M_S:=100;

  if LineE.Ref=nil then begin         // Движение по стене здания,
    if SinA=1 then begin                   //если оно не окружено никакими зонами
      PedestrialVelocity:=GetClimbVelocity*M_S*Coeff;
      if NodeDirection=pdFrom0to1 then
        MovementKind:=_ClimbUp
      else
        MovementKind:=_ClimbDown
    end else begin
      PedestrialVelocity:=0;
      MovementKind:=_PedestrialFast;
    end;
    Result:=PedestrialVelocity;
  end else
  if LineE.Ref.ClassID=_Jump then begin
    JumpKind:=(Line as IDMElement).Ref.Ref as IJumpKind;
    if NodeDirection=pdFrom0to1 then begin
      if C0.Z>=C1.Z then begin
        PedestrialVelocity:=JumpKind.ClimbDownVelocity*M_S*Coeff;
        MovementKind:=_ClimbDown
      end else begin
        PedestrialVelocity:=JumpKind.ClimbUpVelocity*M_S*Coeff;
        MovementKind:=_ClimbUp
      end;
    end else begin
      if C0.Z<C1.Z then begin
        PedestrialVelocity:=JumpKind.ClimbDownVelocity*M_S*Coeff;
        MovementKind:=_ClimbDown
      end else begin
        PedestrialVelocity:=JumpKind.ClimbUpVelocity*M_S*Coeff;
        MovementKind:=_ClimbUp
      end;
    end;
    Result:=PedestrialVelocity;
  end else
  if (Line as IDMElement).Ref.QueryInterface(IRoadPart,RoadPart)=0 then begin
     Road:=RoadPart.Road;
     PedestrialVelocity:=Road.PedestrialVelocity*KM_H*Coeff;
     Result:=PedestrialVelocity;
     MovementKind:=_PedestrialFast;
     if Road.UserDefinedVehicleVelocity then begin
       if (sinA<=0.5) and
          (Result<Road.VehicleVelocity*KM_H*Coeff) then  begin // угол < 30 град
         for j:=0 to WarriorGroup.Vehicles.Count-1 do begin
           aVehicleKindE:=WarriorGroup.Vehicles.Item[j].Ref;
           aVehicleType:=aVehicleKindE.Parent as IVehicleType;
           if aVehicleType.TypeCode=0 then begin  // если есть наземный транспорт
                                      // то используется явно заданная скорость
             Result:=Road.VehicleVelocity*KM_H*Coeff;
             MovementKind:=_Vehicle;
             VehicleKindE:=aVehicleKindE;
             Exit;
           end;
         end;
       end;
     end else begin
      for j:=0 to WarriorGroup.Vehicles.Count-1 do begin
        aVehicleKindE:=WarriorGroup.Vehicles.Item[j].Ref;
        aVehicleKind:=aVehicleKindE as IVehicleKind;
        aVehicleType:=aVehicleKindE.Parent as IVehicleType;
        if aVehicleType.TypeCode=0 then begin
            Velocity:=aVehicleKind.Velocity1*KM_H*Coeff;
            if Result<Velocity then begin
              Result:=Velocity;
              MovementKind:=_Vehicle;
              VehicleKindE:=aVehicleKindE;
            end;
          end;
      end;
    end;
  end else
  if not Get_UserDefinedVehicleVelocity then begin
    if sinA>0.95 then begin
      PedestrialVelocity:=GetClimbVelocity*M_S*Coeff;
      if NodeDirection=pdFrom0to1 then
        MovementKind:=_ClimbUp
      else
        MovementKind:=_ClimbDown
    end else begin
      PedestrialVelocity:=Get_PedestrialVelocity*KM_H*Coeff;
      MovementKind:=_PedestrialFast;
    end;
    Result:=PedestrialVelocity;
    if sinA<=0.5 then   // угол < 30 град
      for j:=0 to WarriorGroup.Vehicles.Count-1 do begin
        aVehicleKindE:=WarriorGroup.Vehicles.Item[j].Ref;
        aVehicleKind:=aVehicleKindE as IVehicleKind;
        Velocity:=aVehicleKind.GetVelocity(ZoneKind)*KM_H*Coeff;
        if Result<Velocity then begin
          Result:=Velocity;
          MovementKind:=_Vehicle;
          VehicleKindE:=aVehicleKindE;
        end;
      end;
  end else begin
    if sinA>0.95 then
      PedestrialVelocity:=GetClimbVelocity*M_S*Coeff
    else
      PedestrialVelocity:=Get_PedestrialVelocity*KM_H*Coeff;
    Result:=PedestrialVelocity;
    MovementKind:=_PedestrialFast;
    Velocity:=Get_VehicleVelocity*KM_H*Coeff;
    if (sinA<=0.5) and
       (Result<Velocity) then begin // угол < 30 град
      for j:=0 to WarriorGroup.Vehicles.Count-1 do begin
        aVehicleKindE:=WarriorGroup.Vehicles.Item[j].Ref;
        aVehicleKind:=aVehicleKindE as IVehicleKind;
        if aVehicleKind.GetVelocity(ZoneKind)<>0 then begin  // если есть транспорт с ненулевой скоростью
                                   // то используется явно заданная скорость
          Result:=Velocity;
          MovementKind:=_Vehicle;
        end;
      end;
    end;
  end;
  except
      on E:Exception do
        DataModel.HandleError
            ('Error in GetMaxVelocity. ZoneID='+IntToStr(ID));
  end
end;

procedure TZone.MakeBackPathElementStates(const SubStateE: IDMElement);
var
  j:integer;
  SafeguardElement:ISafeguardElement;
  OvercomeMethod:IOvercomeMethod;
  FacilityModel:IFacilityModel;
  SafeguardElementStates2:IDMCollection2;
  ElementStateE, SafeguardElementE:IDMElement;
  ElementStateS:ISafeguardElementState;
  ElementType:ISafeguardElementType;
begin
  FacilityModel:=DataModel as IFacilityModel;
  SafeguardElementStates2:=FacilityModel.SafeguardElementStates as IDMCollection2;
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    if SafeguardElementE.QueryInterface(ISafeguardElement, SafeguardElement)=0 then begin;
      OvercomeMethod:=SafeguardElement.BestOvercomeMethod as IOvercomeMethod;
      if (OvercomeMethod<>nil) and
         OvercomeMethod.Destructive then begin
        ElementStateE:=SafeguardElementStates2.CreateElement(False);
        ElementStateE.Ref:=SubStateE;
        ElementStateE.Parent:=SafeguardElementE;
        ElementStateS:=ElementStateE as ISafeguardElementState;
        ElementType:=SafeguardElementE.Ref.Parent as ISafeguardElementType;
        ElementStateS.DeviceState0:=ElementType.DeviceStates.Item[1]; // не [0] - значит возмущенное состояние
        ElementStateS.DeviceState1:=ElementStateS.DeviceState0;
      end;
    end;
  end;
end;

procedure TZone.CalcVulnerability;
var
  PathNode:IVulnerabilityData;
  P:double;
begin
  FRationalProbabilityToTarget:=-InfinitValue;
  FDelayTimeToTarget:=-InfinitValue;
  FNoDetectionProbabilityFromStart:=-InfinitValue;
  PathNode:=FCentralNode as IVulnerabilityData;
  if PathNode<>nil then begin
    P:=PathNode.RationalProbabilityToTarget;
    if FRationalProbabilityToTarget<P then
      FRationalProbabilityToTarget:=P;
    P:=PathNode.DelayTimeToTarget;
    if FDelayTimeToTarget<P then
      FDelayTimeToTarget:=P;
    P:=PathNode.NoDetectionProbabilityFromStart;
    if FNoDetectionProbabilityFromStart<P then
      FNoDetectionProbabilityFromStart:=P;
  end;
end;


procedure TZone.DoCalcPathSuccessProbability(const TacticU: IInterface;
                          ObservationPeriod:double;
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability,
                          StealthT: double;
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner:double;
                                AddDelay:double);
var
  NoFailureP, NoDetP,
  PrevSuccessSum, SuccessSum,
  DelayTimeSumCent, DelayTimeDispersionSumCent,
  AdversaryVictoryPDelayed,
  ReactionTime, ReactionTimeDispersion,
  ReactionDelayTime, ReactionDelayTimeDispersion,
  ReactionTime1, ReactionTimeDispersion1,
  NoPatrolP, dTDisp2, dT2, StealthTDisp:double;
  NoEvidence:WordBool;
  FacilityModelS:IFMState;
  Position:integer;
begin
  FacilityModelS:=DataModel as IFMState;
  ReactionTime:=FacilityModelS.CurrentReactionTime;
  ReactionTimeDispersion:=FacilityModelS.CurrentReactionTimeDispersion;

  DoCalcNoDetectionProbability(TacticU,
                           ObservationPeriod,
                           NoDetP,
                           NoFailureP,
                           NoEvidence,
                           StealthT, StealthTDisp, Position,
                                AddDelay);

  NoEvidence:=True;

  dT2:=0.5*StealthT;
  dTDisp2:=0.5*StealthTDisp;
  DelayTimeSumCent:=DelayTimeSumInner+dT2;
  DelayTimeDispersionSumCent:=DelayTimeDispersionSumInner+dTDisp2;
  if DelayTimeSumCent>DelayTimeSumOuter then begin // меняем тактику
    DelayTimeSumCent:=DelayTimeSumOuter;
    DelayTimeDispersionSumCent:=DelayTimeDispersionSumOuter;
  end;

  case Position of
  dpInner:AdversaryVictoryProbability:=GetAdversaryVictoryProbability(
                  DelayTimeSumInner, DelayTimeDispersionSumInner,
                  ReactionTime, ReactionTimeDispersion);
  dPCent:AdversaryVictoryProbability:=GetAdversaryVictoryProbability(
                  DelayTimeSumCent, DelayTimeDispersionSumCent,
                  ReactionTime, ReactionTimeDispersion);
  dpOuter:AdversaryVictoryProbability:=GetAdversaryVictoryProbability(
                  DelayTimeSumOuter, DelayTimeDispersionSumOuter,
                  ReactionTime, ReactionTimeDispersion);
  end;

  if NoEvidence=False then begin
    ReactionDelayTime:=Get_PatrolPeriod;
    ReactionDelayTimeDispersion:=0;
    ReactionTime1:=ReactionTime+ReactionDelayTime;
    ReactionTimeDispersion1:=ReactionTimeDispersion+ReactionDelayTimeDispersion;
    AdversaryVictoryPDelayed:=GetAdversaryVictoryProbability(
                 DelayTimeSumInner, DelayTimeDispersionSumInner,
                 ReactionTime1, ReactionTimeDispersion1);
    NoPatrolP:=exp(-DelayTimeSumInner/ReactionDelayTime);
  end else begin
    AdversaryVictoryPDelayed:=0;
    NoPatrolP:=1;
  end;

  PrevSuccessSum:=SuccessProbability;

  SuccessSum:=NoDetP*PrevSuccessSum+
             (NoFailureP-NoDetP)*AdversaryVictoryProbability;
  if not NoEvidence then
    SuccessSum:=SuccessSum+NoDetP*(1-NoPatrolP)*AdversaryVictoryPDelayed;

  if PrevSuccessSum>=SuccessSum then
    SuccessProbability:=SuccessSum;

  if SuccessProbability>1 then
    SuccessProbability:=1;
end;


procedure TZone.CalcObservationPeriod(out ObservationPeriod, UserDefinedNoDetP:double);
var
  R, aPatrolPeriod:double;
  ObservationElementE, LineE:IDMElement;
  Road:IRoad;
  RoadPart:IRoadPart;
  FacilityModelS:IFMState;
  m:integer;
  ObservationElement:IObservationElement;
  ObservationElementES:IElementState;
  aObservationPeriod:double;
  SafeguardElement:ISafeguardElement;
begin
  FacilityModelS:=DataModel as IFMState;
  R:=1/Week;
  aPatrolPeriod:=Get_PatrolPeriod;
  R:=R+1/aPatrolPeriod;
  LineE:=FacilityModelS.CurrentLineU as IDMElement;
  if (LineE as IDMElement).Ref.QueryInterface(IRoadPart,RoadPart)=0 then begin
    Road:=RoadPart.Road;
    case Road.PersonalPresence of
    1: R:=R+1/3600;  //  1 раз в час  (иногда)
    2: R:=R+1/600;   //  1 раз в 10 мин  (постоянно)
    end;
  end;

  UserDefinedNoDetP:=1;
  for m:=0 to FObservers.Count-1 do begin
    ObservationElementE:=FObservers.Item[m].Ref;
    if ObservationElementE.QueryInterface(IObservationElement, ObservationElement)=0 then begin
      SafeguardElement:=ObservationElement as ISafeguardElement;
      if SafeguardElement.InWorkingState then begin
        if (ObservationElement.QueryInterface(IElementState, ObservationElementES)=0) and
          ObservationElementES.UserDefinedDetectionProbability then
          UserDefinedNoDetP:=UserDefinedNoDetP*(1-ObservationElementES.DetectionProbability)
        else begin
          aObservationPeriod:=ObservationElement.GetObservationPeriod(0);
          if aObservationPeriod<>0 then
            R:=R+1/aObservationPeriod
          else begin
            R:=R+InfinitValue;
            Break;
          end;
        end;
      end;
    end;
  end;
  if R<>0 then
    ObservationPeriod:=1/R
  else
    ObservationPeriod:=InfinitValue;
end;

procedure TZone.CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                                AddDelay:double);
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  BestTacticE:IDMElement;
  OldPathStage, FastPathStage:integer;
  StealthT,dT, dTDisp, DelayTimeSumOuter, DelayTimeDispersionSumOuter,
  DelayTimeSumInner, DelayTimeDispersionSumInner:double;
  ObservationPeriod, UserDefinedNoDetP:double;

  MaxSuccessProbability, BestStealthT, aSuccessProbability,
  aAdversaryVictoryProbability:double;
  j, PathStage:integer;
  TacticE:IDMElement;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  DependingSafeguardElementList.Clear;
  BestOvercomeMethodList.Clear;

  OldPathStage:=FacilityModelS.CurrentPathStage;
  if OldPathStage=wpsStealthEntry then
    FastPathStage:=wpsFastEntry
  else
  if OldPathStage=wpsStealthExit then
    FastPathStage:=wpsFastExit
  else
    FastPathStage:=OldPathStage;

  FacilityModelS.CurrentPathStage:=FastPathStage;
  CalcDelayTime(dT, dTDisp, BestTacticE, 0);
  FacilityModelS.CurrentPathStage:=OldPathStage;

  DelayTimeSumInner:=DelayTimeSum;
  DelayTimeDispersionSumInner:=DelayTimeDispersionSum;
  DelayTimeSumOuter:=DelayTimeSum+dT;
  DelayTimeDispersionSumOuter:=DelayTimeDispersionSum+dTDisp;
  DelayTimeSum:=DelayTimeSumOuter;
  DelayTimeDispersionSum:=DelayTimeDispersionSumOuter;

  CalcObservationPeriod(ObservationPeriod, UserDefinedNoDetP);

  PathStage:=FacilityModelS.CurrentPathStage;
  MaxSuccessProbability:=-1;
  BestTacticE:=nil;
  BestStealthT:=InfinitValue;
  for j:=0 to FacilityModel.CurrentZoneTactics.Count-1 do begin // отличие от BoundaryLayer
    TacticE:=FacilityModel.CurrentZoneTactics.Item[j];
    if AcceptableTactic(TacticE) then begin

      theDependingSafeguardElementList.Clear;
      theBestOvercomeMethodList.Clear;
      aSuccessProbability:=SuccessProbability;
      DoCalcPathSuccessProbability(TacticE,
                          ObservationPeriod,
                          aSuccessProbability,
                          aAdversaryVictoryProbability,
                          StealthT,
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner, AddDelay);
      if MaxSuccessProbability=aSuccessProbability then begin
        if BestStealthT>StealthT then begin
          BestStealthT:=StealthT;
          BestTacticE:=TacticE;
                            // оставляем старое значение MaxSuccessProbability
          if PathStage=wpsStealthEntry then
            UpdateDependingElements(
                DependingSafeguardElementList,
                theDependingSafeguardElementList,
                BestOvercomeMethodList,
                theBestOvercomeMethodList);
          AdversaryVictoryProbability:=aAdversaryVictoryProbability;
        end;
      end else
      if MaxSuccessProbability<aSuccessProbability then begin
        MaxSuccessProbability:=aSuccessProbability;
        BestTacticE:=TacticE;

        if PathStage=wpsStealthEntry then
          UpdateDependingElements(
              DependingSafeguardElementList,
              theDependingSafeguardElementList,
              BestOvercomeMethodList,
              theBestOvercomeMethodList);
        AdversaryVictoryProbability:=aAdversaryVictoryProbability;
      end
    end;
  end;
  UpdateDependingElementBestMethods(
      DependingSafeguardElementList,
      BestOvercomeMethodList);

  SuccessProbability:=MaxSuccessProbability;
end;

procedure TZone.UpdateDependingElements(
  const DependingSafeguardElementList,
  theDependingSafeguardElementList,
  BestOvercomeMethodList,
  theBestOvercomeMethodList: TList);
var
  j:integer;
  SafeguardElementP, OvercomeMethodP:pointer;
begin

  DependingSafeguardElementList.Clear;
  BestOvercomeMethodList.Clear;

  for j:=0 to theDependingSafeguardElementList.Count-1 do begin
    SafeguardElementP:=theDependingSafeguardElementList[j];
    OvercomeMethodP:=theBestOvercomeMethodList[j];
    DependingSafeguardElementList.Add(SafeguardElementP);
    BestOvercomeMethodList.Add(OvercomeMethodP);
  end;
end;

procedure TZone.UpdateCoords;
var
  j:integer;
  Volume:IVolume;
  AreaE:IDMElement;
  Area:IArea;
begin
  Volume:=SpatialElement as IVolume;
  if Volume=nil then Exit;
  for j:=0 to Volume.Areas.Count-1 do begin
    AreaE:=Volume.Areas.Item[j];
    Area:=AreaE as IArea;
    if Area.IsVertical and
      (AreaE.Ref<>nil) then
      AreaE.Ref.UpdateCoords
  end;
end;

procedure TZone.BuildReport(ReportLevel, TabCount, Mode: Integer;
  const Report: IDMText);
var
  TacticE, SafeguardElementE:IDMElement;
  WarriorPathStage:integer;
  Line:ILine;
  S, S0, MaxLenS, ModeName:WideString;
  MaxLen, Len, Len0:integer;
  FacilityStateE, WarriorGroupE,
  SafeguardElementKindE, SafeguardElementTypeE:IDMElement;
  j, BestJ, MovementKind:integer;
  WarriorGroup:IWarriorGroup;
  Tactic:ITactic;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  SafeguardElements:IDMCollection;
  SafeguardElements2:IDMCollection2;
  BestTimeSum, BestTimeDispSum, MinValue, aTime, T, DetP, aPatrolPeriod, SumT, ProdP:double;
  C0, C1:ICoordNode;
  SafeguardDatabase:ISafeguardDatabase;
  Boundary0E, Boundary1E:IDMElement;
  ObservationPeriod:double;

  procedure DoZoneCalc(out T, DetP: double);
  var
    aTimeDispersion, NoDetP, NoFailureP:double;
    Position:integer;
    NoEvidence:WordBool;
  begin
    DoCalcDelayTime(TacticE, T, aTimeDispersion, 0);
    case WarriorPathStage of
    wpsStealthEntry,
    wpsStealthExit:
      begin
        DoCalcNoDetectionProbability(TacticE,
                      ObservationPeriod,
                      NoDetP,
                      NoFailureP,
                      NoEvidence,
                      BestTimeSum, BestTimeDispSum, Position, 0);
        DetP:=1-NoDetP;
      end;
    end;
  end;

  procedure DoSafeguardElementCalc;
  var
    SafeguardElement:ISafeguardElement;
    SafeguardElementTypeE, SafeguardElementKindE:IDMElement;
    SafeguardElementType:ISafeguardElementType;
    T, TDisp, DetP, BestTime:double;
    DistantDetectionElement:IDistantDetectionElement;
    DontCalc, F0, F1:boolean;
    C0, C1:ICoordNode;
    X0, Y0, Z0, X1, Y1, Z1:double;
    CRef0, CRef1:IDMElement;
  begin
    SafeguardElement:=SafeguardElementE as ISafeguardElement;
    SafeguardElementKindE:=SafeguardElementE.Ref;
    SafeguardElementTypeE:=SafeguardElementKindE.Parent;
    SafeguardElementType:=SafeguardElementTypeE as ISafeguardElementType;

    DontCalc:=False;
    if (SafeguardElementE.ClassID<>_GuardPost) and
       SafeguardElementType.CanDelay then begin
      if SafeguardElement.QueryInterface(IDistantDetectionElement,
                                           DistantDetectionElement)=0 then begin
        C0:=Line.C0;
        C1:=Line.C1;
        CRef0:=(C0 as IDMElement).Ref;
        CRef1:=(C1 as IDMElement).Ref;
        X0:=C0.X;
        Y0:=C0.Y;
        Z0:=C0.Z;
        X1:=C1.X;
        Y1:=C1.Y;
        Z1:=C1.Z;
        F0:=DistantDetectionElement.PointInDetectionZone(X0, Y0, Z0, CRef0, nil);
        F1:=DistantDetectionElement.PointInDetectionZone(X1, Y1, Z1, CRef1, nil);
        DontCalc:=F0 and F1;
      end;
      if DontCalc then
        S:=S+' |     - '
      else begin
        SafeguardElement.CalcDelayTime(TacticE, T, TDisp);
        if T<999999 then begin
          S:=S+Format(' | %6.0f', [T]);
        end else begin
          S:=S+' | Бесконечно';
//          S:=S+' | Тактика не применима';
        end;
        SumT:=SumT+T;
      end;
    end else
      S:=S+' |     - ';

    case WarriorPathStage of
    wpsStealthEntry,
    wpsStealthExit:
      begin
        SafeguardElement.CalcDetectionProbability(TacticE,
                     DetP, BestTime);
        S:=S+Format(' | %6.4f', [DetP]);
        ProdP:=ProdP*(1-DetP);
        if SafeguardElement.CurrOvercomeMethod<>nil then
          S:=S+' | '+SafeguardElement.CurrOvercomeMethod.Name
        else
          S:=S+' | Вне зоны действия'
      end;
    else
      begin
        if SafeguardElement.CurrOvercomeMethod<>nil then
          S:=S+' | '+SafeguardElement.CurrOvercomeMethod.Name
        else
          S:=S+' | Ошибка !!!'
      end;
    end;
    if DontCalc then
      S:=S+' (Задержка учитывается на границе зоны видимости)'
  end;

  procedure MakeHeader(CommentMode:integer);
  var
    j:integer;
  begin
    S:=Format('| %-'+MaxLenS+'s', [ModeName]);
    S:=S+' | Время задержки, с';
    case WarriorPathStage of
    wpsStealthEntry,
    wpsStealthExit:
      S:=S+' | Вероятность обнаружения';
    end;
    case CommentMode of
    0: S:=S+' | Способ преодоления';
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
var
  Volume:IVolume;
  SafeguardElement:ISafeguardElement;
begin
  FacilityModel:=DataModel as IFacilityModel;
  if FacilityModel=nil then Exit;

  Report.AddLine(S);
  Report.AddLine(S);

  Volume:=SpatialElement as IVolume;
  if (Volume<>nil) and
     (Volume.Areas.Count=0) then begin
    S:='Зона "'+Name+'" типа "'+ Ref.Name+'" является объединением следующих зон:';
    Report.AddLine(S);
    S:='  ';
    for j:=0 to FZones.Count-1 do begin
      S:=S+'  "'+FZones.Item[j].Name+'"';
      if j<FZones.Count-1 then
        S:=S+',';
    end;
    Report.AddLine(S);
    Exit;
  end;

  FacilityModelS:=DataModel as IFMState;

  ModeName:=Get_ReportModeName(Mode);

  TacticE:=FacilityModelS.CurrentTacticU as IDMElement;
  Tactic:=TacticE as ITactic;
  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  WarriorGroup:=WarriorGroupE as IWarriorGroup;
  WarriorPathStage:=FacilityModelS.CurrentPathStage;
  Line:=FacilityModelS.CurrentLineU as ILine;
  Boundary0E:=FacilityModelS.CurrentBoundary0U as IDMElement;
  Boundary1E:=FacilityModelS.CurrentBoundary1U as IDMElement;

  S:='Пересечение зоны "'+Name+'" типа "'+ Ref.Name+'"';
  Report.AddLine(S);

  if (Boundary0E<>nil) and
     (Boundary1E<>nil) then begin
    S:='между участком маршрута "'+Boundary0E.Name+'" и участком  маршрута "'+ Boundary1E.Name+'"';
    Report.AddLine(S);
  end;

  CalcPatrolPeriod;

  case Mode of
  0:begin    // Средство охраны
      ModeName:=Get_ReportModeName(Mode);

      S:='"'+WarriorGroupE.Name+'" ';
      S:=S+'"'+FacilityStateE.Name+'" ';
      S:=S+'"'+TacticE.Name+'"';
      Report.AddLine(S);

      MaxLen:=Length(ModeName)+1;
      SafeguardElements:=TDMCollection.Create(nil) as IDMCollection;
      SafeguardElements2:=SafeguardElements as IDMCollection2;
      SafeguardElements2.Add(Self as IDMElement);
      Len:=Length(Name);
      if MaxLen<Len then MaxLen:=Len;

      for j:=0 to FSafeguardElements.Count-1 do begin
        SafeguardElementE:=FSafeguardElements.Item[j];
        SafeguardElementKindE:=SafeguardElementE.Ref;
        if SafeguardElementKindE<>nil then begin
          SafeguardElementTypeE:=SafeguardElementKindE.Parent;
          if (SafeguardElementE.ClassID<>_Target) and
             (SafeguardElementE.ClassID<>_GuardPost) and
             (SafeguardElementE.ClassID<>_TVCamera) and
             (SafeguardElementE.ClassID<>_VolumeSensor) and
             (SafeguardElementE.ClassID<>_SurfaceSensor) and
             (SafeguardElementE.ClassID<>_PerimeterSensor) and
             (SafeguardElementTypeE.Parents.IndexOf(TacticE)<>-1) then begin
             SafeguardElement:=SafeguardElementE as ISafeguardElement;
             if SafeguardElement.IsPresent and
                SafeguardElement.InWorkingState then begin
               SafeguardElements2.Add(SafeguardElementE);
               Len:=Length(SafeguardElementE.Name);
               if MaxLen<Len then MaxLen:=Len;
             end;
          end;
        end;
      end;

      C0:=Line.C0;
      C1:=Line.C1;

      case WarriorPathStage of
      wpsStealthEntry,
      wpsStealthExit:
        begin
          for j:=0 to FObservers.Count-1 do begin
            SafeguardElementE:=FObservers.Item[j].Ref;
            SafeguardElement:=SafeguardElementE as ISafeguardElement;
            if SafeguardElement.IsPresent and
               SafeguardElement.InWorkingState then begin
              SafeguardElements2.Add(SafeguardElementE);
              Len:=Length(SafeguardElementE.Name);
              if MaxLen<Len then MaxLen:=Len;
            end;
          end;
        end;
      end;
      MaxLenS:=IntToStr(MaxLen);

      MakeHeader(0);

      SumT:=0;
      ProdP:=1;
      for j:=0 to SafeguardElements.Count-1 do begin
        SafeguardElementE:=SafeguardElements.Item[j];
        S:=Format('| %-'+MaxLenS+'s', [SafeguardElementE.Name]);
        if j=0 then begin
          aTime:=GetMovementDelayTime(MovementKind);
          aPatrolPeriod:=FPatrolPeriod;
          DetP:=1-exp(-aTime/aPatrolPeriod);
          S:=S+Format(' | %6.0f',[aTime]);
          case WarriorPathStage of
          wpsStealthEntry,
          wpsStealthExit:
            S:=S+Format(' | %6.4f',[DetP]);
          end;
          case MovementKind of
          _PedestrialFast:    S:=S+' | '+'Пробежать';
          _PedestrialStealth: S:=S+' | '+'Прокрасться';
          _Vehicle: S:=S+' | '+'Использовать транспортное средство';
          _ClimbUp: S:=S+' | '+'Вскарабкаться вверх';
          _ClimbDown: S:=S+' | '+'Спуститься вниз';
          _MovementImpossible: S:=S+' | '+'Движение невозможно';
          end;
          SumT:=SumT+aTime;
          ProdP:=ProdP*(1-DetP);
        end else
          DoSafeguardElementCalc;
        Report.AddLine(S);
      end; //for j:=0 to BoundaryLayer.SafeguardElements.Count-1

      Report.AddLine(S0);
      S:=Format('| %'+MaxLenS+'s', ['Итог']);
      if SumT<999999 then
        S:=S+Format(' | %6.0f', [SumT])
      else
        S:=S+' |  Бескон.';
      case WarriorPathStage of
      wpsStealthEntry,
      wpsStealthExit:
        S:=S+Format(' | %6.4f',[1-ProdP]);
      end;
      S:=S+' | ';
      Report.AddLine(S);
      Report.AddLine(S0);
    end;  // 0:
   1:begin  // тактика
       SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;

       S:='"'+WarriorGroupE.Name+'"  "'+FacilityStateE.Name+'" ';
       Report.AddLine(S);

       MaxLen:=Length(ModeName)+1;
       MinValue:=InfinitValue;
       BestJ:=-1;
       for j:=0 to FacilityModel.CurrentZoneTactics.Count-1 do begin
         TacticE:=FacilityModel.CurrentZoneTactics.Item[j];
//       for j:=0 to SafeguardDatabase.Tactics.Count-1 do begin
//         TacticE:=SafeguardDatabase.Tactics.Item[j];
         Len:=Length(TacticE.Name);
         if MaxLen<Len then MaxLen:=Len;
         Tactic:=TacticE as ITactic;
//         if (Tactic.PathArcKind=1) and
//             FacilityModel.AcceptableTactic(TacticE,WarriorGroupE, nil, WarriorPathStage) then begin
           DoZoneCalc(T, DetP);
           case WarriorPathStage of
           wpsStealthEntry,
           wpsStealthExit:
             if MinValue>DetP then begin
               MinValue:=DetP;
               BestJ:=j;
             end;
           else
             if MinValue>T then begin
               MinValue:=T;
               BestJ:=j;
             end;
           end;
//         end;
       end;

       MaxLenS:=IntToStr(MaxLen);

       MakeHeader(1);

       for j:=0 to FacilityModel.CurrentZoneTactics.Count-1 do begin
         TacticE:=FacilityModel.CurrentZoneTactics.Item[j];
//       for j:=0 to SafeguardDatabase.Tactics.Count-1 do begin
//         TacticE:=SafeguardDatabase.Tactics.Item[j];
         Tactic:=TacticE as ITactic;
//         if (Tactic.PathArcKind=1) and
//             FacilityModel.AcceptableTactic(TacticE,WarriorGroupE, nil, WarriorPathStage) then begin
           S:=Format('| %-'+MaxLenS+'s', [TacticE.Name]);
           DoZoneCalc(T, DetP);
           if T<999999 then
             S:=S+Format(' | %6.0f',[T])
           else
             S:=S+' | Бескон.';
           case WarriorPathStage of
           wpsStealthEntry,
           wpsStealthExit:
             begin
               S:=S+Format(' | %6.4f',[DetP]);
             end;
           end;
           Report.AddLine(S);
//         end;
       end;
       if BestJ<>-1 then
         S:=S+' | Наилучшая тактика'
       else
         S:=S+' | ';
       Report.AddLine(S0);
     end; // 1:
   2:begin  // Состояния СФЗ
      S:='"'+WarriorGroupE.Name+'" ';
      S:=S+'"'+TacticE.Name+'"';
      Report.AddLine(S);

      MaxLen:=Length(ModeName)+1;
      for j:=0 to FacilityModel.FacilityStates.Count-1 do begin
        Len:=Length(FacilityModel.FacilityStates.Item[j].Name);
        if MaxLen<Len then MaxLen:=Len;
      end;

      MaxLenS:=IntToStr(MaxLen);

      MakeHeader(1);

      for j:=0 to FacilityModel.FacilityStates.Count-1 do begin
        FacilityStateE:=FacilityModel.FacilityStates.Item[j];
        FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
        CalcPatrolPeriod;
        S:=Format('| %-'+MaxLenS+'s', [FacilityStateE.Name]);
        DoZoneCalc(T, DetP);
        if T<999999 then
          S:=S+Format(' | %6.0f',[T])
        else
          S:=S+' | Бескон.';
        case WarriorPathStage of
        wpsStealthEntry,
        wpsStealthExit:
          begin
            S:=S+Format(' | %6.4f',[DetP]);
          end;
        end;
        S:=S+' | ';
        Report.AddLine(S);
      end;
      Report.AddLine(S0);
    end; // 2:
   3:begin  // Группы
      S:='"'+FacilityStateE.Name+'" ';
      S:=S+'"'+TacticE.Name+'"';
      Report.AddLine(S);

      MaxLen:=Length(ModeName)+1;
      for j:=0 to FacilityModel.AdversaryGroups.Count-1 do begin
        WarriorGroupE:=FacilityModel.AdversaryGroups.Item[j];
        Len:=Length(WarriorGroupE.Name+'/'+WarriorGroupE.Parent.Name);
        if MaxLen<Len then MaxLen:=Len;
      end;
      for j:=0 to FacilityModel.GuardGroups.Count-1 do begin
        WarriorGroupE:=FacilityModel.GuardGroups.Item[j];
        Len:=Length(WarriorGroupE.Name+'/'+WarriorGroupE.Parent.Name);
        if MaxLen<Len then MaxLen:=Len;
      end;

      MaxLenS:=IntToStr(MaxLen);

      MakeHeader(1);

      for j:=0 to FacilityModel.AdversaryGroups.Count-1 do begin
        WarriorGroupE:=FacilityModel.AdversaryGroups.Item[j];
        S:=Format('| %-'+MaxLenS+'s', [WarriorGroupE.Name+'/'+
                            WarriorGroupE.Parent.Name]);
        if (Tactic.PathArcKind=1)
//        and
//           FacilityModel.AcceptableTactic(TacticE,WarriorGroupE, nil, WarriorPathStage)
                then begin
          DoZoneCalc(T, DetP);
          if T<999999 then
            S:=S+Format(' | %6.0f',[T])
          else
            S:=S+' | Бескон.';
          case WarriorPathStage of
          wpsStealthEntry,
          wpsStealthExit:
            begin
              S:=S+Format(' | %6.4f',[DetP]);
            end;
          end;
            S:=S+' | ';
        end else begin
          S:=S+' |     - ';
          S:=S+' |     - ';
          S:=S+' | Тактика не применима';
        end;
        Report.AddLine(S);
      end;
      for j:=0 to FacilityModel.GuardGroups.Count-1 do begin
        WarriorGroupE:=FacilityModel.GuardGroups.Item[j];
        S:=Format('| %-'+MaxLenS+'s', [WarriorGroupE.Name+'/'+
                            WarriorGroupE.Parent.Name]);
        if (Tactic.PathArcKind=1)
//        and
//           FacilityModel.AcceptableTactic(TacticE,WarriorGroupE, nil, WarriorPathStage)
          then begin
          DoZoneCalc(T, DetP);
          if T<999999 then
            S:=S+Format(' | %6.0f',[T])
          else
            S:=S+' | Бескон.';
          case WarriorPathStage of
          wpsStealthEntry,
          wpsStealthExit:
            begin
              S:=S+Format(' | %6.4f',[DetP]);
            end;
          end;
            S:=S+' | ';
        end else begin
          S:=S+' |     - ';
          S:=S+' |     - ';
          S:=S+' | Тактика не применима';
        end;
        Report.AddLine(S);
      end;

      Report.AddLine(S0);
    end; // 3:
  end; // case chbTable.ItemIndex
end;

function TZone.Get_ReportModeCount: integer;
begin
  Result:=4;
end;

function TZone.Get_ReportModeName(Index: integer): WideString;
begin
  case Index of
  0: Result:='Средства охраны';
  1: Result:='Тактика преодолдения';
  2: Result:='Состояние СФЗ';
  3: Result:='Группа';
  else
    Result:=inherited Get_ReportModeName(Index);
  end;
end;

function TZone.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(zpVehicleVelocity):
      Result:=FUserDefinedVehicleVelocity;
  else
    Result:=inherited FieldIsVisible(Code);
  end;
end;

procedure TZone.UpdateDependingElementBestMethods(
  const theDependingSafeguardElementList, theBestOvercomeMethodList: TList);
var
  j:integer;
  SafeguardElementE, OvercomeMethodE:IDMElement;
  SafeguardElement:ISafeguardElement;
begin
  for j:=0 to theDependingSafeguardElementList.Count-1 do begin
    SafeguardElementE:=IDMElement(theDependingSafeguardElementList[j]);
    OvercomeMethodE:=IDMElement(theBestOvercomeMethodList[j]);
    SafeguardElement:=SafeguardElementE as ISafeguardElement;
    SafeguardElement.BestOvercomeMethod:=OvercomeMethodE;
  end;
end;

function TZone.Get_InnerZoneOutline(Index: Integer): IDMCollection;
begin
  Result:=IDMCollection(FInnerZoneOutlines[Index])
end;

function TZone.Get_InnerZoneOutlineCount: Integer;
begin
  Result:=FInnerZoneOutlines.Count
end;

function TZone.Get_IsConvex: WordBool;
begin
  Result:=FIsConvex
end;

function TZone.Get_Outline: IDMCollection;
begin
  Result:=FOutline
end;

type
  PLineRec=^TLineRec;
  TLineRec=record
    X0:double;
    Y0:double;
    X1:double;
    Y1:double;
    W:double;
  end;

procedure TZone.MakeOutlinePath(const OutlineFactory, NodeFactory:IDMCollection2);
var
  Volume:IVolume;

  function IsConvexNode(const Node, C0, C1, oldC0, oldC1:ICoordNode;
                        MinZ:double):boolean;
  var
    Node0, Node1:ICoordNode;
    aX, aY, X, Y, X0, Y0, X1, Y1:double;
    L0, L1, cosA:double;
  begin // IsConvexNode
    Result:=True;
    if Node=oldC0 then
      Node1:=oldC1
    else
    if Node=oldC1 then
      Node1:=oldC0
    else Exit;

    if Node=C0 then
      Node0:=C1
    else
      Node0:=C0;

    X:=Node.X;
    Y:=Node.Y;
    X0:=Node0.X;
    Y0:=Node0.Y;
    X1:=Node1.X;
    Y1:=Node1.Y;
    L0:=sqrt(sqr(X0-X)+sqr(Y0-Y));
    L1:=sqrt(sqr(X1-X)+sqr(Y1-Y));
    cosA:=((X0-X)*(X1-X)+(Y0-Y)*(Y1-Y))/(L0*L1);
    if abs(cosA+1)<0.0001 then
      Exit;

    aX:=0.25*(X0+X1)+0.5*X;
    aY:=0.25*(Y0+Y1)+0.5*Y;
    Result:=Volume.ContainsPoint(aX, aY, MinZ);
    if Result then Exit;
  end; // IsConvexNode

  procedure BuildOutline(const Outline:IDMCollection; SelfOutline:boolean);

    procedure FindLineCrossection(const CC0, CC1:ICoordNode;
               XX0, XX1, YY0, YY1, LL, WW:double;
               const Line:ILine; LineRec:PLineRec;
               out PX0,  PY0,  PZ0:double);
    var
      C0, C1:ICoordNode;
      X0, Y0, X1, Y1, XX, YY, X, Y:double;
      W, L, aL, cosA:double;
    begin // FindLineCrossection
      C0:=Line.C0;
      C1:=Line.C1;
      X0:=LineRec.X0;
      Y0:=LineRec.Y0;
      X1:=LineRec.X1;
      Y1:=LineRec.Y1;
      W:=LineRec.W;
      L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
      cosA:=((XX1-XX0)*(X1-X0)+sqr(YY1-YY0)*(Y1-Y0))/(LL*L);
      if CC0=C0 then begin
        XX:=XX0;
        YY:=YY0;
        X:=X0;
        Y:=Y0;
      end else
      if CC0=C1 then begin
        XX:=XX0;
        YY:=YY0;
        X:=X1;
        Y:=Y1;
      end else
      if CC1=C0 then begin
        XX:=XX1;
        YY:=YY1;
        X:=X0;
        Y:=Y0;
      end else
      if CC1=C1 then begin
        XX:=XX1;
        YY:=YY1;
        X:=X1;
        Y:=Y1;
      end else
      begin
        DataModel.HandleError('Error in MakeOutlinePath. Zone.Id='+IntToStr(ID));
      end;
      if WW<W then begin
        XX:=X;   // для выравнивания по отрезоку контура, наиболее далекому от границы
        YY:=Y;
        aL:=L;
      end else
        aL:=LL;

      if (abs(abs(cosA)-1)<0.01) then begin // если линии приблизительно параллельны (A<0.5 град)
        PX0:=XX;
        PY0:=YY;
      end else
      if LineCanIntersectLine0(
                 XX0, YY0,
                 XX1, YY1,
                 X0, Y0,
                 X1, Y1,
                 PX0,  PY0) then begin
         if sqrt(sqr(XX-PX0)+sqr(YY-PY0))>aL then begin  // пересечение слишком далеко
           PX0:=XX;
           PY0:=YY;
         end;
      end else begin
        PX0:=XX;
        PY0:=YY;
      end;
    end; // FindLineCrossection

  var
    Line:ILine;
    C0, C1:ICoordNode;
    MinZ:double;
    LineList, LineRecList:TList;
    j:integer;
    aLineE, aAreaE, aBoundaryE:IDMElement;
    aLine:ILine;
    aArea:IArea;
    aBoundary:IBoundary;
    aBoundaryFE:IFacilityElement;
    CC0, CC1, N0, N1, Node, PathNode0, PathNode1, thePathNode0:ICoordNode;
    XN, YN, XC, YC, W, WW, W1, X0, Y0, Z0, X1, Y1, Z1,
    XX0, XX1, YY0, YY1, PX0, PX1, PY0, PY1, PZ0, PZ1, LL, L,
    cosX, cosY:double;
    PathArcL, aLine0, aLine1, aPathArcL:ILine;
    LineRec, LineRec0, LineRec1:PLineRec;
    aPathArcE, PathNodeE:IDMElement;
    Outline2:IDMCollection2;
    Volume0, Volume1, Volume:IVolume;
  begin // BuildOutline
    Outline2:=Outline as IDMCollection2;
    ReorderLines0(Outline, nil);

    LineList:=TList.Create;
    LineRecList:=TList.Create;
    for j:=0 to Outline.Count-1 do begin
      aLineE:=Outline.Item[j];
      LineList.Add(pointer(aLineE));
    end;
    Outline2.Clear;

    for j:=0 to LineList.Count-1 do begin  // создаем список концов отрезков контура (не измененных)
      aLineE:=IDMElement(LineList[j]);
      aLine:=aLineE as ILine;
      aArea:=aLine.GetVerticalArea(bdUp);
      if aArea=nil then
        Continue;
      C0:=aArea.C0;
      C1:=aArea.C1;
      X0:=C0.X;
      Y0:=C0.Y;
      X1:=C1.X;
      Y1:=C1.Y;
      XC:=0.5*(X0+X1);
      YC:=0.5*(Y0+Y1);
      aAreaE:=aArea as IDMElement;
      aBoundaryE:=aAreaE.Ref;
      aBoundary:=aBoundaryE as IBoundary;
      aBoundaryFE:=aBoundaryE as IFacilityElement;
      if aBoundaryFE.PathArcs.Count>0 then begin
        PathArcL:=aBoundaryFE.PathArcs.Item[0] as ILine;
        N0:=PathArcL.C0;
        N1:=PathArcL.C1;
        if (N0 as IDMElement).Ref=Self as IDMElement then
          Node:=N0
        else
          Node:=N1;
        XN:=Node.X;
        YN:=Node.Y;
        W:=sqrt(sqr(XC-XN)+sqr(YC-YN));
        if W>10 then begin
          W1:=W-10; // контур должен пересекать PathArc
          XN:=XC+(XN-XC)*W1/W;
          YN:=YC+(YN-YC)*W1/W;
        end;
        GetMem(LineRec, SizeOf(TLineRec));
        LineRecList.Add(LineRec);
        LineRec.X0:=XN+(X0-XC);
        LineRec.Y0:=YN+(Y0-YC);
        LineRec.X1:=XN+(X1-XC);
        LineRec.Y1:=YN+(Y1-YC);
        LineRec.W:=W;
      end
    end;  // for j:=0 to LineList.Count-1

    PathNode1:=nil;
    for j:=0 to LineRecList.Count-1 do begin  // вычисляем точки пересечения отрезков контура
      LineRec:=LineRecList[j];
      aLine:=IDMElement(LineList[j]) as ILine;
      CC0:=aLine.C0;
      CC1:=aLine.C1;
      Z0:=CC0.Z;
      Z1:=CC1.Z;
      XX0:=LineRec.X0;
      YY0:=LineRec.Y0;
      XX1:=LineRec.X1;
      YY1:=LineRec.Y1;
      WW:=LineRec.W;
      LL:=sqrt(sqr(XX1-XX0)+sqr(YY1-YY0));

      if j=0 then begin
        LineRec0:=LineRecList[LineRecList.Count-1];
        aLine0:=IDMElement(LineList[LineRecList.Count-1]) as ILine;
        FindLineCrossection(CC0, CC1,
               XX0, XX1, YY0, YY1, LL, WW,
               aLine0, LineRec0,
               PX0,  PY0,  PZ0);
        PathNodeE:=NodeFactory.CreateElement(False);
//        NodeFactory.Add(PathNodeE);
        PathNodeE.Ref:=Self as IDMElement;
        PathNode0:=PathNodeE as ICoordNode;
        PathNode0.X:=PX0;
        PathNode0.Y:=PY0;
        PathNode0.Z:=Z0;
        thePathNode0:=PathNode0;
      end else
        PathNode0:=PathNode1;

      if j<>LineRecList.Count-1 then begin
        LineRec1:=LineRecList[j+1];
        aLine1:=IDMElement(LineList[j+1]) as ILine;
        FindLineCrossection(CC0, CC1,
               XX0, XX1, YY0, YY1, LL, WW,
               aLine1, LineRec1,
               PX1,  PY1,  PZ1);
        PathNodeE:=NodeFactory.CreateElement(False);
//        NodeFactory.Add(PathNodeE);
        PathNodeE.Ref:=Self as IDMElement;
        PathNode1:=PathNodeE as ICoordNode;
        PathNode1.X:=PX1;
        PathNode1.Y:=PY1;
        PathNode1.Z:=Z1;
      end else
        PathNode1:=thePathNode0;

      aPathArcE:=OutlineFactory.CreateElement(False);
//      OutlineFactory.Add(aPathArcE);
      Outline2.Add(aPathArcE);
      aPathArcE.Ref:=Self as IDMElement;
      aPathArcL:=aPathArcE as ILine;
      aPathArcL.C0:=PathNode0;
      aPathArcL.C1:=PathNode1;

      FreeMem(LineRec, SizeOf(TLineRec))
    end;
    LineRecList.Free;
    LineList.Free;
  end;  // BuildOutline

  function JoinCollections(const Lines, aLines:IDMCollection):boolean;
  var
    k, j:integer;
    aLineE:IDMElement;
    aLines2:IDMCollection2;
  begin // JoinCollections
    Result:=False;
    k:=0;
    while k<Lines.Count do begin
      aLineE:=Lines.Item[k];
      if aLines.IndexOf(aLineE)=-1 then
        inc(k)
      else
        Break
    end;
    if k=Lines.Count then
      Exit;

    Result:=True;
    aLines2:=aLines as IDMCollection2;
    for k:=0 to Lines.Count-1 do begin
      aLineE:=Lines.Item[k];
      j:=aLines.IndexOf(aLineE);
      if j=-1 then
        aLines2.Add(aLineE)
      else
        aLines2.Delete(j);
    end;
    (Lines as IDMCollection2).Clear;
  end; // JoinCollections

var
  InnerOutline, aInnerOutline:IDMCollection;
  j, m:integer;
  SpatialModel2:ISpatialModel2;
  aVolume:IVolume;
  MinZ, MaxBottomZ, BottomZ, aMinZ:double;
  oldLine:ILine;
  oldC0, oldC1, C0, C1:ICoordNode;
  Line:ILine;
  aAreaE, aBoundaryTypeE:IDMElement;
  aArea:IArea;
begin  // TZone.MakeOutlinePath
  FIsConvex:=False;

 (FOutline as IDMCollection2).Clear;
  for j:=0 to FInnerZoneOutlines.Count-1 do begin
    aInnerOutline:=IDMCollection(FInnerZoneOutlines[j]);
    (aInnerOutline as IDMCollection2).Clear;
    aInnerOutline._Release;
  end;
  FInnerZoneOutlines.Clear;

  Volume:=SpatialElement as IVolume;
  if Volume=nil then Exit;
  if Volume.Areas.Count=0 then Exit;

  MinZ:=Volume.MinZ;
  MaxBottomZ:=MinZ;
  for j:=0 to Volume.BottomAreas.Count-1 do begin
    aAreaE:=Volume.BottomAreas.Item[j];
    if aAreaE.Ref=nil then Exit;
    aBoundaryTypeE:=aAreaE.Ref.Ref.Parent;
    if aBoundaryTypeE.ID=btVirtual then Exit;

    aArea:=aAreaE as IArea;
    BottomZ:=aArea.MaxZ;
    if MaxBottomZ>BottomZ then
      MaxBottomZ:=BottomZ;
  end;

  SpatialModel2:=DataModel as ISpatialModel2;
  SpatialModel2.MakeVolumeOutline(Volume, FOutline);
  for j:=0 to FZones.Count-1 do begin
    aVolume:=FZones.Item[j].SpatialElement as IVolume;
    aMinZ:=aVolume.MinZ;
    if aMinZ>MaxBottomZ then
      Continue;
    InnerOutline:=DataModel.CreateCollection(-1, nil);
    SpatialModel2.MakeVolumeOutline(aVolume, InnerOutline);
    aInnerOutline:=nil;
    m:=0;
    while m<FInnerZoneOutlines.Count do begin
      aInnerOutline:=IDMCollection(FInnerZoneOutlines[m]);
      if JoinCollections(aInnerOutline, InnerOutline) then begin
        FInnerZoneOutlines.Delete(m);
        aInnerOutline._Release;
      end else
        inc(m)
    end;
    if m<FInnerZoneOutlines.Count then  // контур лежит над одним из уже найденных
      (InnerOutline as IDMCollection2).Clear
    else
    if not JoinCollections(InnerOutline, FOutLine) then begin
      FInnerZoneOutlines.Add(pointer(InnerOutline));
      InnerOutline._AddRef;
    end;
  end;

  oldLine:=FOutline.Item[FOutline.Count-1] as ILine;
  oldC0:=oldLine.C0;
  oldC1:=oldLine.C1;
  FIsConvex:=True;
  for j:=0 to FOutline.Count-1 do begin
    Line:=FOutline.Item[j] as ILine;
    C0:=Line.C0;
    C1:=Line.C1;
    if not IsConvexNode(C0, C0, C1, oldC0, oldC1, MinZ) then
       FIsConvex:=False;
    if not IsConvexNode(C1, C0, C1, oldC0, oldC1, MinZ) then
       FIsConvex:=False;
    oldC0:=C0;
    oldC1:=C1;
  end;
  if not FIsConvex then
    BuildOutline(FOutline, True)
  else
    (FOutline as IDMCollection2).Clear;

  for j:=0 to FInnerZoneOutlines.Count-1 do begin
    aInnerOutline:=IDMCollection(FInnerZoneOutlines[j]);
    BuildOutline(aInnerOutline, False);
  end;
end; // TZone.MakeOutlinePath

function TZone.Get_ZoneNode: IDMElement;
begin
  Result:=FZoneNode
end;

procedure TZone.Set_ZoneNode(const Value: IDMElement);
begin
  FZoneNode:=Value
end;

procedure TZone.MakeRoundaboutPath(const theStartNodeE, theFinishNodeE: IDMElement;
  const ArcFactory, NodeFactory: IDMCollection2);
var
  XX0, YY0, ZZ0, XX1, YY1, ZZ1:double;
  PathArc2:IDMCollection2;
  OuterFlag:boolean;
  theStartLineE, theFinishLineE:IDMElement;
  StartOutlineJ, FinishOutlineJ:integer;
  FirstArcE, LastArcE:IDMElement;
  FirstArcL, LastArcL:ILine;
  aStartNodeE, aFinishNodeE:IDMElement;
  aStartNode, aFinishNode:ICoordNode;
  Corner0, Corner1:boolean;

  procedure FindStartFinish;
  var
    MinD20, MinD21,BestX0, BestY0, BestX1, BestY1:double;

    procedure FindNearestLine(OutlineJ:integer);
    var
      aLineE:IDMElement;
      aLine:ILine;
      j:integer;
      P0X, P0Y, P1X, P1Y, X, Y:double;
      C0, C1:ICoordNode;
      D20, D21:double;
      Outline:IDMCollection;
      Flag0, Flag1:boolean;
    begin
      if OutlineJ=-1 then
        Outline:=FOutline
      else
        Outline:=Get_InnerZoneOutline(OutlineJ);

      Corner0:=False;
      Corner1:=False;

      for j:=0 to Outline.Count-1 do begin
        aLineE:=Outline.Item[j];
        aLine:=aLineE as ILine;
        C0:=aLine.C0;
        C1:=aLine.C1;
        P0X:=C0.X;
        P0Y:=C0.Y;
        P1X:=C1.X;
        P1Y:=C1.Y;

        PerpendicularFrom0(P0X, P0Y, P1X, P1Y, XX0, YY0, X, Y);
        if ((P0X-X)*(P1X-X)<=0) and
           ((P0Y-Y)*(P1Y-Y)<=0) then begin
          D20:=sqr(XX0-X)+sqr(YY0-Y);
           if MinD20>D20 then begin
             MinD20:=D20;
             BestX0:=X;
             BestY0:=Y;
             theStartLineE:=aLineE;
             StartOutlineJ:=OutlineJ;
           end;
         end;

        PerpendicularFrom0(P0X, P0Y, P1X, P1Y, XX1, YY1, X, Y);
        if ((P0X-X)*(P1X-X)<=0) and
           ((P0Y-Y)*(P1Y-Y)<=0) then begin
          D21:=sqr(XX1-X)+sqr(YY1-Y);
          if MinD21>D21 then begin
            MinD21:=D21;
            BestX1:=X;
            BestY1:=Y;
            theFinishLineE:=aLineE;
            FinishOutlineJ:=OutlineJ;
          end;
        end;
      end; // for j:=0 to Outline.Count-1

      if (StartOutlineJ=-2) or
         (FinishOutlineJ=-2) then begin  // Не найдена хотя бы одна ближайшая точка.
                                         // Будем искать ближайшее пересечение
        Flag0:=(StartOutlineJ=-2);
        Flag1:=(FinishOutlineJ=-2);
        for j:=0 to Outline.Count-1 do begin
          aLineE:=Outline.Item[j];
          aLine:=aLineE as ILine;
          C0:=aLine.C0;
          C1:=aLine.C1;
          P0X:=C0.X;
          P0Y:=C0.Y;
          P1X:=C1.X;
          P1Y:=C1.Y;

          if LineIntersectLine0(
                 XX0, YY0,
                 XX1, YY1,
                 P0X, P0Y,
                 P1X, P1Y,
                 X,  Y) then begin
            D20:=sqr(XX0-X)+sqr(YY0-Y);
            D21:=sqr(XX1-X)+sqr(YY1-Y);
            if D20<D21 then begin
              if Flag0 and
                 (MinD20>D20) then begin
                MinD20:=D20;
                BestX0:=X;
                BestY0:=Y;
                theStartLineE:=aLineE;
                StartOutlineJ:=OutlineJ;
              end;
            end else begin
              if Flag1 and
                (MinD21>D21) then begin
                MinD21:=D21;
                BestX1:=X;
                BestY1:=Y;
                theFinishLineE:=aLineE;
                FinishOutlineJ:=OutlineJ;
              end;
            end;
          end; // if LineCanIntersectLine0(
        end; // for j:=0 to Outline.Count-1
      end; // if (StartOutlineJ=-2) or ...

      if (StartOutlineJ=-2) or
         (FinishOutlineJ=-2) then begin  // Не найдена хотя бы одна ближайшая точка.
                                         // Будем искать ближайший узел
        Flag0:=(StartOutlineJ=-2);
        Flag1:=(FinishOutlineJ=-2);
        for j:=0 to Outline.Count-1 do begin
          aLineE:=Outline.Item[j];
          aLine:=aLineE as ILine;
          C0:=aLine.C0;
          C1:=aLine.C1;
          P0X:=C0.X;
          P0Y:=C0.Y;
          P1X:=C1.X;
          P1Y:=C1.Y;

          if Flag0 then begin
            D20:=min(sqr(XX0-P0X)+sqr(YY0-P0Y), sqr(XX0-P1X)+sqr(YY0-P1Y));
            if (MinD20>D20) then begin
              MinD20:=D20;
              BestX0:=P0X;
              BestY0:=P0Y;
              theStartLineE:=aLineE;
              StartOutlineJ:=OutlineJ;
              Corner0:=True;
            end;
          end;

          if Flag1 then begin
            D21:=min(sqr(XX1-P0X)+sqr(YY1-P0Y), sqr(XX1-P1X)+sqr(YY1-P1Y));
            if (MinD21>D21) then begin
              MinD21:=D21;
              BestX1:=P0X;
              BestY1:=P0Y;
              theFinishLineE:=aLineE;
              FinishOutlineJ:=OutlineJ;
              Corner1:=True;
            end;
          end;
        end; // for j:=0 to Outline.Count-1
      end; // if (StartOutlineJ=-2) or ...

    end; // FindNearestLine

    function IsOuterPoint(XX0, YY0:double; OutlineJ:integer):boolean;
    var
      Outline:IDMCollection;
    begin // IsOuterPoint
      Result:=False;
      if OutlineJ=-2 then
        Exit
      else  
      if OutlineJ=-1 then
        Outline:=FOutline
      else
        Outline:=Get_InnerZoneOutline(OutlineJ);

      if OutlineJ=-1 then
        Result:=not OutlineContainsPoint(XX0, YY0, 0, Outline)
      else
        Result:=OutlineContainsPoint(XX0, YY0, 0, Outline)
    end; // IsOuterPoint

  var
    j, N:integer;
    L:double;
  begin  // FindStartFinish
// поиск ближайших к PrevNodeE  и NextNodeE отрезков контуров
    StartOutlineJ:=-2;
    FinishOutlineJ:=-2;
    MinD20:=sqrt(InfinitValue);
    MinD21:=MinD20;

    FindNearestLine(-1);
    N:=Get_InnerZoneOutlineCount;
    for j:=0 to N-1 do begin
      FindNearestLine(j);
    end;

    aStartNodeE:=NodeFactory.CreateElement(False);
    TMPPathNodeList.Add(pointer(aStartNodeE));
    aStartNodeE._AddRef;
    aStartNodeE.Ref:=Self as IDMElement;
    aStartNode:=aStartNodeE as ICoordNode;
    aStartNode.X:=XX0;
    aStartNode.Y:=YY0;
    aStartNode.Z:=ZZ0;

    aFinishNodeE:=NodeFactory.CreateElement(False);
    TMPPathNodeList.Add(pointer(aFinishNodeE));
    aFinishNodeE._AddRef;
    aFinishNodeE.Ref:=Self as IDMElement;
    aFinishNode:=aFinishNodeE as ICoordNode;
    aFinishNode.X:=XX1;
    aFinishNode.Y:=YY1;
    aFinishNode.Z:=ZZ1;

    if IsOuterPoint(XX0, YY0, StartOutlineJ) then begin
      FirstArcE:=ArcFactory.CreateElement(False);
      TMPPathArcList.Add(pointer(FirstArcE));
      FirstArcE._AddRef;
      FirstArcE.Ref:=Self as IDMElement;
      FirstArcL:=FirstArcE as ILine;
      FirstArcL.C0:=aStartNode;

      aStartNodeE:=NodeFactory.CreateElement(False);
      TMPPathNodeList.Add(pointer(aStartNodeE));
      aStartNodeE._AddRef;
      aStartNodeE.Ref:=Self as IDMElement;
      aStartNode:=aStartNodeE as ICoordNode;
      aStartNode.X:=BestX0;
      aStartNode.Y:=BestY0;
      aStartNode.Z:=ZZ0;

      L:=sqrt(sqr(BestX0-XX0)+sqr(BestY0-YY0));
      if Corner0 then begin
        XX0:=BestX0;
        YY0:=BestY0;
      end else
      if L<>0 then begin
        XX0:=XX0+(BestX0-XX0)/L*(L+10); //перемещаем точку старта внутрь контура
        YY0:=YY0+(BestY0-YY0)/L*(L+10);
      end;

      FirstArcL.C1:=aStartNode;
    end else begin
      theStartLineE:=nil;
      FirstArcE:=nil;
    end;

    if IsOuterPoint(XX1, YY1, FinishOutlineJ) then begin
      LastArcE:=ArcFactory.CreateElement(False);
      TMPPathArcList.Add(pointer(LastArcE));
      LastArcE._AddRef;
      LastArcE.Ref:=Self as IDMElement;
      LastArcL:=LastArcE as ILine;
      LastArcL.C1:=aFinishNode;

      aFinishNodeE:=NodeFactory.CreateElement(False);
      TMPPathNodeList.Add(pointer(aFinishNodeE));
      aFinishNodeE._AddRef;
      aFinishNodeE.Ref:=Self as IDMElement;
      aFinishNode:=aFinishNodeE as ICoordNode;
      aFinishNode.X:=BestX1;
      aFinishNode.Y:=BestY1;
      aFinishNode.Z:=ZZ1;

      L:=sqrt(sqr(BestX1-XX1)+sqr(BestY1-YY1));
      if Corner1 then begin
        XX1:=BestX1;
        YY1:=BestY1;
      end else
      if L<>0 then begin
        XX1:=XX1+(BestX1-XX1)/L*(L+10); //перемещаем точку финиша внутрь
        YY1:=YY1+(BestY1-YY1)/L*(L+10);
      end;

      LastArcL.C0:=aFinishNode;
    end else begin
      theFinishLineE:=nil;
      LastArcE:=nil;
    end;
  end;  // FindStartFinish


  function FindOutlineCrossections:boolean;
  var
    Lines:IDMCollection;

    procedure DoFindOutlineCrossections(InnerFlag:boolean; OutlineJ:integer);
    var
      m, k:integer;
      aLine:ILine;
      aC0, aC1:ICoordNode;
      X0, Y0, X1, Y1, PX, PY:double;
      OutlineCrossectionRec:POutlineCrossectionRec;
      Flag:boolean;
    begin  // DoFindOutlineCrossections
      for m:=0 to Lines.Count-1 do begin
        aLine:=Lines.Item[m] as ILine;
        aC0:=aLine.C0;
        aC1:=aLine.C1;
        X0:=aC0.X;
        Y0:=aC0.Y;
        X1:=aC1.X;
        Y1:=aC1.Y;
        if LineIntersectLine0(X0, Y0, X1, Y1,
                             XX0, YY0, XX1, YY1,
                             PX,  PY) then begin
          GetMem(OutlineCrossectionRec, SizeOf(TOutlineCrossectionRec));
          OutlineCrossectionList.Add(OutlineCrossectionRec);
          OutlineCrossectionRec.X:=PX;
          OutlineCrossectionRec.Y:=PY;
          OutlineCrossectionRec.XX:=XX0;
          OutlineCrossectionRec.YY:=YY0;
          OutlineCrossectionRec.Line:=pointer(aLine);
          OutlineCrossectionRec.InnerFlag:=InnerFlag;
          OutlineCrossectionRec.OutlineJ:=OutlineJ;
        end else begin
          Flag:=False;
          if ((XX0=X0) and (YY0=Y0)) or
             ((XX0=X1) and (YY0=Y1)) then begin
            Flag:=True;
            PX:=XX0;
            PY:=YY0;
          end;
          if ((XX1=X0) and (YY1=Y0)) or
             ((XX1=X1) and (YY1=Y1)) then begin
            Flag:=True;
            PX:=XX1;
            PY:=YY1;
          end;
          if Flag then begin
            k:=0;
            while k<OutlineCrossectionList.Count do begin
              OutlineCrossectionRec:=OutlineCrossectionList[k];
              if (OutlineCrossectionRec.X=PX) and
                 (OutlineCrossectionRec.Y=PY) then
                Break
              else
                inc(k);
            end;
            if k=OutlineCrossectionList.Count then begin
              GetMem(OutlineCrossectionRec, SizeOf(TOutlineCrossectionRec));
              OutlineCrossectionList.Add(OutlineCrossectionRec);
              OutlineCrossectionRec.X:=PX;
              OutlineCrossectionRec.Y:=PY;
              OutlineCrossectionRec.XX:=XX0;
              OutlineCrossectionRec.YY:=YY0;
              OutlineCrossectionRec.Line:=pointer(aLine);
              OutlineCrossectionRec.InnerFlag:=InnerFlag;
              OutlineCrossectionRec.OutlineJ:=OutlineJ;
            end;
          end;
        end;
      end;
    end; // DoFindOutlineCrossections

  var
    j, N:integer;
  begin // FindOutlineCrossections
    Lines:=FOutline;
    DoFindOutlineCrossections(False, -1);
    OuterFlag:=(OutlineCrossectionList.Count mod 2)=1;
    N:=Get_InnerZoneOutlineCount;
    for j:=0 to N-1 do begin
      Lines:=Get_InnerZoneOutline(j);
      DoFindOutlineCrossections(True, j);
    end;
    Result:=(OutlineCrossectionList.Count>0)
  end; // FindOutlineCrossections

  procedure BuildTMPPath;

    function ListSortCompare(P0, P1:pointer):integer;
    var
      Rec0, Rec1: POutlineCrossectionRec;
      X0, Y0, X1, Y1, D0, D1, XX, YY:double;
    begin // ListSortCompare
      try
      Rec0:=P0;
      Rec1:=P1;
      X0:=Rec0.X;
      Y0:=Rec0.Y;
      X1:=Rec1.X;
      Y1:=Rec1.Y;

      XX:=Rec0.XX;
      YY:=Rec0.YY;

      D0:=sqr(XX-X0)+sqr(YY-Y0);
      D1:=sqr(XX-X1)+sqr(YY-Y1);
      if D0<D1 then
        Result:=-1
      else
      if D0>D1 then
        Result:=+1
      else
        Result:=0
      except
        on E:Exception do
          DataModel.HandleError('Error in BuildTMPPath. Zone.Id='+IntToStr(ID));
      end
    end; // ListSortCompare

    function FindOutlineCrossections1(const Line1, Line2, Line3, Line4:ILine;
                                          aXX0, aYY0, X, Y:double;
                                          OutlineJ:integer):boolean;
    var
      Lines:IDMCollection;

      function DoFindOutlineCrossections1:boolean;
      var
        i:integer;
        aLine:ILine;
        C0, C1:ICoordNode;
        PX0, PY0, PX1, PY1, WX, WY:double;
      begin // DoFindOutlineCrossections1
        Result:=True;
        i:=0;
        while i<Lines.Count do begin
          aLine:=Lines.Item[i] as ILine;
          if (aLine<>Line1) and
             (aLine<>Line2) and
             (aLine<>Line3) and
             (aLine<>Line4) then begin
             C0:=aLine.C0;
             C1:=aLine.C1;
             PX0:=C0.X;
             PY0:=C0.Y;
             PX1:=C1.X;
             PY1:=C1.Y;
             if LineIntersectLine0(PX0, PY0, PX1, PY1,
                                  aXX0, aYY0, X, Y,
                                  WX, WY) then
               Exit;
          end;
          inc(i);
        end;
        Result:=False;
      end;  // DoFindOutlineCrossections1

    var
      j, N:integer;
    begin // FindOutlineCrossections1
      Result:=True;
                    // сначала проверяем контур, по которому обходим преграду
      if OutlineJ<>-1  then begin
        Lines:=Get_InnerZoneOutline(OutlineJ);
        if DoFindOutlineCrossections1 then
          Exit;
      end;

      Lines:=FOutline;
      if DoFindOutlineCrossections1 then
        Exit;

      N:=Get_InnerZoneOutlineCount;
      for j:=0 to N-1 do begin
        if j<>OutlineJ then begin
          Lines:=Get_InnerZoneOutline(j);
          if DoFindOutlineCrossections1 then
            Exit;
        end;
      end;
      Result:=False;
    end;  // FindOutlineCrossections1

  var
    aXX0, aYY0, aXX1, aYY1, DF:double;
    StartLine, FinishLine:ILine;
    OutlineJ:integer;

    procedure FindBestPath(const C:ICoordNode;
                           out L:double);
    var
      PrevLine, NextLine:ILine;
      k:integer;
      aC:ICoordNode;
    begin // FindBestPath
      NextLine:=StartLine;
      aC:=C;
      L:=0;
      repeat
        PrevLine:=NextLine;

        k:=0;
        while k<aC.Lines.Count do begin
          NextLine:=aC.Lines.Item[k] as ILine;
          if NextLine<>PrevLine then
            Break
          else
            inc(k)
        end;

        if PrevLine<>StartLine then
          L:=L+PrevLine.Length;

        aC:=NextLine.NextNodeTo(aC);
      until NextLine=FinishLine;
    end; // FindBestPath

    procedure FindBestNode(const C:ICoordNode; const OldPrevLine, OldNextLine:ILine;
                           out CC:ICoordNode; out BestPrevLine, BestNextLine:ILine;
                           out BestD, BestLL:double);
    var
      PrevLine, NextLine:ILine;
      X, Y:double;
      k:integer;
      aC:ICoordNode;
      aCos, minCos, D, LL:double;
    begin // FindBestNode
      CC:=nil;
      BestPrevLine:=nil;
      BestNextLine:=nil;
      minCos:=1;

      NextLine:=StartLine;
      aC:=C;
      BestLL:=0;
      LL:=0;
      repeat
        PrevLine:=NextLine;
        X:=aC.X;
        Y:=aC.Y;

        k:=0;
        while k<aC.Lines.Count do begin
          NextLine:=aC.Lines.Item[k] as ILine;
          if NextLine<>PrevLine then
            Break
          else
            inc(k)
        end;

        if not FindOutlineCrossections1(PrevLine, NextLine, OldPrevLine, OldNextLine,
                                        aXX0, aYY0, X, Y, OutlineJ) then begin
          if PrevLine<>StartLine then
            LL:=LL+PrevLine.Length;
          D:=sqrt(sqr(aXX0-X)+sqr(aYY0-Y));
          aCos:=abs((aXX0-X)*(aXX0-XX1)+(aYY0-Y)*(aYY0-YY1))/(D*DF);
          if minCos>=aCos then begin
            minCos:=aCos;
            BestD:=D;
            BestLL:=LL;
            CC:=aC;
            BestPrevLine:=PrevLine;
            BestNextLine:=NextLine;
          end;
        end;
        aC:=NextLine.NextNodeTo(aC);
      until NextLine=FinishLine;
    end;  // FindBestNode

  var
    j, k:integer;
    SRec, FRec, NRec: POutlineCrossectionRec;
    PathArcE, PathNodeE:IDMElement;
    PathNode0, PathNode1:ICoordNode;
    PathArcL:ILine;
    C0, C1, CC0, CC1:ICoordNode;
    D0, D1, L0, L1, LL0, LL1, X, Y:double;
    NextLine0, NextLine1, PrevLine0, PrevLine1, PrevLine, NextLine, FarLine,
    OldPrevLine, OldNextLine:ILine;
  begin // BuildTMPPath
    if FirstArcE<>nil then
      PathArc2.Add(FirstArcE);

    OutlineCrossectionList.Sort(@ListSortCompare);
    PathNode0:=aStartNode;
    OldPrevLine:=theStartLineE as ILine;
    OldNextLine:=nil;

    j:=0;
    while j<OutlineCrossectionList.Count-1 do begin
      aXX0:=PathNode0.X;
      aYY0:=PathNode0.Y;
      DF:=sqrt(sqr(aXX0-XX1)+sqr(aYY0-YY1));
               // ищем точку подхода к контуру обхода препятствия
      SRec:=OutlineCrossectionList[j];
      FRec:=OutlineCrossectionList[j+1];
      OutlineJ:=SRec.OutlineJ;
      if OutlineJ<>FRec.OutlineJ then begin
        inc(j);
        SRec:=OutlineCrossectionList[j];
        FRec:=OutlineCrossectionList[j+1];
        OutlineJ:=SRec.OutlineJ;
        if OutlineJ<>FRec.OutlineJ then begin
           DataModel.HandleError('Error in MakeRoundaboutPath. Zone.Id='+IntToStr(ID));
        end;
      end;

      StartLine:=ILine(SRec.Line);
      FinishLine:=ILine(FRec.Line);

      if j<OutlineCrossectionList.Count-2 then begin
        NRec:=OutlineCrossectionList[j+2];
        aXX1:=NRec.X;
        aYY1:=NRec.Y;
        FarLine:=ILine(NRec.Line);
      end else begin
        aXX1:=XX1;
        aYY1:=YY1;
        FarLine:=nil;
      end;

      C0:=StartLine.C0;
      C1:=StartLine.C1;
      FindBestPath(C0, L0);
      FindBestPath(C1, L1);
      if OutlineJ<>-1 then begin
        FindBestNode(C0, OldPrevLine, OldNextLine,
                     CC0, PrevLine0, NextLine0, D0, LL0); // ищем входы в контур обхода "слева"
        FindBestNode(C1, OldPrevLine, OldNextLine,
                     CC1, PrevLine1, NextLine1, D1, LL1); // и "справа"
        if (CC0<>nil) and
           (CC1<>nil) then begin
          if (D0+L0-LL0)<=(D1+L1-LL1) then begin
            PathNode1:=CC0;
            PrevLine:=PrevLine0;
            NextLine:=NextLine0;
          end else begin
            PathNode1:=CC1;
            PrevLine:=PrevLine1;
            NextLine:=NextLine1;
          end;
        end else
        if CC0<>nil then begin
          PathNode1:=CC0;
          PrevLine:=PrevLine0;
          NextLine:=NextLine0;
        end else
        if CC1<>nil then begin
          PathNode1:=CC1;
          PrevLine:=PrevLine1;
          NextLine:=NextLine1;
        end else begin
          PathNodeE:=NodeFactory.CreateElement(False);
          TMPPathNodeList.Add(pointer(PathNodeE));
          PathNodeE._AddRef;
          PathNodeE.Ref:=Self as IDMElement;
          PathNode1:=PathNodeE as ICoordNode;
          PathNode1.X:=SRec.X;
          PathNode1.Y:=SRec.Y;
          PathNode1.Z:=aStartNode.Z; //????? рельеф ?????

          PrevLine:=nil;
          NextLine:=nil;
        end;
      end else begin // if OutlineJ=-1
        if L0<L1 then begin // ищем входы в контур обхода "слева" или "справа"
          FindBestNode(C0, OldPrevLine, OldNextLine,
                       CC0, PrevLine, NextLine, D0, LL0);
        end else begin
          FindBestNode(C1, OldPrevLine, OldNextLine,
                       CC0, PrevLine, NextLine, D1, LL1);
        end;
        CC1:=nil;
        if CC0<>nil then
          PathNode1:=CC0
        else begin
          PathNodeE:=NodeFactory.CreateElement(False);
          TMPPathNodeList.Add(pointer(PathNodeE));
          PathNodeE._AddRef;
          PathNodeE.Ref:=Self as IDMElement;
          PathNode1:=PathNodeE as ICoordNode;
          PathNode1.X:=SRec.X;
          PathNode1.Y:=SRec.Y;
          PathNode1.Z:=aStartNode.Z; //????? рельеф ?????

          PrevLine:=nil;
          NextLine:=nil;
        end;
      end;

      PathArcE:=ArcFactory.CreateElement(False);
      TMPPathArcList.Add(pointer(PathArcE)); // линия, подходящая к контуру
      PathArcE._AddRef;
      PathArcE.Ref:=Self as IDMElement;
      PathArcL:=PathArcE as ILine;

      PathArcL.C0:=PathNode0;
      PathArcL.C1:=PathNode1;
      PathArc2.Add(PathArcE);
      PathNode0:=PathNode1;

      if (CC0=nil) and
         (CC1=nil) then begin // если срезать путь нельзя (все перекрыто),
                              // соединяем точку пересечения с контуром с узлом контура
        PathArcE:=ArcFactory.CreateElement(False);
        TMPPathArcList.Add(pointer(PathArcE)); // линия, соединяющая с контуром
        PathArcE._AddRef;
        PathArcE.Ref:=Self as IDMElement;
        PathArcL:=PathArcE as ILine;

        if L0<L1 then
          PathNode1:=C0
        else
          PathNode1:=C1;

        PathArcL.C0:=PathNode0;
        PathArcL.C1:=PathNode1;

        PrevLine:=PathArcL;
        NextLine:=nil;
      end;
                             // ищем точку выхода из контура обхода преграды и
                             // включаем в маршрут часть контура обхода преграды
      repeat
        X:=PathNode0.X;
        Y:=PathNode0.Y;

        if NextLine<>nil then begin
          if not FindOutlineCrossections1(PrevLine, NextLine, FarLine, nil,
                               aXX1, aYY1, X, Y,
                               OutlineJ) then
            Break;    // точка открыта - выходим из контура обхода

          PrevLine:=NextLine;

          if PrevLine=FinishLine then
            Break;
        end;

        PathArcE:=PrevLine as IDMElement;  // точка закрыта - продолжаем обход вдоль контура
        PathArc2.Add(PathArcE);
        PathNode1:=PrevLine.NextNodeTo(PathNode0);
        PathNode0:=PathNode1;

        k:=0;
        while k<PathNode0.Lines.Count do begin
          NextLine:=PathNode0.Lines.Item[k] as ILine;
          if NextLine<>PrevLine then
            Break
          else
            inc(k)
        end;

      until PrevLine=FinishLine;

      if PrevLine=FinishLine then begin // все точки обхода закрыты - выходим из точки пересечения с контуром
        PathNodeE:=NodeFactory.CreateElement(False);
        TMPPathNodeList.Add(pointer(PathNodeE));
        PathNodeE._AddRef;
        PathNodeE.Ref:=Self as IDMElement;
        PathNode1:=PathNodeE as ICoordNode;
        PathNode1.X:=FRec.X;
        PathNode1.Y:=FRec.Y;
        PathNode1.Z:=aStartNode.Z; //????? рельеф ?????

        PathArcE:=ArcFactory.CreateElement(False);
        TMPPathArcList.Add(pointer(PathArcE)); // линия, подходящая к точке пересечения
        PathArcE._AddRef;
        PathArcE.Ref:=Self as IDMElement;
        PathArcL:=PathArcE as ILine;

        PathArcL.C0:=PathNode0;
        PathArcL.C1:=PathNode1;
        PathArc2.Add(PathArcE);
        PathNode0:=PathNode1;

        OldPrevLine:=FinishLine;
        OldNextLine:=nil;
      end else begin
        OldPrevLine:=PrevLine;
        OldNextLine:=NextLine;
      end;

      inc(j, 2);
    end;  //  j<OutlineCrossectionList.Count+1

    PathArcE:=ArcFactory.CreateElement(False);
    TMPPathArcList.Add(pointer(PathArcE)); // линия, подходящая к конечной точке
    PathArcE._AddRef;
    PathArcE.Ref:=Self as IDMElement;
    PathArcL:=PathArcE as ILine;

    PathArcL.C0:=PathNode0;
    PathArcL.C1:=aFinishNode;
    PathArc2.Add(PathArcE);

    if LastArcE<>nil then
      PathArc2.Add(LastArcE);
  end;  // BuildTMPPath

begin  // TZone.MakeRoundaboutPath
  PathArc2:=Get_PathArcs as IDMCollection2;
  aStartNodeE:=theStartNodeE;
  aFinishNodeE:=theFinishNodeE;
  aStartNode:=aStartNodeE as ICoordNode;
  aFinishNode:=aFinishNodeE as ICoordNode;
  XX0:=aStartNode.X;
  YY0:=aStartNode.Y;
  ZZ0:=aStartNode.Z;
  XX1:=aFinishNode.X;
  YY1:=aFinishNode.Y;
  ZZ1:=aFinishNode.Z;

  try
  ClearRoundaboutPath;
  FindStartFinish;  // ищем ближайшие к PrevNodeE  и NextNodeE отрезки контуров
  if FindOutlineCrossections then
    BuildTMPPath;
  except
    on E:Exception do
      DataModel.HandleError('Error in MakeRoundaboutPath. Zone.Id='+IntToStr(ID));
  end;
end; // TZone.MakeRoundaboutPath

procedure TZone.ClearRoundaboutPath;
begin
  ClearTmpPathLists;
  (Get_PathArcs as IDMCollection2).Clear;
end;

function TZone.AcceptableTactic(const TacticU: IInterface): WordBool;
begin
  Result:=True
end;

procedure TZone.Set_SpatialElement(const Value: IDMElement);
var
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  ParentVolume, Volume:IVolume;
begin
  inherited;
  Exit;

  if not DataModel.IsChanging then Exit;
  if DataModel.IsLoading then Exit;
  if Parent=nil then Exit;

  DMDocument:=DataModel.Document as IDMDocument;
  DMOperationManager:=DMDocument as IDMOperationManager;

  ParentVolume:=Parent.SpatialElement as IVolume;
  Volume:=SpatialElement as IVolume;

  if (Volume<>nil) and
     (ParentVolume<>nil) and
    Volume.ContainsVolume(ParentVolume) then begin
    DMOperationManager.ChangeParent( nil, Self as IDMElement, Parent);
    Exit;
  end;

end;

function TZone.Get_Length: double;
begin
  Result:=0;
end;

procedure TZone.Set_Length(Value: double);
begin
end;

procedure TZone.Rotate(X0, Y0, cosA, sinA:double);
var
  j:integer;
  Element:IDMElement;
  Rotater:IRotater;
begin
  for j:=0 to FSafeguardElements.Count-1 do begin
    Element:=FSafeguardElements.Item[j];
    if (Element.SpatialElement=nil) and
       (Element.QueryInterface(IRotater, Rotater)=0) then
      Rotater.Rotate(X0, Y0, cosA, sinA)
  end;
end;

function TZone.Get_AlarmGroupArrivalTime: Double;
begin

end;

function TZone.Get_AlarmGroupArrivalTimeDev: Double;
begin

end;

function TZone.Get_AlarmGroupDelayTime: Double;
begin

end;

function TZone.Get_BlockGroupArrivalTime: Double;
begin

end;

function TZone.Get_BlockGroupArrivalTimeDev: Double;
begin

end;

function TZone.Get_BlockGroupStart: Integer;
begin

end;

function TZone.Get_DelayTimeDev: Double;
var
  FacilityModel:IFacilityModel;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModel.ZoneDelayTimeDispersionRatio
end;

function TZone.Get_DelayTimeFast: Double;
begin

end;

function TZone.Get_DelayTimeStealth: Double;
begin

end;

function TZone.Get_DetectionProbabilityFast: Double;
begin

end;

function TZone.Get_DetectionProbabilityStealth: Double;
begin

end;

function TZone.Get_EvidenceFast: WordBool;
begin

end;

function TZone.Get_EvidenceStealth: WordBool;
begin

end;

function TZone.Get_FailureProbabilityFast: Double;
begin

end;

function TZone.Get_FailureProbabilityStealth: Double;
begin

end;

function TZone.Get_PointsToTarget: WordBool;
begin

end;

procedure TZone.Set_PointsToTarget(Value: WordBool);
begin

end;

procedure TZone.SetCurrentDirection;
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  CurrentDirectPathFlag:boolean;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  case FacilityModelS.CurrentPathStage of
  wpsStealthEntry,
  wpsFastEntry:
    CurrentDirectPathFlag:=True;
  else
    CurrentDirectPathFlag:=False;
  end;
  FacilityModelS.CurrentDirectPathFlag:=CurrentDirectPathFlag;
end;

function TZone.Get_ObservationPeriod: double;
begin

end;

function TZone.Get_SingleDetectionProbabilityFast: Double;
begin

end;

function TZone.Get_SingleDetectionProbabilityStealth: Double;
begin

end;

function TZone.Get_TacticFastU: IUnknown;
begin
  Result:=nil
end;

function TZone.Get_TacticStealthU: IUnknown;
begin
  Result:=nil
end;

{ TZones }

function TZones.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsZone
  else
    Result:=rsZones
end;

class function TZones.GetElementClass: TDMElementClass;
begin
  Result:=TZone;
end;

class function TZones.GetElementGUID: TGUID;
begin
  Result:=IID_IZone;
end;

function  TZone.Get_HAreas:IDMCollection;
begin
  Result:=FHAreas
end;

function  TZone.Get_VAreas:IDMCollection;
begin
  Result:=FVAreas
end;


{ TVBoundaries }

function TVBoundaries.Get_Count: Integer;
var
  Zone:IZone;
begin
  Zone:=Get_Parent as IZone;
  Result:=Zone.VAreas.Count
end;

function TVBoundaries.Get_Item(Index: Integer): IDMElement;
var
  Zone:IZone;
begin
  Zone:=Get_Parent as IZone;
  Result:=Zone.VAreas.Item[Index].Ref;
  if Result=nil then
    Result:=Zone.VAreas.Item[Index]
end;

{ THBoundaries }

function THBoundaries.Get_Count: Integer;
var
  Zone:IZone;
begin
  Zone:=Get_Parent as IZone;
  Result:=Zone.HAreas.Count
end;

function THBoundaries.Get_Item(Index: Integer): IDMElement;
var
  Zone:IZone;
begin
  Zone:=Get_Parent as IZone;
  Result:=Zone.HAreas.Item[Index].Ref;
  if Result=nil then
    Result:=Zone.HAreas.Item[Index]
end;

procedure ClearTmpPathLists;
var
  j:integer;
  aPathArcE, aPathNodeE:IDMElement;
  OutlineCrossectionRec:POutlineCrossectionRec;
begin
  for j:=0 to TMPPathArcList.Count-1 do begin
    aPathArcE:=IDMElement(TMPPathArcList[j]);
    aPathArcE.Clear;
    aPathArcE._Release;
  end;
  TMPPathArcList.Clear;
  try
  for j:=0 to TMPPathNodeList.Count-1 do begin
    aPathNodeE:=IDMElement(TMPPathNodeList[j]);
    aPathNodeE.Clear;
    aPathNodeE._Release;
  end;
  except
    on E:Exception do
      aPathNodeE.DataModel.HandleError('Error in ClearTmpPathLists. ZoneU');
  end;
  TMPPathNodeList.Clear;

  for j:=0 to OutlineCrossectionList.Count-1 do begin
    OutlineCrossectionRec:=OutlineCrossectionList[j];
    FreeMem(OutlineCrossectionRec, SizeOf(TOutlineCrossectionRec));
  end;
  OutlineCrossectionList.Clear;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TZone.MakeFields;

  DependingSafeguardElementList:=TList.Create;
  theDependingSafeguardElementList:=TList.Create;
  BestOvercomeMethodList:=TList.Create;
  theBestOvercomeMethodList:=TList.Create;

  OutlineCrossectionList:=TList.Create;
  TMPPathArcList:=TList.Create;
  TMPPathNodeList:=TList.Create;

finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;

  DependingSafeguardElementList.Free;
  theDependingSafeguardElementList.Free;
  BestOvercomeMethodList.Free;
  theBestOvercomeMethodList.Free;

  OutlineCrossectionList.Free;         // поиск пересечений с препятствиями
  TMPPathArcList.Free;
  TMPPathNodeList.Free;
end.
