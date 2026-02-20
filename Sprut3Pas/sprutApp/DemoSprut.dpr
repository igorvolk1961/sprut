program DemoSprut;

uses
  Forms,
  CurrentOptionsFrm in 'CurrentOptionsFrm.pas' {fmCurrentOptions},
  DemoHelloFrm in '..\..\AutoDM\AutoDMPas\DMControls\DemoHelloFrm.pas' {fmDemoHello},
  AboutFrm in 'AboutFrm.pas' {AboutBox},
//  Spruter_TLB in 'Spruter_TLB.pas',
  ExportFrm in 'ExportFrm.pas' {fmExport},
  AuthorsFrm in 'AuthorsFrm.pas' {fmAuthors},
  SelectFrm in 'selectFrm.pas',
  SGSynthesisControlU in 'FMControls\SGSynthesisControlU.pas' {SGSynthesisControl},
  DetailsControlU in 'FMControls\DetailsControlU.pas' {DetailsControl},
  GraphAnalyzerU in 'FMControls\GraphAnalyzerU.pas' {GraphAnalyzer},
  PriceControlU in 'FMControls\PriceControlU.pas' {PriceControl},
  BattleControlU in 'FMControls\BattleControlU.pas' {BattleControl},
  DMMainFrm in '..\..\AutoDM\AutoDMPas\DMControls\DMMainFrm.pas' {fmDMMain},
  DemoContainerU in 'DemoContainerU.pas' {DMContainer},
  DMListFormU in '..\..\AutoDM\AutoDMPas\DMControls\DMListFormU.pas' {DMListForm},
  DMChartU in '..\..\AutoDM\AutoDMPas\DMControls\DMChartU.pas' {DMChart},
  DMDrawU in '..\..\AutoDM\AutoDMPas\DMControls\DMDrawU.pas' {DMDraw},
  DMBrowserU in '..\..\AutoDM\AutoDMPas\DMControls\DMBrowserU.pas' {DMBrowser},
  DMReportU in '..\..\AutoDM\AutoDMPas\DMControls\DMReportU.pas' {DMReport},
  DMTeeChartU in '..\..\AutoDM\AutoDMPas\DMControls\DMTeeChartU.pas' {DMTeeChart},
  FMBrowserU in 'FMControls\FMBrowserU.pas' {FMBrowser},
  DMOpenGLU in '..\..\AutoDM\AutoDMPas\DMControls\DMOpenGLU.pas',
  DMPageU in '..\..\AutoDM\AutoDMPas\DMControls\DMPageU.pas' {DMPage},
  DMOpenGLPainter in '..\..\AutoDM\AutoDMPas\DMControls\DMOpenGLPainter.pas',
  SpruterFrm in 'SpruterFrm.pas' {fmMainSprut},
  DemoSprutFrm in 'DemoSprutFrm.pas' {fmDemoSprut};

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'СПРУТ-ИСТА (Демонстрационная версия для Газпромбанка)';
  Application.HelpFile := 'Spruter.hlp';
  Application.CreateForm(TfmDemoSprut, fmDemoSprut);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TfmAuthors, fmAuthors);
  Application.Run;
end.
