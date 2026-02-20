unit LightDeviceU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CabelNodeU;

type
  TLightDevice=class(TCabelNode, ILightDevice, IDistantDetectionElement)
  private
    FBackRefs:IDMCollection;
  protected
    procedure Set_SpatialElement(const Value:IDMElement); override; safecall;
    procedure Set_Parent(const Value:IDMElement); override; safecall;
    procedure AfterLoading2; override; safecall;
    class function  GetClassID:integer; override;

    function PointInDetectionZone(X, Y, Z:double; const CRef, ExcludeAreaE:IDMElement):WordBool; virtual; safecall;
    function  GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double; virtual; safecall;
    function Get_BackRefs:IDMCollection; safecall;
    function Get_Observers:IDMCollection; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TLightDevices=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TLightDevice }

class function TLightDevice.GetClassID: integer;
begin
  Result:=_LightDevice;
end;

function TLightDevice.Get_BackRefs: IDMCollection;
begin
  Result:=FBackRefs;
end;

function TLightDevice.GetDistantDetection(const OvercomeMethodU:IUnknown;
                                   DetP, aTime: Double): Double;
begin
  Result:=1
end;

function TLightDevice.PointInDetectionZone(X, Y, Z: double; const CRef, ExcludeAreaE:IDMElement): WordBool;
begin
  Result:=True
end;

procedure TLightDevice.Set_SpatialElement(const Value: IDMElement);
begin
  inherited;
end;

procedure TLightDevice._Destroy;
begin
  inherited;
  FBackRefs:=nil;
end;

procedure TLightDevice.Initialize;
begin
  inherited;
  FBackRefs:=TDMCollection.Create(nil) as IDMCollection;
end;

procedure TLightDevice.Set_Parent(const Value: IDMElement);
begin
  inherited;
end;

procedure TLightDevice.AfterLoading2;
begin
  inherited;
end;

function TLightDevice.Get_Observers: IDMCollection;
begin
  Result:=nil
end;

{ TLightDevices }

class function TLightDevices.GetElementClass: TDMElementClass;
begin
  Result:=TLightDevice;
end;

function TLightDevices.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsLightDevice;
end;

class function TLightDevices.GetElementGUID: TGUID;
begin
  Result:=IID_ILightDevice;
end;

end.
