unit SelectFromTreeFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DataModel_TLB, ImgList,
  ComCtrls, MyComCtrls;

type
  TfmSelectFromTree = class(TForm)
    Panel1: TPanel;
    btOK: TButton;
    btCancel: TButton;
    Button3: TButton;
    tvDataModel: TTreeView;
    ilNodes: TImageList;
    procedure tvDataModelGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure SetCurrentElement(const Value:IDMElement);
    procedure FormShow(Sender: TObject);
    procedure tvDataModelDblClick(Sender: TObject);
  private
    FRootElement:pointer;
    FSelectedElement:pointer;
    function  GetRootElement: IDMElement;
    procedure SetRootElement(const Value: IDMElement);
    function  GetCurrentElement: IDMElement;
  public
    procedure BuildTree(const aSelectedElement:IDMElement);
    property RootElement:IDMElement read GetRootElement write SetRootElement;
    property CurrentElement:IDMElement read GetCurrentElement;
  end;

var
  fmSelectFromTree: TfmSelectFromTree;

implementation
uses
  MyForms;

{$R *.dfm}

{ TfmSelectFromTree }

procedure TfmSelectFromTree.SetRootElement(const Value: IDMElement);
begin
  FRootElement := pointer(Value);
end;

procedure TfmSelectFromTree.BuildTree(const aSelectedElement:IDMElement);
  procedure MakeChilds(const theElement:IDMElement; theTreeNode:TTreeNode);
  var
    aCollection:IDMCollection;
    aElement:IDMElement;
    j:integer;
    aName:string;
    aTreeNode:TTreeNode;
  begin
    if theTreeNode=tvDataModel.Items[0] then
      aCollection:=theElement.Collection[0]
    else
      aCollection:=theElement.Collection[1];
    for j:=0  to aCollection.Count-1 do begin
      aElement:=aCollection.Item[j];
      aName:=aElement.Name;
      aTreeNode:=tvDataModel.Items.AddChildObject(theTreeNode, aName, pointer(aElement));
      if (aElement<>aSelectedElement) and
        not aElement.Selected then
        MakeChilds(aElement, aTreeNode);
    end;
  end;
var
  aName:string;
  aElement:IDMElement;
  aTreeNode:TTreeNode;
begin
  FSelectedElement:=pointer(aSelectedElement);
  tvDataModel.Items.BeginUpdate;
  tvDataModel.Items.Clear;
  aElement:=IDMElement(FRootElement);
  aName:=aElement.Name;
  aTreeNode:=tvDataModel.Items.AddObject(nil, aName, FRootElement);
  MakeChilds(aElement, aTreeNode);
  tvDataModel.Items.EndUpdate;
  SetCurrentElement(aSelectedElement.Parent)
end;

function TfmSelectFromTree.GetRootElement: IDMElement;
begin
  Result:=IDMElement(FRootElement)
end;

function TfmSelectFromTree.GetCurrentElement: IDMElement;
var
  aTreeNode:TTreeNode;
begin
  aTreeNode:=tvDataModel.Selected;
  Result:=nil;
  if aTreeNode=nil then Exit;
  Result:=IDMElement(aTreeNode.Data)
end;

procedure TfmSelectFromTree.SetCurrentElement(const Value:IDMElement);
var
  j:integer;
  aTreeNode:TTreeNode;
begin
  j:=0;
  while j<tvDataModel.Items.Count do
    if tvDataModel.Items[j].Data=pointer(Value) then
      Break
    else
      inc(j);
  if j<tvDataModel.Items.Count then begin
    aTreeNode:=tvDataModel.Items[j];
    aTreeNode.Expand(False);
    aTreeNode.Selected:=True;
    aTreeNode.Focused:=True;
  end;
end;

procedure TfmSelectFromTree.tvDataModelGetImageIndex(Sender: TObject;
  Node: TTreeNode);
var
  aElement, aSelectedElement:IDMElement;
begin
  if Node.Data=nil then
    Node.ImageIndex := -1
  else begin
    aSelectedElement:=IDMElement(FSelectedElement);
    aElement:=IDMElement(Node.Data);
    if aElement.Selected then
      Node.ImageIndex := 1
    else
    if aElement=aSelectedElement then
      Node.ImageIndex := 1
    else
      Node.ImageIndex := 0
  end;
end;

procedure TfmSelectFromTree.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

procedure TfmSelectFromTree.tvDataModelDblClick(Sender: TObject);
begin
  btOK.Click
end;

end.
