program SGDBClient;

uses
  Forms,
  SGDBClientFrm in 'SGDBClientFrm.pas' {Form1},
  DMBrowserU in '..\..\AutoDM\AutoDMPas\DMControls\DMBrowserU.pas',
  DMDrawU in '..\..\AutoDM\AutoDMPas\DMControls\DMDrawU.pas',
  DMContainerU in '..\..\AutoDM\AutoDMPas\DMControls\DMContainerU.pas' {DMContainer};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
