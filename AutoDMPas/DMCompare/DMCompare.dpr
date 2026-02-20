program DMCompare;

uses
  Forms,
  DMCompareFrm in 'DMCompareFrm.pas' {Form1},
  DMBrowser2U in 'DMBrowser2U.pas' {DMBrowser2},
  DMComparatorU in 'DMComparatorU.pas' {DMComparator},
  DMBrowserU in '..\DMControls\DMBrowserU.pas' {DMBrowser},
  DMElementU in '..\DataModelPackage\DMElementU.pas',
  MyDB in '..\DataModelPackage\MyDB.pas',
  DataModelU in '..\DataModelPackage\DataModelU.pas',
  LoadProgressFrm in '..\DataModelPackage\LoadProgressFrm.pas' {fmLoadProgress};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDMBrowser, DMBrowser);
  Application.CreateForm(TfmLoadProgress, fmLoadProgress);
  Application.Run;
end.
