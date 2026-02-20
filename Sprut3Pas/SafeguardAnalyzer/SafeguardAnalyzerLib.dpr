library SafeguardAnalyzerLib;

uses
  ComServ,
  SafeguardAnalyzerLib_TLB in 'SafeguardAnalyzerLib_TLB.pas',
  SafeguardAnalyzerU in 'SafeguardAnalyzerU.pas',
  PathArcU in 'PathArcU.pas',
  GraphBuilderU in 'GraphBuilderU.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,

  GetDataModelClassObject;

{$R *.tlb}

{$R *.res}

begin
end.
