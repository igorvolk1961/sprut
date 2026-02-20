unit AdversaryVariantU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TAdversaryVariant=class(TNamedDMElement, IAdversaryVariant, IDMElement2)
  private
    FComment:string;

    FAdversaryGroups:IDMCollection;
    FAthorities:IDMCollection;
    FLocks:IDMCollection;
    FControlDeviceAccesses:IDMCollection;
    FGuardPostAccesses:IDMCollection;

    procedure MakeDefaultGroup;

  protected
    class function GetClassID:integer; override;
    class function GetFields:IDMCollection; override;

    class procedure MakeFields0; override;

    function Get_FieldCount_: integer;  override; safecall;
    function Get_Field_(Index: integer): IDMField; override; safecall;
    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function  Get_FieldValue_(Index: integer): OleVariant; override; safecall;
    procedure Set_FieldValue_(Index: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code:Integer; var aCollection: IDMCollection); override;

    procedure AfterLoading1; override;

    function Get_AdversaryGroups:IDMCollection; safecall;
    function Get_Athorities:IDMCollection; safecall;
    function Get_Locks:IDMCollection; safecall;
    function Get_ControlDeviceAccesses:IDMCollection; safecall;
    function Get_GuardPostAccesses:IDMCollection; safecall;
    procedure Prepare; safecall;
    function  GetAccessType(const Element: IDMElement;
               InCurrentState:WordBool): Integer; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
// IDMElement2

    function GetOperationName(ColIndex, Index: Integer): WideString; safecall;
    function DoOperation(ColIndex, Index: Integer; var Param1: OleVariant; var Param2: OleVariant;
                         var Param3: OleVariant): WordBool; safecall;
    function GetShortCut(ColIndex, Index: Integer): WideString; safecall;

  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TAdversaryVariants=class(TDMCollection)
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

{ TAdversaryVariant }


procedure TAdversaryVariant.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FAdversaryGroups:=DataModel.CreateCollection(_AdversaryGroup, SelfE);
  FAthorities:=DataModel.CreateCollection(-1, SelfE);
  FLocks:=DataModel.CreateCollection(-1, SelfE);
  FControlDeviceAccesses:=DataModel.CreateCollection(-1, SelfE);
  FGuardPostAccesses:=DataModel.CreateCollection(-1, SelfE);

  if not DataModel.IsLoading then
    MakeDefaultGroup;
end;

procedure TAdversaryVariant._Destroy;
begin
  inherited;
  FAdversaryGroups:=nil;
  FAthorities:=nil;
end;

class function TAdversaryVariant.GetClassID: integer;
begin
  Result:=_AdversaryVariant;
end;

function TAdversaryVariant.Get_CollectionCount: integer;
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     (DataModel.InUndoRedo and not DataModel.IsChanging) or
     DataModel.IsExecuting or
     (DataModel as IFacilityModel).ShowSingleLayer or
     (FAdversaryGroups.Count<>1) then
    Result:=1
  else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    Result:=AdversaryGroupE.CollectionCount;
  end;
end;

function TAdversaryVariant.Get_Collection(Index: Integer): IDMCollection;
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     (DataModel.InUndoRedo and not DataModel.IsChanging) or
     DataModel.IsExecuting or
     (DataModel as IFacilityModel).ShowSingleLayer or
     (FAdversaryGroups.Count<>1) then begin
    case Index of
    0:Result:=FAdversaryGroups;
    else
      Result:=inherited Get_Collection(Index)
    end;
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    Result:=AdversaryGroupE.Collection[Index];
  end;
end;

procedure TAdversaryVariant.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     (DataModel.InUndoRedo and not DataModel.IsChanging) or
     DataModel.IsExecuting or
     (DataModel as IFacilityModel).ShowSingleLayer or
     (FAdversaryGroups.Count<>1) then begin
    case Index of
    0:begin
        aRefSource:=nil;
        aCollectionName:=rsAdversaryGroups;
        aClassCollections:=nil;
        aOperations:=leoAdd or leoDelete or leoRename or leoMove;
        aLinkType:=ltOneToMany;
      end;
    else
      inherited
    end;
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    AdversaryGroupE.GetCollectionProperties(Index,
      aCollectionName, aRefSource, aClassCollections,
      aOperations,aLinkType);
  end;
end;

function TAdversaryVariant.Get_AdversaryGroups: IDMCollection;
begin
  Result:=FAdversaryGroups
end;

function TAdversaryVariant.Get_Athorities: IDMCollection;
begin
  Result:=FAthorities
end;

procedure TAdversaryVariant.Prepare;
var
  Groups:IDMCollection;
  Group:IAdversaryGroup;
  Athorities2, Locks2,
  ControlDeviceAccesses2, GuardPostAccesses2:IDMCollection2;
  j, m:integer;
  Element:IDMElement;
begin
  Groups:=Get_AdversaryGroups;

  Athorities2:=FAthorities as IDMCollection2;
  Locks2:=FLocks as IDMCollection2;
  GuardPostAccesses2:=FGuardPostAccesses as IDMCollection2;
  ControlDeviceAccesses2:=FControlDeviceAccesses as IDMCollection2;

  Athorities2.Clear;
  Locks2.Clear;
  GuardPostAccesses2.Clear;
  ControlDeviceAccesses2.Clear;
  for j:=0 to Groups.Count-1 do begin
    Group:=Groups.Item[j] as IAdversaryGroup;
    for m:=0 to Group.Athorities.Count-1 do begin
      Element:=Group.Athorities.Item[m];
      Athorities2.Add(Element);
    end;
    for m:=0 to Group.Locks.Count-1 do begin
      Element:=Group.Locks.Item[m];
      Locks2.Add(Element);
    end;
    for m:=0 to Group.ControlDeviceAccesses.Count-1 do begin
      Element:=Group.ControlDeviceAccesses.Item[m];
      ControlDeviceAccesses2.Add(Element);
    end;
    for m:=0 to Group.GuardPostAccesses.Count-1 do begin
      Element:=Group.GuardPostAccesses.Item[m];
      GuardPostAccesses2.Add(Element);
    end;
  end;
end;

class procedure TAdversaryVariant.MakeFields0;
begin
  inherited;
  AddField(rsComment, '', '', 'Comment',
           fvtText, 0, 0, 0,
           cnstComment, 0, pkComment);
end;

function TAdversaryVariant.GetFieldValue(Code: integer): OleVariant;
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (FAdversaryGroups.Count<>1) then begin
    case Code of
    ord(cnstComment):
      Result:=FComment;
    else
      Result:=inherited Get_FieldValue(Code);
    end;
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    Result:=AdversaryGroupE.GetFieldValue(Code);
  end;
end;

procedure TAdversaryVariant.SetFieldValue(Code: integer;
  Value: OleVariant);
var
  AdversaryGroupE:IDMElement;
begin
  if not Get_Exists or
     (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (FAdversaryGroups.Count<>1) then begin
    case Code of
    ord(cnstComment):
      FComment:=Value;
    else
      inherited;
    end;
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    AdversaryGroupE.SetFieldValue(Code, Value);
  end;
end;

class function TAdversaryVariant.GetFields: IDMCollection;
begin
  Result:=FFields
end;

procedure TAdversaryVariant.MakeDefaultGroup;
var
  aCollection:IDMCollection;
  aCollection2:IDMCollection2;
  S:string;
  DMOperationManager:IDMOperationManager;
  ElementU:IUnknown;
  Element:IDMElement;
begin
  aCollection:=(DataModel as IFacilityModel).AdversaryGroups;
  aCollection2:=aCollection as IDMCollection2;
  S:=aCollection2.MakeDefaultName(Self as IDMElement);

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

procedure TAdversaryVariant.AfterLoading1;
begin
  inherited;
  if FAdversaryGroups.Count=0 then
    MakeDefaultGroup;
end;

function TAdversaryVariant.GetAccessType(const Element: IDMElement;
  InCurrentState: WordBool): Integer;
var
  j, AccessType:integer;
  Groups:IDMCollection;
  Group:IWarriorGroup;
begin
  Result:=0;
  Groups:=Get_AdversaryGroups;
  for j:=0 to Groups.Count-1 do begin
    Group:=Groups.Item[j] as IWarriorGroup;
    AccessType:=Group.GetAccessType(Element, InCurrentState);
    if Result<AccessType then
      Result:=AccessType;
    if Result=2 then Exit;
  end;
end;

function TAdversaryVariant.Get_Field_(Index: integer): IDMField;
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (FAdversaryGroups.Count<>1) then begin
    Result:=inherited Get_Field_(Index)
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    Result:=AdversaryGroupE.Get_Field_(Index);
  end;
end;

function TAdversaryVariant.Get_FieldCount_: integer;
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (FAdversaryGroups.Count<>1) then begin
    Result:=inherited Get_FieldCount_
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    Result:=AdversaryGroupE.Get_FieldCount_;
  end;
end;

function TAdversaryVariant.Get_FieldValue_(Index: integer): OleVariant;
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (FAdversaryGroups.Count<>1) then begin
    Result:=inherited Get_FieldValue_(Index)
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    Result:=AdversaryGroupE.Get_FieldValue(Index);
  end
end;

procedure TAdversaryVariant.Set_FieldValue_(Index: integer;
  Value: OleVariant);
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (FAdversaryGroups.Count<>1) then begin
    inherited Set_FieldValue_(Index, Value)
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    AdversaryGroupE.Set_FieldValue(Index, Value);
  end
end;

function TAdversaryVariant.GetOperationName(ColIndex, Index: Integer): WideString;
begin
  case Index of
  1:Result:='Добавить группу нарушителей...';
  else
    Result:='';
  end;
end;

function TAdversaryVariant.DoOperation(ColIndex, Index: Integer; var Param1, Param2,
  Param3: OleVariant): WordBool;
var
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  Server:IDataModelServer;
  AdversaryGroups:IDMCollection;
  AdversaryGroups2:IDMCollection2;
  DataModelE, SelfE:IDMElement;
  ElementU:IUnknown;
  j:integer;
  aName:WideString;
begin
  Result:=False;
  case Index of
  1:begin
      SelfE:=Self as IDMElement;

      Document:=DataModel.Document as IDMDocument;
      DMOperationManager:=Document as IDMOperationManager;
      DataModelE:=DataModel as IDMElement;
      AdversaryGroups:=DataModelE.Collection[_AdversaryGroup];
      AdversaryGroups2:=AdversaryGroups as IDMCollection2;
      aName:=AdversaryGroups2.MakeDefaultName(SelfE);

      Server:=Document.Server;

      Server.EventData3:=-1;
      Server.EventData2:=aName;
      Server.CallDialog(sdmInputQuery, 'Модель нарушителей',
                      'Введите название группы нарушителей');
      if Server.EventData3=-1 then Exit;
      aName:=Server.EventData2;
      if aName='' then Exit;

      Document.State:=Document.State or dmfExecuting;
      DMOperationManager.AddElement(SelfE,
           AdversaryGroups, aName, ltOneToMany, ElementU, True);
      Document.State:=Document.State and not dmfExecuting;
      j:=FAdversaryGroups.Count-1;
      Server.DocumentOperation(ElementU, nil, leoAdd, j);
    end;
  else
    Exit;  
  end;
  Result:=True;
end;

procedure TAdversaryVariant.GetFieldValueSource(Code: Integer;
  var aCollection: IDMCollection);
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (FAdversaryGroups.Count<>1) then begin
    inherited
  end else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    AdversaryGroupE.GetFieldValueSource(Code, aCollection);
  end;
end;

function TAdversaryVariant.Get_ControlDeviceAccesses: IDMCollection;
begin
  Result:=FControlDeviceAccesses
end;

function TAdversaryVariant.Get_GuardPostAccesses: IDMCollection;
begin
  Result:=FGuardPostAccesses
end;

function TAdversaryVariant.Get_Locks: IDMCollection;
begin
  Result:=FLocks
end;

procedure TAdversaryVariant.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  AdversaryGroupE:IDMElement;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (FAdversaryGroups.Count<>1) then
    inherited
  else begin
    AdversaryGroupE:=FAdversaryGroups.Item[0];
    AdversaryGroupE.MakeSelectSource(Index, aCollection)
  end;
end;

function TAdversaryVariant.GetShortCut(ColIndex, Index: Integer): WideString;
begin
  Result:='';
end;

{ TAdversaryVariants }

class function TAdversaryVariants.GetElementClass: TDMElementClass;
begin
  Result:=TAdversaryVariant;
end;

function TAdversaryVariants.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsAdversaryVariant
  else
    Result:=rsAdversaryVariants;
end;

class function TAdversaryVariants.GetElementGUID: TGUID;
begin
  Result:=IID_IAdversaryVariant;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TAdversaryVariant.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
