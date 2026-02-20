unit LockTypeU;
//Типы замков
interface
uses
  DelayElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TLockType=class(TDelayElementType, ILockType)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
  end;

  TLockTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID: TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TLockType }

procedure TLockType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_LockKind, Self as IDMElement);
end;

class function TLockType.GetClassID: integer;
begin
  Result:=_LockType
end;

{ TLockTypes }

class function TLockTypes.GetElementClass: TDMElementClass;
begin
  Result:=TLockType;
end;

class function TLockTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ILockType;
end;

function TLockTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLockType;
end;

function TLockTypes.Get_InstanceClassID: Integer;
begin
  Result:=_Lock
end;

end.
