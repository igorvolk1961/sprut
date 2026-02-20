unit FMRecomendationU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLIb_TLB,
  SafeguardAnalyzerLib_TLB;

type

  TFMRecomendation=class(TNamedDMElement, IFMRecomendation)
  private
    FPriority:double;
    FKind:integer;
  protected
    class function  GetClassID:integer; override;
    procedure MakeText; safecall;

    function  Get_Priority:double; safecall;
    procedure Set_Priority(Value:double); safecall;
    function  Get_Kind:integer; safecall;
    procedure Set_Kind(Value:integer); safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TFMRecomendations=class(TSortedCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
    procedure Initialize; override;
  end;

implementation
uses
  FacilityModelConstU;

{ TFMRecomendation }

class function TFMRecomendation.GetClassID: integer;
begin
  Result:=_FMRecomendation;
end;

function TFMRecomendation.Get_Kind: integer;
begin
  Result:=FKind
end;

function TFMRecomendation.Get_Priority: double;
begin
  Result:=FPriority
end;

procedure TFMRecomendation.Initialize;
begin
  inherited;
end;

procedure TFMRecomendation.MakeText;
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
  S:=Format('"%s" (приоритет %0.0f)',[Ref.Name, FPriority]);
  Set_Name(S0+S1+S);
end;

procedure TFMRecomendation.Set_Kind(Value: integer);
begin
  FKind:=Value
end;

procedure TFMRecomendation.Set_Priority(Value: double);
begin
  FPriority:=Value
end;

procedure TFMRecomendation._Destroy;
begin
  inherited;
end;

{ TFMRecomendations }

class function TFMRecomendations.GetElementClass: TDMElementClass;
begin
  Result:=TFMRecomendation;
end;

function TFMRecomendations.Get_ClassAlias(Index:integer): WideString;
begin
    Result:=rsFMRecomendation
end;

class function TFMRecomendations.GetElementGUID: TGUID;
begin
  Result:=IID_IFMRecomendation;
end;

procedure TFMRecomendations.Initialize;
begin
  inherited;
end;

end.
