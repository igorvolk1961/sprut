unit BoundaryTypeU;

interface
uses
  FacilityElementTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TBoundaryType=class(TFacilityElementType, IBoundaryType)
  private
  protected

    class function  GetClassID:integer; override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TBoundaryTypes=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TBoundaryType }

procedure TBoundaryType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_BoundaryKind, Self as IDMElement);
end;

procedure TBoundaryType._Destroy;
begin
  inherited;
  FSubKinds:=nil;
end;

class function TBoundaryType.GetClassID: integer;
begin
  Result:=_BoundaryType
end;

function TBoundaryType.Get_CollectionCount: integer;
begin
  Result:=ord(High(TBoundaryTypeCategory))+1;
end;

function TBoundaryType.Get_Collection(Index: Integer): IDMCollection;
begin
    Result:=inherited Get_Collection(Index)
end;

procedure TBoundaryType.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;
  aOperations:=aOperations or leoMove
end;

{ TBoundaryTypes }

class function TBoundaryTypes.GetElementClass: TDMElementClass;
begin
  Result:=TBoundaryType;
end;

class function TBoundaryTypes.GetElementGUID: TGUID;
begin
  Result:=IID_IBoundaryType;
end;

function TBoundaryTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsBoundaryType;
end;

end.
