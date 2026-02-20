unit SGSynthesisControlU;
//___________________________________вариант  Volkov_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls,
  Types,  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU,
  SafeguardSynthesisLib_TLB, FacilityModelLib_TLB;

type

  TSGSynthesisControl = class(TDMPage)
    Panel1: TPanel;
    Label3: TLabel;
    Panel3: TPanel;
    Panel5: TPanel;
    sgEquipmentVariants: TStringGrid;
    Panel4: TPanel;
    btAdd: TButton;
    btDelete: TButton;
    btPersistent: TButton;
    sgRecomendations: TStringGrid;
    rgTotalEfficiencyCalcMode: TRadioGroup;
    btAnalysis: TButton;
    procedure sgRecomendationsSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure sgEquipmentVariantsSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure sgRecomendationsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure rgTotalEfficiencyCalcModeClick(Sender: TObject);
    procedure btAnalysisClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btPersistentClick(Sender: TObject);
    procedure sgRecomendationsDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    FControlIndex:integer;
    FSafeguardSynthesis:ISafeguardSynthesis;
    procedure ShowEquipmentVariants;
    procedure ShowRecomendations;

  protected

    procedure OpenDocument; override; safecall;
    procedure RefreshDocument(FlagSet:integer); override; safecall;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;

    function  Get_SafeguardSynthesis: IUnknown; safecall;
    procedure Set_SafeguardSynthesis(const Value: IUnknown); safecall;

    procedure StopAnalysis(Mode:integer); override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

{$R *.DFM}

procedure TSGSynthesisControl.Initialize;
begin
  inherited Initialize;
  FControlIndex:=8;
  DecimalSeparator:='.';
end;

procedure TSGSynthesisControl.OpenDocument;
var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  FacilityModel:IFacilityModel;
begin
  inherited;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  FacilityModel:=DMDocument.DataModel as IFacilityModel;

  FSafeguardSynthesis:=FacilityModel.SafeguardSynthesis as ISafeguardSynthesis;
  RefreshDocument(rfData);

  if FSafeguardSynthesis=nil then Exit;

  sgRecomendations.Cells[0, 0]:='Элемент СФЗ';
  sgRecomendations.Cells[1, 0]:='Вариант';
  sgRecomendations.Cells[2, 0]:='Стоимость';

                  sgRecomendations.ColWidths[2]:=0;

  sgEquipmentVariants.Cells[0, 0]:='Вариант оснащения СФЗ';
  sgEquipmentVariants.Cells[1, 0]:='Эффективность';
  sgEquipmentVariants.Cells[2, 0]:='Стоимость';

  rgTotalEfficiencyCalcMode.ItemIndex:=FacilityModel.TotalEfficiencyCalcMode;
end;

procedure TSGSynthesisControl.SelectionChanged(DMElement: OleVariant);
begin
end;

destructor TSGSynthesisControl.Destroy;
begin
  inherited;
  FSafeguardSynthesis:=nil;
end;

function TSGSynthesisControl.Get_SafeguardSynthesis: IUnknown;
begin
  Result:=FSafeguardSynthesis as IUnknown
end;

procedure TSGSynthesisControl.Set_SafeguardSynthesis(
  const Value: IUnknown);
begin
  FSafeguardSynthesis:=Value as  ISafeguardSynthesis
end;

procedure TSGSynthesisControl.RefreshDocument(FlagSet:integer);
var
  B:boolean;
begin
  if not Visible then Exit;
  if (rfData and FlagSet)=0 then Exit;
  ShowEquipmentVariants;
  if sgEquipmentVariants.RowCount>1 then
    sgEquipmentVariantsSelectCell(sgEquipmentVariants,
        0, 1, B)
  else
    ShowRecomendations;
end;

procedure TSGSynthesisControl.ShowRecomendations;
var
  j:integer;
  RecomendationE:IDMElement;
  Recomendation:IRecomendation;
begin
  sgRecomendations.RowCount:=FSafeguardSynthesis.Recomendations.Count+1;
  if sgRecomendations.RowCount>1 then
    sgRecomendations.FixedRows:=1;
  for j:=0 to FSafeguardSynthesis.Recomendations.Count-1 do begin
    RecomendationE:=FSafeguardSynthesis.Recomendations.Item[j];
    Recomendation:=RecomendationE as IRecomendation;
    sgRecomendations.Cells[0, j+1]:=RecomendationE.Name;
    sgRecomendations.Cells[1, j+1]:=IntToStr(Recomendation.CurrentVariantIndex);
    sgRecomendations.Cells[2, j+1]:=Format('%0.2f тыс. руб.',
                                       [Recomendation.Price/1000]);
  end;
end;

procedure TSGSynthesisControl.ShowEquipmentVariants;
var
  j:integer;
  EquipmentVariantE:IDMElement;
  EquipmentVariant:IEquipmentVariant;
begin
  sgEquipmentVariants.RowCount:=FSafeguardSynthesis.EquipmentVariants.Count+1;
  if sgEquipmentVariants.RowCount>1 then
    sgEquipmentVariants.FixedRows:=1;
  for j:=0 to FSafeguardSynthesis.EquipmentVariants.Count-1 do begin
    EquipmentVariantE:=FSafeguardSynthesis.EquipmentVariants.Item[j];
    EquipmentVariant:=EquipmentVariantE as IEquipmentVariant;
    sgEquipmentVariants.Cells[0, j+1]:=EquipmentVariantE.Name;
    sgEquipmentVariants.Cells[1, j+1]:=Format('%0.4f',
                                       [EquipmentVariant.TotalEfficiency]);
    sgEquipmentVariants.Cells[2, j+1]:=Format('%0.2f тыс. руб.',
                                       [EquipmentVariant.TotalPrice/1000]);
  end;

end;

procedure TSGSynthesisControl.sgRecomendationsSelectCell(
  Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  RecomendationE, FacilityElementE, SafeguardElementE:IDMElement;
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  SafeguardUnit:ISafeguardUnit;
  Recomendation:IRecomendation;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;

  if (ARow>0) and
     (ACol=1) then
    (Sender as TStringGrid).Options:=(Sender as TStringGrid).Options+
                                            [goEditing]-[goRowSelect]
  else
    (Sender as TStringGrid).Options:=(Sender as TStringGrid).Options-
                                            [goEditing]+[goRowSelect];
  if ARow=0 then Exit;

  DMDocument.ClearSelection(nil);

  RecomendationE:=FSafeguardSynthesis.Recomendations.Item[ARow-1];
  Recomendation:=RecomendationE as IRecomendation;
  SafeguardUnit:=Recomendation.ParentElement as ISafeguardUnit;
  if SafeguardUnit.SafeguardElements.Count>0 then begin
    SafeguardElementE:=SafeguardUnit.SafeguardElements.Item[0];
    Server.DocumentOperation(SafeguardElementE, nil,
          leoAdd, -1);
  end else begin
    FacilityElementE:=RecomendationE.Ref;
    Server.DocumentOperation(FacilityElementE, nil,
          leoAdd, -1);
  end;
end;

procedure TSGSynthesisControl.sgEquipmentVariantsSelectCell(
  Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  B:boolean;
begin
  if ARow=0 then Exit;
  FSafeguardSynthesis.CurrentEquipmentVariant:=
           FSafeguardSynthesis.EquipmentVariants.Item[ARow-1];
  ShowRecomendations;
  sgRecomendationsSelectCell(sgRecomendations,
      sgRecomendations.Col, sgRecomendations.Row, B)
end;

procedure TSGSynthesisControl.StopAnalysis(Mode: integer);
begin
  if Mode=-2 then begin
    RefreshDocument(rfAll);
  end;
end;

procedure TSGSynthesisControl.sgRecomendationsSetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: String);
var
  D, Err:integer;
  RecomendationE, SafeguardElementE, FacilityElementE:IDMElement;
  Recomendation:IRecomendation;
  RecomendationVariant:IRecomendationVariant;
  Server:IDataModelServer;
  SafeguardUnit:ISafeguardUnit;
begin
  if aRow=0 then Exit;
  if aCol<>1 then Exit;
  Val(Value, D, Err);
  if Err=0 then begin
    if (D>=0) and (D<=3) then begin
      RecomendationE:=FSafeguardSynthesis.Recomendations.Item[aRow-1];
      Recomendation:=RecomendationE as IRecomendation;

      RecomendationVariant:=Recomendation.RecomendationVariant[Recomendation.CurrentVariantIndex] as IRecomendationVariant;
      if RecomendationVariant<>nil then
        RecomendationVariant.Disconnect;
      Recomendation.CurrentVariantIndex:=D;
      RecomendationVariant:=Recomendation.RecomendationVariant[Recomendation.CurrentVariantIndex] as IRecomendationVariant;
      if RecomendationVariant<>nil then
        RecomendationVariant.Connect;

      FacilityElementE:=RecomendationE.Ref;
      Server:=Get_DataModelServer as IDataModelServer;
      SafeguardUnit:=Recomendation.ParentElement as ISafeguardUnit;
      if SafeguardUnit.SafeguardElements.Count>0 then begin
        SafeguardElementE:=SafeguardUnit.SafeguardElements.Item[0];
        Server.DocumentOperation(SafeguardElementE, nil,
          leoAdd, -1);
      end else begin
        FacilityElementE:=RecomendationE.Ref;
        Server.DocumentOperation(FacilityElementE, nil,
          leoDelete, -1);
      end;
    end else
      sgRecomendations.Canvas.Font.Color:=clRed
  end else
    sgRecomendations.Canvas.Font.Color:=clRed
end;

procedure TSGSynthesisControl.rgTotalEfficiencyCalcModeClick(
  Sender: TObject);
var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  FacilityModel:IFacilityModel;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  FacilityModel:=DMDocument.DataModel as IFacilityModel;
  FacilityModel.TotalEfficiencyCalcMode:=rgTotalEfficiencyCalcMode.ItemIndex;
  if FSafeguardSynthesis=nil then Exit;
  FSafeguardSynthesis.Analysis;

  Server.RefreshDocument(rfAll);
end;

procedure TSGSynthesisControl.btAnalysisClick(Sender: TObject);
var
  Server:IDataModelServer;
begin
  if FSafeguardSynthesis=nil then Exit;
  Screen.Cursor:=crHourGlass;
  try
    FSafeguardSynthesis.Analysis;
  finally
    Screen.Cursor:=crDefault;
  end;

  Server:=Get_DataModelServer as IDataModelServer;
  Server.RefreshDocument(rfAll);
end;

procedure TSGSynthesisControl.btAddClick(Sender: TObject);
var
  EquipmentVariants2, RecomendationVariants2:IDMCollection2;
  NewEquipmentVariantE, RecomendationVariantE:IDMElement;
  EquipmentVariant, NewEquipmentVariant:IEquipmentVariant;
  j:integer;
  S:string;
  B:boolean;
begin
  EquipmentVariants2:=FSafeguardSynthesis.EquipmentVariants as IDMCollection2;
  RecomendationVariants2:=FSafeguardSynthesis.RecomendationVariants as IDMCollection2;
  S:=EquipmentVariants2.MakeDefaultName(nil);
  NewEquipmentVariantE:=EquipmentVariants2.CreateElement(False);
  EquipmentVariants2.Add(NewEquipmentVariantE);
  NewEquipmentVariantE.Name:=S;
  NewEquipmentVariant:=NewEquipmentVariantE as IEquipmentVariant;

  EquipmentVariant:=FSafeguardSynthesis.CurrentEquipmentVariant as IEquipmentVariant;
  for j:=0 to EquipmentVariant.RecomendationVariants.Count-1 do begin
    RecomendationVariantE:=EquipmentVariant.RecomendationVariants.Item[j];
    RecomendationVariantE.AddParent(NewEquipmentVariantE);
  end;
  NewEquipmentVariant.TotalPrice:=EquipmentVariant.TotalPrice;
  NewEquipmentVariant.TotalEfficiency:=EquipmentVariant.TotalEfficiency;
  ShowEquipmentVariants;
  if sgEquipmentVariants.RowCount>1 then
    sgEquipmentVariantsSelectCell(sgEquipmentVariants,
        0, 1, B)
end;

procedure TSGSynthesisControl.btDeleteClick(Sender: TObject);
var
  EquipmentVariantE:IDMElement;
  j:integer;
  EquipmentVariants2:IDMCollection2;
  B:boolean;
begin
  if FSafeguardSynthesis.EquipmentVariants.Count<2 then Exit;
  EquipmentVariantE:=FSafeguardSynthesis.CurrentEquipmentVariant;
  j:=FSafeguardSynthesis.EquipmentVariants.IndexOf(EquipmentVariantE);
  if j<>0 then
    FSafeguardSynthesis.CurrentEquipmentVariant:=FSafeguardSynthesis.EquipmentVariants.Item[j-1]
  else
    FSafeguardSynthesis.CurrentEquipmentVariant:=FSafeguardSynthesis.EquipmentVariants.Item[1];
  EquipmentVariants2:=FSafeguardSynthesis.EquipmentVariants as IDMCollection2;
  EquipmentVariantE.Clear;
  EquipmentVariants2.Delete(j);
  ShowEquipmentVariants;
  if sgEquipmentVariants.RowCount>1 then
    sgEquipmentVariantsSelectCell(sgEquipmentVariants,
        0, 1, B)
  else begin
    ShowRecomendations;
    sgRecomendationsSelectCell(sgRecomendations,
      sgRecomendations.Col, sgRecomendations.Row, B)
  end;
end;

procedure TSGSynthesisControl.btPersistentClick(Sender: TObject);
var
  FacilityModel:IFacilityModel;
begin
  FacilityModel:=FSafeguardSynthesis.FacilityModel as IFacilityModel;
  FacilityModel.MakePersistant;
  (FSafeguardSynthesis as IDMElement).Clear;
  RefreshDocument(rfData);
end;

procedure TSGSynthesisControl.sgRecomendationsDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Recomendation:IRecomendation;
  RecomendationVariant:IRecomendationVariant;
begin
  if (not (gdFixed in State)) and
     (ARow>0) then begin
    if FSafeguardSynthesis=nil then Exit;
    Recomendation:=FSafeguardSynthesis.Recomendations.Item[ARow-1] as IRecomendation;
    RecomendationVariant:=Recomendation.RecomendationVariant[
                          Recomendation.CurrentVariantIndex] as IRecomendationVariant;
    if (RecomendationVariant<>nil) and
       (RecomendationVariant.EquipmentElements.Count>0) then
      if gdSelected in State then
        sgRecomendations.Canvas.Font.Color:=clYellow
      else
        sgRecomendations.Canvas.Font.Color:=clGreen
  end;
  sgRecomendations.Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2,
                                 sgRecomendations.Cells[ACol, ARow]);
end;

end.
