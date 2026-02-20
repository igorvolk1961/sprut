unit SpruterAppU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, Spruter_TLB, StdVcl, DMServer_TLB, DMDraw_TLB,
  SpatialModelLib_TLB;

type
  TSpruterApp = class(TAutoObject, ISpruterApp)
  protected
    function  Get_DMEditorX: IUnknown; safecall;
  end;

implementation

uses
  ComServ,
  SpruterFrm;

function TSpruterApp.Get_DMEditorX: IUnknown;
begin
//  Result:=Form1.FacilityEditor as IUnknown
  fmMainSprut.DMEditor.QueryInterface(IUnknown, Result)
end;

initialization
  TAutoObjectFactory.Create(ComServer, TSpruterApp, Class_SpruterApp,
    ciMultiInstance, tmApartment);
end.
