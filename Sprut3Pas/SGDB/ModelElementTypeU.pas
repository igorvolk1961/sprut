unit ModelElementTypeU;

interface
uses
  DMELementU,
  CustomModelElementTypeU,
  DataModel_TLB, SgdbLib_TLB;

type

  TModelElementType=class(TCustomModelElementType, IModelElementType)
  private
    FParameters:IDMCollection;
    FDefaultSubKindIndex:integer;
    FTypeID:integer;
    FElementParameters:IDMCollection;
  protected
    FSubKinds:IDMCollection;        // виды объ€вл€ютс€, но не создаютс€, так как
                                  // у разных потомков виды будут разных классов
    procedure Initialize; override;
    procedure _Destroy; override;
    procedure Loaded; override;

    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function Get_Parameters: IDMCollection; safecall;
    procedure Set_DefaultSubKindIndex(Value: integer); override; safecall;
    function  Get_DefaultSubKindIndex: integer; override; safecall;
    function Get_SubKinds: IDMCollection; override; safecall;
    function Get_TypeID:integer; safecall;
    function Get_ElementParameters:IDMCollection; safecall;

    property Parameters: IDMCollection read Get_Parameters;
    property SubKinds: IDMCollection read Get_SubKinds;
  end;

implementation
uses
  SGDBParameterU, SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TModelElementType }

procedure TModelElementType.Initialize;
begin
  FParameters:=DataModel.CreateCollection(_SGDBParameter, Self as IDMElement);
  FElementParameters:=DataModel.CreateCollection(_ElementParameter, Self as IDMElement);
  FDefaultSubKindIndex:=-1;
//   FSubKinds объ€вл€етс€, но не создаетс€, так как
//   у потомков виды будут разных классов
end;

function TModelElementType.Get_CollectionCount: integer;
begin
  Result:=3;
end;

function TModelElementType.Get_Collection(Index: integer):IDMCollection;
begin
  case Index of
  0:Result:=FSubKinds;
  1:Result:=FParameters;
  2:Result:=FElementParameters;
  else
    Result:=inherited Get_Collection(Index)
  end;
end;

procedure TModelElementType.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
    case Index of
    0:begin
        aCollectionName:=Get_Collection(0).ClassAlias[akImenitM];
        aOperations:=leoAdd or leoDelete or leoRename or leoMove;
        aRefSource:=nil;
        aClassCollections:=nil;
        aLinkType:=ltOneToMany;
      end;
    1:begin
        aCollectionName:=rsSGDBParameters;
        aOperations:=leoAdd or leoSelect or leoRename;
        aRefSource:=nil;
        aClassCollections:=nil;
        aLinkType:=ltManyToMany;
      end;
    2:begin
        aCollectionName:=rsElementParameters;
        aOperations:=leoAdd or leoSelect or leoRename;
        aRefSource:=nil;
        aClassCollections:=nil;
        aLinkType:=ltManyToMany;
      end;
    else
      inherited
    end;
end;

function TModelElementType.Get_SubKinds: IDMCollection;
begin
  Result:=FSubKinds;
end;

function TModelElementType.Get_Parameters: IDMCollection;
begin
  Result:=FParameters;
end;

procedure TModelElementType._Destroy;
begin
  inherited;
  FParameters:=nil;
  FSubKinds:=nil;
end;

procedure TModelElementType.Loaded;
begin
  inherited;
end;

function TModelElementType.Get_DefaultSubKindIndex: integer;
begin
  Result:=FDefaultSubKindIndex
end;

procedure TModelElementType.Set_DefaultSubKindIndex(Value: integer);
begin
  FDefaultSubKindIndex:=Value

end;

function TModelElementType.Get_ElementParameters: IDMCollection;
begin
  Result:=FElementParameters
end;

function TModelElementType.Get_TypeID: integer;
begin
  Result:=FTypeID
end;

class function TModelElementType.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TModelElementType.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  0: Result:=FTypeID;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

class procedure TModelElementType.MakeFields0;
begin
  inherited;
  AddField(rsTypeID, '%d', '', '',
                 fvtInteger, 0, 0, 0,
                 0, 0, pkInput);
end;

procedure TModelElementType.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  0: FTypeID:=Value;
  else
    inherited;
  end;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TModelElementType.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
