unit CustomSMDocumentU;


{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Classes, SysUtils, Dialogs,SpatialModelLib_TLB, DataModel_TLB, DMServer_TLB,
  CustomDMDocument, StdVcl, Variants,
  DMElementU;

var
  NilUnk:IUnknown=nil;
const
  Tresh=20;
const
  csChecked = $00000000;
  csEnabled = $00000001;
  csVisible = $00000002;
  csClick = $00000003;

type
  TCustomSMDocument = class(TCustomDMDocument,
                      ISMDocument, ISMOperationManager, IVolumeBuilder)
  private
    FSnapDistance:integer;
    FSnapMode:integer;
    FAutoSnapNode:boolean;
    FBreakLineInSnapNode:boolean;

    FOrthoMode:boolean;
    FShowAxesMode:boolean;
    FPainter:IPainter;

    FVirtualX:double;
    FVirtualY:double;
    FVirtualZ:double;

    FCurrPX:integer;
    FCurrPY:integer;
    FCurrPZ:integer;

    FP0X:integer;
    FP0Y:integer;
    FP0Z:integer;

    FAxX:integer;
    FAxY:integer;
    FAxZ:integer;

    FHWindowFocused:boolean;       // ???
    FVWindowFocused:boolean;
    FLastView:IView;

    FPictureFileName:string;
    FGlueNodeMode:boolean;
    FExecutingOperation:boolean;

    FOperationStep: Integer;
    FOperationX0: Double;
    FOperationY0: Double;
    FOperationZ0: Double;

    FPrevSelectedAreaList:TList;
    FSelectedAreaList:TList;
    FDontDragMouse:integer;

    procedure CheckDoubleLines(const Node: ICoordNode);
    procedure ClearPrevSelectedAreas;
    procedure ClearSelectedAreas;
  private
    FBuildingLevel:integer;


    function Get_NearestCircle: IDMElement;
    function Get_NearestImage: IDMElement;
    function Get_NearestLabel: IDMElement;
    function GetNearestCircle(WX, WY, WZ: Double): ISpatialElement;
    function GetNearestImage(WX, WY, WZ: Double; Tag: Integer;
      const ExceptedNode: ICoordNode; BlindMode:WordBool): ISpatialElement;
    function GetNearestLabel(WX, WY, WZ: Double; Tag: Integer;
      const ExceptedNode: ICoordNode; BlindMode:WordBool): ISMLabel;
    procedure NodeUpdateAreas(const Node:ICoordNode);
    procedure DoNodeUpdateAreas(const Line0E, Line1E:IDMElement);
    function LineUpdateAreas(const Line:ILine):WordBool;
    function LineIsInternalCheck(const Area:IArea;const Line:ILine;
                                                 out Stat:integer):boolean;
    function BuildVolumeUp(const BaseAreas:IDMCollection; Height:double;
                           const ParentVolume:IVolume; AddView:WordBool):IDMElement;
    function BuildVolumeDown(const BaseAreas:IDMCollection; Height:double;
                           const ParentVolume:IVolume; AddView:WordBool):IDMElement;
    function DoBuildVolume(const BaseAreas:IDMCollection; var Height:double;
                        const SpatialModel2:ISpatialModel2;
                        const ParentVolume1:IVolume; AddView:WordBool; Direction:integer):IDMElement;
    function  Crossing_Node(Node1X: Double; Node1Y: Double; Node2X: Double; Node2Y: Double;
                            Node3X: Double; Node3Y: Double; Node4X: Double; Node4Y: Double;
                            out x: Double; out y: Double): WordBool;
    function LineAddAreas(const Area: IArea;const Line: ILine):IArea;
    procedure IntersectHLine(const HLinesCol:IDMCollection);
    function IsNotAngular(Line,Line1:ILine;var Node:ICoordNode):boolean ;
    procedure VArea_SetParents(const VArea:IArea;const Lines,OppositLines:IDMCollection;
                                const Volume:IVolume);
    procedure MoveBorderInVolume(const VArea:IArea;OldVolume,
              NewVolume:IVolume;Direction:integer);
    function  ReorderLinesWithMessage(var Lines: IDMCollection;
                                              Stat: WordBool): WordBool;
    function Build_NewVolume(const AreaOld:IArea;const AreaNew:IArea;
                     out Volume:IVolume;out NewVolume:IVolume):WordBool;
    function CheckAreaCustomizability(const OldArea: IArea; const NewArea: IArea;
                             const OldTopArea: IArea; const NewTopArea: IArea;
                             const Volume:IVolume): WordBool;
    function BuildSubAreas(const BaseArea: IArea; const OldVolume: IVolume;
                            const NewVolume: IVolume; const AreasCollection: IDMCollection;
                            const BaseLinesCollection: IDMCollection;
                            const BordersCollection: IDMCollection; Direction: Integer): WordBool; safecall;
    function  MoveAreaInVolume(const OldArea:IArea;const Area:IArea;const OldVolume:IVolume;
                               Direction:Integer; var NewVolume: IVolume): WordBool; safecall;
    procedure  UpdateCollection(Direct: WordBool; var C0: ICoordNode;
                           var Collection: IDMCollection);
    function  LineSeparate(X: Double; Y: Double; Z: Double; Direct: WordBool; var NLine: ILine;
                           var C0: ICoordNode): ILine;
    function AreaWithInternalNode(const C0: ICoordNode; const C1: ICoordNode;
                                  const C2: ICoordNode; Stat: Integer;
                                  AreaDivided:boolean): IArea;
    function  NodeIsInternalCheck(const Area:IArea;X:Double;Y:Double;Z:Double;
                                        out Stat:Integer):WordBool;
    function AreaWithNodes(const C0, C1:ICoordNode):IArea;
    procedure BaseBuildingVolumeCheck(const BaseAreas:IDMCollection);
    function Get_AutoSnapNode: WordBool;
    procedure Set_AutoSnapNode(Value: WordBool);
    procedure JoinAreas(const aArea0, aArea1:IArea; const Line:ILine;
                    Index:integer;
                    const DMCollection:IDMCollection;
                    const UpdateElementCollection:IDMCollection);
    function DivideLineIn(const NLine:ILine;
       WX, WY, WZ:double; aSnapMode:integer; out aLine:ILine):ICoordNode;
    procedure BuildConnectingLineList(const C0, C1:ICoordNode;
                                      const Parent:IDMElement;
                                      const ConnectingLineList:TList;
                                      UpdateFlag:boolean);
  protected
    FCurrentOperation:pointer;
    FLastOperation:pointer;
    FLastViewMode:integer;
    FPrevSelectOperationClassType:TClass;
    FPrevSelectOperationCode:integer;

    FCurrX:double;
    FCurrY:double;
    FCurrZ:double;

    FOrtBaseX:double;
    FOrtBaseY:double;
    FOrtBaseZ:double;
    FNewZView:pointer;

    function Get_NearestLine: IDMElement; virtual;
    function Get_NearestNode: IDMElement; virtual;
    function GetNearestLine(WX, WY, WZ: Double; Tag: Integer;
      const ExceptedNode: ICoordNode; BlindMode:WordBool;
                                      var aMinDistance: double): ILine;
    function GetNearestNode(WX, WY, WZ: Double; Tag: Integer;
      const ExceptedNode: ICoordNode; BlindMode:WordBool; var aMinDistance:double): ICoordNode;

{IDMOperationManager}
    procedure Undo; override; safecall;
    procedure Redo; override; safecall;
    procedure DeleteElements(const Collection: IUnknown;
                             ConfirmFlag:WordBool); override; safecall;
{IDMDodument}
    procedure LoadTransactions(const FileName:WideString); override; safecall;
    procedure Select(const aElementU: IUnknown); override; safecall;
    procedure ClearSelection(const ExceptedElementU: IUnknown); override; safecall;
    procedure PasteToElement(const SourceElementU: IUnknown;
                            const DestElementU: IUnknown;
                            CopySpatialElementFlag, LowerLevelPaste:WordBool); override; safecall;
    function  Get_Hint: WideString; override; safecall;
    function  Get_Cursor: Integer; override; safecall;
    procedure SelectAllNodes; safecall;
{ISMDocument}
    procedure Set_DataModel(const Value: IUnknown); override; safecall;
    function Get_Painter: IPainter; safecall;
    procedure Set_Painter(const Value: IPainter); safecall;
    function  Get_CurrX: Double; safecall;
    function  Get_CurrY: Double; safecall;
    function  Get_CurrZ: Double; safecall;
    procedure SetCurrXYZ(aCurrX: Double; aCurrY: Double; aCurrZ: Double); safecall;
    function  Get_CurrPX: integer; safecall;
    function  Get_CurrPY: integer; safecall;
    function  Get_CurrPZ: integer; safecall;
    function  Get_P0X:integer; safecall;
    function  Get_P0Y:integer; safecall;
    function  Get_P0Z:integer; safecall;
    function  Get_HWindowFocused: WordBool; safecall;
    procedure Set_HWindowFocused(Value: WordBool); safecall;
    function  Get_VWindowFocused: WordBool; safecall;
    procedure Set_VWindowFocused(Value: WordBool); safecall;
    procedure MouseMove(ShiftState, X, Y, SenderTag: Integer); safecall;
    procedure MouseDown(ShiftState: integer); safecall;
    procedure MouseDrag; safecall;
    function  Get_ShowAxesMode:WordBool; safecall;
    procedure Set_ShowAxesMode(Value:WordBool); safecall;
    procedure ShowAxes; safecall;
    function  Get_DontDragMouse:integer; safecall;
    procedure Set_DontDragMouse(Value:integer); safecall;
{ISMOperationManager}
    function Get_OperationCode: Integer; safecall;
    procedure StartOperation(aOperationCode: Integer); virtual; safecall;
    procedure DoOperationStep(ShiftState: Integer); safecall;
    procedure StopOperation(ShiftState: Integer); safecall;
    function Get_OperationStep: Integer; safecall;
    function Get_OperationX0: Double; safecall;
    function Get_OperationY0: Double; safecall;
    function Get_OperationZ0: Double; safecall;
    procedure Set_OperationStep(Value: Integer); safecall;
    procedure Set_OperationX0(Value: Double); safecall;
    procedure Set_OperationY0(Value: Double); safecall;
    procedure Set_OperationZ0(Value: Double); safecall;

    function  Get_SnapMode: Integer; safecall;
    procedure Set_SnapMode(Value: Integer); safecall;
    function Get_SnapDistance: Integer; safecall;
    procedure Set_SnapDistance(Value: Integer); safecall;
    procedure RestoreView; safecall;
    function ReorderLines(const aCollection: IDMCollection): Integer; safecall;
    procedure CalcSelectionLimits(out MinX, MinY, MinZ, MaxX, MaxY,
      MaxZ: Double); safecall;
    function Get_PictureFileName: WideString; safecall;
    procedure Set_PictureFileName(const Value: WideString); safecall;
    function Get_VirtualX: Double; safecall;
    function Get_VirtualY: Double; safecall;
    function Get_VirtualZ: Double; safecall;
    procedure ZoomSelection; safecall;

    function Get_GlueNodeMode: WordBool; safecall;
    procedure Set_GlueNodeMode(Value: WordBool); safecall;
    procedure SaveView(const aView: IView); safecall;

    procedure MoveAreas(const DestVolume, SourceVolume:IVolume;
                    const aArea, CuttingArea:IArea); safecall;

{IVolumeBuilder}

    function BuildVolume(const BaseAreas:IDMCollection;
        Height: Double; Direction: Integer;
        const ParentVolume:IVolume; AddView:WordBool): IDMElement; safecall;
    function UpdateAreas(const Element: IDMElement):WordBool; safecall;
    function LineDivideArea(const C0, C1: ICoordNode;
      const aArea: IArea): IArea; safecall;
    procedure ClearPrevSelection(ClearAll:WordBool); override;
    procedure IntersectSurface; safecall;
    function AreaIsObsolet(const AreaE:IDMElement):WordBool; virtual; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;

    property Painter:IPainter read Get_Painter;
    property HWindowFocused:WordBool read Get_HWindowFocused;
    property VWindowFocused:WordBool read Get_VWindowFocused;
    property CurrX:double read Get_CurrX;
    property CurrY:double read Get_CurrY;
    property CurrZ:double read Get_CurrZ;
    property VirtualX:double read Get_VirtualX;
    property VirtualY:double read Get_VirtualY;
    property VirtualZ:double read Get_VirtualZ;
    property OperationX0:double read Get_OperationX0 write Set_OperationX0;
    property OperationY0:double read Get_OperationY0 write Set_OperationY0;
    property OperationZ0:double read Get_OperationZ0 write Set_OperationZ0;
    property OperationStep:integer read Get_OperationStep write Set_OperationStep;
    property OperationCode:integer read Get_OperationCode;
    property NearestNode:IDMElement read Get_NearestNode;
    property NearestLine:IDMElement read Get_NearestLine;
    property NearestCircle:IDMElement read Get_NearestCircle;
    property NearestImage:IDMElement read Get_NearestImage;
    property NearestLabel:IDMElement read Get_NearestLabel;
    property SelectedAreaList:TList read FSelectedAreaList;
    property SnapMode:integer read Get_SnapMode write Set_SnapMode;
    property AutoSnapNode:WordBool read Get_AutoSnapNode write Set_AutoSnapNode;
    property GlueNodeMode:WordBool read Get_GlueNodeMode write Set_GlueNodeMode;
    property DontDragMouse:integer read Get_DontDragMouse write Set_DontDragMouse;
    property BreakLineInSnapNode:boolean read FBreakLineInSnapNode write FBreakLineInSnapNode;
    property NewZView:pointer read FNewZView write FNewZView;

    function GetSnapNode(out NLine: ILine; const ExceptedNode: ICoordNode;
             BlindMode: WordBool; aMinDistance:double): ICoordNode; safecall;
    function FindEndedNodes(const Lines: IDMCollection;
                               out C0, C1, C2: ICoordNode):WordBool;safecall;
    function Find_DivideAreaWithNodes(const C0, C1, C2: ICoordNode;
                                      const LineCollection:IDMCollection;
                                      out NewArea:IArea):IArea;
    procedure Lines_AddParent(const aLines:IDMCollection;var Area:IArea);safecall;
    function PolyLine_IsClosedVolume(const LinesCol: IDMCollection;
                                     const LineColList: TList): WordBool;safecall;
    function PolyLine_BuildVerticalArea(const PolyLineCollection: IDMCollection;
                                  OperationCode: Integer;BuildDirection:Integer;
                                  var AreaRef:IDMElement): IVolume;safecall;
    function CreateRefElement(var ClassID:integer; OperationCode: Integer;
      const Collection: IDMCollection; out RefElement,
      RefParent: IDMElement; SetParentFlag:WordBool): WordBool; virtual; safecall;
    procedure ChangeRefRef(const Collection: IDMCollection;
                        const aName: WideString;
                        const aRef, aElement: IDMElement); virtual;
    procedure AfterRefElementCreation(const aElement: IDMElement); virtual;
    function GlueNode(const Node: ICoordNode;
      const ExceptNodes: IDMCollection): ICoordNode; safecall;
    function BuildVerticalArea(const BLine:ILine;
                        Direction:integer; BuildVolumeFlag:WordBool;
                        NodeList, LineList, UpdateList:TList):IDMElement; safecall;
    function InsertVerticalArea(const BaseNode: ICoordNode): IArea; safecall;
    procedure DivideVerticalArea(const Node: ICoordNode; Direction: Integer;
      out DividingLine: ILine); safecall;
    procedure ReplaceCoordNode(const Node0, Node1: ICoordNode); safecall;
    procedure IntersectLines(const Collection: IDMCollection); safecall;
    procedure DeleteVertical(const DMCollection: IDMCollection); safecall;
    function BuildReliefArea(const BaseArea: IArea; const NewLines,
      UsedNodes: IDMCollection; var BLine0E, BLine1E: IDMElement): IArea; safecall;
    function  ReorderGroupLines(const Lines: IDMCollection;
                                const FirstLines: IDMCollection): WordBool;
    procedure UndoSelection; override; safecall;

    procedure CheckHAreas(const ParentVolume, Volume:IVolume; BuildDirection:integer;
                          CommonVolumeFlag:WordBool); safecall;
    procedure DivideVolume(const Volume: IVolume; Height: Double; ShiftState: Integer;
                            N, BuildDirection, Direction: Integer; CopyBottomArea:WordBool; const RefElement: IDMElement;
                            const RefParent: IDMElement; out NewVolumes: IDMCollection); safecall;
    procedure AddZView(MinZ, MaxZ:double); safecall;
    function GetSubElement:IDMElement; virtual;
    procedure GetSnapPoint(out WX, WY, WZ: Double;
                           out NLine: ILine;
                           out NNode:ICoordNode;
                           const ExceptedNode: ICoordNode; BlindMode: WordBool;
                                                           aMinDistance: double);
    procedure SelectTopEdges; safecall;
    procedure LineDivideArea1(var C0, C1:ICoordNode;
               const aCurrentLines:IDMCollection; var aArea, aNewArea: IArea);
  end;

function AreaInVolume(const aArea:IArea; const Volume:IVolume):boolean;

implementation

uses
  ComObj, ComServ,
  SpatialModelConstU, SMOperationU,
  SMSelectOperationU, SMCreateOperationU,
  SMTransformOperationU, SMEditOperationU, SMReliefOperationU,
  SMViewOperationU, SMBuildOperationU, DMTransactionU, Geometry,
  BuildFMVolumeOperationU, LinkListU;



{ TCustomSMDocument }

procedure TCustomSMDocument.DoOperationStep(ShiftState: Integer);
var
  PrevOperation:TObject;
  OldState:integer;
  CurrentOperation, LastOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  LastOperation:=TSMOperation(FLastOperation);
  if FLastViewMode=1 then begin
    if (FPainter<>nil) and
       (FPainter.View<>nil) then begin
      OldState:=Get_State;
      Set_State(OldState or dmfCommiting);
      try
        FLastView.Duplicate(FPainter.View);
      finally
        Set_State(OldState);
      end;
    end;
    inc(FLastViewMode);
  end;

  if FExecutingOperation then begin
    XXX:=0;
    Exit;
  end;
  FExecutingOperation:=True;
  try
  CurrentOperation.Execute(Self, ShiftState);
  if CurrentOperation.CurrentStep<>-1 then  begin
    if CurrentOperation.CurrentStep=-2 then begin
      PrevOperation:=FCurrentOperation;
      if CurrentOperation is TSMViewOperation then
        FCurrentOperation:=FLastOperation
      else begin
        FCurrentOperation:=TSMOperationClass(LastOperation.ClassType).Create(
           LastOperation.OperationCode, Self);
        CurrentOperation:=TSMOperation(FCurrentOperation);
        CurrentOperation.Init;
        FLastOperation:=FCurrentOperation;
      end;
      PrevOperation.Free;
    end;
    Exit;
  end;

  PrevOperation:=CurrentOperation;
  if CurrentOperation is TSMViewOperation then
    FCurrentOperation:=FLastOperation
  else begin
    FCurrentOperation:=TSMOperationClass(LastOperation.ClassType).Create(
         LastOperation.OperationCode, Self);
    CurrentOperation:=TSMOperation(FCurrentOperation);
    CurrentOperation.Init;
    FLastOperation:=FCurrentOperation;
  end;
  PrevOperation.Free;
  finally
    FExecutingOperation:=False;
  end;
end;

procedure TCustomSMDocument.StopOperation(ShiftState: Integer);
var
  PrevOperation:TObject;
  N:integer;
  CurrentOperation, LastOperation:TSMOperation;
  Server:IDataModelServer;
  DataModel:IDataModel;
  ErrorCount:integer;
begin
  if FCurrentOperation=nil then Exit;
  CurrentOperation:=TSMOperation(FCurrentOperation);
  LastOperation:=TSMOperation(FLastOperation);

  DataModel:=Get_DataModel as IDataModel;

  if CurrentOperation.GetModelCheckFlag then begin
    DataModel.CheckErrors;
    ErrorCount:=DataModel.Errors.Count;
    if ErrorCount>0 then begin
      Get_Server.CallDialog(sdmConfirmation, '',
      'Модель объекта содержит ошибки, которые могут превести к тому, что данная операция '+
      'будет выполнена некорректно.'+#13+
      'Продолжить выполнение операции?');
      if Get_Server.EventData1=0 then Exit;
    end;
  end;


  if FExecutingOperation then begin
    XXX:=0;
    Exit;
  end;
  FExecutingOperation:=True;
  try

  CurrentOperation.Stop(Self, ShiftState);

  if CurrentOperation.CurrentStep=-1 then begin
    Undo;
    N:=FTransactions.Count-1;
    if N<0 then Exit;
    FState:=FState or dmfRollBacking;
    TDMTransaction(FTransactions[N]).Clear;
    TDMTransaction(FTransactions[N]).Free;
    FState:=FState and not dmfRollBacking;
    FTransactions.Delete(N);
    FOperationStepExecutedFlag:=False;
    FDocumentOperationFlag:=False;
    FDocumentOperationElement:=nil;
  end;

  if CurrentOperation.GetModelCheckFlag then begin
    DataModel.CheckErrors;
    if DataModel.Errors.Count-ErrorCount>0 then begin
      Get_Server.CallDialog(sdmShowMessage, '',
      'Операция выполнена с ошибками. Рекомендуется проверить корректность модели');
    end;
  end;

  Server:=Get_Server;

  if (sProgram and ShiftState)<>0 then begin
    Server.SetControlState(0, -CurrentOperation.OperationCode,
                           csChecked, 0);
    PrevOperation:=FCurrentOperation;
    FCurrentOperation:=TSMOperationClass(FPrevSelectOperationClassType).Create(
           FPrevSelectOperationCode, Self);
    CurrentOperation:=TSMOperation(FCurrentOperation);
    CurrentOperation.Init;
    Server.SetControlState(0, -CurrentOperation.OperationCode,
                           csChecked, 1);
    PrevOperation.Free;
    Exit;
  end;

  if CurrentOperation.CurrentStep>-1 then Exit;
  PrevOperation:=FCurrentOperation;
  if CurrentOperation is TSMViewOperation then  begin
    Server.SetControlState(0, -CurrentOperation.OperationCode,
                           csChecked, 0);
    FCurrentOperation:=FLastOperation;
    if LastOperation<>nil then
      Server.SetControlState(0, -LastOperation.OperationCode,
                           csChecked, 1);
  end else begin
    FCurrentOperation:=TSMOperationClass(CurrentOperation.ClassType).Create(
           CurrentOperation.OperationCode, Self);
    CurrentOperation:=TSMOperation(FCurrentOperation);
    CurrentOperation.Init;
    FLastOperation:=FCurrentOperation;
  end;
  PrevOperation.Free;
  finally
    FExecutingOperation:=False;
  end;
end;

function TCustomSMDocument.Get_SnapMode: Integer;
begin
  Result:=FSnapMode
end;

procedure TCustomSMDocument.Set_SnapMode(Value: Integer);
begin
  FSnapMode:=Value
end;

procedure TCustomSMDocument.GetSnapPoint(out WX, WY, WZ: Double;
                                         out NLine: ILine;
                                         out NNode:ICoordNode;
                           const ExceptedNode: ICoordNode; BlindMode: WordBool;
                                                           aMinDistance: double);
var
  W0X, W0Y, W0Z, C0X, C0Y, C0Z, C1X, C1Y, C1Z,
  D0, D1, D, Cell, CX, CY, CZ:double;
  SpatialModel2:ISpatialModel2;
  View:IView;
  Tag, N:integer;
  PX0, PY0, PZ0, X, Y, Z: integer;
  MinDistance:double;
  CurrentOperation:TSMOperation;
  aSnapMode:integer;
  OrtBaseOnLine:WordBool;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  if FVWindowFocused then
    Tag:=2
  else
    Tag:=1;

  View:=FPainter.View;
  SpatialModel2:=Get_DataModel as ISpatialModel2;
  NLine:=GetNearestLine(FCurrX, FCurrY, FCurrZ, Tag,
                ExceptedNode, BlindMode,aMinDistance);
  NNode:=nil;              
  if NLine<>nil then begin
    C0X:=NLine.C0.X;
    C0Y:=NLine.C0.Y;
    C0Z:=NLine.C0.Z;
    C1X:=NLine.C1.X;
    C1Y:=NLine.C1.Y;
    C1Z:=NLine.C1.Z;
  end else begin
    C0X:=0;
    C0Y:=0;
    C0Z:=0;
    C1X:=0;
    C1Y:=0;
    C1Z:=0;
  end;
  D0:=0;
  D1:=0;

  if CurrentOperation.OperationCode<>smoCreateClosedPolyLine then
    aSnapMode:=FSnapMode
  else
    aSnapMode:=smoSnapToNode;

  if aSnapMode=smoSnapNone then begin
    WX:=FCurrX;
    WY:=FCurrY;
    WZ:=FCurrZ;
  end else
  if aSnapMode=smoSnapToNode then begin
    if FOrthoMode then begin
      WX:=FCurrX;
      WY:=FCurrY;
      WZ:=FCurrZ;
    end else begin
      MinDistance:=0;
      NNode:=GetNearestNode(FCurrX, FCurrY, FCurrZ, Tag,
                            ExceptedNode, False, MinDistance);
      if NNode=nil then begin
        WX:=FCurrX;
        WY:=FCurrY;
        WZ:=FCurrZ;
      end else begin
        WX:=NNode.X;
        WY:=NNode.Y;
        WZ:=NNode.Z;
      end;
    end;
  end else
  if FOrthoMode then begin
    WX:=FCurrX;
    WY:=FCurrY;
    WZ:=FCurrZ;
    if (NLine<>nil) and
       (NLine.C0<>ExceptedNode) and
       (NLine.C1<>ExceptedNode) then begin
      FPainter.WP_To_P(FCurrX, FCurrY, FCurrZ,
                      X, Y, Z);
      FPainter.WP_To_P(CurrentOperation.X0, CurrentOperation.Y0, CurrentOperation.Z0,
                      PX0, PY0, PZ0);
      if Abs(PX0-X)>Abs(PY0-Y) then begin
        if C1Y<>C0Y then
          WX:=C0X+(C1X-C0X)*(WY-C0Y)/(C1Y-C0Y)
      end else begin
        if C1X<>C0X then
          WY:=C0Y+(C1Y-C0Y)*(WX-C0X)/(C1X-C0X)
      end;
    end;
  end else
  if aSnapMode=smoSnapToMiddleOfLine then begin
     if (NLine=nil) or
        (NLine.C0=ExceptedNode) or
        (NLine.C1=ExceptedNode) then begin
       WX:=FCurrX;
       WY:=FCurrY;
       WZ:=FCurrZ;
     end else begin
        WX:=(C0X+C1X)/2;
        WY:=(C0Y+C1Y)/2;
        WZ:=(C0Z+C1Z)/2;
      end;
  end else
  if (aSnapMode = smoSnapOrtToLine) or
     (aSnapMode = smoSnapToNearestOnLine) or
     (aSnapMode = smoSnapToLocalGrid) then begin
     if (NLine=nil) or
        (NLine.C0=ExceptedNode) or
        (NLine.C1=ExceptedNode)  then begin
       WX:=FCurrX;
       WY:=FCurrY;
       WZ:=FCurrZ;
     end else begin
       if ExceptedNode<>nil then begin
         if (aSnapMode=smoSnapOrtToLine) or
            (aSnapMode=smoSnapToLocalGrid) then begin
           W0X:=ExceptedNode.X;
           W0Y:=ExceptedNode.Y;
           W0Z:=ExceptedNode.Z;
         end else begin
           W0X:=FCurrX;
           W0Y:=FCurrY;
           W0Z:=FCurrZ;
         end;
       end else begin
         W0X:=FCurrX;
         W0Y:=FCurrY;
         W0Z:=FCurrZ;
       end;

       if FAutoSnapNode then begin
         MinDistance:=FSnapDistance*FPainter.View.RevScaleX;
         D0:=sqrt(sqr(FCurrX-C0X)+
                  sqr(FCurrY-C0Y)+
                  sqr(FCurrZ-C0Z));
         D1:=sqrt(sqr(FCurrX-C1X)+
                 sqr(FCurrY-C1Y)+
                 sqr(FCurrZ-C1Z));
         if D0<MinDistance then begin
            if NLine<>nil then
              NNode:=NLine.C0;
            WX:=C0X;
            WY:=C0Y;
            WZ:=C0Z;
            Exit;
         end else
         if D1<MinDistance then begin
            if NLine<>nil then
              NNode:=NLine.C1;
            WX:=C1X;
            WY:=C1Y;
            WZ:=C1Z;
            Exit;
         end
       end;

       NLine.DistanceFrom(W0X, W0Y, W0Z,
                        WX,  WY,  WZ, OrtBaseOnLine);
       if not OrtBaseOnLine then begin
         WX:=FCurrX;
         WY:=FCurrY;
         WZ:=FCurrZ;
         NLine:=nil;
       end;
     end;
  end;

  try
  if (NLine<>nil) and
     (aSnapMode=smoSnapToLocalGrid) and
     (ExceptedNode=nil) then begin
    Cell:=SpatialModel2.LocalGridCell*100;
    if Cell<NLine.Length then begin
      if Cell<=0.5*NLine.Length then begin
        if D0<D1 then begin
          NNode:=NLine.C0;
          CX:=C0X;
          CY:=C0Y;
          CZ:=C0Z;
        end else begin
          NNode:=NLine.C1;
          CX:=C1X;
          CY:=C1Y;
          CZ:=C1Z;
        end;
      end else begin
        if D0<D1 then begin
          NNode:=NLine.C1;
          CX:=C1X;
          CY:=C1Y;
          CZ:=C1Z;
        end else begin
          NNode:=NLine.C0;
          CX:=C0X;
          CY:=C0Y;
          CZ:=C0Z;
        end;
      end;
      D:=sqrt(sqr(WX-CX)+
                  sqr(WY-CY)+
                  sqr(WZ-CZ));
      N:=round(D/Cell);
      WX:=CX+(WX-CX)/D*(N*Cell);
      WY:=CY+(WY-CY)/D*(N*Cell);
      WZ:=CZ+(WZ-CZ)/D*(N*Cell);
    end;
  end;
  except
    raise
  end;

  if (ExceptedNode<>nil) and
     (WX=ExceptedNode.X) and
     (WY=ExceptedNode.Y) and
     (WZ=ExceptedNode.Z) then begin
    WX:=FCurrX;
    WY:=FCurrY;
    WZ:=FCurrZ;
  end;
end;

function TCustomSMDocument.Get_Painter: IPainter;
begin
  Result:=FPainter
end;

procedure TCustomSMDocument.Set_Painter(const Value: IPainter);
begin
  FPainter:=Value
end;

procedure TCustomSMDocument.MouseDown(ShiftState: integer);
var
  CurrentOperation:TSMOperation;
  DocumentOperationElement:IDMElement;
begin
  if FCurrentOperation=nil then Exit;
  CurrentOperation:=TSMOperation(FCurrentOperation);
  case CurrentOperation.OperationCode of
  smoBreakLine,
  smoDoubleBreakLine,
  smoBuildLineObject,
  smoBuildArrayObject:
    FAutoSnapNode:=False;
  else
    FAutoSnapNode:=((sAlt and ShiftState)=0);
  end;

  FP0X:=FCurrPX;
  FP0Y:=FCurrPY;
  FP0Z:=FCurrPZ;

  State:=State or dmfLongOperation;
  FOperationStepExecutedFlag:=False;
  FDocumentOperationFlag:=False;
  FDocumentOperationElement:=nil;
  try
  if (ShiftState and sLeft)<>0 then
    DoOperationStep(ShiftState)
  else
  if (ShiftState and sRight)<>0 then
      StopOperation(ShiftState)
  else
  if (ShiftState and sProgram)<>0 then
      StopOperation(ShiftState);
  finally
    State:=State and not dmfLongOperation;
    if FOperationStepExecutedFlag then
      Get_Server.OperationStepExecuted;
    DocumentOperationElement:=IDMElement(FDocumentOperationElement);
    if FDocumentOperationFlag and
       ((DocumentOperationElement=nil) or (DocumentOperationElement.Exists))then
      Get_Server.DocumentOperation(DocumentOperationElement,
                                   IDMCollection(FDocumentOperationCollection),
                                   FDocumentOperationOperation,
                                   FDocumentOperationItemIndex);
  end;
end;

procedure TCustomSMDocument.MouseMove(ShiftState, X, Y, SenderTag: Integer);
var
  ExceptedNode, NNode:ICoordNode;
  NLine:ILine;
  PX0, PY0, PZ0:integer;
  CurrentOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  FAutoSnapNode:=((sAlt and ShiftState)=0);

  if FPainter=nil then Exit;
  if CurrentOperation<>nil then
    CurrentOperation.Drag(Self);

  FPainter.P_To_WP(X, Y, SenderTag, FCurrX, FCurrY, FCurrZ);
  if (CurrentOperation<>nil) and
     ((sCtrl and ShiftState)<>0)and
     (CurrentOperation.CurrentStep>0) then begin
    FOrthoMode:=True;
    FPainter.WP_To_P(CurrentOperation.X0, CurrentOperation.Y0, CurrentOperation.Z0,
                    PX0, PY0, PZ0);
    if Abs(PX0-X)>Abs(PY0-Y) then begin
      FCurrY:=CurrentOperation.Y0;
    end else begin
      FCurrX:=CurrentOperation.X0;
    end;
  end else
    FOrthoMode:=False;

  if FShowAxesMode then
     FPainter.DrawAxes(FAxX, FAxY, FAxZ);

  if SenderTag=1 then begin
    if not FHWindowFocused then begin
      FHWindowFocused:=True;
      FVWindowFocused:=False;
      FCurrZ:=FPainter.View.CurrZ0;
    end;
  end else begin
    if not FVWindowFocused then begin
      FHWindowFocused:=False;
      FVWindowFocused:=True;
      FCurrX:=FPainter.View.CurrX0;
      FCurrY:=FPainter.View.CurrY0;
    end;
  end;

  if FCurrentOperation<>nil then
    ExceptedNode:=CurrentOperation.GetBaseNode
  else
    ExceptedNode:=nil;

  FVirtualX:=FCurrX;
  FVirtualY:=FCurrY;
  FVirtualZ:=FCurrZ;
  
  if (CurrentOperation<>nil) and
     (not (CurrentOperation is TSMSelectOperation)) then
    GetSnapPoint(FVirtualX, FVirtualY, FVirtualZ, NLine, NNode,
                     ExceptedNode, False, 0);

  FPainter.WP_To_P(FVirtualX, FVirtualY, FVirtualZ, FCurrPX, FCurrPY, FCurrPZ);

  if CurrentOperation<>nil then
     CurrentOperation.Drag(Self);

  FPainter.WP_To_P(FVirtualX, FVirtualY, FVirtualZ, FAxX, FAxY, FAxZ);
  if FShowAxesMode then
     FPainter.DrawAxes(FAxX, FAxY, FAxZ);

end;

procedure TCustomSMDocument.Initialize;
begin
  inherited;

  FSnapMode:=smoSnapNone;
  FHWindowFocused:=False;
  FVWindowFocused:=False;
  FSnapDistance:=10;
  FGlueNodeMode:=False;
  FAutoSnapNode:=True;
  FBreakLineInSnapNode:=True;

  FLastOperation:=nil;
  FSelectedAreaList:=TList.Create;
  FPrevSelectedAreaList:=TList.Create;
  FLastViewMode:=1;
  FPrevSelectOperationClassType:=nil;
end;

function TCustomSMDocument.Get_CurrX: Double;
begin
  Result:=FCurrX
end;

function TCustomSMDocument.Get_CurrY: Double;
begin
  Result:=FCurrY
end;

function TCustomSMDocument.Get_CurrZ: Double;
begin
  Result:=FCurrZ
end;

function TCustomSMDocument.Get_ShowAxesMode: WordBool;
begin
  Result:=FShowAxesMode
end;

procedure TCustomSMDocument.Set_ShowAxesMode(Value: WordBool);
begin
  FShowAxesMode:=Value
end;

procedure TCustomSMDocument.ShowAxes;
begin
  FPainter.DrawAxes(FCurrPX, FCurrPY, FCurrPZ)
end;

procedure TCustomSMDocument.SetCurrXYZ(aCurrX, aCurrY, aCurrZ: Double);
begin
  FCurrX:=aCurrX;
  FCurrY:=aCurrY;
  FCurrZ:=aCurrZ;

  FVirtualX:=FCurrX;
  FVirtualY:=FCurrY;
  FVirtualZ:=FCurrZ;

  try
  with FPainter.View do begin
    FCurrPX:=Round(FPainter.HWidth/2 +((FCurrX-CX)*cosZ -(FCurrY-CY)*sinZ)/RevScaleX);
    FCurrPY:=Round(FPainter.HHeight/2-((FCurrX-CX)*sinZ +(FCurrY-CY)*cosZ)/RevScaleY);
    FCurrPZ:=Round(FPainter.VHeight/2- (FCurrZ-CZ)/RevScaleY);
  end;
  except
    raise
  end;  
end;

function TCustomSMDocument.Get_CurrPX: integer;
begin
  Result:=FCurrPX
end;

function TCustomSMDocument.Get_CurrPY: integer;
begin
  Result:=FCurrPY
end;

function TCustomSMDocument.Get_CurrPZ: integer;
begin
  Result:=FCurrPZ
end;

function TCustomSMDocument.Get_HWindowFocused: WordBool;
begin
  Result:=FHWindowFocused
end;

function TCustomSMDocument.Get_VWindowFocused: WordBool;
begin
  Result:=FVWindowFocused
end;

procedure TCustomSMDocument.Set_HWindowFocused(Value: WordBool);
begin
  FHWindowFocused:=Value
end;

procedure TCustomSMDocument.Set_VWindowFocused(Value: WordBool);
begin
  FVWindowFocused:=Value
end;

function TCustomSMDocument.GetSnapNode(out NLine: ILine;
  const ExceptedNode: ICoordNode; BlindMode: WordBool; aMinDistance:double): ICoordNode;
var
  WX, WY, WZ:double;
  aLine:ILine;
  NLineS:ISpatialElement;
  CoordNode, NearestNode, NNode:ICoordNode;
  View:IView;
  SpatialModel:ISpatialModel;
  Tag:integer;
  CoordNodeE:IDMElement;
  MinDistance:double;
  NodeU:IUnknown;
  CurrentOperation:TSMOperation;
  aSnapMode:integer;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  if CurrentOperation.OperationCode<>smoCreateClosedPolyLine then
    aSnapMode:=FSnapMode
  else
    aSnapMode:=smoSnapToNode;

  if FHWindowFocused then
    Tag:=1
  else
  if FVWindowFocused then
    Tag:=2
  else
    Exit;

  View:=FPainter.View;
  SpatialModel:=Get_DataModel as ISpatialModel;
  if (aSnapMode=smoSnapToNode) and
     (not FOrthoMode) then begin
     NearestNode:=GetNearestNode(FCurrX, FCurrY, FCurrZ, Tag,
                              ExceptedNode, False, aMinDistance);
     if NearestNode<>nil then begin
       Result:=NearestNode;
       Exit;
     end;
  end;
  GetSnapPoint(WX, WY, WZ, NLine, NNode, ExceptedNode, False, aMinDistance);
  if (ExceptedNode<>nil) and
     (WX=ExceptedNode.X) and
     (WY=ExceptedNode.Y) and
     (WZ=ExceptedNode.Z) then begin
    Result:=nil;
    Exit;
  end;

  NLineS:=NLine as ISpatialElement;
  if (NLine=nil) or     (aSnapMode=smoSnapNone) then begin

    SpatialModel:=Get_DataModel as ISpatialModel;

    AddElement( SpatialModel.CurrentLayer as IDMElement,
                      SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
    CoordNodeE:=NodeU as IDMElement;
    CoordNode:=CoordNodeE as ICoordNode;

    CoordNode.X:=WX;
    CoordNode.Y:=WY;
    CoordNode.Z:=WZ;

    Result:=CoordNode;

  end else begin
    Result:=nil;
    if FAutoSnapNode and
       (not FOrthoMode) then begin
      if aMinDistance>0 then
       MinDistance:=aMinDistance
      else
       MinDistance:=FSnapDistance*FPainter.View.RevScaleX;

      if CurrentOperation.OperationCode<>smoCreateClosedPolyLine then begin
        if sqrt(sqr(WX-NLine.C0.X)+
              sqr(WY-NLine.C0.Y)+
              sqr(WZ-NLine.C0.Z))<MinDistance then
          Result:=NLine.C0
        else
        if sqrt(sqr(WX-NLine.C1.X)+
              sqr(WY-NLine.C1.Y)+
              sqr(WZ-NLine.C1.Z))<MinDistance then
          Result:=NLine.C1
      end;
    end;

    if (Result<>nil) and
       (Result=ExceptedNode) then begin
      Result:=nil;
      Exit;
    end;

    if Result=nil then begin
      Result:=DivideLineIn(NLine, WX, WY, WZ, aSnapMode, aLine);
    end
  end;
end;

function TCustomSMDocument.DivideLineIn(const NLine:ILine;
       WX, WY, WZ:double; aSnapMode:integer; out aLine:ILine):ICoordNode;
var
  NLineS, aLineS:ISpatialElement;
  CoordNodeE, aLineE:IDMElement;
  NodeU, LineU:IUnknown;
  CoordNode:ICoordNode;
  SpatialModel:ISpatialModel;
begin
  NLineS:=NLine as ISpatialElement;
  SpatialModel:=Get_DataModel as ISpatialModel;
  AddElement( NLineS.Layer as IDMElement,
                    SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
  CoordNodeE:=NodeU as IDMElement;
  CoordNode:=CoordNodeE as ICoordNode;

  CoordNode.X:=WX;
  CoordNode.Y:=WY;
  CoordNode.Z:=WZ;

  Result:=CoordNode;

  if (aSnapMode<>smoSnapToNode) and
      FBreakLineInSnapNode then begin
    AddElement( NLineS.Layer as IDMElement,
                    SpatialModel.Lines, '', ltOneToMany, LineU, True);
    aLineE:=LineU as IDMElement;

    aLine:=aLineE as ILine;
    aLineS:=aLineE as ISpatialElement;

    aLine.Thickness:=NLine.Thickness;
    aLine.Style:=NLine.Style;
    aLineS.Color:=NLineS.Color;

    aLine.C0:=CoordNode;
    aLine.C1:=NLine.C1;
    NLine.C1:=CoordNode;

    CoordNodeE.Draw(FPainter, 0);

    NodeUpdateAreas(Result)
  end
end;

function TCustomSMDocument.GetNearestLine(WX, WY, WZ: Double; Tag: Integer;
  const ExceptedNode: ICoordNode; BlindMode:WordBool; var aMinDistance: double): ILine;
var
  i: integer;
  MinDistance: double;

  procedure TrySelect(aLineS:ISpatialElement);
  var
    Distance: double;
    WP0X, WP0Y, WP0Z:double;
    aLine:ILine;
    Layer:ILayer;
    View:IView;
    C0, C1:ICoordNode;
    X0, Y0, Z0, X1, Y1, Z1:double;
    OrtBaseOnLine:WordBool;
  begin
    aLine:=aLineS as ILine;
    C0:=aLine.C0;
    C1:=aLine.C1;
    if C0=nil then Exit;
    if C1=nil then Exit;
    X0:=C0.X;
    Y0:=C0.Y;
    Z0:=C0.Z;
    X1:=C1.X;
    Y1:=C1.Y;
    Z1:=C1.Z;
    Layer:=aLineS.Layer;
    View:=FPainter.View;
    if ((Layer=nil) or
         Layer.Selectable) and
       (BlindMode or
        (View.PointIsVisible(X0, Y0, Z0, Tag) and
         (View.PointIsVisible(X1, Y1, Z1, Tag) or
          ((X0=X1) and (Y0=Y1))
         )
        )
       ) then begin
      Distance:=aLine.DistanceFrom(WX, WY, WZ, WP0X, WP0Y, WP0Z,OrtBaseOnLine);
      if MinDistance>Distance then begin
        MinDistance:=Distance;
        FOrtBaseX:=WP0X;
        FOrtBaseY:=WP0Y;
        FOrtBaseZ:=WP0Z;
        Result:=aLine;
      end;
    end;
  end;

  procedure TrySelectCurved(aLineS:ISpatialElement);
  var
    Distance: double;
    WP0X, WP0Y, WP0Z:double;
    aLine:ILine;
    aCurvedLine:ICurvedLine;
    Layer:ILayer;
    View:IView;
    C0, C1:ICoordNode;
    X0, Y0, Z0, X1, Y1, Z1:double;
    OrtBaseOnLine:WordBool;
    m, N:integer;
    t, t2, t3, q, q2, q3,
    WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, WZ2, WX3, WY3, WZ3,
    WWX0, WWY0, WWZ0, WWX1, WWY1, WWZ1:double;

   function DistanceFrom(WX, WY, WZ:double;
                        out WX0, WY0, WZ0:double):double;
   var
     D0, D1:double;
   begin
     PerpendicularFrom(WWX0, WWY0, WWZ0, WWX1, WWY1, WWZ1, WX, WY, WZ, WX0, WY0, WZ0);
     OrtBaseOnLine:=False;
     if ((WX0-WWX0)*(WX0-WWX1)<=0) and
         ((WY0-WWY0)*(WY0-WWY1)<=0) and
         ((WZ0-WWZ0)*(WZ0-WWZ1)<=0) then begin
       Result:=sqrt(sqr(WX-WX0)+sqr(WY-WY0)+sqr(WZ-WZ0));
     end else begin
       D0:=sqrt(sqr(WX-WWX0)+sqr(WY-WWY0)+sqr(WZ-WWZ0));
       D1:=sqrt(sqr(WX-WWX1)+sqr(WY-WWY1)+sqr(WZ-WWZ1));
       if D0<=D1 then begin
         Result:=D0;
         WX0:=WWX0;
         WY0:=WWY0;
         WZ0:=WWZ0;
       end else begin
         Result:=D1;
         WX0:=WWX1;
         WY0:=WWY1;
         WZ0:=WWZ1;
       end;
     end;
   end;

  begin
    aLine:=aLineS as ILine;
    aCurvedLine:=aLine as ICurvedLine;
    C0:=aLine.C0;
    C1:=aLine.C1;
    if C0=nil then Exit;
    if C1=nil then Exit;
    X0:=C0.X;
    Y0:=C0.Y;
    Z0:=C0.Z;
    X1:=C1.X;
    Y1:=C1.Y;
    Z1:=C1.Z;

    Layer:=aLineS.Layer;
    View:=FPainter.View;
    if ((Layer=nil) or
         Layer.Selectable) and
       (BlindMode or
        (View.PointIsVisible(X0, Y0, Z0, Tag) and
         (View.PointIsVisible(X1, Y1, Z1, Tag) or
          ((X0=X1) and (Y0=Y1))
         )
        )
       ) then begin
      N:=12;

      WX0:=C0.X;
      WY0:=C0.Y;
      WZ0:=C0.Z;
      WX1:=aCurvedLine.P0X;
      WY1:=aCurvedLine.P0Y;
      WZ1:=aCurvedLine.P0Z;
      WX2:=aCurvedLine.P1X;
      WY2:=aCurvedLine.P1Y;
      WZ2:=aCurvedLine.P1Z;
      WX3:=C1.X;
      WY3:=C1.Y;
      WZ3:=C1.Z;

      WWX0:=WX0;
      WWY0:=WY0;
      WWZ0:=WZ0;
      for m:=1 to N do begin
        t:=m/N;
        q:=1-t;
        t2:=sqr(t);
        q2:=sqr(q);
        t3:=t2*t;
        q3:=q2*q;

        WWX1:=q3*WX0+3*q2*t*WX1+3*q*t2*WX2+t3*WX3;
        WWY1:=q3*WY0+3*q2*t*WY1+3*q*t2*WY2+t3*WY3;
        WWZ1:=q3*WZ0+3*q2*t*WZ1+3*q*t2*WZ2+t3*WZ3;

        Distance:=DistanceFrom(WX, WY, WZ, WP0X, WP0Y, WP0Z);
        if MinDistance>Distance then begin
          MinDistance:=Distance;
          FOrtBaseX:=WP0X;
          FOrtBaseY:=WP0Y;
          FOrtBaseZ:=WP0Z;
          Result:=aLine;
        end;
        WWX0:=WWX1;
        WWY0:=WWY1;
        WWZ0:=WWZ1;
      end;
    end;
  end;

var
  aLine:ISpatialElement;
  SpatialModel:ISpatialModel;
  View:IView;
  aLineE:IDMElement;
begin
  if aMinDistance>0 then
   MinDistance:=aMinDistance
  else
   MinDistance:=FSnapDistance*FPainter.View.RevScaleX;

  SpatialModel:=Get_DataModel as ISpatialModel;
  View:=FPainter.View;
  Result:=nil;
  try
  for i:=0 to SpatialModel.Lines.Count-1 do begin
    aLineE:=SpatialModel.Lines.Item[i];
    if (aLineE.Ref=nil) or
       (aLineE.Ref.IsSelectable) then begin
      aLine:=aLineE as ISpatialElement;
      if (aLine.Layer.Selectable)and
         (aLine.Layer.Visible) then
        TrySelect(aLine);
    end;
  end;

  for i:=0 to SpatialModel.CurvedLines.Count-1 do begin
    aLine:=SpatialModel.CurvedLines.Item[i] as ISpatialElement;
    if aLine.Layer.Selectable then
      TrySelectCurved(aLine);
  end;
  aMinDistance:=MinDistance;
  except
    raise
  end;
end;

function TCustomSMDocument.GetNearestImage(WX, WY, WZ: Double; Tag: Integer;
  const ExceptedNode: ICoordNode; BlindMode:WordBool): ISpatialElement;
var
  i: integer;
  aImageE:IDMElement;
  aImage:ISpatialElement;
  Layer:ILayer;
  SpatialModel:ISpatialModel;
  aCX,aCY,aC0X,aC0Y,aC1X,aC1Y:double;
  bLine:ILine;
begin
  aCX:=FCurrX;
  aCY:=FCurrY;
  SpatialModel:=Get_DataModel as ISpatialModel;
  Result:=nil;
  for i:=0 to SpatialModel.ImageRects.Count-1 do begin
    aImageE:=SpatialModel.ImageRects.Item[i];
    Layer:=aImageE.Parent as ILayer;
    if Layer.Selectable then begin
      aImage:=aImageE as ISpatialElement;
      bLine:=aImage as ILine;
      aC0X:=bLine.C0.X;
      aC0Y:=bLine.C0.Y;
      aC1X:=bLine.C1.X;
      aC1Y:=bLine.C1.Y;
      if (((aC0X>aCX)and(aC1X<aCX))or((aC0X<aCX)and(aC1X>aCX))) and
         (((aC0Y>aCY)and(aC1Y<aCY))or((aC0Y<aCY)and(aC1Y>aCY))) then begin
        Result:=aImage;
      end;
    end;
  end;
end;

function TCustomSMDocument.GetNearestCircle(WX, WY, WZ: Double): ISpatialElement;
var
  i: integer;
  aCircleE:IDMElement;
  aCircle:ISpatialElement;
  Layer:ILayer;
  SpatialModel:ISpatialModel;
  aCX,aCY,aC0X,aC0Y,R, D, MinD:double;
  Circle:ICircle;
begin
  aCX:=FCurrX;
  aCY:=FCurrY;
  SpatialModel:=Get_DataModel as ISpatialModel;
  Result:=nil;
  MinD:=InfinitValue;
  for i:=0 to SpatialModel.Circles.Count-1 do begin
    aCircleE:=SpatialModel.Circles.Item[i];
    Layer:=aCircleE.Parent as ILayer;
    if Layer.Selectable then begin
      aCircle:=aCircleE as ISpatialElement;
      Circle:=aCircle as ICircle;
      aC0X:=Circle.X;
      aC0Y:=Circle.Y;
      R:=Circle.Radius;
      D:=sqrt(sqr(aC0X-aCX)+sqr(aC0Y-aCY));
      if (D<R) and (D<MinD) then begin
        Result:=aCircle;
        MinD:=D;
      end;
    end;
  end;
end;

function TCustomSMDocument.GetNearestNode(WX, WY, WZ: Double; Tag: Integer;
  const ExceptedNode: ICoordNode; BlindMode:WordBool; var aMinDistance:double): ICoordNode;
var
  i: integer;
  MinD,D: double;
  C:ICoordNode;
  CS:ISpatialElement;
  SpatialModel:ISpatialModel;
  View:IView;
  CurrentOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);

  if aMinDistance>0 then
   MinD:=aMinDistance
  else
   MinD:=FSnapDistance*FPainter.View.RevScaleX;

  Result:=nil;
  SpatialModel:=Get_DataModel as ISpatialModel;
  View:=FPainter.View;
  for i:=0 to SpatialModel.CoordNodes.Count-1 do begin
    C:=SpatialModel.CoordNodes.Item[i] as ICoordNode;
    CS:=C as ISpatialElement;
    if (CS.Layer.Selectable) and
       (C<>ExceptedNode) then begin
      if BlindMode or
         View.PointIsVisible(C.X, C.Y, C.Z, Tag) then begin
        D:=sqrt(sqr(WX-C.X)+sqr(WY-C.Y)+sqr(WZ-C.Z));
        if MinD>D then begin
          MinD:=D;

          if CurrentOperation.OperationCode<>smoCreateClosedPolyLine then
            Result:=C
          else
          if CurrentOperation.GetFirstNode=C then
            Result:=C
        end;
      end;
    end;
  end;
  aMinDistance:=MinD;
end;

procedure TCustomSMDocument.Redo;
var
  CurrentOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  inherited;
  if CurrentOperation<>nil then
    CurrentOperation.Redo(Self);
  if FPainter<>nil then
    Get_Server.RefreshDocument(rfAll)
end;

procedure TCustomSMDocument.Undo;
var
  CurrentOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  if CurrentOperation<>nil then
    CurrentOperation.Undo(Self);
  inherited;
  if FPainter<>nil then
    Get_Server.RefreshDocument(rfAll)
end;

function TCustomSMDocument.Get_NearestLine: IDMElement;
var
  Tag:integer;
  MinDistance:double;
begin
  if FHWindowFocused then
    Tag:=1
  else
  if FVWindowFocused then
    Tag:=2
  else begin
    Result:=nil;
    Exit;
  end;

  MinDistance:=0;
  Result:=GetNearestLine(FCurrX, FCurrY, FCurrZ, Tag, nil, False,
             MinDistance) as IDMElement
end;

function TCustomSMDocument.Get_NearestNode: IDMElement;
var
  Tag:integer;
  MinDistance:double;
begin
  if FHWindowFocused then
    Tag:=1
  else
  if FVWindowFocused then
    Tag:=2
  else begin
    Result:=nil;
    Exit;
  end;
  MinDistance:=0;
  Result:=GetNearestNode(FCurrX, FCurrY, FCurrZ, Tag, nil, False, MinDistance) as IDMElement
end;

procedure TCustomSMDocument.ClearSelection(const ExceptedElementU: IUnknown);
var
  j:integer;
  aElement:IDMElement;
  Node:ICoordNode;
  DrawSelected:integer;
  ExceptedElement: IDMElement;
begin
  ExceptedElement:=ExceptedElementU as IDMElement;
  if (ExceptedElement<>nil) and
     (ExceptedElement.Ref<>nil) and
     (ExceptedElement.Ref.SpatialElement=ExceptedElement) then
   ExceptedElement:=ExceptedElement.Ref;

  if (FState and dmfDestroying)=0 then
    for j:=0 to Get_SelectionCount-1 do begin
     aElement:=Get_SelectionItem(j) as IDMElement;
     if (aElement.Ref<>nil) and
        (aElement.Ref.SpatialElement=aElement) then
      aElement:=aElement.Ref;
      if aElement<>ExceptedElement then begin

        if aElement.QueryInterface(ICoordNode, Node)=0 then begin
          DrawSelected:=-1; //стереть; 1- рисовать выделенным
        end else
          DrawSelected:=0; //отрисовать обычным образом
        if FPainter<>nil then
          aElement.Draw(FPainter, DrawSelected); //отрисовывается
      end;
    end;
  inherited;
  ClearSelectedAreas;
end;

function TCustomSMDocument.Get_SnapDistance: Integer;
begin
  Result:=FSnapDistance
end;

procedure TCustomSMDocument.Set_SnapDistance(Value: Integer);
begin
  FSnapDistance:=Value
end;

procedure TCustomSMDocument.ReplaceCoordNode(const Node0, Node1: ICoordNode);
var
  aLine:ILine;
  aLineE:IDMElement;
begin
  if Node1=Node0 then Exit;
  while Node1.Lines.Count>0 do begin
    aLine:=Node1.Lines.Item[0] as ILine;
    aLineE:=aLine as IDMElement;
    if aLine.C0=Node1 then
      ChangeFieldValue( aLineE, ord(linC0), True, Node0 as IUnknown)
    else
      ChangeFieldValue( aLineE, ord(linC1), True, Node0 as IUnknown);
  end;
  DeleteElement( nil, nil, ltOneToMany, Node1 as IDMElement);
end;

function TCustomSMDocument.GlueNode(const Node: ICoordNode;
  const ExceptNodes: IDMCollection): ICoordNode;
var
  j, i:integer;
  WX, WY, WZ, Distance:double;
  SpatialModel:ISpatialModel;
  aNodeE, aLineE, LineE:IDMElement;
  aNode:ICoordNode;
  aLine:ILine;
  aLineS:ISpatialElement;
  OrtBaseOnLine:WordBool;
  LineU:IUnknown;
  MinDistance:double;
  GlueFlag:boolean;
begin
  Result:=nil;
  GlueFlag:=False;
  if not FGlueNodeMode then Exit;
  SpatialModel:=Get_DataModel as ISpatialModel;
  if FAutoSnapNode then
    MinDistance:=FSnapDistance*FPainter.View.RevScaleX
  else
    MinDistance:=0;
  j:=0;
  while j<SpatialModel.CoordNodes.Count do begin
    aNodeE:=SpatialModel.CoordNodes.Item[j];
    if (aNodeE.Parent as ILayer).Selectable then begin
      aNode:=aNodeE as ICoordNode;
      if (aNode<>Node) and
         (abs(aNode.X-Node.X)<MinDistance) and
         (abs(aNode.Y-Node.Y)<MinDistance) and
         (aNode.Z=Node.Z) and
         ((ExceptNodes=nil) or
          (ExceptNodes.IndexOf(aNodeE)=-1)) then begin
        ReplaceCoordNode(Node, aNode);
        Result:=aNode;
        GlueFlag:=True;
        Break;
      end else
        inc(j)
    end else
      inc(j)
  end;

  for i:=0 to SpatialModel.Lines.Count-1 do begin
    aLineE:=SpatialModel.Lines.Item[i];
    if Node.Lines.IndexOf(aLineE)<>-1 then
      Continue;
    aLineS:=aLineE as ISpatialElement;
    if aLineS.Layer.Selectable then begin
      aLine:=aLineE as ILine;
      Distance:=aLine.DistanceFrom(Node.X, Node.Y, Node.Z, WX, WY, WZ, OrtBaseOnLine);
      if Distance<1 then begin
        aLineE.Draw(FPainter, -1);
        AddElement( aLineE.Parent,
                         SpatialModel.Lines, '', ltOneToMany, LineU, True);
        LineE:=LineU as IDMElement;
        ChangeFieldValue( LineE, ord(linC0), True, Node as IUnknown);
        ChangeFieldValue( LineE, ord(linC1), True, aLine.C1 as IUnknown);
        ChangeFieldValue( LineE, ord(linThickness), True, aLine.Thickness);
        ChangeFieldValue( LineE, ord(linStyle), True, aLine.Style);
        ChangeFieldValue( LineE, ord(linColor), True, aLineS.Color);

        ChangeFieldValue( aLineE, ord(linC1), True, Node as IUnknown);
        LineE.Draw(FPainter, 0);
        aLineE.Draw(FPainter, 0);

        DoNodeUpdateAreas(LineE, aLineE);

        GlueFlag:=True;
        Result:=Node;

        Break;
      end;
    end;
  end;

  if not GlueFlag then Exit;

  CheckDoubleLines(Node);
end;

procedure TCustomSMDocument.CheckDoubleLines(const Node:ICoordNode);
     function DoubleLine(const aLineE:IDMElement):IDMElement;
     var
       Line, aLine:ILine;
       LineE:IDMElement;
       j:integer;
       Node:ICoordNode;
     begin
       Result:=nil;
       aLine:=aLineE as ILine;
       for j:=0 to aLine.C0.Lines.Count-1 do begin
         LineE:=aLine.C0.Lines.Item[j];
         Line:=LineE as ILine;
         if Line.C0=aLine.C0 then
           Node:=Line.C1
         else
           Node:=Line.C0;
         if (Line<>aLine) and
           (aLine.C1=Node) then begin
           Result:=LineE;
           Exit;
         end;
       end;
     end;
var
  m, k:integer;
  aLineE, LineE, aParent:IDMElement;
  aLine:ILine;
begin
  m:=0;
  while m<Node.Lines.Count do begin
    aLineE:=Node.Lines.Item[m];
    LineE:=DoubleLine(aLineE);
    if LineE<>nil then begin
      aLineE.Selected:=False;
      aLine:=aLineE as ILine;

      for k:=aLineE.Parents.Count-1 downto 0 do begin
        aParent:=aLineE.Parents.Item[k];
        if LineE.Parents.IndexOf(aParent)=-1 then begin
          LineE.AddParent(aParent);
          aLineE.RemoveParent(aParent);
          UpdateElement(aParent);
        end;
      end;

      aLine.C0:=nil;
      aLine.C1:=nil;
//      ChangeFieldValue( aLineE, ord(linC0), True, NilUnk);
//      ChangeFieldValue( aLineE, ord(linC1), True, NilUnk);
      DeleteElement( nil, nil, ltOneToMany, aLineE);
      Exit;
    end else
      inc(m)
  end;

end;

function TCustomSMDocument.Get_OperationCode: Integer;
var
  CurrentOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  if FCurrentOperation<>nil then
    Result:=CurrentOperation.OperationCode
  else
   Result:=-1
end;

procedure TCustomSMDocument.StartOperation(aOperationCode: Integer);
var
  PrevOperation:TObject;
  CurrentOperation:TSMOperation;
begin
  PrevOperation:=FCurrentOperation;

  case aOperationCode of
  smoSelectAll:              FCurrentOperation:=TSelectAllOperation.Create(aOperationCode, Self);
  smoSelectLine:             FCurrentOperation:=TSelectLineOperation.Create(aOperationCode, Self);
  smoSelectVerticalLine:     FCurrentOperation:=TSelectVerticalLineOperation.Create(aOperationCode, Self);
  smoSelectClosedPolyLine:   FCurrentOperation:=TSelectClosedPolyLineOperation.Create(aOperationCode, Self);
  smoSelectImage:            FCurrentOperation:=TSelectImageOperation.Create(aOperationCode, Self);
  smoSelectLabel:            FCurrentOperation:=TSelectLabelOperation.Create(aOperationCode, Self);
  smoSelectCoordNode:        FCurrentOperation:=TSelectCoordNodeOperation.Create(aOperationCode, Self);
  smoSelectVerticalArea:     FCurrentOperation:=TSelectVerticalAreaOperation.Create(aOperationCode, Self);
  smoSelectVolume:           FCurrentOperation:=TSelectVolumeOperation.Create(aOperationCode, Self);
  smoCreateCoordNode:        FCurrentOperation:=TCreateCoordNodeOperation.Create(aOperationCode, Self);
  smoCreateLine:             FCurrentOperation:=TCreateLineOperation.Create(aOperationCode, Self);
  smoCreatePolyLine:         FCurrentOperation:=TCreatePolyLineOperation.Create(aOperationCode, Self);
  smoCreateClosedPolyLine:   FCurrentOperation:=TCreateClosedPolyLineOperation.Create(aOperationCode, Self);
  smoCreateRectangle:        FCurrentOperation:=TCreateRectangleOperation.Create(aOperationCode, Self);
  smoCreateInclinedRectangle:FCurrentOperation:=TCreateInclinedRectangleOperation.Create(aOperationCode, Self);
  smoCreateCurvedLine:       FCurrentOperation:=TCreateCurvedLineOperation.Create(aOperationCode, Self);
  smoCreateEllipse:          FCurrentOperation:=TCreateEllipseOperation.Create(aOperationCode, Self);
  smoCreateImageRect:        FCurrentOperation:=TCreateImageRectOperation.Create1(aOperationCode, FPictureFileName, Self);
  smoMoveSelected:           FCurrentOperation:=TMoveSelectedOperation.Create(aOperationCode, Self);
  smoScaleSelected:          FCurrentOperation:=TScaleSelectedOperation.Create(aOperationCode, Self);
  smoRotateSelected:         FCurrentOperation:=TRotateSelectedOperation.Create(aOperationCode, Self);
  smoDeleteSelected: begin
                             FCurrentOperation:=TDeleteSelectedOperation.Create(aOperationCode, Self);
                             DoOperationStep(0);
                     end;
  smoBreakLine:              FCurrentOperation:=TBreakLineOperation.Create(aOperationCode, Self);
  smoDoubleBreakLine:        FCurrentOperation:=TDoubleBreakLineOperation.Create(aOperationCode, Self);
  smoTrimExtendToSelected:   FCurrentOperation:=TTrimExtendToSelectedOperation.Create(aOperationCode, Self);
  smoBuildRelief:            FCurrentOperation:=TBuildReliefOperation.Create(aOperationCode, Self);
  smoOutlineSelected:        FCurrentOperation:=TOutlineSelectedOperation.Create(aOperationCode, Self);
  smoIntersectSelected:      FCurrentOperation:=TIntersectSelectedOperation.Create(aOperationCode, Self);
  smoZoomIn:                 FCurrentOperation:=TZoomInOperation.Create1(aOperationCode, Self, FOperationStep);
  smoZoomOut:                FCurrentOperation:=TZoomOutOperation.Create1(aOperationCode, Self, FOperationStep);
  smoViewPan:                FCurrentOperation:=TViewPanOperation.Create1(aOperationCode, Self, FOperationStep);
  smoBuildVolume:            FCurrentOperation:=TBuildFMVolumeOperation.Create(aOperationCode, Self);
  smoBuildVerticalArea:      FCurrentOperation:=TBuildVerticalAreaOperation.Create(aOperationCode, Self);
  smoDivideVolume:           FCurrentOperation:=TDivideVolumeOperation.Create(aOperationCode, Self);
  smoBuildLineObject:        FCurrentOperation:=TBuildLineObjectOperation.Create(aOperationCode, Self);
  smoBuildArrayObject:       FCurrentOperation:=TBuildArrayObjectOperation.Create(aOperationCode, Self);
  smoBuildPolylineObject:    FCurrentOperation:=TBuildPolylineObjectOperation.Create(aOperationCode, Self);
  smoBuildArea:              FCurrentOperation:=TBuildAreaOperation.Create(aOperationCode, Self);
  smoMirrorSelected:         FCurrentOperation:=TMirrorSelectedOperation.Create(aOperationCode, Self);
  smoCreateCircle:           FCurrentOperation:=TCreateCircleOperation.Create(aOperationCode, Self);
  end;

  case aOperationCode of
  smoSelectAll,
  smoSelectLine,
  smoSelectVerticalLine,
  smoSelectClosedPolyLine,
  smoSelectCoordNode,
  smoSelectVerticalArea,
  smoSelectVolume,
  smoCreateCoordNode,
  smoCreateLine,
  smoCreatePolyLine,
  smoCreateClosedPolyLine,
  smoCreateRectangle,
  smoCreateInclinedRectangle,
  smoCreateCurvedLine,
  smoCreateEllipse,
  smoBuildVolume,
  smoBuildVerticalArea,
  smoBuildLineObject,
  smoBuildArrayObject,
  smoBuildPolylineObject,
  smoMoveSelected,
  smoScaleSelected,
  smoRotateSelected,
  smoBreakLine,
  smoDoubleBreakLine,
  smoTrimExtendToSelected,
  smoOutlineSelected,
  smoIntersectSelected,
  smoMirrorSelected,
  smoCreateCircle:
   begin
      PrevOperation.Free;
      FLastOperation:=FCurrentOperation;
      FLastViewMode:=0;
      case aOperationCode of
      smoSelectAll,
      smoSelectLine,
      smoSelectVerticalLine,
      smoSelectClosedPolyLine,
      smoSelectCoordNode,
      smoSelectVerticalArea,
      smoSelectVolume:
        begin
          CurrentOperation:=TSMOperation(FCurrentOperation);
          FPrevSelectOperationClassType:=CurrentOperation.ClassType;
          FPrevSelectOperationCode:=CurrentOperation.OperationCode;
        end;
      end;
    end;
  else
    inc(FLastViewMode);
  end;

  Get_Server.OperationStepExecuted;   //сообщение серверу о начале операции

end;

procedure TCustomSMDocument.RestoreView;
var
  TMPView:IView;
  OldState:integer;
begin
  OldState:=Get_State;
  Set_State(OldState or dmfCommiting);
  try
    TMPView:=((Get_DataModel as ISpatialModel2).Views as IDMCollection2).CreateElement(False) as IView;
    TMPView.Duplicate(FPainter.View);
  finally
    Set_State(OldState);
  end;

  FPainter.View.Duplicate(FLastView);

  Set_State(OldState or dmfCommiting);
  try
    FLastView.Duplicate(TMPView);
  finally
    Set_State(OldState);
  end;
end;

procedure TCustomSMDocument.Set_DataModel(const Value: IUnknown);
var
  OldState:integer;
  SpatialModel2:ISpatialModel2;
  SpatialModel:ISpatialModel;
  Views2:IDMCollection2;
begin
  inherited;
  if Value<>nil then begin
    OldState:=Get_State;
    Set_State(OldState or dmfCommiting);
    try
    SpatialModel:=Value as ISpatialModel;
    SpatialModel2:=Value as ISpatialModel2;
    Views2:=SpatialModel2.Views as IDMCollection2;
    FLastView:=Views2.CreateElement(False) as IView;
{    if (FPainter<>nil) and
       (FPainter.View<>nil) then
      FLastView.Duplicate(FPainter.View);
}
    finally
      Set_State(OldState);
    end;
  end;
end;

destructor TCustomSMDocument.Destroy;
begin
  FState:=FState or dmfDestroying;
  inherited;
  FLastView:=nil;
  ClearSelectedAreas;
  ClearPrevSelectedAreas;
  FSelectedAreaList.Free;
  FPrevSelectedAreaList.Free;
end;

procedure TCustomSMDocument.Select(const aElementU: IUnknown);
var
  FirstElement:IDMElement;
  aElement: IDMElement;
begin
  aElement:=aElementU as IDMElement;
  if Get_SelectionCount>0 then begin
    FirstElement:=Get_SelectionItem(0) as IDMElement;
    if (FirstElement.Ref<>aElement) and
       (FirstElement<>aElement.Ref) and
       ((FirstElement.Ref=nil) or
        (FirstElement.Ref<>aElement.Ref)) and
       (FirstElement.OwnerCollection<>nil) and
        not FirstElement.CompartibleWith(aElement) then
//      (not (FirstElement.OwnerCollection as IDMCollection2).CanContain(aElement)) and
//       (not (aElement.OwnerCollection as IDMCollection2).CanContain(FirstElement)) then begin
      ClearSelection(nil);
  end;

  inherited;
end;

function TCustomSMDocument.ReorderLines(
  const aCollection: IDMCollection): Integer;
var
  Line:ILine;
  aList:TList;
  j:integer;
  StartCoord, EndCoord:ICoordNode;
begin
  Result:=0;
  if aCollection.Count=0 then Exit;

  aList:=TList.Create;
  Line:=aCollection.Item[0] as ILine;
  StartCoord:=Line.C0;
  EndCoord:=Line.C1;
  aList.Add(pointer(aCollection.Item[0]));
  (aCollection as IDMCollection2).Delete(0);

  while aCollection.Count>0 do begin
    j:=0;
    while j<aCollection.Count do begin
      Line:=aCollection.Item[j] as ILine;
      if (Line.C0<>StartCoord) and
         (Line.C1<>StartCoord) and
         (Line.C0<>EndCoord) and
         (Line.C1<>EndCoord) then
        inc(j)
      else
        Break;
    end;
    if j<aCollection.Count then begin
      if Line.C0=StartCoord then
        StartCoord:=Line.C1
      else
      if Line.C1=StartCoord then
        StartCoord:=Line.C0
      else
      if Line.C0=EndCoord then
        EndCoord:=Line.C1
      else if Line.C1=EndCoord then
        EndCoord:=Line.C0;
      aList.Add(pointer(aCollection.Item[j]));
      (aCollection as IDMCollection2).Delete(j);
    end else
      Break;
  end;

  if aCollection.Count>0 then
    Result:=0
  else if StartCoord<>EndCoord then
    Result:=1
  else
    Result:=2;

  for j:=0 to aList.Count-1 do
    (aCollection as IDMCollection2).Add(IDMElement(aList[j]));
  aList.Free;
end;

function TCustomSMDocument.UpdateAreas(const Element: IDMElement):WordBool;
var
  Node:ICoordNode;
  Line:ILine;
begin
  Result:=False;
  if Element.QueryInterface(ICoordNode, Node)=0 then
    NodeUpdateAreas(Node)
  else
  if Element.QueryInterface(ILine, Line)=0 then
    Result:=LineUpdateAreas(Line)
end;

function  TCustomSMDocument.Crossing_Node(Node1X: Double; Node1Y: Double; Node2X: Double; Node2Y: Double;
                            Node3X: Double; Node3Y: Double; Node4X: Double; Node4Y: Double; 
                            out x: Double; out y: Double): WordBool;
// Result=True -пересечение есть
var
   X1,Y1,X2,Y2,X3,Y3,X4,Y4,dX12,dY12,dX34,dY34,d12,d34:double;
   a,b:double;
   dx1,dy1,X1n,Lx1:double;
   dx2,dy2,X2n,Lx2:double;

   function CoordConvert(dXi,dYi,dX,dY:double; var Lx0:double):double;
   begin
     Lx0:=(Trunc((Sqrt(dX*dX+dY*dY))*100))/100;
     Result:=(Trunc(((dX/Lx0)*dXi+(dY/Lx0)*dYi)*100))/100;
   end;

begin  { function Crossing __________________________________________}

   if Node1X>Node2X then begin
     X1:=Node2X;
     Y1:=Node2Y;
     X2:=Node1X;
     Y2:=Node1Y
    end
    else begin
     X1:=Node1X;
     Y1:=Node1Y;
     X2:=Node2X;
     Y2:=Node2Y
    end;

   if Node3X>Node4X then begin
     X3:=Node4X;
     Y3:=Node4Y;
     X4:=Node3X;
     Y4:=Node3Y
    end
    else begin
     X3:=Node3X;
     Y3:=Node3Y;
     X4:=Node4X;
     Y4:=Node4Y
    end;

    dX12:=X2-X1;
    dY12:=Y2-Y1;

    dX34:=X4-X3;
    dY34:=Y4-Y3;

    d12:=dX12/dY12;
    d34:=dX34/dY34;

    dX12:=abs(dX12);
    dX34:=abs(dX34);

    if d12=d34 then   //паралл.
     if (dX12=0)or(dX34=0)then
     begin  //верт.
       a:= x3;    // здесь a -это x на векторе 2 в точке x3
       b:= x1;
       if a=b then
       begin
        x:=x3;
        y:=y3
       end
       else
       begin
        x:=99.99E99;
        y:=99.99E99
       end
     end   //верт.
     else
     begin                 //наклон или горизонт.(не верт.)
       a := y3-x3*(1/d34); // здесь b это y на векторе 1 в точке x3
       b:= y1-x1*(1/d12);
       if a=b then
       begin
        if x1<=x3 then
        begin
         x:=x4;
         y:=y4
        end
        else
        begin
         x:=x1;
         y:=y1
        end
       end
       else
       begin
        x:=99.99E99;
        y:=99.99E99
       end
    end
    else       //не паралл.
     if (dY12=0)or(dY34=0)then  //горизонт. 1 или 2
      if (dY12=0) then
      begin   //горизонт. 1
       y:=y1;
       x:=(y-y3)*d34+x3
      end
      else
      begin   //горизонт. 2
       y:=y3;
       x:=(y-y1)*d12+x1
      end
     else
     begin   //наклон
      y:=(y1*d12-y3*d34-x1+x3)/(d12-d34);
      x:=(y-y1)*d12+x1;
     end;

    dx1:=(x-x1);
    dy1:=(y-y1);
    X1n:=CoordConvert(dx1,dy1,dX12,dY12,Lx1);

    dx2:=(x-x3);
    dy2:=(y-y3);
    X2n:=CoordConvert(dx2,dy2,dX34,dY34,Lx2);
// если Result=True -пересечение есть
    Result:=(((X1n=0)or(X1n=Lx1))and((X2n>0)and(X2n<Lx2)))
             or(((X1n>0)and(X1n<Lx1))and((X2n>0)and(X2n<Lx2)))
             or(((X2n=0)or(X2n=Lx2))and((X1n>0)and(X1n<Lx1)));
//___________________________
end; { function Crossing ________________________________________ __}

function TCustomSMDocument.LineIsInternalCheck(const Area:IArea;const Line:ILine;
                                                  out Stat:integer):boolean;
  (*Stat=0, result=True -линия внутр.[число пересечений Area c вектором из ее центра
   -нечетное],иначе внешняя [result=False]. Если линия в двух облaстях (пересекается
   с одной из линией Area) result=True, Stat=-1.
   *)
var
   aCollection:IDMCollection;
   aCount:integer;
   i,kC:integer;
   aLine:ILine;
   x0,y0, x1,y1,x,y:double;
   P1x,P1Y,P2X,P2Y:double;
begin


   aCollection:=Area.BottomLines;
   aCount:=aCollection.Count;
   x0:=Line.C0.X;
   y0:=Line.C0.Y;
   x1:=Line.C1.X;
   y1:=Line.C1.Y;
   for i:=0 to aCount-1 do
   begin
    aLine:=(aCollection.Item[i]) as ILine;
    P1X:=aLine.C0.X;         //пересекается c другими ?
    P1Y:=aLine.C0.Y;
    P2X:=aLine.C1.X;
    P2Y:=aLine.C1.Y;
    if Crossing_Node(x0,y0, x1,y1, P1X,P1Y, P2X,P2Y,x,y) then begin
     Stat:=-1;      //линия в двух облaстях
     result:=True;
     Exit;
    end;
   end;

   Stat:=0;         //линия корректна

   P1x:=Line.C0.X;
   P2x:=Line.C1.X;
   if P1x<>P2x then begin
     x0:=(P1x+P2x)/2;
     y0:=(Line.C0.Y + Line.C1.Y)/2;
     x1:=x0+1000;    //~вертикаль x0-x1 (смещ.)
     y1:=1.E12;
   end else begin
     x1:=1.E12;      //~горизонталь x0-x1 (смещ.)
     y1:=y0+1000;
   end;

   kC:=0;          //число пересечений
   for i:=0 to aCount-1 do
   begin
     aLine:=(aCollection.Item[i]) as ILine;
     P1X:=aLine.C0.X;
     P1Y:=aLine.C0.Y;
     P2X:=aLine.C1.X;
     P2Y:=aLine.C1.Y;

     if Crossing_Node(x0,y0, x1,y1, P1X,P1Y, P2X,P2Y,x,y) then
      kC:=kC+1;
   end;

   if (kC div 2)=(kC/2) then
     result:=False      // линия внешняя
   else
     result:=True;      // линия внутр.[число пересечений -нечетное]

end;
//__________________________________
function TCustomSMDocument.LineAddAreas(const Area: IArea;
                const Line: ILine):IArea;
var
 aCollection:IDMCollection;
 C0, C1:ICoordNode;
 aLine, aLine1, aLine2:ILine;
 aLineE:IDMElement;
 j,aCount:integer;
 aAreaE:IDMElement;
 aList:TList;

 function BuildPolyLine(const Line, Line1: ILine; out List:TList):boolean;
 var
  C0, C1:ICoordNode;
  j,k:integer;
  InFlag:boolean;
  x0,y0:double;

  function IsInterLineCheck(x0,y0:double;Line:ILine):boolean;
  var
   aLine:ILine;
   x1,y1, x,y,dx,dy:double;
   P1x,P1Y,P2X,P2Y:double;
   Hmax,Hi,H:double;
   i:integer;
  begin
   dx:=((Line.C0.X+Line.C1.X)/2)-x0;
   dy:=((Line.C0.Y+Line.C1.Y)/2)-y0;

   if dy>0 then
    y1:=1E12
   else
    if dy=0 then
     y1:=y0
    else
     y1:=-1E12;

   x1:=x0+(dx/dy)*(y1-y0);       //x0,y0-x1,y1  -секущая

   Hmax:=0;
   H:=0;
   for i:=0 to aCount-1 do begin
    aLine:=(aCollection.Item[i]) as ILine;
     P1X:=aLine.C0.X;
     P1Y:=aLine.C0.Y;
     P2X:=aLine.C1.X;
     P2Y:=aLine.C1.Y;
     if Crossing_Node(x0,y0, x1,y1, P1X,P1Y, P2X,P2Y,x,y) then begin
      Hi:=(x-x0)*(x-x0)+(y-y0)*(y-y0);      //кв.расстояния до тек.пересечения
      if Hi>Hmax then
       Hmax:=Hi;
      if aLine=Line then
       H:=Hi;                  //кв.расстояния до пересечения с контр.линией
    end;
   end;

   if H<Hmax then
    result:=True             //если контр.линия ближе max H
   else
    result:=False;

  end;

 begin
  x0:=(Line.C0.X + Line.C1.X)/2;
  y0:=(Line.C0.Y + Line.C1.Y)/2;

  if aList=nil then
   List:=TList.Create
  else
   List.Clear;

  List.Add(pointer(Line));
  List.Add(pointer(Line1));

  if (Line1.C0=Line.C0)or(Line1.C0=Line.C1) then begin
   C0:=Line1.C1;
  end else begin
   C0:=Line1.C0;
  end;

  if (Line1.C0=Line.C0)or(Line1.C1=Line.C0) then
   C1:=Line.C1
  else
   C1:=Line.C0;


  result:=False;
  for j:=0 to aCount-1 do begin
   aLine:=(aCollection.Item[j]) as ILine;
   if aLine=Line1 then
    break;
   end;
  InFlag:=True;
  k:=0;
  while (j<aCount)and(j>0)and(not result)and(k<aCount) do begin
   if InFlag then      //вперед
    if j<aCount-1 then
     inc(j)
    else
     j:=0
   else               //назад
    if j>0 then
     dec(j)
    else
     j:=aCount-1;
   aLine:=(aCollection.Item[j]) as ILine;
   if (aLine.C0=C0)or(aLine.C1=C0) then begin
    if IsInterLineCheck(x0,y0,aLine) then begin
     aList.Add(pointer(aLine));
     inc(k);
     if aLine.C0=C0 then
      C0:=aLine.C1
     else
      C0:=aLine.C0;
     if (C0=C1)then
      result:=True;
    end else
     break;
   end else
     if InFlag then begin
      InFlag:=False;
      dec(j);
     end else begin
      InFlag:=True;
      inc(j);
     end;
  end;
 end;

begin
 result:=nil;
 C0:=Line.C0;
 C1:=Line.C1;
 aCollection:=Area.BottomLines;
 aCount:=aCollection.Count;
//..........................
 for j:=0 to aCount-2 do begin               //? линии, имеющие общий узел C0
  aLine:=(aCollection.Item[j]) as ILine;
  if (aLine.C0=C0)or(aLine.C1=C0) then begin
   aLine1:=aLine;
   if j=0 then begin
    aLine:=(aCollection.Item[1]) as ILine;
    if (aLine.C0=C0)or(aLine.C1=C0) then
     aLine2:=aLine
    else
     aLine2:=(aCollection.Item[aCount-1]) as ILine;
    break;
   end else begin
    aLine2:=(aCollection.Item[j+1]) as ILine;
    break;
   end;
  end;
 end;

 aLine:=aLine1;
 if not BuildPolyLine(Line,aLine,aList)then begin
  aLine:=aLine2;
  if not BuildPolyLine(Line,aLine,aList) then Exit;
 end;
 aLineE:=aLine as IDMElement;

 aAreaE:=((Get_DataModel as ISpatialModel2).Areas as IDMCollection2).
                          CreateElement(True);   //) as IDMElement ;

 for j:=1 to aList.Count-1 do begin            //кроме 1-й (разделяющей)
  aLineE:=ILine(aList.items[j]) as IDMElement;
  AddElementParent( aAreaE, aLineE);
 end;

 result:=aAreaE as IArea;

//....................
 aList.Free;
end;

function TCustomSMDocument.LineUpdateAreas(const Line: ILine):WordBool;
var
  aArea:IArea;
  aAreaE:IDMElement;
  aNewAreaE:IDMElement;
  C0, C1:ICoordNode;
begin
  Result:=False;
  C0:=Line.C0;
  C1:=Line.C1;

  aArea :=AreaWithInternalNode(C0, C1, nil,2, False);

  if aArea<>nil then begin
    Result:=True;
    aAreaE:=aArea as IDMElement;
    aNewAreaE:= LineDivideArea(C0, C1, aArea) as IDMElement;
    (Line as IDMElement).AddParent(aNewAreaE);
    (Line as IDMElement).AddParent(aAreaE);

    UpdateElement( aNewAreaE);
    UpdateElement( aAreaE);
    UpdateCoords( aNewAreaE);
    UpdateCoords( aAreaE);

    if aArea.Volume0<>nil then
      UpdateElement( aArea.Volume0 as IDMElement);
    if aArea.Volume1<>nil then
      UpdateElement( aArea.Volume1 as IDMElement);
  end;
end;

procedure TCustomSMDocument.IntersectHLine(const HLinesCol:IDMCollection);
  var
  C0, C1, theC0, theC1:ICoordNode;
  X0, Y0, Z0, X1, Y1, Z1, theX0, theY0, theZ0, theX1, theY1, theZ1:double;
  j,k,l,aLCount, j0, j1, m0, m1, m:integer;
  aLines, theLines:IDMCollection;
  theLines2:IDMCollection2;
  aSpatialModel:ISpatialModel;
  aLine, LineNew, aLineNew, theLine:ILine;
  PX,PY,PZ:double;
  NodeNewU:IUnknown;
  LineNewU, aLineNewU:IUnknown;
  CNewE:IDMElement;
  CNew:ICoordNode;
  LineNewE, aLineNewE, Line0E, Line1E, Area0E, Area1E, theLineE, aLineE:IDMElement;
  Area0, Area1:IArea;
  aParent, aElement:IDMElement;
  Volume:IVolume;
  AreaP:IPolyline;
  DataModel:IDataModel;
begin
  DataModel:=Get_DataModel as IDataModel;
  aSpatialModel:=DataModel as ISpatialModel;
  aLines:=DataModel.CreateCollection(-1, nil);
  aLineE:=HLinesCol.Item[0];
  aLine:=aLineE as ILine;
  C0:=aLine.C0;
  C1:=aLine.C1;
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Z;

  Volume:=nil;
  Area0:=nil;
  j0:=0;
  while j0<C0.Lines.Count do begin
    Line0E:=C0.Lines.Item[j0];
    if Line0E=aLineE then begin
      inc(j0);
      Continue;
    end;
    m0:=0;
    while m0<Line0E.Parents.Count do begin
      Area0E:=Line0E.Parents.Item[m0];
      if (Area0E.QueryInterface(IArea, Area0)=0) and
          not Area0.IsVertical then begin

        j1:=0;
        while j1<C1.Lines.Count do begin
          Line1E:=C1.Lines.Item[j1];
          if Line1E=aLineE then begin
            inc(j1);
            Continue;
          end;
          m1:=0;
          while m1<Line1E.Parents.Count do begin
            Area1E:=Line1E.Parents.Item[m1];
            if (Area1E.QueryInterface(IArea, Area1)=0) and
                not Area1.IsVertical then begin
              if (Area0.Volume0<>nil) and
                 ((Area0.Volume0=Area1.Volume1) or
                  (Area0.Volume0=Area1.Volume0)) then
                Volume:=Area0.Volume0
              else
              if (Area0.Volume1<>nil) and
                 ((Area0.Volume1=Area1.Volume1) or
                  (Area0.Volume1=Area1.Volume0)) then
                Volume:=Area0.Volume1;
              if Volume<>nil then
                Break
              else
                inc(m1);
            end else
              inc(m1);
          end; //while m1<Line0E.Parents.Count
          if Volume<>nil then
            Break
          else
            inc(j1);
        end;  //while j1<C1.Lines.Count
        if Volume<>nil then
          Break
        else
          inc(m0);
      end else
        inc(m0);
    end; //while m0<Line0E.Parents.Count
    if Volume<>nil then
      Break
    else
      inc(j0);
  end;  //while j0<C0.Lines.Count

  if Volume=nil then Exit;

  theLines:=DataModel.CreateCollection(-1, nil);
  theLines2:=theLines as IDMCollection2;

  for j:=0 to Volume.Areas.Count-1 do begin
    AreaP:=Volume.Areas.Item[j] as IPolyline;
    for m:=0 to AreaP.Lines.Count-1 do begin
      theLineE:=AreaP.Lines.Item[m];
      if theLines.IndexOf(theLineE)=-1 then
        theLines2.Add(theLineE);
    end;
  end;

  for l:=0 to theLines.Count-1 do begin
    theLineE:=theLines.Item[l];
    theLine:=theLineE as ILine;
    theC0:=theLine.C0;
    theC1:=theLine.C1;
    theX0:=theC0.X;
    theY0:=theC0.Y;
    theZ0:=theC0.Z;
    theX1:=theC1.X;
    theY1:=theC1.Y;
    theZ1:=theC1.Z;

    if (LineIntersectLine(X0,Y0,Z0, X1,Y1,Z1,
                          theX0,theY0,theZ0, theX1,theY1,theZ1,
                          PX,PY,PZ))and
       (theC0<>C0)and(theC1<>C0)and(theC0<>C1)and(theC1<>C1) then
      if not(((X0=PX)and(Y0=PY)and(Z0=PZ))or
             ((X1=PX)and(Y1=PY)and(Z1=PZ)))then
             (aLines as IDMCollection2).Add(theLineE);
  end;


  aLCount:=aLines.Count;
  for l:=0 to aLCount-1 do begin
    theLineE:=aLines.Item[l];
    theLine:=theLineE as ILine;
    theC0:=theLine.C0;
    theC1:=theLine.C1;
    theX0:=theC0.X;
    theY0:=theC0.Y;
    theZ0:=theC0.Z;
    theX1:=theC1.X;
    theY1:=theC1.Y;
    theZ1:=theC1.Z;

    for k:=0 to HLinesCol.Count-1 do begin
      aLineE:=HLinesCol.Item[k];
      aLine:=aLineE as ILine;
      C0:=aLine.C0;
      C1:=aLine.C1;
      X0:=C0.X;
      Y0:=C0.Y;
      Z0:=C0.Z;
      X1:=C1.X;
      Y1:=C1.Y;
      Z1:=C1.Z;
      if LineIntersectLine(
          X0,Y0,Z0, X1,Y1,Z1,
          theX0,theY0,theZ0, theX1,theY1,theZ1,
          PX,PY,PZ) then begin
             //Создание узла
        AddElement( HLinesCol.Item[k].Parent,
                         aSpatialModel.CoordNodes, '', ltOneToMany, NodeNewU, True);
        CNewE:=NodeNewU as IDMElement;
        CNew:=CNewE as ICoordNode;
        ChangeFieldValue( CNewE, ord(cooX), True, PX);
        ChangeFieldValue( CNewE, ord(cooY), True, PY);
        ChangeFieldValue( CNewE, ord(cooZ), True, PZ);

             //Создание линии
        AddElement( HLinesCol.Item[k].Parent,
                           aSpatialModel.Lines, '', ltOneToMany, LineNewU, True);
        LineNewE:=LineNewU as IDMElement;
        ChangeFieldValue( LineNewE, ord(linThickness), True, (HLinesCol.Item[k] as ILine).Thickness);
        ChangeFieldValue( LineNewE, ord(linStyle), True, (HLinesCol.Item[k] as ILine).Style);
        ChangeFieldValue( LineNewE, ord(linColor), True, (HLinesCol.Item[k] as ISpatialElement).Color);
        ChangeFieldValue( LineNewE, ord(linC0), True, CNew as IUnknown);
        ChangeFieldValue( LineNewE, ord(linC1), True, (HLinesCol.Item[k] as ILine).C1 as IUnknown);
        LineNew:=LineNewE as ILine;

        ChangeFieldValue( HLinesCol.Item[k], ord(linC1), True, CNewE as IUnknown);

             //Создание линии

        AddElement( aLines.Item[l].Parent,
                           aSpatialModel.Lines, '', ltOneToMany, aLineNewU, True);
        aLineNewE:=aLineNewU as IDMElement;
        ChangeFieldValue( aLineNewE, ord(linThickness), True, (aLines.Item[l] as ILine).Thickness);
        ChangeFieldValue( aLineNewE, ord(linStyle), True, (aLines.Item[l] as ILine).Style);
        ChangeFieldValue( aLineNewE, ord(linColor), True, (aLines.Item[l] as ISpatialElement).Color);
        ChangeFieldValue( aLineNewE, ord(linC0), True, CNew as IUnknown);
        ChangeFieldValue( aLineNewE, ord(linC1), True, (aLines.Item[l] as ILine).C1 as IUnknown);
        aLineNew:=aLineNewE as ILine;
        if aLineNew<>nil then begin
          for j:=0 to aLines.Item[l].Parents.Count-1 do begin
              aParent:=aLines.Item[l].Parents.Item[j];
              aLineNewE.AddParent(aParent);
          end;
        end;

        ChangeFieldValue(aLines.Item[l], ord(linC1), True, CNew as IUnknown);

        (aLines as IDMCollection2).Add(aLineNew as IDMElement);
        (HLinesCol as IDMCollection2).Add(LineNew as IDMElement);
      end;  // if LineIntersectLine
    end;  // for k:=0 to HLinesCol.Count-1
  end;  // for l:=0 to aLCount-1
  
  for l:=0 to aLines.Count-1 do begin
    for k:=0 to aLines.Item[l].Parents.Count-1 do begin
      aElement:=aLines.Item[l].Parents.Item[k];
      UpdateElement(aElement);
      UpdateCoords(aElement);
    end;
  end;
end;

function TCustomSMDocument.AreaWithNodes(const C0, C1:ICoordNode):IArea;
var
  Line1,  Line2,  Line3: ILine;
  Line1E, Line2E, Line3E:IDMElement;
  aArea:IArea;
  aAreaE:IDMElement;
  j0, j01, j1, j2, i0, i1:integer;
  Found:boolean;
begin
  aArea:=nil;
  Found:=False;


  j0:=0;
  while (j0<C0.Lines.Count) and not Found do begin
    Line1E:=C0.Lines.Item[j0];
    Line1:=Line1E as ILine;
    j1:=0;
    while (j1<Line1E.Parents.Count) and not Found do begin
      aAreaE:=Line1E.Parents.Item[j1];
      if (aAreaE.QueryInterface(IArea, aArea)=0) and
         ((aAreaE as IPolyLine).Lines.Count>1)
       { and(LineE.Parents.IndexOf(aAreaE)=-1) } then begin
        j01:=j0+1;
        while (j01<C0.Lines.Count) and not Found do begin
          Line2E:=C0.Lines.Item[j01];
          Line2:=Line2E as ILine;
          j2:=0;
          while (j2<Line2E.Parents.Count) and not Found do begin
            if aAreaE=Line2E.Parents.Item[j2] then begin
              i0:=0;
              while (i0<C1.Lines.Count) and not Found do begin
                Line3E:=C1.Lines.Item[i0];
                Line3:=Line3E as ILine;
                i1:=0;
                while (i1<Line3E.Parents.Count) and not Found do begin
                  if aAreaE=Line3E.Parents.Item[i1] then
                    Found:=True;
                  inc(i1);
                end;
                inc(i0);
              end;
            end;
            inc(j2);
          end;
          inc(j01);
        end;
      end;
      inc(j1);
    end;
    inc(j0);
  end;

  if Found then
   result:=aArea
  else
   result:=nil;
end;
//---------------
procedure TCustomSMDocument.NodeUpdateAreas(const Node: ICoordNode);
var
  Line0E, Line1E:IDMElement;
begin
  Line0E:=Node.Lines.Item[0];    // новый участок линии

  Line1E:=Node.Lines.Item[1];   // поделенная линия
  DoNodeUpdateAreas(Line0E, Line1E)
end;


procedure TCustomSMDocument.DoNodeUpdateAreas(const Line0E, Line1E:IDMElement);
var
  Line0, Line1, aaLine:ILine;
  j, m:integer;
  aPolyLine:IPolyLine;
  aAreaE, aElement:IDMElement;
  Lines:IDMCollection;
begin
  Line0:=Line0E as ILine;
  Line1:=Line1E as ILine;
  for j:=0 to Line1E.Parents.Count-1 do begin
    aElement:=Line1E.Parents.Item[j];
    if aElement.QueryInterface(IPolyline, aPolyline)=0 then
      Lines:=aPolyLine.Lines
    else
    if aElement.QueryInterface(ILineGroup, aPolyline)=0 then
      Lines:=aPolyLine.Lines
    else
      Lines:=nil;

    if Lines<>nil then begin
      m:=aPolyLine.Lines.IndexOf(Line1E);
      if m=aPolyLine.Lines.Count-1 then begin
        aaLine:=aPolyLine.Lines.Item[m-1] as ILine;
        if (aaLine.C0=Line1.C0) or
           (aaLine.C1=Line1.C0) then
          inc(m);
      end else begin
        aaLine:=aPolyLine.Lines.Item[m+1] as ILine;
        if (aaLine.C0=Line1.C0) or
           (aaLine.C1=Line1.C0) then
        else
          inc(m);
      end;

      Line0E.AddParent(aPolyLine as IDMElement); // вставка нового участке в Area

      MoveElement( aPolyLine.Lines,
                                 Line0E, m, False);
    end;
  end;  
  for j:=0 to Line0E.Parents.Count-1 do begin
    aAreaE:=Line0E.Parents.Item[j];
    UpdateElement( aAreaE);
  end;
  for j:=0 to Line1E.Parents.Count-1 do begin
    aAreaE:=Line1E.Parents.Item[j];
    UpdateElement( aAreaE);
  end;
end;

procedure TCustomSMDocument.CalcSelectionLimits(out MinX, MinY, MinZ, MaxX, MaxY,
  MaxZ: Double);
  procedure  Compare(const Node:ICoordNode);
  begin
    if Node=nil then Exit;
    
    if MinX>Node.X then
      MinX:=Node.X;
    if MaxX<Node.X then
      MaxX:=Node.X;

    if MinY>Node.Y then
      MinY:=Node.Y;
    if MaxY<Node.Y then
      MaxY:=Node.Y;

    if MinZ>Node.Z then
      MinZ:=Node.Z;
    if MaxZ<Node.Z then
      MaxZ:=Node.Z;
  end;

var
  j, m, k:integer;
  Line:ILine;
  Node:ICoordNode;
  Polyline:IPolyline;
  Volume:IVolume;
  Element:IDMElement;
begin
  if Get_SelectionCount=0 then begin
    MinX:=Get_CurrX;
    MinY:=Get_CurrY;
    MinZ:=Get_CurrZ;
    MaxX:=MinX;
    MaxY:=MinY;
    MaxZ:=MinZ;
    Exit;
  end;
  MinX:=InfinitValue;
  MinY:=InfinitValue;
  MinZ:=InfinitValue;
  MaxX:=-InfinitValue;
  MaxY:=-InfinitValue;
  MaxZ:=-InfinitValue;
  for j:=0 to Get_SelectionCount-1 do begin
    Element:=Get_SelectionItem(j) as IDMElement;
    if Element.QueryInterface(ICoordNode, Node)=0 then
      Compare(Node)
    else
    if Element.QueryInterface(ILine, Line)=0 then begin
      Compare(Line.C0);
      Compare(Line.C1);
    end else
    if Element.QueryInterface(IPolyLine, PolyLine)=0 then
      for m:=0 to PolyLine.Lines.Count-1 do begin
        Line:=PolyLine.Lines.Item[m] as ILine;
        Compare(Line.C0);
        Compare(Line.C1);
      end
    else
    if Element.QueryInterface(IVolume, Volume)=0 then
      for k:=0 to Volume.Areas.Count-1 do begin
        Polyline:=Volume.Areas.Item[k] as IPolyline;
        for m:=0 to PolyLine.Lines.Count-1 do begin
          Line:=PolyLine.Lines.Item[m] as ILine;
          Compare(Line.C0);
          Compare(Line.C1);
        end;
      end
  end;
end;

function TCustomSMDocument.Get_PictureFileName: WideString;
begin
  Result:=FPictureFileName
end;

procedure TCustomSMDocument.Set_PictureFileName(const Value: WideString);
begin
  FPictureFileName:=Value
end;

procedure TCustomSMDocument.JoinAreas(const aArea0, aArea1:IArea; const Line:ILine;
                    Index:integer;
                    const DMCollection:IDMCollection;
                    const UpdateElementCollection:IDMCollection);

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
  Area0, Area1:IArea;
  Area0P, Area1P:IPolyline;
  aLineE, LineE, Area0E, Area1E:IDMElement;
  Volume0E, Volume1E:IDMElement;
  n:integer;
  DeleteAreaFlag:boolean;
begin
  Area0:=aArea0;
  Area1:=aArea1;
  Area0E:=aArea0 as IDMElement;
  Area1E:=aArea1 as IDMElement;
{
  if (Area0.Volume0<>nil) and
     ((Area0.Volume0 as IDMElement).Ref=nil) then Exit;
  if (Area0.Volume1<>nil) and
     ((Area0.Volume1 as IDMElement).Ref=nil) then Exit;
  if (Area1.Volume0<>nil) and
     ((Area1.Volume0 as IDMElement).Ref=nil) then Exit;
  if (Area1.Volume1<>nil) and
     ((Area1.Volume1 as IDMElement).Ref=nil) then Exit;
}
  if (DMCollection.IndexOf(Area0E)<>-1) then begin //удалаяем Area0E, но потом
    DeleteAreaFlag:=False;
  end else
  if (DMCollection.IndexOf(Area1E)<>-1) then begin
    Area0:=aArea1;
    Area1:=aArea0;
    Area0E:=Area0 as IDMElement;
    Area1E:=Area1 as IDMElement;
    DeleteAreaFlag:=False;
  end else begin
    if (Area0E.Ref<>nil) and
       (Area1E.Ref<>nil) and                  // ворота не должны заменять ограждение
       (Area0E.Ref.Ref.Parent.ID<Area1E.Ref.Ref.Parent.ID) then begin
      Area0:=aArea1;
      Area1:=aArea0;
      Area0E:=Area0 as IDMElement;
      Area1E:=Area1 as IDMElement;
    end;
    DeleteAreaFlag:=True;
  end;

  Area0P:=Area0 as IPolyline;
  Area1P:=Area1 as IPolyline;

  LineE:=Line as IDMElement;
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

  if DeleteAreaFlag then begin
    (DMCollection as IDMCollection2).Add(Area0E);
    if Area0E.Ref<>nil then
      Area0E.Ref.Draw(FPainter, -1)
    else
      Area0E.Draw(FPainter, -1);
  end;

  try
  if Area1E.Ref<>nil then
    Area1E.Ref.Draw(FPainter, -1)
  else
    Area1E.Draw(FPainter, -1);
  except
    raise
  end;

  if UpdateElementCollection.IndexOf(Area1E)=-1 then
    (UpdateElementCollection as IDMCollection2).Add(Area1E);

  if (Area0E.Ref<>nil) and
     (Area1E.Ref<>nil) then begin
    Area1E.Ref.JoinSpatialElements(Area0E.Ref)
  end;

  if Volume0E<>nil then
    UpdateElement( Volume0E);
  if Volume1E<>nil then
    UpdateElement( Volume1E);
end;

procedure  ReorderAreasToDeleteList(const DMCollection:IDMCollection);
var
  AreaList, VolumeList:TList;
  AreaE:IDMElement;
  DMCollection2:IDMCollection2;


  procedure ProcessArea(const AreaE:IDMElement);
  var
    Area:IArea;
    Volume0, Volume1:IVolume;

    procedure ProcessVolume(const Volume:IVolume);
    var
      j:integer;
      aAreaE:IDMElement;
      TMPList:TList;
    begin
      TMPList:=TList.Create;
      for j:=0 to Volume.Areas.Count-1 do begin
        aAreaE:=Volume.Areas.Item[j];
        if (AreaList.IndexOf(pointer(aAreaE))<>-1) then begin
          AreaList.Remove(pointer(aAreaE));
          DMCollection2.Add(aAreaE);
          TMPList.Add(pointer(aAreaE));
        end;
      end;
      for j:=0 to TMPList.Count-1 do begin
        aAreaE:=IDMElement(TMPList[j]);
        ProcessArea(aAreaE);
      end;
      TMPList.Free;
    end;

  begin
    Area:=AreaE as IArea;
    Volume0:=Area.Volume0;
    Volume1:=Area.Volume1;
    if Volume0<>nil then begin
      if VolumeList.IndexOf(pointer(Volume0))=-1 then begin
        VolumeList.Add(pointer(Volume0));
        ProcessVolume(Volume0);
      end;
    end;
    if Volume1<>nil then begin
      if VolumeList.IndexOf(pointer(Volume1))=-1 then begin
        VolumeList.Add(pointer(Volume1));
        ProcessVolume(Volume1);
      end;
    end;

  end;

begin
  DMCollection2:=DMCollection as IDMCollection2;

  AreaList:=TList.Create;
  VolumeList:=TList.Create;

  while DMCollection.Count>0 do begin
    AreaE:=DMCollection.Item[0];
    DMCollection2.Delete(0);
    AreaList.Add(pointer(AreaE));
  end;

  while AreaList.Count>0 do begin
    AreaE:=IDMElement(AreaList[0]);
    AreaList.Delete(0);
    DMCollection2.Add(AreaE);
    ProcessArea(AreaE);
  end;

  AreaList.Free;
  VolumeList.Free;
end;

function IsObsoletNode(const Line:ILine; const C:ICoordNode):boolean;
var
  i:integer;
  aLine0, aLine1, aLine:ILine;
  aLineE:IDMElement;
  D:double;
begin
  Result:=False;
  if C.Lines.Count=1 then begin
    Result:=True;
    Exit;
  end else
  if C.Lines.Count<>3 then Exit;
  aLine0:=nil;
  aLine1:=nil;
  for i:=0 to 2 do begin
    aLineE:=C.Lines.Item[i];
    aLine:=aLineE as ILine;
    if (aLine<>Line) and
       not aLineE.Selected then begin
      if aLine0=nil then
        aLine0:=aLine
      else
        aLine1:=aLine
    end;
  end;
  if aLine0=nil then Exit;
  if aLine1=nil then Exit;
  D:=abs((aLine0.C0.X-aLine0.C1.X)*(aLine1.C0.X-aLine1.C1.X)+
         (aLine0.C0.Y-aLine0.C1.Y)*(aLine1.C0.Y-aLine1.C1.Y)+
         (aLine0.C0.Z-aLine0.C1.Z)*(aLine1.C0.Z-aLine1.C1.Z))/
         (aLine0.Length*aLine1.Length);
  Result:=(abs(D-1)<0.01);
end;

function CanDeleteLineFromArea(const LineE, AreaE:IDMElement):integer;
var
  j:integer;
  aAreaE, Area0E, Area1E:IDMElement;
  Area0, Area1:IArea;
  PlanesAreParallel:boolean;
begin
  Result:=0;
  if LineE.Parents.Count=3 then begin
    Area0E:=nil;
    Area1E:=nil;
    for j:=0 to 2 do begin
      aAreaE:=LineE.Parents.Item[j];
      if aAreaE=AreaE then
        Continue
      else
      if Area0E=nil then
        Area0E:=aAreaE
      else
        Area1E:=aAreaE;
    end;
    Area0:=Area0E as IArea;
    Area1:=Area1E as IArea;

    if (Area0.NZ*Area1.NZ=0) then
      PlanesAreParallel:=(abs(abs(Area0.NX*Area1.NX+Area0.NY*Area1.NY)-1)<0.02)
    else
      PlanesAreParallel:=(abs(abs(Area0.NX*Area1.NX+Area0.NY*Area1.NY+Area0.NZ*Area1.NZ)-1)<0.005);

    if PlanesAreParallel and
       ((Area0.Volume0=Area1.Volume0) or
        (Area0.Volume0=Area1.Volume1) or
        (Area0.Volume1=Area1.Volume0) or
        (Area0.Volume1=Area1.Volume1)) then
      Result:=3
  end else
  if LineE.Parents.Count=2 then begin
    Area0E:=LineE.Parents.Item[0];
    Area1E:=LineE.Parents.Item[1];
    Area0:=Area0E as IArea;
    Area1:=Area1E as IArea;

    if (Area0.NZ*Area1.NZ=0) then
      PlanesAreParallel:=(abs(abs(Area0.NX*Area1.NX+Area0.NY*Area1.NY)-1)<0.02)
    else
      PlanesAreParallel:=(abs(abs(Area0.NX*Area1.NX+Area0.NY*Area1.NY+Area0.NZ*Area1.NZ)-1)<0.005);

    if PlanesAreParallel and
       ((Area0.Volume0=Area1.Volume0) or
        (Area0.Volume0=Area1.Volume1) or
        (Area0.Volume1=Area1.Volume0) or
        (Area0.Volume1=Area1.Volume1)) then
      Result:=2
  end else
  if LineE.Parents.Count=1 then
    Result:=1
end;


procedure TCustomSMDocument.DeleteElements(const Collection: IUnknown;
                                     ConfirmFlag:WordBool);
var
  DMCollection2:IDMCollection2;
  DMCollection:IDMCollection;
var
  j, m, CanDelete, N, ErrorCount:integer;
  Element, LineE, Line0E, Line1E, aNodeE, LineToDraw:IDMElement;
  Line0, Line1, Line:ILine;
  Node, aNode, C0, C1:ICoordNode;
  aArea, Area, Area0, Area1:IArea;
  aAreaE, aParent:IDMElement;
  AreaP:IPolyline;
  Volume0, Volume1, Volume:IVolume;
  LineGroup:ILineGroup;
  Volume0E, Volume1E, PolylineE, NodeE, aRef,
  Parent0, Parent1:IDMElement;
  JoinFlag:boolean;
  Unk:IUnknown;
  YesToAllFlag, YesToAllFlag1, WarnCannotDeleteFlag:boolean;
  Server:IDataModelServer;
  aDefaultParent:IDMElement;
  DataModel:IDataModel;
  SpatialModel2:ISpatialModel2;
  FirstArea, DelFlag:boolean;
  PlanesAreParallel:boolean;
  UpdateElementCollection:IDMCollection;
  UpdateElementCollection2:IDMCollection2;
  SelectingState, InLongOperation:boolean;

  function CanDeleteVArea(const aCollection:IDMCollection):boolean;
  var
    m, k, NV, NG:integer;
    aLineE:IDMElement;
    aLine:ILine;
    aArea:IArea;
  begin
    Result:=False;
    for m:=0 to aCollection.Count-1 do begin
      aLineE:=aCollection.Item[m];
      aLine:=aLineE as ILine;
      NV:=0;
      NG:=0;
      for k:=0 to aLineE.Parents.Count-1 do begin
        if aLineE.Parents.Item[k].QueryInterface(IArea, aArea)=0 then begin
          if aArea<>Area then begin
            if aArea.IsVertical then
              inc(NV)
            else
              inc(NG)
          end;
        end;
      end;
      if (NV=1) and (NG=1) then Exit;
    end;
    Result:=True;
  end;
begin
  j:=0;
  LineToDraw:=nil;
  Server:=Get_Server;
  DataModel:=Get_DataModel as IDataModel;
  SpatialModel2:=DataModel as ISpatialModel2;
  DMCollection:=Collection as IDMCollection;
  DMCollection2:=Collection  as IDMCollection2;
  UpdateElementCollection:=DataModel.CreateCollection(-1, nil);
  UpdateElementCollection2:=UpdateElementCollection as IDMCollection2;
  N:=DMCollection.Count;
  if N=0 then Exit;
  FirstArea:=True;
  YesToAllFlag:=False;
  YesToAllFlag1:=False;
  WarnCannotDeleteFlag:=True;
  if (FState and dmfSelecting)<>0 then
    SelectingState:=True
  else begin
    SelectingState:=False;
    FState:=FState or dmfSelecting;
  end;

  InLongOperation:=(FState and dmfLongOperation)<>0;
  if not InLongOperation then
    FState:=FState or dmfLongOperation;
  if DataModel.Errors<>nil then begin
    DataModel.CheckErrors;
    ErrorCount:=DataModel.Errors.Count
  end else
    ErrorCount:=0;

  try
  while j<DMCollection.Count do begin
    Element:=IDMElement(DMCollection.Item[j]);
    if Element.QueryInterface(IArea, Area)<>0 then
      FirstArea:=False;

    if Element.QueryInterface(ISpatialElement, Unk)<>0 then begin
      DeleteElement( nil, nil, ltOneToMany, Element);
      inc(j);
      Continue;
    end else
    if j<N then
      Element.Selected:=True;

    if not SpatialModel2.CanDeleteNow(Element, DMCollection) then Continue;

    if Element.QueryInterface(IVolume, Volume)=0 then begin
      if ConfirmFlag and
         (j<N) and
         (not YesToAllFlag) then begin
        Server.CallDialog(1, '', Format(rsDeleteConfirm, [Element.Name]));

        Element.Selected:=False;

        if Server.EventData1=0 then begin
          j:=N;
          Continue
        end else
        if Server.EventData1=2 then
          YesToAllFlag:=True
        else
        if Server.EventData1=3 then begin
          inc(j);
          Continue
        end;
      end;

      Element.Draw(FPainter, -1);

      if UpdateElementCollection.IndexOf(Element)=-1 then
         UpdateElementCollection2.Add(Element);

      aRef:=Element.Ref;
      if aRef<>nil then
        aRef.BeforeDeletion;

      aDefaultParent:=nil;
      while Volume.Areas.Count>0 do begin
        aArea:=Volume.Areas.Item[0] as IArea;
        if aArea.Volume0=Volume then begin
          aArea.Volume0:=nil;
          aArea.Volume0IsOuter:=True;
        end;
        if aArea.Volume1=Volume then begin
          aArea.Volume1:=nil;
          aArea.Volume1IsOuter:=True;
        end;
        aAreaE:=aArea as IDMElement;
          if DMCollection.IndexOf(aAreaE)<j then
            DMCollection2.Add(aAreaE);
      end;

      DeleteElement( nil, nil, ltOneToMany, Element);

      if aRef<>nil then
        DeleteElement( nil, nil, ltOneToMany, aRef);

    end else
    if Element.QueryInterface(IArea, Area)=0 then begin

      if ConfirmFlag and
         (j<N) and
         (not YesToAllFlag) then begin
        Server.CallDialog(1, '', Format(rsCaskadeDeleteConfirm, [Element.Name]));

        Element.Selected:=False;

        if Server.EventData1=0 then begin
          j:=N;
          Continue
        end else
        if Server.EventData1=2 then
          YesToAllFlag:=True
        else
        if Server.EventData1=3 then begin
          inc(j);
          Continue
        end;

        if ConfirmFlag then begin
          Server.EventData3:=0;
          Server.CallDialog(sdmPleaseWait, '', 'Удаление элементов модели');
        end;
      end;

      Volume0:=Area.Volume0;
      Volume1:=Area.Volume1;

      AreaP:=Area as IPolyline;

      if FirstArea and (N>2) then begin
        ReorderAreasToDeleteList(DMCollection);
        FirstArea:=False;
      end;

      Element.Selected:=False;
      if AreaP.Lines.Count>0 then begin
        if Element.Ref<>nil then
          Element.Ref.Draw(FPainter, -1)
        else
          Element.Draw(FPainter, -1);
      end;

      if UpdateElementCollection.IndexOf(Element)=-1 then
         UpdateElementCollection2.Add(Element);

      JoinFlag:=False;
      for m:=0 to AreaP.Lines.Count-1 do begin
        LineE:=AreaP.Lines.Item[m];
        CanDelete:=CanDeleteLineFromArea(LineE, Element);
        if CanDelete=2 then begin
          if (DMCollection.IndexOf(LineE)<j) then
            DMCollection2.Add(LineE);
          JoinFlag:=True;
        end
      end;
      if JoinFlag and
         not ((Area.Volume0=nil) and
              (Area.Volume1=nil)) then begin
                  DMCollection2.Add(Element);
        inc(j);            // нужно не только удалить плоскость,
        Continue;          // а слить ее с другими, что будет сделано позже
      end else
      if ((Area.Volume0=nil) and
          (Area.Volume1<>nil) and (not Area.Volume0IsOuter)) or
         ((Area.Volume1=nil) and
          (Area.Volume0<>nil) and (not Area.Volume1IsOuter)) then begin
        inc(j);              // внешние границы не удаляем
        Continue
      end;

      if (not Area.IsVertical) and
         (j<N) then begin
        if ((Volume0<>nil) and
            (Volume0.BottomAreas.Count>1)) or
           ((Volume1<>nil) and
            (Volume1.TopAreas.Count>1)) then begin
          if  WarnCannotDeleteFlag then begin
            Server.CallDialog(1, '', Format(rsCannotDelete, [Element.Name]));
            if Server.EventData1=2 then
              WarnCannotDeleteFlag:=False;
          end;
          inc(j);
          Continue;
        end;
      end else begin  // if Area.IsVertical
        if  not JoinFlag and
          (j<N) and
          (AreaP.Lines.Count>0) and
          (not CanDeleteVArea(Area.TopLines) or
           not CanDeleteVArea(Area.BottomLines)) then begin
          if WarnCannotDeleteFlag then begin
            Server.CallDialog(1, '', Format(rsCannotDelete, [Element.Name]));
            if Server.EventData1=0 then
              WarnCannotDeleteFlag:=False;
          end;
          inc(j);
          Continue;
        end;
      end;

      aRef:=Element.Ref;
      if aRef<>nil then
        aRef.BeforeDeletion;

      while AreaP.Lines.Count>0 do begin
        LineE:=AreaP.Lines.Item[0];
        if (DMCollection.IndexOf(LineE)<j) and
          (CanDeleteLineFromArea(LineE, Element) <>0) then
            DMCollection2.Add(LineE); // линия подлежит удалению
        LineE.RemoveParent(Element);
      end;
      Volume0E:=Volume0 as IDMElement;
      Volume1E:=Volume1 as IDMElement;

      Area.Volume0:=nil;
      Area.Volume1:=nil;
      Area.Volume0IsOuter:=True;
      Area.Volume1IsOuter:=True;
      if (Volume0E<>nil) and
         (Volume1E<>nil) and
         (Volume0E<>Volume1E) then begin // нужно удалить Volume0
        while Volume0.Areas.Count>0 do begin
          aAreaE:=Volume0.Areas.Item[0];
          aArea:=aAreaE as IArea;

          if (Volume1.Areas.IndexOf(aAreaE)=-1) then begin
            if aArea.Volume1=Volume0 then begin  // это не общая граница областей
              aArea.Volume1IsOuter:=False;
              aArea.Volume1:=Volume1
            end else
            if aArea.Volume0=Volume0 then begin
              aArea.Volume0IsOuter:=False;
              aArea.Volume0:=Volume1;
            end;
          end else begin // это общая граница областей, ее нужно удалить
            aArea.Volume0:=nil;
            aArea.Volume1:=nil;
            aArea.Volume0IsOuter:=True;
            aArea.Volume1IsOuter:=True;

            if DMCollection.IndexOf(aAreaE)<j then
              DMCollection2.Add(aAreaE);
          end;
        end;

        if DMCollection.IndexOf(Volume0E)<j then begin
          DMCollection2.Add(Volume0E);
        end;
      end;

      DeleteElement( nil, nil, ltOneToMany, Element);

      if aRef<>nil then
        DeleteElement( nil, nil, ltOneToMany, aRef);
      if Volume0E<>nil then begin
        if UpdateElementCollection.IndexOf(Volume0E)=-1 then
           UpdateElementCollection2.Add(Volume0E);
      end;
      if Volume1E<>nil then begin
        if UpdateElementCollection.IndexOf(Volume1E)=-1 then
           UpdateElementCollection2.Add(Volume1E);
      end;
    end else
    if Element.QueryInterface(ILineGroup, LineGroup)=0 then begin
      if ConfirmFlag and
         (j<N) and
         (not YesToAllFlag) then begin
        Server.CallDialog(1, '', Format(rsDeleteConfirm, [Element.Name]));

        Element.Selected:=False;

        if Server.EventData1=0 then begin
          j:=N;
          Continue
        end else
        if Server.EventData1=2 then
          YesToAllFlag:=True
        else
        if Server.EventData1=3 then begin
          inc(j);
          Continue
        end;
      end;

      Element.Draw(FPainter, -1);

      if LineGroup.Lines.Count>0 then begin
        Server.CallDialog(5, '', Format(rsDeleteLinesConfirm, [Element.Name]));
        if Server.EventData1=1 then begin
          while LineGroup.Lines.Count>0 do begin
            LineE:=LineGroup.Lines.Item[0];
            if (DMCollection.IndexOf(LineE)<j) and
              (LineE.Parents.Count=1) then
                DMCollection2.Add(LineE);
            LineE.RemoveParent(Element);
          end;
        end;
      end;

      aRef:=Element.Ref;
      if aRef<>nil then
        aRef.BeforeDeletion;

      DeleteElement( nil, nil, ltOneToMany, Element);

      if aRef<>nil then
        DeleteElement( nil, nil, ltOneToMany, aRef);
    end else
    if (Element.QueryInterface(ILine, Line)=0) then begin

      C0:=Line.C0;
      C1:=Line.C1;
      if (Element.Parents.Count>2) then begin
        if (j<N) and
          WarnCannotDeleteFlag then begin
          Server.CallDialog(1, '', Format(rsCannotDelete, [Element.Name]));
          if Server.EventData1=0 then
            WarnCannotDeleteFlag:=False;
        end;
        inc(j);
        Continue;
      end;

      if ConfirmFlag and
         (j<N) and
         (not YesToAllFlag) and
         ((Element.Parents.Count>0) or
         (Element.Ref<>nil)) then begin
        Server.CallDialog(1, '', Format(rsCaskadeDeleteConfirm, [Element.Name]));

        Element.Selected:=False;

        if Server.EventData1=0 then begin
          j:=N;
          Continue
        end else
        if Server.EventData1=2 then
          YesToAllFlag:=True
        else
        if Server.EventData1=3 then begin
          inc(j);
          Continue
        end;
      end;

      Element.Selected:=False;
      if (C0<>nil) and
         (C1<>nil) then
        Element.Draw(FPainter, -1);

      if Element.Parents.Count=1 then begin
        PolylineE:=Element.Parents.Item[0]; // нарушается целостность объекта,
        Element.RemoveParent(PolylineE);    // поэтому его нужно удалить
        if DMCollection.IndexOf(PolylineE)<j then
          DMCollection2.Add(PolylineE);
      end else
      if Element.Parents.Count=2 then begin
        Parent0:=Element.Parents.Item[0];
        Parent1:=Element.Parents.Item[1];
        if (Parent0.QueryInterface(IArea, Area0)=0) and
           (Parent1.QueryInterface(IArea, Area1)=0) then begin

          if (Area0.NZ*Area1.NZ=0) then
             PlanesAreParallel:=(abs(abs(Area0.NX*Area1.NX+Area0.NY*Area1.NY)-1)<0.02)
          else
             PlanesAreParallel:=(abs(abs(Area0.NX*Area1.NX+Area0.NY*Area1.NY+Area0.NZ*Area1.NZ)-1)<0.005);

          if  PlanesAreParallel and
             ((Area0.Volume0=Area1.Volume0) or
              (Area0.Volume0=Area1.Volume1) or
              (Area0.Volume1=Area1.Volume0) or
              (Area0.Volume1=Area1.Volume1)) then
            JoinAreas(Area0, Area1, Line, j, DMCollection, UpdateElementCollection)
          else begin
            if (j<N) and
              (not YesToAllFlag1) then begin
              Server.CallDialog(1, '', Format(rsCannotDelete1, [Element.Name]));

              if Server.EventData1=0 then begin
                j:=N;
                Continue
              end else
              if Server.EventData1=2 then begin
                YesToAllFlag1:=True
              end else
              if Server.EventData1=3 then begin
                inc(j);
                Continue
              end;
              JoinAreas(Area0, Area1, Line, j, DMCollection, UpdateElementCollection);
            end else begin
              inc(j);
              Continue;
            end;
          end;
        end else begin //  if j<N then begin ???????
          if (j<N) and
            WarnCannotDeleteFlag then begin
            Server.CallDialog(1, '', Format(rsCannotDelete, [Element.Name]));
            if Server.EventData1=0 then
              WarnCannotDeleteFlag:=False;
          end;
          inc(j);
          Continue;
        end;
      end;
      if (C0<>nil) and
         IsObsoletNode(Line, C0) then begin
        NodeE:=C0 as IDMElement;
        if NodeE.Ref=nil then
          if DMCollection.IndexOf(NodeE)<j then
            DMCollection2.Add(NodeE);
      end;
      if (C1<>nil) and
         IsObsoletNode(Line, C1) then begin
        NodeE:=C1 as IDMElement;
        if NodeE.Ref=nil then
          if DMCollection.IndexOf(NodeE)<j then
            DMCollection2.Add(NodeE);
      end;

      while Element.Parents.Count>0 do begin
        aParent:=Element.Parents.Item[0];
        Element.RemoveParent(aParent);

        if UpdateElementCollection.IndexOf(aParent)=-1 then
          UpdateElementCollection2.Add(aParent);
      end;
      aRef:=Element.Ref;
      DelFlag:=(aRef<>nil) and (aRef.SpatialElement=Element);
      DeleteElement( nil, nil, ltOneToMany, Element);
      if DelFlag then begin
        DeleteElement( nil, nil, ltOneToMany, aRef);
      end;
      if LineToDraw<>nil then
        LineToDraw.Draw(FPainter, 0);
      LineToDraw:=nil;
    end else
    if Element.QueryInterface(ICoordNode, Node)=0 then begin
      Element.Selected:=False;
      Element.Draw(FPainter, -1);

      if ConfirmFlag and
         (j<N) and
         (not YesToAllFlag) and
         (Element.Ref<>nil) then begin
        Server.CallDialog(1, '', Format(rsCaskadeDeleteConfirm, [Element.Name]));

        Element.Selected:=False;

        if Server.EventData1=0 then begin
          j:=N;
          Continue
        end else
        if Server.EventData1=2 then
          YesToAllFlag:=True
        else
        if Server.EventData1=3 then begin
          inc(j);
          Continue
        end;
      end;

      if Node.Lines.Count=2 then begin
        Line0E:=Node.Lines.Item[0];
        Line1E:=Node.Lines.Item[1];
        Line0:=Line0E as ILine;
        Line1:=Line1E as ILine;
        if Line1.C0=Node then
          aNode:=Line1.C1
        else
          aNode:=Line1.C0;
        aNodeE:=aNode as IDMElement;
        Line0E.Draw(FPainter, -1);
        if Line0.C0=Node then
          Line0.C0:=aNode
        else
          Line0.C1:=aNode;
        LineToDraw:=Line0E;

        Line1.C0:=nil;
        LIne1.C1:=nil;

        if DMCollection.IndexOf(Line1E)<j then
          DMCollection2.Add(Line1E);

        while Line1E.Parents.Count>0 do begin
          aParent:=Line1E.Parents.Item[0];
          Line1E.RemoveParent(aParent);

          if UpdateElementCollection.IndexOf(aParent)=-1 then
            UpdateElementCollection2.Add(aParent);
        end;
      end else
      if (Node.Lines.Count=1) and
        SpatialModel2.EdgeNodeDeletionAllowed then begin
        Line0E:=Node.Lines.Item[0];
        Line0:=Line0E as ILine;
        Line0.C0:=nil;
        Line0.C1:=nil;
        if DMCollection.IndexOf(Line0E)<j then
          DMCollection2.Add(Line0E);
        aRef:=Element.Ref;
        if aRef<>nil then begin
          aRef.Draw(FPainter, -1);
          DeleteElement( nil, nil, ltOneToMany, aRef);
        end;
      end;
      if Node.Lines.Count=0 then begin
        aRef:=Element.Ref;
        DeleteElement( nil, nil, ltOneToMany, Element);
        if aRef<>nil then begin
          DeleteElement( nil, nil, ltOneToMany, aRef);
        end
      end;
    end else begin
      Element.Selected:=False;
      DeleteElement( nil, nil, ltOneToMany, Element);
    end;
    inc(j)
  end;

  try
  for j:=0 to UpdateElementCollection.Count-1 do begin
    Element:=UpdateElementCollection.Item[j];
    UpdateElement(Element);
    UpdateCoords(Element);

    if DMCollection.IndexOf(Element)=-1 then begin
      if Element.Ref<>nil then
        Element.Ref.Draw(FPainter, 0)
      else
        Element.Draw(FPainter, 0);
    end;
  end;
  except
    raise
  end;
  finally
    if ConfirmFlag then begin
      Server.EventData3:=-1;
      Server.CallDialog(sdmPleaseWait, '', '');
    end;
    if not SelectingState then
      FState:=FState and not dmfSelecting;
    if not InLongOperation then
      FState:=FState and not dmfLongOperation;

    if DataModel.Errors<>nil then begin
      DataModel.CheckErrors;
      if DataModel.Errors.Count-ErrorCount>0 then begin
        Get_Server.CallDialog(sdmShowMessage, '',
        'Операция выполнена с ошибками. Рекомендуется проверить корректность модели');
      end;
    end;  
  end;
  UpdateElementCollection2.Clear;
end;

function TCustomSMDocument.Get_Cursor: Integer;
var
  aHint:string;
  aCursor:integer;
  CurrentOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  if FCurrentOperation<>nil then begin
    CurrentOperation.GetStepHint(CurrentOperation.CurrentStep,aHint,aCursor);
    Result:=aCursor;
  end else
    Result:=0;
end;

function TCustomSMDocument.Get_Hint: WideString;
var
  aHint:string;
  aCursor:integer;
  CurrentOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  if CurrentOperation<>nil then begin
    CurrentOperation.GetStepHint(CurrentOperation.CurrentStep,aHint,aCursor);
    Result:=aHint;
  end else
    Result:='';
end;


procedure CalcLimits(const aCollection:IDMCollection;
                     var MinX, MinY, MinZ, MaxX, MaxY, MaxZ:double);
  procedure  Compare(const Node:ICoordNode);
  begin
    if MinX>Node.X then
      MinX:=Node.X;
    if MaxX<Node.X then
      MaxX:=Node.X;

    if MinY>Node.Y then
      MinY:=Node.Y;
    if MaxY<Node.Y then
      MaxY:=Node.Y;

    if MinZ>Node.Z then
      MinZ:=Node.Z;
    if MaxZ<Node.Z then
      MaxZ:=Node.Z;
  end;

var
  j, m, k:integer;
  Line:ILine;
  Node:ICoordNode;
  Polyline:IPolyline;
  Volume:IVolume;
  Element:IDMElement;
begin
  MinX:=InfinitValue;
  MinY:=InfinitValue;
  MinZ:=InfinitValue;
  MaxX:=-InfinitValue;
  MaxY:=-InfinitValue;
  MaxZ:=-InfinitValue;
  for j:=0 to aCollection.Count-1 do begin
    Element:=aCollection.Item[j];
    if Element.QueryInterface(ICoordNode, Node)=0 then
      Compare(Node)
    else
    if Element.QueryInterface(ILine, Line)=0 then begin
      Compare(Line.C0);
      Compare(Line.C1);
    end else
    if Element.QueryInterface(IPolyLine, PolyLine)=0 then
      for m:=0 to PolyLine.Lines.Count-1 do begin
        Line:=PolyLine.Lines.Item[m] as ILine;
        Compare(Line.C0);
        Compare(Line.C1);
      end
    else
    if Element.QueryInterface(IVolume, Volume)=0 then
      for k:=0 to Volume.Areas.Count-1 do begin
        Polyline:=Volume.Areas.Item[k] as IPolyline;
        for m:=0 to PolyLine.Lines.Count-1 do begin
          Line:=PolyLine.Lines.Item[m] as ILine;
          Compare(Line.C0);
          Compare(Line.C1);
        end;
      end
  end;
end;


function TCustomSMDocument.CreateRefElement(var ClassID:integer; OperationCode: Integer;
  const Collection: IDMCollection; out RefElement,
  RefParent: IDMElement; SetParentFlag:WordBool): WordBool;
var
  Server:IDataModelServer;
  SpatialModel2:ISpatialModel2;
  aRef:IDMElement;
  aCollection, RefSource, ClassCollection:IDMCollection;
  DMClassCollections:IDMClassCollections;
  PX, PY, PZ, MinX, MinY, MinZ, MaxX, MaxY, MaxZ:double;
  Suffix, aName:WideString;
  V:Variant;
  Unk:IUnknown;
  InstanceClassID:integer;
  aDataModel:IDMElement;
  ElementU:IUnknown;
  DMElement3:IDMElement3;
begin
  RefElement:=nil;
  Result:=False;
  Server:=Get_Server;
  if Collection=nil then
    CalcSelectionLimits(MinX, MinY, MinZ, MaxX, MaxY, MaxZ)
  else
    CalcLimits(Collection, MinX, MinY, MinZ, MaxX, MaxY, MaxZ);
  PX:=0.5*(MinX+MaxX);
  PY:=0.5*(MinY+MaxY);
  PZ:=0.5*(MinZ+MaxZ);
  SpatialModel2:=Get_DataModel as ISpatialModel2;
  SpatialModel2.GetRefElementParent(ClassID, OperationCode, PX, PY, PZ, RefParent,
                         DMClassCollections, RefSource, aCollection);

   Suffix:='';
   Server.EventData1:=null;
   case OperationCode of
   smoCreateCoordNode:
     Server.EventData3:=1;
   smoBuildPolylineObject:
     Server.EventData3:=0;
   smoBuildLineObject,
   smoBuildArrayObject:
     Server.EventData3:=2;
   else
     Server.EventData3:=-1;
   end;

  if (DMClassCollections<>nil) or
     (RefSource<>nil) then begin
    if aCollection<>nil then
      Server.EventData2:=(aCollection as IDMCollection2).MakeDefaultName(RefParent)
    else
      Server.EventData2:='';
    Server.CallRefDialog(DMClassCollections, RefSource, Suffix, True);
    V:=Server.EventData1;
    if VarIsNull(V) then
      aRef:=nil
    else begin
      Unk:=V;
      aRef:=Unk as IDMElement;
    end;
    aName:=Server.EventData2;
    InstanceClassID:=Server.EventData3;
    if (RefSource<>nil) and
       (aRef=nil) then Exit;
    if (DMClassCollections<>nil) and
       (InstanceClassID=-1) then Exit;
    if trim(aName)='' then Exit;
  end else begin
    if aCollection<>nil then
      aName:=(aCollection as IDMCollection2).MakeDefaultName(nil)
    else
      Exit;  

    Server.EventData2:=aName;
    Server.CallDialog(4,
                      Format(rsAddItemCaption,[aName]),
                      Format(rsAddItemPrompt,[aName]));
    aName:=trim(Server.EventData2);
    if trim(aName)='' then Exit;

    RefSource:=nil;
    aRef:=nil;
    if aCollection<>nil then
      InstanceClassID:=aCollection.ClassID
    else
      InstanceClassID:=ClassID
  end;

  if RefSource<>nil then begin
    AddElementRef(
              nil, aCollection, aName, aRef, ltOneToMany, ElementU, False);
    RefElement:=ElementU as IDMElement;
  end else
  if (InstanceClassID<>-1) then begin
    aDataModel:=Get_DataModel as IDMElement;
    ClassCollection:=aDataModel.Collection[InstanceClassID];
    if aRef<>nil then
      _AddElementRef( ClassCollection,
                       nil, aCollection,
                       aName, aRef, ltOneToMany, ElementU, True)
    else
      _AddElement( ClassCollection,
                       nil, aCollection,
                       aName, ltOneToMany, ElementU, True);
    RefElement:=ElementU as IDMElement;
  end;

  Result:=True;

  if RefElement=nil then Exit;

  if RefElement.QueryInterface(IDMElement3, DMElement3)=0 then
    ClassID:=DMElement3.SpatialElementClassID;
end;

procedure TCustomSMDocument.ChangeRefRef(const Collection: IDMCollection;
                        const aName: WideString;
                        const aRef, aElement: IDMElement);
begin
  ChangeRef(Collection, aName, aRef, aElement)
end;

function TCustomSMDocument.Get_NearestImage: IDMElement;
var
  Tag:integer;
begin
  if FHWindowFocused then
    Tag:=1
  else
  if FVWindowFocused then
    Tag:=2
  else begin
    Result:=nil;
    Exit;
  end;

  Result:=GetNearestImage(FCurrX, FCurrY, FCurrZ, Tag, nil, False) as IDMElement
end;

function TCustomSMDocument.Get_NearestCircle: IDMElement;
var
  Tag:integer;
begin
  if FHWindowFocused then
    Tag:=1
  else
  if FVWindowFocused then begin
    Result:=nil;
    Exit;
  end;

  Result:=GetNearestCircle(FCurrX, FCurrY, FCurrZ) as IDMElement
end;

procedure TCustomSMDocument.DivideVerticalArea(const Node: ICoordNode;
  Direction: Integer; out DividingLine: ILine);
var
 SpatialModel:ISpatialModel;
 Lines:IDMCollection;
  Area0, Area1, aArea:IArea;
  j:integer;
  aLine, NLine:ILine;
  MinDistance, Distance, WX, WY, WZ, WX0, WY0, WZ0, X, Y, Z:double;
  aNode:ICoordNode;
  aNodeE, DividingLineE, aLineE:IDMElement;
  DividingLineS, NLineS, aLineS:ISpatialElement;
  OrtBaseOnLine:WordBool;
  LineU:IUnknown;
  NodeU:IUnknown;
begin
  DividingLine:=nil;
  if Node.Lines.Count<2 then Exit;
  Area0:=nil;
  Area1:=nil;
  for j:=0 to Node.Lines.Count-1 do begin
    aLine:=Node.Lines.Item[j] as ILine;
    aArea:=aLine.GetVerticalArea(Direction);
    if aArea<>nil then begin
      if Area0=nil then
        Area0:=aArea
      else
      if Area1=nil then
        Area1:=aArea
      else
        Exit
    end
  end;
  if Area0=nil then Exit;
  if Area1=nil then Exit;
  if Area0<>Area1 then Exit;

  if Direction=bdUp then
    Lines:=Area0.TopLines
  else
    Lines:=Area0.BottomLines;

  WX:=Node.X;
  WY:=Node.Y;
  WZ:=Node.Z;
  X:=WX;
  Y:=WY;
  Z:=WZ;
  MinDistance:=InfinitValue;
  NLine:=nil;
  for j:=0 to Lines.Count-1 do begin
    aLine:=Lines.Item[j] as ILine;
    Distance:=aLine.DistanceFrom(WX, WY, WZ, WX0, WY0, WZ0, OrtBaseOnLine);
    if MinDistance>Distance then begin
      if OrtBaseOnLine then begin
        MinDistance:=Distance;
        NLine:=aLine;
        Z:=WZ0;
      end;
    end;
  end;

  if NLine=nil then Exit;
  NLineS:=NLine as ISpatialElement;

  SpatialModel:=Get_DataModel as ISpatialModel;

  if ((X=NLine.C0.X) and
      (Y=NLine.C0.Y) and
      (Z=NLine.C0.Z)) then
    aNode:=NLine.C0
  else
  if ((X=NLine.C1.X) and
      (Y=NLine.C1.Y) and
      (Z=NLine.C1.Z)) then
    aNode:=NLine.C1
  else begin
    AddElement( NLineS.Layer as IDMElement,
                      SpatialModel.Lines, '', ltOneToMany, LineU, True);
    aLineE:=LineU as IDMElement;

    aLine:=aLineE as ILine;
    aLineS:=aLineE as ISpatialElement;

    aLine.Thickness:=NLine.Thickness;
    aLine.Style:=NLine.Style;
    aLineS.Color:=NLineS.Color;

    AddElement( NLineS.Layer as IDMElement,
                      SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
    aNodeE:=NodeU as IDMElement;
    aNode:=aNodeE as ICoordNode;

    aNode.X:=X;
    aNode.Y:=Y;
    aNode.Z:=Z;

    aLine.C0:=aNode;
    aLine.C1:=NLine.C1;
    NLine.C1:=aNode;

    NodeUpdateAreas(aNode);
  end;

  AddElement( NLineS.Layer as IDMElement,
                    SpatialModel.Lines, '', ltOneToMany, LineU, True);
  DividingLineE:=LineU as IDMElement;
  DividingLine:=DividingLineE as ILine;
  DividingLineS:=DividingLineE as ISpatialElement;

  DividingLine.Thickness:=NLine.Thickness;
  DividingLine.Style:=NLine.Style;
  DividingLineS.Color:=NLineS.Color;

  case Direction of
   bdUp  :begin
           DividingLine.C0:=Node;
           DividingLine.C1:=aNode;
          end;
   bdDown:begin
           DividingLine.C1:=Node;
           DividingLine.C0:=aNode;
          end;
  end; //case

  LineUpdateAreas(DividingLine)
end;

function TCustomSMDocument.Get_VirtualX: Double;
begin
  Result:=FVirtualX
end;

function TCustomSMDocument.Get_VirtualY: Double;
begin
  Result:=FVirtualY
end;

function TCustomSMDocument.Get_VirtualZ: Double;
begin
  Result:=FVirtualZ
end;

function TCustomSMDocument.Get_AutoSnapNode: WordBool;
begin
  Result:=FAutoSnapNode
end;

procedure TCustomSMDocument.Set_AutoSnapNode(Value: WordBool);
begin
  FAutoSnapNode:=Value
end;

function TCustomSMDocument.InsertVerticalArea(const BaseNode: ICoordNode): IArea;

  procedure FindVLine(X, Y, Z:double;
                      const BLine:ILine; const BC0, BC1:ICoordNode;
                      const VAreaE:IDMElement;
                      const BL:double; var W:double; out theLine:ILine; out theC:ICoordNode);
  var
    ALineE, LineE:IDMElement;
    ALine, VLine, GLine:ILine;
    C, aC:ICoordNode;
    m:integer;
    L, dW, aX, aY, aZ, XX, YY, ZZ, theX, theY, theZ:double;
  begin
    ALine:=BLine;
    C:=BC0;
    aC:=BC1;
    aX:=X;
    aY:=Y;
    aZ:=Z;
    ALineE:=ALine as IDMElement;
    L:=BL;
    dW:=W-L;
    VLine:=nil;
    theLine:=nil;
    theC:=nil;
    while dW>0 do begin
      VLine:=C.GetVerticalLine(bdUp);
      if dW<Tresh then
        Break;
      if VLine<>nil then
        Break;
      LineE:=nil;
      m:=0;
      while m<C.Lines.Count do begin
        LineE:=C.Lines.Item[m];
        if LineE=ALineE then
          inc(m)
        else
        if LineE.Parents.IndexOf(VAreaE)=-1 then
          inc(m)
        else
          Break
      end;  // while m<C.Lines.Count
      if m=C.Lines.Count then
        raise Exception.CreateFmt('Error1 in InsertVerticalArea Area.ID=%d',
                               [VAreaE.ID])
      else begin
        ALineE:=LineE;
        ALine:=LineE as ILine;
        L:=ALine.Length;
        dW:=dW-L;
        aC:=C;
        C:=ALine.NextNodeTo(aC);
        aX:=aC.X;
        aY:=aC.Y;
        aZ:=aC.Z;
      end;
    end; // while dW>0
    if dW>0 then begin
      theC:=C;
      if VLine=nil then begin  // dW<Tresh  немного перешли через узел
        DivideVerticalArea(theC, bdUp, theLine);
      end else begin
        theLine:=VLine;
        W:=W+dW;
      end;
    end else begin
      dW:=abs(dW);
      if dW<Tresh then begin    // почти дошли до узла
        theC:=C;
        theLine:=theC.GetVerticalLine(bdUp);
        if theLine=nil then
          DivideVerticalArea(theC, bdUp, theLine)
      end else begin
        XX:=C.X;
        YY:=C.Y;
        ZZ:=c.Z;
        theX:=XX+(aX-XX)/L*dW;
        theY:=YY+(aY-YY)/L*dW;
        theZ:=ZZ+(aZ-ZZ)/L*dW;
        theC:=DivideLineIn(aLine, theX, theY, theZ,
                           smoSnapToNearestOnLine, GLine);
        DivideVerticalArea(theC, bdUp, theLine);
      end;
    end;
  end;

var
  AreaP:IPolyline;
  AreaE, VAreaE:IDMElement;
  VArea:IArea;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  VerticalAreaWidth:double;
  OldSnapMode:integer;
  BLine, ALine, Line0, Line1, GLine:ILine;
  BLineE, ALineE, Line0E, Line1E:IDMElement;
  Node0, Node1:ICoordNode;
  Node0E, Node1E:IDMElement;
  C0, C1, C, aC, theC, NNode:ICoordNode;
  PX, PY, PZ, X0, Y0, Z0, X1, Y1, Z1, X, Y, Z, LB, LA, BL, BL0, BL1,
  W, L0, L1:double;
  j, m:integer;
  GlobalData:IGlobalData;
begin
  Result:=nil;

  SpatialModel:=Get_DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  VerticalAreaWidth:=SpatialModel2.DefaultVerticalAreaWidth*100;
  GlobalData:=SpatialModel as IGlobalData;

  OldSnapMode:=FSnapMode;
  case FSnapMode of
  smoSnapNone:
    FSnapMode:=smoSnapToNearestOnLine;
  end;

  GetSnapPoint(X, Y, Z, BLine, NNode, BaseNode, False, 0);
  FSnapMode:=OldSnapMode;

  if BLine=nil then Exit;

  VArea:=BLine.GetVerticalArea(bdUp);
  if VArea=nil then Exit;

  if GlobalData.GlobalValue[5]=2 then begin
    Result:=VArea;
    Exit;
  end;

  BLineE:=BLine as IDMElement;
  BL:=BLine.Length;
  if GlobalData.GlobalValue[5]=0 then begin
    if VerticalAreaWidth+1>BL then begin
      Node0:=BLine.C0;
      Node1:=BLine.C1;
      Line0:=Node0.GetVerticalLine(bdUp);
      Line1:=Node1.GetVerticalLine(bdUp);
      if Line0=nil then
        DivideVerticalArea(Node0, bdUp, Line0);
      if Line1=nil then
        DivideVerticalArea(Node1, bdUp, Line1);
    end else begin   // if VerticalAreaWidth+1>BL
      case FSnapMode of
      smoSnapNone:
        FSnapMode:=smoSnapToNearestOnLine;
      end;
      Node0:=DivideLineIn(BLine, X, Y, Z, FSnapMode, ALine);
      FSnapMode:=OldSnapMode;

      if Node0=nil then Exit;
      Node0E:=Node0 as IDMElement;

      ALineE:=ALine as IDMElement;
      LB:=BLine.Length;
      LA:=ALine.Length;

      PX:=Node0.X;
      PY:=Node0.Y;
      PZ:=Node0.Z;

      Node0E.Draw(FPainter, -1);

      if VerticalAreaWidth*0.5>=LB then begin
        if BLine.C0=Node0 then begin
          C0:=BLine.C1;
          C1:=BLine.C0;
        end else begin
          C0:=BLine.C0;
          C1:=BLine.C1;
        end;

        X0:=C0.X+(PX-C0.X)*VerticalAreaWidth/LB;
        Y0:=C0.Y+(PY-C0.Y)*VerticalAreaWidth/LB;
        Z0:=C0.Z+(PZ-C0.Z)*VerticalAreaWidth/LB;
        Node0.X:=X0;
        Node0.Y:=Y0;
        Node0.Z:=Z0;
        Node0E.Draw(FPainter, 0);

        DivideVerticalArea(Node0, bdUp, Line0);

        Node1:=C0;
        Line1:=Node1.GetVerticalLine(bdUp);
        if Line1=nil then
          DivideVerticalArea(Node1, bdUp, Line1);
      end else
      if VerticalAreaWidth*0.5>=LA then begin
        if ALine.C1=Node0 then begin
          C0:=ALine.C1;
          C1:=ALine.C0;
        end else begin
          C0:=ALine.C0;
          C1:=ALine.C1;
        end;

        X0:=C1.X+(PX-C1.X)*VerticalAreaWidth/LA;
        Y0:=C1.Y+(PY-C1.Y)*VerticalAreaWidth/LA;
        Z0:=C1.Z+(PZ-C1.Z)*VerticalAreaWidth/LA;
        Node0.X:=X0;
        Node0.Y:=Y0;
        Node0.Z:=Z0;
        Node0E.Draw(FPainter, 0);

        DivideVerticalArea(Node0, bdUp, Line0);

        Node1:=C1;
        Line1:=Node1.GetVerticalLine(bdUp);
        if Line1=nil then
          DivideVerticalArea(Node1, bdUp, Line1);
      end else begin // if VerticalAreaWidth*0.5<LA
        if BLine.C1=Node0 then begin
          C0:=BLine.C0;
          C1:=BLine.C1;
        end else begin
          C0:=BLine.C1;
          C1:=BLine.C0;
        end;

        X0:=PX+(C0.X-C1.X)*0.5*VerticalAreaWidth/LB;
        Y0:=PY+(C0.Y-C1.Y)*0.5*VerticalAreaWidth/LB;
        Z0:=PZ+(C0.Z-C1.Z)*0.5*VerticalAreaWidth/LB;
        X1:=PX-(C0.X-C1.X)*0.5*VerticalAreaWidth/LB;
        Y1:=PY-(C0.Y-C1.Y)*0.5*VerticalAreaWidth/LB;
        Z1:=PZ-(C0.Z-C1.Z)*0.5*VerticalAreaWidth/LB;

        Node0.X:=X0;
        Node0.Y:=Y0;
        Node0.Z:=Z0;
        Node0E.Draw(FPainter, 0);

        DivideVerticalArea(Node0, bdUp, Line0);

        FSnapMode:=smoSnapToNearestOnLine;
        Node1:=DivideLineIn(ALine, X1, Y1, Z1, FSnapMode, GLine);
        Node1E:=Node1 as IDMElement;
        FSnapMode:=OldSnapMode;

        DivideVerticalArea(Node1, bdUp, Line1);
      end; // // if VerticalAreaWidth*0.5<LA
    end // if abs(VerticalAreaWidth-L)<1
  end else begin // if GlobalData.GlobalValue[5]=1
    C0:=BLine.C0;
    C1:=BLine.C1;
    X0:=C0.X;
    Y0:=C0.Y;
    X1:=C1.X;
    Y1:=C1.Y;
    L0:=sqrt(sqr(X0-X)+sqr(Y0-Y));
    L1:=sqrt(sqr(X1-X)+sqr(Y1-Y));
    if L0<=L1 then begin
      C:=C0;
      aC:=C1;
      BL0:=L0;
      BL1:=L1;
    end else begin
      C:=C1;
      aC:=C0;
      BL0:=L1;
      BL1:=L0;
    end;
    W:=VerticalAreaWidth/2;
    VAreaE:=VArea as IDMElement;
    FindVLine(X, Y, Z, BLine, C, aC, VAreaE, BL0, W, Line0, theC);
    m:=0;
    while m<aC.Lines.Count do begin
      BLineE:=aC.Lines.Item[m];
      BLine:=BLineE as ILine;
      if (theC=BLine.NextNodeTo(aC)) or
         (C=BLine.NextNodeTo(aC)) then
        Break
      else
        inc(m)
    end;
    if m=aC.Lines.Count then
      raise Exception.CreateFmt('Error2 in InsertVerticalArea Area.ID=%d',
                               [VAreaE.ID]);
    VArea:=BLine.GetVerticalArea(bdUp);
    VAreaE:=VArea as IDMElement;
    FindVLine(X, Y, Z, BLine, aC, C, VAreaE, BL1, W, Line1, theC);
  end;
  if Line0=nil then Exit;
  if Line1=nil then Exit;
  Line0E:=Line0 as IDMElement;
  Line1E:=Line1 as IDMElement;

  j:=0;
  while j<Line0E.Parents.Count do begin
    AreaE:=Line0E.Parents.Item[j];
    AreaP:=AreaE as IPolyline;
    if AreaP.Lines.IndexOf(Line1E) <>-1 then
      Break
    else
      inc(j)
  end;
  if j=Line0E.Parents.Count then Exit;
  Result:=AreaE as IArea;
  UpdateElement(Result.Volume0 as IDMElement);
  UpdateElement(Result.Volume1 as IDMElement);

  ClearSelection(nil);
end;

procedure TCustomSMDocument.MoveAreas(const DestVolume, SourceVolume:IVolume;
                    const aArea, CuttingArea:IArea);
var
  DestVolumeE, SourceVolumeE, aAreaE, CuttingAreaE, NextAreaE:IDMElement;
  aAreaP, CuttingAreaP:IPolyline;
  aLineE:IDMElement;
  NextArea:IArea;
  j, m:integer;
begin
  DestVolumeE:=DestVolume as IDMElement;
  SourceVolumeE:=SourceVolume as IDMElement;
  aAreaE:=aArea as IDMElement;

  case aAreaE.ID of
  834, 1062:
    XXX:=0;
  end;

  CuttingAreaE:=CuttingArea as IDMElement;
  aAreaP:=aArea as IPolyline;
  CuttingAreaP:=CuttingArea as IPolyline;

  if aArea.Volume0=SourceVolume then begin
    aArea.Volume0IsOuter:=False;
    aArea.Volume0:=DestVolume
  end else begin
    aArea.Volume1IsOuter:=False;
    aArea.Volume1:=DestVolume;
  end;
  for j:=0 to aAreaP.Lines.Count-1 do begin
    aLineE:=aAreaP.Lines.Item[j];
    if CuttingAreaP.Lines.IndexOf(aLineE)=-1 then begin
      m:=0;
      while m<aLineE.Parents.Count do begin
        NextAreaE:=aLineE.Parents.Item[m];
        if (NextAreaE.QueryInterface(IArea, NextArea)=0) and
           (NextAreaE<>aAreaE) and
           (SourceVolume.Areas.IndexOf(NextAreaE)<>-1) then
          MoveAreas(DestVolume, SourceVolume, NextArea, CuttingArea)
        else
          inc(m)    
      end;
    end;
  end;
end;

procedure TCustomSMDocument.DeleteVertical(const DMCollection: IDMCollection);
var
  j:integer;
  Area:IArea;
  VLine0, VLine1, TopLine, BottomLine:ILine;
  BC0, BC1, TC0, TC1:ICoordNode;
  Polyline:IPolyline;
  AreaE, TopLineE, BottomLineE, VLine0E, VLine1E, aAreaE,
  TC0E, TC1E:IDMElement;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  aList:TList;

  procedure DiagDivideVolume(const aVolume:IVolume);
  var
    theAreaE, theVolumeE, theSideAreaE, theLineE, aLineE, RefParent,
    BottomAreaE, aVolumeE:IDMElement;
    theArea, BottomArea:IArea;
    aAreaP, TopAreaP:IPolyline;
    theVolume:IVolume;
    j, m:integer;
    theLine, aLine:ILine;
    TC, C1:ICoordNode;
    VolumeU:IUnknown;
    AreaU:IUnknown;
    LineU:IUnknown;
  begin
    if aVolume=nil then Exit;
    if aVolume.BottomAreas.Count=0 then Exit;
    aVolumeE:=aVolume as IDMElement;
    BottomAreaE:=aVolume.BottomAreas.Item[0];
    BottomArea:=BottomAreaE as IArea;

    AddElement( BottomLineE.Parent,
                     SpatialModel2.Volumes, '', ltOneToMany, VolumeU, True);
    theVolumeE:=VolumeU as IDMElement;
    theVolume:=theVolumeE as IVolume;
    RefParent:=aVolumeE.Ref.Parent;
    ChangeParent( nil, nil, aVolumeE.Ref);
    theVolumeE.Ref:=CreateClone(aVolumeE.Ref) as IDMElement;

    AddElement( BottomLineE.Parent,
                      SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
    theAreaE:=AreaU as IDMElement;
    theArea:=theAreaE as IArea;
    theAreaE.Ref:=CreateClone(BottomAreaE.Ref) as IDMElement;
    ChangeParent( nil, BottomAreaE.Ref.Parent, theAreaE.Ref);

    BottomLineE.AddParent(theAreaE);

    if aVolume.TopAreas.Count>0 then begin
      TopAreaP:=aVolume.TopAreas.Item[0] as IPolyline;
      for j:=0 to TopAreaP.Lines.Count-1 do begin
        aLineE:=TopAreaP.Lines.Item[j];
        aLine:=aLineE as ILine;
        if (aLine.C0<>TC0) and
           (aLine.C0<>TC1) and
           (aLine.C1<>TC0) and
           (aLine.C1<>TC1) then
          aLineE.AddParent(theAreaE);
      end;
    end;

    aList.Clear;
    for j:=0 to aVolume.Areas.Count-1 do
      aList.Add(pointer(aVolume.Areas.Item[j]));
    for j:=0 to aList.Count-1 do begin
      aAreaE:=IDMElement(aList[j]);
      if (aAreaE <> AreaE) and
         (aAreaE as IArea).IsVertical then begin
        aAreaP:=aAreaE as IPolyline;
        if aAreaP.Lines.IndexOf(VLine0E)<>-1 then begin
          AddElement( BottomLineE.Parent,
                      SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
          theSideAreaE:=AreaU as IDMElement;
          TC:=TC0;
          m:=0;
          aLineE:=nil;
          while m<TC.Lines.Count do begin
            aLineE:=TC.Lines.Item[m];
            if(TopAreaP.Lines.IndexOf(aLineE)<>-1) and
              (aAreaP.Lines.IndexOf(aLineE)<>-1) then
              Break
            else
              inc(m);
          end;
          C1:=(aLineE as ILine).NextNodeTo(TC);

          m:=0;
          while m<BC0.Lines.Count do begin
            if C1=(BC0.Lines.Item[m] as ILine).NextNodeTo(BC0) then
              Break
            else
              inc(m)
          end;
          if m=BC0.Lines.Count then begin
            AddElement( BottomLineE.Parent,
                        SpatialModel.Lines, '', ltOneToMany, LineU, True);
            theLineE:=LineU as IDMElement;
            theLine:=theLineE as ILine;
            theLine.C0:=BC0;
            theLine.C1:=C1;
            LineUpdateAreas(theLine);
          end else begin
            theLineE:=BC0.Lines.Item[m];
            theLine:=theLineE as ILine;
          end;

          theLineE.AddParent(theAreaE);
        end;
        if aAreaP.Lines.IndexOf(VLine1E)<>-1 then begin
          AddElement( BottomLineE.Parent,
                      SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
          theSideAreaE:=AreaU as IDMElement;
          TC:=TC1;
          m:=0;
          aLineE:=nil;
          while m<TC.Lines.Count do begin
            aLineE:=TC.Lines.Item[m];
            if(TopAreaP.Lines.IndexOf(aLineE)<>-1) and
              (aAreaP.Lines.IndexOf(aLineE)<>-1) then
              Break
            else
              inc(m);
          end;
          C1:=(aLineE as ILine).NextNodeTo(TC);

          m:=0;
          while m<BC1.Lines.Count do begin
            if C1=(BC1.Lines.Item[m] as ILine).NextNodeTo(BC1) then
              Break
            else
              inc(m)
          end;
          if m=BC1.Lines.Count then begin
            AddElement( BottomLineE.Parent,
                        SpatialModel.Lines, '', ltOneToMany, LineU, True);
            theLineE:=LineU as IDMElement;
            theLine:=theLineE as ILine;
            theLine.C0:=BC1;
            theLine.C1:=C1;
            LineUpdateAreas(theLine);
          end else begin
            theLineE:=BC1.Lines.Item[m];
            theLine:=theLineE as ILine;
          end;
          theLineE.AddParent(theAreaE);
        end;
      end;
    end;
    UpdateElement( theAreaE);
    UpdateCoords( theAreaE);

    MoveAreas(theVolume, aVolume,
              BottomArea, theArea);

    theArea.Volume0IsOuter:=False;
    theArea.Volume0:=aVolume;
    theArea.Volume1IsOuter:=False;
    theArea.Volume1:=theVolume;

    ChangeParent( nil, RefParent, aVolumeE.Ref);
    ChangeParent( nil, RefParent, theVolumeE.Ref);

    UpdateElement(  theVolumeE);
    UpdateElement(  aVolumeE);
  end;

var
   Volume0, Volume1:IVolume;
begin
  aList:=TList.Create;
  SpatialModel:=Get_DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  for j:=0 to DMCollection.Count-1 do begin
    AreaE:=DMCollection.Item[j];
    if AreaE.QueryInterface(IArea, Area)<>0 then Exit;
    if Area.TopLines.Count<>1 then Exit;
    if Area.BottomLines.Count<>1 then Exit;
    Polyline:=AreaE as IPolyline;

    TopLineE:=Area.TopLines.Item[0];
    TopLine:=TopLineE as ILine;
    BottomLineE:=Area.BottomLines.Item[0];
    BottomLine:=BottomLineE as ILine;
    BC0:=BottomLine.C0;
    BC1:=BottomLine.C1;
    VLine0:=BC0.GetVerticalLine(bdUp);
    VLine1:=BC1.GetVerticalLine(bdUp);

    VLine0E:=VLine0 as IDMElement;
    VLine1E:=VLine1 as IDMElement;

    TC0:=VLine0.NextNodeTo(BC0);
    TC1:=VLine1.NextNodeTo(BC1);

    TC0E:=TC0 as IDMElement;
    TC1E:=TC1 as IDMElement;

    Volume0:=Area.Volume0;
    Volume1:=Area.Volume1;
    DiagDivideVolume(Volume0);
    DiagDivideVolume(Volume1);
  end;
  aList.Free;
end;

function TCustomSMDocument.Get_OperationStep: Integer;
begin
  Result:=FOperationStep
end;

function TCustomSMDocument.Get_OperationX0: Double;
begin
  Result:=FOperationX0
end;

function TCustomSMDocument.Get_OperationY0: Double;
begin
  Result:=FOperationY0
end;

function TCustomSMDocument.Get_OperationZ0: Double;
begin
  Result:=FOperationZ0
end;

procedure TCustomSMDocument.Set_OperationStep(Value: Integer);
begin
  FOperationStep:=Value
end;

procedure TCustomSMDocument.Set_OperationX0(Value: Double);
begin
  FOperationX0:=Value
end;

procedure TCustomSMDocument.Set_OperationY0(Value: Double);
begin
  FOperationY0:=Value
end;

procedure TCustomSMDocument.Set_OperationZ0(Value: Double);
begin
  FOperationZ0:=Value
end;

procedure TCustomSMDocument.MouseDrag;
var
  CurrentOperation:TSMOperation;
begin
  CurrentOperation:=TSMOperation(FCurrentOperation);
  if FCurrentOperation<>nil then
    CurrentOperation.Drag(Self);
end;

procedure TCustomSMDocument.ZoomSelection;
var
  MinX, MinY, MinZ,
  MaxX, MaxY, MaxZ: Double;
  View:IView;
begin
  if Get_SelectionCount=0 then Exit;
  CalcSelectionLimits(MinX, MinY, MinZ, MaxX, MaxY, MaxZ);
  View:=FPainter.View;
  View.CX:=(MinX+MaxX)/2;
  View.CY:=(MinY+MaxY)/2;
  View.CZ:=(MinZ+MaxZ)/2;
  if MinY<>MaxY then begin
     if (MaxX<>MinX) and
        (FPainter.HHeight/FPainter.HWidth>Abs((MaxY-MinY)/(MaxX-MinX))) then
        View.RevScale:=5*Abs(MaxX-MinX)/FPainter.HWidth
     else
        View.RevScale:=5*Abs(MaxY-MinY)/FPainter.HHeight
  end else
  if MinX<>MaxX then
     View.RevScale:=5*Abs(MaxX-MinX)/FPainter.HWidth
  else
     View.RevScale:=5*2000/FPainter.HWidth
end;

procedure TCustomSMDocument.LoadTransactions(const FileName: WideString);
var
  P:pointer;
begin
  P:=pointer(FPainter);
  FPainter:=nil;
  try
    inherited;
  finally
    FPainter:=IPainter(P);
  end;
end;


function TCustomSMDocument.BuildVerticalArea(const BLine: ILine;
   Direction: integer; BuildVolumeFlag: WordBool;
   NodeList, LineList, UpdateList:TList): IDMElement;

{если BuildVolumeFlag=True, то верт.плоск. строится, только если линия замыкается на
 плоскости (VLine0<>nil и VLine1<>nil), при этом производится разделение объема -
 если BuildVolumeFlag=False, то верт.плоск. строится всегда и не производится разделение
 объема.  }

var
  SpatialModel2: ISpatialModel2;
  j:integer;
  H0,H1,Height, HV, H:double;
  VLine0, VLine1:ILine;
  VLine0E, VLine1E, HLineE, BLineE:IDMElement;
  BLineS, VLine0S, VLine1S:ISpatialElement;
  C0,C1:ICoordNode;
  DividingArea, Area0, Area1, aArea:IArea;
  DividingAreaP:IPolyline;
  SpatialModel:ISpatialModel;
  VolumeE, NewVolumeE, NodeE:IDMElement;
  Volume, NewVolume:IVolume;
  aRefElement, RefParent:IDMElement;
  LineU:IUnknown;
  AreaU:IUnknown;
  VolumeU:IUnknown;
  NewVolumes:IDMCollection;
  VLinesCol0,VLinesCol1,BLinesCol:IDMCollection;
  DataModel:IDataModel;

  function FindNode(X, Y, Z:double):ICoordNode;
  var
    k, m:integer;
    aC, C0, C1:ICoordNode;
    aLineE, NodeE, LineE, aParent:IDMelement;
    aLine, Line:ILine;
    X0, Y0, Z0, X1, Y1, Z1, D, ZZ, absD:double;
    NodeU, LineU:IUnknown;
  begin
    Result:=nil;
    k:=0;
    while k<NodeList.Count do begin
      aC:=ICoordNode(NodeList[k]);
      if (abs(aC.X-X)<1) and
         (abs(aC.Y-Y)<1) then
        Break
      else
        inc(k)
    end;
    if k<NodeList.Count then begin
      Result:=aC;
      Exit;
    end;
    AddElement(BLineE.Parent, SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
    NodeE:=NodeU as IDMElement;
    Result:=NodeE as ICoordNode;
    Result.X:=X;
    Result.Y:=Y;
    Result.Z:=Z;
    X0:=0;
    Y0:=0;
    X1:=0;
    Y1:=0;
    k:=0;
    while k<LineList.Count do begin
      aLineE:=IDMElement(LineList[k]);
      aLine:=aLineE as ILine;
      C0:=aLine.C0;
      C1:=aLine.C1;
      X0:=C0.X;
      Y0:=C0.Y;
      X1:=C1.X;
      Y1:=C1.Y;
      D:=((X0-X)*(X1-X)+(Y0-Y)*(Y1-Y))/
                sqrt(sqr(X0-X)+sqr(Y0-Y))/
                sqrt(sqr(X1-X)+sqr(Y1-Y));
      absD:=abs(D);
      if (D<=0) and
         (abs(absD-1)<0.09) then
        Break
      else
        inc(k)
    end;
    if k<LineList.Count then begin
      Z0:=C0.Z;
      Z1:=C1.Z;
      if X0<>X1 then
        ZZ:=Z0+(Z1-Z0)/(X1-X0)*(X-X0)
      else
        ZZ:=Z0+(Z1-Z0)/(Y1-Y0)*(Y-Y0);
      Result.Z:=ZZ;
      AddElement(BLineE.Parent, SpatialModel.Lines, '', ltOneToMany, LineU, True);
      LineE:=LineU as IDMElement;
      Line:=LineE as ILine;
      Line.C0:=Result;
      Line.C1:=aLine.C1;
      aLine.C1:=Result;
      for m:=0 to aLineE.Parents.Count-1 do begin
        aParent:=aLineE.Parents.Item[m];
        LineE.AddParent(aParent);
        aParent.Update;
        if UpdateList.IndexOf(pointer(aParent))=-1 then
          UpdateList.Add(pointer(aParent));
      end;
      LineList.Add(pointer(LineE));
    end;
  end; // FindNode

var
  X, Y, Z:double;
  Node:ICoordNode;
  ConnectingLineList:TList;
begin
                    { TODO -o Gol -c find :  BuildVerticalArea }
  Result:=nil;

  DataModel:=Get_DataModel as IDataModel;
  BLinesCol:=DataModel.CreateCollection(-1, nil);
  (BLinesCol as IDMCollection2).Add(BLine as IDMElement);

  C0:=BLine.C0;
  C1:=BLine.C1;

  aArea :=AreaWithInternalNode(C0, C1, nil, 0, True);
  HV:=0;
  if aArea=nil then begin
    IntersectHLine (BLinesCol);
    if BLinesCol.Count=1 then
      Exit
    else begin
      aArea :=AreaWithInternalNode(BLine.C0, BLine.C1, nil, 0, True);
      if aArea=nil then Exit;
      for j:=0 to BLinesCol.Count-1 do
        UpdateAreas(BLinesCol.Item[j]);
    end;
  end;

  if Direction=bdUp then
   if aArea.Volume0<>nil then
    Volume:=aArea.Volume0
   else
    Exit
  else
   if Direction=bdDown then
    if aArea.Volume1<>nil then
      Volume:=aArea.Volume1
    else
     Exit;

  case Direction of
    bdUp  :HV:=Volume.MaxZ-Volume.MinZ;
    bdDown:HV:=Volume.MinZ-Volume.MaxZ;
  end; //case

  SpatialModel:=Get_DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  BLineE:=BLine as IDMElement;
  BLineS:=BLineE as ISpatialElement;
  VLinesCol0:=DataModel.CreateCollection(-1, nil);
  VLinesCol1:=DataModel.CreateCollection(-1, nil);

  Height:=HV;

  H0:=0;
  Repeat
    VLine0:=C0.GetVerticalLine(Direction);
    if VLine0=nil then
      DivideVerticalArea(C0, Direction, VLine0);

    if (VLine0=nil)and(not BuildVolumeFlag) then begin
      AddElement( BLineE.Parent, SpatialModel.Lines,   { new VLine}
                              '', ltOneToMany, LineU, True);
      VLine0E:=LineU as IDMElement;
      VLine0:=VLine0E as ILine;
      VLine0S:=VLine0E as ISpatialElement;

      VLine0.Thickness:=0;
      if BLineS.Layer.Expand then begin
        VLine0.Style:=BLine.Style;
        VLine0S.Color:=BLineS.Color;
        VLine0S.Layer:=BLineS.Layer;
      end;

      X:=C0.X;
      Y:=C0.Y;
      Z:=C0.Z+Height;  // при bdDown Height<0

      Node:=FindNode(X, Y, Z);

      case Direction of
      bdUp  :begin
             VLine0.C0:=C0;
             VLine0.C1:=Node;
            end;
      bdDown:begin
             VLine0.C1:=C0;
             VLine0.C0:=NodeE as ICoordNode;
            end;
      end; //case
    end else
      if VLine0=nil then
       Exit;

    VLine0E:=VLine0 as IDMElement;
    (VLinesCol0 as IDMCollection2).Add(VLine0E);
    case Direction of
    bdUp  :begin
           C0:=(VLine0E as ILine).C1;
           H:=VLine0.C1.Z-VLine0.C0.Z;
          end;
    bdDown:begin
           C0:=(VLine0E as ILine).C0;
           H:=VLine0.C0.Z-VLine0.C1.Z;
          end;
    else
      H:=0;
    end; //case
    H0:=H0+H;
  Until abs(HV)<=abs(H0);

  H1:=0;
  Repeat
    VLine1:=C1.GetVerticalLine(Direction);
    if VLine1=nil then
      DivideVerticalArea(C1, Direction, VLine1);

    if (VLine1=nil)
         and (not BuildVolumeFlag) then begin
     AddElement( BLineE.Parent, SpatialModel.Lines,   { new VLine}
                              '', ltOneToMany, LineU, True);
     VLine1E:=LineU as IDMElement;
     VLine1:=VLine1E as ILine;
     VLine1S:=VLine1E as ISpatialElement;

     VLine1.Thickness:=0;
     if BLineS.Layer.Expand then begin
      VLine1.Style:=BLine.Style;
      VLine1S.Color:=BLineS.Color;
      VLine1S.Layer:=BLineS.Layer;
     end;

    X:=C1.X;
    Y:=C1.Y;
    Z:=C1.Z+Height;  // при bdDown Height<0

    Node:=FindNode(X, Y, Z);

    case Direction of
    bdUp  :begin
           VLine1.C0:=C1;
           VLine1.C1:=Node;
          end;
    bdDown:begin
           VLine1.C1:=C1;
           VLine1.C0:=NodeE as ICoordNode;
          end;
    end; //case
  end else
    if VLine1=nil then
     Exit;

    VLine1E:=VLine1 as IDMElement;
    (VLinesCol1 as IDMCollection2).Add(VLine1E);
    case Direction of
    bdUp  :begin
             C1:=(VLine1E as ILine).C1;
             H:=VLine1.C1.Z-VLine1.C0.Z;
            end;
    bdDown:begin
             C1:=(VLine1E as ILine).C0;
             H:=VLine1.C0.Z-VLine1.C1.Z;
            end;
    end; //case
    H1:=H1+H;
  Until abs(HV)<=abs(H1);

  ConnectingLineList:=TList.Create;
  BuildConnectingLineList(C0, C1, BLineE.Parent, ConnectingLineList, True);

  AddElement( BLineE.Parent,
                          SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
  Result:=AreaU as IDMElement;
  DividingArea:=Result as IArea;
  DividingAreaP:=Result as IPolyline;
  DividingArea.IsVertical:=True;

  for j:=0 to BLinesCol.Count-1 do
    BLinesCol.Item[j].AddParent(Result);
  for j:=0 to VLinesCol0.Count-1 do
    VLinesCol0.Item[j].AddParent(Result);
  for j:=0 to VLinesCol1.Count-1 do
    VLinesCol1.Item[j].AddParent(Result);
  for j:=0 to ConnectingLineList.Count-1 do begin
    HLineE:=IDMElement(ConnectingLineList[j]);
    HLineE.AddParent(Result);
  end;
  ConnectingLineList.Free;

  Area0:=nil;
  Area1:=nil;
  for j:=0 to BLineE.Parents.Count-1 do begin
    if (BLineE.Parents.Item[j].QueryInterface(IArea, aArea)=0) and
       not aArea.IsVertical then begin
      if Area0=nil then
        Area0:=aArea
      else
      if Area1=nil then
        Area1:=aArea
    end;
  end;

  UpdateElement( Result);

  if (Area0<>nil)
     and(BuildVolumeFlag) then begin

    case Direction of
    bdUp  :Volume:=Area0.Volume0;
    bdDown:Volume:=Area0.Volume1;
    end;
    VolumeE:=Volume as IDMElement;

    AddElement( BLineE.Parent,
                          SpatialModel2.Volumes, '', ltOneToMany, VolumeU, True);
    NewVolumeE:=VolumeU as IDMElement;
    NewVolume:=NewVolumeE as IVolume;
    aRefElement:=CreateClone(VolumeE.Ref) as IDMElement;
    NewVolumeE.Ref:=aRefElement;

    RefParent:=VolumeE.Ref.Parent;

    MoveAreas(NewVolume, Volume, Area1, DividingArea);

    DividingArea.Volume0IsOuter:=False;
    DividingArea.Volume0:=Volume;
    DividingArea.Volume1IsOuter:=False;
    DividingArea.Volume1:=NewVolume;

    UpdateElement( VolumeE);
    UpdateElement( NewVolumeE);

    ChangeParent( nil, RefParent, aRefElement);

    NewVolumes:=DataModel.CreateCollection(-1, nil);
    (NewVolumes as IDMCollection2).Add(NewVolumeE);
    SpatialModel2.CheckVolumeContent(NewVolumes, Volume, 0);
  end;

  UpdateCoords( Result);
end;

function TCustomSMDocument.LineDivideArea(const C0, C1:ICoordNode; const aArea: IArea):IArea; safecall;
var
  Line1,  Line2: ILine;
  Line1E, Line2E:IDMElement;
  NewArea:IArea;
  aAreaE:IDMElement;
  aAreaP:IPolyline;
  i, k:integer;
  NewAreaE, RefElement:IDMElement;
  NewAreaU:IUnknown;
begin

    aAreaE:=aArea as IDMElement;
    aAreaP:=aArea as IPolyline;

    AddElement( aAreaE.Parent,
           (Get_DataModel as IDMElement).Collection[_Area], '',
           ltOneToMany, NewAreaU, True);
    NewAreaE:=NewAreaU as IDMElement;
    NewArea:=NewAreaE as IArea;

    if aAreaE.Ref<>nil then begin
      RefElement:=CreateClone(aAreaE.Ref) as IDMElement;
      NewAreaE.Ref:=RefElement;
    end;

    NewArea.IsVertical:=aArea.IsVertical;
    NewArea.Volume0IsOuter:=aArea.Volume0IsOuter;
    NewArea.Volume0:=aArea.Volume0;
    NewArea.Volume1IsOuter:=aArea.Volume1IsOuter;
    NewArea.Volume1:=aArea.Volume1;

    k:=0;

    for i:=0 to (aAreaP.Lines.Count-2) do begin      //
      Line1E:=aAreaP.Lines.Item[i];
      Line1:=Line1E as ILine;
      Line2E:=aAreaP.Lines.Item[i+1];
      Line2:=Line2E as ILine;

      if (((Line1.C0=Line2.C0)and(Line1.C0=C0))
        or((Line1.C0=Line2.C0)and(Line1.C0=C1))
        or((Line1.C0=Line2.C1)and(Line1.C0=C0))
        or((Line1.C0=Line2.C1)and(Line1.C0=C1))
        or((Line1.C1=Line2.C0)and(Line1.C1=C0))
        or((Line1.C1=Line2.C0)and(Line1.C1=C1))
        or((Line1.C1=Line2.C1)and(Line1.C1=C0))
        or((Line1.C1=Line2.C1)and(Line1.C1=C1))) then
      begin
       k:=i+1;
       Break;
      end;
    end;

    try
    while (aAreaP.Lines.Count>1) and
       (aAreaP.Lines.Count>=k+1) do  begin

      Line1E:=aAreaP.Lines.Item[k];
      Line1:=Line1E as ILine;
      Line2E:=aAreaP.Lines.Item[k+1];
      Line2:=Line2E as ILine;

      Line1E.RemoveParent(aAreaE);
      Line1E.AddParent(NewAreaE);

      if (((Line1.C0=Line2.C0)and(Line1.C0=C0))
        or((Line1.C0=Line2.C0)and(Line1.C0=C1))
        or((Line1.C0=Line2.C1)and(Line1.C0=C0))
        or((Line1.C0=Line2.C1)and(Line1.C0=C1))
        or((Line1.C1=Line2.C0)and(Line1.C1=C0))
        or((Line1.C1=Line2.C0)and(Line1.C1=C1))
        or((Line1.C1=Line2.C1)and(Line1.C1=C0))
        or((Line1.C1=Line2.C1)and(Line1.C1=C1)))then
           Break;

    end;
    except
      raise
    end;

    result:=NewAreaE as IArea;


end;

function TCustomSMDocument.BuildVolume(const BaseAreas:IDMCollection;
            Height: Double; Direction: Integer;
            const ParentVolume:IVolume; AddView:WordBool): IDMElement;
begin
  if Direction=bdUp then
    Result:=BuildVolumeUp(BaseAreas, Height, ParentVolume, AddView)
  else
    Result:=BuildVolumeDown(BaseAreas, Height, ParentVolume, AddView)
end;
//___________
procedure TCustomSMDocument.BaseBuildingVolumeCheck(const BaseAreas:IDMCollection);
var
 aBaseZoneE,aBaseZoneKindE,aBaseZoneTypeE:IDMElement;
 aVolume0,aVolume1:IVolume;
begin
 aVolume1:=(BaseAreas.Item[0] as IArea).Volume1;
 if aVolume1<>nil then begin
  aBaseZoneE:=(aVolume1 as IDMElement).Ref;
  if aBaseZoneE<>nil then begin
   aBaseZoneKindE:=aBaseZoneE.Ref;
   if aBaseZoneKindE<>nil then begin
    aBaseZoneTypeE:=aBaseZoneKindE.Parent;
    if aBaseZoneTypeE<>nil then
     aVolume0:=(BaseAreas.Item[0] as IArea).Volume0;
   end;
  end;
 end;
end;
//___________
function TCustomSMDocument.BuildVolumeUp(
  const BaseAreas:IDMCollection; Height:double;
  const ParentVolume:IVolume; AddView:WordBool): IDMElement;
var
  VolumeE, aBasePolylineE:IDMElement;
  SpatialModel2:ISpatialModel2;
  aCollection:IDMCollection;
  BaseAreas2:IDMCollection2;
  DataModel:IDataModel;
begin


  DataModel:=Get_DataModel as IDataModel;
  aCollection:=DataModel.CreateCollection(-1, nil);
  BaseAreas2:=BaseAreas as IDMCollection2;

  SpatialModel2:=DataModel as ISpatialModel2;

  Result:=nil;
  aBasePolylineE:=nil;

  while (Height>0) and
        (BaseAreas.Count<>0) do begin
    VolumeE:=DoBuildVolume(BaseAreas, Height, SpatialModel2,
                             ParentVolume, AddView, bdUp);
    if Result=nil then
      Result:=VolumeE
    else
      if aBasePolylineE<>nil then
       (aCollection as IDMCollection2).Add(aBasePolylineE);
    if (VolumeE as IVolume).TopAreas.Count>0 then begin
      aBasePolylineE:=(VolumeE as IVolume).TopAreas.Item[0];
      BaseAreas2.Clear;
      BaseAreas2.Add(aBasePolylineE);
    end else
      aBasePolylineE:=nil
  end;

  if aCollection.Count>0 then
    DeleteElements(aCollection, False);

//    BaseBuildingVolumeCheck(BaseAreas); //!!!  !!!!  !!!!!

end;

function TCustomSMDocument.BuildVolumeDown(const BaseAreas:IDMCollection;
                     Height:double; const ParentVolume:IVolume; AddView:WordBool):IDMElement;
var
  VolumeE, aBasePolylineE:IDMElement;
  SpatialModel2:ISpatialModel2;
  aCollection:IDMCollection;
  BaseAreas2:IDMCollection2;
  DataModel:IDataModel;
begin
  DataModel:=Get_DataModel as IDataModel;
  aCollection:=DataModel.CreateCollection(-1, nil);
  BaseAreas2:=BaseAreas as IDMCollection2;

  SpatialModel2:=DataModel as ISpatialModel2;

  Result:=nil;
  aBasePolylineE:=nil;

  while (Height>0) and
        (BaseAreas.Count<>0) do begin
    VolumeE:=DoBuildVolume(BaseAreas, Height, SpatialModel2,
                               ParentVolume, AddView, bdDown);
//    if Result=nil then
      Result:=VolumeE;
//    else
    if aBasePolylineE<>nil then
      (aCollection as IDMCollection2).Add(aBasePolylineE);
    if (VolumeE as IVolume).BottomAreas.Count>0 then begin
      aBasePolylineE:=(VolumeE as IVolume).BottomAreas.Item[0];
      BaseAreas2.Clear;
      BaseAreas2.Add(aBasePolylineE);
    end else
      aBasePolylineE:=nil
  end;

  if aCollection.Count>0 then
    DeleteElements(aCollection, False);
end;

procedure  TCustomSMDocument.CheckHAreas(const ParentVolume, Volume:IVolume;
                             BuildDirection:integer;
                             CommonVolumeFlag:WordBool);
  var
    aLineList0:TList;
    aAreaP, AreaP:IPolyline;
    j, j1, m, k, i:integer;
    aLineE, aAreaE, AreaE:IDMElement;
    PX, PY, PZ:double;
    aArea, Area:IArea;
    LineCollection:IDMCollection;
    LineCollection2:IDMCollection2;
    DataModel:IDataModel;
  begin
    if (ParentVolume as IDMElement).Ref.Parent=nil then Exit;
    DataModel:=Get_DataModel as IDataModel;



    aLineList0:=TList.Create;
    LineCollection:=DataModel.CreateCollection(-1, nil);
    LineCollection2:=LineCollection as IDMCollection2;

    if (BuildDirection=0)then begin

      if not CommonVolumeFlag then begin
        for j1:=0 to ParentVolume.TopAreas.Count-1 do begin
          AreaE:=ParentVolume.TopAreas.Item[j1];
          Area:=AreaE as IArea;
          AreaP:=AreaE as IPolyline;
          for j:=0 to Volume.TopAreas.Count-1 do begin
            aAreaE:=Volume.TopAreas.Item[j];
            aArea:=aAreaE as IArea;
            aArea.GetCentralPoint(PX, PY, PZ);
            if Area.ProjectionContainsPoint(PX, PY, 0) and
               (PZ>=Area.MinZ-1.e-6) and
               (PZ<=Area.MaxZ+1.e-6) then begin
              if (aArea.Volume0=nil) and
                 (Area.Volume0<>nil) then begin
                aArea.Volume0IsOuter:=Area.Volume0IsOuter;
                aArea.Volume0:=Area.Volume0;
              end;
              if (AreaE.Ref.Ref<>aAreaE.Ref.Ref) and
                 ((AreaE.Ref.Ref=nil) or (aAreaE.Ref.Ref=nil) or
                 (AreaE.Ref.Ref.Parent=aAreaE.Ref.Ref.Parent)) then begin
                aAreaE.Ref.Name:=Format('%s /%d',[AreaE.Ref.Name, j]);
                PasteToElement( AreaE.Ref, aAreaE.Ref, False, True);
              end;
            end;
          end;
        end;
      end else {
      if ParentVolume.ContainsVolume(Volume) then} begin
        if ParentVolume.TopAreas.Count>0 then begin
          AreaE:=ParentVolume.TopAreas.Item[0];
          Area:=AreaE as IArea;
          for j:=0 to Volume.TopAreas.Count-1 do begin
            aAreaE:=Volume.TopAreas.Item[j];
            aArea:=aAreaE as IArea;
            if (aArea.Volume0=nil) and
               (Area.Volume0<>nil) then begin
              aArea.Volume0IsOuter:=Area.Volume0IsOuter;
              aArea.Volume0:=Area.Volume0;
            end;
            if (AreaE.Ref.Ref<>aAreaE.Ref.Ref) and
               ((AreaE.Ref.Ref=nil) or (aAreaE.Ref.Ref=nil) or
               (AreaE.Ref.Ref.Parent=aAreaE.Ref.Ref.Parent)) then begin
              aAreaE.Ref.Name:=Format('%s /%d',[AreaE.Ref.Name, j]);
              PasteToElement( AreaE.Ref, aAreaE.Ref, False, True);
            end;
          end;
        end;
      end;

      if ParentVolume.TopAreas.Count>1 then begin
        for m:=0 to ParentVolume.TopAreas.Count-1 do begin
          AreaP:=ParentVolume.TopAreas.Item[m] as IPolyline;
          aArea:=AreaP as IArea;
          for k:=0 to AreaP.Lines.Count-1 do begin
            aLineE:=AreaP.Lines.Item[k];
            i:=aLineList0.IndexOf(pointer(aLineE));
            if i=-1 then
              aLineList0.Add(pointer(aLineE))
            else
              aLineList0.Delete(i)
          end;
        end;

        for m:=0 to ParentVolume.TopAreas.Count-1 do begin
          AreaP:=ParentVolume.TopAreas.Item[m] as IPolyline;
          for k:=0 to AreaP.Lines.Count-1 do begin
            aLineE:=AreaP.Lines.Item[k];
            if (aLineList0.IndexOf(pointer(aLineE))=-1) and
               (LineCollection.IndexOf(aLineE)=-1)then
              LineCollection2.Add(aLineE)
          end;
        end;

        if Volume.TopAreas.Count>0 then begin
          aAreaP:=Volume.TopAreas.Item[0] as IPolyline;
          for m:=0 to aAreaP.Lines.Count-1 do begin
            aLineE:=aAreaP.Lines.Item[m];
            if (aLineList0.IndexOf(pointer(aLineE))=-1) and
               (LineCollection.IndexOf(aLineE)=-1)then
              LineCollection2.Add(aLineE)
          end;
        end;
      end;
    end else
    if (BuildDirection=1) then begin

      if not CommonVolumeFlag then begin
        for j1:=0 to ParentVolume.BottomAreas.Count-1 do begin
          AreaE:=ParentVolume.BottomAreas.Item[j1];
          Area:=AreaE as IArea;
          AreaP:=AreaE as IPolyline;
          for j:=0 to Volume.BottomAreas.Count-1 do begin
            aAreaE:=Volume.BottomAreas.Item[j];
            aArea:=aAreaE as IArea;
            aArea.GetCentralPoint(PX, PY, PZ);
            if Area.ProjectionContainsPoint(PX, PY, 0) and
               (PZ>=Area.MinZ) and
               (PZ<=Area.MaxZ) then begin
              if (aArea.Volume1=nil) and
                 (Area.Volume1<>nil) then begin
                aArea.Volume1IsOuter:=Area.Volume1IsOuter;
                aArea.Volume1:=Area.Volume1;
             end;
             if (AreaE.Ref.Ref<>aAreaE.Ref.Ref) and
                 ((AreaE.Ref.Ref=nil) or (aAreaE.Ref.Ref=nil) or
                 (AreaE.Ref.Ref.Parent=aAreaE.Ref.Ref.Parent)) then begin
               aAreaE.Ref.Name:=Format('%s /%d',[AreaE.Ref.Name, j]);
               PasteToElement( AreaE.Ref, aAreaE.Ref, False, True);
             end;
            end;
          end;
        end;
      end else
      if ParentVolume.ContainsVolume(Volume) then begin
        if ParentVolume.BottomAreas.Count>0 then begin
          AreaE:=ParentVolume.BottomAreas.Item[0];
          Area:=AreaE as IArea;
          for j:=0 to Volume.BottomAreas.Count-1 do begin
            aAreaE:=Volume.BottomAreas.Item[j];
            aArea:=aAreaE as IArea;
            if (aArea.Volume1=nil) and
               (Area.Volume1<>nil) then begin
                aArea.Volume1IsOuter:=Area.Volume1IsOuter;
                aArea.Volume1:=Area.Volume1;
            end;
            if (AreaE.Ref.Ref<>aAreaE.Ref.Ref) and
                 ((AreaE.Ref.Ref=nil) or (aAreaE.Ref.Ref=nil) or
                 (AreaE.Ref.Ref.Parent=aAreaE.Ref.Ref.Parent)) then begin
              aAreaE.Ref.Name:=Format('%s /%d',[AreaE.Ref.Name, j]);
              PasteToElement( AreaE.Ref, aAreaE.Ref, False, True);
            end;
          end;
        end;
      end;

      if ParentVolume.BottomAreas.Count>1 then begin
        for m:=0 to ParentVolume.BottomAreas.Count-1 do begin
          AreaP:=ParentVolume.BottomAreas.Item[m] as IPolyline;
          aArea:=AreaP as IArea;
          for k:=0 to AreaP.Lines.Count-1 do begin
            aLineE:=AreaP.Lines.Item[k];
            i:=aLineList0.IndexOf(pointer(aLineE));
            if i=-1 then
              aLineList0.Add(pointer(aLineE))
            else
              aLineList0.Delete(i)
          end;
        end;

        for m:=0 to ParentVolume.BottomAreas.Count-1 do begin
          AreaP:=ParentVolume.BottomAreas.Item[m] as IPolyline;
          for k:=0 to AreaP.Lines.Count-1 do begin
            aLineE:=AreaP.Lines.Item[k];
           if (aLineList0.IndexOf(pointer(aLineE))=-1) and
               (LineCollection.IndexOf(aLineE)=-1)then
              LineCollection2.Add(aLineE)
          end;
        end;

        if Volume.BottomAreas.Count>0 then begin
          aAreaP:=Volume.BottomAreas.Item[0] as IPolyline;
          for m:=0 to aAreaP.Lines.Count-1 do begin
            aLineE:=aAreaP.Lines.Item[m];
            if (aLineList0.IndexOf(pointer(aLineE))=-1) and
               (LineCollection.IndexOf(aLineE)=-1)then
              LineCollection2.Add(aLineE)
          end;
        end;
      end;
    end;

    aLineList0.Free;

    if LineCollection.Count>0 then
      IntersectLines(LineCollection)
  end;

procedure TCustomSMDocument.IntersectLines(const Collection: IDMCollection);

var
  SpatialModel:ISpatialModel;
  LineList, AreaList:TList;
  NodeU:IUnknown;
  LineU:IUnknown;

  procedure DoIntersect(Line0, Line1:ILine; PX, PY, PZ:double;
                        var aLine0, aLine1:ILine);
  var
    aCE, aLine0E, aLine1E, Line0E, Line1E, aParent:IDMElement;
    j:integer;
    aC, aC1:ICoordNode;
    aLine:ILine;
  begin
     Line0E:=Line0 as IDMElement;
     Line1E:=Line1 as IDMElement;

    AddElement( (Line0 as IDMElement).Parent,
                         SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
    aCE:=NodeU as IDMElement;
    aC:=aCE as ICoordNode;
    ChangeFieldValue( aCE, ord(cooX), True, PX);
    ChangeFieldValue( aCE, ord(cooY), True, PY);
    ChangeFieldValue( aCE, ord(cooZ), True, PZ);
    aCE.Draw(FPainter, 0);

    if sqrt(sqr(PX-Line0.C1.X)+sqr(PY-Line0.C1.Y)+sqr(PZ-Line0.C1.Z))<0.1 then begin
      aLine0:=nil;
      aC1:=Line0.C1;
      while aC1.Lines.Count>0 do begin
        aLine:=aC1.Lines.Item[0] as ILine;
        if aLine.C0=aC1 then
          aLine.C0:=aC
        else
          aLine.C1:=aC
      end;
      DeleteElement(
                    nil, nil, ltOneToMany, aC1 as IUnknown);
    end else
    if sqrt(sqr(PX-Line0.C0.X)+sqr(PY-Line0.C0.Y)+sqr(PZ-Line0.C0.Z))<0.1 then begin
      aLine0:=nil;
      aC1:=Line0.C0;
      while aC1.Lines.Count>0 do begin
        aLine:=aC1.Lines.Item[0] as ILine;
        if aLine.C0=aC1 then
          aLine.C0:=aC
        else
          aLine.C1:=aC
      end;
      DeleteElement(
                    nil, nil, ltOneToMany, aC1 as IUnknown);
    end else begin
      AddElement( (Line0 as IDMElement).Parent,
                           SpatialModel.Lines, '', ltOneToMany, LineU, True);
      aLine0E:=LineU as IDMElement;
      ChangeFieldValue( aLine0E, ord(linThickness), True, Line0.Thickness);
      ChangeFieldValue( aLine0E, ord(linStyle), True, Line0.Style);
      ChangeFieldValue( aLine0E, ord(linColor), True, (Line0 as ISpatialElement).Color);
      ChangeFieldValue( aLine0E, ord(linC0), True, aCE as IUnknown);
      ChangeFieldValue( aLine0E, ord(linC1), True, Line0.C1 as IUnknown);
      aLine0:=aLine0E as ILine;

      ChangeFieldValue( Line0 as IDMElement, ord(linC1), True, aCE as IUnknown);

    end;

    if sqrt(sqr(PX-Line1.C1.X)+sqr(PY-Line1.C1.Y)+sqr(PZ-Line1.C1.Z))<0.1 then begin
      aLine1:=nil;
      aC1:=Line1.C1;
      while aC1.Lines.Count>0 do begin
        aLine:=aC1.Lines.Item[0] as ILine;
        if aLine.C0=aC1 then
          aLine.C0:=aC
        else
          aLine.C1:=aC
      end;
      DeleteElement(
                    nil, nil, ltOneToMany, aC1 as IUnknown);
    end else
    if sqrt(sqr(PX-Line1.C0.X)+sqr(PY-Line1.C0.Y)+sqr(PZ-Line1.C0.Z))<0.1 then begin
      aLine1:=nil;
      aC1:=Line1.C0;
      while aC1.Lines.Count>0 do begin
        aLine:=aC1.Lines.Item[0] as ILine;
        if aLine.C0=aC1 then
          aLine.C0:=aC
        else
          aLine.C1:=aC
      end;
      DeleteElement(
                    nil, nil, ltOneToMany, aC1 as IUnknown);
    end else begin
      AddElement( (Line1 as IDMElement).Parent,
                         SpatialModel.Lines, '', ltOneToMany, LineU, True);
      aLine1E:=LineU as IDMElement;
      ChangeFieldValue( aLine1E, ord(linThickness), True, Line1.Thickness);
      ChangeFieldValue( aLine1E, ord(linStyle), True, Line1.Style);
      ChangeFieldValue( aLine1E, ord(linColor), True, (Line1 as ISpatialElement).Color);
      ChangeFieldValue( aLine1E, ord(linC0), True, aCE as IUnknown);
      ChangeFieldValue( aLine1E, ord(linC1), True, Line1.C1 as IUnknown);
      aLine1:=aLine1E as ILine;

      ChangeFieldValue( Line1 as IDMElement, ord(linC1), True, aCE as IUnknown);

    end;

    UpdateAreas(aCE);

    if aLine0<>nil then begin
      for j:=0 to Line0E.Parents.Count-1 do begin
        aParent:=Line0E.Parents.Item[j];
        aLine0E.AddParent(aParent);
        if AreaList.IndexOf(pointer(aParent))=-1 then
          AreaList.Add(pointer(aParent));
      end;
    end;

    if aLine1<>nil then begin
      for j:=0 to Line1E.Parents.Count-1 do begin
        aParent:=Line1E.Parents.Item[j];
        aLine1E.AddParent(aParent);
        if AreaList.IndexOf(pointer(aParent))=-1 then
        AreaList.Add(pointer(aParent));
      end;
    end;

  end;


var
  Line, Line0, Line1, aLine0, aLine1:ILine;
  Line0E, aAreaE:IDMElement;
  PX, PY, PZ:double;
  P0X, P0Y, P0Z, P1X, P1Y, P1Z,
  P2X, P2Y, P2Z, P3X, P3Y, P3Z:double;
  j, j1, m:integer;
  VArea, aArea:IArea;
  Volume0, Volume1:IVolume;
begin
  SpatialModel:=Get_DataModel as ISpatialModel;
  LineList:=TList.Create;
  AreaList:=TList.Create;

  for j:=0 to Collection.Count-1 do begin
    if Collection.Item[j].QueryInterface(ILine, Line)=0 then begin
      LineList.Add(pointer(Line));
      m:=0;
      while m<LineList.Count do begin
        Line0:=ILine(LineList[m]);
        Line0E:=Line0 as IDMElement;
        for j1:=j+1 to Collection.Count-1 do
          if Collection.Item[j1].QueryInterface(ILine, Line1)=0 then begin
            if Line0.C0=Line1.C0 then Continue;
            if Line0.C0=Line1.C1 then Continue;
            if Line0.C1=Line1.C0 then Continue;
            if Line0.C1=Line1.C1 then Continue;
            P0X:=Line0.C0.X;
            P0Y:=Line0.C0.Y;
            P0Z:=Line0.C0.Z;
            P1X:=Line0.C1.X;
            P1Y:=Line0.C1.Y;
            P1Z:=Line0.C1.Z;
            P2X:=Line1.C0.X;
            P2Y:=Line1.C0.Y;
            P2Z:=Line1.C0.Z;
            P3X:=Line1.C1.X;
            P3Y:=Line1.C1.Y;
            P3Z:=Line1.C1.Z;
            if LineCanIntersectLine(P0X, P0Y, P0Z,
                                    P1X, P1Y, P1Z,
                                    P2X, P2Y, P2Z,
                                    P3X, P3Y, P3Z,
                                    PX,  PY,  PZ) and
               ((P0X-PX)*(P1X-PX)+
                (P0Y-PY)*(P1Y-PY)+
                (P0Z-PZ)*(P1Z-PZ)<-1.e-6) and
               ((P2X-PX)*(P3X-PX)+
                (P2Y-PY)*(P3Y-PY)+
                (P2Z-PZ)*(P3Z-PZ)<-1.e-6) then begin
              DoIntersect(Line0, Line1, PX, PY, PZ, aLine0, aLine1);
              if aLine0<>nil then
                LineList.Add(pointer(aLine0));
              if aLine1<>nil then
                LineList.Add(pointer(aLine1));
            end;
          end;

        for j1:=1 to LineList.Count-1 do begin
          Line1:=ILine(LineList[j1]);
          if Line0.C0=Line1.C0 then Continue;
          if Line0.C0=Line1.C1 then Continue;
          if Line0.C1=Line1.C0 then Continue;
          if Line0.C1=Line1.C1 then Continue;
          P0X:=Line0.C0.X;
          P0Y:=Line0.C0.Y;
          P0Z:=Line0.C0.Z;
          P1X:=Line0.C1.X;
          P1Y:=Line0.C1.Y;
          P1Z:=Line0.C1.Z;
          P2X:=Line1.C0.X;
          P2Y:=Line1.C0.Y;
          P2Z:=Line1.C0.Z;
          P3X:=Line1.C1.X;
          P3Y:=Line1.C1.Y;
          P3Z:=Line1.C1.Z;
          if LineCanIntersectLine(P0X, P0Y, P0Z,
                                  P1X, P1Y, P1Z,
                                  P2X, P2Y, P2Z,
                                  P3X, P3Y, P3Z,
                                  PX,  PY,  PZ) and
             ((P0X-PX)*(P1X-PX)+
              (P0Y-PY)*(P1Y-PY)+
              (P0Z-PZ)*(P1Z-PZ)<-1.e-6) and
             ((P2X-PX)*(P3X-PX)+
              (P2Y-PY)*(P3Y-PY)+
              (P2Z-PZ)*(P3Z-PZ)<-1.e-6) then begin
            DoIntersect(Line0, Line1, PX, PY, PZ, aLine0, aLine1);
            if aLine0<>nil then
              LineList.Add(pointer(aLine0));
            if aLine1<>nil then
              LineList.Add(pointer(aLine1));
          end;
        end;
        Line0E.Draw(FPainter, 0);
        inc(m);
      end;
    end;
  end;
  for j:=0 to Collection.Count-1 do begin
    Line0E:=Collection.Item[j];
    Line0E.Selected:=False;
  end;

  for j:=0 to AreaList.Count-1 do begin
    aAreaE:=IDMElement(AreaList[j]);
    UpdateElement( aAreaE);
    UpdateCoords( aAreaE);
  end;

  try
  for j:=0 to LineList.Count-1 do begin
    Line0:=ILine(LineList[j]) as ILine;
    Line0E:=Line0 as IDMElement;
    LineUpdateAreas(Line0);
    VArea:=Line0.GetVerticalArea(bdUp);
    if VArea<>nil then begin
      Volume0:=VArea.Volume0;
      Volume1:=VArea.Volume1;
      for m:=0 to Line0E.Parents.Count-1 do begin
        aAreaE:=Line0E.Parents.Item[m];
        aArea:=aAreaE as IArea;
        if not aArea.IsVertical then begin
          if (aArea.Volume0=Volume0) then begin
            if (Volume1<>nil) and
               AreaInVolume(aArea, Volume1) then begin
              aArea.Volume0IsOuter:=False;
              aArea.Volume0:=Volume1
            end;
          end else
          if (aArea.Volume0=Volume1) then begin
            if (Volume0<>nil) and
               AreaInVolume(aArea, Volume0) then begin
              aArea.Volume0IsOuter:=False;
              aArea.Volume0:=Volume0
            end;
          end;
        end;
      end;
    end;
  end;
  except
    raise
  end;  

  LineList.Free;
  AreaList.Free;
end;


function AreaInVolume(const aArea:IArea; const Volume:IVolume):boolean;
  var
    PX, PY, PZ:double;
    j:integer;
    Area:IArea;
  begin
    try
    Result:=False;
    aArea.GetCentralPoint(PX, PY, PZ);
    for j:=0 to Volume.TopAreas.Count-1 do begin
      Area:=Volume.TopAreas.Item[j] as IArea;
      if Area.ProjectionContainsPoint(PX, PY, 0) then begin
        Result:=True;
        Exit;
      end;
    end;
    except
      raise
    end;
  end;


function TCustomSMDocument.Get_GlueNodeMode: WordBool;
begin
  Result:=FGlueNodeMode
end;

procedure TCustomSMDocument.Set_GlueNodeMode(Value: WordBool);
begin
  FGlueNodeMode:=Value
end;


procedure TCustomSMDocument.SaveView(const aView: IView);
var
  OldState:integer;
begin
  OldState:=Get_State;
  Set_State(OldState or dmfCommiting);
  try
    FLastView.Duplicate(aView);
  finally
    Set_State(OldState);
  end;
end;

function TCustomSMDocument.DoBuildVolume(const BaseAreas:IDMCollection;
  var Height: double; const SpatialModel2: ISpatialModel2;
  const ParentVolume1:IVolume; AddView:WordBool; Direction:integer): IDMElement;
var
  j,i, m, k:integer;
  MinZ:double;
  Volume, ParentVolume:IVolume;
  VLine0, VLine1, VLine, HLine, BLine, BLine1, NewLine:ILine;
  VLine0E, VLine1E, VLineE, HLineE, BLineE, BLine1E, NewLineE,aLineE:IDMElement;
  VLine0S, VLine1S, VLineS, HLineS, BLineS, NewLineS:ISpatialElement;
  C, aC0, aC1, C0, C1:ICoordNode;
  BaseArea, TopArea, SideArea:IArea;
  BaseAreaP, aBaseAreaP, SideAreaP, TopAreaP:IPolyline;
  aBaseAreaE, BaseAreaE, TopAreaE, SideAreaE,
  theBaseAreaE, NodeE, AreaE, aParent:IDMElement;
  SpatialModel:ISpatialModel;
  AreaU:IUnknown;
  VolumeU:IUnknown;
  LineU:IUnknown;
  NodeU:IUnknown;
  Node,Node0:ICoordNode;
  aCount:integer;
  Collection:IDMCollection;
  aCollection2:IDMCollection2;
  aCollection:IDMCollection;
  bCollection2:IDMCollection2;
  bCollection:IDMCollection;
  newCollection2:IDMCollection2;
  newCollection:IDMCollection;
  BaseAreaLines, ParentVolumeOutline:IDMCollection;
  BaseAreaLines2:IDMCollection2;
  ParentVolumeIsOuter:boolean;
  DataModel:IDataModel;
  TopLines:IDMCollection;
  TopLines2:IDMCollection2;
  TopAreas:TList;

//!!!!
  TopOutline, InnerTopLines:TList;
  aTopLineE, aTopLine1E, aAreaE:IDMElement;
  aTopLine, aTopLine1:ILine;
  X, Y, X0, Y0, X1, Y1:double;
  TopC0, TopC1:ICoordNode;
  FirstTopAreaFlag, NoOldTopAreaFlag:boolean;
  ConnectingLineList:TList;
  aCurrentLines:IDMCollection;
  aCurrentLines2:IDMCollection2;
  CC0, CC1:ICoordNode;
  aArea, aNewArea:IArea;

  procedure LookTopAreas(const HLineE:IDMElement);
  var
    k, i, n:integer;
    TopAreaE:IDMElement;
    TopArea:IArea;
  begin
    for k:=0 to HLineE.Parents.Count-1 do begin
      TopAreaE:=HLineE.Parents.Item[k];
      if TopAreaE.QueryInterface(IArea, TopArea)=0 then begin
        if not TopArea.IsVertical then begin
          if FirstTopAreaFlag then
            TopAreas.Add(pointer(TopAreaE))
          else begin
            n:=TopAreas.IndexOf(pointer(TopAreaE));
            if n<>-1 then begin
              i:=0;
              while i<TopAreas.Count do begin
                if TopAreaE<>IDMElement(TopAreas[i]) then
                  TopAreas.Delete(i)
                else
                  inc(i)
              end;
            end;
          end;
        end;
      end; // if TopAreaE.QueryInterface(IArea, TopArea)=0
    end; //  k:=0 to HLineE.Parents.Count-1
  end;

  function GT(A, B:double; Direction:integer):boolean;
  begin
    if Direction=0 then begin
      Result:=(A>B)
    end else begin
      Result:=(A<B)
    end;
  end;

  function LT(A, B:double; Direction:integer):boolean;
  begin
    if Direction=0 then begin
      Result:=(A<B)
    end else begin
      Result:=(A>B)
    end;
  end;

//!!!

begin
  Result:=nil;
  if BaseAreas.Count=0 then Exit;

  DataModel:=Get_DataModel as IDataModel;
  ParentVolume:=ParentVolume1;
  if (ParentVolume<>nil) and
     ((ParentVolume as IDMElement).Id=-1) then
    ParentVolume:=nil;
  aCurrentLines:=DataModel.CreateCollection(-1, nil);
  aCurrentLines2:=aCurrentLines as IDMCollection2;

  SpatialModel:=SpatialModel2 as ISpatialModel;

  theBaseAreaE:=BaseAreas.Item[0];
  BaseAreaLines:=(theBaseAreaE as IPolyline).Lines;

  aParent:=theBaseAreaE.Parent;
  if aParent=nil then begin
    if BaseAreaLines.Count>0 then
      aParent:=BaseAreaLines.Item[0].Parent
    else
      aParent:=SpatialModel.CurrentLayer as IDMElement;
  end;

  AddElement(aParent, SpatialModel2.Volumes, '', ltOneToMany, VolumeU, True);
  Result:=VolumeU as IDMElement;
  Volume:=Result as IVolume;

  if BaseAreas.Count=1 then begin
    BaseArea:=theBaseAreaE as IArea;
    if (BaseArea.Volume0=nil) and
       (BaseArea.Volume1=nil) then begin
      AddElement( theBaseAreaE.Parent,
                         SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
      aBaseAreaE:=AreaU as IDMElement;
      aBaseAreaP:=aBaseAreaE as IPolyline;
      while BaseAreaLines.Count>0 do begin
        BLineE:=BaseAreaLines.Item[0];
        (BaseAreaLines as IDMCollection2).Delete(0);
        BLineE.AddParent(aBaseAreaE);
      end;
      BaseAreaE:=aBaseAreaE;
      BaseArea:=BaseAreaE as IArea ;
      BaseAreaLines:=aBaseAreaP.Lines;
    end else
      BaseAreaE:=theBaseAreaE;

    BaseArea.Vol0IsOuter[Direction]:=False;
    BaseArea.Vol0[Direction]:=Volume;
  end else begin
    BaseAreaLines:=DataModel.CreateCollection(-1, nil);
    BaseAreaLines2:=BaseAreaLines as IDMCollection2;
    BaseAreaE:=nil;
    for j:=0 to BaseAreas.Count-1 do begin
      BaseAreaE:=BaseAreas.Item[j];
      BaseArea:=BaseAreaE as IArea;
      BaseAreaP:=BaseArea as IPolyline;
      BaseArea.Vol0IsOuter[Direction]:=False;
      BaseArea.Vol0[Direction]:=Volume;
      for m:=0 to BaseAreaP.Lines.Count-1 do begin
        aLineE:=BaseAreaP.Lines.Item[m];
        i:=BaseAreaLines.IndexOf(aLineE);
        if i=-1 then
          BaseAreaLines2.Add(aLineE)
        else
          BaseAreaLines2.Delete(i)
      end;
    end;
  end;

  ParentVolumeIsOuter:=True;
  if ParentVolume<>nil then begin
    ParentVolumeOutline:=(SpatialModel2 as IDataModel).CreateCollection(-1, nil);
    SpatialModel2.MakeVolumeOutline(ParentVolume, ParentVolumeOutline);
    m:=0;
    while m<ParentVolumeOutline.Count do begin
      aLineE:=ParentVolumeOutline.Item[m];
      if BaseAreaLines.IndexOf(aLineE)<>-1 then
        Break
      else
        inc(m);
    end;
    if m<ParentVolumeOutline.Count then
      ParentVolumeIsOuter:=False;
  end;   // if ParentVolume<>nil

  TopLines:=(SpatialModel2 as IDataModel).CreateCollection(-1, nil);
  TopLines2:=TopLines as IDMCollection2;

  BaseArea.CalcMinMaxZ;
  if Direction=0 then
    MinZ:=BaseArea.MnZ[Direction]+Height
  else
    MinZ:=BaseArea.MnZ[Direction]-Height;

  if AddView then begin
    if Direction=0 then
      AddZView(BaseArea.MnZ[Direction], MinZ)
    else
      AddZView(MinZ, BaseArea.MnZ[Direction])
  end;

  aCount:=BaseAreaLines.Count;
  for j:=0 to aCount-1 do begin
    BLine:=BaseAreaLines.Item[j] as ILine;
    SideArea:=BLine.GetVerticalArea(Direction);
    if SideArea<>nil then begin
      if GT(MinZ, SideArea.MxZ[Direction], Direction) then
        MinZ:=SideArea.MxZ[Direction];
    end;
    C0:=BLine.C0;
    VLine0:=C0.GetVerticalLine(Direction);
    if VLine0<>nil then begin
      aC0:=VLine0.CC1[Direction];
      if GT(MinZ, aC0.Z, Direction) then
        MinZ:=aC0.Z;
    end;
    C1:=BLine.C1;
    VLine1:=C1.GetVerticalLine(Direction);
    if VLine1<>nil then begin
      aC1:=VLine1.CC1[Direction];
      if GT(MinZ, aC1.Z, Direction) then
        MinZ:=aC1.Z;
    end;
  end;    //for J
  Height:=Height-abs(MinZ-BaseArea.MnZ[Direction]);

//!!!!!!
  ConnectingLineList:=TList.Create;
  InnerTopLines:=TList.Create;
  if (Height=0) and
     (ParentVolume<>nil) then begin
    if ParentVolume.TAreas[Direction].Count>1 then begin
      TopOutline:=TList.Create;
      for j:=0 to ParentVolume.TAreas[Direction].Count-1 do begin
        TopAreaP:=ParentVolume.TAreas[Direction].Item[j] as IPolyline;
        for m:=0 to TopAreaP.Lines.Count-1 do begin
          aLineE:=TopAreaP.Lines.Item[m];
          i:=TopOutline.IndexOf(pointer(aLineE));
          if i=-1 then                              // внешний контур верхних границ
            TopOutline.Add(pointer(aLineE))
          else
            TopOutline.Delete(i);

          i:=InnerTopLines.IndexOf(pointer(aLineE));   //все линии верхних границ
          if i=-1 then
            InnerTopLines.Add(pointer(aLineE))
        end;
      end; // for j:=0 to ParentVolume.TopAreas.Count-1

      for j:=0 to TopOutline.Count-1 do begin
        aLineE:=IDMElement(TopOutline[j]);
        i:=InnerTopLines.IndexOf(pointer(aLineE));
        if i<>-1 then                //останутся только внутренние линии верхних границ
          InnerTopLines.Delete(i);
      end;
      TopOutline.Free;
    end; // if ParentVolume.TopAreas.Count>1
  end;

  NoOldTopAreaFlag:=False;
//!!!!!!

  for j:=0 to BaseAreaLines.Count-1 do begin
    try
    BLineE:=BaseAreaLines.Item[j];
    BLine:=BLineE as ILine;
    BLineS:=BLineE as ISpatialElement;
    SideArea:=BLine.GetVerticalArea(Direction);
    SideAreaE:=SideArea as IDMElement;
    aC0:=nil;
    aC1:=nil;
    if SideArea=nil then begin
      VLine0:=BLine.C0.GetVerticalLine(Direction);
      VLine0E:=VLine0 as IDMElement;
      VLine1:=BLine.C1.GetVerticalLine(Direction);
      VLine1E:=VLine1 as IDMElement;
      if VLine0=nil then begin
        DivideVerticalArea(BLine.C0, Direction, VLine0);
        if VLine0<>nil then
          VLine0E:=VLine0 as IDMElement
        else begin
          AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
          VLine0E:=LineU as IDMElement;
          VLine0:=VLine0E as ILine;
          VLine0S:=VLine0E as ISpatialElement;

          VLine0.Thickness:=0;
          if BLineS.Layer.Expand then begin
            VLine0.Style:=BLine.Style;
            VLine0S.Color:=BLineS.Color;
            VLine0S.Layer:=BLineS.Layer;
          end;

          VLine0.CC0[Direction]:=BLine.C0;

//!!!!
          AddElement(BLineE.Parent,
                     SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
          NodeE:=NodeU as IDMElement;
          Node:=NodeE as ICoordNode;
          X:=BLine.C0.X;
          Y:=BLine.C0.Y;
          Node.X:=X;
          Node.Y:=Y;
          Node.Z:=MinZ;

          aTopLineE:=nil;
          aTopLine:=nil;
          m:=0;
          while m<InnerTopLines.Count do begin
            aTopLineE:=IDMElement(InnerTopLines[m]);
            aTopLine:=aTopLineE as ILine;
            TopC0:=aTopLine.C0;
            TopC1:=aTopLine.C1;
            X0:=TopC0.X;
            Y0:=TopC0.Y;
            X1:=TopC1.X;
            Y1:=TopC1.Y;
            if abs(((X-X0)*(X-X1)+(Y-Y0)*(Y-Y1))/
                       sqrt(sqr(X-X0)+sqr(Y-Y0))/
                       sqrt(sqr(X-X1)+sqr(Y-Y1))+1)<0.01 then
              break
            else
              inc(m)
          end;

          if m<InnerTopLines.Count then begin
            AddElement(aTopLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
            aTopLine1E:=LineU as IDMElement;
            aTopLine1:=aTopLine1E as ILine;

            aTopLine1.Thickness:=aTopLine.Thickness;
            aTopLine1.Style:=aTopLine.Style;
            (aTopLine1 as ISpatialElement).Color:=(aTopLine as ISpatialElement).Color;
            aTopLine1.C1:=aTopLine.C1;
            aTopLine1.C0:=Node;
            aTopLine.C1:=Node;
            NodeUpdateAreas(Node);
          end else
            NoOldTopAreaFlag:=True;

          VLine0.CC1[Direction]:=Node;
//!!!!
        end;
      end;

      if VLine0E.Ref<>nil then begin
      end else
      if GT(VLine0.CC1[Direction].Z, MinZ, Direction) then begin
        AddElement( BLineE.Parent,
                              SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
        NodeE:=NodeU as IDMElement;
        aC0:=NodeE as ICoordNode;
        aC0.Z:=MinZ;
        aC0.X:=VLine0.CC0[Direction].X+(VLine0.CC1[Direction].X-VLine0.CC0[Direction].X)*(MinZ-VLine0.CC0[Direction].Z)/
                                              (VLine0.CC1[Direction].Z-VLine0.CC0[Direction].Z);
        aC0.Y:=VLine0.CC0[Direction].Y+(VLine0.CC1[Direction].Y-VLine0.CC0[Direction].Y)*(MinZ-VLine0.CC0[Direction].Z)/
                                              (VLine0.CC1[Direction].Z-VLine0.CC0[Direction].Z);

        AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
        VLineE:=LineU as IDMElement;
        VLine:=VLineE as ILine;
        VLine.CC0[Direction]:=aC0;
        VLine.CC1[Direction]:=VLine0.CC1[Direction];
        VLine0.CC1[Direction]:=aC0;
        UpdateAreas(NodeE);
      end;

      if VLine1=nil then begin
        DivideVerticalArea(BLine.C1, Direction, VLine1);
        if VLine1<>nil then
          VLine1E:=VLine1 as IDMElement
        else begin
          AddElement( BLineE.Parent,
                                SpatialModel.Lines, '', ltOneToMany, LineU, True);
          VLine1E:=LineU as IDMElement;
          VLine1:=VLine1E as ILine;
          VLine1S:=VLine1E as ISpatialElement;

          VLine1.Thickness:=0;
          if BLineS.Layer.Expand then begin
            VLine1.Style:=BLine.Style;
            VLine1S.Color:=BLineS.Color;
            VLine1S.Layer:=BLineS.Layer;
          end;

          VLine1.CC0[Direction]:=BLine.C1;

          AddElement( BLineE.Parent,
                                 SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);

//!!!!
          NodeE:=NodeU as IDMElement;
          Node:=NodeE as ICoordNode;
          X:=BLine.C1.X;
          Y:=BLine.C1.Y;
          Node.X:=X;
          Node.Y:=Y;
          Node.Z:=MinZ;

          aTopLineE:=nil;
          aTopLine:=nil;
          m:=0;
          while m<InnerTopLines.Count do begin
            aTopLineE:=IDMElement(InnerTopLines[m]);
            aTopLine:=aTopLineE as ILine;
            TopC0:=aTopLine.C0;
            TopC1:=aTopLine.C1;
            X0:=TopC0.X;
            Y0:=TopC0.Y;
            X1:=TopC1.X;
            Y1:=TopC1.Y;
            if abs(((X-X0)*(X-X1)+(Y-Y0)*(Y-Y1))/
                       sqrt(sqr(X-X0)+sqr(Y-Y0))/
                       sqrt(sqr(X-X1)+sqr(Y-Y1))+1)<0.01 then
              break
            else
              inc(m)
          end;

          if m<InnerTopLines.Count then begin
            AddElement(aTopLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
            aTopLine1E:=LineU as IDMElement;
            aTopLine1:=aTopLine1E as ILine;

            aTopLine1.Thickness:=aTopLine.Thickness;
            aTopLine1.Style:=aTopLine.Style;
            (aTopLine1 as ISpatialElement).Color:=(aTopLine as ISpatialElement).Color;
            aTopLine1.C1:=aTopLine.C1;
            aTopLine1.C0:=Node;
            aTopLine.C1:=Node;
            NodeUpdateAreas(Node);
          end else
            NoOldTopAreaFlag:=True;

          VLine1.CC1[Direction]:=Node;
//!!!!
        end;
      end;

      if VLine1E.Ref<>nil then begin
      end else
      if GT(VLine1.CC1[Direction].Z, MinZ, Direction) then begin
        AddElement( BLineE.Parent,
                              SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
        NodeE:=NodeU as IDMElement;
        aC1:=NodeE as ICoordNode;
        aC1.Z:=MinZ;
        aC1.X:=VLine1.CC0[Direction].X+(VLine1.CC1[Direction].X-VLine1.CC0[Direction].X)*(MinZ-VLine1.CC0[Direction].Z)/
                                              (VLine1.CC1[Direction].Z-VLine1.CC0[Direction].Z);
        aC1.Y:=VLine1.CC0[Direction].Y+(VLine1.CC1[Direction].Y-VLine1.CC0[Direction].Y)*(MinZ-VLine1.CC0[Direction].Z)/
                                              (VLine1.CC1[Direction].Z-VLine1.CC0[Direction].Z);

        AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
        VLineE:=LineU as IDMElement;
        VLine:=VLineE as ILine;
        VLine.CC0[Direction]:=aC1;
        VLine.CC1[Direction]:=VLine1.CC1[Direction];
        VLine1.CC1[Direction]:=aC1;
        UpdateAreas(NodeE);
      end;

      if (VLine0E.Parents.Count<>0) and
         (VLine1E.Parents.Count<>0) then
        for m:=0 to VLine0E.Parents.Count-1 do
          if VLine1E.Parents.IndexOf(VLine0E.Parents.Item[m])<>-1 then begin
            SideArea:=VLine0E.Parents.Item[m] as IArea;
            SideAreaE:=SideArea as IDMElement;
            Break;
          end;
    end else begin  //if SideArea<>nil
      SideAreaP:=SideArea as IPolyline;
      VLine0:=BLine.C0.GetVerticalLine(Direction);
      VLine0E:=VLine0 as IDMElement;
      VLine1:=BLine.C1.GetVerticalLine(Direction);
      VLine1E:=VLine1 as IDMElement;

      if VLine0=nil then begin
        DivideVerticalArea(BLine.C0, Direction, VLine0);
        if VLine0=nil then Exit;
        VLine0E:=VLine0 as IDMElement;
        SideArea:=BLine.GetVerticalArea(Direction);
        SideAreaE:=SideArea as IDMElement;
      end;

      if VLine0E.Ref<>nil then begin
      end else
      if GT(VLine0.CC1[Direction].Z, MinZ, Direction) then begin
        AddElement( BLineE.Parent,
                              SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
        NodeE:=NodeU as IDMElement;
        aC0:=NodeE as ICoordNode;
        aC0.Z:=MinZ;
        aC0.X:=VLine0.CC0[Direction].X+(VLine0.CC1[Direction].X-VLine0.CC0[Direction].X)*(MinZ-VLine0.CC0[Direction].Z)/
                                              (VLine0.CC1[Direction].Z-VLine0.CC0[Direction].Z);
        aC0.Y:=VLine0.CC0[Direction].Y+(VLine0.CC1[Direction].Y-VLine0.CC0[Direction].Y)*(MinZ-VLine0.CC0[Direction].Z)/
                                              (VLine0.CC1[Direction].Z-VLine0.CC0[Direction].Z);

        AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
        VLineE:=LineU as IDMElement;
        VLine:=VLineE as ILine;
        VLine.CC0[Direction]:=aC0;
        VLine.CC1[Direction]:=VLine0.CC1[Direction];
        VLine0.CC1[Direction]:=aC0;
        UpdateAreas(NodeE);
      end;

      if VLine1=nil then begin
        DivideVerticalArea(BLine.C1, Direction, VLine1);
        if VLine1=nil then Exit;
        VLine1E:=VLine1 as IDMElement;
        SideArea:=BLine.GetVerticalArea(Direction);
        SideAreaE:=SideArea as IDMElement;
      end;

      if VLine1E.Ref<>nil then begin
      end else
      if GT(VLine1.CC1[Direction].Z, MinZ, Direction) then begin
        AddElement( BLineE.Parent,
                              SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
        NodeE:=NodeU as IDMElement;
        aC1:=NodeE as ICoordNode;
        aC1.Z:=MinZ;
        aC1.X:=VLine1.CC0[Direction].X+(VLine1.CC1[Direction].X-VLine1.CC0[Direction].X)*(MinZ-VLine1.CC0[Direction].Z)/
                                              (VLine1.CC1[Direction].Z-VLine1.CC0[Direction].Z);
        aC1.Y:=VLine1.CC0[Direction].Y+(VLine1.CC1[Direction].Y-VLine1.CC0[Direction].Y)*(MinZ-VLine1.CC0[Direction].Z)/
                                              (VLine1.CC1[Direction].Z-VLine1.CC0[Direction].Z);

        AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
        VLineE:=LineU as IDMElement;
        VLine:=VLineE as ILine;
        VLine.CC0[Direction]:=aC1;
        VLine.CC1[Direction]:=VLine1.CC1[Direction];
        VLine1.CC1[Direction]:=aC1;
        UpdateAreas(NodeE);
      end;
    end;       //if SideArea<>nil

    if SideArea=nil then begin
      CC0:=VLine0.CC1[Direction];
      CC1:=VLine1.CC1[Direction];
      BuildConnectingLineList(CC0, CC1, BLineE.Parent, ConnectingLineList, False);

      AddElement( BLineE.Parent,
                              SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
      SideAreaE:=AreaU as IDMElement;
      SideArea:=SideAreaE as IArea;
      SideAreaP:=SideAreaE as IPolyline;
      SideArea.IsVertical:=True;
      SideArea.Volume0IsOuter:=False;
      SideArea.Volume0:=Volume;
      SideArea.Volume1IsOuter:=ParentVolumeIsOuter;
      SideArea.Volume1:=ParentVolume;

      BLineE.AddParent(SideAreaE);
      VLine0E.AddParent(SideAreaE);

      aCurrentLines2.Clear;
      for k:=0 to ConnectingLineList.Count-1 do begin
        HLineE:=IDMElement(ConnectingLineList[k]);
        TopLines2.Add(HLineE);
        HLineE.AddParent(SideAreaE);
        aCurrentLines2.Add(HLineE);
      end;

      VLine1E.AddParent(SideAreaE);
      UpdateElement( SideAreaE);
      UpdateCoords( SideAreaE);

//      LineDivideArea1(CC0, CC1, aCurrentLines, aArea, aNewArea);
    end else // if SideArea<>nil
    if GT(SideArea.MaxZ, VLine0.CC1[Direction].Z, Direction) or
       GT(SideArea.MaxZ, VLine1.CC1[Direction].Z, Direction) then begin

      AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
      HLineE:=LineU as IDMElement;
      HLine:=HLineE as ILine;
      HLineS:=HLineE as ISpatialElement;

      HLine.Thickness:=0;
      if BLineS.Layer.Expand then begin
        HLine.Style:=BLine.Style;
        HLineS.Color:=BLineS.Color;
        HLineS.Layer:=BLineS.Layer;
      end;

      HLine.C0:=VLine0.CC1[Direction];
      HLine.C1:=VLine1.CC1[Direction];

      TopLines2.Add(HLineE);
      UpdateAreas(HLineE);

      SideArea:=BLine.GetVerticalArea(Direction);

      if SideArea<>nil then begin
        SideAreaE:=SideArea as IDMElement;
        if SideArea.Volume0=nil then begin
          SideArea.Volume0IsOuter:=False;
          SideArea.Volume0:=Volume
        end else begin
          if SideArea.Volume0=ParentVolume then begin
            SideArea.Volume0IsOuter:=False;
            SideArea.Volume0:=Volume
          end else begin
            SideArea.Volume1IsOuter:=False;
            SideArea.Volume1:=Volume;
          end;
        end;
      end;

    end else begin  //(if SideArea<>nil) and (SideArea.MaxZ=VLine0.CC1[Direction].Z=VLine1.CC1[Direction].Z)

      if SideArea.Volume0=nil then begin
        SideArea.Volume0IsOuter:=False;
        SideArea.Volume0:=Volume
      end else begin
        if SideArea.Volume0=ParentVolume then begin
          SideArea.Volume0IsOuter:=False;
          SideArea.Volume0:=Volume
        end else begin
          SideArea.Volume1IsOuter:=False;
          SideArea.Volume1:=Volume;
        end;
      end;

      if SideArea.TLines[Direction].Count>0 then begin
        for m:=0 to SideArea.TLines[Direction].Count-1 do begin
          HLineE:=SideArea.TLines[Direction].Item[m];
          TopLines2.Add(HLineE);

//!!!!
        end; // for m:=0 to SideArea.TLines[Direction].Count-1
      end;
  end;
  except
    raise
  end; //try
  end; //for J

  FirstTopAreaFlag:=True;
  TopAreas:=TList.Create;
  for j:=0 to TopLines.Count-1 do begin
    HLineE:=TopLines.Item[j];
    LookTopAreas(HLineE);
    if TopAreas.Count>0 then
      FirstTopAreaFlag:=False
  end;

  if (Height=0) and
     (TopAreas.Count=1) and
     (not NoOldTopAreaFlag) then
    TopAreaE:=IDMElement(TopAreas[0])
  else
    TopAreaE:=nil;
//!!!!

  TopAreas.Free;

  if TopAreaE<>nil then begin
    TopAreaP:=TopAreaE as IPolyline;
    if not (TopAreaP.Lines as IDMCollection2).IsEqualTo(TopLines) then
      TopAreaE:=nil;
  end;

  if TopAreaE=nil then begin
    AddElement( BaseAreaE.Parent,
                      SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
    TopAreaE:=AreaU as IDMElement;

    for j:=0 to TopLines.Count-1 do begin
      HLineE:=TopLines.Item[j];
      HLineE.AddParent(TopAreaE);
    end;
  end;

  TopArea:=TopAreaE as IArea;
  TopArea.IsVertical:=False;
  TopArea.Vol1IsOuter[Direction]:=False;
  TopArea.Vol1[Direction]:=Volume;

  InnerTopLines.Free;
  ConnectingLineList.Free;

  try
  for j:=0 to Volume.Areas.Count-1 do begin
    AreaE:=Volume.Areas.Item[j];
    UpdateElement(AreaE);
    UpdateCoords(AreaE);
  end;
  except
    raise
  end;
  UpdateElement(Result);

end;

(*
function TCustomSMDocument.DoBuildVolumeDown(const BaseAreas:IDMCollection;
  var Height: double; const SpatialModel2: ISpatialModel2;
  const ParentVolume1:IVolume; AddView:WordBool): IDMElement;
var
  j, m, k:integer;
  MaxZ:double;
  Volume, ParentVolume:IVolume;
  VLine0, VLine1, VLine, HLine, BLine:ILine;
  theBaseAreaE, VLine0E, VLine1E, VLineE, HLineE, BLineE:IDMElement;
  VLine0S, VLine1S, HLineS, BLineS:ISpatialElement;
  C, aC0, aC1, C0, C1:ICoordNode;
  BaseArea, BottomArea, SideArea:IArea;
  aBaseAreaP, BottomAreaP, SideAreaP:IPolyline;
  aBaseAreaE,  BaseAreaE, BottomAreaE, SideAreaE, NodeE, AreaE:IDMElement;
  SpatialModel:ISpatialModel;
  AreaU:IUnknown;
  VolumeU:IUnknown;
  LineU:IUnknown;
  NodeU:IUnknown;

  Node:ICoordNode;
  BLine1E, NewLineE, aParent:IDMElement;
  BLine1, NewLine:ILine;
  VLineS, NewLineS:ISpatialElement;
  i:integer;
  aCollection2:IDMCollection2;
  aCollection:IDMCollection;
  bCollection2:IDMCollection2;
  bCollection:IDMCollection;
  newCollection2:IDMCollection2;
  newCollection:IDMCollection;
  BaseAreaLines, ParentVolumeOutline:IDMCollection;
  ParentVolumeIsOuter:boolean;
  aLineE:IDMElement;
  DataModel:IDataModel;
  BaseAreaLines2:IDMCollection2;
  BaseAreaP:IPolyline;
  aCount:integer;
  Node0:ICoordNode;
  Collection:IDMCollection;
  BottomLines:IDMCollection;
  BottomLines2:IDMCollection2;
  BottomAreas:TList;

  function BaseAreaNodeProjectsOnLine(const LineE:IDMElement):boolean;
  var
    aLineE:IDMElement;
    Line, aLine:ILine;
    C0, C1:ICoordNode;
    X0, Y0, X1, Y1, aX0, aY0, aX1, aY1:double;
    j:integer;
  begin
    Result:=False;
    Line:=LineE as ILine;
    C0:=Line.C0;
    C1:=Line.C1;
    X0:=C0.X;
    Y0:=C0.Y;
    X1:=C1.X;
    Y1:=C1.Y;
    j:=0;
    while j<BaseAreaLines.Count do begin
      aLineE:=BaseAreaLines.Item[j];
      aLine:=aLineE as ILine;
      C0:=Line.C0;
      C1:=Line.C1;
      aX0:=C0.X;
      aY0:=C0.Y;
      aX1:=C1.X;
      aY1:=C1.Y;
      if abs((aY0-Y0)*(X1-X0)-(aX0-X0)*(Y1-Y0))<0.001 then
        Break
      else
      if abs((aY1-Y0)*(X1-X0)-(aX1-X0)*(Y1-Y0))<0.001 then
        Break
      else
        inc(j);
    end;
    if j<BaseAreaLines.Count then
      Result:=True;
  end;

begin
  Result:=nil;
  if BaseAreas.Count=0 then Exit;

  DataModel:=Get_DataModel as IDataModel;
  ParentVolume:=ParentVolume1;
  if (ParentVolume<>nil) and
     ((ParentVolume as IDMElement).Id=-1) then
    ParentVolume:=nil;

  SpatialModel:=SpatialModel2 as ISpatialModel;

  theBaseAreaE:=BaseAreas.Item[0];
  BaseAreaLines:=(theBaseAreaE as IPolyline).Lines;

  aParent:=theBaseAreaE.Parent;
  if aParent=nil then begin
    if BaseAreaLines.Count>0 then
      aParent:=BaseAreaLines.Item[0].Parent
    else
      aParent:=SpatialModel.CurrentLayer as IDMElement;
  end;

  AddElement(aParent, SpatialModel2.Volumes, '', ltOneToMany, VolumeU, True);
  Result:=VolumeU as IDMElement;
  Volume:=Result as IVolume;

  if BaseAreas.Count=1 then begin
    BaseArea:=theBaseAreaE as IArea;
    if (BaseArea.Volume0=nil) and
       (BaseArea.Volume1=nil) then begin
      AddElement( theBaseAreaE.Parent,
                         SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
      aBaseAreaE:=AreaU as IDMElement;
      aBaseAreaP:=aBaseAreaE as IPolyline;
      while BaseAreaLines.Count>0 do begin
        BLineE:=BaseAreaLines.Item[0];
        (BaseAreaLines as IDMCollection2).Delete(0);
        BLineE.AddParent(aBaseAreaE);
      end;
      BaseAreaE:=aBaseAreaE;
      BaseArea:=BaseAreaE as IArea ;
      BaseAreaLines:=aBaseAreaP.Lines;
    end else
      BaseAreaE:=theBaseAreaE;

    BaseArea.Volume1IsOuter:=False;
    BaseArea.Volume1:=Volume;
  end else begin
    BaseAreaLines:=DataModel.CreateCollection(-1, nil);
    BaseAreaLines2:=BaseAreaLines as IDMCollection2;
    BaseAreaE:=nil;
    for j:=0 to BaseAreas.Count-1 do begin
      BaseAreaE:=BaseAreas.Item[j];
      BaseArea:=BaseAreaE as IArea;
      BaseAreaP:=BaseArea as IPolyline;
      BaseArea.Volume1IsOuter:=False;  
      BaseArea.Volume1:=Volume;
      for m:=0 to BaseAreaP.Lines.Count-1 do begin
        aLineE:=BaseAreaP.Lines.Item[m];
        i:=BaseAreaLines.IndexOf(aLineE);
        if i=-1 then
          BaseAreaLines2.Add(aLineE)
        else
          BaseAreaLines2.Delete(i)
      end;
    end;
  end;

  ParentVolumeIsOuter:=True;
  if ParentVolume<>nil then begin
    ParentVolumeOutline:=(SpatialModel2 as IDataModel).CreateCollection(-1, nil);
    SpatialModel2.MakeVolumeOutline(ParentVolume, ParentVolumeOutline);
    m:=0;
    while m<ParentVolumeOutline.Count do begin
      aLineE:=ParentVolumeOutline.Item[m];
      if BaseAreaLines.IndexOf(aLineE)<>-1 then
        Break
      else
        inc(m);
    end;
    if m<ParentVolumeOutline.Count then
      ParentVolumeIsOuter:=False
    else begin  // Внимание !!! Только при построении вниз!
      m:=0;
      while m<ParentVolumeOutline.Count do begin
        aLineE:=ParentVolumeOutline.Item[m];
        if BaseAreaNodeProjectsOnLine(aLineE) then
          Break
        else
          inc(m);
      end;
      if m<ParentVolumeOutline.Count then
        ParentVolumeIsOuter:=False
    end;
  end;

  BottomLines:=(SpatialModel2 as IDataModel).CreateCollection(-1, nil);
  BottomLines2:=BottomLines as IDMCollection2;
  BottomAreas:=TList.Create;

  BaseArea.CalcMinMaxZ;
  MaxZ:=BaseArea.MaxZ-Height;

  if AddView then
    AddZView(MaxZ, BaseArea.MaxZ);

  aCount:=BaseAreaLines.Count;
  for j:=0 to aCount-1 do begin
    BLine:=BaseAreaLines.Item[j] as ILine;
    SideArea:=BLine.GetVerticalArea(bdDown);
    if SideArea<>nil then begin
      if MaxZ<SideArea.MinZ then
        MaxZ:=SideArea.MinZ;
    end;
    C0:=BLine.C0;
    VLine0:=C0.GetVerticalLine(bdDown);
    if VLine0<>nil then begin
      aC0:=VLine0.C0;
      if MaxZ<aC0.Z then
        MaxZ:=aC0.Z;
    end;
    C1:=BLine.C1;
    VLine1:=C1.GetVerticalLine(bdDown);
    if VLine1<>nil then begin
      aC1:=VLine1.C0;
      if MaxZ<aC1.Z then
        MaxZ:=aC1.Z;
    end;
  end;
  Height:=Height-(BaseArea.MaxZ-MaxZ);

  if SpatialModel2.BuildVerticalLine then begin
   for j:=0 to BaseAreaLines.Count-1 do begin
   try
    BLineE:=BaseAreaLines.Item[j];
    BLine:=BLineE as ILine;
    BLineS:=BLineE as ISpatialElement;
    SideArea:=BLine.GetVerticalArea(bdDown);
    SideAreaE:=SideArea as IDMElement;
    aC0:=nil;
    aC1:=nil;
    if SideArea=nil then begin
      VLine0:=BLine.C0.GetVerticalLine(bdDown);
      VLine0E:=VLine0 as IDMElement;
      VLine1:=BLine.C1.GetVerticalLine(bdDown);
      VLine1E:=VLine1 as IDMElement;
      if VLine0=nil then begin
        DivideVerticalArea(BLine.C0, bdDown, VLine0);
        if VLine0<>nil then
          VLine0E:=VLine0 as IDMElement
        else begin
          AddElement( BLineE.Parent,
                                SpatialModel.Lines, '', ltOneToMany, LineU, True);
          VLine0E:=LineU as IDMElement;
          VLine0:=VLine0E as ILine;
          VLine0S:=VLine0E as ISpatialElement;

          VLine0.Thickness:=0;
          if BLineS.Layer.Expand then begin
            VLine0.Style:=BLine.Style;
            VLine0S.Color:=BLineS.Color;
            VLine0S.Layer:=BLineS.Layer;
          end;

          VLine0.C1:=BLine.C0;

          AddElement( BLineE.Parent,
                                SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
          NodeE:=NodeU as IDMElement;
          VLine0.C0:=NodeE as ICoordNode;
          VLine0.C0.X:=VLine0.C1.X;
          VLine0.C0.Y:=VLine0.C1.Y;
          VLine0.C0.Z:=MaxZ;
        end;
      end;

      if VLine0E.Ref<>nil then begin
      end else
      if VLine0.C0.Z<MaxZ then begin
        AddElement( BLineE.Parent,
                              SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
        NodeE:=NodeU as IDMElement;
        aC0:=NodeE as ICoordNode;
        aC0.Z:=MaxZ;
        aC0.X:=VLine0.C1.X+(VLine0.C0.X-VLine0.C1.X)*(MaxZ-VLine0.C1.Z)/
                                              (VLine0.C0.Z-VLine0.C1.Z);
        aC0.Y:=VLine0.C1.Y+(VLine0.C0.Y-VLine0.C1.Y)*(MaxZ-VLine0.C1.Z)/
                                              (VLine0.C0.Z-VLine0.C1.Z);

        AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
        VLineE:=LineU as IDMElement;
        VLine:=VLineE as ILine;
        VLine.C1:=aC0;
        VLine.C0:=VLine0.C0;
        VLine0.C0:=aC0;
        UpdateAreas(NodeE);
      end;

      if VLine1=nil then begin
        DivideVerticalArea(BLine.C1, bdDown, VLine1);
        if VLine1<>nil then
          VLine1E:=VLine1 as IDMElement
        else begin
          AddElement( BLineE.Parent,
                                SpatialModel.Lines, '', ltOneToMany, LineU, True);
          VLine1E:=LineU as IDMElement;
          VLine1:=VLine1E as ILine;
          VLine1S:=VLine1E as ISpatialElement;

          VLine1.Thickness:=0;
          if BLineS.Layer.Expand then begin
            VLine1.Style:=BLine.Style;
            VLine1S.Color:=BLineS.Color;
            VLine1S.Layer:=BLineS.Layer;
          end;

          VLine1.C1:=BLine.C1;

          AddElement( BLineE.Parent,
                                SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
          NodeE:=NodeU as IDMElement;
          VLine1.C0:=NodeE as ICoordNode;
          VLine1.C0.X:=VLine1.C1.X;
          VLine1.C0.Y:=VLine1.C1.Y;
          VLine1.C0.Z:=MaxZ;
        end;
      end;

      if VLine1E.Ref<>nil then begin
      end else
      if VLine1.C0.Z<MaxZ then begin
        AddElement( BLineE.Parent,
                              SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
        NodeE:=NodeU as IDMElement;
        aC1:=NodeE as ICoordNode;
        aC1.Z:=MaxZ;
        aC1.X:=VLine1.C1.X+(VLine1.C0.X-VLine1.C1.X)*(MaxZ-VLine1.C1.Z)/
                                              (VLine1.C0.Z-VLine1.C1.Z);
        aC1.Y:=VLine1.C1.Y+(VLine1.C0.Y-VLine1.C1.Y)*(MaxZ-VLine1.C1.Z)/
                                              (VLine1.C0.Z-VLine1.C1.Z);

        AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
        VLineE:=LineU as IDMElement;
        VLine:=VLineE as ILine;
        VLine.C1:=aC1;
        VLine.C0:=VLine1.C0;
        VLine1.C0:=aC1;
        UpdateAreas(NodeE);
      end;

      if (VLine0E.Parents.Count<>0) and
         (VLine1E.Parents.Count<>0) then
        for m:=0 to VLine0E.Parents.Count-1 do
          if VLine1E.Parents.IndexOf(VLine0E.Parents.Item[m])<>-1 then begin
            SideArea:=VLine0E.Parents.Item[m] as IArea;
            SideAreaE:=SideArea as IDMElement;
            Break;
          end;
    end else begin  //if SideArea<>nil
      SideAreaP:=SideArea as IPolyline;
      VLine0:=BLine.C0.GetVerticalLine(bdDown);
      VLine0E:=VLine0 as IDMElement;
      VLine1:=BLine.C1.GetVerticalLine(bdDown);
      VLine1E:=VLine1 as IDMElement;

      if VLine0=nil then begin
        DivideVerticalArea(BLine.C0, bdDown, VLine0);
        if VLine0=nil then Exit;
        VLine0E:=VLine0 as IDMElement;
        SideArea:=BLine.GetVerticalArea(bdDown);
        SideAreaE:=SideArea as IDMElement;
      end;

      if VLine0E.Ref<>nil then begin
      end else
      if VLine0.C0.Z<MaxZ then begin
        AddElement( BLineE.Parent,
                              SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
        NodeE:=NodeU as IDMElement;
        aC0:=NodeE as ICoordNode;
        aC0.Z:=MaxZ;
        aC0.X:=VLine0.C0.X+(VLine0.C1.X-VLine0.C0.X)*(MaxZ-VLine0.C0.Z)/
                                              (VLine0.C1.Z-VLine0.C0.Z);
        aC0.Y:=VLine0.C0.Y+(VLine0.C1.Y-VLine0.C0.Y)*(MaxZ-VLine0.C0.Z)/
                                              (VLine0.C1.Z-VLine0.C0.Z);

        AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
        VLineE:=LineU as IDMElement;
        VLine:=VLineE as ILine;
        VLine.C1:=aC0;
        VLine.C0:=VLine0.C0;
        VLine0.C0:=aC0;
        UpdateAreas(NodeE);
      end;

      if VLine1=nil then begin
        DivideVerticalArea(BLine.C1, bdDown, VLine1);
        if VLine1=nil then Exit;
        VLine1E:=VLine1 as IDMElement;
        SideArea:=BLine.GetVerticalArea(bdDown);
        SideAreaE:=SideArea as IDMElement;
      end;

      if VLine1E.Ref<>nil then begin
      end else
      if VLine1.C0.Z<MaxZ then begin
        AddElement( BLineE.Parent,
                              SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
        NodeE:=NodeU as IDMElement;
        aC1:=NodeE as ICoordNode;
        aC1.Z:=MaxZ;
        aC1.X:=VLine1.C0.X+(VLine1.C1.X-VLine1.C0.X)*(MaxZ-VLine1.C0.Z)/
                                              (VLine1.C1.Z-VLine1.C0.Z);
        aC1.Y:=VLine1.C0.Y+(VLine1.C1.Y-VLine1.C0.Y)*(MaxZ-VLine1.C0.Z)/
                                              (VLine1.C1.Z-VLine1.C0.Z);

        AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
        VLineE:=LineU as IDMElement;
        VLine:=VLineE as ILine;
        VLine.C1:=aC1;
        VLine.C0:=VLine1.C0;
        VLine1.C0:=aC1;
        UpdateAreas(NodeE);
      end;
    end;       //if SideArea<>nil

    if SideArea=nil then begin
      AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
      HLineE:=LineU as IDMElement;
      HLine:=HLineE as ILine;
      HLineS:=HLineE as ISpatialElement;

      HLine.Thickness:=0;
      if BLineS.Layer.Expand then begin
        HLine.Style:=BLine.Style;
        HLineS.Color:=BLineS.Color;
        HLineS.Layer:=BLineS.Layer;
      end;

      HLine.C0:=VLine0.C0;
      HLine.C1:=VLine1.C0;
      BottomLines2.Add(HLineE);

      AddElement( BaseAreaE.Parent,
                              SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
      SideAreaE:=AreaU as IDMElement;
      SideArea:=SideAreaE as IArea;
      SideAreaP:=SideAreaE as IPolyline;
      SideArea.IsVertical:=True;
      SideArea.Volume0IsOuter:=False;
      SideArea.Volume0:=Volume;
      SideArea.Volume1IsOuter:=ParentVolumeIsOuter;
      SideArea.Volume1:=ParentVolume;

      BLineE.AddParent(SideAreaE);
      VLine0E.AddParent(SideAreaE);
      HLineE.AddParent(SideAreaE);
      VLine1E.AddParent(SideAreaE);
      UpdateElement( SideAreaE);
      UpdateCoords( SideAreaE);
    end else // if SideArea<>nil
    if (SideArea.MinZ<VLine0.C0.Z) or
       (SideArea.MinZ<VLine1.C0.Z) then begin

      AddElement( BLineE.Parent,
                              SpatialModel.Lines, '', ltOneToMany, LineU, True);
      HLineE:=LineU as IDMElement;
      HLine:=HLineE as ILine;
      HLineS:=HLineE as ISpatialElement;

      HLine.Thickness:=0;
      if BLineS.Layer.Expand then begin
        HLine.Style:=BLine.Style;
        HLineS.Color:=BLineS.Color;
        HLineS.Layer:=BLineS.Layer;
      end;

      HLine.C0:=VLine0.C0;
      HLine.C1:=VLine1.C0;

      UpdateAreas(HLineE);
      BottomLines2.Add(HLineE);
      SideArea:=BLine.GetVerticalArea(bdDown);

      if SideArea<>nil then begin
        SideAreaE:=SideArea as IDMElement;
        if SideArea.Volume0=nil then begin
          SideArea.Volume0IsOuter:=False;
          SideArea.Volume0:=Volume
        end else begin
          if SideArea.Volume0=ParentVolume then begin
            SideArea.Volume0IsOuter:=False;
            SideArea.Volume0:=Volume
          end else begin
            SideArea.Volume1IsOuter:=False;
            SideArea.Volume1:=Volume;
          end;
        end;
      end;  

    end else begin  //(if SideArea<>nil) and (SideArea.MinZ=VLine0.C0.Z=VLine1.C0.Z)

      if SideArea.Volume0=nil then begin
        SideArea.Volume0IsOuter:=False;
        SideArea.Volume0:=Volume
      end else begin
        if SideArea.Volume0=ParentVolume then begin
          SideArea.Volume0IsOuter:=False;
          SideArea.Volume0:=Volume
        end else begin
          SideArea.Volume1IsOuter:=False;
          SideArea.Volume1:=Volume;
        end;
      end;

      if SideArea.BottomLines.Count>0 then begin
        for m:=0 to SideArea.BottomLines.Count-1 do begin
          HLineE:=SideArea.BottomLines.Item[m];
          BottomLines2.Add(HLineE);
        end;
        if BottomAreas.Count=0 then begin // достаточно найти плоскость для одной линии
          HLineE:=SideArea.BottomLines.Item[0];
          for k:=0 to HLineE.Parents.Count-1 do begin
            BottomAreaE:=HLineE.Parents.Item[k];
            if BottomAreaE.QueryInterface(IArea, BottomArea)=0 then begin
              if not BottomArea.IsVertical and
                 (BottomAreas.IndexOf(pointer(BottomAreaE))=-1) then
                BottomAreas.Add(pointer(BottomAreaE));
            end;
          end;
        end;
      end;
    end;
  except
    raise
  end; //try
  end; //for j

  BottomAreaE:=nil;
  if (Height=0) then begin
    j:=0;
    while j<BottomAreas.Count do begin
      BottomAreaP:=IDMElement(BottomAreas[j]) as IPolyline;
      if (BottomAreaP.Lines as IDMCollection2).IsEqualTo(BottomLines) then
        Break
      else
        inc(j)
    end;
    if j<BottomAreas.Count then
      BottomAreaE:=BottomAreaP as IDMElement;
  end;
  BottomAreas.Free;

  if BottomAreaE=nil then begin
    AddElement( BaseAreaE.Parent,
                      SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
    BottomAreaE:=AreaU as IDMElement;

    for j:=0 to BottomLines.Count-1 do begin
      HLineE:=BottomLines.Item[j];
      HLineE.AddParent(BottomAreaE);
    end;
  end;

  BottomArea:=BottomAreaE as IArea;
  BottomArea.IsVertical:=False;
  BottomArea.Volume0IsOuter:=False;
  BottomArea.Volume0:=Volume;

  end else begin   //if else not Get_BuildVerticalLine !!!!!!!???????
   aCollection:=DataModel.CreateCollection(-1, nil);  {тек. коллекц.}
   aCollection2:=aCollection as IDMCollection2;
   bCollection:=DataModel.CreateCollection(-1, nil);  {начало       }
   bCollection2:=bCollection as IDMCollection2;
   newCollection:=DataModel.CreateCollection(-1, nil);  {новых лин.   }
   newCollection2:=newCollection as IDMCollection2;
   VLine0E:=nil;
   VLine1E:=nil;
   aCount:=BaseAreaLines.Count;
   for j:=0 to aCount do begin

    if (j>0)and(j<aCount) then begin
     BLineE:=BaseAreaLines.Item[j];
     BLine1E:=BaseAreaLines.Item[j-1]
    end else
     if j=aCount then begin
      BLineE:=BaseAreaLines.Item[aCount-1];
      BLine1E:=BaseAreaLines.Item[0]
    end else begin
      BLineE:=BaseAreaLines.Item[0];
      BLine1E:=BaseAreaLines.Item[aCount-1];
    end;

    BLine:=BLineE as ILine;
    BLineS:=BLineE as ISpatialElement;

    BLine1:=BLine1E as ILine;

    if not IsNotAngular(BLine,BLine1,Node) then begin
      VLine:=Node.GetVerticalLine(bdDown);
      if VLine=nil then begin
        if (BLine.GetVerticalArea(bdDown)=nil)
           and(BLine1.GetVerticalArea(bdDown)=nil) then begin
          AddElement( BLineE.Parent, SpatialModel.Lines,   { new VLine}
                                '', ltOneToMany, LineU, True);
          VLineE:=LineU as IDMElement;
          VLine:=VLineE as ILine;
          VLineS:=VLineE as ISpatialElement;

          VLine.Thickness:=0;
          if BLineS.Layer.Expand then begin
            VLine.Style:=BLine.Style;
            VLineS.Color:=BLineS.Color;
            VLineS.Layer:=BLineS.Layer;
          end;
          VLine.C1:=Node;
          AddElement(BLineE.Parent,SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
          NodeE:=NodeU as IDMElement;
          VLine.C0:=NodeE as ICoordNode;
          VLine.C0.X:=VLine.C1.X;
          VLine.C0.Y:=VLine.C1.Y;
          VLine.C0.Z:=MaxZ;
        end else     //GetVerticalArea(bdDown)=nil
          DivideVerticalArea(Node, bdDown, VLine);
      end;

      VLineE:=VLine as IDMElement;

      if VLine0E=nil then begin  // step 1   selected VLine 0
       VLine0E:=VLineE;
       VLine0:=VLineE as ILine;
       Node0:=Node;
       VLine0.C1:=Node0;
       if VLine.C1=Node0 then
         VLine0.C0:=VLine.C0
       else
         VLine0.C0:=VLine.C1;

       if aCollection.Count>2 then
         for i:=0 to aCollection.Count-1 do
           bCollection2.Add(aCollection.Item[i]);

      end else begin          // step 2   selected VLine 0 VLine 1 build BLine
       VLine1E:=VLineE;
       VLine1:=VLineE as ILine;

      if aCollection.IndexOf(VLineE)=-1 then
        aCollection2.Add(VLineE);

        VLine1.C1:=Node;
        if VLine.C1=Node then
          VLine1.C0:=VLine.C0
        else
          VLine1.C0:=VLine.C1;

{здесь нужена более подробная проверка линий внизу}

        NewLineE:=nil;
        Collection:=(VLine0.C0).Lines;
        for m:=0 to Collection.Count-1 do begin
          HLine:=Collection.Item[m]as ILine;
          if((HLine.C0=VLine0.C0)
             and(HLine.C1=VLine1.C0))
           or((HLine.C1=VLine0.C0)
             and(HLine.C0=VLine1.C0)) then begin
            NewLine:=HLine;
            NewLineE:=NewLine as IDMElement;
            SideAreaE:=HLine.GetVerticalArea(bdDown) as IDMElement;
            break;
          end; //if
        end;  //for m

        if NewLineE=nil then begin
          Collection:=(VLine1.C0).Lines;
          for m:=0 to Collection.Count-1 do begin
           HLine:=Collection.Item[m]as ILine;
           if((HLine.C0=VLine0.C0)
             and(HLine.C1=VLine1.C0))
           or((HLine.C1=VLine0.C0)
             and(HLine.C0=VLine1.C0)) then begin
             NewLine:=HLine;
             NewLineE:=NewLine as IDMElement;
             SideAreaE:=HLine.GetVerticalArea(bdDown) as IDMElement;
             break;
           end; //if
         end;  //for m
       end;

       if NewLineE=nil then begin
        AddElement(VLineE.Parent, SpatialModel.Lines,    { new TLine }
                              '', ltOneToMany, LineU, True);
        NewLineE:=LineU as IDMElement;
        NewLine:=LineU as ILine;

        VLine0:=VLine0E as ILine;
        VLine1:=VLine1E as ILine;

        NewLine.C0:=VLine0.C0;
        NewLine.C1:=VLine1.C0;

        NewLineS:=NewLineE as ISpatialElement;
        NewLine.Thickness:=0;
        if BLineS.Layer.Expand then begin
         NewLine.Style:=BLine.Style;
         NewLineS.Color:=BLineS.Color;
         NewLineS.Layer:=BLineS.Layer;

         AddElement( BLineE.Parent, SpatialModel2.Areas,
                                 '', ltOneToMany, AreaU, True);  { new VArea}
         SideAreaE:=AreaU as IDMElement;
         SideArea:=SideAreaE as IArea;
         SideAreaP:=SideAreaE as IPolyline;
         SideArea.IsVertical:=True;

         if SideArea.Volume0=nil then begin
           SideArea.Volume0IsOuter:=False;
           SideArea.Volume0:=Volume
         end else begin
           if SideArea.Volume0=ParentVolume then begin
             SideArea.Volume0IsOuter:=False;
             SideArea.Volume0:=Volume
           end else begin
             SideArea.Volume1IsOuter:=False;
             SideArea.Volume1:=Volume;
           end;
         end;
       end;

       end else begin

       end;     //Flag

//       NewLineE.AddParent(TopAreaE);

       aCollection2.Add(NewLineE);
       newCollection2.Add(NewLineE);

       for i:=0 to aCollection.Count-1 do
        (aCollection.item[i]).AddParent(SideAreaE);

       UpdateElement( SideAreaE);
       UpdateCoords( SideAreaE);

       VLine0E:=VLine1E;
       VLine1E:=nil;

       aCollection2.Clear;
       aCollection2.Add(VLineE);
       aCollection2.Add(BLineE);
      end;    // step 2
     end  else begin //if  else not IsNotAngular
       if aCollection.IndexOf(BLineE)=-1 then
        aCollection2.Add(BLineE);
     end; //if not IsNotAngular
   end;  //for J
  //_____________________

  if bCollection.Count>0 then begin    { если не обраб. начало }
   VLine1E:=bCollection.Item[bCollection.Count-1]; { соеденить остаток необраб.}
   if aCollection.Count>0 then begin               { конца с необраб. началом  }
    VLine0E:=aCollection.Item[0];
    for j:=0 to aCollection.Count-1 do
     bCollection2.Add(aCollection.Item[j]);
   end;

{здесь нужена более подробная проверка линий внизу}

        NewLineE:=nil;
        Collection:=(VLine0.C0).Lines;
        for m:=0 to Collection.Count-1 do begin
         HLine:=Collection.Item[m]as ILine;
         if((HLine.C0=VLine0.C0)
             and(HLine.C1=VLine1.C0))
           or((HLine.C1=VLine0.C0)
             and(HLine.C0=VLine1.C0)) then begin
          NewLine:=HLine;
          NewLineE:=NewLine as IDMElement;
          SideAreaE:=HLine.GetVerticalArea(bdUp) as IDMElement;
          break;
         end; //if
        end;  //for m

        if NewLineE=nil then begin
        Collection:=(VLine1.C0).Lines;
        for m:=0 to Collection.Count-1 do begin
         HLine:=Collection.Item[m]as ILine;
         if((HLine.C0=VLine0.C0)
             and(HLine.C1=VLine1.C0))
           or((HLine.C1=VLine0.C0)
             and(HLine.C0=VLine1.C0)) then begin
          NewLine:=HLine;
          NewLineE:=NewLine as IDMElement;
          SideAreaE:=HLine.GetVerticalArea(bdUp) as IDMElement;
          break;
         end; //if
        end;  //for m
        end;

   if NewLineE=nil then begin
     AddElement(VLineE.Parent, SpatialModel.Lines,
                        '', ltOneToMany, LineU, True);   { new HLine }
     NewLine:=NewLineE as ILine;

     NewLineS:=NewLineE as ISpatialElement;
     NewLine.Thickness:=0;
     if BLineS.Layer.Expand then begin
       NewLine.Style:=BLine.Style;
       NewLineS.Color:=BLineS.Color;
       NewLineS.Layer:=BLineS.Layer;
     end;
     AddElement( BLineE.Parent, SpatialModel2.Areas,
                             '', ltOneToMany, AreaU, True);
     SideAreaE:=AreaU as IDMElement;
     SideArea:=SideAreaE as IArea;
     SideAreaP:=SideAreaE as IPolyline;
     SideArea.IsVertical:=True;

     if SideArea.Volume0=nil then begin
       SideArea.Volume0IsOuter:=False;
       SideArea.Volume0:=Volume
     end else begin
       if SideArea.Volume0=ParentVolume then begin
         SideArea.Volume0IsOuter:=False;
         SideArea.Volume0:=Volume
       end else begin
         SideArea.Volume1IsOuter:=False;
         SideArea.Volume1:=Volume;
       end;
     end;
   end;

   VLine0:=VLine0E as ILine;
   VLine1:=VLine1E as ILine;
   NewLine.C0:=VLine0.C0;
   NewLine.C1:=VLine1.C0;

   bCollection2.Add(NewLineE);

   for i:=0 to bCollection.Count-1 do
    (bCollection.item[i]).AddParent(SideAreaE);
   UpdateElement( SideAreaE);
   UpdateCoords( SideAreaE);

   NewLineE:=LineU as IDMElement;

  end;

   newCollection2.Add(NewLineE);
   for i:=0 to newCollection.Count-1 do
    (newCollection.item[i]).AddParent(BottomAreaE);
   BottomArea.IsVertical:=False;
   UpdateElement( BottomAreaE);
   UpdateCoords( BottomAreaE);

 end; //if else not Get_BuildVerticalLine

  try
  for j:=0 to Volume.Areas.Count-1 do begin
    AreaE:=Volume.Areas.Item[j];
    UpdateElement( AreaE);
    UpdateCoords( AreaE);
  end;
  except
    raise
  end;
  UpdateElement( Result);

end;
*)

procedure TCustomSMDocument.SelectAllNodes;
var
  SpatialModel:ISpatialModel;
  j, OldSelectState:integer;
begin
  SpatialModel:=Get_DataModel as ISpatialModel;
  ClearSelection(nil);
  OldSelectState:=FState and dmfSelecting;
  FState:=FState or dmfSelecting;
  try
  for j:=0 to SpatialModel.CoordNodes.Count-1 do
    SpatialModel.CoordNodes.Item[j].Selected:=True;
  finally
  FState:=FState and not dmfSelecting or OldSelectState;
  end;
  if SpatialModel.CoordNodes.Count>0 then
    Get_Server.SelectionChanged(SpatialModel.CoordNodes.Item[0]);
end;

function TCustomSMDocument.BuildReliefArea(const BaseArea: IArea; const NewLines,
  UsedNodes: IDMCollection; var BLine0E, BLine1E: IDMElement): IArea;
var
 aSpatialModel:ISpatialModel;
 aSpatialModel2:ISpatialModel2;
 aLineNewU,aAreaU,VolumeU:IUnknown;
 aLineNewE, aLine0E, aLineE:IDMElement;
 BLine0, BLine1, aLineNew:ILine;
 aNewArea, BottomArea:IArea;
 aNewAreaE:IDMElement;

 j,i,k,m,n:integer;
 Flag:boolean;
 FlagArea:boolean;
 aNode0,aNode1,aNode2,aNode3,aNode4,C0,C1:ICoordNode;
 aLine0,aLineJ,aLine:ILine;
 aBaseAreaP,aAreaP,aAreaJP:IPolyLine;
 aAreaJ,aArea:IArea;
 aAreaE,aAreaJE, RefElement,VolumeE,NewVolumeE,RefParent, BaseAreaE,
 BottomAreaE, aBAreaE:IDMElement;
 Volume,NewVolume:IVolume;
 aList:TList;
 aLineList:TList;
 aBaseLineList:TList;
 aTmpList:TList;
 aTmpListArea:TList;
begin
    Result:=nil;
    aList:=TList.Create;                           {сп.обработ-x точек}
    aLineList:=TList.Create;                       {сп.обработ-x Line}
    aBaseLineList:=TList.Create;                   {сп.обработ-x BaseLine}
    aTmpList:=TList.Create;                        {сп.обработ-x точек}
    aTmpListArea:=TList.Create;                        {сп.обработ-x точек}
    BLine0:=BLine0E as ILine;
    BLine1:=BLine1E as ILine;

    aSpatialModel:=Get_DataModel as ISpatialModel;
    aSpatialModel2:=aSpatialModel as ISpatialModel2;

    aBaseAreaP:=BaseArea as IPolyLine;
    BaseAreaE:=BaseArea as IDMElement; 

    BottomAreaE:=nil;
    for j:=0 to aBaseAreaP.Lines.Count-1 do begin //по числу лин.в исх.горизонт.плоск.
     aLineJ:=(aBaseAreaP.Lines.Item[j])as ILine;
     if aLineJ.C0.Z=aLineJ.C1.Z then begin
      aAreaJ:=aLineJ.GetVerticalArea(bdUp);     //верт.плоск.Up через линию
      if aAreaJ<>nil then begin
       aAreaJP:=aAreaJ as IPolyLine;
       for i:=0 to aAreaJP.Lines.Count-1 do begin //по числу лин.в верт.плоск.
        aLine:=(aAreaJP.Lines.Item[i])as ILine;
        for k:=0 to UsedNodes.Count-1 do begin
         aNode2:=UsedNodes.Item[k] as ICoordNode;
         if (aNode2=aLine.C0)or(aNode2=aLine.C1)then begin
          if aTmpList.IndexOf(pointer(aNode2))=-1 then begin
           aTmpList.Add(pointer(aNode2));               {если нет в списке}
           aTmpListArea.Add(pointer(aAreaJ));
          end;
         end; //if (aNode2=aLine.C0 or C1)
        end;   //for k:=0 to NodesList.Count-1
       end;   //for i:=0 to aLinesCount-1


       if aTmpList.Count>1 then begin

        aList.Add(pointer(ICoordNode(aTmpList[0])));        { в списoк}
        aList.Add(pointer(ICoordNode(aTmpList[1])));        { в списoк}
        m:=2;
        while m<aTmpList.Count-2 do begin
         aNode1:=ICoordNode(aTmpList[m]);
         aNode2:=ICoordNode(aTmpList[m+1]);
         Flag:=True;
         for k:=0 to aList.Count-1 do begin
          aNode3:=ICoordNode(aList[k]);
          aNode4:=ICoordNode(aList[k+1]);
          if (aNode1=aNode3)and(aNode2=aNode4)
            or(aNode2=aNode3)and(aNode1=aNode4)then begin
           Flag:=False;
           break;
          end;
         end;
         if Flag then begin
          aList.Add(pointer(aNode1));        { в списoк}
          aList.Add(pointer(aNode2));        { в списoк}
         end;
         inc(m);
        end;

        for k:=0 to aList.Count-2 do begin
         aNode1:=ICoordNode(aList[k]);
         aNode2:=ICoordNode(aList[k+1]);
         if aNode1.Z<>aNode2.Z then begin
          Flag:=True;
          for i:=0 to NewLines.Count-1 do begin
           aLine:=NewLines.Item[i] as ILine;   {нет ли линнии через эти точки}
           if ((aLine.C0.X=aNode1.X)and(aLine.C1.X=aNode2.X)
             and(aLine.C0.Y=aNode1.Y)and(aLine.C1.Y=aNode2.Y))
             or((aLine.C1.X=aNode1.X)and(aLine.C0.X=aNode2.X)
             and(aLine.C1.Y=aNode1.Y)and(aLine.C0.Y=aNode2.Y)) then begin
             Flag:=False;      {есть - создавать не будем}
             break;
            end;
          end;   // i=0-Count-1

          if Flag then begin

           aSpatialModel:=Get_DataModel as ISpatialModel;
           AddElement(aSpatialModel2.ReliefLayer,
                             aSpatialModel.Lines, '', ltOneToMany, aLineNewU, True);
           aLineNewE:=aLineNewU as IDMElement;
           aLineNew:=aLineNewE as ILine;
           aLineNew.C0:=aNode1;
           aLineNew.C1:=aNode2;
           
//_________найти плоск.в которой лежат обе точки__
           aArea:=nil;
           for i:=0 to aAreaJP.Lines.Count-1 do begin
            aLine:=(aAreaJP.Lines.Item[i])as ILine; {просм.все лин.плоскости}
            if (aLine.C0=aNode1)or(aLine.C1=aNode1)then begin
             for n:=0 to aAreaJP.Lines.Count-1 do begin
              aLine:=(aAreaJP.Lines.Item[n])as ILine; {просм.все лин.плоскости}
              if (aLine.C0=aNode2)or(aLine.C1=aNode2)then begin
               aArea:=aAreaJP as IArea;
               break;
              end;
             end;   // n  -Lines
            end;
            if aArea<>nil then
             break;
           end; //i  -Lines

          if aArea<>nil then begin
//________ ___
           aNewArea:=LineDivideArea(aLineNew.C0,aLineNew.C1,aArea);
           aAreaE:=aArea as IDMElement;
           aNewAreaE:=aNewArea as IDMElement;

           (aLineNew as IDMElement).AddParent(aNewAreaE);
           (aLineNew as IDMElement).AddParent(aAreaE);

           UpdateElement(aAreaE);
           UpdateElement(aNewAreaE);
           UpdateCoords(aAreaE);
           UpdateCoords(aNewAreaE);

           if aArea.Volume0<>nil then
            UpdateElement(aArea.Volume0 as IDMElement);

           if aArea.Volume1<>nil then
            UpdateElement(aArea.Volume1 as IDMElement);

          end else begin//aArea=nil
           (aLineNew as IDMElement).AddParent(aAreaJE);

           UpdateElement(aAreaJE);
           UpdateCoords(aAreaJE);

           if aAreaJ.Volume0<>nil then
            UpdateElement(aAreaJ.Volume0 as IDMElement);

           if aAreaJ.Volume1<>nil then
            UpdateElement(aAreaJ.Volume1 as IDMElement);
          end;

        {   MessageDlg((aLineNew as IDMElement).Name +'.-.'+ aAreaE.Name + '('+
                    IntToStr(aAreaE.ID)+') // '+ aNewAreaE.Name+ '('+
                        IntToStr(aNewAreaE.ID)+')',mtCustom,[mbOK],0);   }

           aLineList.Add(pointer(aLineNew));
           aBaseLineList.Add(pointer(aLineNew));
           (NewLines as IDMCollection2).Add(aLineNewE);  // Line in List

           if BLine0E=nil then begin
            BLine0E:=aLineNewE;
            BLine0:=BLine0E as ILine;
           end else
            if BLine1E=nil then begin
             BLine1E:=aLineNewE;
             BLine1:=BLine1E as ILine;
            end;
          end else begin
          if aLineList.IndexOf(pointer(aLine))=-1 then
           aLineList.Add(pointer(aLine));
           aBaseLineList.Add(pointer(aLine));                    // Line in List
          end;   //flag

         end else begin  //aNode1.Z=aNode2.Z
//................
          for m:=0 to aNode1.Lines.Count-1 do begin       {перебрать список выходящ. линий}
           aLine:=aNode1.Lines.Item[m] as ILine;
           if (aLine.C0=aNode2)or(aLine.C1=aNode2)
             and(aLineList.IndexOf(pointer(aLine))=-1) then begin {и добавить в сп.линии того же уровня}
            aLineList.Add(pointer(aLine));                    // Line in List
            aBaseLineList.Add(pointer(aLine));                    // Line in List
           end;
          end;
//................
         end;
        end;   //for k:=0 to aList.Count-2
        aTmpList.Clear;
        aList.Clear;

       end;
      end;     //if aAreaJ<>nil
     end;     //C0.Z=C1.Z
    end;      //for j:=0 to aCount-1

   BottomAreaE:=BaseAreaE;

  if (BLine0<>nil) and (BLine1<>nil)
     and(aLineList.Count=aBaseAreaP.Lines.Count-1) then begin
   aNode1:=BLine0.C0;
   aNode2:=BLine0.C1;
   aNode3:=BLine1.C0;
   aNode4:=BLine1.C1;
   aNode0:=aNode1;
   for j:=0 to aLineList.Count-1 do begin
    aLine:=ILine(aLineList[0]);
    C0:=aLine.C0;
    C1:=aLine.C1;
    if(aLine<>BLine0)and((aNode1=C0)or(aNode1=C1))then begin
     aNode0:=nil;
     break;
    end;
   end;
   if aNode0=nil then begin
    for j:=0 to aLineList.Count-1 do begin
     aLine:=ILine(aLineList[0]);
     C0:=aLine.C0;
     C1:=aLine.C1;
     aNode0:=aNode2;
     if(aLine<>BLine0)and((aNode2=C0)or(aNode2=C1))then begin
      aNode0:=nil;
      break;
     end;
    end;
   end;
   if aNode0<>nil then
    aNode1:=aNode0
   else
    aNode1:=nil;

   for j:=0 to aLineList.Count-1 do begin
    aLine:=ILine(aLineList[0]);
    C0:=aLine.C0;
    C1:=aLine.C1;
    aNode0:=aNode3;
    if(aLine<>BLine1)and((aNode3=C0)or(aNode3=C1))then begin
     aNode0:=nil;
     break;
    end;
   end;
   if aNode0=nil then begin
    for j:=0 to aLineList.Count-1 do begin
     aLine:=ILine(aLineList[0]);
     C0:=aLine.C0;
     C1:=aLine.C1;
     aNode0:=aNode4;
     if(aLine<>BLine1)and((aNode4=C0) or (aNode4=C1))then begin
      aNode0:=nil;
      break;
     end;
    end;
   end;
   if aNode0<>nil then
    aNode2:=aNode0
   else
    aNode2:=nil;

   if (aNode1<>nil) and (aNode2<>nil) then begin
   {если в сп.нет линии, соединяющей aNode1 и aNode2 (концы наклонных), то добавить }
     for j:=0 to aNode1.Lines.Count-1 do begin     {перебрать список выходящ. линий}
      aLine:=aNode1.Lines.Item[j] as ILine;
      if (aLine.C0=aNode2)or (aLine.C1=aNode2)
       and(aLineList.IndexOf(pointer(aLine))=-1) then begin
       aLineList.Add(pointer(aLine));                    // Line in List
       aBaseLineList.Add(pointer(aLine));                // Line in List
       break;
      end;
     end;
   end;
  end;
  if (aBaseLineList.Count=aBaseAreaP.Lines.Count)
     and (aLineList.Count>2)  then begin             //созд.новой плоск.(наклон.)
   aLineE:=ILine(aLineList[0]) as IDMElement;
   AddElement(aLineE.Parent,
                         aSpatialModel2.Areas, '', ltOneToMany, aAreaU, True);
   aAreaE:=aAreaU as IDMElement;
   aArea:=aAreaE as IArea;
   result:=aArea;
   BottomArea:=BottomAreaE as IArea;
   aAreaE.Ref:=CreateClone(BottomAreaE.Ref) as IDMElement;
   for j:=0 to aLineList.Count-1 do begin
    aLineE:=ILine(aLineList[j]) as IDMElement;
    AddElementParent(aAreaE, aLineE);
   end;
   UpdateElement(aAreaE);
  end;

  //_____________________
  if aArea<>nil then begin
    Volume:=BaseArea.Volume0;
    VolumeE:=Volume as IDMElement;

    AddElement((Volume as IDMElement).Parent, aSpatialModel2.Volumes, '', ltOneToMany, VolumeU, True);
    NewVolumeE:=VolumeU as IDMElement;
    NewVolume:=NewVolumeE as IVolume;
    RefElement:=CreateClone(VolumeE.Ref) as IDMElement;
    NewVolumeE.Ref:=RefElement;

    RefParent:=VolumeE.Ref.Parent;

    ChangeParent( nil, nil, VolumeE.Ref); //чтобы не передавать
                                          // изменения границ в родительские зоны
    aArea.Volume0IsOuter:=False;
    aArea.Volume0:=Volume;
    aArea.Volume1IsOuter:=False;
    aArea.Volume1:=NewVolume;

    MoveAreas(NewVolume, Volume, BaseArea, aArea);
    UpdateElement( VolumeE);
    UpdateElement( NewVolumeE);

    ChangeParent( nil, RefParent, RefElement);
    ChangeParent( nil, RefParent, VolumeE.Ref);  // восстановление
                                                 // родительской зоны
//    SpatialModel2.CheckVolumeContent(NewVolumes, Volume, 0);
  end;
  aList.Free;
  aLineList.Free;
  aBaseLineList.Free;
  aTmpList.Free;
end;

function TCustomSMDocument.GetNearestLabel(WX, WY, WZ: Double; Tag: Integer;
  const ExceptedNode: ICoordNode; BlindMode:WordBool): ISMLabel;
var
  i: integer;
  aLabel:ISMLabel;
  SpatialModel2:ISpatialModel2;
  View:IView;

  function CoordRef(const aLabel:ISMLabel; var X,Y,Z:double):boolean ;
  var
   aElementS:ISpatialElement;
   aElement:IDMElement;
   aNode:ICoordNode;
   aLine:ILine;
   aArea:IArea;
   aVolume:IVolume;
  begin
   aElement:=(aLabel as IDMElement).Ref.SpatialElement;
   aElementS:=aElement as ISpatialElement;
   if aElement.QueryInterface(ISpatialElement, aElementS)<>0 then begin
    result:=False;
    Exit;
   end;

   result:=True;
  {_________________ точка     }
   if aElement.QueryInterface(ICoordNode, aNode)=0 then begin
    X:=aNode.X;
    Y:=aNode.Y;
    Z:=aNode.Z;
   end else
   {_________________ линия    }
    if aElement.QueryInterface(ILine, aLine)=0 then begin
     X:=aLine.C0.X;
     Y:=aLine.C0.Y;
     Z:=aLine.C0.Z;
    end else
    {_________________ плоск.   }
     if aElement.QueryInterface(IArea, aArea)=0 then begin
      X:=aArea.C0.X;
      Y:=aArea.C0.Y;
      Z:=aArea.C0.Z;
     end else
    {_________________ объем.   }
     if aElement.QueryInterface(IVolume, aVolume)=0 then begin
       if (aVolume.BottomAreas.Count>0) then begin
         aArea:=aVolume.BottomAreas.Item[0] as IArea;
         aArea.GetCentralPoint(X, Y, Z);
       end else
         result:=False;
     end else
      result:=False;
  end;
var
  X, Y, Z, X0, Y0, Z0, MinD, D: double;
begin
  MinD:=FSnapDistance*FPainter.View.RevScaleX;
  Result:=nil;
  SpatialModel2:=Get_DataModel as ISpatialModel2;
  View:=FPainter.View;
  for i:=0 to SpatialModel2.Labels.Count-1 do begin
   aLabel:=SpatialModel2.Labels.Item[i] as ISMLabel;
   if CoordRef(aLabel,X0,Y0, Z0) then begin
    X:=X0 + aLabel.LabeldX;
    Y:=Y0 + aLabel.LabeldY;
    Z:=Z0;
    if BlindMode or View.PointIsVisible(X, Y, Z, Tag) then begin
     D:=sqrt(sqr(WX-X)+sqr(WY-Y)+sqr(WZ-Z));
     if MinD>D then begin
      MinD:=D;
      Result:=aLabel
     end;
    end;
   end;
  end;
end;

function TCustomSMDocument.Get_NearestLabel: IDMElement;
var
  Tag:integer;
begin
  if FHWindowFocused then
    Tag:=1
  else
  if FVWindowFocused then
    Tag:=2
  else begin
    Result:=nil;
    Exit;
  end;

  Result:=GetNearestLabel(FCurrX, FCurrY, FCurrZ, Tag, nil, False) as IDMElement
end;

function TCustomSMDocument.IsNotAngular(Line,Line1:ILine;var Node:ICoordNode):boolean ;
  //True -если Line,Line1 лежат на прямой, Node точка деления
  var
   x00,x01,x10,x11,y00,y01,y10,y11:double;
  begin
   x00:=Line.C0.X;
   y00:=Line.C0.Y;
   x01:=Line.C1.X;
   y01:=Line.C1.Y;
   x10:=Line1.C0.X;
   y10:=Line1.C0.Y;
   x11:=Line1.C1.X;
   y11:=Line1.C1.Y;

   if ((Line.C0=Line1.C0)
         and(abs((x00-x01)*(y11-y01)-(y00-y01)*(x11-x01))<10))
      or((Line.C0=Line1.C1)
         and(abs((x00-x01)*(y10-y01)-(y00-y01)*(x10-x01))<10))then begin
    Node:=Line.C0;
    result:=True;
   end else
    if ((Line.C1=Line1.C0)
         and(abs((x01-x00)*(y11-y00)-(y01-y00)*(x11-x00))<10))
      or((Line.C1=Line1.C1)
         and(abs((x01-x00)*(y10-y00)-(y01-y00)*(x10-x00))<10)) then begin
     Node:=Line.C1;
     result:=True;
   end else begin
    result:=False;
    if (Line.C0=Line1.C0)or(Line.C0=Line1.C1) then
     Node:=Line.C0
    else
     Node:=Line.C1;
   end;
end;

function TCustomSMDocument.AreaWithInternalNode(const C0: ICoordNode; const C1: ICoordNode;
                                   const C2: ICoordNode; Stat: Integer;
                                   AreaDivided:boolean): IArea;
  {result=Area -между точками C0,C1, C2-внутр.
   Stat- 0 - найти горизонт.плоск. 1 - верт.плоск. 2 - любую                }
var
  Line1E, Line3E:IDMElement;
  aArea:IArea;
  aAreaE, CommonLineE:IDMElement;
  j, j0, j1,  i0, i1,aStat:integer;
  X,Y,Z,X1,Y1,Z1:double;
  Flag, CommonLineFlag:boolean;
  aLine:ILine;
begin
  j:=0;
  while j<C0.Lines.Count do begin
    aLine:=C0.Lines.Item[j] as ILine;
    if C1=aLine.NextNodeTo(C0) then
      break
    else
      inc(j)
  end;
  if j<C0.Lines.Count then begin
    CommonLineE:=aLine as IDMElement;
    CommonLineFlag:=(CommonLineE.Parents.Count=0);
  end else begin
    CommonLineE:=nil;
    CommonLineFlag:=False;
  end;

  X:=(C0.X+C1.X)/2;
  Y:=(C0.Y+C1.Y)/2;    {X,Y,Z между C0,C1}
  Z:=(C0.Z+C1.Z)/2;
  if C2<>nil then begin
   X1:=(C2.X+X)/2;      {X,Y,Z между C0,C1,C2}
   Y1:=(C2.Y+Y)/2;
   Z1:=(C2.Z+Z)/2;
  end else begin
   X1:=X;
   Y1:=Y;
   Z1:=Z;
  end;
  result:=nil;
  aArea:=nil;
  for j0:=0 to C0.Lines.Count-1 do begin
    Line1E:=C0.Lines.Item[j0];
    for j1:=0 to Line1E.Parents.Count-1 do begin
      aAreaE:=Line1E.Parents.Item[j1];
      if (aAreaE.QueryInterface(IArea, aArea)=0) and
         ((aArea.Flags and afEmpty)=0) then begin

        Flag:=True;
        if aArea.IsVertical then
          if Stat=0 then
           Flag:=False
        else
        if Stat=1 then
         Flag:=False;

        if Flag then begin
          for i0:=0  to C1.Lines.Count-1 do begin
            Line3E:=C1.Lines.Item[i0];
            for i1:=0 to Line3E.Parents.Count-1 do begin
              if aAreaE=Line3E.Parents.Item[i1] then begin
                if CommonLineFlag then begin
                  result:=aArea;
                  Exit;
                end else
                if (CommonLineE<>nil) and
                   ((CommonLineE.Parents.IndexOf(aAreaE)<>-1)=AreaDivided) then begin
                    result:=aArea;
                    Exit;
{
                end else
                if NodeIsInternalCheck(aArea, X, Y, Z, aStat) then begin
                  result:=aArea;
                  Exit;
}
                end else
                if (C2<>nil) and
                   NodeIsInternalCheck(aArea, X1, Y1, Z1, aStat) then begin
                  result:=aArea;
                  Exit;
                end;
              end;
            end; // for i1
          end;  // for i0
        end // if Flag
      end;
    end; // for l1
  end; // for j0


end; //function TCustomSMDocument.AreaWithInternalNode

function  TCustomSMDocument.NodeIsInternalCheck(const Area:IArea;
                                        X:Double;Y:Double;Z:Double;
                                        out Stat:Integer):WordBool;
  {Stat=0, result=True -точка X,Y внутр.[число пересечений линий Area c вектором
   из центра точки -нечетное], иначе внешняя [result=False].
   Stat:=-2 -обл.не корректна
   Верт.плоскость преобраз.к горизонт.операт.X=x+(z-z0);Y=y+(z-z0);      }
var
   aCollection:IDMCollection;
   aCount:integer;
   i,kC:integer;
   aLine:ILine;
   x0,y0, x1,y1,xi,yi:double;
   P1x,P1Y,P2X,P2Y:double;
   zMin:double;
begin
  aCollection:=(Area as IPolyLine).Lines;
  aCount:=aCollection.Count;
  if (aCount<3) then begin
    Stat:=-2;      //обл.не корректна
    result:=False;
    Exit;
  end;

   Stat:=0;         //обл корректна
   //~линия xo,y0-x1,y1 через серед.aLine и Node --------
   if Area.IsVertical then begin
    zMin:=Area.MinZ;    //преобраз.к горизонт.
    x0:=X+Z-zMin;
    y0:=Y+Z-zMin;
   end else begin
     Result:=Area.ProjectionContainsPoint(X, Y, 0);
     Exit;
   end;

    {построить секущую X0,y0 - P2x,P2y - x1,y1 , по возможности не парал.ocи x или y}
   P2X:=0;
   P2Y:=0;
   for i:=0 to aCollection.Count-1 do begin
    aLine:= aCollection.Item[i] as ILine;
    P2x:=(2.14*aLine.C0.X + aLine.C1.X)/3.14;  //P2x сдвинуть oт C0.X на некратный интервал
    P2y:=(2.14*aLine.C0.Y + aLine.C1.Y)/3.14;
    if Area.IsVertical then begin
     P2x:=P2x+(2.14*aLine.C0.Z + aLine.C1.Z)/3.14-zMin;
     P2y:=P2y+(2.14*aLine.C0.Z + aLine.C1.Z)/3.14-zMin;
    end;
    if (P2x<>x0)and(P2y<>y0) then
     break;
   end; //for j

//   x0:=x0+(P2x-x0)*0.01;  //X,Y сдвинуть в направлении P2x,P2y
//   y0:=y0+(P2y-y0)*0.01;

   if (P2x<>x0)then begin
    if P2x>x0 then
     x1:=1.E8
    else
     x1:=-1.E8;

    y1:=(x1-x0)*(P2y-y0)/(P2x-x0)+y0;   //из ур. (X-x1)/(x2-x1)=(Y-y1)/(y2-y1)
   end else begin
    if P2y>y0 then
     y1:=1.E8
    else
     y1:=-1.E8;

    x1:=(y1-y0)*(P2x-x0)/(P2y-y0)+x0;   //из ур. (X-x1)/(x2-x1)=(Y-y1)/(y2-y1)
   end;

   //------------------
   kC:=0;
   for i:=0 to aCount-1 do begin
     aLine:=(aCollection.Item[i]) as ILine;
     P1X:=aLine.C0.X;
     P1Y:=aLine.C0.Y;
     P2X:=aLine.C1.X;
     P2Y:=aLine.C1.Y;
     if Area.IsVertical then begin
      P1x:=P1x+(aLine.C0.Z -zMin);   //преобраз.к горизонт.
      P1y:=P1y+(aLine.C0.Z -zMin);
      P2x:=P2x+(aLine.C1.Z -zMin);
      P2y:=P2y+(aLine.C1.Z -zMin);
     end;

     if Crossing_Node(x0,y0, x1,y1, P1X,P1Y, P2X,P2Y,xi,yi) then
      if (abs(xi-x0)>1.E-4)and(abs(yi-Y0)>1.E-4) then  //если пересеч.не в баз.точке
       kC:=kC+1;
    end;

   if (kC div 2)=(kC/2) then
     result:=False      // точка внешняя
   else
     result:=True;      // точка внутр.[число пересечений -нечетное]

end;  //function NodeIsInternal


function TCustomSMDocument.FindEndedNodes(const Lines: IDMCollection;
                     out C0, C1, C2: ICoordNode):WordBool;
  {найти C0,C1 -нач. и конеч.точки тек.полилинии  C2 ~центр.точка}
var
  j,i:integer;
  aC0, aC1, aC01, aC11:ICoordNode;
  aCount:integer;
  C0Flag,C1Flag:boolean;
begin
  result:=False;
  aCount:=Lines.Count;
  if aCount<1 then Exit;

  if aCount=1 then begin
   C0:=(IDMElement(Lines.Item[0])as ILine).C0;
   C1:=(IDMElement(Lines.Item[0])as ILine).C1;
   C2:=nil;
   result:=True;
   Exit;
  end else begin
   C2:=(Lines.Item[Lines.Count div 2]as ILine).C0;
   for j:=0 to Lines.Count-1 do begin
    aC0:=(IDMElement(Lines.Item[j])as ILine).C0;
    aC1:=(IDMElement(Lines.Item[j])as ILine).C1;
    C0Flag:=True;
    C1Flag:=True;
    for i:=0 to Lines.Count-1 do
     if i<>j then begin
      aC01:=(IDMElement(Lines.Item[i])as ILine).C0;
      aC11:=(IDMElement(Lines.Item[i])as ILine).C1;
      if ((aC0=aC01)or(aC0=aC11))then
       C0Flag:=False;
      if ((aC1=aC01)or(aC1=aC11))then
       C1Flag:=False;
    end;

    if C0Flag then begin
     if C0=nil then
      C0:=aC0
     else
      C1:=aC0
    end;
    if C1Flag then
     if C0=nil then
      C0:=aC1
     else
      C1:=aC1;

    if (C0<>nil)and(C1<>nil) then
     result:=True;

    if (C2=C0)or(C2=C1)then
     C2:=(Lines.Item[Lines.Count div 2]as ILine).C1;
   end;
  end;
end;  //procedure FindNodes

function TCustomSMDocument.Find_DivideAreaWithNodes(const C0,C1,C2:ICoordNode;
                                      const LineCollection:IDMCollection;
                                      out NewArea:IArea):IArea;
  {найти Area c C0,C1 -нач. и конеч.точки   C2 ~центр.точка
  result=Area/NewArea  между C0,C1                                            }
var
  j:integer;
  aLine:ILine;
  aC0, aC1:ICoordNode;
  NodeList:TList;
  aArea:IArea;

  function NodeIsOuter(const aC:ICoordNode):boolean;
  var
    X, Y:double;
  begin
    Result:=False;
    if aC=C0 then Exit;
    if aC=C1 then Exit;
    if NodeList.IndexOf(pointer(aC))<>-1 then Exit;
    NodeList.Add(pointer(aC));
    X:=aC.X;
    Y:=aC.Y;
    if aArea.ProjectionContainsPoint(X, Y, 0) then Exit;
    Result:=True;
  end;
begin
  NewArea:=nil;
  aArea:=nil;
  if (C0<>nil)and(C1<>nil) then
    aArea:=AreaWithInternalNode(C0, C1, C2, 0, False);

  if aArea<>nil then begin
    j:=0;
    NodeList:=TList.Create;
    while j<LineCollection.Count do begin
      aLine:=LineCollection.Item[j] as ILine;
      aC0:=aLine.C0;
      aC1:=aLine.C1;
      if NodeIsOuter(aC0) then
        Break
      else
      if NodeIsOuter(aC1) then
        Break
      else
        inc(j)
    end; // while j<LineCollection.Count
    NodeList.Free;
    if j=LineCollection.Count then begin
      NewArea:=LineDivideArea(C0,C1, aArea);
      Result:=aArea;
    end;
  end; // if aArea<>nil
end;  //Find_DivideAreaWithNodes

procedure TCustomSMDocument.Lines_AddParent(const aLines:IDMCollection;var Area:IArea);
var
  j, m:integer;
  aLineE:IDMElement;
  aAreaE:IDMElement;
begin
     if Area<>nil then begin
      aAreaE:=Area as IDMElement;
      for j:=0 to aLines.Count-1 do begin
       aLineE:=IDMElement(aLines.Item[j]);
       m:=aLineE.Parents.IndexOf(aAreaE);
       if m=-1 then
         aLineE.AddParent(aAreaE)
       else
         aLineE.RemoveParent(aAreaE)
      end;  //for j

      UpdateElement( aAreaE);
      UpdateCoords( aAreaE);
      if Area.Volume0<>nil then
        UpdateElement( Area.Volume0 as IDMElement);
      if Area.Volume1<>nil then
        UpdateElement( Area.Volume1 as IDMElement);
     end;  //
end;

function  TCustomSMDocument.LineSeparate(X: Double; Y: Double; Z: Double; Direct: WordBool;
                                      var NLine: ILine; var C0: ICoordNode): ILine;
   {разделить линию NLine  в точке С0~X,Y,Z. Если Direct=True или С0=nil ,
    то С0 создать.
   result=NewLine (C0~X,Y,Z/NodeNew~C0.X,C.Y,C0.Z))
          NLine (../С0~X,Y,Z) }
var
   SpatialModel:ISpatialModel;
   aLineU,aNodeU:IUnknown;
   aLineE,aParentE,NLineE:IDMElement;
   aLine:ILine;
   j:integer;
begin
    SpatialModel:=Get_DataModel as ISpatialModel;
    if Direct then begin
     AddElement((NLine as IDMElement).Parent,
                     SpatialModel.CoordNodes, '', ltOneToMany, aNodeU, True);
     C0:=aNodeU as ICoordNode;
     C0.X:=X;
     C0.Y:=Y;
     C0.Z:=Z;
    end;

    NLineE:=NLine as IDMElement;
    AddElement(NLineE.Parent,
                     SpatialModel.Lines, '', ltOneToMany, aLineU, True);
    aLineE:=aLineU as IDMElement;
    aLine:=aLineE as ILine;

    aLine.Thickness:=NLine.Thickness;
    aLine.Style:=NLine.Style;
   (aLineE as ISpatialElement).Color:=(NLine as ISpatialElement).Color;

    aLine.C0:=C0;
    aLine.C1:=NLine.C1;
    NLine.C1:=C0;

    NLineE:=NLine as IDMElement;
    for j:=0 to NLineE.Parents.Count-1 do begin
      aParentE:=NLineE.Parents.Item[j];
      if aLineE.Parents.IndexOf(aParentE)=-1 then
       aLineE.AddParent(aParentE);
    end; // for n

//    (C0 as IDMElement).Draw(Painter, 0);

    result:=aLine;
end; //function LineSeparate

procedure  TCustomSMDocument.UpdateCollection(Direct: WordBool; var C0: ICoordNode;
                             var Collection: IDMCollection);
     {выравнивание (ID~коорд.)узлa C0, и узлов задан.в коллекции линий;
    Direct=True -в коллекц линий по знач.узлa C0,
    Direct=False-узла C0 по знач.узлов в коллекц}
var
     aLineE:IDMElement;
     aLine:ILine;
     aC0,aC1:ICoordNode;
     j:integer;
     Flag:boolean;
begin
          for j:=0 to Collection.Count-1 do begin
           aLineE:= Collection.Item[j];
           aLine:= aLineE as ILine;
           aC0:=aLine.C0;
           aC1:=aLine.C1;
           Flag:=True;
           if (aC0.X=C0.X)and(aC0.Y=C0.Y)and(aC0<>C0)then
             if Direct then begin
               aC0:=nil;
               aC0:=C0;
             end else begin
               C0:=nil;
               C0:=aC0
             end
           else
           if (aC1.X=C0.X)and(aC1.Y=C0.Y)and(aC1<>C0)then
             if Direct then begin
               aC1:=nil;
               aC1:=C0;
             end else begin
               C0:=nil;
               C0:=aC1;
             end
           else
             Flag:=False;

           if Direct then
             if Flag then begin
               aLine.C0:=nil;
               aLine.C1:=nil;
               aLine.C0:=aC0;
               aLine.C1:=aC1;
               (Collection as IDMCollection2).Delete(j);
               (Collection as IDMCollection2).Insert(j,aLineE);
             end;
          end; //for j
end; //function UpDateCollection

procedure TCustomSMDocument.MoveBorderInVolume(const VArea:IArea;OldVolume,
              NewVolume:IVolume;Direction:integer);
var
  j,k,i:integer;
  aLineE,aAreaE:IDMElement;
  aLine:ILine;
  VArea1:IArea;

  procedure DoMoveBorder;
  begin
    if (VArea1.Volume0=OldVolume) then begin
      VArea1.Volume0IsOuter:=False;
      VArea1.Volume0:=NewVolume
    end else
    if (VArea1.Volume1=OldVolume) then begin
      VArea1.Volume1IsOuter:=False;
      VArea1.Volume1:=NewVolume;
    end;

    if VArea1.Volume0<>nil then
     UpdateElement( VArea1.Volume0 as IDMElement);
    if VArea1.Volume1<>nil then
     UpdateElement( VArea1.Volume1 as IDMElement);

    UpdateElement( OldVolume as IDMElement);
    UpdateElement( NewVolume as IDMElement);
  end;

begin
   if (VArea.Volume0=NewVolume) or
      (VArea.Volume1=NewVolume) then
     Exit;

   if (VArea.Volume0=OldVolume) then begin
     VArea.Volume0IsOuter:=False;
     VArea.Volume0:=NewVolume
   end else
   if (VArea.Volume1=OldVolume) then begin
     VArea.Volume1IsOuter:=False;
     VArea.Volume1:=NewVolume;
   end;

   if VArea.Volume0<>nil then
     UpdateElement( VArea.Volume0 as IDMElement);
   if VArea.Volume1<>nil then
     UpdateElement( VArea.Volume1 as IDMElement);

   UpdateElement( NewVolume as IDMElement);

   case Direction of
   bdDown:
     for j:=0 to VArea.BottomLines.Count-1 do begin
       aLineE:=VArea.BottomLines.Item[j];
       aLine:=aLineE as ILine;
       VArea1:=aLine.GetVerticalArea(Direction);
       if VArea1<>nil then begin
         k:=0;
         while k<VArea1.BottomLines.Count do begin
           aLineE:=VArea1.BottomLines.Item[k];
           i:=0;
           while i<aLineE.Parents.Count do begin
             aAreaE:=aLineE.Parents.Item[i];
             if (OldVolume.BottomAreas.IndexOf(aAreaE)<>-1) or
                (NewVolume.BottomAreas.IndexOf(aAreaE)<>-1) then
               break
             else
               inc(i);
           end;
           if i<aLineE.Parents.Count then
             Break
           else
             inc(k);
         end;
         if k<VArea1.BottomLines.Count then
           DoMoveBorder
         else
           MoveBorderInVolume(VArea1, OldVolume, NewVolume, Direction);
       end; // if VArea1<>nil
     end; // for j:=0 to VArea.BottomLines.Count-1
   bdUp:
     for j:=0 to VArea.TopLines.Count-1 do begin
       aLineE:=VArea.TopLines.Item[j];
       aLine:=aLineE as ILine;
       VArea1:=aLine.GetVerticalArea(Direction);
       if VArea1<>nil then begin
         k:=0;
         while k<VArea1.TopLines.Count do begin
           aLineE:=VArea1.TopLines.Item[k];
           i:=0;
           while i<aLineE.Parents.Count do begin
             aAreaE:=aLineE.Parents.Item[i];
             if (OldVolume.TopAreas.IndexOf(aAreaE)<>-1) or
                (NewVolume.TopAreas.IndexOf(aAreaE)<>-1) then
               break
             else
               inc(i);
           end;
           if i<aLineE.Parents.Count then
             Break
           else
             inc(k);
         end;
         if k<VArea1.BottomLines.Count then
           DoMoveBorder
         else
           MoveBorderInVolume(VArea1, OldVolume, NewVolume, Direction);
       end; // if VArea1<>nil
     end; // for j:=0 to VArea.BottomLines.Count-1
   end;// case  
end; //function


function  TCustomSMDocument.MoveAreaInVolume(const OldArea:IArea;const Area:IArea;const OldVolume:IVolume;
                               Direction:Integer; var NewVolume: IVolume): WordBool;
var
    VArea:IArea;
    aLineE:IDMElement;
    AreaE:IDMElement;
    aCollection:IDMCollection;
    i:integer;
begin
      result:=True;
      if not((Area.Volume0=NewVolume)
            or(Area.Volume1=NewVolume)) then
       if Area.Volume0=OldVolume then begin
         Area.Volume0IsOuter:=False;
         Area.Volume0:=NewVolume;
       end else
       if Area.Volume1=OldVolume then begin
         Area.Volume1IsOuter:=False;
         Area.Volume1:=NewVolume;
       end;

       AreaE:=Area as IDMElement;
       aCollection:=(Area as IPolyLine).Lines;
       for i:=0 to aCollection.Count-1 do begin
        aLineE:=aCollection.Item[i];
        VArea:=(aLineE as ILine).GetVerticalArea(Direction);
        if VArea<>nil then begin
         MoveBorderInVolume(VArea,OldVolume,NewVolume,Direction);
        end;  //VArea<>nil
       end;  //for i

      if Area.Volume0<>nil then
       UpdateElement( Area.Volume0 as IDMElement);
      if Area.Volume1<>nil then
       UpdateElement( Area.Volume1 as IDMElement);

      UpdateElement(OldVolume as IDMElement);
      UpdateElement(NewVolume as IDMElement);
end; //function MoveAreaInVolume

function  TCustomSMDocument.BuildSubAreas(const BaseArea: IArea; const OldVolume: IVolume;
              const NewVolume: IVolume; const AreasCollection: IDMCollection;
              const BaseLinesCollection: IDMCollection;
              const BordersCollection: IDMCollection; Direction: Integer): WordBool;
  {Проц. рекурентная.
   AreasCollection обраб.Area. Если Area Bottom,-Direction=bdUp Top: -bdDown
   BaseLinesCollection - -лин. Area
   BordersCollection   -лин.нa границe объема
   Result=True -обраб.прилегающие обл.                          }
var
   j,i,m,k:integer;
   OldVolumeE,NewVolumeE,aLineE,aAreaE:IDMElement;
   aBaseLineE:IDMElement;
   BaseAreaE:IDMElement;
   aArea,VArea:IArea;
   HAreaP:IPolyLine;
   aLinesCollection:IDMCollection;
   aAreasCollection:IDMCollection;
   DataModel:IDataModel;
begin
    Result:=False;

    OldVolumeE:=OldVolume as IDMElement;
    NewVolumeE:=NewVolume as IDMElement;

    DataModel:=Get_DataModel as IDataModel;
    aAreasCollection :=DataModel.CreateCollection(-1, nil);
    BaseAreaE:=BaseArea as IDMElement;
    for j:=0 to AreasCollection.Count-1 do begin
     aAreaE:=AreasCollection.Item[j];
     if (not(aAreaE=BaseAreaE))then
      (aAreasCollection as IDMCollection2).Add(aAreaE); {не BaseArea }
    end; // for

    while BaseLinesCollection.Count>0 do begin
     aBaseLineE:=BaseLinesCollection.Item[0];
    (BaseLinesCollection as IDMCollection2).Remove(aBaseLineE);
     if (BordersCollection.IndexOf(aBaseLineE)=-1) then begin {лин.не граница объема   }
      aArea:=nil;
      i:=0;
      while i<aAreasCollection.Count do begin
       aAreaE:=aAreasCollection.Item[i];
       if(aBaseLineE.Parents.IndexOf(aAreaE)<>-1)then begin {aBaseLineE общ. aAreaE-BaseArea}
         aArea:=aAreaE as IArea;                         {- значит aArea в NewVolume }
         HAreaP:=aArea as IPolyLine;
         aLinesCollection :=DataModel.CreateCollection(-1, nil);
         for k:=0 to HAreaP.Lines.Count-1 do begin
          aLineE:=HAreaP.Lines.Item[k];
          if (BordersCollection.IndexOf(aLineE)=-1)
             and(aLineE<>aBaseLineE) then  {лин.не граница объема @  не общ. BaseArea}
           (aLinesCollection as IDMCollection2).Add(aLineE);
         end; //k

         if Direction=bdUp then begin
           aArea.Volume0IsOuter:=BaseArea.Volume0IsOuter;
           aArea.Volume0:=BaseArea.Volume0;
         end else begin
           aArea.Volume1IsOuter:=BaseArea.Volume1IsOuter;
           aArea.Volume1:=BaseArea.Volume1;
         end;  

         UpdateElement(aArea as IDMElement);
         UpdateCoords(aArea as IDMElement);
         if Direction=bdUp then
          for  m:=0  to aLinesCollection.Count-1 do begin
           aLineE:=aLinesCollection.Item[m];
           VArea:=(aLineE as ILine).GetVerticalArea(Direction);
           if VArea<>nil then
           MoveBorderInVolume(VArea,OldVolume,NewVolume,Direction);
          end; //for m
         BuildSubAreas(aArea,OldVolume,NewVolume,aAreasCollection,
                        aLinesCollection,BordersCollection,Direction);
         Result:=True;
       end;  //общ.линия
       inc(i);
      end;  // while i
     end;  //не BaseArea
    end;  // while j
    UpdateElement(OldVolume as IDMElement);
    UpdateElement(NewVolume as IDMElement);

end; //function BuildSubBotAreas


function  TCustomSMDocument.CheckAreaCustomizability(const OldArea: IArea;
                       const NewArea: IArea;const OldTopArea: IArea;
                       const NewTopArea: IArea;const Volume:IVolume): WordBool;
     {проверить находится ли aNewTopAreaE над aNewArea (result=True),
     если нет -NewTop и Top нужно поменять местами     (result=False)   }
var
  OldAreaE,NewAreaE,OldTopAreaE,NewTopAreaE:IDMElement;
  VArea:IArea;
  aLineE:IDMElement;
  HV,H0,Height:double;
  j,i:integer;
begin

      HV:=Volume.MaxZ-Volume.MinZ;

      OldAreaE:=OldArea as IDMElement;
      NewAreaE:=NewArea as IDMElement;
      OldTopAreaE:=OldTopArea as IDMElement;
      NewTopAreaE:=NewTopArea as IDMElement;
      Result:=True;
      for j:=0 to OldArea.BottomLines.Count-1 do begin
       aLineE:=OldArea.BottomLines.Item[j];
       if not((aLineE.Parents.IndexOf(OldAreaE)<>-1)
            and(aLineE.Parents.IndexOf(NewAreaE)<>-1)) then begin
         VArea:=(aLineE as ILine).GetVerticalArea(bdUp);
         if VArea<>nil then begin
          //---------
          H0:=0;
          Repeat
           VArea:=(aLineE as ILine).GetVerticalArea(bdUp);
           if VArea<>nil then begin
            Height:=VArea.MaxZ-VArea.MinZ;
            H0:=H0+Height;
            aLineE:=VArea.TopLines.Item[0];
           end else
            Break; //  !!!!!!!!!!!!!!!!!!!!!!!
          Until abs(HV)<=abs(H0);
          //-----------
          Result:=False;
          for i:=0 to VArea.TopLines.Count-1 do begin
           aLineE:=VArea.TopLines.Item[i];
           if (aLineE.Parents.IndexOf(OldTopAreaE)<>-1)
             and(aLineE.Parents.IndexOf(NewTopAreaE)=-1) then begin
            Result:=True;
            break;
           end;
          end; 
          if Result then
           break;
         end;
        end;
       end;
end; //function CheckAreaCustomizability

function TCustomSMDocument.Build_NewVolume(const AreaOld:IArea;const AreaNew:IArea;
                     out Volume:IVolume;out NewVolume:IVolume):WordBool;
      {создание объема для AreaNew}
var
  SpatialModel: ISpatialModel;
  SpatialModel2: ISpatialModel2;
  VolumeE, NewVolumeE:IDMElement;
  aRefElement, RefParent:IDMElement;
  VolumeU:IUnknown;
  BuildDirection:integer;
begin
  SpatialModel:=Get_DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;
  BuildDirection:=SpatialModel2.BuildDirection;


  result:=False;
  if AreaOld<>nil then begin
    case BuildDirection of
    bdUp  :if AreaOld.Volume0<>nil then
              Volume:=AreaOld.Volume0
           else
              Volume:=AreaOld.Volume1;
    bdDown:if AreaOld.Volume1<>nil then
              Volume:=AreaOld.Volume1
           else
              Volume:=AreaOld.Volume0;
    end;

    VolumeE:=Volume as IDMElement;

    AddElement((AreaOld as IDMElement).Parent,
                        SpatialModel2.Volumes, '', ltOneToMany, VolumeU, True);
    NewVolumeE:=VolumeU as IDMElement;
    NewVolume:=NewVolumeE as IVolume;
    aRefElement:=CreateClone(VolumeE.Ref) as IDMElement;
    NewVolumeE.Ref:=aRefElement;

    RefParent:=VolumeE.Ref.Parent;


    ChangeParent( nil, RefParent, aRefElement);

    result:=True;
  end;
end;

function  TCustomSMDocument.PolyLine_BuildVerticalArea(const PolyLineCollection: IDMCollection;
                                  OperationCode: Integer; BuildDirection: Integer;
                                  var AreaRef:IDMElement): IVolume;
var
  aLineE,aTopLineE,aBottomLineE:IDMElement;
  aAreaE,aOldAreaE,aNewAreaE,VAreaE:IDMElement;
  RefParent:IDMElement;
  BaseRefElement:IDMElement;
  aOldVolume,aNewVolume,ControlVolume:IVolume;
  aOldVolume0, aOldVolume1:IVolume;
  aVolume0, aVolume1:IVolume;
  aLine,aTopLine,aBottomLine:ILine;
  aArea,aOldArea, aNewArea, VArea:IArea;
  aBaseOldAreaE, aBaseNewAreaE:IDMElement;
  aBaseOldArea, aBaseNewArea:IArea;
  aTopArea, aNewTopArea:IArea;
  aTopAreaE,aNewTopAreaE:IDMElement;

  aCurrentLineE:IDMElement;
  aCurrentLine:ILine;
  aCurrentLines:IDMCollection;

  aCurrentTopLineE:IDMElement;
  aCurrentTopLine:ILine;
  aCurrentTopLines:IDMCollection;

  aCollection:IDMCollection;
  aCurrentCollection:IDMCollection;

  aBottomLines:IDMCollection;
  aTopLines:IDMCollection;
  aTopAreas:IDMCollection;
  aBottomAreas:IDMCollection;
  aVAreas:IDMCollection;

  C0, C1:ICoordNode;
  C2, C3:ICoordNode;
  aC0, aC1:ICoordNode;
  WX,WY,WZ,OldWX,OldWY,OldWZ:double;

  j,k,i,m, Index0, Index1, Index2, n, aLinesCount, aCount:integer;
  aCurrent:integer;
  SpatialModel:ISpatialModel;
  BuildVolumeFlag:boolean;
  Flag,Flag1, Flag2:boolean;
  SpatialModel2: ISpatialModel2;
  aDocument:IDMDocument;
  BLinesCol:IDMCollection;

  aOldVolumeE:IDMElement;
  aLines:IDMCollection;
  OldState :integer;
   Algorithm:integer;
   aOldTopLine:ILine;
   aLine1:ILine;
   aLine1E:IDMElement;
   NLine:ILine;
   NLineE:IDMElement;
   aParent1:IArea;
   aParent2:IArea;
   X,Y,X1,Y1,X2,Y2:double;
   NLineS:ISpatialElement;
   LineU:IUnknown;
   aAreaP:IPolyLine;
   Stat:integer;
   aPrevOldTopArea:IArea;
   aPrevNewTopArea:IArea;
   DataModel:IDataModel;
   NewVolumes:IDMCollection;
   
 procedure UpdateNodes(var C0,C1:ICoordNode;const Collection:IDMCollection);
 var
     aCollection:IDMCollection;
     j:integer;
 begin
          for j:=0 to Collection.Count-1 do begin
           aCollection:=(Collection.Item[j] as IPolyline).Lines;
           UpdateCollection(False,C0,aCollection);
           UpdateCollection(False,C1,aCollection);
          end;
 end; //function

 procedure LineCrossingProcessor(VArea,OldArea,NewArea,PrevArea:IArea;
                                 OldVolume:IVolume;
                                 aControlLines:IDMCollection);
 var
  aLines:IDMCollection;
  aBaseLines:IDMCollection;
  aBaseAreas:IDMCollection;
  aCollection:IDMCollection;
  aLineE,aLine2E:IDMElement;
  aLine,aLine1,aLine2,aLine3:ILine;
  aPrevArea:IArea;
  aAreaP:IPolyLine;
  WX,WY,WZ:double;
  k,j,Stat:integer;
  aDirection:integer;
 begin
        aPrevArea:=OldArea;
        aDirection:=BuildDirection;
        case aDirection of
           bdUp  :begin
                   aBaseLines:=VArea.TopLines;
                   aBaseAreas:=OldVolume.TopAreas;
                  end;
           bdDown:begin
                   aBaseLines:=VArea.BottomLines;
                   aBaseAreas:=OldVolume.BottomAreas;
                  end;
         end; //case

        aLines:=DataModel.CreateCollection(-1, nil);
        for k:=0 to aBaseLines.Count-1 do begin
         aLineE:=aBaseLines.Item[k];
         aLine:=aLineE as ILine;
        (aLines as IDMCollection2).Add(aLineE);
        (aControlLines as IDMCollection2).Add(aLineE);
        end;

        while aLines.Count>0 do begin
         aLineE:=aLines.Item[0];
         aLine:=aLineE as ILine;
         (aLines as IDMCollection2).Delete(0);
         aArea:=AreaWithInternalNode(aLine.C0,aLine.C1,nil, 0, True);
         if aArea=nil then begin
//_______________
           Flag:=False;
           for k:=0  to aBaseAreas.Count-1 do begin
            aArea:=aBaseAreas.Item[k] as IArea;
            if NodeIsInternalCheck(aArea,
                      aLine.C0.X,aLine.C0.Y,0, Stat) then begin {C0 внутри aArea?}
             Flag:=True;
             break;
            end;
           end;
           if not Flag then
            aArea:=PrevArea;
          end;
//______________________
          if aArea<>nil then begin
             PrevArea:=aArea;
             aAreaP:=aArea as IPolyLine;
             X1:=aLine.C0.X;
             Y1:=aLine.C0.Y;
             X2:=aLine.C1.X;
             Y2:=aLine.C1.Y;
             aCollection:=DataModel.CreateCollection(-1, nil);
             for j:=0 to aAreaP.Lines.Count-1 do
             (aCollection as IDMCollection2).Add(aAreaP.Lines.Item[j]);

             while aCollection.Count>0 do begin
              aLine1:=aCollection.Item[0] as ILine;
             (aCollection as IDMCollection2).Delete(0);
              if Crossing_Node(X1,Y1,X2,Y2,aLine1.C0.X,aLine1.C0.Y,
                          aLine1.C1.X,aLine1.C1.Y, WX,WY)then begin//пересекаются?
               if (WX=X1) and (WY=Y1) then
                 Continue;
               if (WX=X2) and (WY=Y2) then
                 Continue;
               if (WX=aLine1.C0.X) and (WY=aLine1.C0.Y) then
                 Continue;
               if (WX=aLine1.C1.X) and (WY=aLine1.C1.Y) then
                 Continue;

               case aDirection of
                 bdUp  :WZ:=aOldVolume.MaxZ;
                 bdDown:WZ:=aOldVolume.MinZ;
               else
                 WZ:=0;
               end; //case
               //пересек. в WX,WY,WZ
               aLine2:=LineSeparate(WX,WY,WZ,True,aLine,aC0);  //разделить aLine
               aLine2E:=aLine2 as IDMElement;
              (aLines as IDMCollection2).Add(aLine2E);
               k:=aControlLines.IndexOf(aLine2E);
              (aControlLines as IDMCollection2).Insert(k+1,aLine2E);
               aLine3:=LineSeparate(WX,WY,WZ,False,aLine1,aC0);    //разделить aLine1
               UpdateElement(aArea as IDMElement);
               break;
              end; //if Crossing_Node
             end;  //while
          end; //if aArea<>nil
          UpdateElement( VAreaE);
          UpdateCoords( VAreaE);
          UpdateElement( OldArea as IDMElement);
          UpdateElement( NewArea as IDMElement);

        end; //while

  end; //function

var
  ClassID:integer;
  aOppositeLines:IDMCollection;
  aCurrentOppositeLines:IDMCollection;
  aOppositeArea,aPrevArea:IArea;
  aOppositeAreaE:IDMElement;
  aNewOppositeArea:IArea;
  aOppositeLineE,aNewOppositeAreaE:IDMElement;
  aAreaRef,aRefVArea,aNewVolumeE:IDMElement;
  AreaRefRef:IDMElement;
  aName:WideString;
  Line:ILine;
  LineColList:TList;
  aRefArea, Element:IDMElement;
  l, j1, m1:integer;
  View:IView;
  X0, Y0, Z0, Z1:double;
  GlobalData:IGlobalData;
  NodeList, LineList, OuterLineList, UpdateList:TList;
  OldAreas, NewAreas:IDMCollection;
  ErrorCount:integer;
  CheckErrorsFlag:boolean;
begin

  result:=nil;
  DataModel:=Get_DataModel as IDataModel;
  SpatialModel2:=DataModel as ISpatialModel2;
  try
  aNewVolume:=nil;
  aLinesCount:=PolyLineCollection.Count;
  aCurrentLines:=DataModel.CreateCollection(-1, nil);
  for j:=0 to aLinesCount-1 do
      (aCurrentLines as IDMCollection2).Add(IDMElement(PolyLineCollection.Item[j]));
  FindEndedNodes(aCurrentLines,C2,C3,C0); {определить конечн.точки полилин.}
        {C2,C3 замыкают объем ?}
  j:=0;
  while j<C2.Lines.Count do begin
    aLineE:=C2.Lines.Item[j];
    Line:=aLineE as ILine;
    if Line.GetVerticalArea(BuildDirection)<>nil then
      break
    else
      inc(j)
  end;
  if j=C2.Lines.Count then Exit;

  j:=0;
  while j<C3.Lines.Count do begin
    aLineE:=C3.Lines.Item[j];
    Line:=aLineE as ILine;
    if Line.GetVerticalArea(BuildDirection)<>nil then
      break
    else
      inc(j)
  end;
  if j=C3.Lines.Count then Exit;

//--------------------------------------------------------------------------
    {если замыкают -готовимся создать нов. стенку с нов.объемом }
  aTopAreas:=DataModel.CreateCollection(-1, nil);      //TopAreas
  aBottomAreas:=DataModel.CreateCollection(-1, nil);   //BottomAreas

  aLineE:=PolyLineCollection.Item[0];
  if aLineE.Parents.Count>0 then begin
    aBaseOldAreaE:=nil;
    aBaseOldArea:=nil;
    j1:=0;
    while j1<aLineE.Parents.Count do begin
      aBaseOldAreaE:=aLineE.Parents.Item[j1];
      if (aBaseOldAreaE.QueryInterface(IArea, aBaseOldArea)=0) and
         (not aBaseOldArea.IsVertical) then
        Break
      else
        inc(j1);
    end;

    aOldVolume:=nil;
    if j1<aLineE.Parents.Count then begin
      case BuildDirection of                                     //OldVolume
      bdUp  :begin
             if aBaseOldArea.Volume0<>nil then
                aOldVolume:=aBaseOldArea.Volume0
             else
                aOldVolume:=aBaseOldArea.Volume1;

             aCollection:=aOldVolume.TopAreas;
           end;
      bdDown:begin
           if aBaseOldArea.Volume1<>nil then
                aOldVolume:=aBaseOldArea.Volume1
           else
                aOldVolume:=aBaseOldArea.Volume0;

           aCollection:=aOldVolume.BottomAreas;
          end;
      end;   //case
    end else  begin //if aBaseOldAreaE=nil
      result:=nil;
      Exit;
    end;

    aOldVolumeE:=aOldVolume as IDMElement;

    CheckErrorsFlag:=False;
    ErrorCount:=0;

    {создать нов.объем }
    if AreaRef=nil then begin
      ClassID:=_Area;
      if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then begin
        GlobalData.GlobalValue[1]:=0;
        GlobalData.GlobalValue[2]:=0;
        GlobalData.GlobalIntf[1]:=aOldVolumeE;
      end;


      DataModel.CheckErrors;
      ErrorCount:=DataModel.Errors.Count;
      if ErrorCount>0 then begin
        Get_Server.CallDialog(sdmConfirmation, '',
        'Модель объекта содержит ошибки, которые могут превести к тому, что данная операция '+
        'будет выполнена некорректно.'+#13+
        'Продолжить выполнение операции?');
        if Get_Server.EventData1=0 then Exit;
      end;
      CheckErrorsFlag:=True;

      CreateRefElement(ClassID,OperationCode,nil,AreaRef, RefParent, True);//RefElement VArea
      if AreaRef=nil then begin
        result:=nil;
        Exit;
      end;

    end else
      AreaRef:=CreateClone(AreaRef) as IDMElement;

    SetDocumentOperation(AreaRef, nil,leoAdd, -1);

    if aNewVolume=nil then
      Build_NewVolume(aBaseOldArea,
                    aBaseNewArea,aOldVolume,aNewVolume);      //NewVolume

    aNewVolumeE:= aNewVolume as IDMElement;
    RefParent:=aNewVolumeE.Ref.Parent;

    for k:=0  to aOldVolume.BottomAreas.Count-1 do begin
      aAreaE:=aOldVolume.BottomAreas.Item[k];
      if aBottomAreas.IndexOf(aAreaE)=-1 then
      (aBottomAreas as IDMCollection2).Add(aAreaE);     //BottomAreas -> Collection
    end;

    for k:=0  to aOldVolume.TopAreas.Count-1 do begin
      aAreaE:=aOldVolume.TopAreas.Item[k];
      if aTopAreas.IndexOf(aAreaE)=-1 then
      (aTopAreas as IDMCollection2).Add(aAreaE);       //TopAreas -> Collection
    end;
  end else begin // if aLineE.Parents.Count=0
    result:=nil;
    Exit;
  end;
   {создаем нов.стенки, TopLine(BottomLine), если нужно делим Area}
  Index0:=0;
  Index1:=0;
  aVAreas:=DataModel.CreateCollection(-1, nil);
  aTopLines:=DataModel.CreateCollection(-1, nil);
  aLines:=DataModel.CreateCollection(-1, nil);
  aBottomLines:=DataModel.CreateCollection(-1, nil);
  aOppositeLines:=DataModel.CreateCollection(-1, nil);
  aCurrentOppositeLines:=DataModel.CreateCollection(-1, nil);
  OldAreas:=DataModel.CreateCollection(-1, nil);
  NewAreas:=DataModel.CreateCollection(-1, nil);

  LineList:=TList.Create;
  OuterLineList:=TList.Create;
  for k:=0 to aCollection.Count-1 do begin
    aAreaP:=aCollection.Item[k] as IPolyline;
    for  m1:=0 to aAreaP.Lines.Count-1 do begin
      aLineE:=aAreaP.Lines.Item[m1];
      i:=LineList.IndexOf(pointer(aLineE));
      if i=-1 then
        LineList.Add(pointer(aLineE));
      i:=OuterLineList.IndexOf(pointer(aLineE));
      if i=-1 then
        OuterLineList.Add(pointer(aLineE))
      else
        OuterLineList.Delete(i)
    end;
  end;
  for m1:=0 to OuterLineList.Count-1 do begin
    aLineE:=IDMElement(OuterLineList[m1]);
    i:=LineList.IndexOf(pointer(aLineE));
    if i<>-1 then
      LineList.Delete(i);
  end;
  OuterLineList.Free;
  NodeList:=TList.Create;
  for m1:=0 to LineList.Count-1 do begin
    aLineE:=IDMElement(LineList[m1]);
    aLine:=aLineE as ILine;
    C0:=aLine.C0;
    if NodeList.IndexOf(pointer(C0))=-1 then
      NodeList.Add(pointer(C0));
    C1:=aLine.C1;
    if NodeList.IndexOf(pointer(C1))=-1 then
      NodeList.Add(pointer(C1));
  end;

  UpdateList:=TList.Create;
  while  Index1 < aLinesCount do begin
    (aCurrentLines as IDMCollection2).Clear;
    for j:=Index0 to Index1 do
      (aCurrentLines as IDMCollection2).Add(IDMElement(PolyLineCollection.Item[j]));
//______________________

      for aCurrent:=0 to aCurrentLines.Count-1 do begin

       aCurrentLineE:=IDMElement(aCurrentLines.Item[aCurrent]);
       aCurrentLine:=aCurrentLineE as ILine;
       case BuildDirection of
        bdUp  :if aBottomLines.IndexOf(aCurrentLineE)=-1 then
                (aBottomLines as IDMCollection2).Add(aCurrentLineE);
        bdDown:if aTopLines.IndexOf(aCurrentLineE)=-1 then
                (aTopLines as IDMCollection2).Add(aCurrentLineE);
       end; //case

       aOldAreaE:=aCurrentLineE.Parents.Item[0];
       aOldArea:=aOldAreaE as IArea;
       aNewAreaE :=aCurrentLineE.Parents.Item[1];
       aNewArea:=aNewAreaE as IArea;

       BuildVolumeFlag:=False;

       if aCurrentLine.GetVerticalArea(BuildDirection)=nil then
         VAreaE:=BuildVerticalArea(aCurrentLine,BuildDirection,
                                   BuildVolumeFlag, NodeList, LineList, UpdateList);
       if (VAreaE<>nil) then  begin
        VArea:=VAreaE as IArea;
        if Index1 >0 then
         AreaRef:=CreateClone(AreaRef) as IDMElement;
         VAreaE.Ref:=AreaRef;

//        ChangeParent( nil, RefParent, AreaRef);
//        Get_Server.SelectionChanged(VAreaE);

        VArea.IsVertical:=True;
        //----------
        if aVAreas.IndexOf(VAreaE)=-1 then
         (aVAreas as IDMCollection2).Add(VAreaE);

        LineCrossingProcessor(VArea,aOldArea,aNewArea,aPrevArea,
                                    aOldVolume,aOppositeLines);
        case BuildDirection of
          bdUp  :for k:=0 to aOppositeLines.Count-1 do begin
                   aOppositeLineE:=aOppositeLines.Item[k];
                   if aTopLines.IndexOf(aOppositeLineE)=-1 then begin
                    (aTopLines as IDMCollection2).Add(aOppositeLineE);
                    (NewAreas as IDMCollection2).Add(aNewArea as IDMElement);
                    (OldAreas as IDMCollection2).Add(aOldArea as IDMElement);
                   end;
                 end;
          bdDown:for k:=0 to aOppositeLines.Count-1 do begin
                   aOppositeLineE:=aOppositeLines.Item[k];
                   if aBottomLines.IndexOf(aOppositeLineE)=-1 then begin
                    (aBottomLines as IDMCollection2).Add(aOppositeLineE);
                    (NewAreas as IDMCollection2).Add(aNewArea as IDMElement);
                    (OldAreas as IDMCollection2).Add(aOldArea as IDMElement);
                   end;
                 end;
        end; //case
       end;  //if (VArea<>nil)
     end; //for aCurrent

     Index0:=Index1+1;

    inc(Index1);
  end;   //while
  NodeList.Free;
  LineList.Free;
  for k:=0 to UpdateList.Count-1 do begin
    Element:=IDMElement(UpdateList[k]);
    UpdateElement(Element);
  end;
  UpdateList.Free;


//_____________
   {для aOppositeLines (противоположн.тем, что строили) определяем их Parent,s  }
  aLinesCount:=aOppositeLines.Count;
  ReorderLinesWithMessage(aOppositeLines,True);
  Index0:=0;
  Index1:=0;
  while  Index1<aLinesCount do begin
   (aCurrentOppositeLines as IDMCollection2).Clear;
   for j:=Index0 to Index1 do begin
      (aCurrentOppositeLines as IDMCollection2).Add(IDMElement(aOppositeLines.Item[j]));
   end;
   if (aOppositeLines.Item[Index0].Parents.Count<2)
     and(aOppositeLines.Item[Index1].Parents.Count<2)then begin
   if FindEndedNodes(aCurrentOppositeLines,C2,C3,C0)then begin
    case BuildDirection of
       bdUp  :UpdateNodes(C2,C3,aTopAreas);
       bdDown:UpdateNodes(C2,C3,aBottomAreas);
    end; //case
    UpDateCollection(True,C2,aCurrentOppositeLines);
    UpDateCollection(True,C3,aCurrentOppositeLines);
    aArea:=AreaWithInternalNode(C2, C3, C0, 0, True);
    if (aArea<>nil)and(not aArea.IsVertical) then begin
     aOppositeArea:=aArea;
     aOppositeAreaE:=aOppositeArea as IDMElement;
     UpdateElement(aOppositeAreaE);
     aArea:=LineDivideArea(C2,C3, aOppositeArea);
     if (aArea<>nil) then begin
      aNewOppositeArea:=aArea;
      aNewOppositeAreaE:=aNewOppositeArea as IDMElement;
      Lines_AddParent(aCurrentOppositeLines,aOppositeArea);  {опред. владельцев для aCurrentLines  }
      Lines_AddParent(aCurrentOppositeLines,aNewOppositeArea);
      case BuildDirection of
       bdUp  :begin
               if aTopAreas.IndexOf(aOppositeAreaE)=-1 then
                (aTopAreas as IDMCollection2).Add(aOppositeAreaE);
               if aTopAreas.IndexOf(aNewOppositeAreaE)=-1 then
                (aTopAreas as IDMCollection2).Add(aNewOppositeAreaE);
              end;
       bdDown:begin
               if aBottomAreas.IndexOf(aOppositeAreaE)=-1 then
                (aBottomAreas as IDMCollection2).Add(aOppositeAreaE);
               if aBottomAreas.IndexOf(aNewOppositeAreaE)=-1 then
                (aBottomAreas as IDMCollection2).Add(aNewOppositeAreaE);
               end;
      end; //case

       for j:=0 to aCurrentOppositeLines.Count-1 do begin
        aLineE:=aCurrentOppositeLines.Item[j];
        case BuildDirection of
         bdUp  :VArea:=(aLineE as ILine).GetVerticalArea(bdDown);
         bdDown:VArea:=(aLineE as ILine).GetVerticalArea(bdUp);
        end; //case
        if VArea<>nil then begin
         VAreaE:=VArea as IDMElement;
         if aLineE.Parents.IndexOf(VAreaE)=-1 then
          aLineE.AddParent(VAreaE);
        end;
       end;
      Index0:=Index1+1;
      end;
     end;    // (aArea<>nil)and(not aArea.IsVertical)
    end;
   end;
   inc(Index1);
  end;   //while

  case BuildDirection of
   bdUp  :aCollection :=aBottomLines;
   bdDown:aCollection :=aTopLines;
  end; //case

  for j:=0  to aCollection.Count-1 do begin
    aLine:=aCollection.Item[j] as ILine;
    VArea:=aLine.GetVerticalArea(BuildDirection);
    if VArea<>nil then begin
      VArea.Volume0IsOuter:=False;
      VArea.Volume0:=aNewVolume;
      VArea.Volume1IsOuter:=False;
      VArea.Volume1:=aOldVolume;
    end;
  end;

//  переопределить объемы для Area внизу
  for j:=0 to aBottomLines.Count-1 do begin

    aLineE:= aBottomLines.Item[j];
    aLine:=aLineE as ILine;

    aParent1:=nil;
    aParent2:=nil;
    for k:=0 to aLineE.Parents.Count-1 do begin
     aArea:=aLineE.Parents.Item[k] as IArea;
     if not aArea.IsVertical then begin
      if aParent1=nil then
         aParent1:=aArea
      else
         aParent2:=aArea;
     end;
    end; //k

    k:=0;
    if (aParent1<>nil)and(aParent2<>nil)then begin
     if aOldVolume.BottomAreas.IndexOf(aParent1 as IDMElement)<>-1 then
      inc(k);
     if aOldVolume.BottomAreas.IndexOf(aParent2 as IDMElement)<>-1 then
      inc(k,10);
     case k of
        1:begin                  {aParent1  в OldVolume; aParent2  в NewVolume }
           aOldArea  :=aParent1;
           aNewArea  :=aParent2;
           Flag:=False;
          end;
       10:begin                  {aParent1  в NewVolume; aParent2  в OldVolume }
           aOldArea  :=aParent2;
           aNewArea  :=aParent1;
           Flag:=False;
          end;
       11:begin                   {aParent1  в OldVolume; aParent2  в OldVolume }
           aOldArea  :=aParent1;
           aNewArea  :=aParent2;
           MoveAreaInVolume(aOldArea,aNewArea,aOldVolume,bdUp,aNewVolume);
          end;
     end; //case

     if aNewArea<>nil then begin
      aOldAreaE :=aOldArea as IDMElement;
      aNewAreaE :=aNewArea as IDMElement;
      UpdateElement( aOldAreaE);
      UpdateElement( aNewAreaE);
     end;

     aCollection :=DataModel.CreateCollection(-1, nil);
     aAreaP:=aNewArea as IPolyLine;
     for k:=0 to aAreaP.Lines.Count-1 do
      (aCollection as IDMCollection2).Add(aAreaP.Lines.Item[k]);
                   {включить смежные Areas}
     BuildSubAreas(aNewArea,aOldVolume,aNewVolume,aOldVolume.BottomAreas,
                         aCollection,aBottomLines,bdUp);
    end;
  end;

           { переопределить объемы для Area вверху   }
  for j:=0 to aTopLines.Count-1 do begin
   aTopLineE:=aTopLines.Item[j];

   aParent1:=nil;
   aParent2:=nil;
   for k:=0 to aTopLineE.Parents.Count-1 do begin
    aArea:=aTopLineE.Parents.Item[k] as IArea;
    if not aArea.IsVertical then begin
     if aParent1=nil then
        aParent1:=aArea
     else
        aParent2:=aArea;
    end;
   end; //k

   if (aParent1<>nil)and(aParent2<>nil)then begin
    k:=0;
    if aOldVolume.TopAreas.IndexOf(aParent1 as IDMElement)<>-1 then
     inc(k);
    if aOldVolume.TopAreas.IndexOf(aParent2 as IDMElement)<>-1 then
     inc(k,10);
    case k of
       1:begin                   {aParent1  в OldVolume; aParent2  в NewVolume }
          aTopArea  :=aParent1;
          aNewTopArea  :=aParent2;
         end;
      10:begin                    {aParent1  в NewVolume; aParent2  в OldVolume }
          aTopArea  :=aParent2;
          aNewTopArea  :=aParent1;
         end;
      11:begin                    {aParent1  в OldVolume; aParent2  в OldVolume }
          aTopArea  :=aParent1;
          aNewTopArea  :=aParent2;
          
          aOldArea:=OldAreas.Item[j] as IArea;
          aNewArea:=NewAreas.Item[j] as IArea;

          if not CheckAreaCustomizability(aOldArea,aNewArea,
                                       aParent1,aParent2,aOldVolume)then begin
           aTopArea:=aParent2;  {если Top и Bottom не соответственны - поменять местами}
           aNewTopArea:=aParent1;
          end;
          MoveAreaInVolume(aTopArea,aNewTopArea,aOldVolume,bdUp,aNewVolume);
         end;
    end; //case

    if aNewTopArea<>nil then begin
     aTopAreaE:=aTopArea as IDMElement;
     aNewTopAreaE:=aNewTopArea as IDMElement;

     UpdateElement( aTopAreaE);
     UpdateElement( aNewTopAreaE);

     aCollection :=DataModel.CreateCollection(-1, nil);
     aAreaP:=aNewTopArea as IPolyLine;
     for k:=0 to aAreaP.Lines.Count-1 do
       (aCollection as IDMCollection2).Add(aAreaP.Lines.Item[k]);
              {включить смежные Areas}
     BuildSubAreas(aNewTopArea,aOldVolume,aNewVolume,aTopAreas,
                               aCollection,aTopLines,bdDown);
    end;
   end else
   { ShowMessage('    Проверьте построение.');  }

  end; //j


  j:=0;
  while j<aNewVolume.TopAreas.Count do begin
    aArea:=aNewVolume.TopAreas.Item[j] as IArea;
    aArea.GetCentralPoint(X0, Y0, Z0);
    m:=0;
    while m<aNewVolume.BottomAreas.Count do begin
      aOppositeArea:=aNewVolume.BottomAreas.Item[m] as IArea;
      if aOppositeArea.ProjectionContainsPoint(X0, Y0, 0) then
        Break
      else
        inc(m)
    end;
    if m<aNewVolume.BottomAreas.Count then
      inc(j)
    else
      aArea.Volume1:=aOldVolume;
  end;

  j:=0;
  while j<aOldVolume.TopAreas.Count do begin
    aArea:=aOldVolume.TopAreas.Item[j] as IArea;
    aArea.GetCentralPoint(X0, Y0, Z0);
    m:=0;
    while m<aOldVolume.BottomAreas.Count do begin
      aOppositeArea:=aOldVolume.BottomAreas.Item[m] as IArea;
      if aOppositeArea.ProjectionContainsPoint(X0, Y0, 0) then
        Break
      else
        inc(m)
    end;
    if m<aOldVolume.BottomAreas.Count then
      inc(j)
    else
      aArea.Volume1:=aNewVolume;
  end;


  UpdateElement(aOldVolume as IDMElement);
  UpdateElement(aNewVolume as IDMElement);
    //-----------------------

  if SpatialModel2.BuildWallsOnAllLevels then begin
    LineColList:=TList.Create;
    if PolyLine_IsClosedVolume(aOppositeLines,LineColList)then begin

      for j:=0 to LineColList.Count-1 do begin
        aCurrentCollection:=IDMCollection(LineColList[j]);
        l:=0;
        while l<aCurrentCollection.Count do begin
          aLine:=aCurrentCollection.Item[l] as ILine;
          if aLine.GetVerticalArea(BuildDirection)<>nil then
            break
          else
            inc(l)
        end; //for l
        if (l=aCurrentCollection.Count) and
           (l<>0) then begin
          Line:=aCurrentCollection.Item[0] as ILine;
          C0:=Line.C0;
          C1:=Line.C1;
          X0:=C0.X;
          Y0:=C0.Y;
          Z0:=C0.Z;
          X1:=C1.X;
          Y1:=C1.Y;
          Z1:=C1.Z;
          View:=FPainter.View;
          if View.PointIsVisible(X0, Y0, Z0, 1) and
             View.PointIsVisible(X1, Y1, Z1, 1) then begin
            inc(FBuildingLevel);
            AreaRef:=CreateClone(AreaRef) as IDMElement;
            PolyLine_BuildVerticalArea(aCurrentCollection,
                                   OperationCode, BuildDirection,
                                   AreaRef);
            dec(FBuildingLevel);
          end;
        end;
        aCurrentCollection._Release;
      end; // for j:=0 to Lines.Count-1
    end; // if PolyLine_IsClosedVolume(
  end; // if SpatialModel2.BuildWallsOnAllLevels

  if FBuildingLevel=0 then begin
    SpatialModel2.UpdateVolumes;
    Get_Server.RefreshDocument(rfFrontBack);
  end;

  (aLines as IDMCollection2).Clear;
  (aOppositeLines as IDMCollection2).Clear;

  except
    raise
  end;
  result:=aNewVolume;

  if result<>nil then begin
    NewVolumes:=DataModel.CreateCollection(-1, nil);
    (NewVolumes as IDMCollection2).Add(aNewVolumeE);
    SpatialModel2.CheckVolumeContent(NewVolumes, aOldVolume, 0);
  end;


  if CheckErrorsFlag then begin
    DataModel.CheckErrors;
    if DataModel.Errors.Count-ErrorCount>0 then begin
      Get_Server.CallDialog(sdmShowMessage, '',
      'Операция выполнена с ошибками. Рекомендуется проверить корректность модели');
    end;
  end;
end; //function PolyLine_BuildVerticalArea

procedure TCustomSMDocument.VArea_SetParents(const VArea:IArea;const Lines,
                                   OppositLines:IDMCollection;const Volume:IVolume);
   {для OppositeLines (противоположн.Lines) определяем Parent,s  }
var
   aLineE,aOppositLineE,VAreaE:IDMElement;
   aOldAreaE,aNewAreaE:IDMElement;
   aArea,aOldArea,aNewArea,aParent1,aParent2:IArea;
   aOppositAreaE,aNewOppositAreaE:IDMElement;
   aOppositArea,aNewOppositArea:IArea;
   j,n,k:integer;
begin
   VAreaE:=VArea as IDMElement;
   for j:=0 to Lines.Count-1 do begin
    aLineE:=Lines.Item[j];
    aOldArea:=nil;
    aNewArea:=nil;
    for k:=0 to aLineE.Parents.Count-1 do begin
      aArea:=aLineE.Parents.Item[k] as IArea;
      if not aArea.IsVertical then
       if aOldArea=nil then
          aOldArea:=aArea
       else
          aNewArea:=aArea;
    end; //k

    aOldAreaE :=aOldArea as IDMElement;
    aNewAreaE :=aNewArea as IDMElement;

    for n:=0 to OppositLines.Count-1 do begin
     aOppositLineE:=OppositLines.Item[n];
     aOppositArea:=nil;
     aNewOppositArea:=nil;
     for k:=0 to aOppositLineE.Parents.Count-1 do begin
      aArea:=aOppositLineE.Parents.Item[k] as IArea;
      if not aArea.IsVertical then
       if aParent1=nil then
          aParent1:=aArea
       else
          aParent2:=aArea;
     end; //k
     //____________________
     if (aParent1<>nil)and(aParent2<>nil)then begin
      if CheckAreaCustomizability(aOldArea,aNewArea,aParent1,aParent2,Volume)then begin
       aOppositArea:=aParent1;
       aNewOppositArea:=aParent2;
      end else begin
       aOppositArea:=aParent2;
       aNewOppositArea:=aParent1;
      end;
      aOppositAreaE:=aOppositArea as IDMElement;
      aNewOppositAreaE:=aNewOppositArea as IDMElement;
      //____________________
      aLineE.RemoveParent(aOldAreaE);
      aLineE.RemoveParent(aNewAreaE);
      aLineE.RemoveParent(VAreaE);
      aLineE.AddParent(aOldAreaE);
      aLineE.AddParent(aNewAreaE);
      aLineE.AddParent(VAreaE);
      aOppositLineE.RemoveParent(aOppositAreaE);
      aOppositLineE.RemoveParent(aNewOppositAreaE);
      aOppositLineE.RemoveParent(VAreaE);
      aOppositLineE.AddParent(aOppositAreaE);
      aOppositLineE.AddParent(aNewOppositAreaE);
      aOppositLineE.AddParent(VAreaE);
     end;
    end;//n
   end;//j
end; //function VAreaSetParents


function  TCustomSMDocument.PolyLine_IsClosedVolume(const LinesCol: IDMCollection;
                                  const LineColList: TList): WordBool;
  {LinesCol разбивается на отрезки LineColList, внутри отдельных объемов
     result=True -если все отрезки могут coздать замкнутые объемы
          или не все, но сделан выбор: Продолжить  -иначе result=False
     если линия никому не принадлежит, то также result=False}
var
  Index0,Index1,aLinesCount,n,j,k:integer;
  Flag1,Flag2:boolean;
  aCurrentLines:IDMCollection;
  aLineE:IDMElement;
  aArea:IArea;
  C0,C2,C3,aC2,aC3:ICoordNode;
  DataModel:IDataModel;
  SpatialModel2:ISpatialModel2;
  BuildDirection:integer;
  procedure _FindEndedNodes(const Collection:IDMCollection;J,K:integer;
                                  out C2,C3:ICoordNode);
  var
   i:integer;
   aLines:IDMCollection;
  begin
    aLines:=DataModel.CreateCollection(-1, nil);
    for i:=J to K do begin
    (aLines as IDMCollection2).Add(IDMElement(Collection.Item[i]));
    end;
    FindEndedNodes(aLines,C2,C3,C0);

  end; //procedure

begin
  result:=True;
  DataModel:=Get_DataModel as IDataModel;
  SpatialModel2:=Get_DataModel as ISpatialModel2;
  BuildDirection:=SpatialModel2.Get_BuildDirection;
  Index0:=0;
  Index1:=0;
  n:=0;
  Flag1:=True;
  Flag2:=True;
  aLinesCount:=LinesCol.Count;
  while  Index1 < aLinesCount do begin
   aCurrentLines:=DataModel.CreateCollection(-1, nil);
   for j:=Index0 to Index1 do begin
      aLineE:=IDMElement(LinesCol.Item[j]);
      if aLineE.Parents.Count<2 then begin
//        aLineE.Selected:=True;
//        ShowMessage('Линии не имеют владельца или не закреплены.'#10#13''
//                             +'        Проверьте построение');
        result:=False;
        Exit;
      end;
      (aCurrentLines as IDMCollection2).Add(IDMElement(LinesCol.Item[j]));
   end;
   if aCurrentLines.Count>0 then begin
    FindEndedNodes(aCurrentLines,C2,C3,C0);
    if n=0 then
     _FindEndedNodes(LinesCol,Index0,aLinesCount-1,aC2,aC3);
    if C2<>aC2 then begin
      C3:=C2;
      C2:=aC2;
    end;

    if n<10 then begin
     for j:=0 to C2.Lines.Count-1 do begin
      aLineE:=C2.Lines.Item[j];
      for k:=0 to aLineE.Parents.Count-1 do begin
       aArea:=(aLineE.Parents.Item[k] as IArea);
       case BuildDirection of
         bdUp  :if(aArea.IsVertical)
                  and(aArea.BottomLines.IndexOf(aLineE)<>-1 )then begin
                 inc(n,10);
                 break;
                end;
         bdDown:if(aArea.IsVertical)
                  and(aArea.TopLines.IndexOf(aLineE)<>-1 )then begin
                 inc(n,10);
                 break;
                end;
       end; //case
      end;
      if not(n<10) then
       break;
     end;
    end;
    for j:=0 to C3.Lines.Count-1 do begin
     aLineE:=C3.Lines.Item[j];
     for k:=0 to aLineE.Parents.Count-1 do begin
      aArea:=(aLineE.Parents.Item[k] as IArea);
      case BuildDirection of
         bdUp  :if(aArea.IsVertical)
                  and(aArea.BottomLines.IndexOf(aLineE)<>-1 )then begin
                 inc(n,1);
                 break;
                end;
         bdDown:if(aArea.IsVertical)
                  and(aArea.TopLines.IndexOf(aLineE)<>-1 )then begin
                 inc(n,1);
                 break;
                end;
      end; //case
     end;
     if (n>0)and(n<>10) then
       break;
     end;
    end;
    case n of
     0:begin
        Flag1:=False;
        Flag2:=False;
        inc(Index1);
       end;
    10:begin
        Flag2:=False;
        inc(Index1);
       end;
     1:begin
         LineColList.Add(pointer(aCurrentLines));
         aCurrentLines._AddRef;
         inc(Index1);
         Index0:=Index1;
         Flag1:=False;
         n:=0;
       end;
    11:begin
         LineColList.Add(pointer(aCurrentLines));
         aCurrentLines._AddRef;
         inc(Index1);
         Index0:=Index1;
         Flag2:=True;
         n:=0;
       end;
    end; //case
  end;   //while
  if Index0<>aLinesCount then begin
    LineColList.Add(pointer(aCurrentLines));
    aCurrentLines._AddRef;
  end;

  if not(Flag1 and Flag2) then begin
//    if not SpatialModel2.BuildWallsOnAllLevels then
//      ShowMessage('Линии не образуют замкнутого объема. ');
    result:=False;
  end;

 end; //function PolyLine_IsClosedVolume

function  TCustomSMDocument.ReorderGroupLines(const Lines: IDMCollection;
                                              const FirstLines: IDMCollection): WordBool;
 var
  k,LinesCount:integer;
  aLineE:IDMElement;
  LinesTMP:IDMCollection;
  TMPLines:IDMCollection;
  DataModel:IDataModel;
 begin
  Result:=True;
  LinesCount:=Lines.Count;
  if LinesCount<2 then Exit;

  DataModel:=Get_DataModel as IDataModel;
  TMPLines:=DataModel.CreateCollection(-1, nil);
  LinesTMP:=DataModel.CreateCollection(-1, nil);
  for k:=0 to LinesCount-1 do
   (TMPLines as IDMCollection2).Add(IDMElement(Lines.Item[k]));


  while TMPLines.Count>0 do begin
   ReorderLines(Lines);

   aLineE:=Lines.Item[0];
   if FirstLines<>nil then
    if FirstLines.IndexOf(IDMElement(aLineE))=-1 then
     (FirstLines as IDMCollection2).Add(IDMElement(aLineE));

   while Lines.Count>0 do begin
    aLineE:=Lines.Item[0];
    k:=TMPLines.IndexOf(IDMElement(aLineE));
    if k<>-1 then
     (TmpLines as IDMCollection2).Delete(k);
    if LinesTMP.IndexOf(IDMElement(aLineE))=-1 then
     (LinesTMP as IDMCollection2).Add(IDMElement(aLineE));
    (Lines as IDMCollection2).Delete(0);
   end;

   for k:=0 to TmpLines.Count-1 do begin
    (Lines as IDMCollection2).Add(IDMElement(TMPLines.Item[k]));
   end;
  end;

  while Lines.Count>0 do
   (Lines as IDMCollection2).Delete(0);

  for k:=0 to LinesTMP.Count-1 do
   (Lines as IDMCollection2).Add(IDMElement(LinesTMP.Item[k]));
end;


function TCustomSMDocument.ReorderLinesWithMessage(var Lines:IDMCollection;
                                               Stat:WordBool):WordBool;
  {Stat=True выдавать сообщение в случае неуспеха, иначе -False
   Result=True в случае успеха, иначе -False}
var
  j, m:integer;
  Line:ILine;
  LineE, aParent:IDMElement;
  Polyline:IPolyline;
  TMPList:TList;
  C0, C1:ICoordNode;
  Lines2:IDMCollection2;
  PrevCount:integer;
begin
  Result:=True;

  if Lines.Count<2 then Exit;
  Lines2:=Lines as IDMCollection2;
  TMPList:=TList.Create;
  LineE:=Lines.Item[0];
  Line:=LineE as ILine;
  C0:=Line.C0;
  C1:=Line.C1;
  Lines2.Delete(0);
  TMPList.Add(pointer(LineE));
  while Lines.Count>0 do begin
    j:=0;
    while j<Lines.Count do begin
      LineE:=Lines.Item[j];
      Line:=LineE as ILine;
      if C0=Line.C0 then begin
        C0:=Line.C1;
        TMPList.Insert(0, pointer(LineE));
        Break
      end else
      if C1=Line.C0 then begin
        C1:=Line.C1;
        TMPList.Add(pointer(LineE));
        Break
      end else
      if C0=Line.C1 then begin
        C0:=Line.C0;
        TMPList.Insert(0, pointer(LineE));
        Break
      end else
      if C1=Line.C1 then begin
        C1:=Line.C0;
        TMPList.Add(pointer(LineE));
        Break
      end else
        inc(j);
    end;
    if j<Lines.Count then
      Lines2.Delete(j)
    else begin
      while Lines.Count>0 do begin
        LineE:=Lines.Item[0];
        PrevCount:=Lines.Count;
        m:=0;
        while m<LineE.Parents.Count do begin
          aParent:=LineE.Parents.Item[0];
          if aParent.QueryInterface(IPolyline, Polyline)=0 then begin
            if Polyline.Lines.IndexOf(LineE)<>-1 then
              LineE.RemoveParent(aParent)
            else
              inc(m)
          end else
            inc(m)
        end;
        if PrevCount=Lines.Count then
          (Lines as IDMCollection2).Delete(0);
      end;

      Result:=False;
      if Stat then
         ShowMessage('  Выделенные линии не образуют'
                      +' последователной '#10#13'неразрывной цепочки.');
    end
  end;

  for j:=0 to TMPList.Count-1 do
    Lines2.Add(IDMElement(TMPList[j]));

  TMPList.Free
end;
                                                                                                                                                                                    
procedure TCustomSMDocument.PasteToElement(const SourceElementU: IUnknown;
                            const DestElementU: IUnknown;
                            CopySpatialElementFlag, LowerLevelPaste:WordBool);
var
  DestElement:IDMElement;
begin
  try
  inherited;
  DestElement:=DestElementU as IDMElement;
  if FPainter<>nil then
    DestElement.Draw(FPainter, 1);
  except
    raise
  end;  
end;

procedure TCustomSMDocument.ClearPrevSelection(ClearAll:WordBool);
begin
  if FUndoSelectionFlag then Exit;
  inherited;
  ClearPrevSelectedAreas;
end;

procedure TCustomSMDocument.ClearPrevSelectedAreas;
var
  j:integer;
  AreaE:IDMElement;
  AreaP:IPolyline;
  OldState:integer;
begin
  if FUndoSelectionFlag then Exit;
  OldState:=FState;
  FState:=FState or dmfCommiting;
  try
    for j:=0 to FPrevSelectedAreaList.Count-1 do begin
      AreaE:=IDMElement(FPrevSelectedAreaList[j]);
      if AreaE.Ref=nil then begin
        AreaP:=AreaE as IPolyline;
        while AreaP.Lines.Count>0 do
          (AreaP.Lines as IDMCollection2).Delete(0);
        AreaE.Clear;
      end;
    end;
    FPrevSelectedAreaList.Clear;
  finally
    FState:=OldState;
  end;
end;

procedure TCustomSMDocument.ClearSelectedAreas;
var
  aAreaE:IDMElement;
  j:integer;
begin
  ClearPrevSelectedAreas;

  for j:=0 to FSelectedAreaList.Count-1 do begin
    aAreaE:=IDMElement(FSelectedAreaList[j]);
    FPrevSelectedAreaList.Add(pointer(aAreaE));
  end;

  FSelectedAreaList.Clear;
end;

procedure TCustomSMDocument.UndoSelection;
var
  Area:IArea;
  aAreaE:IDMElement;
  j:integer;
  SpatialModel2:ISpatialModel2;
  BuildDirection, OldSelectState:integer;
begin
  OldSelectState:=FState and dmfSelecting;
  FState:=FState or dmfSelecting;
  FUndoSelectionFlag:=True;
  try
  SpatialModel2:=Get_DataModel as ISpatialModel2;
  BuildDirection:=SpatialModel2.BuildDirection;

  if Get_SelectionCount>0 then begin
    if FSelectedAreaList.Count=0 then
      ClearSelection(nil)           // выделена не Area
    else begin
      Area:=IDMElement(FSelectedAreaList[0]) as IArea;
      if Area.IsVertical then
        ClearSelection(nil)
      else begin
        if (Area.Volume0<>nil) and
           (BuildDirection=bdUp) then
          ClearSelection(nil)      // выделена Area над которой уже построен Volume
        else
        if (Area.Volume1<>nil) and
           (BuildDirection=bdDown) then
          ClearSelection(nil)
      end;
    end;
  end;

  for j:=0 to FPrevSelectedAreaList.Count-1 do begin
    aAreaE:=IDMElement(FPrevSelectedAreaList[j]);
    FSelectedAreaList.Add(pointer(aAreaE));
  end;
  FPrevSelectedAreaList.Clear;

  finally
    FState:=FState and not dmfSelecting or OldSelectState;
    FUndoSelectionFlag:=False;
  end;

  DoUndoSelection;
end;

procedure TCustomSMDocument.BuildConnectingLineList(const C0, C1:ICoordNode;
                                                    const Parent:IDMElement;
                                                    const ConnectingLineList:TList;
                                                    UpdateFlag:boolean);
var
  k:integer;
  aC0, aC1, aC:ICoordNode;
  X0, Y0, X1, Y1, X, Y:double;
  aLineE:IDMElement;
  aLine:ILine;
  LineU:IUnknown;
  DataModel:IDataModel;
  SpatialModel:ISpatialModel;
  HLinesCol:IDMCollection;
begin
  ConnectingLineList.Clear;
  DataModel:=Get_DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  aC0:=C0;
  aC1:=C1;

  X0:=C0.X;
  Y0:=C0.Y;
  X1:=C1.X;
  Y1:=C1.Y;

  while True do begin
    k:=0;
    while k<aC1.Lines.Count do begin
      aLineE:=aC1.Lines.Item[k];
      aLine:=aLineE as ILine;
      if aC0=aLine.NextNodeTo(aC1) then
        Break
      else
        inc(k);
    end;
    if k=aC1.Lines.Count then begin
      aLineE:=nil;
      X:=0;
      Y:=0;
      k:=0;
      while k<aC1.Lines.Count do begin
        aLineE:=aC1.Lines.Item[k];
        aLine:=aLineE as ILine;
        if aLine.C0=aC1 then
          aC:=aLine.C1
        else
          aC:=aLine.C0;
        X:=aC.X;
        Y:=aC.Y;

        if abs(((X0-X)*(X1-X)+(Y0-Y)*(Y1-Y))/
                   sqrt(sqr(X0-X)+sqr(Y0-Y))/
                   sqrt(sqr(X1-X)+sqr(Y1-Y))+1)<0.01 then
          Break
        else
          inc(k);
      end;
      if k<aC1.Lines.Count then begin
        ConnectingLineList.Add(pointer(aLineE));
        aC1:=aC;
        X1:=X;
        Y1:=Y;
      end else
        Break      // нет сонаправленных линий
    end else begin // if k=aC1.Lines.Count
      ConnectingLineList.Add(pointer(aLineE));
      Exit;  // нашли замыкающую линию
    end;
  end; // while True

  while True do begin
    aLineE:=nil;
    X:=0;
    Y:=0;
    k:=0;
    while k<aC0.Lines.Count do begin
      aLineE:=aC0.Lines.Item[k];
      aLine:=aLineE as ILine;
      if aLine.C0=aC0 then
        aC:=aLine.C1
      else
        aC:=aLine.C0;
      X:=aC.X;
      Y:=aC.Y;

      if abs(((X0-X)*(X1-X)+(Y0-Y)*(Y1-Y))/sqrt(sqr(X0-X)+sqr(Y0-Y))/sqrt(sqr(X1-X)+sqr(Y1-Y))+1)<0.01 then
        Break
      else
        inc(k);
    end;
    if k<aC0.Lines.Count then begin
      ConnectingLineList.Add(pointer(aLineE));
      aC0:=aC;
      X0:=X;
      Y0:=Y;
    end else
      Break      // нет сонаправленных линий
  end; // while True
  AddElement(Parent,
            SpatialModel.Lines, '', ltOneToMany, LineU, True);
  aLineE:=LineU as IDMElement;
  aLine:=aLineE as ILine;
  aLine.C0:=aC0;
  aLine.C1:=aC1;
  HLinesCol:=DataModel.CreateCollection(-1, nil);
  (HLinesCol as IDMCollection2).Add(aLineE);
  IntersectHLine (HLinesCol);
  for k:=0 to HLinesCol.Count-1 do begin
    aLineE:=HLinesCol.Item[k];
    if UpdateFlag then
      UpdateAreas(aLineE);
    ConnectingLineList.Add(pointer(aLineE))
  end;

end;

procedure TCustomSMDocument.DivideVolume(const Volume: IVolume; Height: Double; ShiftState:
                         Integer; N, BuildDirection, Direction: Integer; CopyBottomArea:WordBool; const RefElement: IDMElement;
                         const RefParent: IDMElement; out NewVolumes: IDMCollection);
var
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;

 NewVolumes2:IDMCollection2;

 VolumeE,aAreaE,NewAreaE,aLineE,NewVolumeE:IDMElement;
 aRefElement,aRefParent:IDMElement;
 NewNodeE,NewVLineE,aNewBLineE:IDMElement;
 NewVolume:IVolume;
 AreaU,VolumeU,LineU,NodeU:IUnknown;
 NewArea,VArea:IArea;
 aAreaP,NewAreaP:IPolyLine;
 BLine,VLine,NewVLine,aNewBLine,aLine,aLine0:ILine;
 C0,C1,aC0,aC1,aNode0,aNode1,NewNode,aNewNode0,aNewNode1:ICoordNode;
 LineList:TList;
 m,L,k,i:integer;
 aHeight:double;
 Flag:boolean;
 TmpCollection:IDMCollection;
 ConnectingLineList:TList;

 procedure ReorderLinesList(var Lines:TList);
 var
  j:integer;
  LineE:IDMElement;
  Line:ILine;
  TMPList:TList;
  C0, C1:ICoordNode;
  OldCount:integer;
 begin
  if Lines.Count<2 then Exit;
  TMPList:=TList.Create;
  LineE:=IDMElement(pointer(Lines[0]));
  Line:=LineE as ILine;
  C0:=Line.C0;
  C1:=Line.C1;
  TMPList.Add(pointer(LineE));
  Lines.Delete(0);

  while Lines.Count>0 do begin
    j:=0;
    OldCount:=Lines.Count;
    while j<Lines.Count do begin
      LineE:=IDMElement(pointer(Lines[j]));
      Line:=LineE as ILine;
      if C0=Line.C0 then begin
        C0:=Line.C1;
        TMPList.Insert(0, pointer(LineE));
        Lines.Delete(j);
        Break
      end else
      if C1=Line.C0 then begin
        C1:=Line.C1;
        TMPList.Add(pointer(LineE));
        Lines.Delete(j);
        Break
      end else
      if C0=Line.C1 then begin
        C0:=Line.C0;
        TMPList.Insert(0, pointer(LineE));
        Lines.Delete(j);
        Break
      end else
      if C1=Line.C1 then begin
        C1:=Line.C0;
        TMPList.Add(pointer(LineE));
        Lines.Delete(j);
        Break
      end else
        inc(j);
    end;
    if (Lines.Count=OldCount) and
       (OldCount<>0) then Break;
  end;

  for j:=0 to TMPList.Count-1 do
    Lines.Add(TMPList[j]);

  TMPList.Free
 end;

var
  VLine1,Vline2, BLineNext, BLinePrev:ILine;
  VLineE, BLineE:iDMElement;
  Length:double;
  SkipFlag0:boolean;
  LastNode, FirstNode:ICoordNode;
  DataModel:IDataModel;
begin
  DataModel:=Get_DataModel as IDataModel;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=SpatialModel as ISpatialModel2;

  NewVolumes:=DataModel.CreateCollection(-1, nil);
  NewVolumes2:=NewVolumes as IDMCollection2;
  LineList:=TList.Create;
  ConnectingLineList:=TList.Create;

  aHeight:=Height;
  VolumeE:=Volume as IDMElement;
  if RefElement=nil then begin
   aRefParent:=VolumeE.Ref.Parent;
   ChangeParent( nil, nil, VolumeE.Ref);
  end else begin
   aRefParent:=RefParent;
   ChangeParent( nil, nil, RefElement);
  end;
  if ((ShiftState and sAlt)<>0) then
   aHeight:=(Volume.MaxZ-Volume.MinZ)/N;
  LineList.Clear;
  for m:=0 to Volume.BAreas[Direction].Count-1 do begin
    aAreaE:=Volume.BAreas[Direction].Item[m];
    aAreaP:=aAreaE as IPolyline;
    for k:=0 to aAreaP.Lines.Count-1 do begin
      aLineE:=aAreaP.Lines.Item[k];
      i:=LineList.IndexOf(pointer(aLineE));
      if i=-1 then
        LineList.Add(pointer(aLineE))
      else
        LineList.Delete(i);
    end;
  end;
  ReorderLinesList(LineList);

  NewVolumes2.Clear;
  for L:=0 to N-2 do begin

    AddElement( VolumeE.Parent,
                        SpatialModel2.Volumes, '', ltOneToMany, VolumeU, True);
    NewVolumeE:=VolumeU as IDMElement;
    NewVolume:=NewVolumeE as IVolume;

    if RefElement=nil then
      aRefElement:=CreateClone(VolumeE.Ref) as IDMElement
    else begin
      if L=0 then
        aRefElement:=RefElement
      else
        aRefElement:=CreateClone(aRefElement) as IDMElement;
    end;

    NewVolumeE.Ref:=aRefElement;

    NewVolumes2.Add(NewVolumeE);

    if (VolumeE.Ref.Ref.Parent.ID=0) and
        CopyBottomArea then begin
      if Volume.BAreas[Direction].Count>0 then
        aAreaE:=Volume.BAreas[Direction].Item[0]
      else
        aAreaE:=Volume.TAreas[Direction].Item[0];
    end else begin
      if Volume.TAreas[Direction].Count>0 then
        aAreaE:=Volume.TAreas[Direction].Item[0]
      else
        aAreaE:=Volume.BAreas[Direction].Item[0]
    end;

    AddElement(aAreaE.Parent,
               SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
    NewAreaE:=AreaU as IDMElement;
    NewArea:=NewAreaE as IArea;
    NewArea.Flags:=NewArea.Flags or afEmpty;
    NewAreaE.Ref:=CreateClone(aAreaE.Ref) as IDMElement;
    ChangeParent( nil, aAreaE.Ref.Parent, NewAreaE.Ref);

    aLineE:=nil;
    SkipFlag0:=False;
    LastNode:=nil;
    FirstNode:=nil;
    for m:=0 to LineList.Count-1 do begin
      BLineE:=IDMElement(LineList[m]);
      BLine:=BLineE as ILine;

      C0:=BLine.C0;
      C1:=BLine.C1;
      if m=0 then begin
        BLineNext:=IDMElement(LineList[m+1]) as ILine;
        if (C0=BLineNext.C0) or
           (C0=BLineNext.C1) then begin
          C0:=BLine.C1;
          C1:=BLine.C0;
        end;
      end else begin
        BLinePrev:=IDMElement(LineList[m-1]) as ILine;
        if (C1=BLinePrev.C0) or
           (C1=BLinePrev.C1) then begin
          C0:=BLine.C1;
          C1:=BLine.C0;
        end;
      end;

      VLine:=C0.GetVerticalLine(Direction);
      if VLine<>nil then begin    // VLine.C0
        Length:=VLine.Length;
        VLine1:=VLine;
        if Length<aHeight then begin
          repeat
            VLine2:=VLine1.CC1[Direction].GetVerticalLine(Direction);
            if VLine2=VLine1 then
              VLine2:=VLine1.CC0[Direction].GetVerticalLine(Direction);
            Length:=Length + VLine2.Length;
            VLine1:=VLine2;
          until (VLine2=nil)or(not(Length<aHeight)) ;
          VLine:=VLine2;
        end;
      end else
        Length:=0;

      if VLine<>nil then begin
        if Length<>aHeight then begin
          VLineE:=VLine as IDMElement;
          AddElement(VLineE.Parent,
                      SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
          NewNodeE:=NodeU as IDMElement;
          NewNode:=NewNodeE as ICoordNode;
          NewNode.X:=C0.X;
          NewNode.Y:=C0.Y;
          if Direction=0 then
            NewNode.Z:=C0.Z+aHeight
          else
            NewNode.Z:=C0.Z-aHeight;

          AddElement(VLineE.Parent,
                      SpatialModel.Lines, '', ltOneToMany, LineU, True);
          NewVLineE:=LineU as IDMElement;
          NewVLine:=NewVLineE as ILine;
          NewVLine.CC1[Direction]:=VLine.CC1[Direction];
          NewVLine.CC0[Direction]:=NewNode;

          VLine.CC1[Direction]:=NewNode;

          UpdateAreas(NewNodeE);
        end;

        aC0:=VLine.CC1[Direction];
        if FirstNode=nil then
          FirstNode:=aC0;

        LastNode:=aC0;

      end else begin  // if VLine=nil
        if m=0 then
          SkipFlag0:=True;
        aC0:=nil;
      end;

      VLine:=C1.GetVerticalLine(Direction);
      if VLine<>nil then begin
        Length:=VLine.Length;
        VLine1:=VLine;
        if Length<aHeight then begin
          repeat
            VLine2:=VLine1.CC1[Direction].GetVerticalLine(Direction);
            if VLine2=VLine1 then
              VLine2:=VLine1.CC0[Direction].GetVerticalLine(Direction);
            Length:=Length + VLine2.Length;
            VLine1:=VLine2;
          until (VLine2=nil)or(not(Length<aHeight)) ;

          VLine:=VLine2;
        end;
      end else
        Length:=0;

      if VLine<>nil then begin
        if Length<>aHeight then begin
          VLineE:=VLine as IDMElement;
          AddElement(VLineE.Parent,
                       SpatialModel.CoordNodes, '', ltOneToMany, NodeU, True);
          NewNodeE:=NodeU as IDMElement;
          NewNode:=NewNodeE as ICoordNode;
          NewNode.X:=C1.X;
          NewNode.Y:=C1.Y;
          if Direction=0 then
            NewNode.Z:=C1.Z+aHeight
          else
            NewNode.Z:=C1.Z-aHeight;

          AddElement(VLineE.Parent,
                        SpatialModel.Lines, '', ltOneToMany, LineU, True);
          NewVLineE:=LineU as IDMElement;
          NewVLine:=NewVLineE as ILine;
          NewVLine.CC1[Direction]:=VLine.CC1[Direction];
          NewVLine.CC0[Direction]:=NewNode;

          VLine.CC1[Direction]:=NewNode;

          UpdateAreas(NewNodeE);
        end;

        aC1:=VLine.CC1[Direction];
        if FirstNode=nil then
          FirstNode:=aC1;

        if LastNode<>nil then begin
          BuildConnectingLineList(LastNode, aC1, BLineE.Parent,
                                  ConnectingLineList, True);
          for k:=0 to ConnectingLineList.Count-1 do begin
            aLineE:=IDMELement(ConnectingLineList[k]);
            aLineE.AddParent(NewAreaE);
          end;
        end;

        LastNode:=aC1;
      end else begin  // if VLine=nil
        aC1:=nil;
      end;
    end;  // for m:=0 to LineList.Count-1

    if SkipFlag0 and
      (FirstNode<>nil) and
      (LastNode<>nil) then begin

       BuildConnectingLineList(LastNode, FirstNode, BLineE.Parent,
                               ConnectingLineList, True);
       for k:=0 to ConnectingLineList.Count-1 do begin
         aLineE:=IDMELement(ConnectingLineList[k]);
         aLineE.AddParent(NewAreaE);
       end;
    end;

    NewArea.Flags:=NewArea.Flags and not afEmpty;

    UpdateElement(  NewAreaE);
    if aLineE<>nil then begin
      aLine:=aLineE as ILine;
      VArea:=aLine.GetVerticalArea(BuildDirection);
      if VArea<>nil then
        MoveAreas(NewVolume, Volume, VArea, NewArea);
    end;

    NewArea.Volume1IsOuter:=False;
    NewArea.Volume0IsOuter:=False;
    if BuildDirection=bdDown then begin
      NewArea.Vol1[Direction]:=NewVolume;
      NewArea.Vol0[Direction]:=Volume;
    end else begin
      NewArea.Vol1[Direction]:=Volume;
      NewArea.Vol0[Direction]:=NewVolume;
    end;

    UpdateElement(NewVolumeE);
    UpdateElement(VolumeE);

    ChangeParent( nil, aRefParent, NewVolumeE.Ref);

    VolumeE.Draw(Painter, 0);

    if L<N-2 then begin
      NewAreaP:=NewArea as IPolyline;
      LineList.Clear;
      for m:=0 to NewAreaP.Lines.Count-1 do begin
        aLineE:=NewAreaP.Lines.Item[m];
        LineList.Add(pointer(aLineE));
      end;
    end;
  end; //for L:=0 to N-2

  SpatialModel2.CheckVolumeContent(NewVolumes, Volume, 1);

  LineList.Free;
  ConnectingLineList.Free;
end;

procedure TCustomSMDocument.AddZView(MinZ, MaxZ:double);
var
  Views:IDMCollection;
  SpatialModel2:ISpatialModel2;
  View:IView;
  ViewU:IUnknown;
  j:integer;
  S:WideString;
  Flag:boolean;
begin
  SpatialModel2:=Get_DataModel as ISpatialModel2;
  Views:=SpatialModel2.Views;
  j:=0;
  View:=nil;
  Flag:=False;
  while j<Views.Count do begin
    View:=Views.Item[j] as IView;
    if (View.StoredParam=vspZ_ZMin_ZMax) and
       (View.Zmin=MinZ) and
       (View.CurrZ0=MinZ) then
      Break
    else
      inc(j)
  end;

  if j<Views.Count then begin
    if View.Zmax>MaxZ-1 then begin
      ViewU:=View;
      ChangeFieldValue(ViewU, ord(vZmax), True, MaxZ-1);
      Flag:=True;
    end;
  end else begin
    S:=Format('Отметка %0.2f м', [MinZ*0.01]);
    AddElement(nil, Views, S, ltOneToMany, ViewU, True);
    ChangeFieldValue(ViewU, ord(vStoredParam), True, vspZ_ZMin_ZMax);
    ChangeFieldValue(ViewU, ord(vZmin), True, MinZ);
    ChangeFieldValue(ViewU, ord(vZmax), True, MaxZ-1);
    ChangeFieldValue(ViewU, ord(vCurrZ), True, MinZ);

    with FPainter.View do begin
      ChangeFieldValue(ViewU, ord(vCentralPointX), True, CX);
      ChangeFieldValue(ViewU, ord(vCentralPointY), True, CY);
      ChangeFieldValue(ViewU, ord(vCentralPointZ), True, CZ);
      ChangeFieldValue(ViewU, ord(vZangle), True, Zangle);
      ChangeFieldValue(ViewU, ord(vRevScaleX), True, RevScaleX);
      ChangeFieldValue(ViewU, ord(vRevScaleY), True, RevScaleY);
      ChangeFieldValue(ViewU, ord(vRevScaleZ), True, RevScaleZ);
      ChangeFieldValue(ViewU, ord(vCurrX), True, CurrX);
      ChangeFieldValue(ViewU, ord(vCurrY), True, CurrY);
      ChangeFieldValue(ViewU, ord(vDmin), True, Dmin);
      ChangeFieldValue(ViewU, ord(vDmax), True, Dmax);
    end;

    Flag:=True;

    if FNewZView=nil then
      FNewZView:=pointer(ViewU as IDMElement);

  end;
{
  FPainter.View.ZMin:=MinZ;
  FPainter.View.ZMax:=MaxZ-1;
  FPainter.View.CurrZ0:=MinZ;
}
  j:=0;
  View:=nil;
  while j<Views.Count do begin
    View:=Views.Item[j] as IView;
    if (View.StoredParam=vspZ_ZMin_ZMax) and
       (View.Zmin=MaxZ) and
       (View.CurrZ0=MaxZ) then
      Break
    else
      inc(j)
  end;

  if j=Views.Count then begin
    S:=Format('Отметка %0.2f м', [MaxZ*0.01]);
    AddElement(nil, Views, S, ltOneToMany, ViewU, True);
    ChangeFieldValue(ViewU, ord(vStoredParam), True, vspZ_ZMin_ZMax);
    ChangeFieldValue(ViewU, ord(vZmin), True, MaxZ);
    ChangeFieldValue(ViewU, ord(vZmax), True, 2*MaxZ-MinZ-1);
    ChangeFieldValue(ViewU, ord(vCurrZ), True, MaxZ);
    Flag:=True;
  end;

  if Flag then
    SetDocumentOperation(ViewU, Views, leoAdd, -1)
end;

procedure TCustomSMDocument.IntersectSurface;
var
  DataModel:IDataModel;
  
  function CrossingNodeOfLines(const x1,y1,z1, x2,y2,z2,
                                      x3,y3,z3, x4,y4,z4:double;
                                      out x,y,z:double):Boolean ;
  var
  l1,m1,n1,l2,m2,n2:double;
  A1,B1,C1,A2,B2,C2,D:double;
  begin
   result:=False;
   l1:=x2-x1;
   m1:=y2-y1;
   n1:=z2-z1;
   l2:=x4-x3;
   m2:=y4-y3;
   n2:=z4-z3;

   if abs((x3-x1)*(m1*n2-m2*n1)-(y3-y1)*
       (l1*n2-l2*n1)+(z3-z1)*(l1*m2-l2*m1))<1E-3 then begin
     A1:=m1;                          {прям.лежат в 1-й плоск.}
     B1:=-l1;
     C1:=-(A1*x1+B1*y1);
     A2:=m2;
     B2:=-l2;
     C2:=-(A2*x3+B2*y3);
     D:=A1*B2-A2*B1;
     if D<>0 then begin
      x:=(B1*C2-B2*C1)/D;  {прям.не паралл.в плоск.X-Y}
      y:=(A2*C1-A1*C2)/D;
      if n1=0 then
        z:=z1
      else
       if n2=0 then
        z:=z3
       else
        z:=(x-x1)/(-B1)*n1-z1;
     end else begin
      B1:=-n1;
      C1:=-(A1*z1+B1*y1);
      B2:=-n2;
      C2:=-(A2*z3+B2*y3);
      D:=A1*B2-A2*B1;
      if D<>0 then begin
       z:=(B1*C2-B2*C1)/D;   {прям.не паралл.в плоск.Y-Z}
       y:=(A2*C1-A1*C2)/D;
       if l1=0 then
        x:=x1
       else
        if l2=0 then
         x:=x3
        else
         x:=(z-z1)/(-B1)*l1-x1;
      end else begin
       A1:=l1;
       C1:=-(A1*z1+B1*x1);
       A2:=l2;
       C2:=-(A2*z3+B2*x3);
       D:=A1*B2-A2*B1;
       if D<>0 then begin
        z:=(B1*C2-B2*C1)/D;  {прям.не паралл.в плоск.X-Z}
        x:=(A2*C1-A1*C2)/D;
        if m1=0 then
         y:=y1
        else
         if m2=0 then
          y:=y3
         else
          y:=(z-z1)/(-B1)*m1-y1;
       end else
        Exit;    {прям.паралл.}
      end;
     end;
     result:=True;
   end;
  end;  //CrossingNodeOfLines


  function CheckInternalNode(x1,y1,z1,x2,y2,z2,x3,y3,z3:double):integer;
  //(x1,y1,z1),(x2,..).(x3,..) лежат на одной прямой
  //и (x1,y1,z1) внутри (x2,..) - (x3,..) result=0
  //и (x1,y1,z1) в(x1,(x1,(x1,(x1,(x1,(x1,(x1,(x1,,z1) в (x3,..)  result=2
  //и (x1,y1,z1) вне (x2,..) - (x3,..) result=-1

  //или (x1,y1,z1),(x2,..).(x3,..) не лежат на одной прямой ) result=-2
  begin
   result:=-2;  //не на одной прямой

   if abs(x2-x3)>1E-6 then begin
     if ((x2-x1)*(x3-x1)<0)and(abs((x2-x1)*(x3-x1))>1E-6) then
      result:=0              //x1 внутри x2,x3
     else
      if ((x2-x1)*(x3-x1)>0)and(abs((x2-x1)*(x3-x1))>1E-6)  then
       result:=-1              //x1 вне x2,x3
      else
       if abs(x2-x1)<1E-6 then
        result:=1              //x1 в x2
       else
        if abs(x3-x1)<1E-6 then
         result:=2              //x1 в  x3
   end else
     if abs(y2-y3)>1E-6 then begin
      if ((y2-y1)*(y3-y1)<0)and(abs((y2-y1)*(y3-y1))>1E-6)  then
       result:=0              //y1 внутри y2,y3
      else
       if ((y2-y1)*(y3-y1)>0)and(abs((y2-y1)*(y3-y1))>1E-6) then
        result:=-1              //y1 вне y2,y3
       else
        if abs(y2-y1)>1E-6 then
         result:=1              //y1 в y2
        else
         if abs(y3-y1)>1E-6 then
          result:=2              //y1 в  y3
     end else
      if abs(z2-z3)>1E-6 then begin
       if ((z2-z1)*(z3-z1)<0)and(abs((z2-z1)*(z3-z1))>1E-6) then
        result:=0             //z1 внутри z2,z3
       else
        if ((z2-z1)*(z3-z1)>0)and(abs((z2-z1)*(z3-z1))>1E-6) then
         result:=-1              //z1 вне z2,z3
        else
         if abs(z2-z1)>1E-6 then
          result:=1              //z1 в z2
         else
          if abs(z3-z1)>1E-6 then
           result:=2              //z1 в z3
      end;
  end;  //CheckInternalNode

  function CrossingArea(Area1,Area2:IArea;
             out p1x,p1y,p1z,p2x,p2y,p2z:double):boolean ;
   {result=True; - Area1,Area2 пересекаются -> p1x,p1y,p1z - p2x,p2y,p2z
    result=False  - не пересекаются}
  var
   aLine1,aLine2:ILine;
   x1,y1,z1, x2,y2,z2: double;
   A1,B1,C1, A2,B2,C2,D1,D2, T1,T2: double;
   aLines1,aLines2:IDMCollection;

   procedure Formula(const A1,B1,C1,A2,B2,C2:double;out cd1,cd2:double);
   begin
    if B1<>0 then begin
     cd1:=(C1*B2/B1-C2)/(A2-A1*B2/B1);
     cd2:=-(cd1*A1+C1)/B1;
    end else
     if B2<>0 then begin
      cd1:=(C2*B1/B2-C1)/(A1-A2*B1/B2);
      cd2:=-(cd1*A2+C2)/B2;
     end;
   end;  //Formula


  function CheckCrossing(const Area1,Area2:IArea;
                      const A1,B1,C1,D1,A2,B2,C2,D2:double):boolean ;
  {result=True если плоск. A1,B1,C1,D1 (Area1) и A2,B2,C2,D2 (Area2)
                      пересек. в пределах, ограниченных своими линиями    }
  var
   aLines:IDMCollection;
   aLine:ILine;
   aC0,aC1:ICoordNode;
   j:integer;
   Flag1,Flag2:boolean;
  begin
   result:=False;
   Flag1:=False;
   Flag2:=False;

      {плоск. A1,B1,C1,D1 (Area1) пересек. в пределах линий  Area2 ?}
   aLines:=(Area2 as IPolyLine).Lines;

   for j:=0 to aLines.Count-1 do begin
    aLine:=(aLines.Item[j]as ILine);
    aC0:=aLine.C0;
    aC1:=aLine.C1;
    if(A1*aC0.X + B1*aC0.Y + C1*aC0.Z + D1)*
                 (A1*aC1.X + B1*aC1.Y + C1*aC1.Z + D1)<1e-3 then begin
     Flag1:=True;
     break;
    end;
   end;    //for j

      {плоск. A2,B2,C2,D2 (Area2) пересек. в пределах линий  Area1 ?}
   aLines:=(Area1 as IPolyLine).Lines;

   for j:=0 to aLines.Count-1 do begin
    aLine:=(aLines.Item[j]as ILine);
    aC0:=aLine.C0;
    aC1:=aLine.C1;
    if(A2*aC0.X + B2*aC0.Y + C2*aC0.Z + D2)*
                 (A2*aC1.X + B2*aC1.Y + C2*aC1.Z + D2)<1E-3 then begin
     Flag2:=True;
     break;
    end;
   end;    //for j

   if Flag1 and Flag2 then
    result:=True;

  end; //function CheckCrossing

  procedure CoordMaxMin(Lines1,Lines2:IDMCollection; n:integer;
                                         var max,min:double);
  var
   aLine:ILine;
   max1,min1,max2,min2:double;
   j:integer;
  begin
   max1:=-1.E12;
   min1:=1.E12;
   for j:=0 to Lines1.Count-1 do begin
    aLine:=Lines1.Item[j]as ILine;
    case n of
      1: begin
          if aLine.C0.X > max1 then
           max1:=aLine.C0.X
          else
           if aLine.C0.X < min1 then
            min1:=aLine.C0.X ;
          if aLine.C1.X > max1 then
           max1:=aLine.C1.X
          else
           if aLine.C1.X < min1 then
            min1:=aLine.C1.X ;
         end;
      2: begin
          if aLine.C0.Y > max1 then
           max1:=aLine.C0.Y
          else
           if aLine.C0.Y < min1 then
            min1:=aLine.C0.Y ;
          if aLine.C1.Y > max1 then
           max1:=aLine.C1.Y
          else
           if aLine.C1.Y < min1 then
            min1:=aLine.C1.Y ;
         end;
      3: begin
          if aLine.C0.Z > max1 then
           max1:=aLine.C0.Z
          else
           if aLine.C0.Z < min1 then
            min1:=aLine.C0.Z ;
          if aLine.C1.Z > max1 then
           max1:=aLine.C1.Z
          else
           if aLine.C1.Z < min1 then
            min1:=aLine.C1.Z ;
         end;
    end; //case
   end;    //for

   max2:=-1.E12;
   min2:=1.E12;
   for j:=0 to Lines2.Count-1 do begin
    aLine:=Lines2.Item[j]as ILine;
    case n of
      1: begin
          if aLine.C0.X > max2 then
           max2:=aLine.C0.X
          else
           if aLine.C0.X < min2 then
            min2:=aLine.C0.X ;
          if aLine.C1.X > max2 then
           max2:=aLine.C1.X
          else
           if aLine.C1.X < min2 then
            min2:=aLine.C1.X ;
         end;
      2: begin
          if aLine.C0.Y > max2 then
           max2:=aLine.C0.Y
          else
           if aLine.C0.Y < min2 then
            min2:=aLine.C0.Y ;
          if aLine.C1.Y > max2 then
           max2:=aLine.C1.Y
          else
           if aLine.C1.Y < min2 then
            min2:=aLine.C1.Y ;
         end;
      3: begin
          if aLine.C0.Z > max2 then
           max2:=aLine.C0.Z
          else
           if aLine.C0.Z < min2 then
            min2:=aLine.C0.Z ;
          if aLine.C1.Z > max2 then
           max2:=aLine.C1.Z
          else
           if aLine.C1.Z < min2 then
            min2:=aLine.C1.Z ;
         end;
    end; //case
   end;    //for

   if max1<max2 then
    max:=max1
   else
    max:=max2;

   if min1<min2 then
    min:=min2
   else
    min:=min1;

  end; //procedure CoordMaxMin


  begin
   result:=False;
   if (Area1=nil)or(Area2=nil) then Exit;

   aLines1:=(Area1 as IPolyLine).Lines;
   aLines2:=(Area2 as IPolyLine).Lines;
   if (aLines1.Count=0)or(aLines2.Count=0) then Exit;

   A1:=Area1.NX;      {A1,B1,C1,D1 - коэф.уравн.плоск.Area1}
   B1:=Area1.NY;
   C1:=Area1.NZ;

   A2:=Area2.NX;       {A2,B2,C2,D2 - коэф.уравн.плоск.Area2}
   B2:=Area2.NY;
   C2:=Area2.NZ;

      {плоск. не пересек. если А1/A2=B1/B2=C1/C2 }
   if (A1=A2)and(B1=B2)and(C1=C2) then Exit;

   aLine1:=aLines1.Item[0]as ILine;

   x1:=aLine1.C0.X;
   y1:=aLine1.C0.Y;
   z1:=aLine1.C0.Z;
   D1:=-(A1*x1 + B1*y1 + C1*z1);

   aLine2:=aLines2.Item[0]as ILine;

   x2:=aLine2.C1.X;
   y2:=aLine2.C1.Y;
   z2:=aLine2.C1.Z;

   D2:=-(A2*x2 + B2*y2 + C2*z2);

   {плоск. Area1 (Area2) пересек. в пределах линий  Area2 (Area1) ?}
   if CheckCrossing(Area1,Area2,A1,B1,C1,D1,A2,B2,C2,D2) then begin
    result:=True;
    if ((A1<>0)or(A2<>0))                 {если плоск.пересек.  }
       and((B1<>0)or(B2<>0))then begin
      CoordMaxMin(aLines1,aLines2,3,p2z,p1z);
      T1:=C1*p1z+D1;
      T2:=C2*p1z+D2;
      Formula(A1,B1,T1,A2,B2,T2,p1x,p1y);
      T1:=C1*p2z+D1;
      T2:=C2*p2z+D2;
      Formula(A1,B1,T1,A2,B2,T2,p2x,p2y);
    end else
     if ((B1<>0)or(B2<>0))
      and((C1<>0)or(C2<>0))then begin
       CoordMaxMin(aLines1,aLines2,1,p2x,p1x);
       T1:=A1*p1x+D1;
       T2:=A2*p1x+D2;
       Formula(B1,C1,T1,B2,C2,T2,p1y,p1z);
       T1:=A1*p2x+D1;
       T2:=A2*p2x+D2;
       Formula(B1,C1,T1,B2,C2,T2,p2y,p2z);
     end else
      if ((C1<>0)or(C2<>0))
          and((A1<>0)or(A2<>0)) then begin
        CoordMaxMin(aLines1,aLines2,2,p2y,p1y);
        T1:=B1*p1y+D1;
        T2:=B2*p1y+D2;
        Formula(A1,C1,T1,A2,C2,T2,p1x,p1z);
        T1:=B1*p2y+D1;
        T2:=B2*p2y+D2;
        Formula(A1,C1,T1,A2,C2,T2,p2x,p2z);
      end else
        result:=False;
   end else
     result:=False;

   if (p1x=p2x)and(p1y=p2y)and(p1z=p2z) then
     result:=False;


  end;  //function CrossingArea
  function LinesContaining(const Line:ILine;
                                  const AllAreas0,AllAreas:IDMCollection;
                                  out Areas:IDMCollection):IDMCollection ;
{  Areas    - коллекция Area (из AllAreas) где лежат оба узла Line,
   Result=Area (из  AllAreas0)   - где лежат оба узла Line                                    }

  var
   SpatialModel2:ISpatialModel2;
   C0_Areas:IDMCollection;
   C1_Areas:IDMCollection;
   C0_Volumes:IDMCollection;
   C1_Volumes:IDMCollection;
   aArea1E,aArea2E:IDMElement;
   j,k:integer;
   l,m:integer;
  begin
  (Result as IDMCollection2).Clear;
   SpatialModel2:=Get_DataModel as ISpatialModel2;

   C0_Areas:=TDMCollection.Create(nil);
   C1_Areas:=TDMCollection.Create(nil);
   C0_Volumes:=TDMCollection.Create(nil);
   C1_Volumes:=TDMCollection.Create(nil);
   Areas  :=TDMCollection.Create(nil);

   SpatialModel2.GetColVolumeContaining(Line.C0.X,Line.C0.Y,
                                              Line.C0.Z,C0_Areas,C0_Volumes);

   SpatialModel2.GetColVolumeContaining(Line.C1.X,Line.C1.Y,
                                        Line.C1.Z,C1_Areas,C1_Volumes);

   for j:=0 to C0_Areas.Count-1 do begin
     aArea1E:=C0_Areas.Item[j];
     l:=(AllAreas as IDMCollection).IndexOf(aArea1E);
     m:=(AllAreas0 as IDMCollection).IndexOf(aArea1E);
     if (l<>-1)or(m<>-1) then begin
        for k:=0 to C1_Areas.Count-1 do begin
          aArea2E:=C1_Areas.Item[k];
          if ((AllAreas0 as IDMCollection).IndexOf(aArea2E)<>-1)
                                             and(aArea2E=aArea1E) then begin
              (Result as IDMCollection2).Add(aArea2E);
          end;
          if ((AllAreas as IDMCollection).IndexOf(aArea2E)<>-1)
                                             and(aArea2E=aArea1E) then begin
                (Areas as IDMCollection2).Add(aArea2E);
          end;
        end;//k
     end;
   end;

  end;  //LinesContaining


  function CheckCoordNode(Collection:IDMCollection;X,Y,Z:double):IDMElement ;
  {result=Node, если Collection(Nodes)- Node.X, Node.Y, Node.Z = X,Y,Z    }
  var
   j:integer;
   aNodeE:IDMElement;
   aNode:ICoordNode;
  begin
   result:=nil;
   for j:=0 to Collection.Count-1 do begin
    aNodeE:=Collection.Item[j];
    aNode:=aNodeE as ICoordNode;
    if (abs(aNode.X-X)<0.1)
         and(abs(aNode.Y-Y)<0.1)and(abs(aNode.Z-Z)<0.1) then begin
     result:=aNodeE;
     break;
    end;
   end;    //for
  end; //function CheckCoordNode

  function CheckCoordOfLine(Line1:ILine;X,Y,Z:double;Line2:ILine;
                                       out NewLine1,NewLine2:ILine):ICoordNode ;
   { result = Node(x,y,z)                                 }
  var
   C0,C1:ICoordNode;
  begin
    result:=nil;
    C0:=Line1.C0;
    C1:=Line1.C1;
    if (abs(C0.X-X)<0.1)and(abs(C0.Y-Y)<0.1)and(abs(C0.Z-Z)<0.1) then
     result:=C0
    else
     if (abs(C1.X-X)<0.1)and(abs(C1.Y-Y)<0.1)and(abs(C1.Z-Z)<0.1) then
      result:=C1;

    if result=nil then
      NewLine1:=LineSeparate(x,y,z,True,Line1,result);

    if Line2<>nil then
      if result=nil then {Node<>Line2.C0/C1 ?}
        NewLine2:=LineSeparate(x,y,z,True,Line2,result)
      else
        NewLine2:=LineSeparate(x,y,z,False,Line2,result);

  end; //function CheckCoordOfLine


  procedure CheckCrossingLines(var Line1,Line2:ILine;
                              var Area1,Area2:IArea;
                              var Nodes:IDMCollection;
                              out NewLine1,NewLine2:ILine;
                              out NewNode:ICoordNode);
    {если aLine1-aLine2 пересекаются, разделить в точке пересечения}
  var
   x1,y1,z1,x2,y2,z2, x3,y3,z3,x4,y4,z4, x,y,z:double;
   NewNodeE:IDMElement;
   StatLine1,StatLine2:integer;
  begin
      NewNode:=nil;
      x1:=Line1.C0.X;
      y1:=Line1.C0.Y;
      z1:=Line1.C0.Z;
      x2:=Line1.C1.X;
      y2:=Line1.C1.Y;
      z2:=Line1.C1.Z;
      x3:=Line2.C0.X;
      y3:=Line2.C0.Y;
      z3:=Line2.C0.Z;
      x4:=Line2.C1.X;
      y4:=Line2.C1.Y;
      z4:=Line2.C1.Z;
      if CrossingNodeOfLines(x1,y1,z1,x2,y2,z2, x3,y3,z3,x4,y4,z4, x,y,z)then begin
       StatLine1:=CheckInternalNode(x,y,z, x1,y1,z1,x2,y2,z2);
       StatLine2:=CheckInternalNode(x,y,z, x3,y3,z3,x4,y4,z4);

       if ((StatLine1=0)and(StatLine2=0)) then begin{пересеч.внутри Line1,2 ?}
           //-----------
        NewNodeE:=CheckCoordNode(Nodes,x,y,z);  //найти (x,y,z) в сп.Nodes
        if NewNodeE=nil then                     {нет в сп.Nodes }
         NewNode:=CheckCoordOfLine(Line1,X,Y,Z,Line2,NewLine1,NewLine2);
       end else
        if (StatLine1=0)and(StatLine2=1) then begin{пересеч.внутри Line1 ?}
           //-----------
         NewNodeE:=CheckCoordNode(Nodes,x,y,z);  //найти (x,y,z) в сп.Nodes
         if NewNodeE=nil then                      {нет в сп.Nodes }
          NewNode:=CheckCoordOfLine(Line1,X,Y,Z,nil,NewLine1,NewLine2);
        end else
          if (StatLine2=0)and(StatLine1=1)then begin {пересеч.внутри Line2 ?}
           //-----------
           NewNodeE:=CheckCoordNode(Nodes,x,y,z);
           if NewNodeE=nil then                {не из сп.Nodes }
            NewNode:=CheckCoordOfLine(Line1,X,Y,Z,Line2,NewLine2,NewLine1);
          end;
      end;
   end; //function CheckCrossungLines

  function CheckPresenceLine(const Node1,Node2:ICoordNode;Stat:boolean;
                       var Lines0,Lines:IDMCollection;out Line:ILine):boolean ;
  {result=True,если между Node1-Node2 есть Line из сп. Lines0,Lines
   result=False,если между Node1-Node2 линии нет.
           Если Stat=True создать Line                                         }
  var
   j:integer;
   LineU:IUnknown;
  begin
   result:=False;
   for j:=0 to Lines0.Count-1 do begin
    Line:=Lines0.Item[j] as ILine;
    if (Line.C0=Node1)and(Line.C1=Node2)
        or(Line.C1=Node1)and(Line.C0=Node2)then begin
     result:=True;
     Exit;
    end;  //lf
   end;    //for

   for j:=0 to Lines.Count-1 do begin
    Line:=Lines.Item[j] as ILine;
    if (Line.C0=Node1)and(Line.C1=Node2)
        or(Line.C1=Node1)and(Line.C0=Node2)then begin
     result:=True;
     Exit;
    end;  //lf
   end;    //for

   if Stat then begin
      AddElement((Line as IDMElement).Parent,Lines0,
                                                '', ltOneToMany, LineU, True);
      Line:=LineU as ILine;
      if Node1.Z<Node2.Z then begin
       Line.C0:=Node1;
       Line.C1:=Node2;
      end else begin
       Line.C0:=Node2;
       Line.C1:=Node1;
      end; //if
   end; //if
  end; //function CheckPresenceLine

//  function CrossinAreaOfLine(const Area:IArea;Line:ILine;out x,y,z:double):boolean ;
  function CrossinAreaOfLine(const Area:IArea;SourceLines:IDMCollection;
                                             Line:ILine;out x,y,z:double):boolean ;
  {result=True,если     }
  var
   aLine:ILine;
   x1,y1,z1, x2,y2,z2:double;
   x3,y3,z3, x0,y0,z0, xi,yi,zi:double;
   dx,dy,dz, d1,d2, d01,d02, v1,v2:double;
   A,B,C,D:double;
   SpatialModel2:ISpatialModel2;
   aAreas,aVolumes:IDMCollection;
   aNodes:IDMCollection;
   aAreaE:IDMElement;
   aAreaP:IPolyLine;
   C0,C1:ICoordNode;
   j,kC,Stat:integer;
  begin

   A:=Area.NX;      {A1,B1,C1,D1 - коэф.уравн.плоск.Area1}
   B:=Area.NY;
   C:=Area.NZ;

   aLine:=SourceLines.Item[0]as ILine;

   C0:=aLine.C0;

   x0:=C0.X;
   y0:=C0.Y;
   z0:=C0.Z;
   D:=-(A*x0 + B*y0 + C*z0);

   C0:=Line.C0;
   C1:=Line.C1;

   x1:=C0.X;
   y1:=C0.Y;
   z1:=C0.Z;

   x2:=C1.X;
   y2:=C1.Y;
   z2:=C1.Z;

   dx:=x2-x1;
   dy:=y2-y1;
   dz:=z2-z1;

   v1:=A*x1 + B*y1 + C*z1;
   d01:=v1 + D;

   if abs(v1-D)<1E-6 then
    d01:=0;

   v2:=(A*x2 + B*y2 + C*z2);
   d02:=v2 + D;

   if abs(v2-D)<1E-6 then
    d02:=0;

   if d01*d02<0 then
    if dx<>0 then begin         //пересек.(С0 и С1 по разные стор. от пл.)
     d1:=-x1*dy/dx+y1;
     d2:=-x1*dz/dx+z1;
     x:=-(D+B*d1+C*d2)/(A + B*dy/dx + C*dz/dx);
     y:=x*dy/dx+d1;
     z:=x*dz/dx+d2;
    end else
     if dy<>0 then begin
      d1:=-y1*dx/dy+x1;
      d2:=-y1*dz/dy+z1;
      y:=-(D+A*d1+C*d2)/(A*dx/dy + B + C*dz/dy);
      x:=y*dx/dy+d1;
      z:=x*dx/dz+d2;
     end else
      if dz<>0 then begin
       d1:=-z1*dx/dz+x1;
       d2:=-z1*dy/dz+y1;
       z:=-(D+A*d1+B*d2)/(A*dx/dz + B*dy/dz + C);
       x:=z*dx/dz+d1;
       y:=z*dy/dz+d2;
      end else begin
       ShowMessage('Проверьте линию ID='+IntToStr((Line as IDMElement).ID));
       result:=False;
       Exit;
      end
   else
    if (d01=0)and(d02=0) then begin
     result:=False;          //лежит на пл. (косается 2-мя точк.)
     Exit;
    end else
     if d01=0 then begin
      x:=x1;                 //косается точк. С0
      y:=y1;
      z:=z1;
     end else
      if d02=0 then begin
       x:=x2;
       y:=y2;                //косается точк. С1
       z:=z2;
      end else begin
       result:=False;//не пересек.(С0 и С1 по 1-y стор. от пл.)
       Exit;
      end;

   {Line пересек.с пл. внутри линий Area ?}

   if Area.IsVertical then begin
    x1:=x;
    y1:=y;
    z1:=1E6;
   end else begin
    D:=Area.MaxZ-Area.MinZ;
    if abs(D)<1E-3 then begin
     x1:=1E6;
     y1:=y+100;
     z1:=z;
    end else begin
     C1:=aLine.C1;
     dx:=C1.X-x0;
     dy:=C1.Y-y0;
     dz:=C1.Z-z0;
     z1:=1E6;
     if dz<>0 then begin
      if (dx<>0)and(dz<>0) then begin
       x1:=x + dx/dz*(1E6-z);
       y1:=y;
       z1:=1E6;
      end else
       if (dy<>0)and(dz<>0) then begin
        x1:=x;
        y1:=y + dy/dz*(1E6-z);
        z1:=1E6;
       end;
     end else
      for j:=0 to SourceLines.Count-1 do begin
       aLine:=SourceLines.Item[j]as ILine;
       C0:=aLine.C0;
       C1:=aLine.C1;
       x0:=C0.X;
       y0:=C0.Y;
       z0:=C0.Z;
       dx:=C1.X-x0;
       dy:=C1.Y-y0;
       dz:=C1.Z-z0;
       if dz<>0 then
        if dx<>0then begin
         x1:=x + dx/dz*(1E6-z);
         y1:=y;
         z1:=1E6;
         break;
        end else
         if dy<>0 then begin
          x1:=x;
          y1:=y + dy/dz*(1E6-z);
          z1:=1E6;
          break;
         end;
     end;    //for
    end;
   end;

   kC:=0; //число пересечений линии (x1..z1)-(x2..) с линиями (x2..z2)-(x3..)
   aNodes:=TDMCollection.Create(nil);
   for j:=0 to SourceLines.Count-1 do begin
     aLine:=(SourceLines.Item[j]) as ILine;
     C0:=aLine.C0;
     C1:=aLine.C1;
     x2:=C0.X;
     y2:=C0.Y;
     z2:=C0.Z;

     x3:=C1.X;
     y3:=C1.Y;
     z3:=C1.Z;

     if CrossingNodeOfLines(x,y,z, x1,y1,z1, x2,y2,z2,x3,y3,z3, xi,yi,zi)then
      if not((abs(x-xi)<1E-3)and(abs(y-yi)<1E-3)and(abs(z-zi)<1E-3))then//пересеч.не в баз.точке
       if CheckInternalNode(xi,yi,zi, x,y,z,x1,y1,z1)>=0 then begin{пересеч.внутри (x..z-x1..z1) ?}
        Stat:=CheckInternalNode(xi,yi,zi, x2,y2,z2,x3,y3,z3);
        if Stat=0 then  {пересеч.внутри (x2..z2-x3..z3)}
         kC:=kC+1
        else
         if Stat=1 then begin
          if aNodes.IndexOf(C0 as IDMElement)=-1 then begin
           kC:=kC+1;
           (aNodes as IDMCollection2).Add(C0 as IDMElement);
          end
         end else
          if Stat=2 then begin
           if aNodes.IndexOf(C1 as IDMElement)=-1 then
            kC:=kC+1;
            (aNodes as IDMCollection2).Add(C1 as IDMElement);
           end;
       end;
   end;

   if (kC div 2)=(kC/2) then
     result:=False      // точка (x,y,z) вне Area
   else
     result:=True;      // точка (x,y,z) внутр.[число пересечений -нечетное]
  end; //function CrossinAreaOfLine

  function FindTopNode(const C:ICoordNode;Area:IArea;Stat:boolean;
                                       out NewLine:ILine):ICoordNode ;
  {result=True,если     }
  var
   C0,C1:ICoordNode;
   x,y,z,dx1, dy1,dx2,dy2:double;
   aTopLines:IDMCollection;
   aLine:ILine;
   j:integer;
  begin
   result:=nil;
   x:=C.X;
   y:=C.Y;

   aTopLines:=Area.TopLines;
   for j:=0 to aTopLines.Count-1 do begin
    aLine:=aTopLines.Item[j] as ILine;
    C0:=aLine.C0;
    C1:=aLine.C1;
    dx1:=C0.X-x;
    dy1:=C0.Y-y;
    dx2:=C1.X-x;
    dy2:=C1.Y-y;
    if abs((dx1*dy2)-(dx2*dy1))<1E-6 then {3 тчк.на 1 прям.}
     if (abs(dx1*dx2)<1E-6)
        and(abs(dy1*dy2)<1E-6) then   {x,y на  C0 или на C1}
       if (abs(dx1)<1E-6)
        and(abs(dy1)<1E-6) then begin     {x,y на  C0}
        result:=C0;
        break;
       end else begin
        if (abs(dx2)<1E-6)
          and(abs(dy2)<1E-6) then begin  {x,y на  C1}
         result:=C1;
         break;
        end;
       end
     else
      if ((dx1*dx2<0)and(dy1*dy2<0))
         or((dx1*dx2<0)and(abs(dy1*dy2)<1E-6))
          or((abs(dx1*dx2)<1E-6)and(dy1*dy2<0)) then begin  {x,y  между C0,C1}
       z:=C0.Z;
       if Stat then begin
        NewLine:=LineSeparate(x,y,z,True,aLine,result);
       end;
       break;
      end;
   end;    //for
  end; //function FindTopNode



    function NodesCount(Lines,Nodes:IDMCollection; x1,y1,z1, x2,y2,z2:double):double;
    {   Если у Line списка Lines есть узлы лежащие на линии x1,y1,z1 - x2,y2,z2,
                               добавить.в Nodes result=Nodes.Count}
    var
     j:integer;
     aLine:ILine;
     C0,C1:ICoordNode;
     C0E,C1E:IDMElement;
     x,y,z,D1,D2,D3:double;
     dx1,dy1,dz1:double;
     dx2,dy2,dz2:double;
    begin
      for j:=0 to Lines.Count-1 do begin
        aLine:=Lines.Item[j] as ILine;
        C0:=aLine.C0;
        x:=C0.X;
        y:=C0.Y;
        z:=C0.Z;
        dx2:=x2-x;
        dy2:=y2-y;
        dz2:=z2-z;
        dx1:=x1-x;
        dy1:=y1-y;
        dz1:=z1-z;
        D1:=dx2*dy1-dy2*dx1;
        D2:=dx2*dz1-dz2*dx1;
        D3:=dy2*dz1-dz2*dy1;
        if (abs(D1)<1E-1)and(abs(D2)<1E-1)and(abs(D3)<1E-1)then begin//C0 на прямой x1,y1,z1-x2,y2,z2
          C0E:=C0 as IDMElement;
          if Nodes.IndexOf(C0E)=-1 then
           (Nodes as IDMCollection2).Add(C0E); //в спис.всех нов.точ.Volume
        end;
        C1:=aLine.C1;
        x:=C1.X;
        y:=C1.Y;
        z:=C1.Z;
        dx2:=x2-x;
        dy2:=y2-y;
        dz2:=z2-z;
        dx1:=x1-x;
        dy1:=y1-y;
        dz1:=z1-z;
        D1:=dx2*dy1-dy2*dx1;
        D2:=dx2*dz1-dz2*dx1;
        D3:=dy2*dz1-dz2*dy1;
        if (abs(D1)<1E-1)and(abs(D2)<1E-1)and(abs(D3)<1E-1)then begin//C1 на прямой x1,y1,z1-x2,y2,z2
          C1E:=C1 as IDMElement;
          if Nodes.IndexOf(C1E)=-1 then
           (Nodes as IDMCollection2).Add(C1E); //в спис.всех нов.точ.Volume
        end;
      end;    //for

      result:=Nodes.Count;

    end; //function NodesCount

  procedure AddInMainAreasLines(const AllAreas:IDMCollection;
                                  var MainAreasLines:IDMCollection);
    {Для AllAreas в MainAreasLines составить списки Areas и CopyLines
    CopyLines - копии исходных полилиний Areas}
  var
     aAreaE:IDMElement;
     aLineE:IDMElement;
     aCopyLineE:IDMElement;
     aLine:ILine;
     aCopyLine:ILine;
     aCollection:IDMCollection;
     aCollection2:IDMCollection2;
     k,n:integer;
  begin
     aCollection2:=((Get_DataModel as ISpatialModel).Lines as IDMCollection2);
     k:=0;
     while k<AllAreas.Count do begin
         aAreaE:=AllAreas.Item[k];
         inc(k,2);
         if (MainAreasLines as IDMCollection).IndexOf(aAreaE)=-1 then begin
           aCollection:=(aAreaE as IPolyLine).Lines;
           for n:=0 to aCollection.Count-1 do begin
             aLineE:=aCollection.Item[n];
             aCopyLineE:=aCollection2.CreateElement(False);
             aCopyLine:=aCopyLineE as ILine;
             aLine:=aLineE as ILine;
             aCopyLine.C0:=aLine.C0;
             aCopyLine.C1:=aLine.C1;

            (MainAreasLines as IDMCollection2).Add(aAreaE);      //1- str
            (MainAreasLines as IDMCollection2).Add(aCopyLineE);  //2- str
           end;    //for n
         end;   //if MainAreas
     end;    //for k
  end; //procedure  AddInMainAreasLines

  procedure ExtractAreaLines(MainAreasLines,Lines:IDMCollection;
                                                AreaE:IDMElement);
   {Из MainAreasLines извлечь Lines для AreaE,
    если их там нет - из PolyLine AreaE}
  var
   aCount:integer;
   aAreaE:IDMElement;
   AreaP : IPolyLine;
   aLineE:IDMElement;
   i,j:integer;
  begin
   (Lines as IDMCollection2).Clear;
    i:=(MainAreasLines as IDMCollection).IndexOf(AreaE);
    if i<>-1 then begin
     aCount:=MainAreasLines.Count;
     while i<aCount do begin
      aAreaE:=MainAreasLines.Item[i];
      if aAreaE=AreaE then begin
       aLineE:=MainAreasLines.Item[i+1];
       (Lines as IDMCollection2).Add(aLineE);
       inc(i,2);
      end else
      i:=aCount;
     end; //while
    end else begin
     AreaP:=AreaE as IPolyLine;
     for j:=0 to AreaP.Lines.Count-1 do begin
       aLineE:=AreaP.Lines.Item[j];
       (Lines as IDMCollection2).Add(aLineE);
       (MainAreasLines as IDMCollection2).Add(AreaE);
       (MainAreasLines as IDMCollection2).Add(aLineE);
     end;
    end; //if
  end; //procedure ExtractAreaLines

  procedure CreateAreaForNewLines(ForNewLines:IDMCollection);
  //--------------
  // создать Area для списка линий
  //--------------
  var
  SpatialModel2:ISpatialModel2;
  AreaU:IUnknown;
  NewAreaE:IDMElement;
  aLineE  :IDMElement;
  aAreaE:IDMElement;
  theAreaE:IDMElement;
  i:integer;
  begin
    SpatialModel2:=Get_DataModel as ISpatialModel2;

    theAreaE:=nil;
    i:=0;
    while i<ForNewLines.Count do begin
     aLineE:=ForNewLines.Item[i];
     aAreaE:=ForNewLines.Item[i+3];
     if aAreaE<>theAreaE then begin
       AddElement( ForNewLines.Item[i].Parent,
                      SpatialModel2.Areas, '', ltOneToMany, AreaU, True);
       NewAreaE:=AreaU as IDMElement;
       theAreaE:=aAreaE;
     end; //if
     aLineE.AddParent(NewAreaE);
     inc(i,4);
    end; //while

  end; //procedure



  procedure NodesProcessing(const Node1,Node2:ICoordNode;
                            var NewLines,ForNewLines,Areas0:IDMCollection;
                            var AreaE,Area0E,Volume0E:IDMElement;
                            out NewAreaE,NewLineE:IDMElement);
  //--------------
  //
  //--------------
  var
   Lines0   :IDMCollection;
   aNewLine :ILine;
   aArea0   :IArea;
   aAreaE   :IDMElement;
   aVolumeE :IDMElement;
   j        :integer;
  begin
        Lines0:=(Area0E as IPolyLine).Lines;
        if Node1<>Node2 then begin
           NewAreaE:=nil;
           aArea0:=Area0E as IArea;
           if not(CheckPresenceLine(Node1,Node2,True,
                                          Lines0,NewLines,aNewLine))then begin
             NewAreaE:= LineDivideArea(Node1,Node2, aArea0) as IDMElement;
             NewLineE:=aNewLine as IDMElement;
             if NewLines.IndexOf(NewLineE)=-1 then begin
                (NewLines as IDMCollection2).Add(NewLineE);    //в спис.
                (ForNewLines as IDMCollection2).Add(NewLineE); //в спис.
                (ForNewLines as IDMCollection2).Add(Area0E);   //в спис.
                (ForNewLines as IDMCollection2).Add(NewAreaE); //в спис.
                (ForNewLines as IDMCollection2).Add(AreaE);    //в спис.
             end;
             if NewLineE.Parents.IndexOf(NewAreaE)=-1 then
              NewLineE.AddParent(NewAreaE);
             if NewLineE.Parents.IndexOf(Area0E)=-1 then
              NewLineE.AddParent(Area0E);
           end else begin
             NewLineE:=aNewLine as IDMElement;
             if NewLineE.Parents.IndexOf(Area0E)=-1 then begin
              NewAreaE:= LineDivideArea(Node1,Node2, aArea0) as IDMElement;
              if NewLineE.Parents.IndexOf(NewAreaE)=-1 then
               NewLineE.AddParent(NewAreaE);
              if NewLineE.Parents.IndexOf(Area0E)=-1 then
               NewLineE.AddParent(Area0E);
              if NewLines.IndexOf(NewLineE)=-1 then begin
                (NewLines as IDMCollection2).Add(NewLineE);    //в спис.
                (ForNewLines as IDMCollection2).Add(NewLineE); //в спис.
                (ForNewLines as IDMCollection2).Add(Area0E);   //в спис.
                (ForNewLines as IDMCollection2).Add(NewAreaE); //в спис.
                (ForNewLines as IDMCollection2).Add(AreaE);    //в спис.
              end;
             end;
           end;
           if NewAreaE<>nil then begin
              UpdateElement(Area0E);
              UpdateCoords(Area0E);
              UpdateElement(NewAreaE);
              UpdateCoords(NewAreaE);
              UpdateElement(Volume0E);
              UpdateCoords(Volume0E);
              for j:=0 to Areas0.Count-1 do begin
               aAreaE:=Areas0.Item[j];
               aVolumeE:=Areas0.Item[j+1];
               if (aAreaE=AreaE)and(aVolumeE=Volume0E) then begin
                (Areas0 as IDMCollection2).Insert(j+2,NewAreaE);
                (Areas0 as IDMCollection2).Insert(j+3,Volume0E);
                 break;
               end;
              end;    //for

              if (Areas0 as IDMCollection).IndexOf(NewAreaE)=-1 then begin
              end;
           end;
        end;//Nod1<>Node2

  end; //procedure NodesProcessing

//***Debug----------------------------------------- ***Debug
  function FindElenentOfID(_ClassID,ID:integer):IDMElement ;
  {result=True,если     }
  var
   SpatialModel2:ISpatialModel2;
   aVolumeE:IDMElement;
   aAreaE  :IDMElement;
   aLineE  :IDMElement;
   aNodeE  :IDMElement;
   aVolume :IVolume;
   aAreaP   :IPolyLine;
   aLine   :ILine;
   aCollection:IDMCollection;
   j,k:integer;
  begin
   SpatialModel2:=Get_DataModel as ISpatialModel2;
   result:=nil;
   case _ClassID of
   _Volume:
       for j:=0 to SpatialModel2.Volumes.Count-1 do begin
         aVolumeE:=SpatialModel2.Volumes.Item[j];
         aVolume:=aVolumeE as IVolume;
         if aVolume.Areas.Count=0 then begin  //если Volumes вложенные
          aCollection:=DataModel.CreateCollection(-1, nil);
          SpatialModel2.GetInnerVolumes(aVolumeE,aCollection);
          for k:=0 to aCollection.Count-1 do begin
            aVolumeE:=aCollection.Item[k];
            if aVolumeE.ID=ID then begin
              result:=aVolumeE;
              break;
            end;
          end    //for k
         end else
          if aVolumeE.ID=ID then begin
            result:=aVolumeE;
            break;
          end;
       end;    //for
   _Area:
       for j:=0 to SpatialModel2.Areas.Count-1 do begin
         aAreaE:=SpatialModel2.Areas.Item[j];
         aAreaP:=aAreaE as IPolyLine;
          if aAreaE.ID=ID then begin
            result:=aAreaE;
            break;
          end;
       end;    //for
   _Line:
       for j:=0 to SpatialModel2.Areas.Count-1 do begin
         aAreaE:=SpatialModel2.Areas.Item[j];
         aAreaP:=aAreaE as IPolyLine;
         for k:=0 to aAreaP.Lines.Count-1 do begin
          aLineE:=aAreaP.Lines.Item[k];
          if aLineE.ID=ID then begin
            result:=aLineE;
            break;
          end;
         end;    //for
       end;    //for
   _CoordNode:
       for j:=0 to SpatialModel2.Areas.Count-1 do begin
         aAreaE:=SpatialModel2.Areas.Item[j];
         aAreaP:=aAreaE as IPolyLine;
         for k:=0 to aAreaP.Lines.Count-1 do begin
          aLineE:=aAreaP.Lines.Item[k];
          aLine:=aLineE as ILine;
          aNodeE:=aLine.C0 as IDMElement;
          if aNodeE.ID=ID then begin
            result:=aNodeE;
            break;
          end else begin
            aNodeE:=aLine.C1 as IDMElement;
            if aNodeE.ID=ID then begin
              result:=aNodeE;
              break;
            end;
          end;
         end;    //for
       end;    //for
   end; //case

  end; //function
//***Debug----------------------------------------- ***Debug

//Debug ------------------------------------- Debug
 procedure ContrlVolume(ID,N:integer);
 //--------------
 //
 //--------------
 var
  Volume0E,Volume1E,Volume2E:IDMElement;
  aVolume:IVolume;
  aArea:IArea;
  j:integer;
 begin
   Volume2E:=FindElenentOfID(_Volume,ID) ;  //0
   if Volume2E<>nil then begin
   aVolume:=Volume2E as IVolume;
   if Volume2E.ID=ID then begin
     for j:=0 to aVolume.Areas.Count-1 do begin
      aArea:=aVolume.Areas.Item[j] as IArea;
      if aArea<>nil then begin
      Volume0E:=aArea.Volume0 as IDMElement;
      Volume1E:=aArea.Volume1 as IDMElement;
      end;
     end;    //for
   end;
   end;

 end; //procedure
//Debug ------------------------------------- Debug

//***Debug----------------------------------------- ***Debug
    function ShowArea(Area:IArea):boolean;
    var
     i:integer;
     aLineE,aVolume0E,aVolume1E,aAreaE:IDMElement;
     aLine:ILine;
     aAreaP:IDMCollection;
    begin
     if Area=nil then begin
      result:=False;
      Exit
     end else
       result:=True;

       if Area.Volume0<>nil then
        aVolume0E:=Area.Volume0 as IDMElement;
       if Area.Volume1<>nil then
        aVolume1E:=Area.Volume1 as IDMElement;

       aAreaE:=Area as IDMElement;
       aAreaP:=(Area as IPolyLine).Lines;
       for  i:=0  to aAreaP.Count-1 do begin
        aLineE:=aAreaP.Item[i];
        aLine:=aLineE as ILine;
       end;
    end; //function ShowArea
//***Debug----------------------------------------- ***Debug

  procedure DivArea(LineE:IDMElement;AreaE:IDMElement;
                                     out NewAreaE:IDMElement);
  //--------------
  //
  //--------------
  var
   SpatialModel2:ISpatialModel2;
   aAreaP:IPolyLine;
   aLine:ILine;
   aLineE:IDMElement;
   C0,C1,Nn,Nk:ICoordNode;
   aCollection:IDMCollection;
   AreaU:IUnknown;
   i,k,aCount:integer;
   FlagN,FlagK:boolean;
  begin
    if (LineE=nil)or(AreaE=nil) then Exit;

    aLine:=LineE as ILine;
    Nn:=aLine.C0;
    Nk:=aLine.C1;

    if (Nn=nil)or(Nk=nil) then Exit;

    aCollection:=DataModel.CreateCollection(-1, nil);

    aAreaP:=AreaE as IPolyLine;
    aCount:=aAreaP.Lines.Count;

    if aCount=0 then Exit;

    FlagN:=False;
    FlagK:=False;
    for i:=0 to aCount-1 do begin   //Line внутри Area ?
     aLineE:=aAreaP.Lines.Item[i];
     aLine:=aLineE as ILine;
     C0:=aLine.C0;
     C1:=aLine.C1;
     if (C0=Nn)or(C1=Nn) then
      FlagN:=True;
     if (C0=Nk)or(C1=Nk) then
      FlagK:=True;
     if FlagN and FlagK then
      break;
    end;    //for

    if not(FlagN and FlagK) then Exit;

    k:=0;
    i:=0;
    while i<aCount do begin
     aLineE:=aAreaP.Lines.Item[i];
     aLine:=aLineE as ILine;
     C0:=aLine.C0;
     C1:=aLine.C1;
     if C0=Nn then begin
       (aCollection as IDMCollection2).Add(aLineE);
        if C1=Nk then
          break;
        Nn:=C1;
     end else
       if C1=Nn then begin
         (aCollection as IDMCollection2).Add(aLineE);
          if C0=Nk then
            break;
          Nn:=C0;
       end;
     if i<aCount-1 then
       inc(i)
     else 
      if k<(aCount*aCount) then begin //разрыв цепоч.(нач.не соед.с конц.)
       i:=0;
       inc(k);     //+ проход
      end else
        Exit;
    end; //while

    SpatialModel2:=Get_DataModel as ISpatialModel2;

    AddElement( AreaE.Parent,
                      SpatialModel2.Areas, '', ltOneToMany, AreaU, True);

    NewAreaE:=AreaU as IDMElement;

    for i:=0 to aCollection.Count-1 do begin
     aLineE:=aCollection.Item[i];
     aLine:=aLineE as ILine;
     aLineE.AddParent(NewAreaE);
     aLineE.RemoveParent(AreaE);
    end;    //for

    LineE.AddParent(AreaE);
    LineE.AddParent(NewAreaE);

  end; //procedure DivArea

  procedure DivVolume(LinesVolumes:IDMCollection);
   //--------------
   // По сп.LinesVolumes(Line/Volume0/Area/Volume)разделить Volume0E,
   // создав NewAreaE.
   //--------------

   procedure Processing(const Lines:IDMCollection;
                         Volume0E,VolumeE,AreaE:IDMElement;
                         out NewAreaE,NewVolumeE:IDMElement);
   //--------------
   // Созд.NewAreaE из Lines/Volume0E, пересекаемого AreaE/VolumeE.
   // По NewAreaE разделить Volume0E, NewVolumeE.
   //--------------
   var
    SpatialModel2:ISpatialModel2;
    aLineE:IDMElement;
    aParent1E:IDMElement;
    aParent2E:IDMElement;
    aAreaE:IDMElement;
    Area,aArea,NewArea:IArea;
    Volume0,Volume,NewVolume:IVolume;
    aLine:ILine;
    aCollection1:IDMCollection;
    aCollection2:IDMCollection;
    aCollection3:IDMCollection;
    aLines:IDMCollection;
    AreaU:IUnknown;
    VolumeU:IUnknown;
    Flag:boolean;
    j,k,l:integer;
   begin
      if ReorderLines(Lines)=0 then begin
       aCollection1:=DataModel.CreateCollection(-1, nil); //плоск.внизу
       aCollection2:=DataModel.CreateCollection(-1, nil); //плоск.вверху
       aCollection3:=DataModel.CreateCollection(-1, nil); //плоск.неопред.
       for j:=0 to Lines.Count-1 do begin
        aLineE:=Lines.Item[j];
        aLine:=aLineE as ILine;
        aParent1E:=aLineE.Parents.Item[0];
        aParent2E:=aLineE.Parents.Item[1];
        if(aParent1E as IArea).MaxZ<(aParent2E as IArea).MaxZ then begin
          (aCollection1  as IDMCollection2).Add(aParent1E);
          (aCollection2  as IDMCollection2).Add(aParent2E);
        end else
           if (aParent1E as IArea).MaxZ=(aParent2E as IArea).MaxZ  then  begin
            (aCollection3  as IDMCollection2).Add(aParent1E);
            (aCollection3  as IDMCollection2).Add(aParent2E);
           end else begin
            (aCollection1  as IDMCollection2).Add(aParent2E);
            (aCollection2  as IDMCollection2).Add(aParent1E);
           end;
       end;    //for

//проверить с какими плоск.соседств.неопред.плоск.и включ.в aCollection1 или aCollection2
       for j:=0 to aCollection3.Count-1 do begin
        aParent1E:=aCollection3.Item[j];
        aLines:=(aParent1E as IPolyLine).Lines;
        Flag:=False;
        for k:=0 to aLines.Count-1 do begin
         aLineE:=aLines.Item[k];
         for l:=0 to aLineE.Parents.Count-1 do begin
          aParent2E:=aLineE.Parents.Item[l];;
          if aCollection1.IndexOf(aParent2E)<>-1 then begin
           (aCollection1  as IDMCollection2).Add(aParent1E);
            Flag:=True;
            break;
          end else
           if aCollection2.IndexOf(aParent2E)<>-1 then begin
            (aCollection2  as IDMCollection2).Add(aParent1E);
             Flag:=True;
             break;
           end;
         end;    //for l
         if Flag then
           break;
        end;    //for k
        if not Flag then
         (aCollection2  as IDMCollection2).Add(aParent1E);
      end;    //for j


       SpatialModel2:=Get_DataModel as ISpatialModel2;

       AddElement(Lines.Item[0].Parents.Item[0].Parent,
                      SpatialModel2.Areas, '', ltOneToMany, AreaU, True);

       NewAreaE:=AreaU as IDMElement;
       NewArea:=NewAreaE as IArea;


       NewAreaE.Ref:=CreateClone(AreaE.Ref) as IDMElement;

       for j:=0 to Lines.Count-1 do begin
        aLineE:=Lines.Item[j];
        aLine:=aLineE as ILine;
        aLineE.AddParent(NewAreaE);
       end;    //for

       UpdateElement(NewAreaE);
       UpdateCoords(NewAreaE);


       AddElement(NewAreaE.Parent,SpatialModel2.Volumes, '', ltOneToMany, VolumeU, True);

       NewVolumeE:=VolumeU as IDMElement;
       NewVolume:=NewVolumeE as IVolume;

       Area:=AreaE as IArea;
       Volume:=VolumeE as IVolume;
{       if not(Area.IsVertical)then begin //если горзонт.-Ref нижн.объема
        aVolume1E:=Area.Volume1 as IDMElement;
        if aVolume1E<>nil then
         NewVolumeE.Ref:=CreateClone(aVolume1E.Ref);
       end else }
        NewVolumeE.Ref:=CreateClone(VolumeE.Ref) as IDMElement;


       Volume0:=Volume0E as IVolume;
       NewArea.Volume0IsOuter:=False;
       NewArea.Volume0:=Volume0;
       NewArea.Volume1IsOuter:=False;
       NewArea.Volume1:=NewVolume;


       for j:=0 to aCollection1.Count-1 do begin
        aAreaE:=aCollection1.Item[j];
        aArea:=aAreaE as IArea;
        if aArea.Volume0=Volume0 then begin
          aArea.Volume0IsOuter:=False;
          aArea.Volume0:=NewVolume
        end else
        if aArea.Volume1=Volume0 then begin
           aArea.Volume1IsOuter:=False;
           aArea.Volume1:=NewVolume;
        end;
       end;    //for j
       UpdateElement(Volume0E);
       UpdateCoords(Volume0E);
       UpdateElement(NewVolumeE);
       UpdateCoords(NewVolumeE);

      end;

   end; //procedure Processing

  var
   aVolume0E,aVolumeE, aVolume01E,aVolume1E:IDMElement;
   aAreaE,aArea1E:IDMElement;
   aLineE:IDMElement;
   NewAreaE,NewVolumeE:IDMElement;
   aLines:IDMCollection;
   i,aCount:integer;
  begin
   aCount:=LinesVolumes.Count;
   if aCount=0  then Exit;
   {B aLines отобрать линии по одному aVolume01E и разделить его}
   aLines:=DataModel.CreateCollection(-1, nil);
   aVolume0E:=LinesVolumes.Item[1];
   aAreaE:=LinesVolumes.Item[2];
   aVolumeE:=LinesVolumes.Item[3];
   i:=0;
   while i<aCount do begin
    aLineE:=LinesVolumes.Item[i];       //линия aLineE
    aVolume01E:=LinesVolumes.Item[i+1]; //из обл. aVolume01E
    aArea1E:=LinesVolumes.Item[i+2];    //образована пересечением с плоск.aArea1E
    aVolume1E:=LinesVolumes.Item[i+3];  //из обл.aVolume1E
    if (aVolume01E=aVolume0E)
        and(aArea1E=aAreaE)
         and(aVolume1E=aVolumeE) then
     (aLines  as IDMCollection2).Add(aLineE)
    else
     if aLines.Count<>0 then begin
      Processing(aLines,aVolume0E,aVolumeE,aAreaE,NewAreaE,NewVolumeE); //раздел.
      (aLines  as IDMCollection2).Clear;
      (aLines  as IDMCollection2).Add(aLineE);
      aVolume0E:=aVolume01E;
      aAreaE:=aArea1E;
      aVolumeE:=aVolume1E;
     end;
    inc(i,4);
    if (aLines.Count<>0)and(not(i<aCount)) then begin
     Processing(aLines,aVolume0E,aVolumeE,aAreaE,NewAreaE,NewVolumeE); //раздел.
     (aLines  as IDMCollection2).Clear;
    end;
   end; //while

  end; //procedure DivVolume


  procedure CheckVolume(var MainAreasLines,AllAreas0,AllAreas:IDMCollection);
  var
   SpatialModel:ISpatialModel;
   SpatialModel2:ISpatialModel2;
   j,k,i,m,l,n,p:integer;
   VolumeE:IDMElement;
   Volume0E,Volume1E,Volume2E:IDMElement;
   aVolumeE:IDMElement;
   aVolume0E:IDMElement;
   aAreaE :IDMElement;
   aArea  :IArea;
   aAreaP :IPolyLine;
   Area0P :IPolyLine;
   aArea0P:IPolyLine;
   aArea12P:IPolyLine;
   aLine1E:IDMElement;
   aArea1P:IPolyLine;
   aLineE:IDMElement;
   aLine:ILine;
   aLine0E:IDMElement;
   aLine0:ILine;
   C0:ICoordNode;
   C1:ICoordNode;
   aNode:ICoordNode;
   aNodeE:IDMElement;
   aNode1:ICoordNode;
   aNode1E:IDMElement;
   aNode2:ICoordNode;
   aTopNode:ICoordNode;
   aTopNodeE:IDMElement;
   aNode2E:IDMElement;
   NewNode:ICoordNode;
   NewNodeE:IDMElement;
   NewLine1E:IDMElement;
   NewLine2E:IDMElement;
   NewLinePrevE:IDMElement;
   NewLine1:ILine;
   NewLine2:ILine;
   NewLinePrev:ILine;
   VLineE:IDMElement;
   VLine:ILine;
   aParentE:IDMElement;
   Areas0:IDMCollection;
   Nodes0:IDMCollection;
   Nodes:IDMCollection;
   Lines0:IDMCollection;
   LinesA:IDMCollection;
   Lines:IDMCollection;
   SourceLines:IDMCollection;
   aLines:IDMCollection;
   NewLines:IDMCollection;
   ForDelLines:IDMCollection;
   ForNewLines:IDMCollection;
   ForNewVLines:IDMCollection;
   NewBotLines:IDMCollection;
   NewTopLines:IDMCollection;
   ForNewAreasLines:IDMCollection;
   Volumes,aVolumes,bVolumes:IDMCollection;
   Areas,aAreas,bAreas,aAreas0:IDMCollection;
   aAdditionalParents:IDMCollection;
   aCollection:IDMCollection;
   aCollection1:IDMCollection;
   aCollNodeProces:IDMCollection;
   aTmpCollection:IDMCollection;
   aLinesVolumes:IDMCollection;
   x,y,z:double;
   x1,y1,z1:double;
   x2,y2,z2:double;
   x3,y3,z3:double;
   x4,y4,z4:double;
   p1x,p1y,p1z,p2x,p2y,p2z:double;
   Flag:boolean;
   Stat,FlagArea,aCount:integer;
   aVolume,aVolume0:IVolume;
   Volume1,Volume2 :IVolume;
   Area0E,AreaE,Area1E,Area2E:IDMElement;
   aArea0E,aArea1E,aArea2E,aNewAreaE:IDMElement;
   Area0,aArea0,aArea1,aArea2,aNewArea:IArea;
   Area,Area1,Area2:IArea;
   VAreaE:IDMElement;
   VArea:IArea;
   LineU:IUnknown;
   FlagLine:boolean;
   Debug,ID1,ID2:integer;
   aUpVolumRefRef,aLowVolumRefRef:IDMElement;
   aVolumH,aUpVolumH,aLowVolumH:double;
   aVolumSpecLayer,aUpVolumSpecLayer,aLowVolumSpecLayer:Wordbool;
   aSpecialType1, aSpecialType2:WordBool;
  begin
   Nodes0:=DataModel.CreateCollection(-1, nil);
   Nodes:=DataModel.CreateCollection(-1, nil);
   Volumes:=DataModel.CreateCollection(-1, nil);
   aVolumes:=DataModel.CreateCollection(-1, nil);
   aAreas:=DataModel.CreateCollection(-1, nil);
   SourceLines:=DataModel.CreateCollection(-1, nil);
   NewLines:=DataModel.CreateCollection(-1, nil);
   ForNewLines:=DataModel.CreateCollection(-1, nil);
   ForDelLines:=DataModel.CreateCollection(-1, nil);
   ForNewVLines:=DataModel.CreateCollection(-1, nil);
   aCollNodeProces:=DataModel.CreateCollection(-1, nil);
   aTmpCollection:=DataModel.CreateCollection(-1, nil);
   ForNewAreasLines:=DataModel.CreateCollection(-1, nil);
   aCollection:=DataModel.CreateCollection(-1, nil);
   aLinesVolumes:=DataModel.CreateCollection(-1, nil);

   SpatialModel:=Get_DataModel as ISpatialModel;
   SpatialModel2:=SpatialModel as ISpatialModel2;

   //________________________________{пересеч. Lines0 с Lines}

  (Nodes as IDMCollection2).Clear;
  (Nodes0 as IDMCollection2).Clear;

   p:=0;
   while p<AllAreas.Count do begin
    aAreaE:=AllAreas.Item[p];
    aArea:=aAreaE as IArea;
    aAreaP:=aAreaE as IPolyLine;
    ExtractAreaLines(MainAreasLines,SourceLines,aAreaE);//исх.копию aAreaP->SourceLines,
    inc(p,2);
    j:=0;
    while j<AllAreas0.Count do begin
     aArea0E:=AllAreas0.Item[j];
     aArea0:=aArea0E as IArea;
     inc(j,2);
                                      {aArea-aArea0 пересекаются ?}
     aArea0P:=aArea0E as IPolyLine;
     k:=0;
     while k<aArea0P.Lines.Count do begin
      Lines0:=aArea0P.Lines;
      aLine0:=Lines0.Item[k] as ILine;
      inc(k);
      i:=0;
      aAreaP:=aAreaE as IPolyLine;
      while i<aAreaP.Lines.Count do begin
       aLine:=aAreaP.Lines.Item[i] as ILine;
       inc(i);
       NewLine1:=nil;
       NewLine2:=nil;
       CheckCrossingLines(aLine0,aLine,aArea0,aArea,Nodes,NewLine1,NewLine2,NewNode);
       if NewLine1<>nil then begin
        NewLine1E:=NewLine1 as IDMElement;
        if NewLines.IndexOf(NewLine1E)=-1 then
         (NewLines as IDMCollection2).Add(NewLine1E);
       end; //if NewLine1<>nil
       if NewLine2<>nil then begin
        NewLine2E:=NewLine2 as IDMElement;
        if NewLines.IndexOf(NewLine2E)=-1 then
         (NewLines as IDMCollection2).Add(NewLine2E);
       end; //if NewLine2<>nil
       if NewNode<>nil then begin
        NewNodeE:=NewNode as IDMElement;
        if (Nodes.IndexOf(NewNodeE)=-1)
            and(CheckCoordNode(Nodes,NewNode.X,NewNode.Y,NewNode.Z)=nil)then
          (Nodes as IDMCollection2).Add(NewNodeE);
       end; //if NewNode<>nil
      end; //while i
     end; //while k<aArea0P.Lines.Count
    end; //while j
   end; //while p<Areas.Count

   //  лин.из окружения (сп.AllAreas) по месту целиком в Area0 - будут удаляться
  (ForDelLines as IDMCollection2).Clear;
   p:=0;
   while p<AllAreas.Count do begin
    AreaE:=AllAreas.Item[p];
    Area:=AreaE as IArea;
    aAreaP:=AreaE as IPolyLine;
    aLines:=aAreaP.Lines;
    aVolumeE:=AllAreas.Item[p+1];  // ?
    inc(p,2);
    for k:=0 to aLines.Count-1 do begin
     aLineE:=aLines.Item[k];
     if (aTmpCollection as IDMCollection).IndexOf(aLineE)=-1 then begin
      (aTmpCollection as IDMCollection2).Add(aLineE);
      aLine:=aLineE as ILine;
      aCollection:=LinesContaining(aLine,AllAreas0,AllAreas,aAreas);
      for l:=0 to aCollection.Count-1 do begin
       aArea0E:=aCollection.Item[l];
       if aArea0E<>nil then begin {где линия по месту}
        aArea0:=aArea0E as IArea;;
        for i:=0 to aAreas.Count-1 do begin
         aAreaE:=aAreas.Item[i];
         if ((aArea0.MaxZ=aLine.C0.Z)and(aArea0.MaxZ=aLine.C1.Z))
           or((aArea0.MinZ=aLine.C0.Z)and(aArea0.MinZ=aLine.C1.Z))
           or((aArea0.MaxZ=aLine.C0.Z)and(aArea0.MinZ=aLine.C1.Z))
           or((aArea0.MinZ=aLine.C0.Z)and(aArea0.MaxZ=aLine.C1.Z))then begin
            {лин.из сп.aArea по месту целиком в aArea0 и в одном уровне}
          (ForDelLines as IDMCollection2).Add(aLineE); // добавить в список
          (ForDelLines as IDMCollection2).Add(aAreaE); // добавить в список
         end;
        end;    //for i
       end;    // if
      end;    //for l
     end;
    end;    //for k
   end;    //p

  {линии по месту целиком в aArea0, удаляемые из горизонт., посмотреть среди верт.плоск.}
   p:=0;
   while p<AllAreas.Count do begin
    aAreaE:=AllAreas.Item[p];
    aArea:=AreaE as IArea;
    aAreaP:=AreaE as IPolyLine;
    aLines:=aAreaP.Lines;
    aVolumeE:=AllAreas.Item[p+1];   // ?
    inc(p,2);
    i:=0;
    while i<ForDelLines.Count do begin
     aLineE:=ForDelLines.Item[i];
     if ((aArea.IsVertical=True)
         and(aLines.IndexOf(aLineE)<>-1)) then begin
      (ForDelLines as IDMCollection2).Add(aLineE); // добавить в список
      (ForDelLines as IDMCollection2).Add(aAreaE); // добавить в список
       break;
     end;
     inc(i);
    end; //while
   end;    //p

 (Nodes0 as IDMCollection2).Clear;
  i:=0;
  while i<aCollNodeProces.Count do begin
     aNode1:=aCollNodeProces.Item[i] as ICoordNode;
     aNode2:=aCollNodeProces.Item[i+1] as ICoordNode;
     aArea0E:=aCollNodeProces.Item[i+2];
     aAreaE :=aCollNodeProces.Item[i+3];
     Lines0:=(aArea0E as IPolyLine).Lines;
     NodesProcessing(aNode1,aNode2,NewLines,ForNewLines,AllAreas0,
                       aAreaE,aArea0E,aVolume0E,aNewAreaE,NewLine2E);
     inc(i,4);
  end; //while



   //________________________________{пересеч. Areas0 с Areas}

 (Nodes0 as IDMCollection2).Clear;

   p:=0;
   while p<AllAreas.Count do begin
    aAreaE:=AllAreas.Item[p];
    aArea:=aAreaE as IArea;
    aAreaP:=aAreaE as IPolyLine;
    aVolumeE:=AllAreas.Item[p+1];
    aVolume:=aVolumeE as IVolume;

    SpatialModel2.GetUpperLowerVolumeParams(aVolumeE.Ref,
                                            aUpVolumRefRef,
                                            aLowVolumRefRef,
                                            aVolumH,aUpVolumH,aLowVolumH,
//                                            aVolumSpecLayer,
                                            aUpVolumSpecLayer,
                                            aLowVolumSpecLayer,
                                            aSpecialType1);  //опред.Params aVolumeE

    aLines:=aAreaP.Lines;
    inc(p,2);

    j:=0;
    while j<AllAreas0.Count do begin
     aArea0E:=AllAreas0.Item[j];
     aArea0:=aArea0E as IArea;
     aArea0P:=aArea0E as IPolyLine;
     Lines0:=aArea0P.Lines;
     aVolume0E:=AllAreas0.Item[j+1];
     aVolume0:=aVolume0E as IVolume;
     inc(j,2);

     (Nodes0 as IDMCollection2).Clear;
                                      {aArea-aArea0 пересекаются ? }

     ExtractAreaLines(MainAreasLines,SourceLines,aAreaE);//исх.копию aAreaP->SourceLines,
     if CrossingArea(aArea0,aArea,p1x,p1y,p1z,p2x,p2y,p2z)then begin
       aArea0P:=aArea0E as IPolyLine;           {линия пересеч.-(p1x,..) - (p2x,..)}
       k:=0;
       SpatialModel2.GetUpperLowerVolumeParams(aVolume0E.Ref,aUpVolumRefRef,aLowVolumRefRef,
                              aVolumH,aUpVolumH,aLowVolumH,
//                             aVolumSpecLayer,
                             aUpVolumSpecLayer,aLowVolumSpecLayer,
                             aSpecialType2); //опред.Params aVolume0E


       while k<aArea0P.Lines.Count do begin
        Lines0:=aArea0P.Lines;
        aLine0:=Lines0.Item[k] as ILine;
        inc(k);
//        x1:=aLine0.C0.X;
//        y1:=aLine0.C0.Y;
//        z1:=aLine0.C0.Z;
//        x2:=aLine0.C1.X;
//        y2:=aLine0.C1.Y;             {aLine-(px1,.. - p2x,..) пересекаются ?}
//        z2:=aLine0.C1.Z;

        if CrossinAreaOfLine(aArea,SourceLines,aLine0,x,y,z) then begin{пересеч.внутри aLine0 ?}
         NewNodeE:=nil;
         NewNodeE:=CheckCoordNode(Nodes,x,y,z);
         if NewNodeE=nil then begin
          NewNode:=CheckCoordOfLine(aLine0,X,Y,Z,nil,NewLine1,NewLine2);
          NewNodeE:=NewNode as IDMElement;
         end;
         if NewNodeE<>nil then begin
          if Nodes.IndexOf(NewNodeE)=-1 then
            (Nodes as IDMCollection2).Add(NewNodeE); //в спис.всех нов.точ.Volume
          if Nodes0.IndexOf(NewNodeE)=-1 then
            (Nodes0 as IDMCollection2).Add(NewNodeE);//в спис.нов.точ.Area
         end;     //if NewNodeE<>nil
        end;     //if CrossinAreaOfLine
       end;     //while k<aArea0P.Lines.Count

      if Nodes0.Count<2 then begin
        (Nodes0 as IDMCollection2).Clear;
        NodesCount(aArea0P.Lines, Nodes0, p1x,p1y,p1z, p2x,p2y,p2z);
      end;

      if Nodes0.Count=2 then begin
         aNode1:=Nodes0.Item[0] as ICoordNode;
         aNode2:=Nodes0.Item[1] as ICoordNode;
         NodesProcessing(aNode1,aNode2,NewLines,ForNewLines, AllAreas0,
                         aAreaE,aArea0E,aVolume0E,aNewAreaE,NewLine2E);
         (Nodes0 as IDMCollection2).Clear;

         if ((aVolume.BottomAreas as IDMCollection).IndexOf(aAreaE)<>-1) and
            aSpecialType1 and aSpecialType2 then begin //откр.зоны
            (ForNewAreasLines as IDMCollection2).Add(NewLine2E);//в спис.
            (aLinesVolumes as IDMCollection2).Add(NewLine2E);   //в спис.
            (aLinesVolumes as IDMCollection2).Add(aVolume0E);   //в спис.
            (aLinesVolumes as IDMCollection2).Add(aAreaE);      //в спис.
            (aLinesVolumes as IDMCollection2).Add(aVolumeE);    //в спис.
         end;
      end;
     end;     //if CrossingArea
    end;     //while j<AllAreas0
   end;     //while p<AllAreas.Count


//____________________
  l:=0;
  while l<ForNewLines.Count do begin   {линия }
   aLineE:=ForNewLines.Item[l];
   aArea0E:=ForNewLines.Item[l+1];
   aAreaE:=ForNewLines.Item[l+3];
   if (aLineE.Parents.IndexOf(aAreaE)=-1) then begin
    aArea0:=aArea0E as IArea;
    Volume0E:=aArea0.Volume0 as IDMElement;
    Volume1E:=aArea0.Volume1 as IDMElement;
    if (not({(aArea0.IsVertical=True)
         and}(((Volume0E<>nil)and(Volume0E.Ref.Ref.Parent.ID=0))
            or((Volume1E<>nil)and(Volume1E.Ref.Ref.Parent.ID=0)))))
        or(((Volume0E<>nil)and(Volume1E<>nil))and
            ((Volume0E.Ref.Ref.Parent.ID=1)
               or(Volume1E.Ref.Ref.Parent.ID=1)))then begin
       aLineE.AddParent(aAreaE);
    end else
     if (ForNewVLines as IDMCollection).IndexOf(aLineE)=-1 then begin
           (ForNewVLines as IDMCollection2).Add(aLineE);
           (ForNewVLines as IDMCollection2).Add(aAreaE);
     end;
   end;  //if

  inc(l,4);
  end;    //while

  for j:=0 to AllAreas0.Count-1 do begin
   aArea0E:=AllAreas0.Item[j];
   UpdateElement( aArea0E);
   UpdateCoords( aArea0E);
  end;

   l:=0;
   while l<ForDelLines.Count do begin   {линия удалялась из сп.aArea ?}
     aLineE:=ForDelLines.Item[l];
     aAreaE:=ForDelLines.Item[l+1];
     i:=0;
     while i<aLineE.Parents.Count do begin
      aAreaE:=aLineE.Parents.Item[i];
      if (AllAreas as IDMCollection).IndexOf(aAreaE)<>-1 then
        aLineE.RemoveParent(aAreaE)  //удалить из aArea
      else
       inc(i);
     end; //while
     inc(l,2);
   end;    //while

   if ForNewVLines.Count>0 then begin
    repeat      //раздел.верт.плоск.
     l:=0;
     (aTmpCollection as IDMCollection2).Clear;
     aArea1E:=ForNewVLines.Item[1];
     while l<ForNewVLines.Count do begin
       aLineE:=ForNewVLines.Item[l];
       aAreaE:=ForNewVLines.Item[l+1];
       if aAreaE=aArea1E then begin
        (aTmpCollection as IDMCollection2).Add(aLineE); //лин.для плоск. aArea1E
        (ForNewVLines as IDMCollection2).Delete(l);
        (ForNewVLines as IDMCollection2).Delete(l);
       end else
       inc(l,2);
     end;    //while

     l:=0;
     (aAreas as IDMCollection2).Clear;
     (aAreas as IDMCollection2).Add(aArea1E);
     while l<aTmpCollection.Count do begin        //обраб. плоск. aArea1E
      aLineE:=aTmpCollection.Item[l];
      aNewAreaE:=nil;
      for j:=0 to aAreas.Count-1 do begin
       aAreaE:=aAreas.Item[j];
       DivArea(aLineE,aAreaE,aNewAreaE);
       if aNewAreaE<>nil then begin
        if (AllAreas  as IDMCollection).IndexOf(aNewAreaE)=-1 then
         (AllAreas as IDMCollection2).Add(aNewAreaE);
         (aAreas as IDMCollection2).Add(aNewAreaE);
         break;
        end;
       end;    //for
       inc(l);
     end;    //while

    until  ForNewVLines.Count=0 ;       //обраб.все плоск.
   end;    //ForNewVLines.Count>0

   DivVolume(aLinesVolumes);

   for j:=0 to AllAreas.Count-1 do begin
    aAreaE:=AllAreas.Item[j];
    UpdateElement( aAreaE);
    UpdateCoords( aAreaE);
   end;


  (Nodes0 as IDMCollection2).Clear;
  (Nodes as IDMCollection2).Clear;
  (Volumes as IDMCollection2).Clear;
  (aVolumes as IDMCollection2).Clear;
  (aAreas as IDMCollection2).Clear;
  (NewLines as IDMCollection2).Clear;
  (ForNewLines as IDMCollection2).Clear;
  (ForDelLines as IDMCollection2).Clear;

  end;


  function DefineExterInterAreas(const VolumeE:IDMElement;
                         var ExternalAreas,InternalAreas:IDMCollection;
                             Flag:boolean):boolean ;
  {В  Volume определить внешние(охватыв.)Area и внутренние
  запись -aAreaE + aVolumeE
  Для открытых зон внутренние Area принимаются как внешние
  Flag -не проверять/провер. "прозрачность"(..Ref.Parent.ID=1/0)
  result=True,если  InternalAreas.Count>0    }
  var
   aVolume:IVolume;
   aAreaE:IDMElement;
   aArea:IArea;
   k,i:integer;
  begin
    aVolume:=VolumeE as IVolume ;
    for k:=0 to aVolume.Areas.Count-1 do begin
       aAreaE:=aVolume.Areas.Item[k];
       if (ExternalAreas as IDMCollection).IndexOf(aAreaE)=-1 then begin
         (ExternalAreas as IDMCollection2).Add(aAreaE);
         (ExternalAreas as IDMCollection2).Add(VolumeE);
       end else begin
          aArea:=aAreaE as IArea;
          i:=(ExternalAreas as IDMCollection).IndexOf(aAreaE);
          if Flag
             or(((aArea.Volume0 as IDMElement).Ref.Ref.Parent.ID=1)
                  and((aArea.Volume1 as IDMElement).Ref.Ref.Parent.ID=1)) then begin
           (ExternalAreas as IDMCollection2).Delete(i);
           (ExternalAreas as IDMCollection2).Delete(i);
           (InternalAreas as IDMCollection2).Add(aAreaE);
           (InternalAreas as IDMCollection2).Add(VolumeE);
          end else begin
           (ExternalAreas as IDMCollection2).Add(aAreaE);
           (ExternalAreas as IDMCollection2).Add(VolumeE);
          end;
       end;
    end;    //for

    Result:=(InternalAreas.Count>0)

  end; //function DefineExterInterAreas

  procedure SortVolumesByZ(CurrentVolumes:IDMCollection);
  var
   aVolume1:IVolume;
   aVolume2:IVolume;
   Zm1,Zmin1:double;
   Zm2,Zmin2:double;
   j,k:integer;
   Flag:boolean;
  begin
   repeat
    Flag:=True;
    for j:=0 to CurrentVolumes.Count-2 do begin
      aVolume1:=CurrentVolumes.Item[j] as IVolume ;
      Zmin1:=1E12;
      for k:=0 to aVolume1.BottomAreas.Count-1 do begin
       Zm1:=(aVolume1.BottomAreas.Item[k] as IArea).MinZ;
       if Zm1<Zmin1 then
         Zmin1:=Zm1;
      end;    //for
      aVolume2:=CurrentVolumes.Item[j+1] as IVolume ;
      Zmin2:=1E12;
      for k:=0 to aVolume2.BottomAreas.Count-1 do begin
       Zm2:=(aVolume2.BottomAreas.Item[k] as IArea).MinZ;
       if Zm2<Zmin2 then
         Zmin2:=Zm2;
      end;    //for

      if Zmin2<Zmin1 then begin
       (CurrentVolumes as IDMCollection2).Delete(j+1);
       (CurrentVolumes as IDMCollection2).Insert(j,aVolume2 as IDMElement);
        Flag:=False;
      end;
    end    //for k

   until Flag=True  ;

 end; //procedure SortVolumesByZ
 procedure ExtractAreas(const SelectVolumes,AllAreas0:IDMCollection;
                    var AllAreas,MainAreasLines:IDMCollection);
 //--------------------------------------------------------------------------
 // Возвращает сп.плоск.окружения(AllAreas),связан.с внешн.плоск.выделенных об.
 // В MainAreasLines список плоск.с CopyLines -копии исходных полилиний AllAreas
 //---------------------------------------------------------------------------
 var
  SpatialModel2:ISpatialModel2;
  aVolumeE:IDMElement;
  aAreaE  :IDMElement;
  aLineE  :IDMElement;
  aAreaP  :IPolyLine;
  aLine   :ILine;
  aVolumes:IDMCollection;
  aVolumeAreas  :IDMCollection;
  Tmp     :IDMCollection;
  aAreas  :IDMCollection;
  C0,C1   :ICoordNode;
  j,k,l :integer;
 begin
   SpatialModel2:=Get_DataModel as ISpatialModel2;

   AllAreas     :=DataModel.CreateCollection(-1, nil);
   aVolumes     :=DataModel.CreateCollection(-1, nil);
   aAreas       :=DataModel.CreateCollection(-1, nil);
   aVolumeAreas :=DataModel.CreateCollection(-1, nil);
   Tmp          :=DataModel.CreateCollection(-1, nil);

   j:=0;
   while j<AllAreas0.Count do begin
    aAreaE:=AllAreas0.Item[j];
    if not((aAreaE as IArea).IsVertical) then begin
     aAreaP:=aAreaE as IPolyLine;
     for k:=0 to aAreaP.Lines.Count-1 do begin
      aLineE:=aAreaP.Lines.Item[k];
      aLine:=aLineE as ILine;
      C0:=aLine.C0;
      (aVolumes as IDMCollection2).Clear;
      (aAreas as IDMCollection2).Clear;

      SpatialModel2.GetColVolumeContaining(C0.X,C0.Y,C0.Z,aAreas,aVolumes);
      for l:=0 to aVolumes.Count-1 do begin
       aVolumeE:=aVolumes.Item[l];
       aAreaE:=aAreas.Item[l];
       if ((SelectVolumes as IDMCollection).IndexOf(aVolumeE)=-1) {не SelectVolumes }
           and((AllAreas as IDMCollection).IndexOf(aAreaE)=-1) then begin
        (AllAreas as IDMCollection2).Add(aAreaE);
        (AllAreas as IDMCollection2).Add(aVolumeE);
       end;
      end; //l
      C1:=aLine.C1;
      (aVolumes as IDMCollection2).Clear;
      (aAreas as IDMCollection2).Clear;

      SpatialModel2.GetColVolumeContaining(C1.X,C1.Y,C1.Z,aAreas,aVolumes);
      for l:=0 to aVolumes.Count-1 do begin
       aVolumeE:=aVolumes.Item[l];
       aAreaE:=aAreas.Item[l];
       if ((SelectVolumes as IDMCollection).IndexOf(aVolumeE)=-1) {не SelectVolumes }
           and((AllAreas as IDMCollection).IndexOf(aAreaE)=-1) then begin
         (AllAreas as IDMCollection2).Add(aAreaE);
         (AllAreas as IDMCollection2).Add(aVolumeE);
        end;
       end; //l
     end; //k
    end;
    inc(j,2);
   end; //while

  k:=1;
  while k<AllAreas.Count do begin
   aVolumeE:=AllAreas.Item[k];
   DefineExterInterAreas(aVolumeE,Tmp,aVolumeAreas,True);
   inc(k,2);
  end; //while
  k:=0;
  while k<aVolumeAreas.Count do begin
   aAreaE:=aVolumeAreas.Item[k];
   aVolumeE:=aVolumeAreas.Item[k+1];
   if ((aAreaE as IArea).IsVertical)
      and((AllAreas as IDMCollection).IndexOf(aAreaE)=-1)then begin
    (AllAreas as IDMCollection2).Add(aAreaE);
    (AllAreas as IDMCollection2).Add(aVolumeE);
   end;
   inc(k,2);
  end; //while

  AddInMainAreasLines(AllAreas,MainAreasLines);

 end; //procedure


var
 SpatialModel2  :ISpatialModel2;
 SelectedVolumes:IDMCollection;
 CurrentVolumes :IDMCollection;
 aVolumes       :IDMCollection;
 ExternalAreas  :IDMCollection;
 InternalAreas  :IDMCollection;
 MainAreasLines :IDMCollection;
 OpenVolumes    :IDMCollection;
 ClosedVolumes  :IDMCollection;
 AllAreas0      :IDMCollection;
 AllAreas       :IDMCollection;
 SelectedElement:IDMElement;
 SelectedVolumeE:IDMElement;
 aCurrentVolumeE:IDMElement;
 SelectedVolume :IVolume;
 j,k            :integer;
begin
  if Get_SelectionCount=0 then Exit;

  StartTransaction(nil, leoAdd, rsBuildVolume);
  //составить спис.всех выделен.Volumes

  DataModel:=Get_DataModel as IDataModel;
  SpatialModel2:=Get_DataModel as ISpatialModel2;

  SelectedVolumes:=DataModel.CreateCollection(-1, nil);
  CurrentVolumes :=DataModel.CreateCollection(-1, nil);
  OpenVolumes    :=DataModel.CreateCollection(-1, nil);
  ClosedVolumes  :=DataModel.CreateCollection(-1, nil);
  aVolumes       :=DataModel.CreateCollection(-1, nil);
  for j:=0 to Get_SelectionCount-1 do begin
    SelectedElement:=Get_SelectionItem(j) as IDMElement;
    if SelectedElement.ClassID=_Volume then begin
     SelectedVolumeE:=SelectedElement;
     SelectedVolume:=SelectedVolumeE as IVolume;
     if SelectedVolume.Areas.Count=0 then begin  //если Volumes вложенные
        (aVolumes as IDMCollection2).Clear;
        SpatialModel2.GetInnerVolumes(SelectedVolumeE,aVolumes);
        for k:=0 to aVolumes.Count-1 do begin
          aCurrentVolumeE:=aVolumes.Item[k];
          if SelectedVolumeE.Ref.Ref.Parent.ID=1 then begin //закрытая зона
           if(ClosedVolumes as IDMCollection).IndexOf(aCurrentVolumeE)=-1 then
            (ClosedVolumes as IDMCollection2).Add(aCurrentVolumeE);
           if(SelectedVolumes as IDMCollection).IndexOf(aCurrentVolumeE)=-1 then
            (SelectedVolumes as IDMCollection2).Add(aCurrentVolumeE);
          end else begin  //открытая зона
           if(OpenVolumes as IDMCollection).IndexOf(aCurrentVolumeE)=-1 then
            (OpenVolumes as IDMCollection2).Add(aCurrentVolumeE);
           if(SelectedVolumes as IDMCollection).IndexOf(aCurrentVolumeE)=-1 then
            (SelectedVolumes as IDMCollection2).Add(aCurrentVolumeE);
           end;
        end    //for k
      end else
        if SelectedVolumeE.Ref.Ref.Parent.ID=1 then begin //закрытая зона
           if (ClosedVolumes as IDMCollection).IndexOf(SelectedVolumeE)=-1 then
            (ClosedVolumes as IDMCollection2).Add(SelectedVolumeE);
           if(SelectedVolumes as IDMCollection).IndexOf(SelectedVolumeE)=-1 then
            (SelectedVolumes as IDMCollection2).Add(SelectedVolumeE);
        end else begin  //открытая зона
           if (OpenVolumes as IDMCollection).IndexOf(SelectedVolumeE)=-1 then
            (OpenVolumes as IDMCollection2).Add(SelectedVolumeE);
           if(SelectedVolumes as IDMCollection).IndexOf(SelectedVolumeE)=-1 then
            (SelectedVolumes as IDMCollection2).Add(SelectedVolumeE);
        end;
    end;
  end;

  AllAreas0  :=DataModel.CreateCollection(-1, nil);
  AllAreas   :=DataModel.CreateCollection(-1, nil);
  ExternalAreas :=DataModel.CreateCollection(-1, nil);
  InternalAreas :=DataModel.CreateCollection(-1, nil);
  MainAreasLines:=DataModel.CreateCollection(-1, nil);

  for j:=0 to SelectedVolumes.Count-1 do begin
    SelectedVolumeE:=SelectedVolumes.Item[j];
    DefineExterInterAreas(SelectedVolumeE,AllAreas0,InternalAreas,False);
   end;    //for

  SortVolumesByZ(SelectedVolumes);

  ExtractAreas(SelectedVolumes,AllAreas0,AllAreas,MainAreasLines);

  CheckVolume(MainAreasLines,AllAreas0,AllAreas);

end;

function  TCustomSMDocument.Get_DontDragMouse:integer;
begin
  Result:=FDontDragMouse
end;

procedure TCustomSMDocument.Set_DontDragMouse(Value:integer);
begin
  FDontDragMouse:=Value
end;

function TCustomSMDocument.GetSubElement:IDMElement;
begin
  Result:=nil
end;

function TCustomSMDocument.AreaIsObsolet(const AreaE:IDMElement):WordBool;
begin
  Result:=False;
end;

procedure TCustomSMDocument.SelectTopEdges;
var
  SpatialModel:ISpatialModel;
  j, OldSelectState:integer;
  LineE:IDMElement;
  Line:ILine;
begin
  SpatialModel:=Get_DataModel as ISpatialModel;
  ClearSelection(nil);
  OldSelectState:=FState and dmfSelecting;
  FState:=FState or dmfSelecting;
  try
  for j:=0 to SpatialModel.Lines.Count-1 do begin
    LineE:=SpatialModel.Lines.Item[j];
    Line:=LineE as ILine;
    if (Line.GetVerticalArea(bdDown)<>nil) and
       (Line.GetVerticalArea(bdUp)=nil) then
      LineE.Selected:=True;
  end;
  finally
  FState:=FState and not dmfSelecting or OldSelectState;
  end;
  if SpatialModel.CoordNodes.Count>0 then
    Get_Server.SelectionChanged(SpatialModel.CoordNodes.Item[0]);
end;

function  TCustomSMDocument.Get_P0X:integer;
begin
  Result:=FP0X
end;

function  TCustomSMDocument.Get_P0Y:integer;
begin
  Result:=FP0Y
end;

function  TCustomSMDocument.Get_P0Z:integer;
begin
  Result:=FP0Z
end;

type
  PNodeRec=^TNodeRec;
  TNodeRec=record
    Signatura:byte;
    Used:boolean;
    Node:pointer;
    LineE:pointer;
    NextNodeRec:PNodeRec;
    Distance:double;
  end;

function FindWallNodes(var C0, C1:ICoordNode;
                         const aCurrentLines:IDMCollection;
                         const LineList0, LineList1:TList):boolean;
var
  NodeRecList:TList;

  procedure AddToLeafList(const Line:ILine;
                          const NearestFromRootNodeRec:PNodeRec;
                          const LeafList:TLinkList);
  var
    aNode, Node: ICoordNode;
    NewDistance: double;
    aNodeRec:PNodeRec;
  begin
    Node:=ICoordNode(NearestFromRootNodeRec.Node);
    aNode:=Line.NextNodeTo(Node);

    if aNode.Tag<>0 then begin
      aNodeRec:=PNodeRec(pointer(aNode.Tag));
      if aNodeRec.Signatura<>$88 then
        aNodeRec:=nil
      else
      if aNodeRec.Used then
        Exit;
    end else
      aNodeRec:=nil;

    if aNodeRec=nil then begin
      GetMem(aNodeRec, SizeOf(TNodeRec));
      NodeRecList.Add(aNodeRec);
      aNodeRec.Signatura:=$88;
      aNodeRec.Used:=False;
      aNodeRec.Node:=pointer(aNode);
      aNodeRec.LineE:=nil;
      aNodeRec.NextNodeRec:=nil;
      aNodeRec.Distance:=0;
      aNode.Tag:=integer(aNodeRec);
    end;

    NewDistance:=Line.Length+NearestFromRootNodeRec.Distance;

    if aNodeRec.NextNodeRec<>nil then begin
      if NewDistance<aNodeRec.Distance then begin
        aNodeRec.NextNodeRec:=NearestFromRootNodeRec;
        aNodeRec.LineE:=pointer(Line as IDMElement);
        aNodeRec.Distance:=NewDistance;
      end;
    end else begin
      aNodeRec.NextNodeRec:=NearestFromRootNodeRec;
      aNodeRec.LineE:=pointer(Line as IDMElement);
      aNodeRec.Distance:=NewDistance;
      LeafList.Add(pointer(aNodeRec));
    end;

  end;  {AddToLeafList}

  function FindNearestFromRootNode(LeafList:TLinkList):PNodeRec;
  var
    ALink:TLink;
    SmallestDistance:double;
  begin
    ALink:=LeafList.first;
    SmallestDistance:=InfinitValue;
    Result:=nil;
    while (ALink<>nil) do begin
      if PNodeRec(ALink.body).Distance<SmallestDistance then begin
        SmallestDistance:=PNodeRec(ALink.body).Distance;
        Result:=PNodeRec(ALink.body);
      end;
      ALink:=ALink.next;
    end
  end;

  function DoFindWallNode(var C:ICoordNode;
                         const aCurrentLines:IDMCollection;
                         const LineList:TList;
                         BuildDirection:integer):boolean;
  var
    NodeRec, NearestFromRootNodeRec:PNodeRec;
    LeafList:TLinkList;
    Node, NewC, C0, C1:ICoordNode;
    Line, aLine:ILine;
    LineE:IDMElement;
    j:integer;
  begin
    Result:=False;

    NodeRecList.Clear;
    LeafList:=TLinkList.Create;

    GetMem(NodeRec, SizeOf(TNodeRec));
    NodeRecList.Add(NodeRec);
    NodeRec.Signatura:=$88;
    NodeRec.Used:=False;
    NodeRec.Node:=pointer(C);
    NodeRec.LineE:=nil;
    NodeRec.NextNodeRec:=nil;
    NodeRec.Distance:=0;
    C.Tag:=integer(NodeRec);

    LeafList.Add(NodeRec);
    NearestFromRootNodeRec:=NodeRec;
    Node:=C;

    j:=0;
    while j<Node.Lines.Count do begin
      aLine:=Node.Lines.Item[j] as ILine;
      if aLine.GetVerticalArea(BuildDirection)<>nil then
        Break
      else
        inc(j)
    end;
    if j=Node.Lines.Count then begin
      while (LeafList.First<>nil) do begin

        for j:=0 to Node.Lines.Count-1 do begin
          LineE:=Node.Lines.Item[j];
          Line:=LineE as ILine;
          C0:=Line.C0;
          C1:=Line.C1;
          if ((abs(C0.X-C1.X)>0.1) or
              (abs(C0.Y-C1.Y)>0.1)) and
             (aCurrentLines.IndexOf(LineE)=-1) then begin
            AddToLeafList(Line, NearestFromRootNodeRec, LeafList);
          end;
        end;
        LeafList.Delete(pointer(NearestFromRootNodeRec));
        NearestFromRootNodeRec.Used:=True;
        NearestFromRootNodeRec:=FindNearestFromRootNode(LeafList);
        if NearestFromRootNodeRec=nil then
          Break;
        Node:=ICoordNode(NearestFromRootNodeRec.Node);

        j:=0;
        while j<Node.Lines.Count do begin
          aLine:=Node.Lines.Item[j] as ILine;
          if aLine.GetVerticalArea(BuildDirection)<>nil then
            Break
          else
            inc(j)
        end;
        if j<Node.Lines.Count then
          Break
      end;
    end;  

    if (LeafList.First<>nil) and
     (NearestFromRootNodeRec<>nil) then begin
      NodeRec:=NearestFromRootNodeRec;
      Node:=ICoordNode(NodeRec.Node);
      Result:=True;
      NewC:=Node;
      while Node<>C do begin
        LineList.Insert(0, pointer(NodeRec.LineE));
        NodeRec:=NodeRec.NextNodeRec;
        Node:=ICoordNode(NodeRec.Node);
      end;
      C:=NewC;
    end;

    for j:=0 to NodeRecList.Count-1 do begin
      NodeRec:=NodeRecList[j];
      Node:=ICoordNode(NodeRec.Node);
      Node.Tag:=0;
      FreeMem(NodeRec, SizeOf(TNodeRec))
    end;
  end;

begin
  NodeRecList:=TList.Create;
  Result:=DoFindWallNode(C0, aCurrentLines, LineList0, bdUp);
  if Result then
    Result:=DoFindWallNode(C1, aCurrentLines, LineList1, bdUp)
  else begin
    Result:=DoFindWallNode(C0, aCurrentLines, LineList0, bdDown);
    if Result then
      Result:=DoFindWallNode(C1, aCurrentLines, LineList1, bdDown)
  end;
  NodeRecList.Free;
end;


procedure TCustomSMDocument.LineDivideArea1(var C0, C1:ICoordNode; const aCurrentLines:IDMCollection;
      var aArea, aNewArea: IArea);
var
  LineList0, LineList1:TList;
  C2:ICoordNode;
  Flag:boolean;
  m:integer;
  aLineE:IDMElement;
  DataModel:IDataModel;
begin
  DataModel:=Get_DataModel as IDataModel;
  LineList0:=TList.Create;
  LineList1:=TList.Create;
  C2:=nil;
  Flag:=FindWallNodes(C0, C1, aCurrentLines, LineList0, LineList1);

  if LineList0.Count>0 then begin
    m:=LineList0.Count div 2;
    aLineE:=IDMElement(LineList0[m]);
    C2:=(aLineE as ILine).C0;
    if (C2=C0) or (C2=C1) then
      C2:=(aLineE as ILine).C1;
  end else
  if LineList1.Count>0 then begin
    m:=LineList1.Count div 2;
    aLineE:=IDMElement(LineList1[m]);
    C2:=(aLineE as ILine).C0;
    if (C2=C0) or (C2=C1) then
      C2:=(aLineE as ILine).C1;
  end;


  if Flag then begin
    aArea:=Find_DivideAreaWithNodes(C0,C1,C2, aCurrentLines, aNewArea);
    if (aArea<>nil) and
       (aNewArea<>nil) then begin
      for m:=0 to LineList0.Count-1 do begin
        aLineE:=IDMElement(LineList0[m]);
        (aCurrentLines as IDMCollection2).Insert(0, aLineE);
      end;
      for m:=0 to LineList1.Count-1 do begin
        aLineE:=IDMElement(LineList1[m]);
        (aCurrentLines as IDMCollection2).Add(aLineE);
      end;

      Lines_AddParent(aCurrentLines,aArea);  {опред. владельцев для aCurrentLines  }
      Lines_AddParent(aCurrentLines,aNewArea);

    end;
  end;
end;

procedure TCustomSMDocument.AfterRefElementCreation(const aElement: IDMElement);
begin
end;

end.
