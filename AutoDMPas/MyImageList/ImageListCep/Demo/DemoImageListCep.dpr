program DemoImageListCep;



uses
  Forms,
  UnitMain in 'UnitMain.pas' {Demo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDemo, Demo);
  Application.Run;
end.
