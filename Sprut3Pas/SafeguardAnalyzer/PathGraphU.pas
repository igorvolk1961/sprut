unit PathGraphU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLIb_TLB,
  SafeguardAnalyzerLib_TLB;

type

  TPathGraph=class(TNamedDMElement, IPathGraph, IFacilityState)
  private
    FGraphIndex:integer;
    FPathArcs:IDMCollection;
    FExtraSubState:IDMElement;
    FBackPathSubState:IDMElement;
    FBackPath:boolean;
    FModificationStage:integer;
    FKind:integer;
  protected
    class function  GetClassID:integer; override;
    function  Get_SubStateCount: integer; safecall;
    function  Get_SubState(Index:integer): IDMElement; safecall;
    procedure AddSubState(const aSubState:IDMElement); safecall;
    procedure RemoveSubState(const aSubState:IDMElement); safecall;

    function  Get_GraphIndex: Integer; safecall;
    procedure Set_GraphIndex(Value: Integer); safecall;
    function Get_ModificationStage:integer; safecall;
    procedure Set_ModificationStage(Value:integer); safecall;

    function Get_PathArcs:IDMCollection; safecall;
    procedure _AddBackRef(const Element:IDMElement); override; safecall;
    procedure _RemoveBackRef(const Element:IDMElement); override; safecall;

    function Get_ExtraSubState:IDMElement; safecall;
    procedure Set_ExtraSubState(const Value:IDMElement); safecall;
    function Get_BackPathSubState:IDMElement; safecall;
    procedure Set_BackPathSubState(const Value:IDMElement); safecall;

    function  Get_BackPath: WordBool; safecall;
    procedure Set_BackPath(Value: WordBool); safecall;

    function  Get_Kind:integer; safecall;
    procedure Set_Kind(Value:integer); safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TPathGraphs=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SafeguardAnalyzerConstU;

{ TPathGraph }

class function TPathGraph.GetClassID: integer;
begin
  Result:=_PathGraph;
end;

function TPathGraph.Get_GraphIndex: Integer;
begin
  Result:=FGraphIndex
end;

procedure TPathGraph.Set_GraphIndex(Value: Integer);
begin
  FGraphIndex:=Value
end;

procedure TPathGraph.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FPathArcs:=DataModel.CreateCollection(-1, SelfE);
end;

procedure TPathGraph._Destroy;
begin
  inherited;
  FPathArcs:=nil;
  FExtraSubState:=nil;
  FBackPathSubState:=nil;
end;

function TPathGraph.Get_ModificationStage: integer;
begin
 Result:=FModificationStage
end;

procedure TPathGraph.Set_ModificationStage(Value: integer);
begin
  FModificationStage:=Value
end;

function TPathGraph.Get_PathArcs: IDMCollection;
begin
  Result:=FPathArcs
end;

procedure TPathGraph._AddBackRef(const Element: IDMElement);
begin
  (FPathArcs as IDMCollection2).Add(Element)
end;

procedure TPathGraph._RemoveBackRef(const Element: IDMElement);
begin
  (FPathArcs as IDMCollection2).Remove(Element)
end;

procedure TPathGraph.Set_ExtraSubState(const Value: IDMElement);
begin
  FExtraSubState:=Value
end;

function TPathGraph.Get_ExtraSubState: IDMElement;
begin
  Result:=FExtraSubState
end;

function TPathGraph.Get_BackPath: WordBool;
begin
  Result:=FBackPath
end;

procedure TPathGraph.Set_BackPath(Value: WordBool);
begin
  FBackPath:=Value
end;

function TPathGraph.Get_Kind: integer;
begin
  Result:=FKind
end;

procedure TPathGraph.Set_Kind(Value: integer);
begin
  FKind:=Value
end;

function TPathGraph.Get_BackPathSubState: IDMElement;
begin
  Result:=FBackPathSubState
end;

procedure TPathGraph.Set_BackPathSubState(const Value: IDMElement);
begin
  FBackPathSubState:=Value
end;

procedure TPathGraph.AddSubState(const aSubState: IDMElement);
var
  aFacilityState:IFacilityState;
begin
  aFacilityState:=Ref as IFacilityState;
  aFacilityState.AddSubState(aSubState);
end;

function TPathGraph.Get_SubState(Index: integer): IDMElement;
var
  aFacilityState:IFacilityState;
begin
  aFacilityState:=Ref as IFacilityState;
  if Index<aFacilityState.SubStateCount then
    Result:=aFacilityState.SubState[Index]
  else
    Result:=FExtraSubState
end;

function TPathGraph.Get_SubStateCount: integer;
var
  aFacilityState:IFacilityState;
begin
  aFacilityState:=Ref as IFacilityState;
  Result:=aFacilityState.SubStateCount+1;
end;

procedure TPathGraph.RemoveSubState(const aSubState: IDMElement);
var
  aFacilityState:IFacilityState;
begin
  aFacilityState:=Ref as IFacilityState;
  aFacilityState.RemoveSubState(aSubState);
end;

{ TPathGraphs }

class function TPathGraphs.GetElementClass: TDMElementClass;
begin
  Result:=TPathGraph;
end;

function TPathGraphs.Get_ClassAlias(Index:integer): WideString;
begin
    Result:=rsPathGraph
end;

class function TPathGraphs.GetElementGUID: TGUID;
begin
  Result:=IID_IPathGraph;
end;

end.
