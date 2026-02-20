unit GuardPostU;

interface
uses
  Classes, SysUtils, Math, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DistantDetectionElementU;

type
  TShotTargetDimensionsRecord=record
    Width:double;
    Height:double;
    FigureFactor:double;
  end;

  TBattleRecord=record
    MainGroup:Pointer;
    Count:Integer;
    B:Double;
    T:Double;
    X0:Double;
    Y0:Double;
    Z0:Double;
    X1:Double;
    Y1:Double;
    Z1:Double;
  end;
  PBattleRecord=^TBattleRecord;

  TShotTargetType=(ttHeadHigh,     // головна€ фигура
                   ttChestHigh,    // грудна€ фигура
                   ttWaistHigh,    // по€сна€ фигура
                   ttFullHigh);    // ростова€ фигура

  TShotTargetDimensionsArray=array[ttHeadHigh..ttFullHigh] of TShotTargetDimensionsRecord;

const
  ShotTargetDimensions:TShotTargetDimensionsArray =
((Width:0.5; Height:0.3; FigureFactor:0.68),
 (Width:0.5; Height:0.5; FigureFactor:0.8),
 (Width:0.5; Height:1;   FigureFactor:0.9),
 (Width:0.5; Height:1.5; FigureFactor:0.85));

  cnstDefaultShotDeviationFactor=4;
 // фактор увеличени€ срединного отклонени€ при стрельбе у неопытного стрелка
  cnstConnectionTime=20;
 // врем€ установлени€ св€зи, сек

type

  TGuardPost=class(TDistantDetectionElement, IGuardPost, IAlarmAssess,
                   IInsiderTarget, IWidthIntf, IObservationElement)
  private
    FParents:IDMCollection;

    FParamReferences:IDMCollection;
    FControlDevices:IDMCollection;
    FCommunicationDevices:IDMCollection;

    FWarriorGroups:IDMCollection;
    FAlarmButton:boolean;
    FDutyDistance:double;

    FBattleList:TList;

    FDefenceLevel:integer;
    FOpenedDefenceState:integer;
    FHidedDefenceState:integer;


  protected
    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class procedure MakeFields1; override;
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    procedure Loaded; override;
    procedure AfterLoading2; override; safecall;

    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure Set_Ref(const Value:IDMElement); override; safecall;

    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    procedure Set_Selected(Value: WordBool); override; safecall;

    function  Get_Parents:IDMCollection; override;
    function  Get_ParamReferences:IDMCollection;
    function  Get_ControlDevices:IDMCollection;
    function  Get_CommunicationDevices:IDMCollection;

    procedure _AddBackRef(const aValue:IDMElement); override;
    procedure _RemoveBackRef(const aValue:IDMElement); override;
    function  Get_WarriorGroups: IDMCollection; safecall;
    function  Get_AlarmButton: boolean;
    function  Get_DutyDistance:double; safecall;
    function Get_DefenceLevel: integer; safecall;
    function Get_OpenedDefenceState: integer; safecall;
    function Get_HidedDefenceState: integer; safecall;
    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; override; safecall;

    function  GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double; override; safecall;
    function GetElevation:double; override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function PointInDetectionZone(X, Y, Z:double; const CRef, ExcludeAreaE:IDMElement):WordBool; override; safecall;
    function DoCalcDetectionProbability(const TacticU:IUnknown;
                          const OvercomeMethodE:IDMElement;
                          DelayTime:double;
                          var DetP0, DetPf, WorkP:double;
                          CalcAll:WordBool):double; override; safecall;
    procedure CalcDelayTime(const TacticU:IUnknown;
                            out DelayTime, DelayTimeDispersion :double); override; safecall;
    function DoCalcDelayTime(const OvercomeMethodE:IDMElement):double; override; safecall;


    function  GetMaxDelayDistance:double; safecall;
    function  InWorkingState:WordBool; override; safecall;
    function  ShowInLayerName: WordBool; override; safecall;

// IAlarmAssess
    function GetAssessProbability: Double; safecall;

//IInsiderTarget
    function Get_ControledByInsider: integer; safecall;
//IWidthIntf
    function Get_Width: Double; safecall;

    function GetObservationKind(Distance:double):integer; override;

//IObservationElement
    function GetObservationPeriod(Distance:double): double; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TGuardPosts=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function Get_ClassAlias(Index: integer):WideString; override;
  end;

implementation

uses
  FacilityModelConstU,
  ControlDeviceU,
  WarriorPathU,
  OutstripU;

var
  FFields:IDMCollection;

{ TGuardPost }

procedure TGuardPost.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);

  FParamReferences:=DataModel.CreateCollection(-1, SelfE);
  FControlDevices:=DataModel.CreateCollection(_ControlDevice, SelfE);
  FCommunicationDevices:=DataModel.CreateCollection(_CommunicationDevice, SelfE);
  FWarriorGroups:=DataModel.CreateCollection(_GuardGroup, SelfE);

  FBattleList:=TList.Create;
end;

procedure TGuardPost._Destroy;
var
  i:Integer;
begin
  inherited;
  FParamReferences:=nil;
  FWarriorGroups:=nil;

  FControlDevices:=nil;
  FCommunicationDevices:=nil;

  for i:=FBattleList.Count-1 downto 0 do
      FreeMem(FBattleList[i],SizeOf(TBattleRecord));
  FBattleList:=nil;
end;

class function TGuardPost.GetClassID: integer;
begin
  Result:=_GuardPost;
end;

procedure TGuardPost.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
begin
  inherited
end;

procedure TGuardPost._AddBackRef(const aValue: IDMElement);
var
  WarriorGroup:IWarriorGroup;
begin
  if aValue.QueryInterface(IWarriorGroup, WarriorGroup)=0 then begin
    if FWarriorGroups.IndexOf(aValue)=-1 then
      (FWarriorGroups as IDMCollection2).Add (aValue);
  end else
    inherited;
end;

procedure TGuardPost._RemoveBackRef(const aValue: IDMElement);
var
  GuardGroup:IWarriorGroup;
  j:integer;
begin
  if aValue.QueryInterface(IWarriorGroup, GuardGroup)=0 then begin
    j:=FWarriorGroups.IndexOf(aValue);
    if j<>-1 then
      (FWarriorGroups as IDMCollection2).Delete(j);
  end else
    inherited;
end;

function TGuardPost.Get_ParamReferences: IDMCollection;
begin
  Result:=FParamReferences;
end;

function TGuardPost.Get_WarriorGroups: IDMCollection;
begin
  Result:=FWarriorGroups;
end;

function TGuardPost.GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double;
var
  T:double;
begin
  T:=GetObservationPeriod(0);
  if T<0 then
    Result:=0
  else
  if T>0 then
    Result:=1-exp(-aTime/T)
  else
    Result:=1;
end;

function TGuardPost.Get_AlarmButton: boolean;
begin
  Result:=FAlarmButton
end;

function TGuardPost.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(pstUserDefinedDelayTime):
    Result:=FUserDefinedDelayTime;
  ord(pstDelayTime):
    Result:=FDelayTime;
  ord(pstPostAlarmButton):
    Result:=FAlarmButton;
  ord(pstDutyDistance):
    Result:=FDutyDistance;
  ord(pstDefenceLevel):
    Result:=FDefenceLevel;
  ord(pstOpenedDefenceState):
    Result:=FOpenedDefenceState;
  ord(pstHidedDefenceState):
    Result:=FHidedDefenceState;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TGuardPost.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(pstUserDefinedDetectionProbability):
    begin
      FUserDefinedDetectionProbability:=Value;
      UpdateUserDefinedElements(FUserDefinedDetectionProbability);
    end;
  ord(pstDetectionProbability):
    FDetectionProbability:=Value;
  ord(pstUserDefinedDelayTime):
    begin
      FUserDefinedDelayTime:=Value;
      UpdateUserDefinedElements(FUserDefinedDelayTime);
    end;
  ord(pstDelayTime):
    FDelayTime:=Value;
  ord(pstPostAlarmButton):
    FAlarmButton:=Value;
  ord(pstDutyDistance):
    FDutyDistance:=Value;
  ord(pstDefenceLevel):
    FDefenceLevel:=Value;
  ord(pstOpenedDefenceState):
    FOpenedDefenceState:=Value;
  ord(pstHidedDefenceState):
    FHidedDefenceState:=Value;
  else
    inherited;
  end;
end;

function TGuardPost.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(pstUserDefinedDetectionProbability):
    Result:=True;
  ord(pstDetectionProbability):
    Result:=Get_UserDefinedDetectionProbability;
  ord(pstUserDefinedDelayTime):
    Result:=True;
  ord(pstDelayTime):
    Result:=Get_UserDefinedDelayTime;
  ord(pstDutyDistance):
    Result:=True;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

class function TGuardPost.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TGuardPost.MakeFields0;
begin
  inherited;
  AddField(rsUserDefinedDelayTime, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(pstUserDefinedDelayTime), 0, pkUserDefined);
  AddField(rsDelayTime, '%9.0f', '', '',
                 fvtFloat,   0, 0, InfinitValue,
                 ord(pstDelayTime), 0, pkUserDefined);
end;

class procedure TGuardPost.MakeFields1;
var
  S:WideString;
begin
  AddField(rsPostAlarmButton, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(pstPostAlarmButton), 0, pkInput);
  AddField(rsDutyDistance, '%0.0f', '', '',
                 fvtFloat, 200, 0, 0,
                 ord(pstDutyDistance), 0, pkInput);
  S:='|'+rsNoWeaponDefence+
     '|'+rsKnifeDefence+
     '|'+rsClass1+
     '|'+rsClass2+
     '|'+rsClass3+
     '|'+rsClass4+
     '|'+rsClass5+
     '|'+rsClass5a+
     '|'+rsClass6+
     '|'+rsClass6a+
     '|'+rsRPGDefence+
     '|'+rsGoodRPGDefence;
  AddField(rsDefenceLevel, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(pstDefenceLevel), 0, pkInput);
  S:='|'+rsNoDefence+
     '|'+rsRunning+
     '|'+rsHalfHeightDefence+
     '|'+rsChestHeightDefence+
     '|'+rsHeadHeightDefence+
     '|'+rsFullDefence;
  AddField(rsOpenedDefenceState, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(pstOpenedDefenceState), 0, pkInput);
  AddField(rsHidedDefenceState, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(pstHidedDefenceState), 0, pkInput);

  inherited;
end;

procedure TGuardPost.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  Image:IElementImage;
  Painter:IPainter;
  aLine:ILine;
  C0, C1:ICoordNode;
  L, Z:double;
  cosA, sinA, cosZ, sinZ, A,
  WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2:double;
  SafeguardDatabase:ISafeguardDatabase;
  SpatialModel:ISpatialModel;
  Layer:ILayer;
begin
  if Ref=nil then Exit;
  if Parent=nil then Exit;
  if SpatialElement=nil then Exit;
  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;
  Image:=SafeguardDatabase.SphearSectorImage as IElementImage;
  if (Image<>nil) and
     (SpatialElement.ClassID=_Line) and
     (DataModel as IVulnerabilityMap).ShowDetectionZones and
     (SpatialElement.Parent as ILayer).Visible then begin
    Layer:=SpatialElement.Parent as ILayer;
    if not Layer.Visible then Exit;
  
    SpatialModel:=DataModel as ISpatialModel;
    Painter:=aPainter as IPainter;
    if Painter.UseLayers then
       Painter.LayerIndex:=SpatialModel.Layers.IndexOf(SpatialElement.Parent);
  
    aLine:=Get_SpatialElement as ILine;
  
    C0:=aLine.C0;
    C1:=aLine.C1;
    WX0:=C0.X;
    WY0:=C0.Y;
    WZ0:=C0.Z;
    WX1:=C1.X;
    WY1:=C1.Y;
    WZ1:=C1.Z;
  
    Z:=WZ0+Get_Elevation;
    L:=sqrt(sqr(WX1-WX0)+sqr(WY1-WY0));
    if L=0 then Exit;
    cosZ:=(WX1-WX0)/L;
    sinZ:=(WY1-WY0)/L;
  
    if (DrawSelected=1) then
      Painter.PenColor:=clLime
    else if (DrawSelected=-1) then
      Painter.PenColor:=clWhite
    else
      Painter.PenColor:=Layer.Color;
  
    Painter.PenStyle:=ord(psDot);
    Painter.DrawLine(WX0,WY0,Z,WX1,WY1,WZ1);
  
    A:=60;
  
    cosA:=cos(A/180*pi);
    sinA:=sqrt(1-sqr(cosA));
  
    Painter.PenStyle:=ord(psSolid);
  
    WX2:=WX0+(cosZ*cosA-sinZ*sinA)*L;
    WY2:=WY0+(sinZ*cosA+cosZ*sinA)*L;
    Painter.DrawLine(WX0,WY0,Z,WX2,WY2,WZ0);
  
    WX2:=WX0+(cosZ*cosA+sinZ*sinA)*L;
    WY2:=WY0+(sinZ*cosA-cosZ*sinA)*L;
    Painter.DrawLine(WX0,WY0,Z,WX2,WY2,WZ0);
    Painter.DrawArc(WX0,WY0,WZ0,WX1,WY1,WZ0,WX2,WY2,WZ0);
  end;

  inherited;
end;

procedure TGuardPost.Set_SpatialElement(const Value: IDMElement);
var
  Line:ILine;
  L,Length, LengthXY,Elevation:double;
  C0, C1:ICoordNode;
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if Value=nil then Exit;

  Elevation:=1.7*100;

  if Value.QueryInterface(ILine, Line)=0 then begin
    L:=Line.Length;
    if L=0 then Exit;
    C0:=Line.C0;
    C1:=Line.C1;

    Length:=50*100;
    if Length<=0 then Exit;

    if Elevation>Length then
      Elevation:=0;

    LengthXY:=sqrt(sqr(Length)-sqr(Elevation));
    C1.X:=C0.X+(C1.X-C0.X)*LengthXY/L;
    C1.Y:=C0.Y+(C1.Y-C0.Y)*LengthXY/L;
  end;

  Set_Elevation(Elevation);

end;

procedure TGuardPost.Set_Parent(const Value:IDMElement);
var
  WarriorGroup:IWarriorGroup;
  GuardPostTypeID, j, Task:integer;
  ResponceGroupE:IDMElement;
  FacilityModel:IFacilityModel;
  aDocument:IDMDocument;
  OldState:integer;
  DMOperationManager:IDMOperationManager;
  Unk, GuardGroupU:IUnknown;
  ResponceGroupW:IWarriorGroup;
  S:WideString;
begin
  inherited;
  if Value=nil then begin
    for j:=0 to FWarriorGroups.Count-1 do begin
      WarriorGroup:=FWarriorGroups.Item[j] as IWarriorGroup;
      if WarriorGroup.StartPoint=(Self as IDMElement) then
        WarriorGroup.StartPoint:=nil;
    end;
  end;
  if DataModel.IsLoading then Exit;
  if Parent=nil then Exit;

  if FWarriorGroups.Count=0 then begin
    aDocument:=DataModel.Document as IDMDocument;
    DMOperationManager:=aDocument as IDMOperationManager;
    OldState:=aDocument.State;
    FacilityModel:=DataModel as IFacilityModel;
    Unk:=Self as IUnknown;

    try

    ResponceGroupE:=nil;
    j:=0;
    while j<FacilityModel.GuardGroups.Count do begin
      ResponceGroupE:=FacilityModel.GuardGroups.Item[j];
      ResponceGroupW:=ResponceGroupE as IWarriorGroup;
      if ResponceGroupW.StartPoint=nil then
        Break
      else
        inc(j)
    end;
    if j<FacilityModel.GuardGroups.Count then begin
      S:=ResponceGroupE.Name+' /'+Name;
      DMOperationManager.ChangeFieldValue(ResponceGroupE, ord(gpStartPoint), True, Unk);
      DMOperationManager.RenameElement(ResponceGroupE, S);
    end else
      ResponceGroupE:=nil;

    if Ref<>nil then
      GuardPostTypeID:=(Ref.Parent as IModelElementType).TypeID
    else
      GuardPostTypeID:=-1;

    if (GuardPostTypeID<>3) and  // не собака
       ((GuardPostTypeID<>2) or  // не место дислокации группы реагировани€ или...
        (ResponceGroupE=nil)) then begin

      case GuardPostTypeID of
      0:begin        // пост часового
          S:=rsGuardMan;
          Task:=gtStayOnPost;
        end;
      1:begin       // пост оператора
          S:=rsOperator;
          Task:=gtStayOnPost;
        end;
      2:begin      // дислокаци€ сил реагировани€
          S:=rsResponceGroup;
          Task:=gtInterruptOnTarget;
        end;
      3:begin      // —обака
          S:=rsDog;
          Task:=gtStayOnPost;
        end;
      4:begin      //  онтролер
          S:=rsControlMan;
          Task:=gtStayOnPost;
        end;
      else
        begin
          S:=rsGuardMan;
          Task:=gtStayOnPost;
        end;
      end;

      S:=S+' '+IntToStr(DataModel.NextID[_GuardGroup]);
      S:=S+' /'+Name;
      DMOperationManager.AddElement( FacilityModel.GuardVariants.Item[0],
                    FacilityModel.GuardGroups, S, ltOneToMany, GuardGroupU, True);
      DMOperationManager.ChangeFieldValue(GuardGroupU, ord(gpStartPoint), True, Unk);
      Unk:=nil;
      DMOperationManager.ChangeFieldValue(GuardGroupU, ord(gpFinishPoint), True, Unk);


      DMOperationManager.ChangeFieldValue(GuardGroupU, ord(gpTask), True, Task);
    end;

    finally
      aDocument.State:=OldState;
    end;
  end;
end;

function TGuardPost.Get_ControlDevices: IDMCollection;
begin
  Result:=FControlDevices
end;

function TGuardPost.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  ord(gpcControlDevices):
    Result:=FControlDevices;
  ord(gpcCommunicationDevices):
    Result:=FCommunicationDevices;
  ord(gpcWarriorGroups):
    Result:=FWarriorGroups;
  ord(gpcCabels):
    Result:=FConnections;
  else
     Result:=inherited Get_Collection(Index);
  end;
end;

function TGuardPost.Get_CollectionCount: integer;
begin
  Result:=ord(high(TGuardPostCategory))+1
end;

procedure TGuardPost.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  DataModelE:IDMELement;
begin
  DataModelE:=DataModel as IDMELement;
  case Index of
  ord(gpcControlDevices):begin
      aCollectionName:=rsGuardPostControlDevices;
      aRefSource:=DataModelE.Ref.Collection[_ControlDeviceType];
      aClassCollections:=nil;
      aOperations:=leoAdd or leoDelete or leoRename or leoChangeRef;
      aLinkType:=ltOneToMany;
    end;
  ord(gpcCommunicationDevices):begin
      aCollectionName:=rsCommunicationDevices;
      aRefSource:=DataModelE.Ref.Collection[_CommunicationDeviceType];
      aClassCollections:=nil;
      aOperations:=leoAdd or leoDelete or leoRename or leoChangeRef;
      aLinkType:=ltOneToMany;
    end;
  ord(gpcWarriorGroups):
    begin
      aCollectionName:=rsGuardGroups;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoDelete or leoRename;
      aLinkType:=ltIndirect;
    end;
  ord(gpcCabels):
    begin
      aCollectionName:=rsConnections;
      if DataModel<>nil then
        aRefSource:=(DataModel as IDMElement).Collection[_ControlDevice]
      else
        aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  else
    inherited
  end;
end;

function TGuardPost.GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer;
var
  GuardGroupW, AdversaryGroupW:IWarriorGroup;
  Line, aLine:ILine;
  C0, C1, C:ICoordNode;
  D, T, MinT, Time, X, Y, Z:double;
  WeaponE, ControlDeviceE:IDMElement;
  WeaponKind:IWeaponKind;
  GuardPostKind:IGuardPostKind;
  k, j, N:integer;
  aField:IDMField;
  BoundaryE, AreaE:IDMElement;
  Area:IArea;
  Weapon:IWeapon;
  aDefenceLevel,aShotForce:Integer;
begin
  case Kind of
  sdWeaponType:
    begin
      j:=0;
      while j<FWarriorGroups.Count do begin
        GuardGroupW:=(FWarriorGroups.Item[j] as  IWarriorGroup);
        if GuardGroupW.Weapons.Count>0 then
          Break
        else
          inc(j)
      end;
      if j<FWarriorGroups.Count then
        Result:=0
      else
        Result:=1
    end;
  sdAdversaryCount:
    begin
      N:=0;
      for j:=0 to FWarriorGroups.Count-1 do begin
        GuardGroupW:=(FWarriorGroups.Item[j] as  IWarriorGroup);
        N:=N+GuardGroupW.InitialNumber;
      end;

      AdversaryGroupW:=ParamE as IWarriorGroup;
      if N<=AdversaryGroupW.InitialNumber then
        Result:=0
      else
        Result:=1
    end;
  sdDetectionSector:
    begin
      case Code of
      0:begin
          Line:=ParamE as ILine;
          if Line=nil then begin
            Result:=0;
            Exit;
          end;
          C0:=Line.C0;
          C1:=Line.C1;
          if SpatialElement=nil then begin
            if Parent.ClassID=_BoundaryLayer then begin
              if Parent.Ref.ID=btEntryPoint then
                Result:=0
              else
                Result:=2
            end else
              Result:=2
          end else begin
            if SpatialElement.QueryInterface(ILine, aLine)<>0 then
              Result:=0
            else
            if PointInDetectionZone(0.5*(Line.C0.X+Line.C1.X),
                                  0.5*(Line.C0.Y+Line.C1.Y),
                                  0.5*(Line.C0.Z+Line.C1.Z), nil, nil) then
              Result:=1
            else
              Result:=2
          end;
        end;
      1:begin
          Line:=ParamE as ILine;
          if Line=nil then begin
            Result:=1;
            Exit;
          end;
          C0:=Line.C0;
          C1:=Line.C1;
          if SpatialElement=nil then begin
            if Parent.ClassID=_BoundaryLayer then begin
              if Parent.Ref.ID=btEntryPoint then
                Result:=0
              else
                Result:=1
            end else
              Result:=1
          end else begin
            if SpatialElement.QueryInterface(ILine, aLine)<>0 then
              Result:=1
            else
            if PointInDetectionZone(0.5*(Line.C0.X+Line.C1.X),
                                  0.5*(Line.C0.Y+Line.C1.Y),
                                  0.5*(Line.C0.Z+Line.C1.Z), nil, nil) then
              Result:=0
            else
              Result:=1
          end;
        end;
      else
        Result:=-1
      end;
    end;
  sdDistance:
    begin
      if SpatialElement=nil then begin
        BoundaryE:=Parent.Parent;
        AreaE:=BoundaryE.SpatialElement;
        Area:=AreaE as IArea;
        if Area.IsVertical then begin
          X:=0.5*(Area.C0.X+Area.C1.X);
          Y:=0.5*(Area.C0.Y+Area.C1.Y);
          Z:=0.5*(Area.C0.Z+Area.C1.Z);
        end else
          Area.GetCentralPoint(X, Y, Z);
      end else begin
        if SpatialElement.QueryInterface(ILine, aLine)<>0 then
          C:=SpatialElement as ICoordNode
        else
          C:=aLine.C0;
        X:=C.X;
        Y:=C.Y;
        Z:=C.Z;
      end;

      Line:=ParamE as ILine;
      if Line=nil then begin
        Result:=0;
        Exit;
      end;
      C0:=Line.C0;
      C1:=Line.C1;
      D:=sqrt(sqr(0.5*(Line.C0.X+Line.C1.X)-X)+
              sqr(0.5*(Line.C0.Y+Line.C1.Y)-Y)+
              sqr(0.5*(Line.C0.Z+Line.C1.Z)-Z));
      case Code of
      0:begin
          k:=0;
          while k<DimItems.Count do begin
            aField:=DimItems.Item[k] as IDMField;
            if (D>aField.MinValue) and
               (D<=aField.MaxValue) then
              Break
            else
              inc(k)
          end;
          Result:=k;
        end;
      1:begin
          if DimItems.Count=0 then
            Result:=3
          else begin
            AdversaryGroupW:=DimItems.Item[0] as IWarriorGroup;
            if AdversaryGroupW.Weapons.Count=0 then
              Result:=3
            else begin
              WeaponE:=AdversaryGroupW.Weapons.Item[0];
              WeaponKind:=WeaponE.Ref as IWeaponKind;

              if D<=25*100 then
                Result:=0
              else
              if D<=WeaponKind.PreciseShotDistance*100 then
                Result:=1
              else
              if D<=WeaponKind.MaxShotDistance*100 then
                Result:=2
              else
                Result:=3
            end;
          end;
        end;  
      else
        Result:=-1
      end;
    end;
  sdPostDefence:
    begin
      if ParamE.QueryInterface(IGuardGroup, GuardGroupW)=0 then
        Result:=0
      else begin
        AdversaryGroupW:=ParamE as IWarriorGroup;
        if AdversaryGroupW.Weapons.Count=0 then
          Result:=2
        else begin
          WeaponE:=AdversaryGroupW.Weapons.Item[0];
          Weapon:=WeaponE as IWeapon;
          WeaponKind:=WeaponE.Ref as IWeaponKind;

          GuardPostKind:=Ref as IGuardPostKind;
{
          aDefenceLevel:=GuardPostKind.DefenceLevel;
          aShotForce:=WeaponKind.ShotForce+1;
}

          aDefenceLevel:=FDefenceLevel;
          if (Weapon.ShotBreach<>nil) then begin
              aShotForce:=(Weapon.ShotBreach as IShotBreachRec).DemandArmour;
          end else
            aShotForce:=0;

          if aDefenceLevel<aShotForce then
            Result:=0
          else
          if aDefenceLevel=aShotForce then
            Result:=1
          else
            Result:=2
        end;
      end;
    end;
  sdCommunication:
    begin
      MinT:=InfinitValue;
      for j:=0 to FControlDevices.Count-1 do begin
        ControlDeviceE:=FControlDevices.Item[j];
        if ControlDeviceE.Ref.Parent.ID=cdtCommunication then begin
          T:=ControlDeviceE.Ref.GetFieldValue(100);
          if MinT>T then
            MinT:=T;
        end;
      end;
      k:=0;
      while k<DimItems.Count do begin
        aField:=DimItems.Item[k] as IDMField;
        if MinT=aField.DefaultValue then
          Break
        else
          inc(k)
      end;
      if k<DimItems.Count then
        Result:=k
      else
        Result:=0;
    end;
  sdTime:
    begin
      Time:=ParamF;
      k:=0;
      while k<DimItems.Count do begin
        aField:=DimItems.Item[k] as IDMField;
        if (Time>aField.MinValue) and
           (Time<=aField.MaxValue) then
          Break
        else
          inc(k)
      end;
      Result:=k;
    end;
  else
    Result:=-1
  end;
end;

function TGuardPost.PointInDetectionZone(X, Y, Z: double; const CRef, ExcludeAreaE:IDMElement): WordBool;
var
  X0, Y0, Z0, X1, Y1, Z1:double;
  C0, C1:ICoordNode;
  cosA, R, L:double;
  Line:ILine;
begin
  Result:= inherited PointInDetectionZone(X, Y, Z, CRef, ExcludeAreaE);
  if not Result then Exit;
  
  if SpatialElement=nil then begin
    Result:=False;
    Exit;
  end;
  if SpatialElement.QueryInterface(ILine, Line)=0 then begin
    C0:=Line.C0;
    C1:=Line.C1;
    L:=Line.Length;
  end else begin
    C0:=SpatialElement as ICoordNode;
    C1:=nil;
    L:=0;
  end;
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z+Get_Elevation;
  R:=sqrt(sqr(X0-X)+sqr(Y0-Y)+sqr(Z0-Z));
  
  Result:=False;
  if R>FDutyDistance/2*100 then Exit;
  Result:=True;
  if R=0 then Exit;
  if L=0 then Exit;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Y;
  cosA:=((X0-X)*(X0-X1)+(Y0-Y)*(Y0-Y1)+(Z0-Z)*(Z0-Z1))/(R*L);
  Result:=(cosA>0.5) // cosA>cos(60)
end;

procedure TGuardPost.Loaded;
begin
  inherited;
end;

function TGuardPost.GetAssessProbability: Double;
var
  j:integer;
  CommunicationDeviceE:IDMElement;
  CommunicationDevice:ICommunicationDevice;
  NoAssessProbability:double;
begin
  if InWorkingState then begin
    NoAssessProbability:=1;
    for j:=0 to FCommunicationDevices.Count-1 do begin
      CommunicationDeviceE:=FCommunicationDevices.Item[j];
      CommunicationDevice:=CommunicationDeviceE as ICommunicationDevice;
      NoAssessProbability:=NoAssessProbability*(1-CommunicationDevice.GetAssessProbability);
    end;
    Result:=1-NoAssessProbability;
  end else
     Result:=0
end;

procedure TGuardPost.Set_Selected(Value: WordBool);
var
  Analyzer:IDMAnalyzer;
  Document:IDMDocument;
  OldState:integer;
begin
  inherited;
  if Value then begin
    Document:=DataModel.Document as IDMDocument;
    Analyzer:=Document.Analyzer as IDMAnalyzer;
    if Analyzer=nil then Exit;
    OldState:=Document.State;
    try
    Analyzer.TreatElement(Self as IDMElement, 0);
    finally
      Document.State:=OldState;
    end;  
  end
end;

function  TGuardPost.GetMaxDelayDistance:double;
var
  j, i:integer;
  WarriorGroup:IWarriorGroup;
  WeaponKind:IWeaponKind;
  D:double;
begin
  Result:=0;
  for j:=0 to FWarriorGroups.Count-1 do begin
    WarriorGroup:=FWarriorGroups.Item[j] as IWarriorGroup;
    for i:=0 to WarriorGroup.Weapons.Count-1 do begin
      WeaponKind:=WarriorGroup.Weapons.Item[i].Ref as IWeaponKind;
      D:=WeaponKind.MaxShotDistance*100;   // в см
      if Result<D then
        Result:=D;
    end;
  end;
end;


function TGuardPost.DoCalcDetectionProbability(const TacticU: IInterface;
  const OvercomeMethodE: IDMElement;
  DelayTime: double; var DetP0, DetPf,
  WorkP: double; CalcAll:WordBool): double;
var
  DetP:double;
  OvercomeMethod:IOvercomeMethod;
begin
  DetP:=1;
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  if OvercomeMethod.ObserverParam then begin
    Result:=GetDistantDetection(OvercomeMethodE, DetP, DelayTime);
    DetP0:=Result;
    DetPf:=0;
    WorkP:=1;
  end else
    Result:=inherited DoCalcDetectionProbability(TacticU, OvercomeMethodE,
                         DelayTime, DetP0, DetPf, WorkP, CalcAll);
end;

procedure TGuardPost.CalcDelayTime(const TacticU: IInterface;
  out DelayTime, DelayTimeDispersion: double);
var
  C0, C1:ICoordNode;
  X0, Y0, Z0, X1, Y1, Z1:double;
  Line:ILine;
  F0, F1:boolean;
  FacilityModelS:IFMState;
  Zone0E, Zone1E:IDMElement;
begin
  DelayTime:=0;
  DelayTimeDispersion:=0;
  if not IsPresent then Exit;
  if SpatialElement=nil then
    inherited
  else begin
    FacilityModelS:=DataModel as IFMState;
    Line:=FacilityModelS.CurrentLineU as ILine;
    Zone0E:=FacilityModelS.CurrentZone0U as IDMElement;
    Zone1E:=FacilityModelS.CurrentZone1U as IDMElement;
    C0:=Line.C0;
    C1:=Line.C1;
    X0:=C0.X;
    Y0:=C0.Y;
    Z0:=C0.Z;
    X1:=C1.X;
    Y1:=C1.Y;
    Z1:=C1.Z;
    F0:=PointInDetectionZone(X0, Y0, Z0, Zone0E, nil);
    F1:=PointInDetectionZone(X1, Y1, Z1, Zone1E, nil);
{
    if F0 and not F1 then
     inherited
    else
    if F1 and not F0 then
}    
    if F1 or F0 then
      inherited
    else begin
      DelayTime:=0;
      DelayTimeDispersion:=0;
      FCurrOvercomeMethod:=nil;
    end;
  end;  
end;

function TGuardPost.GetElevation: double;
begin
  Result:=Get_Elevation // +100; ???????
end;

function TGuardPost.InWorkingState: WordBool;
begin
  Result:=inherited InWorkingState;
  if Result then begin
    Result:=(FWarriorGroups.Count>0)
  end;
end;

function TGuardPost.DoCalcDelayTime(
  const OvercomeMethodE: IDMElement): double;
var
  OvercomeMethod:IOvercomeMethod;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  WarriorGroup:IWarriorGroup;
  AnalysisVariant:IAnalysisVariant;
  ln:ILine;
  T, B:Double;
  Unk:IUnknown;
  AdversaryCount,m:Integer;
  Mem, Rec:PBattleRecord;
begin
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;

  if OvercomeMethod.ObserverParam then
    Result:=GetObservationPeriod(0)*1.61 // ln(0.2)=-1.61
  else begin
    FacilityModel:=DataModel as IFacilityModel;
    if (OvercomeMethod.DelayProcCode = dpcGuard) then begin

      FacilityModelS:=FacilityModel as IFMState;
      AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
      WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;
      if (WarriorGroup.QueryInterface(IAdversaryGroup, Unk)=0)and
         (FWarriorGroups.Count>0) then begin
        if (True) then begin //(FacilityModel.UseSimpleBattleModel) then begin
          ln := FacilityModelS.CurrentLineU as ILine;
          m:=0;
          while m<FBattleList.Count do begin
            Rec:=FBattleList[m];
            if (IWarriorGroup(Rec.MainGroup) = WarriorGroup)and
               (Rec.Count = FWarriorGroups.Count) then
              Break
            else
              inc(m)
          end;
          if m=FBattleList.Count then begin
            LocalBattleModel2(B, T, AdversaryCount,
                             WarriorGroup,
                             FWarriorGroups,
                             DataModel);
            GetMem(Mem, SizeOf(TBattleRecord));
            FBattleList.Add(Mem);
            Mem.MainGroup:=Pointer(WarriorGroup);
            Mem.Count:=FWarriorGroups.Count;
            Mem.B:=B;
            Mem.T:=T;
            Mem.X0:=ln.C0.X; Mem.Y0:=ln.C0.Y; Mem.Z0:=ln.C0.Z;
            Mem.X1:=ln.C1.X; Mem.Y1:=ln.C1.Y; Mem.Z1:=ln.C1.Z;
          end else begin
            Rec:=FBattleList[m];
            B:=Rec.B;
            T:=Rec.T;
          end;

        end else begin //not UseSimpleBattleModel
          ln := FacilityModelS.CurrentLineU as ILine;
          m:=0;
          while m<FBattleList.Count do begin
            Rec:=FBattleList[m];
            if (IWarriorGroup(Rec.MainGroup) = WarriorGroup)and
               (Rec.Count = FWarriorGroups.Count)and
               (((Rec.X0=ln.C0.X) and (Rec.Y0=ln.C0.Y) and (Rec.Z0=ln.C0.Z) and
                 (Rec.X1=ln.C1.X) and (Rec.Y1=ln.C1.Y) and (Rec.Z1=ln.C1.Z))or
                ((Rec.X1=ln.C0.X) and (Rec.Y1=ln.C0.Y) and (Rec.Z1=ln.C0.Z) and
                 (Rec.X0=ln.C1.X) and (Rec.Y0=ln.C1.Y) and (Rec.Z0=ln.C1.Z))) then
              Break
            else
              inc(m)
          end;
          if m=FBattleList.Count then begin
            LocalBattleModel2(B, T, AdversaryCount,
                             WarriorGroup,
                             FWarriorGroups,
                             DataModel);
            GetMem(Mem, SizeOf(TBattleRecord));
            FBattleList.Add(Mem);
            Mem.MainGroup:=Pointer(WarriorGroup);
            Mem.Count:=FWarriorGroups.Count;
            Mem.B:=B;
            Mem.T:=T;
            Mem.X0:=ln.C0.X; Mem.Y0:=ln.C0.Y; Mem.Z0:=ln.C0.Z;
            Mem.X1:=ln.C1.X; Mem.Y1:=ln.C1.Y; Mem.Z1:=ln.C1.Z;
          end else begin
            Rec:=FBattleList[m];
            B:=Rec.B;
            T:=Rec.T;
          end;
        end;//EndUseSimpleBattleModel

        if (B = 1) then
          Result:=InfinitValue
        else
          Result:=T;
      end;
    end else
      Result:=inherited DoCalcDelayTime(OvercomeMethodE);
  end;
end;

function TGuardPost.ShowInLayerName: WordBool;
begin
  Result:=True
end;

function TGuardPost.Get_CommunicationDevices: IDMCollection;
begin
  Result:=FCommunicationDevices
end;

function TGuardPost.Get_Parents: IDMCollection;
begin
   Result:=FParents
end;

function TGuardPost.Get_ControledByInsider: integer;
var
  FacilityModelS:IFMState;
  AnalysisVariant:IAnalysisVariant;
  AdversaryVariant:IAdversaryVariant;
  j, N:integer;
  aGuardPostAccessE, SelfE:IDMElement;
  GuardPostAccesses2:IDMCollection2;
  aGuardPostAccess:IAccess;
  AdversaryGroupW, GuardGroupW:IWarriorGroup;
begin
  SelfE:=Self as IDMElement;
  FacilityModelS:=DataModel as IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  AdversaryVariant:=AnalysisVariant.AdversaryVariant as IAdversaryVariant;
  GuardPostAccesses2:=(AdversaryVariant.GuardPostAccesses as IDMCollection2);
  aGuardPostAccessE:=GuardPostAccesses2.GetItemByRef(SelfE);
  if aGuardPostAccessE=nil then
    Result:=0
  else begin
    N:=0;
    for j:=0 to FWarriorGroups.Count-1 do begin
      GuardGroupW:=FWarriorGroups.Item[j] as IWarriorGroup;
      N:=N+GuardGroupW.InitialNumber;
    end;
    aGuardPostAccess:=aGuardPostAccessE as IAccess;
    AdversaryGroupW:=aGuardPostAccessE.Parent as IWarriorGroup;
    if (AdversaryGroupW.InitialNumber>=N) then
      Result:=2
    else
      Result:=1;
  end;
end;

function TGuardPost.Get_DutyDistance: double;
begin
  Result:=FDutyDistance
end;

procedure TGuardPost.Set_Ref(const Value: IDMElement);
begin
  inherited;
end;

function TGuardPost.Get_DefenceLevel: integer;
begin
  Result:=FDefenceLevel
end;

function TGuardPost.Get_HidedDefenceState: integer;
begin
  Result:=FHidedDefenceState
end;

function TGuardPost.Get_OpenedDefenceState: integer;
begin
  Result:=FOpenedDefenceState
end;

function TGuardPost.Get_Width: Double;
begin
  Result:=1 // ƒл€ того, чтобы не отрисовывалс€ слой рубежа, на котором стоит пост контролера
end;

procedure TGuardPost.AfterLoading2;
begin
  inherited;
end;

function TGuardPost.GetObservationKind(Distance: double): integer;
begin
  if (Distance>0) and (Distance<=GetMaxDelayDistance*100) then
    Result:=obsGuardPostDelay
  else
    Result:=obsGuardPost
end;

{ TGuardPosts }

class function TGuardPosts.GetElementClass: TDMElementClass;
begin
  Result:=TGuardPost;
end;

class function TGuardPosts.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardPost
end;

function TGuardPosts.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsGuardPost
  else
    Result:=rsGuardPosts
end;

function TGuardPost.GetObservationPeriod(Distance:double):double;
var
  SafeguardDatabase:ISafeguardDatabase;
  OvercomeMethod:IOvercomeMethod;
  T100, DutyDistance2:double;
  Line, theLine:ILine;
  C0, C1, C:ICoordNode;
  XX, YY, ZZ, X, Y, Z, D2, X0, Y0, Z0, X1, Y1, Z1:double;
  FacilityModelS:IFMState;
  WarriorGroupE, LineE, C0Ref, C1Ref, C0E, C1E:IDMElement;
  F0, F1:boolean;
  BoundaryLayer:IBoundaryLayer;
begin
  Result:=-1;

  if Parent.ClassID=_BoundaryLayer then begin
    Result:=Get_DutyDistance/1.2;   //1.2 м/с~4.3 км/ч
    if Result=0 then
      Result:=1;
  end;

  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;

  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  LineE:=FacilityModelS.CurrentLineU as IDMElement;

  OvercomeMethod:=(Ref as IObserverKind).ObservationMethod;

  if OvercomeMethod<>nil then begin
    if not OvercomeMethod.ObserverParam then Exit;
    T100:=OvercomeMethod.GetValueFromMatrix(WarriorGroupE, Self as IDMElement,
               LineE, 0, mvkProbability, nil)
  end else
    T100:=0;

  if Distance>0 then
    D2:=Distance*Distance
  else begin
    if (LineE<>nil) and
       (SpatialElement<>nil) then begin
      Line:=LineE as ILine;
      C0:=Line.C0;
      C1:=Line.C1;
      X0:=C0.X;
      Y0:=C0.Y;
      Z0:=C0.Z;
      X1:=C1.X;
      Y1:=C1.Y;
      Z1:=C1.Z;
  
      XX:=0.5*(X0+X1);
      YY:=0.5*(Y0+Y1);
      ZZ:=0.5*(Z0+Z1);
  
      C0E:=C0 as IDMElement;
      C1E:=C1 as IDMElement;
      C0Ref:=C0E.Ref;
      C1Ref:=C1E.Ref;
      F0:=PointInDetectionZone(X0, Y0, Z0, C0Ref, nil);
      F1:=PointInDetectionZone(X1, Y1, Z1, C1Ref, nil);
      if (not F0) and (not F1) then Exit;
      if SpatialElement.QueryInterface(ILine, theLine)=0 then
          C:=theLIne.C0
      else
        C:=SpatialElement as ICoordNode;
      X:=C.X;
      Y:=C.Y;
      Z:=C.Z;
      D2:=sqr(XX-X)+sqr(YY-Y)+sqr(ZZ-Z);
      Result:=T100*D2/100000000;     //  (D/100 м)^2
    end else begin //  if (LineE=nil) or (SpatialElement=nil)
      if (Parent<>nil) and
         (Parent.ClassID=_BoundaryLayer) then begin
        BoundaryLayer:=Parent as IBoundaryLayer;
        X0:=BoundaryLayer.X0;
        Y0:=BoundaryLayer.Y0;
        X1:=BoundaryLayer.X1;
        Y1:=BoundaryLayer.Y1;
        D2:=(sqr(X1-X0)+sqr(Y1-Y0))/4;
        DutyDistance2:=sqr(FDutyDistance/2*100);
        if (D2=0) or
           (D2>DutyDistance2) then
          D2:=DutyDistance2;
      end else begin
        FacilityModelS.CurrentSafeguardElementU:=Self as IUnknown;
        D2:=sqr(FacilityModelS.CurrentDistance*100);
      end;
    end;  //  if (LineE=nil) or (SpatialElement=nil)
  end;  // if Distance<=0
  Result:=T100*D2/100000000;     //(D/100 м)^2
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TGuardPost.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
