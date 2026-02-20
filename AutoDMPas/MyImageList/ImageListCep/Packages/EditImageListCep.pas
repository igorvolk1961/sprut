unit EditImageListCep;
//© 2006 Сергей Рощин (Специально для королевства Дэльфи)
//В этом модуре регистрируется редактор компонента TImageListCep
//Данный модyль не предназначен для коммерческого использования.
//По поводу возможного сотрудничества Вы можете обратиться по
//элестронной почте roschinspb@mail.ru
//http://www.delphikingdom.com/asp/users.asp?ID=1271
//http://www.roschinspb.boom.ru

interface
uses SysUtils,
     {$IFDEF VER130}
     DsgnIntf,
     {$ELSE}
     DesignIntf,DesignEditors,VCLEditors,
     {$ENDIF}
     FormImageListCep,ImageListCep;
resourcestring
  Verb0 = 'Редактировать';
type
  TImageListCepEditor = class (TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer;  override;
  end;

procedure Register;

implementation

procedure Register;
begin
    RegisterComponentEditor(TImageListCep, TImageListCepEditor);
end;

{ TImageListCepEditor }

procedure TImageListCepEditor.ExecuteVerb(Index: Integer);
var F:TFormDlgSIL;
    DT:boolean;
begin
  inherited;
  if Component is TImageListCep then
  begin
    F:=TFormDlgSIL.Create(nil);
    try
      DT := ImageListCep.DesignTime;
      ImageListCep.DesignTime := True;
      try
        F.ImageListCep := TImageListCep(Component);
        F.ShowModal;
      finally
        ImageListCep.DesignTime := DT;
      end;
    finally
      FreeAndNil(F);
    end;
  end;
end;

function TImageListCepEditor.GetVerb(Index: Integer): string;
begin
  if index=0 then
    result := Verb0
  else
    result := inttostr(Index);
end;

function TImageListCepEditor.GetVerbCount: Integer;
begin
  result := 1;
end;

end.
