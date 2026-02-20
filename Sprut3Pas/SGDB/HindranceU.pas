unit HindranceU;
{Типы Помех}
interface
uses
  DeviceCharacteristicU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  THindrance=class(TDeviceCharacteristic, IHindrance)
  protected
    class function  GetClassID:integer; override;
  end;

  THindrances=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ THindrance }

class function THindrance.GetClassID: integer;
begin
  Result:=_Hindrance
end;

{ THindrances }

function THindrances.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsHindrance;
end;

class function THindrances.GetElementClass: TDMElementClass;
begin
  Result:=THindrance;
end;

class function THindrances.GetElementGUID: TGUID;
begin
  Result:=IID_IHindrance;
end;


end.
