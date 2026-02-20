unit AccessControlTypeU;
{Типы средств контроля доступа}
interface
uses
  DetectionElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU; 

type
  TAccessControlType=class(TDetectionElementType, IAccessControlType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
  end;

  TAccessControlTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass: TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TAccessControlType }

procedure TAccessControlType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_AccessControlKind, Self as IDMElement);
end;

class function TAccessControlType.GetClassID: integer;
begin
  Result:=_AccessControlType;
end;

{ TAccessControlTypes }

function TAccessControlTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsAccessControlType;
end;

class function TAccessControlTypes.GetElementClass: TDMElementClass;
begin
  Result:=TAccessControlType;
end;

class function TAccessControlTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IAccessControlType;
end;

function TAccessControlTypes.Get_InstanceClassID: Integer;
begin
  Result:=_AccessControl
end;

end.
