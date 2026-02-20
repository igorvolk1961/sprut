unit SGCoordNodeU;

interface
uses
  Graphics,
  DMElementU, DataModel_TLB, SgdbLib_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  CoordNodeU;

type
  TSGCoordNode=class(TCoordNode)
  private
  protected
    class function  GetClassID:integer; override;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
  end;

  TSGCoordNodes=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function  GetElementGUID:TGUID; override;
  end;

implementation

{ TSGCoordNode }

procedure TSGCoordNode.Draw(const aPainter: IInterface;
  DrawSelected: integer);
begin
  if aPainter=nil then Exit;
  if (DrawSelected<>0) or
    (Layer.Visible and
     (FLines.Count=0)) then
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

class function TSGCoordNode.GetClassID: integer;
begin
  Result:=_SGCoordNode
end;

{ TSGCoordNodes }

class function TSGCoordNodes.GetElementClass: TDMElementClass;
begin
  Result:=TSGCoordNode
end;

class function TSGCoordNodes.GetElementGUID: TGUID;
begin
  Result:=IID_ICoordNode
end;

end.
