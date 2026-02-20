unit CurvedLineU;

interface
uses
  Classes, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, LineU, Variants;

type
  TCurvedLine=class(TLine, ICurvedLine)
  private
    FP0X:double;
    FP0Y:double;
    FP0Z:double;
    FP1X:double;
    FP1Y:double;
    FP1Z:double;
    function Get_P0X: double; safecall;
    function Get_P0Y: double; safecall;
    function Get_P0Z: double; safecall;
    function Get_P1X: double; safecall;
    function Get_P1Y: double; safecall;
    function Get_P1Z: double; safecall;
    procedure Set_P0X(Value: double); safecall;
    procedure Set_P0Y(Value: double); safecall;
    procedure Set_P0Z(Value: double); safecall;
    procedure Set_P1X(Value: double); safecall;
    procedure Set_P1Y(Value: double); safecall;
    procedure Set_P1Z(Value: double); safecall;
  protected

    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); override;

    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
  end;

  TCurvedLines=class(TLines)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SpatialModelConstU;

var
  FFields:IDMCollection;

{ TCurvedLine }

class function TCurvedLine.GetClassID: integer;
begin
  Result:=_CurvedLine;
end;

procedure TCurvedLine.Draw(const aPainter:IUnknown; DrawSelected:integer);
var
  WorldPointList:Variant;
  C0, C1:ICoordNode;
begin
  if aPainter=nil then Exit;
  if Layer=nil then Exit;
  if (DrawSelected<>0) or
    Layer.Visible then
  with aPainter as IPainter do begin
    if (DrawSelected=1) then
      PenColor:=clLime
    else if (DrawSelected=-1) then
      PenColor:=clWhite
    else if (Color=-1) and (Layer<>nil) then
      PenColor:=Layer.Color
    else
      PenColor:=Color;

    if (Get_Style=-1) and (Layer<>nil) then
      PenStyle:=Layer.Style
    else
      PenStyle:=Get_Style;

    PenWidth:=Get_Thickness;
    PenMode:=ord(pmCopy);

    C0:=Get_C0;
    C1:=Get_C1;
    WorldPointList:=VarArrayCreate([0,11], varDouble);
    WorldPointList[0]:=C0.X;
    WorldPointList[1]:=C0.Y;
    WorldPointList[2]:=C0.Z;
    WorldPointList[3]:=FP0X;
    WorldPointList[4]:=FP0Y;
    WorldPointList[5]:=FP0Z;
    WorldPointList[6]:=FP1X;
    WorldPointList[7]:=FP1Y;
    WorldPointList[8]:=FP1Z;
    WorldPointList[9]:=C1.X;
    WorldPointList[10]:=C1.Y;
    WorldPointList[11]:=C1.Z;
    DrawCurvedLine(WorldPointList);
    PenWidth:=0;
  end;
end;

function TCurvedLine.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(clP0X):
    Result:=FP0X;
  ord(clP0Y):
    Result:=FP0Y;
  ord(clP0Z):
    Result:=FP0Z;
  ord(clP1X):
    Result:=FP1X;
  ord(clP1Y):
    Result:=FP1Y;
  ord(clP1Z):
    Result:=FP1Z;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TCurvedLine.SetFieldValue_(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(clP0X):
    FP0X:=Value;
  ord(clP0Y):
    FP0Y:=Value;
  ord(clP0Z):
    FP0Z:=Value;
  ord(clP1X):
    FP1X:=Value;
  ord(clP1Y):
    FP1Y:=Value;
  ord(clP1Z):
    FP1Z:=Value;
  else
    inherited;
  end;
end;

class function TCurvedLine.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TCurvedLine.MakeFields0;
begin
  inherited;
  AddField(rsP0X, '%10.0f', '', '',
      fvtFloat, 0, 0, 0,
      ord(clP0X), 0, pkInput);
  AddField(rsP0Y, '%10.0f', '', '',
      fvtFloat, 0, 0, 0,
      ord(clP0Y), 0, pkInput);
  AddField(rsP0Z, '%10.0f', '', '',
      fvtFloat, 0, 0, 0,
      ord(clP0Z), 0, pkInput);
  AddField(rsP1X, '%10.0f', '', '',
      fvtFloat, 0, 0, 0,
      ord(clP1X), 0, pkInput);
  AddField(rsP1Y, '%10.0f', '', '',
      fvtFloat, 0, 0, 0,
      ord(clP1Y), 0, pkInput);
  AddField(rsP1Z, '%10.0f', '', '',
      fvtFloat, 0, 0, 0,
      ord(clP1Z), 0, pkInput);
end;

function TCurvedLine.Get_P0X: double;
begin
  Result:=FP0X
end;

function TCurvedLine.Get_P0Y: double;
begin
  Result:=FP0Y
end;

function TCurvedLine.Get_P0Z: double;
begin
  Result:=FP0Z
end;

function TCurvedLine.Get_P1X: double;
begin
  Result:=FP1X
end;

function TCurvedLine.Get_P1Y: double;
begin
  Result:=FP1Y
end;

function TCurvedLine.Get_P1Z: double;
begin
  Result:=FP1Z
end;

procedure TCurvedLine.Set_P0X(Value: double);
begin
  Set_FieldValue(ord(clP0X), Value)
end;

procedure TCurvedLine.Set_P0Y(Value: double);
begin
  Set_FieldValue(ord(clP0Y), Value)
end;

procedure TCurvedLine.Set_P0Z(Value: double);
begin
  Set_FieldValue(ord(clP0Z), Value)
end;

procedure TCurvedLine.Set_P1X(Value: double);
begin
  Set_FieldValue(ord(clP1X), Value)
end;

procedure TCurvedLine.Set_P1Y(Value: double);
begin
  Set_FieldValue(ord(clP1Y), Value)
end;

procedure TCurvedLine.Set_P1Z(Value: double);
begin
  Set_FieldValue(ord(clP1Z), Value)
end;

{ TCurvedLines }

class function TCurvedLines.GetElementClass: TDMElementClass;
begin
  Result:=TCurvedLine;
end;

function TCurvedLines.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsCurvedLine
end;

class function TCurvedLines.GetElementGUID: TGUID;
begin
  Result:=IID_ICurvedLine
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TCurvedLine.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
