unit CircleU;

interface
uses
  Classes, SysUtils, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, CoordNodeU, Variants;

type

  TCircle=class(TCoordNode, ICircle)
  private
  protected
    FRadius:double;
    procedure Initialize; override;
    procedure  _Destroy; override;

    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); override;

    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;

    function Get_Radius:double; safecall;
    procedure Set_Radius(Value:double); safecall;
  end;

  TCircles=class(TDMCollection)
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

{ TCircle }

procedure TCircle.Initialize;
begin
  inherited;
end;

procedure TCircle._Destroy;
begin
  inherited;
end;

class function TCircle.GetClassID: integer;
begin
  Result:=_Circle;
end;


procedure TCircle.Draw(const aPainter:IUnknown; DrawSelected:integer);
begin
  if aPainter=nil then Exit;
  if (DataModel<>nil) and
     (DataModel.Document<>nil) and
     (((DataModel.Document as IDMDocument).State and dmfAuto)<>0) then Exit;
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
      PenStyle:=Layer.Style;
      PenWidth:=Layer.LineWidth;
      if DrawSelected=3 then
        PenMode:=ord(pmNotXor)
      else
        PenMode:=ord(pmCopy);
      DrawCircle(FX, FY, FZ, FRadius, False);

      PenWidth:=0;

      if (DrawSelected=1) or
         (DrawSelected=-1) then
        DrawPoint(FX, FY, FZ);
    end;
end;

function TCircle.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cirRadius):
    Result:=FRadius;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

class procedure TCircle.MakeFields0;
begin
  inherited;
  AddField(rsRadius, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cirRadius), 0, pkInput);
end;

procedure TCircle.SetFieldValue_(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(cirRadius):
    FRadius:=Value;
  else
    inherited;
  end;
end;

function TCircle.Get_Radius: double;
begin
  Result:=FRadius
end;

class function TCircle.GetFields: IDMCollection;
begin
  Result:=FFields
end;

procedure TCircle.Set_Radius(Value: double);
begin
  FRadius:=Value
end;

{ TCircles }

class function TCircles.GetElementClass: TDMElementClass;
begin
  Result:=TCircle;
end;


function TCircles.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsCircle;
end;

class function TCircles.GetElementGUID: TGUID;
begin
  Result:=IID_ICircle;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TCircle.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
