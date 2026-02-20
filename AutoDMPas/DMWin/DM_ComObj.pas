unit DM_ComObj;

interface
uses
  DM_Windows,
  ComObj, ComServ;

type

  TDMTypedComObject=class(TTypedComObject)
  protected
    FDataModel:pointer;
    procedure Clear; virtual; safecall;
    function  Get_DataModel: IUnknown; safecall;

    constructor Create(aDataModel: IUnknown);

    function  GetAutoFactory:TAutoObjectFactory; virtual;

    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; virtual; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; virtual; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; stdcall;
  end;

  TDM_AutoObject=TAutoObject;
  EDM_OleException=EOleException;

  procedure CreateAutoObjectFactory(AutoClass: TAutoClass; const ClassID: TGUID);
  procedure CreateTypedComObjectFactory(TypedComClass: TTypedComClass; const ClassID: TGUID);

  function DM_ProgIDToClassID(const ProgID: string): TGUID;
  function DM_CreateOleObject(const ClassName: string): IDispatch;

implementation

{ TDMTypedComObject }

procedure TDMTypedComObject.Clear;
begin
  FDataModel:=nil;
end;

constructor TDMTypedComObject.Create(aDataModel: IUnknown);
begin
  inherited Create;
  FDataModel:=pointer(aDataModel);
end;

function TDMTypedComObject.Get_DataModel: IUnknown;
begin
  Result:=IUnknown(FDataModel);
end;

function TDMTypedComObject.GetAutoFactory: TAutoObjectFactory;
begin
  Result:=nil
end;

function TDMTypedComObject.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDMTypedComObject.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
    Result := DISP_E_BADINDEX;
end;

function TDMTypedComObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 1;
  Result := S_OK;
end;

function TDMTypedComObject.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  Result:=0;
end;

function DM_ProgIDToClassID(const ProgID: string): TGUID;
begin
  Result:=ProgIDToClassID(ProgID);
end;

function DM_CreateOleObject(const ClassName: string): IDispatch;
begin
  Result:=CreateOleObject(ClassName)
end;

procedure CreateAutoObjectFactory(AutoClass: TAutoClass; const ClassID: TGUID);
begin
  TAutoObjectFactory.Create(ComServer, AutoClass, ClassID,
    ciSingleInstance, tmApartment);
end;

procedure CreateTypedComObjectFactory(TypedComClass: TTypedComClass; const ClassID: TGUID);
begin
  TTypedComObjectFactory.Create(ComServer, TypedComClass, ClassID,
    ciMultiInstance, tmApartment);
end;

end.
