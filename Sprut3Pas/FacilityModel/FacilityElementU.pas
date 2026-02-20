unit FacilityElementU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TFacilityElement=class(TNamedDMElement, IFacilityElement,
               IElementState, IVulnerabilityData,
               IMethodDimItemSource,
               IPathElement, IDMReporter)
// абстрактный класс - предок для всех элементов структуры охраняемого объекта
// (зон и рубежей)
  private
    FComment:string;

    FSpatialElement: IDMElement;
    FPathArcs:IDMCollection;
    FFalseAlarmPeriod:double;
    FDisabled:boolean;
  protected
    FStates:IDMCollection;
    FSMLabel:IDMElement;

    FUserDefinedDelayTime:boolean;
    FDelayTime:double;
    FDelayTimeToTargetDispersion:double;
    FDelayTimeDispersion:double;

    FUserDefinedDetectionProbability:boolean;
    FDetectionProbability:double;
    FSuccessProbability:double;
    FRationalProbabilityToTarget:double;
    FBackPathRationalProbability:double;
    FDelayTimeToTarget:double;
    FNoDetectionProbabilityFromStart:double;

    FGoalDefinding:boolean;

    FSuccessProbability_NextNode:IDMElement;
    FRationalProbabilityToTarget_NextNode:IDMElement;
    FBackPathRationalProbability_NextNode:IDMElement;
    FDelayTimeToTarget_NextNode:IDMElement;
    FNoDetectionProbabilityFromStart_NextNode:IDMElement;

    FDelayTimeFromStart:double;
    FDelayTimeFromStart_NextNode:IDMElement;
    FDelayTimeFromStart_NextArc:IDMElement;
    FDelayTimeFromStartDispersion: double;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class procedure MakeFields0; override;
    class procedure MakeFields1; override;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;
    procedure Set_Name(const Value:WideString); override; safecall;

    procedure CalculateFieldValues; override;

    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function  Get_SpatialElement: IDMElement; override; safecall;
    procedure Set_SpatialElement(const Value: IDMElement); override; safecall;
    procedure ClearOp; override; safecall;
    function  Get_PathArcs:IDMCollection; safecall;
    function  Get_UserDefineded: WordBool; override; safecall;
    function  Get_PatrolPeriod:double; virtual; safecall;
    function  Get_Disabled:WordBool; safecall;

    function MakeTMPPathArc:ILine; virtual;

    procedure _AddBackRef(const Value:IDMElement); override;
    procedure _RemoveBackRef(const Value:IDMElement); override; safecall;

    function Get_DelayTime: double; virtual; safecall;
    function Get_DetectionProbability: double; safecall;
    function Get_DelayTimeDispersion: double; safecall;
    function Get_DelayTimeToTargetDispersion: double; safecall;
    function Get_UserDefinedDelayTime: WordBool; safecall;
    function Get_UserDefinedDetectionProbability: WordBool; safecall;
    procedure Set_DelayTime(Value: double); safecall;
    procedure Set_DelayTimeToTargetDispersion(Value: double); safecall;
    procedure Set_DelayTimeDispersion(Value: double); safecall;
    procedure Set_DetectionProbability(Value: double); safecall;

    function Get_SuccessProbabilityFromStart:double; safecall;
    function Get_SuccessProbabilityToTarget:double; safecall;
    function Get_RationalProbabilityToTarget:double; safecall;
    function  Get_BackPathRationalProbability: Double; safecall;

    function Get_SuccessProbabilityFromStart_NextNode:IDMElement; safecall;
    function Get_SuccessProbabilityToTarget_NextNode:IDMElement; safecall;
    function Get_RationalProbabilityToTarget_NextNode:IDMElement; safecall;
    function Get_BackPathRationalProbability_NextNode: IDMElement; safecall;
    function Get_DelayTimeToTarget_NextNode:IDMElement; safecall;
    function Get_NoDetectionProbabilityFromStart_NextNode:IDMElement; safecall;

    function Get_SuccessProbabilityFromStart_NextArc:IDMElement; safecall;
    function Get_SuccessProbabilityToTarget_NextArc:IDMElement; safecall;
    function Get_RationalProbabilityToTarget_NextArc:IDMElement; safecall;
    function  Get_BackPathRationalProbability_NextArc: IDMElement; safecall;
    function Get_DelayTimeToTarget_NextArc:IDMElement; safecall;
    function Get_NoDetectionProbabilityFromStart_NextArc:IDMElement; safecall;

    function  Get_BackPathDelayTime: Double; safecall;
    function  Get_BackPathDelayTimeDispersion: Double; safecall;
    function Get_DelayTimeToTarget:double; safecall;

    function Get_DelayTimeFromStart:double; safecall;
    function Get_DelayTimeFromStart_NextNode:IDMElement; safecall;
    function Get_DelayTimeFromStart_NextArc:IDMElement; safecall;
    function Get_DelayTimeFromStartDispersion: double; safecall;

    function Get_NoDetectionProbabilityFromStart:double; safecall;
    function Get_VisualControl: Integer; virtual; safecall;

    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; virtual; safecall;

    function  Get_SMLabel:IDMElement; safecall;
    procedure Set_SMLabel(const Value:IDMElement); virtual; safecall;
    function  Get_Font: ISMFont; safecall;
    procedure Set_Font(const Value: ISMFont); safecall;
    function  Get_LabelScaleMode: Integer; safecall;
    procedure Set_LabelScaleMode(Value: Integer); safecall;
    function  Get_LabelVisible: WordBool; safecall;
    procedure Set_LabelVisible(Value: WordBool); virtual; safecall;
    procedure CalcFalseAlarmPeriod; virtual; safecall;
    function  Get_FalseAlarmPeriod:double; safecall;
    procedure Set_FalseAlarmPeriod(Value:double); safecall;
    function  GetCurrentState:IElementState;

    procedure CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                            out BestTacticE:IDMElement;
                                AddDelay:double); virtual; safecall;
    procedure CalcNoDetectionProbability(
                           out NoDetP, NoFailureP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                           out BestTacticE:IDMElement;
                                AddDelay:double); virtual; safecall;
    procedure CalcPathNoDetectionProbability(
                      var PathNoDetectionProbability:double;
                      out NoDetP, NoFailureP:double;
                      out NoEvidence: WordBool;
                                AddDelay:double); virtual; safecall;
    procedure CalcPathNoDetectionProbability0(
                      var PathNoDetectionProbability,
                          PathNoDetectionProbability0:double;
                                AddDelay:double); virtual; safecall;
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
                      out NoDetP,
                          NoFailureP:double;
                      out NoEvidence:WordBool;
                      out BestTimeSum, BestTimeDispSum:double;
                      out Position:integer;
                                AddDelay:double); virtual; safecall;
    procedure DoCalcPathSuccessProbability(const TacticU:IUnknown;
                          DetectionTime:double;
                      var SuccessProbability:double;
                      out OutstripProbability,
                          StealthT: double;
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner:double;
                                AddDelay:double); virtual; safecall;
    procedure CalcVulnerability; virtual; safecall;
    procedure MakeBackPathElementStates(const SubStateE:IDMElement); virtual; safecall;

    function  Get_GoalDefinding:WordBool; safecall;
    procedure Set_GoalDefinding(Value:WordBool); safecall;

//реализация интерфейса IDMSearchRef
    function GetDeletedObjectsClassID: integer; override;

    procedure UpdateDependingElementsBestMethods
        (const OldDependingSafeguardElements,
        DependingSafeguardElements: IDMCollection);

    procedure Initialize; override;
    procedure  _Destroy; override;
    function GetDelayTimeFromStart(const WarriorGroupE: IDMElement; out DelayTime: Double;
                                   out DelayTimeDispersion: Double): WordBool; virtual; safecall;
    function GetDelayTimeToTarget(const WarriorGroupE: IDMElement; out DelayTime: Double;
                                  out DelayTimeDispersion: Double): WordBool; virtual;  safecall;
  end;


implementation

uses
  FacilityModelConstU, OutstripU;

{ TFacilityElement }

procedure TFacilityElement.CalcNoDetectionProbability(
                           out NoDetP, NoFailureP:double;
                           out NoEvidence:WordBool;
                           out BestTimeSum, BestTimeDispSum:double;
                           out Position:integer;
                           out BestTacticE:IDMElement;
                                AddDelay:double);
begin
  NoDetP:=1;
  NoFailureP:=1;
  NoEvidence:=True;
  BestTimeSum:=0;
  BestTimeDispSum:=0;
  Position:=0;
  BestTacticE:=nil;
end;

procedure TFacilityElement.CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                                         out BestTacticE:IDMElement;
                                         AddDelay:double);
begin
  DelayTime:=0;
  DelayTimeDispersion:=0;
  BestTacticE:=nil;
end;

function TFacilityElement.MakeTMPPathArc: ILine;
begin
  Result:=nil;
end;

function TFacilityElement.Get_SpatialElement: IDMElement;
begin
  Result:=FSpatialElement;
end;

procedure TFacilityElement.Set_SpatialElement(const Value: IDMElement);
var
  OldSpatialElement:IDMElement;
begin
  inherited;
  OldSpatialElement:=Get_SpatialElement;
  if OldSpatialElement = Value then Exit;

  FSpatialElement := Value;

  if OldSpatialElement<>nil then
    OldSpatialElement.Ref:=nil;
end;

procedure TFacilityElement._AddBackRef(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  if Value.QueryInterface(ICoordNode, Unk)=0 then Exit;
  if Value.QueryInterface(ILine, Unk)=0 then Exit;
  if Value.QueryInterface(ISpatialElement, Unk)<>0 then Exit;
  if Value.QueryInterface(IWarriorPathElement, Unk)=0 then Exit;
  if Value.ClassID=_SMLabel then
    Set_SMLabel(Value)
  else
    Set_SpatialElement(Value);
end;

procedure TFacilityElement._RemoveBackRef(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  if Value.QueryInterface(ICoordNode, Unk)=0 then Exit;
  if Value.QueryInterface(ILine, Unk)=0 then Exit;
  if Value.QueryInterface(ISpatialElement, Unk)<>0 then Exit;
  if Value.QueryInterface(IWarriorPathElement, Unk)=0 then Exit;
  if Value.ClassID=_SMLabel then
    Set_SMLabel(nil)
  else
    Set_SpatialElement(nil);
end;


function TFacilityElement.GetFieldValue(Code: integer): OleVariant;
var
  Unk:IUnknown;
  DelayTime, DelayTimeDispersion, NoDetP, NoFailureP:double;
  BestTimeSum, BestTimeDispSum:double;
  Position:integer;
  NoEvidence:WordBool;
  BestTacticE:IDMElement;
begin
  case Code of
  ord(fepRationalProbabilityToTarget):
    Result:=FRationalProbabilityToTarget;
  ord(fepDelayTimeToTarget):
    Result:=FDelayTimeToTarget;
  ord(fepNoDetectionProbabilityFromStart):
    Result:=FNoDetectionProbabilityFromStart;
  ord(cnstComment):
    Result:=FComment;
  ord(fepLabelVisible):
    Result:=Get_LabelVisible;
  ord(fepLabelScaleMode):
    Result:=Get_LabelScaleMode;
  ord(fepFont):
    begin
      Unk:=Get_Font as IUnknown;
      Result:=Unk;
    end;
  ord(fepBackPathRationalProbability):
    Result:=FBackPathRationalProbability;
  ord(fepDelayTime0):
    begin
      if (DataModel<>nil) and
         not DataModel.IsCopying then
        CalcDelayTime(DelayTime, DelayTimeDispersion,
                    BestTacticE, 0);
      Result:=DelayTime;
    end;
  ord(fepDetectionProbability0):
    begin
      if (DataModel<>nil) and
          not DataModel.IsCopying then
        CalcNoDetectionProbability(NoDetP, NoFailureP, NoEvidence,
                  BestTimeSum, BestTimeDispSum, Position, BestTacticE, 0);
      Result:=1-NoDetP;
    end;
  ord(fepGoalDefining):
    Result:=FGoalDefinding;
  ord(cnstDisabled):
    Result:=FDisabled;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TFacilityElement.SetFieldValue(Code: integer;
  Value: OleVariant);
var
  Unk:IUnknown;
  Painter:IUnknown;
  B:Boolean;
  Mode:integer;
  aFont:ISMFont;
begin
  case Code of
  ord(fepRationalProbabilityToTarget):
    FRationalProbabilityToTarget:=Value;
  ord(fepDelayTimeToTarget):
    FDelayTimeToTarget:=Value;
  ord(fepNoDetectionProbabilityFromStart):
    FNoDetectionProbabilityFromStart:=Value;
  ord(cnstComment):
    FComment:=Value;
  ord(fepLabelVisible):
    if (not DataModel.IsLoading) and
       (not DataModel.IsCopying) then begin
      B:=Value;
      Set_LabelVisible(B);
      if DataModel=nil then Exit;
      if DataModel.IsLoading then Exit;
      if DataModel.IsCopying then Exit;
      if not Exists then Exit;
      Painter:=(DataModel.Document as ISMDocument).PainterU;
      if Painter<>nil then begin
        if Selected then
          Draw(Painter, 1)
        else
          Draw(Painter, 0)
      end;
    end;
  ord(fepLabelScaleMode):
    if (not DataModel.IsLoading) and
       (not DataModel.IsCopying) then begin
      Mode:=Value;
      Set_LabelScaleMode(Mode);
    end;
  ord(fepFont):
    if (not DataModel.IsLoading) and
       (not DataModel.IsCopying) then begin
      Unk:=Value;
      aFont:=Unk as ISMFont;
      Set_Font(aFont);
    end;
  ord(fepBackPathRationalProbability):
    FBackPathRationalProbability:=Value;
  ord(fepDelayTime0):
    begin end;
  ord(fepDetectionProbability0):
    begin end;
  ord(fepGoalDefining):
    FGoalDefinding:=Value;
  ord(cnstDisabled):
    FDisabled:=Value;
  else
    inherited;
  end;
end;

function TFacilityElement.Get_DelayTime: double;
var
  State:IElementState;
  FacilityModelS:IFMState;
  Unk:IUnknown;
begin
  FacilityModelS:=DataModel as IFMState;
  if Get_UserDefinedDelayTime and
     (FacilityModelS.CurrentWarriorGroupU.QueryInterface(IGuardGroup, Unk)=0) then
    Result:=0
  else begin
    State:=GetCurrentState;
    if State<>nil then
      Result:=State.DelayTime
    else
      Result:=FDelayTime
  end;
end;

function TFacilityElement.Get_DetectionProbability: double;
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.DetectionProbability
  else
    Result:=FDetectionProbability
end;

function TFacilityElement.Get_UserDefinedDelayTime: WordBool;
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.UserDefinedDelayTime
  else
    Result:=FUserDefinedDelayTime
end;

function TFacilityElement.Get_UserDefinedDetectionProbability: WordBool;
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.UserDefinedDetectionProbability
  else
    Result:=FUserDefinedDetectionProbability
end;

procedure TFacilityElement.Set_DelayTime(Value: double);
var
  State:IElementState;
  FacilityModelS:IFMState;
  Unk:IUnknown;
begin
  FacilityModelS:=DataModel as IFMState;
  if Get_UserDefinedDelayTime and
     (FacilityModelS.CurrentWarriorGroupU.QueryInterface(IGuardGroup, Unk)=0) then Exit;
  State:=GetCurrentState;
  if State<>nil then
    State.DelayTime:=Value
  else
    FDelayTime:=Value
end;

procedure TFacilityElement.Set_DetectionProbability(
  Value: double);
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    State.DetectionProbability:=Value
  else
    FDetectionProbability:=Value
end;

class procedure TFacilityElement.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsComment, '', '', '',
           fvtText, 0, 0, 0,
           cnstComment, 0, pkComment);
  AddField(rsLabelVisible,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(fepLabelVisible), 0, pkView);

  S:='| '+rsLabelNoScale+
     ' | '+rsLabelScale;
  AddField(rsLabelScaleMode,  S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(fepLabelScaleMode), 0, pkView);
  AddField(rsFont,  '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(fepFont), 0, pkView);

  AddField(rsDelayTimeToTarget, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(fepDelayTimeToTarget), 0, pkChart);
  AddField(rsRationalProbabilityToTarget, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(fepRationalProbabilityToTarget), 0, pkChart);
  AddField(rsBackPathRationalProbability, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(fepBackPathRationalProbability), 0, pkChart);
  AddField(rsNoDetectionProbabilityFromStart, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(fepNoDetectionProbabilityFromStart), 0, pkChart);
  AddField(rsDisabled,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(cnstDisabled), 0, pkAnalysis);

end;

procedure TFacilityElement.Initialize;
begin
  inherited;

  FSuccessProbability:=-InfinitValue;
  FDelayTimeToTarget:=-InfinitValue;
  FNoDetectionProbabilityFromStart:=-InfinitValue;

  FPathArcs:=TDMCollection.Create(nil) as IDMCollection;
end;

function TFacilityElement.Get_DelayTimeDispersion: double;
begin
  Result:=FDelayTimeDispersion
end;

procedure TFacilityElement.Set_DelayTimeDispersion(Value: double);
begin
  FDelayTimeDispersion:=Value
end;

function TFacilityElement.Get_DelayTimeToTarget: double;
begin
  Result:=FDelayTimeToTarget
end;

function TFacilityElement.Get_NoDetectionProbabilityFromStart: double;
begin
  Result:=FNoDetectionProbabilityFromStart
end;

function TFacilityElement.Get_DelayTimeToTarget_NextNode: IDMElement;
begin
  Result:=FDelayTimeToTarget_NextNode
end;

function TFacilityElement.Get_NoDetectionProbabilityFromStart_NextNode: IDMElement;
begin
  Result:=FNoDetectionProbabilityFromStart_NextNode
end;

function TFacilityElement.Get_DelayTimeToTarget_NextArc: IDMElement;
begin
  Result:=nil
end;

function TFacilityElement.Get_NoDetectionProbabilityFromStart_NextArc: IDMElement;
begin
  Result:=nil
end;

procedure TFacilityElement._Destroy;
begin
  inherited;
  FStates:=nil;
  FPathArcs:=nil;
  FSMLabel:=nil;
end;

function TFacilityElement.Get_PathArcs: IDMCollection;
begin
  Result:=FPathArcs
end;

procedure TFacilityElement.ClearOp;
var
  DMOperationManager:IDMOperationManager;
  Collection2:IDMCollection2;
begin
  inherited;
  if (SpatialElement=nil) and
     (FSMLabel=nil) then Exit;

  if DataModel=nil then Exit;
  if DataModel.Document=nil then Exit;

  Collection2:=TDMCollection.Create(nil) as IDMCollection2;

  if SpatialElement<>nil then begin
    Collection2.Add(SpatialElement);
    if SpatialElement.Ref=Self as IDMElement then
      SpatialElement.Ref:=nil;
  end;
  if FSMLabel<>nil then begin
    Collection2.Add(FSMLabel);
    FSMLabel.Ref:=nil;
  end;

  DMOperationManager:=DataModel.Document as IDMOperationManager;
  DMOperationManager.DeleteElements(Collection2, False);

  Collection2.Clear;
end;

function TFacilityElement.GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer;
var
  WarriorGroupE:IDMElement;
  WarriorGroup:IWarriorGroup;
  AdversaryVariant:IAdversaryVariant;
begin
  case Kind of
  sdAccess:
    begin
      WarriorGroupE:=ParamE;
      WarriorGroup:=WarriorGroupE as IWarriorGroup;
      case Code of
      0:Result:=WarriorGroup.GetAccessType(Self as IDMElement, True); // в текущем состоянии
      else
        begin
          AdversaryVariant:=WarriorGroupE.Parent as IAdversaryVariant;
          Result:=AdversaryVariant.GetAccessType(Self as IDMElement, False);// кто-либо
        end;                                                                // когда-либо
      end;
    end;
  else
    Result:=-1;
  end;
end;

function TFacilityElement.Get_Font: ISMFont;
begin
  if FSMLabel=nil then
    Result:=nil
  else
    Result:=(FSMLabel as ISMLabel).Font
end;
procedure TFacilityElement.Set_Font(const Value: ISMFont);
begin
  if DataModel.IsLoading then Exit;
  if FSMLabel=nil then Exit;
  (FSMLabel as ISMLabel).Font:=Value
end;

procedure TFacilityElement.Set_LabelScaleMode(Value: Integer);
begin
  if DataModel.IsLoading then Exit;
  if FSMLabel=nil then Exit;
  (FSMLabel as ISMLabel).LabelScaleMode:=Value
end;

function TFacilityElement.Get_LabelScaleMode: Integer;
begin
  if FSMLabel=nil then
    Result:=0
  else
    Result:=(FSMLabel as ISMLabel).LabelScaleMode
end;

function TFacilityElement.Get_LabelVisible: WordBool;
begin
  Result:=(FSMLabel<>nil)
end;

procedure TFacilityElement.Set_LabelVisible(Value: WordBool);
var
  Collection:IDMCollection;
  SpatialModel2:ISpatialModel2;
  DMOperationManager:IDMOperationManager;
  Unk:IUnknown;
  LabelSize:double;
  SMDocument:ISMDocument;
  View:IView;
begin
  if DataModel.IsLoading then Exit;
  SpatialModel2:=DataModel as ISpatialModel2;
  Collection:=SpatialModel2.Labels as IDMCollection;
  DMOperationManager:=DataModel.Document as  IDMOperationManager;
  if Value then begin
    if FSMLabel<>nil then Exit;

    SMDocument:=DataModel.Document as ISMDocument;
    View:=(SMDocument.PainterU as IPainter).ViewU as IView;
    LabelSize:=10*View.RevScale;

    DMOperationManager.AddElementRef(SpatialElement.Parent, Collection, Name,
                      Self as IUnknown, ltOneToMany, Unk, True);
    DMOperationManager.ChangeFieldValue(Unk, 1, True, SpatialModel2.CurrentFont); // 1 - Font
    DMOperationManager.ChangeFieldValue(Unk, 3, True, LabelSize); // 3 - LabelSize
  end else begin
    if FSMLabel=nil then Exit;
    DMOperationManager.DeleteElement(FSMLabel.Parent, Collection, ltOneToMany, FSMLabel);
  end;
end;

function TFacilityElement.Get_SMLabel: IDMElement;
begin
  Result:=FSMLabel
end;

procedure TFacilityElement.Set_SMLabel(const Value: IDMElement);
begin
  FSMLabel:=Value
end;

function TFacilityElement.Get_VisualControl: Integer;
begin
  Result:=0;
end;

procedure TFacilityElement.CalcFalseAlarmPeriod;
begin
end;

function TFacilityElement.Get_FalseAlarmPeriod: double;
begin
  Result:=FFalseAlarmPeriod
end;

procedure TFacilityElement.Set_FalseAlarmPeriod(Value: double);
var
  FacilityModel:IFacilityModel;
  F, T:double;
begin
  FacilityModel:=DataModel as IFacilityModel;
  T:=FacilityModel.FalseAlarmPeriod;
  if T<>0 then
    F:=1/T
  else
    F:=0;
  if FFalseAlarmPeriod<>0 then
    F:=F-1/FFalseAlarmPeriod;

  FFalseAlarmPeriod:=Value;

  if FFalseAlarmPeriod<>0 then
    F:=F+1/FFalseAlarmPeriod;

  if F<>0 then
    FacilityModel.FalseAlarmPeriod:=1/F
  else
    FacilityModel.FalseAlarmPeriod:=0

end;

function TFacilityElement.Get_UserDefineded: WordBool;
begin
  Result:=(inherited Get_UserDefineded) or
    FUserDefinedDelayTime or
    FUserDefinedDetectionProbability
end;

function TFacilityElement.GetCurrentState: IElementState;
var
  j, m:integer;
  FacilityState:IFacilityState;
  SubStateE:IDMElement;
begin
  Result:=nil;
  if FStates.Count=0 then Exit;
  FacilityState:=DataModel.CurrentState as IFacilityState;
  if FacilityState=nil then Exit;
  j:=FacilityState.SubStateCount-1;
  m:=-1;
  while j>=0 do begin
    SubStateE:=FacilityState.SubState[j];
    m:=0;
    while m<FStates.Count do
      if FStates.Item[m].Ref=SubStateE then
        Break
      else
        inc(m);
    if m<FStates.Count then
      Break
    else
      dec(j);
  end;
  if j>=0 then
    Result:=FStates.Item[m] as IElementState
end;

function TFacilityElement.Get_PatrolPeriod: double;
begin
  Result:=InfinitValue
end;

procedure TFacilityElement.CalcPathNoDetectionProbability(
                      var PathNoDetectionProbability:double;
                      out NoDetP, NoFailureP: Double;
                      out NoEvidence:WordBool;
                                AddDelay:double);
var
  BestTacticE:IDMElement;
  BestTimeSum, BestTimeDispSum:double;
  Position:integer;
begin
  CalcNoDetectionProbability(NoDetP,
                             NoFailureP,
                             NoEvidence,
                             BestTimeSum, BestTimeDispSum,
                             Position,
                             BestTacticE, AddDelay);

  PathNoDetectionProbability:=PathNoDetectionProbability*NoDetP;
end;

procedure TFacilityElement.CalcPathSoundResistance(
  var PathSoundResistance, FuncSoundResistance: Double);
var
  FacilityModelS:IFMState;
  Line:ILine;
begin
  FacilityModelS:=DataModel as IFMState;
  Line:=FacilityModelS.CurrentLineU as ILine;
  FuncSoundResistance:=FuncSoundResistance+Line.Length
end;

procedure TFacilityElement.CalcPathSuccessProbability(
                      var SuccessProbability: double;
                      out OutstripProbability: double;
                      var DelayTimeSum,
                          DelayTimeDispersionSum:double;
                                AddDelay:double);
begin
end;

procedure TFacilityElement.Draw(const aPainter: IInterface;
  DrawSelected: integer);
begin
  inherited;
  if (FSMLabel<>nil) and
     (DataModel as IVulnerabilityMap).ShowText then
    FSMLabel.Draw(aPainter, DrawSelected);
end;

function TFacilityElement.Get_SuccessProbabilityFromStart: double;
begin
  Result:=FSuccessProbability
end;

function TFacilityElement.Get_SuccessProbabilityToTarget: double;
begin
  Result:=FSuccessProbability
end;

function TFacilityElement.Get_SuccessProbabilityFromStart_NextNode: IDMElement;
begin
  Result:=FSuccessProbability_NextNode
end;

function TFacilityElement.Get_SuccessProbabilityToTarget_NextNode: IDMElement;
begin
  Result:=FSuccessProbability_NextNode
end;

function TFacilityElement.Get_SuccessProbabilityFromStart_NextArc: IDMElement;
begin
  Result:=nil
end;

function TFacilityElement.Get_SuccessProbabilityToTarget_NextArc: IDMElement;
begin
  Result:=nil
end;

procedure TFacilityElement.MakeBackPathElementStates(
  const SubStateE: IDMElement);
begin
end;

function TFacilityElement.Get_DelayTimeToTargetDispersion: double;
begin
  Result:=FDelayTimeToTargetDispersion
end;

function TFacilityElement.Get_RationalProbabilityToTarget: double;
begin
  Result:=FRationalProbabilityToTarget
end;

function TFacilityElement.Get_RationalProbabilityToTarget_NextNode: IDMElement;
begin
  Result:=FRationalProbabilityToTarget_NextNode
end;

function TFacilityElement.Get_RationalProbabilityToTarget_NextArc: IDMElement;
begin
  Result:=nil
end;

procedure TFacilityElement.Set_DelayTimeToTargetDispersion(Value: double);
begin
end;

procedure TFacilityElement.CalcVulnerability;
begin
end;

function TFacilityElement.Get_BackPathRationalProbability: Double;
begin
  Result:=FBackPathRationalProbability
end;

function TFacilityElement.Get_BackPathRationalProbability_NextNode: IDMElement;
begin
  Result:=FBackPathRationalProbability_NextNode
end;

function TFacilityElement.Get_BackPathRationalProbability_NextArc: IDMElement;
begin
  Result:=nil
end;

procedure TFacilityElement.DoCalcDelayTime(const TacticU: IInterface;
    out DelayTime, DelayTimeDisparsion: double; AddDelay:double);
begin
end;

procedure TFacilityElement.DoCalcPathSuccessProbability(const TacticU: IInterface;
                          DetectionTime:double;
                      var SuccessProbability:double;
                      out OutstripProbability,
                          StealthT: double;
                          DelayTimeSumOuter,
                          DelayTimeDispersionSumOuter,
                          DelayTimeSumInner,
                          DelayTimeDispersionSumInner:double;
                                AddDelay:double);
begin
end;

procedure TFacilityElement.DoCalcNoDetectionProbability(
  const TacticU: IInterface; DetectionTime:double;
  out NoDetP,  NoFailureP:double;
  out NoEvidence:WordBool;
  out BestTimeSum, BestTimeDispSum: double;
  out Position:integer; AddDelay:double);
begin
end;

function TFacilityElement.Get_BackPathDelayTime: Double;
begin
  Result:=0
end;

function TFacilityElement.Get_BackPathDelayTimeDispersion: Double;
begin
  Result:=0
end;

procedure TFacilityElement.UpdateDependingElementsBestMethods(
  const OldDependingSafeguardElements,
  DependingSafeguardElements: IDMCollection);
var
  j:integer;
  SafeguardElementE:IDMElement;
  SafeguardElement:ISafeguardElement;
  DependingSafeguardElements2:IDMCollection2;
begin

  for j:=0 to OldDependingSafeguardElements.Count-1 do begin
    SafeguardElement:=OldDependingSafeguardElements.Item[j] as ISafeguardElement;
    SafeguardElement.BestOvercomeMethod:=nil;
  end;

  DependingSafeguardElements2:=OldDependingSafeguardElements as IDMCollection2;
  DependingSafeguardElements2.Clear;

  for j:=0 to DependingSafeguardElements.Count-1 do begin
    SafeguardElementE:=DependingSafeguardElements.Item[j];
    SafeguardElement:=SafeguardElementE as ISafeguardElement;
    DependingSafeguardElements2.Add(SafeguardElementE);
    SafeguardElement.BestOvercomeMethod:=SafeguardElement.CurrOvercomeMethod;
  end;

end;

procedure TFacilityElement.CalcPathNoDetectionProbability0(
  var PathNoDetectionProbability, PathNoDetectionProbability0: double;
                                AddDelay:double);
var
  PrevNoDetPSum, PrevNoDetP0Sum, PrevNoDetP1Sum,
  NoDetP,
  NoDetPSum, NoDetP0Sum, NoDetP1Sum, NoFailureP:double;
  BestTimeSum, BestTimeDispSum:double;
  Position:integer;
  NoEvidence:WordBool;
  BestTacticE:IDMElement;
begin
  CalcNoDetectionProbability(NoDetP, NoFailureP, NoEvidence,
             BestTimeSum, BestTimeDispSum, Position, BestTacticE, AddDelay);

  PrevNoDetPSum:=PathNoDetectionProbability;
  PrevNoDetP0Sum:=PathNoDetectionProbability0;
  PrevNoDetP1Sum:=PrevNoDetPSum-PrevNoDetP0Sum;

  NoDetP0Sum:=PrevNoDetP0Sum*NoDetP;
  NoDetP1Sum:=PrevNoDetP1Sum*NoDetP;
  NoDetPSum:=NoDetP0Sum+NoDetP1Sum;

  PathNoDetectionProbability:=NoDetPSum;
  PathNoDetectionProbability0:=NoDetP0Sum;
end;

function TFacilityElement.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(fepRationalProbabilityToTarget),
  ord(fepDelayTimeToTarget),
  ord(fepNoDetectionProbabilityFromStart),
  ord(fepBackPathRationalProbability),
  ord(fepDelayTime0),
  ord(fepDetectionProbability0),
  ord(cnstComment):
    Result:=False;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

function TFacilityElement.GetDeletedObjectsClassID: integer;
begin
  Result:=_Updating;
end;

procedure TFacilityElement.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;

end;

procedure TFacilityElement.CalculateFieldValues;
var
  Document:IDMDocument;
  OldState:integer;
begin
  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfExecuting;
  try
    CalcVulnerability;
  finally
    Document.State:=OldState;
  end;
end;

class procedure TFacilityElement.MakeFields1;
begin
  inherited;
  AddField(rsDelayTime, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(fepDelayTime0), 0, pkChart or pkDontSave);
  AddField(rsDetectionProbability, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(fepDetectionProbability0), 0, pkChart or pkDontSave);
  AddField(rsGoalDefining, '', '', '',
                 fvtBoolean, 1, 0, 0,
                 ord(fepGoalDefining), 0, pkAnalysis);
end;

function TFacilityElement.Get_Disabled: WordBool;
begin
  Result:=FDisabled
end;

function TFacilityElement.Get_GoalDefinding: WordBool;
begin
  Result:=FGoalDefinding
end;

procedure TFacilityElement.Set_GoalDefinding(Value: WordBool);
begin
  FGoalDefinding:=Value
end;

procedure TFacilityElement.Set_Name(const Value: WideString);
var
  DMOperationManager:IDMOperationManager;
begin
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  if not DataModel.IsLoading and
     not DataModel.IsCopying and
     (FSMLabel<>nil) then begin
    if FSMLabel.Name=Name then
      DMOperationManager.RenameElement(FSMLabel, Value);
  end;

  inherited;
end;

function TFacilityElement.Get_DelayTimeFromStart: double;
begin
  Result:=FDelayTimeFromStart
end;

function TFacilityElement.Get_DelayTimeFromStart_NextArc: IDMElement;
begin
  Result:=FDelayTimeFromStart_NextArc
end;

function TFacilityElement.Get_DelayTimeFromStart_NextNode: IDMElement;
begin
  Result:=FDelayTimeFromStart_NextNode
end;

function TFacilityElement.Get_DelayTimeFromStartDispersion: double;
begin
  Result:=FDelayTimeFromStartDispersion
end;

function TFacilityElement.GetDelayTimeFromStart(
  const WarriorGroupE: IDMElement; out DelayTime,
  DelayTimeDispersion: Double): WordBool;
begin
  Result:=False
end;

function TFacilityElement.GetDelayTimeToTarget(
  const WarriorGroupE: IDMElement; out DelayTime,
  DelayTimeDispersion: Double): WordBool;
begin
  Result:=False
end;

end.

