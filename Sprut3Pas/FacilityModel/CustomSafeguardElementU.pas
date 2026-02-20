unit CustomSafeguardElementU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TCustomSafeguardElement=class(TDMElement, IElementState, IImager)
  private
    FComment:string;
 protected
    FUserDefinedDelayTime:boolean;
    FDelayTime:double;
    FDelayTimeDispersion:double;
    FUserDefinedDetectionProbability:boolean;
    FDetectionProbability:double;
    FStates:IDMCollection;

    FShowSymbol:boolean;
    FSymbolScaleFactor:double;
    FImageRotated:boolean;
    FImageMirrored:boolean;

    procedure UpdateUserDefinedElements(Value:boolean); virtual;

    function  Get_UserDefineded: WordBool; override; safecall;
    function Get_Name:WideString; override; safecall;
    function Get_DelayTime: double; safecall;
    function Get_DelayTimeDispersion: double; safecall;
    function Get_DetectionProbability: double; safecall;
    function Get_UserDefinedDelayTime: WordBool; safecall;
    function Get_UserDefinedDetectionProbability: WordBool; safecall;
    procedure Set_UserDefinedDetectionProbability(Value:WordBool); safecall;
    procedure Set_DelayTime(Value: double); safecall;
    procedure Set_DelayTimeDispersion(Value: double); safecall;
    procedure Set_DetectionProbability(Value: double); safecall;
    function Get_States:IDMCollection;

    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;
    class procedure MakeFields0; override;
    class procedure MakeFields1; override;
    function GetCurrentState:IElementState;
    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure AfterCopyFrom2; override; safecall;

    procedure CalculateFieldValues; override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;

    function GetDeletedObjectsClassID: integer; override;

    function Get_ShowSymbol: WordBool; safecall;
    function Get_SymbolScaleFactor: double; safecall;
    function Get_ImageRotated:WordBool; safecall;
    function Get_ImageMirrored:WordBool; safecall;
    procedure CorrectDrawingDirection; virtual; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  public
  end;

implementation
uses
  FacilityModelConstU;

{ TCustomSafeguardElement }

function TCustomSafeguardElement.Get_Name: WideString;
var S:string;
begin
  S:=inherited Get_Name;
  Result:=S;
end;

procedure TCustomSafeguardElement.CalculateFieldValues;
begin
end;

function TCustomSafeguardElement.Get_DelayTime:double;
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.DelayTime
  else
    Result:=FDelayTime
end;

function TCustomSafeguardElement.Get_DetectionProbability: double;
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.DetectionProbability
  else
    Result:=FDetectionProbability
end;

function TCustomSafeguardElement.Get_UserDefinedDelayTime: WordBool;
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.UserDefinedDelayTime
  else
    Result:=FUserDefinedDelayTime
end;

function TCustomSafeguardElement.Get_UserDefinedDetectionProbability: WordBool;
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    Result:=State.UserDefinedDetectionProbability
  else
    Result:=FUserDefinedDetectionProbability
end;

procedure TCustomSafeguardElement.Set_DelayTime(Value: double);
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    State.DelayTime:=Value
  else
    FDelayTime:=Value
end;

procedure TCustomSafeguardElement.Set_DetectionProbability(
  Value: double);
var
  State:IElementState;
begin
  State:=GetCurrentState;
  if State<>nil then
    State.DetectionProbability:=Value
  else
    FDetectionProbability:=Value
end;

function TCustomSafeguardElement.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cnstComment):
    Result:=FComment;
  ord(cnstShowSymbol):
    Result:=FShowSymbol;
  ord(cnstSymbolScaleFactor):
    Result:=FSymbolScaleFactor;
  ord(cnstImageRotated):
    Result:=FImageRotated;
  ord(cnstImageMirrored):
    Result:=FImageMirrored;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TCustomSafeguardElement.UpdateUserDefinedElements(Value:boolean);
var
  j:integer;
  FacilityModel:IFacilityModel;
  UserDefinedElements:IDMCollection;
  UserDefinedElements2:IDMCollection2;
  Document:IDMDocument;
begin
    FacilityModel:=DataModel as IFacilityModel;
    UserDefinedElements:=FacilityModel.UserDefinedElements;
    UserDefinedElements2:=UserDefinedElements as IDMCollection2;
    j:=UserDefinedElements.IndexOf(Self as IDMElement);
    if Value then begin
      if j=-1 then
        UserDefinedElements2.Add(Self as IDMElement);
    end else begin
      if j<>-1 then
        UserDefinedElements2.Remove(Self as IDMElement);
    end;
    if not DataModel.IsLoading and
       not DataModel.IsCopying then begin
      Document:=DataModel.Document as IDMDocument;
      (Document.Server as IDataModelServer).RefreshElement(Self as IUnknown);
    end;
end;

procedure TCustomSafeguardElement.SetFieldValue(Code: integer;
  Value: OleVariant);
var
  Painter:IUnknown;
begin
  Painter:=nil;
  case Code of
  ord(cnstComment):
    FComment:=Value;
  ord(cnstShowSymbol),
  ord(cnstSymbolScaleFactor),
  ord(cnstImageRotated),
  ord(cnstImageMirrored):
    begin
      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (not DataModel.IsCopying) then begin
        Painter:=(DataModel.Document as ISMDocument).PainterU;
        if SpatialElement<>nil then
          Draw(Painter, -1)
        else
        if (Parent<>nil) then begin
          if Parent.SpatialElement<>nil then
            Parent.Draw(Painter, -1)
          else
          if (Parent.Parent<>nil) then begin
            if Parent.Parent.SpatialElement<>nil then
              Parent.Parent.Draw(Painter, -1)
          end;
        end;
      end;

      case Code of
      ord(cnstShowSymbol):
        FShowSymbol:=Value;
      ord(cnstSymbolScaleFactor):
        FSymbolScaleFactor:=Value;
      ord(cnstImageRotated):
//        if not DataModel.IsCopying then
          FImageRotated:=Value;
      ord(cnstImageMirrored):
//        if not DataModel.IsCopying then
          FImageMirrored:=Value;
      end;

      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (not DataModel.IsCopying) then begin
        Painter:=(DataModel.Document as ISMDocument).PainterU;
        if SpatialElement<>nil then begin
          if Selected then
            Draw(Painter, 1)
          else
            Draw(Painter, 0)
        end else
        if (Parent<>nil) then begin
          if Parent.SpatialElement<>nil then begin
            if Parent.Selected then
              Parent.Draw(Painter, 1)
            else
              Parent.Draw(Painter, 0)
          end else
          if (Parent.Parent<>nil) then begin
            if Parent.Parent.SpatialElement<>nil then begin
              if Parent.Parent.Selected then
                Parent.Parent.Draw(Painter, 1)
              else
                Parent.Parent.Draw(Painter, 0)
            end;
          end;
        end;
      end;
    end;
  else
    inherited
  end;
end;

class procedure TCustomSafeguardElement.MakeFields0;
begin
  AddField(rsShowSymbol, '', '', '',
                 fvtBoolean, 1, 0, 0,
                 ord(cnstShowSymbol), 0, pkView);
  AddField(rsSymbolScaleFactor, '%0.2f', '', '',
                 fvtFloat, 1, 0, 0,
                 ord(cnstSymbolScaleFactor), 0, pkView);
  AddField(rsImageRotated,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(cnstImageRotated), 0, pkView);
  AddField(rsImageMirrored,  '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(cnstImageMirrored), 0, pkView);
  inherited;
end;

class procedure TCustomSafeguardElement.MakeFields1;
begin
  AddField(rsComment, '', '', '',
           fvtText, 0, 0, 0,
           cnstComment, 0, pkComment);
  inherited;
end;

function TCustomSafeguardElement.Get_Collection(
  Index: Integer): IDMCollection;
begin
  case Index of
  0: Result:=FStates
  end;
end;

function TCustomSafeguardElement.Get_CollectionCount: integer;
begin
  Result:=1
end;

procedure TCustomSafeguardElement.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:begin
      aCollectionName:=rsElementStates;
      if DataModel<>nil then
        aRefSource:=(DataModel as IFacilityModel).FacilitySubStates
      else
        aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelectRef;
      aLinkType:=ltOneToMany;
    end;
  else
    inherited
  end;
end;

function TCustomSafeguardElement.GetCurrentState: IElementState;
var
  j, m:integer;
  FacilityState:IFacilityState;
  SubStateE:IDMElement;
begin
  Result:=nil;
  if FStates.Count=0 then Exit;
  FacilityState:=DataModel.CurrentState as IFacilityState;
  if FacilityState=nil then Exit;
  j:=FacilityState.SubStateCount-1;
  m:=-1;
  while j>=0 do begin
    SubStateE:=FacilityState.SubState[j];
    m:=0;
    while m<FStates.Count do
      if FStates.Item[m].Ref=SubStateE then
        Break
      else
        inc(m);
    if m<FStates.Count then
      Break
    else
      dec(j);
  end;
  if j>=0 then
    Result:=FStates.Item[m] as IElementState
end;

function TCustomSafeguardElement.Get_States: IDMCollection;
begin
  Result:=FStates
end;

function TCustomSafeguardElement.Get_DelayTimeDispersion: double;
begin
  Result:=FDelayTimeDispersion
end;

procedure TCustomSafeguardElement.Set_DelayTimeDispersion(Value: double);
begin
  FDelayTimeDispersion:=Value
end;

procedure TCustomSafeguardElement.Set_UserDefinedDetectionProbability(
  Value: WordBool);
begin
  FUserDefinedDetectionProbability:=Value
end;

function TCustomSafeguardElement.Get_UserDefineded: WordBool;
begin
  Result:=(inherited Get_UserDefineded) or
    FUserDefinedDelayTime or
    FUserDefinedDetectionProbability;
end;

procedure TCustomSafeguardElement.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
var
  SourceCollection:IDMCollection;
  j:integer;
  aCollection2:IDMCollection2;
begin
  case Index of
  0:begin
      aCollection2:=aCollection as IDMCollection2;
      SourceCollection:=(DataModel as IFacilityModel).FacilitySubStates;
      aCollection2.Clear;
      for j:=0 to SourceCollection.Count-1 do
       aCollection2.Add(SourceCollection.Item[j]);
    end;
  else
    inherited  
  end;
end;

function TCustomSafeguardElement.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(cnstComment):
    Result:=False;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

function TCustomSafeguardElement.GetDeletedObjectsClassID: integer;
begin
  Result:=_Updating;
end;

function TCustomSafeguardElement.Get_ShowSymbol: WordBool;
begin
  Result:=FShowSymbol
end;

function TCustomSafeguardElement.Get_SymbolScaleFactor: double;
begin
  Result:=FSymbolScaleFactor
end;

function TCustomSafeguardElement.Get_ImageRotated: WordBool;
begin
  Result:=FImageRotated
end;

procedure TCustomSafeguardElement._Destroy;
begin
  inherited;
end;

procedure TCustomSafeguardElement.Initialize;
begin
  inherited;
end;

function TCustomSafeguardElement.Get_ImageMirrored: WordBool;
begin
  Result:=FImageMirrored
end;

procedure TCustomSafeguardElement.Set_Parent(const Value: IDMElement);
begin
  inherited;
  if Parent=nil then Exit;
  if DataModel.IsLoading then Exit;
  CorrectDrawingDirection;
end;

procedure TCustomSafeguardElement.CorrectDrawingDirection;
var
  RightSideIsInner:boolean;
  Boundary:IBoundary;
begin
  if Parent=nil then Exit;
  if DataModel.IsLoading then Exit;
  if Parent.ClassID=_Boundary then
    Boundary:=Parent as IBoundary
  else
  if Parent.ClassID=_BoundaryLayer then begin
    if Parent.Parent=nil then Exit;
    if Parent.Parent.ClassID<>_Boundary then Exit;
    Boundary:=Parent.Parent as IBoundary;
  end else
    Exit;

  RightSideIsInner:=(Boundary as IBoundary3).RightSideIsInner;
  if RightSideIsInner then begin
    FImageRotated:=True;
    FImageMirrored:=True;
  end else begin
    FImageRotated:=False;
    FImageMirrored:=False;
  end;

end;

procedure TCustomSafeguardElement.AfterCopyFrom2; safecall;
begin
  inherited;
  CorrectDrawingDirection;
end;

end.
