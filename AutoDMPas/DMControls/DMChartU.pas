unit DMChartU;
//___________________________________вариант  Volkov_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU;

const
  pkOutput = $00000002;
  pkChart =  $20000000;

type

  TDMChart = class(TDMPage)
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    Panel2: TPanel;
    Label1: TLabel;
    cbFunction: TComboBox;
    Label2: TLabel;
    cbSort: TComboBox;
    procedure cbFunctionChange(Sender: TObject);
    procedure cbSortChange(Sender: TObject);
  private
    FieldIndex:integer;
    SortField:integer;
  protected
    FFunctionField:integer;
    FChartElements:TList;
    procedure OpenDocument; override; safecall;
    procedure StopAnalysis(Mode:integer); override; safecall;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;
    function DoAction(ActionCode: integer):WordBool; override; safecall;

    procedure UpdateValues; virtual;
    procedure ClearChart; virtual;
    procedure PrintChart; virtual;
    procedure SetValues;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

function ChartCompare(const Key1, Key2: IDMElement): Integer;

implementation

uses
  ComObj, ComServ;

{$R *.DFM}

var
  FieldSortIndex:Integer;

{ TDMChartX }

procedure TDMChart.Initialize;
begin
  inherited Initialize;
  DecimalSeparator:='.';
  FChartElements:=TList.Create;
  FFunctionField:=-1;
  SortField:=-1;
  FieldIndex:=-1;
end;

procedure TDMChart.OpenDocument;
begin
  SetValues
end;

procedure TDMChart.cbFunctionChange(Sender: TObject);
begin
  if cbFunction.ItemIndex=-1 then Exit;
  FFunctionField:=cbFunction.ItemIndex;
  UpdateValues;
end;

procedure TDMChart.cbSortChange(Sender: TObject);
begin
  if cbSort.ItemIndex=-1 then Exit;
  SortField:=cbSort.ItemIndex;

  FieldSortIndex:=integer(cbSort.Items.Objects[SortField]);

  if FieldSortIndex<>-9999 then
    FChartElements.Sort(@ChartCompare);

  UpdateValues;
end;

procedure TDMChart.UpdateValues;
begin
end;

procedure TDMChart.SetValues;
var
  aElement, aFieldE:IDMElement;
  j, m:integer;
  aClassID:integer;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;

  cbFunction.Clear;
  cbSort.Clear;
  ClearChart;
  if DMDocument.SelectionCount=0 then Exit;

  aElement:=DMDocument.SelectionItem[0] as IDMElement;
  if (aElement.Ref<>nil) and
     (aElement.Ref.SpatialElement=aElement) then
    aElement:=aElement.Ref;
  aClassID:=aElement.ClassID;
  if FFunctionField>aElement.FieldCount-1 then begin
    FFunctionField:=-1;
    SortField:=-1;
  end;
  FChartElements.Clear;
  cbSort.Items.AddObject('Без сортировки', pointer(-9999));
  cbSort.Items.AddObject('По типу выделенных элементов', pointer(-9998));
  m:=-1;
  for j:=0 to aElement.FieldCount-1 do begin
    case aElement.Field[j].ValueType of
    fvtInteger, fvtFloat:
      if ((aElement.Field[j].Level and pkOutput)<>0) or
         ((aElement.Field[j].Level and pkChart)<>0) then begin
        aFieldE:=aElement.Field[j] as IDMElement;
        cbFunction.Items.AddObject(aFieldE.Name, pointer(j));
        cbSort.Items.AddObject(aFieldE.Name, pointer(j));
        inc(m);
      end
    end;
  end;
  if m=-1 then Exit;
  if (FFunctionField=-1) or
    (FFunctionField>m) then begin
    FFunctionField:=0;
//    if FunctionField<>-1 then
//      SortField:=2
//    else
      SortField:=0;
  end;

  cbFunction.ItemIndex:=FFunctionField;
  cbSort.ItemIndex:=SortField;


  if SortField<>-1 then
    FieldSortIndex:=integer(cbSort.Items.Objects[SortField]);

  for j:=0 to DMDocument.SelectionCount-1 do begin
    aElement:=DMDocument.SelectionItem[j] as IDMElement;
    if (aElement.Ref<>nil) and
       (aElement.Ref.SpatialElement=aElement) then
      aElement:=aElement.Ref;
    if aElement.ClassID=aClassID then
      FChartElements.Add(pointer(aElement))
  end;

  cbSortChange(nil);
end;

procedure TDMChart.ClearChart;
begin
end;

procedure TDMChart.SelectionChanged(DMElement: OleVariant);
begin
  SetValues
end;

destructor TDMChart.Destroy;
begin
  inherited;
  FChartElements.Free;
end;

function TDMChart.DoAction(ActionCode: integer): WordBool;
begin
  case ActionCode of
  dmbaPrint:
    PrintChart;
  end;
end;

procedure TDMChart.PrintChart;
begin
end;

procedure TDMChart.StopAnalysis(Mode:integer);
begin
  if not Visible then Exit;
  UpdateValues;
end;

function ChartCompare(const Key1, Key2: IDMElement): Integer;
var
  Ref1, Ref2:IDMElement;
  Value1, Value2:double;
begin
  if FieldSortIndex=-9999 then
    Result:=0
  else
  if FieldSortIndex=-9998 then begin
    if (Key1.Ref<>nil) and
       (Key2.Ref<>nil) then begin
      Ref1:=Key1.Ref;
      Ref2:=Key2.Ref;
      if Ref1.ID<Ref2.ID then
        Result:=-1
      else
      if Ref1.ID>Ref2.ID then
        Result:=+1
      else begin
        if Key1.ID<Key2.ID then
          Result:=-1
        else
        if Key1.ID>Key2.ID then
          Result:=+1
        else
          Result:=0
      end;
    end else
      Result:=0
  end else begin
    Value1:=Key1.FieldValue[FieldSortIndex];
    Value2:=Key2.FieldValue[FieldSortIndex];
    if Value1<Value2 then
      Result:=-1
    else
    if Value1>Value2 then
      Result:=+1
    else
      Result:=0
  end;
end;

end.
