unit WeatherU;
{Погодные условия}
interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TWeather=class(TNamedDMElement, IWeather)
  protected
    class function  GetClassID:integer; override;
  end;

  TWeathers=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TWeather }

class function TWeather.GetClassID: integer;
begin
  Result:=_Weather
end;

{ TWeathers }

function TWeathers.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsWeather;
end;

class function TWeathers.GetElementClass: TDMElementClass;
begin
  Result:=TWeather;
end;

class function TWeathers.GetElementGUID: TGUID;
begin
  Result:=IID_IWeather;
end;


end.
