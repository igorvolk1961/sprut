unit DMListFormU;
//_____вариант  Golubev  с фильтром  ClassAlias_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface


uses
  DM_Windows, DM_AxCtrls,
  Types, SysUtils, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU,
  SpatialModelLib_TLB, Classes;

const
  rsDelete='”даление элемента';
  fcAll=0;        //'¬се элементы модели'
  fcUserDefineded=1;   //'Ёлементы, модифицированные пользователем'
  fcIsEmpty=2;      //'ѕустые элемент', pointer(2));
  fcNilSpatialElement=3;  //'Ёлементы без пространственного представлени€'

type

  TDMListForm = class(TDMPage)
    pn_Client: TPanel;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    lbox_BackRefHolders: TListBox;
    cb_BackRefHolders: TComboBox;
    Panel3: TPanel;
    lbox_BackRef: TListBox;
    Panel4: TPanel;
    bt_SelectAll: TButton;
    bt_UnSelectAll: TButton;
    il_Bitmap: TImageList;
    cbFilter: TComboBox;
    Button1: TButton;


    procedure FormCreate(Sender: TObject);
    procedure cb_ColumnClick(Sender: TObject);
    procedure lbox_BackRefHoldersClick(Sender: TObject);
    procedure lbox_BackRefClick(Sender: TObject);
    procedure lbox_BackRefDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure bt_SelectAllClick(Sender: TObject);
    procedure cb_BackRefHoldersClick(Sender: TObject);
    procedure cbFilterClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FSelChangeFlag:boolean;
    FSettingFilterFlag:boolean;
    FOldClassIndex:integer;
    FOldBackRefHolderIndex:integer;
    bmSelect:TBitmap;
    procedure Set_BackRefHolder;
    procedure lbox_BackRefHoldersExecute(ItemIndex: Integer);
    procedure DeleteElement;
  protected
    procedure SelectionChanged(DMElement:OleVariant); override;
    procedure DocumentOperation(ElementsV,
      CollectionV: OleVariant; DMOperation, nItemIndex: Integer); override; safecall;
    procedure OpenDocument; override; safecall;
    procedure RefreshDocument(FlagSet:integer); override; safecall;

    function DoAction(ActionCode: integer):WordBool; override; safecall;
    procedure SetState(ClassIndex, SubKindIndex: Integer);safecall;

    function Substitute(const aElement:IDMElement):IDMElement; virtual;
    function GetAddFlag(const aElement:IDMElement; FilterIndex:integer):boolean; virtual;
    procedure MakeFilterList; virtual;
  public
    procedure Initialize; override;
  end;

implementation

{$R *.dfm}

{ TDMListFormX }

procedure TDMListForm.Initialize;
begin
  inherited Initialize;
  FOldClassIndex:=-1;
  FOldBackRefHolderIndex:=-1;
end;

procedure TDMListForm.FormCreate(Sender: TObject);
begin
  cbFilter.ItemIndex:=0;
  cb_BackRefHolders.ItemIndex:=0;
  lbox_BackRefHolders.ItemIndex:=0;
  lbox_BackRef.ItemIndex:=0;
  lbox_BackRef.Style:=lbOwnerDrawFixed;
  bmSelect:=TBitmap.Create;
  il_Bitmap.GetBitmap(0,bmSelect);

end;

procedure TDMListForm.DocumentOperation(ElementsV,
  CollectionV: OleVariant; DMOperation, nItemIndex: Integer);
begin
  Set_BackRefHolder;
end;

procedure TDMListForm.OpenDocument;
begin
  Set_BackRefHolder;
end;

procedure TDMListForm.RefreshDocument;
begin
end;

procedure TDMListForm.Set_BackRefHolder;
var
  aDataModel:IDataModel;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  i,j,IP, aCount:integer;
  aElement:IDMElement;
  sListElement: WideString;
  ClassID: integer;
  sElementFlag:boolean;
  OldBackRefHolderIndex:integer;
  P:pointer;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  if Server=nil then Exit;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  aDataModel:=DMDocument.DataModel as IDataModel;
  aCount:=aDataModel.BackRefHolders.Count;
  if aCount=0 then Exit;

  // заполненме списка фильтра (cb_BackRefHolders)
  cb_BackRefHolders.Items.Clear;
  for i:=0 to aCount-1  do begin
    aElement:=aDataModel.BackRefHolders.Item[i];
    if aElement.Ref.OwnerCollection<>nil then
      sListElement:=aElement.Ref.OwnerCollection.ClassAlias[i]
    else
      sListElement:=aElement.Ref.Name;
    ClassID:=aElement.Ref.ClassID;
    sElementFlag:=True;
   // нет ли повтора с уже записанным
    for j:=0 to cb_BackRefHolders.Items.Count-1 do begin
      P:=pointer(cb_BackRefHolders.Items.Objects[j]);
      if P<>nil then
        IP:=integer(P)
      else
        IP:=-1;
      if IP=ClassID then
       sElementFlag:=False;
    end;
    if sElementFlag then begin
      if ClassID<>-1 then
        cb_BackRefHolders.Items.AddObject(sListElement,pointer(ClassID))
      else
        cb_BackRefHolders.Items.AddObject(sListElement,nil)
    end;
  end;

  if (FOldClassIndex<>-1) and
     (FOldClassIndex<cb_BackRefHolders.Items.Count) then
    cb_BackRefHolders.ItemIndex:=FOldClassIndex
  else
    cb_BackRefHolders.ItemIndex:=0;

  OldBackRefHolderIndex:=FOldBackRefHolderIndex;
  cb_BackRefHoldersClick(cb_BackRefHolders);
  FOldBackRefHolderIndex:=OldBackRefHolderIndex;

  if (FOldBackRefHolderIndex<>-1) and
     (FOldBackRefHolderIndex<lbox_BackRefHolders.Items.Count) then
    lbox_BackRefHolders.ItemIndex:=FOldBackRefHolderIndex
  else
    lbox_BackRefHolders.ItemIndex:=0;
  lbox_BackRefHoldersClick(lbox_BackRefHolders);
end;

procedure TDMListForm.cb_ColumnClick(Sender: TObject);
var
 aItemIndex:integer;
begin
  aItemIndex:=lbox_BackRefHolders.ItemIndex;
  lbox_BackRefHoldersExecute(aItemIndex);
end;

procedure TDMListForm.lbox_BackRefClick(Sender: TObject);
var
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  aElement:IDMElement;
  aCount,aItemIndex:integer;
  P:pointer;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  if Server=nil then Exit;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  aCount:=lbox_BackRef.Count;
  if aCount=0 then Exit;

  FSelChangeFlag:=False;
  aItemIndex:=lbox_BackRef.ItemIndex;
  P:=pointer(lbox_BackRef.Items.Objects[aItemIndex]);
  aElement:=IDMElement(P);

  aElement:=Substitute(aElement);

  if not(DM_GetKeyState(VK_CONTROL)<0) then
    DMDocument.ClearSelection(aElement);

  if aElement.Selected then
    aElement.Selected:=False
  else
    aElement.Selected:=True;

  FSelChangeFlag:=True;

  lbox_BackRef.Invalidate;
  Application.ProcessMessages;

end;

procedure TDMListForm.lbox_BackRefHoldersClick(Sender: TObject);
var
 aItemIndex, FilterIndex:integer;
begin
  aItemIndex:=lbox_BackRefHolders.ItemIndex;
  FOldBackRefHolderIndex:=aItemIndex;
  if not FSettingFilterFlag then begin
    FilterIndex:=cbFilter.ItemIndex;
    MakeFilterList;
    if FilterIndex<cbFilter.Items.Count then
      cbFilter.ItemIndex:=FilterIndex
    else
      cbFilter.ItemIndex:=0;
  end;
  lbox_BackRefHoldersExecute(aItemIndex);
  lbox_BackRef.ItemIndex:=0;
end;

procedure TDMListForm.lbox_BackRefHoldersExecute(ItemIndex:integer);
var
  aBackRefHolder:IDMBackRefHolder;
  i, aCount,aLenStr:integer;
  aElement:IDMElement;
  P:pointer;
  AddFlag:boolean;
begin
  if ItemIndex<0 then
    ItemIndex:=0;
  if ItemIndex<lbox_BackRefHolders.Items.Count then begin
    P:=pointer(lbox_BackRefHolders.Items.Objects[ItemIndex]);
    aBackRefHolder:=IDMElement(P) as IDMBackRefHolder;
    lbox_BackRef.Items.Clear;
  end else begin
    lbox_BackRef.Items.Clear;
    Exit;
  end;

  aCount:=aBackRefHolder.BackRefs.Count;
  if aCount=0 then Exit;

  // заполненме правого (BackRef) списка
  aLenStr:=0;
  for i:=0 to aCount-1  do begin
   aElement:=aBackRefHolder.BackRefs.Item[i];
   if aElement.ClassID=_Layer then Continue;
     AddFlag:=GetAddFlag(aElement, cbFilter.ItemIndex);
     if AddFlag then begin
       lbox_BackRef.Items.AddObject(aElement.Name,pointer(aElement));
       if aLenStr<Length(aElement.Name) then
         aLenStr:=Length(aElement.Name);
     end
  end;

end;

procedure TDMListForm.SelectionChanged(DMElement:OleVariant);
var
 aDocument:IDMDocument;
 aElement0:IDMElement;
 aItemIndex, TopIndex:integer;
 Unk:IUnknown;
begin
  if not Visible then Exit;
  if not FSelChangeFlag then begin
   FSelChangeFlag:=true;
   Exit end;

  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if aDocument=nil then Exit;

  Unk:=DMElement;
  aElement0:=Unk as IDMElement;
  if aElement0=nil then begin
    lbox_BackRef.Invalidate;
    Exit;
  end;

//  aCount:= aDocument.SelectionCount;
//  if aCount=0 then Exit;
//  aElement0:=aDocument.SelectionItem[aCount-1] as IDMElement; // последний выделен.элемент
//  if aElement0.QueryInterface(ISpatialElement, aElement0S)<>0 then Exit;
  if aElement0.Ref=nil then Exit;
  if (aElement0.Ref.SpatialElement=aElement0) then
      aElement0:=aElement0.Ref;
  if aElement0.Ref=nil then Exit;

  aItemIndex:=lbox_BackRef.Items.IndexOfObject(pointer(aElement0));
  if aItemIndex=-1 then Exit;
  lbox_BackRef.ItemIndex:=aItemIndex;

  TopIndex:=aItemIndex-((lbox_BackRef.Height div lbox_BackRef.ItemHeight)div 2);
  if TopIndex<0 then
    TopIndex:=0;
  if lbox_BackRef.TopIndex<>TopIndex then
    lbox_BackRef.TopIndex:=TopIndex
  else
    lbox_BackRef.Invalidate;

end;

procedure TDMListForm.lbox_BackRefDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
 aString:string;
 aElement, aParent:IDMElement;
begin
  aElement:=IDMElement(pointer(lbox_BackRef.Items.Objects[Index]));

  aString:=string(lbox_BackRef.Items[Index]);
  aParent:=aElement.Parent;
  if aParent<>nil then
    aString:=aString+' / '+aParent.Name;

  aElement:=Substitute(aElement);

  if aElement.Selected then begin
   lbox_BackRef.Canvas.Font.Color:=clBlue;
   lbox_BackRef.Canvas.BrushCopy(
           Bounds(Rect.Left+2,Rect.Top,bmSelect.Width,bmSelect.Height),
           bmSelect, Bounds(0,0,bmSelect.Width,bmSelect.Height), clBlack);
  end else begin
   lbox_BackRef.Canvas.Font.Color:=clBlack;
  end;
  if lbox_BackRef.Selected[Index] then begin
   lbox_BackRef.Canvas.Brush.Color:=clWindow;
  end;


  lbox_BackRef.Canvas.TextOut(Rect.Left+16,Rect.Top,aString);
end;

procedure TDMListForm.bt_SelectAllClick(Sender: TObject);
var
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  j, aCount,aCountHolders,aTag,OldState,OldSelectState:integer;
  aElement:IDMElement;
  P:pointer;
  aDataModel:IDataModel;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  if Server=nil then Exit;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;

  aCountHolders:=lbox_BackRefHolders.Count;
  if aCountHolders=0 then Exit;

  FSelChangeFlag:=False;
  aDataModel:=GetDataModel;
  OldState:=aDataModel.State;
  OldSelectState:=OldState and dmfSelecting;
  aDataModel.State:=OldState or dmfSelecting;
  try
  aTag:=TControl(Sender).Tag;

  if not(DM_GetKeyState(VK_CONTROL)<0) then
   if aTag=1 then
     DMDocument.ClearSelection(nil);
   aElement:=nil;
   aCount:=lbox_BackRef.Items.Count;
   for j:=0 to aCount-1  do  begin
    P:=pointer(lbox_BackRef.Items.Objects[j]);
    aElement:=IDMElement(P);
    aElement:=Substitute(aElement);
    case aTag of
     1:aElement.Selected:=True;
     2:aElement.Selected:=False;
    end;
   end;

  finally
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
  end;
  DMDocument.Server.SelectionChanged(aElement);
//  lbox_BackRef.Refresh;
  lbox_BackRef.Invalidate;
  Application.ProcessMessages;
  FSelChangeFlag:=True;
end;

procedure TDMListForm.cb_BackRefHoldersClick(Sender: TObject);
var
  aDataModel:IDataModel;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  i, aCount,aItemIndex:integer;
  aElement:IDMElement;
  ClassID, aClassID: integer;
  P:pointer;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  if Server=nil then Exit;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  aDataModel:=DMDocument.DataModel as IDataModel;
  aCount:=aDataModel.BackRefHolders.Count;
  if aCount=0 then Exit;

  // заполненме  левого (lbox_BackRefHolders) списка
  lbox_BackRefHolders.Items.Clear;
  aItemIndex:=cb_BackRefHolders.ItemIndex;

  P:=pointer(cb_BackRefHolders.Items.Objects[aItemIndex]);
  if P<>nil then
    ClassID:=integer(P)
  else
    ClassID:=-1;
  FOldClassIndex:=aItemIndex;
  for i:=0 to aCount-1  do begin
    aElement:=aDataModel.BackRefHolders.Item[i];
    aClassID:=aElement.Ref.ClassID;
    if aClassID=ClassID then
      lbox_BackRefHolders.Items.AddObject(aElement.Name,pointer(aElement));
  end;
  lbox_BackRefHoldersClick(lbox_BackRefHolders);
end;

procedure TDMListForm.cbFilterClick(Sender: TObject);
begin
  FSettingFilterFlag:=True;
  Set_BackRefHolder;
  FSettingFilterFlag:=False;
end;

function TDMListForm.DoAction(ActionCode: integer): WordBool;
var
  aDocument:IDMDocument;
begin
  Result:=False;
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDocument.State and dmfFrozen)<>0 then Exit;

  case ActionCode of
  dmbaDelete: DeleteElement;
  else
    Result:=inherited DoAction(ActionCode)
  end;
end;

procedure TDMListForm.DeleteElement;
var
  OperationManager:IDMOperationManager;
  aElement:IDMElement;
  OldState, OldSelectState:integer;
  aDocument:IDMDocument;
  Collection2:IDMCollection2;
  DataModel:IDataModel;
begin
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (aDocument.State and dmfFrozen)<>0 then Exit;
  DataModel:=aDocument.DataModel as IDataModel;

  Collection2:=DataModel.CreateCollection(-1, nil) as IDMCollection2;

  OperationManager:=aDocument as IDMOperationManager;
  OperationManager.StartTransaction(nil, leoDelete, rsDelete);

  OldState:=aDocument.State;
  OldSelectState:=OldState and dmfSelecting;
  aDocument.State:=aDocument.State or dmfSelecting;

  try
  aElement:=nil;
  while aDocument.SelectionCount>0 do begin
    aElement:=aDocument.SelectionItem[0] as IDMElement;
    if (aElement.SpatialElement<>nil) and
       (aElement.SpatialElement.Ref=aElement) then
    aElement:=aElement.SpatialElement;
    aElement.Selected:=False;
    Collection2.Add(aElement);
  end;

  if (Collection2 as IDMCollection).Count=0 then begin
    aDocument.State:=OldState;
    Exit;
  end;

  OperationManager.DeleteElements(Collection2, True);
  finally
    aDocument.State:=aDocument.State and not dmfSelecting or OldSelectState;
  end;
  OperationManager.FinishTransaction(aElement, nil, leoDelete);
end;

procedure TDMListForm.SetState(ClassIndex, SubKindIndex: Integer);
var
  j, aClassID:integer;
  P:pointer;
  aBackRefHolderE:IDMElement;
begin
  j:=0;
  while j<cb_BackRefHolders.Items.Count do begin
    P:=pointer(cb_BackRefHolders.Items.Objects[j]);
    if P<>nil then
      aClassID:=integer(P)
    else
      aClassID:=-1;

    if aClassID=ClassIndex then
      Break
    else
      inc(j)
  end;
  if j<cb_BackRefHolders.Items.Count then begin
    cb_BackRefHolders.ItemIndex:=j;
    cb_BackRefHoldersClick(cb_BackRefHolders);

    j:=0;
    while j<lbox_BackRefHolders.Count do begin
      P:=pointer(lbox_BackRefHolders.Items.Objects[j]);
      aBackRefHolderE:=IDMElement(P);
      if aBackRefHolderE.Ref.ID=SubKindIndex then
        Break
      else
        inc(j)
    end;
    if j<lbox_BackRefHolders.Count then begin
      lbox_BackRefHolders.ItemIndex:=j;
      lbox_BackRefHoldersClick(lbox_BackRefHolders);
    end;
  end;


end;

function TDMListForm.Substitute(const aElement: IDMElement): IDMElement;
begin
  Result:=aElement
end;

function TDMListForm.GetAddFlag(const aElement:IDMElement; FilterIndex:integer):boolean;
var
  FilterCode:integer;
begin
  FilterCode:=integer(pointer(cbFilter.Items.Objects[FilterIndex]));
  case FilterCode of
  fcAll:               Result:=True;
  fcUserDefineded:     Result:=aElement.UserDefineded;
  fcIsEmpty:           Result:=aElement.IsEmpty;
  fcNilSpatialElement: Result:=aElement.SpatialElement=nil;
  else
     Result:=True;
  end;
end;


procedure TDMListForm.MakeFilterList;
begin
  cbFilter.Clear;
  cbFilter.Items.AddObject('¬се элементы модели', pointer(fcAll));
  cbFilter.Items.AddObject('Ёлементы, модифицированные пользователем', pointer(fcUserDefineded));
  cbFilter.Items.AddObject('ѕустые элемент', pointer(fcIsEmpty));
  cbFilter.Items.AddObject('Ёлементы без пространственного представлени€', pointer(fcNilSpatialElement));
end;

procedure TDMListForm.Button1Click(Sender: TObject);
var
  aCount, j, OldState, OldSelectState:integer;
  TMPList:TList;
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  aElement:IDMElement;
  P:pointer;
  aDataModel:IDataModel;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  if Server=nil then Exit;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  aDataModel:=GetDataModel;


  TMPList:=TList.Create;

  FSelChangeFlag:=False;
  OldState:=aDataModel.State;
  OldSelectState:=OldState and dmfSelecting;
  aDataModel.State:=OldState or dmfSelecting;

  try
  aElement:=nil;
  aCount:=lbox_BackRef.Items.Count;
  for j:=0 to aCount-1  do  begin
    P:=pointer(lbox_BackRef.Items.Objects[j]);
    aElement:=IDMElement(P);
    aElement:=Substitute(aElement);
    if aElement.Selected then begin
      TMPList.Add(pointer(aElement))
    end;
  end;
  DMDocument.ClearSelection(nil);
  for j:=0 to TMPList.Count-1  do  begin
    aElement:=IDMElement(TMPList[j]);
    aElement.Selected:=True;
  end;
  finally
    TMPList.Free;
    aDataModel.State:=aDataModel.State and not dmfSelecting or OldSelectState;
  end;
  DMDocument.Server.SelectionChanged(aElement);
  lbox_BackRef.Invalidate;
  Application.ProcessMessages;
  FSelChangeFlag:=True;
end;

end.
