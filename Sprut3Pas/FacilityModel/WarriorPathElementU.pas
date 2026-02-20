unit WarriorPathElementU;

interface
uses
  Classes, SysUtils, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  RefPathElementU;

type
  TWarriorPathElement=class(TRefPathElement, IWarriorPathElement)
  private
    FT: Double;
    FTDisp: Double;
    FP: Double;
    FR: Double;
    FB: Double;
    FP0: Double;
    FR0: Double;
    FB0: Double;
    FB1: Double;
    FdT: Double;
    FdTDisp: Double;
    FNoDetP: Double;
    FdR: Double;
    FdB: Double;
    FDelayTimeToTargetR: Double;
    FDelayTimeToTargetDispersionR: Double;
    FOutstripProbabilityR:double;
    FRejDetP: Double;
    FNoFailureP: Double;
    FNoEvidence: WordBool;

    FFacilityState:IDMElement;

  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class procedure MakeFields0; override;
    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;
    procedure Clear; override; safecall;

    procedure Set_Selected(Value: WordBool); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    procedure Reset; safecall;
  public
    function  Get_T: Double; safecall;
    procedure Set_T(Value: Double); safecall;
    function  Get_TDisp: Double; safecall;
    procedure Set_TDisp(Value: Double); safecall;
    function  Get_dTDisp: Double; safecall;
    procedure Set_dTDisp(Value: Double); safecall;
    function  Get_P: Double; safecall;
    procedure Set_P(Value: Double); safecall;
    function  Get_R: Double; safecall;
    procedure Set_R(Value: Double); safecall;
    function  Get_B: Double; safecall;
    procedure Set_B(Value: Double); safecall;

    function  Get_P0: Double; safecall;
    procedure Set_P0(Value: Double); safecall;
    function  Get_R0: Double; safecall;
    procedure Set_R0(Value: Double); safecall;
    function  Get_B0: Double; safecall;
    procedure Set_B0(Value: Double); safecall;
    function  Get_B1: Double; safecall;
    procedure Set_B1(Value: Double); safecall;

    function  Get_dT: Double; safecall;
    procedure Set_dT(Value: Double); safecall;
    function  Get_NoDetP: Double; safecall;
    procedure Set_NoDetP(Value: Double); safecall;
    function  Get_dR: Double; safecall;
    procedure Set_dR(Value: Double); safecall;
    function  Get_dB: Double; safecall;
    procedure Set_dB(Value: Double); safecall;
    function  Get_DelayTimeToTargetR: Double; safecall;
    procedure Set_DelayTimeToTargetR(Value: Double); safecall;
    function  Get_DelayTimeToTargetDispersionR: Double; safecall;
    procedure Set_DelayTimeToTargetDispersionR(Value: Double); safecall;
    function Get_OutstripProbabilityR:double; safecall;
    procedure Set_OutstripProbabilityR(Value: double); safecall;
    function  Get_RejDetP: Double; safecall;
    procedure Set_RejDetP(Value: Double); safecall;
    function  Get_NoFailureP: Double; safecall;
    procedure Set_NoFailureP(Value: Double); safecall;
    function  Get_NoEvidence: WordBool; safecall;
    procedure Set_NoEvidence(Value: WordBool); safecall;
    function  Get_FacilityState:IDMElement; safecall;
    procedure Set_FacilityState(const Value:IDMElement); safecall;

    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TWarriorPathElements=class(TDMCollection)
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

{ TWarriorPathElement }

procedure TWarriorPathElement.Initialize;
begin
  inherited;
end;

class function TWarriorPathElement.GetClassID: integer;
begin
  Result:=_WarriorPathElement;
end;

class function TWarriorPathElement.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TWarriorPathElement.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsdT, '%0.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpedT)+100, 1, pkOutput);
  AddField(rsNoDetP, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeNoDetP)+100, 1, pkOutput);
  AddField(rsT, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeT)+100, 1, pkOutput);
  AddField(rsP, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeP)+100, 1, pkOutput);
  AddField(rsR, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeR)+100, 1, pkOutput);
  AddField(rsOutsripProbabilityR, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeOutsripProbabilityR)+100, 1, pkOutput);
  AddField(rsRejDetP, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeRejDetP)+100, 1, pkOutput);
  AddField(rsNoFailureP, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeNoFailureP)+100, 1, pkOutput);
  AddField(rsNoEvidence, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(wpeNoEvidence)+100, 1, pkOutput);

  S:='|'+rsVBoundary_+
     '|'+rsVBoundary+
     '|'+rsHZone+
     '|'+rsHLineObject+
     '|'+rsHBoundary+
     '|'+rsVZone+
     '|'+rsVLineObject+
     '|'+rsChangeFacilityState+
     '|'+rsChangeWarriorGroup+
     '|'+rsRoad+
     '|'+rsTarget;
  AddField(rsPathArcKind, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(wpePathArcKind)+100, 1, pkOutput);
end;

function TWarriorPathElement.GetFieldValue(Code: integer): OleVariant;
begin
  case Code-100 of
  ord(wpedT):
    Result:=FdT;
  ord(wpeNoDetP):
    Result:=FNoDetP;
  ord(wpeT):
    Result:=FT;
  ord(wpeP):
    Result:=FP;
  ord(wpeR):
    Result:=FR;
  ord(wpeB):
    Result:=FB;
  ord(wpeB0):
    Result:=FB0;
  ord(wpeB1):
    Result:=FB1;
  ord(wpeRejDetP):
    Result:=FRejDetP;
  ord(wpeNoFailureP):
    Result:=FNoFailureP;
  ord(wpeNoEvidence):
    Result:=FNoEvidence;
  ord(wpeOutsripProbabilityR):
    Result:=FOutstripProbabilityR;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TWarriorPathElement.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code-100 of
  ord(wpedT):
    FdT:=Value;
  ord(wpeNoDetP):
    FNoDetP:=Value;
  ord(wpeT):
    FT:=Value;
  ord(wpeP):
    FP:=Value;
  ord(wpeR):
    FR:=Value;
  ord(wpeB):
    FB:=Value;
  ord(wpeB0):
    FB0:=Value;
  ord(wpeB1):
    FB1:=Value;
  ord(wpeRejDetP):
    FRejDetP:=Value;
  ord(wpeNoFailureP):
    FNoFailureP:=Value;
  ord(wpeNoEvidence):
    FNoEvidence:=Value;
  ord(wpeOutsripProbabilityR):
    FOutstripProbabilityR:=Value;
  else
    inherited;
  end;
end;

function TWarriorPathElement.Get_DelayTimeToTargetR: Double;
begin
  Result:=FDelayTimeToTargetR
end;

function TWarriorPathElement.Get_DelayTimeToTargetDispersionR: Double;
begin
  Result:=FDelayTimeToTargetDispersionR
end;

function TWarriorPathElement.Get_dT: Double;
begin
  Result:=FdT
end;

function TWarriorPathElement.Get_NoDetP: Double;
begin
  Result:=FNoDetP
end;

function TWarriorPathElement.Get_NoEvidence: WordBool;
begin
  Result:=FNoEvidence
end;

function TWarriorPathElement.Get_NoFailureP: Double;
begin
  Result:=FNoFailureP
end;

function TWarriorPathElement.Get_P: Double;
begin
  Result:=FP
end;

function TWarriorPathElement.Get_RejDetP: Double;
begin
  Result:=FRejDetP
end;

function TWarriorPathElement.Get_T: Double;
begin
  Result:=FT
end;

procedure TWarriorPathElement.Set_DelayTimeToTargetR(Value: Double);
begin
  FDelayTimeToTargetR:=Value
end;

procedure TWarriorPathElement.Set_DelayTimeToTargetDispersionR(
  Value: Double);
begin
  FDelayTimeToTargetDispersionR:=Value
end;

procedure TWarriorPathElement.Set_dT(Value: Double);
begin
  FdT:=Value
end;

procedure TWarriorPathElement.Set_NoDetP(Value: Double);
begin
  FNoDetP:=Value
end;

procedure TWarriorPathElement.Set_NoEvidence(Value: WordBool);
begin
  FNoEvidence:=Value
end;

procedure TWarriorPathElement.Set_NoFailureP(Value: Double);
begin
  FNoFailureP:=Value
end;

procedure TWarriorPathElement.Set_P(Value: Double);
begin
  FP:=Value
end;

procedure TWarriorPathElement.Set_RejDetP(Value: Double);
begin
  FRejDetP:=Value
end;

procedure TWarriorPathElement.Set_T(Value: Double);
begin
  FT:=Value
end;

procedure TWarriorPathElement.Set_Selected(Value: WordBool);
var
  SMDocument:ISMDocument;
  Painter:IUnknown;
begin
  inherited;
  if DataModel=nil then Exit;
  SMDocument:=DataModel.Document as ISMDocument;
  Painter:=SMDocument.PainterU;
  if Painter=nil then Exit;

  if Value then
    Draw(Painter, 1)
  else
  if Ref<>nil then begin
    if Ref.ClassID<>_Zone then
      Ref.Draw(Painter, 0);
    Draw(Painter, 0)
  end
end;

function TWarriorPathElement.FieldIsVisible(Code: integer): WordBool;
begin
  if Code-100>=ord(wpedT) then
    Result:=True
  else
    Result:=False
end;

procedure TWarriorPathElement.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  Painter:IPainter;
  OldColor:integer;
begin
  inherited;
  if Ref=nil then Exit;
  try
  Painter:=aPainter as IPainter;
  if (Ref.ClassID<>_Zone) and
      Selected then
    Ref.Draw(Painter, DrawSelected)
  else begin
    OldColor:=Painter.PenColor;
    if (DrawSelected=1) or Selected then
      Painter.PenColor:=clLime
    else
    if DrawSelected=0 then begin
      if (FPathStage and psfFast)=0 then
        Painter.PenColor:=$00F800
      else
        Painter.PenColor:=$0000F8;
//      if (FPathStage  and psfBack)=0 then
//        Painter.PenColor:=Painter.PenColor+$F80000;
    end
    else if DrawSelected=-1 then
      Painter.PenColor:=clWhite;

    Painter.DrawLine(FX0, FY0, FZ0, FX1, FY1, FZ1);
    Painter.PenColor:=OldColor;
  end
  except
    raise
  end;  
end;

function TWarriorPathElement.Get_dR: Double;
begin
  Result:=FdR
end;

function TWarriorPathElement.Get_OutstripProbabilityR: double;
begin
  Result:=FOutstripProbabilityR
end;

function TWarriorPathElement.Get_R: Double;
begin
  Result:=FR
end;

procedure TWarriorPathElement.Set_dR(Value: Double);
begin
  FdR:=Value
end;

procedure TWarriorPathElement.Set_OutstripProbabilityR(Value: double);
begin
  FOutstripProbabilityR:=Value
end;

procedure TWarriorPathElement.Set_R(Value: Double);
begin
  FR:=Value
end;

function TWarriorPathElement.Get_FacilityState: IDMElement;
begin
  Result:=FFacilityState
end;

procedure TWarriorPathElement.Set_FacilityState(const Value: IDMElement);
begin
  FFacilityState:=Value
end;

function TWarriorPathElement.Get_B: Double;
begin
  Result:=FB
end;

function TWarriorPathElement.Get_dB: Double;
begin
  Result:=FdB
end;

procedure TWarriorPathElement.Set_B(Value: Double);
begin
  FB:=Value
end;

procedure TWarriorPathElement.Set_dB(Value: Double);
begin
  FdB:=Value
end;

destructor TWarriorPathElement.Destroy;
begin
  FFacilityState:=nil;
  FGuardArrivals:=nil;
  inherited;
end;

function TWarriorPathElement.Get_P0: Double;
begin
  Result:=FP0
end;

function TWarriorPathElement.Get_R0: Double;
begin
  Result:=FR0
end;

procedure TWarriorPathElement.Set_P0(Value: Double);
begin
  FP0:=Value
end;

procedure TWarriorPathElement.Set_R0(Value: Double);
begin
  FR0:=Value
end;

function TWarriorPathElement.Get_B0: Double;
begin
  Result:=FB0
end;

function TWarriorPathElement.Get_B1: Double;
begin
  Result:=FB1
end;

procedure TWarriorPathElement.Set_B0(Value: Double);
begin
  FB0:=Value
end;

procedure TWarriorPathElement.Set_B1(Value: Double);
begin
  FB1:=Value
end;

procedure TWarriorPathElement.Reset;
begin
    FT:=0;
    FP:=0;
    FR:=1;
    FB:=1;
    FP0:=0;
    FR0:=0;
    FB0:=0;
    FB1:=0;
    FdT:=0;
    FNoDetP:=0;
    FdR:=0;
    FdB:=0;
    FDelayTimeToTargetR:=0;
    FDelayTimeToTargetDispersionR:=0;
    FOutstripProbabilityR:=0;
    FRejDetP:=0;
    FNoFailureP:=0;
    FNoEvidence:=False;
end;

function TWarriorPathElement.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FGuardArrivals
end;

function TWarriorPathElement.Get_CollectionCount: integer;
begin
  Result:=1
end;

procedure TWarriorPathElement.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;
  aOperations:=leoSelectRef;
end;

procedure TWarriorPathElement.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
  GuardGroupE:IDMElement;
begin
  aCollection2:=aCollection as IDMCollection2;
  SourceCollection:=(DataModel as IFacilityModel).GuardGroups;
  aCollection2.Clear;
  for j:=0 to SourceCollection.Count-1 do begin
    GuardGroupE:=SourceCollection.Item[j];
    aCollection2.Add(GuardGroupE);
  end;
end;

procedure TWarriorPathElement.Clear;
var
  GuardArrivals2:IDMCollection2;
  GuardArrivalE:IDMElement;
begin
  if DataModel<>nil then begin
    GuardArrivals2:=(DataModel as IDMElement).Collection[_GuardArrival] as IDMCollection2;
    while FGuardArrivals.Count>0 do begin
      GuardArrivalE:=FGuardArrivals.Item[FGuardArrivals.Count-1];
      GuardArrivalE.Clear;
      GuardArrivals2.Remove(GuardArrivalE);
    end;
  end;

  inherited;
end;

function TWarriorPathElement.Get_TDisp: Double;
begin
  Result:=FTDisp
end;

procedure TWarriorPathElement.Set_TDisp(Value: Double);
begin
  FTDisp:=Value
end;

function TWarriorPathElement.Get_dTDisp: Double;
begin
  Result:=FdTDisp
end;

procedure TWarriorPathElement.Set_dTDisp(Value: Double);
begin
  FdTDisp:=Value
end;

{ TWarriorPathElements }

class function TWarriorPathElements.GetElementClass: TDMElementClass;
begin
  Result:=TWarriorPathElement;
end;

function TWarriorPathElements.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsWarriorPathElement;
end;

class function TWarriorPathElements.GetElementGUID: TGUID;
begin
  Result:=IID_IWarriorPathElement;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TWarriorPathElement.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
