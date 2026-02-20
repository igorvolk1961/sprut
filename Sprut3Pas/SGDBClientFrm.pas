unit SGDBClientFrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, DMEditor_TLB, DMServer_TLB, DataModel_TLB, SpatialModelLib_TLB,
  Menus, DMMainFrm, DdeMan, ImgList, Buttons, CustomHelloFrm;

type
  TForm1 = class(TfmDMMain)
    miChangeObjectType: TMenuItem;
    miBuildArea: TMenuItem;
    miMirrorSelected: TMenuItem;
    procedure miChangeObjectTypeClick(Sender: TObject);
    procedure miBuildAreaClick(Sender: TObject);
    procedure miMirrorSelectedClick(Sender: TObject);
    procedure fmDMMainmiCorrectClick(Sender: TObject);
  private
  protected
    procedure LoadModuls; override;
    function GetHelloForm: TfmCustomHello; override;
    procedure AddFormButtons; override;
    procedure SetFormModes; override;
    procedure SetEditorForms;  override;
    procedure GetDMEditorParams(var DocumentProgID, ProgID,
              DataModelAlias, DataModelFileExt,
              AnalyzerProgID:string); override;
    function GetRegistryKey: string; override;
    function GetRegistryApplication:boolean; override;
  public
  end;

var
  Form1: TForm1;

implementation

uses
  LoadModulFrm,  ConfirmationFrm, ChangePasswordFrm, HelloFrm, SgdbLib_TLB,
  DMBrowserU, DMDrawU, DMReportU,
  Variants;

resourcestring
  rsAddRefElement='Создание ссылки на объект';

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
  AddMenuItem(0, 2, 'Редактор изображений');
  AddMenuItem(1, 2, 'Отчет');
  AddMenuItem(0, 1, 'База данных');
end;

procedure TForm1.GetDMEditorParams(var DocumentProgID, ProgID,
  DataModelAlias, DataModelFileExt, AnalyzerProgID: string);
begin
    DocumentProgID:=FCommonLibPath+'SpatialModelLib.dll';
    ProgID:='SGDB.dll';
    DataModelAlias:='Safeguard Database';
    DataModelFileExt:='sgb';
    AnalyzerProgID:='';
end;

function TForm1.GetHelloForm: TfmCustomHello;
begin
  Result:=nil;
end;

procedure TForm1.LoadModuls;
begin
{
  if fmLoadModul<>nil then fmLoadModul.NextModul( 'База данных');
  FDMEditor.AddForm(CLASS_DMBrowserX, pnTop, 'fmDataBase');     //0
  if fmLoadModul<>nil then fmLoadModul.NextModul( 'Редактор изображений');
  FDMEditor.AddForm(Class_DMDrawX, pnTop, 'fmDraw');        //1
  if fmLoadModul<>nil then fmLoadModul.NextModul( 'Отчет');
  FDMEditor.AddForm(Class_DMReportX, pnBottom, 'fmReport');   //0
}
  if fmLoadModul<>nil then fmLoadModul.NextModul( 'База данных');
  FDMContainer.AddPage(TDMBrowser, pnTop, 'fmDataBase');     //0
  if fmLoadModul<>nil then fmLoadModul.NextModul( 'Редактор изображений');
  FDMContainer.AddPage(TDMDraw, pnBottom, 'fmDraw');        //1
  if fmLoadModul<>nil then fmLoadModul.NextModul( 'Отчет');
  FDMContainer.AddPage(TDMReport, pnBottom, 'fmReport');   //0
end;

procedure TForm1.SetEditorForms;
begin
    FDMEditor.FormVisible[0, pnTop]:=True;
    FDMEditor.FormVisible[0, pnBottom]:=False;
//    FDMEditor.ActiveForm:=FDMEditor.Form[0, pnTop];
    FDMEditor.PasswordRequired:=True;
end;

procedure TForm1.SetFormModes;
begin
    FDMEditor.Form[0, pnTop].Mode:=1;
    FDMEditor.Form[0, pnBottom].Mode:=0;
    FDMEditor.Form[1, pnBottom].Mode:=0;
end;

procedure TForm1.miChangeObjectTypeClick(Sender: TObject);
var
  Server:IDataModelServer;
  CurrentElement: IDMElement;

  RefSource, ClassCollection:IDMCollection;
  DMClassCollections:IDMClassCollections;
  Suffix, aName, oName, nName:WideString;

  aElement:IDMElement;
  InstanceClassID:integer;
  aDataModel:IDataModel;
  Document:IDMDocument;
  DMOperationManager:IDMOperationManager;
  aElementU:IUnknown;
  aRefU:IUnknown;
  V:Variant;
//  KeyboardState:TKeyboardState;

  CurrentClassCollections: IDMClassCollections;
begin
  inherited;

  DMClassCollections:=nil;
  RefSource:=nil;
  Suffix:='';

  Server:=FDMEditor.DataModelServer as IDataModelServer;
  Document:=Server.CurrentDocument;
  if (Document.State and dmfFrozen)<>0 then Exit;

  CurrentElement:=Document.Currentelement as IDMElement;
  DMOperationManager:=Document as IDMOperationManager;

  aDataModel:=Document.DataModel as IDataModel;
  CurrentClassCollections:= aDataModel as IDMClassCollections;

  if CurrentClassCollections<>nil then begin
    Suffix:='';
    Server.EventData1:=null;
    Server.EventData2:='';
    Server.EventData3:=-9;
    Server.CallRefDialog(CurrentClassCollections, nil, Suffix, False);
    V:=Server.EventData1;
    if VarIsNull(V) then
      aRefU:=nil
    else
      aRefU:=V;
    if aRefU=nil then Exit;
    aName:=Server.EventData2;
    if trim(aName)='' then Exit;
    InstanceClassID:=_Updating;
    oName := (CurrentElement as IDMElement).Name;
    nName := (aRefU as IDMElement).Name;

    if InstanceClassID<>-1 then begin

      ClassCollection:=(aDataModel as IDMElement).Collection[InstanceClassID];
      DMOperationManager.StartTransaction(nil, leoAdd, rsAddRefElement);
      if aRefU<>nil then begin
        if (Document.SelectionCount=0) then begin
          DMOperationManager._AddElementRef( ClassCollection,
                       nil,
                       nil,
                       oName+'-'+nName, aRefU, ltOneToMany, aElementU, True);
          aElement:=aElementU as IDMElement;
          DMOperationManager.ChangeFieldValue(aElement, 0, True, CurrentElement.ClassID);
          DMOperationManager.ChangeFieldValue(aElement, 1, True, CurrentElement.ID);
        end;
      end;
      DMOperationManager.FinishTransaction(aElementU,
                         nil, leoAdd);
    end;
  end


end;

procedure TForm1.miBuildAreaClick(Sender: TObject);
var
  Server:IDataModelServer;
  SMOperationManager:ISMOperationManager;
begin
  Server:=FDMEditor.DataModelServer as IDataModelServer;
  SMOperationManager:=Server.CurrentDocument as ISMOperationManager;
  SMOperationManager.StartOperation(smoBuildArea);
end;

procedure TForm1.miMirrorSelectedClick(Sender: TObject);
var
  Server:IDataModelServer;
  SMOperationManager:ISMOperationManager;
begin
  Server:=FDMEditor.DataModelServer as IDataModelServer;
  SMOperationManager:=Server.CurrentDocument as ISMOperationManager;
  SMOperationManager.StartOperation(smoMirrorSelected);
end;

procedure TForm1.fmDMMainmiCorrectClick(Sender: TObject);
var
  Server:IDataModelServer;
  DataModelE, MethodArrayValueE:IDMElement;
  Collection:IDMCollection;
  Collection2:IDMCollection2;
  j, XXX:integer;
  DMArray:IDMArray;
  MethodArrayValue:IDMArrayValue;
begin
  Server:=FDMEditor.DataModelServer as IDataModelServer;
  DataModelE:=(Server.CurrentDocument as IDMDocument).DataModel as IDMElement;
  Collection:=DataModelE.Collection[_sgMethodArrayValue];
  Collection2:=Collection as IDMCollection2;
  j:=0;
  while j<Collection.Count do begin
    MethodArrayValueE:=Collection.Item[j];
    if MethodArrayValueE.Parent=nil then  begin
      MethodArrayValueE.Clear;
      Collection2.Delete(j)
    end else begin
      MethodArrayValue:=MethodArrayValueE as IDMArrayValue;
      DMArray:=MethodArrayValue.DMArray;
      if (DMArray<>nil) and
         (MethodArrayValue.DimensionIndex<>-1) then begin
        if (MethodArrayValue.DimensionIndex<DMArray.Dimensions.Count)then
          inc(j)
        else begin
          MethodArrayValueE.Clear;
          Collection2.Delete(j)
        end;
      end else
        inc(j)
    end;
  end;
end;

function TForm1.GetRegistryKey: string;
begin
  Result:='SOFTWARE\ISTA\SPRUT-SGDB';
end;

function TForm1.GetRegistryApplication: boolean;
begin
  Result:=False
end;

end.
