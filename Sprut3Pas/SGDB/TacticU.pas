unit TacticU;

interface
uses
  Classes, DMElementU, DataModel_TLB, SgdbLib_TLB;

type

  TTactic=class(TNamedDMElement, ITactic)
  private
    FParents:IDMCollection;

    FInsiderTactic: boolean;
    FOutsiderTactic: boolean;
    FGuardTactic: boolean;
    FFastTactic: WordBool;
    FStealthTactic: boolean;
    FDeceitTactic: boolean;
    FForceTactic: boolean;
    FEntryTactic: boolean;
    FExitTactic: boolean;
    FMethods:IDMCollection;
    FPathArcKind:integer;

    FSafeguardClasses:IDMCollection;

    FCategories:TList;

    function Get_Category(Index: integer): IDMCollection;
    function Get_ListOfClass(TypeClassID:integer): IDMCollection;

    property Category[Index:integer]:IDMCollection
           read Get_Category;
  protected
    class function  GetClassID:integer; override;

    function Get_Parents:IDMCollection; override;
    procedure _AddChild(const aChild:IDMElement); override;
    procedure _RemoveChild(const aChild:IDMElement); override;
    procedure Set_Parent(const Value:IDMElement); override; safecall;

    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    function Get_GuardTactic: WordBool; safecall;
    function Get_OutsiderTactic: WordBool; safecall;
    function Get_InsiderTactic: WordBool; safecall;
    function Get_FastTactic: WordBool; safecall;
    function Get_StealthTactic: WordBool; safecall;
    function Get_DeceitTactic: WordBool; safecall;
    function Get_ForceTactic: WordBool; safecall;
    function Get_EntryTactic: WordBool; safecall;
    function Get_ExitTactic: WordBool; safecall;
    function Get_PathArcKind:integer; safecall;
    function Get_Methods:IDMCollection; safecall;
    function Get_SafeguardClasses:IDMCollection; safecall;


    procedure AddParent(const aParent:IDMElement); override; safecall;
    procedure RemoveParent(const aParent:IDMElement); override; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function  DependsOn(const SafeguardElementTypeE: IDMElement): WordBool; safecall;
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TTactics=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation
uses
  SafeguardDatabaseConstU, SafeguardClassU;

var
  FFields:IDMCollection;

{ TTactic }

procedure TTactic.Initialize;
var
  SafeguardDatabase:ISafeguardDatabase;
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FParents:=DataModel.CreateCollection(-1, SelfE);
  FMethods:=DataModel.CreateCollection(_OvercomeMethod, SelfE);
  SafeguardDatabase:=DataModel as ISafeguardDatabase;
  FSafeguardClasses:=TSafeguardClasses.Create(SafeguardDatabase.DataClassModel as IDMElement) as IDMCollection;

  FCategories:=TList.Create;
end;

procedure TTactic._Destroy;
begin
  inherited;
  FParents:=nil;
  FMethods:=nil;
  FSafeguardClasses:=nil;

  FCategories.Free;
end;

class function TTactic.GetClassID: integer;
begin
  Result:=_Tactic
end;

function TTactic.Get_Parents: IDMCollection;
begin
  Result:=FParents;
end;

function TTactic.Get_DeceitTactic: WordBool;
begin
  Result:=FDeceitTactic
end;

class procedure TTactic.MakeFields0;
begin
  inherited;
  AddField(rsFastTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tFastTactic), 0, pkInput);
  AddField(rsStealthTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tStealthTactic), 0, pkInput);
  AddField(rsDeceitTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tDeceitTactic), 0, pkInput);
  AddField(rsForceTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tForceTactic), 0, pkInput);
  AddField(rsEntryTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tEntryTactic), 0, pkInput);
  AddField(rsExitTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tExitTactic), 0, pkInput);
  AddField(rsOutsiderTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tOutsiderTactic), 0, pkInput);
  AddField(rsInsiderTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tInsiderTactic), 0, pkInput);
  AddField(rsGuardTactic, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(tGuardTactic), 0, pkInput);
  AddField(rsPathArcKind, '|Пересечение рубежа|Пересечение зоны', '', '',
                 fvtChoice, 0, 0, 0,
                 ord(tPathArcKind), 0, pkInput);

end;

class function TTactic.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TTactic.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(tFastTactic):
    Result:=FFastTactic;
  ord(tStealthTactic):
    Result:=FStealthTactic;
  ord(tDeceitTactic):
    Result:=FDeceitTactic;
  ord(tForceTactic):
    Result:=FForceTactic;
  ord(tEntryTactic):
    Result:=FEntryTactic;
  ord(tExitTactic):
    Result:=FExitTactic;
  ord(tOutsiderTactic):
    Result:=FOutsiderTactic;
  ord(tInsiderTactic):
    Result:=FInsiderTactic;
  ord(tGuardTactic):
    Result:=FGuardTactic;
  ord(tPathArcKind):
    Result:=FPathArcKind;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TTactic.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(tFastTactic):
    FFastTactic:=Value;
  ord(tStealthTactic):
    FStealthTactic:=Value;
  ord(tDeceitTactic):
    FDeceitTactic:=Value;
  ord(tForceTactic):
    FForceTactic:=Value;
  ord(tEntryTactic):
    FEntryTactic:=Value;
  ord(tExitTactic):
    FExitTactic:=Value;
  ord(tOutsiderTactic):
    FOutsiderTactic:=Value;
  ord(tInsiderTactic):
    FInsiderTactic:=Value;
  ord(tGuardTactic):
    FGuardTactic:=Value;
   ord(tPathArcKind):
    FPathArcKind:=Value;
 else
    inherited;
  end;
end;

function TTactic.Get_Methods: IDMCollection;
begin
  Result:=FMethods
end;

function TTactic.Get_EntryTactic: WordBool;
begin
  Result:=FEntryTactic
end;

function TTactic.Get_ExitTactic: WordBool;
begin
  Result:=FExitTactic
end;

function TTactic.Get_FastTactic: WordBool;
begin
  Result:=FFastTactic
end;

function TTactic.Get_InsiderTactic: WordBool;
begin
  Result:=FInsiderTactic
end;

function TTactic.Get_StealthTactic: WordBool;
begin
  Result:=FStealthTactic
end;

function TTactic.Get_OutsiderTactic: WordBool;
begin
  Result:=FOutsiderTactic
end;

function TTactic.Get_GuardTactic: WordBool;
begin
  Result:=FGuardTactic
end;

function TTactic.Get_Collection(Index: Integer): IDMCollection;
var
  j:integer;
begin
  case Index of
  ord(tcMethods):
    Result:=FMethods;
  ord(tcSafeguardClasses):
     Result:=FSafeguardClasses;
  ord(tcParents):
    Result:=FParents;
  else
    begin
      j:=Index-ord(High(TTacticCategory))-1;
      Result:=Category[j];
    end;
  end;
end;

function TTactic.Get_CollectionCount: integer;
begin
  Result:=ord(High(TTacticCategory))+1+FCategories.Count;
end;

procedure TTactic.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
var
  aElements:IDMCollection;
  j:integer;
begin
  case Index of
  ord(tcMethods):begin
      aCollectionName:=FMethods.ClassAlias[akImenitM];
      aOperations:=leoDontCopy;
      aRefSource:=nil;
      aClassCollections:=nil;
      aLinkType:=ltParents;
    end;
  ord(tcSafeguardClasses):
    begin
      aCollectionName:=rsSafeguardClasses;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoSelect;
      aLinkType:=ltManyToMany;
    end;
  ord(tcParents):begin
      aCollectionName:=rsParents;
      aOperations:=leoDontCopy;
    end;
  else
    begin
      j:=Index-ord(High(TTacticCategory))-1;
      aElements:=Category[j];

      aCollectionName:=aElements.ClassAlias[akImenitM];
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelect or leoRename;
      aLinkType:=ltManyToMany;
    end
  end;
end;

procedure TTactic.AddParent(const aParent: IDMElement);
begin
  inherited;
  if aParent.ClassID=_OvercomeMethod then
    (FMethods as IDMCollection2).Add(aParent)
end;

procedure TTactic.RemoveParent(const aParent: IDMElement);
begin
  inherited;
  if aParent.ClassID=_OvercomeMethod then
    (FMethods as IDMCollection2).Remove(aParent)
end;

procedure TTactic._AddChild(const aChild: IDMElement);
var
  SafeguardClass:ISafeguardClass;
  aCategory:IDMCollection;
begin
  if aChild.QueryInterface(ISafeguardClass, SafeguardClass)<>0 then Exit;

  aCategory:=SafeguardClass.CreateCollection;
  FCategories.Add(pointer(aCategory));
  aCategory._AddRef;
end;

procedure TTactic._RemoveChild(const aChild: IDMElement);
var
  SafeguardClass:ISafeguardClass;
  aCategory:IDMCollection;
begin
  if aChild.QueryInterface(ISafeguardClass, SafeguardClass)<>0 then Exit;

  aCategory:=Get_ListOfClass(SafeguardClass.TypeClassID);
  if aCategory=nil then Exit;
  (aCategory as IDMCollection2).DisconnectFrom(Self);
  FCategories.Remove(pointer(aCategory));
  aCategory._Release;
end;

function TTactic.Get_Category(Index: integer): IDMCollection;
begin
  Result:=IDMCollection(FCategories[Index]);
end;

function TTactic.Get_ListOfClass(TypeClassID: integer): IDMCollection;
var
  j:integer;
  aCollection:IDMCollection;
begin
  Result:=nil;
  for j:=0 to FCategories.Count-1 do begin
    aCollection:=IDMCollection(Category[j]);
    if TypeClassID = (aCollection as IDMCollection2).ClassID  then begin
      Result:=aCollection;
      Exit;
    end;
  end;
end;

function TTactic.Get_PathArcKind: integer;
begin
  Result:=FPathArcKind
end;

function TTactic.Get_SafeguardClasses: IDMCollection;
begin
  Result:=FSafeguardClasses
end;

function TTactic.DependsOn(
  const SafeguardElementTypeE: IDMElement): WordBool;
var
  Category:IDMCollection;
begin
  Result:=False;
  Category:=Get_ListOfClass(SafeguardElementTypeE.ClassID);
  if Category=nil then Exit;
  if Category.IndexOf(SafeguardElementTypeE)=-1 then Exit;
  Result:=True;
end;

function TTactic.Get_ForceTactic: WordBool;
begin
  Result:=FForceTactic
end;

procedure TTactic.Set_Parent(const Value: IDMElement);
begin
  if DataModel=nil then Exit;
  if (DataModel as IDMElement)=Value then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Value=nil then Exit;
  AddParent(Value);
end;

{ TTactics }

class function TTactics.GetElementClass: TDMElementClass;
begin
  Result:=TTactic;
end;

class function TTactics.GetElementGUID: TGUID;
begin
  Result:=IID_ITactic;
end;

function TTactics.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsTactic;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TTactic.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
