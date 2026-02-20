unit LayerU;

interface
uses
 Classes, Graphics,
 DMElementU, DataModel_TLB, SpatialModelLib_TLB, DMServer_TLB;

type
  TLayer=class(TNamedDMElement, ILayer)
  private
    FCanDelete: WordBool;
    FVisible:WordBool;
    FSelectable:WordBool;
    FColor:integer;
    FStyle:integer;
    FExpand:boolean;
    FLineWidth:integer;
    FKind:integer;

    FSpatialElements:IDMCollection;

    function Get_Color: integer; safecall;
    function Get_Selectable: WordBool; safecall;
    function Get_Style: integer; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_Expand: WordBool; safecall;
    procedure Set_Color(Value: integer); safecall;
    procedure Set_Selectable(Value: WordBool); safecall;
    procedure Set_Style(Value: integer); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure Set_Expand(Value: WordBool); safecall;
    function Get_SpatialElements:IDMCollection; safecall;
    function Get_LineWidth:integer; safecall;
    procedure Set_LineWidth(Value:integer); safecall;
  protected
    procedure Initialize; override;
    procedure _Destroy; override;

    function  GetFieldValue(Code: integer): OleVariant; override;  safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); safecall;
    procedure ClearOp; override; safecall;

    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function  Get_CanDelete: WordBool; safecall;
    procedure Set_CanDelete(Value: WordBool); safecall;
    function Get_Kind: integer; safecall;
    procedure Set_Kind(Value: integer); safecall;

    property Visible:WordBool
      read Get_Visible write Set_Visible;
    property Selectable:WordBool
      read Get_Selectable write Set_Selectable;
    property Color:integer
      read Get_Color write Set_Color;
    property Style:integer
      read Get_Style write Set_Style;
    property SpatialElements:IDMCollection
      read FSpatialElements;
    property Expand:WordBool
      read Get_Expand write Set_Expand;
  end;


  TLayers=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;


implementation
uses
  SpatialModelConstU, SpatialElementU;

var
  FFields:IDMCollection;

{ TLayer }

procedure TLayer.Initialize;
begin
  inherited;
  FSelectable:=True;
  FVisible:=True;
  FColor:=clBlack;
  FStyle:=ord(psInsideFrame);
  FExpand:=True;
  FCanDelete:=True;
  FKind:=0;

  FSpatialElements:=TSpatialElements.Create(Self as IDMElement) as IDMCollection
end;

procedure TLayer._Destroy;
begin
  inherited;
  FSpatialElements:=nil;
end;

function TLayer.Get_Color: integer;
begin
  Result:=FColor
end;

procedure TLayer.Set_Color(Value: integer);
begin
  Set_FieldValue(ord(selColor), Value)
end;

class function TLayer.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TLayer.MakeFields0;
begin
  inherited;
  AddField(rsVisible, '', '', '',
                 fvtBoolean, 1, 0, 0,
                 ord(cselVisible), 0, pkInput);
  AddField(rsSelectable, '', '', '',
                 fvtBoolean, 1, 0, 0,
                 ord(cselSelectable), 0, pkInput);
  AddField(rsColor, '%8x', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(selColor), 0, pkInput);
  AddField(rsStyle, '%d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(selStyle), 0, pkInput);
  AddField(rsExpand, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(selExpand), 0, pkInput);
  AddField(rsLineWidth, '%d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(selLineWidth), 0, pkInput);
  AddField(rsCanDelete, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(selCanDelete), 1, pkOutput);
  AddField(rsLayerKind, '%d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(selKind), 0, pkOutput);
end;

function TLayer.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cselVisible):
    Result:=FVisible;
  ord(cselSelectable):
    Result:=FSelectable;
  ord(selColor):
    Result:=FColor;
  ord(selStyle):
    Result:=FStyle;
  ord(selExpand):
    Result:=FExpand;
  ord(selLineWidth):
    Result:=FLineWidth;
  ord(selCanDelete):
    Result:=FCanDelete;
  ord(selKind):
    Result:=FKind;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TLayer.SetFieldValue_(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(cselVisible):
    FVisible:=Value;
  ord(cselSelectable):
    FSelectable:=Value;
  ord(selColor):
    FColor:=Value;
  ord(selStyle):
    FStyle:=Value;
  ord(selExpand):
    FExpand:=Value;
  ord(selLineWidth):
    FLineWidth:=Value;
  ord(selCanDelete):
    FCanDelete:=Value;
  ord(selKind):
    FKind:=Value;
  else
    inherited;
  end;
end;

function TLayer.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:Result:=FSpatialElements;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

function TLayer.Get_CollectionCount: integer;
begin
  Result:=1
end;

class function TLayer.GetClassID: integer;
begin
  Result:=_Layer
end;

procedure TLayer.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
    case Index of
    0:begin
        aCollectionName:=FSpatialElements.ClassAlias[akImenitM];
        aOperations:=leoDontCopy;
        aRefSource:=nil;
        aClassCollections:=nil;
        aLinkType:=ltOneToMany;
      end;
    else
      inherited
    end;
end;

function TLayer.Get_Selectable: WordBool;
begin
  Result:=FSelectable
end;

function TLayer.Get_Style: integer;
begin
  Result:=FStyle
end;

function TLayer.Get_Visible: WordBool;
begin
  Result:=FVisible
end;

procedure TLayer.Set_Selectable(Value: WordBool);
begin
  Set_FieldValue(ord(selSelectable), Value)
end;

procedure TLayer.Set_Style(Value: integer);
begin
  Set_FieldValue(ord(selStyle), Value)
end;

procedure TLayer.Set_Visible(Value: WordBool);
begin
  Set_FieldValue(ord(selVisible), Value)
end;

function TLayer.Get_Expand: WordBool;
begin
  Result:=FExpand
end;

procedure TLayer.Set_Expand(Value: WordBool);
begin
  FExpand:=Value
end;

function TLayer.Get_SpatialElements: IDMCollection;
begin
  Result:=FSpatialElements
end;

procedure TLayer.ClearOp;
var
  DMOperationManager:IDMOperationManager;
  aCollection:IDMCollection;
  j:integer;
begin
  DMOperationManager:=DataModel.Document as IDMOperationManager;
  aCollection:=TDMCollection.Create(nil) as IDMCollection;
  for j:=0 to FSpatialElements.Count-1 do
    (aCollection as IDMCollection2).Add(FSpatialElements.Item[j]);
  DMOperationManager.DeleteElements(aCollection, False);
  (aCollection as IDMCollection2).Clear
end;

function TLayer.Get_LineWidth: integer;
begin
  Result:=FLineWidth
end;

procedure TLayer.Set_LineWidth(Value: integer);
begin
  Set_FieldValue(ord(selLineWidth), Value)
end;

procedure TLayer.SetFieldValue(Code: integer; Value: OleVariant);
var
  OperationManager:IDMOperationManager;
begin
  if (DataModel=nil) or
     (DataModel.Document=nil) or
     DataModel.IsLoading or
     DataModel.InUndoRedo then

    SetFieldValue_(Code, Value)
  else begin
    OperationManager:=DataModel.Document as IDMOperationManager;
    OperationManager.ChangeFieldValue(
         Self as IDMElement, Code, True, Value);
  end
end;

function TLayer.Get_CanDelete: WordBool;
begin
  Result:=FCanDelete;
end;

procedure TLayer.Set_CanDelete(Value: WordBool);
begin
  FCanDelete:=Value;
end;

function TLayer.Get_Kind: integer;
begin
  Result:=FKind
end;

procedure TLayer.Set_Kind(Value: integer);
begin
  FKind:=Value
end;

{ TLayers }

class function TLayers.GetElementClass: TDMElementClass;
begin
  Result:=TLayer;
end;

function TLayers.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLayer;
end;

class function TLayers.GetElementGUID: TGUID;
begin
  Result:=IID_ILayer;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TLayer.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
