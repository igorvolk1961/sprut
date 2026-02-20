unit _AddRefFrm;

interface

uses
  DM_Windows,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DataModel_TLB, DMServer_TLB, DMEditor_TLB, ExtCtrls;

type
  Tfm_AddRef = class(TForm)
    edKind: TComboBox;
    lKind: TLabel;
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    lSubKind: TLabel;
    edSubKind: TComboBox;
    Label1: TLabel;
    edClassCollection: TComboBox;
    pName: TPanel;
    lName: TLabel;
    edName: TEdit;
    procedure edKindChange(Sender: TObject);
    procedure edSubKindChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edClassCollectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    FLastClassIndex:integer;
    FLastClass:integer;
    FLastClassCollectionMode:integer;
    FInstanceClassID:integer;
    FClassCollectionMode:integer;
    FClassCollections:IDMClassCollections;
    FKinds:IDMCollection;
    FSubKinds:IDMCollection;
    FElementKind:IDMElement;
    FElementSubKind:IDMElement;
    FDataModel:pointer;

    FDMEditorX:pointer;

    procedure SetKinds(const Value: IDMCollection);
    procedure SetClassCollections(const Value: IDMClassCollections);
    procedure SetClassCollectionMode(const Value: integer);
    procedure SetLastClassIndex(const Value: integer);
    function GetDataModel: IDataModel;
    procedure SetDataModel(const Value: IDataModel);

    function  Get_DMEditorX: IDMEditorX; safecall;
    procedure Set_DMEditorX(const Value: IDMEditorX); safecall;
  public
    Suffix:String;
    NextNumber:integer;
    property DataModel:IDataModel read GetDataModel write SetDataModel;
    property ClassCollectionMode:integer read FClassCollectionMode write SetClassCollectionMode;
    property ClassCollections:IDMClassCollections read FClassCollections write SetClassCollections;
    property ElementSubKind:IDMElement read FElementSubKind;
    property ElementKind:IDMElement read FElementKind;
    property InstanceClassID:integer read FInstanceClassID;
    property LastClassIndex:integer read FLastClassIndex write SetLastClassIndex;
    property DMEditorX: IDMEditorX read Get_DMEditorX write Set_DMEditorX;

    procedure InitSetClassIndexMacros(aClassIndex:integer);
    procedure InitSetKindIndexMacros(aKindIndex:integer);
    procedure InitSetSubKindIndexMacros(aSubKindIndex:integer);
  end;

var
  fm_AddRef: Tfm_AddRef;

implementation
uses
  MyForms;

{$R *.DFM}

procedure Tfm_AddRef.edKindChange(Sender: TObject);
var
  j, m, SubKindIndex:integer;
begin
  j:=edKind.ItemIndex;
  if j=-1 then begin
    lSubKind.Visible:=False;
    edSubKind.Visible:=False;
    edSubKind.ItemIndex:=-1;
    edName.Text:=''
  end else begin
    FClassCollections.DefaultClassCollectionIndex[
                 edClassCollection.ItemIndex,
                 FClassCollectionMode]:=j;
    FElementKind:=FKinds.Item[j];
    FSubKinds:=FElementKind.SubKinds;
    SubKindIndex:=FElementKind.DefaultSubKindIndex;
    if FSubKinds<>nil then begin
      lSubKind.Visible:=True;
      edSubKind.Visible:=True;
      edSubKind.Items.Clear;

      if FSubKinds.Count>0 then begin
        for m:=0 to FSubKinds.Count-1 do
          edSubKind.Items.AddObject(FSubKinds.Item[m].Name,
                            pointer(FSubKinds.Item[m]));

        lSubKind.Caption:=(FSubKinds as IDMCollection3).ClassAlias2[akImenit];
        if SubKindIndex<>-1 then
          edSubKind.ItemIndex:=SubKindIndex
        else
          edSubKind.ItemIndex:=0;
        edSubKind.OnChange(edSubKind);
      end;

    end else begin
      lSubKind.Visible:=False;
      edSubKind.Visible:=False;
      edSubKind.ItemIndex:=-1;

      edName.Text:=GetDataModel.GetDefaultName(FElementKind) ;
      edName.Text:=edName.Text+Suffix;

    end;
  end;
end;

procedure Tfm_AddRef.edSubKindChange(Sender: TObject);
var
  j:integer;
begin
  j:=edSubKind.ItemIndex;
  if j=-1 then
    edName.Text:=''
  else begin
    FElementKind.DefaultSubKindIndex:=j;
    FElementSubKind:=FSubKinds.Item[j];
    edName.Text:=GetDataModel.GetDefaultName(FElementSubKind) ;
    edName.Text:=edName.Text+Suffix;
  end;
end;

procedure Tfm_AddRef.SetKinds(const Value: IDMCollection);
var
  j, ClassCollectionIndex:integer;
begin
  ClassCollectionIndex:=FClassCollections.DefaultClassCollectionIndex[
                 edClassCollection.ItemIndex,
                 FClassCollectionMode];

  if ClassCollectionIndex=-1 then
    ClassCollectionIndex:=0;
    
  if FKinds = Value then begin
    edKind.ItemIndex:=ClassCollectionIndex;
    edKind.OnChange(edKind);
    Exit;
  end;
  FKinds := Value;
  edKind.Clear;

  if FKinds.Count=0 then Exit;
  
  edKind.Visible:=True;

  for j:=0 to FKinds.Count-1 do
    edKind.Items.AddObject(FKinds.Item[j].Name, pointer(FKinds.Item[j]));

  edKind.ItemIndex:=ClassCollectionIndex;
  edKind.OnChange(edKind);
end;

procedure Tfm_AddRef.FormShow(Sender: TObject);
begin
  edClassCollectionChange(edClassCollection);
  if pName.Visible and
    edName.Visible then
    edName.SetFocus;
  Form_Resize(Sender);
end;

procedure Tfm_AddRef.FormDestroy(Sender: TObject);
begin
  FClassCollections := nil;
  FKinds := nil;
  FSubKinds := nil;
  FElementKind := nil;
  FElementSubKind := nil;
end;

procedure Tfm_AddRef.SetClassCollections(const Value: IDMClassCollections);
var
  j:integer;
  Collection:IDMCollection;
begin
  if (FClassCollections = Value) and
     (FClassCollectionMode =FLastClassCollectionMode) then begin
    if FLastClass<edClassCollection.Items.Count then begin
      edClassCollection.ItemIndex:=FLastClass;
      edClassCollection.OnChange(edClassCollection);
    end;
    Exit;
  end;
  FClassCollections := Value;
  edClassCollection.Clear;

  if FClassCollections.ClassCount[FClassCollectionMode]=0 then Exit;

  for j:=0 to FClassCollections.ClassCount[FClassCollectionMode]-1 do begin
    Collection:=FClassCollections.ClassCollection[j, FClassCollectionMode];
    edClassCollection.Items.AddObject((Collection as IDMCollection3).ClassAlias2[akImenitM],
                      pointer(Collection));
  end;

  FLastClass:=-1;
  edClassCollection.ItemIndex:=0;
  edClassCollection.OnChange(edClassCollection);
end;

procedure Tfm_AddRef.edClassCollectionChange(Sender: TObject);
var
  aInstanceSource:IDMInstanceSource;
  j:integer;

  procedure HideAll;
  begin
    lKind.Visible:=False;
    edKind.Visible:=False;
    edKind.ItemIndex:=-1;
    lSubKind.Visible:=False;
    edSubKind.Visible:=False;
    edSubKind.ItemIndex:=-1;
  end;
  procedure ShowAll;
  begin
    lKind.Visible:=True;
    edKind.Visible:=True;
  end;
var
  Collection:IDMCollection;
  aCollection2:IDMCollection2;
  S:string;
begin
  j:=edClassCollection.ItemIndex;
  FLastClass:=j;
  if j=-1 then begin
    HideAll;
    edName.Text:=''
  end else begin
    Collection:=FClassCollections.ClassCollection[j, FClassCollectionMode];
    if (FClassCollectionMode<>-9) then begin
      pName.Visible:=True;
      if DM_Succeeded(Collection.QueryInterface(IDMInstanceSource, aInstanceSource)) then begin
        ShowAll;
        SetKinds(Collection);
        FInstanceClassID:=aInstanceSource.InstanceClassID;
        aCollection2:=(GetDataModel as IDMElement).Collection[FInstanceClassID] as IDMCollection2;
        pName.Visible:=(aCollection2.MakeDefaultName(nil)<>'');
      end else begin
        HideAll;
        S:=(Collection as IDMCollection2).MakeDefaultName(nil);
        if S<>'' then begin
          edName.Text:=S;
          pName.Visible:=True;
        end else
          pName.Visible:=False;
        FElementSubKind := nil;
        FInstanceClassID:=(Collection as IDMCollection2).ClassID;
      end;
    end else begin
      pName.Visible:=False;
      ShowAll;
      SetKinds(Collection);
    end;
  end;
end;

procedure Tfm_AddRef.SetClassCollectionMode(const Value: integer);
begin
  FLastClassCollectionMode:=FClassCollectionMode;
  FClassCollectionMode := Value;
end;

procedure Tfm_AddRef.FormCreate(Sender: TObject);
begin
  FClassCollectionMode:=-1
end;

procedure Tfm_AddRef.SetLastClassIndex(const Value: integer);
begin
  edClassCollection.ItemIndex:=Value;
  edClassCollectionChange(edClassCollection);
end;

function Tfm_AddRef.GetDataModel: IDataModel;
begin
  Result:=IDataModel(FDataModel)
end;

procedure Tfm_AddRef.SetDataModel(const Value: IDataModel);
begin
  FDataModel:=pointer(Value)
end;

procedure Tfm_AddRef.InitSetClassIndexMacros(aClassIndex: integer);
begin
end;

procedure Tfm_AddRef.InitSetKindIndexMacros(aKindIndex: integer);
begin
end;

procedure Tfm_AddRef.InitSetSubKindIndexMacros(aSubKindIndex: integer);
begin
end;

function Tfm_AddRef.Get_DMEditorX: IDMEditorX;
begin
  Result:=IDMEditorX(FDMEditorX)
end;

procedure Tfm_AddRef.Set_DMEditorX(const Value: IDMEditorX);
begin
  FDMEditorX:=pointer(Value)
end;

procedure Tfm_AddRef.btHelpClick(Sender: TObject);
begin
  Application.HelpJump(btHelp.HelpKeyword);
end;

end.
