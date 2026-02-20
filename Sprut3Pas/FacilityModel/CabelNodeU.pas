unit CabelNodeU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardElementU;

type

  TCabelNode=class(TSafeguardElement, ICabelNode)
  private
  protected
    FConnections:IDMCollection;

    function Get_Connections:IDMCollection; safecall;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;

    procedure Initialize; override;
    procedure  _Destroy; override;

  end;

implementation

uses
  FacilityModelConstU;

{ TCabelNode }


procedure TCabelNode.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  1:begin
      aCollectionName:=rsConnections;
      if DataModel<>nil then
        aRefSource:=(DataModel as IDMElement).Collection[_ControlDevice]
      else
        aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  else
    inherited
  end;    
end;

function TCabelNode.Get_Connections:IDMCollection;
begin
  Result:=FConnections
end;

function TCabelNode.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  1:   Result:=FConnections;
  else
     Result:=inherited Get_Collection(Index);
  end;
end;

function TCabelNode.Get_CollectionCount: integer;
begin
  Result:=inherited Get_CollectionCount+1
end;

procedure TCabelNode.Initialize;
begin
  inherited;
  FConnections:=DataModel.CreateCollection(_Connection, Self as IDMElement);
end;

procedure TCabelNode.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  case Index of
  1:begin
      aCollection2:=aCollection as IDMCollection2;
      SourceCollection:=(DataModel as IFacilityModel).Cabels;
      aCollection2.Clear;
      for j:=0 to SourceCollection.Count-1 do
       aCollection2.Add(SourceCollection.Item[j]);
    end;
  else
    inherited  
  end;
end;

procedure  TCabelNode._Destroy;
begin
  inherited;
  FConnections:=nil
end;

end.
