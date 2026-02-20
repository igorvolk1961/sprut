unit ActiveSafeguardU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DelayElementU;

type
  TActiveSafeguard=class(TDelayElement, IActiveSafeguard)
  private
  protected
    class function  GetClassID:integer; override;
    function  ShowInLayerName:WordBool; override;
  end;

  TActiveSafeguards=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TActiveSafeguard }

class function TActiveSafeguard.GetClassID: integer;
begin
  Result:=_ActiveSafeguard;
end;

function TActiveSafeguard.ShowInLayerName: WordBool;
begin
  Result:=True;
end;

{ TActiveSafeguards }

class function TActiveSafeguards.GetElementClass: TDMElementClass;
begin
  Result:=TActiveSafeguard;
end;

function TActiveSafeguards.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsActiveSafeguard
end;

class function TActiveSafeguards.GetElementGUID: TGUID;
begin
  Result:=IID_IActiveSafeguard
end;

end.
