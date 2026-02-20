unit CustomFacilityModelU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj, DM_ActiveX, DM_Windows,
  Classes, SysUtils, StdVcl, Math,
  FacilityModelLib_TLB,
  DMElementU, SorterU, DataModelU, CustomSpatialModelU, DataModel_TLB, PainterLib_TLB,
  DMServer_TLB, SpatialModelLib_TLB, SgdbLib_TLB,
  SafeguardSynthesisLib_TLB, BattleModelLib_TLB,
  Variants;

const
  mpkView    =2;
  mpkBuild   =4;
  mpkAnalysis=8;
  mpkPrice   =16;
  mpkCurrent =256;


type
  TBoundariesZSorter=class (TSorter)
  protected
    function Compare(const Key1, Key2:IDMElement):integer; override; safecall;
  end;

  TBoundariesDSorter=class (TSorter)
  protected
    function Compare(const Key1, Key2:IDMElement):integer; override; safecall;
  end;

  TDelayedGuardArrivalTimeSorter=class(TSorter)
  protected
    function Compare(const Key1, Key2:IDMElement):integer; override; safecall;
  end;

  TCustomFacilityModel = class(TCustomSpatialModel, IFacilityModel,
      IVulnerabilityMap,IDMClassCollections, IFMState, IStairBuilder,
      IGlobalData, IGuardModel)
  private
    FEnviroments:IDMElement;
    FCurrentState: IDMElement;
    FCurrentPathArc:IDMElement;
    FCurrentTactic:IDMElement;

    FShowOptimalPathFromBoundary:boolean;
    FShowFastPathFromBoundary:boolean;
    FShowStealthPathToBoundary:boolean;
    FShowFastGuardPathToBoundary:boolean;
    FShowOptimalPathFromStart:boolean;
    FShowGraph: boolean;
    FShowText: boolean;
    FShowSymbols: boolean;
    FShowWalls: boolean;
    FShowDetectionZones: boolean;
    FShowOnlyBoundaryAreas: boolean;

    FBoundariesOrdered:boolean;
    FUseBattleModel: boolean;
    FUseSimpleBattleModel: boolean;
    FFindCriticalPointsFlag: boolean;
    FCalcOptimalPathFlag:boolean;
    FBuildAllVerticalWays:boolean;
    FDelayTimeDispersionRatio: Double;
    FZoneDelayTimeDispersionRatio: Double;
    FResponceTimeDispersionRatio: Double;
    FFalseAlarmPeriod:double;
    FDefaultReactionMode:integer;
    FCriticalFalseAlarmPeriod:double;

    FBuildSectorLayer:Variant;
    FReliefLayer:Variant;
    FVerticalBoundaryLayer:Variant;
    FUserDefinedPathLayer:Variant;

    FExtraTargets:IDMCollection;
    FCurrentBoundaryStealthTactics: IDMCollection;
    FCurrentZoneStealthTactics: IDMCollection;
    FCurrentBoundaryFastTactics: IDMCollection;
    FCurrentZoneFastTactics: IDMCollection;
    FErrors: IDMCollection;
    FWarnings: IDMCollection;
    FBackRefHolders: IDMCollection;
    FUserDefinedElements: IDMCollection;

    FLastSubStateIndex:integer;

    FBattleModel:IDataModel;
    FSafeguardSynthesis:IDataModel;

    FCurrencyRate: Double;
    FPriceCoeffD: Double;
    FPriceCoeffTZSR: Double;
    FPriceCoeffPNR: Double;
    FTotalEfficiencyCalcMode:integer;
    FTotalPrice: Double;
    FTotalEfficiency:Double;
    FEmptyBackRefHolder:IDMElement;
    FUpdateDependingElementsBestMethodsFlag:boolean;

    FCurrentWarriorGroup: IDMElement;
    FCurrentFacilityState: IDMElement;
    FCurrentLine: IDMElement;
    FCurrentSafeguardElement: IDMElement;
    FCurrentZone0: IDMElement;
    FCurrentZone1: IDMElement;
    FCurrentBoundary0: IDMElement;
    FCurrentBoundary1: IDMElement;
    FCurrentAnalysisVariant: IDMElement;
    FCurrentPathStage: Integer;
    FCurrentNodeDirection: Integer;
    FCurrentDirectPathFlag: boolean;
    FCurrentReactionTime: Double;
    FCurrentReactionTimeDispersion: Double;
    FCurrentPatrolPeriod: Double;
    FCurrentPathArcKind: Integer;
    FForceTacticEnabled:boolean;
    FTotalBackPathDelayTime:double;
    FTotalBackPathDelayTimeDispersion:double;
    FDelayFlag:boolean;

    FZSortedBoundaries:IDMCollection;
    FDSortedBoundaries:IDMCollection;

    FClassCollectionIndexes0:TList;
    FClassCollectionIndexes_:TList;

    FGraphColor: Integer;
    FFastPathColor: Integer;
    FStealthPathColor: Integer;
    FRationalPathColor: Integer;
    FGuardPathColor: Integer;
    FMaxBoundaryDistance: Double;
    FMaxPathAlongBoundaryDistance: Double;
    FPathHeight: Double;
    FShoulderWidth: Double;

    FDefaultOpenZoneHeight:double;

    FShowSingleLayer:boolean;

    FStairTurnAngle: Integer;
    FStairLandingCount: Integer;
    FStairLandingWidth: Double;
    FStairWidth: Double;
    FStairLayer: IDMElement;

    FGlobalValue: array[1..10] of double;
    FGlobalIntf: array[1..10] of pointer;

    FGuardArrivals:IDMCollection;
    FVerificationGroups:IDMCollection;
    FAdversaryPotentialSum: Double;

    procedure UpdateCurrentTactics;
  protected
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code: Integer; var aCollection: IDMCollection); override; safecall;
    procedure AfterLoading2; override;

    function  Get_FieldCategoryCount:integer; override;
    function  Get_FieldCategory(Index:integer):WideString; override;

// методы IDataModel
    function  Get_RootObjectCount(Mode:integer): Integer; override; safecall;
    procedure GetRootObject(Mode, RootIndex: Integer; out RootObject: IUnknown;
                            out RootObjectName: WideString; out aOperations: Integer;
                            out aLinkType: Integer); override; safecall;
    function GetDefaultParent(ClassID:integer): IDMElement; override; safecall;
    procedure HandleError(const ErrorMessage:WideString); override; safecall;

    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function Get_SubModel(Index: integer): IDataModel; override; safecall;
    procedure Init; override;
    function Get_Errors:IDMCollection; override;safecall;
    function Get_Warnings:IDMCollection; override;safecall;
    procedure BeforePaste; override; safecall;
    procedure AfterPaste; override; safecall;
    function  CreateCollection(aClassID:integer; const aParent:IDMElement): IDMCollection; override; safecall;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    function  Get_CurrentState: IDMElement; override; safecall;
    procedure Set_CurrentState(const Value: IDMElement); override; safecall;
    function Get_CurrentTactic: IDMElement; safecall;
    procedure Set_CurrentTactic(const Value: IDMElement); safecall;
    function Get_CurrentPathArc: IDMElement; safecall;
    procedure Set_CurrentPathArc(const Value: IDMElement); safecall;
    function Get_Boundaries: IDMCollection; safecall;
    function Get_TechnicalServices: IDMCollection; safecall;
    function Get_BoundaryLayers: IDMCollection; safecall;
    function Get_BoundaryLayerStates: IDMCollection; safecall;
    function Get_BoundaryStates: IDMCollection; safecall;
    function Get_FacilityStates: IDMCollection; safecall;
    function Get_FacilitySubStates: IDMCollection; safecall;
    function Get_SafeguardElementStates: IDMCollection; safecall;
    function Get_ZoneStates: IDMCollection; safecall;
    function Get_WarriorPaths: IDMCollection; safecall;
    function Get_Roads: IDMCollection; safecall;
    function Get_Zones: IDMCollection; safecall;
    function Get_AccessControls: IDMCollection; safecall;
    function Get_ActiveSafeguards: IDMCollection; safecall;
    function Get_BarrierFixtures: IDMCollection; safecall;
    function Get_Barriers: IDMCollection; safecall;
    function Get_BarrierSensors: IDMCollection; safecall;
    function Get_Cabels: IDMCollection; safecall;
    function Get_ContrabandSensors: IDMCollection; safecall;
    function Get_CommunicationDevices: IDMCollection; safecall;
    function Get_Conveyances: IDMCollection; safecall;
    function Get_GuardGroups: IDMCollection; safecall;
    function Get_GuardPosts: IDMCollection; safecall;
    function Get_GuardVariants: IDMCollection; safecall;
    function Get_Weapons: IDMCollection; safecall;
    function Get_LightDevices: IDMCollection; safecall;
    function Get_Jumps: IDMCollection; safecall;
    function Get_LocalPointObjects: IDMCollection; safecall;
    function Get_Locks: IDMCollection; safecall;
    function Get_UndergroundObstacles: IDMCollection; safecall;
    function Get_GroundObstacles: IDMCollection; safecall;
    function Get_FenceObstacles: IDMCollection; safecall;
    function Get_PatrolPaths: IDMCollection; safecall;
    function Get_PerimeterSensors: IDMCollection; safecall;
    function Get_PositionSensors: IDMCollection; safecall;
    function Get_PowerSources: IDMCollection; safecall;
    function Get_SignalDevices: IDMCollection; safecall;
    function Get_StartPoints: IDMCollection; safecall;
    function Get_SurfaceSensors: IDMCollection; safecall;
    function Get_Targets: IDMCollection; safecall;
    function Get_TVCameras: IDMCollection; safecall;
    function Get_VolumeSensors: IDMCollection; safecall;
    function Get_Athorities: IDMCollection; safecall;
    function Get_AdversaryGroups: IDMCollection; safecall;
    function Get_Skills: IDMCollection; safecall;
    function Get_Tools: IDMCollection; safecall;
    function Get_AdversaryVariants: IDMCollection; safecall;
    function Get_Vehicles: IDMCollection; safecall;
    function Get_AnalysisVariants: IDMCollection; virtual; safecall;
    function Get_WarriorPathElements: IDMCollection; safecall;
    function Get_Connections: IDMCollection; safecall;
    function Get_ControlDevices: IDMCollection; safecall;
    function Get_CriticalPoints: IDMCollection; safecall;
    function Get_OvercomingBoundaries: IDMCollection; safecall;
    function FindSeparatingAreas(C0X, C0Y, C0Z, C1X, C1Y, C1Z: Double;
      const C0Ref, C1Ref: IDMElement; WhileTransparent: Integer;
      const SeparatingAreas: IDMCollection; var TransparencyCoeff: Double;
      const ExcludeArea0E, ExcludeArea1E: IDMElement): WordBool; safecall;
    function Get_SafeguardDatabase: IUnknown; safecall;
    procedure Set_SafeguardDatabase(const Value: IUnknown); safecall;
    procedure GetRefElementParent(ClassID, OperationCode: Integer; PX: Double; PY: Double; PZ: Double;
                                  out aParent: IDMElement;
                                  out DMClassCollections:IDMClassCollections;
                                  out RefSource, aCollection: IDMCollection); override; safecall;
    procedure GetDefaultAreaRefRef(const VolumeE: IDMElement; Mode: Integer;
                               BaseVolumeFlag:WordBool;
                               out aCollection: IDMCollection; out aName: WideString;
                               out AreaRefRef: IDMElement); override; safecall;
    function Get_ExtraTargets:IDMCollection; safecall;
    function  Get_BackRefHolders: IDMCollection; override; safecall;
    function Get_EmptyBackRefHolder:IDMElement; override; safecall;
    procedure Set_EmptyBackRefHolder(const Value: IDMElement); override; safecall;


    procedure UpdateVolumes; override; safecall;
    procedure MakeVolumeOutline(const Volume:IVolume; const aCollection:IDMCollection); override; safecall;
    procedure CalcVolumeMinMaxZ(const Volume:IVolume); override; safecall;

    procedure CorrectErrors; override; safecall;
    procedure CheckErrors; override; safecall;

// IVulnerabilityMap
    function  Get_ShowOptimalPathFromBoundary: WordBool; safecall;
    procedure Set_ShowOptimalPathFromBoundary(Value: WordBool); safecall;
    function  Get_ShowFastPathFromBoundary: WordBool; safecall;
    procedure Set_ShowFastPathFromBoundary(Value: WordBool); safecall;
    function  Get_ShowStealthPathToBoundary: WordBool; safecall;
    procedure Set_ShowStealthPathToBoundary(Value: WordBool); safecall;
    function  Get_ShowFastGuardPathToBoundary: WordBool; safecall;
    procedure Set_ShowFastGuardPathToBoundary(Value: WordBool); safecall;
    function  Get_ShowOptimalPathFromStart: WordBool; safecall;
    procedure Set_ShowOptimalPathFromStart(Value: WordBool); safecall;
    function  Get_ShowGraph: WordBool; safecall;
    procedure Set_ShowGraph(Value: WordBool); safecall;
    function  Get_ShowText: WordBool; safecall;
    procedure Set_ShowText(Value: WordBool); safecall;
    function  Get_ShowSymbols: WordBool; safecall;
    procedure Set_ShowSymbols(Value: WordBool); safecall;
    function  Get_ShowWalls: WordBool; safecall;
    procedure Set_ShowWalls(Value: WordBool); safecall;
    function  Get_ShowDetectionZones: WordBool; safecall;
    procedure Set_ShowDetectionZones(Value: WordBool); safecall;
    function  Get_ShowOnlyBoundaryAreas: WordBool; safecall;

    function  Get_DefaultReactionMode:integer; safecall;

//IDMClassCollection
    function  Get_ClassCount(Mode: Integer): Integer; safecall;
    function  Get_ClassCollection(Index: Integer; Mode: Integer): IDMCollection; safecall;
    function Get_DefaultClassCollectionIndex(Index, Mode: Integer): Integer; safecall;
    procedure Set_DefaultClassCollectionIndex(Index, Mode: Integer; Value: Integer); safecall;
//  защищенные методы
    procedure MakeCollections; override;
    procedure MakeFieldValues; override;
    function Get_Enviroments: IDMElement; safecall;

    procedure Loaded;override;  safecall;
    procedure LoadedFromDataBase(const aDataBaseU: IUnknown);override;  safecall;
    function GetSmallestZone(WX, WY, WZ: Double): IZone;
    function Get_CurrentBoundaryTactics: IDMCollection; safecall;
    function Get_CurrentZoneTactics: IDMCollection; safecall;
    function Get_UserDefinedPaths: IDMCollection; safecall;
    function Get_Accesses: IDMCollection; safecall;
    function Get_DelayTimeDispersionRatio: Double; safecall;
    function Get_ResponceTimeDispersionRatio: Double; safecall;
    procedure Set_DelayTimeDispersionRatio(Value: Double); safecall;
    procedure Set_ResponceTimeDispersionRatio(Value: Double); safecall;
    function Get_BattleModel: IUnknown; safecall;
    procedure Set_BattleModel(const Value: IUnknown); safecall;

    function Get_BuildSectorLayer: IDMElement; safecall;
    procedure Set_BuildSectorLayer(const Value: IDMElement); safecall;
    function Get_ReliefLayer: IDMElement; override; safecall;
    procedure Set_ReliefLayer(const Value: IDMElement); override;  safecall;
    function Get_UserDefinedPathLayer: IDMElement; safecall;
    procedure Set_UserDefinedPathLayer(const Value: IDMElement); safecall;

    function GetVolumeContaining(PX, PY, PZ: Double): IVolume; override; safecall;
    procedure Set_DefaultReactionMode(Value: Integer); safecall;
    function Get_FalseAlarmPeriod: Double; safecall;
    procedure CalcFalseAlarmPeriod(const FacilityStateE: IDMElement); safecall;
    function Get_CriticalFalseAlarmPeriod: Double; safecall;
    procedure Set_CriticalFalseAlarmPeriod(Value: Double); safecall;
    procedure Set_FalseAlarmPeriod(Value: Double); safecall;
    procedure CheckVolumeContent(const NewVolumes:IDMCollection;
                                 const Volume:IVolume;
                                 Mode:integer); override; safecall;
    function CanDeleteNow(const aElement:IDMElement;
                          const DeleteCollection:IDMCollection):WordBool; override; safecall;
    function Get_UserDefinedElements: IDMCollection; safecall;
    function Get_UseBattleModel: WordBool; safecall;
    procedure Set_UseBattleModel(Value: WordBool); safecall;

    function Get_BuildAllVerticalWays: WordBool; safecall;
    procedure Set_BuildAllVerticalWays(Value: WordBool); safecall;
    function Get_CalcOptimalPathFlag: WordBool; safecall;
    procedure Set_CalcOptimalPathFlag(Value: WordBool); safecall;
    function Get_CurrencyRate: Double; safecall;
    function Get_PriceCoeffD: Double; safecall;
    function Get_PriceCoeffTZSR: Double; safecall;
    procedure Set_CurrencyRate(Value: Double); safecall;
    procedure Set_PriceCoeffD(Value: Double); safecall;
    procedure Set_PriceCoeffTZSR(Value: Double); safecall;
    function Get_PriceCoeffPNR: Double; safecall;
    procedure Set_PriceCoeffPNR(Value: Double); safecall;
    function Get_SafeguardSynthesis: IDataModel; safecall;
    function Get_FMRecomendations: IDMCollection; safecall;
    procedure CalcEfficiency; safecall;
    function Get_TotalEfficiencyCalcMode: Integer; safecall;
    procedure Set_TotalEfficiencyCalcMode(Value: Integer); safecall;
    function Get_TotalEfficiency: Double; safecall;
    function Get_TotalPrice: Double; safecall;
    procedure CalcPrice(ModificationStage: Integer); safecall;
    procedure MakeRecomendations; safecall;
    procedure MakePersistant; safecall;
    function Get_FindCriticalPointsFlag: WordBool; safecall;
    procedure Set_FindCriticalPointsFlag(Value: WordBool); safecall;
    function Get_CurrentZoneFastTactics: IDMCollection; safecall;
    function Get_CurrentZoneStealthTactics: IDMCollection; safecall;
    function Get_UpdateDependingElementsBestMethodsFlag: WordBool; safecall;
    procedure Set_UpdateDependingElementsBestMethodsFlag(Value: WordBool); safecall;

// IFMState

    function  Get_CurrentWarriorGroupU: IUnknown; safecall;
    procedure Set_CurrentWarriorGroupU(const Value: IUnknown); safecall;
    function  Get_CurrentFacilityStateU: IUnknown; safecall;
    procedure Set_CurrentFacilityStateU(const Value: IUnknown); safecall;
    function  Get_CurrentLineU: IUnknown; safecall;
    procedure Set_CurrentLineU(const Value: IUnknown); safecall;
    procedure Set_CurrentSafeguardElementU(const Value: IUnknown); safecall;
    function  Get_CurrentSafeguardElementU: IUnknown; safecall;
    function  Get_CurrentZone0U: IUnknown; safecall;
    procedure Set_CurrentZone0U(const Value: IUnknown); safecall;
    function  Get_CurrentZone1U: IUnknown; safecall;
    procedure Set_CurrentZone1U(const Value: IUnknown); safecall;
    function  Get_CurrentBoundary0U: IUnknown; safecall;
    procedure Set_CurrentBoundary0U(const Value: IUnknown); safecall;
    function  Get_CurrentBoundary1U: IUnknown; safecall;
    procedure Set_CurrentBoundary1U(const Value: IUnknown); safecall;
    function  Get_CurrentTacticU: IUnknown; safecall;
    procedure Set_CurrentTacticU(const Value: IUnknown); safecall;
    function  Get_CurrentPathStage: Integer; safecall;
    procedure Set_CurrentPathStage(Value: Integer); safecall;
    function  Get_CurrentNodeDirection: Integer; safecall;
    procedure Set_CurrentNodeDirection(Value: Integer); safecall;
    function  Get_CurrentDirectPathFlag: WordBool; safecall;
    procedure Set_CurrentDirectPathFlag(Value: WordBool); safecall;
    function  Get_CurrentReactionTime: Double; safecall;
    procedure Set_CurrentReactionTime(Value: Double); safecall;
    function  Get_CurrentReactionTimeDispersion: Double; safecall;
    procedure Set_CurrentReactionTimeDispersion(Value: Double); safecall;
    function  Get_CurrentPatrolPeriod: Double; safecall;
    procedure Set_CurrentPatrolPeriod(Value: Double); safecall;
    function  Get_CurrentAnalysisVariantU: IUnknown; safecall;
    procedure Set_CurrentAnalysisVariantU(const Value: IUnknown); safecall;
    function  Get_CurrentPathArcKind: Integer; safecall;
    procedure Set_CurrentPathArcKind(Value: Integer); safecall;
    function  Get_CurrentDistance: double; virtual; safecall;
    procedure Set_CurrentDistance(Value:double); virtual; safecall;
    function  Get_ForceTacticEnabled:WordBool; safecall;
    procedure Set_ForceTacticEnabled(Value:WordBool); safecall;
    function  Get_TotalBackPathDelayTime: Double; safecall;
    procedure Set_TotalBackPathDelayTime(Value: Double); safecall;
    function  Get_TotalBackPathDelayTimeDispersion: Double; safecall;
    procedure Set_TotalBackPathDelayTimeDispersion(Value: Double); safecall;
    function  Get_DelayFlag:WordBool; safecall;
    procedure Set_DelayFlag(Value:WordBool);safecall;
    function AcceptableTactic(const TacticE, WarriorGroupE,
      BoundaryLayerTypeE: IDMElement; WarriorPathStage: Integer): WordBool;
      safecall;
    function Get_AreasOrdered: WordBool; override; safecall;
    procedure Set_AreasOrdered(Value: WordBool); override; safecall;
    function Get_FastPathColor: Integer; safecall;
    function Get_GuardPathColor: Integer; safecall;
    function Get_MaxBoundaryDistance: Double; safecall;
    function Get_MaxPathAlongBoundaryDistance: Double; safecall;
    function Get_PathHeight: Double; safecall;
    function Get_RationalPathColor: Integer; safecall;
    function Get_ShoulderWidth: Double; safecall;
    function Get_StealthPathColor: Integer; safecall;
    procedure Set_FastPathColor(Value: Integer); safecall;
    procedure Set_GuardPathColor(Value: Integer); safecall;
    procedure Set_MaxBoundaryDistance(Value: Double); safecall;
    procedure Set_MaxPathAlongBoundaryDistance(Value: Double); safecall;
    procedure Set_PathHeight(Value: Double); safecall;
    procedure Set_RationalPathColor(Value: Integer); safecall;
    procedure Set_ShoulderWidth(Value: Double); safecall;
    procedure Set_StealthPathColor(Value: Integer); safecall;
    function Get_GraphColor: Integer; safecall;
    procedure Set_GraphColor(Value: Integer); safecall;
    procedure Reset(const BaseStateE: IDMElement); safecall;


    procedure GetUpperLowerVolumeParams(const VolumeRef: IDMElement;
                                        out UpperZoneKindE: IDMElement;
                                        out LowerZoneKindE: IDMElement;
                                        out VolumeHeight: Double;
                                        out UpperVolumeHeight: Double;
                                        out LowerVolumeHeight: Double;
                                        out UpperVolumeUseSpecLayer: WordBool;
                                        out LowerVolumeUseSpecLayer: WordBool;
                                        out TopAreaUseSpecLayer: WordBool); override; safecall;
    function Get_VerticalBoundaryLayer: IDMElement; override; safecall;
    procedure Set_VerticalBoundaryLayer(const Value: IDMElement); override; safecall;
    function GetColVolumeContaining(PX: Double; PY: Double; PZ: Double;
                                    const ColAreas: IDMCollection; const Volumes: IDMCollection): WordBool; override; safecall;
    procedure GetInnerVolumes(const VolumeE: IDMElement; const InnerVolumes: IDMCollection); override; safecall;
    function  GetOuterVolume(const VolumeE: IDMElement):IDMElement; override; safecall;
    function Get_DefaultOpenZoneHeight: Double; safecall;
    function Get_ShowSingleLayer: WordBool; safecall;
    procedure Set_ShowSingleLayer(Value: WordBool); safecall;
    function Get_ZoneDelayTimeDispersionRatio: Double; safecall;
    procedure Set_ZoneDelayTimeDispersionRatio(Value: Double); safecall;

// IStairBuilder
    function Get_StairTurnAngle: Integer; safecall;
    procedure Set_StairTurnAngle(Value: Integer); safecall;
    function Get_StairLandingCount: Integer; safecall;
    procedure Set_StairLandingCount(Value: Integer); safecall;
    function Get_StairLandingWidth: Double; safecall;
    procedure Set_StairLandingWidth(Value: Double); safecall;
    function Get_StairWidth: Double; safecall;
    procedure Set_StairWidth(Value: Double); safecall;
    procedure BuildStair; safecall;
    function Get_StairLayer: IDMElement; safecall;
    procedure Set_StairLayer(const Value: IDMElement); safecall;
    procedure Set_DefaultOpenZoneHeight(Value: Double); safecall;
    function MakePathFrom(const NodeE: IDMElement; Reversed: WordBool;
      PathKind: Integer; UseStoredRecords: WordBool;
      const Paths: IDMCollection; const PathLayerE: IDMElement;
      var WarriorPathE: IDMElement): IDMElement; safecall;
    function Get_UseSimpleBattleModel: WordBool; safecall;
    procedure Set_UseSimpleBattleModel(Value: WordBool); safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
// IGlobalData
    function Get_GlobalValue(Index:integer):double; safecall;
    procedure Set_GlobalValue(Index:integer; Value:double); safecall;
    function Get_GlobalIntf(Index:integer):IUnknown; safecall;
    procedure Set_GlobalIntf(Index:integer; const Value:IUnknown); safecall;

//IGuardModel
    function Get_GuardArrivals:IDMCollection; safecall;
    function Get_AlarmGroups:IDMCollection; safecall;
    function Get_AdversaryPotentialSum: Double; safecall;
    procedure Set_AdversaryPotentialSum(Value: Double); safecall;
    procedure CalcResponceTime(VGroupTimeFromStart,
                               VGroupTimeToTarget, VGroupTimeToTargetDispersion: Double;
                         const VGroupE: IDMElement; GoalDefindingBoundary:WordBool;
                           out theGroupTimeToTarget, theGroupTimeToTargetDisp: Double;
                           out theGroupE:IDMElement); safecall;
  end;

  TFMRecomendationSorter=class(TSorter)
  protected
    function  Get_Duplicates: WordBool; override; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

  TErrorSorter=class(TSorter)
  private
  protected
    function  Get_Duplicates: WordBool; override; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  public
  end;



  procedure InitCash;

implementation

uses
  SafeguardElementU,
  ElementStateU,
  FacilityModelConstU,
  ZoneU,
  BoundaryU,
  BoundaryLayerU,
  FacilityStateU,
  FacilitySubStateU,
  BoundaryStateU,
  ZoneStateU,
  BoundaryLayerStateU,
  SafeguardElementStateU,
  WarriorPathU,
  WarriorPathElementU,
  BarrierU,
//  BarrierFixtureU,
  LockU,
  UndergroundObstacleU,
  FenceObstacleU,
  GroundObstacleU,
  ActiveSafeguardU,
  SurfaceSensorU,
  PositionSensorU,
  VolumeSensorU,
  BarrierSensorU,
  PerimeterSensorU,
  ContrabandSensorU,
  AccessControlU,
  TVCameraU,
  LightDeviceU,
  CommunicationDeviceU,
//  SignalDeviceU,
//  PowerSourceU,
  CabelU,
  ConnectionU,
  GuardPostU,
  PatrolPathU,
  TargetU,
  ControlDeviceU,
  LocalPointObjectU,
  JumpU,
  StartPointU,
  GuardVariantU,
  GuardGroupU,
  AdversaryVariantU,
  AdversaryGroupU,
  WeaponU,
  ToolU,
  VehicleU,
  SkillU,
  AthorityU,
  AnalysisVariantU,
  FMErrorU,
  RoadU,
  TechnicalServiceU,
  UserDefinedPathU,
  GlobalZoneU,
  AccessU,
  CriticalPointU,
  FMRecomendationU,
  GuardArrivalU,
  StairBuilderU,
  ElementParameterValueU,
  ControlDeviceAccessU,
  GuardPostAccessU,
  SubBoundaryU,
  OvercomingBoundaryU,
  ObserverU,
  GuardGroupStateU;

var
  FFields:IDMCollection;
  CashC0X, CashC0Y, CashC0Z, CashC1X, CashC1Y, CashC1Z: Double;
  CashWhileTransparent: Integer;
  CashExcludeArea0P, CashExcludeArea1P: pointer;
  CashTransparencyCoeff: Double;
  CashSeparatingAreaList: TList;
  CashFindSeparatingAreasResult:boolean;
  GuardArrivalTimeSorter, ErrorSorter:ISorter;

{ TCustomFacilityModel }

procedure TCustomFacilityModel.Draw(const aPainter: IInterface;
  DrawSelected: integer);

var
  Painter:IPainter;
  Layers:IDMCollection;

  procedure DoDraw(const DMCollection:IDMCollection; DrawSelected:integer);
  var
    j:integer;
    Element:IDMElement;
  begin
    try
    for j:=0 to DMCollection.Count-1 do  begin
      if FDrawThreadTerminated then Exit;

      Element:=DMCollection.Item[j];
      if not Element.Selected then begin
        if Painter.UseLayers and
           (Element.SpatialElement<>nil)then
          Painter.LayerIndex:=Layers.IndexOf(Element.SpatialElement.Parent);
        Element.Draw(aPainter, DrawSelected);
      end;
    end
    except
      HandleError('Error in TCustomFacilityModel.Draw');
    end;
  end;

var
  aDocument:IDMDocument;
  Paths:IDMCollection;
  aSpatialModel:ISpatialModel;
  BattleModelE:IDMElement;
  AnalysisVariant:IAnalysisVariant;
  ZSortedBoundaries2, DSortedBoundaries2:IDMCollection2;
  Boundaries:IDMCollection;
  BoundaryE:IDMElement;
  j:integer;
  Sorter:ISorter;
begin
  if Get_Document=nil then Exit;
  inherited;
  Painter:=aPainter as IPainter;
  Layers:=Get_Layers;

  if Get_DrawOrdered and
    not FBoundariesOrdered then begin
    FBoundariesOrdered:=True;
    Boundaries:=Get_Boundaries;
    ZSortedBoundaries2:=FZSortedBoundaries as IDMCollection2;
    DSortedBoundaries2:=FDSortedBoundaries as IDMCollection2;
    ZSortedBoundaries2.Clear;
    DSortedBoundaries2.Clear;
    for j:=0 to Boundaries.Count-1 do begin
      BoundaryE:=Boundaries.Item[j];
      ZSortedBoundaries2.Add(BoundaryE);
      DSortedBoundaries2.Add(BoundaryE);
    end;
    Sorter:=TBoundariesZSorter.Create(nil) as ISorter;
    ZSortedBoundaries2.Sort(Sorter);
    Sorter:=TBoundariesDSorter.Create(nil) as ISorter;
    DSortedBoundaries2.Sort(Sorter);
  end;

  if Get_DrawOrdered then begin
    if Painter.HHeight>20 then begin
      Painter.Mode:=1;
      DoDraw(FZSortedBoundaries, 0);
    end;
    if Painter.VHeight>20 then begin
      Painter.Mode:=2;
      DoDraw(FDSortedBoundaries, 0);
    end;
    Painter.Mode:=0;
  end else begin
    Painter.Mode:=0;
    DoDraw(Get_Boundaries, 0);
  end;
  
  DoDraw(Get_Zones, 2); // 2 - рисовать только средства охраны
  DoDraw(Get_Roads, 0);
  DoDraw(Get_Cabels, 0);
  DoDraw(Get_UserDefinedPaths, 0);
  DoDraw(Get_WarriorPaths, 0);
  DoDraw(Get_PatrolPaths, 0);

  AnalysisVariant:=FCurrentAnalysisVariant as IAnalysisVariant;
  if (FCurrentAnalysisVariant<>nil) and
    FShowOptimalPathFromStart and
    (AnalysisVariant.WarriorPaths.Count>0) then
       AnalysisVariant.WarriorPaths.Item[0].Draw(aPainter, DrawSelected);
//  DoDraw(FCurrentAnalysisVariant.WarriorPaths, 0);
  DoDraw(Get_Jumps, 0);
  if FShowGraph then begin
    aDocument:=Get_Document as IDMDocument;
    aSpatialModel:=(aDocument.Analyzer as ISpatialModel);
    if aSpatialModel<>nil then begin
      Paths:=aSpatialModel.Lines;
      DoDraw(Paths, 0);
    end;
  end;
  DoDraw(Get_AdversaryGroups, 2);
  DoDraw(Get_GuardGroups, 2);

  BattleModelE:=Get_BattleModel as IDMElement;
  if BattleModelE<>nil then
    DoDraw(BattleModelE.Collection[1], 2);
end;

function TCustomFacilityModel.Get_SubModel(Index: integer): IDataModel;
begin
  case Index of
  0:  Result:=Self;
  1:  Result:=Self;
  2:  Result:=Ref as IDataModel;
  3:  Result:=Self;
  4:  Result:=Self;
  5:  Result:=Self;
  else
      Result:=inherited Get_SubModel(Index);
  end;
end;

function TCustomFacilityModel.Get_RootObjectCount(Mode:integer): Integer;
begin
  case Mode of
  1: Result:=2;
  2: Result:=1;
  3: Result:=3;
  else
    Result:=inherited Get_RootObjectCount(Mode);
  end;
end;

procedure TCustomFacilityModel.GetRootObject(Mode, RootIndex: Integer;
  out RootObject: IInterface; out RootObjectName: WideString;
  out aOperations, aLinkType: Integer);
var
  aRefSource:IDMCollection;
  aClassCollections:IDMClassCollections;
begin
  case Mode of
  1:case RootIndex of
    0:begin
        RootObject:=FEnviroments;
        RootObjectName:=FEnviroments.Name;
        aOperations:=0;
        aLinkType:=ltOneToMany;
      end;
    1:begin
        RootObject:=Collection[_GuardVariant].Item[0];
        RootObjectName:=rsGuardModel;
        aOperations:=0;
        aLinkType:=ltOneToMany;
      end;
    end;
  2:case RootIndex of
    0:begin
        GetCollectionProperties(_AdversaryVariant,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_AdversaryVariant];
        RootObjectName:=rsAdversaryModel
      end;
    end;
  3:case RootIndex of
    0:begin
        GetCollectionProperties(_AnalysisVariant,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_AnalysisVariant];
      end;
    1:begin
        GetCollectionProperties(_UserDefinedPath,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_UserDefinedPath];
        RootObjectName:=rsUserDefinedPaths
      end;
    2:begin
        GetCollectionProperties(_WarriorPath,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_WarriorPath];
        RootObjectName:=rsWarriorPaths
      end;
    end;
  else
    inherited;
  end;
end;

procedure TCustomFacilityModel.Init;
var
  GuardVariant,
  AdversaryGroup,
  AdversaryVariant,
  StartPoint,
  FacilityState,
  AnalysisVariantE,
  Layer:IDMElement;
  TechnicalService, DefaultVolume:IDMElement;
  aCollection2:IDMCollection2;
  aCollection, BoundaryKinds:IDMCollection;
  S:string;
  DMDocument:IDMDocument;
  OldState:integer;
  j:integer;
  BuildSectorLayerE, VerticalBoundaryLayerE,
  UserDefinedPathLayerE:IDMElement;
  Views2:IDMCollection2;
  aViewE:IDMElement;
  SafeguardDatabase:ISafeguardDatabase;

  procedure SetBoundaryKind(const Layer:IDMElement; LayerKind:integer);
  var
    j:integer;
    BoundaryKindE:IDMElement;
    BoundaryKind2:IBoundaryKind2;
  begin
    j:=0;
    while j<BoundaryKinds.Count do begin
      BoundaryKindE:=BoundaryKinds.Item[j];
      BoundaryKind2:=BoundaryKindE as IBoundaryKind2;
      if BoundaryKind2.LayerKind=LayerKind then
        Break
      else
        inc(j)
    end;
    if j<BoundaryKinds.Count then
      Layer.Ref:=BoundaryKindE;
  end;

begin
  inherited;

  DMDocument:=Get_Document as IDMDocument;
  OldState:=DMDocument.State;
  SafeguardDatabase:=Ref as ISafeguardDatabase;
  BoundaryKinds:=SafeguardDatabase.BoundaryKinds;

  if not Get_IsLoading then begin
    DMDocument.State:=DMDocument.State or dmfCommiting;
    try
    Views2:=Get_Views as IDMCollection2;
    aViewE:=Views2.CreateElement(False);
    Views2.Add(aViewE);
    aViewE.Name:='Все уровни';
    with aViewE as IView do begin
      ZMax:=+FDefaultOpenZoneHeight*100;
      ZMin:=-FDefaultOpenZoneHeight*100;
      CurrZ0:=0;
      StoredParam:=vspZ_ZMin_ZMax;
    end;
    finally
      DMDocument.State:=OldState;
    end;
  end;

  aCollection2:=Collection[_GlobalZone] as IDMCollection2;
  if (aCollection2 as IDMCollection).Count=0 then begin
    FEnviroments:=aCollection2.CreateElement(False);
    aCollection2.Add(FEnviroments);
    FEnviroments.Name:=rsFacility;
    DefaultVolume:=GetDefaultParent(_Area);
    FEnviroments.Ref:=(Ref as ISafeguardDataBase).ZoneKinds.Item[0];

    DMDocument.State:=DMDocument.State or dmfCommiting;
    try
    DefaultVolume.Ref:=FEnviroments;
    (FEnviroments as IZone).Category:=-1;
    finally
      DMDocument.State:=OldState;
    end;
  end else
    FEnviroments:=(aCollection2 as IDMCollection).Item[0];

  aCollection2:=Get_GuardVariants as IDMCollection2;
  if (aCollection2 as IDMCollection).Count=0 then begin
    S:=rsGuardVariant2;
    GuardVariant:=aCollection2.CreateElement(False);
    aCollection2.Add(GuardVariant);
    GuardVariant.Name:=S;
  end;

  aCollection2:=Get_AdversaryVariants as IDMCollection2;
  if (aCollection2 as IDMCollection).Count=0 then begin
    S:=aCollection2.MakeDefaultName(nil);
    AdversaryVariant:=aCollection2.CreateElement(False);
    aCollection2.Add(AdversaryVariant);
    AdversaryVariant.Name:=S;
  end;

  aCollection2:=Get_AdversaryGroups as IDMCollection2;
  AdversaryGroup:=(aCollection2 as IDMCollection).Item[0];
  Set_CurrentWarriorGroupU(AdversaryGroup);

  aCollection2:=Get_StartPoints as IDMCollection2;
  if (aCollection2 as IDMCollection).Count=0 then begin
    S:=aCollection2.MakeDefaultName(nil);
    StartPoint:=aCollection2.CreateElement(False);
    aCollection2.Add(StartPoint);
    StartPoint.Ref:=(Ref as ISafeguardDatabase).StartPointKinds.Item[0];
    StartPoint.name:=S;
  end else
    StartPoint:=(aCollection2 as IDMCollection).Item[0];

  if (AdversaryGroup as IWarriorGroup).StartPoint=nil then
    (AdversaryGroup as IWarriorGroup).StartPoint:=StartPoint;

  aCollection2:=Get_TechnicalServices as IDMCollection2;
  if (aCollection2 as IDMCollection).Count=0 then begin
    S:=aCollection2.MakeDefaultName(nil);
    TechnicalService:=aCollection2.CreateElement(False);
    aCollection2.Add(TechnicalService);
    TechnicalService.Name:=S;
    TechnicalService.Parent:=GuardVariant;
  end;

  aCollection2:=Get_FacilityStates as IDMCollection2;
  if (aCollection2 as IDMCollection).Count=0 then begin
    S:=aCollection2.MakeDefaultName(nil);
    FacilityState:=aCollection2.CreateElement(False);
    aCollection2.Add(FacilityState);
    FacilityState.Name:=S;
    FacilityState.Parent:=FEnviroments;
  end else
    FacilityState:=(aCollection2 as IDMCollection).Item[0];
   Set_CurrentFacilityStateU(FacilityState);

  aCollection2:=Get_AnalysisVariants as IDMCollection2;
  if (aCollection2 as IDMCollection).Count=0 then begin
    S:=aCollection2.MakeDefaultName(nil);
    AnalysisVariantE:=aCollection2.CreateElement(False);
    aCollection2.Add(AnalysisVariantE);
    AnalysisVariantE.Name:=S;
  end else
    AnalysisVariantE:=(aCollection2 as IDMCollection).Item[0];
  Set_CurrentAnalysisVariantU(AnalysisVariantE);

  DMDocument.State:=DMDocument.State or dmfCommiting;
  aCollection2:=Get_Layers as IDMCollection2;
  if (aCollection2 as IDMCollection).Count<=1 then begin

    Layer:=aCollection2.CreateElement(False);
    aCollection2.Add(Layer);
    Layer.Name:=rsWallLayer;
    (Layer as ILayer).Color:=$000000;  //clBlack
    SetBoundaryKind(Layer, lkWall);

    Layer:=aCollection2.CreateElement(False);
    aCollection2.Add(Layer);
    Layer.Name:=rsFenceLayer;
    (Layer as ILayer).Color:=$08080;  //clDkGray
    SetBoundaryKind(Layer, lkFence);


    Layer:=aCollection2.CreateElement(False);
    aCollection2.Add(Layer);
    Layer.Name:=rsRoadLayer;
    (Layer as ILayer).Color:=$004080FF;  //clOrange

    Layer:=aCollection2.CreateElement(False);
    aCollection2.Add(Layer);
    Layer.Name:=rsDummyLayer;
    (Layer as ILayer).Color:=$00FFFF;  //clYellow
    SetBoundaryKind(Layer, lkVirtual);

    Layer:=aCollection2.CreateElement(False);
    aCollection2.Add(Layer);
    Layer.Name:=rsInvisibleLayer;
    (Layer as ILayer).Color:=$EAEAEA;  // Light Gray
    SetBoundaryKind(Layer, lkHidden);

    Layer:=aCollection2.CreateElement(False);
    aCollection2.Add(Layer);
    Layer.Name:=rsDoorLayer;
    (Layer as ILayer).Color:=$000080;  //clMaroon
    SetBoundaryKind(Layer, lkDoor);

    Layer:=aCollection2.CreateElement(False);
    aCollection2.Add(Layer);
    Layer.Name:=rsWindowLayer;
    (Layer as ILayer).Color:=$FF0000;  //clBlue
    SetBoundaryKind(Layer, lkWindow);
  end;

  aCollection:=aCollection2 as IDMCollection;

  j:=0;
  while j<aCollection.Count do begin
    Layer:=aCollection.Item[j];
    if (Layer as ILayer).Kind=lkBuildSector then
      Break
    else
      inc(j)
  end;
  if j<aCollection.Count then
    BuildSectorLayerE:=aCollection.Item[j]
  else begin
    BuildSectorLayerE:=aCollection2.CreateElement(False);
    aCollection2.Add(BuildSectorLayerE);
    BuildSectorLayerE.Name:=rsBuildSectorLayer;
    (BuildSectorLayerE as ILayer).Color:=$E8E8E8;  // Light Gray
    (BuildSectorLayerE as ILayer).Style:=2;  // psDot
    (BuildSectorLayerE as ILayer).KInd:=lkBuildSector;  // psDot
    (BuildSectorLayerE as ILayer).CanDelete:=False; // нельзя удалять
  end;
  if Get_BuildSectorLayer=nil then
    Set_BuildSectorLayer(BuildSectorLayerE);

  j:=0;
  while j<aCollection.Count do begin
    Layer:=aCollection.Item[j];
    if (Layer as ILayer).Kind=lkVerticalBoundary then
      Break
    else
      inc(j)
  end;
  if j<aCollection.Count then
    VerticalBoundaryLayerE:=aCollection.Item[j]
  else begin
    VerticalBoundaryLayerE:=aCollection2.CreateElement(False);
    aCollection2.Add(VerticalBoundaryLayerE);
    VerticalBoundaryLayerE.Name:=rsVerticalBoundaryLayer;
    (VerticalBoundaryLayerE as ILayer).Color:=$E8E8E8;
    (VerticalBoundaryLayerE as ILayer).Style:=2;  // psDot
    (VerticalBoundaryLayerE as ILayer).Kind:=lkVerticalBoundary;
    (VerticalBoundaryLayerE as ILayer).CanDelete:=False; // нельзя удалять
  end;
  if Get_VerticalBoundaryLayer=nil then
    Set_VerticalBoundaryLayer(VerticalBoundaryLayerE);

  j:=0;
  while j<aCollection.Count do begin
    Layer:=aCollection.Item[j];
    if (Layer as ILayer).Kind=lkUserDefinedPath then
      Break
    else
      inc(j)
  end;
  if j<aCollection.Count then
    UserDefinedPathLayerE:=aCollection.Item[j]
  else begin
    UserDefinedPathLayerE:=aCollection2.CreateElement(False);
    aCollection2.Add(UserDefinedPathLayerE);
    UserDefinedPathLayerE.Name:=rsAdversaryPathLayer;
    (UserDefinedPathLayerE as ILayer).Color:=$0000FF;  //clRed
    (UserDefinedPathLayerE as ILayer).Kind:=lkUserDefinedPath;
    (UserDefinedPathLayerE as ILayer).CanDelete:=False; // нельзя удалять
  end;
  if Get_UserDefinedPathLayer=nil then
    Set_UserDefinedPathLayer(UserDefinedPathLayerE);

  DMDocument.State:=OldState;

  FShowWalls:=False;


  FDelayFlag:=True;
end;

type
  TGetDMClassFactory=function:IDMClassFactory;

procedure TCustomFacilityModel.Initialize;
var
//  aClassFactory:IDM_ClassFactory;
  Unk:IUnknown;
  SelfE:IDMElement;
  H:HMODULE;
  F:TGetDMClassFactory;
  aDMClassFactory:IDMClassFactory;
begin
  SelfE:=Self as IDMElement;
{
//  DM_CoGetClassObject(CLASS_SafeguardSynthesis, aClassFactory);
//  aClassFactory.CreateInstance(nil, IUnknown, Unk);
  H:=DM_LoadLibrary('SafeguardSynthesisLib.dll');
  @F:=DM_GetProcAddress(H, 'GetDataModelClassObject');
  aDMClassFactory:=F;
  Unk:=aDMClassFactory.CreateInstance;

  FSafeguardSynthesis:=Unk as IDataModel;
  (FSafeguardSynthesis as IDMElement).Name:='Safeguard Synthesis';
  (FSafeguardSynthesis as ISafeguardSynthesis).FacilityModel:=Self as IDataModel;
}


//  DM_CoGetClassObject(CLASS_BattleModel, aClassFactory);
//  aClassFactory.CreateInstance(nil, IUnknown, Unk);
  H:=DM_LoadLibrary('BattleModelLib.dll');
  @F:=DM_GetProcAddress(H, 'GetDataModelClassObject');
  aDMClassFactory:=F;
  Unk:=aDMClassFactory.CreateInstance;

  FBattleModel:=Unk as IDataModel;
  (FBattleModel as IDMElement).Name:='Battle Model';
  (FBattleModel as IBattleModel).FacilityModel:=Self as IDataModel;

  DecimalSeparator:='.';

  inherited;
  ID:=0;

  FShowOptimalPathFromBoundary:=True;
  FShowFastPathFromBoundary:=True;
  FShowStealthPathToBoundary:=True;
  FShowFastGuardPathToBoundary:=True;
  FShowOptimalPathFromStart:=True;
  FShowText:=True;
  FShowSymbols:=True;
  FShowWalls:=False;
  FShowDetectionZones:=True;
  FBoundariesOrdered:=True;
  FBuildAllVerticalWays:=False;

  FDelayTimeDispersionRatio:=0.2;
  FZoneDelayTimeDispersionRatio:=0.13;
  FResponceTimeDispersionRatio:=0.13;
  FDefaultReactionMode:=1;
  FCriticalFalseAlarmPeriod:=8;

  FGraphColor:=$808080;
  FFastPathColor:=$0000FF;
  FStealthPathColor:=$FF0000;
  FRationalPathColor:=$880088;
  FGuardPathColor:=$00FF00;
  FMaxBoundaryDistance:=10000;
  FMaxPathAlongBoundaryDistance:=1000;
  FPathHeight:=100;
  FShoulderWidth:=100;

  FCurrentBoundaryStealthTactics:=CreateCollection(-1, SelfE);
  FCurrentZoneStealthTactics:=CreateCollection(-1, SelfE);
  FCurrentBoundaryFastTactics:=CreateCollection(-1, SelfE);
  FCurrentZoneFastTactics:=CreateCollection(-1, SelfE);
  FExtraTargets:=CreateCollection(-1, SelfE);
  FZSortedBoundaries:=CreateCollection(-1, SelfE);
  FDSortedBoundaries:=CreateCollection(-1, SelfE);
  FGuardArrivals:=CreateCollection(-1, SelfE);
  FVerificationGroups:=CreateCollection(-1, SelfE);

  FErrors:=TFMErrors.Create(SelfE) as IDMCollection;
  FWarnings:=TFMErrors.Create(SelfE) as IDMCollection;
  FBackRefHolders:=TDMBackRefHolders.Create(SelfE) as IDMCollection;
  FUserDefinedElements:=TDMBackRefHolders.Create(SelfE) as IDMCollection;

  FCurrencyRate:=35;
  FPriceCoeffD:=0.8;
  FPriceCoeffTZSR:=0.14;
  FPriceCoeffPNR:=0.3;

  FClassCollectionIndexes_:=TList.Create;
  FClassCollectionIndexes0:=TList.Create;

  FStairTurnAngle:=180;
  FStairLandingCount:=1;
  FStairLandingWidth:=2;
  FStairWidth:=2;
end;

procedure TCustomFacilityModel.MakeCollections;
begin
  inherited;

  AddClass(TZones);
  AddClass(TBoundaries);
  AddClass(TBoundaryLayers);
  AddClass(TTechnicalServices);
  AddClass(TFacilityStates);
  AddClass(TFacilitySubStates);
  AddClass(TBoundaryStates);
  AddClass(TZoneStates);
  AddClass(TBoundaryLayerStates);
  AddClass(TSafeguardElementStates);
  AddClass(TWarriorPaths);
  AddClass(TBarriers);
//  AddClass(TBarrierFixtures);
  AddClass(TLocks);
  AddClass(TUndergroundObstacles);
  AddClass(TGroundObstacles);
  AddClass(TFenceObstacles);
  AddClass(TActiveSafeguards);
  AddClass(TSurfaceSensors);
  AddClass(TPositionSensors);
  AddClass(TVolumeSensors);
  AddClass(TBarrierSensors);
  AddClass(TPerimeterSensors);
  AddClass(TContrabandSensors);
  AddClass(TAccessControls);
  AddClass(TTVCameras);
  AddClass(TLightDevices);
  AddClass(TCommunicationDevices);
//  AddClass(TSignalDevices);
//  AddClass(TPowerSources);
  AddClass(TCabels);
  AddClass(TConnections);
  AddClass(TControlDevices);
  AddClass(TGuardPosts);
  AddClass(TPatrolPaths);
  AddClass(TTargets);
  AddClass(TLocalPointObjects);
  AddClass(TJumps);
  AddClass(TStartPoints);
  AddClass(TGuardVariants);
  AddClass(TGuardGroups);
  AddClass(TAdversaryVariants);
  AddClass(TAdversaryGroups);
  AddClass(TTools);
  AddClass(TWeapons);
  AddClass(TVehicles);
  AddClass(TAthorities);
  AddClass(TSkills);
  AddClass(TAnalysisVariants);
  AddClass(TRoads);
  AddClass(TUserDefinedPaths);
  AddClass(TGlobalZones);
  AddClass(TAccesses);
  AddClass(TWarriorPathElements);
  AddClass(TCriticalPoints);
  AddClass(TFMRecomendations);
  AddClass(TGuardArrivals);
  AddClass(TElementParameterValues);
  AddClass(TControlDeviceAccesses);
  AddClass(TGuardPostAccesses);
  AddClass(TSubBoundaries);
  AddClass(TOvercomingBoundaries);
  AddClass(TObservers);
  AddClass(TGuardGroupStates);
end;

procedure TCustomFacilityModel.Set_CurrentWarriorGroupU(
  const Value: IUnknown);
begin
  FCurrentWarriorGroup:=Value as IDMElement;
  UpdateCurrentTactics;
end;

function TCustomFacilityModel.Get_CurrentFacilityStateU: IUnknown;
begin
  Result:=FCurrentState
end;

procedure TCustomFacilityModel.Set_CurrentFacilityStateU(
  const Value: IUnknown);
begin
  FCurrentState:=Value as IDMElement
end;

function TCustomFacilityModel.Get_CurrentPathArc: IDMElement;
begin
  Result:=FCurrentPathArc
end;

procedure TCustomFacilityModel.Set_CurrentPathArc(const Value: IDMElement);
begin
  FCurrentPathArc:=Value
end;

function TCustomFacilityModel.Get_CurrentPathStage: Integer;
begin
  Result:=FCurrentPathStage
end;

procedure TCustomFacilityModel.Set_CurrentPathStage(Value: Integer);
begin
  FCurrentPathStage:=Value;
  UpdateCurrentTactics;
end;


function TCustomFacilityModel.Get_Boundaries: IDMCollection;
begin
  Result:=Collection[_Boundary];
end;
{
function TCustomFacilityModel.Get_BoundaryElements: IDMCollection;
begin
  Result:=Collection[_BoundaryElement]
end;

function TCustomFacilityModel.Get_BoundaryElementStates: IDMCollection;
begin
  Result:=Collection[_BoundaryElementState]
end;
}
function TCustomFacilityModel.Get_BoundaryLayers: IDMCollection;
begin
  Result:=Collection[_BoundaryLayer]
end;

function TCustomFacilityModel.Get_BoundaryLayerStates: IDMCollection;
begin
  Result:=Collection[_BoundaryLayerState]
end;

function TCustomFacilityModel.Get_BoundaryStates: IDMCollection;
begin
  Result:=Collection[_BoundaryState]
end;

function TCustomFacilityModel.Get_FacilityStates: IDMCollection;
begin
  Result:=Collection[_FacilityState]
end;

function TCustomFacilityModel.Get_FacilitySubStates: IDMCollection;
begin
  Result:=Collection[_FacilitySubState]
end;

function TCustomFacilityModel.Get_SafeguardElementStates: IDMCollection;
begin
  Result:=Collection[_SafeguardElementState]
end;

function TCustomFacilityModel.Get_ZoneStates: IDMCollection;
begin
  Result:=Collection[_ZoneState]
end;

function TCustomFacilityModel.Get_WarriorPaths: IDMCollection;
begin
  Result:=Collection[_WarriorPath]
end;

function TCustomFacilityModel.Get_Zones: IDMCollection;
begin
  Result:=Collection[_Zone]
end;

function TCustomFacilityModel.Get_AccessControls: IDMCollection;
begin
  Result:=Collection[_AccessControl]
end;

function TCustomFacilityModel.Get_ActiveSafeguards: IDMCollection;
begin
  Result:=Collection[_ActiveSafeguard]
end;

function TCustomFacilityModel.Get_BarrierFixtures: IDMCollection;
begin
  Result:=Collection[_BarrierFixture]
end;

function TCustomFacilityModel.Get_Barriers: IDMCollection;
begin
  Result:=Collection[_Barrier]
end;

function TCustomFacilityModel.Get_BarrierSensors: IDMCollection;
begin
  Result:=Collection[_BarrierSensor]
end;

function TCustomFacilityModel.Get_Cabels: IDMCollection;
begin
  Result:=Collection[_Cabel]
end;

function TCustomFacilityModel.Get_ContrabandSensors: IDMCollection;
begin
  Result:=Collection[_ContrabandSensor]
end;

function TCustomFacilityModel.Get_CommunicationDevices: IDMCollection;
begin
  Result:=Collection[_CommunicationDevice]
end;

function TCustomFacilityModel.Get_Conveyances: IDMCollection;
begin
  Result:=Collection[_Conveyance]
end;

function TCustomFacilityModel.Get_GuardGroups: IDMCollection;
begin
  Result:=Collection[_GuardGroup]
end;

function TCustomFacilityModel.Get_GuardPosts: IDMCollection;
begin
  Result:=Collection[_GuardPost]
end;

function TCustomFacilityModel.Get_GuardVariants: IDMCollection;
begin
  Result:=Collection[_GuardVariant]
end;

function TCustomFacilityModel.Get_Weapons: IDMCollection;
begin
  Result:=Collection[_Weapon]
end;

function TCustomFacilityModel.Get_LightDevices: IDMCollection;
begin
  Result:=Collection[_LightDevice]
end;

function TCustomFacilityModel.Get_Jumps: IDMCollection;
begin
  Result:=Collection[_Jump]
end;

function TCustomFacilityModel.Get_LocalPointObjects: IDMCollection;
begin
  Result:=Collection[_LocalPointObject]
end;

function TCustomFacilityModel.Get_Locks: IDMCollection;
begin
  Result:=Collection[_Lock]
end;

function TCustomFacilityModel.Get_UndergroundObstacles: IDMCollection;
begin
  Result:=Collection[_UndergroundObstacle]
end;

function TCustomFacilityModel.Get_GroundObstacles: IDMCollection;
begin
  Result:=Collection[_GroundObstacle]
end;

function TCustomFacilityModel.Get_FenceObstacles: IDMCollection;
begin
  Result:=Collection[_FenceObstacle]
end;

function TCustomFacilityModel.Get_PatrolPaths: IDMCollection;
begin
  Result:=Collection[_PatrolPath]
end;

function TCustomFacilityModel.Get_PerimeterSensors: IDMCollection;
begin
  Result:=Collection[_PerimeterSensor]
end;

function TCustomFacilityModel.Get_PositionSensors: IDMCollection;
begin
  Result:=Collection[_PositionSensor]
end;

function TCustomFacilityModel.Get_PowerSources: IDMCollection;
begin
  Result:=Collection[_PowerSource]
end;

function TCustomFacilityModel.Get_SignalDevices: IDMCollection;
begin
  Result:=Collection[_SignalDevice]
end;

function TCustomFacilityModel.Get_StartPoints: IDMCollection;
begin
  Result:=Collection[_StartPoint]
end;

function TCustomFacilityModel.Get_SurfaceSensors: IDMCollection;
begin
  Result:=Collection[_SurfaceSensor]
end;

function TCustomFacilityModel.Get_Targets: IDMCollection;
begin
  Result:=Collection[_Target]
end;

function TCustomFacilityModel.Get_TVCameras: IDMCollection;
begin
  Result:=Collection[_TVCamera]
end;

function TCustomFacilityModel.Get_VolumeSensors: IDMCollection;
begin
  Result:=Collection[_VolumeSensor]
end;

function TCustomFacilityModel.Get_Athorities: IDMCollection;
begin
  Result:=Collection[_Athority]
end;

function TCustomFacilityModel.Get_AdversaryGroups: IDMCollection;
begin
  Result:=Collection[_AdversaryGroup]
end;

function TCustomFacilityModel.Get_Skills: IDMCollection;
begin
  Result:=Collection[_Skill]
end;

function TCustomFacilityModel.Get_Tools: IDMCollection;
begin
  Result:=Collection[_Tool]
end;

function TCustomFacilityModel.Get_AdversaryVariants: IDMCollection;
begin
  Result:=Collection[_AdversaryVariant]
end;

function TCustomFacilityModel.Get_Vehicles: IDMCollection;
begin
  Result:=Collection[_Vehicle]
end;

type
  PSeparatingAreaRec=^TSeparatingAreaRec;
  TSeparatingAreaRec=record
    FArea:pointer;
    FDist:double;
  end;

function CompareSeparatingAreaRec(Item1, Item2:pointer):integer;
var
  Rec1, Rec2:PSeparatingAreaRec;
begin
  Rec1:=PSeparatingAreaRec(Item1);
  Rec2:=PSeparatingAreaRec(Item2);
  if Rec1.FDist<Rec2.FDist then
    Result:=-1
  else
  if Rec1.FDist>Rec2.FDist then
    Result:=+1
  else
    Result:=0
end;

function TCustomFacilityModel.FindSeparatingAreas(C0X, C0Y, C0Z, C1X, C1Y,
  C1Z: Double; const C0Ref, C1Ref: IDMElement; WhileTransparent: Integer;
  const SeparatingAreas: IDMCollection; var TransparencyCoeff: Double;
  const ExcludeArea0E, ExcludeArea1E: IDMElement): WordBool;
//  WhileTransparent=0 -  проходим все границы, не останавливаясь на непрозрачных
//  Result=True, если найдена граница с достаточной высотой непрозрачного слоя
//  в SeparatingAreas все плоскости
//  TransparencyCoeff вычисляется с использованием данных о прозрачности зон

//  WhileTransparent=1 -  останавливаемся на первой границе с достаточной высотой непрозрачного слоя
//  Result=True, если найдена граница с достаточной высотой непрозрачного слоя
//  в SeparatingAreas все непрозрачные границы и последняя непрозрачная
//  TransparencyCoeff вычисляется с использованием данных о прозрачности зон
//  (следует учесть, что Result=False также и в том случае, если одна из точек - вне объекта)

//  WhileTransparent=2 -  останавливаемся на первой границе, независимо от ее прозрачности
//  Result=True, если найдена любая граница
//  в SeparatingAreas  - ничего (не используется)
//  TransparencyCoeff не используется
var
  WP0X, WP0Y, WP0Z,
  WP1X, WP1Y, WP1Z,
  WPX, WPY, WPZ:double;
  aArea:IArea;
  aBoundary:IBoundary;
  j:integer;
  AreaList:TList;
  VolumeList:TList;
  AreaRecList:TList;
  SafeguardElement:ISafeguardElement;
  Volume0E, Volume1E, aVolumeE:IDMElement;
  AreaE, Area1E, aAreaE:IDMElement;
  Target:ITarget;
  SeparatingAreas2:IDMCollection2;

  function GetCashResult:boolean;
  var
    j:integer;
    AreaE:IDMElement;
  begin
    Result:=False;
    if C0X<>CashC0X then Exit;
    if C0Y<>CashC0Y then Exit;
    if C0Z<>CashC0Z then Exit;
    if C1X<>CashC1X then Exit;
    if C1Y<>CashC1Y then Exit;
    if C1Z<>CashC1Z then Exit;
    if WhileTransparent<>CashWhileTransparent then Exit;
    if pointer(ExcludeArea0E)<>CashExcludeArea0P then Exit;
    if pointer(ExcludeArea1E)<>CashExcludeArea1P then Exit;
    Result:=True;
    TransparencyCoeff:=CashTransparencyCoeff;
    CashSeparatingAreaList.Clear;
    for j:=0 to CashSeparatingAreaList.Count-1 do begin
      AreaE:=IDMElement(CashSeparatingAreaList[j]);
      SeparatingAreas2.Add(AreaE);
    end;
  end;

  procedure SaveResult;
  var
    j:integer;
    AreaE:IDMElement;
  begin
    CashC0X:=C0X;
    CashC0Y:=C0Y;
    CashC0Z:=C0Z;
    CashC1X:=C1X;
    CashC1Y:=C1Y;
    CashC1Z:=C1Z;
    CashWhileTransparent:=WhileTransparent;
    CashExcludeArea0P:=pointer(ExcludeArea0E);
    CashExcludeArea1P:=pointer(ExcludeArea1E);
    CashFindSeparatingAreasResult:=Result;
    CashTransparencyCoeff:=TransparencyCoeff;
    CashSeparatingAreaList.Clear;
    for j:=0 to SeparatingAreas.Count-1 do begin
      AreaE:=SeparatingAreas.Item[j];
      CashSeparatingAreaList.Add(pointer(AreaE));
    end;
  end;

  procedure FreeLists;
  var
    AreaRec:PSeparatingAreaRec;
  begin
    AreaList.Free;
    VolumeList.Free;
    while AreaRecList.Count>0 do begin
      AreaRec:=AreaRecList[0];
      FreeMem(AreaRec, SizeOf(TSeparatingAreaRec));
      AreaRecList.Delete(0)
    end;
    AreaRecList.Free;
  end;

  procedure AddArea(const aAreaE:IDMElement);
  var
    MaxHeight, aHeight0, aHeight1, aHeight:double;
    m:integer;
    AreaRec:PSeparatingAreaRec;
    BoundaryLayerE:IDMElement;
    BoundaryLayer:IBoundaryLayer;
    BoundaryLayerType:IBoundaryLayerType;
    BoundaryLayerB:IFieldBarrier;
  begin
    aArea:=aAreaE as IArea;
    aBoundary:=aAreaE.Ref as IBoundary;
    if aBoundary=nil then Exit;

    if (aAreaE<>ExcludeArea0E) and
       (aAreaE<>ExcludeArea1E) then begin


      if WhileTransparent=2 then begin // не важно - прозрачно или нет
        Result:=True;
        TransparencyCoeff:=0;
      end else begin
        SeparatingAreas2.Add(aAreaE);
        GetMem(AreaRec, SizeOf(TSeparatingAreaRec));
        AreaRecList.Add(AreaRec);
        AreaRec.FArea:=pointer(aArea);
        AreaRec.FDist:=sqrt(sqr(WP0X-WPX)+sqr(WP0Y-WPY)+sqr(WP0Z-WPZ));
        if aArea.IsVertical then begin
          MaxHeight:=0;
          for m:=0 to aBoundary.BoundaryLayers.Count-1 do begin
            BoundaryLayerE:=aBoundary.BoundaryLayers.Item[m];
            BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
            BoundaryLayerType:=BoundaryLayerE.Ref as IBoundaryLayerType;
            BoundaryLayerB:=BoundaryLayerE as IFieldBarrier;
            if not BoundaryLayerB.IsTransparent then begin
              aHeight0:=BoundaryLayer.Height0*100;
              aHeight1:=BoundaryLayer.Height1*100;
              if (BoundaryLayerType.DefaultHeight>0) and
                 (aHeight0>0) and
                 (aHeight1>0) then begin
                aHeight:=0.5*(aHeight0+aHeight1);
                 if MaxHeight<aHeight then
                   MaxHeight:=aHeight;
              end else begin
                MaxHeight:=aArea.MaxZ-aArea.MinZ;
                Break;
              end;
            end;
          end;
          if (MaxHeight>0) and
             (MaxHeight>=(WPZ-aArea.MinZ-1.e-6)) then begin // нашли непрозрачный слой достаточной высоты
            Result:=True;
            TransparencyCoeff:=0;
          end;
        end else begin
          if  (not (aBoundary as IFieldBarrier).IsTransparent) then begin
            Result:=True;
            TransparencyCoeff:=0;
          end;
        end;
      end;
    end;  //if (aArea<>ExcludeArea0E) and ...

    Volume0E:=aArea.Volume0 as IDMElement;
    if (Volume0E<>nil) and
       (VolumeList.IndexOf(pointer(Volume0E))=-1)  then
         VolumeList.Add(pointer(Volume0E));
    Volume1E:=aArea.Volume1 as IDMElement;
    if (Volume1E<>nil) and
       (VolumeList.IndexOf(pointer(Volume1E))=-1)  then
         VolumeList.Add(pointer(Volume1E));

  end;

  procedure CheckArea(const aAreaE:IDMElement);
  begin
      if (AreaList.IndexOf(pointer(aAreaE))=-1) then begin
        AreaList.Add(pointer(aAreaE));
        if (aAreaE as IArea).IntersectLine(WP0X, WP0Y, WP0Z,
                                           WP1X, WP1Y, WP1Z,
                                           WPX, WPY, WPZ) then begin
          if ((WP1X-WPX)*(WP0X-WPX)<=0) and
             ((WP1Y-WPY)*(WP0Y-WPY)<=0) and
             ((WP1Z-WPZ)*(WP0Z-WPZ)<=0) then begin
            AreaE:=aAreaE;
            AddArea(aAreaE)
(*
          end else begin //if ((WP1X-WPX)*(WP0X-WPX)<=0) and ....
            D1:=sqrt(sqr(WP1X-WPX)+sqr(WP1Y-WPY)+sqr(WP1Z-WPZ));
            if D1<D1Min then begin   //  ловушка для узлов графа маршрутов, не помещающихся в зоне
              D1Min:=D1;
              Area1E:=aAreaE;
            end;
*)  // закоментировано, так как эта проблема должна решаться путем корректного расчета координат узлов

          end;
        end; //if (aAreaE as IArea).IntersectLine
      end;  //if (AreaList.IndexOf(pointer(aAreaE))=-1)
  end;

var
  Volume0, Volume1:IVolume;
  Zone0E, Zone1E:IDMElement;
  Zone0, Zone1, aZone0, aZone1, aZone:IZone;
  TransparencyDist, Dist, Q, L:double;
  AreaRec:PSeparatingAreaRec;
  aCoordNode:ICoordNode;
  Boundary:IBoundary;
  CC0, CC1:ICoordNode;

  function GetBoundaryZone(const CRef:IDMElement;
                           CX, CY, CZ:double):IZone;
  var
    X0, Y0, Z0, X1, Y1, Z1, ProjL, cosX, cosY,
    W0X, W0Y, W1X, W1Y, X, Y, Z:double;
    V0, V1:IVolume;
    aAreaE, aLineE, Zone0E, Zone1E:IDMElement;
    aArea:IArea;
    aLine:ILine;
  begin
    if CRef.ClassID=_Jump then begin
      Zone0E:=Boundary.Zone0;
      Zone1E:=Boundary.Zone1;

      aLineE:=CRef.SpatialElement;
      aLine:=aLineE as ILine;
      CC0:=aLine.C0;
      CC1:=aLine.C1;
      W0X:=CC0.X;
      W0Y:=CC0.Y;
      W1X:=CC1.X;
      W1Y:=CC1.Y;
      if (sqr(CX-W0X)+sqr(CY-W0Y))<(sqr(CX-W1X)+sqr(CY-W1Y)) then
        Result:=Zone0E as IZone
      else
        Result:=Zone1E as IZone
    end else
    if CRef.ClassID=_Boundary then begin
      try
      aAreaE:=CRef.SpatialElement;
      aArea:=aAreaE as IArea;
      V0:=aArea.Volume0;
      V1:=aArea.Volume1;
      if aArea.IsVertical then begin
        CC0:=aArea.C0;
        CC1:=aArea.C1;

        X0:=CC0.X;
        Y0:=CC0.Y;
        Z0:=CC0.Z;
        X1:=CC1.X;
        Y1:=CC1.Y;
        Z1:=CC1.Z;
        ProjL:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
        cosX:=(X1-X0)/ProjL;
        cosY:=(Y1-Y0)/ProjL;
        X:=0.5*(X0+X1);
        Y:=0.5*(Y0+Y1);
        Z:=0.5*(Z0+Z1);
        W0X:=X-5*cosY;
        W0Y:=Y+5*cosX;
        W1X:=X+5*cosY;
        W1Y:=Y-5*cosX;
        if (sqr(CX-W0X)+sqr(CY-W0Y))<(sqr(CX-W1X)+sqr(CY-W1Y)) then begin
          X:=W0X;
          Y:=W0Y;
        end else begin
          X:=W1X;
          Y:=W1Y;
        end;
        if (V0<>nil) and
           V0.ContainsPoint(X, Y, Z) then
          Result:=(V0 as IDMElement).Ref as IZone
        else
        if (V1<>nil) then
          Result:=(V1 as IDMElement).Ref as IZone
        else
          Result:=nil
      end else begin
        Z:=0.5*(aArea.MaxZ+aArea.MinZ);
        if CZ>Z then
          Result:=(V0 as IDMElement).Ref as IZone
        else
          Result:=(V1 as IDMElement).Ref as IZone
      end;
      except
        raise
      end;  
    end
    else
      Result:=nil;
  end;

begin
  SeparatingAreas2:=SeparatingAreas as IDMCollection2;

  if GetCashResult then begin
    Result:=CashFindSeparatingAreasResult;
    Exit;
  end;

  Result:=False;

  SeparatingAreas2.Clear;

  try
  TransparencyCoeff:=1;

  if C0Ref=nil then
    Zone0:=FEnviroments as IZone
  else
  if C0Ref.QueryInterface(ICoordNode, aCoordNode)=0 then begin
    Zone0:=C0Ref.Ref as IZone;
    if Zone0=nil then Exit;
  end else
  if C0Ref.QueryInterface(ISafeguardElement, SafeguardElement)=0 then
    Zone0:=C0Ref.Parent as IZone
  else
  if C0Ref.QueryInterface(ITarget, Target)=0 then
    Zone0:=C0Ref.Parent as IZone
  else
  if C0Ref.QueryInterface(IBoundary, Boundary)=0 then begin
    Zone0:=GetBoundaryZone(C0Ref, C1X, C1Y, C1Z);
  end else
  if C0Ref.QueryInterface(IZone, Zone0)<>0 then
    Exit;

  Zone0E:=Zone0 as IDMElement;
  if Zone0E=nil then Exit;
  if Zone0E.SpatialElement=nil then Exit;

  Volume0E:=Zone0E.SpatialElement;
  Volume0:=Volume0E as IVolume;

  if C1Ref=nil then
    Zone1:=FEnviroments as IZone
  else
  if C1Ref.QueryInterface(ICoordNode, aCoordNode)=0 then begin
    Zone1:=C1Ref.Ref as IZone;
    if Zone1=nil then Exit;
  end else
  if C1Ref.QueryInterface(ISafeguardElement, SafeguardElement)=0 then
    Zone1:=C1Ref.Parent as IZone
  else
  if C1Ref.QueryInterface(ITarget, Target)=0 then
    Zone1:=C1Ref.Parent as IZone
  else
  if C1Ref.QueryInterface(IBoundary, Boundary)=0 then begin
    Zone1:=GetBoundaryZone(C1Ref, C0X, C0Y, C0Z);
  end else
  if C1Ref.QueryInterface(IZone, Zone1)<>0 then
    Exit;

  Zone1E:=Zone1 as IDMElement;
  if Zone1E=nil then Exit;
  if Zone1E.SpatialElement=nil then Exit;

  Volume1E:=Zone1E.SpatialElement;
  Volume1:=Volume1E as IVolume;

  AreaList:=TList.Create;
  VolumeList:=TList.Create;
  AreaRecList:=TList.Create;

  try

  WP0X:=C0X;
  WP0Y:=C0Y;
  WP0Z:=C0Z;
  if (C0Ref<>nil) and
     (WP0Z>=Volume0.MaxZ-1.e-6) then
    WP0Z:=Volume0.MaxZ-10;
  WP1X:=C1X;
  WP1Y:=C1Y;
  WP1Z:=C1Z;
  if (C1Ref<>nil) and
     (WP1Z>=Volume1.MaxZ-1.e-6) then
    WP1Z:=Volume1.MaxZ-10;

  VolumeList.Add(pointer(Volume0E));
  if Volume1E<>Volume0E then
    VolumeList.Add(pointer(Volume1E));

  while VolumeList.Count>0 do begin
    aVolumeE:=IDMElement(VolumeList[0]);
    aZone:=aVolumeE.Ref as IZone;

    AreaE:=nil;
    Area1E:=nil;
    for j:=0 to aZone.HAreas.Count-1 do begin
      aAreaE:=aZone.HAreas.Item[j];
      CheckArea(aAreaE);
      if Result and
        (WhileTransparent<>0) then begin
        Exit;
      end;
    end;  //for j:=0 to aVolume.Areas.Count-1

    for j:=0 to aZone.VAreas.Count-1 do begin
      aAreaE:=aZone.VAreas.Item[j];
      CheckArea(aAreaE);
      if Result and
         (WhileTransparent<>0) then begin
        Exit;
      end;
    end;  //for j:=0 to aVolume.Areas.Count-1

    if (AreaE=nil) and
       (Area1E<>nil) then begin
      AddArea(Area1E);
      if Result and
         (WhileTransparent<>0) then begin
        Exit;
      end;
    end;

    for j:=0 to aZone.Zones.Count-1 do begin
      aVolumeE:=aZone.Zones.Item[j].SpatialElement;
      if VolumeList.IndexOf(pointer(aVolumeE))=-1  then
        VolumeList.Add(pointer(aVolumeE));
    end;

    VolumeList.Delete(0);
  end; //while VolumeList.Count>0

// if (not Result) or (WhileTransparent=0) then ....

  if AreaRecList.Count>0 then begin
    AreaRecList.Sort(@CompareSeparatingAreaRec);

    Q:=0;
    Dist:=0;
    aZone:=Zone0;

    SeparatingAreas2.Clear;
    for j:=0 to AreaRecList.Count-1 do begin
      AreaRec:=PSeparatingAreaRec(AreaRecList[j]);
      aArea:=IArea(AreaRec.FArea);
      SeparatingAreas2.Add(aArea as IDMElement);

      if aZone<>nil then begin
        TransparencyDist:=aZone.TransparencyDist*100;
        if TransparencyDist=0 then begin
          TransparencyCoeff:=0;
          Break;
        end else begin
          Q:=Q+(AreaRec.FDist-Dist)/TransparencyDist;
          Dist:=AreaRec.FDist;
        end;
      end;

      if aArea.Volume0<>nil then
        aZone0:=(aArea.Volume0 as  IDMElement).Ref as IZone
      else
        aZone0:=nil;
      if aArea.Volume1<>nil then
        aZone1:=(aArea.Volume1 as  IDMElement).Ref as IZone
      else
        aZone1:=nil;
      if aZone=aZone0 then
        aZone:=aZone1
      else
        aZone:=aZone0
    end; //for j:=0 to AreaRecList.Count-1

    if (TransparencyCoeff<>0) and
       (aZone<>nil) then begin
      TransparencyDist:=aZone.TransparencyDist*100;
      if TransparencyDist=0 then begin
        TransparencyCoeff:=0;
      end else begin
        L:=sqrt(sqr(WP0X-WP1X)+sqr(WP0Y-WP1Y)+sqr(WP0Z-WP1Z));
        Q:=Q+(L-Dist)/TransparencyDist;
      end;
    end;

    if TransparencyCoeff<>0 then
      TransparencyCoeff:=TransparencyCoeff*exp(-Q);

  end;
  finally
    FreeLists;
  end
  finally
    SaveResult
  end;
end;


function TCustomFacilityModel.Get_SafeguardDatabase: IUnknown;
begin
  Result:=Ref as IUnknown
end;

procedure TCustomFacilityModel.Set_SafeguardDatabase(const Value: IUnknown);
begin
  Ref:=Value as IDMElement
end;

procedure TCustomFacilityModel.GetRefElementParent(ClassID, OperationCode: Integer;
                      PX, PY, PZ: Double;
                      out aParent: IDMElement;
                      out DMClassCollections:IDMClassCollections;
                      out RefSource, aCollection : IDMCollection);
var
  aZone:IZone;
  j:integer;
  DMDocument:IDMDocument;
  aElement:IDMElement;
begin
  case ClassID of
  _CoordNode:
     begin
       aZone:=GetSmallestZone(PX, PY, PZ);
       aParent:=aZone as IDMElement;
       if aParent=FEnviroments then begin
         aParent:=nil;
         DMClassCollections:=nil
       end else
         DMClassCollections:=(aZone as IDMElement).Ref.Parent as IDMClassCollections;
       RefSource:=nil;
       aCollection:=nil;
     end;
  _Line:
     case OperationCode of
     smoBuildLineObject:
       begin
         aParent:=nil;
         DMClassCollections:=nil;
         aCollection:=Get_Jumps;
         RefSource:=(Get_SafeguardDatabase as IDMElement).Collection[_JumpType];
       end;
     smoBuildArrayObject:
       begin
         aZone:=GetSmallestZone(PX, PY, PZ);
         aParent:=aZone as IDMElement;
         DMClassCollections:=(aZone as IDMElement).Ref.Parent as IDMClassCollections;
         RefSource:=nil;
         aCollection:=nil;
       end;
     end;
  _Polyline:
     begin
       aParent:=nil;
       DMClassCollections:=Self as IDMClassCollections;
       RefSource:=nil;
       aCollection:=nil;
     end;
  _Area:
    begin
      aParent:=nil;
      DMClassCollections:=nil;
      RefSource:=(Get_SafeguardDatabase as ISafeguardDatabase).BoundaryTypes;
      aCollection:=Get_Boundaries;
      aParent:=nil;
      aCollection:=Get_Boundaries;
    end;
  _Volume:
    begin
      DMDocument:=Get_Document as IDMDocument;

      DMClassCollections:=nil;
      RefSource:=(Get_SafeguardDatabase as ISafeguardDatabase).ZoneTypes;
      aCollection:=Get_Zones;

      aZone:=GetSmallestZone(PX, PY, PZ);
      while aZone<>FEnviroments as IZone do begin
        j:=0;
        while j<DMDocument.SelectionCount do begin
          aElement:=DMDocument.SelectionItem[j] as IDMElement;
          if not aZone.Contains(aElement) then
            Break
          else
            inc(j)
        end;
        if j<DMDocument.SelectionCount then
          aZone:=(aZone as IDMElement).Parent as IZone
        else
          Break  
      end;
      aParent:=aZone as IDMElement;
      aCollection:=aZone.Zones;
    end;
  end;
end;

procedure TCustomFacilityModel.GetDefaultAreaRefRef(const VolumeE: IDMElement;
  Mode: Integer; BaseVolumeFlag:WordBool;
  out aCollection: IDMCollection; out aName: WideString;
  out AreaRefRef: IDMElement);
var
  ZoneKindE:IDMElement;
  ZoneKind:IZoneKind;
begin
  aCollection:=nil;
  aName:='';
  AreaRefRef:=nil;

  ZoneKindE:=VolumeE.Ref.Ref;
  ZoneKind:=ZoneKindE as IZoneKind;

  case Mode of
  0:AreaRefRef:=ZoneKind.DefaultBottomBoundaryKind;
  1:AreaRefRef:=ZoneKind.DefaultTopBoundaryKind;
  2:if BaseVolumeFlag then
      AreaRefRef:=Get_GlobalIntf(1) as IDMELement
    else
      AreaRefRef:=ZoneKind.DefaultSideBoundaryKind;
  end;

  aCollection:=Get_Boundaries;
  if AreaRefRef<>nil then
    aName:=Format('%s %s%s',[GetDefaultName(AreaRefRef),
                           SuffixDivider, VolumeE.Name])
end;

procedure TCustomFacilityModel.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;
  case Index of
  _Boundary:
     begin
       aRefSource:=(Ref as ISafeguardDatabase).BoundaryTypes;
       aOperations:=leoAdd or leoDelete or leoRename or leoChangeRef;
     end;
  _AdversaryVariant:
     begin
       aOperations:=leoAdd or leoDelete or leoRename or leoMove or leoOperation1;
     end;
  _AnalysisVariant:
     begin
       aOperations:=leoAdd or leoDelete or leoRename or leoMove;
     end;
  _UserDefinedPath:
     begin
       aOperations:=leoDelete or leoRename or leoMove or leoExecute;
     end;
  end;
end;

function TCustomFacilityModel.Get_Enviroments: IDMElement;
begin
  Result:=FEnviroments
end;

procedure TCustomFacilityModel.LoadedFromDataBase(const aDataBaseU: IUnknown);
var
  aCollection:IDMCollection;
  aCollection2:IDMCollection2;
  DefaultVolume:IDMElement;
begin

  aCollection:=Collection[_GlobalZone];
  aCollection2:=Collection[_GlobalZone] as IDMCollection2;
  if aCollection.Count>0 then
    FEnviroments:=aCollection.Item[0]
  else begin
    FEnviroments:=aCollection2.CreateElement(False);
    aCollection2.Add(FEnviroments);
    FEnviroments.Name:=rsFacility;
  end;

  DefaultVolume:=GetDefaultParent(_Area);
  DefaultVolume.Ref:=FEnviroments;

  inherited;
//  CheckTopology;

  Init;

end;

function TCustomFacilityModel.Get_AnalysisVariants: IDMCollection;
begin
  Result:=Collection[_AnalysisVariant]
end;

function TCustomFacilityModel.GetSmallestZone(WX, WY, WZ: Double): IZone;
var
  j, m:integer;
  MinZ, MaxZ:double;
  Zone:IZone;
  Volume:IVolume;
  VolumeE:IDMElement;
  Layer:ILayer;
  Area:IArea;
begin
  Result:=FEnviroments as IZone;
  for j:=0 to Get_Zones.Count-1 do begin
    Zone:=Get_Zones.Item[j] as IZone;
    VolumeE:=(Zone as IDMElement).SpatialElement;
    if VolumeE<>nil then begin
      Volume:=VolumeE as IVolume;
      Layer:=VolumeE.Parent as ILayer;
      if (Volume<>nil) and
         (Volume.Areas.Count>0) and
         (Layer.Selectable) then begin
        MinZ:=Volume.MinZ;
        MaxZ:=Volume.MaxZ;
        if (MinZ<=WZ+1.e-6) and (MaxZ>WZ+1.e-6) then
        for m:=0 to Volume.Areas.Count-1 do begin
          Area:=Volume.Areas.Item[m] as IArea;
          if not Area.IsVertical and
             (Area.MinZ<=WZ+1.e-6) and
             (Area.ProjectionContainsPoint(WX, WY, 0)) then begin
            if (not Zone.Contains(Result as IDMElement)) then
              Result:=Zone;
          end;
        end;
      end;
    end;
  end
end;

function TCustomFacilityModel.GetDefaultParent(ClassID: integer): IDMElement;
begin
  case ClassID of
  _Zone,
  _Road,
  _Cabel:
    Result:=FEnviroments;
  _Boundary:
    Result:=nil;
  _PatrolPath:
    begin
      if  Get_GuardVariants.Count=0 then
        Result:=nil
      else
        Result:=Get_GuardVariants.Item[0];
    end;
  else
    Result:=inherited GetDefaultParent(ClassID);
  end;
end;

function TCustomFacilityModel.Get_ShowFastGuardPathToBoundary: WordBool;
begin
  Result:=FShowFastGuardPathToBoundary
end;

function TCustomFacilityModel.Get_ShowFastPathFromBoundary: WordBool;
begin
  Result:=FShowFastPathFromBoundary
end;

function TCustomFacilityModel.Get_ShowOptimalPathFromBoundary: WordBool;
begin
  Result:=FShowOptimalPathFromBoundary
end;

function TCustomFacilityModel.Get_ShowOptimalPathFromStart: WordBool;
begin
  Result:=FShowOptimalPathFromStart
end;

function TCustomFacilityModel.Get_ShowStealthPathToBoundary: WordBool;
begin
  Result:=FShowStealthPathToBoundary
end;

procedure TCustomFacilityModel.Set_ShowFastGuardPathToBoundary(Value: WordBool);
begin
  FShowFastGuardPathToBoundary:=Value
end;

procedure TCustomFacilityModel.Set_ShowFastPathFromBoundary(Value: WordBool);
begin
  FShowFastPathFromBoundary:=Value
end;

procedure TCustomFacilityModel.Set_ShowOptimalPathFromBoundary(Value: WordBool);
begin
  FShowOptimalPathFromBoundary:=Value
end;

procedure TCustomFacilityModel.Set_ShowOptimalPathFromStart(Value: WordBool);
begin
  FShowOptimalPathFromStart:=Value
end;

procedure TCustomFacilityModel.Set_ShowStealthPathToBoundary(Value: WordBool);
begin
  FShowStealthPathToBoundary:=Value
end;

function TCustomFacilityModel.Get_CurrentAnalysisVariantU: IUnknown;
begin
  Result:=FCurrentAnalysisVariant
end;

procedure TCustomFacilityModel.Set_CurrentAnalysisVariantU(
  const Value: IUnknown);
var
  Document:IDMDocument;
  AnalysisVariant:IAnalysisVariant;
  AnalyzerE:IDMElement;
begin
  FCurrentAnalysisVariant:=Value as IDMElement;
  if Value=nil then Exit;
  AnalysisVariant:=Value as IAnalysisVariant;
  Set_CurrentFacilityStateU(AnalysisVariant.FacilityState);
  Set_CurrentWarriorGroupU(AnalysisVariant.MainGroup);
  Set_CurrentReactionTime(AnalysisVariant.ResponceTime);
  Set_CurrentReactionTimeDispersion(AnalysisVariant.ResponceTimeDispersion);
  
  Document:=Get_Document as IDMDocument;
  AnalyzerE:=Document.Analyzer as IDMElement;
  if AnalyzerE<>nil then
    AnalyzerE.Update;
end;

function TCustomFacilityModel.Get_CurrentState: IDMElement;
begin
  Result:=FCurrentState
end;

procedure TCustomFacilityModel.Set_CurrentState(const Value: IDMElement);
begin
  FCurrentState:=Value
end;

function TCustomFacilityModel.Get_CurrentBoundaryTactics: IDMCollection;
begin
  case FCurrentPathStage of
  wpsStealthEntry,
  wpsStealthExit:
    Result:=FCurrentBoundaryStealthTactics;
  else
    Result:=FCurrentBoundaryFastTactics;
  end;
end;

destructor TCustomFacilityModel.Destroy;
begin
  inherited;
  FCurrentState:=nil;
  FCurrentPathArc:=nil;
  FCurrentTactic:=nil;
  FEnviroments:=nil;

  FCurrentWarriorGroup:=nil;
  FCurrentFacilityState:=nil;
  FCurrentLine:=nil;
  FCurrentSafeguardElement:=nil;
  FCurrentZone0:=nil;
  FCurrentZone1:=nil;
  FCurrentBoundary0:=nil;
  FCurrentBoundary1:=nil;
  FCurrentAnalysisVariant:=nil;

  FCurrentBoundaryStealthTactics:=nil;
  FCurrentZoneStealthTactics:=nil;
  FCurrentBoundaryFastTactics:=nil;
  FCurrentZoneFastTactics:=nil;
  FExtraTargets:=nil;
  FErrors:=nil;
  FWarnings:=nil;
  FBattleModel:=nil;
  FSafeguardSynthesis:=nil;
  FGuardArrivals:=nil;
  FVerificationGroups:=nil;

  if FEmptyBackRefHolder<>nil then begin
    FEmptyBackRefHolder.Ref:=nil;
    FEmptyBackRefHolder:=nil;
  end;
  (FBackRefHolders as IDMCollection2).Clear;
  FBackRefHolders:=nil;
  (FUserDefinedElements as IDMCollection2).Clear;
  FUserDefinedElements:=nil;

  (FZSortedBoundaries as IDMCollection2).Clear;
  FZSortedBoundaries:=nil;
  (FDSortedBoundaries as IDMCollection2).Clear;
  FDSortedBoundaries:=nil;

  FStairLayer:=nil;

  FClassCollectionIndexes_.Free;
  FClassCollectionIndexes0.Free;
end;

procedure TCustomFacilityModel.UpdateCurrentTactics;
var
  SafeguardDatabase:IDMElement;
  AdversaryGroup:IAdversaryGroup;
  WarriorGroup:IWarriorGroup;
  WarriorGroupE, TacticE:IDMElement;
  Tactics:IDMCollection;
  j:integer;
  Tactic:ITactic;
  CurrentBoundaryStealthTactics, CurrentZoneStealthTactics,
  CurrentBoundaryFastTactics, CurrentZoneFastTactics:IDMCollection2;
  AddTacticFlag:boolean;
begin
  CurrentBoundaryStealthTactics:=FCurrentBoundaryStealthTactics as IDMCollection2;
  CurrentZoneStealthTactics:=FCurrentZoneStealthTactics as IDMCollection2;
  CurrentBoundaryFastTactics:=FCurrentBoundaryFastTactics as IDMCollection2;
  CurrentZoneFastTactics:=FCurrentZoneFastTactics as IDMCollection2;
  while FCurrentBoundaryStealthTactics.Count>0 do
    CurrentBoundaryStealthTactics.Delete(0);
  while FCurrentZoneStealthTactics.Count>0 do
    CurrentZoneStealthTactics.Delete(0);
  while FCurrentBoundaryFastTactics.Count>0 do
    CurrentBoundaryFastTactics.Delete(0);
  while FCurrentZoneFastTactics.Count>0 do
    CurrentZoneFastTactics.Delete(0);
  WarriorGroupE:=FCurrentWarriorGroup;
  if WarriorGroupE=nil then Exit;
  WarriorGroup:=WarriorGroupE as IWarriorGroup;
  SafeguardDatabase:=Ref;
  if WarriorGroupE.ClassID=_AdversaryGroup then
    AdversaryGroup:=WarriorGroupE as IAdversaryGroup
  else
    AdversaryGroup:=nil;
  Tactics:=(SafeguardDatabase as ISafeguardDatabase).Tactics;
  for j:=0 to Tactics.Count-1 do begin
    TacticE:=Tactics.Item[j];
    Tactic:=TacticE as ITactic;

    if ((Tactic.EntryTactic and
       ((FCurrentPathStage=wpsStealthEntry) or (FCurrentPathStage=wpsFastEntry))) or
      (Tactic.ExitTactic and
       ((FCurrentPathStage=wpsStealthExit) or (FCurrentPathStage=wpsFastExit)))) then begin
      AddTacticFlag:=True;
      if (WarriorGroupE.ClassID=_AdversaryGroup) then begin
        if (WarriorGroup.Accesses.Count=0) and
            not Tactic.OutsiderTactic then
          AddTacticFlag:=False;
        if (WarriorGroup.Accesses.Count>0) and
          not Tactic.InsiderTactic then
          AddTacticFlag:=False;
      end else
      if (WarriorGroupE.ClassID=_GuardGroup) then begin
        if not Tactic.GuardTactic then
          AddTacticFlag:=False;
        if Tactic.DeceitTactic then
          AddTacticFlag:=False;
      end;
    end else
      AddTacticFlag:=False;

    if AddTacticFlag then begin
      if Tactic.PathArcKind=0 then begin
        if Tactic.StealthTactic then
          CurrentBoundaryStealthTactics.Add(TacticE);
        if Tactic.FastTactic then
          CurrentBoundaryFastTactics.Add(TacticE)
      end else begin
        if Tactic.StealthTactic then
          CurrentZoneStealthTactics.Add(TacticE);
        if Tactic.FastTactic then
          CurrentZoneFastTactics.Add(TacticE)
      end;
    end;
  end;
end;

function TCustomFacilityModel.Get_ExtraTargets: IDMCollection;
begin
  Result:=FExtraTargets
end;

function TCustomFacilityModel.Get_Errors: IDMCollection;
begin
  Result:=FErrors
end;

function TCustomFacilityModel.Get_Warnings: IDMCollection;
begin
  Result:=FWarnings
end;

function TCustomFacilityModel.Get_CurrentZoneTactics: IDMCollection;
begin
  case FCurrentPathStage of
  wpsStealthEntry,
  wpsStealthExit:
    Result:=FCurrentZoneStealthTactics;
  else
    Result:=FCurrentZoneFastTactics;
  end;
end;

function TCustomFacilityModel.Get_BackRefHolders: IDMCollection;
begin
  Result:=FBackRefHolders
end;

function TCustomFacilityModel.Get_ShowDetectionZones: WordBool;
begin
  Result:=FShowDetectionZones
end;

function TCustomFacilityModel.Get_ShowGraph: WordBool;
begin
  Result:=FShowGraph
end;

function TCustomFacilityModel.Get_ShowSymbols: WordBool;
begin
  Result:=FShowSymbols
end;

function TCustomFacilityModel.Get_ShowText: WordBool;
begin
  Result:=FShowText
end;

procedure TCustomFacilityModel.Set_ShowDetectionZones(Value: WordBool);
begin
  FShowDetectionZones:=Value
end;

procedure TCustomFacilityModel.Set_ShowGraph(Value: WordBool);
begin
  FShowGraph:=Value
end;

procedure TCustomFacilityModel.Set_ShowSymbols(Value: WordBool);
begin
  FShowSymbols:=Value
end;

procedure TCustomFacilityModel.Set_ShowText(Value: WordBool);
begin
  FShowText:=Value
end;

function TCustomFacilityModel.Get_TechnicalServices: IDMCollection;
begin
  Result:=Collection[_TechnicalService]
end;

function TCustomFacilityModel.Get_CurrentTactic: IDMElement;
begin
  Result:=FCurrentTactic
end;

procedure TCustomFacilityModel.Set_CurrentTactic(const Value: IDMElement);
begin
  FCurrentTactic:=Value
end;

function TCustomFacilityModel.Get_ClassCount(Mode: Integer): Integer;
begin
  case Mode of
   0:Result:=4;
  else
     Result:=0;
  end;
end;

function TCustomFacilityModel.Get_ClassCollection(Index,
  Mode: Integer): IDMCollection;
var
  SafeguardDatabase:ISafeguardDatabase;
begin
  case Mode of
  0:case Index of
    0: Result:=Get_PatrolPaths;
    1: Result:=Get_Roads;
    2: begin
        SafeguardDatabase:=Ref as ISafeguardDatabase;
        Result:=SafeguardDatabase.CabelTypes;
       end;
    3: Result:=Get_UserDefinedPaths;
    end;
  else
    Result:=nil;
  end
end;

function TCustomFacilityModel.Get_Roads: IDMCollection;
begin
  Result:=Collection[_Road]
end;

function TCustomFacilityModel.Get_UserDefinedPaths: IDMCollection;
begin
  Result:=Collection[_UserDefinedPath]
end;

function TCustomFacilityModel.Get_Accesses: IDMCollection;
begin
  Result:=Collection[_Access]
end;

function TCustomFacilityModel.Get_ShowWalls: WordBool;
begin
  Result:=FShowWalls
end;

procedure TCustomFacilityModel.Set_ShowWalls(Value: WordBool);
begin
  FShowWalls:=Value
end;

function TCustomFacilityModel.Get_DelayTimeDispersionRatio: Double;
begin
  Result:=FDelayTimeDispersionRatio
end;

function TCustomFacilityModel.Get_ResponceTimeDispersionRatio: Double;
begin
  Result:=FResponceTimeDispersionRatio
end;

procedure TCustomFacilityModel.Set_DelayTimeDispersionRatio(Value: Double);
begin
  FDelayTimeDispersionRatio:=Value
end;

procedure TCustomFacilityModel.Set_ResponceTimeDispersionRatio(Value: Double);
var
  j:integer;
  AnalysisVariants:IDMCollection;
  AnalysisVariant:IAnalysisVariant;
begin
  FResponceTimeDispersionRatio:=Value;
  AnalysisVariants:=Get_AnalysisVariants as IDMCollection;
  for j:=0 to AnalysisVariants.Count-1 do begin
    AnalysisVariant:=AnalysisVariants.Item[j] as IAnalysisVariant;
    AnalysisVariant.ResponceTimeDispersion:=sqr(FResponceTimeDispersionRatio*AnalysisVariant.ResponceTime);
  end;
end;

function TCustomFacilityModel.Get_BattleModel: IUnknown;
begin
  Result:=FBattleModel
end;

procedure TCustomFacilityModel.Set_BattleModel(const Value: IUnknown);
begin
  FBattleModel:=Value as IDataModel
end;

function TCustomFacilityModel.Get_BuildSectorLayer: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FBuildSectorLayer;
  Result:=Unk as IDMElement;
end;

procedure TCustomFacilityModel.Set_BuildSectorLayer(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FBuildSectorLayer:=Unk;
end;

function GetInnerVolumeContaining(PX, PY, PZ: Double; const OuterVolume:IVolume): IVolume;
var
  Zone:IZone;
  j:integer;
  aVolume, Volume:IVolume;
  InnerZones:IDMCollection;
begin
  Result:=nil;

  Zone:=(OuterVolume as IDMElement).Ref as IZone;
  InnerZones:=Zone.Zones;
  for j:=0 to InnerZones.Count-1 do begin
    Volume:=InnerZones.Item[j].SpatialElement as IVolume;
    if Volume<>nil then begin
      if Volume.ContainsPoint(PX, PY, PZ) then begin
        Result:=Volume;
        aVolume:=GetInnerVolumeContaining(PX, PY, PZ, Result);
        if aVolume<>nil then
          Result:=aVolume;
        Exit;
      end else begin
        aVolume:=GetInnerVolumeContaining(PX, PY, PZ, Volume);
        if aVolume<>nil then begin
          Result:=aVolume;
          Exit;
        end;
      end;
    end;
  end;
end;

function TCustomFacilityModel.GetVolumeContaining(PX, PY, PZ: Double): IVolume;
var
  aVolume:IVolume;
begin
  Result:=inherited GetVolumeContaining(PX, PY, PZ);
  if Result=nil then Exit;
  aVolume:=GetInnerVolumeContaining(PX, PY, PZ, Result);
  if aVolume<>nil then
    Result:=aVolume;
end;

function TCustomFacilityModel.Get_DefaultReactionMode: integer;
begin
  Result:=FDefaultReactionMode
end;

procedure TCustomFacilityModel.Set_DefaultReactionMode(Value: Integer);
begin
  FDefaultReactionMode:=Value
end;

procedure TCustomFacilityModel.CalcFalseAlarmPeriod(
  const FacilityStateE: IDMElement);
var
  j:integer;
  FacilityElement:IFacilityElement;
  Collection:IDMCollection;
  FalseAlarmFrequence, T:double;
begin
  FFalseAlarmPeriod:=0;

  FalseAlarmFrequence:=0;

  Collection:=Get_Boundaries;
  for j:=0 to Collection.Count-1 do begin
    FacilityElement:=Collection.Item[j] as IFacilityElement;
    FacilityElement.CalcFalseAlarmPeriod;

    T:=FacilityElement.FalseAlarmPeriod;
    if T<>0 then
      FalseAlarmFrequence:=FalseAlarmFrequence+1/T

  end;
  Collection:=Get_Zones;
  for j:=0 to Collection.Count-1 do begin
    FacilityElement:=Collection.Item[j] as IFacilityElement;
    FacilityElement.CalcFalseAlarmPeriod;

    T:=FacilityElement.FalseAlarmPeriod;
    if T<>0 then
      FalseAlarmFrequence:=FalseAlarmFrequence+1/T
  end;

  if FalseAlarmFrequence<>0 then
    FFalseAlarmPeriod:=1/FalseAlarmFrequence

end;

function TCustomFacilityModel.Get_CriticalFalseAlarmPeriod: Double;
begin
  Result:=FCriticalFalseAlarmPeriod
end;

procedure TCustomFacilityModel.Set_CriticalFalseAlarmPeriod(Value: Double);
begin
  FCriticalFalseAlarmPeriod:=Value
end;

function TCustomFacilityModel.Get_FalseAlarmPeriod: Double;
begin
  Result:=FFalseAlarmPeriod
end;

procedure TCustomFacilityModel.Set_FalseAlarmPeriod(Value: Double);
begin
  FFalseAlarmPeriod:=Value
end;

procedure TCustomFacilityModel.CheckVolumeContent(const NewVolumes:IDMCollection;
                                 const Volume:IVolume;
                                 Mode:integer);
var
  NewVolumeE, VolumeE, SafeguardElementE, 
  NewZoneE, ZoneE, aZoneE, SubZoneKindE, OuterZoneE:IDMElement;
  aVolume, NewVolume:IVolume;
  NewZone, Zone:IZone;
  ZoneS:ISafeguardUnit;
  j, m:integer;
  Line:ILine;
  Node:ICoordNode;
  PX, PY, PZ:double;
  ZoneKind:IZoneKind;
  OuterZoneU, SubZoneKindU:IUnknown;
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  S:string;
begin
  inherited;
  VolumeE:=Volume as IDMElement;
  ZoneE:=VolumeE.Ref;
  Zone:=ZoneE as IZone;
  ZoneS:=ZoneE as ISafeguardUnit;

  DMDocument:=Get_Document as IDMDocument;
  DMOperationManager:=DMDocument as IDMOperationManager;

  if Mode=0 then begin
    j:=0;
    while j<Zone.Zones.Count do begin
      aZoneE:=Zone.Zones.Item[j];
      aVolume:=aZoneE.SpatialElement as IVolume;

      NewZoneE:=nil;
      m:=0;
      while m<NewVolumes.Count do begin
        NewVolumeE:=NewVolumes.Item[m];
        NewVolume:=NewVolumeE as IVolume;
        NewZoneE:=NewVolumeE.Ref;
        NewZone:=NewZoneE as IZone;
        if NewVolume.ContainsVolume(aVolume) then
          Break
        else
          inc(m)
      end;
      if m<NewVolumes.Count then
        DMOperationManager.ChangeParent( nil, NewZoneE, aZoneE)
      else begin
        inc(j);
      end;
    end;
  end;

  j:=0;
  while j<ZoneS.SafeguardElements.Count do begin
    SafeguardElementE:=ZoneS.SafeguardElements.Item[j];
    if SafeguardElementE.SpatialElement<>nil then begin
      if SafeguardElementE.SpatialElement.QueryInterface(ILine, Line)=0 then
        Node:=Line.C0
      else
        Node:=SafeguardElementE.SpatialElement as ICoordNode;
      PX:=Node.X;
      PY:=Node.Y;
      PZ:=Node.Z;
      NewZoneE:=nil;
      m:=0;
      while m<NewVolumes.Count do begin
        NewVolumeE:=NewVolumes.Item[m];
        NewVolume:=NewVolumeE as IVolume;
        NewZoneE:=NewVolumeE.Ref;
        NewZone:=NewZoneE as IZone;
        if NewVolume.ContainsPoint(PX, PY, PZ) then
          Break
        else
          inc(m)
      end;
      if m<NewVolumes.Count then
        DMOperationManager.ChangeParent( nil, NewZoneE, SafeguardElementE)
      else
        inc(j)
    end else  //if SafeguardElementE.SpatialElement=nil
      inc(j);
  end;  //while j<Zone.SafeguardElements.Count

  ZoneKind:=ZoneE.Ref as IZoneKind;
  if Mode=0 then
    SubZoneKindE:=ZoneKind.HSubZoneKind
  else
    SubZoneKindE:=ZoneKind.VSubZoneKind;
  SubZoneKindU:=SubZoneKindE as IUnknown;
  if SubZoneKindE<>nil then begin
    S:=ZoneE.Name;
    DMOperationManager.AddElement( ZoneE.Parent,
                         Get_Zones, '', ltOneToMany, OuterZoneU, True);
    DMOperationManager.ChangeRef( nil,
                        S, ZoneE.Ref as IUnknown, OuterZoneU);
    OuterZoneE:=OuterZoneU as IDMElement;

    DMOperationManager.ChangeParent( nil, OuterZoneE, ZoneE);
    S:=GetDefaultName(SubZoneKindE);
    DMOperationManager.ChangeRef( nil,
                        S, SubZoneKindU, ZoneE as IUnknown);
    for m:=0 to NewVolumes.Count-1 do begin
      NewVolumeE:=NewVolumes.Item[m];
      NewZoneE:=NewVolumeE.Ref;
      NewZone:=NewZoneE as IZone;
      DMOperationManager.ChangeParent( nil, OuterZoneE, NewZoneE);

      S:=GetDefaultName(SubZoneKindE);
      DMOperationManager.ChangeRef( nil,
                        S, SubZoneKindU, NewZoneE as IUnknown);
    end;
  end;
end;

function TCustomFacilityModel.Get_UserDefinedElements: IDMCollection;
begin
  Result:=FUserDefinedElements;
end;

function TCustomFacilityModel.Get_UseBattleModel: WordBool;
begin
  Result:=FUseBattleModel
end;

procedure TCustomFacilityModel.Set_UseBattleModel(Value: WordBool);
begin
  FUseBattleModel:=Value
end;

function TCustomFacilityModel.CanDeleteNow(const aElement: IDMElement;
  const DeleteCollection: IDMCollection): WordBool;
var
  aZone:IZone;
  j, m:integer;
  DeleteCollection2: IDMCollection2;
  aVolumeE:IDMElement;
  ZoneCount:integer;
begin
  Result:=True;
  if aElement.ClassID=_Volume then begin
    aZone:=aElement.Ref as IZone;
    if aZone=nil then Exit;
    ZoneCount:=0;
    for m:=0 to aZone.Zones.Count-1 do begin
      aVolumeE:=aZone.Zones.Item[m].SpatialElement;
      if aVolumeE<>nil then
        inc(ZoneCount)
    end;
    if ZoneCount=0 then
      Result:=True
    else begin
      Result:=False;
      DeleteCollection2:=DeleteCollection as IDMCollection2;
      j:=DeleteCollection.IndexOf(aElement);
      for m:=0 to aZone.Zones.Count-1 do begin
        aVolumeE:=aZone.Zones.Item[m].SpatialElement;
        if aVolumeE<>nil then
          DeleteCollection2.Insert(j, aVolumeE);
      end;
    end;
  end else
    Result:=True;
end;

function TCustomFacilityModel.Get_ReliefLayer: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FReliefLayer;
  Result:=Unk as IDMElement
end;

procedure TCustomFacilityModel.Set_ReliefLayer(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FReliefLayer:=Unk;
end;

function TCustomFacilityModel.Get_BuildAllVerticalWays: WordBool;
begin
  Result:=FBuildAllVerticalWays
end;

procedure TCustomFacilityModel.Set_BuildAllVerticalWays(Value: WordBool);
begin
  FBuildAllVerticalWays:=Value
end;

procedure TCustomFacilityModel.GetFieldValueSource(Code: Integer; var aCollection: IDMCollection);
begin
  inherited;
end;

class function TCustomFacilityModel.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TCustomFacilityModel.MakeFields;
var
  S:string;
begin
  inherited;

  AddField(rsDefaultVerticalAreaWidth, '%0.2f', '', '',
                 fvtFloat, 1.5, 0, 0,
                 ord(fmDefaultVerticalAreaWidth), 0, mpkCurrent); //mpkBuild);
  AddField(rsDefaultObjectWidth, '%0.2f', '', '',
                 fvtFloat, 2, 0, 0,
                 ord(fmDefaultObjectWidth), 0, mpkCurrent); //mpkBuild);
  AddField(rsDefaultVolumeHeight, '%0.2f', '', '',
                 fvtFloat, 3, 0, 0,
                 ord(fmDefaultVolumeHeight), 0, mpkCurrent); //mpkBuild);
  AddField(rsDefaultOpenZoneHeight, '%0.2f', '', '',
                 fvtFloat, 30, 0, 0,
                 ord(fmDefaultOpenZoneHeight), 0, mpkBuild);

  AddField(rsShowOnlyBoundaryAreas, '', '', '',
                  fvtBoolean, 0, 0, 1,
                  ord(fmShowOnlyBoundaryAreas), 0, mpkView);
  S:='!Не закрашивать области'+
     '!Закрасить области явно заданным цветом'+
     '!Поле вероятности успеха нарушителей'+
     '!Поле времени задержки нарушителей'+
     '!Поле вероятности обнаружения нарушителей'+
     '!Поле времени прибытия охраны';
  AddField(rsRenderAreasMode, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(fmRenderAreasMode), 0, mpkCurrent); //mpkView);
  AddField(rsShowText, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmShowText), 0, mpkView);
  AddField(rsShowSymbols, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmShowSymbols), 0, mpkView);
  AddField(rsShowWalls, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmShowWalls), 0, mpkCurrent); //mpkView);
  AddField(rsShowDetectionZones, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmShowDetectionZones), 0, mpkView);
  AddField(rsUseBattleModel, '', '', '',
                  fvtBoolean, 0, 0, 1,
                  ord(fmUseBattleModel), 0, mpkCurrent); //mpkAnalysis);
  AddField(rsUseSimpleBattleModel, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmUseSimpleBattleModel), 0, mpkAnalysis);
  AddField(rsBuildAllVerticalWays, '', '', '',
                  fvtBoolean, 0, 0, 1,
                  ord(fmBuildAllVerticalWays), 0, mpkCurrent); //mpkAnalysis);
  AddField(rsDelayTimeDispersionRatio, '%0.2f', '', '',
                  fvtFloat, 0.2, 0, 0,
                  ord(fmDelayTimeDispersionRatio), 0, mpkAnalysis);
  AddField(rsZoneDelayTimeDispersionRatio, '%0.2f', '', '',
                  fvtFloat, 0.13, 0, 0,
                  ord(fmZoneDelayTimeDispersionRatio), 0, mpkAnalysis);
  AddField(rsResponceTimeDispersionRatio, '%0.2f', '', '',
                  fvtFloat, 0.13, 0, 0,
                  ord(fmResponceTimeDispersionRatio), 0, mpkAnalysis);
  S:='!Отсутствует'+
     '!Всегда'+
     '!В половине случаев'+
     '!Зависит общей от частоты ложных тревог'+
     '!Зависит от частоты ложных тревог на рубеже';
  AddField(rsDefaultReactionMode, S, '', '',
                  fvtChoice, 1, 0, 0,
                  ord(fmDefaultReactionMode), 0, mpkAnalysis);
  AddField(rsCriticalFalseAlarmPeriod, '%0.2f', '', '',
                  fvtFloat, 0, 0, 0,
                  ord(fmCriticalFalseAlarmPeriod), 0, mpkAnalysis);
{
  AddField(rsCurrencyRate, '%0.2f', '', '',
                  fvtFloat, 30, 0, 0,
                  ord(fmCurrencyRate), 0, mpkCurrent, mpkPrice);
  AddField(rsPriceCoeffD, '%0.2f', '', '',
                  fvtFloat, 0.08, 0, 0,
                  ord(fmPriceCoeffD), 0, mpkPrice);
  AddField(rsPriceCoeffTZSR, '%0.2f', '', '',
                  fvtFloat, 0.14, 0, 0,
                  ord(fmPriceCoeffTZSR), 0, mpkPrice);
  AddField(rsPriceCoeffPNR, '%0.2f', '', '',
                  fvtFloat, 0.3, 0, 0,
                  ord(fmPriceCoeffPNR), 0, mpkPrice);
  S:='!Оценка снизу'+
     '!Усредненная оценка';
  AddField(rsTotalEfficiencyCalcMode, S, '', '',
                  fvtChoice, 0, 0, 0,
                  ord(fmTotalEfficiencyCalcMode), 0, mpkPrice);
}
  AddField(rsShowGraph, '', '', '',
                  fvtBoolean, 0, 0, 1,
                  ord(fmShowGraph), 0, mpkView);
  AddField(rsGraphColor, '%d', '', '',
                  fvtColor, $808080, 0, 0,
                  ord(fmGraphColor), 0, mpkCurrent); //mpkView);
  AddField(rsFastPathColor, '%d', '', '',
                  fvtColor, $0000FF, 0, 0,
                  ord(fmFastPathColor), 0, mpkCurrent); //mpkView);
  AddField(rsStealthPathColor, '%d', '', '',
                  fvtColor, $FF0000, 0, 0,
                  ord(fmStealthPathColor), 0, mpkCurrent); //mpkView);
  AddField(rsRationalPathColor, '%d', '', '',
                  fvtColor, $880088, 0, 0,
                  ord(fmRationalPathColor), 0, mpkCurrent); //mpkView);
  AddField(rsGuardPathColor, '%d', '', '',
                  fvtColor, $00FF00, 0, 0,
                  ord(fmGuardPathColor), 0, mpkCurrent); //mpkView);
  AddField(rsShowOptimalPathFromBoundary, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmShowOptimalPathFromBoundary), 0, mpkCurrent); //mpkView);
  AddField(rsShowFastPathFromBoundary, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmShowFastPathFromBoundary), 0, mpkCurrent); //mpkView);
  AddField(rsShowStealthPathToBoundary, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmShowStealthPathToBoundary), 0, mpkCurrent); //mpkView);
  AddField(rsShowFastGuardPathToBoundary, '', '', '',
                  fvtBoolean, 0, 0, 1,
                  ord(fmShowFastGuardPathToBoundary), 0, mpkCurrent); //mpkView);
  AddField(rsShowOptimalPathFromStart, '', '', '',
                  fvtBoolean, 1, 0, 1,
                  ord(fmShowOptimalPathFromStart), 0, mpkView);

  AddField(rsPathHeight, '%0.0f', '', '',
                          fvtFloat, 100, 0, 0,
                  ord(fmPathHeight), 0, mpkAnalysis);

  AddField(rsShoulderWidth, '%0.0f', '', '',
                  fvtFloat, 100, 0, 0,
                  ord(fmShoulderWidth), 0, mpkAnalysis);

end;

function TCustomFacilityModel.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(fmDefaultVerticalAreaWidth):
    Result:=FDefaultVerticalAreaWidth;
  ord(fmDefaultObjectWidth):
    Result:=FDefaultObjectWidth;
  ord(fmDefaultVolumeHeight):
    Result:=FDefaultVolumeHeight;
  ord(fmDefaultOpenZoneHeight):
    Result:=FDefaultOpenZoneHeight;

  ord(fmShowOptimalPathFromBoundary):
    Result:=FShowOptimalPathFromBoundary;
  ord(fmShowFastPathFromBoundary):
    Result:=FShowFastPathFromBoundary;
  ord(fmShowStealthPathToBoundary):
    Result:=FShowStealthPathToBoundary;
  ord(fmShowFastGuardPathToBoundary):
    Result:=FShowFastGuardPathToBoundary;
  ord(fmShowOptimalPathFromStart):
    Result:=FShowOptimalPathFromStart;
  ord(fmShowGraph):
    Result:=FShowGraph;
  ord(fmShowText):
    Result:=FShowText;
  ord(fmShowSymbols):
    Result:=FShowSymbols;
  ord(fmShowWalls):
    Result:=FShowWalls;
  ord(fmShowDetectionZones):
    Result:=FShowDetectionZones;
  ord(fmShowOnlyBoundaryAreas):
    Result:=FShowOnlyBoundaryAreas;
  ord(fmUseBattleModel):
    Result:=FUseBattleModel;
  ord(fmUseSimpleBattleModel):
    Result:=FUseSimpleBattleModel;
  ord(fmBuildAllVerticalWays):
    Result:=FBuildAllVerticalWays;
  ord(fmDelayTimeDispersionRatio):
    Result:=FDelayTimeDispersionRatio;
  ord(fmZoneDelayTimeDispersionRatio):
    Result:=FZoneDelayTimeDispersionRatio;
  ord(fmResponceTimeDispersionRatio):
    Result:=FResponceTimeDispersionRatio;
  ord(fmDefaultReactionMode):
    Result:=FDefaultReactionMode;
  ord(fmCriticalFalseAlarmPeriod):
    Result:=FCriticalFalseAlarmPeriod;
  ord(fmCurrencyRate):
    Result:=FCurrencyRate;
  ord(fmPriceCoeffD):
    Result:=FPriceCoeffD;
  ord(fmPriceCoeffTZSR):
    Result:=FPriceCoeffTZSR;
  ord(fmPriceCoeffPNR):
    Result:=FPriceCoeffPNR;
  ord(fmTotalEfficiencyCalcMode):
    Result:=FTotalEfficiencyCalcMode;
  ord(fmGraphColor):
    Result:=FGraphColor;
  ord(fmFastPathColor):
    Result:=FFastPathColor;
  ord(fmStealthPathColor):
    Result:=FStealthPathColor;
  ord(fmRationalPathColor):
    Result:=FRationalPathColor;
  ord(fmGuardPathColor):
    Result:=FGuardPathColor;
  ord(fmMaxBoundaryDistance):
    Result:=FMaxBoundaryDistance;
  ord(fmMaxPathAlongBoundaryDistance):
    Result:=FMaxPathAlongBoundaryDistance;
  ord(fmShoulderWidth):
    Result:=FShoulderWidth;
  ord(fmPathHeight):
    Result:=FPathHeight;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TCustomFacilityModel.SetFieldValue(Code: integer; Value: OleVariant);
var
  Document:IDMDocument;
begin
  case Code of
  ord(fmDefaultVerticalAreaWidth):
    FDefaultVerticalAreaWidth:=Value;
  ord(fmDefaultObjectWidth):
    FDefaultObjectWidth:=Value;
  ord(fmDefaultVolumeHeight):
    FDefaultVolumeHeight:=Value;
  ord(fmDefaultOpenZoneHeight):
    FDefaultOpenZoneHeight:=Value;

  ord(fmShowOptimalPathFromBoundary):
    FShowOptimalPathFromBoundary:=Value;
  ord(fmShowFastPathFromBoundary):
    FShowFastPathFromBoundary:=Value;
  ord(fmShowStealthPathToBoundary):
    FShowStealthPathToBoundary:=Value;
  ord(fmShowFastGuardPathToBoundary):
    FShowFastGuardPathToBoundary:=Value;
  ord(fmShowOptimalPathFromStart):
    FShowOptimalPathFromStart:=Value;
  ord(fmShowGraph):
    FShowGraph:=Value;
  ord(fmShowText):
    FShowText:=Value;
  ord(fmShowSymbols):
    FShowSymbols:=Value;
  ord(fmShowWalls):
    FShowWalls:=Value;
  ord(fmShowDetectionZones):
    FShowDetectionZones:=Value;
  ord(fmShowOnlyBoundaryAreas):
    FShowOnlyBoundaryAreas:=Value;
  ord(fmUseBattleModel):
    FUseBattleModel:=Value;
  ord(fmUseSimpleBattleModel):
    FUseSimpleBattleModel:=Value;
  ord(fmBuildAllVerticalWays):
    FBuildAllVerticalWays:=Value;
  ord(fmDelayTimeDispersionRatio):
    FDelayTimeDispersionRatio:=Value;
  ord(fmZoneDelayTimeDispersionRatio):
    FZoneDelayTimeDispersionRatio:=Value;
  ord(fmResponceTimeDispersionRatio):
    FResponceTimeDispersionRatio:=Value;
  ord(fmDefaultReactionMode):
    FDefaultReactionMode:=Value;
  ord(fmCriticalFalseAlarmPeriod):
    FCriticalFalseAlarmPeriod:=Value;
  ord(fmCurrencyRate):
    FCurrencyRate:=Value;
  ord(fmPriceCoeffD):
    FPriceCoeffD:=Value;
  ord(fmPriceCoeffTZSR):
    FPriceCoeffTZSR:=Value;
  ord(fmPriceCoeffPNR):
    FPriceCoeffPNR:=Value;
  ord(fmTotalEfficiencyCalcMode):
    FTotalEfficiencyCalcMode:=Value;
  ord(fmGraphColor):
    FGraphColor:=Value;
  ord(fmFastPathColor):
    FFastPathColor:=Value;
  ord(fmStealthPathColor):
    FStealthPathColor:=Value;
  ord(fmRationalPathColor):
    FRationalPathColor:=Value;
  ord(fmGuardPathColor):
    FGuardPathColor:=Value;
  ord(fmMaxBoundaryDistance):
    Set_MaxBoundaryDistance(Value);
  ord(fmMaxPathAlongBoundaryDistance):
    Set_MaxPathAlongBoundaryDistance(Value);
  ord(fmShoulderWidth):
    Set_ShoulderWidth(Value);
  ord(fmPathHeight):
    FPathHeight:=Value;
  else
    inherited;
  end;

  if Get_IsLoading then Exit;

  case Code of
  ord(fmShowOptimalPathFromBoundary),
  ord(fmShowFastPathFromBoundary),
  ord(fmShowStealthPathToBoundary),
  ord(fmShowFastGuardPathToBoundary),
  ord(fmShowOptimalPathFromStart),
  ord(fmShowGraph),
  ord(fmShowText),
  ord(fmShowSymbols),
  ord(fmShowWalls),
  ord(fmShowDetectionZones),
  ord(fmShowOnlyBoundaryAreas),
  ord(fmGraphColor),
  ord(fmFastPathColor),
  ord(fmStealthPathColor),
  ord(fmRationalPathColor),
  ord(fmGuardPathColor):
    begin
      Document:=Get_Document as IDMDocument;
      if Document<>nil then
        Document.Server.RefreshDocument(rfFrontBack);
    end;
  end;

end;

function TCustomFacilityModel.Get_WarriorPathElements: IDMCollection;
begin
  Result:=Collection[_WarriorPathElement]
end;

function TCustomFacilityModel.Get_CalcOptimalPathFlag: WordBool;
begin
  Result:=FCalcOptimalPathFlag;
end;

procedure TCustomFacilityModel.Set_CalcOptimalPathFlag(Value: WordBool);
begin
  FCalcOptimalPathFlag:=Value
end;

procedure TCustomFacilityModel.AfterLoading2;
var
  Sorter:ISorter;
  Recomendations2:IDMCollection2;
begin
  UpdateVolumes;
  inherited;

  Recomendations2:=Get_FMRecomendations as IDMCollection2;
  Sorter:=TFMRecomendationSorter.Create(nil) as ISorter;
  Recomendations2.Sort(Sorter);
end;

procedure TCustomFacilityModel.AfterPaste;
var
  j, k:integer;
  FacilitySubStates:IDMCollection;
  FacilitySubStatesU:IUnknown;
  FacilitySubStates2:IDMCollection2;
  FacilitySubStateE, aFacilitySubStateE, ElementStateE:IDMElement;
  FacilitySubState, aFacilitySubState:IFacilitySubState;
  DMOperationManager:IDMOperationManager;
begin
  inherited;
  DMOperationManager:=Get_Document as IDMOperationManager;
  FacilitySubStates:=Get_FacilitySubStates;
  FacilitySubStates2:=FacilitySubStates as IDMCollection2;
  FacilitySubStatesU:=FacilitySubStates as IUnknown;
  j:=FLastSubStateIndex;
  while j<FacilitySubStates.Count do begin
    FacilitySubStateE:=FacilitySubStates.Item[j];
    aFacilitySubStateE:=nil;
    k:=0;
    while k<FLastSubStateIndex do begin
      aFacilitySubStateE:=FacilitySubStates.Item[k];
      if aFacilitySubStateE.Name=FacilitySubStateE.Name then
        Break
      else
        inc(k)
    end;
    if k<FLastSubStateIndex then begin
      FacilitySubState:=FacilitySubStateE as IFacilitySubState;
      aFacilitySubState:=aFacilitySubStateE as IFacilitySubState;
      while FacilitySubState.ElementStates.Count>0 do begin
        ElementStateE:=FacilitySubState.ElementStates.Item[0];
        DMOperationManager.ChangeRef(nil, '', aFacilitySubStateE  as IUnknown,
                                             ElementStateE as IUnknown);
      end;
      DMOperationManager.DeleteElement(nil, FacilitySubStatesU, ltOneToMany,
                                     FacilitySubStateE as IUnknown);
    end else
      inc(j)
  end;
end;

procedure TCustomFacilityModel.BeforePaste;
begin
  inherited;
  FLastSubStateIndex:=Get_FacilitySubStates.Count;
end;

function TCustomFacilityModel.Get_Connections: IDMCollection;
begin
  Result:=Collection[_Connection]
end;

function TCustomFacilityModel.Get_ControlDevices: IDMCollection;
begin
  Result:=Collection[_ControlDevice]
end;

function TCustomFacilityModel.Get_CurrencyRate: Double;
begin
  Result:=FCurrencyRate
end;

function TCustomFacilityModel.Get_PriceCoeffD: Double;
begin
  Result:=FPriceCoeffD
end;

function TCustomFacilityModel.Get_PriceCoeffTZSR: Double;
begin
  Result:=FPriceCoeffTZSR
end;

function TCustomFacilityModel.Get_PriceCoeffPNR: Double;
begin
  Result:=FPriceCoeffPNR
end;

procedure TCustomFacilityModel.Set_CurrencyRate(Value: Double);
begin
  FCurrencyRate:=Value
end;

procedure TCustomFacilityModel.Set_PriceCoeffD(Value: Double);
begin
  FPriceCoeffD:=Value
end;

procedure TCustomFacilityModel.Set_PriceCoeffTZSR(Value: Double);
begin
  FPriceCoeffTZSR:=Value
end;

procedure TCustomFacilityModel.Set_PriceCoeffPNR(Value: Double);
begin
  FPriceCoeffPNR:=Value
end;

function TCustomFacilityModel.Get_SafeguardSynthesis: IDataModel;
begin
  Result:=FSafeguardSynthesis
end;

function TCustomFacilityModel.Get_CriticalPoints: IDMCollection;
begin
  Result:=Collection[_CriticalPoint]
end;

function TCustomFacilityModel.Get_FMRecomendations: IDMCollection;
begin
  Result:=Collection[_FMRecomendation]
end;

function TCustomFacilityModel.Get_TotalEfficiencyCalcMode: Integer;
begin
  Result:=FTotalEfficiencyCalcMode
end;

procedure TCustomFacilityModel.Set_TotalEfficiencyCalcMode(Value: Integer);
begin
  FTotalEfficiencyCalcMode:=Value;
end;

function TCustomFacilityModel.Get_TotalEfficiency: Double;
begin
  Result:=FTotalEfficiency
end;

function TCustomFacilityModel.Get_TotalPrice: Double;
begin
  Result:=FTotalPrice
end;

procedure TCustomFacilityModel.CalcEfficiency;
var
  j:integer;
  CriticalPoints:IDMCollection;
  CriticalPoint:ICriticalPoint;
  WarriorPath:IWarriorPath;
  Efficiency:double;
begin
  CriticalPoints:=Get_CriticalPoints;
  FTotalEfficiency:=1;
  for j:=0 to CriticalPoints.Count-1 do begin
    CriticalPoint:=CriticalPoints.Item[j] as ICriticalPoint;
    WarriorPath:=CriticalPoint.WarriorPath as IWarriorPath;
    WarriorPath.Analysis;
    Efficiency:=1-WarriorPath.RationalProbability;
    if FTotalEfficiency>Efficiency then
      FTotalEfficiency:=Efficiency;
  end;
end;

procedure TCustomFacilityModel.CalcPrice(ModificationStage: Integer);
var
  Summ0, Summ1, Summ2, Summ3, Summ4,
  aPrice, M, InstallCoeff, aPriceM, aPriceI:double;
  Price:IPrice;
  BackRefHolders, aLinesB:IDMCollection;
  j, e, l:integer;
  BackRefHolder:IDMBackRefHolder;
  aElement:IDMElement;
  Goods:IGoods;
  aArea:IArea;
  C:double;
//  ElementName, Dimensionб PriceDimension:string;
begin
      Summ0:=0;
      Summ1:=0;
      BackRefHolders:=Get_BackRefHolders;
      for j:=0 to BackRefHolders.Count-1 do begin
        try
//        ShowFlag:=False;
        if BackRefHolders.Item[j].Ref.QueryInterface(IPrice, Price)=0 then begin
//          ElementName:=aCollection.Item[j].Ref.Name;
          aPrice:=Price.Price;
          BackRefHolder:=BackRefHolders.Item[j] as IDMBackRefHolder;

          M:=0;
          InstallCoeff:=0;
          for e:=0 to BackRefHolder.BackRefs.Count-1 do begin
          aElement:=BackRefHolder.BackRefs.Item[e];
          if aElement.QueryInterface(IGoods, Goods)=0 then begin
            InstallCoeff:=Goods.InstallCoeff;
            if (aElement.Parent<>nil) and
               (aElement.Presence>0) and
               (aElement.Presence<=ModificationStage) and
               (Goods.DeviceCount>0) then
              case Price.PriceDimension of
              pdPerPieceR,
              pdPerPieceU:
                begin
                  M:=M+Goods.DeviceCount;
                end;
              pdPerLengthR,
              pdPerLengthU:
                begin
                  if aElement.ClassID=_Cabel then begin
                    aLinesB:=(aElement.SpatialElement as IPolyline).Lines;
                    for l:=0 to aLinesB.Count-1 do
                      M:=M+(aLinesB.Item[l] as ILine).Length*0.01;
                  end else
                  if (aElement.Parent<>nil) and
                     (aElement.Parent.Parent<>nil) and
                     (aElement.Parent.Parent.ClassID=_Boundary) then begin
                    aLinesB:=(aElement.Parent.Parent.SpatialElement as IArea).BottomLines;
                    for l:=0 to aLinesB.Count-1 do
                      M:=M+(aLinesB.Item[l] as ILine).Length*0.01;
                  end
                end;
              pdPerSquareR,
              pdPerSquareU:
                begin
                  if (aElement.Parent<>nil) and
                     (aElement.Parent.Parent<>nil) and
                     (aElement.Parent.Parent.ClassID=_Boundary) then begin
                    aArea:=aElement.Parent.Parent.SpatialElement as IArea;
                    M:=M+aArea.Square*0.0001;
                  end;
                end;
              pdPerVolumeR,
              pdPerVolumeU:
                begin
                end;
              pdPerComplectR,
              pdPerComplectU:
                begin
                end;
              end; //  case Price.PriceDimension
          end else//if aElement.QueryInterface(ISafeguardElement, SafeguardElement)=0
            M:=M+0;
          end; //for e:=0 to BackRefHolder.BackRefs.Count-1

          if M>0 then begin
            case Price.PriceDimension of
            pdPerPieceR:
              begin
//                PriceDimension:=rsPerPieceR;
                C:=1;
//                Dimension:='шт.';
              end;
            pdPerPieceU:
              begin
//                PriceDimension:=rsPerPieceU;
                C:=FCurrencyRate;
//                Dimension:='шт.';
              end;
            pdPerLengthR:
              begin
//                PriceDimension:=rsPerLengthR;
                C:=1;
//                Dimension:='м';
              end;
            pdPerLengthU:
              begin
//                PriceDimension:=rsPerLengthU;
                C:=FCurrencyRate;
//                Dimension:='м';
              end;
            pdPerSquareR:
              begin
//                PriceDimension:=rsPerSquareR;
                C:=1;
//                Dimension:='кв.м';
              end;
            pdPerSquareU:
              begin
//                PriceDimension:=rsPerSquareU;
                C:=FCurrencyRate;
//                Dimension:='кв.м';
              end;
            pdPerVolumeR:
              begin
//                PriceDimension:=rsPerVolumeR;
                C:=1;
//                Dimension:='куб.м';
              end;
            pdPerVolumeU:
              begin
//                PriceDimension:=rsPerVolumeU;
                C:=FCurrencyRate;
//                Dimension:='куб.м';
              end;
            pdPerComplectR:
              begin
//               PriceDimension:=rsPerComplectR;
                C:=1;
//                Dimension:='компл.';
              end;
            pdPerComplectU:
              begin
//                PriceDimension:=rsPerComplectU;
                C:=FCurrencyRate;
//                Dimension:='компл.';
              end;
            else
              begin
//                PriceDimension:='';
                C:=1;
              end;
            end; //  case Price.PriceDimension

            aPriceM:=aPrice*M*C;
            aPriceI:=aPriceM*InstallCoeff;
            Summ0:=Summ0+aPriceM;
            Summ1:=Summ1+aPriceI;
{
            i:=PriceTable.RowCount;
            PriceTable.RowCount:=i+1;
            PriceTable.Cells[0,i]:=ElementName;
            PriceTable.Cells[1,i]:=Format('%0.2n',[aPrice]);
            PriceTable.Cells[2,i]:=PriceDimension;
            PriceTable.Cells[3,i]:=Format('%0.0n %s',[M, Dimension]);
            PriceTable.Cells[4,i]:=Format('%0.2n руб.',[aPriceM]);
            PriceTable.Cells[5,i]:=Format('%0.2n руб.',[aPriceI]);
}
          end; //  if M>0
        end;  // if aCollection.Item[j].Ref.QueryInterface(IPrice, Price)=0
        except
           HandleError('Error in TCustomFacilityModel.CalcPrice');
        end;
      end;  // for j:=0 to aCollection.Count-1

      Summ2:=Summ1*FPriceCoeffPNR;
      Summ3:=Summ0*FPriceCoeffD;
      Summ4:=Summ0*FPriceCoeffTZSR;
      FTotalPrice:=Summ0+Summ1+Summ2+Summ3+Summ4;

end;

procedure TCustomFacilityModel.MakeRecomendations;
var
  RecomendationE:IDMElement;
  Recomendation:IFMRecomendation;
  AnalysisVariants, Recomendations, CriticalPoints:IDMCollection;
  Recomendations2:IDMCollection2;
  j:integer;
  CriticalPoint:ICriticalPoint;
  WeightSum, MinWeight, MaxWeight, MaxPriority:double;
  AnalysisVariant:IAnalysisVariant;
  Sorter:ISorter;
begin
  Recomendations:=Get_FMRecomendations as IDMCollection;
  Recomendations2:=Recomendations as IDMCollection2;

  while Recomendations.Count>0 do begin
    RecomendationE:=Recomendations.Item[Recomendations.Count-1];
    Recomendations2.Remove(RecomendationE);
  end;

  CriticalPoints:=Get_CriticalPoints;
  for j:=0 to CriticalPoints.Count-1 do begin
    CriticalPoint:=CriticalPoints.Item[j] as ICriticalPoint;
    CriticalPoint.MakeRecomendations(rcDelayTime);
    CriticalPoint.MakeRecomendations(rcDetectionProbability);
  end;

  AnalysisVariants:=Get_AnalysisVariants;
  WeightSum:=0;
  for j:=0 to AnalysisVariants.Count-1 do begin
    AnalysisVariant:=AnalysisVariants.Item[j] as IAnalysisVariant;
    WeightSum:=WeightSum+AnalysisVariant.VariantWeight;
  end;
  if WeightSum=0 then Exit;

  MinWeight:=InfinitValue;
  MaxWeight:=0;
  for j:=0 to Recomendations.Count-1 do begin
    Recomendation:=Recomendations.Item[j] as IFMRecomendation;
    Recomendation.Priority:=Recomendation.Priority/WeightSum;
    if MinWeight>Recomendation.Priority then
      MinWeight:=Recomendation.Priority;
    if MaxWeight<Recomendation.Priority then
      MaxWeight:=Recomendation.Priority;
  end;
  if MinWeight=0 then Exit;

  MaxPriority:=ceil(MaxWeight/MinWeight);
  for j:=0 to Recomendations.Count-1 do begin
    Recomendation:=Recomendations.Item[j] as IFMRecomendation;
    Recomendation.Priority:=MaxPriority-ceil(Recomendation.Priority/MinWeight)+1;
  end;

  Sorter:=TFMRecomendationSorter.Create(nil) as ISorter;
  Recomendations2.Sort(Sorter);

  try
  for j:=0 to Recomendations.Count-1 do begin
    Recomendation:=Recomendations.Item[j] as IFMRecomendation;
    Recomendation.MakeText;
  end;

  except
    HandleError('Error in TCustomFacilityModel.MakeRecomendations');
  end;

end;

procedure TCustomFacilityModel.MakePersistant;
var
  j, m:integer;
  Collection:IDMCollection;
  SafeguardUnit2:ISafeguardUnit2;
  Boundary:IBoundary;
  SubStateE:IDMElement;
  SubStates:IDMCollection;
  DMOperationManager:IDMOperationManager;
  Unk:IUnknown;
  CurrentFacilityStateE:IDMElement;
begin
  SubStates:=Get_FacilitySubStates;

  DMOperationManager:=Get_Document as  IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, rsMakePersistant);
  DMOperationManager.AddElement(nil, SubStates, rsEquipmentRecomendation, ltOneToMany, Unk, True);

  CurrentFacilityStateE:=FCurrentFacilityState;
  SubStateE:=Unk as IDMElement;
  DMOperationManager.AddElementParent(CurrentFacilityStateE, SubStateE);

  Collection:=Get_Boundaries;
  for j:=0 to Collection.Count-1 do begin
    Boundary:=Collection.Item[j] as IBoundary;
    for m:=0 to Boundary.BoundaryLayers.Count-1 do begin
      SafeguardUnit2:=Boundary.BoundaryLayers.Item[m] as ISafeguardUnit2;
      SafeguardUnit2.MakePersistant(SubStateE);
    end;
  end;

  Collection:=Get_Targets;
  for j:=0 to Collection.Count-1 do begin
    Boundary:=Collection.Item[j] as IBoundary;
    for m:=0 to Boundary.BoundaryLayers.Count-1 do begin
      SafeguardUnit2:=Boundary.BoundaryLayers.Item[m] as ISafeguardUnit2;
      SafeguardUnit2.MakePersistant(SubStateE);
    end;
  end;

  Collection:=Get_ControlDevices;
  for j:=0 to Collection.Count-1 do begin
    Boundary:=Collection.Item[j] as IBoundary;
    for m:=0 to Boundary.BoundaryLayers.Count-1 do begin
      SafeguardUnit2:=Boundary.BoundaryLayers.Item[m] as ISafeguardUnit2;
      SafeguardUnit2.MakePersistant(SubStateE);
    end;
  end;

  Collection:=Get_Zones;
  for j:=0 to Collection.Count-1 do begin
    SafeguardUnit2:=Collection.Item[j] as ISafeguardUnit2;
    SafeguardUnit2.MakePersistant(SubStateE);
  end;
end;

function TCustomFacilityModel.Get_FindCriticalPointsFlag: WordBool;
begin
  Result:=FFindCriticalPointsFlag
end;

procedure TCustomFacilityModel.Set_FindCriticalPointsFlag(Value: WordBool);
begin
  FFindCriticalPointsFlag:=Value
end;

function TCustomFacilityModel.Get_EmptyBackRefHolder: IDMElement;
begin
  Result:=FEmptyBackRefHolder
end;

procedure TCustomFacilityModel.Set_EmptyBackRefHolder(const Value: IDMElement);
begin
  FEmptyBackRefHolder:=Value
end;

function TCustomFacilityModel.Get_CurrentZoneFastTactics: IDMCollection;
begin
  Result:=FCurrentZoneFastTactics
end;

function TCustomFacilityModel.Get_CurrentZoneStealthTactics: IDMCollection;
begin
  Result:=FCurrentZoneStealthTactics
end;

function TCustomFacilityModel.Get_UpdateDependingElementsBestMethodsFlag: WordBool;
begin
  Result:=FUpdateDependingElementsBestMethodsFlag
end;

procedure TCustomFacilityModel.Set_UpdateDependingElementsBestMethodsFlag(
  Value: WordBool);
begin
  FUpdateDependingElementsBestMethodsFlag:=Value
end;

function TCustomFacilityModel.Get_TotalBackPathDelayTime: double;
begin
  Result:=FTotalBackPathDelayTime
end;

function TCustomFacilityModel.Get_TotalBackPathDelayTimeDispersion: double;
begin
  Result:=FTotalBackPathDelayTimeDispersion
end;

procedure TCustomFacilityModel.Set_TotalBackPathDelayTime(Value: double);
begin
  FTotalBackPathDelayTime:=Value
end;

procedure TCustomFacilityModel.Set_TotalBackPathDelayTimeDispersion(
  Value: double);
begin
  FTotalBackPathDelayTimeDispersion:=Value
end;

function TCustomFacilityModel.Get_CurrentDirectPathFlag: WordBool;
begin
  Result:=FCurrentDirectPathFlag
end;

function TCustomFacilityModel.Get_CurrentLineU: IUnknown;
begin
  Result:=FCurrentLine
end;

function TCustomFacilityModel.Get_CurrentNodeDirection: Integer;
begin
  Result:=FCurrentNodeDirection
end;

function TCustomFacilityModel.Get_CurrentPathArcKind: Integer;
begin
  Result:=FCurrentPathArcKind
end;

function TCustomFacilityModel.Get_CurrentPatrolPeriod: Double;
begin
  Result:=FCurrentPatrolPeriod
end;

function TCustomFacilityModel.Get_CurrentReactionTime: Double;
begin
  Result:=FCurrentReactionTime
end;

function TCustomFacilityModel.Get_CurrentReactionTimeDispersion: Double;
begin
  Result:=FCurrentReactionTimeDispersion
end;

function TCustomFacilityModel.Get_CurrentWarriorGroupU: IUnknown;
begin
  Result:=FCurrentWarriorGroup
end;

function TCustomFacilityModel.Get_CurrentZone0U: IUnknown;
begin
  Result:=FCurrentZone0
end;

function TCustomFacilityModel.Get_CurrentZone1U: IUnknown;
begin
  Result:=FCurrentZone1
end;

function TCustomFacilityModel.Get_CurrentBoundary0U: IUnknown;
begin
  Result:=FCurrentBoundary0
end;

function TCustomFacilityModel.Get_CurrentBoundary1U: IUnknown;
begin
  Result:=FCurrentBoundary1
end;

procedure TCustomFacilityModel.Set_CurrentDirectPathFlag(Value: WordBool);
begin
  FCurrentDirectPathFlag:=Value
end;

procedure TCustomFacilityModel.Set_CurrentLineU(const Value: IInterface);
begin
  FCurrentLine:=Value as IDMElement
end;

procedure TCustomFacilityModel.Set_CurrentNodeDirection(Value: Integer);
begin
  FCurrentNodeDirection:=Value
end;

procedure TCustomFacilityModel.Set_CurrentPathArcKind(Value: Integer);
begin
  FCurrentPathArcKind:=Value
end;

procedure TCustomFacilityModel.Set_CurrentPatrolPeriod(Value: Double);
begin
  FCurrentPatrolPeriod:=Value
end;

procedure TCustomFacilityModel.Set_CurrentReactionTime(Value: Double);
begin
  FCurrentReactionTime:=Value
end;

procedure TCustomFacilityModel.Set_CurrentReactionTimeDispersion(Value: Double);
begin
  FCurrentReactionTimeDispersion:=Value
end;

procedure TCustomFacilityModel.Set_CurrentZone0U(const Value: IInterface);
begin
  FCurrentZone0:=Value as IDMElement
end;

procedure TCustomFacilityModel.Set_CurrentZone1U(const Value: IInterface);
begin
  FCurrentZone1:=Value as IDMElement
end;

procedure TCustomFacilityModel.Set_CurrentBoundary0U(const Value: IInterface);
begin
  FCurrentBoundary0:=Value as IDMElement
end;

procedure TCustomFacilityModel.Set_CurrentBoundary1U(const Value: IInterface);
begin
  FCurrentBoundary1:=Value as IDMElement
end;

function TCustomFacilityModel.Get_DelayFlag: WordBool;
begin
  Result:=FDelayFlag
end;

procedure TCustomFacilityModel.Set_DelayFlag(Value: WordBool);
begin
  FDelayFlag:=Value
end;

function TCustomFacilityModel.AcceptableTactic(const TacticE, WarriorGroupE,
  BoundaryLayerTypeE: IDMElement; WarriorPathStage: Integer): WordBool;
var
  WarriorGroup:IWarriorGroup;
  Tactic:ITactic;
  BoundaryLayerType:IBoundaryLayerType;
begin
  Tactic:=TacticE as ITactic;

  if ((Tactic.EntryTactic and
     ((WarriorPathStage=wpsStealthEntry) or (WarriorPathStage=wpsFastEntry))) or
    (Tactic.ExitTactic and
     ((WarriorPathStage=wpsStealthExit) or (WarriorPathStage=wpsFastExit)))) and
    ((Tactic.StealthTactic and
     ((WarriorPathStage=wpsStealthEntry) or (WarriorPathStage=wpsStealthExit))) or
    (Tactic.FastTactic and
     ((WarriorPathStage=wpsFastEntry) or (WarriorPathStage=wpsFastExit)))) then begin

    Result:=True;
    if (WarriorGroupE.ClassID=_AdversaryGroup) then begin
      WarriorGroup:=WarriorGroupE as IWarriorGroup;
      if (WarriorGroup.Accesses.Count=0) and
          not Tactic.OutsiderTactic then
        Result:=False;
      if (WarriorGroup.Accesses.Count>0) and
        not Tactic.InsiderTactic then
        Result:=False;
    end else
    if (WarriorGroupE.ClassID=_GuardGroup) then begin
      if not Tactic.GuardTactic then
        Result:=False;
      if Tactic.DeceitTactic then
        Result:=False;
    end;

    if Result and
      (BoundaryLayerTypeE<>nil) then begin
      BoundaryLayerType:=BoundaryLayerTypeE as IBoundaryLayerType;
      Result:=(BoundaryLayerType.Tactics.IndexOf(Tactic as IDMElement)<>-1)
   end;
  end else
    Result:=False
end;

function TCustomFacilityModel.Get_CurrentTacticU: IUnknown;
begin
  Result:=FCurrentTactic
end;

procedure TCustomFacilityModel.Set_CurrentTacticU(const Value: IInterface);
begin
  FCurrentTactic:=Value as IDMElement
end;

function TCustomFacilityModel.Get_FieldCategory(Index: integer): WideString;
begin
  case Index of
  0: Result:='Общие параметры';
  1: Result:='Содержание электронного плана';
  2: Result:='Параметры построений';
  3: Result:='Параметры анализа';
  4: Result:='Стоимостные параметры';
  5: Result:='Текущие параметры';
  end;
end;

function TCustomFacilityModel.Get_FieldCategoryCount: integer;
begin
  Result:=5
end;

function TCustomFacilityModel.Get_DefaultClassCollectionIndex(Index,
  Mode: Integer): Integer;
var
  j:integer;
begin
  case Mode of
  0:begin
      if FClassCollectionIndexes0.Count=0 then begin
        for j:=0 to Get_ClassCollection(Index, Mode).Count-1 do
          FClassCollectionIndexes0.Add(pointer(-1));
        Result:=-1;
      end else
        Result:=integer(FClassCollectionIndexes0[Index])
    end;
  else
    begin
      if FClassCollectionIndexes_.Count=0 then begin
        for j:=0 to 2 do
          FClassCollectionIndexes_.Add(pointer(-1));
        Result:=-1;
      end else
        case Index of
        _ZoneType:
            Result:=integer(FClassCollectionIndexes_[0]);
        _BoundaryType:
            Result:=integer(FClassCollectionIndexes_[1]);
        else
            Result:=integer(FClassCollectionIndexes_[2]);
        end;
    end;
  end;
end;

procedure TCustomFacilityModel.Set_DefaultClassCollectionIndex(Index, Mode,
  Value: Integer);
var
  j:integer;
begin
  case Mode of
  0:begin
      if FClassCollectionIndexes0.Count=0 then begin
        for j:=0 to Get_ClassCollection(Index, Mode).Count-1 do
           FClassCollectionIndexes0.Add(pointer(-1))
      end;
      FClassCollectionIndexes0[Index]:=pointer(Value);
    end;
  else
    begin
      if FClassCollectionIndexes_.Count=0 then begin
        for j:=0 to 2 do
          FClassCollectionIndexes_.Add(pointer(-1));
      end;
      case Index of
      _ZoneType:
          FClassCollectionIndexes_[0]:=pointer(Value);
      _BoundaryType:
          FClassCollectionIndexes_[1]:=pointer(Value);
      else
          FClassCollectionIndexes_[2]:=pointer(Value);
      end;
    end;
  end;
end;

function TCustomFacilityModel.CreateCollection(aClassID: integer; const aParent:IDMElement): IDMCollection;
begin
  case aClassID of
  -3: Result:=TSafeguardElements.Create(aParent) as IDMCollection;
  -4: Result:=TElementStates.Create(aParent) as IDMCollection;
  else
      Result:=inherited CreateCollection(aClassID, aParent);
  end;
end;

procedure TCustomFacilityModel.UpdateVolumes;
var
  aAddFlag:WordBool;
begin
   aAddFlag:=False;
  (FEnviroments as IZone).MakeHVAreas(nil, nil, aAddFlag);
end;

procedure TCustomFacilityModel.MakeVolumeOutline(const Volume: IVolume;
  const aCollection: IDMCollection);
var
  j, m:integer;
  Area, aArea:IArea;
  aLineE, aAreaE:IDMElement;
  aCollection2:IDMCollection2;
  Zone:IZone;
  Line:ILine;
  Flag:boolean;
begin
  if Volume.Areas.Count>0 then begin
    inherited;
    Exit;
  end;
  Zone:=(Volume as IDMElement).Ref as IZone;

  aCollection2:=aCollection as IDMCollection2;
  for j:=0 to Zone.VAreas.Count-1 do begin
    Area:=Zone.VAreas.Item[j] as IArea;
    if Area.BottomLines.Count>0 then begin
      aLineE:=Area.BottomLines.Item[0];
      Line:=aLineE as ILine;
      aArea:=Line.GetVerticalArea(bdDown);
      Flag:=True;
      if aArea<>nil then begin
        aAreaE:=aArea as IDMElement;
        Flag:=(Zone.VAreas.IndexOf(aAreaE)=-1);
      end;
      if Flag then begin
        for m:=0 to Area.BottomLines.Count-1 do begin
          aLineE:=Area.BottomLines.Item[m];
          aCollection2.Add(aLineE)
        end;
      end;
    end;
  end;
end;

procedure TCustomFacilityModel.CalcVolumeMinMaxZ(const Volume: IVolume);
var
  j:integer;
  Zone:IZone;
  aVolume:IVolume;
  MinZ, MaxZ:double;
begin
  inherited;
  Zone:=(Volume as IDMElement).Ref as IZone;
  if Zone=nil then Exit;
  MinZ:=Volume.MinZ;
  MaxZ:=Volume.MaxZ;
  for j:=0 to Zone.Zones.Count-1 do begin
    aVolume:=Zone.Zones.Item[j].SpatialElement as IVolume;
    if aVolume<>nil then begin
      if aVolume.MinZ>aVolume.MaxZ then
        CalcVolumeMinMaxZ(aVolume);
      if MinZ>aVolume.MinZ then
        MinZ:=aVolume.MinZ;
      if MaxZ<aVolume.MaxZ then
        MaxZ:=aVolume.MaxZ;
    end;
  end;
  Volume.MinZ:=MinZ;
  Volume.MaxZ:=MaxZ;
end;

function TCustomFacilityModel.Get_VerticalBoundaryLayer: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FVerticalBoundaryLayer;
  Result:=Unk as IDMElement
end;

procedure TCustomFacilityModel.Set_VerticalBoundaryLayer(
  const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FVerticalBoundaryLayer:=Unk;
end;

function TCustomFacilityModel.GetColVolumeContaining(PX, PY, PZ: Double;
  const ColAreas, Volumes: IDMCollection): WordBool;
var
  aVolume,aVolume1:IVolume;
 // aCollection:IDMCollection;
begin
  Result:=inherited GetColVolumeContaining(PX, PY, PZ,ColAreas,Volumes);
  if Volumes.Count<>0 then begin
   aVolume:=Volumes.Item[0] as IVolume;
   if aVolume=nil then Exit;
   aVolume1:=GetInnerVolumeContaining(PX, PY, PZ, aVolume);
   if (aVolume1<>nil)
       and(Volumes.IndexOf(aVolume1 as IDMElement)=-1) then
    (Volumes as IDMCollection2).Add(aVolume1 as IDMElement);
  end;
end;

procedure TCustomFacilityModel.GetInnerVolumes(const VolumeE: IDMElement;
  const InnerVolumes: IDMCollection);
var
 aZone:IZone;
 aZones: IDMCollection;
 j:integer;
begin

 if VolumeE<>nil then begin
  aZone:=VolumeE.Ref as IZone;
  aZones:=aZone.Zones;
  (InnerVolumes as IDMCollection2).Clear;
  for j:=0 to aZones.Count-1 do
    (InnerVolumes as IDMCollection2).Add(aZones.Item[j].SpatialElement);
 end; //if

end;

procedure TCustomFacilityModel.GetUpperLowerVolumeParams(
  const VolumeRef: IDMElement; out UpperZoneKindE,
  LowerZoneKindE: IDMElement; out VolumeHeight, UpperVolumeHeight,
  LowerVolumeHeight: Double;
  out UpperVolumeUseSpecLayer, LowerVolumeUseSpecLayer: WordBool;
  out TopAreaUseSpecLayer: WordBool);
{Определение парамтров для автопостроения зон сверху и снизу:
  UpperVolumeRef,LowerVolumeRef -тип
  VolumeHeigh,UpperVolumeHeight,LowerVolumeHeight - высота
  VolumeUseSpecLayer,UpperVolumeUseSpecLayer,LowerVolumeUseSpecLayer -спец.слой.}
var
  ZoneKind, UpperZoneKind, LowerZoneKind:IZoneKind;
  ZoneKindE:IDMElement;
  DMDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  DataModel:IDataModel;

begin
  inherited;
  if VolumeRef=nil then Exit;
  ZoneKindE:=VolumeRef.Ref;
  if ZoneKindE=nil then Exit;

  DMDocument:=Get_Document as IDMDocument;
  DMOperationManager:=DMDocument as IDMOperationManager;
  DataModel:=DMDocument.DataModel as IDataModel;

  ZoneKind:=ZoneKindE as IZoneKind;
  if ZoneKindE.Parent.ID=0 then
    VolumeHeight:=Get_DefaultOpenZoneHeight*100
  else
    VolumeHeight:=-1;

  UpperZoneKindE:=ZoneKind.UpperZoneKind;
  UpperZoneKind:=UpperZoneKindE as IZoneKind;
  if (UpperZoneKindE<>nil) and
     (UpperZoneKindE.Parent.ID=0) then
    UpperVolumeHeight:=Get_DefaultOpenZoneHeight*100
  else
    UpperVolumeHeight:=-1;

  LowerZoneKindE:=ZoneKind.LowerZoneKind;
  LowerZoneKind:=LowerZoneKindE as IZoneKind;
  if (LowerZoneKindE<>nil) and
     (LowerZoneKindE.Parent.ID=0) then
    LowerVolumeHeight:=Get_DefaultOpenZoneHeight*100
  else
    LowerVolumeHeight:=-1;

  TopAreaUseSpecLayer:=(ZoneKindE.Parent.ID=0);
  if UpperZoneKind<>nil then
    UpperVolumeUseSpecLayer:=(UpperZoneKindE.Parent.ID=0);

  if LowerZoneKind<>nil then
    LowerVolumeUseSpecLayer:=(LowerZoneKindE.Parent.ID=0);
end;

procedure TCustomFacilityModel.MakeFieldValues;
begin
  inherited;

end;

function TCustomFacilityModel.Get_AreasOrdered: WordBool;
begin
  Result:=FBoundariesOrdered
end;

procedure TCustomFacilityModel.Set_AreasOrdered(Value: WordBool);
begin
  FBoundariesOrdered:=Value
end;

function TCustomFacilityModel.Get_FastPathColor: Integer;
begin
  Result:=FFastPathColor
end;

function TCustomFacilityModel.Get_GuardPathColor: Integer;
begin
  Result:=FGuardPathColor
end;

function TCustomFacilityModel.Get_MaxBoundaryDistance: Double;
begin
  Result:=FMaxBoundaryDistance
end;

function TCustomFacilityModel.Get_MaxPathAlongBoundaryDistance: Double;
begin
  Result:=FMaxPathAlongBoundaryDistance
end;

function TCustomFacilityModel.Get_PathHeight: Double;
begin
  Result:=FPathHeight
end;

function TCustomFacilityModel.Get_RationalPathColor: Integer;
begin
  Result:=FRationalPathColor
end;

function TCustomFacilityModel.Get_ShoulderWidth: Double;
begin
  Result:=FShoulderWidth
end;

function TCustomFacilityModel.Get_StealthPathColor: Integer;
begin
  Result:=FStealthPathColor
end;

procedure TCustomFacilityModel.Set_FastPathColor(Value: Integer);
begin
  FFastPathColor:=Value
end;

procedure TCustomFacilityModel.Set_GuardPathColor(Value: Integer);
begin
  FGuardPathColor:=Value
end;

procedure TCustomFacilityModel.Set_MaxBoundaryDistance(Value: Double);
var
  j:integer;
  Boundaries:IDMCollection;
  Boundary3:IBoundary3;
begin
  Boundaries:=Get_Boundaries;
  for j:=0 to Boundaries.Count-1 do begin
    Boundary3:=Boundaries.Item[j] as IBoundary3;
    if Boundary3.MaxBoundaryDistance=FMaxBoundaryDistance then
      Boundary3.MaxBoundaryDistance:=Value
  end;

  FMaxBoundaryDistance:=Value;
end;

procedure TCustomFacilityModel.Set_MaxPathAlongBoundaryDistance(Value: Double);
var
  j:integer;
  Boundaries:IDMCollection;
  Boundary3:IBoundary3;
begin
  Boundaries:=Get_Boundaries;
  for j:=0 to Boundaries.Count-1 do begin
    Boundary3:=Boundaries.Item[j] as IBoundary3;
    if Boundary3.MaxPathAlongBoundaryDistance=FMaxPathAlongBoundaryDistance then
      Boundary3.MaxPathAlongBoundaryDistance:=Value
  end;

  FMaxPathAlongBoundaryDistance:=Value
end;

procedure TCustomFacilityModel.Set_ShoulderWidth(Value: Double);
var
  j:integer;
  Boundaries:IDMCollection;
  Boundary3:IBoundary3;
begin
  Boundaries:=Get_Boundaries;
  for j:=0 to Boundaries.Count-1 do begin
    Boundary3:=Boundaries.Item[j] as IBoundary3;
    if Boundary3.ShoulderWidth=FShoulderWidth then
      Boundary3.ShoulderWidth:=Value
  end;

  FShoulderWidth:=Value
end;

procedure TCustomFacilityModel.Set_PathHeight(Value: Double);
begin
  FPathHeight:=Value
end;

procedure TCustomFacilityModel.Set_RationalPathColor(Value: Integer);
begin
  FRationalPathColor:=Value
end;

procedure TCustomFacilityModel.Set_StealthPathColor(Value: Integer);
begin
  FStealthPathColor:=Value
end;

function TCustomFacilityModel.Get_GraphColor: Integer;
begin
   Result:=FGraphColor
end;

procedure TCustomFacilityModel.Set_GraphColor(Value: Integer);
begin
   FGraphColor:=Value
end;

procedure TCustomFacilityModel.Reset(const BaseStateE: IDMElement);
var
  j:integer;
  Boundaries:IDMCollection;
  Boundary:IBoundary;
begin
  Boundaries:=Get_Boundaries;
  for j:=0 to Boundaries.Count-1 do begin
    Boundary:=Boundaries.Item[j] as IBoundary;
    Boundary.Reset(BaseStateE);
  end;
  Boundaries:=Get_Jumps;
  for j:=0 to Boundaries.Count-1 do begin
    Boundary:=Boundaries.Item[j] as IBoundary;
    Boundary.Reset(BaseStateE);
  end;
  Boundaries:=Get_Targets;
  for j:=0 to Boundaries.Count-1 do begin
    Boundary:=Boundaries.Item[j] as IBoundary;
    Boundary.Reset(BaseStateE);
  end;
  Boundaries:=Get_ControlDevices;
  for j:=0 to Boundaries.Count-1 do begin
    Boundary:=Boundaries.Item[j] as IBoundary;
    Boundary.Reset(BaseStateE);
  end;
end;

function TCustomFacilityModel.Get_UserDefinedPathLayer: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FUserDefinedPathLayer;
  Result:=Unk as IDMElement;
end;

procedure TCustomFacilityModel.Set_UserDefinedPathLayer(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FUserDefinedPathLayer:=Unk;
end;


function TCustomFacilityModel.Get_DefaultOpenZoneHeight: Double;
begin
  Result:=FDefaultOpenZoneHeight
end;

function TCustomFacilityModel.Get_ShowOnlyBoundaryAreas: WordBool;
begin
  Result:=FShowOnlyBoundaryAreas
end;

procedure TCustomFacilityModel.BuildStair;
begin
  BuildStairProc(Self as IDataModel)
end;

function TCustomFacilityModel.Get_StairLandingCount: Integer;
begin
  Result:=FStairLandingCount
end;

function TCustomFacilityModel.Get_StairLandingWidth: Double;
begin
  Result:=FStairLandingWidth
end;

function TCustomFacilityModel.Get_StairTurnAngle: Integer;
begin
  Result:=FStairTurnAngle
end;

function TCustomFacilityModel.Get_StairWidth: Double;
begin
  Result:=FStairWidth
end;


procedure TCustomFacilityModel.Set_StairLandingCount(Value: Integer);
begin
  FStairLandingCount:=Value
end;

procedure TCustomFacilityModel.Set_StairLandingWidth(Value: Double);
begin
  FStairLandingWidth:=Value
end;

procedure TCustomFacilityModel.Set_StairTurnAngle(Value: Integer);
begin
  FStairTurnAngle:=Value
end;

procedure TCustomFacilityModel.Set_StairWidth(Value: Double);
begin
  FStairWidth:=Value
end;

function TCustomFacilityModel.Get_StairLayer: IDMElement;
begin
  Result:=FStairLayer
end;

procedure TCustomFacilityModel.Set_StairLayer(const Value: IDMElement);
begin
  FStairLayer:=Value
end;

function TCustomFacilityModel.Get_GlobalValue(Index:integer): double;
begin
  Result:=FGlobalValue[Index]
end;

procedure TCustomFacilityModel.Set_GlobalValue(Index:integer; Value: double);
begin
  FGlobalValue[Index]:=Value
end;

function TCustomFacilityModel.Get_GlobalIntf(Index:integer): IUnknown;
begin
  Result:=IUnknown(FGlobalIntf[Index])
end;

procedure TCustomFacilityModel.Set_GlobalIntf(Index:integer; const Value: IUnknown);
begin
  FGlobalIntf[Index]:=pointer(Value)
end;

function TCustomFacilityModel.Get_ForceTacticEnabled: WordBool;
begin
  Result:=FForceTacticEnabled
end;

procedure TCustomFacilityModel.Set_ForceTacticEnabled(Value: WordBool);
begin
  FForceTacticEnabled:=Value
end;

procedure TCustomFacilityModel.HandleError(const ErrorMessage:WideString);
var
  Server:IDataModelServer;
begin
  Server:=(Get_Document as IDMDocument).Server;
  Server.AnalysisError(ErrorMessage);
  Abort;
end;

procedure TCustomFacilityModel.CheckErrors;
var
  Errors, Warnings:IDMCollection;
  Errors2, Warnings2:IDMCollection2;

  procedure AddError(const Element:IDMElement; Code:integer);
  var
    DMErrorE:IDMElement;
    DMError:IDMError;
  begin
    DMErrorE:=Errors2.CreateElement(True);
    if Code<10000 then
      Errors2.Add(DMErrorE)
    else
      Warnings2.Add(DMErrorE);
    DMErrorE.Ref:=Element;
    DMError:=DMErrorE as IDMError;
    DMError.Code:=Code;
  end;


var
  Jumps:IDMCollection;
  j:integer;
  Element:IDMElement;
  Jump:IJump;
  Volume, aVolume:IVolume;
  Zone, aZone:IZone;
  Areas:IDMCollection;
  Area:IArea;
  AreaE, ZoneE, aZoneE:IDMElement;
begin
  inherited;

  Errors:=Get_Errors;
  if Errors=nil then Exit;
  Warnings:=Get_Warnings;
  if Warnings=nil then Exit;

  Errors2:=Errors as IDMCollection2;
  Warnings2:=Warnings as IDMCollection2;

  try
    Areas:=Get_Areas;
    for j:=0 to Areas.Count-1 do begin
      AreaE:=Areas.Item[j];
      Area:=AreaE as IArea;
      if (Area.Volume0<>nil) and
         (Area.Volume0IsOuter) then begin
        Volume:=Area.Volume0;
        aVolume:=Area.Volume1;
      end else
      if (Area.Volume1<>nil) and
         (Area.Volume1IsOuter) then begin
        Volume:=Area.Volume1;
        aVolume:=Area.Volume0;
      end else begin
        Volume:=nil;
        aVolume:=nil;
      end;
      if (Volume<>nil) and
         (aVolume<>nil) then begin
         ZoneE:=(Volume as IDMElement).Ref;
         aZoneE:=(aVolume as IDMElement).Ref;
         Zone:=ZoneE as IZone;
         aZone:=aZoneE as IZone;
         if (Zone<>nil) and (aZoneE<>nil) and
            (not Zone.Contains(aZoneE)) then
           AddError(AreaE, 7)
      end;
    end;
  except
    raise
  end;

  try
  Jumps:=Get_Jumps;
  for j:=0 to Jumps.Count-1 do begin
    Element:=Jumps.Item[j];
    Jump:=Element as IJump;
    if (Jump.Zone0=nil) or
       (Jump.Zone1=nil) then
      AddError(Element, 0);
  end;

  Errors2.Sort(ErrorSorter);

  except
    raise
  end;
end;

function TCustomFacilityModel.Get_UseSimpleBattleModel: WordBool;
begin
  Result := FUseSimpleBattleModel;
end;

procedure TCustomFacilityModel.Set_UseSimpleBattleModel(Value: WordBool);
begin
  FUseSimpleBattleModel := Value;
end;


function TCustomFacilityModel.Get_GuardArrivals: IDMCollection;
begin
  Result:=FGuardArrivals
end;

function TCustomFacilityModel.Get_AlarmGroups: IDMCollection;
begin
  Result:=FVerificationGroups
end;

procedure TCustomFacilityModel.CalcResponceTime(VGroupTimeFromStart,
                                          VGroupTimeToTarget, VGroupTimeToTargetDispersion: Double;
                                    const VGroupE: IDMElement;  GoalDefindingBoundary:WordBool;
                                      out theGroupTimeToTarget, theGroupTimeToTargetDisp: Double;
                                      out theGroupE:IDMElement);
var
  GuardGroupW: IWarriorGroup;
  GuardArrivals2:IDMCollection2;
  GuardGroup:IGuardGroup;
  thePotential, GuardPotentialSum:double;
  j:integer;
begin
  GuardArrivals2:=FGuardArrivals as IDMCollection2;
  for j:=0 to FGuardArrivals.Count-1 do begin
    GuardGroupW:=FGuardArrivals.Item[j] as IWarriorGroup;
    GuardGroup:=GuardGroupW as IGuardGroup;
    case GuardGroup.StartCondition of
    scAlarm:
      GuardGroup.DelayedArrivalTime:=GuardGroupW.ArrivalTime;
    scGoalDefiningPointPassed:
      if GoalDefindingBoundary then
        GuardGroup.DelayedArrivalTime:=GuardGroupW.ArrivalTime
      else
        GuardGroup.DelayedArrivalTime:=VGroupTimeFromStart+GuardGroupW.ArrivalTime;
    else
      GuardGroup.DelayedArrivalTime:=VGroupTimeFromStart+GuardGroupW.ArrivalTime;
    end;
  end;
  if VGroupE<>nil then begin
    GuardGroup:=VGroupE as IGuardGroup;
    GuardGroup.DelayedArrivalTime:=VGroupTimeFromStart+VGroupTimeToTarget+(VGroupE as IGuardGroup2).TimeLimit;
    GuardArrivals2.Add(VGroupE);
  end;
  GuardArrivals2.Sort(GuardArrivalTimeSorter);

  theGroupE:=nil;
  theGroupTimeToTarget:=InfinitValue;
  theGroupTimeToTargetDisp:=InfinitValue;
  GuardPotentialSum:=0;
  j:=0;
  while j<FGuardArrivals.Count do begin
    theGroupE:=FGuardArrivals.Item[j];
    GuardGroupW:=theGroupE as IWarriorGroup;
    theGroupTimeToTarget:=GuardGroupW.ArrivalTime;
    theGroupTimeToTargetDisp:=GuardGroupW.ArrivalTimeDispersion;
    thePotential:=GuardGroupW.GetPotential;

    GuardPotentialSum:=GuardPotentialSum+thePotential;
    if GuardPotentialSum>=FAdversaryPotentialSum then
      Break
    else
      inc(j)  
  end;

  if VGroupE<>nil then
    GuardArrivals2.Remove(VGroupE);
end;

function TCustomFacilityModel.Get_AdversaryPotentialSum: Double;
begin
   Result:=FAdversaryPotentialSum
end;

procedure TCustomFacilityModel.Set_AdversaryPotentialSum(Value: Double);
begin
  FAdversaryPotentialSum:=Value
end;

function TCustomFacilityModel.Get_CurrentDistance: double;
begin
  Result:=1
end;

procedure TCustomFacilityModel.Set_CurrentDistance(Value:double);
begin
end;

function TCustomFacilityModel.Get_CurrentSafeguardElementU: IUnknown;
begin
  Result:=FCurrentSafeguardElement
end;

procedure TCustomFacilityModel.Set_CurrentSafeguardElementU(
  const Value: IInterface);
begin
  FCurrentSafeguardElement:=Value as IDMElement
end;

function TCustomFacilityModel.GetOuterVolume(const VolumeE: IDMElement): IDMElement;
var
  ParentZoneE:IDMElement;
begin
  Result:=inherited GetOuterVolume(VolumeE);
  if VolumeE.Ref=nil then Exit;
  ParentZoneE:=VolumeE.Ref.Parent;
  if ParentZoneE=nil then Exit;
  Result:=ParentZoneE.SpatialElement;
end;

procedure TCustomFacilityModel.CorrectErrors;
  function CorrectError(const DMErrorE:IDMElement):boolean;
  var
    DMError:IDMError;
    Element:IDMElement;
    Code:integer;
    Volume, aVolume, theVolume:IVolume;
    aZone, theZone:IZone;
    Area:IArea;
    AreaE, ZoneE, aZoneE, theZoneE:IDMElement;
  begin
    Result:=False;
    DMError:=DMErrorE as IDMError;
    Code:=DMError.Code;
    Element:=DMErrorE.Ref;
    if not Element.Exists then Exit;
    try
    case Element.ClassID of
    _Area:
      case Code of
      7:begin
        AreaE:=Element;
        Area:=AreaE as IArea;
        if (Area.Volume0<>nil) and
           (Area.Volume0IsOuter) then begin
          Volume:=Area.Volume0;
          aVolume:=Area.Volume1;
        end else
        if (Area.Volume1<>nil) and
           (Area.Volume1IsOuter) then begin
          Volume:=Area.Volume1;
          aVolume:=Area.Volume0;
        end else begin
          Volume:=nil;
          aVolume:=nil;
        end;
        if (Volume<>nil) and
          (aVolume<>nil) then begin
          ZoneE:=(Volume as IDMElement).Ref;
          aZoneE:=(aVolume as IDMElement).Ref;
          aZone:=aZoneE as IZone;
          theZoneE:=aZoneE.Parent;
          theVolume:=theZoneE.SpatialElement as IVolume;
          while theZoneE<>nil do begin
             theZone:=theZoneE as IZone;
             theVolume:=theZoneE.SpatialElement as IVolume;
             if theZone.Contains(aZoneE) and
                (theVolume.Areas.Count<>0) then
               break
             else begin
               theZoneE:=theZoneE.Parent;
             end;
          end;
          if theZoneE<>nil then begin
            if Area.Volume0=Volume then
              Area.Volume0:=theVolume
            else
              Area.Volume1:=theVolume
          end else begin
            if Area.Volume0=Volume then
              Area.Volume0IsOuter:=False
            else
              Area.Volume1IsOuter:=False
          end;
        end; // if (Volume<>nil) and
        Result:=True;
      end; //
      end; // case Code of
    end; //  case Element.ClassID of
    except
      raise
    end;
  end;
var
  Errors:IDMCollection;
  DMErrorE:IDMElement;
  j:integer;
begin
  inherited;
  Errors:=Get_Errors;
  for j:=0 to Errors.Count-1 do begin
    DMErrorE:=Errors.Item[j];
    if DMErrorE.Selected then begin
      if CorrectError(DMErrorE) then
        DMErrorE.Selected:=False;
    end;
  end;

end;

procedure TCustomFacilityModel.Loaded;
begin
  inherited;
  Init;
end;

{ TBoundariesDSorter }

function TBoundariesDSorter.Compare(const Key1, Key2: IDMElement): integer;
var
  Area1, Area2:IArea;
  PX, PY, PZ, D1, D2:double;
  Painter:IPainter;
  View:IView;
  Document:IUnknown;
begin
  Document:=Key1.DataModel.Document;
  Painter:=(Document as ISMDocument).PainterU as IPainter;
  View:=Painter.ViewU as IView;
  
  Area1:=Key1.SpatialElement as  IArea;
  Area2:=Key2.SpatialElement as  IArea;
  if Area1<>nil then begin
    Area1.GetCentralPoint(PX, PY, PZ);
    D1:=PX*View.SinZ+PY*View.CosZ;
  end else
    D1:=InfinitValue;
  if Area2<>nil then begin
    Area2.GetCentralPoint(PX, PY, PZ);
    D2:=PX*View.SinZ+PY*View.CosZ;
  end else
    D2:=InfinitValue;
  if D1>D2 then
    Result:=-1
  else
  if D1<D2 then
    Result:=+1
  else
    Result:=0
end;

{ TBoundariesZSorter }

function TBoundariesZSorter.Compare(const Key1, Key2: IDMElement): integer;
var
  Area1, Area2:IArea;
  PX, PY, Z1, Z2:double;
begin
  Area1:=Key1.SpatialElement as  IArea;
  Area2:=Key2.SpatialElement as  IArea;
  if Area1<>nil then begin
    Area1.GetCentralPoint(PX, PY, Z1);
  end else
    Z1:=InfinitValue;
  if Area2<>nil then begin
    Area2.GetCentralPoint(PX, PY, Z2);
  end else
    Z2:=InfinitValue;
  if Z1<Z2 then
    Result:=-1
  else
  if Z1>Z2 then
    Result:=+1
  else
    Result:=0
end;

{ TFMRecomendationSorter }

function TFMRecomendationSorter.Compare(const Key1,
  Key2: IDMElement): Integer;
var
  P1, P2:double;
begin
  if Key1.DataModel.IsLoading then begin
    Result:=inherited Compare(Key1, Key2);
    Exit;
  end;
  P1:=(Key1 as IFMRecomendation).Priority;
  P2:=(Key2 as IFMRecomendation).Priority;
  if P1<P2 then
    Result:=-1
  else if P1>P2 then
    Result:=+1
  else begin
    Result:=0;
  end;
end;

function TFMRecomendationSorter.Get_Duplicates: WordBool;
begin
  Result:=True
end;

function TCustomFacilityModel.Get_ShowSingleLayer: WordBool;
begin
  Result:=FShowSingleLayer
end;

procedure TCustomFacilityModel.Set_ShowSingleLayer(Value: WordBool);
begin
  FShowSingleLayer:=Value
end;

function TCustomFacilityModel.Get_ZoneDelayTimeDispersionRatio: Double;
begin
  Result:=FResponceTimeDispersionRatio
end;

procedure TCustomFacilityModel.Set_ZoneDelayTimeDispersionRatio(Value: Double);
begin
  FResponceTimeDispersionRatio:=Value
end;

procedure InitCash;
begin
  CashC0X:=-InfinitValue;
  CashC0Y:=-InfinitValue;
  CashC0Z:=-InfinitValue;
  CashC1X:=-InfinitValue;
  CashC1Y:=-InfinitValue;
  CashC1Z:=-InfinitValue;
  CashWhileTransparent:=0;
  CashExcludeArea0P:=nil;
  CashExcludeArea1P:=nil;
end;

procedure TCustomFacilityModel.Set_DefaultOpenZoneHeight(Value: Double);
begin
  FDefaultOpenZoneHeight:=Value
end;

function TCustomFacilityModel.Get_OvercomingBoundaries: IDMCollection;
begin
  Result:=Collection[_OvercomingBoundary]
end;

function TCustomFacilityModel.MakePathFrom(const NodeE: IDMElement;
  Reversed: WordBool; PathKind: Integer; UseStoredRecords: WordBool;
  const Paths: IDMCollection; const PathLayerE: IDMElement;
  var WarriorPathE: IDMElement): IDMElement;
var
  aNode0V:IVulnerabilityData;
  aNode0E, aNode1E:IDMElement;
  aNode0, aNode1:ICoordNode;
  aNode0P, aPathNode0, aPathNode1:IPathNode;
  aPathArc:IPathArc;
  aPathArcE, PathE:IDMElement;
  PathP:IPolyline;
  j:integer;
  WarriorPaths2, Paths2, PathNodes2:IDMCollection2;
  WarriorPath:IWarriorPath;
  TMPArcList, TMPNodeList:TList;
  RationalPathFlag:boolean;
  V0, V1:IVulnerabilityData;
  aPathArcL:ILine;
  D:double;
begin
  Result:=nil;
  if NodeE=nil then Exit;

  aNode0E:=NodeE;
  aNode0V:=NodeE as IVulnerabilityData;
//  aNode0P:=NodeE as IPathNode;
  aNode0:=NodeE as ICoordNode;

  if UseStoredRecords then begin
    case PathKind of
    pkRationalPath:
      begin
        aPathArcE:=aNode0V.RationalProbabilityToTarget_NextArc;
        aNode1E:=aNode0V.RationalProbabilityToTarget_NextNode;
      end;
    pkFastPath:
      begin
        aPathArcE:=aNode0V.DelayTimeToTarget_NextArc;
        aNode1E:=aNode0V.DelayTimeToTarget_NextNode;
      end;
    pkStealthPath:
      begin
        aPathArcE:=aNode0V.NoDetectionProbabilityFromStart_NextArc;
        aNode1E:=aNode0V.NoDetectionProbabilityFromStart_NextNode;
      end;
    pkGuardPathToTarget:
      begin
        aPathArcE:=aNode0V.DelayTimeToTarget_NextArc;
        aNode1E:=aNode0V.DelayTimeToTarget_NextNode;
      end;
    pkGuardPathFromStart:
      begin
        aPathArcE:=aNode0V.DelayTimeFromStart_NextArc;
        aNode1E:=aNode0V.DelayTimeFromStart_NextNode;
      end;
    pkRationalBackPath:
      begin
        aPathArcE:=aNode0V.BackPathRationalProbability_NextArc;
        aNode1E:=aNode0V.BackPathRationalProbability_NextNode;
      end;
    else
      begin
        aPathArcE:=nil;
        aNode1E:=nil;
      end;
    end
  end else begin
    aPathArcE:=aNode0P.BestNextArc;
    aNode1E:=aNode0P.BestNextNode;
  end;
  if aPathArcE=nil then Exit;
  if aNode1E=nil then Exit;

  aPathArcL:=aPathArcE as ILine;
  aNode1:=aNode1E as ICoordNode;

  WarriorPaths2:=Get_WarriorPaths as IDMCollection2;
  Paths2:=Paths as  IDMCollection2;
  if WarriorPathE=nil then begin
    WarriorPathE:=WarriorPaths2.CreateElement(False);
    WarriorPaths2.Add(WarriorPathE);
    PathE:=Paths2.CreateElement(False);
    Paths2.Add(PathE);
    PathE.Ref:=WarriorPathE;
  end else
    PathE:=WarriorPathE.SpatialElement;
  WarriorPath:=WarriorPathE as IWarriorPath;

  Result:=WarriorPathE;
  PathP:=PathE as IPolyline;

  PathNodes2:=WarriorPath.PathNodes as IDMCollection2;
  WarriorPath.FirstNode:=NodeE;

  TMPArcList:=TList.Create;
  TMPNodeList:=TList.Create;
  RationalPathFlag:=True;
  while aNode0V<>nil do begin
    if UseStoredRecords then
      case PathKind of
      pkRationalPath:
        begin
          if RationalPathFlag then begin
            aPathArcE:=aNode0V.RationalProbabilityToTarget_NextArc;
            aNode1E:=aNode0V.RationalProbabilityToTarget_NextNode;
          end else begin
            D:=aNode0V.RationalProbabilityToTarget;
            if D>0.999 then begin
              RationalPathFlag:=False;
              aPathArcE:=aNode0V.DelayTimeToTarget_NextArc;
              aNode1E:=aNode0V.DelayTimeToTarget_NextNode;
            end;
          end;
        end;
      pkFastPath:
        begin
          aPathArcE:=aNode0V.DelayTimeToTarget_NextArc;
          aNode1E:=aNode0V.DelayTimeToTarget_NextNode;
        end;
      pkStealthPath:
        begin
          aPathArcE:=aNode0V.NoDetectionProbabilityFromStart_NextArc;
          aNode1E:=aNode0V.NoDetectionProbabilityFromStart_NextNode;
        end;
      pkGuardPathToTarget:
        begin
          aPathArcE:=aNode0V.DelayTimeToTarget_NextArc;
          aNode1E:=aNode0V.DelayTimeToTarget_NextNode;
        end;
      pkGuardPathFromStart:
        begin
          aPathArcE:=aNode0V.DelayTimeFromStart_NextArc;
          aNode1E:=aNode0V.DelayTimeFromStart_NextNode;
        end;
      pkRationalBackPath:
        begin
          aPathArcE:=aNode0V.BackPathRationalProbability_NextArc;
          aNode1E:=aNode0V.BackPathRationalProbability_NextNode;
        end;
      else
        begin
          aPathArcE:=nil;
          aNode1E:=nil;
        end;
      end
    else begin
      aPathArcE:=aNode0P.BestNextArc;
      aNode1E:=aNode0P.BestNextNode;
    end;
    if aPathArcE=nil then
      Break;
    if aNode1E=nil then
      Break;

    aPathArc:=aPathArcE as IPathArc;
    aPathArcL:=aPathArcE as ILine;
    aNode1:=aNode1E as ICoordNode;

    if TMPArcList.IndexOf(pointer(aPathArcE))<>-1 then begin
      Result:=nil;
      Break;
    end;
    TMPArcList.Add(pointer(aPathArcE));
    TMPNodeList.Add(pointer(aNode1E));
    if (PathKind=pkFastPath) and
        not UseStoredRecords then begin
      aPathArcE.Parent:=PathLayerE;
      if not Reversed then begin     // to Root
        V0:=aNode0 as IVulnerabilityData;
        V1:=aNode1 as IVulnerabilityData;
        aPathArc.Value:=abs(V0.DelayTimeToTarget-V1.DelayTimeToTarget);
      end else begin
        aPathNode0:=aNode0 as IPathNode;
        aPathNode1:=aNode1 as IPathNode;
        aPathArc.Value:=abs(aPathNode1.BestDistance-aPathNode0.BestDistance);
      end;
    end;

    aNode0:=aNode1;
    aNode0V:=aNode1 as IVulnerabilityData;
    aNode0P:=aNode1 as IPathNode;
  end;  // while aNodeV<>nil

  if not Reversed then begin
    for j:=0 to TMPArcList.Count-1 do begin
      aPathArcE:=IDMElement(TMPArcList[j]);
      aNode1E:=IDMElement(TMPNodeList[j]);
      aPathArcE.AddParent(PathE);
      PathNodes2.Add(aNode1E);
    end;
  end else begin
    for j:=TMPArcList.Count-1 downto 0 do begin
      aPathArcE:=IDMElement(TMPArcList[j]);
      aNode1E:=IDMElement(TMPNodeList[j]);
      aPathArcE.AddParent(PathE);
      PathNodes2.Add(aNode1E);
    end;
  end;

  if PathP.Lines.Count=0 then begin
    WarriorPaths2.Remove(WarriorPathE);
    Paths2.Remove(PathE);
    PathE.Clear;
    WarriorPathE.Clear;
    WarriorPathE:=nil;
    Result:=nil;
  end;

  if Result<>nil then begin
    WarriorPath:=Result as IWarriorPath;

    case PathKind of
    pkFastPath:
      WarriorPath.Kind:=_wpkFast;
    pkStealthPath:
      WarriorPath.Kind:=_wpkStealth;
    pkRationalPath,
    pkRationalBackPath:
        WarriorPath.Kind:=_wpkRational;
    end;
  end;

  TMPArcList.Free;
  TMPNodeList.Free;
end;

{ TGuardArrivalTimeSorter }

function TDelayedGuardArrivalTimeSorter.Compare(const Key1,
  Key2: IDMElement): integer;
var
  GuardGroup1, GuardGroup2:IGuardGroup;
  T1, T2:double;
begin
  GuardGroup1:=Key1 as IGuardGroup;
  GuardGroup2:=Key2 as IGuardGroup;
  T1:=GuardGroup1.DelayedArrivalTime;
  T2:=GuardGroup2.DelayedArrivalTime;
  if T1<T2 then
    Result:=-1
  else
  if T1>T2 then
    Result:=+1
  else
    Result:=0
end;

{ TErrorSorter }

function TErrorSorter.Compare(const Key1: IDMElement; const Key2: IDMElement): Integer;
var
  DMErrorE1, DMErrorE2:IDMElement;
  DMError1, DMError2:IDMError;
begin
  DMErrorE1:=IDMElement(Key1);
  DMErrorE2:=IDMElement(Key2);
  DMError1:=DMErrorE1 as IDMError;
  DMError2:=DMErrorE2 as IDMError;
  if DMErrorE1.Ref.ClassID<DMErrorE2.Ref.ClassID then
    Result:=-1
  else
  if DMErrorE1.Ref.ClassID>DMErrorE2.Ref.ClassID then
    Result:=+1
  else
  if DMError1.Code<DMError2.Code then
    Result:=-1
  else
  if DMError1.Code>DMError2.Code then
    Result:=+1
  else
    Result:=0
end;

function TErrorSorter.Get_Duplicates: WordBool;
begin
  Result:=True
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TCustomFacilityModel.MakeFields;

  CashSeparatingAreaList:=TList.Create;

  InitCash;

  GuardArrivalTimeSorter:=TDelayedGuardArrivalTimeSorter.Create(nil) as ISorter;
  ErrorSorter:=TErrorSorter.Create(nil) as ISorter;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
  CashSeparatingAreaList.Free;

  GuardArrivalTimeSorter:=nil;
  ErrorSorter:=nil;
end.
