unit DemoNavigatorFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  fcButton, fcShapeBtn, fcClearPanel, fcButtonGroup, fcImgBtn, fcLabel,
  fcCommon, fcPanel, fcImageForm;

const
  dmrPrev=1;
  dmrMenu=2;
  dmrShow=3;
  dmrNext=4;
  
type
  TfmDemoNavigator = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    Panel:TfcImageForm;

    procedure btPrevClick(Sender: TObject);
    procedure btMenuClick(Sender: TObject);
    procedure btShowClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
  public
    btPrev:TfcShapeBtn;
    btMenu:TfcShapeBtn;
    btShow:TfcShapeBtn;
    btNext:TfcShapeBtn;
  end;

var
  fmDemoNavigator: TfmDemoNavigator;

implementation

{$R *.dfm}

procedure TfmDemoNavigator.btMenuClick(Sender: TObject);
begin
end;

procedure TfmDemoNavigator.btNextClick(Sender: TObject);
begin
end;

procedure TfmDemoNavigator.btPrevClick(Sender: TObject);
begin
end;

procedure TfmDemoNavigator.btShowClick(Sender: TObject);
begin
end;

procedure TfmDemoNavigator.FormCreate(Sender: TObject);
var
  L:integer;
begin
  Panel:=TfcImageForm.Create(Self);
  Panel.Parent:=Self;
  Panel.Align:=alClient;
  L:=0;
  btPrev:=TfcShapeBtn.Create(Self);
  btPrev.Parent:=Self;
  btPrev.Shape:=bsArrow;
  btPrev.Orientation:=soLeft;
  btPrev.OnClick:=btPrevClick;
  btPrev.ModalResult:=dmrPrev;
  btPrev.Top:=8;
  btPrev.Height:=24;
  btPrev.Left:=L;
  btPrev.Width:=28;
  L:=L+btPrev.Width+4;

  btMenu:=TfcShapeBtn.Create(Self);
  btMenu.Parent:=Self;
  btMenu.Shape:=bsArrow;
  btMenu.Orientation:=soUp;
  btMenu.OnClick:=btMenuClick;
  btMenu.ModalResult:=dmrMenu;
  btMenu.Top:=2;
  btMenu.Height:=24;
  btMenu.Left:=L;
  btMenu.Width:=20;
  L:=L+btMenu.Width+4;

  btShow:=TfcShapeBtn.Create(Self);
  btShow.Parent:=Self;
  btShow.Shape:=bsArrow;
  btShow.Orientation:=soRight;
  btShow.OnClick:=btShowClick;
  btShow.ModalResult:=dmrShow;
  btShow.Top:=8;
  btShow.Height:=24;
  btShow.Left:=L;
  btShow.Width:=28+4;
  L:=L+btShow.Width;

  btNext:=TfcShapeBtn.Create(Self);
  btNext.Parent:=Self;
  btNext.Shape:=bsArrow;
  btNext.Orientation:=soRight;
  btNext.OnClick:=btNextClick;
  btNext.ModalResult:=dmrNext;
  btNext.Top:=8;
  btNext.Height:=24;
  btNext.Left:=L;
  btNext.Width:=50;
  L:=L+btNext.Width;

  Width:=L;
end;

end.
