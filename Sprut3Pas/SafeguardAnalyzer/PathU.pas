unit PathU;

interface
uses
  Classes, SysUtils,
  DMElementU, PolylineU,
  DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardAnalyzerLib_TLB;

type

  TPath=class(TPolyline, IPath)
  private
    FFirstNode:IDMElement;
    FNodes:IDMCollection;
  protected
    class function  GetClassID:integer; override;
    function GetLineClassID: integer; override;

    procedure Initialize; override;
    procedure _Destroy; override;

  end;

  TPaths=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;

  end;

implementation
uses
  SafeguardAnalyzerConstU;

{ TPath }


class function TPath.GetClassID: integer;
begin
  Result:=_Path
end;


function TPath.GetLineClassID: integer;
begin
  Result:=_PathArc
end;

procedure TPath._Destroy;
begin
  inherited;
end;

procedure TPath.Initialize;
begin
  inherited;
end;

{ TPaths }

function TPaths.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsPath
end;

class function TPaths.GetElementClass: TDMElementClass;
begin
  Result:=TPath
end;

class function TPaths.GetElementGUID: TGUID;
begin
  Result:=IID_IPath
end;

end.
