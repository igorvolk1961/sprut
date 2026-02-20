unit VerticalWayU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB,
  DMServer_TLB,
  SafeguardAnalyzerLib_TLB;

type

  TVerticalWay=class(TDMElement, IVerticalWay)
  private
    FX0:double;
    FY0:double;
    FX1:double;
    FY1:double;
    FSide:integer;
    FNodes0:IDMCollection;
    FNodes1:IDMCollection;
    FUsable:boolean;
  protected
    class function  GetClassID:integer; override;

    function  Get_X:double; safecall;
    function  Get_Y:double; safecall;
    function  Get_X0:double; safecall;
    procedure Set_X0(Value:double); safecall;
    function  Get_Y0:double; safecall;
    procedure Set_Y0(Value:double); safecall;
    function  Get_X1:double; safecall;
    procedure Set_X1(Value:double); safecall;
    function  Get_Y1:double; safecall;
    procedure Set_Y1(Value:double); safecall;
    function  Get_Nodes0:IDMCollection; safecall;
    function  Get_Nodes1:IDMCollection; safecall;
    function  Get_Usable:WordBool; safecall;
    procedure Set_Usable(Value:WordBool); safecall;
    function  Get_Side:integer; safecall;
    procedure Set_Side(Value:integer); safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TVerticalWays=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  SafeguardAnalyzerConstU;

{ TVerticalWay }

class function TVerticalWay.GetClassID: integer;
begin
  Result:=_VerticalWay;
end;

function TVerticalWay.Get_Nodes0: IDMCollection;
begin
  Result:=FNodes0
end;

function TVerticalWay.Get_Nodes1: IDMCollection;
begin
  Result:=FNodes1
end;

function TVerticalWay.Get_Side: integer;
begin
  Result:=FSide
end;

function TVerticalWay.Get_Usable: WordBool;
begin
  Result:=FUsable
end;

function TVerticalWay.Get_X: double;
begin
  Result:=0.5*(FX0+FX1)
end;

function TVerticalWay.Get_X0: double;
begin
  Result:=FX0
end;

function TVerticalWay.Get_X1: double;
begin
  Result:=FX1
end;

function TVerticalWay.Get_Y: double;
begin
  Result:=0.5*(FY0+FY1)
end;

function TVerticalWay.Get_Y0: double;
begin
  Result:=FY0
end;

function TVerticalWay.Get_Y1: double;
begin
  Result:=FY1
end;

procedure TVerticalWay.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FNodes0:=DataModel.CreateCollection(-1, SelfE);
  FNodes1:=DataModel.CreateCollection(-1, SelfE);
end;

procedure TVerticalWay.Set_Side(Value: integer);
begin
  FSide:=Value
end;

procedure TVerticalWay.Set_Usable(Value: WordBool);
begin
  FUsable:=Value
end;

procedure TVerticalWay.Set_X0(Value: double);
begin
  FX0:=Value
end;

procedure TVerticalWay.Set_X1(Value: double);
begin
  FX1:=Value
end;

procedure TVerticalWay.Set_Y0(Value: double);
begin
  FY0:=Value
end;

procedure TVerticalWay.Set_Y1(Value: double);
begin
  FY1:=Value
end;

procedure TVerticalWay._Destroy;
begin
  inherited;
  FNodes0:=nil;
  FNodes1:=nil;
end;

{ TVerticalWays }

class function TVerticalWays.GetElementClass: TDMElementClass;
begin
  Result:=TVerticalWay;
end;

function TVerticalWays.Get_ClassAlias(Index:integer): WideString;
begin
    Result:=rsVerticalWay
end;

class function TVerticalWays.GetElementGUID: TGUID;
begin
  Result:=IID_IVerticalWay;
end;

end.
