unit DMTeeChartU;
//___________________________________вариант  Volkov_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMChartU,
  TeEngine, Series, TeeProcs, Chart, FloatValueLists;

type

  TDMTeeChart = class(TDMChart)
    Chart1: TChart;
    Series1: THorizBarSeries;
    mComment: TMemo;
    sbCopy: TSpeedButton;
    Splitter1: TSplitter;
    FontDialog1: TFontDialog;
    SpinButton1: TSpinButton;
    SpinButton2: TSpinButton;
    LabelH: TLabel;
    LabelW: TLabel;
    procedure ScrollBox1Resize(Sender: TObject);
    procedure sbCopyClick(Sender: TObject);
    procedure mCommentChange(Sender: TObject);
    procedure cbFunctionChange(Sender: TObject);
    procedure Chart1ClickAxis(Sender: TCustomChart; Axis: TChartAxis;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mCommentMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Chart1ClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure Chart1GetAxisLabel(Sender: TChartAxis; Series: TChartSeries;
      ValueIndex: Integer; var LabelText: String);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
  private
    FloatValueList:TFloatValueList;
  protected
    procedure UpdateValues; override;
    procedure ClearChart; override;
    procedure PrintChart; override;
  public
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
  end;

implementation

const
  InfinitValue=1000000000;

{$R *.DFM}


{ TDMChartX }

procedure TDMTeeChart.UpdateValues;
var
  j, i, DigitCount:integer;
  aElement:IDMElement;
  minValue, Value:double;
  ValueFormat:string;
  Flag:boolean;
begin
  if not Visible then Exit;
  Series1.Clear;
  if FFunctionField=-1 then Exit;
  if FFunctionField>cbFunction.Items.Count-1 then Exit;

  i:=integer(cbFunction.Items.Objects[FFunctionField]);

  FloatValueList.FreeValues;

  Chart1.LeftAxis.LabelsSize:=0;

  minValue:=InfinitValue;
  for j:=0 to FChartElements.Count-1 do begin
    aElement:=IDMElement(FChartElements[j]);
    Value:=abs(aElement.FieldValue[i]);
    FloatValueList.AddValue(Value);
    if (Value<>InfinitValue) then begin
      if minValue>Value then
        minValue:=Value;
    end;
  end;

  Flag:=False;
  Chart1.Height:=30*(FChartElements.Count-1)+100;
  if FChartElements.Count>0 then begin
    aElement:=IDMElement(FChartElements[0]);
    if (aElement.Field[i].ValueType=fvtFloat) and
       (aElement.Field[i].MaxValue=1) and
       (aElement.Field[i].MinValue=0) then begin
      Flag:=True;
      if minValue>=0.0095 then
        DigitCount:=2
      else
      if minValue>=0.00095 then
        DigitCount:=3
      else
        DigitCount:=4;

      ValueFormat:='0.##';
      for j:=2 to DigitCount-1 do
         ValueFormat:=ValueFormat+'#';
      Series1.ValueFormat:=ValueFormat;
    end;
  end;
  for j:=0 to FChartElements.Count-1 do begin
    aElement:=IDMElement(FChartElements[j]);
    Value:=FloatValueList.FloatValue[j];
    if Flag and (Value>=0.01) then
      Value:=0.01*round(Value/0.01);
    if (Value<>InfinitValue) and
       (Value<>-InfinitValue) then
      Series1.Add(Value, aElement.Name, clRed)
  end;
  if FChartElements.Count>0 then begin
    aElement:=IDMElement(FChartElements[0]);
    if (aElement.Field[i].ValueType=fvtFloat) and
       (aElement.Field[i].MaxValue=1) and
       (aElement.Field[i].MinValue=0) then begin
      Chart1.BottomAxis.Automatic:=False;
      Chart1.BottomAxis.Minimum:=0;
      Chart1.BottomAxis.Maximum:=1.09;
      Chart1.BottomAxis.Increment:=0.1;
      Chart1.BottomAxis.MinorTickCount:=1;
    end else
      Chart1.BottomAxis.Automatic:=True;
  end else
    Chart1.BottomAxis.Automatic:=True;
end;

procedure TDMTeeChart.ClearChart;
begin
  Series1.Clear;
end;

procedure TDMTeeChart.ScrollBox1Resize(Sender: TObject);
begin
  Chart1.Width:=Chart1.Parent.Width;
end;

procedure TDMTeeChart.PrintChart;
begin
//  Chart1.PrintProportional:=False;
//  Chart1.PrintResolution:=50;
//  Chart1.PrintRect(rect(0,0,Printer.PageWidth-1,Printer.PageHeight-1))
  Chart1.PrintOrientation(poLandscape);
end;

procedure TDMTeeChart.sbCopyClick(Sender: TObject);
begin
  inherited;
//  Chart1.CopyToClipboardBitmap;
  Chart1.CopyToClipboardMetafile(True)
end;

procedure TDMTeeChart.mCommentChange(Sender: TObject);
begin
  Chart1.Foot.Text.Assign(mComment.Lines);
end;

procedure TDMTeeChart.cbFunctionChange(Sender: TObject);
begin
  inherited;
  mComment.Text:=cbFunction.Text;
  mCommentChange(mComment);
end;

procedure TDMTeeChart.Chart1ClickAxis(Sender: TCustomChart;
  Axis: TChartAxis; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if not (ssRight in Shift) then Exit;
  FontDialog1.Font:=Axis.LabelsFont;
  if not FontDialog1.Execute then Exit;
  Axis.LabelsFont:=FontDialog1.Font;
end;

procedure TDMTeeChart.mCommentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not (ssRight in Shift) then Exit;
  FontDialog1.Font:=Chart1.Foot.Font;
  if not FontDialog1.Execute then Exit;
  Chart1.Foot.Font:=FontDialog1.Font;
  mComment.Font:=FontDialog1.Font;
end;

procedure TDMTeeChart.Chart1ClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not (ssRight in Shift) then Exit;
  FontDialog1.Font:=Chart1.Series[0].Marks.Font;
  if not FontDialog1.Execute then Exit;
  Chart1.Series[0].Marks.Font:=FontDialog1.Font;
end;

constructor TDMTeeChart.Create(aOwner: TComponent);
begin
  inherited;
  FloatValueList:=TFloatValueList.Create;
end;

destructor TDMTeeChart.Destroy;
begin
  FloatValueList.Free;
  inherited;
end;

procedure TDMTeeChart.Chart1GetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: String);
var
  S:string;
  L, j, m0, m1, W:integer;
begin
  L:=length(LabelText);
  m0:=1;
  for j:=1 to L do
    if LabelText[j]='|' then begin
      LabelText[j]:=#13;
      m1:=j-1;
      S:=Copy(LabelText, m0, m1);
      W:=Chart1.Canvas.TextWidth(S)+100;
      if Chart1.LeftAxis.LabelsSize<W then
        Chart1.LeftAxis.LabelsSize:=W;
      m0:=j+1;
    end;
end;

procedure TDMTeeChart.SpinButton1UpClick(Sender: TObject);
begin
  Chart1.Height:=round(Chart1.Height*1.2)
end;

procedure TDMTeeChart.SpinButton1DownClick(Sender: TObject);
begin
  Chart1.Height:=round(Chart1.Height/1.2)
end;

procedure TDMTeeChart.SpinButton2DownClick(Sender: TObject);
begin
  Chart1.Width:=round(Chart1.Width/1.2)
end;

procedure TDMTeeChart.SpinButton2UpClick(Sender: TObject);
begin
  Chart1.Width:=round(Chart1.Width*1.2)
end;

end.
