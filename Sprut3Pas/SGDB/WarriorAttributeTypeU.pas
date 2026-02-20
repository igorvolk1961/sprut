unit WarriorAttributeTypeU;

interface
uses
  ModelElementTypeU, DataModel_TLB, SgdbLib_TLB, DMServer_TLB;

type
  TWarriorAttributeType=class(TModelElementType)
  private
    FParents:IDMCollection;
  protected
    function Get_Parents:IDMCollection; override;
    procedure _AddChild(const aChild:IDMElement); override;
    procedure _RemoveChild(const aChild:IDMElement); override;
    procedure Initialize; override;
  end;

implementation

uses
  DMElementU;

{ TWarriorAttributeType }

procedure TWarriorAttributeType._AddChild(const aChild: IDMElement);
var
  j:integer;
  ParameterValueU:IUnknown;
  Unk:IUnknown;
  SGDBParameterValues:IDMCollection;
  OperationManager:IDMOperationManager;
begin
  inherited;
  if ((DataModel.Document as IDMDocument).State and dmfLoading)<>0 then Exit;
  if aChild.QueryInterface(ISGDBParameter, Unk)<>0 then Exit;
  if Parameters=nil then Exit;
  if SubKinds=nil then Exit;

  OperationManager:=DataModel.Document as IDMOperationManager;
  SGDBParameterValues:=(DataModel as ISafeguardDatabase).SGDBParameterValues;
  for j:=0 to SubKinds.Count-1 do
    OperationManager.AddElementRef(
        SubKinds.Item[j], SGDBParameterValues, '',
        aChild, ltOneToMany, ParameterValueU, True);
end;

procedure TWarriorAttributeType._RemoveChild(
  const aChild: IDMElement);
var
  j:integer;
  Unk:IUnknown;
  ParameterValue:IDMElement;
  OperationManager:IDMOperationManager;
  WarriorAttributeKind:IModelElementKind;
begin
  inherited;
  if aChild.QueryInterface(ISGDBParameter, Unk)<>0 then Exit;
  if Parameters=nil then Exit;
  if SubKinds=nil then Exit;

  OperationManager:=DataModel.Document as IDMOperationManager;
  for j:=0 to SubKinds.Count-1 do begin
    WarriorAttributeKind:=SubKinds.Item[j] as IModelElementKind;
    ParameterValue:=(WarriorAttributeKind.ParameterValues as IDMCollection2).GetItemByRef(aChild);
    if ParameterValue<>nil then
      OperationManager.DeleteElement(
         SubKinds.Item[j], nil,
         ltOneToMany, ParameterValue);
  end
end;


procedure TWarriorAttributeType.Initialize;
begin
  inherited;
  FParents:=DataModel.CreateCollection(-1, Self as IDMElement);
end;

function TWarriorAttributeType.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

end.
