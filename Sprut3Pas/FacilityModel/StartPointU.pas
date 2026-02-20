unit StartPointU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardElementU;

type

  TStartPoint=class(TSafeguardElement, IStartPoint)
  private
    FName:String;
  protected
    class function  GetClassID:integer; override;
    class function  StoredName: WordBool; override;

    function  Get_Name:WideString; override; safecall;
    procedure Set_Name(const Value:WideString); override; safecall;
    procedure Loaded; override;
  end;

  TStartPoints=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TStartPoint }

class function TStartPoint.GetClassID: integer;
begin
  Result:=_StartPoint;
end;

function TStartPoint.Get_Name: WideString;
begin
  Result:=FName
end;

procedure TStartPoint.Loaded;
begin
  inherited;
  if FName='' then
    FName:=GetDefaultName;
end;

procedure TStartPoint.Set_Name(const Value: WideString);
begin
  FName:=Value
end;

class function TStartPoint.StoredName: WordBool;
begin
  Result:=True
end;

{ TStartPoints }

class function TStartPoints.GetElementClass: TDMElementClass;
begin
  Result:=TStartPoint;
end;

function TStartPoints.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsStartPoint;
end;

class function TStartPoints.GetElementGUID: TGUID;
begin
  Result:=IID_IStartPoint;
end;


end.
