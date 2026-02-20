unit DetailsControlU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls, 
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU,
  SpatialModelLib_TLB, FacilityModelLib_TLB, SafeguardAnalyzerLib_TLB;
const
  ShoulderWidth=100;
  wpsStelthEntry=0;
  wpsFastEntry=1;
  wpsStelthExit=2;
  wpsFastExit=3;

  InfinitValue=1000000000;

type

  TDetailsControl = class(TDMPage)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    lName: TLabel;
    Panel3: TPanel;
    sgData: TStringGrid;
    chbTable: TComboBox;
    lFacilityState: TLabel;
    chbFacilityState: TComboBox;
    lWarriorGroup: TLabel;
    chbWarriorGroup: TComboBox;
    Label4: TLabel;
    chbWarriorPathStage: TComboBox;
    Header: THeaderControl;
    lTactic: TLabel;
    chbTactic: TComboBox;
    pAreas: TPanel;
    cbFrom: TComboBox;
    Label1: TLabel;
    lPoint: TLabel;
    cbTo: TComboBox;
    Label2: TLabel;
    chbAnalysisVariant: TComboBox;
    mComment: TMemo;
    Splitter1: TSplitter;
    procedure HeaderMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure HeaderSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure chbChange(Sender: TObject);
    procedure chbWarriorGroupChange(Sender: TObject);
    procedure chbWarriorPathStageChange(Sender: TObject);
    procedure cbFromToChange(Sender: TObject);
    procedure sgDataTopLeftChanged(Sender: TObject);
    procedure chbAnalysisVariantChange(Sender: TObject);
    procedure chbFacilityStateChange(Sender: TObject);
    procedure sgDataExit(Sender: TObject);
    procedure sgDataSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    FElement:pointer;
    FChangingTable:boolean;
    FClearing:boolean;
    FRemarkCol:integer;
    FSortedAreas:TList;
    FLineE:IDMElement;
    FNodeDirection:integer;
    FDirectPath:WordBool;
    FTime:double;
    procedure SetSafeguardElement;
    procedure SetBoundaryLayer(TableItemIndex:integer);
    procedure SetBoundary;
    procedure SetZone;
    procedure SetZonePath;
    procedure SetWarriorPath;
    procedure SetWarriorPathElement;
    procedure SetSafeguardElementTactics;
    procedure SetBoundaryLayerTactics;
    procedure SetZoneTactics;
    procedure DoSafeguardElementCalc(
              const SafeguardElementE, TacticE:IDMElement;
                    aTime:double; j, Mode:integer);
    procedure DoBoundaryLayerCalc(const BoundaryLayerE,
                 WarriorGroupE, FacilityStateE, LineE, TacticE,
                 Zone0E, Zone1E:IDMElement;
                 j:integer; out T, DetP:double);
    procedure SetRemarkCol(W0, W1: integer);
    procedure SetHeaderWidth;
    procedure SetNodeDirection(WarriorPathStage: integer;
                           const Zone0, Zone1: IZone;
                           const WarriorGroup: IWarriorGroup);
    procedure SetAnalysisVariant;
    procedure BuildTableFromReport(const Report: IDMText);
    procedure SetWarriorGroups;
    procedure SetVisualComponents(const Element: IDMElement);
    procedure SetWarriorPathStages(Mode: integer);
  protected

    procedure UpdateDocument; override; safecall;
    procedure OpenDocument; override; safecall;
    procedure SetCurrentElement(DMElement:OleVariant); override; safecall;
    procedure DocumentOperation(ElementsV,
      CollectionV: OleVariant; DMOperation, nItemIndex: Integer); override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  function AreaCompare(const Key1, Key2:IDMElement):integer;

implementation

uses
  SgdbLib_TLB, FacilityModelConstU;

var
  TMPLine:ILine;
  TMPC0, TMPC1:ICoordNode;
  TMPLineE, TMPC0E, TMPC1E, BackPathSubStateE:IDMElement;
  BackPathSubState:IFacilitySubState;

{$R *.dfm}

procedure TDetailsControl.Initialize;
begin
  inherited Initialize;
  DecimalSeparator:='.';
  FSortedAreas:=TList.Create;
end;

procedure TDetailsControl.SetVisualComponents(const Element:IDMElement);
begin
  FElement:=pointer(Element);
  if Element<>nil then begin
    lName.Caption:=Element.Name;
    Panel1.Visible:=True
  end else
    Panel1.Visible:=False
end;

procedure TDetailsControl.SetWarriorPathStages(Mode:integer);
var
  oldWarriorPathStageCount, oldWarriorPathStageIndex:integer;
begin

  oldWarriorPathStageCount:=chbWarriorPathStage.Items.Count;
  oldWarriorPathStageIndex:=chbWarriorPathStage.ItemIndex;
  if oldWarriorPathStageIndex=-1 then
    oldWarriorPathStageIndex:=0;
  chbWarriorPathStage.Clear;
  case Mode of
  0:begin
      chbWarriorPathStage.Items.Add('К цели скрытно');
      chbWarriorPathStage.Items.Add('К цели быстро');
      chbWarriorPathStage.Items.Add('От цели скрытно');
      chbWarriorPathStage.Items.Add('От цели быстро');
    end;
  1:begin
      chbWarriorPathStage.Items.Add('Оптимально');
      chbWarriorPathStage.Items.Add('Все скрытно');
      chbWarriorPathStage.Items.Add('Все быстро');
    end;
  end;
  if oldWarriorPathStageCount=chbWarriorPathStage.Items.Count then begin
    chbWarriorPathStage.ItemIndex:=oldWarriorPathStageIndex;
    chbWarriorPathStage.OnChange(nil);
  end;

  chbWarriorPathStage.Visible:=True;
end;

procedure TDetailsControl.SetCurrentElement(DMElement: OleVariant);
var
  Element:IDMElement;
  Unk:IUnknown;

var
  j:integer;
  Boundary:IBoundary;
begin
  Unk:=DMElement;
  Element:=Unk as IDMElement;

  FSortedAreas.Clear;
  if Element=nil then
    SetVisualComponents(Element)
  else
  if not Element.Exists then begin
    Element:=nil;
    SetVisualComponents(Element);
  end else
  if Element.QueryInterface(IAnalysisVariant, Unk)=0 then begin
    j:=chbAnalysisVariant.Items.IndexOfObject(pointer(Element));
    if j=-1 then
      chbAnalysisVariant.ItemIndex:=0
    else
      chbAnalysisVariant.ItemIndex:=j;
  end else
  if Element.QueryInterface(ISafeguardElement, Unk)=0 then begin
    if not FChangingTable then begin
      chbTable.Clear;
      chbTable.Items.Add('Способ преодолдения');
      chbTable.Items.Add('Тактика преодолдения');
      chbTable.Items.Add('Состояние СФЗ');
      chbTable.Items.Add('Группа');
      chbTable.ItemIndex:=0;
    end;

    FChangingTable:=True;
    SetVisualComponents(Element);
    SetWarriorPathStages(0);
    SetSafeguardElementTactics;
    FChangingTable:=False;

    SetSafeguardElement
  end else
  if Element.QueryInterface(IBoundaryLayer, Unk)=0 then begin
    if not FChangingTable then begin
      chbTable.Clear;
      chbTable.Items.Add('Средства охраны');
      chbTable.Items.Add('Тактика преодолдения');
      chbTable.Items.Add('Состояние СФЗ');
      chbTable.Items.Add('Группа');
      chbTable.ItemIndex:=0;
    end;

    FChangingTable:=True;
    SetVisualComponents(Element);
    SetWarriorPathStages(0);
    SetBoundaryLayerTactics;
    FChangingTable:=False;

    SetBoundaryLayer(chbTable.ItemIndex)
  end else
  if Element.QueryInterface(IBoundary, Boundary)=0 then begin
    if not FChangingTable then begin
      chbTable.Clear;
      chbTable.Items.Add('Слои рубежа');
      if (Boundary.BoundaryLayers.Count=1) and
         (not (Element.DataModel as IFacilityModel).ShowSingleLayer) then begin
        chbTable.Items.Add('Средства охраны');
        chbTable.Items.Add('Тактика преодолдения');
        chbTable.Items.Add('Состояние СФЗ');
        chbTable.Items.Add('Группа');
      end;
      chbTable.ItemIndex:=0;
    end;

    FChangingTable:=True;
    SetVisualComponents(Element);
    SetWarriorPathStages(0);
    FChangingTable:=False;

    SetBoundary;
  end else
  if Element.QueryInterface(IZone, Unk)=0 then begin
    if not FChangingTable then begin
      chbTable.Clear;
      chbTable.Items.Add('Средства охраны');
      chbTable.Items.Add('Тактика преодолдения');
      chbTable.Items.Add('Состояние СФЗ');
      chbTable.Items.Add('Группа');
      chbTable.ItemIndex:=0;
    end;

    FChangingTable:=True;
    SetVisualComponents(Element);
    SetWarriorPathStages(0);
    SetZoneTactics;
    FChangingTable:=False;

    SetZone;
  end else
  if Element.QueryInterface(IWarriorPath, Unk)=0 then begin
    if not FChangingTable then begin
      chbTable.Clear;
      chbTable.Items.Add('Участки маршрута');
      chbTable.Items.Add('Последовательность действий');
      chbTable.ItemIndex:=0;
    end;

    FChangingTable:=True;
    SetVisualComponents(Element);
    SetWarriorPathStages(1);
    FChangingTable:=False;

    SetWarriorPath;
  end else
  if Element.QueryInterface(IWarriorPathElement, Unk)=0 then begin
    FChangingTable:=True;
    SetVisualComponents(Element);
    FChangingTable:=False;

    SetWarriorPathElement
  end else
  if Element.Ref<>nil then begin
    Element:=Element.Ref;
    SetCurrentElement(Element);
  end else
    Panel1.Visible:=False
end;

function AcceptableTactic0(const Tactic:ITactic;
                          const WarriorGroupE:IDMElement;
                          const BoundaryLayer:IBoundaryLayer;
                          WarriorPathStage:integer):boolean;
var
  WarriorGroup:IWarriorGroup;
begin
  if ((Tactic.EntryTactic and
     ((WarriorPathStage=wpsStealthEntry) or (WarriorPathStage=wpsFastEntry))) or
    (Tactic.ExitTactic and
     ((WarriorPathStage=wpsStealthExit) or (WarriorPathStage=wpsFastExit)))) and
    ((Tactic.StealthTactic and
     ((WarriorPathStage=wpsStealthEntry) or (WarriorPathStage=wpsStealthExit))) or
    (Tactic.FastTactic and
     ((WarriorPathStage=wpsFastEntry) or (WarriorPathStage=wpsFastExit)))) then begin

    Result:=True;
    if (WarriorGroupE.ClassID=_AdversaryGroup) then begin
      WarriorGroup:=WarriorGroupE as IWarriorGroup;
      if (WarriorGroup.Accesses.Count=0) and
          not Tactic.OutsiderTactic then
        Result:=False;
      if (WarriorGroup.Accesses.Count>0) and
        not Tactic.InsiderTactic then
        Result:=False;
    end else
    if (WarriorGroupE.ClassID=_GuardGroup) then begin
      if not Tactic.GuardTactic then
        Result:=False;
      if Tactic.DeceitTactic then
        Result:=False;
    end;

    if Result and
      (BoundaryLayer<>nil) then
      Result:=BoundaryLayer.AcceptableTactic(Tactic)
  end else
    Result:=False
end;

procedure TDetailsControl.DoSafeguardElementCalc(
              const SafeguardElementE, TacticE:IDMElement;
                    aTime:double; j, Mode:integer);
var
  SafeguardElementTypeE, SafeguardElementKindE:IDMElement;
  SafeguardElementType:ISafeguardElementType;
  SafeguardElement:ISafeguardElement;
  Tactic:ITactic;
  T, TDisp, DetP, BestTime:double;
  DistantDetectionElement:IDistantDetectionElement;
  DontCalc, F0, F1:boolean;
  Line:ILine;
  C0, C1:ICoordNode;
  X0, Y0, Z0, X1, Y1, Z1:double;
  CRef0, CRef1:IDMElement;
  FacilityModelS:IFMState;
begin
  FacilityModelS:=SafeguardElementE.DataModel as IFMState;
  SafeguardElement:=SafeguardElementE as ISafeguardElement;
  SafeguardElementKindE:=SafeguardElementE.Ref;
  SafeguardElementTypeE:=SafeguardElementKindE.Parent;
  SafeguardElementType:=SafeguardElementTypeE as ISafeguardElementType;
  Tactic:=TacticE as ITactic;

  case chbWarriorPathStage.ItemIndex of
  1,3: begin
         if SafeguardElementType.CanDelay then begin
           DontCalc:=False;
           if SafeguardElement.QueryInterface(IDistantDetectionElement,
                                           DistantDetectionElement)=0 then begin
             Line:=FacilityModelS.CurrentLineU as ILine;
             C0:=Line.C0;
             C1:=Line.C1;
             CRef0:=(C0 as IDMElement).Ref;
             CRef1:=(C1 as IDMElement).Ref;
             X0:=C0.X;
             Y0:=C0.Y;
             Z0:=C0.Z;
             X1:=C1.X;
             Y1:=C1.Y;
             Z1:=C1.Z;
             F0:=DistantDetectionElement.PointInDetectionZone(X0, Y0, Z0, CRef0, nil);
             F1:=DistantDetectionElement.PointInDetectionZone(X1, Y1, Z1, CRef1, nil);
             DontCalc:=F0 and F1;
           end;
           if DontCalc then begin
              sgData.Cells[1, j]:='-';
              sgData.Cells[FRemarkCol, j]:='Задержка учитывается на границе зоны видимости';
            end else begin
              SafeguardElement.CalcDelayTime(TacticE, T, TDisp);
              if T<1000000 then begin
                sgData.Cells[1, j]:=Format('%0.0f',[T]);
                if Tactic.FastTactic then begin
                  if SafeguardElement.CurrOvercomeMethod<>nil then
                    sgData.Cells[FRemarkCol, j]:=SafeguardElement.CurrOvercomeMethod.Name
                  else
                    sgData.Cells[FRemarkCol, j]:='Ошибка !!!'
                end else
                  sgData.Cells[FRemarkCol, j]:='-'
              end else begin
                sgData.Cells[1, j]:='Бесконечно';
                sgData.Cells[FRemarkCol, j]:='Тактика не применима';
              end;
            end;
          end else begin
            sgData.Cells[1, j]:='-';
          end;
       end;
  0,2:
    begin
      SafeguardElement.CalcDetectionProbability(TacticE, DetP, BestTime);

      if BestTime<1000000 then begin
        sgData.Cells[1, j]:=Format('%0.0f',[BestTime]);
      end else begin
        sgData.Cells[1, j]:='Бесконечно';
        sgData.Cells[FRemarkCol, j]:='Тактика не применима';
      end;

      sgData.Cells[2, j]:=Format('%0.4f',[DetP]);
      if Tactic.StealthTactic then begin
        if SafeguardElement.CurrOvercomeMethod<>nil then
          sgData.Cells[FRemarkCol, j]:=SafeguardElement.CurrOvercomeMethod.Name
        else
          sgData.Cells[FRemarkCol, j]:='Ошибка !!!'
      end else
        sgData.Cells[2, j]:='-';
    end;
  end;
end;


procedure TDetailsControl.SetSafeguardElement;
var
  SafeguardElementE, SafeguardElementKindE:IDMElement;
  SafeguardElement:ISafeguardElement;
  SafeguardElementS:IElementState;
  SafeguardElementType:ISafeguardElementType;
  SafeguardElementTypeE,
  OvercomeMethodE, FacilityStateE, WarriorGroupE, AnalysisVariantE,
  LineE, TacticE:IDMElement;
  W0, W1, j, N, k, WarriorPathStage:integer;
  T, DetP, P0, Pf, WorkP:double;
  WarriorGroup:IWarriorGroup;
  FacilityModelS:IFMState;
  OvercomeMethod:IOvercomeMethod;
  Boundary:IBoundary;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerType:IBoundaryLayerType;
  Jump:IJump;
  DMDocument:IDMDocument;
  OldState:integer;
  Tactic:ITactic;
  Zone0, Zone1:IZone;
  Zone0E, Zone1E:IDMElement;

  function GetTactic(const OvercomeMethodE:IDMElement):IDMElement;
  var
    Tactic:ITactic;
    OvercomeMethod:IOvercomeMethod;
  begin
    OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
    Tactic:=nil;
    k:=0;
    while k<OvercomeMethod.Tactics.Count do begin
      Tactic:=OvercomeMethod.Tactics.Item[k] as ITactic;
      if AcceptableTactic0(Tactic,WarriorGroupE,
                          BoundaryLayer, WarriorPathStage) then
        Break
      else
        inc(k)
    end;

    if k<OvercomeMethod.Tactics.Count then
      Result:=Tactic as IDMElement
    else
      Result:=nil
  end;

begin
  pAreas.Visible:=False;

  W1:=49;
  W0:=(sgData.Width-1-8*(W1+1)) div 2;
  if not FChangingTable then begin
    sgData.Visible:=False;
    sgData.ColWidths[0]:=W0;
    sgData.ColWidths[1]:=W1;
    sgData.ColWidths[2]:=W1;

    Header.Sections[0].Text:=chbTable.Items[chbTable.ItemIndex];
    Header.Sections[1].Text:='T, с';
    Header.Sections[2].Text:='P';
  end;

  SafeguardElementE:=IDMElement(FElement);
  SafeguardElement:=SafeguardElementE as ISafeguardElement;
  SafeguardElementS:=SafeguardElementE as IElementState;
  SafeguardElementKindE:=SafeguardElementE.Ref;
  if SafeguardElementKindE=nil then Exit;
  SafeguardElementTypeE:=SafeguardElementKindE.Parent;
  SafeguardElementType:=SafeguardElementTypeE as ISafeguardElementType;

  if chbAnalysisVariant.ItemIndex=-1 then Exit;
  if chbTactic.ItemIndex=-1 then Exit;
  if chbFacilityState.ItemIndex=-1 then Exit;
  if chbWarriorGroup.ItemIndex=-1 then Exit;

  TacticE:=IDMElement(pointer(chbTactic.Items.Objects[chbTactic.ItemIndex]));
  Tactic:=TacticE as ITactic;

  AnalysisVariantE:=IDMElement(pointer(chbAnalysisVariant.Items.Objects[chbAnalysisVariant.ItemIndex]));

  FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[chbFacilityState.ItemIndex]));

  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));
  WarriorGroup:=WarriorGroupE as IWarriorGroup;

  FacilityModelS:=SafeguardElementE.DataModel as IFMState;
  if FacilityModelS=nil then Exit;

  Boundary:=nil;
  Jump:=nil;
  if (SafeguardElementE.Parent<>nil) and
    (SafeguardElementE.Parent.ClassID=_BoundaryLayer) then begin
    BoundaryLayer:=SafeguardElementE.Parent as IBoundaryLayer;
    BoundaryLayerType:=SafeguardElementE.Parent.Ref as IBoundaryLayerType;
    Boundary:=SafeguardElementE.Parent.Parent as IBoundary;
    Zone0E:=Boundary.Get_Zone0;
    Zone1E:=Boundary.Get_Zone1;
  end else begin
    Zone0E:=nil;
    Zone1E:=nil;
    BoundaryLayer:=nil;
    BoundaryLayerType:=nil;
  end;
  Zone0:=Zone0E as IZone;
  Zone1:=Zone1E as IZone;

  WarriorPathStage:=chbWarriorPathStage.ItemIndex;

  SetNodeDirection(WarriorPathStage, Zone0, Zone1, WarriorGroup);

  DMDocument:=SafeguardElementE.DataModel.Document as IDMDocument;
  OldState:=DMDocument.State;
  DMDocument.State:=DMDocument.State or dmfCommiting;
  try
  if Boundary<>nil then
    LineE:=Boundary.MakeTemporyPath
  else
  if Jump<>nil then
    LineE:=(Jump as IDMElement).SpatialElement
  else
    LineE:=nil;
  finally
    DMDocument.State:=OldState;
  end;

  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;
  FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
  FacilityModelS.CurrentWarriorGroupU:=WarriorGroupE;
  FacilityModelS.CurrentZone0U:=Zone0E;
  FacilityModelS.CurrentZone1U:=Zone1E;
  FacilityModelS.CurrentLineU:=LineE;
  FacilityModelS.CurrentDirectPathFlag:=FDirectPath;
  FacilityModelS.CurrentNodeDirection:=FNodeDirection;
  FacilityModelS.CurrentPathStage:=WarriorPathStage;
  FacilityModelS.TotalBackPathDelayTime:=0;
  FacilityModelS.TotalBackPathDelayTimeDispersion:=0;
  if (SafeguardElementE.Parent<>nil) and
    (SafeguardElementE.Parent.ClassID=_BoundaryLayer) then
    FacilityModelS.CurrentPathArcKind:=pakVBoundary
  else
    FacilityModelS.CurrentPathArcKind:=pakHZone;
  FacilityModelS.CurrentTacticU:=TacticE;

  if Zone0<>nil then
    Zone0.CalcPatrolPeriod;
  if Zone1<>nil then
    Zone1.CalcPatrolPeriod;

  chbTable.Visible:=True;
  N:=0;
  case chbTable.ItemIndex of
  0:begin    // Способ преодоления
      chbTactic.Visible:=False;
      lTactic.Visible:=False;
      chbFacilityState.Visible:=True;
      lFacilityState.Visible:=True;
      chbWarriorGroup.Visible:=True;
      lWarriorGroup.Visible:=True;

//      if not FChangingTable then begin
        sgData.ColCount:=10;

        sgData.ColWidths[0]:=sgData.Width div 2;
        sgData.ColWidths[3]:=W1;
        sgData.ColWidths[4]:=W1;
        sgData.ColWidths[5]:=W1;
        sgData.ColWidths[6]:=W1;
        sgData.ColWidths[7]:=W1;
        sgData.ColWidths[8]:=W1;
        sgData.ColWidths[9]:=sgData.Width-(W0+1)-8*(W1+1);
        SetHeaderWidth;
        Header.Sections[3].Text:='Pо';
        Header.Sections[4].Text:='Pз';
        Header.Sections[5].Text:='Pч';
        Header.Sections[6].Text:='Pт';
        Header.Sections[7].Text:='Pп';
        Header.Sections[8].Text:='Pн';
        Header.Sections[9].Text:='Примечания';
//      end;

      N:=0;
      FClearing:=True;
      sgData.RowCount:=1;
      FClearing:=False;

      FacilityModelS.ForceTacticEnabled:=True;
      for j:=0 to SafeguardElementType.OvercomeMethods.Count-1 do begin
        OvercomeMethodE:=SafeguardElementType.OvercomeMethods.Item[j];
        OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
        if (OvercomeMethod.DelayProcCode<>longint(dpcInfinit)) and
           SafeguardElement.AcceptableMethod(OvercomeMethodE) and
           WarriorGroup.AcceptableMethod(OvercomeMethodE) then begin
          TacticE:=GetTactic(OvercomeMethodE);
          if TacticE<>nil then begin
            sgData.Objects[0, N]:=pointer(OvercomeMethod);
            sgData.Cells[0, N]:=OvercomeMethodE.Name;

            if SafeguardElementType.CanDelay then begin
              T:=SafeguardElement.DoCalcDelayTime(OvercomeMethodE);
              if T<1000000 then begin
                sgData.Cells[1, N]:=Format('%0.0f',[T]);
                sgData.Cells[9, N]:='';
              end else begin
                sgData.Cells[1, N]:='Бесконечно';
                sgData.Cells[9, N]:='Способ не применим';
              end;
            end else begin
              T:=0;
              sgData.Cells[1, N]:='-';
            end;

            if T<1000000 then begin
              DetP:=SafeguardElement.DoCalcDetectionProbability(TacticE,
                            OvercomeMethodE,
                            T, P0, Pf, WorkP, True);

              sgData.Cells[2, N]:=Format('%0.4f',[DetP]);
              sgData.Cells[3, N]:=Format('%0.4f',[P0]);

              if OvercomeMethod.PhysicalFields.Count>0 then begin
                if OvercomeMethod.PhysicalFieldValue[0]>=0 then
                  sgData.Cells[4, N]:=Format('%0.4f',[Pf])
                else
                  sgData.Cells[4, N]:='-';
              end else
                sgData.Cells[4, N]:='-';

              if (Boundary<>nil) and
                 (Boundary.Observers.Count<>0) then
                sgData.Cells[5, N]:=Format('%0.4f',[0])
              else
                sgData.Cells[5, N]:='-';

              sgData.Cells[6, N]:='-';

              sgData.Cells[7, N]:=Format('%0.4f',[0]);
              sgData.Cells[8, N]:=Format('%0.4f',[WorkP]);

            end else begin    // if (T>=1000000)
              sgData.Cells[2, N]:='1';

              sgData.Cells[3, N]:='-';
              sgData.Cells[4, N]:='-';
              sgData.Cells[5, N]:='-';
              sgData.Cells[6, N]:='-';
              sgData.Cells[7, N]:='-';
              sgData.Cells[8, N]:='-';
            end;
            inc(N);
            sgData.RowCount:=N;
          end;  //if TacticE<>nil
        end;  //if SafeguardElement.AcceptableMethod...
      end; //for j:=0 to SafeguardElementType.OvercomeMethods.Count-1
      FacilityModelS.ForceTacticEnabled:=False;
    end;  // 0:
   1:begin  // тактика
      chbTactic.Visible:=False;
      lTactic.Visible:=False;
      chbFacilityState.Visible:=True;
      lFacilityState.Visible:=True;
      chbWarriorGroup.Visible:=True;
      lWarriorGroup.Visible:=True;


      N:=chbTactic.Items.Count;
      sgData.RowCount:=N;
      sgData.Visible:=(N>0);
//      if not FChangingTable then begin
        sgData.ColCount:=4;
        sgData.ColWidths[3]:=sgData.Width-(W0+1)-2*(W1+1);
        SetHeaderWidth;
        Header.Sections[3].Text:='Наилучший способ преодоления';
//      end;

      for j:=0 to chbTactic.Items.Count-1 do begin
        TacticE:=IDMElement(pointer(chbTactic.Items.Objects[j]));
        Tactic:=TacticE as ITactic;
        sgData.Cells[0, j]:=TacticE.Name;
        FTime:=0;
        DoSafeguardElementCalc(SafeguardElementE, TacticE,
                 FTime, j, 0);
      end;
    end; // 1:
   2:begin  // Состояния СФЗ
      chbTactic.Visible:=True;
      lTactic.Visible:=True;
      chbFacilityState.Visible:=False;
      lFacilityState.Visible:=False;
      chbWarriorGroup.Visible:=True;
      lWarriorGroup.Visible:=True;

      N:=chbFacilityState.Items.Count;
      sgData.RowCount:=N;
      sgData.Visible:=(N>0);

//      if not FChangingTable then begin
        sgData.ColCount:=4;
        sgData.ColWidths[3]:=sgData.Width-(W0+1)-2*(W1+1);
        SetHeaderWidth;
        Header.Sections[3].Width:=sgData.ColWidths[3];
        Header.Sections[3].Text:='Наилучший способ преодоления';
//      end;

      for j:=0 to chbFacilityState.Items.Count-1 do begin
        FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[j]));
        FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
        if Zone0<>nil then
          Zone0.CalcPatrolPeriod;
        if Zone1<>nil then
          Zone1.CalcPatrolPeriod;
        sgData.Cells[0, j]:=FacilityStateE.Name;
        FTime:=0;
        DoSafeguardElementCalc(SafeguardElementE,
               TacticE, FTime, j, 0);
      end;
    end; // 2:
   3:begin  // Группы
      chbTactic.Visible:=True;
      lTactic.Visible:=True;
      chbFacilityState.Visible:=True;
      lFacilityState.Visible:=True;
      chbWarriorGroup.Visible:=False;
      lWarriorGroup.Visible:=False;

      N:=chbWarriorGroup.Items.Count;
      sgData.RowCount:=N;
      sgData.Visible:=(N>0);

//      if not FChangingTable then begin
         sgData.ColCount:=4;
        sgData.ColWidths[3]:=sgData.Width-(W0+1)-2*(W1+1);
        SetHeaderWidth;
        Header.Sections[3].Text:='Наилучший способ преодоления';
//      end;

      for j:=0 to chbWarriorGroup.Items.Count-1 do begin
        WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[j]));
        sgData.Cells[0, j]:=WarriorGroupE.Name+'/'+
                            WarriorGroupE.Parent.Name;
        if AcceptableTactic0(Tactic,WarriorGroupE, BoundaryLayer, WarriorPathStage) then begin
          FTime:=0;
          DoSafeguardElementCalc(SafeguardElementE,TacticE,
                 FTime, j, 0)
        end else begin
          sgData.Cells[1, j]:='-';
          sgData.Cells[2, j]:='-';
          sgData.Cells[3, j]:='Тактика не применима';
        end;
      end;
    end; // 3:
  end; // case chbTable.ItemIndex
  sgData.Visible:=(N>0);
end;

destructor TDetailsControl.Destroy;
begin
  inherited;
  FSortedAreas:=nil;
  FLineE:=nil;
end;

procedure TDetailsControl.HeaderMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  XX:integer;
begin
  Header.ShowHint:=True;
  XX:=Header.Sections[0].Width;
  if X<XX then begin
    Header.ShowHint:=False;
    Exit;
  end;
  XX:=XX+Header.Sections[1].Width;
  if X<XX then begin
    Header.Hint:='Время задержки';
    Exit;
  end;
  case chbTable.ItemIndex of
  0:begin
    if Header.Sections.Count<3 then begin
      Header.ShowHint:=False;
      Exit;
    end;
    XX:=XX+Header.Sections[2].Width;
    if X<XX then begin
      Header.Hint:='Вероятность обнаружения (полная)';
      Exit;
    end;
    if Header.Sections.Count<4 then begin
      Header.ShowHint:=False;
      Exit;
    end;
    XX:=XX+Header.Sections[3].Width;
    if X<XX then begin
      Header.Hint:='Вероятность обнаружения непосредственно средством охраны';
      Exit;
    end;
    if Header.Sections.Count<5 then begin
      Header.ShowHint:=False;
      Exit;
    end;
    XX:=XX+Header.Sections[4].Width;
    if X<XX then begin
      Header.Hint:='Вероятность обнаружения демаскирующих факторов (звука и т.п.)';
      Exit;
    end;
    XX:=XX+Header.Sections[5].Width;
    if X<XX then begin
      Header.Hint:='Вероятность визуального обнаружения часовым на посту';
      Exit;
    end;
    XX:=XX+Header.Sections[6].Width;
    if X<XX then begin
      Header.Hint:='Вероятность обнаружения с использованием СТН';
      Exit;
    end;
    XX:=XX+Header.Sections[7].Width;
    if X<XX then begin
      Header.Hint:='Вероятность обнаружения патрулем или персоналом';
      Exit;
    end;
    XX:=XX+Header.Sections[8].Width;
    if X<XX then begin
      Header.Hint:='Вероятность исправного состояния';
      Exit;
    end;
    end;
  1:begin
    if Header.Sections.Count<3 then begin
      Header.ShowHint:=False;
      Exit;
    end;
    XX:=XX+Header.Sections[2].Width;
    if X<XX then begin
      Header.Hint:='Вероятность обнаружения';
      Exit;
    end;
    end;
  end;

  Header.ShowHint:=False
end;

procedure TDetailsControl.HeaderSectionResize(
  HeaderControl: THeaderControl; Section: THeaderSection);
var
  j:integer;
begin
  for j:=0 to sgData.ColCount-1 do
    sgData.ColWidths[j]:=HeaderControl.Sections[j].Width-1;
end;

procedure TDetailsControl.chbChange(Sender: TObject);
var
  Element:IDMElement;
  Zone:IZone;
begin
  inherited;
  if FChangingTable then Exit;
  Element:=IDMElement(FElement);
  if Element=nil then Exit;

  if Sender=chbTable then
    FChangingTable:=True;
  if Element.QueryInterface(IZone, Zone)=0 then
    SetZonePath
  else
    SetCurrentElement(Element);
  if Sender=chbTable then
    FChangingTable:=False;
end;

procedure TDetailsControl.SetSafeguardElementTactics;
var
  j, WarriorPathStage, TacticIndex:integer;
  WarriorGroupE, SafeguardElementE, SafeguardElementKindE,
  SafeguardElementTypeE, TacticE:IDMElement;
  Tactic:ITactic;
  BoundaryLayer:IBoundaryLayer;
begin
  TacticIndex:=chbTactic.ItemIndex;
  chbTactic.Clear;

  if chbWarriorGroup.ItemIndex=-1 then Exit;
  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));

  WarriorPathStage:=chbWarriorPathStage.ItemIndex;

  SafeguardElementE:=IDMElement(FElement);
  SafeguardElementKindE:=SafeguardElementE.Ref;
  if SafeguardElementKindE=nil then Exit;

  SafeguardElementTypeE:= SafeguardElementKindE.Parent;

  if (SafeguardElementE.Parent<>nil) and
     (SafeguardElementE.Parent.ClassID=_BoundaryLayer) then
    BoundaryLayer:=SafeguardElementE.Parent as IBoundaryLayer
  else
    BoundaryLayer:=nil;

  for j:=0 to SafeguardElementTypeE.Parents.Count-1 do begin
    if SafeguardElementTypeE.Parents.Item[j].QueryInterface(ITactic, Tactic)=0 then begin
      TacticE:=SafeguardElementTypeE.Parents.Item[j];
      Tactic:=TacticE as ITactic;
      if AcceptableTactic0(Tactic,WarriorGroupE, BoundaryLayer, WarriorPathStage) then
        chbTactic.Items.AddObject(TacticE.Name, pointer(TacticE));
    end;
  end;
  if (TacticIndex<>-1) and
     (TacticIndex<chbTactic.Items.Count) then
    chbTactic.ItemIndex:=TacticIndex
  else
    chbTactic.ItemIndex:=0
end;

procedure TDetailsControl.chbWarriorGroupChange(Sender: TObject);
var
  Element, WarriorGroupE:IDMElement;
  SafeguardElement:ISafeguardElement;
  BoundaryLayer:IBoundaryLayer;
  Zone:IZone;
begin
  inherited;
  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));

  if WarriorGroupE.ClassID=_AdversaryGroup then
    SetAnalysisVariant;

  Element:=IDMElement(FElement);
  if Element.QueryInterface(ISafeguardElement, SafeguardElement)=0 then
    SetSafeguardElementTactics
  else
  if Element.QueryInterface(IBoundaryLayer, BoundaryLayer)=0 then
    SetBoundaryLayerTactics;
  if Element.QueryInterface(IZone, Zone)=0 then
    SetZoneTactics;

//  FChangingTable:=True;
  chbChange(nil);
//  FChangingTable:=False;
end;

procedure TDetailsControl.chbWarriorPathStageChange(Sender: TObject);
var
  Element:IDMElement;
  SafeguardElement:ISafeguardElement;
  BoundaryLayer:IBoundaryLayer;
  Zone:IZone;
begin
  inherited;
  Element:=IDMElement(FElement);
  if Element=nil then Exit;
  if Element.QueryInterface(ISafeguardElement, SafeguardElement)=0 then
    SetSafeguardElementTactics
  else
  if Element.QueryInterface(IBoundaryLayer, BoundaryLayer)=0 then
    SetBoundaryLayerTactics
  else
  if Element.QueryInterface(IZone, Zone)=0 then
    SetZoneTactics;
  chbChange(nil);
end;

procedure TDetailsControl.SetRemarkCol(W0, W1:integer);
begin
  case chbWarriorPathStage.ItemIndex of
  0, 2 :
    begin
      FRemarkCol:=3;
      sgData.ColCount:=FRemarkCol+1;
//      if not FChangingTable then
      sgData.ColWidths[2]:=W1+1;
      sgData.ColWidths[FRemarkCol]:=sgData.Width-(W0+1)-2*(W1+1);
    end;
  else
    begin
      FRemarkCol:=2;
      sgData.ColCount:=FRemarkCol+1;
//      if not FChangingTable then
      sgData.ColWidths[FRemarkCol]:=sgData.Width-(W0+1)-(W1+1);
    end;
  end;
  SetHeaderWidth;

  Header.Sections[1].Text:='T, с';
  Header.Sections[2].Text:='P';
  Header.Sections[FRemarkCol].Text:='Примечания';
end;

procedure TDetailsControl.SetBoundaryLayer(TableItemIndex:integer);
var
  BoundaryLayerE, SafeguardElementE,
  SafeguardElementKindE, SafeguardElementTypeE:IDMElement;
  SafeguardElement:ISafeguardElement;
  BoundaryLayerS:IElementState;
  BoundaryLayerSU:ISafeguardUnit;
  BoundaryLayerType:IBoundaryLayerType;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerTypeE,
  FacilityStateE, WarriorGroupE, AnalysisVariantE,
  LineE, TacticE:IDMElement;
  W0, W1, j, N, WarriorPathStage:integer;
  WarriorGroup:IWarriorGroup;
  FacilityModelS:IFMState;
  Boundary:IBoundary;
  Jump:IJump;
  DMDocument:IDMDocument;
  OldState:integer;
  Tactic:ITactic;
  Zone0, Zone1:IZone;
  Zone0E, Zone1E:IDMElement;
  MinT, MinP:double;
  BestJ:integer;
  T, DetP:double;
  SubBoundary:IPathElement;
  dTDisp, NoDetP:double;
  aNoPrelDetP: double;
  aNoEvidence:WordBool;
  BestTimeSum, BestTimeDispSum:double;
  Position:integer;
begin
  pAreas.Visible:=False;

  W1:=49;
  W0:=(sgData.Width-1-7*(W1+1)) div 2;
  if not FChangingTable then begin
    sgData.Visible:=False;
    sgData.ColWidths[0]:=W0;
    sgData.ColWidths[1]:=W1;
    sgData.ColWidths[2]:=W1;

    Header.Sections[0].Text:=chbTable.Items[TableItemIndex];
    Header.Sections[1].Text:='T, с';
    Header.Sections[2].Text:='P';
  end;

  BoundaryLayerE:=IDMElement(FElement);
  BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
  BoundaryLayerSU:=BoundaryLayerE as ISafeguardUnit;
  BoundaryLayerS:=BoundaryLayerE as IElementState;
  BoundaryLayerTypeE:=BoundaryLayerE.Ref;
  BoundaryLayerType:=BoundaryLayerTypeE as IBoundaryLayerType;

  if chbTactic.ItemIndex=-1 then Exit;
  if chbFacilityState.ItemIndex=-1 then Exit;
  if chbWarriorGroup.ItemIndex=-1 then Exit;

  FacilityModelS:=BoundaryLayerE.DataModel as IFMState;
  if FacilityModelS=nil then Exit;

  TacticE:=IDMElement(pointer(chbTactic.Items.Objects[chbTactic.ItemIndex]));
  if TacticE.ClassID=_Tactic then begin
    Tactic:=TacticE as ITactic;
    SubBoundary:=nil;
  end else begin
    Tactic:=nil;
    SubBoundary:=TacticE as IPathElement;
  end;

  AnalysisVariantE:=IDMElement(pointer(chbAnalysisVariant.Items.Objects[chbAnalysisVariant.ItemIndex]));

  FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[chbFacilityState.ItemIndex]));

  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));
  WarriorGroup:=WarriorGroupE as IWarriorGroup;

  Boundary:=BoundaryLayerE.Parent as IBoundary;
  Zone0E:=Boundary.Get_Zone0;
  Zone1E:=Boundary.Get_Zone1;
  Zone0:=Zone0E as IZone;
  Zone1:=Zone1E as IZone;

  WarriorPathStage:=chbWarriorPathStage.ItemIndex;

  SetNodeDirection(WarriorPathStage, Zone0, Zone1, WarriorGroup);

  DMDocument:=BoundaryLayerE.DataModel.Document as IDMDocument;
  OldState:=DMDocument.State;
  DMDocument.State:=DMDocument.State or dmfCommiting;
  try
  if Boundary<>nil then
    LineE:=Boundary.MakeTemporyPath
  else
  if Jump<>nil then
    LineE:=(Jump as IDMElement).SpatialElement
  else
    LineE:=nil;
  finally
    DMDocument.State:=OldState;
  end;

  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;
  FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
  FacilityModelS.CurrentWarriorGroupU:=WarriorGroupE;
  FacilityModelS.CurrentZone0U:=Zone0E;
  FacilityModelS.CurrentZone1U:=Zone1E;
  FacilityModelS.CurrentLineU:=LineE;
  FacilityModelS.CurrentDirectPathFlag:=FDirectPath;
  FacilityModelS.CurrentNodeDirection:=FNodeDirection;
  FacilityModelS.CurrentPathStage:=WarriorPathStage;
  FacilityModelS.TotalBackPathDelayTime:=0;
  FacilityModelS.TotalBackPathDelayTimeDispersion:=0;
  FacilityModelS.CurrentPathArcKind:=pakVBoundary;
  FacilityModelS.CurrentTacticU:=TacticE;

  if Zone0<>nil then
    Zone0.CalcPatrolPeriod;
  if Zone1<>nil then
    Zone1.CalcPatrolPeriod;

  chbTable.Visible:=True;
  N:=0;
  case TableItemIndex of
   0:begin    // Средство охраны
      chbTactic.Visible:=True;
      lTactic.Visible:=True;
      chbFacilityState.Visible:=True;
      lFacilityState.Visible:=True;
      chbWarriorGroup.Visible:=True;
      lWarriorGroup.Visible:=True;

      SetRemarkCol(W0, W1);

      if not FChangingTable then begin
//        SetHeaderWidth;
//        sgData.ColWidths[FRemarkCol]:=sgData.Width-(W0+1)-2*(W1+1);
        Header.Sections[FRemarkCol].Text:='Наилучший способ преодоления';
      end;

      N:=0;
      FClearing:=True;
      sgData.RowCount:=1;
      FClearing:=False;
      if Tactic<>nil then begin
        if not BoundaryLayerS.UserDefinedDelayTime and
           not BoundaryLayerS.UserDefinedDetectionProbability then begin
          for j:=0 to BoundaryLayerSU.SafeguardElements.Count-1 do begin
            SafeguardElementE:=BoundaryLayerSU.SafeguardElements.Item[j];
            SafeguardElement:=SafeguardElementE as ISafeguardElement;
            if SafeguardElement.InWorkingState then begin
              SafeguardElementKindE:=SafeguardElementE.Ref;
              if SafeguardElementKindE<>nil then begin
                SafeguardElementTypeE:=SafeguardElementKindE.Parent;
                if (SafeguardElementTypeE.Parents.IndexOf(TacticE)<>-1) then begin
                  sgData.Cells[0, N]:=SafeguardElementE.Name;
                  FTime:=0;
                  DoSafeguardElementCalc(SafeguardElementE, TacticE,
                       FTime, N, 0);
                  inc(N);
                  sgData.RowCount:=N;
                end;  //SafeguardElementTypeE.Parents.IndexOf(TacticE)<>-1
              end;
            end;  //if SafeguardElement.InWorkingState(FacilityStateE)
          end; //for j:=0 to BoundaryLayer.SafeguardElements.Count-1
        end else begin
           N:=1;
           sgData.RowCount:=1;
           T:=BoundaryLayerS.DelayTime;
           DetP:=BoundaryLayerS.DetectionProbability;
           sgData.Cells[0, 0]:=' ';
           sgData.Cells[1, 0]:=Format('%0.0f',[T]);
           case WarriorPathStage of
           wpsStealthEntry,
           wpsStealthExit:
              sgData.Cells[2, 0]:=Format('%0.4f',[DetP]);
           end;
             sgData.Cells[FRemarkCol, 0]:='Время задержки и вероятность обнаружения заданы пользователем';
        end;
      end; // if Tactic<>nil
     end;  // 0:
   1:begin  // тактика
       chbTactic.Visible:=False;
       lTactic.Visible:=False;
       chbFacilityState.Visible:=True;
       lFacilityState.Visible:=True;
       chbWarriorGroup.Visible:=True;
       lWarriorGroup.Visible:=True;

       N:=chbTactic.Items.Count;
       sgData.RowCount:=N;
       sgData.Visible:=(N>0);

       SetRemarkCol(W0, W1);

       MinT:=1000000000;
       MinP:=1;
       BestJ:=-1;
       for j:=0 to chbTactic.Items.Count-1 do begin
         TacticE:=IDMElement(pointer(chbTactic.Items.Objects[j]));
         if TacticE.ClassID=_Tactic then begin
           Tactic:=TacticE as ITactic;
           sgData.Cells[0, j]:=TacticE.Name;
           DoBoundaryLayerCalc(BoundaryLayerE,
                 WarriorGroupE, FacilityStateE, LineE, TacticE,
                 Zone0E, Zone1E, j, T, DetP);
         end else begin
           SubBoundary:=TacticE as IPathElement;
           sgData.Cells[0, j]:='Проникнуть через '+TacticE.Name;
           SubBoundary.CalcDelayTime(T, dTDisp, TacticE, 0);
           SubBoundary.CalcNoDetectionProbability(NoDetP,
                         aNoPrelDetP, aNoEvidence,
                         BestTimeSum, BestTimeDispSum,
                         Position,
                          TacticE, 0);
           DetP:=1-NoDetP;
         end;

         if not BoundaryLayerS.UserDefinedDelayTime and
              not BoundaryLayerS.UserDefinedDetectionProbability then begin
           sgData.Cells[FRemarkCol,j]:='';
           case chbWarriorPathStage.ItemIndex of
           0, 2 :
             if MinP>DetP then begin
               MinP:=DetP;
               MinT:=T;
               BestJ:=j;
             end else
             if MinP=DetP then begin
               if MinT>T then begin
                 MinT:=T;
                 BestJ:=j;
               end;
             end;
           else
             if MinT>T then begin
               MinT:=T;
               BestJ:=j;
             end;
           end;
         end;
       end;
       if BestJ<>-1 then
         sgData.Cells[FRemarkCol,BestJ]:='Наилучшая тактика';
     end; // 1:
   2:begin  // Состояния СФЗ
      chbTactic.Visible:=True;
      lTactic.Visible:=True;
      chbFacilityState.Visible:=False;
      lFacilityState.Visible:=False;
      chbWarriorGroup.Visible:=True;
      lWarriorGroup.Visible:=True;

      N:=chbFacilityState.Items.Count;
      sgData.RowCount:=N;
      sgData.Visible:=(N>0);

      SetRemarkCol(W0, W1);

      if Tactic<>nil then begin
        for j:=0 to chbFacilityState.Items.Count-1 do begin
          FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[j]));
          FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
          if Zone0<>nil then
            Zone0.CalcPatrolPeriod;
          if Zone1<>nil then
            Zone1.CalcPatrolPeriod;
          sgData.Cells[0, j]:=FacilityStateE.Name;
          DoBoundaryLayerCalc(BoundaryLayerE,
                 WarriorGroupE, FacilityStateE, LineE, TacticE,
                   Zone0E, Zone1E, j, T, DetP);
          if not BoundaryLayerS.UserDefinedDelayTime and
              not BoundaryLayerS.UserDefinedDetectionProbability then
            sgData.Cells[FRemarkCol,j]:='';
        end;
      end else // if Tactic<>nil
        N:=0;
    end; // 2:
   3:begin  // Группы
      chbTactic.Visible:=True;
      lTactic.Visible:=True;
      chbFacilityState.Visible:=True;
      lFacilityState.Visible:=True;
      chbWarriorGroup.Visible:=False;
      lWarriorGroup.Visible:=False;

      N:=chbWarriorGroup.Items.Count;
      sgData.RowCount:=N;
      sgData.Visible:=(N>0);

      SetRemarkCol(W0, W1);

      if Tactic<>nil then begin
        for j:=0 to chbWarriorGroup.Items.Count-1 do begin
          WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[j]));
          sgData.Cells[0, j]:=WarriorGroupE.Name+'/'+
                              WarriorGroupE.Parent.Name;
          if AcceptableTactic0(Tactic,WarriorGroupE, BoundaryLayer, WarriorPathStage) then begin
            DoBoundaryLayerCalc(BoundaryLayerE,
                 WarriorGroupE, FacilityStateE, LineE, TacticE,
                   Zone0E, Zone1E, j, T, DetP);
            if not BoundaryLayerS.UserDefinedDelayTime and
                not BoundaryLayerS.UserDefinedDetectionProbability then
              sgData.Cells[FRemarkCol,j]:='';
          end else begin
            sgData.Cells[1, j]:='-';
            sgData.Cells[2, j]:='-';
            sgData.Cells[3, j]:='Тактика не применима';
          end;
        end;
      end else //if Tactic<>nil
        N:=0;
    end; // 3:
  end; // case TableItemIndex
  sgData.Visible:=(N>0);
end;

procedure TDetailsControl.SetBoundary;
var
  WarriorPathStage:integer;
  BoundaryE, FacilityStateE, WarriorGroupE, AnalysisVariantE,
  Zone0E, Zone1E:IDMElement;
  Zone0, Zone1:IZone;
  WarriorGroup:IWarriorGroup;
  FacilityModelS:IFMState;
  DMDocument:IDMDocument;
  OldState:integer;
  LineE, TacticE, Element:IDMElement;
  OldElement:pointer;
  Boundary:IBoundary;
  Jump:IJump;
  Report:IDMText;
  Reporter:IDMReporter;
  Analyzer:IDMAnalyzer;
begin
  pAreas.Visible:=False;

  chbTactic.Visible:=False;
//  chbTactic.Visible:=(chbTable.ItemIndex<>1);
  lTactic.Visible:=chbTactic.Visible;

  BoundaryE:=IDMElement(FElement);
  Boundary:=nil;
  Jump:=nil;
  Boundary:=BoundaryE as IBoundary;

  FacilityModelS:=BoundaryE.DataModel as IFMState;
  if FacilityModelS=nil then Exit;
  FacilityModelS.CurrentBoundary0U:=BoundaryE;
  FacilityModelS.CurrentBoundary1U:=BoundaryE;

  if BoundaryE.ClassID=_Jump then begin
    Jump:=BoundaryE as IJump;
  end else
  if BoundaryE.ClassID<>_Boundary then
    Exit;

  if Boundary.BoundaryLayers.Count=0 then
    Exit;

  if chbFacilityState.ItemIndex=-1 then Exit;
  if chbWarriorGroup.ItemIndex=-1 then Exit;
  if chbAnalysisVariant.ItemIndex=-1 then Exit;

  AnalysisVariantE:=IDMElement(pointer(chbAnalysisVariant.Items.Objects[chbAnalysisVariant.ItemIndex]));

  FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[chbFacilityState.ItemIndex]));

  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));
  WarriorGroup:=WarriorGroupE as IWarriorGroup;

  Zone0E:=Boundary.Get_Zone0;
  Zone1E:=Boundary.Get_Zone1;
  Zone0:=Zone0E as IZone;
  Zone1:=Zone1E as IZone;

  WarriorPathStage:=chbWarriorPathStage.ItemIndex;

  SetNodeDirection(WarriorPathStage, Zone0, Zone1, WarriorGroup);

  DMDocument:=BoundaryE.DataModel.Document as IDMDocument;
  OldState:=DMDocument.State;
  DMDocument.State:=DMDocument.State or dmfCommiting;
  try
  if Jump<>nil then
    LineE:=(Jump as IDMElement).SpatialElement
  else
  if Boundary<>nil then
    LineE:=Boundary.MakeTemporyPath
  else
    LineE:=nil;
   finally
    DMDocument.State:=OldState;
  end;

  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;
  FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
  FacilityModelS.CurrentPathStage:=WarriorPathStage;
  FacilityModelS.CurrentWarriorGroupU:=WarriorGroupE;
  FacilityModelS.CurrentZone0U:=Zone0E;
  FacilityModelS.CurrentZone1U:=Zone1E;
  FacilityModelS.CurrentLineU:=LineE;
  FacilityModelS.CurrentDirectPathFlag:=FDirectPath;
  FacilityModelS.CurrentNodeDirection:=FNodeDirection;
  FacilityModelS.TotalBackPathDelayTime:=0;
  FacilityModelS.TotalBackPathDelayTimeDispersion:=0;
  FacilityModelS.CurrentPathArcKind:=pakVBoundary;
  FacilityModelS.CurrentTacticU:=TacticE;

  Analyzer:=BoundaryE.DataModel.Analyzer;

  if chbTable.ItemIndex=0 then begin
    Report:=Analyzer.Report;
    Report.ClearLines;
    Reporter:=BoundaryE as IDMReporter;
    Reporter.BuildReport(0, 0, chbTable.ItemIndex, Report);
    BuildTableFromReport(Report);
    sgData.Visible:=(sgData.RowCount>1) or
                  (sgData.Cells[0,0]<>'');
  end else begin
    OldElement:=FElement;
    FElement:=pointer(Boundary.BoundaryLayers.Item[0]);
    Element:=IDMElement(FElement);
    FChangingTable:=True;
    SetVisualComponents(Element);
    SetWarriorPathStages(0);
    SetBoundaryLayerTactics;
    FChangingTable:=False;

    SetBoundaryLayer(chbTable.ItemIndex-1);
    FElement:=OldElement;
  end;

end;

procedure TDetailsControl.SetBoundaryLayerTactics;
var
  j, WarriorPathStage, TacticIndex:integer;
  WarriorGroupE, BoundaryLayerE, BoundaryLayerTypeE, TacticE:IDMElement;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerType:IBoundaryLayerType;
  Tactic:ITactic;
  SubBoundaryE:IDMElement;
  S:string;
  FacilityModelS:IFMState;
begin
  TacticIndex:=chbTactic.ItemIndex;
  chbTactic.Clear;

  if chbWarriorGroup.ItemIndex=-1 then Exit;
  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));

  WarriorPathStage:=chbWarriorPathStage.ItemIndex;

  BoundaryLayerE:=IDMElement(FElement);
  BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
  BoundaryLayerTypeE:= BoundaryLayerE.Ref;
  if BoundaryLayerTypeE=nil then Exit;

  FacilityModelS:=BoundaryLayerE.DataModel as IFMState;
  FacilityModelS.ForceTacticEnabled:=True;

  BoundaryLayerType:=BoundaryLayerTypeE as IBoundaryLayerType;
  for j:=0 to BoundaryLayerType.Tactics.Count-1 do begin
    TacticE:=BoundaryLayerType.Tactics.Item[j];
    Tactic:=TacticE as ITactic;
    if AcceptableTactic0(Tactic,WarriorGroupE, BoundaryLayer, WarriorPathStage) then
        chbTactic.Items.AddObject(TacticE.Name, pointer(TacticE));
  end;
  for j:=0 to BoundaryLayer.SubBoundaries.Count-1 do begin
    SubBoundaryE:=BoundaryLayer.SubBoundaries.Item[j];
    S:='Проникнуть через '+SubBoundaryE.Name;
    chbTactic.Items.AddObject(S, pointer(SubBoundaryE));
  end;

  FacilityModelS.ForceTacticEnabled:=False;

  if (TacticIndex<>-1) and
     (TacticIndex<chbTactic.Items.Count) then
    chbTactic.ItemIndex:=TacticIndex
  else
    chbTactic.ItemIndex:=0
end;

procedure TDetailsControl.DoBoundaryLayerCalc(const BoundaryLayerE,
  WarriorGroupE, FacilityStateE, LineE, TacticE, Zone0E,
  Zone1E: IDMElement;
  j: integer; out T, DetP:double);
var
  BoundaryLayerTypeE:IDMElement;
  BoundaryLayerType:IBoundaryLayerType;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerS:IElementState;
  BoundaryLayerPE:IPathElement;
  Tactic:ITactic;
  TimeSumDispersion,
  NoDetP,
  NoPrelDetP,
  BestTimeSum, BestTimeDispSum:double;
  NoEvidence:WordBool;
  Position:integer;
  DetectionTime:double;
begin
  BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
  BoundaryLayerPE:=BoundaryLayerE as IPathElement;
  BoundaryLayerTypeE:=BoundaryLayerE.Ref.Parent;
  BoundaryLayerType:=BoundaryLayerTypeE as IBoundaryLayerType;
  BoundaryLayerS:=BoundaryLayerE as IElementState;
  if TacticE.ClassID<>_Tactic then Exit;
  Tactic:=TacticE as ITactic;

  case chbWarriorPathStage.ItemIndex of
  1,3:
    begin
      if BoundaryLayerS.UserDefinedDelayTime then
        T:=BoundaryLayerS.DelayTime
      else
        BoundaryLayerPE.DoCalcDelayTime(TacticE, T, TimeSumDispersion, 0);

      if T<1000000 then begin
        sgData.Cells[1, j]:=Format('%0.0f',[T]);
        if BoundaryLayerS.UserDefinedDelayTime then
          sgData.Cells[3, j]:='Время задержки на слое задано пользователем'
        else
          sgData.Cells[3, j]:=' '
      end else begin
        sgData.Cells[1, j]:='Бесконечно';
        if BoundaryLayerS.UserDefinedDelayTime then
          sgData.Cells[3, j]:='Время задержки на слое задано пользователем'
        else
          sgData.Cells[3, j]:='Тактика не применима';
      end;
    end;
  0,2:
    begin
      if BoundaryLayerS.UserDefinedDetectionProbability then begin
        if BoundaryLayerS.UserDefinedDelayTime then
          BestTimeSum:=BoundaryLayerS.DelayTime
        else
          BestTimeSum:=0;

        DetP:=BoundaryLayerS.DetectionProbability;
      end else begin
        DetectionTime:=InfinitValue;
        BoundaryLayerPE.DoCalcNoDetectionProbability(TacticE, DetectionTime,
                      NoDetP,
                      NoPrelDetP,
                      NoEvidence,
                      BestTimeSum, BestTimeDispSum, Position, 0);
        DetP:=1-NoDetP;
      end;
      T:=BestTimeSum;

      if T<1000000 then begin
        sgData.Cells[1, j]:=Format('%0.0f',[T]);
        sgData.Cells[3, j]:=' '
      end else begin
        sgData.Cells[1, j]:='Бесконечно';
        sgData.Cells[3, j]:='Тактика не применима';
      end;

      sgData.Cells[2, j]:=Format('%0.4f',[DetP]);
        if BoundaryLayerS.UserDefinedDetectionProbability then
          sgData.Cells[3, j]:='Вероятность обнаружения на слое задана пользователем'
        else
          sgData.Cells[3, j]:=' '
    end;
  end;
end;

procedure TDetailsControl.SetZonePath;
var
  Zone:IZone;
  ZoneE, TacticE, FacilityStateE, WarriorGroupE,  AnalysisVariantE:IDMElement;
  WarriorPathStage:integer;
  WarriorGroup:IWarriorGroup;
  Tactic:ITactic;
  FacilityModelS:IFMState;
  FacilityModel:IFacilityModel;
  DataModel:IDataModel;
  Volume:IVolume;
  Report:IDMText;
  Reporter:IDMReporter;
  Analyzer:IDMAnalyzer;
begin
  chbTactic.Visible:=(chbTable.ItemIndex<>1);
  lTactic.Visible:=chbTactic.Visible;

  if FElement=nil then Exit;
  if FLineE=nil then Exit;

  ZoneE:=IDMElement(FElement);
  Volume:=ZoneE.SpatialElement as IVolume;

  Zone:=ZoneE as IZone;

  if (Volume<>nil) and
     (Volume.Areas.Count=0) and
     (Zone.Zones.Count>0) then Exit;

  if chbTactic.Visible and
     (chbTactic.ItemIndex=-1) then Exit;
  if chbFacilityState.ItemIndex=-1 then Exit;
  if chbWarriorGroup.ItemIndex=-1 then Exit;
  if chbAnalysisVariant.ItemIndex=-1 then Exit;

  DataModel:=ZoneE.DataModel;
  FacilityModel:=DataModel as IFacilityModel;
  if FacilityModel=nil then Exit;

  FacilityModelS:=FacilityModel as IFMState;

  if chbTactic.Visible then
    TacticE:=IDMElement(pointer(chbTactic.Items.Objects[chbTactic.ItemIndex]))
  else
    TacticE:=nil;
  Tactic:=TacticE as ITactic;

  AnalysisVariantE:=IDMElement(pointer(chbAnalysisVariant.Items.Objects[chbAnalysisVariant.ItemIndex]));
  FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[chbFacilityState.ItemIndex]));
  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));
  WarriorGroup:=WarriorGroupE as IWarriorGroup;

  WarriorPathStage:=chbWarriorPathStage.ItemIndex;
  FDirectPath:=True;

  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;
  FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
  FacilityModelS.CurrentWarriorGroupU:=WarriorGroupE;
  FacilityModelS.CurrentZone0U:=Zone;
  FacilityModelS.CurrentZone1U:=Zone;
  FacilityModelS.CurrentLineU:=FLineE;
  FacilityModelS.CurrentDirectPathFlag:=FDirectPath;
  FacilityModelS.CurrentNodeDirection:=FNodeDirection;
  FacilityModelS.CurrentPathStage:=WarriorPathStage;
  FacilityModelS.TotalBackPathDelayTime:=0;
  FacilityModelS.TotalBackPathDelayTimeDispersion:=0;
  FacilityModelS.CurrentPathArcKind:=1; //pakHZone;
  FacilityModelS.CurrentTacticU:=TacticE;

  Analyzer:=ZoneE.DataModel.Analyzer;
  Report:=Analyzer.Report;
  Report.ClearLines;
  Reporter:=ZoneE as IDMReporter;
  Reporter.BuildReport(0, 0, chbTable.ItemIndex, Report);
  try
  BuildTableFromReport(Report);
  except
    raise
  end;

  sgData.Visible:=(sgData.RowCount>1) or
                  (sgData.Cells[0,0]<>'?');

  Exit;

end;

function AcceptableTactic1(const Tactic:ITactic;
                          const WarriorGroupE:IDMElement;
                          WarriorPathStage:integer):boolean;
var
  WarriorGroup:IWarriorGroup;
begin

  if (Tactic.PathArcKind=1) and
    ((Tactic.EntryTactic and
     ((WarriorPathStage=wpsStealthEntry) or (WarriorPathStage=wpsFastEntry))) or
    (Tactic.ExitTactic and
     ((WarriorPathStage=wpsStealthExit) or (WarriorPathStage=wpsFastExit)))) and
    ((Tactic.StealthTactic and
     ((WarriorPathStage=wpsStealthEntry) or (WarriorPathStage=wpsStealthExit))) or
    (Tactic.FastTactic and
     ((WarriorPathStage=wpsFastEntry) or (WarriorPathStage=wpsFastExit)))) then begin

    Result:=True;
    if (WarriorGroupE.ClassID=_AdversaryGroup) then begin
      WarriorGroup:=WarriorGroupE as IWarriorGroup;
      if (WarriorGroup.Accesses.Count=0) and
          not Tactic.OutsiderTactic then
        Result:=False;
      if (WarriorGroup.Accesses.Count>0) and
        not Tactic.InsiderTactic then
        Result:=False;
    end else
    if (WarriorGroupE.ClassID=_GuardGroup) then begin
      if not Tactic.GuardTactic then
        Result:=False;
      if Tactic.DeceitTactic then
        Result:=False;
    end;
  end else
    Result:=False
end;

procedure TDetailsControl.SetZoneTactics;
var
  FacilityModelE:IDMElement;
  SafeguardDatabase:ISafeguardDatabase;
  j, TacticIndex, WarriorPathStage:integer;
  TacticE, WarriorGroupE:IDMElement;
  Tactic:ITactic;
begin
  TacticIndex:=chbTactic.ItemIndex;
  chbTactic.Clear;

  if chbWarriorGroup.ItemIndex=-1 then Exit;

  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));

  WarriorPathStage:=chbWarriorPathStage.ItemIndex;

  FacilityModelE:=IDMElement(FElement).DataModel as IDMElement;
  if FacilityModelE=nil then Exit;
  SafeguardDatabase:=FacilityModelE.Ref as ISafeguardDatabase;
  for j:=0 to SafeguardDatabase.Tactics.Count-1 do begin
   TacticE:=SafeguardDatabase.Tactics.Item[j];
   Tactic:=TacticE as ITactic;
   if AcceptableTactic1(Tactic,WarriorGroupE, WarriorPathStage) then
      chbTactic.Items.AddObject(TacticE.Name, pointer(TacticE));
  end;

  if (TacticIndex<>-1) and
     (TacticIndex<chbTactic.Items.Count) then
    chbTactic.ItemIndex:=TacticIndex
  else
    chbTactic.ItemIndex:=0
end;

procedure TDetailsControl.SetZone;
var
  aZoneE, ZoneE, AreaE:IDMElement;
  aZone, Zone:IZone;
  Area:IArea;
  j, m:integer;
  Volume:IVolume;
  ZoneSU:ISafeguardUnit;
  SafeguardElementE, aElement:IDMElement;
  Unk:IUnknown;
  CoordNodes2, Lines2:IDMCollection2;
  SpatialModel:ISpatialModel;
  DMDocument:IDMDocument;
  OldState:integer;
  Line:ILine;
begin
  pAreas.Visible:=False;
  chbTactic.Visible:=(chbTable.ItemIndex<>1);
  lTactic.Visible:=chbTactic.Visible;

  FSortedAreas.Clear;
  cbFrom.Clear;
  cbTo.Clear;

  ZoneE:=IDMElement(FElement);
  Volume:=ZoneE.SpatialElement as IVolume;
  if Volume<>nil then begin
    if Volume.Areas.Count=0 then begin
      sgData.Visible:=False;
      Exit;
    end;
    Zone:=ZoneE as IZone;

    pAreas.Visible:=True;


    ZoneSU:=Zone as ISafeguardUnit;
    for j:=0 to ZoneSU.SafeguardElements.Count-1 do begin
      SafeguardElementE:=ZoneSU.SafeguardElements.Item[j];
      if (SafeguardElementE.QueryInterface(ITarget, Unk)=0) or
         (SafeguardElementE.QueryInterface(IStartPoint, Unk)=0) or
         (SafeguardElementE.QueryInterface(IControlDevice, Unk)=0) or
         (SafeguardElementE.QueryInterface(IGuardPost, Unk)=0) then begin
       aElement:=SafeguardElementE.SpatialElement;
        FSortedAreas.Add(pointer(aElement));
      end;
    end;

    for j:=0 to Zone.Jumps.Count-1 do begin
      aElement:=Zone.Jumps.Item[j].SpatialElement;
      FSortedAreas.Add(pointer(aElement));
    end;

    for j:=0 to Volume.Areas.Count-1 do begin
      AreaE:=Volume.Areas.Item[j];
      if AreaE.Ref<>nil then
        FSortedAreas.Add(pointer(AreaE));
    end;

    for m:=0 to Zone.Zones.Count-1 do begin
      aZoneE:=Zone.Zones.Item[m];
      aZone:=aZoneE as IZone;
      for j:=0 to aZone.VAreas.Count-1 do begin
        AreaE:=aZone.VAreas.Item[j];
        if AreaE.Ref<>nil then
          FSortedAreas.Add(pointer(AreaE));
      end;
    end;

    FSortedAreas.Sort(@AreaCompare);

    for j:=0 to FSortedAreas.Count-1 do begin
      aElement:=IDMElement(FSortedAreas[j]);
      cbFrom.Items.AddObject(aElement.Name, pointer(aElement));
      if (aElement.QueryInterface(IArea, Area)<>0) or
         Area.IsVertical then
        cbTo.Items.AddObject(aElement.Name, pointer(aElement));
    end;
  end; // if Volume<>nil

  DMDocument:=ZoneE.DataModel.Document as IDMDocument;
  OldState:=DMDocument.State;
  DMDocument.State:=DMDocument.State or dmfCommiting;
  try
  if FLineE=nil then begin
    SpatialModel:=ZoneE.DataModel as ISpatialModel;
    Lines2:=SpatialModel.Lines as IDMCollection2;
    CoordNodes2:=SpatialModel.CoordNodes as IDMCollection2;

    FLineE:=Lines2.CreateElement(True);
    FLineE.Ref:=ZoneE;
    Line:=FLineE as ILine;
    Line.C0:=CoordNodes2.CreateElement(True) as ICoordNode;
    Line.C1:=CoordNodes2.CreateElement(True) as ICoordNode;
  end else
    Line:=FLineE as ILine;

  (Line.C0 as IDMElement).Ref:=ZoneE;
  (Line.C1 as IDMElement).Ref:=ZoneE;
  finally
    DMDocument.State:=OldState;
  end;

  cbFrom.ItemIndex:=0;
  cbTo.ItemIndex:=1;


  cbFromToChange(cbFrom);
end;


procedure TDetailsControl.cbFromToChange(Sender: TObject);
var
  j0, j1, OldState:integer;
  ZoneE, aElement0, aElement1:IDMElement;
  Volume:IVolume;
  DMDocument:IDMDocument;
  H, X00, Y00, Z00, X01, Y01, Z01, X10, Y10, Z10, X11, Y11, Z11,
  X0, Y0, Z0, X1, Y1, Z1,
  Len, L00, L01, L10, L11:double;
  C0, C1:ICoordNode;
  FacilityModelS:IFMState;

  function CalcXYZ(const aElement:IDMElement; K:integer):boolean;
  var
    X, Y, Z, X0, Y0, Z0, X1, Y1, Z1,
    D, L, cosX, cosY:double;
    Area:IArea;
    C, aC0, aC1:ICoordNode;
    Line:ILine;
  begin
    Result:=True;
    if aElement.QueryInterface(IArea, Area)=0 then begin
      if Area.IsVertical then begin
        aC0:=Area.C0;
        aC1:=Area.C1;
        if (aC0=nil) or
           (aC1=nil) then begin
          Result:=False; 
          Exit;
        end;
        X0:=aC0.X;
        Y0:=aC0.Y;
        Z0:=aC0.Z;
        X1:=aC1.X;
        Y1:=aC1.Y;
        Z1:=aC1.Z;
        L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
        cosX:=(X1-X0)/L;
        cosY:=(Y1-Y0)/L;
        X:=0.5*(X1+X0);
        Y:=0.5*(Y1+Y0);
        Z:=0.5*(Z1+Z0)+ShoulderWidth;

        FNodeDirection:=0;

        if aElement.Ref.Ref.Parent.ID=btVirtual then  // условная граница
          D:=0
        else
          D:=ShoulderWidth;

        if K=0 then begin
          X00:=X-0.5*D*cosY;
          Y00:=Y+0.5*D*cosX;
          Z00:=Z;
          X01:=X+0.5*D*cosY;
          Y01:=Y-0.5*D*cosX;
          Z01:=Z;
        end else begin
          X10:=X-0.5*D*cosY;
          Y10:=Y+0.5*D*cosX;
          Z10:=Z;
          X11:=X+0.5*D*cosY;
          Y11:=Y-0.5*D*cosX;
          Z11:=Z;
        end;

      end else begin
        if Sender=cbFrom then
          cbTo.Visible:=False
        else
          cbFrom.Visible:=False;

        Area.GetCentralPoint(X, Y, Z);
        if Volume.BottomAreas.IndexOf(aElement)<>-1 then begin
          lPoint.Caption:='и точкой над ней';

          FNodeDirection:=pdFrom0To1;

          X00:=X;
          Y00:=Y;
          Z00:=Z+ShoulderWidth;
          X01:=X00;
          Y01:=Y00;
          Z01:=Z00;

          X10:=X;
          Y10:=Y;
          Z10:=Z+H-ShoulderWidth;
          X11:=X10;
          Y11:=Y10;
          Z11:=Z10;
        end else begin
          lPoint.Caption:='и точкой под ней';

          FNodeDirection:=pdFrom1To0;

          X00:=X;
          Y00:=Y;
          Z00:=Z;
          X01:=X00;
          Y01:=Y00;
          Z01:=Z00;

          X10:=X;
          Y10:=Y;
          Z10:=Z-H+ShoulderWidth;
          X11:=X10;
          Y11:=Y10;
          Z11:=Z10;
        end;
      end;
    end else
    if aElement.QueryInterface(ILine, Line)=0 then begin
      C:=Line.C0;
      if K=0 then begin
        X00:=C.X;
        Y00:=C.Y;
        Z00:=C.Z;
        X01:=X00;
        Y01:=Y00;
        Z01:=Z00;
      end else begin
        X10:=C.X;
        Y10:=C.Y;
        Z10:=C.Z;
        X11:=X10;
        Y11:=Y10;
        Z11:=Z10;
      end;
    end else
    if aElement.QueryInterface(ICoordNode, C)=0 then begin
      if K=0 then begin
        X00:=C.X;
        Y00:=C.Y;
        Z00:=C.Z;
        X01:=X00;
        Y01:=Y00;
        Z01:=Z00;
      end else begin
        X10:=C.X;
        Y10:=C.Y;
        Z10:=C.Z;
        X11:=X10;
        Y11:=Y10;
        Z11:=Z10;
      end;
    end;
  end;

begin
  j0:=cbFrom.ItemIndex;
  j1:=cbTo.ItemIndex;
  if (j0=-1) and (j1=-1) then begin
    SetZonePath;
    Exit;
  end;
  if j0=-1 then Exit;
  if j1=-1 then Exit;

  ZoneE:=IDMElement(FElement);
  Volume:=ZoneE.SpatialElement as IVolume;
  H:=Volume.MaxZ-Volume.MinZ;

  aElement0:=IDMElement(pointer(cbFrom.Items.Objects[j0]));
  aElement1:=IDMElement(pointer(cbTo.Items.Objects[j1]));

  FacilityModelS:=ZoneE.DataModel as IFMState;
  FacilityModelS.CurrentBoundary0U:=aElement0;
  FacilityModelS.CurrentBoundary1U:=aElement1;

  DMDocument:=ZoneE.DataModel.Document as IDMDocument;
  OldState:=DMDocument.State;
  DMDocument.State:=DMDocument.State or dmfCommiting;
  try

  cbTo.Visible:=True;
  lPoint.Caption:='и точкой';
  if not CalcXYZ(aElement0,0) then Exit;
  if cbTo.Visible then
    if not CalcXYZ(aElement1,1) then Exit;

  L00 :=sqrt(sqr(X00-X10)+sqr(Y00-Y10)+sqr(Z00-Z10));
  L01 :=sqrt(sqr(X00-X11)+sqr(Y00-Y11)+sqr(Z00-Z11));
  L10 :=sqrt(sqr(X10-X10)+sqr(Y10-Y10)+sqr(Z10-Z10));
  L11 :=sqrt(sqr(X10-X11)+sqr(Y10-Y11)+sqr(Z10-Z11));

  Len:=L00;
  X0:=X00;
  Y0:=Y00;
  Z0:=Z00;
  X1:=X10;
  Y1:=Y10;
  Z1:=Z10;
  if Len>L01 then begin
    Len:=L01;
    X0:=X00;
    Y0:=Y00;
    Z0:=Z00;
    X1:=X11;
    Y1:=Y11;
    Z1:=Z11;
  end;
  if Len>L10 then begin
    Len:=L10;
    X0:=X01;
    Y0:=Y01;
    Z0:=Z01;
    X1:=X10;
    Y1:=Y10;
    Z1:=Z10;
  end;
  if Len>L11 then begin
    X0:=X01;
    Y0:=Y01;
    Z0:=Z01;
    X1:=X11;
    Y1:=Y11;
    Z1:=Z11;
  end;

  C0:=(FLineE as ILine).C0;
  C1:=(FLineE as ILine).C1;
  C0.X:=X0;
  C0.Y:=Y0;
  C0.Z:=Z0;
  C1.X:=X1;
  C1.Y:=Y1;
  C1.Z:=Z1;

  SetZonePath;

  finally
    DMDocument.State:=OldState;
  end;
end;

function AreaCompare(const Key1, Key2: IDMElement): integer;
var
  Area1, Area2:IArea;
  Code1, Code2:integer;
  RefParentID1, RefParentID2:integer;
  RefParentKind1, RefParentKind2:integer;
  RefID1, RefID2:integer;
  Key1RefRef, Key2RefRef:IDMElement;

  function GetRefParentKind(ID:integer):integer;
  begin
    case ID of
    0:Result:=1;
    1:Result:=0;
    else
      Result:=2;
    end;
  end;
begin
  try
  if Key1.QueryInterface(IArea, Area1)=0 then
    Code1:=ord(Area1.IsVertical)
  else
    Code1:=-2;
  if Key2.QueryInterface(IArea, Area2)=0 then
    Code2:=ord(Area2.IsVertical)
  else
    Code2:=-2;
  if Code1<Code2 then
    Result:=-1
  else
  if Code1>Code2 then
    Result:=+1
  else begin
    Key1RefRef:=Key1.Ref.Ref;
    Key2RefRef:=Key2.Ref.Ref;
    if Key1RefRef.Parent<>nil then
      RefParentID1:=Key1RefRef.Parent.ID
    else
      RefParentID1:=1;
    if Key2RefRef.Parent<>nil then
      RefParentID2:=Key2RefRef.Parent.ID
    else
      RefParentID2:=1;
    RefParentKind1:=GetRefParentKind(RefParentID1);
    RefParentKind2:=GetRefParentKind(RefParentID2);
    if RefParentKind1<RefParentKind2 then
      Result:=-1
    else
    if RefParentKind1>RefParentKind2 then
      Result:=+1
    else begin
      RefID1:=Key1RefRef.ID;
      RefID2:=Key2RefRef.ID;
      if RefID1<RefID2 then
        Result:=-1
      else
      if RefID1>RefID2 then
        Result:=+1
      else
        Result:=0
    end;
  end;
  except
    raise
  end;  
end;

procedure TDetailsControl.sgDataTopLeftChanged(Sender: TObject);
var
  j0, j:integer;
begin
  try
  j0:=sgData.LeftCol;
  SetHeaderWidth;
  for j:=1 to j0-1 do
    Header.Sections[j].Width:=0;
  except
    raise
  end;
end;

procedure TDetailsControl.SetWarriorPath;
var
  N, j, m, W0, W1,
  ObserverCount, NodeDirection, PathArcKind, OldState,
  WarriorPathStage:integer;
  WarriorPathE, FacilityStateE,  AnalysisVariantE,
  WarriorGroupE, WarriorPathElementE, CriticalPointE:IDMElement;
  WarriorGroup:IWarriorGroup;
  FacilityModelS:IFMState;
  DataModel:IDataModel;
  FacilityModel:IFacilityModel;
  SpatialModel:ISpatialModel;
  WarriorPath:IWarriorPath;
  WarriorPathElement:IWarriorPathElement;
  RefPathElement:IRefPathElement;
  TSum, T, TDisp, dT, dTDisp, dT0, dTDisp0, DetP, NoDetP,
  NoDetPer,
  NoPrelDetP,
  DelayTimeDispersionRatio, PedestrialVelocity, ResponceTime:double;
  PathElementE, BoundaryLayerE, Zone0E, Zone1E, BestTacticE, ElementStateE:IDMElement;
  NoEvidence:WordBool;
  Zone:IZone;
  Boundary:IBoundary;
  Target:ITarget;
  Observers:IDMCollection;
  SafeguardElement:ISafeguardElement;
  PathElement:IPathElement;
  FacilityElement:IFacilityElement;
  Document:IDMDocument;
  OldCurrentLayer:ILayer;
  CurrentPathStage:integer;
  TargetPassed, CriticalPointPassed:boolean;
  FacilityState:IFacilityState;
  S:string;
  AnalysisVariant:IAnalysisVariant;
  BestTimeSum, BestTimeDispSum:double;
  Position:integer;

  procedure SetWarriorPathElement_;
  begin
    WarriorPathElementE.QueryInterface(IWarriorPathElement,WarriorPathElement);

    RefPathElement:=WarriorPathElementE as IRefPathElement;
    PathElementE:=WarriorPathElementE.Ref;
    PathElement:=PathElementE as IPathElement;

    PathArcKind:=RefPathElement.PathArcKind;
    NodeDirection:=RefPathElement.Direction;

    TMPLineE.Ref:=PathElementE;
    TMPC0.X:=RefPathElement.X0;
    TMPC0.Y:=RefPathElement.Y0;
    TMPC0.Z:=RefPathElement.Z0;
    TMPC0E.Ref:=RefPathElement.Ref0;
    TMPC1.X:=RefPathElement.X1;
    TMPC1.Y:=RefPathElement.Y1;
    TMPC1.Z:=RefPathElement.Z1;
    TMPC1E.Ref:=RefPathElement.Ref1;
    FacilityModelS.CurrentLineU:=TMPLineE;
    FacilityModelS.CurrentPathArcKind:=PathArcKind;
    FacilityModelS.CurrentNodeDirection:=NodeDirection;
  end;

  function GetDescription:string;
  begin
    if BestTacticE<>nil then
      Result:=BestTacticE.Name
    else
      Result:='Тактика не определена';
    if TargetPassed then
      Result:=Result+' на выходе'
    else
      Result:=Result+' на входе';
  end;

var
  GuardPost:IGuardPost;
begin
  pAreas.Visible:=False;
  chbTactic.Visible:=False;
  lTactic.Visible:=False;

  W1:=49;
  W0:=(sgData.Width-1-2*(W1+1)) div 2;
  if not FChangingTable then begin
    sgData.Visible:=False;
    sgData.ColWidths[0]:=W0;
    sgData.ColWidths[1]:=W1;
    sgData.ColWidths[2]:=W1;

    Header.Sections[0].Text:=chbTable.Items[chbTable.ItemIndex];
    Header.Sections[1].Text:='T, с';
    Header.Sections[2].Text:='P';
  end;

  WarriorPathE:=IDMElement(FElement);
  WarriorPath:=WarriorPathE as IWarriorPath;

  if chbFacilityState.ItemIndex=-1 then Exit;
  if chbWarriorGroup.ItemIndex=-1 then Exit;
  if chbAnalysisVariant.ItemIndex=-1 then Exit;

  FacilityModelS:=WarriorPathE.DataModel as IFMState;
  if FacilityModelS=nil then Exit;
  FacilityModel:=FacilityModelS as IFacilityModel;
  SpatialModel:=FacilityModel as ISpatialModel;
  DataModel:=FacilityModel as IDataModel;

  AnalysisVariantE:=IDMElement(pointer(chbAnalysisVariant.Items.Objects[chbAnalysisVariant.ItemIndex]));
  AnalysisVariant:=AnalysisVariantE as IAnalysisVariant;
  ResponceTime:=AnalysisVariant.ResponceTime;
  FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[chbFacilityState.ItemIndex]));
  FacilityState:=FacilityStateE as IFacilityState;

  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));
  WarriorGroup:=WarriorGroupE as IWarriorGroup;

  if chbTable.ItemIndex=0 then begin
    chbWarriorPathStage.Visible:=False;
    WarriorPathStage:=-1;
  end else begin
    chbWarriorPathStage.Visible:=True;
    WarriorPathStage:=chbWarriorPathStage.ItemIndex;
    if WarriorPathStage=1 then
      WarriorPathStage:=wpsStelthEntry
    else
    if WarriorPathStage=2 then
      WarriorPathStage:=wpsFastEntry
    else
      WarriorPathStage:=-1;
  end;

  CriticalPointE:=WarriorPath.CriticalPoint;

  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;
  FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
  FacilityModelS.CurrentWarriorGroupU:=WarriorGroupE;
  DelayTimeDispersionRatio:=FacilityModel.DelayTimeDispersionRatio;

  OldCurrentLayer:=SpatialModel.CurrentLayer;
  SpatialModel.CurrentLayer:=nil;

  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfChanging;
  try

  if TMPLine=nil then begin
    TMPLineE:=(SpatialModel.Lines as IDMCollection2).CreateElement(True);
    TMPC0E:=(SpatialModel.CoordNodes as IDMCollection2).CreateElement(True);
    TMPC1E:=(SpatialModel.CoordNodes as IDMCollection2).CreateElement(True);
    TMPLine:=TMPLineE as ILine;;
    TMPC0:=TMPC0E as ICoordNode;
    TMPC1:=TMPC1E as ICoordNode;
    TMPLine.C0:=TMPC0;
    TMPLine.C1:=TMPC1;
  end;
  if BackPathSubState=nil then begin
    BackPathSubStateE:=(FacilityModel.FacilitySubStates as IDMCollection2).CreateElement(True);
    BackPathSubState:=BackPathSubStateE as IFacilitySubState;
  end;

  chbTable.Visible:=True;

  if CriticalPointE<>nil then begin
    CurrentPathStage:=wpsStealthEntry;
    CriticalPointPassed:=False;
  end else begin
    CurrentPathStage:=wpsFastEntry;
    CriticalPointPassed:=True;
  end;
  TargetPassed:=False;
  N:=0;

  case chbTable.ItemIndex of
  0:begin
      sgData.ColCount:=4;
      SetHeaderWidth;
      Header.Sections[3].Text:='';

      N:=0;
      FClearing:=True;
      sgData.RowCount:=1;
      FClearing:=False;

      try
      for j:=0 to WarriorPath.WarriorPathElements.Count-1 do begin
        WarriorPathElementE:=WarriorPath.WarriorPathElements.Item[j];

        SetWarriorPathElement_;

        sgData.Cells[0, N]:=WarriorPathElementE.Name;
        if WarriorPathElement<>nil then begin
          dT:=WarriorPathElement.dT;
          NoDetP:=WarriorPathElement.NoDetP;
          DetP:=1-NoDetP;
          sgData.Cells[1, N]:=Format('%0.1f',[dT]);
          sgData.Cells[2, N]:=Format('%0.4f',[DetP]);
        end else begin
          sgData.Cells[1, N]:='-';
          sgData.Cells[2, N]:='-';
        end;
        case RefPathElement.PathArcKind of
        pakVBoundary_:
          S:=rsVBoundary_;
        pakVBoundary:
          S:=rsVBoundary_;
        pakHZone:
          S:=rsHZone;
        pakHLineObject:
          S:=rsHLineObject;
        pakHBoundary:
          S:=rsHBoundary;
        pakVZone:
          S:=rsVZone;
        pakVLineObject:
          S:=rsVLineObject;
        pakChangeFacilityState:
          S:=rsChangeFacilityState;
        pakChangeWarriorGroup:
          S:=rsChangeWarriorGroup;
        pakRoad:
          S:=rsRoad;
        pakTarget:
          S:=rsTarget;
        pakRZone:
          S:=rsHZone;
        end;

        if (PathElementE<>nil) and
         (PathElementE.QueryInterface(ITarget, Target)=0) then begin
          if (not TargetPassed) and
             (j<WarriorPath.WarriorPathElements.Count-1) then // возврат
          TargetPassed:=True;
        end;

        if WarriorPathElementE=CriticalPointE then begin
          if TargetPassed then
            S:=S+'. Критическая точка обнаружения на выходе'
          else
            S:=S+'. Критическая точка обнаружения на входе';
          CriticalPointPassed:=True;
        end else begin
          if CriticalPointPassed then
            S:=S+'. Быстрое преодоление'
          else
            S:=S+'. Скрытное преодоление';
          if TargetPassed then
            S:=S+' на выходе'
          else
            S:=S+' на входе'
        end;

        sgData.Cells[3, N]:=S;
        inc(N);
        sgData.RowCount:=N;
      end; //for j:=0 to WarriorPath.WarriorPathElements.Count-1
      except
        raise
      end;  
    end;
  1:begin
      FClearing:=True;
      sgData.RowCount:=1;
      FClearing:=False;

      sgData.ColCount:=4;
      SetHeaderWidth;
      Header.Sections[3].Text:='';

      TargetPassed:=False;
      N:=0;
      FClearing:=True;
      sgData.RowCount:=1;
      FClearing:=False;
      try
      for j:=0 to WarriorPath.WarriorPathElements.Count-1 do begin
        WarriorPathElementE:=WarriorPath.WarriorPathElements.Item[j];

        SetWarriorPathElement_;

        TSum:=WarriorPathElement.T;

        if PathElementE=nil then begin
          FacilityModelS.CurrentPathStage:=WarriorPathStage;

          sgData.Cells[0, N]:=WarriorPathElementE.Name;
          if WarriorPathElement<>nil then begin
            dT:=WarriorPathElement.dT;
            NoDetP:=WarriorPathElement.NoDetP;
            DetP:=1-NoDetP;
            sgData.Cells[1, N]:=Format('%0.1f',[dT]);
            sgData.Cells[2, N]:=Format('%0.4f',[DetP]);
          end else begin
            sgData.Cells[1, N]:='-';
            sgData.Cells[2, N]:='-';
          end;
          S:='Движение по дороге';
          if TargetPassed then
            S:=S+' на выходе'
          else
            S:=S+' на входе';

          if WarriorPathElementE=CriticalPointE then begin
            S:=S+'. Критическая точка обнаружения';
            CriticalPointPassed:=True;

            if CurrentPathStage=wpsStealthEntry then
              CurrentPathStage:=wpsFastEntry
            else
            if CurrentPathStage=wpsStealthExit then
              CurrentPathStage:=wpsFastExit;
          end;

          sgData.Cells[3, N]:=S;
          inc(N);
          sgData.RowCount:=N;
        end else
        if PathElementE.QueryInterface(IZone, Zone)=0 then begin
          if WarriorPathStage=-1 then
            FacilityModelS.CurrentPathStage:=CurrentPathStage
          else
            FacilityModelS.CurrentPathStage:=WarriorPathStage;

          PathElement.CalcDelayTime(dT, dTDisp, BestTacticE, 0);
          PathElement.CalcNoDetectionProbability(
              NoDetPer,
              NoPrelDetP,
              NoEvidence,
              BestTimeSum, BestTimeDispSum,
              Position,
               BestTacticE, 0);
          NoDetP:=NoDetPer;
          DetP:=1-NoDetP;
          sgData.Cells[0, N]:=WarriorPathElementE.Name;
          sgData.Cells[1, N]:=Format('%0.1f',[dT]);
          sgData.Cells[2, N]:=Format('%0.4f',[DetP]);
          S:=GetDescription;

          if (WarriorPathElementE=CriticalPointE) and
             not CriticalPointPassed then begin
            if TargetPassed then
              S:=S+'. Критическая точка обнаружения на выходе'
            else
              S:=S+'. Критическая точка обнаружения на входе';
            CriticalPointPassed:=True;

            if CurrentPathStage=wpsStealthEntry then
              CurrentPathStage:=wpsFastEntry
            else
            if CurrentPathStage=wpsStealthExit then
              CurrentPathStage:=wpsFastExit;
          end;

          sgData.Cells[3, N]:=S;
          inc(N);
          sgData.RowCount:=N;
        end else
        if PathElementE.QueryInterface(IBoundary, Boundary)=0 then begin
          if NodeDirection=pdFrom0To1 then begin
            Zone0E:=Boundary.Zone0;
            Zone1E:=Boundary.Zone1;
          end else begin
            Zone1E:=Boundary.Zone0;
            Zone0E:=Boundary.Zone1;
          end;
          Observers:=Boundary.Observers;
          ObserverCount:=0;
          for m:=0 to Observers.Count-1 do begin
            SafeguardElement:=Observers.Item[m] as ISafeguardElement;
            if (SafeguardElement.QueryInterface(IGuardPost, GuardPost)=0) and
                SafeguardElement.IsPresent then
              inc(ObserverCount);
          end;

          if WarriorPathStage=-1 then
            FacilityModelS.CurrentPathStage:=CurrentPathStage
          else
            FacilityModelS.CurrentPathStage:=WarriorPathStage;

          if TMPLine<>nil then begin
           PedestrialVelocity:=5;
           T:=TMPLine.Length/(PedestrialVelocity*100);
           TDisp:=sqr(DelayTimeDispersionRatio*T);
           if Boundary.BoundaryLayers.Count>0 then begin
             dT0:=T/Boundary.BoundaryLayers.Count;
             dTDisp0:=TDisp/Boundary.BoundaryLayers.Count;
           end else begin
             dT0:=T;
             dTDisp0:=TDisp;
           end;
          end else begin
           dT0:=0;
           dTDisp0:=0;
          end;

          if PathElementE.Ref.Parent.ID<>btVirtual then begin // не условная граница
            for m:=0 to Boundary.BoundaryLayers.Count-1 do begin
              BoundaryLayerE:=Boundary.BoundaryLayers.Item[m];
              PathElement:=BoundaryLayerE as IPathElement;

              if WarriorPathStage=-1 then
                FacilityModelS.CurrentPathStage:=CurrentPathStage
              else
                FacilityModelS.CurrentPathStage:=WarriorPathStage;

              PathElement.CalcDelayTime(dT, dTDisp, BestTacticE, 0);
              dT:=dT+dT0;
              dTDisp:=dTDisp+dTDisp0;
              PathElement.CalcNoDetectionProbability(
                NoDetPer,
                NoPrelDetP,
                NoEvidence,
                BestTimeSum, BestTimeDispSum,
                Position,
                BestTacticE, 0);
              NoDetP:=NoDetPer;
              DetP:=1-NoDetP;
              sgData.Cells[0, N]:=BoundaryLayerE.Name;
              sgData.Cells[1, N]:=Format('%0.1f',[dT]);
              sgData.Cells[2, N]:=Format('%0.4f',[DetP]);
              S:=GetDescription;

              if (WarriorPathElementE=CriticalPointE) and
                not CriticalPointPassed then begin
                if  (ResponceTime<TSum) and
                    (ResponceTime>=TSum-dT) then begin
                  if TargetPassed then
                    S:=S+'. Критическая точка обнаружения на выходе'
                  else
                    S:=S+'. Критическая точка обнаружения на входе';
                  CriticalPointPassed:=True;

                  if CurrentPathStage=wpsStealthEntry then
                    CurrentPathStage:=wpsFastEntry
                  else
                  if CurrentPathStage=wpsStealthExit then
                    CurrentPathStage:=wpsFastExit;
                end;
              end;
              TSum:=TSum-dT;

              sgData.Cells[3, N]:=S;
              inc(N);
              sgData.RowCount:=N;

            end;
          end;

          if WarriorPathStage=-1 then
            FacilityModelS.CurrentPathStage:=CurrentPathStage
          else
            FacilityModelS.CurrentPathStage:=WarriorPathStage;

          if (ObserverCount>0) then begin
            Boundary.CalcExternalDelayTime(dT, dTDisp, BestTacticE);
            sgData.Cells[0, N]:='Отход от рубежа '+WarriorPathElementE.Name;
            sgData.Cells[1, N]:=Format('%0.1f',[dT]);
            sgData.Cells[2, N]:=Format('%0.4f',[0]);
            S:=GetDescription;

            if (WarriorPathElementE=CriticalPointE) and
               not CriticalPointPassed then begin
              if  (ResponceTime<TSum) and
                  (ResponceTime>=TSum-dT) then begin
                if TargetPassed then
                  S:=S+'. Критическая точка обнаружения на выходе'
                else
                  S:=S+'. Критическая точка обнаружения на входе';
                CriticalPointPassed:=True;

                if CurrentPathStage=wpsStealthEntry then
                  CurrentPathStage:=wpsFastEntry
                else
                if CurrentPathStage=wpsStealthExit then
                  CurrentPathStage:=wpsFastExit;
              end;
            end;
            TSum:=TSum-dT;

            sgData.Cells[3, N]:=S;
            inc(N);
            sgData.RowCount:=N;
          end;

        end; // if PathElementE.QueryInterface(IBoundary, Boundary)=0
        if (not TargetPassed) and
         (PathElementE<>nil) and
         (PathElementE.QueryInterface(IFacilityElement, FacilityElement)=0) then
          FacilityElement.MakeBackPathElementStates(BackPathSubStateE);
        if (PathElementE<>nil) and
         (PathElementE.QueryInterface(ITarget, Target)=0) then begin
          if (not TargetPassed) and
             (j<WarriorPath.WarriorPathElements.Count-1) then begin // возврат
            TargetPassed:=True;

            if WarriorPathStage=-1 then
              FacilityModelS.CurrentPathStage:=CurrentPathStage
            else
              FacilityModelS.CurrentPathStage:=WarriorPathStage;

            Boundary:=PathElementE as IBoundary;
            Boundary.CalcExternalDelayTime(dT, dTDisp, BestTacticE);

            sgData.Cells[0, N]:='Операции с целевым предметом';
            sgData.Cells[1, N]:=Format('%0.1f',[dT]);
            sgData.Cells[2, N]:=Format('%0.4f',[0]);

            if (WarriorPathElementE=CriticalPointE) and
               not CriticalPointPassed then begin
              if (ResponceTime>=TSum) and
                 (ResponceTime<TSum+dT) then begin
                S:='. Критическая точка обнаружения';
                CriticalPointPassed:=True;

                if CurrentPathStage=wpsStealthEntry then
                  CurrentPathStage:=wpsFastEntry
                else
                if CurrentPathStage=wpsStealthExit then
                  CurrentPathStage:=wpsFastExit;
              end;
            end;

            sgData.Cells[3, N]:=S;
            inc(N);
            sgData.RowCount:=N;

            if CurrentPathStage=wpsStealthEntry then
              CurrentPathStage:=wpsStealthExit
            else
            if CurrentPathStage=wpsFastEntry then
              CurrentPathStage:=wpsFastExit;

            FacilityState.AddSubState(BackPathSubStateE);
            if WarriorPathStage=wpsStelthEntry then
              WarriorPathStage:=wpsStelthExit;
            if WarriorPathStage=wpsFastEntry then
              WarriorPathStage:=wpsFastExit;
            FacilityModelS.CurrentPathStage:=WarriorPathStage;
          end;
        end;

      end; // for j:=0 to WarriorPath.WarriorPathElements.Count-1
      finally
        FacilityState.RemoveSubState(BackPathSubStateE);
        while BackPathSubState.ElementStates.Count>0 do begin
          ElementStateE:=BackPathSubState.ElementStates.Item[0];
          ElementStateE.Clear;
        end;
      end;
    end;
  end;  // case chbTable.ItemIndex
  sgData.Visible:=N>0;

  finally
    SpatialModel.CurrentLayer:=OldCurrentLayer;
    Document.State:=OldState;
  end;
end;

procedure TDetailsControl.SetHeaderWidth;
var
  j, N:integer;
begin
  N:=sgData.ColCount;
  while Header.Sections.Count<N do
    Header.Sections.Add;
  while Header.Sections.Count>N do
    Header.Sections.Delete(N);
  for j:=0 to sgData.ColCount-1 do
    Header.Sections[j].Width:=sgData.ColWidths[j]+1;
end;

procedure TDetailsControl.SetNodeDirection(WarriorPathStage:integer;
                           const Zone0, Zone1: IZone;
                           const WarriorGroup: IWarriorGroup);
var
  FinishPointE, Zone1E:IDMElement;
  FinishNode:ICoordNode;
  Volume1:IVolume;
  X, Y, Z:double;
begin
  case WarriorPathStage of
  wpsStealthExit,
  wpsFastExit:
    begin
      FDirectPath:=False;
      if Zone0=nil then
        FNodeDirection:=pdFrom1To0
      else
      if Zone1=nil then
        FNodeDirection:=pdFrom0To1
      else
      if Zone0.Category<=Zone1.Category then
        FNodeDirection:=pdFrom1To0
      else
        FNodeDirection:=pdFrom0To1;
    end;
  else
    begin
      FDirectPath:=True;
      if Zone0=nil then
        FNodeDirection:=pdFrom0To1
      else
      if Zone1=nil then
        FNodeDirection:=pdFrom1To0
      else
      if Zone0.Category<Zone1.Category then
        FNodeDirection:=pdFrom0To1
      else
      if Zone0.Category>Zone1.Category then
        FNodeDirection:=pdFrom1To0
      else begin// if Zone0.Category=Zone1.Category then begin
        FinishPointE:=WarriorGroup.FinishPoint;
        if FinishPointE=nil then
          FNodeDirection:=pdFrom1To0
        else  
        if FinishPointE.SpatialElement=nil then
          FNodeDirection:=pdFrom1To0
        else begin
          FinishNode:=FinishPointE.SpatialElement as ICoordNode;
          X:=FinishNode.X;
          Y:=FinishNode.Y;
          Z:=FinishNode.Z;
          Zone1E:=Zone1 as IDMElement;
          Volume1:=Zone1E.SpatialElement as IVolume;
          if Volume1.ContainsPoint(X, Y, Z) then
            FNodeDirection:=pdFrom0To1
          else
            FNodeDirection:=pdFrom1To0
        end;
      end;
    end;
  end;
end;

procedure TDetailsControl.OpenDocument;
var
  aDataModel:IDataModel;
  j:integer;
  FacilityModel:IFacilityModel;
  FacilityModels:IFMState;
  AnalysisVariantE, FacilityStateE, CurrentElement:IDMElement;
  Document:IDMDocument;
begin
  Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  aDataModel:=GetDataModel;
  if aDataModel=nil then Exit;
  FacilityModel:=aDataModel as IFacilityModel;
  FacilityModels:=aDataModel as IFMState;

  chbAnalysisVariant.Clear;
  for j:=0 to FacilityModel.AnalysisVariants.Count-1 do begin
    AnalysisVariantE:=FacilityModel.AnalysisVariants.Item[j];
    chbAnalysisVariant.Items.AddObject(AnalysisVariantE.Name, pointer(AnalysisVariantE));
  end;

  chbFacilityState.Clear;
  for j:=0 to FacilityModel.FacilityStates.Count-1 do begin
    FacilityStateE:=FacilityModel.FacilityStates.Item[j];
    chbFacilityState.Items.AddObject(FacilityStateE.Name, pointer(FacilityStateE));
  end;

  if FacilityModel.AnalysisVariants.Count>0 then begin
    AnalysisVariantE:=FacilityModels.CurrentAnalysisVariantU as IDMElement;
    j:=FacilityModel.AnalysisVariants.IndexOf(AnalysisVariantE);
    if j=-1 then begin
      AnalysisVariantE:=FacilityModel.AnalysisVariants.Item[0];
      FacilityModels.CurrentAnalysisVariantU:=AnalysisVariantE;
      chbAnalysisVariant.ItemIndex:=0;
    end else
      chbAnalysisVariant.ItemIndex:=j;
  end else
    chbAnalysisVariant.ItemIndex:=-1;

  chbAnalysisVariantChange(chbAnalysisVariant);

  if chbAnalysisVariant.ItemIndex<>-1 then begin
    CurrentElement:=Document.CurrentElement as IDMElement;
    SetCurrentElement(CurrentElement);
  end;

end;

procedure TDetailsControl.SetWarriorGroups;
var
  AnalysisVariantE, WarriorGroupE:IDMElement;
  AnalysisVariant:IAnalysisVariant;
  FacilityModel:IFacilityModel;
  aDataModel:IDataModel;
  FacilityModels:IFMState;
  AdversaryVariant:IAdversaryVariant;
  GuardVariant:IGuardVariant;
  j:integer;
begin
  aDataModel:=GetDataModel;
  if aDataModel=nil then Exit;
  FacilityModel:=aDataModel as IFacilityModel;
  FacilityModels:=aDataModel as IFMState;
  AnalysisVariantE:=FacilityModels.CurrentAnalysisVariantU as IDMElement;
  AnalysisVariant:=AnalysisVariantE as IAnalysisVariant;

  chbWarriorGroup.Clear;
  if AnalysisVariant<>nil then begin
    AdversaryVariant:=AnalysisVariant.AdversaryVariant as IAdversaryVariant;
    GuardVariant:=AnalysisVariant.GuardVariant as IGuardVariant;

    for j:=0 to AdversaryVariant.AdversaryGroups.Count-1 do begin
      WarriorGroupE:=AdversaryVariant.AdversaryGroups.Item[j];
      chbWarriorGroup.Items.AddObject(WarriorGroupE.Name,
                                    pointer(WarriorGroupE));
    end;
    for j:=0 to GuardVariant.GuardGroups.Count-1 do begin
      WarriorGroupE:=GuardVariant.GuardGroups.Item[j];
      chbWarriorGroup.Items.AddObject(WarriorGroupE.Name,
                                    pointer(WarriorGroupE));
    end;

    chbWarriorGroup.ItemIndex:=chbWarriorGroup.Items.IndexOfObject(pointer(AnalysisVariant.MainGroup as IDMElement));

  end;
end;

procedure TDetailsControl.chbAnalysisVariantChange(Sender: TObject);
var
  AnalysisVariantE:IDMElement;
  AnalysisVariant:IAnalysisVariant;
  j:integer;
  FacilityModelS:IFMState;
begin
  j:=chbAnalysisVariant.ItemIndex;
  if j=-1 then Exit;
  AnalysisVariantE:=IDMElement(pointer(chbAnalysisVariant.Items.Objects[j]));
  AnalysisVariant:=AnalysisVariantE as IAnalysisVariant;

  FacilityModelS:=AnalysisVariantE.DataModel as IFMState;
  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;

  chbFacilityState.ItemIndex:=chbFacilityState.Items.IndexOfObject(pointer(AnalysisVariant.FacilityState));

  SetWarriorGroups;
  
  chbChange(nil)
end;

procedure TDetailsControl.SetAnalysisVariant;
var
  FacilityStateE, AdversaryGroupE:IDMElement;
  AdversaryGroup:IWarriorGroup;
  AnalysisVariant:IAnalysisVariant;
  j:integer;
begin
  j:=chbFacilityState.ItemIndex;
  FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[j]));
  j:=chbWarriorGroup.ItemIndex;
  AdversaryGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[j]));
  AdversaryGroupE.QueryInterface(IWarriorGroup, AdversaryGroup);

  j:=0;
  while j<chbAnalysisVariant.Items.Count do begin
    AnalysisVariant:=IDMElement(pointer(chbAnalysisVariant.Items.Objects[j])) as IAnalysisVariant;
    if (AnalysisVariant.FacilityState=FacilityStateE) and
       ((AnalysisVariant.MainGroup=AdversaryGroup) or
        (AdversaryGroup=nil)) then
      Break
    else
      inc(j);
  end;
  if j<chbAnalysisVariant.Items.Count then
    chbAnalysisVariant.ItemIndex:=j
  else
    chbAnalysisVariant.ItemIndex:=-1;
end;

procedure TDetailsControl.chbFacilityStateChange(Sender: TObject);
begin
  SetAnalysisVariant;

//  FChangingTable:=True;
  chbChange(nil);
//  FChangingTable:=False;
end;

procedure TDetailsControl.UpdateDocument;
begin
  OpenDocument
end;

procedure TDetailsControl.SetWarriorPathElement;
var
  WarriorPathElementE, AreaE, SafeguardElementE, aElement,
  FromElement, ToElement, JumpE, LineE:IDMElement;
  WarriorPathElement:IWarriorPathElement;
  RefPathElement:IRefPathElement;
  X0, Y0, Z0, X1, Y1, Z1, X, Y, Z:double;
  Zone:IZone;
  Volume:IVolume;
  Area:IArea;
  j, m:integer;
  D0min, D0, D1min, D1:double;
  Unk:IUnknown;
  ZoneSU:ISafeguardUnit;
  C:ICoordNode;
  Jump:IJump;
  Line:ILine;
  WarriorPath:IWarriorPath;
  NextZone, PrevZone:IZone;
  aRef:IDMElement;
  FacilityModelS:IFMState;
begin
  WarriorPathElementE:=IDMElement(FElement);
  WarriorPathElement:=WarriorPathElementE as IWarriorPathElement;
  RefPathElement:=WarriorPathElementE as IRefPathElement;
  Unk:=WarriorPathElementE.Ref;
  if WarriorPathElementE.Ref.QueryInterface(IZone, Zone)=0 then begin
    X0:=RefPathElement.X0;
    Y0:=RefPathElement.Y0;
    Z0:=RefPathElement.Z0;
    X1:=RefPathElement.X1;
    Y1:=RefPathElement.Y1;
    Z1:=RefPathElement.Z1;
    Volume:=(Zone as IDMElement).SpatialElement as IVolume;
    if Volume<>nil then begin
      D0min:=1000000000;
      D1min:=1000000000;
      FromElement:=nil;
      ToElement:=nil;

      ZoneSU:=Zone as ISafeguardUnit;
      for j:=0 to ZoneSU.SafeguardElements.Count-1 do begin
        SafeguardElementE:=ZoneSU.SafeguardElements.Item[j];
        if (SafeguardElementE.QueryInterface(ITarget, Unk)=0) or
           (SafeguardElementE.QueryInterface(IStartPoint, Unk)=0) or
           (SafeguardElementE.QueryInterface(IControlDevice, Unk)=0) or
           (SafeguardElementE.QueryInterface(IGuardPost, Unk)=0) then begin
          aElement:=SafeguardElementE.SpatialElement;
          if aElement.QueryInterface(ICoordNode, C)<>0 then
            C:=(aElement as ILine).C0;
          X:=C.X;
          Y:=C.Y;
          Z:=C.Z;
          D0:=sqrt(sqr(X-X0)+sqr(Y-Y0)+sqr(Z-Z0));
          D1:=sqrt(sqr(X-X1)+sqr(Y-Y1)+sqr(Z-Z1));
          if D0Min>D0 then begin
            D0Min:=D0;
            FromElement:=aElement
          end;
          if D1Min>D1 then begin
            D1Min:=D1;
            ToElement:=aElement
          end;
        end;
      end;

      for j:=0 to Zone.Jumps.Count-1 do begin
        JumpE:=Zone.Jumps.Item[j];
        Jump:=JumpE as IJump;
        LineE:=JumpE.SpatialElement;
        Line:=LineE as ILine;
        if Jump.Zone0=Zone as IDMElement then
          C:=Line.C0
        else
          C:=Line.C1;
        X:=C.X;
        Y:=C.Y;
        Z:=C.Z;
        D0:=sqrt(sqr(X-X0)+sqr(Y-Y0)+sqr(Z-Z0));
        D1:=sqrt(sqr(X-X1)+sqr(Y-Y1)+sqr(Z-Z1));
        if D0Min>D0 then begin
          D0Min:=D0;
          FromElement:=LineE
        end;
        if D1Min>D1 then begin
          D1Min:=D1;
          ToElement:=LineE
        end;
      end;

      for j:=0 to Volume.Areas.Count-1 do begin
        AreaE:=Volume.Areas.Item[j];
        Area:=AreaE as IArea;
        if Area.IsVertical then begin
          D0:=Area.GetDistanceFrom(X0, Y0, Z0);
          D1:=Area.GetDistanceFrom(X1, Y1, Z1);
          if D0Min>D0 then begin
            D0Min:=D0;
            FromElement:=AreaE
          end;
          if D1Min>D1 then begin
            D1Min:=D1;
            ToElement:=AreaE;
          end;
        end;
      end;

      for j:=0 to Volume.Areas.Count-1 do begin
        AreaE:=Volume.Areas.Item[j];
        Area:=AreaE as IArea;
        if not Area.IsVertical then begin
          D0:=Area.GetDistanceFrom(X0, Y0, Z0);
          D1:=Area.GetDistanceFrom(X1, Y1, Z1);
          if D0Min>D0 then begin
            D0Min:=D0;
            FromElement:=AreaE
          end;
          if D1Min>D1 then begin
            D1Min:=D1;
            ToElement:=AreaE;
          end;
        end;
      end;

    end;
  end else begin
    WarriorPath:=WarriorPathElementE.Parent as IWarriorPath;
    j:=WarriorPath.WarriorPathElements.IndexOf(WarriorPathElementE);
    NextZone:=nil;
    m:=j+1;
    while m<WarriorPath.WarriorPathElements.Count do begin
      aRef:=WarriorPath.WarriorPathElements.Item[m].Ref;
      if aRef.QueryInterface(IZone, NextZone)=0 then
        break
      else
        inc(m);
    end;
    PrevZone:=nil;
    m:=j-1;
    while m>-1 do begin
      aRef:=WarriorPath.WarriorPathElements.Item[m].Ref;
      if aRef.QueryInterface(IZone, PrevZone)=0 then
        break
      else
        dec(m);
    end;
    FacilityModelS:=WarriorPathElementE.DataModel as IFMState;
    FacilityModelS.CurrentZone0U:=NextZone;
    FacilityModelS.CurrentZone1U:=PrevZone;
  end;

  SetCurrentElement(Unk);

  cbFrom.ItemIndex:=cbFrom.Items.IndexOfObject(pointer(FromElement));
  cbTo.ItemIndex:=cbTo.Items.IndexOfObject(pointer(ToElement));
end;

procedure TDetailsControl.DocumentOperation(ElementsV,
  CollectionV: OleVariant; DMOperation, nItemIndex: Integer);
var
  Unk:IUnknown;
  aElement:IDMElement;
  aCollection:IDMCollection;
begin
  case DMOperation of
  leoAdd, leoRename:
    begin
      Unk:=ElementsV;
      if (Unk<>nil) and
         (Unk.QueryInterface(IDMElement, aElement)=0) then
        case aElement.ClassID of
        _AnalysisVariant,
        _AdversaryGroup,
        _GuardGroup,
        _FacilityState:
          OpenDocument;
        end;
    end;
  leoDelete:
    begin
      Unk:=CollectionV;
      if (Unk<>nil) and
         (Unk.QueryInterface(IDMCollection, aCollection)=0) then
        case aCollection.ClassID of
        _AnalysisVariant,
        _AdversaryGroup,
        _GuardGroup,
        _FacilityState:
         OpenDocument;
        end;
    end;
  end;
end;

procedure TDetailsControl.BuildTableFromReport(const Report: IDMText);

  function ExtractCell(out S0:string; var S:string):boolean;
  var
    i:integer;
  begin
    if S[1]='|' then begin
      S:=Copy(S, 2, Length(S)-1);
      i:=Pos('|', S);
      if i=0 then
        S0:=(S)
      else begin
        S0:=Copy(S, 1, i-1);
        S:= Copy(S, i, Length(S)-i+1);
      end;
      Result:=True;
    end else
      Result:=False
  end;
var
  j, m, N, W, TextWidth:integer;
  S0, S:string;
  HeaderBuild:boolean;
  StringList:TStringList;
  HeaderSection:THeaderSection;
begin
  StringList:=TStringList.Create;
  HeaderBuild:=False;
  sgData.RowCount:=1;
  sgData.Cells[0, 0]:='?';
  N:=0;
  try
  for j:=0 to Report.LineCount-1 do begin
    S:=Report.Line[j];
    if length(S)=0 then
      Continue;
    if S[1]<>'|' then
      Continue;
    if S[2] in ['-', '_'] then
      Continue;
    StringList.Clear;
    while ExtractCell(S0, S) do
      StringList.Add(S0);
    if not HeaderBuild then begin

      sgData.ColCount:=StringList.Count;
      Header.Sections.Clear;
      for m:=0 to StringList.Count-1 do begin
        HeaderSection:=Header.Sections.Add;
        HeaderSection.Text:=StringList[m];
        TextWidth:=Canvas.TextWidth(StringList[m])+20;
        if TextWidth>round(0.8*sgData.Width) then
          TextWidth:=round(0.8*sgData.Width);
        HeaderSection.Width:=TextWidth;
        sgData.Cells[m, 0]:=' ';
      end;
      sgData.ColCount:=Header.Sections.Count;
      HeaderBuild:=True;
    end else begin
      inc(N);
      sgData.RowCount:=N;
      for m:=0 to StringList.Count-1 do begin
        W:=Canvas.TextWidth(StringList[m])+20;
        if W>round(0.8*sgData.Width) then
          W:=round(0.8*sgData.Width);
        HeaderSection:=Header.Sections[m];
        if HeaderSection.Width<W then
          HeaderSection.Width:=W;
        sgData.Cells[m, N-1]:=StringList[m];
      end;
    end;
  end;
  except
    raise
  end;  
  for m:=0 to Header.Sections.Count-1 do begin
    HeaderSection:=Header.Sections[m];
    sgData.ColWidths[m]:=HeaderSection.Width-1;
  end;

  StringList.Free;
end;
procedure TDetailsControl.sgDataExit(Sender: TObject);
begin
  mComment.Visible:=False
end;

procedure TDetailsControl.sgDataSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  SafeguardElementE:IDMELement;
  SafeguardElement:ISafeguardElement;
  OvercomeMethod:IOvercomeMethod;
  T, DetP, P0, Pf, WorkP:double;
  S, SS, SSS, Som, Sse, Swg, Sfs, Sbo:string;
  SafeguardElementS:IElementState;
  SafeguardElementKindE, SafeguardElementTypeE, TacticE,
  AnalysisVariantE, FacilityStateE, WarriorGroupE,
  Zone0E, Zone1E, LineE, OvercomeMethodE:IDMElement;
  SafeguardElementType:ISafeguardElementType;
  Tactic:ITactic;
  WarriorGroup:IWarriorGroup;
  FacilityModelS:IFMState;
  Boundary:IBoundary;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerType:IBoundaryLayerType;
  Jump:IJump;
  Zone0, Zone1:IZone;
  WarriorPathStage, OldState, N, j, Indx:integer;
  DMDocument:IDMDocument;
  DMArray:IDMArray;
  DimensionE, DimItemE:IDMElement;
  Dimension:IDMArrayDimension;
  DimensionM:IMethodDimension;
begin
  if FClearing then Exit;
  
  SafeguardElementE:=IDMElement(FElement);
  if SafeguardElementE=nil then Exit;
  if SafeguardElementE.QueryInterface(ISafeguardElement, SafeguardElement)<>0 then Exit;
  Sse:='"'+SafeguardElementE.Name+'"';


  SafeguardElementS:=SafeguardElementE as IElementState;
  SafeguardElementKindE:=SafeguardElementE.Ref;
  SafeguardElementTypeE:=SafeguardElementKindE.Parent;
  SafeguardElementType:=SafeguardElementTypeE as ISafeguardElementType;
  TacticE:=IDMElement(pointer(chbTactic.Items.Objects[chbTactic.ItemIndex]));
  Tactic:=TacticE as ITactic;
  AnalysisVariantE:=IDMElement(pointer(chbAnalysisVariant.Items.Objects[chbAnalysisVariant.ItemIndex]));
  FacilityStateE:=IDMElement(pointer(chbFacilityState.Items.Objects[chbFacilityState.ItemIndex]));
  Sfs:='"'+FacilityStateE.Name+'"';
  WarriorGroupE:=IDMElement(pointer(chbWarriorGroup.Items.Objects[chbWarriorGroup.ItemIndex]));
  Swg:='"'+WarriorGroupE.Name+'"';
  WarriorGroup:=WarriorGroupE as IWarriorGroup;
  FacilityModelS:=SafeguardElementE.DataModel as IFMState;

  Boundary:=nil;
  Jump:=nil;
  Sbo:='';
  if (SafeguardElementE.Parent<>nil) and
    (SafeguardElementE.Parent.ClassID=_BoundaryLayer) then begin
    BoundaryLayer:=SafeguardElementE.Parent as IBoundaryLayer;
    BoundaryLayerType:=SafeguardElementE.Parent.Ref as IBoundaryLayerType;
    Boundary:=SafeguardElementE.Parent.Parent as IBoundary;
    Sbo:='"'+(Boundary as IDMElement).Name+'"';
    Zone0E:=Boundary.Get_Zone0;
    Zone1E:=Boundary.Get_Zone1;
  end else begin
    Zone0E:=nil;
    Zone1E:=nil;
    BoundaryLayer:=nil;
    BoundaryLayerType:=nil;
  end;
  Zone0:=Zone0E as IZone;
  Zone1:=Zone1E as IZone;

  WarriorPathStage:=chbWarriorPathStage.ItemIndex;
  SetNodeDirection(WarriorPathStage, Zone0, Zone1, WarriorGroup);

  DMDocument:=SafeguardElementE.DataModel.Document as IDMDocument;
  OldState:=DMDocument.State;
  DMDocument.State:=DMDocument.State or dmfCommiting;
  try
  if Boundary<>nil then
    LineE:=Boundary.MakeTemporyPath
  else
  if Jump<>nil then
    LineE:=(Jump as IDMElement).SpatialElement
  else
    LineE:=nil;
  finally
    DMDocument.State:=OldState;
  end;

  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;
  FacilityModelS.CurrentFacilityStateU:=FacilityStateE;
  FacilityModelS.CurrentWarriorGroupU:=WarriorGroupE;
  FacilityModelS.CurrentZone0U:=Zone0E;
  FacilityModelS.CurrentZone1U:=Zone1E;
  FacilityModelS.CurrentLineU:=LineE;
  FacilityModelS.CurrentDirectPathFlag:=FDirectPath;
  FacilityModelS.CurrentNodeDirection:=FNodeDirection;
  FacilityModelS.CurrentPathStage:=WarriorPathStage;
  FacilityModelS.TotalBackPathDelayTime:=0;
  FacilityModelS.TotalBackPathDelayTimeDispersion:=0;

  if (SafeguardElementE.Parent<>nil) and
     (SafeguardElementE.Parent.ClassID=_BoundaryLayer) then
    FacilityModelS.CurrentPathArcKind:=pakVBoundary
  else
    FacilityModelS.CurrentPathArcKind:=pakHZone;
  FacilityModelS.CurrentTacticU:=TacticE;

  if Zone0<>nil then
    Zone0.CalcPatrolPeriod;
  if Zone1<>nil then
    Zone1.CalcPatrolPeriod;


  case chbTable.ItemIndex of
  0:begin
      OvercomeMethod:=IOvercomeMethod(pointer(sgData.Objects[0, ARow]));
      OvercomeMethodE:=OvercomeMethod as IDMElement;
      Som:='"'+OvercomeMethodE.Name+'"';
      mComment.Visible:=True;
      case ACol of
      1:begin
          if SafeguardElementType.CanDelay then begin
            T:=SafeguardElement.DoCalcDelayTime(OvercomeMethodE);
            SS:='Время задержки группы нарушителей '+Swg+
                ' при преодолении ими элемента системы охраны '+Sse+
                ' способом '+Som;
            if T<1000000 then begin
              SSS:=SS+' составляет '+Format('%0.0f сек.',[T]);
            end else begin
              SSS:=SS+' бесконечно велико';
            end;
          end else begin
            SSS:=SS+' не определено'
          end;
          mComment.Text:=SSS;

          case OvercomeMethod.DelayProcCode of
          LongInt(dpcCodeMatrix),
          LongInt(dpcMatrix):
            begin
              DMArray:=OvercomeMethod as IDMArray;
              if DMArray.Dimensions.Count=0 then
                SSS:='Ошибка!!!'
              else
              if DMArray.Dimensions.Count=1 then
                SSS:='    Данный результат обусловлен выполнением следующего условия:'
              else
                SSS:='    Данный результат обусловлен совпадением следующих условий:';
              mComment.Lines.Add(SSS);
              for j:=0 to DMArray.Dimensions.Count-1 do begin
                DimensionE:=DMArray.Dimensions.Item[j];
                Dimension:=DimensionE as IDMArrayDimension;
                DimensionM:=DimensionE as  IMethodDimension;
                Indx:=DimensionM.CurrentValueIndex;
                if (Indx<>-1) and
                   (DimensionM.SourceKind<>skMethod) then begin
                  DimItemE:=Dimension.DimItems.Item[Indx];
                  SSS:='"'+DimensionE.Name+'" - "'+
                                   DimItemE.Name+'"' ;
                  mComment.Lines.Add(SSS);
                end;
              end;
            end;
          LongInt(dpcExternal):
            begin
              SSS:='    Данный результат получен с использованием'+
                   ' внешней процедуры';
              mComment.Lines.Add(SSS);
            end;
          dpcZero:
            begin
              SSS:='    При данном способе преодоления элемента системы охраны'+
                   ' дополнительной задержки нарушителей не происходит';
              mComment.Lines.Add(SSS);
            end;
          dpcInfinit:
            begin
              SSS:='    Данный вариант реализуется, когда нарушитель'+
                   ' не может успешно применить никакой другой'+
                   ' способ преодоления элемента системы охраны';
              mComment.Lines.Add(SSS);
            end;
          dpcVelocityCodeMatrix,
          dpcVelocityMatrix:
            if LineE<>nil then begin
              S:=Format('%0.2f м',[(LineE as ILine).Length/100]);
              DMArray:=OvercomeMethod as IDMArray;
              if DMArray.Dimensions.Count=0 then
                SSS:='Ошибка!!!'
              else
              if DMArray.Dimensions.Count=1 then
                SSS:='    Данный результат получен для участка маршрута длиной '+S+
                     ' и обусловлен выполнением следующего условия:'
              else
                SSS:='    Данный результат получен для участка маршрута длиной '+S+
                     ' и обусловлен совпадением следующих условий:';
              mComment.Lines.Add(SSS);
              for j:=0 to DMArray.Dimensions.Count-1 do begin
                DimensionE:=DMArray.Dimensions.Item[j];
                Dimension:=DimensionE as IDMArrayDimension;
                DimensionM:=DimensionE as  IMethodDimension;
                Indx:=DimensionM.CurrentValueIndex;
                if (Indx<>-1) and
                   (DimensionM.SourceKind<>skMethod) then begin
                  DimItemE:=Dimension.DimItems.Item[Indx];
                  SSS:='"'+DimensionE.Name+'" - "'+
                                   DimItemE.Name+'"' ;
                  mComment.Lines.Add(SSS);
                end;
              end;
            end;
          dpcEc,
          dpcCriminalEc:
            begin
              SSS:='    Данный результат получен на основе данных о стойкости'+
                   ' элемента системы охраны ко взлому';
              mComment.Lines.Add(SSS);
            end;
          dpcUseKey:
            begin
            end;
          end;

        end;
      2..8:
        begin
          T:=SafeguardElement.DoCalcDelayTime(OvercomeMethodE);
          if T<1000000 then begin
            DetP:=SafeguardElement.DoCalcDetectionProbability(TacticE,
                          OvercomeMethodE,
                          T, P0, Pf, WorkP, True);
            SS:='обнаружения группы нарушителей '+Swg+
                ' при преодолении ими элемента системы охраны '+Sse+
                ' способом '+Som;
            case ACol of
            2:begin
                SSS:='Полная вероятность '+SS+
                     ' составляет '+Format('%0.4f',[DetP]);
                mComment.Text:=SSS;
              end;
            3:begin
                SSS:='Вероятность '+SS+
                     ', обусловленная непосредственным действием этого элемента,'+
                     ' составляет '+Format('%0.4f',[P0]);
                mComment.Text:=SSS;
                case OvercomeMethod.ProbabilityProcCode of
                LongInt(ppcMatrix):
                  begin
                    DMArray:=OvercomeMethod as IDMArray;
                    if DMArray.Dimensions.Count=0 then
                      SSS:='Ошибка!!!'
                    else
                    if DMArray.Dimensions.Count=1 then
                      SSS:='    Данный результат обусловлен выполнением следующего условия:'
                    else
                      SSS:='    Данный результат обусловлен совпадением следующих условий:';
                    mComment.Lines.Add(SSS);
                    for j:=0 to DMArray.Dimensions.Count-1 do begin
                      DimensionE:=DMArray.Dimensions.Item[j];
                      Dimension:=DimensionE as IDMArrayDimension;
                      DimensionM:=DimensionE as  IMethodDimension;
                      Indx:=DimensionM.CurrentValueIndex;
                      if (Indx<>-1) and
                         (DimensionM.SourceKind<>skMethod) then begin
                        DimItemE:=Dimension.DimItems.Item[Indx];
                        SSS:='"'+DimensionE.Name+'" - "'+
                                         DimItemE.Name+'"' ;
                        mComment.Lines.Add(SSS);
                      end;
                    end;
                  end;
                LongInt(ppcExternal):
                  begin
                    SSS:='    Данный результат получен с использованием'+
                         ' внешней процедуры';
                     mComment.Lines.Add(SSS);
                  end;
                ppcZero:
                  begin
                    SSS:='    Это обусловлено тем, что данный способ преодоления'+
                         ' элемента системы охраны не может быть обнаружен самим элементом';
                     mComment.Lines.Add(SSS);
                  end;
                ppcOne:
                  begin
                    SSS:='    Данный вариант реализуется, когда нарушитель'+
                         ' не может успешно применить никакой другой'+
                         ' способ преодоления элемента системы охраны';
                     mComment.Lines.Add(SSS);
                  end;
                ppcStandard:
                  begin
                    SSS:='    Данный результат обусловлен обнаружительной способностью'+
                         ' элемента системы охраны при стандартных условиях';
                     mComment.Lines.Add(SSS);
                  end;
                end;
              end;
            4:begin
                if OvercomeMethod.PhysicalFields.Count>0 then begin
                  if OvercomeMethod.PhysicalFieldValue[0]>=0 then
                    SSS:='Вероятность '+SS+
                         ', обусловленная шумом, сопровождающим этот способ преодоления,'+
                         ' составляет '+Format('%0.4f',[Pf])
                  else
                    SSS:='Шум, сопровождающий преодоление элемента системы охраны '+Sse+
                         ' способом '+Som+
                         ', полностью затухает в точке находждения ближайшего наблюдателя.'
                end else
                  SSS:='Преодоление элемента системы охраны '+Sse+
                         ' способом "'+Som+
                         ' не сопровождаетя шумом';
                mComment.Text:=SSS;
              end;
            5:begin
                if Boundary<>nil then
                  N:=Boundary.Observers.Count
                else
                  N:=0;
                if SafeguardElementE.ClassID=_GuardPost then begin
                  dec(N);
                  S:=' других';
                end else
                  S:='';
                if N>0 then begin
                  if N=1 then
                    S:=Format('%d поста', [N])
                  else
                    S:=Format('%d постов', [N]);
                  SSS:='Рубеж '+Sbo+
                       ', на котором расположен элемент системы охраны '+Sse+
                       ' попадает в поле зрение '+S+
                       ' охраны, что обусловливает его визуальное обнаружение'+
                       ' с вероятностью '+Format('%0.4f',[0])+
                       ' при преодолении этого элемента за время '+Format('%0.0f сек.',[T])+
                       ' способом '+Som;
                end else
                  SSS:='Рубеж '+Sbo+
                       ', на котором расположен элемент системы охраны '+Sse+
                       ', не попадает в поле зрения'+S+' постов охраны';
                mComment.Text:=SSS;
              end;
            6:begin
                mComment.Text:='';
              end;
            7:begin
                SSS:='Вероятность '+SS+
                     ', обуслов-ленная патрулированием территории и/или'+
                     ' присутствием персонала, составляет '+Format('%0.4f',[0])+
                     ' при преодолении этого элемента за время '+Format('%0.0f сек.',[T])+
                     ' способом '+Som;
                mComment.Text:=SSS;
              end;
            8:begin
                SSS:='Вероятность работоспособности элемент системы охраны '+Sse+
                    ' в момент соверщения акции нарушителей'+
                    ' составляет '+Format('%0.4f',[WorkP]);
                mComment.Text:=SSS;
              end;
            end;
          end else begin    // if (T>=1000000)
            SSS:='Поскольку время задержки группы нарушителей '+Swg+
                ' при преодолении ими элемента системы охраны '+Sse+
                ' способом '+Som+
                ' очень велико - данный способ считается неприменимым';
            mComment.Text:=SSS;
          end;
        end;
      else
        mComment.Text:='';
      end;
    end;
  else
  end;
end;

initialization
finalization
  TMPLine:=nil;
  TMPC0:=nil;
  TMPC1:=nil;
  TMPLineE:=nil;
  TMPC0E:=nil;
  TMPC1E:=nil;
  BackPathSubState:=nil;
  BackPathSubStateE:=nil;
end.
