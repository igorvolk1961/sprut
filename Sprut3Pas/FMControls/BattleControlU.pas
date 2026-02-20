unit BattleControlU;
//___________________________________вариант  Volkov_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU,
  SpatialModelLib_TLB, FacilityModelLib_TLB, SafeguardAnalyzerLib_TLB, PainterLib_TLB,
  BattleModelLib_TLB, SgdbLib_TLB, TeEngine, Series, TeeProcs,
  Chart;

type

  TBattleControl = class(TDMPage)
    Panel1: TPanel;
    btRestart: TButton;
    btNextStep: TButton;
    Label2: TLabel;
    LStartElement: TLabel;
    btCalc: TButton;
    Label3: TLabel;
    Label4: TLabel;
    LFacilityState: TLabel;
    Label5: TLabel;
    LCurrentTime: TLabel;
    Timer1: TTimer;
    btSuccess: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    sgGuards: TStringGrid;
    Splitter1: TSplitter;
    sgAdversaries: TStringGrid;
    Chart1: TChart;
    btGrTab: TButton;
    btCopy: TButton;
    cbShowMovment: TCheckBox;
    cbChartType: TComboBox;
    procedure btRestartClick(Sender: TObject);
    procedure btNextStepClick(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure btCalcClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btSuccessClick(Sender: TObject);
    procedure btGrTabClick(Sender: TObject);
    procedure sgGuardsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btCopyClick(Sender: TObject);
    procedure cbChartTypeChange(Sender: TObject);
  private
    FControlIndex:integer;
//    FSeriesCount:integer;
    FStartElement:IDMElement;

    FBattleModel: IBattleModel;
//    FBattleUnit: IBattleUnit;
    FOldCurrentGroup:IDMElement;
    FGuardGroups:IDMCollection;
    FAdversaryGroups:IDMCollection;

    procedure MakeTables;
    procedure FindStartNode(const Element: IDMElement;
                            var StartNode, NextToStartNode: IDMElement);
    procedure MakeChart;
  protected

    procedure OpenDocument; override; safecall;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;
    function Get_BattleModel: IUnknown; safecall;
    procedure Set_BattleModel(const Value: IUnknown); safecall;

  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  SuccessFrm, GuardFrm;

{$R *.dfm}

{ TDMChartX }


procedure TBattleControl.Initialize;
begin
  inherited Initialize;
  FControlIndex:=1;
  DecimalSeparator:='.';
end;

procedure TBattleControl.OpenDocument;
var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  aGuardVariant:IGuardVariant;
  aAdversaryVariant:IAdversaryVariant;
  CurrentAnalysisVariant:IAnalysisVariant;
  j:integer;
begin
  inherited;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  if FBattleModel=nil then Exit;
  FBattleModel.FacilityModel:=DMDocument.DataModel as IUnknown;
  FBattleModel.ClearBattle;
  aFacilityModel:=FBattleModel.FacilityModel as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  CurrentAnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if CurrentAnalysisVariant=nil then Exit;
  aGuardVariant:=CurrentAnalysisVariant.GuardVariant as IGuardVariant;
  aAdversaryVariant:=CurrentAnalysisVariant.AdversaryVariant as IAdversaryVariant;
  FGuardGroups:=aGuardVariant.GuardGroups;
  FAdversaryGroups:=aAdversaryVariant.AdversaryGroups;

  sgGuards.RowCount:=FGuardGroups.Count+1;
  sgGuards.Cells[0, 0]:='Охрана';
  sgGuards.Cells[1, 0]:='Состояние';
  sgGuards.Cells[2, 0]:='P выжить';
  for j:=0 to FGuardGroups.Count-1 do begin
    sgGuards.Cells[0, j+1]:=FGuardGroups.Item[j].Name;
    sgGuards.Cells[1, j+1]:=' ';
    sgGuards.Cells[2, j+1]:='1';
  end;

  sgAdversaries.RowCount:=FAdversaryGroups.Count+1;
  sgAdversaries.Cells[0, 0]:='Нарушители';
  sgAdversaries.Cells[1, 0]:='Состояние';
  sgAdversaries.Cells[2, 0]:='P выжить';
  for j:=0 to FAdversaryGroups.Count-1 do begin
    sgAdversaries.Cells[0, j+1]:=FAdversaryGroups.Item[j].Name;
    sgAdversaries.Cells[1, j+1]:=' ';
    sgAdversaries.Cells[2, j+1]:='1';
  end;
end;

procedure TBattleControl.SelectionChanged(DMElement: OleVariant);
begin
end;

destructor TBattleControl.Destroy;
begin
  inherited;
  FStartElement:=nil;
  FGuardGroups:=nil;
  FAdversaryGroups:=nil;
end;

procedure TBattleControl.FindStartNode(const Element:IDMElement;
                           var StartNode, NextToStartNode: IDMElement);
var
  ElementF:IFacilityElement;
  MinT, T:double;
  j:integer;
  PathArc, NextToStartArcL:ILine;
  aNode:IVulnerabilityData;
begin
  StartNode:=nil;
  NextToStartNode:=nil;
  if Element.ClassID=_Boundary then begin
    FStartElement:=Element;
    ElementF:=Element as IFacilityElement;
    MinT:=1000000000;
    for j:=0 to ElementF.PathArcs.Count-1 do begin
      PathArc:=ElementF.PathArcs.Item[j] as ILine;
      if not((PathArc as IPathArc).FacilityState as IPathGraph).BackPath then begin
        aNode:=PathArc.C0 as IVulnerabilityData;
        T:=aNode.DelayTimeToTarget;
        if MinT>T then begin
          MinT:=T;
          StartNode:=PathArc.C1 as IDMElement;
          NextToStartNode:=PathArc.C0 as IDMElement;
        end;
        aNode:=PathArc.C1 as IVulnerabilityData;
        T:=aNode.DelayTimeToTarget;
        if MinT>T then begin
          MinT:=T;
          StartNode:=PathArc.C0 as IDMElement;
          NextToStartNode:=PathArc.C1 as IDMElement;
        end;
      end;
    end;
  end else
  if Element.ClassID=_Zone then begin
    FStartElement:=Element;
    StartNode:=(Element as IZone).CentralNode;
    NextToStartNode:=StartNode;
  end else
  if Element.ClassID=_StartPoint then begin
    FStartElement:=Element;
    if (Element as IPathNodeArray).PathNodes.Count=0 then begin
      StartNode:=nil;
      NextToStartNode:=nil;
      Exit;
    end;
    StartNode:=(Element as IPathNodeArray).PathNodes.Item[0];
    aNode:=StartNode as IVulnerabilityData;
    NextToStartArcL:=aNode.DelayTimeToTarget_NextArc as ILine;
    NextToStartNode:=NextToStartArcL.NextNodeTo(aNode as ICoordNode) as IDMElement;
  end else begin
    Exit;
  end;
end;

procedure TBattleControl.btRestartClick(Sender: TObject);
var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  Element, StartNodeE, NextToStartNodeE:IDMElement;
  j:integer;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  BattleUnitE, BattleLineE:IDMElement;
  SMDocument:ISMDocument;
  Painter:IPainter;
  FSeries:TLineSeries;
  Unk:IUnknown;
  CurrentAnalysisVariant:IAnalysisVariant;
  aAdversaryVariant:IAdversaryVariant;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  if FBattleModel=nil then Exit;
  SMDocument:=DMDocument as ISMDocument;
  Painter:=SMDocument.PainterU as IPainter;
  aFacilityModel:=FBattleModel.FacilityModel as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  CurrentAnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  aAdversaryVariant:=CurrentAnalysisVariant.AdversaryVariant as IAdversaryVariant;
  FAdversaryGroups:=aAdversaryVariant.AdversaryGroups;

  if DMDocument.SelectionCount=0 then begin
    Element:=(CurrentAnalysisVariant.MainGroup as IWarriorGroup).StartPoint;
    if Element=nil then begin
      LStartElement.Caption:='не определена. Необходимо задать точку старта основной группы или выделить стартовый рубеж';
      Exit;
    end;
  end else begin
    Element:=DMDocument.SelectionItem[0] as IDMElement;
    if (Element.Ref<>nil) and
       (Element.Ref.SpatialElement=Element) then
      Element:=Element.Ref;
    if (Element.QueryInterface(IFacilityElement, Unk)<>0) and
       (Element.QueryInterface(IGuardPost, Unk)<>0) and
       (Element.QueryInterface(IStartPoint, Unk)<>0) then begin
      Element:=(CurrentAnalysisVariant.MainGroup as IWarriorGroup).StartPoint;
      if Element=nil then begin
        LStartElement.Caption:='не определена. Необходимо задать точку старта основной группы или выделить стартовый рубеж';
        Exit;
      end;
    end;
  end;
  FindStartNode(Element, StartNodeE, NextToStartNodeE);

  if StartNodeE=nil then begin
    LStartElement.Caption:='не определена. Необходимо сначала найти оптимальные маршруты';
    Exit;
  end;

  LStartElement.Caption:=FStartElement.Name;
  if CurrentAnalysisVariant=nil then Exit;
  LFacilityState.Caption:=(CurrentAnalysisVariant as IDMElement).Name;
  if CurrentAnalysisVariant.UserDefinedResponceTime then begin
    LStartElement.Caption:='не определена. Маршруты сил охраны не определены, так как время реагирования задано явно';
    Exit;
  end;

  FBattleModel.StartNode:=StartNodeE as IUnknown;
  FBattleModel.NextToStartNode:=NextToStartNodeE as IUnknown;

  FOldCurrentGroup:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  for j:=0 to FBattleModel.BattleUnits.Count-1 do begin
    BattleUnitE:=FBattleModel.BattleUnits.Item[j];
    BattleUnitE.Draw(Painter, 3);
  end;
  for j:=0 to FBattleModel.BattleLines.Count-1 do begin
    BattleLineE:=FBattleModel.BattleLines.Item[j];
    if (BattleLineE as IBattleLine).Visible then
      BattleLineE.Draw(Painter, 3);
  end;

  FBattleModel.ClearBattle;
  FBattleModel.StartBattle;

//Создание графика P от T
    for j:=Chart1.SeriesList.Count-1 downto 0 do
      Chart1.SeriesList.Delete(j);
    for j:=0 to FBattleModel.BattleUnits.Count-1 do
      begin
        FSeries:=TLineSeries.Create(Self);
        FSeries.ParentChart:=Chart1;
        Fseries.Title:=FBattleModel.BattleUnits.Item[j].Name;
        if Chart1.Series[j].SeriesColor=12632256 then
          Chart1.Series[j].SeriesColor:=clActiveCaption;
      end;

  for j:=0 to FBattleModel.BattleUnits.Count-1 do begin
    BattleUnitE:=FBattleModel.BattleUnits.Item[j];
    BattleUnitE.Draw(Painter, 3);
  end;

  LCurrentTime.Caption:='0.00 c';

  MakeTables;

  FacilityModelS.CurrentWarriorGroupU:=FOldCurrentGroup;

  btCalc.Enabled:=True;
  btNextStep.Enabled:=True;
  Timer1.Enabled:=False;
  btCalc.Caption:='До конца анализа';

end;

function TBattleControl.Get_BattleModel: IUnknown;
begin
  Result:=FBattleModel as IUnknown

end;

procedure TBattleControl.Set_BattleModel(const Value: IUnknown);
begin
  FBattleModel:=Value as  IBattleModel
end;

procedure TBattleControl.btNextStepClick(Sender: TObject);
var
  Server:IDataModelServer;
  SMDocument:ISMDocument;
  Painter:IPainter;
  j:integer;
  BattleUnitE, BattleLineE:IDMElement;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  BattleUnit:IBattleUnit;
begin
  LCurrentTime.Caption:=Format('%0.2f c',[FBattleModel.CurrentTime]);
  Server:=Get_DataModelServer as IDataModelServer;
  SMDocument:=Server.CurrentDocument as ISMDocument;
  if SMDocument=nil then Exit;
  Painter:=SMDocument.PainterU as IPainter;

  aFacilityModel:=FBattleModel.FacilityModel as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;

  for j:=0 to FBattleModel.BattleUnits.Count-1 do begin
    BattleUnitE:=FBattleModel.BattleUnits.Item[j];
    BattleUnitE.Draw(Painter, 3);
  end;
  for j:=0 to FBattleModel.BattleLines.Count-1 do begin
    BattleLineE:=FBattleModel.BattleLines.Item[j];
    if (BattleLineE as IBattleLine).Visible then
      BattleLineE.Draw(Painter, 3);
  end;

  if not FBattleModel.NextStep then begin
    btCalc.Enabled:=False;
    btNextStep.Enabled:=False;
    for j:=0 to FBattleModel.BattleUnits.Count-1 do
      Begin
        BattleUnit:=FBattleModel.BattleUnits.Item[j] as IBattleUnit;
        BattleUnit.LastStep;
      end;
    Timer1.Enabled:=False;
    btCalc.Caption:='До конца анализа';
  end;

  for j:=0 to FBattleModel.BattleUnits.Count-1 do begin
    BattleUnitE:=FBattleModel.BattleUnits.Item[j];
    BattleUnitE.Draw(Painter, 3);
  end;
  for j:=0 to FBattleModel.BattleLines.Count-1 do begin
    BattleLineE:=FBattleModel.BattleLines.Item[j];
    BattleLineE.Draw(Painter, 3);
  end;

  MakeTables;
  MakeChart;

  FacilityModelS.CurrentWarriorGroupU:=FOldCurrentGroup;
end;

procedure TBattleControl.MakeTables;
var
  j:integer;
  aBattleUnit:IBattleUnit;
  S:string;
  aFacilityModel:IFacilityModel;
  Alive:double;
begin
  aFacilityModel:=FBattleModel.FacilityModel as IFacilityModel;
  if FBattleModel.BattleUnits.Count=0 then Exit;

  for j:=0 to FGuardGroups.Count-1 do begin
    aBattleUnit:=FGuardGroups.Item[j].SpatialElement as IBattleUnit;
    if aBattleUnit<>nil then begin
      case aBattleUnit.State of
      busShotNoDefence:    S:= 'Ведет огонь в обороне, не защищен';
      busShotHalfDefence:  S:= 'Ведет огонь в обороне, защищен на половину';
      busShotChestDefence: S:= 'Ведет огонь в обороне, защищен по грудь';
      busShotHeadDefence:  S:= 'Ведет огонь в обороне, защищен';
      busHide:             S:= 'Не на линии огня';
      busShotRun:
      begin
        if aBattleUnit.FireLineCount>0 then
          S:= 'Ведет огонь в движении'
        else
          S:= 'В движении'
      end;
      busStartDelay:       S:= 'Не прибыл';
      else
        S:=' ';
      end;
      Alive:=aBattleUnit.SomebodyAlive;
    end else begin
      S:='Не задана начальная точка';
      Alive:=1;
    end;
    sgGuards.Cells[1, j+1]:=S;
    sgGuards.Cells[2, j+1]:=Format('%0.4f',[Alive]);
  end;
  for j:=0 to FAdversaryGroups.Count-1 do begin
    aBattleUnit:=FAdversaryGroups.Item[j].SpatialElement as IBattleUnit;
    case aBattleUnit.State of
    busShotNoDefence:    S:= 'Ведет огонь в обороне, не защищен';
    busShotHalfDefence:  S:= 'Ведет огонь в обороне, защищен на половину';
    busShotChestDefence: S:= 'Ведет огонь в обороне, защищен по грудь';
    busShotHeadDefence:  S:= 'Ведет огонь в обороне, защищен';
    busHide:             S:= 'Не на линии огня';
    busShotRun: 
      begin
        if aBattleUnit.FireLineCount>0 then
          S:= 'Ведет огонь в движении'
        else
          S:= 'В движении'
      end;
    busStartDelay:       S:= 'Не прибыл';
    else
      S:=' ';
    end;
    sgAdversaries.Cells[1, j+1]:=S;
    sgAdversaries.Cells[2, j+1]:=Format('%0.4f',[aBattleUnit.SomebodyAlive]);

  end;

end;

procedure TBattleControl.MakeChart;
var
  j, i:integer;
  MaxN, N, MaxT, T:double;
  BattleUnit:IBattleUnit;
begin
//Создание графика P от T
  MaxN:=0;
  MaxT:=0;
  for j:=0 to FBattleModel.BattleUnits.Count-1 do begin
    BattleUnit:=FBattleModel.BattleUnits.Item[j] as IBattleUnit;
    N:=BattleUnit.NumberArray[0];
    if (N<20) and
       (MaxN<N) then
      MaxN:=N;
    T:=BattleUnit.UsefulTimeArray[FBattleModel.TimeArrayCount-1];
    if MaxT<T then
      MaxT:=T;
  end;

  Chart1.LeftAxis.Automatic:=False;

  for j:=0 to FBattleModel.BattleUnits.Count-1 do begin
      BattleUnit:=FBattleModel.BattleUnits.Item[j] as IBattleUnit;
      Chart1.Series[j].Clear;
      case cbChartType.ItemIndex of
      0:begin
          Chart1.LeftAxis.Minimum:=0;
          Chart1.LeftAxis.Maximum:=MaxN*1.1;
        end;
      1:begin
          Chart1.LeftAxis.Minimum:=0;
          Chart1.LeftAxis.Maximum:=MaxT/60*1.1;
        end;
      2:begin
          Chart1.LeftAxis.Minimum:=0;
          Chart1.LeftAxis.Maximum:=1.1;
        end;
      end;
      for i:=0 to FBattleModel.TimeArrayCount-1 do begin
        T:=FBattleModel.TimeArray[i]/60;
        case cbChartType.ItemIndex of
        0:  Chart1.Series[j].AddXY(T, BattleUnit.NumberArray[i]);
        1:  Chart1.Series[j].AddXY(T, BattleUnit.UsefulTimeArray[i]/60);
        2:  Chart1.Series[j].AddXY(T, BattleUnit.AliveArray[i]);
        end;
      end;
    end;
end;

procedure TBattleControl.Panel1Resize(Sender: TObject);
var
  W:integer;
begin
  inherited;
  sgGuards.Width:=(Panel1.Width-5) div 2;
  W:=(sgGuards.Width-20) div 5;
  sgGuards.ColWidths[0]:=W * 3;
  sgGuards.ColWidths[1]:=W;
  sgGuards.ColWidths[2]:=W;

  W:=(sgAdversaries.Width-20) div 5;
  sgAdversaries.ColWidths[0]:=W * 3;
  sgAdversaries.ColWidths[1]:=W;
  sgAdversaries.ColWidths[2]:=W;
end;

procedure TBattleControl.btCalcClick(Sender: TObject);
var
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  j:integer;
  BattleUnit:IBattleUnit;
begin
  aFacilityModel:=FBattleModel.FacilityModel as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  FOldCurrentGroup:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  if cbShowMovment.Checked then begin
    Timer1.Enabled:=not Timer1.Enabled;
    if Timer1.Enabled then
      btCalc.Caption:='Стоп'
    else
      btCalc.Caption:='До конца анализа';
  end else begin
    while FBattleModel.NextStep do;
    btCalc.Enabled:=False;
    btNextStep.Enabled:=False;
    for j:=0 to FBattleModel.BattleUnits.Count-1 do Begin
      BattleUnit:=FBattleModel.BattleUnits.Item[j] as IBattleUnit;
      BattleUnit.LastStep;
    end;
    btCalc.Caption:='До конца анализа';
    MakeTables;
    MakeChart;
    FacilityModelS.CurrentWarriorGroupU:=FOldCurrentGroup;
  end;
end;

procedure TBattleControl.Timer1Timer(Sender: TObject);
begin
  inherited;
  btNextStepClick(btNextStep);
end;

procedure TBattleControl.Button1Click(Sender: TObject);
var
  aFacilityModelDM:IDataModel;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  CurrentAnalysisVariant:IAnalysisVariant;
  j, m:integer;
  SafeguardAnalyzer:ISafeguardAnalyzer;
  Time0, Time1:TDateTime;
  Node:ICoordNode;
  NodeE:IDMElement;
  NodeV:IVulnerabilityData;
  DelayTimeToTarget:double;
  WarriorPathE:IDMElement;
  Polyline:IPolyline;
  Line:ILine;
  NodeList:TList;
begin
  aFacilityModelDM:=FBattleModel.FacilityModel as IDataModel;
  aFacilityModel:=aFacilityModelDM as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  CurrentAnalysisVariant:=FacilityModelS as IAnalysisVariant;
  SafeguardAnalyzer:=aFacilityModelDM.Analyzer as ISafeguardAnalyzer;

  Time0:=Now;

  try
  NodeList:=TList.Create;
  for j:=0 to CurrentAnalysisVariant.WarriorPaths.Count-1 do begin
    WarriorPathE:=CurrentAnalysisVariant.WarriorPaths.Item[j];
    Polyline:=WarriorPathE.SpatialElement as IPolyline;
    for m:=0 to Polyline.Lines.Count-1 do begin
      Line:=Polyline.Lines.Item[m] as ILine;
      if NodeList.IndexOf(pointer(Line.C0))=-1 then
        NodeList.Add(pointer(Line.C0));
      if NodeList.IndexOf(pointer(Line.C1))=-1 then
        NodeList.Add(pointer(Line.C1));
    end;
  end;

  for m:=0 to NodeList.Count-1 do begin
    Node:=ICoordNode(NodeList[m]);
    if (abs(Node.X)<9999999) and
       (abs(Node.Y)<9999999) and
       (abs(Node.Z)<9999999) then begin
      NodeE:=Node as IDMElement;
      NodeV:=Node as IVulnerabilityData;
      FacilityModelS.CurrentWarriorGroupU:=CurrentAnalysisVariant.MainGroup;
      DelayTimeToTarget:=NodeV.DelayTimeToTarget;
      if DelayTimeToTarget<1000000 then begin
        FBattleModel.StartNode:=NodeE as IUnknown;
        FBattleModel.StartBattle;
        while FBattleModel.NextStep do
      end;
    end;
  end;
  Time1:=Now;
  ShowMessage(IntToStr(SafeguardAnalyzer.PathNodes.Count)+' '+TimeToStr(Time0-Time1));
  NodeList.Free;
  except
    raise
  end;
end;

procedure TBattleControl.btSuccessClick(Sender: TObject);
var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  Element:IDMElement;
  aFacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  Boundary:IBoundary;
  PolylineU:IUnknown;
  WarriorGroup, FacilityState:IDMElement;
  SuccessProbability:double;
  SpatialModel2:ISpatialModel2;
  AnalysisVariant:IAnalysisVariant;
  OptimalPathE:IDMElement;


begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if FBattleModel=nil then Exit;
  if DMDocument=nil then Exit;

  aFacilityModel:=FBattleModel.FacilityModel as IFacilityModel;
  FacilityModelS:=aFacilityModel as IFMState;
  AnalysisVariant:=FacilityModelS.CurrentAnalysisVariantU as IAnalysisVariant;
  if AnalysisVariant=nil then Exit;

  if DMDocument.SelectionCount=0 then begin
    if AnalysisVariant.WarriorPaths.Count=0 then Exit;
    OptimalPathE:=AnalysisVariant.WarriorPaths.Item[0];
    PolylineU:=OptimalPathE.SpatialElement as IUnknown;
    FStartElement:=OptimalPathE;
  end else begin
    Element:=DMDocument.SelectionItem[0] as IDMElement;
    if (Element.Ref<>nil) and
       (Element.Ref.SpatialElement=Element) then
      Element:=Element.Ref;
    if Element.ClassID<>_Boundary then  begin
      LStartElement.Caption:='не определена. Необходимо выделить рубеж, на котором произошло обнаружение нарушителя';
      Exit;
    end;

    Boundary:=Element as IBoundary;
    Boundary.OptimalPath;

    if Boundary.OptimalPath=nil then begin
      LStartElement.Caption:='не определена. Необходимо сначала найти оптимальные маршруты';
      Exit;
    end;
    PolylineU:=(Boundary.OptimalPath as IDMElement).SpatialElement as IUnknown;

    FStartElement:=Element;
  end;
  LStartElement.Caption:=FStartElement.Name;

  if (PolylineU as IPolyline).Lines.Count=0 then begin
    LStartElement.Caption:='не определена. Необходимо сначала найти оптимальные маршруты';
    Exit;
  end;


  LFacilityState.Caption:=(AnalysisVariant as IDMElement).Name;
  if AnalysisVariant.UserDefinedResponceTime then begin
    LStartElement.Caption:='не определена. Маршруты сил охраны не определены, так как время реагирования задано явно';
    Exit;
  end;

  SpatialModel2:=aFacilityModel as ISpatialModel2;
  FacilityState:=FacilityModelS.CurrentFacilityStateU as IDMElement;
  WarriorGroup:=AnalysisVariant.MainGroup as IDMElement;

  if fmSuccess=nil then
    fmSuccess:=TfmSuccess.Create(Self);
  fmSuccess.LBoundary.Caption:=FStartElement.Name;
  fmSuccess.LCount.Caption:=Format('%d', [(PolylineU as IPolyline).Lines.Count]);

  fmSuccess.LSuccess.Visible:=False;
  fmSuccess.LSuccessLabel.Visible:=False;
  fmSuccess.btOK.Enabled:=False;
  fmSuccess.Show;

  try
  SuccessProbability:=FBattleModel.CalcSccessProbabilityOnPath(PolylineU);

  fmSuccess.LSuccess.Caption:=Format('%0.4f',[SuccessProbability]);
  fmSuccess.LSuccess.Visible:=True;
  fmSuccess.LSuccessLabel.Visible:=True;
  finally
    fmSuccess.btOK.Enabled:=True;
  end;  
end;

procedure TBattleControl.btGrTabClick(Sender: TObject);
begin
  inherited;
  if btGrTab.Caption='График' then
    begin
      btGrTab.Caption:='Таблица';
      Panel2.Visible:=True;
      Panel3.Visible:=False;
    end
  else
    begin
      btGrTab.Caption:='График';
      Panel2.Visible:=False;
      Panel3.Visible:=True;
    end;

end;

procedure TBattleControl.sgGuardsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  if fmGuardFrm=nil then
    fmGuardFrm:=TfmGuardFrm.Create(Self);
  fmGuardFrm.BattleModel:=FBattleModel;  
  fmGuardFrm.ShowModal;
//  if fmGuardFrm.ShowModal=mrOK then Exit;
  end;

procedure TBattleControl.btCopyClick(Sender: TObject);
begin
  Chart1.CopyToClipboardMetafile(True)
//  Chart1.CopyToClipboardBitmap;
end;

procedure TBattleControl.cbChartTypeChange(Sender: TObject);
begin
  MakeChart;
end;

end.
