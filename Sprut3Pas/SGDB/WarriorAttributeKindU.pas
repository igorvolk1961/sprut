unit WarriorAttributeKindU;

interface
uses
  ModelElementKindU, DataModel_TLB, SgdbLib_TLB, DMServer_TLB;

type
  TWarriorAttributeKind=class(TModelElementKind, IWarriorAttributeKind)
  protected
    FParameterValues:IDMCollection;
    FIsDefault:boolean;

// методы интерфейса IDMElement
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    function Get_Field(Index: integer): IDMField; override; safecall;
    function Get_FieldCount: integer;  override; safecall;

// методы интерфейса IWarriorAttributeKind
    function Get_AttributeType: IWarriorAttributeType; safecall;
    function Get_IsDefault:WordBool; safecall;

    property AttributeType:IWarriorAttributeType
            read Get_AttributeType;

// защищенные методы
    procedure Initialize; override;
    function GetParameterValues: IDMCollection; override;
  end;

implementation
uses
  SGDBParameterValueU;

{ TWarriorAttributeKind }

function TWarriorAttributeKind.Get_AttributeType: IWarriorAttributeType;
begin
  Result:=Parent as IWarriorAttributeType;
end;

function TWarriorAttributeKind.GetParameterValues: IDMCollection;
begin
  Result:=FParameterValues;
end;

function TWarriorAttributeKind.Get_Field(Index: integer): IDMField;
var
  Fields:IDMCollection;
begin
  Fields:=GetFields;
  if Fields<>nil then begin
    if Index<Fields.Count then
      Result:=Fields.Item[Index] as IDMField
    else
      Result:=ParameterValues.Item[Index-Fields.Count].Ref as IDMField
  end else
    Result:=ParameterValues.Item[Index].Ref as IDMField
end;

function TWarriorAttributeKind.Get_FieldCount: integer;
var
  Fields:IDMCollection;
begin
  Fields:=GetFields;
  if Fields<>nil then
    Result:=Fields.Count+ParameterValues.Count
  else
    Result:=ParameterValues.Count
end;

function TWarriorAttributeKind.GetFieldValue(Index: integer): OleVariant;
var
  j:integer;
  Parameter:IDMField;
begin
  j:=0;
  while j<ParameterValues.Count do begin
    Parameter:=ParameterValues.Item[j].Ref as IDMField;
    if Parameter.Code=Index then
      Break
    else
      inc(j);
  end;
  if j<ParameterValues.Count then
    Result:=(ParameterValues.Item[j] as IDMParameterValue).Value
  else
    Result:=inherited GetFieldValue(Index)
end;

procedure TWarriorAttributeKind.SetFieldValue(Index: integer;
  Value: OleVariant);
var
  j:integer;
  Parameter:IDMField;
begin
  j:=0;
  while j<ParameterValues.Count do begin
    Parameter:=ParameterValues.Item[j].Ref as IDMField;
    if Parameter.Code=Index then
      Break
    else
      inc(j);
  end;    
  if j<ParameterValues.Count then
    (ParameterValues.Item[j] as IDMParameterValue).Value:=Value
  else
    inherited
end;

procedure TWarriorAttributeKind.Initialize;
begin
  FParameterValues:=DataModel.CreateCollection(_SGDBParameterValue, Self as IDMElement);
  inherited;
end;

function TWarriorAttributeKind.Get_IsDefault: WordBool;
begin
  Result:=FIsDefault;
end;

end.
