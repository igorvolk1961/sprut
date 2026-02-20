unit SpruterFrm;

interface

{$INCLUDE SprutDef.inc}

uses
  DM_Windows,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DMMainFrm, DdeMan, ImgList, Menus, Buttons, ActiveX, Registry,
  DMServer_TLB, DMEditor_TLB, DataModel_TLB,
  AutoVisio_TLB, AutoCadExp_TLB, SpatialModelLib_TLB,
  SectorBuilderLib_TLB, SgdbLib_TLB, FacilityModelLib_TLB, FMDocumentLib_TLB, PainterLib_TLB,
  ExtCtrls, DMContainerU, CustomHelloFrm;

const
  rsApplicationVersion='2.5.0';
    
type
  TfmMainSprut = class(TfmDMMain)
    miBuildSectors: TMenuItem;
    miSetUndergroundObstacle: TMenuItem;
    miExport: TMenuItem;
    N17: TMenuItem;
    N28: TMenuItem;
    miMakeAnalysisVariants: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    miTutorial: TMenuItem;
    miDatabaseEditor: TMenuItem;
    miBuildPerimeterZone: TMenuItem;
    miMakeUserDefinedPaths: TMenuItem;
    miBuildStair: TMenuItem;
    miShowSingleLayer: TMenuItem;
    N23: TMenuItem;
    miJoinStoreys: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure miSetUndergroundObstacleClick(Sender: TObject);
    procedure miAnalysisClick(Sender: TObject);
    procedure miBuidlGraphClick(Sender: TObject);
    procedure miAnalysis2Click(Sender: TObject);
    procedure miLoadEtalonModelClick(Sender: TObject);
    procedure miSafeguardSynthesisClick(Sender: TObject);
    procedure miBuildAllAnalysisVariantsClick(Sender: TObject);
    procedure miClearResultsClick(Sender: TObject);
    procedure miExportClick(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure miDatabaseEditorClick(Sender: TObject);
    procedure miTutorialClick(Sender: TObject);
    procedure miIntersectSurfaceClick(Sender: TObject);
    procedure miBuildPerimeterZoneClick(Sender: TObject);
    procedure miMakeUserDefinedPathsClick(Sender: TObject);
    procedure miBuildStairClick(Sender: TObject);
    procedure miShowSingleLayerClick(Sender: TObject);
    procedure miJoinStoreysClick(Sender: TObject);
  private
    FEtalonModel:IDataModel;
    FVisioExport:IVisioExport;
    FAutoCadExport:IAutoCadExport;
    miSGSynthesis:TMenuItem;

    function CreateBattleModel:IUnknown;

  protected

    function CreateContainer:TDMContainer; override;
    procedure LoadModuls; override;
    procedure AddFormButtons; override;
    procedure RegisterIcon; override;
    function GetHelloForm: TfmCustomHello; override;
    function GetAboutBoxForm:TForm; override;
    function GetRegistryKey: string; override;
    procedure SetFormModes; override;
    procedure GetDBEditorParams(var DocumentProgID, ProgID,
               DataModelAlias, DataModelFileExt, DataBaseFileNameParam, DataBaseFileName:string); override;
    procedure GetDMEditorParams(var DocumentProgID, ProgID,
              DataModelAlias, DataModelFileExt,
              AnalyzerProgID:string); override;
    procedure Initialize; override;
    procedure SetMenuTags; override;
    function GetApplicationKey: string; override;
    function GetApplicationVersion:string; override;
  end;

var
  fmMainSprut: TfmMainSprut;

implementation

uses
  LoadModulFrm, ExportFrm,  HelloFrm,
  AboutFrm, SpeechEngine, Windows,
  FMBrowserU, FMDrawU, FMChartU, DMReportU, FMGridU, FMListFormU,
  DetailsControlU,
  BattleControlU,
  SelectFrm,
//  DMOpenGLU, SGSynthesisControlU,
  PriceControlU, GraphAnalyzerU,
  BattleModelLib_TLB, SafeguardSynthesisLib_TLB,
  FacilityModelConstU,
  StairBuilderFrm,
  FMContainerU,
  RegistryFrm;

{$R *.dfm}

procedure TfmMainSprut.FormDestroy(Sender: TObject);
begin
  inherited;
  FEtalonModel:=nil;
end;

procedure TfmMainSprut.miSetUndergroundObstacleClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  aFacilityModel:IFacilityModel;
  j, m, N, k:integer;
  BoundaryLayerE, SafeguardElement, SafeguardDatabaseE, SafeguardElementKindE:IDMElement;
  SafeguardElementU:IUnknown;
  BoundaryLayerType:IDMClassCollections;
  BoundaryLayerSU:ISafeguardUnit;
  aCollection:IDMCollection;
  UndergroundObstacles2:IDMCollection2;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  DMOperationManager:=Document as IDMOperationManager;

  aFacilityModel:=Document.DataModel as IFacilityModel;
  SafeguardDatabaseE:=(aFacilityModel as IDMElement).Ref;

  UndergroundObstacles2:=aFacilityModel.UndergroundObstacles as IDMCollection2;
  if fmSelect=nil then
    fmSelect:=TfmSelect.Create(Self);
  fmSelect.lElement.Caption:='Тип основания заграждений (грунта) по умолчанию';
  fmSelect.cbElement.Items.Clear;

  aCollection:=SafeguardDatabaseE.Collection[_UndergroundObstacleKind];
  for j:=0 to aCollection.Count-1 do
    fmSelect.cbElement.Items.Add(aCollection.Item[j].Name);
  fmSelect.cbElement.ItemIndex:=0;

  if fmSelect.ShowModal<>mrOK then Exit;
  j:=fmSelect.cbElement.ItemIndex;
  SafeguardElementKindE:=aCollection.Item[j];

  try
  DMOperationManager.StartTransaction(UndergroundObstacles2, leoAdd, 'Задание типа грунта');
  for j:=0 to aFacilityModel.BoundaryLayers.Count-1 do begin
    BoundaryLayerE:=aFacilityModel.BoundaryLayers.Item[j];
    if BoundaryLayerE.Parent=nil then Exit;
    BoundaryLayerType:=BoundaryLayerE.Ref as IDMClassCollections;
    N:=BoundaryLayerType.ClassCount[0];
    m:=0;
    while m<N do begin
      aCollection:=BoundaryLayerType.ClassCollection[m, 0];
      if aCollection.ClassID=_UndergroundObstacleType then
        Break
      else
        inc(m);
    end;
    if m<N then begin
      BoundaryLayerSU:=BoundaryLayerE as ISafeguardUnit;
      k:=0;
      while k<BoundaryLayerSU.SafeguardElements.Count do begin
        SafeguardElement:=BoundaryLayerSU.SafeguardElements.Item[k];
        if SafeguardElement.ClassID=_UndergroundObstacle then
          Break
        else
          inc(k);
      end;

      if k=BoundaryLayerSU.SafeguardElements.Count then begin
        DMOperationManager.AddElement(BoundaryLayerE,
                      UndergroundObstacles2, '', ltOneToMany, SafeguardElementU, True);
        SafeguardElement:=SafeguardElementU as IDMElement;
        SafeguardElement.Ref:=SafeguardElementKindE;
      end;
    end;
  end;
  except
    (Document.DataModel as IDataModel).HandleError
    ('Error in TfmMainSprut.miSetUndergroundObstacleClick')
  end;
end;

procedure TfmMainSprut.miAnalysisClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  FDMEditor.StartAnalysis(1);
end;

procedure TfmMainSprut.miBuidlGraphClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  FDMEditor.StartAnalysis(0);
end;

procedure TfmMainSprut.miAnalysis2Click(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  FDMEditor.StartAnalysis(-1);
end;

procedure TfmMainSprut.miSafeguardSynthesisClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  SafeguardSynthesis:ISafeguardSynthesis;
  aFacilityModel:IFacilityModel;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  if FEtalonModel=nil then
    miLoadEtalonModelClick(Sender);
  if FEtalonModel=nil then Exit;

  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;

  aFacilityModel:=Document.DataModel as IFacilityModel;

  SafeguardSynthesis:=aFacilityModel.SafeguardSynthesis as ISafeguardSynthesis;

  if not aFacilityModel.FindCriticalPointsFlag then begin
    ShowMessage('Для выработки рекомендаций необходимо'+
                ' предварительно выполнить анализ уязвимости'+
                ' с поиском критических точек обнаружения');
    Exit;            
  end;

  SafeguardSynthesis.EtalonModel:=FEtalonModel;

  if not miSGSynthesis.Checked then begin
    miSGSynthesis.Click;
    miSGSynthesis.Visible:=True
  end;

  FDMEditor.StartAnalysis(-2);
end;

procedure TfmMainSprut.miBuildAllAnalysisVariantsClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  aFacilityModel:IFacilityModel;
  j, m, i, N:integer;
  AdversaryVariants, FacilityStates, AnalysisVariants:IDMCollection;
  AdversaryVariantE, FacilityStateE, AnalysisVariantE:IDMElement;
  AnalysisVariant:IAnalysisVariant;
  DMOperationManager:IDMOperationManager;
  S:string;
  Unk:IUnknown;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  DMOperationManager:=Document as IDMOperationManager;
  aFacilityModel:=Document.DataModel as IFacilityModel;
  if aFacilityModel=nil then Exit;
  AdversaryVariants:=aFacilityModel.AdversaryVariants;
  FacilityStates:=aFacilityModel.FacilityStates;
  AnalysisVariants:=aFacilityModel.AnalysisVariants;
  N:=AnalysisVariants.Count;
  DMOperationManager.StartTransaction(AnalysisVariants, leoAdd, 'Создание вариантов анализа');
  for j:=0 to FacilityStates.Count-1 do begin
    FacilityStateE:=FacilityStates.Item[j];
    for m:=0 to AdversaryVariants.Count-1 do begin
      AdversaryVariantE:=AdversaryVariants.Item[m];
      i:=0;
      while i<N do begin
        AnalysisVariantE:=AnalysisVariants.Item[i];
        AnalysisVariant:=AnalysisVariantE as IAnalysisVariant;
        if (AnalysisVariant.FacilityState=FacilityStateE) and
           (AnalysisVariant.AdversaryVariant=AdversaryVariantE) then Break;
        inc(i);
      end;
      if i=N then begin
        S:=AdversaryVariantE.Name;
        if FacilityStates.Count>1 then
          S:=S+'. '+FacilityStateE.Name;
        DMOperationManager.AddElement(nil, AnalysisVariants, S, ltOneToMany, Unk, True);
        AnalysisVariantE:=Unk as IDMElement;
        DMOperationManager.ChangeFieldValue(Unk, 0, True, FacilityStateE as IUnknown);
        DMOperationManager.ChangeFieldValue(Unk, 1, True, AdversaryVariantE as IUnknown);
      end;
    end;
  end;
  DMOperationManager.FinishTransaction(AdversaryVariantE, AnalysisVariants, leoAdd);
end;

procedure TfmMainSprut.miClearResultsClick(Sender: TObject);
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  FDMEditor.StartAnalysis(3);
end;

procedure TfmMainSprut.miLoadEtalonModelClick(Sender: TObject);
var
  OldDataModelAlias, OldDataModelFileExt:string;
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}

  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;

  OldDataModelAlias:=FDMEditor.DataModelAlias;
  OldDataModelFileExt:=FDMEditor.DataModelFileExt;
  try
    FDMEditor.DataModelAlias:='эталона';
    FDMEditor.DataModelFileExt:='etm';
    if FDMEditor.LoadDataModel('', False) then begin
      Document:=DataModelServer.CurrentDocument;
      FEtalonModel:=Document.DataModel as IDataModel;
      Document.State:=Document.State or dmfAuto;  // запрет вызова DataModel.Clear
      DataModelServer.CloseCurrentDocument;
    end;
  finally
    FDMEditor.DataModelAlias:=OldDataModelAlias;
    FDMEditor.DataModelFileExt:=OldDataModelFileExt;
  end;
end;

procedure TfmMainSprut.miExportClick(Sender: TObject);
var
  DataModel:IDataModel;
  DataModelServer:IDataModelServer;
  SMDocument:ISMDocument;
  Painter:IPainter;
  FileName, FileExt:string;
begin
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  if not ExportDialog.Execute then begin
    DataModelServer.RefreshDocument(rfFast);
    Exit;
  end;
  FileName:=ExportDialog.FileName;
  FileExt:=UpperCase(ExtractFileExt(FileName));

  DataModelServer.RefreshDocument(rfFast);

  DataModel:=FDMEditor.DataModel as IDataModel;
  SMDocument:=DataModelServer.CurrentDocument as ISMDocument;
  Painter:=SMDocument.PainterU as IPainter;

  Screen.Cursor:=crHourGlass;
  try
  case  ExportDialog.FilterIndex of
  1:begin
      if fmExport=nil then
        fmExport:=TfmExport.Create(Self);
      if not fmExport.ShowModal=mrOK then begin
        DataModelServer.RefreshDocument(rfFast);
       Exit;
      end;

      if FileExt='' then
        FileName:=FileName+'.vsd';
      FVisioExport:=CoVisioExport.Create;
      FVisioExport.SpatialModel:=DataModel as IUnknown;
      (FVisioExport as IPainter).ViewU:=Painter.ViewU;
      FVisioExport.Width:=Painter.HWidth;
      case fmExport.RadioGroup1.ItemIndex of
      0:begin
          FVisioExport.Form:=0;
          FVisioExport.Height:=Painter.HHeight
        end;
      1:begin
          FVisioExport.Form:=1;
          FVisioExport.Height:=Painter.VHeight;
        end;
      end;
      FVisioExport.SaveToFile(FileName);
      FVisioExport:=nil;
    end;
  else
    begin
      DataModelServer.RefreshDocument(rfFast);

      if FileExt='' then
        FileName:=FileName+'.dxf';

      FAutoCadExport:=CoAutoCadExport.Create;
      FAutoCadExport.SpatialModel:=DataModel as IUnknown;
      (FAutoCadExport as IPainter).ViewU:=Painter.ViewU;
      FAutoCadExport.SaveToFile(FileName);
      FAutoCadExport:=nil;
    end;
  end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

function TfmMainSprut.GetHelloForm: TfmCustomHello;
begin
  Result:=TfmHello.Create(Application);
end;

function TfmMainSprut.GetRegistryKey: string;
begin
  Result:='SOFTWARE\ISTA\SPRUT-ISTA';
end;

procedure TfmMainSprut.GetDBEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, DataBaseFileNameParam, DataBaseFileName: string);
var
  FilePath:string;
begin
  DocumentProgID:=FCommonLibPath+'DMServerLib.dll';
  ProgID:='SGDB.dll';
  DataModelAlias:='БД типовых элементов системы охраны';
  DataModelFileExt:='sgb';
  DataBaseFileNameParam:='Safeguard Database';
  DataBaseFileName:='Spruter.sgb';
//  DataBaseFileName:='SprutGPB.sgb';
//  DataBaseFileName:='SprutDemo.sgb';
end;

procedure TfmMainSprut.GetDMEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, AnalyzerProgID: string);
begin
  DocumentProgID:='FMDocumentLib.dll';
  ProgID:='FacilityModelLib.dll';
  DataModelAlias:='Объект';
  DataModelFileExt:='spm';
  AnalyzerProgID:='SafeguardAnalyzerLib.dll';
end;

procedure TfmMainSprut.RegisterIcon;
var
  S, S1:string;
  Registry:TRegistry;
begin
  Registry:=TRegistry.Create;
  try
  Registry.RootKey:=HKEY_CLASSES_ROOT;
  Registry.OpenKey('.spm',True);
  S:=Registry.ReadString('');
  if S='' then
    Registry.WriteString('', 'Spruter.SpruterApp')
  else if S<>'Spruter.SpruterApp' then begin
    Registry.DeleteKey(S);
    Registry.WriteString('', 'Spruter.SpruterApp');
  end;
  Registry.CloseKey;

  Registry.OpenKey('Spruter.SpruterApp',True);
  S:=Registry.ReadString('');
  if S<>'SPRUT Model' then
    Registry.WriteString('', 'SPRUT Model');
  Registry.CloseKey;

  Registry.OpenKey('Spruter.SpruterApp\DefaultIcon',True);
  S:=Registry.ReadString('');
  S1:=Application.ExeName + ',0';
  if S<>S1 then
    Registry.WriteString('', S1);
  Registry.CloseKey;


  Registry.OpenKey('Spruter.SpruterApp\shell\open\command',True);
  S:=Registry.ReadString('');
  S1:=Format('"%s"',[Application.ExeName])+ ' "%1"';
  if S<>S1 then
    Registry.WriteString('', S1);
  Registry.CloseKey;


  Registry.OpenKey('Spruter.SpruterApp\shell\open\ddeexec',True);
  S:=Registry.ReadString('');
  S1:='[Open("%1")]';
  if S<>S1 then
    Registry.WriteString('', S1);
  Registry.CloseKey;
  Registry.OpenKey('Spruter.SpruterApp\shell\open\ddeexec\Application',True);
  S:=Registry.ReadString('');
  S1:='Spruter';
  if S<>S1 then
    Registry.WriteString('', S1);
  Registry.CloseKey;

  Registry.OpenKey('Spruter.SpruterApp\shell\open\ddeexec\Topic',True);
  S:=Registry.ReadString('');
  S1:='System';
  if S<>S1 then
    Registry.WriteString('', S1);
  Registry.CloseKey;
  finally
    Registry.Free;
  end;
end;

procedure TfmMainSprut.LoadModuls;
begin
  inherited;
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
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Расчет стоимости');
    FDMContainer.AddPage(TPriceControl, pnTop, 'fmPrice');  //5
(*
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Выработка рекомендаций');
    FDMContainer.AddPage(TSGSynthesisControl, pnTop, 'fmSynthes'); //6
*)
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Модель системы охраны');
    FDMContainer.AddPage(TFMBrowser, pnBottom, 'fmFacility');  //0
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Модель нарушителей');
    FDMContainer.AddPage(TFMBrowser, pnBottom, 'fmAdversaryModel');  //1
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Варианты анализа');
    FDMContainer.AddPage(TFMBrowser, pnBottom, 'fmAnalysis');  //2
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Перечень элементов модели');
    FDMContainer.AddPage(TFMListForm, pnBottom, 'fmList'); //3
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Настройки программы');
    FDMContainer.AddPage(TFMGrid, pnBottom, 'fmOptions'); //4
{
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Модель боя');
    FDMContainer.AddPage(TBattleControl, pnBottom, 'fmBattleModel'); //5
}
(*
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Пространственная модель');
    FDMContainer.AddPage(TDMOpenGL,  pnBottom, 'fm3D');  //6
    if fmLoadModul<>nil then fmLoadModul.NextModul( 'Анализ графа маршрутов');
    FDMContainer.AddPage(TGraphAnalyzer, pnBottom, 'fmGraph'); //7
*)
{
    (FDMEditor.Form[5, pnBottom] as IBattleControlX).BattleModel:=
              CreateBattleModel;
}
end;

procedure TfmMainSprut.AddFormButtons;
begin
(*
    FDMEditor.AddFormButton(7, HInstance, 'GRAPH', 'Анализ графа маршрутов', 1, False);
    AddMenuItem(7, 2, 'Анализ графа маршрутов');
    FDMEditor.AddFormButton(6, HInstance, '3D', '3-мерная модель', 1, False);
    AddMenuItem(6, 2, 'Пространственная модель');
*)
{
    FDMEditor.AddFormButton(5, HInstance, 'BATTLE', 'Модель боя', 1, False);
    AddMenuItem(5, 2, 'Модель боя');
}
    FDMEditor.AddFormButton(4, HInstance, 'TOOLS', 'Настройки', 1, False);
    AddMenuItem(4, 2, 'Настройки');
    FDMEditor.AddFormButton(3, HInstance, 'LIST', 'Перечень элементов модели', 1, False);
    AddMenuItem(3, 2, 'Перечень элементов модели');
    FDMEditor.AddFormButton(2, HInstance, 'VARIANTS', 'Варианты анализа', 1, False);
    AddMenuItem(2, 2, 'Варианты анализа');
    FDMEditor.AddFormButton(1, HInstance, 'THREAT', 'Модель нарушителей', 1, False);
    AddMenuItem(1, 2, 'Модель нарушителей');
    FDMEditor.AddFormButton(0, HInstance, 'PHDEF', 'Модель системы охраны', 1, True);
    AddMenuItem(0, 2, 'Модель системы охраны');
    FDMEditor.AddFormButton(-1, 0, '', '', 0, False);
    AddMenuItem(0, 0, '-');
(*
    FDMEditor.AddFormButton(6, HInstance, 'RECOMENDATIONS', 'Рекомендации', 0, False);
    miSGSynthesis:=AddMenuItem(6, 1, 'Рекомендации');
    miSGSynthesis.Visible:=False;
*)
    FDMEditor.AddFormButton(5, HInstance, 'PRICE', 'Расчет стоимости', 0, False);
    AddMenuItem(5, 1, 'Расчет стоимости');

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

function TfmMainSprut.GetAboutBoxForm: TForm;
begin
  if AboutBox=nil then
    AboutBox:=TAboutBox.Create(Self);
  Result:=AboutBox;
end;

procedure TfmMainSprut.Initialize;
begin
  inherited;
  FAskPassword:=True;
end;

procedure TfmMainSprut.N23Click(Sender: TObject);
var
  si:TStartupInfo;
  pi:TProcessInformation;
  ExeName:array[0..255] of char;
  S:string;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  S:=ExtractFilePath(Application.ExeName)+'SGDBClient.exe';
  StrPCopy(ExeName, S);
    FillChar(si, SizeOf(si), 0);
    si.cb := SizeOf(si);

    // Start the child process.
    if  not DM_CreateProcess( nil, // No module name (use command line).
        ExeName,          // Command line.
        nil,              // Process handle not inheritable.
        nil,              // Thread handle not inheritable.
        FALSE,            // Set handle inheritance to FALSE.
        0,                // No creation flags.
        nil,              // Use parent's environment block.
        nil,              // Use parent's starting directory.
        si,               // Pointer to STARTUPINFO structure.
        pi ) then         // Pointer to PROCESS_INFORMATION structure.
          ShowMessage( 'CreateProcess failed.' );

    // Wait until child process exits.
    DM_WaitForSingleObject( pi.hProcess, INFINITE );

    // Close process and thread handles.
    DM_CloseHandle( pi.hProcess );

    DM_CloseHandle( pi.hThread );

    ShowMessage('Для того, чтобы изменения, сделанные в базе данных, вступили в силу'#13+
                'необходимо перезапустить программу СПРУТ.');
end;

procedure TfmMainSprut.miDatabaseEditorClick(Sender: TObject);
var
  si:TStartupInfo;
  pi:TProcessInformation;
  ExeName:array[0..255] of char;
  S:string;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  S:=ExtractFilePath(Application.ExeName)+'SGDBClient.exe';
  StrPCopy(ExeName, S);
    FillChar(si, SizeOf(si), 0);
    si.cb := SizeOf(si);

    // Start the child process.
//    if  not DM_CreateProcess( nil, // No module name (use command line).
    if  not CreateProcess( nil, // No module name (use command line).
        ExeName,          // Command line.
        nil,              // Process handle not inheritable.
        nil,              // Thread handle not inheritable.
        FALSE,            // Set handle inheritance to FALSE.
        0,                // No creation flags.
        nil,              // Use parent's environment block.
        nil,              // Use parent's starting directory.
        si,               // Pointer to STARTUPINFO structure.
        pi ) then         // Pointer to PROCESS_INFORMATION structure.
          ShowMessage( 'CreateProcess failed.' );

    // Wait until child process exits.
//    DM_WaitForSingleObject( pi.hProcess, INFINITE );
    WaitForSingleObject( pi.hProcess, INFINITE );

    // Close process and thread handles.
    DM_CloseHandle( pi.hProcess );

    DM_CloseHandle( pi.hThread );

    ShowMessage('Для того, чтобы изменения, сделанные в базе данных, вступили в силу'#13+
                'необходимо перезапустить программу СПРУТ.');
end;

procedure TfmMainSprut.miTutorialClick(Sender: TObject);
var
  DMMacrosManager:IDMMacrosManager;
  Path, FileName, LessonsName:string;
  DataModelServer:IDataModelServer;
begin
{$IFDEF Demo}
  DMMacrosManager:=FDMEditor as IDMMacrosManager;
  if DMMacrosManager.SpeechEngine=nil then
   DMMacrosManager.SpeechEngine:=GetSpeechEngine;

  LessonsName:='Lessons.dat';
  Path:=ExtractFilePath(Application.ExeName);
  FileName:=Path+LessonsName;

  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  DataModelServer.InitialDir:=Path+'Demo';

  DMMacrosManager.ShowDemoMenu(FileName);
{$ENDIF}
end;

procedure TfmMainSprut.miIntersectSurfaceClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  VolumeBuilder:IVolumeBuilder;
  aOldCursor:integer;
begin
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  VolumeBuilder:=Document as IVolumeBuilder;
  aOldCursor:=Document.Cursor;
  Screen.Cursor:=crHourGlass;
  try
  VolumeBuilder.IntersectSurface;
  finally
    Screen.Cursor:=aOldCursor;
  end;
end;

procedure TfmMainSprut.miBuildPerimeterZoneClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  FMDocument:IFMDocument;
  aOldCursor:integer;
begin
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  FMDocument:=Document as IFMDocument;
  aOldCursor:=Document.Cursor;
  Screen.Cursor:=crHourGlass;
  try
  FMDocument.BuildPerimeterZone;
  finally
    Screen.Cursor:=aOldCursor;
  end;
end;

procedure TfmMainSprut.SetFormModes;
begin
  FDMEditor.Form[3, pnTop].Mode:=-1;
  FDMEditor.Form[0, pnBottom].Mode:=1;
  FDMEditor.Form[1, pnBottom].Mode:=2;
  FDMEditor.Form[2, pnBottom].Mode:=3;
end;

procedure TfmMainSprut.miMakeUserDefinedPathsClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  aFacilityModel:IFacilityModel;
  j, m, N:integer;
  UserDefinedPaths, AnalysisVariants:IDMCollection;
  DataModelE, UserDefinedPathE, aUserDefinedPathE,
  AnalysisVariantE, aAnalysisVariantE:IDMElement;
  aAnalysisVariant:IAnalysisVariant;
  DMOperationManager:IDMOperationManager;
  S, S0:string;
  Unk:IUnknown;
  TargetE, aTargetE:IDMElement;
  MainGroup:IWarriorGroup;
  UserDefinedPath:IUserDefinedPath;

  function GetTaregt(const UserDefinedPathE:IDMElement):IDMElement;
  var
    WarriorPath:IWarriorPath;
    i:integer;
    WarriorPathElementE:IDMElement;
  begin
    WarriorPath:=UserDefinedPathE as IWarriorPath;
    i:=0;
    WarriorPathElementE:=nil;
    while i<WarriorPath.WarriorPathElements.Count do begin
      WarriorPathElementE:=WarriorPath.WarriorPathElements.Item[i];
      if WarriorPathElementE.Ref.ClassID=_Target then
        Break
      else
        inc(i)
    end;
    if i<WarriorPath.WarriorPathElements.Count then
      Result:=WarriorPathElementE.Ref
    else
      Result:=nil;
  end;
begin
{$IFDEF Demo}
  WriteMacrosMenuEvent(Sender);
{$ENDIF}
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  DMOperationManager:=Document as IDMOperationManager;
  DataModelE:=Document.DataModel as IDMElement;
  aFacilityModel:=DataModelE as IFacilityModel;
  if aFacilityModel=nil then Exit;
  UserDefinedPaths:=DataModelE.Collection[_UserDefinedPath];
  AnalysisVariants:=DataModelE.Collection[_AnalysisVariant];
  N:=UserDefinedPaths.Count;
  DMOperationManager.StartTransaction(UserDefinedPaths, leoAdd, 'Создание маршрутов');
  FDMEditor.SetCursor(ord(crHourGlass));
  try
  for j:=0 to N-1 do begin
    UserDefinedPathE:=UserDefinedPaths.Item[j];
    UserDefinedPath:=UserDefinedPathE as IUserDefinedPath;
    AnalysisVariantE:=UserDefinedPath.AnalysisVariant;
    TargetE:=GetTaregt(UserDefinedPathE);
    if TargetE=nil then Continue;
    S0:=UserDefinedPathE.Name;
    for m:=0 to AnalysisVariants.Count-1 do begin
      aAnalysisVariantE:=AnalysisVariants.Item[m];
      aAnalysisVariant:=aAnalysisVariantE as IAnalysisVariant;
      MainGroup:=aAnalysisVariant.MainGroup;
      if MainGroup=nil then Continue;
      aTargetE:=MainGroup.FinishPoint;
      if TargetE=aTargetE then begin
        S:=S0+'. '+aAnalysisVariantE.Name;
        if (AnalysisVariantE=aAnalysisVariantE) and
           (UserDefinedPathE.SpatialElement=nil) then begin
          if Pos(aAnalysisVariantE.Name, S0)=0 then
            DMOperationManager.RenameElement(UserDefinedPathE, S);
        end else begin
          DMOperationManager.AddElement(nil, UserDefinedPaths, S, ltOneToMany, Unk, True);
          aUserDefinedPathE:=Unk as IDMElement;
          DMOperationManager.PasteToElement(UserDefinedPathE, aUserDefinedPathE, False, True);
          DMOperationManager.ChangeFieldValue(Unk, ord(udpAnalysisVariant),
                                                  True, aAnalysisVariantE);
        end;
      end;
    end;
  end;
  DMOperationManager.FinishTransaction(aUserDefinedPathE, UserDefinedPaths, leoAdd);
  finally
    FDMEditor.RestoreCursor;
  end;
end;

function TfmMainSprut.CreateBattleModel: IUnknown;
var
  aClassFactory:IClassFactory;
  BattleModelE:IDMElement;
begin
  CoGetClassObject(
      CLASS_BattleModel,
      CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER,
      nil, IUnknown, aClassFactory);

  aClassFactory.CreateInstance(nil, IUnknown, Result);
  BattleModelE:=Result as IDMElement;
  BattleModelE.Name:='Battle Model';
end;

procedure TfmMainSprut.miBuildStairClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  StairBuilder:IStairBuilder;
  D:double;
  Err:integer;
  Element:IDMElement;
begin
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  if Document.SelectionCount=0 then Exit;
  Element:=Document.SelectionItem[0] as IDMElement;
  if Element.ClassID<>_Volume then Exit;

  if fmStairBuilder=nil then
    fmStairBuilder:=TfmStairBuilder.Create(Self);
  StairBuilder:=Document.DataModel as IStairBuilder;

  if StairBuilder.StairTurnAngle<0 then
    fmStairBuilder.rgStairClockwise.ItemIndex:=0
  else
    fmStairBuilder.rgStairClockwise.ItemIndex:=1;
  fmStairBuilder.edStairWidth.Text:=Format('%0.2f',[StairBuilder.StairWidth]);

  if fmStairBuilder.ShowModal=mrOK then begin
    if fmStairBuilder.rgStairClockwise.ItemIndex=0 then
      StairBuilder.StairTurnAngle:=-abs(StairBuilder.StairTurnAngle)
    else
    if fmStairBuilder.rgStairClockwise.ItemIndex=1 then
      StairBuilder.StairTurnAngle:=abs(StairBuilder.StairTurnAngle);
    Val(fmStairBuilder.edStairWidth.Text, D, Err);
    if Err=0 then
      StairBuilder.StairWidth:=D;

    StairBuilder.BuildStair;

    DataModelServer.RefreshDocument(rfFast);
  end  else
    DataModelServer.RefreshDocument(rfFast);

end;

function TfmMainSprut.CreateContainer: TDMContainer;
begin
  Result:=TFMContainer.Create(Self, FCommonLibPath);
end;

procedure TfmMainSprut.miShowSingleLayerClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  ShowSingleLayer:boolean;
  j:integer;
  FacilityModel:IFacilityModel;
begin
  ShowSingleLayer:=miShowSingleLayer.Checked;
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  for j:=0 to DataModelServer.DocumentCount-1 do begin
    Document:=DataModelServer.Document[j];
    FacilityModel:=Document.DataModel as IFacilityModel;
    FacilityModel.ShowSingleLayer:=ShowSingleLayer;
  end;
  (FDMContainer as TFMContainer).ShowSingleLayer:=ShowSingleLayer;
end;

procedure TfmMainSprut.SetMenuTags;
begin
  inherited;
  
  miBuildSectors.Tag:=smoBuildSectors;
end;

function TfmMainSprut.GetApplicationKey: string;
begin
  Result:='';
end;

procedure TfmMainSprut.miJoinStoreysClick(Sender: TObject);
var
  DataModelServer:IDataModelServer;
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  FacilityModel:IFacilityModel;
  SafeguardDatabase:ISafeguardDatabase;
  j, m:integer;
  aZone:IZone;
  FacilityModelE, aZoneE, aZoneParent, NewZoneE, BuildingZoneKindE,
  theVolumeE, theZoneE, theZoneParent:IDMElement;
  aZoneKind:IZoneKind;
  aVolume:IVolume;
  aZoneParentType, theZoneParentType:IModelElementType;
  Zones:IDMCollection;
  NewZoneU:IUnknown;
  aArea:IArea;
begin
  DataModelServer:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=DataModelServer.CurrentDocument;
  DMOperationManager:=Document as IDMOperationManager;
  FacilityModel:=Document.DataModel as IFacilityModel;
  FacilityModelE:=FacilityModel as IDMElement;
  SafeguardDatabase:=FacilityModelE.Ref as ISafeguardDatabase;
  BuildingZoneKindE:=SafeguardDatabase.SpecialZoneKinds.Item[skBuilding];
  Zones:=FacilityModel.Zones;
//  DMOperationManager.StartTransaction(Zones, leoAdd, 'Объединение этажей');
  for j:=0 to Zones.Count-1 do begin
    aZoneE:=Zones.Item[j];
    aZoneKind:=aZoneE.Ref as IZoneKind;
    if aZoneKind.SpecialKind<>skRoof then Continue;
    aZone:=aZoneE as IZone;
    if aZone.Zones.Count>0 then Continue;
    aZoneParent:=aZoneE.Parent;
    aZoneParentType:=aZoneParent.Ref.Parent as IModelElementType;
    if aZoneParentType.TypeID=ztClosedZone then Continue;
    aVolume:=aZoneE.SpatialElement as IVolume;
    if aVolume.BottomAreas.Count=0 then Continue;

    for m:=0 to aVolume.BottomAreas.Count-1 do begin
      aArea:=aVolume.BottomAreas.Item[m] as IArea;
      theVolumeE:=aArea.Volume1 as IDMElement;
      if theVolumeE=nil then Continue;
      theZoneE:=theVolumeE.Ref;
      theZoneParent:=theZoneE.Parent;
      theZoneParentType:=aZoneParent.Ref.Parent as IModelElementType;
//      while theZoneParentType.TypeID=ztClosedZone do
    end;
{
    DMOperationManager.AddElement(aZoneParent, Zones, '', ltOneToMany, NewZoneU, True);
    DMOperationManager.ChangeRef(Zones, '',BuildingZoneKindE ,aZoneE);
    DMOperationManager.ChangeParent(Zones, NewZoneU, aZoneE);
}
  end;
end;

function TfmMainSprut.GetApplicationVersion: string;
begin
  Result:=rsApplicationVersion
end;

end.
