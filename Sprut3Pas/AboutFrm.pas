unit AboutFrm;

interface

uses SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses
  AuthorsFrm,
  DMMainFrm;

{$R *.dfm}

procedure TAboutBox.Button1Click(Sender: TObject);
begin
  if fmAuthors=nil then
    fmAuthors:=TfmAuthors.Create(Self);
  fmAuthors.ShowModal
end;

procedure TAboutBox.FormShow(Sender: TObject);
var
  A:string;
begin
  A:=TfmDMMain(Owner).GetApplicationVersion;
  Version.Caption:='Версия '+A
end;

end.

