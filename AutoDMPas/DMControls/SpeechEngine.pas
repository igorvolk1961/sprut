unit SpeechEngine;

interface
uses
  Windows,
  SysUtils, Forms, Registry,
  ActiveX, ComObj,
  Speech;

procedure InstallSpeechAPI;
procedure InstallSpeechEngine;
function GetSpeechEngine:IUnknown;

implementation

const
  ModeID:TGUID='{D1829431-B467-11d3-9A09-00105A40EA60}';

function GetSpeechEngine:IUnknown;
var
  TTSCentral: ITTSCentral; {Центральный интерфейс, через который производятся все действия с речью}
  AMM: IAudioMultimediaDevice;   {Интерфейс для связи с аудиоустройством}
  TTSEnum: ITTSEnum;   {Интерфейс для перебора движков}
begin
  Result:=nil;

  InstallSpeechAPI;
  InstallSpeechEngine;

  try
    {Инициализация аудиоустройства}
    CoCreateInstance(CLSID_MMAudioDest, Nil, CLSCTX_ALL,
                     IID_IAudioMultiMediaDevice, AMM);
  except
    Exit;
  end;

  {Создание перечисляемого объекта для перебора всех движков в системе
  с помощью интерфейса ITTSEnum}
  CoCreateInstance(CLSID_TTSEnumerator, Nil, CLSCTX_ALL,
                   IID_ITTSEnum, TTSEnum);
  TTSEnum.Select(ModeID, TTSCentral, IUnknown(AMM));
  Result:=TTSCentral as IUnknown;
end;

procedure InstallSpeechAPI;
var
  SpeechDir, WinDir, S, S0:string;
  si:TStartupInfo;
  pi:TProcessInformation;
  ExeName, WindowsDirectory:array[0..255] of char;
begin
  GetWindowsDirectory(WindowsDirectory, SizeOf(WindowsDirectory));
  WinDir:=WindowsDirectory;
  SpeechDir:=WinDir+'\Speech\';
  if FileExists(SpeechDir+'\speech.dll') then Exit;

  S0:=ExtractFilePath(Application.ExeName);
  S:=S0+'spchapi.exe';
  StrPCopy(ExeName, S);
    FillChar(si, SizeOf(si), 0);
    si.cb := SizeOf(si);

    // Start the child process.
    if  not CreateProcess( nil, // No module name (use command line).
        ExeName,          // Command line.
        nil,              // Process handle not inheritable.
        nil,              // Thread handle not inheritable.
        FALSE,            // Set handle inheritance to FALSE.
        0,                // No creation flags.
        nil,              // Use parent's environment block.
        nil,              // Use parent's starting directory.
        si,               // Pointer to STARTUPINFO structure.
        pi ) then         // Pointer to PROCESS_INFORMATION structure.
          Exit;
end;

var
  RunData: Array[0..115] of byte=(
  $e4,$ad,$b0,$f0,$00,$00,$00,$00,$7b,$04,$6b,$d7,$9f,$33,$15,$3f,$70,$59,$30,$59,
  $1f,$a3,$05,$75,$4c,$b9,$f6,$89,$80,$4a,$06,$1b,$c5,$7f,$12,$7d,$01,$12,$c9,$0a,
  $4e,$56,$29,$d6,$50,
  $96,$33,$09,$7b,$b9,$47,$f0,$00,$65,$cc,$31,$4c,$db,$c3,$1b,$83,$24,$d5,$ad,$cc,
  $19,$f9,$63,$00,$ec,
  $36,$31,$4c,$f0,$ec,$44,$80,$ef,$fd,$2b,$cc,$6e,$38,$df,$00,$df,$f7,$6b,$4c,$bd,
  $ec,$b0,$80,$56,$34,
  $aa,$cc,$a3,$80,$1d,$00,$7e,$bf,$b0,$4d,$9a,$10,$da,$80,$e1,$ba,$94,$cc,$50,$be,
  $03
   );
   
procedure InstallSpeechEngine;
var
  Registry:TRegistry;
  Data:DWord;
  WinDir, SysDir, ProgDir, Drive:string;
  SystemDirectory, WindowsDirectory:array[0..255] of char;
begin
  GetWindowsDirectory(WindowsDirectory, SizeOf(WindowsDirectory));
  WinDir:=WindowsDirectory;
  GetSystemDirectory(SystemDirectory, SizeOf(SystemDirectory));
  SysDir:=SystemDirectory;
  Drive:=Copy(SysDir,1,2);
  ProgDir:=Drive+'\Program Files';

  Registry:=TRegistry.Create;
  try
    Registry.RootKey:=HKEY_LOCAL_MACHINE;

// SharedDLLs

    Registry.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs',True);
    if not Registry.ValueExists(SysDir+'\digalo.dll') then
        Registry.WriteInteger(SysDir+'\digalo.dll',1);
    if not Registry.ValueExists(SysDir+'\DigaloRegister.exe') then
        Registry.WriteInteger(SysDir+'\DigaloRegister.exe',1);
    Registry.CloseKey;

// Voice

    Registry.OpenKey('SOFTWARE\Voice',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Voice\TextToSpeech',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Voice\TextToSpeech\Engine',True);
    if not Registry.ValueExists('Digalo') then
        Registry.WriteString('Digalo', '{7EEA4F90-7FDB-11d3-998A-00105A40EA60}');
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Voice\TextToSpeech\Engine\{1B6BF820-9299-101B-8A19-265D428C60FF}',True);
    Data:=1;
    if not Registry.ValueExists('Dirty') then
        Registry.WriteBinaryData('Dirty', Data, SizeOf(DWORD));
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Voice\TextToSpeech\Engine\{F063EDA0-8C65-11CF-8FC8-0020AF14F271}',True);
    Data:=1;
    if not Registry.ValueExists('Dirty') then
        Registry.WriteBinaryData('Dirty', Data, SizeOf(DWORD));
    Registry.CloseKey;


// Elan Text To Speech

    Registry.OpenKey('SOFTWARE\Elan Text To Speech',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Elan Text To Speech\Digalo',True);
    if not Registry.ValueExists('RegEngine') then
        Registry.WriteString('RegEngine', SysDir+'\DigaloRegister.exe');
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Elan Text To Speech\Digalo\NICOLAI',True);
    if not Registry.ValueExists('CustomCmdLine') then
        Registry.WriteString('CustomCmdLine',
 '/d "'+ProgDir+'\Digalo\Digalo 2000 Russian\RUSSIAN\DATA\NICOLAI.dat"');
    if not Registry.ValueExists('data') then
        Registry.WriteString('data',
 ProgDir+'\Digalo\Digalo 2000 Russian\RUSSIAN\DATA');
    Registry.CloseKey;


    Registry.OpenKey('SOFTWARE\Elan Text To Speech\Digalo\Server Configuration',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Elan Text To Speech\Digalo\SpeechParam',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Elan Text To Speech\Digalo\Voices',True);
    Registry.CloseKey;
    Registry.OpenKey('SOFTWARE\Elan Text To Speech\Digalo\Voices\{D1829431-B467-11d3-9A09-00105A40EA60}',True);
    if not Registry.ValueExists('BasePitch') then
        Registry.WriteInteger('BasePitch', 100);
    if not Registry.ValueExists('BaseSpeed') then
        Registry.WriteInteger('BaseSpeed', 85);
    if not Registry.ValueExists('Cmd') then
        Registry.WriteString('Cmd', 'NICOLAI');
    if not Registry.ValueExists('DataFile') then
        Registry.WriteString('DataFile',
 ProgDir+'\Digalo\Digalo 2000 Russian\RUSSIAN\DATA\NICOLAI.dat');
    if not Registry.ValueExists('Dialect') then
        Registry.WriteString('Dialect', 'Standard');
    if not Registry.ValueExists('Feature') then
        Registry.WriteInteger('Feature', 479);
    if not Registry.ValueExists('Gender') then
        Registry.WriteInteger('Gender', 2);
    if not Registry.ValueExists('Language') then
        Registry.WriteInteger('Language', 1049);
    if not Registry.ValueExists('ModeName') then
        Registry.WriteString('ModeName', 'Digalo Russian Nicolai');
    if not Registry.ValueExists('RPBV') then
        Registry.WriteInteger('RPBV', 100);
    if not Registry.ValueExists('RSBV') then
        Registry.WriteInteger('RSBV', 114);
    if not Registry.ValueExists('SamplesPerSec') then
        Registry.WriteInteger('SamplesPerSec', 16000);
    if not Registry.ValueExists('Speaker') then
        Registry.WriteString('Speaker', 'Nicolai');
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Elan Text To Speech\Digalo\WAVEOUT',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Elan Text To Speech\Digalo\WPsolaPath',True);
    if not Registry.ValueExists('Russian') then
        Registry.WriteString('Russian',
 ProgDir+'\Digalo\Digalo 2000 Russian\RUSSIAN\digalo_rus.exe');
    Registry.CloseKey;

// Digalo
    Registry.OpenKey('SOFTWARE\Digalo',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Digalo\Digalo 2000 Russian',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Digalo\Digalo 2000 Russian\2000.01.000',True);
    Registry.CloseKey;

//Paranosoft

    Registry.OpenKey('SOFTWARE\Paranosoft',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Paranosoft\2',True);
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Paranosoft\2\license',True);
    if not Registry.ValueExists('InstallType_1049') then
        Registry.WriteInteger('InstallType_1049', 0);
    if not Registry.ValueExists('LND_1049') then
        Registry.WriteInteger('LND_1049', {808932563}809417198);
    if not Registry.ValueExists('RunData_09') then
        Registry.WriteBinaryData('RunData_09', RunData, SizeOf(RunData));
    Registry.CloseKey;

//Classes

    Registry.OpenKey('SOFTWARE\Classes\CLSID\{7EEA4F90-7FDB-11d3-998A-00105A40EA60}',True);
    Registry.WriteString('','Digalo');
    Registry.CloseKey;

    Registry.OpenKey('SOFTWARE\Classes\CLSID\{7EEA4F90-7FDB-11d3-998A-00105A40EA60}\InprocServer32',True);
    Registry.WriteString('',SysDir+'\digalo.dll');
    if not Registry.ValueExists('ThreadingModel') then
        Registry.WriteString('ThreadingModel','Apartment');
    Registry.CloseKey;

//________________________________

    Registry.RootKey:=HKEY_CLASSES_ROOT;

//Vcmshl

    Registry.OpenKey('CLSID\{B9BD3860-44DB-101B-90A8-00AA003E4B50}',True);
    Registry.WriteString('','ISRShare_PSFactory');
    Registry.CloseKey;

    Registry.OpenKey('CLSID\{B9BD3860-44DB-101B-90A8-00AA003E4B50}\InprocServer32',True);
    Registry.WriteString('',WinDir+'\Speech\vcmshl.dll');
    Registry.CloseKey;

//Speech

    Registry.OpenKey('CLSID\{D67C0280-C743-11cd-80E5-00AA003E4B50}',True);
    Registry.WriteString('','Text to Speech Enumerator');
    Registry.CloseKey;

    Registry.OpenKey('CLSID\{D67C0280-C743-11cd-80E5-00AA003E4B50}\InprocServer32',True);
    Registry.WriteString('',WinDir+'\Speech\speech.dll');
    if not Registry.ValueExists('ThreadingModel') then
        Registry.WriteString('ThreadingModel','Apartment');
    Registry.CloseKey;

    Registry.OpenKey('Interface\{05EB6C6D-DBAB-11CD-B3CA-00AA0047BA4F}',True);
    Registry.WriteString('','ITTSEnumA');
    Registry.CloseKey;
    Registry.OpenKey('Interface\{05EB6C6D-DBAB-11CD-B3CA-00AA0047BA4F}\ProxyStubClsid32',True);
    Registry.WriteString('','{B9BD3860-44DB-101B-90A8-00AA003E4B50}');
    Registry.CloseKey;

    Registry.OpenKey('Interface\{05EB6C6A-DBAB-11CD-B3CA-00AA0047BA4F}',True);
    Registry.WriteString('','ITTSCentralA');
    Registry.CloseKey;
    Registry.OpenKey('Interface\{05EB6C6A-DBAB-11CD-B3CA-00AA0047BA4F}\ProxyStubClsid32',True);
    Registry.WriteString('','{B9BD3860-44DB-101B-90A8-00AA003E4B50}');
    Registry.CloseKey;

    Registry.OpenKey('Interface\{0FD6E2A1-E77D-11CD-B3CA-00AA0047BA4F}',True);
    Registry.WriteString('','ITTSAttributesA');
    Registry.CloseKey;
    Registry.OpenKey('Interface\{0FD6E2A1-E77D-11CD-B3CA-00AA0047BA4F}\ProxyStubClsid32',True);
    Registry.WriteString('','{B9BD3860-44DB-101B-90A8-00AA003E4B50}');
    Registry.CloseKey;

(*
    Registry.OpenKey('CLSID\{7EEA4F90-7FDB-11d3-998A-00105A40EA60}',True);
    Registry.WriteString('','Digalo');
    Registry.CloseKey;

    Registry.OpenKey('CLSID\{7EEA4F90-7FDB-11d3-998A-00105A40EA60}\InprocServer32',True);
    Registry.WriteString('',SysDir+'\digalo.dll');
    if not Registry.ValueExists('ThreadingModel') then
        Registry.WriteString('ThreadingModel','Apartment');
    Registry.CloseKey;
*)
  finally
    Registry.Free;
  end;

end;

end.
