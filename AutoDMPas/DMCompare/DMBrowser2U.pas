unit DMBrowser2U;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_Windows, DM_Messages, Types,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, StdVcl, ImgList, Menus, Printers,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMBrowserU, DMBrowser_TLB,
  ComCtrls, MyComCtrls, DMPageU, DMElementU;

const
  pkComment = $00000008;
const
  SuffixDivider='/';

type
  TDMBrowser2 = class(TDMBrowser, ITreeViewForm)
  private
    FDocumentIndex:integer;
    procedure InitTree2(Index:integer);
  protected
    function GetDocument:IDMDocument; override; safecall;
    procedure OpenDocument0; override; safecall;
    procedure OpenDocument1; override; safecall;
    procedure MakeRootNodes; override;
    procedure MakeNodeChilds(ParentNode: TTreeNode; ClearFirst:boolean); override;
  public
    function DoAction(ActionCode: integer):WordBool; override; safecall;
    procedure Initialize; override;
  end;

var
  DMBrowser2: TDMBrowser2;

implementation
{$R *.dfm}


function TDMBrowser2.DoAction(ActionCode: integer): WordBool;
begin
  Result:=False;
  if GetDocument=(Get_DataModelServer as IDataModelServer).CurrentDocument then
    Result:=inherited DoAction(ActionCode)
end;

function TDMBrowser2.GetDocument: IDMDocument;
begin
  if FDocumentIndex=-1 then
    Result:=inherited GetDocument
  else
    Result:=(Get_DataModelServer as IDataModelServer).Document[FDocumentIndex]
end;

procedure TDMBrowser2.Initialize;
begin
  inherited;
  FDocumentIndex:=-1;
end;

procedure TDMBrowser2.InitTree2(Index: integer);
begin
  FDocumentIndex:=Index;
  FExpandingGenerationsFlag:=False;
  InitTree;
end;

procedure TDMBrowser2.MakeNodeChilds(ParentNode: TTreeNode;
  ClearFirst: boolean);
var
  j, CollectionCount: integer;
  Collection:IDMCollection;
  CollectionName:WideString;
  Element:IDMElement;
  Unk, aUnk:IUnknown;

  aCurrentRefSource:IDMCollection;
  aCurrentClassCollections:IDMClassCollections;
  aCurrentOperations:integer;
  aCurrentLinkType:integer;
  aChildNode, aTreeNode:TTreeNode;
  aDataModelE, aParentElement, ParentElement:IDMElement;
  theCollection2, aCollection2:IDMCollection2;
  Server:IDataModelServer;
  m:integer;
  aElement:IDMElement;
  aDocument:IDMDocument;
begin
  Cursor := crHourGlass;
  tvDataModel.Selected := ParentNode;
  if ParentNode=nil then Exit;
  if ParentNode.Data=nil then Exit;

  Server:=Get_DataModelServer as IDataModelServer;
  if Server.DocumentCount<2 then
    aDataModelE:=nil
  else begin
    if FDocumentIndex=0 then
      aDocument:=Server.Document[1] as IDMDocument
    else
      aDocument:=Server.Document[0] as IDMDocument;
    aDataModelE:=aDocument.DataModel as IDMElement;
  end;

  tvDataModel.Items.BeginUpdate;
  try
    if Succeeded(IUnknown(ParentNode.Data).QueryInterface(IDMElement, Element)) then begin
      if aDataModelE<>nil then begin
        theCollection2:=aDataModelE.Collection[Element.ClassID] as IDMCollection2;
        aElement:=theCollection2.GetItemByID(Element.ID);
      end else
        aElement:=nil;

      CollectionCount:=Element.CollectionCount;
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
            if aElement<>nil then
              aCollection2:=aElement.Collection[j] as IDMCollection2
            else
              aCollection2:=nil;
            Element.GetCollectionProperties(j, CollectionName,
                aCurrentRefSource,
                aCurrentClassCollections,
                aCurrentOperations, aCurrentLinkType);
            if (aCollection2=nil) or
               (not aCollection2.IsSimilarTo(Collection, aCurrentLinkType)) then begin

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
    end else
    if IUnknown(ParentNode.Data).QueryInterface(IDMCollection, Collection)=0 then begin
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

      aCollection2:=nil;
      ParentElement:=Collection.Parent;
      if (ParentElement<>nil) and
         (aDataModelE<>nil) then begin
        if ParentElement.ClassID=-1 then
          aCollection2:=aDataModelE.Collection[Collection.ClassID] as IDMCollection2
        else begin
          theCollection2:=aDataModelE.Collection[ParentElement.ClassID] as IDMCollection2;
          aParentElement:=theCollection2.GetItemByID(ParentElement.ID);
          if aParentElement<>nil then begin
            m:=0;
            while m<ParentElement.CollectionCount do begin
              if ParentElement.Collection[m]=Collection then
                Break
             else
                inc(m)
            end;
            if m<ParentElement.CollectionCount then
              aCollection2:=aParentElement.Collection[m] as IDMCollection2
          end;
        end;
      end;

      for j := 0 to Collection.Count-1 do begin
        Unk:=Collection.Item[j] as IUnknown;
        aChildNode:=ParentNode.getFirstChild;
        while aChildNode<>nil do begin
          aUnk:=IUnknown(aChildNode.Data);
          if Unk=aUnk then
            Break
          else
           aChildNode:=aChildNode.getNextSibling;
        end;
        if aChildNode=nil then begin
          Element:=Unk as IDMElement;
          if aCollection2<>nil then
            aElement:=aCollection2.GetItemSimilarTo(Element)
          else
            aElement:=nil;
          if aElement=nil then begin
            if j<ParentNode.Count then
              tvDataModel.Items.InsertObject(ParentNode.Item[j],
                                Collection.Item[j].Name, pointer(Unk))
            else
              tvDataModel.Items.AddChildObject(tvDataModel.Selected,
                                Collection.Item[j].Name, pointer(Unk));
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


procedure TDMBrowser2.MakeRootNodes;
var
  Document, aDocument:IDMDocument;
  DataModel, aDataModel:IDataModel;
  j, Mode, Operations, LinkType:integer;
  Text:string;
  Data:pointer;
  RootObject, aRootObject:IUnknown;
  RootObjectName: WideString;
  Unk, aUnk:IUnknown;
  Server:IDataModelServer;
  AddItemFlag:boolean;
  Collection, aCollection:IDMCollection;
begin
  Mode:=Get_Mode;

  Server:=Get_DataModelServer as IDataModelServer;
  if Server.DocumentCount<2 then
    aDataModel:=nil
  else begin
    if FDocumentIndex=0 then
      aDocument:=Server.Document[1] as IDMDocument
    else
      aDocument:=Server.Document[0] as IDMDocument;
    aDataModel:=aDocument.DataModel as IDataModel;
  end;

  tvDataModel.Items.BeginUpdate;

  ClearTree;

  Document:=GetDocument;
  if Document<>nil then begin
    DataModel:=GetDataModel;
    if (aDataModel<>nil) and
       (DataModel.RootObjectCount[Mode]<>aDataModel.RootObjectCount[Mode]) then Exit;
    for j := 0 to DataModel.RootObjectCount[Mode]-1 do begin
      DataModel.GetRootObject(Mode, j, RootObject,
                              RootObjectName, Operations, LinkType);
      Unk:=RootObject as IUnknown;
      AddItemFlag:=True;
      if aDataModel<>nil then begin
        aDataModel.GetRootObject(Mode, j, aRootObject,
                              RootObjectName, Operations, LinkType);
        aUnk:=aRootObject as IUnknown;

        if (Unk=nil) or (aUnk=nil) then
           AddItemFlag:=False
        else
        if (Unk.QueryInterface(IDMCollection, Collection)=0) and
           (aUnk.QueryInterface(IDMCollection, aCollection)=0) then begin
          if (Collection as IDMCollection2).IsSimilarTo(aCollection, ltOneToMany) then
            AddItemFlag:=False;
        end;
      end;
      if AddItemFlag then begin
        Text:=RootObjectName;
        Data:=pointer(Unk);
        tvDataModel.Items.AddObject(nil, Text, Data);
        if Unk<>nil then
          Unk._AddRef;
      end;
    end;
  end;
  tvDataModel.Items.EndUpdate;
end;

procedure TDMBrowser2.OpenDocument0;
begin
  if (Get_DataModelServer as IDataModelServer).DocumentCount>0 then begin
    try
      InitTree2(0);
    except
      raise
    end;
  end else begin
    ClearTreeData;
    ClearTree;
  end;
end;

procedure TDMBrowser2.OpenDocument1;
begin
  if (Get_DataModelServer as IDataModelServer).DocumentCount>1 then begin
    try
      InitTree2(1);
    except
      raise
    end;
  end else begin
    ClearTreeData;
    ClearTree;
  end;
end;

end.
