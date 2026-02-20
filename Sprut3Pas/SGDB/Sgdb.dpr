library Sgdb;

uses
  ComServ,
  SgdbU in 'SgdbU.pas' {Sgdb: CoClass},
  SafeguardDatabaseConstU in '..\FMCommon\SafeguardDatabaseConstU.pas';

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
