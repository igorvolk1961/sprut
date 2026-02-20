unit DMReportU;
//___________________________________вариант  Volkov_________________________________

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_Windows, DM_Messages, DM_AxCtrls,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, Printers, Buttons,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Spin, ExtDlgs,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, DMPageU,
  ClipBrd, ActnList;

type

  TDMReport = class(TDMPage)
    RichEdit: TRichEdit;
    Panel1: TPanel;
    SaveDialog1: TSaveDialog;
    cbModes: TComboBox;
    Label1: TLabel;
    ToolbarImages: TImageList;
    FontDialog1: TFontDialog;
    SaveDialog: TSaveDialog;
    StandardToolBar: TToolBar;
    ToolButton1: TToolButton;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    PrintButton: TToolButton;
    ToolButton5: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    UndoButton: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    ToolButton11: TToolButton;
    FontSize: TEdit;
    UpDown1: TUpDown;
    ToolButton2: TToolButton;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolButton16: TToolButton;
    LeftAlign: TToolButton;
    CenterAlign: TToolButton;
    RightAlign: TToolButton;
    ToolButton20: TToolButton;
    BulletsButton: TToolButton;
    OpenDialog: TOpenDialog;
    Label2: TLabel;
    cbCategory: TComboBox;        //таб.видов

    procedure FormCreate(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure cbModesChange(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure UndoButtonClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure BoldButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure AlignButtonClick(Sender: TObject);
    procedure BulletsButtonClick(Sender: TObject);
    procedure RichEditSelectionChange(Sender: TObject);
  private
    FReportLevel:integer;
    FReportMode:integer;

    FUpdating: Boolean;
    FElementClassID:integer;

    procedure btShowErrorsClick(Sender: TObject);
    procedure PerformFileOpen(const AFileName: string);
    function CurrText: TTextAttributes;
    procedure GetFontNames;
  protected
    procedure OpenDocument; override; safecall;
    procedure RefreshDocument(FlagSet:integer); override; safecall;
    procedure SelectionChanged(DMElement:OleVariant); override; safecall;
    function DoAction(ActionCode: integer):WordBool; override; safecall;

    procedure AddSelectedToReport;
  public
    procedure Initialize; override;
  end;

implementation

{$R *.dfm}


{ TDMReportX }

procedure TDMReport.Initialize;
begin
  inherited Initialize;

  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  GetFontNames;
  RichEditSelectionChange(Self);

//  CurrText.Name := DefFontData.Name;
  CurrText.Name := 'Courier New Cyr';
  FontName.Text:=CurrText.Name;
  CurrText.Size := -DM_MulDiv(DefFontData.Height, 72, Screen.PixelsPerInch);
  FElementClassID:=-1;
end;

procedure TDMReport.FormCreate(Sender: TObject);
begin
  DecimalSeparator:='.';
end;

procedure TDMReport.SelectionChanged(DMElement: OleVariant);
var
  Element:IDMElement;
  Reporter:IDMReporter;
  Unk:IUnknown;
  ModeCount:integer;
  j:integer;
begin
  Unk:=DMElement;
  Element:=Unk as IDMElement;
  if Element=nil then Exit;
  if (Element.Ref<>nil) and
     (Element.Ref.SpatialElement=Element) then
    Element:=Element.Ref; 
  if Element.ClassID=FElementClassID then Exit;
  cbModes.Clear;
  if Element.QueryInterface(IDMReporter, Reporter)<>0 then Exit;
  ModeCount:=Reporter.ReportModeCount;
  if ModeCount=0 then Exit;
  for j:=0 to ModeCount-1 do
    cbModes.Items.Add(Reporter.ReportModeName[j]);
  cbModes.ItemIndex:=0;
  FReportLevel:=0;  
end;

procedure TDMReport.RefreshDocument;
begin
  if not Visible then Exit;
end;

procedure TDMReport.btSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then begin
    RichEdit.Lines.SaveToFile(SaveDialog1.FileName);
    RichEdit.Modified := False;
  end;
end;

procedure TDMReport.btShowErrorsClick(Sender: TObject);
var
  aDataModel:IDataMOdel;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  j:integer;
begin
  inherited;
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;
  aDataModel:=DMDocument.DataModel as IDataModel;

  RichEdit.Lines.Clear;
  for j:=0 to aDataModel.Errors.Count-1 do
    RichEdit.Lines.AddObject(aDataModel.Errors.Item[j].Name, pointer(aDataModel.Errors.Item[j]))

end;

procedure TDMReport.OpenDocument;
begin
end;

procedure TDMReport.btClearClick(Sender: TObject);
begin
  RichEdit.Lines.Clear;
  RichEdit.Modified := False;
end;

procedure TDMReport.btAddClick(Sender: TObject);
begin
  AddSelectedToReport;
end;

procedure TDMReport.AddSelectedToReport;
var
  aDataModel:IDataMOdel;
  DMDocument:IDMDocument;
  Server:IDataModelServer;
  DMText:IDMText;
  Analyzer:IDMAnalyzer;
  j:integer;
  Element:IDMElement;
  S:string;
  Reporter:IDMReporter;
begin
  Server:=Get_DataModelServer as IDataModelServer;
  DMDocument:=Server.CurrentDocument;
  if DMDocument=nil then Exit;

  aDataModel:=DMDocument.DataModel as IDataModel;
  if aDataModel=nil then Exit;
  Analyzer:=aDataModel.Analyzer;
  if Analyzer=nil then Exit;
  DMText:=Analyzer.Report;

  DMText.ClearLines;

  if RichEdit.Lines.Count=0 then begin

    S:='$R';            DMText.AddLine(S);
    S:=cbCategory.Text; DMText.AddLine(S);
    S:='$C';            DMText.AddLine(S);

    if FReportMode=0 then
      S:=Format('Отчет по результатам анализа от %s', [DateTimeToStr(Now)])
    else
      S:=Format('Рекомендации от %s', [DateTimeToStr(Now)]);
    DMText.AddLine(S);

    S:=Format('Объект %s', [(aDataModel as IDMElement).Name]);
    DMText.AddLine(S);
    S:='$L';            DMText.AddLine(S);
    S:=' ';             DMText.AddLine(S);
  end;

  try
  if DMDocument.SelectionCount>0 then begin
     for j:=0 to DMDocument.SelectionCount-1 do begin
      Element:=DMDocument.SelectionItem[j] as IDMElement;
      if (Element.Ref<>nil) and
         (Element.Ref.SpatialElement=Element) then
        Element:=Element.Ref;
      Reporter:=Element as IDMReporter;
      Reporter.BuildReport(1, 0, FReportMode, DMText);
    end
  end else begin
    S:='Для генерации отчета необходимо выделить один или несколько элементов,'#10+
       'информацию по которым Вы желаете получить';
    DMText.AddLine(S);
  end;
  except
    raise
  end;  

  try
  for j:=0 to DMText.LineCount-1 do begin
    S:=DMText.Line[j];
    if (S<>'') and
       (S[1]='$') then begin
      case S[2] of
      'N': RichEdit.SelAttributes.Style:=[];
      'I': RichEdit.SelAttributes.Style:=[fsItalic];
      'B': RichEdit.SelAttributes.Style:=[fsBold];
      'U': RichEdit.SelAttributes.Style:=[fsUnderline];
      'S': RichEdit.SelAttributes.Size:=StrToInt(Copy(S, 3, length(S)-2));
      'F': RichEdit.SelAttributes.Name:=Copy(S, 3, length(S)-2);
      'L': RichEdit.Paragraph.Alignment := taLeftJustify;
      'R': RichEdit.Paragraph.Alignment := taRightJustify;
      'C': RichEdit.Paragraph.Alignment := taCenter;
      end;
    end else
      RichEdit.Lines.Add(S);
  end;
  except
    raise
  end;  
end;

function TDMReport.DoAction(ActionCode: integer): WordBool;
begin
  case ActionCode of
  dmbaPrint:
    RichEdit.Print('Отчет СПРУТ-12');
  end;
end;

procedure TDMReport.cbModesChange(Sender: TObject);
begin
  FReportMode:=cbModes.ItemIndex
end;

procedure TDMReport.OpenButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    PerformFileOpen(OpenDialog.FileName);
    RichEdit.ReadOnly := ofReadOnly in OpenDialog.Options;
  end;
end;

procedure TDMReport.PerformFileOpen(const AFileName: string);
begin
  RichEdit.Lines.LoadFromFile(AFileName);
  RichEdit.SetFocus;
  RichEdit.Modified := False;
end;

procedure TDMReport.CutButtonClick(Sender: TObject);
begin
  RichEdit.CutToClipboard;
end;

procedure TDMReport.CopyButtonClick(Sender: TObject);
begin
  RichEdit.CopyToClipboard;
end;

procedure TDMReport.PasteButtonClick(Sender: TObject);
begin
  RichEdit.PasteFromClipboard;
end;

procedure TDMReport.UndoButtonClick(Sender: TObject);
begin
  with RichEdit do
    if HandleAllocated then DM_SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TDMReport.FontNameChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Name := FontName.Items[FontName.ItemIndex];
end;

function TDMReport.CurrText: TTextAttributes;
begin
  if RichEdit.SelLength > 0 then Result := RichEdit.SelAttributes
  else Result := RichEdit.DefAttributes;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TDMReport.GetFontNames;
var
  DC: HDC;
begin
  DC := DM_GetDC(0);
  DM_EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  DM_ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TDMReport.FontSizeChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Size := StrToInt(FontSize.Text);
end;

procedure TDMReport.BoldButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if BoldButton.Down then
    CurrText.Style := CurrText.Style + [fsBold]
  else
    CurrText.Style := CurrText.Style - [fsBold];
end;

procedure TDMReport.ItalicButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if ItalicButton.Down then
    CurrText.Style := CurrText.Style + [fsItalic]
  else
    CurrText.Style := CurrText.Style - [fsItalic];
end;

procedure TDMReport.UnderlineButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if UnderlineButton.Down then
    CurrText.Style := CurrText.Style + [fsUnderline]
  else
    CurrText.Style := CurrText.Style - [fsUnderline];
end;

procedure TDMReport.AlignButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  RichEdit.Paragraph.Alignment := TAlignment(TControl(Sender).Tag);
end;

procedure TDMReport.BulletsButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  RichEdit.Paragraph.Numbering := TNumberingStyle(BulletsButton.Down);
end;

procedure TDMReport.RichEditSelectionChange(Sender: TObject);
begin
  with RichEdit.Paragraph do
  try
    FUpdating := True;
    BoldButton.Down := fsBold in RichEdit.SelAttributes.Style;
    ItalicButton.Down := fsItalic in RichEdit.SelAttributes.Style;
    UnderlineButton.Down := fsUnderline in RichEdit.SelAttributes.Style;
    BulletsButton.Down := Boolean(Numbering);
    FontSize.Text := IntToStr(RichEdit.SelAttributes.Size);
    FontName.Text := RichEdit.SelAttributes.Name;
    case Ord(Alignment) of
      0: LeftAlign.Down := True;
      1: RightAlign.Down := True;
      2: CenterAlign.Down := True;
    end;
  finally
    FUpdating := False;
  end;
end;

end.
