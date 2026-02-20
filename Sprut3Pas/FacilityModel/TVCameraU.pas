unit TVCameraU;

interface
uses
  Classes, SysUtils, Math, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DistantDetectionElementU;

const
  vrNoVideoRecord=0;
  vrSimpleVideoRecord=1;
  vrAlarmNoVideoRecord=2;
  vrAlarmVideoRecord=3;
  vrPreAlarmVideoRecord=4;

type
  TTVCamera=class(TDistantDetectionElement, ITVCamera, IAlarmAssess, IWidthIntf,
                      IObservationElement)
  private
    FViewAngle: Double;
    FIsSlewing: boolean;
    FSlewAngle: Double;
    FMotionSensor: boolean;
    FVideoRecord:integer;
    procedure CalcIntersection(X0, Y0, X1, Y1:double;
        var XS1, YS1, XS2, YS2: double; var F: integer);
  protected
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Set_Ref(const Value: IDMElement); override; safecall;
    class function  GetClassID:integer; override;
    procedure SetDefaults; override;
    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    function GetDistantDetection(const OvercomeMethodU:IUnknown;
                                 DetP, aTime: Double): Double; override; safecall;
    function PointInDetectionZone(X, Y, Z:double; const CRef, ExcludeAreaE:IDMElement):WordBool; override; safecall;
    function DoCalcDetectionProbability(const TacticU:IUnknown;
                          const OvercomeMethodE:IDMElement;
                          DelayTime:double;
                          var DetP0, DetPf, WorkP:double;
                          CalcAll:WordBool):double; override; safecall;
    function  GetMethodDimItemIndex(Kind, Code: Integer;
                        const DimItems: IDMCollection;
                        const ParamE:IDMElement;
                              ParamF:double): Integer; override; safecall;
   procedure GetCoord(var X0, Y0, Z0:double); override; safecall;

// ITVCamera

    function  Get_ViewAngle: Double; safecall;
    function  Get_IsSlewing: WordBool; safecall;
    function  Get_SlewAngle: Double; safecall;
    function  Get_MotionSensor: WordBool; safecall;
    function  Get_VideoRecord:integer; safecall;

// IAlarmAssess
    function GetAssessProbability: Double; safecall;
// IWidthIntf
    function Get_Width: Double; safecall;

//IObservationElement
    function GetObservationPeriod(Distance:double): double; safecall;

  end;

  TTVCameras=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;


{ TTVCamera }

procedure TTVCamera.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  Image:IElementImage;
  Painter:IPainter;
  Layer:ILayer;
  aLine:ILine;
  C0, C1:ICoordNode;
  L, Z:double;
  SafeguardDatabase:ISafeguardDatabase;
  TVCameraKind:ITVCameraKind;
  cosA, sinA, cosZ, sinZ, A, LL, ZAngle, cos_A,
  WX0, WY0, WZ0, WX1, WY1, WZ1, WX2, WY2, X0, Y0, X1, Y1:double;
  SpatialModel:ISpatialModel;
  BoundaryLayer:IBoundaryLayer;
begin
  if Ref=nil then Exit;
  if Parent=nil then Exit;
  Painter:=aPainter as IPainter;

  TVCameraKind:=Ref as ITVCameraKind;

  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;
  Image:=SafeguardDatabase.SphearSectorImage as IElementImage;
  if (Image=nil) or
    not (DataModel as IVulnerabilityMap).ShowDetectionZones or
    not FShowDetectionZone then begin
    inherited;
    Exit;
  end;

  ZAngle:=0;
  if SpatialElement<>nil then begin
    Layer:=SpatialElement.Parent as ILayer;
    if not Layer.Visible then Exit;
    SpatialModel:=DataModel as ISpatialModel;
    if Painter.UseLayers then
       Painter.LayerIndex:=SpatialModel.Layers.IndexOf(SpatialElement.Parent);
    aLine:=Get_SpatialElement as ILine;
    C0:=aLine.C0;
    C1:=aLine.C1;
    if C0=nil then Exit;
    if C1=nil then Exit;
    WX0:=C0.X;
    WY0:=C0.Y;
    WZ0:=C0.Z;
    WX1:=C1.X;
    WY1:=C1.Y;
    WZ1:=C1.Z;
    Z:=WZ0+Get_Elevation;
    L:=sqrt(sqr(WX1-WX0)+sqr(WY1-WY0));
    if L=0 then Exit;
    cosZ:=(WX1-WX0)/L;
    sinZ:=(WY1-WY0)/L;
  end else begin
    case Parent.ClassID of
    _BoundaryLayer:
      begin
        Layer:=Parent.Parent.SpatialElement.Parent as ILayer;

        BoundaryLayer:=Parent as IBoundaryLayer;
        X0:=BoundaryLayer.X0;
        Y0:=BoundaryLayer.Y0;
        X1:=BoundaryLayer.X1;
        Y1:=BoundaryLayer.Y1;
        LL:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));
        if LL=0 then
          ZAngle:=0
        else begin
          cos_A:=(X1-X0)/LL;
          if cos_A=1 then
            ZAngle:=0
         else
          if cos_A=0 then
            ZAngle:=90
          else
            ZAngle:=arccos(cos_A)/3.1415926*180;
          if Y1-Y0<0 then
             ZAngle:=-ZAngle;
        end;
      end;
    _Zone:
      Layer:=Parent.SpatialElement.Parent as ILayer;
    else
      Layer:=nil;
    end;
    GetCoord(WX0, WY0, WZ0);
    Z:=WZ0+Get_Elevation;
    L:=FMaxDistance*100;
    A:=GetRotationAngle+ZAngle;
    cosZ:=cos(A/180*Pi);
    sinZ:=sin(A/180*Pi);
    WX1:=WX0+L*cosZ;
    WY1:=WY0+L*sinZ;
    WZ1:=WZ0;
  end;

  if (DrawSelected=1) then
    Painter.PenColor:=clLime
  else if (DrawSelected=-1) then
    Painter.PenColor:=clWhite
  else
    Painter.PenColor:=Layer.Color;

  Painter.PenStyle:=ord(psDot);
  Painter.DrawLine(WX0,WY0,Z,WX1,WY1,WZ1);

  if FIsSlewing then
    A:=FSlewAngle/2
  else
    A:=FViewAngle/2;

  cosA:=cos(A/180*pi);
  sinA:=sqrt(1-sqr(cosA));

  Painter.PenStyle:=ord(psSolid);

  WX2:=WX0+(cosZ*cosA-sinZ*sinA)*L;
  WY2:=WY0+(sinZ*cosA+cosZ*sinA)*L;
  Painter.DrawLine(WX0,WY0,Z,WX2,WY2,WZ0);

  WX2:=WX0+(cosZ*cosA+sinZ*sinA)*L;
  WY2:=WY0+(sinZ*cosA-cosZ*sinA)*L;
  Painter.DrawLine(WX0,WY0,Z,WX2,WY2,WZ0);
  Painter.DrawArc(WX0,WY0,WZ0,WX1,WY1,WZ0,WX2,WY2,WZ0);

  inherited;

end;

class function TTVCamera.GetClassID: integer;
begin
  Result:=_TVCamera;
end;

procedure TTVCamera.CalcIntersection(X0, Y0, X1, Y1:double;
                  var XS1, YS1, XS2, YS2:double;var F:integer);
var
  aLine:ILine;
  CC0, CC1:ICoordNode;
  WX0, WY0, WX1, WY1, L, A, D,
  cosA, sinA, cosG, sinG, cosB1, sinB1, cosB2, sinB2, tgB1, tgB2:double;
begin
  if not FUseDetectionZone  then begin
    XS1:=X0;
    YS1:=Y0;
    XS2:=X1;
    YS2:=Y1;
    F:=2;
    Exit;
  end;

  aLine:=Get_SpatialElement as ILine;

  CC0:=aLine.C0;
  CC1:=aLine.C1;
  WX0:=CC0.X;
  WY0:=CC0.Y;
  WX1:=CC1.X;
  WY1:=CC1.Y;
  L:=sqrt(sqr(WX1-WX0)+sqr(WY1-WY0));
  cosG:=(WX1-WX0)/L;
  sinG:=(WY1-WY0)/L;
  if FIsSlewing then
    A:=FSlewAngle/2
  else
    A:=FViewAngle/2;

  cosA:=cos(A/180*pi);
  sinA:=sqrt(1-sqr(cosA));
  cosB1:=cosG*cosA-sinG*sinA;
  cosB2:=cosG*cosA+sinG*sinA;
  sinB1:=sinG*cosA+cosG*sinA;
  sinB2:=sinG*cosA-cosG*sinA;
  if X0=X1 then
    D:=InfinitValue
  else
    D:=(Y1-Y0)/(X1-X0);
  if cosB1=0 then
    tgB1:=InfinitValue
  else
    tgB1:=sinB1/cosB1;
  if cosB2=0 then
    tgB2:=InfinitValue
  else
    tgB2:=sinB2/cosB2;

  F:=0;

  if cosB1=0 then begin
    if X0=X1 then
      F:=1
    else begin
      XS1:=WX0;
      YS1:=Y0+D*(XS1-X0);
      if (YS1-WY0)*sinB1<0 then
        F:=1;
    end
  end else begin
    if X0=X1 then begin
      XS1:=X0;
      YS1:=WY0+tgB1*(XS1-WX0);
      if (XS1-WX0)*cosB1<0 then
        F:=1;
    end else begin
      if D-tgB1=0 then
        F:=1
      else begin
        XS1:=-((Y0-D*X0)-(WY0-tgB1*WX0))/(D-tgB1);
        YS1:=Y0+D*(XS1-X0);
        if (XS1-WX0)*cosB1<0 then
          F:=1;
      end;
    end;
  end;

  if cosB2=0 then begin
    if X0=X1 then
      F:=F+2
    else begin
      XS2:=WX0;
      YS2:=Y0+D*(XS2-X0);
      if (YS2-WY0)*sinB2<0 then
        F:=F+2;
    end
  end else begin
    if X0=X1 then begin
      XS2:=X0;
      YS2:=WY0+tgB2*(XS2-WX0);
      if (XS2-WX0)*cosB2<0 then
        F:=F+2;
    end else begin
      if D-tgB2=0 then
        F:=F+2
      else begin
        XS2:=-((Y0-D*X0)-(WY0-tgB2*WX0))/(D-tgB2);
        YS2:=Y0+D*(XS2-X0);
        if (XS2-WX0)*cosB2<0 then
          F:=F+2;
      end;
    end;
  end;

end;

function TTVCamera.GetAssessProbability: Double;
begin
  if InWorkingState then begin
    case FVideoRecord of
    vrNoVideoRecord:
      Result:=0;
    vrSimpleVideoRecord:
      Result:=0.1;
    vrAlarmNoVideoRecord:
      Result:=0.5;
    vrAlarmVideoRecord:
      Result:=0.95;
    vrPreAlarmVideoRecord:
      Result:=0.99;
    else
      Result:=0
    end;
  end else
    Result:=0
end;

function TTVCamera.PointInDetectionZone(X, Y, Z: double; const CRef, ExcludeAreaE:IDMElement): WordBool;
var
  X0, Y0, Z0, X1, Y1 {, Z1}:double;
  C0, C1:ICoordNode;
  cosAA, cosG, R, L, RR, LL:double;
  Line:ILine;
  ParentVolume:IVolume;
begin
  if (SpatialElement=nil) or
     (not FUseDetectionZone)  then begin
    ParentVolume:=Parent.SpatialElement as IVolume;
    Result:=ParentVolume.ContainsPoint(X, Y, Z);
    Exit;
  end;

  Result:= inherited PointInDetectionZone(X, Y, Z, CRef, ExcludeAreaE);
  if not Result then Exit;

  Line:=SpatialElement as ILine;
  C0:=Line.C0;
  C1:=Line.C1;

  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z+Get_Elevation;
  R:=sqrt(sqr(X0-X)+sqr(Y0-Y)+sqr(Z0-Z));
  RR:=sqrt(sqr(X0-X)+sqr(Y0-Y));

  Result:=False;
  if R>2000*100 then Exit;
  Result:=True;
  if R=0 then Exit;

  X1:=C1.X;
  Y1:=C1.Y;
//  Z1:=C1.Y;

  L:=Line.Length;
  LL:=sqrt(sqr(X0-X1)+sqr(Y0-Y1));

  if L=0 then Exit;

  cosAA:=((X0-X)*(X0-X1)+(Y0-Y)*(Y0-Y1))/(RR*LL);
//  cosBB:=(Z0-Z)*(Z0-Z1)/(R*L);
  if FIsSlewing then begin
    if FSlewAngle=0 then
      cosG:=1
    else
    if abs(FSlewAngle)=90 then
      cosG:=0
    else
      cosG:=cos(0.5*FSlewAngle/180*3.1415926);
    Result:=(cosAA>cosG)
  end else begin
    if FViewAngle=0 then
      cosG:=1
    else
    if abs(FViewAngle)=90 then
      cosG:=0
    else
      cosG:=cos(0.5*FViewAngle/180*3.1415926);
    Result:=(cosAA>cosG)
  end;
end;

procedure TTVCamera.Set_SpatialElement(const Value: IDMElement);
var
  Line:ILine;
  L,Length, LengthXY,Height:double;
  C0, C1:ICoordNode;
  TVCameraKind:ITVCameraKind;
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if Value=nil then Exit;
  if Value.QueryInterface(ILine, Line)=0 then begin
    TVCameraKind:=Ref as ITVCameraKind;
    Length:=TVCameraKind.ViewLength*100;
    if Length<=0 then Exit;

    L:=Line.Length;
    if L=0 then Exit;
    C0:=Line.C0;
    C1:=Line.C1;

    Height:=FElevation*100;
    LengthXY:=sqrt(sqr(Length)-sqr(Height));
    C1.X:=C0.X+(C1.X-C0.X)*LengthXY/L;
    C1.Y:=C0.Y+(C1.Y-C0.Y)*LengthXY/L;
  end;
end;

procedure TTVCamera.SetDefaults;
var
  FacilityModel:IFacilityModel;
  j:integer;
  ControlDeviceE:IDMElement;
  ControlDeviceKind:IControlDeviceKind;
begin
  FacilityModel:=DataModel as IFacilityModel;
  j:=0;
  while j<FacilityModel.ControlDevices.Count do begin
    ControlDeviceE:=FacilityModel.ControlDevices.Item[j];
    ControlDeviceKind:=ControlDeviceE.Ref as IControlDeviceKind;
    case ControlDeviceKind.SystemKind of
    skComplexSystem,
    skTVSystem:
      Break
    else
      inc(j)
    end;
  end;
  if j<FacilityModel.ControlDevices.Count then
    Set_MainControlDevice(ControlDeviceE);

  if FacilityModel.TechnicalServices.Count<>0 then
    Set_TechnicalService(FacilityModel.TechnicalServices.Item[0])
end;

function TTVCamera.GetMethodDimItemIndex(Kind, Code: Integer;
  const DimItems: IDMCollection; const ParamE: IDMElement;
  ParamF: double): Integer;
var
  ControlDevice:ICabelNode;
  TVMonitorCount:integer;
begin
  case Kind of
  sdDetectionSector:
    case Code of
    0:begin
        if FMotionSensor then
          Result:=1  // в зоне особого внимания
        else begin
          ControlDevice:=Get_MainControlDevice as ICabelNode;
          if ControlDevice<>nil then begin
            TVMonitorCount:=ControlDevice.Connections.Count;
            if TVMonitorCount>8 then
              Result:=2  // вне зоны особого внимания
            else
              Result:=0  // круговой обзор
          end else
            Result:=2    // вне зоны особого внимания
        end;
      end;
    else
      Result:=0;
    end;
  else
    Result:=inherited GetMethodDimItemIndex(Kind, Code, DimItems,
                                            ParamE, ParamF );
  end
end;

function TTVCamera.Get_IsSlewing: WordBool;
begin
  Result:=FIsSlewing
end;

function TTVCamera.Get_MotionSensor: WordBool;
begin
  Result:=FMotionSensor
end;

function TTVCamera.Get_SlewAngle: Double;
begin
  Result:=FSlewAngle
end;

function TTVCamera.Get_ViewAngle: Double;
begin
  Result:=FViewAngle
end;

class function TTVCamera.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TTVCamera.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsMotionSensor,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tvcMotionSensor), 0, pkInput);
  AddField(rsViewAngle, '%3.0f', '', '',
                 fvtFloat, 60, 0, 360,
                 ord(tvcViewAngle), 0, pkInput);
  AddField(rsIsSlewing,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tvcIsSlewing), 0, pkInput);
  AddField(rsSlewAngle, '%3.0f', '', '',
                 fvtFloat, 300, 0, 360,
                 ord(tvcSlewAngle), 2, pkInput);
  S:='|'+rsNoVideoRecord+
     '|'+rsSimpleVideoRecord+
     '|'+rsAlarmNoVideoRecord+
     '|'+rsAlarmVideoRecord+
     '|'+rsPreAlarmVideoRecord;
  AddField(rsVideoRecord, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(tvcVideoRecord), 0, pkInput);
end;

function TTVCamera.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(tvcMotionSensor):
    Result:=FMotionSensor;
  ord(tvcViewAngle):
    Result:=FViewAngle;
  ord(tvcIsSlewing):
    Result:=FIsSlewing;
  ord(tvcSlewAngle):
    Result:=FSlewAngle;
  ord(tvcVideoRecord):
    Result:=FVideoRecord;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TTVCamera.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(tvcMotionSensor):
    FMotionSensor:=Value;
  ord(tvcViewAngle),
  ord(tvcIsSlewing),
  ord(tvcSlewAngle):
    begin
      Redraw(-1);
      case Code of
      ord(tvcViewAngle):
        FViewAngle:=Value;
      ord(tvcIsSlewing):
        FIsSlewing:=Value;
      ord(tvcSlewAngle):
        FSlewAngle:=Value;
      end;
      Redraw(1);
    end;
  ord(tvcVideoRecord):
    FVideoRecord:=Value;
  else
    inherited;
  end;
end;

function TTVCamera.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(tvcSlewAngle):
    Result:=FIsSlewing;
  ord(tvcLocalAlarmSignal):
    Result:=False;
  else
    Result:=inherited FieldIsVisible(Code);
  end;
end;

procedure TTVCamera.Set_Ref(const Value: IDMElement);
var
  TVCameraKind:ITVCameraKind;
begin
  inherited;
  if Value=nil then Exit;
  TVCameraKind:=Value as ITVCameraKind;
  FViewAngle:=TVCameraKind.ViewAngle;
  FMaxDistance:=TVCameraKind.ViewLength;
  FElevation:=2.5;
  if FElevation>FMaxDistance then
    FElevation:=0;
end;

function TTVCamera.DoCalcDetectionProbability(const TacticU: IInterface;
  const OvercomeMethodE: IDMElement; 
  DelayTime: double; var DetP0, DetPf,
  WorkP: double; CalcAll:WordBool): double;
var
  DetP:double;
  OvercomeMethod:IOvercomeMethod;
begin
  DetP:=1;
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  if OvercomeMethod.ObserverParam then begin
    Result:=GetDistantDetection(OvercomeMethodE, DetP, DelayTime);
    DetP0:=Result;
    DetPf:=0;
    WorkP:=1;
  end else
    Result:=inherited DoCalcDetectionProbability(TacticU, OvercomeMethodE,
                         DelayTime, DetP0, DetPf, WorkP, CalcAll);
end;

function TTVCamera.Get_VideoRecord: integer;
begin
  Result:=FVideoRecord
end;

procedure TTVCamera.GetCoord(var X0, Y0, Z0: double);
var
  Area:IArea;
  C0, C1:ICoordNode;
  BoundaryLayer:IBoundaryLayer;
begin
  X0:=-InfinitValue;
  Y0:=-InfinitValue;
  Z0:=-InfinitValue;
  if SpatialElement=nil then begin
    if Parent=nil then Exit;
    case Parent.ClassID of
    _BoundaryLayer:
      begin
        if Parent.Parent=nil then Exit;
        Area:=Parent.Parent.SpatialElement as IArea;
        if Area=nil then Exit;
        if Area.IsVertical then begin
          C0:=Area.C0;
          C1:=Area.C1;
          BoundaryLayer:=Parent as IBoundaryLayer;
          if Get_ImageRotated then begin
            X0:=BoundaryLayer.X1+Get_SymbolDX;
            Y0:=BoundaryLayer.Y1+Get_SymbolDY;
          end else begin
            X0:=BoundaryLayer.X0+Get_SymbolDX;
            Y0:=BoundaryLayer.Y0+Get_SymbolDY;
          end;
          Z0:=C0.Z;
        end;
      end;
    else
      inherited;
    end;
  end else
    inherited
end;

function TTVCamera.Get_Width: Double;
begin
  Result:=1; // Для того, чтобы не отрисовывался слой рубежа, на котором стоит камера
end;


function TTVCamera.GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double;
var
  SafeguardDatabase:ISafeguardDatabase;
  OvercomeMethod:IOvercomeMethod;
  T0, T:double;
  Line:ILine;
  C0, C1:ICoordNode;
  X0, Y0, Z0, X1, Y1, Z1:double;
  F0, F1, FA:boolean;
  XS1, YS1, XS2, YS2, L, R:double;
  F:integer;
  FacilityModelS:IFMState;
  WarriorGroupE, LineE, C0Ref, C1Ref, C0E, C1E:IDMElement;
begin
  Result:=0;

  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;
  OvercomeMethod:=OvercomeMethodU as IOvercomeMethod;
  FCurrOvercomeMethod:=pointer(OvercomeMethod as IDMElement);

  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  LineE:=FacilityModelS.CurrentLineU as IDMElement;

  T:=aTime;

  if (LineE<>nil) and
     (SpatialElement<>nil) then begin
    Line:=LineE as ILine;
    C0:=Line.C0;
    C1:=Line.C1;
    X0:=C0.X;
    Y0:=C0.Y;
    Z0:=C0.Z;
    X1:=C1.X;
    Y1:=C1.Y;
    Z1:=C1.Z;
    L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));

    C0E:=C0 as IDMElement;
    C1E:=C1 as IDMElement;
    C0Ref:=C0E.Ref;
    C1Ref:=C1E.Ref;
    F0:=PointInDetectionZone(X0, Y0, Z0, C0Ref, nil);
    F1:=PointInDetectionZone(X1, Y1, Z1, C1Ref, nil);
    if FIsSlewing then
      FA:=FSlewAngle<180
    else
      FA:=True;

    if FA then begin
      if F0 and F1 then
        T:=aTime
      else begin
        CalcIntersection(X0, Y0, X1, Y1, XS1, YS1, XS2, YS2, F);
        if F=3 then Exit;   // нет пересечений
        if (not F0) and (not F1) then begin
          if F=0 then begin
            if (XS1-X0)*(XS1-X1)<0 then begin
              R:=sqrt(sqr(XS2-XS1)+sqr(YS2-YS1))/L;
              if R<1 then begin
                T:=aTime*R;
              end;
            end else
              Exit;
          end else
            Exit;
        end else
        if F=1 then begin
          if F0 then begin// and not F1
            R:=sqrt(sqr(XS2-X0)+sqr(YS2-Y0))/L;
            if R<1 then begin
              T:=aTime*R;
            end;
          end else begin// F1 and not F0
            R:=sqrt(sqr(XS2-X1)+sqr(YS2-Y1))/L;
            if R<1 then begin
              T:=aTime*R;
            end;
          end;
        end else begin  // F=2
          if F0 then begin// and not F1
            R:=sqrt(sqr(XS1-X0)+sqr(YS1-Y0))/L;
            if R<1 then begin
              T:=aTime*R;
            end;
          end else begin// F1 and not F0
            R:=sqrt(sqr(XS1-X1)+sqr(YS1-Y1))/L;
            if R<1 then begin
              T:=aTime*R;
            end;
          end;
        end;
      end;
    end else begin
      if (not F0) and (not F1) then
        Exit
      else begin
        CalcIntersection(X0, Y0, X1, Y1, XS1, YS1, XS2, YS2, F);
        if F0 and F1 then begin
          if F=0 then begin
            if (XS1-X0)*(XS1-X1)<0 then begin
              R:=sqrt(sqr(XS2-XS1)+sqr(YS2-YS1))/L;
              if R<1 then begin
                T:=T*(1-R);
              end;
            end else
             T:=aTime
          end else
            T:=aTime
        end else
        if F=1 then begin
          if F0 then begin// and not F1
            R:=sqrt(sqr(XS2-X0)+sqr(YS2-Y0))/L;
            if R<1 then begin
              T:=aTime*R;
            end;
          end else begin// F1 and not F0
            R:=sqrt(sqr(XS2-X1)+sqr(YS2-Y1))/L;
            if R<1 then begin
              T:=aTime*R;
            end;
          end;
        end else begin  // F=2
          if F0 then begin// and not F1
            R:=sqrt(sqr(XS1-X0)+sqr(YS1-Y0))/L;
            if R<1 then begin
              T:=aTime*R;
            end;
          end else begin// F1 and not F0
            R:=sqrt(sqr(XS1-X1)+sqr(YS1-Y1))/L;
            if R<1 then begin
              T:=aTime*R;
            end;
          end;
        end;
      end;
    end;
  end;

  T0:=GetObservationPeriod(0);

  if T0<>0 then
    Result:=1-exp(-T/T0)
  else
    Result:=1
end;

function TTVCamera.GetObservationPeriod(Distance:double): double;
var
  SafeguardDatabase:ISafeguardDatabase;
  OvercomeMethod:IOvercomeMethod;
  T1, T0:double;
  Line, theLine:ILine;
  C0, C1, C:ICoordNode;
  XX, YY, ZZ, X, Y, Z, X0, Y0, Z0, X1, Y1, Z1, D:double;
  F0, F1, FA:boolean;
  XS1, YS1, XS2, YS2, L, R:double;
  F:integer;
  FacilityModelS:IFMState;
  WarriorGroupE, LineE, C0Ref, C1Ref, C0E, C1E:IDMElement;
begin
  Result:=0;

  SafeguardDatabase:=(DataModel as IDMElement).Ref as ISafeguardDatabase;

  OvercomeMethod:=(Ref as IObserverKind).ObservationMethod;

  FCurrOvercomeMethod:=pointer(OvercomeMethod as IDMElement);

  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;
  LineE:=FacilityModelS.CurrentLineU as IDMElement;

  T1:=OvercomeMethod.GetValueFromMatrix(WarriorGroupE, Self as IDMElement,
                                         LineE, -1, mvkProbability, nil);

  if Distance>0 then
    D:=Distance
  else begin
    if (LineE<>nil) and
       (SpatialElement<>nil) then begin
      Line:=LineE as ILine;
      C0:=Line.C0;
      C1:=Line.C1;
      X0:=C0.X;
      Y0:=C0.Y;
      Z0:=C0.Z;
      X1:=C1.X;
      Y1:=C1.Y;
      Z1:=C1.Z;
      XX:=0.5*(X0+X1);
      YY:=0.5*(Y0+Y1);
      ZZ:=0.5*(Z0+Z1);
      L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0));

      C0E:=C0 as IDMElement;
      C1E:=C1 as IDMElement;
      C0Ref:=C0E.Ref;
      C1Ref:=C1E.Ref;
      F0:=PointInDetectionZone(X0, Y0, Z0, C0Ref, nil);
      if (X0=X1) and (Y0=Y1) then
        F1:=F0
      else
        F1:=PointInDetectionZone(X1, Y1, Z1, C1Ref, nil);
      if FIsSlewing then
        FA:=FSlewAngle<180
      else
        FA:=True;

      if FA then begin
        if (not F0) or (not F1) then begin
          if  (X0=X1) and (Y0=Y1) then begin
            XX:=X0;
            YY:=Y0;
          end else begin
            CalcIntersection(X0, Y0, X1, Y1, XS1, YS1, XS2, YS2, F);
            if F=3 then Exit;   // нет пересечений
            if (not F0) and (not F1) then begin
              if F=0 then begin
                if (XS1-X0)*(XS1-X1)<0 then begin
                  R:=sqrt(sqr(XS2-XS1)+sqr(YS2-YS1))/L;
                  if R<1 then begin
                    XX:=0.5*(XS2+XS1);
                    YY:=0.5*(YS2+YS1);
                  end;
                end else
                  Exit;
              end else
                Exit;
            end else
            if F=1 then begin
              if F0 then begin// and not F1
                R:=sqrt(sqr(XS2-X0)+sqr(YS2-Y0))/L;
                if R<1 then begin
                  XX:=0.5*(XS2+X0);
                  YY:=0.5*(YS2+Y0);
                end;
              end else begin// F1 and not F0
                R:=sqrt(sqr(XS2-X1)+sqr(YS2-Y1))/L;
                if R<1 then begin
                  XX:=0.5*(XS2+X1);
                  YY:=0.5*(YS2+Y1);
                end;
              end;
            end else begin  // F=2
              if F0 then begin// and not F1
                R:=sqrt(sqr(XS1-X0)+sqr(YS1-Y0))/L;
                if R<1 then begin
                  XX:=0.5*(XS1+X0);
                  YY:=0.5*(YS1+Y0);
                end;
              end else begin// F1 and not F0
                R:=sqrt(sqr(XS1-X1)+sqr(YS1-Y1))/L;
                if R<1 then begin
                  XX:=0.5*(XS1+X1);
                  YY:=0.5*(YS1+Y1);
                end;
              end;
            end;
          end;
        end;
      end else begin
        if (not F0) and (not F1) then
          Exit
        else begin
          CalcIntersection(X0, Y0, X1, Y1, XS1, YS1, XS2, YS2, F);
          if F0 and F1 then begin
            if F=0 then begin
              if (XS1-X0)*(XS1-X1)<0 then begin
                R:=sqrt(sqr(XS2-XS1)+sqr(YS2-YS1))/L;
                if R<1 then begin
                  XX:=XS1;
                  YY:=YS1;
                end;
              end
            end
          end else
          if F=1 then begin
            if F0 then begin// and not F1
              R:=sqrt(sqr(XS2-X0)+sqr(YS2-Y0))/L;
              if R<1 then begin
                XX:=0.5*(XS2+X0);
                YY:=0.5*(YS2+Y0);
              end;
            end else begin// F1 and not F0
              R:=sqrt(sqr(XS2-X1)+sqr(YS2-Y1))/L;
              if R<1 then begin
                XX:=0.5*(XS2+X1);
                YY:=0.5*(YS2+Y1);
              end;
            end;
          end else begin  // F=2
            if F0 then begin// and not F1
              R:=sqrt(sqr(XS1-X0)+sqr(YS1-Y0))/L;
              if R<1 then begin
                XX:=0.5*(XS1+X0);
                YY:=0.5*(YS1+Y0);
              end;
            end else begin// F1 and not F0
              R:=sqrt(sqr(XS1-X1)+sqr(YS1-Y1))/L;
              if R<1 then begin
                XX:=0.5*(XS1+X1);
                YY:=0.5*(YS1+Y1);
              end;  
            end;
          end;
        end;
      end;

      theLine:=SpatialElement as ILine;

      C:=theLine.C0;
      X:=C.X;
      Y:=C.Y;
      Z:=C.Z;
      D:=sqrt(sqr(XX-X)+sqr(YY-Y)+sqr(ZZ-Z));
    end else begin
      if (Parent<>nil) and
         (Parent.ClassID=_BoundaryLayer) then begin
        D:=500;  // 5 метров
      end else begin
        FacilityModelS.CurrentSafeguardElementU:=Self as IUnknown;
        D:=FacilityModelS.CurrentDistance*100;
      end;
    end;
  end; // if Distance<=0
  T0:=T1*D/100;

  if FIsSlewing  and
     (FSlewAngle<>0) and
     (FViewAngle<>0) then
    T0:=T0*FSlewAngle/FViewAngle;

  Result:=T0
end;

{ TTVCameras }

class function TTVCameras.GetElementClass: TDMElementClass;
begin
  Result:=TTVCamera;
end;

function TTVCameras.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsTVCamera;
end;

class function TTVCameras.GetElementGUID: TGUID;
begin
  Result:=IID_ITVCamera;
end;


initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TTVCamera.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
