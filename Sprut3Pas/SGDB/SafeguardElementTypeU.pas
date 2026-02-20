unit SafeguardElementTypeU;

interface
uses
  SysUtils,
  ModelElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB, DMServer_TLB;

type
  TSafeguardElementType=class(TModelElementType, ISafeguardElementType)
  private
    FParents:IDMCollection;
    FOvercomeMethods:IDMCollection;
    FDeviceStates:IDMCollection;
  protected
    procedure Initialize; override;
    procedure _Destroy; override;

    function Get_Parents:IDMCollection; override; safecall;

    procedure _AddChild(const aChild:IDMElement); override;
    procedure _RemoveChild(const aChild:IDMElement); override;

    function Get_HasDistantAction:WordBool; virtual; safecall;
    function Get_CanDetect:WordBool; virtual; safecall;
    function Get_CanDelay:WordBool; virtual; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function  Get_DeviceStates: IDMCollection; safecall;
    function  Get_OvercomeMethods: IDMCollection; safecall;

    procedure BuildReport(ReportLevel: Integer; TabCount: Integer;  Mode: Integer;
                            const Report: IDMText); override;
  end;

  TSafeguardElementTypes=class(TDMCollection, ISafeguardElementTypes)
  private
    FSafeguardClass:ISafeguardClass;
  protected
    function Get_SafeguardClass: ISafeguardClass; safecall;
    procedure Set_SafeguardClass(const Value: ISafeguardClass); safecall;

    property SafeguardClass:ISafeguardClass read Get_SafeguardClass write Set_SafeguardClass;
  end;

implementation
uses
  SafeguardDatabaseConstU,
  SGDBParameterU, OvercomeMethodU, DeviceStateU;

{ TSafeguardElementType }

procedure TSafeguardElementType.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SElfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);
  FOvercomeMethods:=DataModel.CreateCollection(_OvercomeMethod, SelfE);
  FDeviceStates:=DataModel.CreateCollection(_DeviceState, SelfE);
end;

procedure TSafeguardElementType._Destroy;
begin
  inherited;
  FParents:=nil;
  FOvercomeMethods:=nil;
  FDeviceStates:=nil;
end;

procedure TSafeguardElementType._AddChild(const aChild: IDMElement);
var
  j:integer;
  ParameterValueU:IUnknown;
  Unk:IUnknown;
  SGDBParameterValues:IDMCollection;
  OperationManager:IDMOperationManager;
begin
  inherited;
  if ((DataModel.Document as IDMDocument).State and dmfLoading)<>0 then Exit;
  if aChild.QueryInterface(ISGDBParameter, Unk)<>0 then Exit;
  if Parameters=nil then Exit;
  if SubKinds=nil then Exit;

  OperationManager:=DataModel.Document as IDMOperationManager;
  SGDBParameterValues:=(DataModel as ISafeguardDatabase).SGDBParameterValues;
  for j:=0 to SubKinds.Count-1 do
    OperationManager.AddElementRef(
        SubKinds.Item[j], SGDBParameterValues, '',
        aChild, ltOneToMany, ParameterValueU, True);
end;

procedure TSafeguardElementType._RemoveChild(const aChild: IDMElement);
var
  j:integer;
  Unk:IUnknown;
  ParameterValue:IDMElement;
  OperationManager:IDMOperationManager;
  SafeguardElementKind:IModelElementKind;
  Document:IDMDocument;
begin
  try
  inherited;
  if aChild.QueryInterface(ISGDBParameter, Unk)<>0 then Exit;
  if Parameters=nil then Exit;
  if SubKinds=nil then Exit;
  Document:=DataModel.Document as IDMDocument;
  if Document=nil then Exit;
  if (Document.State and dmfDestroying)<>0 then Exit;
  if (Document.State and dmfLoading)<>0 then Exit;

  OperationManager:=DataModel.Document as IDMOperationManager;
  for j:=0 to SubKinds.Count-1 do begin
    SafeguardElementKind:=SubKinds.Item[j] as IModelElementKind;
    ParameterValue:=(SafeguardElementKind.ParameterValues as IDMCollection2).GetItemByRef(aChild);
    if ParameterValue<>nil then
      OperationManager.DeleteElement(
         SubKinds.Item[j], nil,
         ltOneToMany, ParameterValue);
  end;
  except
    raise
  end  
end;

function TSafeguardElementType.Get_CollectionCount: integer;
begin
  Result:=5;
end;

function TSafeguardElementType.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

function TSafeguardElementType.Get_HasDistantAction: WordBool;
begin
  Result:=False;
end;

function TSafeguardElementType.Get_CanDelay: WordBool;
begin
  Result:=False;
end;

function TSafeguardElementType.Get_CanDetect: WordBool;
begin
  Result:=False;
end;

function TSafeguardElementType.Get_Collection(
  Index: Integer): IDMCollection;
begin
  case Index of
  3:Result:=FOvercomeMethods;
  4:Result:=FDeviceStates;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

procedure TSafeguardElementType.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  3:begin
      aCollectionName:=FOvercomeMethods.ClassAlias[akImenitM];
      aOperations:=leoAdd or leoSelect  or leoDelete or leoRename;
      aRefSource:=nil;
      aClassCollections:=nil;
      aLinkType:=ltManyToMany;
    end;
  4:begin
      aCollectionName:=FDeviceStates.ClassAlias[akImenitM];
      aOperations:=leoAdd or leoSelect or leoRename;
      aRefSource:=nil;
      aClassCollections:=nil;
      aLinkType:=ltManyToMany;
    end;
  else
    inherited
  end;
end;

function TSafeguardElementType.Get_DeviceStates: IDMCollection;
begin
  Result:=FDeviceStates
end;

function TSafeguardElementType.Get_OvercomeMethods: IDMCollection;
begin
  Result:=FOvercomeMethods
end;

procedure TSafeguardElementType.BuildReport(
    ReportLevel: Integer; TabCount: Integer;  Mode: Integer;
    const Report: IDMText);
var
  S:WideString;
  j:integer;
  Reporter:IDMReporter;
begin
  S:=Format('Способы преодоления средства охраны "%s"',
     [Name]);
  Report.AddLine(S);

  for j:=0 to FOvercomeMethods.Count-1 do begin
    Reporter:=FOvercomeMethods.Item[j] as IDMReporter;
    Reporter.BuildReport(0, 1, Mode,  Report);
  end;

  Report.AddLine('');
  S:=Format('Виды средства охраны "%s"',
     [Name]);
  Report.AddLine(S);
  for j:=0 to SubKinds.Count-1 do begin
    S:='     '+SubKinds.Item[j].Name;
    Report.AddLine(S);
  end;
end;


{ TSafeguardElementTypes }

function TSafeguardElementTypes.Get_SafeguardClass: ISafeguardClass;
begin
  Result:=FSafeguardClass
end;

procedure TSafeguardElementTypes.Set_SafeguardClass(
  const Value: ISafeguardClass);
begin
  FSafeguardClass:=Value
end;

end.
