unit MyImageList;

interface

uses
  Windows, Messages, SysUtils, Classes, ImgList, Controls, Forms,
  Graphics;

type
  TMyImageList = class(TImageList)
  private
    procedure MakeImages;
  protected
    { Protected declarations }
  public
    constructor Create(Owner:TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

{$R DrawTools.res}

const
  ButtonImageArrayCount=51;
  
var
  ToolButtonImage:array[0..ButtonImageArrayCount-1] of string=(
  'bmpSelectCoordNode',
  'bmpSelectVerticalLine',
  'bmpSelectLine',
  'bmpSelectVerticalArea',
  'bmpSelectVolume',
  'bmpCreateLine',
  'bmpCreatePolyLine',
  'bmpCreateClosedPolyLine',
  'bmpCreateCurvedLine',
  'bmpCreateRectangle',
  'bmpCreateInclinedRectangle',
  'bmpCreateEllipse',
  'bmpDoubleBreakLine',
  'bmpBreakLine',
  'bmpIntersectLines',
  'bmpCreateCoordNode',
  'bmpMoveSelected',
  'bmpScaleSelected',
  'bmpTrimExtend',
  'bmpRotateSelected',
  'bmpSnapOrtToLine',
  'bmpSnapToNearestOnLine',
  'bmpSnapToMiddleOfLine',
  'bmpZoomIn',
  'bmpZoomOut',
  'bmpViewPan',
  'bmpSelectClosedPolyLine',
  'bmpSnapNone',
  'bmpSnapToNode',
  'bmpSnapToLocalGrid',
  'bmpRedraw',
  'bmpLastView',
  'bmpBuildVolume',

  'bmpBuildVerticalArea',
  'bmpBuildLineObject',
  'bmpBuildArrayObject',
  'bmpDivideVolume',
  'bmpSelectImage',
  'bmpBuildPointObject',
  'bmpSideView',
  'bmpPalette',
  'bmpBuildRelief',
  'bmpZoomSelection',
  'bmpOutline',
  'bmpSelectLabel',
  'bmpSelectAll',
  'bmpBuildPolyLineObject',
  'bmpCreateDoor',
  'bmpDropDown',
  'bmpBuildSectors',
  'bmpCreateCircle'
);


procedure Register;
begin
  RegisterComponents('Samples', [TMyImageList]);
end;

{ TMyImageList }

constructor TMyImageList.Create(Owner: TComponent);
begin
  inherited;
  MakeImages;
end;

procedure TMyImageList.MakeImages;
  procedure AddImage(const ResourceName:string; ResourceInstanceHandle:integer);
  var
    aBitMap:TBitMap;
  begin
      aBitMap:=TBitMap.Create;
      aBitMap.LoadFromResourceName(ResourceInstanceHandle, ResourceName);
      AddMasked(aBitMap, clWhite);
      aBitMap.Free;
  end;
var
  j,
  ResourceInstanceHandle:integer;
  ImageResourceName:string;
begin
  ResourceInstanceHandle:=Application.Handle;
  for j:=0 to ButtonImageArrayCount-1 do begin
    ImageResourceName:=ToolButtonImage[j];
    AddImage(ImageResourceName, ResourceInstanceHandle);
  end;
end;

end.
