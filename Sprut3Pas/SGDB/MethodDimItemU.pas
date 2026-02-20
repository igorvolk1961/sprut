unit MethodDimItemU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TMethodDimItem=class(TDMArrayDimItem, IMethodDimItem)
  protected
    class function  GetClassID:integer; override;
  end;

  TMethodDimItems=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;
  
implementation
uses
  SafeguardDatabaseConstU;


{ TMethodDimItem }

class function TMethodDimItem.GetClassID: integer;
begin
  Result:=_sgMethodDimItem
end;

{ TMethodDimItems }

function TMethodDimItems.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsMethodDimItem
end;

class function TMethodDimItems.GetElementClass: TDMElementClass;
begin
  Result:=TMethodDimItem
end;

class function TMethodDimItems.GetElementGUID: TGUID;
begin
  Result:=IID_IMethodDimItem
end;

end.
