unit TextureU;
interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TTexture=class(TNamedDMElement, ITexture)
  private
    FNum:integer;
  protected
    class function  GetClassID:integer; override;
    function Get_Num:integer; safecall;
    procedure Set_Num(Value:integer); safecall;
    procedure Initialize; override;
  end;

  TTextures=class(TDMCollection)
  protected
    function  Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;

implementation

uses
  SafeguardDatabaseConstU;

{ TTexture }

class function TTexture.GetClassID: integer;
begin
  Result:=_Texture
end;

function TTexture.Get_Num: integer;
begin
  Result:=FNum
end;

procedure TTexture.Initialize;
begin
  inherited;
  FNum:=-1;
end;

procedure TTexture.Set_Num(Value: integer);
begin
  FNum:=Value
end;

{ TTextures }

function TTextures.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsTexture;
end;

class function TTextures.GetElementClass: TDMElementClass;
begin
  Result:=TTexture;
end;

class function TTextures.GetElementGUID: TGUID;
begin
  Result:=IID_ITexture;
end;


end.
