unit SafeguardElementU;

interface
uses
  Classes, SysUtils, Math,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomSafeguardElementU, Variants;

type
  PMethodCashRecord=^TMethodCashRecord;
  TMethodCashRecord=record
    OvercomeMethod:pointer;
    DetP0:double;
  end;

  TSafeguardElement=class(TCustomSafeguardElement, ISafeguardElement,
            IMethodDimItemSource, IPathNodeArray, IDMReporter, ICoord,
            IGoods)
  private
    FPresence:integer;
    FDeviceCount:integer;
    FInstallCoeff:double;

    FParents:IDMCollection;
    FSpatialElement:IDMElement;

    FPathNodes:IDMCollection;

    FSMLabel:IDMElement;

    FBestOvercomeMethod:pointer;

    FParameterValues:IDMCollection;

    function FindCashRecord(const OvercomeMethodE:IDMElement): PMethodCashRecord;
    function CalcNoGlassSoundDetection(const TacticU:IUnknown;
                    const aCollection,  PhysicalFields: IDMCollection): double;


  protected
    FDeviceState0:Variant;
    FDeviceState1:Variant;
    FSymbolDX:double;
    FSymbolDY:double;
    FElevation:double;
    FCurrOvercomeMethod:pointer;

    FMethodCashRecordList:TList;

    function GetParameterValues: IDMCollection; override;

    function Get_Field(Index: integer): IDMField; override; safecall;
    function Get_FieldCount: integer;  override; safecall;

    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class procedure MakeFields1; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    procedure AfterLoading2; override; safecall;
    procedure AfterCopyFrom(const SourceElement:IDMElement); override; safecall;
    procedure Redraw(DrawSelected:integer);
    procedure Set_Selected(Value:WordBool); override; safecall;

    function IsPresent: WordBool; safecall;
    function  InWorkingState:WordBool; virtual; safecall;
    function  CalcWorkProbability:double; virtual;

    function  Get_UserDefineded: WordBool; override; safecall;
    function Get_Parents:IDMCollection; override;
    procedure CalculateFieldValues; override;

    procedure Set_Ref(const Value:IDMElement); override;
    procedure Set_Parent(const Value:IDMElement); override;
    function  Get_SpatialElement:IDMElement; override; safecall;
    procedure Set_SpatialElement(const Value: IDMElement); override; safecall;
    procedure _AddBackRef(const Value:IDMElement); override; safecall;
    procedure _RemoveBackRef(const Value:IDMElement); override; safecall;
    function  Get_MainParent: IDMElement; override; safecall;

    procedure CalcDelayTime(const TacticU:IUnknown;
                            out dT, dTDisp:double); virtual; safecall;
//           метод, возвращающий врем€ задержки нарушител€ заданного типа
//           при заданном состо€нии системы защиты
//           на средстве охраны
    procedure CalcDetectionProbability(const TacticU:IUnknown;
                                       out DetP, BestTime:double); virtual; safecall;
//           переопределенный метод, возвращающий веро€тность
//           необнаружени€ нарушител€ заданного типа при заданно состо€нии
//           системы защиты на данном элементе защиты
    procedure CalcParams(const TacticU: IUnknown; ObservationPeriod:double;
                         out dTFast, dTDispFast, NoDetPFast, NoDetP1Fast,
                             dTStealth, dTDispStealth, NoDetPStealth, NoDetP1Stealth: Double;
                         out OvercomeMethodFastE, OvercomeMethodStealthE: IDMElement); safecall;
    function DoCalcDelayTime(const OvercomeMethodE:IDMElement):double; virtual; safecall;
    function DoCalcDetectionProbability(const TacticU:IUnknown;
                          const OvercomeMethodE:IDMElement;
                          DelayTime:double;
                          var DetP0, DetPf, WorkP:double;
                          CalcAll:WordBool):double; virtual; safecall;
    procedure CalcPhysicalFields(const OvercomeMethodE:IDMElement); virtual; safecall;
    function AcceptableMethod(const OvercomeMethodE:IDMElement): WordBool; safecall;


    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    function Get_CurrOvercomeMethod: IDMElement; safecall;
    procedure Set_CurrOvercomeMethod(const Value: IDMElement); safecall;
    function Get_BestOvercomeMethod: IDMElement; safecall;
    procedure Set_BestOvercomeMethod(const Value: IDMElement); safecall;
    function Get_DeviceState0: IDMElement;
    procedure Set_DeviceState0(const Value: IDMElement);
    function Get_DeviceState1: IDMElement;
    procedure Set_DeviceState1(const Value: IDMElement);
    procedure CalcSoundPower(const OvercomeMethod:IOvercomeMethod);
    function Get_PathNodes:IDMCollection; safecall;
    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; virtual; safecall;
    function Get_Elevation: double; safecall;
    procedure Set_Elevation(const Value: double); safecall;
    function Get_SymbolDX:double; safecall;
    function Get_SymbolDY:double; safecall;

    procedure Clear; override;
    procedure ClearOp; override; safecall;

    function  Get_Presence:integer; override; safecall;
    procedure Set_Presence(Value: Integer); override; safecall;
    function  Get_DeviceCount:integer; safecall;
    procedure Set_DeviceCount(Value: Integer); safecall;
    function  Get_InstallCoeff:double; safecall;
    procedure Set_InstallCoeff(Value:double); safecall;

    function  Get_SMLabel:IDMElement; safecall;
    procedure Set_SMLabel(const Value:IDMElement); virtual; safecall;
    function  Get_Font: ISMFont; safecall;
    procedure Set_Font(const Value: ISMFont); safecall;
    function  Get_LabelScaleMode: Integer; safecall;
    procedure Set_LabelScaleMode(Value: Integer); safecall;
    function  Get_LabelVisible: WordBool; safecall;
    procedure Set_LabelVisible(Value: WordBool); virtual; safecall;
    function  ShowInLayerName: WordBool; virtual; safecall;
    function  Get_DetectionPosition:integer; virtual; safecall;
    function  WorksInDirection(DirectPathFlag:boolean):WordBool; virtual; safecall;

    function  CompartibleWith(const aElement:IDMElement):WordBool; override; safecall;

    procedure ClearCash; safecall;
    function GetRotationAngle:double; virtual;

// ICoord
   function Get_X:double; safecall;
   function Get_Y:double; safecall;
   function Get_Z:double; safecall;
   procedure Set_X(Value:double); safecall;
   procedure Set_Y(Value:double); safecall;
   procedure Set_Z(Value:double); safecall;
   procedure GetCoord(var X0, Y0, Z0:double); virtual; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TSafeguardElements=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  FacilityModelConstU, OutstripU,
  CalcDetectionProbabilityLib,
  ElementParameterValueU;

var
  FFields:IDMCollection;

{ TSafeguardElement }

procedure TSafeguardElement.Initialize;
var
  SelfE:IDMElement;
begin
  FParameterValues:=DataModel.CreateCollection(_ElementPArameterValue, Self as IDMElement);
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);
  FPathNodes:=DataModel.CreateCollection(-1, SelfE);
  FStates:=DataModel.CreateCollection(_SafeguardElementState, SelfE);
  FMethodCashRecordList:=TList.Create;

  FSymbolScaleFactor:=1;
end;

procedure TSafeguardElement._Destroy;
begin
  FParameterValues:=nil;
  inherited;
  FStates:=nil;
  FPathNodes:=nil;
  FCurrOvercomeMethod:=nil;
  FBestOvercomeMethod:=nil;
  ClearCash;
  FMethodCashRecordList.Free;
end;

procedure TSafeguardElement.Clear;
begin
  if SpatialElement<>nil then
    ((DataModel as IDMElement).Collection[SpatialElement.Get_ClassID] as IDMCollection2).Remove(SpatialElement);
  inherited;
end;

procedure TSafeguardElement.CalcDelayTime(const TacticU:IUnknown;
                                          out dT, dTDisp:double);
var
  SafeguardElementType:ISafeguardElementType;
  OvercomeMethodE:IDMElement;
  OvercomeMethod:IOvercomeMethod;
  WarriorGroup:IWarriorGroup;
  j:integer;
  T, MinTime:double;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  DelayTimeDispersionRatio:double;
  SafeguardDatabase:ISafeguardDatabase;
begin
  try
  dT:=0;
  dTDisp:=0;
  FCurrOvercomeMethod:=nil;

  if Ref=nil then Exit;
  if Ref.Parent=nil then Exit;
  if not IsPresent then Exit;
  if not InWorkingState then Exit;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  FCurrOvercomeMethod:=nil;
  if Get_UserDefinedDelayTime then begin
    SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;
    OvercomeMethodE:=SafeguardDatabase.USerDefinedValueMethod;
    Set_CurrOvercomeMethod(OvercomeMethodE);
    dT:=Get_DelayTime;
    dTDisp:=sqr(DelayTimeDispersionRatio*dT);
    Exit;
  end;

  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;
  SafeguardElementType:=Ref.Parent as ISafeguardElementType;

  MinTime:=InfinitValue/1000;
  FCurrOvercomeMethod:=nil;
  for j:=0 to SafeguardElementType.OvercomeMethods.Count-1 do begin
    OvercomeMethodE:=SafeguardElementType.OvercomeMethods.Item[j];
    OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
    if OvercomeMethod.AcceptableForTactic(TacticU) and
      AcceptableMethod(OvercomeMethodE) and
      WarriorGroup.AcceptableMethod(OvercomeMethodE) then begin

      T:=DoCalcDelayTime(OvercomeMethodE);

      if MinTime>T then begin
        MinTime:=T;
        Set_CurrOvercomeMethod(OvercomeMethodE);
        if MinTime=0 then
          Break;
      end;
    end;
  end;
  dT:=MinTime;
  dTDisp:=sqr(DelayTimeDispersionRatio*MinTime);
  except
    DataModel.HandleError(Format
    ('Error in CalcDelayTime. SafeguardElementID=%d ClassID=%d',[ID, ClassID]))
  end;
end;



procedure TSafeguardElement.CalcDetectionProbability(
                            const TacticU:IUnknown;
                            out DetP, BestTime:double);
var
  SafeguardElementType:ISafeguardElementType;
  OvercomeMethodE:IDMElement;
  OvercomeMethod:IOvercomeMethod;
  j:integer;
  T, NoDetP, MaxNoDetP:double;
  DisableDetection:boolean;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  WarriorGroup:IWarriorGroup;
  aDetP, DetP0, DetPf,WorkP:double;
  SafeguardDatabase:ISafeguardDatabase;
  InsiderTarget:IInsiderTarget;
begin
  DetP:=0;
  FCurrOvercomeMethod:=nil;

  if Ref=nil then Exit;
  if Ref.Parent=nil then Exit;
  if not IsPresent then Exit;
  if not InWorkingState then Exit;
  if QueryInterface(IInsiderTarget, InsiderTarget)=0 then begin
    if InsiderTarget.ControledByInsider=2 then // пост поголовно подкуплен
      Exit
  end;

  if Get_UserDefinedDetectionProbability then begin
    SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;
    OvercomeMethodE:=SafeguardDatabase.USerDefinedValueMethod;
    Set_CurrOvercomeMethod(OvercomeMethodE);
    DetP:=Get_DetectionProbability;
    BestTime:=0;
    Exit;
  end;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;

  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;
  SafeguardElementType:=Ref.Parent as ISafeguardElementType;

  MaxNoDetP:=-1;
  BestTime:=InfinitValue;
  FCurrOvercomeMethod:=nil;
  for j:=0 to SafeguardElementType.OvercomeMethods.Count-1 do begin
    OvercomeMethodE:=SafeguardElementType.OvercomeMethods.Item[j];

    OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
    if OvercomeMethod.AcceptableForTactic(TacticU) and
       AcceptableMethod(OvercomeMethodE) and
       WarriorGroup.AcceptableMethod(OvercomeMethodE) then begin

      if FacilityModelS.DelayFlag then
        T:=DoCalcDelayTime(OvercomeMethodE)
      else
        T:=0;

      if T>=InfinitValue/1000 then begin
        NoDetP:=0;
      end else begin
        DisableDetection:=False;
        if not DisableDetection then begin
          aDetP:=DoCalcDetectionProbability(TacticU, OvercomeMethodE, T,
                            DetP0, DetPf, WorkP, False);
          NoDetP:=1-aDetP;
        end else
          NoDetP:=1;
      end;

      if MaxNoDetP<NoDetP then begin
        MaxNoDetP:=NoDetP;
        BestTime:=T;
        Set_CurrOvercomeMethod(OvercomeMethodE);
      end else
      if MaxNoDetP=NoDetP then begin
        if BestTime>T then begin
          MaxNoDetP:=NoDetP;
          BestTime:=T;
          Set_CurrOvercomeMethod(OvercomeMethodE);
          if MaxNoDetP=1 then
            Break
        end;
      end;
    end;
  end;
  if MaxNoDetP>0 then
    DetP:=1-MaxNoDetP
  else
    DetP:=1;
end;

function TSafeguardElement.Get_CurrOvercomeMethod: IDMElement;
begin
   Result:=IDMElement(FCurrOvercomeMethod);
end;

procedure TSafeguardElement.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  SafeguardElementType:ISafeguardElementType;
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  aCollection:=nil;
  if Ref=nil then Exit;
  theCollection:=nil;
  SafeguardElementType:=Ref.Parent as ISafeguardElementType;
  case Code of
  ord(seDeviceState0),
  ord(seDeviceState1):
    theCollection:=SafeguardElementType.DeviceStates;
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
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

function TSafeguardElement.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

function TSafeguardElement.Get_DeviceState0: IDMElement;
var
  Unk:IUnknown;
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=(State as ISafeguardElementState).DeviceState0
  else begin
    Unk:=FDeviceState0;
    Result:=Unk as IDMElement
  end
end;

function TSafeguardElement.Get_DeviceState1: IDMElement;
var
  Unk:IUnknown;
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=(State as ISafeguardElementState).DeviceState1
  else begin
    Unk:=FDeviceState1;
    Result:=Unk as IDMElement
  end
end;

procedure TSafeguardElement.Set_DeviceState0(
  const Value: IDMElement);
var
  Unk:IUnknown;
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    (State as ISafeguardElementState).DeviceState0:=Value
  else begin
    Unk:=Value as IUnknown;
    FDeviceState0:=Unk;
  end;
end;

procedure TSafeguardElement.Set_DeviceState1(
  const Value: IDMElement);
var
  Unk:IUnknown;
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    (State as ISafeguardElementState).DeviceState1:=Value
  else begin
    Unk:=Value as IUnknown;
    FDeviceState1:=Unk;
  end;
end;

function TSafeguardElement.AcceptableMethod(
  const OvercomeMethodE: IDMElement): WordBool;
var
  OvercomeMethod:IOvercomeMethod;
  FacilityModelS:IFMState;
begin
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  if OvercomeMethod.DeviceStates.Count>0 then begin
    FacilityModelS:=DataModel as IFMState;
    if FacilityModelS.CurrentDirectPathFlag then
      Result:=OvercomeMethod.DeviceStates.IndexOf(Get_DeviceState0)<>-1
    else
      Result:=OvercomeMethod.DeviceStates.IndexOf(Get_DeviceState1)<>-1
  end else
    Result:=True
end;

function TSafeguardElement.Get_CollectionCount: integer;
begin
    Result:=1
end;

procedure TSafeguardElement.Set_Ref(const Value: IDMElement);
var
  SafeguardElementType:ISafeguardElementType;
  SafeguardElementTypeM:IModelElementType;
  Price:IPrice;
  OperationManager:IDMOperationManager;
  ElementParameterValues:IDMCollection;
  aParameter:IDMElement;
  j:integer;
  ParameterValueU, SelfU:IUnknown;
begin
  inherited;
  if Value=nil then Exit;
  try
  Price:=Ref as IPrice;
  except
    raise
  end;  

  FInstallCoeff:=Price.InstallCoeff;

  if DataModel.IsCopying then Exit;
  if DataModel.IsLoading then Exit;

  SafeguardElementType:=Ref.Parent as ISafeguardElementType;
  if SafeguardElementType=nil then Exit;

  if SafeguardElementType.DeviceStates.Count>0 then begin
    Set_DeviceState0(SafeguardElementType.DeviceStates.Item[0]);
    Set_DeviceState1(SafeguardElementType.DeviceStates.Item[0]);
  end;

  SafeguardElementTypeM:=SafeguardElementType as  IModelElementType;

  SelfU:=Self as IUnknown;
  OperationManager:=DataModel.Document as IDMOperationManager;
  ElementParameterValues:=(DataModel as IDMElement).Collection[_ElementParameterValue];
  for j:=0 to SafeguardElementTypeM.ElementParameters.Count-1 do  begin
    aParameter:=SafeguardElementTypeM.ElementParameters.Item[j];
    OperationManager.AddElementRef(
        SelfU, ElementParameterValues, '',
        aParameter, ltOneToMany, ParameterValueU, True);
  end;

end;

function TSafeguardElement.Get_SpatialElement: IDMElement;
begin
  Result:=FSpatialElement
end;

procedure TSafeguardElement.Set_SpatialElement(const Value: IDMElement);
begin
  FSpatialElement := Value;
end;

procedure TSafeguardElement._AddBackRef(const Value: IDMElement);
begin
  if Value.DataModel<>DataModel then Exit;
  if Value.Parent=nil then Exit;
  
  if Value.ClassID=_SMLabel then
    Set_SMLabel(Value)
  else
  if Value.ClassID=_CoordNode then
    Set_SpatialElement(Value)
  else
  if Value.ClassID=_Line then
    Set_SpatialElement(Value);
end;

function TSafeguardElement.GetFieldValue(Code: integer): OleVariant;
var
  j:integer;
begin
  case Code of
  ord(seDeviceState0):
    Result:=FDeviceState0;
  ord(seDeviceState1):
    Result:=FDeviceState1;
  ord(cnstDeviceCount):
    Result:=FDeviceCount;
  ord(cnstPresence):
    Result:=FPresence;
  ord(cnstInstallCoeff):
    Result:=FInstallCoeff;
  ord(cnstSymbolDX):
    Result:=FSymbolDX;
  ord(cnstSymbolDY):
    Result:=FSymbolDY;
  else
    begin
      j:=0;
      while j<FParameterValues.Count do
      if (FParameterValues.Item[j].Ref as IDMField).Code=Code then
        Break
      else
        inc(j);
      if j<FParameterValues.Count then
        Result:=(FParameterValues.Item[j] as IDMParameterValue).Value
      else
        Result:=inherited GetFieldValue(Code)
    end
  end;
end;

procedure TSafeguardElement.SetFieldValue(Code:integer; Value:OleVariant);
var
  j:integer;
begin
  case Code of
  ord(seDeviceState0):
    begin
      SetUnkValue(FDeviceState0, Value);
      SetUnkValue(FDeviceState1, Value);
    end;
  ord(seDeviceState1):
    SetUnkValue(FDeviceState1, Value);
  ord(cnstDeviceCount):
    FDeviceCount:=Value;
  ord(cnstPresence):
    FPresence:=Value;
  ord(cnstInstallCoeff):
    FInstallCoeff:=Value;
  ord(cnstSymbolDX),
  ord(cnstSymbolDY):
    begin
      Redraw(-1);
      case Code of
      ord(cnstSymbolDX):
        FSymbolDX:=Value;
      ord(cnstSymbolDY):
        FSymbolDY:=Value;
      end;
      Redraw(1);
    end;
  else
    begin
      j:=0;
      while j<FParameterValues.Count do
        if (FParameterValues.Item[j].Ref as IDMField).Code=Code then
          Break
        else
          inc(j);
      if j<FParameterValues.Count then
        (FParameterValues.Item[j] as IDMParameterValue).Value:=Value
      else
        inherited
    end;
  end;
end;

class function TSafeguardElement.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TSafeguardElement.MakeFields0;
begin
  AddField(rsDeviceState0, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(seDeviceState0), 0, pkInput);
  AddField(rsDeviceState1, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(seDeviceState1), 0, pkInput);
  inherited;
end;

class procedure TSafeguardElement.MakeFields1;
var
  S:WideString;
begin
  S:='|'+'—нимаетс€ на 3-м этапе модернизации'+
     '|'+'—нимаетс€ на 2-м этапе модернизации'+
     '|'+'—нимаетс€ на 1-м этапе модернизации'+
     '|'+'”становлен в исходном состо€нии —‘«'+
     '|'+'ƒобавл€етс€ на 1-м этапе модернизации'+
     '|'+'ƒобавл€етс€ на 2-м этапе модернизации'+
     '|'+'ƒобавл€етс€ на 3-м этапе модернизации';
  AddField(rsPresence, S, '', '',
                 fvtChoice, 0, -3, +3,
                 ord(cnstPresence), 0, pkInput);
  AddField(rsDeviceCount, '%d', '', '',
                 fvtInteger, 1, 0, 0,
                 ord(cnstDeviceCount), 0, pkPrice);
  AddField(rsInstallCoeff, '%0.2f', '', '',
                 fvtFloat, 1, 0, 0,
                 ord(cnstInstallCoeff), 0, pkPrice);
  AddField(rsSymbolDX, '%0.2f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstSymbolDX), 0, pkView);
  AddField(rsSymbolDY, '%0.2f', '', '',
           fvtFloat, 0, 0, 0,
           ord(cnstSymbolDY), 0, pkView);
  inherited;
end;

function TSafeguardElement.DoCalcDelayTime(const OvercomeMethodE: IDMElement): double;
var
  OvercomeMethod:IOvercomeMethod;
  FacilityModelS:IFMState;
  WarriorGroupU, FacilityStateU, LineU, SelfU:IUnknown;
  V, L:double;
begin
  Result:=0;
  if Ref=nil then Exit;
  if not IsPresent then Exit;

  FacilityModelS:=DataModel as IFMState;
  WarriorGroupU:=FacilityModelS.CurrentWarriorGroupU;
  FacilityStateU:=FacilityModelS.CurrentFacilityStateU;
  LineU:=FacilityModelS.CurrentLineU;
  SelfU:=Self as IUnknown;
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;

  Result:=InfinitValue/1000;
  if OvercomeMethod=nil then Exit;
  case OvercomeMethod.DelayProcCode of
  longint(dpcCodeMatrix):
    begin
      Result:=OvercomeMethod.GetValueByCodeFromMatrix(WarriorGroupU, SelfU,
                                              LineU, 0, mvkDelay, nil);
      if Result=-InfinitValue then
        Result:=InfinitValue
    end;
  longint(dpcMatrix):
    Result:=OvercomeMethod.GetValueFromMatrix(WarriorGroupU, SelfU,
                                              LineU, 0, mvkDelay, nil);
  longInt(dpcExternal):
    Result:=OvercomeMethod.GetDelayTime(WarriorGroupU, FacilityStateU, LineU,
                                        SelfU, nil);
  longint(dpcZero):
    Result:=0;
  longint(dpcInfinit):
    Result:=InfinitValue/1000;
  longint(dpcVelocityCodeMatrix):
    begin
      V:=OvercomeMethod.GetValueByCodeFromMatrix(WarriorGroupU, SelfU,
                                              LineU, 0, mvkDelay, nil);
      if V=-InfinitValue then
        V:=0;                           // в м/с
       if LineU<>nil then
         L:=(LineU as ILine).Length/100 // в метрах
       else
         L:=1;
       if V=0 then
         Result:=InfinitValue
       else
         Result:=L/V;
    end;
  longint(dpcVelocityMatrix):
    begin
      V:=OvercomeMethod.GetValueFromMatrix(WarriorGroupU, SelfU,
                                              LineU, 0, mvkDelay, nil);
      if V=-InfinitValue then
        V:=0;                           // в м/с
       if LineU<>nil then
         L:=(LineU as ILine).Length/100 // в метрах
       else
         L:=1;
       if V=0 then
         Result:=InfinitValue
       else
         Result:=L/V;
    end;
  longint(dpcMinimum):
    Result:=1;
  else
      Result:=0;
  end;
end;

function CalcNoPatrolDetection(const ZoneE:IDMElement;
                     T:double):double; safecall;
var
  PatrolPeriod:double;
  Zone:IZone;
begin
    Result:=1;
    if ZoneE=nil then Exit;
    Zone:=ZoneE as IZone;
    PatrolPeriod:=(Zone as IFacilityElement).PatrolPeriod;
    if PatrolPeriod=InfinitValue then Exit;
    if PatrolPeriod=0 then Exit;
    Result:=exp(-T/PatrolPeriod);
end;


function TSafeguardElement.CalcNoGlassSoundDetection(const TacticU:IUnknown; 
                const aCollection, PhysicalFields:IDMCollection):double;
var
  m:integer;
  DistantDetectionElement:ISafeguardElement;
  DetP, BestTime:double;
begin
  Result:=1;
  for m:=0 to aCollection.Count-1 do begin
    if aCollection.Item[m]<>Self as IDMElement then begin
      DistantDetectionElement:=aCollection.Item[m].Ref as ISafeguardElement;
      DistantDetectionElement.CalcDetectionProbability(TacticU,
                                     DetP, BestTime);
      Result:=Result*(1-DetP);
    end;
  end;
end;


function TSafeguardElement.DoCalcDetectionProbability(const TacticU:IUnknown;
                          const OvercomeMethodE: IDMElement;
                          DelayTime:double;
                          var DetP0, DetPf, WorkP:double;
                          CalcAll:WordBool): double;
var
  Tactic:ITactic;
  DetP, NoDetP, NoDetP0:double;
  OvercomeMethod:IOvercomeMethod;
  WarriorGroupU, FacilityStateU, LineU, SelfU:IUnknown;
  BoundaryLayer:IBoundaryLayer;
  Boundary:IBoundary;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  k:integer;
  DetectionElementKind:IDetectionElementKind;
  MethodCashRecord:PMethodCashRecord;
  BarrierKind:IBarrierKind;
label DetP_equ_1;

begin
  Result:=0;
  DetP0:=0;
  DetPf:=0;
  WorkP:=0;
  if Ref=nil then Exit;
  if not IsPresent then Exit;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  WarriorGroupU:=FacilityModelS.CurrentWarriorGroupU;
  FacilityStateU:=FacilityModelS.CurrentFacilityStateU;
  LineU:=FacilityModelS.CurrentLineU;
  SelfU:=Self as IUnknown;
  Tactic:=TacticU as ITactic;

  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  if OvercomeMethod.DependsOnReliability then
    WorkP:=CalcWorkProbability
  else
    WorkP:=1;

  try
  DetP0:=1;
  if OvercomeMethod=nil then Exit;
  case OvercomeMethod.ProbabilityProcCode of
  longint(ppcMatrix):
    begin
      if (Parent<>nil) and
         (Parent.ClassID=_BoundaryLayer) then
        MethodCashRecord:=FindCashRecord(OvercomeMethodE)
      else
        MethodCashRecord:=nil;

      if MethodCashRecord=nil then begin
        NoDetP:=OvercomeMethod.GetValueFromMatrix(WarriorGroupU, SelfU,
                                           LineU, 0, mvkProbability, nil);
        if NoDetP=-1 then
          DetP0:=1
        else
          DetP0:=1-NoDetP;

        if (Parent<>nil) and
           (Parent.ClassID=_BoundaryLayer) then begin
          GetMem(MethodCashRecord, SizeOf(TMethodCashRecord));
          MethodCashRecord.OvercomeMethod:=pointer(OvercomeMethodE);
          MethodCashRecord.DetP0:=DetP0;
        end;
      end else
        DetP0:=MethodCashRecord.DetP0;
    end;
  longint(ppcExternal):
    DetP0:=OvercomeMethod.GetDetectionProbability(WarriorGroupU,
                          FacilityStateU, LineU, SelfU, nil);
  longint(ppcZero):
    DetP0:=0;
  longint(ppcOne):
    DetP0:=1;
  longint(ppcStandard):
    begin
      if Ref.QueryInterface(IDetectionElementKind, DetectionElementKind)=0 then
        DetP0:=DetectionElementKind.StandardDetectionProbability
      else
        DetP0:=0;
    end;
  else
    DetP0:=0;
  end;
  except
    DataModel.HandleError(Format
    ('Error in DoCalcDetectionProbability. SafeguardElementID=%d ClassID=%d',[ID, ClassID]))
  end;

  if FacilityModelS.DelayFlag and
     (DelayTime>0) then begin
    FacilityModelS.DelayFlag:=False; // флаг DelayFlag используетс€ как дл€
                                     // обхода задержки на цели, так и во
                                     // избежание вложенных вызовов CalcNoDistantDetection

    if (DetP0=1) and
      not CalcAll then goto DetP_equ_1;

    CalcPhysicalFields(OvercomeMethodE);

    NoDetP:=1;
    if FacilityModel.GuardPosts.Count>0 then begin // дл€ рубежа сохранено минимальное ослабление звука
      for k:=0 to OvercomeMethod.PhysicalFields.Count-1 do begin
        DetP:=GetFieldDetectionProbability
              (OvercomeMethod.PhysicalFields.Item[k],
               Self as IDMElement,
               OvercomeMethod.PhysicalFieldValue[k], DelayTime);
        if DetP=1 then begin
          DetPf:=1;
          if not CalcAll then goto DetP_equ_1;
        end;
        NoDetP:=NoDetP*(1-DetP);
      end;
    end;
    DetPf:=1-NoDetP;

    if (Parent<>nil) and
       (Parent.QueryInterface(IBoundaryLayer, BoundaryLayer)=0) then begin
      Boundary:=Parent.Parent as IBoundary;

      if (OvercomeMethod.PhysicalFields.Count>0) and
         (Ref.QueryInterface(IBarrierKind, BarrierKind)=0) and
         BarrierKind.IsFragile then begin
        NoDetP0:=CalcNoGlassSoundDetection(TacticU, Boundary.Observers,
                                                OvercomeMethod.PhysicalFields);
        if NoDetP0=0 then begin
          DetPf:=1;
          if not CalcAll then goto DetP_equ_1;
        end;

        DetPf:=1-(1-DetPf)*NoDetP0;
      end;
    end else begin // if Parent.QueryInterface(IBoundaryLayer, BoundaryLayer)<>0
      DetPf:=0;
    end;

DetP_equ_1:

    FacilityModelS.DelayFlag:=True;
  end; //if DelayFlag

  Result:=1-(1-DetP0*WorkP)*(1-DetPf);

end;

procedure TSafeguardElement.CalcPhysicalFields(const OvercomeMethodE:IDMElement);
var
  OvercomeMethod:IOvercomeMethod;
  WarriorGroupU, FacilityStateU, LineU, SelfU:IUnknown;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
begin
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  WarriorGroupU:=FacilityModelS.CurrentWarriorGroupU;
  FacilityStateU:=FacilityModelS.CurrentFacilityStateU;
  LineU:=FacilityModelS.CurrentLineU;
  SelfU:=Self as IUnknown;

  case OvercomeMethod.FieldsProcCode of
  -1: OvercomeMethod.CalcPhysicalFields(WarriorGroupU,
                          FacilityStateU, LineU, SelfU);
   0: begin
      end;
   1: CalcSoundPower(OvercomeMethod);
  end;
end;

procedure TSafeguardElement.CalcSoundPower(const OvercomeMethod:IOvercomeMethod);
var
  j:integer;
  aToolTypeE, ToolE,
  aWeaponTypeE, WeaponE, WarriorGroupE:IDMElement;
  aToolKind:IToolKind;
  aWeaponKind:IWeaponKind;
  SoundPower, MaxSoundPower:double;
  WarriorGroup:IWarriorGroup;
  FacilityModelS:IFMState;
begin
  if Ref=nil then Exit;
  if OvercomeMethod.PhysicalFields.Count=0 then Exit;

  FacilityModelS:=DataModel as IFMState;
  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;
  WarriorGroupE:=WarriorGroup as IDMElement; 
  if WarriorGroupE.ClassID<>_AdversaryGroup then Exit;

  if OvercomeMethod.ToolTypes.Count>0 then begin
    MaxSoundPower:=0;
    for j:=0 to OvercomeMethod.ToolTypes.Count-1 do begin
      aToolTypeE:=OvercomeMethod.ToolTypes.Item[j];
      ToolE:=(WarriorGroup.Tools as IDMCollection2).GetItemByRefParent(aToolTypeE);
      if ToolE=nil then begin
        OvercomeMethod.PhysicalFieldValue[0]:=-1;
        Exit;  //  у нарушителей нет нужного инструмента
      end;
      aToolKind:=ToolE.Ref as IToolKind;
      SoundPower:=aToolKind.SoundPower;
      if MaxSoundPower<SoundPower then
        MaxSoundPower:=SoundPower;
    end;
  end else
  if OvercomeMethod.WeaponTypes.Count>0 then begin
    MaxSoundPower:=0;
    for j:=0 to OvercomeMethod.WeaponTypes.Count-1 do begin
      aWeaponTypeE:=OvercomeMethod.WeaponTypes.Item[j];
      WeaponE:=(WarriorGroup.Weapons as IDMCollection2).GetItemByRefParent(aWeaponTypeE);
      if WeaponE=nil then begin
        OvercomeMethod.PhysicalFieldValue[0]:=-1;
        Exit;  //  у нарушителей нет нужного вооружени€
      end;
      aWeaponKind:=WeaponE.Ref as IWeaponKind;
      SoundPower:=aWeaponKind.SoundPower;
      if MaxSoundPower<SoundPower then
        MaxSoundPower:=SoundPower;
    end;
  end else
    MaxSoundPower:=50; // звук быстрых шагов

  OvercomeMethod.PhysicalFieldValue[0]:=MaxSoundPower;
  if OvercomeMethod.PhysicalFields.Count=1 then Exit;
    OvercomeMethod.PhysicalFieldValue[1]:=0;
end;

function TSafeguardElement.Get_Collection(Index: Integer): IDMCollection;
begin
    Result:=inherited Get_Collection(Index)
end;

procedure TSafeguardElement.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
    inherited
end;

procedure TSafeguardElement.Draw(const aPainter:IUnknown; DrawSelected: integer);
var
  Image:IElementImage;
  LocalView:IView;
  Node:ICoordNode;
  Line:ILine;
  SpatialModel2:ISpatialModel2;
  SpatialModel:ISpatialModel;
  Painter:IPainter;
  Document:IDMDocument;
  OldState:integer;
  PX, PY, PZ, X0, Y0, X1, Y1, W, L, MaxH, K0, K1, dL, dL2, cos_A, ZAngle:double;
  N, m:integer;
  SelfE:IDMElement;
  WidthIntf:IWidthIntf;
  BoundaryLayer:IBoundaryLayer;
  ParentSelected:boolean;
  View:IView;
begin
  if Ref=nil then Exit;
  if Parent=nil then Exit;
  if SpatialElement<>nil then begin
    if not (SpatialElement.Parent as ILayer).Visible and
       not  Selected then Exit;
  end;

  if (FSMLabel<>nil) and
     (DataModel as IVulnerabilityMap).ShowText then
    FSMLabel.Draw(aPainter, DrawSelected);

  SpatialModel2:=DataModel as ISpatialModel2;
  SpatialModel:=DataModel as ISpatialModel;
  Image:=(Ref as IVisualElement).Image;
  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfExecuting;
  try

  if (Image<>nil) and
     (DataModel as IVulnerabilityMap).ShowSymbols and
     FShowSymbol then begin

    Painter:=aPainter as IPainter;
    View:=Painter.ViewU as IView;

    if Painter.UseLayers then
     Painter.LayerIndex:=SpatialModel.Layers.IndexOf(SpatialElement.Parent);

    SelfE:=Self as IDMElement;
    if SelfE.QueryInterface(IWidthIntf, WidthIntf)=0 then
      W:=WidthIntf.Width
    else
      W:=0;

    X0:=-InfinitValue;
    Y0:=-InfinitValue;
    X1:=-InfinitValue;
    Y1:=-InfinitValue;
    MaxH:=-1;
    L:=0;

    if Parent.ClassID=_Zone then
      ParentSelected:=Parent.SpatialElement.Selected
    else
      ParentSelected:=Parent.Parent.SpatialElement.Selected;

    if (SpatialElement<>nil) and
       (SpatialElement.QueryInterface(ILine, Line)=0) then begin
      L:=Line.Length;
    end else begin
      if Parent.QueryInterface(IBoundaryLayer, BoundaryLayer)=0 then begin
        X0:=BoundaryLayer.X0;
        Y0:=BoundaryLayer.Y0;
        X1:=BoundaryLayer.X1;
        Y1:=BoundaryLayer.Y1;
        L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
        MaxH:=max(BoundaryLayer.Height0, BoundaryLayer.Height1);
//        if MaxH<0 then
//          MaxH:=max(H0, H1)/100;
      end;
    end;

    LocalView:=(SpatialModel2.Views as IDMCollection2).CreateElement(False) as IView;
    if SpatialElement=nil then begin
      GetCoord(PX, PY, PZ);
      if Parent.ClassID=_Zone then begin
        LocalView.CX:=PX;
        LocalView.CY:=PY;
        LocalView.CZ:=PZ+Get_Elevation;
        LocalView.CurrX0:=0;
        LocalView.CurrY0:=0;
        LocalView.ZAngle:=GetRotationAngle;
      end else begin
        LocalView.CX:=PX;
        LocalView.CY:=PY;
        LocalView.CZ:=PZ+Get_Elevation;
        LocalView.CurrX0:=0;
        LocalView.CurrY0:=0;

       if L=0 then
         ZAngle:=0
       else begin
         cos_A:=(X1-X0)/L;
         if cos_A=1 then
           ZAngle:=0
        else
         if cos_A=0 then
           ZAngle:=90
         else
           ZAngle:=arccos(cos_A)/3.1415926*180;
         if Y1-Y0<0 then
           ZAngle:=-ZAngle;
        end;   
        LocalView.ZAngle:=ZAngle+GetRotationAngle;
      end;
    end else
    if SpatialElement.QueryInterface(ICoordNode, Node)=0 then begin
      LocalView.CX:=Node.X;
      LocalView.CY:=Node.Y;
      LocalView.CZ:=Node.Z+Get_Elevation;
      LocalView.ZAngle:=-View.ZAngle;
    end else
    if SpatialElement.QueryInterface(ILine, Line)=0 then begin
      Node:=Line.C0;
      LocalView.CX:=Node.X;
      LocalView.CY:=Node.Y;
      LocalView.CZ:=Node.Z+Get_Elevation;
      LocalView.ZAngle:=Line.ZAngle;
    end else begin
      Document.State:=OldState;
      Exit;
    end;

    if FImageMirrored then
      LocalView.CurrZ0:=-1
    else
      LocalView.CurrZ0:=+1;


    N:=1;
    dL:=0;
    dL2:=0;
    case Image.ScalingType of
    eitNoScaling:
      begin
        LocalView.RevScale:=1/View.RevScale/FSymbolScaleFactor;
      end;
    eitScaling:
       LocalView.RevScale:=1/FSymbolScaleFactor;
    eitXScaling:
      begin
        if (L<>0) and
           (Image.XSize<>0) then
          LocalView.RevScaleX:=Image.XSize/L/FSymbolScaleFactor
        else
          LocalView.RevScaleX:=1/FSymbolScaleFactor;
        if (W<>0) and
           (Image.YSize<>0) then
          LocalView.RevScaleY:=Image.YSize/W/FSymbolScaleFactor
        else
          LocalView.RevScaleY:=1/FSymbolScaleFactor;
        if (MaxH>0) and
           (Image.ZSize<>0) then
          LocalView.RevScaleZ:=Image.ZSize/(MaxH*100)/FSymbolScaleFactor
        else
          LocalView.RevScaleZ:=1/FSymbolScaleFactor
      end;
    eitXYScaling:
      begin
        if (L<>0) and
           (Image.XSize<>0) then
          LocalView.RevScaleX:=Image.XSize/L/FSymbolScaleFactor
        else
          LocalView.RevScaleX:=1/FSymbolScaleFactor;
        LocalView.RevScaleY:=LocalView.RevScaleX;
        if (MaxH>0) and
           (Image.ZSize<>0) then
          LocalView.RevScaleZ:=Image.ZSize/(MaxH*100)/FSymbolScaleFactor
        else
          LocalView.RevScaleZ:=1/FSymbolScaleFactor
      end;
    eitMultScaling:
      begin
        K0:=Image.MinPixels*FSymbolScaleFactor;
        K1:=L/View.RevScale;
        N:=ceil(K1/K0);
        if N>1 then begin
          dL:=L/N;
          dL2:=dL/2;
          LocalView.RevScale:=Image.MaxSize/dL/FSymbolScaleFactor;
        end else
          LocalView.RevScale:=Image.MaxSize/L/FSymbolScaleFactor;
      end;
    end;
    if LocalView.RevScaleZ=0 then
      LocalView.RevScaleZ:=1/FSymbolScaleFactor;

     Painter.LocalViewU:=LocalView;


    if N=1 then begin
      if (DrawSelected=-1) then
        (Image as IDMElement).Draw(aPainter, -1)
      else
      if (DrawSelected=1) or ParentSelected then
        (Image as IDMElement).Draw(aPainter, 1)
      else
        (Image as IDMElement).Draw(aPainter, 0);
    end else begin
      for m:=0 to N-1 do begin
        LocalView.CX:=X0+(X1-X0)/L*(m*dL+dL2);
        LocalView.CY:=Y0+(Y1-Y0)/L*(m*dL+dL2);
        if (DrawSelected=-1) then
          (Image as IDMElement).Draw(aPainter, -1)
        else
        if (DrawSelected=1) or ParentSelected then
          (Image as IDMElement).Draw(aPainter, 1)
        else
          (Image as IDMElement).Draw(aPainter, 0);
      end;
    end;

    Painter.LocalViewU:=nil;
  end else
  if SpatialElement<>nil then begin
    if SpatialElement.ClassID=_Line then
      ((SpatialElement as ILine).C0 as IDMElement).Draw(aPainter, DrawSelected)
    else
      SpatialElement.Draw(aPainter, DrawSelected);
  end;

  finally
    Document.State:=OldState;
  end;
end;

function TSafeguardElement.Get_PathNodes: IDMCollection;
begin
  Result:=FPathNodes
end;

procedure TSafeguardElement.Set_Parent(const Value: IDMElement);
var
  Boundary:IBoundary;
  RefPathElement:IRefPathElement;
begin
  if Value=nil then
    inherited
  else
  if Value.QueryInterface(IRefPathElement,RefPathElement)=0  then
    Set_Parent(Value.Ref)
  else
  if Value.QueryInterface(IBoundary, Boundary)=0  then
    Set_Parent(Boundary.BoundaryLayers.Item[0])
  else
    inherited;
end;

procedure TSafeguardElement.CalculateFieldValues;
begin
end;

function TSafeguardElement.GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer;
begin
    Result:=-1;
end;

function TSafeguardElement.Get_Elevation: double;
begin
  Result:=FElevation*100
end;

function TSafeguardElement.Get_LabelVisible: WordBool;
begin
  Result:=(FSMLabel<>nil)
end;

function TSafeguardElement.Get_SMLabel: IDMElement;
begin
  Result:=FSMLabel
end;

procedure TSafeguardElement.Set_LabelVisible(Value: WordBool);
var
  Collection2:IDMCollection2;
  aLabel:ISMLabel;
  aLabelE:IDMElement;
  SpatialModel2:ISpatialModel2;
begin
  if DataModel.IsLoading then Exit;
  SpatialModel2:=DataModel as ISpatialModel2;
  Collection2:=SpatialModel2.Labels as IDMCollection2;
  if Value then begin
    if FSMLabel<>nil then Exit;
    FSMLabel:=Collection2.CreateElement(False);
    Collection2.Add(FSMLabel);
    FSMLabel.Name:=Name;
    FSMLabel.Ref:=Self as IDMElement;
    aLabel:=FSMLabel as ISMLabel;
    aLabel.Font:=SpatialModel2.CurrentFont;
  end else begin
    if FSMLabel=nil then Exit;
    aLabelE:=FSMLabel;
    FSMLabel.Clear;
    Collection2.Remove(aLabelE);
    Set_SMLabel(nil);
  end;
end;

procedure TSafeguardElement.Set_SMLabel(const Value: IDMElement);
begin
  FSMLabel:=Value
end;

function TSafeguardElement.Get_Font: ISMFont;
begin
  if FSMLabel=nil then
    Result:=nil
  else
    Result:=(FSMLabel as ISMLabel).Font
end;

function TSafeguardElement.Get_LabelScaleMode: Integer;
begin
  if FSMLabel=nil then
    Result:=0
  else
    Result:=(FSMLabel as ISMLabel).LabelScaleMode
end;

procedure TSafeguardElement.Set_Font(const Value: ISMFont);
begin
  if DataModel.IsLoading then Exit;
  if FSMLabel=nil then Exit;
  (FSMLabel as ISMLabel).Font:=Value
end;

procedure TSafeguardElement.Set_LabelScaleMode(Value: Integer);
begin
  if DataModel.IsLoading then Exit;
  if FSMLabel=nil then Exit;
  (FSMLabel as ISMLabel).LabelScaleMode:=Value
end;

procedure TSafeguardElement._RemoveBackRef(const Value: IDMElement);
begin
  if Value.DataModel<>DataModel then Exit;
  if Value.Parent=nil then Exit;

  if Value.ClassID=_SMLabel then
    Set_SMLabel(nil)
  else
  if Value.ClassID=_CoordNode then
    Set_SpatialElement(nil)
  else
  if Value.ClassID=_Line then
    Set_SpatialElement(nil);
end;

procedure TSafeguardElement.ClearOp;
var
  SpatialModel2:ISpatialModel2;
  Collection2:IDMCollection2;
begin
  inherited;
  if FSMLabel=nil then Exit;
  SpatialModel2:=DataModel as ISpatialModel2;
  Collection2:=SpatialModel2.Labels as IDMCollection2;
  Collection2.Remove(FSMLabel);
  FSMLabel.Ref:=nil;
  Set_SMLabel(nil)
end;

function TSafeguardElement.Get_UserDefineded: WordBool;
begin
  Result:=(inherited Get_UserDefineded)
end;

procedure TSafeguardElement.Set_Elevation(const Value: double);
begin
  FElevation:=Value/100
end;

function TSafeguardElement.Get_MainParent: IDMElement;
var
  Boundary:IBoundary;
  FacilityModel:IFacilityModel;
begin
  if (Parent<>nil) and
     (Parent.ClassID=_BoundaryLayer) then begin
    FacilityModel:=DataModel as IFacilityModel;
    Boundary:=Parent.Parent as IBoundary;
    if (Boundary.BoundaryLayers.Count=1) and
        not FacilityModel.ShowSingleLayer then
       Result:=Parent.Parent
    else
      Result:=Parent
  end else
    Result:=Parent
end;

function TSafeguardElement.IsPresent: WordBool;
var
  FacilityModelS:IFMState;
  FacilityState:IFacilityState;
begin
  FacilityModelS:=DataModel as IFMState;
  FacilityState:=FacilityModelS.CurrentFacilityStateU as IFacilityState;
  if FacilityState=nil then
    Result:=True
  else
  if FPresence>=0 then
    Result:=(FPresence<=FacilityState.ModificationStage)
  else
    Result:=(-FPresence>FacilityState.ModificationStage);
end;

function TSafeguardElement.InWorkingState: WordBool;
var
  FacilityModelS:IFMState;
  SafeguardElementType:ISafeguardElementType;
  DeviceStateE, SubStateE:IDMElement;
  FacilityState:IFacilityState;
  j, m:integer;
  DirectPathFlag:boolean;
  Unk:IUnknown;
begin
  Result:=False;
  if Ref=nil then Exit;

  FacilityModelS:=DataModel as IFMState;
  FacilityState:=FacilityModelS.CurrentFacilityStateU as IFacilityState;
  if FacilityState=nil then
     Exit;
  DirectPathFlag:=FacilityModelS.CurrentDirectPathFlag;

  if FPresence>=0 then
    Result:=(FPresence<=FacilityState.ModificationStage)
  else
    Result:=(-FPresence>FacilityState.ModificationStage);
  if not Result then Exit;

  Result:=WorksInDirection(DirectPathFlag);
  if not Result then Exit;


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

  if DirectPathFlag then begin
    if j>=0 then
      DeviceStateE:=(FStates.Item[m] as ISafeguardElementState).DeviceState0
    else begin
      if not VarIsNull(FDeviceState0) then
        Unk:=FDeviceState0
      else
        Unk:=nil;
      DeviceStateE:=Unk as IDMElement
    end
  end else begin
    if j>=0 then
      DeviceStateE:=(FStates.Item[m] as ISafeguardElementState).DeviceState1
    else begin
      if not VarIsNull(FDeviceState1) then
        Unk:=FDeviceState1
      else
        Unk:=nil;
      DeviceStateE:=Unk as IDMElement
    end
  end;

  SafeguardElementType:=Ref.Parent as ISafeguardElementType;
  if SafeguardElementType.DeviceStates.Count>0 then
    Result:=(SafeguardElementType.DeviceStates.Item[0]=DeviceStateE)
  else
    Result:=True
end;

function TSafeguardElement.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(seDeviceState0),
  ord(seDeviceState1):
    Result:=True;
  else
    Result:=inherited FieldIsVisible(Code)
  end;

end;

function TSafeguardElement.Get_DeviceCount: integer;
begin
  Result:=FDeviceCount
end;

function TSafeguardElement.Get_Presence: integer;
begin
  Result:=FPresence
end;

procedure TSafeguardElement.Set_DeviceCount(Value: Integer);
begin
  FDeviceCount:=Value
end;

procedure TSafeguardElement.Set_Presence(Value: Integer);
begin
  FPresence:=Value
end;

function TSafeguardElement.Get_InstallCoeff: double;
begin
  Result:=FInstallCoeff
end;

procedure TSafeguardElement.Set_InstallCoeff(Value: double);
begin
  FInstallCoeff:=Value
end;

function TSafeguardElement.CalcWorkProbability: double;
begin
  Result:=1;
end;

procedure TSafeguardElement.AfterLoading2;
var
  SafeguardElementType:ISafeguardElementType;
  Unk:IUnknown;
  BackRefHolders2:IDMCollection2;
  EmptyBackRefHolderE, DummyKindE:IDMElement;
  EmptyBackRefHolder:IDMBackRefHolder;
begin
  inherited;
  if Ref=nil then begin
    EmptyBackRefHolderE:=DataModel.EmptyBackRefHolder;
    if EmptyBackRefHolderE=nil then begin
      BackRefHolders2:=DataModel.BackRefHolders as IDMCollection2;
      EmptyBackRefHolderE:=BackRefHolders2.CreateElement(True);
      DataModel.EmptyBackRefHolder:=EmptyBackRefHolderE;
      BackRefHolders2.Add(EmptyBackRefHolderE);
      DummyKindE:=TNamedDMElement.Create(DataModel) as IDMElement;
      EmptyBackRefHolderE.Ref:=DummyKindE;
      DummyKindE.Name:='ќбъекты с типом, удаленным из базы данных';
    end;
    EmptyBackRefHolder:=EmptyBackRefHolderE as IDMBackRefHolder;
    (EmptyBackRefHolder.BackRefs as IDMCollection2).Add(Self as IDMElement);

    Exit;
  end;
  SafeguardElementType:=Ref.Parent as ISafeguardElementType;
  if SafeguardElementType=nil then Exit;
  if SafeguardElementType.DeviceStates.Count=0 then Exit;

  Unk:=FDeviceState1;
  if Unk=nil then begin
    Unk:=SafeguardElementType.DeviceStates.Item[0] as IUnknown;
    FDeviceState1:=Unk;
  end;
end;

function TSafeguardElement.Get_BestOvercomeMethod: IDMElement;
begin
   Result:=IDMElement(FBestOvercomeMethod);
end;

procedure TSafeguardElement.Set_BestOvercomeMethod(
  const Value: IDMElement);
begin
  FBestOvercomeMethod:=pointer(Value)
end;

function TSafeguardElement.ShowInLayerName: WordBool;
begin
  Result:=False
end;

function TSafeguardElement.Get_DetectionPosition: integer;
begin
  Result:=0
end;

procedure TSafeguardElement.Set_CurrOvercomeMethod(
  const Value: IDMElement);
begin
  FCurrOvercomeMethod:=pointer(Value)
end;

procedure TSafeguardElement.AfterCopyFrom(const SourceElement: IDMElement);
begin
  inherited;
  if SourceElement.SpatialElement=nil then
    FDeviceCount:=0
end;

function TSafeguardElement.CompartibleWith(
  const aElement: IDMElement): WordBool;
var
  U:IUnknown;
begin
  Result:=False;
  if aElement.QueryInterface(ISafeguardElement, U)<>0 then Exit;
  if (SpatialElement<>nil) and
     (aElement.SpatialElement<>nil) then
    Result:=inherited CompartibleWith(aElement)
  else
  if (SpatialElement=nil) and
     (aElement.SpatialElement=nil) then
    Result:=True
end;

function TSafeguardElement.GetParameterValues: IDMCollection;
begin
  Result:=FParameterValues
end;

function TSafeguardElement.Get_Field(Index: integer): IDMField;
var
  Fields:IDMCollection;
begin
  Fields:=GetFields;
  if Fields<>nil then begin
    if Index<Fields.Count then
      Result:=Fields.Item[Index] as IDMField
    else
      Result:=FParameterValues.Item[Index-Fields.Count].Ref as IDMField
  end else
      Result:=FParameterValues.Item[Index].Ref as IDMField
end;

function TSafeguardElement.Get_FieldCount: integer;
var
  Fields:IDMCollection;
begin
  Fields:=GetFields;
  if Fields<>nil then
    Result:=Fields.Count+FParameterValues.Count
  else
    Result:=FParameterValues.Count
end;


procedure TSafeguardElement.ClearCash;
var
  j:integer;
  MethodCashRecord:PMethodCashRecord;
begin
  for j:=0 to FMethodCashRecordList.Count-1 do begin
    MethodCashRecord:=FMethodCashRecordList[j];
    FreeMem(MethodCashRecord, SizeOf(TMethodCashRecord));
  end;
  FMethodCashRecordList.Clear;
end;

function TSafeguardElement.FindCashRecord(const OvercomeMethodE:IDMElement):PMethodCashRecord;
var
  j:integer;
  MethodCashRecord:PMethodCashRecord;
begin
  MethodCashRecord:=nil;
  j:=0;
  while j<FMethodCashRecordList.Count do begin
    MethodCashRecord:=FMethodCashRecordList[j];
    if MethodCashRecord.OvercomeMethod=pointer(OvercomeMethodE) then
      Break
    else
      inc(j)
  end;
  if j<FMethodCashRecordList.Count then
    Result:=MethodCashRecord
  else
    Result:=nil
end;

procedure TSafeguardElement.Redraw(DrawSelected:integer);
var
  Painter:IUnknown;
begin
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  Painter:=(DataModel.Document as ISMDocument).PainterU;

  if DrawSelected=-1 then begin
    if SpatialElement<>nil then
      Draw(Painter, -1)
    else
    if (Parent<>nil) then begin
      if Parent.SpatialElement<>nil then
        Parent.Draw(Painter, -1)
      else
      if (Parent.Parent<>nil) then begin
        if Parent.Parent.SpatialElement<>nil then
          Parent.Parent.Draw(Painter, -1)
      end;
    end;
  end else
  begin
    if SpatialElement<>nil then begin
      if Selected then
        Draw(Painter, 1)
      else
        Draw(Painter, 0)
    end else
    if (Parent<>nil) then begin
      if Parent.SpatialElement<>nil then begin
        if Parent.Selected then
          Parent.Draw(Painter, 1)
        else
          Parent.Draw(Painter, 0)
      end else
      if (Parent.Parent<>nil) then begin
        if Parent.Parent.SpatialElement<>nil then begin
          if Parent.Parent.Selected then
            Parent.Parent.Draw(Painter, 1)
          else
            Parent.Parent.Draw(Painter, 0)
        end;
      end;
    end;  
  end;
end;

function TSafeguardElement.Get_SymbolDX: double;
begin
  Result:=FSymbolDX
end;

function TSafeguardElement.Get_SymbolDY: double;
begin
  Result:=FSymbolDY
end;

function TSafeguardElement.WorksInDirection(DirectPathFlag:boolean): WordBool;
begin
  Result:=True
end;

function TSafeguardElement.Get_X: double;
var
  Line:ILine;
  C, C0, C1:ICoord;
  Area:IArea;
  Volume:IVolume;
  Areas:IDMCollection;
  PX, PY, PZ, aX0, aX1:double;
  BoundaryLayer:IBoundaryLayer;
begin
  if SpatialElement<>nil then begin
    if SpatialElement.QueryInterface(ILine, Line)=0 then
      C:=Line.C0
    else
      C:=SpatialElement as ICoord;
    Result:=C.X;
  end else begin
    if Parent=nil then
      Result:=-InfinitValue
    else begin
      case Parent.ClassID of
      _BoundaryLayer:
        begin
          Area:=Parent.Parent.SpatialElement as IArea;
          if Area.IsVertical then begin
            C0:=Area.C0;
            C1:=Area.C1;
            BoundaryLayer:=Parent as IBoundaryLayer;
            aX0:=BoundaryLayer.X0;
            aX1:=BoundaryLayer.X1;
            Result:=0.5*(aX0+aX1)+Get_SymbolDX;
          end;
        end;
      _Zone:
        begin
          Volume:=Parent.SpatialElement as IVolume;
          Areas:=Volume.BottomAreas;
          if Areas.Count=0 then
            Areas:=Volume.TopAreas;
          if Areas.Count=0 then
            Result:=-InfinitValue
          else begin
            Area:=Areas.Item[0] as IArea;
            Area.GetCentralPoint(PX, PY, PZ);
            Result:=PX+FSymbolDX;
          end;
        end
      else
        Result:=-InfinitValue
      end;
    end;
  end;
end;

function TSafeguardElement.Get_Y: double;
var
  Line:ILine;
  C, C0, C1:ICoord;
  Area:IArea;
  Volume:IVolume;
  Areas:IDMCollection;
  PX, PY, PZ, aY0, aY1:double;
  BoundaryLayer:IBoundaryLayer;
begin
  if SpatialElement<>nil then begin
    if SpatialElement.QueryInterface(ILine, Line)=0 then
      C:=Line.C0
    else
      C:=SpatialElement as ICoord;
    Result:=C.Y;
  end else begin
    if Parent=nil then
      Result:=-InfinitValue
    else begin
      case Parent.ClassID of
      _BoundaryLayer:
        begin
          Area:=Parent.Parent.SpatialElement as IArea;
          if Area.IsVertical then begin
            C0:=Area.C0;
            C1:=Area.C1;
            BoundaryLayer:=Parent as IBoundaryLayer;
            aY0:=BoundaryLayer.Y0;
            aY1:=BoundaryLayer.Y1;
            Result:=0.5*(aY0+aY1)+Get_SymbolDY;
          end;
        end;
      _Zone:
        begin
          Volume:=Parent.SpatialElement as IVolume;
          Areas:=Volume.BottomAreas;
          if Areas.Count=0 then
            Areas:=Volume.TopAreas;
          if Areas.Count=0 then
            Result:=-InfinitValue
          else begin
            Area:=Areas.Item[0] as IArea;
            Area.GetCentralPoint(PX, PY, PZ);
            Result:=PY+FSymbolDY;
          end;
        end
      else
        Result:=-InfinitValue
      end;
    end;
  end;
end;

function TSafeguardElement.Get_Z: double;
var
  Line:ILine;
  C, C0, C1:ICoord;
  Area:IArea;
  Volume:IVolume;
  Areas:IDMCollection;
  PX, PY, PZ:double;
begin
  if SpatialElement<>nil then begin
    if SpatialElement.QueryInterface(ILine, Line)=0 then
      C:=Line.C0
    else
      C:=SpatialElement as ICoord;
    Result:=C.Z+FElevation*100;
  end else begin
    if Parent=nil then
      Result:=-InfinitValue
    else begin
      case Parent.ClassID of
      _BoundaryLayer:
        begin
          Area:=Parent.Parent.SpatialElement as IArea;
          C0:=Area.C0;
          C1:=Area.C1;
          Result:=0.5*(C0.Z+C1.Z)+FElevation*100;
        end;
      _Zone:
        begin
          Volume:=Parent.SpatialElement as IVolume;
          Areas:=Volume.BottomAreas;
          if Areas.Count=0 then
            Areas:=Volume.TopAreas;
          if Areas.Count=0 then
            Result:=-InfinitValue
          else begin
            Area:=Areas.Item[0] as IArea;
            Area.GetCentralPoint(PX, PY, PZ);
            Result:=PZ+FElevation*100;
          end;
        end
      else
        Result:=-InfinitValue
      end;
    end;
  end;
end;

procedure TSafeguardElement.Set_X(Value: double);
var
  Line:ILine;
  C, C0, C1:ICoord;
  Area:IArea;
  Volume:IVolume;
  Areas:IDMCollection;
  PX, PY, PZ, D, V, aX0, aX1:double;
  DMOperationManager:IDMOperationManager;
  BoundaryLayer:IBoundaryLayer;
begin
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  if SpatialElement<>nil then begin
    if SpatialElement.QueryInterface(ILine, Line)=0 then begin
      C0:=Line.C0;
      D:=C1.X-C0.X;
      C0.X:=Value;
      C1.X:=Value+D;
    end else begin
      C:=SpatialElement as ICoord;
      C.X:=Value;
    end;
  end else begin
    if Parent<>nil  then begin
      case Parent.ClassID of
      _BoundaryLayer:
        begin
          Area:=Parent.Parent.SpatialElement as IArea;
          if Area.IsVertical then begin
            C0:=Area.C0;
            C1:=Area.C1;
            BoundaryLayer:=Parent as IBoundaryLayer;
            aX0:=BoundaryLayer.X0;
            aX1:=BoundaryLayer.X1;
            V:=Value-0.5*(aX0+aX1);
            DMOperationManager.ChangeFieldValue(Self as IDMELement, cnstSymbolDX, True, V);
          end;
        end;
      _Zone:
        begin
          Volume:=Parent.SpatialElement as IVolume;
          Areas:=Volume.BottomAreas;
          if Areas.Count=0 then
            Areas:=Volume.TopAreas;
          if Areas.Count>0 then begin
            Area:=Areas.Item[0] as IArea;
            Area.GetCentralPoint(PX, PY, PZ);
            V:=Value-PX;
            DMOperationManager.ChangeFieldValue(Self as IDMELement, cnstSymbolDX, True, V);
          end;
        end
      end;
    end;
  end;
end;

procedure TSafeguardElement.Set_Y(Value: double);
var
  Line:ILine;
  C, C0, C1:ICoord;
  Area:IArea;
  Volume:IVolume;
  Areas:IDMCollection;
  PX, PY, PZ, D, V, aY0, aY1:double;
  DMOperationManager:IDMOperationManager;
  BoundaryLayer:IBoundaryLayer;
begin
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  if SpatialElement<>nil then begin
    if SpatialElement.QueryInterface(ILine, Line)=0 then begin
      C0:=Line.C0;
      D:=C1.Y-C0.Y;
      C0.Y:=Value;
      C1.Y:=Value+D;
    end else begin
      C:=SpatialElement as ICoord;
      C.Y:=Value;
    end;
  end else begin
    if Parent<>nil  then begin
      case Parent.ClassID of
      _BoundaryLayer:
        begin
          Area:=Parent.Parent.SpatialElement as IArea;
          if Area.IsVertical then begin
            C0:=Area.C0;
            C1:=Area.C1;
            BoundaryLayer:=Parent as IBoundaryLayer;
            aY0:=BoundaryLayer.Y0;
            aY1:=BoundaryLayer.Y1;
            V:=Value-0.5*(aY0+aY1);
            DMOperationManager.ChangeFieldValue(Self as IDMELement, cnstSymbolDY, True, V);
          end;
        end;
      _Zone:
        begin
          Volume:=Parent.SpatialElement as IVolume;
          Areas:=Volume.BottomAreas;
          if Areas.Count=0 then
            Areas:=Volume.TopAreas;
          if Areas.Count>0 then begin
            Area:=Areas.Item[0] as IArea;
            Area.GetCentralPoint(PX, PY, PZ);
            V:=Value-PY;
            DMOperationManager.ChangeFieldValue(Self as IDMELement, cnstSymbolDY, True, V);
          end;
        end
      end;
    end;
  end;
end;

procedure TSafeguardElement.Set_Z(Value: double);
var
  Line:ILine;
  C, C0, C1:ICoord;
  Area:IArea;
  Volume:IVolume;
  Areas:IDMCollection;
  PX, PY, PZ, V:double;
  DMOperationManager:IDMOperationManager;
begin
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  if SpatialElement<>nil then begin
    if SpatialElement.QueryInterface(ILine, Line)=0 then
      C:=Line.C0
    else
      C:=SpatialElement as ICoord;
    V:=(Value-C.Z)/100;
    DMOperationManager.ChangeFieldValue(Self as IDMELement, ord(ddpElevation), True, V);
  end else begin
    if Parent<>nil  then begin
      case Parent.ClassID of
      _BoundaryLayer:
        begin
          Area:=Parent.Parent.SpatialElement as IArea;
          C0:=Area.C0;
          C1:=Area.C1;
          V:=(Value-0.5*(C0.Z+C1.Z))/100;
          DMOperationManager.ChangeFieldValue(Self as IDMELement, ord(ddpElevation), True, V);
        end;
      _Zone:
        begin
          Volume:=Parent.SpatialElement as IVolume;
          Areas:=Volume.BottomAreas;
          if Areas.Count=0 then
            Areas:=Volume.TopAreas;
          if Areas.Count>0 then begin
            Area:=Areas.Item[0] as IArea;
            Area.GetCentralPoint(PX, PY, PZ);
            V:=(Value-PZ)/100;
            DMOperationManager.ChangeFieldValue(Self as IDMELement, ord(ddpElevation), True, V);
          end;
        end
      end;
    end;
  end;
end;

function TSafeguardElement.GetRotationAngle: double;
begin
  if Get_ImageRotated then
    Result:=180
  else
    Result:=0;
end;

procedure TSafeguardElement.GetCoord(var X0, Y0, Z0: double);
var
  Node:ICoordNode;
  Area:IArea;
  Areas:IDMCollection;
  C0, C1:ICoordNode;
  Volume:IVolume;
  PX, PY, PZ, aX0, aY0, aX1, aY1:double;
  BoundaryLayer:IBoundaryLayer;
  m, AreaCount:integer;
begin
  if SpatialElement=nil then begin
    if Parent=nil then Exit;
    case Parent.ClassID of
    _BoundaryLayer:
      begin
        if Parent.Parent=nil then Exit;
        Area:=Parent.Parent.SpatialElement as IArea;
        if Area.IsVertical then begin
          C0:=Area.C0;
          C1:=Area.C1;
          BoundaryLayer:=Parent as IBoundaryLayer;
          aX0:=BoundaryLayer.X0;
          aY0:=BoundaryLayer.Y0;
          aX1:=BoundaryLayer.X1;
          aY1:=BoundaryLayer.Y1;
          X0:=0.5*(aX0+aX1)+Get_SymbolDX;
          Y0:=0.5*(aY0+aY1)+Get_SymbolDY;
          Z0:=0.5*(C0.Z+C1.Z)
        end;
      end;
    _Zone:
      begin
        Volume:=Parent.SpatialElement as IVolume;
        Areas:=Volume.BottomAreas;
        if Areas.Count=0 then
          Areas:=Volume.TopAreas;
        if Areas.Count>0 then begin
          AreaCount:=Areas.Count;
          X0:=0;
          Y0:=0;
          Z0:=0;
          for m:=0 to AreaCount-1 do begin
            Area:=Areas.Item[m] as IArea;
            Area.GetCentralPoint(PX, PY, PZ);
            X0:=X0+PX;
            Y0:=Y0+PY;
            Z0:=Z0+PZ;
          end;
          X0:=X0/AreaCount+Get_SymbolDX;
          Y0:=Y0/AreaCount+Get_SymbolDY;
          Z0:=Z0/AreaCount;
        end;
      end;
    else

       begin
        X0:=-InfinitValue;
        Y0:=-InfinitValue;
        Z0:=-InfinitValue;
       end;
    end;
  end else begin
    if SpatialElement.QueryInterface(ICoordNode, Node)<>0 then
      Node:=(SpatialElement as ILine).C0;
    X0:=Node.X;
    Y0:=Node.Y;
    Z0:=Node.Z;
  end;
end;

procedure TSafeguardElement.Set_Selected(Value: WordBool);
var
  SMDocument:ISMDocument;
  PainterU:IUnknown;
begin
  inherited;
  if DataModel=nil then Exit;
  if SpatialElement<>nil then Exit;
  SMDocument:=DataModel.Document as  ISMDocument;
  PainterU:=SMDocument.PainterU;
  if Value then
    Draw(PainterU, 1)
  else
    Draw(PainterU, 0)
end;

procedure TSafeguardElement.CalcParams(const TacticU: IUnknown; ObservationPeriod:double;
                         out dTFast, dTDispFast, NoDetPFast, NoDetP1Fast,
                             dTStealth, dTDispStealth, NoDetPStealth, NoDetP1Stealth: Double;
                         out OvercomeMethodFastE, OvercomeMethodStealthE: IDMElement);
var
  SafeguardElementType:ISafeguardElementType;
  OvercomeMethodE:IDMElement;
  OvercomeMethod:IOvercomeMethod;
  j:integer;
  dT, NoDetP, NoDetP1, DetP1, TT:double;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  WarriorGroup:IWarriorGroup;
  DetP0, DetPf, WorkP, DelayTimeDispersionRatio:double;
  SafeguardDatabase:ISafeguardDatabase;
  InsiderTarget:IInsiderTarget;
begin
  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;

  dTFast:=0;
  NoDetPFast:=1;
  OvercomeMethodFastE:=nil;

  dTStealth:=0;
  NoDetPStealth:=1;
  OvercomeMethodStealthE:=nil;

  if Ref=nil then Exit;
  if Ref.Parent=nil then Exit;
  if not IsPresent then Exit;
  if not InWorkingState then Exit;
  if QueryInterface(IInsiderTarget, InsiderTarget)=0 then begin
    if InsiderTarget.ControledByInsider=2 then // пост поголовно подкуплен
      Exit
  end;

  FacilityModel:=DataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;
  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  if Get_UserDefinedDetectionProbability then begin
    NoDetPFast:=1-Get_DetectionProbability;
    NoDetPStealth:=NoDetPFast;
    OvercomeMethodFastE:=SafeguardDatabase.UserDefinedValueMethod;
    OvercomeMethodStealthE:=OvercomeMethodFastE;
  end;
  if Get_UserDefinedDelayTime then begin
    dTFast:=Get_DelayTime;
    dTDispFast:=sqr(DelayTimeDispersionRatio*dTFast);
    dTStealth:=dTFast;
    NoDetPStealth:=dTDispFast;

    OvercomeMethodE:=SafeguardDatabase.UserDefinedValueMethod;
    OvercomeMethodStealthE:=OvercomeMethodFastE;
    if Get_UserDefinedDetectionProbability then
      Exit;
  end;

  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;
  SafeguardElementType:=Ref.Parent as ISafeguardElementType;

  dTFast:=InfinitValue;
  NoDetPFast:=-1;
  dTStealth:=InfinitValue;
  NoDetPStealth:=-1;

  for j:=0 to SafeguardElementType.OvercomeMethods.Count-1 do begin
    OvercomeMethodE:=SafeguardElementType.OvercomeMethods.Item[j];
    OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
    if OvercomeMethod.AcceptableForTactic(TacticU) and
       AcceptableMethod(OvercomeMethodE) and
       WarriorGroup.AcceptableMethod(OvercomeMethodE) then begin

      if FacilityModelS.DelayFlag then
        dT:=DoCalcDelayTime(OvercomeMethodE)
      else
        dT:=0;

      if dT>=InfinitValue/1000 then begin
        NoDetP:=0;
        NoDetP1:=0;
      end else begin
        DetP1:=DoCalcDetectionProbability(TacticU, OvercomeMethodE,
                            dT, DetP0, DetPf, WorkP, False);
        NoDetP1:=1-DetP1;
        NoDetP:=NoDetP1;
        if ObservationPeriod<>0 then begin
          TT:=dT/ObservationPeriod;
          NoDetP:=NoDetP*exp(-TT);
        end;
      end;

      if NoDetPStealth<NoDetP then begin
        NoDetPStealth:=NoDetP;
        NoDetP1Stealth:=NoDetP1;
        dTStealth:=dT;
        OvercomeMethodStealthE:=OvercomeMethodE;
      end else
      if NoDetPStealth=NoDetP then begin
        if dTStealth>dT then begin
          NoDetPStealth:=NoDetP;
          NoDetP1Stealth:=NoDetP1;
          dTStealth:=dT;
          OvercomeMethodStealthE:=OvercomeMethodE;
        end;
      end;

      if dTFast>dT then begin
        dTFast:=dT;
        NoDetPFast:=NoDetP;
        NoDetP1Fast:=NoDetP1;
        OvercomeMethodFastE:=OvercomeMethodE;
      end;
    end;
  end;

  dTDispFast:=sqr(DelayTimeDispersionRatio*dTFast);
  dTDispStealth:=sqr(DelayTimeDispersionRatio*dTStealth);
end;

{ TSafeguardElements }

class function TSafeguardElements.GetElementClass: TDMElementClass;
begin
  Result:=TSafeguardElement
end;

function TSafeguardElements.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSafeguardElement
end;

class function TSafeguardElements.GetElementGUID: TGUID;
begin
  Result:=IID_ISafeguardElement
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TSafeguardElement.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
