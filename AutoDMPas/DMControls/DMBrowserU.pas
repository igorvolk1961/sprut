unit DMBrowserU;

{$WARN SYMBOL_PLATFORM OFF}

interface

//{$INCLUDE SprutikDef.inc}

uses
  DM_Windows, DM_Messages, Types,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, StdVcl, ImgList, Menus, Printers,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU, 
  ComCtrls, MyComCtrls, DMUtils;

const
  pkComment = $00000008;
  dmdList = $00000000;
  dmdTable = $00000001;
const
  SuffixDivider='/';

type
  TDMBrowser = class(TDMPage, ITreeViewForm)
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
    miColOperation: TMenuItem;

    procedure miPopupMenuClick(Sender: TObject);

    procedure tvDataModelChange(Sender: TObject; Node: TTreeNode);
    procedure tvDataModelCollapsed(Sender: TObject; Node: TTreeNode);
    procedure tvDataModelCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tvDataModelDeletion(Sender: TObject; Node: TTreeNode);
    procedure tvDataModelEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure tvDataModelExpanded(Sender: TObject; Node: TTreeNode);
    procedure tvDataModelGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvDataModelGetSelectedIndex(Sender: TObject;
      Node: TTreeNode);
    procedure tvDataModelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

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

    procedure tvDataModelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miSwitchSelectionClick(Sender: TObject);
    procedure miUnselectClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure tvDataModelEnter(Sender: TObject);
    procedure memCommentEnter(Sender: TObject);
    procedure cbParameterEnter(Sender: TObject);
    procedure cbCategoriesEnter(Sender: TObject);
    procedure sgDetailsTopLeftChanged(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure HeaderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure tvDataModelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure tvDataModelDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvDataModelDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvDataModelStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TabControl1Change(Sender: TObject);
    procedure tvDataModelDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    procedure sgDetailsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miSelectFieldElementClick(Sender: TObject);
    procedure memCommentExit(Sender: TObject);
    procedure memCommentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgDetailsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure miGoToLastElementClick(Sender: TObject);
  private

  protected
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
    FCurrentCollectionIndex:integer;
    FCurrentRefSource:IDMCollection;
    FCurrentClassCollections:IDMClassCollections;
    FCurrentOperations:integer;
    FCurrentLinkType:integer;
    FCurrentFieldIndex:integer;
    FCurrentParamKind:integer;
    FIsControlForm:boolean;
    FSelectedCollectionNode:TTreeNode;
    FNodeList:TList;
    FMemoFieldIndex:integer;
    FCurrentClassID:integer;

    FDetailMode:integer;
    FEditing:boolean;
    FOldLayoutName:array [0..255] of char;
    FDraggingElement:IDMElement;
    FShiftState:TShiftState;
    FSelectionRangeStart:integer;


    tvDataModel:TTreeView;


//    FEvents: IDMBrowserXEvents;

//    procedure ActivateEvent(Sender: TObject);

    procedure AddElement;
    procedure RenameElement;
    procedure ChangeRef;
    procedure ChangeParent;
    procedure CustomOperation(Index:Integer);

    procedure DeleteElement;
    function ExpandGenerations(const theElement:IDMElement; var Found:boolean;
                               DoSelect:boolean):TTreeNode;
    procedure ShiftElement(Shift:integer);

    function GetDetailCellHeight(S0: string; DrawFlag: boolean; WW, HH,
      LL: integer; R:TRect): integer;
    procedure GoToLastElement;
    procedure InitTree;
    procedure MakeRootNodes; virtual;
    procedure MakeNodeChilds(ParentNode: TTreeNode; ClearFirst:boolean); virtual;
    procedure SelectAll;
    procedure SelectElementFromList;
    procedure SetColWidths(W0: double);
    procedure SetDetailMode(const Value: integer);
    procedure SetDetails;
    procedure SetDetailsElements(Elements: IDMCollection);
    procedure SetDetailsList;
    procedure SetHideEmptyCollectionsFlag(const Value: boolean);
    procedure SetItemBold(ANode: TTreeNode; Value: Boolean);
    procedure SetMenuItems; virtual;
    procedure SetOptions;
    procedure SwitchSelection(aNode: TTreeNode; ClearSelectionFlag:boolean);
    procedure UpdateTree(nItemIndex: integer; CollectionNode: TTreeNode; ClearFirst:boolean);
    procedure SetCurrentOptions;
    procedure SetDetailsListKind;
    procedure InitNodeClickMacros(aNode:TTreeNode; HT:integer);
    procedure GetMacrosNodeID(aNode: TTreeNode; HT: integer; var ID, YY: integer);
    procedure SetDetailPanels;
    procedure SetDetailsCell(ACol, ARow: Integer);
    procedure ChangeDetailsFont(const Element: IDMElement;
                                const Field: IDMField;
                                ACol, ARow:integer);
    procedure SetFieldValue(const V:Variant; const aElement:IDMElement);

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

{$IFDEF Demo}
    function DoMacrosStep(RecordKind, ControlID: Integer; EventID: Integer;
                  X: Integer; Y: Integer; const S:WideString):WordBool; override; safecall;
{$ENDIF}

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

    procedure ClearTree;
    procedure ClearTreeData;
  public
    constructor Create(aOwner:TComponent); override;
    procedure Initialize; override;
    destructor Destroy; override;
    function DoAction(ActionCode: integer):WordBool; override; safecall;
  end;

var
  DMBrowser: TDMBrowser;
const
  InfinitValue=1000000000;

implementation
uses
  DMBrowserConstU,
  DualListDlg1, ChangeRefFrm, DMBrowserOptions,
  SelectFromTreeFrm;

{$R *.dfm}

procedure TDMBrowser.Initialize;
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

procedure TDMBrowser.SetColWidths(W0:double);
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

procedure TDMBrowser.tvDataModelGetImageIndex(Sender: TObject;
  Node: TTreeNode);
var
  aElement:IDMElement;
begin
//  if csDesigning in Application.MainForm.ComponentState then Exit;

  try
  with Node do begin

    if Data=nil then
      ImageIndex := -1
    else
    if Succeeded(IUnknown(Data).QueryInterface(IDMElement, aElement)) then begin
      if aElement.Selected then
         ImageIndex := 1
      else
      if aElement.SelectRef and
        (FCurrentLinkType<>ltBackRefs) and
         aElement.Ref.Selected then
         ImageIndex := 1
      else
        ImageIndex := 0
    end else
      ImageIndex := -1;
  end;
  except
    raise
  end;
end;

procedure TDMBrowser.tvDataModelChange(Sender: TObject; Node: TTreeNode);
var
  j:integer;
  Unk:IUnknown;
  aElement:IDMElement;
  ParentElementNode, ParentNode:TTreeNode;
  aDocument:IDMDocument;
  CanPaste:WordBool;
  OwnerCollection:IDMCollection;
  CanHaveFields:boolean;
begin
  if Get_ChangingParent then Exit;
  if FExpandingGenerationsFlag then Exit;
  if FClearTreeFlag then Exit;
  if FChangingTreeNodeFlag then Exit;

  if (Sender<>nil) and
      Visible then
    Get_DMEditorX.ActiveForm:=Self as IDMForm;

  FEditing:=False;
  tvDataModel.ReadOnly:=True;

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
  with Node do begin
      Unk:=nil;
      Set_CurrentElement(Unk);
      Unk:=IUnknown(Data);
      if Unk=nil then Exit;
      if Unk.QueryInterface(IDMCollection, FCurrentCollection)=0  then begin
        FCurrentCollectionIndex:=Node.Index;
        ParentElementNode:=Node.Parent;
        SetDetailMode(dmdTable);
        SetColWidths(0.3);
        if Unk.QueryInterface(IDMElement, FCurrentElement)=0 then // возможно одновременное использование
                                                          // обоих интерфейсов
          CanHaveFields:=FCurrentCollection.HasFields
        else
          CanHaveFields:=False;
      end else
        CanHaveFields:=True;

      if CanHaveFields and
         (Unk.QueryInterface(IDMElement, aElement)=0) then begin
        FCurrentCollectionIndex:=-1;
        if not aElement.Exists then begin
          Node.Parent.Collapse(True);
          Exit;
        end;
        OwnerCollection:=aElement.OwnerCollection;
        if (Node.Parent<>nil) and
           (OwnerCollection<>nil) and
           (OwnerCollection.IndexOf(aElement)=-1) then begin
          FChangingTreeNodeFlag:=False;
//          Unk._Release;
//          Node.Delete;
//          Exit;
        end;
        FDetailMode:=dmdList;
        Unk:=aElement as IUnknown;
        Set_CurrentElement(Unk);
        ParentNode:=Node.Parent;
        if ParentNode<>nil then
          ParentElementNode:=ParentNode.Parent
        else
          ParentElementNode:=nil;
        if ParentNode<>nil then begin
          Unk:=IUnknown(ParentNode.Data);
          if Unk<>nil then begin
            Unk.QueryInterface(IDMCollection, FCurrentCollection);
          end;
        end else begin
          FCurrentCollection:=nil;
        end;
        SetDetails;
      end;
  end;

  cbParameter.Visible:=False;
  sgDetails.Visible:=sgDetails.Cells[0,0]<>'';

  if ParentElementNode<>nil then
    IUnknown(ParentElementNode.Data).QueryInterface(IDMElement, FCurrentParentElement)
  else begin
     aDocument:=GetDocument;
     FCurrentParentElement:=GetDataModel as IDMElement;
  end;

  if FCurrentParentElement<>nil then begin
    SetCurrentOptions;

    (Get_DataModelServer as IDMCopyBuffer).Paste(FCurrentParentElement,
      FCurrentCollection, FCurrentLinkType, False, CanPaste);
  end;

  MakeNodeChilds(Node, False);

  SetMenuItems;

 (Get_DataModelServer as IDataModelServer).ChangeCurrentObject(FCurrentElement,
                                                              Self as IUnknown);

  finally
    FChangingTreeNodeFlag:=False;
  end;

end;

procedure TDMBrowser.MakeNodeChilds(ParentNode: TTreeNode; ClearFirst:boolean);
var
  j, CollectionCount: integer;
  Collection:IDMCollection;
  CollectionName:WideString;
  Element:IDMElement;
  Unk, aUnk:IUnknown;
  S:string;

  aCurrentRefSource:IDMCollection;
  aCurrentClassCollections:IDMClassCollections;
  aCurrentOperations:integer;
  aCurrentLinkType:integer;
  aChildNode, aTreeNode:TTreeNode;
  DataModel:IDataModel;
  aElement:IDMElement;
begin
  DataModel:=GetDataModel;
  Cursor := crHourGlass;
  tvDataModel.Selected := ParentNode;
  if ParentNode=nil then Exit;
  if ParentNode.Data=nil then Exit;

  tvDataModel.Items.BeginUpdate;
  try
    if IUnknown(ParentNode.Data).QueryInterface(IDMCollection, Collection)=0  then begin
      if ClearFirst then
        ParentNode.DeleteChildren
      else begin
        aChildNode:=ParentNode.getFirstChild;
        while aChildNode<>nil do begin
          aUnk:=IUnknown(aChildNode.Data);
          j:=0;
          while j<Collection.Count do begin
             Unk:=Collection.Item[j] as IUnknown;
             if Unk=aUnk then
               Break
             else
               inc(j)
          end;
          if j=Collection.Count then begin
            aTreeNode:=aChildNode.getNextSibling;
            aChildNode.Delete;
            aChildNode:=aTreeNode;
          end else
            aChildNode:=aChildNode.getNextSibling;
        end;
      end;

      for j := 0 to Collection.Count-1 do begin
        aElement:=Collection.Item[j];
        Unk:=aElement as IUnknown;
        aChildNode:=ParentNode.getFirstChild;
        while aChildNode<>nil do begin
          aUnk:=IUnknown(aChildNode.Data);
          if Unk=aUnk then
            Break
          else
           aChildNode:=aChildNode.getNextSibling;
        end;
        if aChildNode=nil then begin

          if (FCurrentLinkType<>ltBackRefs) or
             (aElement.Parent=nil) or
             FExpandingGenerationsFlag then
            S:=aElement.Name
          else
            S:=aElement.Parent.Name;

          if j<ParentNode.Count then
            tvDataModel.Items.InsertObject(ParentNode.Item[j],
                              S, pointer(Unk))
          else
            tvDataModel.Items.AddChildObject(tvDataModel.Selected,
                              S, pointer(Unk));
          Unk._AddRef;
        end;
      end
    end else
    if IUnknown(ParentNode.Data).QueryInterface(IDMElement, Element)=0 then begin
        CollectionCount:=DataModel.GetElementCollectionCount(Element);
        aChildNode:=ParentNode.getFirstChild;
        while aChildNode<>nil do begin
          aUnk:=IUnknown(aChildNode.Data);
           j:=0;
           while j<CollectionCount do begin
             Collection:=Element.Collection[j];
             if (Collection.Count>0) or
               (not FHideEmptyCollectionsFlag) then begin
               Unk:=Collection as IUnknown;
                if Unk=aUnk then
                  Break
                else
                  inc(j)
             end else
               inc(j)
           end;
           if j=CollectionCount then begin
             aTreeNode:=aChildNode.getNextSibling;
             aChildNode.Delete;
             aChildNode:=aTreeNode;
           end else
           aChildNode:=aChildNode.getNextSibling;
        end;

        for j := 0 to CollectionCount-1 do begin
          Collection:=Element.Collection[j];
          if (Collection.Count>0) or
             (not FHideEmptyCollectionsFlag) then begin
            Unk:=Collection as IUnknown;
            aChildNode:=ParentNode.getFirstChild;
            while aChildNode<>nil do begin
              aUnk:=IUnknown(aChildNode.Data);
              if Unk=aUnk then
                Break
              else
                aChildNode:=aChildNode.getNextSibling;
            end;
            if aChildNode=nil then begin
              Element.GetCollectionProperties(j, CollectionName,
                aCurrentRefSource,
                aCurrentClassCollections,
                aCurrentOperations, aCurrentLinkType);

              if j<ParentNode.Count then
                tvDataModel.Items.InsertObject(ParentNode.Item[j],
                             CollectionName, pointer(Unk))
              else
                tvDataModel.Items.AddChildObject(tvDataModel.Selected,
                             CollectionName, pointer(Unk));
              Unk._AddRef;
            end;
          end;
        end;
    end;
  finally
    tvDataModel.Items.EndUpdate;
    Cursor := crDefault;
  end;
end;

procedure TDMBrowser.tvDataModelExpanded(Sender: TObject; Node: TTreeNode);
begin
  Node := tvDataModel.Selected;
  if Node=nil then Exit;
  MakeNodeChilds(Node, False);
end;

procedure TDMBrowser.SetCurrentOptions;
var
  aCollection:IDMCollection;
  aCollectionU:IUnknown;
  RootObject:IUnknown;
  j, CollectionCount:integer;
  RootObjectName, CollectionName:WideString;
  aDataModel:IDataModel;
  Unk:IUnknown;
begin
  aDataModel:=GetDataModel;
  try
  FCurrentClassCollections:=nil;
  FCurrentRefSource:=nil;
  if FCurrentParentElement.QueryInterface(IDMCollection, Unk)=0 then Exit;

  CollectionCount:=aDataModel.GetElementCollectionCount(FCurrentParentElement);
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
    if tvDataModel.Selected.Data=nil then Exit;
    if (IUnknown(tvDataModel.Selected.Data).QueryInterface(IDMCollection, FCurrentCollection)=0) then begin
      aDataModel.GetRootObject(Get_Mode, tvDataModel.Selected.Index,
         RootObject, RootObjectName, FCurrentOperations, FCurrentLinkType);
      FCurrentCollectionIndex:=tvDataModel.Selected.Index;
    end else
    if tvDataModel.Selected.Parent<>nil then
      aDataModel.GetRootObject(Get_Mode, tvDataModel.Selected.Parent.Index,
         RootObject, RootObjectName, FCurrentOperations, FCurrentLinkType)
    else
      aDataModel.GetRootObject(Get_Mode, tvDataModel.Selected.Index,
         RootObject, RootObjectName, FCurrentOperations, FCurrentLinkType);
    if RootObject<>nil then
      RootObject.QueryInterface(IDMCollection, FCurrentCollection)
    else
      FCurrentCollection:=nil;
  end;
  except
    raise
  end;
end;

function TDMBrowser.DoAction(ActionCode:integer):WordBool;
var
  aDataModel:IDataModel;
begin
  Result:=False;
  if Get_Mode<0 then Exit;
  aDataModel:=GetDataModel;
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
  dmbaColOperation,
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
      dmbaDelete          : if not tvDataModel.Selected.Focused then
                              DeleteElement;
      dmbaRenameElement   : RenameElement;
      dmbaSelectElementFromList: SelectElementFromList;
      dmbaChangeRef       : ChangeRef;
      dmbaExecute         : CustomOperation(0);
      dmbaCustomOperation1: CustomOperation(1);
      dmbaCustomOperation2: CustomOperation(2);
      dmbaColOperation    : CustomOperation(3);
      dmbaChangeParent    : ChangeParent;
      dmbaSwitchSelection : SwitchSelection(tvDataModel.Selected, False);
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

procedure TDMBrowser.SetMenuItems;
var
  S,SC:string;
  MoveItemEnabled, CollectionFlag:boolean;
  List:IDMCollection;
  aElement:IDMElement;
  aElement2:IDMElement2;
  Unk:IUnknown;
  Collection2:IDMCollection2;
  Collection3:IDMCollection3;
  CollectionIndex:integer;
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

  Unk:=IUnknown(tvDataModel.Selected.Data);
  if Unk=nil then Exit;
  CollectionFlag:=(Unk.QueryInterface(IDMCollection, List)=0);
  if not CollectionFlag then
    aElement:=Unk as IDMElement
  else
    aElement:=FCurrentCollection.Parent;

  with miAddItem do begin
    Visible:=(leoAdd and FCurrentOperations)<>0;
    Enabled:=Visible;
    if Visible then begin
      Caption:=Format(rsAddElementItem, [S]);
      ShortCut:=TextToShortCut('Ins')
    end else begin
      ShortCut:=TextToShortCut('')
    end;
    Tag:=dmbaAddElement;
  end;

  with miDeleteItem do begin
    Visible:=((leoDelete and FCurrentOperations)<>0) and (not CollectionFlag);
    Enabled:=Visible;
    if Visible then begin
      Caption:=Format(rsDeleteItem, [S]);
      ShortCut:=TextToShortCut('Del')
    end else begin
      ShortCut:=TextToShortCut('')
    end;
    Tag:=dmbaDeleteElement;
  end;

  with miRenameItem do begin
    Visible:=((leoRename and FCurrentOperations)<>0);
//     and (not CollectionFlag);
    Enabled:=Visible;
    if Visible then begin
      Caption:=Format(rsRenameItem, [S]);
      ShortCut:=TextToShortCut('Ctrl+N')
    end else begin
      ShortCut:=TextToShortCut('')
    end;
    Tag:=dmbaRenameElement;
  end;

  with miSelectItems do begin
    Visible:=((leoSelect and FCurrentOperations)<>0) or
             ((leoSelectRef and FCurrentOperations)<>0);
    Enabled:=Visible;
    if Visible then begin
      Caption:=Format(rsSelectItem, [S]);
      ShortCut:=TextToShortCut('Alt+Ins')
    end else begin
      ShortCut:=TextToShortCut('')
    end;
    Tag:=dmbaSelectElementFromList;
  end;

  with miChangeRef do begin
    Visible:=((leoChangeRef and FCurrentOperations)<>0) and (not CollectionFlag);
    Enabled:=Visible;
    if Visible then begin
      ShortCut:=TextToShortCut('Ctrl+T');
      Caption:=Format(rsChangeRef, [S]);
    end else begin
      ShortCut:=TextToShortCut('')
    end;
    Tag:=dmbaChangeRef;
  end;

  with miCustomOperation1 do begin
    Visible:=((leoOperation1 and FCurrentOperations)<>0) and
     (not CollectionFlag) and
     (aElement.QueryInterface(IDMElement2, aElement2)=0);

    Enabled:=Visible;
    if Visible then begin
      Caption:=aElement2.GetOperationName(-1, 1);
      SC:=aElement2.GetShortCut(-1, 1);
      ShortCut:=TextToShortCut(SC)
    end else begin
      ShortCut:=TextToShortCut('');
    end;
    Tag:=dmbaCustomOperation1;
  end;

  with miCustomOperation2 do begin
    Visible:=((leoOperation2 and FCurrentOperations)<>0) and
     (not CollectionFlag) and
     (aElement.QueryInterface(IDMElement2, aElement2)=0);

    Enabled:=Visible;
    if Visible then begin
      Caption:=aElement2.GetOperationName(-1, 2);
      SC:=aElement2.GetShortCut(-1, 2);
      ShortCut:=TextToShortCut(SC)
    end else begin
      ShortCut:=TextToShortCut('');
    end;
    Tag:=dmbaCustomOperation2;
  end;

  with miColOperation do begin
    Visible:=((leoColOperation and FCurrentOperations)<>0) and
     (CollectionFlag) and
     (aElement.QueryInterface(IDMElement2, aElement2)=0);

    Enabled:=Visible;
    if Visible then begin
      Caption:=aElement2.GetOperationName(FCurrentCollectionIndex, 3);
      SC:=aElement2.GetShortCut(FCurrentCollectionIndex, 3);
      ShortCut:=TextToShortCut(SC)
    end else begin
      ShortCut:=TextToShortCut('');
    end;
    Tag:=dmbaColOperation;
  end;

  with miExecute do begin
    Visible:=((leoExecute and FCurrentOperations)<>0) and
     (not CollectionFlag) and
     (aElement.QueryInterface(IDMElement2, aElement2)=0);

    Enabled:=Visible;
    if Visible then begin
      Caption:=aElement2.GetOperationName(-1, 0);
      if Caption>'' then begin
        SC:=aElement2.GetShortCut(-1, 0);
        ShortCut:=TextToShortCut(SC)
      end else begin
        Visible:=False;
        Enabled:=False;
      end;
    end else begin
      ShortCut:=TextToShortCut('');
    end;
    Tag:=dmbaExecute;
  end;

  with miChangeParent do begin
    Visible:=((leoChangeParent and FCurrentOperations)<>0) and (not CollectionFlag);
    Enabled:=Visible;
    if Visible then
      Caption:=Format(rsChangeParent, [S]);
    Tag:=dmbaChangeParent;
  end;

  FCurrentCollection.QueryInterface(IDMCollection2, Collection2);
  MoveItemEnabled:=not CollectionFlag;
  miMoveUp.Enabled:=MoveItemEnabled;
  miMoveDown.Enabled:=MoveItemEnabled;

  if aElement=nil then Exit;
  if CollectionFlag then Exit;

  if aElement.Selected then
    miSwitchSelection.Caption:=Format(rsUnSelect, [S])
  else
    miSwitchSelection.Caption:=Format(rsSelect, [S]);
end;

procedure TDMBrowser.UpdateTree(nItemIndex:integer; CollectionNode:TTreeNode; ClearFirst:boolean);
begin
  MakeNodeChilds(CollectionNode, ClearFirst);
  if nItemIndex<-1 then Exit;
  if (nItemIndex<>-1) and
     (nItemIndex<CollectionNode.Count)then
    tvDataModel.Selected:=CollectionNode.Item[nItemIndex]
  else
    tvDataModel.Selected:=CollectionNode;
//  tvDataModel.TopItem:=tvDataModel.Selected;
  tvDataModel.Selected.MakeVisible;
  if not tvDataModel.Selected.Selected then
    tvDataModel.Selected.Selected:=True;
end;

procedure TDMBrowser.SetHideEmptyCollectionsFlag(const Value: boolean);
begin
  FHideEmptyCollectionsFlag := Value;
end;

procedure TDMBrowser.tvDataModelEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
  aElement:IDMElement;
  OperationManager:IDMOperationManager;
  aDocument:IDMDocument;
begin
  aElement:=IUnknown(Node.Data) as IDMElement;
  if aElement=nil then Exit;
  tvDataModel.ReadOnly:=True;
  aDocument:=GetDocument;
  OperationManager:=aDocument as IDMOperationManager;
  OperationManager.StartTransaction(FCurrentCollection, leoRename, rsRename);
  OperationManager.RenameElement( aElement, S);
  OperationManager.FinishTransaction(aElement, FCurrentCollection, leoRename);

  if (GetDataModel.State and dmfDemo)<>0 then begin
    DM_LoadKeyboardLayout(FOldLayoutName,
      KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);
  end;

  tvDataModel.SetFocus;
end;

procedure TDMBrowser.SetItemBold(ANode: TTreeNode; Value: Boolean);
var
  Item: TTVItem;
  Template: Integer;
begin
  if ANode = nil then Exit;
  if Value then Template := -1
  else Template := 0;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ANode.ItemId;
    stateMask := TVIS_BOLD;
    state := stateMask and Template;
  end;
  TreeView_SetItem(tvDataModel.Handle, Item);
end;

procedure TDMBrowser.tvDataModelCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  aElement:IDMElement;
  aList:IDMCollection;
begin
  DefaultDraw:=True;
  if Node.Data=nil then Exit;
  if IUnknown(Node.Data).QueryInterface(IDMCollection, aList)=0 then begin
    SetItemBold(Node, True);
  end else if IUnknown(Node.Data).QueryInterface(IDMElement, aElement)=0 then begin
    SetItemBold(Node, False);
    if aElement.Presence>0 then
      tvDataModel.Canvas.Font.Style:=tvDataModel.Canvas.Font.Style+[fsItalic]
    else
      tvDataModel.Canvas.Font.Style:=tvDataModel.Canvas.Font.Style-[fsItalic]
  end;
end;

function TDMBrowser.ExpandGenerations(const theElement:IDMElement;
               var Found:boolean; DoSelect:boolean):TTreeNode;
var
  Node:TTreeNode;
  j:integer;
  aCollection:IDMCollection;
  aCollection2:IDMCollection2;
  aElement, Element:IDMElement;
  aDataModel:IDataModel;
  Unk:IUnknown;
begin
  Result:=nil;
  Found:=False;
  if FChangingTreeNodeFlag then Exit;
  Node:=tvDataModel.Items.GetFirstNode;
  while Node<>nil do begin
    Unk:=IUnknown(Node.Data);
    if Unk.QueryInterface(IDMElement, aElement)=0 then begin
      if aElement=theElement then
        Break
      else
      if aElement.Ref=theElement then
        Break
      else
      if aElement=theElement.Ref then
        Break
      else
        Node:=Node.GetNext;
    end else
      Node:=Node.GetNext;
  end;
  if Node<>nil then begin
//    tvDataModel.TopItem:=Node;
    Node.MakeVisible;
    if (not Node.Selected) and DoSelect then
      tvDataModel.Selected:=Node;
    Node.MakeVisible;
    Result:=Node;
    Found:=True;
    Exit;
  end;

  aDataModel:=GetDataModel;
  aDataModel.BuildGenerations(Get_Mode, theElement);
  if aDataModel.GenerationCount=0 then Exit;
  if (tvDataModel.Selected<>nil) then begin
    if tvDataModel.Selected.Data=nil then Exit;
    if (IUnknown(tvDataModel.Selected.Data).QueryInterface(IDMElement, aElement)=0) and
         (aElement=aDataModel.Generation[aDataModel.GenerationCount-1]) then begin
       Result:=tvDataModel.Selected;
       Found:=True;
       Exit;
    end;
  end;
  Node:=tvDataModel.Items.GetFirstNode;
  FExpandingGenerationsFlag:=True;
  tvDataModel.Items.BeginUpdate;
  try
  Node.Collapse(True);

  Element:=aDataModel.Generation[0];

  while Node<>nil do begin
    if Node.Data=nil then
      Node:=Node.GetNextSibling
    else
    if IUnknown(Node.Data).QueryInterface(IDMCollection, aCollection)=0 then begin
      if aCollection.IndexOf(Element)<>-1 then begin
        MakeNodeChilds(Node, False);
        Node.Expand(False);
        Node:=Node.GetFirstChild;
      end else
        Node:=Node.GetNextSibling;
    end else begin
      aElement:=IUnknown(Node.Data) as IDMElement;
      if aElement=Element then
        Break
      else
      if aElement.Ref=Element then
        Break
      else
        Node:=Node.GetNextSibling;
    end;
  end;

  for j:=0 to aDataModel.GenerationCount-1 do begin
    Element:=aDataModel.Generation[j];
    while Node<>nil do begin
      aElement:=IUnknown(Node.Data) as IDMElement;
      if aElement=Element then
        Break
      else
      if aElement.Ref=Element then
        Break;
      Node:=Node.GetNextSibling;
    end;
    if Node=nil then Break;
    MakeNodeChilds(Node, False);
    if j<aDataModel.GenerationCount-1 then begin
      Element:=aDataModel.Generation[j+1];
      Node.Expand(False);
      Node:=Node.GetFirstChild;
      while Node<>nil do begin
        aCollection:=IUnknown(Node.Data) as IDMCollection;
        if aCollection.IndexOf(Element)<>-1 then
          Break
        else begin
          if aCollection.QueryInterface(IDMCollection2, aCollection2)=0 then begin
            if aCollection2.GetItemByRef(Element)<>nil then
              Break
          end;
        end;
        Node:=Node.GetNextSibling;
      end;
      if Node=nil then Break;

      MakeNodeChilds(Node, False);
      Node.Expand(False);
      Node:=Node.GetFirstChild;
    end;
  end;
  finally
    tvDataModel.Items.EndUpdate;
    tvDataModel.Visible:=True;
  FExpandingGenerationsFlag:=False;
  end;

  Found:=True;

  if (Node<>nil) then begin
    if (not Node.Selected) and DoSelect then
      tvDataModel.Selected:=Node;
    tvDataModelChange(nil, Node);
    Node.MakeVisible;
  end;

  Result:=Node;

end;

procedure TDMBrowser.ClearTree;
begin
  FClearTreeFlag:=True;
  try
  try
  tvDataModel.Items.Clear;
  except
    raise
  end;
  finally
    FClearTreeFlag:=False;
  end;
end;

procedure TDMBrowser.SetDetailsList;
var
  j, m, FieldCount_, ParamKind: integer;
  Field:IDMField;
  ParamKindSet:integer;
  S:string;
  CanSelect:boolean;
  aDataModel:IDataModel;
begin
  try
  if FCurrentElement=nil then Exit;

  FieldCount_:=FCurrentElement.FieldCount_;
  FMemoFieldIndex:=-1;
  ParamKindSet:=0;
  aDataModel:=GetDataModel;
  for j:=0 to FieldCount_-1 do begin
    Field:=FCurrentElement.Field_[j];
    if Field.ValueType=fvtText then begin
      ParamKindSet:=ParamKindSet or pkComment;
    end else
    if aDataModel.GetElementFieldVisible(FCurrentElement, Field.Code) then begin
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
//  SetDetailsListKind;
//  SetDetailPanels;
//  sgDetailsSelectCell(nil, 0, 0, CanSelect);
//  cbParameter.Visible:=False;
  except
    raise
  end;  
end;

procedure TDMBrowser.SetDetailsListKind;
var
  j, H0, H1, WW, HH, N, FieldCount_: integer;
  Field:IDMField;
  R:TRect;
  aDataModel:IDataModel;
begin
  aDataModel:=GetDataModel;
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
    if aDataModel.GetElementFieldVisible(FCurrentElement, Field.Code) then begin
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
      if aDataModel.GetElementFieldVisible(FCurrentElement, Field.Code) and
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

procedure TDMBrowser.cbParameterChange(Sender: TObject);
var
  m, aCol, aRow:integer;
  aElement, Element:IDMElement;
  OperationManager:IDMOperationManager;
  V:Variant;
  aDocument:IDMDocument;
begin
  if Get_Mode<0 then Exit;
  aDocument:=GetDocument;
  if (GetDataModel.State and dmfFrozen)<>0 then Exit;

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

procedure TDMBrowser.SetFieldValue(const V:Variant; const aElement:IDMElement);
var
  aDocument:IDMDocument;
  OperationManager:IDMOperationManager;
  aField, theField:IDMField;
  RCode, j, i, l, CollectionIndex, CollectionIndex1, Indx, Indx1:integer;
  theElement, aParentElement, GrandParentElement:IDMElement;
  aCollection, theCollection:IDMCollection;
  aCollection2, theCollection2:IDMCollection2;
  DataModel:IDataModel;
begin
  DataModel:=GetDataModel;
  aDocument:=GetDocument;
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
    while CollectionIndex<DataModel.GetElementCollectionCount(FCurrentParentElement) do begin
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
         (CollectionIndex<DataModel.GetElementCollectionCount(aParentElement)) then begin
        aCollection:=aParentElement.Collection[CollectionIndex];
        if (aCollection.QueryInterface(IDMCollection2, aCollection2)=0) and
           aCollection2.CanContain(aElement) then begin
          if Indx=-1 then begin
            for i:=0 to aCollection.Count-1 do begin
              theElement:=aCollection.Item[i];
              if theElement.ClassID=aElement.ClassID then begin
                theField:=theElement.Field_[FCurrentFieldIndex];
                if theField=aField then
                  OperationManager.ChangeFieldValue(
                    theElement, RCode, True, V);
              end;
            end;
          end else
          if Indx<aCollection.Count then begin
            theElement:=aCollection.Item[Indx];
            if theElement.ClassID=aElement.ClassID then begin
              theField:=theElement.Field_[FCurrentFieldIndex];
              if theField=aField then
                OperationManager.ChangeFieldValue(
                  theElement, RCode, True, V);
            end;
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
    while CollectionIndex1<DataModel.GetElementCollectionCount(GrandParentElement) do begin
      aCollection:=GrandParentElement.Collection[CollectionIndex1];
      Indx1:=aCollection.IndexOf(FCurrentParentElement);
      if Indx1<>-1 then
        Break
      else
        inc(CollectionIndex1);
    end;

    CollectionIndex:=0;
    while CollectionIndex<DataModel.GetElementCollectionCount(FCurrentParentElement) do begin
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
         (CollectionIndex1<DataModel.GetElementCollectionCount(GrandParentElement)) then begin
        aCollection:=GrandParentElement.Collection[CollectionIndex1];
        if (aCollection.QueryInterface(IDMCollection2, aCollection2)=0) and
          aCollection2.CanContain(FCurrentParentElement) then begin
          if Indx1<aCollection.Count then begin
            aParentElement:=aCollection.Item[Indx1];
            if aParentElement.Ref=FCurrentParentElement.Ref then
              if CollectionIndex<DataModel.GetElementCollectionCount(aParentElement) then begin
                theCollection:=aParentElement.Collection[CollectionIndex];
                if (theCollection.QueryInterface(IDMCollection2, theCollection2)=0) and
                   theCollection2.CanContain(aElement) then begin
                  if Indx=-1 then begin
                    for l:=0 to theCollection.Count-1 do begin
                      theElement:=theCollection.Item[l];
                      if theElement.ClassID=aElement.ClassID then begin
                        theField:=theElement.Field_[FCurrentFieldIndex];
                        if theField=aField then
                          OperationManager.ChangeFieldValue(
                            theElement, RCode, True, V);
                      end;
                    end;
                  end else
                  if Indx<theCollection.Count then begin
                    theElement:=theCollection.Item[Indx];
                    if theElement.ClassID=aElement.ClassID then begin
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
    end;

  end else
    OperationManager.ChangeFieldValue( aElement,
       RCode, True, V);

  OperationManager.FinishTransaction(aElement, FCurrentCollection, leoChangeFieldValue);
end;

procedure TDMBrowser.Set_CurrentElement(const Value: IUnknown);
var
  aElement:IDMElement;
  aDocument:IDMDocument;
  Key:word;
  aDataModel:IDataModel;
  Found:boolean;
begin
  aDocument:=GetDocument;
  aDataModel:=GetDataModel;
  if (aDataModel.State and dmfSelecting)<>0 then Exit;
  aElement:=Value as IDMElement;
  if FCurrentElement = aElement then Exit;

  if FSetCurrentElementFlag then Exit;
  FSetCurrentElementFlag:=True;
  try

  if cbParameter.Visible then
    cbParameterExit;
  Key:=VK_RETURN;
  sgDetailsKeyDown(nil, Key, []);

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

procedure TDMBrowser.ParameterKeyPress(Sender: TObject; var Key: Char);
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

       OperationManager:=GetDocument as IDMOperationManager;
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

procedure TDMBrowser.GoToLastElement;
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

procedure TDMBrowser.tvDataModelDeletion(Sender: TObject; Node: TTreeNode);
var
  Unk:IUnknown;
begin
  if Get_ChangingParent then Exit;
  if FSelectedCollectionNode=Node then
    FSelectedCollectionNode:=nil;
  if (Node.Data<>nil) then begin
    Unk:=IUnknown(Node.Data);
    if Unk<>nil then
      Unk._Release;
    Node.Data:=nil;
  end;
end;

procedure TDMBrowser.HeaderSectionResize(HeaderControl: THeaderControl;
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

procedure TDMBrowser.HeaderResize(Sender: TObject);
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

procedure TDMBrowser.ChangeDetailsFont(const Element:IDMElement;
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

procedure TDMBrowser.SetDetailsCell(ACol, ARow: Integer);
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
//  if (ACol=Col) and (ARow=Row) and
//     cbParameter.Visible then begin
//    S:=' ';
//  end else begin
      case ACol of
      0:if FDetailMode=dmdList then
          S:=Element.FieldName[i]
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
             Frmt:=Element.FieldFormat[i];
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
           Frmt:=Element.FieldFormat[i];
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
//    end;

    Cells[aCol, aRow]:=S;

  end;
  except
    raise
  end
end;

procedure TDMBrowser.sgDetailsDrawCell(Sender: TObject; ACol, ARow: Integer;
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

function TDMBrowser.GetDetailCellHeight(S0:string; DrawFlag:boolean;
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

procedure TDMBrowser.sgDetailsKeyDown(Sender: TObject; var Key: Word;
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
  m, OldRow, OldCol:integer;
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
      Document:=GetDocument;
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
              Frmt:=aElement.FieldFormat[FCurrentFieldIndex];
              if Frmt<>'' then begin
                Delimeter:=Frmt[1];
                Delete(Frmt,1,1);
                ParseText(Frmt, Delimeter, cbParameter.Items);
                cbParameter.ItemIndex:=aElement.FieldValue_[FCurrentFieldIndex]-
                                       aElement.Field_[FCurrentFieldIndex].MinValue;
              end;
            end;
          end; //end case  ...ValueType
          if Sender=sgDetails then begin
            cbParameter.Visible:=True;
            if Visible then
              cbParameter.SetFocus;
          end;
        end
      else
        begin
          if (Get_Mode>=0) and
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
              OldRow:=sgDetails.Row;
              OldCol:=sgDetails.Col;
              SetFieldValue(V, aElement);
              if OldRow<sgDetails.RowCount then
                sgDetails.Row:=OldRow;
//              sgDetails.Col:=OldCol;
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

procedure TDMBrowser.sgDetailsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  Element:IDMElement;
  OperationManager:IDMOperationManager;
  Key:word;
  S:string;
begin
  FOldFieldValue:=sgDetails.Cells[ACol, ARow];
  if cbParameter.Visible then
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
      OperationManager:=GetDocument as IDMOperationManager;
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
       (Get_Mode>=0) then begin
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

procedure TDMBrowser.sgDetailsEnter(Sender: TObject);
var
  CanSelect: Boolean;
begin
  sgDetailsSelectCell(sgDetails,
      sgDetails.Col, sgDetails.Row, CanSelect);
  Get_DMEditorX.ActiveForm:=Self as IDMForm;
end;

procedure TDMBrowser.sgDetailsDblClick(Sender: TObject);
var Key: Word;
begin
  Key:=VK_RETURN;
  sgDetailsKeyDown(sgDetails,  Key, []);
end;

procedure TDMBrowser.sgDetailsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if (not FEditingParameterFlag) and
     (goEditing in sgDetails.Options) then begin
    FEditingParameterFlag:=True;
  end;
end;

procedure TDMBrowser.cbParameterExit;
begin
  cbParameterChange(nil);
  cbParameter.Visible:=False;
end;

procedure TDMBrowser.SetDetailMode(const Value: integer);
begin
  FDetailMode := Value;
  SetDetails;
  sgDetails.Visible:=sgDetails.Cells[0,0]<>'';
end;

procedure TDMBrowser.SetDetails;
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
      if tvDataModel.Selected=nil then Exit;
      if tvDataModel.Selected.Data=nil then Exit;

        SetDetailsElements(FCurrentCollection)
    end;
  end;
  FSetDetailsFlag:=False;
end;

procedure TDMBrowser.SetDetailsElements(Elements: IDMCollection);
var
  Field, Field0:IDMField;
  Element, Element0:IDMElement;
  m, j, HH, WW, N:integer;
  Section:THeaderSection;
  FieldCount_, aCode:integer;
  R:TRect;
  aDataModel:IDataModel;
begin
  aDataModel:=GetDataModel;
   while Header.Sections.Count>1 do
     Header.Sections.Delete(1);
   Header.Sections[0].Text:='';
   sgDetails.ColCount:=1;
   sgDetails.RowCount:=1;

   if Elements.Count=0 then Exit;

   Element0:=Elements.Item[0];
   FieldCount_:=Element0.FieldCount_;
   N:=0;
   try
   for m:=0 to FieldCount_-1 do begin
     Element0:=Elements.Item[0];
     Field0:=Element0.Field_[m];
     aCode:=Field0.Code;
     j:=0;
     while j<Elements.Count do begin
       Element0:=Elements.Item[j];
       if aDataModel.GetElementFieldVisible(Element0, aCode) then
         break
       else
         inc(j)
     end;
     if (j<Elements.Count)  and
       (Field0.ValueType<>fvtText) then
       inc(N);
   end;
   except
     raise
   end;
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
     Element0:=Elements.Item[0];
     Field0:=Element0.Field_[m];
     aCode:=Field0.Code;
     j:=0;
     while j<Elements.Count do begin
       Element0:=Elements.Item[j];
       if aDataModel.GetElementFieldVisible(Element0, aCode) then
         break
       else
         inc(j)
     end;
     if (j<Elements.Count)  and
       (Field0.ValueType<>fvtText) then begin
       Section:=Header.Sections.Add;
       Section.Text:=IntToStr(N+1);
       for j:=0 to Elements.Count-1 do begin
         Element:=Elements.Item[j];
         Field:=Element.Field_[m];
         sgDetails.Objects[N+1, j]:=pointer(m);
         if Field=Field0 then
           SetDetailsCell(N+1, j)
         else
           sgDetails.Cells[N+1, j]:='-';
       end;
       inc(N);
     end;
   end;
   sgDetails.Invalidate;
end;

procedure TDMBrowser.HeaderSectionClick(HeaderControl: THeaderControl;
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

procedure TDMBrowser.cbCategoriesChange(Sender: TObject);
var
  Elements:IDMCollection;
  j:integer;
  aDocument:IDMDocument;
begin
  if Get_Mode<0 then Exit;
  aDocument:=GetDocument;
  if (GetDataModel.State and dmfFrozen)<>0 then Exit;

  j:=cbCategories.ItemIndex;
  if j=-1 then Exit;
  Elements:=IDMCollection(pointer(cbCategories.Items.Objects[j]));
  SetDetailsElements(Elements);
  SetColWidths(0.3);
  sgDetails.Visible:=sgDetails.Cells[0,0]<>'';
end;

procedure TDMBrowser.cbCategoriesExit(Sender: TObject);
begin
  cbCategoriesChange(Sender);
  cbCategories.Visible:=False;
end;

procedure TDMBrowser.MakeRootNodes;
var
  DMDocument:IDMDocument;
  aDataModel:IDataModel;
  DataModelE:IDMElement;
  j, Mode, Operations, LinkType:integer;
  Text:string;
  Data:pointer;
  RootObject:IUnknown;
  RootObjectName: WideString;
  Unk:IUnknown;
begin
  Mode:=Get_Mode;
  tvDataModel.Items.BeginUpdate;

  ClearTree;

  DMDocument:=GetDocument;
  if DMDocument<>nil then begin
    aDataModel:=GetDataModel;
    DataModelE:=aDataModel as IDMElement;
    for j := 0 to aDataModel.RootObjectCount[Mode]-1 do begin
      aDataModel.GetRootObject(Mode, j, RootObject,
                              RootObjectName, Operations, LinkType);
      Text:=RootObjectName;
      Unk:=RootObject as IUnknown;
      Data:=pointer(Unk);
      tvDataModel.Items.AddObject(nil, Text, Data);
      if Unk<>nil then
        Unk._AddRef;
    end;
  end;
  tvDataModel.Items.EndUpdate;
end;

procedure TDMBrowser.InitTree;
var
  j, Mode:integer;
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
begin
  Mode:=Get_Mode;

  ClearTreeData;

  MakeRootNodes;

  DMDocument:=GetDocument;

  if DMDocument=nil then Exit;
  if (FCurrentObject<>nil) and
     (FCurrentObject.QueryInterface(IDMElement, aElement)<>0) then begin
    aCollection:=FCurrentObject as IDMCollection;
    aElement:=aCollection.Parent;
  end else
    aElement:=nil;

  if Mode<0 then Exit;
  try
  
  aDataModel:=DMDocument.DataModel as IDataModel;
  DataModelE:=aDataModel as IDMElement;

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

      if (aElement<>nil) and
         (TopCollectionIndex<>-1) then
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

  if FCurrentObject=nil then begin
    if tvDataModel.Items.Count>0 then begin
      tvDataModel.Selected:=tvDataModel.Items[0];
      if not tvDataModel.Selected.Selected then
        tvDataModel.Selected.Selected:=True;
      tvDataModel.Items[0].Expand(False);
    end;
  end else begin
    j:=0;
    while j<tvDataModel.Items.Count do begin
      if pointer(FCurrentObject)=tvDataModel.Items[j].Data then
        Break
      else
        inc(j);
    end;
    if j=tvDataModel.Items.Count then begin
      FExpandingGenerationsFlag:=True;
      MakeNodeChilds(tvDataModel.Items[0], False);
      FExpandingGenerationsFlag:=False;
    end;
  end;
end;

procedure TDMBrowser.DocumentOperation(ElementsV, CollectionV: OleVariant; DMOperation,
  nItemIndex: Integer);
var
  aNode, CollectionNode:TTreeNode;
  aCollectionU, aElementU, aUnk, Unk:IUnknown;
  i, j, m:integer;
  Element:IDMElement;
  Collection:IDMCollection;
  Found:boolean;
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
        for j:=0 to tvDataModel.Items.Count-1 do begin
          aNode:=tvDataModel.Items[j];
          Unk:=IUnknown(aNode.Data);
          if aUnk=Unk then
            FNodeList.Add(aNode);
        end;
      end else begin
        Collection:=aUnk as IDMCollection;
        for i:=0 to Collection.Count-1 do begin
          Element:=Collection.Item[i];
          aUnk:=Element as IUnknown;
          for j:=0 to tvDataModel.Items.Count-1 do begin
            aNode:=tvDataModel.Items[j];
            Unk:=IUnknown(aNode.Data);
            if aUnk=Unk then
              FNodeList.Add(aNode);
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
      for j:=0 to tvDataModel.Items.Count-1 do begin
        aNode:=tvDataModel.Items[j];
        Unk:=IUnknown(aNode.Data);
        if aUnk=Unk then
         FNodeList.Add(aNode);
      end;
    end;

    aElementU:=ElementsV;
    aUnk:=aElementU as IUnknown;
    for j:=0 to tvDataModel.Items.Count-1 do begin
      aNode:=tvDataModel.Items[j];
      Unk:=IUnknown(aNode.Data);
      if (aUnk=Unk) and
         (aNode.Parent<>nil) and
         (FNodeList.IndexOf(aNode.Parent)=-1) then
        FNodeList.Add(aNode.Parent);
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
          aNode:=ExpandGenerations(Element, Found, True);
          if aNode<>nil then
            aNode.Text:=Element.Name;
        end else begin
          for j:=0 to FNodeList.Count-1 do begin
            aNode:=FNodeList[j];
            UpdateTree(nItemIndex, aNode, True);
          end;
        end;
      end;
    end;
  leoRename, leoChangeRef:
     for j:=0 to FNodeList.Count-1 do begin
       aNode:=FNodeList[j];
       if aElementU.QueryInterface(IDMElement, Element)<>0 then
         Element:=(aElementU as IDMCollection).Item[j];
       aNode.Text:=Element.Name
     end;
  leoDelete,
  leoSelect,
  leoSelectRef,
  leoPaste,
  leoMove,
  leoChangeParent:
    begin
      if (tvDataModel.Selected<>nil) and
         (tvDataModel.Selected.Data<>nil)  then begin
        if Succeeded(IUnknown(tvDataModel.Selected.Data).QueryInterface(IDMCollection, aCollectionU)) then
          CollectionNode:=tvDataModel.Selected
        else
          CollectionNode:=tvDataModel.Selected.Parent;

        m:=FNodeList.IndexOf(CollectionNode);
        if m<>-1 then
          FNodeList.Move(m, FNodeList.Count-1);
      end;

      for j:=0 to FNodeList.Count-1 do begin
        aNode:=FNodeList[j];
        UpdateTree(nItemIndex, aNode, DMOperation=leoMove);
      end;
    end;
  end;

  inherited;
end;


function TDMBrowser.CheckCurrentElementSeletion:boolean;
var
  Document:IDMDocument;
  Server:IDataModelServer;
  aParent:IDMElement;

  procedure CallErrorDailog;
  begin
     Server.CallDialog(sdmShowMessage, 'Спрут-ИСТА', 'Текущий элемент не выделен.'#13+
                      'Либо выделите текущий элемент или его родительский элемент,'#13+
                      'либо снимите выделение со всех элементов и повторите операцию');
  end;
begin
  Result:=False;
  if FCurrentElement=nil then begin
    Result:=True;
    Exit;
  end;
  Server:=Get_DataModelServer as IDataModelServer;
  Document:=GetDocument;
  if Document=nil then Exit;
  if (Document.SelectionCount>1) and
     (not FCurrentElement.Selected) then begin
     aParent:=FCurrentElement.Parent;
     if aParent=nil then begin
       CallErrorDailog;
       Exit;
     end else begin
       if not aParent.Selected then begin
         aParent:=aParent.Parent;
         if aParent=nil then begin
           CallErrorDailog;
           Exit;
         end else begin
           if not aParent.Selected then begin
             CallErrorDailog;
            Exit;
           end;
         end;
       end;  
     end;
  end;
  Result:=True;
end;

procedure TDMBrowser.AddElement;
var
  aName, Suffix, ClassAlias:string;
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
  First:boolean;

  procedure RefInput;
  begin
    aName:=(FCurrentRefSource as IDMCollection2).MakeDefaultName(FCurrentParentElement);
    ClassAlias:=FCurrentCollection.ClassAlias[0];

    Server.EventData2:=aName;
    Server.EventData3:=0;
    Server.CallDialog(4,
                      Format(rsAddItemCaption,[ClassAlias]),
                      Format(rsAddItemPrompt,[ClassAlias]));
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
            if First then
              First:=not First
            else
              aName:=IncElementNumber(aName);
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
  if Get_Mode<0 then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  Document:=GetDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;
  if not CheckCurrentElementSeletion then Exit;

  DMOperationManager:=Document as IDMOperationManager;

  First:=True;
  if (FCurrentRefSource=nil) and
     (FCurrentClassCollections=nil) then begin
    aName:=(FCurrentCollection as IDMCollection2).MakeDefaultName(FCurrentParentElement);
    ClassAlias:=FCurrentCollection.ClassAlias[0];

    Server.EventData2:=aName;
    Server.EventData3:=0;
    Server.CallDialog(4,
                      Format(rsAddItemCaption,[ClassAlias]),
                      Format(rsAddItemPrompt,[ClassAlias]));
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
            if First then
              First:=not First
            else
              aName:=IncElementNumber(aName);
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
                if First then
                  First:=not First
                else
                  aName:=IncElementNumber(aName);
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
          while CollectionIndex1<aDataModel.GetElementCollectionCount(GrandParentElement) do begin
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
               (CollectionIndex1< aDataModel.GetElementCollectionCount(GrandParentElement)) then begin
              aCollection:=GrandParentElement.Collection[CollectionIndex1];
              if aCollection.ClassID=FCurrentParentElement.ClassID then begin
                if Indx1<aCollection.Count then begin
                  aParentElement:=aCollection.Item[Indx1];
                  if First then
                    First:=not First
                  else
                    aName:=IncElementNumber(aName);
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

procedure TDMBrowser.DeleteElement;
var
  OperationManager:IDMOperationManager;
  aElement:IDMElement;
  OldState, OldSelectState:integer;
  aDocument:IDMDocument;
  Collection2:IDMCollection2;
  aDataModel:IDataModel;
begin
  if Get_Mode<0 then Exit;
  if FCurrentElement=nil then Exit;
  if not CheckCurrentElementSeletion then Exit;
  aDocument:=GetDocument;
  aDataModel:=GetDataModel;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;

  OperationManager:=aDocument as IDMOperationManager;
  Collection2:=OperationManager.SourceCollection as IDMCollection2;
  Collection2.Clear;

  OperationManager.StartTransaction(FCurrentCollection, leoDelete, rsDelete);

  OldState:=aDataModel.State;
  OldSelectState:=OldState and dmfSelecting;
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
      aElement.Selected:=False;
      if (aElement.SpatialElement<>nil) and
         (aElement.SpatialElement.Ref=aElement) then begin
        aElement:=aElement.SpatialElement;
        aElement.Selected:=False;
      end;
      Collection2.Add(aElement);
    end;
  end;

  if (Collection2 as IDMCollection).Count=0 then begin
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
    Exit;
  end;

//  Get_DMEditorX.Say('Удаляем объект', True, False);

  OperationManager.DeleteElements(Collection2, True);
  finally
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
  end;
  OperationManager.FinishTransaction(nil, FCurrentCollection, leoDelete);
end;

procedure TDMBrowser.SelectElementFromList;
var
  SourceCollection, DestCollection:IDMCollection;
  SourceCollection2, DestCollection2:IDMCollection2;
  j, m, FormID:integer;
  aElement, aRef:IDMElement;
  OperationManager:IDMOperationManager;
  aDocument:IDMDocument;
  AddFlag:boolean;
  aDataModel:IDataModel;
begin
  aDataModel:=GetDataModel;
  if Get_Mode<0 then Exit;
  aDocument:=GetDocument;
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
  while j<aDataModel.GetElementCollectionCount(FCurrentParentElement) do
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
{$IFDEF Demo}
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
{$ENDIF}
        end;
      end;
    end;
{$IFDEF Demo}
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -3, meLClick, -1, -1, '');
{$ENDIF}

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

procedure TDMBrowser.tvDataModelGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
   if tvDataModel.Dragging then
     Node.SelectedIndex:=-1
   else
     Node.SelectedIndex:=Node.ImageIndex
end;

procedure TDMBrowser.tvDataModelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aNode:TTreeNode;
  ClearSelectionFlag:boolean;
  HitTest:THitTests;
  HT, FormID, ID, YY:integer;
  aDocument:IDMDocument;
begin
  FShiftState:=Shift;
  FEditing:=False;

  tvDataModel.ReadOnly:=True;

  if Get_Mode<0 then Exit;
  aDocument:=GetDocument;
  if (GetDataModel.State and dmfFrozen)<>0 then Exit;

  aNode:=tvDataModel.GetNodeAt(X,Y);
  if aNode=nil then Exit;

  HitTest:=tvDataModel.GetHitTestInfoAt(X,Y);
  ht:=0;
  if htOnItem in HitTest then
    ht:=32;
  if htOnIcon in HitTest then
    ht:=64;
  if htOnButton in HitTest then
    ht:=128;
  if ht<>0 then begin
    if ssShift in Shift then
      ht:=ht+1;
    if ssAlt in Shift then
      ht:=ht+2;
    if ssCtrl in Shift then
      ht:=ht+4;
    if ssRight in Shift then
      ht:=ht+16;
{$IFDEF Demo}
    InitNodeClickMacros(aNode, ht);
{$ENDIF}
  end;

  if not (ssRight in Shift) then begin
    ClearSelectionFlag:=(not (ssCtrl in Shift)) and (not (ssShift in Shift));

    if htOnIcon in HitTest then
      SwitchSelection(aNode, ClearSelectionFlag);
  end else begin
{$IFDEF Demo}
    GetMacrosNodeID(aNode, HT, ID, YY);
    FormID:=Get_FormID;
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
              FormID, -1, meRClick, ID, YY, '')
{$ENDIF}
  end;
end;

procedure TDMBrowser.SwitchSelection(aNode:TTreeNode; ClearSelectionFlag:boolean);
var
  aElement:IDMElement;
  aDocument:IDMDocument;
  aSelectedCollectionNode:TTreeNode;
  j, m, OldState, OldSelectState:integer;
  Server:IDataModelServer;
  aDataModel:IDataModel;
begin
  if Get_Mode<0 then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=GetDocument;
  aDataModel:=GetDataModel;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;
  if aNode.Data=nil then Exit;
  with aNode do
    if Succeeded(IUnknown(Data).QueryInterface(IDMElement, aElement)) then begin
      aSelectedCollectionNode:=aNode.Parent;

      if aElement.SelectRef and
        (FCurrentLinkType<>ltBackRefs) then
        aElement:=aElement.Ref
      else
      if aElement.SelectParent then
        aElement:=aElement.Parent;

      if ClearSelectionFlag or
         ((FSelectedCollectionNode<>nil) and
          (aNode.Parent<>FSelectedCollectionNode)) then begin
        aDocument.ClearSelection(aElement);
        FSelectionRangeStart:=-1
      end;

      if not aElement.Selected then
        FSelectedCollectionNode:=aSelectedCollectionNode;

      aElement.Selected:=not aElement.Selected;
      tvDataModel.Invalidate;

      if FCurrentCollection=nil then Exit;
      j:=FCurrentCollection.IndexOf(aElement);
      if j=-1 then Exit;
      if FSelectionRangeStart=-1 then
        FSelectionRangeStart:=j
      else begin
        if (ssShift in FShiftState) then begin
          OldState:=aDataModel.State;
          OldSelectState:=OldState and dmfSelecting;
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
end;

procedure TDMBrowser.UnselectAll;
var
  aDocument:IDMDocument;
begin
  if Get_Mode<0 then Exit;
  aDocument:=GetDocument;
  if (GetDataModel.State and dmfFrozen)<>0 then Exit;

  aDocument.ClearSelection(nil);
  tvDataModel.Invalidate;
end;

procedure TDMBrowser.SelectAll;
var
  j, N, OldState, OldSelectState:integer;
  aDocument:IDMDocument;
  Server:IDataModelServer;
  aElement:IDMElement;
  Data:pointer;
  Node:TTreeNode;
  aDataModel:IDataModel;
begin
  if Get_Mode<0 then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=GetDocument;
  aDataModel:=GetDataModel;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;
  if FCurrentCollection=nil then Exit;

  OldState:=aDataModel.State;
  OldSelectState:=OldState and dmfSelecting;
  aDataModel.State:=OldState or dmfSelecting;

  try

  aDocument.ClearSelection(nil);
  N:=FCurrentCollection.Count;
  for j:=0 to N-1 do begin
    aElement:=FCurrentCollection.Item[j];
    aElement.Selected:=True;
  end;
  finally
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
  end;

  Server.SelectionChanged(FCurrentElement);

  Node:=tvDataModel.Selected;
  if Node=nil then Exit;
  Data:=Node.Data;
  if Succeeded(IUnknown(Data).QueryInterface(IDMElement, aElement)) then
    FSelectedCollectionNode:=Node.Parent
  else
    FSelectedCollectionNode:=Node;
end;

procedure TDMBrowser.tvDataModelCollapsed(Sender: TObject; Node: TTreeNode);
var
  FirstChild, ChildNode:TTreeNode;

begin
  ChildNode:=Node.getFirstChild;
  while ChildNode<>nil do begin
    FirstChild:=ChildNode.getFirstChild;
    while FirstChild<>nil do begin
      FirstChild.Delete;
      FirstChild:=ChildNode.getFirstChild;
    end;
    ChildNode:=ChildNode.getNextSibling;
  end;
end;

procedure TDMBrowser.ChangeRef;


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
  aName, S, SS, Suffix:string;
  aElement, ElementRef, theElement, aParentElement, GrandParentElement:IDMElement;
  SubKinds, TMPCollection, aCollection, theCollection:IDMCollection;
  TMPCollection2, aCollection2, theCollection2:IDMCollection2;
  SubKindsFlag, First:boolean;
  aDocument:IDMDocument;
  DMOperationManager:IDMOperationManager;
  j, ClassID, CollectionIndex, Indx, i, CollectionIndex1, Indx1, l:integer;
  GlobalData:IGlobalData;
  Server:IDataModelServer;
  V:Variant;
  ElementRefU:IUnknown;
  SaveOldNames:boolean;
  aDataModel:IDataModel;
begin
  aDataModel:=GetDataModel;
  if Get_Mode<0 then Exit;
  if FCurrentElement=nil then Exit;
  if not CheckCurrentElementSeletion then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  aDocument:=GetDocument;
  if (aDataModel.State and dmfFrozen)<>0 then Exit;
  DMOperationManager:=aDocument as IDMOperationManager;
  GlobalData:=aDocument.DataModel as IGlobalData;

  if fmChangeRef=nil then
    fmChangeRef:=TfmChangeRef.Create(Self);

  if not FCurrentElement.Selected then
    aElement:=FCurrentElement
  else
    aElement:=aDocument.SelectionItem[aDocument.SelectionCount-1] as IDMElement;
  if (aElement.Ref<>nil) and
      (aElement.Ref.SpatialElement=aElement) then
    aElement:=aElement.Ref;

  Server.EventData1:=aElement as IUnknown;
  Server.EventData2:=aElement.Name;
  Server.EventData3:=0;
  if aElement.Ref<>nil then
    Server.CallRefDialog(nil, nil, '', True)
  else begin
    Suffix:='';
    Server.CallRefDialog(FCurrentClassCollections, nil, Suffix, True);
  end;

  if Server.EventData3=-1 then Exit;
  V:=Server.EventData1;
  if VarIsNull(V) then
    ElementRefU:=nil
  else
    ElementRefU:=V;
  if ElementRefU=nil then Exit;
  aName:=Server.EventData2;
  aName:=trim(aName);
  if aName='' then Exit;
  SaveOldNames:=(aName='..');

  if aElement.SpatialElement=nil then
    ClassID:=-1
  else
    ClassID:=aElement.SpatialElement.ClassID;

  DMOperationManager.StartTransaction(FCurrentCollection, leoChangeRef, rsChangeRef);

  TMPCollection:=DMOperationManager.SourceCollection as IDMCollection;
  TMPCollection2:=TMPCollection as IDMCollection2;
  TMPCollection2.Clear;

  First:=True;
  if aDocument.SelectionCount=0 then begin
    if SaveOldNames then
      aName:=aElement.Name;
    DMOperationManager.ChangeRef(FCurrentCollection,
                     aName, ElementRefU, aElement);
    DMOperationManager.OnCreateRefElement(ClassID, aElement);
    TMPCollection2.Add(aElement);
  end else
  if aElement.Selected then begin
    for j:=0 to aDocument.SelectionCount-1 do begin
      theElement:=aDocument.SelectionItem[j] as IDMElement;
      if (theElement.Ref<>nil) and
        (theElement.Ref.SpatialElement=theElement) then
        theElement:=theElement.Ref;
      if SaveOldNames then
        aName:=theElement.Name
      else begin
        if First then
          First:=not First
        else
          aName:=IncElementNumber(aName);
      end;
      DMOperationManager.ChangeRef(FCurrentCollection,
                     aName, ElementRefU, theElement);
      DMOperationManager.OnCreateRefElement(ClassID, theElement);
      TMPCollection2.Add(theElement);
    end
  end else
  if FCurrentParentElement.Selected then begin
    CollectionIndex:=0;
    while CollectionIndex<aDataModel.GetElementCollectionCount(FCurrentParentElement) do begin
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
         (CollectionIndex<aDataModel.GetElementCollectionCount(aParentElement)) then begin
        aCollection:=aParentElement.Collection[CollectionIndex];
        if (aCollection.QueryInterface(IDMCollection2, aCollection2)=0) and
           aCollection2.CanContain(aElement) then begin
          if Indx=-1 then begin
            for i:=0 to aCollection.Count-1 do begin
              theElement:=aCollection.Item[i];
              if theElement.ClassID=aElement.ClassID then begin
                if SaveOldNames then
                  aName:=theElement.Name
                else begin
                  if First then
                    First:=not First
                  else
                    aName:=IncElementNumber(aName);
                end;
                DMOperationManager.ChangeRef(FCurrentCollection,
                     aName, ElementRefU, theElement);
                 TMPCollection2.Add(theElement);
              end;
            end;
          end else
          if Indx<aCollection.Count then begin
            theElement:=aCollection.Item[Indx];
            if theElement.ClassID=aElement.ClassID then begin
             if SaveOldNames then
               aName:=theElement.Name
             else begin
               if First then
                 First:=not First
               else
                 aName:=IncElementNumber(aName);
             end;
              DMOperationManager.ChangeRef(FCurrentCollection,
                     aName, ElementRefU, theElement);
              DMOperationManager.OnCreateRefElement(ClassID, theElement);
              TMPCollection2.Add(theElement);
            end;
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
    while CollectionIndex1<aDataModel.GetElementCollectionCount(GrandParentElement) do begin
      aCollection:=GrandParentElement.Collection[CollectionIndex1];
      Indx1:=aCollection.IndexOf(FCurrentParentElement);
      if Indx1<>-1 then
        Break
      else
        inc(CollectionIndex1);
    end;

    CollectionIndex:=0;
    while CollectionIndex<aDataModel.GetElementCollectionCount(FCurrentParentElement) do begin
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
         (CollectionIndex1<aDataModel.GetElementCollectionCount(GrandParentElement)) then begin
        aCollection:=GrandParentElement.Collection[CollectionIndex1];
        if (aCollection.QueryInterface(IDMCollection2, aCollection2)=0) and
          aCollection2.CanContain(FCurrentParentElement) then begin
          if Indx1<aCollection.Count then begin
            aParentElement:=aCollection.Item[Indx1];
            if aParentElement.Ref=FCurrentParentElement.Ref then
              if CollectionIndex<aDataModel.GetElementCollectionCount(aParentElement) then begin
                theCollection:=aParentElement.Collection[CollectionIndex];
                if (theCollection.QueryInterface(IDMCollection2, theCollection2)=0) and
                   theCollection2.CanContain(aElement) then begin
                  if Indx=-1 then begin
                    for l:=0 to theCollection.Count-1 do begin
                      theElement:=theCollection.Item[l];
                      if theElement.ClassID=aElement.ClassID then begin
                        if SaveOldNames then
                          aName:=theElement.Name
                        else begin
                          if First then
                            First:=not First
                          else
                            aName:=IncElementNumber(aName);
                        end;
                        DMOperationManager.ChangeRef(FCurrentCollection,
                                   aName, ElementRefU, theElement);
                        DMOperationManager.OnCreateRefElement(ClassID, theElement);
                        TMPCollection2.Add(theElement);
                      end;
                    end;
                  end else
                  if Indx<theCollection.Count then begin
                    theElement:=theCollection.Item[Indx];
                    if theElement.ClassID=aElement.ClassID then begin
                      if SaveOldNames then
                        aName:=theElement.Name
                      else begin
                        if First then
                          First:=not First
                        else
                          aName:=IncElementNumber(aName);
                      end;
                      DMOperationManager.ChangeRef(FCurrentCollection,
                                   aName, ElementRefU, theElement);
                      DMOperationManager.OnCreateRefElement(ClassID, theElement);
                      TMPCollection2.Add(theElement);
                    end;
                  end;
                end;
              end;
          end;
        end;
      end;
    end;

  end else begin
    if SaveOldNames then
      aName:=aElement.Name;
    DMOperationManager.ChangeRef(FCurrentCollection,
                     aName, ElementRefU, aElement);
    DMOperationManager.OnCreateRefElement(ClassID, aElement);
    TMPCollection2.Add(aElement);
  end;

  DMOperationManager.FinishTransaction(TMPCollection, FCurrentCollection, leoChangeRef);
  TMPCollection2.Clear;
  
  fmChangeRef.pName.Visible:=True;
end;


procedure TDMBrowser.SetOptions;
begin
  if frmDMBrowserOptions=nil then
    frmDMBrowserOptions:=TfrmDMBrowserOptions.Create(Self);
  if frmDMBrowserOptions.ShowModal=mrOK then begin
    HideEmptyCollectionsFlag:=frmDMBrowserOptions.chbHideEmptyCollections.Checked;
    MakeNodeChilds(tvDataModel.Selected, False);
    FDetailMode:=frmDMBrowserOptions.rgDetailMode.ItemIndex;
  end
end;

destructor TDMBrowser.Destroy;
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

procedure TDMBrowser.CustomOperation(Index:Integer);
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
  if Get_Mode<0 then Exit;
  if not CheckCurrentElementSeletion then Exit;
  Document:=GetDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;
  DMOperationManager:=Document as IDMOperationManager;

  if FCurrentElement=nil then
    aElement:=FCurrentParentElement
  else
  if not FCurrentElement.Selected then
    aElement:=FCurrentElement
  else
    aElement:=Document.SelectionItem[Document.SelectionCount-1] as IDMElement;
  if (aElement.Ref<>nil) and
      (aElement.Ref.SpatialElement=aElement) then
    aElement:=aElement.Ref;

  if aElement.QueryInterface(IDMElement2, aElement2)<>0 then Exit;
  OperationName:=aElement2.GetOperationName(FCurrentCollectionIndex, Index);

  Param1:=-1;
  Param2:=-1;
  Param3:=-1;

  if (FCurrentElement=nil) or
      not FCurrentElement.Selected or
     (Document.SelectionCount=1) then begin
    DMOperationManager.StartTransaction(FCurrentCollection,
                                        leoExecute+Index, OperationName);
    aElement2:=aElement as IDMElement2;
    if not aElement2.DoOperation(FCurrentCollectionIndex, Index, Param1, Param2, Param3) then
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
      if not aElement2.DoOperation(FCurrentCollectionIndex, Index, Param1, Param2, Param3) then
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

function TDMBrowser.Get_CurrentElement: IUnknown;
begin
  Result:=FCurrentElement as IUnknown
end;

procedure TDMBrowser.OpenDocument;
begin
  inherited;
  if GetDocument<>nil then begin
    try
      InitTree;
    except
      raise
    end;
  end else begin
    ClearTreeData;
    ClearTree;
  end;
end;

procedure TDMBrowser.CloseDocument;
begin
  inherited;
  FCurrentElement:=nil;
end;

procedure TDMBrowser.tvDataModelKeyDown(Sender: TObject; var Key: Word;
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

procedure TDMBrowser.miPopupMenuClick(Sender: TObject);
var
  FormID, j:integer;
begin
  if FEditing then Exit;
  
  FormID:=Get_FormID;
  j:=TMenuItem(Sender).Tag;
{$IFDEF Demo}
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrMenuEvent,
              FormID, 0, meMouseMove, j, 0, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrPause, -1, -1, 1, 500, -1, '');
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrMenuEvent,
              FormID, 0, meLClick, j, 0, '');
{$ENDIF}
  DoAction(j)
end;

function TDMBrowser.PasteFromBuffer:boolean;
var
  CanPaste:WordBool;
  aDocument:IDMDocument;
begin
  Result:=False;
  if Get_Mode<0 then Exit;
  aDocument:=GetDocument;
  if (GEtDataModel.State and dmfFrozen)<>0 then Exit;
  (Get_DataModelServer as IDMCopyBuffer).Paste(FCurrentParentElement,
    FCurrentCollection, FCurrentLinkType, True, CanPaste);
  if CanPaste then
    Result:=True
end;

procedure TDMBrowser.miSwitchSelectionClick(Sender: TObject);
begin
  SwitchSelection(tvDataModel.Selected, False)
end;

procedure TDMBrowser.miUnselectClick(Sender: TObject);
begin
  UnselectAll;
end;

procedure TDMBrowser.miSelectAllClick(Sender: TObject);
begin
  SelectAll;
end;

procedure TDMBrowser.SelectionChanged(DMElement: OleVariant);
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

    if Get_Mode>=0 then begin
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

function TDMBrowser.Get_DetailMode: Integer;
begin
  Result:=FDetailMode
end;

procedure TDMBrowser.Set_DetailMode(Value: Integer);
begin
  FDetailMode:=Value
end;

procedure TDMBrowser.Set_Mode(Value: Integer);
begin
  inherited;
  InitTree;
end;

procedure TDMBrowser.tvDataModelEnter(Sender: TObject);
var
  DMEditorX:IDMEditorX;
begin
  inherited;
  DMEditorX:=Get_DMEditorX;
  if DMEditorX=nil then Exit;
  DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMBrowser.memCommentEnter(Sender: TObject);
begin
  inherited;
  Get_DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMBrowser.cbParameterEnter(Sender: TObject);
begin
  inherited;
  Get_DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMBrowser.cbCategoriesEnter(Sender: TObject);
begin
  inherited;
  Get_DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMBrowser.sgDetailsExit(Sender: TObject);
var
  Key:Word;
begin
  Key:=VK_Return;
  sgDetailsKeyDown(Sender, Key, []);
  memCommentExit(memComment);
end;

procedure TDMBrowser.ChangeParent;
var
  Server:IDataModelServer;
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  m, FormID:integer;
  aElement, SelectedElement:IDMElement;
begin
  if Get_Mode<0 then Exit;
  if FCurrentElement=nil then Exit;
  if not CheckCurrentElementSeletion then Exit;
  Server:=Get_DataModelServer as IDataModelServer;
  Document:=GetDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;
  DMOperationManager:=Document as IDMOperationManager;

  if fmSelectFromTree=nil then
    fmSelectFromTree:=TfmSelectFromTree.Create(Self);

  fmSelectFromTree.RootElement:=IUnknown(tvDataModel.Items[0].Data) as IDMElement;
  fmSelectFromTree.BuildTree(FCurrentElement);

//  Get_DMEditorX.Say('Изменим иерархический порядок зон', True, False);

  if fmSelectFromTree.ShowModal=mrOK then begin
    aElement:=fmSelectFromTree.CurrentElement;
    if aElement=nil then Exit;
    if aElement.Selected then Exit;

    FormID:=Get_FormID;
{$IFDEF Demo}
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -4, meMouseMove, aElement.ID, aElement.ClassID, '');
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -4, meLClick, aElement.ID, aElement.ClassID, '');
    (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
                FormID, -4, meLClick, -1, -1, '');
{$ENDIF}

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

  Server.RefreshDocument(rfFast);

end;

procedure TDMBrowser.sgDetailsTopLeftChanged(Sender: TObject);
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

procedure TDMBrowser.PopupMenuPopup(Sender: TObject);
var
  Node:TTreeNode;
begin
  Node:=tvDataModel.Selected;
  if not Node.Selected then
    Node.Selected:=True;
  SetMenuItems
end;

procedure TDMBrowser.HeaderMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  j, m, W, N, aCode:integer;
  Field:IDMField;
  Element, Element0:IDMElement;
  aDataModel:IDataModel;
  Elements:IDMCollection;
begin
  aDataModel:=GetDataModel;
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
      Elements:=FCurrentCollection;
      for m:=0 to Element.FieldCount_-1 do begin
        Field:=Element.Field_[m];
        aCode:=Field.Code;
        j:=0;
        while j<Elements.Count do begin
          Element0:=Elements.Item[j];
          if aDataModel.GetElementFieldVisible(Element0, aCode) then
            break
          else
            inc(j)
        end;
        if (j<Elements.Count)  and
          (Field.ValueType<>fvtText) then begin
          W:=W+Header.Sections[N+1].Width;
          if X<W then begin
            Header.Hint:=Element.FieldName[m];
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

procedure TDMBrowser.ShiftElement(Shift: integer);
var
  OperationManager:IDMOperationManager;
  Document:IDMDocument;
  j:integer;
begin
  if Get_Mode<0 then Exit;
  if FCurrentElement=nil then Exit;
  if FCurrentCollection=nil then Exit;
  Document:=GetDocument;
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

procedure TDMBrowser.GetTopObject(out CurrentObject: IUnknown; out CurrentObjectExpanded:WordBool;
                           out TopObject: IUnknown);
var
  Node:TTreeNode;
begin
  CurrentObject:=nil;
  TopObject:=nil;
  FCurrentObjectExpanded:=0;
  CurrentObjectExpanded:=False;
  if Get_Mode<0 then Exit;

  Node:=tvDataModel.Selected;
  if Node<>nil then begin
    CurrentObject:=IUnknown(Node.Data);
    CurrentObjectExpanded:=Node.Expanded;

    Node:=tvDataModel.TopItem;
    TopObject:=IUnknown(Node.Data);
  end;
  FCurrentObject:=CurrentObject;
  if CurrentObjectExpanded then
    FCurrentObjectExpanded:=1
  else
    FCurrentObjectExpanded:=0;
  FTopObject:=TopObject;
end;

procedure TDMBrowser.SetTopObject(const CurrentObject: IUnknown; CurrentObjectExpanded:WordBool;
                           const TopObject: IUnknown);
var
  aElement:IDMElement;
  aCollection:IDMCollection;
  CurrentNode, aNode:TTreeNode;
  Found:boolean;
begin
  if Get_Mode<0 then Exit;
  if CurrentObject=nil then Exit;
  if CurrentObject.QueryInterface(IDMElement, aElement)=0 then begin
    ExpandGenerations(aElement, Found, True);
    aNode:=tvDataModel.Selected;
  end else begin
    aCollection:=CurrentObject as IDMCollection;
    aElement:=aCollection.Parent;
    ExpandGenerations(aElement, Found, True);
    CurrentNode:=tvDataModel.Selected;
    if CurrentNode=nil then Exit;
    aNode:=CurrentNode.GetFirstChild;
    repeat
      if IUnknown(aNode.Data)=CurrentObject then
        Break
      else
        aNode:=CurrentNode.GetNextChild(aNode);
    until aNode=nil;
    if aNode<>nil then
      tvDataModel.Selected:=aNode;
  end;
  if aNode<>nil then
    aNode.Expanded:=CurrentObjectExpanded;

  if TopObject=nil then Exit;
  while (aNode<>nil) and
        (IUnknown(aNode.Data)<>TopObject) do
    aNode:=aNode.GetPrevVisible;
  if aNode<>nil then begin
//    tvDataModel.TopItem:=aNode;
    aNode.MakeVisible;
  end;
end;

procedure TDMBrowser.RenameElement;
var
  aDocument:IDMDocument;
  KeyboardState:TKeyboardState;
  Collection:IDMCollection;
  CollectionFlag:boolean;
  Unk:IUnknown;
begin
//  if FCurrentElement=nil then Exit;
  Unk:=IUnknown(tvDataModel.Selected.Data);
  if Unk=nil then Exit;

  aDocument:=GetDocument;

  CollectionFlag:=(Unk.QueryInterface(IDMCollection, Collection)=0);
  if not CollectionFlag and
     (aDocument.SelectionCount<2) then begin
    if (GetDataModel.State and dmfDemo)<>0 then begin
      DM_GetKeyboardLayoutName(FOldLayoutName);
      DM_LoadKeyboardLayout('00000419',   //Russion
       KLF_ACTIVATE or KLF_REORDER or KLF_REPLACELANG);

      DM_GetKeyboardState(KeyboardState);
      KeyboardState[VK_CAPITAL]:=0;
      DM_SetKeyboardState(KeyboardState);
    end;

    FEditing:=True;
    tvDataModel.ReadOnly:=False;

    tvDataModel.Selected.EditText;
  end else begin
    ReplaceDialog1.Options:=ReplaceDialog1.Options +
           [frHideMatchCase, frHideUpDown, frHideWholeWord];
    ReplaceDialog1.Execute;
  end;
end;

procedure TDMBrowser.ReplaceDialog1Replace(Sender: TObject);
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

  procedure DoReplaceText(const aElement:IDMElement);
  begin
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
begin

  aDocument:=GetDocument;
  OperationManager:=aDocument as IDMOperationManager;

  ReplaceText:=ReplaceDialog1.ReplaceText;
  FindText:=ReplaceDialog1.FindText;
  FindText:=AnsiUppercase(FindText);
  LF:=length(FindText);

  OperationManager.StartTransaction(FCurrentCollection, leoRename, rsRename);

  if aDocument.SelectionCount=0 then begin
    Unk:=IUnknown(tvDataModel.Selected.Data);
    if Unk=nil then Exit;
    if (Unk.QueryInterface(IDMCollection, Collection)<>0) then Exit;
    for j:=0 to Collection.Count-1 do begin
      aElement:=Collection.Item[j];
      DoReplaceText(aElement)
    end;
  end else begin
    for j:=0 to aDocument.SelectionCount-1 do begin
      aElement:=aDocument.SelectionItem[j] as IDMElement;
      if (aElement.Ref<>nil) and
         (aElement.Ref.SpatialElement=aElement) then
        aElement:=aElement.Ref;
      DoReplaceText(aElement)
    end;
  end;


  OperationManager.FinishTransaction(FCurrentCollection, FCurrentCollection, leoRename);

  ReplaceDialog1.CloseDialog;
end;


procedure TDMBrowser.tvDataModelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  aNode:TTreeNode;
  aElement:IDMElement;
  ht:THitTests;
begin
  if not (ssLeft in Shift) then Exit;
  if tvDataModel.Dragging then Exit;
//  if FDraggingElement<>nil then Exit;
  aNode:=tvDataModel.Selected;
  if aNode=nil then Exit;
  if aNode.Data=nil then Exit;
  if IUnknown(aNode.Data).QueryInterface(IDMElement, aElement)<>0 then Exit;
  if aElement<>FCurrentElement then Exit;
  if (FCurrentOperations and leoMove)=0 then Exit;
  ht:=tvDataModel.GetHitTestInfoAt(X,Y);
  if (htOnIcon in ht) then Exit;
  tvDataModel.BeginDrag(False, 15);
  FDraggingElement:=aElement;
end;

procedure TDMBrowser.tvDataModelDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  aNode:TTreeNode;
  aElement:IDMElement;
begin
  Accept:=False;
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

  aNode:=tvDataModel.DropTarget;
  if aNode=nil then Exit;
  if aNode.Data=nil then Exit;
  if IUnknown(aNode.Data).QueryInterface(IDMElement, aElement)<>0 then Exit;
  if aElement=FDraggingElement then Exit;
  if aElement.ClassID<>FDraggingElement.ClassID then Exit;
  if aElement.Parent<>FDraggingElement.Parent then Exit;
  Accept:=True;
end;

procedure TDMBrowser.tvDataModelDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  aNode:TTreeNode;
  aElement:IDMElement;
  j0, j:integer;
  OperationManager:IDMOperationManager;
begin
  aNode:=tvDataModel.DropTarget;
  if aNode=nil then Exit;
  if aNode.Data=nil then Exit;
  if IUnknown(aNode.Data).QueryInterface(IDMElement, aElement)<>0 then Exit;
  if aElement=FDraggingElement then Exit;
  if aElement.ClassID<>FDraggingElement.ClassID then Exit;
  if aElement.Parent<>FDraggingElement.Parent then Exit;
  if FCurrentCollection=nil then Exit;
  j0:=FCurrentCollection.IndexOf(FDraggingElement);
  if j0=-1 then Exit;
  j:=FCurrentCollection.IndexOf(aElement);
  if j=-1 then Exit;
  OperationManager:=GetDocument as IDMOperationManager;
  OperationManager.StartTransaction(FCurrentCollection, leoMove, rsMove);
  OperationManager.MoveElement( FCurrentCollection,
                    FDraggingElement, j, True);
  OperationManager.FinishTransaction(FDraggingElement, FCurrentCollection, leoMove);
  FDraggingElement:=nil;
end;

procedure TDMBrowser.tvDataModelStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  DragObject:=nil;
end;

procedure TDMBrowser.StopAnalysis(Mode: integer);
begin
  SetDetails;
end;

procedure TDMBrowser.SetDetailPanels;
begin
  if FCurrentParamKind = pkComment then begin
//    pControl.Visible:=True;
//    pTable.Visible:=False;
    pControl.Height:=PanelDetails.Height;
  end else begin
//    pControl.Visible:=False;
    pControl.Height:=0;
//    pTable.Visible:=True;
    sgDetails.Visible:=sgDetails.Cells[0,0]<>'';
    sgDetails.Invalidate;
  end;
end;

procedure TDMBrowser.TabControl1Change(Sender: TObject);
var
  CanSelect:boolean;
  j:integer;
begin
  if TabControl1.TabIndex=-1 then begin
    for j:=0 to sgDetails.ColCount-1 do
      sgDetails.Cols[j].Clear;
    sgDetails.RowCount:=0;
    Exit;
  end;
  FCurrentParamKind:=integer(pointer(TabControl1.Tabs.Objects[TabControl1.TabIndex]));
  cbParameter.Visible:=False;
  SetDetailsListKind;
  SetDetailPanels;
  FSetDetailsFlag:=True;
  sgDetailsSelectCell(nil, 0, 0, CanSelect);
  FSetDetailsFlag:=False;
end;

procedure TDMBrowser.RefreshElement(DMElement:OleVariant);
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
  tvDataModel.Selected.Collapse(True);
  sgDetails.Row:=OldRow;
  FRefreshingFlag:=False;
end;

procedure TDMBrowser.RestoreState;
var
  aCurrentObjectExpanded:WordBool;
begin
  if Get_Mode<0 then Exit;
  if FCurrentObject=nil then Exit;
//  if FTopObject=nil then Exit;
  aCurrentObjectExpanded:=(FCurrentObjectExpanded=1);
  SetTopObject(FCurrentObject, aCurrentObjectExpanded, FTopObject)
end;

procedure TDMBrowser.SaveState;
var
  aCurrentObjectExpanded:WordBool;
begin
  if Get_Mode<0 then Exit;
  GetTopObject(FCurrentObject, aCurrentObjectExpanded, FTopObject);
  if aCurrentObjectExpanded then
    FCurrentObjectExpanded:=1
  else
    FCurrentObjectExpanded:=0
end;

procedure TDMBrowser.GetMacrosNodeID(aNode: TTreeNode;
                 HT: integer; var ID,YY:integer);
var
  Unk:IUnknown;
  ParentElementNode:TTreeNode;
  aCollection:IDMCollection;
  aElement:IDMElement;
  ClassID:integer;
  j:integer;
begin
{$IFDEF Demo}
  Unk:=IUnknown(aNode.Data);
  if Unk=nil then Exit;
  YY:=HT;
  if Unk.QueryInterface(IDMCollection, aCollection)=0  then begin
    ParentElementNode:=aNode.Parent;
    if ParentElementNode<>nil then begin
      Unk:=IUnknown(ParentElementNode.Data);
      aElement:=Unk as IDMElement;
    end else
      aElement:=GetDataModel as IDMElement;
    j:=0;
    while j<aDataModel.GetElementCollectionCount(aElement) do begin
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
{$ENDIF}
end;

procedure TDMBrowser.InitNodeClickMacros(aNode: TTreeNode; HT: integer);
var
  ID:integer;
  DMEditor:IDMEditorX;
  DMMacrosManager:IDMMacrosManager;
  FormID, YY:integer;
begin
{$IFDEF Demo}
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
{$ENDIF}
end;

{$IFDEF Demo}
function TDMBrowser.DoMacrosStep(RecordKind, ControlID, EventID, X, Y: Integer;
  const S: WideString):WordBool;
var
  DMMacrosManager:IDMMacrosManager;
  CursorStepLength, ClassID, ID, YY, HT, CollectionID, H, j, m:integer;
  P, PS:TPoint;
  aElement, DataModelE:IDMElement;
  Found:boolean;
  HitTest:THitTest;
  ShiftState:TShiftState;
  Node, PrevNode:TTreeNode;
  R, RPrev:TRect;
  aX, aY, aTag:integer;

  function GetTreeNode:TTreeNode;
  begin
    ID:=ord(X);
    YY:=ord(Y);
    HT:=YY and $FF;
    CollectionID:=((YY shr 8) and $FF)-1;
    ClassID:=(YY shr 16) and $FF;
    aElement:=DataModelE.Collection[ClassID].Item[ID];

    Result:=ExpandGenerations(aElement, Found, False);

    if CollectionID<>-1 then begin
      Result:=Result.Item[CollectionID];
      Result.MakeVisible;
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
          Node:=GetTreeNode;
          if HitTest=htOnIcon then begin
            R:=Node.DisplayRect(True);
            PrevNode:=Node.Parent;
            RPrev:=PrevNode.DisplayRect(True);
            P.X:=RPrev.Left+5;
            P.Y:=(R.Top+R.Bottom) div 2;
            tvDataModelMouseDown(tvDataModel, mbLeft, ShiftState, P.X, P.Y);
          end else begin
            tvDataModel.Selected:=Node;
          end;
        end;
      meRClick:
        begin
          Node:=GetTreeNode;
          R:=Node.DisplayRect(True);
          P.X:=(R.Left+R.Right) div 2;
          P.Y:=(R.Top+R.Bottom) div 2;
          P:=FMacrosControl.ClientToScreen(P);
          Result:=False;
          DMMacrosManager.PauseMacros(500);
          PopupMenu.Popup(P.X, P.Y);
        end;
      meDoubleClick:
        begin
          Node:=GetTreeNode;
          Node.Expand(False);
        end;
      meMouseMove:
        begin
          Node:=GetTreeNode;

          R:=Node.DisplayRect(True);
          case HitTest of
          htOnItem:
            begin
              P.X:=(R.Left+R.Right) div 2;
              P.Y:=(R.Top+R.Bottom) div 2;
            end;
          htOnIcon:
            begin
              PrevNode:=Node.Parent;
              RPrev:=PrevNode.DisplayRect(True);
              P.X:=RPrev.Left+5;
              P.Y:=(R.Top+R.Bottom) div 2;
            end;
          htOnButton:
            begin
              PrevNode:=Node.Parent;
              RPrev:=PrevNode.DisplayRect(True);
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
          Node:=fmSelectFromTree.tvDataModel.Items[j];
          if IDMElement(Node.Data)=aElement then
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
          fmSelectFromTree.tvDataModel.Selected:=Node;
          DMMacrosManager.PauseMacros(500);
        end;
      meMouseMove:
        begin
          Node.MakeVisible;
          R:=Node.DisplayRect(True);
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
{$ENDIF}

procedure TDMBrowser.tvDataModelDblClick(Sender: TObject);
var
  FormID:integer;
begin
  FormID:=Get_FormID;
{$IFDEF Demo}
  (Get_DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrFormEvent,
            FormID, -1, meDoubleClick, 0, 0, '')
{$ENDIF}
end;

constructor TDMBrowser.Create(aOwner: TComponent);
begin
  inherited;
  tvDataModel:=TTreeView.Create(Self);
  tvDataModel.Parent:=Self;
  with tvDataModel do begin
    Left:=0;
    Top:=0;
    Width:=300;
    Height:=354;
    Align:=alClient;
    HideSelection:=False;
    Images:=ilNodes;
    Indent:=19;
    MultiSelectStyle:=[msControlSelect, msShiftSelect, msVisibleOnly];
    PopupMenu:=Self.PopupMenu;
    ReadOnly:=True;
    RightClickSelect:=True;
    TabOrder:=0;
    ToolTips:=False;
    OnChange:=tvDataModelChange;
    OnCollapsed:=tvDataModelCollapsed;
    OnCustomDrawItem:=tvDataModelCustomDrawItem;
    OnDblClick:=tvDataModelDblClick;
    OnDeletion:=tvDataModelDeletion;
    OnDragDrop:=tvDataModelDragDrop;
    OnDragOver:=tvDataModelDragOver;
    OnEdited:=tvDataModelEdited;
    OnEnter:=tvDataModelEnter;
    OnExpanded:=tvDataModelExpanded;
    OnGetImageIndex:=tvDataModelGetImageIndex;
    OnGetSelectedIndex:=tvDataModelGetSelectedIndex;
    OnKeyDown:=tvDataModelKeyDown;
    OnMouseDown:=tvDataModelMouseDown;
    OnMouseMove:=tvDataModelMouseMove;
    OnStartDrag:=tvDataModelStartDrag;
  end
end;

procedure TDMBrowser.FormShow(Sender: TObject);
begin
  inherited;
  if FSizeSetted then Exit;
  TabControl1.Width:=Width div 2;
  FSizeSetted:=True;
end;

procedure TDMBrowser.FormResize(Sender: TObject);
begin
  inherited;
  SetDetailPanels;
end;

procedure TDMBrowser.ClearTreeData;
var j:integer;
begin
  FClearTreeFlag:=True;
  try
  try
  for j:=0 to tvDataModel.Items.Count-1 do
    tvDataModel.Items[j].Data:=nil;
  except
    raise
  end;
  finally
    FClearTreeFlag:=False;
  end;
end;

procedure TDMBrowser.sgDetailsMouseDown(Sender: TObject;
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

procedure TDMBrowser.miSelectFieldElementClick(Sender: TObject);
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
  if theElement<>nil then
    theElement.Selected:=True;
end;

procedure TDMBrowser.UpdateCurrentElement;
var
  Unk:IUnknown;
  aElement:IDMElement;
begin
  if tvDataModel.Selected=nil then Exit;
  Unk:=IUnknown(tvDataModel.Selected.Data);
  if Unk.QueryInterface(IDMElement, aElement)<>0 then
    aElement:=nil;
  Set_CurrentElement(aElement);
end;

{
initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TDMBrowserX,
    Class_DMBrowserX,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmApartment);
}

procedure TDMBrowser.memCommentExit(Sender: TObject);
var
  Key:Word;
begin
  Key:=VK_Return;
  memCommentKeyDown(Sender, Key, []);
end;

procedure TDMBrowser.memCommentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  aDocument:IDMDocument;
  V:Variant;
begin
  case Key of
  VK_RETURN:
    begin
      if Get_Mode<0 then Exit;
      aDocument:=GetDocument;
      if (GetDataModel.State and dmfFrozen)<>0 then Exit;
      if FMemoFieldIndex=-1 then Exit;
      if FCurrentElement=nil then Exit;
      if ssShift in Shift then Exit;

      V:=memComment.Lines.Text;
      FCurrentFieldIndex:=FMemoFieldIndex;
      SetFieldValue(V, FCurrentElement);
    end;
  end;
end;

procedure TDMBrowser.sgDetailsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  aCol, aRow, FieldIndex:integer;
begin
  sgDetails.MouseToCell(X, Y, aCol, aRow);
  sgDetails.ShowHint:=((aCol=0) and (FDetailMode=dmdList) and
                      (FCurrentElement<>nil));
  if not sgDetails.ShowHint then Exit;

  FieldIndex:=integer(pointer(sgDetails.Objects[1, ARow]));
  sgDetails.Hint:=FCurrentElement.Field_[FieldIndex].Hint;
end;

procedure TDMBrowser.miGoToLastElementClick(Sender: TObject);
var
  aDocument:DMDocument;
begin
  aDocument:=GetDocument;
  aDocument.UndoSelection;
end;

end.
