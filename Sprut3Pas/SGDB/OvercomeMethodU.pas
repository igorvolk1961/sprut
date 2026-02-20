unit OvercomeMethodU;

interface
uses
  DM_Windows,
  Classes, SysUtils,
  DMElementU, DataModel_TLB, DMServer_TLB, SgdbLib_TLB{, FacilityModelLIb_TLB};

type
  TOvercomeMethod=class;

  TCalcDelayTime = procedure (WarriorGroupU, FacilityStateU, LineU,
            SafeguardElementU: IUnknown;
            OvercomeMethod:IOvercomeMethod;
            var DelayTime: double);

  TCalcDetectionProbability = procedure (WarriorGroupU, FacilityStateU, LineU,
            SafeguardElementU: IUnknown;
            OvercomeMethod:IOvercomeMethod;
            var DetectionProbability: double);

  TCalcPhysicalFields = procedure (WarriorGroupU, FacilityStateU,
            SafeguardElementU:IUnknown;
            OvercomeMethod:IOvercomeMethod);


  TOvercomeMethod=class(TDMArray, IOvercomeMethod)
  private
    FParents:IDMCollection;

    FToolTypes:IDMCollection;
    FVehicleTypes:IDMCollection;
    FWeaponTypes:IDMCollection;
    FSkillTypes:IDMCollection;
    FAthorityTypes:IDMCollection;
    FPhysicalFields:IDMCollection;
    FPhysicalFieldValues:TList;
    FDeviceStates:IDMCollection;
    FTactics:IDMCollection;

    FCalcDelayTimeHandle:integer;
    FCalcDetectionProbabilityHandle:integer;
    FCalcPhysicalFieldsHandle:integer;

    FCalcDelayProc:string;
    FCalcDelayLib:string;
    FCalcProbabilityProc:string;
    FCalcProbabilityLib:string;
    FCalcFieldsProc:string;
    FCalcFieldsLib:string;
    FDelayProcCode:integer;
    FProbabilityProcCode:integer;
    FFieldsProcCode:integer;

    FObserverParam:boolean;
    FDependsOnReliability:boolean;
    FFailure: boolean;
    FEvidence: boolean;
    FAssessRequired: boolean;
    FDestructive: boolean;

    procedure BuildArrayValueMatrix(const Space0:string;
           const ArrayValue0:IDMArrayValue;
           const Report:IDMText;
           DimensionIndex0:integer);
  protected
    function Get_Parents:IDMCollection; override;
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    procedure Loaded; override;

    class function  GetClassID:integer; override;

    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure _AddChild(const aChild:IDMElement); override;
    procedure _RemoveChild(const aChild:IDMElement); override;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure AfterCopyFrom(const SourceElement:IDMElement); override; safecall;

    function  Get_PhysicalFieldValue(Index: integer): double; safecall;
    procedure Set_PhysicalFieldValue(Index: integer; Value: double); safecall;
    function  Get_PhysicalFields:IDMCollection; safecall;
    function  Get_ToolTypes:IDMCollection; safecall;
    function  Get_VehicleTypes:IDMCollection; safecall;
    function  Get_WeaponTypes:IDMCollection; safecall;
    function  Get_AthorityTypes:IDMCollection; safecall;
    function  Get_DeviceStates:IDMCollection; safecall;
    function  Get_Tactics:IDMCollection; safecall;
    function  Get_SkillTypes:IDMCollection; safecall;
    function  Get_DelayProcCode:integer; safecall;
    function  Get_ProbabilityProcCode:integer; safecall;
    function  Get_FieldsProcCode:integer; safecall;


    function  Get_CalcDelayProc:String;
    function  Get_CalcDelayLib:String;
    function  Get_CalcProbabilityProc:String;
    function  Get_CalcProbabilityLib:String;
    function  Get_CalcFieldsProc:String;
    function  Get_CalcFieldsLib:String;

    function GetDelayTime(const WarriorGroupU, FacilityStateU, LineU,
                          SafeguardElementU:IUnknown;
                          const Report:IDMText):double; safecall;
    function GetDetectionProbability(const WarriorGroupU, FacilityStateU, LineU,
                          SafeguardElementU:IUnknown;
                          const Report:IDMText):double; safecall;
    procedure CalcPhysicalFields(const WarriorGroupU, FacilityStateU, LineU,
                          SafeguardElementU:IUnknown); safecall;
    function AcceptableForTactic(const TacticU:IUnknown): WordBool; safecall;


    function  CreateValue:IDMElement; override; safecall;
    procedure RemoveValue(const aValue:IDMElement); override; safecall;
    procedure BuildReport(ReportLevel: Integer; TabCount: Integer;  Mode: Integer;
                  const Report: IDMText); override; safecall;

    function  Get_Failure: WordBool; safecall;
    function  Get_Evidence: WordBool; safecall;
    function  Get_AssessRequired: WordBool; safecall;
    function  Get_ObserverParam: WordBool; safecall;
    function  Get_DependsOnReliability: WordBool; safecall;
    function  Get_Destructive: WordBool; safecall;

    function GetValueFromMatrix(const WarriorGroupU,
                          SafeguardElementU, LineU:IUnknown;
                          Time:double; ValueKind:integer;
                          const Report:IDMText):double; safecall;
    function GetValueByCodeFromMatrix(const WarriorGroupU,
                          SafeguardElementU, LineU:IUnknown;
                          Time:double; ValueKind:integer;
                          const Report:IDMText):double; safecall;

    procedure Initialize; override;
    procedure  Clear; override;
    procedure  _Destroy; override;
  end;

  TOvercomeMethods=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU,
  PhysicalFieldU;

var
  FFields:IDMCollection;
  Flag:boolean;

{ TOvercomeMethod }

procedure TOvercomeMethod.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);

  FToolTypes:=DataModel.CreateCollection(_ToolType, SelfE);
  FVehicleTypes:=DataModel.CreateCollection(_VehicleType, SelfE);
  FWeaponTypes:=DataModel.CreateCollection(_WeaponType, SelfE);
  FSkillTypes:=DataModel.CreateCollection(_SkillType, SelfE);
  FAthorityTypes:=DataModel.CreateCollection(_AthorityType, SelfE);
  FDeviceStates:=DataModel.CreateCollection(_DeviceState, SelfE);
  FPhysicalFields:=DataModel.CreateCollection(_PhysicalField, SelfE);
  FTactics:=DataModel.CreateCollection(_Tactic, SelfE);

  FPhysicalFieldValues:=TList.Create;

  FDelayProcCode:=1;
  FProbabilityProcCode:=1;
  FFieldsProcCode:=1;

  FDimensions:=DataModel.CreateCollection(_sgMethodDimension, SelfE);
end;

procedure TOvercomeMethod._Destroy;
begin
try
  inherited;
  FParents:=nil;
  FToolTypes:=nil;
  FVehicleTypes:=nil;
  FWeaponTypes:=nil;
  FSkillTypes:=nil;
  FAthorityTypes:=nil;
  FDeviceStates:=nil;
  FTactics:=nil;
  FPhysicalFields:=nil;

  TPhysicalFieldValues(FPhysicalFieldValues).FreeValues;
  FPhysicalFieldValues.Free;
except
  raise
end;    
end;

class function TOvercomeMethod.GetClassID: integer;
begin
  Result:=_OvercomeMethod
end;

function TOvercomeMethod.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

procedure TOvercomeMethod._AddChild(const aChild: IDMElement);
var
  PhysicalField:IPhysicalField;
begin
  if aChild.QueryInterface(IPhysicalField, PhysicalField)<>0 then Exit;
  TPhysicalFieldValues(FPhysicalFieldValues).AddValue(PhysicalField)
end;

procedure TOvercomeMethod._RemoveChild(const aChild: IDMElement);
var
  PhysicalField:IPhysicalField;
begin
  if aChild.QueryInterface(IPhysicalField, PhysicalField)<>0 then Exit;
  TPhysicalFieldValues(FPhysicalFieldValues).RemoveValue(PhysicalField)
end;

function TOvercomeMethod.Get_CollectionCount: integer;
begin
  Result:=ord(high(TOvercomeMethodCategory))+1;
end;

procedure TOvercomeMethod.CalcPhysicalFields(const WarriorGroupU,
          FacilityStateU, LineU, SafeguardElementU:IUnknown);
var
  CalcPhysicalFields:TCalcPhysicalFields;
  ProcName:array[0..255] of Char;
begin
  if FCalcPhysicalFieldsHandle<>0 then begin
    StrPCopy(ProcName, FCalcFieldsProc);
    @CalcPhysicalFields:=DM_GetProcAddress(FCalcPhysicalFieldsHandle,
                                        ProcName);
    if @CalcPhysicalFields<>nil then
      CalcPhysicalFields(WarriorGroupU,
                      FacilityStateU, SafeguardElementU, Self as IOvercomeMethod)
    else begin
      DataModel.HandleError
      ('Ошибка в процедуре TOvercomeMethod.CalcPhysicalFields');
    end;
  end else
    TPhysicalFieldValues(FPhysicalFieldValues).ResetValues
end;

function TOvercomeMethod.GetDelayTime(const WarriorGroupU, FacilityStateU, LineU,
                          SafeguardElementU:IUnknown;
                          const Report:IDMText): double;
var
  CalcDelayTime:TCalcDelayTime;
  ProcName:array[0..255] of Char;
  S:WideString;
begin
  if FCalcDelayTimeHandle<>0 then begin
    StrPCopy(ProcName, FCalcDelayProc);
    @CalcDelayTime:=DM_GetProcAddress(FCalcDelayTimeHandle,
                                   ProcName);
    if Report<>nil then begin
      S:=Format('               Время задержки вычисляется во внешней процедуре %s из модуля %s',
      [FCalcDelayProc, FCalcDelayLib]);
    end;

    if @CalcDelayTime<>nil then
      CalcDelayTime(WarriorGroupU, FacilityStateU, LineU,
                    SafeguardElementU, Self as IOvercomeMethod, Result)
    else begin
      DataModel.HandleError
      ('Ошибка в прцедуре TOvercomeMethod.CalcDelayTime');
    end;
  end else
    Result:=0;
end;

function TOvercomeMethod.GetDetectionProbability(
         const WarriorGroupU, FacilityStateU, LineU,
         SafeguardElementU:IUnknown;
         const Report:IDMText): double;
var
  CalcDetectionProbability:TCalcDetectionProbability;
  ProcName:array[0..255] of Char;
  S:WideString;
begin
  if FCalcDetectionProbabilityHandle<>0 then begin
    StrPCopy(ProcName, FCalcProbabilityProc);
    @CalcDetectionProbability:=DM_GetProcAddress(FCalcDetectionProbabilityHandle,
                                              ProcName);
    if Report<>nil then begin
      S:=Format('               Вероятность обнаружения вычисляется во внешней процедуре %s из модуля %s',
      [FCalcProbabilityProc, FCalcProbabilityLib]);
    end;

    if @CalcDetectionProbability<>nil then
      CalcDetectionProbability(WarriorGroupU, FacilityStateU, LineU,
                               SafeguardElementU, Self as IOvercomeMethod, Result)
    else begin
      DataModel.HandleError
        ('Ошибка в прцедуре TOvercomeMethod.CalcDetectionProbability');
    end;
  end else
    Result:=0;
end;

function TOvercomeMethod.AcceptableForTactic(
  const TacticU: IUnknown): WordBool;
var
  TacticE:IDMElement;
begin
  if TacticU=nil then
    Result:=not Get_ObserverParam
  else begin
    TacticE:=TacticU as IDMElement;
    Result:=(FTactics.IndexOf(TacticE)<>-1);
  end;  
end;

function TOvercomeMethod.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(ompDelayProcCode):
    Result:=FDelayProcCode;
  ord(ompProbabilityProcCode):
    Result:=FProbabilityProcCode;
  ord(ompFieldsProcCode):
    Result:=FFieldsProcCode;
  ord(ompObserverParam):
    Result:=FObserverParam;
  ord(ompDependsOnReliability):
    Result:=FDependsOnReliability;
  ord(ompEvidence):
    Result:=FEvidence;
  ord(ompFailure):
    Result:=FFailure;
  ord(ompAssessRequired):
    Result:=FAssessRequired;
  ord(ompDestructive):
    Result:=FDestructive;
{  ord(ompCalcDelayProc):
    Result:=FCalcDelayProc;
  ord(ompCalcDelayLib):
    Result:=FCalcDelayLib;
  ord(ompCalcProbabilityProc):
    Result:=FCalcProbabilityProc;
  ord(ompCalcProbabilityLib):
    Result:=FCalcProbabilityLib;
  ord(ompCalcFieldsProc):
    Result:=FCalcFieldsProc;
  ord(ompCalcFieldsLib):
    Result:=FCalcFieldsLib;
}
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TOvercomeMethod.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  if Flag then Exit;
  Flag:=True;
  case Index of
  ord(ompDelayProcCode):
    FDelayProcCode:=Value;
  ord(ompProbabilityProcCode):
    FProbabilityProcCode:=Value;
  ord(ompFieldsProcCode):
    FFieldsProcCode:=Value;
  ord(ompObserverParam):
    FObserverParam:=Value;
  ord(ompDependsOnReliability):
    FDependsOnReliability:=Value;
  ord(ompEvidence):
    FEvidence:=Value;
  ord(ompFailure):
    FFailure:=Value;
  ord(ompAssessRequired):
    FAssessRequired:=Value;
  ord(ompDestructive):
    FDestructive:=Value;
{  ord(ompCalcDelayProc):
    FCalcDelayProc:=Value;
  ord(ompCalcDelayLib):
    FCalcDelayLib:=Value;
  ord(ompCalcProbabilityProc):
    FCalcProbabilityProc:=Value;
  ord(ompCalcProbabilityLib):
    FCalcProbabilityLib:=Value;
  ord(ompCalcFieldsProc):
    FCalcFieldsProc:=Value;
  ord(ompCalcFieldsLib):
    FCalcFieldsLib:=Value;
}
  else
    inherited;
  end;
  Flag:=False;
end;

class function TOvercomeMethod.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TOvercomeMethod.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsCodeMatrix+
     '|'+rsMatrix+
     '|'+rsExternal+
     '|'+rsZeroD+
     '|'+rsInfinit+
     '|'+rsDEc+
     '|'+rsDCriminalEc+
     '|'+rsUseKey+
     '|'+rsClimb+
     '|'+rsGuard+
     '|'+rsVelocityCodeMatrix+
     '|'+rsVelocityMatrix+
     '|'+rsMinimum;
  AddField(rsDelayProcCode, S, '', '',
                 fvtChoice, -2, -3, 99,
                 ord(ompDelayProcCode), 0, pkInput);
  S:='|'+rsCodeMatrix+
     '|'+rsMatrix+
     '|'+rsExternal+
     '|'+rsZeroP+
     '|'+rsOne+
     '|'+rsStandard+
     '|'+rsReserved+
     '|'+rsReserved+
     '|'+rsReserved+
     '|'+rsGuard;
  AddField(rsProbabilityProcCode, S, '', '',
                 fvtChoice, -2, -3, 99,
                 ord(ompProbabilityProcCode), 0, pkInput);
  AddField(rsFieldsProcCode, '%3d', '', '',
                 fvtInteger, -1, 0, 0,
                 ord(ompFieldsProcCode), 0, pkInput);
  AddField(rsObserverParam, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(ompObserverParam), 0, pkInput);
  AddField(rsDependsOnReliability, '', '', '',
                 fvtBoolean, 1, 0, 0,
                 ord(ompDependsOnReliability), 0, pkInput);
  AddField(rsEvidence, '', '', '',
                 fvtBoolean, 0, 0, 1,
                 ord(ompEvidence), 0, pkInput);
  AddField(rsFailure, '', '', '',
                 fvtBoolean, 0, 0, 1,
                 ord(ompFailure), 0, pkInput);
  AddField(rsAssessRequired, S, '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(ompAssessRequired), 0, pkInput);
  AddField(rsDestructive, S, '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(ompDestructive), 0, pkInput);
end;

function TOvercomeMethod.Get_Collection(Index: Integer): IDMCollection;
begin
    case TOvercomeMethodCategory(Index) of
    omcToolTypes:
      Result:=FToolTypes;
    omcVehicleTypes:
      Result:=FVehicleTypes;
    omcWeaponTypes:
      Result:=FWeaponTypes;
    omcSkillTypes:
      Result:=FSkillTypes;
    omcAthorityTypes:
      Result:=FAthorityTypes;
    omcDeviceStates:
      Result:=FDeviceStates;
    omcTactics:
      Result:=FTactics;
    omcPhysicalFields:
      Result:=FPhysicalFields;
    omcParents:
      Result:=FParents;
    else
      Result:=inherited Get_Collection(Index);
    end;
end;

procedure TOvercomeMethod.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case TOvercomeMethodCategory(Index) of
  omcToolTypes:
    begin
      aCollectionName:=rsToolType;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  omcVehicleTypes:
    begin
      aCollectionName:=rsVehicleType;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  omcWeaponTypes:
    begin
      aCollectionName:=rsWeaponType;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  omcSkillTypes:
    begin
      aCollectionName:=rsSkillType;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  omcAthorityTypes:
    begin
      aCollectionName:=rsAthorityType;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  omcDeviceStates:
    begin
      aCollectionName:=rsDeviceState;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  omcTactics:
    begin
      aCollectionName:=rsTactic;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
      end;
  omcPhysicalFields:
    begin
      aCollectionName:=rsPhysicalField;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  omcParents:
    begin
      aCollectionName:=rsParents;
      aOperations:=leoDontCopy;
    end;
  else
    inherited
  end;
end;

function TOvercomeMethod.Get_PhysicalFieldValue(Index: integer): double;
var
  P:PDouble;
begin
  P:=PDouble(FPhysicalFieldValues[Index]);
  Result:=P^
end;

procedure TOvercomeMethod.Set_PhysicalFieldValue(Index: integer;
  Value: double);
var
  P:PDouble;
begin
  P:=PDouble(FPhysicalFieldValues[Index]);
  P^:=Value
end;

function TOvercomeMethod.Get_PhysicalFields: IDMCollection;
begin
  Result:=FPhysicalFields
end;

function TOvercomeMethod.Get_AthorityTypes: IDMCollection;
begin
  Result:=FAthorityTypes
end;

function TOvercomeMethod.Get_DeviceStates: IDMCollection;
begin
  Result:=FDeviceStates
end;

function TOvercomeMethod.Get_Tactics: IDMCollection;
begin
  Result:=FTactics
end;

function TOvercomeMethod.Get_ToolTypes: IDMCollection;
begin
  Result:=FToolTypes
end;

function TOvercomeMethod.Get_VehicleTypes: IDMCollection;
begin
  Result:=FVehicleTypes
end;

function TOvercomeMethod.Get_WeaponTypes: IDMCollection;
begin
  Result:=FWeaponTypes
end;

function TOvercomeMethod.Get_CalcDelayLib: String;
begin
  Result:=FCalcDelayLib
end;

function TOvercomeMethod.Get_CalcDelayProc: String;
begin
  Result:=FCalcDelayProc
end;

function TOvercomeMethod.Get_CalcFieldsLib: String;
begin
  Result:=FCalcFieldsLib
end;

function TOvercomeMethod.Get_CalcFieldsProc: String;
begin
  Result:=FCalcFieldsProc
end;

function TOvercomeMethod.Get_CalcProbabilityLib: String;
begin
  Result:=FCalcProbabilityLib
end;

function TOvercomeMethod.Get_CalcProbabilityProc: String;
begin
  Result:=FCalcProbabilityProc
end;

function TOvercomeMethod.Get_DelayProcCode: integer;
begin
  Result:=FDelayProcCode
end;

function TOvercomeMethod.Get_FieldsProcCode: integer;
begin
  Result:=FFieldsProcCode
end;

function TOvercomeMethod.Get_ProbabilityProcCode: integer;
begin
  Result:=FProbabilityProcCode
end;

function TOvercomeMethod.Get_SkillTypes: IDMCollection;
begin
  Result:=FSkillTypes
end;

function TOvercomeMethod.CreateValue: IDMElement;
var
  SafeguardDatabase:ISafeguardDatabase;
  MethodArrayValues:IDMCollection2;
begin
  SafeguardDatabase:=DataModel as ISafeguardDatabase;
  MethodArrayValues:=SafeguardDatabase.MethodArrayValues as IDMCollection2;
  Result:=MethodArrayValues.CreateElement(False);
  MethodArrayValues.Add(Result);
end;

procedure TOvercomeMethod.RemoveValue(const aValue: IDMElement);
var
  SafeguardDatabase:ISafeguardDatabase;
  MethodArrayValues:IDMCollection2;
begin
  SafeguardDatabase:=DataModel as ISafeguardDatabase;
  MethodArrayValues:=SafeguardDatabase.MethodArrayValues as IDMCollection2;
  aValue.Clear;
  MethodArrayValues.Remove(aValue);
end;

const
  depMainControlDevice=6;

function TOvercomeMethod.GetValueFromMatrix(const WarriorGroupU,
  SafeguardElementU, LineU:IUnknown;
  Time:double; ValueKind:integer;
  const Report:IDMText): double;
var
  SafeguardElementE, WarriorGroupE:IDMElement;
  j, k, Index:integer;
  DimensionE:IDMElement;
  Dimension:IDMArrayDimension;
  DimensionM:IMethodDimension;
  MethodDimItemSource:IMethodDimItemSource;
  MethodDimItemSourceE, ParamE:IDMElement;
  ParamF, V:double;
  DimItems:IDMCollection;
  ArrayValue:IDMArrayValue;
  TargetU:IUnknown;
  aField:IDMField;
  B:boolean;
  S:WideString;
  TmpCollectionFlag:boolean;
  Vrnt, NilVrnt:Variant;
  Unk:IUnknown;
begin
  NilVrnt:=NilUnk;
  SafeguardElementE:=SafeguardElementU as IDMElement;
  WarriorGroupE:=WarriorGroupU as IDMElement;
  if Report<>nil then begin
    S:=Format('               Эффективность способа преодоления "%s"',
       [Name]);
    Report.AddLine(S);
    S:='               определяется совокупностью следующих условий:';
    Report.AddLine(S);
  end;

  ArrayValue:=Get_ArrayValue;
  for j:=0 to Get_Dimensions.Count-1 do begin
    DimensionE:=Get_Dimensions.Item[j];
    Dimension:=DimensionE as IDMArrayDimension;
    DimensionM:=Dimension as IMethodDimension;
    case DimensionM.SourceKind of
    skElement:
       MethodDimItemSource:=SafeguardElementU as IMethodDimItemSource;
    skElementKind:
       MethodDimItemSource:=SafeguardElementE.Ref as IMethodDimItemSource;
    skGroup:
       MethodDimItemSource:=WarriorGroupU as IMethodDimItemSource;
    skGroupTarget:
       begin
         TargetU:=WarriorGroupE.GetFieldValue(2);
         MethodDimItemSource:=TargetU as IMethodDimItemSource;
       end;
    skBoundary:
       MethodDimItemSource:=SafeguardElementE.Parent.Parent as IMethodDimItemSource;
    skBoundaryLayer,
    skZone:
       MethodDimItemSource:=SafeguardElementE.Parent as IMethodDimItemSource;
    skControlDevice:
      begin
        Vrnt:=SafeguardElementE.GetFieldValue(depMainControlDevice);
        Unk:=IUnknown(Vrnt);
//        if Unk<>NilUnk then begin
          MethodDimItemSource:=Unk as IMethodDimItemSource
//        end else
//          MethodDimItemSource:=nil;
      end;
    skControlDeviceKind:
      begin
        Vrnt:=SafeguardElementE.GetFieldValue(depMainControlDevice);
        Unk:=IUnknown(Vrnt);
        if Unk<>nil then
          MethodDimItemSource:=(Unk as IDMElement).Ref as IMethodDimItemSource
        else
          MethodDimItemSource:=nil;
      end;
    skMethod:
      begin
        MethodDimItemSource:=nil;
      end;
    else
      MethodDimItemSource:=nil;
    end;

    if (DimensionM.SourceKind=skMethod) or
       ((DimensionM as IDMArrayDimension).SubArrayIndex=-1) then
      Index:=ValueKind
    else begin
      if MethodDimItemSource=nil then begin
        Result:=-1;
        Exit;
      end;

      TmpCollectionFlag:=False;
      Index:=-1;
      case DimensionM.Kind of
      sdAthorityType:
        DimItems:=FAthorityTypes;
//      sdToolSkillLevel:
//        DimItems:=FSkillTypes;
      sdVehicleType, sdVehicleKind:
        DimItems:=FVehicleTypes;
      sdWeaponType, sdWeaponKind:
        DimItems:=FWeaponTypes;
      sdToolType, sdToolKind:
        DimItems:=FToolTypes;
      sdFieldValueInterval:
       begin
          DimItems:=Dimension.DimItems;
          MethodDimItemSourceE:=MethodDimItemSource as IDMElement;
          V:=MethodDimItemSourceE.GetFieldValue(DimensionM.Code);
          k:=0;
          while k<DimItems.Count do begin
            aField:=DimItems.Item[k] as IDMField;
            if (V>aField.MinValue) and
               (V<=aField.MaxValue) then
              Break
            else
              inc(k)
          end;
          Index:=k;
       end;
      sdFieldValue:
        begin
          DimItems:=Dimension.DimItems;
          MethodDimItemSourceE:=MethodDimItemSource as IDMElement;
          aField:=nil;
          k:=0;
          while k<MethodDimItemSourceE.FieldCount do begin
            aField:=MethodDimItemSourceE.Field[k];
            if aField.Code=DimensionM.Code then
              Break
            else
              inc(k)
          end;
          if (aField<>nil) and
            (aField.ValueType=fvtBoolean) then begin
            B:=MethodDimItemSourceE.GetFieldValue(DimensionM.Code);
            Index:=ord(B);
          end else begin
            V:=MethodDimItemSourceE.GetFieldValue(DimensionM.Code);
            k:=0;
            while k<DimItems.Count do begin
              aField:=DimItems.Item[k] as IDMField;
              if V=aField.DefaultValue then
                Break
              else
                inc(k)
            end;
            Index:=k;
          end;
        end;
      sdTime:
       begin
          DimItems:=Dimension.DimItems;
          k:=0;
          while k<DimItems.Count do begin
            aField:=DimItems.Item[k] as IDMField;
            if (Time>aField.MinValue) and
               (Time<=aField.MaxValue) then
              Break
            else
              inc(k)
          end;
          Index:=k;
       end;
      sdAvailabelTime,
      sdDetectionZoneSize,
      sdCommunication,
      sdMineLength,
      sdTVMonitorCount,
      sdWeight,
      sdSize,
      sdPersonalCount:
        DimItems:=Dimension.DimItems;
      sdDistance:
        begin
          case DimensionM.Code of
          0:  DimItems:=Dimension.DimItems;
          1:begin
              DimItems:=TDMCollection.Create(nil) as IDMCollection;
              (DimItems as IDMCollection2).Add(WarriorGroupE);
              TMPCollectionFlag:=True;
            end;
          else
            DimItems:=nil;
          end;
        end;
      else
        DimItems:=nil;
      end;

      case DimensionM.Kind of
      sdAccess,
      sdAdversaryCount,
      sdPostDefence:
        ParamE:=WarriorGroupE;
      sdDetectionSector,
      sdDistance:
        ParamE:=LineU as IDMElement;
      else
        ParamE:=SafeguardElementU as IDMElement;
      end;

      ParamF:=Time;

      if Index=-1 then
        try
        Index:=MethodDimItemSource.GetMethodDimItemIndex(
                      DimensionM.Kind, DimensionM.Code, DimItems,
                      ParamE, ParamF);
        except
          raise
        end;
      if TMPCollectionFlag then
        DimItems:=nil;
    end; // if DimensionM.SourceKind=skMethod
    
    DimensionM.CurrentValueIndex:=Index;

    if Index<>-1 then begin
      ArrayValue:=ArrayValue.ArrayValues.Item[Index] as IDMArrayValue;

      if Report<>nil then begin
        S:=Format('               "%s" - %s',
        [DimensionE.Name, Dimension.DimItems.Item[Index].Name]);
        Report.AddLine(S);
      end;
    end else begin
      ArrayValue:=nil;
      if Report<>nil then begin
        S:=Format('               Значение параметра "%s" не определено. Необходима доработка программы',
        [DimensionE.Name]);
        Report.AddLine(S);
      end;
      Break;
    end;
  end;
  if ArrayValue<>nil then
    Result:=ArrayValue.Value
  else
    Result:=-1
end;

procedure TOvercomeMethod.BuildReport(
     ReportLevel: Integer; TabCount: Integer; Mode: Integer;
     const Report: IDMText);
var
  S:WideString;
  j, m:integer;
  DimensionE:IDMElement;
  Dimension:IDMArrayDimension;
  ArrayValue:IDMArrayValue;
  Space:string;
begin
  Report.AddLine('');
  S:=Format('     Способ преодоления "%s"',
     [Name]);
  Report.AddLine(S);
  if FDimensions.Count<>0 then begin
    Report.AddLine('');
    S:=Format('         Параметры способа преодоления:',
     [Name]);
    Report.AddLine(S);
    for j:=0 to FDimensions.Count-1 do begin
      DimensionE:=FDimensions.Item[j];
      S:=Format('           "%s"',
         [DimensionE.Name]);
      Report.AddLine(S);
      Dimension:=DimensionE as IDMArrayDimension;
      for m:=0 to Dimension.DimItems.Count-1 do begin
        S:=Format('                "%s"',
           [Dimension.DimItems.Item[m].Name]);
        Report.AddLine(S);
      end;
    end;
  end;

  if FAthorityTypes.Count<>0 then begin
    Report.AddLine('');
    S:=Format('         Полномочия, от которых зависит способ предоления:',
     [Name]);
    Report.AddLine(S);
    for j:=0 to FAthorityTypes.Count-1 do begin
      S:=Format('           "%s"',
         [FAthorityTypes.Item[j].Name]);
      Report.AddLine(S);
    end;
  end;

  if FToolTypes.Count<>0 then begin
    Report.AddLine('');
    S:=Format('         Инструменты, необходимые для способа предоления:',
     [Name]);
    Report.AddLine(S);
    for j:=0 to FToolTypes.Count-1 do begin
      S:=Format('           "%s"',
         [FToolTypes.Item[j].Name]);
      Report.AddLine(S);
    end;
  end;

  if FWeaponTypes.Count<>0 then begin
    S:=Format('         Вооружение, необходимое для способа предоления:',
     [Name]);
    Report.AddLine(S);
    for j:=0 to FWeaponTypes.Count-1 do begin
      S:=Format('           "%s"',
         [FWeaponTypes.Item[j].Name]);
      Report.AddLine(S);
    end;
  end;

  if FVehicleTypes.Count<>0 then begin
    Report.AddLine('');
    S:=Format('         Транспортное средство, необходимое для способа предоления:',
     [Name]);
    Report.AddLine(S);
    for j:=0 to FVehicleTypes.Count-1 do begin
      S:=Format('           "%s"',
         [FVehicleTypes.Item[j].Name]);
      Report.AddLine(S);
    end;
  end;

  ArrayValue:=Get_ArrayValue;
  if ArrayValue.ArrayValues.Count>0 then begin
    Report.AddLine('');
    S:=Format('         Матрица эффективности способа предоления:',
     [Name]);
    Report.AddLine(S);
    Space:='         ';
    BuildArrayValueMatrix(Space, ArrayValue, Report, 0);
  end;
end;

procedure TOvercomeMethod.BuildArrayValueMatrix(const Space0: string;
  const ArrayValue0: IDMArrayValue;
  const Report:IDMText; DimensionIndex0: integer);
var
  ArrayValue, ArrayValue1:IDMArrayValue;
  Space, S, S0:string;
  j, m, i, DimensionIndex:integer;
  Dimension, Dimension1:IDMArrayDimension;
  N:integer;
  DimensionE:IDMElement;
begin
  Dimension:=FDimensions.Item[DimensionIndex0] as IDMArrayDimension;
  if DimensionIndex0=FDimensions.Count-1 then begin
    for j:=0 to Dimension.DimItems.Count-1 do begin
      ArrayValue:=ArrayValue0.ArrayValues.Item[j] as IDMArrayValue;
      S0:=Dimension.DimItems.Item[j].Name;
      N:=length(S0) div 8;
      if N=0 then N:=1;
      S:=Format('%-s ',
           [S0]);
      for i:=1 to 4-N do
        S:=S+#9;
      S:=S+Format('%0.4f'#9#9,
           [ArrayValue.Value]);
      Report.AddLine(S);
    end;
  end else
  if DimensionIndex0=FDimensions.Count-2 then begin
    Dimension1:=FDimensions.Item[DimensionIndex0+1] as IDMArrayDimension;
    S:=#9#9#9#9;
    for m:=0 to Dimension1.DimItems.Count-1 do begin
      S0:=Dimension1.DimItems.Item[m].Name;
      N:=length(S0) div 8;
      if N=0 then N:=1;
      S:=S+Format('%-s',[S0]);
      for i:=1 to 3-N do
        S:=S+#9;
    end;
    Report.AddLine(S);
    for j:=0 to Dimension.DimItems.Count-1 do begin
      ArrayValue:=ArrayValue0.ArrayValues.Item[j] as IDMArrayValue;
      S0:=Dimension.DimItems.Item[j].Name;
      N:=length(S0) div 8;
      if N=0 then N:=1;
      S:=Format('%-s',
           [S0]);
      for i:=1 to 4-N do
        S:=S+#9;
      for m:=0 to Dimension1.DimItems.Count-1 do begin
        ArrayValue1:=ArrayValue.ArrayValues.Item[m] as IDMArrayValue;
        S:=S+Format('%-0.4f'#9#9,[ArrayValue1.Value]);
      end;
      Report.AddLine(S);
    end;
  end else begin
    DimensionE:=Dimension as IDMElement;
    Space:=Space0+'     ';
    DimensionIndex:=DimensionIndex0+1;
    for j:=0 to ArrayValue0.ArrayValues.Count-1 do begin
      Report.AddLine('');
      S:=Space0+Format('%s - "%s"',
           [DimensionE.Name, Dimension.DimItems.Item[j].Name]);
      Report.AddLine(S);
      ArrayValue:=ArrayValue0.ArrayValues.Item[j] as IDMArrayValue;
      BuildArrayValueMatrix(Space, ArrayValue, Report, DimensionIndex);
    end;
  end;
end;

function TOvercomeMethod.Get_Evidence: WordBool;
begin
  Result:=FEvidence
end;

function TOvercomeMethod.Get_Failure: WordBool;
begin
  Result:=FFailure
end;

function TOvercomeMethod.Get_ObserverParam: WordBool;
begin
  Result:=FObserverParam
end;

function TOvercomeMethod.GetValueByCodeFromMatrix(const WarriorGroupU,
  SafeguardElementU, LineU: IUnknown; Time: double; ValueKind:integer;
  const Report: IDMText): double;
var
  FieldCode:integer;
  SafeguardElementE:IDMElement;
begin
  FieldCode:=round(GetValueFromMatrix(WarriorGroupU,
             SafeguardElementU, LineU, Time, ValueKind, Report));
  try
  if FieldCode<>-1 then begin
    SafeguardElementE:=SafeguardElementU as IDMElement;
    Result:=SafeguardElementE.Ref.GetFieldValue(FieldCode)
  end else
    Result:=-InfinitValue
  except
    DataModel.HandleError
    ('Error in GetValueByCodeFromMatrix '+Name)
  end
end;

function TOvercomeMethod.Get_AssessRequired: WordBool;
begin
  Result:=FAssessRequired
end;

procedure TOvercomeMethod.Loaded;
begin
  inherited;
  BuildNextDimensionIndexes
end;

function TOvercomeMethod.Get_Destructive: WordBool;
begin
  Result:=FDestructive
end;

procedure TOvercomeMethod.Clear;
begin
  try
  inherited;
  except
    raise
  end;  
end;

function TOvercomeMethod.Get_DependsOnReliability: WordBool;
begin
  Result:=FDependsOnReliability
end;

procedure TOvercomeMethod.Set_Parent(const Value: IDMElement);
begin
  if DataModel=nil then Exit;
  if (DataModel as IDMElement)=Value then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Value=nil then Exit;
  AddParent(Value);
end;


procedure TOvercomeMethod.AfterCopyFrom(const SourceElement: IDMElement);
var
  DMOperationManager:IDMOperationManager;
  DArrayValueE, SArrayValueE:IDMElement;
  SOvercomeMethodA:IDMArray;
begin
  DMOperationManager:=DataModel.Document as IDMOperationManager;

  SOvercomeMethodA:=SourceElement as IDMArray;
  DArrayValueE:=Get_ArrayValue as IDMElement;
  SArrayValueE:=SOvercomeMethodA.ArrayValue as IDMElement;
  DMOperationManager.PasteToElement(SArrayValueE, DArrayValueE, False, False);
  BuildNextDimensionIndexes;
end;

{ TOvercomeMethods }

class function TOvercomeMethods.GetElementClass: TDMElementClass;
begin
  Result:=TOvercomeMethod;
end;

function TOvercomeMethods.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsOvercomeMethod;
end;

class function TOvercomeMethods.GetElementGUID: TGUID;
begin
  Result:=IID_IOvercomeMethod;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TOvercomeMethod.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
