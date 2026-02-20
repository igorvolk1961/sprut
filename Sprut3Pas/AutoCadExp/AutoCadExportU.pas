unit AutoCadExportU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj, DM_ActiveX,
  Types, Classes, SysUtils, AutoCadExp_TLB, StdVcl, SpatialModelLib_Tlb, PainterLib_TLB,
  DataModel_TLB, Math, Variants, Graphics, DMServer_TLB;

const
  InfinitValue=999999;

  ViewPortCount=1;
  LineTypeCount0=2;
  LineTypeCount=5;
  LayerCount0=1;
  StyleCount=1;
  ViewCount=1;
  UCSCount=0;
  APPIDCount=1;
  DimStyleCount=1;
  BlockRecordCount0=2;
  ObjectCount=4;

type
 TPointF=record
   X:double;
   Y:double;
   Z:double;
 end;

 TPointArrayF=array[0..4] of TPointF;

type
  TAutoCadExport = class(TDM_AutoObject, IAutoCadExport, IPainter)
  Private
    FCurrentHandle:integer;
    FSpatialModel:ISpatialModel;
    FK:double;
    FPageX:double;
    FPageY:double;
    FLayerIndex: integer;
    FLayerCount:integer;

    FFile:TextFile;

    FView:IView;
    FLocalView:IView;

    FWriteFlag:boolean;
    FWritingBlock:integer;
    FMode:integer;
    FPenStyle:integer;
    FPenColor:integer;
    FPenMode:integer;
    FPenWidth:integer;
    FBrushStyle:integer;
    FBrushColor:integer;


    FLayers:TStringList;
    FBlockList:TList;
    FEntityCount:integer;

//    FFont:TFont;

    procedure BuildHeader;
    procedure BuildClasses;
    procedure BuildTables;

    procedure BuildViewPortTable;
    procedure BuildLineTypeTable;
    procedure BuildLayerTable;
    procedure BuildStyleTable;
    procedure BuildViewTable;
    procedure BuildUCSTable;
    procedure BuildAPPIDTable;
    procedure BuildDimStyleTable;
    procedure BuildBlockRecordTable;

    procedure BuildBlocks;
    procedure BuildObjects;

    procedure BuildLine(x0, y0, z0, x1, y1, z1: double);
    procedure BuildBezier(const PointArray: array of TPointF);
    procedure BuildText(x0, y0, z0, TextSize: double; const Text: string);
    procedure BuildInsertBlock(const BlockName:string);
  protected
    function Get_SpatialModel: IUnknown; safecall;
    procedure SaveToFile(const FileName: WideString); safecall;
    procedure Set_SpatialModel(const Value: IUnknown); safecall;

    function Get_ViewU: IUnknown; safecall;
    procedure Set_ViewU(const Value: IUnknown); safecall;
    function Get_PenColor: Integer; safecall;
    procedure Set_PenColor(Value: Integer); safecall;
    function Get_PenMode: Integer; safecall;
    procedure Set_PenMode(Value: Integer); safecall;
    procedure Clear; safecall;
    procedure DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z, P3X, P3Y, P3Z, P4X,
      P4Y, P4Z, aAngle: Double; PictureHandle: LongWord; PictureFMT, Alpha: Integer); safecall;
    procedure DrawCurvedLine(VarPointArray: OleVariant); safecall;
    procedure DrawLine(WX0, WY0, WZ0, WX1, WY1, WZ1: Double); safecall;
    procedure DrawArc(WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, WZ2: Double); safecall;
    procedure DrawPoint(WX, WY, WZ: Double); safecall;
    procedure DrawCircle(WX: Double; WY: Double; WZ: Double; R: Double; R_In_Pixels: WordBool); safecall;
    procedure DrawPolygon(const Lines: IDMCollection; Vertical: WordBool);
      safecall;
    procedure DragLine(PX0: Integer; PY0: Integer; PZ0: Integer; PX1: Integer; PY1: Integer;
                       PZ1: Integer); safecall;
    procedure DragRect(PX0: Integer; PY0: Integer; PZ0: Integer; PX1: Integer; PY1: Integer;
                       PZ1: Integer); safecall;
    procedure DragCurvedLine(VarPointArray: OleVariant); safecall;
    function Get_PenStyle: Integer; safecall;
    procedure Set_PenStyle(Value: Integer); safecall;
    function Get_PenWidth: Double; safecall;
    procedure Set_PenWidth(Value: Double); safecall;
    function Get_BrushColor: Integer; safecall;
    function Get_BrushStyle: Integer; safecall;
    procedure Set_BrushColor(Value: Integer); safecall;
    procedure Set_BrushStyle(Value: Integer); safecall;
    procedure DrawAxes(XP, YP, ZP:integer); safecall;
    procedure SetRangePix; safecall;
    procedure DrawRangeMarks; safecall;
    function Get_DmaxPix: Integer; safecall;
    function Get_DminPix: Integer; safecall;
    function Get_ZmaxPix: Integer; safecall;
    function Get_ZminPix: Integer; safecall;
    procedure Set_DmaxPix(Value: Integer); safecall;
    procedure Set_DminPix(Value: Integer); safecall;
    procedure Set_ZmaxPix(Value: Integer); safecall;
    procedure Set_ZminPix(Value: Integer); safecall;
    function Get_HCanvasHandle: Integer; safecall;
    function Get_VCanvasHandle: Integer; safecall;
    procedure Set_HCanvasHandle(Value: Integer); safecall;
    procedure Set_VCanvasHandle(Value: Integer); safecall;
    procedure WP_To_P(WX, WY, WZ: Double; out PX, PY, PZ: Integer); safecall;
    procedure P_To_WP(PX, PY, Tag: Integer; out WX, WY, WZ: Double); safecall;
    procedure DrawRectangle(WX0, WY0, WZ0, WX1, WY1, WZ1, Angle: Double);
      safecall;
    function Get_LocalViewU: IUnknown; safecall;
    procedure Set_LocalViewU(const Value: IUnknown); safecall;
    procedure DrawText(WX, WY, WZ: Double; const Text: WideString;
      TextSize: Double; const FontName: WideString; FontSize, FontColor,
      FontStyle, ScaleMode: Integer); safecall;  public
    function Get_LayerIndex: Integer; safecall;
    procedure Set_LayerIndex(Value: Integer); safecall;
    function Get_UseLayers: WordBool; safecall;
    procedure SetLimits; safecall;
    function  LineIsVisible(aCanvasTag:integer;
                            var X0,Y0,Z0, X1,Y1,Z1:double; FitToCanvas:WordBool;
                            CanvasLevel: integer):WordBool; safecall;
    function Get_HHeight: Integer; safecall;
    procedure Set_HHeight(Value: Integer); safecall;
    function Get_HWidth: Integer; safecall;
    procedure Set_HWidth(Value: Integer); safecall;
    function Get_VWidth: Integer; safecall;
    procedure Set_VWidth(Value: Integer); safecall;
    function Get_VHeight: Integer; safecall;
    procedure Set_VHeight(Value: Integer); safecall;
    function Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    procedure CloseBlock; safecall;
    procedure InsertBlock(const ElementU: IUnknown); safecall;
    function CheckVisiblePoint(aCanvasTag: Integer; X, Y, Z: Double): WordBool;
      safecall;
    procedure DrawTexture(const TextureName: WideString;
    var TextureNum: Integer; x0, y0, z0, x1, y1, z1, x2,
      y2, z2, x3, y3, z3, NX, NY, NZ, MX, MY: Double); safecall;
    procedure GetTextExtent(const Text: WideString; out Width, Height: Double);
      safecall;
    procedure SetFont(const FontName: WideString; FontSize, FontStyle,
      FontColor: Integer); safecall;
    function Get_IsPrinter: WordBool; safecall;
    procedure Set_IsPrinter(Value: WordBool); safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

procedure CorrectName(var S:string);
var
  m:integer;
begin
  S:=Copy(S, 1, 31);
  S:=ANSIUpperCase(S);
  for m:=1 to length(S) do
    case S[m] of
    ' ': S[m]:='_';
    '0'..'9',
    'A'..'Z',
    'А'..'Я':
       begin
       end;
     else
       S[m]:='$';
    end;
end;

destructor TAutoCadExport.Destroy;
begin
  inherited;
  FSpatialModel:=nil;
  FLayers.Free;
  FBlockList.Free;
end;

function TAutoCadExport.Get_SpatialModel: IUnknown;
begin
    Result:=FSpatialModel as IUnknown;
end;

procedure TAutoCadExport.BuildLine(x0,y0,z0,x1,y1,z1:double);
begin
  writeln(FFile, '  0');
  writeln(FFile, 'LINE');
  writeln(FFile, '  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(FFile, '100');
  writeln(FFile, 'AcDbEntity');

  writeln(FFile, '  8');
  writeln(FFile, FLayers[FLayerIndex]);

  writeln(FFile, '100');
  writeln(FFile, 'AcDbLine');

  writeln(FFile, ' 10');
  writeln(FFile, FloatToStr(x0));
  writeln(FFile, ' 20');
  writeln(FFile, FloatToStr(y0));
  writeln(FFile, ' 30');
  writeln(FFile, FloatToStr(z0));
  writeln(FFile, ' 11');
  writeln(FFile, FloatToStr(x1));
  writeln(FFile, ' 21');
  writeln(FFile, FloatToStr(y1));
  writeln(FFile, ' 31');
  writeln(FFile, FloatToStr(z1));
end;

procedure TAutoCadExport.BuildLineTypeTable;
  procedure BuildLineType(const Name1, Name2:string; L:real; LineType:array of real);
  var
    N, j:integer;
  begin
    N:=High(LineType)+1;
    writeln(FFile, '  0');
    writeln(FFile, 'LTYPE');

    writeln(FFile, '  5');
    writeln(FFile, IntToHex(FCurrentHandle, 1));
    inc(FCurrentHandle);

    writeln(FFile, '100');
    writeln(FFile, 'AcDbSymbolTableRecord');
    writeln(FFile, '100');
    writeln(FFile, 'AcDbLinetypeTableRecord');

    writeln(FFile, '  2');
    writeln(FFile, Name1);

    writeln(FFile, ' 70');
    writeln(FFile, '     0');

    writeln(FFile, '  3');
    writeln(FFile, Name2);
    writeln(FFile, ' 72');
    writeln(FFile, '    65');
    writeln(FFile, ' 73');
    writeln(FFile, Format('%6d',[N]));
    writeln(FFile, ' 40');
    writeln(FFile, Format('%0.1f',[L]));
    for j:=0 to N-1 do begin
      writeln(FFile, ' 49');
      writeln(FFile, Format('%0.1f',[LineType[j]]));
      writeln(FFile, ' 74');
      writeln(FFile, '     0');
    end;
  end;
begin
  writeln(FFile, '  0');
  writeln(FFile, 'TABLE');

  writeln(FFile, '  2');
  writeln(FFile, 'LTYPE');

  writeln(FFile, '  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(FFile, '100');
  writeln(FFile, 'AcDbSymbolTable');

  writeln(FFile, ' 70');
  writeln(FFile, IntToStr(LineTypeCount0+LineTypeCount));   // число LTypes

  BuildLineType('BYBLOCK','', 0., []);
  BuildLineType('BYLAYER','', 0., []);
  BuildLineType('CONTINUOUS','Solid line', 0., []);
  BuildLineType('DASH','ISO dash __ __ __ __', 15., [12., -3.]);
  BuildLineType('DOT','ISO dot . . . .', 3., [0., -3.]);
  BuildLineType('DASH_DOT','ISO dash dot __ . __ .', 18., [12., -3, 0., -3.]);
  BuildLineType('DASH_DOT_DOT','ISO dash double-dot __ . __ .', 21., [12., -3, 0., -3., 0., -3]);

  writeln(FFile, '  0');
  writeln(FFile, 'ENDTAB');
end;

procedure TAutoCadExport.BuildLayerTable;
var
  L:integer;
  LStyle, LayerName:string;
  LayerE:IDMElement;
  Layer:ILayer;
  Flags, Color:integer;

  procedure DoBuildLayer;
  begin
    writeln(FFile, '  0');
    writeln(FFile, 'LAYER');

    writeln(FFile, '  5');
    writeln(FFile, IntToHex(FCurrentHandle, 1));
    inc(FCurrentHandle);

    writeln(FFile, '100');
    writeln(FFile, 'AcDbSymbolTableRecord');
    writeln(FFile, '100');
    writeln(FFile, 'AcDbLayerTableRecord');

    writeln(FFile, '  2');
    writeln(FFile, LayerName);

    writeln(FFile, ' 70');
    writeln(FFile, Format('%6d', [Flags]));
    writeln(FFile, ' 62');
    writeln(FFile, Format('%6d', [Color]));
    writeln(FFile, '  6');
    writeln(FFile, LStyle);

//    writeln(FFile, '390');
//    writeln(FFile, 'F'); // pointer to PlotStyleName
  end;

  procedure BuildLayer(const LayerE:IDMElement);
  begin
    Layer:=LayerE as ILayer;
    LayerName:=LayerE.Name;
    CorrectName(LayerName);

    FLayers.Add(LayerName);

    Flags:=0;
    if not Layer.Visible then
      Flags:=Flags or 1;
    if not Layer.Selectable then
      Flags:=Flags or 4;

    Color:=7;
    case Layer.Style of
    1: LStyle:='DASH';
    2: LStyle:='DOT';
    3: LStyle:='DASH_DOT';
    4: LStyle:='DASH_DOT_DOT';
    else LStyle:='CONTINUOUS';
    end;

    LStyle:='CONTINUOUS';
    
    DoBuildLayer;
  end;

begin
  writeln(FFile, '  0');
  writeln(FFile, 'TABLE');

  writeln(FFile, '  2');
  writeln(FFile, 'LAYER');
  writeln(FFile, '  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(FFile, '100');
  writeln(FFile, 'AcDbSymbolTable');

  writeln(FFile, ' 70');
  writeln(FFile, Format('%6d', [LayerCount0+FSpatialModel.Layers.Count]));

  LayerName:='0';
  LStyle:='CONTINUOUS';
  Color:=7;

  DoBuildLayer;

  FLayers.Clear;

  for L:=0 to FSpatialModel.Layers.Count-1 do begin
    LayerE:=FSpatialModel.Layers.Item[L];
    BuildLayer(LayerE);
  end;

  FLayerCount:=FLayers.Count;

  for L:=0 to FBlockList.Count-1 do begin
    LayerE:=IDMElement(FBlockList[L]);
    BuildLayer(LayerE);
  end;


  writeln(FFile, '  0');
  writeln(FFile, 'ENDTAB');
end;

procedure TAutoCadExport.BuildHeader;
var
  MaxHandle:integer;
begin
  MaxHandle:=1+ViewPortCount+
             1+LineTypeCount0+LineTypeCount+
             1+LayerCount0+FSpatialModel.Layers.Count+
             1+StyleCount+
             1+ViewCount+(FSpatialModel as ISpatialModel2).Views.Count+
             1+UCSCount+
             1+APPIDCount+
             1+DimStyleCount+
             1+BlockRecordCount0+FBlockList.Count+
             BlockRecordCount0+FBlockList.Count+
             BlockRecordCount0+FBlockList.Count+
             FEntityCount+
             ObjectCount;
  writeln(Ffile,'  0');
  writeln(Ffile,'SECTION');
  writeln(Ffile,'  2');
  writeln(Ffile,'HEADER');

  writeln(Ffile,'  9');
  writeln(Ffile,'$ACADVER');
  writeln(Ffile,'  1');
  writeln(Ffile,'AC1012');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DWGCODEPAGE');
  writeln(Ffile,'  3');
  writeln(Ffile,'ANSI_1251');
  writeln(Ffile,'  9');
  writeln(Ffile,'$INSBASE');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$EXTMIN');
  writeln(Ffile,' 10');
  writeln(Ffile,'110.702964');
  writeln(Ffile,' 20');
  writeln(Ffile,'82.674916');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$EXTMAX');
  writeln(Ffile,' 10');
  writeln(Ffile,'276.553162');
  writeln(Ffile,' 20');
  writeln(Ffile,'216.172346');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$LIMMIN');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$LIMMAX');
  writeln(Ffile,' 10');
  writeln(Ffile,'420.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'297.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$ORTHOMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$REGENMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$FILLMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$QTEXTMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$MIRRTEXT');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DRAGMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     2');
  writeln(Ffile,'  9');
  writeln(Ffile,'$LTSCALE');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$OSMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$ATTMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TEXTSIZE');
  writeln(Ffile,' 40');
  writeln(Ffile,'2.5');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TRACEWID');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TEXTSTYLE');
  writeln(Ffile,'  7');
  writeln(Ffile,'STANDARD');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CLAYER');
  writeln(Ffile,'  8');
  writeln(Ffile,'0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CELTYPE');
  writeln(Ffile,'  6');
  writeln(Ffile,'BYLAYER');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CECOLOR');
  writeln(Ffile,' 62');
  writeln(Ffile,'   256');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CELTSCALE');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DELOBJ');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DISPSILH');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSCALE');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMASZ');
  writeln(Ffile,' 40');
  writeln(Ffile,'2.5');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMEXO');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.625');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMDLI');
  writeln(Ffile,' 40');
  writeln(Ffile,'3.75');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMRND');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMDLE');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMEXE');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.25');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTP');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTM');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTXT');
  writeln(Ffile,' 40');
  writeln(Ffile,'2.5');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMCEN');
  writeln(Ffile,' 40');
  writeln(Ffile,'2.5');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTSZ');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTOL');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMLIM');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTIH');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTOH');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSE1');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSE2');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTAD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMZIN');
  writeln(Ffile,' 70');
  writeln(Ffile,'     8');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMBLK');
  writeln(Ffile,'  1');
  writeln(Ffile,'');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMASO');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSHO');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMPOST');
  writeln(Ffile,'  1');
  writeln(Ffile,'');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMAPOST');
  writeln(Ffile,'  1');
  writeln(Ffile,'');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMALT');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMALTD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     4');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMALTF');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0394');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMLFAC');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTOFL');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTVP');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTIX');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSOXD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSAH');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMBLK1');
  writeln(Ffile,'  1');
  writeln(Ffile,'');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMBLK2');
  writeln(Ffile,'  1');
  writeln(Ffile,'');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSTYLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'STANDARD');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMCLRD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMCLRE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMCLRT');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTFAC');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMGAP');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.625');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMJUST');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSD1');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMSD2');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTOLJ');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTZIN');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMALTZ');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMALTTZ');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMFIT');
  writeln(Ffile,' 70');
  writeln(Ffile,'     3');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMUPT');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMUNIT');
  writeln(Ffile,' 70');
  writeln(Ffile,'     8');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMDEC');
  writeln(Ffile,' 70');
  writeln(Ffile,'     4');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTDEC');
  writeln(Ffile,' 70');
  writeln(Ffile,'     4');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMALTU');
  writeln(Ffile,' 70');
  writeln(Ffile,'     8');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMALTTD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     4');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMTXSTY');
  writeln(Ffile,'  7');
  writeln(Ffile,'STANDARD');
  writeln(Ffile,'  9');
  writeln(Ffile,'$DIMAUNIT');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$LUNITS');
  writeln(Ffile,' 70');
  writeln(Ffile,'     2');
  writeln(Ffile,'  9');
  writeln(Ffile,'$LUPREC');
  writeln(Ffile,' 70');
  writeln(Ffile,'     4');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SKETCHINC');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$FILLETRAD');
  writeln(Ffile,' 40');
  writeln(Ffile,'10.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$AUNITS');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$AUPREC');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$MENU');
  writeln(Ffile,'  1');
  writeln(Ffile,'.');
  writeln(Ffile,'  9');
  writeln(Ffile,'$ELEVATION');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PELEVATION');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$THICKNESS');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$LIMCHECK');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$BLIPMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CHAMFERA');
  writeln(Ffile,' 40');
  writeln(Ffile,'10.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CHAMFERB');
  writeln(Ffile,' 40');
  writeln(Ffile,'10.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CHAMFERC');
  writeln(Ffile,' 40');
  writeln(Ffile,'20.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CHAMFERD');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SKPOLY');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TDCREATE');
  writeln(Ffile,' 40');
  writeln(Ffile,'2453633.802054513');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TDUPDATE');
  writeln(Ffile,' 40');
  writeln(Ffile,'2453633.802054513');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TDINDWG');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0000000000');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TDUSRTIMER');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0000000000');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USRTIMER');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$ANGBASE');
  writeln(Ffile,' 50');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$ANGDIR');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PDMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PDSIZE');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PLINEWID');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$COORDS');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SPLFRAME');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SPLINETYPE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     6');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SPLINESEGS');
  writeln(Ffile,' 70');
  writeln(Ffile,'     8');
  writeln(Ffile,'  9');
  writeln(Ffile,'$ATTDIA');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$ATTREQ');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');

  writeln(Ffile,'$HANDLING');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$HANDSEED');
  writeln(Ffile,'  5');
  writeln(Ffile,IntToHex(MaxHandle+1, 1));

  writeln(Ffile,'  9');
  writeln(Ffile,'$SURFTAB1');
  writeln(Ffile,' 70');
  writeln(Ffile,'     6');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SURFTAB2');
  writeln(Ffile,' 70');
  writeln(Ffile,'     6');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SURFTYPE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     6');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SURFU');
  writeln(Ffile,' 70');
  writeln(Ffile,'     6');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SURFV');
  writeln(Ffile,' 70');
  writeln(Ffile,'     6');
  writeln(Ffile,'  9');
  writeln(Ffile,'$UCSNAME');
  writeln(Ffile,'  2');
  writeln(Ffile,'');
  writeln(Ffile,'  9');
  writeln(Ffile,'$UCSORG');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$UCSXDIR');
  writeln(Ffile,' 10');
  writeln(Ffile,'1.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$UCSYDIR');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'1.0');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PUCSNAME');
  writeln(Ffile,'  2');
  writeln(Ffile,'');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PUCSORG');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PUCSXDIR');
  writeln(Ffile,' 10');
  writeln(Ffile,'1.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PUCSYDIR');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'1.0');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERI1');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERI2');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERI3');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERI4');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERI5');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERR1');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERR2');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERR3');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERR4');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$USERR5');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$WORLDVIEW');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SHADEDGE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     3');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SHADEDIF');
  writeln(Ffile,' 70');
  writeln(Ffile,'    70');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TILEMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$MAXACTVP');
  writeln(Ffile,' 70');
  writeln(Ffile,'    48');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PINSBASE');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 30');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PLIMCHECK');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PEXTMIN');
  writeln(Ffile,' 10');
  writeln(Ffile,'1.000000E+20');
  writeln(Ffile,' 20');
  writeln(Ffile,'1.000000E+20');
  writeln(Ffile,' 30');
  writeln(Ffile,'1.000000E+20');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PEXTMAX');
  writeln(Ffile,' 10');
  writeln(Ffile,'-1.000000E+20');
  writeln(Ffile,' 20');
  writeln(Ffile,'-1.000000E+20');
  writeln(Ffile,' 30');
  writeln(Ffile,'-1.000000E+20');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PLIMMIN');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PLIMMAX');
  writeln(Ffile,' 10');
  writeln(Ffile,'420.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'297.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$UNITMODE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$VISRETAIN');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PLINEGEN');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PSLTSCALE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$TREEDEPTH');
  writeln(Ffile,' 70');
  writeln(Ffile,'  3020');
  writeln(Ffile,'  9');
  writeln(Ffile,'$PICKSTYLE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CMLSTYLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'STANDARD');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CMLJUST');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$CMLSCALE');
  writeln(Ffile,' 40');
  writeln(Ffile,'20.0');
  writeln(Ffile,'  9');
  writeln(Ffile,'$SAVEIMAGES');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  0');
  writeln(Ffile,'ENDSEC');
end;

procedure TAutoCadExport.BuildTables;
begin
  writeln(FFile, '  0');
  writeln(FFile, 'SECTION');
  writeln(FFile, '  2');
  writeln(FFile, 'TABLES');

  BuildViewPortTable;
  BuildLineTypeTable;
  BuildLayerTable;
  BuildStyleTable;
  BuildViewTable;
  BuildUCSTable;
  BuildAPPIDTable;
  BuildDimStyleTable;
  BuildBlockRecordTable;

  writeln(FFile, '  0');
  writeln(FFile, 'ENDSEC');
end;

procedure TAutoCadExport.SaveToFile(const FileName: WideString);
var
  DMDocument:IDMDocument;
  aElement:IDMElement;
  aPainter:IPainter;
  Unk:IUnknown;

  procedure BuildEntities;
  var
    j:integer;
  begin
    for j:=0 to (FSpatialModel as ISpatialModel).ImageRects.Count-1 do begin
      aElement:=(FSpatialModel as ISpatialModel).ImageRects.Item[j];
      if aElement.Selected then
        aElement.Draw(aPainter, 1);
    end;

    (FSpatialModel as IDMElement).Draw(aPainter, 0);

    DMDocument:=(FSpatialModel as IDataModel).Document as IDMDocument;
    for j:=0 to DMDocument.SelectionCount-1 do begin
      aElement:=DMDocument.SelectionItem[j] as IDMElement;
      if aElement.QueryInterface(IImageRect, Unk)<>0 then begin
        if (aElement.Ref<>nil) and
           (aElement.Ref.SpatialElement=aElement) then
          aElement.Ref.Draw(aPainter, 1)
        else
          aElement.Draw(aPainter, 1);
      end;
    end;
  end;

begin
  DecimalSeparator:='.';

  aPainter:=Self as IPainter;

  if FileExists(FileName) then
    DeleteFile(FileName);

  AssignFile(FFile, FileName);

  Rewrite(FFile);

  FWriteFlag:=False;
  FEntityCount:=0;
  FBlockList.Clear;
  BuildEntities;
  FWriteFlag:=True;

  BuildHeader;
  BuildClasses;
  BuildTables;
  BuildBlocks;
  try

//Создание элементов
  writeln(FFile, '  0');
  writeln(FFile, 'SECTION');
  writeln(FFile, '  2');
  writeln(FFile, 'ENTITIES');

  BuildEntities;

  writeln(FFile, '  0');
  writeln(FFile, 'ENDSEC');

  BuildObjects;

  writeln(FFile, '  0');
  writeln(FFile, 'EOF');

  finally
    CloseFile(FFile);
  end;
end;

procedure TAutoCadExport.Set_SpatialModel(const Value: IUnknown);
begin
    FSpatialModel:=Value as ISpatialModel;
end;

function TAutoCadExport.Get_ViewU: IUnknown;
begin
  Result:=FView
end;

procedure TAutoCadExport.Set_ViewU(const Value: IUnknown);
begin
  FView:=Value as IView
end;

function TAutoCadExport.Get_PenColor: Integer;
begin
  Result:=FPenColor
end;

procedure TAutoCadExport.Set_PenColor(Value: Integer);
begin
  FPenColor:=Value
end;

function TAutoCadExport.Get_PenMode: Integer;
begin
  Result:=FPenMode
end;

procedure TAutoCadExport.Set_PenMode(Value: Integer);
begin
  FPenMode:=Value
end;

type
  TPointsArray3=array [0..2,0..1] of double;

procedure TAutoCadExport.DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z, P3X, P3Y, P3Z,
  P4X, P4Y, P4Z, aAngle: Double; PictureHandle: LongWord; PictureFMT, Alpha: Integer);
begin
end;


procedure TAutoCadExport.DrawCurvedLine(VarPointArray: OleVariant);
 procedure OutDrawCurvedLine(VarPointArray: OleVariant);
 var
   j, N:integer;
   XX, YY, ZZ, RX, RY, RZ, X, Y, Z, XT, YT, ZT:double;
   VarPointArrayCount:integer;
   P:TPointF;
   PointArrayF:TPointArrayF;
 begin
   VarPointArrayCount:=VarArrayHighBound(VarPointArray, 1)+1;
   N:=VarPointArrayCount div 3;
   for j:=0 to N-1 do begin
     X:=VarPointArray[3*j];
     Y:=VarPointArray[3*j+1];
     Z:=VarPointArray[3*j+2];
     if FLocalView=nil then begin
       XX:=X;
       YY:=Y;
       ZZ:=Z;
     end else begin
       RX:=1/FLocalView.RevScaleX;
       RY:=1/FLocalView.RevScaleY;
       RZ:=1/FLocalView.RevScaleZ;

       XT:=X*RX*FLocalView.cosT-Z*RZ*FLocalView.sinT;
       YT:=Y*RY;
       ZT:=X*RX*FLocalView.sinT+Z*RZ*FLocalView.cosT;

       XX:=(XT*FLocalView.cosZ-
           YT*FLocalView.sinZ)+FLocalView.CX;
       YY:=(XT*FLocalView.sinZ+
           YT*FLocalView.cosZ)+FLocalView.CY;
       ZZ:=ZT+FLocalView.CZ;
     end;
     P.X:=XX;
     P.Y:=YY;
     P.Z:=ZZ;

     if not CheckVisiblePoint(1, XX,YY,ZZ) then Exit;
     PointArrayF[j]:=P;
   end;
   if FWriteFlag then
     BuildBezier(Slice(PointArrayF, N))
   else  
     inc(FEntityCount)
 end;
begin
  try
    if ((FMode=0) or (FMode=1)) and
       (FWritingBlock<>1) then
      OutDrawCurvedLine(VarPointArray)
  except
    raise
  end;
end;

procedure TAutoCadExport.DrawLine(WX0, WY0, WZ0, WX1, WY1, WZ1: Double);
var
  X0, Y0, Z0, X1, Y1, Z1, RX, RY, RZ:double;

var
  XT, YT, ZT:double;
begin
  try
  if FLocalView=nil then begin
    X0:=WX0;
    Y0:=WY0;
    Z0:=WZ0;
    X1:=WX1;
    Y1:=WY1;
    Z1:=WZ1;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XT:=WX0*RX*FLocalView.cosT-WZ0*RZ*FLocalView.sinT;
    YT:=WY0*RY;
    ZT:=WX0*RX*FLocalView.sinT+WZ0*RZ*FLocalView.cosT;

    X0:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y0:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;

    XT:=WX1*RX*FLocalView.cosT-WZ1*RZ*FLocalView.sinT;
    YT:=WY1*RY;
    ZT:=WX1*RX*FLocalView.sinT+WZ1*RZ*FLocalView.cosT;

    X1:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y1:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z1:=ZT+FLocalView.CZ;
  end;

  if ((FMode=0) or (FMode=1)) and
     (FWritingBlock<>1) and
     CheckVisiblePoint(1, X0,Y0,Z0) and
     CheckVisiblePoint(1, X1,Y1,Z1) then begin
    if FWriteFlag then
      BuildLine(X0, Y0, Z0, X1, Y1, Z1)
    else
      inc(FEntityCount)
  end;
  except
    raise
  end;
end;

procedure TAutoCadExport.DrawPoint(WX, WY, WZ: Double);
var
 X0, Y0, Z0, RX, RY, RZ, R:double;

 procedure OutDrawPoint;
 begin
 {
  writeln(FFile, '  0');
  writeln(FFile, 'CIRCLE');
  
  writeln(FFile, '  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(FFile, '100');
  writeln(FFile, 'AcDbEntity');

  writeln(FFile, '  8');
  writeln(FFile, FLayers[FLayerIndex]);

  writeln(FFile, '100');
  writeln(FFile, 'AcDbCircle');

  writeln(FFile, ' 10');
  writeln(FFile, FloatToStr(X0));
  writeln(FFile, ' 20');
  writeln(FFile, FloatToStr(Y0));
  writeln(FFile, ' 30');
  writeln(FFile, FloatToStr(Z0));
  writeln(FFile, ' 40');
  writeln(FFile, FloatToStr(R));
}  
 end;

var
  XT, YT, ZT:double;
begin
  R:=10;
  if FLocalView=nil then begin
    X0:=WX;
    Y0:=WY;
    Z0:=WZ;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;
    XT:=WX*RX*FLocalView.cosT-WZ*RZ*FLocalView.sinT;
    YT:=WY*RY;
    ZT:=WX*RX*FLocalView.sinT+WZ*RZ*FLocalView.cosT;
    X0:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y0:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;
    R:=R*RX;
  end;
 if ((FMode=0) or (FMode=1)) and
    (FWritingBlock<>1) and
    CheckVisiblePoint(1, X0,Y0,Z0) then begin
    if FWriteFlag then
      OutDrawPoint
    else
      inc(FEntityCount)
  end;
end;

procedure TAutoCadExport.DrawPolygon(const Lines: IDMCollection;
  Vertical: WordBool);
var
  j, CanvasTag:integer;
  C:ICoordNode;
  Points:array of TPointF;
  Line, NLine:ILine;
  Q, MinX, MaxX, MinY, MaxY, X, Y, Z, RX, RY, RZ,
  XT, YT, ZT:double;
begin
  if not Vertical then begin
    CanvasTag:=1;
  end else begin
    CanvasTag:=2;
  end;
  SetLength(Points, Lines.Count);
  C:=nil;
  MinX:=InfinitValue;
  MinY:=InfinitValue;
  MaxX:=-InfinitValue;
  MaxY:=-InfinitValue;
  if FLocalView<>nil then begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;
  end else begin
    RX:=1;
    RY:=1;
    RZ:=1;
  end;
  for j:=0 to Lines.Count-1 do begin
    Line:=Lines.Item[j] as ILine;
    if j>0 then begin
      if C=Line.C0 then
        C:=Line.C1
      else
        C:=Line.C0;
    end else begin
      NLine:=Lines.Item[1] as ILine;
      if (Line.C0=NLine.C0) or
         (Line.C0=NLine.C1) then
        C:=Line.C0
      else
        C:=Line.C1
    end;
    if FLocalView=nil then begin
      X:=C.X;
      Y:=C.Y;
      Z:=C.Z;
    end else begin
      XT:=C.X*RX*FLocalView.cosT-C.Z*RZ*FLocalView.sinT;
      YT:=C.Y*RY;
      ZT:=C.X*RX*FLocalView.sinT+C.Z*RZ*FLocalView.cosT;
      X:=(XT*FLocalView.cosZ-
          YT*FLocalView.sinZ)+FLocalView.CX;
      Y:=(XT*FLocalView.sinZ+
          YT*FLocalView.cosZ)+FLocalView.CY;
      Z:=ZT+FLocalView.CZ;
    end;
    if not CheckVisiblePoint(1, X,Y,Z) then Exit;
    Q:=FPageX/2+
               FK*((X-FView.CX)*FView.CosZ-
                (Y-FView.CY)*FView.SinZ)/FView.RevScaleX;
    Points[j].X:=Q;
    case CanvasTag of
    1:begin
        Q:=FPageY/2+
               FK*((X-FView.CX)*FView.SinZ+
                (Y-FView.CY)*FView.CosZ)/FView.RevScaleY;
        Points[j].Y:=Q;
      end
    else
      begin
        Q:=FPageY/2+
              FK*(Z-FView.CZ)/FView.RevScaleY;
        Points[j].Y:=Q;
      end;
    end;
    if MinX>Points[j].X then
      MinX:=Points[j].X;
    if MinY>Points[j].Y then
      MinY:=Points[j].Y;
    if MaxX<Points[j].X then
      MaxX:=Points[j].X;
    if MaxY<Points[j].Y then
      MaxY:=Points[j].Y;
  end;
  if (MaxX-MinX)>62800 then Exit;
  if (MaxY-MinY)>62800 then Exit;
//  Polygon(Points); ???????????????????????
end;

function TAutoCadExport.Get_PenStyle: Integer;
begin
  Result:=FPenStyle
end;

procedure TAutoCadExport.Set_PenStyle(Value: Integer);
begin
  FPenStyle:=Value
end;

function TAutoCadExport.Get_PenWidth: Double;
begin
  Result:=FPenWidth
end;

procedure TAutoCadExport.Set_PenWidth(Value: Double);
begin
  FPenWidth:=round(Value)
end;

function TAutoCadExport.Get_BrushColor: Integer;
begin
  Result:=FBrushColor
end;

procedure TAutoCadExport.Set_BrushColor(Value: Integer);
begin
  FBrushColor:=Value
end;

function TAutoCadExport.Get_BrushStyle: Integer;
begin
  Result:=FBrushStyle
end;

procedure TAutoCadExport.Set_BrushStyle(Value: Integer);
begin
  FBrushStyle:=Value
end;

function TAutoCadExport.CheckVisiblePoint(aCanvasTag: Integer; X, Y, Z: Double): WordBool;
begin
  with FView do
   if FLocalView=nil then
     Result:=(Z>=Zmin)and(Z<=Zmax)
   else
     Result:=(FLocalView.CZ>=Zmin)and(FLocalView.CZ<=Zmax);
end;

procedure TAutoCadExport.DrawAxes(XP, YP, ZP:integer);
begin
end;

procedure TAutoCadExport.SetRangePix;
begin
end;

procedure TAutoCadExport.DrawRangeMarks;
begin
end;

function TAutoCadExport.Get_DmaxPix: Integer;
begin
  Result:=0
end;

function TAutoCadExport.Get_DminPix: Integer;
begin
  Result:=0
end;

function TAutoCadExport.Get_ZmaxPix: Integer;
begin
  Result:=0
end;

function TAutoCadExport.Get_ZminPix: Integer;
begin
  Result:=0
end;

procedure TAutoCadExport.Set_DmaxPix(Value: Integer);
begin
end;

procedure TAutoCadExport.Set_DminPix(Value: Integer);
begin
end;

procedure TAutoCadExport.Set_ZmaxPix(Value: Integer);
begin
end;

procedure TAutoCadExport.Set_ZminPix(Value: Integer);
begin
end;

function TAutoCadExport.Get_HCanvasHandle: Integer;
begin
  Result:=0
end;

function TAutoCadExport.Get_VCanvasHandle: Integer;
begin
  Result:=0
end;

procedure TAutoCadExport.Set_HCanvasHandle(Value: Integer);
begin
end;

procedure TAutoCadExport.Set_VCanvasHandle(Value: Integer);
begin
end;

procedure TAutoCadExport.Initialize;
begin
  inherited;
  FPenMode:=ord(pmCopy);
  FPenStyle:=ord(psSolid);
  FLayers:=TStringList.Create;
  FBlockList:=TList.Create;
  FCurrentHandle:=1;
end;

procedure TAutoCadExport.DragLine(PX0, PY0, PZ0, PX1, PY1, PZ1: Integer);
begin
end;

procedure TAutoCadExport.DragRect(PX0, PY0, PZ0, PX1, PY1, PZ1: Integer);
begin
end;

procedure TAutoCadExport.WP_To_P(WX, WY, WZ:double;
                       out PX, PY, PZ:integer);
begin
end;


procedure TAutoCadExport.P_To_WP(PX, PY, Tag: Integer; out WX, WY, WZ: Double);
begin
end;

procedure TAutoCadExport.DragCurvedLine(VarPointArray: OleVariant);
begin
end;

procedure TAutoCadExport.DrawRectangle(WX0, WY0, WZ0, WX1, WY1, WZ1,
  Angle: Double);
begin
end;

function TAutoCadExport.Get_LocalViewU: IUnknown;
begin
  Result:=FLocalView
end;

procedure TAutoCadExport.Set_LocalViewU(const Value: IUnknown);
begin
  FLocalView:=Value as IView
end;

procedure TAutoCadExport.BuildText(x0, y0, z0, TextSize:double; const Text:string);
begin
  writeln(FFile, '  0');
  writeln(FFile, 'MTEXT');

  writeln(FFile, '  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbEntity');

  writeln(FFile, '  8');
  writeln(FFile, FLayers[FLayerIndex]);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbMText');

  writeln(FFile, ' 10');
  writeln(FFile, FloatToStr(x0));
  writeln(FFile, ' 20');
  writeln(FFile, FloatToStr(y0-TextSize));
  writeln(FFile, ' 30');
  writeln(FFile, FloatToStr(z0));
  writeln(FFile, ' 40');
  writeln(FFile, FloatToStr(TextSize));
  writeln(FFile, '  1');
  writeln(FFile, Text);
end;

procedure TAutoCadExport.DrawText(WX, WY, WZ: Double; const Text: WideString;
  TextSize: Double; const FontName: WideString; FontSize, FontColor,
  FontStyle, ScaleMode: Integer);
var
 X0, Y0, Z0, RX, RY, RZ:double;
 XT, YT, ZT, aFontSize:double;
begin
  try
  if FLocalView=nil then begin
    X0:=WX;
    Y0:=WY;
    Z0:=WZ;
  end else begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;
    XT:=WX*RX*FLocalView.cosT-WZ*RZ*FLocalView.sinT;
    YT:=WY*RY;
    ZT:=WX*RX*FLocalView.sinT+WZ*RZ*FLocalView.cosT;
    X0:=(XT*FLocalView.cosZ-
         YT*FLocalView.sinZ)+FLocalView.CX;
    Y0:=(XT*FLocalView.sinZ+
         YT*FLocalView.cosZ)+FLocalView.CY;
    Z0:=ZT+FLocalView.CZ;
  end;

  aFontSize:=8*FView.RevScaleX;

  if ((FMode=0) or (FMode=1)) and
     (FWritingBlock<>1) and
     CheckVisiblePoint(1,X0,Y0,Z0) then begin
    if FWriteFlag then
      BuildText(X0,Y0,Z0, aFontSize, Text)
    else
      inc(FEntityCount)
  end;
  except
    raise
  end;
end;

procedure TAutoCadExport.BuildBezier(const PointArray: array of TPointF);
  procedure   BuildControlPoint(X, Y, Z:double);
  begin
    writeln(FFile, ' 10');
    writeln(FFile, FloatToStr(X));
    writeln(FFile, ' 20');
    writeln(FFile, FloatToStr(Y));
    writeln(FFile, ' 30');
    writeln(FFile, FloatToStr(Z));
  end;
var
  N, j:integer;
begin
  N:=4;
  writeln(FFile, '  0');
  writeln(FFile, 'SPLINE');

  writeln(FFile, '  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(FFile, '100');
  writeln(FFile, 'AcDbEntity');

  writeln(FFile, '  8');
  writeln(FFile, FLayers[FLayerIndex]);

  writeln(FFile, '100');
  writeln(FFile, 'AcDbSpline');

  writeln(FFile, ' 70');
  writeln(FFile, '     8'); // plane spline
  writeln(FFile, ' 71');
  writeln(FFile, Format('%6d',[N-1]));
  writeln(FFile, ' 72');
  writeln(FFile, '     8');     // N*2 ?
  writeln(FFile, ' 73');
  writeln(FFile, Format('%6d',[N]));
  writeln(FFile, ' 74');
  writeln(FFile, '     0');
  writeln(FFile, ' 42');
  writeln(FFile, '0.0000000001');
  writeln(FFile, ' 43');
  writeln(FFile, '0.0000000001');

  for j:=1 to 4 do begin
    writeln(FFile, ' 40');
    writeln(FFile, '0.0');
  end;
  for j:=1 to 4 do begin
    writeln(FFile, ' 40');
    writeln(FFile, '25.60057497095522');
  end;

  for j:=0 to 3 do
    BuildControlPoint(PointArray[j].X, PointArray[j].Y, PointArray[j].Z)
   
end;

function TAutoCadExport.Get_LayerIndex: Integer;
begin
  Result:=FLayerIndex
end;

procedure TAutoCadExport.Set_LayerIndex(Value: Integer);
begin
  FLayerIndex:=Value
end;

function TAutoCadExport.Get_UseLayers: WordBool;
begin
  Result:=True
end;

procedure TAutoCadExport.DrawArc(WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2,
  WZ2: Double);
 {WX0,WY0,WZ0 -центр окружн., WX1,WY1,WZ1 -центральн.точка дуги на окружн.,
  WX0, WY0, WZ0 - WX2, WY2, WZ2 -направл.на котором лежит 1-я точка дуги,
  2-я точка дуги вычисл.симетрично относит.центр.}
var
 xC,yC,zC:Double;
 R,R1,dX1,dY1,NewX2,NewY2,cos,sin, A0, A1, cos0, cos1, sin0, sin1:double;
 NewX3,NewY3, x0, y0, z0, x1,y1,z1,x2,y2,z2,x3,y3,z3:double;
 XT, YT, ZT:double;
 RX, RY, RZ:double;
//___________
   procedure OutDrawArc;
   begin
     writeln(FFile, '  0');
     writeln(FFile, 'ARC');

     writeln(FFile, '  5');
     writeln(FFile, IntToHex(FCurrentHandle, 1));
     inc(FCurrentHandle);
     
     writeln(FFile, '100');
     writeln(FFile, 'AcDbEntity');

     writeln(FFile, '  8');
     writeln(FFile, FLayers[FLayerIndex]);

     writeln(FFile, '100');
     writeln(FFile, 'AcDbCircle');

     writeln(FFile, ' 10');
     writeln(FFile, FloatToStr(x0));
     writeln(FFile, ' 20');
     writeln(FFile, FloatToStr(y0));
     writeln(FFile, ' 30');
     writeln(FFile, FloatToStr(z0));
     writeln(FFile, ' 40');
     writeln(FFile, FloatToStr(R));

     writeln(FFile, '100');
     writeln(FFile, 'AcDbArc');

     writeln(FFile, ' 50');
     writeln(FFile, FloatToStr(A0));
     writeln(FFile, ' 51');
     writeln(FFile, FloatToStr(A1));

   end;
begin
  dX1:=WX1-WX0;
  dY1:=WY1-WY0;
  R:=sqrt(sqr(dX1) + sqr(dY1));

  x0:=WX0;
  y0:=WY0;
  z0:=WZ0;

  x1:=WX1;   //вершина дуги
  y1:=WY1;
  z1:=WZ1;

  R1:=sqrt(sqr(WX2-WX0) + sqr(WY2-WY0));
  x2:=WX0+(WX2-WX0)/R1*R;   //1 точка дуги
  y2:=WY0+(WY2-WY0)/R1*R;
  z2:=WZ0+(WZ2-WZ0)/R1*R;

 {опред.2-ю точку дуги в нов.коорд.}
  if R=0 then Exit;
  cos:=dX1/R;
  sin:=dY1/R;
  NewX2:=(WX2-WX0)*cos + (WY2-WY0)*sin;
  NewY2:=-(WX2-WX0)*sin + (WY2-WY0)*cos;
  NewX3:=NewX2;
  NewY3:=-NewY2;
 {преобраз.в cтар.коорд. 2-ю точку дуги}
  x3:=WX0 + NewX3*cos - NewY3*sin;   //
  y3:=WY0 + NewX3*sin + NewY3*cos;
  Z3:=WZ2;

  if FLocalView<>nil then begin
    RX:=1/FLocalView.RevScaleX;
    RY:=1/FLocalView.RevScaleY;
    RZ:=1/FLocalView.RevScaleZ;

    XT:=x0*RX*FLocalView.cosT-z0*RZ*FLocalView.sinT;
    YT:=y0*RY;
    ZT:=x0*RX*FLocalView.sinT+z0*RZ*FLocalView.cosT;

    x0:=(XT*FLocalView.cosZ-YT*FLocalView.sinZ)+FLocalView.CX;
    y0:=(XT*FLocalView.sinZ+YT*FLocalView.cosZ)+FLocalView.CY;
    z0:=ZT+FLocalView.CZ;

    XT:=x1*RX*FLocalView.cosT-z1*RZ*FLocalView.sinT;
    YT:=y1*RY;

    x1:=(XT*FLocalView.cosZ-YT*FLocalView.sinZ)+FLocalView.CX;
    y1:=(XT*FLocalView.sinZ+YT*FLocalView.cosZ)+FLocalView.CY;

    XT:=x2*RX*FLocalView.cosT-z2*RZ*FLocalView.sinT;
    YT:=y2*RY;
    ZT:=x2*RX*FLocalView.sinT+z2*RZ*FLocalView.cosT;

    x2:=(XT*FLocalView.cosZ-YT*FLocalView.sinZ)+FLocalView.CX;
    y2:=(XT*FLocalView.sinZ+YT*FLocalView.cosZ)+FLocalView.CY;
    z2:=ZT+FLocalView.CZ;

    XT:=x3*RX*FLocalView.cosT-z3*RZ*FLocalView.sinT;
    YT:=y3*RY;
    ZT:=x3*RX*FLocalView.sinT+z3*RZ*FLocalView.cosT;

    x3:=(XT*FLocalView.cosZ-YT*FLocalView.sinZ)+FLocalView.CX;
    y3:=(XT*FLocalView.sinZ+YT*FLocalView.cosZ)+FLocalView.CY;
    z3:=ZT+FLocalView.CZ;

    R:=sqrt(sqr(x1-x0)+sqr(y1-y0));
  end;

  cos0:=(x2-x0)/R;
  sin0:=(y2-x0)/R;
  A0:=arccos(cos0)/pi*180;
  if sin0<0 then
    A0:=360-A0;

  cos1:=(x3-WX0)/R;
  sin1:=(y3-WX0)/R;
  A1:=arccos(cos1)/pi*180;
  if sin1<0 then
    A1:=360-A1;

  XC:=FView.CX;
  YC:=FView.CY;
  ZC:=FView.CZ;

  try
  if ((FMode=0) or (FMode=1)) and
     (FWritingBlock<>1) and
    CheckVisiblePoint(1, X2,Y2,Z2) and
    CheckVisiblePoint(1, X3,Y3,Z3) then begin
    if FWriteFlag then
      OutDrawArc
    else
      inc(FEntityCount)
  end;
  except
    raise
  end
end;

procedure TAutoCadExport.SetLimits;
begin
end;

function TAutoCadExport.LineIsVisible(aCanvasTag: integer;
  var X0, Y0, Z0, X1, Y1, Z1: double; FitToCanvas:WordBool;
  CanvasLevel: integer): WordBool;
begin
  Result:=True
end;

procedure TAutoCadExport.DrawCircle(WX, WY, WZ, R: Double;
  R_In_Pixels: WordBool);
begin

end;

function TAutoCadExport.Get_HHeight: Integer;
begin
  Result:=0
end;

function TAutoCadExport.Get_HWidth: Integer;
begin
  Result:=0
end;

function TAutoCadExport.Get_VHeight: Integer;
begin
  Result:=0
end;

function TAutoCadExport.Get_VWidth: Integer;
begin
  Result:=0
end;

procedure TAutoCadExport.Set_HHeight(Value: Integer);
begin

end;

procedure TAutoCadExport.Set_HWidth(Value: Integer);
begin

end;

procedure TAutoCadExport.Set_VHeight(Value: Integer);
begin

end;

procedure TAutoCadExport.Set_VWidth(Value: Integer);
begin

end;

function TAutoCadExport.Get_Mode: Integer;
begin
  Result:=FMode
end;

procedure TAutoCadExport.Set_Mode(Value: Integer);
begin
  FMode:=Value
end;

procedure TAutoCadExport.BuildAPPIDTable;
begin
  writeln(Ffile,'  0');
  writeln(Ffile,'TABLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'APPID');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTable');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  0');
  writeln(Ffile,'APPID');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTableRecord');
  writeln(Ffile,'100');
  writeln(Ffile,'AcDbRegAppTableRecord');
  writeln(Ffile,'  2');
  writeln(Ffile,'ACAD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  0');
  writeln(Ffile,'ENDTAB');
end;

procedure TAutoCadExport.BuildClasses;
begin
  writeln(Ffile,'  0');
  writeln(Ffile,'SECTION');
  writeln(Ffile,'  2');
  writeln(Ffile,'CLASSES');
  writeln(Ffile,'  0');
  writeln(Ffile,'ENDSEC');
end;

procedure TAutoCadExport.BuildViewTable;
  procedure BuildView(const ViewE:IDMElement);
  var
    View:IView;
    S:string;
    X, Y, Z, Zmin, Zmax, H, NX, NY, NZ,
    cosT, NR, DZ:double;
    ViewMode:integer;
  begin
    View:=ViewE as IView;
    S:=ViewE.Name;
    CorrectName(S);

    ViewMode:=22;   // 2+4+16
    X:=View.CX;
    Y:=View.CY;
    Z:=View.CurrZ0;
    H:=600*View.RevScale;

    if View.SinZ=0 then begin
      NX:=0;
      NY:=0;
    end else begin
      if View.SinZ>0 then
        NX:=-1.e-10
      else
        NX:=+1.e-8;
      NY:=NX*View.CosZ/FView.SinZ
    end;
    NZ:=1;
    NR:=sqrt(sqr(NX)+sqr(NY)+sqr(NZ));
    cosT:=NZ/NR;
    DZ:=2*H*sqrt(1-sqr(cosT));

    Zmin:=View.Zmin-Z-DZ;
    Zmax:=View.Zmax-Z;

    writeln(Ffile,'  0');
    writeln(Ffile,'VIEW');

    writeln(Ffile,'  5');
    writeln(FFile, IntToHex(FCurrentHandle, 1));
    inc(FCurrentHandle);

    writeln(Ffile,'100');
    writeln(Ffile,'AcDbSymbolTableRecord');
    writeln(Ffile,'100');
    writeln(Ffile,'AcDbViewTableRecord');
    writeln(Ffile,'  2');
    writeln(Ffile, S);
    writeln(Ffile,' 70');
    writeln(Ffile,'     0');
    writeln(Ffile,' 40');
    writeln(Ffile, FloatToStr(H));
    writeln(Ffile,' 10');
    writeln(Ffile, FloatToStr(X));
    writeln(Ffile,' 20');
    writeln(Ffile, FloatToStr(Y));
    writeln(Ffile,' 41');
    writeln(Ffile, FloatToStr(H*2));
    writeln(Ffile,' 11');
    writeln(Ffile, FloatToStr(NX));
    writeln(Ffile,' 21');
    writeln(Ffile, FloatToStr(NY));
    writeln(Ffile,' 31');
    writeln(Ffile, FloatToStr(NZ));
    writeln(Ffile,' 12');
    writeln(Ffile, FloatToStr(X));
    writeln(Ffile,' 22');
    writeln(Ffile, FloatToStr(Y));
    writeln(Ffile,' 32');
    writeln(Ffile, FloatToStr(Z));
    writeln(Ffile,' 42');
    writeln(Ffile,'50.0');
    writeln(Ffile,' 43');
    writeln(Ffile, FloatToStr(Zmax));
    writeln(Ffile,' 44');
    writeln(Ffile, FloatToStr(Zmin));
    writeln(Ffile,' 50');
    writeln(Ffile,'0.0');
    writeln(Ffile,' 71');
    writeln(Ffile, IntToStr(ViewMode));
  end;
var
  j:integer;
  SpatialModel2:ISpatialModel2;
  ViewE:IDMElement;
begin
  SpatialModel2:=FSpatialModel as ISpatialModel2;

  writeln(Ffile,'  0');
  writeln(Ffile,'TABLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'VIEW');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTable');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');

  for j:=0 to SpatialModel2.Views.Count-1 do begin
    ViewE:=SpatialModel2.Views.Item[j];
    BuildView(ViewE);
  end;

  writeln(Ffile,'  0');
  writeln(Ffile,'ENDTAB');
end;

procedure TAutoCadExport.BuildViewPortTable;
var
  X, Y, Z, Zmin, Zmax, H, NX, NY, NZ,
  cosT, NR, DZ:double;
  ViewMode:integer;
begin
  ViewMode:=22;   // 2+4+16
  X:=FView.CX;
  Y:=FView.CY;
  Z:=FView.CurrZ0;
  H:=600*FView.RevScale;

  if FView.SinZ=0 then begin
    NX:=0;
    NY:=0;
  end else begin
   if FView.SinZ>0 then
      NX:=-1.e-10
    else
      NX:=+1.e-8;
    NY:=NX*FView.CosZ/FView.SinZ
  end;
  NZ:=1;
  NR:=sqrt(sqr(NX)+sqr(NY)+sqr(NZ));
  cosT:=NZ/NR;
  DZ:=2*H*sqrt(1-sqr(cosT));

  Zmin:=FView.Zmin-Z-DZ;
  Zmax:=FView.Zmax-Z;

  writeln(Ffile,'  0');
  writeln(Ffile,'TABLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'VPORT');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTable');
  writeln(Ffile,' 70');
  writeln(Ffile,'     2');
  writeln(Ffile,'  0');
  writeln(Ffile,'VPORT');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTableRecord');
  writeln(Ffile,'100');
  writeln(Ffile,'AcDbViewportTableRecord');
  writeln(Ffile,'  2');
  writeln(Ffile,'*ACTIVE');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,' 10');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 20');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 11');
  writeln(Ffile,'1.0');
  writeln(Ffile,' 21');
  writeln(Ffile,'1.0');
  writeln(Ffile,' 12');
  writeln(Ffile, FloatToStr(X));
  writeln(Ffile,' 22');
  writeln(Ffile, FloatToStr(Y));
  writeln(Ffile,' 13');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 23');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 14');
  writeln(Ffile,'10.0');
  writeln(Ffile,' 24');
  writeln(Ffile,'10.0');
  writeln(Ffile,' 15');
  writeln(Ffile,'10.0');
  writeln(Ffile,' 25');
  writeln(Ffile,'10.0');
  writeln(Ffile,' 16');
  writeln(Ffile, FloatToStr(NX));
  writeln(Ffile,' 26');
  writeln(Ffile, FloatToStr(NY));
  writeln(Ffile,' 36');
  writeln(Ffile, FloatToStr(NZ));
  writeln(Ffile,' 17');
  writeln(Ffile, FloatToStr(X));
  writeln(Ffile,' 27');
  writeln(Ffile, FloatToStr(Y));
  writeln(Ffile,' 37');
  writeln(Ffile, FloatToStr(Z));
  writeln(Ffile,' 40');
  writeln(Ffile, FloatToStr(H));
  writeln(Ffile,' 41');
  writeln(Ffile,'1.898072');
  writeln(Ffile,' 42');
  writeln(Ffile,'50.0');
  writeln(Ffile,' 43');
  writeln(Ffile, FloatToStr(Zmax));
  writeln(Ffile,' 44');
  writeln(Ffile, FloatToStr(Zmin));
  writeln(Ffile,' 50');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 51');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 71');
  writeln(Ffile, IntToStr(ViewMode));
  writeln(Ffile,' 72');
  writeln(Ffile,'   100');
  writeln(Ffile,' 73');
  writeln(Ffile,'     1');
  writeln(Ffile,' 74');
  writeln(Ffile,'     1');
  writeln(Ffile,' 75');
  writeln(Ffile,'     0');
  writeln(Ffile,' 76');
  writeln(Ffile,'     0');
  writeln(Ffile,' 77');
  writeln(Ffile,'     0');
  writeln(Ffile,' 78');
  writeln(Ffile,'     0');
  writeln(Ffile,'  0');
  writeln(Ffile,'ENDTAB');
end;

procedure TAutoCadExport.BuildStyleTable;
begin
  writeln(Ffile,'  0');
  writeln(Ffile,'TABLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'STYLE');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTable');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');
  writeln(Ffile,'  0');
  writeln(Ffile,'STYLE');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTableRecord');
  writeln(Ffile,'100');
  writeln(Ffile,'AcDbTextStyleTableRecord');
  writeln(Ffile,'  2');
  writeln(Ffile,'STANDARD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,' 40');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 41');
  writeln(Ffile,'1.0');
  writeln(Ffile,' 50');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 71');
  writeln(Ffile,'     0');
  writeln(Ffile,' 42');
  writeln(Ffile,'2.5');
  writeln(Ffile,'  3');
  writeln(Ffile,'txt');
  writeln(Ffile,'  4');
  writeln(Ffile,'');
  writeln(Ffile,'  0');
  writeln(Ffile,'ENDTAB');
end;

procedure TAutoCadExport.BuildUCSTable;
begin
  writeln(Ffile,'  0');
  writeln(Ffile,'TABLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'UCS');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTable');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  0');
  writeln(Ffile,'ENDTAB');
end;

procedure TAutoCadExport.BuildBlockRecordTable;
  procedure BuildBlockRecord(const BlockName:string);
  begin
    writeln(Ffile,'  0');
    writeln(Ffile,'BLOCK_RECORD');

    writeln(Ffile,'  5');
    writeln(FFile, IntToHex(FCurrentHandle, 1));
    inc(FCurrentHandle);

    writeln(Ffile,'100');
    writeln(Ffile,'AcDbSymbolTableRecord');
    writeln(Ffile,'100');
    writeln(Ffile,'AcDbBlockTableRecord');
    writeln(Ffile,'  2');
    writeln(Ffile, BlockName);
  end;
var
  j:integer;
  Element:IDMElement;
  S:string;
begin
  writeln(Ffile,'  0');
  writeln(Ffile,'TABLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'BLOCK_RECORD');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTable');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');

  BuildBlockRecord('*MODEL_SPACE');
  BuildBlockRecord('*PAPER_SPACE');

  for j:=0 to FBlockList.Count-1 do begin
    Element:=IDMElement(FBlockList[j]);
    S:=Element.Name;
    CorrectName(S);
    BuildBlockRecord(S);
  end;

  writeln(Ffile,'  0');
  writeln(Ffile,'ENDTAB');
end;

procedure TAutoCadExport.BuildDimStyleTable;
begin
  writeln(Ffile,'  0');
  writeln(Ffile,'TABLE');
  writeln(Ffile,'  2');
  writeln(Ffile,'DIMSTYLE');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTable');
  writeln(Ffile,' 70');
  writeln(Ffile,'     1');

  writeln(Ffile,'  0');
  writeln(Ffile,'DIMSTYLE');

  writeln(Ffile,'105');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbSymbolTableRecord');
  writeln(Ffile,'100');
  writeln(Ffile,'AcDbDimStyleTableRecord');
  writeln(Ffile,'  2');
  writeln(Ffile,'STANDARD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  3');
  writeln(Ffile,'');
  writeln(Ffile,'  4');
  writeln(Ffile,'');
  writeln(Ffile,'  5');
  writeln(Ffile,'');
  writeln(Ffile,'  6');
  writeln(Ffile,'');
  writeln(Ffile,'  7');
  writeln(Ffile,'');
  writeln(Ffile,' 40');
  writeln(Ffile,'1.0');
  writeln(Ffile,' 41');
  writeln(Ffile,'0.18');
  writeln(Ffile,' 42');
  writeln(Ffile,'0.0625');
  writeln(Ffile,' 43');
  writeln(Ffile,'0.38');
  writeln(Ffile,' 44');
  writeln(Ffile,'0.18');
  writeln(Ffile,' 45');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 46');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 47');
  writeln(Ffile,'0.0');
  writeln(Ffile,' 48');
  writeln(Ffile,'0.0');
  writeln(Ffile,'140');
  writeln(Ffile,'0.18');
  writeln(Ffile,'141');
  writeln(Ffile,'0.09');
  writeln(Ffile,'142');
  writeln(Ffile,'0.0');
  writeln(Ffile,'143');
  writeln(Ffile,'25.4');
  writeln(Ffile,'144');
  writeln(Ffile,'1.0');
  writeln(Ffile,'145');
  writeln(Ffile,'0.0');
  writeln(Ffile,'146');
  writeln(Ffile,'1.0');
  writeln(Ffile,'147');
  writeln(Ffile,'0.09');
  writeln(Ffile,' 71');
  writeln(Ffile,'     0');
  writeln(Ffile,' 72');
  writeln(Ffile,'     0');
  writeln(Ffile,' 73');
  writeln(Ffile,'     1');
  writeln(Ffile,' 74');
  writeln(Ffile,'     1');
  writeln(Ffile,' 75');
  writeln(Ffile,'     0');
  writeln(Ffile,' 76');
  writeln(Ffile,'     0');
  writeln(Ffile,' 77');
  writeln(Ffile,'     0');
  writeln(Ffile,' 78');
  writeln(Ffile,'     0');
  writeln(Ffile,'170');
  writeln(Ffile,'     0');
  writeln(Ffile,'171');
  writeln(Ffile,'     2');
  writeln(Ffile,'172');
  writeln(Ffile,'     0');
  writeln(Ffile,'173');
  writeln(Ffile,'     0');
  writeln(Ffile,'174');
  writeln(Ffile,'     0');
  writeln(Ffile,'175');
  writeln(Ffile,'     0');
  writeln(Ffile,'176');
  writeln(Ffile,'     0');
  writeln(Ffile,'177');
  writeln(Ffile,'     0');
  writeln(Ffile,'178');
  writeln(Ffile,'     0');
  writeln(Ffile,'270');
  writeln(Ffile,'     2');
  writeln(Ffile,'271');
  writeln(Ffile,'     4');
  writeln(Ffile,'272');
  writeln(Ffile,'     4');
  writeln(Ffile,'273');
  writeln(Ffile,'     2');
  writeln(Ffile,'274');
  writeln(Ffile,'     2');
  writeln(Ffile,'340');
  writeln(Ffile,'F');
  writeln(Ffile,'275');
  writeln(Ffile,'     0');
  writeln(Ffile,'280');
  writeln(Ffile,'     0');
  writeln(Ffile,'281');
  writeln(Ffile,'     0');
  writeln(Ffile,'282');
  writeln(Ffile,'     0');
  writeln(Ffile,'283');
  writeln(Ffile,'     1');
  writeln(Ffile,'284');
  writeln(Ffile,'     0');
  writeln(Ffile,'285');
  writeln(Ffile,'     0');
  writeln(Ffile,'286');
  writeln(Ffile,'     0');
  writeln(Ffile,'287');
  writeln(Ffile,'     3');
  writeln(Ffile,'288');
  writeln(Ffile,'     0');
  writeln(Ffile,'  0');
  writeln(Ffile,'ENDTAB');
end;

procedure TAutoCadExport.BuildBlocks;

  procedure BuildBlock(const BlockName:string;
                        const Element:IDMElement;
                        PaperSpaceFlag:boolean);
  begin
    writeln(Ffile,'  0');
    writeln(Ffile,'BLOCK');

    writeln(Ffile,'  5');
    writeln(FFile, IntToHex(FCurrentHandle, 1));
    inc(FCurrentHandle);

    writeln(Ffile,'100');
    writeln(Ffile,'AcDbEntity');
    if PaperSpaceFlag then begin
      writeln(Ffile,' 67');
      writeln(Ffile,'     1');
    end;
    writeln(Ffile,'  8');
    writeln(Ffile,'0');
    writeln(Ffile,'100');
    writeln(Ffile,'AcDbBlockBegin');
    writeln(Ffile,'  2');
    writeln(Ffile, BlockName);
    writeln(Ffile,' 70');
    writeln(Ffile,'     0');
    writeln(Ffile,' 10');
    writeln(Ffile,'0.0');
    writeln(Ffile,' 20');
    writeln(Ffile,'0.0');
    writeln(Ffile,' 30');
    writeln(Ffile,'0.0');
    writeln(Ffile,'  3');
    writeln(Ffile, BlockName);
    writeln(Ffile,'  1');
    writeln(Ffile,'');

    if Element<>nil then begin
      Element.Draw(Self as IPainter, 0);
    end;

    writeln(Ffile,'  0');
    writeln(Ffile,'ENDBLK');

    writeln(Ffile,'  5');
    writeln(FFile, IntToHex(FCurrentHandle, 1));
    inc(FCurrentHandle);

    writeln(Ffile,'100');
    writeln(Ffile,'AcDbEntity');
    if PaperSpaceFlag then begin
      writeln(Ffile,' 67');
      writeln(Ffile,'     1');
    end;
    writeln(Ffile,'  8');
    writeln(Ffile,'0');
    writeln(Ffile,'100');
    writeln(Ffile,'AcDbBlockEnd');
  end;

var
  j:integer;
  Element:IDMElement;
  S:string;
begin
  writeln(Ffile,'  0');
  writeln(Ffile,'SECTION');
  writeln(Ffile,'  2');
  writeln(Ffile,'BLOCKS');

  BuildBlock('*MODEL_SPACE', nil, False);
  BuildBlock('*PAPER_SPACE', nil, True);

  FMode:=1;
  FWritingBlock:=2; // запрет вызова InsertBlock и CloseBlock
                    // при разрешенном рисовании объектов
  for j:=0 to FBlockList.Count-1 do begin
    Element:=IDMElement(FBlockList[j]);
    S:=Element.Name;
    CorrectName(S);
    FLayerIndex:=FLayerCount+j;
    BuildBlock(S, Element, False);
  end;
  FWritingBlock:=0;

  writeln(Ffile,'  0');
  writeln(Ffile,'ENDSEC');
end;

procedure TAutoCadExport.BuildObjects;
var
  N:integer;
begin
  N:=FCurrentHandle;
  
  writeln(Ffile,'  0');
  writeln(Ffile,'SECTION');
  writeln(Ffile,'  2');
  writeln(Ffile,'OBJECTS');

  writeln(Ffile,'  0');
  writeln(Ffile,'DICTIONARY');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbDictionary');
  writeln(Ffile,'  3');
  writeln(Ffile,'ACAD_GROUP');
  writeln(Ffile,'350');
  writeln(Ffile, IntToHex(N+1, 1));
  writeln(Ffile,'  3');
  writeln(Ffile,'ACAD_MLINESTYLE');
  writeln(Ffile,'350');
  writeln(Ffile, IntToHex(N+2, 1));

  writeln(Ffile,'  0');
  writeln(Ffile,'DICTIONARY');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'102');
  writeln(Ffile,'{ACAD_REACTORS');
  writeln(Ffile,'330');
  writeln(Ffile, IntToHex(N, 1));
  writeln(Ffile,'102');
  writeln(Ffile,'}');
  writeln(Ffile,'100');
  writeln(Ffile,'AcDbDictionary');

  writeln(Ffile,'  0');
  writeln(Ffile,'DICTIONARY');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'102');
  writeln(Ffile,'{ACAD_REACTORS');
  writeln(Ffile,'330');
  writeln(Ffile, IntToHex(N, 1));
  writeln(Ffile,'102');
  writeln(Ffile,'}');
  writeln(Ffile,'100');
  writeln(Ffile,'AcDbDictionary');
  writeln(Ffile,'  3');
  writeln(Ffile,'STANDARD');
  writeln(Ffile,'350');
  writeln(Ffile, IntToHex(N+3, 1));

  writeln(Ffile,'  0');
  writeln(Ffile,'MLINESTYLE');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'102');
  writeln(Ffile,'{ACAD_REACTORS');
  writeln(Ffile,'330');
  writeln(Ffile, IntToHex(N+2, 1));
  writeln(Ffile,'102');
  writeln(Ffile,'}');
  writeln(Ffile,'100');
  writeln(Ffile,'AcDbMlineStyle');
  writeln(Ffile,'  2');
  writeln(Ffile,'STANDARD');
  writeln(Ffile,' 70');
  writeln(Ffile,'     0');
  writeln(Ffile,'  3');
  writeln(Ffile,'');
  writeln(Ffile,' 62');
  writeln(Ffile,'   256');
  writeln(Ffile,' 51');
  writeln(Ffile,'90.0');
  writeln(Ffile,' 52');
  writeln(Ffile,'90.0');
  writeln(Ffile,' 71');
  writeln(Ffile,'     2');
  writeln(Ffile,' 49');
  writeln(Ffile,'0.5');
  writeln(Ffile,' 62');
  writeln(Ffile,'   256');
  writeln(Ffile,'  6');
  writeln(Ffile,'BYLAYER');
  writeln(Ffile,' 49');
  writeln(Ffile,'-0.5');
  writeln(Ffile,' 62');
  writeln(Ffile,'   256');
  writeln(Ffile,'  6');
  writeln(Ffile,'BYLAYER');
  writeln(Ffile,'  0');
  writeln(Ffile,'ENDSEC');
end;

procedure TAutoCadExport.CloseBlock;
begin
  if FWritingBlock=2 then Exit;
  FWritingBlock:=0;
end;

procedure TAutoCadExport.InsertBlock(const ElementU: IInterface);
var
  Element:IDMElement;
  S:string;
begin
  if FWritingBlock=2 then Exit;
  Element:=ElementU as IDMElement;
  if FWriteFlag then begin
    FWritingBlock:=1;
    S:=Element.Name;
    CorrectName(S);
    BuildInsertBlock(S);
  end else begin
    if FBlockList.IndexOf(pointer(Element))=-1 then
      FBlockList.Add(pointer(Element));
  end;
end;

procedure TAutoCadExport.BuildInsertBlock(const BlockName:string);
var
  X, Y, Z, XScale, YScale, ZScale, Angle:double;
begin
  X:=FLocalView.CX;
  Y:=FLocalView.CY;
  Z:=FLocalView.CZ;
  XScale:=1./FLocalView.RevScaleX;
  YScale:=1./FLocalView.RevScaleY;
  ZScale:=1./FLocalView.RevScaleZ;
  Angle:=FLocalView.ZAngle;

  writeln(Ffile,'  0');
  writeln(Ffile,'INSERT');

  writeln(Ffile,'  5');
  writeln(FFile, IntToHex(FCurrentHandle, 1));
  inc(FCurrentHandle);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbEntity');

  writeln(Ffile,'  8');
  writeln(FFile, FLayers[FLayerIndex]);

  writeln(Ffile,'100');
  writeln(Ffile,'AcDbBlockReference');
  writeln(Ffile,'  2');
  writeln(Ffile, BlockName);
  writeln(Ffile,' 10');
  writeln(Ffile, FloatToStr(X));
  writeln(Ffile,' 20');
  writeln(Ffile, FloatToStr(Y));
  writeln(Ffile,' 30');
  writeln(Ffile, FloatToStr(Z));
  writeln(Ffile,' 41');
  writeln(Ffile, FloatToStr(XScale));
  writeln(Ffile,' 42');
  writeln(Ffile, FloatToStr(YScale));
  writeln(Ffile,' 43');
  writeln(Ffile, FloatToStr(ZScale));
  writeln(Ffile,' 50');
  writeln(Ffile, FloatToStr(Angle));
end;

procedure TAutoCadExport.DrawTexture(const TextureName: WideString;
         var TextureNum: Integer; x0, y0, z0, x1, y1, z1, x2,
      y2, z2, x3, y3, z3, NX, NY, NZ, MX, MY: Double);
begin
end;

procedure TAutoCadExport.Clear;
begin
end;

procedure TAutoCadExport.GetTextExtent(const Text: WideString; out Width,
  Height: Double);
begin
end;

procedure TAutoCadExport.SetFont(const FontName: WideString; FontSize,
  FontStyle, FontColor: Integer);
begin
end;

function TAutoCadExport.Get_IsPrinter: WordBool;
begin
  Result:=False
end;

procedure TAutoCadExport.Set_IsPrinter(Value: WordBool);
begin
end;

initialization
  CreateAutoObjectFactory(TAutoCadExport, Class_AutoCadExport);
end.
