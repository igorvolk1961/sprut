unit CustomSpatialModelU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Classes, SpatialModelLib_TLB, StdVcl, Graphics, SysUtils,
  DMElementU, DataModelU, DataModel_TLB, DMServer_TLB, PainterLib_TLB,
  SortedLists, Variants;

const
  mpkView    =2;
  mpkBuild   =4;
  mpkCurrent =256;

type
  TCustomSpatialModel = class(TDataModel, ISpatialModel, ISpatialModel2, ISpatialModel3)
  private
    FCurrentLayer:Variant;
    FCurrentFont:Variant;
    FLocalGridCell:double;
    FChangeLengthDirection:integer;
    FBuildVerticalLine:boolean;
    FBuildJoinedVolume:boolean;
    FBuildDirection:integer;
    FEnabledBuildDirection:integer;

    FDrawOrdered:boolean;
    FFastDraw:boolean;
    FMinX:double;
    FMaxX:double;
    FMinY:double;
    FMaxY:double;
    FMinZ:double;
    FMaxZ:double;
    FDefaultVolume:IDMElement;
    FMaxModelHeight:double;
    FBuildWallsOnAllLevels:boolean;
  protected
    FRenderAreasMode:integer;
    FDefaultVolumeHeight:double;
    FDefaultVerticalAreaWidth:double;
    FDefaultObjectWidth:double;

    FDrawThreadTerminated:boolean;
    FDrawThreadFinished:boolean;

    class function  GetFields:IDMCollection; override;
    class procedure MakeFields; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code: Integer; var aCollection: IDMCollection); override; safecall;
    function  Get_FieldCategoryCount:integer; override;
    function  Get_FieldCategory(Index:integer):WideString; override;

// методы IDataModel
    function  Get_RootObjectCount(Mode:integer): Integer; override; safecall;
    procedure GetRootObject(Mode, RootIndex: Integer; out RootObject: IUnknown;
                            out RootObjectName: WideString; out aOperations: Integer;
                            out aLinkType: Integer); override; safecall;
    function Get_SubModel(Index: integer): IDataModel; override; safecall;
    procedure Init; override;
    procedure LoadedFromDataBase(const aDatabaseU: IUnknown);override;  safecall;
    procedure Loaded;override;  safecall;
    function GetDefaultParent(ClassID:integer): IDMElement; override; safecall;
    function GetDefaultElement(ClassID:integer): IDMElement; override; safecall;
    function  CreateCollection(aClassID:integer; const aParent:IDMElement): IDMCollection; override; safecall;

//  защищенные методы
    procedure MakeCollections; override;
    function Get_CurrentLayer: ILayer; safecall;
    procedure Set_CurrentLayer(const Value: ILayer); virtual; safecall;
    function Get_CurrentFont: ISMFont; safecall;
    procedure Set_CurrentFont(const Value: ISMFont); virtual; safecall;
    function Get_Areas: IDMCollection; virtual; safecall;
    function Get_CoordNodes: IDMCollection; virtual; safecall;
    function Get_CurvedLines: IDMCollection; virtual; safecall;
    function Get_ImageRects: IDMCollection; virtual; safecall;
    function Get_Layers: IDMCollection; virtual; safecall;
    function Get_Lines: IDMCollection; virtual; safecall;
    function Get_Polylines: IDMCollection; virtual; safecall;
    function Get_LineGroups: IDMCollection; virtual; safecall;
    function Get_Views: IDMCollection; virtual; safecall;
    function Get_Volumes: IDMCollection; virtual; safecall;
    function Get_Fonts: IDMCollection; virtual; safecall;
    function Get_Labels: IDMCollection; virtual; safecall;
    function Get_Circles: IDMCollection; virtual; safecall;
    function Get_DefaultVerticalAreaWidth: Double; safecall;
    procedure Set_DefaultVerticalAreaWidth(Value: Double); safecall;
    function Get_DefaultObjectWidth: double; safecall;
    procedure Set_DefaultObjectWidth(Value: double); safecall;
    function Get_LocalGridCell: double; safecall;
    procedure Set_LocalGridCell(Value: double); safecall;
    function Get_ChangeLengthDirection:integer; safecall;
    procedure Set_ChangeLengthDirection(Value:integer); safecall;
    function Get_BuildVerticalLine: WordBool; safecall;
    procedure Set_BuildVerticalLine(Value: WordBool); safecall;
    function Get_BuildJoinedVolume: WordBool; safecall;
    procedure Set_BuildJoinedVolume(Value: WordBool); safecall;
    function Get_RenderAreasMode: Integer; safecall;
    procedure Set_RenderAreasMode(Value: Integer); safecall;
    function Get_ReliefLayer: IDMElement; virtual; safecall;
    procedure Set_ReliefLayer(const Value: IDMElement); virtual;  safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    function Import(const FileName:WideString):integer; override; safecall;

    property Layers: IDMCollection read Get_Layers;
    property CoordNodes: IDMCollection read Get_CoordNodes;
    property Lines: IDMCollection read Get_Lines;
    property CurvedLines: IDMCollection read Get_CurvedLines;
    property Polylines: IDMCollection read Get_Polylines;
    property Areas: IDMCollection read Get_Areas;
    property Volumes: IDMCollection read Get_Volumes;
    property Circles: IDMCollection read Get_Circles;
    property ImageRects: IDMCollection read Get_ImageRects;
    property Views: IDMCollection read Get_Views;
    property CurrentLayer: ILayer read Get_CurrentLayer write Set_CurrentLayer;
    function Get_DefaultVolumeHeight: Double; safecall;
    procedure Set_DefaultVolumeHeight(Value: Double); safecall;
    function Get_BuildDirection:integer; safecall;
    procedure Set_BuildDirection(Value: integer); safecall;
    function Get_EnabledBuildDirection:integer; safecall;
    procedure Set_EnabledBuildDirection(Value:integer); safecall;

    function Get_BuildWallsOnAllLevels:WordBool; safecall;
    procedure Set_BuildWallsOnAllLevels(Value:WordBool); safecall;

    function BuildAreaSurrounding(WX, WY, WZ:double):IArea; safecall;
    function GetAreaEqualTo(const aArea: IArea): IArea; safecall;
    function GetVolumeContaining(PX, PY, PZ: Double): IVolume; virtual; safecall;
    procedure CalcLimits; safecall;
    function Get_MinX:double; safecall;
    function Get_MaxX:double; safecall;
    function Get_MinY:double; safecall;
    function Get_MaxY:double; safecall;
    function Get_MinZ:double; safecall;
    function Get_MaxZ:double; safecall;
    procedure GetRefElementParent(ClassID, OperationCode: Integer; PX: Double; PY: Double; PZ: Double;
                                  out aParent: IDMElement;
                                  out DMClassCollections:IDMClassCollections;
                                  out RefSource, aCollection: IDMCollection); virtual; safecall;
    procedure GetDefaultAreaRefRef(const VolumeE: IDMElement;Mode: Integer;
                                   BaseVolumeFlag:WordBool;
                               out aCollection: IDMCollection; out aName: WideString;
                               out AreaRefRef: IDMElement); virtual; safecall;
    procedure CheckErrors; override; safecall;
    procedure CorrectErrors; override; safecall;
    procedure CheckVolumeContent(const NewVolumes:IDMCollection;
                                 const Volume:IVolume;
                                 Mode:integer); virtual; safecall;
    function CanDeleteNow(const aElement:IDMElement;
                          const DeleteCollection:IDMCollection):WordBool; virtual; safecall;
    function Get_AreasOrdered: WordBool; virtual; safecall;
    procedure Set_AreasOrdered(Value: WordBool); virtual; safecall;
    function Get_DrawOrdered: WordBool; safecall;
    procedure Set_DrawOrdered(Value: WordBool); safecall;
    function Get_FastDraw: WordBool; safecall;
    function Get_EdgeNodeDeletionAllowed: WordBool; virtual; safecall;
    procedure UpdateVolumes; virtual; safecall;
    procedure MakeVolumeOutline(const Volume:IVolume; const aCollection:IDMCollection); virtual; safecall;
    procedure CalcVolumeMinMaxZ(const Volume:IVolume); virtual; safecall;

    procedure GetUpperLowerVolumeParams(const VolumeRef: IDMElement;
                                        out UpperVolumeRefRef: IDMElement;
                                        out LowerVolumeRefRef: IDMElement;
                                        out VolumeHeight: Double;
                                        out UpperVolumeHeight: Double;
                                        out LowerVolumeHeight: Double;
                                        out UpperVolumeUseSpecLayer: WordBool;
                                        out LowerVolumeUseSpecLayer: WordBool;
                                        out TopAreaUseSpecLayer: WordBool); virtual; safecall;
    function Get_VerticalBoundaryLayer: IDMElement; virtual; safecall;
    procedure Set_VerticalBoundaryLayer(const Value: IDMElement); virtual; safecall;
    function GetColVolumeContaining(PX: Double; PY: Double; PZ: Double;
                                    const ColAreas: IDMCollection; const Volumes: IDMCollection): WordBool; virtual; safecall;
    procedure GetInnerVolumes(const VolumeE: IDMElement; const InnerVolumes: IDMCollection); virtual; safecall;
    function  GetOuterVolume(const VolumeE: IDMElement):IDMElement; virtual; safecall;

    function  Get_MaxModelHeight: double; safecall;

//ISpatialModel3
    function Get_DrawThreadTerminated:WordBool; safecall;
    procedure Set_DrawThreadTerminated(Value:WordBool); safecall;
    function Get_DrawThreadFinished:WordBool; safecall;
    procedure Set_DrawThreadFinished(Value:WordBool); safecall;

    procedure DoDraw(const Painter: IPainter;
      const DMCollection: IDMCollection; DrawSelected: integer);

  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TSortedByDistanceList=class(TSortedList)
  private
    FX:double;
    FY:double;
    FZ:double;
  protected
    function Compare(Key1, Key2: pointer): Integer; override;
  public
    constructor Create1(WX, WY, WZ:double);
  end;

implementation

uses
  SpatialElementU,
  LayerU,
  CoordNodeU,
  LineU,
  CurvedLineU,
  PolyLineU,
  AreaU,
  VolumeU,
  ViewU,
  ImageRectU,
  SpatialModelConstU,
  ImportDXFU,
  SMLabelU,
  SMFontU,
  LineGroupU,
  CircleU;

var
  FFields:IDMCollection;

{ TCustomSpatialModel }

function TCustomSpatialModel.Get_RootObjectCount(Mode:integer): Integer;
begin
  case Mode of
  0: Result:=inherited Get_RootObjectCount(Mode);
  else
    Result:=8;
  end;  
end;

function TCustomSpatialModel.Get_SubModel(Index: integer): IDataModel;
begin
  case Index of
  1:  Result:=Self;
  else
      Result:=inherited Get_SubModel(Index);
  end;
end;

procedure TCustomSpatialModel.GetRootObject(Mode, RootIndex: Integer;
  out RootObject: IInterface; out RootObjectName: WideString;
  out aOperations, aLinkType: Integer);
var
  aRefSource:IDMCollection;
  aClassCollections:IDMClassCollections;
begin
  case Mode of
  0: inherited;
  else
    case RootIndex of
    0:begin
        GetCollectionProperties(_CoordNode,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_CoordNode];
      end;
    1:begin
        GetCollectionProperties(_Line,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_Line];
      end;
    2:begin
        GetCollectionProperties(_Area,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_Area];
      end;
    3:begin
        GetCollectionProperties(_Volume,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_Volume];
      end;
    4:begin
        GetCollectionProperties(_Polyline,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_Polyline];
      end;
    5:begin
        GetCollectionProperties(_CurvedLine,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_CurvedLine];
      end;
    6:begin
        GetCollectionProperties(_ImageRect,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_ImageRect];
      end;
    7:begin
        GetCollectionProperties(_View,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_View];
      end;
    8:begin
        GetCollectionProperties(_LineGroup,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
        RootObject:=Collection[_LineGroup];
      end;
    end;
  end;
end;

procedure TCustomSpatialModel.MakeCollections;
var
  aDataModel:IDataModel;
begin
  inherited;
  aDataModel:=Self as IDataModel;

  AddClass(TLayers);
  AddClass(TCoordNodes);
  AddClass(TLines);
  AddClass(TCurvedLines);
  AddClass(TPolyLines);
  AddClass(TAreas);
  AddClass(TVolumes);
  AddClass(TViews);
  AddClass(TImageRects);
  AddClass(TSMFonts);
  AddClass(TSMLabels);
  AddClass(TLineGroups);
  AddClass(TCircles);
end;

procedure TCustomSpatialModel.Init;
var
  aViewE, aLayerE, aFontE:IDMElement;
  Fonts2, Layers2:IDMCollection2;
  DMDocument:IDMDocument;
  OldState:integer;
begin
  inherited;

  FMaxModelHeight:=3000;   // 0;

  if Get_IsLoading then Exit;

  DMDocument:=Get_Document as IDMDocument;
  OldState:=Get_State;
  Set_State(Get_State or dmfCommiting);
  try

  aViewE:=(Views as IDMCollection2).CreateElement(False);
  (Views as IDMCollection2).Add(aViewE);
  aViewE.Name:=rsDefaultView;
  with aViewE as IView do begin
    CX:=0;
    CY:=0;
    CZ:=0;
    Zangle:=0;
    RevScale:=1000/30;
  end;

  Layers2:=Layers as IDMCollection2;
  aLayerE:=Layers2.CreateElement(False);
  Layers2.Add(aLayerE);
  aLayerE.Name:=rsDefaultLayer;
  (aLayerE as ILayer).Color:=clBlack;
  FCurrentLayer:=aLayerE as ILayer;

  Fonts2:=Get_Fonts as IDMCollection2;
  if Fonts2=nil then Exit;
  aFontE:=Fonts2.CreateElement(False);
  Fonts2.Add(aFontE);
  aFontE.Name:=rsDefaultFont;
  FCurrentFont:=aFontE as ISMFont;

  finally
    Set_State(OldState);
  end;  
end;

procedure TCustomSpatialModel.Initialize;
var
  Volumes:IDMCollection;
begin
  inherited;
  ID:=1;
  FDrawOrdered:=True;
  FLocalGridCell:=1.5;
  FBuildVerticalLine:=True;

  DecimalSeparator:='.';

  Volumes:=Get_Volumes;
  if Get_Volumes<>nil then begin
    FDefaultVolume:=(Get_Volumes as IDMCollection2).CreateElement(True);
    FDefaultVolume.ID:=-1;
  end else
    FDefaultVolume:=nil;
end;

function TCustomSpatialModel.Get_CurrentLayer: ILayer;
var
  Unk:IUnknown;
begin
  Unk:=FCurrentLayer;
  Result:=Unk as ILayer;
end;

procedure TCustomSpatialModel.Set_CurrentLayer(const Value: ILayer);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FCurrentLayer:=Unk;
end;

function TCustomSpatialModel.Get_Areas: IDMCollection;
begin
  Result:=Collection[_Area]
end;

function TCustomSpatialModel.Get_CoordNodes: IDMCollection;
begin
  Result:=Collection[_CoordNode]
end;

function TCustomSpatialModel.Get_CurvedLines: IDMCollection;
begin
  Result:=Collection[_CurvedLine]
end;

function TCustomSpatialModel.Get_ImageRects: IDMCollection;
begin
  Result:=Collection[_ImageRect]
end;

function TCustomSpatialModel.Get_Layers: IDMCollection;
begin
  Result:=Collection[_Layer]
end;

function TCustomSpatialModel.Get_Lines: IDMCollection;
begin
  Result:=Collection[_Line]
end;

function TCustomSpatialModel.Get_Polylines: IDMCollection;
begin
  Result:=Collection[_Polyline]
end;

function TCustomSpatialModel.Get_Views: IDMCollection;
begin
  Result:=Collection[_View]
end;

function TCustomSpatialModel.Get_Volumes: IDMCollection;
begin
  Result:=Collection[_Volume]
end;

function TCustomSpatialModel.Get_RenderAreasMode: Integer;
begin
  Result:=FRenderAreasMode
end;

procedure TCustomSpatialModel.Set_RenderAreasMode(Value: Integer);
begin
  FRenderAreasMode:=Value
end;

procedure TCustomSpatialModel.DoDraw(const Painter:IPainter; const DMCollection:IDMCollection; DrawSelected:integer);
var
  j:integer;
  Element:IDMElement;
begin
  try
  for j:=0 to DMCollection.Count-1 do  begin
    if FDrawThreadTerminated then Exit;
    Element:=DMCollection.Item[j];
    if not Element.Selected then begin
      if Painter.UseLayers and
         (Element.SpatialElement<>nil)then
        Painter.LayerIndex:=Layers.IndexOf(Element.SpatialElement.Parent)
      else
        Painter.LayerIndex:=Layers.IndexOf(Element.Parent);
      Element.Draw(Painter, DrawSelected);
    end;
  end
  except
    HandleError('Error in TCustomFacilityModel.Draw');
  end;
end;


procedure TCustomSpatialModel.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  i:integer;
  Element:IDMElement;
  Painter:IPainter;
  Flag:boolean;
  Line:ILine;
  Node, C0, C1:ICoordNode;
begin
  if Get_Document=nil then Exit;
  Painter:=aPainter as IPainter;
  try

  DoDraw(Painter, ImageRects, DrawSelected);
  DoDraw(Painter, Areas, DrawSelected);

  for i:=0 to Lines.Count-1 do begin
    if FDrawThreadTerminated then Exit;

    Element:=Lines.Item[i];
    if (Element.Ref=nil) and
       (not Element.Selected) then begin
      Flag:=False;
      if (Element.Parents.Count=0) then
        Flag:=True
      else begin
        Line:=Element as ILine;
        C0:=Line.C0;
        C1:=Line.C1;
        if (C0<>nil) and
           (C1<>nil) then begin
          if ((C0.X<>C1.X) or (C0.Y<>C1.Y)) and
             (Line.GetVerticalArea(bdUp)=nil) and
             (Line.GetVerticalArea(bdDown)=nil) then
            Flag:=True
        end;
      end;
      if Flag then begin
        if Painter.UseLayers then
          Painter.LayerIndex:=Layers.IndexOf(Element.Parent);
        Element.Draw(aPainter, DrawSelected);
      end;
    end;
  end;

  FMinX:=InfinitValue;
  FMaxX:=-InfinitValue;
  FMinY:=InfinitValue;
  FMaxY:=-InfinitValue;
  FMinZ:=InfinitValue;
  FMaxZ:=-InfinitValue;

  for i:=0 to CoordNodes.Count-1 do begin
    if FDrawThreadTerminated then Exit;

    Element:=CoordNodes.Item[i];
    Node:=Element as ICoordNode;
    if FMinX>Node.X then
      FMinX:=Node.X;
    if FMaxX<Node.X then
      FMaxX:=Node.X;
    if FMinY>Node.Y then
      FMinY:=Node.Y;
    if FMaxY<Node.Y then
      FMaxY:=Node.Y;
    if FMinZ>Node.Z then
      FMinZ:=Node.Z;
    if FMaxZ<Node.Z then
      FMaxZ:=Node.Z;

    if (Element.Ref=nil) and
       (not Element.Selected) then begin
      if Painter.UseLayers then
        Painter.LayerIndex:=Layers.IndexOf(Element.Parent);
      Element.Draw(aPainter, DrawSelected);
    end;
  end;

  DoDraw(Painter, CurvedLines, DrawSelected);
  DoDraw(Painter, Circles, DrawSelected);

  except
    raise
  end;
end;

function TCustomSpatialModel.Get_DefaultVolumeHeight: Double;
begin
  Result:=FDefaultVolumeHeight
end;

procedure TCustomSpatialModel.Set_DefaultVolumeHeight(Value: Double);
begin
  FDefaultVolumeHeight:=Value
end;

function TCustomSpatialModel.BuildAreaSurrounding(WX, WY, WZ: double): IArea;


  function MakeNextLineTags(StartLine:ILine):boolean;
  var
    PrevC, CurrC, AC:ICoordNode;
    PrevLine, CurrLine, ALine, TagLine:ILine;
    ALineE:IDMElement;
    j:integer;
    cos_a, sin_a, cos_b, sin_b, cos_c, sin_c,
    sin_bc, cos_ba, sin_ba, A, CA, dr:real;
    CoordList:TList;
  const pi=3.1415926;
  begin
    Result:=True;
    CoordList:=TList.Create;

    CurrC:=StartLine.C0;
    PrevLine:=StartLine;
    PrevC:=StartLine.C1;

    dr:=sqrt((CurrC.X-WX)*(CurrC.X-WX)+
             (CurrC.Y-WY)*(CurrC.Y-WY));
    cos_b:=(PrevC.X-CurrC.X)/PrevLine.Length;
    sin_b:=(PrevC.Y-CurrC.Y)/PrevLine.Length;
    cos_c:=(WX-CurrC.X)/dr;
    sin_c:=(WY-CurrC.Y)/dr;
    sin_bc:=sin_b*cos_c-cos_b*sin_c;

    while (CurrC<>StartLine.C1) and
          (CurrC<>nil) do begin
      CurrLine:=nil;

      if sin_bc>0 then
        A:=2*pi
      else
        A:=-pi;
      for j:=0 to CurrC.Lines.Count-1 do begin
        ALineE:=CurrC.Lines.Item[j];
        if (ALineE.Ref<>nil) then Continue;
        if not (ALineE.Parent as ILayer).Selectable then Continue;
        ALine:=ALineE as ILine;
        if (ALine.C0.X=ALine.C1.X) and
           (ALine.C0.Y=ALine.C1.Y)  then Continue;
        AC:=ALine.NextNodeTo(CurrC);
        TagLine:=AC.TagRef as ILine;
        try
        if abs(AC.Z-WZ)>1 then Continue;
        if (ALine<>PrevLine) and
           (AC.Lines.Count>1) and
           (TagLine=nil) then begin
          if PrevLine.Length<>0 then begin
            cos_b:=(PrevC.X-CurrC.X)/PrevLine.Length;
            sin_b:=(PrevC.Y-CurrC.Y)/PrevLine.Length;
          end else begin
            cos_b:=1;
            sin_b:=0;
          end;
          if ALine.Length<>0 then begin
            cos_a:=(AC.X-CurrC.X)/ALine.Length;
            sin_a:=(AC.Y-CurrC.Y)/ALine.Length;
          end else begin
            cos_a:=1;
            sin_a:=0;
          end;
          cos_ba:=cos_b*cos_a+sin_b*sin_a;
          sin_ba:=sin_b*cos_a-cos_b*sin_a;
          if cos_ba=0 then begin
            if sin_ba>=0 then CA:=0.5*pi
            else CA:=1.5*pi;
          end else begin
            CA:=ArcTan(sin_ba/cos_ba);
            if (cos_ba>0) and (sin_ba<0) then
              CA:=CA+2.*pi
            else if cos_ba<0 then
              CA:=CA+pi
          end;
          if sin_bc>=0 then begin
            if CA<A then begin
              A:=CA;
              CurrLine:=ALine;
            end;
          end else begin
            if CA>A then begin
              A:=CA;
              CurrLine:=ALine;
            end;
          end;
        end;
        except
          raise
        end;
      end;

      if CurrLine=nil then begin
        CurrLine:=CurrC.TagRef as ILine;
        PrevLine:=CurrLine;
        PrevC:=CurrC;
        if PrevLine<> nil then
          if PrevLine.C0.TagRef<>PrevLine.C1.TagRef then
            CurrC:=PrevLine.NextNodeTo(PrevC)
          else
            CurrC:=nil
        else
          CurrC:=nil
      end else begin
        PrevLine:=CurrLine;
        PrevC:=CurrC;
        CurrC:=PrevLine.NextNodeTo(PrevC);
        CurrC.TagRef:=PrevLine as IDMElement;
      end;

      if CoordList.IndexOf(pointer(CurrC))=-1 then
        CoordList.Add(pointer(CurrC))
      else begin
        Result:=False;
        CoordList.Free;
        Exit;
      end;
    end;
    CoordList.Free;
  end; {MakeNextLineTags}

  function SurroundStartingFrom(StartLine:ILine; Area:IArea; Side:integer):boolean;
  var
    j:integer;
    N_crosses:word;
    WP_OnLine:boolean;
    aNode:ICoordNode;
    aLine:ILine;
    AreaE:IDMElement;
    AreaP:IPolyline;
  begin
    AreaE:=Area as IDMElement;
    AreaP:=Area as IPolyline;
    for j:=0 to CoordNodes.Count-1 do
      (CoordNodes.Item[j] as ICoordNode).TagRef:=nil;
    if not MakeNextLineTags(StartLine) then begin
      Result:=False;
      Exit;
    end;
    while AreaP.Lines.Count>0 do
      (AreaP.Lines as IDMCollection2).Delete(0);

    (AreaP.Lines as IDMCollection2).Add(StartLine as IDMElement);

    if StartLine.C1.TagRef<>nil then begin
      N_crosses:=1;
      aNode:=StartLine.C1;
      aLine:=aNode.TagRef as ILine;
      WP_OnLine:=False;
      while (aNode<>StartLine.C0) and (not WP_OnLine) do begin
        case aLine.InLineWith(WX, WY, WZ, Side, 0, False) of
        1: inc(N_crosses);
        2: WP_OnLine:=True;
        end;
        (AreaP.Lines as IDMCollection2).Add(aLine as IDMElement);
        aNode:=aLine.NextNodeTo(aNode);
        aLine:=aNode.TagRef as ILine;
      end;
      if WP_OnLine then
         Result:=False
      else if N_crosses mod 2 = 1 then
        Result:=True
      else
        Result:=False
    end else
      Result:=False
  end; {SurroundStartingFrom}

var
  j:integer;
  StartLines:TSortedByDistanceList;
  Surrounding:boolean;
  Line:ILine;
  LineE, aLayerE, MinLayerE, AreaE:IDMElement;
  AreaP:IPolyline;
  MinID:integer;
begin    {TCustomSpatialModel.CreateAreaSurrounding}
  AreaE:=(Areas as IDMCollection2).CreateElement(True);
  Result:=AreaE as IArea ;

  StartLines:=TSortedByDistanceList.Create1(WX, WY, WZ);

  try
  for j:=0 to Lines.Count-1 do begin
    LineE:=Lines.Item[j];;
    Line:=LineE as ILine;
    if (LineE.Ref=nil) and
       (LineE.Parent as ILayer).Selectable and
       (Line.InLineWith(WX, WY, WZ, 1, 0, False)=1) then
      StartLines.AddValue(pointer(Line));
  end;
  except
    raise
  end;
  for j:=0 to CurvedLines.Count-1 do begin
    LineE:=CurvedLines.Item[j];;
    Line:=LineE as ILine;
    if (LineE.Ref=nil) and
       (LineE.Parent as ILayer).Selectable and
       (Line.InLineWith(WX, WY, WZ, 1, 0, False)=1) then
      StartLines.AddValue(pointer(Line));
  end;

  Surrounding:=False;
  while (not Surrounding) and (StartLines.Count>0) do begin
    if SurroundStartingFrom(ILine(StartLines[0]), Result, 1) then
      Surrounding:=True
    else
      StartLines.Delete(0);
  end;

  if not Surrounding then begin
    StartLines.Clear;
    for j:=0 to Lines.Count-1 do begin
      LineE:=Lines.Item[j];;
      Line:=LineE as ILine;
      if (LineE.Ref=nil) and
         (LineE.Parent as ILayer).Selectable and
         (Line.InLineWith(WX, WY, WZ, 0, 0, False)=1) then
        StartLines.AddValue(pointer(Line));
    end;
    for j:=0 to CurvedLines.Count-1 do begin
      LineE:=CurvedLines.Item[j];;
      Line:=LineE as ILine;
      if (LineE.Ref=nil) and
         (LineE.Parent as ILayer).Selectable and
         (Line.InLineWith(WX, WY, WZ, 0, 0, False)=1) then
        StartLines.AddValue(pointer(Line));
    end;
  end;

  while (not Surrounding) and (StartLines.Count>0) do begin
    if SurroundStartingFrom(ILine(StartLines[0]), Result, 0) then
      Surrounding:=True
    else
      StartLines.Delete(0);
  end;

  StartLines.Free;

  for j:=0 to CoordNodes.Count-1 do
    (CoordNodes.Item[j] as ICoordNode).TagRef:=nil;

  AreaP:=Result as IPolyline;
  if not Surrounding then begin
    while AreaP.Lines.Count>0 do
      (AreaP.Lines as IDMCollection2).Delete(0);
    Result:=nil;
  end else begin
    MinLayerE:=nil;
    MinID:=InfinitValue;
    for j:=0 to AreaP.Lines.Count do begin
      aLayerE:=AreaP.Lines.Item[j].Parent;
      if MinID>aLayerE.ID then begin
        MinID:=aLayerE.ID;
        MinLayerE:=aLayerE;
      end;
    end;
    AreaE.Parent:=MinLayerE;
    AreaE.Update;
  end;
end;

function TCustomSpatialModel.GetVolumeContaining(PX, PY, PZ: Double): IVolume;
var
  Area:IArea;
  j:integer;
  Volume:IVolume;
begin
  Result:=nil;
  for j:=0 to Areas.Count-1 do begin
    Area:=Areas.Item[j] as IArea;
    if not Area.IsVertical then begin
      Volume:=Area.Volume0;
      if Volume<>nil then begin
        if (Area.MinZ<PZ) and
           (Area.MaxZ>PZ) then begin
          if Area.ProjectionContainsPoint(PX, PY, 0) then begin
            Result:=Volume;
            Exit;
          end;
        end else
        if (Area.MinZ=PZ) and
           (Area.MaxZ=PZ) then begin
          if Area.ProjectionContainsPoint(PX, PY, 0) then begin
            Result:=Volume;
            Exit;
          end;
        end else
        if (Volume.MinZ<PZ+1.e-6) and
           (Volume.MaxZ>PZ+1.e-6) then begin
          if Area.ProjectionContainsPoint(PX, PY, 0) then
            Result:=Volume;
        end;
      end;
    end;
  end;
end;

procedure TCustomSpatialModel.CalcLimits;
var
  j:integer;
  Node:ICoordNode;
begin
  FMinX:=InfinitValue;
  FMaxX:=-InfinitValue;
  FMinY:=InfinitValue;
  FMaxY:=-InfinitValue;
  FMinZ:=InfinitValue;
  FMaxZ:=-InfinitValue;
  for j:=0 to CoordNodes.Count-1 do begin
    Node:=CoordNodes.Item[j] as ICoordNode;
    if FMinX>Node.X then
      FMinX:=Node.X;
    if FMaxX<Node.X then
      FMaxX:=Node.X;
    if FMinY>Node.Y then
      FMinY:=Node.Y;
    if FMaxY<Node.Y then
      FMaxY:=Node.Y;
    if FMinZ>Node.Z then
      FMinZ:=Node.Z;
    if FMaxZ<Node.Z then
      FMaxZ:=Node.Z;
  end;
end;

function TCustomSpatialModel.Get_MaxX: double;
begin
  Result:=FMaxX
end;

function TCustomSpatialModel.Get_MaxY: double;
begin
  Result:=FMaxY
end;

function TCustomSpatialModel.Get_MaxZ: double;
begin
  Result:=FMaxZ
end;

function TCustomSpatialModel.Get_MinX: double;
begin
  Result:=FMinX
end;

function TCustomSpatialModel.Get_MinY: double;
begin
  Result:=FMinY
end;

function TCustomSpatialModel.Get_MinZ: double;
begin
  Result:=FMinZ
end;

procedure TCustomSpatialModel.GetRefElementParent(ClassID, OperationCode: Integer;
  PX, PY, PZ: Double;
  out aParent: IDMElement;
  out DMClassCollections:IDMClassCollections;
  out RefSource, aCollection: IDMCollection);
begin
  aParent:=nil;
  DMClassCollections:=nil;
  RefSource:=nil;
  aCollection:=nil;
end;

procedure TCustomSpatialModel.GetDefaultAreaRefRef(const VolumeE: IDMElement; Mode: Integer;
  BaseVolumeFlag:WordBool;
  out aCollection: IDMCollection; out aName: WideString; out AreaRefRef: IDMElement);
begin
end;

function TCustomSpatialModel.Import(const FileName: WideString): integer;
var
  S:string;
begin
  Result:=0;
  S:=FileName;
  ImportDXF(S, Self as ISpatialModel)
end;

destructor TCustomSpatialModel.Destroy;
begin
  inherited;
//  FCurrentFont:=nil;
//  FCurrentLayer:=nil;
end;

function TCustomSpatialModel.GetDefaultParent(
  ClassID: integer): IDMElement;
begin
  case ClassID of
  _Area:
    Result:=FDefaultVolume;
  else
    Result:=Get_CurrentLayer as IDMElement;
  end;
end;

function TCustomSpatialModel.Get_DefaultVerticalAreaWidth: Double;
begin
  Result:=FDefaultVerticalAreaWidth
end;

procedure TCustomSpatialModel.Set_DefaultVerticalAreaWidth(Value: Double);
begin
  FDefaultVerticalAreaWidth:=Value
end;

procedure TCustomSpatialModel.LoadedFromDataBase(const aDatabaseU: IUnknown);
var
  Collection:IDMCollection;
  aLayerE, aFontE:IDMElement;
begin
  inherited;
  Collection:=Get_Layers;
  if Collection.Count=0 then begin
    aLayerE:=(Layers as IDMCollection2).CreateElement(False);
    (Layers as IDMCollection2).Add(aLayerE);
    aLayerE.Name:=rsDefaultLayer;
    (aLayerE as ILayer).Color:=clBlack;
    FCurrentLayer:=aLayerE as ILayer;
  end else
  if Get_CurrentLayer=nil then
    Set_CurrentLayer(Collection.Item[0] as ILayer);

  Collection:=Get_Fonts;
  if (Collection<>nil) then begin
    if (Collection.Count=0) then begin
      aFontE:=(Get_Fonts as IDMCollection2).CreateElement(False);
      (Get_Fonts as IDMCollection2).Add(aFontE);
      aFontE.Name:=rsDefaultFont;
      FCurrentFont:=aFontE as ISMFont;
    end else
    if Get_CurrentFont=nil then
      Set_CurrentFont(Collection.Item[0] as ISMFont);
  end;

  CalcLimits;
end;

function TCustomSpatialModel.Get_Fonts: IDMCollection;
begin
  Result:=Collection[_SMFont]
end;

function TCustomSpatialModel.Get_Labels: IDMCollection;
begin
  Result:=Collection[_SMLabel]
end;

function TCustomSpatialModel.Get_CurrentFont: ISMFont;
var
  Unk:IUnknown;
begin
  Unk:=FCurrentFont;
  Result:=Unk as ISMFont;
end;

procedure TCustomSpatialModel.Set_CurrentFont(const Value: ISMFont);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FCurrentFont:=Unk
end;

function TCustomSpatialModel.GetDefaultElement(
  ClassID: integer): IDMElement;
begin
  case ClassID of
  _Volume:
    Result:=FDefaultVolume;
  else
    Result:=inherited GetDefaultElement(ClassID);
  end;
end;

procedure TCustomSpatialModel.CheckVolumeContent(const NewVolumes:IDMCollection;
                                 const Volume:IVolume;
                                 Mode:integer);
begin
end;

function TCustomSpatialModel.CanDeleteNow(const aElement: IDMElement;
  const DeleteCollection: IDMCollection): WordBool;
begin
  Result:=True;
end;

function TCustomSpatialModel.Get_ReliefLayer: IDMElement;
begin
  Result:=Get_CurrentLayer as IDMElement
end;

procedure TCustomSpatialModel.Set_ReliefLayer(const Value: IDMElement);
begin
end;

class function TCustomSpatialModel.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TCustomSpatialModel.MakeFields;
var
  S:WideString;
begin
  inherited;

  S:='|'+'Вверх'+
     '|'+'Вниз';
  AddField(rsBuildDirection, S, '', '',
                 fvtChoice, 0, 0, 1,
                 ord(smBuildDirection), 0, mpkCurrent);
  S:='|'+'От центра'+
     '|'+'Слева'+
     '|'+'Справа'+
     '|'+'Сверху'+
     '|'+'Снизу';
  AddField(rsChangeLengthDirection, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(smChangeLengthDirection), 0, mpkCurrent);

  AddField(rsDrawOrdered, '', '', '',
                 fvtBoolean, 1, 0, 1,
                 ord(smDrawOrdered), 0, mpkView);

  AddField(rsFastDraw, '', '', '',
                 fvtBoolean, 0, 0, 1,
                 ord(smFastDraw), 0, mpkCurrent); //mpkView);
  AddField(rsCurrentLayer, '', '', '',
                  fvtElement, -1, 0, 0,
                  ord(smCurrentLayer), 0, mpkCurrent);
  AddField(rsCurrentFont, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(smCurrentFont), 0, mpkCurrent);
  AddField(rsBuildVerticalLine, '', '', '',
                 fvtBoolean, 1, 0, 1,
                 ord(smBuildVerticalLine), 0, mpkCurrent); //mpkBuild);
  AddField(rsBuildJoinedVolume, '', '', '',
                 fvtBoolean, 0, 0, 1,
                 ord(smBuildJoinedVolume), 0, mpkCurrent); //mpkBuild);
  AddField(rsLocalGridCell, '%0.2f', '', '',
                 fvtFloat, 1.5, 0, 0,
                 ord(smLocalGridCell), 0, mpkBuild);
end;

function TCustomSpatialModel.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(smCurrentLayer):
    Result:=FCurrentLayer;
  ord(smCurrentFont):
    Result:=FCurrentFont;
  ord(smLocalGridCell):
    Result:=FLocalGridCell;
  ord(smRenderAreasMode):
    Result:=FRenderAreasMode;
  ord(smDrawOrdered):
    Result:=FDrawOrdered;
  ord(smFastDraw):
    Result:=FFastDraw;
  ord(smChangeLengthDirection):
    Result:=FChangeLengthDirection;
  ord(smBuildVerticalLine):
    Result:=FBuildVerticalLine;
  ord(smBuildJoinedVolume):
    Result:=FBuildJoinedVolume;
  ord(smBuildDirection):
    Result:=FBuildDirection;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TCustomSpatialModel.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(smCurrentLayer):
    FCurrentLayer:=Value;
  ord(smCurrentFont):
    FCurrentFont:=Value;
  ord(smLocalGridCell):
    FLocalGridCell:=Value;
  ord(smRenderAreasMode):
    FRenderAreasMode:=Value;
  ord(smDrawOrdered):
    FDrawOrdered:=Value;
  ord(smFastDraw):
    FFastDraw:=Value;
  ord(smChangeLengthDirection):
    FChangeLengthDirection:=Value;
  ord(smBuildVerticalLine):
    FBuildVerticalLine:=Value;
  ord(smBuildJoinedVolume):
    FBuildJoinedVolume:=Value;
  ord(smBuildDirection):
    FBuildDirection:=Value;
  else
    inherited;
  end;
end;

procedure TCustomSpatialModel.GetFieldValueSource(
  Code: Integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(smCurrentLayer):
    theCollection:=Get_Layers;
  ord(smCurrentFont):
    theCollection:=Get_Fonts;
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

function TCustomSpatialModel.Get_BuildVerticalLine: WordBool;
begin
  Result:=FBuildVerticalLine
end;

procedure TCustomSpatialModel.Set_BuildVerticalLine(Value: WordBool);
begin
  FBuildVerticalLine:=Value
end;

function TCustomSpatialModel.Get_BuildJoinedVolume: WordBool;
begin
  Result:=FBuildJoinedVolume
end;

procedure TCustomSpatialModel.Set_BuildJoinedVolume(Value: WordBool);
begin
  FBuildJoinedVolume:=Value
end;

function TCustomSpatialModel.Get_LineGroups: IDMCollection;
begin
  Result:=Collection[_LineGroup]
end;

function TCustomSpatialModel.Get_AreasOrdered: WordBool;
begin

end;

procedure TCustomSpatialModel.Set_AreasOrdered(Value: WordBool);
begin

end;

function TCustomSpatialModel.Get_DrawOrdered: WordBool;
begin
  Result:=FDrawOrdered
end;

procedure TCustomSpatialModel.Set_DrawOrdered(Value: WordBool);
begin
  FDrawOrdered:=Value
end;

function TCustomSpatialModel.Get_LocalGridCell: double;
begin
  Result:=FLocalGridCell
end;

procedure TCustomSpatialModel.Set_LocalGridCell(Value: double);
begin
  FLocalGridCell:=Value
end;

function TCustomSpatialModel.Get_ChangeLengthDirection: integer;
begin
  Result:=FChangeLengthDirection
end;

procedure TCustomSpatialModel.Set_ChangeLengthDirection(Value: integer);
begin
  FChangeLengthDirection:=Value
end;

function TCustomSpatialModel.Get_FieldCategory(Index: integer): WideString;
begin
  case Index of
  0: Result:='Общие параметры';
  1: Result:='Параметры вида';
  2: Result:='Параметры построения';
  3: Result:='Текущие параметры';
  end;
end;

function TCustomSpatialModel.Get_FieldCategoryCount: integer;
begin
  Result:=4
end;

function TCustomSpatialModel.Get_EdgeNodeDeletionAllowed: WordBool;
begin
  Result:=False
end;

function TCustomSpatialModel.CreateCollection(
  aClassID: integer; const aParent:IDMElement): IDMCollection;
begin
  Result:= inherited CreateCollection(aClassID, aParent)
end;

procedure TCustomSpatialModel.UpdateVolumes;
begin
end;

procedure TCustomSpatialModel.MakeVolumeOutline(const Volume: IVolume;
  const aCollection: IDMCollection);
var
  j, m, i:integer;
  AreaP:IPolyline;
  aLineE:IDMElement;
  aCollection2:IDMCollection2;
  theAreas:IDMCollection;
begin
  aCollection2:=aCollection as IDMCollection2;
  if Volume.BottomAreas.Count>0 then
    theAreas:=Volume.BottomAreas
  else
    theAreas:=Volume.TopAreas;
  for j:=0 to theAreas.Count-1 do begin
    AreaP:=theAreas.Item[j] as IPolyline;
    for m:=0 to AreaP.Lines.Count-1 do begin
      aLineE:=AreaP.Lines.Item[m];
      i:=aCollection.IndexOf(aLineE);
      if i=-1 then
        aCollection2.Add(aLineE)
      else
        aCollection2.Delete(i)
    end;
  end;
end;

procedure TCustomSpatialModel.CalcVolumeMinMaxZ(const Volume: IVolume);
var
  j:integer;
  Area:IArea;
  MinZ, MaxZ:double;
begin
  MinZ:=InfinitValue;
  MaxZ:=-InfinitValue;
  for j:=0 to Volume.Areas.Count-1 do begin
    Area:=Volume.Areas.Item[j] as IArea;
    if MinZ>Area.MinZ then
      MinZ:=Area.MinZ
    else
    if MaxZ<Area.MaxZ then
      MaxZ:=Area.MaxZ;
  end;
  Volume.MinZ:=MinZ;
  Volume.MaxZ:=MaxZ;
end;

function TCustomSpatialModel.Get_VerticalBoundaryLayer: IDMElement;
begin
  Result:=nil
end;

procedure TCustomSpatialModel.Set_VerticalBoundaryLayer(
  const Value: IDMElement);
begin
end;

function TCustomSpatialModel.GetColVolumeContaining(PX, PY, PZ: Double;
  const ColAreas, Volumes: IDMCollection): WordBool;
var
  Area:IArea;
  AreaE:IDMElement;
  j:integer;
  Volume:IVolume;
begin
try
  for j:=0 to Areas.Count-1 do begin
    Area:=Areas.Item[j] as IArea;
    if (not Area.IsVertical)
            and Area.ProjectionContainsPoint(PX, PY, 0) then begin
      Volume:=Area.Volume0;
      AreaE:=Area as IDMElement;
     if (Volume<>nil)
          and((Volume.MinZ<=PZ)and(Volume.MaxZ>=PZ))then begin
      if (Volume.BottomAreas.IndexOf(AreaE)<>-1) then begin
        if (Volumes.IndexOf(Volume as IDMElement)=-1)then begin
          (Volumes as IDMCollection2).Add(Volume as IDMElement);
          (ColAreas as IDMCollection2).Add(AreaE);
        end;
      end;
     end else begin
      Volume:=Area.Volume1;
      if (Volume<>nil)
             and((Volume.MinZ<=PZ)or(Volume.MaxZ>=PZ))then
        if (Volume.TopAreas.IndexOf(AreaE)<>-1) then
         if (Volumes.IndexOf(Volume as IDMElement)=-1)then begin
          (Volumes as IDMCollection2).Add(Volume as IDMElement);
          (ColAreas as IDMCollection2).Add(AreaE);
         end;
     end;
    end;
  end;
except
  raise
end;    
end;

procedure TCustomSpatialModel.GetInnerVolumes(const VolumeE: IDMElement;
  const InnerVolumes: IDMCollection);
begin
end;

procedure TCustomSpatialModel.GetUpperLowerVolumeParams(
  const VolumeRef: IDMElement; out UpperVolumeRefRef,
  LowerVolumeRefRef: IDMElement; out VolumeHeight, UpperVolumeHeight,
  LowerVolumeHeight: Double;
  out UpperVolumeUseSpecLayer, LowerVolumeUseSpecLayer: WordBool;
  out TopAreaUseSpecLayer: WordBool);
begin
end;

function TCustomSpatialModel.Get_MaxModelHeight: double;
begin
  Result:=FMaxModelHeight
end;

function TCustomSpatialModel.Get_BuildDirection: integer;
begin
  Result:=FBuildDirection
end;

procedure TCustomSpatialModel.Set_BuildDirection(Value: integer);
begin
  FBuildDirection:=Value
end;

function TCustomSpatialModel.Get_BuildWallsOnAllLevels: WordBool;
begin
  Result:=FBuildWallsOnAllLevels
end;

procedure TCustomSpatialModel.Set_BuildWallsOnAllLevels(Value: WordBool);
begin
  FBuildWallsOnAllLevels:=Value
end;

function TCustomSpatialModel.Get_EnabledBuildDirection: integer;
begin
  Result:=FEnabledBuildDirection
end;

procedure TCustomSpatialModel.Set_EnabledBuildDirection(Value: integer);
begin
  FEnabledBuildDirection:=Value;
  if FEnabledBuildDirection=1 then
    FBuildDirection:=bdUp
  else
  if FEnabledBuildDirection=2 then
    FBuildDirection:=bdDown;
end;

function TCustomSpatialModel.Get_DrawThreadTerminated: WordBool;
begin
  Result:=FDrawThreadTerminated
end;

procedure TCustomSpatialModel.Set_DrawThreadTerminated(Value: WordBool);
begin
  FDrawThreadTerminated:=Value
end;

function TCustomSpatialModel.Get_DrawThreadFinished: WordBool;
begin
  Result:=FDrawThreadFinished
end;

procedure TCustomSpatialModel.Set_DrawThreadFinished(Value: WordBool);
begin
  FDrawThreadFinished:=Value
end;

procedure TCustomSpatialModel.CheckErrors;
var
  Errors, Warnings, Lines, Nodes, Areas, Volumes:IDMCollection;
  Errors2, Warnings2:IDMCollection2;
  j, m, k:integer;
  LineE, aLineE, Node1E, AreaE, aParent, Area0E, Area1E:IDMElement;
  Line, aLine, Line0, Line1:ILine;
  Node0, Node1, C0, C1, C2:ICoordNode;
  Area, Area0, Area1:IArea;
  AreaP:IPolyline;
  OwnerCollection2:IDMCollection2;
  Volume0E, Volume1E, Element:IDMElement;
  NH, NVErr, NErr:integer;
  L:double;
  Volume:IVolume;
  LineIsVertical, PlanesAreParallel:boolean;
  X0, Y0, Z0, X1, Y1, Z1, X2, Y2, Z2, L0, L1:double;
  Unk:IUnknown;

  procedure AddError(const Element:IDMElement; Code:integer);
  var
    DMErrorE:IDMElement;
    DMError:IDMError;
  begin
    DMErrorE:=Errors2.CreateElement(True);
    if Code<10000 then
      Errors2.Add(DMErrorE)
    else
      Warnings2.Add(DMErrorE);
    DMErrorE.Ref:=Element;
    DMError:=DMErrorE as IDMError;
    DMError.Code:=Code;
  end;

begin
  Errors:=Get_Errors;
  if Errors=nil then Exit;
  Warnings:=Get_Warnings;
  if Warnings=nil then Exit;

  Errors2:=Errors as IDMCollection2;
  Errors2.Clear;
  Warnings2:=Warnings as IDMCollection2;
  Warnings2.Clear;

  try
  Lines:=Get_Lines;
  for j:=0 to Lines.Count-1 do begin
    Element:=Lines.Item[j];
    Line:=Element as ILine;
    L:=Line.Length;
    LineIsVertical:=Line.IsVertical;
    C0:=Line.C0;
    C1:=Line.C1;
    if (C0=nil) or (C1=nil) then begin
      AddError(Element, 4);
      Continue;
    end else
    if L<1 then
      AddError(Element, 0)
    else
    if L<20 then begin
      if ((C0.GetVerticalLine(bdUp)<>nil) and
          (C1.GetVerticalLine(bdUp)<>nil)) or
         ((C0.GetVerticalLine(bdDown)<>nil) and
          (C1.GetVerticalLine(bdDown)<>nil)) then
      AddError(Element, 10000);
    end;
    if (C0.Z>C1.Z) and
        LineIsVertical then
      AddError(Element, 7)
    else
    if (Element.Parents.Count=0) and
       (Element.Ref=nil) and
        LineIsVertical then
      AddError(Element, 5)
    else
    if (Element.Parents.Count=1) then begin
       if (Element.Parents.Item[0].ClassID=_Area) then
        AddError(Element, 1);
    end else begin
      if (Element.Parents.Count=2) and
         (Element as ILine).IsVertical then begin
        Area0E:=Element.Parents.Item[0];
        Area1E:=Element.Parents.Item[1];
        if (Area0E.QueryInterface(IArea, Area0)=0) and
           (Area1E.QueryInterface(IArea, Area1)=0) and
           (Area0E.Ref<>nil) and (Area1E.Ref<>nil) and
           (Area0E.Ref.Ref=Area1E.Ref.Ref) then begin
          PlanesAreParallel:=(abs(abs(Area0.NX*Area1.NX+Area0.NY*Area1.NY+Area0.NZ*Area1.NZ)-1)<0.005);
          if PlanesAreParallel then
            AddError(Element, 10001);
        end;
      end;
      NVErr:=0;
      NH:=0;
      for m:=0 to Element.Parents.Count-1 do begin
        if (Element.Parents.Item[m].ClassID=_Area) then begin
          Area:=Element.Parents.Item[m] as IArea;
          if not LineIsVertical and
             Area.IsVertical and
             (Area<>Line.GetVerticalArea(bdUp)) and
             (Area<>Line.GetVerticalArea(bdDown)) then
            inc(NVErr)
          else
          if Area.MinZ=Area.MaxZ then
            inc(NH)
        end;
      end;
      if NVErr>0 then begin
        if  C0.Z<>C1.Z then
          AddError(Element, 2)
        else
          AddError(Element, 6)
      end;
      if NH>2 then
        AddError(Element, 3);
    end;
  end;
  except
    raise
  end;

  try
  Nodes:=Get_CoordNodes;
  for j:=0 to Nodes.Count-1 do begin
    Element:=Nodes.Item[j];
    Node0:=Element as ICoordNode;
    if (Node0.Lines.Count=0) and
       (Element.Ref=nil) then
      AddError(Element, 0)
    else begin
      NErr:=0;
      NVErr:=0;
      for m:=0 to Node0.Lines.Count-1 do begin
        LineE:=Node0.Lines.Item[m];
        if LineE.QueryInterface(ICurvedLine, Unk)<>0 then begin
          Line:=LineE as ILine;
          Node1:=Line.NextNodeTo(Node0);
          for k:=0 to Node1.Lines.Count-1 do begin
            aLineE:=Node1.Lines.Item[k];
            aLine:=aLineE as ILine;
            if (aLine<>Line) and
               (aLine.NextNodeTo(Node1)=Node0) then
              inc(NErr)
          end;
          if Line.IsVertical and
             (Line<>Node0.GetVerticalLine(bdUp)) and
             (Line<>Node0.GetVerticalLine(bdDown)) then
            inc(NVErr)
        end;    
      end;
      if NErr>0 then
        AddError(Element, 1);
      if NVErr>0 then
        AddError(Element, 2);
    end;
  end;
  except
    raise
  end;

  try
  Areas:=Get_Areas;
  for j:=0 to Areas.Count-1 do begin
    Element:=Areas.Item[j];
    if Element.Ref=nil then
      AddError(Element, 0);
    AreaP:=Element as IPolyline;
    if AreaP.Lines.Count<3 then
      AddError(Element, 6)
    else begin
      Line:=AreaP.Lines.Item[0] as ILine;
      aLine:=AreaP.Lines.Item[AreaP.Lines.Count-1] as ILine;
      if (Line.C0<>aLine.C0) and
         (Line.C0<>aLine.C1) and
         (Line.C1<>aLine.C0) and
         (Line.C1<>aLine.C1) then
      AddError(Element, 2)
    end;
    Area:=Element as IArea;
    if (Area.Volume0=nil) and
       (Area.Volume1=nil) then
      AddError(Element, 3);
    if Area.IsVertical then begin
      if (Area.MaxZ-Area.MinZ)=0 then
        AddError(Element, 4);
      if (Area.C0=nil) or
         (Area.C1=nil) then
        AddError(Element, 5);
    end;

    for m:=0 to AreaP.Lines.Count-1 do begin
      Line0:=AreaP.Lines.Item[m] as ILine;
      Line1:=AreaP.Lines.Item[m+1] as ILine;
      if Line0.C0=Line1.C0 then begin
        C2:=Line0.C0;
        C0:=Line0.C1;
        C1:=Line1.C1;
      end else
      if Line0.C0=Line1.C1 then begin
        C2:=Line0.C0;
        C0:=Line0.C1;
        C1:=Line1.C0;
      end else
      if Line0.C1=Line1.C0 then begin
        C2:=Line0.C1;
        C0:=Line0.C0;
        C1:=Line1.C1;
      end else
      if Line0.C1=Line1.C1 then begin
        C2:=Line0.C1;
        C0:=Line0.C0;
        C1:=Line1.C0;
      end else begin
        C2:=nil;
        C0:=nil;
        C1:=nil;
        Break;
      end;

      X0:=C0.X;
      Y0:=C0.Y;
      Z0:=C0.Z;
      X1:=C1.X;
      Y1:=C1.Y;
      Z1:=C1.Z;
      X2:=C2.X;
      Y2:=C2.Y;
      Z2:=C2.Z;
      L0:=Line0.Length;
      L1:=Line1.Length;
      if (L0<>0) and (L1<>0) then begin
        if abs(((X2-X0)*(X2-X1)+(Y2-Y0)*(Y2-Y1)+(Z2-Z0)*(Z2-Z1))/(L0*L1)-1)<1.e-5 then begin
          AddError(Element, 1);
          Break;
        end;
      end;
    end;


  end;
  except
    raise
  end;

  try
  Volumes:=Get_Volumes;
  for j:=0 to Volumes.Count-1 do begin
    Element:=Volumes.Item[j];
    if Element.Ref=nil then
      AddError(Element, 0);
    Volume:=Element as IVolume;
    if (Volume.MaxZ-Volume.MinZ)<100 then
      AddError(Element, 1);
    if Volume.Areas.Count>0 then begin
      if Volume.BottomAreas.Count=0 then begin
        if Volume.TopAreas.Count=0 then begin
          if Volume.Areas.Count=2 then
            AddError(Element, 4)
          else
            AddError(Element, 2);
        end else
          AddError(Element, 2);
      end;
      if Volume.TopAreas.Count=0 then

        AddError(Element, 3);
    end;
  end;
  except
    raise
  end;
end;

function TCustomSpatialModel.Get_FastDraw: WordBool;
begin
  Result:=FFastDraw
end;

function TCustomSpatialModel.Get_Circles: IDMCollection;
begin
  Result:=Collection[_Circle]
end;

function TCustomSpatialModel.GetOuterVolume(
  const VolumeE: IDMElement): IDMElement;
begin
  Result:=FDefaultVolume
end;

procedure TCustomSpatialModel.Loaded;
var
  Collection:IDMCollection;
  aLayerE, aFontE:IDMElement;
begin
  inherited;
  Collection:=Get_Layers;
  if Collection.Count=0 then begin
    aLayerE:=(Layers as IDMCollection2).CreateElement(False);
    (Layers as IDMCollection2).Add(aLayerE);
    aLayerE.Name:=rsDefaultLayer;
    (aLayerE as ILayer).Color:=clBlack;
    FCurrentLayer:=aLayerE as ILayer;
  end else
  if Get_CurrentLayer=nil then
    Set_CurrentLayer(Collection.Item[0] as ILayer);

  Collection:=Get_Fonts;
  if (Collection<>nil) then begin
    if (Collection.Count=0) then begin
      aFontE:=(Get_Fonts as IDMCollection2).CreateElement(False);
      (Get_Fonts as IDMCollection2).Add(aFontE);
      aFontE.Name:=rsDefaultFont;
      FCurrentFont:=aFontE as ISMFont;
    end else
    if Get_CurrentFont=nil then
      Set_CurrentFont(Collection.Item[0] as ISMFont);
  end;

  CalcLimits;
end;

{ TSortedByDistanceList }

constructor TSortedByDistanceList.Create1(WX, WY, WZ: double);
begin
  inherited Create;
  FX:=WX;
  FY:=WY;
  FZ:=WZ;
end;

function TSortedByDistanceList.Compare(Key1, Key2: pointer): Integer;
var
  D1, D2, X0, Y0, Z0:double;
  OrtBaseOnLine:WordBool;
begin
  D1:=ILine(Key1).DistanceFrom(FX, FY, FZ, X0, Y0, Z0, OrtBaseOnLine);
  D2:=ILine(Key2).DistanceFrom(FX, FY, FZ, X0, Y0, Z0, OrtBaseOnLine);
  if D1<D2 then
    Result:=-1
  else if D1>D2 then
    Result:=+1
  else
    Result:=0
end;

function TCustomSpatialModel.GetAreaEqualTo(const aArea: IArea): IArea;
var
  j:integer;
  aAreaP:IPolyline;
begin
  Result:=nil;
  if aArea=nil then Exit;
  aAreaP:=aArea as IPolyline;
  try
  for j:=0 to Areas.Count-1 do
    if ((Areas.Item[j] as IPolyline).Lines as IDMCollection2).IsEqualTo(aAreaP.Lines) then begin
      Result:=Areas.Item[j] as IArea;
      Exit;
    end;
  except
    raise
  end;
end;

procedure TCustomSpatialModel.CorrectErrors;
var
  Errors, Warnings, Elements:IDMCollection;
  Elements2:IDMCollection2;
  AreaList, VolumeList:TList;
  DMOperationManager:IDMOperationManager;

  procedure JoinAreas(const Area0E, Area1E, LineE:IDMElement);

    function NodeConnecting(const Line0, Line1:ILine):ICoordNode;
    begin
      if (Line0.C0=Line1.C0) or
         (Line0.C0=Line1.C1) then
        Result:=Line0.C0
      else
      if (Line0.C1=Line1.C0) or
         (Line0.C1=Line1.C1) then
        Result:=Line0.C1
      else
        Result:=nil;
    end;

var
  Line:ILine;
  Area0, Area1:IArea;
  Area0P, Area1P:IPolyline;
  aLineE:IDMElement;
  Volume0E, Volume1E:IDMElement;
  n:integer;
begin
  Area0:=Area0E as IArea;
  Area1:=Area1E as IArea;

  Area0P:=Area0 as IPolyline;
  Area1P:=Area1 as IPolyline;

  Line:=LineE as ILine;
  Volume0E:=Area0.Volume0 as IDMElement;
  Volume1E:=Area0.Volume1 as IDMElement;
  Area0.Volume0:=nil;
  Area0.Volume1:=nil;
  Area0.Volume0IsOuter:=True;
  Area0.Volume1IsOuter:=True;

  LineE.RemoveParent(Area1E);
  LineE.RemoveParent(Area0E);
  while Area0P.Lines.Count>0 do begin
    aLineE:=Area0P.Lines.Item[0];
    aLineE.RemoveParent(Area0E);

    n:=Area1P.Lines.IndexOf(aLineE);
    if n=-1 then
      aLineE.AddParent(Area1E)
    else
      aLineE.RemoveParent(Area1E);
  end;

  Area1E.Ref.JoinSpatialElements(Area0E.Ref);

  Area0E.Clear;
  (Get_Areas as IDMCollection2).Remove(Area0E);
  LineE.Clear;
  (Get_Lines as IDMCollection2).Remove(LineE);

  Area1E.Update;

  if Volume0E<>nil then
    Volume0E.Update;
  if Volume1E<>nil then
    Volume1E.Update;
end;

  function CorrectError(const DMErrorE:IDMElement): boolean;
  var
    DMError:IDMError;
    Element:IDMElement;
    Code, m, k, i:integer;
    LineE, aLineE, Node1E, AreaE, aParent, MinLineE, MaxLineE, VolumeE,
    Line0E, Line1E:IDMElement;
    Line, aLine, Line0, Line1:ILine;
    Node0, Node1, MinNode, MaxNode, C0, C1, C2, aC, TMPNode:ICoordNode;
    Area:IArea;
    AreaP:IPolyline;
    OwnerCollection2:IDMCollection2;
    Area0E, Area1E:IDMElement;
    Z, aZ, Zmin,Zmax, aLen, theLen:double;
    UpdateList, LineList:TList;
    AreaUpE, AreaDownE, aAreaE, theAreaE, aRef:IDMElement;
    aArea, theArea, Area0, Area1:IArea;
    aAreaP, theAreaP:IPolyline;
    Volume, Volume0, Volume1:IVolume;
    X0, Y0, Z0, X1, Y1, Z1, X2, Y2, Z2, L0, L1:double;
    LineCollection:IDMCollection;
  begin
    Result:=False;
    DMError:=DMErrorE as IDMError;
    Code:=DMError.Code;
    Element:=DMErrorE.Ref;
    if not Element.Exists then Exit;
    try
    case Element.ClassID of
    _CoordNode:
      case Code of
      0:begin
          Element.Clear;
          (Get_CoordNodes as IDMCollection2).Remove(Element);
          Result:=True;
        end;
      1:begin
          Node0:=Element as ICoordNode;
          m:=0;
          while m<Node0.Lines.Count do begin
            LineE:=Node0.Lines.Item[m];
            Line:=LineE as ILine;
            Node1:=Line.NextNodeTo(Node0);
            k:=0;
            while k<Node1.Lines.Count do begin
              aLineE:=Node1.Lines.Item[k];
              aLine:=aLineE as ILine;
              if (aLine<>Line) and
                 (aLine.NextNodeTo(Node1)=Node0) then begin
                while aLineE.Parents.Count>0 do begin
                  aParent:=aLineE.Parents.Item[0];
                  if LineE.Parents.IndexOf(aParent)=-1 then
                    LineE.AddParent(aParent);
                  aLineE.RemoveParent(aParent);
                  aParent.Update;
                end;
                aLine.C0:=nil;
                aLine.C1:=nil;
                aLineE.Selected:=False;
                if aLineE.Ref<>nil then begin
                  OwnerCollection2:=aLineE.Ref.OwnerCollection as IDMCollection2;
                  aLineE.Ref.Clear;
                  OwnerCollection2.Remove(aLineE.Ref);
                end;
                (Get_Lines as IDMCollection2).Remove(aLineE);
              end else
                inc(k)
            end;
            inc(m);
          end;
          Result:=True;
        end;
      2:begin
          Node0:=Element as ICoordNode;
          Z:=Node0.Z;
          Zmin:=InfinitValue;
          Zmax:=-InfinitValue;
          MinNode:=nil;
          MaxNode:=nil;
          MinLineE:=nil;
          MaxLineE:=nil;
          for m:=0 to Node0.Lines.Count-1 do begin
            LineE:=Node0.Lines.Item[m];
            Line:=LineE as ILine;
            if Line.IsVertical then begin
              Node1:=Line.NextNodeTo(Node0);
              aZ:=Node1.Z;
              if (Zmin>aZ) and (aZ>Z) then begin
                Zmin:=aZ;
                MinNode:=Node1;
                MinLineE:=LineE;
              end;
              if (Zmax<aZ) and (aZ<Z) then begin
                Zmax:=aZ;
                MaxNode:=Node1;
                MaxLineE:=LineE;
              end;
            end;
          end;

          UpdateList:=TList.Create;
          for m:=0 to Node0.Lines.Count-1 do begin
            LineE:=Node0.Lines.Item[m];
            Line:=LineE as ILine;
            if Line.IsVertical then begin
              Node1:=Line.NextNodeTo(Node0);
              aZ:=Node1.Z;
              if (aZ>=Zmin) and (LineE<>MinLineE) then begin
                for k:=0 to LineE.Parents.Count-1 do begin
                  AreaE:=LineE.Parents.Item[k];
                  if MinLineE.Parents.IndexOf(AreaE)=-1 then begin
                    MinLineE.AddParent(AreaE);
                    if UpdateList.IndexOf(pointer(AreaE))=-1 then
                      UpdateList.Add(pointer(AreaE));
                  end;
                end;
                Line.C0:=MinNode;
              end;
              if (aZ<=Zmax) and (LineE<>MaxLineE) then begin
                for k:=0 to LineE.Parents.Count-1 do begin
                  AreaE:=LineE.Parents.Item[k];
                  if MaxLineE.Parents.IndexOf(AreaE)=-1 then begin
                    MaxLineE.AddParent(AreaE);
                    if UpdateList.IndexOf(pointer(AreaE))=-1 then
                      UpdateList.Add(pointer(AreaE));
                  end;
                end;
                Line.C1:=MaxNode;
              end;
            end;
          end;
          for m:=0 to UpdateList.Count-1 do begin
            AreaE:=IDMElement(UpdateList[m]);
            AreaE.Update;
          end;
          UpdateList.Free;
          Result:=True;
        end;
      end;
    _Line:
      case Code of
      0:begin
          LineE:=Element;
          Line:=LineE as ILine;
          Node0:=Line.C0;
          Node1:=Line.C1;
          if Node0<>Node1 then begin
            Node1E:=Node1 as IDMElement;
            m:=0;
            while m<Node1.Lines.Count do begin
              aLineE:=Node1.Lines.Item[m];
              if aLineE<>LineE then begin
                aLine:=aLineE as ILine;
                if aLine.C0=Node1 then
                  aLine.C0:=Node0
                else
                if aLine.C1=Node1 then
                  aLine.C1:=Node0
              end else
                inc(m);
            end;
            Node1E.Selected:=False;
            if Node1E.Ref<>nil then begin
              OwnerCollection2:=Node1E.Ref.OwnerCollection as IDMCollection2;
              Node1E.Ref.Clear;
              OwnerCollection2.Remove(Node1E.Ref);
            end;
            (Get_CoordNodes as IDMCollection2).Remove(Node1E);
          end;
          while LineE.Parents.Count>0 do begin
            AreaE:=LineE.Parents.Item[0];
            LineE.RemoveParent(AreaE);
            AreaE.Update;
          end;
          LineE.Selected:=False;
          Line.C0:=nil;
          Line.C1:=nil;
          if LineE.Ref<>nil then begin
            OwnerCollection2:=LineE.Ref.OwnerCollection as IDMCollection2;
            LineE.Ref.Clear;
            OwnerCollection2.Remove(LineE.Ref);
          end;
          (Get_Lines as IDMCollection2).Remove(LineE);
          Result:=True;
        end;
      1:begin
          aLineE:=Element;
          AreaE:=aLineE.Parents.Item[0];
          Area:=AreaE as IArea;
          Area.Volume0:=nil;
          Area.Volume1:=nil;
          AreaE.Clear;
          AreaE.Selected:=False;
          (Get_Areas as IDMCollection2).Remove(AreaE);
          aLine:=aLineE as ILine;
          aLine.C0:=nil;
          aLine.C1:=nil;
          aLineE.Clear;
          aLineE.Selected:=False;
          (Get_Lines as IDMCollection2).Remove(aLineE);
          Result:=True;
        end;
      4, 5:begin
          aLineE:=Element;
          Elements2.Clear;
          Elements2.Add(aLineE);
          DMOperationManager.DeleteElements(Elements, False);
          Result:=True;
        end;
      6:begin
          LineE:=Element;
          Line:=LineE as ILine;
          AreaUpE:=nil;
          AreaDownE:=nil;
          aAreaE:=nil;
          for m:=0 to LineE.Parents.Count-1 do begin
            AreaE:=LineE.Parents.Item[m];
            if (AreaE.ClassID=_Area) then begin
              Area:=AreaE as IArea;
              if Area.IsVertical then begin
                if Area=Line.GetVerticalArea(bdUp) then
                  AreaUpE:=AreaE
                else
                if Area=Line.GetVerticalArea(bdDown) then
                  AreaDownE:=AreaE
                else
                if Area.MaxZ>Line.C0.Z then begin
                  theAreaE:=AreaUpE;
                  aAreaE:=AreaE;
                  Break;
                end else begin
                  theAreaE:=AreaDownE;
                  aAreaE:=AreaE;
                  Break;
                end
              end;
            end;
          end; //for m:=0 to LineE.Parents.Count-1
          if (theAreaE<>nil) and
             (aAreaE<>nil) then begin
            theAreaP:=theAreaE as IPolyline;
            aAreaP:=aAreaE as IPolyline;
            aLen:=0;
            for m:=0 to aAreaP.Lines.Count-1 do begin
              aLine:=aAreaP.Lines.Item[m] as ILine;
              aLen:=aLen+aLine.Length;
            end;
            theLen:=0;
            for m:=0 to theAreaP.Lines.Count-1 do begin
              aLine:=theAreaP.Lines.Item[m] as ILine;
              theLen:=theLen+aLine.Length;
            end;
            if aLen<theLen then begin
              theAreaP:=aAreaE as IPolyline;
              aAreaP:=theAreaE as IPolyline;
            end;
            theAreaE:=theAreaP as IDMElement;
            aAreaE:=aAreaP as IDMElement;
            LineList:=TList.Create;
            for  m:=0 to aAreaP.Lines.Count-1 do begin
              aLineE:=aAreaP.Lines.Item[m];
              if theAreaP.Lines.IndexOf(aLineE)<>-1 then
                LineList.Add(pointer(aLineE))
            end; // while m<aAreaP.Lines.Count
            m:=0;
            while m<theAreaP.Lines.Count do begin
              aLineE:=theAreaP.Lines.Item[m];
              if aAreaP.Lines.IndexOf(aLineE)=-1 then
                aLineE.AddParent(aAreaE)
              else
                inc(m);
            end; // while m<theAreaP.Lines.Count
            for m:=0 to LineList.Count-1 do begin
              aLineE:=IDMElement(LineList[m]);
              aLineE.RemoveParent(aAreaE);
            end;
            LineList.Free;
            aAreaE.Update;

            theArea:=theAreaP as IArea;
            aArea:=aAreaP as IArea;
            if theArea.Volume0=aArea.Volume0 then
              theArea.Volume1:=aArea.Volume1
            else
            if theArea.Volume0=aArea.Volume1 then
              theArea.Volume1:=aArea.Volume0
            else
            if theArea.Volume1=aArea.Volume0 then
              theArea.Volume0:=aArea.Volume1
            else
            if theArea.Volume1=aArea.Volume1 then
              theArea.Volume0:=aArea.Volume0;
          end; // if (theAreaE<>nil) and
          Result:=True;
        end; // 6
      7:begin
          LineE:=Element;
          for m:=0 to LineE.Parents.Count-1 do begin
            aAreaE:=LineE.Parents.Item[m];
            if (aAreaE.QueryInterface(IArea, aArea)=0) and
               (AreaList.IndexOf(pointer(aAreaE))=-1) then
              AreaList.Add(pointer(aAreaE))
          end;
          Line:=LineE as ILine;
          C0:=Line.C0;
          C1:=Line.C1;
          TMPNode:=(Get_CoordNodes as IDMCollection2).CreateElement(True) as ICoordNode;
          m:=0;
          while m<C0.Lines.Count do begin
            aLine:=C0.Lines.Item[m] as ILine;
            if aLine.IsVertical then begin
              if aLine.C0=C0 then
                aLine.C0:=TMPNode
              else
                aLine.C1:=TMPNode
            end else
              inc(m)
          end;
          m:=0;
          while m<C1.Lines.Count do begin
            aLine:=C1.Lines.Item[m] as ILine;
            if (aLine=Line) or aLine.IsVertical then begin
              if aLine.C0=C1 then
                aLine.C0:=C0
              else
                aLine.C1:=C0
            end else
              inc(m)
          end;
          m:=0;
          while m<TMPNode.Lines.Count do begin
            aLine:=TMPNode.Lines.Item[m] as ILine;
            if aLine.C0=TMPNode then
              aLine.C0:=C1
            else
              aLine.C1:=C1
          end;
          Result:=True;
        end;
      10001:
         if Element.Parents.Count>0 then begin
           Area0E:=Element.Parents.Item[0];
           Area1E:=Element.Parents.Item[1];
           JoinAreas(Area0E, Area1E, Element);
           Result:=True;
         end;
      end; // _Line
    _Area:
    case Code of
    0,3,4,5,6:
      begin
        AreaE:=Element;
        Area:=AreaE as IArea;
        Area.Volume0:=nil;
        Area.Volume1:=nil;
        AreaE.Clear;
        AreaE.Selected:=False;
        (Get_Areas as IDMCollection2).Remove(AreaE);
        Result:=True;
      end;
    1:begin
        AreaE:=Element;
        AreaP:=Element as IPolyline;
        for m:=0 to AreaP.Lines.Count-1 do begin
          Line0:=AreaP.Lines.Item[m] as ILine;
          Line1:=AreaP.Lines.Item[m+1] as ILine;
          Line0E:=Line0 as IDMElement;
          Line1E:=Line1 as IDMElement;
          if Line0.C0=Line1.C0 then begin
            C2:=Line0.C0;
            C0:=Line0.C1;
            C1:=Line1.C1;
          end else
          if Line0.C0=Line1.C1 then begin
            C2:=Line0.C0;
            C0:=Line0.C1;
            C1:=Line1.C0;
          end else
          if Line0.C1=Line1.C0 then begin
            C2:=Line0.C1;
            C0:=Line0.C0;
            C1:=Line1.C1;
          end else
          if Line0.C1=Line1.C1 then begin
            C2:=Line0.C1;
            C0:=Line0.C0;
            C1:=Line1.C0;
          end else begin
            C2:=nil;
            C0:=nil;
            C1:=nil;
            Break;
          end;
          X0:=C0.X;
          Y0:=C0.Y;
          Z0:=C0.Z;
          X1:=C1.X;
          Y1:=C1.Y;
          Z1:=C1.Z;
          X2:=C2.X;
          Y2:=C2.Y;
          Z2:=C2.Z;
          L0:=Line0.Length;
          L1:=Line1.Length;
          if (L0<>0) and (L1<>0) then begin
            if abs(((X2-X0)*(X2-X1)+(Y2-Y0)*(Y2-Y1)+(Z2-Z0)*(Z2-Z1))/(L0*L1)-1)<0.002 then begin
              if L0>L1 then begin
                Line:=Line1;
                Line1:=Line0;
                Line0:=Line;
                aC:=C1;
                C1:=C0;
                C0:=aC;
              end;
              if Line1.C0=C2 then
                Line1.C0:=C0
              else
                Line1.C1:=C0;
              Line0E.RemoveParent(AreaE);
              k:=0;
              while k<Line1E.Parents.Count do begin
                aAreaE:=Line1E.Parents.Item[k];
                if Line0E.Parents.IndexOf(aAreaE)=-1 then begin
                  Line0E.AddParent(aAreaE);
                  aAreaE.Update;
                end;
                inc(k);
              end;
              Element.Update;
              break;
            end;
          end;
        end;
        Result:=True;
      end;
    2:begin
        Element.Update;
        Result:=True;
      end;  
     end;
    _Volume:
      case Code of
      2,3:
        begin
          VolumeE:=Element;
          Volume:=VolumeE as IVolume;
          AreaE:=(Get_Areas as IDMCollection2).CreateElement(False);
          (Get_Areas as IDMCollection2).Add(AreaE);
          AreaE.Parent:=VolumeE.Parent;
          Area:=AreaE as IArea;
          theAreaE:=nil;
          OwnerCollection2:=nil;
          for k:=0 to Volume.Areas.Count-1 do begin
            aAreaE:=Volume.Areas.Item[k];
            aArea:=aAreaE as IArea;
            if aArea.IsVertical then begin
              if Code=2 then
                LineCollection:=aArea.BottomLines
              else
                LineCollection:=aArea.TopLines;
              for m:=0 to LineCollection.Count-1 do begin
                LineE:=LineCollection.Item[m];
                if OwnerCollection2=nil then begin
                  i:=0;
                  while i<LineE.Parents.Count do begin
                    theAreaE:=LineE.Parents.Item[i];
                    if (theAreaE.QueryInterface(IArea, theArea)=0) and
                       (not theArea.IsVertical) then begin
                      break;
                    end else
                      inc(i)
                  end;
                  if i<LineE.Parents.Count then begin
                    theAreaE:=theArea as IDMElement;
                    OwnerCollection2:=theAreaE.Ref.OwnerCollection as IDMCollection2;
                  end;
                end;
                LineE.AddParent(AreaE);
              end;
            end;
          end;
          aRef:=OwnerCollection2.CreateElement(False);
          OwnerCollection2.Add(aRef);
          aRef.Ref:=theAreaE.Ref.Ref;
          AreaE.Ref:=aRef;
          if Code=2 then
            Area.Volume0:=Volume
          else
            Area.Volume1:=Volume;
          AreaE.Update;
          Result:=True;
        end;
      4:begin
         VolumeE:=Element;
         Volume:=VolumeE as IVolume;
         Area0:=Volume.Areas.Item[0] as IArea;
         Area1:=Volume.Areas.Item[1] as IArea;
         if Area0.Volume0=Volume then
           Volume0:=Area0.Volume1
         else
           Volume0:=Area0.Volume0;
         if Area1.Volume0=Volume then
           Volume1:=Area1.Volume1
         else
           Volume1:=Area1.Volume0;
         Area1.Volume0:=nil;
         Area1.Volume1:=nil;
         AreaE:=Area1 as IDMElement;
         AreaE.Clear;
         (Get_Areas as IDMCollection2).Remove(AreaE);
         Area0.Volume0:=Volume0;
         Area0.Volume1:=Volume1;
         VolumeE.Selected:=False;
         VolumeE.Clear;
         (Get_Volumes as IDMCollection2).Remove(VolumeE);
         Result:=True;
        end;
      end;
    end;
    except
      raise
    end;
  end;

  procedure RevertArea(const AreaE:IDMElement);
  var
    Area:IArea;
    Volume0, Volume1:IVolume;
    TopLineList:TList;
    k:integer;
    aLineE, UpAreaE, DownAreaE:IDMElement;
    aLine:ILine;
  begin
    Area:=AreaE as IArea;
    Volume0:=Area.Volume0;
    Volume1:=Area.Volume1;
    TopLineList:=TList.Create;
    UpAreaE:=nil;
    DownAreaE:=nil;
    for k:=0 to Area.TopLines.Count-1 do begin
      aLineE:=Area.TopLines.Item[k];
      aLine:=aLineE as ILine;
      if k=0 then
        DownAreaE:=aLine.GetVerticalArea(bdDown) as IDMElement;
      aLineE.RemoveParent(DownAreaE);
      TopLineList.Add(pointer(aLineE));
    end;
    for k:=0 to Area.BottomLines.Count-1 do begin
      aLineE:=Area.BottomLines.Item[k];
      aLine:=aLineE as ILine;
      if k=0 then
        UpAreaE:=aLine.GetVerticalArea(bdUp) as IDMElement;
      aLineE.RemoveParent(UpAreaE);
      aLineE.AddParent(DownAreaE);
    end;
    for k:=0 to TopLineList.Count-1 do begin
      aLineE:=IDMElement(TopLineList[k]);
      aLineE.AddParent(UpAreaE);
    end;
    TopLineList.Free;
  end;

  procedure RevertVolume(const VolumeE:IDMElement);
  begin
  end;
var
  DMErrorE:IDMElement;
  j:integer;
  AreaE, VolumeE:IDMElement;
  Document:IDMDocument;
begin
  Errors:=Get_Errors;
  Warnings:=Get_Warnings;
  Elements:=CreateCollection(-1, nil);
  Elements2:=Elements as IDMCollection2;
  Document:=Get_Document as IDMDocument;
  DMOperationManager:=Document as IDMOperationManager;
  Document.State:=Document.State or dmfLongOperation;
  try
  AreaList:=TList.Create;
  for j:=0 to Errors.Count-1 do begin
    DMErrorE:=Errors.Item[j];
    if DMErrorE.Selected then begin
      if CorrectError(DMErrorE) then
        DMErrorE.Selected:=False;
    end;
  end;
  VolumeList:=TList.Create;
  for j:=0 to AreaList.Count-1 do begin
    AreaE:=IDMElement(AreaList[j]);
    RevertArea(AreaE);
  end;
  for j:=0 to VolumeList.Count-1 do begin
    VolumeE:=IDMElement(VolumeList[j]);
    RevertVolume(VolumeE);
  end;
  VolumeList.Free;
  AreaList.Free;
  for j:=0 to Warnings.Count-1 do begin
    DMErrorE:=Warnings.Item[j];
    if DMErrorE.Selected then begin
      DMErrorE.Selected:=False;
      CorrectError(DMErrorE);
    end;
  end;
  finally
    Document.State:=Document.State and not dmfLongOperation;
  end;
end;

function TCustomSpatialModel.Get_DefaultObjectWidth: double;
begin
  Result:=FDefaultObjectWidth
end;

procedure TCustomSpatialModel.Set_DefaultObjectWidth(Value: double);
begin
  FDefaultObjectWidth:=Value
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TCustomSpatialModel.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
