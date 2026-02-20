unit VolumeU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SpatialElementU;

type
  TVolume=class(TSpatialElement, IVolume, IVolume2)
  private
    FBottomAreas:IDMCollection;
    FTopAreas:IDMCollection;
    FMinZ:double;
    FMaxZ:double;
    function Get_Areas: IDMCollection; safecall;

    function Get_BottomAreas: IDMCollection; safecall;
    function Get_TopAreas: IDMCollection; safecall;

    function Get_BAreas(Direction:integer): IDMCollection; safecall;
    function Get_TAreas(Direction:integer): IDMCollection; safecall;
  protected
    FAreas:IDMCollection;

    procedure Initialize; override;
    procedure _Destroy; override;
    procedure ClearOp; override;

    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure Set_Ref(const Value:IDMElement); override; safecall;
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;

    procedure Set_Selected(Value: WordBool); override;

    property Areas:IDMCollection read Get_Areas;

    property BottomAreas:IDMCollection read Get_BottomAreas;
    property TopAreas:IDMCollection read Get_TopAreas;

    function  GetCopyLinkMode(const aLink: IDMElement): Integer; override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    procedure AfterLoading2; override; safecall;
    procedure Update; override; safecall;
    procedure UpdateCoords; override; safecall;

    function  Get_CollectionCount:integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    function Get_MaxZ: double; safecall;
    function Get_MinZ: double; safecall;
    procedure Set_MaxZ(Value: double); safecall;
    procedure Set_MinZ(Value: double); safecall;
    function  ContainsPoint(PX: Double; PY: Double; PZ: Double): WordBool; safecall;
    function  ContainsVolume(const aVolume:IVolume): WordBool; safecall;
    procedure RemoveChild(const Value:IDMElement); override; safecall;
    function AdjacentTo(const aVolume:IVolume):WordBool; safecall;
    function GetAreaClassID:integer; virtual;

// IVolume2
    function Get_OuterVolume: IVolume; safecall;
    function Get_InnerVolumeCount: Integer; safecall;
    function Get_InnerVolume(Index: Integer): IVolume; safecall;

  end;

  TVolumes=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation

uses
  SpatialModelConstU, Geometry, Outlines;

var
  FFields:IDMCollection;
  
{ TVolume }
procedure TVolume.Initialize;
var
  SelfE:IDMElement;
  AreaClassID:integer;
begin
  inherited;
  SelfE:=Self as IDMElement;
  AreaClassID:=GetAreaClassID;
  FAreas:=DataModel.CreateCollection(AreaClassID, SelfE);
  FBottomAreas:=DataModel.CreateCollection(AreaClassID, SelfE);
  FTopAreas:=DataModel.CreateCollection(AreaClassID, SelfE);
end;

procedure TVolume._Destroy;
begin
  inherited;
  FAreas:=nil;
  FBottomAreas:=nil;
  FTopAreas:=nil;
end;

class function TVolume.GetClassID: integer;
begin
  Result:=_Volume;
end;


procedure TVolume.ClearOp;
var
  aArea:IArea;
  aRef:IDMElement;
begin
  try
  if Ref<>nil then begin
    aRef:=Ref;
    Ref.SpatialElement:=nil;
  end else
    aRef:=nil;
  while Areas.Count>0 do begin
    aArea:=Areas.Item[0] as IArea;
    if aArea.Volume0=Self as IVolume then
      aArea.Volume0:=nil;
    if aArea.Volume1=Self as IVolume then
      aArea.Volume1:=nil;
    if (aArea.Volume0=nil) and
       (aArea.Volume1=nil) and
      not DataModel.IsCopying then
        DataModel.RemoveElement(aArea as IDMElement);
  end;
  inherited;
  except
    Raise
  end;
end;


procedure TVolume.Draw(const aPainter:IUnknown; DrawSelected:integer);
var
  Area:IArea;
  AreaE:IDMElement;
  j:integer;
begin
  for j:=0 to Areas.Count-1 do begin
    AreaE:=Areas.Item[j];
    Area:=AreaE as IArea;
    if Area.IsVertical then
      AreaE.Draw(aPainter, DrawSelected);
  end;
end;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
procedure TVolume.Update;
begin
  try
  inherited;
  UpdateCoords;
  if Ref<>nil then
    Ref.Update;
  except
    Raise
  end;
end;

function TVolume.Get_Areas: IDMCollection;
begin
  Result:=FAreas
end;

function TVolume.Get_BottomAreas: IDMCollection;
begin
  Result:=FBottomAreas
end;

function TVolume.Get_TopAreas: IDMCollection;
begin
  Result:=FTopAreas
end;

function TVolume.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:Result:=FAreas;
  else
    Result:=inherited Get_Collection(Index-1)
  end;
end;

function TVolume.Get_CollectionCount: integer;
begin
  Result:=inherited Get_CollectionCount + 1
end;

procedure TVolume.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
    case Index of
    0:begin
        aCollectionName:=FAreas.ClassAlias[akImenitM];
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

function TVolume.Get_MaxZ: double;
begin
  Result:=FMaxZ
end;

function TVolume.Get_MinZ: double;
begin
  Result:=FMinZ
end;

function TVolume.GetCopyLinkMode(const aLink: IDMElement): Integer;
var
  Area:IArea;
begin
  if aLink=nil then
    Result:=clmNil
  else
  if aLink.QueryInterface(IArea, Area)=0then
    Result:=clmNewLink
  else
    Result:=inherited GetCopyLinkMode(aLink);
end;

class function TVolume.GetFields: IDMCollection;
begin
  Result:=FFields
end;

procedure TVolume.Set_Parent(const Value: IDMElement);
begin
  inherited;
end;

procedure TVolume.Set_MaxZ(Value: double);
begin
  FMaxZ:=Value
end;

procedure TVolume.Set_MinZ(Value: double);
begin
  FMinZ:=Value
end;

function TVolume.ContainsPoint(PX, PY, PZ: Double): WordBool;
var
  j:integer;
  Area:IArea;
begin
  Result:=False;
  if FBottomAreas.Count<>0 then begin
    for j:=0 to FBottomAreas.Count-1 do begin
      Area:=FBottomAreas.Item[j] as IArea;
      if Area.ProjectionContainsPoint(PX, PY, 0) then begin
         if (FMaxZ>PZ+1.e-6) and
            (FMinZ<=PZ+1.e-6) then begin
           Result:=True;
           Break;
         end;
      end;
    end;
  end else begin
    for j:=0 to FTopAreas.Count-1 do begin
      Area:=FTopAreas.Item[j] as IArea;
     if Area.ProjectionContainsPoint(PX, PY, 0) then begin
         if (FMaxZ>PZ+1.e-6) and
            (FMinZ<=PZ) then begin
           Result:=True;
           Break;
         end;
      end;
   end;
 end;
end;

function TVolume.ContainsVolume(const aVolume: IVolume): WordBool;
var
  j, OldState:integer;
  aCollection, Collection:IDMCollection;
  aArea:IArea;
  Document:IDMDocument;
  SpatialModel2:ISpatialModel2;
begin
  try
  SpatialModel2:=DataModel as ISpatialModel2;

  Collection:=TDMCollection.Create(nil) as IDMCollection;
  aCollection:=TDMCollection.Create(nil) as IDMCollection;
  SpatialModel2.MakeVolumeOutline(Self as IVolume, Collection);
  SpatialModel2.MakeVolumeOutline(aVolume, aCollection);

  Result:=False;

  if aVolume.MinZ>=FMaxZ then begin
   (Collection as IDMCollection2).Clear;
   (aCollection as IDMCollection2).Clear;
   Exit;
  end;

  if aVolume.MaxZ<=FMinZ then begin
   (Collection as IDMCollection2).Clear;
   (aCollection as IDMCollection2).Clear;
    Exit;
  end;

  if  (aVolume.MinZ<=FMinZ) and
      (aVolume.MaxZ>FMaxZ) then begin
   (Collection as IDMCollection2).Clear;
   (aCollection as IDMCollection2).Clear;
    Exit;
  end;

  Document:=DataModel.Document as IDMDocument;
  OldState:=DataModel.State;
  DataModel.State:=DataModel.State or dmfCommiting;
                            // внутри происходит временное присвоение C.Z:=0
  Result:=OutlineContainsOutline(Collection, aCollection);

  DataModel.State:=OldState;

  if Result then
   for j:=0 to aVolume.BottomAreas.Count-1 do begin
    aArea:=aVolume.BottomAreas.Item[j] as IArea;
    if aArea.MaxZ<>aArea.MinZ then begin
     Result:=False;
     break;
    end;
   end;

  if Result then
   for j:=0 to aVolume.TopAreas.Count-1 do begin
    aArea:=aVolume.TopAreas.Item[j] as IArea;
    if aArea.MaxZ<>aArea.MinZ then begin
     Result:=False;
     break;
    end;
   end;

  if Result then
   for j:=0 to FBottomAreas.Count-1 do begin
    aArea:=FBottomAreas.Item[j] as IArea;
    if aArea.MaxZ<>aArea.MinZ then begin
     Result:=False;
     break;
    end;
   end;

  if Result then
   for j:=0 to FTopAreas.Count-1 do begin
    aArea:=FTopAreas.Item[j] as IArea;
    if aArea.MaxZ<>aArea.MinZ then begin
     Result:=False;
     break;
    end;
   end;

  (Collection as IDMCollection2).Clear;
  (aCollection as IDMCollection2).Clear;
  except
    raise
  end;
end;

procedure TVolume.RemoveChild(const Value: IDMElement);
begin
  inherited;

end;

function TVolume.Get_OuterVolume: IVolume;
var
  aVolumeE:IDMElement;
begin
  Result:=nil;
  if Ref=nil then Exit;
  if Ref.Parent=nil then Exit;
  aVolumeE:=Ref.Parent.SpatialElement;
  if aVolumeE=nil then Exit;
  aVolumeE.QueryInterface(IVolume, Result)
end;

function TVolume.Get_InnerVolume(Index: Integer): IVolume;
var
  aCollection:IDMCollection;
begin
  Result:=nil;
  if Ref=nil then Exit;
  if Ref.CollectionCount=0 then Exit;
  aCollection:=Ref.Collection[0];
  if Index>=aCollection.Count then Exit;
  Result:=aCollection.Item[Index].SpatialElement as IVolume;

end;

function TVolume.Get_InnerVolumeCount: Integer;
var
  aCollection:IDMCollection;
begin
  Result:=0;
  if Ref=nil then Exit;
  if Ref.CollectionCount=0 then Exit;
  aCollection:=Ref.Collection[0];
  Result:=aCollection.Count;
end;

procedure TVolume.UpdateCoords;
var
  SpatialModel2:ISpatialModel2;
begin
  inherited;
  SpatialModel2:=DataModel as ISpatialModel2;
  SpatialModel2.CalcVolumeMinMaxZ(Self as IVolume);
end;

function TVolume.AdjacentTo(const aVolume: IVolume): WordBool;
var
  j:integer;
  aAreaE:IDMElement;
begin
  Result:=False;
  if aVolume=Self as IVolume then Exit;
  Result:=True;
  j:=0;
  while j<FAreas.Count do begin
    aAreaE:=FAreas.Item[j];
    if  aVolume.Areas.IndexOf(aAreaE)<>-1 then
      Exit
    else
      inc(j)
  end;
  Result:=False;
end;

procedure TVolume.AfterLoading2;
begin
  inherited;
  UpdateCoords;
end;

function TVolume.GetAreaClassID: integer;
begin
  Result:=_Area
end;

procedure TVolume.Set_Selected(Value: WordBool);
var
  Painter:IUnknown;
  Document:IDMDocument;
  C0, C1:ICoordNode;
  C0E, C1E:IDMElement;
  Area:IArea;
  j:integer;
begin
  if Selected=Value then Exit;
  inherited;
  if DataModel=nil then Exit;
  if DataModel.InUndoRedo then Exit;
  if Value then Exit;
  Document:=DataModel.Document as IDMDocument;
  Painter:=(Document as ISMDocument).PainterU as IUnknown;
  for j:=0 to FAreas.Count-1 do begin
    Area:=FAreas.Item[j] as IArea;
    if Area.IsVertical then begin
      C0:=Area.C0;
      C1:=Area.C1;

      if C0<>nil then begin
        C0E:=C0 as IDMElement;
        C0E.Draw(Painter, -1);
      end;
      if C1<>nil then begin
        C1E:=C1 as IDMElement;
        C1E.Draw(Painter, -1);
      end;  
    end;  
  end;
end;

procedure TVolume.Set_Ref(const Value: IDMElement);
begin
  inherited;
end;

function TVolume.Get_BAreas(Direction: integer): IDMCollection;
begin
  if Direction=0 then
    Result:=FBottomAreas
  else
    Result:=FTopAreas
end;

function TVolume.Get_TAreas(Direction: integer): IDMCollection;
begin
  if Direction=0 then
    Result:=FTopAreas
  else
    Result:=FBottomAreas
end;

{ TVolumes }

class function TVolumes.GetElementClass: TDMElementClass;
begin
  Result:=TVolume;
end;

function TVolumes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsVolume;
end;

class function TVolumes.GetElementGUID: TGUID;
begin
  Result:=IID_IVolume;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TVolume.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
