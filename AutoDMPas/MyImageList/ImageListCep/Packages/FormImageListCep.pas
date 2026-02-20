unit FormImageListCep;
//© 2006 Сергей Рощин
//В этом модуле расположена форма редактирования компонента TImageListCep
//Данный модyль не предназначен для коммерческого использования.
//По поводу возможного сотрудничества Вы можете обратиться по
//элестронной почте roschinspb@mail.ru
//http://www.delphikingdom.com/asp/users.asp?ID=1271
interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Controls,
  Forms, Dialogs, ImgList, ImageListCep,
  ActnList, Grids, SysConst,
  ExtDlgs, StdCtrls, ExtCtrls, Mask{, jpeg};

resourcestring
  StrSDxdd = '%s (%dx%d) [%d]';
  StrAOwnerError = 'AOwner должно быть TFormDlgSIL';
  ResLoadError = 'Ошибка %d при загрузке ресурса "%s"'+#13#10+'%s';
  ErrorFormat = 'Формат "%s" не поддерживается';

type
  TTypeAdd = (taScale, taCenter, taDiv);

  TFormOpenResource = class (TCustomForm)
  private
    fHotIndex:integer;
    fSelIndexes:array of integer;
    fPaintBox: TControl;
    fFileName: String;
    fResourceName: string;
    fhInstance: Integer;
    fIcons: TStringList;
    fImageWidth: integer;
    fImageHeight: integer;
    procedure SetFileName(const Value: string);
    procedure FreeHinstance;
    procedure UpdateHinstance;
    function NameByIndex(Index: integer): string;
    function IsSelectedIndex(Index: integer): boolean;
    procedure SelectIndex(Index: integer);
    procedure UnSelectIndex(Index: integer);
    procedure ClickOk(Sender:TObject);
    procedure ClickCancel(Sender:TObject);
  protected
  published
    constructor Create(AOwner:TComponent; AImageWidth:integer=32; AImageHeight:integer=32); reintroduce;
    property FileName:string read fFileName write SetFileName;
    property ResourceName:string read fResourceName;
    property ImageWidth: integer read fImageWidth;
    property ImageHeight: integer read fImageHeight;
    destructor Destroy; override;
  end;

  TFormProp = class (TCustomForm)
  private
   fChild: TPersistent;
   feWidth: TMaskEdit;
   feHeight: TMaskEdit;
   feCount: TMaskEdit;
   {$IFDEF VER130} {$ELSE}
   fColorBox: TColorBox;
   {$ENDIF}
   fResourceBox: TComboBox;
   fEditFileName: TMaskEdit;
   fButtonBrowse:TButton;
   fDLGopen:TOpenDialog;
   fCheckAuto:TCheckBox;
   fCheckDOM:TCheckBox;
   procedure ClickOk(Sender:TObject);
   procedure ClickBrowse(Sender:TObject);
    procedure UpdateResourceNames;
    procedure ClickAuto(Sender: TObject);
    procedure UpdateEnableSize;
    procedure ClickDom(Sender: TObject);
  public
   constructor Create(AOwner:TComponent; AChild:TPersistent); reintroduce;
   procedure DoShow; override;
   property Child: TPersistent read fChild;
  end;

  TOpenPictureDialogCep = class (TOpenPictureDialog)
  private
    {$IFDEF VER130}
    {$ELSE}
    FSavedFilename: string;
    {$ENDIF}
  protected
    procedure DoSelectionChange; override;
  private

  end;

  TFormDlgSIL = class(TForm)
    ButtonAdd: TButton;
    ActionList1: TActionList;
    ActionAdd: TAction;
    ActionInsert: TAction;
    ButtonInsert: TButton;
    ActionDel: TAction;
    ButtonDelete: TButton;
    GroupTypeAdd: TRadioGroup;
    GroupSize: TGroupBox;
    Label1: TLabel;
    EHeight: TMaskEdit;
    eWidth: TMaskEdit;
    CDefaultSize: TCheckBox;
    ActionApply: TAction;
    ButtonApply: TButton;
    ButtonCancel: TButton;
    ActionClose: TAction;
    ActionOk: TAction;
    ButtonOk: TButton;
    ActionMoveNext: TAction;
    ActionMovePrior: TAction;
    ButtonProps: TButton;
    ActionAddStandart: TAction;
    ActionDelResource: TAction;
    ActionPropResource: TAction;
    ActionProps: TAction;
    ActionExport: TAction;
    ButtonExport: TButton;
    SaveDialog1: TSaveDialog;
    ActionExportAll: TAction;
    ActionAddResource: TAction;
    procedure InternalImageListChange(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ActionAddExecute(Sender: TObject);
    procedure ActionInsertExecute(Sender: TObject);
    procedure ActionDelUpdate(Sender: TObject);
    procedure ActionDelExecute(Sender: TObject);
    procedure MEKeyPress(Sender: TObject; var Key: Char);
    procedure EChange(Sender: TObject);
    procedure CDefaultSizeClick(Sender: TObject);
    procedure GroupTypeAddClick(Sender: TObject);
    procedure ActionPriorExecute(Sender: TObject);
    procedure ActionNextExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionApplyExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionOkExecute(Sender: TObject);
    procedure ActionMoveNextExecute(Sender: TObject);
    procedure ActionMovePriorExecute(Sender: TObject);
    procedure ActionAddStandartExecute(Sender: TObject);
    procedure ActionAddBBResourceExecute(Sender: TObject);
    procedure ActionAddStandartUpdate(Sender: TObject);
    procedure ActionDelResourceExecute(Sender: TObject);
    procedure ActionPropResourceExecute(Sender: TObject);
    procedure ActionPropsExecute(Sender: TObject);
    procedure ActionExportExecute(Sender: TObject);
    procedure ActionExportUpdate(Sender: TObject);
    procedure ActionExportAllExecute(Sender: TObject);
    procedure ActionAddResourceExecute(Sender: TObject);
  private
    { Private declarations }
    fItemIndex: integer;
    fAddedWidth:integer;
    fAddedHeight:integer;
    fAddedDefaultSize: boolean;
    fTypeAdd: TTypeAdd;
    fInternalImageList: TImageListCep;
    fImageListCep: TImageListCep;
    fGrid:TCustomGrid;
    fItemDel: TObject;
    fItemProp: TObject;
    fOpenPictureDialogCep: TOpenPictureDialogCep;
    procedure OpenFile(FileName:string; Index:integer; Image: TImage=nil);
    procedure SetItemIndex(const Value: integer);
    procedure SetAddedHeight(const Value: integer);
    procedure SetAddedWidth(const Value: integer);
    procedure SetAddedDefaultSize(const Value: boolean);
    procedure SetTypeAdd(const Value: TTypeAdd);
    procedure UpdateESize;
    procedure SetInternalImageList(const Value: TImageListCep);
    procedure SetImageListCep(const Value: TImageListCep);
    procedure CreatePopupMenuGrid(const SelResource: Integer);
    procedure PopupUpdate(Sender: TObject);
    function CreateMenuItem(Action: TAction):TObject;
    procedure UpdateGrid;
    procedure UpdateCaption;
    procedure SaveToRes(B: TBitmap);
    procedure DoExport(All: Boolean);
    procedure DrawPreview(IMGList: TImageListCep; Image: TImage);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    // Эта процедура вызывается после загрузки изображения стандартными методами
    // Если формат не поддерживается должно быть возвращено значение False
    function LoadFiles(Ext: String;      // Расширение файла
                       Instance: hinst;  // Дескриптор загруженного модуля
                       FileNames: string;// Имена файлов, или ресурсов (если Instance<>0)
                       Width, Height: integer; // Размер одного изображения
                   var Bitmap: TBitmap):boolean; virtual;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    property ItemIndex:integer read fItemIndex write SetItemIndex;
    property AddedWidth:integer read fAddedWidth write SetAddedWidth;
    property AddedHeight:integer read fAddedHeight write SetAddedHeight;
    property AddedDefaultSize:boolean read fAddedDefaultSize write SetAddedDefaultSize;
    property TypeAdd:TTypeAdd read fTypeAdd write SetTypeAdd;
    property InternalImageList:TImageListCep read fInternalImageList;
    property ImageListCep:TImageListCep read fImageListCep write SetImageListCep;
    property OpenPictureDialogCep: TOpenPictureDialogCep read fOpenPictureDialogCep;
  end;

var
  FormDlgSIL: TFormDlgSIL;

const Margin=8;

implementation
uses ShellAPI,Menus,InternalTimer,GraphUtil;

resourcestring
  StrDel = 'Удалить ';
  ErrAChildType = 'AChild должен быть TResourceName, или TCustomImg';
  StrProps = 'Свойства ';
  StrWidth = 'Ширина изображения:';
  StrHeight = 'Высота изображения:';
  StrCount = 'Количество:';
  StrFileName = 'Имя файла:';
  StrResourceName = 'Название ресурса:';
  StrTransparentColor = 'Прозрачный цвет:';
  StrCancel = 'Отмена';
  StrBrowse = 'Обзор';
  StrOk = 'Ok';
  StrDOM = 'Только при дизайне';
  StrAuto = 'Автоматически';
  StrFileRes = 'Файл с ресурсом';
  StrExeDllexe = 'Файлы с ресурсами (*.exe; *.dll)|*.exe;*.dll|Bce(*.*)|*.*';

{$R *.dfm}

type
  TImgGrid = class (TCustomGrid)
  private
    fForm: TFormDlgSIL;
    fTh : integer;
    fTw : integer;
    fMovedCol: integer;
    fNewCol: integer;
    fDragImageList: TDragImageList;
    fClickedRow: integer;
    procedure DrawDropPos(ARect: TRect; ACol: Integer; ARow: Integer);
    procedure WMDROPFILES(var Message:TWMDROPFILES); message WM_DROPFILES;
    procedure EventLeft(Sender:TObject);
    procedure EventRight(Sender:TObject);
  protected
    fTimer: TInternalTimer;
    function GetTimer(Event:TNotifyEvent): TInternalTimer;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;

    function GetDragImages: TDragImageList; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    property ClickedRow:integer read fClickedRow;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure UpdateGrid;
  end;

constructor TFormDlgSIL.Create(AOwner: TComponent);
begin
  inherited;
  fOpenPictureDialogCep := TOpenPictureDialogCep.Create(self);
  fOpenPictureDialogCep.Options := [ofHideReadOnly,ofAllowMultiSelect,ofEnableSizing];
  fOpenPictureDialogCep.Filter := GraphicFilter(TGraphic)+'|'+StrExeDllexe;
  fGrid := TImgGrid.Create(self);
  fInternalImageList := TImageListCep.Create(self);
  fInternalImageList.onChange := InternalImageListChange;
  AddedWidth := 32;
  AddedHeight := 32;
  AddedDefaultSize := true;
  TypeAdd := taDiv;
  KeyPreview := True;
  CreatePopupMenuGrid(-1);
  UpdateCaption;
end;

destructor TFormDlgSIL.Destroy;
begin
  inherited;
end;

procedure TFormDlgSIL.DrawPreview(IMGList: TImageListCep; Image: TImage);
var Dx,Dy,X,Y,i: integer;
begin
  if (Image <> nil) and (IMGList <> nil) then
  begin
    Image.Transparent := false;
    Image.Stretch := false;
    with Image.Picture.Bitmap do
    begin
      Width := Image.Width;
      Height := Image.Height;
      Canvas.Brush.Color := self.Color;
      Canvas.FillRect(Rect(0, 0, Width, Height));
      Y := Height div (IMGList.Height);
      if Y<1 then Y := 1;
      Dy := (Height - (Y*IMGList.Height))div(Y+1);
      X := Width div (IMGList.Width);
      if X<1 then X := 1;
      Dx := (Width - (X*IMGList.Width))div(X+1);

      X := Dx;
      Y := Dy;
      Canvas.Brush.Style := bsClear;
      for I := 0 to IMGList.Count - 1 do
      begin
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo(X,Y+IMGList.Height);
        Canvas.LineTo(X+IMGList.Width, Y+IMGList.Height);
        Canvas.LineTo(X+IMGList.Width, Y-1);
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo(X+IMGList.Width-1, Y-1);
        Canvas.LineTo(X-1, Y-1);
        Canvas.LineTo(X-1, Y+IMGList.Height);
        IMGList.Draw(Canvas, X, Y, i, true);
        if ((X+2*(IMGList.Width+Dx))>Width) and (X>Dx) then
        begin
          X := Dx;
          inc(Y, IMGList.Height+DY);
        end
        else inc(X,IMGList.Width+Dx);
        if Y+Dy>Height then Break;
      end;
    end;
  end;
end;

procedure TFormDlgSIL.DoExport(All: Boolean);
var
  B: TBitmap;
  FileExt: string;
  procedure UpdateBitmap(Img: TCustomImg);
  var i: Integer;
  begin
    with Img do
    begin
      B.Width := Count * Width;
      B.Height := Height;
      if (BlendColor = clNone) or (BlendColor = clDefault) then
        B.Canvas.Brush.Color := clFuchsia
      else
        B.Canvas.Brush.Color := BlendColor;
      B.Canvas.FillRect(Rect(0, 0, B.Width, B.Height));
      for i := 0 to Count - 1 do
        Draw(B.Canvas, i * Width, 0, i);
    end;
  end;
begin
  B := TBitmap.Create;
  try
    B.PixelFormat := pf32Bit;
    if All then UpdateBitmap(InternalImageList)
           else UpdateBitmap(InternalImageList.CustomImg);
    FileExt := ExtractFileExt(SaveDialog1.FileName);
    B.PixelFormat := pf24Bit;
    if UpperCase(FileExt) = '.RES' then
      SaveToRes(B)
    else
      B.SaveToFile(SaveDialog1.FileName);
  finally
    FreeAndNil(B);
  end;
end;

procedure TFormDlgSIL.SaveToRes(B: TBitmap);
var
  STARTUPINFO: _STARTUPINFOA;
  PROCESS: _PROCESS_INFORMATION;
  A: array[0..255] of Char;
  Path,FileName,TmpFileName,RCFileName: string;
  List: TStringList;
begin
  List := nil;
  FileName := SaveDialog1.FileName;
  RCFileName := ChangeFileExt(FileName, '.RC');
  Path := ExtractFilePath(FileName);
  FileName := ExtractFileName(FileName);
  GetTempFileName(PChar(Path), 'Cep', 0, @A);
  TmpFileName := string(PChar(@A));
  B.SaveToFile(TmpFileName);
  try
    List := TStringList.Create;
    List.Text := UpperCase(ChangeFileExt(FileName, '')) + ' BITMAP ' + AnsiQuotedStr(TmpFileName, '"');
    List.SaveToFile(RCFileName);
    try
      List.Clear;
      ZeroMemory(@STARTUPINFO, SizeOf(STARTUPINFO));
      STARTUPINFO.cb := SizeOf(STARTUPINFO);
      STARTUPINFO.dwFlags := STARTF_USESHOWWINDOW;
      STARTUPINFO.wShowWindow := SW_HIDE;
      ZeroMemory(@PROCESS, SizeOf(PROCESS));
      if CreateProcess(nil,
                       PChar('BRCC32.EXE '+AnsiQuotedStr(RCFileName,'"')),
                       nil,
                       nil,
                       true,
                       CREATE_NEW_CONSOLE,
                       nil,
                       nil,
                       STARTUPINFO,
                       PROCESS) then
      begin
        WaitForSingleObject(PROCESS.hProcess, 5000);
        CloseHandle(PROCESS.hProcess);
        CloseHandle(PROCESS.hThread);
      end
      else
        {$IFDEF VER130}
        RaiseLastWin32Error;
        {$ELSE}
        RaiseLastOsError;
        {$ENDIF}
    finally
      DeleteFile(RCFileName);
    end;
  finally
    List.Free;
    DeleteFile(TmpFileName);
  end;
end;

procedure TFormDlgSIL.UpdateCaption;
begin
  if fImageListCep <> nil then
  begin
    if fImageListCep.Name = '' then
      Caption := fImageListCep.ClassType.ClassName
    else
      Caption := fImageListCep.Name;
    if fImageListCep.DirName<>'' then
    begin
      OpenPictureDialogCep.InitialDir := fImageListCep.DirName;
    end;
  end else
    Caption := '';
end;

function TFormDlgSIL.CreateMenuItem(Action: TAction):TObject;
var
  Item: TMenuItem;
begin
  Item := TMenuItem.Create(fGrid);
  try
   Item.Action := Action;
   TImgGrid(fGrid).PopupMenu.Items.Add(Item);
   result := Item;
  except
   FreeAndNil(Item);
   raise;
  end;
end;

procedure TFormDlgSIL.CreatePopupMenuGrid(const SelResource: Integer);
var
  Item: TMenuItem;
begin
  if TImgGrid(fGrid).PopupMenu=nil then
  begin
    TImgGrid(fGrid).PopupMenu := TPopupMenu.Create(fGrid);
    try
      TImgGrid(fGrid).PopupMenu.OnPopup := PopupUpdate;
      fItemProp := CreateMenuItem(ActionPropResource);
      CreateMenuItem(ActionAddStandart);
      CreateMenuItem(ActionAddResource);
      Item := TMenuItem.Create(fGrid);
      Item.Caption := '-';
      TImgGrid(fGrid).PopupMenu.Items.Add(Item);
      fItemDel := CreateMenuItem(ActionDelResource);
    except
      TImgGrid(fGrid).PopupMenu.Free;
      TImgGrid(fGrid).PopupMenu := nil;
      raise;
    end;
  end;
  with InternalImageList do
  if (SelResource<0) or (SelResource>ResourceNames.Count) then
  begin
    ActionDelResource.Caption := StrDel;
    ActionDelResource.Enabled := false;
    ActionDelResource.Tag := -1;
    ActionPropResource.Caption := StrProps;
    ActionPropResource.Enabled := false;
    ActionPropResource.Tag := -1;
  end else begin
    ActionDelResource.Tag := SelResource;
    ActionPropResource.Tag := SelResource;
    ActionPropResource.Enabled := true;
    if SelResource>=ResourceNames.Count then
    begin
      ActionDelResource.Caption := StrDel + CustomImg.Name+'...';
      ActionDelResource.Enabled := CustomImg.Count>0;
      ActionPropResource.Caption := StrProps + CustomImg.Name+'...';
    end else
    begin
      ActionDelResource.Caption := StrDel + ResourceNames.Items[SelResource].Name+'...';
      ActionDelResource.Enabled := true;
      ActionPropResource.Caption := StrProps + ResourceNames.Items[SelResource].Name+'...';
    end;
  end;

end;

procedure TFormDlgSIL.PopupUpdate(Sender: TObject);
begin
  CreatePopupMenuGrid(TImgGrid(fGrid).ClickedRow);
end;

procedure TFormDlgSIL.ActionPriorExecute(Sender: TObject);
begin
  if ItemIndex>0 then
    ItemIndex := ItemIndex-1;
end;

procedure TFormDlgSIL.ActionPropResourceExecute(Sender: TObject);
var Obj:TPersistent;
    F: TFormProp;
    Pt: TPoint;
begin
  Obj := nil;
  if Sender is TAction then
  with InternalImageList do begin
    if TAction(Sender).Tag>=ResourceNames.Count then
      Obj := InternalImageList.CustomImg
    else if TAction(Sender).Tag>=0 then
      Obj := InternalImageList.ResourceNames.Items[TAction(Sender).Tag];
  end;
  if Obj<>nil then
  begin
    F := TFormProp.Create(self,Obj);
    try
      Pt := Mouse.CursorPos;
      Dec(Pt.X,32);
      Dec(Pt.Y,16);
      if Pt.X<0 then Pt.X := 0;
      if Pt.Y<0 then Pt.Y := 0;

      F.SetBounds(Pt.X,Pt.Y,F.Width,F.Height);
      F.ShowModal;
    finally
      FreeAndNil(F);
    end;
  end;
end;

procedure TFormDlgSIL.ActionPropsExecute(Sender: TObject);
var F: TFormProp;
    Pt: TPoint;
begin
  F := TFormProp.Create(self,self.InternalImageList);
  try
    Pt := Point(0,ButtonProps.Height);
    Pt := ButtonProps.ClientToScreen(Pt);
    F.Left := Pt.X;
    F.Top := Pt.Y;
    if ImageListCep<>nil then
      F.Caption := ImageListCep.Name;
    F.ShowModal;
    //UpdateGrid;
  finally
    FreeAndNil(F);
  end;
end;

procedure TFormDlgSIL.ActionAddBBResourceExecute(Sender: TObject);
begin
  Repaint;
end;

procedure TFormDlgSIL.ActionAddStandartExecute(Sender: TObject);
begin
  InternalImageList.ResourceNames.AddDefault;
end;

procedure TFormDlgSIL.ActionAddStandartUpdate(Sender: TObject);
begin
  if Sender is TAction then
  with InternalImageList.ResourceNames do begin
    TAction(Sender).Enabled := FindItemByName(StandartResourceName)<0;
  end;
end;

procedure TFormDlgSIL.ActionApplyExecute(Sender: TObject);
begin
  if ImageListCep<>nil then
  begin
    ImageListCep.Assign(InternalImageList);
    fImageListCep.DirName := OpenPictureDialogCep.InitialDir;
  end;
end;

procedure TFormDlgSIL.ActionCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormDlgSIL.ActionAddExecute(Sender: TObject);
begin
  if OpenPictureDialogCep.Execute then
  begin
    OpenPictureDialogCep.InitialDir := ExtractFilePath(OpenPictureDialogCep.FileName);
    OpenFile('',InternalImageList.CustomImg.Count);
  end;
end;

procedure TFormDlgSIL.ActionAddResourceExecute(Sender: TObject);
var Obj:TPersistent;
    F: TFormProp;
    Pt: TPoint;
begin
  Obj := InternalImageList.ResourceNames.Add;
  if Obj<>nil then
  begin
    F := TFormProp.Create(self,Obj);
    try
      Pt := Mouse.CursorPos;
      Dec(Pt.X,32);
      Dec(Pt.Y,16);
      if Pt.X<0 then Pt.X := 0;
      if Pt.Y<0 then Pt.Y := 0;

      F.SetBounds(Pt.X,Pt.Y,F.Width,F.Height);
      if F.ShowModal=idCancel then
        InternalImageList.ResourceNames.Delete(InternalImageList.ResourceNames.Count-1);
    finally
      FreeAndNil(F);
    end;
  end;
end;

procedure TFormDlgSIL.ActionDelExecute(Sender: TObject);
var N:integer;
begin
  if Sender is TAction then
  begin
    N := InternalImageList.CustomImg.Count;
    if (N>0) and (ItemIndex>=0) and (ItemIndex<N) then
    begin
      InternalImageList.CustomImg.Delete(ItemIndex);
      dec(N);
      if (ItemIndex>=N) and (N>0) then ItemIndex := N-1;
    end;
  end;
end;

procedure TFormDlgSIL.ActionDelResourceExecute(Sender: TObject);
begin
  if Sender is TAction then
  with InternalImageList do begin
    if TAction(Sender).Tag>=ResourceNames.Count then
    begin
      InternalImageList.CustomImg.Clear;
      ItemIndex :=0;
    end else
      if TAction(Sender).Tag>=0 then
        InternalImageList.ResourceNames.Delete(TAction(Sender).Tag);
  end;
end;

procedure TFormDlgSIL.ActionDelUpdate(Sender: TObject);
var N:integer;
begin
  if Sender is TAction then
  begin
    N := InternalImageList.CustomImg.Count;
    TAction(Sender).Enabled := (N>0) and (ItemIndex>=0) and (ItemIndex<N);
  end;
end;

procedure TFormDlgSIL.ActionExportAllExecute(Sender: TObject);
begin
  if (InternalImageList.Count>0) and (SaveDialog1.Execute) then
    DoExport(true);
end;

procedure TFormDlgSIL.ActionExportExecute(Sender: TObject);
begin
  if (InternalImageList.CustomImg.Count>0) and (SaveDialog1.Execute) then
    DoExport(false);
end;

procedure TFormDlgSIL.ActionExportUpdate(Sender: TObject);
begin
 if Sender is TAction then
   TAction(Sender).Enabled := InternalImageList.CustomImg.Count>0;
end;

procedure TFormDlgSIL.ActionInsertExecute(Sender: TObject);
begin
  if OpenPictureDialogCep.Execute then
  begin
    OpenPictureDialogCep.InitialDir := ExtractFilePath(OpenPictureDialogCep.FileName);
    OpenFile('',ItemIndex);
  end;
end;

procedure TFormDlgSIL.ActionMoveNextExecute(Sender: TObject);
begin
  if ItemIndex<InternalImageList.CustomImg.Count-1 then
  begin
    InternalImageList.CustomImg.Move(ItemIndex,ItemIndex+1);
    ItemIndex := ItemIndex+1;
  end;
end;

procedure TFormDlgSIL.ActionMovePriorExecute(Sender: TObject);
begin
  if (ItemIndex>0) and
     (ItemIndex<InternalImageList.CustomImg.Count)  then
  begin
    InternalImageList.CustomImg.Move(ItemIndex,ItemIndex-1);
    ItemIndex := ItemIndex-1;
  end;
end;

procedure TFormDlgSIL.ActionNextExecute(Sender: TObject);
begin
  if ItemIndex<InternalImageList.CustomImg.Count then
    ItemIndex := ItemIndex+1;
end;

procedure TFormDlgSIL.ActionOkExecute(Sender: TObject);
begin
  ActionApply.Execute;
  Close;
end;

// Этот виртуальный метод предназначен для загрузки графических файлов
// нестандартными методами.
// Если формат не поддерживается, то возвращается False
function TFormDlgSIL.LoadFiles(Ext:String;          // Расширение файла (ICO, BMP, DLL
                               Instance: hinst;      // Дескриптор загруженного модуля
                               FileNames: string;    // Названия файлов, или ресурсов (разделены ';')
                               Width,Height:integer; // Размер загружаемого изображения
                           var Bitmap:TBitmap):Boolean;      // Изображение, которое будет добавлено (м. б. NIL)
begin
  result :=  not ((pos(EXT,'EXE;DLL;BMP;ICO')=0) and ((Bitmap=nil) or (Bitmap.Empty)));
end;

// Это основная процедура добавляющая список файлов, или формирующая
// предварительный просмотр
procedure TFormDlgSIL.OpenFile(FileName:string; Index:integer; Image: TImage=nil);
var
  W, H, I, J, K, N: Integer;
  S, GetFileName, IconsNames: string;
  Bmp: TBitmap;
  R: TRect;
  F: TFormOpenResource;
  IMGList: TImageListCep;
  Pic: TPicture;
  //Выполняем загрузку иконок
  procedure LoadIcon(EXT: string; Instance: hinst; Name:string);
  var HI: HICON;
      PIconName: Pointer;
      S, GetName: string;
      Flag: Cardinal;
      i, J: integer;
  begin
   //Несколько названий ресурсов могут быть разделены ';'
   J := 0;
   repeat
    i := Pos(';', Name);
    if i=0 then
    begin
      GetName := Name;
      Name := '';
    end else
    begin
      GetName := Copy(Name,1,i-1);
      Delete(Name,1,i);
    end;

    HI := 0;
    Bmp := nil;
    try
      Flag := LR_LOADMAP3DCOLORS;
      if (Instance<>0) and (GetName<>'') then
      begin
        if (GetName[1] ='#') then
        begin
          S := copy(GetName,2,Length(GetName));
          PIconName := MAKEINTRESOURCE(StrToInt(S));
        end else
          PIconName := PChar(GetName);
      end else
      begin
        PIconName := PChar(GetName);
        Flag := Flag or LR_LOADFROMFILE;
      end;
      HI := LoadImage(Instance, PIconName,
                      IMAGE_ICON,
                      W,
                      H,
                      Flag);
      Bmp := TBitmap.Create;
      Bmp.PixelFormat := pf32Bit;
      Bmp.Canvas.Brush.Color := ImgList.CustomImg.BkColor;
      Bmp.Width := ImgList.CustomImg.Width;
      Bmp.Height := ImgList.CustomImg.Height;
      if (Bmp.Canvas.Brush.Color = clDefault) or (Bmp.Canvas.Brush.Color = clNone) then
        Bmp.Canvas.Brush.Color := clBtnFace;
      Bmp.TransparentColor := Bmp.Canvas.Brush.Color;
      Bmp.TransparentMode := tmFixed;
      Bmp.Transparent := True;
      Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));
      DrawIconEx(Bmp.Canvas.Handle, 0, 0, HI, Bmp.Width, Bmp.Height, 0, Bmp.Canvas.Brush.Handle, DI_NORMAL);
      if (not LoadFiles(Ext,Instance,GetName,W,H,Bmp)) and (Image=nil) then
        raise EInvalidGraphic.CreateFmt(ErrorFormat, [Ext]);;
      if Bmp<>nil then
      begin
        ImgList.CustomImg.InsertBitmap(Index+J, Bmp);
        inc(J);
      end;
    finally
      Bmp.Free;
      DestroyIcon(HI);
    end;
   until Name='';
  end;
  //Загружаем битмап
  procedure LoadBmp(var Bmp: TBitmap);
  var TAdd:TTypeAdd;
  begin
    if (BMP<>nil) then
    begin
      if not BMP.Empty then
      begin
          TAdd := TypeAdd;
          // Ограничиваем размер изображения для скорости
          if Image<>nil then
          begin
            if Bmp.Width*Bmp.Height>Image.Width*Image.Height then
            begin
              if Bmp.Width>Image.Width then
                Bmp.Width := ImgList.Width*((Image.Width)div(ImgList.Width));
              if Bmp.Height>Image.Height then
                Bmp.Height := ImgList.Height*((Image.Height)div(ImgList.Height));
            end;
          end;
          Bmp.PixelFormat := pf32Bit;
          Bmp.Transparent := true;
          case TAdd of
            taScale: ImgList.CustomImg.InsertBitmap(Index+J, Bmp);
            taCenter: begin
              R.Left := (Bmp.Width-W)div(2);
              R.Top := (Bmp.Height-H)div(2);
              R.Right := R.Left + W;
              R.Bottom := R.Top + H;
              ImgList.CustomImg.InsertBitmap(Index+J, Bmp, R);
            end;
            taDiv: begin
              ImgList.CustomImg.InsertBitmaps(Index+J, Bmp, W, H);
            end;
          end;
          inc(J);
      end;
    end;
  end;
begin
 if Image<>nil then   //Если есть картинка предварительного просмотра,
 begin                //то создаем временную коллекцию
   IMGList := TImageListCep.Create(nil);
   Index := 0;
   with IMGList do
   begin
     Width := InternalImageList.CustomImg.Width;
     Height := InternalImageList.CustomImg.Height;
     BkColor := InternalImageList.BkColor;
     BlendColor := InternalImageList.BlendColor;
     with CustomImg do
     begin
       Width := InternalImageList.CustomImg.Width;
       Height := InternalImageList.CustomImg.Height;
       BkColor := InternalImageList.CustomImg.BkColor;
       BlendColor := InternalImageList.CustomImg.BlendColor;
     end;
   end;
 end else IMGList := InternalImageList;
 try
  J := 0;
  // Формируем список открываемых файлов
  if FileName='' then
  begin
    for i := 0 to OpenPictureDialogCep.Files.Count - 1 do
      if FileName=''  then FileName := OpenPictureDialogCep.Files[i]
                      else FileName := FileName+';'+OpenPictureDialogCep.Files[i];
  end;
  OpenPictureDialogCep.InitialDir := ExtractFilePath(FileName);
  // Получаем размер добавляемого изображения
  if AddedDefaultSize then
  begin
    W := ImgList.CustomImg.Width;
    H := ImgList.CustomImg.Height;
  end else begin
    W := AddedWidth;
    H := AddedHeight;
  end;
  //Несколько названий файлов могут быть разделены ';'
  repeat
    // Получаем очередное имя одного файла
    i := Pos(';', FileName);
    if i=0 then
    begin
      GetFileName := FileName;
      FileName := '';
    end else
    begin
      GetFileName := Copy(FileName,1,i-1);
      Delete(FileName,1,i);
    end;
    // Получаем расширение файла
    S := ExtractFileExt(UpperCase(GetFileName));
    while (Length(S) > 0) and (S[1] = '.') do Delete(S, 1, 1);
    //Для разных расширений выполняем разные действия
    if S = 'ICO' then  // Просто загружаем одну иконку
    begin
      LoadIcon(S, 0, GetFileName);
    end else
    if (S = 'DLL') or (S = 'EXE') then  // Из DLL и EXE файлов дополнительно
    begin                               // выбираем иконки в специальной форме
      F := TFormOpenResource.Create(self,W,H);
      try
        try
          F.FileName := GetFileName;
        except
          if Image<>nil then Image.Visible := false // При предварительном просмотре не отображаем ошибку
                        else raise;
        end;
        if Image<>nil then
        begin
          //Формируем список из названий всех иконок
          IconsNames := '';
          if F.fIcons<>nil then
            N := F.fIcons.Count-1
          else
            N := -1;
          if N>39 then N := 39; //Грузим не более 40, для скорости
          for K := 0 to N do
          begin
            if IconsNames='' then IconsNames := F.fIcons[K]
                             else IconsNames := IconsNames +';'+F.fIcons[K];
          end;
          LoadIcon(S,F.fhInstance, IconsNames);
        end else if F.ShowModal=IdOk then
        begin
          //Выбираем несколько иконок мышкой
          LoadIcon(S,F.fhInstance, F.ResourceName);
        end;
      finally
        FreeAndNil(F);
      end;
    end else
    if S='BMP' then
    begin
      Bmp := TBitmap.Create;
      try
        Bmp.LoadFromFile(GetFileName);
        if (not LoadFiles(S,0,GetFileName,W,H,Bmp)) and (Image=nil) then
          raise EInvalidGraphic.CreateFmt(ErrorFormat, [S]);;
        LoadBmp(BMP);
      finally
        FreeAndNil(Bmp);
      end;
    end
    else begin   // Все остальные возможные расширения
      Bmp := TBitmap.Create;
      try
        // Здесь пытаемся загрузить изображение из файла
        try
          Pic := TPicture.Create;
          try
            Bmp.PixelFormat := pf32Bit;
            Bmp.Canvas.Brush.Color := ImgList.CustomImg.BkColor;
            if (Bmp.Canvas.Brush.Color = clDefault) or (Bmp.Canvas.Brush.Color = clNone) then
              Bmp.Canvas.Brush.Color := clBtnFace;
            Bmp.TransparentColor := Bmp.Canvas.Brush.Color;
            Bmp.TransparentMode := tmFixed;
            Bmp.Transparent := True;
            Bmp.Canvas.FillRect(Rect(0, 0, Bmp.Width, Bmp.Height));
            // TPicture.LoadFromFile позволяет загрузить все зарегистрированные
            // графические форматы. Например чтобы иметь возможность загружать
            // *.jpg надо добавить модуль JPEG либо в этот модуль, либо в
            // один из модулей программы. см. также RegisterFileFormat
            Pic.LoadFromFile(GetFileName);
            // Рисуем загруженное изображение на Bmp
            Bmp.Width := Pic.Graphic.Width;
            Bmp.Height := Pic.Graphic.Height;
            Bmp.Canvas.Draw(0,0,Pic.Graphic);
          finally
            FreeAndNil(Pic);
          end;
        except
          // В случае, если неудалось загрузить изображение
          // не выводим ошибку, а делаем еще одну попытку в процедуре
          // LoadFiles
          FreeAndNil(BMP);
        end;
        if (not LoadFiles(S,0,GetFileName,W,H,Bmp)) and (Image=nil) then
          raise EInvalidGraphic.CreateFmt(ErrorFormat, [S]);;
        LoadBmp(BMP);
      finally
        FreeAndNil(Bmp);
      end;
    end;
    if Image<>nil then break;   // При предварительном просмотре выводим только один файл
  until FileName='';
 finally
  try
    if Image<>nil then
    begin
      //Если есть картинка предварительного просмотра, то выводим в нее
      //временную коллекцию
      IMGList.UpdateImages;
      DrawPreview(IMGList, Image);
    end;
  finally
    if IMGList <> InternalImageList then
      FreeAndNil(IMGList);
  end;
 end;
end;

procedure TFormDlgSIL.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var D,I:integer;
begin
  D:=0;
  if WheelDelta>0 then D:=-1;
  if WheelDelta<0 then D:=1;
  if ssShift in Shift then
  begin
    if (D<>0) and (InternalImageList.CustomImg.Count>1) then
    begin
      I := ItemIndex;
      inc(I,D);
      if I<0 then
        I := 0
      else if I>=InternalImageList.CustomImg.Count then
        I := InternalImageList.CustomImg.Count-1;
      if I<>ItemIndex then
      begin
        if ssCtrl in Shift then
        begin
          InternalImageList.CustomImg.Move(ItemIndex,I);
        end;
        ItemIndex := I;
      end;
    end;
    Handled :=true;
  end else
  begin
    Handled :=true;
    I := TImgGrid(fGrid).LeftCol + D;
    if (I>=TImgGrid(fGrid).FixedCols) and
       (I+TImgGrid(fGrid).VisibleColCount<=TImgGrid(fGrid).ColCount) then
    begin
      TImgGrid(fGrid).LeftCol := I;
      fGrid.Repaint;
    end;
  end;
end;

procedure TFormDlgSIL.UpdateGrid;
begin
  if (fGrid<>nil) and (not (csDestroying in ComponentState)) then
  begin
    TImgGrid(fGrid).UpdateGrid;
  end;
end;

procedure TFormDlgSIL.FormShow(Sender: TObject);
begin
  UpdateGrid;
end;

procedure TFormDlgSIL.InternalImageListChange(Sender: TObject);
begin
  UpdateGrid;
end;

procedure TFormDlgSIL.MEKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and (Sender is TWinControl) then
  begin
    SelectNext(TWinControl(Sender),true,true);
    Key := #0;;
  end;
  if not (Key in ['0','1','2','3','4','5','6','7','8','9',#8]) then
    Key := #0;
end;

procedure TFormDlgSIL.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if csDestroying in ComponentState then Exit;
  if (AComponent=fInternalImageList) and (Operation=opRemove) then
  begin
    fInternalImageList := nil;
    SetInternalImageList(nil);
  end;
end;

procedure TFormDlgSIL.EChange(Sender: TObject);
var I:integer;
begin
  if TMaskEdit(Sender).Text='' then
    TMaskEdit(Sender).Text := '32';
  if Sender is TMaskEdit then
  begin
    I := StrToInt(TMaskEdit(Sender).Text);
    if Sender = EHeight then AddedHeight := I;
    if Sender = EWidth then AddedWidth := I;
  end;
end;

procedure TFormDlgSIL.UpdateESize;
begin
  if (fAddedDefaultSize) or (fTypeAdd=taScale) then
  begin
    EHeight.Enabled := false;
    EWidth.Enabled :=false;
    EHeight.ParentColor := true;
    EWidth.ParentColor := true;
  end
  else
  begin
    EHeight.Enabled := true;
    EWidth.Enabled :=true;
    EHeight.Color := clWindow;
    EWidth.Color := clWindow;
  end;
end;

procedure TFormDlgSIL.SetAddedDefaultSize(const Value: boolean);
begin
  if fAddedDefaultSize <> Value then
  begin
    fAddedDefaultSize := Value;
    CDefaultSize.Checked := fAddedDefaultSize;
    UpdateESize;
  end;
end;

procedure TFormDlgSIL.SetAddedHeight(const Value: integer);
begin
 if fAddedHeight <> Value then
 begin
  fAddedHeight := Value;
  if fAddedHeight<=1 then fAddedHeight := 1;
  //if fAddedHeight>128 then fAddedHeight := 128;
  EHeight.Text := inttostr(fAddedHeight);
 end;
end;

procedure TFormDlgSIL.SetAddedWidth(const Value: integer);
begin
 if fAddedWidth <> Value then
 begin
  fAddedWidth := Value;
  if fAddedWidth<1 then fAddedWidth := 1;
  //if fAddedWidth>128 then fAddedWidth := 128;
  EWidth.Text := inttostr(fAddedWidth);
 end;
end;

procedure TFormDlgSIL.SetItemIndex(const Value: integer);
begin
  if fItemIndex<>Value then
  begin
    fItemIndex := Value;
    UpdateGrid;
  end;
end;

procedure TFormDlgSIL.SetImageListCep(const Value: TImageListCep);
begin
  if fImageListCep<>nil then
    fImageListCep.RemoveFreeNotification(self);
  fImageListCep := Value;
  if fImageListCep<>nil then
    fImageListCep.FreeNotification(self);
  SetInternalImageList(fImageListCep);
  UpdateCaption;
end;

procedure TFormDlgSIL.SetInternalImageList(const Value: TImageListCep);
begin
  fInternalImageList.Assign(Value);
end;

procedure TFormDlgSIL.SetTypeAdd(const Value: TTypeAdd);
begin
  if fTypeAdd<>Value then
  begin
    fTypeAdd := Value;
    GroupTypeAdd.ItemIndex := integer(fTypeAdd);
    if fTypeAdd = taScale then
    begin
      Label1.Enabled := false;
      CDefaultSize.Enabled := false;
    end else begin
      Label1.Enabled := true;
      CDefaultSize.Enabled := true;
    end;
    UpdateESize;
  end;
end;

procedure TFormDlgSIL.GroupTypeAddClick(Sender: TObject);
begin
  TypeAdd := TTypeAdd(GroupTypeAdd.ItemIndex);
end;

procedure TFormDlgSIL.CDefaultSizeClick(Sender: TObject);
begin
  AddedDefaultSize := CDefaultSize.Checked;
end;

{ TImgGrid }

constructor TImgGrid.Create(AOwner: TComponent);
var Y:integer;
begin
  inherited;
  DragCursor := 0;
  fNewCol := -1;
  if AOwner is TFormDlgSIL then
  begin
    fForm := TFormDlgSIL(AOwner);
    ParentColor := true;
    Options := [goFixedVertLine, goFixedHorzLine, goHorzLine,
                goDrawFocusSelected,
                goThumbTracking];
    RowCount := 1;
    DefaultDrawing := false;
    FixedRows :=0;
    Parent := fForm;
    Anchors := [akLeft, akTop, akRight, akBottom];
    Y := fForm.GroupSize.Top+fForm.GroupSize.Height+fForm.BorderWidth;
    SetBounds(0, Y,
              fForm.ClientWidth, fForm.ButtonAdd.Top-(Y+2*fForm.BorderWidth));
    ParentColor := true;
  end else raise Exception.Create(StrAOwnerError);
end;

destructor TImgGrid.Destroy;
begin
  FreeAndNil(fDragImageList);
  inherited;
end;

function TImgGrid.GetTimer(Event:TNotifyEvent): TInternalTimer;
begin
  if fTimer=nil then
    fTimer := TInternalTimer.Create(self);
  result := fTimer;
  if @Event=nil then
    fTimer.Stop
  else
    fTimer.ExecuteInterval(100,Event);
end;

procedure TImgGrid.EventLeft(Sender: TObject);
begin
  if LeftCol>FixedCols then
  begin
    LeftCol := LeftCol-1;
    if (fMovedCol<>-1) and (fNewCol<>-1) then Dec(fNewCol);
    InvalidateRect(Handle,nil,true);
  end else GetTimer(nil);
end;

procedure TImgGrid.EventRight(Sender: TObject);
begin
  if LeftCol+VisibleColCount<ColCount then
  begin
    LeftCol := LeftCol+1;
    if (fMovedCol<>-1) and (fNewCol<>-1) then Inc(fNewCol);
    InvalidateRect(Handle,nil,true);
  end else GetTimer(nil);
end;                 

//При использовании колеса мыши в таблице вызываем аналогичное событие формы
function TImgGrid.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
begin
  fForm.DoMouseWheel(Shift,WheelDelta,MousePos);
  result := true;
end;

procedure TImgGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_END : begin
         fForm.ItemIndex := fForm.InternalImageList.CustomImg.Count-1;
         Key := 0;
    end;
    VK_RIGHT : begin
      if ssCtrl in Shift then
      begin
         fForm.ActionMoveNext.Execute;
         Key := 0;
      end;
    end;
    VK_LEFT : begin
      if ssCtrl in Shift then
      begin
         fForm.ActionMovePrior.Execute;
         Key := 0;
      end;
    end;
  end;
  inherited;
end;

//При нажатии на левую кнопку мыши начинаем перетаскивание
procedure TImgGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var R:TRect;
    Pt:TPoint;
    C: TGridCoord;
begin
  if Button=mbRight then
  begin
    C := MouseCoord(X,Y);
    fClickedRow := C.Y-FixedRows;
  end else fClickedRow := -1;
  Pt := Point(X,Y);
  R := CellRect(Col,Row);
  if (Focused) and (Button=mbLeft) and PtInRect(R,Pt) and
     (Col-FixedCols<fForm.InternalImageList.CustomImg.Count) then
  begin
    fMovedCol := Col;
    BeginDrag(true);
  end else inherited;
end;

procedure TImgGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var Col:integer;
begin
  inherited;
  if (Button=mbLeft) and (fNewCol<>-1) then
  begin
    Col := fNewCol;
    fNewCol := -1;
    InvalidateCell(Col,RowCount-1);
    InvalidateCell(Col-1,RowCount-1);
    FreeAndnil(fDragImageList);
  end;
end;

function TImgGrid.GetDragImages: TDragImageList;
begin
  {$IFDEF VER130}
  {$ELSE}
  if fDragImageList=nil then
  with fForm.InternalImageList do begin
    fDragImageList := TDragImageList.Create(nil);
    fDragImageList.Width := CustomImg.Width;
    fDragImageList.Height := CustomImg.Height;
    fDragImageList.AddImage(CustomImg,fMovedCol-FixedCols);
    fDragImageList.DragHotspot := Point((Width*2)div(3),(Height*2)div(3));
  end;
  {$ENDIF}
  result := fDragImageList;
end;

procedure TImgGrid.DoStartDrag(var DragObject: TDragObject);
{$IFDEF VER130}
var Dr: TDragControlObject;
{$ELSE}
var Dr: TDragControlObjectEx;
{$ENDIF}
begin
  inherited;
  {$IFDEF VER130}
  Dr := TDragControlObject.Create(self);
  {$ELSE}
  Dr := TDragControlObjectEx.Create(self);
  Dr.AlwaysShowDragImages :=true;
  {$ENDIF}
  DragObject := Dr;
end;

procedure TImgGrid.DoEndDrag(Target: TObject; X, Y: Integer);
var Col:integer;
begin
  inherited;
  if (fNewCol<>-1) then
  begin
    Col := fNewCol;
    fNewCol := -1;
    if fMovedCol<>-1 then
    begin
      if Col>fMovedCol then Dec(Col);
      fForm.InternalImageList.CustomImg.Move(fMovedCol-FixedCols,Col-FixedCols);
      fForm.ItemIndex := Col-FixedCols;
    end;
    InvalidateCell(Col,RowCount-1);
    InvalidateCell(Col-1,RowCount-1);
    fMovedCol := -1;
  end;
  FreeAndnil(fDragImageList);
  GetTimer(nil);
  fMovedCol := -1;
end;

procedure TImgGrid.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var C:TGridCoord;
    R:TRect;
    Pt:TPoint;
    NewCol,LeftX:integer;
begin
  inherited;
  NewCol := -1;
  C := MouseCoord(X,Y);
  Accept := C.Y=RowCount-1;
  if Accept then
  begin
   Pt := Point(X,Y);
   R := CellRect(C.X,C.Y);
   NewCol := C.X;
   if X-R.Left>(R.Right-R.Left)div(2) then inc(NewCol);
   Accept := (NewCol<>fMovedCol)and(NewCol-1<>fMovedCol)and
             ((NewCol-FixedCols)>=0)and
             ((NewCol-FixedCols)<=fForm.InternalImageList.CustomImg.Count);
  end;
  if not Accept then NewCol := -1;
  if FixedCols>0 then
    LeftX := CellRect(FixedCols-1,0).Right+4
  else
    LeftX := 4;
  if Accept and ((X>=ClientWidth-4) or (X<=LeftX)) then begin
    if X<=LeftX then
      GetTimer(EventLeft)
    else
      GetTimer(EventRight);
  end else GetTimer(nil);
  if fNewCol<>NewCol then
  begin
      InvalidateCell(fNewCol,RowCount-1);
      InvalidateCell(fNewCol-1,RowCount-1);
      fNewCol := NewCol;
      InvalidateCell(fNewCol-1,RowCount-1);
      InvalidateCell(fNewCol,RowCount-1);
  end;
end;

//Изображаем курсор для вставки перетаскиваемой картинки
procedure TImgGrid.DrawDropPos(ARect: TRect; ACol: Integer; ARow: Integer);
begin
  if ARow = RowCount - 1 then
  begin
    Canvas.Pen.Width := 2;
    if ACol = fNewCol then
    begin
      Canvas.MoveTo(ARect.Left - 2, ARect.Top + 2);
      Canvas.LineTo(ARect.Left + 1, ARect.Top + 2);
      Canvas.MoveTo(ARect.Left - 1, ARect.Top + 2);
      Canvas.LineTo(ARect.Left - 1, ARect.Bottom - 2);
      Canvas.MoveTo(ARect.Left - 2, ARect.Bottom - 2);
      Canvas.LineTo(ARect.Left + 1, ARect.Bottom - 2);
    end;
    if ACol = fNewCol - 1 then
    begin
      Canvas.MoveTo(ARect.Right + 2, ARect.Top + 2);
      Canvas.LineTo(ARect.Right - 3, ARect.Top + 2);
      Canvas.MoveTo(ARect.Right, ARect.Top + 2);
      Canvas.LineTo(ARect.Right, ARect.Bottom - 2);
      Canvas.MoveTo(ARect.Right + 2, ARect.Bottom - 2);
      Canvas.LineTo(ARect.Right - 3, ARect.Bottom - 2);
    end;
  end;
end;

procedure DrawText(DC:HDC; R:TRect; S:string; Flags: Cardinal);
var RR: TRect;
    X,Y:integer;
begin
  RR := Rect(0,0,Abs(R.Right-R.Left),2000);
  Windows.DrawText(DC,PChar(S),Length(S),RR,
    (FLAGS and (DT_END_ELLIPSIS or DT_PATH_ELLIPSIS or DT_WORDBREAK or DT_SINGLELINE)) or DT_CALCRECT);
  Y := 0;
  X := 0;
  if (Flags and DT_VCENTER)=DT_VCENTER then
  begin
    Y := (R.Bottom-R.Top-RR.Bottom)div(2);
    if Y<-1 then Y:= -1;
  end;
  if (Flags and DT_CENTER)=DT_CENTER then
  begin
    X := (R.Right-R.Left-RR.Right)div(2);
    if X<-1 then X:= -1;
  end;
  inc(R.Left,X);
  inc(R.Top,Y);
  Windows.DrawText(DC,PChar(S),Length(S),R,
    FLAGS and (not (DT_VCENTER or DT_CENTER)));
end;

procedure TImgGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var R:TRect;
    I1,I2,I:integer;
    S: string;
    NeedImg:boolean;
begin
 Canvas.Pen.Width := 1;
 Canvas.Font := Font;
 Canvas.Brush.Color := Color;
 Canvas.Font.Color := Font.Color;
 Canvas.Brush.Style := bsSolid;
 if (gdSelected in AState) then
 begin
   Canvas.Brush.Color := clHighlight;
   Canvas.Font.Color := clHighlightText;
 end;
 Canvas.FillRect(ARect);
 Canvas.Brush.Style := bsClear;
 I1 := ACol-FixedCols;    // Абсолютный номер изображения
 I2 := ARow-FixedRows;
 with fForm.InternalImageList do begin
   NeedImg := ((I2=ResourceNames.Count) and (I1<CustomImg.Count))
           OR ((I2<ResourceNames.Count) and (I2>=0) and
               (I1<ResourceNames.Items[I2].GliphCount));
   if NeedImg then
     for I := 0 to ARow-FixedRows-1  do
       inc(I1,ResourceNames.Items[i].GliphCount);
   I2 := 0;
   for I := 0 to ResourceNames.Count - 1 do
   begin
     if I2+ResourceNames.Items[i].GliphCount>=ACol then break;
     inc(I2,ResourceNames.Items[i].GliphCount);
   end;
   R := ARect;
   if (ARow>=FixedRows) and (ACol>=FixedCols) then
   begin
     if Focused and (gdSelected in AState) then
     begin
       Canvas.Brush.Color := Color;
       Canvas.DrawFocusRect(R);
       Canvas.Brush.Style := bsClear;
     end;
     if NeedImg then Draw(Canvas,(ARect.Right+ARect.Left-Width)div(2),ARect.Top+(Margin)div(2),I1,true);
   end;
 end;
 R := ARect;
 if ARow>=FixedRows then
 begin
   R.Top := R.Bottom-fTh-(Margin)div(2)+1;
   R.Bottom := R.Top+fTh;
   if NeedImg then
     S := inttostr(I1)
   else
     S := '-';
 end else
 begin
   R.Top := R.Top-1;
   R.Bottom := R.Top+fTh;
   S := inttostr(I1)
 end;
 if ACol>=FixedCols then
 begin
   if I1>=0 then
     DrawText(Canvas.Handle,R,S,DT_CENTER or DT_VCENTER);
 end else
 begin
   Canvas.Font.Name := 'Small Fonts';
   Canvas.Font.Size := 5;
   S := '';
   I := ARow-FixedRows;
   if (I>=0) then
     if (I<fForm.InternalImageList.ResourceNames.Count) then
       S := fForm.InternalImageList.ResourceNames.Items[I].DisplayName
     else
       S := Format(StrSDxdd,
                   [fForm.InternalImageList.CustomImg.Name,
                    fForm.InternalImageList.CustomImg.Width,
                    fForm.InternalImageList.CustomImg.Height,
                    fForm.InternalImageList.CustomImg.Count]);
   R := ARect;
   InflateRect(R,-1,-2);
   DrawText(Canvas.Handle,R,S,DT_WORDBREAK);
 end;
 Canvas.Pen.Color := clBtnShadow;
 R := ARect;
 InflateRect(R,1,1);
 Canvas.Rectangle(R);
 Canvas.Font.Color := Font.Color;
 DrawDropPos(ARect, ACol, ARow);
end;

function TImgGrid.SelectCell(ACol, ARow: Integer): Boolean;
begin
  result := (ARow = RowCount-1) and
            ((ACol-FixedCols)<=fForm.InternalImageList.CustomImg.Count);
  if result then
    fForm.ItemIndex := ACol-FixedCols;
end;

procedure TImgGrid.UpdateGrid;
var X,I: integer;
begin
  if (fForm.InternalImageList<>nil) and
     (fForm.InternalImageList.CountUpdating=0) then
  begin
    X := 0;
    for i := 0 to fForm.InternalImageList.ResourceNames.Count - 1 do
      if X<fForm.InternalImageList.ResourceNames.Items[I].GliphCount then
        X := fForm.InternalImageList.ResourceNames.Items[I].GliphCount;
    if X<fForm.InternalImageList.CustomImg.Count then
      X := fForm.InternalImageList.CustomImg.Count;
    if X>0 then
    begin
     ColCount := X+1;
     FixedCols := 1;
    end
    else begin
     FixedCols := 0;
     ColCount :=1;
    end;
    RowCount := fForm.InternalImageList.ResourceNames.Count+2;
    FixedRows := 1;
    Canvas.Font := Font;
    fTw := fForm.InternalImageList.Width+Margin;
    fTh := Canvas.TextWidth('000')+Margin;
    if fTw<fTh then fTw := fTh;
    if fTw<24 then fTw:=24;
    fTh := Canvas.TextHeight('Wp');
    DefaultColWidth := fTw;
    DefaultRowHeight := fTh+Margin+fForm.InternalImageList.Height;
    RowHeights[0] := fTh;
    ColWidths[0] := Canvas.TextWidth(fForm.InternalImageList.CustomImg.Name)+4;
    Row := RowCount -1;
    X := fForm.ItemIndex+FixedCols;
    if X>=ColCount then X := 0;
    if X<0 then X := 0;
    Col := X;
  end;
end;

//Прием файлов из Explorer
procedure TImgGrid.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_ACCEPTFILES;
end;

procedure TImgGrid.WMDROPFILES(var Message: TWMDROPFILES);
var
  FileName: array[0..MAX_PATH] of Char;
  i, InsertIndex: Integer;
  List: TStringList;
  S,Ex: String;
  Pt: TPoint;
  C: TGridCoord;
begin
  List := nil;
  try
    List := TStringList.Create;
    i:=0;
    while (DragQueryFile(Message.Drop, i, FileName, MAX_PATH) > 0) do
    begin
      S := String(FileName);
      Ex := UpperCase(ExtractFileExt(S));
      //if (Ex='.BMP') or (Ex='.ICO') then
      //begin
        List.Add(S);
      //end;
      Inc(i);
    end;
    if List.Count>0 then
    begin
      DragQueryPoint(Message.Drop,Pt);
      C := MouseCoord(Pt.X,Pt.Y);
      if (C.Y=RowCount-1) or (C.Y=-1) then
      begin
        if (C.X-FixedCols>=fForm.InternalImageList.Count) or (C.X=-1) then
          InsertIndex := fForm.InternalImageList.Count
        else
          InsertIndex := C.X-FixedCols;
        for i:=0 to List.Count - 1 do
        try
          fForm.OpenFile(List[i], InsertIndex);
          inc(InsertIndex);
        except
          Continue
        end;
      end;
    end;
    Message.Result := 0;
  finally
    FreeAndNil(List);
    DragFinish(Message.Drop);
  end;
end;

{ TFormProp }

procedure TFormProp.ClickBrowse(Sender: TObject);
var S:string;
begin
  if fDLGopen=nil then
  begin
    fDLGopen := TOpenDialog.Create(self);
    fDLGopen.Filter := '*.exe; *.dll|*.exe;*.dll'+#13#10+'*.*|*.*';
    fDLGopen.Title := StrFileRes;
  end;
  S := ExtractFilePath(trim(fEditFileName.Text));
  {$IFDEF VER130}
  {$ELSE}
  if DirectoryExists(S) then fDLGopen.InitialDir := S;
  {$ENDIF}
  if   {$IFDEF VER130}
         fDLGopen.Execute
       {$ELSE}
         fDLGopen.Execute(Handle)
       {$ENDIF} then
  begin
    fEditFileName.Text := fDLGopen.FileName;
    TResourceName(Child).FileName := trim(fEditFileName.Text);
    UpdateResourceNames;
  end;
end;

procedure TFormProp.ClickOk(Sender: TObject);
type TCustInt= 1..128;
var W,H,N: TCustInt;
  function  EditToInt(Edit:TMaskEdit):TCustInt;
  var I:integer;
  begin
    try
      I := StrToInt(Edit.Text);
      if (I<Low(result)) or (I>High(result)) then
        raise ERangeError.Create(SRangeError);
      result := I;
    except
      Edit.SetFocus;
      raise;
    end;
  end;
begin
  W := EditToInt(feWidth);
  H := EditToInt(feHeight);
  if Child is TCustomImg then
  begin
    TCustomImg(Child).BeginUpdate;
    try
      TCustomImg(Child).Width := W;
      TCustomImg(Child).Height := H;
    finally
      TCustomImg(Child).EndUpdate;
    end;
  end;
  if Child is TResourceName then
  begin
    N := EditToInt(feCount);
    TResourceName(Child).Collection.BeginUpdate;
    try
      TResourceName(Child).AutoSize := fCheckAuto.Checked;
      if not TResourceName(Child).AutoSize then
      begin
        TResourceName(Child).Width := W;
        TResourceName(Child).Height := H;
      end;
      TResourceName(Child).GliphCount := N;
      {$IFDEF VER130} {$ELSE}
      TResourceName(Child).TransparentColor := fColorBox.Selected;
      {$ENDIF}
      TResourceName(Child).FileNameDOM := fCheckDOM.Checked;
      TResourceName(Child).FileName := trim(fEditFileName.Text);
      TResourceName(Child).Name := fResourceBox.Text;
    finally
      TResourceName(Child).Collection.EndUpdate;
    end;
  end;
  Close;
  ModalResult := IdOk;
end;

procedure TFormProp.ClickAuto(Sender:TObject);
begin
  UpdateEnableSize;
end;

procedure TFormProp.ClickDom(Sender:TObject);
begin
  UpdateResourceNames;
end;

constructor TFormProp.Create(AOwner: TComponent; AChild: TPersistent);
var Y,X:integer;
begin
  if not ((AChild is TResourceName) or (AChild is TCustomImg)) then
    raise Exception.Create(ErrAChildType);
  inherited CreateNew(AOwner);
  BorderStyle := bsToolWindow;
  BorderWidth := 4;
  Position := poDesigned;
  fChild := AChild;
  if Child is TResourceName then
    if TResourceName(fChild).Name<>'' then
      Caption := TResourceName(fChild).Name
    else
      Caption := Child.ClassType.ClassName
  else
    if TCustomImg(fChild).Name<>'' then
      Caption := TCustomImg(fChild).Name;
  AutoSize := False;
  Y := 2*BorderWidth;
  with TLabel.Create(self) do
  begin
    Caption := StrWidth;
    Top := Y;
    X := Left+Width+BorderWidth;
    fEWidth := TMaskEdit.Create(self);
    with fEWidth do
    begin
      Top := Y-3;
      Left := X;
      Width := 32;
      if AOwner is TFormDlgSIL then
        OnKeyPress := TFormDlgSIL(AOwner).MEKeyPress;
      inc(Y,Height+BorderWidth);
    end;
  end;
  with TLabel.Create(self) do
  begin
    Caption := StrHeight;
    Top := Y;
    fEHeight := TMaskEdit.Create(self);
    with fEHeight do
    begin
      Top := Y-3;
      Left := X;
      Width := 32;
      if AOwner is TFormDlgSIL then
        OnKeyPress := TFormDlgSIL(AOwner).MEKeyPress;
      inc(Y,Height+BorderWidth);
    end;
  end;
  if Child is TResourceName then
  begin
    fCheckAuto := TCheckBox.Create(self);
    with fCheckAuto do
    begin
      Caption := StrAuto;
      Top := Y;
      Checked := TResourceName(Child).AutoSize;
      inc(Y,Height+BorderWidth);
      OnClick := ClickAuto;
    end;
    with TLabel.Create(self) do
    begin
      Caption := StrCount;
      Top := Y;
      fECount := TMaskEdit.Create(self);
      with fECount do
      begin
        Top := Y-3;
        Left := X;
        Width := 32;
        if AOwner is TFormDlgSIL then
          OnKeyPress := TFormDlgSIL(AOwner).MEKeyPress;
        inc(Y,Height+BorderWidth);
      end;
    end;

    with TLabel.Create(self) do
    begin
      Caption := StrFileName;
      Top := Y;
      inc(Y,Height+BorderWidth);
      fEditFileName := TMaskEdit.Create(self);
      with fEditFileName do
      begin
        Top := Y;
        Width := X+32;
        Text := TResourceName(Child).FileName;
        inc(Y,Height+BorderWidth);
      end;
      fCheckDOM := TCheckBox.Create(self);
      with fCheckDOM do
      begin
        Caption := StrDOM;
        Top := Y;
        Width := X+32;
        Checked := TResourceName(Child).FileNameDOM;
        inc(Y,Height+BorderWidth);
        OnClick := ClickDom;
      end;
    end;

    with TLabel.Create(self) do
    begin
      Caption := StrResourceName;
      Top := Y;
      inc(Y,Height+BorderWidth);
      fResourceBox := TComboBox.Create(self);
      with fResourceBox do
      begin
        Top := Y;
        Width := X+32;
        inc(Y,Height);
      end;
    end;
    
    with TLabel.Create(self) do
    begin
      Caption := StrTransparentColor;
      Top := Y;
      inc(Y,Height+BorderWidth);
      {$IFDEF VER130} {$ELSE}
      fColorBox := TColorBox.Create(self);
      with fColorBox do
      begin
        Top := Y;
        Width := X+32;
        Selected := TResourceName(Child).TransparentColor;
        inc(Y,Height);
      end;
      {$ENDIF}
    end;
  end;
  with TBevel.Create(self) do
    SetBounds(-BorderWidth, 0, X+32+2*BorderWidth,Y);
  X := X+32+3*BorderWidth;
  Y := 0;
  with TButton.Create(self) do
  begin
    Top := Y;
    Left := X;
    Caption := StrOk;
    OnClick := ClickOk;
    Default := true;
    Y := Y+Height+BorderWidth;
  end;
  with TButton.Create(self) do
  begin
    Top := Y;
    Left := X;
    Caption := StrCancel;
    ModalResult := IdCancel;
    Cancel := true;
    Y := Y+Height+BorderWidth;
  end;
  if Child is TCustomImg then
  begin
    fEWidth.Text := Inttostr(TCustomImg(Child).Width);
    fEHeight.Text := Inttostr(TCustomImg(Child).Height);
  end;
  if Child is TResourceName then
  begin
    fEWidth.Text := Inttostr(TResourceName(Child).Width);
    fEHeight.Text := Inttostr(TResourceName(Child).Height);
    fECount.Text := Inttostr(TResourceName(Child).GliphCount);
    fButtonBrowse := TButton.Create(self);
    with fButtonBrowse do
    begin
      Top := Y;
      Left := X;
      Caption := StrBrowse;
      OnClick := ClickBrowse;
    end;
  end;
end;

procedure TFormProp.DoShow;
var i:integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TButton then
      TControl(Components[i]).Parent := self;    
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TControl then
      TControl(Components[i]).Parent := self;
    {$IFDEF VER130} {$ELSE}
    if Components[i] is TColorBox then
      TColorBox(Components[i]).Style :=
             [cbStandardColors,cbExtendedColors,
              cbSystemColors,cbIncludeNone,
              cbIncludeDefault,cbCustomColor,cbCustomColors];
    {$ENDIF}
  end;
  AutoSize := true;
  if Top+Height>Screen.Height then
    Top := Top-Height;
  if Left+Width>Screen.Width then
    Left := Screen.Width-Width;
  UpdateResourceNames;
  inherited;
  fEWidth.SetFocus;
  UpdateEnableSize;
  if (Child is TResourceName) and (fResourceBox <> nil) then
    fButtonBrowse.SetFocus;
end;

procedure TFormProp.UpdateEnableSize;
begin
  if (Child is TResourceName) and (fResourceBox <> nil) then
  begin
    fButtonBrowse.SetFocus;
    fEWidth.Enabled := not fCheckAuto.Checked;
    fEHeight.Enabled := not fCheckAuto.Checked;
    if fEWidth.Enabled then
    begin
      fEWidth.Color := clWindow;
      fEHeight.Color := clWindow;
    end
    else begin
      fEWidth.ParentColor := true;
      fEHeight.ParentColor := true;
    end;
  end;
end;

procedure TFormProp.UpdateResourceNames;
var
  L: TStringList;
  S: string;
begin
  if (Child is TResourceName) and (fResourceBox <> nil) then
  begin
    L := TStringList.Create;
    S := fResourceBox.Text;
    try
      TResourceName(Child).FileNameDOM := fCheckDOM.Checked;
      TResourceName(Child).EnumResources(L);
      fResourceBox.Items.Clear;
      fResourceBox.Items.AddStrings(L);
    finally
      FreeAndNil(L);
      fResourceBox.Text := S;
    end;
    fResourceBox.Text := TResourceName(Child).Name;
  end;
end;

{ TFormOpenResource }

type
  TPaitBoxCep=class (TImage)
  private
    fColCount:integer;
    fResizing:boolean;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure ChangeMousePos(X, Y: integer);
    function IndexByPos(X, Y: integer): integer;
    function GetForm: TFormOpenResource;
    function GetIconRect(Index: integer): TRect;
    function GetColCount: integer;
  protected
    procedure Click; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    procedure PaintRect(ARect: TRect; Clear:boolean=false);
    property Form:TFormOpenResource read GetForm;
    procedure Resize; override;
    constructor Create(AOwner: TComponent); override;
  end;

  TPaintPanel = class (TScrollingWinControl)
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TTmpPaintPanel }

constructor TPaintPanel.Create(AOwner: TComponent);
begin
  inherited;
  Align := alClient;
  VertScrollBar.Tracking := true;
  VertScrollBar.Visible := true;
  HorzScrollBar.Visible := False;
  Autoscroll := true;
  BevelKind := bkTile;
  BevelInner := bvLowered;
  if AOwner is TFormOpenResource then
    Parent := TFormOpenResource(AOwner);
end;


function TPaitBoxCep.GetColCount:integer;
begin
  result := Form.ImageWidth+8;
  result := (ClientWidth+8)div(result);
  if result < 1 then result := 1;  
end;

function TPaitBoxCep.IndexByPos(X,Y: integer):integer;
var R,CC,C: integer;
begin
  result := -1;
  if (X<=-10) or (Y<=-10) then exit;  
  R := Form.ImageWidth+8;
  CC := GetColCount;
  if CC*R<=X then Exit
             else C := (X)div(R);
  R := (Y)div(Form.ImageHeight+8);
  result := R*CC+C;
end;

procedure TPaitBoxCep.ChangeMousePos(X, Y: integer);
var I,OldHotIndex:integer;
begin
  i := IndexByPos(X,Y);
  if i<>Form.fHotIndex then
  begin
    OldHotIndex := Form.fHotIndex;
    Form.fHotIndex := i;
    PaintRect(GetIconRect(OldHotIndex));
    Form.fFileName := Form.NameByIndex(I);
    Application.CancelHint;
    Hint := Form.fFileName;
    PaintRect(GetIconRect(Form.fHotIndex));
  end;
end;

function TPaitBoxCep.GetIconRect(Index: integer):TRect;
var
  X: Integer;
  Y: Integer;
  i: Integer;
begin
  X := 4;
  Y := 4;
  FillChar(result,SizeOf(Result),0);
  if Index>=0 then
  begin
    for i := 0 to Index-1 do
    begin
      inc(X,Form.ImageWidth+8);
      if X > ClientWidth - Form.ImageWidth +4 then
      begin
        X := 4;
        inc(Y, Form.ImageHeight + 8);
      end;
    end;
    result :=  Rect (X-4, Y-4, X+Form.ImageWidth+4, Y+Form.ImageHeight+4);
  end;
end;

procedure TPaitBoxCep.CMMouseLeave(var Message: TMessage);
begin
  ChangeMousePos(-10,-10);
  inherited;
end;

constructor TPaitBoxCep.Create(AOwner: TComponent);
begin
  inherited;
  fColCount := -1;
end;

function TPaitBoxCep.GetForm: TFormOpenResource;
begin
  if Owner is TFormOpenResource then result := TFormOpenResource(Owner)
                                else result := nil;
  
end;

procedure TPaitBoxCep.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ChangeMousePos(X,Y);
end;

procedure TPaitBoxCep.Click;
begin
  inherited;
  if Form.fHotIndex>=0 then
  begin
    if Form.IsSelectedIndex(Form.fHotIndex) then Form.UnSelectIndex(Form.fHotIndex)
                                            else Form.SelectIndex(Form.fHotIndex);
    PaintRect(GetIconRect(Form.fHotIndex));
  end;
end;

procedure TPaitBoxCep.PaintRect(ARect:TRect; Clear:boolean=false);
var
  X: Integer;
  Y: Integer;
  i: Integer;
  HI: Integer;
  R,RR: TRect;
  Flag: Cardinal;
  Sel:boolean;
begin
  if (ARect.Right<=ARect.Left) or (ARect.Bottom<=ARect.Top) then Exit;
  with Picture.Bitmap do
  for i := 0 to Form.fIcons.Count - 1 do
  begin
    R := GetIconRect(I);
    if Windows.IntersectRect(RR,R,ARect) then
    begin
      X := Form.ImageWidth+8;
      Width := ((self.Width+X-1)div(X))*X;
      Height := self.Height;
      Canvas.Brush.Color := Color;
      if Clear then Canvas.FillRect(Rect(0,0,Width,Height))
               else Canvas.FillRect(R);
      X := R.Left;
      Y := R.Top;
      HI := Integer(Form.fIcons.Objects[i]);
      Flag := DI_NORMAL;
      Sel := Form.IsSelectedIndex(I);
      if (I=Form.fHotIndex) then
        if Sel then
          Canvas.Brush.Color :=  GraphUtil.GetHighLightColor(clHighlight)
        else
          Canvas.Brush.Color := {$IFDEF VER130}clAqua{$ELSE} clSkyBlue {$ENDIF}
      else
        if Sel then
          Canvas.Brush.Color := clHighlight
        else
          Canvas.Brush.Color := Color;
      Canvas.Brush.Style := bsSolid;
      if I=Form.fHotIndex then
      begin
        Canvas.Pen.Color := Font.Color;
      end else
      begin
        if Sel then
          Canvas.Pen.Color := clBtnShadow
        else
          Canvas.Pen.Color := Color;
      end;
      Canvas.Pen.Style := psSolid;
      Canvas.Rectangle(X + 2, Y + 2, X + Form.ImageWidth + 6, Y + Form.ImageHeight + 6);
      if (HI <> 0) and (HI <> -1) then
      begin
        DrawIconEx(Canvas.Handle, X + 4, Y + 4, HI, Form.ImageWidth, Form.ImageHeight, 0, Canvas.Brush.Handle, FLAG);
        windows.ExcludeClipRect(Canvas.Handle,X + 4, Y + 4, X + 4+Form.ImageWidth, Y + 4+Form.ImageHeight)
      end;
    end;
  end;
end;

procedure TPaitBoxCep.Resize;
var R: TRect;
    CC, OldH :integer;
begin
  OldH := Height;
  inherited;
  if fResizing then Exit;
  fResizing := true;
  try
    if (Form.fIcons<>nil) and (Form.fIcons.Count>0) then
    begin
      R := GetIconRect(Form.fIcons.Count-1);
      if R.Bottom<>Height then Height := R.Bottom
    end else Height := 0;
    CC := GetColCount;
    if (fColCount<>CC) or (Height<>OldH) then
    begin
      PaintRect(ClientRect,true);
      fColCount := CC;
      Paint;
    end;
  finally
    fResizing := false;
  end;
end;

constructor TFormOpenResource.Create(AOwner:TComponent; AImageWidth:integer=32; AImageHeight:integer=32);
var Panel: TPanel;
    PaintPanel:TPaintPanel;
begin
  inherited CreateNew(AOwner);
  Width := 394;
  fHotIndex :=-1;
  BorderStyle := bsSizeToolWin;
  Position := poScreenCenter;
  VertScrollBar.Visible := true;
  fImageWidth := AImageWidth;
  fImageHeight := AImageHeight;
  ShowHint := true;
  Panel := TPanel.Create(self);
  with Panel do
  begin
    Height := 32;
    Align := alBottom;
    Parent := self;
    BevelOuter := bvNone;
    BorderStyle := bsNone;
    with TButton.Create(Panel) do
    begin
      Caption := StrOk;
      Default := True;
      OnClick := ClickOk;
      Anchors := [akTop, akRight, akBottom];
      SetBounds(Panel.Width-(64+8)*2,4,64,Height);
      Parent := Panel;
    end;
    with TButton.Create(Panel) do
    begin
      Caption := StrCancel;
      Cancel := True;
      OnClick := ClickCancel;
      Anchors := [akTop, akRight, akBottom];
      SetBounds(Panel.Width-(64+8),4,64,Height);
      Parent := Panel;
    end;
  end;
  PaintPanel := TPaintPanel.Create(Self);
  fPaintBox := TPaitBoxCep.Create(self);
  with fPaintBox do
  begin
    Width := PaintPanel.ClientWidth;
    Color := self.Color;
    Align := alTop;
    parent := PaintPanel;
  end;
end;

destructor TFormOpenResource.Destroy;
begin
  FreeHinstance;
  inherited;
end;

function TFormOpenResource.NameByIndex(Index:integer):string;
begin
  result := '';
  if (Index>=0) and (fIcons<>nil) and (Index<fIcons.Count) then
  begin
    result := fIcons[Index];
  end;
end;

function TFormOpenResource.IsSelectedIndex(Index:integer):boolean;
var i:integer;
begin
  result := false;
  for i:=0 to Length(fSelIndexes) - 1 do
    if fSelIndexes[i]=Index then
    begin
      result := true;
      break;
    end;
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
    if Integer(lpszName)>High(Word) then
      List.Add(lpszName)
    else
    begin
      List.Add('#'+Inttostr(integer(lpszName)));
    end;
  end;
  result := true;
end;


procedure TFormOpenResource.UpdateHinstance;
var Error, I, HI, N:integer;
    S:String;
    PIconName: PChar;
    procedure RaiseError;
    begin
      Error := GetLastError;
      if (Error<>ERROR_RESOURCE_TYPE_NOT_FOUND) and (Error<>NO_ERROR) then
      begin
        {$IFDEF VER130}
        raise EWin32Error.CreateResFmt(@SWin32Error, [Error, SysErrorMessage(Error)])
        {$ELSE}
        raise EOSError.CreateResFmt(@SOSError, [Error, SysErrorMessage(Error)])
        {$ENDIF};
      end;
    end;
begin
  FreeHinstance;
  if trim(fFileName)='' then Exit;
  fhInstance := LoadLibraryEx(PChar(fFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  if fhInstance=0 then
      {$IFDEF VER130}
      RaiseLastWin32Error
      {$ELSE}
      RaiseLastOSError
      {$ENDIF};
  try
    fIcons := TStringList.Create;
    if not EnumResourceNames(fhInstance, RT_CURSOR, @EnumResNameProc, integer(fIcons)) then
      RaiseError;
    if not EnumResourceNames(fhInstance, RT_ICON, @EnumResNameProc, integer(fIcons)) then
      RaiseError;
    i := 0;
    while i<fIcons.Count do
    begin
      if (fIcons[i]<>'') and (fIcons[i][1] ='#') then
      begin
        S := copy(fIcons[i],2,Length(fIcons[i]));
        N := StrToInt(S);
        PIconName := MAKEINTRESOURCE(N);
      end else
        PIconName := PChar(fIcons[i]);
      HI := LoadImage(fhInstance, PIconName,
                      IMAGE_ICON,
                      ImageWidth,
                      ImageHeight,
                      LR_LOADMAP3DCOLORS);
      if HI<>0 then
      begin
          fIcons.Objects[i] := TObject(HI);
          inc(i);
      end
      else fIcons.Delete(I);
    end;
    TPaitBoxCep(fPaintBox).Resize;
  except
    FreeHinstance;
    raise;
  end;
end;

procedure TFormOpenResource.FreeHinstance;
var i: integer;
begin
  if fIcons<>nil then
   for i := 0 to fIcons.Count - 1 do
    if (Integer(fIcons.Objects[i])<>0) and (Integer(fIcons.Objects[i])<>-1) then
    begin
      //if not DestroyIcon(Integer(fIcons.Objects[i])) then raiseLastOsError;
      DestroyIcon(Integer(fIcons.Objects[i]));
      fIcons.Objects[i] := nil;
    end;
  FreeAndNil(fIcons);
  if fhInstance <> 0 then
  begin
    if not FreeLibrary(fhInstance) then
     {$IFDEF VER130}
        RaiseLastWin32Error;
     {$ELSE}
        RaiseLastOSError;
     {$ENDIF}
    fhInstance := 0;
  end;
  TPaitBoxCep(fPaintBox).Resize;
end;

procedure TFormOpenResource.SelectIndex(Index:integer);
var i:integer;
begin
  for i := 0 to Length(fSelIndexes) - 1 do
    if fSelIndexes[i]=Index then Exit;
  SetLength(fSelIndexes,Length(fSelIndexes)+1);
  fSelIndexes[Length(fSelIndexes)-1] := Index;
end;

procedure TFormOpenResource.UnSelectIndex(Index:integer);
var i:integer;
begin
  for i := 0 to Length(fSelIndexes) - 1 do
    if fSelIndexes[i]=Index then
    begin
      move(fSelIndexes[i+1],fSelIndexes[i],SizeOf(fSelIndexes[i])*Length(fSelIndexes)-i-1);
      SetLength(fSelIndexes,Length(fSelIndexes)-1);
      break;
    end;
end;

procedure TFormOpenResource.ClickCancel(Sender: TObject);
begin
  fResourceName := '';
  Close;
  ModalResult := IdCancel;
end;

procedure TFormOpenResource.ClickOk(Sender: TObject);
var i: integer;
begin
  fResourceName := '';
  if fIcons<>nil then
    for i := 0 to fIcons.Count - 1 do
      if IsSelectedIndex(i) then
        if fResourceName='' then fResourceName := fIcons[i]
                            else fResourceName := fResourceName+';'+fIcons[i];
  Close;
  if fResourceName<>'' then ModalResult := IdOk;
end;

procedure TFormOpenResource.SetFileName(const Value: string);
var OldFileName:string;
begin
  if trim(fFileName)<>trim(Value) then
  begin
    OldFileName := fFileName;
    fFileName := Value;
    try
      UpdateHinstance;
    except
      fFileName := OldFileName;
      raise;
    end;
    Realign;
    Caption := Trim(fFileName);
    Invalidate;
  end;
end;

{ TOpenPictureDialogCep }

procedure TOpenPictureDialogCep.DoSelectionChange;
  {$IFDEF VER130}
  {$ELSE}
var
  ValidPicture: boolean;
  FullName: string;
  i: integer;
  FDlgSIL: TFormDlgSIL;
  function ValidFile(const FileName: string): Boolean;
  begin
    Result := (Trim(FileName)<>'') and
              (uppercase(ExtractFileExt(FileName))<>'.LNK') and
              (GetFileAttributes(PChar(FileName)) <> $FFFFFFFF) and
              (FileExists(FileName)) ;
  end;
  {$ENDIF}
begin
  {$IFDEF VER130}
  inherited; //Обладатели Delphi 5 обламываются!
  {$ELSE}
  FullName := '';
  i := Pos('"',FileName);
  if I>0 then
  begin
    FullName := Copy(FileName,1,i-1);
    inc(I);
    while (I<=Length(FileName)) and (FileName[i]<>'"') do
    begin
      FullName := FullName+FileName[i];
      inc(I);
    end;
  end else
    FullName := FileName;
  
  if (Owner is TFormDlgSIL) then
  begin
    ValidPicture := ValidFile(FullName);
    if (FullName <> FSavedFilename) and
       (ValidPicture) then
    begin
      FDlgSIL := TFormDlgSIL(Owner);
      FSavedFilename := FullName;
      FDlgSIL.OpenFile(FullName,0,ImageCtrl);
    end;
    PictureLabel.Caption := ExtractFileName(FullName);
    ImageCtrl.Visible := ValidPicture;
  end else inherited;
  {$ENDIF}
end;

end.


