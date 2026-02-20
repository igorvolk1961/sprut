unit AdversaryGroupU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  WarriorGroupU;

type
  TAdversaryGroup=class(TWarriorGroup, IAdversaryGroup)
  private
    FSkills:IDMCollection;
    FAthorities:IDMCollection;
    FLocks:IDMCollection;
    FControlDeviceAccesses:IDMCollection;
    FGuardPostAccesses:IDMCollection;

    FTargetDelayTime:double;
    FTargetAccessRequired:boolean;
    FTargetFieldValue:double;
    FUserDefinedTargetDelayDispersionRatio:boolean;
    FTargetDelayDispersionRatio:double;

  protected
    function Get_Skills:IDMCollection; safecall;
    function Get_Athorities:IDMCollection; safecall;
    function Get_Locks:IDMCollection; safecall;
    function Get_ControlDeviceAccesses:IDMCollection; safecall;
    function Get_GuardPostAccesses:IDMCollection; safecall;

    function  Get_TargetDelayTime:double; safecall;
    function  Get_UserDefinedTargetDelayDispersionRatio:WordBool; safecall;
    function  Get_TargetDelayDispersionRatio:double; safecall;
    function  Get_TargetFieldValue:double; safecall;
    function  Get_TargetAccessRequired:WordBool; safecall;

    class function GetClassID:integer; override;
    class function GetFields:IDMCollection; override;

    class procedure MakeFields0; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    procedure GetFieldValueSource(Code:Integer; var aCollection: IDMCollection); override;

    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; override; safecall;

    function  Get_CollectionCount: Integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
    function GetCollectionForChild(const aChild: IDMElement): IDMCollection; override; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;

    procedure MakeDefaultAttribute; override;

  end;

  TAdversaryGroups=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation
uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TAdversaryGroup }

class function TAdversaryGroup.GetClassID: integer;
begin
  Result:=_AdversaryGroup;
end;

procedure TAdversaryGroup.GetFieldValueSource(
  Code:Integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(wapStartPoint):
    theCollection:=(DataModel as IFacilityModel).StartPoints
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
{
function TAdversaryGroup.Get_TMPWaySteps: TDMElementRefs;
begin
  Result:=FTMPWaySteps
end;
}
function TAdversaryGroup.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(apTargetAccessRequired):
    Result:=FTargetAccessRequired;
  ord(apTargetDelayTime):
    Result:=FTargetDelayTime;
  ord(apUserDefinedTargetDelayDispersionRatio):
    Result:=FUserDefinedTargetDelayDispersionRatio;
  ord(apTargetDelayDispersionRatio):
    Result:=FTargetDelayDispersionRatio;
  ord(apTargetFieldValue):
    Result:=FTargetFieldValue;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TAdversaryGroup.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(apTargetAccessRequired):
    FTargetAccessRequired:=Value;
  ord(apTargetDelayTime):
    FTargetDelayTime:=Value;
  ord(apUserDefinedTargetDelayDispersionRatio):
    FUserDefinedTargetDelayDispersionRatio:=Value;
  ord(apTargetDelayDispersionRatio):
    FTargetDelayDispersionRatio:=Value;
  ord(apTargetFieldValue):
    FTargetFieldValue:=Value;
  else
    inherited;
  end;
end;

class function TAdversaryGroup.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TAdversaryGroup.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsMainGroup+
     '|'+rsInsider;
//     '|'+rsSupportGroup;
  AddField(rsTask, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(apTask), 0, pkInput);
  AddField(rsTargetAccessRequired, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(apTargetAccessRequired), 0, pkInput);
  AddField(rsTargetDelayTime, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(apTargetDelayTime), 0, pkInput);
  AddField(rsUserDefinedTargetDelayDispersionRatio, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(apUserDefinedTargetDelayDispersionRatio), 0, pkUserDefined);
  AddField(rsTargetDelayDispersionRatio, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(apTargetDelayDispersionRatio), 2, pkUserDefined);
  AddField(rsTargetFieldValue, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(apTargetFieldValue), 0, pkInput);
end;

function TAdversaryGroup.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  ord(acLocks):
    Result:=FLocks;
  ord(acControlDeviceAccesses):
    Result:=FControlDeviceAccesses;
  ord(acGuardPostAccesses):
    Result:=FGuardPostAccesses;
  ord(acAthorities):
    Result:=FAthorities;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

function TAdversaryGroup.Get_CollectionCount: Integer;
begin
  Result:=ord(high(TAdversaryCategory))+1
end;

procedure TAdversaryGroup.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  SafeguardDatabase:ISafeguardDatabase;
begin
  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;
  case Index of
  ord(acLocks):
    begin
      aRefSource:=nil;
      aCollectionName:=rsKeys;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  ord(acControlDeviceAccesses):
    begin
      aRefSource:=nil;
      aCollectionName:=rsControlDeviceAccess;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  ord(acGuardPostAccesses):
    begin
      aRefSource:=nil;
      aCollectionName:=rsGuardPostAccess;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  ord(acAthorities):
    begin
      aRefSource:=SafeguardDatabase.AthorityTypes;
      aCollectionName:=rsAdversaryAthorities;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  else
    inherited
  end;
end;

procedure TAdversaryGroup.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FSkills:=DataModel.CreateCollection(_Skill, SelfE);
  FAthorities:=DataModel.CreateCollection(_Athority, SelfE);
  FLocks:=DataModel.CreateCollection(_Lock, SelfE);
  FControlDeviceAccesses:=DataModel.CreateCollection(_ControlDeviceAccess, SelfE);
  FGuardPostAccesses:=DataModel.CreateCollection(_GuardPostAccess, SelfE);
end;

procedure TAdversaryGroup._Destroy;
begin
  inherited;
  FSkills:=nil;
  FAthorities:=nil;
  FLocks:=nil;
  FControlDeviceAccesses:=nil;
  FGuardPostAccesses:=nil;
end;

function TAdversaryGroup.Get_Athorities: IDMCollection;
begin
  Result:=FAthorities
end;

function TAdversaryGroup.Get_Skills: IDMCollection;
begin
  Result:=FSkills
end;

function TAdversaryGroup.Get_Locks: IDMCollection;
begin
  Result:=FLocks
end;


function TAdversaryGroup.GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer;
var
  j:integer;
  AthorityE:IDMElement;
  Athorities:IDMCollection2;
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  AnalysisVariant:IAnalysisVariant;
  AdversaryVariant:IAdversaryVariant;
begin
  case Kind of
  sdAthorityType:
    begin
      FacilityModel:=DataModel as IFacilityModel;
      FacilityModelS:=FacilityModel as IFMState;
      AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
      if AnalysisVariant=nil then
        AnalysisVariant:=FacilityModel.AnalysisVariants.Item[0] as IAnalysisVariant;
      AdversaryVariant:=AnalysisVariant.AdversaryVariant as IAdversaryVariant;
      Athorities:=AdversaryVariant.Athorities as IDMCollection2;
      j:=DimItems.Count-1;
      while j>=0 do begin
        AthorityE:=DimItems.Item[j];
        if Athorities.GetItemByRef(AthorityE)<>nil then
          Break
        else
          dec(j)
      end;
      if j>=0 then
        Result:=j+1
      else
        Result:=0
    end;
  sdAdversaryCount:
    if FInitialNumber>1 then
      Result:=1
    else
      Result:=0
  else
    Result:=inherited GetMethodDimItemIndex(Kind, Code, DimItems,
                                            ParamE, ParamF);
  end;
end;

procedure TAdversaryGroup.MakeDefaultAttribute;
var
  aCollection2:IDMCollection2;
  AttributeE, AttributeKindE:IDMElement;
  AttributeKind:IWarriorAttributeKind;
  SafeguardDatabase:ISafeguardDatabase;
  j:integer;
begin
  inherited;

  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;

  aCollection2:=(DataModel as IFacilityModel).Tools as IDMCollection2;
  for j:=0 to SafeguardDatabase.ToolKinds.Count-1 do begin
    AttributeKindE:=SafeguardDatabase.ToolKinds.Item[j];
    AttributeKind:=AttributeKindE as IWarriorAttributeKind;
    if AttributeKind.IsDefault then begin
      AttributeE:=aCollection2.CreateElement(False);
      aCollection2.Add(AttributeE);
      AttributeE.Ref:=AttributeKindE;
      AttributeE.Parent:=Self as IDMElement;
    end;
  end;


end;

procedure TAdversaryGroup.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
  SafeguardDatabase:ISafeguardDatabase;
  DataModelE:IDMELement;
begin
  DataModelE:=DataModel as IDMELement;
  SafeguardDatabase:=DataModelE.Ref as ISafeguardDatabase;
  case Index of
  ord(acAthorities):
    SourceCollection:=SafeguardDatabase.AthorityTypes;
  ord(acLocks):
    SourceCollection:=DataModelE.Collection[_Lock];
  ord(acControlDeviceAccesses):
    SourceCollection:=DataModelE.Collection[_ControlDevice];
  ord(acGuardPostAccesses):
    SourceCollection:=DataModelE.Collection[_GuardPost];
  else
    begin
      inherited;
      Exit;
    end;
  end;

  aCollection2:=aCollection as IDMCollection2;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do
    aCollection2.Add(SourceCollection.Item[j]);
end;

function TAdversaryGroup.Get_TargetDelayTime: double;
begin
  Result:=FTargetDelayTime
end;

function TAdversaryGroup.Get_TargetDelayDispersionRatio: double;
begin
  Result:=FTargetDelayDispersionRatio
end;

function TAdversaryGroup.Get_UserDefinedTargetDelayDispersionRatio: WordBool;
begin
  Result:=FUserDefinedTargetDelayDispersionRatio
end;

function TAdversaryGroup.Get_TargetFieldValue: double;
begin
  Result:=FTargetFieldValue
end;

function TAdversaryGroup.Get_TargetAccessRequired: WordBool;
begin
  Result:=FTargetAccessRequired
end;

function TAdversaryGroup.Get_ControlDeviceAccesses: IDMCollection;
begin
  Result:=FControlDeviceAccesses
end;

function TAdversaryGroup.Get_GuardPostAccesses: IDMCollection;
begin
  Result:=FGuardPostAccesses
end;

function TAdversaryGroup.GetCollectionForChild(
  const aChild: IDMElement): IDMCollection;
begin
  Result:=nil;
  if aChild=nil then Exit;
  case aChild.ClassID of
  _Access:
    Result:=FAccesses;
  _ControlDeviceAccess:
    Result:=FControlDeviceAccesses;
  _GuardPostAccess:
    Result:=FGuardPostAccesses;
  else
    Result:=inherited GetCollectionForChild(aChild);
  end;
end;

{ TAdversaryGroups }

class function TAdversaryGroups.GetElementClass: TDMElementClass;
begin
  Result:=TAdversaryGroup;
end;

function TAdversaryGroups.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsAdversaryGroup
  else
    Result:=rsAdversaryGroups;
end;

class function TAdversaryGroups.GetElementGUID: TGUID;
begin
  Result:=IID_IAdversaryGroup;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TAdversaryGroup.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
