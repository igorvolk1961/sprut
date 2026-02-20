unit DM_Windows;

interface
uses
  Windows;

var
  OSVersion:integer;

const
{ dwPlatformId defines }
  VER_PLATFORM_WIN32s = Windows.VER_PLATFORM_WIN32s;
  VER_PLATFORM_WIN32_WINDOWS = Windows.VER_PLATFORM_WIN32_WINDOWS;
  VER_PLATFORM_WIN32_NT = Windows.VER_PLATFORM_WIN32_NT;

  DISP_E_BADINDEX=Windows.DISP_E_BADINDEX;

  { Keyboard Layout API }
  KLF_ACTIVATE = Windows.KLF_ACTIVATE;
  KLF_REORDER = Windows.KLF_REORDER;
  KLF_REPLACELANG = Windows.KLF_REPLACELANG;

  { GetSystemMetrics() codes }
  SM_CYCAPTION=Windows.SM_CYCAPTION;

  { Virtual Keys, Standard Set }
  VK_SHIFT = Windows.VK_SHIFT;
  VK_CONTROL = Windows.VK_CONTROL;
  VK_CAPITAL = Windows.VK_CAPITAL;
  VK_UP = Windows.VK_UP;
  VK_DOWN = Windows.VK_DOWN;
  VK_LEFT = Windows.VK_LEFT;
  VK_RIGHT = Windows.VK_RIGHT;
  VK_BACK = Windows.VK_BACK;
  VK_INSERT = Windows.VK_INSERT;
  VK_DELETE = Windows.VK_DELETE;
  VK_RETURN = Windows.VK_RETURN;
  VK_ESCAPE = Windows.VK_ESCAPE;
  VK_F4 = Windows.VK_F4;
  VK_F5 = Windows.VK_F5;
  VK_F6 = Windows.VK_F6;
  VK_F7 = Windows.VK_F7;
  VK_F8 = Windows.VK_F8;
  VK_F11 = Windows.VK_F11;
  VK_SPACE = Windows.VK_SPACE;
  VK_MENU = Windows.VK_MENU;

{ Reserved Key Handles. }
  HKEY_LOCAL_MACHINE = Windows.HKEY_LOCAL_MACHINE;
  HKEY_CLASSES_ROOT = Windows.HKEY_CLASSES_ROOT;

  { Flags for TrackPopupMenu }
  TPM_LEFTALIGN = Windows.TPM_LEFTALIGN;
  TPM_LEFTBUTTON = Windows.TPM_LEFTBUTTON;

  { Predefined Clipboard Formats }
  CF_BITMAP = Windows.CF_BITMAP;
  CF_MAX = Windows.CF_MAX;

  { StretchBlt() Modes }
  COLORONCOLOR = Windows.COLORONCOLOR;

  { TPixelFormatDescriptor flags }
  PFD_DOUBLEBUFFER = Windows.PFD_DOUBLEBUFFER;
  PFD_DRAW_TO_WINDOW = Windows.PFD_DRAW_TO_WINDOW;
  PFD_SUPPORT_OPENGL = Windows.PFD_SUPPORT_OPENGL;
  PFD_TYPE_RGBA = Windows.PFD_TYPE_RGBA;

  { Listbox Return Values }
  LB_ERR = Windows.LB_ERR;

  INFINITE = Windows.INFINITE;     { Infinite timeout }

  { Commands to pass to WinHelp() }
  HELP_FINDER = Windows.HELP_FINDER;

{ field selection bits }
  DM_PELSWIDTH = Windows.DM_PELSWIDTH;
  DM_PELSHEIGHT = Windows.DM_PELSHEIGHT;

  KEY_ALL_ACCESS=Windows.KEY_ALL_ACCESS;
  ERROR_SUCCESS=Windows.ERROR_SUCCESS;
  SECURITY_DESCRIPTOR_MIN_LENGTH=Windows.SECURITY_DESCRIPTOR_MIN_LENGTH;
  DACL_SECURITY_INFORMATION=Windows.DACL_SECURITY_INFORMATION;

  LOGPIXELSY = Windows.LOGPIXELSY;

  PAGE_READWRITE = Windows.PAGE_READWRITE;

type
  BOOL = Windows.Bool;
  HPALETTE = Windows.HPALETTE;
  HDC = Windows.HDC;
  HWnd = Windows.HWnd;
  HBITMAP = Windows.HBITMAP;
  HMenu = Windows.HMenu;
  PSECURITY_DESCRIPTOR = Pointer;
  HKey=Windows.HKEy;

type
  TKeyboardState=Windows.TKeyboardState;
  TPixelFormatDescriptor=Windows.TPixelFormatDescriptor;
  TLogFont=Windows.TLogFont;
  TTextMetric=Windows.TTextMetric;
  TStartupInfo=Windows.TStartupInfo;
  TProcessInformation=Windows.TProcessInformation;
  PDeviceMode=Windows.PDeviceMode;
  TDeviceMode=Windows.TDeviceMode;

function DM_GetSystemMetrics(nIndex: Integer): Integer; stdcall;
function DM_Succeeded(Status: HRESULT): BOOL;
function DM_GetActiveWindow: HWND; stdcall;
function DM_DestroyWindow(hWnd: HWND): BOOL; stdcall;
function DM_GetKeyboardLayoutName(pwszKLID: PChar): BOOL; stdcall;
function DM_LoadKeyboardLayout(pwszKLID: PChar; Flags: UINT): HKL; stdcall;
function DM_GetKeyboardState(var KeyState: TKeyboardState): BOOL; stdcall;
function DM_SetKeyboardState(var KeyState: TKeyboardState): BOOL; stdcall;
function DM_GetKeyState(nVirtKey: Integer): SHORT; stdcall;
function DM_PostMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
function DM_SendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
function DM_GetCursorPos(var lpPoint: TPoint): BOOL; stdcall;
function DM_SetCursorPos(X, Y: Integer): BOOL; stdcall;
function DM_GetClassName(hWnd: HWND; lpClassName: PChar; nMaxCount: Integer): Integer; stdcall;
function DM_GetParent(hWnd: HWND): HWND; stdcall;
function DM_EnumChildWindows(hWndParent: HWND; lpEnumFunc: TFNWndEnumProc;
  lParam: LPARAM): BOOL; stdcall;
function DM_GetWindowText(hWnd: HWND; lpString: PChar; nMaxCount: Integer): Integer; stdcall;
function DM_GetWindowRect(hWnd: HWND; var lpRect: TRect): BOOL; stdcall;
function DM_InvalidateRect(hWnd: HWND; lpRect: PRect; bErase: BOOL): BOOL; stdcall;
function DM_GetMenuItemCount(hMenu: HMENU): Integer; stdcall;
function DM_GetMenuItemID(hMenu: HMENU; nPos: Integer): UINT; stdcall;
function DM_GetSubMenu(hMenu: HMENU; nPos: Integer): HMENU; stdcall;
function DM_TrackPopupMenu(hMenu: HMENU; uFlags: UINT; x, y, nReserved: Integer;
  hWnd: HWND; prcRect: PRect): BOOL; stdcall;
function DM_GetMenuItemRect(hWnd: HWND; hMenu: HMENU; uItem: UINT;
  var lprcItem: TRect): BOOL; stdcall;
function DM_DeleteObject(p1: HGDIOBJ): BOOL; stdcall;
function DM_SetStretchBltMode(DC: HDC; StretchMode: Integer): Integer; stdcall;
function DM_PlgBlt(DestDC: HDC; const PointsArray; SrcDC: HDC;
  XSrc, YSrc, Width, Height: Integer; Mask: HBITMAP; xMask, yMask: Integer): BOOL; stdcall;
function DM_LoadCursor(hInstance: HINST; lpCursorName: PAnsiChar): HCURSOR; stdcall;
function DM_GetRValue(rgb: DWORD): Byte;
function DM_GetGValue(rgb: DWORD): Byte;
function DM_GetBValue(rgb: DWORD): Byte;
function DM_ChoosePixelFormat(DC: HDC; p2: PPixelFormatDescriptor): Integer; stdcall;
function DM_SetPixelFormat(DC: HDC; PixelFormat: Integer; FormatDef: PPixelFormatDescriptor): BOOL; stdcall;
function DM_GetDC(hWnd: HWND): HDC; stdcall;
function DM_DeleteDC(DC: HDC): BOOL; stdcall;
function DM_ReleaseDC(hWnd: HWND; hDC: HDC): Integer; stdcall;
function DM_wglCreateContext(DC: HDC): HGLRC; stdcall;
function DM_wglDeleteContext(p1: HGLRC): BOOL; stdcall;
function DM_wglMakeCurrent(DC: HDC; p2: HGLRC): BOOL; stdcall;
function DM_SwapBuffers(DC: HDC): BOOL; stdcall;
function DM_MulDiv(nNumber, nNumerator, nDenominator: Integer): Integer; stdcall;
function DM_EnumFonts(DC: HDC; lpszFace: PChar; fntenmprc: TFNFontEnumProc;
  lpszData: PChar): Integer; stdcall;
function DM_GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall;
function DM_LoadLibrary(lpLibFileName: PChar): HMODULE; stdcall;
function DM_FreeLibrary(hLibModule: HMODULE): BOOL; stdcall;
function DM_CreateProcess(lpApplicationName: PChar; lpCommandLine: PChar;
  lpProcessAttributes, lpThreadAttributes: PSecurityAttributes;
  bInheritHandles: BOOL; dwCreationFlags: DWORD; lpEnvironment: Pointer;
  lpCurrentDirectory: PChar; const lpStartupInfo: TStartupInfo;
  var lpProcessInformation: TProcessInformation): BOOL; stdcall;
function DM_WaitForSingleObject(hHandle: THandle; dwMilliseconds: DWORD): DWORD; stdcall;
function DM_CloseHandle(hObject: THandle): BOOL; stdcall;
function DM_ChangeDisplaySettings(var lpDevMode: TDeviceMode; dwFlags: DWORD): Longint; stdcall;
function DM_RegOpenKeyEx(hKey: HKEY; lpSubKey: PChar;
  ulOptions: DWORD; samDesired: REGSAM; var phkResult: HKEY): Longint; stdcall;
function DM_InitializeSecurityDescriptor(pSecurityDescriptor: PSecurityDescriptor;
  dwRevision: DWORD): BOOL; stdcall;
function DM_SetSecurityDescriptorDacl(pSecurityDescriptor: PSecurityDescriptor;
  bDaclPresent: BOOL; pDacl: PACL; bDaclDefaulted: BOOL): BOOL; stdcall;
function DM_RegSetKeySecurity(hKey: HKEY; SecurityInformation: SECURITY_INFORMATION;
  pSecurityDescriptor: PSECURITY_DESCRIPTOR): Longint; stdcall;
function DM_RegCloseKey(hKey: HKEY): Longint; stdcall;
function DM_GetDeviceCaps(DC: HDC; Index: Integer): Integer; stdcall;

function DM_GetOSVersion:integer;
function DM_VirtualProtect(lpAddress: Pointer; dwSize, flNewProtect: DWORD;
  lpflOldProtect: Pointer): BOOL; stdcall;

type
  TBLENDFUNCTION=record
    BlendOp:byte;
    BlendFlags:byte;
    SourceConstantAlpha:byte;
    AlphaFormat:byte;
  end;

{$EXTERNALSYM AlphaBlend}
function AlphaBlend(
  hdcDest:HDC;                 // дескриптор целевого DC
  nXOriginDest:longint;        // x-коорд. левого верхнего угла
  nYOriginDest:longint;        // y-коорд. левого верхнего угла
  nWidthDest:longint;          // ширина целевого прямоугольника
  nHeightDest:longint;         // высота целевого прямоугольника
  hdcSrc:HDC;                  // дескриптор источникового DC
  nXOriginSrc:longint;         // x-коорд. левого верхнего угла
  nYOriginSrc:longint;         // y-коорд. левого верхнего угла
  nWidthSrc:longint;           // ширина источникового прямоугольника
  nHeightSrc:longint;          // высота источникового прямоугольника
  blendFunction:TBLENDFUNCTION):BOOL; stdcall;

implementation

function DM_GetSystemMetrics(nIndex: Integer): Integer;
begin
  Result:=GetSystemMetrics(nIndex)
end;

function DM_Succeeded(Status: HRESULT): BOOL;
begin
  Result := Status and HRESULT($80000000) = 0;
end;

function DM_GetActiveWindow: HWND;
begin
  Result:=GetActiveWindow
end;

function DM_DestroyWindow(hWnd: HWND): BOOL;
begin
  Result:=DestroyWindow(hWnd)
end;

function DM_GetKeyboardLayoutName(pwszKLID: PChar): BOOL;
begin
  Result:=GetKeyboardLayoutName(pwszKLID)
end;

function DM_LoadKeyboardLayout(pwszKLID: PChar; Flags: UINT): HKL;
begin
  Result:=LoadKeyboardLayout(pwszKLID, Flags)
end;

function DM_GetKeyboardState(var KeyState: TKeyboardState): BOOL;
begin
  Result:=GetKeyboardState(KeyState)
end;

function DM_SetKeyboardState(var KeyState: TKeyboardState): BOOL;
begin
  Result:=SetKeyboardState(KeyState)
end;

function DM_PostMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL;
begin
  Result:=PostMessage(hWnd, Msg, wParam, lParam)
end;

function DM_SendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result:=SendMessage(hWnd, Msg, wParam, lParam)
end;

function DM_GetCursorPos(var lpPoint: TPoint): BOOL;
begin
  Result:=GetCursorPos(lpPoint)
end;

function DM_SetCursorPos(X, Y: Integer): BOOL;
begin
  Result:=SetCursorPos(X, Y)
end;

function DM_GetClassName(hWnd: HWND; lpClassName: PChar; nMaxCount: Integer): Integer;
begin
  Result:=GetClassName(hWnd, lpClassName, nMaxCount)
end;

function DM_GetParent(hWnd: HWND): HWND;
begin
  Result:=GetParent(hWnd)
end;

function DM_EnumChildWindows(hWndParent: HWND; lpEnumFunc: TFNWndEnumProc;
  lParam: LPARAM): BOOL;
begin
  Result:=EnumChildWindows(hWndParent, lpEnumFunc, lParam)
end;

function DM_GetWindowText(hWnd: HWND; lpString: PChar; nMaxCount: Integer): Integer;
begin
  Result:=GetWindowText(hWnd, lpString, nMaxCount)
end;

function DM_GetWindowRect(hWnd: HWND; var lpRect: TRect): BOOL;
begin
  Result:=GetWindowRect(hWnd, lpRect)
end;

function DM_InvalidateRect(hWnd: HWND; lpRect: PRect; bErase: BOOL): BOOL;
begin
  Result:=InvalidateRect(hWnd, lpRect, bErase)
end;

function DM_GetMenuItemCount(hMenu: HMENU): Integer;
begin
  Result:=GetMenuItemCount(hMenu)
end;

function DM_GetMenuItemID(hMenu: HMENU; nPos: Integer): UINT;
begin
  Result:=GetMenuItemID(hMenu, nPos)
end;

function DM_GetSubMenu(hMenu: HMENU; nPos: Integer): HMENU;
begin
  Result:=GetSubMenu(hMenu, nPos)
end;

function DM_TrackPopupMenu(hMenu: HMENU; uFlags: UINT; x, y, nReserved: Integer;
  hWnd: HWND; prcRect: PRect): BOOL;
begin
  Result:=TrackPopupMenu(hMenu, uFlags, x, y, nReserved, hWnd, prcRect)
end;

function DM_GetMenuItemRect(hWnd: HWND; hMenu: HMENU; uItem: UINT;
  var lprcItem: TRect): BOOL;
begin
  Result:=GetMenuItemRect(hWnd, hMenu, uItem, lprcItem)
end;

function DM_DeleteObject(p1: HGDIOBJ): BOOL;
begin
  Result:=DeleteObject(p1)
end;

function DM_GetKeyState(nVirtKey: Integer): SHORT;
begin
  Result:=GetKeyState(nVirtKey)
end;

function DM_SetStretchBltMode(DC: HDC; StretchMode: Integer): Integer;
begin
  Result:=SetStretchBltMode(DC, StretchMode)
end;

function DM_PlgBlt(DestDC: HDC; const PointsArray; SrcDC: HDC;
  XSrc, YSrc, Width, Height: Integer; Mask: HBITMAP; xMask, yMask: Integer): BOOL;
begin
  Result:=PlgBlt(DestDC, PointsArray, SrcDC,
                 XSrc, YSrc, Width, Height, Mask, xMask, yMask)
end;

function DM_LoadCursor(hInstance: HINST; lpCursorName: PAnsiChar): HCURSOR;
begin
  Result:=LoadCursor(hInstance, lpCursorName)
end;

function DM_GetRValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb);
end;

function DM_GetGValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 8);
end;

function DM_GetBValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 16);
end;

function DM_ChoosePixelFormat(DC: HDC; p2: PPixelFormatDescriptor): Integer;
begin
  Result := ChoosePixelFormat(DC, p2)
end;

function DM_SetPixelFormat(DC: HDC; PixelFormat: Integer; FormatDef: PPixelFormatDescriptor): BOOL;
begin
  Result := SetPixelFormat(DC, PixelFormat, FormatDef)
end;

function DM_GetDC(hWnd: HWND): HDC;
begin
  Result := GetDC(hWnd)
end;

function DM_DeleteDC(DC: HDC): BOOL;
begin
  Result := DeleteDC(DC)
end;

function DM_ReleaseDC(hWnd: HWND; hDC: HDC): Integer;
begin
  Result := ReleaseDC(hWnd, hDC)
end;

function DM_wglCreateContext(DC: HDC): HGLRC;
begin
  Result := wglCreateContext(DC)
end;

function DM_wglDeleteContext(p1: HGLRC): BOOL;
begin
  Result := wglDeleteContext(p1)
end;

function DM_wglMakeCurrent(DC: HDC; p2: HGLRC): BOOL;
begin
  Result := wglMakeCurrent(DC, p2)
end;

function DM_SwapBuffers(DC: HDC): BOOL;
begin
  Result := SwapBuffers(DC)
end;

function DM_MulDiv(nNumber, nNumerator, nDenominator: Integer): Integer;
begin
  Result := MulDiv(nNumber, nNumerator, nDenominator)
end;

function DM_EnumFonts(DC: HDC; lpszFace: PChar; fntenmprc: TFNFontEnumProc;
  lpszData: PChar): Integer;
begin
  Result := EnumFonts(DC, lpszFace, fntenmprc, lpszData)
end;

function DM_GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC;
begin
  Result := GetProcAddress(hModule, lpProcName)
end;

function DM_LoadLibrary(lpLibFileName: PChar): HMODULE;
begin
  Result := LoadLibrary(lpLibFileName)
end;

function DM_FreeLibrary(hLibModule: HMODULE): BOOL;
begin
  Result := FreeLibrary(hLibModule)
end;

function DM_CreateProcess(lpApplicationName: PChar; lpCommandLine: PChar;
  lpProcessAttributes, lpThreadAttributes: PSecurityAttributes;
  bInheritHandles: BOOL; dwCreationFlags: DWORD; lpEnvironment: Pointer;
  lpCurrentDirectory: PChar; const lpStartupInfo: TStartupInfo;
  var lpProcessInformation: TProcessInformation): BOOL;
begin
  Result := CreateProcess(lpApplicationName, lpCommandLine,
  lpProcessAttributes, lpThreadAttributes,
  bInheritHandles, dwCreationFlags, lpEnvironment,
  lpCurrentDirectory, lpStartupInfo,
  lpProcessInformation)
end;

function DM_WaitForSingleObject(hHandle: THandle; dwMilliseconds: DWORD): DWORD;
begin
  Result := WaitForSingleObject(hHandle, dwMilliseconds)
end;

function DM_CloseHandle(hObject: THandle): BOOL;
begin
  Result := CloseHandle(hObject)
end;

function DM_ChangeDisplaySettings(var lpDevMode: TDeviceMode; dwFlags: DWORD): Longint;
begin
  Result := ChangeDisplaySettings(lpDevMode, dwFlags)
end;

function DM_RegOpenKeyEx(hKey: HKEY; lpSubKey: PChar;
  ulOptions: DWORD; samDesired: REGSAM; var phkResult: HKEY): Longint;
begin
  Result:=RegOpenKeyEx(hKey, lpSubKey, ulOptions, samDesired, phkResult)
end;

function DM_InitializeSecurityDescriptor(pSecurityDescriptor: PSecurityDescriptor;
  dwRevision: DWORD): BOOL;
begin
  Result:=InitializeSecurityDescriptor(pSecurityDescriptor, dwRevision)
end;

function DM_SetSecurityDescriptorDacl(pSecurityDescriptor: PSecurityDescriptor;
  bDaclPresent: BOOL; pDacl: PACL; bDaclDefaulted: BOOL): BOOL; stdcall;
begin
  Result:=SetSecurityDescriptorDacl(pSecurityDescriptor, bDaclPresent,
                                    pDacl, bDaclDefaulted)
end;

function DM_RegSetKeySecurity(hKey: HKEY; SecurityInformation: SECURITY_INFORMATION;
  pSecurityDescriptor: PSECURITY_DESCRIPTOR): Longint;
begin
  Result:=RegSetKeySecurity(hKey, SecurityInformation, pSecurityDescriptor)
end;

function DM_RegCloseKey(hKey: HKEY): Longint;
begin
  Result:=RegCloseKey(hKey)
end;

function DM_GetDeviceCaps(DC: HDC; Index: Integer): Integer;
begin
  Result:=GetDeviceCaps(DC, Index)
end;

function DM_GetOSVersion:integer;
var
  vi:tOSVersionInfo;
begin
  vi.dwOSVersionInfoSize:=sizeOf(tOSVersionInfo);
  if getVersionEx(vi)then
    Result:=vi.dwPlatformId
  else
    Result:=0
end;

function DM_VirtualProtect(lpAddress: Pointer; dwSize, flNewProtect: DWORD;
  lpflOldProtect: Pointer): BOOL;
begin
  Result:=VirtualProtect(lpAddress, dwSize, flNewProtect, lpflOldProtect)
end;

function AlphaBlend; external 'MSimg32.dll' name 'AlphaBlend';

initialization
  OSVersion:=DM_GetOSVersion;
end.
