unit DMMenu;

interface
uses
  Classes, Contnrs;

type
  TDMMenuItem=class(TComponent)
  private
    FHandle:integer;
    FCommand:integer;
    FPos:integer;
    FPX:integer;
    FPY:integer;
    FLeft:integer;
    FBottom:integer;
    FMenuItems:TList;
  public
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
    procedure AddMenuItem(aHandle, aCommand, Pos, PX, PY, Left, Bottom:integer);
    function  FindByHandle(aHandle:integer):TDMMenuItem;
    function  FindByCommand(aCommand:integer):TDMMenuItem;
    property Handle:integer read FHandle write FHandle;
    property Command:integer read FCommand write FCommand;
    property Pos:integer read FPos write FPos;
    property PX:integer read FPX write FPX;
    property PY:integer read FPY write FPY;
    property Left:integer read FLeft write FLeft;
    property Bottom:integer read FBottom write FBottom;
    property MenuItems:TList read FMenuItems;
  end;

implementation

{ TDMMenuItem }

procedure TDMMenuItem.AddMenuItem(aHandle, aCommand,
                                  Pos, PX, PY, Left, Bottom: integer);
var
  aDMMenuItem:TDMMenuItem;
begin
  aDMMenuItem:=TDMMenuItem.Create(Self);
  FMenuItems.Add(aDMMenuItem);
  aDMMenuItem.FHandle:=aHandle;
  aDMMenuItem.FCommand:=aCommand;
  aDMMenuItem.Pos:=Pos;
  aDMMenuItem.PX:=PX;
  aDMMenuItem.PY:=PY;
  aDMMenuItem.Left:=Left;
  aDMMenuItem.Bottom:=Bottom;
end;

constructor TDMMenuItem.Create(aOwner: TComponent);
begin
  inherited;
  FMenuItems:=TComponentList.Create;
end;

destructor TDMMenuItem.Destroy;
begin
  FMenuItems.Free;
  inherited;
end;

function TDMMenuItem.FindByHandle(aHandle: integer): TDMMenuItem;
var
  m:integer;
  aDMMenuItem:TDMMenuItem;
begin
  Result:=nil;
  m:=0;
  while (Result=nil) and
        (m<FMenuItems.Count) do begin
    aDMMenuItem:=TDMMenuItem(FMenuItems[m]);
    if aDMMenuItem.Handle=aHandle then
      Result:=aDMMenuItem
    else
      Result:=aDMMenuItem.FindByHandle(aHandle);
    inc(m);
  end;
end;

function TDMMenuItem.FindByCommand(aCommand: integer): TDMMenuItem;
var
  m:integer;
  aDMMenuItem:TDMMenuItem;
begin
  Result:=nil;
  m:=0;
  while (Result=nil) and
        (m<FMenuItems.Count) do begin
    aDMMenuItem:=TDMMenuItem(FMenuItems[m]);
    if aDMMenuItem.Command=aCommand then
      Result:=aDMMenuItem
    else
      Result:=aDMMenuItem.FindByCommand(aCommand);
    inc(m);
  end;
end;

end.
