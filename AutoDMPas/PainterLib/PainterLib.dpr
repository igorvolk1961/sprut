library PainterLib;

uses
  ComServ,
  Painter in 'Painter.pas' {Painter: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,

  GetPainterClassObject;

{$R *.tlb}

{$R *.res}

begin
end.
