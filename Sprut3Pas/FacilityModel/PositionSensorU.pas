unit PositionSensorU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SensorU;

type
  TPositionSensor=class(TSensor, IPositionSensor)
  private
    FAlwaysAlarms:boolean;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class procedure MakeFields0; override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;

    function Get_AlwaysAlarms:WordBool; safecall;
    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; override; safecall;
  end;

  TPositionSensors=class(TDMCollection)
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

{ TPositionSensor }

function TPositionSensor.FieldIsVisible(Code: integer): WordBool;
var
  BoundaryLayer:ISafeguardUnit;
  j:integer;
  SafeguardElementE:IDMElement;
begin
  case Code of
  ord(pospAlwaysAlarms):
    begin
      BoundaryLayer:=Parent as ISafeguardUnit;
      j:=0;
      while j<BoundaryLayer.SafeguardElements.Count do begin
        SafeguardElementE:=BoundaryLayer.SafeguardElements.Item[j];
        if SafeguardElementE.ClassID=_AccessControl then
          Break
        else
          inc(j);
      end;
      if j=BoundaryLayer.SafeguardElements.Count then
        Result:=False
      else
        Result:=True;
    end;
  else
    Result:=inherited FieldIsVisible(Code);
  end
end;

class function TPositionSensor.GetClassID: integer;
begin
  Result:=_PositionSensor;
end;

class function TPositionSensor.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TPositionSensor.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(pospAlwaysAlarms):
    Result:=FAlwaysAlarms;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

function TPositionSensor.GetMethodDimItemIndex(Kind, Code: Integer;
  const DimItems: IDMCollection; const ParamE: IDMElement;
  ParamF: double): Integer;
var
  BoundaryLayer:ISafeguardUnit;
  j:integer;
  SafeguardElementE:IDMElement;
begin
  case Kind of
  sdSensorAccessControl:
    begin
      if FAlwaysAlarms then begin
        Result:=0;
        Exit;
      end;

      BoundaryLayer:=Parent as ISafeguardUnit;
      j:=0;
      while j<BoundaryLayer.SafeguardElements.Count do begin
        SafeguardElementE:=BoundaryLayer.SafeguardElements.Item[j];
        if SafeguardElementE.ClassID=_AccessControl then
          Break
        else
          inc(j);
      end;
      if j=BoundaryLayer.SafeguardElements.Count then
        Result:=0
      else
        Result:=1;
    end;
  else
    Result:=inherited GetMethodDimItemIndex(Kind, Code, DimItems,
                                            ParamE, ParamF);
  end;
end;

function TPositionSensor.Get_AlwaysAlarms: WordBool;
begin
  Result:=FAlwaysAlarms
end;

class procedure TPositionSensor.MakeFields0;
begin
  inherited;
  AddField(rsAlwaysAlarms, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(pospAlwaysAlarms), 0, pkInput);
end;

procedure TPositionSensor.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(pospAlwaysAlarms):
    FAlwaysAlarms:=Value
  else
    inherited;
  end;
end;

{ TPositionSensors }

class function TPositionSensors.GetElementClass: TDMElementClass;
begin
  Result:=TPositionSensor;
end;

function TPositionSensors.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsPositionSensor;
end;

class function TPositionSensors.GetElementGUID: TGUID;
begin
  Result:=IID_IPositionSensor;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TPositionSensor.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
