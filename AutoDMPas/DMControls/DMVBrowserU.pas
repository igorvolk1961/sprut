unit DMVBrowserU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_Windows, DM_Messages, Types,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, StdVcl, ImgList, Menus, Printers,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU, DMBrowser_TLB,
  VirtualTrees, ComCtrls, MyComCtrls;

const
  pkComment = $00000008;
const
  SuffixDivider='/';

type
  PNodeDataRecord=^TNodeDataRecord;
  TNodeDataRecord=record
    Data:pointer;
  end;

  TDMVBrowser = class(TDMPage, ITreeViewForm)
    ilNodes: TImageList;
    Splitter0: TSplitter;
    PopupMenu: TPopupMenu;
    miAddItem: TMenuItem;
    miDeleteItem: TMenuItem;
    miRenameItem: TMenuItem;
    miSelectItems: TMenuItem;
    miChangeRef: TMenuItem;
    miExecute: TMenuItem;
    miCustomOperation1: TMenuItem;
    miCustomOperation2: TMenuItem;
    N1: TMenuItem;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    N11: TMenuItem;
    miSwitchSelection: TMenuItem;
    miSelectAll: TMenuItem;
    miUnselect: TMenuItem;
    N16: TMenuItem;
    miUndo: TMenuItem;
    miRedo: TMenuItem;
    miGoToLastElement: TMenuItem;
    N18: TMenuItem;
    miOptions: TMenuItem;
    miMoveDown: TMenuItem;
    miMoveUp: TMenuItem;
    miChangeParent: TMenuItem;
    TabControl1: TTabControl;
    PanelDetails: TPanel;
    pControl: TPanel;
    memComment: TMemo;
    pTable: TPanel;
    Header: THeaderControl;
    sgDetails: TStringGrid;
    cbCategories: TComboBox;
    cbParameter: TComboBox;
    ReplaceDialog1: TReplaceDialog;
    PopupMenu1: TPopupMenu;
    miSelectFieldElement: TMenuItem;

    procedure miPopupMenuClick(Sender: TObject);

    procedure tvDataModelFocusChanged(Sender: TBaseVirtualTree;
                Node: PVirtualNode; Column: TColumnIndex);
    procedure tvDataModelGetNodeDataSize(Sender: TBaseVirtualTree;
              var NodeDataSize: Integer);
    procedure tvDataModelInitNode(Sender: TBaseVirtualTree;
             ParentNode, Node: PVirtualNode;
             var InitialStates: TVirtualNodeInitStates);
    procedure tvDataModelFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvDataModelInitChildren(Sender: TBaseVirtualTree;
              Node: PVirtualNode; var ChildCount: Cardinal);
    procedure tvDataModelPaintText(Sender: TBaseVirtualTree;
       const TargetCanvas: TCanvas; Node: PVirtualNode;
             Column: TColumnIndex;  TextType: TVSTTextType);
    procedure tvDataModelGetText(Sender: TBaseVirtualTree;
             Node: PVirtualNode; Column: TColumnIndex;
             TextType: TVSTTextType; var CellText: WideString);
    procedure tvDataModelEdited(Sender: TBaseVirtualTree;
              Node: PVirtualNode; Column: TColumnIndex);
    procedure tvDataModelNewText(Sender: TBaseVirtualTree;
              Node: PVirtualNode; Column: TColumnIndex; NewText:WideString);
    procedure tvDataModelGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure tvDataModelCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvDataModelDragOver(Sender: TBaseVirtualTree; Source: TObject;
          Shift: TShiftState; State: TDragState;
          Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure tvDataModelDragDrop(Sender: TBaseVirtualTree; Source: TObject;
           DataObject: IDataObject;  Formats: TFormatArray;
           Shift: TShiftState;
           Pt: TPoint; var Effect: Integer; Mode: TDropMode);

    procedure tvDataModelStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure tvDataModelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tvDataModelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvDataModelEnter(Sender: TObject);
    procedure tvDataModelMouseMove(Sender: TObject; Shift: TShiftState;
           X, Y: Integer);
    procedure tvDataModelDblClick(Sender: TObject);

    procedure cbCategoriesChange(Sender: TObject);
    procedure cbCategoriesExit(Sender: TObject);
    procedure cbParameterChange(Sender: TObject);
    procedure ParameterKeyPress(Sender: TObject; var Key: Char);
    procedure cbParameterExit;

    procedure sgDetailsDblClick(Sender: TObject);
    procedure sgDetailsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgDetailsEnter(Sender: TObject);
    procedure sgDetailsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgDetailsExit(Sender: TObject);
    procedure sgDetailsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgDetailsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);

    procedure HeaderResize(Sender: TObject);
    procedure HeaderSectionClick(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure HeaderSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);

    procedure memCommentChange(Sender: TObject);
    procedure miSwitchSelectionClick(Sender: TObject);
    procedure miUnselectClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure memCommentEnter(Sender: TObject);
    procedure cbParameterEnter(Sender: TObject);
    procedure cbCategoriesEnter(Sender: TObject);
    procedure sgDetailsTopLeftChanged(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure HeaderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TabControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    procedure miSelectFieldElementClick(Sender: TObject);
    procedure sgDetailsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private

//    FEvents: IDMBrowserXEvents;

    FOldFieldValue:string;

    FEditingParameterFlag:boolean;
    FHideEmptyCollectionsFlag:boolean;
    FClearTreeFlag:boolean;
    FChangingTreeNodeFlag:boolean;
    FExpandingGenerationsFlag:boolean;
    FSetDetailsFlag:boolean;
    FSetCurrentElementFlag:boolean;
    FRefreshingFlag:boolean;
    FSizeSetted:boolean;

    FCurrentObject:IUnknown;
    FTopObject:IUnknown;
    FCurrentObjectExpanded:integer;

    FCurrentElement:IDMElement;
    FCurrentParentElement:IDMElement;
    FLastElement:IDMElement;
    FCurrentCollection:IDMCollection;
    FCurrentRefSource:IDMCollection;
    FCurrentClassCollections:IDMClassCollections;
    FCurrentOperations:integer;
    FCurrentLinkType:integer;
    FCurrentFieldIndex:integer;
    FCurrentParamKind:integer;
    FIsControlForm:boolean;
    FSelectedCollectionNode:PVirtualNode;
    FNodeList:TList;
    FMemoFieldIndex:integer;
    FCurrentClassID:integer;

    FDetailMode:integer;
    FEditing:boolean;
    FOldLayoutName:array [0..255] of char;
    FDraggingElement:IDMElement;
    FShiftState:TShiftState;
    FSelectionRangeStart:integer;

//    procedure ActivateEvent(Sender: TObject);


    procedure SwitchSelection(aNode: PVirtualNode; ClearSelectionFlag:boolean);
    procedure UpdateTree(nItemIndex: integer; CollectionNode: PVirtualNode; ClearFirst:boolean);

    procedure AddElement;
    procedure RenameElement;
    procedure ChangeRef;
    procedure ChangeParent;
    procedure ClearTree;
    procedure CustomOperation(Index:Integer);

    procedure DeleteElement;
    function ExpandGenerations(const theElement:IDMElement; var Found:boolean;
                               DoSelect:boolean):PVirtualNode;
    procedure ShiftElement(Shift:integer);

    function GetDetailCellHeight(S0: string; DrawFlag: boolean; WW, HH,
      LL: integer; R:TRect): integer;
    procedure GoToLastElement;
    procedure InitTree;
    procedure SelectAll;
    procedure SelectElementFromList;
    procedure SetColWidths(W0: double);
    procedure SetDetailMode(const Value: TDetailMode);
    procedure SetDetails;
    procedure SetDetailsElements(Elements: IDMCollection);
    procedure SetDetailsList;
    procedure SetHideEmptyCollectionsFlag(const Value: boolean);
    procedure SetMenuItems;
    procedure SetOptions;
    procedure SetCurrentOptions;
    procedure SetDetailsListKind;
    procedure InitNodeClickMacros(aNode:PVirtualNode; HT:integer);
    procedure GetMacrosNodeID(aNode: PVirtualNode; HT: integer; var ID, YY: integer);
    procedure SetDetailPanels;
    procedure SetDetailsCell(ACol, ARow: Integer);
    procedure ChangeDetailsFont(const Element: IDMElement;
                                const Field: IDMField;
                                ACol, ARow:integer);
    procedure SetFieldValue(const V:Variant; const aElement:IDMElement);

    function GetNodeData(Node:PVirtualNode):pointer;
  protected
    tvDataModel:TVirtualStringTree;

    function CheckCurrentElementSeletion: boolean;
    procedure DocumentOperation(ElementsV,
      CollectionV: OleVariant; DMOperation, nItemIndex: Integer); override;
    procedure RefreshElement(DMElement:OleVariant); override; safecall;
    procedure OpenDocument; override;
    procedure CloseDocument; override;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;
    procedure StopAnalysis(Mode:integer); override; safecall;

    procedure UnselectAll;
    function PasteFromBuffer:boolean; override;

    property HideEmptyCollectionsFlag:boolean
            read FHideEmptyCollectionsFlag write SetHideEmptyCollectionsFlag;

    function Get_DetailMode: Integer; virtual; safecall;
    procedure Set_DetailMode(Value: Integer); virtual;safecall;
    procedure Set_Mode(Value: Integer); override; safecall;

    function DoMacrosStep(RecordKind, ControlID: Integer; EventID: Integer;
                  X: Integer; Y: Integer; const S:WideString):WordBool; override; safecall;

//методы IElementlistForm

    function Get_CurrentElement: IUnknown; virtual; safecall;
    procedure Set_CurrentElement(const Value: IUnknown); virtual; safecall;
    procedure UpdateCurrentElement; override; safecall;

    procedure GetTopObject(out CurrentObject: IUnknown; out CurrentObjectExpanded:WordBool;
                           out TopObject: IUnknown); safecall;
    procedure SetTopObject(const CurrentObject: IUnknown; CurrentObjectExpanded:WordBool;
                           const TopObject: IUnknown); safecall;
    procedure RestoreState; override;safecall;
    procedure SaveState; override; safecall;

  public
    constructor Create(aOwner:TComponent); override;
    procedure Initialize; override;
    destructor Destroy; override;
    function DoAction(ActionCode: integer):WordBool; override; safecall;
  end;

var
  DMVBrowser: TDMVBrowser;
const
  InfinitValue=1000000000;

implementation
uses
  DMBrowserConstU,
  DualListDlg1, ChangeRefFrm, DMBrowserOptions,
  SelectFromTreeFrm;

{$R *.dfm}

procedure TDMVBrowser.Initialize;
begin
  inherited Initialize;

  cbParameter.Ctl3D:=False;
  cbParameter.Height:=15;
  FCurrentFieldIndex:=-1;
  FSelectionRangeStart:=-1;

  FIsControlForm:=True;


  SetColWidths(0.6);
  miMoveUp.ShortCut:=ShortCut(VK_UP,[ssCtrl]);
  miMoveDown.ShortCut:=ShortCut(VK_DOWN,[ssCtrl]);

  FCurrentElement:=nil;

  FNodeList:=TList.Create;

  FCurrentParamKind:=0;
  FCurrentClassId:=-1;

end;

procedure ParseText(const S:string; Delimeter:char; const aList:TStrings);
var
  S0, S1:string;
  m:integer;
begin
  aList.Clear;
  S0:=S;
  m:=Pos(Delimeter, S0);
  while m<>0 do begin
    S1:=Copy(S0, 1, m-1);
    aList.Add(S1);
    Delete(S0, 1, m);
    m:=Pos(Delimeter, S0);
  end;
  aList.Add(S0);
end;


function ExtractString(const S:string; Index:integer):string;
var
  Delimeter:char;
  aList:TStringList;
  S1:string;
begin
  Result:='';
  if S='' then Exit;
  Delimeter:=S[1];
  S1:=S;
  Delete(S1, 1, 1);
  aList:=TStringList.Create;
  ParseText(S1, Delimeter, aList);
  if Index<aList.Count then
    Result:=aList[Index];
  aList.Free;
end;

procedure TDMVBrowser.SetColWidths(W0:double);
var
  j:integer;
  W:integer;
begin
  if Header.Sections.Count>1 then begin
    Header.Sections[0].Width:=Round(Header.Width * W0);
    W:=Round(Header.Width * (1-W0)/(Header.Sections.Count-1));
    if W<30 then
      W:=30;
    for j:=1 to Header.Sections.Count-1 do
      Header.Sections[j].Width:=W;
  end else
    Header.Sections[0].Width:=Header.Width;

  if sgDetails.ColCount=Header.Sections.Count then
    for j:=0 to Header.Sections.Count-1 do begin
      sgDetails.ColWidths[j]:=Header.Sections[j].Width-1;
    end;
  if sgDetails.ColCount>1 then
    sgDetails.FixedCols:=1;
end;

procedure TDMVBrowser.tvDataModelGetImageIndex(Sender: TBaseVirtualTree;
    Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
    var Ghosted: Boolean; var ImageIndex: Integer);
var
  aElement:IDMElement;
  Data:pointer;
begin
  Data:=GetNodeData(Node);
  if Data=nil then
    ImageIndex := -1
  else
  if Succeeded(IUnknown(Data).QueryInterface(IDMElement, aElement)) then begin
    if (aElement.Ref<>nil) and
       (aElement.DataModel=aElement.Ref.DataModel) and
       (aElement<>aElement.Ref.SpatialElement) then
      aElement:=aElement.Ref;
    if aElement.Selected then
       ImageIndex := 1
    else
      ImageIndex := 0
  end else
    ImageIndex := -1;
end;

procedure TDMVBrowser.tvDataModelFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
var
  j:integer;
  Unk:IUnknown;
  aElement:IDMElement;
  ParentElementNode, ParentNode:PVirtualNode;
  aDocument:IDMDocument;
  CanPaste:WordBool;
  OwnerCollection:IDMCollection;
  Data, ParentNodeData, ParentElementNodeData:pointer;
  MiscOptions:TVTMiscOptions;
begin
  if Get_ChangingParent then Exit;
  if FExpandingGenerationsFlag then Exit;
  if FClearTreeFlag then Exit;
  if FChangingTreeNodeFlag then Exit;

  if (Sender<>nil) and
      Visible then
    Get_DMEditorX.ActiveForm:=Self as IDMForm;

  FEditing:=False;
  MiscOptions:=tvDataModel.TreeOptions.MiscOptions;
  Exclude(MiscOptions, toEditable);
  tvDataModel.TreeOptions.MiscOptions:=MiscOptions;

  FChangingTreeNodeFlag:=True;
  try
  sgDetails.RowCount:=0;  //здесь вызывается sgDetailsSelectCell->sgDetailsKeyPress
  pControl.Height:=0;
  if not FSetCurrentElementFlag and
     cbParameter.Visible then
    cbParameterExit;
  FMemoFieldIndex:=-1;
  FCurrentFieldIndex:=-1;

  for j:=0 to sgDetails.ColCount-1 do
    sgDetails.Cols[j].Clear;

  Data:=GetNodeData(Node);

  Unk:=nil;
  Set_CurrentElement(Unk);
  Unk:=IUnknown(Data);
  if Unk=nil then Exit;
  ParentElementNode:=tvDataModel.NodeParent[Node];
  if Succeeded(Unk.QueryInterface(IDMCollection, FCurrentCollection))  then begin
    SetDetailMode(dmdTable);
    SetColWidths(0.3);
    Unk.QueryInterface(IDMElement, FCurrentElement);  // возможно одновременное использование
                                                      // обоих интерфейсов
  end else begin
    Unk.QueryInterface(IDMElement, aElement);
    OwnerCollection:=aElement.OwnerCollection;
    if (ParentElementNode<>nil) and
       (OwnerCollection<>nil) and
       (OwnerCollection.IndexOf(aElement)=-1) then begin
      FChangingTreeNodeFlag:=False;
      Unk._Release;
      Sender.DeleteNode(Node);
      Exit;
    end;
    FDetailMode:=dmdList;
    Unk:=aElement as IUnknown;
    Set_CurrentElement(Unk);
    ParentNode:=tvDataModel.NodeParent[Node];
    if ParentNode<>nil then
      ParentElementNode:=tvDataModel.NodeParent[ParentNode]
    else
      ParentElementNode:=nil;
    if ParentNode<>nil then begin
      ParentNodeData:=GetNodeData(ParentNode);
      Unk:=IUnknown(ParentNodeData);
      if Unk<>nil then
        Unk.QueryInterface(IDMCollection, FCurrentCollection);
    end else
      FCurrentCollection:=nil;
    SetDetails;
  end;

  cbParameter.Visible:=False;
  sgDetails.Visible:=sgDetails.Cells[0,0]<>'';

  if ParentElementNode<>nil then begin
    ParentElementNodeData:=GetNodeData(ParentElementNode);
    IUnknown(ParentElementNodeData).QueryInterface(IDMElement, FCurrentParentElement)
  end else begin
     aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
     FCurrentParentElement:=GetDataModel as IDMElement;
  end;

  if FCurrentParentElement<>nil then begin
    SetCurrentOptions;

    (Get_DataModelServer as IDMCopyBuffer).Paste(FCurrentParentElement,
      FCurrentCollection, FCurrentLinkType, False, CanPaste);
  end;

  SetMenuItems;

  (Get_DataModelServer as IDataModelServer).ChangeCurrentObject(FCurrentElement,
                                                              Self as IUnknown);

  finally
    FChangingTreeNodeFlag:=False;
  end;

end;

procedure TDMVBrowser.SetCurrentOptions;
var
  aCollection:IDMCollection;
  aCollectionU:IUnknown;
  RootObject:IUnknown;
  j, CollectionCount:integer;
  RootObjectName, CollectionName:WideString;
  aDataModel:IDataModel;
  Unk:IUnknown;
  Data:pointer;
  FocusedNodeParent:PVirtualNode;
begin
  try
  FCurrentClassCollections:=nil;
  FCurrentRefSource:=nil;
  if FCurrentParentElement.QueryInterface(IDMCollection, Unk)=0 then Exit;

  CollectionCount:=FCurrentParentElement.CollectionCount;
  j:=0;
  while j<CollectionCount do begin
    aCollectionU:=FCurrentParentElement.Get_Collection(j);
    aCollection:=aCollectionU as IDMCollection;
    if (aCollection=FCurrentCollection) and
       (aCollection<>nil) then
      Break
    else
      inc(j);
  end;
  if j<CollectionCount then
   FCurrentParentElement.GetCollectionProperties(j, CollectionName,
      FCurrentRefSource,
      FCurrentClassCollections,
      FCurrentOperations, FCurrentLinkType)
  else begin
    Data:=GetNodeData(tvDataModel.FocusedNode);
    if Data=nil then Exit;
    aDataModel:=GetDataModel;
    if (IUnknown(Data).QueryInterface(IDMCollection, FCurrentCollection)=0) then
      aDataModel.GetRootObject(Get_Mode, tvDataModel.FocusedNode.Index,
         RootObject, RootObjectName, FCurrentOperations, FCurrentLinkType)
    else begin
      FocusedNodeParent:=tvDataModel.NodeParent[tvDataModel.FocusedNode];
      if FocusedNodeParent<>nil then
        aDataModel.GetRootObject(Get_Mode, FocusedNodeParent.Index,
           RootObject, RootObjectName, FCurrentOperations, FCurrentLinkType)
      else
        aDataModel.GetRootObject(Get_Mode, tvDataModel.FocusedNode.Index,
           RootObject, RootObjectName, FCurrentOperations, FCurrentLinkType);
    end;
    RootObject.QueryInterface(IDMCollection, FCurrentCollection);
  end;
  except
    raise
  end;
end;

function TDMVBrowser.DoAction(ActionCode:integer):WordBool;
var
  aDocument:IDMDocument;
begin
  Result:=False;
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  case ActionCode of
  dmbaAddElement,
  dmbaDeleteElement,
  dmbaDelete,
  dmbaRenameElement,
  dmbaSelectElementFromList,
  dmbaChangeRef,
  dmbaExecute,
  dmbaCustomOperation1,
  dmbaCustomOperation2,
  dmbaChangeParent,
  dmbaSwitchSelection,
  dmbaSelectAll,
  dmbaUnselectAll,
  dmbaGoToLastElement,
  dmbaSetOptions,
  dmbaShiftElementUp,
  dmbaShiftElementDown:
    begin
      Result:=True;
      case ActionCode of
      dmbaAddElement      : AddElement;
      dmbaDeleteElement,
      dmbaDelete          : // if not tvDataModel.FocusedNode.Focused then
                              DeleteElement;
      dmbaRenameElement   : RenameElement;
      dmbaSelectElementFromList: SelectElementFromList;
      dmbaChangeRef       : ChangeRef;
      dmbaExecute         : CustomOperation(0);
      dmbaCustomOperation1: CustomOperation(1);
      dmbaCustomOperation2: CustomOperation(2);
      dmbaChangeParent    : ChangeParent;
      dmbaSwitchSelection : SwitchSelection(tvDataModel.FocusedNode, False);
      dmbaSelectAll       : SelectAll;
      dmbaUnselectAll     : UnselectAll;
      dmbaGoToLastElement : GoToLastElement;
      dmbaSetOptions      : SetOptions;
      dmbaShiftElementUp  : ShiftElement(-1);
      dmbaShiftElementDown: ShiftElement(+1);
      end;
    end;
  dmbaPrint:   Print;
  else
    Result:=inherited DoAction(ActionCode)
  end;
end;

procedure TDMVBrowser.SetMenuItems;
var
  S:string;
  MoveItemEnabled, CategoryFlag:boolean;
  List:IDMCollection;
  aElement:IDMElement;
  aElement2:IDMElement2;
  Unk:IUnknown;
  Collection2:IDMCollection2;
  Collection3:IDMCollection3;
  Data:pointer;
begin
  if PopupMenu=nil then Exit;
  if FCurrentCollection=nil then Exit;
  if FCurrentCollection.ClassID=-1 then
    S:=''
  else
  if FCurrentCollection.QueryInterface(IDMCollection3, Collection3)=0 then
    S:='"'+Collection3.ClassAlias2[akRodit]+'"'
  else
    S:='"'+FCurrentCollection.ClassAlias[akRodit]+'"';

  Data:=GetNodeData(tvDataModel.FocusedNode);
  Unk:=IUnknown(Data);
  if Unk=nil then Exit;
  CategoryFlag:=(Unk.QueryInterface(IDMCollection, List)=0);
  if not CategoryFlag then
    aElement:=Unk as IDMElement
  else
    aElement:=nil;

  with PopupMenu.Items[0] do begin
    Visible:=(leoAdd and FCurrentOperations)<>0;
    Enabled:=Visible;
    if Visible then begin
      Caption:=Format(rsAddElementItem, [S]);
      ShortCut:=TextToShortCut('Ins')
    end else begin
      ShortCut:=TextToShortCut('')
    end;
  end;

  with PopupMenu.Items[1] do begin
    Visible:=((leoDelete and FCurrentOperations)<>0) and (not CategoryFlag);
    Enabled:=Visible;
    if Visible then begin
      Caption:=Format(rsDeleteItem, [S]);
      ShortCut:=TextToShortCut('Del')
    end else begin
      ShortCut:=TextToShortCut('')
    end;
  end;

  with PopupMenu.Items[2] do begin
    Visible:=((leoRename and FCurrentOperations)<>0);// and (not CategoryFlag);
    Enabled:=Visible;
    if Visible then begin
      Caption:=Format(rsRenameItem, [S]);
      ShortCut:=TextToShortCut('Ctrl+N')
    end else begin
      ShortCut:=TextToShortCut('')
    end;
  end;

  with PopupMenu.Items[3] do begin
    Visible:=((leoSelect and FCurrentOperations)<>0) or
             ((leoSelectRef and FCurrentOperations)<>0);
    Enabled:=Visible;
    if Visible then begin
      Caption:=Format(rsSelectItem, [S]);
      ShortCut:=TextToShortCut('Alt+Ins')
    end else begin
      ShortCut:=TextToShortCut('')
    end;
  end;

  with PopupMenu.Items[4] do begin
    Visible:=((leoChangeRef and FCurrentOperations)<>0) and (not CategoryFlag);
    Enabled:=Visible;
    if Visible then begin
      ShortCut:=TextToShortCut('Ctrl+T');
      Caption:=Format(rsChangeRef, [S]);
    end else begin
      ShortCut:=TextToShortCut('')
    end;
  end;

  with PopupMenu.Items[5] do begin
    Visible:=((leoExecute and FCurrentOperations)<>0) and (not CategoryFlag) and
            (aElement.QueryInterface(IDMElement2, aElement2)=0);
    Enabled:=Visible;
    if Visible then
      Caption:=aElement2.GetOperationName(0);
  end;

  with PopupMenu.Items[6] do begin
    Visible:=((leoOperation1 and FCurrentOperations)<>0) and (not CategoryFlag) and
            (aElement.QueryInterface(IDMElement2, aElement2)=0);
    Enabled:=Visible;
    if Visible then
      Caption:=aElement2.GetOperationName(1);
  end;

  with PopupMenu.Items[7] do begin
    Visible:=((leoOperation2 and FCurrentOperations)<>0) and (not CategoryFlag) and
            (aElement.QueryInterface(IDMElement2, aElement2)=0);
    Enabled:=Visible;
    if Visible then
      Caption:=aElement2.GetOperationName(2);
  end;

  with PopupMenu.Items[8] do begin
    Visible:=((leoChangeParent and FCurrentOperations)<>0) and (not CategoryFlag);
    Enabled:=Visible;
    if Visible then
      Caption:=Format(rsChangeParent, [S]);
  end;

  FCurrentCollection.QueryInterface(IDMCollection2, Collection2);
  MoveItemEnabled:=not CategoryFlag;
  miMoveUp.Enabled:=MoveItemEnabled;
  miMoveDown.Enabled:=MoveItemEnabled;

  if aElement=nil then Exit;

  if aElement.Selected then
    PopupMenu.Items[14].Caption:=Format(rsUnSelect, [S])
  else
    PopupMenu.Items[14].Caption:=Format(rsSelect, [S]);
end;

procedure TDMVBrowser.UpdateTree(nItemIndex:integer; CollectionNode:PVirtualNode; ClearFirst:boolean);
var
  aNode:PVirtualNode;
  i:integer;
begin
  tvDataModel.ReinitNode(CollectionNode, False);
  tvDataModel.InvalidateChildren(CollectionNode, True);
  if nItemIndex<-1 then Exit;
  if (nItemIndex<>-1) and
     (nItemIndex<tvDataModel.ChildCount[CollectionNode])then begin
    aNode:=tvDataModel.GetFirstChild(CollectionNode);
    for i:=0 to nItemIndex-1 do
      aNode:=tvDataModel.GetNextSibling(aNode);
    tvDataModel.FocusedNode:=aNode;
  end else
    tvDataModel.FocusedNode:=CollectionNode;
end;

procedure TDMVBrowser.SetHideEmptyCollectionsFlag(const Value: boolean);
begin
  FHideEmptyCollectionsFlag := Value;
end;

procedure TDMVBrowser.tvDataModelEdited(Sender: TBaseVirtualTree;
              Node: PVirtualNode; Column: TColumnIndex);
{
var
  aElement:IDMElement;
  OperationManager:IDMOperationManager;
  aDocument:IDMDocument;
  Data:pointer;
  MiscOptions:TVTMiscOptions;
  S:WideString;
}
begin
{
  Data:=GetNodeData(Node);
  aElement:=IUnknown(Data) as IDMElement;
  if aElement=nil then Exit;

  MiscOptions:=tvDataModel.TreeOptions.MiscOptions;
  Exclude(MiscOptions, toEditable);
  tvDataModel.TreeOptions.MiscOptions:=MiscOptions;

  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  OperationManager:=aDocument as IDMOperationManager;
  OperationManager.StartTransaction(FCurrentCollection, leoRename, rsRename);
  S:=tvDataModel.Text[Node,-1];
  OperationManager.RenameElement( aElement, S);
  OperationManager.FinishTransaction(aElement, FCurrentCollection, leoRename);

  if (aDataModel.State and dmfDemo)<>0 then begin
    DM_LoadKeyboardLayout(FOldLayoutName,
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;
}
end;

procedure TDMVBrowser.tvDataModelPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode;
       Column: TColumnIndex;  TextType: TVSTTextType);
var
  aElement:IDMElement;
  aList:IDMCollection;
  Data:pointer;
begin
  Data:=GetNodeData(Node);
  if Data=nil then Exit;
  if IUnknown(Data).QueryInterface(IDMCollection, aList)=0 then begin
    TargetCanvas.Font.Style:=TargetCanvas.Font.Style+[fsBold]
  end else if IUnknown(Data).QueryInterface(IDMElement, aElement)=0 then begin
    TargetCanvas.Font.Style:=TargetCanvas.Font.Style-[fsBold];
    if aElement.Presence>0 then
      TargetCanvas.Font.Style:=TargetCanvas.Font.Style+[fsItalic]
    else
      TargetCanvas.Font.Style:=TargetCanvas.Font.Style-[fsItalic]
  end;
end;

function TDMVBrowser.ExpandGenerations(const theElement:IDMElement;
               var Found:boolean; DoSelect:boolean):PVirtualNode;
var
  Node:PVirtualNode;
  j:integer;
  aCollection:IDMCollection;
  aCollection2:IDMCollection2;
  aElement, Element:IDMElement;
  aDataModel:IDataModel;
  Data:pointer;
begin
  Result:=nil;
  Found:=False;
  if FChangingTreeNodeFlag then Exit;
  Node:=tvDataModel.GetFirst;
  while Node<>nil do begin
    Data:=GetNodeData(Node);
    if IUnknown(Data)=theElement as IUnknown then
      Break
    else
      Node:=tvDataModel.GetNext(Node);
  end;
  if Node<>nil then begin
    tvDataModel.VisiblePath[Node]:=True;
    if (tvDataModel.FocusedNode<>Node) and DoSelect then
      tvDataModel.FocusedNode:=Node;
    Result:=Node;
    Found:=True;
    Exit;
  end;

  aDataModel:=GetDataModel;
  aDataModel.BuildGenerations(Get_Mode, theElement);
  if aDataModel.GenerationCount=0 then Exit;
  if (tvDataModel.FocusedNode<>nil) then begin
    Data:=GetNodeData(tvDataModel.FocusedNode);
    if Data=nil then Exit;
    if (IUnknown(Data).QueryInterface(IDMElement, aElement)=0) and
         (aElement=aDataModel.Generation[aDataModel.GenerationCount-1]) then begin
       Result:=tvDataModel.FocusedNode;
       Found:=True;
       Exit;
    end;
  end;
  Node:=tvDataModel.GetFirst;
  FExpandingGenerationsFlag:=True;
  tvDataModel.BeginUpdate;
  try
  tvDataModel.FullCollapse(nil);

  Element:=aDataModel.Generation[0];

  while Node<>nil do begin
    Data:=GetNodeData(Node);
    if Data=nil then
      Node:=tvDataModel.GetNextSibling(Node)
    else
    if IUnknown(Data).QueryInterface(IDMCollection, aCollection)=0 then begin
      if aCollection.IndexOf(Element)<>-1 then begin
        tvDataModel.ReinitNode(Node, False);
        tvDataModel.InvalidateChildren(Node, True);
        tvDataModel.Expanded[Node]:=True;
        Node:=tvDataModel.GetFirstChild(Node);
      end else
        Node:=tvDataModel.GetNextSibling(Node);
    end else begin
      aElement:=IUnknown(Data) as IDMElement;
      if aElement=Element then
        Break
      else
      if aElement.Ref=Element then
        Break
      else
        Node:=tvDataModel.GetNextSibling(Node);
    end;
  end;

  for j:=0 to aDataModel.GenerationCount-1 do begin
    Element:=aDataModel.Generation[j];
    while Node<>nil do begin
      Data:=GetNodeData(Node);
      aElement:=IUnknown(Data) as IDMElement;
      if aElement=Element then
        Break
      else
      if aElement.Ref=Element then
        Break;
      Node:=tvDataModel.GetNextSibling(Node);
    end;
    if Node=nil then Break;
    tvDataModel.InvalidateChildren(Node, True);
    if j<aDataModel.GenerationCount-1 then begin
      Element:=aDataModel.Generation[j+1];
      tvDataModel.Expanded[Node]:=True;
      Node:=tvDataModel.GetFirstChild(Node);
      while Node<>nil do begin
        Data:=GetNodeData(Node);
        aCollection:=IUnknown(Data) as IDMCollection;
        if aCollection.IndexOf(Element)<>-1 then
          Break
        else begin
          if aCollection.QueryInterface(IDMCollection2, aCollection2)=0 then begin
            if aCollection2.GetItemByRef(Element)<>nil then
              Break
          end;
        end;
        Node:=tvDataModel.GetNextSibling(Node);
      end;
      if Node=nil then Break;

      tvDataModel.InvalidateChildren(Node, True);
      tvDataModel.Expanded[Node]:=True;
      Node:=tvDataModel.GetFirstChild(Node);
    end;
  end;
  finally
    tvDataModel.EndUpdate;
    tvDataModel.Visible:=True;
    FExpandingGenerationsFlag:=False;
  end;

  Found:=True;

  if (Node<>nil) then begin
    if (tvDataModel.FocusedNode<>Node) and DoSelect then
      tvDataModel.FocusedNode:=Node
    else
      tvDataModelFocusChanged(tvDataModel, Node, -1);
    tvDataModel.VisiblePath[Node]:=True;
  end;

  Result:=Node;

end;

procedure TDMVBrowser.ClearTree;
begin
  FClearTreeFlag:=True;
  try
    try
      tvDataModel.Clear;
    except
      raise
    end;
  finally
    FClearTreeFlag:=False;
  end;
end;

procedure TDMVBrowser.SetDetailsList;
var
  j, m, FieldCount_, ParamKind: integer;
  Field:IDMField;
  ParamKindSet:integer;
  S:string;
begin
  try
  if FCurrentElement=nil then Exit;

  FieldCount_:=FCurrentElement.FieldCount_;
  FMemoFieldIndex:=-1;
  ParamKindSet:=0;
  for j:=0 to FieldCount_-1 do begin
    Field:=FCurrentElement.Field_[j];
    if Field.ValueType=fvtText then begin
      ParamKindSet:=ParamKindSet or pkComment;
    end else
    if FCurrentElement.FieldIsVisible(Field.Code) then begin
      ParamKind:=1;
      for m:=0 to 10 do begin
        if (Field.Level and ParamKind)<>0 then
          ParamKindSet:=ParamKindSet or ParamKind;
        ParamKind:=ParamKind*2;
      end;
    end;
  end;

  ParamKind:=1;
  for j:=0 to FCurrentElement.FieldCategoryCount-1 do begin
    if (ParamKindSet and ParamKind)<>0 then begin
      S:=FCurrentElement.FieldCategory[j];
      TabControl1.Tabs.AddObject(S, pointer(ParamKind));
    end;
    ParamKind:=ParamKind*2
  end;

  if FCurrentElement.ClassId=FCurrentClassId then begin
    j:=0;
    if TabControl1.Tabs.Count>0 then begin
      while j<TabControl1.Tabs.Count do begin
        ParamKind:=integer(pointer(TabControl1.Tabs.Objects[j]));
        if ParamKind=FCurrentParamKind then
          Break
        else
          inc(j)
      end;
      if j<TabControl1.Tabs.Count then
        TabControl1.TabIndex:=j
      else
        j:=0;
    end;
  end else begin
    j:=0;
    FCurrentClassID:=FCurrentElement.ClassID;
  end;
  TabControl1.TabIndex:=j;

  TabControl1Change(TabControl1);
//  FCurrentParamKind:=integer(pointer(TabControl1.Tabs.Objects[j]));
//  SetDetailsListKind;
  except
    raise
  end;  
end;

procedure TDMVBrowser.SetDetailsListKind;
var
  j, H0, H1, WW, HH, N, FieldCount_: integer;
  Field:IDMField;
  R:TRect;
begin
  try

  for j:=0 to sgDetails.ColCount-1 do
    sgDetails.Cols[j].Clear;
  sgDetails.RowCount:=0;
  if FCurrentElement=nil then Exit;
  

  FCurrentElement.CalculateFieldValues;

  FieldCount_:=FCurrentElement.FieldCount_;
//  memComment.Visible:=False;
  N:=0;
  FMemoFieldIndex:=-1;
  for j:=0 to FieldCount_-1 do begin
    Field:=FCurrentElement.Field_[j];
    if Field.ValueType=fvtText then begin
//      memComment.Visible:=True;
      memComment.Lines.Text:=FCurrentElement.FieldValue_[j];
//      pControl.Visible:=True;
      FMemoFieldIndex:=j;
    end else
    if FCurrentElement.FieldIsVisible(Field.Code) then begin
      if (Field.Level and FCurrentParamKind)<>0 then
        inc(N);
    end;
  end;

  with sgDetails do begin
    RowCount:=N;
    HH:=Top;
    N:=0;
    for j := 0 to FieldCount_-1 do begin
      Field:=FCurrentElement.Field_[j];
      if FCurrentElement.FieldIsVisible(Field.Code) and
         (Field.ValueType<>fvtText) and
         ((Field.Level and FCurrentParamKind)<>0) then begin
        Cells[0, N] := FCurrentElement.FieldName[j];
        Objects[0, N] := pointer(j);
        Objects[1, N] := pointer(j);
        SetDetailsCell(1, N);
        WW:=ColWidths[0];
        H0:=GetDetailCellHeight(Cells[0, N], False, WW, HH, 0, R);
        WW:=ColWidths[1];
        H1:=GetDetailCellHeight(Cells[1, N], False, WW, HH, 0, R);
        if H0>H1 then
          RowHeights[N]:=H0
        else
          RowHeights[N]:=H1;
        HH:=HH+RowHeights[N];
        inc(N);
      end;
    end;
  end;

  except
    raise
  end
end;

procedure TDMVBrowser.cbParameterChange(Sender: TObject);
var
  m, aCol, aRow:integer;
  aElement, Element:IDMElement;
  OperationManager:IDMOperationManager;
  V:Variant;
  aDocument:IDMDocument;
begin
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  OperationManager:=aDocument as IDMOperationManager;
  m:=cbParameter.ItemIndex;

  aCol:=sgDetails.Col;
  aRow:=sgDetails.Row;


  if FDetailMode=dmdList then begin
    if FCurrentElement=nil then Exit;
    aElement:=FCurrentElement;
  end else begin
    if sgDetails.Col<>0 then begin
      if FCurrentCollection=nil then Exit;
      if FCurrentCollection.Count=0 then Exit;
      aElement:=IDMElement(pointer(sgDetails.Objects[0, aRow]));
    end else
      aElement:=nil;
  end;

  if (m=-1) and
     (aElement.Field_[FCurrentFieldIndex].ValueType=fvtElement) then begin
    sgDetails.Cells[aCol, aRow]:='';
    V:=Null;
  end else begin
    case aElement.Field_[FCurrentFieldIndex].ValueType of
    fvtElement:
      begin
        Element:=IDMElement(pointer(cbParameter.Items.Objects[m]));
        V:=Element;
      end;
    fvtChoice:
      V:=cbParameter.ItemIndex+aElement.Field_[FCurrentFieldIndex].MinValue;
    else
      V:=cbParameter.ItemIndex;
    end;
  end;

  SetFieldValue(V, aElement);

  sgDetails.Cells[aCol, aRow]:=cbParameter.Text;
  cbParameter.Visible:=False;
  if Visible and
     (Sender=cbParameter) then
    sgDetails.SetFocus;
end;

procedure TDMVBrowser.SetFieldValue(const V:Variant; const aElement:IDMElement);
var
  aDocument:IDMDocument;
  OperationManager:IDMOperationManager;
  aField, theField:IDMField;
  RCode, j, i, l, CollectionIndex, CollectionIndex1, Indx, Indx1:integer;
  theElement, aParentElement, GrandParentElement:IDMElement;
  aCollection, theCollection:IDMCollection;
  aCollection2, theCollection2:IDMCollection2;
begin
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  OperationManager:=aDocument as IDMOperationManager;
  OperationManager.StartTransaction(FCurrentCollection, leoChangeFieldValue,
                                    rsChangeFieldValue);
  aField:=aElement.Field_[FCurrentFieldIndex];
  RCode:=aField.Code;

  if aDocument.SelectionCount=0 then
    OperationManager.ChangeFieldValue( aElement,
       RCode, True, V)
  else
  if aElement.Selected then begin
    for j:=0 to aDocument.SelectionCount-1 do begin
      theElement:=aDocument.SelectionItem[j] as IDMElement;
      if (theElement.Ref<>nil) and
        (theElement.Ref.SpatialElement=theElement) then
        theElement:=theElement.Ref;
        theField:=theElement.Field_[FCurrentFieldIndex];
      if theField=aField then
        OperationManager.ChangeFieldValue( theElement,
            RCode, True, V);
    end
  end else
  if FCurrentParentElement.Selected then begin
    CollectionIndex:=0;
    while CollectionIndex<FCurrentParentElement.CollectionCount do begin
      aCollection:=FCurrentParentElement.Collection[CollectionIndex];
      if aCollection.IndexOf(aElement)<>-1 then
        Break
      else
        inc(CollectionIndex);
    end;

    if FCurrentCollection=nil then
      Indx:=-1
    else
      Indx:=FCurrentCollection.IndexOf(aElement);

    for j:=0 to aDocument.SelectionCount-1 do begin
      aParentElement:=aDocument.SelectionItem[j] as IDMElement;
      if (aParentElement.Ref<>nil) and
        (aParentElement.Ref.SpatialElement=aParentElement) then
        aParentElement:=aParentElement.Ref;
      if (aParentElement.Ref=FCurrentParentElement.Ref) and
         (CollectionIndex<aParentElement.CollectionCount) then begin
        aCollection:=aParentElement.Collection[CollectionIndex];
        if (aCollection.QueryInterface(IDMCollection2, aCollection2)=0) and
           aCollection2.CanContain(aElement) then begin
          if Indx=-1 then begin
            for i:=0 to aCollection.Count-1 do begin
              theElement:=aCollection.Item[i];
              theField:=theElement.Field_[FCurrentFieldIndex];
              if theField=aField then
                OperationManager.ChangeFieldValue(
                  theElement, RCode, True, V);
            end;
          end else begin
            theElement:=aCollection.Item[Indx];
            theField:=theElement.Field_[FCurrentFieldIndex];
            if theField=aField then
              OperationManager.ChangeFieldValue(
                theElement, RCode, True, V);
          end;
        end;
      end;
    end
  end else
  if (FCurrentParentElement.Parent<>nil) and
      FCurrentParentElement.Parent.Selected then begin
    GrandParentElement:=FCurrentParentElement.Parent;

    CollectionIndex1:=0;
    Indx1:=-1;
    while CollectionIndex1<GrandParentElement.CollectionCount do begin
      aCollection:=GrandParentElement.Collection[CollectionIndex1];
      Indx1:=aCollection.IndexOf(FCurrentParentElement);
      if Indx1<>-1 then
        Break
      else
        inc(CollectionIndex1);
    end;

    CollectionIndex:=0;
    while CollectionIndex<FCurrentParentElement.CollectionCount do begin
      aCollection:=FCurrentParentElement.Collection[CollectionIndex];
      if aCollection.IndexOf(aElement)<>-1 then
        Break
      else
        inc(CollectionIndex);
    end;

    if FCurrentCollection=nil then
      Indx:=-1
    else
      Indx:=FCurrentCollection.IndexOf(aElement);

    for j:=0 to aDocument.SelectionCount-1 do begin
      GrandParentElement:=aDocument.SelectionItem[j] as IDMElement;
      if (GrandParentElement.Ref<>nil) and
         (GrandParentElement.Ref.SpatialElement=GrandParentElement) then
        GrandParentElement:=GrandParentElement.Ref;
      if (GrandParentElement.Ref=FCurrentParentElement.Parent.Ref) and
         (CollectionIndex1<GrandParentElement.CollectionCount) then begin
        aCollection:=GrandParentElement.Collection[CollectionIndex1];
        if (aCollection.QueryInterface(IDMCollection2, aCollection2)=0) and
          aCollection2.CanContain(FCurrentParentElement) then begin
          if Indx1<aCollection.Count then begin
            aParentElement:=aCollection.Item[Indx1];
            if aParentElement.Ref=FCurrentParentElement.Ref then
              if CollectionIndex<aParentElement.CollectionCount then begin
                theCollection:=aParentElement.Collection[CollectionIndex];
                if (theCollection.QueryInterface(IDMCollection2, theCollection2)=0) and
                   theCollection2.CanContain(aElement) then begin
                  if Indx=-1 then begin
                    for l:=0 to theCollection.Count-1 do begin
                      theElement:=theCollection.Item[l];
                      theField:=theElement.Field_[FCurrentFieldIndex];
                      if theField=aField then
                        OperationManager.ChangeFieldValue(
                          theElement, RCode, True, V);
                    end;
                  end else begin
                    theElement:=theCollection.Item[Indx];
                    theField:=theElement.Field_[FCurrentFieldIndex];
                    if theField=aField then
                      OperationManager.ChangeFieldValue(
                        theElement, RCode, True, V);
                  end;
                end;
              end;

          end;
        end;
      end;
    end;

  end else
    OperationManager.ChangeFieldValue( aElement,
       RCode, True, V);

  OperationManager.FinishTransaction(aElement, FCurrentCollection, leoChangeFieldValue);
end;

procedure TDMVBrowser.Set_CurrentElement(const Value: IUnknown);
var
  aElement:IDMElement;
  aDocument:IDMDocument;
  Key:word;
  aDataModel:IDataModel;
  Found:boolean;
begin
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfSelecting)<>0 then Exit;
  aElement:=Value as IDMElement;
  if FCurrentElement = aElement then Exit;

  if FSetCurrentElementFlag then Exit;
  FSetCurrentElementFlag:=True;
  try

  if cbParameter.Visible then
    cbParameterExit;
  Key:=VK_RETURN;
  sgDetailsKeyDown(sgDetails, Key, []);

  aDataModel:=GetDataModel;
  if aElement=nil  then
    FCurrentElement := nil
  else
  if aElement.DataModel=aDataModel  then
    FCurrentElement := aElement
  else
  if aElement.Ref=nil then
    FCurrentElement := aElement
  else
  if (aElement.Ref<>nil) and
     (aElement.Ref.DataModel=aDataModel) then begin
    if (aElement.DataModel as IDMElement).Ref=(aDataModel as IDMElement) then
      FCurrentElement := aElement.Ref
    else
      FCurrentElement := aElement
  end else begin
    FSetCurrentElementFlag:=False;
    Exit;
  end;

  if FCurrentElement<>nil then begin
//    SetDetails;
    if not FChangingTreeNodeFlag then begin
      ExpandGenerations(FCurrentElement, Found, True);
      if not Found then
        FCurrentElement:=nil;
    end
  end;

  aDocument.CurrentElement:=FCurrentElement;
  finally
    FSetCurrentElementFlag:=False;
  end;
end;

procedure TDMVBrowser.ParameterKeyPress(Sender: TObject; var Key: Char);
var
  OperationManager:IDMOperationManager;
  B:boolean;
  V:Variant;
  aElement, NilElement:IDMElement;
begin
   case key of
   #13:
     begin
       sgDetails.Cells[sgDetails.Col, sgDetails.Row]:=cbParameter.Text;
       cbParameter.Visible:=False;
       if Visible then
         sgDetails.SetFocus;
       Key:=#0;
     end;
   #32:
     begin

       if FDetailMode=dmdList then begin
         if FCurrentElement=nil then Exit;
         aElement:=FCurrentElement;
       end else begin
         if sgDetails.Col<>0 then begin
           if FCurrentCollection=nil then Exit;
           if FCurrentCollection.Count=0 then Exit;
           aElement:=IDMElement(pointer(sgDetails.Objects[0, sgDetails.Row]));
         end else
           aElement:=nil;
       end;

       OperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as IDMOperationManager;
       case aElement.Field_[FCurrentFieldIndex].ValueType of
       fvtBoolean:
         begin
           B:=FCurrentElement.FieldValue_[FCurrentFieldIndex];
           V:=not B;
           SetFieldValue(V, aElement);
           cbParameter.Visible:=False;
           if Visible then
             sgDetails.SetFocus;
           SetDetailsCell(sgDetails.Col, sgDetails.Row);
         end;
       fvtElement:
         begin
           cbParameter.ItemIndex:=-1;
           cbParameter.Text:='';
           NilElement:=nil;
           V:=NilElement as IUnknown;
           SetFieldValue(V, aElement);
           cbParameter.Visible:=False;
           if Visible then
             sgDetails.SetFocus;
         end;
       end;                
       Key:=#0;
     end;
   end;
end;

procedure TDMVBrowser.GoToLastElement;
var
  aElement:IDMElement;
  Unk:IUnknown;
begin
  if FLastElement<>nil then begin
    aElement:=FCurrentElement;
    Unk:=FLastElement as IUnknown;
    Set_CurrentElement(Unk);
    FLastElement:=aElement;
    if Visible then
      tvDataModel.SetFocus;
  end;
end;

procedure TDMVBrowser.tvDataModelFreeNode(Sender: TBaseVirtualTree; Node:PVirtualNode);
var
  Unk:IUnknown;
  Data:pointer;
begin
  if Get_ChangingParent then Exit;
  Data:=GetNodeData(Node);
  if FSelectedCollectionNode=Node then
    FSelectedCollectionNode:=nil;
  if (Data<>nil) then begin
    Unk:=IUnknown(Data);
    if Unk<>nil then
      Unk._Release;
//    tvDataModel.ResetNode(Node);
  end;
end;

procedure TDMVBrowser.HeaderSectionResize(HeaderControl: THeaderControl;
  Section: THeaderSection);
var
  j:integer;
  Rect:TRect;
begin
  for j:=0 to HeaderControl.Sections.Count-1 do
    sgDetails.ColWidths[j]:=HeaderControl.Sections[j].Width-1;

  with sgDetails do begin
    Rect:=CellRect(Col, Row);
    cbParameter.Left:=Rect.Left;
    cbParameter.Top:=Top+Rect.Top;
    cbParameter.Width:=Rect.Right-Rect.Left+2;
    cbParameter.Height:=Rect.Bottom-Rect.Top;
  end;
end;

procedure TDMVBrowser.HeaderResize(Sender: TObject);
var
  Rect:TRect;
  R:double;
begin
  if Header.Sections[0].Width>30 then
    R:=Header.Sections[0].Width/Header.Width
  else
  if FDetailMode=dmdList then
    R:=0.6
  else
    R:=0.3;
  SetColWidths(R);
  with sgDetails do begin
    Rect:=CellRect(Col, Row);
    cbParameter.Left:=Rect.Left;
    cbParameter.Top:=Top+Rect.Top;
    cbParameter.Width:=Rect.Right-Rect.Left+2;
    cbParameter.Height:=Rect.Bottom-Rect.Top;
  end;
end;

procedure TDMVBrowser.ChangeDetailsFont(const Element:IDMElement;
                                       const Field:IDMField;
                                       ACol, ARow:integer);
var
  iPrev:integer;
  PrevField:IDMField;
begin
  with sgDetails do begin
    case Field.Modifier of
    1:begin
        Canvas.Font.Color:=clNavy;
        Canvas.Font.Style:=Canvas.Font.Style+[fsBold];
      end;
    2:begin
        Canvas.Font.Style:=Canvas.Font.Style+[fsBold];

        if FDetailMode=dmdList then begin
          if ARow>0 then
            iPrev:=integer(pointer(Objects[ACol, ARow-1]))
          else
            iPrev:=-1
        end else
          iPrev:=integer(pointer(Objects[ACol-1, ARow]));

        if iPrev<>-1 then begin
          PrevField:=Element.Field_[iPrev];
          if PrevField.ValueType=fvtBoolean then begin
            if Element.FieldValue_[iPrev]=True then
              Canvas.Font.Color:=clGreen
            else
            Canvas.Font.Color:=clNavy;
          end;
        end else
          Canvas.Font.Color:=clNavy;
      end;
    3:begin
        Canvas.Font.Style:=Canvas.Font.Style+[fsItalic]
      end;
    end;
  end;
end;

procedure TDMVBrowser.SetDetailsCell(ACol, ARow: Integer);
var
  i, j:integer;
  Field:IDMField;
  Unk:IUnknown;
  Frmt:string;
  F:double;
  V:OleVariant;

  S:string;
  Element:IDMElement;
begin
  try
  if FDetailMode=dmdList then begin
    if FCurrentElement=nil then Exit;
    Element:=FCurrentElement;
  end else begin
    if FCurrentCollection=nil then Exit;
    if FCurrentCollection.Count=0 then Exit;
    Element:=IDMElement(pointer(sgDetails.Objects[0, ARow]));
  end;
  Field:=nil;

  if (Element<>nil) and
     (Element.FieldCount_>0) then begin
    if (ACol>0) or (FDetailMode=dmdList) then
      i:=integer(pointer(sgDetails.Objects[ACol, ARow]))
    else
      i:=integer(pointer(sgDetails.Objects[1, ARow]));
    Field:=Element.Field_[i];
  end else begin
    Field:=nil;
    i:=-1;
  end;

  with sgDetails do begin
    if Element=nil then
      S:=' '
    else
    if Field=nil then
      S:=' '
    else
    if (ACol=Col) and (ARow=Row) and
       cbParameter.Visible then begin
      S:=' ';
    end else begin
      case ACol of
      0:if FDetailMode=dmdList then
          S:=Element.FieldName[j]
        else
          S:=Element.Name;
      else begin
        V:=Element.FieldValue_[i];
        if VarIsNull(V) or
           VarIsEmpty(V) then
          S:=' '
        else
        case Field.ValueType of
        fvtFloat:
          begin
           if V>=InfinitValue then
             S:=rsInfinit
           else  
           if abs(V+InfinitValue)>1 then begin
             Frmt:=Field.ValueFormat;
             F:=V;
             S:=Format(Frmt, [F]);
           end else
             S:=rsUndefined;
          end;
        fvtBoolean:
          if V then
            S:=rsYes
          else
            S:=rsNo;
        fvtElement:
          begin
            Unk:=V;
            if Unk=nil then
              S:=''
            else
              S:=(Unk as IDMElement).Name;
          end;
        fvtChoice:
          begin
           Frmt:=Field.ValueFormat;
           j:=V-Field.MinValue;
           if (j>=0) and (j<=length(Frmt)) then
             S:=ExtractString(Frmt, j)
           else
             S:=''
          end;
        else
          S:=V;
        end;
        end;
      end;
    end;

    Cells[aCol, aRow]:=S;

  end;
  except
    raise
  end
end;

procedure TDMVBrowser.sgDetailsDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Field:IDMField;
  i:integer;
  S:string;
  HH, WW, LL:integer;
  Element:IDMElement;
begin
  try
  if FDetailMode=dmdList then begin
    if FCurrentElement=nil then Exit;
    Element:=FCurrentElement;
  end else begin
    if FCurrentCollection=nil then Exit;
    if FCurrentCollection.Count=0 then Exit;
    Element:=IDMElement(pointer(sgDetails.Objects[0, ARow]));
  end;
  Field:=nil;

  if (Element<>nil) and
     (Element.FieldCount_>0) then begin
    if (ACol>0) or (FDetailMode=dmdList) then
      i:=integer(pointer(sgDetails.Objects[ACol, ARow]))
    else
      i:=integer(pointer(sgDetails.Objects[1, ARow]));
    Field:=Element.Field_[i];
    if (ACol>0) and
       (Field<>nil) then
      ChangeDetailsFont(Element, Field, ACol, ARow);
  end else begin
    Field:=nil;
  end;

  with sgDetails do begin
    S:=Cells[aCol, aRow];

    HH:=Rect.Top;
    WW:=Rect.Right-Rect.Left-5;
    LL:=Rect.Left;
    if ACol=0 then
      Canvas.Brush.Color:=clBtnFace
    else begin
      Canvas.Brush.Color:=clWindow;
      Canvas.Font.Color:=clBlack;
    end;
    Canvas.FillRect(Rect);
    GetDetailCellHeight(S, True, WW, HH, LL, Rect);
  end;
  except
    raise
  end
end;

function TDMVBrowser.GetDetailCellHeight(S0:string; DrawFlag:boolean;
                                         WW, HH, LL:integer;
                                         R:TRect):integer;
var
  H, W, j, N:integer;
  S, S1, SS:string;
begin
  try
  with sgDetails do begin
    S:=Trim(S0);
    H:=Canvas.TextHeight(S);
    N:=0;
    Result:=3;
    while S<>'' do begin
      W:=Canvas.TextWidth(S);
      if W<=WW then begin
        S1:=S;
        S:='';
      end else begin
        S1:='';
        W:=0;
        j:=-1;
        while (W<=WW) and (j<>0) do begin
          j:=Pos(' ', S);
          if j<>0 then begin
            SS:=S1+Copy(S,1,j);
            W:=Canvas.TextWidth(SS);
            if W<=WW then begin
              S1:=SS;
              Delete(S,1,j);
              S:=TrimLeft(S);
            end;
          end;
        end;
      end;
//      if (N>2) and
//         (W>WW) then
//           S1:=S1+'...';
      if DrawFlag then
        Canvas.TextOut(LL,HH, S1);
//        Canvas.TextRect(R, LL,HH, S1);
      HH:=HH+H;
      Result:=Result+H;
      N:=N+1;
      if N=3 then
        Exit;
    end;
  end;
  except
    raise
  end;
end;

procedure TDMVBrowser.sgDetailsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Rect:TRect;
  ValueList:IDMCollection;
  ValueList2:IDMCollection2;
  Unk:IUnknown;
  DW, Err:integer;
  Document:IDMDocument;
  OperationManager:IDMOperationManager;
  V:Variant;
  Frmt:string;
  Delimeter:char;
  S:string;
  D:double;
  aElement:IDMElement;
  m:integer;
begin
  case Key of
  VK_RETURN,
  VK_ESCAPE:
    begin
      if FDetailMode=dmdList then begin
        if FCurrentElement=nil then Exit;
        aElement:=FCurrentElement;
      end else begin
        if sgDetails.Col<>0 then begin
          if FCurrentCollection=nil then Exit;
          if FCurrentCollection.Count=0 then Exit;
          aElement:=IDMElement(pointer(sgDetails.Objects[0, sgDetails.Row]));
        end else
          aElement:=nil;
      end;
    end;
  else
    Exit;
  end;

  with sgDetails do
  case Key of
  VK_RETURN:
    begin
      Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
      OperationManager:=Document as IDMOperationManager;
      ValueList:=OperationManager.SourceCollection as IDMCollection;
      ValueList2:=ValueList as IDMCollection2;
      ValueList2.Clear;

      if (FCurrentFieldIndex<>-1) and
         (aElement<>nil) then
      case aElement.Field_[FCurrentFieldIndex].ValueType of
      fvtBoolean,
      fvtChoice,
      fvtElement:
        begin
          if not cbParameter.Enabled then Exit;
          Rect:=CellRect(Col, Row);
          cbParameter.Left:=Rect.Left;
          cbParameter.Top:=Top+Rect.Top;
          cbParameter.Width:=Rect.Right-Rect.Left+2;
          cbParameter.Height:=Rect.Bottom-Rect.Top;
          cbParameter.Items.Clear;
          case aElement.Field_[FCurrentFieldIndex].ValueType of
          fvtElement:
            begin
              cbParameter.ItemIndex := -1;
              aElement.GetFieldValueSource(aElement.Field_[FCurrentFieldIndex].Code, ValueList);
              if ValueList<>nil then
                for m:=0 to ValueList.Count-1 do begin
                  Unk:=ValueList.Item[m];
                  cbParameter.Items.AddObject(ValueList.Item[m].Name, pointer(Unk));
                end;
              V:=aElement.FieldValue_[FCurrentFieldIndex];
              if VarIsNull(V) or
                 VarIsEmpty(V) then
                cbParameter.ItemIndex:=-1
              else begin
                Unk:=aElement.FieldValue_[FCurrentFieldIndex];
                cbParameter.ItemIndex:=cbParameter.Items.IndexOfObject(pointer(Unk));
              end;
              if cbParameter.ItemIndex=-1 then cbParameter.Text:=rsNotDefined;
              DW:=Canvas.TextWidth(cbParameter.Text)+25-Header.Sections[Col].Width;
              if DW>0 then begin
                 if DW>Header.Sections[0].Width-20 then
                   DW:=Header.Sections[0].Width-20;
                Header.Sections[0].Width:=Header.Sections[0].Width-DW;
                HeaderSectionResize(Header, Header.Sections[0]);
              end;
            end;
          fvtBoolean:
            begin
              cbParameter.Items.Add(rsNo);
              cbParameter.Items.Add(rsYes);
              if aElement.FieldValue_[FCurrentFieldIndex] then
                cbParameter.ItemIndex:=1
              else
                cbParameter.ItemIndex:=0
            end;
          fvtChoice:
            begin
              Frmt:=aElement.Field_[FCurrentFieldIndex].ValueFormat;
              if Frmt<>'' then begin
                Delimeter:=Frmt[1];
                Delete(Frmt,1,1);
                ParseText(Frmt, Delimeter, cbParameter.Items);
                cbParameter.ItemIndex:=aElement.FieldValue_[FCurrentFieldIndex]-
                                       aElement.Field_[FCurrentFieldIndex].MinValue;
              end;
            end;
          end; //end case  ...ValueType
          cbParameter.Visible:=True;
          if Visible then
            cbParameter.SetFocus;
        end
      else
        begin
          if (Get_Mode<>-1) and
              FEditingParameterFlag then begin
            FEditingParameterFlag:=not FEditingParameterFlag;
            Err:=0;
            S:=Cells[Col, Row];
            case aElement.Field_[FCurrentFieldIndex].ValueType of
            fvtInteger,
            fvtFloat:
              begin
                Val(S, D, Err);
                if Err=0 then
                  V:=D
                else
                if Pos(AnsiUpperCase(S), AnsiUpperCase(rsInfinit)) =1 then begin
                  V:=InfinitValue;
                  Err:=0;
                end;
              end;
            fvtString, fvtFile:
              V:=S;
            end;
            if Err=0 then begin
              SetFieldValue(V, aElement);
            end
          end;
        end;
      end; //end case ...ValueType
    end;
  VK_ESCAPE:
    begin
      if (aElement.Field_[FCurrentFieldIndex].ValueType=fvtBoolean) or
         (aElement.Field_[FCurrentFieldIndex].ValueType=fvtElement) or
         ((aElement.Field_[FCurrentFieldIndex].ValueType=fvtInteger) and
          (aElement.Field_[FCurrentFieldIndex].MaxValue=1)) then begin
      end else begin
        Cells[Col, Row]:=FOldFieldValue;
        FEditingParameterFlag:=not FEditingParameterFlag;
      end;
    end;
  end;
end;

procedure TDMVBrowser.sgDetailsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  Element:IDMElement;
  OperationManager:IDMOperationManager;
  Key:word;
  S:string;
begin
  FOldFieldValue:=sgDetails.Cells[ACol, ARow];
  cbParameter.Visible:=False;

  if FDetailMode=dmdList then begin
    if FCurrentElement=nil then Exit;
    Element:=FCurrentElement;
  end else begin
    if ACol<>0 then begin
      if FCurrentCollection=nil then Exit;
      if FCurrentCollection.Count=0 then Exit;
      Element:=IDMElement(pointer(sgDetails.Objects[0, ARow]));
    end else
      Element:=nil;
  end;

  with sgDetails do begin
    if (not FSetDetailsFlag) and
      ((aCol<>Col) or (aRow<>Row)) and
      (FCurrentFieldIndex<>-1) and
       FEditingParameterFlag then begin
      OperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as IDMOperationManager;
      S:=Element.FieldValue_[FCurrentFieldIndex];
      if Cells[Col, Row]<>S then begin
        Key:=VK_RETURN;
        sgDetailsKeyDown(Sender, Key, []);
      end;
      FEditingParameterFlag:=False;
    end;

    FCurrentFieldIndex:=integer(pointer(Objects[ACol, ARow]));
    if FCurrentFieldIndex>Element.FieldCount_-1 then Exit;

    if (not Element.FieldIsReadOnly(FCurrentFieldIndex)) and
       (Get_Mode<>-1) then begin
      Options:=Options+[goEditing];
      cbParameter.Enabled:=True;
    end else begin
      Options:=Options-[goEditing];
      cbParameter.Enabled:=False;
      FEditingParameterFlag:=False;
    end;

    if (Element.Field_[FCurrentFieldIndex].ValueType=fvtBoolean) or
       (Element.Field_[FCurrentFieldIndex].ValueType=fvtChoice) or
       (Element.Field_[FCurrentFieldIndex].ValueType=fvtElement) then begin
      Options:=Options-[goEditing];
      FEditingParameterFlag:=False;
    end;
  end;
end;

procedure TDMVBrowser.sgDetailsEnter(Sender: TObject);
var
  CanSelect: Boolean;
begin
  sgDetailsSelectCell(sgDetails,
      sgDetails.Col, sgDetails.Row, CanSelect);
  Get_DMEditorX.ActiveForm:=Self as IDMForm;
end;

procedure TDMVBrowser.sgDetailsDblClick(Sender: TObject);
var Key: Word;
begin
  Key:=VK_RETURN;
  sgDetailsKeyDown(sgDetails,  Key, []);
end;

procedure TDMVBrowser.sgDetailsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if (not FEditingParameterFlag) and
     (goEditing in sgDetails.Options) then begin
    FEditingParameterFlag:=True;
  end;
end;

procedure TDMVBrowser.cbParameterExit;
begin
  cbParameterChange(nil);
  cbParameter.Visible:=False;
end;

procedure TDMVBrowser.SetDetailMode(const Value: TDetailMode);
begin
  FDetailMode := Value;
  SetDetails;
  sgDetails.Visible:=sgDetails.Cells[0,0]<>'';
end;

procedure TDMVBrowser.SetDetails;
var
  Data:pointer;
begin
  if Get_ChangingParent then Exit;
  try
  TabControl1.Tabs.Clear;
  except
    Exit;
  end;

  FSetDetailsFlag:=True;
  case FDetailMode of
  dmdList:
    begin
      while Header.Sections.Count>2 do
        Header.Sections.Delete(2);
      sgDetails.ColCount:=2;
      Header.Sections[0].Text:=rsParameter;
      if Header.Sections.Count=1 then
        Header.Sections.Add;
      Header.Sections[1].Text:=rsFieldValue;
      SetColWidths(0.6);
      SetDetailsList;
    end;
  dmdTable:
    begin
      if tvDataModel.FocusedNode=nil then Exit;
      Data:=GetNodeData(tvDataModel.FocusedNode);
      if Data=nil then Exit;

        SetDetailsElements(FCurrentCollection)
    end;
  end;
  FSetDetailsFlag:=False;
end;

procedure TDMVBrowser.SetDetailsElements(Elements: IDMCollection);
var
  Field:IDMField;
  Element:IDMElement;
  m, j, HH, WW, N:integer;
  Section:THeaderSection;
  FieldCount_:integer;
  R:TRect;
begin
   while Header.Sections.Count>1 do
     Header.Sections.Delete(1);
   Header.Sections[0].Text:='';
   sgDetails.ColCount:=1;
   sgDetails.RowCount:=1;

   if Elements.Count=0 then Exit;
   Element:=Elements.Item[0];

   FieldCount_:=Element.FieldCount_;
   N:=0;
   for m:=0 to FieldCount_-1 do
     if Element.FieldIsVisible(Element.Field_[m].Code) and
       (Element.Field_[m].ValueType<>fvtText) then
       inc(N);
   sgDetails.ColCount:=N+1;
   sgDetails.RowCount:=Elements.Count;
   HH:=sgDetails.Top;
   for j:=0 to Elements.Count-1 do begin
     sgDetails.Cells[0, j]:=Elements.Item[j].Name;
     sgDetails.Objects[0, j]:=pointer(Elements.Item[j]);
     WW:=sgDetails.ColWidths[0];
     sgDetails.RowHeights[j]:=GetDetailCellHeight(sgDetails.Cells[0, j], False, WW, HH, 0, R);
   end;
   N:=0;
   for m:=0 to FieldCount_-1 do begin
     Field:=Element.Field_[m];
     if Element.FieldIsVisible(Field.Code) and
       (Field.ValueType<>fvtText) then begin
       Section:=Header.Sections.Add;
       Section.Text:=IntToStr(N+1);
       for j:=0 to Elements.Count-1 do begin
         sgDetails.Objects[N+1, j]:=pointer(m);
         SetDetailsCell(N+1, j);
       end;
       inc(N);
     end;
   end;
   sgDetails.Invalidate;
end;

procedure TDMVBrowser.HeaderSectionClick(HeaderControl: THeaderControl;
  Section: THeaderSection);
begin
  if (FDetailMode=dmdTable) and
     (FCurrentElement<>nil) and
     (Section=Header.Sections[0]) then begin
    cbCategories.Left:=0;
    cbCategories.Top:=Header.Top;
    cbCategories.Width:=Header.Sections[0].Width;
    cbCategories.Visible:=True;
    if Visible then
      cbCategories.SetFocus;
  end;
end;

procedure TDMVBrowser.cbCategoriesChange(Sender: TObject);
var
  Elements:IDMCollection;
  j:integer;
  aDocument:IDMDocument;
begin
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  j:=cbCategories.ItemIndex;
  if j=-1 then Exit;
  Elements:=IDMCollection(pointer(cbCategories.Items.Objects[j]));
  SetDetailsElements(Elements);
  SetColWidths(0.3);
  sgDetails.Visible:=sgDetails.Cells[0,0]<>'';
end;

procedure TDMVBrowser.cbCategoriesExit(Sender: TObject);
begin
  cbCategoriesChange(Sender);
  cbCategories.Visible:=False;
end;

procedure TDMVBrowser.InitTree;
var
  j, Operations, LinkType, Mode:integer;
  Text:string;
  Data:pointer;
  RootObject:IUnknown;
  RootObjectName: WideString;
  Unk:IUnknown;
  aDataModel:IDataModel;
  DMDocument:IDMDocument;
  aElement, DataModelE:IDMElement;
  aCollection:IDMCollection;

  CurrentElementID:integer;
  CurrentElementClassID:integer;
  CurrentCollectionIndex:integer;

  TopElementID:integer;
  TopElementClassID:integer;
  TopCollectionIndex:integer;
  Node:PVirtualNode;
begin
  Mode:=Get_Mode;

  ClearTree;

  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if DMDocument<>nil then begin
    aDataModel:=GetDataModel;
    DataModelE:=aDataModel as IDMElement;
    tvDataModel.RootNodeCount:=aDataModel.RootObjectCount[Mode];
  end;

  if DMDocument=nil then Exit;
  if (FCurrentObject<>nil) and
     (FCurrentObject.QueryInterface(IDMElement, aElement)<>0) then begin
    aCollection:=FCurrentObject as IDMCollection;
    aElement:=aCollection.Parent;
  end else
    aElement:=nil;

  if Mode=-1 then Exit;
  try
  if (aElement=nil) or
     (aElement.DataModel<>aDataModel) then begin
    CurrentElementID:=DMDocument.CurrentElementID;
    CurrentElementClassID:=DMDocument.CurrentElementClassID;
    CurrentCollectionIndex:=DMDocument.CurrentCollectionIndex;
    FCurrentObjectExpanded:=DMDocument.CurrentObjectExpanded;
    TopElementID:=DMDocument.TopElementID;
    TopElementClassID:=DMDocument.TopElementClassID;
    TopCollectionIndex:=DMDocument.TopCollectionIndex;

    if (TopElementClassID<>-1) and
       (TopElementID<>-1) then begin
      aElement:=(DataModelE.Collection[TopElementClassID] as IDMCollection2).GetItemByID(TopElementID);

      if TopCollectionIndex<>-1 then
        aCollection:=aElement.Collection[TopCollectionIndex]
      else
        aCollection:=nil;

      if aCollection=nil then
        FTopObject:=aElement as IUnknown
      else
        FTopObject:=aCollection as IUnknown;
    end else
      FTopObject:=nil;

    if (CurrentElementClassID<>-1) and
       (CurrentElementID<>-1) then begin
      aElement:=(DataModelE.Collection[CurrentElementClassID] as IDMCollection2).GetItemByID(CurrentElementID);

      if (aElement<>nil) and
         (CurrentCollectionIndex<>-1) then
        aCollection:=aElement.Collection[CurrentCollectionIndex]
      else
        aCollection:=nil;

      if aCollection=nil then begin
        FCurrentObject:=aElement as IUnknown
      end else
        FCurrentObject:=aCollection as IUnknown;
    end else
      FCurrentObject:=nil;

    RestoreState;
  end;
  except
    raise
  end;
end;

procedure TDMVBrowser.DocumentOperation(ElementsV, CollectionV: OleVariant; DMOperation,
  nItemIndex: Integer);
var
  aNode, CollectionNode:PVirtualNode;
  aCollectionU, aElementU, aUnk, Unk:IUnknown;
  i, j, m:integer;
  Element:IDMElement;
  Collection:IDMCollection;
  Found:boolean;
  aNodeParent, FocusedNodeParent:PVirtualNode;
  Data:pointer;
begin
  if not Visible then Exit;
  FNodeList.Clear;

  case DMOperation of
  leoRename, leoChangeRef:
    begin
      aElementU:=ElementsV;
      aUnk:=aElementU as IUnknown;
      if aUnk=nil then Exit;
      if aUnk.QueryInterface(IDMElement, Element)=0 then begin
        aNode:=tvDataModel.GetFirst;
        while aNode<>nil do begin
          Data:=GetNodeData(aNode);
          Unk:=IUnknown(Data);
          if aUnk=Unk then
            FNodeList.Add(aNode);
          aNode:=tvDataModel.GetNext(aNode)
        end;
      end else begin
        Collection:=aUnk as IDMCollection;
        for i:=0 to Collection.Count-1 do begin
          Element:=Collection.Item[i];
          aUnk:=Element as IUnknown;
          aNode:=tvDataModel.GetFirst;
          while aNode<>nil do begin
            Data:=GetNodeData(aNode);
            Unk:=IUnknown(Data);
            if aUnk=Unk then
              FNodeList.Add(aNode);
            aNode:=tvDataModel.GetNext(aNode)
          end;
        end;
      end;
    end;
  leoChangeFieldValue:
    begin
      aUnk:=ElementsV;
      if aUnk=nil then Exit;
      if aUnk.QueryInterface(IDMElement, Element)=0 then begin
        if FCurrentElement=Element then
          SetDetails;
      end;
    end;
  else
    begin
      aCollectionU:=CollectionV;
      aUnk:=aCollectionU as IUnknown;
      if aUnk=nil then
        aUnk:=FCurrentCollection as IUnknown;
      aNode:=tvDataModel.GetFirst;
      while aNode<>nil do begin
        Data:=GetNodeData(aNode);
        Unk:=IUnknown(Data) as IUnknown;
        if aUnk=Unk then
         FNodeList.Add(aNode);
        aNode:=tvDataModel.GetNext(aNode)
      end;
    end;

    aElementU:=ElementsV;
    aUnk:=aElementU as IUnknown;
      aNode:=tvDataModel.GetFirst;
      while aNode<>nil do begin
        Data:=GetNodeData(aNode);
        Unk:=IUnknown(Data);
        aNodeParent:=tvDataModel.NodeParent[aNode];
        if (aUnk=Unk) and
         (aNodeParent<>nil) and
         (FNodeList.IndexOf(aNodeParent)=-1) then
        FNodeList.Add(aNodeParent);
        aNode:=tvDataModel.GetNext(aNode)
      end;
  end;

  case DMOperation of
  leoAdd:
    begin
      if aElementU=nil then Exit;
      if aElementU.QueryInterface(IDMElement, Element)=0 then begin
        if (Element<>nil) and
           Element.Exists then begin
          if (Element.Ref<>nil) and
             (Element.Ref.SpatialElement=Element) then
            Element:=Element.Ref;
          ExpandGenerations(Element, Found, True)
        end else begin
          for j:=0 to FNodeList.Count-1 do begin
            aNode:=FNodeList[j];
            UpdateTree(nItemIndex, aNode, DMOperation=leoMove);
          end;
        end;
      end;
    end;
  leoRename, leoChangeRef:
     for j:=0 to FNodeList.Count-1 do begin
       aNode:=FNodeList[j];
       if aElementU.QueryInterface(IDMElement, Element)<>0 then
         Element:=(aElementU as IDMCollection).Item[j];
       tvDataModel.InvalidateNode(aNode);
     end;
  leoDelete,
  leoSelect,
  leoSelectRef,
  leoPaste,
  leoMove,
  leoChangeParent:
    begin
      if (tvDataModel.FocusedNode<>nil) then begin
        Data:=GetNodeData(tvDataModel.FocusedNode);
        if Data<>nil then begin
          if Succeeded(IUnknown(Data).QueryInterface(IDMCollection, aCollectionU)) then
            CollectionNode:=tvDataModel.FocusedNode
          else begin
            FocusedNodeParent:=tvDataModel.NodeParent[tvDataModel.FocusedNode];
            CollectionNode:=FocusedNodeParent;
          end;

          m:=FNodeList.IndexOf(CollectionNode);
          if m<>-1 then
            FNodeList.Move(m, FNodeList.Count-1);
        end;
      end;

      for j:=0 to FNodeList.Count-1 do begin
        aNode:=FNodeList[j];
        UpdateTree(nItemIndex, aNode, DMOperation=leoMove);
      end;
    end;
  end;

  inherited;
end;

procedure TDMVBrowser.AddElement;
var
  aName, Suffix:string;
  aRef, aElement:IDMElement;
  ClassCollection, aCollection:IDMCollection;
  InstanceClassID:integer;
  aDataModel:IDataModel;
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  j, CollectionIndex1, Indx1:integer;
  aParentElement, GrandParentElement, aRefE:IDMElement;
  aElementU:IUnknown;
  aRefU:IUnknown;
  Server:IDataModelServer;
  V:Variant;
  Element4:IDMElement4;

  procedure RefInput;
  begin
    aName:=(FCurrentRefSource as IDMCollection2).MakeDefaultName(FCurrentParentElement);

    Server.EventData2:=aName;
    Server.EventData3:=0;
    Server.CallDialog(4,
                      Format(rsAddItemCaption,[aName]),
                      Format(rsAddItemPrompt,[aName]));
    if Server.EventData3=-1 then
      Exit;
    aName:=trim(Server.EventData2);

    if length(aName)=0 then
      Raise Exception.Create(rsBlankNameError);

    DMOperationManager.StartTransaction(FCurrentCollection as IUnknown,
                                        leoAdd, rsAddElementRef);
    DMOperationManager.AddElement(
                     nil, FCurrentRefSource,
                     aName, ltOneToMany, aRefU, True);
    DMOperationManager.AddElementRef(
                       FCurrentParentElement, FCurrentCollection,
                       aName, aRefU, ltOneToMany, aElementU, True);
    aRef:=aRefU as IDMElement;
    aElement:=aElementU as IDMElement;
    DMOperationManager.FinishTransaction(aElementU,
               FCurrentCollection as IUnknown, leoAdd);
  end;

  procedure RefInput4;
  var
    j:integer;
  begin
    Suffix:='';
    Server.EventData1:=null;
    if FCurrentCollection.ClassID<>-1 then
    Server.EventData2:=' ';
    Server.EventData3:=0;
    Server.CallRefDialog(nil, FCurrentRefSource, Suffix, True);
    V:=Server.EventData1;
    if VarIsNull(V) then
      aRefU:=nil
    else
      aRefU:=V;
    if aRefU=nil then Exit;
    aRefE:=aRefU as IDMElement;
    aName:=Server.EventData2;
    if trim(aName)='' then Exit;

//    Get_DMEditorX.Say('Добавляем объект '+aName, True, False);

    DMOperationManager.StartTransaction(FCurrentCollection, leoAdd, rsAddElementRef);
    if (Document.SelectionCount=0) or
        not FCurrentParentElement.Selected then begin
      aElementU:=Element4.AddRefElementRef(FCurrentCollection, aName, aRefE);
      aElement:=aElementU as IDMElement;
    end else begin
      for j:=0 to Document.SelectionCount-1 do begin
        aParentElement:=Document.SelectionItem[j] as IDMElement;
        if (aParentElement.Ref<>nil) and
          (aParentElement.Ref.SpatialElement=aParentElement) then
          aParentElement:=aParentElement.Ref;
        if aParentElement.Ref=FCurrentParentElement.Ref then begin
          if (aParentElement.QueryInterface(IDMElement4, Element4)=0) then begin
            aElementU:=Element4.AddRefElementRef(FCurrentCollection, aName, aRefE);
            aElement:=aElementU as IDMElement;
          end
        end else
          aElement:=nil;
      end;
    end;
    DMOperationManager.FinishTransaction(aElementU, FCurrentCollection, leoAdd);
  end;

begin
  if FCurrentCollection=nil then Exit;
  if Get_Mode=-1 then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  Document:=Server.CurrentDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;
  if not CheckCurrentElementSeletion then Exit;

  DMOperationManager:=Document as IDMOperationManager;

  if (FCurrentRefSource=nil) and
     (FCurrentClassCollections=nil) then begin
    aName:=(FCurrentCollection as IDMCollection2).MakeDefaultName(FCurrentParentElement);

    Server.EventData2:=aName;
    Server.EventData3:=0;
    Server.CallDialog(4,
                      Format(rsAddItemCaption,[aName]),
                      Format(rsAddItemPrompt,[aName]));
    if Server.EventData3=-1 then
      Exit;
    aName:=trim(Server.EventData2);

    if length(aName)=0 then
      Raise Exception.Create(rsBlankNameError);
    DMOperationManager.StartTransaction(FCurrentCollection, leoAdd, rsAddElement);
    DMOperationManager.AddElement(
                       FCurrentParentElement, FCurrentCollection,
                       aName, ltOneToMany, aElementU, True);
    DMOperationManager.FinishTransaction(aElementU, FCurrentCollection, leoAdd);
    aElement:=aElementU as IDMElement;
  end else if FCurrentRefSource<>nil then begin
    if ((FCurrentOperations and leoSelect)=0) and
       ((FCurrentOperations and leoSelectRef)<>0) then begin
      if (FCurrentParentElement<>nil) then begin
        if (FCurrentParentElement.QueryInterface(IDMElement4, Element4)=0) then
          RefInput4
        else begin
          if (FCurrentParentElement.Ref<>nil) and
             (FCurrentParentElement.Ref.QueryInterface(IDMElement4, Element4)=0) then
            RefInput4
          else
            RefInput
        end;  
      end else
        RefInput
    end else begin
      Suffix:='';
      Server.EventData1:=null;
      if FCurrentCollection.ClassID<>-1 then
        Server.EventData2:=(FCurrentCollection as IDMCollection2).MakeDefaultName(FCurrentParentElement)
      else
        Server.EventData2:='';
      Server.EventData3:=0;
      Server.CallRefDialog(nil, FCurrentRefSource, Suffix, True);
      V:=Server.EventData1;
      if VarIsNull(V) then
        aRefU:=nil
      else
        aRefU:=V;
      if aRefU=nil then Exit;
      aName:=Server.EventData2;
      if trim(aName)='' then Exit;

//      Get_DMEditorX.Say('Добавляем объект '+aName, True, False);

      DMOperationManager.StartTransaction(FCurrentCollection, leoAdd, rsAddElementRef);
      if (Document.SelectionCount=0) or
          not FCurrentParentElement.Selected then begin
        DMOperationManager.AddElementRef(
                         FCurrentParentElement, FCurrentCollection,
                         aName, aRefU, ltOneToMany, aElementU, True);
        aElement:=aElementU as IDMElement;
      end else begin
        for j:=0 to Document.SelectionCount-1 do begin
          aParentElement:=Document.SelectionItem[j] as IDMElement;
          if (aParentElement.Ref<>nil) and
            (aParentElement.Ref.SpatialElement=aParentElement) then
            aParentElement:=aParentElement.Ref;
          if aParentElement.Ref=FCurrentParentElement.Ref then begin
            DMOperationManager.AddElementRef(
                         aParentElement, FCurrentCollection,
                         aName, aRefU, ltOneToMany, aElementU, True);
            aElement:=aElementU as IDMElement;
          end else
            aElement:=nil;
        end;
      end;
      DMOperationManager.FinishTransaction(aElementU, FCurrentCollection, leoAdd);
    end;
  end else if FCurrentClassCollections<>nil then begin
    Suffix:='';
    Server.EventData1:=null;
    Server.EventData2:=(FCurrentCollection as IDMCollection2).MakeDefaultName(FCurrentParentElement);
    Server.EventData3:=0;
    Server.CallRefDialog(FCurrentClassCollections, nil, Suffix, True);
    V:=Server.EventData1;
    if VarIsNull(V) then
      aRefU:=nil
    else
      aRefU:=V;
    if aRefU=nil then Exit;
    aName:=Server.EventData2;
    if trim(aName)='' then Exit;
    InstanceClassID:=Server.EventData3;

    if InstanceClassID<>-1 then begin
      aDataModel:=GetDataModel;
      ClassCollection:=(aDataModel as IDMElement).Collection[InstanceClassID];
      DMOperationManager.StartTransaction(FCurrentCollection, leoAdd, rsAddElementRef);
      if aRefU<>nil then begin
        if (Document.SelectionCount=0) then begin
          DMOperationManager._AddElementRef( ClassCollection,
                       FCurrentParentElement as IUnknown,
                       FCurrentCollection as IUnknown,
                       aName, aRefU, ltOneToMany, aElementU, True);
          aElement:=aElementU as IDMElement;
        end else
        if FCurrentParentElement.Selected then begin

          for j:=0 to Document.SelectionCount-1 do begin
            aParentElement:=Document.SelectionItem[j] as IDMElement;
            if (aParentElement.Ref<>nil) and
              (aParentElement.Ref.SpatialElement=aParentElement) then
              aParentElement:=aParentElement.Ref;
              if aParentElement.Ref=FCurrentParentElement.Ref then begin
                DMOperationManager._AddElementRef( ClassCollection,
                           aParentElement as IUnknown,
                           FCurrentCollection as IUnknown,
                           aName, aRefU, ltOneToMany, aElementU, True);
                aElement:=aElementU as IDMElement;
              end else
                aElement:=nil;
          end
        end else
        if (FCurrentParentElement.Parent<>nil) and
            FCurrentParentElement.Parent.Selected then begin
          GrandParentElement:=FCurrentParentElement.Parent;

          CollectionIndex1:=0;
          Indx1:=-1;
          while CollectionIndex1<GrandParentElement.CollectionCount do begin
            aCollection:=GrandParentElement.Collection[CollectionIndex1];
            Indx1:=aCollection.IndexOf(FCurrentParentElement);
            if Indx1<>-1 then
              Break
            else
              inc(CollectionIndex1);
          end;

          for j:=0 to Document.SelectionCount-1 do begin
            GrandParentElement:=Document.SelectionItem[j] as IDMElement;
            if (GrandParentElement.Ref<>nil) and
               (GrandParentElement.Ref.SpatialElement=GrandParentElement) then
              GrandParentElement:=GrandParentElement.Ref;
            if (GrandParentElement.Ref=FCurrentParentElement.Parent.Ref) and
               (CollectionIndex1< GrandParentElement.CollectionCount) then begin
              aCollection:=GrandParentElement.Collection[CollectionIndex1];
              if aCollection.ClassID=FCurrentParentElement.ClassID then begin
                if Indx1<aCollection.Count then begin
                  aParentElement:=aCollection.Item[Indx1];
                  DMOperationManager._AddElementRef( ClassCollection,
                       aParentElement as IUnknown,
                       FCurrentCollection as IUnknown,
                       aName, aRefU, ltOneToMany, aElementU, True);
                  aElement:=aElementU as IDMElement;
                end;
              end;
            end;
          end;
        end;
      end else begin
        DMOperationManager._AddElement(
                     ClassCollection as IUnknown,
                     FCurrentParentElement as IUnknown,
                     FCurrentCollection as IUnknown,
                     aName, ltOneToMany, aElementU, True);
        aElement:=aElementU as IDMElement;
      end;
      DMOperationManager.FinishTransaction(aElementU,
                         FCurrentCollection as IUnknown, leoAdd);
    end;
  end
end;

procedure TDMVBrowser.DeleteElement;
var
  OperationManager:IDMOperationManager;
  aElement:IDMElement;
  OldState, OldSelectState:integer;
  aDocument:IDMDocument;
  Collection2:IDMCollection2;
begin
  if Get_Mode=-1 then Exit;
  if FCurrentElement=nil then Exit;
  if not CheckCurrentElementSeletion then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  OperationManager:=aDocument as IDMOperationManager;
  Collection2:=OperationManager.SourceCollection as IDMCollection2;
  Collection2.Clear;
  
  OperationManager.StartTransaction(FCurrentCollection, leoDelete, rsDelete);

  OldState:=aDataModel.State;
  OldSelectState:=OldSelectState and dmfSelecting;
  aDataModel.State:=OldState or dmfSelecting;
  try
  if not FCurrentElement.Selected then begin
    aElement:=FCurrentElement;
    if (aElement.SpatialElement<>nil) and
       (aElement.SpatialElement.Ref=aElement) then
    aElement:=aElement.SpatialElement;
    Collection2.Add(aElement);
  end else begin
    aElement:=nil;
    while aDocument.SelectionCount>0 do begin
      aElement:=aDocument.SelectionItem[0] as IDMElement;
      if (aElement.SpatialElement<>nil) and
         (aElement.SpatialElement.Ref=aElement) then
      aElement:=aElement.SpatialElement;
      aElement.Selected:=False;
      Collection2.Add(aElement);
    end;
  end;

  if (Collection2 as IDMCollection).Count=0 then begin
    aDataModel.State:=OldState;
    Exit;
  end;

//  Get_DMEditorX.Say('Удаляем объект', True, False);

  OperationManager.DeleteElements(Collection2, True);
  finally
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
  end;
  OperationManager.FinishTransaction(nil, FCurrentCollection, leoDelete);
end;

procedure TDMVBrowser.SelectElementFromList;
var
  SourceCollection, DestCollection:IDMCollection;
  SourceCollection2, DestCollection2:IDMCollection2;
  j, m, FormID:integer;
  aElement, aRef:IDMElement;
  OperationManager:IDMOperationManager;
  aDocument:IDMDocument;
  AddFlag:boolean;
begin
  if FCurrentCollection=nil then Exit;
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;
  OperationManager:=aDocument as IDMOperationManager;

  SourceCollection:=OperationManager.SourceCollection as IDMCollection;
  SourceCollection2:=SourceCollection as IDMCollection2;
  SourceCollection2.Clear;
  
  DestCollection:=OperationManager.DestCollection as IDMCollection;
  DestCollection2:=DestCollection as IDMCollection2;
  DestCollection2.Clear;

  if dlgDualList=nil then
    dlgDualList:=TdlgDualList.Create(Self);

  j:=0;
  while j<FCurrentParentElement.CollectionCount do
    if FCurrentParentElement.Collection[j]=FCurrentCollection then
      Break
    else
      inc(j);
  FCurrentParentElement.MakeSelectSource(j, SourceCollection);

  with dlgDualList do begin
    if (FCurrentOperations and leoSelect)<>0 then begin
      SrcList.Clear;
      for j:=0 to SourceCollection.Count-1 do begin
        aElement:=SourceCollection.Item[j];
        if (FCurrentCollection.IndexOf(aElement)=-1) and
          not (aElement.Includes(FCurrentParentElement)) then
          SrcList.Items.AddObject(aElement.Name, pointer(aElement));
      end;
      SourceCollection:=nil;
      DstList.Clear;
      for j:=0 to FCurrentCollection.Count-1 do
        DstList.Items.AddObject(FCurrentCollection.Item[j].Name, pointer(FCurrentCollection.Item[j]));
    end else begin
      SrcList.Clear;
      for j:=0 to SourceCollection.Count-1 do begin
        aRef:=SourceCollection.Item[j];
        m:=0;
        while m<FCurrentCollection.Count do
          if FCurrentCollection.Item[m].Ref=aRef then
            Break
          else
            inc(m);
        if m=FCurrentCollection.Count then
          SrcList.Items.AddObject(aRef.Name, pointer(aRef));
      end;
      DstList.Clear;
      for j:=0 to FCurrentCollection.Count-1 do
        DstList.Items.AddObject(FCurrentCollection.Item[j].Ref.Name, pointer(FCurrentCollection.Item[j].Ref));
    end;

    SetButtons;
  end;

  if dlgDualList.ShowModal=mrOK then begin

   FormID:=Get_FormID;
    with dlgDualList do begin
      if DstList.Items.Count>0 then begin
        for j:=0 to DstList.Items.Count-1 do begin
          aElement:=IDMElement(pointer(DstList.Items.Objects[j]));
          DestCollection2.Add(aElement);

          if (FCurrentOperations and leoSelect)<>0 then
            AddFlag:=(FCurrentCollection.IndexOf(aElement)=-1)
          else
            AddFlag:=((FCurrentCollection as IDMCollection2).GetItemByRef(aElement)=nil);
          if AddFlag then begin
            (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -3, meMouseMove, aElement.ID, 0, '');
            (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -3, meLClick, aElement.ID, 0, '');
            (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -3, meMouseMove, -1, 1, '');
            (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -3, meLClick, -1, 1, '')
          end;
        end;
      end;
    end;
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -3, meLClick, -1, -1, '');

    OperationManager.StartTransaction(FCurrentCollection, leoSelect, rsAddDeleteElements);
    if (SourceCollection<>nil) and
       ((FCurrentOperations and leoSelect)=0) then
      OperationManager.AddDeleteRefs( FCurrentParentElement,
                                     FCurrentCollection, DestCollection,
                                     SourceCollection, aDocument)
    else
      OperationManager.AddDeleteElements( FCurrentParentElement,
                                     FCurrentCollection, DestCollection,
                                     FCurrentLinkType);
    if FCurrentCollection.Count=0 then
      aElement:=nil
    else
      aElement:=FCurrentCollection.Item[0];

    OperationManager.FinishTransaction(aElement, FCurrentCollection, leoSelect);
    if aDocument<>nil then begin
      aDocument.ClearSelection(nil);
      aDataModel.State:=aDataModel.State and not dmfSelecting;
    end;

    tvDataModel.Invalidate;
  end;
end;

procedure TDMVBrowser.tvDataModelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aNode:PVirtualNode;
  ClearSelectionFlag:boolean;
  HitInfo:THitInfo;
  HitPositions:THitPositions;
  Hi, FormID, ID, YY:integer;
  aDocument:IDMDocument;
  MiscOptions:TVTMiscOptions;
begin
  FShiftState:=Shift;
  FEditing:=False;

  MiscOptions:=tvDataModel.TreeOptions.MiscOptions;
  Exclude(MiscOptions, toEditable);
  tvDataModel.TreeOptions.MiscOptions:=MiscOptions;

  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  aNode:=tvDataModel.GetNodeAt(X,Y);
  if aNode=nil then Exit;

  tvDataModel.GetHitTestInfoAt(X,Y, True, HitInfo);
  HitPositions:=HitInfo.HitPositions;
  hi:=0;
  if hiOnItem in HitPositions then
    hi:=32;
  if hiOnNormalIcon in HitPositions then
    hi:=64;
  if hiOnItemButton in HitPositions then
    hi:=128;
  if hi<>0 then begin
    if ssShift in Shift then
      hi:=hi+1;
    if ssAlt in Shift then
      hi:=hi+2;
    if ssCtrl in Shift then
      hi:=hi+4;
    if ssRight in Shift then
      hi:=hi+16;
    InitNodeClickMacros(aNode, hi);
  end;

  if not (ssRight in Shift) then begin
    ClearSelectionFlag:=(not (ssCtrl in Shift)) and (not (ssShift in Shift));

    if hiOnNormalIcon in HitPositions then
      SwitchSelection(aNode, ClearSelectionFlag);
  end else begin
    GetMacrosNodeID(aNode, Hi, ID, YY);
    FormID:=Get_FormID;
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -1, meRClick, ID, YY, '')
  end;
end;

procedure TDMVBrowser.SwitchSelection(aNode:PVirtualNode; ClearSelectionFlag:boolean);
var
  aElement:IDMElement;
  aDocument:IDMDocument;
  aSelectedCollectionNode:PVirtualNode;
  j, m, OldState, OldSelectState:integer;
  Server:IDataModelServer;
  Data:pointer;
begin
  if Get_Mode=-1 then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=Server.CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;
  Data:=GetNodeData(aNode);
  if Data=nil then Exit;
  if Succeeded(IUnknown(Data).QueryInterface(IDMElement, aElement)) then
    aSelectedCollectionNode:=tvDataModel.NodeParent[aNode]
  else
    Exit;

  if (aElement.Ref<>nil) and
     (aElement.DataModel=aElement.Ref.DataModel) and
     (aElement<>aElement.Ref.SpatialElement) then
    aElement:=aElement.Ref;

  if ClearSelectionFlag or
     ((FSelectedCollectionNode<>nil) and
      (aNode.Parent<>FSelectedCollectionNode)) then begin
    aDocument.ClearSelection(aElement);
    FSelectionRangeStart:=-1
  end;

  if not aElement.Selected then
    FSelectedCollectionNode:=aSelectedCollectionNode;

  aElement.Selected:=not aElement.Selected;

  tvDataModel.InvalidateNode(aNode);

  if FCurrentCollection=nil then Exit;
  j:=FCurrentCollection.IndexOf(aElement);
  if j=-1 then Exit;
  if FSelectionRangeStart=-1 then
    FSelectionRangeStart:=j
  else begin
    if (ssShift in FShiftState) then begin
      OldState:=aDataModel.State;
      OldSelectState:=aDataModel.State and dmfSelecting;
      aDataModel.State:=OldState or dmfSelecting;
      try
      if FSelectionRangeStart<j then
        for m:=FSelectionRangeStart+1 to j do begin
          aElement:=FCurrentCollection.Item[m];
          aElement.Selected:=not aElement.Selected;
        end
      else
      if FSelectionRangeStart>j then
        for m:=FSelectionRangeStart-1 downto j do begin
          aElement:=FCurrentCollection.Item[m];
          aElement.Selected:=not aElement.Selected;
        end;
      aElement:=FCurrentCollection.Item[j];
      aElement.Selected:=not aElement.Selected;
      finally
        aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
        Server.SelectionChanged(aElement);
      end;
      if FSelectionRangeStart<>j then
        FSelectionRangeStart:=-1
    end else
      FSelectionRangeStart:=-1
  end;
end;

procedure TDMVBrowser.UnselectAll;
var
  aDocument:IDMDocument;
begin
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  aDocument.ClearSelection(nil);
  tvDataModel.Invalidate;
end;

procedure TDMVBrowser.SelectAll;
var
  j, N, OldState, OldSelectState:integer;
  aDocument:IDMDocument;
  Server:IDataModelServer;
  Node:PVirtualNode;
  Data:pointer;
  aElement:IDMElement;
begin
  if Get_Mode=-1 then Exit;
  if FCurrentCollection=nil then Exit;

  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=Server.CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  OldState:=aDataModel.State;
  OldSelectState:=OldState and dmfSelecting;
  aDataModel.State:=OldState or dmfSelecting;

  try

  aDocument.ClearSelection(nil);
  N:=FCurrentCollection.Count;
  for j:=0 to N-1 do
    FCurrentCollection.Item[j].Selected:=True;
  finally
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
  end;

  Server.SelectionChanged(FCurrentElement);

  Node:=tvDataModel.FocusedNode;
  if Node=nil then Exit;
  Data:=GetNodeData(Node);
  if Succeeded(IUnknown(Data).QueryInterface(IDMElement, aElement)) then
    FSelectedCollectionNode:=Node.Parent
  else
    FSelectedCollectionNode:=Node;
end;

procedure TDMVBrowser.tvDataModelCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  tvDataModel.DeleteChildren(Node, False);
end;

procedure TDMVBrowser.ChangeRef;

  function ExtractLastWord(const S0:string):string;
  var
    S:string;
    L,j:integer;
  begin
    S:=trim(S0);
    L:=length(S);
    j:=Pos(SuffixDivider, S);
    if (j>0) and (L>0) then
      Result:=SuffixDivider+Copy(S, j+1, L-j)
    else
      Result:=''
  end;

var
  aName, S, SS:string;
  aElement, ElementRef:IDMElement;
  SubKinds, TMPCollection:IDMCollection;
  TMPCollection2:IDMCollection2;
  SubKindsFlag:boolean;
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  j:integer;
begin
  if Get_Mode=-1 then Exit;
  if FCurrentElement=nil then Exit;
  if not CheckCurrentElementSeletion then Exit;
  Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;
  DMOperationManager:=Document as IDMOperationManager;

  if fmChangeRef=nil then
    fmChangeRef:=TfmChangeRef.Create(Self);

  if not FCurrentElement.Selected then
    aElement:=FCurrentElement
  else
    aElement:=Document.SelectionItem[Document.SelectionCount-1] as IDMElement;
  if (aElement.Ref<>nil) and
      (aElement.Ref.SpatialElement=aElement) then
    aElement:=aElement.Ref;

  SubKindsFlag:=False;
  if (aElement.Ref<>nil) and
     (aElement.Ref.Parent<>nil) then begin
    SubKinds:=aElement.Ref.Parent.SubKinds;
    if SubKinds<>nil then
      SubKindsFlag:=True;
  end;

  fmChangeRef.DataModel:=Document.DataModel as IDataModel;
  if aElement.Ref<>nil then
    fmChangeRef.Kinds:=aElement.Ref.Parent.OwnerCollection
  else
    fmChangeRef.Kinds:=nil;
  if not SubKindsFlag then
    fmChangeRef.LastKindIndex:=fmChangeRef.edKind.Items.IndexOfObject(pointer(aElement.Ref))
  else begin
    fmChangeRef.LastKindIndex:=fmChangeRef.edKind.Items.IndexOfObject(pointer(aElement.Ref.Parent));
    fmChangeRef.edSubKind.ItemIndex:=fmChangeRef.edSubKind.Items.IndexOfObject(pointer(aElement.Ref));
  end;
  if Document.SelectionCount<=1 then begin
    fmChangeRef.pName.Visible:=True;
    fmChangeRef.edName.Text:=aElement.Name;
    fmChangeRef.Suffix:=' '+ExtractLastWord(aElement.Name);
  end else
    fmChangeRef.pName.Visible:=False;

//  Get_DMEditorX.Say('Изменим тип объекта', True, False);

  if fmChangeRef.ShowModal=mrOK then begin
    ElementRef:=fmChangeRef.ElementSubKind;
    aName:=fmChangeRef.edName.Text;

    if not FCurrentElement.Selected or
        (Document.SelectionCount=1) then begin
      DMOperationManager.StartTransaction(FCurrentCollection, leoChangeRef, rsChangeRef);
      DMOperationManager.ChangeRef(FCurrentCollection,
                       aName, ElementRef, aElement);
      DMOperationManager.FinishTransaction(aElement, FCurrentCollection, leoChangeRef);
    end else begin
      DMOperationManager.StartTransaction(FCurrentCollection, leoChangeRef, rsChangeRef);
      aElement:=nil;
      TMPCollection:=DMOperationManager.SourceCollection as IDMCollection;
      TMPCollection2:=TMPCollection as IDMCollection2;
      TMPCollection2.Clear;
      for j:=0 to Document.SelectionCount-1 do begin
        aElement:=Document.SelectionItem[j] as IDMElement;
        if (aElement.Ref<>nil) and
          (aElement.Ref.SpatialElement=aElement) then
          aElement:=aElement.Ref;
        SS:=ExtractLastWord(aElement.Name);
        if SS<>'' then
          S:=' '+SS
        else
          S:='';
        aName:=aElement.DataModel.GetDefaultName(ElementRef)+S;
        DMOperationManager.ChangeRef(  FCurrentCollection,
                         aName, ElementRef, aElement);
        TMPCollection2.Add(aElement);
      end;
      DMOperationManager.FinishTransaction(TMPCollection, FCurrentCollection, leoChangeRef);
      TMPCollection2.Clear;
    end;
  end;

  fmChangeRef.pName.Visible:=True;
end;


procedure TDMVBrowser.SetOptions;
begin
  if frmDMBrowserOptions=nil then
    frmDMBrowserOptions:=TfrmDMBrowserOptions.Create(Self);
  if frmDMBrowserOptions.ShowModal=mrOK then begin
    HideEmptyCollectionsFlag:=frmDMBrowserOptions.chbHideEmptyCollections.Checked;
    tvDataModel.InvalidateChildren(tvDataModel.FocusedNode, True);
    FDetailMode:=frmDMBrowserOptions.rgDetailMode.ItemIndex;
  end
end;

destructor TDMVBrowser.Destroy;
begin
  inherited;
  FCurrentElement:=nil;
  FCurrentParentElement:=nil;
  FLastElement:=nil;
  FCurrentCollection:=nil;
  FCurrentRefSource:=nil;
  FCurrentClassCollections:=nil;
  FNodeList.Free;
  FDraggingElement:=nil;
  FCurrentObject:=nil;
  FTopObject:=nil;
end;

procedure TDMVBrowser.CustomOperation(Index:Integer);
var
  aElement:IDMElement;
  aElement2:IDMElement2;
  TMPCollection:IDMCollection;
  TMPCollection2:IDMCollection2;
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  j:integer;
  Param1, Param2, Param3:OleVariant;
  OperationName:string;
begin
  if Get_Mode=-1 then Exit;
  Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;
  DMOperationManager:=Document as IDMOperationManager;

  if not FCurrentElement.Selected then
    aElement:=FCurrentElement
  else
    aElement:=Document.SelectionItem[Document.SelectionCount-1] as IDMElement;
  if (aElement.Ref<>nil) and
      (aElement.Ref.SpatialElement=aElement) then
    aElement:=aElement.Ref;

  if aElement.QueryInterface(IDMElement2, aElement2)<>0 then Exit;
  OperationName:=aElement2.GetOperationName(Index);

  Param1:=-1;
  Param2:=-1;
  Param3:=-1;

  if not FCurrentElement.Selected or
      (Document.SelectionCount=1) then begin
    DMOperationManager.StartTransaction(FCurrentCollection,
                                        leoExecute+Index, OperationName);
    aElement2:=aElement as IDMElement2;
    if not aElement2.DoOperation(Index, Param1, Param2, Param3) then
      DMOperationManager.Undo
    else
      DMOperationManager.FinishTransaction(aElement, FCurrentCollection, leoExecute+Index);
  end else begin
    DMOperationManager.StartTransaction(FCurrentCollection,
                                        leoExecute+Index, OperationName);
    aElement:=nil;
    TMPCollection:=DMOperationManager.SourceCollection as IDMCollection;
    TMPCollection2:=TMPCollection as IDMCollection2;
    TMPCollection2.Clear;
    j:=0;
    while j<Document.SelectionCount do begin
      aElement:=Document.SelectionItem[j] as IDMElement;
      if (aElement.Ref<>nil) and
        (aElement.Ref.SpatialElement=aElement) then
        aElement:=aElement.Ref;
      aElement2:=aElement as IDMElement2;
      if not aElement2.DoOperation(Index, Param1, Param2, Param3) then
        Break
      else begin
        inc(j);
        TMPCollection2.Add(aElement);
      end;
    end;
    if j<Document.SelectionCount then
      DMOperationManager.Undo
    else  
      DMOperationManager.FinishTransaction(TMPCollection, FCurrentCollection, leoExecute+Index);
    TMPCollection2.Clear;
  end;
end;

function TDMVBrowser.Get_CurrentElement: IUnknown;
begin
  Result:=FCurrentElement as IUnknown
end;

procedure TDMVBrowser.OpenDocument;
begin
  inherited;
  if (Get_DataModelServer as IDataModelServer).CurrentDocument<>nil then begin
    try
      InitTree;
    except
      raise
    end;
  end else begin
    ClearTree;
  end;
end;

procedure TDMVBrowser.CloseDocument;
begin
  inherited;
  FCurrentElement:=nil;
end;

procedure TDMVBrowser.tvDataModelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FShiftState:=Shift;
  if FEditing then Exit;
  if Shift=[ssCtrl] then
    case Key of
    VK_UP:
       if (FCurrentOperations and leoMove)<>0 then begin
         DoAction(ord(dmbaShiftElementUp));
         Key:=0;
       end;
    VK_DOWN:
       if (FCurrentOperations and leoMove)<>0 then begin
         DoAction(ord(dmbaShiftElementDown));
         Key:=0;
       end;
    VK_INSERT:
       DoAction(ord(dmbaSwitchSelection));
    ord('N'):
       if (FCurrentOperations and leoRename)<>0 then
         DoAction(ord(dmbaRenameElement));
    ord('T'):
       if (FCurrentOperations and leoChangeRef)<>0 then
         DoAction(ord(dmbaChangeRef));
    ord('B'):
       if (FCurrentOperations and leoChangeParent)<>0 then
         DoAction(ord(dmbaChangeParent));
    ord('C'):
       DoAction(ord(dmbaCopy));
    ord('X'):
       DoAction(ord(dmbaCut));
    ord('V'):
       DoAction(ord(dmbaPaste));
    ord('L'):
       DoAction(ord(dmbaGoToLastElement));
    end
  else
    case Key of
    VK_INSERT:
      if Shift=[] then begin
        if (FCurrentOperations and leoAdd)<>0 then
          DoAction(ord(dmbaAddElement))
      end else if Shift=[ssAlt] then begin
         if (FCurrentOperations and leoSelect)<>0 then
          DoAction(ord(dmbaSelectElementFromList));
      end;
    VK_DELETE:
       if (FCurrentOperations and leoDelete)<>0 then
         DoAction(ord(dmbaDeleteElement));
    VK_BACK:
      if Shift=[ssAlt] then
         DoAction(ord(dmbaUndo));
    ord('Z'):
      if Shift=[ssShift, ssCtrl] then
         DoAction(ord(dmbaRedo));
    end;
end;

procedure TDMVBrowser.memCommentChange(Sender: TObject);
var
  aDocument:IDMDocument;
begin
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;
  if FMemoFieldIndex=-1 then Exit;
  if FCurrentElement=nil then Exit;
  FCurrentElement.FieldValue_[FMemoFieldIndex]:=memComment.Lines.Text;
end;

procedure TDMVBrowser.miPopupMenuClick(Sender: TObject);
var
  FormID, j:integer;
begin
  if FEditing then Exit;
  
  FormID:=Get_FormID;
  j:=TMenuItem(Sender).Tag;
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrMenuEvent,
              FormID, 0, meMouseMove, j, 0, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrPause, -1, -1, 1, 500, -1, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrMenuEvent,
              FormID, 0, meLClick, j, 0, '');
  DoAction(j)
end;

function TDMVBrowser.PasteFromBuffer:boolean;
var
  CanPaste:WordBool;
  aDocument:IDMDocument;
begin
  Result:=False;
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;
  (Get_DataModelServer as IDMCopyBuffer).Paste(FCurrentParentElement,
    FCurrentCollection, FCurrentLinkType, True, CanPaste);
  if CanPaste then
    Result:=True
end;

procedure TDMVBrowser.miSwitchSelectionClick(Sender: TObject);
begin
  SwitchSelection(tvDataModel.FocusedNode, False)
end;

procedure TDMVBrowser.miUnselectClick(Sender: TObject);
begin
  UnselectAll;
end;

procedure TDMVBrowser.miSelectAllClick(Sender: TObject);
begin
  SelectAll;
end;

procedure TDMVBrowser.SelectionChanged(DMElement: OleVariant);
var
  Unk:IUnknown;
  aElement, aRef, OldCurrentElement, RootElement, aRootElement:IDMElement;
  aDataModel:IDataModel;
  Node:TTreeNode;
begin
  if Get_ChangingParent then Exit;
  if not Visible then Exit;
  try
  Unk:=DMElement;
  aElement:=Unk as  IDMElement;
  if (aElement<>nil) and
     aElement.Selected then begin
    aRef:=aElement.Ref;
    if (aRef<>nil) and
       (aRef.SpatialElement=aElement) then
      aElement:=aRef;

    if Get_Mode<>-1 then begin
      aDataModel:=GetDataModel;
      aDataModel.BuildGenerations(Get_Mode, aElement);
      if aDataModel.GenerationCount=0 then Exit;
    end;

    Set_CurrentElement(aElement)
  end;
  tvDataModel.Invalidate;
  except
    raise
  end;  
end;

function TDMVBrowser.Get_DetailMode: Integer;
begin
  Result:=FDetailMode
end;

procedure TDMVBrowser.Set_DetailMode(Value: Integer);
begin
  FDetailMode:=Value
end;

procedure TDMVBrowser.Set_Mode(Value: Integer);
begin
  inherited;
  InitTree;
end;

procedure TDMVBrowser.tvDataModelEnter(Sender: TObject);
var
  DMEditorX:IDMEditorX;
begin
  inherited;
  DMEditorX:=Get_DMEditorX;
  if DMEditorX=nil then Exit;
  DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMVBrowser.memCommentEnter(Sender: TObject);
begin
  inherited;
  Get_DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMVBrowser.cbParameterEnter(Sender: TObject);
begin
  inherited;
  Get_DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMVBrowser.cbCategoriesEnter(Sender: TObject);
begin
  inherited;
  Get_DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMVBrowser.sgDetailsExit(Sender: TObject);
var
  Key:Word;
begin
  Key:=VK_Return;
  sgDetailsKeyDown(Sender, Key, []);
end;

procedure TDMVBrowser.ChangeParent;
var
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  m, FormID:integer;
  aElement, SelectedElement:IDMElement;
  Node:PVirtualNode;
  Data:pointer;
  Unk:IUnknown;
begin
  if Get_Mode=-1 then Exit;
  if FCurrentElement=nil then Exit;
  if not CheckCurrentElementSeletion then Exit;
  Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;
  DMOperationManager:=Document as IDMOperationManager;

  if fmSelectFromTree=nil then
    fmSelectFromTree:=TfmSelectFromTree.Create(Self);

  Node:=tvDataModel.GetFirst;
  Data:=GetNodeData(Node);
  Unk:=IUnknown(Data);
  if Unk.QueryInterface(IDMElement, aElement)<>0 then Exit;
  
  fmSelectFromTree.RootElement:=aElement;
  fmSelectFromTree.BuildTree(FCurrentElement);

//  Get_DMEditorX.Say('Изменим иерархический порядок зон', True, False);

  if fmSelectFromTree.ShowModal=mrOK then begin
    aElement:=fmSelectFromTree.CurrentElement;
    if aElement=nil then Exit;
    if aElement.Selected then Exit;

    FormID:=Get_FormID;
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -4, meMouseMove, aElement.ID, aElement.ClassID, '');
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -4, meLClick, aElement.ID, aElement.ClassID, '');
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -4, meLClick, -1, -1, '');

    DMOperationManager.StartTransaction(FCurrentCollection, leoChangeParent, rsChangeParent);
    if Document.SelectionCount>0 then begin
      for m:=0 to Document.SelectionCount-1 do begin
        SelectedElement:=Document.SelectionItem[m] as IDMElement;
        if (SelectedElement.Ref<>nil) and
           (SelectedElement.Ref.SpatialElement=SelectedElement) then
          SelectedElement:=SelectedElement.Ref;
        if aElement<>SelectedElement.Parent then
          DMOperationManager.ChangeParent( FCurrentCollection, aElement, SelectedElement);
      end;
    end else begin
      SelectedElement:=FCurrentElement;
      if (SelectedElement.Ref<>nil) and
         (SelectedElement.Ref.SpatialElement=SelectedElement) then
        SelectedElement:=SelectedElement.Ref;
      if aElement<>SelectedElement.Parent then
        DMOperationManager.ChangeParent( FCurrentCollection, aElement, SelectedElement);
    end;
    DMOperationManager.FinishTransaction(aElement, FCurrentCollection, leoChangeParent);
  end;


end;

procedure TDMVBrowser.sgDetailsTopLeftChanged(Sender: TObject);
var
  j, N:integer;
begin
  inherited;
  N:=sgDetails.LeftCol;
  for j:=1 to N-1 do
    Header.Sections[j].Width:=0;
  for j:=N to Header.Sections.Count-1 do
    Header.Sections[j].Width:=sgDetails.ColWidths[j]+1;
end;

procedure TDMVBrowser.PopupMenuPopup(Sender: TObject);
begin
  SetMenuItems
end;

procedure TDMVBrowser.HeaderMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  j, W, N:integer;
  Field:IDMField;
  Element:IDMElement;
begin
  if (FCurrentCollection=nil) or
     (FCurrentCollection.Count=0) then begin
    Header.ShowHint:=False;
    Exit;
  end;

  Element:=FCurrentCollection.Item[0];
  case FDetailMode of
  dmdTable:
    begin
      Header.ShowHint:=True;
      N:=0;
      W:=Header.Sections[0].Width;
      if X<W then begin
        Header.ShowHint:=False;
        Exit;
      end;
      for j:=0 to Element.FieldCount_-1 do begin
        Field:=Element.Field_[j];
        if Element.FieldIsVisible(Field.Code) and
          (Field.ValueType<>fvtText) then begin
          W:=W+Header.Sections[N+1].Width;
          if X<W then begin
            Header.Hint:=Element.FieldName[j];
            Exit;
          end;
          inc(N);
        end;
      end;
    end;
  else
    Header.ShowHint:=False;
  end;
end;

procedure TDMVBrowser.ShiftElement(Shift: integer);
var
  OperationManager:IDMOperationManager;
  Document:IDMDocument;
  j:integer;
begin
  if FCurrentElement=nil then Exit;
  if FCurrentCollection=nil then Exit;
  if Get_Mode=-1 then Exit;
  Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;
  j:=FCurrentCollection.IndexOf(FCurrentElement);
  if j+Shift<0 then Exit;
  if j+Shift>FCurrentCollection.Count-1 then Exit;
  OperationManager:=Document as IDMOperationManager;
  OperationManager.StartTransaction(FCurrentCollection, leoMove, rsMove);
  OperationManager.MoveElement( FCurrentCollection,
                    FCurrentElement, j+Shift, True);
  OperationManager.FinishTransaction(FCurrentElement, FCurrentCollection, leoMove);

end;

procedure TDMVBrowser.GetTopObject(out CurrentObject: IUnknown; out CurrentObjectExpanded:WordBool;
                           out TopObject: IUnknown);
var
  Node:PVirtualNode;
  Data:pointer;
begin
  CurrentObject:=nil;
  TopObject:=nil;
  FCurrentObjectExpanded:=0;
  CurrentObjectExpanded:=False;
  if Get_Mode=-1 then Exit;

  Node:=tvDataModel.FocusedNode;
  if Node<>nil then begin
    Data:=GetNodeData(Node);
    CurrentObject:=IUnknown(Data);
    CurrentObjectExpanded:=tvDataModel.Expanded[Node];

    Node:=tvDataModel.TopNode;
    TopObject:=IUnknown(Data);
  end;
  FCurrentObject:=CurrentObject;
  if CurrentObjectExpanded then
    FCurrentObjectExpanded:=1
  else
    FCurrentObjectExpanded:=0;
  FTopObject:=TopObject;
end;

procedure TDMVBrowser.SetTopObject(const CurrentObject: IUnknown; CurrentObjectExpanded:WordBool;
                           const TopObject: IUnknown);
var
  aElement:IDMElement;
  aCollection:IDMCollection;
  CurrentNode, aNode:PVirtualNode;
  Found:boolean;
  Data:pointer;
begin
  if Get_Mode=-1 then Exit;
  if CurrentObject=nil then Exit;
  if CurrentObject.QueryInterface(IDMElement, aElement)=0 then begin
    ExpandGenerations(aElement, Found, True);
    aNode:=tvDataModel.FocusedNode;
  end else begin
    aCollection:=CurrentObject as IDMCollection;
    aElement:=aCollection.Parent;
    ExpandGenerations(aElement, Found, True);
    CurrentNode:=tvDataModel.FocusedNode;
    if CurrentNode=nil then Exit;
    aNode:=tvDataModel.GetFirstChild(CurrentNode);
    repeat
      Data:=GetNodeData(aNode);
      if IUnknown(Data)=CurrentObject then
        Break
      else
        aNode:=tvDataModel.GetNextSibling(aNode);
    until aNode=nil;
    if aNode<>nil then
      tvDataModel.FocusedNode:=aNode;
  end;
  if aNode<>nil then
    tvDataModel.Expanded[aNode]:=CurrentObjectExpanded;

  if TopObject=nil then Exit;
  while (aNode<>nil) do begin
    Data:=GetNodeData(aNode);
    if (IUnknown(Data)=TopObject) then
      break
    else
      aNode:=tvDataModel.GetPreviousVisible(aNode);
  end;
  if aNode<>nil then
    tvDataModel.VisiblePath[aNode]:=True
end;

procedure TDMVBrowser.RenameElement;
var
  aDocument:IDMDocument;
  KeyboardState:TKeyboardState;
  Collection:IDMCollection;
  CategoryFlag:boolean;
  Unk:IUnknown;
  Data:pointer;
  MiscOptions:TVTMiscOptions;
begin
  if FCurrentElement=nil then Exit;
  Data:=GetNodeData(tvDataModel.FocusedNode);
  Unk:=IUnknown(Data);
  if Unk=nil then Exit;

  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;

  CategoryFlag:=(Unk.QueryInterface(IDMCollection, Collection)=0);
  if not CategoryFlag then begin
    if (aDataModel.State and dmfDemo)<>0 then begin
      DM_GetKeyboardLayoutName(FOldLayoutName);
      DM_LoadKeyboardLayout('00000419',   //Russion
       KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

      DM_GetKeyboardState(KeyboardState);
      KeyboardState[VK_CAPITAL]:=0;
      DM_SetKeyboardState(KeyboardState);
    end;

    FEditing:=True;
    MiscOptions:=tvDataModel.TreeOptions.MiscOptions;
    Include(MiscOptions, toEditable);
    tvDataModel.TreeOptions.MiscOptions:=MiscOptions;

    tvDataModel.EditNode(tvDataModel.FocusedNode, -1)
  end else begin
    ReplaceDialog1.Options:=ReplaceDialog1.Options +
           [frHideMatchCase, frHideUpDown, frHideWholeWord];
    ReplaceDialog1.Execute;
  end;
end;

procedure TDMVBrowser.ReplaceDialog1Replace(Sender: TObject);
var
  aDocument:IDMDocument;
  OperationManager:IDMOperationManager;
  Collection:IDMCollection;
  Unk:IUnknown;
  j, m:integer;
  ReplaceText, FindText, S, S0, S1, SU:string;
  aElement:IDMElement;
  L, LF:integer;
  SelectedFlag:boolean;
  Data:pointer;
begin
  Data:=GetNodeData(tvDataModel.FocusedNode);
  Unk:=IUnknown(Data);
  if Unk=nil then Exit;
  if (Unk.QueryInterface(IDMCollection, Collection)<>0) then Exit;

  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  OperationManager:=aDocument as IDMOperationManager;

  ReplaceText:=ReplaceDialog1.ReplaceText;
  FindText:=ReplaceDialog1.FindText;
  FindText:=AnsiUppercase(FindText);
  LF:=length(FindText);

  OperationManager.StartTransaction(FCurrentCollection, leoRename, rsRename);

  j:=0;
  while j<Collection.Count do
    if Collection.Item[j].Selected then
      Break
    else
      inc(j);
  SelectedFlag:=j<Collection.Count;

  for j:=0 to Collection.Count-1 do begin
    aElement:=Collection.Item[j];
    if not SelectedFlag or
      aElement.Selected then begin
      S:=aElement.Name;
      SU:=AnsiUppercase(S);
      L:=length(S);
      m:=Pos(FindText, SU);
      if m>0 then begin
        if m>1 then
          S0:=Copy(S, 1, m-1)
        else
          S0:='';
        S1:=Copy(S, m+LF, L-(m+LF)+1);
        S:=S0+ReplaceText+S1;
        OperationManager.RenameElement(aElement, S);
      end;
    end;
  end;
  OperationManager.FinishTransaction(FCurrentCollection, FCurrentCollection, leoRename);
  
  ReplaceDialog1.CloseDialog;
end;


procedure TDMVBrowser.tvDataModelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  aNode:PVirtualNode;
  aElement:IDMElement;
  HitInfo:THitInfo;
  hi:THitPositions;
  Data:pointer;
begin
  if not (ssLeft in Shift) then Exit;
  if tvDataModel.Dragging then Exit;

  aNode:=tvDataModel.FocusedNode;
  if aNode=nil then Exit;
  Data:=GetNodeData(aNode);
  if Data=nil then Exit;
  if IUnknown(Data).QueryInterface(IDMElement, aElement)<>0 then Exit;
  if aElement<>FCurrentElement then Exit;
  if (FCurrentOperations and leoMove)=0 then Exit;
  tvDataModel.GetHitTestInfoAt(X,Y, True, HitInfo);
  hi:=HitInfo.HitPositions;
  if (hiOnNormalIcon in hi) then Exit;
  tvDataModel.BeginDrag(False, 15);
  FDraggingElement:=aElement;
end;

procedure TDMVBrowser.tvDataModelDragOver(Sender: TBaseVirtualTree; Source: TObject;
          Shift: TShiftState; State: TDragState;
          Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  aNode:PVirtualNode;
  aElement:IDMElement;
  Data:pointer;
begin
  Accept:=False;
{
  if (Y<tvDataModel.Top+20) then begin
    tvDataModel.TopItem:=tvDataModel.TopItem.GetPrevVisible;
    tvDataModel.Invalidate;
    Exit
  end;
  if (Y>tvDataModel.Top+tvDataModel.Height-20) then begin
    tvDataModel.TopItem:=tvDataModel.TopItem.GetNextVisible;
    tvDataModel.Invalidate;
    Exit
  end;
}

  aNode:=tvDataModel.DropTargetNode;
  if aNode=nil then Exit;
  Data:=GetNodeData(aNode);
  if Data=nil then Exit;
  if IUnknown(Data).QueryInterface(IDMElement, aElement)<>0 then Exit;
  if aElement=FDraggingElement then Exit;
  if aElement.ClassID<>FDraggingElement.ClassID then Exit;
  if aElement.Parent<>FDraggingElement.Parent then Exit;
  Accept:=True;
end;

procedure TDMVBrowser.tvDataModelDragDrop(Sender: TBaseVirtualTree; Source: TObject;
           DataObject: IDataObject;  Formats: TFormatArray;
           Shift: TShiftState;
           Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  aNode:PVirtualNode;
  aElement:IDMElement;
  j0, j:integer;
  OperationManager:IDMOperationManager;
  Data:pointer;
begin
  aNode:=tvDataModel.DropTargetNode;
  if aNode=nil then Exit;
  Data:=GetNodeData(aNode);
  if Data=nil then Exit;
  if IUnknown(Data).QueryInterface(IDMElement, aElement)<>0 then Exit;
  if aElement=FDraggingElement then Exit;
  if aElement.ClassID<>FDraggingElement.ClassID then Exit;
  if aElement.Parent<>FDraggingElement.Parent then Exit;
  if FCurrentCollection=nil then Exit;
  j0:=FCurrentCollection.IndexOf(FDraggingElement);
  if j0=-1 then Exit;
  j:=FCurrentCollection.IndexOf(aElement);
  if j=-1 then Exit;
  OperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as IDMOperationManager;
  OperationManager.StartTransaction(FCurrentCollection, leoMove, rsMove);
  OperationManager.MoveElement( FCurrentCollection,
                    FDraggingElement, j, True);
  OperationManager.FinishTransaction(FDraggingElement, FCurrentCollection, leoMove);
  FDraggingElement:=nil;
end;

procedure TDMVBrowser.tvDataModelStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  DragObject:=nil;
end;

procedure TDMVBrowser.StopAnalysis(Mode: integer);
begin
  SetDetails;
end;

procedure TDMVBrowser.SetDetailPanels;
begin
  if FCurrentParamKind = pkComment then begin
    pControl.Height:=PanelDetails.Height;
  end else begin
//    pControl.Visible:=False;
    pControl.Height:=0;
//    pTable.Visible:=True;
    sgDetails.Visible:=sgDetails.Cells[0,0]<>'';
    sgDetails.Invalidate;
  end;
end;

procedure TDMVBrowser.TabControl1Change(Sender: TObject);
begin
  if TabControl1.TabIndex=-1 then Exit;
  FCurrentParamKind:=integer(pointer(TabControl1.Tabs.Objects[TabControl1.TabIndex]));
  SetDetailsListKind;
  cbParameter.Visible:=False;
  SetDetailPanels;
end;

procedure TDMVBrowser.RefreshElement(DMElement:OleVariant);
var
  OldRow:integer;
  Element:IDMElement;
  Unk:IUnknown;
begin
  if not Visible then Exit;
  if FRefreshingFlag then Exit;
  Unk:=DMElement;
  Element:=Unk as IDMElement;
  if Element<>FCurrentElement then Exit;
  FRefreshingFlag:=True;
  OldRow:=sgDetails.Row;
  SetDetails;
  tvDataModel.Expanded[tvDataModel.FocusedNode]:=False;
  sgDetails.Row:=OldRow;
  FRefreshingFlag:=False;
end;

procedure TDMVBrowser.RestoreState;
var
  aCurrentObjectExpanded:WordBool;
begin
  if Get_Mode=-1 then Exit;
  if FCurrentObject=nil then Exit;
//  if FTopObject=nil then Exit;
  aCurrentObjectExpanded:=(FCurrentObjectExpanded=1);
  SetTopObject(FCurrentObject, aCurrentObjectExpanded, FTopObject)
end;

procedure TDMVBrowser.SaveState;
var
  aCurrentObjectExpanded:WordBool;
begin
  if Get_Mode=-1 then Exit;
  GetTopObject(FCurrentObject, aCurrentObjectExpanded, FTopObject);
  if aCurrentObjectExpanded then
    FCurrentObjectExpanded:=1
  else
    FCurrentObjectExpanded:=0
end;

procedure TDMVBrowser.GetMacrosNodeID(aNode: PVirtualNode;
                 HT: integer; var ID,YY:integer);
var
  Unk:IUnknown;
  ParentElementNode:PVirtualNode;
  aCollection:IDMCollection;
  aElement:IDMElement;
  ClassID:integer;
  j:integer;
  aNodeParent:PVirtualNode;
  Data:pointer;
begin
  Data:=GetNodeData(aNode);
  Unk:=IUnknown(Data);
  if Unk=nil then Exit;
  YY:=HT;
  if Unk.QueryInterface(IDMCollection, aCollection)=0  then begin
    aNodeParent:=tvDataModel.NodeParent[aNode];
    ParentElementNode:=aNodeParent;
    if ParentElementNode<>nil then begin
      Data:=GetNodeData(ParentElementNode);
      Unk:=IUnknown(Data);
      aElement:=Unk as IDMElement;
    end else
      aElement:=GetDataModel as IDMElement;
    j:=0;
    while j<aElement.CollectionCount do begin
      if aCollection=aElement.Collection[j] then
        Break
      else
        inc(j);
    end;
    YY:=YY+((j+1) shl 8);
  end else
    aElement:=Unk as IDMElement;
  ClassID:=aElement.ClassID;
  YY:=YY+(ClassID shl 16);
  ID:=aElement.ID;
end;

procedure TDMVBrowser.InitNodeClickMacros(aNode: PVirtualNode; HT: integer);
var
  ID:integer;
  DMEditor:IDMEditorX;
  DMMacrosManager:IDMMacrosManager;
  FormID, YY:integer;
begin
  DMEditor:=Get_DMEditorX;
  DMMacrosManager:=DMEditor as IDMMacrosManager;
  if not DMMacrosManager.IsWritingMacros then Exit;

  GetMacrosNodeID(aNode, HT, ID, YY);

  FormID:=Get_FormID;
  DMMacrosManager.WriteMacrosEvent(mrFormEvent,
              FormID, -1, meMouseMove, ID, YY, '');
  DMMacrosManager.WriteMacrosEvent(mrPause,
              -1, -1, 1, 500, -1, '');
  DMMacrosManager.WriteMacrosEvent(mrFormEvent,
              FormID, -1, meLClick, ID, YY, '')
end;

function TDMVBrowser.DoMacrosStep(RecordKind, ControlID, EventID, X, Y: Integer;
  const S: WideString):WordBool;
var
  DMMacrosManager:IDMMacrosManager;
  CursorStepLength, ClassID, ID, YY, HT, CollectionID, H, j, m:integer;
  P, PS:TPoint;
  aElement, DataModelE:IDMElement;
  Found:boolean;
  HitTest:THitTest;
  ShiftState:TShiftState;
  Node, PrevNode:PVirtualNode;
  R, RPrev:TRect;
  aX, aY, aTag:integer;

  function GetVTreeNode:PVirtualNode;
  var
    j:integer;
    Node:PVirtualNode;
  begin
    ID:=ord(X);
    YY:=ord(Y);
    HT:=YY and $FF;
    CollectionID:=((YY shr 8) and $FF)-1;
    ClassID:=(YY shr 16) and $FF;
    aElement:=DataModelE.Collection[ClassID].Item[ID];

    Result:=ExpandGenerations(aElement, Found, False);

    if CollectionID<>-1 then begin
      Node:=tvDataModel.GetFirstChild(Result);
      j:=0;
      while Node<>nil do begin
        if j=CollectionID then
          break
        else begin
          inc(j);
          Node:=tvDataModel.GetNextSibling(Node);
        end;
      end;
      if Node<>nil then begin
        Result:=Node;
        tvDataModel.VisiblePath[Result]:=True;
      end;
    end;

  end;

  procedure GetMenuItemPoint(aPopupMenu:TPopupMenu; aTag:integer; var aX, aY:integer);
  var
    j, m:integer;
    HW:HWnd;
    HM:HMenu;
    Item:TMenuItem;
    R:TRect;
    P, PP:TPoint;
    Ymin, Ymax:integer;
    MenuItemCount:integer;
    NodeParent:PVirtualNode;
  begin
    HW:=Handle;
    HM:=aPopupMenu.Handle;
    PP:=aPopupMenu.PopupPoint;
    Item:=nil;
    m:=0;
    while m<aPopupMenu.Items.Count do begin
      Item:=aPopupMenu.Items[m];
      if Item.Tag=aTag then
        Break
      else
        inc(m)
    end;

    if m<aPopupMenu.Items.Count then begin
      MenuItemCount:=DM_GetMenuItemCount(HM);
      j:=0;
      while j<MenuItemCount do begin
        if DM_GetMenuItemID(HM, j)=Item.Command then
          Break
        else
          inc(j);
      end;

      DM_GetMenuItemRect(HW, HM, j, R);
      P.X:=(R.Left+R.Right) div 3;
      P.Y:=(R.Top+R.Bottom) div 2;
      P:=ScreenToClient(P);

      DM_GetMenuItemRect(HW, HM, 0, R);
      Ymin:=R.Top;
      DM_GetMenuItemRect(HW, HM, MenuItemCount-1, R);
      Ymax:=R.Bottom;
      if PP.Y+(Ymax-Ymin)<Screen.DesktopHeight then begin
        aX:=PP.X+P.X;
        aY:=PP.Y+P.Y;
      end else begin

        aX:=PP.X+P.X;
        if (Win32Platform = VER_PLATFORM_WIN32_NT)and
           (Win32MajorVersion <= 4) then begin
          aY:=Screen.DesktopHeight+P.Y-Ymax+Ymin;
        end else
          aY:=PP.Y+P.Y-Ymax+Ymin;
      end;
    end;
  end;

  function GetListItemIndex(ListBox:TListBox; ID:integer):integer;
  var
    j:integer;
  begin
    j:=0;
    while j<ListBox.Items.Count do begin
      aElement:=IDMElement(pointer(ListBox.Items.Objects[j]));
      if aElement.ID=ID then
        Break
      else
        inc(j)
    end;
    if j<ListBox.Items.Count then
      Result:=j
    else
      Result:=-1;
  end;

  procedure GetListItemPoint(ListBox:TListBox; ID:integer; var aX, aY:integer);
  var
    j:integer;
    R:TRect;
    P:TPoint;
  begin
    j:=GetListItemIndex(ListBox, ID);
    if j<ListBox.Items.Count then begin
      R:=ListBox.ItemRect(j);
      P.X:=(R.Left+R.Right) div 2;
      P.Y:=(R.Top+R.Bottom) div 2;
      P:=ListBox.ClientToScreen(P);
      aX:=P.X;
      aY:=P.Y;
    end;
  end;

var
  TreeNode:TTreeNode;
begin
  Result:=inherited DoMacrosStep(RecordKind, ControlID, EventID, X, Y, S);

  DMMacrosManager:=Get_DMEditorX as IDMMacrosManager;
  DataModelE:=GetDataModel as IDMElement;
  CursorStepLength:=16;

  case RecordKind of
  mrMenuEvent:
    begin
      case FMacrosEventID of
      meLClick:
        begin
          aTag:=round(FMacrosX);
          DMMacrosManager.PauseMacros(500);
          DoAction(aTag);
        end;
      meMouseMove:
        begin
          aTag:=round(X);
          GetMenuItemPoint(PopupMenu, aTag, aX, aY);
          Result:=False;
          DMMacrosManager.StartMacrosStep(aX, aY, CursorStepLength);
        end;
      end;
    end;
  mrFormEvent:
    if FMacrosControlID=-1 then begin
      FMacrosControl:=tvDataModel;

      HT:=round(FMacrosY) and $FF;
      if (HT and 32)<>0 then
        HitTest:=htOnItem
      else
      if (HT and 64)<>0 then
        HitTest:=htOnIcon
      else
      if (HT and 128)<>0 then
        HitTest:=htOnButton
      else
        HitTest:=htOnItem;

      ShiftState:=[];
      if (ht and 1)<>0 then
        ShiftState:=ShiftState+[ssShift];
      if (ht and 2)<>0 then
        ShiftState:=ShiftState+[ssAlt];
      if (ht and 4)<>0 then
        ShiftState:=ShiftState+[ssCtrl];
      if (ht and 16)<>0 then
        ShiftState:=ShiftState+[ssRight];

      DM_GetCursorPos(PS);
      P:=FMacrosControl.ScreenToClient(PS);

      case FMacrosEventID of
      meLClick:
        begin
          Node:=GetVTreeNode;
          if HitTest=htOnIcon then begin
            R:=tvDataModel.GetDisplayRect(Node, -1, True, False);
            PrevNode:=tvDataModel.NodeParent[Node];
            RPrev:=tvDataModel.GetDisplayRect(PrevNode, -1, True, False);
            P.X:=RPrev.Left+5;
            P.Y:=(R.Top+R.Bottom) div 2;
            tvDataModelMouseDown(tvDataModel, mbLeft, ShiftState, P.X, P.Y);
          end else begin
            tvDataModel.FocusedNode:=Node;
          end;
//          DMMacrosManager.PauseMacros(500);
        end;
      meRClick:
        begin
          Node:=GetVTreeNode;
          R:=tvDataModel.GetDisplayRect(Node, -1, True, False);
          P.X:=(R.Left+R.Right) div 2;
          P.Y:=(R.Top+R.Bottom) div 2;
          P:=FMacrosControl.ClientToScreen(P);
          Result:=False;
          DMMacrosManager.PauseMacros(500);
          PopupMenu.Popup(P.X, P.Y);
        end;
      meDoubleClick:
        begin
          Node:=GetVTreeNode;
          tvDataModel.Expanded[Node]:=True;
        end;
      meMouseMove:
        begin
          Node:=GetVTreeNode;

          R:=tvDataModel.GetDisplayRect(Node, -1, True, False);
          case HitTest of
          htOnItem:
            begin
              P.X:=(R.Left+R.Right) div 2;
              P.Y:=(R.Top+R.Bottom) div 2;
            end;
          htOnIcon:
            begin
              PrevNode:=tvDataModel.NodeParent[Node];
              RPrev:=tvDataModel.GetDisplayRect(PrevNode, -1, True, False);
              P.X:=RPrev.Left+5;
              P.Y:=(R.Top+R.Bottom) div 2;
            end;
          htOnButton:
            begin
              PrevNode:=tvDataModel.NodeParent[Node];
              RPrev:=tvDataModel.GetDisplayRect(PrevNode, -1, True, False);
              P.X:=(R.Left+RPrev.Left) div 2;
              P.Y:=(R.Top+R.Bottom) div 2;
            end;
          end;
          P:=FMacrosControl.ClientToScreen(P);
          Result:=False;
          DMMacrosManager.StartMacrosStep(P.X, P.Y, CursorStepLength);
        end;
      end; // case FFMacrosEventID
    end else
    if FMacrosControlID=-3 then begin
      case FMacrosEventID of
      meLClick:
        case Y of
        -1:begin
            H:=dlgDualList.OKBtn.Handle;
            DM_SendMessage(H, WM_LButtonDown, 0, 0);
            DM_SendMessage(H, WM_LButtonUp, 0, 0);
          end;
        0:begin
            j:=GetListItemIndex(dlgDualList.SrcList, X);
            dlgDualList.SrcList.ItemIndex:=j;
            for m:=0 to dlgDualList.SrcList.Count-1 do
              dlgDualList.SrcList.Selected[m]:=(m=j)
          end;
        1:begin
            dlgDualList.IncludeBtn.Down:=True;
            dlgDualList.IncludeBtn.Click;
          end;
        2:begin
            j:=GetListItemIndex(dlgDualList.DstList, X);
            dlgDualList.DstList.ItemIndex:=j;
            for m:=0 to dlgDualList.DstList.Count-1 do
              dlgDualList.DstList.Selected[m]:=(m=j)
          end;
        3:begin
            dlgDualList.ExcludeBtn.Down:=True;
            dlgDualList.ExcludeBtn.Click;
          end;
        end;
      meMouseMove:
        begin
          Result:=False;
          case Y of
          0:GetListItemPoint(dlgDualList.SrcList, X, P.X, P.Y);
          1:begin
              R:=dlgDualList.IncludeBtn.ClientRect;
              P.X:=(R.Left+R.Right) div 2;
              P.Y:=(R.Top+R.Bottom) div 2;
              P:=dlgDualList.IncludeBtn.ClientToScreen(P);
            end;
          2:GetListItemPoint(dlgDualList.DstList, X, P.X, P.Y);
          3:begin
              R:=dlgDualList.ExcludeBtn.ClientRect;
              P.X:=(R.Left+R.Right) div 2;
              P.Y:=(R.Top+R.Bottom) div 2;
              P:=dlgDualList.IncludeBtn.ClientToScreen(P);
            end;
          end;
          DMMacrosManager.StartMacrosStep(P.X, P.Y, CursorStepLength);
        end;
      end;
    end else
    if FMacrosControlID=-4 then begin
      if Y<>-1 then begin
        ID:=ord(X);
        ClassID:=ord(Y);
        aElement:=DataModelE.Collection[ClassID].Item[ID];
        j:=0;
        Node:=nil;
        while j<fmSelectFromTree.tvDataModel.Items.Count do begin
          TreeNode:=fmSelectFromTree.tvDataModel.Items[j];
          if IDMElement(TreeNode.Data)=aElement then
            Break
          else
            inc(j);
        end;
      end;

      case FMacrosEventID of
      meLClick:
        if Y=-1 then begin
          H:=fmSelectFromTree.btOK.Handle;
          DM_SendMessage(H, WM_LButtonDown, 0, 0);
          DM_SendMessage(H, WM_LButtonUp, 0, 0);
        end else begin
          fmSelectFromTree.tvDataModel.Selected:=TreeNode;
          DMMacrosManager.PauseMacros(500);
        end;
      meMouseMove:
        begin
          TreeNode.MakeVisible;
          R:=TreeNode.DisplayRect(True);
          P.X:=(R.Left+R.Right) div 2;
          P.Y:=(R.Top+R.Bottom) div 2;
          P:=fmSelectFromTree.tvDataModel.ClientToScreen(P);
          Result:=False;
          DMMacrosManager.StartMacrosStep(P.X, P.Y, CursorStepLength);
        end;
      end;
    end;
  end; // case RecordKind of
end;

procedure TDMVBrowser.tvDataModelDblClick(Sender: TObject);
var
  FormID:integer;
begin
  FormID:=Get_FormID;
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
            FormID, -1, meDoubleClick, 0, 0, '')
end;

constructor TDMVBrowser.Create(aOwner: TComponent);
begin
  inherited;
  tvDataModel:=TVirtualStringTree.Create(Self);
  tvDataModel.Parent:=Self;
  with tvDataModel do begin
    Left:=0;
    Top:=0;
    Width:=300;
    Height:=354;
    Align:=alClient;
    TabOrder:=0;

    Images:=ilNodes;
    Indent:=19;

    PopupMenu:=Self.PopupMenu;

    OnGetNodeDataSize:=tvDataModelGetNodeDataSize;
    OnInitNode:=tvDataModelInitNode;
    OnFreeNode:=tvDataModelFreeNode;
    OnInitChildren:=tvDataModelInitChildren;
    OnGetText:=tvDataModelGetText;
    OnPaintText:=tvDataModelPaintText;
    OnGetImageIndex:=tvDataModelGetImageIndex;
    OnFocusChanged:=tvDataModelFocusChanged;
    OnCollapsed:=tvDataModelCollapsed;

    OnDblClick:=tvDataModelDblClick;
    OnMouseDown:=tvDataModelMouseDown;

    OnDragDrop:=tvDataModelDragDrop;
    OnDragOver:=tvDataModelDragOver;
    OnEdited:=tvDataModelEdited;
    OnNewText:=tvDataModelNewText;
    OnEnter:=tvDataModelEnter;
    OnKeyDown:=tvDataModelKeyDown;
    OnMouseMove:=tvDataModelMouseMove;
    OnStartDrag:=tvDataModelStartDrag;
  end;

  tvDataModel.RootNodeCount:=0;
end;

procedure TDMVBrowser.FormShow(Sender: TObject);
begin
  inherited;
  if FSizeSetted then Exit;
  TabControl1.Width:=Width div 2;
  FSizeSetted:=True;
end;

procedure TDMVBrowser.FormResize(Sender: TObject);
begin
  inherited;
  SetDetailPanels;
end;

procedure TDMVBrowser.tvDataModelGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data:pointer;
  Unk, RootObject:IUnknown;
  Element:IDMElement;
  Collection, aCollection, aRefSource:IDMCollection;
  aClassCollection:IDMClassCollections;
  ParentNode:PVirtualNode;
  j, aOperations, aLinkType, Mode:integer;
  CollectionName, RootObjectName:WideString;
  aDataModel:IDataModel;
begin
  try
  Data:=GetNodeData(Node);
  Unk:=IUnknown(Data);
  if Sender.GetNodeLevel(Node)=0 then begin
    aDataModel:=GetDataModel;
    if aDataModel=nil then
      CellText:=''
    else begin
      Mode:=Get_Mode;
      j:=Node.Index;
      aDataModel.GetRootObject(Mode, j, RootObject,
                            RootObjectName, aOperations, aLinkType);
      CellText:=RootObjectName;
    end;
  end else
  if Unk=nil then
    CellText:='Error: No data'
  else
  if Unk.QueryInterface(IDMElement, Element)=0 then
    CellText:=Element.Name
  else
  if Unk.QueryInterface(IDMCollection, Collection)=0 then begin
    ParentNode:=Sender.NodeParent[Node];
    Data:=GetNodeData(ParentNode);
    Unk:=IUnknown(Data);
    Element:=Unk as IDMElement;
    if Element.DataModel=nil then
      Exit;
    j:=0;
    while j<Element.CollectionCount do begin
      aCollection:=Element.Collection[j];
      if aCollection=Collection then
        break
      else
        inc(j)
    end;
    if j<Element.CollectionCount then begin
      Element.GetCollectionProperties(j, CollectionName,
          aRefSource, aClassCollection, aOperations, aLinkType);
      CellText:=CollectionName
    end else
      CellText:='Error: No collection'
  end else
    CellText:='Error: Unknown data'
  except
    raise
  end;
end;

procedure TDMVBrowser.tvDataModelGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize:=SizeOf(TNodeDataRecord)
end;

procedure TDMVBrowser.tvDataModelInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  ParentData, Data:pointer;
  Unk, RootObject:IUnknown;
  Element, DataModelE:IDMElement;
  Collection:IDMCollection;
  j, Mode,Operations, LinkType:integer;
  aDataModel:IDataModel;
  RootObjectName:WideString;
  NodeDataRecord:PNodeDataRecord;
begin
  j:=Node.Index;
  NodeDataRecord:=Sender.GetNodeData(Node);
  if Sender.GetNodeLevel(Node)=0 then begin

    aDataModel:=GetDataModel;
    Mode:=Get_Mode;
    aDataModel.GetRootObject(Mode, j, RootObject,
                            RootObjectName, Operations, LinkType);
    NodeDataRecord.Data:=pointer(RootObject);
    if RootObject<>nil then
      RootObject._AddRef;

    if j=0 then
      InitialStates := InitialStates + [ivsExpanded];
    InitialStates := InitialStates + [ivsHasChildren];
  end else begin
    ParentData:=GetNodeData(ParentNode);
    Unk:=IUnknown(ParentData);
    if Unk.QueryInterface(IDMElement, Element)=0 then begin
      Collection:=Element.Collection[j];
      NodeDataRecord.Data:=pointer(Collection);
      Collection._AddRef;
      if Collection.Count>0 then
        InitialStates := InitialStates + [ivsHasChildren];
    end else
    if Unk.QueryInterface(IDMCollection, Collection)=0 then begin
      Element:=Collection.Item[j];
      NodeDataRecord.Data:=pointer(Element);
      Element._AddRef;
      if Element.CollectionCount>0 then
        InitialStates := InitialStates + [ivsHasChildren];
    end else
      NodeDataRecord.Data:=nil; // такого не должно быть
  end;
end;

procedure TDMVBrowser.tvDataModelInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
var
  Data:pointer;
  Unk:IUnknown;
  Element:IDMElement;
  Collection:IDMCollection;
  j:integer;
begin
  Data:=GetNodeData(Node);
  Unk:=IUnknown(Data);
  if Unk.QueryInterface(IDMElement, Element)=0 then begin
    ChildCount:=Element.CollectionCount;
  end else
  if Unk.QueryInterface(IDMCollection, Collection)=0 then begin
    ChildCount:=Collection.Count;
  end;
end;

function TDMVBrowser.GetNodeData(Node: PVirtualNode): pointer;
var
  NodeDataRecord:PNodeDataRecord;
begin
  if Node<>nil then begin
    NodeDataRecord:=tvDataModel.GetNodeData(Node);
    Result:=NodeDataRecord.Data;
  end else
    Result:=nil;
end;

procedure TDMVBrowser.miSelectFieldElementClick(Sender: TObject);
var
  aElement, theElement:IDMElement;
  V:Variant;
  Unk:IUnknown;
begin
  if FDetailMode=dmdList then begin
    if FCurrentElement=nil then Exit;
    aElement:=FCurrentElement;
  end else begin
    if sgDetails.Col<>0 then begin
      if FCurrentCollection=nil then Exit;
      if FCurrentCollection.Count=0 then Exit;
      aElement:=IDMElement(pointer(sgDetails.Objects[0, sgDetails.Row]));
    end else
      aElement:=nil;
  end;
  if aElement=nil then Exit;

  V:=aElement.FieldValue_[FCurrentFieldIndex];
  Unk:=V;
  theElement:=Unk as IDMELement;
  theElement.Selected:=True;
end;

procedure TDMVBrowser.sgDetailsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aElement:IDMElement;
  P:TPoint;
begin
  if not (ssRight in Shift) then Exit;
  if FDetailMode=dmdList then begin
    if FCurrentElement=nil then Exit;
    aElement:=FCurrentElement;
  end else begin
    if sgDetails.Col<>0 then begin
      if FCurrentCollection=nil then Exit;
      if FCurrentCollection.Count=0 then Exit;
      aElement:=IDMElement(pointer(sgDetails.Objects[0, sgDetails.Row]));
    end else
      aElement:=nil;
  end;
  if aElement=nil then Exit;

  if aElement.Field_[FCurrentFieldIndex].ValueType=fvtElement then begin
    P.X:=X;
    P.Y:=Y;
    P:=sgDetails.ClientToScreen(P);
    PopupMenu1.Popup(P.X, P.Y);
  end;
end;

procedure TDMVBrowser.tvDataModelNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  aElement:IDMElement;
  OperationManager:IDMOperationManager;
  aDocument:IDMDocument;
  Data:pointer;
  MiscOptions:TVTMiscOptions;
  S:WideString;
begin
  Data:=GetNodeData(Node);
  aElement:=IUnknown(Data) as IDMElement;
  if aElement=nil then Exit;

  MiscOptions:=tvDataModel.TreeOptions.MiscOptions;
  Exclude(MiscOptions, toEditable);
  tvDataModel.TreeOptions.MiscOptions:=MiscOptions;

  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  OperationManager:=aDocument as IDMOperationManager;
  OperationManager.StartTransaction(FCurrentCollection, leoRename, rsRename);
  S:=NewText;
  OperationManager.RenameElement( aElement, S);
  OperationManager.FinishTransaction(aElement, FCurrentCollection, leoRename);

  if (aDataModel.State and dmfDemo)<>0 then begin
    DM_LoadKeyboardLayout(FOldLayoutName,
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;
end;

function TDMVBrowser.CheckCurrentElementSeletion: boolean;
var
  Document:IDMDocument;
  Server:IDataModelServer;
begin
  Result:=False;
  if FCurrentElement=nil then begin
    Result:=True;
    Exit;
  end;
  Server:=Get_DataModelServer as IDataModelServer;
  Document:=Server.CurrentDocument;
  if Document=nil then Exit;
  if (Document.SelectionCount>1) and
     (not FCurrentElement.Selected) then begin
     Server.CallDialog(sdmShowMessage, 'Спрут-ИСТА', 'Текущий элемент не выделен.'#13+
                      'Выделите его или снимите выделение с других элементов.');
     Exit;
  end;
  Result:=True;
end;

procedure TDMVBrowser.UpdateCurrentElement;
var
  Unk:IUnknown;
  aElement:IDMElement;
  Data:pointer;
begin
  Data:=GetNodeData(tvDataModel.FocusedNode);
  Unk:=IUnknown(Data);
  if Unk.QueryInterface(IDMElement, aElement)<>0 then
    aElement:=nil;
  Set_CurrentElement(aElement);
end;

end.
