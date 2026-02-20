unit Conveyances;

interface
uses
  Classes, SysUtils,
  DataModels, SecurityElements;

type
  TConveyance=class(TSecurityElement)
  private
  protected

  public
    constructor Create(aDataModel:TDataModel); override;
    destructor  Destroy; override;

    class function  Get_ClassID:integer; override;
    class function Get_ClassAlias: string; override;
    class function UsedInModel:boolean; override;

  published
  end;

  TConveyances=class(TDMElements)
  private
    function Get_Conveyances(Index: integer): TConveyance;
  protected
    class function Get_ElementClass:TDMElementClass; override;
  public
    property Conveyances[Index:integer]:TConveyance read Get_Conveyances; default;
  end;

  TConveyanceRefs=class(TDMElementRefs)
  private
    function Get_Conveyances(Index: integer): TConveyance;
  protected
    class function Get_ElementClass:TDMElementClass; override;
  public
    property Conveyances[Index:integer]:TConveyance read Get_Conveyances; default;
  end;

implementation

uses
// Здесь следует указать имя моодуля, содержащего определение
// индексов классов модели
  SafeguardModelConsts;

{ TConveyance }

constructor TConveyance.Create(aDataModel:TDataModel);
begin
  inherited;
end;

destructor TConveyance.Destroy;
begin
  inherited Destroy;
end;

class function TConveyance.Get_ClassAlias: string;
begin
  Result:=rsConveyance;
end;

class function TConveyance.Get_ClassID: integer;
begin
  Result:=ord(dmcConveyance);
end;

class function TConveyance.UsedInModel: boolean;
begin
  Result:=False
end;

{ TConveyances }

class function TConveyances.Get_ElementClass: TDMElementClass;
begin
  Result:=TConveyance;
end;

function TConveyances.Get_Conveyances(Index: integer): TConveyance;
begin
  Result:=Items[Index];
end;

{ TConveyanceRefs }

class function TConveyanceRefs.Get_ElementClass: TDMElementClass;
begin
  Result:=TConveyance;
end;

function TConveyanceRefs.Get_Conveyances(Index: integer): TConveyance;
begin
  Result:=Items[Index];
end;

end.
