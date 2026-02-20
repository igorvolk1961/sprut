unit CabelU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  SafeguardElementU;

type
  TCabel=class(TSafeguardElement, ICabel)
  private
    FName:String;
    FConnections:IDMCollection;
    FControlDevices:IDMCollection;
  protected
    function  Get_Name:WideString; override; safecall;
    procedure Set_Name(const Value:WideString); override; safecall;
    procedure _AddBackRef(const aElement:IDMElement); override;
    procedure _RemoveBackRef(const aElement:IDMElement); override;

    function Get_Connections:IDMCollection; safecall;
    function Get_ControlDevices:IDMCollection; safecall;
    function IndexOf(const ConnectionParent:IDMElement):integer; safecall;
    function CuttedBetween(Index0, Index1:integer):WordBool; safecall;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    procedure Initialize; override;
    procedure _Destroy; override;
    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;

    class function  StoredName: WordBool; override;
  public
    class function  GetClassID:integer; override;
  end;

  TCabels=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

{ TCabel }

class function TCabel.GetClassID: integer;
begin
  Result:=_Cabel;
end;

function TCabel.Get_Collection(Index: Integer): IDMCollection;
begin
   case Index of
   0:Result:=FConnections;
   1:Result:=FControlDevices;
   end;

end;

function TCabel.Get_CollectionCount: integer;
begin
  Result:=2
end;

procedure TCabel.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
   case Index of
   0:aCollectionName:=rsConnections;
   1:aCollectionName:=rsControlDevices;
   end;
   aRefSource:=nil;
   aClassCollections:=nil;
   aOperations:=0;
   aLinkType:=ltManyToMany;
end;

procedure TCabel.Initialize;
var
  SelfE:IDMElement;
begin
  inherited;
  SelfE:=Self as IDMElement;
  FConnections:=DataModel.CreateCollection(-1, SelfE);
  FControlDevices:=DataModel.CreateCollection(-1, SelfE);
end;

procedure TCabel._AddBackRef(const aElement: IDMElement);
var
  j:integer;
begin
  if aElement.ClassID=_Polyline then
    Set_SpatialElement(aElement)
  else
  if aElement.ClassID=_Connection then begin
    j:=FConnections.IndexOf(aElement);
    if j=-1 then
      (FConnections as IDMCollection2).Add(aElement);
  end;
end;

procedure TCabel._Destroy;
begin
  inherited;
  FConnections:=nil;
  FControlDevices:=nil;
end;

procedure TCabel._RemoveBackRef(const aElement: IDMElement);
var
  j:integer;
begin
  if aElement.ClassID=_Connection then begin
    j:=FConnections.IndexOf(aElement);
    if j<>-1 then
      (FConnections as IDMCollection2).Delete(j);
  end;
end;

procedure TCabel.Draw(const aPainter: IInterface; DrawSelected: integer);
var
  j:integer;
  ConnectionE:IDMElement;
begin
  inherited;
  for j:=0 to FConnections.Count-1 do begin
    ConnectionE:=FConnections.Item[j];
    ConnectionE.Draw(aPainter, DrawSelected);
  end;
end;

function TCabel.Get_ControlDevices: IDMCollection;
begin
  Result:=FControlDevices
end;

function TCabel.Get_Connections: IDMCollection;
begin
  Result:=FConnections
end;

function TCabel.CuttedBetween(Index0, Index1: integer): WordBool;
begin
  Result:=False;
end;

function TCabel.IndexOf(const ConnectionParent: IDMElement): integer;
var
  j:integer;
  ConnectionE:IDMElement;
begin
  Result:=-1;
  if ConnectionParent=nil then Exit;

  j:=0;
  while j<FConnections.Count do begin
    ConnectionE:=FConnections.Item[j];
    if ConnectionE.Parent=ConnectionParent then
      Break
    else
      inc(j)
  end;
  if j<FConnections.Count then
    Result:=j
end;

function TCabel.Get_Name: WideString;
begin
  Result:=FName
end;

procedure TCabel.Set_Name(const Value: WideString);
begin
  FName:=Value
end;

class function TCabel.StoredName: WordBool;
begin
  Result:=True
end;

{ TCabels }

class function TCabels.GetElementClass: TDMElementClass;
begin
  Result:=TCabel;
end;

function TCabels.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsCabel;
end;

class function TCabels.GetElementGUID: TGUID;
begin
  Result:=IID_ICabel;
end;

end.
