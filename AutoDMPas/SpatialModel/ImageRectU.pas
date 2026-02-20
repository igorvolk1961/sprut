unit ImageRectU;

interface
uses
  DM_Windows,
  Classes, Graphics, SysUtils, Forms,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, LineU, JPEG;

  const
    cf_JPEG=cf_MAX+1;

type
  TImageRect=class(TLine, IImageRect)
  private
    FPicture:TPicture;
//    FGraphic:TGraphic;
    FPictureFMT:integer;
    FPictureHandle:LongWord;
    FPictureWidth:integer;
    FPictureHeight:integer;
    FGraphicFileName:WideString;
    FRotGraphic:TGraphic;
    FRotPictureHandle:integer;
    FRotPictureWidth:integer;
    FRotPictureHeight:integer;
    FAngle:double;
    FC3X:double;
    FC3Y:double;
    FC4X:double;
    FC4Y:double;
    FAlpha:integer;
    function Get_C3X: double; safecall;
    function Get_C4X: double; safecall;
    function Get_C3Y: double; safecall;
    function Get_C4Y: double; safecall;
    function Get_Angle: double;safecall;
    procedure Set_C3X(Value: double);safecall;
    procedure Set_C3Y(Value: double); safecall;
    procedure Set_C4X(Value: double); safecall;
    procedure Set_C4Y(Value: double); safecall;
    procedure Set_Angle(Value: double);safecall;
    procedure GetPictureHandle;
  protected
    procedure Initialize; override;
    procedure _Destroy; override;

    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); override;

    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;
    function Get_PictureFileName: WideString; safecall;
    procedure Set_PictureFileName(const Value: WideString); safecall;
    function Get_PictureWidth:integer; safecall;
    function Get_PictureHeight:integer; safecall;
    function  Get_RotPictureHandle: Integer; safecall;
    procedure Set_RotPictureHandle(Value: Integer); safecall;
    function  Get_PictureHandle: LongWord; safecall;
    procedure Set_PictureHandle(Value: LongWord); safecall;
    function  Get_PictureFMT: Integer; safecall;
    procedure Set_PictureFMT(Value: Integer); safecall;
    function  Get_Alpha:integer; safecall;
    procedure Set_Alpha(Value:integer); safecall;

    procedure RotatePicture(Angle:double); safecall;
    procedure Loaded; override;
    procedure UpdateCoords; override; safecall;
  end;

  TImageRects=class(TLines)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SpatialModelConstU;

var
  FFields:IDMCollection;

procedure TImageRect.Initialize;
begin
  inherited;
  FPicture:=TPicture.Create;
//  FGraphic:=TBitmap.Create;
//  FRotGraphic:=TBitmap.Create;
  FPictureFMT:=CF_BITMAP;
  FPictureHandle:=$FFFFFFFF;
end;

procedure TImageRect._Destroy;
begin
  inherited;
  if FPicture=nil then Exit;

  FPicture.Free;
  FPicture:=nil;
{$R-}
  if FPictureHandle<>$FFFFFFFF then
    DM_DeleteObject(FPictureHandle);
  DM_DeleteObject(FRotPictureHandle);
{$R+}
end;

class function TImageRect.GetClassID: integer;
begin
  Result:=_ImageRect;
end;

procedure TImageRect.Draw(const aPainter:IUnknown; DrawSelected:integer);
var
  P0X, P0Y, P0Z,
  P1X, P1Y, P1Z,
  P3X, P3Y, P3Z,
  P4X, P4Y, P4Z:double;
  aPictureHandle:LongWord;
  aPenWidthOld:double;
  C0, C1:ICoordNode;
//  aAngle:double;
//  aFlag:integer;
begin
  if Layer=nil then Exit;
  if not Layer.Visible then begin
    if FPictureHandle<>$FFFFFFFF then begin
      DM_DeleteObject(FPictureHandle);
      FPictureHandle:=$FFFFFFFF;
    end;
    Exit;
  end;
  if FPictureHandle=$FFFFFFFF then begin
    GetPictureHandle;
  end;
  if FPictureHandle=$FFFFFFFF then Exit;
  if FPicture=nil then Exit;
//  if FPicture.Graphic=nil then Exit;
  if ((DataModel.Document as IDMDocument).State and dmfAuto)<>0 then Exit;
//    If aFlag=2 then
//     Update;
     C0:=Get_C0;
     C1:=Get_C1;
     if (C0.X<=C1.X)and (C0.Y>C1.Y)then begin
        P0X:=C0.X;
        P0Y:=C0.Y;
        P1X:=C1.X;
        P1Y:=C1.Y;
        P3X:=FC3X;
        P3Y:=FC3Y;
        P4X:=FC4X;
        P4Y:=FC4Y;

        P0Z:=C0.Z;
        P1Z:=C1.Z;
        P3Z:=P0Z;
        P4Z:=P1Z;
      end else
      if (C0.X<=C1.X)and (C0.Y<=C1.Y)then begin
        P0X:=FC3X;
        P0Y:=FC3Y;
        P1X:=FC4X;
        P1Y:=FC4Y;
        P3X:=C0.X;
        P3Y:=C0.Y;
        P4X:=C1.X;
        P4Y:=C1.Y;

        P3Z:=C0.Z;
        P4Z:=C1.Z;
        P0Z:=P3Z;
        P1Z:=P4Z;
      end else
      if (C0.X>C1.X)and (C0.Y<=C1.Y)then begin
         P0X:=FC4X;
         P0Y:=FC4Y;
         P1X:=FC3X;
         P1Y:=FC3Y;
         P3X:=C1.X;
         P3Y:=C1.Y;
         P4X:=C0.X;
         P4Y:=C0.Y;

         P3Z:=C1.Z;
         P4Z:=C0.Z;
         P0Z:=P3Z;
         P1Z:=P4Z;
       end else begin     // if (C0.X>C1.X)and (C0.Y>C1.Y)
          P0X:=C1.X;
          P0Y:=C1.Y;
          P1X:=C0.X;
          P1Y:=C0.Y;
          P3X:=FC4X;
          P3Y:=FC4Y;
          P4X:=FC3X;
          P4Y:=FC3Y;

          P0Z:=C1.Z;
          P1Z:=C0.Z;
          P3Z:=P0Z;
          P4Z:=P1Z;
       end;

//  if (aPainter as IPainter).View.ZAngle=FAngle then
    aPictureHandle := FPictureHandle;
//  else
//    aPictureHandle := FRotPictureHandle;



  aPenWidthOld:=0;
  if (DrawSelected=-1) then begin
    with aPainter as IPainter do begin
      aPenWidthOld:=PenWidth;
      PenColor:=clWhite;
      PenStyle := 0;
      PenWidth:=3;
      PenMode:=ord(pmCopy);
      DrawLine(P0X, P0Y, P0Z,
               P3X, P3Y, P3Z);
      DrawLine(P0X, P0Y, P0Z,
               P4X, P4Y, P4Z);
      DrawLine(P3X, P3Y, P3Z,
               P1X, P1Y, P1Z);
      DrawLine(P4X, P4Y, P4Z,
               P1X, P1Y, P1Z);
    end;
  end;

  (aPainter as IPainter).DrawPicture(P0X, P0Y, P0Z, P1X, P1Y, P1Z,
                            P3X, P3Y, P3Z, P4X, P4Y, P4Z, FAngle,aPictureHandle, FPictureFMT, FAlpha);

  aPenWidthOld:=0;
  if (DrawSelected=1) then begin
    with aPainter as IPainter do begin
      aPenWidthOld:=PenWidth;
      PenColor:=clLime;
      PenStyle := 0;
      PenWidth:=3;
      PenMode:=ord(pmCopy);
      DrawLine(P0X, P0Y, P0Z,
               P3X, P3Y, P3Z);
      DrawLine(P0X, P0Y, P0Z,
               P4X, P4Y, P4Z);
      DrawLine(P3X, P3Y, P3Z,
               P1X, P1Y, P1Z);
      DrawLine(P4X, P4Y, P4Z,
               P1X, P1Y, P1Z);
    end;
  end;

  (aPainter as IPainter).PenWidth:=aPenWidthOld;
end;
//_________________________________________
//  6.11.2001 ____рабочий вариант__________________________

procedure TImageRect.RotatePicture(Angle: double);
(*
var
  aAngle, CosA,  SinA, SinB, CosB: double;
  Jk, Ik, dX, dY, I, J, m, n :integer;
  Xc0, Yc0:double;
  MyFormat : Word;
  AData: THandle;
  APalette : HPALETTE;
*)  
begin
(*
  aAngle := round(Angle) mod 360 + (Angle - Int(Angle));
  CosA := cos(aAngle*Pi/180);
  SinA := sin(aAngle*Pi/180);
  SinB := Sin((aAngle-90)*Pi/180);
  CosB := Cos((aAngle-90)*Pi/180);
  Ik := FGraphic.Width;
  Jk := FGraphic.Height;
  dX := round(abs(Ik*CosA)+abs(Jk*SinA));
  dY := round(abs(Ik*SinA)+abs(Jk*CosA));
  FRotGraphic.Width := dX;
  FRotGraphic.Height:= dY;
  FRotGraphic.Transparent := True;
  (FRotGraphic as TBitmap).TransparentColor:= clWhite;
  (FRotGraphic.TransparentMode as TBitmap):= tmAuto;
  for I := 0 to dX-1 do
   begin
    for J := 0 to dY-1 do
      FRotGraphic.Canvas.Pixels[I, J] := clWhite	;
   end;
  if ((aAngle >=0) and (aAngle <=90)) or ((aAngle <-270) and (aAngle >=-360)) then begin
     Xc0 := 0;
     Yc0 := Ik*abs(SinA)
   end
     else if (aAngle >90) and (aAngle <=180) or ((aAngle <-180) and (aAngle >=-270)) then begin
         Xc0 := Ik*abs(SinB);
         Yc0 := Ik*abs(CosB)+Jk*abs(SinB)
       end
       else if (aAngle <0) and (aAngle >=-90) or ((aAngle >270) and (aAngle <=360)) then begin
         Xc0 := Jk*abs(SinA);
         Yc0 := 0
       end
       else if (aAngle <-90) and (aAngle >=-180) or ((aAngle >180) and (aAngle <=270)) then begin
         Xc0 := Jk*abs(CosB)+Ik*abs(SinB);
         Yc0 := Jk*abs(SinB);
       end
       else begin
         Xc0 := 0;
         Yc0 := Ik*abs(SinA)
       end;

    for I := 0 to Ik-1 do
     for J := 0 to Jk-1 do
     begin
       m := round((cosA*(I) + SinA*(J)) + Xc0);
       n := round((-SinA*(I) + cosA*(J)) + Yc0);
       FRotBitmap.Canvas.Pixels[m, n] := FBitmap.Canvas.Pixels[I, J];
     end;
    FRotBitmap.SaveToClipBoardFormat(MyFormat,AData,APalette);
{$R-}
    DeleteObject(FRotPictureHandle);
    FRotPictureHandle:=AData;
{$R+}
*)
end;
//  6.11.2001 ___________конец___________________

class function TImageRect.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TImageRect.MakeFields0;
begin
  inherited;
  AddField(rsBitmapFileName, '%s', '', '',
                 fvtString, 0, 0, 0,
                 ord(irBitmapFileName), 0, pkInput);
  AddField(rsAngle, '%7.2f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(irAngle), 0, pkInput);
  AddField(rsAlpha, '%d', '', '',
                 fvtInteger, 255, 0, 0,
                 ord(irAlpha), 0, pkInput);
end;

function TImageRect.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(irBitmapFileName):
    Result:=FGraphicFileName;
  ord(irAngle):
    Result:=FAngle;
  ord(irAlpha):
    Result:=FAlpha;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TImageRect.SetFieldValue_(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(irBitmapFileName):
    begin
      FGraphicFileName:=Value;
      if DataModel.IsLoading then Exit;
      GetPictureHandle;
      end;
  ord(irAngle):
    FAngle:=Value;
  ord(irAlpha):
    FAlpha:=Value;
  else
    inherited;
  end;
end;

procedure TImageRect.Loaded;
var
  C0, C1:ICoordNode;
begin
  inherited;
//  GetPictureHandle;
  C0:=Get_C0;
  C1:=Get_C1;
  FC3X:=C0.X;
  FC3Y:=C1.Y;
  FC4X:=C1.X;
  FC4Y:=C0.Y;
end;

procedure TImageRect.GetPictureHandle;
var
  AData: THandle;
  aFMT:Word;
  APalette : HPALETTE;
  FileName, FilePath, GraphicFilePath, S, S1:string;
  m, L:integer;
  aPicture:TPicture;
begin
  FileName:=(DataModel as IDMElement).Name;
  FilePath:=ExtractFilePath(FileName);
  GraphicFilePath:=ExtractFilePath(FGraphicFileName);
  S:=FGraphicFileName;
  if GraphicFilePath<>'' then begin
    if GraphicFilePath=FilePath then
      FGraphicFileName:=ExtractFileName(S)
    else
    if Copy(S, 1, 3)='..\' then begin
      L:=length(FilePath);
      m:=L-1;
      while m>0 do begin
        if FilePath[m]<>'\' then
          dec(m)
        else
          break
      end;
      if m>0 then
        S1:=Copy(FilePath, 1, m)
      else
        S1:=FilePath;
      S:=S1+Copy(S, 4, length(S)-3);
    end;
  end else begin
    S:=FilePath+S
  end;
  if FileExists(S) then begin
    aPicture:=TPicture.Create;
    aPicture.LoadFromFile(S);
{$R-}
    aFMT:=FPictureFMT;
    try
      aPicture.SaveToClipBoardFormat(aFMT, aData, APalette);
      FPictureHandle:=AData;
    except
      FPictureHandle:=0;
    end;
{$R+}
    FPictureWidth:=aPicture.Width;
    FPictureHeight:=aPicture.Height;
    aPicture.Free;
  end else
    FPictureHandle:=$FFFFFFFF;
end;

{ TImageRects }

function TImageRects.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsImageRect;
end;

class function TImageRects.GetElementGUID: TGUID;
begin
  Result:=IID_IImageRect;
end;

class function TImageRects.GetElementClass: TDMElementClass;
begin
  Result:=TImageRect;
end;

function TImageRect.Get_Angle: double;
begin
  Result:=FAngle
end;


function TImageRect.Get_C3X: double;
begin
  Result:=FC3X
end;
function TImageRect.Get_C3Y: double;
begin
  Result:=FC3Y
end;
function TImageRect.Get_C4X: double;
begin
  Result:=FC4X
end;
function TImageRect.Get_C4Y: double;
begin
  Result:=FC4Y
end;

function TImageRect.Get_PictureFileName: WideString;
begin
  Result:=FGraphicFileName
end;

procedure TImageRect.Set_Angle(Value: double);
begin
  Set_FieldValue(ord(irAngle), Value)
end;

procedure TImageRect.Set_C3X(Value: double);
begin
  FC3X:=Value
end;

procedure TImageRect.Set_C3Y(Value: double);
begin
  FC3Y:=Value
end;

procedure TImageRect.Set_C4X(Value: double);
begin
  FC4X:=Value
end;

procedure TImageRect.Set_C4Y(Value: double);
begin
  FC4Y:=Value
end;


procedure TImageRect.Set_PictureFileName(const Value: WideString);
begin
  Set_FieldValue(ord(irBitmapFileName), Value);
end;

function TImageRect.Get_PictureHeight: integer;
begin
  Result:=FPictureHeight
end;

function TImageRect.Get_PictureWidth: integer;
begin
  Result:=FPictureWidth
end;

function TImageRect.Get_PictureHandle: LongWord;
begin
  Result:=FPictureHandle
end;

procedure TImageRect.Set_PictureHandle(Value: LongWord);
begin
  FPictureHandle:=Value;
{$R-}
  FPicture.LoadFromClipboardFormat(FPictureFMT,FPictureHandle,0);
{$R+}
  FPictureWidth:=FPicture.Width;
  FPictureHeight:=FPicture.Height;
end;

function TImageRect.Get_RotPictureHandle: Integer;
begin
  Result:=FPictureHandle
end;

procedure TImageRect.Set_RotPictureHandle(Value: Integer);
begin
  FRotPictureHandle:=Value;
{$R-}
  FRotGraphic.LoadFromClipboardFormat(cf_BitMap,FRotPictureHandle,0);
{$R+}
  FRotPictureWidth:=FPicture.Width;
  FRotPictureHeight:=FPicture.Height;
end;

procedure TImageRect.UpdateCoords;
var
  cosZ, sinZ:double;
//  X, Y :double;
  X3, Y3, X4, Y4:double;
  aDocument:IDMDocument;
  C0, C1:ICoordNode;
begin
  C0:=Get_C0;
  C1:=Get_C1;
  if C0=nil then Exit;
  if C1=nil then Exit;
  If (FAngle<>0) then
   begin
    cosZ:=cos(-FAngle*pi/180);
    sinZ:=sin(-FAngle*pi/180);
    //............................
    X3 := cosZ*(C1.X-C0.X) + sinZ*(C1.Y-C0.Y); // в нов.корд. угол =0
    Y3 := 0;
    X4 := 0;
    Y4 :=-sinZ*(C1.X-C0.X) + cosZ*(C1.Y-C0.Y);
//............................
    FC3X := C0.X + cosZ*(X3) - sinZ*(Y3);      // в старые коорд.- с поворотом)
    FC3Y := C0.Y + sinZ*(X3) + CosZ*(Y3);
    FC4X := C0.X + cosZ*(X4) - sinZ*(Y4);
    FC4Y := C0.Y + sinZ*(X4) + CosZ*(Y4);
   end else begin
     FC3X := C1.X;
     FC3Y := C0.Y;
     FC4X := C0.X;
     FC4Y := C1.Y;
   end;
// -------- здесь проверить нужен ли поворот Canvas BitMap

   if DataModel.IsLoading then Exit;
   aDocument := DataModel.Document as IDMDocument;
   if (aDocument as ISMDocument).PainterU=nil then Exit;
{
    If((aDocument as ISMOperationManager).Painter.View.ZAngle<>FAngle)then
     RotatePicture((aDocument as ISMOperationManager).Painter.View.ZAngle-FAngle);
}
   aDocument.Server.RefreshDocument(rfFrontBack);   //это RePaint
end;


function TImageRect.Get_PictureFMT: Integer;
begin
  Result:=FPictureFMT
end;

procedure TImageRect.Set_PictureFMT(Value: Integer);
begin
  FPictureFMT:=Value;
{
  case FPictureFMT of
  cf_BITMAP:
    FGraphic:=TBitmap.Create;
  cf_JPEG:
    FGraphic:=TJPEGImage.Create
  end;
}
end;

function TImageRect.Get_Alpha: integer;
begin
  Result:=FAlpha
end;

procedure TImageRect.Set_Alpha(Value: integer);
begin
  Set_FieldValue(ord(irAlpha), Value)
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TImageRect.MakeFields;
  TPicture.RegisterClipboardFormat(cf_JPEG, TJPEGImage)
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.


