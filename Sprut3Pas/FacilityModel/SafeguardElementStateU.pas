unit SafeguardElementStateU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  ElementStateU;

type
  TSafeguardElementState=class(TElementState, ISafeguardElementState)
  private
    FDeviceState0:Variant;
    FDeviceState1:Variant;
  protected
    class function GetClassID:integer; override;
    procedure Set_Parent(const Value:IDMElement); override;
    function  GetFieldValue(Index: integer): OleVariant; override;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override;
    class function GetFields: IDMCollection; override;
    class procedure MakeFields0; override;

    procedure AfterLoading2; override; safecall;

    function Get_DeviceState0: IDMElement; safecall;
    procedure Set_DeviceState0(const Value: IDMElement); safecall;
    function Get_DeviceState1: IDMElement; safecall;
    procedure Set_DeviceState1(const Value: IDMElement); safecall;

    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;

  end;

  TSafeguardElementStates=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TSafeguardElementState }

procedure TSafeguardElementState.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  SafeguardElementType:ISafeguardElementType;
  aDocument:IDMDocument;
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  theCollection:=nil;
  aDocument:=DataModel.Document as IDMDocument;
  if (aDocument.State and dmfNotEmpty)=0 then Exit;
  if Parent=nil then Exit;
  if Parent.Ref=nil then Exit;
  SafeguardElementType:=Parent.Ref.Parent as ISafeguardElementType;
  case Code of
  ord(sesDeviceState0),
  ord(sesDeviceState1):
    theCollection:=SafeguardElementType.DeviceStates;
  else
    begin
      inherited;
      Exit;
    end;
  end;
  if aCollection=nil then
    aCollection:=theCollection
  else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;
end;

function TSafeguardElementState.Get_DeviceState0: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FDeviceState0;
  Result:=Unk as IDMElement
end;

function TSafeguardElementState.Get_DeviceState1: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FDeviceState1;
  Result:=Unk as IDMElement
end;

procedure TSafeguardElementState.Set_DeviceState0(
  const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FDeviceState0:=Unk;
end;

procedure TSafeguardElementState.Set_DeviceState1(
  const Value: IDMElement);
var
  Unk:IUnknown;
begin
  Unk:=Value as IUnknown;
  FDeviceState1:=Unk;
end;

function TSafeguardElementState.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  ord(sesDeviceState0):
    Result:=FDeviceState0;
  ord(sesDeviceState1):
    Result:=FDeviceState1;
  else
    Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TSafeguardElementState.SetFieldValue(Index:integer; Value:OleVariant);
begin
  case Index of
  ord(sesDeviceState0):
    begin
      FDeviceState0:=Value;
      FDeviceState1:=Value;
    end;
  ord(sesDeviceState1):
    FDeviceState1:=Value;
  else
    inherited
  end;
end;

class function TSafeguardElementState.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TSafeguardElementState.MakeFields0;
begin
  AddField(rsDeviceState0, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(sesDeviceState0), 0, pkInput);
  AddField(rsDeviceState1, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(sesDeviceState1), 0, pkInput);
  inherited;
end;

procedure TSafeguardElementState.Set_Parent(const Value: IDMElement);
var
  SafeguardElementType:ISafeguardElementType;
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Parent=nil then Exit;
  SafeguardElementType:=Parent.Ref.Parent as ISafeguardElementType;
  if SafeguardElementType.DeviceStates.Count>0 then begin
    Set_DeviceState0(SafeguardElementType.DeviceStates.Item[0] as IDMElement);
    Set_DeviceState1(SafeguardElementType.DeviceStates.Item[0] as IDMElement);
  end;
end;

class function TSafeguardElementState.GetClassID: integer;
begin
  Result:=_SafeguardElementState
end;

procedure TSafeguardElementState.AfterLoading2;
var
  SafeguardElementType:ISafeguardElementType;
begin
  inherited;
  if Parent=nil then Exit;
  if Get_DeviceState1<>nil then Exit;
  
  SafeguardElementType:=Parent.Ref.Parent as ISafeguardElementType;
  if SafeguardElementType.DeviceStates.Count>0 then
    Set_DeviceState1(SafeguardElementType.DeviceStates.Item[0] as IDMElement);
end;

{ TSafeguardElementStates }

function TSafeguardElementStates.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsSafeguardElementState
  else
    Result:=rsSafeguardElementStates
end;

class function TSafeguardElementStates.GetElementClass: TDMElementClass;
begin
  Result:=TSafeguardElementState
end;

class function TSafeguardElementStates.GetElementGUID: TGUID;
begin
  Result:=IID_ISafeguardElementState
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TSafeguardElementState.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
