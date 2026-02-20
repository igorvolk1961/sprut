unit PriceControlU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU,
  SpatialModelLib_TLB, FacilityModelLib_TLB, SafeguardAnalyzerLib_TLB,
  SgdbLib_TLB, ValEdit ;

type

  TPriceControl = class(TDMPage)
    PriceTable: TStringGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    L1: TLabel;
    lSumm0: TLabel;
    B1: TButton;
    BKoef: TButton;
    lSumm: TLabel;
    L2: TLabel;
    chbModificationStage: TComboBox;
    Label2: TLabel;
    lSumm1: TLabel;
    Label1: TLabel;
    lSumm3: TLabel;
    Label7: TLabel;
    lSumm4: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    lSumm2: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure B1Click(Sender: TObject);
    procedure BKoefClick(Sender: TObject);
    procedure chbModificationStageChange(Sender: TObject);
  private
  protected

    procedure OpenDocument; override; safecall;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;

  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  Koef;

{$R *.DFM}

{ TDMChartX }
var
//  aCount:integer;
  aFacilityModel:IFacilityModel;

const
  rsPerPieceR='руб./шт.';
  rsPerLengthR='руб./м';
  rsPerSquareR='руб./м2';
  rsPerVolumeR='руб./м3';
  rsPerComplectR='руб./компл.';
  rsPerPieceU='у.е./шт.';
  rsPerLengthU='у.е./м';
  rsPerSquareU='у.е./м2';
  rsPerVolumeU='у.е./м3';
  rsPerComplectU='у.е./компл.';

procedure TPriceControl.Initialize;
begin
  inherited Initialize;
  DecimalSeparator:='.';
end;

procedure TPriceControl.SelectionChanged(DMElement: OleVariant);
begin
end;

destructor TPriceControl.Destroy;
begin
  inherited;
end;


procedure TPriceControl.B1Click(Sender: TObject);
var
  Server:IDataModelServer;
  DMDocument:IDMDocument;
  ModificationStage:integer;

  Procedure FillTable (const aCollection:IDMCollection);
    var
      j,i,e,l:integer;
      Price:IPrice;
      C, CurrencyRate, M,
      aPrice, aPriceM, aPriceI,
      Summ, Summ0, Summ1, Summ2, Summ3, Summ4:double;
      InstallCoeff, KD, KTZSR, KPNR:double;
      aElement:IDMElement;
      aLinesB:IDMCollection;
      aArea:IArea;
      BackRefHolder:IDMBackRefHolder;
      Goods:IGoods;
      ElementName, PriceDimension, Dimension:string;
    begin
      CurrencyRate:=aFacilityModel.CurrencyRate;
      KD:=aFacilityModel.PriceCoeffD;
      KTZSR:=aFacilityModel.PriceCoeffTZSR;
      KPNR:=aFacilityModel.PriceCoeffPNR;
      Summ0:=0;
      Summ1:=0;
      for j:=0 to aCollection.Count-1 do begin
        try
        if aCollection.Item[j].Ref.QueryInterface(IPrice, Price)=0 then begin
          ElementName:=aCollection.Item[j].Ref.Name;
          aPrice:=Price.Price;
          BackRefHolder:=aCollection.Item[j] as IDMBackRefHolder;

          InstallCoeff:=1;
          M:=0;
          for e:=0 to BackRefHolder.BackRefs.Count-1 do begin
            aElement:=BackRefHolder.BackRefs.Item[e];
            Goods:=aElement as IGoods;
            InstallCoeff:=Goods.InstallCoeff;
            if (aElement.Parent<>nil) and
               (aElement.Presence>0) and
               (aElement.Presence<=ModificationStage) and
               (Goods.DeviceCount>0) then
              case Price.PriceDimension of
              pdPerPieceR,
              pdPerPieceU:
                begin
                  M:=M+Goods.DeviceCount;
                end;
              pdPerLengthR,
              pdPerLengthU:
                begin
                  if aElement.ClassID=_Cabel then begin
                    aLinesB:=(aElement.SpatialElement as IPolyline).Lines;
                    for l:=0 to aLinesB.Count-1 do
                      M:=M+(aLinesB.Item[l] as ILine).Length*0.01;
                  end else
                  if (aElement.Parent<>nil) and
                     (aElement.Parent.Parent<>nil) and
                     (aElement.Parent.Parent.ClassID=_Boundary) then begin
                    aLinesB:=(aElement.Parent.Parent.SpatialElement as IArea).BottomLines;
                    for l:=0 to aLinesB.Count-1 do
                      M:=M+(aLinesB.Item[l] as ILine).Length*0.01;
                  end
                end;
              pdPerSquareR,
              pdPerSquareU:
                begin
                  if (aElement.Parent<>nil) and
                     (aElement.Parent.Parent<>nil) and
                     (aElement.Parent.Parent.ClassID=_Boundary) then begin
                    aArea:=aElement.Parent.Parent.SpatialElement as IArea;
                    M:=M+aArea.Square*0.0001;
                  end;
                end;
              pdPerVolumeR,
              pdPerVolumeU:
                begin
                end;
              pdPerComplectR,
              pdPerComplectU:
                begin
                end;
              end; //  case Price.PriceDimension
          end; //for e:=0 to BackRefHolder.BackRefs.Count-1

          if M>0 then begin
            case Price.PriceDimension of
            pdPerPieceR:
              begin
                PriceDimension:=rsPerPieceR;
                C:=1;
                Dimension:='шт.';
              end;
            pdPerPieceU:
              begin
                PriceDimension:=rsPerPieceU;
                C:=CurrencyRate;
                Dimension:='шт.';
              end;
            pdPerLengthR:
              begin
                PriceDimension:=rsPerLengthR;
                C:=1;
                Dimension:='м';
              end;
            pdPerLengthU:
              begin
                PriceDimension:=rsPerLengthU;
                C:=CurrencyRate;
                Dimension:='м';
              end;
            pdPerSquareR:
              begin
                PriceDimension:=rsPerSquareR;
                C:=1;
                Dimension:='кв.м';
              end;
            pdPerSquareU:
              begin
                PriceDimension:=rsPerSquareU;
                C:=CurrencyRate;
                Dimension:='кв.м';
              end;
            pdPerVolumeR:
              begin
                PriceDimension:=rsPerVolumeR;
                C:=1;
                Dimension:='куб.м';
              end;
            pdPerVolumeU:
              begin
                PriceDimension:=rsPerVolumeU;
                C:=CurrencyRate;
                Dimension:='куб.м';
              end;
            pdPerComplectR:
              begin
                PriceDimension:=rsPerComplectR;
                C:=1;
                Dimension:='компл.';
              end;
            pdPerComplectU:
              begin
                PriceDimension:=rsPerComplectU;
                C:=CurrencyRate;
                Dimension:='компл.';
              end;
            else
              begin
                PriceDimension:='';
                C:=1;
              end;
            end; //  case Price.PriceDimension

            aPriceM:=aPrice*M*C;
            aPriceI:=aPriceM*InstallCoeff;
            Summ0:=Summ0+aPriceM;
            Summ1:=Summ1+aPriceI;

            i:=PriceTable.RowCount;
            PriceTable.RowCount:=i+1;
            PriceTable.Cells[0,i]:=ElementName;
            PriceTable.Cells[1,i]:=Format('%0.2n',[aPrice]);
            PriceTable.Cells[2,i]:=PriceDimension;
            PriceTable.Cells[3,i]:=Format('%0.0n %s',[M, Dimension]);
            PriceTable.Cells[4,i]:=Format('%0.2n руб.',[aPriceM]);
            PriceTable.Cells[5,i]:=Format('%0.2n руб.',[aPriceI]);

          end; //  if M>0
        end;  // if aCollection.Item[j].Ref.QueryInterface(IPrice, Price)=0
        except
          raise
        end;
      end;  // for j:=0 to aCollection.Count-1

      Summ2:=Summ1*KPNR;
      Summ3:=Summ0*KD;
      Summ4:=Summ0*KTZSR;
      Summ:=Summ0+Summ1+Summ2+Summ3+Summ4;

      lSumm0.Caption:=Format('%0.1f тыс. руб.',[Summ0*0.001]);
      lSumm1.Caption:=Format('%0.1f тыс. руб.',[Summ1*0.001]);
      lSumm2.Caption:=Format('%0.1f тыс. руб.',[Summ2*0.001]);
      lSumm3.Caption:=Format('%0.1f тыс. руб.',[Summ3*0.001]);
      lSumm4.Caption:=Format('%0.1f тыс. руб.',[Summ4*0.001]);
      lSumm.Caption :=Format('%0.1f тыс. руб.',[Summ *0.001]);
    end;

begin
  inherited;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  aFacilityModel:=DMDocument.DataModel as IFacilityModel;

  PriceTable.Cells[0,0]:='Наименование изделия';
  PriceTable.Cells[1,0]:='Цена';
  PriceTable.Cells[2,0]:='Единица измер.';
  PriceTable.Cells[3,0]:='Количество';
  PriceTable.Cells[4,0]:='Стоимость';
  PriceTable.Cells[5,0]:='Стоимость уст.';

  PriceTable.RowCount:=1;

  ModificationStage:=chbModificationStage.ItemIndex+1;

  FillTable((DMDocument.DataModel as IDataModel).BackRefHolders);

  if PriceTable.RowCount>1 then
    PriceTable.FixedRows:=1;

end;

procedure TPriceControl.OpenDocument;
begin
  inherited;
//  if not Visible then Exit;
  B1.Click;
end;

procedure TPriceControl.BKoefClick(Sender: TObject);
begin
  inherited;
  if KoefFrm=nil then
    KoefFrm:=TKoefFrm.Create(Self);
  KoefFrm.edD.Text:=Format('%0.2f',[aFacilityModel.PriceCoeffD]);
  KoefFrm.edTZSR.Text:=Format('%0.2f',[aFacilityModel.PriceCoeffTZSR]);
  KoefFrm.edPNR.Text:=Format('%0.2f',[aFacilityModel.PriceCoeffPNR]);
  KoefFrm.edCurrencyRate.Text:=Format('%0.2f',[aFacilityModel.CurrencyRate]);
  if KoefFrm.ShowModal=mrOK then begin
    aFacilityModel.PriceCoeffD:=StrToFloat(KoefFrm.edD.Text);
    aFacilityModel.PriceCoeffTZSR:=StrToFloat(KoefFrm.edTZSR.Text);
    aFacilityModel.PriceCoeffPNR:=StrToFloat(KoefFrm.edPNR.Text);
    aFacilityModel.CurrencyRate:=StrToFloat(KoefFrm.edCurrencyRate.Text);
  end;
end;

procedure TPriceControl.chbModificationStageChange(Sender: TObject);
begin
  B1.Click;
end;

end.
