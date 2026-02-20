unit GuardCharacteristicTypeU;

interface
uses
  WarriorAttributeTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TGuardCharacteristicType=class(TWarriorAttributeType, IGuardCharacteristicType)
  protected
    class function  GetClassID:integer; override;
    procedure Initialize; override;
  end;

  TGuardCharacteristicTypes=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU, GuardCharacteristicKindU;

{ TGuardCharacteristicType }

procedure TGuardCharacteristicType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_GuardCharacteristicKind, Self as IDMElement);
end;

class function TGuardCharacteristicType.GetClassID: integer;
begin
  Result:=_GuardCharacteristicType
end;


{ TGuardCharacteristicTypes }

function TGuardCharacteristicTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsGuardCharacteristicType;
end;

class function TGuardCharacteristicTypes.GetElementClass: TDMElementClass;
begin
  Result:=TGuardCharacteristicType;
end;

class function TGuardCharacteristicTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardCharacteristicType;
end;

end.
