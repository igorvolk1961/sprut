unit RecomendationU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLIb_TLB,
  SafeguardAnalyzerLib_TLB;

type

  TRecomendation=class(TNamedDMElement, IRecomendation)
  private
    FPriority:integer;
    FKind:integer;
  protected
    class function  GetClassID:integer; override;
    procedure MakeText; safecall;

    function  Get_Priority:integer; safecall;
    procedure Set_Priority(Value:integer); safecall;
    function  Get_Kind:integer; safecall;
    procedure Set_Kind(Value:integer); safecall;
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
  SafeguardAnalyzerConstU;

{ TRecomendation }

class function TRecomendation.GetClassID: integer;
begin
  Result:=_Recomendation;
end;

function TRecomendation.Get_Kind: integer;
begin
  Result:=FKind
end;

function TRecomendation.Get_Priority: integer;
begin
  Result:=FPriority
end;

procedure TRecomendation.Initialize;
begin
  inherited;
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

procedure TRecomendation.Set_Priority(Value: integer);
begin
  FPriority:=Value
end;

procedure TRecomendation._Destroy;
begin
  inherited;
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
