unit ControlDeviceKindU;
{Виды целей}
interface
uses
  SecurityEquipmentKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type

  TControlDeviceKind=class(TSecurityEquipmentKind, IControlDeviceKind, IBoundaryKind)
  private
    FBoundaryLayerTypes:IDMCollection;
    FAddressInfo:boolean;
    FDamageInfo:boolean;
    FTamperInfo:boolean;
    FLinkCheck:boolean;
    FInfoCapacity:integer;
    FSystemKind:integer;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class procedure MakeFields0; override;

    function  Get_CollectionCount:integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function  Get_BoundaryLayerTypes: IDMCollection; safecall;
    function  Get_SingleLayer: WordBool; safecall;
    function  Get_PathKind: Integer; safecall;
    function  Get_HighPath: WordBool; safecall;

    function  Get_AddressInfo:WordBool; safecall;
    function  Get_DamageInfo:WordBool; safecall;
    function  Get_TamperInfo:WordBool; safecall;
    function  Get_LinkCheck:WordBool; safecall;
    function  Get_InfoCapacity:integer; safecall;
    function  Get_DontCross:WordBool; safecall;
    function  Get_Orientation:integer; safecall;
    function  Get_SystemKind:integer; safecall;
    function Get_DefaultBottomEdgeHeight:double; safecall;


    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TControlDeviceKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TControlDeviceKind }

class function TControlDeviceKind.GetClassID: integer;
begin
  Result:=_ControlDeviceKind
end;

class function TControlDeviceKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TControlDeviceKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsAddressInfo, '', '', '',
           fvtBoolean, 0, 0, 0,
           ord(cmkAddressInfo), 0, pkInput);
  AddField(rsDamageInfo, '', '', '',
           fvtBoolean, 0, 0, 0,
           ord(cmkDamageInfo), 0, pkInput);
  AddField(rsTamperInfo, '', '', '',
           fvtBoolean, 0, 0, 0,
           ord(cmkDamageInfo), 0, pkInput);
  AddField(rsLinkCheck, '', '', '',
           fvtBoolean, 0, 0, 0,
           ord(cmkLinkCheck), 0, pkInput);
  AddField(rsInfoCapacity, '', '', '',
           fvtInteger, 4, 0, 0,
           ord(cmkInfoCapacity), 0, pkInput);
  S:='|'+rsComplexSystem+
     '|'+rsAlarmSystem+
     '|'+rsTVSystem+
     '|'+rsAccessSystem+
     '|'+rsAlarmFireSystem+
     '|'+rsFireSystem+
     '|'+rsKeyStorageSystem;
  AddField(rsSystemKind, S, '', '',
           fvtChoice, 4, 0, 0,
           ord(cmkSystemKind), 0, pkInput);
end;

function TControlDeviceKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cmkAddressInfo):
    Result:=FAddressInfo;
  ord(cmkDamageInfo):
    Result:=FDamageInfo;
  ord(cmkTamperInfo):
    Result:=FTamperInfo;
  ord(cmkLinkCheck):
    Result:=FLinkCheck;
  ord(cmkInfoCapacity):
    Result:=FInfoCapacity;
  ord(cmkSystemKind):
    Result:=FSystemKind;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TControlDeviceKind.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(cmkAddressInfo):
    FAddressInfo:=Value;
  ord(cmkDamageInfo):
    FDamageInfo:=Value;
  ord(cmkTamperInfo):
    FTamperInfo:=Value;
  ord(cmkLinkCheck):
    FLinkCheck:=Value;
  ord(cmkInfoCapacity):
    FInfoCapacity:=Value;
  ord(cmkSystemKind):
    FSystemKind:=Value;
  else
    inherited;
  end;
end;

function TControlDeviceKind.Get_BoundaryLayerTypes: IDMCollection;
begin
  Result:=FBoundaryLayerTypes
end;

function TControlDeviceKind.Get_HighPath: WordBool;
begin
  Result:=False
end;

function TControlDeviceKind.Get_PathKind: Integer;
begin
  Result:=0
end;

function TControlDeviceKind.Get_SingleLayer: WordBool;
begin
  Result:=False
end;

procedure TControlDeviceKind._Destroy;
begin
  inherited;
  FBoundaryLayerTypes:=nil
end;

procedure TControlDeviceKind.Initialize;
begin
  inherited;
  FBoundaryLayerTypes:=DataModel.CreateCollection(_BoundaryLayerType, Self as IDMElement);
end;

function TControlDeviceKind.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0: Result:=FBoundaryLayerTypes;
  else
    Result:=inherited Get_Collection(Index);
  end;
end;

function TControlDeviceKind.Get_CollectionCount: integer;
begin
  Result:=1
end;

procedure TControlDeviceKind.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  case Index of
  0:begin
      aCollectionName:=rsBoundaryLayerTypes;
      aRefSource:=nil;
      aClassCollections:=nil;
      aOperations:=leoAdd or leoSelect or leoRename;
      aLinkType:=ltManyToMany;
    end;
  else
    inherited;
  end;
end;

function TControlDeviceKind.Get_AddressInfo: WordBool;
begin
  Result:=FAddressInfo
end;

function TControlDeviceKind.Get_DamageInfo: WordBool;
begin
  Result:=FDamageInfo
end;

function TControlDeviceKind.Get_InfoCapacity: integer;
begin
  Result:=FInfoCapacity
end;

function TControlDeviceKind.Get_LinkCheck: WordBool;
begin
  Result:=FLinkCheck
end;

function TControlDeviceKind.Get_TamperInfo: WordBool;
begin
  Result:=FTamperInfo
end;

function TControlDeviceKind.Get_DontCross: WordBool;
begin
  Result:=False
end;

function TControlDeviceKind.Get_Orientation: integer;
begin
  Result:=-1
end;

function TControlDeviceKind.Get_SystemKind: integer;
begin
  Result:=FSystemKind
end;

function TControlDeviceKind.Get_DefaultBottomEdgeHeight: double;
begin
  Result:=0;
end;

{ TControlDeviceKinds }

function TControlDeviceKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsControlDeviceKind;
end;

class function TControlDeviceKinds.GetElementClass: TDMElementClass;
begin
  Result:=TControlDeviceKind;
end;

class function TControlDeviceKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IControlDeviceKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TControlDeviceKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
