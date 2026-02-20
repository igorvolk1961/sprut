unit CalcDetectionProbabilityLib;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

procedure FactorConvert(ZoneForm: Integer; x0,y0,z0,alfa,betta,a: double; var xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33: double);
procedure InConvert(x,y,z,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33: double; var Xi,Yi,Zi: double);
procedure Ellips(ZoneForm: Integer; x1,y1,z1, x2,y2,z2, al,bl,cl: double; var  Xc1,Yc1,Zc1, Xc2,Yc2,Zc2: double; var Stat: Integer);
procedure OutConvert(Xi,Yi,Zi,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33: double; var x,y,z: double);
procedure DetectEllips(ZoneForm:integer; x0,y0,z0, a,b,c, alfa,betta, x1,y1,z1, x2,y2,z2: double; var Xd1,Yd1,Zd1, Xd2,Yd2,Zd2: double; var Stat: Integer);
procedure DetectLine(x0,y0,z0, alfa,betta,L, x1,y1,z1, x2,y2,z2,dXc,dYc,dZc: double; var Xd1,Yd1,Zd1: double; var Stat: Integer);
procedure Line(x1,y1,z1, x2,y2,z2, dXc,dYc,dZc: double; var Xc,Yc,Zc : double; var Stat: Integer);
function  GetFieldDetectionProbability(const FieldE: IDMElement;
                                       const SafeguardElementE: IDMElement; FieldValue: Double;
                                       aTime: Double): Double; safecall;

implementation

procedure DetectEllips(ZoneForm: Integer; x0,y0,z0, a,b,c, alfa,betta, x1,y1,z1, x2,y2,z2: double; var Xd1,Yd1,Zd1, Xd2,Yd2,Zd2: double; var Stat: Integer);
//пересечение прямой (x1,y1,z1-x2,y2,z2)с эллипсоидом (I=0) или конусом (I=1)
//подвес в точке x0,y0,z0 под углом alfa,betta c полуосями a,b,c
//пересечение в 2-х точках Xd1,..-Xd2,.. Stat=2
//              1-й точке Xd1,..         Stat=1
//            нет                        Stat=0
//ошибка в данных                        Stat=-1
var
 xC,yC,zC: double;
 Xc1,Yc1,Zc1: double;
 Xc2,Yc2,Zc2: double;
 Xi1,Yi1,Zi1: double;
 Xi2,Yi2,Zi2: double;
 t11,t12,t13,t21,t22,t23,t31,t33: double;
begin
 Stat := -1;
   FactorConvert(ZoneForm,x0,y0,z0,alfa+90,betta,a,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33); //определить центр элипса и коэф для новых координат
   InConvert(x1,y1,z1,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33,Xi1,Yi1,Zi1);        //1-я точка секущей в новых коорд
   InConvert(x2,y2,z2,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33,Xi2,Yi2,Zi2);        //2-я точка секущей в новых коорд
 case ZoneForm of
   0,1: Ellips(ZoneForm,Xi1,Yi1,Zi1, Xi2,Yi2,Zi2, a,b,c, Xc1,Yc1,Zc1, Xc2,Yc2,Zc2,Stat);
 end;

   OutConvert(Xc1,Yc1,Zc1,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33,Xd1,Yd1,Zd1);
   OutConvert(Xc2,Yc2,Zc2,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33,Xd2,Yd2,Zd2);
end;
procedure DetectLine(x0,y0,z0, alfa,betta,L, x1,y1,z1, x2,y2,z2,dXc,dYc,dZc: double; var Xd1,Yd1,Zd1: double; var Stat: Integer);
//пересечение прямой (x1,y1,z1-x2,y2,z2)с прямой длиной L
//подвес в точке x0,y0,z0 под углом alfa,betta
//пересечение в 2-х и более точках 1-я в Xd1,.. Stat=2
//              1-й точке                Xd1,.. Stat=1
//            нет                               Stat=0
//ошибка в данных                               Stat=-1
var
 xC,yC,zC: double;
 Xc1,Yc1,Zc1: double;
 Xi1,Yi1,Zi1: double;
 Xi2,Yi2,Zi2: double;
 t11,t12,t13,t21,t22,t23,t31,t33: double;
begin
 Stat := -1;
   FactorConvert(3,x0,y0,z0,alfa-90,betta,1,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33);
   InConvert(x1,y1,z1,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33,Xi1,Yi1,Zi1);
   InConvert(x2,y2,z2,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33,Xi2,Yi2,Zi2);

   Line(Xi1,Yi1,Zi1, Xi2,Yi2,Zi2, dXc,dYc,dZc, Xc1,Yc1,Zc1,Stat);
   If Xc1<0  then Stat := 0; //пересечение до подвеса
   If Xc1>L  then Stat := 0; //пересечение  за пределом длины луча
   OutConvert(Xc1,Yc1,Zc1,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33,Xd1,Yd1,Zd1);
end;

procedure FactorConvert(ZoneForm: Integer; x0,y0,z0,alfa,betta,a: double; var xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33: double);
//вычисление параметров преобразования координат
var
 CosA, CosB, SinA, SinB: double;
begin
  CosA := cos(alfa*Pi/180);
  SinA := sin(alfa*Pi/180);
  CosB := cos(betta*Pi/180);
  SinB := sin(betta*Pi/180);
  case ZoneForm of
  0:begin
      Xc := x0 + a*CosA*CosB;
      Yc := y0 + a*SinA*CosB;
      Zc := z0 + a*SinB
    end;
  1:begin
      Xc := x0;
      Yc := y0;
      Zc := z0
    end;
  else
    begin
      Xc := x0;
      Yc := y0;
      Zc := z0
    end;
  end;

  t11 := CosA*CosB;
  t12 := -SinA;
  t13 := -CosA*SinB;
  t21 := SinA*CosB;
  t22 := CosA;
  t23 := SinA*SinB;
  t31 := SinB;
//t32 := 0;
  t33 := CosB;
end;

procedure InConvert(x,y,z,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33: double; var Xi,Yi,Zi: double);
//переход к новым координатам
begin
  Xi := t11*(x-xC) + t21*(y-yC) + t31*(z-zC);
  Yi := t12*(x-xC) + t22*(y-yC);               // t32 = 0  !
  Zi := t13*(x-xC) + t23*(y-yC) + t33*(z-zC);
end;

procedure OutConvert(Xi,Yi,Zi,xC,yC,zC,t11,t12,t13,t21,t22,t23,t31,t33: double; var x,y,z: double);
//возврат к исходным координатам
begin
  x := xC + t11*Xi + t12*Yi + t13*Zi;
  y := yC + t21*Xi + t22*Yi + t23*Zi;
  z := zC + t31*Xi +          t33*Zi;   // t32 = 0  !
end;

procedure Ellips(ZoneForm: Integer;x1,y1,z1, x2,y2,z2, al,bl,cl: double; var Xc1,Yc1,Zc1, Xc2,Yc2,Zc2: double; var Stat: Integer);
//процедура - пересечение с эллипсом (I=0) или с конусом (I=1)
var
 dx, dy, dz: double;
 a2, b2, c2: double;
 k1, k2, Ak1, Ak2, A, B, C, D: double;
begin
 Stat := -1;
 dX := x2-x1;
 dY := y2-y1;
 dZ := z2-z1;
 a2 := al*al;
 b2 := bl*bl;
 c2 := cl*cl;
 A :=0;
 B :=0;
 C :=0;
 if dX <> 0 then
 begin
  k1 := dY/dX;
  k2 := dZ/dX;
  Ak1 := y1-k1*x1;
  Ak2 := z1-k2*x1;
  case ZoneForm of
    0: begin
       A := 1/a2 + (k1*k1)/b2 + (k2*k2)/c2;
       B := 2*((Ak1*k1)/b2 + (Ak2*k2)/c2);
       C := (Ak1*Ak1)/b2 + (Ak2*Ak2)/c2 -1 end;
    1: begin
       A := 1/a2 + (k1*k1)/b2 - (k2*k2)/c2;
       B := 2*((Ak1*k1)/b2 - (Ak2*k2)/c2);
       C := (Ak1*Ak1)/b2 - (Ak2*Ak2)/c2  end;
  end;
  D := B*B-4*A*C;
  If D>=0 then begin
   D := Sqrt(D);
   If x1<x2 then D :=-D;
   Xc1 := (-B+D)/(2*A);
   Xc2 := (-B-D)/(2*A);
   Yc1 := y1 + k1*(Xc1-x1);
   Yc2 := y1 + k1*(Xc2-x1);
   Zc1 := z1 + k2*(Xc1-x1);
   Zc2 := z1 + k2*(Xc2-x1);
   If abs(D)>0 then Stat := 2 else Stat := 1;  end
  else
   Stat :=0;
 end
 else
 begin
  if dY <> 0 then
  begin
   k1 := dX/dY;
    k2 := dZ/dY;
    Ak1 := x1-k1*y1;
    Ak2 := z1-k2*y1;
    case ZoneForm of
      0: begin
         A := (k1*k1)/a2 + 1/b2 + (k2*k2)/c2;
         B := 2*((Ak1*k1)/a2 + (Ak2*k2)/c2);
         C := (Ak1*Ak1)/a2 + (Ak2*Ak2)/c2 -1 end;
      1: begin
         A := (k1*k1)/a2 + 1/b2 - (k2*k2)/c2;
         B := 2*((Ak1*k1)/a2 - (Ak2*k2)/c2);
         C := (Ak1*Ak1)/a2 - (Ak2*Ak2)/c2  end;
    end;
    D := B*B-4*A*C;
    If D>=0 then  begin
     D := Sqrt(D);
     If y1<y2 then D :=-D;
     Yc1 := (-B+D)/(2*A);
     Yc2 := (-B-D)/(2*A);
     Xc1 := x1 + k1*(Yc1-y1);
     Xc2 := x1 + k1*(Yc2-y1);
     Zc1 := z1 + k2*(Yc1-y1);
     Zc2 := z1 + k2*(Yc2-y1);
     If abs(D)>0 then Stat := 2 else Stat := 1 end
    else
     Stat :=0
  end
  else
  begin
   if dZ <> 0 then
   begin
    k1 := dX/dZ;
     k2 := dY/dZ;
     Ak1 := x1-k1*z1;
     Ak2 := y1-k2*z1;
     case ZoneForm of
       0: begin
         A := (k1*k1)/a2 + (k2*k2)/b2 + 1/c2;
         B := 2*((Ak1*k1)/a2 + (Ak2*k2)/b2);
         C := (Ak1*Ak1)/a2 + (Ak2*Ak2)/b2 -1 end;
       1: begin
         A := (k1*k1)/a2 + (k2*k2)/b2 - 1/c2;
         B := 2*((Ak1*k1)/a2 + (Ak2*k2)/b2);
         C := (Ak1*Ak1)/a2 + (Ak2*Ak2)/b2  end;
     end;
     D := B*B-4*A*C;
     If D>=0 then  begin
      D := Sqrt(D);
      If z1<z2 then D :=-D;
      Zc1 := (-B+D)/(2*A);
      Zc2 := (-B-D)/(2*A);
      Xc1 := x1 + k1*(Zc1-z1);
      Xc2 := x1 + k1*(Zc2-z1);
      Yc1 := y1 + k2*(Zc1-z1);
      Yc2 := y1 + k2*(Zc2-z1);
      If abs(D)>0 then Stat := 2 else Stat := 1 end
     else
      Stat :=0
   end
   else
   begin
    Stat :=-1;
   end;
  end;
 end;
end;

procedure Line(x1,y1,z1, x2,y2,z2, dXc,dYc,dZc: double; var Xc,Yc,Zc : double; var Stat: Integer);
//прцедура пересечения с прямой
var
 dx, dy, dz: double;
 J1,J2,J3,I1,I2: Integer;
begin
 dX := x2-x1;
 dY := y2-y1;
 dZ := z2-z1;
 if dX=0 then J1:=0 else J1:=4;
 if dY=0 then J2:=0 else J2:=2;
 if dZ=0 then J3:=0 else J3:=1;
 Case J1+J2+J3 of
 7:begin Zc :=z1-(dZ/dY)*y1;
    Yc :=y1-(dY/dZ)*z1;
    if abs(Zc)>dZc then I1:=0 else I1:=1;
    if abs(Yc)>dYc then I2:=0 else I2:=2;
    Case I1+I2 of
    3:begin if abs(Zc)<abs(Yc)then Xc:=x1-(dX/dZ)*z1 else Xc:=x1-(dX/dY)*y1;
       Stat := 2 end;
    2:begin Xc:=x1-(dX/dY)*y1;
       Stat := 1 end;
    1:begin Xc:=x1-(dX/dZ)*z1;
       Stat := 1 end;
    0:Stat :=0;
    end;
    end;
 6: begin Xc:=x1-(dX/dY)*y1;
    Zc :=z1;
    Yc :=0;
    if abs(Zc)>dZc then Stat:=0 else Stat:=1; end;
 5: begin Xc:=x1-(dX/dZ)*z1;
    Yc :=y1;
    Zc :=0;
    if abs(Yc)>dYc then Stat:=0 else Stat:=1; end;
 4: begin Xc:=x1;
    Yc :=y1;
    Zc :=z1;
    if (abs(Yc)>dYc) and (abs(Zc)>dZc) then Stat:=0 else Stat:=2; end;
 3: begin Xc:=x1;
    Yc :=y1-(dY/dZ)*z1;
    Zc :=z1-(dZ/dY)*y1;
    if (abs(Zc)>dZc) then Stat:=0 else Stat:=1;
    if (abs(Yc)>dYc) then Stat:=Stat+1 end;
 2: begin Xc:=x1;
    Zc :=z1;
    Yc :=0;
    if abs(Zc)>dZc then Stat:=0 else Stat:=1; end;
 1: begin Xc:=x1;
    Yc :=y1;
    Zc :=0;
    if abs(Yc)>dYc then Stat:=0 else Stat:=1; end;
 0: Stat :=-1;
 end;

end;


const
  W_Array_Count=6;
  W_Array:array[0..W_Array_Count-1] of double=(20,  35, 40, 60, 80, 100);
  W_Array2:array[0..W_Array_Count-1] of double=(35, 40, 60, 80, 100, 200);
  T_Array:array[0..W_Array_Count-1] of double=(3600, 60, 45, 15, 10,   5);

function  GetFieldDetectionProbability(const FieldE: IDMElement;
                                       const SafeguardElementE: IDMElement; FieldValue: Double;
                                       aTime: Double): Double; safecall;
var
  Boundary:IBoundary2;
  SoundResistanceSum, NearestSoundResistanceSum:double;
  SoundPower, SoundPower2, T, T2:double;
  m, NodeDirection:integer;
  FacilityModelS:IFMState;
begin
  Result:=0;

  FacilityModelS:=SafeguardElementE.DataModel as IFMState;
  NodeDirection:=FacilityModelS.CurrentNodeDirection;

  if (SafeguardElementE.Parent.ClassID=_BoundaryLayer) or
     (SafeguardElementE.ClassID=_Target) then begin
    if (SafeguardElementE.Parent.ClassID=_BoundaryLayer) then
      Boundary:=SafeguardElementE.Parent.Parent as IBoundary2
    else // if SafeguardElementE.ClassID=_Target
      Boundary:=SafeguardElementE as IBoundary2;
    if NodeDirection=0 then begin
      SoundResistanceSum:=Boundary.SoundResistanceSum0;
      NearestSoundResistanceSum:=Boundary.NearestSoundResistanceSum0
    end else begin
      SoundResistanceSum:=Boundary.SoundResistanceSum1;
      NearestSoundResistanceSum:=Boundary.NearestSoundResistanceSum1;
    end;
    SoundPower:=FieldValue-4*3.1415926-SoundResistanceSum;
    SoundPower2:=FieldValue-4*3.1415926-NearestSoundResistanceSum;
    Result:=0;

    try
    if SoundPower>=0 then begin
      m:=1;
      while m<W_Array_Count do begin
        if SoundPower<W_Array[m] then
          Break
        else
          inc(m)
      end;
      if m=W_Array_Count then
        m:=W_Array_Count-1;

      T:=T_Array[m-1]+(T_Array[m]-T_Array[m-1])*
                     (SoundPower-W_Array[m-1])/
                     (W_Array[m]-W_Array[m-1]);
    end else
      T:=InfinitValue;

    if SoundPower2>=0 then begin
      m:=1;
      while m<W_Array_Count do begin
        if SoundPower<W_Array2[m] then
          Break
        else
          inc(m)
      end;
      if m=W_Array_Count then
        m:=W_Array_Count-1;

      T2:=T_Array[m-1]+(T_Array[m]-T_Array[m-1])*
                     (SoundPower-W_Array2[m-1])/
                     (W_Array2[m]-W_Array2[m-1]);
    end else
      T2:=InfinitValue;

    if T2<T then
      T:=T2;  

    if T=InfinitValue then
      Result:=0
    else  
    if T>0 then
      Result:=1-exp(-aTime/T)
    else
      Result:=1;
    except
      raise
    end;

  end else
    Result:=0
end;


end.
