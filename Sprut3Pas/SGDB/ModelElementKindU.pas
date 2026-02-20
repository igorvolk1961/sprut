unit ModelElementKindU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB, DMServer_TLB;

type
  TModelElementKind=class(TNamedDMElement, IModelElementKind)
  private
  protected
    FComment:string;
// методы интерфейса IDMElement
    procedure Set_Parent(const aElement:IDMElement); override; safecall;
    function  GetFieldValue(Code: Integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: Integer; Value: OleVariant); override; safecall;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    procedure _AddBackRef(const aElement:IDMElement); override; safecall;
    procedure _RemoveBackRef(const aElement:IDMElement); override; safecall;
    procedure AfterLoading2; override; safecall;

// защищенные методы
    class procedure MakeFields1; override;

// методы интерфейса IModelElementKind
    function  Get_Comment: WideString; safecall;
    procedure Set_Comment(const Value: WideString); safecall;
    function  Get_ParameterValues: IDMCollection; safecall;

    property Comment: WideString read Get_Comment write Set_Comment;
    property ParameterValues: IDMCollection read Get_ParameterValues;

    procedure Initialize; override;
  end;

implementation
uses
  SafeguardDatabaseConstU;

{ TModelElementKind }

function TModelElementKind.Get_Comment: WideString;
begin
  Result:=FComment
end;

class procedure TModelElementKind.MakeFields1;
begin
  inherited;
  AddField(rsComment, '', '', '',
           fvtText, 0, 0, 0,
           0, 0, pkComment);
end;

procedure TModelElementKind.Set_Comment(const Value: WideString);
begin
  FComment:=Value
end;

function TModelElementKind.GetFieldValue(Code: Integer): OleVariant;
begin
  case Code of
  0:Result:=FComment;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TModelElementKind.SetFieldValue(Code: Integer;
  Value: OleVariant);
begin
  case Code of
  0:
    FComment:=Value;
  else
    inherited;
  end;
end;

function TModelElementKind.Get_ParameterValues: IDMCollection;
begin
  Result:=GetParameterValues
end;

function TModelElementKind.FieldIsVisible(Code:integer): WordBool;
begin
  case Code of
  0: Result:=False
  else
     Result:=inherited FieldIsVisible(Code)
  end;
end;

procedure TModelElementKind._AddBackRef(const aElement: IDMElement);
var
  BackRefHolders2:IDMCollection2;
  BackRefHolderE:IDMElement;
  BackRefHolder:IDMBackRefHolder;
begin
  if aElement.QueryInterface(IDMBackRefHolder, BackRefHolder)=0 then Exit;
  BackRefHolders2:=aElement.DataModel.BackRefHolders as IDMCollection2;
  If BackRefHolders2=nil then exit;
  BackRefHolderE:=BackRefHolders2.GetItemByRef(Self as IDMElement);
  if BackRefHolderE=nil then begin
    BackRefHolderE:=BackRefHolders2.CreateElement(False);
    BackRefHolders2.Add(BackRefHolderE);
    BackRefHolderE.Ref:=Self as IDMElement;
  end;
  BackRefHolder:=BackRefHolderE as IDMBackRefHolder;
  (BackRefHolder.BackRefs as IDMCollection2).Add(aElement)
end;

procedure TModelElementKind._RemoveBackRef(const aElement: IDMElement);
var
  BackRefHolders2:IDMCollection2;
  BackRefHolderE:IDMElement;
  BackRefHolder:IDMBackRefHolder;
begin
  if aElement.QueryInterface(IDMBackRefHolder, BackRefHolder)=0 then Exit;
  BackRefHolders2:=aElement.DataModel.BackRefHolders as IDMCollection2;
  If BackRefHolders2=nil then exit;
  BackRefHolderE:=BackRefHolders2.GetItemByRef(Self as IDMElement);
  BackRefHolder:=BackRefHolderE as IDMBackRefHolder;
  (BackRefHolder.BackRefs as IDMCollection2).Remove(aElement)
end;

procedure TModelElementKind.Initialize;
begin
  inherited;
end;

procedure TModelElementKind.Set_Parent(const aElement: IDMElement);
var
  ModelElementType:IModelElementType;
  j:integer;
  ParameterE:IDMElement;
  ParameterValueU:IUnknown;
  OperationManager:IDMOperationManager;
  SGDBParameterValues:IDMCollection;
begin
  inherited;
  if aElement=nil then Exit;
  if ParameterValues=nil then Exit;
  if DataModel.IsLoading then Exit;
  OperationManager:=DataModel.Document as IDMOperationManager;
  ModelElementType:=Parent as IModelElementType;
  SGDBParameterValues:=(DataModel as ISafeguardDatabase).SGDBParameterValues;
  for j:=0 to ModelElementType.Parameters.Count-1 do begin
    ParameterE:=ModelElementType.Parameters.Item[j];
    OperationManager.AddElementRef(
          Self as  IDMElement, SGDBParameterValues, '',
          ParameterE, ltOneToMany, ParameterValueU, True);
  end;
end;

procedure TModelElementKind.AfterLoading2;
var
  ModelElementType:IModelElementType;
  NP, NV, j:integer;
  ParameterValueE, ParameterE, SelfE:IDMElement;
  ParameterValues, SGDBParameterValues:IDMCollection;
  SGDBParameterValues2:IDMCollection2;
begin
  inherited;
  if Parent=nil then Exit;
  try
  if Parent.QueryInterface(IModelElementType, ModelElementType)<>0 then Exit;
  ParameterValues:=Get_ParameterValues;
  if ParameterValues<>nil then
    NV:=Get_ParameterValues.Count
  else
    NV:=0;
  NP:=ModelElementType.Parameters.Count;
  if NV=NP then Exit;

  SGDBParameterValues:=(DataModel as ISafeguardDatabase).SGDBParameterValues;
  SGDBParameterValues2:=SGDBParameterValues as IDMCollection2;

  while ParameterValues.Count>NP do begin
    ParameterValueE:=ParameterValues.Item[ParameterValues.Count-1];
    ParameterValueE.Clear;
    SGDBParameterValues2.Remove(ParameterValueE);
  end;

  SelfE:=Self as IDMElement;
  for j:=NV to NP-1 do begin
    ParameterE:=ModelElementType.Parameters.Item[j];
    ParameterValueE:=SGDBParameterValues2.CreateElement(False);
    SGDBParameterValues2.Add(ParameterValueE);
    ParameterValueE.Ref:=ParameterE;
    ParameterValueE.Parent:=SelfE;
  end;

  except
    raise
  end;
end;

end.
