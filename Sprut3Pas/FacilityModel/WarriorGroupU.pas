unit WarriorGroupU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  PPathRecord=^TPathRecord;
  TPathRecord=record
    State:IDMElement;
    WarriorPath: IWarriorPath;
  end;

  TWarriorGroup=class(TNamedDMElement, IWarriorGroup,
              IMethodDimItemSource)
  private
    FComment:string;

    FSpatialElement: IDMElement;

    FParents:IDMCollection;

    FTask:integer;

    FWeapons:IDMCollection;
    FVehicles:IDMCollection;
    FTools:IDMCollection;

    FArrivalTimeDispersion:double;

    FPathRecords:TList;

    FStartPoint:Variant;
    FFinishPoint:Variant;
    FBattleSkill: Variant;
    FToolSkill: integer;

  protected
    FInitialNumber:integer;
    FAccesses:IDMCollection;
    FArrivalTime:double;

    class procedure MakeFields0; override;

    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    function Get_Parents:IDMCollection; override;
    function  Get_SpatialElement: IDMElement; override; safecall;
    procedure Set_SpatialElement(const Value: IDMElement); override; safecall;
    procedure Loaded; override; safecall;

    procedure _AddBackRef(const aElement:IDMElement); override;

    function  Get_CollectionCount: Integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
    function  Get_InitialNumber: integer; safecall;
    procedure Set_InitialNumber(Value: integer); safecall;
    function  Get_StartPoint: IDMElement; safecall;
    procedure Set_StartPoint(const Value: IDMElement); safecall;
    function  Get_FinishPoint: IDMElement; safecall;
    procedure Set_FinishPoint(const Value: IDMElement); safecall;

    function Get_Task: integer; safecall;
    procedure Set_Task(Value: integer); safecall;

    function  Get_Weapons:IDMCollection; safecall;
    function  Get_Vehicles:IDMCollection; safecall;
    function Get_Tools:IDMCollection; safecall;
    function  Get_ArrivalTime: double; virtual; safecall;
    procedure Set_ArrivalTime(Value: double); virtual; safecall;
    function  Get_ArrivalTimeDispersion: double; safecall;
    procedure Set_ArrivalTimeDispersion(Value: double); safecall;
    function  Get_FastPath:IWarriorPath; safecall;
    procedure ClearAllPaths; safecall;
    procedure StorePath(const aFastPath:IWarriorPath); safecall;
    function  Get_BattleSkill: IDMElement; safecall;
    function  Get_ToolSkill: integer; safecall;
    function Get_Accesses:IDMCollection; safecall;
    function GetAccessTypeToZone(const ZoneE:IDMElement;
                                 InCurrentState:WordBool):integer; virtual; safecall;
    function  GetAccessType(const Element: IDMElement;
               InCurrentState:WordBool): Integer; safecall;

    function Get_StartNode(const FacilityStateE:IDMElement):ICoordNode; virtual;
    function Get_FinishNode(const FacilityStateE:IDMElement):ICoordNode;
    function AcceptableMethod(const OvercomeMethodE:IDMElement): WordBool; virtual; safecall;
    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; virtual; safecall;

    procedure SetInitialNumber(Value: integer); safecall;
    function GetPotential:double; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;

    procedure MakeDefaultAttribute; virtual;

  end;

implementation
uses
  FacilityModelConstU;


procedure TWarriorGroup.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);

  FWeapons:=DataModel.CreateCollection(_Weapon, SelfE);
  FVehicles:=DataModel.CreateCollection(_Vehicle, SelfE);
  FTools:=DataModel.CreateCollection(_Tool, SelfE);
  FAccesses:=DataModel.CreateCollection(_Access, SelfE);

  FPathRecords:=TList.Create;

  if not DataModel.IsLoading then
    MakeDefaultAttribute;
end;

procedure TWarriorGroup._Destroy;
begin
  inherited ;

  FWeapons:=nil;
  FVehicles:=nil;
  FTools:=nil;
  FAccesses:=nil;

  ClearAllPaths;
  FPathRecords.Free;
end;

function TWarriorGroup.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

procedure TWarriorGroup.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(wapFinishPoint):
    theCollection:=(DataModel as IFacilityModel).Targets;
  ord(wapBattleSkill):
    theCollection:=((DataModel as IFacilityModel).SafeguardDatabase as ISafeguardDatabase).BattleSkills;
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

function TWarriorGroup.Get_StartPoint: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FStartPoint;
  Result:=Unk as IDMElement
end;

function TWarriorGroup.Get_FinishPoint: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FFinishPoint;
  Result:=Unk as IDMElement
end;

procedure TWarriorGroup.Set_StartPoint(const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FStartPoint:=Unk;
end;

procedure TWarriorGroup.Set_FinishPoint(const Value: IDMElement);
var
  Unk:IUnknown;
  FinishPointE:IDMElement;
begin
  Unk:=Value as IUnknown;
  FFinishPoint:=Unk;
  FinishPointE:=Get_FinishPoint;
  if FinishPointE<>nil then
    FinishPointE._AddBackRef(Self as IDMElement);
end;

function TWarriorGroup.Get_InitialNumber: integer;
begin
  Result:=FInitialNumber
end;

procedure TWarriorGroup.Set_InitialNumber(Value: integer);
var
  Weapon:IWeapon;
  WeaponE:IDMElement;
  j:integer;
begin
  FInitialNumber:=Value;
  if FWeapons=nil then Exit;
  
  for j:=0 to FWeapons.Count-1 do begin
    WeaponE:=FWeapons.Item[j];
    Weapon:=WeaponE as IWeapon;
    if WeaponE.Ref.Parent.ID=wtArmWeapon then // стрелковое оружие
      Weapon.Count:=FInitialNumber
  end;
end;

function TWarriorGroup.Get_StartNode(const FacilityStateE: IDMElement):ICoordNode;
var
  SafeguardElementA:IPathNodeArray;
  FacilityState:IFacilityState;
begin
  SafeguardElementA:=Get_StartPoint as IPathNodeArray;
  if SafeguardElementA<>nil then begin
    FacilityState:=FacilityStateE as IFacilityState;
    Result:=SafeguardElementA.PathNodes.Item[FacilityState.GraphIndex] as ICoordNode;
  end else
    Result:=nil;
end;

function TWarriorGroup.Get_FinishNode(const FacilityStateE: IDMElement):ICoordNode;
var
  SafeguardElementA:IPathNodeArray;
  FacilityState:IFacilityState;
begin
  SafeguardElementA:=Get_FinishPoint as IPathNodeArray;
  if SafeguardElementA<>nil then begin
    FacilityState:=FacilityStateE as IFacilityState;
    Result:=SafeguardElementA.PathNodes.Item[FacilityState.GraphIndex] as ICoordNode;
  end else
    Result:=nil;
end;


function TWarriorGroup.AcceptableMethod(const OvercomeMethodE:IDMElement): WordBool;
var
  j:integer;
  OvercomeMethod:IOvercomeMethod;
  aWeaponTypeE, aVehicleTypeE, aToolTypeE:IDMElement;
begin
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  Result:=False;

  for j:=0 to OvercomeMethod.WeaponTypes.Count-1 do begin
    aWeaponTypeE:=OvercomeMethod.WeaponTypes.Item[j];
    if (FWeapons as IDMCollection2).GetItemByRefParent(aWeaponTypeE)=nil then Exit;
  end;                         //  у нарушителей нет нужного оружия

  for j:=0 to OvercomeMethod.VehicleTypes.Count-1 do begin
    aVehicleTypeE:=OvercomeMethod.VehicleTypes.Item[j];
    if (FVehicles as IDMCollection2).GetItemByRefParent(aVehicleTypeE)=nil then Exit;
  end;                      //  у нарушителей нет нужного транспорта

  for j:=0 to OvercomeMethod.ToolTypes.Count-1 do begin
    aToolTypeE:=OvercomeMethod.ToolTypes.Item[j];
    if (FTools as IDMCollection2).GetItemByRefParent(aToolTypeE)=nil then Exit;
  end;                      //  у нарушителей нет нужного транспорта

  Result:=True;

end;

function TWarriorGroup.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(wapNumber):
    Result:=FInitialNumber;
  ord(wapStartPoint):
    Result:=FStartPoint;
  ord(wapFinishPoint):
    Result:=FFinishPoint;
  ord(wapBattleSkill):
    Result:=FBattleSkill;
  ord(wapToolSkill):
    Result:=FToolSkill;
  ord(wapTask):
    Result:=FTask;
  ord(cnstComment):
    Result:=FComment;
  else
    Result:=inherited Get_FieldValue(Code);
  end;
end;

procedure TWarriorGroup.SetFieldValue(Code: integer;
  Value: OleVariant);
var
  StartPointE, FinishPointE:IDMElement;
begin
  case Code of
  ord(wapNumber):
    begin
      FInitialNumber:=Value;
      Set_InitialNumber(FInitialNumber);
    end;  
  ord(wapStartPoint):
    if not DataModel.IsLoading then begin
      SetUnkValue(FStartPoint, Value);
      StartPointE:=Get_StartPoint;
      if StartPointE<>nil then
        StartPointE._AddBackRef(Self as IDMElement);
    end else
      FStartPoint:=Value;
  ord(wapFinishPoint):
    if not DataModel.IsLoading then begin
      SetUnkValue(FFinishPoint, Value);
      FinishPointE:=Get_FinishPoint;
      if FinishPointE<>nil then
        FinishPointE._AddBackRef(Self as IDMElement);
    end else
      FFinishPoint:=Value;
  ord(wapBattleSkill):
    FBattleSkill:=Value;
  ord(wapToolSkill):
    FToolSkill:=Value;
  ord(wapTask):
    FTask:=Value;
  ord(cnstComment):
    FComment:=Value;
  else
    inherited;
  end;
end;

class procedure TWarriorGroup.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsComment, '', '', '',
           fvtText, 0, 0, 0,
           cnstComment, 0, pkComment);
  AddField(rsWarriorNumber, '%3d', '', '',
                 fvtInteger, 1, 0, 0,
                 ord(wapNumber), 0, pkInput);
  AddField(rsTarget, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(wapFinishPoint), 0, pkInput);
  AddField(rsBattleSkill, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(wapBattleSkill), 0, pkInput);
  S:='|'+rsLowLevel+
     '|'+rsMediumLevel+
     '|'+rsHighLevel;
  AddField(rsToolSkill, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(wapToolSkill), 0, pkInput);
  AddField(rsStartPoint, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(wapStartPoint), 0, pkInput);
end;

function TWarriorGroup.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  ord(wcWeapons):
    Result:=FWeapons;
  ord(wcVehicles):
    Result:=FVehicles;
  ord(wcTools):
    Result:=FTools;
  ord(wcAccesses):
    Result:=FAccesses;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

procedure TWarriorGroup.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  SafeguardDatabase:ISafeguardDatabase;
begin
  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;
  case Index of
  ord(wcWeapons):
    begin
      aRefSource:=SafeguardDatabase.WeaponKinds;
      aCollectionName:=rsWeapons;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  ord(wcVehicles):
    begin
      aRefSource:=SafeguardDatabase.VehicleKinds;
      aCollectionName:=rsVehicles;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  ord(wcTools):
    begin
      aRefSource:=SafeguardDatabase.ToolKinds;
      aCollectionName:=rsTools;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  ord(wcAccesses):
    begin
      aRefSource:=(DataModel as IFacilityModel).Zones;
      aCollectionName:=rsAccesses;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  else
    inherited
  end;
end;

function TWarriorGroup.Get_Vehicles: IDMCollection;
begin
  Result:=FVehicles
end;

function TWarriorGroup.Get_Weapons: IDMCollection;
begin
  Result:=FWeapons
end;


function TWarriorGroup.Get_CollectionCount: Integer;
begin
  Result:=ord(high(TWarriorCategory))+1
end;

function TWarriorGroup.Get_ArrivalTime: double;
begin
  Result:=FArrivalTime
end;

procedure TWarriorGroup.Set_ArrivalTime(Value: double);
begin
  FArrivalTime:=Value
end;

function TWarriorGroup.GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer;
var
  k, j:integer;
  VehicleE, VehicleTypeE,
  ToolE, ToolTypeE:IDMElement;
  WeaponE, WeaponTypeE, WeaponKindE:IDMElement;
  ToolKind:IToolKind;
  Weight:double;
  Target:ITarget;
  FacilityModelS:IFMState;
  DimensionItem:IDMField;
  MaxSize, Size:double;
  WeaponKind:IWeaponKind;
  BattleSkill:IBattleSkill;
begin
  case Kind of
  sdToolSkillLevel:
    case Code of
    0: Result:=FToolSkill;
    1: begin
         BattleSkill:=Get_BattleSkill as IBattleSkill;
         Result:=BattleSkill.SkillLevel;
       end;
    else
       Result:=0;
    end;
  sdWeaponType:
    begin
      case Code of
      0:begin
          if DimItems.Count>0 then begin
            WeaponTypeE:=DimItems.Item[Code];
            WeaponE:=(FWeapons as IDMCollection2).GetItemByRefParent(WeaponTypeE);
            if WeaponE<>nil then
              Result:=1
            else
              Result:=0
          end else
            if FWeapons.Count=0 then
              Result:=1
            else
              Result:=0
        end;
      1:if FWeapons.Count=0 then
          Result:=0
        else begin
          MaxSize:=0;
          for j:=0 to FWeapons.Count-1 do begin
            WeaponKindE:=FWeapons.Item[j].Ref;
            WeaponKind:=WeaponKindE as IWeaponKind;
            Size:=WeaponKind.MaxLength;
            if MaxSize<Size then
              MaxSize:=Size;
          end;
          if MaxSize<0.5 then
            Result:=1
          else
          if MaxSize<2 then
            Result:=2
          else
          if FVehicles.Count>0 then
            Result:=3
          else
            Result:=4
        end;
      end;
    end;
  sdWeaponKind:
    begin
      WeaponTypeE:=DimItems.Item[Code];
      WeaponE:=(FWeapons as IDMCollection2).GetItemByRefParent(WeaponTypeE);
      if WeaponE<>nil then begin
        k:=WeaponTypeE.SubKinds.IndexOf(WeaponE.Ref);
        Result:=k+1
      end else
        Result:=0
    end;
  sdVehicleType:
    begin
      VehicleTypeE:=DimItems.Item[Code];
      VehicleE:=(FVehicles as IDMCollection2).GetItemByRefParent(VehicleTypeE);
      if VehicleE<>nil then
        Result:=1
      else
        Result:=0
    end;
  sdVehicleKind:
    begin
      VehicleTypeE:=DimItems.Item[Code];
      VehicleE:=(FVehicles as IDMCollection2).GetItemByRefParent(VehicleTypeE);
      if VehicleE<>nil then begin
        k:=VehicleTypeE.SubKinds.IndexOf(VehicleE.Ref);
        Result:=k+1
      end else
        Result:=0
    end;
  sdToolType:
    begin
      ToolTypeE:=DimItems.Item[Code];
      ToolE:=(FTools as IDMCollection2).GetItemByRefParent(ToolTypeE);
      if ToolE<>nil then
        Result:=1
      else
        Result:=0
    end;
  sdToolKind:
    begin
      ToolTypeE:=DimItems.Item[Code];
      ToolE:=(FTools as IDMCollection2).GetItemByRefParent(ToolTypeE);
      if ToolE<>nil then begin
        k:=ToolTypeE.SubKinds.IndexOf(ToolE.Ref);
        Result:=k+1;
      end else
        Result:=0
    end;
  sdWeight:
    begin
      if ClassID=_GuardGroup then
        Result:=0
      else begin
        Weight:=0;
        for j:=0 to FTools.Count-1 do begin
          ToolKind:=FTools.Item[j].Ref as IToolKind;
          Weight:=Weight+ToolKind.Mass;
        end;
        if FTask=MainGroup then begin
          FacilityModelS:=DataModel as IFMState;
          case FacilityModelS.CurrentPathStage of
          wpsStealthExit,
          wpsFastExit:
            begin
              Target:=Get_FinishPoint as ITarget;
              Weight:=Weight+Target.Mass;
            end;
          end;
        end;
        k:=0;
        while k<DimItems.Count-1 do begin
          DimensionItem:=DimItems.Item[k] as IDMField;
          if (Weight>=DimensionItem.MinValue) and
             (Weight<DimensionItem.MaxValue) then
            Break
          else
            inc(k)
        end;
        Result:=k;
      end;
    end;
  sdSize:
    begin
      if ClassID=_GuardGroup then
        Result:=0
      else begin
        MaxSize:=0;
        for j:=0 to FWeapons.Count-1 do begin
          WeaponKindE:=FWeapons.Item[j].Ref;
          WeaponKind:=WeaponKindE as IWeaponKind;
          Size:=WeaponKind.MaxLength;
          if MaxSize<Size then
            MaxSize:=Size;
        end;
        for j:=0 to FTools.Count-1 do begin
          ToolKind:=FTools.Item[j].Ref as IToolKind;
          Size:=ToolKind.MaxLength;
          if MaxSize<Size then
            MaxSize:=Size;
        end;
        if FTask=MainGroup then begin
          FacilityModelS:=DataModel as IFMState;
          case FacilityModelS.CurrentPathStage of
          wpsStealthExit,
          wpsFastExit:
            begin
              Target:=Get_FinishPoint as ITarget;
              Size:=Target.MaxSize;
              if MaxSize<Size then
                 MaxSize:=Size;
            end;
          end;
        end;
        k:=0;
        while k<DimItems.Count-1 do begin
          DimensionItem:=DimItems.Item[k] as IDMField;
          if (MaxSize>=DimensionItem.MinValue) and
             (MaxSize<DimensionItem.MaxValue) then
            Break
          else
            inc(k)
        end;
        Result:=k;
      end;
    end;
  sdHasMetall:
    begin
      if ClassID=_GuardGroup then
        Result:=0
      else begin
        Result:=1;
        for j:=0 to FWeapons.Count-1 do begin
          WeaponKindE:=FWeapons.Item[j].Ref;
          WeaponKind:=WeaponKindE as IWeaponKind;
          if WeaponKind.HasMetall then Exit;
        end;
        for j:=0 to FTools.Count-1 do begin
          ToolKind:=FTools.Item[j].Ref as IToolKind;
          if ToolKind.HasMetall then Exit;
        end;
        if FTask=MainGroup then begin
          FacilityModelS:=DataModel as IFMState;
          case FacilityModelS.CurrentPathStage of
          wpsStealthExit,
          wpsFastExit:
            begin
              Target:=Get_FinishPoint as ITarget;
              if Target.HasMetall then Exit;
            end;
          end;
        end;
        Result:=0;
      end;  
    end;
  else
    Result:=-1;
  end;
end;

procedure TWarriorGroup.ClearAllPaths;
var
  FacilityModel:IFacilityModel;
  PathRecord:PPathRecord;
  j:integer;
begin
  FacilityModel:=DataModel as IFacilityModel;
  for j:=0 to FPathRecords.Count-1 do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    PathRecord.State:=nil;
//    WarriorPathE:=PathRecord.WarriorPath as IDMElement;
//    WarriorPathE.Clear;
//    (FacilityModel.WarriorPaths as IDMCollection2).Remove(WarriorPathE);
    PathRecord.WarriorPath:=nil;
    FreeMem(PathRecord, SizeOf(TPathRecord));
  end;
  FPathRecords.Clear
end;

procedure TWarriorGroup.StorePath(const aFastPath:IWarriorPath);
var
  PathRecord:PPathRecord;
begin
  GetMem(PathRecord, SizeOf(TPathRecord));
  FillChar(PathRecord^, SizeOf(TPathRecord), 0);
  FPathRecords.Add(PathRecord);
  PathRecord^.State:=(DataModel as IFMState).CurrentFacilityStateU as IDMElement;
  PathRecord^.WarriorPath:=aFastPath;
end;

function TWarriorGroup.Get_FastPath: IWarriorPath;
var
  State:IDMElement;
  j:integer;
  PathRecord:PPathRecord;
begin
  State:=(DataModel as IFMState).CurrentFacilityStateU as IDMElement;
  PathRecord:=nil;
  j:=0;
  while j<FPathRecords.Count do begin
    PathRecord:=PPathRecord(FPathRecords[j]);
    if PathRecord^.State=State then
      Break
    else
      inc(j)
  end;
  if j<FPathRecords.Count then
    Result:=PathRecord^.WarriorPath
  else
    Result:=nil;
end;

function TWarriorGroup.Get_BattleSkill: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FBattleSkill;
  Result:=Unk as IDMElement
end;

function TWarriorGroup.Get_SpatialElement: IDMElement;
begin
  Result:=FSpatialElement
end;

procedure TWarriorGroup.Set_SpatialElement(const Value: IDMElement);
var
  OldSpatialElement:IDMElement;
begin
  OldSpatialElement:=Get_SpatialElement;
  if OldSpatialElement = Value then Exit;

  FSpatialElement := Value;

  if OldSpatialElement<>nil then
    OldSpatialElement.Ref:=nil;
end;

procedure TWarriorGroup._AddBackRef(const aElement: IDMElement);
var
  Unk:IUnknown;
begin
  inherited;
  if aElement.QueryInterface(ICoordNode, Unk)=0 then
    Set_SpatialElement(aElement);
end;

function TWarriorGroup.Get_Task: integer;
begin
  Result:=FTask
end;

procedure TWarriorGroup.Set_Task(Value: integer);
begin
  FTask:=Value
end;

procedure TWarriorGroup.Loaded;
var
  StartPointE:IDMElement;
begin
  inherited;
  StartPointE:=Get_StartPoint;
  if StartPointE<>nil then
    StartPointE._AddBackRef(Self as IDMElement);
end;

function TWarriorGroup.Get_Tools: IDMCollection;
begin
  Result:=FTools
end;

function TWarriorGroup.Get_ToolSkill: integer;
begin
  Result:=FToolSkill;
end;

procedure TWarriorGroup.MakeDefaultAttribute;
var
  aCollection2:IDMCollection2;
  AttributeE, AttributeKindE:IDMElement;
  AttributeKind:IWarriorAttributeKind;
  SafeguardDatabase:ISafeguardDatabase;
  j:integer;
begin
  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;

  aCollection2:=(DataModel as IFacilityModel).Weapons as IDMCollection2;
  for j:=0 to SafeguardDatabase.WeaponKinds.Count-1 do begin
    AttributeKindE:=SafeguardDatabase.WeaponKinds.Item[j];
    AttributeKind:=AttributeKindE as IWarriorAttributeKind;
    if AttributeKind.IsDefault then begin
      AttributeE:=aCollection2.CreateElement(False);
      aCollection2.Add(AttributeE);
      AttributeE.Ref:=AttributeKindE;
      AttributeE.Parent:=Self as IDMElement;
    end;
  end;
end;

procedure TWarriorGroup.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
  SafeguardDatabase:ISafeguardDatabase;
begin
  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;
  case Index of
  ord(wcWeapons):
    SourceCollection:=SafeguardDatabase.WeaponKinds;
  ord(wcVehicles):
    SourceCollection:=SafeguardDatabase.VehicleKinds;
  ord(wcTools):
    SourceCollection:=SafeguardDatabase.ToolKinds;
  ord(wcAccesses):
    SourceCollection:=(DataModel as IFacilityModel).Zones;
  else
    SourceCollection:=nil;
  end;

  aCollection2:=aCollection as IDMCollection2;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do
    aCollection2.Add(SourceCollection.Item[j]);
end;

function TWarriorGroup.Get_Accesses: IDMCollection;
begin
  Result:=FAccesses
end;

function TWarriorGroup.GetAccessTypeToZone(const ZoneE: IDMElement;
                                             InCurrentState:WordBool): integer;
var
  ParentZoneE, aZoneE, CurrentState, AccessE:IDMElement;
  ParentZone, aZone:IZone;
  j:integer;
  Access:IAccess;
  FacilityModelS:IFMState;
begin
  Result:=1;
  if ZoneE=nil then Exit;

  Access:=nil;
  j:=0;
  while j<FAccesses.Count do begin
    AccessE:=FAccesses.Item[j];
    Access:=AccessE as IAccess;
    aZone:=AccessE.Ref as IZone;
    if (Access.AccessRegion=0) and
       aZone.Contains(ZoneE) then begin
     if InCurrentState then begin
       if (Access.FacilityStates.Count=0) or
          (Access.FacilityStates.IndexOf(CurrentState)<>-1) then
         Break
       else
         inc(j)
     end else
       Break
    end else
      inc(j)
  end;
  if j=FAccesses.Count then
    Result:=0
  else begin
    Result:=1;
    Exit;
  end;

  aZoneE:=ZoneE;
  ParentZoneE:=aZoneE.Parent;
  while ParentZoneE<>nil do begin
    aZone:=aZoneE as IZone;
    ParentZone:=ParentZoneE as IZone;
    if ParentZone.Category<aZone.Category then Break;
    aZoneE:=ParentZoneE;
    ParentZoneE:=aZoneE.Parent;
  end;

  if InCurrentState then begin
    FacilityModelS:=DataModel as IFMState;
    CurrentState:=FacilityModelS.CurrentFacilityStateU as IDMElement;
    if CurrentState.ClassID<>_FacilityState then begin
      CurrentState:=(FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant).FacilityState;
    end;
  end else
    CurrentState:=nil;

  Access:=nil;
  j:=0;
  while j<FAccesses.Count do begin
    AccessE:=FAccesses.Item[j];
    Access:=AccessE as IAccess;
    if aZone.Contains(AccessE.Ref) then begin
     if InCurrentState then begin
       if (Access.FacilityStates.Count=0) or
          (Access.FacilityStates.IndexOf(CurrentState)<>-1) then
         Break
       else
         inc(j)
     end else
       Break
    end else
      inc(j)
  end;
  if j=FAccesses.Count then
    Result:=0
  else
    Result:=1
end;

procedure TWarriorGroup.SetInitialNumber(Value: integer);
begin
  FInitialNumber:=Value;
end;

function TWarriorGroup.GetAccessType(const Element: IDMElement;
  InCurrentState: WordBool): Integer;
var
  Boundary:IBoundary;
  Zone0E, Zone1E:IDMElement;
  AccessType0, AccessType1:integer;
begin
  try
  case Element.ClassID of
  _Zone:
      Result:=GetAccessTypeToZone(Element, InCurrentState);
  _Boundary,
  _Jump,
  _Target:
    begin
      Boundary:=Element as IBoundary;
      Zone0E:=Boundary.Zone0;
      Zone1E:=Boundary.Zone1;
      Result:=3;
      AccessType0:=GetAccessTypeToZone(Zone0E, InCurrentState);
      if (Zone0E<>nil) and
        (Result>AccessType0) then
        Result:=AccessType0;
      AccessType1:=GetAccessTypeToZone(Zone1E, InCurrentState);
      if (Zone1E<>nil) and
        (Result>AccessType1) then
        Result:=AccessType1;
    end;
  else
      Result:=0;
  end;
  except
    raise
  end
end;

function TWarriorGroup.GetPotential: double;
var
  SkillCoeff:double;
  j:integer;
  WeaponKind:IWeaponKind;
  ShotRate, MaxShotRate:double;
  WeaponE:IDMElement;
begin
  case Get_BattleSkill.ID of
  0: SkillCoeff:=1;
  1: SkillCoeff:=4;
  2: SkillCoeff:=16;
  else
    SkillCoeff:=1;
  end;
  MaxShotRate:=1;
  for j:=0 to FWeapons.Count-1 do begin
    WeaponE:=FWeapons.Item[j];
    WeaponKind:=WeaponE.Ref as IWeaponKind;
    ShotRate:=WeaponKind.ShotRate;
    if MaxShotRate<ShotRate then
      MaxShotRate:=ShotRate;
  end;
  Result:=SkillCoeff*FInitialNumber*MaxShotRate;
end;

function TWarriorGroup.Get_ArrivalTimeDispersion: double;
begin
  Result:=FArrivalTimeDispersion
end;

procedure TWarriorGroup.Set_ArrivalTimeDispersion(Value: double);
begin
  FArrivalTimeDispersion:=Value
end;

end.
