unit BarrierFixtures;

interface
uses
  Classes, SysUtils,
  DataModels, DelayElements;

type
  TBarrierFixture=class(TDelayElement)
  private
  protected

  public
    constructor Create(aDataModel:TDataModel); override;
    destructor  Destroy; override;

    class function  Get_ClassID:integer; override;
    class function Get_ClassAlias: string; override;

  published
  end;

  TBarrierFixtures=class(TDMElements)
  private
    function Get_BarrierFixtures(Index: integer): TBarrierFixture;
  protected
    class function Get_ElementClass:TDMElementClass; override;
  public
    property BarrierFixtures[Index:integer]:TBarrierFixture read Get_BarrierFixtures; default;
  end;

  TBarrierFixtureRefs=class(TDMElementRefs)
  private
    function Get_BarrierFixtures(Index: integer): TBarrierFixture;
  protected
    class function Get_ElementClass:TDMElementClass; override;
  public
    property BarrierFixtures[Index:integer]:TBarrierFixture read Get_BarrierFixtures; default;
  end;

implementation

uses
// Здесь следует указать имя моодуля, содержащего определение
// индексов классов модели
  SafeguardModelConsts;

{ TBarrierFixture }

constructor TBarrierFixture.Create(aDataModel:TDataModel);
begin
  inherited;
end;

destructor TBarrierFixture.Destroy;
begin
  inherited Destroy;
end;

class function TBarrierFixture.Get_ClassAlias: string;
begin
  Result:=rsBarrierFixture;
end;

class function TBarrierFixture.Get_ClassID: integer;
begin
  Result:=ord(dmcBarrierFixture);
end;

{ TBarrierFixtures }

class function TBarrierFixtures.Get_ElementClass: TDMElementClass;
begin
  Result:=TBarrierFixture;
end;

function TBarrierFixtures.Get_BarrierFixtures(Index: integer): TBarrierFixture;
begin
  Result:=Items[Index];
end;

{ TBarrierFixtureRefs }

class function TBarrierFixtureRefs.Get_ElementClass: TDMElementClass;
begin
  Result:=TBarrierFixture;
end;

function TBarrierFixtureRefs.Get_BarrierFixtures(Index: integer): TBarrierFixture;
begin
  Result:=Items[Index];
end;

end.
