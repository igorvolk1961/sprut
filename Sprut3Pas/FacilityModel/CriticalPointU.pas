unit CriticalPointU;

interface
uses
  Classes, SysUtils,
  DMElementU,
  DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type

  TCriticalPoint=class(TDMElement, ICriticalPoint)
  private
    FWarriorPath: IDMElement;

    FInterruptionProbability:double;
    FDetectionPotential:integer;
    FDelayTimeToTarget:double;
    FTimeRemainder: Double;

    FSelfIndex:integer;
  protected
    class function  GetClassID:integer; override;

    function GetFieldValue(Index: integer): OleVariant; override;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    procedure AddChild(const Value:IDMElement); override; safecall;
    procedure RemoveChild(const Value:IDMElement); override; safecall;
    procedure AfterLoading2; override; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    procedure Clear; override;
    procedure Set_Selected(Value: WordBool); override;
    function  Get_Selected: WordBool; override;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;

    procedure Set_WarriorPath(const Value:IDMElement); safecall;
    function  Get_WarriorPath: IDMElement; safecall;
    function  Get_DelayTimeToTarget: Double; safecall;
    procedure Set_DelayTimeToTarget(Value: Double); safecall;
    function  Get_InterruptionProbability: Double; safecall;
    procedure Set_InterruptionProbability(Value: Double); safecall;
    function  Get_TimeRemainder: Double; safecall;
    procedure Set_TimeRemainder(Value: Double); safecall;
    procedure MakeRecomendations(RecomendationKind:integer); safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TCriticalPoints=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;

    procedure Initialize; override;
  public
    destructor Destroy; override;
  end;

implementation
uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TCriticalPoint }


procedure TCriticalPoint.Draw(const aPainter: IInterface;
  DrawSelected: integer);
begin
  if Ref=nil then Exit;
  Ref.Draw(aPainter, DrawSelected);
end;

class function TCriticalPoint.GetClassID: integer;
begin
  Result:=_CriticalPoint
end;


function TCriticalPoint.Get_Selected: WordBool;
begin
  Result:=False;
  if Ref=nil then Exit;
  if Ref.SpatialElement=nil then Exit;
  Result:=Ref.SpatialElement.Selected;
end;

function TCriticalPoint.Get_WarriorPath: IDMElement;
begin
  Result:=FWarriorPath
end;

procedure TCriticalPoint.Set_WarriorPath(const Value: IDMElement);
begin
  FWarriorPath:=Value
end;

procedure TCriticalPoint.Set_Selected(Value: WordBool);
var
  Painter:IUnknown;
  Document:IDMDocument;
begin
  inherited;

  if Ref=nil then Exit;
  if Ref.SpatialElement=nil then Exit;
  Ref.SpatialElement.Selected:=Value;

  if DataModel=nil then Exit;
  Document:=DataModel.Document as IDMDocument;
  if Document=nil then Exit;

  if FWarriorPath=nil then Exit;

  Painter:=(Document as ISMDocument).PainterU;
  if Value then
    FWarriorPath.Draw(Painter, 1)
  else
    FWarriorPath.Draw(Painter, -1)
end;

destructor TCriticalPoint.Destroy;
begin
  inherited;
  FWarriorPath:=nil;
end;

function TCriticalPoint.Get_InterruptionProbability: Double;
begin
  Result:=FInterruptionProbability
end;

function TCriticalPoint.Get_DelayTimeToTarget: Double;
begin
  Result:=FDelayTimeToTarget
end;

procedure TCriticalPoint.Set_InterruptionProbability(
  Value: Double);
begin
  FInterruptionProbability:=Value
end;

procedure TCriticalPoint.Set_DelayTimeToTarget(Value: Double);
begin
  FDelayTimeToTarget:=Value
end;

function TCriticalPoint.Get_TimeRemainder: Double;
begin
  Result:=FTimeRemainder
end;

procedure TCriticalPoint.Set_TimeRemainder(Value: Double);
begin
  FTimeRemainder:=Value
end;

procedure TCriticalPoint.MakeRecomendations(RecomendationKind:integer);
var
  Recomendations2:IDMCollection2;
  WarriorPathElements:IDMCollection;
  VariantWeight:double;

  procedure DoMakeRecomendations(j0, j1:integer);
  var
    j:integer;
    RecomendationE:IDMElement;
    Recomendation:IFMRecomendation;
    WarriorPathElement, aElement:IDMElement;
    Unk:IUnknown;
    ZoneKind:IZoneKind;
    ZoneList:TList;

    procedure AddRecomendation;
    begin
          aElement:=WarriorPathElement.Ref;
          ZoneKind:=nil;
          if aElement.QueryInterface(IBoundary, Unk)=0 then begin
            if aElement.Ref.Parent.ID=btVirtual then
              aElement:=nil
          end else
          if aElement.QueryInterface(IZone, Unk)=0 then begin
            ZoneKind:=aElement.Ref as IZoneKind;
            if ZoneKind=nil then
              aElement:=nil
            else
            if not ((ZoneKind.PedestrialMovementVelocity<>0) or
                    ZoneKind.AirMovementEnabled or
                    ZoneKind.WaterMovementEnabled or
                    ZoneKind.UnderWaterMovementEnabled) then
              aElement:=nil;
            if ZoneList.IndexOf(pointer(aElement))<>-1 then
              aElement:=nil;
          end;
          if aElement<>nil then begin
              RecomendationE:=Recomendations2.CreateElement(False);
              Recomendations2.Add(RecomendationE);
              RecomendationE.Ref:=aElement;
              Recomendation:=RecomendationE as IFMRecomendation;
              Recomendation.Kind:=RecomendationKind;
              Recomendation.Priority:=Recomendation.Priority+VariantWeight;
              if ZoneKind<>nil then
                ZoneList.Add(pointer(aElement));
          end;
    end;
  var
    FacilityElementE:IDMElement;
  begin
      ZoneList:=TList.Create;
      for j:=j0 to j1 do begin
        WarriorPathElement:=WarriorPathElements.Item[j];
        FacilityElementE:=WarriorPathElement.Ref;
        RecomendationE:=Recomendations2.GetItemByRef(FacilityElementE);
        if RecomendationE<>nil then begin
          Recomendation:=RecomendationE as IFMRecomendation;
          if Recomendation.Kind<>RecomendationKind then
            Recomendation.Kind:=rcTimeAndProbability;
          Recomendation.Priority:=Recomendation.Priority+VariantWeight;
        end else
          AddRecomendation;
      end;
      ZoneList.Free;
  end;
var
  FacilityModel:IFacilityModel;
  AnalysisVariant:IAnalysisVariant;
  j:integer;
  WarriorPathElement:IDMElement;
begin
  FacilityModel:=DataModel as IFacilityModel;
  Recomendations2:=FacilityModel.FMRecomendations as IDMCollection2;
  AnalysisVariant:=Parent as IAnalysisVariant;
  VariantWeight:=AnalysisVariant.VariantWeight;
  if VariantWeight=0 then Exit;
  WarriorPathElements:=(FWarriorPath.SpatialElement as IPolyline).Lines;
  j:=0;
  while j<WarriorPathElements.Count do begin
    WarriorPathElement:=WarriorPathElements.Item[j];
    if WarriorPathElement.Ref=Ref then
      Break
    else
      inc(j)
  end;

  if j=WarriorPathElements.Count then Exit;

  FSelfIndex:=j;

  try

  case RecomendationKind of
  rcDetectionProbability:
    DoMakeRecomendations(0, FSelfIndex);
  rcDelayTime:
    DoMakeRecomendations(FSelfIndex, WarriorPathElements.Count-1);
  end;
  except
    raise
  end;
end;

procedure TCriticalPoint.Initialize;
begin
  inherited;

end;

class function TCriticalPoint.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TCriticalPoint.MakeFields0;
begin
  inherited;

  AddField(rsCPInterruptionProbability, '%0.4f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cppInterruptionProbability), 1, pkOutput);
  AddField(rsCPDelayTimeToTarget, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cppDelayTimeToTarget), 1, pkOutput);
  AddField(rsCPTimeRemainder, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cppTimeRemainder), 1, pkOutput);

end;

function TCriticalPoint.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(cppInterruptionProbability):
    Result:=FInterruptionProbability;
  ord(cppDetectionPotential):
    Result:=FDetectionPotential;
  ord(cppDelayTimeToTarget):
    Result:=FDelayTimeToTarget;
  ord(cppTimeRemainder):
    Result:=FTimeRemainder;
  else
    Result:=inherited GetFieldValue(Index)
  end;
end;

procedure TCriticalPoint.SetFieldValue(Index: integer; Value: OleVariant);
begin
  case Index of
  ord(cppInterruptionProbability):
    FInterruptionProbability:=Value;
  ord(cppDetectionPotential):
    FDetectionPotential:=Value;
  ord(cppDelayTimeToTarget):
    FDelayTimeToTarget:=Value;
  ord(cppTimeRemainder):
    FTimeRemainder:=Value;
  else
    inherited
  end;
end;

function TCriticalPoint.Get_Collection(Index: Integer): IDMCollection;
begin
  if FWarriorPath<>nil then
    Result:=(FWarriorPath as IWarriorPath).WarriorPathElements
  else
    Result:=nil
end;

function TCriticalPoint.Get_CollectionCount: integer;
begin
  if FWarriorPath<>nil then
    Result:=1
  else
    Result:=0
end;

procedure TCriticalPoint.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
   aCollectionName:=rsWarriorPathLines;
   aRefSource:=nil;
   aClassCollections:=nil;
   aOperations:=leoDontCopy;
   aLinkType:=ltIndirect;
end;

procedure TCriticalPoint.Clear;
var
  WarriorPaths2:IDMCollection2;
begin
  if (FWarriorPath<>nil) and
     (DataModel<>nil) and
     (FWarriorPath<>nil) then begin
    FWarriorPath.Clear;
    WarriorPaths2:=(DataModel as FacilityModel).WarriorPaths as IDMCollection2;
    WarriorPaths2.Remove(FWarriorPath);
    FWarriorPath:=nil;
  end;
  inherited;
end;

procedure TCriticalPoint.AddChild(const Value: IDMElement);
begin
  if (Value<>nil) and
     (Value.ClassID=_WarriorPath) then
    FWarriorPath:=Value  
end;

procedure TCriticalPoint.RemoveChild(const Value: IDMElement);
begin
  if (Value<>nil) and
     (Value.ClassID=_WarriorPath) then
    FWarriorPath:=nil  
end;

procedure TCriticalPoint.AfterLoading2;
begin
  inherited;
end;

{ TCriticalPoints }

function TCriticalPoints.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsCriticalPoint
end;

class function TCriticalPoints.GetElementClass: TDMElementClass;
begin
  Result:=TCriticalPoint
end;

class function TCriticalPoints.GetElementGUID: TGUID;
begin
  Result:=IID_ICriticalPoint
end;

procedure TCriticalPoints.Initialize;
begin
  inherited;
end;

destructor TCriticalPoints.Destroy;
begin
  inherited;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TCriticalPoint.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
