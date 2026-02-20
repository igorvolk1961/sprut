unit TVCameraTypeU;
{Типы  телекамер}
interface
uses
  SecurityEquipmentTypeU, DMElementU, DataModel_TLB, SgdbLib_TLB,
  SafeguardElementTypeU;

type
  TTVCameraType=class(TSecurityEquipmentType, ITVCameraType)
  protected
    procedure Initialize; override;

    class function  GetClassID:integer; override;
    function Get_HasDistantAction:WordBool; override; safecall;
    function Get_CanDetect:WordBool; override; safecall;
  end;

  TTVCameraTypes=class(TSafeguardElementTypes, IDMInstanceSource)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function  Get_InstanceClassID: Integer; safecall;
  end;

implementation

uses
  SafeguardDatabaseConstU, TVCameraKindU;

{ TTVCameraType }

procedure TTVCameraType.Initialize;
begin
  inherited;
  FSubKinds:=DataModel.CreateCollection(_TVCameraKind, Self as IDMElement)
end;

function TTVCameraType.Get_CanDetect: WordBool;
begin
  Result:=True;
end;

class function TTVCameraType.GetClassID: integer;
begin
  Result:=_TVCameraType
end;

function TTVCameraType.Get_HasDistantAction: WordBool;
begin
  Result:=True;
end;

{ TTVCameraTypes }

function TTVCameraTypes.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsTVCameraType;
end;

class function TTVCameraTypes.GetElementClass: TDMElementClass;
begin
  Result:=TTVCameraType;
end;

class function TTVCameraTypes.GetElementGUID: TGUID;
begin
  Result:=IID_ITVCameraType;
end;

function TTVCameraTypes.Get_InstanceClassID: Integer;
begin
  Result:=_TVCamera
end;

end.
