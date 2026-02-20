unit SGDBParameterValueU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TSGDBParameterValue=class(TDMParameterValue, ISGDBParameterValue)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
    procedure Set_Parent(const Value:IDMElement); override;
  end;

  TSGDBParameterValues=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID: TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TSGDBParameterValue }

class function TSGDBParameterValue.GetClassID: integer;
begin
  Result:=_SGDBParameterValue;
end;

procedure TSGDBParameterValue.Initialize;
begin
  inherited;
end;

procedure TSGDBParameterValue.Set_Parent(const Value: IDMElement);
begin
  inherited;
end;

{ TSGDBParameterValues }

class function TSGDBParameterValues.GetElementClass: TDMElementClass;
begin
  Result:=TSGDBParameterValue;
end;

class function TSGDBParameterValues.GetElementGUID: TGUID;
begin
  Result:=IID_ISGDBParameterValue;
end;


function TSGDBParameterValues.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsSGDBParameterValue;
end;

end.
