library DMServerLib;

uses
  ComServ,
  DataModelServer in 'DataModelServer.pas' {DataModelServer: CoClass},
  DMOperationU in 'DMOperationU.pas',
  DataModelServerConsts in 'DataModelServerConsts.pas',
  DMTransactionU in 'DMTransactionU.pas',
  DMDocument in 'DMDocument.pas' {DMDocument: CoClass},
  CustomDMDocument in 'CustomDMDocument.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,

  GetDMServerClassObject,
  GetDMDocumentClassObject;

{$R *.tlb}

{$R *.res}

begin
end.
