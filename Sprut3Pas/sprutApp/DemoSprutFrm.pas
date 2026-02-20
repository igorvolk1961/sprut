unit DemoSprutFrm;

interface

uses
  SpruterFrm, DMContainerU, DemoContainerU,
  Forms, DdeMan, Dialogs, ImgList,
  Controls, Menus, Classes, Buttons ;

const
  pnTop = $00000000;
  pnBottom = $00000001;
  
type
  TfmDemoSprut = class(TfmMainSprut)
  protected
    function CreateContainer:TDMContainer; override;
    function GetHelloForm: TForm; override;
    procedure GetDBEditorParams(var DocumentProgID, ProgID,
               DataModelAlias, DataModelFileExt, DataBaseFileNameParam, DataBaseFileName:string); override;
    function GetRegistryKey: string; override;
    procedure LoadModuls; override;
    procedure AddFormButtons; override;
    procedure Initialize; override;
    procedure SetFormModes; override;
  end;

var
  fmDemoSprut: TfmDemoSprut;

implementation
uses
  DemoHelloFrm, LoadModulFrm,
  FMBrowserU, FMDrawU, FMChartU, DMReportU, FMGridU, DMListFormU,
  DMOpenGLU, DetailsControlU,
  SectorBuilderLib_TLB;

{$R *.DFM}

{ TfmDemoSprut }

procedure TfmDemoSprut.AddFormButtons;
begin
//    FDMEditor.AddFormButton(7, HInstance, 'GRAPH', 'Анализ графа маршрутов', 1, False);
//    AddMenuItem(7, 2, 'Анализ графа маршрутов');

    FDMEditor.AddFormButton(5, HInstance, 'TOOLS', 'Настройки', 1, False);
    AddMenuItem(5, 2, 'Настройки');
    FDMEditor.AddFormButton(4, HInstance, 'LIST', 'Спецификация элементов СФЗ', 1, False);
    AddMenuItem(4, 2, 'Спецификация элементов СФЗ');
    FDMEditor.AddFormButton(3, HInstance, '3D', '3-мерная модель', 1, False);
    AddMenuItem(3, 2, 'Пространственная модель');
    FDMEditor.AddFormButton(2, HInstance, 'ANALISYS', 'Варианты анализа', 1, False);
    AddMenuItem(2, 2, 'Варианты анализа');
//    FDMEditor.AddFormButton(2, HInstance, 'BATTLE', 'Модель боя', 1, False);
//    AddMenuItem(2, 2, 'Модель боя');
    FDMEditor.AddFormButton(1, HInstance, 'THREAT', 'Модель нарушителей', 1, False);
    AddMenuItem(1, 2, 'Модель нарушителей');
    FDMEditor.AddFormButton(0, HInstance, 'PHDEF', 'Модель СФЗ', 1, True);
    AddMenuItem(0, 2, 'Модель СФЗ');
    FDMEditor.AddFormButton(-1, 0, '', '', 0, False);
    AddMenuItem(0, 0, '-');
//    FDMEditor.AddFormButton(6, HInstance, 'RECOMENDATIONS', 'Рекомендации', 0, False);
 //    miSGSynthesis:=AddMenuItem(6, 1, 'Рекомендации');
//    miSGSynthesis.Visible:=False;
//    FDMEditor.AddFormButton(5, HInstance, 'PRICE', 'Расчет стоимости', 0, False);
//    AddMenuItem(5, 1, 'Расчет стоимости');
    FDMEditor.AddFormButton(4, HInstance, 'INFO', 'Детальная информация', 0, False);
    AddMenuItem(4, 1, 'Детальная информация');
    FDMEditor.AddFormButton(3, HInstance, 'DATABASE', 'База данных', 0, False);
    AddMenuItem(3, 1, 'База данных');
    FDMEditor.AddFormButton(2, HInstance, 'REPORT', 'Отчет', 0, False);
    AddMenuItem(2, 1, 'Отчет');
    FDMEditor.AddFormButton(1, HInstance, 'CHART', 'Графики', 0, False);
    AddMenuItem(1, 1, 'Графики');
    FDMEditor.AddFormButton(0, HInstance, 'DRAW', 'План объекта', 0, True);
    AddMenuItem(0, 1, 'План объекта');
end;

function TfmDemoSprut.CreateContainer: TDMContainer;
begin
  Result:=TDemoContainer.Create(Self);
end;

procedure TfmDemoSprut.GetDBEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, DataBaseFileNameParam,
  DataBaseFileName: string);
begin
  DocumentProgID:='DMServer.DMDocument';
  ProgID:='SGDB.SafeguardDatabase';
  DataModelAlias:='БД типовых элементов СФЗ';
  DataModelFileExt:='sgb';
  DataBaseFileNameParam:='Safeguard Database';
  DataBaseFileName:='DemoSprut.sgb';
end;

function TfmDemoSprut.GetHelloForm: TForm;
begin
  Result:=TfmDemoHello.Create(Application);
end;

function TfmDemoSprut.GetRegistryKey: string;
begin
  Result:='SOFTWARE\ISTA\SPRUT-DEMO';
end;

procedure TfmDemoSprut.Initialize;
begin
  inherited;
  FAskPassword:=False;
end;

procedure TfmDemoSprut.LoadModuls;
begin
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'План объекта');
    FDMContainer.AddPage(TFMDraw, pnTop, 'fmDraw');        //0
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Графики');
    FDMContainer.AddPage(TFMChart, pnTop, 'fmChart');       //1
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Отчет');
    FDMContainer.AddPage(TDMReport, pnTop, 'fmReport');      //2
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'База данных');
    FDMContainer.AddPage(TFMBrowser, pnTop, 'fmDataBase');     //3
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Детальная информация');
    FDMContainer.AddPage(TDetailsControl, pnTop, 'fmDetails');//4
//    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Расчет стоимости');
//    FDMContainer.AddPage(TPriceControl, pnTop, 'fmPrice');  //5
//    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Выработка рекомендаций');
//    FDMContainer.AddPage(TSGSynthesisControl, pnTop, 'fmSynthes'); //6

    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Модель СФЗ');
    FDMContainer.AddPage(TFMBrowser, pnBottom, 'fmFacility');  //0
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Модель нарушителей');
    FDMContainer.AddPage(TFMBrowser, pnBottom, 'fmAdversaryModel');  //1
//    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Модель боя');
//    FDMContainer.AddPage(TBattleControl, pnBottom, 'fmBattleModel'); //2
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Варианты анализа');
    FDMContainer.AddPage(TFMBrowser, pnBottom, 'fmAnalysis');  //3
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Пространственная модель');
    FDMContainer.AddPage(TDMOpenGL,  pnBottom, 'fm3D');  //4
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Спецификация элементов СФЗ');
    FDMContainer.AddPage(TDMListForm, pnBottom, 'fmList'); //5
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Настройки');
    FDMContainer.AddPage(TFMGrid, pnBottom, 'fmOptions'); //6

//    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Анализ графа маршрутов');
//    FDMContainer.AddPage(TGraphAnalyzer, pnBottom, 'fmGraph'); //7
    FSectorBuilder:=CoSectorBuilder.Create;
end;

procedure TfmDemoSprut.SetFormModes;
begin
  FDMEditor.Form[3, pnTop].Mode:=-1;
  FDMEditor.Form[0, pnBottom].Mode:=1;
  FDMEditor.Form[1, pnBottom].Mode:=2;
  FDMEditor.Form[2, pnBottom].Mode:=3;
end;

end.
