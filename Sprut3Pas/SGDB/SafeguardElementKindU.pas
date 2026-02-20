unit SafeguardElementKindU;

interface
uses
  ModelElementKindU, DMElementU, DataModel_TLB, SgdbLib_TLB, DMServer_TLB;

type
  TSafeguardElementKind=class(TModelElementKind, ISafeguardElementKind,
            IMethodDimItemSource, IPrice, IVisualElement)
  private
    FParameterValues:IDMCollection;
    FImage:Variant;
    FImage2:Variant;
    FMainDeviceState:Variant;

    FPrice:double;
    FPriceDimension:Integer;
    FInstallCoeff: double;
    FKindID:integer;
  protected
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class procedure MakeFields0; override;
    class procedure MakeFields1; override;
    function Get_Field(Index: integer): IDMField; override; safecall;
    function Get_FieldCount: integer;  override; safecall;
    function Get_ParameterValues: IDMCollection; safecall;
    function Get_Image: IElementImage; safecall;
    function Get_Image2: IElementImage; safecall;
    function Get_MainDeviceState:IDMElement; safecall;
    class function GetFields:IDMCollection; override;
    function  GetMethodDimItemIndex(Kind, Code: Integer;
                  const DimItems: IDMCollection;
                  const ParamE:IDMElement;
                  ParamF:double): Integer; virtual; safecall;

    procedure  GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override; safecall;
    function  Get_KindID:integer; safecall;
    
// защищенные методы
    function GetParameterValues: IDMCollection; override;
    procedure Initialize; override;

// методы IPrice
    function  Get_Price: double; safecall;
    function  Get_PriceDimension: Integer; safecall;
    function  Get_InstallCoeff: double; safecall;

  end;

implementation
uses
  SafeguardDatabaseConstU, SGDBParameterValueU;

var
  FFields:IDMCollection;

{ TSafeguardElementKind }

procedure TSafeguardElementKind.Initialize;
begin
  FParameterValues:=DataModel.CreateCollection(_SGDBParameterValue, Self as IDMElement);
  inherited;
end;

procedure TSafeguardElementKind.GetFieldValueSource(
  Code: integer; var aCollection: IDMCollection);
var
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  case Code of
  1, ord(cnstImage2): theCollection:=(DataModel as IDMElement).Collection[_ElementImage];
  ord(cnstMainDeviceState): theCollection:=(DataModel as IDMElement).Collection[_DeviceState];
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

function TSafeguardElementKind.GetParameterValues: IDMCollection;
begin
  Result:=FParameterValues;
end;

function TSafeguardElementKind.Get_Field(Index: integer): IDMField;
var
  Fields:IDMCollection;
begin
  Fields:=GetFields;
  if Fields<>nil then begin
    if Index<Fields.Count then
      Result:=Fields.Item[Index] as IDMField
    else
      Result:=ParameterValues.Item[Index-Fields.Count].Ref as IDMField
  end else
      Result:=ParameterValues.Item[Index].Ref as IDMField
end;

function TSafeguardElementKind.Get_FieldCount: integer;
var
  Fields:IDMCollection;
begin
  Fields:=GetFields;
  if Fields<>nil then
    Result:=Fields.Count+ParameterValues.Count
  else
    Result:=ParameterValues.Count
end;

function TSafeguardElementKind.GetFieldValue(Code: integer): OleVariant;
var
  j:integer;
begin
  case Code of
  1:
    Result:=FImage;
  cnstPrice:
    Result:=FPrice;
  cnstPriceDimension:
    Result:=FPriceDimension;
  cnstInstallCoeff:
    Result:=FInstallCoeff;
  cnstImage2:
    Result:=FImage2;
  cnstMainDeviceState:
    Result:=FMainDeviceState;
  cnstKindID:
    Result:=FKindID;
  else
    begin
      j:=0;
      while j<ParameterValues.Count do
      if (ParameterValues.Item[j].Ref as IDMField).Code=Code then
        Break
      else
        inc(j);
      if j<ParameterValues.Count then
        Result:=(ParameterValues.Item[j] as IDMParameterValue).Value
      else
        Result:=inherited GetFieldValue(Code)
    end
  end
end;

procedure TSafeguardElementKind.SetFieldValue(Code: integer;
  Value: OleVariant);
var
  j:integer;
begin
  case Code of
  1:
    FImage:=Value;
  cnstPrice:
    FPrice:=Value;
  cnstPriceDimension:
    FPriceDimension:=Value;
  cnstInstallCoeff:
    FInstallCoeff:=Value;
  cnstImage2:
    FImage2:=Value;
  cnstMainDeviceState:
    FMainDeviceState:=Value;
  cnstKindID:
    FKindID:=Value;
  else
    begin
      j:=0;
      while j<ParameterValues.Count do
        if (ParameterValues.Item[j].Ref as IDMField).Code=Code then
          Break
        else
          inc(j);
      if j<ParameterValues.Count then
        (ParameterValues.Item[j] as IDMParameterValue).Value:=Value
      else
        inherited
    end;
  end;
end;

class procedure TSafeguardElementKind.MakeFields0;
var S:WideString;
begin
  inherited;
  AddField(rsImage, '', '', '',
                 fvtElement, -1, 0, 0,
                 1, 0, pkView);
  AddField(rsImage2, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(cnstImage2), 0, pkView);
  AddField(rsMainDeviceState, '', '', '',
                 fvtElement, -1, 0, 0,
                 ord(cnstMainDeviceState), 0, pkAdditional);
  AddField(rsPrice, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 cnstPrice, 0, pkPrice);
 S:='|'+rsPerPieceR+
    '|'+rsPerPieceU+
    '|'+rsPerLengthR+
    '|'+rsPerLengthU+
    '|'+rsPerSquareR+
    '|'+rsPerSquareU+
    '|'+rsPerVolumeR+
    '|'+rsPerVolumeU+
    '|'+rsPerComplectR+
    '|'+rsPerComplectU;

  AddField(rsPriceDimension, S, '', '',
                 fvtChoice, 0, 0, 0,
                 cnstPriceDimension, 0, pkPrice);
  AddField(rsInstallCoeff, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 cnstInstallCoeff, 0, pkPrice);
end;

function TSafeguardElementKind.Get_Image: IElementImage;
var
  Unk:IUnknown;
begin
  Unk:=FImage;
  Result:=Unk as IElementImage
end;

class function TSafeguardElementKind.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TSafeguardElementKind.Get_ParameterValues: IDMCollection;
begin
  Result:=FParameterValues
end;

function TSafeguardElementKind.GetMethodDimItemIndex(Kind, Code: Integer;
                    const DimItems: IDMCollection;
                    const ParamE:IDMElement;
                          ParamF:double): Integer;
begin
  case Kind of
  sdKindID:
    Result:=Get_KindID
  else
    Result:=-1
  end;
end;

function TSafeguardElementKind.Get_Price: double;
begin
  Result:=FPrice
end;

function TSafeguardElementKind.Get_PriceDimension: Integer;
begin
  Result:=FPriceDimension
end;

function TSafeguardElementKind.Get_InstallCoeff: double;
begin
  Result:=FInstallCoeff
end;

function TSafeguardElementKind.Get_Image2: IElementImage;
var
  Unk:IUnknown;
begin
  Unk:=FImage2;
  Result:=Unk as IElementImage
end;

function TSafeguardElementKind.Get_MainDeviceState: IDMElement;
var
  Unk:IUnknown;
begin
  Unk:=FMainDeviceState;
  Result:=Unk as IDMElement
end;

function TSafeguardElementKind.Get_KindID: integer;
begin
  Result:=FKindID
end;

class procedure TSafeguardElementKind.MakeFields1;
begin
  inherited;
  AddField(rsKindID, '', '', '',
           fvtInteger, 0, 0, 0,
           cnstKindID, 0, pkInput);
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TSafeguardElementKind.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
