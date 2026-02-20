unit ElementStateU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type
  TElementState=class(TDMElement, IElementState)
  private
    FUserDefinedDelayTime:boolean;
    FDelayTime:double;
    FDelayTimeDispersion:double;
    FUserDefinedDetectionProbability:boolean;
    FDetectionProbability:double;
  protected
    class procedure MakeFields0; override;
    procedure Set_Parent(const Value:IDMElement); override; safecall;

    function Get_DelayTime: double; safecall;
    function Get_DetectionProbability: double; safecall;
    function Get_DelayTimeDispersion: double; safecall;
    function Get_UserDefinedDelayTime: WordBool; safecall;
    function Get_UserDefinedDetectionProbability: WordBool; safecall;
    procedure Set_DelayTime(Value: double); safecall;
    procedure Set_DelayTimeDispersion(Value: double); safecall;
    procedure Set_DetectionProbability(Value: double); safecall;
    function Get_Name:WideString; override;
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
  end;

  TElementStates=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;


implementation
uses
  FacilityModelConstU;

{ TElementState }

function TElementState.Get_Name: WideString;
var S:string;
begin
  S:=inherited Get_Name;
  if Parent<>nil then
    Result:=S+' ('+Parent.Name+', '+Ref.Name+')'
end;

function TElementState.Get_DelayTime: double;
begin
  Result:=FDelayTime
end;

function TElementState.Get_DetectionProbability: double;
begin
  Result:=FDetectionProbability
end;

function TElementState.Get_UserDefinedDelayTime: WordBool;
begin
  Result:=FUserDefinedDelayTime
end;

function TElementState.Get_UserDefinedDetectionProbability: WordBool;
begin
  Result:=FUserDefinedDetectionProbability
end;

procedure TElementState.Set_DelayTime(Value: double);
begin
  FDelayTime:=Value
end;

procedure TElementState.Set_DetectionProbability(
  Value: double);
begin
  FDetectionProbability:=Value
end;

function TElementState.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(esUserDefinedDelayTime):
    Result:=FUserDefinedDelayTime;
  ord(esDelayTime):
    Result:=FDelayTime;
  ord(esUserDefinedDetectionProbability):
    Result:=FUserDefinedDetectionProbability;
  ord(esDetectionProbability):
    Result:=FDetectionProbability;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TElementState.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(esUserDefinedDelayTime):
    FUserDefinedDelayTime:=Value;
  ord(esDelayTime):
    FDelayTime:=Value;
  ord(esUserDefinedDetectionProbability):
    FUserDefinedDetectionProbability:=Value;
  ord(esDetectionProbability):
    FDetectionProbability:=Value;
  else
    inherited
  end;
end;

class procedure TElementState.MakeFields0;
begin
  inherited;
  AddField(rsUserDefinedDelayTime, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(esUserDefinedDelayTime), 0, pkUserDefined);
  AddField(rsDelayTime, '%0.1f', '', '',
                 fvtFloat,   0, 0, InfinitValue,
                 ord(esDelayTime), 2, pkUserDefined);
  AddField(rsUserDefinedDetectionProbability, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(esUserDefinedDetectionProbability), 0, pkUserDefined);
  AddField(rsDetectionProbability, '%0.4f', '', '',
                  fvtFloat, 0, 0, 1,
                 ord(esDetectionProbability), 2, pkUserDefined);
end;

function TElementState.Get_DelayTimeDispersion: double;
begin
  Result:=FDelayTimeDispersion
end;

procedure TElementState.Set_DelayTimeDispersion(Value: double);
begin
  FDelayTimeDispersion:=Value
end;

procedure TElementState.Set_Parent(const Value: IDMElement);
var
  RefPathElement:IRefPathElement;
begin
  if (Value<>nil) and
     (Value.QueryInterface(IRefPathElement,RefPathElement)=0)  then begin
    Set_Parent(Value.Ref);
    Exit;
  end;
  inherited;
end;

{ TElementStates }

class function TElementStates.GetElementClass: TDMElementClass;
begin
  Result:=TElementState;
end;

class function TElementStates.GetElementGUID: TGUID;
begin
  Result:=IID_IElementState;
end;

end.
