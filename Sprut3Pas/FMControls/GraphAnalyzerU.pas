unit GraphAnalyzerU;
//___________________________________вариант  Volkov_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls,
  Types, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU,
  SpatialModelLib_TLB, FacilityModelLib_TLB, SafeguardAnalyzerLib_TLB, PainterLib_TLB;

const
  admGet_DelayTime=0;
  admGet_NoDetectionProbability=1;
  admGet_SuccessProbability=2;

type

  TGraphAnalyzer = class(TDMPage)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Splitter2: TSplitter;
    Panel3: TPanel;
    Panel4: TPanel;
    lbArcs: TListBox;
    Panel5: TPanel;
    Panel6: TPanel;
    lbInArcs: TListBox;
    lbOutArcs: TListBox;
    btNext: TButton;
    btPrev: TButton;
    lElement: TLabel;
    rgGraphType: TRadioGroup;
    lInV: TLabel;
    lOutV: TLabel;
    Splitter3: TSplitter;
    lbHistory: TListBox;
    lRecalcInV: TLabel;
    lRecalcOutV: TLabel;
    lRecalcV: TLabel;
    lPathGraph: TLabel;
    procedure lbArcsClick(Sender: TObject);
    procedure rgGraphTypeClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure btPrevClick(Sender: TObject);
    procedure lbExtArcsClick(Sender: TObject);
    procedure lbInArcsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbHistoryClick(Sender: TObject);
  private
    FControlIndex:integer;
    FPathArcE:IDMElement;
    FLastShownPathArcE:IDMElement;
    FBestInPathArc:IDMElement;
    FBestOutPathArc:IDMElement;
    FCInE:IDMElement;
    FCOutE:IDMElement;
    procedure SetFacilityElement(const Element: IDMElement);
    procedure AddPathArc(const PathArcE: IDMElement;
                         j:integer; var BestJ:integer; var BestV:double);
    procedure SetPathArc(const aPathArcE: IDMElement);
    procedure MakeInOutArcsList;
    function DoSetPathArc(const aPathArcE: IDMElement): integer;
  protected
    procedure OpenDocument; override; safecall;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

{$R *.DFM}

{ TDMChartX }


procedure TGraphAnalyzer.Initialize;
begin
  inherited Initialize;
  FControlIndex:=1;
  DecimalSeparator:='.';
end;

procedure TGraphAnalyzer.OpenDocument;
var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
begin
  inherited;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;

  FPathArcE:=nil;
  FLastShownPathArcE:=nil;
  FCInE:=nil;
  FCOutE:=nil;

  lbArcs.Clear;
  lbInArcs.Clear;
  lbOutArcs.Clear;
  lbHistory.Clear;
  lRecalcInV.Caption:='';
  lRecalcOutV.Caption:='';
  lInV.Caption:='';
  lOutV.Caption:='';
  lElement.Caption:='';
end;

procedure TGraphAnalyzer.SelectionChanged(DMElement: OleVariant);
var
  DMDocument:IDMDocument;
  Element:IDMElement;
  Unk:IUnknown;
  S:string;
  j:integer;
begin
//  if not Visible then Exit;
  DMDocument:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  Unk:=DMElement;
  Element:=Unk as IDMElement;
  if Element=nil then Exit;
  if (Element.Ref<>nil) and
     (Element.Ref.SpatialElement=Element) then
    Element:=Element.Ref;

  lElement.Caption:='';
  if Element.QueryInterface(IBoundary, Unk)=0 then begin
    SetFacilityElement(Element);
    lbHistory.Clear;
    j:=lbArcs.ItemIndex;
    if j<>-1 then begin
      S:=lbArcs.Items[j];
      lbHistory.Items.AddObject(S, lbArcs.Items.Objects[j])
    end;
  end else
  if Element.QueryInterface(IPathArc2, Unk)=0 then begin
    SetPathArc(Element);
  end;
end;

procedure TGraphAnalyzer.AddPathArc(const PathArcE:IDMElement;
                            j:integer; var BestJ:integer; var BestV:double);
var
  C0E, C1E:IDMElement;
  PathArcL:ILine;
  PathArc:IPathArc2;
  C0, C1:ICoordNode;
  S, S0, S1:string;
  C0V, C1V: IVulnerabilityData;
  V, V0, V1:double;
  CE:IDMElement;
begin
      PathArcL:=PathArcE as ILine;
      PathArc:=PathArcE as IPathArc2;
      C0:=PathArcL.C0;
      C1:=PathArcL.C1;
      C0E:=C0 as IDMElement;
      C1E:=C1 as IDMElement;
      C0V:=C0 as IVulnerabilityData;
      C1V:=C1 as IVulnerabilityData;
      if C0.Lines.Count>0 then
        S0:=C0.Lines.Item[0].Name
      else
        S0:='';
      if C1.Lines.Count>0 then
        S1:=C1.Lines.Item[0].Name
      else
        S1:='';
      S:=Format('%s(%d) - %d - %s(%d)',[S0, C0E.ID, PathArcE.ID, S1, C1E.ID]);
      lbArcs.Items.AddObject(S, TObject(pointer(PathArcE)));

      case rgGraphType.ItemIndex of
      0:begin
          V0:=C0V.DelayTimeToTarget;
          V1:=C1V.DelayTimeToTarget;
          if V0>V1 then begin
            V:=V0;
            CE:=C0V as IDMElement;
          end else begin
            V:=V1;
            CE:=C1V as IDMElement;
          end;
          if BestV>V then begin
            BestV:=V;
            BestJ:=j;
          end;
        end;
      1:begin
          V0:=C0V.NoDetectionProbabilityFromStart;
          V1:=C1V.NoDetectionProbabilityFromStart;
          if V0>V1 then begin
            V:=V0;
            CE:=C0V as IDMElement;
          end else begin
            V:=V1;
            CE:=C1V as IDMElement;
          end;
          if BestV<V then begin
            BestV:=V;
            BestJ:=j;
          end;
        end;
      2:begin
          V0:=C0V.RationalProbabilityToTarget;
          V1:=C1V.RationalProbabilityToTarget;
          if V0<V1 then begin
            V:=V0;
            CE:=C0V as IDMElement;
          end else begin
            V:=V1;
            CE:=C1V as IDMElement;
          end;
          if BestV<V then begin
            BestV:=V;
            BestJ:=j;
          end;
        end;
      end; //case rgGraphType of
end;

procedure TGraphAnalyzer.SetFacilityElement(const Element:IDMElement);
var
  FacilityElement:IFacilityElement;
  j, BestJ:integer;
  PathArcE:IDMElement;
  BestV:double;
begin
    lElement.Caption:=Element.Name;
    FacilityElement:=Element as IFacilityElement;

    lbArcs.Clear;
    BestJ:=-1;
    case rgGraphType.ItemIndex of
    0:BestV:=1000000000;
    1:BestV:=-1000000000;
    2:BestV:=-1000000000;
    else BestV:=0;
    end;

    for j:=0 to FacilityElement.PathArcs.Count-1 do begin
      PathArcE:=FacilityElement.PathArcs.Item[j];
      AddPathArc(PathArcE, j, Bestj, BestV);
    end;  

    lbArcs.ItemIndex:=BestJ;
    MakeInOutArcsList
end;

destructor TGraphAnalyzer.Destroy;
begin
  inherited;
  FPathArcE:=nil;
  FLastShownPathArcE:=nil;
  FCInE:=nil;
  FCOutE:=nil;
end;

procedure TGraphAnalyzer.lbArcsClick(Sender: TObject);
begin
  MakeInOutArcsList;
  lbExtArcsClick(Sender);
end;

procedure TGraphAnalyzer.MakeInOutArcsList;
  procedure FillArcList(const aListBox:TListBox; const C:ICoordNode);
  var
    m:integer;
    aLine:ILine;
    aLineE:IDMElement;
    aC0, aC1, aC:ICoordNode;
    SS, SF, S:string;
    aCE, CE:IDMElement;
    aCV, CV: IVulnerabilityData;
    V{, BestV}:double;
  begin
    CV:=C as IVulnerabilityData;
    CE:=C as IDMElement;

    for m:=0 to C.Lines.Count-1 do begin
      aLineE:=C.Lines.Item[m];
      if aLineE<>FPathArcE then begin
        aLine:=aLineE as ILine;
        aC0:=aLine.C0;
        aC1:=aLine.C1;
        if C=aC0 then
          aC:=aC1
        else
          aC:=aC0;
        aCE:=aC as IDMElement;
        aCV:=aC as IVulnerabilityData;
        case rgGraphType.ItemIndex of
        0:begin
            V:=aCV.DelayTimeToTarget;
            SF:='%0.0f';
            if aListBox.Tag=0 then begin
              if (CV.DelayTimeToTarget_NextArc=aLineE) and
                 (CV.DelayTimeToTarget<V)then begin
                FBestInPathArc:=aLineE;
                V:=CV.DelayTimeToTarget;
              end;
            end else begin
              if aCV.DelayTimeToTarget_NextArc=aLineE then
                FBestOutPathArc:=aLineE
            end;
          end;
        1:begin
            V:=aCV.NoDetectionProbabilityFromStart;
            SF:='%0.6f';
            if aListBox.Tag=0 then begin
              if CV.NoDetectionProbabilityFromStart_NextArc=aLineE then
                FBestInPathArc:=aLineE
            end else begin
              if (aCV.NoDetectionProbabilityFromStart_NextArc=aLineE) and
                 (aCV.NoDetectionProbabilityFromStart>V) then begin
                FBestOutPathArc:=aLineE;
                V:=aCV.NoDetectionProbabilityFromStart;
              end;
            end;
          end;
        2:begin
            V:=-aCV.RationalProbabilityToTarget;
            SF:='%0.12f';
            if aListBox.Tag=0 then begin
              if CV.RationalProbabilityToTarget_NextArc=aLineE then
                FBestInPathArc:=aLineE
            end else begin
              if (aCV.RationalProbabilityToTarget_NextArc=aLineE) and
                 (aCV.RationalProbabilityToTarget>V) then begin
                FBestOutPathArc:=aLineE;
                V:=aCV.RationalProbabilityToTarget;
              end;
            end;
          end;
        else
          begin
            V:=0;
            SF:=''
          end;
        end;

        if aC.Lines.Count>0 then
          SS:=aC.Lines.Item[0].Name
        else
          SS:='';
        if aListBox.Tag=0 then
          S:=Format(SF+'- %s(%d) - %d -',[V, SS, aCE.ID, aLineE.ID])
        else
          S:=Format('- %d - %s(%d) - '+SF,[aLineE.ID, SS, aCE.ID, V]);
        aListBox.Items.AddObject(S, TObject(pointer(aLineE)));
      end;
    end; //for m:=0 to C.Lines.Count-1
    aListBox.ItemIndex:=-1;
  end;

var
  j:integer;
  PathArcL:ILine;
  PathArc:IPathArc;
  C0, C1:ICoordNode;
  C0V, C1V: IVulnerabilityData;
  V0, V1:double;
  SF:string;

begin
  lbInArcs.Clear;
  lbOutArcs.Clear;
  j:=lbArcs.ItemIndex;
  if j=-1 then Exit;

  FPathArcE:=IDMElement(pointer(lbArcs.Items.Objects[j]));
  PathArcL:=FPathArcE as ILine;
  PathArc:=FPathArcE as IPathArc;
  C0:=PathArcL.C0;
  C1:=PathArcL.C1;
  C0V:=C0 as IVulnerabilityData;
  C1V:=C1 as IVulnerabilityData;
  case rgGraphType.ItemIndex of
  0:begin
      V0:=C0V.DelayTimeToTarget;
      V1:=C1V.DelayTimeToTarget;
      SF:='%0.0f';
    end;
  1:begin
      V0:=C0V.NoDetectionProbabilityFromStart;
      V1:=C1V.NoDetectionProbabilityFromStart;
      SF:='%0.6f';
    end;
  2:begin
      V0:=-C0V.RationalProbabilityToTarget;
      V1:=-C1V.RationalProbabilityToTarget;
      SF:='%0.12f';
    end;
  else
    begin
      V0:=0;
      V1:=0;
      SF:='';
    end;
  end;
  if V0<=V1 then begin
    lInV.Caption:=Format(SF,[V0]);
    lOutV.Caption:=Format(SF,[V1]);
    FillArcList(lbInArcs, C0);
    FillArcList(lbOutArcs, C1);
    FCInE:=C0 as IDMElement;
    FCOutE:=C1 as IDMElement;
  end else begin
    lInV.Caption:=Format(SF,[V1]);
    lOutV.Caption:=Format(SF,[V0]);
    FillArcList(lbInArcs, C1);
    FillArcList(lbOutArcs, C0);
    FCInE:=C1 as IDMElement;
    FCOutE:=C0 as IDMElement;
  end;
  lPathGraph.Caption:=PathArc.FacilityState.Name;
end;

procedure TGraphAnalyzer.rgGraphTypeClick(Sender: TObject);
begin
  lbHistory.Clear;
  MakeInOutArcsList;
end;

procedure TGraphAnalyzer.btNextClick(Sender: TObject);
var
  j:integer;
  aPathArcE:IDMElement;
begin
  j:=lbInArcs.ItemIndex;
  if j=-1 then Exit;
  aPathArcE:=IDMElement(pointer(lbInArcs.Items.Objects[j]));
  SetPathArc(aPathArcE);
end;

procedure TGraphAnalyzer.btPrevClick(Sender: TObject);
var
  j:integer;
  aPathArcE:IDMElement;
begin
  j:=lbOutArcs.ItemIndex;
  if j=-1 then Exit;
  aPathArcE:=IDMElement(pointer(lbOutArcs.Items.Objects[j]));
  SetPathArc(aPathArcE);
end;


procedure TGraphAnalyzer.SetPathArc(const aPathArcE:IDMElement);
var
  j:integer;
  S:string;
begin
  j:=DoSetPathArc(aPathArcE);
  if j<>-1 then begin
    S:=lbArcs.Items[j];
    lbHistory.Items.AddObject(S, TObject(pointer(aPathArcE)))
  end;
end;

function TGraphAnalyzer.DoSetPathArc(const aPathArcE:IDMElement):integer;
var
  BestJ:integer;
  BestV:double;
begin
  lElement.Caption:='';
  lbArcs.Clear;

  BestJ:=-1;
  case rgGraphType.ItemIndex of
  0:BestV:=1000000000;
  1:BestV:=-1000000000;
  2:BestV:=-1000000000;
  else BestV:=0;
  end;

  AddPathArc(aPathArcE, 0, BestJ, BestV);

  lbArcs.ItemIndex:=0;
  MakeInOutArcsList;
  Result:=0;
end;

procedure TGraphAnalyzer.lbExtArcsClick(Sender: TObject);
var
  Server:IDataModelServer;
  SMDocument:ISMDocument;
  Painter:IPainter;
  j:integer;
  aPathArcE:IDMElement;
  aPathArcL:ILine;
  aPathArc:IPathArc2;
  aListBox:TListBox;
  PrevNode:IPathNode;
  PrevNode2:IPathNode2;
  PrevNodeE, NextNodeE:IDMElement;
  V:double;
  SF:string;
begin
  inherited;
  aListBox:=Sender as TListBox;
  Server:=Get_DataModelServer as IDataModelServer;
  SMDocument:=Server.CurrentDocument as ISMDocument;
  if SMDocument=nil then Exit;
  Painter:=SMDocument.PainterU as IPainter;
  if Painter=nil then Exit;

  j:=aListBox.ItemIndex;
  if j=-1 then Exit;
  aPathArcE:=IDMElement(pointer((Sender as TListBox).Items.Objects[j]));
  aPathArcL:=aPathArcE as ILine;
  aPathArc:=aPathArcE as IPathArc2;

  if FLastShownPathArcE<>nil then
    FLastShownPathArcE.Draw(Painter, -1);
  aPathArcE.Draw(Painter, 1);
  FLastShownPathArcE:=aPathArcE;

  if aListBox.Tag=0 then
    PrevNode:=aPathArcL.NextNodeTo(FCInE as ICoordNode)as IPathNode
  else
  if aListBox.Tag=1 then
    PrevNode:=FCOutE as IPathNode
  else
    PrevNode:=FCInE as IPathNode;
  PrevNode2:=PrevNode as IPathNode2;

  case rgGraphType.ItemIndex of
  0:begin
      PrevNode2.RestoreRecord(admGet_DelayTime);
      SF:='%0.0f';
    end;
  1:begin
      PrevNode2.RestoreRecord(admGet_NoDetectionProbability);
      SF:='%0.6f';
    end;
  2:begin
      PrevNode2.RestoreRecord(admGet_SuccessProbability);
      SF:='%0.12f';
    end;
  end;
  PrevNodeE:=PrevNode as IDMElement;
  NextNodeE:=aPathArcL.NextNodeTo(PrevNodeE as ICoordNode) as IDMElement;
  V:=aPathArc.NewDistanceFromRoot(PrevNodeE, NextNodeE);
  if aListBox.Tag=0 then
    lRecalcInV.Caption:=Format(SF, [V])
  else
  if aListBox.Tag=1 then
    lRecalcOutV.Caption:=Format(SF, [V])
  else
    lRecalcV.Caption:=Format(SF, [V])
end;

procedure TGraphAnalyzer.lbInArcsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aListBox:TListBox;
begin
  aListBox:=Control as TListBox;
  aListBox.Canvas.FillRect(Rect);
  if IDMElement(pointer(aListBox.Items.Objects[Index]))=FBestInPathArc then
    aListBox.Canvas.Font.Color:=clBlue
  else
  if IDMElement(pointer(aListBox.Items.Objects[Index]))=FBestOutPathArc then
    aListBox.Canvas.Font.Color:=clBlue;
  aListBox.Canvas.TextOut(Rect.Left + 2, Rect.Top, aListBox.Items[Index])
end;

procedure TGraphAnalyzer.lbHistoryClick(Sender: TObject);
var
  j:integer;
  PathArcE:IDMElement;
begin
  j:=lbHistory.ItemIndex;
  if j=-1 then Exit;
  PathArcE:=IDMElement(pointer(lbHistory.Items.Objects[j]));
  DoSetPathArc(PathArcE);
  lbExtArcsClick(Sender);
end;

end.
