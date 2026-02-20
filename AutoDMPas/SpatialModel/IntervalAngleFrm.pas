unit IntervalAngleFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DrawFrm;

type
  TfmIntervalAngle = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    ed_Interval: TEdit;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IntervalAngleFrmCreate;
    procedure ed_IntervalChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    IntervalFlag: boolean;
    IntervalOld: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmIntervalAngle: TfmIntervalAngle;

implementation

{$R *.dfm}
procedure TfmIntervalAngle.IntervalAngleFrmCreate;
begin
     ed_Interval.Text:='0';
     IntervalFlag := True;
end;
procedure TfmIntervalAngle.Button1Click(Sender: TObject);
begin
  If not IntervalFlag then Exit;
//  fmDraw.FIntervalAngle := StrToInt(ed_Interval.Text);
  Close;
end;

procedure TfmIntervalAngle.Button2Click(Sender: TObject);
begin
   ed_Interval.Text := IntervalOld;
//   If not IntervalFlag then
//     fmDraw.FIntervalAngle := StrToInt(ed_Interval.Text);
   Close;
end;

procedure TfmIntervalAngle.ed_IntervalChange(Sender: TObject);
var
 C:integer;
 Z:double;
begin
  if not ed_Interval.Modified then Exit;
  Val(ed_Interval.Text,Z,C);
  if (C<>0) or (Z<>Z) then begin
      ed_Interval.Font.Color:=clRed;
      IntervalFlag := False;
      Exit;
   end else
      ed_Interval.Font.Color:=clWindowText;
   IntervalFlag := True;
end;

procedure TfmIntervalAngle.FormActivate(Sender: TObject);
begin
   IntervalOld := ed_Interval.Text;
end;

end.
