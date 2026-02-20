unit OvercomingBoundaryU;

interface
uses
  Classes, SysUtils,  Graphics, Math,
  DMElementU, SorterU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  NamedSpatialElementU, SpatialModelConstU;

type
  TOvercomingBoundary=class(TDMElement, IOvercomingBoundary)
  private
    FPursuerGuards:IDMCollection;
    FBoundaryUnknowns:IDMCollection;
    FStartingGuards:IDMCollection;
    FNoIntercepts:IDMCollection;
    FCombatDefeats:IDMCollection;

    FInfoState:Integer;
    FSumW:Double;
    FProdNotU:Double;
    FBattleProbability:Double;
    FBattleTime:Double;
    FQProbability:Double;
    FResultProbability:Double;
    //FWarriorPathElements:IDMCollection;
    //FCriticalPoint:Variant;

    //function SavePath:boolean;
  protected
    class function GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Clear; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;


    procedure Set_InfoState(Value: Integer); safecall;
    procedure Set_SumW(Value: Double); safecall;
    procedure Set_ProdNotU(Value: Double); safecall;
    procedure Set_BattleProbability(Value: Double); safecall;
    procedure Set_BattleTime(Value: Double); safecall;
    procedure Set_QProbability(Value: Double); safecall;
    procedure Set_ResultProbability(Value: Double); safecall;

    function Get_StartingGuards: IDMCollection; safecall;
    function Get_PursuerGuards: IDMCollection; safecall;
    function Get_BoundaryUnknowns: IDMCollection; safecall;
    function Get_BoundaryNoIntercepts: IDMCollection; safecall;
    function Get_BoundaryCombatDefeats: IDMCollection; safecall;

    procedure BuildReport(ReportLevel: Integer; TabCount: Integer; Mode: Integer;
                          const Report: IDMText); override; safecall;
    function Get_ReportModeCount:integer; override; safecall;
    function Get_ReportModeName(Index:integer):WideString; override; safecall;
    function GetOperationName(Index: Integer): WideString;

  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;


  TOvercomingBoundaries=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function Get_ClassAlias(Index: integer): WideString; override; safecall;
  public
    procedure Initialize; override;
  end;

  TOvercomingBoundaryElementSorter=class(TSorter)
    function Compare(const Key1: IDMElement; const Key2: IDMElement): Integer; override; safecall;
  end;

implementation

uses
  GuardGroupU,
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TOvercomingBoundary }

class function TOvercomingBoundary.GetClassID: integer;
begin
  Result:=_OvercomingBoundary
end;

function TOvercomingBoundary.Get_CollectionCount: integer;
begin
  Result:=5;
end;

function TOvercomingBoundary.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
    0:Result:=FPursuerGuards;
    1:Result:=FBoundaryUnknowns;
    2:Result:=FStartingGuards;
    3:Result:=FNoIntercepts;
    4:Result:=FCombatDefeats;
  end;
end;

procedure TOvercomingBoundary.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:begin
      aCollectionName:=rsGuardPursuers;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=0;//leoDontCopy or leoOperation1;
      aLinkType:=ltOneToMany;
    end;
  1:begin
      aCollectionName:=rsBoundarUnknowns;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=0;
      aLinkType:=ltOneToMany;
    end;
  2:begin
      aCollectionName:=rsGuardStarts;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=0;
      aLinkType:=ltOneToMany;
    end;
  3:begin
      aCollectionName:=rsNoIntercepts;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=0;
      aLinkType:=ltOneToMany;
    end;
  4:begin
      aCollectionName:=rsCombatDefeats;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=0;
      aLinkType:=ltOneToMany;
    end;
  else
    inherited;
  end;
end;

class function TOvercomingBoundary.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TOvercomingBoundary.MakeFields0;
begin
  inherited;
  AddField(rsInfostate, '%0.4g', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(obInfoState), 1, pkOutput);
  AddField(rsSumW, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(obSumW), 1, pkOutput);
  AddField(rsProdNotU, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(obProdNotU), 1, pkOutput);
  AddField(rsBattleProbability, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(obBattleProbability), 1, pkOutput);
  AddField(rsBattleTime, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(obBattleTime), 1, pkOutput);
  AddField(rsQProbability, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(obQProbability), 1, pkOutput);
  AddField(rsResultProbability, '%0.4g', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(obResultProbability), 1, pkOutput);
end;

function TOvercomingBoundary.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(obInfoState):
    Result:=FInfoState;
  ord(obSumW):
    Result:=FSumW;
  ord(obProdNotU):
    Result:=FProdNotU;
  ord(obBattleProbability):
    Result:=FBattleProbability;
  ord(obBattleTime):
    Result:=FBattleTime;
  ord(obQProbability):
    Result:=FQProbability;
  ord(obResultProbability):
    Result:=FResultProbability;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TOvercomingBoundary.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(obInfoState):
    //FInfoState;
    begin end;
  ord(obSumW):
    //FSumW;
    begin end;
  ord(obProdNotU):
    //FProdNotU;
    begin end;
  ord(obBattleProbability):
    //FBattleProbability;
    begin end;
  ord(obBattleTime):
    //FBattleTime;
    begin end;
  ord(obQProbability):
    //FQProbability;
    begin end;
  ord(obResultProbability):
    //FResultProbability:=Value;
    begin end;
  else
    inherited;
  end;
end;

const
  _Path=2;

procedure TOvercomingBoundary.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
   SelfE:=Self as IDMElement;
  FPursuerGuards:=TGuardGroups.Create(SelfE) as IDMCollection;
  FBoundaryUnknowns:=TOvercomingBoundaries.Create(SelfE) as IDMCollection;
  FStartingGuards:=TGuardGroups.Create(SelfE) as IDMCollection;
  FNoIntercepts:=TOvercomingBoundaries.Create(SelfE) as IDMCollection;
  FCombatDefeats:=TOvercomingBoundaries.Create(SelfE) as IDMCollection;
end;

destructor TOvercomingBoundary.Destroy;
begin
  inherited;
  FPursuerGuards:=nil;
  FBoundaryUnknowns:=nil;
  FStartingGuards:=nil;
  FNoIntercepts:=nil;
  FCombatDefeats:=nil;
end;


procedure TOvercomingBoundary.Clear;
var
  DMCollection2:IDMCollection2;
  DMElementE:IDMElement;
begin
  if DataModel<>nil then begin
    DMCollection2:= FPursuerGuards as IDMCollection2;
    while FPursuerGuards.Count>0 do begin
      DMElementE:=FPursuerGuards.Item[FPursuerGuards.Count-1];
      DMElementE.Clear;
      DMCollection2.Remove(DMElementE);
    end;
    DMCollection2:= FBoundaryUnknowns as IDMCollection2;
    while FBoundaryUnknowns.Count>0 do begin
      DMElementE:=FBoundaryUnknowns.Item[FBoundaryUnknowns.Count-1];
      DMElementE.Clear;
      DMCollection2.Remove(DMElementE);
    end;
    DMCollection2:=FStartingGuards as IDMCollection2;
    while FStartingGuards.Count>0 do begin
      DMElementE:=FStartingGuards.Item[FStartingGuards.Count-1];
      DMElementE.Clear;
      DMCollection2.Remove(DMElementE);
    end;
    DMCollection2:= FNoIntercepts as IDMCollection2;
    while FNoIntercepts.Count>0 do begin
      DMElementE:=FNoIntercepts.Item[FNoIntercepts.Count-1];
      DMElementE.Clear;
      DMCollection2.Remove(DMElementE);
    end;
    DMCollection2:= FCombatDefeats as IDMCollection2;
    while FCombatDefeats.Count>0 do begin
      DMElementE:=FCombatDefeats.Item[FCombatDefeats.Count-1];
      DMElementE.Clear;
      DMCollection2.Remove(DMElementE);
    end;

  end;

  //inherited;
end;

function TOvercomingBoundary.Get_StartingGuards: IDMCollection;
begin
  Result:=FStartingGuards
end;

function TOvercomingBoundary.Get_PursuerGuards: IDMCollection;
begin
  Result:=FPursuerGuards
end;

function TOvercomingBoundary.Get_BoundaryUnknowns: IDMCollection;
begin
  Result:=FBoundaryUnknowns
end;

function TOvercomingBoundary.Get_BoundaryNoIntercepts: IDMCollection;
begin
  Result:=FNoIntercepts
end;

function TOvercomingBoundary.Get_BoundaryCombatDefeats: IDMCollection;
begin
  Result:=FCombatDefeats
end;

function TOvercomingBoundary.Get_ReportModeName(Index: integer): WideString;
begin
  case Index of
  0:Result:='Участки маршрута';
  1:Result:='Последовательность действий';
  else
    Result:=inherited Get_ReportModeName(Index);
  end;
end;

function TOvercomingBoundary.GetOperationName(Index: Integer): WideString;
begin
  case Index of
  0:Result:='Анализировать маршрут';
  1:Result:='Сохранить маршрут';
  else
    Result:='';
  end
end;


{ TOvercomingBoundarys }

class function TOvercomingBoundaries.GetElementClass: TDMElementClass;
begin
  Result:=TOvercomingBoundary;
end;

function TOvercomingBoundaries.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsOvercomingBoundaries;
end;

class function TOvercomingBoundaries.GetElementGUID: TGUID;
begin
  Result:=IID_IOvercomingBoundary;
end;

procedure TOvercomingBoundaries.Initialize;
begin
  inherited;
end;


procedure TOvercomingBoundary.Set_BattleProbability(Value: Double);
begin
  FBattleProbability:=Value;
end;

procedure TOvercomingBoundary.Set_BattleTime(Value: Double);
begin
  FBattleTime:=Value;
end;

procedure TOvercomingBoundary.Set_InfoState(Value: Integer);
begin
  FInfoState:=Value;
end;

procedure TOvercomingBoundary.Set_ProdNotU(Value: Double);
begin
  FProdNotU:=Value;
end;

procedure TOvercomingBoundary.Set_QProbability(Value: Double);
begin
  FQProbability:=Value;
end;

procedure TOvercomingBoundary.Set_ResultProbability(Value: Double);
begin
  FResultProbability:=Value;
end;

procedure TOvercomingBoundary.Set_SumW(Value: Double);
begin
  FSumW:=Value;
end;

procedure TOvercomingBoundary.BuildReport(ReportLevel, TabCount,
  Mode: Integer; const Report: IDMText);
begin
  inherited;

end;

function TOvercomingBoundary.Get_ReportModeCount: integer;
begin

end;

procedure TOvercomingBoundary.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
begin
  inherited;

end;
{ TOvercomingBoundaryElementSorter }

function TOvercomingBoundaryElementSorter.Compare(const Key1,
  Key2: IDMElement): Integer;
begin
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TOvercomingBoundary.MakeFields;

  //FSeparatingAreas:=TDMCollection.Create(nil) as IDMCollection;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
  //FSeparatingAreas:=nil;
end.
