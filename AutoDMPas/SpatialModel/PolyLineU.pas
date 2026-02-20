unit PolyLineU;

interface
uses
  Classes, SysUtils, Dialogs,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, LineGroupU;

type

  TPolyLine=class(TLineGroup, IPolyLine)
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    procedure Update; override; safecall;
    procedure Set_Selected(value:WordBool); override;
    procedure ReorderLines(const Lines:IDMCollection); override;
  end;

  TPolyLines=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;


implementation
uses
  SpatialModelConstU,
  ReorderLinesU;

var
  FFields:IDMCollection;

{ TPolyLine }

class function TPolyLine.GetClassID: integer;
begin
  Result:=_PolyLine;
end;

procedure TPolyLine.Update;
begin
  inherited;
  ReorderLines(FLines);
end;

procedure TPolyLine.ReorderLines(const Lines:IDMCollection);
begin
  ReorderLines0(Lines, Self as IDMElement)
end;

class function TPolyLine.GetFields: IDMCollection;
begin
  Result:=FFields
end;

procedure TPolyLine.Set_Selected(value: WordBool);
begin
  inherited;

end;

{ TPolyLines }

class function TPolyLines.GetElementClass: TDMElementClass;
begin
  Result:=TPolyLine;
end;

function TPolyLines.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsPolyLine;
end;

class function TPolyLines.GetElementGUID: TGUID;
begin
  Result:=IID_IPolyLine;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TPolyLine.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.

