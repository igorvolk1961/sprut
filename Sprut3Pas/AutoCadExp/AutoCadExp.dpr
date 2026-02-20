library AutoCadExp;

uses
  ComServ,
  AutoCadExportU in 'AutoCadExportU.pas' {AutoCadExp: CoClass},
  AutoCadExp_TLB in 'AutoCadExp_TLB.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.tlb}
{$R *.res}

begin
end.
