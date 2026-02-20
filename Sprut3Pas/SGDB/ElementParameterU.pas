unit ElementParameterU;
interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TElementParameter=class(TDMParameter, IElementParameter)
  protected
    class function  GetClassID:integer; override;
    procedure Loaded; override;
  end;

  TElementParameters=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation
uses
  SafeguardDatabaseConstU;

{ TElementParameter }

class function TElementParameter.GetClassID: integer;
begin
  Result:=_ElementParameter;
end;

procedure TElementParameter.Loaded;
begin
  inherited;
  if Parent<>nil then begin
    AddParent(Parent);
    Parent:=nil;
  end;
end;

{ TElementParameters }

function TElementParameters.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsElementParameter;
end;

class function TElementParameters.GetElementClass: TDMElementClass;
begin
  Result:=TElementParameter;
end;

class function TElementParameters.GetElementGUID: TGUID;
begin
  Result:=IID_IElementParameter;
end;

end.
