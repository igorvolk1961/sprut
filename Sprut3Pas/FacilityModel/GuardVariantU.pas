unit GuardVariantU;

interface
uses
  Classes, SysUtils, Variants,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TGuardVariant=class(TNamedDMElement, IGuardVariant,
                      ICabelNode, IDMElement4)
  private
    FGuardGroups:IDMCollection;
    FPatrolPaths:IDMCollection;
    FTechnicalServices:IDMCollection;
    FConnections:IDMCollection;
    FLargestZone:Variant;

    procedure MakeDefaultGroup;

  protected
    class function GetFields:IDMCollection; override;
    class function GetClassID:integer; override;

    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class procedure MakeFields0; override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;

    procedure AfterLoading1; override;

    function Get_GuardGroups:IDMCollection; safecall;
    function Get_PatrolPaths:IDMCollection; safecall;
    function Get_TechnicalServices:IDMCollection; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;

    procedure _AddChild(const aElement:IDMElement); override;
    procedure _RemoveChild(const aElement:IDMElement); override;
    procedure AfterLoading2; override; safecall;

    function Get_LargestZone:IDMElement; safecall;

//ICabelNode
    function Get_Connections:IDMCollection; safecall;

//IDMElement4
    function AddRefElementRef(const aCollection: IDMCollection; const aName: WideString;
                             const aRef: IDMElement): IDMElement; safecall;

  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TGuardVariants=class(TDMCollection)
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

{ TGuardVariant }


procedure TGuardVariant.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FGuardGroups:=DataModel.CreateCollection(_GuardGroup, SelfE);
  FPatrolPaths:=DataModel.CreateCollection(_PatrolPath, SelfE);
  FTechnicalServices:=DataModel.CreateCollection(_TechnicalService, SelfE);
  FConnections:=DataModel.CreateCollection(_Connection, SelfE);

  if not DataModel.IsLoading then
    MakeDefaultGroup;
end;

procedure TGuardVariant._Destroy;
begin
  inherited;
  FGuardGroups:=nil;
  FPatrolPaths:=nil;
  FTechnicalServices:=nil;
  FConnections:=nil;
end;

class function TGuardVariant.GetClassID: integer;
begin
  Result:=_GuardVariant;
end;

function TGuardVariant.Get_CollectionCount: integer;
begin
  Result:=4;
end;

function TGuardVariant.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0: Result:=FGuardGroups;
  1: Result:=FPatrolPaths;
  2: Result:=FTechnicalServices;
  3: Result:=FConnections;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

procedure TGuardVariant.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:begin
      aRefSource:=nil;
      aCollectionName:=rsGuardGroups;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoDelete or leoRename or leoMove;
      aLinkType:=ltOneToMany;
    end;
  1:begin
      aRefSource:=nil;
      aCollectionName:=rsPatrolPaths;
      aClassCollections:=nil;
      aOperations:=leoDelete or leoRename;
      aLinkType:=ltOneToMany;
    end;
  2:begin
      aRefSource:=nil;
      aCollectionName:=rsTechnicalServices;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoDelete or leoRename;
      aLinkType:=ltOneToMany;
    end;
  3:begin
      aCollectionName:=rsMainControlDevices;
      aRefSource:=(DataModel as IDMElement).Ref.Collection[_ControlDeviceType];
      aClassCollections:=nil;
      aOperations:=leoAdd or leoRename or leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  else
    inherited
  end;
end;

function TGuardVariant.Get_GuardGroups: IDMCollection;
begin
  Result:=FGuardGroups
end;

class function TGuardVariant.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TGuardVariant.Get_PatrolPaths: IDMCollection;
begin
  Result:=FPatrolPaths
end;

function TGuardVariant.Get_TechnicalServices: IDMCollection;
begin
  Result:=FTechnicalServices
end;

procedure TGuardVariant.AfterLoading1;
begin
  inherited;
  if FGuardGroups.Count=0 then
    MakeDefaultGroup;
end;

procedure TGuardVariant.MakeDefaultGroup;
var
  aCollection:IDMCollection;
  aCollection2:IDMCollection2;
  S:string;
  DMOperationManager:IDMOperationManager;
  ElementU:IUnknown;
  Element:IDMElement;
begin
  aCollection:=(DataModel as IFacilityModel).GuardGroups;
  aCollection2:=aCollection as IDMCollection2;
  S:=rsResponceGroup+' '+IntToStr(DataModel.NextID[_GuardGroup]);

  if DataModel.IsChanging then begin
    DMOperationManager:=DataModel.Document as IDMOperationManager;
    DMOperationManager.AddElement( Self as IDMElement,
                      aCollection, S, ltOneToMany, ElementU, True);
  end else begin
    Element:=aCollection2.CreateElement(False);
    aCollection2.Add(Element);
    Element.Parent:=Self as IDMElement;
    Element.Name:=S;
  end;
end;

function TGuardVariant.Get_Connections: IDMCollection;
begin
  Result:=FConnections
end;

function TGuardVariant.AddRefElementRef(const aCollection: IDMCollection;
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
                       SelfU, FConnections,
                       '', ControlDeviceU, ltOneToMany, ConnectionU, True);

  Result:=ConnectionU as IDMElement;
end;

procedure TGuardVariant.MakeSelectSource(Index: Integer;
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

procedure TGuardVariant._AddChild(const aElement: IDMElement);
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

  if aElement.ClassID=_Connection then begin
    aControlDevice:=aElement.Ref as IControlDevice;
    j:=aControlDevice.InputConnections.IndexOf(SelfE);
    if j=-1 then
      (aControlDevice.InputConnections as IDMCollection2).Add(SelfE);
  end;
end;

procedure TGuardVariant._RemoveChild(const aElement: IDMElement);
var
  aControlDevice:IControlDevice;
  SelfE:IDMElement;
  j:integer;
begin
  inherited;

  if aElement=nil then Exit;
  if aElement.Ref=nil then Exit;
  SelfE:=Self  as IDMElement;

  if aElement.ClassID=_Connection then begin
    aControlDevice:=aElement.Ref as IControlDevice;
    j:=aControlDevice.InputConnections.IndexOf(SelfE);
    if j<>-1 then
      (aControlDevice.InputConnections as IDMCollection2).Delete(j);
  end;
end;

procedure TGuardVariant.AfterLoading2;
var
  m, j:integer;
  aElement, SelfE:IDMElement;
  aControlDevice:IControlDevice;
begin
  inherited;

  SelfE:=Self as IDMElement;
  for m:=0 to FConnections.Count-1 do begin
    aElement:=FConnections.Item[m];
    aControlDevice:=aElement.Ref as IControlDevice;
    j:=aControlDevice.InputConnections.IndexOf(SelfE);
    if j=-1 then
      (aControlDevice.InputConnections as IDMCollection2).Add(SelfE);
  end;
end;

function TGuardVariant.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  0: Result:=FLargestZone;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TGuardVariant.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
var
  aFacilityModel:IFacilityModel;
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  Enviroments:IZone;
  j:integer;
begin
  aFacilityModel:=DataModel as IFacilityModel;
  Enviroments:=aFacilityModel.Enviroments as  IZone;
  case Code of
  0: theCollection:=Enviroments.Zones;
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

class procedure TGuardVariant.MakeFields0;
begin
  inherited;
  AddField(rsLargestZone, '', '', '',
                 fvtElement, -1, 0, 0,
                 0, 0, pkInput);
end;

procedure TGuardVariant.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  0: FLargestZone:=Value;
  else
    inherited;
  end;
end;

function TGuardVariant.Get_LargestZone: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FLargestZone;
  Result:=Unk as IDMElement
end;

{ TGuardVariants }

class function TGuardVariants.GetElementClass: TDMElementClass;
begin
  Result:=TGuardVariant;
end;

function TGuardVariants.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsGuardVariant
  else
    Result:=rsGuardVariants;
end;

class function TGuardVariants.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardVariant;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TGuardVariant.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
