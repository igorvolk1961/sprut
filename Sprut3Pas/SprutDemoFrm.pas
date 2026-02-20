unit SprutDemoFrm;

interface

uses
  SpruterFrm, DMContainerU, DemoContainerU ;

type
  TfmDemoSprut = class(TfmMainSprut)
  protected
    function CreateContainer:TDMContainer; override;
  end;

var
  fmDemoSprut: TfmDemoSprut;

implementation


{ TfmDemoSprut }

function TfmDemoSprut.CreateContainer: TDMContainer;
begin
  Result:=TDemoContainer.Create(Self);
end;

end.
