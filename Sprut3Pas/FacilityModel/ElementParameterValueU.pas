unit ElementParameterValueU;

interface
uses
  DMElementU, DataModel_TLB, FacilityModelLib_TLB;

type
  TElementParameterValue=class(TDMParameterValue, IElementParameterValue)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
  end;

  TElementParameterValues=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID: TGUID; override;
  end;

implementation

uses
  FacilityModelConstU;

{ TElementParameterValue }

class function TElementParameterValue.GetClassID: integer;
begin
  Result:=_ElementParameterValue;
end;

procedure TElementParameterValue.Initialize;
begin
  inherited;

end;

{ TElementParameterValues }

class function TElementParameterValues.GetElementClass: TDMElementClass;
begin
  Result:=TElementParameterValue;
end;

class function TElementParameterValues.GetElementGUID: TGUID;
begin
  Result:=IID_IElementParameterValue;
end;


function TElementParameterValues.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsElementParameterValue;
end;

end.
