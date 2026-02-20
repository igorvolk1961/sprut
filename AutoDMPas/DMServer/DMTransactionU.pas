unit DMTransactionU;

interface
uses
  Classes,
  DMOperationU, DataModel_TLB, DMServer_TLB;

type

  TDMTransaction=class(TObject)
  private
    FOperations:TList;
    FSourceList:TList;
    FCopyList:TList;
    FCollection:IDMCollection;
    FOperation:integer;
    FName:string;
    function GetLastElement: IDMElement;
    function  GetName:string;
  public
    constructor Create(aCollection:IDMCollection; Operation:integer;
      aName:string); virtual;
    destructor Destroy; override;

    procedure Commit(DMDocument:IDMDocument);
    procedure RollBack(DMDocument:IDMDocument);
    procedure AddOperation(Operation:TDMOperation);
    procedure Clear;
    procedure AddCopyOf(const aSource, aCopy:IDMElement);
    function  GetCopyOf(const aSource:IDMElement):IDMElement;

    property Operations:TList read FOperations;
    property LastElement:IDMElement read GetLastElement;
    property Collection:IDMCollection
      read FCollection;
    property Operation:integer read FOperation;
    property Name:string read GetName;
  end;

implementation

{ TDMTransaction }

constructor TDMTransaction.Create(aCollection:IDMCollection; Operation:integer;
                                  aName:string);
begin
  FOperations:=TList.Create;
  FSourceList:=TList.Create;
  FCopyList:=TList.Create;
  FCollection:=aCollection;
  FOperation:=Operation;
  FName:=aName;
end;

destructor TDMTransaction.Destroy;
var
  j:integer;
  aElement:IDMElement;
begin
  inherited;
  for j:=FOperations.Count-1 downto 0 do
    TDMOperation(FOperations[j]).Free;
  FOperations.Free;
  for j:=0 to FSourceList.Count-1 do begin
    aElement:=IDMElement(FSourceList[j]);
    aElement._Release;
    aElement:=IDMElement(FCopyList[j]);
    aElement._Release;
  end;

  FSourceList.Free;
  FCopyList.Free;

  FCollection:=nil;
end;

procedure TDMTransaction.AddOperation(Operation: TDMOperation);
begin
  FOperations.Add(Operation)
end;

procedure TDMTransaction.Commit(DMDocument:IDMDocument);
var
  j:integer;
begin
  for j:=0 to FOperations.Count-1 do
    TDMOperation(FOperations[j]).Commit(DMDocument)
end;

procedure TDMTransaction.RollBack(DMDocument:IDMDocument);
var
  j:integer;
  UpdateList, UpdateCoordsList:TList;
  aOperation:TDMOperation;

  procedure AddUpdateOperation(const aList:TList);
//  var
//     Operation:TDMOperation
  begin
{
    m:=0;
    while m<aList.Count do begin
      Operation:=TDMOperation(aList[j]);
      if Operation.Element<>aOperation.Element then
        inc(m)
      else
        Break;
    end;
    if m=aList.Count then
}
      aList.Add(aOperation)
  end;

begin
  UpdateList:=TList.Create;
  UpdateCoordsList:=TList.Create;
  for j:=FOperations.Count-1 downto 0 do begin
    aOperation:=TDMOperation(FOperations[j]);
    if aOperation is TUpdateElementOperation then
      AddUpdateOperation(UpdateList)
    else
    if aOperation is TUpdateCoordsOperation then
      AddUpdateOperation(UpdateCoordsList)
    else
      aOperation.RollBack(DMDocument)
  end;
  for j:=0 to UpdateList.Count-1 do
    TDMOperation(UpdateList[j]).RollBack(DMDocument);
  for j:=0 to UpdateCoordsList.Count-1 do
    TDMOperation(UpdateCoordsList[j]).RollBack(DMDocument);
  UpdateList.Free;
  UpdateCoordsList.Free;
end;

function TDMTransaction.GetLastElement: IDMElement;
begin
  if FOperations.Count=0 then
    Result:=nil
  else
    Result:=TDMOperation(FOperations[FOperations.Count-1]).Element
end;

procedure TDMTransaction.Clear;
var
  j:integer;
begin
  for j:=FOperations.Count-1 downto 0 do
    TDMOperation(FOperations[j]).Clear;
end;

procedure TDMTransaction.AddCopyOf(const aSource, aCopy: IDMElement);
var
  p:pointer;
begin
  p:=pointer(aSource);
  FSourceList.Add(p);
  aSource._AddRef;

  p:=pointer(aCopy);
  FCopyList.Add(p);
  aCopy._AddRef;
end;

function TDMTransaction.GetCopyOf(const aSource: IDMElement): IDMElement;
var
  p:pointer;
  j:integer;
begin
  p:=pointer(aSource);
  j:=FSourceList.IndexOf(p);
  if j<>-1  then
    Result:=IDMElement(FCopyList[j])
  else
    Result:=nil
end;

function TDMTransaction.GetName: string;
begin
  Result:=FName;
end;

end.
