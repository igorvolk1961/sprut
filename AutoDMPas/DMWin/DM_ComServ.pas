unit DM_ComServ;

interface
uses
  ComServ;

function DM_DllGetClassObject(const CLSID, IID: TGUID; var Obj): HResult; stdcall;
function DM_DllCanUnloadNow: HResult; stdcall;
function DM_DllRegisterServer: HResult; stdcall;
function DM_DllUnregisterServer: HResult; stdcall;

implementation

function DM_DllGetClassObject(const CLSID, IID: TGUID; var Obj): HResult;
begin
  Result:=DllGetClassObject(CLSID, IID, Obj)
end;

function DM_DllCanUnloadNow: HResult;
begin
  Result:=DllCanUnloadNow
end;

function DM_DllRegisterServer: HResult;
begin
  Result:=DllRegisterServer
end;

function DM_DllUnregisterServer: HResult;
begin
  Result:=DllUnregisterServer
end;

end.
