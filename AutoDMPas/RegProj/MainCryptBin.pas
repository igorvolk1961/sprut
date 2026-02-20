unit MainCryptBin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure CryptFile(FileName: string; strmask: string; StartPoint, StopPoint: LongInt);
var
 F: file;
 b:byte;
 m, j, L:integer;
begin
 AssignFile(F,FileName);
 FileMode := fmOpenReadWrite;
 Reset(F,1);
 Seek(F,StartPoint);
 L:=length(strmask);
 j:=1;
 for m:=StartPoint to StopPoint do begin
   BlockRead(F,b,1);
   b := b xor byte(strmask[j]);
   Seek(F,m-1);
   BlockWrite(F,b,1);
   if j=L then
     j:=1
   else
     inc(j)
 end;
end;

function CheckFileLabel(FileName: string; strlabel: string; var point: LongInt): boolean;
var
 F: file;
 currarray: array [1..30] of byte;
 lookarray: array [1..30] of byte;
 i, L, m, XXX: integer;
begin
 Result := false;
 point := -1;
 //Load labels
 L:=length(strlabel);
 for i := 1 to 30 do  begin
  currarray[i] := 0;
 end;
 for i := 1 to L do  begin
  lookarray[i] := byte(strlabel[i]);
 end;
 //Look for label
 AssignFile(F,FileName);
 FileMode := fmOpenRead;
 Reset(F,1);
 Seek(F,0);
 m:=0;
 while not EOF(F) do begin
  for i := 1 to L-1 do
   currarray[i] := currarray[i + 1];
  BlockRead(F,currarray[L],1);
  inc(m);
  if (m=$0bb030) then
    XXX:=0;
  Result := true;
  for i := 1 to L do
   Result := Result and (currarray[i] = lookarray[i]);
  if Result then  begin
   //point points to the next byte after label
   point := FilePos(F) + 1;
   break;
  end;
 end;
 if not Result then
   point:=0;
 CloseFile(F);
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  Filename, strmask:string;
  StartPoint, StopPoint:longint;
  j:integer;
begin
  if not OpenDialog1.Execute then Exit;
  Filename:=OpenDialog1.FileName;
  CheckFileLabel(FileName, 'Модуль инициализации', StartPoint);
  CheckFileLabel(FileName, 'Конец модуля инициализации', StopPoint);
  StartPoint:=StartPoint;
  StopPoint:=StopPoint-31;

  strmask:=Lowercase(ExtractFileName(FileName));
  strmask[1]:=UpperCase(strmask)[1];
  j:=Pos('.', strmask);
  strmask:='fmMain'+Copy(strmask, 1, j-1);

  CryptFile(FileName, strmask, StartPoint, StopPoint);
  ShowMessage('Done');
end;

end.
