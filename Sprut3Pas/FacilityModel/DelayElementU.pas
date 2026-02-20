unit DelayElementU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardElementU;

type
  TDelayElement=class(TSafeguardElement)
  private
    FUserDefinedDelayTimeDispersionRatio:boolean;
    FDelayTimeDispersionRatio:double;
  protected
    class procedure MakeFields0; override;
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    function  FieldIsVisible(Code:integer):WordBool; override; safecall;

    procedure CalcDelayTime(const TacticU:IUnknown;
           out DelayTime, DelayTimeDispersion:double); override; safecall;
  public
  end;

implementation

uses
  FacilityModelConstU;

{ TDelayElement }

function TDelayElement.FieldIsVisible(Code: integer): WordBool;
begin
  case Code of
  ord(deDeviceState0):
    Result:=True;
  ord(deDeviceState1):
    Result:=False;
  ord(deUserDefinedDelayTime):
    Result:=True;
  ord(deDelayTime):
    Result:=Get_UserDefinedDelayTime;
  ord(deUserDefinedDelayTimeDispersionRatio):
    Result:=True;
  ord(deDelayTimeDispersionRatio):
    Result:=FUserDefinedDelayTimeDispersionRatio;
  ord(blpUserDefinedDetectionProbability):
    Result:=True;
  ord(blpDetectionProbability):
    Result:=Get_UserDefinedDetectionProbability;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

function TDelayElement.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(deUserDefinedDelayTime):
    Result:=FUserDefinedDelayTime;
  ord(deDelayTime):
    Result:=FDelayTime;
  ord(deUserDefinedDelayTimeDispersionRatio):
    Result:=FUserDefinedDelayTimeDispersionRatio;
  ord(deDelayTimeDispersionRatio):
    Result:=FDelayTimeDispersionRatio;
  ord(blpUserDefinedDetectionProbability):
    Result:=FUserDefinedDetectionProbability;
  ord(blpDetectionProbability):
    Result:=FDetectionProbability;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TDelayElement.SetFieldValue(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(deUserDefinedDelayTime):
    begin
      FUserDefinedDelayTime:=Value;
      UpdateUserDefinedElements(FUserDefinedDelayTime);
    end;
  ord(deDelayTime):
    FDelayTime:=Value;
  ord(deUserDefinedDelayTimeDispersionRatio):
    begin
      FUserDefinedDelayTimeDispersionRatio:=Value;
      UpdateUserDefinedElements(FUserDefinedDelayTimeDispersionRatio);
    end;
  ord(deDelayTimeDispersionRatio):
    FDelayTimeDispersionRatio:=Value;
  ord(blpUserDefinedDetectionProbability):
    begin
      FUserDefinedDetectionProbability:=Value;
      UpdateUserDefinedElements(FUserDefinedDetectionProbability);
    end;
  ord(blpDetectionProbability):
    FDetectionProbability:=Value;
  else
    inherited
  end;
end;

class procedure TDelayElement.MakeFields0;
begin
  inherited;
  AddField(rsUserDefinedDelayTime, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(deUserDefinedDelayTime), 0, pkUserDefined);
  AddField(rsDelayTime, '%9.0f', '', '',
                 fvtFloat,   0, 0, InfinitValue,
                 ord(deDelayTime), 0, pkUserDefined);
  AddField(rsUserDefinedDelayTimeDispersionRatio, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(deUserDefinedDelayTimeDispersionRatio), 0, pkUserDefined);
  AddField(rsDelayTimeDispersionRatio, '%.3f', '', '',
                 fvtFloat,   0.2, 0, 1,
                 ord(deDelayTimeDispersionRatio), 0, pkUserDefined);
  AddField(rsUserDefinedDetectionProbability, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(blpUserDefinedDetectionProbability), 0, pkUserDefined);
  AddField(rsDetectionProbability, '%.3f', '', '',
                 fvtFloat,   0, 0, 1,
                 ord(blpDetectionProbability), 0, pkUserDefined);
end;

procedure TDelayElement.CalcDelayTime(const TacticU:IUnknown;
             out DelayTime, DelayTimeDispersion:double);
begin
  if Ref=nil then Exit;
  inherited;
  if FUserDefinedDelayTimeDispersionRatio then
    DelayTimeDispersion:=sqr(FDelayTimeDispersionRatio*DelayTime);
end;

end.
