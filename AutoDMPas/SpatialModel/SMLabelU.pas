unit SMLabelU;

interface
uses
 Classes, Graphics,
 DMElementU,
 DataModel_TLB, DMServer_TLB, SpatialModelLib_TLB,  PainterLib_TLB,
 CustomSpatialElementU;

type
  TSMLabel=class(TCustomSpatialElement, ISMLabel)
  private
    FFont:Variant;
    FLabelScaleMode: Integer;
    FLabelSize: Double;
    FLabeldX: double;
    FLabeldY: double;
    FLabeldZ: double;
    FName:string;

    function  Get_Font: ISMFont; safecall;
    procedure Set_Font(const Value: ISMFont); safecall;
    function  Get_LabelScaleMode: Integer; safecall;
    procedure Set_LabelScaleMode(Value: Integer); safecall;
    function  Get_LabelSize: Double; safecall;
    procedure Set_LabelSize(Value: Double); safecall;
    function  Get_LabeldX: double; safecall;
    procedure Set_LabeldX(Value: double); safecall;
    function  Get_LabeldY: double; safecall;
    procedure Set_LabeldY(Value: double); safecall;
    function  Get_LabeldZ: double; safecall;
    procedure Set_LabeldZ(Value: double); safecall;
  protected
    procedure Initialize; override;
    procedure _Destroy; override;

    function  GetFieldValue(Code: integer): OleVariant; override;  safecall;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); override;
    procedure GetFieldValueSource(Index: integer; var aCollection: IDMCollection); override;
    function  Get_Name:WideString; override; safecall;
    procedure Set_Name(const Value:WideString); override; safecall;

    class function  StoredName: WordBool; override;

    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override; safecall;
  end;


  TSMLabels=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;


implementation
uses
  SpatialModelConstU;

var
  FFields:IDMCollection;

{ TSMLabel }

procedure TSMLabel.Initialize;
begin

  inherited;
end;

procedure TSMLabel._Destroy;
begin
  inherited;
end;

class function TSMLabel.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TSMLabel.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsFont, '', '', '',
                 fvtElement, 0, 0, 0,
                 ord(lbFont), 0, pkInput);
  S:='|'+rsLabelNoScale+
     '|'+rsLabelScale;
  AddField(rsLabelScaleMode, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(lbLabelScaleMode), 0, pkInput);
  AddField(rsLabelSize, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(lbLabelSize), 0, pkInput);
  AddField(rsLabeldX, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(lbLabeldX), 0, pkInput);
  AddField(rsLabeldY, '%0.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(lbLabeldY), 0, pkInput);
end;

function TSMLabel.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(lbFont):
    Result:=FFont;
  ord(lbLabelScaleMode):
    Result:=FLabelScaleMode;
  ord(lbLabelSize):
    Result:=FLabelSize;
  ord(lbLabeldX):
    Result:=FLabeldX;
  ord(lbLabeldY):
    Result:=FLabeldY;
  ord(lbLabeldZ):
    Result:=FLabeldZ;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TSMLabel.SetFieldValue_(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(lbFont):
    FFont:=Value;
  ord(lbLabelScaleMode):
    FLabelScaleMode:=Value;
  ord(lbLabelSize):
    FLabelSize:=Value;
  ord(lbLabeldX):
    FLabeldX:=Value;
  ord(lbLabeldY):
    FLabeldY:=Value;
  ord(lbLabeldZ):
    FLabeldZ:=Value;
  else
    inherited;
  end;
end;

function TSMLabel.Get_Font: ISMFont;
var
  Unk:IUnknown;
begin
  Unk:=FFont;
  Result:=Unk as ISMFont
end;

function TSMLabel.Get_LabelScaleMode: Integer;
begin
  Result:=FLabelScaleMode
end;

function TSMLabel.Get_LabelSize: Double;
begin
  Result:=FLabelSize
end;

function TSMLabel.Get_LabeldX: double;
begin
  Result:=FLabeldX
end;

function TSMLabel.Get_LabeldY: double;
begin
  Result:=FLabeldY
end;

function TSMLabel.Get_LabeldZ: double;
begin
  Result:=FLabeldZ
end;

class function TSMLabel.GetClassID: integer;
begin
  Result:=_SMLabel
end;

procedure TSMLabel.Set_Font(const Value: ISMFont);
begin
  Set_FieldValue(ord(lbFont), Value)
end;

procedure TSMLabel.Set_LabelScaleMode(Value: Integer);
var
  DMOperationManager:IDMOperationManager;
  SMDocument:ISMDocument;
  View:IView;
  LabelSize:double;
  Painter:IPainter;
begin
  FLabelScaleMode:=Value;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  DMOperationManager:=DataModel.Document as  IDMOperationManager;
  SMDocument:=DMOperationManager as ISMDocument;
  Painter:=SMDocument.PainterU as IPainter;
  View:=Painter.ViewU as IView;
  LabelSize:=10*View.RevScale;
  DMOperationManager.ChangeFieldValue(Self  as  IUnknown, 3, True, LabelSize); // 3 - LabelSize
end;

procedure TSMLabel.Set_LabelSize(Value: Double);
begin
  FLabelSize:=Value
end;

procedure TSMLabel.Set_LabeldX(Value: double);
begin
  Set_FieldValue(ord(lbLabeldX), Value)
end;

procedure TSMLabel.Set_LabeldY(Value: double);
begin
  Set_FieldValue(ord(lbLabeldY), Value)
end;

procedure TSMLabel.Set_LabeldZ(Value: double);
begin
  Set_FieldValue(ord(lbLabeldZ), Value)
end;

procedure TSMLabel.Draw(const aPainter: IInterface; DrawSelected: integer);
var
  Painter:IPainter;
  aFont:ISMFont;
  aElementS:ISpatialElement;
  aElement, aFontE:IDMElement;
  aNode:ICoordNode;
  aLine:ILine;
  aArea:IArea;
  aVolume:IVolume;
  X,Y,Z:double;
  PenColor:TColor;
  OldColor:TColor;
  Layers:IDMCollection;
  SW, SH:double;
begin
  Painter:=aPainter as IPainter;
  aFont:=Get_Font;
  if aFont=nil then Exit;
  OldColor:=aFont.Color;

  aElement:=Ref.SpatialElement;
  aElementS:=aElement as ISpatialElement;
  if aElement.QueryInterface(ISpatialElement, aElementS)<>0 then Exit;
  aFontE:=aFont as IDMElement;

 {_________________ точка     }
  if aElement.QueryInterface(ICoordNode, aNode)=0 then begin
     X:=aNode.X;
     Y:=aNode.Y;
     Z:=aNode.Z;
  end else
  {_________________ линия    }
   if aElement.QueryInterface(ILine, aLine)=0 then begin
     X:=aLine.C0.X;
     Y:=aLine.C0.Y;
     Z:=aLine.C0.Z;
   end else
   {_________________ плоск.   }
    if aElement.QueryInterface(IArea, aArea)=0 then begin
     if aArea.IsVertical then begin
      if aArea.C0=nil then Exit;
      X:=aArea.C0.X;
      Y:=aArea.C0.Y;
      Z:=aArea.C0.Z;
     end else begin
      aArea.GetCentralPoint(X, Y, Z);
      Painter.SetFont(aFontE.Name, aFont.Size, aFont.Style, PenColor);
      Painter.GetTextExtent(Name, SW, SH);
      case FLabelScaleMode of
      0:begin
          X:=X-0.5*SW;
          Y:=Y+0.5*SH;
        end
      else
        begin
          X:=X-0.5*SW*FLabelSize/SH;
          Y:=Y+0.5*FLabelSize;
        end;
      end;
     end;
   end else
   {_________________ объем   }
    if (aElement.QueryInterface(IVolume, aVolume)=0) and
       (aVolume.BottomAreas.Count>0) then begin
       aArea:=aVolume.BottomAreas.Item[0] as IArea;
      aArea.GetCentralPoint(X, Y, Z);
      Painter.SetFont(aFontE.Name, aFont.Size, aFont.Style, PenColor);
      Painter.GetTextExtent(Name, SW, SH);
      case FLabelScaleMode of
      0:begin
          X:=X-0.5*SW;
          Y:=Y+0.5*SH;
        end
      else
        begin
          X:=X-0.5*SW*FLabelSize/SH;
          Y:=Y+0.5*FLabelSize;
        end;
      end;
    end else begin
     Exit;
    end;

    if (DrawSelected=1) then
     PenColor:=clLime
    else
     if (DrawSelected=-1) then
      PenColor:=clWhite
     else
      PenColor:=OldColor;

  if Painter.UseLayers then begin
     Layers:=(DataModel as ISpatialModel).Layers;
     Painter.LayerIndex:=Layers.IndexOf(Parent);
  end;
  Painter.DrawText(X+FLabeldX, Y+FLabeldY, Z, Name, FLabelSize,
    aFontE.Name, aFont.Size, PenColor, aFont.Style, FLabelScaleMode);

end;

procedure TSMLabel.GetFieldValueSource(Index: integer; var aCollection: IDMCollection);
var
  SpatialModel:ISpatialModel2;
  theCollection:IDMCollection;
  aCollection2:IDMCollection2;
  j:integer;
begin
  SpatialModel:=DataModel as ISpatialModel2;
  if DataModel=nil then
   theCollection:=nil
  else
    theCollection:=SpatialModel.Fonts;

  if aCollection=nil then
    aCollection:=theCollection
  else begin
    aCollection2:=aCollection as IDMCollection2;
    aCollection2.Clear;
    for j:=0 to theCollection.Count-1 do
      aCollection2.Add(theCollection.Item[j])
  end;

end;

function TSMLabel.Get_Name: WideString;
begin
  Result:=FName
end;

procedure TSMLabel.Set_Name(const Value: WideString);
begin
  FName:=Value
end;

class function TSMLabel.StoredName: WordBool;
begin
  Result:=True
end;

{ TSMLabels }

class function TSMLabels.GetElementClass: TDMElementClass;
begin
  Result:=TSMLabel;
end;

function TSMLabels.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLabel;
end;

class function TSMLabels.GetElementGUID: TGUID;
begin
  Result:=IID_ISMLabel;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TSMLabel.MakeFields;

finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
