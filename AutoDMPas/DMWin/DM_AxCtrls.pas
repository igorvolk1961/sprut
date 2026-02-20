unit DM_AxCtrls;

interface
uses
  AxCtrls, ActiveX, ComObj, ComServ, Controls;

type
  TDM_ConnectionPoint=TConnectionPoint;
  TDM_ConnectionPoints=TConnectionPoints;
  TDM_ActiveForm=TActiveForm;

const
  ckSingle=AxCtrls.ckSingle;

procedure CreateActiveFormFactory(WinControlClass: TWinControlClass; const ClassID: TGUID);

implementation

procedure CreateActiveFormFactory(WinControlClass: TWinControlClass; const ClassID: TGUID);
begin
  TActiveFormFactory.Create( ComServer,
      TActiveFormControl,
      WinControlClass,
      ClassID, 1, '',
      OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
      tmApartment);
end;

end.
