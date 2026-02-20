unit UpdateTypeU;

interface
uses
  SafeguardElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TUpdateType=class(TSafeguardElementType, IUpdateType)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
  end;

  TUpdateTypes=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TUpdateType }

procedure TUpdateType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_UpdateKind);
end;

class function TUpdateType.GetClassID: integer;
begin
  Result:=_UpdateType
end;

{ TUpdateTypes }

function TUpdateTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsUpdateType;
end;

class function TUpdateTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IUpdateType;
end;

class function TUpdateTypes.GetElementClass: TDMElementClass;
begin
  Result:=TUpdateType;
end;

end.
