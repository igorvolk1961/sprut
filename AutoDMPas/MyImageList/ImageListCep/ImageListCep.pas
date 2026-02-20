unit ImageListCep;
//© 2006 Сергей Рощин (Специально для королевства Дэльфи)
//В этом модуле содержится коллекция изображений загружаемых
//из ресурсов программы TImageListCep
//Данный модyль не предназначен для коммерческого использования.
//По поводу возможного сотрудничества Вы можете обратиться по
//элестронной почте roschinspb@mail.ru
//http://www.delphikingdom.com/asp/users.asp?ID=1271
//http://www.roschinspb.boom.ru
interface
//Чтобы иметь возможность использовать данный компонент в дизайнере форм Delphi
//вы должны последовательно инсталлировать библиотеки
//ImageListCepPack.dpk и EditImgListPack.dpk.
uses
  windows,SysUtils, Classes, ImgList, Controls, Forms, Graphics, GraphUtil, Math
  ,InternalTimer;

const StandartResourceName = 'STANDARTBTN';

resourcestring
  StrNoFile = 'Неудалось найти файл "%s"';

{$DEFINE VER130}

type
  TImageListCep = class;

  //В этом классе содержится информация о загружаемом ресурсе
  TResourceName=class (TCollectionItem)
  private
    fName: string;
    fWidth: Byte;
    fHeight: Byte;
    fGliphCount: Word;
    fTransparentColor: TColor;
    fAutoSize: boolean;
    fFileName: String;
    fhInstance: THandle;
    fFileNameDOM: boolean;
    procedure SetHeight(const Value: Byte);
    procedure SetName(const Value: string);
    procedure SetWidth(const Value: Byte);
    procedure SetGliphCount(const Value: Word);
    procedure SetTransparentColor(const Value: TColor);
    procedure SetAutoSize(const Value: boolean);
    procedure SetFileName(const Value: String);
    procedure FreeHinstance(RaisedError: Boolean);
    function UpdatehInstance(RaisedError: Boolean): boolean;
    procedure SetFileNameODM(const Value: boolean);
  protected
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromStream(S: TStream);
    procedure SaveToStream(S: TStream);
    //Реальное название ресурса (см. AutoSize)
    function GetResourceName:string;
    //Загрузка картинки из ресурса (см. GetResourceName, FileName, FileNameDOM)
    function LoadFromResourceName(var Bmp:TBitmap; RaisedError:boolean=false):boolean;
    //Возвращает список всех ресурсов с картинками
    procedure EnumResources(List: TStringList);
  published
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Name:string read fName write SetName;              //Название ресурса
    property Width:Byte read fWidth write SetWidth default 24;    //Ширина изображения (в ресурсе)
    property Height:Byte read fHeight write SetHeight default 24; //Высота изображения
    //Если AutoSize=true, то функция GetResourceName
    //выбирает из ресурсов NAME_ss (ss - размер) наиболее подходящий по размеру
    //ресурс и устанавливает соответствующие значения Width и Height
    property AutoSize:boolean read fAutoSize write SetAutoSize default true;
    //Количество изображений в ресурсе
    property GliphCount:Word read fGliphCount write SetGliphCount default 8;
    //Цвет, который используется в качестве прозрачного
    property TransparentColor:TColor read fTransparentColor
                          write SetTransparentColor default clFuchsia;
    //Название файла из которого берется ресурс.
    //Если '', то из приложения
    property FileName:String read fFileName write SetFileName;
    //Если FileNameDOM=true, то FileName используется только в DesignTime,
    //иначе изображения беруться из приложения т. е. FileName игнорируется.
    property FileNameDOM:boolean read fFileNameDOM write SetFileNameODM default true;
  end;

  //Коллекция ресурсов
  TResourceNames = class (TOwnedCollection)
  private
    function GetItem(Index: Integer): TResourceName;
    procedure SetItem(Index: Integer; const Value: TResourceName);
    function GetImageList: TImageListCep;
  protected
    procedure Update(Item: TCollectionItem); override;  //Выполняется при изменении одного
  public
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function AddDefault:TResourceName;   //Добавить изображение из ресурса StandartBtn
    property Items[Index: Integer]: TResourceName read GetItem write SetItem;
    function FindItemByName(Name:string):integer; //Поиск изображения по названию c учетом &
  published
    property ImageListCep:TImageListCep read GetImageList;
  end;

  //Потомок TDragImageList с дополнительными возможностями
  TCustomImg = class (TDragImageList)
  private
    fSourceBitmap:TBitmap;
    fDestBitmap:TBitmap;
    fTMPBitmap:TBitmap;
    fCountUpdating: integer;
    fTimer: TInternalTimer;
    function GetTimer: TInternalTimer;
  protected
    procedure DoChanged(Sender:TObject); virtual;
    procedure Change; override;
  public
    procedure LoadFromStream(S: TStream);
    procedure SaveToStream(S: TStream);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //Вставляет картинку заданного размера (ARect). Если Index=Count, то
    //добавляет в конец. При добавлении изображение масштабируется.
    procedure InsertBitmap(Index: integer; Bitmap: TBitmap; ARect:TRect); overload;
    procedure InsertBitmap(Index: integer; Bitmap: TBitmap); overload;
    //Вставляет несколько изображений. Bitmap разбивается на
    //прямоугольники указанного размера
    function InsertBitmaps(Index:integer; Bitmap: TBitmap;
                           Width,Height:integer; Count:integer=0):Word;
    procedure BeginUpdate;
    procedure EndUpdate;
    property CountUpdating:integer read fCountUpdating;
    property Timer: TInternalTimer read GetTimer;
  published
    property BlendColor;
    property BkColor;
    property Height;
    property Masked;
    property Width;
  end;

  //Набор изображений загружаемых из ресурсов
  TImageListCep = class(TCustomImg)
  private
    fInChange: boolean;
    fCustomImg: TCustomImg;
    fResourceNames: TResourceNames;
    fDirName: string;
    procedure SetResourceNames(const Value: TResourceNames);
    procedure ReaderProc(Reader: TReader);
    procedure WriterProc(Writer: TWriter);
    {$IFDEF VER130}
    procedure ReadLeft(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure WriteLeft(Writer: TWriter);
    procedure WriteTop(Writer: TWriter);
    procedure ReadCustomImgWidth(Reader: TReader);
    procedure WriteCustomImgWidth(Writer: TWriter);
    procedure ReadCustomImgHeight(Reader: TReader);
    procedure WriteCustomImgHeight(Writer: TWriter);
    procedure ReadCustomImgBitmap(Stream: TStream);
    procedure WriteCustomImgBitmap(Stream: TStream);
    {$ENDIF}
  protected
    procedure DefineProperties(Filer: TFiler); override;
    {$IFDEF VER130}
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream); 
    {$ELSE}
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
    {$ENDIF}
    procedure DoChanged(Sender: TObject); override;
    procedure Loaded; override;
  public
    procedure Assign(Source: TPersistent); override;
    //Обновление результирующего набора изображений, которое состоит
    //из изображений в ресурсах ResourceNames и CustomImg
    function UpdateImages:boolean; dynamic;
    constructor Create(AOwner:TComponent); override;
    //Название папки, из которой в последний раз добавлялись картинки
    property DirName:string read fDirName write fDirName;
  published
    //Коллекция с ресурсов из которых выполняется загрузка изображений
    property ResourceNames:TResourceNames read fResourceNames write SetResourceNames;
    //Это пользовательское изображение, загружаемое традиционным образом
    property CustomImg:TCustomImg read fCustomImg;
    property onChange;
  end;


var DesignTime: boolean;

function ResourceNameToSize(Name:string; var Size:integer):string;
procedure Register;

implementation

{$R StandartBtn_32.RES}
{$R StandartBtn_24.RES}
{$R StandartBtn_16.RES}


{$IFDEF VER130}
uses Commctrl, Consts;
{$ENDIF}


procedure ShrinkImage(const SourceBitmap, StretchedBitmap: TBitmap;
  Scale: Double);
var
  ScanLines: array of PByteArray;
  DestLine: PByteArray;
  DestX, DestY: Integer;
  DestR, DestB, DestG: Integer;
  SourceYStart, SourceXStart: Integer;
  SourceYEnd, SourceXEnd: Integer;
  AvgX, AvgY: Integer;
  ActualX: Integer;
  CurrentLine: PByteArray;
  PixelsUsed: Integer;
  DestWidth, DestHeight: Integer;
begin
  DestWidth := StretchedBitmap.Width;
  DestHeight := StretchedBitmap.Height;
  SetLength(ScanLines, SourceBitmap.Height);
  for DestY := 0 to DestHeight - 1 do
  begin
    SourceYStart := Round(DestY / Scale);
    SourceYEnd := Round((DestY + 1) / Scale) - 1;

    if SourceYEnd >= SourceBitmap.Height then
      SourceYEnd := SourceBitmap.Height - 1;

    { Grab the destination pixels }
    DestLine := StretchedBitmap.ScanLine[DestY];
    for DestX := 0 to DestWidth - 1 do
    begin
      { Calculate the RGB value at this destination pixel }
      SourceXStart := Round(DestX / Scale);
      SourceXEnd := Round((DestX + 1) / Scale) - 1;

      DestR := 0;
      DestB := 0;
      DestG := 0;
      PixelsUsed := 0;
      if SourceXEnd >= SourceBitmap.Width then
        SourceXEnd := SourceBitmap.Width - 1;
      for AvgY := SourceYStart to SourceYEnd do
      begin
        if ScanLines[AvgY] = nil then
          ScanLines[AvgY] := SourceBitmap.ScanLine[AvgY];
        CurrentLine := ScanLines[AvgY];
        for AvgX := SourceXStart to SourceXEnd do
        begin
          ActualX := AvgX*3; { 3 bytes per pixel }
          DestR := DestR + CurrentLine[ActualX];
          DestB := DestB + CurrentLine[ActualX+1];
          DestG := DestG + CurrentLine[ActualX+2];
          Inc(PixelsUsed);
        end;
      end;

      { pf24bit = 3 bytes per pixel }
      ActualX := DestX*3;
      DestLine[ActualX] := Round(DestR / PixelsUsed);
      DestLine[ActualX+1] := Round(DestB / PixelsUsed);
      DestLine[ActualX+2] := Round(DestG / PixelsUsed);
    end;
  end;
end;


procedure EnlargeImage(const SourceBitmap, StretchedBitmap: TBitmap;
  Scale: Double);
var
  ScanLines: array of PByteArray;
  DestLine: PByteArray;
  DestX, DestY: Integer;
  DestR, DestB, DestG: Double;
  SourceYStart, SourceXStart: Integer;
  SourceYPos: Integer;
  AvgX, AvgY: Integer;
  ActualX: Integer;
  CurrentLine: PByteArray;
  { Use a 4 pixels for enlarging }
  XWeights, YWeights: array[0..1] of Double;
  PixelWeight: Double;
  DistFromStart: Double;
  DestWidth, DestHeight: Integer;
begin
  DestWidth := StretchedBitmap.Width;
  DestHeight := StretchedBitmap.Height;
  Scale := StretchedBitmap.Width / SourceBitmap.Width;
  SetLength(ScanLines, SourceBitmap.Height);
  for DestY := 0 to DestHeight - 1 do
  begin
    DistFromStart := DestY / Scale;
    SourceYStart := Round(DistFromSTart);
    YWeights[1] := DistFromStart - SourceYStart;
    if YWeights[1] < 0 then
      YWeights[1] := 0;
    YWeights[0] := 1 - YWeights[1];

    DestLine := StretchedBitmap.ScanLine[DestY];
    for DestX := 0 to DestWidth - 1 do
    begin
      { Calculate the RGB value at this destination pixel }
      DistFromStart := DestX / Scale;
      if DistFromStart > (SourceBitmap.Width - 1) then
        DistFromStart := SourceBitmap.Width - 1;
      SourceXStart := Round(DistFromStart);
      XWeights[1] := DistFromStart - SourceXStart;
      if XWeights[1] < 0 then
        XWeights[1] := 0;
      XWeights[0] := 1 - XWeights[1];

      { Average the four nearest pixels from the source mapped point }
      DestR := 0;
      DestB := 0;
      DestG := 0;
      for AvgY := 0 to 1 do
      begin
        SourceYPos := SourceYStart + AvgY;
        if SourceYPos >= SourceBitmap.Height then
          SourceYPos := SourceBitmap.Height - 1;
        if ScanLines[SourceYPos] = nil then
          ScanLines[SourceYPos] := SourceBitmap.ScanLine[SourceYPos];
            CurrentLine := ScanLines[SourceYPos];

        for AvgX := 0 to 1 do
        begin
          if SourceXStart + AvgX >= SourceBitmap.Width then
            SourceXStart := SourceBitmap.Width - 1;

          ActualX := (SourceXStart + AvgX) * 3; { 3 bytes per pixel }

          { Calculate how heavy this pixel is based on how far away
            it is from the mapped pixel }
          PixelWeight := XWeights[AvgX] * YWeights[AvgY];
          DestR := DestR + CurrentLine[ActualX] * PixelWeight;
          DestB := DestB + CurrentLine[ActualX+1] * PixelWeight;
          DestG := DestG + CurrentLine[ActualX+2] * PixelWeight;
        end;
      end;

      ActualX := DestX * 3;
      DestLine[ActualX] := Round(DestR);
      DestLine[ActualX+1] := Round(DestB);
      DestLine[ActualX+2] := Round(DestG);
    end;
  end;
end;

procedure ScaleImage(const SourceBitmap, ResizedBitmap: TBitmap;
  const ScaleAmount: Double);
var
  DestWidth, DestHeight: Integer;
begin
  DestWidth := Round(SourceBitmap.Width * ScaleAmount);
  DestHeight := Round(SourceBitmap.Height * ScaleAmount);
  { We must work in 24-bit to insure the pixel layout for
    scanline is correct }
  SourceBitmap.PixelFormat := pf24bit;

  ResizedBitmap.Width := DestWidth;
  ResizedBitmap.Height := DestHeight;
  ResizedBitmap.Canvas.Brush.Color := clNone;
  ResizedBitmap.Canvas.FillRect(Rect(0, 0, DestWidth, DestHeight));
  ResizedBitmap.PixelFormat := pf24bit;

  if ResizedBitmap.Width < SourceBitmap.Width then
    ShrinkImage(SourceBitmap, ResizedBitmap, ScaleAmount)
  else
    EnlargeImage(SourceBitmap, ResizedBitmap, ScaleAmount);
end;

procedure Register;
begin
  RegisterComponents('Cep', [TImageListCep]);
end;

{ TStandartImageList }

procedure TImageListCep.Assign(Source: TPersistent);
begin
 BeginUpdate;
 try
  if Source=nil then
  begin
   ResourceNames.Assign(nil);
   CustomImg.Clear;
  end else
  begin
    if (Source is TImageListCep) then
    begin
      Clear;
      Width := TCustomImg(Source).Width;
      Height := TCustomImg(Source).Width;
      BkColor := TCustomImg(Source).BkColor;
      BlendColor := TCustomImg(Source).BlendColor;
      ResourceNames.Assign(TImageListCep(Source).ResourceNames);
      CustomImg.Assign(TImageListCep(Source).CustomImg);
    end else
    if (Source is TCustomImageList) then
    begin
      ResourceNames.Assign(nil);
      CustomImg.Assign(TCustomImageList(Source));
    end
    else inherited;
  end;
 finally
   EndUpdate;
   inherited Change;
 end;
end;  

constructor TImageListCep.Create(AOwner: TComponent);
begin
  inherited;
  fCustomImg := TCustomImg.Create(self);
  fCustomImg.Name := 'CustomImg';
  {$IFDEF VER130}
  {$ELSE}
  fCustomImg.SetSubComponent(True);
  {$ENDIF}
  fResourceNames := TResourceNames.Create(self,TResourceName);
  UpdateImages;
end;

procedure TImageListCep.Loaded;
begin
  inherited;
  Inherited Change;
end;

type TTmpControl=class (TControl);

function GetDefBkColor(ImageList:TCustomImageList):TColor;
begin
  result := GetShadowColor(clBtnFace);
  if ImageList<>nil then
  with ImageList do begin
    result := BkColor;
    if ((result = clNone) or (result = clDefault)) and
       (Owner is TControl) and
       (TTmpControl(Owner).Color<>clNone) and
       (TTmpControl(Owner).Color<>clDefault) then
      result := ColorToRGB(TTmpControl(Owner).Color);
    if ((result = clNone) or (result = clDefault)) and
       (Owner is TCustomImg) and
       (TCustomImg(Owner).BkColor<>clNone) and
       (TCustomImg(Owner).BkColor<>clDefault) then
      result := ColorToRGB(TCustomImg(Owner).BkColor);
    if ((result = clNone) or (result = clDefault)) then
      result := GetShadowColor(clBtnFace);
   end;
   result := ColorToRGB(result);
end;

procedure UpdateTransparentBitmap(var Bitmap: TBitmap; Color: TColor);
begin
  if Color = clNone then
    Bitmap.Transparent := false
  else
  begin
    Bitmap.Transparent := true;
    if Color = clDefault then
      Bitmap.TransparentMode := tmAuto
    else
    begin
      Bitmap.TransparentMode := tmFixed;
      Bitmap.TransparentColor := Color;
    end;
  end;
end;

function Scale(DestWidth,DestHeight,SourceWidth,SourceHeight:integer):Double;
var Scale2:Double;
begin
 result := 0;
 if (SourceWidth=0) or (SourceHeight=0) then Exit;
 result := DestWidth/SourceWidth;
 Scale2 := DestHeight/SourceHeight;
 if Scale2<result then result := Scale2;
 if Abs(result-1)<0.01 then result := 1;
end;

procedure TImageListCep.DefineProperties(Filer: TFiler);
{$IFDEF VER130}
  var
  Ancestor: TComponent;
  Info: Longint;
{$ENDIF}
begin
{$IFDEF VER130}
  Info := 0;
  Ancestor := TComponent(Filer.Ancestor);
  if Ancestor <> nil then Info := Ancestor.DesignInfo;

  Filer.DefineProperty(fCustomImg.Name+'.Width',
                       ReadCustomImgWidth,
                       WriteCustomImgWidth,
                       fCustomImg.Width<>16);
  Filer.DefineProperty(fCustomImg.Name+'.Height',
                       ReadCustomImgHeight,
                       WriteCustomImgHeight,
                       fCustomImg.Height<>16);
  Filer.DefineBinaryProperty(fCustomImg.Name+'.Bitmap',
                       ReadCustomImgBitmap,
                       WriteCustomImgBitmap,
                       fCustomImg.Count>0);


  Filer.DefineBinaryProperty('Bitmap', ReadData, WriteData, true);
  Filer.DefineProperty('Left', ReadLeft, WriteLeft,
    LongRec(DesignInfo).Lo <> LongRec(Info).Lo);
  Filer.DefineProperty('Top', ReadTop, WriteTop,
    LongRec(DesignInfo).Hi <> LongRec(Info).Hi);
{$ELSE}
  inherited;
{$ENDIF}
  Filer.DefineProperty('DirName',ReaderProc,WriterProc,DirName<>'');
end;

procedure TImageListCep.DoChanged(Sender: TObject);
begin
  UpdateImages;
  inherited;
end;

procedure TImageListCep.ReaderProc(Reader: TReader);
begin
 try
  fDirName := Reader.ReadString;
 except
  fDirName := '';
 end;
end;

procedure TImageListCep.WriterProc(Writer: TWriter);
begin
  Writer.WriteString(fDirName);
end;

//Следующие процедуры для совместимости с 5 версией
{$IFDEF VER130}
procedure TImageListCep.ReadCustomImgWidth(Reader: TReader);
begin
  fCustomImg.Width := Reader.ReadInteger;
end;

procedure TImageListCep.WriteCustomImgWidth(Writer: TWriter);
begin
  Writer.WriteInteger(fCustomImg.Width);
end;

procedure TImageListCep.ReadCustomImgHeight(Reader: TReader);
begin
  fCustomImg.Height := Reader.ReadInteger;
end;

procedure TImageListCep.WriteCustomImgHeight(Writer: TWriter);
begin
  Writer.WriteInteger(fCustomImg.Height);
end;

procedure TImageListCep.ReadCustomImgBitmap(Stream: TStream);
var
  SA: TStreamAdapter;
begin
  with fCustomImg do
  begin
    SA := TStreamAdapter.Create(Stream);
    try
      Handle := ImageList_Read(SA);
      if Handle = 0 then
        raise EReadError.CreateRes(@SImageReadFail);
    finally
      SA.Free;
    end;
  end;
end;

procedure TImageListCep.WriteCustomImgBitmap(Stream: TStream);
var
  SA: TStreamAdapter;
begin
  with fCustomImg do
  begin
    SA := TStreamAdapter.Create(Stream);
    try
      if not ImageList_Write(Handle, SA) then
        raise EWriteError.CreateRes(@SImageWriteFail);
    finally
      SA.Free;
    end;
  end;
end;

procedure TImageListCep.ReadLeft(Reader: TReader);
var FDesignInfo: Longint;
begin
  FDesignInfo := DesignInfo;
  LongRec(FDesignInfo).Lo := Reader.ReadInteger;
  DesignInfo := FDesignInfo;
end;

procedure TImageListCep.ReadTop(Reader: TReader);
var FDesignInfo: Longint;
begin
  FDesignInfo := DesignInfo;
  LongRec(FDesignInfo).Hi := Reader.ReadInteger;
  DesignInfo := FDesignInfo;
end;

procedure TImageListCep.WriteLeft(Writer: TWriter);
var FDesignInfo: Longint;
begin
  FDesignInfo := DesignInfo;
  Writer.WriteInteger(LongRec(FDesignInfo).Lo);
end;

procedure TImageListCep.WriteTop(Writer: TWriter);
var FDesignInfo: Longint;
begin
  FDesignInfo := DesignInfo;
  Writer.WriteInteger(LongRec(FDesignInfo).Hi);
end;
{$ENDIF}

procedure TImageListCep.ReadData(Stream: TStream);
begin
  //inherited;
end;

procedure TImageListCep.WriteData(Stream: TStream);
begin
  //inherited;
end;

procedure TImageListCep.SetResourceNames(const Value: TResourceNames);
begin
  if Value=nil then
    fResourceNames.Clear
  else
    fResourceNames.Assign(Value);
end;

function TImageListCep.UpdateImages:boolean;
var K,I,ImgCount: integer;
    ResBmp:TBitmap;
begin
 result := false;
 if (CountUpdating>0) or (fInChange) then Exit;
 fInChange := true;
 try
  if (([csUpdating, csDestroying, csLoading] * ComponentState)=[]) and
     (Width>0) and (Height>0) then
  begin
    ImgCount := 0;
    for i := 0 to ResourceNames.Count - 1 do
      inc(ImgCount,ResourceNames.Items[i].GliphCount);
    if (fCustomImg<>nil) then inc(ImgCount,fCustomImg.Count);
    if ImgCount>0 then
    begin
      BeginUpdate;
      ResBmp := nil;
      try
        Clear;
        for I := 0 to ResourceNames.Count - 1 do
        try
          if ResourceNames.Items[i].Name<>'' then
          begin
            ResBmp := TBitmap.Create;
            if not ResourceNames.Items[i].LoadFromResourceName(ResBmp) then
              FreeAndNil(ResBmp)
            else
            begin
              ResBmp.PixelFormat := pf32Bit;
              ResBmp.TransparentColor := ResourceNames.Items[i].TransparentColor;
              UpdateTransparentBitmap(ResBmp, ResourceNames.Items[i].TransparentColor);
            end;
          end
          else ResBmp := nil;
          if ResBmp<>nil then
          begin
            InsertBitmaps(Count,
                          ResBmp,
                          ResourceNames.Items[i].Width,
                          ResourceNames.Items[i].Height,
                          ResourceNames.Items[i].GliphCount);
          end
          else begin
            ResBmp := TBitmap.Create;
            ResBmp.PixelFormat := pf32Bit;
            ResBmp.TransparentColor := clBtnFace;
            ResBmp.Canvas.Brush.Color := clBtnFace;
            ResBmp.Width := (ResourceNames.Items[i].Width*3)div(2);
            ResBmp.Height := (ResourceNames.Items[i].Height*3)div(2);
            for K := 0 to ResourceNames.Items[i].GliphCount - 1 do
            begin
              ResBmp.Canvas.FillRect(Rect(0,0,ResBmp.Width,ResBmp.Height));
              ResBmp.Canvas.Font.Name := 'Small Fonts';
              ResBmp.Canvas.Font.Color := clWindowText;
              ResBmp.Canvas.Font.Size := 7;
              ResBmp.Canvas.TextOut(0,0,Format('%d',[K]));
              ResBmp.Canvas.TextOut(0,8,ResourceNames.Items[i].Name);
              InsertBitmap(Count,ResBmp);
            end;
          end;
        finally
          FreeAndNil(ResBmp);
        end;
        if (fCustomImg<>nil) and (fCustomImg.Count>0) then
        begin
          ResBmp := TBitmap.Create;
          try
            ResBmp.PixelFormat := pf32Bit;
            ResBmp.Transparent := false;
            ResBmp.Width := fCustomImg.Width;
            ResBmp.Height := fCustomImg.Height;
            ResBmp.Canvas.Brush.Color := GetDefBkColor(self);
            for K := 0 to fCustomImg.Count - 1 do
            begin
              ResBmp.Canvas.FillRect(Rect(0,0,ResBmp.Width,ResBmp.Height));
              fCustomImg.Draw(ResBmp.Canvas,0,0,K,true);
              InsertBitmap(Count,ResBmp);
            end;
          finally
            FreeAndNil(ResBmp);
          end;
        end;
      finally
        FreeAndNil(ResBmp);
        EndUpdate
      end;
      result := true;
    end
    else begin
      if Count>0 then
      begin
        Clear;
        result := true;
      end;
    end;
  end;
 finally
  fInChange := false;
  if Timer<>nil then Timer.Stop;
 end;
end;

{ TResourceName }

procedure TResourceName.Assign(Source: TPersistent);
var Name: string;
    Width,Height,GliphCount: integer;
    TransparentColor: TColor;
    FileName: string;
    AutoSize,FileNameDOM: boolean;
begin
  if Source=nil then
  begin
    fName := '';
    fFileName := '';
  end
  else if Source is TResourceName then
  begin
    Name := trim(UpperCase(TResourceName(Source).Name));
    Width := TResourceName(Source).Width;
    Height := TResourceName(Source).Height;
    GliphCount := TResourceName(Source).GliphCount;
    FileName := TResourceName(Source).FileName;
    TransparentColor := TResourceName(Source).TransparentColor;
    AutoSize := TResourceName(Source).AutoSize;
    FileNameDOM := TResourceName(Source).FileNameDOM;
    if (fName<>Name) or
       (fWidth<>Width) or
       (fHeight<>Height) or
       (fGliphCount<>GliphCount) or
       (fFileName<>FileName) or
       (fTransparentColor<>TransparentColor) or
       (fAutoSize<>AutoSize) or
       (fFileNameDOM<>FileNameDOM) then
    begin
      fName := Name;
      fWidth := Width;
      fHeight := Height;
      fGliphCount := GliphCount;
      fFileName := FileName;
      fTransparentColor := TransparentColor;
      fAutoSize := AutoSize;
      fFileNameDOM := FileNameDOM;
      Changed(false);
    end;
  end else inherited;
end;

constructor TResourceName.Create(Collection: TCollection);
begin
  inherited;
  fFileNameDOM := true;
  fWidth := 24;
  fHeight := 24;
  fGliphCount := 8;
  fTransparentColor := clFuchsia;
  fAutoSize := true;
  if (Collection is TResourceNames) and
     (TResourceNames(Collection).ImageListCep<>nil) then
  begin
    if fWidth<=0 then
      fWidth := TResourceNames(Collection).ImageListCep.Width;
    if fHeight<=0 then
      fHeight := TResourceNames(Collection).ImageListCep.Height;
  end;
end;

destructor TResourceName.Destroy;
begin
  FreeHinstance(false);
  inherited;
end;

function EnumResNameProc(Module: hModule;
                         lpszType: PChar;
                         lpszName: PChar;
                         lParam: Pointer):BOOL; stdcall;
var List: TStringList;
begin
  if (lParam<>nil) and (TObject(LParam) is TStringList) then
  begin
    List := TStringList(lParam);
    if lpszType=RT_BITMAP then
    begin
      List.Add(lpszName);
    end;
  end;
  result := true;
end;

procedure TResourceName.EnumResources(List: TStringList);
var L:TStringList;
    i:integer;
begin
  if List = nil then Exit;       
  L := nil;
  try
    if List<>nil then
    begin
      UpdatehInstance(true);
      L := TStringList.Create;
      if fhInstance = 0 then
        EnumResourceNames(hInstance, RT_BITMAP, @EnumResNameProc, integer(L))
      else
        EnumResourceNames(fhInstance, RT_BITMAP, @EnumResNameProc, integer(L));
      List.BeginUpdate;
      try
        for i := 0 to L.Count-1 do
          if List.IndexOf(L[i])=-1 then List.Add(L[I]);
      finally
        List.EndUpdate;
      end;
    end;
  finally
    FreeAndNil(L);
    FreeHinstance(true);
  end;
end;

function TResourceName.UpdatehInstance(RaisedError: Boolean):boolean;
var Designing: boolean;
begin
  Designing := DesignTime or
             ((Collection is TResourceNames) and
              (TResourceNames(Collection).ImageListCep<>nil) and
              (csDesigning in TResourceNames(Collection).ImageListCep.ComponentState));

  result := false;
  if (FileName<>'') and
     ((not fFileNameDOM) or
      (fFileNameDOM and Designing)) then
  begin
    if (fhInstance=0) then begin
      if FileExists(fFileName) then
      begin
        fhInstance := LoadLibraryEx(PChar(fFileName),0,LOAD_LIBRARY_AS_DATAFILE);
        if fhInstance=0 then
          if RaisedError then
              {$IFDEF VER130}
                  RaiseLastWin32Error
              {$ELSE}
                  RaiseLastOSError
              {$ENDIF}
                         else Exit;
        result := true;
      end else
      begin
        if RaisedError then
              {$IFDEF VER130}
                  EWin32Error.CreateFmt(StrNoFile,[fFileName])
              {$ELSE}
                  EOSError.CreateFmt(StrNoFile,[fFileName])
              {$ENDIF}
        else Exit;
      end;
    end else result := true;
  end else
  begin
    FreeHinstance(RaisedError);
    result := true;
  end;
end;

procedure TResourceName.FreeHinstance(RaisedError: Boolean);
begin
  if fhInstance <> 0 then
  begin
    if not FreeLibrary(fhInstance) then
      if RaisedError then
     {$IFDEF VER130}
        RaiseLastWin32Error;
     {$ELSE}
        RaiseLastOSError;
     {$ENDIF}
    fhInstance := 0;
  end;
end;

function TResourceName.GetDisplayName: string;
begin
  result := Name;
  if result='' then
    result := inherited GetDisplayName;
  if result<>'' then result := result+' ';
  result := result+Format('(%dx%d)[%d]',[Width,Height,GliphCount]);
end;

type
  TResourceNameWrapper = class(TComponent)
  private
    fResourceName: TResourceName;
  published
    property ResourceName: TResourceName read fResourceName write fResourceName;
  end;

function TResourceName.LoadFromResourceName(var Bmp: TBitmap;
  RaisedError: boolean): boolean;
begin
  result := UpdatehInstance(RaisedError);
  if not result then Exit;
  try
    try
      if fhInstance=0 then
        Bmp.LoadFromResourceName(hInstance,GetResourceName)
                      else
        Bmp.LoadFromResourceName(fhInstance,GetResourceName);
      result := true;
    finally
      FreeHinstance(RaisedError);
    end;
  except
    if RaisedError then Raise;
  end;
end;

procedure TResourceName.LoadFromStream(S: TStream);
var
  Wrapper: TResourceNameWrapper;
begin
  Wrapper := TResourceNameWrapper.Create(nil);
  try
    Wrapper.ResourceName := TResourceName.Create(nil{GetOwner});
    S.ReadComponent(Wrapper);
    Assign(Wrapper.ResourceName);
  finally
    Wrapper.ResourceName.Free;
    Wrapper.Free;
  end;
end;

function ResourceNameToSize(Name:string; var Size:integer):string;
var S:string;
    i,Code:integer;
begin
  S := Trim(Name);
  result := S;
  I := 0;
  Size := 0;
  while (I<Length(S)) and (I<3) and
        (S[Length(S)-I]>='0')  and (S[Length(S)-I]<='9') do inc(I);
  if (I<Length(S)) and (S[Length(S)-I]='_') then
  begin
    S := Copy(S,Length(S)-I+1,I);
    if S<>'' then Val(S, Size, Code);
    if Code<>0 then Size := -1;
    result := Copy(result,1,Length(result)-I-1);
  end;
end;

function TResourceName.GetResourceName: string;
var S,SS: string;
    i,Size,MinSize,OwnerSize: integer;
    List: TStringList;
    Sizes: array of integer;
begin
  result := Name;
  if (result<>'') and (AutoSize) then
  begin
    List := nil;
    S := ResourceNameToSize(Name,Size);
    OwnerSize := TResourceNames(Collection).ImageListCep.Height;
    if (S<>'') and (OwnerSize>0) then
    try
      List := TStringList.Create;
      EnumResources(List);
      for I := 0 to List.Count - 1 do
      begin
        SS := ResourceNameToSize(List[I],Size);
        if (SS=S) then
        begin
          SetLength(Sizes,Length(Sizes)+1);
          Sizes[High(Sizes)] := Size;
        end;
      end;
      result := S;
      MinSize := MaxInt;
      for I := 0 to Length(Sizes)-1 do
      if (Sizes[i]>=OwnerSize) and (Sizes[i]<MinSize) then
        MinSize := Sizes[I];
      if MinSize = MaxInt then
      begin
        MinSize := 0;
        for I := 0 to Length(Sizes)-1 do
        if Sizes[i]>MinSize then
          MinSize := Sizes[I];
      end;
      if MinSize<>0 then
      begin
        result := S+'_'+inttostr(MinSize);
        if fAutoSize then
        begin
          fWidth := MinSize;
          fHeight := MinSize;
        end;
      end;
    finally
      FreeAndNil(List);
    end;
  end;
end;

procedure TResourceName.SaveToStream(S: TStream);
var
  Wrapper: TResourceNameWrapper;
begin
  Wrapper := TResourceNameWrapper.Create(nil);
  try
    Wrapper.ResourceName := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TResourceName.SetAutoSize(const Value: boolean);
begin
  if fAutoSize<>Value then
  begin
    fAutoSize := Value;
    GetResourceName;
    Changed(false);
  end;
end;

procedure TResourceName.SetDisplayName(const Value: string);
begin
  inherited SetDisplayName(Value);
end;

procedure TResourceName.SetFileName(const Value: String);
begin
  if fFileName <> Value then
  begin
    fFileName := Value;
    FreeHinstance(true);
    Changed(false);
  end;
end;

procedure TResourceName.SetFileNameODM(const Value: boolean);
begin
  if fFileNameDOM<>Value then
  begin
    fFileNameDOM := Value;
    FreeHinstance(true);
    Changed(true);
  end;
end;

procedure TResourceName.SetGliphCount(const Value: Word);
begin
  if fGliphCount <> Value then
  begin
    fGliphCount := Value;
    Changed(true);
  end;
end;

procedure TResourceName.SetHeight(const Value: Byte);
begin
  if (Value<>fHeight) and (Value>0) then
  begin
    fHeight := Value;
  if (Collection is TResourceNames) and
     (TResourceNames(Collection).ImageListCep<>nil) then
    begin
      if fHeight<=0 then
        fHeight := TResourceNames(Collection).ImageListCep.Height;
    end;
    Changed(false);
  end;
end;

procedure TResourceName.SetName(const Value: string);
var V: string;
begin
  V := trim(UpperCase(Value));
  if V<>fName then
  begin
    fName := V;
    Changed(false);
  end;
end;

procedure TResourceName.SetTransparentColor(const Value: TColor);
begin
 if fTransparentColor <> Value then
 begin
  fTransparentColor := Value;
  Changed(false);
 end;
end;

procedure TResourceName.SetWidth(const Value: Byte);
begin
  if (Value<>fWidth) and (Value>0) then
  begin
    fWidth := Value;
    if (Collection is TResourceNames) and
       (TResourceNames(Collection).ImageListCep<>nil) then
    begin
      if fWidth<=0 then
        fWidth := TResourceNames(Collection).ImageListCep.Width;
    end;
    Changed(false);
  end;
end;

{ TResourceNames }

function TResourceNames.AddDefault: TResourceName;
var i:integer;
begin
  result := nil;
  for i := 0 to Count - 1 do
    if Items[i].Name=StandartResourceName then
    begin
      result := Items[i];
      break;
    end;
  if result=nil then
  begin
    result := TResourceName(Add);
    result.Name := StandartResourceName;
    result.GliphCount := 36;
  end;
end;

procedure TResourceNames.Assign(Source: TPersistent);
begin
  if Source=nil then
    Clear
  else inherited;
end;

procedure TResourceNames.BeginUpdate;
begin
  inherited;

end;

procedure TResourceNames.EndUpdate;
begin
  inherited;
end;

function TResourceNames.FindItemByName(Name: string): integer;
var S:String;
    i: integer;
    C:Char;
begin
  result := -1;
  S := '';
  i := 1;
  while i<= Length(Name) do
  begin
    C := UpCase(Name[i]);
    if (C='&') and (i<Length(Name)) and (Name[i+1]='&') then inc(I);
    if (C<#128) and (C>='!') then S := S+C;
    inc(I);
  end;
  for I := 0 to Count - 1 do
    if Items[i].Name=S then
    begin
      result := i;
      exit;
    end;
end;

function TResourceNames.GetItem(Index: Integer): TResourceName;
begin
  result := TResourceName(inherited GetItem(Index));
end;

function TResourceNames.GetImageList: TImageListCep;
begin
  if GetOwner is TImageListCep then
    result := TImageListCep(GetOwner)
  else
    result :=nil;
end;

procedure TResourceNames.SetItem(Index: Integer; const Value: TResourceName);
begin
  inherited SetItem(Index, Value);
end;

procedure TResourceNames.Update(Item: TCollectionItem);
begin
  if (ImageListCep<>nil) and (UpdateCount=0) then
  begin
    ImageListCep.Change;
  end;
end;

{ TCustomImg }

procedure TCustomImg.Assign(Source: TPersistent);
begin
 if Source=nil then
 begin
  BeginUpdate;
  try
   Clear;
   BlendColor := clNone;
   BkColor := clNone;
   Masked := true;
   Tag := 0;
   Width := 16;
   Height := 16;
  finally
   EndUpdate;
  end;
 end else
 begin
  BeginUpdate;
  try
    if Source is TCustomImg then
    begin
      Clear;
      Width := TCustomImg(Source).Width;
      Height := TCustomImg(Source).Width;
      BkColor := TCustomImg(Source).BkColor;
      BlendColor := TCustomImg(Source).BlendColor;
      if TCustomImg(Source).Count>0 then
      begin
        AddImages(TCustomImg(Source));
      end;
    end else inherited Assign(Source);
  finally
    EndUpdate;
  end;
 end;
end;

type
  TCustomImgWrapper = class(TComponent)
  private
    fCustomImg: TCustomImg;
  published
    property CustomImg: TCustomImg read fCustomImg write fCustomImg;
  end;


procedure TCustomImg.LoadFromStream(S: TStream);
var
  Wrapper: TCustomImgWrapper;
begin
  Wrapper := TCustomImgWrapper.Create(nil);
  try
    Wrapper.CustomImg := TCustomImg.Create(nil{GetOwner});
    S.ReadComponent(Wrapper);
    Assign(Wrapper.CustomImg);
  finally
    Wrapper.CustomImg.Free;
    Wrapper.Free;
  end;
end;

procedure TCustomImg.SaveToStream(S: TStream);
var
  Wrapper: TCustomImgWrapper;
begin
  Wrapper := TCustomImgWrapper.Create(nil);
  try
    Wrapper.CustomImg := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TCustomImg.InsertBitmap(Index: integer; Bitmap: TBitmap; ARect:TRect);
var NeedSourceBitmap,NeedDestBitmap,NeedTMPBitmap:boolean;
    Scale1:Double;
    X,Y{,XX}:integer;
    TransparentColor: TColor;
  procedure InsertBmp(Bitmap:TBitmap);
  var X,Y:integer;
  begin
      if (Bitmap.Width<>Width) or (Bitmap.Height<>Height) then
      begin
        if fTMPBitmap=nil then
        begin
          fTMPBitmap := TBitmap.Create;
        end;
        fTMPBitmap.Width := Width;
        fTMPBitmap.Height := Height;
        fTMPBitmap.Canvas.Brush.Color := TransparentColor;
        fTMPBitmap.Canvas.FillRect(Rect(0,0,Width,Height));
        X := (Width-Bitmap.Width)div(2);
        Y := (Height-Bitmap.Height)div(2);
        BitBlt(fTMPBitmap.Canvas.Handle,X,Y,Bitmap.Width,Bitmap.Height,
               Bitmap.Canvas.Handle,0,0,SRCCOPY);
        Bitmap := fTMPBitmap;
      end;
      if Index>=Count then
        AddMasked(Bitmap,TransparentColor{clFuchsia})
      else
        InsertMasked(Index,Bitmap,TransparentColor{clFuchsia});
  end;
begin
  NeedSourceBitmap := fSourceBitmap=nil;
  NeedDestBitmap := fDestBitmap=nil;
  NeedTMPBitmap := fTMPBitmap=nil;
  if Bitmap<>nil then
  try
    if NeedSourceBitmap then fSourceBitmap := TBitmap.Create;
    fSourceBitmap.PixelFormat := pf32Bit;
    fSourceBitmap.Transparent := false;
    fSourceBitmap.Width := Abs(ARect.Right-ARect.Left);
    fSourceBitmap.Height := Abs(ARect.Bottom-ARect.Top);
    X := ARect.Left;
    if X>ARect.Right then X := ARect.Right;
    Y := ARect.Top;
    if Y>ARect.Bottom then Y := ARect.Bottom;
    Scale1 := Scale(Width, Height, fSourceBitmap.Width, fSourceBitmap.Height);
    if Scale1<>0 then
    begin
     //Заполняем фон источника цветом BkColor
     TransparentColor := GetDefBkColor(self);
     fSourceBitmap.Canvas.Brush.Color := TransparentColor;
     fSourceBitmap.Canvas.FillRect(Rect(0,0,fSourceBitmap.Width,fSourceBitmap.Height));
     fSourceBitmap.Canvas.Draw(-X,-Y,Bitmap);
     if Scale1<>1 then
     begin
      if NeedDestBitmap then fDestBitmap := TBitmap.Create;
      fDestBitmap.PixelFormat := pf32Bit;
      fDestBitmap.Transparent := false;
      ScaleImage(fSourceBitmap,fDestBitmap,Scale1);
      InsertBmp(fDestBitmap);
     end else begin
      InsertBmp(fSourceBitmap);
     end;
    end;
  finally
    if NeedDestBitmap then FreeAndNil(fDestBitmap);
    if NeedSourceBitmap then FreeAndNil(fSourceBitmap);
    if NeedTMPBitmap then FreeAndNil(fTMPBitmap);
    
  end;
end;

procedure TCustomImg.BeginUpdate;
begin
 inc(fCountUpdating);
 if fCountUpdating=1 then
 begin
   Updating;
   if fSourceBitmap=nil then
   begin
     fSourceBitmap := TBitmap.Create;
     fSourceBitmap.PixelFormat := pf32Bit;
   end;
   if fDestBitmap=nil then
   begin
     fDestBitmap := TBitmap.Create;
     fDestBitmap.PixelFormat := pf32Bit;
   end;
 end;
end;

procedure TCustomImg.EndUpdate;
begin
 if fCountUpdating>0 then begin
  Dec(fCountUpdating);
  if fCountUpdating=0 then
  begin
    Updated;
    FreeAndNil(fSourceBitmap);
    FreeAndNil(fDestBitmap);
    FreeAndNil(fTMPBitmap);
    Change;
  end;
 end
 else fCountUpdating := 0;
end;

function TCustomImg.GetTimer: TInternalTimer;
begin
  if fTimer=nil then
    fTimer := TInternalTimer.Create(nil);
  result := fTimer;  
end;

procedure TCustomImg.DoChanged(Sender: TObject);
begin
 if Owner is TImageListCep then
 with TImageListCep(Owner) do begin
   if ([csUpdating, csLoading, csDestroying]*ComponentState=[]) and
     (CountUpdating=0) then
     Change;
 end;
 if ([csUpdating, csLoading, csDestroying]*ComponentState=[]) and
     (CountUpdating=0) then
   inherited Change;
end;

procedure TCustomImg.Change;
begin
  if self.Timer<>nil then self.Timer.ExecuteDelay(40,self.DoChanged);
end;

destructor TCustomImg.Destroy;
begin
  FreeAndNil(fSourceBitmap);
  FreeAndNil(fDestBitmap);
  FreeAndNil(fTMPBitmap);
  FreeAndNil(fTimer);
  inherited;
end;

procedure TCustomImg.InsertBitmap(Index: integer; Bitmap: TBitmap);
begin
  InsertBitmap(Index,Bitmap,Rect(0,0,Bitmap.Width,Bitmap.Height));
end;

function TCustomImg.InsertBitmaps(Index: integer; Bitmap: TBitmap;
      Width, Height: integer; Count: integer): Word;
var X,Y,N,i,RowCount,ColCount:integer;
    R: TRect;
    EmptyBitmap:TBitmap;
begin
 result := 0;
 if (Bitmap<>nil) and (Width>0) and (Height>0) then
 begin
  BeginUpdate;
  try
   if Count<0 then
   begin
    InsertBitmap(Index,Bitmap);
    result := 1;
   end
   else begin
    ColCount := (Bitmap.Width+Width-1)div(Width);
    RowCount := (Bitmap.Height+Height-1)div(Height);
    N := RowCount * ColCount;
    if (Count>0) and (N>Count) then N := Count;
    for Y := 0 to RowCount - 1 do
      for X := 0 to ColCount - 1 do
      begin
        if result>=N then break;
        R := Rect(X*Width,Y*Height,(X+1)*Width,(Y+1)*Height);
        InsertBitmap(Index+Result,Bitmap,R);
        inc(result);
      end;
    N := Count-result;
    if N>0 then
    begin
      EmptyBitmap := TBitmap.Create;
      try
        EmptyBitmap.PixelFormat := pf32Bit;
        R := Rect(0,0,N*self.Width,self.Height);
        EmptyBitmap.Width := R.Right;
        EmptyBitmap.Height := R.Bottom;
        with EmptyBitmap.Canvas do
        begin
          Brush.Color := clFuchsia;
          for i := 0 to N-1 do
          begin
            R := Rect(i*self.Width,0,(i+1)*self.Width,self.Height);
            Rectangle(R);
            MoveTo(R.Left,R.Top);
            LineTo(R.Right,R.Bottom);
            MoveTo(R.Right-1,R.Top);
            LineTo(R.Left,R.Bottom-1);
          end;
        end;
        if Index+result>=self.Count then
          AddMasked(EmptyBitmap,clFuchsia)
        else
          InsertMasked(Index+result,EmptyBitmap,clFuchsia);
        inc(result,N);
      finally
        FreeAndNil(EmptyBitmap);
      end;
    end;
   end;
  finally
   EndUpdate;
  end;
 end;
end;

initialization
  DesignTime := false;

end.


