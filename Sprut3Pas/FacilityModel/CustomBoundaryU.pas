unit CustomBoundaryU;

interface
uses
  Classes, SysUtils, Variants, Math,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  FacilityElementU, SprutikLib_TLB;

const
  pfTransparent=1;
  pfNoFieldBarrier=2;
  pfFragile=4;
  pfAlwaysGoalDefinding=8;
  pfParamsCalculated=16; // Параметры для базового состояния системы рассчитаны
  pfParamsChanged=32; // Параметры изменяются хотя бы в одном возмущенном состоянии системы

type
  TCustomBoundary=class(TFacilityElement, IFieldBarrier, IPathElement,
                        IBoundary, IBoundary2, IDMElement2, IWayElement)
//  класс, представляющий границу между секторами зон
  private
    FDelayTimeFast_:double;
    FDelayTimeFastDispersion_:double;
    FDelayTimeStealth_:double;
    FBaseState:pointer;

    FParents:IDMCollection;

    FFlowIntencity:integer;

    FParamFlags:byte;

    FObservers:IDMCollection;

    FSoundResistanceSum0: Double;
    FSoundResistanceSum1: Double;
    FNearestSoundResistanceSum0: Double;
    FNearestSoundResistanceSum1: Double;
    FSoundResistance: Double;

    FBackRefs:IDMCollection;

    FAlarmGroupDelayTimeFromStart:double;
    FAlarmGroupDelayTimeFromStartDispersion:double;
    FAlarmGroupDelayTimeToTarget:double;
    FAlarmGroupDelayTimeToTargetDispersion:double;
    FAlarmGroup:IDMElement;
    FBlockGroup:IDMElement;
    FBattleVictoryProbability:double;
    FBattleTime:double;
    FBattleTimeDispersion:double;

    procedure UpdateObservers;  //определяет перечень средств охраны в поле которых попадает данный рубеж
    procedure ClearWarriorPaths;
    function MakePathFrom(PathKind: integer): IDMElement;
    procedure CalcExternalPathDelayTime(var T, TDisp, dT, dTDisp: double);
    procedure SetCurrentDirection;
    procedure CalcGuardDelayTime(out DelayTime, DelayTimeDispersion:double;
                                 out BestTacticE:IDMElement; aAddDelay:double);
    procedure CalcAdversaryDelayTime(out DelayTime, DelayTimeDispersion:double;
                                     out BestTacticE:IDMElement; aAddDelay:double);
    procedure CalcObservationPeriods(TryKill:boolean; T:double; out Changed:boolean);
    function ImplicitCalcNeeded:boolean;
    function CalcParamsNeeded:boolean;
    function CalcNoObsProbability:double;

    procedure CalcParams(aAddDelay:double);
  protected
    FBoundaryLayers:IDMCollection;
    FWarriorPaths:IDMCollection;


    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class procedure MakeFields1; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;

    function Get_FieldCount_: integer;  override; safecall;
    function Get_Field_(Index: integer): IDMField; override; safecall;
    function  Get_FieldValue_(Index: integer): OleVariant; override; safecall;
    procedure Set_FieldValue_(Index: integer; Value: OleVariant); override; safecall;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;

    procedure Update; override; safecall;

    procedure JoinSpatialElements(const aElement:IDMElement); override; safecall;
    function  Get_UserDefineded: WordBool; override; safecall;
    function  Get_IsEmpty: WordBool; override; safecall;
    procedure Clear; override;
    procedure ClearOp; override;

    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
    procedure AfterLoading1; override; safecall;
    procedure AfterLoading2; override; safecall;
    procedure AfterCopyFrom2; override; safecall;
    procedure _AddBackRef(const Value:IDMElement); override; safecall;
    procedure _RemoveBackRef(const Value:IDMElement); override; safecall;
    function Get_BackRefs:IDMCollection; safecall;

// IDMElement2

    function GetOperationName(ColIndex, Index: Integer): WideString; safecall;
    function GetShortCut(ColIndex, Index: Integer): WideString; safecall;
    function DoOperation(ColIndex, Index: Integer; var Param1: OleVariant; var Param2: OleVariant;
                         var Param3: OleVariant): WordBool; safecall;

    function  Get_MainParent: IDMElement; override; safecall;
    function Get_Parents:IDMCollection; override; safecall;
    procedure Set_Ref(const Value: IDMElement); override; safecall;
    procedure Set_Selected(Value: WordBool); override; safecall;
    procedure CalcVulnerability; override; safecall;
    function  Get_FastPath: IWarriorPath; safecall;
    function  Get_StealthPath: IWarriorPath; safecall;
    function  Get_OptimalPath: IWarriorPath; safecall;
    function  Get_BoundaryLayers:IDMCollection; safecall;
    function  Get_FlowIntencity:integer; safecall;
    function  Get_Observers:IDMCollection; safecall;
    function  Get_WarriorPaths:IDMCollection; safecall;

    function  Get_NeighbourDist0:double; virtual; safecall;
    function  Get_NeighbourDist1:double; virtual; safecall;
    procedure ClearCash(ClearElements:WordBool); safecall;

    procedure CalculateFieldValues; override;

    function GetPassVelocity: double; virtual; safecall;
    function GetGap: double; virtual; safecall;

    function GetPassDistance:double;

//IPatElement
    procedure CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                            out BestTacticE:IDMElement;
                            aAddDelay:double); override;
    procedure CalcNoDetectionProbability(
                           out NoDetP, NoFailureP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                           out BestTacticE:IDMElement;
                                aAddDelay:double); override;

    procedure CalcPathSoundResistance(var PathSoundResistance,
                          FuncSoundResistance: Double); override; safecall;
    procedure CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                          aAddDelay:double); override; safecall;
    function Get_InstallPrice:integer;
    function Get_MaintenancePrice:integer;

    function Get_DelayTime: double; override; safecall;

    function Get_Zone0:IDMElement; virtual; safecall;
    procedure Set_Zone0(const Value:IDMElement); virtual; safecall;
    function Get_Zone1:IDMElement; virtual; safecall;
    procedure Set_Zone1(const Value:IDMElement); virtual; safecall;
    procedure ResetSoundResistance; safecall;

    function  Get_SoundResistanceSum0: Double; safecall;
    procedure Set_SoundResistanceSum0(Value: Double); safecall;
    function  Get_SoundResistanceSum1: Double; safecall;
    procedure Set_SoundResistanceSum1(Value: Double); safecall;
    function  Get_NearestSoundResistanceSum0: Double; safecall;
    procedure Set_NearestSoundResistanceSum0(Value: Double); safecall;
    function  Get_NearestSoundResistanceSum1: Double; safecall;
    procedure Set_NearestSoundResistanceSum1(Value: Double); safecall;

    function  Get_VisualControl: Integer; override; safecall;
    function MakeTemporyPath:IDMElement; safecall;
    function  Get_PatrolPeriod:double; override; safecall;

    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; override; safecall;
    procedure CalcFalseAlarmPeriod; override; safecall;
    procedure BeforeDeletion; override; safecall;


    procedure MakeBackPathElementStates(const SubStateE:IDMElement); override; safecall;

    procedure Initialize; override;
    procedure  _Destroy; override;

    procedure CalcExternalDelayTime(out dT, dTDisp: double; out BestTacticE:IDMElement); virtual; safecall;
    procedure BuildReport(ReportLevel: Integer; TabCount: Integer; Mode: Integer;
                          const Report: IDMText); override; safecall;
    function Get_ReportModeCount:integer; override; safecall;
    function Get_ReportModeName(Index:integer):WideString; override; safecall;

    procedure Reset(const BaseStateE:IDMElement); safecall;
    function GetDelayTimeFromStart(const WarriorGroupE: IDMElement; out DelayTime: Double;
                                   out DelayTimeDispersion: Double): WordBool; override; safecall;
    function GetDelayTimeToTarget(const WarriorGroupE: IDMElement; out DelayTime: Double;
                                  out DelayTimeDispersion: Double): WordBool; override;  safecall;
    procedure CalcGuardTactic; safecall;
    function Get_GuardDelayTimeFromStart:double; safecall;
    function Get_GuardDelayTimeFromStartDispersion:double; safecall;
    function Get_GuardDelayTimeToTarget:double; safecall;
    function Get_GuardDelayTimeToTargetDispersion:double; safecall;
    function Get_AlarmGroup:IDMElement; safecall;
    function  Get_BlockGroup:IDMElement; safecall;
    procedure Set_BlockGroup(const Value:IDMElement); safecall;
    function Get_BattleVictoryProbability:double; safecall;
    function Get_BattleTime:double; safecall;
    function Get_BattleTimeDispersion:double; safecall;

// IFieldBarrier
    procedure CalcParamFlags; safecall;      //определяет является ли слой прозрачным
    function Get_IsFragile:WordBool; safecall;
    function Get_IsTransparent:WordBool; safecall;
    function Get_HasNoFieldBarrier:WordBool; safecall;
    function CalcAttenuation(const PhysicalField:IDMElement):double; safecall;
    function Get_SoundResistance:double; safecall;

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

implementation

uses
  FacilityModelConstU,
  OutstripU, Geometry;

var
  FFields:IDMCollection;
  OldDependingSafeguardElements2, DependingSafeguardElements2:IDMCollection2;
  OldDependingSafeguardElements, DependingSafeguardElements:IDMCollection;

  GDelayTimeToTarget_BestArcE, GDelayTimeFromStart_BestArcE,
  GRationalProbabilityToTarget_BestArcE, GBackPathRationalProbability_BestArcE,
  GNoDetectionProbabilityFromStart_BestArcE:IDMElement;

{ TCustomBoundary }

procedure TCustomBoundary.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  
  FParamFlags:=pfTransparent;

  FBoundaryLayers:=DataModel.CreateCollection(_BoundaryLayer, SelfE);
  FWarriorPaths:=DataModel.CreateCollection(_WarriorPath, SelfE);
  FStates:=DataModel.CreateCollection(_BoundaryState, SelfE);
  FObservers:=DataModel.CreateCollection(_Observer, SelfE);

  FParents:=DataModel.CreateCollection(-1, SelfE);

  FBackRefs:=DataModel.CreateCollection(-1, SelfE);

  FSoundResistanceSum0:=InfinitValue;
  FSoundResistanceSum1:=InfinitValue;

end;

procedure TCustomBoundary._Destroy;
begin
  inherited;
  FBoundaryLayers:=nil;
  FWarriorPaths:=nil;

  FObservers:=nil;

  FBackRefs:=nil;

  FAlarmGroup:=nil;
  FBlockGroup:=nil;
end;

function TCustomBoundary.Get_Zone0: IDMElement;
var
  Area:IArea;
  FacilityModelS:IFMState;
begin
  Area:=SpatialElement as IArea;
  if Area=nil then begin
    FacilityModelS:=DataModel as IFMState;
    Result:=FacilityModelS.CurrentZone0U as IDMElement;
  end else
  if Area.Volume0<>nil then
    Result:=(Area.Volume0 as IDMElement).Ref
  else
    Result:=nil
end;

function TCustomBoundary.Get_Zone1: IDMElement;
var
  Area:IArea;
  FacilityModelS:IFMState;
begin
  Area:=SpatialElement as IArea;
  if Area=nil then begin
    FacilityModelS:=DataModel as IFMState;
    Result:=FacilityModelS.CurrentZone1U as IDMElement;
  end else
  if Area.Volume1<>nil then
    Result:=(Area.Volume1 as IDMElement).Ref
  else
    Result:=nil
end;

function TCustomBoundary.GetPassVelocity:double;
begin
  Result:=500;
end;

function TCustomBoundary.GetPassDistance:double;
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  theLine:ILine;
  DMDocument:IDMDocument;
  OldState:integer;
  theLineE:IDMElement;
  SumL:double;
  j:integer;
  BoundaryLayer:IBoundaryLayer;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=DataModel as IFMState;
  theLine:=FacilityModelS.CurrentLineU as ILine;
  if theLine=nil then begin
    DMDocument:=DataModel.Document as IDMDocument;
    OldState:=DMDocument.State;
    DMDocument.State:=DMDocument.State or dmfCommiting;
    try
      theLineE:=MakeTemporyPath as IDMElement;
      FacilityModelS.CurrentLineU:=theLineE;
      theLine:=theLineE as ILine;
    finally
      DMDocument.State:=OldState;
    end;
  end;

  if theLine<>nil then begin
    SumL:=0;
    for j:=1 to FBoundaryLayers.Count-1 do begin // начиная с 1
      BoundaryLayer:=FBoundaryLayers.Item[j] as IBoundaryLayer;
      SumL:=SumL+BoundaryLayer.DistanceFromPrev;
    end;
    Result:=theLine.Length-SumL;
    if Result<0 then
      Result:=0;
  end else
    Result:=0;
end;

procedure TCustomBoundary.SetCurrentDirection;
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  Zone0E, Zone1E:IDMElement;
  Zone0,  Zone1:IZone;
  NodeDirection:integer;
  CurrentDirectPathFlag:boolean;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  FacilityModelS.CurrentBoundary0U:=Self as IUnknown;
  FacilityModelS.CurrentBoundary1U:=Self as IUnknown;
  Zone0E:=Get_Zone0 as IDMElement;
  Zone1E:=Get_Zone1 as IDMElement;
  Zone0:=Zone0E as IZone;
  Zone1:=Zone1E as IZone;
  FacilityModelS.CurrentZone0U:=Zone0E;
  FacilityModelS.CurrentZone1U:=Zone1E;
  NodeDirection:=FacilityModelS.CurrentNodeDirection;

  if Zone0=nil then begin
    CurrentDirectPathFlag:=(NodeDirection=pdFrom0To1)
  end else
  if Zone1=nil then begin
    CurrentDirectPathFlag:=(NodeDirection=pdFrom1To0)
  end else
  if Zone0.Category<Zone1.Category then begin
    CurrentDirectPathFlag:=(NodeDirection=pdFrom1To0)
  end else
  if Zone0.Category>Zone1.Category then begin
    CurrentDirectPathFlag:=(NodeDirection=pdFrom0To1)
  end else //if Zone0.Category=Zone1.Category
    case FacilityModelS.CurrentPathStage of
    wpsStealthEntry,
    wpsFastEntry:
       CurrentDirectPathFlag:=(NodeDirection=pdFrom1To0);
    else
       CurrentDirectPathFlag:=(NodeDirection=pdFrom0To1);
    end;
  FacilityModelS.CurrentDirectPathFlag:=CurrentDirectPathFlag;
end;

procedure TCustomBoundary.CalcGuardDelayTime(out DelayTime, DelayTimeDispersion:double;
                                              out BestTacticE:IDMElement; aAddDelay:double);
var
  m:integer;
  aDelayTime, aDelayTimeDispersion:double;
  aBestTacticE:IDMElement;
  FacilityModelS:IFMState;
  FacilityStateE:IDMElement;
  BoundaryLayer:IBoundaryLayer;
  PassVelocity, Gap, AddDelay:double;
begin
  SetCurrentDirection;

  FacilityModelS:=DataModel as IFMState;

  PassVelocity:=GetPassVelocity;
  Gap:=GetGap;

  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  if FDelayTimeFast_=-1 then begin
    DelayTime:=0;
    DelayTimeDispersion:=0;
    for m:=0 to FBoundaryLayers.Count-1 do begin
      BoundaryLayer:=FBoundaryLayers.Item[m] as IBoundaryLayer;

      AddDelay:=aAddDelay;
      if m=0 then
        AddDelay:=AddDelay+Gap/PassVelocity;
      if m=FBoundaryLayers.Count-1 then
        AddDelay:=AddDelay+Gap/PassVelocity;

      BoundaryLayer.CalcGuardDelayTime(aDelayTime, aDelayTimeDispersion,
                                       aBestTacticE,  AddDelay);

      DelayTime:=DelayTime+aDelayTime;
      DelayTimeDispersion:=DelayTimeDispersion+aDelayTimeDispersion;
    end;
    FDelayTimeFast_:=DelayTime;
    FDelayTimeFastDispersion_:=DelayTimeDispersion;
  end else begin
    DelayTime:=FDelayTimeFast_;
    DelayTimeDispersion:=FDelayTimeFastDispersion_;
  end;

  if DelayTime>InfinitValue/1000 then
    DelayTime:=InfinitValue/1000;
end;

procedure TCustomBoundary.CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                                  out BestTacticE:IDMElement;
                                  aAddDelay:double);
var
  WarriorGroupE, aBestTactic1E:IDMElement;
  FacilityModelS:IFMState;
  dT, dTDisp:double;
begin
  inherited;
  if Ref=nil then Exit;
  if FBoundaryLayers.Count=0 then Exit;

  FacilityModelS:=DataModel as IFMState;

  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  if WarriorGroupE.ClassID=_GuardGroup then
    CalcGuardDelayTime(DelayTime, DelayTimeDispersion,
                       BestTacticE, aAddDelay)
  else begin
    if ImplicitCalcNeeded then
      CalcAdversaryDelayTime(DelayTime, DelayTimeDispersion,
                         BestTacticE, aAddDelay)
    else  begin
      if CalcParamsNeeded then
        CalcParams(aAddDelay); // рассчитываем все параметры для основного состояния здесь

      DelayTime:=FDelayTimeFast_;
      DelayTimeDispersion:=FDelayTimeFastDispersion_;

      CalcExternalDelayTime(dT, dTDisp, aBestTactic1E); // aBestTactic1E - не используется

      DelayTime:=DelayTime+dT;
      DelayTimeDispersion:=DelayTimeDispersion+dTDisp;
      BestTacticE:=nil;
    end;
  end;
end;


function TCustomBoundary.Get_InstallPrice: integer;
{
var
  j:integer;
  BoundaryLayerC:ICustomSafeguardElement;
}
//           метод, возвращающий стоимость оборудования
//           данной границы зоны
begin
  Result:=0;
{  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayerC:=BoundaryLayers.Item[j] as ICustomSafeguardElement;
    Result:=Result+BoundaryLayerC.Get_InstallPrice;
  end;
}  
end;

function TCustomBoundary.Get_MaintenancePrice: integer;
{var
  j:integer;
  BoundaryLayerC:ICustomSafeguardElement;
}  
//           метод, возвращающий стоимость оборудования
//           данной границы зоны
begin
  Result:=0;
{  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayerC:=BoundaryLayers.Item[j] as ICustomSafeguardElement;
    Result:=Result+BoundaryLayerC.Get_MaintenancePrice;
  end;
}
end;

function TCustomBoundary.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

function TCustomBoundary.Get_CollectionCount: integer;
var
  BoundaryKind:IBoundaryKind;
  BoundaryLayer:IBoundaryLayer;
begin
  if (DataModel=nil) or
      DataModel.IsLoading or
      DataModel.IsCopying or
      DataModel.InUndoRedo or
      DataModel.IsExecuting then begin
    Result:=ord(High(TBoundaryCategory));
    inc(Result)
  end else
  if (DataModel as IFacilityModel).ShowSingleLayer or
     (Ref=nil) or
     (Ref.QueryInterface(IBoundaryKind, BoundaryKind)<>0) or
     (FBoundaryLayers.Count<>1) then begin
    Result:=ord(High(TBoundaryCategory));
    if FWarriorPaths.Count>0 then
      inc(Result);
  end else begin
    Result:=3;
    BoundaryLayer:=FBoundaryLayers.Item[0] as IBoundaryLayer;
    if BoundaryLayer.SubBoundaries.Count>0 then
      inc(Result);
    if FWarriorPaths.Count>0 then
      inc(Result);
  end;
end;

procedure TCustomBoundary.Set_Ref(const Value: IDMElement);
var
  BoundaryLayerE, BoundaryLayerTypeE:IDMElement;
  BoundaryKind:IBoundaryKind;
  DataModelE:IDMElement;
  FacilityModel:IFacilityModel;
  DMOperationManager:IDMOperationManager;
  Painter:IUnknown;
  ElementU:IUnknown;
  aDocument:IDMDocument;
  OldState:integer;
begin
  if Ref=Value then Exit;

  if (DataModel<>nil) and
     (not DataModel.IsLoading) and
     (not DataModel.IsCopying) then begin
    Painter:=(DataModel.Document as ISMDocument).PainterU;
    Draw(Painter, -1)
  end;

  inherited Set_Ref(Value);

  if Value=nil then Exit;
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if not DataModel.IsChanging then Exit;
  if ((DataModel.Document as IDMDocument).State and dmfRollbacking)<>0 then Exit;
  if Ref.QueryInterface(IBoundaryKind, BoundaryKind)<>0 then Exit;

  DataModelE:=DataModel as IDMElement;
  FacilityModel:=DataModel as IFacilityModel;
  aDocument:=DataModel.Document as IDMDocument;
  DMOperationManager:=aDocument as IDMOperationManager;
  OldState:=aDocument.State;
//  FBoundaryLayers.DisconnectFrom(Self as IDMElement);
  while FBoundaryLayers.Count>0 do begin
    BoundaryLayerE:=FBoundaryLayers.Item[0];
    DMOperationManager.DeleteElement( Self as IDMElement, FBoundaryLayers,
                            ltOneToMany, BoundaryLayerE);
  end;

  if BoundaryKind.BoundaryLayerTypes.Count=0 then Exit;

//  aDocument.State:=aDocument.State or dmfCommiting;
  try

  DMOperationManager.AddElement( Self as IDMElement,
                      FacilityModel.BoundaryLayers, '', ltOneToMany, ElementU, True);
  BoundaryLayerE:=ElementU as IDMElement;
  BoundaryLayerTypeE:=BoundaryKind.BoundaryLayerTypes.Item[0];

  DMOperationManager.ChangeRef( nil,
                        '', BoundaryLayerTypeE, BoundaryLayerE);

  finally
    aDocument.State:=OldState;
  end;

  if Selected then
    Draw(Painter, 1)
  else
    Draw(Painter, 0)
end;

procedure TCustomBoundary.Update;
begin
  if not DataModel.IsLoading then
    CalcParamFlags;
end;


function TCustomBoundary.CalcAttenuation(const PhysicalField:IDMElement):double;
var
  j:integer;
  Attenuation:double;
  BoundaryLayer:IFieldBarrier;
begin
  Result:=0;
  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayer:=FBoundaryLayers.Item[j] as IFieldBarrier;
    Attenuation:=BoundaryLayer.CalcAttenuation(PhysicalField);
    Result:=Result+Attenuation;
  end;
end;

function TCustomBoundary.GetFieldValue(Code: integer): OleVariant;
var
  BoundaryLayerE:IDMElement;
begin
  case Code of
  ord(bopUserDefinedDelayTime):
    Result:=FUserDefinedDelayTime;
  ord(bopDelayTime):
      Result:=FDelayTime;
  ord(bopUserDefinedDetectionProbability):
    Result:=FUserDefinedDetectionProbability;
  ord(bopDetectionProbability):
    Result:=FDetectionProbability;
  ord(bopFlowIntencity):
    Result:=FFlowIntencity;
  ord(bopFalseAlarmPeriod):
    Result:=Get_FalseAlarmPeriod;
  ord(blpHeight0),
  ord(blpHeight1),
  ord(blpDistanceFromPrev),
  ord(cnstShowSymbol),
  ord(cnstSymbolScaleFactor),
  ord(cnstImageRotated),
  ord(cnstImageMirrored):
    begin
      BoundaryLayerE:=FBoundaryLayers.Item[0];
      Result:=BoundaryLayerE.GetFieldValue(Code);
    end;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TCustomBoundary.SetFieldValue(Code: integer;
  Value: OleVariant);

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
       (Document.Server as IDataModelServer).RefreshElement(Self as IUnknown);
     end;
  end;
var
  BoundaryLayerE:IDMElement;
begin
  case Code of
  ord(bopUserDefinedDelayTime):
    begin
      FUserDefinedDelayTime:=Value;
      UpdateUserDefinedElements;
    end;
  ord(bopDelayTime):
    FDelayTime:=Value;
  ord(bopUserDefinedDetectionProbability):
    begin
      FUserDefinedDetectionProbability:=Value;
      UpdateUserDefinedElements;
    end;
  ord(bopDetectionProbability):
    FDetectionProbability:=Value;
  ord(bopFlowIntencity):
    FFlowIntencity:=Value;
  ord(bopFalseAlarmPeriod):
    Set_FalseAlarmPeriod(Value);
  ord(blpHeight0),
  ord(blpHeight1),
  ord(blpDistanceFromPrev),
  ord(blpUserDefinedDelayTime),
  ord(blpDelayTime),
  ord(blpUserDefinedDetectionProbability),
  ord(blpDetectionProbability),
  ord(cnstShowSymbol),
  ord(cnstSymbolScaleFactor),
  ord(cnstImageRotated),
  ord(cnstImageMirrored):
    begin
      BoundaryLayerE:=FBoundaryLayers.Item[0];
      BoundaryLayerE.SetFieldValue(Code, Value);
    end;
  else
    inherited
  end;
end;

class function TCustomBoundary.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TCustomBoundary.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsUserDefinedDelayTime, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(bopUserDefinedDelayTime), 0, pkUserDefined);
  AddField(rsDelayTime, '%0.1f', '', '',
                 fvtFloat,   0, 0, InfinitValue,
                 ord(bopDelayTime), 2, pkUserDefined);
  AddField(rsUserDefinedDetectionProbability, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(bopUserDefinedDetectionProbability), 0, pkUserDefined);
  AddField(rsDetectionProbability, '%0.4g', '', '',
                  fvtFloat, 0, 0, 1,
                 ord(bopDetectionProbability), 2, pkUserDefined);
  S:='| '+rsLow+
     ' | '+rsMedium+
     ' | '+rsHigh;
  AddField(rsFlowIntencity, S, '', '',
                 fvtChoice, 1, 0, 0,
                 ord(bopFlowIntencity), 0, pkInput);
end;

function TCustomBoundary.Get_Collection(Index: Integer): IDMCollection;
var
  BoundaryLayerE:IDMElement;
  BoundaryKind:IBoundaryKind;
  BoundaryLayer:IBoundaryLayer;
begin
  if (DataModel=nil) or
      DataModel.IsLoading or
      DataModel.IsCopying or
      DataModel.InUndoRedo or
      DataModel.IsExecuting or
      (DataModel as IFacilityModel).ShowSingleLayer or
      (Ref=nil) or
      (Ref.QueryInterface(IBoundaryKind, BoundaryKind)<>0) or
      (FBoundaryLayers.Count<>1) then begin
    case TBoundaryCategory(Index) of
    zbcStates:
      Result:=FStates;
    zbcBoundaryLayers:
      Result:=FBoundaryLayers;
    zbcObservers:
      Result:=FObservers;
    zbcWarriorPaths:
      Result:=FWarriorPaths;
    else
      Result:=inherited Get_Collection(Index)
    end
  end else begin
    BoundaryLayerE:=FBoundaryLayers.Item[0];
    BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
    case Index of
    0:Result:=FStates;
    1:Result:=BoundaryLayerE.Collection[Index];
    2:Result:=FObservers;
    3:begin
        if BoundaryLayer.SubBoundaries.Count>0 then
          Result:=BoundaryLayer.SubBoundaries
        else
          Result:=FWarriorPaths;
      end;
    4:Result:=FWarriorPaths;
    else
      Result:=inherited Get_Collection(Index)
    end
  end;
end;

procedure TCustomBoundary.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  BoundaryLayerE:IDMElement;
  BoundaryKind:IBoundaryKind;
  BoundaryLayer:IBoundaryLayer;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.InUndoRedo or
     DataModel.IsExecuting or
     (DataModel as IFacilityModel).ShowSingleLayer or
     (Ref=nil) or
     (Ref.QueryInterface(IBoundaryKind, BoundaryKind)<>0) or
     (FBoundaryLayers.Count<>1) then begin
    case TBoundaryCategory(Index) of
    zbcStates:
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
    zbcBoundaryLayers:
      begin
        aCollectionName:=rsBoundaryLayers2;
        if Ref<>nil then
          aRefSource:=(Ref as IBoundaryKind).BoundaryLayerTypes
        else
          aRefSource:=nil;
        aClassCollections:=nil;
        aOperations:=leoAdd or leoDelete or leoMove or leoOperation1;
        aLinkType:=ltOneToMany;
      end;
    zbcObservers:
      begin
        aCollectionName:='Наблюдение';
        aRefSource:=nil;
        aClassCollections:=nil;
        aOperations:=0;
        aLinkType:=ltOneToMany;
      end;
    zbcWarriorPaths:
      begin
        aCollectionName:=rsBoundaryWarriorPaths;
        aRefSource:=nil;
        aClassCollections:=nil;
        aOperations:=leoRename  or leoDelete or leoMove or leoDontCopy;
        aLinkType:=ltOneToMany;
      end;
    else
      inherited;
    end;
  end else begin
    BoundaryLayerE:=FBoundaryLayers.Item[0];
    BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
    case Index of
    0:begin
         aCollectionName:=rsElementStates;
        if DataModel<>nil then
          aRefSource:=(DataModel as IFacilityModel).FacilitySubStates
        else
          aRefSource:=nil;
        aClassCollections:=nil;
        aOperations:=leoAdd or leoSelectRef;
        aLinkType:=ltOneToMany;
    end;
    1:begin
        BoundaryLayerE:=FBoundaryLayers.Item[0];
        BoundaryLayerE.GetCollectionProperties(Index,
               aCollectionName, aRefSource,
               aClassCollections, aOperations, aLinkType);
      end;
    2:begin
        aCollectionName:='Наблюдение';
        aRefSource:=nil;
        aClassCollections:=nil;
        aOperations:=0;
        aLinkType:=ltOneToMany;
      end;
    3:begin
        if BoundaryLayer.SubBoundaries.Count>0 then
          BoundaryLayerE.GetCollectionProperties(Index,
                 aCollectionName, aRefSource,
                 aClassCollections, aOperations, aLinkType)
        else begin
          aCollectionName:=rsBoundaryWarriorPaths;
          aRefSource:=nil;
          aClassCollections:=nil;
          aOperations:=leoRename or leoDelete or leoMove or leoDontCopy;
          aLinkType:=ltOneToMany;
        end;
      end;
    4:begin
        aCollectionName:=rsBoundaryWarriorPaths;
        aRefSource:=nil;
        aClassCollections:=nil;
        aOperations:=leoRename or leoDelete or leoMove or leoDontCopy;
        aLinkType:=ltOneToMany;
      end;
    else
      inherited;
    end;
  end;
end;

procedure TCustomBoundary.CalculateFieldValues;
begin
  inherited
end;

function TCustomBoundary.Get_MainParent: IDMElement;
var
  Area:IArea;
begin
  Result:=nil;
  if SpatialElement=nil then Exit;
  Area:=SpatialElement as IArea;
  if Area.Volume0<>nil then
    Result:=(Area.Volume0 as IDMElement).Ref
  else
  if Area.Volume1<>nil then
    Result:=(Area.Volume1 as IDMElement).Ref
  else
    Result:=nil  
end;

function TCustomBoundary.MakeTemporyPath: IDMElement;
var
  BottomLine, ResultLine:ILine;
  BottomLineE:IDMElement;
  ProjL, cosX, cosY, X, Y, Z:double;
  m:integer;
  WP0X, WP0Y, WP0Z, WP1X, WP1Y, WP1Z:double;
  SpatialModel:ISpatialModel;
  Area, aArea:IArea;
  C0, C1:ICoordNode;
  C0E, C1E:IDMElement;

  procedure Set_CenterAt(const C0, C1: ICoordNode;
                      X, Y, Z, aLength, cosX, cosY,
                      WX0, WY0, WZ0, WX1, WY1, WZ1:double);
    procedure ChangeCoords;
    var Q:double;
    begin
      Q:=C0.X; C0.X:=C1.X; C1.X:=Q;
      Q:=C0.Y; C0.Y:=C1.Y; C1.Y:=Q;
      Q:=C0.Z; C0.Z:=C1.Z; C1.Z:=Q;
    end;
  begin
    C0.X:=X-0.5*aLength*cosY;
    C0.Y:=Y+0.5*aLength*cosX;
    C0.Z:=Z;
    C1.X:=X+0.5*aLength*cosY;
    C1.Y:=Y-0.5*aLength*cosX;
    C1.Z:=Z;

    if WZ0=-InfinitValue then begin
      if WZ1=-InfinitValue then
        Exit
      else
      if C1.DistanceFrom(WX1, WY1, WZ1)>C0.DistanceFrom(WX1, WY1, WZ1) then
        ChangeCoords;
    end else
    if C0.DistanceFrom(WX0, WY0, WZ0)>C1.DistanceFrom(WX0, WY0, WZ0) then
      ChangeCoords;
  end;

var
  Document:IDMDocument;
  OldState:integer;
begin
  Result:=nil;

  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfChanging;
  try

  SpatialModel:=DataModel as ISpatialModel;
  Result:=(SpatialModel.Lines as IDMCollection2).CreateElement(False);
  ResultLine:=Result as ILine;
  Result.Ref:=Self;

  C0E:=(SpatialModel.CoordNodes as IDMCollection2).CreateElement(False);
  C0:=C0E as ICoordNode;
  C0E.Ref:=Get_Zone0 as IDMElement;
  ResultLine.C0:=C0;

  C1E:=(SpatialModel.CoordNodes as IDMCollection2).CreateElement(False);
  C1:=C1E as ICoordNode;
  C1E.Ref:=Get_Zone1 as IDMElement;
  ResultLine.C1:=C1;

  if SpatialElement=nil then Exit;
  if SpatialElement.QueryInterface(IArea, Area)<>0 then Exit;
  
  if Area.IsVertical then begin
    if  Area.BottomLines.Count>0 then begin
       BottomLineE:=Area.BottomLines.Item[0];
       BottomLine:=BottomLineE as ILine;
       X:=BottomLine.C0.X+(BottomLine.C1.X-BottomLine.C0.X)*0.5;
       Y:=BottomLine.C0.Y+(BottomLine.C1.Y-BottomLine.C0.Y)*0.5;
       Z:=BottomLine.C0.Z+(BottomLine.C1.Z-BottomLine.C0.Z)*0.5;
       Z:=Z+ShoulderWidth;

       WP0Z:=-InfinitValue;
       aArea:=nil;
       if Area.Volume0<>nil then
       for m:=0 to Area.Volume0.Areas.Count-1 do begin
         aArea:=Area.Volume0.Areas.Item[m] as IArea;
         if (aArea<>Area) and
            ((aArea as IPolyline).Lines.IndexOf(BottomLineE)<>-1) then begin
           aArea.GetCentralPoint(WP0X, WP0Y, WP0Z);
           Break;
         end;
       end;
       if aArea=nil then begin
         WP0X:=X;
         WP0Y:=Y;
         WP0Z:=Z;
       end;


       WP1Z:=-InfinitValue;
       aArea:=nil;
       if Area.Volume1<>nil then
       for m:=0 to Area.Volume1.Areas.Count-1 do begin
         aArea:=Area.Volume1.Areas.Item[m] as IArea;
         if (aArea<>Area) and
            ((aArea as IPolyline).Lines.IndexOf(BottomLineE)<>-1) then begin
           aArea.GetCentralPoint(WP1X, WP1Y, WP1Z);
           Break;
         end;
       end;
       if aArea=nil then begin
         WP1X:=X;
         WP1Y:=Y;
         WP1Z:=Z;
       end;

       ProjL:=sqrt(sqr(BottomLine.C1.X-BottomLine.C0.X)+sqr(BottomLine.C1.Y-BottomLine.C0.Y));
       cosX:=(BottomLine.C1.X-BottomLine.C0.X)/ProjL;
       cosY:=(BottomLine.C1.Y-BottomLine.C0.Y)/ProjL;
       Set_CenterAt(C0, C1, X, Y, Z, ShoulderWidth, cosX, cosY,
                             WP0X, WP0Y, WP0Z, WP1X, WP1Y, WP1Z);
    end else
      Result:=nil;
  end else begin
    Area.GetCentralPoint(WP0X, WP0Y, WP0Z);
    C0.X:=WP0X;
    C0.Y:=WP0Y;
    C0.Z:=WP0Z+ShoulderWidth;
    C1.X:=WP0X;
    C1.Y:=WP0Y;
    C1.Z:=WP0Z-ShoulderWidth;
  end;
  finally
    Document.State:=OldState;
  end;
end;

procedure TCustomBoundary.CalcVulnerability;
var
  j:integer;
  C0V, C1V: IVulnerabilityData;
  C0E, C1E:IDMElement;
  Zone0, Zone1:IZone;
  V, V0, V1:double;
  DelayTimeToTarget, DelayTimeFromStart,
  RationalProbabilityToTarget, BackPathRationalProbability,
  NoDetectionProbabilityFromStart:double;
  CE, DelayTimeToTargetNode, DelayTimeFromStartNode,
  RationalProbabilityToTargetNode, BackPathRationalProbabilityNode,
  NoDetectionProbabilityFromStartNode:IDMElement;
  PathArcL:ILine;
  PathArc:IPathArc;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  PathArcs:IDMCollection;
  Category0, Category1:integer;
  PathArcE, FacilityStateE, aFacilityStateE:IDMElement;
  BaseFacilityState, aFacilityState:IFacilityState;
  AnalysisVariant:IAnalysisVariant;
//  aAnalysisVariant:IAnalysisVariant;

begin
  FacilityModel:=DataModel as  IFacilityModel;
  FacilityModelS:=FacilityModel as  IFMState;
  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  if FacilityStateE=nil then Exit;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;

  BaseFacilityState:=AnalysisVariant.FacilityState as IFacilityState;

  try
  DelayTimeToTarget:=InfinitValue;
  DelayTimeFromStart:=InfinitValue;
  RationalProbabilityToTarget:=-InfinitValue;
  BackPathRationalProbability:=-InfinitValue;
  NoDetectionProbabilityFromStart:=-InfinitValue;
  DelayTimeToTargetNode:=nil;
  DelayTimeFromStartNode:=nil;
  RationalProbabilityToTargetNode:=nil;
  BackPathRationalProbabilityNode:=nil;
  NoDetectionProbabilityFromStartNode:=nil;
  GDelayTimeToTarget_BestArcE:=nil;
  GDelayTimeFromStart_BestArcE:=nil;
  GRationalProbabilityToTarget_BestArcE:=nil;
  GBackPathRationalProbability_BestArcE:=nil;
  GNoDetectionProbabilityFromStart_BestArcE:=nil;;

  PathArcs:=Get_PathArcs;

  for j:=0 to PathArcs.Count-1 do begin
    PathArcE:=PathArcs.Item[j];
    PathArc:=PathArcE as IPathArc;
    aFacilityStateE:=PathArc.FacilityState;
    aFacilityState:=aFacilityStateE as IFacilityState;
//    aAnalysisVariant:=aFacilityStateE.Ref as IAnalysisVariant;
    if // (aAnalysisVariant=AnalysisVariant) and   // относится к текущему варианту
      (aFacilityState.Kind<>2) then begin
      PathArcL:=PathArcE as ILine;             // не возмущенное состояние
      C0E:=PathArcL.C0 as IDMElement;
      C1E:=PathArcL.C1 as IDMElement;
      if C0E=nil then Exit;
      if C1E=nil then Exit;
      C0V:=C0E as IVulnerabilityData;
      C1V:=C1E as IVulnerabilityData;

      Category0:=-1;
      Category1:=-1;
      if (C0E.Ref<>nil) and (C1E.Ref<>nil) then begin
        if (C0E.Ref.QueryInterface(IZone, Zone0)=0) and
           (C1E.Ref.QueryInterface(IZone, Zone1)=0) then begin
          if Zone0<>nil then
            Category0:=Zone0.Category;
          if Zone1<>nil then
            Category1:=Zone1.Category;
        end else begin
          Category1:=0;
          Category0:=1;
        end;
      end else
        Exit;

      if aFacilityState.Kind=0 then begin // (на входящей ветви)
        V0:=C0V.DelayTimeToTarget;
        V1:=C1V.DelayTimeToTarget;
        if Category0<Category1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else
        if Category0>Category1 then begin
          V:=V1;
          CE:=C1V as IDMElement;
        end else
        if V0>V1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else begin
          V:=V1;
          CE:=C1V as IDMElement;
        end;
        if DelayTimeToTarget>V then begin
          DelayTimeToTarget:=V;
          DelayTimeToTargetNode:=CE;
          GDelayTimeToTarget_BestArcE:=PathArcE;
        end;

        V0:=C0V.DelayTimeFromStart;
        V1:=C1V.DelayTimeFromStart;
        if Category0<Category1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else
        if Category0>Category1 then begin
          V:=V1;
          CE:=C1V as IDMElement;
        end else
        if V0>V1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else begin
          V:=V1;
          CE:=C1V as IDMElement;
        end;
        if DelayTimeFromStart>V then begin
          DelayTimeFromStart:=V;
          DelayTimeFromStartNode:=CE;
          GDelayTimeFromStart_BestArcE:=PathArcE;
        end;

        V0:=C0V.RationalProbabilityToTarget;
        V1:=C1V.RationalProbabilityToTarget;
        if Category0<Category1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else
        if Category0>Category1 then begin
          V:=V1;
          CE:=C1V as IDMElement;
        end else
        if V0<V1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else
        if V0>V1 then begin
          V:=V1;
          CE:=C1V as IDMElement;
        end else begin
          V:=V0;
          V0:=C0V.DelayTimeToTarget;
          V1:=C1V.DelayTimeToTarget;
          if V0>V1 then
            CE:=C0V as IDMElement
          else
          if V0<V1 then
            CE:=C1V as IDMElement
          else
          if PathArcE=C0V.DelayTimeToTarget_NextArc then
            CE:=C1V as IDMElement
          else
            CE:=C0V as IDMElement
        end;

        if RationalProbabilityToTarget<V then begin
          RationalProbabilityToTarget:=V;
          RationalProbabilityToTargetNode:=CE;
          GRationalProbabilityToTarget_BestArcE:=PathArcE;
        end;


        V0:=C0V.BackPathRationalProbability;
        V1:=C1V.BackPathRationalProbability;
        if Category0<Category1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else
        if Category0>Category1 then begin
          V:=V1;
          CE:=C1V as IDMElement;
        end else
        if V0<V1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else
        if V0>V1 then begin
          V:=V1;
          CE:=C1V as IDMElement;
        end else begin
          V:=V0;
          V0:=C0V.DelayTimeToTarget;
          V1:=C1V.DelayTimeToTarget;
          if V0<V1 then
            CE:=C0V as IDMElement
          else
          if V0>V1 then
            CE:=C1V as IDMElement
          else
          if PathArcE=C0V.DelayTimeToTarget_NextArc then
            CE:=C0V as IDMElement
          else
            CE:=C1V as IDMElement
        end;

        if BackPathRationalProbability<V then begin
          BackPathRationalProbability:=V;
          BackPathRationalProbabilityNode:=CE;
          GBackPathRationalProbability_BestArcE:=PathArcE;
        end;

        V0:=C0V.NoDetectionProbabilityFromStart;
        V1:=C1V.NoDetectionProbabilityFromStart;
        if Category0<Category1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else
        if Category0>Category1 then begin
          V:=V1;
          CE:=C1V as IDMElement;
        end else
        if V0>V1 then begin
          V:=V0;
          CE:=C0V as IDMElement;
        end else begin
          V:=V1;
          CE:=C1V as IDMElement;
        end;
        if NoDetectionProbabilityFromStart<V then begin
          NoDetectionProbabilityFromStart:=V;
          NoDetectionProbabilityFromStartNode:=CE;
          GNoDetectionProbabilityFromStart_BestArcE:=PathArcE;
        end;
      end;  //if aFacilityState.Kind=0
    end; //  if (aAnalysisVariant=AnalysisVariant) and ...
  end; //      for j:=0 to PathArcs.Count-1



  FDelayTimeToTarget:=DelayTimeToTarget;
  FDelayTimeFromStart:=DelayTimeFromStart;
  FRationalProbabilityToTarget:=RationalProbabilityToTarget;
  FBackPathRationalProbability:=BackPathRationalProbability;
  FNoDetectionProbabilityFromStart:=NoDetectionProbabilityFromStart;
  FDelayTimeToTarget_NextNode:=DelayTimeToTargetNode;
  FDelayTimeFromStart_NextNode:=DelayTimeFromStartNode;
  FRationalProbabilityToTarget_NextNode:=RationalProbabilityToTargetNode;
  FBackPathRationalProbability_NextNode:=BackPathRationalProbabilityNode;
  FNoDetectionProbabilityFromStart_NextNode:=NoDetectionProbabilityFromStartNode;

  finally
  end;
end;

procedure TCustomBoundary.CalcGuardTactic;
var
  j, m:integer;
  C0V, C1V, BestCV, CV: IVulnerabilityData;
  C0E, C1E:IDMElement;
  V, V0, V1, DV, DV0, DV1, StartDelay, ResponceTimeDispersionRatio,
  VGroupDelayTimeFromStart, VGroupDelayTimeFromStartDispersion:double;
  PathArcL:ILine;
  PathArc:IPathArc;
  FacilityModel:IFacilityModel;
  GuardModel:IGuardModel;
  FacilityModelS:IFMState;
  PathArcs:IDMCollection;
  PathArcE, FacilityStateE, aFacilityStateE:IDMElement;
  BaseFacilityState, aFacilityState:IFacilityState;
  AnalysisVariant:IAnalysisVariant;
  AlarmGroupE, SelfE, GuardArrivalE:IDMElement;
  WarriorGroup:IWarriorGroup;
begin
  SelfE:=Self as IDMElement;
  FacilityModel:=DataModel as  IFacilityModel;
  GuardModel:=DataModel as  IGuardModel;
  FacilityModelS:=FacilityModel as  IFMState;
  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;

  if FacilityStateE=nil then Exit;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;

  BaseFacilityState:=AnalysisVariant.FacilityState as IFacilityState;
  VGroupDelayTimeFromStart:=InfinitValue;
  VGroupDelayTimeFromStartDispersion:=InfinitValue;
  FAlarmGroup:=nil;

  if FGoalDefinding then
    FParamFlags:=FParamFlags or pfAlwaysGoalDefinding
  else begin
    m:=0;
    while m<GuardModel.GuardArrivals.Count do begin
      GuardArrivalE:=GuardModel.GuardArrivals.Item[m];
      WarriorGroup:=GuardArrivalE as IWarriorGroup;
      if WarriorGroup.GetAccessType(SelfE, True)<>0 then
        Break
      else
        inc(m)
    end;
    if (m=GuardModel.GuardArrivals.Count) then
      FParamFlags:=FParamFlags or pfAlwaysGoalDefinding
    else
      FParamFlags:=FParamFlags and not pfAlwaysGoalDefinding
  end;

  if AnalysisVariant.UserDefinedResponceTimeDispersionRatio then
    ResponceTimeDispersionRatio:=AnalysisVariant.ResponceTimeDispersionRatio
  else
    ResponceTimeDispersionRatio:=FacilityModel.ResponceTimeDispersionRatio;

  PathArcs:=Get_PathArcs;

  for m:=0 to GuardModel.AlarmGroups.Count-1 do begin
    AlarmGroupE:=GuardModel.AlarmGroups.Item[m];
    WarriorGroup:=AlarmGroupE as IWarriorGroup;
    if WarriorGroup.GetAccessType(SelfE, True)<>0 then begin
      StartDelay:=(WarriorGroup as IGuardGroup).StartDelay;
      for j:=0 to PathArcs.Count-1 do begin
        PathArcE:=PathArcs.Item[j];
        PathArc:=PathArcE as IPathArc;
        aFacilityStateE:=PathArc.FacilityState;
        aFacilityState:=aFacilityStateE as IFacilityState;
//        aAnalysisVariant:=aFacilityStateE.Ref as IAnalysisVariant;
        if //(aAnalysisVariant=AnalysisVariant) and   // относится к текущему варианту
          (aFacilityState.Kind=0) then begin
          PathArcL:=PathArcE as ILine;             // не возмущенное состояние
          C0E:=PathArcL.C0 as IDMElement;
          C1E:=PathArcL.C1 as IDMElement;
          C0V:=C0E as IVulnerabilityData;
          C1V:=C1E as IVulnerabilityData;

          if not C0V.GetDelayTimeFromStart(AlarmGroupE, V0, DV0) then
            V0:=InfinitValue;
          if not C1V.GetDelayTimeFromStart(AlarmGroupE, V1, DV1) then
            V1:=InfinitValue;
          if V0<V1 then begin
            V:=V0+StartDelay;
            DV:=DV0+sqr(ResponceTimeDispersionRatio*StartDelay);
            CV:=C0V;
          end else begin
            V:=V1+StartDelay;
            DV:=DV1+sqr(ResponceTimeDispersionRatio*StartDelay);
            CV:=C1V;
          end;
          if VGroupDelayTimeFromStart>V then begin
            VGroupDelayTimeFromStart:=V;
            VGroupDelayTimeFromStartDispersion:=DV;
            BestCV:=CV;
            FAlarmGroup:=AlarmGroupE;
          end;
        end; //  if (aAnalysisVariant=AnalysisVariant) and ...
      end; //      for j:=0 to PathArcs.Count-1
    end // if AlarmGroup.GetAccessType(SelfE, True)<>0 then begin
  end;  // for m:=0 to GuardModel.AlarmGroups.Count-1

  FBattleVictoryProbability:=0;
  FBattleTime:=0;
  FBattleTimeDispersion:=0;

  FAlarmGroupDelayTimeFromStart:=VGroupDelayTimeFromStart;
  FAlarmGroupDelayTimeFromStartDispersion:=VGroupDelayTimeFromStartDispersion;
end;

function TCustomBoundary.Get_OptimalPath: IWarriorPath;
var
  j:integer;
  WarriorPath:IWarriorPath;
begin
  j:=0;
  while j<FWarriorPaths.Count do begin
    WarriorPath:=FWarriorPaths.Item[j] as IWarriorPath;
    if WarriorPath.Kind=_wpkOptimal then Break;
    inc(j);
  end;
  if j<FWarriorPaths.Count then
    Result:=WarriorPath
  else
    Result:=nil;
end;

function TCustomBoundary.Get_FastPath: IWarriorPath;
var
  j:integer;
  WarriorPath:IWarriorPath;
begin
  j:=0;
  while j<FWarriorPaths.Count do begin
    WarriorPath:=FWarriorPaths.Item[j] as IWarriorPath;
    if WarriorPath.Kind=_wpkFast then Break;
    inc(j);
  end;
  if j<FWarriorPaths.Count then
    Result:=WarriorPath
  else
    Result:=nil;
end;

function TCustomBoundary.Get_StealthPath: IWarriorPath;
var
  j:integer;
  WarriorPath:IWarriorPath;
begin
  j:=0;
  while j<FWarriorPaths.Count do begin
    WarriorPath:=FWarriorPaths.Item[j] as IWarriorPath;
    if WarriorPath.Kind=_wpkStealth then Break;
    inc(j);
  end;
  if j<FWarriorPaths.Count then
    Result:=WarriorPath
  else
    Result:=nil;
end;

procedure TCustomBoundary.Set_Selected(Value: WordBool);
begin
  inherited;
end;

function TCustomBoundary.Get_BoundaryLayers: IDMCollection;
begin
  Result:=FBoundaryLayers
end;

function TCustomBoundary.Get_HasNoFieldBarrier: WordBool;
begin
  Result:=(FParamFlags and pfNoFieldBarrier)<>0
end;

function TCustomBoundary.Get_IsTransparent: WordBool;
begin
  Result:=(FParamFlags and pfTransparent)<>0
end;

procedure TCustomBoundary.Set_SpatialElement(const Value: IDMElement);
begin
  inherited;
  if Value=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if DataModel.IsChanging then Exit;
  UpdateObservers;
end;

procedure TCustomBoundary.UpdateObservers;
var
  FacilityModel:IFacilityModel;
  Zone:IZone;
  X, Y, Z:double;
  Observers: IDMCollection;
  Area:IArea;
  Line:ILine;
  C0, C1:ICoordNode;
  Volume:IVolume;
  SpatialModel2:ISpatialModel2;
  j:integer;
  aObserverE, DataModelE, SelfE:IDMElement;
  OperationManager:IDMOperationManager;
  NewObserverU:IUnknown;
  NewObserver, aObserver:IObserver;
begin
  inherited;
  SelfE:=Self as IDMElement;
  DataModelE:=DataModel as IDMElement;
  SpatialModel2:=DataModelE as ISpatialModel2;
  FacilityModel:=DataModelE as IFacilityModel;
  OperationManager:=DataModel.Document as IDMOperationManager;
  if SpatialElement=nil then Exit;
  if SpatialElement.QueryInterface(IArea, Area)=0 then begin
    Zone:=Get_Zone0 as IZone;
    if Zone=nil then
      Zone:=Get_Zone1 as IZone;
  end else
  if SpatialElement.QueryInterface(ILine, Line)=0 then begin
    C0:=Line.C0;
    C1:=Line.C1;
    if C0=nil then Exit;
    if C1=nil then Exit;
    X:=0.5*(C0.X+C1.X);
    Y:=0.5*(C0.Y+C1.Y);
    Z:=0.5*(C0.Z+C1.Z)+100;
    Volume:=SpatialModel2.GetVolumeContaining(X,Y,Z);
    Zone:=(Volume as IDMElement).Ref as IZone;
  end else
  if SpatialElement.QueryInterface(ICoordNode, C0)=0 then begin
    Zone:=Get_Zone0 as IZone;
  end else
    Exit;

  if Zone=nil then Exit;

  Observers:=DataModelE.Collection[_Observer] as IDMCollection;

  for j:=0 to Zone.Observers.Count-1 do begin
    aObserverE:=Zone.Observers.Item[j];
    OperationManager.AddElementRef(SelfE, Observers, '',
                              aObserverE.Ref, ltOneToMany, NewObserverU, True);
    aObserver:=aObserverE as IObserver;
    NewObserver:=NewObserverU as IObserver;
    aObserver.ObservationKind:=NewObserver.ObservationKind;
  end;
end;

procedure TCustomBoundary.AfterLoading2;
begin
  inherited;
  ClearCash(True);
  CalcParamFlags;
end;

procedure TCustomBoundary.GetFieldValueSource(Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(fepFont):
    begin
      if DataModel=nil then
        theCollection:=nil
      else
        theCollection:=(DataModel as ISpatialModel2).Fonts
    end;
  else
    begin
      inherited;
      Exit;
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

procedure TCustomBoundary.CalcParamFlags;
var
  j:integer;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerFB:IFieldBarrier;
  Visible0, Visible1:boolean;
begin
  FParamFlags:=FParamFlags and not pfTransparent and not pfFragile;
  if Get_Disabled then Exit;
  if Get_IsEmpty then Exit;

  FParamFlags:=FParamFlags or pfTransparent or pfNoFieldBarrier;
  if (Ref.Parent as IModelElementType).TypeID=btVirtual then Exit;

  Visible0:=True;
  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayer:=FBoundaryLayers.Item[j] as IBoundaryLayer;
    BoundaryLayerFB:=BoundaryLayer as IFieldBarrier;
    BoundaryLayerFB.CalcParamFlags;
    BoundaryLayer.Visible0:=Visible0;
    if not BoundaryLayerFB.IsTransparent then begin
      FParamFlags:=FParamFlags and not pfTransparent;
       Visible0:=False;
    end;
    if not BoundaryLayerFB.HasNoFieldBarrier then
      FParamFlags:=FParamFlags and not pfNoFieldBarrier;
    if BoundaryLayerFB.IsFragile then
      FParamFlags:=FParamFlags or pfFragile;
  end;

  Visible1:=True;
  for j:=FBoundaryLayers.Count-1  downto 0 do begin
    BoundaryLayer:=FBoundaryLayers.Item[j] as IBoundaryLayer;
    BoundaryLayerFB:=BoundaryLayer as IFieldBarrier;
    BoundaryLayer.Visible1:=Visible1;
    if not BoundaryLayerFB.IsTransparent then
       Visible1:=False;
  end;

end;

function TCustomBoundary.Get_SoundResistance: double;
var
  j:integer;
  BoundaryLayer:IFieldBarrier;
begin
  if FSoundResistance=-1 then begin
    Result:=0;
    for j:=0 to FBoundaryLayers.Count-1 do begin
      BoundaryLayer:=FBoundaryLayers.Item[j] as IFieldBarrier;
      Result:=Result+BoundaryLayer.SoundResistance;
    end;
    FSoundResistance:=Result
  end else
    Result:=FSoundResistance
end;

function TCustomBoundary.Get_SoundResistanceSum0: Double;
begin
  Result:=FSoundResistanceSum0
end;

function TCustomBoundary.Get_SoundResistanceSum1: Double;
begin
  Result:=FSoundResistanceSum1
end;

procedure TCustomBoundary.Set_SoundResistanceSum0(Value: Double);
begin
  FSoundResistanceSum0:=Value
end;

procedure TCustomBoundary.Set_SoundResistanceSum1(Value: Double);
begin
  FSoundResistanceSum1:=Value
end;

function TCustomBoundary.Get_NearestSoundResistanceSum0: Double;
begin
  Result:=FNearestSoundResistanceSum0
end;

function TCustomBoundary.Get_NearestSoundResistanceSum1: Double;
begin
  Result:=FNearestSoundResistanceSum1
end;

procedure TCustomBoundary.Set_NearestSoundResistanceSum0(Value: Double);
begin
  FNearestSoundResistanceSum0:=Value
end;

procedure TCustomBoundary.Set_NearestSoundResistanceSum1(Value: Double);
begin
  FNearestSoundResistanceSum1:=Value
end;

function TCustomBoundary.GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer;
var
  j, m, N:integer;
  VisualControl:integer;
  AvailabelTime, L:double;
  DimensionItem:IDMField;
  Zone0, Zone1, Zone:IZone;
  PresonalCount:integer;
  Area:IArea;
  C0, C1:ICoord;
  BoundaryLayer:ISafeguardUnit;
  ModelElementType:IModelElementType;
  SafeguardElementE:IDMElement;
  SafeguardElement:ISafeguardElement;
begin
  case Kind of
  sdVisualControl:
    begin
      case Code of
      0:begin
        if (FObservers.Count=0) then
          Result:=0
        else
          Result:=1;
        end;
      1:begin
          N:=FObservers.Count;
          if N>1 then
            Result:=0
          else
          if N=1 then
            Result:=1
          else
            Result:=2
        end;
      end;
    end;
  sdAvailabelTime:
    begin
      if DimItems=nil then begin
        Result:=-1;
        Exit;
      end;
      VisualControl:=Get_VisualControl;
      case VisualControl of
      0:AvailabelTime:=Get_PatrolPeriod;

      1:AvailabelTime:=10;
      2:AvailabelTime:=20;
      else
        AvailabelTime:=-1;
      end;
      j:=0;
      while j<DimItems.Count do begin
        DimensionItem:=DimItems.Item[j] as IDMField;
        if (AvailabelTime>=DimensionItem.MinValue) and
           (AvailabelTime<DimensionItem.MaxValue) then
          Break
        else
          inc(j)
      end;
      if j<DimItems.Count then
        Result:=j
      else
        Result:=DimItems.Count-1
    end;
  sdPersonalCount:
    begin
      Zone0:=Get_Zone0 as IZone;
      Zone1:=Get_Zone1 as IZone;
      if Zone0=nil then
        Zone:=Zone1
      else
      if Zone1=nil then
        Zone:=Zone0
      else
      if Zone0.Category<Zone1.Category then
        Zone:=Zone1
      else
        Zone:=Zone0;
      PresonalCount:=Zone.PersonalCount;
      j:=0;
      while j<DimItems.Count do begin
        DimensionItem:=DimItems.Item[j] as IDMField;
        if (PresonalCount>=DimensionItem.MinValue) and
           (PresonalCount<DimensionItem.MaxValue) then
          Break
        else
          inc(j)
      end;
      if j<DimItems.Count then
        Result:=j
      else
        Result:=DimItems.Count-1
    end;
  sdRamEnabled:
    begin
      Result:=0;
      Zone0:=Get_Zone0 as IZone;
      if Zone0<>nil then
        if not ((Zone0 as IDMElement).Ref as IZoneKind).CarMovementEnabled then begin
        Exit;
      end;
      Zone1:=Get_Zone1 as IZone;
      if Zone1<>nil then
        if not ((Zone1 as IDMElement).Ref as IZoneKind).CarMovementEnabled then begin
        Exit;
      end;
      if (SpatialElement.QueryInterface(IArea, Area)=0) and
         Area.IsVertical then begin
        C0:=Area.C0;
        C1:=Area.C1;
        L:=sqrt(sqr(C0.X-C1.X)+sqr(C0.Y-C1.Y));
        if L<200 then begin
          Exit;
        end;
      end else begin
        Exit;
      end;
      j:=0;
      while j<FBoundaryLayers.Count do begin
        BoundaryLayer:=FBoundaryLayers.Item[j] as ISafeguardUnit;
        m:=0;
        while m<BoundaryLayer.SafeguardElements.Count do begin
          SafeguardElementE:=BoundaryLayer.SafeguardElements.Item[m];
          SafeguardElement:=SafeguardElementE as ISafeguardElement;
          ModelElementType:=SafeguardElementE.Ref.Parent as IModelElementType;
          if (ModelElementType.TypeID=bRamObstacle) and
             (SafeguardElement.InWorkingState) then
            Exit
          else
            inc(m)
        end;
        inc(j);
      end;
      Result:=1;
    end;
  else
    Result:=inherited GetMethodDimItemIndex(Kind, Code, DimItems,
                                            ParamE, ParamF);
  end;
end;


procedure TCustomBoundary._AddBackRef(const Value: IDMElement);
begin
  if Value.ClassID=_Jump then
    (FBackRefs as IDMCollection2).Add(Value)
  else
    inherited;
end;

procedure TCustomBoundary._RemoveBackRef(const Value: IDMElement);
begin
  if Value.ClassID=_Jump then
    (FBackRefs as IDMCollection2).Remove(Value)
  else
    inherited;
end;

function TCustomBoundary.Get_VisualControl: Integer;
begin
  if FObservers.Count>0 then
    Result:=1
  else
    Result:=0
end;

function TCustomBoundary.Get_FlowIntencity: integer;
begin
  Result:=FFlowIntencity
end;

function TCustomBoundary.FieldIsVisible(Code: Integer): WordBool;
var
  BoundaryLayerE:IDMElement;
begin
  try
  case Code of
  ord(bopDelayTime):
    Result:=FUserDefinedDelayTime;
  ord(bopDetectionProbability):
    Result:=FUserDefinedDetectionProbability;
  ord(bopFlowIntencity):
    if (Ref<>nil) and
       (Ref.Parent<>nil) then
      Result:=(Ref.Parent.Id=btEntryPoint)
    else
      Result:=False;
  ord(blpUserDefinedDelayTime),
  ord(blpDelayTime),
  ord(blpUserDefinedDetectionProbability),
  ord(blpDetectionProbability):
    Result:=False;
  ord(blpHeight0),
  ord(blpHeight1),
  ord(blpDistanceFromPrev),
  ord(blpDrawJoint0),
  ord(blpDrawJoint1),
  ord(cnstShowSymbol),
  ord(cnstSymbolScaleFactor),
  ord(cnstImageRotated),
  ord(cnstImageMirrored),
  ord(blpConstruction):
    begin
      BoundaryLayerE:=FBoundaryLayers.Item[0];
      Result:=BoundaryLayerE.FieldIsVisible(Code);
    end;
  else
    Result:=inherited FieldIsVisible(Code);
  end;
  except
    raise
  end;
end;

function TCustomBoundary.Get_Observers: IDMCollection;
begin
  Result:=FObservers
end;

procedure TCustomBoundary.JoinSpatialElements(const aElement: IDMElement);
var
  j:integer;
  aBoundary:IBoundary;
  Jump:IJump;
begin
  try
  if aElement.ClassID=_Boundary then begin
    aBoundary:=aElement as IBoundary;
    for j:=0 to aBoundary.BackRefs.Count-1 do begin
      if aBoundary.BackRefs.Item[j].ClassID=_Jump then begin
        Jump:=aBoundary.BackRefs.Item[j] as IJump;
        if Jump.Boundary0=aElement then
          Jump.Boundary0:=Self as IDMElement;
        if Jump.Boundary1=aElement then
          Jump.Boundary1:=Self as IDMElement;
      end;
    end;
  end;
  except
    raise
  end;  
end;

function TCustomBoundary.Get_BackRefs: IDMCollection;
begin
  Result:=FBackRefs
end;

procedure TCustomBoundary.AfterLoading1;
begin
  inherited;
//  CalcParamFlags;
end;

procedure TCustomBoundary.CalcFalseAlarmPeriod;
var
  FalseAlarmFrequency, F, T:double;
  j, m:integer;
  Sensor:ISensor;
  BoundaryLayerS:ISafeguardUnit;
  SafeguardElement:ISafeguardElement;
begin
  FalseAlarmFrequency:=0;
  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayerS:=FBoundaryLayers.Item[j] as ISafeguardUnit;
    for m:=0 to BoundaryLayerS.SafeguardElements.Count-1 do begin
      SafeguardElement:=BoundaryLayerS.SafeguardElements.Item[m] as ISafeguardElement;
      if SafeguardElement.QueryInterface(ISensor, Sensor)=0 then begin
        Sensor.CalcFalseAlarmPeriod;
        T:=Sensor.FalseAlarmPeriod;
        if T<>0 then begin
          F:=1./T;
          FalseAlarmFrequency:=FalseAlarmFrequency+F;
        end;
      end;
    end;
  end;
  if FalseAlarmFrequency<>0 then
    Set_FalseAlarmPeriod(1./FalseAlarmFrequency)
  else
    Set_FalseAlarmPeriod(0)
end;

procedure TCustomBoundary.BeforeDeletion;
var
  Area:IArea;
  Zone0E, aZoneE, Zone1E:IDMElement;
  Zone0:IZone;
  DMOperationManager:IDMOperationManager;
  j:integer;
begin
  inherited;
  if SpatialElement=nil then Exit;
  if SpatialElement.QueryInterface(IArea, Area)<>0 then Exit;

  Zone0E:=Get_Zone0;
  if Zone0E=nil then Exit;
  Zone1E:=Get_Zone1;
  if Zone1E=nil then Exit;

  Zone0:=Zone0E as IZone;

  DMOperationManager:=DataModel.Document as IDMOperationManager;

  j:=0;
  while j<Zone0.Zones.Count do begin
    aZoneE:=Zone0.Zones.Item[j];
    if aZoneE.Parent<>Zone1E then
      DMOperationManager.ChangeParent( nil, Zone1E, aZoneE)
    else
      inc(j)  
  end;
end;

function TCustomBoundary.Get_UserDefineded: WordBool;
var
  j:integer;
  BoundaryLayerUserDefined:boolean;
  BoundaryLayerE:IDMElement;
begin
  j:=0;
  while j<FBoundaryLayers.Count do begin
    BoundaryLayerE:=FBoundaryLayers.Item[j];
    if BoundaryLayerE.UserDefineded then
      Break
    else
      inc(j)
  end;
  BoundaryLayerUserDefined:=j<FBoundaryLayers.Count;
  Result:=(inherited Get_UserDefineded) or BoundaryLayerUserDefined;
end;

function TCustomBoundary.Get_DelayTime: double;
var
  State:IElementState;
  FacilityModelS:IFMState;
begin
  FacilityModelS:=DataModel as IFMState;
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.DelayTime
  else
    Result:=FDelayTime
end;

function TCustomBoundary.Get_PatrolPeriod: double;
var
  T0, T1, R:double;
  Zone0E, Zone1E:IDMElement;
begin
  Zone0E:=Get_Zone0;
  Zone1E:=Get_Zone1;
  if Zone0E=nil then
    T0:=InfinitValue
  else
    T0:=(Zone0E as IFacilityElement).PatrolPeriod;
  if Zone1E=nil then
    T1:=InfinitValue
  else
    T1:=(Zone1E as IFacilityElement).PatrolPeriod;
  R:=1/T0+1/T1;

  if R=0 then
    Result:=InfinitValue
  else
    Result:=1/R
end;

procedure TCustomBoundary.CalcPathSoundResistance(
  var PathSoundResistance, FuncSoundResistance: Double);
begin
  PathSoundResistance:=PathSoundResistance+Get_SoundResistance;
  inherited;
end;

function TCustomBoundary.Get_IsEmpty: WordBool;
var
  j:integer;
  BoundaryLayerIsNotEmpty:boolean;
  BoundaryLayerE:IDMElement;
begin
  j:=0;
  while j<FBoundaryLayers.Count do begin
    BoundaryLayerE:=FBoundaryLayers.Item[j];
    if not BoundaryLayerE.IsEmpty then
      Break
    else
      inc(j)
  end;
  BoundaryLayerIsNotEmpty:=j<FBoundaryLayers.Count;
  Result:=not BoundaryLayerIsNotEmpty;
end;

procedure TCustomBoundary.Clear;
begin
  ClearWarriorPaths;
  inherited;
end;

procedure TCustomBoundary.ClearWarriorPaths;
var
  WarriorPaths2:IDMCollection2;
  WarriorPathE:IDMElement;
begin
  if DataModel<>nil then begin
    WarriorPaths2:=(DataModel as IFacilityModel).WarriorPaths as IDMCollection2;
    while FWarriorPaths.Count>0 do begin
      WarriorPathE:=FWarriorPaths.Item[FWarriorPaths.Count-1];
      WarriorPathE.Clear;
      WarriorPaths2.Remove(WarriorPathE);
    end;
  end;
end;

procedure TCustomBoundary.ClearOp;
begin
  ClearWarriorPaths;
  inherited;
end;

procedure TCustomBoundary.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  aCollection2:=aCollection as IDMCollection2;
  SourceCollection:=(DataModel as IFacilityModel).FacilitySubStates;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do
    aCollection2.Add(SourceCollection.Item[j]);
end;

procedure TCustomBoundary.Set_Zone0(const Value: IDMElement);
begin
end;

procedure TCustomBoundary.Set_Zone1(const Value: IDMElement);
begin
end;

procedure TCustomBoundary.MakeBackPathElementStates(const SubStateE: IDMElement);
var
  j, m:integer;
  BoundaryLayerSU:ISafeguardUnit;
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
  for m:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayerSU:=FBoundaryLayers.Item[m] as ISafeguardUnit;
    for j:=0 to BoundaryLayerSU.SafeguardElements.Count-1 do begin
      SafeguardElementE:=BoundaryLayerSU.SafeguardElements.Item[j];
      SafeguardElement:=SafeguardElementE as ISafeguardElement;
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


procedure TCustomBoundary.CalcExternalPathDelayTime(var T, TDisp, dT, dTDisp:double);
var
  OldWarriorPathStage:integer;
  FacilityModelS:IFMState;
  BestTacticE:IDMElement;
begin
  FacilityModelS:=DataModel as IFMState;
  OldWarriorPathStage:=FacilityModelS.CurrentPathStage;
  if (OldWarriorPathStage=wpsStealthEntry) then
    FacilityModelS.CurrentPathStage:=wpsFastEntry
  else
  if (OldWarriorPathStage=wpsStealthExit) then
     FacilityModelS.CurrentPathStage:=wpsFastExit;

  CalcExternalDelayTime(dT, dTDisp, BestTacticE);

  T:=T+dT;
  TDisp:=TDisp+dTDisp;
  FacilityModelS.CurrentPathStage:=OldWarriorPathStage;
end;

procedure TCustomBoundary.CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                                aAddDelay:double);
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  OldState:integer;
  theLineE:IDMElement;
  theLine:ILine;
  DMDocument:IDMDocument;
  DelayTimeDispersionRatio,
  T, TDisp, aT, aTDisp:double;
  aSuccessProbability,
  aAdversaryVictoryProbability,
  dTExt, dTDispExt,
  PassDistance, PassVelocity, PassTime, PassTimeDispersion:double;
  m:integer;
  BoundaryLayer:IBoundaryLayer;

  AddDelay,Gap, NoObsP:double;
begin
  inherited;

  if Ref=nil then Exit;

  SetCurrentDirection;

  try
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;

  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  if FBoundaryLayers.Count=0 then Exit;

  theLine:=FacilityModelS.CurrentLineU as ILine;
  if theLine=nil then begin  //если нет явно заданной лииии преодоления рубежа
    DMDocument:=DataModel.Document as IDMDocument;
    OldState:=DMDocument.State;
    DMDocument.State:=DMDocument.State or dmfCommiting;
    try
      theLineE:=MakeTemporyPath as IDMElement;
      FacilityModelS.CurrentLineU:=theLineE;
      theLine:=theLineE as ILine;
    finally
      DMDocument.State:=OldState;
    end;
  end;

  T:=DelayTimeSum;
  TDisp:=DelayTimeDispersionSum;

  CalcExternalPathDelayTime(T, TDisp, dTExt, dTDispExt);

  PassVelocity:=GetPassVelocity;
  Gap:=GetGap;

  if FBoundaryLayers.Count>0 then begin

    aSuccessProbability:=SuccessProbability;
    aT:=T;
    aTDisp:=TDisp;

    for m:=FBoundaryLayers.Count-1 downto 0 do begin
      BoundaryLayer:=FBoundaryLayers.Item[m] as IBoundaryLayer;

      AddDelay:=aAddDelay;
      if m=0 then
        AddDelay:=AddDelay+Gap/PassVelocity;
      if m=FBoundaryLayers.Count-1 then
        AddDelay:=AddDelay+Gap/PassVelocity;

      BoundaryLayer.CalcPathSuccessProbability(
                        aSuccessProbability,
                        aAdversaryVictoryProbability,
                        aT, aTDisp, AddDelay);
    end;

    SuccessProbability:=aSuccessProbability;
    T:=aT;
    TDisp:=aTDisp;
    AdversaryVictoryProbability:=aAdversaryVictoryProbability;
    DelayTimeSum:=T;
    DelayTimeDispersionSum:=TDisp;
  end else begin
    DelayTimeSum:=T+2*Gap/PassVelocity;
  end;

  NoObsP:=CalcNoObsProbability; // здесь считаем вклады в обнаружение от
         // явно заданных  для наблюдателей вероятностей и от вероятностей их нейтрализации

  if NoObsP<>1 then
    SuccessProbability:=NoObsP*SuccessProbability+
                     (1-NoObsP)*aAdversaryVictoryProbability;


  except
    DataModel.HandleError('Error in CalcPathSuccessProbability. BoundaryID='+IntToStr(ID));
  end;
end;


procedure TCustomBoundary.CalcExternalDelayTime(
     out dT,  dTDisp: double; out BestTacticE:IDMElement);
var
  j, Side, NodeDirection: integer;
  ObserverE, SafeguardElementE:IDMElement;
  GuardPostSE:ISafeguardElement;
  aDelayTime, aDelayTimeDispersion:double;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  GuardPost:IGuardPost;
  Observer:IObserver;
begin
   FacilityModel:=DataModel as IFacilityModel;
   FacilityModelS:=FacilityModel as IFMState;

   NodeDirection:=FacilityModelS.CurrentNodeDirection;

  if NodeDirection=pdFrom1To0 then
    Side:=0
  else
    Side:=1;

  if FacilityModel.CurrentZoneTactics.Count>0 then
    BestTacticE:=FacilityModel.CurrentZoneTactics.Item[0]
  else
    BestTacticE:=nil;

  dT:=0;
  dTDisp:=0;
  for j:=0 to FObservers.Count-1 do begin
    ObserverE:=FObservers.Item[j];
    Observer:=ObserverE as IObserver;
    SafeguardElementE:=ObserverE.Ref;
    if (SafeguardElementE.QueryInterface(IGuardPost, GuardPost)=0) and
       (Observer.Side=Side) then begin
      GuardPostSE:=SafeguardElementE as ISafeguardElement;
      GuardPostSE.CalcDelayTime(BestTacticE, aDelayTime, aDelayTimeDispersion);

      dT:=dT+aDelayTime;
      dTDisp:=dTDisp+aDelayTimeDispersion;
    end;
  end;
end;

function TCustomBoundary.Get_Field_(Index: integer): IDMField;
var
  BoundaryKind:IBoundaryKind;
  BoundaryLayerE:IDMElement;
  N:integer;
begin
  BoundaryKind:=Ref as IBoundaryKind;
  if FBoundaryLayers.Count=1 then begin
    BoundaryLayerE:=FBoundaryLayers.Item[0];
    N:=Get_FieldCount;
    if Index<N then
      Result:=Get_Field(Index)
    else
    if Index<N+BoundaryLayerE.Get_FieldCount then
      Result:=BoundaryLayerE.Get_Field(Index-N)
    else
      Result:=nil
  end else begin
    if Index<Get_FieldCount then
      Result:=Get_Field(Index)
    else
      Result:=nil
  end;
end;

function TCustomBoundary.Get_FieldCount_: integer;
var
  BoundaryKind:IBoundaryKind;
  BoundaryLayerE:IDMElement;
  N:integer;
begin
  BoundaryKind:=Ref as IBoundaryKind;
  if FBoundaryLayers.Count=1 then begin
    BoundaryLayerE:=FBoundaryLayers.Item[0];
    N:=Get_FieldCount;
    Result:=N+BoundaryLayerE.Get_FieldCount
  end else begin
    Result:=Get_FieldCount
  end;
end;

function TCustomBoundary.Get_FieldValue_(Index: integer): OleVariant;
var
  BoundaryKind:IBoundaryKind;
  BoundaryLayerE:IDMElement;
  N:integer;
begin
  BoundaryKind:=Ref as IBoundaryKind;
  if FBoundaryLayers.Count=1 then begin
    BoundaryLayerE:=FBoundaryLayers.Item[0];
    N:=Get_FieldCount;
    if Index<N then
      Result:=Get_FieldValue(Index)
    else
    if Index<N+BoundaryLayerE.Get_FieldCount then
      Result:=BoundaryLayerE.Get_FieldValue(Index-N)
    else
      Result:=null
  end else begin
    Result:=Get_FieldValue(Index)
  end;
end;

procedure TCustomBoundary.Set_FieldValue_(Index: integer; Value: OleVariant);
var
  BoundaryKind:IBoundaryKind;
  BoundaryLayerE:IDMElement;
  N:integer;
begin
  BoundaryKind:=Ref as IBoundaryKind;
  if FBoundaryLayers.Count=1 then begin
    BoundaryLayerE:=FBoundaryLayers.Item[0];
    N:=Get_FieldCount;
    if Index<N then
      Set_FieldValue(Index, Value)
    else
    if Index<N+BoundaryLayerE.Get_FieldCount then
      BoundaryLayerE.Set_FieldValue(Index-N, Value)
  end else begin
    Set_FieldValue(Index, Value)
  end;
end;


procedure TCustomBoundary.BuildReport(ReportLevel, TabCount, Mode: Integer;
  const Report: IDMText);
var
  S, S0, MaxLenS, ModeName:WideString;
  j, j0, j1, m, WarriorPathStage:integer;
  FacilityStateE, WarriorGroupE,
  Zone0E, Zone1E:IDMElement;
  Zone0, Zone1:IZone;
  FacilityModelS:IFMState;
  FacilityModel:IFacilityModel;
  CRef0, CRef1, BoundaryLayerE,
  TacticE, Tactic1E, Tactic2E, BestTacticE:IDMElement;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerS:IElementState;
  BoundaryLayerType:IBoundaryLayerType;
  T, TDisp, MinT, MinP, SumT, ProdP:double;
  DetP:double;
  SafeguardElementE, BoundaryLayerTypeE, GuardPostE:IDMElement;
  GuardPost:IGuardPost;
  SafeguardElement:ISafeguardElement;
  SafeguardElementD:IDistantDetectionElement;
  C0, C1:ICoordNode;
  X0, Y0, Z0, X1, Y1, Z1:double;
  Line:ILine;
  F0, F1:boolean;
  OvercomeMethodE:IDMElement;
  Direction, MaxLen, Len, Len0:integer;
  UserDefinedDelayTimeFlag, UserDefinedDetectionProbabilityFlag:boolean;
  SubBoundaryE:IDMElement;
  SubBoundary:IPathElement;
  dTDisp, NoDetP, RejDetP:double;
  ObservationPeriod, UserDefinedNoDetP:double;
  BestTimeSum, BestTimeDispSum:double;
  Position:integer;


  procedure DoBoundaryLayerCalc(out T, DetP:double);
  var
    BoundaryLayer:IBoundaryLayer;
    TimeSumDispersion, BestTimeDispSum,
    NoDetP, NoFailureP:double;
    NoEvidence:WordBool;
    Position:integer;
  begin
    BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
    case WarriorPathStage of
    wpsFastEntry,
    wpsFastExit:
        BoundaryLayer.DoCalcDelayTime(TacticE, T, TimeSumDispersion, 0);
    wpsStealthEntry,
    wpsStealthExit:
      begin
        BoundaryLayer.DoCalcNoDetectionProbability(TacticE,
                      ObservationPeriod,
                      NoDetP,
                      NoFailureP,
                      NoEvidence,
                      T, BestTimeDispSum, Position, 0);
        DetP:=1-NoDetP;
      end;
    end;
  end;

  procedure MakeHeader(CommentMode:integer);
  var
    j:integer;
  begin
    S:=Format('| %-'+MaxLenS+'s', [ModeName]);
    S:=S+' |Время задержки, с';
    case WarriorPathStage of
    wpsStealthEntry,
    wpsStealthExit:
      S:=S+' |Вероятность обнаружения';
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

var
  NoFailureP:double;
  NoEvidence:WordBool;
begin
  FacilityModelS:=DataModel as IFMState;
  if FacilityModelS=nil then Exit;
  FacilityModel:=FacilityModelS as IFacilityModel;

  ModeName:=Get_ReportModeName(Mode);

  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  Direction:=FacilityModelS.CurrentNodeDirection;
  WarriorPathStage:=FacilityModelS.CurrentPathStage;
  Line:=FacilityModelS.CurrentLineU as ILine;
  if Line=nil then Exit;

  Zone0E:=Get_Zone0;
  Zone1E:=Get_Zone1;
  Zone0:=Zone0E as IZone;
  Zone1:=Zone1E as IZone;

  case WarriorPathStage of
  wpsStealthEntry,
  wpsFastEntry:
    begin
      j0:=0;
      j1:=FBoundaryLayers.Count-1;
    end;
  else
    begin
      j0:=FBoundaryLayers.Count-1;
      j1:=0;
    end;  
  end;

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

  if Zone0<>nil then
    Zone0.CalcPatrolPeriod;
  if Zone1<>nil then
    Zone1.CalcPatrolPeriod;

  Report.AddLine('');
  Report.AddLine('');

  S:='Пересечение рубежа "'+Name+'" типа "'+ Ref.Name+'"';
  Report.AddLine(S);

  if (Zone0E<>nil) and (Zone1E<>nil) then begin
    if Direction=pdFrom1To0 then
      S:='из зоны "'+Zone1E.Name+'" в зону "'+ Zone0E.Name+'"'
    else
      S:='из зоны "'+Zone0E.Name+'" в зону "'+ Zone1E.Name+'"';
  end else
  if (Zone0E<>nil) then begin
    if Direction=pdFrom1To0 then
      S:='Вход в зону "'+ Zone0E.Name+'"'
    else
      S:='Выход из зоны "'+Zone0E.Name;
  end;
  if (Zone1E<>nil) then begin
    if Direction=pdFrom0To1 then
      S:='Вход в зону "'+ Zone1E.Name+'"'
    else
      S:='Выход из зоны "'+Zone1E.Name;
  end;
  Report.AddLine(S);
  Report.AddLine('');

  case Mode of
  0:begin
      S:='"'+WarriorGroupE.Name+'"  "'+FacilityStateE.Name+'" ';
      case WarriorPathStage of
      wpsStealthEntry:
        S:=S+'Скрытное прникновение';
      wpsFastEntry:
        S:=S+'Быстрое прникновение';
      wpsStealthExit:
        S:=S+'Скрытный отход';
      wpsFastExit:
        S:=S+'Быстрый отход';
      end;

      Report.AddLine(S);
      Report.AddLine('');

      MaxLen:=Length(ModeName)+1;
      if WarriorGroupE.ClassID=_AdversaryGroup then begin
        case WarriorPathStage of
        wpsStealthEntry,
        wpsStealthExit:
          begin
          end;
        else
          begin
            for j:=0 to FObservers.Count-1 do begin
              GuardPostE:=FObservers.Item[j].Ref;
              if GuardPostE.QueryInterface(IGuardPost, GuardPost)=0 then begin
                Len:=Length(GuardPostE.Name);
                if MaxLen<Len then MaxLen:=Len;
              end;
            end;
          end;
        end;
        for j:=0 to FBoundaryLayers.Count-1 do begin
          Len:=Length(FBoundaryLayers.Item[j].Name);
          if MaxLen<Len then MaxLen:=Len;
        end;
      end;
      MaxLenS:=IntToStr(MaxLen);

      MakeHeader(0);

      if FacilityModel.CurrentZoneStealthTactics.Count=0 then Exit;
      if FacilityModel.CurrentZoneFastTactics.Count=0 then Exit;

      Tactic1E:=FacilityModel.CurrentZoneStealthTactics.Item[0];
      Tactic2E:=FacilityModel.CurrentZoneFastTactics.Item[0];

      SumT:=0;
      ProdP:=1;

        j:=j0;
        while (j-j1)*(j-j0)<=0 do begin
          BoundaryLayerE:=FBoundaryLayers.Item[j];
          BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
          BoundaryLayerS:=BoundaryLayerE as IElementState;

          MinP:=InfinitValue;
          MinT:=InfinitValue;
          BoundaryLayerTypeE:=BoundaryLayerE.Ref;
          BoundaryLayerType:=BoundaryLayerTypeE as IBoundaryLayerType;

          for m:=0 to FacilityModel.CurrentBoundaryTactics.Count-1 do begin
            TacticE:=FacilityModel.CurrentBoundaryTactics.Item[m];
            if BoundaryLayer.AcceptableTactic(TacticE) then begin
              DoBoundaryLayerCalc(T, DetP);
              case WarriorPathStage of
              wpsStealthEntry,
              wpsStealthExit:
                if MinP>DetP then begin
                  MinP:=DetP;
                  MinT:=T;
                  BestTacticE:=TacticE;
                end else
                if MinP=DetP then begin
                  if MinT>T then begin
                    MinP:=DetP;
                    MinT:=T;
                    BestTacticE:=TacticE;
                  end;
                end;
              else
                if MinT>T then begin
                  MinP:=DetP;
                  MinT:=T;
                  BestTacticE:=TacticE;
                end;
              end;
            end;
          end;

          for m:=0 to BoundaryLayer.SubBoundaries.Count-1 do begin
            SubBoundaryE:=BoundaryLayer.SubBoundaries.Item[m];
            SubBoundary:=SubBoundaryE as IPathElement;
            SubBoundary.CalcDelayTime(T, dTDisp, TacticE, 0);
            SubBoundary.CalcNoDetectionProbability(NoDetP, NoFailureP, NoEvidence,
                           BestTimeSum, BestTimeDispSum,
                           Position, BestTacticE, 0);
            DetP:=1-NoDetP;
            case WarriorPathStage of
            wpsStealthEntry,
            wpsStealthExit:
              if MinP>DetP then begin
                MinP:=DetP;
                MinT:=T;
                BestTacticE:=SubBoundaryE;  // здесь тактика - подрубеж!
              end else
              if MinP=DetP then begin
                if MinT>T then begin
                  MinP:=DetP;
                  MinT:=T;
                  BestTacticE:=SubBoundaryE;
                end;
              end;
            else
              if MinT>T then begin
                MinP:=DetP;
                MinT:=T;
                BestTacticE:=SubBoundaryE;
              end;
            end;
          end;


          S:=Format('| %-'+MaxLenS+'s', [BoundaryLayerE.Name]);
          if BestTacticE<>nil then begin
            if MinT<999999 then
              S:=S+Format(' | %6.0f',[MinT])
            else
              S:=S+' | Бескон.';
            SumT:=SumT+MinT;
            case WarriorPathStage of
            wpsStealthEntry,
            wpsStealthExit:
              begin
                S:=S+Format(' | %6.4f',[MinP]);
                ProdP:=ProdP*(1-MinP)
              end;
            end;
            if BoundaryLayerS.UserDefinedDelayTime or
               BoundaryLayerS.UserDefinedDetectionProbability then
              S:=S+' | '
            else
            if BestTacticE.ClassID=_Tactic then
              S:=S+' | '+BestTacticE.Name
            else
              S:=S+' | Проникнуть через '+BestTacticE.Name;

            case WarriorPathStage of
            wpsStealthEntry,
            wpsStealthExit:
              begin
                if BoundaryLayerS.UserDefinedDetectionProbability then
                  S:=S+' Вероятность обнаружения на слое задана пользователем';
              end;
            else
              if BoundaryLayerS.UserDefinedDelayTime then
                S:=S+' Время задержки на слое задано пользователем'
            end;

          end else begin
            S:=S+' |     - ';
            case WarriorPathStage of
            wpsStealthEntry,
            wpsStealthExit:
              S:=S+' |     - ';
            end;
            S:=S+' | '+'Не определена';

            case WarriorPathStage of
            wpsStealthEntry,
            wpsStealthExit:
              begin
                if BoundaryLayerS.UserDefinedDetectionProbability then
                  S:=S+' Вероятность обнаружения на слое задана пользователем';
              end;
            else
              if BoundaryLayerS.UserDefinedDelayTime then
                S:=S+' Время задержки на слое задано пользователем'
            end;
          end;
          Report.AddLine(S);
          if j1>=j0 then
            inc(j)
          else
            dec(j)
        end; //for j:=0 to Boundary.BoundaryLayers.Count-1

        if WarriorGroupE.ClassID=_AdversaryGroup then begin
          case WarriorPathStage of
          wpsStealthEntry,
          wpsStealthExit:
            begin
            end;
          else
            for j:=0 to FObservers.Count-1 do begin
              SafeguardElementE:=FObservers.Item[j].Ref;
              SafeguardElement:=SafeguardElementE as ISafeguardElement;
              if (SafeguardElementE.QueryInterface(IGuardPost, GuardPost)=0) and
                 SafeguardElement.IsPresent and
                 SafeguardElement.InWorkingState then begin
                SafeguardElementD:=SafeguardElementE as IDistantDetectionElement;
                F0:=SafeguardElementD.PointInDetectionZone(X0, Y0, Z0, CRef0, SpatialElement);
                F1:=SafeguardElementD.PointInDetectionZone(X1, Y1, Z1, CRef1, SpatialElement);
                if F0 or F1 then begin
                  SafeguardElement:=SafeguardElementE as ISafeguardElement;
                  SafeguardElement.CalcDelayTime(Tactic2E,
                                 T, TDisp);

                  OvercomeMethodE:=SafeguardElement.CurrOvercomeMethod;

                  S:=Format('| %-'+MaxLenS+'s', [SafeguardElementE.Name]);
                  if T<999999 then
                    S:=S+Format(' | %6.0f', [T])
                  else
                    S:=S+' | Бескон.';
                  SumT:=SumT+T;
                  if OvercomeMethodE<>nil then
                    S:=S+' | '+OvercomeMethodE.Name
                  else
                    S:=S+' | Ошибка!!!';
                  Report.AddLine(S);
                end;
              end;
            end;  //for j:=0 to GuardDelays.Count-1
          end; //case WarriorPathStage
        end; // while j<>j1

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
    end;
  1:begin
    end;
  end;
end;

function TCustomBoundary.Get_ReportModeCount: integer;
begin
  Result:=1
end;

function TCustomBoundary.Get_ReportModeName(Index: integer): WideString;
begin
  case Index of
  0: Result:='Слои рубежа';
  else
    Result:=inherited Get_ReportModeName(Index);
  end;
end;

function TCustomBoundary.Get_NeighbourDist0: double;
begin
  Result:=0
end;

function TCustomBoundary.Get_NeighbourDist1: double;
begin
  Result:=0
end;

procedure TCustomBoundary.Reset(const BaseStateE:IDMElement);
var
  BoundaryLayer:IBoundaryLayer;
  m:integer;
begin
  FBaseState:=pointer(BaseStateE);

  for m:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayer:=FBoundaryLayers.Item[m] as IBoundaryLayer;
    BoundaryLayer.Reset(BaseStateE);
  end;
end;

function TCustomBoundary.Get_WarriorPaths: IDMCollection;
begin
  Result:=FWarriorPaths;
end;

function TCustomBoundary.DoOperation(ColIndex, Index: Integer; var Param1, Param2,
  Param3: OleVariant): WordBool;
var
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  Server:IDataModelServer;
  BoundaryLayerTypes, BoundaryLayers:IDMCollection;
  V:Variant;
  DataModelE, BoundaryLayerTypeE:IDMElement;
  BoundaryKind:IBoundaryKind;
  Unk, ElementU:IUnknown;
  BoundaryKindID, j, PathKind:integer;
  OldWarriorGroupU, OldAnalysisVariantU:IUnknown;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  S:WideString;
  BoundaryPathE:IDMElement;
  BoundaryPath:IWarriorPath;
begin
  Result:=False;
  if ColIndex<>-1 then Exit;
  case Index of
  0:begin
      Document:=DataModel.Document as IDMDocument;
      DMOperationManager:=Document as IDMOperationManager;
      Server:=Document.Server;
      BoundaryKind:=Ref as IBoundaryKind;
      BoundaryLayerTypes:=BoundaryKind.BoundaryLayerTypes;

      BoundaryKindID:=Param1;
      if BoundaryKindID=-1 then begin
        Server.EventData2:='';
        Server.CallRefDialog(nil, BoundaryLayerTypes, '', True);
        if Server.EventData3=-1 then Exit;
        V:=Server.EventData1;
        if VarIsNull(V) then  Exit;
        Unk:=V;
        BoundaryLayerTypeE:=Unk as IDMElement;
        Param1:=BoundaryLayerTypes.IndexOf(BoundaryLayerTypeE);
      end else
        BoundaryLayerTypeE:=BoundaryLayerTypes.Item[BoundaryKindID];

      DataModelE:=DataModel as IDMElement;
      BoundaryLayers:=DataModelE.Collection[_BoundaryLayer];
      DMOperationManager.AddElementRef(Self as IDMElement,
           BoundaryLayers, '', BoundaryLayerTypeE, ltOneToMany, ElementU, True);
      j:=FBoundaryLayers.Count-1;
      Server.DocumentOperation(ElementU, nil, leoAdd, j);
    end;
  2:begin
      FacilityModel:=DataModel as IFacilityModel;
      FacilityModelS:=DataModel as IFMState;

      Document:=DataModel.Document as IDMDocument;
      DMOperationManager:=Document as IDMOperationManager;
      Server:=Document.Server;
      Server.EventData2:=(FacilityModel.WarriorPaths as IDMCollection2).MakeDefaultName(nil);

      OldAnalysisVariantU:=FacilityModelS.CurrentAnalysisVariantU;
      OldWarriorGroupU:=FacilityModelS.CurrentWarriorGroupU;
      try
      Server.CallDialog(20, '', '');
      PathKind:=Server.EventData3;
      if PathKind=-1 then Exit;
      S:=Server.EventData2;

      BoundaryPathE:=MakePathFrom(PathKind);
      if BoundaryPathE<>nil then begin
        BoundaryPathE.Name:=S;

        Document.State:=Document.State or dmfExecuting;
        BoundaryPathE.Parent:=Self;

        BoundaryPath:=BoundaryPathE as IWarriorPath;
        if BoundaryPath<>nil then begin
          BoundaryPath.Build(tmToRoot, True, False, nil);
          BoundaryPath.DoAnalysis(nil, True);
        end;
        Document.State:=Document.State and not dmfExecuting;
      end;  
      finally
        FacilityModelS.CurrentAnalysisVariantU:=OldAnalysisVariantU;
        FacilityModelS.CurrentWarriorGroupU:=OldWarriorGroupU;
      end;
    end;
  else
    Exit;
  end;
  Result:=True;
end;

function TCustomBoundary.GetOperationName(ColIndex, Index: Integer): WideString;
begin
    case Index of
    0:Result:='Добавить слой защиты...';
    2:Result:='Построить маршрут...';
    else
      Result:='';
    end;
end;

class procedure TCustomBoundary.MakeFields1;
begin
  inherited;
  AddField(rsFalseAlarmPeriod, '%0.4f', '', '',
                 fvtFloat,   0, 0, 0,
                 ord(bopFalseAlarmPeriod), 1, pkAdditional);
end;


procedure TCustomBoundary.ResetSoundResistance;
begin
  FSoundResistance:=-1;
  FSoundResistanceSum0:=InfinitValue;
  FSoundResistanceSum1:=InfinitValue;
end;

function TCustomBoundary.MakePathFrom(PathKind:integer):IDMElement;
var
  FacilityModel:IFacilityModel;
  DataModelE, NodeE, PathLayerE, BoundaryPathE:IDMElement;
  Reversed, UseStoredRecords:WordBool;
  Paths:IDMCollection;
  WarriorPath:IWarriorPath;
  PathNodes2:IDMCollection2;
  PathE, aPathArcE:IDMElement;
  aPathArcL:ILine;
  Node:ICoordNode;
begin
  DataModelE:=DataModel as IDMElement;
  FacilityModel:=DataModelE as IFacilityModel;
  UseStoredRecords:=True;
  Paths:=DataModelE.Collection[_Polyline];
  PathLayerE:=DataModelE.Collection[_Layer].Item[0];

  CalcVulnerability;
  case PathKind of
  pkRationalPath:
    begin
      NodeE:=Get_RationalProbabilityToTarget_NextNode;
      Reversed:=True;
      aPathArcE:=GRationalProbabilityToTarget_BestArcE;
    end;
  pkFastPath:
    begin
      NodeE:=Get_DelayTimeToTarget_NextNode;
      Reversed:=True;
      aPathArcE:=GDelayTimeToTarget_BestArcE;
    end;
  pkStealthPath:
    begin
      NodeE:=Get_NoDetectionProbabilityFromStart_NextNode;
      Reversed:=False;
      aPathArcE:=GNoDetectionProbabilityFromStart_BestArcE;
    end;
  pkGuardPathToTarget:
    begin
      NodeE:=Get_DelayTimeToTarget_NextNode;
      Reversed:=True;
      aPathArcE:=GDelayTimeToTarget_BestArcE;
    end;
  pkGuardPathFromStart:
    begin
      NodeE:=Get_DelayTimeFromStart_NextNode;
      Reversed:=False;
      aPathArcE:=GDelayTimeFromStart_BestArcE;
    end;
  else
    begin
      NodeE:=nil;
      Reversed:=False;
    end;
  end;
  if NodeE<>nil then begin
    BoundaryPathE:=nil;
    Result:=FacilityModel.MakePathFrom(NodeE, Reversed,
             PathKind, UseStoredRecords, Paths, PathLayerE,
             BoundaryPathE);

    if (Result<>nil) and
       (aPathArcE<>nil) then begin
      WarriorPath:=Result as IWarriorPath;
      PathNodes2:=WarriorPath.PathNodes as IDMCollection2;
      PathE:=Result.SpatialElement;
      aPathArcE.AddParent(PathE);
      PathNodes2.Add(NodeE);
      aPathArcL:=aPathArcE as ILine;
      Node:=NodeE as ICoordNode;
      Node:=aPathArcL.NextNodeTo(Node);
      NodeE:=Node as IDMElement;
    end;

    if PathKind=pkRationalPath then begin
//      Reversed:=True;
      Result:=FacilityModel.MakePathFrom(NodeE, False,
             pkStealthPath, UseStoredRecords, Paths, PathLayerE,
             Result);
    end;
  end else
    Result:=nil;
end;

function TCustomBoundary.GetDelayTimeFromStart(
  const WarriorGroupE: IDMElement; out DelayTime,
  DelayTimeDispersion: Double): WordBool;
begin
  Result:=False;
  if WarriorGroupE<>FAlarmGroup then Exit;

  Result:=(FAlarmGroupDelayTimeFromStart<InfinitValue);
  DelayTime:=FAlarmGroupDelayTimeFromStart;
  DelayTimeDispersion:=FAlarmGroupDelayTimeFromStartDispersion;
end;

function TCustomBoundary.GetDelayTimeToTarget(
  const WarriorGroupE: IDMElement; out DelayTime,
  DelayTimeDispersion: Double): WordBool;
begin
  Result:=False;
  if WarriorGroupE<>FAlarmGroup then Exit;

  Result:=(FAlarmGroupDelayTimeToTarget<InfinitValue);
  DelayTime:=FAlarmGroupDelayTimeToTarget;
  DelayTimeDispersion:=FAlarmGroupDelayTimeToTargetDispersion;
end;

function TCustomBoundary.Get_GuardDelayTimeFromStart: double;
begin
  Result:=FAlarmGroupDelayTimeFromStart
end;

function TCustomBoundary.Get_GuardDelayTimeFromStartDispersion: double;
begin
  Result:=FAlarmGroupDelayTimeFromStartDispersion
end;

function TCustomBoundary.Get_GuardDelayTimeToTarget: double;
begin
  Result:=FAlarmGroupDelayTimeToTarget
end;

function TCustomBoundary.Get_GuardDelayTimeToTargetDispersion: double;
begin
  Result:=FAlarmGroupDelayTimeToTargetDispersion
end;

function TCustomBoundary.Get_AlarmGroup: IDMElement;
begin
  Result:=FAlarmGroup
end;

function TCustomBoundary.Get_BattleTime: double;
begin
  Result:=FBattleTime
end;

function TCustomBoundary.Get_BattleTimeDispersion: double;
begin
  Result:=FBattleTimeDispersion
end;

function TCustomBoundary.Get_BattleVictoryProbability: double;
begin
  Result:=FBattleVictoryProbability
end;

function TCustomBoundary.GetShortCut(ColIndex, Index: Integer): WideString;
begin
  Result:='';
end;

procedure TCustomBoundary.AfterCopyFrom2;
var
  j:integer;
  BoundaryLayerE:IDMElement;
begin
  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayerE:=FBoundaryLayers.Item[j];
    BoundaryLayerE.AfterCopyFrom2;
  end
end;

function TCustomBoundary.Get_AlarmGroupArrivalTime: Double;
begin
  Result:=FAlarmGroupDelayTimeFromStart
end;

function TCustomBoundary.Get_AlarmGroupArrivalTimeDev: Double;
var
  AnalysisVariant:IAnalysisVariant;
  FacilityModelS:IFMState;
  FacilityModel:IFacilityModel;
begin
  FacilityModelS:=DataModel as  IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant.UserDefinedResponceTimeDispersionRatio then
    Result:=AnalysisVariant.ResponceTimeDispersionRatio
  else begin
    Result:=FacilityModel.ResponceTimeDispersionRatio;
  end;  
end;

function TCustomBoundary.Get_AlarmGroupDelayTime: Double;
begin

end;

function TCustomBoundary.Get_BlockGroupArrivalTime: Double;
var
  BlockGroup:IWarriorGroup;
begin
  BlockGroup:=FBlockGroup as IWarriorGroup;
  Result:=BlockGroup.ArrivalTime;
end;

function TCustomBoundary.Get_BlockGroupArrivalTimeDev: Double;
var
  AnalysisVariant:IAnalysisVariant;
  FacilityModelS:IFMState;
  FacilityModel:IFacilityModel;
begin
  FacilityModelS:=DataModel as  IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant.UserDefinedResponceTimeDispersionRatio then
    Result:=AnalysisVariant.ResponceTimeDispersionRatio
  else begin
    Result:=FacilityModel.ResponceTimeDispersionRatio;
  end;  
end;

function TCustomBoundary.Get_BlockGroupStart: Integer;
begin

end;

function TCustomBoundary.Get_DelayTimeDev: Double;
var
  FacilityModel:IFacilityModel;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModel.DelayTimeDispersionRatio
end;

function TCustomBoundary.Get_DelayTimeFast: Double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.DelayTimeFast
end;

function TCustomBoundary.Get_DelayTimeStealth: Double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.DelayTimeStealth
end;

function TCustomBoundary.Get_DetectionProbabilityFast: Double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.DetectionProbabilityFast
end;

function TCustomBoundary.Get_DetectionProbabilityStealth: Double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.DetectionProbabilityStealth
end;

function TCustomBoundary.Get_EvidenceFast: WordBool;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.EvidenceFast
end;

function TCustomBoundary.Get_EvidenceStealth: WordBool;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.EvidenceStealth
end;

function TCustomBoundary.Get_FailureProbabilityFast: Double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.FailureProbabilityFast
end;

function TCustomBoundary.Get_FailureProbabilityStealth: Double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.FailureProbabilityStealth
end;

function TCustomBoundary.Get_PointsToTarget: WordBool;
begin
  Result:=FGoalDefinding
end;

procedure TCustomBoundary.Set_PointsToTarget(Value: WordBool);
begin
  FGoalDefinding:=Value
end;

function TCustomBoundary.Get_BlockGroup: IDMElement;
begin
  Result:=FBlockGroup
end;

procedure TCustomBoundary.Set_BlockGroup(const Value: IDMElement);
begin
  FBlockGroup:=Value
end;

function TCustomBoundary.Get_IsFragile: WordBool;
begin
  Result:=(FParamFlags and pfFragile)<>0;
end;

function TCustomBoundary.GetGap: double;
var
  ModelElementType:IModelElementType;
begin
  ModelElementType:=Ref.Parent as IModelElementType;
  if ModelElementType.TypeID=btVirtual then
    Result:=20
  else
    Result:=ShoulderWidth/2;
end;

function TCustomBoundary.Get_ObservationPeriod: double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.ObservationPeriod
end;

function TCustomBoundary.Get_SingleDetectionProbabilityFast: Double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.SingleDetectionProbabilityFast
end;

function TCustomBoundary.Get_SingleDetectionProbabilityStealth: Double;
var
  WayElement:IWayElement;
begin
  WayElement:=FBoundaryLayers.Item[0] as IWayElement;
  Result:=WayElement.SingleDetectionProbabilityStealth
end;

function TCustomBoundary.Get_TacticFastU: IUnknown;
begin
  Result:=nil
end;

function TCustomBoundary.Get_TacticStealthU: IUnknown;
begin
  Result:=nil
end;

procedure TCustomBoundary.CalcObservationPeriods(
                  TryKill: boolean; T: double; out Changed:boolean);
var
  aObservationPeriod:double;
  ObserverE:IDMElement;
  SafeguardElement:ISafeguardElement;
  j:integer;
  ObservationElement:IObservationElement;
  ObservationElementES:IElementState;
  KillObsP, aNoObsP, P, BestTime, TT:double;
  Observer:IObserver;
begin
  Changed:=False;
  for j:=0 to FObservers.Count-1 do begin
    ObserverE:=FObservers.Item[j];
    Observer:=ObserverE as IObserver;
    if ObserverE.Ref.QueryInterface(IObservationElement, ObservationElement)=0 then begin
      SafeguardElement:=ObservationElement as ISafeguardElement;
      if SafeguardElement.InWorkingState then begin
        if (ObservationElement.QueryInterface(IElementState, ObservationElementES)=0) and
            ObservationElementES.UserDefinedDetectionProbability then begin
          Observer.ObservationPeriod:=-(1-ObservationElementES.DetectionProbability); // отрицательное значение
        end else begin                                                                // указывает на явно заданную верояность
          aObservationPeriod:=ObservationElement.GetObservationPeriod(0);
          Observer.ObservationPeriod:=aObservationPeriod;

          if TryKill then begin
            TT:=T/aObservationPeriod;
            SafeguardElement.CalcDetectionProbability(nil, KillObsP, BestTime);
            aNoObsP:=1-KillObsP;
            P:=exp(-TT);
            if aNoObsP>P then begin  // Может быть нарушителю выгоднее вывести наблюдателя из строя?
              Observer.ObservationPeriod:=-aNoObsP;  // отрицательное значение указывает на явно заданную верояность
              Changed:=True;  // нужно пересчитать вероятности обнаружения
            end;
          end;
        end;
      end else // if not SafeguardElement.InWorkingState
        Observer.ObservationPeriod:=-InfinitValue
    end else
      Observer.ObservationPeriod:=-InfinitValue
  end;
end;

function TCustomBoundary.CalcNoObsProbability:double;
var
  aObservationPeriod:double;
  ObserverE:IDMElement;
  j:integer;
  ObservationElement:IObservationElement;
  Observer:IObserver;
begin
  Result:=1;
  for j:=0 to FObservers.Count-1 do begin
    ObserverE:=FObservers.Item[j];
    Observer:=ObserverE as IObserver;
    if ObserverE.Ref.QueryInterface(IObservationElement, ObservationElement)=0 then begin
      aObservationPeriod:=Observer.ObservationPeriod;
      if (aObservationPeriod<0) and
         (aObservationPeriod<>-InfinitValue) then
        Result:=Result*(-aObservationPeriod);
    end;
  end;
end;

procedure TCustomBoundary.ClearCash(ClearElements: WordBool);
var
  j:integer;
  BoundaryLayer:IBoundaryLayer;
begin
  FDelayTimeFast_:=-1; // для Guard
  FParamFlags:=FParamFlags and not pfParamsCalculated;

  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayer:=FBoundaryLayers.Item[j] as IBoundaryLayer;
    BoundaryLayer.ClearCash(ClearElements);
  end;
end;

procedure TCustomBoundary.CalcParams(aAddDelay:double);
var
  m:integer;
  BoundaryLayer:IBoundaryLayer;
  PassVelocity, Gap, AddDelay:double;
  Changed:boolean;
  DelayTimeFast, DelayTimeFastDispersion, DelayTimeStealth:double;
  WayElement:IWayElement;
begin
  SetCurrentDirection;

  PassVelocity:=GetPassVelocity;
  Gap:=GetGap;
  CalcObservationPeriods(False, 0, Changed);

  DelayTimeFast:=0;
  DelayTimeFastDispersion:=0;
  DelayTimeStealth:=0;
  for m:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayer:=FBoundaryLayers.Item[m] as IBoundaryLayer;

    AddDelay:=aAddDelay;
    if m=0 then
      AddDelay:=AddDelay+Gap/PassVelocity;
    if m=FBoundaryLayers.Count-1 then
      AddDelay:=AddDelay+Gap/PassVelocity;

    BoundaryLayer.CalcParams(AddDelay);

    WayElement:=BoundaryLayer as IWayElement;
    DelayTimeFast:=DelayTimeFast+WayElement.DelayTimeFast;
    DelayTimeFastDispersion:=DelayTimeFast+WayElement.DelayTimeDev*WayElement.DelayTimeFast;
    DelayTimeStealth:=DelayTimeStealth+WayElement.DelayTimeStealth;
  end;

  CalcObservationPeriods(True, DelayTimeStealth, Changed); // пересчитываем периоды наблюдения с учетом возможности устранения наблюдателей

  if Changed then begin
    DelayTimeStealth:=0;
    for m:=0 to FBoundaryLayers.Count-1 do begin    // пересчитываем вероятности обнаружения
      BoundaryLayer:=FBoundaryLayers.Item[m] as IBoundaryLayer;

      AddDelay:=aAddDelay;
      if m=0 then
        AddDelay:=AddDelay+Gap/PassVelocity;
      if m=FBoundaryLayers.Count-1 then
        AddDelay:=AddDelay+Gap/PassVelocity;

      BoundaryLayer.CalcParams(AddDelay);

      WayElement:=BoundaryLayer as IWayElement;
      DelayTimeStealth:=DelayTimeStealth+WayElement.DelayTimeStealth;
    end;
  end;

  if DelayTimeFast>InfinitValue/1000 then
    DelayTimeFast:=InfinitValue/1000;
  if DelayTimeStealth>InfinitValue/1000 then
    DelayTimeStealth:=InfinitValue/1000;

  FDelayTimeFast_:=DelayTimeFast;
  FDelayTimeFastDispersion_:=DelayTimeFastDispersion;
  FDelayTimeStealth_:=DelayTimeStealth;

  FParamFlags:=FParamFlags or pfParamsCalculated;
end;

procedure TCustomBoundary.CalcAdversaryDelayTime(out DelayTime,
  DelayTimeDispersion: double; out BestTacticE: IDMElement;
  aAddDelay: double);
var
  m:integer;
  aDelayTime, aDelayTimeDispersion:double;
  aBestTactic1E:IDMElement;
  FacilityModelS:IFMState;
  FacilityStateE:IDMElement;
  BoundaryLayer:IBoundaryLayer;
  PassVelocity, Gap, AddDelay, dT, dTDisp:double;
begin
  SetCurrentDirection;

  FacilityModelS:=DataModel as IFMState;

  PassVelocity:=GetPassVelocity;
  Gap:=GetGap;

  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  DelayTime:=0;
  DelayTimeDispersion:=0;
  if FBoundaryLayers.Count>0 then begin
    for m:=0 to FBoundaryLayers.Count-1 do begin
      BoundaryLayer:=FBoundaryLayers.Item[m] as IBoundaryLayer;
      BoundaryLayer:=BoundaryLayer as IBoundaryLayer;

      AddDelay:=aAddDelay;
      if m=0 then
        AddDelay:=AddDelay+Gap/PassVelocity;
      if m=FBoundaryLayers.Count-1 then
        AddDelay:=AddDelay+Gap/PassVelocity;

      BoundaryLayer.CalcDelayTime(aDelayTime, aDelayTimeDispersion,
                                AddDelay);

      DelayTime:=DelayTime+aDelayTime;
      DelayTimeDispersion:=DelayTimeDispersion+aDelayTimeDispersion;
    end;
  end else begin
    DelayTime:=2*Gap/PassVelocity;
  end;  

  if DelayTime>InfinitValue/1000 then
    DelayTime:=InfinitValue/1000;

  CalcExternalDelayTime(dT, dTDisp, aBestTactic1E); // aBestTactic1E - не используется

  DelayTime:=DelayTime+dT;
  DelayTimeDispersion:=DelayTimeDispersion+dTDisp;
end;

procedure TCustomBoundary.CalcNoDetectionProbability(out NoDetP, NoFailureP: double;
        out NoEvidence: WordBool;
        out BestTimeSum, BestTimeDispSum:double;
        out Position:integer;
        out BestTacticE: IDMElement;
            aAddDelay:double);
var
  FacilityModelS:IFMState;
  theNoDetP, theNoFailureP:double;
  theNoEvidence:WordBool;
  theLineE:IDMElement;
  theLine:ILine;
  m:integer;
  DMDocument:IDMDocument;
  OldState:integer;

  PassVelocity, Gap,
  aNoDetP, aNoFailureP, AddDelay, NoObsP, aObservationPeriod, aDelayTime, TT:double;
  aNoEvidence:WordBool;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerWE:IWayElement;
begin
  SetCurrentDirection;

  try
  FacilityModelS:=DataModel as IFMState;
  theLine:=FacilityModelS.CurrentLineU as ILine;
  if theLine=nil then begin
    DMDocument:=DataModel.Document as IDMDocument;
    OldState:=DMDocument.State;
    DMDocument.State:=DMDocument.State or dmfCommiting;
    try
      theLineE:=MakeTemporyPath as IDMElement;
      FacilityModelS.CurrentLineU:=theLineE;
    finally
      DMDocument.State:=OldState;
    end;
  end;


  if not ImplicitCalcNeeded then begin 
    if CalcParamsNeeded then
      CalcParams(0); // рассчитываем все параметры для основного состояния здесь
                     //  (CalcObservationPeriods вызывается внутри)
  end;
  NoObsP:=CalcNoObsProbability; // здесь считаем вклады в обнаружение от
         // явно заданных  для наблюдателей вероятностей и от вероятностей их нейтрализации

  PassVelocity:=GetPassVelocity;
  Gap:=GetGap;

  theNoDetP:=1;
  theNoFailureP:=1;
  theNoEvidence:=True;
  for m:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayer:=FBoundaryLayers.Item[m] as IBoundaryLayer;

    if ImplicitCalcNeeded then begin
      AddDelay:=aAddDelay;
      if m=0 then
        AddDelay:=AddDelay+Gap/PassVelocity;
      if m=FBoundaryLayers.Count-1 then
        AddDelay:=AddDelay+Gap/PassVelocity;
      BoundaryLayer.CalcNoDetectionProbability(
               aNoDetP,
               aNoFailureP,
               aNoEvidence,
               BestTimeSum, BestTimeDispSum,
               Position,
               AddDelay);  // наблюдение учтено внутри
    end else begin
      BoundaryLayerWE:=BoundaryLayer as IWayElement;
      aNoDetP:=(1-BoundaryLayerWE.DetectionProbabilityStealth);

      aObservationPeriod:=BoundaryLayerWE.ObservationPeriod;
      aDelayTime:=BoundaryLayerWE.DelayTimeStealth;
      TT:=aDelayTime/aObservationPeriod;
      aNoDetP:=aNoDetP*exp(-TT);

      aNoFailureP:=1-BoundaryLayerWE.FailureProbabilityStealth;
      aNoEvidence:=not BoundaryLayerWE.EvidenceStealth
    end;
    theNoDetP:=theNoDetP*aNoDetP;
    theNoFailureP:=theNoFailureP*aNoFailureP;
    theNoEvidence:=theNoEvidence and aNoEvidence;
  end;

  NoDetP:=theNoDetP*NoObsP; // здесь учитываем нейтрализацию наблюдателей
  NoFailureP:=theNoFailureP;
  NoEvidence:=theNoEvidence;

  except
    DataModel.HandleError('Error in CalcNoDetectionProbability. BoundaryID='+IntToStr(ID));
  end
end;

function TCustomBoundary.CalcParamsNeeded: boolean;
begin
  Result:=((FParamFlags and pfParamsCalculated)=0)
end;

function TCustomBoundary.ImplicitCalcNeeded: boolean;
var
  FacilityModelS:IFMState;
  FacilityStateE:IDMElement;
begin
  FacilityModelS:=DataModel as IFMState;
  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  Result:=(((FParamFlags and pfParamsChanged)<>0) and (FBaseState<>pointer(FacilityStateE)))
end;


initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TCustomBoundary.MakeFields;
  OldDependingSafeguardElements:=TDMCollection.Create(nil) as IDMCollection;
  DependingSafeguardElements:=TDMCollection.Create(nil) as IDMCollection;
  OldDependingSafeguardElements2:=OldDependingSafeguardElements as IDMCollection2;
  DependingSafeguardElements2:=DependingSafeguardElements as IDMCollection2;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
  OldDependingSafeguardElements:=nil;
  DependingSafeguardElements:=nil;
  OldDependingSafeguardElements2:=nil;
  DependingSafeguardElements2:=nil;
  GDelayTimeToTarget_BestArcE:=nil;
  GDelayTimeFromStart_BestArcE:=nil;
  GRationalProbabilityToTarget_BestArcE:=nil;
  GBackPathRationalProbability_BestArcE:=nil;
  GNoDetectionProbabilityFromStart_BestArcE:=nil;;

end.
