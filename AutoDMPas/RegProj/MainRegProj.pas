unit MainRegProj;

interface

uses
  Windows,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    miFile: TMenuItem;
    miNew: TMenuItem;
    miOpen: TMenuItem;
    miSave: TMenuItem;
    N4: TMenuItem;
    miExit: TMenuItem;
    miRegister: TMenuItem;
    miUnregister: TMenuItem;
    N8: TMenuItem;
    miAdd: TMenuItem;
    miDelete: TMenuItem;
    lbFiles: TListBox;
    Panel1: TPanel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OpenDialog2: TOpenDialog;
    procedure miNewClick(Sender: TObject);
    procedure miOpenClick(Sender: TObject);
    procedure miSaveClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miAddClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure miRegisterClick(Sender: TObject);
    procedure miUnregisterClick(Sender: TObject);
  private
    FileName:string;
    Changed:boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.miNewClick(Sender: TObject);
begin
  if Changed and
     (MessageDlg('Данные не сохранены.'#13'Продолжить?', mtConfirmation, mbOkCancel, 0)=mrCancel) then Exit;
  Changed:=False;
  FileName:='';
  lbFiles.Clear;
end;

procedure TForm1.miOpenClick(Sender: TObject);
var
  F:TextFile;
  S:string;
begin
  if Changed and
     (MessageDlg('Данные не сохранены.'#13'Продолжить?', mtConfirmation, mbOkCancel, 0)=mrCancel) then Exit;
  OpenDialog1.FileName:=FileName;
  if not OpenDialog1.Execute then Exit;
  FileName:=OpenDialog1.FileName;
  AssignFile(F, FileName);
  Reset(F);
  try
  lbFiles.Clear;
  while not EOF(F) do begin
    Readln(F, S);
    lbFiles.Items.Add(S);
  end;
  Changed:=False;
  finally
    CloseFile(F);
  end;
end;

procedure TForm1.miSaveClick(Sender: TObject);
var
  F:TextFile;
  S:string;
  j:integer;
begin
  SaveDialog1.FileName:=FileName;
  if not SaveDialog1.Execute then Exit;
  FileName:=SaveDialog1.FileName;
  AssignFile(F, FileName);
  Rewrite(F);
  try
  for j:=0 to lbFiles.Items.Count-1 do begin
    S:=lbFiles.Items[j];
    Writeln(F, S);
  end;
  Changed:=False;
  finally
    CloseFile(F);
  end;
end;

procedure TForm1.miExitClick(Sender: TObject);
begin
  Exit;
end;

procedure TForm1.miAddClick(Sender: TObject);
var
  S:string;
  j:integer;
begin
  OpenDialog2.FileName:=FileName;
  if not OpenDialog2.Execute then Exit;
  if OpenDialog2.Files.Count=0 then Exit;
  Changed:=True;
  for j:=0 to OpenDialog2.Files.Count-1 do begin
    S:=OpenDialog2.Files[j];
    lbFiles.Items.Add(S);
  end;
end;

procedure TForm1.miDeleteClick(Sender: TObject);
var
  j:integer;
begin
  j:=0;
  if lbFiles.SelCount=0 then Exit;
  Changed:=True;
  while j<lbFiles.Items.Count do begin
    if lbFiles.Selected[j] then
      lbFiles.Items.Delete(j)
    else
      inc(j)
  end;
end;

var F:function: HResult;

procedure TForm1.miRegisterClick(Sender: TObject);
var
  j:integer;
  S:string;
  P:array[0..255] of char;
  H:LongWord;
begin
  try
  for j:=0 to lbFiles.Items.Count-1 do begin
    S:=lbFiles.Items[j];
    if FileExists(S) then begin
      StrPCopy(P, S);
      H:=LoadLibrary(P);
      try
        F:=GetProcAddress(H, 'DllRegisterServer');
        F;
      finally
        FreeLibrary(H);
      end;  
    end else
      ShowMessage('Файл '+S+' отсутствует')
  end;
  ShowMessage('Done!!!')
  except
    raise
  end;
end;

procedure TForm1.miUnregisterClick(Sender: TObject);
var
  j:integer;
  S:string;
  P:array[0..255] of char;
  H:LongWord;
begin
  try
  for j:=0 to lbFiles.Items.Count-1 do begin
    S:=lbFiles.Items[j];
    StrPCopy(P, S);
    if FileExists(S) then begin
      H:=LoadLibrary(P);
      try
        F:=GetProcAddress(H, 'DllUnregisterServer');
        F;
      finally
        FreeLibrary(H);
      end;
    end else
      ShowMessage('Файл '+S+' отсутствует')
  end;
  ShowMessage('Done!!!')
  except
    raise
  end;
end;

end.

