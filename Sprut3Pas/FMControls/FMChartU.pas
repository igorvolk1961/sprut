unit FMChartU;
//___________________________________вариант  Volkov_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, FacilityModelLib_TLB,
  DMChartU,  Chart, DMTeeChartU, TeEngine, Series, TeeProcs;

type

  TFMChart = class(TDMTeeChart)
    pAnalysisVariant: TPanel;
    Label3: TLabel;
    chbAnalysisVariant: TComboBox;
    btCopy: TButton;
    procedure btCopyClick(Sender: TObject);
    procedure chbAnalysisVariantChange(Sender: TObject);
  protected
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;
  public
  end;

implementation

{$R *.DFM}


procedure TFMChart.btCopyClick(Sender: TObject);
begin
  Chart1.CopyToClipboardMetafile(True)
end;

procedure TFMChart.SelectionChanged(DMElement: OleVariant);
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  j:integer;
  AnalysisVariantE:IDMElement;
  aElement:IDMElement;
  Unk:IUnknown;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;

  if DMDocument.SelectionCount<>0 then begin
    aElement:=DMDocument.SelectionItem[0] as IDMElement;
    if (aElement.Ref<>nil) and
       (aElement.Ref.SpatialElement=aElement) then
      aElement:=aElement.Ref;

    if (aElement.QueryInterface(IAnalysisVariant, Unk)=0) or
       ((aElement.Parent<>nil) and
        (aElement.Parent.QueryInterface(IAnalysisVariant, Unk)=0)) then begin
      pAnalysisVariant.Visible:=False;
    end else begin
      pAnalysisVariant.Visible:=True;

      FacilityModel:=GetDataModel as IFacilityModel;
      FacilityModelS:=FacilityModel as IFMState;

      chbAnalysisVariant.Clear;

      for j:=0 to FacilityModel.AnalysisVariants.Count-1 do begin
        AnalysisVariantE:=FacilityModel.AnalysisVariants.Item[j];
        chbAnalysisVariant.Items.Add(AnalysisVariantE.Name);
      end;

      AnalysisVariantE:=FacilityModelS.CurrentAnalysisVariantU as IDMElement;
      chbAnalysisVariant.ItemIndex:=FacilityModel.AnalysisVariants.IndexOf(AnalysisVariantE);
    end;
  end;

  inherited;
end;

procedure TFMChart.chbAnalysisVariantChange(Sender: TObject);
var
  FacilityModel:IFacilityModel;
  FacilityModelS:IFMState;
  j:integer;
  AnalysisVariantE:IDMElement;
begin
  j:=chbAnalysisVariant.ItemIndex;
  if j=-1 then Exit;

  FacilityModel:=GetDataModel as IFacilityModel;
  FacilityModelS:=FacilityModel as IFMState;

  if j>FacilityModel.AnalysisVariants.Count-1 then Exit;

  AnalysisVariantE:=FacilityModel.AnalysisVariants.Item[j];
  if (FacilityModelS.CurrentAnalysisVariantU as IDMElement)=AnalysisVariantE then Exit;
  FacilityModelS.CurrentAnalysisVariantU:=AnalysisVariantE;

  SetValues;

end;

end.
