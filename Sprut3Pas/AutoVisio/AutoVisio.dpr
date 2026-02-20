library AutoVisio;

uses
  ComServ,
  VisioExportU in 'VisioExportU.pas' {VisioExport: CoClass},
  AutoVisio_TLB in 'AutoVisio_TLB.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.tlb}
{$R *.res}

begin
end.
