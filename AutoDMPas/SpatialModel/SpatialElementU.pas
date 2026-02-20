unit SpatialElementU;

interface
uses
  Classes, Graphics,
  DMElementU, CustomSpatialElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, Variants;

type
  TSpatialElement=class(TCustomSpatialElement)
  private
  protected
    function Get_FieldCount_: integer;  override; safecall;
    function Get_Field_(Index: integer): IDMField; override; safecall;
    function  Get_FieldValue_(Index: integer): OleVariant; override; safecall;
    procedure Set_FieldValue_(Index: integer; Value: OleVariant); override; safecall;

    procedure Set_Selected(Value: WordBool); override;

    function  Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure AfterCopyFrom(const SourceElement:IDMElement); override; safecall;
  end;

  TSpatialElements=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;



implementation
uses
  SpatialModelConstU;

{ TSpatialElement }


function TSpatialElement.Get_FieldValue_(Index: integer): OleVariant;
var
  N:integer;
begin
  if (Ref<>nil) then
    N:=Ref.FieldCount
  else
    N:=0;

  if Index>=N then
    Result:=Get_FieldValue(Index-N)
  else
    Result:=Ref.FieldValue[Index]
end;

procedure TSpatialElement.Set_FieldValue_(Index: integer;
  Value: OleVariant);
var
  N:integer;
begin
  if (Ref<>nil) then
    N:=Ref.FieldCount
  else
    N:=0;

  if Index>=N then
    Set_FieldValue(Index-N, Value)
  else
    Ref.FieldValue[Index]:=Value
end;

procedure TSpatialElement.Set_Selected(Value: WordBool);
var
  Painter:IUnknown;
  aDataModel:IDataModel;
  Document:IDMDocument;
begin
  if Selected=Value then Exit;
  inherited;
  if DataModel=nil then Exit;
  if DataModel.InUndoRedo then Exit;
  Document:=DataModel.Document as IDMDocument;
  if Document=nil then begin
    aDataModel:=(DataModel as IDMElement).DataModel;
    if aDataModel=nil then Exit;
    Document:=aDataModel.Document as IDMDocument;
    if Document=nil then Exit;
  end;
  Painter:=(Document as ISMDocument).PainterU;
  if Painter=nil then Exit;
//  Draw(Painter, -1);
  if Ref=nil then begin
    if Get_Selected then
      Draw(Painter, 1)
    else begin
      if (Parent<>nil) and
         not (Parent as ILayer).Visible then
        Draw(Painter, -1)
      else
        Draw(Painter, 0)
    end;
  end else begin
    if Ref=nil then Exit;
    if Ref.SpatialElement<>(Self as IDMElement) then Exit;
    Ref.Selected:=Value;  // метод Set_selected у Ref следует переопределить так,
    if Get_Selected then  // чтобы Ref не заносился в SelectionItems
      Ref.Draw(Painter, 1)
    else
      Ref.Draw(Painter, 0)
  end;
end;

{
procedure TSpatialElement.Clear;
begin
  inherited;
  if (Ref<>nil) and
     (Ref.SpatialElement=Self) then
    Ref.SpatialElement:=nil;
end;
}

function TSpatialElement.Get_Collection(Index: Integer): IDMCollection;
begin
  if (DataModel<>nil) and
     (not DataModel.IsCopying) and
     (not DataModel.InUndoRedo) and
     (not DataModel.IsLoading) and
     (Ref<>nil) then
    Result:=Ref.Get_Collection(Index)
  else
    Result:=inherited Get_Collection(Index)
end;

function TSpatialElement.Get_CollectionCount: integer;
begin
  if (DataModel<>nil) and
     (not DataModel.IsCopying) and
     (not DataModel.InUndoRedo) and
     (not DataModel.IsLoading) and
     (Ref<>nil) then
    Result:=Ref.Get_CollectionCount
  else
    Result:=inherited Get_CollectionCount
end;

procedure TSpatialElement.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  if (DataModel<>nil) and
     (not DataModel.IsCopying) and
     (not DataModel.InUndoRedo) and
     (not DataModel.IsLoading) and
     (Ref<>nil) then
    Ref.GetCollectionProperties(Index, aCollectionName, aRefSource,
                            aClassCollections, aOperations, aLinkType)
  else
    inherited
end;

function TSpatialElement.Get_Field_(Index: integer): IDMField;
var
  N:integer;
begin
  try
  if Index>Get_FieldCount_-1 then begin
    Result:=nil;
    Exit;
  end;
  if (Ref<>nil) then
    N:=Ref.FieldCount
  else
    N:=0;

  if Index>=N then
    Result:=inherited Get_Field(Index-N)
  else
    Result:=Ref.Field[Index]
  except
    raise
  end;
end;

function TSpatialElement.Get_FieldCount_: integer;
begin
  Result:=Get_FieldCount;
  if Ref<>nil then
    Result:=Ref.FieldCount
end;

procedure TSpatialElement.AfterCopyFrom(const SourceElement: IDMElement);
begin
  inherited;
  if Ref<>nil then begin
    if SourceElement<>nil then
      Ref.AfterCopyFrom(SourceElement.Ref)
    else
      Ref.AfterCopyFrom(nil)
  end;
end;

{ TSpatialElements }

function TSpatialElements.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSpatialElements;
end;

class function TSpatialElements.GetElementClass: TDMElementClass;
begin
  Result:=TSpatialElement;
end;

class function TSpatialElements.GetElementGUID: TGUID;
begin
  Result:=IID_ISpatialElement;
end;

end.
