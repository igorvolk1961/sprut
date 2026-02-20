unit LaplasGaussFun;
interface
  FUNCTION ERF(Y:real):real;

{                     Y                 }
{ERF(Y)=2/sqr(pi)*Integral(exp(-t^2)dt)}
{                     0                }

  FUNCTION LaplasGauss(Y:real):real;
  FUNCTION LaplasGaussZimenkov(Y:real):real;

{                     Y                 }
{Ô(Y)=1/sqr(2*pi)*Integral(exp(-t^2/2)dt)}
{                   -inf                }

const
  SQRPI:real=0.5641896;
  SQR2:real=1.414213562373;

implementation
  FUNCTION LaplasGauss(Y:real):real;
  const
    P:array[1..3] of real=(0.3166529,1.722276,21.38533);          {COEFFICIENTS FOR}
    Q:array[1..2] of real=(7.843746,18.95226);                    { 0.0<=Y<0.477 }
    P1:array[1..5] of real=(0.5631696,3.031799,6.865018,7.373888,4.318779E-5);
    Q1:array[1..4] of real=(5.354217,12.79553,15.18491,7.373961); { 0.477<=Y<=4.0}
    P2:array[1..3] of real=(-5.168823E-2,-0.1960690,-4.257996E-2);
    Q2:array[1..2] of real=(0.9214524,0.1509421);                 { 4.<Y}
    XMIN:real=1.0E-5;
    XLARGE:real=4.1875E0;
  var
    ISW,I :INTEGER;
    RES,XSQ,XNUM,XDEN,XI,X:real;
  begin
      if (Y>=0) then begin
        X:=Y/SQR2;
        ISW:=1;
      end else begin
        X:=-Y/SQR2;
        ISW:=-1;
      end;
      if X<0.477 then begin
        if (X>=XMIN) then begin
          XSQ := X*X;
          XNUM := (P[1]*XSQ+P[2])*XSQ+P[3];
          XDEN := (XSQ+Q[1])*XSQ+Q[2];
          RES := X*XNUM/XDEN;
        end else RES:=X*P[3]/Q[2];
      end else if X<=4. then begin
        XSQ:=X*X;
        XNUM:=P1[5]*X+P1[1];
        XDEN:=X+Q1[1];
        for I:=2 to 4  do begin
          XNUM:=XNUM*X+P1[I];
          XDEN:=XDEN*X+Q1[I];
        end;
        RES:=1.-XNUM/XDEN*EXP(-XSQ);
      end else if X<XLARGE then begin
        XSQ:=X*X;
        XI:=1./XSQ;
        XNUM:=(P2[1]*XI+P2[2])*XI+P2[3];
        XDEN:=(XI+Q2[1])*XI+Q2[2];
        RES:=1.-(SQRPI+XI*XNUM/XDEN)/X*EXP(-XSQ);
      end else RES := 1.;

      if ISW=+1 then Result:=0.5+0.5*RES
      else Result:=0.5-0.5*RES;
    end;

  FUNCTION ERF(Y:real):real;
  begin
    Result:=2*LaplasGauss(SQR2*Y)-1
  end;

  FUNCTION LaplasGaussZimenkov(Y:real):real;
  const
    A=0.7;
    B=0.8;
  begin
    if Y<0 then
      Result:=0.5*exp(-A*sqr(Y)+B*Y)
    else
      Result:=1-0.5*exp(-A*sqr(Y)-B*Y)
  end;

  END.
