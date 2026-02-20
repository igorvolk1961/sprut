unit CoordNodeU;

interface
uses
  Classes, SysUtils, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SpatialElementU, Variants;

type

  TCoordNode=class(TSpatialElement, ICoord, ICoordNode, IRotater)
  private
  protected
    FX:double;
    FY:double;
    FZ:double;
    FTag:integer;

    FLines:IDMCollection;

    procedure Initialize; override;
    procedure  _Destroy; override;

    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    procedure Loaded; override;
    procedure Set_Ref(const Value:IDMElement); override;

    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure ClearOp; override; safecall;
    function  Get_CollectionCount:integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;


    function  GetCopyLinkMode(const aLink: IDMElement): Integer; override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;

    function Get_X:double; safecall;
    function Get_Y:double; safecall;
    function Get_Z:double; safecall;
    function Get_Tag:integer; safecall;
    function Get_TagRef:IDMElement; safecall;
    procedure Set_X(Value:double); safecall;
    procedure Set_Y(Value:double); safecall;
    procedure Set_Z(Value:double); safecall;
    procedure Set_Tag(Value:integer); safecall;
    procedure Set_TagRef(const Value:IDMElement); safecall;
    function  Get_Lines: IDMCollection; safecall;
    function  GetVerticalLine(Direction:integer):ILine; safecall;
    function  DistanceFrom(WX, WY, WZ:double):double; safecall;
// IRotater
    procedure Rotate(X0, Y0, cosA, sinA:double); safecall;
  end;

  TCoordNodes=class(TDMCollection)
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

{ TCoordNode }

procedure TCoordNode.Initialize;
begin
  inherited;
  FLines:=DataModel.CreateCollection(-1, Self as IDMElement);
  FTag:=0;
end;

procedure TCoordNode._Destroy;
begin
  inherited;
  FLines:=nil;
end;

class function TCoordNode.GetClassID: integer;
begin
  Result:=_CoordNode;
end;


function TCoordNode.DistanceFrom(WX, WY, WZ:double): double;
var
  dx, dy, dz, R2:double;
begin
  dx:=WX-FX;
  dy:=WY-FY;
  dz:=WZ-FZ;
  R2:=dx*dx+dy*dy+dz*dz;
  Result:=sqrt(R2);
end;

procedure TCoordNode.Draw(const aPainter:IUnknown; DrawSelected:integer);
  function DrawCircle:boolean;
  var
    Line0, Line1:ILine;
    Line0E, Line1E:ISpatialElement;
    C0, C1:ICoordNode;
    D, L:double;
  begin
    Result:=True;
    if FLines.Count=0 then Exit;
    if FLines.Count=2 then begin
      Line0:=FLines.Item[0] as ILine;
      Line1:=FLines.Item[1] as ILine;
      Line0E:=FLines.Item[0] as ISpatialElement;
      Line1E:=FLines.Item[1] as ISpatialElement;
      if (Line0E.Layer=Line1E.Layer) and
         (Line0E.Color=Line1E.Color) and
         (Line0.Thickness=Line1.Thickness) and
         (Line0.Style=Line1.Style) then begin
        C0:=Line0.NextNodeTo(Self as ICoordNode);
        C1:=Line1.NextNodeTo(Self as ICoordNode);
        L:=sqrt(sqr(C1.X-C0.X)+sqr(C1.Y-C0.Y)+sqr(C1.Z-C0.Z))*0.01;
        if abs(C1.Z-C0.Z)>L then begin
          D:=(FZ-C0.Z)/(C1.Z-C0.Z);
          if (abs(FX-(C0.X+(C1.X-C0.X)*D))<L) and
             (abs(FY-(C0.Y-(C1.Y-C0.Y)*D))<L) then Exit;
        end else
        if abs(C1.Y-C0.Y)>1.e-6 then begin
          D:=(FY-C0.Y)/(C1.Y-C0.Y);
          if (abs(FX-(C0.X+(C1.X-C0.X)*D))<L) and
             (abs(FZ-(C0.Z-(C1.Z-C0.Z)*D))<L) then Exit;
        end else
          if abs(FY-C0.Y)<L then Exit
      end;
    end;
    Result:=False;
  end;
begin
  if aPainter=nil then Exit;
  if Parent=nil then Exit;
  if (DrawSelected<>0) or
    (Layer.Visible and
     DrawCircle) then
  with aPainter as IPainter do begin
    if (DrawSelected=1) then
      PenColor:=clLime
    else if (DrawSelected=-1) then
      PenColor:=clWhite
    else if Layer=nil then
      PenColor:=Color
    else
      PenColor:=Layer.Color;
    if DrawSelected=3 then
      PenMode:=ord(pmNotXor)
    else
      PenMode:=ord(pmCopy);
    DrawPoint(FX, FY, FZ);
  end;
end;


procedure TCoordNode.ClearOp;
var
  aLine:ILine;
begin
  inherited;
  while FLines.Count>0 do begin
    aLine:=FLines.Item[0] as ILine;
    if aLine.C0=Self as ICoordNode then
      aLine.C0:=nil
    else
    if aLine.C1=Self as ICoordNode then
      aLine.C1:=nil;
  end;
end;

function TCoordNode.GetVerticalLine(Direction:integer): ILine;
var
  j:integer;
  aCoord:ICoordNode;
  L, D:double;
  Line:ILine;
  LineE:IDMElement;
begin
  Result:=nil;
  for j:=0 to FLines.Count-1 do begin
    LineE:=FLines.Item[j];
    Line:=LineE as ILine;
    aCoord:=Line.NextNodeTo(Self as ICoordNode);
    L:=Line.Length;
    D:=sqrt(sqr(aCoord.X-FX)+sqr(aCoord.Y-FY));
    if (D<20) and
       (D/L<0.25) then begin
      case Direction of
      0:if (aCoord.Z>FZ) and
           (aCoord=Line.C1) then begin
          Result:=FLines.Item[j] as  ILine;
          Exit;
        end;
      1:if (aCoord.Z<FZ) and
           (aCoord=Line.C0) then begin
          Result:=FLines.Item[j] as  ILine;
          Exit;
        end;
      end;
   end;
  end;
end;

function TCoordNode.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:Result:=FLines;
  else
    Result:=inherited Get_Collection(Index-1)
  end;
end;

function TCoordNode.Get_CollectionCount: integer;
begin
  Result:=inherited Get_CollectionCount + 1
end;

function TCoordNode.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cooX):
    Result:=FX;
  ord(cooY):
    Result:=FY;
  ord(cooZ):
    Result:=FZ;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

function TCoordNode.Get_X: double;
begin
  Result:=FX
end;

function TCoordNode.Get_Y: double;
begin
  Result:=FY
end;

function TCoordNode.Get_Z: double;
begin
  Result:=FZ
end;

procedure TCoordNode.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
    case Index of
    0:begin
        aCollectionName:=FLines.ClassAlias[akImenitM];
        aOperations:=0;
        aRefSource:=nil;
        aClassCollections:=nil;
        aLinkType:=ltManyToMany;
      end;
    else
      inherited GetCollectionProperties(Index-1,
      aCollectionName, aRefSource, aClassCollections, aOperations, aLinkType)
    end;
end;

class function TCoordNode.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TCoordNode.MakeFields0;
begin
  inherited;
  AddField(rsX, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cooX), 0, pkInput);
  AddField(rsY, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cooY), 0, pkInput);
  AddField(rsZ, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cooZ), 0, pkInput);
end;

procedure TCoordNode.SetFieldValue_(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(cooX):
    FX:=Value;
  ord(cooY):
    FY:=Value;
  ord(cooZ):
    FZ:=Value;
  else
    inherited;
  end;
end;

procedure TCoordNode.Set_X(Value: double);
begin
  Set_FieldValue(ord(cooX), Value)
end;

procedure TCoordNode.Set_Y(Value: double);
begin
  Set_FieldValue(ord(cooY), Value)
end;

procedure TCoordNode.Set_Z(Value: double);
begin
  Set_FieldValue(ord(cooZ), Value)
end;

function TCoordNode.Get_Lines: IDMCollection;
begin
  Result:=FLines
end;

function TCoordNode.Get_Tag: integer;
begin
  Result:=FTag
end;

procedure TCoordNode.Set_Tag(Value: integer);
begin
  FTag:=Value
end;

function TCoordNode.Get_TagRef: IDMElement;
var
  p:pointer;
begin
  if FTag=0 then
    Result:=nil
  else begin
    p:=pointer(FTag);
    Result:=IDMElement(p)
  end;
end;

procedure TCoordNode.Set_TagRef(const Value: IDMElement);
var
  p:pointer;
begin
  if Value=nil then
    FTag:=0
  else begin
    p:=pointer(Value);
    FTag:=integer(p)
  end;
end;

function TCoordNode.GetCopyLinkMode(const aLink: IDMElement): Integer;
var
  Line:ILine;
begin
  if aLink=nil then
    Result:=clmNil
  else
  if aLink.QueryInterface(ILine, Line)=0then
    Result:=clmNil
  else
    Result:=inherited GetCopyLinkMode(aLink);
end;

procedure TCoordNode.Loaded;
begin
  inherited;

end;

procedure TCoordNode.SetFieldValue(Code: integer; Value: OleVariant);
begin
  inherited;
end;

procedure TCoordNode.Rotate(X0, Y0, cosA, sinA: double);
var
  PX, PY:double;
begin
  PX:=X0+(FX-X0)*cosA+(FY-Y0)*sinA;
  PY:=Y0-(FX-X0)*sinA+(FY-Y0)*cosA;
  Set_X(PX);
  Set_Y(PY);
end;

procedure TCoordNode.Set_Ref(const Value: IDMElement);
begin
  inherited;
end;

{ TCoordNodes }

class function TCoordNodes.GetElementClass: TDMElementClass;
begin
  Result:=TCoordNode;
end;


function TCoordNodes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsCoordNode;
end;

class function TCoordNodes.GetElementGUID: TGUID;
begin
  Result:=IID_ICoordNode;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TCoordNode.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
