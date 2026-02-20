unit DM_ActiveX;

interface
uses
  ActiveX, ComObj;

type
  IDM_ConnectionPointContainer=IConnectionPointContainer;
  IDM_ClassFactory=IClassFactory;
  PDM_SafeArray=PSafeArray;

const
  VT_R8=ActiveX.VT_R8;

procedure DM_CoGetClassObject(const clsid: TCLSID; out pv); stdcall;
function DM_SafeArrayCreate(vt: TVarType; cDims: Integer; const rgsabound): PSafeArray; stdcall;
function DM_SafeArrayPutElement(psa: PSafeArray; const rgIndices; const pv): HResult; stdcall;
function DM_SafeArrayDestroy(psa: PSafeArray): HResult; stdcall;

implementation

procedure DM_CoGetClassObject(const clsid: TCLSID; out pv);
begin
  OleCheck(CoGetClassObject(clsid,
          CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER,
          nil, IUnknown, pv))
end;

function DM_SafeArrayCreate(vt: TVarType; cDims: Integer; const rgsabound): PSafeArray;
begin
  Result:=SafeArrayCreate(vt, cDims, rgsabound);
end;

function DM_SafeArrayPutElement(psa: PSafeArray; const rgIndices; const pv): HResult;
begin
  Result:= SafeArrayPutElement(psa, rgIndices, pv)
end;

function DM_SafeArrayDestroy(psa: PSafeArray): HResult;
begin
  Result:=SafeArrayDestroy(psa)
end;

end.
