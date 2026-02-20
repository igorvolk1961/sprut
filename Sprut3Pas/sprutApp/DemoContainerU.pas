unit DemoContainerU;
interface
uses
  DMContainerU, ExtCtrls, Dialogs, ImgList, Controls, ComCtrls, Buttons,
  ToolWin, Classes;
type
  TDemoContainer = class(TDMContainer)
    procedure tbSaveDataModelClick(Sender: TObject);
  protected
  end;

implementation

{$R *.dfm}



procedure TDemoContainer.tbSaveDataModelClick(Sender: TObject);
begin
  ShowMessage('Демонстрационная версия пограммы не позволяет сохранять внесенные изменения')
end;

end.
