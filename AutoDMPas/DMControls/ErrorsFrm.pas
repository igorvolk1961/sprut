unit ErrorsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  DataModel_TLB, SpatialModelLib_TLB, DMServer_TLB, StdCtrls;

type
  TfmErrors = class(TForm)
    lbErrors: TListBox;
    btHelp: TButton;
    btShowError: TButton;
    btCorrectErrors: TButton;
    btClose: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure btCorrectErrorsClick(Sender: TObject);
    procedure btShowErrorClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure lbErrorsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lbErrorsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    FDataModel:IDataModel;
    procedure SetDataModel(const DataModel:IDataModel);
  public
    procedure CheckModel;
    property DataModel:IDataModel read FDataModel write SetDataModel;
  end;

var
  fmErrors: TfmErrors;

implementation

{$R *.dfm}

procedure TfmErrors.FormDestroy(Sender: TObject);
begin
  FDataModel:=nil
end;

procedure TfmErrors.CheckModel;
var
  j:integer;
  DMErrorE:IDMElement;
  S:string;
begin
  lbErrors.Clear;
  FDataModel.CheckErrors;
  if DataModel.Errors.Count+DataModel.Warnings.Count=0 then
    ShowMessage('Ошибки не обнаружены')
  else
    for j:=0 to DataModel.Errors.Count-1 do begin
      DMErrorE:=DataModel.Errors.Item[j];
      S:=DMErrorE.Name;
      lbErrors.AddItem(S, pointer(DMErrorE));
    end;
    for j:=0 to DataModel.Warnings.Count-1 do begin
      DMErrorE:=DataModel.Warnings.Item[j];
      S:=DMErrorE.Name;
      lbErrors.AddItem(S, pointer(DMErrorE));
    end;
end;

procedure TfmErrors.SetDataModel(const DataModel: IDataModel);
var
  j:integer;
  DMErrorE:IDMElement;
  S:string;
begin
  lbErrors.Clear;
  FDataModel:=DataModel;
  for j:=0 to DataModel.Errors.Count-1 do begin
    DMErrorE:=DataModel.Errors.Item[j];
    S:=DMErrorE.Name;
    lbErrors.AddItem(S, pointer(DMErrorE));
  end;
  for j:=0 to DataModel.Warnings.Count-1 do begin
    DMErrorE:=DataModel.Warnings.Item[j];
    S:=DMErrorE.Name;
    lbErrors.AddItem(S, pointer(DMErrorE));
  end;
end;

procedure TfmErrors.btCorrectErrorsClick(Sender: TObject);
var
  j, j1:integer;
begin
  if MessageDlg('Внимание! Процедура автоматического исправления ошибок'#13+
                'не может быть отменена и не гарантирует корректного иправления'#13+
                'Рекомендуется предварительно сохранить модель в файле с другим именем.'#13+
                'Продолжить автоматическое исправление?', mtConfirmation, [mbYes,mbNo], 0)<mrYes then Exit;
  for j:=0 to DataModel.Errors.Count-1 do begin
    if lbErrors.Selected[j] then
      DataModel.Errors.Item[j].Selected:=True;
  end;
  for j:=0 to DataModel.Warnings.Count-1 do begin
    j1:=DataModel.Errors.Count+j;
    if lbErrors.Selected[j1] then
      DataModel.Warnings.Item[j].Selected:=True;
  end;
  FDataModel.CorrectErrors;
  CheckModel;
end;

procedure TfmErrors.btShowErrorClick(Sender: TObject);
var
  j:integer;
  DMErrorE:IDMElement;
  SMDocument:ISMDocument;
  DMDocument:IDMDocument;
begin
  j:=lbErrors.ItemIndex;
  if j=-1 then Exit;
  if j<DataModel.Errors.Count then begin
    DMErrorE:=DataModel.Errors.Item[j]
  end else begin
    j:=j-DataModel.Errors.Count;
    DMErrorE:=DataModel.Warnings.Item[j]
  end;
  DMDocument:=DataModel.Document as IDMDocument;
  SMDocument:=DMDocument as ISMDocument;
  DMDocument.ClearSelection(nil);

  DMErrorE.Ref.Selected:=True;
  SMDocument.ZoomSelection;

  Close;
end;

procedure TfmErrors.btCloseClick(Sender: TObject);
var
  DMDocument:IDMDocument;
begin
  DMDocument:=DataModel.Document as IDMDocument;
  DMDocument.ClearSelection(nil);
end;

procedure TfmErrors.lbErrorsClick(Sender: TObject);
var
  j, j1:integer;
  DMError:IDMError;
  Flag:boolean;
begin
  btCorrectErrors.Enabled:=False;
  if lbErrors.SelCount=0 then Exit;

  j:=0;
  j1:=0;
  while j<DataModel.Errors.Count do begin
    if lbErrors.Selected[j1] then begin
      DMError:=DataModel.Errors.Item[j] as IDMError;
      if not DMError.Correctable then
        Break
      else begin
        inc(j);
        inc(j1)
      end;
    end else begin
      inc(j);
      inc(j1);
    end;
  end;
  j:=0;
  while j<DataModel.Warnings.Count do begin
    if lbErrors.Selected[j1] then begin
      DMError:=DataModel.Warnings.Item[j] as IDMError;
      if not DMError.Correctable then
        Break
      else begin
        inc(j);
        inc(j1)
      end;
    end else begin
      inc(j);
      inc(j1);
    end;
  end;
  btCorrectErrors.Enabled:=(j1=DataModel.Errors.Count+DataModel.Warnings.Count);
end;

procedure TfmErrors.FormActivate(Sender: TObject);
begin
  btCorrectErrors.Enabled:=False;
end;

procedure TfmErrors.lbErrorsDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Offset:integer;
  Canvas:TCanvas;
  DMError:IDMError;
  j:integer;
begin
  Canvas:=(Control as TListBox).Canvas;
  Canvas.FillRect(Rect);       { clear the rectangle }
  Offset := 2;          { provide default offset }
  if Index<DataModel.Errors.Count then begin
    j:=Index;
    DMError:=DataModel.Errors.Item[j] as IDMError
  end else begin
    j:=Index-DataModel.Errors.Count;
    DMError:=DataModel.Warnings.Item[j] as IDMError
  end;
  if DMError.Correctable then
    Canvas.Font.Style:=[fsBold]
  else
    Canvas.Font.Style:=[];
  if DMError.Code>=10000 then
    Canvas.Font.Style:=Canvas.Font.Style+[fsItalic];
  Canvas.TextOut(Rect.Left + Offset, Rect.Top, (Control as TListBox).Items[Index]);
end;

end.
