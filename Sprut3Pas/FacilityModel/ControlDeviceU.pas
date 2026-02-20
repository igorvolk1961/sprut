unit ControlDeviceU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomTargetU;

type
  TControlDevice=class(TCustomTarget, IControlDevice, ICabelNode, IDMElement4,
                       IInsiderTarget, IGoods)
  private
    FInputConnections:IDMCollection;
    FOutputConnections:IDMCollection;
    FDeviceState0:Variant;
    FDeviceState1:Variant;
    FPresence:integer;
    FCabelSafety:integer;
    FDeviceCount:integer;
    FInstallCoeff:double;
  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class procedure MakeFields1; override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;

    procedure _AddChild(const aElement:IDMElement); override;
    procedure _RemoveChild(const aElement:IDMElement); override;
    procedure AfterLoading2; override; safecall;
    procedure ClearOp; override;

    procedure Set_Ref(const Value:IDMElement); override;
    procedure Set_SpatialElement(const Value:IDMElement); override;
    function Get_MainParent:IDMElement; override;

    function  Get_Presence:integer; override; safecall;
    procedure Set_Presence(Value: Integer); override; safecall;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;

    function  InWorkingState:WordBool; virtual; safecall;
    function Get_Connections:IDMCollection; safecall;
    function Get_InputConnections:IDMCollection; safecall;
    function Get_OutputConnections:IDMCollection; safecall;

    function Get_CabelSafety:integer; safecall;

    function  Get_DeviceState0: IDMElement; safecall;
    procedure Set_DeviceState0(const Value: IDMElement); safecall;
    function  Get_DeviceState1: IDMElement; safecall;
    procedure Set_DeviceState1(const Value: IDMElement); safecall;

    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; override; safecall;

    procedure CalcDelayTime(out DelayTime, DelayTimeDispersion:double;
                            out BestTacticE:IDMElement; AddDelay:double); override;

//IDMElement4
    function AddRefElementRef(const aCollection: IDMCollection; const aName: WideString;
                             const aRef: IDMElement): IDMElement; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;

//IInsiderTarget
    function Get_ControledByInsider: integer; safecall;

//IGoods
    function  Get_DeviceCount:integer; safecall;
    procedure Set_DeviceCount(Value: Integer); safecall;
    function  Get_InstallCoeff:double; safecall;
    procedure Set_InstallCoeff(Value:double); safecall;
  end;

  TControlDevices=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
    function       Get_ClassAlias2(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TControlDevice }

class function TControlDevice.GetClassID: integer;
begin
  Result:=_ControlDevice;
end;

class function TControlDevice.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TControlDevice.MakeFields0;
var
  S:WideString;
begin
  S:='|'+'Снимается на  3-м этапе модернизации'+
     '|'+'Снимается на  2-м этапе модернизации'+
     '|'+'Снимается на  1-м этапе модернизации'+
     '|'+'Установлен в исходном состоянии'+
     '|'+'Добавляется на  1-м этапе модернизации'+
     '|'+'Добавляется на  2-м этапе модернизации'+
     '|'+'Добавляется на  3-м этапе модернизации';
  AddField(rsPresence, S, '', '',
                 fvtChoice, 0, -3, +3,
                 ord(cnstPresence), 0, pkInput);
  AddField(rsDeviceState0, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(cpDeviceState0), 0, pkInput);
  AddField(rsDeviceState1, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(cpDeviceState1), 0, pkInput);
  inherited;
end;

function TControlDevice.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cpDeviceState0):
    Result:=FDeviceState0;
  ord(cpDeviceState1):
    Result:=FDeviceState1;
  ord(cnstPresence):
    Result:=FPresence;
  ord(cnstDeviceCount):
    Result:=FDeviceCount;
  ord(cnstInstallCoeff):
    Result:=FInstallCoeff;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TControlDevice.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(cpDeviceState0):
    begin
      SetUnkValue(FDeviceState0, Value);
      SetUnkValue(FDeviceState1, Value);
    end;
  ord(cpDeviceState1):
    SetUnkValue(FDeviceState1, Value);
  ord(cnstPresence):
    FPresence:=Value;
  ord(cnstDeviceCount):
    FDeviceCount:=Value;
  ord(cnstInstallCoeff):
    FInstallCoeff:=Value;
  else
    inherited
  end;
end;

procedure TControlDevice._Destroy;
begin
  inherited;
  (FInputConnections as IDMCollection2).Clear;
  FInputConnections:=nil;
  FOutputConnections:=nil;
end;

procedure TControlDevice.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FStates:=DataModel.CreateCollection(_SafeguardElementState, SelfE);
  FOutputConnections:=DataModel.CreateCollection(_Connection, SelfE);
  FInputConnections:=DataModel.CreateCollection(-1, SelfE);
end;

function TControlDevice.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(cnstShowSymbol),
  ord(cnstSymbolScaleFactor),
  ord(cnstImageRotated),
  ord(cnstImageMirrored),
  ord(fepLabelVisible),
  ord(fepLabelScaleMode),
  ord(fepFont):
    Result:=(SpatialElement<>nil)
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

function TControlDevice.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:   Result:=FInputConnections;
  1:   Result:=FOutputConnections;
  else
     Result:=inherited Get_Collection(Index-2);
  end;
end;

function TControlDevice.Get_CollectionCount: integer;
begin
  Result:=inherited Get_CollectionCount +2
end;

function TControlDevice.Get_Connections: IDMCollection;
begin
  Result:=FOutputConnections
end;

function TControlDevice.Get_OutputConnections: IDMCollection;
begin
  Result:=FOutputConnections
end;

function TControlDevice.Get_InputConnections: IDMCollection;
begin
  Result:=FInputConnections
end;

procedure TControlDevice.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:begin
      aCollectionName:=rsInputConnections;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=0;
      aLinkType:=ltOneToMany;
    end;
  1:begin
      aCollectionName:=rsOutputConnections;
      if DataModel<>nil then
        aRefSource:=(DataModel as IDMElement).Ref.Collection[_ControlDeviceType]
      else
        aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoRename or leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  else
    inherited GetCollectionProperties(Index-2,
              aCollectionName, aRefSource,
              aClassCollections, aOperations, aLinkType)
  end;    
end;

procedure TControlDevice.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  aCollection2:=aCollection as IDMCollection2;
  SourceCollection:=(DataModel as IDMElement).Collection[_ControlDevice];
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do
    aCollection2.Add(SourceCollection.Item[j]);
end;

procedure TControlDevice._AddChild(const aElement: IDMElement);
var
  aControlDevice:IControlDevice;
  SelfE:IDMElement;
  j:integer;
begin
  inherited;

  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;

  if aElement=nil then Exit;
  if aElement.Ref=nil then Exit;
  SelfE:=Self  as IDMElement;
{
  if aElement.Ref.QueryInterface(ICabel, Cabel)=0 then begin
    j:=Cabel.ControlDevices.IndexOf(SelfE);
    if j=-1 then
      (Cabel.ControlDevices as IDMCollection2).Add(SelfE);
  end;
}
  if aElement.ClassID=_Connection then begin
    if aElement.Ref.QueryInterface(IControlDevice, aControlDevice)=0 then begin
      j:=aControlDevice.InputConnections.IndexOf(SelfE);
      if j=-1 then
        (aControlDevice.InputConnections as IDMCollection2).Add(SelfE);
    end;
  end;
end;

procedure TControlDevice._RemoveChild(const aElement: IDMElement);
var
  aControlDevice:IControlDevice;
  SelfE:IDMElement;
  j:integer;
begin
  inherited;

  if aElement=nil then Exit;
  if aElement.Ref=nil then Exit;
  SelfE:=Self  as IDMElement;
{
  if aElement.Ref.QueryInterface(ICabel, Cabel)=0 then begin
    j:=Cabel.ControlDevices.IndexOf(SelfE);
    if j<>-1 then
      (Cabel.ControlDevices as IDMCollection2).Delete(j);
  end;
}
  if aElement.ClassID=_Connection then begin
    if aElement.Ref.QueryInterface(IControlDevice, aControlDevice)=0 then  begin
      j:=aControlDevice.InputConnections.IndexOf(SelfE);
      if j<>-1 then
        (aControlDevice.InputConnections as IDMCollection2).Delete(j);
    end;
  end;
end;

function TControlDevice.InWorkingState: WordBool;

var
  Unk:IUnknown;
  SafeguardElementType:ISafeguardElementType;
  DeviceStateE:IDMElement;
    SubStateE:IDMElement;
  FacilityState:IFacilityState;
  j, m:integer;
  FacilityModelS:IFMState;
begin
  FacilityModelS:=DataModel as IFMState;
  FacilityState:=FacilityModelS.CurrentFacilityStateU as IFacilityState;

  if FPresence>=0 then
    Result:=(FPresence<=FacilityState.ModificationStage)
  else
    Result:=(-FPresence>FacilityState.ModificationStage);
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
  if FacilityModelS.CurrentDirectPathFlag then begin
    if j>=0 then
      DeviceStateE:=(FStates.Item[m] as ISafeguardElementState).DeviceState0
    else begin
      Unk:=FDeviceState0;
      DeviceStateE:=Unk as IDMElement;
    end;
  end else begin
    if j>=0 then
      DeviceStateE:=(FStates.Item[m] as ISafeguardElementState).DeviceState1
    else begin
      Unk:=FDeviceState1;
      DeviceStateE:=Unk as IDMElement;
    end;
  end;

  SafeguardElementType:=Ref.Parent as ISafeguardElementType;
  if SafeguardElementType.DeviceStates.Count>0 then
    Result:=(SafeguardElementType.DeviceStates.Item[0]=DeviceStateE)
  else
    Result:=True;

end;

function TControlDevice.Get_DeviceState0: IDMElement;
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

function TControlDevice.Get_DeviceState1: IDMElement;
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

procedure TControlDevice.Set_DeviceState0(const Value: IDMElement);
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

procedure TControlDevice.Set_DeviceState1(const Value: IDMElement);
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

procedure TControlDevice.Set_Ref(const Value: IDMElement);
var
  SafeguardElementType:ISafeguardElementType;
  FacilityModel:IFacilityModel;
  j:integer;
  DetectionElement:IDetectionElement;
  ControlDeviceKind:IControlDeviceKind;
begin
  inherited;
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Value=nil then Exit;
  SafeguardElementType:=Ref.Parent as ISafeguardElementType;
  if SafeguardElementType=nil then Exit;
  if SafeguardElementType.DeviceStates.Count>0 then begin
    Set_DeviceState0(SafeguardElementType.DeviceStates.Item[0]);
    Set_DeviceState1(SafeguardElementType.DeviceStates.Item[0]);
  end;

  FacilityModel:=DataModel as IFacilityModel;
  ControlDeviceKind:=Ref as IControlDeviceKind;

  case ControlDeviceKind.SystemKind of
  skComplexSystem,
  skAlarmSystem,
  skAlarmFireSystem:
    begin
      for j:=0 to FacilityModel.PerimeterSensors.Count-1 do begin
        DetectionElement:=FacilityModel.PerimeterSensors.Item[j] as IDetectionElement;
        if (DetectionElement.MainControlDevice=nil) and
           (not DetectionElement.LocalAlarmSignal) then
          DetectionElement.MainControlDevice:=Self as IDMElement;
      end;

      for j:=0 to FacilityModel.PositionSensors.Count-1 do begin
        DetectionElement:=FacilityModel.PositionSensors.Item[j] as IDetectionElement;
        if (DetectionElement.MainControlDevice=nil) and
           (not DetectionElement.LocalAlarmSignal) then
          DetectionElement.MainControlDevice:=Self as IDMElement;
      end;

      for j:=0 to FacilityModel.VolumeSensors.Count-1 do begin
        DetectionElement:=FacilityModel.VolumeSensors.Item[j] as IDetectionElement;
        if (DetectionElement.MainControlDevice=nil) and
           (not DetectionElement.LocalAlarmSignal) then
          DetectionElement.MainControlDevice:=Self as IDMElement;
      end;

      for j:=0 to FacilityModel.BarrierSensors.Count-1 do begin
        DetectionElement:=FacilityModel.BarrierSensors.Item[j] as IDetectionElement;
        if (DetectionElement.MainControlDevice=nil) and
           (not DetectionElement.LocalAlarmSignal) then
          DetectionElement.MainControlDevice:=Self as IDMElement;
      end;

      for j:=0 to FacilityModel.SurfaceSensors.Count-1 do begin
        DetectionElement:=FacilityModel.SurfaceSensors.Item[j] as IDetectionElement;
        if (DetectionElement.MainControlDevice=nil) and
           (not DetectionElement.LocalAlarmSignal) then
          DetectionElement.MainControlDevice:=Self as IDMElement;
    end;
    end;
  end;

  case ControlDeviceKind.SystemKind of
  skComplexSystem,
  skTVSystem:
    begin
      for j:=0 to FacilityModel.TVCameras.Count-1 do begin
        DetectionElement:=FacilityModel.TVCameras.Item[j] as IDetectionElement;
        if (DetectionElement.MainControlDevice=nil) and
           (not DetectionElement.LocalAlarmSignal) then
          DetectionElement.MainControlDevice:=Self as IDMElement;
      end;
    end;
  end;
end;

function TControlDevice.Get_Presence: integer;
begin
  Result:=FPresence
end;

procedure TControlDevice.Set_Presence(Value: Integer);
begin
  FPresence:=Value
end;

procedure TControlDevice.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
var
  SafeguardElementType:ISafeguardElementType;
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  theCollection:=nil;
  if Ref=nil then Exit;
  SafeguardElementType:=Ref.Parent as ISafeguardElementType;
  case Code of
  ord(cpDeviceState0),
  ord(cpDeviceState1):
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

function TControlDevice.GetMethodDimItemIndex(Kind, Code: Integer;
  const DimItems: IDMCollection; const ParamE: IDMElement;
  ParamF: double): Integer;
var
  TVMonitorCount:integer;
  j:integer;
  DimensionItem:IDMField;
begin
  case Kind of
  sdAlarmCabelSafety:
    begin
        Result:=0
    end;
  sdTVMonitorCount:
    begin
      TVMonitorCount:=FOutputConnections.Count;
      j:=0;
      while j<DimItems.Count do begin
        DimensionItem:=DimItems.Item[j] as IDMField;
        if (TVMonitorCount>=DimensionItem.MinValue) and
           (TVMonitorCount<DimensionItem.MaxValue) then
          Break
        else
          inc(j)
      end;
      if j<DimItems.Count then
        Result:=j
      else
        Result:=DimItems.Count-1
    end;
  else
    Result:=inherited GetMethodDimItemIndex(Kind, Code, DimItems,
                                            ParamE, ParamF );
  end;                                          
end;

procedure TControlDevice.AfterLoading2;
var
  SafeguardElementType:ISafeguardElementType;
  Unk:IUnknown;
  m, j:integer;
  aElement, SelfE:IDMElement;
  aControlDevice:IControlDevice;
begin
  inherited;
  if Ref=nil then Exit;
  SafeguardElementType:=Ref.Parent as ISafeguardElementType;
  if SafeguardElementType=nil then Exit;
  if SafeguardElementType.DeviceStates.Count=0 then Exit;

  Unk:=FDeviceState1;
  if Unk=nil then begin
    Unk:=SafeguardElementType.DeviceStates.Item[0] as IUnknown;
    FDeviceState1:=Unk;
  end;

  SelfE:=Self as IDMElement;
  for m:=0 to FOutputConnections.Count-1 do begin
    aElement:=FOutputConnections.Item[m];
    if aElement.Ref.QueryInterface(IControlDevice, aControlDevice)=0 then begin
      aControlDevice:=aElement.Ref as IControlDevice;
      j:=aControlDevice.InputConnections.IndexOf(SelfE);
      if j=-1 then
        (aControlDevice.InputConnections as IDMCollection2).Add(SelfE);
    end;
  end;
end;

procedure TControlDevice.CalcDelayTime(out DelayTime,
  DelayTimeDispersion: double; out BestTacticE: IDMElement; AddDelay:double);
var
  AdversaryGroup:IAdversaryGroup;
  FacilityModelS:IFMState;
  WarriorGroupE:IDMElement;
begin
  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  if  WarriorGroupE.QueryInterface(IAdversaryGroup, AdversaryGroup)=0 then
    inherited
  else begin
    DelayTime:=0;
    DelayTimeDispersion:=0;
    BestTacticE:=nil;
  end;
end;

function TControlDevice.AddRefElementRef(const aCollection: IDMCollection;
  const aName: WideString; const aRef: IDMElement): IDMElement;
var
  DMOperationManager:IDMOperationManager;
  ConnectionU, ControlDeviceU, SelfU:IUnknown;
  ControlDevices:IDMCollection;
begin
  SelfU:=Self as  IDMElement;

  ControlDevices:=(DataModel as IDMElement).Collection[_ControlDevice];

  DMOperationManager:=DataModel.Document as IDMOperationManager;

  DMOperationManager.AddElementRef(
                       nil, ControlDevices,
                       aName, aRef, ltOneToMany, ControlDeviceU, True);
  DMOperationManager.AddElementRef(
                       SelfU, FOutputConnections,
                       '', ControlDeviceU, ltOneToMany, ConnectionU, True);

  Result:=ConnectionU as IDMElement;
end;

function TControlDevice.Get_MainParent: IDMElement;
var
  ParentControlDeviceE, GrandParentControlDeviceE:IDMElement;
  ParentControlDevice:IControlDevice;
  GrandParentCabelNode:ICabelNode;
  Connections:IDMCollection;
begin
  Result:=Parent;
  if Parent=nil then begin
    if FInputConnections.Count=0 then
      Result:=nil
    else begin
      ParentControlDeviceE:=FInputConnections.Item[0];
      if ParentControlDeviceE.ClassID=_ControlDevice then begin
        ParentControlDevice:=ParentControlDeviceE as IControlDevice;
        if ParentControlDevice.InputConnections.Count=0 then
          Result:=nil
        else begin
          GrandParentControlDeviceE:=ParentControlDevice.InputConnections.Item[0];
          GrandParentCabelNode:=GrandParentControlDeviceE as ICabelNode;
          Connections:=GrandParentCabelNode.Connections;
          Result:=(Connections as IDMCOllection2).GetItemByRef(ParentControlDeviceE)
        end;
      end else
        Result:=ParentControlDeviceE
    end;
  end;
end;

function TControlDevice.Get_CabelSafety: integer;
begin
  Result:=FCabelSafety
end;

function TControlDevice.Get_ControledByInsider: integer;
var
  FacilityModelS:IFMState;
  AnalysisVariant:IAnalysisVariant;
  AdversaryVariant:IAdversaryVariant;
  ControlDeviceAccesses2:IDMCollection2;
  SelfE:IDMElement;
begin
  SelfE:=Self as IDMElement;
  FacilityModelS:=DataModel as IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  AdversaryVariant:=AnalysisVariant.AdversaryVariant as IAdversaryVariant;
  ControlDeviceAccesses2:=AdversaryVariant.ControlDeviceAccesses as IDMCollection2;
  if ControlDeviceAccesses2.GetItemByRef(SelfE)=nil then
    Result:=0
  else
    Result:=1
end;

procedure TControlDevice.Set_SpatialElement(const Value: IDMElement);
var
  DMOperationManager:IDMOperationManager;
  GuardVariantE, DataModelE:IDMElement;
  ConnectionU:IUnknown;
  Connections:IDMCollection;
begin
  inherited;
  if Value=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if not DataModel.IsChanging then Exit;
  DataModelE:=DataModel as IDMElement;
  GuardVariantE:=DataModelE.Collection[_GuardVariant].Item[0];
  Connections:=DataModelE.Collection[_Connection];
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  DMOperationManager.AddElementRef(GuardVariantE, Connections, '', Self as IDMElement,
    ltOneToMany, ConnectionU, True);
end;

procedure TControlDevice.ClearOp;
var
  ConnectionE:IDMElement;
  DMOperationManager:IDMOperationManager;
  Element, Nul:IDMElement;
begin
  inherited;
  DMOperationManager:=DataModel.Document as  IDMOperationManager;
  Nul:=nil;
  while FOutputConnections.Count>0 do begin
    ConnectionE:=FOutputConnections.Item[0];
    Element:=ConnectionE.Ref;
    DMOperationManager.ChangeFieldValue(Element, ord(depMainControlDevice), True, Nul);
  end;
end;

function TControlDevice.Get_DeviceCount: integer;
begin
  Result:=FDeviceCount
end;

function TControlDevice.Get_InstallCoeff: double;
begin
  Result:=FInstallCoeff
end;

procedure TControlDevice.Set_DeviceCount(Value: Integer);
begin
  FDeviceCount:=Value
end;

procedure TControlDevice.Set_InstallCoeff(Value: double);
begin
  FInstallCoeff:=Value
end;

class procedure TControlDevice.MakeFields1;
begin
  AddField(rsDeviceCount, '%d', '', '',
                 fvtInteger, 1, 0, 0,
                 ord(cnstDeviceCount), 0, pkPrice);
  AddField(rsInstallCoeff, '%0.2f', '', '',
                 fvtFloat, 1, 0, 0,
                 ord(cnstInstallCoeff), 0, pkPrice);
  inherited;
end;

{ TControlDevices }

class function TControlDevices.GetElementClass: TDMElementClass;
begin
  Result:=TControlDevice;
end;

function TControlDevices.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsControlDevice;
end;

class function TControlDevices.GetElementGUID: TGUID;
begin
  Result:=IID_IControlDevice;
end;

function TControlDevices.Get_ClassAlias2(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsControlDevice2
  else
    Result:=rsControlDevices2
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TControlDevice.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
