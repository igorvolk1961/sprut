program Spruter;

uses
  Forms,
  HelloFrm in 'HelloFrm.pas' {fmHello},
  AboutFrm in 'AboutFrm.pas' {AboutBox},
  AuthorsFrm in 'AuthorsFrm.pas' {fmAuthors},
  SpruterFrm in 'SpruterFrm.pas' {fmMainSprut},
  SGSynthesisControlU in 'FMControls\SGSynthesisControlU.pas' {SGSynthesisControl},
  DetailsControlU in 'FMControls\DetailsControlU.pas' {DetailsControl},
  GraphAnalyzerU in 'FMControls\GraphAnalyzerU.pas' {GraphAnalyzer},
  PriceControlU in 'FMControls\PriceControlU.pas' {PriceControl},
  BattleControlU in 'FMControls\BattleControlU.pas' {BattleControl},
  DMMainFrm in '..\..\AutoDM\AutoDMPas\DMControls\DMMainFrm.pas' {fmDMMain},
  DMContainerU in '..\..\AutoDM\AutoDMPas\DMControls\DMContainerU.pas' {DMContainer},
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
  OutlookListU in '..\..\AutoDM\AutoDMPas\DMControls\OutlookListU.pas',
  MacrosManagerU in '..\..\AutoDM\AutoDMPas\DMControls\MacrosManagerU.pas',
  FMContainerU in 'FMControls\FMContainerU.pas' {FMContainer},
  AddZoneFrm in 'FMControls\AddZoneFrm.pas' {fmAddZone},
  AddJumpFrm in 'FMControls\AddJumpFrm.pas' {fmAddJump},
  PleaseWaitFrm in '..\..\AutoDM\AutoDMPas\DMControls\PleaseWaitFrm.pas' {fmPleaseWait},
  ErrorsFrm in '..\..\AutoDM\AutoDMPas\DMControls\ErrorsFrm.pas' {fmErrors},
  DMToolBar in '..\..\AutoDM\AutoDMPas\DMControls\DMToolBar.pas',
  RoundXYFrm in '..\..\AutoDM\AutoDMPas\DMControls\RoundXYFrm.pas' {fmRoundXY},
  VDivideVolumeFrm in 'FMControls\VDivideVolumeFrm.pas' {fmVDivideVolume},
  DrawToolsConstU in '..\..\AutoDM\AutoDMPas\DMControls\DrawToolsConstU.pas',
  FMChartU in 'FMControls\FMChartU.pas' {FMChart},
  LinkClass in '..\..\AutoDM\AutoDMPas\DMControls\LinkClass.pas' {fmLinkClass},
  FMListFormU in 'FMControls\FMListFormU.pas' {FMListForm},
  AddBoundaryFrm in 'FMControls\AddBoundaryFrm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '—œ–”“-»—“¿';
  Application.HelpFile := 'SPRUT-ISTA.HLP';
  Application.CreateForm(TfmMainSprut, fmMainSprut);
  Application.Run;
end.
