unit SGImageRectU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB, SpatialModelLib_TLB,
  ImageRectU;

type
  TSGImageRect=class(TImageRect)
  private
  protected
    class function  GetClassID:integer; override;
    procedure GetFieldValueSource(Code: Integer; var aCollection: IDMCollection); override; safecall;
  end;

  TSGImageRects=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function  GetElementGUID:TGUID; override;
  end;

implementation
uses
  SpatialModelConstU;

{ TSGImageRect }

class function TSGImageRect.GetClassID: integer;
begin
  Result:=_SGImageRect
end;

procedure TSGImageRect.GetFieldValueSource(Code: Integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(linC0),
  ord(linC1):
    theCollection:=(DataModel as IDMElement).Collection[_SGCoordNode]
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

{ TSGImageRects }

class function TSGImageRects.GetElementClass: TDMElementClass;
begin
  Result:=TSGImageRect
end;

class function TSGImageRects.GetElementGUID: TGUID;
begin
  Result:=IID_IImageRect
end;

end.
