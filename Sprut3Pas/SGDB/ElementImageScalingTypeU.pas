unit ElementImageScalingTypeU;

interface
uses
  Classes,
  SafeguardDatabaseConsts,
  SpatialModels, DataModels;

type

  TElementImageScalingType=class(TNamedDMElement, IElementImageScalingType)
  protected
    Code:TElementImageScalingTypeCode;
  end;

  TElementImageScalingTypes=class(TDMElements)
  protected
    class function Get_ElementClass:TDMElementClass; override;
  protected
    constructor Create(aDataModel:TDataModel); override;
  end;

implementation

{ TElementImageScalingTypes }

constructor TElementImageScalingTypes.Create(aDataModel:TDataModel);
var
  aElementImageScalingType:TElementImageScalingType;
begin
  inherited;
  aElementImageScalingType:=TElementImageScalingType(CreateElement(False));
  Add(aElementImageScalingType);
  aElementImageScalingType.Ident:=rsElementImageNoScale;
  aElementImageScalingType.Code:=eitNoScaling;
  aElementImageScalingType.ID:=ord(eitNoScaling);

  aElementImageScalingType:=TElementImageScalingType(CreateElement(False));
  Add(aElementImageScalingType);
  aElementImageScalingType.Ident:=rsElementImageScale;
  aElementImageScalingType.Code:=eitScaling;
  aElementImageScalingType.ID:=ord(eitScaling);

  aElementImageScalingType:=TElementImageScalingType(CreateElement(False));
  Add(aElementImageScalingType);
  aElementImageScalingType.Ident:=rsElementImageXScale;
  aElementImageScalingType.Code:=eitXScaling;
  aElementImageScalingType.ID:=ord(eitXScaling);
end;

class function TElementImageScalingTypes.Get_ElementClass: TDMElementClass;
begin
  Result:=TElementImageScalingType
end;

end.
