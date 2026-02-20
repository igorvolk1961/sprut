library SectorBuilderLib;

uses
  ComServ,
  SectorBuilderLib_TLB in 'SectorBuilderLib_TLB.pas',
  SectorBuilderU in 'SectorBuilderU.pas' {SectorBuilder: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.tlb}

{$R *.res}

begin
end.
