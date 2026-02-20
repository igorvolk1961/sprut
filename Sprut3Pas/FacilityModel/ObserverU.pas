unit ObserverU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TObserver=class(TDMElement, IObserver)
  private
    FObservationKind:integer;
    FDistance:double;
    FObservationPeriod:double;
    FSide:integer;
  protected
    class function  GetClassID:integer; override;

    function Get_Name:WideString; override;

    procedure Set_Parent(const Value:IDMElement); override;

    class procedure MakeFields0; override;
    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function FieldIsVisible(Code: integer): WordBool; override; safecall;
    function  Get_SelectParent: WordBool; override; safecall;

    function Get_ObservationKind:integer; safecall;
    procedure Set_ObservationKind(Value:integer); safecall;
    function Get_Distance:double; safecall;
    procedure Set_Distance(Value:double); safecall;
    function Get_ObservationPeriod:double; safecall;
    procedure Set_ObservationPeriod(Value:double); safecall;
    function Get_Side:integer; safecall;
    procedure Set_Side(Value:integer); safecall;
  end;

  TObservers=class(TDMCollection)
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

{ TObserver }

class procedure TObserver.MakeFields0;
var
  S:string;
begin
  inherited;
  S:='|Охранное телевидение'+
     '|Визуальное обнаружение постом охраны'+
     '|Визуальное обнаружение и задержка постом охраны'+
     '|Визуальное обнаружение персоналом'+
     '|Обнаружение патрулем'+
     '|Обнаружение шума датчиком'+
     '|Обнаружение шума постом охраны'+
     '|Обнаружение шума и задержка постом охраны'+
     '|Обнаружение шума персоналом';
  AddField(rsObservationKind, S, '', '',
           fvtChoice, 0, 0, 0,
           0, 0, pkInput);
  AddField(rsObservationDistance, '%0.0f', '', '',
           fvtFloat, 0, 0, 0,
           1, 0, pkInput);
  S:='|В зоне 0'+'|В зоне 1'+'|Просматривает рубеж на все глубину';
  AddField(rsObservationSide, S, '', '',
           fvtChoice, 0, 0, 0,
           2, 0, pkInput);
end;

function TObserver.Get_Name: WideString;
begin
  Result:=Inherited Get_Name;
end;

function TObserver.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  0: Result:=FObservationKind;
  1: Result:=FDistance;
  2: Result:=FSide;
  else
    Result:=inherited Get_FieldValue(Code);
  end;
end;

procedure TObserver.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  0: FObservationKind:=Value;
  1: FDistance:=Value;
  2: FSide:=Value;
  else
    inherited;
  end;
end;

class function TObserver.GetFields: IDMCollection;
begin
  Result:=FFields
end;

procedure TObserver.Set_Parent(const Value: IDMElement);
begin
    inherited;
end;

class function TObserver.GetClassID: integer;
begin
  Result:=_Observer
end;

function TObserver.Get_SelectParent: WordBool;
begin
  Result:=(FParent<>nil)
end;

function TObserver.Get_ObservationKind: integer;
begin
  Result:=FObservationKind
end;

procedure TObserver.Set_ObservationKind(Value: integer);
begin
  FObservationKind:=Value
end;

function TObserver.Get_Distance: double;
begin
  Result:=FDistance
end;

function TObserver.Get_Side: integer;
begin
  Result:=FSide
end;

procedure TObserver.Set_Distance(Value: double);
begin
  FDistance:=Value
end;

procedure TObserver.Set_Side(Value: integer);
begin
  FSide:=Value
end;

function TObserver.FieldIsVisible(Code: integer):  WordBool;
begin
  case Code of
  1: Result:=(Parent.ClassID<>_Zone);
  2: Result:=(Parent.ClassID=_Boundary) or (Parent.ClassID<>_Jump);
  else
    Result:=inherited FieldIsVisible(Code);
  end;
end;

function TObserver.Get_ObservationPeriod: double;
begin
  Result:=FObservationPeriod
end;

procedure TObserver.Set_ObservationPeriod(Value: double);
begin
  FObservationPeriod:=Value
end;

{ TObservers }

function TObservers.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsObserver
  else
    Result:=rsObservers;
end;

class function TObservers.GetElementClass: TDMElementClass;
begin
  Result:=TObserver
end;

class function TObservers.GetElementGUID: TGUID;
begin
  Result:=IID_IObserver
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TObserver.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
