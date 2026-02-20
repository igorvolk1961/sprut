unit VehicleTypeU;
interface
uses
  WarriorAttributeTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TVehicleType=class(TWarriorAttributeType, IVehicleType)
  private
    FTypeCode:integer;

  protected
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;

    function Get_TypeCode: integer; safecall;

    property TypeCode:integer
      read Get_TypeCode;
    procedure Initialize; override;
  end;

  TVehicleTypes=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU, VehicleKindU;

var
  FFields:IDMCollection;

{ TVehicleType }

procedure TVehicleType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_VehicleKind, Self as IDMElement);
end;

class function TVehicleType.GetClassID: integer;
begin
  Result:=_VehicleType
end;


function TVehicleType.Get_TypeCode: integer;
begin
  Result:=FTypeCode;
end;

function TVehicleType.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  0:Result:=FTypeCode;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TVehicleType.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  0:FTypeCode:=Value;
  else
    inherited;
  end;
end;

class function TVehicleType.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TVehicleType.MakeFields0;
begin
  inherited;
  AddField(rsVehicleTypeCode, '%4d', '', '',
                 fvtInteger, 0, 0, 0,
                 0, 0, pkInput);
end;

{ TVehicleTypes }

class function TVehicleTypes.GetElementClass: TDMElementClass;
begin
  Result:=TVehicleType;
end;

function TVehicleTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsVehicleType;
end;

class function TVehicleTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IVehicleType;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TVehicleType.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
