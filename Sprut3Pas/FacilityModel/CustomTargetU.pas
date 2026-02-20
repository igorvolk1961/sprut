unit CustomTargetU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  CustomBoundaryU;

type
  TCustomTarget=class(TCustomBoundary, IPathNodeArray)
  private
    FPathNodes:IDMCollection;
    FShowSymbol:boolean;

  protected
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;
    class procedure MakeFields0; override;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    procedure _AddBackRef(const Value:IDMElement); override; safecall;

    function Get_Zone0:IDMElement; override; safecall;
    function Get_Zone1:IDMElement; override; safecall;
    function  Get_MainParent: IDMElement; override; safecall;
    procedure CalcVulnerability; override; safecall;

    function  Get_PathNodes: IDMCollection; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

implementation

uses
  FacilityModelConstU;

{ TCustomTarget }

procedure TCustomTarget.Draw(const aPainter: IInterface; DrawSelected: integer);
var
  Image:IElementImage;
  LocalView:IView;
  Node:ICoordNode;
  Line:ILine;
  SpatialModel2:ISpatialModel2;
  Painter:IPainter;
  Pixels:integer;
  RevScale:double;
  Document:IDMDocument;
  OldState:integer;
  Layer:ILayer;
  View:IView;
begin
  if SpatialElement=nil then Exit;
  if Ref=nil then Exit;

  Layer:=SpatialElement.Parent as ILayer;
  if not Layer.Visible then Exit;

  if (FSMLabel<>nil) and
     (DataModel as IVulnerabilityMap).ShowText then
    FSMLabel.Draw(aPainter, DrawSelected);

  SpatialModel2:=DataModel as ISpatialModel2;
  Image:=(Ref as IVisualElement).Image;
  Document:=DataModel.Document as IDMDocument;
  OldState:=Document.State;
  Document.State:=Document.State or dmfExecuting;
  try

  if (Image<>nil) and
      FShowSymbol and
     (DataModel as IVulnerabilityMap).ShowSymbols then begin
    Painter:=aPainter as IPainter;
    View:=Painter.ViewU as IView;

    LocalView:=(SpatialModel2.Views as IDMCollection2).CreateElement(False) as IView;
    if SpatialElement.QueryInterface(ICoordNode, Node)=0 then begin
      LocalView.CX:=Node.X;
      LocalView.CY:=Node.Y;
      LocalView.CZ:=Node.Z;
      LocalView.ZAngle:=-View.ZAngle;
    end else begin
      Document.State:=OldState;
      Exit;
    end;

    case Image.ScalingType of
    eitNoScaling:
      begin
        Pixels:=Image.MinPixels;
        RevScale:=Pixels/View.RevScale;
        if RevScale<1 then
          LocalView.RevScale:=RevScale
        else
          LocalView.RevScale:=1
      end;
    eitScaling:
       LocalView.RevScale:=1;
    eitXScaling:
      if SpatialElement.QueryInterface(ILine, Line)=0 then begin
        LocalView.RevScaleX:=Image.XSize/Line.Length;
        LocalView.RevScaleY:=1;
      end else begin
        Document.State:=OldState;
        Exit;
      end;
    end;
     Painter.LocalViewU:=LocalView;

    (Image as IDMElement).Draw(aPainter, DrawSelected);

    Painter.LocalViewU:=nil;
  end else begin
    if SpatialElement.ClassID=_Line then
      ((SpatialElement as ILine).C0 as IDMElement).Draw(aPainter, DrawSelected)
    else
      SpatialElement.Draw(aPainter, DrawSelected);
  end;

  finally
    Document.State:=OldState;
  end;
end;

function TCustomTarget.Get_Zone0: IDMElement;
begin
  Result:=Parent
end;

function TCustomTarget.Get_Zone1: IDMElement;
begin
  Result:=nil
end;

function TCustomTarget.Get_MainParent: IDMElement;
begin
  Result:=Parent
end;


function TCustomTarget.Get_PathNodes: IDMCollection;
begin
  Result:=FPathNodes
end;

procedure TCustomTarget._AddBackRef(const Value: IDMElement);
begin
  if Value.DataModel<>DataModel then Exit;
  if Value.Parent=nil then Exit;
  
  if Value.ClassID=_CoordNode then
    Set_SpatialElement(Value)
  else
    inherited
end;

procedure TCustomTarget._Destroy;
begin
  inherited;
  FPathNodes:=nil;
end;

procedure TCustomTarget.Initialize;
begin
  inherited;
  FPathNodes:=DataModel.CreateCollection(-1, Self as IDMElement);
end;

class procedure TCustomTarget.MakeFields0;
begin
  AddField(rsShowSymbol, '', '', '',
                 fvtBoolean, 1, 0, 0,
                 ord(cnstShowSymbol), 0, pkView);
  inherited;
end;

function TCustomTarget.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cnstShowSymbol):
    Result:=FShowSymbol;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TCustomTarget.SetFieldValue(Code: integer; Value: OleVariant);
var
  Painter:IUnknown;
begin
  Painter:=nil;
  case Code of
  ord(cnstShowSymbol):
    begin
      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (not DataModel.IsCopying) then begin
        Painter:=(DataModel.Document as ISMDocument).PainterU;
        if SpatialElement<>nil then
          Draw(Painter, -1)
        else
        if (Parent<>nil) then
          Parent.Draw(Painter, -1)
      end;

      FShowSymbol:=Value;

      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (not DataModel.IsCopying) then begin
        Painter:=(DataModel.Document as ISMDocument).PainterU;
        if SpatialElement<>nil then begin
          if Selected then
            Draw(Painter, 1)
          else
            Draw(Painter, 0)
        end else
        if (Parent<>nil) then begin
          if Parent.Selected then
            Parent.Draw(Painter, 1)
          else
            Parent.Draw(Painter, 0)
        end;
      end;
    end;
  else
    inherited
  end;
end;

function TCustomTarget.FieldIsVisible(Code: Integer): WordBool;
begin
  case Code of
  ord(cnstShowSymbol),
  ord(cnstSymbolScaleFactor),
  ord(cnstImageRotated),
  ord(cnstImageMirrored):
    Result:=True;
  ord(bopFlowIntencity):
    Result:=False
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

procedure TCustomTarget.CalcVulnerability;
begin
  inherited;

end;

end.
