unit DMCompareFrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, DMEditor_TLB, DMServer_TLB, DataModel_TLB, SpatialModelLib_TLB,
  Menus, DMMainFrm, DdeMan, ImgList, Buttons, DMMainCompareFrm;

type
  TForm1 = class(TfmDMMainCompare)
  private
  protected
    procedure LoadModuls; override;
    function GetHelloForm: TForm; override;
    procedure AddFormButtons; override;
    procedure SetFormModes; override;
    procedure SetEditorForms;  override;
    procedure GetDMEditorParams(var DocumentProgID, ProgID,
              DataModelAlias, DataModelFileExt,
              AnalyzerProgID:string); override;
  public
  end;

var
  Form1: TForm1;

implementation

uses
  LoadModulFrm,  ConfirmationFrm, ChangePasswordFrm,
  DMBrowser2U, DMDrawU, DMReportU,
  Variants;

{$R *.DFM}

procedure TForm1.AddFormButtons;
  function AddMenuItem(aTag, aGroupIndex:integer; const S:string):TMenuItem;
  begin
    Result:=TMenuItem.Create(Self);
    Result.Caption:=S;
    Result.Tag:=aTag;
    Result.AutoCheck:=True;
    Result.GroupIndex:=aGroupIndex;
    if aGroupIndex>0 then
      Result.RadioItem:=True;
    if aGroupIndex=1 then
      Result.OnClick:=miTopPanelViewClick
    else
    if aGroupIndex=2 then
      Result.OnClick:=miBottomPanelViewClick;
    miView.Insert(0,Result);
  end;
begin
  AddMenuItem(0, 2, 'Τΰιλ 2');
  AddMenuItem(0, 1, 'Τΰιλ 1');
end;

procedure TForm1.GetDMEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, AnalyzerProgID: string);
begin
    DocumentProgID:='SpatialModelLib.SMDocument';
    ProgID:='SGDB.SafeguardDatabase';
    DataModelAlias:='Safeguard Database';
    DataModelFileExt:='sgb';
    AnalyzerProgID:='';
end;

function TForm1.GetHelloForm: TForm;
begin
  Result:=nil;
end;

procedure TForm1.LoadModuls;
begin
  if fmLoadModul<>nil then fmLoadModul.NextModul( 'Τΰιλ 1');
  FDMComparator.AddPage(TDMBrowser2, pnTop, 'fmFile1');     //0
  if fmLoadModul<>nil then fmLoadModul.NextModul( 'Τΰιλ 2');
  FDMComparator.AddPage(TDMBrowser2, pnBottom, 'fmFile2');     //0
end;

procedure TForm1.SetEditorForms;
begin
    FDMEditor.FormVisible[0, pnTop]:=True;
    FDMEditor.FormVisible[0, pnBottom]:=True;
    FDMEditor.PasswordRequired:=True;
end;

procedure TForm1.SetFormModes;
begin
    FDMEditor.Form[0, pnTop].Mode:=0;
    FDMEditor.Form[0, pnBottom].Mode:=0;
end;

end.
