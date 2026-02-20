unit DMComObjectU;

interface
uses
  DM_Windows, DM_ComObj,
  Classes, SysUtils, Math, 
  DataModel_TLB, Variants;

type
  TDMComObjectClass=class of TDMComObject;

  TDMComObject=class(TObject, IUnknown, IRefCounter)
  protected
    FOwner:pointer;
// реализация интерфейса  IUnknown
    function IUnknown.QueryInterface = QueryInterface;
    function IUnknown._AddRef = _AddRef;
    function IUnknown._Release = _Release;
    { IUnknown methods for other interfaces }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; virtual; stdcall;
    function _Release: Integer; virtual; stdcall;

// реализация интерфейса  IDispatch
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; virtual; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; virtual; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; stdcall;

//  защищенные методы
    procedure Clear; virtual; safecall;
    procedure Set_DataModel(const Value: IDataModel); virtual; safecall;
    function  Get_DataModel: IDataModel; virtual; safecall;
//    function  GetAutoFactory:TAutoObjectFactory; virtual;
//  защищенные свойства

    procedure Initialize; virtual;
//  IRefCounter
    function Get_RefCount: Integer; safecall;
  public
    FRefCount: Integer;
    constructor Create(aDataModel: IDataModel);
    destructor Destroy; override;
  end;

implementation
uses
  ComServ;


{ TDMComObject }

function TDMComObject._AddRef: Integer;
begin
  inc(FRefCount);
  Result := FRefCount;
end;

function TDMComObject._Release: Integer;
begin
  try
  dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then begin
    Destroy;
  end;
  except
    raise
  end;
end;

constructor TDMComObject.Create(aDataModel: IDataModel);
begin
  FRefCount := 1;
  FOwner:=pointer(aDataModel);
  Initialize;
  Dec(FRefCount);
end;

function TDMComObject.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  try
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
  except
    raise
  end;
end;

procedure TDMComObject.Initialize;
begin
end;

destructor TDMComObject.Destroy;
begin
  try
  inherited;
  except
    raise
  end;  
end;

procedure TDMComObject.Clear;
begin
  FOwner:=nil;
end;

function TDMComObject.Get_DataModel: IDataModel;
begin
  Result:=IDataModel(FOwner);
end;

function TDMComObject.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDMComObject.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := DISP_E_BADINDEX;
end;

function TDMComObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 1;
  Result := S_OK;
end;

function TDMComObject.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  Result := 0
end;

procedure TDMComObject.Set_DataModel(const Value: IDataModel);
begin
  FOwner:=pointer(Value)
end;

function TDMComObject.Get_RefCount: Integer;
begin
  Result:=FRefCount
end;

end.
