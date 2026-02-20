unit AreaU;

interface
uses
  Classes, SysUtils, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, PolyLineU, Variants;

type
  TArea=class(TPolyLine, IArea)
  private
    FVolume0: Variant;
    FVolume1: Variant;
    FThickness:double;
    FIsVertical:boolean;
    FFlags:integer;

    FMinZ:double;
    FMaxZ:double;

    FBottomLines:IDMCollection;
    FTopLines:IDMCollection;

    FNX:double;
    FNY:double;
    FNZ:double;

    FC0:pointer;
    FC1:pointer;

    FSquare:double;

    procedure MakeBottomTopLines;
    procedure CalcNormal;
    procedure FindC0C1;

    function Get_Volume0: IVolume; safecall;
    function Get_Volume1: IVolume; safecall;
    procedure Set_Volume0(const Value: IVolume); safecall;
    procedure Set_Volume1(const Value: IVolume); safecall;
    function Get_Volume0IsOuter: WordBool; safecall;
    procedure Set_Volume0IsOuter(Value: WordBool); safecall;
    function Get_Volume1IsOuter: WordBool; safecall;
    procedure Set_Volume1IsOuter(Value: WordBool); safecall;
    function Get_BottomLines:IDMCollection; safecall;
    function Get_TopLines:IDMCollection; safecall;
    function Get_MaxZ: double; safecall;
    function Get_MinZ: double; safecall;
    procedure Set_MaxZ(Value: double); safecall;
    procedure Set_MinZ(Value: double); safecall;

    function Get_Vol0(Direction:integer): IVolume; safecall;
    function Get_Vol1(Direction:integer): IVolume; safecall;
    procedure Set_Vol0(Direction:integer; const Value: IVolume); safecall;
    procedure Set_Vol1(Direction:integer; const Value: IVolume); safecall;
    function Get_Vol0IsOuter(Direction:integer): WordBool; safecall;
    procedure Set_Vol0IsOuter(Direction:integer; Value: WordBool); safecall;
    function Get_Vol1IsOuter(Direction:integer): WordBool; safecall;
    procedure Set_Vol1IsOuter(Direction:integer; Value: WordBool); safecall;
    function Get_BLines(Direction:integer):IDMCollection; safecall;
    function Get_TLines(Direction:integer):IDMCollection; safecall;
    function Get_MxZ(Direction:integer): double; safecall;
    function Get_MnZ(Direction:integer): double; safecall;
    procedure Set_MxZ(Direction:integer; Value: double); safecall;
    procedure Set_MnZ(Direction:integer; Value: double); safecall;

    function Get_IsVertical: WordBool; safecall;
    procedure Set_Flags(Value: integer); safecall;
    function Get_Flags: integer; safecall;
    procedure Set_IsVertical(Value: WordBool); safecall;

    function Get_Style: integer; safecall;
    procedure Set_Style(Value: integer); safecall;
    function Get_C0:ICoordNode; safecall;
    function Get_C1:ICoordNode; safecall;
    procedure CalcSquare;
  protected
    FStyle:integer;

    procedure Initialize; override;
    procedure _Destroy; override;
    function _AddRef: Integer; override; stdcall;
    function _Release: Integer; override; stdcall;

    procedure DisconnectFrom(const aParent:IDMElement); override; safecall;

    class function GetClassID: integer; override;
    class procedure MakeFields0; override;
    class function GetFields:IDMCollection; override;

    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); override;
    function  GetCopyLinkMode(const aLink: IDMElement): Integer; override; safecall;

    procedure Loaded; override;
    procedure AfterLoading2; override;

    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure ClearOp; override;

    procedure Set_Selected(Value: WordBool); override;
    procedure RemoveChild(const Element:IDMElement); override;

    property Volume0:IVolume read Get_Volume0 write Set_Volume0;
    property Volume1:IVolume read Get_Volume1 write Set_Volume1;

    function Get_NeighborAt(Coord: ICoordNode;
      SectorCode: integer): IArea;
    procedure CheckVertical;

    function Get_NX:double; safecall;
    function Get_NY:double; safecall;
    function Get_NZ:double; safecall;

    procedure GetCentralPoint(out PX, PY, PZ:double); safecall;
    function ProjectionContainsPoint(P1,P2:double; Plain:integer):WordBool; safecall;
    function ProjectionContainsArea(const aArea:IArea):boolean;
    function Contains(PX, PY, PZ:double):boolean;
    procedure CalcMinMaxZ; safecall;
    function IntersectLine(L0X, L0Y, L0Z,
                           L1X, L1Y, L1Z:double;
                       out PX,  PY,  PZ :double):WordBool; safecall;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    procedure Update; override; safecall;
    procedure UpdateCoords; override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    function Get_Square:double; safecall;
    function GetDistanceFrom(X, Y, Z:double):double; safecall;
  end;

  TAreas=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation

uses
  SpatialModelConstU,
  Geometry, Outlines, FloatValueLists;

var
  FFields:IDMCollection;

{ TArea }

procedure TArea.Initialize;
begin
  inherited;

  FBottomLines:=TDMCollection.Create(Self as IDMElement) as IDMCollection;
  FTopLines:=TDMCollection.Create(Self as IDMElement) as IDMCollection;

  Color:=0;
  Volume0:=nil;
  Volume1:=nil;
end;

procedure TArea._Destroy;
begin
  inherited;
  FBottomLines:=nil;
  FTopLines:=nil;
end;

function TArea.Get_BottomLines: IDMCollection;
begin
  if FIsVertical then begin
    Result:=FBottomLines;
//    if FBottomLines.Count>0 then Exit;
//    MakeBottomTopLines
  end else
    Result:=Lines;
end;

function TArea.Get_TopLines: IDMCollection;
begin
  if FIsVertical then begin
    Result:=FTopLines;
//    if FTopLines.Count>0 then Exit;
//    MakeBottomTopLines
  end else
    Result:=Lines;
end;

procedure  TArea.MakeBottomTopLines;
var
  j, m, j0, j1:integer;
  L:double;
  ZList:TFloatValueList;
  aLine, bLine:ILine;
  aLineE, bLineE:IDMElement;
  C0, C1, bC0, bC1, aC0, aC1:ICoordNode;
  BottomFlag, TopFlag:boolean;
  InclinedLines:TList;
  X0, Y0, Z0, X1, Y1, Z1, X2, Y2, Z2:double;
  VertFlag:boolean;

  procedure AddToCollection(const CC:ICoordNode; Collection:IDMCollection);
  var
    Collection2:IDMCollection2;
    C, CPrev, CNext:ICoordNode;
    PrevLine:ILine;
  begin
    Collection2:=Collection as IDMCollection2;
    m:=0;
    while m<CC.Lines.Count do begin   // ищем первую гориз
      aLineE:=CC.Lines.Item[m];
      aLine:=aLineE as ILine;
      if Lines.IndexOf(aLineE)<>-1 then begin
        if aLine.IsVertical then
          inc(m)
        else
          Break
      end else
        inc(m)
    end;
    Collection2.Add(aLineE);
    PrevLine:=aLine;

    VertFlag:=False;
    CPrev:=CC;
    CNext:=aLine.NextNodeTo(CPrev);
    while True do begin       // продолжаем поиск гориз
      C:=CNext;
      m:=0;
      while m<C.Lines.Count do begin
        aLineE:=C.Lines.Item[m];
        aLine:=aLineE as ILine;
        if (aLine<>PrevLine) and
           (Lines.IndexOf(aLineE)<>-1) then begin
          if aLine.IsVertical then  // нашли вторую вертикальную
            VertFlag:=True;
          Break
        end else
          inc(m)
      end;
      if not VertFlag then begin
        CNext:=aLine.NextNodeTo(C);
                   // проверяем - не острый ли угол
        X0:=C.X;
        Y0:=C.Y;
        Z0:=C.Z;
        X1:=CPrev.X;
        Y1:=CPrev.Y;
        Z1:=CPrev.Z;
        X2:=CNext.X;
        Y2:=CNext.Y;
        Z2:=CNext.Z;
        if (X2-X0)*(X1-X0)+(Y2-Y0)*(Y1-Y0)+(Z2-Z0)*(Z1-Z0)>0 then
          Break // острый угол
        else
        if Collection.IndexOf(aLineE)=-1 then begin
          Collection2.Add(aLineE);
          CPrev:=C;
          PrevLine:=aLine;
        end else
          Break  // ????
      end else
        Break
    end;
  end;

begin
  (FBottomLines as IDMCollection2).Clear;
  (FTopLines as IDMCollection2).Clear;

  if FIsVertical then begin
    VertFlag:=False;
    C0:=nil;
    C1:=nil;
    j:=0;
    j0:=-1;
    while j<Lines.Count do begin
      aLineE:=Lines.Item[j];
      aLine:=aLineE as ILine;
      if aLine.IsVertical then begin
        if not VertFlag then begin   // если пока вертикальной не было
          j0:=j;          // запоминаем первую вертикальную
          VertFlag:=True;
          C0:=aLine.C0;
          C1:=aLine.C1;
        end else begin    // раздвигаем концы вертикальной
          aC0:=aLine.C0;
          aC1:=aLine.C1;
          if aC1=C0 then
            C0:=aC0
          else
          if aC0=C1 then
            C1:=aC1
          else
            XXX:=0;
//            raise Exception.Create('Error in MakeBottomTopLines');
        end;
        inc(j);
      end else begin
        if VertFlag then begin // только что была вертикальная
          VertFlag:=False;     // и кончилась
          Break
        end else // продолжаем поиск вертикальной
          inc(j);
      end;
    end;

    try
    if j0=0 then begin
      j1:=Lines.Count-1;
      while j1>j do begin
        aLineE:=Lines.Item[j1];
        aLine:=aLineE as ILine;
        if aLine.IsVertical then begin
          aC0:=aLine.C0;       // раздвигаем концы вертикальной
          aC1:=aLine.C1;
          if aC1=C0 then
            C0:=aC0
          else
          if aC0=C1 then
            C1:=aC1
          else
            XXX:=0;
//            raise Exception.Create('Error in MakeBottomTopLines');
          dec(j1)
        end else     // вертикальная кончилась
          Break
      end;
    end;
    except
      raise
    end;

    if (C0<>nil) and
       (C1<>nil) then begin  // если найдена вертикальная
      AddToCollection(C0, FBottomLines);
      AddToCollection(C1, FTopLines);
      Exit;
    end;
  end; // if FIsVertical

  ZList:=TSortedFloatValueList.Create;
  InclinedLines:=TList.Create;
  for j:=0 to Lines.Count-1 do begin
    aLine:=Lines.Item[j] as ILine;
    ZList.AddValue(aLine.C0.Z);
    ZList.AddValue(aLine.C1.Z);
  end;

  for j:=0 to Lines.Count-1 do begin
    aLineE:=Lines.Item[j];
    aLine:=aLineE as ILine;
    C0:=aLine.C0;
    C1:=aLine.C1;
    L:=aLine.Length;
    if (L<>0) and
       (sqrt(sqr(C0.X-C1.X)+sqr(C0.Y-C1.Y))/L>0.5) then begin
      if C1.Z<C0.Z then begin
        Z1:=C1.Z;
        Z2:=C0.Z;
      end else begin
        Z1:=C0.Z;
        Z2:=C1.Z;
      end;
      BottomFlag:=False;
      TopFlag:=False;
      if ((Z1=ZList[0]) and
          (Z2=ZList[0])) or
         ((Z1=ZList[0]) and
          (Z2=ZList[1])) then
        BottomFlag:=True;
      if ((Z2=ZList[ZList.Count-1]) and
               (Z1=ZList[ZList.Count-1])) or
         ((Z2=ZList[ZList.Count-1]) and
          (Z1=ZList[ZList.Count-2])) then
        TopFlag:=True;

      if BottomFlag and not TopFlag then
         (FBottomLines as IDMCollection2).Add(aLineE)
      else
      if not BottomFlag and TopFlag then
        (FTopLines as IDMCollection2).Add(aLineE);
      if BottomFlag and TopFlag then
        InclinedLines.Add(pointer(aLineE))
    end;
  end;

  for j:=0 to InclinedLines.Count-1 do begin
    aLineE:=IDMELement(InclinedLines[j]);
    if FTopLines.Count=0 then
      (FTopLines as IDMCollection2).Add(aLineE)
    else
    if FBottomLines.Count=0 then
     (FBottomLines as IDMCollection2).Add(aLineE)
    else begin
      C0:=aLine.C0;
      C1:=aLine.C1;
      m:=0;
      while m<FBottomLines.Count do begin
        bLineE:=FBottomLines.Item[m];
        bLine:=bLineE as ILine;
        bC0:=bLine.C0;
        bC1:=bLine.C1;
        if (C0=bC0) then begin
          X0:=C0.X;
          Y0:=C0.Y;
          X1:=C1.X;
          Y1:=C1.Y;
          X2:=bC1.X;
          Y2:=bC1.Y;
          break;
        end else
        if (C0=bC1) then begin
          X0:=C0.X;
          Y0:=C0.Y;
          X1:=C1.X;
          Y1:=C1.Y;
          X2:=bC0.X;
          Y2:=bC0.Y;
          break;
        end else
        if (C1=bC0) then begin
          X0:=C1.X;
          Y0:=C1.Y;
          X1:=C0.X;
          Y1:=C0.Y;
          X2:=bC1.X;
          Y2:=bC1.Y;
          break;
        end else
        if (C1=bC1) then begin
          X0:=C1.X;
          Y0:=C1.Y;
          X1:=C0.X;
          Y1:=C0.Y;
          X2:=bC0.X;
          Y2:=bC0.Y;
          break;
        end else
          inc(m)
      end; // while m<FBottomLines.Count
      if m<FBottomLines.Count then begin
        if ((X1-X0)*(X2-X0)+(Y1-Y0)*(Y2-Y0))>0 then
          (FTopLines as IDMCollection2).Add(aLineE)
        else
          (FBottomLines as IDMCollection2).Add(aLineE)
      end;
    end;
  end;

  if FBottomLines.Count>2 then
    ReorderLines(FBottomLines);
  if FTopLines.Count>2 then
    ReorderLines(FTopLines);

  InclinedLines.Clear;
  ZList.FreeValues;
  ZList.Free;
end;

class function TArea.GetClassID: integer;
begin
  Result:=_Area;
end;

function TArea.Get_NeighborAt(Coord:ICoordNode; SectorCode:integer):IArea;
var
  Volume:IVolume;
  aBottomLine:ILine;
  aArea:IArea;
  j, m:integer;
begin
  case SectorCode of
  0:Volume:=Volume0;
  1:Volume:=Volume1;
  else
    Raise Exception.Create('SectorCode Error!!!');
  end;
  Result:=nil;
  if Volume=nil then Exit;
  for j:=0 to Volume.Areas.Count-1 do begin
    aArea:=Volume.Areas.Item[j] as IArea;
    if aArea<>Self as IArea then begin
      if not aArea.IsVertical then Continue;
      for m:=0 to aArea.BottomLines.Count-1 do begin
        aBottomLine:=aArea.BottomLines.Item[m] as ILine;
        if (aBottomLine.C0=Coord) or
           (aBottomLine.C1=Coord) then begin
          Result:=aArea;
          Exit;
        end;
      end;
    end;
  end;
end;

function TArea.ProjectionContainsPoint(P1,P2:double; Plain:integer): WordBool;
var
  Document:IDMDocument;
  OldState:integer;
begin
  if DataModel<>nil then begin
    Document:=DataModel.Document as IDMDocument;
    OldState:=DataModel.State;
    DataModel.State:=DataModel.State or dmfCommiting;
  end else begin
    Document:=nil;
    OldState:=0;
  end;

  Result:=OutlineContainsPoint(P1,P2,Plain, Get_Lines);

  if Document<>nil then
    DataModel.State:=OldState;
end;

procedure TArea.CheckVertical;
begin
end;


procedure TArea.GetCentralPoint(out PX, PY, PZ:double);
var
  j:integer;
  Line:ILine;
  L, LS:double;
begin
  PX:=0;
  PY:=0;
  PZ:=0;
  LS:=0;
  for j:=0 to Lines.Count-1 do begin
    Line:=Lines.Item[j] as ILine;
    L:=Line.Length;
    PX:=PX+(Line.C0.X+Line.C1.X)*0.5*L;
    PY:=PY+(Line.C0.Y+Line.C1.Y)*0.5*L;
    PZ:=PZ+(Line.C0.Z+Line.C1.Z)*0.5*L;
    LS:=LS+L;
  end;
  PX:=PX/LS;
  PY:=PY/LS;
  PZ:=PZ/LS;
  if abs(PZ-FMinZ)<1 then
    PZ:=FMinZ
end;

function TArea.Contains(PX, PY, PZ:double): boolean;
begin
  Result:=((ProjectionContainsPoint(PX, PY, 0)) and
           (FMinZ<=PZ) and (FMaxZ<=PZ))
end;

function TArea.ProjectionContainsArea(const aArea: IArea): boolean;
var
  aAreaP:IPolyline;
  Document:IDMDocument;
  OldState:integer;
begin
  Result:=False;
  if aArea=nil then Exit;
  aAreaP:=aArea as IPolyline;

  Document:=DataModel.Document as IDMDocument;
  OldState:=DataModel.State;
  DataModel.State:=DataModel.State or dmfCommiting;
                            // внутри происходит временное присвоение C.Z:=0
  Result:=OutlineContainsOutline(Get_Lines, aAreaP.Lines);

  DataModel.State:=OldState;
end;


procedure TArea.ClearOp;
var
 aArea:IArea;
 m:integer;
 aAreaE, Volume0E, Volume1E:IDMElement;
begin
  if not Exists then Exit;
  try
  inherited;
  if not DataModel.IsCopying then begin
    if Volume0<>nil then begin
      Volume0E:=Volume0 as IDMElement;

      if Volume1<>nil then begin
        Volume1E:=Volume1 as IDMElement;

        m:=0;
        while m<Volume1.Areas.Count do begin
          aAreaE:=Volume1.Areas.Item[m];
          aArea:=aAreaE as IArea;
          if aArea<>Self as IArea then begin
            if aArea.Volume0=Volume1 then begin
              if aArea.Volume1<>Volume0 then
                aArea.Volume0:=Volume0
              else begin
                aArea.Volume0:=nil;
                aArea.Volume1:=nil;
                DataModel.RemoveElement(aAreaE);
              end
            end else
            if aArea.Volume1=Volume1 then begin
              if aArea.Volume0<>Volume0 then
                aArea.Volume1:=Volume0
              else begin
                aArea.Volume0:=nil;
                aArea.Volume1:=nil;
                DataModel.RemoveElement(aAreaE);
              end
            end
          end else
            inc(m)
        end;
        DataModel.RemoveElement(Volume1E);
      end else begin
        Volume0:=nil;
        DataModel.RemoveElement(Volume0E);
      end;
    end else if Volume1<>nil then begin
      Volume1:=nil;
      if not DataModel.IsCopying then
        DataModel.RemoveElement(Volume1E);
    end
  end else begin
    Volume0:=nil;
    Volume1:=nil;
  end;

  except
  end;
end;

const
  pXY=0;
  pYZ=1;
  pZX=2;

function TArea.IntersectLine(L0X, L0Y, L0Z,
                             L1X, L1Y, L1Z:double;
                         out PX,  PY,  PZ :double):WordBool;
var
  P0X, P0Y, P0Z,
  P1X, P1Y, P1Z,
  P2X, P2Y, P2Z,
  PPX, PPY, PPZ,
  CPX, CPY, CPZ,
  D, Len1, Len2:double;
  X0, Y0, Z0, X1, Y1, Z1:double;
  j:integer;
  C:ICoordNode;
  C0, C1:ICoordNode;
  Line, NextLine, LastLine:ILine;
  Plane:integer;
  Q, QQ:double;
begin
  Result:=False;

  Len1:=0;
  j:=0;
  while j<Lines.Count do begin
    Line:=Lines.Item[j] as ILine;
    Len1:=Line.Length;
    if Len1<>0 then
      Break
    else
      inc(j);
  end;

  if j=Lines.Count then Exit;

  P0X:=Line.C0.X;
  P0Y:=Line.C0.Y;
  P0Z:=Line.C0.Z;
  P1X:=Line.C1.X;
  P1Y:=Line.C1.Y;
  P1Z:=Line.C1.Z;
  P2X:=-InfinitValue;
  P2Y:=-InfinitValue;
  P2Z:=-InfinitValue;

  inc(j);
  while j<Lines.Count do begin
    Line:=Lines.Item[j] as ILine;

    P2X:=Line.C0.X;
    P2Y:=Line.C0.Y;
    P2Z:=Line.C0.Z;
    Len2:=sqrt(sqr(P2X-P0X)+sqr(P2Y-P0Y)+sqr(P2Z-P0Z));
    if Len2<>0 then begin
      D:=((P1X-P0X)*(P2X-P0X)+
          (P1Y-P0Y)*(P2Y-P0Y)+
          (P1Z-P0Z)*(P2Z-P0Z))/(Len1*Len2);
      if abs(D)<0.99 then Break;
    end;

    P2X:=Line.C1.X;
    P2Y:=Line.C1.Y;
    P2Z:=Line.C1.Z;
    Len2:=sqrt(sqr(P2X-P0X)+sqr(P2Y-P0Y)+sqr(P2Z-P0Z));
    if Len2<>0 then begin
      D:=((P1X-P0X)*(P2X-P0X)+
          (P1Y-P0Y)*(P2Y-P0Y)+
          (P1Z-P0Z)*(P2Z-P0Z))/(Len1*Len2);
      if abs(D)<0.99 then Break;
    end;

    inc(j);
  end;
  if j=Lines.Count then Exit;

  if not LineIntersectPlane(L0X, L0Y, L0Z,
                            L1X, L1Y, L1Z,
                            P0X, P0Y, P0Z,
                            P1X, P1Y, P1Z,
                            P2X, P2Y, P2Z,
                            PX,  PY,  PZ) then Exit;

  if (abs(FNZ)>=abs(FNX)) and (abs(FNZ)>=abs(FNY)) then
    Plane:=pXY
  else
  if (abs(FNX)>=abs(FNY)) and (abs(FNX)>=abs(FNZ)) then
    Plane:=pYZ
  else
    Plane:=pZX;

  Line:=Lines.Item[0] as ILine;
  NextLine:=Lines.Item[1] as ILine;
  if (Line.C0=NextLine.C0) or
     (Line.C0=NextLine.C1) then
    C0:=Line.C1
  else
    C0:=Line.C0;
  C1:=Line.NextNodeTo(C0);
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Z;

  case Plane of
  pXY: QQ:=(PY-Y0)*(X1-X0)-(PX-X0)*(Y1-Y0);
  pYZ: QQ:=(PZ-Z0)*(Y1-Y0)-(PY-Y0)*(Z1-Z0);
  else QQ:=(PX-X0)*(Z1-Z0)-(PZ-Z0)*(X1-X0);
  end;

  try
  for j:=1 to Lines.Count-1 do begin
    Line:=Lines.Item[j] as ILine;
    C0:=C1;
    C1:=Line.NextNodeTo(C0);

    X0:=C0.X;
    Y0:=C0.Y;
    Z0:=C0.Z;
    X1:=C1.X;
    Y1:=C1.Y;
    Z1:=C1.Z;
    case Plane of
    pXY: Q:=(PY-Y0)*(X1-X0)-(PX-X0)*(Y1-Y0);
    pYZ: Q:=(PZ-Z0)*(Y1-Y0)-(PY-Y0)*(Z1-Z0);
    else Q:=(PX-X0)*(Z1-Z0)-(PZ-Z0)*(X1-X0);
    end;
    if QQ*Q<0 then Exit;
  end;
  Result:=True;
  except
    raise
  end;  

{
  LastLine:=Lines.Item[Lines.Count-1] as ILine;
  if (LastLine.C0<>C) and
     (LastLine.C1<>C) then
    C:=Line.C1;
  CPX:=C.X;
  CPY:=C.Y;
  CPZ:=C.Z;
  for j:=1 to Lines.Count-2 do begin
    Line:=Lines.Item[j] as ILine;
    C0:=Line.C0;
    C1:=Line.C1;
    X0:=C0.X;
    Y0:=C0.Y;
    Z0:=C0.Z;
    X1:=C1.X;
    Y1:=C1.Y;
    Z1:=C1.Z;
    if LineIntersectLine(PX, PY, PZ, CPX, CPY, CPZ,
                X0, Y0, Z0,
                X1, Y1, Z1,
                PPX, PPY, PPZ) then begin
      Result:=True;
      Exit;
    end;
  end;
}
end;

class function TArea.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TArea.MakeFields0;
begin
  inherited;
  AddField(rsThickness, '%5.1f', '', '',
      fvtFloat, 0, 0, 0,
      ord(areThickness), 0, pkInput);
  AddField(rsStyle, '%2d', '', '',
      fvtInteger, 0, 0, 0,
      ord(areStyle), 0, pkInput);
  AddField(rsAreaFlags, '%d', '', '',
      fvtInteger, 0, 0, 0,
      ord(areFlags), 0, pkInput);
  AddField(rsVolume0, '', '', '',
      fvtElement, -1, 0, 0,
      ord(areVolume0), 0, pkInput);
  AddField(rsVolume1, '', '', '',
      fvtElement, -1, 0, 0,
      ord(areVolume1), 0, pkInput);
  AddField(rsIsVertical, '', '', '',
      fvtBoolean, 0, 0, 0,
      ord(areIsVertical), 0, pkInput);
end;

function TArea.GetFieldValue(Code: integer): OleVariant;
begin
    case Code of
    ord(areFlags):
      Result:=FFlags;
    ord(areVolume0):
      if not VarIsNull(FVolume0) and
         not VarIsEmpty(FVolume0) then
        Result:=FVolume0
      else
        Result:=Null;
    ord(areVolume1):
      if not VarIsNull(FVolume1) and
         not VarIsEmpty(FVolume1) then
        Result:=FVolume1
      else
        Result:=Null;
    ord(areThickness):
      Result:=FThickness;
    ord(areStyle):
      Result:=FStyle;
    ord(areIsVertical):
      Result:=FIsVertical;
    else
      Result:=inherited GetFieldValue(Code);
    end
end;

procedure TArea.SetFieldValue_(Code: integer; Value: OleVariant);
var
  Volume:IVolume;
  SelfE:IDMElement;
  j:integer;
  IsVertical, VolumeIsOuter:WordBool;
begin
  case Code of
  ord(areFlags):
    FFlags:=Value;
  ord(areVolume0):
    begin
      SelfE:=Self as IDMElement;
      IsVertical:=Get_IsVertical;
      VolumeIsOuter:=Get_Volume0IsOuter;
      if not DataModel.IsLoading and
         not VarIsNull(FVolume0) and
         not VarIsEmpty(FVolume0) and
         not VolumeIsOuter then  begin
        Volume:=Get_Volume0;


        if (Volume<>nil) then begin
          j:=Volume.Areas.IndexOf(SelfE);
          if j<>-1 then
            (Volume.Areas as IDMCollection2).Delete(j);
          if not IsVertical then begin
            j:=Volume.BottomAreas.IndexOf(SelfE);
            if j<>-1 then
              (Volume.BottomAreas as IDMCollection2).Delete(j);
          end;
        end;
      end;

      FVolume0 := Value;

      if not DataModel.IsLoading and
         not VarIsNull(FVolume0) and
         not VarIsEmpty(FVolume0) and
         not VolumeIsOuter then  begin
        Volume:=Get_Volume0;
        if (Volume<>nil) then begin

          j:=Volume.Areas.IndexOf(SelfE);
          if j=-1 then
            (Volume.Areas as IDMCollection2).Add(SelfE);
          if not IsVertical then begin
            j:=Volume.BottomAreas.IndexOf(SelfE);
            if j=-1 then
              (Volume.BottomAreas as IDMCollection2).Add(SelfE);
          end;
        end;
      end;
    end;
  ord(areVolume1):
    begin
      SelfE:=Self as IDMElement;
      IsVertical:=Get_IsVertical;
      VolumeIsOuter:=Get_Volume1IsOuter;
      if not DataModel.IsLoading and
         not VarIsNull(FVolume1) and
         not VarIsEmpty(FVolume1) and
         not VolumeIsOuter then  begin
        Volume:=Get_Volume1;
        if (Volume<>nil) then begin
          j:=Volume.Areas.IndexOf(SelfE);
          if j<>-1 then
            (Volume.Areas as IDMCollection2).Delete(j);
          if not IsVertical then begin
            j:=Volume.TopAreas.IndexOf(SelfE);
            if j<>-1 then
              (Volume.TopAreas as IDMCollection2).Delete(j);
          end;
        end;
      end;

      FVolume1 := Value;

      if not DataModel.IsLoading and
         not VarIsNull(FVolume1) and
         not VarIsEmpty(FVolume1) and
         not VolumeIsOuter then  begin
        Volume:=Get_Volume1;
        if (Volume<>nil) then begin

          j:=Volume.Areas.IndexOf(SelfE);
          if j=-1 then
            (Volume.Areas as IDMCollection2).Add(SelfE);
          if not IsVertical then begin
            j:=Volume.TopAreas.IndexOf(SelfE);
            if j=-1 then
              (Volume.TopAreas as IDMCollection2).Add(SelfE);
          end;
        end;
      end;
    end;
  ord(areThickness):
    FThickness:=Value;
  ord(areStyle):
    FStyle:=Value;
  ord(areIsVertical):
    FIsVertical:=Value;
  else
    inherited;
  end
end;

procedure TArea.GetFieldValueSource(Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(areVolume0),
  ord(areVolume1):
    theCollection:=(DataModel as IDMElement).Collection[_Volume];
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

procedure TArea.Update;
var
  SpatialModel2:ISpatialModel2;
begin
  inherited;
  CalcMinMaxZ;
  MakeBottomTopLines;
  FindC0C1;
  CalcNormal;
//  CalcSquare;
  if (Ref<>nil) and
     not DataModel.IsLoading then
    Ref.Update;
  if DataModel=nil  then Exit;
  SpatialModel2:=DataModel as ISpatialModel2;
  SpatialModel2.AreasOrdered:=False;
end;

procedure TArea.CalcMinMaxZ;
var
  j:integer;
  Line:ILine;
begin
  FMinZ:=InfinitValue;
  FMaxZ:=-InfinitValue;
  for j:=0 to Lines.Count-1 do begin
    Line:=Lines.Item[j] as ILine;
    if FMinZ>Line.C0.Z then
      FMinZ:=Line.C0.Z
    else
    if FMaxZ<Line.C0.Z then
      FMaxZ:=Line.C0.Z;

    if FMinZ>Line.C1.Z then
      FMinZ:=Line.C1.Z
    else
    if FMaxZ<Line.C1.Z then
      FMaxZ:=Line.C1.Z;
    if not FIsVertical and
      (Line.C0.Z<Line.C1.Z) and
      (Line.C0.X=Line.C1.X) and
      (Line.C0.Y=Line.C1.Y) then
      FIsVertical:=True;
  end;
end;

procedure TArea.Set_Volume0(const Value: IVolume);
begin
  Set_FieldValue(ord(areVolume0), Value as IUnknown)
end;

procedure TArea.Set_Volume1(const Value: IVolume);
begin
  Set_FieldValue(ord(areVolume1), Value as IUnknown)
end;

procedure TArea.Draw(const aPainter: IUnknown; DrawSelected: integer);
var
  Painter:IPainter;
  SpatialModel2:ISpatialModel2;
  View:IView;
  Line:ILine;
  C0, C1:ICoordNode;
  OldMode, OldPenStyle, OldPenColor:integer;
  X0, Y0, Z0, X1, Y1, Z1, OldPenWidth:double;
begin
  if Layer=nil then Exit;
  if not Layer.Visible then Exit;
  if DataModel=nil then Exit;
  if aPainter=nil then Exit;
  SpatialModel2:=DataModel as ISpatialModel2;
  Painter:=aPainter as IPainter;
  if (FStyle<>0) or
     ((SpatialModel2.RenderAreasMode<>0) and
      (Color<>0)) then begin

    OldPenStyle:=Painter.PenStyle;
    OldPenWidth:=Painter.PenWidth;
    OldPenColor:=Painter.PenColor;
    Painter.PenStyle:=0;
    Painter.PenWidth:=0;
    Painter.PenColor:=Color;
    if DrawSelected=-1 then begin
      Painter.BrushColor:=clWhite;
      Painter.BrushStyle:=0;
    end else begin
      Painter.BrushColor:=Color;
      Painter.BrushStyle:=FStyle;
    end;
    Painter.DrawPolygon(Lines, FIsVertical);

    Painter.PenStyle:=OldPenStyle;
    Painter.PenWidth:=OldPenWidth;
    Painter.PenColor:=OldPenColor;
  end;
  inherited;

  if not Get_IsVertical then Exit;

  View:=Painter.ViewU as IView;
  C0:=Get_C0;
  C1:=Get_C1;
  if C0=nil then Exit;
  if C1=nil then Exit;
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Z;
  if (Z0<View.Zmin) or
     (Z1<View.Zmin) and
     (FTopLines.Count>0) then begin
    Line:=FTopLines.Item[0] as ILine;
    C0:=Line.C0;
    C1:=Line.C1;
    if C0=nil then Exit;
    if C1=nil then Exit;
    if (C0.Z>View.Zmax) or
       (C1.Z>View.Zmax) then begin
      Z0:=View.Zmin;
      Z1:=View.Zmin;
      OldMode:=Painter.Mode;
      OldPenStyle:=Painter.PenStyle;
      OldPenWidth:=Painter.PenWidth;
      OldPenColor:=Painter.PenColor;
      Painter.Mode:=1;
      Painter.PenStyle:=2; // Dot
      Painter.PenWidth:=0;

      Layer:=Parent as ILayer;
      if DrawSelected=1 then
        Painter.PenColor:=clLime
      else
      if (DrawSelected=-1) then
        Painter.PenColor:=clWhite
      else
      if ((Get_Volume0<>nil) and
          (Get_Volume0 as IDMELement).Selected) or
         ((Get_Volume1<>nil) and
          (Get_Volume1 as IDMELement).Selected)  then
        Painter.PenColor:=clLime
      else
      if Layer<>nil then
        Painter.PenColor:=Layer.Color;

      Painter.DrawLine(X0, Y0, Z0, X1, Y1, Z1);
      Painter.Mode:=OldMode;
      Painter.PenStyle:=OldPenStyle;
      Painter.PenWidth:=OldPenWidth;
      Painter.PenColor:=OldPenColor;
    end;
  end;
end;

function TArea.Get_IsVertical: WordBool;
begin
  Result:=FIsVertical
end;

function TArea.Get_Style: integer;
begin
  Result:=FStyle
end;

function TArea.Get_Volume0: IVolume;
var
  Unk:IUnknown;
begin
  if not VarIsNull(FVolume0) and
     not VarIsClear(FVolume0) then begin
    Unk:=FVolume0;
    Result:=Unk as IVolume
  end else
    Result:=nil
end;

function TArea.Get_Volume1: IVolume;
var
  Unk:IUnknown;
begin
  try
  if not VarIsNull(FVolume1) and
     not VarIsClear(FVolume1) then begin
    Unk:=FVolume1;
    Result:=Unk as IVolume
  end else
    Result:=nil
  except
    raise
  end
end;

procedure TArea.Set_IsVertical(Value: WordBool);
begin
  if not Value then
    XXX:=0;
  Set_FieldValue(ord(areIsVertical), Value)
end;

function TArea.Get_MaxZ: double;
begin
  Result:=FMaxZ
end;

function TArea.Get_MinZ: double;
begin
  Result:=FMinZ
end;

function TArea.GetCopyLinkMode(const aLink: IDMElement): Integer;
var
  Line:ILine;
  Volume:IVolume;
begin
  if aLink=nil then
    Result:=clmNil
  else
  if aLink.QueryInterface(ILine, Line)=0then
    Result:=clmNewLink
  else
  if aLink.QueryInterface(IVolume, Volume)=0then
    Result:=clmExistingLink
  else
    Result:=inherited GetCopyLinkMode(aLink);
end;


procedure TArea.Set_MaxZ(Value: double);
begin
  FMaxZ:=Value
end;

procedure TArea.Set_MinZ(Value: double);
begin
  FMinZ:=Value
end;

procedure TArea.Set_Style(Value: integer);
begin
  FStyle:=Value
end;

procedure TArea.CalcNormal;

var
  Line0, Line:ILine;
  C0, C1, C2:ICoordNode;
  j, jBest:integer;
  L0, L, A, B, C, Q, Q2,
  X0, Y0, Z0, X1, Y1, Z1, X2, Y2, Z2,
  DX, DY, DZ, D, Dmin:double;
  kBest: Integer;

  function FindNormal(const Line: ILine; Finding: Boolean): Boolean;
  begin
    Result := False;
    if (Line.C1<>C0) and
       (Line.C1<>C1) then
      C2:=Line.C1
    else
      C2:=Line.C0;
    X2:=C2.X;
    Y2:=C2.Y;
    Z2:=C2.Z;
    L:=sqrt(sqr(X2-X0)+sqr(Y2-Y0)+sqr(Z2-Z0));
    if L<>0 then begin
      D:=abs(DX*(X2-X0)+DY*(Y2-Y0)+DZ*(Z2-Z0))/(L0*L);
      if (Dmin > D) then begin
        Dmin := D;
        jBest := j;
        kBest := 0;
      end;
      if  (abs(D-1)>0.01)or((not Finding)and(kBest=0)) then begin
        A:=+DY*(Z2-Z0)-(Y2-Y0)*DZ;
        B:=-DX*(Z2-Z0)+(X2-X0)*DZ;
        C:=+DX*(Y2-Y0)-(X2-X0)*DY;
        Q2:=A*A+B*B+C*C;
        if Q2<>0 then begin
          Result := True;
          Exit
        end else
          Exit
      end else begin
        L:=sqrt(sqr(X2-X1)+sqr(Y2-Y1)+sqr(Z2-Z1));
        if L<>0 then begin
          D:=abs(DX*(X2-X1)+DY*(Y2-Y1)+DZ*(Z2-Z1))/(L0*L);
          if (Dmin > D) then begin
            Dmin := D;
            jBest := j;
            kBest:=1;
          end;
          if (abs(D-1)>0.01)or((not Finding)and(kBest=1)) then begin
            A:=+DY*(Z2-Z1)-(Y2-Y1)*DZ;
            B:=-DX*(Z2-Z1)+(X2-X1)*DZ;
            C:=+DX*(Y2-Y1)-(X2-X1)*DY;
            Q2:=A*A+B*B+C*C;
            if Q2<>0 then begin
              Result := True;
              Exit
            end else
             Exit
          end else
            Exit
        end;
      end;
    end;
  end;

begin
  if Lines.Count=0 then Exit;
  Line0:=Lines.Item[0] as ILine;
  C0:=Line0.C0;
  C1:=Line0.C1;
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Z;
  DX:=X1-X0;
  DY:=Y1-Y0;
  DZ:=Z1-Z0;
  L0:=Line0.Length;
  if L0=0 then Exit;
  j:=1;
  C2:=nil;
  A:=0;
  B:=0;
  C:=0;
  Q2:=0;
  Dmin := InfinitValue;
  while j<Lines.Count do begin
    Line:=Lines.Item[j] as ILine;
    If FindNormal(Line, True) then
      break
    else
      inc(j);
  end;
  if (j = Lines.Count) then begin
    j:=jBest;
    Line:=Lines.Item[j] as ILine;
    FindNormal(Line, False);
  end;

  Q:=sqrt(Q2);
  FNX:=A/Q;
  FNY:=B/Q;
  FNZ:=C/Q;
end;

function TArea.Get_NX: double;
begin
  Result:=FNX
end;

function TArea.Get_NY: double;
begin
  Result:=FNY
end;

function TArea.Get_NZ: double;
begin
  Result:=FNZ
end;

function TArea.Get_C0: ICoordNode;
begin
  Result:=ICoordNode(FC0)
end;

function TArea.Get_C1: ICoordNode;
begin
  Result:=ICoordNode(FC1)
end;

procedure TArea.FindC0C1;
var
  Line0, Line1:ILine;
  DD, Length:double;
  C0, C1:ICoordNode;
begin
  FC0:=nil;
  FC1:=nil;
  if FIsVertical and
     (FBottomLines.Count>0) then begin
    if FBottomLines.Count=1 then begin
      Line0:=FBottomLines.Item[0] as ILine;
      C0:=Line0.C0;
      C1:=Line0.C1;
    end else begin
      Line0:=FBottomLines.Item[0] as ILine;
      Line1:=FBottomLines.Item[FBottomLines.Count-1] as ILine;
      C0:=Line0.C0;
      C1:=Line1.C1;
      Length:=sqrt(sqr(C0.X-C1.X)+sqr(C0.Y-C1.Y));
      DD:=sqrt(sqr(C0.X-Line1.C0.X)+sqr(C0.Y-Line1.C0.Y));
      if DD>Length then begin
        C1:=Line1.C0;
        Length:=DD
      end;
      DD:=sqrt(sqr(C1.X-Line0.C1.X)+sqr(C1.Y-Line0.C1.Y));
      if DD>Length then begin
        C0:=Line0.C1;
      end;
    end;
    FC0:=pointer(C0);
    FC1:=pointer(C1);
  end;
end;

function TArea.Get_Square: double;
begin
  Result:=FSquare
end;

procedure TArea.Set_Parent(const Value: IDMElement);
var
  Collection:IDMCollection;
  Collection2:IDMCollection2;
  j:integer;
  aLine:ILine;
begin
  if (Value<>nil) and
    FIsVertical and
    (FTopLines<>nil) and
     not Get_BuildIn and
     not DataModel.IsCopying and
     DataModel.IsChanging then begin
      Collection:=TDMCollection.Create(nil) as IDMCollection;
      Collection2:=Collection as IDMCollection2;
      for j:=0 to FTopLines.Count-1 do
        Collection2.Add(FTopLines.Item[j].Parent);
  end else
    Collection:=nil;

  inherited;

  if (Value<>nil) and
     FIsVertical and
     (FTopLines<>nil) and
     not Get_BuildIn and
     not DataModel.IsCopying and
     DataModel.IsChanging then begin
    for j:=0 to FTopLines.Count-1 do begin
      aLine:=FTopLines.Item[j] as ILine;
      FTopLines.Item[j].Parent:=Collection.Item[j];
    end;
    Collection2.Clear;
  end;
end;

procedure TArea.Loaded;
var
  Volume:IVolume;
  j:integer;
  SelfE:IDMElement;
  IsVertical, Volume0IsOuter, Volume1IsOuter:WordBool;
begin
  inherited;

  SelfE:=Self as IDMElement;
  IsVertical:=Get_IsVertical;
  Volume0IsOuter:=Get_Volume0IsOuter;
  Volume1IsOuter:=Get_Volume1IsOuter;

  Volume:=Get_Volume0;
  if (Volume<>nil) and
     (not Volume0IsOuter) then begin
    j:=Volume.Areas.IndexOf(SelfE);
    if j=-1 then
      (Volume.Areas as IDMCollection2).Add(SelfE);
    if not IsVertical then begin
      j:=Volume.BottomAreas.IndexOf(SelfE);
      if j=-1 then
        (Volume.BottomAreas as IDMCollection2).Add(SelfE);
    end;
  end;

  Volume:=Get_Volume1;
  if (Volume<>nil) and
     (not Volume1IsOuter) then begin
    j:=Volume.Areas.IndexOf(SelfE);
    if j=-1 then
      (Volume.Areas as IDMCollection2).Add(SelfE);
    if not IsVertical then begin
      j:=Volume.TopAreas.IndexOf(SelfE);
      if j=-1 then
        (Volume.TopAreas as IDMCollection2).Add(SelfE);
    end;
  end;
end;

procedure TArea.DisconnectFrom(const aParent: IDMElement);
begin
  inherited;
  if aParent=Volume0 as IDMElement then
    Volume0:=nil
  else
  if aParent=Volume1 as IDMElement then
    Volume1:=nil
end;

procedure TArea.CalcSquare;

var a,b,c,S, X,Y,px,py,pz,Zn:double;
    i,j,OldState:integer;
    Line1,Line2,aLine, NewLine:ILine;
    aLineE, NewLineE:IDMElement;
    aLines:IDMCollection;
    aLines2, Lines2:IDMCollection2;
    Document:IDMDocument;
    SMOperationManager:ISMOperationManager;
    Int:boolean;

begin
  FSquare:=0;

  Document:=DataModel.Document as IDMDocument;
  if Document.QueryInterface(ISMOperationManager, SMOperationManager)<>0 then Exit;
  OldState:=DataModel.State;
  DataModel.State:=DataModel.State or dmfLoading or dmfCommiting;
  try

  S:=0;
  Lines2:=(DataModel as ISpatialModel).Lines as IDMCollection2;
  aLines:=TDMCollection.Create(nil) as IDMCollection;
  aLines2:=aLines as IDMCollection2;

  for i:=0 to FLines.Count-1 do begin
    aLineE:=FLines.Item[i];
    aLine:=aLineE as ILine;
    NewLineE:=Lines2.CreateElement(True);
    NewLine:=NewLineE as ILine;
    NewLine.C0:=aLine.C0;
    NewLine.C1:=aLine.C1;
    aLines2.Add(NewLineE);
  end;

  if aLines.Count<2 then Exit;
  i:=0;
  Repeat  begin
    NewLineE:=Lines2.CreateElement(True);
    NewLine:=NewLineE as ILine;
    Line1:=aLines.Item[i] as ILine;
    Line2:=aLines.Item[i+1] as ILine;
    a:=Line1.Length;
    b:=Line2.Length;
    if Line1.C0=Line2.C0 then begin
      NewLine.C0:=Line1.C1;
      NewLine.C1:=Line2.C1;
    end;
    if (Line1.C1=Line2.C0)then begin
      NewLine.C0:=Line1.C0;
      NewLine.C1:=Line2.C1;
    end;
    if (Line1.C0=Line2.C1)then begin
      NewLine.C0:=Line1.C1;
      NewLine.C1:=Line2.C0;
    end;
    if (Line1.C1=Line2.C1)then begin
      NewLine.C0:=Line1.C0;
      NewLine.C1:=Line2.C0;
    end;
    c:=NewLine.Length;
    Int:=false;

    for j:=0 to (aLines.Count-1) do begin
      if (LineIntersectLine      (NewLine.C0.X,NewLine.C0.Y,NewLine.C0.Z,
                                   NewLine.C1.X,NewLine.C1.Y,NewLine.C1.Z,
                                  (aLines.Item[j] as ILine).C0.X,
                                  (aLines.Item[j] as ILine).C0.Y,
                                  (aLines.Item[j] as ILine).C0.Z,
                                  (aLines.Item[j] as ILine).C1.X,
                                  (aLines.Item[j] as ILine).C1.Y,
                                  (aLines.Item[j] as ILine).C1.Z,px,py,pz)=true)and
                              not(((abs(px-NewLine.C0.X)<1)and(abs(py-NewLine.C0.Y)<1))or
                                   ((abs(px-NewLine.C1.X)<1)and(abs(py-NewLine.C1.Y)<1))) then
        begin
            Int:=true;
            break;
        end
    end;

    if Int=false then begin
      X:=(NewLine.C0.X+NewLine.C1.X)/2;
      Y:=(NewLine.C0.Y+NewLine.C1.Y)/2;

      if OutlineContainsPoint(X,Y,0,aLines)=true then
        Zn:=1
      else
        Zn:=-1;

      S:=S+Zn*SQRT((a+b+c)/2*((a+b+c)/2-a)*((a+b+c)/2-b)*((a+b+c)/2-c))/10000;
      Line1.C0:=nil;
      Line1.C1:=nil;
      Line2.C0:=nil;
      Line2.C1:=nil;
      (aLines as IDMCollection2).Insert(i,NewLine as IDMElement);
      (aLines as IDMCollection2).Remove(Line1 as IDMElement);
      (aLines as IDMCollection2).Remove(Line2 as IDMElement);
      i:=-1;
    end;
    i:=i+1;
  end;
  until (aLines.Count=2) or
        (aLines.Count=i+1);

  FSquare:=S;


  finally
    DataModel.State:=OldState;
    aLines2.Clear;
  end;

end;

function TArea.GetDistanceFrom(X, Y, Z:double): double;
var
  X0, Y0, Z0:double;
  C0:ICoordNode;
  Lines:IDMCollection;
  Line:ILine;
begin
  Result:=InfinitValue;
  Lines:=Get_Lines;
  if Lines.Count=0 then Exit;
  Line:=Lines.Item[0] as ILine;
  C0:=Line.C0;
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z;
  Result:=abs(FNX*(X-X0)+FNY*(Y-Y0)+FNZ*(Z-Z0));
end;

procedure TArea.UpdateCoords;
begin
  inherited;
  CalcMinMaxZ;
  MakeBottomTopLines;
  FindC0C1;
  CalcNormal;
//  CalcSquare;
end;

function TArea.Get_Volume0IsOuter: WordBool;
begin
  Result:=((FFlags and afVolume0IsOuter)<>0)
end;

function TArea.Get_Volume1IsOuter: WordBool;
begin
  Result:=((FFlags and afVolume1IsOuter)<>0)
end;

procedure TArea.Set_Volume0IsOuter(Value: WordBool);
var
  Flags:integer;
begin
  if Value then
    Flags:=FFlags or afVolume0IsOuter
  else
    Flags:=FFlags and not afVolume0IsOuter;
  Set_FieldValue(ord(areFlags), Flags)
end;

procedure TArea.Set_Volume1IsOuter(Value: WordBool);
var
  Flags:integer;
begin
  if Value then
    Flags:=FFlags or afVolume1IsOuter
  else
    Flags:=FFlags and not afVolume1IsOuter;
  Set_FieldValue(ord(areFlags), Flags)
end;

function TArea.Get_Flags: integer;
begin
  Result:=FFlags
end;

procedure TArea.Set_Flags(Value: integer);
begin
  FFlags:=Value
end;

procedure TArea.AfterLoading2;
var
   PX, PY, PZ:double;
begin
  inherited;

  GetCentralPoint(PX, PY, PZ);
  PX:=PX+FNX;
  PY:=PY+FNY;
  PZ:=PZ+FNZ;
  if Volume0<>nil then begin  // нормаль направлена из Volume0 в Volume1
    if Volume0.ContainsPoint(PX, PY, PZ) then begin
      FNX:=-FNX;
      FNY:=-FNY;
      FNZ:=-FNZ;
    end;
  end else
  if Volume1<>nil then begin
    if not Volume1.ContainsPoint(PX, PY, PZ) then begin
      FNX:=-FNX;
      FNY:=-FNY;
      FNZ:=-FNZ;
    end;
  end;
  
end;

procedure TArea.Set_Selected(Value: WordBool);
var
  Painter:IUnknown;
  Document:IDMDocument;
  C0, C1:ICoordNode;
  C0E, C1E:IDMElement;
begin
  if Selected=Value then Exit;
  inherited;
  if DataModel=nil then Exit;
  if DataModel.InUndoRedo then Exit;
  if Value then Exit;
  if not FIsVertical then Exit;
  C0:=Get_C0;
  C1:=Get_C1;
  if C0=nil then Exit;
  if C1=nil then Exit;

  Document:=DataModel.Document as IDMDocument;
  Painter:=(Document as ISMDocument).PainterU;
  C0E:=C0 as IDMElement;
  C0E.Draw(Painter, -1);
  C1E:=C1 as IDMElement;
  C1E.Draw(Painter, -1);
end;

function TArea._AddRef: Integer;
begin
  Result:=inherited _AddRef
end;

function TArea._Release: Integer;
begin
  Result:=inherited _Release
end;

function TArea.Get_Vol0(Direction: integer): IVolume;
var
  Unk:IUnknown;
  V:Variant;
begin
  if Direction=0 then
    V:=FVolume0
  else
    V:=FVolume1;

  if not VarIsNull(V) and
     not VarIsClear(V) then begin
    Unk:=V;
    Result:=Unk as IVolume
  end else
    Result:=nil
end;

function TArea.Get_Vol1(Direction: integer): IVolume;
var
  Unk:IUnknown;
  V:Variant;
begin
  if Direction=0 then
    V:=FVolume1
  else
    V:=FVolume0;

  if not VarIsNull(V) and
     not VarIsClear(V) then begin
    Unk:=V;
    Result:=Unk as IVolume
  end else
    Result:=nil
end;

procedure TArea.Set_Vol0(Direction:integer; const Value: IVolume);
begin
  if Direction=0 then
    Set_FieldValue(ord(areVolume0), Value as IUnknown)
  else
    Set_FieldValue(ord(areVolume1), Value as IUnknown)
end;

procedure TArea.Set_Vol1(Direction:integer; const Value: IVolume);
begin
  if Direction=0 then
    Set_FieldValue(ord(areVolume1), Value as IUnknown)
  else
    Set_FieldValue(ord(areVolume0), Value as IUnknown)
end;

function TArea.Get_Vol0IsOuter(Direction:integer): WordBool;
begin
  if Direction=0 then
    Result:=((FFlags and afVolume0IsOuter)<>0)
  else
    Result:=((FFlags and afVolume1IsOuter)<>0)
end;

function TArea.Get_Vol1IsOuter(Direction:integer): WordBool;
begin
  if Direction=0 then
    Result:=((FFlags and afVolume1IsOuter)<>0)
  else
    Result:=((FFlags and afVolume0IsOuter)<>0)
end;

procedure TArea.Set_Vol0IsOuter(Direction:integer; Value: WordBool);
var
  Flags:integer;
begin
  if Direction=0 then begin
    if Value then
      Flags:=FFlags or afVolume0IsOuter
    else
      Flags:=FFlags and not afVolume0IsOuter;
  end else begin
    if Value then
      Flags:=FFlags or afVolume1IsOuter
    else
      Flags:=FFlags and not afVolume1IsOuter;
  end;
  Set_FieldValue(ord(areFlags), Flags)
end;

procedure TArea.Set_Vol1IsOuter(Direction:integer; Value: WordBool);
var
  Flags:integer;
begin
  if Direction=0 then begin
    if Value then
      Flags:=FFlags or afVolume1IsOuter
    else
      Flags:=FFlags and not afVolume1IsOuter;
  end else begin
    if Value then
      Flags:=FFlags or afVolume0IsOuter
    else
      Flags:=FFlags and not afVolume0IsOuter;
  end;
  Set_FieldValue(ord(areFlags), Flags)
end;

function TArea.Get_BLines(Direction: integer): IDMCollection;
begin
  if Direction=0 then
    Result:=FBottomLines
  else
    Result:=FTopLines
end;

function TArea.Get_TLines(Direction: integer): IDMCollection;
begin
  if Direction=0 then
    Result:=FTopLines
  else
    Result:=FBottomLines
end;

function TArea.Get_MnZ(Direction: integer): double;
begin
  if Direction=0 then
    Result:=FMinZ
  else
    Result:=FMaxZ
end;

function TArea.Get_MxZ(Direction: integer): double;
begin
  if Direction=0 then
    Result:=FMaxZ
  else
    Result:=FMinZ
end;

procedure TArea.Set_MnZ(Direction: integer; Value: double);
begin
  if Direction=0 then
    FMinZ:=Value
  else
    FMaxZ:=Value
end;

procedure TArea.Set_MxZ(Direction: integer; Value: double);
begin
  if Direction=0 then
    FMaxZ:=Value
  else
    FMinZ:=Value
end;

procedure TArea.RemoveChild(const Element: IDMElement);
begin
  inherited;

end;

{ TAreas }

class function TAreas.GetElementClass: TDMElementClass;
begin
  Result:=TArea;
end;

function TAreas.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsArea;
end;

class function TAreas.GetElementGUID: TGUID;
begin
  Result:=IID_IArea;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TArea.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
