unit RecomendationVariantU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB,
  SafeguardSynthesisLib_TLB;

type
  TRecomendationVariant=class(TDMElement, IRecomendationVariant)
  private
    FEquipmentElements:IDMCollection;
    FParents:IDMCollection;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;

    function  Get_EquipmentElements:IDMCollection; safecall;
    procedure Connect; safecall;
    procedure Disconnect; safecall;

    procedure AddParent(const value:IDMElement); override;
    function  Get_Parents:IDMCollection; override; safecall;
    function  Get_CollectionCount: Integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TRecomendationVariants=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  SafeguardSynthesisConstU;

var
  FFields:IDMCollection;

{ TRecomendationVariant }

class function TRecomendationVariant.GetClassID: integer;
begin
  Result:=_RecomendationVariant;
end;

procedure TRecomendationVariant._Destroy;
begin
  inherited;
  FEquipmentElements:=nil;
end;

procedure TRecomendationVariant.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FEquipmentElements:=DataModel.CreateCollection(_EquipmentElement, SelfE);
  FParents:=DataModel.CreateCollection(-1, SelfE);
end;

class function TRecomendationVariant.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TRecomendationVariant.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FEquipmentElements
end;

function TRecomendationVariant.Get_CollectionCount: Integer;
begin
  Result:=1
end;

procedure TRecomendationVariant.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
   aRefSource:=nil;
   aCollectionName:=rsEquipmentElements;
   aClassCollections:=nil;
   aOperations:=0;
   aLinkType:=ltOneToMany;
end;

function TRecomendationVariant.Get_EquipmentElements: IDMCollection;
begin
  Result:=FEquipmentElements
end;

procedure TRecomendationVariant.Connect;
var
  j:integer;
  EquipmentElement:IEquipmentElement;
  OwnerCollection:IDMCollection;
  OwnerCollection2:IDMCollection2;
  SafeguardElement:IDMElement;
begin
  for j:=0 to FEquipmentElements.Count-1 do begin
    EquipmentElement:=FEquipmentElements.Item[j] as IEquipmentElement;
    SafeguardElement:=EquipmentElement.SafeguardElement;
    SafeguardElement.Parent:=(Parent as IRecomendation).ParentElement;
    OwnerCollection:=SafeguardElement.OwnerCollection;
    OwnerCollection2:=OwnerCollection as IDMCollection2;
    OwnerCollection2.Add(SafeguardElement);
  end;
end;

procedure TRecomendationVariant.Disconnect;
var
  j:integer;
  EquipmentElement:IEquipmentElement;
  OwnerCollection:IDMCollection;
  OwnerCollection2:IDMCollection2;
  SafeguardElement:IDMElement;
begin
  for j:=0 to FEquipmentElements.Count-1 do begin
    EquipmentElement:=FEquipmentElements.Item[j] as IEquipmentElement;
    SafeguardElement:=EquipmentElement.SafeguardElement;
    SafeguardElement.Parent:=nil;
    OwnerCollection:=SafeguardElement.OwnerCollection;
    OwnerCollection2:=OwnerCollection as IDMCollection2;
    OwnerCollection2.Remove(SafeguardElement);
  end;
end;

function TRecomendationVariant.Get_Parents: IDMCollection;
begin
  Result:=FParents
end;

procedure TRecomendationVariant.AddParent(const value: IDMElement);
begin
  inherited;

end;

{ TRecomendationVariants }

class function TRecomendationVariants.GetElementClass: TDMElementClass;
begin
  Result:=TRecomendationVariant;
end;


function TRecomendationVariants.Get_ClassAlias(Index: integer): WideString;
begin
    Result:=rsRecomendationVariant
end;

class function TRecomendationVariants.GetElementGUID: TGUID;
begin
  Result:=IID_IRecomendationVariant;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TRecomendationVariant.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
