unit UndergroundObstacleU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DelayElementU;

type
  TUndergroundObstacle=class(TDelayElement, IUndergroundObstacle)
  private
    FMinMineDepth:double;
  protected
    function Get_MinMineDepth:double; safecall;

    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Set_Ref(const Value:IDMElement); override; safecall;
    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; override; safecall;
  end;

  TUndergroundObstacles=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TUndergroundObstacle }

class function TUndergroundObstacle.GetClassID: integer;
begin
  Result:=_UndergroundObstacle;
end;

class function TUndergroundObstacle.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TUndergroundObstacle.Get_MinMineDepth: double;
begin
  Result:=FMinMineDepth
end;

class procedure TUndergroundObstacle.MakeFields0;
begin
  inherited;
  AddField(rsMinMineDepth, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(uopMinMineDepth), 0, pkInput);
end;

function TUndergroundObstacle.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(uopMinMineDepth):
    Result:=FMinMineDepth;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TUndergroundObstacle.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(uopMinMineDepth):
    FMinMineDepth:=Value;
  else
    inherited;
  end;
end;

procedure TUndergroundObstacle.Set_Ref(const Value: IDMElement);
begin
  inherited;
  if Value=nil then Exit;
  FMinMineDepth:=(Value as IUndergroundObstacleKind).DefaultMineDepth
end;

function TUndergroundObstacle.GetMethodDimItemIndex(Kind, Code: Integer;
  const DimItems: IDMCollection; const ParamE: IDMElement;
  ParamF: double): Integer;
var
  SumL:double;
  BoundaryLayerS:ISafeguardUnit;
  j, k:integer;
  aField:IDMField;
  SafeguardElementE:IDMElement;
  WidthIntf:IWidthIntf;
begin
  case Kind of
  sdMineLength:
    begin
      BoundaryLayerS:=Parent as ISafeguardUnit;
      SumL:=0;
      for j:=0 to BoundaryLayerS.SafeguardElements.Count-1 do begin
        SafeguardElementE:=BoundaryLayerS.SafeguardElements.Item[j];
        if SafeguardElementE.QueryInterface(IWidthIntf, WidthIntf)=0 then
          SumL:=SumL+WidthIntf.Width
        else
        if SafeguardElementE.ClassID=_PerimeterSensor then
          SumL:=SumL+(SafeguardElementE as IPerimeterSensor).ZoneWidth
      end;

      k:=0;
      while k<DimItems.Count do begin
        aField:=DimItems.Item[k] as IDMField;
        if (SumL>aField.MinValue) and
           (SumL<=aField.MaxValue) then
          Break
        else
          inc(k)
      end;
      Result:=k;
    end;
  else
    Result:=-1
  end;    
end;

{ TUndergroundObstacles }

class function TUndergroundObstacles.GetElementClass: TDMElementClass;
begin
  Result:=TUndergroundObstacle;
end;

function TUndergroundObstacles.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsUndergroundObstacle;
end;

class function TUndergroundObstacles.GetElementGUID: TGUID;
begin
  Result:=IID_IUndergroundObstacle;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TUndergroundObstacle.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
