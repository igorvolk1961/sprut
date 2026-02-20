unit VolumeSensorKindU;
{Виды объемных  элементов обнаружения}
interface
uses
  DetectionElementKindU, DMElementU, DataMOdel_TLB, SgdbLib_TLB;

type
  TVolumeSensorKind=class(TDetectionElementKind, IVolumeSensorKind)
  private
    FZoneImage:Variant;
    FZoneLength:double;
    FZoneWidth:double;
    FZoneHeight:double;
    FDefaultElevation: double;
    FZoneForm:integer;
    FDetectionOnBoundary:boolean;
  protected
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    class function  GetClassID:integer; override;

    function Get_DetectionZoneHeight: double; safecall;
    function Get_DetectionZoneLength: double; safecall;
    function Get_DetectionZoneWidth: double; safecall;
    function Get_DetectionZoneImage: IElementImage; safecall;
    function Get_DetectionZoneForm: integer; safecall;
    function Get_DefaultElevation: double; safecall;
    function Get_DetectionOnBoundary:WordBool; safecall;

    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override; safecall;
  end;

  TVolumeSensorKinds=class(TDMCollection)
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

{ TVolumeSensorKind }

class function TVolumeSensorKind.GetClassID: integer;
begin
  Result:=_VolumeSensorKind
end;

class function TVolumeSensorKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TVolumeSensorKind.Get_DetectionZoneHeight: double;
begin
  Result:=FZoneHeight
end;

function TVolumeSensorKind.Get_DetectionZoneLength: double;
begin
  Result:=FZoneLength
end;

function TVolumeSensorKind.Get_DetectionZoneWidth: double;
begin
  Result:=FZoneWidth
end;

class procedure TVolumeSensorKind.MakeFields0;
begin
  inherited;
  AddField(rsZoneImage, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(vskZoneImage), 0, pkView);
  AddField(rsZoneLength, '%5.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(vskZoneLength), 0, pkInput);
  AddField(rsZoneWidth, '%5.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(vskZoneWidth), 0, pkInput);
  AddField(rsZoneHeight, '%5.1f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(vskZoneHeight), 0, pkInput);
  AddField(rsZoneForm,
  '|Эллипсоид|Конус|Параллелепипед|Цилиндр|Сфера|Полуэллипсоид', '', '',
                 fvtChoice, 0, 0, 0,
                 ord(vskZoneForm), 0, pkInput);
  AddField(rsDefaultElevation, '%5.1f', '', '',
                 fvtFloat, 2.5, 0, 0,
                 ord(vskDefaultElevation), 0, pkInput);
  AddField(rsDetectionOnBoundary, '', '', '',
                 fvtBoolean, 0, 0, 1,
                 ord(vskDetectionOnBoundary), 0, pkInput);
end;

function TVolumeSensorKind.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(vskZoneLength):
    Result:=FZoneLength;
  ord(vskZoneWidth):
    Result:=FZoneWidth;
  ord(vskZoneHeight):
    Result:=FZoneHeight;
  ord(vskZoneImage):
    Result:=FZoneImage;
  ord(vskZoneForm):
    Result:=FZoneForm;
  ord(vskDefaultElevation):
    Result:=FDefaultElevation;
  ord(vskDetectionOnBoundary):
    Result:=FDetectionOnBoundary;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TVolumeSensorKind.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  ord(vskZoneLength):
    FZoneLength:=Value;
  ord(vskZoneWidth):
    FZoneWidth:=Value;
  ord(vskZoneHeight):
    FZoneHeight:=Value;
  ord(vskZoneImage):
    FZoneImage:=Value;
  ord(vskZoneForm):
    FZoneForm:=Value;
  ord(vskDefaultElevation):
    FDefaultElevation:=Value;
  ord(vskDetectionOnBoundary):
    FDetectionOnBoundary:=Value;
  else
    inherited
  end;
end;

procedure TVolumeSensorKind.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  ord(vskZoneImage):
    theCollection:=(DataModel as IDMElement).Collection[_ElementImage];
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

function TVolumeSensorKind.Get_DetectionZoneImage: IElementImage;
var
  Unk:IUnknown;
begin
  Unk:=FZoneImage;
  Result:=Unk as IElementImage
end;

function TVolumeSensorKind.Get_DefaultElevation: double;
begin
  Result:=FDefaultElevation
end;

function TVolumeSensorKind.Get_DetectionZoneForm: integer;
begin
  Result:=FZoneForm
end;

function TVolumeSensorKind.Get_DetectionOnBoundary: WordBool;
begin
  Result:=FDetectionOnBoundary
end;

{ TVolumeSensorKinds }

function TVolumeSensorKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsVolumeSensorKind;
end;

class function TVolumeSensorKinds.GetElementClass: TDMElementClass;
begin
  Result:=TVolumeSensorKind;
end;

class function TVolumeSensorKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IVolumeSensorKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TVolumeSensorKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
