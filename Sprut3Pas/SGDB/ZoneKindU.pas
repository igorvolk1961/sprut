unit ZoneKindU;

interface
uses
  FacilityElementKindU,  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TZoneKind=class(TFacilityElementKind, IZoneKind)
  private
    FPedestrialMovementVelocity:double;
    FCarMovementEnabled:boolean;
    FAirMovementEnabled:boolean;
    FWaterMovementEnabled:boolean;
    FUnderWaterMovementEnabled:boolean;
    FRoadCover:integer;
    FDefaultCategory:integer;
    FDefaultTransparencyDist:double;
    FDefaultSideBoundaryKind: Variant;
    FDefaultBottomBoundaryKind: Variant;
    FDefaultTopBoundaryKind: Variant;
    FHSubZoneKind: Variant;
    FVSubZoneKind: Variant;

    FUpperZoneKind: Variant;
    FLowerZoneKind: Variant;

    FSpecialKind:integer;
  protected
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;

    function Get_AirMovementEnabled: WordBool; safecall;
    function Get_CarMovementEnabled: WordBool; safecall;
    function Get_PedestrialMovementVelocity: double; safecall;
    function Get_UnderWaterMovementEnabled: WordBool; safecall;
    function Get_WaterMovementEnabled: WordBool; safecall;
    function Get_RoadCover: integer; safecall;
    function Get_DefaultCategory:integer; safecall;
    function Get_DefaultTransparencyDist:double; safecall;
    function  Get_DefaultSideBoundaryKind: IDMElement; safecall;
    function  Get_DefaultBottomBoundaryKind: IDMElement; safecall;
    function  Get_DefaultTopBoundaryKind: IDMElement; safecall;
    function  Get_VSubZoneKind: IDMElement; safecall;
    function  Get_HSubZoneKind: IDMElement; safecall;
    function  Get_SpecialKind:integer; safecall;
    function Get_UpperZoneKind: IDMElement; safecall;
    function Get_LowerZoneKind: IDMElement; safecall;

    property PedestrialMovementVelocity:double
      read Get_PedestrialMovementVelocity;
    property CarMovementEnabled:WordBool
      read Get_CarMovementEnabled;
    property AirMovementEnabled:WordBool
      read Get_AirMovementEnabled;
    property WaterMovementEnabled:WordBool
      read Get_WaterMovementEnabled;
    property UnderWaterMovementEnabled:WordBool
      read Get_UnderWaterMovementEnabled;
    property RoadCover:integer
      read Get_RoadCover;

  end;

  TZoneKinds=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TZoneKind }

class function TZoneKind.GetClassID: integer;
begin
  Result:=_ZoneKind
end;

function TZoneKind.Get_AirMovementEnabled: WordBool;
begin
  Result:=FAirMovementEnabled
end;

function TZoneKind.Get_CarMovementEnabled: WordBool;
begin
  Result:=FCarMovementEnabled
end;

function TZoneKind.Get_PedestrialMovementVelocity: double;
begin
  Result:=FPedestrialMovementVelocity
end;

function TZoneKind.Get_RoadCover: integer;
begin
  Result:=FRoadCover
end;

function TZoneKind.Get_UnderWaterMovementEnabled: WordBool;
begin
  Result:=FUnderWaterMovementEnabled
end;

function TZoneKind.Get_WaterMovementEnabled: WordBool;
begin
  Result:=FWaterMovementEnabled
end;

function TZoneKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(zkpPedestrialMovementVelocity):
    Result:=FPedestrialMovementVelocity;
  ord(zkpCarMovementEnabled):
    Result:=FCarMovementEnabled;
  ord(zkpAirMovementEnabled):
    Result:=FAirMovementEnabled;
  ord(zkpWaterMovementEnabled):
    Result:=FWaterMovementEnabled;
  ord(zkpUnderWaterMovementEnabled):
    Result:=FUnderWaterMovementEnabled;
  ord(zkpRoadCover):
    Result:=FRoadCover;
  ord(zkpDefaultCategory):
    Result:=FDefaultCategory;
  ord(zkpDefaultTransparencyDist):
    Result:=FDefaultTransparencyDist;
  ord(zkpDefaultSideBoundaryKind):
      Result:=FDefaultSideBoundaryKind;
  ord(zkpDefaultBottomBoundaryKind):
      Result:=FDefaultBottomBoundaryKind;
  ord(zkpDefaultTopBoundaryKind):
      Result:=FDefaultTopBoundaryKind;
  ord(zkpHSubZoneKind):
      Result:=FHSubZoneKind;
  ord(zkpVSubZoneKind):
      Result:=FVSubZoneKind;

  ord(zkpUpperZoneKind):
      Result:=FUpperZoneKind;
  ord(zkpLowerZoneKind):
      Result:=FLowerZoneKind;

  ord(zkpSpecialKind):
      Result:=FSpecialKind;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TZoneKind.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(zkpPedestrialMovementVelocity):
    FPedestrialMovementVelocity:=Value;
  ord(zkpCarMovementEnabled):
    FCarMovementEnabled:=Value;
  ord(zkpAirMovementEnabled):
    FAirMovementEnabled:=Value;
  ord(zkpWaterMovementEnabled):
    FWaterMovementEnabled:=Value;
  ord(zkpUnderWaterMovementEnabled):
    FUnderWaterMovementEnabled:=Value;
  ord(zkpRoadCover):
    FRoadCover:=Value;
  ord(zkpDefaultCategory):
    FDefaultCategory:=Value;
  ord(zkpDefaultTransparencyDist):
    FDefaultTransparencyDist:=Value;
  ord(zkpDefaultSideBoundaryKind):
    FDefaultSideBoundaryKind:=Value;
  ord(zkpDefaultBottomBoundaryKind):
    FDefaultBottomBoundaryKind:=Value;
  ord(zkpDefaultTopBoundaryKind):
    FDefaultTopBoundaryKind:=Value;
  ord(zkpHSubZoneKind):
    FHSubZoneKind:=Value;
  ord(zkpVSubZoneKind):
    FVSubZoneKind:=Value;

  ord(zkpUpperZoneKind):
    FUpperZoneKind:=Value;
  ord(zkpLowerZoneKind):
    FLowerZoneKind:=Value;

  ord(zkpSpecialKind):
    FSpecialKind:=Value;
  else
    inherited;
  end;
end;

class function TZoneKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TZoneKind.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsPedestrialMovementVelocity, '%0.2f', '', '',
                 fvtFloat, 10, 0, 0,
                 ord(zkpPedestrialMovementVelocity), 0, pkInput);
  AddField(rsCarMovementEnabled, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(zkpCarMovementEnabled), 0, pkInput);
  AddField(rsAirMovementEnabled, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(zkpAirMovementEnabled), 0, pkInput);
  AddField(rsWaterMovementEnabled, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(zkpWaterMovementEnabled), 0, pkInput);
  AddField(rsUnderWaterMovementEnabled, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(zkpUnderWaterMovementEnabled), 0, pkInput);

  S:='|'+rsZoneNoVelocity+
     '|'+rsZoneVelocity1+
     '|'+rsZoneVelocity2+
     '|'+rsZoneVelocity3;
  AddField(rsRoadCover, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(zkpRoadCover), 0, pkInput);
  AddField(rsDefaultCategory, '%2d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(zkpDefaultCategory), 0, pkInput);
  AddField(rsDefaultTransparencyDist, '%0.02f', '', '',
                 fvtFloat, InfinitValue, 0, InfinitValue,
                 ord(zkpDefaultTransparencyDist), 0, pkInput);
  AddField(rsDefaultSideBoundaryKind, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(zkpDefaultSideBoundaryKind), 0, pkInput);
  AddField(rsDefaultBottomBoundaryKind, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(zkpDefaultBottomBoundaryKind), 0, pkInput);
  AddField(rsDefaultTopBoundaryKind, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(zkpDefaultTopBoundaryKind), 0, pkInput);
  AddField(rsHSubZoneKind, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(zkpHSubZoneKind), 0, pkInput);
  AddField(rsVSubZoneKind, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(zkpVSubZoneKind), 0, pkInput);

  AddField(rsUpperZoneKind, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(zkpUpperZoneKind), 0, pkInput);
  AddField(rsLowerZoneKind, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(zkpLowerZoneKind), 0, pkInput);

  S:='|'+rsNone+
     '|'+rsAir+
     '|'+rsEarth+
     '|'+rsSite+
     '|'+rsRoof+
     '|'+rsBuilding;
  AddField(rsSpecialKind, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(zkpSpecialKind), 0, pkInput);
end;

function TZoneKind.Get_DefaultCategory: integer;
begin
  Result:=FDefaultCategory
end;

function TZoneKind.Get_DefaultTransparencyDist: double;
begin
  Result:=FDefaultTransparencyDist
end;

function TZoneKind.Get_DefaultSideBoundaryKind: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FDefaultSideBoundaryKind;
  Result:=Unk as IDMElement
end;


function TZoneKind.Get_HSubZoneKind: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FHSubZoneKind;
  Result:=Unk as IDMElement
end;

function TZoneKind.Get_VSubZoneKind: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FVSubZoneKind;
  Result:=Unk as IDMElement
end;

procedure TZoneKind.GetFieldValueSource(Code: integer; var aCollection: IDMCollection);
var
  SafeguardDatabase:ISafeguardDatabase;
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  SafeguardDatabase:=DataModel as ISafeguardDatabase;
  case Code of
  ord(zkpDefaultSideBoundaryKind),
  ord(zkpDefaultBottomBoundaryKind),
  ord(zkpDefaultTopBoundaryKind):
    theCollection:=SafeguardDatabase.BoundaryKinds;
  ord(zkpHSubZoneKind),
  ord(zkpVSubZoneKind),
  ord(zkpUpperZoneKind),
  ord(zkpLowerZoneKind):
    theCollection:=SafeguardDatabase.ZoneKinds;
  else
    begin
      inherited;
      Exit;
    end;
  end;
  if aCollection=nil then
    aCollection:=theCollection
  else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

function TZoneKind.Get_SpecialKind: integer;
begin
  Result:=FSpecialKind
end;

function TZoneKind.Get_LowerZoneKind: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FLowerZoneKind;
  Result:=Unk as IDMElement
end;

function TZoneKind.Get_UpperZoneKind: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FUpperZoneKind;
  Result:=Unk as IDMElement
end;

function TZoneKind.Get_DefaultBottomBoundaryKind: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FDefaultBottomBoundaryKind;
  Result:=Unk as IDMElement
end;

function TZoneKind.Get_DefaultTopBoundaryKind: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FDefaultTopBoundaryKind;
  Result:=Unk as IDMElement
end;

{ TZoneKinds }

class function TZoneKinds.GetElementClass: TDMElementClass;
begin
  Result:=TZoneKind;
end;

function TZoneKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsZoneKind;
end;

class function TZoneKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IZoneKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TZoneKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
