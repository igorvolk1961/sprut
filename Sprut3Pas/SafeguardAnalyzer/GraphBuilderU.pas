unit GraphBuilderU;

interface
uses
  Classes,
  SysUtils, Math,
  DataModel_TLB,
  DMServer_TLB,
  SpatialModelLib_TLB,
  SgdbLib_TLB,
  FacilityModelLib_TLB,
  SafeguardAnalyzerLib_TLB,
  DMElementU, Geometry;


procedure MakePathGraphs(const SafeguardAnalyzerP:TObject);
procedure BuildPathGraph(const SafeguardAnalyzerP:TObject);
procedure RestoreZoneNodes(const SafeguardAnalyzerP:TObject);


implementation
uses
  SafeguardAnalyzerU,
  SafeguardAnalyzerConstU;

procedure MakeBoundaryPathArcs(const SafeguardAnalyzer:TSafeguardAnalyzer;
                               const AreaE, FacilityStateE:IDMElement; //создание дуг пересекающих границы зон
                               const theNode:ICoordNode; UseTheNode:boolean;
                               var theNode0, theNode1:ICoordNode);
var
  Area:IArea;
  PathNodes2, PathArcs2:IDMCollection2;
  FacilityState:IFacilityState;
  NodeList0, NodeList1:TList;
  C0E, C1E:IDMElement;
  Node02, Node12:IPathNode2;
  VerticalWays:IDMCollection;
  VerticalWays2:IDMCollection2;
  aFacilityModel:IFacilityModel;
  BoundaryWidth, ShoulderWidth, PathHeight,
  MaxBoundaryDistance, MaxPathAlongBoundaryDistance:double;
  Volume0, Volume1:IVolume;
  Zone0, Zone1:IZone;
  PathEnabled:boolean;

  procedure Set_CenterAt(X, Y, Z, aLength, cosX, cosY:double;
                           C0, C1:ICoordNode);
    var
      D0, D1, L2,
      P0X, P0Y, P0Z, P1X, P1Y, P1Z,
      W0X, W0Y, W0Z, W1X, W1Y, W1Z,
      aX, aY, aZ:double;
      j:integer;
      theArea:IArea;

      procedure SetNodePosition;
      begin
        C0.X:=P0X;
        C0.Y:=P0Y;
        C0.Z:=P0Z;
        C1.X:=P1X;
        C1.Y:=P1Y;
        C1.Z:=P1Z;

        if (Volume0<>nil) and
           not Volume0.ContainsPoint(P0X, P0Y, P0Z) then begin
          j:=0;
          while j<Volume0.Areas.Count do begin
            theArea:=Volume0.Areas.Item[j] as IArea;
            if theArea.IsVertical and
              (theArea<>Area) and
               theArea.IntersectLine(P0X, P0Y, P0Z, X, Y, Z, aX, aY, aZ) and
               ((P0X-aX)*(X-aX)<=0) and
               ((P0Y-aY)*(Y-aY)<=0) and
               ((P0Z-aZ)*(Z-aZ)<=0) then
              Break
            else
              inc(j)
          end;
          if j<Volume0.Areas.Count then begin
            C0.X:=0.5*(X+aX);
            C0.Y:=0.5*(Y+aY);
          end;
        end; // if not Volume0.ContainsPoint(P0X, P0Y, P0Z)

        if (Volume1<>nil) and
           not Volume1.ContainsPoint(P1X, P1Y, P1Z) then begin
          j:=0;
          while j<Volume1.Areas.Count do begin
            theArea:=Volume1.Areas.Item[j] as IArea;
            if theArea.IsVertical and
              (theArea<>Area) and
               theArea.IntersectLine(P1X, P1Y, P1Z, X, Y, Z, aX, aY, aZ) and
               ((P1X-aX)*(X-aX)<=0) and
               ((P1Y-aY)*(Y-aY)<=0) and
               ((P1Z-aZ)*(Z-aZ)<=0) then
              Break
            else
              inc(j)
          end;
          if j<Volume1.Areas.Count then begin
            C1.X:=0.5*(X+aX);
            C1.Y:=0.5*(Y+aY);
          end;
        end;  // if not Volume1.ContainsPoint(P1X, P1Y, P1Z)
      end;
    begin
      L2:=0.5*aLength;
      D0:=0;
      D1:=0;
      if Zone0=nil then
        D1:=BoundaryWidth*100
      else
      if Zone1=nil then
        D0:=BoundaryWidth*100
      else
      if Zone0.Category>Zone1.Category then
        D0:=BoundaryWidth*100
      else
        D1:=BoundaryWidth*100;

      W0X:=X-5*cosY;
      W0Y:=Y+5*cosX;
      W0Z:=Z;
      W1X:=X+5*cosY;
      W1Y:=Y-5*cosX;
      W1Z:=Z;

      P0X:=X-(L2+D0)*cosY;
      P0Y:=Y+(L2+D0)*cosX;
      P0Z:=Z;
      P1X:=X+(L2+D1)*cosY;
      P1Y:=Y-(L2+D1)*cosX;
      P1Z:=Z;

      if Volume0<>nil then begin
        if  Volume0.ContainsPoint(W0X, W0Y, W0Z) then begin
          SetNodePosition;
        end else begin // if Volume0.ContainsPoint(P0X, P0Y, P0Z)
          P0X:=X+(L2+D0)*cosY;
          P0Y:=Y-(L2+D0)*cosX;
          P1X:=X-(L2+D1)*cosY;
          P1Y:=Y+(L2+D1)*cosX;
          SetNodePosition;
        end;
      end else
      if Volume1<>nil then begin;
        if  Volume1.ContainsPoint(W1X, W1Y, W1Z) then begin
          SetNodePosition;
        end else begin // if Volume1.ContainsPoint(P1X, P1Y, P1Z)
          P0X:=X+(L2+D0)*cosY;
          P0Y:=Y-(L2+D0)*cosX;
          P1X:=X-(L2+D1)*cosY;
          P1Y:=Y+(L2+D1)*cosX;
          SetNodePosition;
        end;
      end;
    end;


  procedure AddToVerticalWay(const C0E, C1E, PathArcE:IDMElement; Side:integer);
  var
    j:integer;
    C0, C1:ICoordNode;
    X0, Y0, X1, Y1, X, Y:double;
    VerticalWay:IVerticalWay;
    VerticalWayE:IDMElement;
  begin
    C0:=C0E as ICoordNode;
    C1:=C1E as ICoordNode;
    X0:=C0.X;
    Y0:=C0.Y;
    X1:=C1.X;
    Y1:=C1.Y;

    X:=0.5*(X0+X1);
    Y:=0.5*(Y0+Y1);

    j:=0;
    VerticalWay:=nil;
    while j<VerticalWays.Count do begin
      VerticalWay:=VerticalWays.Item[j] as IVerticalWay;
      if ((sqr(X-VerticalWay.X)+sqr(Y-VerticalWay.Y))<=sqr(0.5*ShoulderWidth)) then
         Break
       else
         inc(j);
    end;
    if j=VerticalWays.Count then begin
      VerticalWayE:=VerticalWays2.CreateElement(False);
      VerticalWays2.Add(VerticalWayE);
      VerticalWay:=VerticalWayE as IVerticalWay;
      VerticalWay.X0:=X0;
      VerticalWay.Y0:=Y0;
      VerticalWay.X1:=X1;
      VerticalWay.Y1:=Y1;
      VerticalWay.Side:=Side;
    end else begin
      if VerticalWay.Side<>Side then
        VerticalWay.Side:=2;
    end;

    if PathArcE<>nil then
      VerticalWay.Usable:=True;
    case Side of
    0:begin
        if ((sqr(X0-VerticalWay.X0)+sqr(Y0-VerticalWay.Y0))<=sqr(0.5*ShoulderWidth)) then
          (VerticalWay.Nodes0 as IDMCollection2).Add(C0E)
        else
          (VerticalWay.Nodes0 as IDMCollection2).Add(C1E)
      end;
    1:begin
        if ((sqr(X1-VerticalWay.X1)+sqr(Y1-VerticalWay.Y1))<=sqr(0.5*ShoulderWidth)) then
          (VerticalWay.Nodes1 as IDMCollection2).Add(C1E)
        else
          (VerticalWay.Nodes1 as IDMCollection2).Add(C0E)
      end;
    else
      begin
        if ((sqr(X0-VerticalWay.X0)+sqr(Y0-VerticalWay.Y0))<sqr(0.5*ShoulderWidth)) then
          (VerticalWay.Nodes0 as IDMCollection2).Add(C0E)
        else
          (VerticalWay.Nodes0 as IDMCollection2).Add(C1E);
        if ((sqr(X1-VerticalWay.X1)+sqr(Y1-VerticalWay.Y1))<sqr(0.5*ShoulderWidth)) then
          (VerticalWay.Nodes1 as IDMCollection2).Add(C1E)
        else
          (VerticalWay.Nodes1 as IDMCollection2).Add(C0E)
      end;
    end;
  end;

  procedure AddHPathArc(const CC0, CC1:ICoordNode; F, cosX, cosY:double;
                       Boundary, BottomBoundary0, BottomBoundary1:IBoundary;
                       Zone0E, Zone1E:IDMElement; PathNodeKind, BoundaryPathKind:integer;
                       AddToFloor0, AddToFloor1:boolean;
                       var C0, C1:ICoordNode);

  var
    PathArc:ILine;
    PathArcE:IDMElement;
    X,Y,Z,D:double;
    BoundaryKind:IBoundaryKind;
  begin
    BoundaryKind:=(Boundary as IDMElement).Ref as IBoundaryKind;

    C0E:=PathNodes2.CreateElement(False) as IDMElement;
    PathNodes2.Add(C0E);
    C0E.Ref:=Zone0E;
    if Zone0E=nil then
      C0E.Ref:=aFacilityModel.Enviroments
    else if AddToFloor0 then begin
      if PathEnabled then
        ((Zone0E as IZone).FloorNodes as IDMCollection2).Add(C0E);
    end;

    C0:=C0E as ICoordNode;
    NodeList0.Add(pointer(C0));
    Node02:=C0E as IPathNode2;
    Node02.Kind:=PathNodeKind;

    C1E:=PathNodes2.CreateElement(False) as IDMElement;
    PathNodes2.Add(C1E);
    C1E.Ref:=Zone1E;
    if Zone1E=nil then
      C1E.Ref:=aFacilityModel.Enviroments
    else if AddToFloor1 then begin
      if PathEnabled then
        ((Zone1E as IZone).FloorNodes as IDMCollection2).Add(C1E);
    end;
    C1:=C1E as ICoordNode;
    NodeList1.Add(pointer(C1));
    Node12:=C1E as IPathNode2;
    Node12.Kind:=PathNodeKind;

    PathArcE:=nil;
    if AddToFloor0 or AddToFloor1 or
       BoundaryKind.HighPath then begin

      if (Boundary<>nil) then begin
        PathArcE:=PathArcs2.CreateElement(False);
        PathArcs2.Add(PathArcE);
        PathArc:=PathArcE as ILine;
        PathArc.C0:=C0;
        PathArc.C1:=C1;
        (PathArc as IPathArc2).Enabled:=PathEnabled;
        ((Boundary as IFacilityElement).PathArcs as IDMCollection2).Add(PathArcE);
        PathArcE.Ref:=Boundary as IDMElement;
        (PathArc as IPathArc).FacilityState:=FacilityStateE;
        if PathNodeKind=pnkVBoundaryCenter then
          (PathArc as IPathArc).Kind:=pakVBoundary
        else
          (PathArc as IPathArc).Kind:=pakVBoundary_
      end;
    end;

    if  AreaE.Ref.Ref.Parent.ID=btVirtual then  // условная граница
      D:=40
    else
      D:=ShoulderWidth;
    X:=CC0.X+(CC1.X-CC0.X)*F;
    Y:=CC0.Y+(CC1.Y-CC0.Y)*F;
    Z:=CC0.Z+(CC1.Z-CC0.Z)*F+PathHeight;
    Set_CenterAt(X, Y, Z, D, cosX, cosY, C0, C1);
    if (PathNodeKind=pnkVBoundaryCenter) and
       aFacilityModel.BuildAllVerticalWays then begin
      if (not AddToFloor0)  and
         (not AddToFloor1) then
        AddToVerticalWay(C0E, C1E,  PathArcE, 2)
      else
      if not AddToFloor0 then
        AddToVerticalWay(C0E, C1E,  PathArcE, 0)
      else
      if not AddToFloor1 then
        AddToVerticalWay(C0E, C1E, PathArcE, 1);
    end;
  end;

  procedure AddVPathArc(BoundaryE, Zone0E, Zone1E:IDMElement;
                       Node0Kind, Node1Kind, PathArcKind:integer;
                       WP0X,WP0Y,WP0Z,WP1X,WP1Y,WP1Z:double);

  var
    PathArc:ILine;
    PathArcE:IDMElement;
    C0, C1:ICoordNode;
  begin
    C0E:=PathNodes2.CreateElement(False) as IDMElement;
    PathNodes2.Add(C0E);
    C0E.Ref:=Zone0E;
    if Zone0E=nil then
      C0E.Ref:=aFacilityModel.Enviroments
    else begin
      if Node0Kind=pnkZoneCenter then begin
        (Zone0E as IZone).CentralNode:=C0E;
        if PathEnabled then
          ((Zone0E as IZone).FloorNodes as IDMCollection2).Add(C0E);
      end else
      if (Node0Kind=pnkTMP) and
         PathEnabled then
        ((Zone0E as IZone).FloorNodes as IDMCollection2).Add(C0E);
    end;
    C0:=C0E as ICoordNode;
    C0.X:=WP0X;
    C0.Y:=WP0Y;
    C0.Z:=WP0Z;
    Node02:=C0E as IPathNode2;
    Node02.Kind:=Node0Kind;

    if Zone1E=nil then Exit;
    if not PathEnabled then Exit;

    C1E:=PathNodes2.CreateElement(False) as IDMElement;
    PathNodes2.Add(C1E);
    C1E.Ref:=Zone1E;
    if Zone1E=nil then
      C1E.Ref:=aFacilityModel.Enviroments;
    if (Node1Kind=pnkTMP) and
       PathEnabled then
      ((Zone1E as IZone).FloorNodes as IDMCollection2).Add(C1E);

    C1:=C1E as ICoordNode;
    C1.X:=WP1X;
    C1.Y:=WP1Y;
    C1.Z:=WP1Z;
    Node12:=C1E as IPathNode2;
    Node12.Kind:=Node1Kind;

    PathArcE:=PathArcs2.CreateElement(False);
    PathArcs2.Add(PathArcE);
    PathArc:=PathArcE as ILine;
    PathArc.C0:=C0;
    PathArc.C1:=C1;
    ((BoundaryE as IFacilityElement).PathArcs as IDMCollection2).Add(PathArcE);
    PathArcE.Ref:=BoundaryE;
    (PathArc as IPathArc).FacilityState:=FacilityStateE;
    (PathArc as IPathArc).Kind:=PathArcKind
  end;

var
  aArea, aArea0, aArea1,  DArea, VArea:IArea;
  Boundary:IBoundary;
  Boundary3:IBoundary3;
  DVolume0, DVolume1, aVolume0, aVolume1:IVolume;
  j, m:integer;
  CC0, CC1:ICoordNode;
  L, ProjL,
  cosX, cosY, dist0, dist1:double;
  BottomBoundary0, BottomBoundary1: IBoundary;
  aAreaE, aBottomLineE, BottomBoundary0E, BottomBoundary1E:IDMElement;
  BoundaryTypeE, BoundaryKindE:IDMElement;
  C0, C1:ICoordNode;
  aLine:ILine;
  AddToFloor0, AddToFloor1:boolean;
  Polyline:IPolyline;
  aLineE, BoundaryE:IDMElement;
  Zone0E, Zone1E:IDMElement;
  DD:double;
  ND, PathKind:integer;
  BoundaryLayer:IBoundaryLayer;
  BoundaryES:IElementState;
  BoundaryPE:IPathElement;
  WP0X, WP0Y, WP0Z, WP1Z,
  X0, Y0, Z0, X1, Y1, Z1:double;
  Analyzer:IDMAnalyzer;
  aBottomLine:ILine;
begin
  try
  Analyzer:=SafeguardAnalyzer as IDMAnalyzer;

  aFacilityModel:=Analyzer.Data as IFacilityModel;
  Area:=AreaE as IArea;
  BoundaryE:=AreaE.Ref;
  if BoundaryE=nil then Exit;

  if Area.Volume0<>nil then begin
    Zone0E:=(Area.Volume0 as IDMElement).Ref;
    Zone0:=Zone0E as IZone;
    Volume0:=Area.Volume0;
  end else begin
    Zone0E:=nil;
    Zone0:=nil;
    Volume0:=nil;
  end;
  if Area.Volume1<>nil then begin
    Zone1E:=(Area.Volume1 as IDMElement).Ref;
    Zone1:=Zone1E as IZone;
    Volume1:=Area.Volume1;
  end else begin
    Zone1E:=nil;
    Zone1:=nil;
    Volume1:=nil;
  end;

  BoundaryKindE:=BoundaryE.Ref;
  if BoundaryKindE=nil then
    Exit;
  PathKind:=(BoundaryKindE as IBoundaryKind).PathKind;
  Boundary:=BoundaryE as IBoundary;
  Boundary3:=BoundaryE as IBoundary3;
  BoundaryES:=BoundaryE as IElementState;
  BoundaryPE:=BoundaryE as IPathElement;
  PathEnabled:=(not BoundaryPE.Disabled) and
               (not (BoundaryES.UserDefinedDelayTime and
                   (BoundaryES.DelayTime=InfinitValue)));

  BoundaryTypeE:=BoundaryKindE.Parent;
  FacilityState:=FacilityStateE as IFacilityState;

  PathHeight:=aFacilityModel.PathHeight;
  ShoulderWidth:=Boundary3.ShoulderWidth;
  MaxBoundaryDistance:=Boundary3.MaxBoundaryDistance;
  MaxPathAlongBoundaryDistance:=Boundary3.MaxPathAlongBoundaryDistance;

  PathNodes2:=SafeguardAnalyzer.PathNodes as IDMCollection2;
  PathArcs2:=SafeguardAnalyzer.PathArcs as IDMCollection2;
  VerticalWays:=SafeguardAnalyzer.VerticalWays;
  VerticalWays2:=VerticalWays as IDMCollection2;

  if Area.IsVertical then begin
    if Area.BottomLines.Count=0 then Exit;  

    BoundaryWidth:=0;
    for j:=0 to Boundary.BoundaryLayers.Count-1 do begin
      BoundaryLayer:=Boundary.BoundaryLayers.Item[j] as IBoundaryLayer;
      BoundaryWidth:=BoundaryWidth+BoundaryLayer.DistanceFromPrev;
    end;
    BoundaryWidth:=abs(BoundaryWidth);

    NodeList0:=TList.Create;
    NodeList1:=TList.Create;

    CC0:=Area.C0;
    CC1:=Area.C1;
    X0:=CC0.X;
    Y0:=CC0.Y;
    Z0:=CC0.Z;
    X1:=CC1.X;
    Y1:=CC1.Y;
    Z1:=CC1.Z;
    
      NodeList0.Clear;
      NodeList1.Clear;

      if not UseTheNode or
        (CC0=theNode) or
        (theNode.Lines.Count=1) then begin

        L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0)+sqr(Z1-Z0));
        ProjL:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
        cosX:=(X1-X0)/ProjL;
        cosY:=(Y1-Y0)/ProjL;

        dist0 := (Boundary.NeighbourDist0+0.5*ShoulderWidth)/L; //относительное положение точки пересечения рубежа от С0 (или С1 ?)
        if dist0>1 then
           dist0:=1;
        dist1 := 1-(Boundary.NeighbourDist1+0.5*ShoulderWidth)/L; //относительное положение точки пересечения рубежа от С0 (или С1 ?)
        if dist1>1 then
           dist1:=1;

        BottomBoundary0:=nil;
        if (Area.Volume0<>nil) and
           (Area.Volume0.BottomAreas.Count>0) then begin
          aAreaE:=Area.Volume0.BottomAreas.Item[0];
          aArea0:=aAreaE as IArea;
          BottomBoundary0E:=aAreaE.Ref;
          BottomBoundary0:=BottomBoundary0E as IBoundary;
        end else
          aArea0:=nil;

        BottomBoundary1:=nil;
        if (Area.Volume1<>nil) and
           (Area.Volume1.BottomAreas.Count>0) then begin
          aAreaE:=Area.Volume1.BottomAreas.Item[0];
          aArea1:=aAreaE as IArea;
          BottomBoundary1E:=aAreaE.Ref;
          BottomBoundary1:=BottomBoundary1E as IBoundary;
        end else
          aArea1:=nil;

        aBottomLine:=Area.BottomLines.Item[0] as ILine;  
        DArea:=aBottomLine.GetVerticalArea(bdDown);
        AddToFloor0:=True;
        AddToFloor1:=True;
        if DArea<>nil then begin
          DVolume0:=DArea.Volume0;
          DVolume1:=DArea.Volume1;
          if (DVolume0=Volume0) or
             (DVolume1=Volume0) then
            AddToFloor0:=False;
          if (DVolume0=Volume1) or
             (DVolume1=Volume1) then begin
            AddToFloor1:=False;
          end;
          if (BottomBoundary0E=nil) or
            (BottomBoundary0E.Ref.Parent.ID=btVirtual) then  // условная граница
            AddToFloor0:=False;
          if (BottomBoundary1E=nil) or
             (BottomBoundary1E.Ref.Parent.ID=btVirtual) then  // условная граница
            AddToFloor1:=False;
        end else begin
          if (aArea0<>nil) and
             (Area.MinZ>aArea0.MaxZ) then
            AddToFloor0:=False;    //  "висячая" зона
          if (aArea1<>nil) and
             (Area.MinZ>aArea1.MaxZ) then
            AddToFloor1:=False;   //  "висячая" зона
        end;

        if UseTheNode and
           (theNode.Lines.Count>1) then
          AddHPathArc(CC0, CC1, 0.5, cosX, cosY,
               Boundary, BottomBoundary0, BottomBoundary1,
               Zone0E, Zone1E, pnkVBoundaryCenter, PathKind,
               AddToFloor0, AddToFloor1,
               theNode0, theNode1)
        else begin

          AddHPathArc(CC0, CC1, 0.5, cosX, cosY,
               Boundary, BottomBoundary0, BottomBoundary1,
               Zone0E, Zone1E, pnkVBoundaryCenter, PathKind,
               AddToFloor0, AddToFloor1,
               theNode0, theNode1);
          if L>maxPathAlongBoundaryDistance then begin
            if abs(dist0)<1 then
              AddHPathArc(CC0, CC1, dist0, cosX, cosY,
                   Boundary, BottomBoundary0, BottomBoundary1,
                   Zone0E, Zone1E,  pnkCorner, PathKind,
                   AddToFloor0, AddToFloor1,
                   C0, C1);
            if abs(dist1)<1 then
              AddHPathArc(CC0, CC1, dist1, cosX, cosY,
                   Boundary, BottomBoundary0, BottomBoundary1,
                   Zone0E, Zone1E,  pnkCorner, PathKind,
                   AddToFloor0, AddToFloor1,
                   C0, C1);
          end;

          if L/2>maxBoundaryDistance then begin
            ND:=ceil(L/2/maxBoundaryDistance);
            if ND>3 then
              ND:=3;
            DD:=1/(2*ND);
            for m:=1 to ND-1 do begin
              if (0.5-m*DD)>dist0 then
                AddHPathArc(CC0, CC1, 0.5-m*DD, cosX, cosY,
                   Boundary, BottomBoundary0, BottomBoundary1,
                   Zone0E, Zone1E,  pnkCorner, PathKind,
                   AddToFloor0, AddToFloor1,
                   C0, C1);
              if (0.5+m*DD)<dist1 then
                AddHPathArc(CC0, CC1, 0.5+m*DD, cosX, cosY,
                     Boundary, BottomBoundary0, BottomBoundary1,
                     Zone0E, Zone1E,  pnkCorner, PathKind,
                     AddToFloor0, AddToFloor1,
                     C0, C1);
            end;
          end;
        end; // if not UseXYZ

      end;

    NodeList0.Free;
    NodeList1.Free;
  end else  // not Area.IsVertical
  if (Zone0<>nil) then begin
    if (Zone0.Zones.Count=0) then begin
      Area.GetCentralPoint(WP0X, WP0Y, WP0Z);
      WP1Z:=WP0Z;
      WP0Z:=WP1Z+PathHeight;
      AddVPathArc(BoundaryE,
                Zone0E, Zone1E,
                pnkZoneCenter, pnkHBoundaryCenter, pakHBoundary,
                WP0X,WP0Y,WP0Z,WP0X,WP0Y,WP1Z);
    end;

    Polyline:=AreaE as IPolyline;
    for j:=0 to Polyline.Lines.Count-1 do begin
      aLineE:=Polyline.Lines.Item[j];
      aLine:=aLineE as ILine;
      VArea:=aLine.GetVerticalArea(bdUp);
      if VArea<>nil then begin
        aVolume0:=VArea.Volume0;
        aVolume1:=VArea.Volume1;
        if (aVolume0<>Volume0) and
           (aVolume1<>Volume0) then begin
          C0:=aLine.C0;
          C1:=aLine.C1;
          for m:=0 to aLineE.Parents.Count-1 do begin
            aAreaE:=aLineE.Parents.Item[m];
            aArea:=aAreaE as IArea;
            if not aArea.IsVertical and
              (aArea.Volume0<>nil) and
              (aArea.Volume1=Volume0) then begin
              WP0X:=0.5*(C0.X+C1.X);
              WP0Y:=0.5*(C0.Y+C1.Y);
              WP0Z:=0.5*(C0.Z+C1.Z)+PathHeight;

              AddVPathArc(aAreaE.Ref,             // маршрут через наклонные плоскости
                  (aArea.Volume0 as IDMElement).Ref,
                  (aArea.Volume1 as IDMElement).Ref,
                  pnkTMP, pnkTMP, pakHBoundary,
                  WP0X,WP0Y,WP0Z,WP0X,WP0Y,WP0Z);
            end;
          end;  
        end;
      end;  
    end;

  end;
  except
    (SafeguardAnalyzer as IDataModel).
    HandleError(Format(
      'Ошибка в прцедуре MakeBoundaryPathArcs (AreaE.ID=%d)',
      [AreaE.ID]));
  end;
end;

procedure RestoreZoneNodes(const SafeguardAnalyzerP:TObject);
var
  SafeguardAnalyzer:TSafeguardAnalyzer;
  Analyzer:IDMAnalyzer;
  aFacilityModel:IFacilityModel;
  Zones:IDMCollection;
  j:integer;
  Zone:IZone;
  aNodeC, ZoneNodeC:ICoordNode;
begin
  SafeguardAnalyzer:=SafeguardAnalyzerP as TSafeguardAnalyzer;
  Analyzer:=SafeguardAnalyzer as IDMAnalyzer;
  aFacilityModel:=Analyzer.Data as IFacilityModel;
  Zones:=aFacilityModel.Zones;
  for j:=0 to Zones.Count-1 do begin
    Zone:=Zones.Item[j] as IZone;
    aNodeC:=Zone.CentralNode as ICoordNode;
    if aNodeC=nil then begin
      if Zone.FloorNodes.Count>0 then
        aNodeC:=Zone.FloorNodes.Item[0] as ICoordNode;
    end;
    ZoneNodeC:=(Zone as IZone2).ZoneNode as ICoordNode;
    if (aNodeC<>nil) and
       (ZoneNodeC<>nil) then begin
      ZoneNodeC.X:=aNodeC.X;
      ZoneNodeC.Y:=aNodeC.Y;
      ZoneNodeC.Z:=aNodeC.Z;
    end;
  end;
end;

procedure MakeCeilingPathArcs(const SafeguardAnalyzer:TSafeguardAnalyzer;
                              const ZoneE,
                              FacilityStateE: IDMElement);
var
  PathArcs2, PathNodes2:IDMCollection2;
  Zone, aZone:IZone;
  aZoneE, NodeE, aPathArcE, PathNodeE:IDMElement;
  aPathArc, Line:ILine;
  C, C0, C1:ICoordNode;
  Node0E, Node1E:IDMElement;
  PathArc:IPathArc;
  aVolume:IVolume;
  aFacilityModel:IFacilityModel;
  PathHeight:double;
  TopArea, BottomArea:IArea;
  TopVolume, BottomVolume:IVolume;
  Analyzer:IDMAnalyzer;
begin
  try
  Analyzer:=SafeguardAnalyzer as IDMAnalyzer;

  aFacilityModel:=Analyzer.Data as IFacilityModel;
  Zone:=ZoneE as IZone;

  if Zone.Zones.Count>0 then Exit;
  aVolume:=ZoneE.SpatialElement as IVolume;
  if aVolume=nil then Exit;

  if aVolume.Areas.Count=0 then Exit;

  if aVolume.TopAreas.Count>0 then begin
    TopArea:=aVolume.TopAreas.Item[0] as IArea;
    TopVolume:=TopArea.Volume0;
  end else
    TopVolume:=nil;
  if aVolume.BottomAreas.Count>0 then begin
    BottomArea:=aVolume.BottomAreas.Item[0] as IArea;
    BottomVolume:=BottomArea.Volume1;
  end else
    BottomVolume:=nil;
  if (TopVolume=nil) and
     (BottomVolume=nil) then Exit;

  NodeE:=Zone.CentralNode;
  if NodeE=nil then Exit;

  C:=NodeE as ICoordNode;
  if C.Lines.Count=0 then Exit;
  PathArc:=C.Lines.Item[0] as IPathArc;

  if PathArc.Kind<>pakHBoundary then Exit;

  Line:=PathArc as ILine;
  C1:=Line.NextNodeTo(C);
  if C1=nil then Exit;

  Node1E:=C1 as IDMElement;
  aZoneE:=Node1E.Ref;
  if aZoneE=nil then Exit;

  aZone:=aZoneE as IZone;
  Node0E:=aZone.CentralNode;
  C0:=Node0E as ICoordNode;
  if C0=nil then Exit;

  PathHeight:=aFacilityModel.PathHeight;

  PathNodes2:=SafeguardAnalyzer.PathNodes as IDMCollection2;
  PathArcs2:=SafeguardAnalyzer.PathArcs as IDMCollection2;
  
  if sqrt(sqr(C1.X-C0.X)+sqr(C1.Y-C0.Y))>100 then begin

    aVolume:=aZoneE.SpatialElement as IVolume;

    PathNodeE:=PathNodes2.CreateElement(False);
    PathNodes2.Add(PathNodeE);
    C0:=PathNodeE as ICoordNode;
    (aZone.FloorNodes as IDMCollection2).Add(PathNodeE);
    C0.X:=C1.X;
    C0.Y:=C1.Y;
    C0.Z:=aVolume.MinZ+PathHeight;
    PathNodeE.Ref:=aZoneE;
    if aZoneE=nil then
      PathNodeE.Ref:=aFacilityModel.Enviroments;
    (PathNodeE as IPathNode2).Kind:=pnkZoneCenterProjection;
  end;

  aPathArcE:=PathArcs2.CreateElement(False);
  PathArcs2.Add(aPathArcE);
  aPathArc:=aPathArcE as ILine;
  aPathArcE.Ref:=aZoneE;
  aPathArc.C0:=C0;
  aPathArc.C1:=C1;
  (aPathArc as IPathArc).FacilityState:=FacilityStateE;
  (aPathArc as IPathArc).Kind:=pakVZone;
  except
    (SafeguardAnalyzer as IDataModel).
    HandleError(Format(
    'Ошибка в прцедуре MakeCeilingPathArcs (ZoneE.ID=%d)',
    [ZoneE.ID]));
  end;
end;

procedure MakeZonePathArcs(const SafeguardAnalyzer:TSafeguardAnalyzer;
                           const ZoneE,
                           FacilityStateE: IDMElement);
var
  Zone:IZone;
  Volume:IVolume;
  AreaE:IDMElement;
  PathArcs2, PathNodes2:IDMCollection2;
  j0, j1:integer;
  SafeguardElement:IDMElement;
  PathArc, aLine:ILine;
  Node:ICoordNode;
  PathArcE, C1E:IDMElement;
  Unk:IUnknown;
  Node02, Node12:IPathNode2;
  C0, C1:ICoordNode;
  FloorNodes:IDMCollection;
  FloorNodes2:IDMCollection2;
  aFacilityModel:IFacilityModel;
  PathHeight:double;

  procedure DeleteCloseNodes(Distance:double);
  begin
    j0:=0;
    while j0<FloorNodes.Count do begin
      Node02:=FloorNodes.Item[j0] as IPathNode2;
      C0:=Node02 as ICoordNode;
      j1:=j0+1;
      while j1<FloorNodes.Count do begin
        Node12:=FloorNodes.Item[j1] as IPathNode2;
        C1:=Node12 as ICoordNode;
        if (Node02.Kind<>pnkObject) and
           (Node12.Kind<>pnkObject) and
           (Node02.Kind<>pnkZoneCenter) and
           (Node12.Kind<>pnkZoneCenter) and
           ((Node02.Kind<>pnkVBoundaryCenter) or (Node12.Kind=pnkTMP)) and
           ((Node12.Kind<>pnkVBoundaryCenter) or (Node02.Kind=pnkTMP)) and
           (sqrt(sqr(C1.X-C0.X)+sqr(C1.Y-C0.Y)+sqr(C1.Z-C0.Z))<=Distance) then begin
          if Node02.Kind<Node12.Kind then
            Node02.Kind:=Node12.Kind;
          C0.X:=0.5*(C0.X+C1.X);
          C0.Y:=0.5*(C0.Y+C1.Y);
          C0.Z:=0.5*(C0.Z+C1.Z);
          while C1.Lines.Count>0 do begin
            aLine:=C1.Lines.Item[0] as ILine;
            if aLine.C0=C1 then
              aLine.C0:=C0
            else
              aLine.C1:=C0
          end;
          C1E:=C1 as IDMElement;
          FloorNodes2.Remove(C1E);
          C1E.Clear;
          PathNodes2.Remove(C1E);
        end else
          inc(j1)
      end;
      inc(j0);
    end;
  end;

  procedure  AddInnerZoneNodes(const Zone:IZone);
  var
    j, m, k:integer;
    aZone:IZone;
    aAreaE, ZoneE, DZoneE:IDMElement;
    aBoundary:IFacilityElement;
    PathArcL:ILine;
    PathArc:IPathArc;
    PathNodeE:IDMElement;
    aArea, DArea:IArea;
    BottomLine:ILine;
    Volume:IVolume;
  begin
    if Zone.Zones.Count=0 then Exit;
    ZoneE:=Zone as IDMElement;
    Volume:=ZoneE.SpatialElement as IVolume;
    for j:=0 to Zone.Zones.Count-1 do begin
      aZone:=Zone.Zones.Item[j] as IZone;
      for m:=0 to aZone.VAreas.Count-1 do begin
        aAreaE:=aZone.VAreas.Item[m];
        aArea:=aAreaE as IArea;
        if aArea.BottomLines.Count=0 then
          Continue;
        BottomLine:=aArea.BottomLines.Item[0] as ILine;
        DArea:=BottomLine.GetVerticalArea(bdDown);
        if DArea<>nil then begin
          if DArea.Volume0=Volume then
            Continue;
          if DArea.Volume1=Volume then
            Continue;
          if DArea.Volume0<>nil then begin
            DZoneE:=(DArea.Volume0 as IDMElement).Ref;
            if Zone.Zones.IndexOf(DZoneE)<>-1 then
              Continue;
          end;
          if DArea.Volume1<>nil then begin
            DZoneE:=(DArea.Volume1 as IDMElement).Ref;
            if Zone.Zones.IndexOf(DZoneE)<>-1 then
              Continue;
          end;
        end;
        aBoundary:=aAreaE.Ref as IFacilityElement;
        for k:=0 to aBoundary.PathArcs.Count-1 do begin
          PathArc:=aBoundary.PathArcs.Item[k] as IPathArc;
          if PathArc.FacilityState=FacilityStateE then begin
            PathArcL:=PathArc as ILine;

            PathNodeE:=PathArcL.C0 as IDMElement;
            if PathNodeE.Ref=aFacilityModel.Enviroments then begin
              PathNodeE.Ref:=ZoneE;
              (Zone.FloorNodes as IDMCollection2).Add(PathNodeE);
            end;

            PathNodeE:=PathArcL.C1 as IDMElement;
            if PathNodeE.Ref=aFacilityModel.Enviroments then begin
              PathNodeE.Ref:=ZoneE;
              (Zone.FloorNodes as IDMCollection2).Add(PathNodeE);
            end;
          end;
        end;
      end;
    end;
  end;

  function NodeInVerticalArea(const C:ICoordNode):boolean;
  var
    m:integer;
    aLine:ILine;
  begin
    Result:=True;
    m:=0;
    while m<C.Lines.Count do begin
      aLine:=C.Lines.Item[m] as ILine;
      if aLine.GetVerticalArea(bdUp)=nil then
        inc(m)
      else
        Exit;
    end;
    Result:=False;
  end;

var
  PathNode1E:IDMElement;
  PathNode0, PathNode1:ICoordNode;
  BoundaryKindE:IDMElement;
  ZoneS:ISafeguardUnit;
  ZoneKind:IZoneKind;
  ShoulderWidth:double;
  Analyzer:IDMAnalyzer;
  Zone2:IZone2;
  ZoneNodeE, PathNode0E:IDMElement;
  ZoneNodeC, aNodeC:ICoordNode;
  ZoneNode2:IPathNode2;
begin
  try
    Analyzer:=SafeguardAnalyzer as IDMAnalyzer;
    aFacilityModel:=Analyzer.Data as IFacilityModel;

    ZoneKind:=ZoneE.Ref as IZoneKind;
    Zone:=ZoneE as IZone;
    Zone2:=ZoneE as  IZone2;
    if (Zone as IPathElement).Disabled then Exit;
    if (Zone.PedestrialVelocity=0) and
       (not ZoneKind.CarMovementEnabled) and
       (not ZoneKind.AirMovementEnabled) and
       (not ZoneKind.WaterMovementEnabled) and
       (not ZoneKind.UnderWaterMovementEnabled) then Exit;
  ZoneS:=ZoneE as ISafeguardUnit;

  Volume:=ZoneE.SpatialElement as IVolume;
  if Volume=nil then Exit;
  if Volume.Areas.Count=0 then Exit;
  if Volume.BottomAreas.Count=0 then Exit;
  AreaE:=Volume.BottomAreas.Item[0];
  if AreaE.Ref=nil then Exit;
  BoundaryKindE:=AreaE.Ref.Ref;
  if (ZoneE.Ref.Parent.ID=ztClosedZone) and // закрытая зона
     (BoundaryKindE.Parent.ID=btVirtual) then Exit;   // условная граница

  PathHeight:=aFacilityModel.PathHeight;

  FloorNodes:=Zone.FloorNodes;
  FloorNodes2:=FloorNodes as IDMCollection2 ;

  PathNodes2:=SafeguardAnalyzer.PathNodes as IDMCollection2;
  PathArcs2:=SafeguardAnalyzer.PathArcs as IDMCollection2;

  AddInnerZoneNodes(Zone);

  for j0:=0 to ZoneS.SafeguardElements.Count-1 do begin
    SafeguardElement:=ZoneS.SafeguardElements.Item[j0];
    if (SafeguardElement.QueryInterface(ITarget, Unk)=0) or
       (SafeguardElement.QueryInterface(IStartPoint, Unk)=0) or
       (SafeguardElement.QueryInterface(IControlDevice, Unk)=0) or
       (SafeguardElement.QueryInterface(IGuardPost, Unk)=0) then begin
      PathNode0E:=PathNodes2.CreateElement(False);
      PathNodes2.Add(PathNode0E);
      PathNode0:=PathNode0E as ICoordNode;
      if SafeguardElement.SpatialElement.QueryInterface(ICoordNode, Node)<>0 then
        Node:=(SafeguardElement.SpatialElement as ILine).C0;
      PathNode0.X:=Node.X;
      PathNode0.Y:=Node.Y;
      PathNode0.Z:=Node.Z+PathHeight;
      PathNode0E.Ref:=SafeguardElement;
      (PathNode0 as IPathNode2).Kind:=pnkObject;
      FloorNodes2.Add(PathNode0E);
      if (SafeguardElement.QueryInterface(ITarget, Unk)=0) then begin
        PathNode1E:=PathNodes2.CreateElement(False);
        PathNodes2.Add(PathNode1E);
        PathNode1:=PathNode1E as ICoordNode;
        PathNode1.X:=PathNode0.X;
        PathNode1.Y:=PathNode0.Y;
        PathNode1.Z:=PathNode0.Z;
        PathNode1E.Ref:=SafeguardElement;
        (PathNode1 as IPathNode2).Kind:=pnkObject;

        PathArcE:=PathArcs2.CreateElement(False);
        PathArc:=PathArcE as ILine;
        PathArcs2.Add(PathArcE);
        PathArcE.Ref:=SafeguardElement;
        PathArc.C0:=PathNode0 as ICoordNode;
        PathArc.C1:=PathNode1 as ICoordNode;
        (PathArc as IPathArc).FacilityState:=FacilityStateE;
        (PathArc as IPathArc).Kind:=pakTarget;

        ((SafeguardElement as IFacilityElement).PathArcs as IDMCollection2).Add(PathArcE);
        ((SafeguardElement as IPathNodeArray).PathNodes as IDMCollection2).Add(PathNode1E);
      end else
        ((SafeguardElement as IPathNodeArray).PathNodes as IDMCollection2).Add(PathNode0E);
    end;
  end;

  ShoulderWidth:=aFacilityModel.ShoulderWidth;
  DeleteCloseNodes(ShoulderWidth);

  aNodeC:=Zone.CentralNode as ICoordNode;
  if aNodeC=nil then begin
    if FloorNodes.Count>0 then
      aNodeC:=FloorNodes.Item[0] as ICoordNode;
  end;
  ZoneNodeE:=PathNodes2.CreateElement(False) as IDMElement;
  PathNodes2.Add(ZoneNodeE);
  ZoneNodeE.Ref:=ZoneE;
  Zone2.ZoneNode:=ZoneNodeE;
  ZoneNodeC:=ZoneNodeE as ICoordNode;
  if aNodeC<>nil then begin
    ZoneNodeC.X:=aNodeC.X;
    ZoneNodeC.Y:=aNodeC.Y;
    ZoneNodeC.Z:=aNodeC.Z;
  end else begin
    ZoneNodeC.X:=0;
    ZoneNodeC.Y:=0;
    ZoneNodeC.Z:=Volume.MinZ+PathHeight;
  end;
  ZoneNode2:=ZoneNodeE as IPathNode2;
  ZoneNode2.Kind:=pnkZoneNode;

  for j0:=0 to FloorNodes.Count-1 do begin
    PathNode0E:=FloorNodes.Item[j0];
    Node02:=PathNode0E as IPathNode2;
    C0:=PathNode0E as ICoordNode;
    PathArcE:=PathArcs2.CreateElement(False);
    PathArc:=PathArcE as ILine;
    PathArcs2.Add(PathArcE);
    PathArcE.Ref:=ZoneE;
    if ZoneE=nil then
      PathArcE.Ref:=aFacilityModel.Enviroments;
    PathArc.C0:=C0;
    PathArc.C1:=ZoneNodeC;
    (PathArc as IPathArc).FacilityState:=FacilityStateE;
    (PathArc as IPathArc).Kind:=pakRZone;
  end;
  except
    (SafeguardAnalyzer as IDataModel).
    HandleError(Format(
    'Ошибка в прцедуре MakeZonePathArcs (ZoneE.ID=%d)',
    [ZoneE.ID]));
  end;
end;

procedure MakeJumpPathArcs(const SafeguardAnalyzer:TSafeguardAnalyzer;
                                 const JumpE,
                                 FacilityStateE: IDMElement);
var
  Jump:IJump;
  PathArcE:IDMElement;
  PathArc:IPathArc;
  PathArcL:ILine;
  PathNode0C, PathNode1C, C0, C1:ICoordNode;
  PathArcs2:IDMCollection2;
  Area0E, Area1E:IDMElement;
  Line:ILine;
  Boundary0, Boundary1, JumpB:IBoundary;
  PathNodes2:IDMCollection2;
  PathNode0E, PathNode1E:IDMElement;

  function NodeInArea(const Node:ICoordNode; const AreaE:IDMElement):boolean;
  var
    AreaP:IPolyline;
    j:integer;
    Line:ILine;
  begin
    AreaP:=AreaE as IPolyline;
    Result:=True;
    j:=0;
    while j<AreaP.Lines.Count do begin
      Line:=AreaP.Lines.Item[j] as ILine;
      if Line.C0=Node then Exit;
      if Line.C1=Node then Exit;
      inc(j);
    end;
    Result:=False;
  end;

  function AreaAtNode(const Node:ICoordNode; const ZoneE:IDMElement):IDMElement;
  var
    Volume:IVolume;
    aArea:IArea;
    aAreaE:IDMElement;
    j:integer;
  begin
    Volume:=ZoneE.SpatialElement as IVolume;
    j:=0;
    while j<Volume.Areas.Count do begin
      aAreaE:=Volume.Areas.Item[j];
      aArea:=aAreaE as IArea;
      if aArea.IsVertical and
         NodeInArea(Node, aAreaE) then begin
        Result:=aAreaE;
        Exit;
      end;
      inc(j);
    end;
  end;

var
  PathHeight:double;
  FacilityModel:IFacilityModel;
  Analyzer:IDMAnalyzer;
  Zone0, Zone1:IZone;
begin
  Analyzer:=SafeguardAnalyzer as IDMAnalyzer;
  FacilityModel:=Analyzer.Data as IFacilityModel;
  PathHeight:=FacilityModel.PathHeight;

  PathNodes2:=SafeguardAnalyzer.PathNodes as IDMCollection2;
  PathArcs2:=SafeguardAnalyzer.PathArcs as IDMCollection2;

  Jump:=JumpE as IJump;
  JumpB:=JumpE as IBoundary;

  if Jump.Boundary0<>nil then
    Area0E:=Jump.Boundary0.SpatialElement;
  if Jump.Boundary1<>nil then
    Area1E:=Jump.Boundary1.SpatialElement;

  Line:=JumpE.SpatialElement as ILine;

  Zone0:=Jump.Zone0 as IZone;
  Zone1:=Jump.Zone1 as IZone;

  if Line<>nil then begin
    C0:=Line.C0;
    C1:=Line.C1;

    if (Area0E<>nil) and
      not NodeInArea(C0, Area0E) then begin
      Area0E:=AreaAtNode(C0, Jump.Zone0);
      if Area0E<>nil then
        Jump.Boundary0:=Area0E.Ref;
    end;
    if (Area1E<>nil) and
      not NodeInArea(C1, Area1E) then begin
      Area1E:=AreaAtNode(C1, Jump.Zone1);
      if Area1E<>nil then
        Jump.Boundary1:=Area1E.Ref;
    end;

    PathNode0E:=PathNodes2.CreateElement(False);
    PathNodes2.Add(PathNode0E);
    (PathNode0E as IPathNode2).Kind:=pnkObject;
    if Zone0<>nil then
      PathNode0E.Ref:=Zone0 as IDMElement
    else
      PathNode0E.Ref:=FacilityModel.Enviroments;
    PathNode0C:=PathNode0E as ICoordNode;
    PathNode0C.X:=C0.X;
    PathNode0C.Y:=C0.Y;
    PathNode0C.Z:=C0.Z+PathHeight;
    if Zone0<>nil then
       (Zone0.FloorNodes as IDMCollection2).Add(PathNode0E);

    PathNode1E:=PathNodes2.CreateElement(False);
    PathNodes2.Add(PathNode1E);
    (PathNode1E as IPathNode2).Kind:=pnkObject;
    if Zone1<>nil then
      PathNode1E.Ref:=Zone1 as IDMElement
    else
      PathNode1E.Ref:=FacilityModel.Enviroments;
    PathNode1C:=PathNode1E as ICoordNode;
    PathNode1C.X:=C1.X;
    PathNode1C.Y:=C1.Y;
    PathNode1C.Z:=C1.Z+PathHeight;
    if Zone1<>nil then
      (Zone1.FloorNodes as IDMCollection2).Add(PathNode1E);

  end else begin
    Boundary0:=Jump.Boundary0 as IBoundary;
    if Boundary0<>nil then begin
      PathArcE:=(Boundary0 as IFacilityElement).PathArcs.Item[0];
      PathArcL:=PathArcE as ILine;
      if (PathArcL.C0 as IDMElement).Ref=JumpB.Zone0 then
        PathNode0C:=PathArcL.C0
      else
        PathNode0C:=PathArcL.C1;
    end else
    if Zone0<>nil then
      PathNode0C:=Zone0.CentralNode as ICoordNode
    else
      PathNode0C:=nil;

    if Boundary1<>nil then begin
      Boundary1:=Jump.Boundary1 as IBoundary;
      PathArcE:=(Boundary1 as IFacilityElement).PathArcs.Item[0];
      PathArcL:=PathArcE as ILine;
      if (PathArcL.C0 as IDMElement).Ref=JumpB.Zone1 then
        PathNode1C:=PathArcL.C0
      else
        PathNode1C:=PathArcL.C1
    end else
    if Zone1<>nil then
      PathNode1C:=Zone1.CentralNode as ICoordNode
    else
      PathNode1C:=nil;
  end;

  PathArcE:=PathArcs2.CreateElement(False);
  PathArcL:=PathArcE as ILine;
  PathArc:=PathArcE as IPathArc;
  PathArcs2.Add(PathArcE);
  PathArcL.C0:=PathNode0C;
  PathArcL.C1:=PathNode1C;
  PathArcE.Ref:=JumpE;
  ((JumpE as IFacilityElement).PathArcs as IDMCollection2).Add(PathArcE);
  PathArc.FacilityState:=FacilityStateE;
  PathArc.Kind:=pakVJump;
end;


procedure MakeRoadPathArcs(const SafeguardAnalyzer:TSafeguardAnalyzer;
                           const RoadE, FacilityStateE: IDMElement);
var
  LineGroup:ILineGroup;
  FacilityModel:IFacilityModel;
  Zone:IZone;
  Volume:IVolume;
  Boundary:IFacilityElement;
  Line,PathArcL:ILine;
  ZoneE,Zone0E,Zone1E:IDMElement;
  j,a:integer;
  PathArc:IPathArc;
  RoadPart:IRoadPart;
  RC0, RC1, CC0, CC1, CCC0, CCC1, C0, C1:ICoordNode;
  C0E,C1E:IDMElement;
  RoadParts2, PathArcs2, PathNodes2:IDMCollection2;
  RoadPartE, PathArcE, PathNodeE, PathNode0E, PathNode1E:IDMElement;
  Areas:IDMCollection;
  Area:IArea;
  X0, Y0, Z0, X1, Y1, Z1, X, Y, Z, aX, aY, aZ:double;
  TransparencyCoeff:double;
  Document:IDMDocument;
  Server:DataModelServer;
  MakeRoadPartFlag:boolean;
  PathHeight:double;
  Analyzer:IDMAnalyzer;
begin
  try
  Analyzer:=SafeguardAnalyzer as IDMAnalyzer;
  FacilityModel:=Analyzer.Data as IFacilityModel;

  PathHeight:=FacilityModel.PathHeight;
  LineGroup:=(RoadE.SpatialElement as ILineGroup);
  PathNodes2:=SafeguardAnalyzer.PathNodes as IDMCollection2;
  PathArcs2:=SafeguardAnalyzer.PathArcs as IDMCollection2;
  RoadParts2:=SafeguardAnalyzer.RoadParts as IDMCollection2;

  Areas:=TDMCollection.Create(nil) as IDMCollection;
  for j:=0 to (LineGroup.Lines.Count-1) do begin
    Line:=LineGroup.Lines.Item[j] as ILine;
    X0:=Line.C0.X;
    Y0:=Line.C0.Y;
    Z0:=Line.C0.Z+PathHeight;
    X1:=Line.C1.X;
    Y1:=Line.C1.Y;
    Z1:=Line.C1.Z+PathHeight;

    C0E:=Line.C0 as IDMElement;
    Volume:=(FacilityModel as ISpatialModel2).GetVolumeContaining(X0,Y0,Z0);
    if Volume<>nil then begin
      ZoneE:=(Volume as IDMElement).Ref;
      Zone:=ZoneE as IZone;
      PathNodeE:=(Zone.FloorNodes as IDMCollection2).GetItemByRef(C0E);
    end else begin
      PathNodeE:=nil;
      ZoneE:=nil;
      Zone:=nil;
    end;
    if PathNodeE=nil then begin
      PathNodeE:=PathNodes2.CreateElement(False);
      PathNodeE.Ref:=C0E;
      C0E.Ref:=ZoneE;
      if ZoneE=nil then
        C0E.Ref:=FacilityModel.Enviroments;
      PathNodes2.Add(PathNodeE);
      (PathNodeE as IPathNode2).Kind:=pnkObject;
      if Volume<>nil then
         (Zone.FloorNodes as IDMCollection2).Add(PathNodeE);
    end;
    RC0:=PathNodeE as ICoordNode;
    RC0.X:=X0;
    RC0.Y:=Y0;
    RC0.Z:=Z0;
    Zone0E:=ZoneE;

    C1E:=Line.C1 as IDMElement;
    Volume:=(FacilityModel as ISpatialModel2).GetVolumeContaining(X1,Y1,Z1);
    if Volume<>nil then begin
      ZoneE:=(Volume as IDMElement).Ref;
      Zone:=ZoneE as IZone;
      PathNodeE:=(Zone.FloorNodes as IDMCollection2).GetItemByRef(C1E);
    end else begin
      PathNodeE:=nil;
      ZoneE:=nil;
      Zone:=nil
    end;
    if PathNodeE=nil then begin
      PathNodeE:=PathNodes2.CreateElement(False);
      PathNodeE.Ref:=C1E;
      C1E.Ref:=ZoneE;
      if ZoneE=nil then
        C1E.Ref:=FacilityModel.Enviroments;
      PathNodes2.Add(PathNodeE);
      (PathNodeE as IPathNode2).Kind:=pnkObject;
      if Volume<>nil then
        (Zone.FloorNodes as IDMCollection2).Add(PathNodeE);
    end;
    RC1:=PathNodeE as ICoordNode;
    RC1.X:=X1;
    RC1.Y:=Y1;
    RC1.Z:=Z1;

    CC1:=RC1;
    CC0:=RC0;
    Zone1E:=ZoneE;

//Разбиение дороги
    FacilityModel.FindSeparatingAreas(X0, Y0, Z0, X1, Y1, Z1,
                                      Zone0E, Zone1E, 0, Areas, TransparencyCoeff, nil, nil);
    MakeRoadPartFlag:=True;
    if Areas.Count>0 then begin
      a:=0;
      while a<Areas.Count do begin
        Area:=Areas.Item[a] as IArea;
        Area.IntersectLine(X0, Y0, Z0, X1, Y1, Z1, X, Y, Z);
        Boundary:=Areas.Item[a].Ref as IFacilityElement;
        if Boundary.PathArcs.Count=0 then Break;
        PathArcL:=Boundary.PathArcs.Item[0] as ILine;
        C0:=PathArcL.C0;
        C1:=PathArcL.C1;
        C0E:=C0 as IDMElement;
        C1E:=C1 as IDMElement;
        aX:=0.5*(C0.X+C1.X);
        aY:=0.5*(C0.Y+C1.Y);
        aZ:=0.5*(C0.Z+C1.Z);
        C0.X:=C0.X+X-aX;
        C0.Y:=C0.Y+Y-aY;
        C0.Z:=C0.Z+Z-aZ;
        if sqrt(sqr(X0-C0.X)+sqr(Y0-C0.Y)+sqr(Z0-C0.Z))<=
           sqrt(sqr(X0-C1.X)+sqr(Y0-C1.Y)+sqr(Z0-C1.Z)) then begin
          CCC0:=C0;
          CCC1:=C1;
        end else begin
          CCC0:=C1;
          CCC1:=C0;
        end;
{
        PathNode0E:=PathNodes2.CreateElement(False);
        PathNodes2.Add(PathNode0E);
        (PathNode0E as IPathNode2).Kind:=pnkObject;
        PathNode0E.Ref:=C0E.Ref;
        CCC0:=PathNode0E as ICoordNode;
        CCC0.X:=X;
        CCC0.Y:=Y;
        CCC0.Z:=Z;
        if C0E.Ref<>nil then
           ((C0E.Ref as IZone).FloorNodes as IDMCollection2).Add(PathNode0E);

        PathNode1E:=PathNodes2.CreateElement(False);
        PathNodes2.Add(PathNode1E);
        (PathNode1E as IPathNode2).Kind:=pnkObject;
        PathNode1E.Ref:=C1E.Ref;
        CCC1:=PathNode1E as ICoordNode;
        CCC1.X:=X;
        CCC1.Y:=Y;
        CCC1.Z:=Z;
        if C1E.Ref<>nil then
           ((C1E.Ref as IZone).FloorNodes as IDMCollection2).Add(PathNode1E);

        PathArcE:=PathArcs2.CreateElement(False);
        PathArcL:=PathArcE as ILine;
        PathArc:=PathArcE as IPathArc;
        PathArcs2.Add(PathArcE);
        PathArcL.C0:=CCC0;
        PathArcL.C1:=CCC1;
        PathArcE.Ref:=Boundary as IDMElement;
        PathArc.FacilityState:=FacilityStateE;
        PathArc.Kind:=pakRoad;
}

        if C0E.Ref=Zone0E then begin
          ZoneE:=Zone0E;
          Zone0E:=C1E.Ref;
          CC0:=CCC0;
          CC1:=RC0;
          RC0:=CCC1;
          C0E:=RC0 as IDMElement;
        end else
        if C1E.Ref=Zone0E then begin
          ZoneE:=Zone0E;
          Zone0E:=C0E.Ref;
          CC0:=CCC1;
          CC1:=RC0;
          RC0:=CCC0;
          C0E:=RC0 as IDMElement;
        end else
        if C0E.Ref=Zone1E then  begin
          ZoneE:=Zone1E;
          Zone1E:=C1E.Ref;
          CC0:=CCC0;
          CC1:=RC1;
          RC1:=CCC1;
          C1E:=RC1 as IDMElement;
        end else
        if C1E.Ref=Zone1E then begin
          ZoneE:=Zone1E;
          Zone1E:=C0E.Ref;
          CC0:=CCC1;
          CC1:=RC1;
          RC1:=CCC0;
          C1E:=RC1 as IDMElement;
        end;

        PathArcE:=PathArcs2.CreateElement(False);
        PathArcL:=PathArcE as ILine;
        PathArc:=PathArcE as IPathArc;
        PathArcs2.Add(PathArcE);
        PathArcL.C0:=CC0;
        PathArcL.C1:=CC1;
        RoadPartE:=RoadParts2.CreateElement(False);
        RoadPart:=RoadPartE as IRoadPart;
        RoadParts2.Add(RoadPartE);
        PathArcE.Ref:=RoadPartE;
        RoadPartE.Ref:=ZoneE;
        RoadPart.Road:=RoadE as IRoad;
        PathArc.FacilityState:=FacilityStateE;
        PathArc.Kind:=pakRoad;

        inc(a);
      end;  //while a<Areas.Count
    end else begin //if Areas.Count=0
      if Zone0E<>Zone1E then
        MakeRoadPartFlag:=False;
    end;

    if MakeRoadPartFlag then begin

      PathArcE:=PathArcs2.CreateElement(False);
      PathArcL:=PathArcE as ILine;
      PathArc:=PathArcE as IPathArc;
      PathArcs2.Add(PathArcE);
      PathArcL.C0:=RC0;
      PathArcL.C1:=RC1;
      RoadPartE:=RoadParts2.CreateElement(False);
      RoadPart:=RoadPartE as IRoadPart;
      RoadParts2.Add(RoadPartE);
      PathArcE.Ref:=RoadPartE;
      RoadPartE.Ref:=ZoneE;
      RoadPart.Road:=RoadE as IRoad;
      PathArc.FacilityState:=FacilityStateE;
      PathArc.Kind:=pakRoad;

    end;
  end;  //for j:=0 to (LineGroup.Lines.Count-1)

  except
    (SafeguardAnalyzer as IDataModel).HandleError(Format(
    'Ошибка в прцедуре MakeRoadPathArcs (RoadE.ID=%d)',
    [RoadE.ID]));
  end;
end;

procedure MakeVerticalPathArcs(const SafeguardAnalyzer:TSafeguardAnalyzer;
                               const VerticalWayE, FacilityStateE: IDMElement);
var
  VerticalWay:IVerticalWay;
  X, Y, X0, Y0, X1, Y1, Z:double;
  j, m:integer;
  PathNodes2, PathArcs2:IDMCollection2;
  NodeE, PathNodeE, aZoneE, AreaE, PathArcE:IDMElement;
  PathNode2:IPathNode2;
  PathArc:IPathArc;
  PathArcL:ILine;
  PathNodeC, NodeC, aNodeC, C0, C1:ICoordNode;
  aZone:IZone;
  NodeList0, NodeList1:TList;
  FacilityModelS:ISpatialModel2;
  Areas:IDMCollection;
  Area:IArea;
  BoundaryKind:IBoundaryKind;
  aVolumeE:IDMElement;
  Side:integer;
  AddNode0, AddNode1:boolean;
  FacilityModel:IFacilityModel;
  PathHeight:double;
  Analyzer:IDMAnalyzer;
begin
  Analyzer:=SafeguardAnalyzer as IDMAnalyzer;
  VerticalWay:=VerticalWayE as IVerticalWay;
  if not VerticalWay.Usable then Exit;
  FacilityModel:=Analyzer.Data as IFacilityModel;
  FacilityModelS:=FacilityModel as ISpatialModel2;

  PathHeight:=FacilityModel.PathHeight;

  Areas:=FacilityModelS.Areas;
  X0:=VerticalWay.X0;
  Y0:=VerticalWay.Y0;
  X1:=VerticalWay.X1;
  Y1:=VerticalWay.Y1;
  Side:=VerticalWay.Side;
  NodeList0:=TList.Create;
  NodeList1:=TList.Create;

  PathNodes2:=SafeguardAnalyzer.PathNodes as IDMCollection2;
  PathArcs2:=SafeguardAnalyzer.PathArcs as IDMCollection2;

  for j:=0 to VerticalWay.Nodes0.Count-1 do begin
    NodeE:=VerticalWay.Nodes0.Item[j];
    NodeC:=NodeE as ICoordNode;
    Z:=NodeC.Z;
    m:=0;
    while m<NodeList0.Count do begin
      aNodeC:=ICoordNode(NodeList0[m]);
      if  Z<aNodeC.Z then
        Break
      else
        inc(m);
    end;
    NodeList0.Insert(m, pointer(NodeC));
  end;

  for j:=0 to VerticalWay.Nodes1.Count-1 do begin
    NodeE:=VerticalWay.Nodes1.Item[j];
    NodeC:=NodeE as ICoordNode;
    Z:=NodeC.Z;
    m:=0;
    while m<NodeList1.Count do begin
      aNodeC:=ICoordNode(NodeList1[m]);
      if  Z<aNodeC.Z then
        Break
      else
        inc(m);
    end;
    NodeList1.Insert(m, pointer(NodeC));
  end;


  try
  for j:=0 to Areas.Count-1 do begin
    AreaE:=Areas.Item[j];
    BoundaryKind:=AreaE.Ref.Ref as IBoundaryKind;
    Area:=AreaE as IArea;
    aVolumeE:=Area.Volume0 as IDMElement;
    if (not Area.IsVertical) and
       (not BoundaryKind.HighPath) and
       (aVolumeE<>nil) then begin
      AddNode0:=False;
      AddNode1:=False;
      X:=0;
      Y:=0;
      if  Area.ProjectionContainsPoint(X0, Y0, 0) and
         ((Side=0) or (Side=2)) then begin
        X:=X0;
        Y:=Y0;
        AddNode0:=True;
      end;
      if  Area.ProjectionContainsPoint(X1, Y1, 0) and
         ((Side=1) or (Side=2)) then begin
        X:=X1;
        Y:=Y1;
        AddNode1:=True;
      end;

      if AddNode0 then begin
        PathNodeE:=PathNodes2.CreateElement(False);
        PathNodes2.Add(PathNodeE);
        PathNode2:=PathNodeE as IPathNode2;
        PathNodeC:=PathNodeE as ICoordNode;
        PathNodeC.X:=X;
        PathNodeC.Y:=Y;
        Z:=Area.MaxZ+PathHeight;
        PathNodeC.Z:=Z;
        aZoneE:=aVolumeE.Ref;
        PathNodeE.Ref:=aZoneE;
        if aZoneE=nil then
          PathNodeE.Ref:=FacilityModel.Enviroments;
        PathNode2.Kind:=pnkObject;
        aZone:=aZoneE as IZone;
        (aZone.FloorNodes as IDMCollection2).Add(PathNodeE);

        m:=0;
        while m<NodeList0.Count do begin
          aNodeC:=ICoordNode(NodeList0[m]);
          if  Z<aNodeC.Z then
            Break
          else
            inc(m);
        end;
        NodeList0.Insert(m, pointer(PathNodeC))
      end;

      if AddNode1 then begin
        PathNodeE:=PathNodes2.CreateElement(False);
        PathNodes2.Add(PathNodeE);
        PathNode2:=PathNodeE as IPathNode2;
        PathNodeC:=PathNodeE as ICoordNode;
        PathNodeC.X:=X;
        PathNodeC.Y:=Y;
        Z:=Area.MaxZ+PathHeight;
        PathNodeC.Z:=Z;
        aZoneE:=aVolumeE.Ref;
        PathNodeE.Ref:=aZoneE;
        if aZoneE=nil then
          PathNodeE.Ref:=FacilityModel.Enviroments;
        PathNode2.Kind:=pnkObject;
        aZone:=aZoneE as IZone;
        (aZone.FloorNodes as IDMCollection2).Add(PathNodeE);

        m:=0;
        while m<NodeList1.Count do begin
          aNodeC:=ICoordNode(NodeList1[m]);
          if  Z<aNodeC.Z then
            Break
          else
            inc(m);
        end;
        NodeList1.Insert(m, pointer(PathNodeC))
      end;

    end;
  end;
  except
    (SafeguardAnalyzer as IDataModel).HandleError(Format(
    'Ошибка в прцедуре MakeVerticalPathArcs (VerticalWayE.ID=%d)',
    [VerticalWayE.ID]));
  end;

  for m:=0 to NodeList0.Count-2 do begin
    C0:=ICoordNode(NodeList0[m]);
    C1:=ICoordNode(NodeList0[m+1]);
    if (C1 as IPathNode2).Kind<>pnkObject then begin
      PathArcE:=PathArcs2.CreateElement(False);
      PathArcs2.Add(PathArcE);
      PathArcE.Ref:=(C0 as IDMElement).Ref;
      if PathArcE.Ref=nil then
        PathArcE.Ref:=FacilityModel.Enviroments;
      PathArc:=PathArcE as IPathArc;
      PathArcL:=PathArcE as ILine;
      PathArcL.C0:=C0;
      PathArcL.C1:=C1;
      PathArc.Kind:=pakVZone;
      PathArc.FacilityState:=FacilityStateE;
    end;
  end;

  for m:=0 to NodeList1.Count-2 do begin
    C0:=ICoordNode(NodeList1[m]);
    C1:=ICoordNode(NodeList1[m+1]);
    if (C1 as IPathNode2).Kind<>pnkObject then begin
      PathArcE:=PathArcs2.CreateElement(False);
      PathArcs2.Add(PathArcE);
      PathArcE.Ref:=(C0 as IDMElement).Ref;
      if PathArcE.Ref=nil then
        PathArcE.Ref:=FacilityModel.Enviroments;
      PathArc:=PathArcE as IPathArc;
      PathArcL:=PathArcE as ILine;
      PathArcL.C0:=C0;
      PathArcL.C1:=C1;
      PathArc.Kind:=pakVZone;
      PathArc.FacilityState:=FacilityStateE;
    end;
  end;

  NodeList0.Free;
  NodeList1.Free;
end;

procedure MakePathGraphs(const SafeguardAnalyzerP:TObject);
var
  j, m:integer;
  FacilityModel:IFacilityModel;
  MaxPathGraphCount, PathGraphCount, ExtraTargetCount:integer;
  PathGraphs2, SubStates2:IDMCollection2;
  PathGraphE:IDMElement;
  PathGraph:IPathGraph;

  SafeguardAnalyzer:TSafeguardAnalyzer;
  Analyzer:IDMAnalyzer;
  AnalysisVariant:IAnalysisVariant;
begin
  SafeguardAnalyzer:=SafeguardAnalyzerP as TSafeguardAnalyzer;
  Analyzer:=SafeguardAnalyzer as IDMAnalyzer;

  FacilityModel:=Analyzer.Data as IFacilityModel;

  MaxPathGraphCount:=0;
  for j:=0 to FacilityModel.AnalysisVariants.Count-1 do begin
    AnalysisVariant:=FacilityModel.AnalysisVariants.Item[j] as IAnalysisVariant;
    SafeguardAnalyzer.AnalysisVariant:=AnalysisVariant;
    ExtraTargetCount:=AnalysisVariant.ExtraTargets.Count;
    if ExtraTargetCount>3 then begin
    (SafeguardAnalyzer as IDataModel).HandleError(
            'Тоo many Extra Targets in '+
            FacilityModel.AnalysisVariants.Item[j].Name);
    end;
    PathGraphCount:=1;
    for m:=0 to ExtraTargetCount-1 do
      PathGraphCount:=PathGraphCount*2;
    if MaxPathGraphCount<PathGraphCount then
      MaxPathGraphCount:=PathGraphCount;
  end;

  PathGraphs2:=SafeguardAnalyzer.Get_PathGraphs as IDMCollection2;
  SubStates2:=FacilityModel.FacilitySubStates as IDMCollection2;
  for j:=0 to MaxPathGraphCount-1 do begin
    PathGraphE:=PathGraphs2.CreateElement(False);
    PathGraphE.Name:=Format('%s %d', [rsPathGraph, j]);
    PathGraph:=PathGraphE as IPathGraph;
    (PathGraph as IFacilityState).GraphIndex:=j;
    PathGraphs2.Add(PathGraphE);
    if j<>0 then begin
      PathGraph.ExtraSubState:=SubStates2.CreateElement(False);
      PathGraph.ExtraSubState.Name:='Пройденные промежуточные цели';
    end else
      PathGraph.ExtraSubState:=nil;
    PathGraph.BackPathSubState:=SubStates2.CreateElement(False);
    PathGraph.BackPathSubState.Name:='Выведенные из строя средства защиты';
  end;

  SafeguardAnalyzer.BaseGraph:=SafeguardAnalyzer.Get_PathGraphs.Item[0];
end;

procedure BuildPathGraph(const SafeguardAnalyzerP:TObject);
var
  j, k, m, i, N:integer;
  aFacilityModel:IFacilityModel;
  aSpatialModel:ISpatialModel;
  EnviromentsE, LargestZoneE:IDMElement;
  Enviroments, LargestZone:IZone;
  aArea:IArea;
  aAreaE, BoundaryE, JumpE, aZoneE, aRoadE:IDMElement;
  BoundaryFE:IFacilityElement;
  BoundaryPE, ZonePE:IPathElement;
  PathArcL, ZonePathArcL, BLine:ILine;
  StartPointE, FinishPointE:IDMElement;
  StartNode:ICoordNode;
  StartPathNodeE, ZonePathArcE:IDMElement;
  Document:IDMDocument;
  Server:IDataModelServer;
  PathGraph:IDMElement;
  PathArcs, PathNodes:IDMCollection;
  PathArcs2, PathNodes2:IDMCollection2;
  PathArcE, PathNodeE, BLineE, DAreaE:IDMElement;
  DArea, HArea:IArea;
  PathArc:IPathArc;
  aZone:IZone;
  VerticalWays:IDMCollection;
  VerticalWays2:IDMCollection2;
  VerticalWayE:IDMElement;
  theNode0, theNode1:ICoordNode;
  aAddFlag:WordBool;
  VAreas, InnerZoneOutline:IDMCollection;
  VAreas2:IDMCollection2;
  aZone2:IZone2;
  Jump:IJump;

  SafeguardAnalyzer:TSafeguardAnalyzer;
  Analyzer:IDMAnalyzer;
  EntryFlag:boolean;
  aZoneKindE:IDMElement;
  aZoneKind:IZoneKind;
  VolumeE:IDMElement;
  GlobalZone:IGlobalZone;
  LargestZoneDefined:boolean;
  HAreaE:IDMElement;
  Zone0E, Zone1E:IDMElement;
begin
  SafeguardAnalyzer:=SafeguardAnalyzerP as TSafeguardAnalyzer;
  Analyzer:=SafeguardAnalyzer as IDMAnalyzer;

  try
  Document:=(Analyzer.Data as IDataModel).Document as IDMDocument;
  Server:=Document.Server;
  aFacilityModel:=Analyzer.Data as IFacilityModel;
  aSpatialModel:=aFacilityModel as ISpatialModel;

  PathNodes:=SafeguardAnalyzer.PathNodes;
  PathArcs:=SafeguardAnalyzer.PathArcs;

  PathNodes2:=PathNodes as IDMCollection2;
  PathArcs2:=PathArcs as IDMCollection2;

  while PathArcs.Count>0 do begin
    PathArcE:=PathArcs.Item[0];
    PathArcL:=PathArcE as ILine;
    PathArcL.C0:=nil;
    PathArcL.C1:=nil;
    PathArcE.Clear;
    PathArcs2.Delete(0);
  end;

  while PathArcs.Count>0 do begin
    PathNodeE:=PathNodes.Item[0];
    PathNodeE.Clear;
    PathNodes2.Delete(0);
  end;

  StartPointE:=SafeguardAnalyzer.AnalysisVariant.MainGroup.StartPoint;
  FinishPointE:=SafeguardAnalyzer.AnalysisVariant.MainGroup.FinishPoint;

  if StartPointE.SpatialElement=nil then begin
    StartPathNodeE:=PathNodes2.CreateElement(False);
    PathNodes2.Add(StartPathNodeE);
    StartPathNodeE.Ref:=StartPointE;
    ((StartPointE as IPathNodeArray).PathNodes as IDMCollection2).Add(StartPathNodeE);
    StartNode:=StartPathNodeE as ICoordNode;
    StartNode.X:=-2*InfinitValue;
    StartNode.Y:=-2*InfinitValue;
    StartNode.Z:=-2*InfinitValue;
  end else
    StartNode:=nil;

  EnviromentsE:= aFacilityModel.Enviroments;
  Enviroments:= EnviromentsE as IZone;
  aAddFlag:=False;
  Enviroments.MakeHVAreas(nil, nil, aAddFlag);

  for j:=0 to aFacilityModel.Zones.Count-1 do begin
    aZoneE:=aFacilityModel.Zones.Item[j];
    aZone:=aZoneE as IZone;
    ((aZone as IFacilityElement).PathArcs as IDMCollection2).Clear;
  end;

  for j:=0 to aFacilityModel.Boundaries.Count-1 do begin
    BoundaryE:=aFacilityModel.Boundaries.Item[j];
    ((BoundaryE as IFacilityElement).PathArcs as IDMCollection2).Clear;
  end;

  for j:=0 to aFacilityModel.Jumps.Count-1 do begin
    JumpE:=aFacilityModel.Jumps.Item[j];
    ((JumpE as IFacilityElement).PathArcs as IDMCollection2).Clear;
  end;

  for k:=SafeguardAnalyzer.Get_PathGraphs.Count-1 downto 0 do begin

    for j:=0 to aFacilityModel.Zones.Count-1 do begin
      aZoneE:=aFacilityModel.Zones.Item[j];
      aZone:=aZoneE as IZone;
      (aZone.FloorNodes as IDMCollection2).Clear;
      aZone.CentralNode:=nil;
    end;

    for j:=0 to aSpatialModel.CoordNodes.Count-1 do
      (aSpatialModel.CoordNodes.Item[j] as ICoordNode).Tag:=0;

    VerticalWays:=SafeguardAnalyzer.VerticalWays;
    VerticalWays2:=VerticalWays as IDMCollection2;
    while VerticalWays.Count>0 do begin
      VerticalWayE:=VerticalWays.Item[0];
      VerticalWayE.Clear;
      VerticalWays2.Remove(VerticalWayE);
    end;

    PathGraph:=SafeguardAnalyzer.Get_PathGraphs.Item[k];
    for j:=0 to (aFacilityModel as ISpatialModel2).Areas.Count-1 do begin
      theNode0:=nil;
      theNode1:=nil;
      aAreaE:=(aFacilityModel as ISpatialModel2).Areas.Item[j];
      MakeBoundaryPathArcs(SafeguardAnalyzer,
              aAreaE, PathGraph,
               nil,False, theNode0, theNode1);
    end;
    for j:=0 to aFacilityModel.Zones.Count-1 do begin
      aZoneE:=aFacilityModel.Zones.Item[j];
      MakeCeilingPathArcs(SafeguardAnalyzer,
                aZoneE, PathGraph);
    end;
    for j:=0 to aFacilityModel.Roads.Count-1 do begin
      aRoadE:=aFacilityModel.Roads.Item[j];
      MakeRoadPathArcs(SafeguardAnalyzer,
                      aRoadE, PathGraph);
    end;

    if aFacilityModel.BuildAllVerticalWays then
      for j:=0 to SafeguardAnalyzer.VerticalWays.Count-1 do begin
        VerticalWayE:=SafeguardAnalyzer.VerticalWays.Item[j];
        MakeVerticalPathArcs(SafeguardAnalyzer,
                             VerticalWayE, PathGraph)
      end;

    for j:=0 to aFacilityModel.Jumps.Count-1 do begin
      JumpE:=aFacilityModel.Jumps.Item[j];
      MakeJumpPathArcs(SafeguardAnalyzer,
                             JumpE, PathGraph);
    end;

    if k=SafeguardAnalyzer.Get_PathGraphs.Count-1 then begin
      for j:=0 to aFacilityModel.Zones.Count-1 do begin
        aZoneE:=aFacilityModel.Zones.Item[j];
        aZone2:=aZoneE as IZone2;

        aZone2.MakeOutlinePath(PathArcs2, PathNodes2);

        for m:=0 to aZone2.Outline.Count-1 do begin
          PathArcE:=aZone2.Outline.Item[m];
          PathArc:=PathArcE as IPathArc;
          PathArc.Kind:=pakOutline;
        end;
        for i:=0 to aZone2.InnerZoneOutlineCount-1 do begin
          InnerZoneOutline:=aZone2.InnerZoneOutline[i];
          for m:=0 to InnerZoneOutline.Count-1 do begin
            PathArcE:=InnerZoneOutline.Item[m];
            PathArc:=PathArcE as IPathArc;
            PathArc.Kind:=pakOutline;
          end;
        end;
      end;
    end;

    for j:=0 to aFacilityModel.Zones.Count-1 do begin
      MakeZonePathArcs(SafeguardAnalyzer,
                       aFacilityModel.Zones.Item[j], PathGraph);
    end;

    if StartPointE.SpatialElement=nil then begin // бесконечно удаленная точка

      if k=0 then begin
        GlobalZone:=EnviromentsE as IGlobalZone;
        LargestZoneE:=GlobalZone.LargestZone;
        if LargestZoneE=nil then begin
          LargestZoneE:=EnviromentsE;
          LargestZoneDefined:=False;
        end else begin
          LargestZoneDefined:=True;
        end;

        LargestZone:=LargestZoneE as IZone;

        VAreas:=LargestZone.VAreas;
        VAreas2:=VAreas as IDMCollection2;
        for j:=0 to VAreas.Count-1 do begin
          aAreaE:=VAreas.Item[j];
          aArea:=aAreaE as IArea;
          if (aAreaE.Ref<>nil) and
            (aArea.BottomLines.Count>0) then begin

            EntryFlag:=True;

            BoundaryPE:=aAreaE.Ref as IPathElement;
            if BoundaryPE.Disabled then
              EntryFlag:=False;

            if not EntryFlag then
              Continue;

            if aArea<>nil then begin
              if aArea.Volume0<>nil then begin
                VolumeE:=aArea.Volume0 as IDMElement;
                aZoneE:=VolumeE.Ref;
                ZonePE:=aZoneE as IPathElement;
                if ZonePE.Disabled then
                  EntryFlag:=False
                else begin
                  aZoneKindE:=aZoneE.Ref;
                  aZoneKind:=aZoneKindE as IZoneKind;
                  if aZoneKind.PedestrialMovementVelocity=0 then
                    EntryFlag:=False
                end;
              end;
              if aArea.Volume1<>nil then begin
                VolumeE:=aArea.Volume1 as IDMElement;
                aZoneE:=VolumeE.Ref;
                ZonePE:=aZoneE as IPathElement;
                if ZonePE.Disabled then
                  EntryFlag:=False
                else begin
                  aZoneKindE:=aZoneE.Ref;
                  aZoneKind:=aZoneKindE as IZoneKind;
                  if aZoneKind.PedestrialMovementVelocity=0 then
                    EntryFlag:=False
                end;
              end;
            end;

            if not EntryFlag then
              Continue;

            BLineE:=aArea.BottomLines.Item[0];
            BLine:=BLineE as ILine;
            DArea:=BLine.GetVerticalArea(bdDown);
            if DArea<>nil then begin
              if LargestZoneDefined then begin
                N:=0;
                for m:=0 to BLineE.Parents.Count-1 do begin
                  HAreaE:=BLineE.Parents.Item[m];
                  if HAreaE.QueryInterface(IArea, HArea)=0 then begin
                    if not HArea.IsVertical and
                       ((HArea.Volume0=aArea.Volume0) or
                        (HArea.Volume0=aArea.Volume1)) then
                      inc(N);
                  end;
                end;
                if N<2 then
                  EntryFlag:=False
              end else begin
                if DArea.Volume0<>nil then
                  VolumeE:=DArea.Volume0 as IDMElement
                else
                if DArea.Volume1<>nil then
                  VolumeE:=DArea.Volume1 as IDMElement
                else begin
                  VolumeE:=nil;
                  EntryFlag:=False;
                end;
                if  VolumeE<>nil then begin
                  aZoneKindE:=VolumeE.Ref.Ref;
                  aZoneKind:=aZoneKindE as IZoneKind;
                  if aZoneKind.PedestrialMovementVelocity<>0 then
                    EntryFlag:=False
                end;
              end;
            end;  

            if not EntryFlag then
              Continue;

            if EntryFlag then begin

              BoundaryFE:=aAreaE.Ref as IFacilityElement;
              for m:=0 to BoundaryFE.PathArcs.Count-1 do begin
                PathArcL:=BoundaryFE.PathArcs.Item[m] as ILine;
                if (PathArcL as IPathArc).FacilityState=PathGraph then begin
                  ZonePathArcE:=PathArcs2.CreateElement(False);
                  PathArcs2.Add(ZonePathArcE);
                  ZonePathArcE.Ref:=aFacilityModel.Enviroments;
                  ZonePathArcL:=ZonePathArcE as ILine;
                  Zone0E:=(PathArcL.C0 as IDMElement).Ref;
                  Zone1E:=(PathArcL.C1 as IDMElement).Ref;
                  if (Zone1E=aFacilityModel.Enviroments) or
                     (Zone1E=nil) then
                    ZonePathArcL.C0:=PathArcL.C1
                  else begin
                    if LargestZoneDefined then begin
                      if LargestZone.Contains(Zone0E) then
                        ZonePathArcL.C0:=PathArcL.C1
                      else
                        ZonePathArcL.C0:=PathArcL.C0
                    end else
                      ZonePathArcL.C0:=PathArcL.C0;
                  end;
                  ZonePathArcL.C1:=StartNode;
                  (ZonePathArcL as IPathArc).FacilityState:=SafeguardAnalyzer.BaseGraph;
                end;
              end; // for m:=0 to Boundary.PathArcs.Count-1
            end;
          end;
        end; // for j:=0 to VAreas.Count-1

        for j:=0 to LargestZone.Jumps.Count-1 do begin
          Jump:=LargestZone.Jumps.Item[j] as IJump;
          BoundaryFE:=Jump as IFacilityElement;
          for m:=0 to BoundaryFE.PathArcs.Count-1 do begin
            PathArcL:=BoundaryFE.PathArcs.Item[m] as ILine;
            if (PathArcL as IPathArc).FacilityState=PathGraph then begin
              ZonePathArcE:=PathArcs2.CreateElement(False);
              PathArcs2.Add(ZonePathArcE);
               ZonePathArcE.Ref:=aFacilityModel.Enviroments;
              ZonePathArcL:=ZonePathArcE as ILine;
              if ((PathArcL.C1 as IDMElement).Ref=aFacilityModel.Enviroments) or
                 ((PathArcL.C1 as IDMElement).Ref=nil) then
                ZonePathArcL.C0:=PathArcL.C1
              else
                ZonePathArcL.C0:=PathArcL.C0;
              ZonePathArcL.C1:=StartNode;
              (ZonePathArcL as IPathArc).FacilityState:=SafeguardAnalyzer.BaseGraph;
            end;
          end; // for m:=0 to Boundary.PathArcs.Count-1
        end;
      end;
    end;
  end;

  for j:=0 to (aFacilityModel as ISpatialModel).CoordNodes.Count-1 do
    ((aFacilityModel as ISpatialModel).CoordNodes.Item[j] as ICoordNode).Tag:=0;

  except
    on E:Exception do
    (SafeguardAnalyzer as IDataModel).HandleError(
    'Error in BuildPathGraph')
  end
end;


end.
