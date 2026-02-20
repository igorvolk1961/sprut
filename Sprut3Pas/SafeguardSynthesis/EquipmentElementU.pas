unit EquipmentElementU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB,
  SafeguardSynthesisLib_TLB;

type
  TEquipmentElement=class(TNamedDMElement, IEquipmentElement)
  private
    FSafeguardElement:IDMElement;
  protected
    class function  GetClassID:integer; override;

    function  Get_SafeguardElement:IDMElement; safecall;
    procedure Set_SafeguardElement(const Value:IDMElement); safecall;

    procedure MakePersistantState; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TEquipmentElements=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  SafeguardSynthesisConstU;

{ TEquipmentElement }

class function TEquipmentElement.GetClassID: integer;
begin
  Result:=_EquipmentElement;
end;

procedure TEquipmentElement._Destroy;
begin
  inherited;
end;

procedure TEquipmentElement.Initialize;
begin
  inherited;
end;

function TEquipmentElement.Get_SafeguardElement: IDMElement;
begin
  Result:=FSafeguardElement
end;

procedure TEquipmentElement.Set_SafeguardElement(const Value: IDMElement);
begin
  FSafeguardElement:=Value
end;

procedure TEquipmentElement.MakePersistantState;
begin

end;

{ TEquipmentElements }

class function TEquipmentElements.GetElementClass: TDMElementClass;
begin
  Result:=TEquipmentElement;
end;


function TEquipmentElements.Get_ClassAlias(Index: integer): WideString;
begin
    Result:=rsEquipmentElement
end;

class function TEquipmentElements.GetElementGUID: TGUID;
begin
  Result:=IID_IEquipmentElement;
end;

end.
