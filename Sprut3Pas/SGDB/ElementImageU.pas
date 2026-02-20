unit ElementImageU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  LayerU;

type
  TElementImage=class(TLayer, IElementImage)
  private
    FScalingType:integer;
    FXSize:double;
    FYSize:double;
    FZSize:double;
    FMinPixels:integer;
    FMaxSize:double;

    FCoordNodes:IDMCollection;
    FLines:IDMCollection;
    FCurvedLines:IDMCollection;
    FAreas:IDMCollection;
    FVolumes:IDMCollection;
    FImageRects:IDMCollection;
  protected
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function Get_ScalingType: integer; safecall;
    function Get_XSize:double; safecall;
    function Get_YSize:double; safecall;
    function Get_ZSize:double; safecall;
    function Get_MinPixels:integer; safecall;
    function Get_MaxSize:double; safecall;

    class function  GetClassID:integer; override;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    procedure AfterLoading1;override;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TElementImages=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation
uses
  SafeguardDatabaseConstU,
  SGCurvedLineU;

var
  FFields:IDMCollection;

{ TElementImage }

procedure TElementImage.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FCoordNodes:=DataModel.CreateCollection(_SGCoordNode, SelfE);
  FLines:=DataModel.CreateCollection(_SGLine, SelfE);
  FCurvedLines:=DataModel.CreateCollection(_SGCurvedLine, SelfE);
  FAreas:=DataModel.CreateCollection(_SGArea, SelfE);
  FVolumes:=DataModel.CreateCollection(_SGVolume, SelfE);
  FImageRects:=DataModel.CreateCollection(_SGImageRect, SelfE);
end;

procedure TElementImage._Destroy;
begin
  inherited;
  FCoordNodes:=nil;
  FLines:=nil;
  FCurvedLines:=nil;
  FAreas:=nil;
  FVolumes:=nil;
  FImageRects:=nil;
end;

class function TElementImage.GetClassID: integer;
begin
  Result:=_ElementImage
end;

function TElementImage.Get_ScalingType: integer;
begin
  Result:=FScalingType
end;

function TElementImage.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(eiScalingType):
    Result:=FScalingType;
  ord(eiMinPixels):
    Result:=FMinPixels;
  ord(eiMaxSize):
    Result:=FMaxSize;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TElementImage.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(eiScalingType):
    FScalingType:=Value;
  ord(eiMinPixels):
    FMinPixels:=Value;
  ord(eiMaxSize):
    FMaxSize:=Value;
  else
    inherited;
  end;
end;

class function TElementImage.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TElementImage.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:=
  '|'+rsNoScaling+
  '|'+rsScaling+
  '|'+rsXScaling+
  '|'+rsXYScaling+
  '|'+rsXYZScaling+
  '|'+rsConus+
  '|'+rsMultScaling;
  AddField(rsElementImageScalingType, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(eiScalingType), 0, pkInput);
  AddField(rsElementImageMinPixels, '%d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(eiMinPixels), 0, pkInput);
  AddField(rsElementImageMaxSize, '%0.1f', '', '',
                 fvtFloat, InfinitValue, 0, 0,
                 ord(eiMaxSize), 0, pkInput);
end;

function TElementImage.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:Result:=FCoordNodes;
  1:Result:=FCurvedLines;
  2:Result:=FLines;
  3:Result:=FAreas;
  4:Result:=FVolumes;
  5:Result:=FImageRects;
  end;
end;

function TElementImage.Get_CollectionCount: integer;
begin
  Result:=6
end;

procedure TElementImage.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  aCollectionName:=Get_Collection(Index).ClassAlias[akImenitM];
  aOperations:=0;
  aRefSource:=nil;
  aClassCollections:=nil;
  aLinkType:=ltOneToMany;
  case  Index of
  3,4:  aOperations:=leoAdd or leoDelete;  //Area, Volume
  end;
end;

procedure TElementImage.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  i:integer;
  Painter:IPainter;
begin
  Painter:=aPainter as IPainter;
  Painter.InsertBlock(Self as IUnknown);
  for i:=0 to FVolumes.Count-1 do
    if (FVolumes.Item[i].Ref=nil) and
       (not FVolumes.Item[i].Selected) then
      FVolumes.Item[i].Draw(aPainter, DrawSelected);
  for i:=0 to FAreas.Count-1 do
    if (FAreas.Item[i].Ref=nil) and
       (not FAreas.Item[i].Selected) then
      FAreas.Item[i].Draw(aPainter, DrawSelected);
  for i:=0 to FImageRects.Count-1 do
    if not FImageRects.Item[i].Selected then
      FImageRects.Item[i].Draw(aPainter, DrawSelected);
  for i:=0 to FLines.Count-1 do
    if (FLines.Item[i].Ref=nil) and
       (FLines.Item[i].Parents.Count=0) and
       (not FLines.Item[i].Selected) then
      FLines.Item[i].Draw(aPainter, DrawSelected);

  for i:=0 to FCoordNodes.Count-1 do
    if (FCoordNodes.Item[i].Ref=nil) and
       (not FCoordNodes.Item[i].Selected) then
      FCoordNodes.Item[i].Draw(aPainter, 0);

  for i:=0 to FCurvedLines.Count-1 do
    if (FCurvedLines.Item[i].Ref=nil) and
       (not FCurvedLines.Item[i].Selected) then
      FCurvedLines.Item[i].Draw(aPainter, DrawSelected);

  Painter.CloseBlock;
end;

function TElementImage.Get_XSize: double;
begin
  Result:=FXSize
end;

function TElementImage.Get_YSize: double;
begin
  Result:=FYSize
end;

function TElementImage.Get_ZSize: double;
begin
  Result:=FZSize
end;

procedure TElementImage.AfterLoading1;
var
  j:integer;
  MinX, MaxX, MinY, MaxY, MinZ, MaxZ:double;
  CoordNode:ICoordNode;
  CurvedLine:ICurvedLine;
begin
  inherited;
  MinX:=InfinitValue;
  MinY:=InfinitValue;
  MinZ:=InfinitValue;
  MaxX:=-InfinitValue;
  MaxY:=-InfinitValue;
  MaxZ:=-InfinitValue;
  for j:=0 to FCoordNodes.Count-1 do begin
    CoordNode:=FCoordNodes.Item[j] as ICoordNode;
    if MinX>CoordNode.X then
      MinX:=CoordNode.X;
    if MaxX<CoordNode.X then
      MaxX:=CoordNode.X;
    if MinY>CoordNode.Y then
      MinY:=CoordNode.Y;
    if MaxY<CoordNode.Y then
      MaxY:=CoordNode.Y;
    if MinZ>CoordNode.Z then
      MinZ:=CoordNode.Z;
    if MaxZ<CoordNode.Z then
      MaxZ:=CoordNode.Z;
  end;
  for j:=0 to FCurvedLines.Count-1 do begin
    CurvedLine:=FCurvedLines.Item[j] as ICurvedLine;
    if MinX>CurvedLine.P0X then
      MinX:=CurvedLine.P0X;
    if MaxX<CurvedLine.P0X then
      MaxX:=CurvedLine.P0X;
    if MinY>CurvedLine.P0Y then
      MinY:=CurvedLine.P0Y;
    if MaxY<CurvedLine.P0Y then
      MaxY:=CurvedLine.P0Y;
    if MinZ>CurvedLine.P0Z then
      MinZ:=CurvedLine.P0Z;
    if MaxZ<CurvedLine.P0Z then
      MaxZ:=CurvedLine.P0Z;

    if MinX>CurvedLine.P1X then
      MinX:=CurvedLine.P1X;
    if MaxX<CurvedLine.P1X then
      MaxX:=CurvedLine.P1X;
    if MinY>CurvedLine.P1Y then
      MinY:=CurvedLine.P1Y;
    if MaxY<CurvedLine.P1Y then
      MaxY:=CurvedLine.P1Y;
    if MinZ>CurvedLine.P1Z then
      MinZ:=CurvedLine.P1Z;
    if MaxZ<CurvedLine.P1Z then
      MaxZ:=CurvedLine.P1Z;

  end;
  FXSize:=MaxX-MinX;
  FYSize:=MaxY-MinY;
  FZSize:=MaxZ-MinZ;
end;

function TElementImage.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(eiColor),
  ord(eiScalingType),
  ord(eiMinPixels),
  ord(eiMaxSize):
    Result:=True
  else
    Result:=False
  end;
end;

function TElementImage.Get_MinPixels: integer;
begin
  Result:=FMinPixels
end;


function TElementImage.Get_MaxSize: double;
begin
  Result:=FMaxSize
end;

{ TElementImages }

function TElementImages.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsElementImage
end;

class function TElementImages.GetElementClass: TDMElementClass;
begin
  Result:=TElementImage
end;

class function TElementImages.GetElementGUID: TGUID;
begin
  Result:=IID_IElementImage
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TElementImage.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
