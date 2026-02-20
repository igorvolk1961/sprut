unit CustomSpatialElementU;

interface
uses
  Classes, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, Variants, PainterLib_TLB;

type
  TCustomSpatialElement=class(TDMElement, ISpatialElement)
  private
    FColor:TColor;
    function Get_Layer: ILayer; safecall;
    function Get_Color: integer; safecall;
    procedure Set_Color(Value: integer); virtual; safecall;
    function Get_SpatialModel: ISpatialModel;
  protected
    procedure Initialize; override;

    class procedure MakeFields0; override;

    procedure Set_Parent(const Value: IDMElement); override; safecall;
    procedure Set_Ref(const Value: IDMElement); override;
    procedure AddParent(const aParent:IDMElement); override; safecall;
    procedure RemoveParent(const aParent:IDMElement); override; safecall;

    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); virtual;

//    function  Get_RefDataModel:IDataModel; override;
    procedure Set_Layer(const Value:ILayer); virtual; safecall;

    function  GetCopyLinkMode(const aLink: IDMElement): Integer; override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    function  CheckVisible(const aPainter:IPainter):WordBool; virtual;

    property SpatialModel:ISpatialModel read Get_SpatialModel;
    property Layer:ILayer read Get_Layer write Set_Layer;
    property Color:integer read Get_Color write Set_Color;

  end;

  TCustomSpatialElements=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;



implementation
uses
  SpatialModelConstU;

{ TCustomSpatialElement }

procedure TCustomSpatialElement.Initialize;
var
  Unk:IUnknown;
begin
  try
  inherited;
  if DataModel=nil then Exit;
  if (DataModel as IDMElement).QueryInterface(ISpatialModel, Unk)<>0 then Exit;
  Parent:=SpatialModel.CurrentLayer as IDMElement;
  
  Color:=-1
  except
    raise
  end;  
end;

procedure TCustomSpatialElement.Draw(const aPainter:IUnknown; DrawSelected:integer);
begin
end;

{
function TCustomSpatialElement.Get_RefDataModel: IDataModel;
begin
  Result:= DataModel.Get_RefDataModel
end;
}

function TCustomSpatialElement.CheckVisible(const aPainter:IPainter): WordBool;
begin
  Result:=True;
end;

procedure TCustomSpatialElement.Set_Layer(const Value:ILayer);
begin
  Parent:=Value as IDMElement;
end;

function TCustomSpatialElement.Get_Layer: ILayer;
begin
  Result:=Parent as ILayer
end;

function TCustomSpatialElement.Get_Color: integer;
begin
  Result:=FColor
end;

procedure TCustomSpatialElement.Set_Color(Value: integer);
begin
  Set_FieldValue(ord(speColor), Value)
end;

class procedure TCustomSpatialElement.MakeFields0;
begin
  inherited;
  AddField(rsColor, '%8x', '', '',
           fvtInteger, 0, 0, 0,
           ord(speColor), 0, pkInput);
end;


function TCustomSpatialElement.Get_SpatialModel: ISpatialModel;
begin
  Result:=DataModel as ISpatialModel
end;

procedure TCustomSpatialElement.AddParent(const aParent: IDMElement);
var
  OperationManager:IDMOperationManager;
  OldState:integer;
begin
  if Get_Parents=nil then Exit;
  if Get_Parents.IndexOf(aParent)<>-1 then Exit;
  if (DataModel=nil) or
     (DataModel.Document=nil) or
     DataModel.IsLoading or
     DataModel.InUndoRedo then
    inherited
  else begin
    OldState:=DataModel.State;
    try
//    aDataModel.State:=aDataModel.State or dmfCommiting;
    OperationManager:=DataModel.Document as IDMOperationManager;
    OperationManager.AddElementParent(
           aParent, Self as IDMElement);
    finally
      DataModel.State:=OldState;
    end;
  end;
end;

procedure TCustomSpatialElement.RemoveParent(const aParent: IDMElement);
var
  OperationManager:IDMOperationManager;
  OldState:integer;
begin
  if Get_Parents=nil then Exit;
  if Get_Parents.IndexOf(aParent)=-1 then Exit;
  if (DataModel=nil) or
     (DataModel.Document=nil) or
     DataModel.IsLoading or
     DataModel.IsExecuting or
     DataModel.InUndoRedo then
    inherited
  else begin
    OldState:=DataModel.State;
    try
//    aDataModel.State:=aDataModel.State or dmfCommiting;
    OperationManager:=DataModel.Document as IDMOperationManager;
    OperationManager.RemoveElementParent(
           aParent, Self as IDMElement);
    finally
      DataModel.State:=OldState;
    end;
  end
end;

procedure TCustomSpatialElement.Set_Parent(const Value: IDMElement);
var
  OperationManager:IDMOperationManager;
  OldState:integer;
begin
  if Parent=Value then Exit;
  if (DataModel=nil) or
     (DataModel.Document=nil) or
     DataModel.IsExecuting or
     DataModel.IsLoading or
     DataModel.InUndoRedo then
    inherited
  else begin
    OldState:=DataModel.State;
    try
//    aDataModel.State:=aDataModel.State or dmfCommiting;
    OperationManager:=DataModel.Document as IDMOperationManager;
    OperationManager.ChangeParent(nil, Value, Self as IDMElement);
    finally
      DataModel.State:=OldState;
    end;
  end;
end;

procedure TCustomSpatialElement.Set_Ref(const Value: IDMElement);
var
  OperationManager:IDMOperationManager;
  OldState:integer;
begin
  try
  if BuildIn or
     (DataModel=nil) or
     (DataModel.Document=nil) or
     DataModel.IsExecuting or
     DataModel.IsLoading then
    inherited
  else
  if DataModel.InUndoRedo then begin
    if Ref=Value then Exit;
    if (Ref<>nil) and
       (Ref.SpatialElement=Self as IDMElement) then
      Ref.SpatialElement:=nil;
    inherited;
  end else begin
    if Ref=Value then Exit;
    OldState:=DataModel.State;
    try
//    aDataModel.State:=aDataModel.State or dmfCommiting;
    OperationManager:=DataModel.Document as IDMOperationManager;
    OperationManager.ChangeRef(nil, '', Value, Self as IDMElement);
     finally
      DataModel.State:=OldState;
     end;
  end;
  except
    raise
  end;
end;


procedure TCustomSpatialElement.SetFieldValue(Code: integer; Value: OleVariant);
var
  OperationManager:IDMOperationManager;
  OldState:integer;
begin
  try
  if BuildIn or
     (DataModel=nil) or
     (DataModel.Document=nil) or
     DataModel.IsLoading or
     DataModel.IsExecuting or
     DataModel.InUndoRedo then
    SetFieldValue_(Code, Value)
  else begin
    OldState:=DataModel.State;
    try
//    aDataModel.State:=aDataModel.State or dmfCommiting;
    OperationManager:=DataModel.Document as IDMOperationManager;
    OperationManager.ChangeFieldValue(
         Self as IDMElement, Code, True, Value);
    finally
      DataModel.State:=OldState;
    end;
  end
  except
    raise
  end;
end;

function TCustomSpatialElement.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(speColor):
    Result:=FColor;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;


function TCustomSpatialElement.GetCopyLinkMode(const aLink: IDMElement): Integer;
begin
  Result:=clmNewLink
end;

procedure TCustomSpatialElement.SetFieldValue_(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(speColor):
    FColor:=Value;
  else
    inherited
  end;
end;

{ TCustomSpatialElements }

function TCustomSpatialElements.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSpatialElements;
end;

class function TCustomSpatialElements.GetElementClass: TDMElementClass;
begin
  Result:=TCustomSpatialElement;
end;

class function TCustomSpatialElements.GetElementGUID: TGUID;
begin
  Result:=IID_ISpatialElement;
end;

end.
