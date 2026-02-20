library SafeguardSynthesisLib;

uses
  ComServ,
  SafeguardSynthesisLib_TLB in 'SafeguardSynthesisLib_TLB.pas' {SafeguardSynthesis: CoClass},
  SafeguardSynthesisU in 'SafeguardSynthesisU.pas',
  RecomendationVariantU in 'RecomendationVariantU.pas',
  EquipmentElementU in 'EquipmentElementU.pas',
  EquipmentVariantU in 'EquipmentVariantU.pas';

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
