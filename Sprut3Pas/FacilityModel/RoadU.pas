unit RoadU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  NamedSpatialElementU;

type
  TRoad=class(TNamedSpatialElement, IRoad, IDMElement3)
  private
    FUserDefinedVehicleVelocity:boolean;
    FVehicleVelocity:Double;
    FPedestrialVelocity:Double;
    FPersonalPresence: Integer;
  protected
    procedure CalculateFieldValues; override; safecall;
    class function GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function  Get_UserDefineded: WordBool; override; safecall;
    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;

    procedure _AddBackRef(const aElement:IDMElement); override;

    function Get_UserDefinedVehicleVelocity:WordBool; safecall;
    function Get_VehicleVelocity:Double; safecall;
    function Get_PedestrialVelocity:Double; safecall;
    function  Get_PersonalPresence: Integer; safecall;
    function Get_SpatialElementClassID: Integer; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TRoads=class(TDMCollection)
  private
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  public
    procedure Initialize; override;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TRoad }

class function TRoad.GetClassID: integer;
begin
  Result:=_Road
end;

class function TRoad.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TRoad.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsUserDefinedVehicleVelocity, '', '', '',
           fvtBoolean, 0, 0, 1,
           ord(rpUserDefinedVehicleVelocity), 0, pkUserDefined);
  AddField(rsVehicleVelocity, '%0.2f', '', '',
           fvtFloat, 0, 0, 0,
           ord(rpVehicleVelocity), 2, pkUserDefined);
  AddField(rsPedestrialVelocity, '%0.2f', '', '',
           fvtFloat, 9, 0, 0,
           ord(rpPedestrialVelocity), 0, pkInput);
  S:='|'+rsPersonalNeverPresent+
     '|'+rsPersonalMayPresent+
     '|'+rsPersonalAlwaysPresent;
  AddField(rsPersonalPresence, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(rpPersonalPresence), 0, pkInput);
end;

function TRoad.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(rpUserDefinedVehicleVelocity):
    Result:=FUserDefinedVehicleVelocity;
  ord(rpVehicleVelocity):
    Result:=FVehicleVelocity;
  ord(rpPedestrialVelocity):
    Result:=FPedestrialVelocity;
  ord(rpPersonalPresence):
    Result:=FPersonalPresence;
//  ord(rdWidth):
//    Result:=FWidth;
  else
    Result:=inherited GetFieldValue(Code)
  end;
end;

procedure TRoad.SetFieldValue(Code: integer;
  Value: OleVariant);
  procedure UpdateUserDefinedElements;
  var
    j:integer;
    FacilityModel:IFacilityModel;
    UserDefinedElements:IDMCollection;
    UserDefinedElements2:IDMCollection2;
    Document:IDMDocument;
  begin
      FacilityModel:=DataModel as IFacilityModel;
      UserDefinedElements:=FacilityModel.UserDefinedElements;
      UserDefinedElements2:=UserDefinedElements as IDMCollection2;
      j:=UserDefinedElements.IndexOf(Self as IDMElement);
      if Value then begin
        if j=-1 then
          UserDefinedElements2.Add(Self as IDMElement);
      end else begin
        if j<>-1 then
          UserDefinedElements2.Remove(Self as IDMElement);
      end;
     if not DataModel.IsLoading and
        not DataModel.IsCopying then begin
       Document:=DataModel.Document as IDMDocument;
       (Document.Server as IDataModelServer).RefreshElement(Self as IUnknown);
     end;
  end;
begin
  case Code of
  ord(rpUserDefinedVehicleVelocity):
    begin
      FUserDefinedVehicleVelocity:=Value;
      UpdateUserDefinedElements;
    end;
  ord(rpVehicleVelocity):
    FVehicleVelocity:=Value;
  ord(rpPedestrialVelocity):
    FPedestrialVelocity:=Value;
  ord(rpPersonalPresence):
    FPersonalPresence:=Value;
//  ord(wpWidth):
//    FWidth:=Value;
  else
    inherited;
  end;
end;

procedure TRoad.Initialize;
begin
  inherited;
end;

destructor TRoad.Destroy;
begin
  inherited;
end;

procedure TRoad._AddBackRef(const aElement: IDMElement);
begin
  if aElement.ClassID=_LineGroup then
    Set_SpatialElement(aElement)
  else
  if aElement.ClassID=_Polyline then
    Set_SpatialElement(aElement);
end;


procedure TRoad.CalculateFieldValues;
var
  FacilityModelS:IFMState;
  WarriorGroup:IWarriorGroup;
  j:integer;
  VehicleKind:IVehicleKind;
  Velocity:double;
  aVehicleType:IVehicleType;
begin
  inherited;
  FacilityModelS:=DataModel as IFMState;
  WarriorGroup:=FacilityModelS.CurrentWarriorGroupU as IWarriorGroup;
  if WarriorGroup=nil then Exit;
  if FUserDefinedVehicleVelocity then Exit;

  FVehicleVelocity:=0;
  for j:=0 to WarriorGroup.Vehicles.Count-1 do begin
    VehicleKind:=WarriorGroup.Vehicles.Item[j].Ref as IVehicleKind;
    aVehicleType:=WarriorGroup.Vehicles.Item[j].Ref.Parent as IVehicleType;
    if aVehicleType.TypeCode=0 then
      begin
        Velocity:=VehicleKind.Velocity1;
        if FVehicleVelocity<Velocity then
          FVehicleVelocity:=Velocity;
      end;
  end;
end;

function TRoad.Get_PedestrialVelocity: Double;
begin
  Result:=FPedestrialVelocity
end;

function TRoad.Get_UserDefinedVehicleVelocity: WordBool;
begin
  Result:=FUserDefinedVehicleVelocity
end;

function TRoad.Get_VehicleVelocity: Double;
begin
  Result:=FVehicleVelocity
end;

function TRoad.Get_UserDefineded: WordBool;
begin
  Result:=(inherited Get_UserDefineded) or
    FUserDefinedVehicleVelocity
end;

function TRoad.Get_PersonalPresence: Integer;
begin
  Result:=FPersonalPresence
end;

function TRoad.Get_SpatialElementClassID: Integer;
begin
  Result:=_LineGroup
end;

function TRoad.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(rpVehicleVelocity):
    Result:=FUserDefinedVehicleVelocity;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

{ TRoads }

class function TRoads.GetElementClass: TDMElementClass;
begin
  Result:=TRoad;
end;

function TRoads.Get_ClassAlias(Index: integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsRoad
  else
    Result:=rsRoads;
end;

class function TRoads.GetElementGUID: TGUID;
begin
  Result:=IID_IRoad;
end;

procedure TRoads.Initialize;
begin
  inherited;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TRoad.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
