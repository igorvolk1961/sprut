unit SubBoundaryU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB, SprutikLib_TLB,
  CustomBoundaryU;

type
  TSubBoundary=class(TCustomBoundary, ISubBoundary)
  private
  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;
    class procedure MakeFields0; override;

    procedure Set_Parent(const Value:IDMElement); override;
    function  Get_MainParent: IDMElement; override; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;

    procedure CalcParams1(AddDelay, ObservationPeriod:double;
                      out dTFast, dTDispFast, NoDetPFast, NoDetP1Fast,
                          NoFailurePFast:double;
                      out NoEvidenceFast:WordBool;
                      out SingleDetFast:double;
                      out dTStealth, dTDispStealth, NoDetPStealth, NoDetP1Stealth,
                          NoFailurePStealth:double;
                      out NoEvidenceStealth:WordBool;
                      out SingleDetStealth:double;
                      out PositionFast, PositionStealth:integer); safecall;
  end;

  TSubBoundaries=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;


implementation

uses
  FacilityModelConstU;

{ TSubBoundary }

procedure TSubBoundary._Destroy;
begin
  inherited;
end;

procedure TSubBoundary.Initialize;
begin
  inherited;
end;

class procedure TSubBoundary.MakeFields0;
begin
  inherited;
end;

function TSubBoundary.GetFieldValue(Code: integer): OleVariant;
begin
    Result:=inherited GetFieldValue(Code);
end;

procedure TSubBoundary.SetFieldValue(Code: integer; Value: OleVariant);
begin
    inherited
end;

function TSubBoundary.FieldIsVisible(Code: Integer): WordBool;
begin
    Result:=inherited FieldIsVisible(Code)
end;

class function TSubBoundary.GetClassID: integer;
begin
  Result:=_SubBoundary
end;

procedure TSubBoundary.Set_Parent(const Value: IDMElement);
var
  Boundary:IBoundary;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IBoundary,Boundary)=0)  then
    Set_Parent(Boundary.BoundaryLayers.Item[0])
  else
    inherited;
end;

function TSubBoundary.Get_MainParent: IDMElement;
var
  ParentParent:IDMElement;
  Boundary:IBoundary;
begin
  ParentParent:=Parent.Parent;
  Boundary:=ParentParent as IBoundary;
  if (DataModel=nil) or
      DataModel.IsLoading or
      DataModel.IsCopying or
      DataModel.InUndoRedo or
      DataModel.IsExecuting or
      (DataModel as IFacilityModel).ShowSingleLayer or
      (Boundary.BoundaryLayers.Count<>1) then
    Result:=Parent
  else
    Result:=ParentParent
end;

procedure TSubBoundary.CalcParams1(AddDelay, ObservationPeriod: double;
  out dTFast, dTDispFast, NoDetPFast, NoDetP1Fast, NoFailurePFast:double;
  out NoEvidenceFast:WordBool;
  out SingleDetFast:double;
  out dTStealth, dTDispStealth, NoDetPStealth,  NoDetP1Stealth, NoFailurePStealth:double;
  out NoEvidenceStealth:WordBool;
  out SingleDetStealth: double;
  out PositionFast, PositionStealth: integer);
var
  FacilityModelS:IFMState;
  theLineE:IDMElement;
  theLine:ILine;
  m:integer;
  DMDocument:IDMDocument;
  OldState:integer;
  BoundaryLayer:IBoundaryLayer;
  BoundaryLayerWE:IWayElement;

begin
  inherited;

  if Ref=nil then Exit;

  try

  if FBoundaryLayers.Count=0 then Exit;

  FacilityModelS:=DataModel as IFMState;

  theLine:=FacilityModelS.CurrentLineU as ILine;
  if theLine=nil then begin
    DMDocument:=DataModel.Document as IDMDocument;
    OldState:=DMDocument.State;
    DMDocument.State:=DMDocument.State or dmfCommiting;
    try
      theLineE:=MakeTemporyPath as IDMElement;
      FacilityModelS.CurrentLineU:=theLineE;
      theLine:=theLineE as ILine;
    finally
      DMDocument.State:=OldState;
    end;
  end;

  dTFast:=0;
  dTDispFast:=0;
  NoDetPFast:=1;
  NoDetP1Fast:=1;
  NoFailurePFast:=1;
  NoEvidenceFast:=True;
  SingleDetFast:=0;

  dTStealth:=0;
  dTDispStealth:=0;
  NoDetPStealth:=1;
  NoDetP1Stealth:=1;
  NoFailurePStealth:=1;
  NoEvidenceStealth:=True;
  SingleDetStealth:=0;

  for m:=0 to FBoundaryLayers.Count-1 do begin
    BoundaryLayer:=FBoundaryLayers.Item[m] as IBoundaryLayer;
    BoundaryLayerWE:=BoundaryLayer as IWayElement;

    BoundaryLayer.CalcParams(AddDelay);
    dTFast:=BoundaryLayerWE.DelayTimeFast;
    dTDispFast:=0;
    NoDetPFast:=1-BoundaryLayerWE.DetectionProbabilityFast;
    NoDetP1Fast:=1-BoundaryLayerWE.DetectionProbabilityFast;
    NoFailurePFast:=1-BoundaryLayerWE.FailureProbabilityFast;
    NoEvidenceFast:=True;
    SingleDetFast:=BoundaryLayerWE.SingleDetectionProbabilityFast;

    dTStealth:=BoundaryLayerWE.DelayTimeStealth;
    dTDispStealth:=0;
    NoDetPStealth:=1-BoundaryLayerWE.DetectionProbabilityStealth;
    NoDetP1Stealth:=1-BoundaryLayerWE.DetectionProbabilityStealth;
    NoFailurePStealth:=1-BoundaryLayerWE.FailureProbabilityStealth;
    NoEvidenceStealth:=True;
    SingleDetStealth:=BoundaryLayerWE.SingleDetectionProbabilityStealth;
  end;

  except
    DataModel.HandleError('Error in TSubBoundary.CalcParams. BoundaryID='+IntToStr(Parent.ID));
  end
end;

{ TSubBoundaries }

class function TSubBoundaries.GetElementClass: TDMElementClass;
begin
  Result:=TSubBoundary;
end;

function TSubBoundaries.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsSubBoundary
  else
    Result:=rsSubBoundaries;
end;

class function TSubBoundaries.GetElementGUID: TGUID;
begin
  Result:=IID_ISubBoundary;
end;

end.
