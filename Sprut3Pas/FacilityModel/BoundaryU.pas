unit BoundaryU;

interface
uses
  Classes, SysUtils, Variants, Math, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomBoundaryU;

type
  TBoundary=class(TCustomBoundary, IBoundary3)
//  класс, представляющий границу между секторами зон
  private
    FShowLayersMode:integer;
    FMaxBoundaryDistance: Double;
    FMaxPathAlongBoundaryDistance: Double;
    FShoulderWidth: Double;

    FNeighbourDist0:double;
    FNeighbourDist1:double;

    FDrawingState:boolean;
    FBottomEdgeHeight:double;

    FRightSideIsInner:boolean;
    procedure CorrectLayerPositions; //высчитывает координаты концов слоев рубежа
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;
    function  Get_NeighbourDist0:double; override; safecall;
    function  Get_NeighbourDist1:double; override; safecall;

    procedure Set_Ref(const Value: IDMElement); override; safecall;

    procedure Set_Selected(Value: WordBool); override;
    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
    procedure AfterLoading2; override; safecall;
    procedure UpdateCoords; override; safecall;
    procedure AfterCopyFrom(const SourceElement:IDMElement); override; safecall;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;

    function  Get_MaxBoundaryDistance: Double; safecall;
    procedure Set_MaxBoundaryDistance(Value: Double); safecall;
    function  Get_MaxPathAlongBoundaryDistance: Double; safecall;
    procedure Set_MaxPathAlongBoundaryDistance(Value: Double); safecall;
    function  Get_ShoulderWidth: Double; safecall;
    procedure Set_ShoulderWidth(Value: Double); safecall;
    function  Get_RightSideIsInner:WordBool; safecall;

    procedure CalcExternalDelayTime(out dT, dTDisp: double; out BestTacticE:IDMElement); override; safecall;
    procedure Initialize; override;
  end;

  TBoundaries=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  FacilityModelConstU, Geometry;

var
  FFields:IDMCollection;

{ TBoundary }

class function TBoundary.GetClassID: integer;
begin
  Result:=_Boundary
end;

class function TBoundary.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TBoundary.MakeFields0;
var
  S:WideString;
begin
  inherited;
  S:='|'+rsShowOnlyBoundaryLayers+
     '|'+rsShowOnlyBoundaryArea+
     '|'+rsShowBoundaryAreaAndLayers;
  AddField(rsShowLayersMode,  S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(bopShowLayersMode), 0, pkView);
  AddField(rsMaxBoundaryDistance, '%0.0f', '', '',
                  fvtFloat, 10000, 0, 0,
                  ord(bopMaxBoundaryDistance), 0, pkAnalysis);
  AddField(rsMaxPathAlongBoundaryDistance, '%0.0f', '', '',
                  fvtFloat, 1000, 0, 0,
                  ord(bopMaxPathAlongBoundaryDistance), 0, pkAnalysis);
  AddField(rsShoulderWidth, '%0.0f', '', '',
                  fvtFloat, 100, 0, 0,
                  ord(bopShoulderWidth), 0, pkAnalysis);
  AddField(rsBottomEdgeHeight, '%0.0f', '', '',
                  fvtFloat, 70, 0, 0,
                  ord(bopBottomEdgeHeight), 0, pkInput);
end;

function TBoundary.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(bopShowLayersMode):
    Result:=FShowLayersMode;
  ord(bopMaxBoundaryDistance):
    Result:=FMaxBoundaryDistance;
  ord(bopMaxPathAlongBoundaryDistance):
    Result:=FMaxPathAlongBoundaryDistance;
  ord(bopShoulderWidth):
    Result:=FShoulderWidth;
  ord(bopBottomEdgeHeight):
    Result:=FBottomEdgeHeight;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TBoundary.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(bopShowLayersMode):
    FShowLayersMode:=Value;
  ord(bopMaxBoundaryDistance):
    FMaxBoundaryDistance:=Value;
  ord(bopMaxPathAlongBoundaryDistance):
    FMaxPathAlongBoundaryDistance:=Value;
  ord(bopShoulderWidth):
    FShoulderWidth:=Value;
  ord(bopBottomEdgeHeight):
    FBottomEdgeHeight:=Value;
  else
    inherited
  end;
end;

function TBoundary.Get_MaxBoundaryDistance: Double;
begin
  Result:=FMaxBoundaryDistance
end;

function TBoundary.Get_MaxPathAlongBoundaryDistance: Double;
begin
  Result:=FMaxPathAlongBoundaryDistance
end;

function TBoundary.Get_ShoulderWidth: Double;
begin
  Result:=FShoulderWidth
end;

procedure TBoundary.Set_MaxBoundaryDistance(Value: Double);
begin
  FMaxBoundaryDistance:=Value
end;

procedure TBoundary.Set_MaxPathAlongBoundaryDistance(Value: Double);
begin
  FMaxPathAlongBoundaryDistance:=Value
end;

procedure TBoundary.Set_ShoulderWidth(Value: Double);
begin
  FShoulderWidth:=Value
end;

procedure TBoundary.Set_Ref(const Value: IDMElement);
var
  FacilityModel:IFacilityModel;
  BoundaryKind:IBoundaryKind;
  BoundaryLayer:IBoundaryLayer;
begin
  inherited;

  if Value=nil then Exit;
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if not DataModel.IsChanging then Exit;
  if ((DataModel.Document as IDMDocument).State and dmfRollbacking)<>0 then Exit;
  if Value.QueryInterface(IBoundaryKind, BoundaryKind)<>0 then Exit;

  FacilityModel:=DataModel as IFacilityModel;

  FMaxBoundaryDistance:=FacilityModel.MaxBoundaryDistance;
  FMaxPathAlongBoundaryDistance:=FacilityModel.MaxPathAlongBoundaryDistance;
  FShoulderWidth:=FacilityModel.ShoulderWidth;
  if FBoundaryLayers.Count>1 then
    FShowLayersMode:=slmShowOnlyBoundaryLayers
  else
  if FBoundaryLayers.Count=1 then begin
    BoundaryLayer:=FBoundaryLayers.Item[0] as IBoundaryLayer;
    if BoundaryLayer.Height0>0 then
      FShowLayersMode:=slmShowOnlyBoundaryLayers
    else
      FShowLayersMode:=slmShowOnlyBoundaryArea;
  end;

  FBottomEdgeHeight:=BoundaryKind.DefaultBottomEdgeHeight;
end;

procedure TBoundary.Draw(const aPainter:IUnknown; DrawSelected:integer);
var
  j:integer;
  BoundaryLayerE:IDMElement;
  DefaultDrawFlag:boolean;
  OldColor:integer;
  Q:integer;
  aZone:IVulnerabilityData;
  FacilityModelVM:IVulnerabilityMap;
  AreaS:ISpatialElement;
  Painter:IPainter;
  SpatialModel2:ISpatialModel2;
  Area:IArea;
  Document:DMDocument;
  OldState:integer;
  WarriorPathE:IDMElement;
  C0, C1:ICoordNode;
  CanvasLevel:integer;
  X0, Y0, Z0, X1, Y1, Z1:double;
  Painter3:IPainter3;
  BoundaryLayer:IBoundaryLayer;
  View:IView;
begin
  Area:=SpatialElement as IArea;
  if Area=nil then Exit;
  if Ref=nil then Exit;
  if (not (SpatialElement.Parent as ILayer).Visible) and
      not Selected then Exit;

  FacilityModelVM:=DataModel as IVulnerabilityMap;
  Painter:=aPainter as IPainter;
  if Painter=nil then Exit;

  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfExecuting;
  try

  SpatialModel2:=DataModel as ISpatialModel2;
  DefaultDrawFlag:=True;
  C0:=Area.C0;
  C1:=Area.C1;
  if Area.IsVertical then begin
    if C0=nil then Exit;
    if C1=nil then Exit;

    X0:=C0.X;
    Y0:=C0.Y;
    Z0:=C0.Z;
    X1:=C1.X;
    Y1:=C1.Y;
    Z1:=C1.Z;
    if Painter.QueryInterface(IPainter3, Painter3)=0 then
      if ((Painter3.CanvasSet and BackCanvas)<>0) or
         ((Painter3.CanvasSet and BackCanvas2)<>0) then
        CanvasLevel:=BackCanvas
      else
        CanvasLevel:=FrontCanvas
    else
      CanvasLevel:=FrontCanvas;

    if not Painter.LineIsVisible(1, X0, Y0, Z0, X1, Y1, Z1, False, CanvasLevel) then begin
      if FBoundaryLayers.Count=0 then
        Exit
      else
        BoundaryLayerE:=FBoundaryLayers.Item[FBoundaryLayers.Count-1];
        BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
        X0:=BoundaryLayer.X0;
        Y0:=BoundaryLayer.Y0;
        X1:=BoundaryLayer.X1;
        Y1:=BoundaryLayer.Y1;
        if not Painter.LineIsVisible(1, X0, Y0, Z0, X1, Y1, Z1, False, CanvasLevel) then
          Exit;
    end;

    if (FShowLayersMode<>slmShowOnlyBoundaryArea) and
       (not FacilityModelVM.ShowOnlyBoundaryAreas) and  // Показывать слои рубежа
       (Ref.Parent.ID<>btVirtual) then begin  // если не условная граница
      for j:=0 to FBoundaryLayers.Count-1 do begin
        BoundaryLayerE:=FBoundaryLayers.Item[j];
        BoundaryLayerE.Draw(aPainter, DrawSelected);
      end;
    end;
    if (FShowLayersMode<>slmShowOnlyBoundaryLayers) or
        FacilityModelVM.ShowOnlyBoundaryAreas or  //Показывать контур рубежа
       Selected or
       (DrawSelected<>0) then
      inherited
    else begin
      View:=Painter.ViewU as IView;
      if (Z0<View.Zmin) or
         (Z1<View.Zmin) and
         (Area.TopLines.Count>0) then begin
        inherited
      end;
    end;

    Painter.LocalViewU:=nil;
  end else begin
    AreaS:=SpatialElement as ISpatialElement;
    aZone:=Get_Zone0 as IVulnerabilityData;
    if DefaultDrawFlag then begin
      if aZone=nil then
        aZone:=Get_Zone1 as IVulnerabilityData;
      OldColor:=AreaS.Color;
      case SpatialModel2.RenderAreasMode of
      0:AreaS.Color:=0;
      1:begin end;
        2:if aZone.RationalProbabilityToTarget<>-InfinitValue then begin
          Q:=round($FF*(1-aZone.RationalProbabilityToTarget));
            AreaS.Color:=$FF+(Q shl 8)+(Q shl 16)
        end else
          AreaS.Color:=0;
      3:if aZone.DelayTimeToTarget<>-InfinitValue then begin
          Q:=round($FF*(aZone as IZone).RelativeDelayTimeToTarget);
          AreaS.Color:=$FF+(Q shl 8)+(Q shl 16)
        end else
          AreaS.Color:=0;
      4:if aZone.NoDetectionProbabilityFromStart<>-InfinitValue then begin
          Q:=round($FF*(1-aZone.NoDetectionProbabilityFromStart));
          AreaS.Color:=$FF+(Q shl 8)+(Q shl 16)
        end else
          AreaS.Color:=0;
      end;
      if (FShowLayersMode<>slmShowOnlyBoundaryLayers) or     //Показывать контур рубежа
         FacilityModelVM.ShowOnlyBoundaryAreas or
         (AreaS.Color<>0) or
         Selected or
         (DrawSelected<>0) then
        inherited;
      AreaS.Color:=OldColor;
    end;
  end;

  finally
    Document.State:=OldState;
  end;

  try
  if (Get_SMLabel<>nil) and
     (DataModel as IVulnerabilityMap).ShowText then
    Get_SMLabel.Draw(aPainter, DrawSelected);
  except
    raise
  end;

  if FWarriorPaths.Count=0 then Exit;
  if FDrawingState then Exit;
  FDrawingState:=True;

  if FacilityModelVM.ShowOptimalPathFromBoundary then begin
    WarriorPathE:=Get_OptimalPath as IDMElement;
    if WarriorPathE<>nil then begin
      if SpatialElement.Selected then
        WarriorPathE.Draw(aPainter, 0)
      else
        WarriorPathE.Draw(aPainter, -1)
    end;
  end;

  if FacilityModelVM.ShowFastPathFromBoundary then begin
    WarriorPathE:=Get_FastPath as IDMElement;
    if WarriorPathE<>nil then begin
      if SpatialElement.Selected then
        WarriorPathE.Draw(aPainter, 0)
      else
        WarriorPathE.Draw(aPainter, -1)
    end;
  end;

  if FacilityModelVM.ShowStealthPathToBoundary then begin
    WarriorPathE:=Get_StealthPath as IDMElement;
    if WarriorPathE<>nil then begin
      if SpatialElement.Selected then
        WarriorPathE.Draw(aPainter, 0)
      else
        WarriorPathE.Draw(aPainter, -1)
    end;
  end;

  FDrawingState:=False;
end;

procedure TBoundary.Set_Selected(Value: WordBool);
var
  Document:IDMDocument;
  Painter:IUnknown;
  Area:IArea;
begin
  if not Value then begin
    Document:=DataModel.Document as IDMDocument;
    Painter:=(Document as ISMDocument).PainterU;
    Area:=SpatialElement as IArea;
    if (Area<>nil) and
      Area.IsVertical then
      inherited Draw(Painter, -1);
  end;

  inherited;
end;

function TBoundary.FieldIsVisible(Code: Integer): WordBool;
var
  BoundaryKind:IBoundaryKind;
begin
  case Code of
  ord(bopBottomEdgeHeight):
    begin
      BoundaryKind:=Ref as IBoundaryKind;
      Result:=(BoundaryKind.DefaultBottomEdgeHeight>0);
    end;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

procedure TBoundary.CalcExternalDelayTime(out dT, dTDisp: double; out BestTacticE: IDMElement);
begin
  inherited;
  if FBottomEdgeHeight>0 then begin
  end;
end;

procedure TBoundary.CorrectLayerPositions;
var
  j:integer;
  BoundaryLayer:IBoundaryLayer;
  L:double;
  Area, aArea, AreaInner:IArea;
  VolumeInner:IVolume;
  BottomLineE, aAreaE, BoundaryLayerE:IDMElement;
  C0, C1:ICoordNode;
  BX0, BY0, BX1, BY1, BL,
  X0, Y0, X1, Y1,
  XP, YP, XM, YM,
  XC, YC, ZC:double;
  VLine0E, VLine1E:IDMElement;

  function GetVolumeInner(const Area:IArea):IVolume;
  var
    Volume0, Volume1:IVolume;
    Zone0, Zone1:IZone;
  begin
    Result:=nil;
    Volume0:=Area.Volume0;
    Volume1:=Area.Volume1;
    if (Volume0=nil) and (Volume1=nil) then Exit;

    if Volume0=nil then
      Result:=Volume1
    else
    if Volume1=nil then
      Result:=Volume0
    else begin
      Zone0:=(Volume0 as IDMElement).Ref as IZone;
      Zone1:=(Volume1 as IDMElement).Ref as IZone;
      if (Zone0=nil) and (Zone1=nil) then Exit;
      if Zone0=nil then
        Result:=Volume1
      else
      if Zone1=nil then
        Result:=Volume0
      else begin
        if Zone0.Category>=Zone1.Category then
          Result:=Volume0
        else
          Result:=Volume1;
      end;
    end;
  end;

  procedure ResetNeighbours(const VLineE:IDMElement; const Node:ICoordNode);
  var
    j, m:integer;
    aArea:IArea;
    aAreaE:IDMElement;
    aBoundary:IBoundary;
    aBoundaryLayer:IBoundaryLayer;
  begin
    try
    for j:=0 to VLineE.Parents.Count-1 do begin
      aAreaE:=VLineE.Parents.Item[j];
      if (aAreaE<>SpatialElement) and
         (aAreaE.QueryInterface(IArea, aArea)=0) and
         (aAreaE.Ref<>nil) then begin
        aBoundary:=aAreaE.Ref as IBoundary;
        for m:=0 to aBoundary.BoundaryLayers.Count-1 do begin
          aBoundaryLayer:=aBoundary.BoundaryLayers.Item[m] as IBoundaryLayer;
          if Node=aArea.C0 then
            aBoundaryLayer.Neighbour0:=nil
          else
            aBoundaryLayer.Neighbour1:=nil;
        end;
      end;
    end;
    except
      DataModel.HandleError('Error in CorrectLayerPositions. BoundaryID='+IntToStr(ID));
    end;
  end;


  procedure CheckNeighbours(const VLineE:IDMElement; const Node:ICoordNode);
  var
    j, m:integer;
    aArea:IArea;
    aAreaE:IDMElement;
    aBoundary:IBoundary;
    aBoundaryLayerE, NeighbourE:IDMElement;
    aBoundaryLayer:IBoundaryLayer;
    aL, aBX0, aBY0, aBX1, aBY1, PX,  PY, aDist:double;
//    aVolumeInner:IVolume;
    SpatialModel2:ISpatialModel2;
  begin
    try
    SpatialModel2:=DataModel as ISpatialModel2;

    if (FBoundaryLayers.Count=1) and
       (VLineE.Parents.Count>2) then begin
{      for j:=0 to VLineE.Parents.Count-1 do begin
        aAreaE:=VLineE.Parents.Item[j];
        if (aAreaE<>SpatialElement) and
           (aAreaE.QueryInterface(IArea, aArea)=0) and
           (aAreaE.Ref<>nil) then begin
          aBoundary:=aAreaE.Ref as IBoundary;
          aL:=0;
          for m:=0 to aBoundary.BoundaryLayers.Count-1 do begin
            aBoundaryLayerE:=aBoundary.BoundaryLayers.Item[m];
            aBoundaryLayer:=aBoundaryLayerE as IBoundaryLayer;
            aL:=aL+aBoundaryLayer.DistanceFromPrev*100;
          end;
          if aL<>0 then begin
            aBX0:=aBoundaryLayer.X0;
            aBY0:=aBoundaryLayer.Y0;
            aBX1:=aBoundaryLayer.X1;
            aBY1:=aBoundaryLayer.Y1;
            if LineCanIntersectLine(
                         BX0, BY0, 0,
                         BX1, BY1, 0,
                         aBX0, aBY0, 0,
                         aBX1, aBY1, 0,
                         PX,  PY,  PZ) and
                 (PX>=SpatialModel2.MinX) and
                 (PX<=SpatialModel2.MaxX) and
                 (PY>=SpatialModel2.MinY) and
                 (PY<=SpatialModel2.MaxY) then begin
              if Node=C0 then begin
                aDist:=((PX-X0)*(X1-X0)+(PY-Y0)*(Y1-Y0))/BL;
                if FNeighbourDist0<aDist then
                  FNeighbourDist0:=aDist;
              end else begin
                aDist:=((PX-X1)*(X0-X1)+(PY-Y1)*(Y0-Y1))/BL;
                if FNeighbourDist1<aDist then
                  FNeighbourDist1:=aDist;
              end;

              if Node=C0 then begin
                BoundaryLayer.X0:=PX;
                BoundaryLayer.Y0:=PY;
                BoundaryLayer.Neighbour0:=aBoundaryLayerE;
              end else begin
                BoundaryLayer.X1:=PX;
                BoundaryLayer.Y1:=PY;
                BoundaryLayer.Neighbour1:=aBoundaryLayerE;
              end;

              Break;
            end;  //if LineCanIntersectLine
          end;  //if abs(aL)=abs(L) then
        end; // if (aAreaE<>SpatialElement) and ...
      end;  // for j:=0 to VLineE.Parents.Count-1
      if j=VLineE.Parents.Count then begin  // не нашли
        for j:=0 to VLineE.Parents.Count-1 do begin
          aAreaE:=VLineE.Parents.Item[j];
          if (aAreaE<>SpatialElement) and
             (aAreaE.QueryInterface(IArea, aArea)=0) and
             (aAreaE.Ref<>nil) then begin
            aBoundary:=aAreaE.Ref as IBoundary;
            aBoundaryLayerE:=aBoundary.BoundaryLayers.Item[0];
            aBoundaryLayer:=aBoundaryLayerE as IBoundaryLayer;

            if Node=C0 then
              BoundaryLayer.Neighbour0:=aBoundaryLayerE
            else
              BoundaryLayer.Neighbour1:=aBoundaryLayerE;
          end;
        end;
      end;
}
    end else begin// if (FBoundaryLayers.Count=1) and ...
      for j:=0 to VLineE.Parents.Count-1 do begin
        aAreaE:=VLineE.Parents.Item[j];
        if (aAreaE<>SpatialElement) and
           (aAreaE.QueryInterface(IArea, aArea)=0) and
           (aAreaE.Ref<>nil) then begin
          aBoundary:=aAreaE.Ref as IBoundary;
          {aVolumeInner:=GetVolumeInner(aArea);
          if (VolumeInner=aVolumeInner) or
             (VolumeInner.AdjacentTo(aVolumeInner) and
              (VolumeInner.Areas.IndexOf(aAreaE)=-1)) then begin}

            aL:=0;
            m:=0;
            while m<aBoundary.BoundaryLayers.Count do begin
              aBoundaryLayerE:=aBoundary.BoundaryLayers.Item[m];
              aBoundaryLayer:=aBoundaryLayerE as IBoundaryLayer;

              aL:=aL+aBoundaryLayer.DistanceFromPrev*100;
              if aL<>0 then begin
                if (abs(aL)=abs(L)) and
                   (BoundaryLayerE.Ref=aBoundaryLayerE.Ref) then begin
                  aBX0:=aBoundaryLayer.X0;
                  aBY0:=aBoundaryLayer.Y0;
                  aBX1:=aBoundaryLayer.X1;
                  aBY1:=aBoundaryLayer.Y1;
                  if LineCanIntersectLine0(
                             BX0, BY0,
                             BX1, BY1,
                             aBX0, aBY0,
                             aBX1, aBY1,
                             PX,  PY) and
                     (PX>=SpatialModel2.MinX) and
                     (PX<=SpatialModel2.MaxX) and
                     (PY>=SpatialModel2.MinY) and
                     (PY<=SpatialModel2.MaxY) then begin

                    if Node=C0 then begin
                      aDist:=((PX-X0)*(X1-X0)+(PY-Y0)*(Y1-Y0))/BL;
                      if FNeighbourDist0<aDist then
                        FNeighbourDist0:=aDist;
                    end else begin
                      aDist:=((PX-X1)*(X0-X1)+(PY-Y1)*(Y0-Y1))/BL;
                      if FNeighbourDist1<aDist then
                        FNeighbourDist1:=aDist;
                    end;

                    if Node=C0 then begin
                      BoundaryLayer.X0:=PX;
                      BoundaryLayer.Y0:=PY;
                      BoundaryLayer.Neighbour0:=aBoundaryLayerE;
                    end else begin
                      BoundaryLayer.X1:=PX;
                      BoundaryLayer.Y1:=PY;
                      BoundaryLayer.Neighbour1:=aBoundaryLayerE;
                    end;

                    if Node=aArea.C0 then begin
                      aBoundaryLayer.X0:=PX;
                      aBoundaryLayer.Y0:=PY;
                      aBoundaryLayer.Neighbour0:=BoundaryLayerE;
                    end else begin
                      aBoundaryLayer.X1:=PX;
                      aBoundaryLayer.Y1:=PY;
                      aBoundaryLayer.Neighbour1:=BoundaryLayerE;
                    end;
                  end;  //if LineCanIntersectLine0
                  Break;
                end else  //if abs(aL)=abs(L) then
                  inc(m)
              end else  //if aL=0
              if L=0 then begin
                if Node=C0 then
                  BoundaryLayer.Neighbour0:=aBoundaryLayerE
                else
                  BoundaryLayer.Neighbour1:=aBoundaryLayerE;

                if Node=aArea.C0 then
                  aBoundaryLayer.Neighbour0:=BoundaryLayerE
                else
                  aBoundaryLayer.Neighbour1:=BoundaryLayerE;
                Break
              end else  // if (L=0) and (aL=0) then
                inc(m)
            end;  // while m<aBoundary.BoundaryLayers.Count

            if m=aBoundary.BoundaryLayers.Count then begin  // не нашли
              m:=0;
              while m<aBoundary.BoundaryLayers.Count do begin
                aBoundaryLayerE:=aBoundary.BoundaryLayers.Item[m];
                aBoundaryLayer:=aBoundaryLayerE as IBoundaryLayer;
                if Node=aArea.C0 then
                  NeighbourE:=aBoundaryLayer.Neighbour0
                else
                  NeighbourE:=aBoundaryLayer.Neighbour1;

                if (NeighbourE=nil) and
                   (BoundaryLayerE.Ref=aBoundaryLayerE.Ref) then begin

                  aBX0:=aBoundaryLayer.X0;
                  aBY0:=aBoundaryLayer.Y0;
                  aBX1:=aBoundaryLayer.X1;
                  aBY1:=aBoundaryLayer.Y1;
                  if LineCanIntersectLine0(
                             BX0, BY0,
                             BX1, BY1,
                             aBX0, aBY0,
                             aBX1, aBY1,
                             PX,  PY) and
                     (PX>=SpatialModel2.MinX) and
                     (PX<=SpatialModel2.MaxX) and
                     (PY>=SpatialModel2.MinY) and
                     (PY<=SpatialModel2.MaxY) then begin

                    if Node=C0 then begin
                      aDist:=((PX-X0)*(X1-X0)+(PY-Y0)*(Y1-Y0))/BL;
                      if FNeighbourDist0<aDist then
                        FNeighbourDist0:=aDist;
                    end else begin
                      aDist:=((PX-X1)*(X0-X1)+(PY-Y1)*(Y0-Y1))/BL;
                      if FNeighbourDist1<aDist then
                        FNeighbourDist1:=aDist;
                    end;

                    if Node=C0 then begin
                      BoundaryLayer.X0:=PX;
                      BoundaryLayer.Y0:=PY;
                      BoundaryLayer.Neighbour0:=aBoundaryLayerE;
                    end else begin
                      BoundaryLayer.X1:=PX;
                      BoundaryLayer.Y1:=PY;
                      BoundaryLayer.Neighbour1:=aBoundaryLayerE;
                    end;

                    if Node=aArea.C0 then begin
                      aBoundaryLayer.X0:=PX;
                      aBoundaryLayer.Y0:=PY;
                      aBoundaryLayer.Neighbour0:=BoundaryLayerE;
                    end else begin
                      aBoundaryLayer.X1:=PX;
                      aBoundaryLayer.Y1:=PY;
                      aBoundaryLayer.Neighbour1:=BoundaryLayerE;
                    end;
                  end;
                  Break
                end else
                  inc(m)
              end;  // while m<aBoundary.BoundaryLayers.Count
            end; // if m=aBoundary.BoundaryLayers.Count (если не нашли)

//        end; //  if (VolumeInner=aVolumeInner) or ...
        end; // if (aAreaE<>SpatialElement) and ...
      end; // for j:=0 to VLineE.Parents.Count-1
    end; // // if (FBoundaryLayers.Count<>1)
    except
      DataModel.HandleError('Error in CorrectLayerPositions. BoundaryID='+IntToStr(ID));
    end;
  end;

var
  PlusFlag:boolean;
  H0, H1:double;
  TopC:ICoordNode;
  VLine:ILine;
  AreaP:IPolyline;
begin
  if SpatialElement=nil then Exit;
  if SpatialElement.QueryInterface(IArea, Area)<>0 then Exit;
  if not Area.IsVertical then Exit;

  C0:=Area.C0;
  C1:=Area.C1;
  if C0=nil then Exit;
  if C1=nil then Exit;
  X0:=C0.X;
  Y0:=C0.Y;
  X1:=C1.X;
  Y1:=C1.Y;
  BL:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
  VLine0E:=C0.GetVerticalLine(bdUp) as IDMElement;
  VLine1E:=C1.GetVerticalLine(bdUp) as IDMElement;

  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayer:=FBoundaryLayers.Item[j] as IBoundaryLayer;
    BoundaryLayer.X0:=X0;
    BoundaryLayer.Y0:=Y0;
    BoundaryLayer.X1:=X1;
    BoundaryLayer.Y1:=Y1;
  end;

  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayerE:=FBoundaryLayers.Item[j];
    BoundaryLayerE.Update;
  end;

  if Area.BottomLines.Count=0 then Exit;
  VolumeInner:=GetVolumeInner(Area);
  if VolumeInner=nil then Exit;

  try
  BottomLineE:=Area.BottomLines.Item[0];
  AreaInner:=nil;
  for j:=0 to BottomLineE.Parents.Count-1 do begin
    aAreaE:=BottomLineE.Parents.Item[j];
    if aAreaE.QueryInterface(IArea, aArea)=0 then begin
      if (not aArea.IsVertical) and
         (aArea.Volume0=VolumeInner) then begin
        AreaInner:=aArea;
        Break;
      end;
    end;
  end;
  if AreaInner=nil then Exit;
  AreaInner.GetCentralPoint(XC, YC, ZC);
  except
    DataModel.HandleError('Error in CorrectLayerPositions. BoundaryID='+IntToStr(ID));
  end;


  FNeighbourDist0:=0;
  FNeighbourDist1:=0;

  if not DataModel.IsLoading then begin
    if VLine0E<>nil then
      ResetNeighbours(VLine0E, C0);
    if VLine1E<>nil then
      ResetNeighbours(VLine1E, C1);
  end;

  PerpendicularTo(X0, Y0, X1, Y1, 1,
                  XP, YP, XM, YM);

  if ((YC-Y0)*(X1-X0)-(XC-X0)*(Y1-Y0))/
         (sqrt(sqr(X1-X0)+sqr(Y1-Y0))*sqrt(sqr(XC-X0)+sqr(YC-Y0)))>0 then
    FRightSideIsInner:=False
  else
    FRightSideIsInner:=True;

  if ((YP-Y0)*(X1-X0)-(XP-X0)*(Y1-Y0))/
         (sqrt(sqr(X1-X0)+sqr(Y1-Y0))*sqrt(sqr(XP-X0)+sqr(YP-Y0)))>0 then
    PlusFlag:=False
  else
    PlusFlag:=True;

  L:=0;
  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayerE:=FBoundaryLayers.Item[j];
    BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;
    if j=0 then
      BoundaryLayer.Prev:=nil
    else
      BoundaryLayer.Prev:=FBoundaryLayers.Item[j-1];
    L:=L+BoundaryLayer.DistanceFromPrev*100;
    if L<>0 then begin
      PerpendicularTo(X0, Y0, X1, Y1, L,
                      XP, YP, XM, YM);
      if FRightSideIsInner then begin
        if PlusFlag then begin
          BX0:=XP;
          BY0:=YP;
        end else begin
          BX0:=XM;
          BY0:=YM;
        end;
      end else begin
        if PlusFlag then begin
          BX0:=XM;
          BY0:=YM;
        end else begin
          BX0:=XP;
          BY0:=YP;
        end;
      end;
      BoundaryLayer.X0:=BX0;
      BoundaryLayer.Y0:=BY0;

      PerpendicularTo(X1, Y1, X0, Y0, L,
                      XP, YP, XM, YM);
      if FRightSideIsInner then begin
        if PlusFlag then begin
          BX1:=XP;
          BY1:=YP;
        end else begin
          BX1:=XM;
          BY1:=YM;
        end;
      end else begin
        if PlusFlag then begin
          BX1:=XM;
          BY1:=YM;
        end else begin
          BX1:=XP;
          BY1:=YP;
        end;
      end;
      BoundaryLayer.X1:=BX1;
      BoundaryLayer.Y1:=BY1;
    end;

    if not DataModel.IsLoading then begin
      BoundaryLayer.Neighbour0:=nil;
      BoundaryLayer.Neighbour1:=nil;
      if VLine0E<>nil then
        CheckNeighbours(VLine0E, C0);
      if VLine1E<>nil then
        CheckNeighbours(VLine1E, C1);
    end;
  end;

  AreaP:=Area as IPolyline;

  H0:=0;
  TopC:=C0;
  VLine:=TopC.GetVerticalLine(bdUp);
  while (VLine<>nil) and
   (AreaP.Lines.IndexOf(VLine as IDMElement)<>-1) do begin
    H0:=H0+VLine.Length;
    TopC:=VLine.C1;
    VLine:=TopC.GetVerticalLine(bdUp);
  end;

  H1:=0;
  TopC:=C1;
  VLine:=TopC.GetVerticalLine(bdUp);
  while (VLine<>nil) and
   (AreaP.Lines.IndexOf(VLine as IDMElement)<>-1) do begin
    H1:=H1+VLine.Length;
    TopC:=VLine.C1;
    VLine:=TopC.GetVerticalLine(bdUp);
  end;

  for j:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayerE:=FBoundaryLayers.Item[j];
    BoundaryLayer:=BoundaryLayerE as IBoundaryLayer;

    if BoundaryLayer.Height0>0.01*H0 then
      BoundaryLayer.Height0:=0.01*H0;
    if BoundaryLayer.Height1>0.01*H1 then
      BoundaryLayer.Height1:=0.01*H1;
  end;
end;

procedure TBoundary.Set_SpatialElement(const Value: IDMElement);
begin
  inherited;
  if Value=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  CorrectLayerPositions;
end;

procedure TBoundary.AfterLoading2;
begin
  inherited;
  CorrectLayerPositions;

end;

procedure TBoundary.UpdateCoords;
begin
  CorrectLayerPositions
end;

procedure TBoundary.AfterCopyFrom(const SourceElement: IDMElement);
begin
  if SourceElement=nil then
    CorrectLayerPositions;
end;

procedure TBoundary.Initialize;
begin
  inherited;
  FNeighbourDist0:=0;
  FNeighbourDist1:=0;
end;

function TBoundary.Get_NeighbourDist0: double;
begin
  Result:=FNeighbourDist0
end;

function TBoundary.Get_NeighbourDist1: double;
begin
  Result:=FNeighbourDist1
end;

function TBoundary.Get_RightSideIsInner: WordBool;
begin
  Result:=FRightSideIsInner
end;

{ TBoundaries }

function TBoundaries.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsBoundary
  else
    Result:=rsBoundaries
end;

class function TBoundaries.GetElementClass: TDMElementClass;
begin
  Result:=TBoundary;
end;

class function TBoundaries.GetElementGUID: TGUID;
begin
  Result:=IID_IBoundary;
end;


initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TBoundary.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
