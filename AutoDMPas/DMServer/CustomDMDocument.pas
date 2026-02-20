unit CustomDMDocument;

interface

uses
  DM_ComObj,
  Classes, Dialogs, SysUtils, Forms,
  DataModel_TLB, DMServer_TLB, DMComObjectU,
  DMTransactionU, StdVcl, Variants;

var
  NilUnk:IUnknown=nil;
  
type
  TCustomDMDocument = class(TDMComObject,
//  TCustomDMDocument = class(TDM_AutoObject,
                      IDMDocument, IDMOperationManager)
  private
    FAnalyzer:IUnknown;
    FPassword:WideString;

    FCurrentElementID:integer;
    FCurrentElementClassID:integer;
    FCurrentCollectionIndex:integer;
    FCurrentObjectExpanded:integer;

    FTopElementID:integer;
    FTopElementClassID:integer;
    FTopCollectionIndex:integer;

  protected
    FServer:pointer;
    FDataModel: IUnknown;

    FOperationStepExecutedFlag:boolean;
    FDocumentOperationFlag:boolean;
    FDocumentOperationElement:pointer;
    FDocumentOperationCollection:pointer;
    FDocumentOperationOperation:integer;
    FDocumentOperationItemIndex:integer;

    FSelectedElements:TList;
    FPrevSelectedElements0:IDMCollection;
    FPrevSelectedElements1:IDMCollection;
    FSourceCollection:IDMCollection;
    FDestCollection:IDMCollection;

    FCurrentElement:pointer;
    FCurrentTransaction:TDMTransaction;
    FTransactions:TList;
    FMaxTransactionCount:integer;
    FCurrentTransactionIndex:integer;
    FChangeCount:integer;

    FUndoSelectionFlag:boolean;

    function CreateTransaction(const aCollectionU:IUnknown;
              Operation:integer; const TransactionName:string):TDMTransaction;

  // реализация интерфейса IDMDocument
    function  Get_RootObjectCount: Integer; safecall;
    procedure GetRootObject(RootIndex: Integer; out RootObject: IUnknown;
      out RootObjectName: WideString; out aOperations: Integer; out aLinkType: Integer); safecall;
    function  Get_CurrentElement: IUnknown; safecall;
    procedure Set_CurrentElement(const Value: IUnknown); safecall;
    function  Get_DataModel: IUnknown; safecall;
    procedure Set_DataModel(const Value: IUnknown); virtual; safecall;
    function  Get_ChangeCount: Integer; safecall;
    procedure IncChangeCount; safecall;
    procedure DecChangeCount; safecall;
    procedure ResetChangeCount; safecall;
    function  Get_SelectionCount: Integer; safecall;
    function  Get_SelectionItem(Index: Integer): IUnknown; safecall;
    procedure Select(const aElement: IUnknown); virtual; safecall;
    procedure UnSelect(const aElement: IUnknown); safecall;
    procedure ClearSelection(const ExceptedElementU: IUnknown); virtual; safecall;
    procedure UndoSelection; virtual; safecall;
    function  Get_State: Integer; safecall;
    procedure Set_State(Value: Integer); safecall;
    function  Get_Server: IDataModelServer; safecall;
    procedure Set_Server(const Value: IDataModelServer); safecall;
    function  Get_Analyzer:IUnknown; safecall;
    procedure Set_Analyzer(const Value: IUnknown); safecall;
    function  Get_Password:WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;

// реализация интерфейса IDMOperationManager
    function Get_SourceCollection:IUnknown; safecall;
    function Get_DestCollection:IUnknown; safecall;
    procedure AddElement(const ParentElementU: IUnknown;
                         const CollectionU: IUnknown;
                         const aName: WideString; aLinkType: Integer;
                         out aElementU: IUnknown; SetParentFlag:WordBool); safecall;
    procedure _AddElement(const ClassCollectionU: IUnknown;
      const ParentElementU: IUnknown;
      const CollectionU: IUnknown;
      const aName: WideString; aLinkType: Integer;
      out aElementU: IUnknown; SetParentFlag:WordBool); safecall;
    procedure AddElementParent(const ParentElementU, aElementU: IUnknown); safecall;
    procedure RemoveElementParent(const ParentElementU, aElementU: IUnknown); safecall;
    procedure DeleteElement(const ParentElementU: IUnknown;
                            const CollectionU: IUnknown;
                            aLinkType: Integer;
                            const aElementU: IUnknown); safecall;
    procedure DeleteElements(const Collection:IUnknown;
                             ConfirmFlag:WordBool); virtual; safecall;
    procedure AddElementRef(const ParentElementU: IUnknown;
                            const CollectionU: IUnknown;
                            const aName: WideString;
                            const aRefU: IUnknown; aLinkType: Integer;
                            out aElementU: IUnknown; SetParentFlag:WordBool); virtual; safecall;
    procedure _AddElementRef(const ClassCollectionU: IUnknown;
                            const ParentElementU: IUnknown;
                            const CollectionU: IUnknown;
                            const aName: WideString;
                            const aRefU: IUnknown; aLinkType: Integer;
                            out aElementU: IUnknown; SetParentFlag:WordBool); safecall;
    procedure AddDeleteElements(const ParentElementU: IUnknown;
                                const DestCollectionU, SourceCollectionU: IUnknown;
                                aLinkType: Integer); safecall;
    procedure AddDeleteRefs(const theParentElementU: IUnknown;
                            const theDestCollectionU, SourceCollectionU: IUnknown;
                            const RefSourceU: IUnknown;
                            const RefDocument:IDMDocument); safecall;
    procedure ChangeRef(const CollectionU: IUnknown;
                        const aName: WideString;
                        const aRefU, aElementU: IUnknown); safecall;
    procedure ChangeParent(const CollectionU: IUnknown;
                        const aParentU, aElementU: IUnknown); safecall;
    procedure RenameElement(const aElementU: IUnknown;
                            const NewName: WideString); safecall;
    procedure ChangeFieldValue(const aElementU: IUnknown;
                            FieldIndex: Integer; FieldByCode: WordBool;
                            Value: OleVariant); safecall;
    procedure ClearElement(const aElementU: IUnknown); safecall;
    procedure MoveElement(const CollectionU: IUnknown;
                          const aElementU: IUnknown;
                          NewIndex: Integer; MoveInOwnerCollection:WordBool); safecall;
    procedure Undo; virtual; safecall;
    procedure Redo; virtual; safecall;
    procedure StartTransaction(const CollectionU: IUnknown;
         DMOperation: Integer; const TransactionName:WideString); safecall;
    procedure CommitTransaction(const ElementU: IUnknown;
                                const CollectionU: IUnknown;
                                DMOperation: Integer); safecall;
    procedure FinishTransaction(const ElementsV: IUnknown;
                                const CollectionV: IUnknown;
                                DMOperation: Integer); safecall;
    procedure PasteToElement(const SourceElementU: IUnknown;
                            const DestElementU: IUnknown;
                            CopySpatialElementFlag, LowerLevelPaste:WordBool); virtual; safecall;
    procedure PasteToCollection(const ParentElementU: IUnknown;
                                const SourceElementU: IUnknown;
                                const DestCollectionU: IUnknown;
                                aLinkType: Integer;
                                out aElementU:IUnknown); safecall;
    procedure UpdateElement(const aElementU: IUnknown); safecall;
    procedure UpdateCoords(const aElementU: IUnknown); safecall;
    function  Get_Hint: WideString; virtual; safecall;
    function  Get_Cursor: Integer; virtual; safecall;

    function  Get_TransactionCount: Integer; safecall;
    function  Get_TransactionName(Index: Integer): WideString; safecall;
    function  Get_CurrentTransactionIndex: Integer; safecall;
    procedure SaveTransactions(const FileName:WideString); safecall;
    procedure LoadTransactions(const FileName:WideString); virtual; safecall;
    function CreateClone(const aElementU: IUnknown): IUnknown; safecall;

    function  Get_CurrentElementID:integer; safecall;
    procedure Set_CurrentElementID(Value:integer); safecall;
    function  Get_CurrentElementClassID:integer; safecall;
    procedure Set_CurrentElementClassID(Value:integer); safecall;
    function  Get_CurrentCollectionIndex:integer; safecall;
    procedure Set_CurrentCollectionIndex(Value:integer); safecall;
    function  Get_CurrentObjectExpanded:integer; safecall;
    procedure Set_CurrentObjectExpanded(Value:integer); safecall;
    function  Get_TopElementID:integer; safecall;
    procedure Set_TopElementID(Value:integer); safecall;
    function  Get_TopElementClassID:integer; safecall;
    procedure Set_TopElementClassID(Value:integer); safecall;
    function  Get_TopCollectionIndex:integer; safecall;
    procedure Set_TopCollectionIndex(Value:integer); safecall;

    procedure OnCreateRefElement(ClassID: integer;
      const RefElementU: IUnknown); virtual; safecall;

    procedure DoUndoSelection;
    procedure ClearPrevSelection(ClearAll:WordBool); virtual; safecall;

public
    procedure Initialize; override;
    destructor Destroy; override;
    procedure SetDocumentOperation(const DMElement, DMCollection: IUnknown;
                                   DMOperation, nItemIndex: Integer); safecall;
    property OperationStepExecutedFlag:boolean
                           read FOperationStepExecutedFlag
                          write FOperationStepExecutedFlag;
end;

implementation

uses
  ComServ,
  DataModelServerConsts, DMOperationU, DMUtils;

procedure TCustomDMDocument.Initialize;
begin
  inherited Initialize;

  FSelectedElements:=TList.Create;
  FTransactions:=TList.Create;
  FMaxTransactionCount:=9999999;
  FCurrentTransactionIndex:=-1;
  FChangeCount:=0;

  FCurrentElementID:=-1;
  FCurrentElementClassID:=-1;
  FCurrentCollectionIndex:=-1;
  FCurrentObjectExpanded:=-1;

  FTopElementID:=-1;
  FTopElementClassID:=-1;
  FTopCollectionIndex:=-1;
end;

{ TCustomDMDocument }

function TCustomDMDocument.Get_CurrentElement: IUnknown;
begin
  Result:=IUnknown(FCurrentElement);
end;

procedure TCustomDMDocument.GetRootObject(RootIndex: Integer; out RootObject: IUnknown;
      out RootObjectName: WideString; out aOperations: Integer; out aLinkType: Integer); safecall;
begin
  RootObject:=nil;
  RootObjectName:='';
  aOperations:=0;
  aLinkType:=ltOneToMany;
end;

procedure TCustomDMDocument.Set_CurrentElement(const Value: IUnknown);
begin
  FCurrentElement:=pointer(Value);
end;

function TCustomDMDocument.Get_DataModel: IUnknown;
begin
  Result:=FDataModel
end;

procedure TCustomDMDocument.Set_DataModel(const Value: IUnknown);
var
  DataModel:IDataModel;
begin
  FDataModel:=Value;
  if FDataModel=nil then Exit;
  DataModel:=FDataModel as IDataModel;
  DataModel.Document:=Self as IUnknown;

  FPrevSelectedElements0:=DataModel.CreateCollection(-1, nil);
  FPrevSelectedElements1:=DataModel.CreateCollection(-1, nil);
  FSourceCollection:=DataModel.CreateCollection(-1, nil);
  FDestCollection:=DataModel.CreateCollection(-1, nil);
end;

function TCustomDMDocument.Get_RootObjectCount: Integer;
begin
  Result:=0
end;

destructor TCustomDMDocument.Destroy;
var
  N:integer;
  aDataModel:IDMElement;
begin
  inherited;
  ClearSelection(nil);
  ClearPrevSelection(True);
  FSelectedElements.Free;
  FPrevSelectedElements0:=nil;
  FPrevSelectedElements1:=nil;
  FSourceCollection:=nil;
  FDestCollection:=nil;

  while FTransactions.Count>0 do begin
    N:=FTransactions.Count-1;
    TDMTransaction(FTransactions[N]).Free;
    FTransactions.Delete(N);
  end;
  FTransactions.Free;

  if aDataModel<>nil then begin
    aDataModel:=FDataModel as IDMElement;
    aDataModel.Clear;
    FDataModel:=nil;
  end;

  FAnalyzer:=nil;
end;

procedure  TCustomDMDocument.ChangeRef(
                        const CollectionU: IUnknown;
                        const aName: WideString;
                        const aRefU, aElementU: IUnknown);
var
  Operation:TDMOperation;
  OldState:integer;
  Collection: IDMCollection;
  aRef, aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;

  Collection:=CollectionU as IDMCollection;
  aRef:=aRefU as IDMElement;
  aElement:=aElementU as IDMElement;

  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(Collection, leoChangeRef, rsChangeRef);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TSetRefOperation.Create(aElement, aRef);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  Operation:=TRenameElementOperation.Create(aElement, aName);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;

end;

procedure TCustomDMDocument.AddDeleteRefs(
                            const theParentElementU: IUnknown;
                            const theDestCollectionU, SourceCollectionU: IUnknown;
                            const RefSourceU: IUnknown;
                            const RefDocument:IDMDocument);
var
  OldState:integer;
  theDestCollection, SourceCollection: IDMCollection;
  RefSource: IDMCollection;

  procedure DoAddDeleteRefs(k:integer; const ParentElement:IDMElement);
  var
    j, m:integer;
    aElement, aRef:IDMElement;
    Operation:TDMOperation;
    DestCollection:IDMCollection;
  begin
    DestCollection:=ParentElement.Collection[k];
    j:=0;
    while j<DestCollection.Count do begin
      aElement:=DestCollection.Item[j];
      aRef:=aElement.Ref;
      if SourceCollection.IndexOf(aRef)=-1 then begin
        Operation:=TSetParentOperation.Create(aElement, nil);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);

        Operation:=TSetRefOperation.Create(aElement, nil);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);

        Operation:=TDestroyElementOperation.Create(aElement);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);
      end else
        inc(j)
    end;

    for j:=0 to SourceCollection.Count-1 do begin
      aRef:=SourceCollection.Item[j];
      m:=0;
      while m<DestCollection.Count do
        if DestCollection.Item[m].Ref=aRef then
          Break
        else
          inc(m);
      if m=DestCollection.Count then begin
        aElement:=(DestCollection as IDMCollection2).CreateElement(False);
        Operation:=TCreateElementOperation.Create0(aElement);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);

        Operation:=TSetRefOperation.Create(aElement, aRef);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);

        Operation:=TSetParentOperation.Create(aElement, ParentElement);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);
      end;
    end;
  end;

var
  aElement, theElement, aParentElement, GrandParentElement:IDMElement;
  k, j, CollectionIndex, Indx, i, CollectionIndex1, Indx1, l:integer;
  aCollection, theCollection:IDMCollection;
  aCollection2, theCollection2:IDMCollection2;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  aElement:=theParentElementU as IDMElement;
  theDestCollection:=theDestCollectionU as IDMCollection;
  SourceCollection:=SourceCollectionU as IDMCollection;
  RefSource:=RefSourceU as IDMCollection;

  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(theDestCollection, leoSelect, rsAddDeleteRefs);

  k:=0;
  while k<aElement.CollectionCount do begin
    if aElement.Collection[k]=theDestCollection then
      Break
    else
      inc(k);
  end;
  if k=aElement.CollectionCount then begin
    Raise Exception.Create('Ошибка в AddDeleteRefs');
  end;

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try
  if (Get_SelectionCount=0) or
     (aElement.Parent=nil) then
    DoAddDeleteRefs(k, aElement)
  else
  if aElement.Selected then begin
    for j:=0 to Get_SelectionCount-1 do begin
      theElement:=Get_SelectionItem(j) as IDMElement;
      if (theElement.Ref<>nil) and
        (theElement.Ref.SpatialElement=theElement) then
        theElement:=theElement.Ref;
      DoAddDeleteRefs(k, theElement);
    end
  end else
  if aElement.Parent.Selected then begin
    CollectionIndex:=0;
    while CollectionIndex<aElement.Parent.CollectionCount do begin
      aCollection:=aElement.Parent.Collection[CollectionIndex];
      if aCollection.IndexOf(aElement)<>-1 then
        Break
      else
        inc(CollectionIndex);
    end;

    Indx:=aCollection.IndexOf(aElement);

    for j:=0 to Get_SelectionCount-1 do begin
      aParentElement:=Get_SelectionItem(j) as IDMElement;
      if (aParentElement.Ref<>nil) and
        (aParentElement.Ref.SpatialElement=aParentElement) then
        aParentElement:=aParentElement.Ref;
      if (aParentElement.Ref=aElement.Parent.Ref) and
         (CollectionIndex<aParentElement.CollectionCount) then begin
        aCollection:=aParentElement.Collection[CollectionIndex];
        if (aCollection.QueryInterface(IDMCollection2, aCollection2)=0) and
           aCollection2.CanContain(aElement) then begin
          if Indx=-1 then begin
            for i:=0 to aCollection.Count-1 do begin
              theElement:=aCollection.Item[i];
              DoAddDeleteRefs(k, theElement);
            end;
          end else begin
            theElement:=aCollection.Item[Indx];
            DoAddDeleteRefs(k, theElement);
          end;
        end;
      end;
    end
  end else
  if (aElement.Parent.Parent<>nil) and
      aElement.Parent.Parent.Selected then begin
    GrandParentElement:=aElement.Parent.Parent;

    CollectionIndex1:=0;
    Indx1:=-1;
    while CollectionIndex1<GrandParentElement.CollectionCount do begin
      aCollection:=GrandParentElement.Collection[CollectionIndex1];
      Indx1:=aCollection.IndexOf(aElement.Parent);
      if Indx1<>-1 then
        Break
      else
        inc(CollectionIndex1);
    end;

    CollectionIndex:=0;
    while CollectionIndex<aElement.Parent.CollectionCount do begin
      aCollection:=aElement.Parent.Collection[CollectionIndex];
      if aCollection.IndexOf(aElement)<>-1 then
        Break
      else
        inc(CollectionIndex);
    end;

    Indx:=aCollection.IndexOf(aElement);

    for j:=0 to Get_SelectionCount-1 do begin
      GrandParentElement:=Get_SelectionItem(j) as IDMElement;
      if (GrandParentElement.Ref<>nil) and
         (GrandParentElement.Ref.SpatialElement=GrandParentElement) then
        GrandParentElement:=GrandParentElement.Ref;
      if (GrandParentElement.Ref=aElement.Parent.Parent.Ref) and
         (CollectionIndex1<GrandParentElement.CollectionCount) then begin
        aCollection:=GrandParentElement.Collection[CollectionIndex1];
        if (aCollection.QueryInterface(IDMCollection2, aCollection2)=0) and
          aCollection2.CanContain(aElement.Parent) then begin
          if Indx1<aCollection.Count then begin
            aParentElement:=aCollection.Item[Indx1];
            if aParentElement.Ref=aElement.Parent.Ref then
              if CollectionIndex<aParentElement.CollectionCount then begin
                theCollection:=aParentElement.Collection[CollectionIndex];
                if (theCollection.QueryInterface(IDMCollection2, theCollection2)=0) and
                   theCollection2.CanContain(aElement) then begin
                  if Indx=-1 then begin
                    for l:=0 to theCollection.Count-1 do begin
                      theElement:=theCollection.Item[l];
                      DoAddDeleteRefs(k, theElement);
                    end;
                  end else begin
                    theElement:=theCollection.Item[Indx];
                    DoAddDeleteRefs(k, theElement);
                  end;
                end;
              end;

          end;
        end;
      end;
    end;

  end else
    DoAddDeleteRefs(k, aElement);


  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;

end;

procedure TCustomDMDocument.AddElement(
                         const ParentElementU: IUnknown;
                         const CollectionU: IUnknown;
                         const aName: WideString; aLinkType: Integer;
                         out aElementU: IUnknown; SetParentFlag:WordBool);
begin
  _AddElement(CollectionU, ParentElementU, CollectionU,
              aName, aLinkType, aElementU, SetParentFlag)
end;

procedure TCustomDMDocument.AddElementRef(
                            const ParentElementU: IUnknown;
                            const CollectionU: IUnknown;
                            const aName: WideString;
                            const aRefU: IUnknown; aLinkType: Integer;
                            out aElementU: IUnknown; SetParentFlag:WordBool);
begin
  _AddElementRef(CollectionU, ParentElementU, CollectionU,
                 aName, aRefU, aLinkType, aElementU, SetParentFlag);
end;

procedure TCustomDMDocument.DeleteElement(
  const ParentElementU: IUnknown;
  const CollectionU: IUnknown;
  aLinkType: Integer;
  const aElementU: IUnknown);
var
  Operation:TDMOperation;
  OldState:integer;
  ParentElement: IDMElement;
  Collection: IDMCollection;
  aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  ParentElement:=ParentElementU as IDMElement;
  Collection:=CollectionU as IDMCollection;
  aElement:=aElementU as IDMElement;

  if FCurrentTransaction=nil  then
    FCurrentTransaction:=CreateTransaction(Collection, leoDelete, rsDelete);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting;
  try

  if aLinkType=ltOneToMany then begin
    ClearElement(aElement)
  end else begin
    if (aElement.Parents<>nil) and
       (aElement.Parents.Count=1) then begin
      ClearElement(aElement)
    end else begin

      Operation:=TRemoveParentOperation.Create(aElement, ParentElement);
      FCurrentTransaction.AddOperation(Operation);
      Operation.Commit(Self);
    end;
  end;

  Operation:=TDestroyElementOperation.Create(aElement);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
    ClearPrevSelection(True);
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

procedure TCustomDMDocument.AddDeleteElements(
                                const ParentElementU: IUnknown;
                                const DestCollectionU, SourceCollectionU: IUnknown;
                                aLinkType: Integer);
var
  Operation:TDMOperation;
  aElement:IDMElement;
  j, OldState:integer;
  ParentElement: IDMElement;
  DestCollection, SourceCollection: IDMCollection;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  ParentElement:=ParentElementU as IDMElement;
  DestCollection:=DestCollectionU as IDMCollection;
  SourceCollection:=SourceCollectionU as IDMCollection;

  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(DestCollection, leoSelect, rsAddDeleteElement);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  j:=0;
  while j<DestCollection.Count do begin
    aElement:=DestCollection.Item[j];
    if SourceCollection.IndexOf(aElement)=-1 then begin
      if aLinkType=ltOneToMany then
        Operation:=TSetParentOperation.Create(aElement, nil)
      else
        Operation:=TRemoveParentOperation.Create(aElement, ParentElement);
      FCurrentTransaction.AddOperation(Operation);
      Operation.Commit(Self);

      if (aElement.Parent=nil) and
         ((aElement.Parents=nil) or
          (aElement.Parents.Count=0)) then begin
        ClearElement(aElement);
        Operation:=TDestroyElementOperation.Create(aElement);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);
      end;
    end else
      inc(j);
  end;

  for j:=0 to SourceCollection.Count-1 do begin
    aElement:=SourceCollection.Item[j];
    if (aElement.Ref<>nil) and
       (aElement.Ref.SpatialElement=aElement) then
      aElement:=aElement.Ref;
    if DestCollection.IndexOf(aElement)=-1 then begin
      if aLinkType=ltOneToMany then
        Operation:=TSetParentOperation.Create(aElement, ParentElement)
      else
        Operation:=TAddParentOperation.Create(aElement, ParentElement);
      FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);
    end;
  end;

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;

end;

procedure TCustomDMDocument.RenameElement(
  const aElementU: IUnknown;
  const NewName: WideString);
var
  Operation:TDMOperation;
  OldState:integer;
  aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  aElement:=aElementU as IDMElement;

  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(nil, leoRename, rsRename);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TRenameElementOperation.Create(aElement, NewName);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

function TCustomDMDocument.CreateTransaction(const aCollectionU:IUnknown;
     Operation:integer; const TransactionName:string): TDMTransaction;
var
  N:integer;
  aCollection:IDMCollection;
  LastTransaction:TDMTransaction;
  OldState:integer;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  aCollection:=aCollectionU as IDMCollection;

  aDataModel.State:=aDataModel.State or dmfModified;
  aDataModel.State:=aDataModel.State or dmfNotEmpty;

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfRollBacking;
  try

  while FTransactions.Count-1>FCurrentTransactionIndex do begin
    N:=FTransactions.Count-1;
    TDMTransaction(FTransactions[N]).Clear;
    TDMTransaction(FTransactions[N]).Free;
    FTransactions.Delete(N);
  end;
  finally
    aDataModel.State:=OldState;
  end;

  Result:=TDMTransaction.Create(aCollection, Operation, TransactionName);
  if FTransactions.Count>0 then
    LastTransaction:=TDMTransaction(FTransactions[FTransactions.Count-1])
  else
    LastTransaction:=nil;
  if LastTransaction<>nil then begin
    if LastTransaction.Operations.Count>0 then
      inc(FCurrentTransactionIndex)
    else begin
      LastTransaction.Clear;
      LastTransaction.Free;
      FTransactions.Delete(FTransactions.Count-1);
    end;
  end else
    inc(FCurrentTransactionIndex);
  FTransactions.Add(Result);

  if FTransactions.Count>FMaxTransactionCount then begin

    TDMTransaction(FTransactions[0]).Free;
    FTransactions.Delete(0);
    dec(FCurrentTransactionIndex);
  end;
end;

function TCustomDMDocument.Get_SelectionCount: Integer;
begin
  Result:=FSelectedElements.Count
end;

procedure TCustomDMDocument.ClearSelection(const ExceptedElementU: IUnknown);
var
  p:pointer;
  aElement:IDMElement;
  j, OldSelectState:integer;
  ExceptedElement:IDMElement;
  aDataModel:IDataModel;
begin
  if FSelectedElements.Count=0 then Exit;
  ExceptedElement:=ExceptedElementU as IDMElement;
  if (ExceptedElement<>nil) and
     (ExceptedElement.Ref<>nil) and
     (ExceptedElement.Ref.SpatialElement=ExceptedElement) then
   ExceptedElement:=ExceptedElement.Ref;

  j:=0;

  aDataModel:=Get_DataModel as IDataModel;
  if aDataModel<>nil then begin
    OldSelectState:=aDataModel.State and dmfSelecting;
    aDataModel.State:=aDataModel.State or dmfSelecting;
  end;
  try

  if not FUndoSelectionFlag then
    (FPrevSelectedElements0 as IDMCollection2).Clear
  else
    (FPrevSelectedElements1 as IDMCollection2).Clear;

  while j<FSelectedElements.Count do begin
    p:=FSelectedElements[j];
    aElement:=IDMElement(p);
    if (aElement.Ref<>nil) and
       (aElement.Ref.SpatialElement=aElement) then
     aElement:=aElement.Ref;

    if not FUndoSelectionFlag then
      (FPrevSelectedElements0 as IDMCollection2).Add(aElement)
    else
      (FPrevSelectedElements1 as IDMCollection2).Add(aElement);

    if aElement<>ExceptedElement then begin
      if aElement.Selected then
        aElement.Selected:=False
      else begin
        FSelectedElements.Remove(p);
        aElement._Release;
      end;
    end else
      inc(j)
  end;

  finally
    if aDataModel<>nil then
      aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
  end;

  Get_Server.SelectionChanged(nil);
end;

function TCustomDMDocument.Get_SelectionItem(Index: Integer): IUnknown;
var
  p:pointer;
begin
  p:=FSelectedElements[Index];
  Result:=IUnknown(p);
end;

procedure TCustomDMDocument.Select(const aElement: IUnknown);
var
  p:pointer;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  p:=pointer(aElement);
  if FSelectedElements.IndexOf(p)<>-1 then Exit;
  FSelectedElements.Add(p);
  aElement._AddRef;
  if (aDataModel.State and dmfSelecting)=0 then
    Get_Server.SelectionChanged(aElement);
end;

procedure TCustomDMDocument.UnSelect(const aElement: IUnknown);
var
  p:pointer;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  p:=pointer(aElement);
  if FSelectedElements.IndexOf(p)=-1 then Exit;
  FSelectedElements.Remove(p);
  aElement._Release;
  if (aDataModel.State and dmfSelecting)=0 then
    Get_Server.SelectionChanged(aElement);
end;

procedure TCustomDMDocument.Redo;
var
  aElement: IDMElement;
  OldState:integer;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  if (FCurrentTransactionIndex<FTransactions.Count-1) then begin
    inc(FCurrentTransactionIndex);
    FCurrentTransaction:=FTransactions[FCurrentTransactionIndex];

    OldState:=aDataModel.State;
    aDataModel.State:=OldState or dmfCommiting;
    try

    FCurrentTransaction.Commit(Self as IDMDocument);

    finally
      aDataModel.State:=OldState;
    end;

    aElement:=FCurrentTransaction.LastElement;

    aDataModel.State:=aDataModel.State or dmfCanUndo;
    if FCurrentTransactionIndex=FTransactions.Count-1 then
      aDataModel.State:=aDataModel.State and not dmfCanRedo
    else
      aDataModel.State:=aDataModel.State or dmfCanRedo;


    if ((aDataModel.State and dmfLoadingTransactions)=0) and
       ((aDataModel.State and dmfAuto)=0) then
      SetDocumentOperation(aElement, FCurrentTransaction.Collection,
                        FCurrentTransaction.Operation, -1);
  end;
end;

procedure TCustomDMDocument.Undo;
var
  aElement: IDMElement;
  OldState:integer;
  Server:IDataModelServer;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  if (FCurrentTransactionIndex<>-1) and
    (FCurrentTransaction<>nil) then begin

    OldState:=aDataModel.State;
    aDataModel.State:=OldState or dmfRollBacking;
    try

    FCurrentTransaction.RollBack(Self as IDMDocument);

    finally
      aDataModel.State:=OldState;
    end;

    dec(FCurrentTransactionIndex);
    aElement:=FCurrentTransaction.LastElement;

    aDataModel.State:=aDataModel.State or dmfCanRedo;
    if FCurrentTransactionIndex=-1 then
      aDataModel.State:=aDataModel.State and not dmfCanUndo
    else
      aDataModel.State:=aDataModel.State or dmfCanUndo;

    if ((aDataModel.State and dmfLoadingTransactions)=0) and
       ((aDataModel.State and dmfAuto)=0) then begin
        Server:=Get_Server;
        SetDocumentOperation(aElement,
                          FCurrentTransaction.Collection,
                          FCurrentTransaction.Operation, -1);
        if (aDataModel.State and dmfLongOperation)=0 then
          Server.OperationStepExecuted
        else
          FOperationStepExecutedFlag:=True;
    end;
    if FCurrentTransactionIndex<>-1 then
      FCurrentTransaction:=FTransactions[FCurrentTransactionIndex];
  end;
end;

function TCustomDMDocument.Get_ChangeCount: Integer;
begin
  Result:=FChangeCount
end;

procedure TCustomDMDocument.DecChangeCount;
begin
  dec(FChangeCount)
end;

procedure TCustomDMDocument.IncChangeCount;
begin
  inc(FChangeCount)
end;

procedure TCustomDMDocument.ResetChangeCount;
begin
  FChangeCount:=0
end;

procedure TCustomDMDocument.ChangeFieldValue(
  const aElementU: IUnknown;
  FieldIndex: Integer;  FieldByCode: WordBool; Value: OleVariant);
var
  Operation:TDMOperation;
  OldState, FieldCode:integer;
  aElement: IDMElement;
  Server:IDataModelServer;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  aElement:=aElementU as IDMElement;
  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(nil, leoChangeFieldValue, rsChangeFieldValue);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  if  FieldByCode then
    FieldCode:=FieldIndex
  else
    FieldCode:=aElement.Field[FieldIndex].Code;

  Operation:=TChangeFieldValueOperation.Create(aElement, FieldCode, Value);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;

  Server:=Get_Server as IDataModelServer;
  if ((aDataModel.State and dmfExecuting)=0) then begin
    if (aDataModel.State and dmfLongOperation)=0 then
      Server.OperationStepExecuted
    else
      FOperationStepExecutedFlag:=True;
  end;
end;

procedure TCustomDMDocument._AddElementRef(
  const ClassCollectionU: IUnknown;
  const ParentElementU: IUnknown;
  const CollectionU: IUnknown;
  const aName: WideString;
  const aRefU: IUnknown; aLinkType: Integer;
  out aElementU: IUnknown; SetParentFlag:WordBool);
var
  Operation:TDMOperation;
  OldState:integer;
  ClassCollection: IDMCollection;
  ParentElement: IDMElement;
  Collection: IDMCollection;
  aRef: IDMElement;
  aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  ClassCollection:=ClassCollectionU as IDMCollection;
  ParentElement:=ParentElementU as IDMElement;
  Collection:=CollectionU as IDMCollection;
  aRef:=aRefU as IDMElement;

  aElement:=(ClassCollection as IDMCollection2).CreateElement(False);
  aElementU:=aElement as IUnknown;
  aElement.Name:=aName;

  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(ClassCollection, leoAdd, rsAddElementRef);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TCreateElementOperation.Create0(aElement);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  Operation:=TSetRefOperation.Create(aElement, aRef);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  if SetParentFlag then begin
    if aLinkType=ltOneToMany then begin
      Operation:=TSetParentOperation.Create(aElement, ParentElement);
      FCurrentTransaction.AddOperation(Operation);
      Operation.Commit(Self);
    end;
  end;  

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

procedure TCustomDMDocument._AddElement(
  const ClassCollectionU: IUnknown;
  const ParentElementU: IUnknown;
  const CollectionU: IUnknown;
  const aName: WideString;
  aLinkType: Integer;
  out aElementU: IUnknown; SetParentFlag:WordBool);
var
  Operation:TDMOperation;
  OldState:integer;
  ClassCollection: IDMCollection;
  ParentElement: IDMElement;
  Collection: IDMCollection;
  aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  ClassCollection:=ClassCollectionU as IDMCollection;
  ParentElement:=ParentElementU as IDMElement;
  Collection:=CollectionU as IDMCollection;

  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(ClassCollection, leoAdd, rsAddElement);

  OldState:=aDataModel.State;
  aDataModel.State:=aDataModel.State or dmfCommiting or dmfChanging;
  try

  aElement:=(ClassCollection as IDMCollection2).CreateElement(False);
  aElementU:=aElement as IUnknown;
  aElement.Name:=aName;

  Operation:=TCreateElementOperation.Create0(aElement);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  if SetParentFlag then begin
    if aLinkType=ltOneToMany then
      Operation:=TSetParentOperation.Create(aElement, ParentElement)
    else
      Operation:=TAddParentOperation.Create(aElement, ParentElement);
    FCurrentTransaction.AddOperation(Operation);
    Operation.Commit(Self);
  end;

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

function TCustomDMDocument.Get_State: Integer;
var
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  Result:=aDataModel.State
end;

procedure TCustomDMDocument.Set_State(Value: Integer);
var
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  aDataModel.State:=Value;
end;

function TCustomDMDocument.Get_Server: IDataModelServer;
begin
  Result:=IDataModelServer(FServer)
end;

procedure TCustomDMDocument.Set_Server(const Value: IDataModelServer);
begin
  FServer:=pointer(Value)
end;

procedure TCustomDMDocument.ChangeParent(
  const CollectionU: IUnknown;
  const aParentU, aElementU: IUnknown);
var
  Operation:TDMOperation;
  OldState:integer;
  Collection: IDMCollection;
  aParent, aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  Collection:=CollectionU as IDMCollection;
  aParent:=aParentU as  IDMElement;
  aElement:=aElementU as IDMElement;

  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(Collection, leoChangeParent, rsChangeParent);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TSetParentOperation.Create(aElement, aParent);
  Operation.Commit(Self);

  FCurrentTransaction.AddOperation(Operation);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

procedure TCustomDMDocument.ClearElement(
        const aElementU: IUnknown);
var
  Operation:TDMOperation;
  Collection:IDMCollection;
  Collection2:IDMCollection2;
  aChild:IDMElement;
  j, m:integer;

  aCollectionName: WideString;
  aRefSource: IDMCollection;
  aClassCollections: IDMClassCollections;
  aOperations: Integer;
  aLinkType, OldState, OldState1: Integer;
  aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  aElement:=aElementU as IDMElement;

  OldState:=aDataModel.State;
  try

  aDataModel.State:=OldState and not dmfCommiting; //что бы все операции записались в транзакцию
  aElement.ClearOp;
  aDataModel.State:=OldState;

  OldState1:=aDataModel.State;
  aDataModel.State:=aDataModel.State or dmfChanging;
  try

  Operation:=TSetParentOperation.Create(aElement, nil);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  Operation:=TSetRefOperation.Create(aElement, nil);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);
  finally
    aDataModel.State:=OldState1;
  end;

  if aElement.Parents<>nil then begin
    j:=0;
    while j<aElement.Parents.Count do begin
      Operation:=TRemoveParentOperation.Create(aElement, aElement.Parents.Item[j]);
      FCurrentTransaction.AddOperation(Operation);
      Operation.Commit(Self);
    end;
  end;

  if aElement.OwnerCollection<>nil then
    for j:=0 to aElement.FieldCount-1 do
      if aElement.Field[j].ValueType=fvtElement then begin
        Operation:=TChangeFieldValueOperation.Create(aElement,
                  aElement.Field[j].Code, NilUnk);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);
      end;

  j:=0;
  while j<aElement.CollectionCount do begin
    Collection:=aElement.Collection[j];
    aElement.GetCollectionProperties(j, aCollectionName,
      aRefSource, aClassCollections, aOperations, aLinkType);
    m:=0;
    while m<Collection.Count do begin
      aChild:=Collection.Item[m];
      if aLinkType=ltOneToMany then
        DeleteElement(aElement, Collection, aLinkType, aChild)
      else
      if aLinkType=ltManyToMany then
        RemoveElementParent(aElement, aChild)
      else
      if Collection.QueryInterface(IDMCollection2, Collection2)=0 then
        Collection2.Delete(m)
      else
        inc(m)
    end;
    inc(j);
  end;

  finally
    aDataModel.State:=OldState
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;

end;


procedure TCustomDMDocument.PasteToCollection(
  const ParentElementU: IUnknown;
  const SourceElementU:IUnknown;
  const DestCollectionU: IUnknown;
  aLinkType: Integer;
  out aElementU:IUnknown);
var
  Operation:TDMOperation;
  ClassCollection:IDMCollection;
  ClassCollection2:IDMCollection2;
  aName:WideString;
  DestOldState, SourceOldState:integer;
  SourceDataModel:IDataModel;
  SourceDocument:IDMDocument;
  ParentElement: IDMElement;
  SourceElement: IDMElement;
  DestCollection: IDMCollection;
  aElement:IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  ParentElement:=ParentElementU as IDMElement;
  SourceElement:=SourceElementU as IDMElement;
  DestCollection:=DestCollectionU as IDMCollection;

  ClassCollection:=(Get_DataModel as IDMElement).Collection[SourceElement.ClassID];

  SourceDataModel:=SourceElement.DataModel;
  SourceDocument:=SourceDataModel.Document as IDMDocument;

  DestOldState:=aDataModel.State;
  SourceOldState:=SourceDocument.State;

  aDataModel.State:=aDataModel.State or dmfCopying or dmfCommiting or dmfChanging;
  SourceDocument.State:=SourceDocument.State or dmfCopying;

  try

  ClassCollection2:=ClassCollection as IDMCollection2;
  aElement:=ClassCollection2.CreateElement(False);
  aElementU:=aElement as IUnknown;
  aName:=SourceElement.Name;
  aElement.Name:=aName;
  
  if ClassCollection2.GetItemByID(SourceElement.ID)=nil then
    aElement.ID:=SourceElement.ID;

  Operation:=TCreateElementOperation.Create0(aElement);
  FCurrentTransaction.AddOperation(Operation);

  Operation.Commit(Self);

  if aLinkType=ltOneToMany then
    Operation:=TSetParentOperation.Create(aElement, ParentElement)
  else
    Operation:=TAddParentOperation.Create(aElement, ParentElement);
  FCurrentTransaction.AddOperation(Operation);
  FCurrentTransaction.AddCopyOf(SourceElement, aElement);

  Operation.Commit(Self);

  PasteToElement(SourceElement, aElement, True, True);

  finally
    aDataModel.State:=DestOldState;
    SourceDocument.State:=SourceOldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

procedure TCustomDMDocument.PasteToElement(const SourceElementU, DestElementU:IUnknown;
                                           CopySpatialElementFlag, LowerLevelPaste:WordBool);
var
  SourceElement, DestElement:IDMElement;
  aRef, aFieldValue, NewFieldValue, aChild, NewChild:IDMElement;
  Operation:TDMOperation;
  ClassCollection:IDMCollection2;
  Collection:IDMCollection;
  aName:WideString;
  V:OleVariant;
  Unk:IUnknown;
  CopyLinkMode:integer;

  aCollectionName: WideString;
  aRefSource: IDMCollection;
  aClassCollections: IDMClassCollections;
  aOperations: Integer;
  aLinkType: Integer;

  function NewLink(OldLink:IDMElement; CopySpatialElementFlag:boolean):IDMElement;
  begin
    ClassCollection:=(Get_DataModel as IDMElement).Collection[OldLink.ClassID] as IDMCollection2;
    aName:=OldLink.Name;
    Result:=ClassCollection.CreateElement(False);
    Result.Name:=aName;
    if ClassCollection.GetItemByID(OldLink.ID)=nil then
      Result.ID:=OldLink.ID;

    Operation:=TCreateElementOperation.Create0(Result);
    FCurrentTransaction.AddOperation(Operation);
    FCurrentTransaction.AddCopyOf(OldLink, Result);
    Operation.Commit(Self);

    PasteToElement(OldLink, Result, CopySpatialElementFlag, True);
  end;

  function FindSimilarTo(OldLink:IDMElement):IDMElement;
  begin
    ClassCollection:=(Get_DataModel as IDMElement).Collection[OldLink.ClassID] as IDMCollection2;
    aName:=OldLink.Name;
    Result:=ClassCollection.GetItemByName(aName);
  end;

  procedure CopySpatialElement;
  var
    DefaultParent, aSpatialElement:IDMElement;
  begin
    if SourceElement.SpatialElement=nil then Exit;
    aSpatialElement:=FCurrentTransaction.GetCopyOf(SourceElement.SpatialElement);
    if aSpatialElement=nil then begin
      aSpatialElement:=NewLink(SourceElement.SpatialElement, False);

    DefaultParent:=FCurrentTransaction.GetCopyOf(SourceElement.SpatialElement.Parent);
    if DefaultParent=nil then
      DefaultParent:=NewLink(SourceElement.SpatialElement.Parent, False);

      Operation:=TSetParentOperation.Create(aSpatialElement, DefaultParent);
      FCurrentTransaction.AddOperation(Operation);
      Operation.Commit(Self);
    end else begin
      Operation:=TSetRefOperation.Create(aSpatialElement, DestElement);
      FCurrentTransaction.AddOperation(Operation);
      Operation.Commit(Self);
    end;
  end;

  procedure CopyFields(const aSource, aDest:IDMElement);
  var
    j:integer;
    Field:IDMField;
    DoCopyFlag:boolean;
  begin
    for j:=0 to aSource.FieldCount-1 do begin
      V:=aSource.FieldValue[j];
      Field:=aSource.Field[j];
      DoCopyFlag:=True;
      if Field.ValueType=fvtElement then begin
        if not VarIsNull(V) and
           not VarIsEmpty(V) then begin
          Unk:=V;
          aFieldValue:=Unk as IDMElement;
        end else
          aFieldValue:=nil;
        NewFieldValue:=nil;

        CopyLinkMode:=aSource.GetCopyLinkMode(aFieldValue);
        if CopyLinkMode=clmDefault then begin
          if aSource.DataModel=aDest.DataModel then
            CopyLinkMode:=clmOldLink
          else
          if aFieldValue=nil then
            CopyLinkMode:=clmNil
          else begin
            NewFieldValue:=FCurrentTransaction.GetCopyOf(aFieldValue);
            if NewFieldValue=nil then begin
              NewFieldValue:=FindSimilarTo(aFieldValue);
              if NewFieldValue<>nil then
                CopyLinkMode:=clmOldLink
              else
                CopyLinkMode:=clmNil
            end else
              CopyLinkMode:=clmNewLink
          end;
        end;

        case CopyLinkMode of
        clmNil: V:=NilUnk;
        clmOldLink:
          FCurrentTransaction.AddCopyOf(aFieldValue, aFieldValue); // V:=V
        clmNewLink:
          begin
            if NewFieldValue=nil then
              NewFieldValue:=FCurrentTransaction.GetCopyOf(aFieldValue);
            if NewFieldValue=nil then
              NewFieldValue:=NewLink(aFieldValue, False);
            Unk:=NewFieldValue as IUnknown;
            V:=Unk;
          end;
        clmExistingLink:
          begin
            if NewFieldValue=nil then
              NewFieldValue:=FCurrentTransaction.GetCopyOf(aFieldValue);
            if NewFieldValue=nil then begin
              DoCopyFlag:=False;
              V:=NilUnk;
            end else begin
              Unk:=NewFieldValue as IUnknown;
              V:=Unk;
            end;
          end;
        end;
      end;
      if DoCopyFlag then begin
        Operation:=TChangeFieldValueOperation.Create(aDest, Field.Code, V);
        FCurrentTransaction.AddOperation(Operation);
        Operation.Commit(Self);
      end;
    end;
  end;

  procedure CopyRef;
  var
    DefaultParent, theRef:IDMElement;
  begin
    if SourceElement.Ref=nil then
      aRef:=nil
    else begin
      CopyLinkMode:=SourceElement.GetCopyLinkMode(SourceElement.Ref);
      if CopyLinkMode=clmDefault then begin
        if SourceElement.DataModel=DestElement.DataModel then
          CopyLinkMode:=clmOldLink
        else
          CopyLinkMode:=clmNewLink
      end;

      case CopyLinkMode of
      clmNil:
        aRef:=nil;
      clmOldLink:
        begin
          aRef:=SourceElement.Ref;
          FCurrentTransaction.AddCopyOf(aRef, aRef);
        end;
      clmNewLink:
        begin
          theRef:=SourceElement.Ref;
          aRef:=FCurrentTransaction.GetCopyOf(theRef);
          if aRef=nil then begin
//            aRef:=NewLink(theRef, False);
            aRef:=NewLink(theRef, CopySpatialElementFlag);

            DefaultParent:=aRef.DataModel.GetDefaultParent(aRef.ClassID);
            Operation:=TSetParentOperation.Create(aRef, DefaultParent);
            FCurrentTransaction.AddOperation(Operation);
            Operation.Commit(Self);
          end;
        end;
      end;
    end;
    Operation:=TSetRefOperation.Create(DestElement, aRef);
    FCurrentTransaction.AddOperation(Operation);
    Operation.Commit(Self);
  end;

  procedure CopyCollections;
  var
    j, m:integer;
//    DestCollectionCount:integer;
    DefaultParent, DestChild:IDMElement;
    DestCollection:IDMCollection;
  begin
    for j:=0 to SourceElement.CollectionCount-1 do begin
      Collection:=SourceElement.Collection[j];
      SourceElement.GetCollectionProperties(j, aCollectionName, aRefSource,
                              aClassCollections, aOperations, aLinkType);

      if ((aOperations and leoDontCopy)<>0) then Continue;
      
      if ((aOperations and leoDontCopy)<>0) and
         ((aOperations and leoPasteProps)<>0) and
         LowerLevelPaste and
         not CopySpatialElementFlag then begin
        DestCollection:=DestElement.Collection[j];
        if (Collection.Count=DestCollection.Count) then begin
          for m:=0 to Collection.Count-1 do begin
            aChild:=Collection.Item[m];
            DestChild:=DestCollection.Item[m];
            PasteToElement(aChild, DestChild, False, True)
          end;
        end;
        Continue;
      end;
      if aLinkType=ltOneToMany then begin
        m:=0;
        DestCollection:=DestElement.Collection[j];
        while m<DestCollection.Count do begin
          aChild:=DestCollection.Item[m];
          if CopySpatialElementFlag or
             (aChild.SpatialElement=nil) then begin
            Operation:=TSetParentOperation.Create(aChild, nil);
            FCurrentTransaction.AddOperation(Operation);
            Operation.Commit(Self);

            ClearElement(aChild);
            Operation:=TDestroyElementOperation.Create(aChild);
            FCurrentTransaction.AddOperation(Operation);
            Operation.Commit(Self);
          end else
            inc(m)
        end;

//        DestCollectionCount:=DestCollection.Count;

        for m:=0 to Collection.Count-1 do begin
          aChild:=Collection.Item[m];
          if CopySpatialElementFlag or
             (aChild.SpatialElement=nil) then begin
            ClassCollection:=(Get_DataModel as IDMElement).Collection[aChild.ClassID] as IDMCollection2;
            NewChild:=NewLink(aChild, True);

            Operation:=TSetParentOperation.Create(NewChild, DestElement);
            FCurrentTransaction.AddOperation(Operation);
            Operation.Commit(Self);
          end
        end;

{
        if  not CopySpatialElementFlag and
          (Collection.Count=DestCollectionCount) then begin
          for m:=0 to Collection.Count-1 do begin
            aChild:=Collection.Item[m];
            DestChild:=DestCollection.Item[m];
            if aChild.Ref=DestChild.Ref then
              PasteToElement(aChild, DestChild, False, True)
          end;
        end;
}
      end else
      if aLinkType=ltManyToMany then begin

        m:=0;
        while m<DestElement.Collection[j].Count do begin
          aChild:=DestElement.Collection[j].Item[m];
          Operation:=TRemoveParentOperation.Create(aChild, DestElement);
          FCurrentTransaction.AddOperation(Operation);
          Operation.Commit(Self);
        end;

        for m:=0 to Collection.Count-1 do begin
          aChild:=Collection.Item[m];
          NewChild:=nil;
          CopyLinkMode:=SourceElement.GetCopyLinkMode(aChild);
          if CopyLinkMode=clmDefault then begin
            if SourceElement.DataModel=DestElement.DataModel then
              CopyLinkMode:=clmOldLink
            else begin
              NewChild:=FCurrentTransaction.GetCopyOf(aChild);
              if NewChild=nil then begin
                NewChild:=FindSimilarTo(aChild);
                if NewChild<>nil then
                  CopyLinkMode:=clmOldLink
                else
                  CopyLinkMode:=clmNil
              end else
                CopyLinkMode:=clmNewLink
            end;
          end;

          case CopyLinkMode of
          clmOldLink:
            begin
              Operation:=TAddParentOperation.Create(aChild, DestElement);
              FCurrentTransaction.AddOperation(Operation);
              FCurrentTransaction.AddCopyOf(aChild, aChild);
              Operation.Commit(Self);
            end;
          clmNewLink:
            begin
              if NewChild=nil then
                NewChild:=FCurrentTransaction.GetCopyOf(aChild);
              if NewChild=nil then
                NewChild:=NewLink(aChild, True)
              else
                CopyFields(aChild, NewChild); // возможно, нужно повторить
                                                     // копирование указателей на объекты

              if aChild.Parent<>nil then begin
                DefaultParent:=FCurrentTransaction.GetCopyOf(aChild.Parent);
                if DefaultParent=nil then
                  DefaultParent:=NewLink(aChild.Parent, False);

                Operation:=TSetParentOperation.Create(NewChild, DefaultParent);
                FCurrentTransaction.AddOperation(Operation);
                Operation.Commit(Self);
              end;

              Operation:=TAddParentOperation.Create(NewChild, DestElement);
              FCurrentTransaction.AddOperation(Operation);
              Operation.Commit(Self);
            end;
          end;
        end;
      end;
    end;
  end;

var
  OldState, SourceOldState: Integer;
  SourceDataModel:IDataModel;
  SourceDocument:IDMDocument;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  if SourceElementU=DestElementU then Exit;
  SourceElement:=SourceElementU as IDMElement;
  DestElement:=DestElementU as IDMElement;

  SourceDataModel:=SourceElement.DataModel;
  SourceDocument:=SourceDataModel.Document as IDMDocument;
  SourceOldState:=0;

  OldState:=aDataModel.State;
  if SourceDocument<>nil then
    SourceOldState:=SourceDocument.State;

  aDataModel.State:=aDataModel.State or dmfCommiting or dmfCopying;
  if SourceDocument<>nil then
    SourceDocument.State:=SourceDocument.State or dmfCopying;
  try

  CopyRef;
  if CopySpatialElementFlag then
    CopySpatialElement;
  CopyCollections;

  DestElement.Ref:=nil; // в некоторых случаях необходимо выполнить
  CopyRef;              // _AddBackRef после CopyCollections

  CopyFields(SourceElement, DestElement);

  Operation:=TUpdateElementOperation.Create0(DestElement);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  DestElement.AfterCopyFrom(SourceElement);

  finally
    if SourceDocument<>nil then
      SourceDocument.State:=SourceOldState;
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

procedure TCustomDMDocument.StartTransaction(const CollectionU: IUnknown;
          DMOperation: Integer; const TransactionName:WideString);
begin
  FCurrentTransaction:=CreateTransaction(CollectionU, DMOperation, TransactionName);
end;

procedure TCustomDMDocument.CommitTransaction(const ElementU: IUnknown;
                                const CollectionU: IUnknown;
                                DMOperation: Integer);
var
  OldState:integer;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting;
  try
    FCurrentTransaction.Commit(Self as IDMDocument);
  finally
    aDataModel.State:=OldState;
    FinishTransaction(ElementU, CollectionU, DMOperation);
  end;
end;

procedure TCustomDMDocument.AddElementParent(
  const ParentElementU, aElementU: IUnknown);
var
  Operation:TDMOperation;
  OldState:integer;
  ParentElement, aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  ParentElement:=ParentElementU as IDMElement;
  aElement:=aElementU as IDMElement;
  
  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(nil, leoSelect, rsAddElementParent);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TAddParentOperation.Create(aElement, ParentElement);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;

end;

procedure TCustomDMDocument.MoveElement(
       const CollectionU: IUnknown;
       const aElementU: IUnknown;
       NewIndex: Integer; MoveInOwnerCollection:WordBool);
var
  Operation:TDMOperation;
  OldState:integer;
  Collection: IDMCollection;
  aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  Collection:=CollectionU as IDMCollection;
  aElement:=aElementU as IDMElement;

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TMoveElementOperation.Create(aElement, Collection, NewIndex,
                                MoveInOwnerCollection);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

procedure TCustomDMDocument.RemoveElementParent(
  const ParentElementU, aElementU: IUnknown);
var
  Operation:TDMOperation;
  OldState:integer;
  ParentElement, aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  ParentElement:=ParentElementU as IDMElement;
  aElement:=aElementU as IDMElement;
  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(nil, leoSelect, rsRemoveElementParent);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TRemoveParentOperation.Create(aElement, ParentElement);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

procedure TCustomDMDocument.UpdateElement(const aElementU: IUnknown);
var
  Operation:TDMOperation;
  OldState:integer;
  aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  aElement:=aElementU as IDMElement;
  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(nil, leoAdd, rsUpdateElement);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TUpdateElementOperation.Create0(aElement);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

procedure TCustomDMDocument.FinishTransaction(const ElementsV: IUnknown;
  const CollectionV: IUnknown; DMOperation: Integer);
var
  nItemIndex:integer;
  Element:IDMElement;
  Collection:IDMCollection;
  aElementsV, aCollectionV: IUnknown;
begin
  aElementsV:=ElementsV;
  aCollectionV:=CollectionV;
  if (ElementsV<>nil) and
    (ElementsV.QueryInterface(IDMElement, Element)=0) then begin
    Element:=ElementsV as IDMElement;
    Collection:=CollectionV as IDMCollection;
    if Collection<>nil then begin
      nItemIndex:=Collection.IndexOf(Element);
      if nItemIndex=-1 then begin
        Collection:=Element.OwnerCollection;
        nItemIndex:=Collection.IndexOf(Element);
        if nItemIndex=-1 then begin
          Element:=Element.Ref;
          if Element<>nil then begin
            Collection:=Element.OwnerCollection;
            nItemIndex:=Collection.IndexOf(Element);
            if nItemIndex<>-1 then begin
              aElementsV:=Element as IUnknown;
              aCollectionV:=Collection as IUnknown;
            end;
          end;
        end;
      end;
    end else
      nItemIndex:=-1;
  end else
    nItemIndex:=-1;

  SetDocumentOperation(aElementsV, aCollectionV,
                          DMOperation, nItemIndex);
end;

function TCustomDMDocument.Get_Cursor: Integer;
begin
  Result:=0
end;

function TCustomDMDocument.Get_Hint: WideString;
begin
  Result:=''
end;

function TCustomDMDocument.Get_Analyzer: IUnknown;
begin
  Result:=FAnalyzer
end;

procedure TCustomDMDocument.Set_Analyzer(const Value: IUnknown);
begin
  FAnalyzer:=Value;
  (FAnalyzer as IDMAnalyzer).Data:=FDataModel as IDMElement
end;

function TCustomDMDocument.Get_TransactionCount: Integer;
begin
  Result:=FTransactions.Count
end;

function TCustomDMDocument.Get_TransactionName(Index: Integer): WideString;
begin
  Result:=TDMTransaction(FTransactions[Index]).Name
end;

procedure TCustomDMDocument.LoadTransactions(const FileName:WideString);
var
  Code:integer;
  aFile:TextFile;
  S0, S, TransactionName:string;
  DMTransaction:TDMTransaction;
  DMOperation:TDMOperation;
  Value:double;
  OldState, j, N:integer;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfLoading;
  try

  for j:=0 to FTransactions.Count-1 do
    Undo;

  while FTransactions.Count>0 do begin
    N:=FTransactions.Count-1;
    TDMTransaction(FTransactions[N]).Clear;
    TDMTransaction(FTransactions[N]).Free;
    FTransactions.Delete(N);
  end;

  finally
    aDataModel.State:=OldState;
  end;

  AssignFile(aFile, FileName);
  Reset(aFile);

  try
  if not EOF(aFile) then begin
    ReadLn(aFile, S);
    while not EOF(aFile) do begin
      TransactionName:=ExtractQuoteFromString(S);
      DMTransaction:=TDMTransaction.Create(nil, 0, TransactionName);
      FCurrentTransaction:=DMTransaction;
      FTransactions.Add(DMTransaction);
      try
      while not EOF(aFile) do begin
        ReadLn(aFile, S0);
        S:=S0;
        if S[1]='$' then Break;
        Value:=0;
        ExtractValueFromString(S, Value);
        Code:=round(Value);
        case Code of
        boCreateElement:
            DMOperation:=TCreateElementOperation.Create0(nil);
        boDestroyElement:
            DMOperation:=TDestroyElementOperation.Create(nil);
        boSetParent:
            DMOperation:=TSetParentOperation.Create(nil, nil);
        boSetRef:
            DMOperation:=TSetRefOperation.Create(nil, nil);
        boAddParent:
            DMOperation:=TAddParentOperation.Create(nil, nil);
        boRemoveParent:
            DMOperation:=TRemoveParentOperation.Create(nil, nil);
        boRename:
            DMOperation:=TRenameElementOperation.Create(nil, '');
        boChangeFieldValue:
            DMOperation:=TChangeFieldValueOperation.Create(nil, -1, null);
        boMoveElement:
            DMOperation:=TMoveElementOperation.Create(nil, nil, -1, True);
        boUpdateElement:
            DMOperation:=TUpdateElementOperation.Create0(nil);
        else
            DMOperation:=nil;
        end;
        DMTransaction.AddOperation(DMOperation);
        OldState:=aDataModel.State;
        aDataModel.State:=OldState or dmfCommiting or dmfLoadingTransactions;
        try
        DMOperation.ReadFromString(S, Self as IDMDocument);
        DMOperation.Commit(Self as IDMDocument);
        finally
          aDataModel.State:=OldState;
        end;
      end;
      except
        raise
      end;
    end;
  end;
  finally
    CloseFile(aFile);
  end;

  FCurrentTransactionIndex:=FTransactions.Count-1;
  FCurrentTransaction:=FTransactions[FCurrentTransactionIndex];

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfLoadingTransactions;
  try
  for j:=0 to FTransactions.Count-1 do
    Undo;
  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfModified or dmfCanRedo;
  Get_Server.OperationStepExecuted;
  Get_Server.RefreshDocument(rfAll);
end;

procedure TCustomDMDocument.SaveTransactions(const FileName:WideString);
var
  j, m:integer;
  aFile:TextFile;
  S:string;
  DMTransaction:TDMTransaction;
  DMOperation:TDMOperation;
begin
  AssignFile(aFile, FileName);
  Rewrite(aFile);
  try

  for j:=0 to FTransactions.Count-1 do begin
    DMTransaction:=TDMTransaction(FTransactions[j]);
    S:=Format('$%d "%s"', [j, DMTransaction.Name]);
    WriteLn(aFile, S);
    for m:=0 to DMTransaction.Operations.Count-1 do begin
      DMOperation:=TDMOperation(DMTransaction.Operations[m]);
      S:=Format('%d', [DMOperation.GetCode]);
      DMOperation.WriteToString(S, Self as IDMDocument);
      WriteLn(aFile, S);
    end;
  end;

  finally
    CloseFile(aFile);
  end;
end;

function TCustomDMDocument.Get_CurrentTransactionIndex: Integer;
begin
  Result:=FCurrentTransactionIndex;
end;

procedure TCustomDMDocument.DeleteElements(const Collection: IUnknown;
                                           ConfirmFlag:WordBool);
var
  j:integer;
  aElement:IDMElement;
  aCollection:IDMCollection;
  YesToAllFlag:boolean;
  Server:IDataModelServer;
begin
  Server:=Get_Server;
  aCollection:=Collection as IDMCollection;
  YesToAllFlag:=False;

  j:=0;
  while j<aCollection.Count do begin
    aElement:=aCollection.Item[j];

    if ConfirmFlag and
      (not YesToAllFlag) then begin
      Server.CallDialog(1, '', Format(rsDeleteConfirm, [aElement.Name]));
      if Server.EventData1=0 then
        Exit
      else
      if Server.EventData1=2 then
        YesToAllFlag:=True
      else
      if Server.EventData1=3 then begin
        inc(j);
        Continue
      end;
    end;
    aElement.Selected:=False;
    DeleteElement(nil, nil, ltOneToMany, aElement);
    inc(j);
  end;
end;

function TCustomDMDocument.Get_Password: WideString;
begin
  Result:=FPassword
end;

procedure TCustomDMDocument.Set_Password(const Value: WideString);
begin
  FPassword:=Value
end;

function TCustomDMDocument.CreateClone(const aElementU:IUnknown):IUnknown;
var
  aRef:IDMElement;
  aCollection:IDMCollection;
  aName:WideString;
  nItemIndex:integer;
  aElement:IDMElement;

begin
  aElement:=aElementU as IDMElement;
  aRef:=aElement.Ref;
  aCollection:=aElement.OwnerCollection;
  aName:=IncElementNumber(aElement.Name);
  if aRef<>nil then
    _AddElementRef( aCollection,
                     nil, aCollection,
                     aName, aRef, ltOneToMany, Result, False)
  else
    _AddElement( aCollection,
                     nil, aCollection,
                     aName, ltOneToMany, Result, False);

  if Result=nil then Exit;
  PasteToElement(aElement, Result, False, True);

  if aCollection<>nil then
    nItemIndex:=aCollection.IndexOf(Result as IDMElement)
  else
    nItemIndex:=-1;
  SetDocumentOperation(Result, aCollection,
                          leoAdd, nItemIndex);
end;


function TCustomDMDocument.Get_CurrentCollectionIndex: integer;
begin
  Result:=FCurrentCollectionIndex
end;

function TCustomDMDocument.Get_CurrentElementClassID: integer;
begin
  Result:=FCurrentElementClassID
end;

function TCustomDMDocument.Get_CurrentElementID: integer;
begin
  Result:=FCurrentElementID
end;

function TCustomDMDocument.Get_CurrentObjectExpanded: integer;
begin
  Result:=FCurrentObjectExpanded
end;

function TCustomDMDocument.Get_TopCollectionIndex: integer;
begin
  Result:=FTopCollectionIndex
end;

function TCustomDMDocument.Get_TopElementClassID: integer;
begin
  Result:=FTopElementClassID
end;

function TCustomDMDocument.Get_TopElementID: integer;
begin
  Result:=FTopElementID
end;

procedure TCustomDMDocument.Set_CurrentCollectionIndex(Value: integer);
begin
  FCurrentCollectionIndex:=Value
end;

procedure TCustomDMDocument.Set_CurrentElementClassID(Value: integer);
begin
  FCurrentElementClassID:=Value
end;

procedure TCustomDMDocument.Set_CurrentElementID(Value: integer);
begin
  FCurrentElementID:=Value
end;

procedure TCustomDMDocument.Set_CurrentObjectExpanded(Value: integer);
begin
  FCurrentObjectExpanded:=Value
end;

procedure TCustomDMDocument.Set_TopCollectionIndex(Value: integer);
begin
  FTopCollectionIndex:=Value
end;

procedure TCustomDMDocument.Set_TopElementClassID(Value: integer);
begin
  FTopElementClassID:=Value
end;

procedure TCustomDMDocument.Set_TopElementID(Value: integer);
begin
  FTopElementID:=Value
end;

procedure TCustomDMDocument.UndoSelection;
begin
  ClearSelection(nil);
  DoUndoSelection;
end;

procedure TCustomDMDocument.DoUndoSelection;
var
  OldState, OldSelectState:integer;
  j:integer;
  aElement, theElement:IDMElement;
  PrevSelectedElements2:IDMCollection2;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  OldState:=aDataModel.State;
  OldSelectState:=OldState and dmfSelecting;
  aDataModel.State:=OldState or dmfSelecting;
  FUndoSelectionFlag:=True;
  PrevSelectedElements2:=FPrevSelectedElements0 as IDMCollection2;
  try
  if FPrevSelectedElements0.Count>0 then
    for j:=0 to FPrevSelectedElements0.Count-1 do begin
      theElement:=FPrevSelectedElements0.Item[j];
      theElement.Selected:=True;
    end
  else
    theElement:=nil;

  PrevSelectedElements2.Clear;

  for j:=0 to FPrevSelectedElements1.Count-1 do begin
    aElement:=FPrevSelectedElements1.Item[j];
    PrevSelectedElements2.Add(aElement);
  end;

  (FPrevSelectedElements1 as IDMCollection2).Clear;

  finally
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
    FUndoSelectionFlag:=False;
  end;

  Get_Server.SelectionChanged(theElement);
end;

procedure TCustomDMDocument.ClearPrevSelection(ClearAll:WordBool);
begin
  if ClearAll and
     (FPrevSelectedElements0<>nil) then
    (FPrevSelectedElements0 as IDMCollection2).Clear;
end;

procedure TCustomDMDocument.UpdateCoords(const aElementU: IInterface);
var
  Operation:TDMOperation;
  OldState:integer;
  aElement: IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  if aElementU=nil then Exit;
  aElement:=aElementU as IDMElement;
  if (aElement.Ref<>nil) and
     (aElement.Ref.SpatialElement=aElement) then
    aElement:=aElement.Ref;
    
  if FCurrentTransaction=nil then
    FCurrentTransaction:=CreateTransaction(nil, leoAdd, rsUpdateElement);

  OldState:=aDataModel.State;
  aDataModel.State:=OldState or dmfCommiting or dmfChanging;
  try

  Operation:=TUpdateCoordsOperation.Create0(aElement);
  FCurrentTransaction.AddOperation(Operation);
  Operation.Commit(Self);

  finally
    aDataModel.State:=OldState;
  end;

  aDataModel.State:=aDataModel.State or dmfCanUndo;
  aDataModel.State:=aDataModel.State and not dmfCanRedo;
end;

function TCustomDMDocument.Get_SourceCollection: IUnknown;
begin
  Result:=FSourceCollection
end;

function TCustomDMDocument.Get_DestCollection: IUnknown;
begin
  Result:=FDestCollection
end;

procedure TCustomDMDocument.OnCreateRefElement(ClassID: integer;
  const RefElementU: IUnknown);
begin
end;

procedure TCustomDMDocument.SetDocumentOperation(const DMElement,
  DMCollection: IInterface; DMOperation, nItemIndex: Integer);
var
  aDataModel:IDataModel;
begin
  aDataModel:=Get_DataModel as IDataModel;
  if (aDataModel.State and dmfLongOperation)=0 then
    Get_Server.DocumentOperation(DMElement, DMCollection, DMOperation, nItemIndex)
  else begin
    FDocumentOperationFlag:=True;
    FDocumentOperationElement:=pointer(DMElement as IDMElement);
    FDocumentOperationCollection:=pointer(DMCollection as IDMCollection);
    FDocumentOperationOperation:=DMOperation;
    FDocumentOperationItemIndex:=nItemIndex;
  end;
end;

end.
