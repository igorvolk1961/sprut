unit TargetKindU;
{Виды целей}
interface
uses
  BoundaryKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TTargetKind=class(TBoundaryKind, ITargetKind, IGuardPostKind, IVisualElement)
  private
    FParameterValues:IDMCollection;
    FImage:Variant;
    FImage2:Variant;
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class procedure MakeFields0; override;
    procedure  GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override; safecall;
    function Get_ParameterValues: IDMCollection; safecall;
    function GetParameterValues: IDMCollection; override;
    function Get_Field(Index: integer): IDMField; override; safecall;
    function Get_FieldCount: integer;  override; safecall;

    function Get_DefenceLevel: integer; safecall;
    function Get_OpenedDefenceState: integer; safecall;
    function Get_HidedDefenceState: integer; safecall;

    function Get_Image: IElementImage; safecall;
    function Get_Image2: IElementImage; safecall;
  public
    procedure Initialize; override;
  end;

  TTargetKinds=class(TDMCollection)
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

{ TTargetKind }

class function TTargetKind.GetClassID: integer;
begin
  Result:=_TargetKind
end;

function TTargetKind.Get_OpenedDefenceState: integer;
begin
  if Parent.ID=1 then
    Result:=GetFieldValue(100)
  else
    Result:=0;
end;

function TTargetKind.Get_HidedDefenceState: integer;
begin
  if Parent.ID=1 then
    Result:=GetFieldValue(101)
  else
    Result:=0;
end;

function TTargetKind.Get_DefenceLevel: integer;
begin
  Result:=0;
  if Parent.ID=1 then
    Result:=GetFieldValue(102)
  else
    Result:=0;
end;

function TTargetKind.Get_Image: IElementImage;
var
  Unk:IUnknown;
begin
  Unk:=FImage;
  Result:=Unk as IElementImage
end;

class function TTargetKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TTargetKind.MakeFields0;
begin
  AddField(rsComment, '', '', '',
           fvtText, 0, 0, 0,
           0, 0, pkComment);
  AddField(rsImage, '', '', '',
                 fvtElement, -1, 0, 0,
                 1, 0, pkView);
  AddField(rsImage2, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(cnstImage2), 0, pkView);
end;

function TTargetKind.GetFieldValue(Code: integer): OleVariant;
var
  j:integer;
begin
  case Code of
  0: Result:=FComment;
  1: Result:=FImage;
  ord(cnstImage2): Result:=FImage2;
  else
    begin
      j:=0;
      while j<ParameterValues.Count do
      if (ParameterValues.Item[j].Ref as IDMField).Code=Code then
        Break
      else
        inc(j);
      if j<ParameterValues.Count then
        Result:=(ParameterValues.Item[j] as IDMParameterValue).Value
      else
        Result:=inherited GetFieldValue(Code)
    end
  end;
end;

procedure TTargetKind.SetFieldValue(Code: integer; Value: OleVariant);
var
  j:integer;
begin
  case Code of
  0: FComment:=Value;
  1: FImage:=Value;
  ord(cnstImage2): FImage2:=Value;
  else
    begin
      j:=0;
      while j<ParameterValues.Count do
        if (ParameterValues.Item[j].Ref as IDMField).Code=Code then
          Break
        else
          inc(j);
      if j<ParameterValues.Count then
        (ParameterValues.Item[j] as IDMParameterValue).Value:=Value
      else
        inherited
    end;
  end;
end;

procedure TTargetKind.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  1, ord(cnstImage2): theCollection:=(DataModel as IDMElement).Collection[_ElementImage];
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

function TTargetKind.Get_ParameterValues: IDMCollection;
begin
  Result:=FParameterValues
end;

function TTargetKind.GetParameterValues: IDMCollection;
begin
  Result:=FParameterValues;
end;

procedure TTargetKind.Initialize;
begin
  FParameterValues:=DataModel.CreateCollection(_SGDBParameterValue, Self as IDMElement);
  inherited;
end;

function TTargetKind.Get_Field(Index: integer): IDMField;
var
  Fields:IDMCollection;
begin
  Fields:=GetFields;
  if Fields<>nil then begin
    if Index<Fields.Count then
      Result:=Fields.Item[Index] as IDMField
    else
      Result:=ParameterValues.Item[Index-Fields.Count].Ref as IDMField
  end else
      Result:=ParameterValues.Item[Index].Ref as IDMField
end;

function TTargetKind.Get_FieldCount: integer;
var
  Fields:IDMCollection;
begin
  Fields:=GetFields;
  if Fields<>nil then
    Result:=Fields.Count+ParameterValues.Count
  else
    Result:=ParameterValues.Count
end;

function TTargetKind.Get_Image2: IElementImage;
var
  Unk:IUnknown;
begin
  Unk:=FImage2;
  Result:=Unk as IElementImage
end;

{ TTargetKinds }

function TTargetKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsTargetKind;
end;

class function TTargetKinds.GetElementClass: TDMElementClass;
begin
  Result:=TTargetKind;
end;

class function TTargetKinds.GetElementGUID: TGUID;
begin
  Result:=IID_ITargetKind;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TTargetKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
