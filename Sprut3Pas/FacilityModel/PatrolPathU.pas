unit PatrolPathU;

interface
uses
  Classes, SysUtils, Variants,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  NamedSpatialElementU;

type
  TPatrolPath=class(TNamedSpatialElement, IPatrolPath)
  private
    FGuardGroup:Variant;
    FPeriod: Double;
    FIrregular: boolean;
    procedure CheckZones;
  protected
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function GetFieldValue(Index: integer): OleVariant; override;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override;
    procedure Set_SpatialElement(const aElement:IDMElement); override; safecall;
    procedure AfterLoading2; override;

    procedure _AddBackRef(const aElement:IDMElement); override;

    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    class function  GetClassID:integer; override;

    function  Get_Period: Double; safecall;
    function  Get_Irregular: WordBool; safecall;
    function  Get_WarriorGroup: IWarriorGroup; safecall;

  end;

  TPatrolPaths=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TPatrolPath }

class function TPatrolPath.GetClassID: integer;
begin
  Result:=_PatrolPath;
end;

class function TPatrolPath.GetFields: IDMCollection;
begin
  Result:=FFields
end;

procedure TPatrolPath.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(wpGuardGroup):
    theCollection:=(DataModel as IFacilityModel).GuardGroups;
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
    if theCollection=nil then Exit;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

class procedure TPatrolPath.MakeFields0;
begin
  inherited;
  AddField(rsGuardGroup, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(wpGuardGroup), 0, pkInput);
  AddField(rsPatrolPeriod, '%0.2f', '', '',
                 fvtFloat, 1, 0, 0,
                 ord(wpPeriod), 0, pkInput);
  AddField(rsIrregular, '', '', 'I',
                 fvtBoolean, 0, 0, 0,
                 ord(wpIrregular), 0, pkInput);
end;

function TPatrolPath.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(wpGuardGroup):
    Result:=FGuardGroup;
  ord(wpPeriod):
    Result:=FPeriod;
  ord(wpIrregular):
    Result:=FIrregular;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TPatrolPath.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(wpGuardGroup):
    FGuardGroup:=Value;
  ord(wpPeriod):
    FPeriod:=Value;
  ord(wpIrregular):
    FIrregular:=Value;
  else
    inherited;
  end;
end;

procedure TPatrolPath._AddBackRef(const aElement: IDMElement);
begin
  if aElement.ClassID=_Polyline then
    Set_SpatialElement(aElement);
end;

function TPatrolPath.Get_Irregular: WordBool;
begin
  Result:=FIrregular
end;

function TPatrolPath.Get_Period: Double;
begin
  Result:=FPeriod
end;

procedure TPatrolPath.Set_SpatialElement(const aElement:IDMElement);
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if aElement=nil then Exit;
  CheckZones;
end;

procedure TPatrolPath.CheckZones;
var
  Polyline:IPolyLine;
  Line:ILine;
  j:integer;
  SpatialModel:ISpatialModel2;
  C0, C1:ICoordNode;
  Volume0, Volume1:IVolume;
  Zone0, Zone1:IZone;
begin
  SpatialModel:=DataModel as ISpatialModel2;

  Polyline:=SpatialElement as  IPolyLine;
  for j:=0 to Polyline.Lines.Count-1 do begin
    Line:=Polyline.Lines.Item[j] as ILine;
    C0:=Line.C0;
    C1:=Line.C1;
    Volume0:=SpatialModel.GetVolumeContaining(C0.X,C0.Y,C0.Z);
    Volume1:=SpatialModel.GetVolumeContaining(C1.X,C1.Y,C1.Z);
    if Volume0<>nil then begin
      Zone0:=(Volume0 as IDMElement).Ref as IZone;
      if Zone0.PatrolPaths.IndexOf(Self as IDMElement)=-1 then
        (Zone0.PatrolPaths as IDMCollection2).Add(Self as IDMElement);
    end;
    if Volume1<>nil then begin
      Zone1:=(Volume1 as IDMElement).Ref as IZone;
      if Zone1.PatrolPaths.IndexOf(Self as IDMElement)=-1 then
        (Zone1.PatrolPaths as IDMCollection2).Add(Self as IDMElement);
    end;
  end;
end;

procedure TPatrolPath.AfterLoading2;
begin
  inherited;
  CheckZones
end;

function TPatrolPath.Get_WarriorGroup: IWarriorGroup;
var
  Unk:IUnknown;
begin
  Unk:=FGuardGroup;
  Result:=Unk as IWarriorGroup;
end;

{ TPatrolPaths }

class function TPatrolPaths.GetElementClass: TDMElementClass;
begin
  Result:=TPatrolPath;
end;

function TPatrolPaths.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsPatrolPath;
end;

class function TPatrolPaths.GetElementGUID: TGUID;
begin
  Result:=IID_IPatrolPath;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TPatrolPath.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
