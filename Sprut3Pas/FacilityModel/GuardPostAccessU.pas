unit GuardPostAccessU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  AccessU;

type
  TGuardPostAccess=class(TAccess, IGuardPostAccess)
  private
  protected
    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
    procedure Set_Parent(const Value:IDMElement); override;

  end;

  TGuardPostAccesses=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU,
  FacilityStateU;

var
  FFields:IDMCollection;

{ TGuardPostAccess }

class function TGuardPostAccess.GetClassID: integer;
begin
  Result:=_GuardPostAccess;
end;

class function TGuardPostAccess.GetFields: IDMCollection;
begin
  REsult:=FFields
end;

class procedure TGuardPostAccess.MakeFields0;
var
  S:WideString;
begin
  S:='|'+rsLimitedGuardPostAccess+
     '|'+rsFullGuardPostAccess;
  AddField(rsAccessType, S, '', '',
                 fvtChoice, 0, 0, 0,
                 0, 0, pkInput);
end;

procedure TGuardPostAccess.Set_Parent(const Value: IDMElement);
var
  AdversaryVariant:IAdversaryVariant;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IAdversaryVariant,AdversaryVariant)=0)  then
    Set_Parent(AdversaryVariant.AdversaryGroups.Item[0])
  else
    inherited;
end;

{ TGuardPostAccesses }

class function TGuardPostAccesses.GetElementClass: TDMElementClass;
begin
  Result:=TGuardPostAccess;
end;


function TGuardPostAccesses.Get_ClassAlias(Index: integer): WideString;
begin
    Result:=rsGuardPostAccess
end;

class function TGuardPostAccesses.GetElementGUID: TGUID;
begin
  Result:=IID_IGuardPostAccess;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TGuardPostAccess.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
