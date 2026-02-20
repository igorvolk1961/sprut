unit DDDU;

interface

uses
  ComObj, Classes, DataModelU,
  DataModel_TLB, DDDLib_TLB, DMServer_TLB;

type
  TDDD = class(TDataModel, IDDD)
  private
  protected
// методы IDataModel
    function  Get_RootObjectCount(Mode: Integer):integer; override; safecall;
    procedure GetRootObject(Mode, RootIndex: Integer; out RootObject: IUnknown;
                            out RootObjectName: WideString; out aOperations: Integer;
                            out aLinkType: Integer); override; safecall;
    function Get_SubModel(Index: integer): IDataModel; override; safecall;

//  защищенные методы
    procedure MakeCollections; override;
    procedure Init; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  ComServ,
  AAAU,
  BBBU,
  CCCU;

{ TStoXDB }

function TStoXDB.Get_RootObjectCount(Mode: Integer): integer;
begin
  case Mode of
  0: Result:=3;
  else
   inherited
 end;
end;

procedure TStoXDB.GetRootObject(Mode, RootIndex: Integer;
  out RootObject: IUnknown; out RootObjectName: WideString;
  out aOperations, aLinkType: Integer);
var
  aRefSource:IDMCollection;
  aClassCollections:IDMClassCollections;
begin
  case Mode of
  0:case RootIndex of
    0:begin
        RootObject:=Collection[_AAA];
        GetCollectionProperties(_AAA,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
      end;
    1:begin
        RootObject:=Collection[_BBB];
        GetCollectionProperties(_BBB,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
      end;
    2:begin
        RootObject:=Collection[_CCC];
        GetCollectionProperties(_CCC,RootObjectName,aRefSource,aClassCollections,aOperations,aLinkType);
      end;
    else
      inherited
    end;
 else
   inherited
 end;
end;

procedure TStoXDB.MakeCollections;
var
  aParent:IDMElement;
begin
  inherited;
  aParent:=Self as IDMElement;

  AddCollection(TAAAs.Create(aParent) as IDMCollection);
  AddCollection(TBBBs.Create(aParent) as IDMCollection);
  AddCollection(TCCCs.Create(aParent) as IDMCollection);
end;

destructor TStoXDB.Destroy;
begin
  inherited;
end;

procedure TStoXDB.Initialize;
begin
  inherited;
  ID:=1;
end;

procedure TStoXDB.Init;
begin
  inherited;
end;

function TStoXDB.Get_SubModel(Index: integer): IDataModel;
begin
  case Index of
  1:  Result:=Self;
  else
      Result:=inherited Get_SubModel(Index);
  end;
end;

initialization
  TTypedComObjectFactory.Create(ComServer, TDDD, Class_DDD,
    ciMultiInstance, tmApartment);
end.
