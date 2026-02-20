unit BoundaryLayerStateU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  ElementStateU;

type
  TBoundaryLayerState=class(TElementState, IBoundaryLayerState)
  private
  protected
    class function GetFields: IDMCollection; override;
    class function GetClassID:integer; override;
//    class procedure MakeFields0; override;
  end;

  TBoundaryLayerStates=class(TDMCollection)
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

{ TBoundaryLayerState }

class function TBoundaryLayerState.GetClassID: integer;
begin
  Result:=_BoundaryLayerState
end;

class function TBoundaryLayerState.GetFields: IDMCollection;
begin
  Result:=FFields
end;

{ TBoundaryLayerStates }

class function TBoundaryLayerStates.GetElementClass: TDMElementClass;
begin
  Result:=TBoundaryLayerState;
end;

function TBoundaryLayerStates.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsBoundaryLayerState
  else  
    Result:=rsBoundaryLayerStates;
end;

class function TBoundaryLayerStates.GetElementGUID: TGUID;
begin
  Result:=IID_IBoundaryLayerState;
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TBoundaryLayerState.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
