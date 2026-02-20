unit SGVolumeU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB, SpatialModelLib_TLB,
  VolumeU;

type
  TSGVolume=class(TVolume)
  private
  protected
    class function  GetClassID:integer; override;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
    function GetAreaClassID:integer; override;

    procedure Initialize; override;
  end;

  TSGVolumes=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function  GetElementGUID:TGUID; override;
  end;

implementation
uses
  SGAreaU;

{ TSGVolume }

class function TSGVolume.GetClassID: integer;
begin
  Result:=_SGVolume
end;

procedure TSGVolume.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;
  aOperations:=leoSelect;
end;

procedure TSGVolume.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  case Index of
  0:begin
    aCollection2:=aCollection as IDMCollection2;
    SourceCollection:=Parent.Collection[3];
    aCollection2.Clear;
    for j:=0 to SourceCollection.Count-1 do
      aCollection2.Add(SourceCollection.Item[j]);
    end;
  end;
end;

procedure TSGVolume.Initialize;
begin
  inherited;
end;

function TSGVolume.GetAreaClassID: integer;
begin
  Result:=_SGArea
end;

{ TSGVolumes }

class function TSGVolumes.GetElementClass: TDMElementClass;
begin
  Result:=TSGVolume
end;

class function TSGVolumes.GetElementGUID: TGUID;
begin
  Result:=IID_IVolume
end;

end.
