unit AAAU;

interface
uses
  DMElementU, DataModel_TLB, DDDLib_TLB;

type
  TAAA=class(TNamedDMElement, IAAA)
  private
//    FXXX:integer;
//    FBBB:Variant;
//    FCCCs:IDMCollection;
  protected
    class function  GetClassID:integer; override;

    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure GetFieldValueSource(Code: Integer; var aCollection: IDMCollection); override; safecall;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TAAAs=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  DDDConstU
//,CCCU
  ;

var
  FFields:IDMCollection;

{ TAAA }

procedure TAAA.Initialize;
begin
  inherited;
//    FCCCs:=TCCCs.Create(Self as IDMElement) as IDMCollection;
end;

procedure TAAA._Destroy;
begin
  inherited;
//    FCCCs:=nil
end;

class function TAAA.GetClassID: integer;
begin
  Result:=_AAA
end;

class function TAAA.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TAAA.MakeFields0;
begin
  inherited;
//  AddField(rsXXX, '%d', '', '',
//      fvtInteger, 0, 0, 0,
//      ord(aaaXXX), 0, pkInput);
//  AddField(rsBBB, '', '', '',
//      fvtElement, 0, 0, 0,
//      ord(aaaBBB), 0, pkInput);
end;

function TAAA.GetFieldValue(Code: integer): OleVariant;
begin
//  case Code of
//  ord(aaaXXX): Result:=FXXX;
//  ord(aaaBBB): Result:=FBBB;
//  else
    Result:=inherited GetFieldValue(Code);
//  end;
end;

procedure TAAA.SetFieldValue(Code: integer; Value: OleVariant);
begin
///  case Code of
///  ord(aaaXXX):FXXX:=Value;
///  ord(aaaBBB):FBBB:=Value;
///  else
    inherited;
///  end;
end;

procedure TAAA.GetFieldValueSource(Code: Integer;
  var aCollection: IDMCollection);
begin
//  case Code of
//  ord(aaaBBB): aCollection:=(DataModel as IDMElement).Collection[_BBB];
//  else
    inherited
//  end;
end;

function TAAA.Get_Collection(Index: Integer): IDMCollection;
begin
//  case Index-inherited Get_CollectionCount of
//  0: Result:=FCCC
//  else
    Result:=inherited Get_Collection(Index)
//  end;
end;

function TAAA.Get_CollectionCount: integer;
begin
  Result:=inherited Get_CollectionCount
//                                     +1;
end;

procedure TAAA.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  inherited;
end;

{ TAAAs }

function TAAAs.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsAAA
  else
    Result:=rsAAAs;
end;

class function TAAAs.GetElementClass: TDMElementClass;
begin
  Result:=TAAA
end;

class function TAAAs.GetElementGUID: TGUID;
begin
  Result:=IID_IAAA
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TAAA.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
