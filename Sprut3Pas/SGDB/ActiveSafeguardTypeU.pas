unit ActiveSafeguardTypeU;
{Типы активных средств защиты}
interface
uses
  DelayElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB, 
  SafeguardElementTypeU;

type
  TActiveSafeguardType=class(TDelayElementType, IActiveSafeguardType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TActiveSafeguardTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TActiveSafeguardType }

procedure TActiveSafeguardType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_ActiveSafeguardKind, Self as IDMElement);
end;

class function TActiveSafeguardType.GetClassID: integer;
begin
  Result:=_ActiveSafeguardType;
end;

{ TActiveSafeguardTypes }

function TActiveSafeguardTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsActiveSafeguardType;
end;

class function TActiveSafeguardTypes.GetElementClass: TDMElementClass;
begin
  Result:=TActiveSafeguardType;
end;

class function TActiveSafeguardTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IActiveSafeguardType;
end;


function TActiveSafeguardTypes.Get_InstanceClassID: Integer;
begin
  Result:=_ActiveSafeguard
end;

end.
