library BattleModelLib;

uses
  ComServ,
  BattleModelU in 'BattleModelU.pas',
  BattleUnitU in 'BattleUnitU.pas',
  BattleLineU in 'BattleLineU.pas';

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
