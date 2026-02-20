unit VolumeSensorU;

interface
uses
  DM_Windows,
  Classes, SysUtils, Math,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DistantDetectionElementU;

type
  TCalcFalseAlarmPeriod = procedure (SafeguardElement: IDMElement;
            var FalseAlarmPeriod: double);

type
  TVolumeSensor=class(TDistantDetectionElement, IVolumeSensor, ISensor)
  private
    FUserDefinedFalseAlarmPeriod:boolean;
    FFalseAlarmPeriod:double;
    FDisableFalseAlarm:boolean;
    function CalcStandardFalseAlarmPeriod:double;
    function CalcVolumeDetectionFlag:integer;
  protected
    function  GetFieldValue(Index: integer): OleVariant; override;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function  Get_UserDefineded: WordBool; override; safecall;
    procedure Set_Ref(const Value: IDMElement); override; safecall;
    procedure AfterLoading2; override; safecall;

    class function  GetClassID:integer; override;
    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
    function  GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double; override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
    function PointInDetectionZone(X, Y, Z:double; const CRef, ExcludeAreaE:IDMElement):WordBool; override; safecall;
    function Get_FalseAlarmPeriod: double; safecall;
    procedure Set_FalseAlarmPeriod(const Value: double);
    function Get_UserDefinedFalseAlarmPeriod: WordBool; safecall;
    procedure CalcFalseAlarmPeriod; safecall;

    function GetObservationKind(Distance:double):integer; override;
    procedure _Destroy; override;
  end;

  TVolumeSensors=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  CalcDetectionProbabilityLib;

var
  FFields:IDMCollection;
  Flag:boolean;
{ TVolumeSensor }


procedure TVolumeSensor.Draw(const aPainter: IUnknown; DrawSelected: integer);
var
  Image:IElementImage;
  LocalView:IView;
  Width, Length, Height:double;
  VolumeSensorKind:IVolumeSensorKind;
  Painter:IPainter;
  aLine:ILine;
  C0, C1:ICoordNode;
  L, Z:double;
  F:integer;
  Document:IDMDocument;
  OldState:integer;
  SpatialModel:ISpatialModel;
  X0, Y0, X1, Y1, Z1:double;
begin
  if Ref=nil then Exit;
  if Parent=nil then Exit;

  VolumeSensorKind:=Ref as IVolumeSensorKind;
  Image:=VolumeSensorKind.DetectionZoneImage;
  if (Image=nil) or
    not (DataModel as IVulnerabilityMap).ShowDetectionZones  or
    not FShowDetectionZone then begin
    try
    inherited;
    except
    raise
    end;
    Exit;
  end;

  if SpatialElement=nil then begin
    inherited;
    Exit;
  end;

  if not (SpatialElement.Parent as ILayer).Visible then Exit;
  aLine:=Get_SpatialElement as ILine;
  C0:=aLine.C0;
  C1:=aLine.C1;
  Z:=C0.Z+Get_Elevation;
  X0:=C0.X;
  Y0:=C0.Y;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Z;

  L:=sqrt(sqr(X1-X0)+sqr(Y1-Y0)+sqr(Z1-Z));

  Length:=VolumeSensorKind.DetectionZoneLength*100;
  if Length<=0 then Exit;
  Width:=VolumeSensorKind.DetectionZoneWidth*100;
  if Width<=0 then Exit;
  Height:=VolumeSensorKind.DetectionZoneHeight*100;
  if Height<=0 then
    Height:=Width;
  F:=VolumeSensorKind.DetectionZoneForm;

  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfExecuting;
  try

  LocalView:=((DataModel as ISpatialModel2).Views as IDMCollection2).CreateElement(False) as IView;
  LocalView.CX:=0.5*(X0+X1);
  LocalView.CY:=0.5*(Y0+Y1);
  LocalView.CZ:=0.5*(Z+Z1);
  LocalView.ZAngle:=aLine.ZAngle;
  LocalView.TAngle:=90-arccos((Z1-Z)/L)/pi*180;
  LocalView.RevScaleX:=Image.XSize/L;
  case F of
  0, 4:begin
      LocalView.RevScaleY:=Image.YSize/L*Length/Width*3/4;
      LocalView.RevScaleZ:=Image.ZSize/L*Length/Height*3/4;
    end;
  1:begin
      LocalView.RevScaleY:=Image.YSize/L*Length/Width;
      LocalView.RevScaleZ:=Image.ZSize/L*Length/Height;
    end;
  end;

  Painter:=aPainter as IPainter;
  Painter.LocalViewU:=LocalView;

  SpatialModel:=DataModel as ISpatialModel;
  if Painter.UseLayers then
     Painter.LayerIndex:=SpatialModel.Layers.IndexOf(SpatialElement.Parent);

  (Image as IDMElement).Draw(aPainter, DrawSelected);

  Painter.LocalViewU:=nil;

  inherited;

  finally
    Document.State:=OldState;
  end;

end;

function TVolumeSensor.CalcVolumeDetectionFlag: integer;
var
  ZoneHalfLength, ZoneHalfWidth, ZoneHalfHeight, alfa, beta:double;
  W0X, W0Y, W0Z, W1X, W1Y, W1Z, X, Y, Z:double;
  C, C0, C1:ICoordNode;
  Stat, ZoneForm:integer;
  VolumeSensorKind:IVolumeSensorKind;
  Line, ArrayLine:ILine;
  C0X, C0Y, C0Z, C1X, C1Y, C1Z:double;
  F0, F1:boolean;
  C0E, C1E:IDMElement;
  WarriorGroup:IWarriorGroup;
  FacilityModelS:IFMState;
  LineE:IDMElement;
begin
  Result:=vdfFull;
  FacilityModelS:=DataModel as IFMState;
  Line:=FacilityModelS.CurrentLineU as ILine;
  if Line=nil then Exit;
  LineE:=Line as IDMElement;
  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;

  C0:=Line.C0;
  C1:=Line.C1;
  C0E:=C0 as IDMElement;
  C1E:=C1 as IDMElement;

  C0X:=C0.X;
  C0Y:=C0.Y;
  C0Z:=C0.Z;
  C1X:=C1.X;
  C1Y:=C1.Y;
  C1Z:=C1.Z;
  F0:=PointInDetectionZone(C0X, C0Y, C0Z, nil, nil);
  F1:=PointInDetectionZone(C1X, C1Y, C1Z, nil, nil);

(*
  T0:=((C0E.Ref<>nil) and
       (C0E.Ref=WarriorGroup.FinishPoint));
  T1:=((C1E.Ref<>nil) and
       (C1E.Ref=WarriorGroup.FinishPoint));

  if (LineE.Ref<>nil) and
      (LineE.Ref.ClassID=_Boundary) then begin
    if  (F0 or F1) then
      Result:=vdfSqrt
    else
      Result:=vdfNoDetection;
    Exit;
  end else
  if F0 and (not F1) then begin
    if T0 then
      Result:=vdfFull
    else
      Result:=vdfSqrt;
    Exit;
  end else
  if (not F0) and F1 then begin
    if T1 then
      Result:=vdfFull
    else
      Result:=vdfSqrt;
    Exit;
  end else
  if F0 and F1 then begin
    if T0 or T1 then
      Result:=vdfSqrt
    else
      Result:=vdfNoDetection;
    Exit;
  end;
*)
  if F0 or F1 then begin
    Result:=vdfFull;
    Exit;
  end;

  if SpatialElement=nil then begin
(*
    if T0 or T1 then
      Result:=vdfSqrt
    else
*)
    Result:=vdfNoDetection
  end else begin
    VolumeSensorKind:=Ref as IVolumeSensorKind;
    ZoneHalfLength:=VolumeSensorKind.DetectionZoneLength*50;  //a=L*100/2
    if ZoneHalfLength<=0 then
      DataModel.HandleError(Format
       ('ZoneHalfLength<=0 (%s)',[Name]));
    ZoneHalfWidth:=VolumeSensorKind.DetectionZoneWidth*50;
      if ZoneHalfWidth<=0 then
      if ZoneHalfLength<=0 then
        DataModel.HandleError(Format
           ('ZoneHalfWidth<=0 (%s)',[Name]));
    ZoneHalfHeight:=VolumeSensorKind.DetectionZoneHeight*50;
    if ZoneHalfHeight<=0 then
    if ZoneHalfLength<=0 then
      DataModel.HandleError(Format
           ('ZoneHalfHeight<=0 (%s)',[Name]));
    ZoneForm:=VolumeSensorKind.DetectionZoneForm;

    if SpatialElement.QueryInterface(ILine, ArrayLine)=0 then begin
      alfa:=ArrayLine.ZAngle;
      if alfa=-InfinitValue then Exit;
      X:=ArrayLine.C0.X;
      Y:=ArrayLine.C0.Y;
      Z:=ArrayLine.C0.Z+Get_Elevation;

      beta:=90-arccos((ArrayLine.C1.Z-Z)/ArrayLine.Length)/pi*180;
      C:=ArrayLine.C0;

      case ZoneForm  of
      0, 1: DetectEllips(ZoneForm,     // Эллипс (1), конус (2)
              X,  Y,  Z,
              ZoneHalfLength, ZoneHalfWidth, ZoneHalfHeight,
              alfa, beta,
              C0x, C0y, C0z,
              C1x, C1y, C1z,
              W0X, W0Y, W0Z,
              W1X, W1Y, W1Z, Stat);
      else
        Stat:=-1;
      end;

      if Stat=2 then
        Result:=vdfFull
      else
        Result:=vdfNoDetection;
    end else
    if SpatialElement.QueryInterface(ICoordNode, C)=0 then begin
      alfa:=0;
      beta:=90;

      X:=C.X;
      Y:=C.Y;
      Z:=C.Z+Get_Elevation;


      case ZoneForm  of
      4:begin                  // сфера
          Z:=C.Z+0.5*Get_Elevation;
        end;
      5:begin                  // полуэллипсоид
          Z:=C.Z+Get_Elevation;
        end;
      else
        ZoneForm:=-1;
      end;

      if ZoneForm<>-1 then
        DetectEllips(0,
              X,  Y,  Z,
              ZoneHalfLength, ZoneHalfWidth, ZoneHalfHeight,
              alfa, beta,
              C0x, C0y, C0z,
              C1x, C1y, C1z,
              W0X, W0Y, W0Z,
              W1X, W1Y, W1Z, Stat)
      else
        Stat:=-1;

      if Stat=2 then
        Result:=vdfFull
      else
        Result:=vdfNoDetection;
    end else
      Result:=vdfNoDetection
  end;  //if SpatialElement=nil
end;

class function TVolumeSensor.GetClassID: integer;
begin
  Result:=_VolumeSensor;
end;

procedure TVolumeSensor.Set_SpatialElement(const Value:IDMElement);
var
  VolumeSensorKind:IVolumeSensorKind;
  Line:ILine;
  L,Length, LengthXY, Height:double;
  C0, C1:ICoordNode;
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if Value=nil then Exit;
  VolumeSensorKind:=Ref as IVolumeSensorKind;
  if Value.QueryInterface(ILine, Line)=0 then begin
    L:=Line.Length;
    if L=0 then Exit;
    C0:=Line.C0;
    C1:=Line.C1;

    Length:=VolumeSensorKind.DetectionZoneLength*100;
    if Length<=0 then Exit;

    Height:=FElevation*100;
    LengthXY:=sqrt(sqr(Length)-sqr(Height));
    C1.X:=C0.X+(C1.X-C0.X)*LengthXY/L;
    C1.Y:=C0.Y+(C1.Y-C0.Y)*LengthXY/L;
  end;
end;

class function TVolumeSensor.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TVolumeSensor.MakeFields0;
begin
  inherited;
  AddField(rsUserDefinedFalseAlarmPeriod, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(spUserDefinedFalseAlarmPeriod), 0, pkUserDefined);
  AddField(rsFalseAlarmPeriod, '%9.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(spFalseAlarmPeriod), 0, pkUserDefined);
  AddField(rsDisableFalseAlarm, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(spDisableFalseAlarm), 0, pkInput);
end;

function TVolumeSensor.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(spUserDefinedFalseAlarmPeriod):
    Result:=FUserDefinedFalseAlarmPeriod;
  ord(spFalseAlarmPeriod):
    Result:=FFalseAlarmPeriod;
  ord(spDisableFalseAlarm):
    Result:=FDisableFalseAlarm;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TVolumeSensor.SetFieldValue(Index: integer; Value: OleVariant);
begin
  if Flag then Exit;
  Flag:=True;
  try
  case Index of
  ord(spUserDefinedFalseAlarmPeriod):
    begin
      FUserDefinedFalseAlarmPeriod:=Value;
      UpdateUserDefinedElements(Value);
    end;
  ord(spFalseAlarmPeriod):
    FFalseAlarmPeriod:=Value;
  ord(spDisableFalseAlarm):
    FDisableFalseAlarm:=Value;
  else
    inherited;
  end;
  finally
    Flag:=False;
  end;
end;

function TVolumeSensor.PointInDetectionZone(X, Y, Z: double; const CRef, ExcludeAreaE:IDMElement): WordBool;
var
  VolumeSensorKind:IVolumeSensorKind;
  A, B, C, X0, Y0, Z0, X1, Y1, Z1, XC, YC, ZC, L, W, H:double;
  DetectionZoneForm:integer;
  C0, C1:ICoordNode;
  cosA,  cosC, R, R0, R1, D:double;
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

  VolumeSensorKind:=Ref as IVolumeSensorKind;
  DetectionZoneForm:=VolumeSensorKind.DetectionZoneForm;
  L:=VolumeSensorKind.DetectionZoneLength*100;
  W:=VolumeSensorKind.DetectionZoneWidth*100;
  H:=VolumeSensorKind.DetectionZoneHeight*100;

  if SpatialElement.QueryInterface(ILine, Line)=0 then begin
    C0:=Line.C0;
    C1:=Line.C1;
    D:=Line.Length;
  end else begin
    C0:=SpatialElement as ICoordNode;
    C1:=nil;
    D:=0;
  end;
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z+Get_Elevation;

  case DetectionZoneForm of
  0, 4:begin         //  Эллипсоид, сфера
      if L>=W then begin
        A:=L/2;
        B:=W/2;
      end else begin
        A:=W/2;
        B:=L/2;
      end;

      Result:=False;
      if A=0 then Exit;

      C:=sqrt(sqr(A)-sqr(B));
      X1:=C1.X;
      Y1:=C1.Y;
      Z1:=C1.Z;
      XC:=0.5*(X0+X1);
      YC:=0.5*(Y0+Y1);
      ZC:=0.5*(Z0+Z1);
      X0:=XC+(X0-XC)*C/A;
      Y0:=YC+(Y0-YC)*C/A;
      Z0:=ZC+(Z0-ZC)*C/A;
      X1:=XC+(X1-XC)*C/A;
      Y1:=YC+(Y1-YC)*C/A;
      Z1:=ZC+(Z1-ZC)*C/A;
      R0:=sqrt(sqr(X0-X)+sqr(Y0-Y)+sqr(Z0-Z));
      R1:=sqrt(sqr(X1-X)+sqr(Y1-Y)+sqr(Z1-Z));
      Result:=(R0+R1<2*A);
    end;
  1:begin         //  Конус
      Result:=False;

      R:=sqrt(sqr(X0-X)+sqr(Y0-Y)+sqr(Z0-Z));
      if R>D then Exit;
      if R=0 then begin
        Result:=True;
        Exit;
      end;
      if D=0 then Exit;
      X1:=C1.X;
      Y1:=C1.Y;
      Z1:=C1.Z;
      cosA:=((X0-X)*(X0-X1)+(Y0-Y)*(Y0-Y1)+(Z0-Z)*(Z0-Z1))/(R*D);
      cosC:=sqrt(sqr(L)-sqr(W/2))/L;
      Result:=(cosA>cosC)
    end;
  2:begin         //  Параллелепипед
    end;
  3:begin         //  Цилиндр
    end;
//  4:begin         //  Сфера
//      R:=sqrt(sqr(X0-X)+sqr(Y0-Y)+sqr(Z0-Z));
//      Result:=(R<L)
//    end;
  5:begin         //  Полуэллипсоид
      if H>=W then begin
        A:=H;
        B:=W/2;
      end else begin
        A:=W/2;
        B:=H;
      end;

      Result:=False;
      if A=0 then Exit;

      C:=sqrt(sqr(A)-sqr(B));
//      XC:=X0;
//      YC:=Y0;
      ZC:=Z0-H;
      Z0:=ZC+(Z0-ZC)*C/A;
      Z1:=ZC-(Z0-ZC)*C/A;
      R0:=sqrt(sqr(X0-X)+sqr(Y0-Y)+sqr(Z0-Z));
      R1:=sqrt(sqr(X0-X)+sqr(Y0-Y)+sqr(Z1-Z));
      Result:=(R0+R1<2*A);
    end;
  else
    Result:=False
  end;

end;

function TVolumeSensor.GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double;
var
  Flag:integer;
begin
  Result:=0;

  Flag:=CalcVolumeDetectionFlag;
  if Flag=0 then Exit;

  case Flag of
  vdfFull:Result:=DetP;
  vdfSqrt:Result:=1-sqrt(1-DetP);
  else    Result:=0;
  end;
end;

procedure TVolumeSensor.CalcFalseAlarmPeriod;
var
  DoCalcFalseAlarmPeriod:TCalcFalseAlarmPeriod;
  ProcName:array[0..255] of Char;
  SensorType:IDetectionElementType;
begin
  if FUserDefinedFalseAlarmPeriod then  Exit;

  if Ref.Parent.QueryInterface(IDetectionElementType, SensorType)=0 then
  with SensorType do
    if CalcFalseAlarmPeriodHandle<>0 then begin
      StrPCopy(ProcName, CalcFalseAlarmPeriodProc);
     @DoCalcFalseAlarmPeriod:=DM_GetProcAddress(CalcFalseAlarmPeriodHandle,
                                   ProcName);
      if @DoCalcFalseAlarmPeriod<>nil then
        DoCalcFalseAlarmPeriod(Self, FFalseAlarmPeriod)
      else begin
        DataModel.HandleError('Ошибка в прцедуре TSensor.Get_FalseAlarmPeriod');
      end;
    end else
      FFalseAlarmPeriod:=CalcStandardFalseAlarmPeriod
  else
    FFalseAlarmPeriod:=InfinitValue
end;

function TVolumeSensor.Get_FalseAlarmPeriod: double;
begin
  Result:=FFalseAlarmPeriod
end;

procedure TVolumeSensor.Set_FalseAlarmPeriod(const Value: double);
begin
  FFalseAlarmPeriod:=Value
end;

function TVolumeSensor.Get_UserDefinedFalseAlarmPeriod: WordBool;
begin
  Result:=FUserDefinedFalseAlarmPeriod
end;

function TVolumeSensor.CalcStandardFalseAlarmPeriod: double;
var
  SensorKind:IDetectionElementKind;
begin
  SensorKind:=Ref as IDetectionElementKind;
  Result:=SensorKind.StandardFalseAlarmPeriod;
  if Result<=0 then
    Result:=InfinitValue
end;

function TVolumeSensor.Get_UserDefineded: WordBool;
begin
  Result:=(inherited Get_UserDefineded) or
    FUserDefinedFalseAlarmPeriod
end;

function TVolumeSensor.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(spUserDefinedFalseAlarmPeriod):
    Result:=True;
  ord(spFalseAlarmPeriod):
    Result:=Get_UserDefinedFalseAlarmPeriod;
  ord(spDisableFalseAlarm):
    Result:=False;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

procedure TVolumeSensor._Destroy;
begin
  inherited;
end;

procedure TVolumeSensor.Set_Ref(const Value: IDMElement);
var
  VolumeSensorKind:IVolumeSensorKind;
begin
  inherited;
  if Value=nil then Exit;
  VolumeSensorKind:=Value as IVolumeSensorKind;
  FMaxDistance:=VolumeSensorKind.DetectionZoneLength;
  FElevation:=VolumeSensorKind.DefaultElevation;
  if (FMaxDistance>0) and
     (FElevation>FMaxDistance) then
    FElevation:=0;
end;

procedure TVolumeSensor.AfterLoading2;
begin
  inherited;
end;

function TVolumeSensor.GetObservationKind(Distance: double): integer;
begin
  Result:=obsSensor
end;

{ TVolumeSensors }

class function TVolumeSensors.GetElementClass: TDMElementClass;
begin
  Result:=TVolumeSensor;
end;

function TVolumeSensors.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsVolumeSensor;
end;

class function TVolumeSensors.GetElementGUID: TGUID;
begin
  Result:=IID_IVolumeSensor;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TVolumeSensor.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
