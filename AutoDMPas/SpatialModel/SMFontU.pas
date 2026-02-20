unit SMFontU;

interface
uses
 Classes, Graphics,
 DMElementU, DataModel_TLB, SpatialModelLib_TLB;

type
  TSMFont=class(TNamedDMElement, ISMFont)
  private
    FSize: Integer;
    FColor: Integer;
    FStyle: Integer;

    function  Get_Size: Integer; safecall;
    procedure Set_Size(Value: Integer); safecall;
    function  Get_Color: Integer; safecall;
    procedure Set_Color(Value: Integer); safecall;
    function  Get_Style: Integer; safecall;
    procedure Set_Style(Value: Integer); safecall;
  protected
    procedure Initialize; override;
    procedure _Destroy; override;

    function  GetFieldValue(Code: integer): OleVariant; override;  safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;

    class function  GetClassID:integer; override;
    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

  end;


  TSMFonts=class(TDMCollection)
  protected
    function Get_ClassAlias(Index:integer): WideString; override; safecall;
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
  end;


implementation
uses
  SpatialModelConstU;

var
  FFields:IDMCollection;

{ TSMFont }

procedure TSMFont.Initialize;
begin
  inherited;
  FSize:=8;
  FColor:=clBlack;
  FStyle:=0;
end;

procedure TSMFont._Destroy;
begin
  inherited;
end;

function TSMFont.Get_Color: integer;
begin
  Result:=FColor
end;

procedure TSMFont.Set_Color(Value: integer);
begin
  FColor:=Value
end;

class function TSMFont.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TSMFont.MakeFields0;
begin
  inherited;
  AddField(rsFontSize, '%2d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(fntSize), 0, pkInput);
  AddField(rsFontColor, '%8x', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(fntColor), 0, pkInput);
  AddField(rsFontStyle, '%2d', '', '',
                 fvtInteger, 0, 0, 0,
                 ord(fntStyle), 0, pkInput);
end;

function TSMFont.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(fntSize):
    Result:=FSize;
  ord(fntColor):
    Result:=FColor;
  ord(fntStyle):
    Result:=FStyle;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TSMFont.SetFieldValue(Code: integer;
  Value: OleVariant);
begin
  case Code of
  ord(fntSize):
    FSize:=Value;
  ord(fntColor):
    FColor:=Value;
  ord(fntStyle):
    FStyle:=Value;
  else
    inherited;
  end;
end;

class function TSMFont.GetClassID: integer;
begin
  Result:=_SMFont
end;

function TSMFont.Get_Style: integer;
begin
  Result:=FStyle
end;

procedure TSMFont.Set_Style(Value: integer);
begin
  FStyle:=Value
end;

function TSMFont.Get_Size: Integer;
begin
  Result:=FSize
end;

procedure TSMFont.Set_Size(Value: Integer);
begin
  FSize:=Value
end;

{ TSMFonts }

class function TSMFonts.GetElementClass: TDMElementClass;
begin
  Result:=TSMFont;
end;

function TSMFonts.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsFont;
end;

class function TSMFonts.GetElementGUID: TGUID;
begin
  Result:=IID_ISMFont;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TSMFont.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
