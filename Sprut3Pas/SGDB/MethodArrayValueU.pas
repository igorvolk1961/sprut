unit MethodArrayValueU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TMethodArrayValue=class(TDMArrayValue)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
  end;

  TMethodArrayValues=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SafeguardDatabaseConstU;

{ TMethodArrayValue }

procedure TMethodArrayValue.Initialize;
begin
  inherited;
  FArrayValues:=DataModel.CreateCollection(_sgMethodArrayValue, Self as IDMElement);
end;

class function TMethodArrayValue.GetClassID: integer;
begin
  Result:=_sgMethodArrayValue
end;

{ TMethodArrayValues }

function TMethodArrayValues.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsMethodArrayValue
end;

class function TMethodArrayValues.GetElementClass: TDMElementClass;
begin
  Result:=TMethodArrayValue
end;

class function TMethodArrayValues.GetElementGUID: TGUID;
begin
  Result:=IID_IDMArrayValue
end;

end.
