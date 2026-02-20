unit BoundaryLayerU;

interface
uses
  Classes, SysUtils, Math, Graphics, Variants,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomSafeguardElementU, SprutikLib_TLB;

const
  pfTransparent=1;       // Прозрачный
  pfNoFieldBarrier=2;    // Не ослабляет звук
  pfFragile=4;           // Хрупкий
  pfParamsCalculated=16; // Параметры для базового состояния системы рассчитаны
  pfParamsChanged=32;    // Параметры изменяются хотя бы в одном возмущенном состоянии системы
  pfVisible0=64;         // Виден из зоны 0
  pfVisible1=128;        // Виден из зоны 1

const
  Week=3600*24*7;


type
  TBoundaryLayer=class(TCustomSafeguardElement, IElementState, IBoundaryLayer,
                       IFieldBarrier, IMethodDimItemSource,
                       ISafeguardUnit, ISafeguardUnit2, IDMReporter,
                       IDMElement2, IWayElement)
//  класс, представляющий слой защиты границы зоны
  private
//  реализация массива элементов защиты
    FSafeguardElements:IDMCollection;
    FSubBoundaries:IDMCollection;

    FHeight0:double;
    FHeight1:double;
    FBaseState:pointer;

    FDistanceFromPrev: Double;
    FX0: Double;
    FY0: Double;
    FX1: Double;
    FY1: Double;
    FNeighbour0: IDMElement;
    FNeighbour1: IDMElement;
    FPrev:IDMElement;

    FParamFlags:byte;

    FDrawJoint0:boolean;
    FDrawJoint1:boolean;

    FConstruction:integer;

//  IWayElement
    FDelayTimeFast: Double;
    FDelayTimeDispFast: Double;
    FDetectionProbabilityFast: Double;
    FSingleDetectionProbabilityFast: Double;
    FEvidencePFast: boolean;
    FFailurePFast: Double;
    FTacticFastE:IDMElement;
    FPositionFast:integer;

    FDelayTimeStealth: Double;
    FDelayTimeDispStealth: Double;
    FDetectionProbabilityStealth: Double;
    FSingleDetectionProbabilityStealth: Double;
    FEvidencePStealth: boolean;
    FFailurePStealth: Double;
    FTacticStealthE:IDMElement;
    FPositionStealth:integer;

    FObservationPeriod:double;

    procedure UpdateDependingElements
             (const DependingSafeguardElementList,
                    theDependingSafeguardElementList,
                    BestOvercomeMethodList,
                    theBestOvercomeMethodList: TList);
    procedure UpdateDependingElementBestMethods
             (const DependingSafeguardElementList,
                    BestOvercomeMethodList: TList);
    function CalcObservationPeriod:double;
    function RecalcObservationPeriod:double;
    function ImplicitCalcNeeded:boolean;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    function Get_Name:WideString; override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure Loaded; override; safecall;
    procedure Set_Selected(Value:WordBool); override; safecall;
    procedure AfterLoading2; override; safecall;
    procedure AfterCopyFrom2; override; safecall;
    procedure Set_Ref(const Value: IDMElement); override; safecall;

    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function GetCollectionForChild(const aChild: IDMElement): IDMCollection; override; safecall;

    procedure CalcPathNoDetectionProbability(
                      var PathNoDetectionProbability:double;
                      out NoDetP, NoFailureP:double;
                      out NoEvidence: WordBool;
                          AddDelay:double); safecall;
    procedure CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                          AddDelay:double); safecall;
    procedure CalcPathSoundResistance(
                      var PathSoundResistance,
                          FuncSoundResistance: double); safecall;
    procedure CalcGuardDelayTime(out DelayTime, DelayTimeDispersion:double;
                                 out BestTacticE:IDMElement;
                                 AddDelay:double);safecall;
    procedure CalcDelayTime(out DelayTime: Double; out DelayTimeDisp: Double; AddDelay: Double); safecall;
    procedure CalcParams(AddDelay:double);safecall;
    procedure DoCalcParams(const TacticU:IUnknown; AddDelay:double;
                      out dTFast, dTDispFast, NoDetPFast, NoDetP1Fast,
                          NoFailurePFast:double;
                      out NoEvidenceFast:WordBool;
                      out SingleDetPFast:double;
                      out dTStealth, dTDispStealth, NoDetPStealth, NoDetP1Stealth,
                          NoFailurePStealth:double;
                      out NoEvidenceStealth:WordBool;
                      out SingleDetPStealth:double;
                      out PositionFast, PositionStealth:integer);
    procedure CalcNoDetectionProbability(out NoDetP: Double; out NoFailureP: Double; 
                                         out NoEvidence: WordBool; out BestTimeSum: Double; 
                                         out BestTimeDispSum: Double; out Position: Integer;
                                         AddDelay: Double); safecall;
    procedure DoCalcDelayTime(const TacticU:IUnknown;
                      out DelayTime, DelayTimeDispersion:double; AddDelay:double); safecall;
    procedure DoCalcNoDetectionProbability(const TacticU:IUnknown;
                          ObservationPeriod:double;
                      out NoDetP, NoFailureP:double;
                      out NoEvidence:WordBool;
                      out BestTimeSum, BestTimeDispSum:double;
                      out Position:integer;
                          AddDelay:double); virtual; safecall;
    procedure DoCalcPathSuccessProbability(const TacticU:IUnknown;
                          ObservationPeriod:double;
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability,
                          StealthT: double;
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner:double;
                          AddDelay:double); safecall;

    procedure MakePersistant(const SubStateE:IDMElement); safecall;
    function Get_InstallPrice:integer;
//           метод, возвращающий стоимость оборудования
//           данного слоя защиты
    function Get_MaintenancePrice:integer;
//           метод, возвращающий стоимость эксплуатации в течении года
//           данного слоя защиты
    function Get_SafeguardElements:IDMCollection; safecall;

    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; virtual; safecall;
    function Get_SoundResistance:double; safecall;
    
    function  Get_Height0:double; safecall;
    procedure Set_Height0(Value:double); safecall;
    function  Get_Height1:double; safecall;
    procedure Set_Height1(Value:double); safecall;
    function  Get_Visible0:WordBool; safecall;
    procedure Set_Visible0(Value:WordBool); safecall;
    function  Get_Visible1:WordBool; safecall;
    procedure Set_Visible1(Value:WordBool); safecall;

    function  Get_SubBoundaries:IDMCollection; safecall;

    function  Get_UserDefineded: WordBool; override; safecall;
    function  Get_IsEmpty: WordBool; override; safecall;
    function  Get_DistanceFromPrev: Double; safecall;
    function  Get_X0: Double; safecall;
    procedure Set_X0(Value: Double); safecall;
    function  Get_Y0: Double; safecall;
    procedure Set_Y0(Value: Double); safecall;
    function  Get_X1: Double; safecall;
    procedure Set_X1(Value: Double); safecall;
    function  Get_Y1: Double; safecall;
    procedure Set_Y1(Value: Double); safecall;
    function  Get_Neighbour0: IDMElement; safecall;
    procedure Set_Neighbour0(const Value: IDMElement); safecall;
    function  Get_Neighbour1: IDMElement; safecall;
    procedure Set_Neighbour1(const Value: IDMElement); safecall;
    function  Get_Prev:IDMElement; safecall;
    procedure Set_Prev(const Value:IDMElement); safecall;
    function  Get_Construction:integer; safecall;

    procedure Reset(const BaseStateE:IDMElement); safecall;

    function AcceptableTactic(const TacticU:IUnknown):WordBool; safecall;
    function  Get_Disabled:WordBool; safecall;

    procedure ClearCash(ClearElements:WordBool); safecall;

    procedure BuildReport(ReportLevel: Integer; TabCount: Integer; Mode: Integer;
                          const Report: IDMText); override; safecall;
    function Get_ReportModeCount:integer; override; safecall;
    function Get_ReportModeName(Index:integer):WideString; override; safecall;

// IFieldBarrier
    procedure CalcParamFlags; safecall;
    function Get_IsTransparent:WordBool; safecall;
    function Get_HasNoFieldBarrier:WordBool; safecall;
    function Get_IsFragile:WordBool; safecall;
    function CalcAttenuation(const PhysicalField:IDMElement):double; safecall;

// IDMElement2

    function GetOperationName(ColIndex, Index: Integer): WideString; safecall;
    function DoOperation(ColIndex, Index: Integer; var Param1: OleVariant; var Param2: OleVariant;
                         var Param3: OleVariant): WordBool; safecall;
    function GetShortCut(ColIndex, Index: Integer): WideString; safecall;


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
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TBoundaryLayers=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
    function       Get_ClassAlias2(Index:integer): WideString; override; safecall;
  end;


var
  aNoDetP,
  aNoFailureP:double;
  aNoEvidence:boolean;


implementation

uses
  FacilityModelConstU,
  OutstripU;

var
  FFields:IDMCollection;
  DependingSafeguardElementList, theDependingSafeguardElementList,
  BestOvercomeMethodList, theBestOvercomeMethodList:TList;
  _BottomLineE, _TopLineE, _VLine0E, _Vline1E:IDMElement;
  _BottomC0, _BottomC1, _TopC0, _TopC1:ICoordNode;

const
  PedestrialVelocity=500;

{ TBoundaryLayer }

procedure TBoundaryLayer.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FStates:=DataModel.CreateCollection(_BoundaryLayerState, SelfE);
  FSafeguardElements:=DataModel.CreateCollection(-3, SelfE);
  FSubBoundaries:=DataModel.CreateCollection(_SubBoundary, SelfE);
end;

procedure TBoundaryLayer._Destroy;
begin
  inherited;
  FSafeguardElements:=nil;
  FSubBoundaries:=nil;
  FPrev:=nil;
  FNeighbour0:=nil;
  FNeighbour1:=nil;
  FTacticFastE:=nil;
  FTacticStealthE:=nil;
end;

procedure TBoundaryLayer.DoCalcDelayTime(const TacticU:IUnknown;
                      out DelayTime, DelayTimeDispersion:double; AddDelay:double);
var
  SafeguardElementE, SafeguardElementKindE, SafeguardElementTypeE:IDMElement;
  SafeguardElementType:ISafeguardElementType;
  SafeguardElement:ISafeguardElement;
  Tactic:ITactic;
  j:integer;
  dT, dTDisp, DelayTimeDispersionRatio,
  PassVelocity, PassTime:double;
  OvercomeMethod:IOvercomeMethod;
  OvercomeMethodE, WarriorGroupE:IDMElement;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  Unk:IUnknown;
begin
  Tactic:=TacticU as ITactic;
  if Tactic.SafeguardClasses.Count=0 then begin
    DelayTime:=InfinitValue/1000;
    DelayTimeDispersion:=InfinitValue;
    Exit;
  End;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  PassVelocity:=(Parent as IBoundary).GetPassVelocity;
  if Parent.ClassID<>_Jump then
    PassTime:=abs(FDistanceFromPrev)/PassVelocity
  else
    PassTime:=0;  // длина Jump учитывается отдельно 

  if Get_UserDefinedDelayTime and
    ((WarriorGroupE.QueryInterface(IAdversaryGroup, Unk)=0) or
     ((Parent.ClassID=_Boundary) and
     (Parent.Ref.Parent.ID<>btEntryPoint))) then begin  // через точки доступа охрана проходит беспрепятственно
    DelayTime:=PassTime+Get_DelayTime+AddDelay;
    DelayTimeDispersion:=sqr(DelayTimeDispersionRatio*DelayTime);
    Exit;
  end;

  DelayTime:=abs(FDistanceFromPrev)/PedestrialVelocity+AddDelay;
  DelayTimeDispersion:=sqr(DelayTimeDispersionRatio*DelayTime);
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    SafeguardElement:=SafeguardElementE as ISafeguardElement;
    SafeguardElementKindE:=SafeguardElementE.Ref;
    if SafeguardElementKindE<>nil then begin
      SafeguardElementTypeE:=SafeguardElementKindE.Parent;
      SafeguardElementType:=SafeguardElementTypeE as ISafeguardElementType;
      if Tactic.DependsOn(SafeguardElementTypeE) and
         SafeguardElementType.CanDelay then begin
        SafeguardElement.CalcDelayTime(TacticU, dT, dTDisp);
        DelayTime:=DelayTime+dT;
        DelayTimeDispersion:=DelayTimeDispersion+dTDisp;

        OvercomeMethodE:=SafeguardElement.CurrOvercomeMethod;
        OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
        if OvercomeMethod<>nil then begin
          theDependingSafeguardElementList.Add(pointer(SafeguardElementE));
          theBestOvercomeMethodList.Add(pointer(OvercomeMethodE));
        end;
      end;
    end;
  end;
  if DelayTime>InfinitValue/1000 then
    DelayTime:=InfinitValue/1000;
end;

procedure TBoundaryLayer.CalcDelayTime(out DelayTime: Double; out DelayTimeDisp: Double;
                                       AddDelay: Double);
var
  j, PathStage:integer;
  MinTime, BestTimeDispersion, dT, dTDisp:double;
  TacticE:IDMElement;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  DelayTimeDispersionRatio, PassVelocity,
  PassTime, PassTimeDispersion:double;
  SubBoundaryE:IDMElement;
  SubBoundary:IPathElement;
  Boundary:IBoundary;
  BoundaryLayerType:IBoundaryLayerType;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  PathStage:=FacilityModelS.CurrentPathStage;
  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;
  Boundary:=Parent as IBoundary;

  PassVelocity:=Boundary.GetPassVelocity;
  PassTime:=abs(FDistanceFromPrev)/PassVelocity;
  PassTimeDispersion:=sqr(DelayTimeDispersionRatio*PassTime);

  if Get_UserDefinedDelayTime then begin  // через точки доступа охрана проходит беспрепятственно
    DelayTime:=PassTime+Get_DelayTime+AddDelay;
    DelayTimeDisp:=PassTimeDispersion+sqr(DelayTimeDispersionRatio*DelayTime);
    Exit;
  end;

  MinTime:=InfinitValue/1000;
  BestTimeDispersion:=0;

  DependingSafeguardElementList.Clear;
  BestOvercomeMethodList.Clear;
  BoundaryLayerType:=Ref as IBoundaryLayerType;
  for j:=0 to BoundaryLayerType.Tactics.Count-1 do begin
    TacticE:=BoundaryLayerType.Tactics.Item[j];
    if AcceptableTactic(TacticE) then begin
      theDependingSafeguardElementList.Clear;
      theBestOvercomeMethodList.Clear;
      DoCalcDelayTime(TacticE,
                      dT, dTDisp, AddDelay);

      if MinTime>dT then begin
        MinTime:=dT;
        BestTimeDispersion:=dTDisp;

        if PathStage=wpsFastEntry then
          UpdateDependingElements(
            DependingSafeguardElementList,
            theDependingSafeguardElementList,
            BestOvercomeMethodList,
            theBestOvercomeMethodList);
        if MinTime=0 then
          Break
      end;
    end;
  end;
  if MinTime>0 then begin
    for j:=0 to FSubBoundaries.Count-1 do begin
      SubBoundaryE:=FSubBoundaries.Item[j];
      SubBoundary:=SubBoundaryE as IPathElement;
      SubBoundary.CalcDelayTime(dT, dTDisp, TacticE, AddDelay);
      if MinTime>dT then begin
        MinTime:=dT;
        BestTimeDispersion:=dTDisp;
        if MinTime=0 then
          Break
      end;
    end;
  end;

  UpdateDependingElementBestMethods
             (DependingSafeguardElementList,
              BestOvercomeMethodList);


  DelayTime:=MinTime+PassTime;
  DelayTimeDisp:=BestTimeDispersion+PassTimeDispersion;
end;

procedure TBoundaryLayer.DoCalcNoDetectionProbability(const TacticU: IUnknown;
                          ObservationPeriod:double;
                      out NoDetP, NoFailureP:double;
                      out NoEvidence:WordBool;
                      out BestTimeSum, BestTimeDispSum:double;
                      out Position:integer;
                          AddDelay:double);
var
  SafeguardElementE, SafeguardElementKindE, SafeguardElementTypeE:IDMElement;
  SafeguardElementType:ISafeguardElementType;
  SafeguardElement:ISafeguardElement;
  Tactic:ITactic;
  aNoDetP, aDetP, BestTime:double;
  j:integer;
  OvercomeMethod:IOvercomeMethod;
  OvercomeMethodE:IDMElement;
  DelayTimeDispersionRatio:double;
  FacilityModel:IFacilityModel;
  Boundary:IBoundary;
  GuardPostE:IDMElement;
  InsiderTarget:IInsiderTarget;
begin
  Tactic:=TacticU as ITactic;
  if Tactic.SafeguardClasses.Count=0 then begin
    NoDetP:=0;
    NoFailureP:=0;
    NoEvidence:=False;
    BestTimeSum:=InfinitValue/1000;
    BestTimeDispSum:=InfinitValue;
    Exit;
  end;

  NoDetP:=1;
  NoFailureP:=1;
  NoEvidence:=True;


  if not Tactic.ForceTactic then begin
    Boundary:=Parent as IBoundary;
    if Parent.Ref.ID=btEntryPoint then begin
      j:=0;
      while j<Boundary.Observers.Count do begin
        GuardPostE:=Boundary.Observers.Item[j];
        if (GuardPostE.QueryInterface(IInsiderTarget, InsiderTarget)=0) and
           (GuardPostE.Parent.ClassID=_BoundaryLayer) then begin
          if InsiderTarget.ControledByInsider<>2 then
            Break                  // не полностью подкупленный пост
          else
            inc(j)
        end else
          inc(j)  // пост не на рубеже может не заметить
      end;
      if (j<Boundary.Observers.Count) then begin// есть гарантированный наблюдатель
        NoDetP:=0;
        NoFailureP:=0;
        NoEvidence:=False;
        BestTimeSum:=InfinitValue/1000;
        BestTimeDispSum:=InfinitValue;
        Exit;
      end;
    end;
  end;

  FacilityModel:=DataModel as IFacilityModel;
  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  if Get_UserDefinedDetectionProbability then begin
    NoDetP:=1-Get_DetectionProbability;

    if Get_UserDefinedDelayTime then
      BestTimeSum:=Get_DelayTime
    else
      BestTimeSum:=0;
    BestTimeDispSum:=sqr(DelayTimeDispersionRatio*BestTimeSum);

    Exit;
  end;

  BestTimeSum:=abs(FDistanceFromPrev)/PedestrialVelocity+AddDelay;
  BestTimeDispSum:=sqr(DelayTimeDispersionRatio*BestTimeSum);

  Position:=2;
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    SafeguardElementKindE:=SafeguardElementE.Ref;
    if SafeguardElementKindE<>nil then begin
      SafeguardElementTypeE:=SafeguardElementKindE.Parent;
      SafeguardElementType:=SafeguardElementTypeE as ISafeguardElementType;
      if Tactic.DependsOn(SafeguardElementTypeE) then begin
        SafeguardElement:=SafeguardElementE as ISafeguardElement;
        SafeguardElement.CalcDetectionProbability(TacticU, aDetP, BestTime);
        BestTimeSum:=BestTimeSum+BestTime;
        BestTimeDispSum:=BestTimeDispSum+sqr(DelayTimeDispersionRatio*BestTime);
        aNoDetP:=1-aDetP;
        OvercomeMethodE:=SafeguardElement.CurrOvercomeMethod;
        OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
        if OvercomeMethod<>nil then begin
          theDependingSafeguardElementList.Add(pointer(SafeguardElementE));
          theBestOvercomeMethodList.Add(pointer(OvercomeMethodE));
        end;

        if Position>SafeguardElement.DetectionPosition then
          Position:=SafeguardElement.DetectionPosition;

        NoDetP:=NoDetP*aNoDetP;
        if OvercomeMethod<>nil then begin
          if OvercomeMethod.Failure then
            NoFailureP:=NoFailureP*aNoDetP;
          NoEvidence:=NoEvidence and not OvercomeMethod.Evidence
        end;
      end; // if Tactic.DependsOn(SafeguardElementTypeE)
    end; // if SafeguardElementKindE<>nil
  end;  // for j:=0 to FSafeguardElements.Count-1
  if BestTimeSum>InfinitValue/1000 then begin
    BestTimeSum:=InfinitValue/1000;
    NoDetP:=0;
  end else begin
    if (ObservationPeriod>0) and (ObservationPeriod<InfinitValue) then
      NoDetP:=NoDetP*exp(-BestTimeSum/ObservationPeriod)
  end;
end;


procedure TBoundaryLayer.CalcNoDetectionProbability(
                           out NoDetP, NoFailureP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                               AddDelay:double);
var
  j:integer;
  aNoDetP, MaxNoDetP,
  aNoFailureP:double;
  aNoEvidence:WordBool;
  TacticE:IDMElement;
  FacilityModel:IFacilityModel;
  SubBoundaryE:IDMElement;
  SubBoundary:IPathElement;
  ObservationPeriod:double;
  BoundaryLayerType:IBoundaryLayerType;
begin
  NoDetP:=1;
  NoFailureP:=1;
  NoEvidence:=True;

  if Get_UserDefinedDetectionProbability then begin
    NoDetP:=1-Get_DetectionProbability;
    Exit;
  end;

  ObservationPeriod:=RecalcObservationPeriod;

  FacilityModel:=DataModel as IFacilityModel;
  MaxNoDetP:=-1;
  DependingSafeguardElementList.Clear;
  BestOvercomeMethodList.Clear;
  BoundaryLayerType:=Ref as IBoundaryLayerType;
  for j:=0 to BoundaryLayerType.Tactics.Count-1 do begin
    TacticE:=BoundaryLayerType.Tactics.Item[j];
    if AcceptableTactic(TacticE) then begin

      theDependingSafeguardElementList.Clear;
      theBestOvercomeMethodList.Clear;
      DoCalcNoDetectionProbability(TacticE,
                        ObservationPeriod,
                        aNoDetP,
                        aNoFailureP,
                        aNoEvidence,
                        BestTimeSum, BestTimeDispSum, Position,
                        AddDelay);

      if MaxNoDetP<aNoDetP then begin
        MaxNoDetP:=aNoDetP;

        NoDetP:=aNoDetP;
        NoFailureP:=aNoFailureP;
        NoEvidence:=aNoEvidence;
        if MaxNoDetP=1 then
          Break;

      end;
    end;
  end;
  if MaxNoDetP<1 then begin
    for j:=0 to FSubBoundaries.Count-1 do begin
      SubBoundaryE:=FSubBoundaries.Item[j];
      SubBoundary:=SubBoundaryE as IPathElement;
      SubBoundary.CalcNoDetectionProbability(
                         aNoDetP,
                         aNoFailureP,
                         aNoEvidence,
                         BestTimeSum, BestTimeDispSum,
                         Position,
                         TacticE, AddDelay);
      aNoDetP:=aNoDetP;
      if MaxNoDetP<aNoDetP then begin
        MaxNoDetP:=aNoDetP;

        NoDetP:=aNoDetP;
        NoFailureP:=aNoFailureP;
        NoEvidence:=aNoEvidence;
        if MaxNoDetP=1 then
          Break;
      end;
    end;
  end;

end;

function TBoundaryLayer.Get_InstallPrice: integer;
begin
  Result:=0;
end;

function TBoundaryLayer.Get_MaintenancePrice: integer;
begin
  Result:=0;
end;

function TBoundaryLayer.Get_CollectionCount: integer;
begin
  if FSubBoundaries.Count>0 then
    Result:=ord(High(TBoundaryLayerCategory))+1
  else
    Result:=ord(High(TBoundaryLayerCategory))
end;

procedure TBoundaryLayer.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
begin
  inherited;
end;

function TBoundaryLayer.Get_IsTransparent: WordBool;
begin
  Result:=(FParamFlags and pfTransparent)<>0
end;

function TBoundaryLayer.Get_HasNoFieldBarrier: WordBool;
begin
  Result:=(FParamFlags and pfNoFieldBarrier)<>0
end;

function TBoundaryLayer.Get_IsFragile: WordBool;
begin
  Result:=(FParamFlags and pfFragile)<>0
end;

function TBoundaryLayer.CalcAttenuation(const PhysicalField:IDMElement):double;
var
  j:integer;
  SafeguardElementE:IDMElement;
  Barrier:IBarrier;
begin
  Result:=0;
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    if SafeguardElementE.ClassID=_Barrier then begin
      Barrier:=SafeguardElementE as IBarrier;
      Result:=Result+Barrier.CalcAttenuation(PhysicalField);
    end;
  end;
end;

function TBoundaryLayer.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(blpHeight0):
    Result:=FHeight0;
  ord(blpHeight1):
    Result:=FHeight1;
  ord(blpDistanceFromPrev):
    Result:=FDistanceFromPrev;
  ord(blpDrawJoint0):
    Result:=FDrawJoint0;
  ord(blpDrawJoint1):
    Result:=FDrawJoint1;
  ord(blpUserDefinedDelayTime):
    Result:=FUserDefinedDelayTime;
  ord(blpDelayTime):
    Result:=FDelayTime;
  ord(blpUserDefinedDetectionProbability):
    Result:=FUserDefinedDetectionProbability;
  ord(blpDetectionProbability):
    Result:=FDetectionProbability;
  ord(blpConstruction):
    Result:=FConstruction;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TBoundaryLayer.SetFieldValue(Code:integer; Value:OleVariant);
var
  Painter:IUnknown;
begin
  Painter:=nil;
  case Code of
  ord(blpHeight0),
  ord(blpHeight1),
  ord(blpDistanceFromPrev),
  ord(blpDrawJoint0),
  ord(blpDrawJoint1):
    begin
      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (not DataModel.IsCopying) then begin
        Painter:=(DataModel.Document as ISMDocument).PainterU;
        Draw(Painter, -1);
      end;

        case Code of
        ord(blpHeight0):
          begin
            FHeight0:=Value;
            FHeight1:=Value;
          end;
        ord(blpHeight1):
          FHeight1:=Value;
        ord(blpDistanceFromPrev):
          begin
            FDistanceFromPrev:=Value;
            if (DataModel<>nil) and
              (not DataModel.IsLoading) and
              (not DataModel.IsCopying) and
              (Parent<>nil) then
              Parent.UpdateCoords;
          end;
        ord(blpDrawJoint0):
          FDrawJoint0:=Value;
        ord(blpDrawJoint1):
          FDrawJoint1:=Value;
        end;

      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (not DataModel.IsCopying) then begin
        if Parent<>nil then begin
          if Parent.Selected then
            Draw(Painter, 1)
          else
            Draw(Painter, 0)
        end;
      end;
    end;
  ord(blpUserDefinedDelayTime):
    begin
      FUserDefinedDelayTime:=Value;
      UpdateUserDefinedElements(FUserDefinedDelayTime);
    end;
  ord(blpDelayTime):
    FDelayTime:=Value;
  ord(blpUserDefinedDetectionProbability):
    begin
      FUserDefinedDetectionProbability:=Value;
      UpdateUserDefinedElements(FUserDefinedDetectionProbability);
    end;
  ord(blpDetectionProbability):
    FDetectionProbability:=Value;
  ord(blpConstruction):
    FConstruction:=Value;
  else
    inherited
  end;
end;

class function TBoundaryLayer.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TBoundaryLayer.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsHeight0, '%0.1f', '', '',
                 fvtFloat, InfinitValue, 0, 0,
                 ord(blpHeight0), 0, pkInput or pkChart);
  AddField(rsHeight1, '%0.1f', '', '',
                 fvtFloat, InfinitValue, 0, 0,
                 ord(blpHeight1), 0, pkInput);
  AddField(rsDistanceFromPrev, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(blpDistanceFromPrev), 0, pkInput or pkChart);
  AddField(rsDrawJoint0,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(blpDrawJoint0), 0, pkView);
  AddField(rsDrawJoint1,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(blpDrawJoint1), 0, pkView);
  AddField(rsUserDefinedDelayTime, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(blpUserDefinedDelayTime), 0, pkUserDefined);
  AddField(rsDelayTime, '%9.0f', '', '',
                 fvtFloat,   0, 0, InfinitValue,
                 ord(blpDelayTime), 0, pkUserDefined);
  AddField(rsUserDefinedDetectionProbability, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(blpUserDefinedDetectionProbability), 0, pkUserDefined);
  AddField(rsDetectionProbability, '%.3f', '', '',
                 fvtFloat,   0, 0, 1,
                 ord(blpDetectionProbability), 0, pkUserDefined);
  S:='|'+'Без шлюзования и доводчика'+
     '|'+'Без шлюзования с доводчиком'+
     '|'+'Шлюзование';
  AddField(rsBoundaryLayerConstruction, S, '', '',
                 fvtChoice, 1, 0, InfinitValue,
                 ord(blpConstruction), 0, pkInput);
end;

function TBoundaryLayer.Get_Collection(Index: Integer): IDMCollection;
begin
  case TBoundaryLayerCategory(Index) of
  dlcSafeguardElements:
    Result:=FSafeguardElements;
  dlcSubBoundaries:
    Result:=FSubBoundaries;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

procedure TBoundaryLayer.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  DataModelE:IDMElement;
  BoundaryLayerType:IBoundaryLayerType;
begin
  case TBoundaryLayerCategory(Index) of
  dlcSafeguardElements:
    begin
      aRefSource:=nil;
      aCollectionName:=rsSafeguardElements2;
      aLinkType:=ltOneToMany;

      if Ref<>nil then begin
        aClassCollections:=Ref as IDMClassCollections;
        aOperations:=leoAdd or leoDelete or leoChangeRef;
      end else begin
        aClassCollections:=nil;
        aOperations:=0;
      end;
    end;
  dlcSubBoundaries:
    begin
      inherited;
      DataModelE:=DataModel as IDMElement;
      if Ref<>nil then begin
        BoundaryLayerType:=Ref as  IBoundaryLayerType;
        aRefSource:=BoundaryLayerType.SubBoundaryKinds;
        if aRefSource.Count=0 then begin
          aRefSource:=nil;
          aOperations:=0;
        end;
      end else begin
        aRefSource:=nil;
        aOperations:=0;
      end;
    end;
  else
    inherited
  end;
end;

class function TBoundaryLayer.GetClassID: integer;
begin
  Result:=_BoundaryLayer
end;

function TBoundaryLayer.Get_SafeguardElements: IDMCollection;
begin
  Result:=FSafeguardElements
end;

function TBoundaryLayer.GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer;
var
  j:integer;
  SafeguardElementE, ModelElementTypeE, ModelElementKindE:IDMElement;
  ModelElementType:IModelElementType;
  Prohibition, Res:integer;
begin
  case Kind of
  sdProhibition:
    begin
      Res:=0;
      for j:=0 to FSafeguardElements.Count-1 do begin
        SafeguardElementE:=FSafeguardElements.Item[j];
        if SafeguardElementE.ClassID=_ContrabandSensor then begin
          ModelElementKindE:=SafeguardElementE.Ref;
          ModelElementTypeE:=ModelElementKindE.Parent;
          ModelElementType:=ModelElementTypeE as IModelElementType;
          if ModelElementType.TypeID=1 then begin
            Prohibition:=ModelElementKindE.GetFieldValue(100);
            case Prohibition of
            0:Res:=Res or 1;
            else
              Res:=Res or 2;
            end;
          end;
        end;
      end;
      Result:=Res;
    end;
  else
    Result:=-1
  end;
end;

function TBoundaryLayer.Get_SoundResistance: double;
var
  j:integer;
  SafeguardElementE, SafeguardElementKindE:IDMElement;
  BarrierKind:IBarrierKind;
begin
  Result:=0;
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    SafeguardElementKindE:=SafeguardElementE.Ref;
    if (SafeguardElementE.ClassID=_Barrier) and
       (SafeguardElementKindE<>nil) then begin
      BarrierKind:=SafeguardElementKindE as IBarrierKind;
      Result:=Result+BarrierKind.SoundResistance;
    end;
  end;
end;

function TBoundaryLayer.Get_Height0: double;
begin
  Result:=FHeight0
end;

function TBoundaryLayer.Get_Height1: double;
begin
  Result:=FHeight1
end;

function TBoundaryLayer.Get_Name: WideString;
var
  S:string;
  j, N:integer;
  SafeguardElementE:IDMElement;
  SafeguardElement:ISafeguardElement;
begin
  if FSafeguardElements.Count=0 then
    S:=rsBoundaryLayer2+' '+inherited Get_Name
  else begin // if FSafeguardElements.Count>0
    S:='';
    N:=0;
    for j:=0 to FSafeguardElements.Count-1 do begin
      SafeguardElementE:=FSafeguardElements.Item[j];
      SafeguardElement:=SafeguardElementE as ISafeguardElement;
      if SafeguardElement.IsPresent and
         SafeguardElement.ShowInLayerName then begin
        if S<>'' then
          S:=S+'+';
        S:=S+SafeguardElementE.Name;
        inc(N);
      end;  // if SafeguardElement.ShowInLayerName
    end;  // for j:=0 to FSafeguardElements.Count-1
    if N=0 then begin
      SafeguardElementE:=FSafeguardElements.Item[0];
      S:=SafeguardElementE.Name;
      inc(N);
    end; // if N=0
    if N<FSafeguardElements.Count-1 then
      S:=S+'+...'
  end;  // if FSafeguardElements.Count>0
  Result:=S;
//  if Parent<>nil then
//    Result:=S+' / '+Parent.Name;
end;

function TBoundaryLayer.Get_UserDefineded: WordBool;
var
  j:integer;
  SafeguardElementUserDefined:boolean;
  SafeguardElementE:IDMElement;
begin
  j:=0;
  while j<FSafeguardElements.Count do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    if SafeguardElementE.UserDefineded then
      Break
    else
      inc(j)
  end;
  SafeguardElementUserDefined:=j<FSafeguardElements.Count;
  Result:=(inherited Get_UserDefineded) or SafeguardElementUserDefined
end;

function TBoundaryLayer.Get_IsEmpty: WordBool;
begin
  Result:=FSafeguardElements.Count=0
end;

function TBoundaryLayer.FieldIsVisible(Code: integer): WordBool;
var
  AreaE:IDMElement;
  Area:IArea;
  Boundary:IBoundary;
begin
  try
  case Code of
  ord(blpUserDefinedDelayTime):
    Result:=True;
  ord(blpDelayTime):
    Result:=Get_UserDefinedDelayTime;
  ord(blpUserDefinedDetectionProbability):
    Result:=True;
  ord(blpDetectionProbability):
    Result:=Get_UserDefinedDetectionProbability;
  ord(blpHeight0),
  ord(blpHeight1):
    Result:=(FHeight0<>-1) and (FHeight1<>-1);
  ord(blpDistanceFromPrev),
  ord(blpDrawJoint0),
  ord(blpDrawJoint1),
  ord(cnstShowSymbol),
  ord(cnstSymbolScaleFactor),
  ord(cnstImageRotated),
  ord(cnstImageMirrored),
  ord(blpConstruction):
    begin
      AreaE:=Parent.SpatialElement;
      if AreaE=nil then
        Result:=True
      else
      if AreaE.QueryInterface(IArea, Area)<>0 then
        Result:=False
      else
        Result:=Area.IsVertical;
      if Result and
         (Code=ord(blpDistanceFromPrev)) then begin
        Boundary:=Parent as IBoundary;
        Result:=(Boundary.BoundaryLayers.Count>1) or
                (FDistanceFromPrev<>0);
      end;
      if Result and
         (Code=ord(blpConstruction)) and
         (Ref<>nil) then begin
        Result:= ((Parent.Ref.Parent as IModelElementType).TypeID=btEntryPoint)
      end;

    end;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
  except
    raise
  end;  
end;

procedure TBoundaryLayer.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  FacilityModel:IVulnerabilityMap;
  BoundaryLayerType:IBoundaryLayerType;
  LocalView:IView;
  Painter:IPainter;
  Boundary:IBoundary;
  SafeguardElementE:IDMElement;
  SafeguardElement:ISafeguardElement;
  SafeguardElementKindV:IVisualElement;
  Area:IArea;
  C0, C1, TopC:ICoordNode;
  L:double;
  DefaultDraw:boolean;
  Layer:ILayer;
  ZAngle, cos_A,
  H0, H1:double;
  Z0, Z1, TopZ0, TopZ1:double;
  View:IView;

  j:integer;

  procedure DoDraw(const aImage:IElementImage; L, W, ScaleFactor, DX, DY:double; ImageRotated, ImageMirrored:boolean);
  var
    N, m:integer;
    K0, K1, dL, dL2, MaxH, OldX, OldY, OldCurrX0, OldCurrY0, OldCurrZ0:double;
  begin
    if aImage=nil then Exit;
    View:=Painter.ViewU as IView;
    if View=nil then Exit;

    MaxH:=max(FHeight0, FHeight1);
    if MaxH<0 then
      MaxH:=max(H0, H1)/100;

    if ImageRotated then
      LocalView.ZAngle:=ZAngle+180
    else
      LocalView.ZAngle:=ZAngle;

    N:=1;
    dL:=0;
    dL2:=0;
    case aImage.ScalingType of
    eitNoScaling:
      LocalView.RevScale:=1/View.RevScale/ScaleFactor;
    eitScaling:
      LocalView.RevScale:=1/ScaleFactor;
    eitXScaling:
      begin
        LocalView.RevScaleX:=aImage.XSize/L/ScaleFactor;
        if W=0 then
          LocalView.RevScaleY:=1/ScaleFactor
        else
          LocalView.RevScaleY:=aImage.YSize/W/ScaleFactor;
        LocalView.RevScaleZ:=aImage.ZSize/(MaxH*100)/ScaleFactor;
      end;
    eitXYScaling:
      begin
        LocalView.RevScaleX:=aImage.XSize/L/ScaleFactor;
        LocalView.RevScaleY:=LocalView.RevScaleX;
        LocalView.RevScaleZ:=aImage.ZSize/(MaxH*100)/ScaleFactor;
      end;
    eitMultScaling:
      begin
        K0:=aImage.MinPixels*ScaleFactor;
        K1:=L/View.RevScale;
        N:=ceil(K1/K0);
        if N>1 then begin
          dL:=L/N;
          dL2:=dL/2;
          LocalView.RevScale:=aImage.MaxSize/dL/ScaleFactor;
        end else
          LocalView.RevScale:=aImage.MaxSize/L/ScaleFactor;
      end;
    end;
    if LocalView.RevScaleZ=0 then
      LocalView.RevScaleZ:=1/ScaleFactor;

    OldX:=LocalView.CX;
    OldY:=LocalView.CY;
    OldCurrX0:=LocalView.CurrX0;
    OldCurrY0:=LocalView.CurrY0;
    OldCurrZ0:=LocalView.CurrZ0;
    LocalView.CurrX0:=DX;
    LocalView.CurrY0:=DY;
    if ImageMirrored then
      LocalView.CurrZ0:=-1
    else
      LocalView.CurrZ0:=+1;

    if N=1 then begin
      if (DrawSelected=-1) then
        (aImage as IDMElement).Draw(aPainter, -1)
      else
      if (DrawSelected=1) or Parent.SpatialElement.Selected then
        (aImage as IDMElement).Draw(aPainter, 1)
      else
        (aImage as IDMElement).Draw(aPainter, 0);
    end else begin
      for m:=0 to N-1 do begin
        LocalView.CX:=FX0+(FX1-FX0)/L*(m*dL+dL2);
        LocalView.CY:=FY0+(FY1-FY0)/L*(m*dL+dL2);
        if (DrawSelected=-1) then
          (aImage as IDMElement).Draw(aPainter, -1)
        else
        if (DrawSelected=1) or Parent.SpatialElement.Selected then
          (aImage as IDMElement).Draw(aPainter, 1)
        else
          (aImage as IDMElement).Draw(aPainter, 0);
      end;
    end;
    LocalView.CX:=OldX;
    LocalView.CY:=OldY;
    LocalView.CurrX0:=OldCurrX0;
    LocalView.CurrY0:=OldCurrY0;
    LocalView.CurrZ0:=OldCurrZ0;
  end;

var
  Image, aImage, Image2:IElementImage;
  SafeguardElementKindE, BarrierKindE, TextureE:IDMElement;
  AreaE:IDMElement;
  AreaP:IPolyline;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  Lines2, CoordNodes2:IDMCollection2;
  Document:IDMDocument;
  OldState:integer;
  VLine:ILine;
  BottomLayerE, TopLayerE, LayerE, Layer0E,  Layer1E:IDMElement;
  _TopLine, _BottomLine, _VLine0, _VLine1:ILine;
  PrevLayer:IBoundaryLayer;
  W, W0, W1, cosB, LL, L0, L1, X0, X1, Y0, Y1, NX, NY, NZ, MX, MY, H, ScaleFactor,
  OldX, OldY, DX, DY:double;
  NeighbourLayer0, NeighbourLayer1:IBoundaryLayer;
  Barrier:IBarrier;
  BarrierKind:IBarrierKind;
  Texture:ITexture;
  TextureName:WideString;
  TextureNum:integer;
  Imager:IImager;
  ImageRotated, ImageMirrored:boolean;
  WidthIntf:IWidthIntf;
  BackMode:WordBool;
  SafeguardElementD:IDistantDetectionElement;

  procedure MakeLocalView;
  begin
    LocalView:=(SpatialModel2.Views as IDMCollection2).CreateElement(True) as IView;
    LocalView.CX:=0.5*(FX0+FX1);
    LocalView.CY:=0.5*(FY0+FY1);
    LocalView.CZ:=0.5*(Z0+Z1);

    if L=0 then
      ZAngle:=0
    else begin
      cos_A:=(FX1-FX0)/L;
      if cos_A=1 then
        ZAngle:=0
      else
      if cos_A=0 then
        ZAngle:=90
      else
        ZAngle:=arccos(cos_A)/3.1415926*180;
      if FY1-FY0<0 then
        ZAngle:=-ZAngle;
    end;

    Painter.LocalViewU:=LocalView;
  end;
begin
  inherited;
  Painter:=aPainter as IPainter;
  if Painter=nil then Exit;

  if Parent=nil then Exit;
  if Parent.ClassID<>_Boundary then Exit;
  if Ref=nil then Exit;

  L:=sqrt(sqr(FX0-FX1)+sqr(FY0-FY1));
  if L=0 then Exit;

  Document:=DataModel.Document as IDMDocument;
  SpatialModel2:=DataModel as ISpatialModel2;
  FacilityModel:=DataModel as IVulnerabilityMap;

  OldState:=Document.State;
  Document.State:=Document.State or dmfExecuting;

  try
  if _BottomLineE=nil then begin
     SpatialModel:=DataModel as ISpatialModel;
     Lines2:=SpatialModel.Lines as IDMCollection2;
     CoordNodes2:=SpatialModel.CoordNodes as IDMCollection2;

    _BottomLineE:=Lines2.CreateElement(True);
    _TopLineE:=Lines2.CreateElement(True);
    _VLine0E:=Lines2.CreateElement(True);
    _Vline1E:=Lines2.CreateElement(True);
    _BottomLine:=_BottomLineE as ILine;
    _TopLine:=_TopLineE as ILine;
    _VLine0:=_VLine0E as ILine;
    _VLine1:=_VLine1E as ILine;

    _BottomC0:=CoordNodes2.CreateElement(True) as ICoordNode;
    _BottomC1:=CoordNodes2.CreateElement(True) as ICoordNode;
    _TopC0:=CoordNodes2.CreateElement(True) as ICoordNode;
    _TopC1:=CoordNodes2.CreateElement(True) as ICoordNode;
    _BottomLine.C0:=_BottomC0;
    _BottomLine.C1:=_BottomC1;
    _TopLine.C0:=_TopC0;
    _TopLine.C1:=_TopC1;
    _VLine0.C0:=_BottomC0;
    _VLine0.C1:=_TopC0;
    _VLine1.C0:=_BottomC1;
    _VLine1.C1:=_TopC1;
  end;
  finally
    Document.State:=OldState;
  end;

  Boundary:=Parent as IBoundary;

  AreaE:=Parent.SpatialElement;
  if AreaE=nil then Exit;
  if AreaE.QueryInterface(IArea, Area)<>0 then Exit;
  if not Area.IsVertical then Exit;

  AreaP:=AreaE as IPolyline;

  LayerE:=AreaE.Parent;
  Layer:=LayerE as ILayer;

  BoundaryLayerType:=Ref as IBoundaryLayerType;
  if FShowSymbol then
    Image:=(BoundaryLayerType as IVisualElement).Image
  else
     Image:=nil;

  C0:=Area.C0;
  C1:=Area.C1;
  Z0:=C0.Z;
  Z1:=C1.Z;

  H0:=0;
  TopC:=C0;
  VLine:=TopC.GetVerticalLine(bdUp);
  if VLine<>nil then
    Layer0E:=(VLine as IDMElement).Parent
  else
    Layer0E:=LayerE;
  while (VLine<>nil) and
   (AreaP.Lines.IndexOf(VLine as IDMElement)<>-1) do begin
    H0:=H0+VLine.Length;
    TopC:=VLine.C1;
    VLine:=TopC.GetVerticalLine(bdUp);
  end;

  H1:=0;
  TopC:=C1;
  VLine:=TopC.GetVerticalLine(bdUp);
  if VLine<>nil then
    Layer1E:=(VLine as IDMElement).Parent
  else
    Layer1E:=LayerE;
  while (VLine<>nil) and
   (AreaP.Lines.IndexOf(VLine as IDMElement)<>-1) do begin
    H1:=H1+VLine.Length;
    TopC:=VLine.C1;
    VLine:=TopC.GetVerticalLine(bdUp);
  end;

{
  if DrawSelected<>-1 then begin
    if FHeight0>0.01*H0 then
      FHeight0:=0.01*H0;
    if FHeight1>0.01*H1 then
      FHeight1:=0.01*H1;
  end;
}
  if FHeight0<0 then
    TopZ0:=Z0+H0
  else
    TopZ0:=Z0+FHeight0*100;
  if FHeight1<0 then
    TopZ1:=Z1+H1
  else
    TopZ1:=Z1+FHeight1*100;

  if Area.BottomLines.Count>0 then
    BottomLayerE:=Area.BottomLines.Item[0].Parent
  else
    BottomLayerE:=nil;
  if Area.TopLines.Count>0 then
    TopLayerE:=Area.TopLines.Item[0].Parent
  else
    TopLayerE:=nil;

  try
  DefaultDraw:=True;

  Barrier:=nil;
  if FacilityModel.ShowSymbols then begin
    for j:=0 to FSafeguardElements.Count-1 do begin
      SafeguardElementE:=FSafeguardElements.Item[j];
      SafeguardElement:=SafeguardElementE as ISafeguardElement;
      SafeguardElementKindE:=SafeguardElementE.Ref;
      if (SafeguardElementKindE<>nil) and
         SafeguardElement.IsPresent and
         (SafeguardElementKindE<>nil) then begin

        if (SafeguardElementE.ClassID=_Barrier) then
          Barrier:=SafeguardElementE as IBarrier;

        SafeguardElementKindV:=SafeguardElementKindE as IVisualElement;
        aImage:=SafeguardElementKindV.Image;
        if (aImage<>nil) and
           (SafeguardElement.ShowSymbol) then begin

          if SafeguardElement.QueryInterface(IWidthIntf, WidthIntf)=0 then
            W:=WidthIntf.Width
          else
            W:=0;

          if W>0 then
            DefaultDraw:=False;

          if (SafeguardElementE.ClassID=_Barrier) then begin
            LocalView:=Painter.LocalViewU as IView;
            if LocalView=nil then
              MakeLocalView;

            NeighbourLayer0:=FNeighbour0 as IBoundaryLayer;
            if NeighbourLayer0=nil then
              W0:=0
            else begin
              W0:=0;
              X0:=NeighbourLayer0.X0;
              Y0:=NeighbourLayer0.Y0;
              X1:=NeighbourLayer0.X1;
              Y1:=NeighbourLayer0.Y1;
              L0:=sqrt(sqr(X0-X1)+sqr(Y0-Y1));
              if L0<>0 then begin
                cosB:=abs((FX0-FX1)*(X0-X1)+(FY0-FY1)*(Y0-Y1))/(L*L0);
                if cosB<>1 then
                  W0:=W0*sqrt(1-sqr(cosB))
                else
                  W0:=0;
              end;
            end;

            NeighbourLayer1:=FNeighbour1 as IBoundaryLayer;
            if NeighbourLayer1=nil then
              W1:=0
            else begin
              W1:=0;
              X0:=NeighbourLayer1.X0;
              Y0:=NeighbourLayer1.Y0;
              X1:=NeighbourLayer1.X1;
              Y1:=NeighbourLayer1.Y1;
              L1:=sqrt(sqr(X0-X1)+sqr(Y0-Y1));
              if L1<>0 then begin
                cosB:=abs((FX0-FX1)*(X0-X1)+(FY0-FY1)*(Y0-Y1))/(L*L1);
                W1:=W1*sqrt(1-sqr(cosB));
              end;
            end;

            OldX:=LocalView.CX;
            OldY:=LocalView.CY;
            if W0<>W1 then begin
              LocalView.CX:=OldX+0.5*(FX1-FX0)/L*(W1-W0);
              LocalView.CY:=OldY+0.5*(FY1-FY0)/L*(W1-W0);
            end;

            LL:=L+W0+W1;

            Imager:=SafeguardElement as IImager;
            ScaleFactor:=Imager.SymbolScaleFactor;
            ImageRotated:=Imager.ImageRotated;
            ImageMirrored:=Imager.ImageMirrored;
            DoDraw(aImage, LL, W, ScaleFactor, 0, 0, ImageRotated, ImageMirrored);

            LocalView.CX:=OldX;
            LocalView.CY:=OldY;

          end; // if (SafeguardElementE.ClassID=_Barrier)
        end;
      end;
    end;
    if Image<>nil  then
     DefaultDraw:=DefaultDraw or
                  BoundaryLayerType.AlwaysShowImage;

    for j:=0 to FSafeguardElements.Count-1 do begin
      SafeguardElementE:=FSafeguardElements.Item[j];
      SafeguardElement:=SafeguardElementE as ISafeguardElement;
      SafeguardElementKindE:=SafeguardElementE.Ref;

      if (SafeguardElementKindE<>nil) and
        SafeguardElement.IsPresent and
        (SafeguardElementKindE<>nil) then begin
        SafeguardElementKindV:=SafeguardElementKindE as IVisualElement;
        aImage:=SafeguardElementKindV.Image;
        if (aImage<>nil) and
           (SafeguardElement.ShowSymbol) and
           (SafeguardElementE.ClassID<>_Barrier) then begin
(*          if SafeguardElement.QueryInterface(IDistantDetectionElement, SafeguardElementD)=0 then begin
*)
            if (DrawSelected=-1) then
              SafeguardElementE.Draw(aPainter, -1)
            else
            if (DrawSelected=1) or Parent.SpatialElement.Selected then
              SafeguardElementE.Draw(aPainter, 1)
            else
              SafeguardElementE.Draw(aPainter, 0);
(*
          end else begin
            LocalView:=Painter.LocalView;
            if LocalView=nil then
              MakeLocalView;
            Imager:=SafeguardElement as IImager;
            ScaleFactor:=Imager.SymbolScaleFactor;
            ImageRotated:=Imager.ImageRotated;
            ImageMirrored:=Imager.ImageMirrored;
            if SafeguardElement.QueryInterface(IWidthIntf, WidthIntf)=0 then
              W:=WidthIntf.Width
            else
              W:=0;
            if SafeguardElementE.SpatialElement=nil then begin
              DX:=SafeguardElement.SymbolDX;
              DY:=SafeguardElement.SymbolDY;
            end else begin
              DX:=0;
              DY:=0;
            end;
            DoDraw(aImage, L, W, ScaleFactor, DX, DY, ImageRotated, ImageMirrored);
          end;
*)
        end;
      end;
    end;
  end;

  Texture:=nil;
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    SafeguardElement:=SafeguardElementE as ISafeguardElement;
    BarrierKindE:=SafeguardElementE.Ref;
    if (BarrierKindE<>nil) and
       SafeguardElement.IsPresent and
       (SafeguardElementE.ClassID=_Barrier) then begin
       BarrierKind:=BarrierKindE as IBarrierKind;
       Texture:=BarrierKind.Texture;
    end;
  end;
//  if Parent.ID=501 then begin
  if (Texture<>nil) and
       (L<>0) then begin
    TextureE:=Texture as IDMElement;
    TextureName:=TextureE.Name;
    TextureNum:=Texture.Num;
    NX:=Area.NX;
    NY:=Area.NY;
    NZ:=Area.NZ;
    H:=TopZ0-Z0;
    if H=0 then
      H:=TopZ1-Z1;
    if H>L then begin
      MX:=1;
      MY:=H/L;
    end else begin
      MX:=L/H;
      MY:=1;
    end;

    Painter.DrawTexture(TextureName, TextureNum,
                       FX0, FY0, Z0,
                       FX0, FY0, TopZ0,
                       FX1, FY1, TopZ1,
                       FX1, FY1, Z1,
                       NX, NY, NZ,
                       MX, MY
                       );
    Texture.Num:=TextureNum;
  end;
//  end;

  OldState:=Document.State;
  Document.State:=Document.State or dmfExecuting;
  _BottomC0.X:=FX0;
  _BottomC0.Y:=FY0;
  _BottomC0.Z:=Z0;
  _BottomC1.X:=FX1;
  _BottomC1.Y:=FY1;
  _BottomC1.Z:=Z1;

  _TopC0.X:=FX0;
  _TopC0.Y:=FY0;
  _TopC0.Z:=TopZ0;
  _TopC1.X:=FX1;
  _TopC1.Y:=FY1;
  _TopC1.Z:=TopZ1;
  if (FHeight0>=0) or
     (FHeight1>=0) then
    TopLayerE:=LayerE;

  _BottomLineE.Parent:=BottomLayerE;
  _TopLineE.Parent:=TopLayerE;
  _VLine0E.Parent:=Layer0E;
  _VLine1E.Parent:=Layer1E;

  if DefaultDraw then begin
    if Image<>nil then begin
      LocalView:=Painter.LocalViewU as IView;
      if LocalView=nil then
        MakeLocalView;
      ScaleFactor:=Get_SymbolScaleFactor;
      ImageRotated:=Get_ImageRotated;
      ImageMirrored:=Get_ImageMirrored;
      if Barrier<>nil then begin
         Image2:= (BoundaryLayerType as IVisualElement).Image2;
         if Image2<>nil then
           Image:=Image2;
      end;
      DoDraw(Image, L, 0, ScaleFactor, 0, 0, ImageRotated, ImageMirrored)
    end else begin
      Painter.LocalViewU:=nil;

      _BottomLineE.Draw(Painter, DrawSelected);
      _VLine0E.Draw(Painter, DrawSelected);
      _VLine1E.Draw(Painter, DrawSelected);
      if Painter.CheckVisiblePoint(1, FX0, FY0, Z0) and
         Painter.CheckVisiblePoint(1, FX1, FY1, Z1) then
        _TopLineE.Draw(Painter, DrawSelected);
    end;
  end;

  Painter.LocalViewU:=nil;

  if FPrev<>nil then begin // рисование поперечных перегородок
    PrevLayer:=FPrev as IBoundaryLayer;
    if FDrawJoint0 then begin
       _TopC0.X:=PrevLayer.X0;
       _TopC0.Y:=PrevLayer.Y0;
       _TopC0.Z:=Z0;
       _VLine0E.Parent:=LayerE;
       _VLine0E.Draw(Painter, DrawSelected);
    end;
    if FDrawJoint1 then begin
       _TopC1.X:=PrevLayer.X1;
       _TopC1.Y:=PrevLayer.Y1;
       _TopC1.Z:=Z1;
       _VLine1E.Parent:=LayerE;
       _VLine1E.Draw(Painter, DrawSelected);
    end;
  end;

  _BottomLineE.Parent:=nil;
  _TopLineE.Parent:=nil;
  _VLine0E.Parent:=nil;
  _VLine1E.Parent:=nil;

  Document.State:=OldState;

  Painter.LocalViewU:=nil;
  except
    DataModel.HandleError('Error in Draw. BoundaryLayer.ParentID=');
  end;
end;

procedure TBoundaryLayer.MakePersistant(const SubStateE:IDMElement);
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
  for j:=0 to FSafeguardElements.Count-1 do begin     // 2-й этап модернизации  (рекомендация)
    SafeguardElementE:=FSafeguardElements.Item[j];
    if SafeguardElementE.Presence=2 then begin
      DMOperationManager.AddElement(SafeguardElementE,
        SafeguardElementStates, '', ltOneToMany, Unk, True);
      SafeguardElementStateE:=Unk as IDMElement;
      SafeguardElementStateE.Ref:=SubStateE;
      SafeguardElementE.Presence:=1;                 // 1-й этап модернизации   (запомненное состояние)
    end;
  end;
end;

procedure TBoundaryLayer.UpdateDependingElements(
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


function TBoundaryLayer.Get_DistanceFromPrev: Double;
begin
  Result:=FDistanceFromPrev
end;

procedure TBoundaryLayer.CalcPathNoDetectionProbability(
  var PathNoDetectionProbability: double;
  out NoDetP, NoFailureP:double;
  out NoEvidence:WordBool; AddDelay:double);
begin
end;

procedure TBoundaryLayer.CalcPathSoundResistance(var PathSoundResistance,
  FuncSoundResistance: double);
begin
end;

procedure TBoundaryLayer.CalcPathSuccessProbability(
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability: double;
                      var DelayTimeSum, DelayTimeDispersionSum:double;
                          AddDelay:double);
var
  FacilityModelS:IFMState;
  StealthT:double;
  OldPathStage, FastPathStage:integer;
  dT, dTDisp, DelayTimeSumOuter, DelayTimeDispersionSumOuter,
  DelayTimeSumInner, DelayTimeDispersionSumInner,
  NoDetP, NoFailureP:double;
  NoEvidence:WordBool;
  Position:integer;
  DelayTimeSumCent, DelayTimeDispersionSumCent,
  ReactionTime, ReactionTimeDispersion,
  dT2, dTDisp2, StealthTDisp, TT:double;
begin
  FacilityModelS:=DataModel as IFMState;
  ReactionTime:=FacilityModelS.CurrentReactionTime;
  ReactionTimeDispersion:=FacilityModelS.CurrentReactionTimeDispersion;

  if ImplicitCalcNeeded then begin
    OldPathStage:=FacilityModelS.CurrentPathStage;
    if OldPathStage=wpsStealthEntry then
      FastPathStage:=wpsFastEntry
    else
    if OldPathStage=wpsStealthExit then
      FastPathStage:=wpsFastExit
    else
      FastPathStage:=OldPathStage;

    FacilityModelS.CurrentPathStage:=FastPathStage;
    CalcDelayTime(dT, dTDisp, AddDelay);
    FacilityModelS.CurrentPathStage:=OldPathStage;

    CalcNoDetectionProbability(NoDetP, NoFailureP,
                              NoEvidence, StealthT, StealthTDisp,
                              Position, AddDelay);
  end else begin
    dT:=FDelayTimeFast;
    dTDisp:=FDelayTimeDispFast;
    StealthT:=FDelayTimeStealth;
    StealthTDisp:=FDelayTimeDispStealth;
    NoDetP:=1-FDetectionProbabilityStealth;

    TT:=FDelayTimeStealth/FObservationPeriod;
    NoDetP:=NoDetP*exp(-TT);

    NoFailureP:=1-FFailurePStealth;
    Position:=FPositionStealth;
  end;

  DelayTimeSumInner:=DelayTimeSum;
  DelayTimeDispersionSumInner:=DelayTimeDispersionSum;
  DelayTimeSumOuter:=DelayTimeSum+dT;
  DelayTimeDispersionSumOuter:=DelayTimeDispersionSum+dTDisp;

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

  SuccessProbability:=NoDetP*SuccessProbability+
             (NoFailureP-NoDetP)*AdversaryVictoryProbability;
  DelayTimeSum:=DelayTimeSumOuter;
  DelayTimeDispersionSum:=DelayTimeDispersionSumOuter;

  if Position<>dpOuter then
    AdversaryVictoryProbability:=GetAdversaryVictoryProbability(
                  DelayTimeSumOuter, DelayTimeDispersionSumOuter,
                  ReactionTime, ReactionTimeDispersion);
end;

procedure TBoundaryLayer.DoCalcPathSuccessProbability(const TacticU:IUnknown;
                          ObservationPeriod:double;
                      var SuccessProbability:double;
                      out AdversaryVictoryProbability,
                          StealthT: double;
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner:double;
                          AddDelay:double);
begin
end;

function TBoundaryLayer.Get_Neighbour0: IDMElement;
begin
  Result:=FNeighbour0
end;

function TBoundaryLayer.Get_Neighbour1: IDMElement;
begin
  Result:=FNeighbour1
end;

function TBoundaryLayer.Get_Prev: IDMElement;
begin
  Result:=FPrev
end;

function TBoundaryLayer.Get_X0: Double;
begin
  Result:=FX0
end;

function TBoundaryLayer.Get_X1: Double;
begin
  Result:=FX1
end;

function TBoundaryLayer.Get_Y0: Double;
begin
  Result:=FY0
end;

function TBoundaryLayer.Get_Y1: Double;
begin
  Result:=FY1
end;

procedure TBoundaryLayer.Set_Neighbour0(const Value: IDMElement);
begin
  FNeighbour0:=Value
end;

procedure TBoundaryLayer.Set_Neighbour1(const Value: IDMElement);
begin
  FNeighbour1:=Value
end;

procedure TBoundaryLayer.Set_Prev(const Value: IDMElement);
begin
  FPrev:=Value
end;

procedure TBoundaryLayer.Set_X0(Value: Double);
begin
  FX0:=Value
end;

procedure TBoundaryLayer.Set_X1(Value: Double);
begin
  FX1:=Value
end;

procedure TBoundaryLayer.Set_Y0(Value: Double);
begin
  FY0:=Value
end;

procedure TBoundaryLayer.Set_Y1(Value: Double);
begin
  FY1:=Value
end;

procedure TBoundaryLayer.AfterLoading2;
begin
  inherited;
end;

procedure TBoundaryLayer.Loaded;
begin
  inherited;
  if Parent=nil then Exit;
  Parent.UpdateCoords;
end;

procedure TBoundaryLayer.Set_Parent(const Value: IDMElement);
var
  OldParent:IDMElement;
  DMOperationManager:IDMOperationManager;
  SMDocument:ISMDocument;
  RefPathElement:IRefPathElement;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IRefPathElement,RefPathElement)=0)  then begin
    Set_Parent(Value.Ref);
    Exit;
  end;
  OldParent:=Parent;
  DMOperationManager:=DataModel.Document as  IDMOperationManager;
  if (OldParent<>nil) and
     (Value=nil) then begin
    SMDocument:=DMOperationManager as  ISMDocument;
    Draw(SMDocument.PainterU, -1);
  end;

  inherited;

  if Value<>nil then begin
    if Value.SpatialElement=nil then Exit;
    if DataModel.IsLoading then Exit;
    DMOperationManager.UpdateCoords(Value);
  end else
  if OldParent<>nil then
    DMOperationManager.UpdateCoords(OldParent);
end;

procedure TBoundaryLayer.Set_Selected(Value: WordBool);
var
  SMDocument:ISMDocument;
  PainterU:IUnknown;
begin
  inherited;
  if DataModel=nil then Exit;
  SMDocument:=DataModel.Document as  ISMDocument;
  PainterU:=SMDocument.PainterU;
  if Value then
    Draw(PainterU, 1)
  else
    Draw(PainterU, 0)
end;

procedure TBoundaryLayer.Reset(const BaseStateE:IDMElement);
begin
  FBaseState:=pointer(BaseStateE);
end;

function TBoundaryLayer.AcceptableTactic( const TacticU:IUnknown): WordBool;
var
  j, CurrentPathStage:integer;
  Tactic:ITactic;
  SafeguardElementE, WarriorGroupE:IDMElement;
  SafeguardElement:ISafeguardElement;
  FacilityModelS:IFMState;
  WarriorGroup:IWarriorGroup;
begin
  Tactic:=TacticU as ITactic;
  FacilityModelS:=DataModel as IFMState;
  CurrentPathStage:=FacilityModelS.CurrentPathStage;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  WarriorGroup:=WarriorGroupE as IWarriorGroup;

  Result:=False;
  
  if not(((Tactic.EntryTactic and
      ((CurrentPathStage=wpsStealthEntry) or (CurrentPathStage=wpsFastEntry))) or
          (Tactic.ExitTactic and
      ((CurrentPathStage=wpsStealthExit) or (CurrentPathStage=wpsFastExit))))) then
    Exit;

  if (WarriorGroupE.ClassID=_AdversaryGroup) then begin
    if (WarriorGroup.Accesses.Count=0) and
        not Tactic.OutsiderTactic then  Exit;
    if (WarriorGroup.Accesses.Count>0) and
      not Tactic.InsiderTactic then Exit;
  end else
  if (WarriorGroupE.ClassID=_GuardGroup) then begin
    if not Tactic.GuardTactic then Exit;
    if Tactic.DeceitTactic then Exit;
  end;

  Result:=True;
  
  if not Tactic.DeceitTactic then Exit;
  j:=0;
  while j<FSafeguardElements.Count do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    SafeguardElement:=SafeguardElementE as ISafeguardElement;
    if (SafeguardElementE.ClassID=_AccessControl) and
       SafeguardElement.InWorkingState then
      Exit
    else
      inc(j)
  end;
  Result:=False;
end;

procedure TBoundaryLayer.Set_Ref(const Value: IDMElement);
var
  BoundaryLayerType:IBoundaryLayerType;
  DefaultHeight:double;
begin
  inherited;

  if Value=nil then Exit;
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if not DataModel.IsChanging then Exit;
  if ((DataModel.Document as IDMDocument).State and dmfRollbacking)<>0 then Exit;

  try
  BoundaryLayerType:=Value as IBoundaryLayerType;
  DefaultHeight:=BoundaryLayerType.DefaultHeight;
  FHeight0:=DefaultHeight;
  FHeight1:=FHeight0;
  except
    raise
  end;  
end;

procedure TBoundaryLayer.UpdateDependingElementBestMethods(
  const DependingSafeguardElementList, BestOvercomeMethodList: TList);
var
  j:integer;
  SafeguardElementE, OvercomeMethodE:IDMElement;
  SafeguardElement:ISafeguardElement;
begin
  for j:=0 to DependingSafeguardElementList.Count-1 do begin
    SafeguardElementE:=IDMElement(DependingSafeguardElementList[j]);
    OvercomeMethodE:=IDMElement(BestOvercomeMethodList[j]);
    SafeguardElement:=SafeguardElementE as ISafeguardElement;
    SafeguardElement.BestOvercomeMethod:=OvercomeMethodE;
  end;
end;

function TBoundaryLayer.Get_Disabled: WordBool;
begin
  Result:=False
end;


function TBoundaryLayer.DoOperation(ColIndex, Index: Integer; var Param1, Param2,
  Param3: OleVariant): WordBool;
var
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  Server:IDataModelServer;
  SubBoundaries, SubBoundaryKinds:IDMCollection;
  V:Variant;
  DataModelE, BoundaryKindE:IDMElement;
  BoundaryLayerType:IBoundaryLayerType;
  Unk, ElementU:IUnknown;
  j:integer;
  S:WideString;
begin
  Result:=False;
  if ColIndex<>-1 then Exit;
  case Index of
  1:begin
      Document:=DataModel.Document as IDMDocument;
      DMOperationManager:=Document as IDMOperationManager;
      Server:=Document.Server;
      BoundaryLayerType:=Ref as IBoundaryLayerType;
      SubBoundaryKinds:=BoundaryLayerType.SubBoundaryKinds;
      if SubBoundaryKinds.Count=0 then Exit;

      Server.EventData3:=-1;
      Server.EventData2:=' ';
      Server.CallRefDialog(nil, SubBoundaryKinds, '', True);
      if Server.EventData3=-1 then Exit;
      V:=Server.EventData1;
      if VarIsNull(V) then  Exit;
      S:=Server.EventData2;
      if S='' then Exit;
      Unk:=V;
      BoundaryKindE:=Unk as IDMElement;

      DataModelE:=DataModel as IDMElement;
      SubBoundaries:=DataModelE.Collection[_SubBoundary];
      DMOperationManager.AddElementRef(Self as IDMElement,
           SubBoundaries, S, BoundaryKindE, ltOneToMany, ElementU, True);
      j:=FSubBoundaries.Count-1;
      Server.DocumentOperation(ElementU, nil, leoAdd, j);
    end;
  else
    Exit;
  end;
  Result:=True;
end;

function TBoundaryLayer.GetOperationName(ColIndex, Index: Integer): WideString;
begin
  if ColIndex=-1 then begin
    case Index of
    1:Result:='Добавить подрубеж...';
    else
      Result:='';
    end;
  end else
    Result:='';
end;

function TBoundaryLayer.Get_SubBoundaries: IDMCollection;
begin
  Result:=FSubBoundaries
end;

function TBoundaryLayer.GetCollectionForChild(
  const aChild: IDMElement): IDMCollection;
begin
  case aChild.ClassID of
  _SubBoundary:
    Result:=FSubBoundaries
  else
    Result:=inherited GetCollectionForChild(aChild)
  end
end;

procedure TBoundaryLayer.ClearCash(ClearElements:WordBool);
var
  j:integer;
  SafeguardElement:ISafeguardElement;
begin
  FDelayTimeFast:=-1; // для Guard
  FParamFlags:=FParamFlags and not pfParamsCalculated;

  if not ClearElements then Exit;
  
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElement:=FSafeguardElements.Item[j] as ISafeguardElement;
    SafeguardElement.ClearCash;
  end;
end;

function TBoundaryLayer.Get_Construction: integer;
begin
  Result:=FConstruction
end;

procedure TBoundaryLayer.Set_Height0(Value: double);
begin
  FHeight0:=Value
end;

procedure TBoundaryLayer.Set_Height1(Value: double);
begin
  FHeight1:=Value
end;


function TBoundaryLayer.GetShortCut(ColIndex, Index: Integer): WideString;
begin
  Result:='';
end;

procedure TBoundaryLayer.AfterCopyFrom2;
var
  j:integer;
  SafeguardElementE:IDMElement;
begin
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    SafeguardElementE.AfterCopyFrom2;
  end;
end;

procedure TBoundaryLayer.BuildReport(ReportLevel, TabCount, Mode: Integer;
  const Report: IDMText);
begin
  inherited;
end;

function TBoundaryLayer.Get_ReportModeCount: integer;
begin
  Result:=4
end;

function TBoundaryLayer.Get_ReportModeName(Index: integer): WideString;
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

function TBoundaryLayer.Get_AlarmGroupArrivalTime: Double;
var
  ParentWayElement:IWayElement;
begin
  ParentWayElement:=Parent as IWayElement;
  Result:=ParentWayElement.AlarmGroupArrivalTime;
end;

function TBoundaryLayer.Get_AlarmGroupArrivalTimeDev: Double;
var
  ParentWayElement:IWayElement;
begin
  ParentWayElement:=Parent as IWayElement;
  Result:=ParentWayElement.AlarmGroupArrivalTimeDev;
end;

function TBoundaryLayer.Get_AlarmGroupDelayTime: Double;
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

function TBoundaryLayer.Get_BlockGroupArrivalTime: Double;
var
  ParentWayElement:IWayElement;
begin
  ParentWayElement:=Parent as IWayElement;
  Result:=ParentWayElement.BlockGroupArrivalTime;
end;

function TBoundaryLayer.Get_BlockGroupArrivalTimeDev: Double;
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

function TBoundaryLayer.Get_BlockGroupStart: Integer;
var
  ParentWayElement:IWayElement;
begin
  ParentWayElement:=Parent as IWayElement;
  Result:=ParentWayElement.BlockGroupStart;
end;

function TBoundaryLayer.Get_DelayTimeDev: Double;
var
  FacilityModel:IFacilityModel;
begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModel.DelayTimeDispersionRatio
end;

function TBoundaryLayer.Get_DelayTimeFast: Double;
begin
  Result:=FDelayTimeFast;
end;

function TBoundaryLayer.Get_DelayTimeStealth: Double;
begin
  Result:=FDelayTimeStealth;
end;

function TBoundaryLayer.Get_DetectionProbabilityFast: Double;
begin
  Result:=FDetectionProbabilityFast;
end;

function TBoundaryLayer.Get_DetectionProbabilityStealth: Double;
begin
  Result:=FDetectionProbabilityStealth;
end;

function TBoundaryLayer.Get_EvidenceFast: WordBool;
begin
  Result:=FEvidencePFast
end;

function TBoundaryLayer.Get_EvidenceStealth: WordBool;
begin
  Result:=FEvidencePStealth
end;

function TBoundaryLayer.Get_FailureProbabilityFast: Double;
begin
  Result:=FFailurePFast;
end;

function TBoundaryLayer.Get_FailureProbabilityStealth: Double;
begin
  Result:=FFailurePStealth;
end;

function TBoundaryLayer.Get_PointsToTarget: WordBool;
var
  ParentWayElement:IWayElement;
begin
  ParentWayElement:=Parent as IWayElement;
  Result:=ParentWayElement.PointsToTarget;
end;

procedure TBoundaryLayer.Set_PointsToTarget(Value: WordBool);
begin
end;


procedure TBoundaryLayer.CalcParamFlags;
var
  j:integer;
  SafeguardElementE:IDMElement;
  Barrier:IBarrier;
begin
  FParamFlags:=FParamFlags or pfTransparent or pfNoFieldBarrier and not pfFragile;
  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    if SafeguardElementE.ClassID=_Barrier then begin
      FParamFlags:=FParamFlags and not pfNoFieldBarrier;
      Barrier:=SafeguardElementE as IBarrier;
      if not Barrier.IsTransparent then
        FParamFlags:=FParamFlags and not pfTransparent;
      if (SafeguardElementE.Ref as IBarrierKind).IsFragile then
        FParamFlags:=FParamFlags or pfFragile;
    end;
  end;
end;

function TBoundaryLayer.Get_ObservationPeriod: double;
begin
  Result:=FObservationPeriod
end;

function TBoundaryLayer.CalcObservationPeriod:double;
var
  Boundary:IBoundary;
  R, aObservationPeriod:double;
  ObserverE:IDMElement;
  j:integer;
  Observer:IObserver;
  Zone:IZone;
begin
  Boundary:=Parent as IBoundary;
  R:=1/Week;
  if Get_Visible0 then begin
    Zone:=Boundary.Zone0 as IZone;
    if Zone<>nil then
      case Zone.PersonalPresence of
      1: R:=R+1/3600;  //  1 раз в час  (иногда)
      2: R:=R+1/600;   //  1 раз в 10 мин  (постоянно)
      end;
  end;
  if Get_Visible1 then begin
    Zone:=Boundary.Zone1 as IZone;
    if Zone<>nil then
      case Zone.PersonalPresence of
      1: R:=R+1/3600;  //  1 раз в час  (иногда)
      2: R:=R+1/600;   //  1 раз в 10 мин  (постоянно)
      end;
  end;

  for j:=0 to Boundary.Observers.Count-1 do begin
    ObserverE:=Boundary.Observers.Item[j];
    Observer:=ObserverE as IObserver;
    if ((Observer.Side=0) and Get_Visible0) or
       ((Observer.Side=1) and Get_Visible1) or
        (Observer.Side=2) then begin
      aObservationPeriod:=Observer.ObservationPeriod;
      if (aObservationPeriod>0) then
        R:=R+1/aObservationPeriod
    end;
  end;
  if R<>0 then
    result:=1/R
  else
    result:=InfinitValue;
end;

procedure TBoundaryLayer.DoCalcParams(const TacticU:IUnknown;
                          AddDelay:double;
                      out dTFast, dTDispFast, NoDetPFast, NoDetP1Fast,
                          NoFailurePFast:double;
                      out NoEvidenceFast:WordBool;
                      out SingleDetPFast:double;
                      out dTStealth, dTDispStealth, NoDetPStealth, NoDetP1Stealth,
                          NoFailurePStealth:double;
                      out NoEvidenceStealth:WordBool;
                      out SingleDetPStealth:double;
                      out PositionFast, PositionStealth:integer);
var
  SafeguardElementE, SafeguardElementKindE, SafeguardElementTypeE:IDMElement;
  SafeguardElementType:ISafeguardElementType;
  SafeguardElement:ISafeguardElement;
  Tactic:ITactic;
  aNoDetPFast, adTFast, adTDispFast, aNoDetP1Fast,
  aNoDetPStealth, adTStealth, adTDispStealth, aNoDetP1Stealth:double;
  j:integer;
  OvercomeMethodFast, OvercomeMethodStealth:IOvercomeMethod;
  OvercomeMethodFastE, OvercomeMethodStealthE:IDMElement;
  DelayTimeDispersionRatio, PSFast, PSStealth:double;
  FacilityModel:IFacilityModel;
begin
  Tactic:=TacticU as ITactic;
  if Tactic.SafeguardClasses.Count=0 then begin
    dTFast:=InfinitValue/1000;
    dTDispFast:=InfinitValue;
    NoDetPFast:=0;
    NoFailurePFast:=0;
    NoEvidenceFast:=False;
    SingleDetPFast:=0;
    PositionFast:=2;

    dTStealth:=InfinitValue/1000;
    dTDispStealth:=InfinitValue;
    NoDetPStealth:=0;
    NoFailurePStealth:=0;
    NoEvidenceStealth:=False;
    SingleDetPStealth:=0;
    PositionStealth:=2;
    Exit;
  end;

  dTFast:=0;
  dTDispFast:=0;
  NoDetPFast:=1;
  NoDetP1Fast:=1;
  SingleDetPFast:=1;
  NoFailurePFast:=1;
  NoEvidenceFast:=True;
  PositionFast:=2;

  dTStealth:=0;
  dTDispStealth:=0;
  NoDetPStealth:=1;
  NoDetP1Stealth:=1;
  SingleDetPStealth:=1;
  NoFailurePStealth:=1;
  NoEvidenceStealth:=True;
  PositionStealth:=2;

  FacilityModel:=DataModel as IFacilityModel;
  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  if Get_UserDefinedDetectionProbability then begin
    NoDetPFast:=1-Get_DetectionProbability;
    NoDetPStealth:=NoDetPFast;
    SingleDetPStealth:=NoDetPStealth;
  end;
  if Get_UserDefinedDelayTime then begin
    dTFast:=Get_DelayTime;
    dTDispFast:=sqr(DelayTimeDispersionRatio*dTFast);
    dTStealth:=dTFast;
    dTDispStealth:=dTDispFast;
    if Get_UserDefinedDetectionProbability then
      Exit;
  end;

  dTFast:=abs(FDistanceFromPrev)/PedestrialVelocity+AddDelay;
  dTDispFast:=sqr(DelayTimeDispersionRatio*dTFast);
  dTStealth:=dTFast;
  dTDispStealth:=dTDispFast;
  PSFast:=0;
  PSStealth:=0;

  for j:=0 to FSafeguardElements.Count-1 do begin
    SafeguardElementE:=FSafeguardElements.Item[j];
    SafeguardElementKindE:=SafeguardElementE.Ref;
    if SafeguardElementKindE<>nil then begin
      SafeguardElementTypeE:=SafeguardElementKindE.Parent;
      SafeguardElementType:=SafeguardElementTypeE as ISafeguardElementType;
      if Tactic.DependsOn(SafeguardElementTypeE) then begin
        SafeguardElement:=SafeguardElementE as ISafeguardElement;
        SafeguardElement.CalcParams(TacticU, FObservationPeriod,
                    adTFast, adTDispFast, aNoDetPFast, aNoDetP1Fast,
                    adTStealth, adTDispStealth, aNoDetPStealth, aNoDetP1Stealth,
                    OvercomeMethodFastE, OvercomeMethodStealthE);
        dTFast:=dTFast+adTFast;
        dTDispFast:=dTDispFast+adTDispFast;
        if PositionFast>SafeguardElement.DetectionPosition then
          PositionFast:=SafeguardElement.DetectionPosition;
        NoDetPFast:=NoDetPFast*aNoDetPFast;
        NoDetP1Fast:=NoDetP1Fast*aNoDetP1Fast;
        if OvercomeMethodFastE<>nil then begin
          OvercomeMethodFast:=OvercomeMethodFastE as IOvercomeMethod;
          if (aNoDetPFast<>1) and
            OvercomeMethodFast.AssessRequired then
            PSFast:=PSFast+(1-aNoDetP1Fast)/aNoDetP1Fast;
          if (aNoDetPFast<>1) and
            OvercomeMethodFast.Failure then
            NoFailurePFast:=NoFailurePFast*aNoDetPFast;
          NoEvidenceFast:=NoEvidenceFast and not OvercomeMethodFast.Evidence;
        end;

        dTStealth:=dTStealth+adTStealth;
        dTDispStealth:=dTDispStealth+adTDispStealth;
        if PositionStealth>SafeguardElement.DetectionPosition then
          PositionStealth:=SafeguardElement.DetectionPosition;
        NoDetPStealth:=NoDetPStealth*aNoDetPStealth;
        NoDetP1Stealth:=NoDetP1Stealth*aNoDetP1Stealth;
        if OvercomeMethodStealthE<>nil then begin
          OvercomeMethodStealth:=OvercomeMethodStealthE as IOvercomeMethod;
          if (aNoDetPStealth<>1) and
            OvercomeMethodStealth.AssessRequired then
            PSStealth:=PSStealth+(1-aNoDetP1Stealth)/aNoDetP1Stealth;
          if (aNoDetPStealth<>1) and
            OvercomeMethodStealth.Failure then
            NoFailurePStealth:=NoFailurePStealth*aNoDetPStealth;
          NoEvidenceStealth:=NoEvidenceStealth and not OvercomeMethodStealth.Evidence;
        end;

      end; // if Tactic.DependsOn(SafeguardElementTypeE)
    end; // if SafeguardElementKindE<>nil
  end;  // for j:=0 to FSafeguardElements.Count-1

  SingleDetPFast:=PSFast*NoDetPFast;
  SingleDetPStealth:=PSStealth*NoDetPStealth;

  if dTFast>InfinitValue/1000 then begin
    dTFast:=InfinitValue/1000;
    NoDetPFast:=0;
  end;
  if dTStealth>InfinitValue/1000 then begin
    dTStealth:=InfinitValue/1000;
    NoDetPStealth:=0;
  end;
end;

procedure TBoundaryLayer.CalcParams(AddDelay: double);
var
  PathStage:integer;
  WarriorGroupE:IDMElement;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  DelayTimeDispersionRatio, PassVelocity,
  PassTime, PassTimeDispersion:double;
  Boundary:IBoundary;

  DetPStealth:double;
  j:integer;
  TacticE, SubBoundaryE:IDMElement;
  SubBoundary:ISubBoundary;
  BoundaryLayerType:IBoundaryLayerType;
  dTFast, dTDispFast, NoDetPFast, NoDetP1Fast,
  NoFailurePFast, SingleDetPFast,
  dTStealth, dTDispStealth, NoDetPStealth, NoDetP1Stealth,
  NoFailurePStealth, SingleDetPStealth:double;
  NoEvidenceFast, NoEvidenceStealth:WordBool;
  PositionFast, PositionStealth:integer;

begin
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;
  Boundary:=Parent as IBoundary;

  PassVelocity:=Boundary.GetPassVelocity;
  PassTime:=abs(FDistanceFromPrev)/PassVelocity;
  PassTimeDispersion:=sqr(DelayTimeDispersionRatio*PassTime);

  FDelayTimeFast:=0;
  FDelayTimeDispFast:=0;
  FDetectionProbabilityFast:=0;
  FEvidencePFast:=False;
  FFailurePFast:=0;
  FTacticFastE:=nil;

  FDelayTimeStealth:=0;
  FDelayTimeDispStealth:=0;
  FDetectionProbabilityStealth:=0;
  FEvidencePStealth:=False;
  FFailurePStealth:=0;
  FTacticStealthE:=nil;

  if Get_UserDefinedDelayTime  then begin
    FDelayTimeFast:=PassTime+Get_DelayTime+AddDelay;
    FDelayTimeDispFast:=PassTimeDispersion+sqr(DelayTimeDispersionRatio*FDelayTimeFast);
    FDelayTimeStealth:=FDelayTimeFast;
    FDelayTimeStealth:=FDelayTimeDispFast;
  end;

  if Get_UserDefinedDetectionProbability  then begin
    FDetectionProbability:=1-Get_DetectionProbability;
    if Get_UserDefinedDelayTime  then
      Exit;
  end;

  PathStage:=FacilityModelS.CurrentPathStage;

  FObservationPeriod:=CalcObservationPeriod;

  FDelayTimeFast:=InfinitValue/1000;
  FDetectionProbabilityFast:=1;
  FDelayTimeStealth:=FDelayTimeFast;
  FDetectionProbabilityStealth:=FDetectionProbabilityFast;

  DetPStealth:=1;

  DependingSafeguardElementList.Clear;
  BestOvercomeMethodList.Clear;
  BoundaryLayerType:=Ref as IBoundaryLayerType;
  
  for j:=0 to BoundaryLayerType.Tactics.Count-1 do begin
    TacticE:=BoundaryLayerType.Tactics.Item[j];
    if AcceptableTactic(TacticE) then begin

      theDependingSafeguardElementList.Clear;
      theBestOvercomeMethodList.Clear;

      DoCalcParams(TacticE, AddDelay,
                   dTFast, dTDispFast, NoDetPFast, NoDetP1Fast,
                   NoFailurePFast, NoEvidenceFast, SingleDetPFast,
                   dTStealth, dTDispStealth, NoDetPStealth, NoDetP1Stealth,
                   NoFailurePStealth, NoEvidenceStealth, SingleDetPStealth,
                   PositionFast, PositionStealth);

      if FDelayTimeFast>dTFast then begin
        FDelayTimeFast:=dTFast;
        FDelayTimeDispFast:=dTDispFast;
        FDetectionProbabilityFast:=1-NoDetP1Fast;
        FEvidencePFast:=not NoEvidenceFast;
        FFailurePFast:=1-NoFailurePFast;
        FSingleDetectionProbabilityFast:=SingleDetPFast;
        FTacticFastE:=TacticE;
        FPositionFast:=PositionFast;
      end;

      if DetPStealth>1-NoDetPStealth then begin     // ищем самую скрытную тактику с учетом наблюдателей
        DetPStealth:=1-NoDetPStealth;
        FDelayTimeStealth:=dTStealth;
        FDelayTimeDispStealth:=dTDispStealth;
        FDetectionProbabilityStealth:=1-NoDetP1Stealth; // запоминаем обнаружение без учета наблюдателей
        FEvidencePStealth:=not NoEvidenceStealth;
        FFailurePStealth:=1-NoFailurePStealth;
        FSingleDetectionProbabilityStealth:=SingleDetPStealth;
        FTacticStealthE:=TacticE;
        FPositionStealth:=PositionStealth;

        if PathStage=wpsStealthEntry then
          UpdateDependingElements(
            DependingSafeguardElementList,
            theDependingSafeguardElementList,
            BestOvercomeMethodList,
            theBestOvercomeMethodList);
      end;
    end;
  end;

  for j:=0 to FSubBoundaries.Count-1 do begin
    SubBoundaryE:=FSubBoundaries.Item[j];
    SubBoundary:=SubBoundaryE as ISubBoundary;
    SubBoundary.CalcParams1(AddDelay, FObservationPeriod,
                   dTFast, dTDispFast, NoDetPFast, NoDetP1Fast,
                   NoFailurePFast, NoEvidenceFast, SingleDetPFast,
                   dTStealth, dTDispStealth, NoDetPStealth, NoDetP1Stealth,
                   NoFailurePStealth, NoEvidenceStealth, SingleDetPStealth,
                   PositionFast, PositionStealth);
    if FDelayTimeFast>dTFast then begin
      FDelayTimeFast:=dTFast;
      FDelayTimeDispFast:=dTDispFast;
      FDetectionProbabilityFast:=1-NoDetP1Fast;
      FEvidencePFast:=not NoEvidenceFast;
      FFailurePFast:=1-NoFailurePFast;
      FSingleDetectionProbabilityFast:=SingleDetPFast;
      FTacticFastE:=SubBoundaryE;  // в качастве тактики запоминаем сам подрубеж
      FPositionFast:=PositionFast;
    end;
    if DetPStealth>1-NoDetPStealth then begin     // ищем самую скрытную тактику с учетом наблюдателей
      DetPStealth:=1-NoDetPStealth;
      FDelayTimeStealth:=dTStealth;
      FDelayTimeDispStealth:=dTDispStealth;
      FDetectionProbabilityStealth:=1-NoDetP1Stealth; // запоминаем обнаружение без учета наблюдателей
      FEvidencePStealth:=not NoEvidenceStealth;
      FFailurePStealth:=1-NoFailurePStealth;
      FSingleDetectionProbabilityStealth:=SingleDetPStealth;
      FTacticStealthE:=SubBoundaryE;  // в качастве тактики запоминаем сам подрубеж
      FPositionStealth:=PositionStealth;

      DependingSafeguardElementList.Clear;  // На основном участке средства охраны
      BestOvercomeMethodList.Clear;         // не выводятся из строя
    end;
  end;

  if PathStage=wpsFastEntry then
    UpdateDependingElementBestMethods
             (DependingSafeguardElementList,
              BestOvercomeMethodList);

  FParamFlags:=FParamFlags or pfParamsCalculated;              
end;

function TBoundaryLayer.Get_SingleDetectionProbabilityFast: Double;
begin
  Result:=FSingleDetectionProbabilityFast;
end;

function TBoundaryLayer.Get_SingleDetectionProbabilityStealth: Double;
begin
  Result:=FSingleDetectionProbabilityStealth;
end;

procedure TBoundaryLayer.CalcGuardDelayTime(out DelayTime, DelayTimeDispersion: double;
                                            out BestTacticE:IDMElement;
                                                AddDelay: double);
var
  BoundaryLayerType:IBoundaryLayerType;
  TacticE:IDMElement;
  j:integer;
begin
  if FDelayTimeFast=-1 then begin  // если кэш очищен
    BoundaryLayerType:=Ref as IBoundaryLayerType;
    j:=0;
    while j<BoundaryLayerType.Tactics.Count do begin
      TacticE:=BoundaryLayerType.Tactics.Item[j];
      if AcceptableTactic(TacticE) then
        Break
      else
        inc(j)
    end;
    if j<BoundaryLayerType.Tactics.Count then begin
      DoCalcDelayTime(TacticE, DelayTime, DelayTimeDispersion, AddDelay);
      BestTacticE:=TacticE;
    end else begin
      DelayTime:=InfinitValue;
      DelayTimeDispersion:=0;
      BestTacticE:=nil;
    end;
    FDelayTimeFast:=DelayTime;
    FDelayTimeDispFast:=DelayTimeDispersion;
    FTacticFastE:=BestTacticE;
  end else begin
    DelayTime:=FDelayTimeFast;
    DelayTimeDispersion:=FDelayTimeDispFast;
    BestTacticE:=FTacticFastE
  end;
end;

function TBoundaryLayer.Get_TacticFastU: IUnknown;
begin
  Result:=FTacticFastE
end;

function TBoundaryLayer.Get_TacticStealthU: IUnknown;
begin
  Result:=FTacticStealthE
end;

function TBoundaryLayer.Get_Visible0: WordBool;
begin
  Result:=(FParamFlags and pfVisible0)<>0
end;

function TBoundaryLayer.Get_Visible1: WordBool;
begin
  Result:=(FParamFlags and pfVisible1)<>0
end;

procedure TBoundaryLayer.Set_Visible0(Value: WordBool);
begin
  if Value then
    FParamFlags:=FParamFlags or pfVisible0
  else
    FParamFlags:=FParamFlags and not pfVisible0
end;

procedure TBoundaryLayer.Set_Visible1(Value: WordBool);
begin
  if Value then
    FParamFlags:=FParamFlags or pfVisible1
  else
    FParamFlags:=FParamFlags and not pfVisible1
end;

function TBoundaryLayer.ImplicitCalcNeeded: boolean;
var
  FacilityModelS:IFMState;
  FacilityStateE:IDMElement;
begin
  FacilityModelS:=DataModel as IFMState;
  FacilityStateE:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  Result:=(((FParamFlags and pfParamsChanged)=0) and (FBaseState<>pointer(FacilityStateE)))
end;

function TBoundaryLayer.RecalcObservationPeriod: double;
var
  Boundary:IBoundary;
  R, aObservationPeriod:double;
  ObserverE:IDMElement;
  j:integer;
  Observer:IObserver;
  SafeguardElement:ISafeguardElement;
  ObservationElement:IObservationElement;
begin
  Boundary:=Parent as IBoundary;
  R:=1/Week;
  for j:=0 to Boundary.Observers.Count-1 do begin
    ObserverE:=Boundary.Observers.Item[j];
    if ObserverE.Ref.QueryInterface(IObservationElement, ObservationElement)=0 then begin
      Observer:=ObserverE as IObserver;
      if (((Observer.Side=0) and Get_Visible0) or
          ((Observer.Side=1) and Get_Visible1) or
           (Observer.Side=2)) and                  // здесь допущение - ранее сделаный для основного состояния
         (Observer.ObservationPeriod>0) then begin // выбор "нужно ли нейтрализовать наблюдателя"
                                                   // используется и для возмущенных состояний
        SafeguardElement:=ObservationElement as ISafeguardElement;
        if SafeguardElement.InWorkingState then begin
          aObservationPeriod:=ObservationElement.GetObservationPeriod(0);
          R:=R+1/aObservationPeriod
        end;
      end;
    end;
  end;
  if R<>0 then
    result:=1/R
  else
    result:=InfinitValue;
end;

{ TBoundaryLayers }

class function TBoundaryLayers.GetElementClass: TDMElementClass;
begin
  Result:=TBoundaryLayer;
end;

function TBoundaryLayers.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsBoundaryLayer
  else
    Result:=rsBoundaryLayers;
end;

class function TBoundaryLayers.GetElementGUID: TGUID;
begin
  Result:=IID_IBoundaryLayer;
end;

function TBoundaryLayers.Get_ClassAlias2(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsBoundaryLayer2
  else
    Result:=rsBoundaryLayers2;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TBoundaryLayer.MakeFields;
  DependingSafeguardElementList:=TList.Create;
  theDependingSafeguardElementList:=TList.Create;
  BestOvercomeMethodList:=TList.Create;
  theBestOvercomeMethodList:=TList.Create;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;

  DependingSafeguardElementList.Free;
  theDependingSafeguardElementList.Free;
  BestOvercomeMethodList.Free;
  theBestOvercomeMethodList.Free;

  _BottomLineE:=nil;
  _TopLineE:=nil;
  _VLine0E:=nil;
  _Vline1E:=nil;
  _BottomC0:=nil;
  _BottomC1:=nil;
  _TopC0:=nil;
  _TopC1:=nil;
end.
