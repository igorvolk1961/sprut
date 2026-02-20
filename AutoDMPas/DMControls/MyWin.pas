unit MyWin;

interface
uses
  Windows, Messages, Classes, Consts;

function  CopyBits(Src: HDC; Width, Height:integer): HBITMAP;
procedure GDIError;

implementation

procedure GDIError;
var
  ErrorCode: Integer;
  Buf: array [Byte] of Char;
begin
  ErrorCode := GetLastError;
  if (ErrorCode <> 0) and (FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil,
    ErrorCode, LOCALE_USER_DEFAULT, Buf, sizeof(Buf), nil) <> 0) then
    raise EOutOfResources.Create(Buf)
  else
    raise EOutOfResources.Create(SOutOfResources);
end;


function CopyBits(Src: HDC; Width, Height:integer): HBITMAP;
var
  DC, Dst: HDC;
  OldHBMP: HBITMAP;
  Bitmap: Windows.TBitmap;
begin
  Dst := CreateCompatibleDC(0);

  try
    GetObject(Src, SizeOf(Bitmap), @Bitmap);
    DC := GetDC(0);
    if DC = 0 then GDIError;
    try
      Result := CreateCompatibleBitmap(DC, Width, Height);
      if Result = 0 then GDIError;
    finally
      ReleaseDC(0, DC);
    end;

    if Result <> 0 then
    begin
      OldHBMP := SelectObject(Dst, Result);

      StretchBlt(Dst, 0, 0, Width, Height,
                 Src, 0, 0, Width, Height, SrcCopy);
      if OldHBMP <> 0 then SelectObject(Dst, OldHBMP);
    end;
  finally
    DeleteDC(Dst);
  end;
end;

end.
