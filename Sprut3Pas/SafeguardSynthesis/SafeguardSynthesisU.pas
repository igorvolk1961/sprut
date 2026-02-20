unit SafeguardSynthesisU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj,
  Classes, SysUtils, StdVcl,
  DMComObjectU, DataModelU, DataModel_TLB, 
  DMServer_TLB, FacilityModelLib_TLB, SgdbLib_TLB, SafeguardAnalyzerLib_TLB,
  SafeguardSynthesisLib_TLB, SpatialModelLib_TLB,
  Variants;

function GetDataModelClassObject:IDMClassFactory;

type
  TSafeguardSynthesisFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;


  TSafeguardSynthesis = class(TDataModel, ISafeguardSynthesis)
  private
    FCurrentEquipmentVariant: IDMElement;
    FFacilityModel:IFacilityModel;
    FEtalonModel:IFacilityModel;

    FSafeguardElementCollection:IDMCollection;

    FTerminateFlag:WordBool;

    function FindEtalonElement(const FacilityElementE:IDMElement):IDMElement;
    function SafeguardElementExists(const SafeguardElementKindE, FacilityElementE:IDMElement):boolean;
    procedure BuildRecomendations;
    function CompareElements(const FacilityElementE, EtalonElementE:IDMElement):double;
  protected
    procedure Analysis;safecall;
    
    function  Get_CurrentEquipmentVariant: IDMElement; safecall;
    procedure Set_CurrentEquipmentVariant(const Value: IDMElement); safecall;
    function  Get_EquipmentVariants: IDMCollection; safecall;
    function  Get_EquipmentElements: IDMCollection; safecall;
    function  Get_Recomendations: IDMCollection; safecall;
    function  Get_RecomendationVariants: IDMCollection; safecall;

    function  Get_FacilityModel: IDataModel; safecall;
    procedure Set_FacilityModel(const Value: IDataModel); safecall;

    function  Get_EtalonModel: IDataModel; safecall;
    procedure Set_EtalonModel(const Value: IDataModel); safecall;
    function  Get_TerminateFlag:WordBool; safecall;
    procedure Set_TerminateFlag(Value:WordBool); safecall;

    procedure BuildEquipmentVariants; safecall;
    procedure Clear; override;

//  защищенные методы
    procedure MakeCollections; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  SafeguardSynthesisConstU,
  EquipmentVariantU,
  EquipmentElementU,
  RecomendationU,
  RecomendationVariantU;

{ TSafeguardSynthesis }

procedure TSafeguardSynthesis.Initialize;
begin
  DecimalSeparator:='.';

  inherited;
  ID:=8;

  FSafeguardElementCollection:=CreateCollection(-1, nil);
end;

procedure TSafeguardSynthesis.MakeCollections;
begin
  inherited;
  AddClass(TEquipmentVariants);
  AddClass(TEquipmentElements);
  AddClass(TRecomendations);
  AddClass(TRecomendationVariants);
end;

function TSafeguardSynthesis.Get_FacilityModel: IDataModel;
begin
  Result:=FFacilityModel as IDataModel
end;

procedure TSafeguardSynthesis.Set_FacilityModel(
  const Value: IDataModel);
begin
  FFacilityModel:=Value as  IFacilityModel;
end;

function TSafeguardSynthesis.Get_EtalonModel: IDataModel;
begin
  Result:=FEtalonModel as IDataModel
end;

procedure TSafeguardSynthesis.Set_EtalonModel(const Value: IDataModel);
begin
  FEtalonModel:=Value as IFacilityModel
end;

function TSafeguardSynthesis.Get_EquipmentVariants: IDMCollection;
begin
  Result:=Collection[_EquipmentVariant]
end;

function TSafeguardSynthesis.Get_EquipmentElements: IDMCollection;
begin
  Result:=Collection[_EquipmentElement]
end;

destructor TSafeguardSynthesis.Destroy;
begin
  inherited;
  FCurrentEquipmentVariant:=nil;
  FFacilityModel:=nil;
  FEtalonModel:=nil;
  FSafeguardElementCollection:=nil;
end;

function TSafeguardSynthesis.Get_CurrentEquipmentVariant: IDMElement;
begin
  Result:=FCurrentEquipmentVariant
end;

procedure TSafeguardSynthesis.Set_CurrentEquipmentVariant(
  const Value: IDMElement);
begin
  if FCurrentEquipmentVariant<>nil then
    (FCurrentEquipmentVariant as IEquipmentVariant).Disconnect;
  FCurrentEquipmentVariant:=Value;
  if FCurrentEquipmentVariant<>nil then
    (FCurrentEquipmentVariant as IEquipmentVariant).Connect;
end;

procedure TSafeguardSynthesis.BuildRecomendations;
var
  SafeguardAnalyzer:ISafeguardAnalyzer;
  j:integer;
  FacilityElementE, RecomendationE, FacilityModelE:IDMElement;
  Recomendation:IRecomendation;
  Recomendations:IDMCollection;
  Recomendations2:IDMCollection2;
  Zone:IZone;
  ZoneKind:IZoneKind;
  DMOperationManager:IDMOperationManager;
begin
  SafeguardAnalyzer:=(FFacilityModel as IDataModel).Analyzer as ISafeguardAnalyzer;
  FacilityModelE:=FFacilityModel as IDMElement;
  DMOperationManager:=(FFacilityModel as IDataModel).Document as IDMOperationManager;

  Recomendations:=Get_Recomendations as IDMCollection;
  Recomendations2:=Recomendations as IDMCollection2;
  Recomendations2.Clear;
{
  if FFacilityModel.FMRecomendations.Count>0 then begin
    for j:=0 to FFacilityModel.FMRecomendations.Count-1 do begin
      FacilityElementE:=FFacilityModel.FMRecomendations.Item[j].Ref;
      if FacilityElementE.ClassID<>_GlobalZone then begin
        RecomendationE:=Recomendations2.CreateElement(False);
        Recomendations2.Add(RecomendationE);
        RecomendationE.Ref:=FacilityElementE;
        Recomendation:=RecomendationE as IRecomendation;
      end
    end;

  end else begin
}
    for j:=0 to FFacilityModel.Zones.Count-1 do begin
      FacilityElementE:=FFacilityModel.Zones.Item[j];
      Zone:=FacilityElementE as IZone;
      ZoneKind:=FacilityElementE.Ref as IZoneKind;
      if (Zone.Zones.Count=0) and
         (ZoneKind<>nil) and
         ((ZoneKind.PedestrialMovementVelocity<>0) or
           ZoneKind.AirMovementEnabled or           
           ZoneKind.WaterMovementEnabled or
           ZoneKind.UnderWaterMovementEnabled) then begin
        RecomendationE:=Recomendations2.CreateElement(False);
        Recomendations2.Add(RecomendationE);
        RecomendationE.Ref:=FacilityElementE;
        Recomendation:=RecomendationE as IRecomendation;
      end;
    end;

    for j:=0 to FFacilityModel.Boundaries.Count-1 do begin
      FacilityElementE:=FFacilityModel.Boundaries.Item[j];
      if FacilityElementE.Ref.Parent.ID<>btVirtual then begin  // не условная граница
        RecomendationE:=Recomendations2.CreateElement(False);
        Recomendations2.Add(RecomendationE);
        RecomendationE.Ref:=FacilityElementE;
        Recomendation:=RecomendationE as IRecomendation;
      end;
    end;
    for j:=0 to FFacilityModel.Jumps.Count-1 do begin
      FacilityElementE:=FFacilityModel.Jumps.Item[j];
      RecomendationE:=Recomendations2.CreateElement(False);
      Recomendations2.Add(RecomendationE);
      RecomendationE.Ref:=FacilityElementE;
      Recomendation:=RecomendationE as IRecomendation;
    end;
    for j:=0 to FFacilityModel.Targets.Count-1 do begin
      FacilityElementE:=FFacilityModel.Targets.Item[j];
      RecomendationE:=Recomendations2.CreateElement(False);
      Recomendations2.Add(RecomendationE);
      RecomendationE.Ref:=FacilityElementE;
      Recomendation:=RecomendationE as IRecomendation;
    end;
//  end;
end;

procedure TSafeguardSynthesis.BuildEquipmentVariants;
var
  SafeguardAnalyzer:ISafeguardAnalyzer;
  j, m, k, VariantIndex, ClassID:integer;
  FacilityElementE, RecomendationE, EquipmentVariantE,
  EtalonElementE, FacilityModelE:IDMElement;
  Recomendations:IDMCollection;
  Recomendations2, EquipmentVariants2, EquipmentElements2:IDMCollection2;
  EquipmentVariants:IDMCollection;
  Zone:IZone;
  Boundary:IBoundary;
  SafeguardUnit:ISafeguardUnit;
  SafeguardUnitE:IDMElement;
  SafeguardElements:IDMCollection;
  SourceSafeguardElementE, DestSafeguardElementE,
  SafeguardElementKindE, SafeguardElementTypeE,
  EquipmentElementE:IDMElement;
  DMInstanceSource:IDMInstanceSource;
  Collection2, SafeguardElementCollection2:IDMCollection2;
  DMOperationManager:IDMOperationManager;
  EquipmentElement:IEquipmentElement;
  Recomendation:IRecomendation;
  aName:WideString;
begin
  FTerminateFlag:=False;
  SafeguardAnalyzer:=(FFacilityModel as IDataModel).Analyzer as ISafeguardAnalyzer;
  FacilityModelE:=FFacilityModel as IDMElement;
  DMOperationManager:=(FFacilityModel as IDataModel).Document as IDMOperationManager;
  DMOperationManager.StartTransaction(nil, leoAdd, 'Выработка рекомендаций');

  Recomendations:=Get_Recomendations as IDMCollection;
  Recomendations2:=Recomendations as IDMCollection2;
  Recomendations2.Clear;

  EquipmentElements2:=Get_EquipmentElements as  IDMCollection2;
  EquipmentElements2.Clear;

  SafeguardElementCollection2:=FSafeguardElementCollection as IDMCollection2;
  SafeguardElementCollection2.Clear;

  EquipmentVariants:=Get_EquipmentVariants;
  EquipmentVariants2:=EquipmentVariants as IDMCollection2;
  EquipmentVariants2.Clear;

  for j:=0 to 3 do begin
    EquipmentVariantE:=EquipmentVariants2.CreateElement(False);
    EquipmentVariants2.Add(EquipmentVariantE);
    if j=0 then
      EquipmentVariantE.Name:='Исходное состояние'
    else
      EquipmentVariantE.Name:='Вариант оснащения '+IntToStr(j);
  end;

  BuildRecomendations;

  DMOperationManager.StartTransaction(nil, leoAdd, 'Выработка рекомендаций');
  for m:=0 to Recomendations.Count-1 do begin
    if FTerminateFlag then
      Exit;
    RecomendationE:=Recomendations.Item[m];
    Recomendation:=RecomendationE as IRecomendation;
    FacilityElementE:=RecomendationE.Ref;
    EtalonElementE:=FindEtalonElement(FacilityElementE);
    if EtalonElementE<>nil then begin
      if EtalonElementE.QueryInterface(IZone, Zone)=0 then begin
        SafeguardUnit:=EtalonElementE as ISafeguardUnit;
        SafeguardElements:=SafeguardUnit.SafeguardElements;
        Recomendation.ParentElement:=FacilityElementE;
      end else
      if (EtalonElementE.QueryInterface(IBoundary, Boundary)=0) and
         (Boundary.BoundaryLayers.Count>0) then begin
        SafeguardUnit:=Boundary.BoundaryLayers.Item[0] as ISafeguardUnit;
        SafeguardElements:=SafeguardUnit.SafeguardElements;
        Recomendation.ParentElement:=(FacilityElementE as IBoundary).BoundaryLayers.Item[0];
      end else begin
        SafeguardElements:=nil;
        SafeguardUnitE:=nil;
      end;

      if SafeguardElements<>nil then begin
        for k:=0 to SafeguardElements.Count-1 do begin
          SourceSafeguardElementE:=SafeguardElements.Item[k];
          VariantIndex:=SourceSafeguardElementE.Presence;
          if VariantIndex=0 then
            Continue;
          SafeguardElementKindE:=SourceSafeguardElementE.Ref;
          if not SafeguardElementExists(SafeguardElementKindE, FacilityElementE) and
             (SourceSafeguardElementE.ClassID<>_Target) and
             (SourceSafeguardElementE.ClassID<>_GuardPost) then begin
            SafeguardElementTypeE:=SafeguardElementKindE.Parent;
            DMInstanceSource:=SafeguardElementTypeE.OwnerCollection as IDMInstanceSource;
            ClassID:=DMInstanceSource.InstanceClassID;
            aName:=(FFacilityModel as IDataModel).GetDefaultName(SourceSafeguardElementE.Ref);
            Collection2:=FacilityModelE.Collection[ClassID] as IDMCollection2;
            DestSafeguardElementE:=Collection2.CreateElement(False);
            SafeguardElementCollection2.Add(DestSafeguardElementE);
            DMOperationManager.PasteToElement(SourceSafeguardElementE, DestSafeguardElementE, False, True);
            DestSafeguardElementE.Name:=aName;
            DestSafeguardElementE.Presence:=2;  // 2-й этап модернизации

            EquipmentElementE:=EquipmentElements2.CreateElement(False);
            EquipmentElements2.Add(EquipmentElementE);

            EquipmentElement:=EquipmentElementE as IEquipmentElement;
            EquipmentElement.SafeguardElement:=DestSafeguardElementE;
            EquipmentElementE.Parent:=Recomendation.RecomendationVariant[VariantIndex];
          end;
        end;
      end;
    end;
  end;

  Analysis;
end;

function TSafeguardSynthesis.Get_Recomendations: IDMCollection;
begin
  Result:=Collection[_Recomendation]
end;

function TSafeguardSynthesis.FindEtalonElement(
  const FacilityElementE: IDMElement): IDMElement;
var
  j:integer;
  Collection:IDMCollection;
  W, MaxW:double;
  aElement:IDMElement;
begin
  Result:=nil;
  Collection:=nil;
  case FacilityElementE.ClassID of
  _Zone: Collection:=FEtalonModel.Zones;
  _Boundary: Collection:=FEtalonModel.Boundaries;
  _Jump: Collection:=FEtalonModel.Boundaries;
  _Target: Collection:=FEtalonModel.Targets;
  else
    Exit;
  end;
  MaxW:=0;
  try
  for j:=0 to Collection.Count-1 do begin
    aElement:=Collection.Item[j];
    W:=CompareElements(FacilityElementE, aElement);
    if MaxW<W then begin
      MaxW:=W;
      Result:=aElement;
    end;
  end;
  except
    raise
  end;  
end;

function TSafeguardSynthesis.SafeguardElementExists(
  const SafeguardElementKindE, FacilityElementE:IDMElement): boolean;
var
  SafeguardUnit:ISafeguardUnit;
  Boundary:IBoundary;
  j:integer;
begin
  Result:=False;
  if FacilityElementE.QueryInterface(IBoundary, Boundary)=0 then begin
    for j:=0 to Boundary.BoundaryLayers.Count-1 do begin
      SafeguardUnit:=Boundary.BoundaryLayers.Item[j] as ISafeguardUnit;
      if (SafeguardUnit.SafeguardElements as IDMCollection2).GetItemByRef(SafeguardElementKindE)<>nil then begin
        Result:=True;
        Exit;
      end;
    end;
  end else
  if FacilityElementE.QueryInterface(ISafeguardUnit, SafeguardUnit)=0 then begin
    if (SafeguardUnit.SafeguardElements as IDMCollection2).GetItemByRef(SafeguardElementKindE)<>nil then begin
      Result:=True;
      Exit;
    end;
  end;

end;

function TSafeguardSynthesis.CompareElements(const FacilityElementE,
  EtalonElementE: IDMElement): double;
var
  m, k:integer;
  FieldValue0, FieldValue1:OleVariant;
  Field:IDMField;
  FieldValue0U, FieldValue1U:IUnknown;
  Boundary0, Boundary1:IBoundary;
  Zone00E, Zone10E, Zone01E, Zone11E:IDMElement;
  V0, V1:double;
  EtalonLayerKindE:IDMElement;
  Zone0, Zone1:IZone;
  Zone0S, Zone1S:ISafeguardUnit;
  TargetFlag0, TargetFlag1:boolean;
  Volume0, Volume1:IVolume;
  HZoneKindList, VZoneKindList, BoundaryKindList:TList;
  aAreaE, aBoundaryKind0E, aBoundaryKind1E,
  aZoneKind0E, aZoneKind1E:IDMElement;
  aArea:IArea;
begin
  try
  Result:=0;

  if (FacilityElementE=EtalonElementE) and
     (FacilityElementE=nil) then begin
    Result:=750;
    Exit;
  end;

  if FacilityElementE=nil then Exit;
  if EtalonElementE=nil then Exit;

  if (FacilityElementE.ClassID=_Zone) and
     ((FacilityElementE as IZone).Zones.Count>0) then Exit;
  if (EtalonElementE.ClassID=_Zone) and
     ((EtalonElementE as IZone).Zones.Count>0) then Exit;

  if FacilityElementE.Ref.Parent=EtalonElementE.Ref.Parent then begin
    if FacilityElementE.ClassID=_Zone then
      Result:=Result+250
    else
      Result:=Result+2500;
  end;

  if FacilityElementE.Ref=EtalonElementE.Ref then begin
    if FacilityElementE.ClassID=_Zone then
      Result:=Result+200
    else
      Result:=Result+2000;
  end;

  m:=0;
  while m<FacilityElementE.FieldCount do begin
    FieldValue0:=FacilityElementE.FieldValue[m];
    FieldValue1:=EtalonElementE.FieldValue[m];
    Field:=FacilityElementE.Field[m];
    if Field.ValueType=fvtElement then begin
      FieldValue0U:=IUnknown(FieldValue0);
      FieldValue1U:=IUnknown(FieldValue1);
      if FieldValue0U<>FieldValue1U then
        Break
      else
        inc(m);
    end else begin
      if FieldValue0<>FieldValue1 then
        Break
      else
        inc(m);
    end;
  end;
  if m=FacilityElementE.FieldCount then begin // все поля равны
    if FacilityElementE.ClassID=_Zone then
      Result:=Result+150
    else
      Result:=Result+1500;
  end;

  if FacilityElementE.ClassID=_Zone then begin
    Zone0:=FacilityElementE as IZone;
    Zone1:=EtalonElementE as IZone;
    Zone0S:=FacilityElementE as ISafeguardUnit;
    Zone1S:=EtalonElementE as ISafeguardUnit;
    Result:=Result+100-abs(Zone0.Category-Zone1.Category);

    m:=0;
    while m<Zone0S.SafeguardElements.Count do
      if Zone0S.SafeguardElements.Item[m].ClassID=_Target then
        Break
      else
        inc(m);
    TargetFlag0:=(m<Zone0S.SafeguardElements.Count);

    m:=0;
    while m<Zone1S.SafeguardElements.Count do
      if Zone1S.SafeguardElements.Item[m].ClassID=_Target then
        Break
      else
        inc(m);
    TargetFlag1:=(m<Zone1S.SafeguardElements.Count);

    if TargetFlag0=TargetFlag1 then
      Result:=Result+50;

    Volume0:=FacilityElementE.SpatialElement as IVolume;
    Volume1:=EtalonElementE.SpatialElement as IVolume;

    HZoneKindList:=TList.Create;
    VZoneKindList:=TList.Create;

    BoundaryKindList:=TList.Create;
    for m:=0 to Volume0.Areas.Count-1 do begin
      aAreaE:=Volume0.Areas.Item[m];
      aBoundaryKind0E:=aAreaE.Ref.Ref;
      if BoundaryKindList.IndexOf(pointer(aBoundaryKind0E))=-1 then
        BoundaryKindList.Add(pointer(aBoundaryKind0E));

      aArea:=aAreaE as IArea;
      if aArea.Volume0=Volume0 then begin
        if aArea.Volume1<>nil then
          aZoneKind0E:=(aArea.Volume1 as IDMElement).Ref.Ref
        else
          aZoneKind0E:=nil
      end else begin
        if aArea.Volume0<>nil then
          aZoneKind0E:=(aArea.Volume0 as IDMElement).Ref.Ref
        else
          aZoneKind0E:=nil
      end;
      if aArea.IsVertical then begin
        if VZoneKindList.IndexOf(pointer(aZoneKind0E))=-1 then
          VZoneKindList.Add(pointer(aZoneKind0E))
      end else begin
        if HZoneKindList.IndexOf(pointer(aZoneKind0E))=-1 then
          HZoneKindList.Add(pointer(aZoneKind0E))
      end;
    end;

    for m:=0 to BoundaryKindList.Count-1 do begin
      aBoundaryKind0E:=IDMElement(BoundaryKindList[m]);
      k:=0;
      while k<Volume1.Areas.Count do begin
        aBoundaryKind1E:=Volume1.Areas.Item[k].Ref.Ref;
        if aBoundaryKind0E=aBoundaryKind1E then
          Break
        else
          inc(k)
      end;
      if k<Volume1.Areas.Count then // есть совпадение типа границ
        Result:=Result+1
    end;
    BoundaryKindList.Free;

    for m:=0 to VZoneKindList.Count-1 do begin
      aZoneKind0E:=IDMElement(VZoneKindList[m]);
      k:=0;
      while k<Zone1.VAreas.Count do begin
        aAreaE:=Zone1.VAreas.Item[k];
        aArea:=aAreaE as IArea;
        if aArea.Volume0=Volume1 then begin
          if aArea.Volume1<>nil then
            aZoneKind1E:=(aArea.Volume1 as IDMElement).Ref.Ref
          else
            aZoneKind1E:=nil
        end else begin
          if aArea.Volume0<>nil then
            aZoneKind1E:=(aArea.Volume0 as IDMElement).Ref.Ref
          else
            aZoneKind1E:=nil
        end;

        if aZoneKind0E=aZoneKind1E then
          Break
        else
          inc(k)
      end;
      if k<Zone1.VAreas.Count then // есть совпадение типа смежных зон
        Result:=Result+5
    end;
    VZoneKindList.Free;


    for m:=0 to VZoneKindList.Count-1 do begin
      aZoneKind0E:=IDMElement(VZoneKindList[m]);
      k:=0;
      while k<Zone1.HAreas.Count do begin
        aAreaE:=Zone1.HAreas.Item[k];
        aArea:=aAreaE as IArea;
        if aArea.Volume0=Volume1 then
          aZoneKind1E:=(aArea.Volume1 as IDMElement).Ref.Ref
        else
          aZoneKind1E:=(aArea.Volume0 as IDMElement).Ref.Ref;

        if aZoneKind0E=aZoneKind1E then
          Break
        else
          inc(k)
      end;
      if k<Zone1.VAreas.Count then // есть совпадение типа смежных зон
        Result:=Result+5
    end;
    HZoneKindList.Free;

  end else begin
    Boundary0:=FacilityElementE as IBoundary;
    Boundary1:=EtalonElementE as IBoundary;
    Zone00E:=Boundary0.Zone0;
    Zone01E:=Boundary0.Zone1;
    Zone10E:=Boundary1.Zone0;
    Zone11E:=Boundary1.Zone1;
    V0:=CompareElements(Zone00E, Zone10E)+CompareElements(Zone01E, Zone11E);
    V1:=CompareElements(Zone00E, Zone11E)+CompareElements(Zone01E, Zone10E);
    if V0>V1 then
      Result:=Result+V0
    else
      Result:=Result+V1;

    if Boundary1.BoundaryLayers.Count>0 then begin
      EtalonLayerKindE:=Boundary1.BoundaryLayers.Item[0].Ref;
      m:=0;
      while m<Boundary0.BoundaryLayers.Count do
        if  Boundary0.BoundaryLayers.Item[m].Ref=EtalonLayerKindE then
          Break
        else
          inc(m);
      if m<Boundary0.BoundaryLayers.Count then // есть совпадающий слой
        Result:=Result+1000
    end;
  end;  //if FacilityElementE.ClassID<>_Zone
  except
    raise
  end;  

end;

function TSafeguardSynthesis.Get_RecomendationVariants: IDMCollection;
begin
  Result:=Collection[_RecomendationVariant]
end;

function TSafeguardSynthesis.Get_TerminateFlag: WordBool;
begin
  Result:=FTerminateFlag
end;

procedure TSafeguardSynthesis.Set_TerminateFlag(Value: WordBool);
begin
  FTerminateFlag:=Value
end;

procedure TSafeguardSynthesis.Analysis;
var
  j:integer;
  EquipmentVariants:IDMCollection;
  EquipmentVariant:IEquipmentVariant;
  EquipmentVariantE, OldEquipmentVariantE:IDMElement;
begin
  EquipmentVariants:=Get_EquipmentVariants;
  EquipmentVariantE:=Get_CurrentEquipmentVariant;
  try
  for j:=0 to EquipmentVariants.Count-1 do begin
    EquipmentVariantE:=EquipmentVariants.Item[j];
    EquipmentVariant:=EquipmentVariantE as IEquipmentVariant;
    Set_CurrentEquipmentVariant(EquipmentVariantE);
    EquipmentVariant.Analysis;
  end;
  finally
    Set_CurrentEquipmentVariant(OldEquipmentVariantE);
  end;
end;

procedure TSafeguardSynthesis.Clear;
var
  Recomendations2, EquipmentVariants2, EquipmentElements2,
  SafeguardElementCollection2:IDMCollection2;
begin
  Recomendations2:=Get_Recomendations as IDMCollection2;
  Recomendations2.Clear;

  EquipmentElements2:=Get_EquipmentElements as  IDMCollection2;
  EquipmentElements2.Clear;

  SafeguardElementCollection2:=FSafeguardElementCollection as IDMCollection2;
  SafeguardElementCollection2.Clear;

  EquipmentVariants2:=Get_EquipmentVariants as IDMCollection2;
  EquipmentVariants2.Clear;

  FCurrentEquipmentVariant:=nil;
end;

{ TSafeguardSynthesisFactory }

function TSafeguardSynthesisFactory.CreateInstance: IUnknown;
begin
  Result:=TSafeguardSynthesis.Create(nil) as IUnknown;
end;

function GetDataModelClassObject:IDMClassFactory;
begin
  Result:=TSafeguardSynthesisFactory.Create(nil) as IDMClassFactory
end;

initialization
//  CreateTypedComObjectFactory(TSafeguardSynthesis, Class_SafeguardSynthesis);
finalization
end.
