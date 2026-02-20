unit DetectionElementU;

interface
uses
  Classes, SysUtils, Math,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CabelNodeU;

type
  TDetectionElement=class(TCabelNode, IDetectionElement)
  private
    FDetectionPosition:integer;
    FLocalAlarmSignal:boolean;
    FMainControlDevice:Variant;
    FSecondaryControlDevice:Variant;
    FTechnicalService:Variant;
    FWorkProbability:double;
    FUserDefinedWorkProbability:boolean;
  protected
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class procedure MakeFields1; override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure Set_Ref(const Value:IDMElement); override; safecall;
    procedure Loaded; override;

    procedure SetDefaults; virtual;
    function  CalcWorkProbability:double; override;
    function  InWorkingState:WordBool; override; safecall;
    function Get_LocalAlarmSignal:WordBool; safecall;
    function Get_MainControlDevice:IDMElement; safecall;
    procedure Set_MainControlDevice(const Value:IDMElement); safecall;
    function Get_SecondaryControlDevice:IDMElement; safecall;
    function Get_TechnicalService:IDMElement; safecall;
    procedure Set_TechnicalService(const Value:IDMElement); safecall;
    function  Get_DetectionPosition:integer; override; safecall;

    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; override; safecall;
    procedure _Destroy; override;
    procedure CorrectDrawingDirection; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  CalcDetectionProbabilityLib;

var
  FFields:IDMCollection;

{ TDetectionElement }

function TDetectionElement.Get_LocalAlarmSignal: WordBool;
begin
  Result:=FLocalAlarmSignal
end;

function TDetectionElement.Get_MainControlDevice: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FMainControlDevice;
  Result:=Unk as IDMElement;
end;

function TDetectionElement.Get_SecondaryControlDevice: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FSecondaryControlDevice;
  Result:=Unk as IDMElement;
end;

function TDetectionElement.Get_TechnicalService: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FTechnicalService;
  Result:=Unk as IDMElement;
end;

class function TDetectionElement.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TDetectionElement.MakeFields0;
var
  S:string;
begin
  inherited;
  AddField(rsUserDefinedDetectionProbability, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(depUserDefinedDetectionProbability), 0, pkUserDefined);
  AddField(rsDetectionProbability, '%7.4f', '', '',
                  fvtFloat, 0, 0, 1,
                 ord(depDetectionProbability), 0, pkUserDefined);
  S:='|'+rsOuter+
     '|'+rsCentral+
     '|'+rsInner;
  AddField(rsDetectionPosition, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(depDetectionPosition), 0, pkInput);
  AddField(rsUserDefinedWorkProbability, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(depUserDefinedWorkProbability), 0, pkUserDefined);
  AddField(rsWorkProbability, '%7.4f', '', '',
                  fvtFloat, 1, 0, 1,
                 ord(depWorkProbability), 0, pkUserDefined);
end;

class procedure TDetectionElement.MakeFields1;
begin
  AddField(rsLocalAlarmSignal, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(depLocalAlarmSignal), 0, pkInput);
  AddField(rsMainControlDevice, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(depMainControlDevice), 0, pkInput);
  AddField(rsSecondaryControlDevice, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(depSecondaryControlDevice), 0, pkInput);
  AddField(rsTechnicalService, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(depTechnicalService), 0, pkInput);
  inherited;
end;

function TDetectionElement.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(depUserDefinedDetectionProbability):
    Result:=FUserDefinedDetectionProbability;
  ord(depDetectionProbability):
    Result:=FDetectionProbability;
  ord(depDetectionPosition):
    Result:=FDetectionPosition;
  ord(depLocalAlarmSignal):
    Result:=FLocalAlarmSignal;
  ord(depMainControlDevice):
    Result:=FMainControlDevice;
  ord(depSecondaryControlDevice):
    Result:=FSecondaryControlDevice;
  ord(depTechnicalService):
    Result:=FTechnicalService;
  ord(depUserDefinedWorkProbability):
    Result:=FUserDefinedWorkProbability;
  ord(depWorkProbability):
    Result:=FWorkProbability;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TDetectionElement.SetFieldValue(Code: integer;
  Value: OleVariant);
{
  procedure UpdateUserDefinedElements;
  var
    j:integer;
    FacilityModel:IFacilityModel;
    UserDefinedElements:IDMCollection;
    UserDefinedElements2:IDMCollection2;
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
  end;
}
var
  Unk:IUnknown;
  ControlDeviceE:IDMElement;
begin
  case Code of
  ord(depUserDefinedDetectionProbability):
    begin
      FUserDefinedDetectionProbability:=Value;
      UpdateUserDefinedElements(Value);
    end;
  ord(depDetectionProbability):
    FDetectionProbability:=Value;
  ord(depDetectionPosition):
    FDetectionPosition:=Value;
  ord(depLocalAlarmSignal):
    FLocalAlarmSignal:=Value;
  ord(depMainControlDevice):
    begin
      if not DataModel.IsLoading then begin
        Unk:=Value;
        ControlDeviceE:=Unk as IDMElement;
        Set_MainControlDevice(ControlDeviceE);
      end else
        FMainControlDevice:=Value;
    end;
  ord(depSecondaryControlDevice):
    FSecondaryControlDevice:=Value;
  ord(depTechnicalService):
    FTechnicalService:=Value;
  ord(depUserDefinedWorkProbability):
    begin
      FUserDefinedWorkProbability:=Value;
      UpdateUserDefinedElements(Value);
    end;
  ord(depWorkProbability):
    FWorkProbability:=Value;
  else
    inherited;
  end;
end;

procedure TDetectionElement.Set_MainControlDevice(const Value: IDMElement);
var
  Unk:IUnknown;
  ControlDeviceE:IDMElement;
  ControlDevice:IControlDevice;
  InputConnections:IDMCollection;
  OutputConnections2:IDMCollection2;
  DMOperationManager:IDMOperationManager;
  ConnectionU:IUnknown;
  ConnectionE:IDMElement;
begin
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  InputConnections:=(DataModel as IDMElement).Collection[_Connection];

  ControlDeviceE:=Get_MainControlDevice;
  if ControlDeviceE<>nil then begin
    ControlDevice:=ControlDeviceE as IControlDevice;
    OutputConnections2:=ControlDevice.OutputConnections as IDMCollection2;
    ConnectionE:=OutputConnections2.GetItemByRef(Self as IDMElement);
    if ConnectionE<>nil then
      DMOperationManager.DeleteElement(ControlDeviceE, OutputConnections2, ltOneToMany, ConnectionE);
  end;

  Unk:=Value as IUnknown;
  FMainControlDevice:=Unk;

  ControlDeviceE:=Get_MainControlDevice;
  if ControlDeviceE<>nil then begin
    DMOperationManager.AddElementRef(ControlDeviceE, InputConnections, '',
                   Self as IDMElement, ltOneToMany, ConnectionU, True)
  end;
end;

procedure TDetectionElement.Set_TechnicalService(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FTechnicalService:=Unk;
end;

procedure TDetectionElement.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
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
  ord(depDeviceState0),
  ord(depDeviceState1):
    theCollection:=SafeguardElementType.DeviceStates;
  ord(depMainControlDevice):
    theCollection:=(DataModel as FacilityModel).ControlDevices;
  ord(depSecondaryControlDevice):
    theCollection:=(DataModel as FacilityModel).ControlDevices;
  ord(depTechnicalService):
    theCollection:=(DataModel as FacilityModel).TechnicalServices;
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

function TDetectionElement.GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer;
var
  MainControlDevice:IControlDevice;
  TechnicalService:ITechnicalService;
  AdversaryGroupE:IDMElement;
  AdversaryGroup:IAdversaryGroup;
  AdversaryVariant:IAdversaryVariant;
  MainControlDeviceE, aZoneE, aZone0E, aZone1E:IDMElement;
  BoundaryLayerS:ISafeguardUnit;
  DetectionElementKindE:IDMElement;
  j, AccessType0, AccessType1:integer;
  H, H0, H1:double;
  DimensionItem:IDMField;
  aZone0, aZone1:IZone;
  Boundary:IBoundary;
begin
  Result:=0;
  if Ref=nil then Exit;

  case Kind of
  sdVisualControl:
    begin
        Result:=1
    end;
  sdAlarmSignal:
    begin
      case Code of
      0:begin
        if (Get_MainControlDevice=nil) and
           (Get_SecondaryControlDevice=nil) then begin
          if FLocalAlarmSignal then
            Result:=0
          else
            Result:=1
        end else
        if (Get_MainControlDevice<>nil) and
           (Get_SecondaryControlDevice=nil) then begin
           if FLocalAlarmSignal then
             Result:=3
           else
             Result:=1
        end else
        if (Get_MainControlDevice=nil) and
           (Get_SecondaryControlDevice<>nil) then begin
           if FLocalAlarmSignal then
             Result:=3
           else
             Result:=1
        end else
        if (Get_MainControlDevice<>nil) and
           (Get_SecondaryControlDevice<>nil) then
          Result:=2
        end;
      1:begin
        if (Get_MainControlDevice=nil) and
           (Get_SecondaryControlDevice=nil) then begin
          if FLocalAlarmSignal then
            Result:=0
          else
            Result:=0
        end else
          Result:=1
        end;
      end;
    end;
  sdAlarmCabelSafety:
    begin
      MainControlDevice:=Get_MainControlDevice as IControlDevice;
      if MainControlDevice<>nil then
        Result:=MainControlDevice.CabelSafety
      else
        Result:=0
    end;
  sdTechnicalservice:
    begin
      TechnicalService:=Get_TechnicalService as ITechnicalService;
      if TechnicalService=nil then
        Result:=0
      else
        case Code of
        0:Result:=TechnicalService.Control;
        1:Result:=TechnicalService.Testing;
        2:begin
            Result:=-1
          end;
        else
          Result:=-1
        end;
    end;
  sdAccess:
    begin
      AdversaryGroupE:=ParamE;
      AdversaryVariant:=AdversaryGroupE.Parent as IAdversaryVariant;
      if AdversaryGroupE.QueryInterface(IAdversaryGroup, AdversaryGroup)=0 then begin
        case Code of
        0:begin
            MainControlDeviceE:=Get_MainControlDevice;
            if MainControlDeviceE<>nil then
              Result:=AdversaryVariant.GetAccessType(MainControlDeviceE, False)
            else
              Result:=0
          end;
        1:begin
              Result:=0
          end;
        2:begin
            if Parent.ClassID=_Zone then
              aZoneE:=Parent
            else begin
              Boundary:=Parent.Parent as IBoundary;
              aZone0E:=Boundary.Zone0;
              aZone1E:=Boundary.Zone1;
              case FDetectionPosition of
              1:begin
                  AccessType0:=AdversaryVariant.GetAccessType(aZone0E, False);
                  AccessType1:=AdversaryVariant.GetAccessType(aZone1E, False);
                  Result:=max(AccessType0, AccessType1);
                end;
              0:begin
                  if (aZone0E=nil) or
                     (aZone1E=nil) then
                    Result:=1
                  else begin
                    aZone0:=aZone0E as IZone;
                    aZone1:=aZone1E as IZone;
                    if aZone1.Category<aZone0.Category then
                      Result:=AdversaryVariant.GetAccessType(aZone1E, False)
                    else
                    if aZone1.Category>aZone0.Category then
                      Result:=AdversaryVariant.GetAccessType(aZone0E, False)
                    else begin
                      AccessType0:=AdversaryVariant.GetAccessType(aZone0E, False);
                      AccessType1:=AdversaryVariant.GetAccessType(aZone1E, False);
                      Result:=max(AccessType0, AccessType1);
                    end;
                  end;
                end;
              else //3
                begin
                  if aZone0E=nil then
                    Result:=AdversaryVariant.GetAccessType(aZone1E, False)
                  else
                  if aZone1E=nil then
                    Result:=AdversaryVariant.GetAccessType(aZone0E, False)
                  else begin
                    aZone0:=aZone0E as IZone;
                    aZone1:=aZone1E as IZone;
                    if aZone1.Category<aZone0.Category then
                      Result:=AdversaryVariant.GetAccessType(aZone0E, False)
                    else
                    if aZone1.Category>aZone0.Category then
                      Result:=AdversaryVariant.GetAccessType(aZone1E, False)
                    else begin
                      AccessType0:=AdversaryVariant.GetAccessType(aZone0E, False);
                      AccessType1:=AdversaryVariant.GetAccessType(aZone1E, False);
                      Result:=max(AccessType0, AccessType1);
                    end;
                  end;
                end;
              end;
            end;
          end;
        else
          Result:=0;
        end;
      end else
        Result:=0;
    end;
  sdBarrierMaterial:
    begin
      BoundaryLayerS:=Parent as ISafeguardUnit;
      j:=0;
      while j<BoundaryLayerS.SafeguardElements.Count do
        if BoundaryLayerS.SafeguardElements.Item[j].ClassID=_Barrier then
          Break
        else
          inc(j);
      if j<BoundaryLayerS.SafeguardElements.Count then
        case Code of
        0: Result:=ord((BoundaryLayerS.SafeguardElements.Item[j].Ref as IBarrierKind).IsFragile);
        else
          Result:=-1;
        end
      else
        Result:=0
    end;
  sdDetectionZoneSize:
    case Code of
    0:begin
        if DimItems=nil then begin
          Result:=-1;
          Exit;
        end;
        DetectionElementKindE:=Ref;
        H0:=FElevation;                        //в метрах
        H1:=DetectionElementKindE.GetFieldValue(100); //в метрах
        H:=H0+H1;

        j:=0;
        while j<DimItems.Count do begin
          DimensionItem:=DimItems.Item[j] as IDMField;
          if (H>=DimensionItem.MinValue) and
             (H<DimensionItem.MaxValue) then
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
      Result:=-1
    end;
  else
    Result:=inherited GetMethodDimItemIndex(Kind, Code, DimItems,
                                            ParamE, ParamF );
  end;
end;

procedure TDetectionElement._Destroy;
begin
  inherited;
end;

procedure TDetectionElement.Set_Parent(const Value: IDMElement);
begin
  inherited;
  if Value=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Parent=nil then Exit;
  if Parent.Parent=nil then Exit;

  SetDefaults
end;

procedure TDetectionElement.SetDefaults;
var
  FacilityModel:IFacilityModel;
  j:integer;
  ControlDeviceE:IDMElement;
  ControlDeviceKind:IControlDeviceKind;
begin
  FacilityModel:=DataModel as IFacilityModel;
  j:=0;
  while j<FacilityModel.ControlDevices.Count do begin
    ControlDeviceE:=FacilityModel.ControlDevices.Item[j];
    ControlDeviceKind:=ControlDeviceE.Ref as IControlDeviceKind;
    case ControlDeviceKind.SystemKind of
    skComplexSystem,
    skAlarmSystem,
    skAlarmFireSystem:
      Break
    else
      inc(j)
    end;
  end;
  if j<FacilityModel.ControlDevices.Count then
    Set_MainControlDevice(ControlDeviceE);

  if FacilityModel.TechnicalServices.Count<>0 then
    Set_TechnicalService(FacilityModel.TechnicalServices.Item[0])
end;

procedure TDetectionElement.Loaded;
begin
  inherited;
  if Parent=nil then begin
//    Free;
    Exit;
  end;
end;

function TDetectionElement.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(depUserDefinedDetectionProbability):
    Result:=True;
  ord(depDetectionProbability):
    Result:=Get_UserDefinedDetectionProbability;
  ord(depDeviceState0):
    Result:=True;
  ord(depDeviceState1):
    Result:=True;
//    Result:=False;
  ord(depDetectionPosition):
    Result:=(Parent.ClassID=_BoundaryLayer);
  ord(depLocalAlarmSignal):
    Result:=True;
  ord(depMainControlDevice):
    Result:=True;
  ord(depSecondaryControlDevice):
    Result:=True;
  ord(depTechnicalService):
    Result:=True;
  ord(depWorkProbability):
    Result:=FUserDefinedWorkProbability;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

function TDetectionElement.InWorkingState: WordBool;
var
  MainControlDeviceE, SecondaryControlDeviceE:IDMElement;
  MainControlDevice, SecondaryControlDevice:IControlDevice;
  j:integer;
  Connections:IDMCollection;
  Connection:IConnection;
  CheckedConnections:IDMCollection;
begin
  Result:=inherited InWorkingState;
  if not Result then begin
    Exit;
  end;
  MainControlDeviceE:=Get_MainControlDevice;
  SecondaryControlDeviceE:=Get_SecondaryControlDevice;
  if (MainControlDeviceE=nil) and
     (SecondaryControlDeviceE=nil) then Exit; // если не задано, то не учитывать

  Result:=False;
  MainControlDevice:=MainControlDeviceE as IControlDevice;
  SecondaryControlDevice:=SecondaryControlDeviceE as IControlDevice;
  if (not MainControlDevice.InWorkingState) and
     (not SecondaryControlDevice.InWorkingState) then Exit;
  Result:=True;

  Connections:=Get_Connections;
  if Connections.Count=0 then Exit; // если не задано, то не учитывать

  Result:=False;
  CheckedConnections:=TDMCollection.Create(nil) as IDMCollection;
  j:=0;
  while j<Connections.Count do begin
    Connection:=Connections.Item[j] as IConnection;
    if Connection.ConnectedTo(MainControlDeviceE,
              SecondaryControlDeviceE,
              CheckedConnections) then
      Break
    else
      inc(j)
  end;

  (CheckedConnections as IDMCollection2).Clear;

  Result:=(j<Connections.Count);
end;

function TDetectionElement.CalcWorkProbability: double;
var
  TechnicalService:ITechnicalService;
  Ts, Tr:double;
  DetectionElementKind:IDetectionElementKind;
begin
  if FUserDefinedWorkProbability then begin
    Result:=FWorkProbability;
    Exit
  end;


  TechnicalService:=Get_TechnicalService as ITechnicalService;
  if TechnicalService=nil then
    Result:=1
  else
  if Ref.QueryInterface(IDetectionElementKind, DetectionElementKind)=0 then begin
    Tr:=DetectionElementKind.ReliabilityTime;
    if Tr=0 then begin
      Result:=1;
      Exit;
    end;
    Ts:=TechnicalService.Period*24;
    Result:=exp(-Ts/Tr)
  end else
    Result:=1
end;

function TDetectionElement.Get_DetectionPosition: integer;
begin
  Result:=FDetectionPosition
end;

procedure TDetectionElement.Set_Ref(const Value: IDMElement);
var
  DetectionElementKind:IDetectionElementKind;
begin
  inherited;
  if Value=nil then Exit;
  if Value.QueryInterface(IDetectionElementKind, DetectionElementKind)=0 then
    FDetectionPosition:=DetectionElementKind.DefaultDetectionPosition
  else
    FDetectionPosition:=dpCent
end;

procedure TDetectionElement.CorrectDrawingDirection;
begin
  inherited;
  if FDetectionPosition=2 then begin
    FImageRotated:=not FImageRotated;
    FImageMirrored:=not FImageMirrored;
  end;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TDetectionElement.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
