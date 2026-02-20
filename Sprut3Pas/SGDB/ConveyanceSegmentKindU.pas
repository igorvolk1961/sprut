unit ConveyanceSegmentKindU;
{ Виды Транспортировок   }
interface
uses
  SecuritySubjectKindU, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TConveyanceSegmentKind=class(TSecuritySubjectKind, IConveyanceSegmentKind)
  protected
    class function  GetClassID:integer; override;
  end;

  TConveyanceSegmentKinds=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TConveyanceSegmentKind }

class function TConveyanceSegmentKind.GetClassID: integer;
begin
  Result:=_ConveyanceSegmentKind
end;

{ TConveyanceSegmentKinds }

function TConveyanceSegmentKinds.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsConveyanceSegmentKind;
end;

class function TConveyanceSegmentKinds.GetElementClass: TDMElementClass;
begin
  Result:=TConveyanceSegmentKind;
end;

class function TConveyanceSegmentKinds.GetElementGUID: TGUID;
begin
  Result:=IID_IConveyanceSegmentKind;
end;


end.
