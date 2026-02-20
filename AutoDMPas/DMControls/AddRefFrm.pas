unit AddRefFrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DataModel_TLB, DMServer_TLB, ExtCtrls, DMEditor_TLB;

type
  TfmAddRef = class(TForm)
    Panel1: TPanel;
    lKind: TLabel;
    edKind: TComboBox;
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    pName: TPanel;
    lName: TLabel;
    edName: TEdit;
    pSubKind: TPanel;
    lSubKind: TLabel;
    edSubKind: TComboBox;
    procedure edKindChange(Sender: TObject);
    procedure edSubKindChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject); virtual;
  private
    FLastKind:integer;
    FKinds:IDMCollection;
    FDataModel:pointer;
    FClassCollections:IDMClassCollections;
    FClassIndex:integer;
    FDefaultSubKindIndex:integer;

    FDMEditorX:pointer;

    procedure SetKinds(const Value: IDMCollection);

    function  Get_DMEditorX: IDMEditorX; safecall;
    procedure Set_DMEditorX(const Value: IDMEditorX); safecall;
    function Get_DefaultName: string;
    procedure Set_DefaultName(const Value: string);
  protected
    FElementKind:IDMElement;
    FElementSubKind:IDMElement;
    FSubKinds:IDMCollection;
    function GetDataModel: IDataModel;
    procedure SetDataModel(const Value: IDataModel);
    procedure FillSubKinds; virtual;
  public
    Suffix:String;
    NextNumber:integer;
    property DataModel:IDataModel read GetDataModel write SetDataModel;
    property Kinds:IDMCollection read FKinds write SetKinds;
    property ElementSubKind:IDMElement read FElementSubKind;
    property DMEditorX: IDMEditorX read Get_DMEditorX write Set_DMEditorX;
    property DefaultName: string read Get_DefaultName write Set_DefaultName;
    property LastKind:integer read FLastKind write FLastKind;
    property DefaultSubKindIndex:integer read FDefaultSubKindIndex write FDefaultSubKindIndex;

    procedure InitSetKindIndexMacros(aKindIndex:integer);
    procedure InitSetSubKindIndexMacros(aSubKindIndex:integer);
  end;

var
  fmAddRef: TfmAddRef;

implementation
uses
  MyForms;

{$R *.DFM}

procedure TfmAddRef.FillSubKinds;
var
  m:integer;
begin
  for m:=0 to FSubKinds.Count-1 do
    edSubKind.Items.AddObject(FSubKinds.Item[m].Name,
                      pointer(FSubKinds.Item[m]));
end;

procedure TfmAddRef.edKindChange(Sender: TObject);
var
  j, SubKindIndex:integer;
  KindE:IDMElement;
begin
  j:=edKind.ItemIndex;
  if j=-1 then begin
    pSubKind.Visible:=False;
    edSubKind.ItemIndex:=-1;
    edName.Text:=''
  end else begin
    if FClassCollections<>nil then
      FClassCollections.DefaultClassCollectionIndex[FClassIndex, -1]:=j
    else
      FLastKind:=j;
    FElementKind:=FKinds.Item[j];
    FSubKinds:=FElementKind.SubKinds;
    if DefaultSubKindIndex=-1 then
      SubKindIndex:=FElementKind.DefaultSubKindIndex
    else
      SubKindIndex:=DefaultSubKindIndex;

    if FSubKinds<>nil then begin
      pSubKind.Visible:=True;
      edSubKind.Items.Clear;

      if FSubKinds.Count>0 then begin
        FillSubKinds;
        
        lSubKind.Caption:=(FSubKinds as IDMCollection3).ClassAlias2[akImenit];
        if (SubKindIndex<>-1) and
           (SubKindIndex<edSubKind.Items.Count) then
          edSubKind.ItemIndex:=SubKindIndex
        else
          edSubKind.ItemIndex:=0;
        edSubKind.OnChange(edSubKind);
      end;

    end else begin
      pSubKind.Visible:=False;
      edSubKind.Items.Clear;
      edSubKind.ItemIndex:=-1;

      KindE:=IDMElement(pointer(edKind.Items.Objects[j]));
      FElementSubKind:=KindE;
      edName.Text:=GetDataModel.GetDefaultName(KindE) ;
      edName.Text:=edName.Text+Suffix;
    end;
  end;
end;

procedure TfmAddRef.edSubKindChange(Sender: TObject);
var
  j:integer;
begin
  j:=edSubKind.ItemIndex;
  if j=-1 then
    edName.Text:=''
  else begin
    FElementKind.DefaultSubKindIndex:=j;
    FElementSubKind:=IDMELement(pointer(edSubKind.Items.Objects[j]));
    edName.Text:=GetDataModel.GetDefaultName(FElementSubKind) ;
    edName.Text:=edName.Text+Suffix;
  end;
end;

procedure TfmAddRef.SetKinds(const Value: IDMCollection);
var
  j, ClassCollectionIndex:integer;
  DataModel:IDataModel;
begin
  DataModel:=GetDataModel;
  DataModel.QueryInterface(IDMClassCollections, FClassCollections);
  if FClassCollections<>nil then begin
    FClassIndex:=Value.ClassID;
    ClassCollectionIndex:=FClassCollections.DefaultClassCollectionIndex[FClassIndex, -1];
  end else
    ClassCollectionIndex:=FLastKind;

  if FKinds <> Value then begin
    FKinds := Value;
    edKind.Clear;

    if FKinds.Count=0 then Exit;

    for j:=0 to FKinds.Count-1 do
      edKind.Items.AddObject(FKinds.Item[j].Name, pointer(FKinds.Item[j]));
  end;

  if (ClassCollectionIndex<0) or
     (ClassCollectionIndex>edKind.Items.Count-1) then
    ClassCollectionIndex:=0;

  edKind.ItemIndex:=ClassCollectionIndex;
  edKind.OnChange(edKind);
end;

procedure TfmAddRef.FormShow(Sender: TObject);
begin
  edKindChange(edKind);
  if pName.Visible and
    edName.Visible then
    edName.SetFocus;
  Form_Resize(Sender);
end;

procedure TfmAddRef.FormDestroy(Sender: TObject);
begin
  FKinds := nil;
  FSubKinds := nil;
  FElementKind := nil;
  FElementSubKind := nil;
  FClassCollections := nil;
end;

function TfmAddRef.GetDataModel: IDataModel;
begin
  Result:=IDataModel(FDataModel)
end;

procedure TfmAddRef.SetDataModel(const Value: IDataModel);
begin
  FDataModel:=pointer(Value)
end;

procedure TfmAddRef.InitSetKindIndexMacros(aKindIndex: integer);
begin

end;

procedure TfmAddRef.InitSetSubKindIndexMacros(aSubKindIndex: integer);
begin

end;

function TfmAddRef.Get_DMEditorX: IDMEditorX;
begin
  Result:=IDMEditorX(FDMEditorX)
end;

procedure TfmAddRef.Set_DMEditorX(const Value: IDMEditorX);
begin
  FDMEditorX:=pointer(Value)
end;

function TfmAddRef.Get_DefaultName: string;
begin
  Result:=edName.Text;
end;

procedure TfmAddRef.Set_DefaultName(const Value: string);
begin
  if Value<>'' then begin
    pName.Visible:=True;
    edName.Text:=Value
  end else
    pName.Visible:=False;
end;

procedure TfmAddRef.FormCreate(Sender: TObject);
begin
  FDefaultSubKindIndex:=-1
end;

procedure TfmAddRef.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
