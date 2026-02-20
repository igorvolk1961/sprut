unit GuardFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  BattleModelLib_TLB, DataModel_TLB,
  Dialogs, StdCtrls;

type
  TfmGuardFrm = class(TForm)
    BtOk: TButton;
    CBTime: TComboBox;
    LTime: TLabel;
    LAlive: TLabel;
    Label4: TLabel;
    LState: TLabel;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FBattleModel: IBattleModel;
    procedure SetBattleModel(const Value: IBattleModel);
    function GetBattleModel: IBattleModel;
  public
    property BattleModel: IBattleModel read GetBattleModel write SetBattleModel;
  end;

var
  fmGuardFrm: TfmGuardFrm;

implementation

{$R *.dfm}

procedure TfmGuardFrm.FormActivate(Sender: TObject);
var i:integer;
begin
    CBTime.Items.Clear;
    for i:=0 to FBattleModel.TimeArrayCount-1 do
      CBTime.Items.Add(FloatToStr(FBattleModel.TimeArray[i]));
end;

function TfmGuardFrm.GetBattleModel: IBattleModel;
begin
  Result:=FBattleModel;
end;

procedure TfmGuardFrm.SetBattleModel(const Value: IBattleModel);
begin
  FBattleModel := Value;
end;

end.
