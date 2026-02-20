unit WarriorAttributeU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TWarriorAttribute=class(TDMElement)
  private
    FComment:string;
  protected
    function Get_Name:WideString; override;

    procedure Set_Parent(const Value:IDMElement); override;

    class procedure MakeFields0; override;
    class function GetFields:IDMCollection; override;
    function GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function GetDeletedObjectsClassID: integer;override; 
  end;

implementation
uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TWarriorAttribute }

class procedure TWarriorAttribute.MakeFields0;
begin
  inherited;
  AddField(rsComment, '', '', 'Comment',
           fvtText, 0, 0, 0,
           cnstComment, 0, pkComment);
end;

function TWarriorAttribute.Get_Name: WideString;
var S:string;
begin
  S:=Inherited Get_Name;
  if Parent<>nil then
    Result:=S+' '+SuffixDivider+Parent.Name
  else
    Result:=S;
end;

function TWarriorAttribute.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cnstComment):
    Result:=FComment;
  else
    Result:=inherited Get_FieldValue(Code);
  end;
end;

procedure TWarriorAttribute.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(cnstComment):
    FComment:=Value;
  else
    inherited;
  end;
end;

class function TWarriorAttribute.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TWarriorAttribute.GetDeletedObjectsClassID: integer;
begin
  Result:=_Updating;
end;

procedure TWarriorAttribute.Set_Parent(const Value: IDMElement);
var
  AdversaryVariant:IAdversaryVariant;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IAdversaryVariant,AdversaryVariant)=0)  then
    Set_Parent(AdversaryVariant.AdversaryGroups.Item[0])
  else
    inherited;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TWarriorAttribute.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
