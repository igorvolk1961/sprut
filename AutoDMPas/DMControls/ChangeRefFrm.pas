unit ChangeRefFrm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DataModel_TLB, DMServer_TLB, ExtCtrls, DMEditor_TLB;

type
  TfmChangeRef = class(TForm)
    edKind: TComboBox;
    lKind: TLabel;
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
  private
    FLastKind:integer;
    FKinds:IDMCollection;
    FSubKinds:IDMCollection;
    FElementKind:IDMElement;
    FElementSubKind:IDMElement;
    FDataModel:pointer;

    FDMEditorX:pointer;

    procedure SetKinds(const Value: IDMCollection);
    procedure SetLastKindIndex(const Value: integer);
    function GetDataModel: IDataModel;
    procedure SetDataModel(const Value: IDataModel);

    function  Get_DMEditorX: IDMEditorX; safecall;
    procedure Set_DMEditorX(const Value: IDMEditorX); safecall;
  public
    Suffix:String;
    NextNumber:integer;
    property DataModel:IDataModel read GetDataModel write SetDataModel;
    property Kinds:IDMCollection read FKinds write SetKinds;
    property ElementSubKind:IDMElement read FElementSubKind;
    property LastKindIndex:integer read FLastKind write SetLastKindIndex;
    property DMEditorX: IDMEditorX read Get_DMEditorX write Set_DMEditorX;

    procedure InitSetKindIndexMacros(aKindIndex:integer);
    procedure InitSetSubKindIndexMacros(aSubKindIndex:integer);
  end;

var
  fmChangeRef: TfmChangeRef;

implementation
uses
  MyForms;
  
{$R *.DFM}

procedure TfmChangeRef.edKindChange(Sender: TObject);
var
  j, m, SubKindIndex:integer;
  KindE:IDMElement;
begin
  j:=edKind.ItemIndex;
  if j=-1 then begin
    pSubKind.Visible:=False;
    edSubKind.ItemIndex:=-1;
    edName.Text:=''
  end else begin
    FLastKind:=j;
    FElementKind:=FKinds.Item[j];
    FSubKinds:=FElementKind.SubKinds;
    SubKindIndex:=FElementKind.DefaultSubKindIndex;
    if FSubKinds<>nil then begin
      pSubKind.Visible:=True;
      edSubKind.Items.Clear;

      if FSubKinds.Count>0 then begin
        for m:=0 to FSubKinds.Count-1 do
          edSubKind.Items.AddObject(FSubKinds.Item[m].Name,
                            pointer(FSubKinds.Item[m]));

        lSubKind.Caption:=FSubKinds.ClassAlias[akImenit];
        if (SubKindIndex<>-1) and
           (SubKindIndex<edSubKind.Items.Count) then
          edSubKind.ItemIndex:=SubKindIndex
        else
          edSubKind.ItemIndex:=0;
        edSubKind.OnChange(Sender);
      end;

    end else begin
      pSubKind.Visible:=False;
      edSubKind.Items.Clear;
      edSubKind.ItemIndex:=-1;

      KindE:=IDMElement(pointer(edKind.Items.Objects[j]));
      FElementSubKind:=KindE;
      if Sender<>nil then begin
        edName.Text:=GetDataModel.GetDefaultName(KindE) ;
        edName.Text:=edName.Text+Suffix;
      end;
    end;
  end;
end;

procedure TfmChangeRef.edSubKindChange(Sender: TObject);
var
  j:integer;
begin
  j:=edSubKind.ItemIndex;
  if j=-1 then
    edName.Text:=''
  else begin
    FElementKind.DefaultSubKindIndex:=j;
    FElementSubKind:=FSubKinds.Item[j];
    if Sender<>nil then begin
      edName.Text:=GetDataModel.GetDefaultName(FElementSubKind) ;
      edName.Text:=edName.Text+Suffix;
    end;
  end;
end;

procedure TfmChangeRef.SetKinds(const Value: IDMCollection);
var j:integer;
begin
  if FKinds = Value then begin
    if FLastKind<edKind.Items.Count then
      edKind.ItemIndex:=FLastKind
    else
      edKind.ItemIndex:=0;
    edKind.OnChange(edKind);
  end;
  FKinds := Value;
  edKind.Clear;

  if FKinds.Count=0 then Exit;

  for j:=0 to FKinds.Count-1 do
    edKind.Items.AddObject(FKinds.Item[j].Name, pointer(FKinds.Item[j]));

  if FLastKind<edKind.Items.Count then begin
    edKind.ItemIndex:=FLastKind;
    edKind.OnChange(edKind);
  end;
end;

procedure TfmChangeRef.FormShow(Sender: TObject);
begin
  edKindChange(nil);
  if pName.Visible and
    edName.Visible then
    edName.SetFocus;
  Form_Resize(Sender);
end;

procedure TfmChangeRef.FormDestroy(Sender: TObject);
begin
  FKinds := nil;
  FSubKinds := nil;
  FElementKind := nil;
  FElementSubKind := nil;
end;

procedure TfmChangeRef.SetLastKindIndex(const Value: integer);
begin
  FLastKind:=Value;
  edKind.ItemIndex:=Value;
  edKindChange(edKind);
end;

function TfmChangeRef.GetDataModel: IDataModel;
begin
  Result:=IDataModel(FDataModel)
end;

procedure TfmChangeRef.SetDataModel(const Value: IDataModel);
begin
  FDataModel:=pointer(Value)
end;

procedure TfmChangeRef.InitSetKindIndexMacros(aKindIndex: integer);
begin

end;

procedure TfmChangeRef.InitSetSubKindIndexMacros(aSubKindIndex: integer);
begin

end;

function TfmChangeRef.Get_DMEditorX: IDMEditorX;
begin
  Result:=IDMEditorX(FDMEditorX)
end;

procedure TfmChangeRef.Set_DMEditorX(const Value: IDMEditorX);
begin
  FDMEditorX:=pointer(Value)
end;

end.
