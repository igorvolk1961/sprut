unit AccessControlU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DetectionElementU;

type
  TAccessControl=class(TDetectionElement, IAccessControl, IWidthIntf)
  protected
    class function  GetClassID:integer; override;
    function  Get_FieldFormat(Index: Integer): WideString; override; safecall;
    function  WorksInDirection(DirectPathFlag:boolean):WordBool; override; safecall;
// IWidthIntf
    function Get_Width: Double; safecall;
  end;

  TAccessControls=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TAccessControl }

class function TAccessControl.GetClassID: integer;
begin
  Result:=_AccessControl;
end;

function TAccessControl.Get_FieldFormat(Index: Integer): WideString;
var
  Field:IDMField;
begin
  Field:=Get_Field_(Index);
  case Field.Code of
  ord(depDetectionPosition):
    Result:='|'+rsOuter+
            '|'+rsBothSide+
            '|'+rsInner;

  else
    Result:=inherited Get_FieldFormat(Index)
  end;
end;

function TAccessControl.Get_Width: Double;
begin
  if (Ref as IVisualElement).Image<>nil then
    Result:=1 // Для того, чтобы не отрисовывался слой рубежа, на котором помещен объект
  else
    Result:=0;
end;

function TAccessControl.WorksInDirection(DirectPathFlag:boolean): WordBool;
var
  DetectionPosition:integer;
begin
  DetectionPosition:=Get_DetectionPosition;
  case DetectionPosition of
  dpInner:
    Result:=not DirectPathFlag;
  dpOuter:
    Result:=DirectPathFlag;
  else
    Result:=True
  end;
end;

{ TAccessControls }

class function TAccessControls.GetElementClass: TDMElementClass;
begin
  Result:=TAccessControl;
end;

function TAccessControls.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsAccessControl;
end;

class function TAccessControls.GetElementGUID: TGUID;
begin
  Result:=IID_IAccessControl;
end;

end.
