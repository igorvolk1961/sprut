unit FacilityModelU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj, DM_ActiveX,
  Classes, SysUtils, StdVcl,
  DMComObjectU, DataModel_TLB,
  CustomFacilityModelU, FacilityModelLib_TLB;

function GetDataModelClassObject:IDMClassFactory;

type
  TFacilityModelFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;

  TFacilityModel = class(TCustomFacilityModel, IFacilityModel)
  private
  protected
  public
  end;

implementation
{ TFacilityModelFactory }

function GetDataModelClassObject:IDMClassFactory;
begin
  Result:=TFacilityModelFactory.Create(nil) as IDMClassFactory
end;

{ TFacilityModelFactory }

function TFacilityModelFactory.CreateInstance: IUnknown;
begin
  Result:=TFacilityModel.Create(nil) as  IUnknown;
end;

initialization
//  CreateTypedComObjectFactory(TFacilityModel, Class_FacilityModel);
end.
