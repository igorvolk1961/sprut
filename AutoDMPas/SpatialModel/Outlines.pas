unit OutLines;

interface
uses
  Classes,  Dialogs, Math, DataModel_TLB, SpatialModelLib_TLB, DMServer_TLB;

  function FindOutlinesDistance(const Outline0, Outline1:IDMCollection;
                          var X0, Y0, Z0, X1, Y1, Z1: double):double;
  function FindPointToOutlineDistance(const Outline:IDMCollection;
                          X0, Y0, Z0:double; var X1, Y1, Z1:double):double;
  function OutlineContainsPoint(P1, P2: Double; Plain: Integer;
      const Lines: IDMCollection): WordBool; safecall;
  function OutlineContainsOutline(const Lines,
      aOutline: IDMCollection): WordBool; safecall;
  procedure GetOutlineCentralPoint(const Lines:IDMCollection;
                             out PX, PY, PZ:double);

  procedure BuildOutline(LinesList, NodesList, NewLinesList:TList;
                         L:double;
                         const SpatialModel:ISpatialModel;
                         const DMOperationManager:IDMOperationManager);
implementation
uses
  Geometry;

function FindOutlinesDistance(const Outline0, Outline1:IDMCollection;
                          var X0, Y0, Z0, X1, Y1, Z1: double):double;
var
  j:integer;
  Line:ILine;
  C0, C1:ICoordNode;
  P0X, P0Y, P0Z, WX1, WY1, WZ1, D:double;
  List:TList;
begin
  List:=TList.Create;

  Result:=999999999;

  for j:=0 to Outline0.Count-1 do begin
    Line:=Outline0.Item[j] as ILine;
    C0:=Line.C0;
    C1:=Line.C1;
    if List.IndexOf(pointer(C0))=-1 then
      List.Add(pointer(C0));
    if List.IndexOf(pointer(C1))=-1 then
      List.Add(pointer(C1));
  end;

  for j:=0 to List.Count-1 do begin
    C0:=ICoordNode(List[j]);
    P0X:=C0.X;
    P0Y:=C0.Y;
    P0Z:=C0.Z;
    D:=FindPointToOutlineDistance(Outline1, P0X, P0Y, P0Z, WX1, WY1, WZ1);
    if Result>D then begin
      Result:=D;
      X0:=P0X;
      Y0:=P0Y;
      Z0:=P0Z;
      X1:=WX1;
      Y1:=WY1;
      Z1:=WZ1;
    end;
  end;
  List.Free;
end;

function FindPointToOutlineDistance(const Outline:IDMCollection;
                          X0, Y0, Z0:double; var X1, Y1, Z1:double):double;
var
  j:integer;
  Line:ILine;
  C0, C1:ICoordNode;
  P0X, P0Y, P0Z, P1X, P1Y, P1Z, WX1, WY1, WZ1, D:double;
begin
  Result:=999999999;
  for j:=0 to Outline.Count-1 do begin
    Line:=Outline.Item[j] as ILine;
    C0:=Line.C0;
    C1:=Line.C1;
    P0X:=C0.X;
    P0Y:=C0.Y;
    P0Z:=C0.Z;
    P1X:=C1.X;
    P1Y:=C1.Y;
    P1Z:=C1.Z;

    D:=_DistanceFromLine(P0X, P0Y, P0Z, P1X, P1Y, P1Z, X0, Y0, Z0, WX1, WY1, WZ1);
    if Result>D then begin
      Result:=D;
      X1:=WX1;
      Y1:=WY1;
      Z1:=WZ1;
    end;
  end;
end;

function OutlineContainsPoint(P1, P2: Double; Plain: Integer;
  const Lines: IDMCollection): WordBool;
var
  j, NumCrosses:integer;
  WPX, WPY, WPZ:double;
  aLine:ILine;
  InLineCode:integer;
begin
  NumCrosses:=0;
  if Lines.Count<3 then begin
    Result:=False;
    Exit;
  end;

  case Plain of
  0:begin
      WPX:=P1;
      WPY:=P2;
      WPZ:=0;
      for j:=0 to Lines.Count-1 do begin
        aLine:=Lines.Item[j] as ILine;
        InLineCode:=aLine.InLineWith(WPX, WPY, WPZ, 1, Plain, True);
        if InLineCode=1 then
          inc(NumCrosses)
        else if InLineCode=2 then begin
          Result:=True;
          Exit;
        end;
      end;
    end;

  1:begin
      WPY:=P1;
      WPZ:=P2;
      WPX:=0;
      for j:=0 to Lines.Count-1 do begin
        aLine:=Lines.Item[j] as ILine;
        InLineCode:=aLine.InLineWith(WPY, WPZ, WPX, 1, Plain, True);
        if InLineCode=1 then
          inc(NumCrosses)
        else if InLineCode=2 then begin
          Result:=True;
          Exit;
        end;
      end;
    end;

  2:begin
      WPZ:=P1;
      WPX:=P2;
      WPY:=0;
      for j:=0 to Lines.Count-1 do begin
        aLine:=Lines.Item[j] as ILine;
        InLineCode:=aLine.InLineWith(WPZ, WPX, WPY, 1, Plain, True);
        if InLineCode=1 then
          inc(NumCrosses)
        else if InLineCode=2 then begin
          Result:=True;
          Exit;
        end;
      end;
    end;

  end;

  if NumCrosses mod 2 =1 then
    Result:=True
  else
    Result:=False;
end;

function OutlineContainsOutline(const Lines,
  aOutline: IDMCollection): WordBool;
var
  j:integer;
  aLine:ILine;
  X0, Y0, X1, Y1, XS, YS:double;
  C0, C1:ICoordNode;
  TMPList:TList;
begin
  Result:=False;
  if Lines.Count<3 then Exit;
  if aOutline.Count=0 then Exit;

  Result:=True;
  TMPList:=TList.Create;
  XS:=0;
  YS:=0;
  for j:=0 to aOutline.Count-1 do begin
    aLine:=aOutline.Item[j] as ILine;
    C0:=aLine.C0;
    C1:=aLine.C1;
    X0:=C0.X;
    Y0:=C0.Y;
    X1:=C1.X;
    Y1:=C1.Y;
    if TMPList.IndexOf(pointer(C0))=-1 then begin
      if not OutlineContainsPoint(X0, Y0, 0, Lines) then begin
        Result:=False;
        TMPList.Free;
        Exit;
      end;
      TMPList.Add(pointer(C0));
      XS:=XS+X0;
      YS:=YS+Y0;
    end;
    if TMPList.IndexOf(pointer(C1))=-1 then begin
      if not OutlineContainsPoint(X1, Y1, 0, Lines) then begin
        Result:=False;
        TMPList.Free;
        Exit;
      end;
      TMPList.Add(pointer(C1));
      XS:=XS+X1;
      YS:=YS+Y1;
    end;
  end;
  TMPList.Free;
  XS:=XS/aOutline.Count;
  YS:=YS/aOutline.Count;
  Result:=OutlineContainsPoint(XS, YS, 0, Lines)
end;

  procedure DoubleLineBuild(const Line:ILine; const L:double;
                            var NewLine:ILine; var Node0,Node1:ICoordNode;
                            const SpatialModel:ISpatialModel;
                            const DMOperationManager:IDMOperationManager);
  var
   X0, Y0, Z0, X1, Y1, Z1,
   X0P, Y0P, X0M, Y0M, X1P, Y1P, X1M, Y1M:double;
   dX, dY:double;
   NewLineU, aNode0U, aNode1U:IUnknown;
   C0, C1:ICoordNode;
   Fl:integer;
   procedure LineBuild(const X0,Y0, X1,Y1, L:double; var Xp0,Yp0, Xm0,Ym0,
                                                         Xp1,Yp1, Xm1,Ym1:double);
   var
    A,B,C,CP,CM,root,ba:double;
   begin

    A:=Y1-Y0;
    if abs(A)<0.1 then
      A:=0;
    B:=-(X1-X0);
    if abs(B)<0.1 then
      B:=0;
    C:=-(A*X0+B*Y0);
    root:=sqrt(A*A+B*B);
    CP:=C-L*root;
    CM:=C+L*root;

    if A<>0 then begin
     if B<>0 then begin
      ba:=B/A;
      Yp0:=(-ba*(Cp/A+X0)+Y0)/(1+ba*ba);
      Xp0:=-(B*Yp0+Cp)/A;
      Yp1:=(-ba*(Cp/A+X1)+Y1)/(1+ba*ba);
      Xp1:=-(B*Yp1+Cp)/A;

      Ym0:=(-ba*(Cm/A+X0)+Y0)/(1+ba*ba);
      Xm0:=-(B*Ym0+Cm)/A;
      Ym1:=(-ba*(Cm/A+X1)+Y1)/(1+ba*ba);
      Xm1:=-(B*Ym1+Cm)/A;
     end else begin
      Xp0:=X0+L;
      Yp0:=Y0;
      Xp1:=Xp0;
      Yp1:=Y1;

      Xm0:=X0-L;
      Ym0:=Y0;
      Xm1:=Xm0;
      Ym1:=Y1;
     end;
    end else begin
     Xp0:=X0;
     Yp0:=Y0+L;
     Xp1:=X1;
     Yp1:=Y1+L;

     Xm0:=X0;
     Ym0:=Y0-L;
     Xm1:=X1;
     Ym1:=Y1-L;
    end;
   end;

  var
    aParent:IDMElement;
    Lines2, CoordNodes2:IDMCollection2;
    NewLineE:IDMElement;
  begin
      C0:=Line.C0;
      C1:=Line.C1;
      X0:=C0.X;
      Y0:=C0.Y;
      Z0:=C0.Z;
      X1:=C1.X;
      Y1:=C1.Y;
      Z1:=C1.Z;

      LineBuild(X0,Y0, X1,Y1, L, X0p,Y0p, X0m,Y0m, X1p,Y1p, X1m,Y1m);
      aParent:=(Line as IDMElement).Parent;
      Lines2:=SpatialModel.Lines as IDMCollection2;
      CoordNodes2:=SpatialModel.CoordNodes as IDMCollection2;

      if DMOperationManager<>nil then
        DMOperationManager.AddElement(aParent,
                          Lines2, '', ltOneToMany, NewLineU, True)
      else begin
        NewLineU:=Lines2.CreateElement(True);
        NewLineU._AddRef;
      end;

      NewLineE:=NewLineU as IDMElement;
      NewLine:=NewLineE as ILine;

      if DMOperationManager<>nil then
        DMOperationManager.AddElement(aParent,
                          CoordNodes2, '', ltOneToMany, aNode0U, True)
      else begin
        aNode0U:=CoordNodes2.CreateElement(True);
        aNode0U._AddRef;
      end;

      Node0:=aNode0U as ICoordNode;
      NewLine.C0:=Node0;

      if DMOperationManager<>nil then
        DMOperationManager.AddElement(aParent,
                          SpatialModel.CoordNodes, '', ltOneToMany, aNode1U, True)
      else begin
        aNode1U:=CoordNodes2.CreateElement(True);
        aNode1U._AddRef;
      end;

      Node1:=aNode1U as ICoordNode;
      NewLine.C1:=Node1;

      dX:=X1-X0;
      if abs(dX)<0.1 then
        dX:=0;
      dY:=Y1-Y0;
      if abs(dY)<0.1 then
        dY:=0;
      Fl:=Sign(dX)*10+Sign(dY);  //Fl=(1..-1 / 11..-11)
      case Fl of
      -1,10:begin
       Node0.X:=X0P;
       Node0.Y:=Y0P;
       Node0.Z:=Z0;

       Node1.X:=X1P;
       Node1.Y:=Y1P;
       Node1.Z:=Z1;
      end;
      1,-9,9,-10,-11,11:begin
       Node0.X:=X0M;
       Node0.Y:=Y0M;
       Node0.Z:=Z0;

       Node1.X:=X1M;
       Node1.Y:=Y1M;
       Node1.Z:=Z1;
      end;
      end;
  end;

  function Crossing( Node1X,Node1Y, Node2X,Node2Y,
                Node3X,Node3Y, Node4X,Node4Y:Double; var X,Y:Double):boolean;
  var
   X1,Y1,X2,Y2,X3,Y3,X4,Y4,dX12,dY12,dX34,dY34,d12,d34:double;
   a,b:double;
  begin  { function Crossing __________________________________________}
     Node1X:=(Trunc(Node1X*100))/100;
     Node1Y:=(Trunc(Node1Y*100))/100;
     Node2X:=(Trunc(Node2X*100))/100;
     Node2Y:=(Trunc(Node2Y*100))/100;
     Node3X:=(Trunc(Node3X*100))/100;
     Node3Y:=(Trunc(Node3Y*100))/100;
     Node4X:=(Trunc(Node4X*100))/100;
     Node4Y:=(Trunc(Node4Y*100))/100;

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
     Result:=True;

  end; { function Crossing __________________________________________}

   function  RegularizeNodesList(LinesList,NodesList:TList):integer;
   {Result=0 лин.замкнута;  Result=1..Count лин.незамкнута;   Result=-1,-2  Error;}
   var
       j,i,k,m,n, mn,mk, aCount:integer;
       J1,J2,Jn,Jk:integer;
       aNode,aNodeK1,aNodeK2:ICoordNode;
       x1,x2,y1,y2:double;
       TmpList:TList;
       aLine1, aLine2:ILine;
       C01, C11, C02, C12:ICoordNode;
   begin
   //----------------------------------------
     Result:=0;
     aCount:=LinesList.Count;
     if aCount=1 then Exit;

     {найти начало}
     m:=0;                                 //всего соединений (узлов)
     n:=0;                                 //всего концевых лин. (не больше 2-х)
     for j:=0 to aCount-1 do begin
      aLine1:=ILine(LinesList[j]);
      k:=0;                                //соединений с этой лин. (не больше 2-х)
      mn:=0;                               //соединений с С0  (не больше 1)
      mk:=0;                               //соединений с С1  (не больше 1)
      C01:=aLine1.C0;
      C11:=aLine1.C1;
      for i:=0 to aCount-1 do begin
       aLine2:=ILine(LinesList[i]);
       C02:=aLine2.C0;
       C12:=aLine2.C1;
       if i<>j then begin
        if (C01=C02)or(C01=C12) then begin
         inc(k);
         inc(m);
         inc(mn);
         aNode:=C01;
        end;
        if (C11=C02)or(C11=C12) then begin
         inc(k);
         inc(m);
         inc(mk);
         aNode:=C11;
        end;
       end;
      end;
      if k=1 then
       if n=0 then begin
         inc(n);
//         J1:=j;
         aNodeK1:=aNode;
       end else
        if n=1 then begin
          inc(n);
//          J2:=j;
          aNodeK2:=aNode;
        end else begin
          Result:=-1;
          break;
        end
      else
       if k=0 then begin
        Result:=-1;
        break;
       end else
        if k>2 then begin
         Result:=-1;
         break;
        end else
         if (mn>1)or(mk>1)then begin
          Result:=-1;
          break;
         end;
      if Result<0 then
       break;
     end;


     j1:=0;
     Jn:=0;
     J2:=0;
     Jk:=0;
     y1:=0;
     y2:=0;

     if aCount=m/2 then
      if n=0 then begin
       j1:=0;
       Jn:=0;
       J2:=aCount-1;        {eсли замкнуто}
       Jk:=aCount-1;
      end else
       Result:=-2           {возможно Err}
     else
      if n=2 then begin     {если не замкнуто: где началo-конец }
       x1:=aNodeK1.X;
       y1:=aNodeK1.Y;
       x2:=aNodeK2.X;
       y2:=aNodeK2.Y;
       if x1<x2 then begin
        Jn:=J1;
        Jk:=J2;
       end else
        if x1<>x2 then begin
         Jn:=J2;
         Jk:=J1;
        end else
         if y1<y2 then begin
          Jn:=J1;
          Jk:=J2;
         end else
          if y1<>y2 then begin
           Jn:=J2;
           Jk:=J1;
          end else
           Result:=-2;
      end else
       Result:=-2;

     if Result<0 then begin
      case Result of
      -1: MessageDlg('в выделенном объекте есть ветвление или разрыв,'
                                 +' проверте выделение ', mtWarning, [mbOk], 0);
      -2: MessageDlg('проверте выделен. объект', mtWarning, [mbOk], 0);
      end;
      Exit;
     end;

     if aCount=m/2 then begin
      aLine1:=ILine(LinesList[0]);
      C01:=aLine1.C0;
      C11:=aLine1.C1;
      x1:=aLine1.C0.X;
      x2:=aLine1.C1.X;
       if x1>x2 then begin
        aLine1.C0:=C11;
        aLine1.C1:=C01;
       end else
        if x1=x2 then
         if y1<y2 then begin
          aLine1.C0:=C11;
          aLine1.C1:=C01;
         end;
     end else begin                             {выстроить C0-->C1 концевыx лин.}
      aLine1:=ILine(LinesList[J1]);
      C01:=aLine1.C0;
      C11:=aLine1.C1;
      if (C01=aNodeK1) then begin
       aLine1.C0:=C11;
       aLine1.C1:=C01;
      end;
      aLine2:=ILine(LinesList[J2]);
      C02:=aLine2.C0;
      C12:=aLine2.C1;
      if (C02=aNodeK1) then begin
       aLine2.C0:=C12;
       aLine2.C1:=C02;
      end;

      if aCount-1<>Jn then              {уст. концевые в начало-конец}
       LinesList.Exchange(aCount-1, Jk);
      if Jn<>0 then
       LinesList.Exchange(0, Jn);

     end;

                                       {выстроить C0-->C1 в TmpList}
     TmpList:=TList.Create;
     j:=0;
     aLine1:=ILine(LinesList[0]);
     TmpList.Add(pointer(aLine1));
     while (j<LinesList.Count)and(LinesList.Count>1)  do begin
      aLine1:=ILine(LinesList[j]);
      C01:=aLine1.C0;
      C11:=aLine1.C1;
      i:=0;
      while i<LinesList.Count do begin
       if i<>j then begin
        aLine2:=ILine(LinesList[i]);
        C02:=aLine2.C0;
        C12:=aLine2.C1;
        if (C01=C02)or(C01=C12)or(C11=C02)or(C11=C12) then
         if TmpList.IndexOf(pointer(aLine2))=-1 then begin
          if (C11=C12)or(C01=C02) then begin
           aLine2.C0:=C12;
           aLine2.C1:=C02;
          end;
          TmpList.Add(pointer(aLine2));
          LinesList.Delete(j);
          j:=LinesList.IndexOf(pointer(aLine2));
          break;
         end;
       end;
       inc(i);
      end;
     end;


                                         {tmpList -> LinesList}
     LinesList.Clear;
     for j:=0 to TmpList.Count-1 do begin
      aLine1:=ILine(TmpList[j]);
      LinesList.Add(pointer(aLine1));
     end;
     TmpList.Free;
                                         {build NodesList}
     NodesList.Clear;
     for j:=0 to LinesList.Count-1 do begin
      aLine1:=ILine(LinesList[j]);
      C01:=aLine1.C0;
      C11:=aLine1.C1;
      for i:=0 to aCount-1 do begin
       if i<>j then begin
        aLine2:=ILine(LinesList[i]);
        C02:=aLine2.C0;
        C12:=aLine2.C1;
        if C01=C02 then begin
         NodesList.Add(pointer(j));
         NodesList.Add(pointer(i));
        end else
         if C01=C12 then begin
          NodesList.Add(pointer(j));
          NodesList.Add(pointer(i));
         end else
          if C11=C02 then begin
           NodesList.Add(pointer(j));
           NodesList.Add(pointer(i));
         end else
          if C11=C12 then begin
           NodesList.Add(pointer(j));
           NodesList.Add(pointer(i));
        end;
       end;
      end;
     end;

     j:=0;
     While j<NodesList.Count-3 do begin   //удал.повтров (if m,n = n,m)
       m:=integer(NodesList[j]);
       n:=integer(NodesList[j+1]);
       i:=j+2;
       While i<NodesList.Count-1 do begin
        if (integer(NodesList[i])=n)and(integer(NodesList[i+1])=m)then begin
         NodesList.Delete(i);
         NodesList.Delete(i);
         break;
        end;
        inc(i,2);
       end;
       inc(j,2);
     end;

   if NodesList.Count=aCount*2 then
      Result:=aCount
   else
      Result:=NodesList.Count;

  end;
  
procedure BuildOutline(LinesList, NodesList, NewLinesList:TList;
                       L:double;
                       const SpatialModel:ISpatialModel;
                       const DMOperationManager:IDMOperationManager);
var
  j, i, m, n, k, FL:integer;
  aLine, NewLine:ILine;
  aNode0, aNode1, aNode01, aNode11, aNode02, aNode12:ICoordNode;
  TmpList:TList;
  X0, Y0:double;
  Flag:boolean;
  aNodeE:IDMElement;
begin
  RegularizeNodesList(LinesList,NodesList);      //выстроить линии  C0 --> C1

  for j:=0 to LinesList.Count-1 do begin
    aLine:=ILine(LinesList[j]);

    DoubleLineBuild(aLine, L, NewLine,aNode0,aNode1,
                   SpatialModel, DMOperationManager);  //построить нов.лин.на расст.L(-L)

    NewLinesList.Add(pointer(NewLine));              // Move  newLine in list
  end;

         {связать узлами новые линии в цепочку}
  TmpList:=TList.Create;
  i:=0;
  While i<NodesList.Count-1 do begin
    m:=integer(NodesList[i]);
    n:=integer(NodesList[i+1]);
    inc(i,2);
    aNode01:=ILine(LinesList[m]).C0;//aNode01/11(02/12) C0/C1 new line 1(2)
    aNode11:=ILine(LinesList[m]).C1;//(double old line 1(2) )
    aNode02:=ILine(LinesList[n]).C0;
    aNode12:=ILine(LinesList[n]).C1;
    if aNode01=aNode02 then
      FL:=0
    else
    if aNode01=aNode12 then
      FL:=1
    else
    if aNode11=aNode02 then
      FL:=10
    else
    if aNode11=aNode12 then
      FL:=11
    else
      FL:=-1;  

    aNode01:=ILine(NewLinesList[m]).C0;//aNode01/11(02/12) C0/C1 new line 1(2)
    aNode11:=ILine(NewLinesList[m]).C1;//(double old line 1(2) )
    aNode02:=ILine(NewLinesList[n]).C0;
    aNode12:=ILine(NewLinesList[n]).C1;
    case FL of
    0:begin
        Crossing(aNode01.X,aNode01.Y,aNode11.X,aNode11.Y,
               aNode02.X,aNode02.Y,aNode12.X,aNode12.Y, X0, Y0);
        aNode01.X:=X0;
        aNode01.Y:=Y0;
        ILine(NewLinesList[m]).C0:=aNode01;
        ILine(NewLinesList[n]).C0:=aNode01;
        TmpList.Add(pointer(aNode02));
      end;
    1:begin
        Crossing(aNode01.X,aNode01.Y,aNode11.X,aNode11.Y,
               aNode02.X,aNode02.Y,aNode12.X,aNode12.Y,X0,Y0);
        aNode01.X:=X0;
        aNode01.Y:=Y0;
        ILine(NewLinesList[m]).C0:=aNode01;
        ILine(NewLinesList[n]).C1:=aNode01;
        TmpList.Add(pointer(aNode12));
      end;
    10: begin
         Crossing(aNode01.X,aNode01.Y,aNode11.X,aNode11.Y,
               aNode02.X,aNode02.Y,aNode12.X,aNode12.Y,X0,Y0);
         aNode11.X:=X0;
         aNode11.Y:=Y0;
         ILine(NewLinesList[m]).C1:=aNode11;
         ILine(NewLinesList[n]).C0:=aNode11;
         TmpList.Add(pointer(aNode02));
       end;
    11: begin
         Crossing(aNode01.X,aNode01.Y,aNode11.X,aNode11.Y,
               aNode02.X,aNode02.Y,aNode12.X,aNode12.Y,X0,Y0);
         aNode11.X:=X0;
         aNode11.Y:=Y0;
         ILine(NewLinesList[m]).C1:=aNode11;
         ILine(NewLinesList[n]).C1:=aNode11;
         TmpList.Add(pointer(aNode12));
       end;
    end;
  end;
                {удалить пустые узлы}
  for j:=0 to TmpList.Count-1 do begin
   aNode01:=ICoordNode(TmpList[j]);
   Flag:=False;
   for k:=0 to NewLinesList.Count-1 do begin
    aLine:=ILine(NewLinesList[k]);
    aNode02:=aLine.C0;
    aNode12:=aLine.C1;
    if (aNode01=aNode02)or(aNode01=aNode12) then
      Flag:=True;
   end;
   if not Flag then begin
    aNodeE:=aNode01 as IDMElement;
    if DMOperationManager<>nil then
      DMOperationManager.DeleteElement(nil,nil,ltOneToMany, aNodeE)
    else
      aNodeE._Release;
   end;
  end;
  
  TmpList.Free;
end;

procedure GetOutlineCentralPoint(const Lines:IDMCollection;
                             out PX, PY, PZ:double);
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
end;

end.
