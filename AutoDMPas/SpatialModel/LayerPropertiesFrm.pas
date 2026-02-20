unit LayerPropertiesFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  DataModel_TLB;

type
  TfmLayerProperties = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    chbExpand: TCheckBox;
    Label2: TLabel;
    edRef: TEdit;
    btDefineRef: TButton;
    btOK: TButton;
    btCcancel: TButton;
    btHelp: TButton;
    procedure btDefineRefClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edRefKeyPress(Sender: TObject; var Key: Char);
  private
    FLayerRef: IDMElement;
    FLayerRefTypes: IDMCollection;
    procedure SetLayerRef(const Value: IDMElement);
    procedure SetLayerRefTypes(const Value: IDMCollection);
  public
    property LayerRef:IDMElement read FLayerRef write SetLayerRef;
    property LayerRefTypes:IDMCollection read FLayerRefTypes write SetLayerRefTypes;
  end;

var
  fmLayerProperties: TfmLayerProperties;

implementation

{$R *.dfm}

procedure TfmLayerProperties.btDefineRefClick(Sender: TObject);
//var
//  aRef:IDMElement;
begin
{  if FCategoryRecord^.Types=nil then Exit;
  if DMTreeGetElementRef(FCategoryRecord^, aRef) then
    LayerRef:=aRef
}
end;

procedure TfmLayerProperties.SetLayerRef(const Value: IDMElement);
begin
  FLayerRef := Value;
  if FLayerRef<>nil then
    edRef.Text:=FLayerRef.Name
  else
    edRef.Text:=''
end;

procedure TfmLayerProperties.FormCreate(Sender: TObject);
begin
{
  GetMem(FCategoryRecord, SizeOf(TCategoryRecord));
  FillChar(FCategoryRecord^, SizeOf(TCategoryRecord), 0);
  FCategoryRecord.ElementClass:=TSpatialElementLayer;
}  
end;

procedure TfmLayerProperties.FormDestroy(Sender: TObject);
begin
//  FreeMem(FCategoryRecord, SizeOf(TCategoryRecord));
end;

procedure TfmLayerProperties.SetLayerRefTypes(const Value: IDMCollection);
begin
{  FLayerRefTypes := Value;
  FCategoryRecord.Types:=Value;
  if Value<>nil then
    FCategoryRecord.TypeClass:=Value.ElementClass
  else
    FCategoryRecord.TypeClass:=nil;
}    
end;

procedure TfmLayerProperties.edRefKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=' ' then
    LayerRef:=nil
end;

end.
