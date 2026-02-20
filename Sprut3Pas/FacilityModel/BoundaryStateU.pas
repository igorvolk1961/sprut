unit BoundaryStateU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  ElementStateU;

type
  TBoundaryState=class(TElementState, IBoundaryState)
  private
  protected
    class function GetClassID:integer; override;

    function GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;
  end;

  TBoundaryStates=class(TDMCollection)
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

{ TBoundaryState }

function TBoundaryState.GetFieldValue(Code: integer): OleVariant;
begin
//  case Code of
//  else
    Result:=inherited GetFieldValue(Code);
//  end;
end;

procedure TBoundaryState.SetFieldValue(Code:integer; Value:OleVariant);
begin
//  case Code of
//  else
    inherited
//  end;
end;

class function TBoundaryState.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TBoundaryState.MakeFields0;
begin
  inherited;
end;

class function TBoundaryState.GetClassID: integer;
begin
  Result:=_BoundaryState
end;

{ TBoundaryStates }

class function TBoundaryStates.GetElementClass: TDMElementClass;
begin
  Result:=TBoundaryState;
end;

function TBoundaryStates.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsBoundaryState
  else  
    Result:=rsBoundaryStates;
end;

class function TBoundaryStates.GetElementGUID: TGUID;
begin
  Result:=IID_IBoundaryState;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TBoundaryState.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
