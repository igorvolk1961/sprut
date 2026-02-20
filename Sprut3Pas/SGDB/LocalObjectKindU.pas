unit LocalObjectKindU;

interface
uses
  BoundaryKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TLocalObjectKind=class(TBoundaryKind, ILocalObjectKind)
  private
    FImage:Variant;
    FClimbUpVelocity:double;
    FClimbDownVelocity:double;
  protected
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    procedure  GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override; safecall;
    function Get_ClimbDownVelocity: double; safecall;
    function Get_ClimbUpVelocity: double; safecall;
    function Get_Image: IElementImage; safecall;
  end;

implementation
uses
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;

{ TLocalObjectKind }

function TLocalObjectKind.Get_ClimbDownVelocity: double;
begin
  Result:=FClimbDownVelocity
end;

function TLocalObjectKind.Get_ClimbUpVelocity: double;
begin
  Result:=FClimbUpVelocity
end;

class function TLocalObjectKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TLocalObjectKind.MakeFields0;
begin
  AddField(rsImage, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(lokImage), 0, pkInput);
  AddField(rsClimbUpVelocity, '%5.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(lokClimbUpVelocity), 0, pkInput);
  AddField(rsClimbDownVelocity, '%5.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(lokClimbDownVelocity), 0, pkInput);
end;

function TLocalObjectKind.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(lokImage):
    Result:=FImage;
  ord(lokClimbUpVelocity):
    Result:=FClimbUpVelocity;
  ord(lokClimbDownVelocity):
    Result:=FClimbDownVelocity;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TLocalObjectKind.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(lokImage):
    FImage:=Value;
  ord(lokClimbUpVelocity):
    FClimbUpVelocity:=Value;
  ord(lokClimbDownVelocity):
    FClimbDownVelocity:=Value;
  else
    inherited;
  end;
end;

function TLocalObjectKind.Get_Image: IElementImage;
var
  Unk:IUnknown;
begin
  Unk:=FImage;
  Result:=Unk as IElementImage
end;

procedure TLocalObjectKind.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  1: theCollection:=(DataModel as IDMElement).Collection[_ElementImage];
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

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TLocalObjectKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
