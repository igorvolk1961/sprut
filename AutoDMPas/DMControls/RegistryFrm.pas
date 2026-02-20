unit RegistryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfmRegistry = class(TForm)
    lbOrganizationName: TLabel;
    edOrganizationName: TEdit;
    lbName: TLabel;
    edName: TEdit;
    btGenerate: TBitBtn;
    ed1: TEdit;
    ed2: TEdit;
    ed3: TEdit;
    ed4: TEdit;
    ed5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    sd1: TEdit;
    Label5: TLabel;
    sd2: TEdit;
    Label6: TLabel;
    sd3: TEdit;
    Label7: TLabel;
    sd4: TEdit;
    sd5: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    procedure btGenerateClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
    FRegistryKey: String;
    FOrganizationName: String;
    FSurName: String;
    FRegistrationKey: String;
    FAuthorizationKey: String;
    FCompare:Boolean;
    FApplicationKey: string;
    FIniFileName:string;
    procedure SetApplicationKey(const Value: string);
  public
    { Public declarations }
    constructor Create(Owner:TComponent; const aIniFileName:string);

    function CheckRegistry(aRegistryKey: string): boolean;

    property RegistryKey: String read FRegistryKey write FRegistryKey;
    property ApplicationKey:string read FApplicationKey write SetApplicationKey;
    property IniFileName:string read FIniFileName write FIniFileName;
  end;

var
  fmRegistry: TfmRegistry;
  Compare:Boolean;

implementation

uses
  IniFiles, CryptonsU, BIOSDate, ExpandCPUInfo;

{$R *.dfm}

{ TfmRegistry }

function TfmRegistry.CheckRegistry(aRegistryKey: string): boolean;
const
  Convert: array[0..15] of Char = '09A8B4C3D7E5F261';
var                                
  IniFile:TIniFile;
  i,j,sizeb, A0, A1:Integer;
  S:string;
  Letter: char;
  pch:PChar;
  arch:array of Char;
  OrganizationName, SurName, CheckValue, RegistryKey, AuthorizationKey,
  txt1, txt2, txt3, txt4, txt5:string;
  RegStr, AuthStr:String;
  bos:TBIOSDate;
  biosinfo:string;
  b: thash;
  CPU: TCPUInfo;
begin
  Result:=True;
  FRegistryKey:=aRegistryKey;
  //DecimalSeparator:='.';
  bos:=TBIOSDate.Create(self);
  try
  IniFile:=TIniFile.Create(FIniFileName);
  S:=IniFile.ReadString(FRegistryKey, 'Organization Name', '');

  if S='' then begin
    OrganizationName:='Organization';
    IniFile.WriteString(FRegistryKey, 'Organization Name', OrganizationName);
    edOrganizationName.Enabled:=true;
  end else
    OrganizationName:=S;
  edOrganizationName.Text := OrganizationName;

  S:=IniFile.ReadString(FRegistryKey, 'SurName', '');
  if S='' then begin
    SurName:='User';
    IniFile.WriteString(FRegistryKey, 'SurName', SurName);
    edName.Enabled:=true;
  end else
    SurName:=S;
  edName.Text := SurName;

  biosinfo:=bos.BIOSVersion+bos.BIOSDate;
  biosinfo:=Trim(biosinfo);
  if CPUIDInfo(CPU) then
    CheckValue:=FApplicationKey+
                OrganizationName+CPU.CPUName+biosinfo+IntToStr(CPU.Model)+IntToStr(CPU.Family)+SurName
  else
    CheckValue:=FApplicationKey+
                OrganizationName+biosinfo+SurName;
  if Length(CheckValue)<13 then
     CheckValue:=FApplicationKey+
                 OrganizationName+'Organ'+biosinfo+SurName+'User';

  s:=CheckValue;
  SetLength(b, Length(s));
  for i:=0 to Length(s)-1 do begin
    letter := s[i+1];
    b[i] := Ord(letter)
  end;

  encript(b);
  decript2(b);

  sizeb := Length(b);
  sizeb := Round(sizeb/13);
  sizeb := sizeb - 1;
  if sizeb<=0 then sizeb:=1;

  SetLength(arch, 2);
  j:=0;
  RegStr:='';
  for i:=0 to 12 do begin
    arch[0] := Convert[Byte(b[j]) shr 4];
    arch[1] := Convert[Byte(b[j]) and $F];
    RegStr:=RegStr+arch[0]+arch[1];
    j:=j+sizeb;
  end;
  RegStr:=copy(RegStr, 0, 25);

  S:=IniFile.ReadString(FRegistryKey, 'RegistryKey', '');
  if S='' then begin
    RegistryKey:='AAAAAAAAAAAAAAAAAAAAAAAAA';
    IniFile.WriteString(FRegistryKey, 'RegistryKey', RegistryKey);
  end else begin
    RegistryKey:=S;
  end;

  Compare:=false;
  FCompare:=true;
  if (Length(RegStr)<>Length(RegistryKey)) then begin
    edOrganizationName.Text:=OrganizationName;
    edName.Text:=SurName;
    Result:=False;
    Exit;
  end else begin
    for i:=1 to Length(RegStr) do begin
      txt1:=copy(RegStr, i, 1);
      txt2:=copy(RegistryKey, i, 1);
      if (Length(txt1)>0)and
         (Length(txt2)>0) then begin
        A0:=Ord(txt1[1]);
        A1:=Ord(txt2[1]);
        Compare:=(A0 = A1);
        if not Compare then begin
          break;
        end;
      end;
    end;
    if not (Compare and FCompare) then begin
        Result:=False;
        Exit;
      end;
    ed1.Text:=copy(RegStr, 1, 5);
    ed2.Text:=copy(RegStr, 6, 5);
    ed3.Text:=copy(RegStr, 11, 5);
    ed4.Text:=copy(RegStr, 16, 5);
    ed5.Text:=copy(RegStr, 21, 5);
  end;
  if not (Compare and FCompare) then begin
      Result:=False;
      Exit;
    end;

  s:=RegStr;
  SetLength(b, Length(s));
  for i:=0 to Length(s)-1 do begin
    letter := s[i+1];
    b[i] := Ord(letter)
  end;

  encript(b);
  decript2(b);

  sizeb := Length(b);
  sizeb := Round(sizeb/13);
  sizeb := sizeb - 1;
  if sizeb<=0 then sizeb:=1;

  SetLength(arch, 2);
  j:=0;
  AuthStr:='';
  for i:=0 to 12 do begin
    arch[0] := Convert[Byte(b[j]) shr 4];
    arch[1] := Convert[Byte(b[j]) and $F];
    AuthStr:=AuthStr+arch[0]+arch[1];
    j:=j+sizeb;
  end;
  AuthStr:=copy(AuthStr, 0, 25);

  S:=IniFile.ReadString(FRegistryKey, 'AuthorizationKey', '');
  if S='' then begin
    AuthorizationKey:='BBBBBBBBBBBBBBBBBBBBBBBBB';
    IniFile.WriteString(FRegistryKey, 'AuthorizationKey', AuthorizationKey);
  end else begin
    AuthorizationKey:=S;
  end;

  if (AuthStr<>AuthorizationKey) then begin
    edOrganizationName.Text:=OrganizationName;
    edName.Text:=SurName;
    //btGenerate.Enabled:=false;
    Result:=False;
    Exit;
  end;

  Compare:=false;
  FCompare:=true;
  if (Length(AuthStr)<>Length(AuthorizationKey)) then begin
    Result:=False;
    Exit;
  end else begin
    for i:=1 to Length(AuthStr) do begin
      txt1:=copy(AuthStr, i, 1);
      txt2:=copy(AuthorizationKey, i, 1);
      if (Length(txt1)>0)and
         (Length(txt2)>0) then begin
        A0:=Ord(txt1[1]);
        A1:=Ord(txt2[1]);
        Compare:=(A0 = A1);
        if not Compare then begin
          break;
        end;
      end;
    end;
    if not (Compare and FCompare) then begin
        Result:=False;
        Exit;
      end;
  end;
  if not (Compare and FCompare) then begin
      Result:=False;
      Exit;
    end;

  IniFile.UpdateFile;

  finally
    IniFile.Free;
  end;
end;

procedure TfmRegistry.btGenerateClick(Sender: TObject);
const
  Convert: array[0..15] of Char = '09A8B4C3D7E5F261';
var
  s, e, reg: String;
  letter: char;
  bos:TBIOSDate;
  biosinfo:string;
  arch:array of Char;
  b: thash;//array[1..23] of byte;
  i,j, sizeb: integer;
  IniFile:TIniFile;
  CPU: TCPUInfo;
begin
  //edOrganizationName.Enabled:=False;
  //edName.Enabled:=False;
  FOrganizationName:=edOrganizationName.Text;
  FSurName:=edName.Text;

  if FOrganizationName='' then begin
    ShowMessage('Поле с наименованием организации не может быть пустым!');
    Exit;
  end;
  if FSurName='' then begin
    ShowMessage('Поле с фамилией пользователя не может быть пустым!');
    Exit;
  end;

  IniFile:=TIniFile.Create(FIniFileName);

  try
  IniFile.WriteString(FRegistryKey,'Organization Name', FOrganizationName);
  IniFile.WriteString(FRegistryKey,'SurName', FSurName);

  try
    bos:=TBIOSDate.Create(self);
  except
    raise;
  end;
  biosinfo:=bos.BIOSVersion+bos.BIOSDate;
  biosinfo:=Trim(biosinfo);
  if CPUIDInfo(CPU) then
    s:=FApplicationKey+
       FOrganizationName+CPU.CPUName+biosinfo+
       IntToStr(CPU.Model)+IntToStr(CPU.Family)+FSurName
  else
    s:=FApplicationKey+
       FOrganizationName+biosinfo+FSurName;
  if Length(s)<13 then
    s:=FApplicationKey+
       FOrganizationName+'Organ'+biosinfo+FSurName+'User';

  SetLength(b, Length(s));
  for i:=0 to Length(s)-1 do begin
    letter := s[i+1];
    b[i] := Ord(letter)
  end;
  encript(b);
  decript2(b);
  //b:=RC6SelfTest;
  sizeb := Length(b);
  sizeb := Round(sizeb/13);
  sizeb := sizeb - 1;
  if sizeb<=0 then sizeb:=1;

  SetLength(arch, 2);
  j:=0;
  reg:='';
  for i:=0 to 12 do begin
    arch[0] := Convert[Byte(b[j]) shr 4];
    arch[1] := Convert[Byte(b[j]) and $F];
    reg:=reg+arch[0]+arch[1];
    j:=j+sizeb;
  end;
  ed1.Text:=copy(reg, 1, 5);
  ed2.Text:=copy(reg, 6, 5);
  ed3.Text:=copy(reg, 11, 5);
  ed4.Text:=copy(reg, 16, 5);
  ed5.Text:=copy(reg, 21, 5);

  IniFile.WriteString(FRegistryKey, 'RegistryKey', ed1.Text+ed2.Text+ed3.Text+ed4.Text+ed5.Text);

  finally

    IniFile.UpdateFile;
    IniFile.Free;
  end;

end;

procedure TfmRegistry.btOkClick(Sender: TObject);
const
  Convert: array[0..15] of Char = '09A8B4C3D7E5F261';
var
  s, org, name, auth0, auth1, text1, text2: String;
  letter: char;
  arch:array of Char;
  b: thash;
  i,j, sizeb, A0,A1: integer;
  IniFile:TIniFile;
begin

  IniFile:=TIniFile.Create(FIniFileName);

  try

  s:='';
  s:=s+ed1.Text;
  s:=s+ed2.Text;
  s:=s+ed3.Text;
  s:=s+ed4.Text;
  s:=s+ed5.Text;

  SetLength(b, Length(s));
  for i:=0 to Length(s)-1 do begin
    letter := s[i+1];
    b[i] := Ord(letter)
  end;

  encript(b);
  decript2(b);

  sizeb := Length(b);
  sizeb := Round(sizeb/13);
  sizeb := sizeb - 1;
  if sizeb<=0 then sizeb:=1;

  SetLength(arch, 2);
  j:=0;
  auth0:='';
  auth1:='';
  for i:=0 to 12 do begin
    arch[0] := Convert[Byte(b[j]) shr 4];
    arch[1] := Convert[Byte(b[j]) and $F];
    auth0:=auth0+arch[0]+arch[1];
    j:=j+sizeb;
  end;
  auth0:=copy(auth0, 0, 25);
  auth1:=auth1+Uppercase(sd1.Text);
  auth1:=auth1+Uppercase(sd2.Text);
  auth1:=auth1+Uppercase(sd3.Text);
  auth1:=auth1+Uppercase(sd4.Text);
  auth1:=auth1+Uppercase(sd5.Text);

  Compare:=false;
  FCompare:=true;
  if (Length(auth0)<>Length(auth1)) then begin
    ShowMessage('Проверьте правильность ввода авторизационного ключа!');
    Exit;
  end else begin
    for i:=1 to Length(auth0) do begin
      text1:=copy(auth0, i, 1);
      text2:=copy(auth1, i, 1);
      if (Length(text1)>0)and
         (Length(text2)>0) then begin
        A0:=Ord(text1[1]);
        A1:=Ord(text2[1]);
        Compare:=(A0 = A1);
        if not Compare then begin
          break;
        end;
      end;
    end;
    if not (Compare and FCompare) then begin
      ShowMessage('Проверьте правильность ввода авторизационного ключа!');
      Exit;
    end else begin
      IniFile.WriteString(FRegistryKey,'AuthorizationKey', auth0);
      self.ModalResult:=mrOk;
      Exit;
    end;
  end;
  if not (Compare and FCompare) then begin
    ShowMessage('Проверьте правильность ввода авторизационного ключа!');
    Exit;
  end;

  finally
    IniFile.UpdateFile;
    IniFile.Free;
  end;
end;

procedure TfmRegistry.SetApplicationKey(const Value: string);
begin
  FApplicationKey := Value;
end;

constructor TfmRegistry.Create(Owner: TComponent;
  const aIniFileName: string);
begin
  inherited Create(Owner);
  FIniFileName:=aIniFileName;
end;

end.
