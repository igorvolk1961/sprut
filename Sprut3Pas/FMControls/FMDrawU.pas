unit FMDrawU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls, Types, Variants,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DataModel_TLB, DMServer_TLB, SgdbLib_TLB,
  StdVcl, DMDrawU, ImgList, Menus, ExtCtrls, Buttons,
  StdCtrls, Grids, Spin, ComCtrls;

type
  TFMDraw = class(TDMDraw)
  protected
    procedure ShowLayerKinds; override;
  public
  end;

implementation

{$R *.dfm}

{ TFMDrawX }

{ TFMDraw }

procedure TFMDraw.ShowLayerKinds;
var
  Rect:TRect;
  ValueList:IDMCollection;
  ValueList2:IDMCollection2;
  Unk:IUnknown;
  DW, Err:integer;
  Document:IDMDocument;
  OperationManager:IDMOperationManager;
  V:Variant;
  Frmt:string;
  Delimeter:char;
  S:string;
  D:double;
  aLayerE:IDMElement;
  m, OldRow, OldCol:integer;
  DataModelE:IDMElement;
begin
  Document:=(Get_DataModelServer as IDataModelServer).CurrentDocument;
  OperationManager:=Document as IDMOperationManager;
  ValueList:=OperationManager.SourceCollection as IDMCollection;
  ValueList2:=ValueList as IDMCollection2;
  ValueList2.Clear;

  if not cbLayerRef.Enabled then Exit;
  Rect:=sgLayers.CellRect(sgLayers.Col, sgLayers.Row);
  cbLayerRef.Left:=Rect.Left;
  cbLayerRef.Top:=sgLayers.Top+Rect.Top;
  cbLayerRef.Width:=Rect.Right-Rect.Left+2;
  cbLayerRef.Height:=Rect.Bottom-Rect.Top;
  cbLayerRef.Items.Clear;

  DataModelE:=Document.DataModel as IDMElement;
  ValueList:=DataModelE.Ref.Collection[_BoundaryKind];

  cbLayerRef.ItemIndex := -1;
  if ValueList<>nil then
    for m:=0 to ValueList.Count-1 do begin
      Unk:=ValueList.Item[m];
      cbLayerRef.Items.AddObject(ValueList.Item[m].Name, pointer(Unk));
    end;

  aLayerE:=FSpatialModel.Layers.Item[sgLayers.Row-1];
  V:=aLayerE.Ref;
  if VarIsNull(V) or
     VarIsEmpty(V) then
    cbLayerRef.ItemIndex:=-1
  else begin
    Unk:=aLayerE.Ref;
    cbLayerRef.ItemIndex:=cbLayerRef.Items.IndexOfObject(pointer(Unk));
  end;
  cbLayerRef.Visible:=True;
  if Visible then
    cbLayerRef.SetFocus;
end;

end.
