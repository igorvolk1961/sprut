unit BarrierTypeU;
{Типы физических барьеров}
interface
uses
  DelayElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TBarrierType=class(TDelayElementType, IBarrierType)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
  end;

  TBarrierTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TBarrierType }

procedure TBarrierType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_BarrierKind, Self as IDMElement);
end;

class function TBarrierType.GetClassID: integer;
begin
  Result:=_BarrierType
end;

{ TBarrierTypes }

class function TBarrierTypes.GetElementClass: TDMElementClass;
begin
  Result:=TBarrierType;
end;

class function TBarrierTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IBarrierType;
end;

function TBarrierTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsBarrierType;
end;

function TBarrierTypes.Get_InstanceClassID: Integer;
begin
  Result:=_Barrier
end;

end.
