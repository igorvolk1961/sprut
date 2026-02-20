///// BIOSVersion & date Delphi component
///// send you questions & comments to
////  aziz@telebot.net

///NOTE VideoBIOSVersion currently works under WindowsNT only

unit BIOSDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, registry;

type
  TBIOSDate = class(TComponent)
  private
    { Private declarations }
    fBIOSVersion : String;
    fBIOSDate : String;
    fVideoBIOSVersion : string;
    fOS : string;
    procedure fSetAll;
    procedure fSetUnderWin9x;
    procedure fSetUnderWinNT;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create (AOwner : TComponent); override;
  published
    { Published declarations }
    /////обьявите не read-only - чтоб видны были в design time
    property BIOSVersion : string read fBIOSVersion {write fBIOSVersion};
    property BIOSDate : string read fBIOSDate {write fBIOSDate};
    property VideoBIOSVersion : string read fVideoBIOSVersion {write fVideoBIOSVersion};
    property OS : string read fOs {write fOS};
  end;

 const
 SubKey9x : String = '\Enum\Root\';
 SubkeyNT: string = 'HARDWARE\DESCRIPTION\System';


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TBIOSDate]);
end;

{ TBIOSDate }

constructor TBIOSDate.Create(AOwner: TComponent);
begin
Inherited;
fSetAll;
end;

procedure TBIOSDate.fSetAll;
var
WinVer : DWORD;
begin
WinVer:=GetVersion;
if (WinVer < $80000000) then
 fSetUnderWinNT
else
 fSetUnderWin9x;
end;

procedure TBIOSDate.fSetUnderWin9x;
 var
 R : TRegistry;
 S : TStringlist;
 I : Word;
 SubKey : String;
 L : String;
begin
fOS:='Windows 9x detected';
try
 R := TRegistry.Create;
try
 S := TStringList.Create;
 with R do
 begin
   RootKey:=HKEY_LOCAL_MACHINE;
   OpenKey(SubKey9x,False);
   if HasSubkeys then
   begin
   GetKeyNames(S);
   for i := 0 to S.Count-1 do
    begin
      SubKey:=SubKey9x+S.Strings[i]+'\0000';
      OpenKey(SubKey,false);
      L:=ReadString('BIOSVersion');
      if L<>'' then fBIOSVersion:=L;
      L:=ReadString('BIOSDate');
      if L<>'' then fBIOSDate:=L;
    end;
   end;
  end;
finally
S.Free;
end;
finally
R.Free;
end;
//

end;

procedure TBIOSDate.fSetUnderWinNT;
var
S: string;
R : TRegistry;
Buferok : array[0..1000] of char;
i,BufSize : Integer;
DataBiosa : TDATE;
begin

fOS:='Windows NT detected';
///
try
 R := TRegistry.Create;
R.RootKey:=HKEY_LOCAL_MACHINE;
R.OpenKeyReadOnly(SubKeyNT);
BufSize:=SizeOf(Buferok);
try
R.ReadBinaryData('SystemBiosVersion',Buferok,BufSize);
i:=0; s:='';
while Buferok[i]<> #0 do
begin
 s:=s+Buferok[i]; INC(i);
end;
fBIOSVersion:=s;

Except on ERegistryException do
 fBIOSVersion:='';
end;


try
//DataBiosa:=R.ReadDate('SystemBiosDate');
//fBIOSDate:=DateToStr(DataBiosa);
fBIOSDate:=R.ReadString('SystemBiosDate');
Except on ERegistryException do
 fBIOSDate:='';
end;

try
R.ReadBinaryData('VideoBiosVersion',Buferok,BufSize);
i:=0; s:='';
while Buferok[i]<> #0 do
begin
 s:=s+Buferok[i]; INC(i);
end;
fVideoBIOSVersion:=s;
Except on ERegistryException do
 fVideoBIOSVersion:='';
end;

r.CloseKey;

finally
r.Free;
end;

end;

end.
