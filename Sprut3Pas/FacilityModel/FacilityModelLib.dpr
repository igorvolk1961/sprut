library FacilityModelLib;

uses
  ComServ,
  FacilityModelU in 'FacilityModelU.pas' {FacilityModel: CoClass},
  CustomFacilityModelU in 'CustomFacilityModelU.pas',
  FacilityElementU in 'FacilityElementU.pas',
  SafeguardElementStateU in 'SafeguardElementStateU.pas',
  SafeguardElementU in 'SafeguardElementU.pas',
  CustomSafeguardElementU in 'CustomSafeguardElementU.pas',
  ZoneStateU in 'ZoneStateU.pas',
  BoundaryLayerU in 'BoundaryLayerU.pas',
  CustomBoundaryU in 'CustomBoundaryU.pas',
  AnalysisVariantU in 'AnalysisVariantU.pas',
  FMErrorU in 'FMErrorU.pas',
  OutstripU in 'OutstripU.pas',
  CriticalPointU in 'CriticalPointU.pas',
  BoundaryU in 'BoundaryU.pas',
  ReorderLinesU in '..\..\..\AutoDM\AutoDMPas\DMCommon\ReorderLinesU.pas',
  RefPathElementU in 'RefPathElementU.pas',
  WarriorPathU in 'WarriorPathU.pas',
  ZoneU in 'ZoneU.pas',
  FacilityModelConstU in '..\FMCommon\FacilityModelConstU.pas',
  WarriorPathElementU in 'WarriorPathElementU.pas';

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

