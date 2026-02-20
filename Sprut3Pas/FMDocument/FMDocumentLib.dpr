library FMDocumentLib;

uses
  ComServ,
  FMDocumentLib_TLB in 'FMDocumentLib_TLB.pas',
  FMDocumentU in 'FMDocumentU.pas' {FMDocument: CoClass},
  BuildReliefFrm in '..\FMControls\BuildReliefFrm.pas' {fmBuildRelief};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,

  GetDMDocumentClassObject;

{$R *.TLB}

{$R *.RES}

begin
end.
