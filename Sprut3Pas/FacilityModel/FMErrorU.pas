unit FMErrorU;

interface
uses
  DMElementU, DataModel_TLB, FacilityModelLib_TLB, SpatialModelLib_TLB,
  DMErrorU;

type
  TFMError=class(TDMError)
  protected
    class function  GetClassID:integer; override;
    function Get_Correctable:WordBool; override; safecall;

    function Get_Name:WideString; override; safecall;
  end;

  TFMErrors=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;
  
implementation


{ TFMError }

class function TFMError.GetClassID: integer;
begin
  Result:=-1
end;

function TFMError.Get_Correctable: WordBool;
var
  Code:integer;
begin
  Result:=inherited Get_Correctable;
  Code:=Get_Code;
  case Ref.ClassID of
  _Area:
    case Code of
    7: Result:=True;
    end;
  _Jump:
    case Code of
    0: Result:=False;
    end;
  end;
end;

function TFMError.Get_Name: WideString;
var
  S:WideString;
  Code:integer;
begin
  S:=inherited Get_Name;
  Result:=S;   // +Format(' #%d', [Ref.ID]);
  Code:=Get_Code;
  case Ref.ClassID of
  _Area:
    case Code of
    7: Result:=Result+'. Граничит с не смежной областью';
    end;
  _Jump:
    case Code of
    0: Result:=Result+'. Не определена зона';
    end;
  end;
end;

{ TFMErrors }

function TFMErrors.Get_ClassAlias(Index: integer): WideString;
begin
  Result:='Errors'
end;

class function TFMErrors.GetElementClass: TDMElementClass;
begin
  Result:=TFMError
end;

class function TFMErrors.GetElementGUID: TGUID;
begin
  Result:=IID_IDMError
end;

end.
