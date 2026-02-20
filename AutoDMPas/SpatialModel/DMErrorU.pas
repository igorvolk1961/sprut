unit DMErrorU;

interface
uses
  SysUtils,
  DMElementU, DataModel_TLB, FacilityModelLib_TLB, SpatialModelLib_TLB;

type
  TDMError=class(TDMElement, IDMError)
  private
    FLevel:integer;
  protected
    FCode:integer;
    function Get_Name:WideString; override; safecall;
    function Get_Code:integer; safecall;
    procedure Set_Code(Value:integer); safecall;
    function Get_Level:integer; safecall;
    function Get_Correctable:WordBool; virtual; safecall;
    procedure Set_Level(Value:integer); safecall;
    class function  GetClassID:integer; override;
    function  CompartibleWith(const aElement:IDMElement):WordBool; override; safecall;
  end;

  TDMErrors=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;
  
implementation

{ TDMError }

function TDMError.CompartibleWith(const aElement: IDMElement): WordBool;
var
  Unk:IUnknown;
begin
  Result:=(aElement.QueryInterface(IDMError, Unk)=0)
end;

class function TDMError.GetClassID: integer;
begin
  Result:=-1
end;

function TDMError.Get_Code: integer;
begin
  Result:=FCode
end;

function TDMError.Get_Correctable: WordBool;
var
  Element:IDMElement;
begin
    Element:=Ref;
    case Element.ClassID of
    _CoordNode:
      case FCode of
      0,1,2:Result:=True;
      else
        Result:=False;
      end;
    _Line:
      case FCode of
      0, 1, 4, 5, 6, 7,
      10001:Result:=True;
      else
        Result:=False;
      end;
    _Area:
      Result:=True;
    _Volume:
      case FCode of
      2..4:Result:=True;
      else
        Result:=False;
      end;
    else
        Result:=False;
    end;
end;

function TDMError.Get_Level: integer;
begin
  Result:=FLevel
end;

function TDMError.Get_Name: WideString;
var
  S:WideString;
  Code:integer;
begin
  S:=inherited Get_Name;
  Result:=S+Format(' #%d', [Ref.ID]);
  Code:=Get_Code;
  case Ref.ClassID of
  _Line:
    case Code of
    0: Result:=Result+'. L<1 см';
    1: Result:=Result+'. Принадлежит только 1-ой плоскости';
    2: Result:=Result+'. Более 2-х вертикальных плоскостей у невертикальной линии';
    3: Result:=Result+'. Более 2-х горизонтальных плоскостей у горизонтльной линии';
    4: Result:=Result+'. C0=nil или C1=nil';
    5: Result:=Result+'. Изолированная вертикальная линия';
    6: Result:=Result+'. Более 2-х вертикальных плоскостей у горизонтальной линии';
    7: Result:=Result+'. Перевернутая вертикальная линия';
    10000: Result:=Result+'. L<20 см';
    10001: Result:=Result+'. "лишняя" вертикальная линия';
    end;
  _CoordNode:
    case Code of
    0: Result:=Result+'. Изолированная';
    1: Result:=Result+'. Двойные линии';
    2: Result:=Result+'. Более 2-х вертикальных линий';
    end;
  _Area:
    case Code of
    0: Result:=Result+'. Ref=nil';
    1: Result:=Result+'. Вырожденый контур';
    2: Result:=Result+'. Не замкнутая';
    3: Result:=Result+'. Нет смежных зон';
    4: Result:=Result+'. H=0';
    5: Result:=Result+'. C0=nil или C1=nil или нет нижних линий';
    6: Result:=Result+'. Mенее 3 линий';
    end;
  _Volume:
    case Code of
    0: Result:=Result+'. Ref=nil';
    1: Result:=Result+'. H<1 м';
    2: Result:=Result+'. Нет нижних плоскостей';
    3: Result:=Result+'. Нет верхних плоскостей';
    4: Result:=Result+'. Объем вырожден';
    end;
  else
  end;
end;

procedure TDMError.Set_Code(Value: integer);
begin
  FCode:=Value
end;

procedure TDMError.Set_Level(Value: integer);
begin
  FLevel:=Value
end;

{ TDMErrors }

function TDMErrors.Get_ClassAlias(Index: integer): WideString;
begin
  Result:='Errors'
end;

class function TDMErrors.GetElementClass: TDMElementClass;
begin
  Result:=TDMError
end;

class function TDMErrors.GetElementGUID: TGUID;
begin
  Result:=IID_IDMError
end;

end.
