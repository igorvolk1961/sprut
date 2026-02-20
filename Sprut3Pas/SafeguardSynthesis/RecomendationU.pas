unit RecomendationU;

interface
uses
  Classes, SysUtils,
  DMElementU, SorterU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLIb_TLB,
  SafeguardSynthesisLib_TLB;

const
  BaseVariantCount=3;

type

  TRecomendation=class(TDMElement, IRecomendation)
  private
    FPriority:integer;
    FKind:integer;
    FPrice:double;
    FParentElement:IDMElement;
    FRecomendationVariants:IDMCollection;
  protected
    class function  GetClassID:integer; override;
    procedure MakeText; safecall;

    function  Get_Priority:integer; safecall;
    procedure Set_Priority(Value:integer); safecall;
    function  Get_Kind:integer; safecall;
    procedure Set_Kind(Value:integer); safecall;
    function  Get_CurrentVariantIndex:integer; safecall;
    procedure Set_CurrentVariantIndex(Value:integer); safecall;
    function  Get_Price:double; safecall;
    procedure Set_Price(Value:double); safecall;
    function  Get_ParentElement:IDMElement; safecall;
    procedure Set_ParentElement(const Value:IDMElement); safecall;
    function  Get_RecomendationVariant(Index:integer):IDMElement; safecall;

    function  Get_CollectionCount: Integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TRecomendations=class(TSortedCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

  TRecomendationSorter=class(TSorter)
  protected
    function  Get_Duplicates: WordBool; override; safecall;
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

implementation
uses
  SafeguardSynthesisConstU,
  RecomendationVariantU;

{ TRecomendation }

class function TRecomendation.GetClassID: integer;
begin
  Result:=_Recomendation;
end;

function TRecomendation.Get_Kind: integer;
begin
  Result:=FKind
end;

function TRecomendation.Get_ParentElement: IDMElement;
begin
  Result:=FParentElement
end;

function TRecomendation.Get_Price: double;
begin
  Result:=FPrice
end;

function TRecomendation.Get_Priority: integer;
begin
  Result:=FPriority
end;

function TRecomendation.Get_RecomendationVariant(
  Index: integer): IDMElement;
begin
  if Index<=0 then
    Result:=nil
  else
    Result:=FRecomendationVariants.Item[Index-1]
end;

function TRecomendation.Get_CurrentVariantIndex: integer;
var
  j:integer;
  RecomendationVariantE, EquipmentVariantE:IDMElement;
begin
  EquipmentVariantE:=(DataModel as ISafeguardSynthesis).CurrentEquipmentVariant;
  j:=0;
  while j<=BaseVariantCount-1 do begin
    RecomendationVariantE:=FRecomendationVariants.Item[j];
    if RecomendationVariantE.Parents.IndexOf(EquipmentVariantE)<>-1 then
      Break
    else
      inc(j)
  end;
  if j<=BaseVariantCount-1 then
    Result:=j+1
  else
    Result:=0
end;

procedure TRecomendation.Initialize;
var
  RecomendationVariantE:IDMElement;
  RecomendationVariants2:IDMCollection2;
  EquipmentVariants:IDMCollection;
  j:integer;
begin
  inherited;
  FRecomendationVariants:=DataModel.CreateCollection(_RecomendationVariant, Self as IDMElement);
  RecomendationVariants2:=(DataModel as ISafeguardSynthesis).RecomendationVariants  as IDMCollection2;
  EquipmentVariants:=(DataModel as ISafeguardSynthesis).EquipmentVariants;
  for j:=1 to BaseVariantCount do begin
    RecomendationVariantE:=RecomendationVariants2.CreateElement(False);
    RecomendationVariants2.Add(RecomendationVariantE);
    RecomendationVariantE.Parent:=Self as IDMElement;
    RecomendationVariantE.AddParent(EquipmentVariants.Item[j]);
  end;
end;

procedure TRecomendation.MakeText;
var
  S, S0, S1:string;
  Unk:IUnknown;
begin
  case FKind of
  0: S0:='Увеличить время задержки ';
  1: S0:='Увеличить вероятность обнаружения ';
  else
     S0:='Увеличить время задержки и вероятность обнаружения ';
  end;
  if Ref.QueryInterface(IZone, Unk)=0 then
    S1:='в зоне '
  else
  if Ref.QueryInterface(IBoundary, Unk)=0 then
    S1:='на рубеже '
  else
    S1:='';
  S:=Format('"%s" (приоритет %d)',[Ref.Name, FPriority]);
  Set_Name(S0+S1+S);
end;

procedure TRecomendation.Set_Kind(Value: integer);
begin
  FKind:=Value
end;

procedure TRecomendation.Set_ParentElement(const Value: IDMElement);
begin
  FParentElement:=Value
end;

procedure TRecomendation.Set_Price(Value: double);
begin
  FPrice:=Value
end;

procedure TRecomendation.Set_Priority(Value: integer);
begin
  FPriority:=Value
end;

procedure TRecomendation.Set_CurrentVariantIndex(Value: integer);
var
  VariantIndex, j:integer;
  RecomendationVariantE, CurrentEquipmentVariantE:IDMElement;
begin
  VariantIndex:=Get_CurrentVariantIndex;
  if VariantIndex=Value then Exit;

  CurrentEquipmentVariantE:=(DataModel as ISafeguardSynthesis).CurrentEquipmentVariant;

  if VariantIndex>0 then begin
    RecomendationVariantE:=FRecomendationVariants.Item[VariantIndex-1];
    j:=RecomendationVariantE.Parents.IndexOf(CurrentEquipmentVariantE);
    if j<>-1 then
      RecomendationVariantE.RemoveParent(CurrentEquipmentVariantE);
  end;

  VariantIndex:=Value;

  if VariantIndex>0 then begin
    RecomendationVariantE:=FRecomendationVariants.Item[VariantIndex-1];
    j:=RecomendationVariantE.Parents.IndexOf(CurrentEquipmentVariantE);
    if j=-1 then
      RecomendationVariantE.AddParent(CurrentEquipmentVariantE);
  end;
end;

procedure TRecomendation._Destroy;
begin
  inherited;
  FRecomendationVariants:=nil;
end;


function TRecomendation.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FRecomendationVariants
end;

function TRecomendation.Get_CollectionCount: Integer;
begin
  Result:=1
end;

procedure TRecomendation.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
   aRefSource:=nil;
   aCollectionName:=rsRecomendationVariants;
   aClassCollections:=nil;
   aOperations:=0;
   aLinkType:=ltOneToMany;
end;

{ TRecomendations }

class function TRecomendations.GetElementClass: TDMElementClass;
begin
  Result:=TRecomendation;
end;

function TRecomendations.Get_ClassAlias(Index:integer): WideString;
begin
    Result:=rsRecomendation
end;

class function TRecomendations.GetElementGUID: TGUID;
begin
  Result:=IID_IRecomendation;
end;

{ TRecomendationSorter }

function TRecomendationSorter.Compare(const Key1,
  Key2: IDMElement): Integer;
var
  P1, P2:integer;
begin
  if Key1.DataModel.IsLoading then begin
    Result:=inherited Compare(Key1, Key2);
    Exit;
  end;
  P1:=(Key1 as IRecomendation).Priority;
  P2:=(Key2 as IRecomendation).Priority;
  if P1>P2 then
    Result:=-1
  else if P1<P2 then
    Result:=+1
  else begin
    Result:=0;
  end;  
end;

function TRecomendationSorter.Get_Duplicates: WordBool;
begin
  Result:=True
end;

end.
