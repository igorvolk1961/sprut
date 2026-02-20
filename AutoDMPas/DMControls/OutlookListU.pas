unit OutlookListU;

interface
uses
  Controls, Classes, ComCtrls, DMEditor_TLB,
  fcClearPanel, fcButtonGroup, fcOutlookBar, fcOutlookList,
  fcChangeLink,  fcButton, fcCommon, fcShapeBtn, fcImgBtn, fcCollection;

type
  TEventHolder=class(TControl)
  private
     OutlookListItemsClick:TfcCustomOutlookListItemEvent;
  protected
     procedure DoOutlookListItemsClick(OutlookList: TfcCustomOutlookList;
                                     Item: TfcOutlookListItem);
  public
     constructor Create(aOwner:TComponent); override;
  end;

procedure DoCreateOutlookBar(OutlookPanel:TWinControl; Owner:TControl;
                             ImageList:TImageList;
                             var aOutlookBar,
                             aTopOutlookList, aBottomOutlookList:TCustomControl);

procedure SetOutlookList(aOutlookList: TCustomControl;
                         Index:integer;
                         Value:boolean);

procedure DoMakeOutlookBar(tbForms:TToolBar; Owner:TControl;
                           aTopOutlookList, aBottomOutlookList:TCustomControl);

implementation
uses
  DMContainerU;

procedure DoCreateOutlookBar(OutlookPanel:TWinControl; Owner:TControl;
                             ImageList:TImageList;
                             var aOutlookBar,
                             aTopOutlookList, aBottomOutlookList:TCustomControl);
var
  Button:TfcCustombitBtn;
  OutlookBar:TfcOutlookBar;
  OutlookList: TfcCustomOutlookList;
begin
  OutlookPanel.Width:=120;

  OutlookBar:=TfcOutlookBar.Create(Owner);
  aOutlookBar:=OutlookBar;
  OutlookBar.Parent:=OutlookPanel;
  OutlookBar.Align:=alClient;
  OutlookBar.ButtonSize:=30;
  OutlookBar.ClickStyle:=bcsRadioGroup;

  OutlookList:=OutlookBar.OutlookItems.Add.OutlookList;
  aTopOutlookList:=OutlookList;
  OutlookList.Tag:=1;
  OutlookList.ItemSpacing:=20;
  OutlookList.ClickStyle:=csSelect;
  OutlookList.Images:=ImageList;
//  OutlookList.HotTrackStyle:=hsItemHilite;
  Button:=OutlookBar.ButtonItems[0].Button;
//  Button.Color:=clNavy;
//  Button.Font.Color:=clWhite;
//  Button.Font.Style:=[fsBold];
  Button.TextOptions.WordWrap:=True;
  Button.Caption:='Верхняя панель';

  OutlookList:=OutlookBar.OutlookItems.Add.OutlookList;
  aBottomOutlookList:=OutlookList;
  aBottomOutlookList.Tag:=2;
  OutlookList.ItemSpacing:=20;
  OutlookList.ClickStyle:=csSelect;
  OutlookList.Images:=ImageList;
//  OutlookList.HotTrackStyle:=hsItemHilite;
  Button:=OutlookBar.ButtonItems[1].Button;
//  Button.Color:=clNavy;
//  Button.Font.Color:=clWhite;
//  Button.Font.Style:=[fsBold];
  Button.TextOptions.WordWrap:=True;
  Button.Caption:='Нижняя панель';
end;

procedure SetOutlookList(aOutlookList: TCustomControl;
                         Index:integer;
                         Value:boolean);
var
  j, aTag:integer;
  OutlookList: TfcCustomOutlookList;
begin
  OutlookList:=aOutlookList as TfcCustomOutlookList;
  j:=0;
  aTag:=0;
  while (aTag<>-1) and
        (j<OutlookList.Items.Count) do begin
    aTag:=OutlookList.Items[j].Tag;
    if aTag=Index then
      Break
    else
      inc(j);
  end;
  if (aTag<>-1) and
     (j<OutlookList.Items.Count) then
    OutlookList.Items[j].Selected:=Value;
end;

procedure DoMakeOutlookBar(tbForms:TToolBar; Owner:TControl;
                           aTopOutlookList, aBottomOutlookList:TCustomControl);
var
  j:integer;
  Button:TToolButton;
  Item:TfcOutlookListItem;
  BottomFlag:boolean;
  TopOutlookList, BottomOutlookList:TfcCustomOutlookList;
  EventHolder:TEventHolder;
begin
  TopOutlookList:=aTopOutlookList as TfcCustomOutlookList;
  BottomOutlookList:=aBottomOutlookList as TfcCustomOutlookList;
  EventHolder:=TEventHolder.Create(nil);

  BottomFlag:=False;
  for j:=0 to tbForms.ButtonCount-1 do begin
    Button:=tbForms.Buttons[j];
    if Button.Style=tbsSeparator then
       BottomFlag:=True
    else begin
      if BottomFlag then begin
        Item:=BottomOutlookList.Items.Add;
      end else begin
        Item:=TopOutlookList.Items.Add;
      end;
      Item.OnClick:=EventHolder.OutlookListItemsClick;
      Item.Text:=Button.Hint;
      Item.ImageIndex:=Button.ImageIndex;
      Item.Tag:=Button.Tag;
    end;
  end;
  EventHolder.Free;
end;

{ TEventHolder }

constructor TEventHolder.Create(aOwner: TComponent);
begin
  OutlookListItemsClick:=DoOutlookListItemsClick
end;

procedure TEventHolder.DoOutlookListItemsClick(
  OutlookList: TfcCustomOutlookList; Item: TfcOutlookListItem);
var
  aTag:integer;
  DMContainerX:IDMEditorX;
begin
  DMContainerX:=OutlookList.Owner as IDMEditorX;
  aTag:=Item.Tag;
  if OutlookList.Tag=1 then begin
    if DMContainerX.FormVisible[aTag, 0] then begin
      DMContainerX.FormVisible[aTag, 0]:=False;
      Item.Selected:=False;
    end else begin
      DMContainerX.FormVisible[aTag, 0]:=True;
      DMContainerX.ActiveForm:=DMContainerX.Form[aTag, 0]
    end;
  end else
  if OutlookList.Tag=2 then begin
    if DMContainerX.FormVisible[aTag, 1] then begin
      DMContainerX.FormVisible[aTag, 1]:=False;
      Item.Selected:=False;
    end else begin
      DMContainerX.FormVisible[aTag, 1]:=True;
      DMContainerX.ActiveForm:=DMContainerX.Form[aTag, 1]
    end;
  end else begin
  end;
end;

end.
