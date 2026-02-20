unit LayerListFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpatialModelLib_TLB, DataModel_TLB, StdCtrls, ExtCtrls;

type
  TfmLayerList = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    lbLayers: TListBox;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLayerList: TfmLayerList;

implementation
uses
  MyForms;

{$R *.dfm}

procedure TfmLayerList.FormShow(Sender: TObject);
begin
  Form_Resize(Sender);
end;

end.
