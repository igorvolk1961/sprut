unit LineU;

interface
uses
  Classes, Graphics, SysUtils, Math,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SpatialElementU, Variants;

type

  TLine=class(TSpatialElement, ILine)
  private
    FParents: IDMCollection;
    FC0:Variant;
    FC1:Variant;

    FThickness:double;
    FStyle:integer;

  protected
    function  Get_Parents: IDMCollection; override; safecall;
    procedure Set_Parent(const Value:IDMElement); override; safecall;

    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); override;

    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Set_Selected(Value: WordBool); override;

    function  Get_ZAngle:double; safecall;
    procedure Set_ZAngle(Value:double); safecall;
    function  Get_Length:double; safecall;
    procedure Set_Length(Value:double); safecall;
    function  Get_Thickness:double; safecall;
    procedure Set_Thickness(Value:double); safecall;
    function  Get_Style:integer; safecall;
    procedure Set_Style(Value: integer); safecall;

    function  Get_C0:ICoordNode; virtual; safecall;
    function  Get_C1:ICoordNode; virtual; safecall;
    procedure Set_C0(const Value:ICoordNode); virtual; safecall;
    procedure Set_C1(const Value:ICoordNode); virtual; safecall;

    function  Get_CC0(Direction:integer):ICoordNode; virtual; safecall;
    function  Get_CC1(Direction:integer):ICoordNode; virtual; safecall;
    procedure Set_CC0(Direction:integer; const Value:ICoordNode); virtual; safecall;
    procedure Set_CC1(Direction:integer; const Value:ICoordNode); virtual; safecall;

    function Get_ProjectionLength: double;

    procedure DisconnectFrom(const aParent:IDMElement); override; safecall;
    procedure Loaded; override;
    function  GetCopyLinkMode(const aLink: IDMElement): Integer; override; safecall;

    procedure Initialize; override;
    procedure ClearOp; override; safecall;

    procedure  GetFieldValueSource(Index: Integer; var aCollection: IDMCollection); override; safecall;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    function InLineWith(W1, W2, W3:double; Side, Plain: integer; Projection:WordBool): integer; safecall;
    function NextNodeTo(const Node:ICoordNode):ICoordNode;  safecall;
    function GetVerticalArea(Direction:integer):IArea; safecall;
    function  DistanceFrom(WX, WY, WZ:double; out WX0, WY0, WZ0:double;
                          out OrtBaseOnLine:WordBool):double; safecall;
    procedure PerpendicularFrom(WX: double; WY: double; WZ: double;
                                out WX0, WY0, WZ0: double); safecall;
    function Get_IsVertical:WordBool;  safecall;

    procedure Get_CenterPoint(var WX, WY, WZ:double);
    function NodeConnectingWith(const aLine:ILine):ICoordNode;
    function CanIntersectLine(const aLine:ILine;
                       var WX, WY, WZ:double):WordBool;
    procedure AddParent(const aParent:IDMElement); override;
    procedure RemoveParent(const aParent:IDMElement); override;

    procedure Set_CenterAt(X, Y, Z, aLength, cosX, cosY,
                      WX0, WY0, WZ0, WX1, WY1, WZ1:double);
    procedure UpdateAreas(const aPainter:IPainter);
  end;

  TLines=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation

uses
  SpatialModelConstU,
  Geometry;

var
  FFields:IDMCollection;

{ TLine }

procedure TLine.Initialize;
begin
  inherited;
  FParents:=TDMCollection.Create(Self as IDMElement);
  Set_Style(-1);
  Set_C0(nil);
  Set_C1(nil);
  Set_Thickness(0);
end;

procedure TLine.DisconnectFrom(const aParent:IDMElement);
var
  aNode:ICoordNode;
begin
  if aParent.QueryInterface(ICoordNode, aNode)=0 then begin
    if aNode=Get_C0 then
      Set_C0(nil)
    else
      Set_C1(nil)
  end else
    inherited
end;

class function TLine.GetClassID: integer;
begin
  Result:=_Line;
end;

function TLine.Get_ProjectionLength: double;
var
  C0, C1:ICoordNode;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  Result:=sqrt(sqr(C1.X-C0.X)+sqr(C1.Y-C0.Y))
end;

function TLine.GetVerticalArea(Direction:integer): IArea;
var
  j:integer;
  aArea:IArea;
begin
  Result:=nil;
  for j:=0 to Parents.Count-1 do
  if Parents.Item[j].QueryInterface(IArea, aArea)=0 then begin
    if aArea.IsVertical then
      try
      case Direction of
      0:if aArea.BottomLines.IndexOf(Self as IDMElement)<>-1 then begin
          Result:=aArea;
          Exit;
        end;
      1:if aArea.TopLines.IndexOf(Self as IDMElement)<>-1 then begin
         Result:=aArea;
         Exit;
        end;
      end;
      except
        Raise
      end;
  end;
end;

function TLine.DistanceFrom(WX, WY, WZ:double;
                        out WX0, WY0, WZ0:double;
                        out OrtBaseOnLine:WordBool):double;
var
  C0, C1:IcoordNode;
  D0, D1:double;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  PerpendicularFrom(WX, WY, WZ, WX0, WY0, WZ0);
  OrtBaseOnLine:=False;
  if ((WX0-C0.X)*(WX0-C1.X)<=0) and
      ((WY0-C0.Y)*(WY0-C1.Y)<=0) and
      ((WZ0-C0.Z)*(WZ0-C1.Z)<=0) then begin
    OrtBaseOnLine:=True;
    Result:=sqrt(sqr(WX-WX0)+sqr(WY-WY0)+sqr(WZ-WZ0));
  end else begin
    D0:=C0.DistanceFrom(WX, WY, WZ);
    D1:=C1.DistanceFrom(WX, WY, WZ);
    if D0<=D1 then begin
      Result:=D0;
      WX0:=C0.X;
      WY0:=C0.Y;
      WZ0:=C0.Z;
    end else begin
      Result:=D1;
      WX0:=C1.X;
      WY0:=C1.Y;
      WZ0:=C1.Z;
    end;
  end;
end;

procedure TLine.PerpendicularFrom(WX,  WY,  WZ:double;
                              out WX0, WY0, WZ0:double);
var
  dx,dy, dz: double;
  C0, C1:ICoordNode;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  dx:=C1.X-C0.X;
  dy:=C1.Y-C0.Y;
  dz:=C1.Z-C0.Z;
  if abs(dz)>1.e-6 then begin
    WZ0:=(C1.Z*(sqr(dx)+sqr(dy))+WZ*sqr(dz)+
               dz*(dx*(WX-C1.X)+
                   dy*(WY-C1.Y)))/
                    (sqr(dx)+sqr(dy)+sqr(dz));
    WX0:=C1.X+dx/dz*(WZ0-C1.Z);
    WY0:=C1.Y+dy/dz*(WZ0-C1.Z);
  end else
  if abs(dx)>1.e-6 then begin
    WZ0:=C1.Z;
    WX0:=(dy*dy*C1.X+dx*dx*WX-dy*dx*(C1.Y-WY))/(dy*dy+dx*dx);
    WY0:=C1.Y+dy/dx*(WX0-C1.X);
  end else begin
    WZ0:=C1.Z;
    WX0:=C1.X;
    WY0:=WY
  end;
end;

procedure TLine.Get_CenterPoint(var WX, WY, WZ:double);
var
  C0, C1:ICoordNode;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  WX:=0.5*(C0.X+C1.X);
  WY:=0.5*(C0.Y+C1.Y);
  WZ:=0.5*(C0.Z+C1.Z);
end;

procedure TLine.Draw(const aPainter:IUnknown; DrawSelected:integer);
var
  Style:integer;
  C0, C1:ICoordNode;
  X0, Y0, Z0, X1, Y1, Z1:double;
  C0E:IDMElement;
//  Painter:IPainter;
//  S:WideString;
begin
  try
  if Layer=nil then Exit;
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

      Style:=Get_Style;
      if (Style=-1) and (Layer<>nil) then
        PenStyle:=Layer.Style
      else
        PenStyle:=Style;

      PenWidth:=Layer.LineWidth;
      if DrawSelected=3 then
        PenMode:=ord(pmNotXor)
      else
        PenMode:=ord(pmCopy);
      C0:=Get_C0;
      C1:=Get_C1;
      if C0=nil then Exit;
      if C1=nil then Exit;

      X0:=C0.X;
      Y0:=C0.Y;
      Z0:=C0.Z;
      X1:=C1.X;
      Y1:=C1.Y;
      Z1:=C1.Z;

      DrawLine(X0, Y0, Z0, X1, Y1, Z1);

      PenWidth:=0;

      if ((DrawSelected=1) or
         (DrawSelected=-1)) and
         (X0=X1) and (Y0=Y1) and
         (ClassID=_Line) then begin
        C0E:=C0 as IDMElement;
        C0E.Draw(aPainter, DrawSelected);
      end;
    end;
  except
    raise
  end;
{
  Painter:=aPainter as IPainter;
  X0:=0.5*(C0.X+C1.X);
  Y0:=0.5*(C0.Y+C1.Y);
  Z0:=0.5*(C0.Z+C1.Z);
  S:=IntToStr(ID);
  Painter.DrawText(X0, Y0, Z0, S, 0,
   'Arial', 8, 0, 0, 0);
}
end;

procedure TLine.ClearOp;
begin
  try
  inherited;
  if (Ref<>nil) and
    (Ref.SpatialElement=Self as IDMElement) then
   Ref.SpatialElement:=nil;

//  C0:=nil;
//  C1:=nil;
  except
  end;
end;


function TLine.NodeConnectingWith(const aLine: ILine): ICoordNode;
var
  C0, C1:ICoordNode;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  if (C0=aLine.C0) or
     (C0=aLine.C1) then
    Result:=C0
  else
  if (C1=aLine.C0) or
     (C1=aLine.C1) then
    Result:=C1
  else
    Result:=nil;
end;

procedure TLine.Set_CenterAt(X, Y, Z, aLength, cosX, cosY,
                      WX0, WY0, WZ0, WX1, WY1, WZ1:double);
var
  C0, C1:ICoordNode;

  procedure ChangeCoords;
  var Q:double;
  begin
    Q:=C0.X; C0.X:=C1.X; C1.X:=Q;
    Q:=C0.Y; C0.Y:=C1.Y; C1.Y:=Q;
    Q:=C0.Z; C0.Z:=C1.Z; C1.Z:=Q;
  end;
begin
    C0:=Get_C0;
    C1:=Get_C1;
    C0.X:=X-0.5*aLength*cosY;
    C0.Y:=Y+0.5*aLength*cosX;
    C0.Z:=Z;
    C1.X:=X+0.5*aLength*cosY;
    C1.Y:=Y-0.5*aLength*cosX;
    C1.Z:=Z;

  if WZ0=-InfinitValue then begin
    if WZ1=-InfinitValue then
      Exit
    else
    if C1.DistanceFrom(WX1, WY1, WZ1)>C0.DistanceFrom(WX1, WY1, WZ1) then
      ChangeCoords;
  end else
  if C0.DistanceFrom(WX0, WY0, WZ0)>C1.DistanceFrom(WX0, WY0, WZ0) then
    ChangeCoords;
end;

function TLine.Get_Length:double;
var
  dx, dy, dz, R2:double;
  C0, C1:ICoordNode;
begin
  Result:=0;
  C0:=Get_C0;
  C1:=Get_C1;
  if C0=nil then Exit;
  if C1=nil then Exit;
  dx:=C0.X-C1.X;
  dy:=C0.Y-C1.Y;
  dz:=C0.Z-C1.Z;
  R2:=dx*dx+dy*dy+dz*dz;
  Result:=sqrt(R2);
end;

procedure TLine.Set_Length(Value:double);
var
  C0, C1, aC0, aC1:ICoordNode;
  L, A, B:double;
  SpatialModel2:ISpatialModel2;
  ChangeLengthDirection:integer;
begin
  if  DataModel.QueryInterface(ISpatialModel2, SpatialModel2)=0 then
    ChangeLengthDirection:=SpatialModel2.ChangeLengthDirection
  else
    ChangeLengthDirection:=0;

  C0:=Get_C0;
  C1:=Get_C1;
  L:=Get_Length;

  if ChangeLengthDirection=0 then begin
    A:=(C1.X+C0.X)/2;
    B:=(C1.X-C0.X)/2;
    C0.X:=A-B*Value/L;
    C1.X:=A+B*Value/L;

    A:=(C1.Y+C0.Y)/2;
    B:=(C1.Y-C0.Y)/2;
    C0.Y:=A-B*Value/L;
    C1.Y:=A+B*Value/L;

    A:=(C1.Z+C0.Z)/2;
    B:=(C1.Z-C0.Z)/2;
    C0.Z:=A-B*Value/L;
    C1.Z:=A+B*Value/L;
  end else begin
    case ChangeLengthDirection of
    1:begin
        if C0.X<C1.X then begin
          aC0:=C0;
          aC1:=C1;
        end else begin
          aC0:=C1;
          aC1:=C0;
        end;
      end;
    2:begin
        if C0.X<C1.X then begin
          aC0:=C1;
          aC1:=C0;
        end else begin
          aC0:=C0;
          aC1:=C1;
        end;
      end;
    3:begin
        if C0.Y<C1.Y then begin
          aC0:=C1;
          aC1:=C0;
        end else begin
          aC0:=C0;
          aC1:=C1;
        end;
      end;
    4:begin
        if C0.Y<C1.Y then begin
          aC0:=C0;
          aC1:=C1;
        end else begin
          aC0:=C1;
          aC1:=C0;
        end;
      end;
    end;

    aC1.X:=aC0.X+(aC1.X-aC0.X)*Value/L;
    aC1.Y:=aC0.Y+(aC1.Y-aC0.Y)*Value/L;
    aC1.Z:=aC0.Z+(aC1.Z-aC0.Z)*Value/L;
  end;
end;

function  TLine.Get_Thickness:double;
begin
  Result:=FThickness
end;

procedure TLine.Set_Thickness(Value:double);
begin
  Set_FieldValue(ord(linThickness), Value)
end;

function TLine.Get_C0:ICoordNode;
var
 Unk:IUnknown;
begin
  Unk:=FC0;
  Result:=Unk as ICoordNode;
end;

function TLine.Get_C1:ICoordNode;
var
 Unk:IUnknown;
begin
  Unk:=FC1;
  Result:=Unk as ICoordNode;
end;

procedure TLine.Set_C0(const Value:ICoordNode);
begin
  Set_FieldValue(ord(linC0), Value as IUnknown)
end;

procedure TLine.Set_C1(const Value:ICoordNode);
begin
  Set_FieldValue(ord(linC1), Value as IUnknown)
end;

function TLine.Get_CC0(Direction:integer):ICoordNode;
var
 Unk:IUnknown;
begin
  if Direction=0 then
    Unk:=FC0
  else
    Unk:=FC1;
  Result:=Unk as ICoordNode;
end;

function TLine.Get_CC1(Direction:integer):ICoordNode;
var
 Unk:IUnknown;
begin
  if Direction=0 then
    Unk:=FC1
  else
    Unk:=FC0;
  Result:=Unk as ICoordNode;
end;

procedure TLine.Set_CC0(Direction:integer; const Value:ICoordNode);
begin
  if Direction=0 then
    Set_FieldValue(ord(linC0), Value as IUnknown)
  else
    Set_FieldValue(ord(linC1), Value as IUnknown)
end;

procedure TLine.Set_CC1(Direction:integer; const Value:ICoordNode);
begin
  if Direction=0 then
    Set_FieldValue(ord(linC1), Value as IUnknown)
  else
    Set_FieldValue(ord(linC0), Value as IUnknown)
end;

function TLine.Get_Parents: IDMCollection;
begin
  Result:=FParents
end;

function TLine.InLineWith(W1, W2, W3:double; Side, Plain:integer;
          Projection:WordBool):integer;

    function Min(A,B:real):real;
    begin if A<=B then Min:=A else Min:=B end;

    function Max(A,B:real):real;
    begin if A>=B then Max:=A else Max:=B end;

var
  AX, AY, AZ, MX, MY, MZ:double;
  C0, C1:ICoordNode;
  WX, WY, WZ, X0, Y0, Z0, X1, Y1, Z1:double;
begin
  Result:=0;
  C0:=Get_C0;
  C1:=Get_C1;
  if C0=nil then Exit;
  if C1=nil then Exit;
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Z;

  case Plain of
  0:begin
      WX:=W1;
      WY:=W2;
      WZ:=W3;
      if Projection then begin
        Z0:=0;
        Z1:=0;
        WZ:=0;
      end;
      if (abs(Z0-WZ)>1.e-6) or
         (abs(Z1-WZ)>1.e-6) then begin
        Result:=0;
        Exit;
      end;
      if abs(Y1-Y0)>=1.e-6 then begin
        AX:=X0+(X1-X0)/(Y1-Y0)*(WY-Y0);
        MX:=(AX-X0)*(AX-X1);
        if MX<0 then begin
          if AX>WX then
            case Side of
            0:Result:=0;
            1:Result:=1;
            end
          else if AX=WX then
            Result:=2
          else
          if AX<WX then
            case Side of
            0:Result:=1;
            1:Result:=0;
            end
        end else
        if MX=0 then begin
          if abs(X1-X0)>=1.e-6 then begin
            if AX>WX then
              case Side of
              0: Result:=0;
              1:
                begin
                  if WY=Min(Y0, Y1) then
                    Result:=1
                  else
                    Result:=0;
                end;
              end
            else
            if AX=WX then
              Result:=2
            else
            if AX<WX then
              case Side of
              0:begin
                  if WY=Min(Y0, Y1) then
                    Result:=1
                  else
                    Result:=0
                end;
              1:Result:=0;
              end
          end else
          if abs(X1-X0)<1.e-6 then begin
            MY:=(WY-Y0)*(WY-Y1);
            if MY<0 then begin
              if AX>WX then
                case Side of
                0:Result:=0;
                1:Result:=1;
                end
              else
              if AX=WX then
                Result:=2
              else
              if AX<WX then
                case Side of
                0:Result:=1;
                1:Result:=0;
                end
            end else
            if MY=0 then begin
              if AX>WX then
                case Side of
                0:Result:=0;
                1:begin
                    if WY=Min(Y0, Y1) then
                      Result:=1
                    else
                      Result:=0
                    end;
                end
              else
              if AX=WX then
                Result:=2
             else
              if AX<WX then
                case Side of
                0:begin
                    if WY=Min(Y0, Y1) then
                      Result:=1
                    else
                      Result:=0;
                    end;
                1:Result:=0;
                end
            end else
            if MY>0 then
              Result:=0
          end
        end else
          if MX>0 then
            Result:=0
      end else
      if abs(WY-Y0)>1.e-6 then
        Result:=0
      else begin
        if (WX<Min(X0, X1)) or (WX>Max(X0, X1)) then
          Result:=0
        else
          Result:=2
      end;
    end;

  1:begin
      WY:=W1;
      WZ:=W2;
      WX:=W3;
      if Projection then begin
        X0:=0;
        X1:=0;
        WX:=0;
      end;
      if (abs(X0-WX)>1.e-6) or
         (abs(X1-WX)>1.e-6) then begin
        Result:=0;
        Exit;
      end;
      if abs(Z1-Z0)>=1.e-6 then begin
        AY:=Y0+(Y1-Y0)/(Z1-Z0)*(WZ-Z0);
        MY:=(AY-Y0)*(AY-Y1);
        if MY<0 then begin
          if AY>WY then
            case Side of
            0:Result:=0;
            1:Result:=1;
            end
          else if AY=WY then
            Result:=2
          else
          if AY<WY then
            case Side of
            0:Result:=1;
            1:Result:=0;
            end
        end else
        if MY=0 then begin
          if abs(Y1-Y0)>=1.e-6 then begin
            if AY>WY then
              case Side of
              0: Result:=0;
              1:
                begin
                  if WZ=Min(Z0, Z1) then
                    Result:=1
                  else
                    Result:=0;
                end;
              end
            else
            if AY=WY then
              Result:=2
            else
            if AY<WY then
              case Side of
              0:begin
                  if WZ=Min(Z0, Z1) then
                    Result:=1
                  else
                    Result:=0
                end;
              1:Result:=0;
              end
          end else
          if abs(Y1-Y0)<1.e-6 then begin
            MZ:=(WZ-Z0)*(WZ-Z1);
            if MZ<0 then begin
              if AY>WY then
                case Side of
                0:Result:=0;
                1:Result:=1;
                end
              else
              if AY=WY then
                Result:=2
              else
              if AY<WY then
                case Side of
                0:Result:=1;
                1:Result:=0;
                end
            end else
            if MZ=0 then begin
              if AY>WY then
                case Side of
                0:Result:=0;
                1:begin
                    if WZ=Min(Z0, Z1) then
                      Result:=1
                    else
                      Result:=0
                    end;
                end
              else
              if AY=WY then
                Result:=2
             else
              if AY<WY then
                case Side of
                0:begin
                    if WZ=Min(Z0, Z1) then
                      Result:=1
                    else
                      Result:=0;
                    end;
                1:Result:=0;
                end
            end else
            if MZ>0 then
              Result:=0
          end
        end else
          if MY>0 then
            Result:=0
      end else
      if abs(WZ-Z0)>1.e-6 then
        Result:=0
      else begin
        if (WY<Min(Y0, Y1)) or (WY>Max(Y0, Y1)) then
          Result:=0
        else
          Result:=2
      end;
    end;

  2:begin
      WZ:=W1;
      WX:=W2;
      WY:=W3;
      if Projection then begin
        Y0:=0;
        Y1:=0;
        WZ:=0;
      end;
      if (abs(Y0-WY)>1.e-6) or
         (abs(Y1-WY)>1.e-6) then begin
        Result:=0;
        Exit;
      end;
      if abs(X1-X0)>=1.e-6 then begin
        AZ:=Z0+(Z1-Z0)/(X1-X0)*(WX-X0);
        MZ:=(AZ-Z0)*(AZ-Z1);
        if MZ<0 then begin
          if AZ>WZ then
            case Side of
            0:Result:=0;
            1:Result:=1;
            end
          else if AZ=WZ then
            Result:=2
          else
          if AZ<WZ then
            case Side of
            0:Result:=1;
            1:Result:=0;
            end
        end else
        if MZ=0 then begin
          if abs(Z1-Z0)>=1.e-6 then begin
            if AZ>WZ then
              case Side of
              0: Result:=0;
              1:
                begin
                  if WX=Min(X0, X1) then
                    Result:=1
                  else
                    Result:=0;
                end;
              end
            else
            if AZ=WZ then
              Result:=2
            else
            if AZ<WZ then
              case Side of
              0:begin
                  if WX=Min(X0, X1) then
                    Result:=1
                  else
                    Result:=0
                end;
              1:Result:=0;
              end
          end else
          if abs(Z1-Z0)<1.e-6 then begin
            MX:=(WX-X0)*(WX-X1);
            if MX<0 then begin
              if AZ>WZ then
                case Side of
                0:Result:=0;
                1:Result:=1;
                end
              else
              if AZ=WZ then
                Result:=2
              else
              if AZ<WZ then
                case Side of
                0:Result:=1;
                1:Result:=0;
                end
            end else
            if MX=0 then begin
              if AZ>WZ then
                case Side of
                0:Result:=0;
                1:begin
                    if WX=Min(X0, X1) then
                      Result:=1
                    else
                      Result:=0
                    end;
                end
              else
              if AZ=WZ then
                Result:=2
             else
              if AZ<WZ then
                case Side of
                0:begin
                    if WX=Min(X0, X1) then
                      Result:=1
                    else
                      Result:=0;
                    end;
                1:Result:=0;
                end
            end else
            if MX>0 then
              Result:=0
          end
        end else
          if MZ>0 then
            Result:=0
      end else
      if abs(WX-X0)>1.e-6 then
        Result:=0
      else begin
        if (WZ<Min(Z0, Z1)) or (WZ>Max(Z0, Z1)) then
          Result:=0
        else
          Result:=2
      end;
    end;

  end;
end;

function TLine.NextNodeTo(const Node: ICoordNode): ICoordNode;
var
  C0, C1:ICoordNode;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  if Node=C0 then
    Result:=C1
  else if Node=C1 then
    Result:=C0
  else
    Raise Exception.Create('Error in TLine.NextNodeTo');
end;

function TLine.Get_ZAngle: double;
var
  cos_A, L:double;
  C0, C1:ICoordNode;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  L:=sqrt(sqr(C1.X-C0.X)+sqr(C1.Y-C0.Y));
  if L=0 then
    Result:=0
  else begin
    cos_A:=(C1.X-C0.X)/L;
    Result:=arccos(cos_A)/3.1415926*180;
    if C1.Y-C0.Y<0 then
      Result:=-Result;
  end;
end;

procedure TLine.Set_ZAngle(Value:double);
begin
end;

class function TLine.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TLine.MakeFields0;
begin
  inherited;
  AddField(rsC0, '', '', '',
      fvtElement, -1, 0, 0,
      ord(linC0), 0, pkInput);
  AddField(rsC1, '', '', '',
      fvtElement, -1, 0, 0,
      ord(linC1), 0, pkInput);
  AddField(rsThickness, '%5.1f', '', '',
      fvtFloat, 0, 0, 0,
      ord(linThickness), 0, pkInput);
  AddField(rsStyle, '%2d', '', '',
      fvtInteger, 0, 0, 0,
      ord(linStyle), 0, pkInput);
end;

function TLine.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(linThickness):
    Result:=FThickness;
  ord(linStyle):
    Result:=FStyle;
  ord(linC0):
    if not VarIsEmpty(FC0) then
      Result:=FC0
    else
      Result:=Null;
  ord(linC1):
    if not VarIsEmpty(FC1) then
      Result:=FC1
    else
      Result:=Null
  else
    Result:=inherited GetFieldValue(Code);
  end
end;

procedure TLine.SetFieldValue_(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(linThickness):
    FThickness:=Value;
  ord(linStyle):
    FStyle:=Value;
  ord(linC0):
    begin
      if ((DataModel=nil) or
           not DataModel.IsLoading) and
         not VarIsNull(FC0) and
         not VarIsEmpty(FC0) and
         (Get_C0<>nil) then
        (Get_C0.Lines as IDMCollection2).Remove(Self as IDMElement);
      FC0:=Value;
      if ((DataModel=nil) or
           not DataModel.IsLoading) and
         not VarIsNull(FC0) and
         not VarIsEmpty(FC0) and
         (Get_C0<>nil) then
        (Get_C0.Lines as IDMCollection2).Add(Self as IDMElement);
    end;
  ord(linC1):
    begin
      if ((DataModel=nil) or
           not DataModel.IsLoading) and
         not VarIsNull(FC1) and
         not VarIsEmpty(FC1) and
         (Get_C1<>nil) then
        (Get_C1.Lines as IDMCollection2).Remove(Self as IDMElement);
      FC1:=Value;
      if ((DataModel=nil) or
           not DataModel.IsLoading) and
         not VarIsNull(FC1) and
         not VarIsEmpty(FC1) and
         (Get_C1<>nil) then
        (Get_C1.Lines as IDMCollection2).Add(Self as IDMElement);
    end;
  else
    inherited;
  end;
end;

procedure TLine.GetFieldValueSource(Index: Integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Index of
  ord(linC0),
  ord(linC1):
    theCollection:=(DataModel as ISpatialModel).CoordNodes
  else
    begin
      inherited;
      Exit;
    end;
  end;
  if aCollection=nil then
    aCollection:=theCollection
  else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

procedure TLine.Loaded;
begin
  inherited;
  if Get_C0=nil then Exit;
  if Get_C1=nil then Exit;
  (Get_C0.Lines as IDMCollection2).Add(Self as IDMElement);
  (Get_C1.Lines as IDMCollection2).Add(Self as IDMElement);
end;

function TLine.CanIntersectLine(const aLine: ILine;
                       var WX, WY, WZ:double):WordBool;
var
  P0X, P0Y, P0Z,
  P1X, P1Y, P1Z,
  P2X, P2Y, P2Z,
  P3X, P3Y, P3Z:double;
  C0, C1:ICoordNode;
begin
  Result:=False;
  C0:=Get_C0;
  C1:=Get_C1;
  if C0=aLine.C0 then Exit;
  if C0=aLine.C1 then Exit;
  if C1=aLine.C0 then Exit;
  if C1=aLine.C1 then Exit;
  P0X:=C0.X;
  P0Y:=C0.Y;
  P0Z:=C0.Z;
  P1X:=C1.X;
  P1Y:=C1.Y;
  P1Z:=C1.Z;
  P2X:=aLine.C0.X;
  P2Y:=aLine.C0.Y;
  P2Z:=aLine.C0.Z;
  P3X:=aLine.C1.X;
  P3Y:=aLine.C1.Y;
  P3Z:=aLine.C1.Z;
  Result:=LineCanIntersectLine(P0X, P0Y, P0Z,
                               P1X, P1Y, P1Z,
                               P2X, P2Y, P2Z,
                               P3X, P3Y, P3Z,
                               WX,  WY,  WZ);
end;

function  TLine.Get_Style:integer;
begin
  Result:=FStyle
end;

procedure TLine.Set_Style(Value: integer);
begin
  Set_FieldValue(ord(linStyle), Value)
end;

procedure TLine.UpdateAreas(const aPainter:IPainter);
var
  Line1,  Line2,  Line3: ILine;
  Line1E, Line2E, Line3E:IDMElement;
  aArea, NewArea:IArea;
  aAreaE:IDMElement;
  aAreaP:IPolyline;
  j, j0, j01, j1, j2, i0, i1:integer;
  Found:boolean;
  NewAreaE:IDMElement;
  C0, C1:ICoordNode;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  Found:=False;
  aArea:=nil;
  j0:=0;
  while (j0<C0.Lines.Count) and not Found do begin
    Line1E:=C0.Lines.Item[j0];
    Line1:=Line1E as ILine;
    j1:=0;
    while (j1<Line1E.Parents.Count) and not Found do begin
      if Line1E.Parents.Item[j1].QueryInterface(IArea, aArea)=0 then begin
        j01:=j0+1;
        while (j01<C0.Lines.Count) and not Found do begin
          Line2E:=C0.Lines.Item[j01];
          Line2:=Line2E as ILine;
          j2:=0;
          while (j2<Line2E.Parents.Count) and not Found do begin
            if (aArea as IDMElement)=Line2E.Parents.Item[j2] then begin
              i0:=0;
              while (i0<C1.Lines.Count) and not Found do begin
                Line3E:=C1.Lines.Item[i0];
                Line3:=Line3E as ILine;
                i1:=0;
                while (i1<Line3E.Parents.Count) and not Found do begin
                  if (aArea as IDMElement)=Line3E.Parents.Item[i1] then
                    Found:=True;
                  inc(i1);
                end;
                inc(i0);
              end;
            end;
            inc(j2);
          end;
          inc(j01);
        end;
      end;
      inc(j1);
    end;
    inc(j0);
  end;
  if Found then begin
    aAreaE:=aArea as IDMElement;
    aAreaP:=aArea as IPolyline;

    NewAreaE:=DataModel.CreateElement(_Area);
    NewArea:=NewAreaE as IArea;

    NewArea.IsVertical:=aArea.IsVertical;
    NewArea.Volume0:=aArea.Volume0;
    NewArea.Volume1:=aArea.Volume1;

    while (aAreaP.Lines.Count>0) do begin
      Line1E:=aAreaP.Lines.Item[0];
      Line1:=Line1E as ILine;
      Line2:=aAreaP.Lines.Item[1] as ILine;

      Line1E.RemoveParent(aAreaE);
      Line1E.AddParent(NewAreaE);

      if (not ((Line1.C0<>C0)  and
               (Line1.C0<>C1)  and
               (Line1.C1<>C0)  and
               (Line1.C1<>C1))) and
         (not ((Line2.C0<>C0)  and
               (Line2.C0<>C1)  and
               (Line2.C1<>C0)  and
               (Line2.C1<>C1))) then Break;
    end;

    AddParent(NewAreaE);

    j:=2;
    while (j<aAreaP.Lines.Count) and
          ((aAreaP.Lines.Item[j] as ILine).C0<>C0) and
          ((aAreaP.Lines.Item[j] as ILine).C0<>C1) and
          ((aAreaP.Lines.Item[j] as ILine).C1<>C0) and
          ((aAreaP.Lines.Item[j] as ILine).C1<>C1) do
      inc(j);
    inc(j);
    while (j<aAreaP.Lines.Count) do begin
      Line1E:=aAreaP.Lines.Item[j];

      Line1E.RemoveParent(aAreaE);
      Line1E.AddParent(NewAreaE);

    end;

    AddParent(aAreaE);

  end;
end;

procedure TLine.Set_Parent(const Value:IDMElement);
var
  C0, C1:ICoordNode;
begin
  if id=51568 then
    XXX:=0;
  inherited;
  if Value=nil then Exit;
  if DataModel=nil then Exit;
  if DataModel.IsCopying then Exit;
  if DataModel.InUndoRedo then Exit;
  C0:=Get_C0;
  C1:=Get_C1;
  if not DataModel.IsLoading then begin
    if C0<>nil then
      (C0 as IDMElement).Parent:=Value;
    if C1<>nil then
      (C1 as IDMElement).Parent:=Value;
  end;  
end;

function  TLine.GetCopyLinkMode(const aLink: IDMElement): Integer;
var
  Node:ICoordNode;
begin
  if aLink=nil then
    Result:=clmNil
  else
  if aLink.QueryInterface(ICoordNode, Node)=0then
    Result:=clmNewLink
  else
    Result:=inherited GetCopyLinkMode(aLink);
end;
procedure TLine.AddParent(const aParent:IDMElement);
begin
  inherited;
end;

procedure TLine.RemoveParent(const aParent:IDMElement);
begin
  inherited
end;

procedure TLine.Set_Selected(Value: WordBool);
var
  Painter:IUnknown;
  Document:IDMDocument;
  C0, C1:ICoordNode;
  C0E:IDMElement;
  X0, Y0, X1, Y1:double;
begin
  if Selected=Value then Exit;
  inherited;
  if DataModel=nil then Exit;
  if DataModel.InUndoRedo then Exit;
  if Value then Exit;
  C0:=Get_C0;
  C1:=Get_C1;
  if C0=nil then Exit;
  if C1=nil then Exit;
  X0:=C0.X;
  Y0:=C0.Y;
  X1:=C1.X;
  Y1:=C1.Y;
  if (X0=X1) and (Y0=Y1) then begin
    Document:=DataModel.Document as IDMDocument;
    Painter:=(Document as ISMDocument).PainterU;
    C0E:=C0 as IDMElement;
    C0E.Draw(Painter, -1);
  end;
end;

function TLine.Get_IsVertical:WordBool;
var
  C0, C1:ICoordNode;
  L, D:Double;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  L:=Get_Length;
  if L<>0 then begin
    D:=sqrt(sqr(C0.X-C1.X)+sqr(C0.Y-C1.Y));
    Result:=(D<20) and
            (D/L<0.25)      //наклон меньше ~15 градусов
  end else
    Result:=False
end;

{ TLines }

class function TLines.GetElementClass: TDMElementClass;
begin
  Result:=TLine;
end;


function TLines.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLine
end;

class function TLines.GetElementGUID: TGUID;
begin
  Result:=IID_ILine
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TLine.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
