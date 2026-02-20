unit SGDBParameterU;
interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TSGDBParameter=class(TDMParameter, ISGDBParameter)
  protected
    class function  GetClassID:integer; override;

    procedure Loaded; override;
  end;

  TSGDBParameters=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation
uses
  SafeguardDatabaseConstU;

{ TSGDBParameter }

class function TSGDBParameter.GetClassID: integer;
begin
  Result:=_SGDBParameter;
end;

procedure TSGDBParameter.Loaded;
var
  aParent:IDMElement;
begin
  inherited;
  if Parent<>nil then begin
    aParent:=Parent;
    Parent:=nil;
    AddParent(aParent);
  end;
end;

{ TSGDBParameters }

function TSGDBParameters.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSGDBParameter;
end;

class function TSGDBParameters.GetElementClass: TDMElementClass;
begin
  Result:=TSGDBParameter;
end;

class function TSGDBParameters.GetElementGUID: TGUID;
begin
  Result:=IID_ISGDBParameter;
end;

end.
