unit Geometry;
interface
  function LineIntersectLine0(P0X, P0Y,
                             P1X, P1Y,
                             P2X, P2Y,
                             P3X, P3Y:double;
                         var PX,  PY:double):boolean;
  function LineIntersectLine(P0X, P0Y, P0Z,
                             P1X, P1Y, P1Z,
                             P2X, P2Y, P2Z,
                             P3X, P3Y, P3Z:double;
                         var PX,  PY,  PZ:double):boolean;
  function LineCanIntersectLine0(P0X, P0Y,
                             P1X, P1Y,
                             P2X, P2Y,
                             P3X, P3Y:double;
                         var PX,  PY:double):boolean;
  function LineCanIntersectLine(P0X, P0Y, P0Z,
                             P1X, P1Y, P1Z,
                             P2X, P2Y, P2Z,
                             P3X, P3Y, P3Z:double;
                         var PX,  PY,  PZ:double):boolean;
  function LineIntersectPlane(L0X, L0Y, L0Z,
                              L1X, L1Y, L1Z,
                              P0X, P0Y, P0Z,
                              P1X, P1Y, P1Z,
                              P2X, P2Y, P2Z:double;
                          var PX,  PY,  PZ :double):boolean;

  procedure PerpendicularFrom(P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX, WY, WZ:double;
                             var X0, Y0, Z0:double);
  procedure PerpendicularFrom0(P0X, P0Y, P1X, P1Y, WX, WY:double;
                             var X0, Y0:double);
  function DistanceBetween(P0X, P0Y, P0Z, P1X, P1Y, P1Z:double): double;

  function DistanceFromLine(P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX, WY, WZ:double): double;

  function _DistanceFromLine(P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX, WY, WZ:double;
                             var WX0, WY0, WZ0:double): double;
  procedure PerpendicularTo(X0, Y0, X1, Y1, L:double;
                            var XP, YP, XM, YM:double);

implementation

function LineIntersectLine0(P0X, P0Y,
                           P1X, P1Y,
                           P2X, P2Y,
                           P3X, P3Y:double;
                       var PX,  PY:double):boolean;
begin
  Result:=LineCanIntersectLine0(P0X, P0Y,
                               P1X, P1Y,
                               P2X, P2Y,
                               P3X, P3Y,
                               PX,  PY);

  if Result and
     ((PX-P0X)*(PX-P1X)<=0) and
     ((PY-P0Y)*(PY-P1Y)<=0) and
     ((PX-P2X)*(PX-P3X)<=0) and
     ((PY-P2Y)*(PY-P3Y)<=0) then

    Exit
  else
    Result:=False;
end;

function LineIntersectLine(P0X, P0Y, P0Z,
                           P1X, P1Y, P1Z,
                           P2X, P2Y, P2Z,
                           P3X, P3Y, P3Z:double;
                       var PX,  PY,  PZ :double):boolean;
begin
  Result:=LineCanIntersectLine(P0X, P0Y, P0Z,
                               P1X, P1Y, P1Z,
                               P2X, P2Y, P2Z,
                               P3X, P3Y, P3Z,
                               PX,  PY,  PZ);

  if Result and
     ((PX-P0X)*(PX-P1X)<=0) and
     ((PY-P0Y)*(PY-P1Y)<=0) and
     ((PZ-P0Z)*(PZ-P1Z)<=0) and
     ((PX-P2X)*(PX-P3X)<=0) and
     ((PY-P2Y)*(PY-P3Y)<=0) and
     ((PZ-P2Z)*(PZ-P3Z)<=0) then

    Exit
  else
    Result:=False;
end;

{  Линия может пересеч линию }

function LineCanIntersectLine0(P0X, P0Y,
                           P1X, P1Y,
                           P2X, P2Y,
                           P3X, P3Y:double;
                       var PX,  PY:double):boolean;
var Ryx10, Rxy32: double;
begin
  Result:=False;

  if abs(P3Y-P2Y)>=0.1 then begin
    Rxy32:=(P3X-P2X)/(P3Y-P2Y);
    if abs(P1X-P0X)>=0.1 then begin
      Ryx10:=(P1Y-P0Y)/(P1X-P0X);
      if abs(1-Ryx10*Rxy32)>1.e-6  then begin
        PX:=(P2X+(P0Y-P2Y-P0X*Ryx10)*Rxy32)/(1-Ryx10*Rxy32);
        PY:=P0Y+(PX-P0X)*Ryx10;
        Result:=True
      end;
    end else begin
      PX:=P0X;
      if abs(P3X-P2X)>=0.1 then begin
        PY:=P2Y+(P3Y-P2Y)*(PX-P2X)/(P3X-P2X);
        Result:=True;
      end
    end
  end else begin
    PY:=P2Y;
    if abs(P1Y-P0Y)<0.1 then begin // в плоскости Y=const
      if abs(P3X-P2X)<0.1 then begin
        PX:=P2X;
        if abs(P1X-P0X)>=0.1 then
          Result:=True;
      end;
    end else if abs(P1Y-P0Y)>=0.1 then begin
      PX:=P0X+(P1X-P0X)*(PY-P0Y)/(P1Y-P0Y);
      Result:=True;
    end;
  end;
end;

function LineCanIntersectLine(P0X, P0Y, P0Z,
                           P1X, P1Y, P1Z,
                           P2X, P2Y, P2Z,
                           P3X, P3Y, P3Z:double;
                       var PX,  PY,  PZ :double):boolean;
var Ryx10, Rxz10, Ryz10, Rzx10,
    Rxy32, Rzx32, Rzy32: double;
begin
  Result:=False;

  if abs(P3Y-P2Y)>=0.1 then begin
    Rxy32:=(P3X-P2X)/(P3Y-P2Y);
    Rzy32:=(P3Z-P2Z)/(P3Y-P2Y);
    if abs(P1X-P0X)>=0.1 then begin
      Ryx10:=(P1Y-P0Y)/(P1X-P0X);
      Rzx10:=(P1Z-P0Z)/(P1X-P0X);
      if abs(1-Ryx10*Rxy32)>1.e-6  then begin
        PX:=(P2X+(P0Y-P2Y-P0X*Ryx10)*Rxy32)/(1-Ryx10*Rxy32);
        PY:=P0Y+(PX-P0X)*Ryx10;
        PZ:=P0Z+(PX-P0X)*Rzx10;
        Result:=True
      end else begin

        if abs(P1Z-P0Z)>=0.1 then begin
          Ryz10:=(P1Y-P0Y)/(P1Z-P0Z);
          Rxz10:=(P1X-P0X)/(P1Z-P0Z);
          if 1-Ryz10*Rzy32<>0  then begin
            PZ:=(P2Z+(P0Y-P2Y-P0Z*Ryz10)*Rzy32)/(1-Ryz10*Rzy32);
            PY:=P0Y+(PZ-P0Z)*Ryz10;
            PX:=P0X+(PZ-P0Z)*Rxz10;
            Result:=True
          end else
            Exit;
        end else if abs(P1Z-P0Z)<0.1 then begin
          PZ:=P0Z;
          if abs(P3Z-P2Z)<0.1 then
            Exit
          else begin
            PY:=P2Y+(P3Y-P2Y)*(PZ-P2Z)/(P3Z-P2Z);
            PX:=P2X+(P3X-P2X)*(PZ-P2Z)/(P3Z-P2Z);
            Result:=True;
          end;
        end;
      end;
    end else if abs(P1X-P0X)<0.1 then begin
      PX:=P0X;
      if abs(P3X-P2X)<0.1 then begin // в плоскости X=const
        if abs(P1Z-P0Z)>=0.1 then begin
          Ryz10:=(P1Y-P0Y)/(P1Z-P0Z);
          if 1-Ryz10*Rzy32<>0  then begin
            PZ:=(P2Z+(P0Y-P2Y-P0Z*Ryz10)*Rzy32)/(1-Ryz10*Rzy32);
            PY:=P0Y+(PZ-P0Z)*Ryz10;
            Result:=True
          end else
            Exit;
        end else if abs(P1Z-P0Z)<0.1 then begin
          PZ:=P0Z;
          if abs(P3Z-P2Z)<0.1 then
            Exit
          else begin
            PY:=P2Y+(P3Y-P2Y)*(PZ-P2Z)/(P3Z-P2Z);
            Result:=True;
          end;
        end;
      end else if abs(P3X-P2X)>=0.1 then begin
        PY:=P2Y+(P3Y-P2Y)*(PX-P2X)/(P3X-P2X);
        PZ:=P2Z+(P3Z-P2Z)*(PX-P2X)/(P3X-P2X);
        Result:=True;
      end
    end
  end else if abs(P3Y-P2Y)<0.1 then begin
    PY:=P2Y;
    if abs(P1Y-P0Y)<0.1 then begin // в плоскости Y=const
      if abs(P3X-P2X)>=0.1 then begin
        Rzx32:=(P3Z-P2Z)/(P3X-P2X);
        if abs(P1Z-P0Z)>=0.1 then begin
          Rxz10:=(P1X-P0X)/(P1Z-P0Z);
          if 1-Rxz10*Rzx32<>0  then begin
            PZ:=(P2Z+(P0X-P2X-P0Z*Rxz10)*Rzx32)/(1-Rxz10*Rzx32);
            PX:=P0X+(PZ-P0Z)*Rxz10;
            Result:=True;
          end else
            Exit;
        end else if abs(P1Z-P0Z)<0.1 then begin
          PZ:=P0Z;
          if abs(P3Z-P2Z)<0.1 then
            Exit
          else begin
            PX:=P2X+(P3X-P2X)*(PZ-P2Z)/(P3Z-P2Z);
            Result:=True;
          end;
        end;
      end else if abs(P3X-P2X)<0.1 then begin
        PX:=P2X;
        if abs(P1X-P0X)<0.1 then
          Exit
        else if abs(P1X-P0X)>=0.1 then begin
          PZ:=P0Z+(P1Z-P0Z)*(PX-P0X)/(P1X-P0X);
          Result:=True;
        end;
      end;
    end else if abs(P1Y-P0Y)>=0.1 then begin
      PX:=P0X+(P1X-P0X)*(PY-P0Y)/(P1Y-P0Y);
      PZ:=P0Z+(P1Z-P0Z)*(PY-P0Y)/(P1Y-P0Y);
      Result:=True;
    end;
  end;
end;

function LineIntersectPlane(L0X, L0Y, L0Z,
                            L1X, L1Y, L1Z,
                            P0X, P0Y, P0Z,
                            P1X, P1Y, P1Z,
                            P2X, P2Y, P2Z:double;
                        var PX,  PY,  PZ :double):boolean;
var
  detX, detY, detZ, Q, Ryx, Ryz, Rzx, D:double;
begin
  Result:=False;
  detX:=(P1Y-P0Y)*(P2Z-P0Z)-(P1Z-P0Z)*(P2Y-P0Y);
  detY:=(P1X-P0X)*(P2Z-P0Z)-(P1Z-P0Z)*(P2X-P0X);
  detZ:=(P1X-P0X)*(P2Y-P0Y)-(P1Y-P0Y)*(P2X-P0X);
  Q:=P0X*detX-P0Y*detY+P0Z*detZ;

  if L1Z=L0Z then begin
    PZ:=L0Z;
    if L1X=L0X then begin
      if detY=0 then Exit;
      PX:=L0X;
      PY:=(PX*detX+PZ*detZ-Q)/detY;
      Result:=True;
    end else if L1X<>L0X then begin
      Ryx:=(L1Y-L0Y)/(L1X-L0X);
      D:=detX-Ryx*detY;
      if D=0 then Exit;
      PX:=(Q-L0Z*detZ-(L0X*Ryx-L0Y)*detY)/D;
      PY:=L0Y+(PX-L0X)*Ryx;
      Result:=True;
    end;
  end else if L1Z<>L0Z then begin
    if L1X=L0X then begin
      PX:=L0X;
      Ryz:=(L1Y-L0Y)/(L1Z-L0Z);
      D:=detZ-Ryz*detY;
      if D=0 then Exit;
      PZ:=(Q-L0X*detX-(L0Z*Ryz-L0Y)*detY)/D;
      PY:=L0Y+(PZ-L0Z)*Ryz;
      Result:=True;
    end else if L1X<>L0X then begin
      Ryx:=(L1Y-L0Y)/(L1X-L0X);
      Rzx:=(L1Z-L0Z)/(L1X-L0X);
      D:=(detX-Ryx*detY+Rzx*detZ);
      if D=0 then Exit;
      PX:=(Q-(L0X*Ryx-L0Y)*detY+(L0X*Rzx-L0Z)*detZ)/D;
      PY:=L0Y+(PX-L0X)*Ryx;
      PZ:=L0Z+(PX-L0X)*Rzx;
      Result:=True;
    end;
  end;
end;

procedure PerpendicularFrom0(P0X, P0Y, P1X, P1Y, WX, WY:double;
                             var X0, Y0:double);
var
  dx,dy: double;
begin
  dx:=P1X-P0X;
  dy:=P1Y-P0Y;
  if abs(dx)>1.e-6 then begin
    X0:=(dy*dy*P1X+dx*dx*WX-dy*dx*(P1Y-WY))/(dy*dy+dx*dx);
    Y0:=P1Y+dy/dx*(X0-P1X);
  end else begin
    X0:=P1X;
    Y0:=WY
  end;
end;

procedure PerpendicularFrom(P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX, WY, WZ:double;
                             var X0, Y0, Z0:double);
var
  dx,dy, dz: double;
begin
  dx:=P1X-P0X;
  dy:=P1Y-P0Y;
  dz:=P1Z-P0Z;
  if abs(dz)>1.e-6 then begin
    Z0:=(P1Z*(sqr(dx)+sqr(dy))+WZ*sqr(dz)+
               dz*(dx*(WX-P1X)+
                   dy*(WY-P1Y)))/
                    (sqr(dx)+sqr(dy)+sqr(dz));
    X0:=P1X+dx/dz*(Z0-P1Z);
    Y0:=P1Y+dy/dz*(Z0-P1Z);
  end else
  if abs(dx)>1.e-6 then begin
    Z0:=P1Z;
    X0:=(dy*dy*P1X+dx*dx*WX-dy*dx*(P1Y-WY))/(dy*dy+dx*dx);
    Y0:=P1Y+dy/dx*(X0-P1X);
  end else begin
    Z0:=P1Z;
    X0:=P1X;
    Y0:=WY
  end;
end;

function DistanceBetween(P0X, P0Y, P0Z, P1X, P1Y, P1Z:double): double;
var
  dx,dy,dz,rr:double;
begin
  dx:=P1X-P0X;
  dy:=P1Y-P0Y;
  dz:=P1Z-P0Z;
  rr:=dx*dx+dy*dy+dz*dz;
  Result:=sqrt(rr);
end;

function DistanceFromLine(P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX, WY, WZ:double): double;
var
  WX0, WY0, WZ0:double;
begin
  Result:=_DistanceFromLine(P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX, WY, WZ, WX0, WY0, WZ0);
end;

function _DistanceFromLine(P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX, WY, WZ:double;
                           var  WX0, WY0, WZ0:double): double;
begin
   PerpendicularFrom(P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX, WY, WZ, WX0, WY0, WZ0);
   if ((WX0-P0X)*(WX0-P1X)<=0) and
      ((WY0-P0Y)*(WY0-P1Y)<=0) and
      ((WZ0-P0Z)*(WZ0-P1Z)<=0) then
    Result:=sqrt(sqr(WX-WX0)+sqr(WY-WY0)+sqr(WZ-WZ0))
  else if abs(WX0-P0X)<abs(WX0-P1X) then begin
    Result:=DistanceBetween(P0X, P0Y, P0Z, WX, WY, WZ);
    WX0:=P0X;
    WY0:=P0Y;
    WZ0:=P0Z;
  end else if abs(WX0-P0X)>abs(WX0-P1X) then begin
    Result:=DistanceBetween(P1X, P1Y, P1Z, WX, WY, WZ);
    WX0:=P1X;
    WY0:=P1Y;
    WZ0:=P1Z;
  end else if abs(WY0-P0Y)<abs(WY0-P1Y) then begin
    Result:=DistanceBetween(P0X, P0Y, P0Z, WX, WY, WZ);
    WX0:=P0X;
    WY0:=P0Y;
    WZ0:=P0Z;
  end else if abs(WY0-P0Y)>abs(WY0-P1Y) then begin
    Result:=DistanceBetween(P1X, P1Y, P1Z, WX, WY, WZ);
    WX0:=P1X;
    WY0:=P1Y;
    WZ0:=P1Z;
  end else if abs(WZ0-P0Z)<abs(WZ0-P1Z) then begin
    Result:=DistanceBetween(P0X, P0Y, P0Z, WX, WY, WZ);
    WX0:=P0X;
    WY0:=P0Y;
    WZ0:=P0Z;
  end else if abs(WZ0-P0Z)>abs(WZ0-P1Z) then begin
    Result:=DistanceBetween(P1X, P1Y, P1Z, WX, WY, WZ);
    WX0:=P1X;
    WY0:=P1Y;
    WZ0:=P1Z;
  end else begin
    Result:=DistanceBetween(P0X, P0Y, P0Z, WX, WY, WZ);
    WX0:=P0X;
    WY0:=P0Y;
    WZ0:=P0Z;
  end;
end;

procedure PerpendicularTo(X0, Y0, X1, Y1, L:double;
                          var XP, YP, XM, YM:double);
var
  a,b,c,dx,dy:double;
begin
  dx:=x1-x0;
  dy:=y1-y0;

  if abs(dy)>0.001 then begin
    a:=1;
    b:=-2*x0;
    c:=sqr(x0)-sqr(L)/(1+sqr(dx/dy));

    xp:=(-b+sqrt(b*b-4*a*c))/(2*a);
    xm:=(-b-sqrt(b*b-4*a*c))/(2*a);

    yp:=y0-dx/dy*(xp-x0);
    ym:=y0-dx/dy*(xm-x0);

  end else begin
    xp:=x0;
    xm:=x0;
    yp:=y0-L;
    ym:=y0+L;
  end
end;

end.
