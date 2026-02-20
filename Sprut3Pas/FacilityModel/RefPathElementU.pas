unit RefPathElementU;

interface
uses
  Classes, SysUtils, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TRefPathElement=class(TDMElement, IRefPathElement)
  private
  protected
    FN: integer;
    FGuardArrivals:IDMCollection;
    FX0:double;
    FY0:double;
    FZ0:double;
    FX1:double;
    FY1:double;
    FZ1:double;
    FDirection:integer;
    FPathArcKind: Integer;
    FPathStage:integer;
    FRef0:IDMElement;
    FRef1:IDMElement;

    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    class procedure MakeFields0; override;
    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
    procedure Clear; override; safecall;

    function  Get_PathStage:integer; safecall;
    procedure Set_PathStage(Value:integer); safecall;
  public
    function  Get_N: integer; safecall;
    procedure Set_N(Value: integer); safecall;
    function  Get_PathArcKind: Integer; safecall;
    procedure Set_PathArcKind(Value: Integer); safecall;
    function  Get_X0:double; safecall;
    procedure Set_X0(Value:double); safecall;
    function  Get_Y0:double; safecall;
    procedure Set_Y0(Value:double); safecall;
    function  Get_Z0:double; safecall;
    procedure Set_Z0(Value:double); safecall;
    function  Get_X1:double; safecall;
    procedure Set_X1(Value:double); safecall;
    function  Get_Y1:double; safecall;
    procedure Set_Y1(Value:double); safecall;
    function  Get_Z1:double; safecall;
    procedure Set_Z1(Value:double); safecall;
    function  Get_Direction: integer; safecall;
    procedure Set_Direction(Value: integer); safecall;
    function Get_GuardArrivals:IDMCollection; safecall;
    function  Get_Ref0:IDMElement; safecall;
    procedure Set_Ref0(const Value:IDMElement); safecall;
    function  Get_Ref1:IDMElement; safecall;
    procedure Set_Ref1(const Value:IDMElement); safecall;

    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  FacilityModelConstU;
var
  FFields:IDMCollection;

{ TRefPathElement }

procedure TRefPathElement.Initialize;
begin
  inherited;
  FGuardArrivals:=DataModel.CreateCollection(_GuardArrival, Self as IDMElement);
end;

class function TRefPathElement.GetClassID: integer;
begin
  Result:=-1;
end;

class function TRefPathElement.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TRefPathElement.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsN, '%d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(wpeN)+100, 1, pkOutput);
  AddField(rsDirection, '%d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(wpeDirection)+100, 1, pkOutput);
  S:='|'+'К цели скрытно' + //0
     '|'+'К цели быстро'  + //1
     '|'+'От цели скрытно'+ //2
     '|'+'От цели быстро' + //3
     '|'+'Критическая точка на пути к цели'+  //4
     '|'+'Критическая точка на пути к цели'+  //5
     '|'+'Критическая точка на пути от цели'+ //6
     '|'+'Критическая точка на пути от цели'+ //7
     '|'+'Цель на скрытном этапе' + //8
     '|'+'Цель на быстром этапе'  + //9
     '|'+'Цель на скрытном этапе' + //10
     '|'+'Цель на быстром этапе'  + //11
     '|'+'Критическая точка на цели'+  //12
     '|'+'Критическая точка на цели'+  //13
     '|'+'Критическая точка на цели'+  //14
     '|'+'Критическая точка на цели';  //15
  AddField(rsPathStage, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(wpePathStage)+100, 1, pkOutput);
  AddField(rsX0, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeX0)+100, 1, pkOutput);
  AddField(rsY0, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeY0)+100, 1, pkOutput);
  AddField(rsZ0, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeZ0)+100, 1, pkOutput);
  AddField(rsX1, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeX1)+100, 1, pkOutput);
  AddField(rsY1, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeY1)+100, 1, pkOutput);
  AddField(rsZ1, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeZ1)+100, 1, pkOutput);
end;

function TRefPathElement.GetFieldValue(Code: integer): OleVariant;
begin
  case Code-100 of
  ord(wpeN):
    Result:=FN;
  ord(wpePathArcKind):
    Result:=FPathArcKind;
  ord(wpeDirection):
    Result:=FDirection;
  ord(wpePathStage):
    Result:=FPathStage;
  ord(wpeX0):
    Result:=FX0;
  ord(wpeY0):
    Result:=FY0;
  ord(wpeZ0):
    Result:=FZ0;
  ord(wpeX1):
    Result:=FX1;
  ord(wpeY1):
    Result:=FY1;
  ord(wpeZ1):
    Result:=FZ1;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TRefPathElement.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code-100 of
  ord(wpeN):
    FN:=Value;
  ord(wpePathArcKind):
    FPathArcKind:=Value;
  ord(wpeDirection):
    FDirection:=Value;
  ord(wpePathStage):
    FPathStage:=Value;
  ord(wpeX0):
    FX0:=Value;
  ord(wpeY0):
    FY0:=Value;
  ord(wpeZ0):
    FZ0:=Value;
  ord(wpeX1):
    FX1:=Value;
  ord(wpeY1):
    FY1:=Value;
  ord(wpeZ1):
    FZ1:=Value;
  else
    inherited;
  end;
end;

function TRefPathElement.Get_N: integer;
begin
  Result:=FN
end;

procedure TRefPathElement.Set_N(Value: integer);
begin
  FN:=Value
end;

destructor TRefPathElement.Destroy;
begin
  FGuardArrivals:=nil;
  FRef0:=nil;
  FRef1:=nil;
  inherited;
end;

function TRefPathElement.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FGuardArrivals
end;

function TRefPathElement.Get_CollectionCount: integer;
begin
  Result:=1
end;

procedure TRefPathElement.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;
  aOperations:=leoSelectRef;
end;

procedure TRefPathElement.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
  GuardGroupE:IDMElement;
begin
  aCollection2:=aCollection as IDMCollection2;
  SourceCollection:=(DataModel as IFacilityModel).GuardGroups;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do begin
    GuardGroupE:=SourceCollection.Item[j];
    aCollection2.Add(GuardGroupE);
  end;
end;

procedure TRefPathElement.Clear;
var
  GuardArrivals2:IDMCollection2;
  GuardArrivalE:IDMElement;
begin
  if DataModel<>nil then begin
    GuardArrivals2:=(DataModel as IDMElement).Collection[_GuardArrival] as IDMCollection2;
    while FGuardArrivals.Count>0 do begin
      GuardArrivalE:=FGuardArrivals.Item[FGuardArrivals.Count-1];
      GuardArrivalE.Clear;
      GuardArrivals2.Remove(GuardArrivalE);
    end;
  end;

  inherited;
end;

function TRefPathElement.Get_GuardArrivals: IDMCollection;
begin
  Result:=FGuardArrivals
end;

function TRefPathElement.Get_PathStage: integer;
begin
  Result:=FPathStage
end;

procedure TRefPathElement.Set_PathStage(Value: integer);
begin
  FPathStage:=Value
end;

function TRefPathElement.Get_Direction: integer;
begin
  Result:=FDirection
end;

function TRefPathElement.Get_PathArcKind: Integer;
begin
  Result:=FPathArcKind
end;

function TRefPathElement.Get_X0: double;
begin
  Result:=FX0
end;

function TRefPathElement.Get_X1: double;
begin
  Result:=FX1
end;

function TRefPathElement.Get_Y0: double;
begin
  Result:=FY0
end;

function TRefPathElement.Get_Y1: double;
begin
  Result:=FY1
end;

function TRefPathElement.Get_Z0: double;
begin
  Result:=FZ0
end;

function TRefPathElement.Get_Z1: double;
begin
  Result:=FZ1
end;

procedure TRefPathElement.Set_Direction(Value: integer);
begin
  FDirection:=Value
end;

procedure TRefPathElement.Set_PathArcKind(Value: Integer);
begin
  FPathArcKind:=Value
end;

procedure TRefPathElement.Set_X0(Value: double);
begin
  FX0:=Value
end;

procedure TRefPathElement.Set_X1(Value: double);
begin
  FX1:=Value
end;

procedure TRefPathElement.Set_Y0(Value: double);
begin
  FY0:=Value
end;

procedure TRefPathElement.Set_Y1(Value: double);
begin
  FY1:=Value
end;

procedure TRefPathElement.Set_Z0(Value: double);
begin
  FZ0:=Value
end;

procedure TRefPathElement.Set_Z1(Value: double);
begin
  FZ1:=Value
end;

function TRefPathElement.FieldIsVisible(Code: integer): WordBool;
begin
  case Code-100 of
  ord(wpeN), ord(wpePathArcKind):
    Result:=True
  else
    Result:=False
  end;
end;

function TRefPathElement.Get_Ref0: IDMElement;
begin
  Result:=FRef0
end;

function TRefPathElement.Get_Ref1: IDMElement;
begin
  Result:=FRef1
end;

procedure TRefPathElement.Set_Ref0(const Value: IDMElement);
begin
  FRef0:=Value
end;

procedure TRefPathElement.Set_Ref1(const Value: IDMElement);
begin
  FRef1:=Value
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TRefPathElement.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
