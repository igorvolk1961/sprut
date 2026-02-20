unit DMGridU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_Windows, Types,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers,
  StdCtrls, Grids, ToolWin, Variants,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU, ExtCtrls;

const
  pkComment = $00000008;

  rsChangeFieldValue='Изменение значения параметра';
  rsUndefined='Не определено';
  rsNotDefined='Не определено';
  rsYes='Да';
  rsNo='Нет';
  rsParameter='Параметр';
  rsFieldValue='Значение';

type
  TDMGrid = class(TDMPage)
    Splitter0: TSplitter;
    TabControl1: TTabControl;
    PanelDetails: TPanel;
    pTable: TPanel;
    Header: THeaderControl;
    sgDetails: TStringGrid;
    cbCategories: TComboBox;
    cbParameter: TComboBox;

    procedure cbCategoriesChange(Sender: TObject);
    procedure cbCategoriesExit(Sender: TObject);
    procedure cbParameterChange(Sender: TObject);
    procedure cbParameterExit;

    procedure sgDetailsDblClick(Sender: TObject);
    procedure sgDetailsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgDetailsEnter(Sender: TObject);
    procedure sgDetailsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgDetailsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgDetailsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);

    procedure HeaderResize(Sender: TObject);
    procedure HeaderSectionClick(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure HeaderSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);

    procedure ParameterKeyPress(Sender: TObject; var Key: Char);
    procedure cbParameterEnter(Sender: TObject);
    procedure cbCategoriesEnter(Sender: TObject);
    procedure sgDetailsExit(Sender: TObject);
    procedure sgDetailsTopLeftChanged(Sender: TObject);
    procedure HeaderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TabControl1Change(Sender: TObject);
    procedure sgDetailsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

  private

//    FEvents: IDMGridXEvents;

    FOldFieldValue:string;

    FEditingParameterFlag:boolean;
    FSetDetailsFlag:boolean;
    FRefreshingFlag:boolean;

    FCurrentElement:IDMElement;
    FCurrentFieldIndex:integer;
    FCurrentParamKind:integer;
    FIsControlForm:boolean;

    FDraggingElement:IDMElement;
    FSelectionRangeStart:integer;

    function GetDetailCellHeight(S0: string; DrawFlag: boolean; WW, HH,
      LL: integer; R:TRect): integer;
    procedure SetColWidths(W0: double);
    procedure SetDetails;
    procedure SetDetailsElements(Elements: IDMCollection);
    procedure SetDetailsList;
    procedure SetDetailsListKind;
  protected
    procedure OpenDocument; override;
    procedure DocumentOperation(ElementsV,
      CollectionV: OleVariant; DMOperation, nItemIndex: Integer); override;
    procedure RefreshElement(DMElement:OleVariant); override; safecall;
    procedure StopAnalysis(Mode:integer); override; safecall;

  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

var
  DMGrid: TDMGrid;
const
  InfinitValue=1000000000;

implementation
uses
  ComObj, ComServ;

{$R *.dfm}

procedure TDMGrid.Initialize;
begin
  inherited Initialize;
  cbParameter.Ctl3D:=False;
  cbParameter.Height:=15;
  FCurrentFieldIndex:=-1;
  FSelectionRangeStart:=-1;

  FIsControlForm:=True;

  SetColWidths(0.6);

  sgDetails.Visible:=True;

  FCurrentParamKind:=0;
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

procedure TDMGrid.SetColWidths(W0:double);
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

  for j:=0 to Header.Sections.Count-1 do
    sgDetails.ColWidths[j]:=Header.Sections[j].Width-1;
  if sgDetails.ColCount>1 then
    sgDetails.FixedCols:=1;
end;

procedure TDMGrid.SetDetailsList;
var
  j, m, FieldCount_, ParamKind: integer;
  Field:IDMField;
  ParamKindSet:integer;
  S:string;
begin
  try
  if FCurrentElement=nil then Exit;

  FieldCount_:=FCurrentElement.FieldCount_;
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

  TabControl1.TabIndex:=0;

  TabControl1Change(TabControl1);
  except
    raise
  end;
end;

procedure TDMGrid.SetDetailsListKind;
var
  j, H0, H1, WW, HH, N, FieldCount_: integer;
  Field:IDMField;
  R:TRect;
begin
  try
  FCurrentElement:=GetDataModel as IDMElement;

  for j:=0 to sgDetails.ColCount-1 do
    sgDetails.Cols[j].Clear;
  sgDetails.RowCount:=0;
  if FCurrentElement=nil then Exit;

  FCurrentElement.CalculateFieldValues;

  FieldCount_:=FCurrentElement.FieldCount_;
  N:=0;
  for j:=0 to FieldCount_-1 do begin
    Field:=FCurrentElement.Field_[j];
    if Field.ValueType<>fvtText then begin
      if FCurrentElement.FieldIsVisible(Field.Code) then begin
        if (Field.Level and FCurrentParamKind)<>0 then
          inc(N);
      end;
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
        Cells[0, N] := (Field as IDMElement).Name;
        Objects[0, N] := pointer(j);
        Objects[1, N] := pointer(j);
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

procedure TDMGrid.cbParameterChange(Sender: TObject);
var
  m, RCode:integer;
  aElement, Element:IDMElement;
  OperationManager:IDMOperationManager;
  V:Variant;
  aDocument:IDMDocument;
begin
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (GetDataModel.State and dmfFrozen)<>0 then Exit;

  OperationManager:=aDocument as IDMOperationManager;
  m:=cbParameter.ItemIndex;

  FCurrentElement:=GetDataModel as IDMElement;
  if FCurrentElement=nil then Exit;
  aElement:=FCurrentElement;

  if (m=-1) and
     (aElement.Field_[FCurrentFieldIndex].ValueType=fvtElement) then begin
    sgDetails.Cells[sgDetails.Col, sgDetails.Row]:='';
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
  OperationManager.StartTransaction(nil, leoAdd, rsChangeFieldValue);
  RCode:=aElement.Field_[FCurrentFieldIndex].Code;
  OperationManager.ChangeFieldValue( aElement, RCode, True, V);
  OperationManager.FinishTransaction(aElement, nil, leoChangeFieldValue);
  sgDetails.Refresh;
end;

procedure TDMGrid.ParameterKeyPress(Sender: TObject; var Key: Char);
var
  OperationManager:IDMOperationManager;
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
     end;
   #32:
     begin
       FCurrentElement:=GetDataModel as IDMElement;
       if FCurrentElement=nil then Exit;
       aElement:=FCurrentElement;

       OperationManager:=(Get_DataModelServer as IDataModelServer).CurrentDocument as IDMOperationManager;
       cbParameter.ItemIndex:=-1;
       cbParameter.Text:='';
       case aElement.Field_[FCurrentFieldIndex].ValueType of
       fvtBoolean:
         begin
           V:=not FCurrentElement.FieldValue_[FCurrentFieldIndex];
           OperationManager.StartTransaction(nil, leoAdd, rsChangeFieldValue);
           OperationManager.ChangeFieldValue( aElement,
             aElement.Field_[FCurrentFieldIndex].Code, True, V);
           OperationManager.FinishTransaction(aElement, nil, leoChangeFieldValue);
           sgDetails.Refresh;
         end;
       fvtElement:
         begin
           NilElement:=nil;
           V:=NilElement as IUnknown;
           OperationManager.StartTransaction(nil, leoAdd, rsChangeFieldValue);
           OperationManager.ChangeFieldValue( aElement,
             aElement.Field_[FCurrentFieldIndex].Code, True, V);
           OperationManager.FinishTransaction(aElement, nil, leoChangeFieldValue);
           sgDetails.Refresh;
         end;
       end;
     end;
   end;
end;

procedure TDMGrid.HeaderSectionResize(HeaderControl: THeaderControl;
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

procedure TDMGrid.HeaderResize(Sender: TObject);
var
  Rect:TRect;
  R:double;
begin
  if Header.Sections[0].Width>30 then
    R:=Header.Sections[0].Width/Header.Width
  else
    R:=0.6;
  SetColWidths(R);
  with sgDetails do begin
    Rect:=CellRect(Col, Row);
    cbParameter.Left:=Rect.Left;
    cbParameter.Top:=Top+Rect.Top;
    cbParameter.Width:=Rect.Right-Rect.Left+2;
    cbParameter.Height:=Rect.Bottom-Rect.Top;
  end;
end;

procedure TDMGrid.sgDetailsDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  i, iPrev, j:integer;
  Field, PrevField:IDMField;
  Unk:IUnknown;
  Frmt:string;
  F:double;
  V:OleVariant;

  S:string;
  HH, WW, LL:integer;
  Element:IDMElement;

  procedure ChangeFont(const Element:IDMElement);
  begin
    with sgDetails do begin
      case Field.Modifier of
      1:begin
          Canvas.Font.Color:=clNavy;
          Canvas.Font.Style:=Canvas.Font.Style+[fsBold];
        end;
      2:begin
          Canvas.Font.Style:=Canvas.Font.Style+[fsBold];
          iPrev:=integer(pointer(Objects[ACol, ARow-1]));

          PrevField:=Element.Field_[iPrev];
          if PrevField.ValueType=fvtBoolean then begin
            if Element.FieldValue_[iPrev]=True then
              Canvas.Font.Color:=clGreen
            else
              Canvas.Font.Color:=clNavy;
          end;
        end;
      3:begin
          Canvas.Font.Style:=Canvas.Font.Style+[fsItalic]
        end;
      end;
    end;
  end;
begin
  try
  FCurrentElement:=GetDataModel as IDMElement;
  if FCurrentElement=nil then Exit;
  Element:=FCurrentElement;
  Field:=nil;

  if (Element<>nil) and
     (Element.FieldCount_>0) then begin
    i:=integer(pointer(sgDetails.Objects[ACol, ARow]));
    Field:=Element.Field_[i];
    if (ACol>0) and
//       (ARow>0) and
       (Field<>nil) then
      ChangeFont(Element);
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
      0: S:=(Field as IDMElement).Name
      else begin
        V:=Element.FieldValue_[i];
        if VarIsNull(V) or
           VarIsEmpty(V) then
          S:=' '
        else
        case Field.ValueType of
        fvtFloat:
          begin
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

function TDMGrid.GetDetailCellHeight(S0:string; DrawFlag:boolean;
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
      if DrawFlag then
        Canvas.TextOut(LL,HH, S1);
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

procedure TDMGrid.sgDetailsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Rect:TRect;
  ValueList:IDMCollection;
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
  RCode, m:integer;
  DataModel:IDataModel;
begin
  FCurrentElement:=GetDataModel as IDMElement;
  case Key of
  VK_RETURN,
  VK_ESCAPE:
    begin
      if FCurrentElement=nil then Exit;
      aElement:=FCurrentElement;
    end;
  else
    Exit;
  end;

  with sgDetails do
  case Key of
  VK_RETURN:
    begin
      Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
      DataModel:=Document.DataModel as IDataModel;
      OperationManager:=Document as IDMOperationManager;
      if (FCurrentFieldIndex<>-1) and
         (aElement<>nil) then
      case aElement.Field_[FCurrentFieldIndex].ValueType of
      fvtBoolean,
      fvtChoice,
      fvtElement:
        begin
          if not cbParameter.Enabled then Exit;
          Cells[Col,Row]:='';
          Rect:=CellRect(Col, Row);
          cbParameter.Left:=Rect.Left;
          cbParameter.Top:=Top+Rect.Top;
          cbParameter.Width:=Rect.Right-Rect.Left+2;
          cbParameter.Height:=Rect.Bottom-Rect.Top;
          cbParameter.Items.Clear;
          case aElement.Field_[FCurrentFieldIndex].ValueType of
          fvtElement:
            begin
              cbParameter.ItemIndex := 0;
              ValueList:=DataModel.CreateCollection(-1, nil);
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
              end;
            fvtString, fvtFile:
              V:=S;
            end;
            if Err=0 then begin
              OperationManager.StartTransaction(nil, leoAdd, rsChangeFieldValue);

              RCode:=aElement.Field_[FCurrentFieldIndex].Code;

              OperationManager.ChangeFieldValue( aElement,
                   RCode, True, V);

              OperationManager.FinishTransaction(aElement, nil, leoChangeFieldValue);
              sgDetails.Refresh;
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

procedure TDMGrid.sgDetailsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  iPrev:integer;
  Element:IDMElement;
  OperationManager:IDMOperationManager;
  Key:word;
  S:string;
begin
  cbParameter.Visible:=False;
  FCurrentElement:=GetDataModel as IDMElement;

  if FCurrentElement=nil then Exit;
  Element:=FCurrentElement;

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

    case Element.Field_[FCurrentFieldIndex].Modifier of
    1:begin
        Options:=Options-[goEditing];
        FEditingParameterFlag:=False;
        cbParameter.Enabled:=False;
      end;
    2:begin
        iPrev:=integer(pointer(Objects[ACol, ARow-1]));
        if (Element.FieldValue_[iPrev]=True) and
           (Get_Mode<>-1) then begin
            Options:=Options+[goEditing];
          cbParameter.Enabled:=True;
        end else begin
          Options:=Options-[goEditing];
          FEditingParameterFlag:=False;
          cbParameter.Enabled:=False;
        end;
      end;
    else
    if (Get_Mode<>-1) then
      Options:=Options+[goEditing];
      cbParameter.Enabled:=True;
    end;

    if (Element.Field_[FCurrentFieldIndex].ValueType=fvtBoolean) or
       (Element.Field_[FCurrentFieldIndex].ValueType=fvtChoice) or
       (Element.Field_[FCurrentFieldIndex].ValueType=fvtElement) then begin
      Options:=Options-[goEditing];
      FEditingParameterFlag:=False;
    end;
  end;
end;

procedure TDMGrid.sgDetailsEnter(Sender: TObject);
var
  CanSelect: Boolean;
begin
  sgDetailsSelectCell(sgDetails,
      sgDetails.Col, sgDetails.Row, CanSelect);
  Get_DMEditorX.ActiveForm:=Self as IDMForm;
end;

procedure TDMGrid.sgDetailsDblClick(Sender: TObject);
var Key: Word;
begin
  Key:=VK_RETURN;
  sgDetailsKeyDown(sgDetails,  Key, []);
end;

procedure TDMGrid.sgDetailsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if (not FEditingParameterFlag) and
     (goEditing in sgDetails.Options) then begin
    FEditingParameterFlag:=True;
    FOldFieldValue:=sgDetails.Cells[ACol, ARow];
  end;
end;

procedure TDMGrid.cbParameterExit;
begin
  cbParameterChange(cbParameter);
  cbParameter.Visible:=False;
end;

procedure TDMGrid.SetDetails;
begin
  TabControl1.Tabs.Clear;

  FSetDetailsFlag:=True;
  while Header.Sections.Count>2 do
    Header.Sections.Delete(2);
  sgDetails.ColCount:=2;
  Header.Sections[0].Text:=rsParameter;
  if Header.Sections.Count=1 then
    Header.Sections.Add;
  Header.Sections[1].Text:=rsFieldValue;
  SetColWidths(0.6);
  SetDetailsList;

  FSetDetailsFlag:=False;
end;

procedure TDMGrid.SetDetailsElements(Elements: IDMCollection);
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
   sgDetails.Cols[0].Clear;
   sgDetails.Rows[0].Clear;

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
       end;
       inc(N);
     end;
   end;
   sgDetails.Invalidate;
end;

procedure TDMGrid.HeaderSectionClick(HeaderControl: THeaderControl;
  Section: THeaderSection);
begin
  FCurrentElement:=GetDataModel as IDMElement;
  if (FCurrentElement<>nil) and
     (Section=Header.Sections[0]) then begin
    cbCategories.Left:=0;
    cbCategories.Top:=Header.Top;
    cbCategories.Width:=Header.Sections[0].Width;
    cbCategories.Visible:=True;
    if Visible then
      cbCategories.SetFocus;
  end;
end;

procedure TDMGrid.cbCategoriesChange(Sender: TObject);
var
  Elements:IDMCollection;
  j:integer;
  aDocument:IDMDocument;
begin
  if Get_Mode=-1 then Exit;
  aDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  if (GetDataModel.State and dmfFrozen)<>0 then Exit;

  j:=cbCategories.ItemIndex;
  if j=-1 then Exit;
  Elements:=IDMCollection(pointer(cbCategories.Items.Objects[j]));
  SetDetailsElements(Elements);
  SetColWidths(0.3);
  sgDetails.Visible:=sgDetails.Cells[0,0]<>'';
end;

procedure TDMGrid.cbCategoriesExit(Sender: TObject);
begin
  cbCategoriesChange(Sender);
  cbCategories.Visible:=False;
end;


procedure TDMGrid.DocumentOperation(ElementsV, CollectionV: OleVariant; DMOperation,
  nItemIndex: Integer);
var
  aElementU:IUnknown;
begin
  if not Visible then Exit;

  FCurrentElement:=GetDataModel as IDMElement;
  case DMOperation of
  leoChangeFieldValue:
    begin
      aElementU:=ElementsV;
      if FCurrentElement=aElementU as IDMElement then
        sgDetails.Invalidate;
    end;
  end;

  inherited;
end;

destructor TDMGrid.Destroy;
begin
  inherited;
  FCurrentElement:=nil;
  FDraggingElement:=nil;
end;

procedure TDMGrid.cbParameterEnter(Sender: TObject);
begin
  inherited;
  Get_DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMGrid.cbCategoriesEnter(Sender: TObject);
begin
  inherited;
  Get_DMEditorX.ActiveForm:=Self as IDMForm
end;

procedure TDMGrid.sgDetailsExit(Sender: TObject);
var
  Rect:TRect;
  ValueList:IDMCollection;
  Unk:IUnknown;
  m, DW:integer;
  OperationManager:IDMOperationManager;
  Document:IDMDocument;
  V:Variant;
  Frmt:string;
  Delimeter:char;
  aElement:IDMElement;
  DataModel:IDataModel;
begin
  FCurrentElement:=GetDataModel as IDMElement;
  with sgDetails do  begin
      if FCurrentElement=nil then Exit;
      aElement:=FCurrentElement;

      Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument as IDMDocument;
      OperationManager:=Document as IDMOperationManager;
      DataModel:=Document.DataModel as IDataModel;
      if (aElement.Field_[FCurrentFieldIndex].ValueType=fvtBoolean) or
         (aElement.Field_[FCurrentFieldIndex].ValueType=fvtChoice) or
         (aElement.Field_[FCurrentFieldIndex].ValueType=fvtElement) then begin
        Cells[1,FCurrentFieldIndex-1]:='';
        Rect:=CellRect(1, FCurrentFieldIndex-1);
        cbParameter.Left:=Rect.Left;
        cbParameter.Top:=Top+Rect.Top;
        cbParameter.Width:=Rect.Right-Rect.Left+2;
        cbParameter.Height:=Rect.Bottom-Rect.Top;
        cbParameter.Items.Clear;
        case aElement.Field_[FCurrentFieldIndex].ValueType of
        fvtElement:
          begin
            cbParameter.ItemIndex := 0;
            ValueList:=DataModel.CreateCollection(-1, nil);
            aElement.GetFieldValueSource(FCurrentElement.Field_[FCurrentFieldIndex].Code, ValueList);
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
        end;
        cbParameter.Visible:=True;
        if Visible then
          cbParameter.SetFocus;
      end else begin
        if FEditingParameterFlag then begin
          V:=Cells[1, FCurrentFieldIndex-1];
          OperationManager.StartTransaction(nil, leoAdd, rsChangeFieldValue);
          OperationManager.ChangeFieldValue( aElement,
            aElement.Field_[FCurrentFieldIndex].Code, True, V);
          OperationManager.FinishTransaction(aElement, nil, leoChangeFieldValue);
        end;
        FEditingParameterFlag:=not FEditingParameterFlag;
      end;
  end;
end;

procedure TDMGrid.sgDetailsTopLeftChanged(Sender: TObject);
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

procedure TDMGrid.HeaderMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Header.ShowHint:=False;
end;

procedure TDMGrid.StopAnalysis(Mode: integer);
begin
  SetDetails;
end;

procedure TDMGrid.TabControl1Change(Sender: TObject);
begin
  if TabControl1.TabIndex=-1 then Exit;
  FCurrentParamKind:=integer(pointer(TabControl1.Tabs.Objects[TabControl1.TabIndex]));
  SetDetailsListKind;
  cbParameter.Visible:=False;
  sgDetails.Visible:=sgDetails.Cells[0,0]<>'';
  sgDetails.Invalidate;
end;

procedure TDMGrid.RefreshElement(DMElement:OleVariant);
var
  OldRow:integer;
  Element:IDMElement;
  Unk:IUnknown;
begin
  if not Visible then Exit;
  if FRefreshingFlag then Exit;
  Unk:=DMElement;
  Element:=Unk as IDMElement;
  if Element<>GetDataModel as IDMElement then Exit;
  FRefreshingFlag:=True;
  OldRow:=sgDetails.Row;
  SetDetails;
  sgDetails.Row:=OldRow;
  FRefreshingFlag:=False;
end;

procedure TDMGrid.OpenDocument;
begin
  FCurrentElement:=GetDataModel as IDMElement;
  SetDetails;
end;

procedure TDMGrid.sgDetailsMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  aCol, aRow, FieldIndex:integer;
begin
  sgDetails.MouseToCell(X, Y, aCol, aRow);
  sgDetails.ShowHint:=((aCol=0) and
                      (FCurrentElement<>nil));
  if not sgDetails.ShowHint then Exit;

  FieldIndex:=integer(pointer(sgDetails.Objects[1, ARow]));
  sgDetails.Hint:=FCurrentElement.Field_[FieldIndex].Hint;
end;

end.