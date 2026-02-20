unit PhysicalFieldU;

interface
uses
  Classes,
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TPhysicalField=class(TNamedDMElement, IPhysicalField)
  private
    FParents:IDMCollection;
  protected
    function Get_Parents:IDMCollection; override; safecall;

    class function  GetClassID:integer; override;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TPhysicalFields=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

  PPhysicalFieldValue=^TPhysicalFieldValue;
  TPhysicalFieldValue=record
    Field:pointer;
    Value:double;
  end;

  TPhysicalFieldValues=class(TList)
  private
    function Get_PhysicalFieldValues(Index: integer): PPhysicalFieldValue;
  public
    property PhysicalFieldValues[Index:integer]:PPhysicalFieldValue read Get_PhysicalFieldValues; default;
    procedure FreeValues;
    procedure AddValue(PhysicalField:IPhysicalField);
    procedure RemoveValue(PhysicalField:IPhysicalField);
    procedure ResetValues;
  end;
implementation

uses
  SafeguardDatabaseConstU;

{ TPhysicalField }

procedure TPhysicalField.Initialize;
begin
  inherited;
  FParents:=DataModel.CreateCollection(-1, Self as IDMElement)
end;

procedure TPhysicalField._Destroy;
begin
  inherited;
  FParents:=nil
end;

class function TPhysicalField.GetClassID: integer;
begin
  Result:=_PhysicalField
end;


function TPhysicalField.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

{ TPhysicalFields }

class function TPhysicalFields.GetElementClass: TDMElementClass;
begin
  Result:=TPhysicalField;
end;

class function TPhysicalFields.GetElementGUID: TGUID;
begin
  Result:=IID_IPhysicalField;
end;

function TPhysicalFields.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsPhysicalField;
end;

{ TPhysicalFieldValues }

procedure TPhysicalFieldValues.FreeValues;
var
  j:integer;
  PhysicalFieldValue:PPhysicalFieldValue;
begin
  for j:=0 to Count-1 do begin
    PhysicalFieldValue:=PPhysicalFieldValue(Items[j]);
    FreeMem(PhysicalFieldValue, SizeOf(TPhysicalFieldValue))
  end;
end;

procedure TPhysicalFieldValues.AddValue(PhysicalField:IPhysicalField);
var PhysicalFieldValue:PPhysicalFieldValue;
begin
  GetMem(PhysicalFieldValue, SizeOf(TPhysicalFieldValue));
  PhysicalFieldValue^.Field:=pointer(PhysicalField);
  PhysicalFieldValue^.Value:=0;
  Add(PhysicalFieldValue);
end;

procedure TPhysicalFieldValues.RemoveValue(PhysicalField:IPhysicalField);
var j:integer;
begin
  j:=0;
  while (j<Count) and
        (PhysicalFieldValues[j]^.Field<>pointer(PhysicalField)) do
     inc(j);
  if (j<Count) then begin
    FreeMem(Items[j], SizeOf(TPhysicalFieldValue));
    Delete(j);
  end
end;

procedure TPhysicalFieldValues.ResetValues;
var j:integer;
begin
  for j:=0 to Count-1 do
    PhysicalFieldValues[j]^.Value:=0;
end;

function TPhysicalFieldValues.Get_PhysicalFieldValues(Index: integer): PPhysicalFieldValue;
begin
  Result:=Items[Index]
end;

end.
