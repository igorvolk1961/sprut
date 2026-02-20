library DMEditor;

uses
  ComServ,
//  DMEditorImpl1 in 'DMEditorImpl1.pas' {DMEditorX: TActiveForm} {DMEditorX: CoClass},
  DMContainerU in 'DMContainerU.pas' {DMEditorX: TActiveForm} {DMEditorX: CoClass},
  DMToolBar in 'DMToolBar.pas',
  _AddRefFrm in '_AddRefFrm.pas' {fm_AddRef},
  AddRefFrm in 'AddRefFrm.pas' {fmAddRef},
  IntegerInputFrm in 'IntegerInputFrm.pas' {fmIntegerInput},
  ConfirmationFrm in 'ConfirmationFrm.pas' {fmConfirmation},
  DMEditor_TLB in 'DMEditor_TLB.pas',
  DMMenu in 'DMMenu.pas',
  DemoNavigatorFrm in 'DemoNavigatorFrm.pas' {fmDemoNavigator},
  DemoMenuFrm in 'DemoMenuFrm.pas' {fmDemoMenu},
  DemoOptionsFrm in 'DemoOptionsFrm.pas' {fmDemoOptions};

{$E ocx}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.