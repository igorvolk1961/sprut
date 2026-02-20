unit SGAreaU;

interface
uses
  Graphics,
  DMElementU, DataModel_TLB, SgdbLib_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  AreaU;

type
  TSGArea=class(TArea)
  private
  protected
    class function  GetClassID:integer; override;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;

    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
    procedure Initialize; override;
  end;

  TSGAreas=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function  GetElementGUID:TGUID; override;
  end;

implementation
uses
  SpatialModelConstU,
  SGLineU;

{ TSGArea }

procedure TSGArea.Draw(const aPainter: IInterface; DrawSelected: integer);
var
  Painter:IPainter;
begin
  if Layer=nil then Exit;
  if not Layer.Visible then Exit;
  if DataModel=nil then Exit;
  if aPainter=nil then Exit;
  if (FStyle<>0) or
     (Color<>0) then begin
    Painter:=aPainter as IPainter;

    if DrawSelected=-1 then begin
      Painter.PenColor:=clWhite;
      Painter.BrushColor:=clWhite;
      Painter.BrushStyle:=0;
    end else begin
      Painter.PenColor:=Color;
      Painter.BrushColor:=Color;
      Painter.BrushStyle:=FStyle;
    end;
    Painter.DrawPolygon(Lines, False);
  end;
  inherited;
end;

class function TSGArea.GetClassID: integer;
begin
  Result:=_SGArea
end;

procedure TSGArea.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;
  aOperations:=leoSelect;
end;

procedure TSGArea.GetFieldValueSource(Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(areVolume0),
  ord(areVolume1):
    theCollection:=(DataModel as IDMElement).Collection[_SGVolume];
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

procedure TSGArea.Initialize;
begin
  inherited;
  FLines:=DataModel.CreateCollection(_SGLine, Self as IDMElement);
end;

procedure TSGArea.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  case Index of
  0:begin
    aCollection2:=aCollection as IDMCollection2;
    SourceCollection:=Parent.Collection[2];
    aCollection2.Clear;
    for j:=0 to SourceCollection.Count-1 do
      aCollection2.Add(SourceCollection.Item[j]);
    end;
  end;
end;


{ TSGAreas }

class function TSGAreas.GetElementClass: TDMElementClass;
begin
  Result:=TSGArea
end;

class function TSGAreas.GetElementGUID: TGUID;
begin
  Result:=IID_IArea
end;

end.
