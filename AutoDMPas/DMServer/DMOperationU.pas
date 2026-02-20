unit DMOperationU;

interface
uses
  Classes, DataModel_TLB, DMServer_TLB,
  SysUtils, Variants;

type
  TDMOperation=class(TObject)
  private
    FElement:IDMElement;
  public
    constructor Create0(aElement:IDMElement); virtual;
    destructor  Destroy; override;
    procedure Clear; virtual;
    procedure Commit(DMDocument:IDMDocument); virtual;
    procedure RollBack(DMDocument:IDMDocument); virtual;
    function GetCode:integer; virtual;
    procedure WriteToString (var S:string; const DMDocument:IDMDocument); virtual;
    procedure ReadFromString(var S:string; const DMDocument:IDMDocument); virtual;

    property Element:IDMElement read FElement;

  end;

  TRenameElementOperation=class(TDMOperation)
  private
    FNewName:string;
    FOldName:string;
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
    procedure WriteToString (var S:string; const DMDocument:IDMDocument); override;
    procedure ReadFromString(var S:string; const DMDocument:IDMDocument); override;

    constructor Create(aElement:IDMElement; NewName:string); virtual;
  end;

  TChangeFieldValueOperation=class(TDMOperation)
  private
    FFieldCode:integer;
    FNewValue:OleVariant;
    FOldValue:OleVariant;
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
    procedure WriteToString (var S:string; const DMDocument:IDMDocument); override;
    procedure ReadFromString(var S:string; const DMDocument:IDMDocument); override;

    constructor Create(aElement:IDMElement; FieldCode:integer; NewValue:OleVariant); virtual;
  end;

  TCreateElementOperation=class(TDMOperation)
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
    procedure WriteToString (var S:string; const DMDocument:IDMDocument); override;
    procedure ReadFromString(var S:string; const DMDocument:IDMDocument); override;

    destructor  Destroy; override;
    procedure Clear; override;
  end;

  TUpdateElementOperation=class(TDMOperation)
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
  end;

  TUpdateCoordsOperation=class(TDMOperation)
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
  end;

  TDestroyElementOperation=class(TDMOperation)
  private
    FOldParent:IDMElement;
    FOldRef:IDMElement;
    FOldIndex:integer;
  public
    constructor Create(aElement:IDMElement);
    destructor  Destroy; override;
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
    procedure WriteToString (var S:string; const DMDocument:IDMDocument); override;
    procedure ReadFromString(var S:string; const DMDocument:IDMDocument); override;
  end;

  TRelationOperation=class(TDMOperation)
  private
    FNewValue:IDMElement;
  public
    constructor Create(aElement, aElement1:IDMElement); virtual;
    destructor  Destroy; override;
    procedure WriteToString (var S:string; const DMDocument:IDMDocument); override;
    procedure ReadFromString(var S:string; const DMDocument:IDMDocument); override;
  end;

  TManyToManyRelationOperation=class(TRelationOperation)
  end;

  TAddParentOperation=class(TManyToManyRelationOperation)
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
  end;

  TRemoveParentOperation=class(TManyToManyRelationOperation)
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
  end;

  TOneToManyRelationOperation=class(TRelationOperation)
  private
    FOldValue:IDMElement;
  public
    constructor Create(aElement, aElement1:IDMElement); override;
    destructor  Destroy; override;
    procedure WriteToString (var S:string; const DMDocument:IDMDocument); override;
    procedure ReadFromString(var S:string; const DMDocument:IDMDocument); override;
  end;

  TSetParentOperation=class(TOneToManyRelationOperation)
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
  end;

  TSetRefOperation=class(TOneToManyRelationOperation)
  public
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
  end;


  TMoveElementOperation=class(TDMOperation)
  private
    FOldIndex:integer;
    FNewIndex:integer;
    FOldOwnerCollectionIndex:integer;
    FNewOwnerCollectionIndex:integer;
    FCollection:IDMCollection;
    FMoveInOwnerCollection:boolean;
  public
    constructor Create(const aElement:IDMElement;
        const Collection:IDMCollection; NewIndex:integer;
        MoveInOwnerCollection:WordBool);
    destructor  Destroy; override;
    procedure Commit(DMDocument:IDMDocument); override;
    procedure RollBack(DMDocument:IDMDocument); override;
    function GetCode:integer; override;
    procedure WriteToString (var S:string; const DMDocument:IDMDocument); override;
    procedure ReadFromString(var S:string; const DMDocument:IDMDocument); override;
  end;

implementation

{ TDMOperation }
uses
  DMUtils;

var
  LocalDecimalSeparator:Char;
  XXX:integer;

procedure TDMOperation.Clear;
begin
end;

procedure TDMOperation.Commit(DMDocument:IDMDocument);
begin
  DMDocument.IncChangeCount;
end;

constructor TDMOperation.Create0(aElement: IDMElement);
begin
  FElement:=aElement;
end;

destructor TDMOperation.Destroy;
begin
  inherited;
  FElement:=nil;
end;

function TDMOperation.GetCode: integer;
begin
  Result:=-1;
end;

procedure TDMOperation.RollBack(DMDocument:IDMDocument);
begin
  DMDocument.DecChangeCount;
end;

procedure TDMOperation.WriteToString(var S:string; const DMDocument:IDMDocument);
var
  ModelID, ClassID, ID:integer;
begin
  if FElement=nil then
    S:=S+' -1 -1 -1'
  else begin
    if FElement.DataModel=DMDocument.DataModel then
      ModelID:=-1
    else
      ModelID:=(FElement.DataModel as IDMElement).ID;
    ClassID:=FElement.ClassID;
    ID:=FElement.ID;
    S:=S+Format(' %d %d %d',[ModelID, ClassID, ID])
  end;
end;

procedure TDMOperation.ReadFromString(var S: string; const DMDocument:IDMDocument);
var
  ModelID, ClassID, ID:integer;
  aDataModel:IDMElement;
  aCollection2:IDMCollection2;
  Value:double;
begin
  FElement:=nil;
  if not ExtractValueFromString(S, Value) then Exit;
  ModelID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ClassID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ID:=round(Value);
  aDataModel:=DMDocument.DataModel as IDMElement;
  if ModelID=-1 then
    aDataModel:=DMDocument.DataModel as IDMElement
  else
    aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

  if ID<>-1 then begin
    aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
    if aCollection2<>nil then
      FElement:=aCollection2.GetItemByID(ID);
  end else
    FElement:=(DMDocument.DataModel as IDataModel).GetDefaultElement(ClassID);
end;

{ TCreateElementOperation }

procedure TCreateElementOperation.Clear;
begin
  FElement.Clear
end;

procedure TCreateElementOperation.Commit(DMDocument: IDMDocument);
var
  ClassID:integer;
  Collection:IDMCollection2;
  aDataModel:IDataModel;
begin
  ClassID:=FElement.ClassID;
  Collection:=(DMDocument.DataModel as IDMElement).Collection[ClassID] as IDMCollection2;
  Collection.Add(FElement);
  FElement.Exists:=True;
  Collection:=nil;

  aDataModel:=FElement.DataModel;
  aDataModel.NextID[ClassID]:=FElement.ID+1;

  inherited;
end;

destructor TCreateElementOperation.Destroy;
begin
  inherited;
end;

function TCreateElementOperation.GetCode: integer;
begin
  Result:=boCreateElement
end;

procedure TCreateElementOperation.RollBack(DMDocument: IDMDocument);
var
  ClassID:integer;
  Collection:IDMCollection2;
  aDataModel:IDataModel;
begin
  try
  FElement.Selected:=False;
  ClassID:=FElement.ClassID;
  Collection:=(DMDocument.DataModel as IDMElement).Collection[ClassID] as IDMCollection2;
  Collection.Remove(FElement);
  FElement.Exists:=False;
  Collection:=nil;

  aDataModel:=FElement.DataModel;
  aDataModel.NextID[ClassID]:=FElement.ID;

  inherited;
  except
    raise
  end;
end;

procedure TCreateElementOperation.WriteToString(var S: string;
  const DMDocument: IDMDocument);
begin
  inherited;
  if FElement<>nil then
    S:=S+Format(' "%s"',[FElement.Name]);
end;

procedure TCreateElementOperation.ReadFromString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID:integer;
  aDataModel:IDMElement;
  aCollection2:IDMCollection2;
  Value:double;
begin
  FElement:=nil;
  if not ExtractValueFromString(S, Value) then Exit;
  ModelID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ClassID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ID:=round(Value);
  aDataModel:=DMDocument.DataModel as IDMElement;
  if ModelID=-1 then
    aDataModel:=DMDocument.DataModel as IDMElement
  else
    aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

  if ID<>-1 then begin
    aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
    if aCollection2<>nil then begin
      FElement:=aCollection2.CreateElement(False);
      FElement.ID:=ID;
      FElement.Name:=ExtractQuoteFromString(S);
    end;
  end;
end;

{ TRelationOperation }

constructor TRelationOperation.Create(aElement,
  aElement1: IDMElement);
begin
  inherited Create0(aElement);
  FNewValue:=aElement1;
end;

destructor TRelationOperation.Destroy;
begin
  inherited;
  FNewValue:=nil;
end;

procedure TRelationOperation.ReadFromString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID:integer;
  aDataModel:IDMElement;
  aCollection2:IDMCollection2;
  Value:double;
begin
  inherited;

  FNewValue:=nil;

  if not ExtractValueFromString(S, Value) then Exit;
  ModelID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ClassID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ID:=round(Value);
  aDataModel:=DMDocument.DataModel as IDMElement;
  if ModelID=-1 then
    aDataModel:=DMDocument.DataModel as IDMElement
  else
    aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

  if ClassID<>-1 then begin
    if ID<>-1 then begin
      aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
      if aCollection2<>nil then
        FNewValue:=aCollection2.GetItemByID(ID);
    end else
      FNewValue:=(DMDocument.DataModel as IDataModel).GetDefaultElement(ClassID);
  end else
    FNewValue:=nil
end;

procedure TRelationOperation.WriteToString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID:integer;
begin
  inherited;
  if FNewValue=nil then
    S:=S+' -1 -1 -1'
  else begin
    if FNewValue.DataModel=DMDocument.DataModel then
      ModelID:=-1
    else  
    if FNewValue=DMDocument.DataModel as IDMElement then
      ModelID:=-1
    else
      ModelID:=(FNewValue.DataModel as IDMElement).ID;
    ClassID:=FNewValue.ClassID;
    ID:=FNewValue.ID;
    S:=S+Format(' %d %d %d',[ModelID, ClassID, ID])
  end;
end;

{ TOneToManyRelationOperation }

constructor TOneToManyRelationOperation.Create(aElement,
  aElement1: IDMElement);
begin
  inherited Create(aElement, aElement1);
  FOldValue:=nil;
end;

destructor TOneToManyRelationOperation.Destroy;
begin
  inherited;
  FOldValue:=nil;
end;

procedure TOneToManyRelationOperation.ReadFromString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID:integer;
  aDataModel:IDMElement;
  aCollection2:IDMCollection2;
  Value:double;
begin
  inherited;

  FOldValue:=nil;

  if not ExtractValueFromString(S, Value) then Exit;
  ModelID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ClassID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ID:=round(Value);
  aDataModel:=DMDocument.DataModel as IDMElement;
  if ModelID=-1 then
    aDataModel:=DMDocument.DataModel as IDMElement
  else
    aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

  if ID<>-1 then begin
    aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
    if aCollection2<>nil then
      FOldValue:=aCollection2.GetItemByID(ID);
  end else
    FOldValue:=(DMDocument.DataModel as IDataModel).GetDefaultElement(ClassID);
end;

procedure TOneToManyRelationOperation.WriteToString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID:integer;
begin
  inherited;
  if FOldValue=nil then
    S:=S+' -1 -1 -1'
  else begin
    if FOldValue.DataModel=DMDocument.DataModel then
      ModelID:=-1
    else
      ModelID:=(FOldValue.DataModel as IDMElement).ID;
    ClassID:=FOldValue.ClassID;
    ID:=FOldValue.ID;
    S:=S+Format(' %d %d %d',[ModelID, ClassID, ID])
  end;
end;

{ TSetParentOperation }

procedure TSetParentOperation.Commit(DMDocument: IDMDocument);
begin
  try
  if FElement=nil then Exit;
  if (FElement.ID=118) or
     (FElement.ID=13) then
    XXX:=0; 
  FOldValue:=FElement.Parent;
  FElement.Parent:=FNewValue;
  inherited;
  except
    raise
  end
end;

function TSetParentOperation.GetCode: integer;
begin
  Result:=boSetParent
end;

procedure TSetParentOperation.RollBack(DMDocument: IDMDocument);
begin
  try
  if FElement=nil then Exit;
  FElement.Parent:=FOldValue;
  FOldValue:=nil;
  inherited;
  except
    raise
  end  
end;

{ TAddParentOperation }

procedure TAddParentOperation.Commit(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.AddParent(FNewValue);
  inherited;
end;

function TAddParentOperation.GetCode: integer;
begin
  Result:=boAddParent
end;

procedure TAddParentOperation.RollBack(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.RemoveParent(FNewValue);
  inherited;
end;

{ TRemoveParentOperation }

procedure TRemoveParentOperation.Commit(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.RemoveParent(FNewValue);
  inherited;
end;

function TRemoveParentOperation.GetCode: integer;
begin
  Result:=boRemoveParent
end;

procedure TRemoveParentOperation.RollBack(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.AddParent(FNewValue);
  inherited;
end;

{ TSetRefOperation }

procedure TSetRefOperation.Commit(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FOldValue:=FElement.Ref;
  FElement.Ref:=FNewValue;
  inherited;
end;

function TSetRefOperation.GetCode: integer;
begin
  Result:=boSetRef
end;

procedure TSetRefOperation.RollBack(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.Ref:=FOldValue;
  FOldValue:=nil;
  inherited;
end;

{ TDestroyElementOperation }

constructor TDestroyElementOperation.Create(aElement: IDMElement);
begin
  inherited Create0(aElement);
  FOldParent:=nil;
  FOldRef:=nil;
end;

destructor TDestroyElementOperation.Destroy;
begin
  inherited;
  FOldParent:=nil;
  FOldRef:=nil;
end;

procedure TDestroyElementOperation.Commit(DMDocument: IDMDocument);
var
  Collection: IDMCollection;
  ClassID:integer;
begin
  if FElement=nil then Exit;
  ClassID:=FElement.ClassID;
  Collection:=(DMDocument.DataModel as IDMElement).Collection[ClassID];
  FOldIndex:=Collection.IndexOf(FElement);
  (Collection as IDMCollection2).Remove(FElement);
  FOldParent:=FElement.Parent;
  FOldRef:=FElement.Ref;

  inherited;
end;

procedure TDestroyElementOperation.RollBack(DMDocument:IDMDocument);
var
  Collection2:IDMCollection2;
  ClassID:integer;
begin
try
  if FElement=nil then Exit;
  ClassID:=FElement.ClassID;
  Collection2:=(DMDocument.DataModel as IDMElement).Collection[ClassID] as IDMCollection2;
  if FOldIndex<>-1 then
    Collection2.Insert(FOldIndex, FElement)
  else
    Collection2.Add(FElement);

  FOldParent:=nil;
  FOldRef:=nil;
except
  raise
end;

  inherited;
end;

function TDestroyElementOperation.GetCode: integer;
begin
  Result:=boDestroyElement
end;

procedure TDestroyElementOperation.ReadFromString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID:integer;
  aDataModel:IDMElement;
  aCollection2:IDMCollection2;
  Value:double;
begin
  inherited;

  FOldParent:=nil;
  FOldRef:=nil;
  FOldIndex:=-1;

  if not ExtractValueFromString(S, Value) then Exit;
  ModelID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ClassID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ID:=round(Value);
  aDataModel:=DMDocument.DataModel as IDMElement;
  if ModelID=-1 then
    aDataModel:=DMDocument.DataModel as IDMElement
  else
    aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

  if ID<>-1 then begin
    aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
    if aCollection2<>nil then
      FOldParent:=aCollection2.GetItemByID(ID);
  end;

  if not ExtractValueFromString(S, Value) then Exit;
  ModelID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ClassID:=round(Value);
  if not ExtractValueFromString(S, Value) then Exit;
  ID:=round(Value);
  aDataModel:=DMDocument.DataModel as IDMElement;
  if ModelID=-1 then
    aDataModel:=DMDocument.DataModel as IDMElement
  else
    aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

  if ID<>-1 then begin
    aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
    if aCollection2<>nil then
      FOldRef:=aCollection2.GetItemByID(ID);
  end;

  ExtractValueFromString(S, Value);
  FOldIndex:=round(Value)
end;

procedure TDestroyElementOperation.WriteToString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID:integer;
begin
  inherited;
  if FOldParent=nil then
    S:=S+' -1 -1 -1'
  else begin
    if FOldParent.DataModel=DMDocument.DataModel then
      ModelID:=-1
    else
      ModelID:=(FOldParent.DataModel as IDMElement).ID;
    ClassID:=FOldParent.ClassID;
    ID:=FOldParent.ID;
    S:=S+Format(' %d %d %d',[ModelID, ClassID, ID])
  end;

  if FOldRef=nil then
    S:=S+' -1 -1 -1'
  else begin
    if FOldRef.DataModel=DMDocument.DataModel then
      ModelID:=-1
    else
      ModelID:=(FOldRef.DataModel as IDMElement).ID;
    ClassID:=FOldRef.ClassID;
    ID:=FOldRef.ID;
    S:=S+Format(' %d %d %d',[ModelID, ClassID, ID])
  end;

  S:=S+Format(' %d',[FOldIndex]);
end;

{ TRenameElementOperation }

procedure TRenameElementOperation.Commit(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.Name:=FNewName;
  inherited;
end;

constructor TRenameElementOperation.Create(aElement: IDMElement;
  NewName: string);
begin
  inherited Create0(aElement);
  FNewName:=NewName;
  if aElement<>nil then
    FOldName:=aElement.Name;
end;

function TRenameElementOperation.GetCode: integer;
begin
  Result:=boRename
end;

procedure TRenameElementOperation.RollBack(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.Name:=FOldName;
  inherited;
end;

procedure TRenameElementOperation.WriteToString(var S: string;
  const DMDocument: IDMDocument);
begin
  inherited;
  S:=S+Format(' "%s" "%s"',[FNewName, FOldName]);
end;

procedure TRenameElementOperation.ReadFromString(var S: string;
  const DMDocument: IDMDocument);
begin
  inherited;
  FNewName:=ExtractQuoteFromString(S);
  FOldName:=ExtractQuoteFromString(S);
end;

{ TChangeFieldValueOperation }

constructor TChangeFieldValueOperation.Create(aElement: IDMElement;
  FieldCode: integer; NewValue: OleVariant);
begin
  inherited Create0(aElement);
  FFieldCode:=FieldCode;
  FNewValue:=NewValue;
  if aElement<>nil then
    FOldValue:=aElement.GetFieldValue(FieldCode);
end;

procedure TChangeFieldValueOperation.Commit(
  DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  try
    FElement.SetFieldValue(FFieldCode, FNewValue);
    inherited;
  except
    raise
  end    
end;

procedure TChangeFieldValueOperation.RollBack(
  DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.SetFieldValue(FFieldCode, FOldValue);
  inherited;
end;

function TChangeFieldValueOperation.GetCode: integer;
begin
  Result:=boChangeFieldValue
end;

procedure TChangeFieldValueOperation.WriteToString(var S: string;
  const DMDocument: IDMDocument);
var
  DMField:IDMField;
  j, ModelID, ClassID, ID:integer;
  NewI, OldI:integer;
  NewF, OldF:double;
  NewS, OldS:string;
  NewE, OldE:IDMElement;
  V:variant;
  Unk:IUnknown;
begin
  inherited;
  DMField:=nil;
  j:=0;
  while j<FElement.FieldCount do begin
    if FElement.Field[j].Code=FFieldCode then
      Break
    else
      inc(j)
  end;
  if j<FElement.FieldCount then
    DMField:=FElement.Field[j];

  if DMField<>nil then begin
    S:=S+Format(' %d',[FFieldCode]);
    case DMField.ValueType of
    fvtFloat:
      begin
        NewF:=FNewValue;
        OldF:=FOldValue;
        DecimalSeparator:=LocalDecimalSeparator;
        S:=S+Format(' %0.4f %0.4f',[NewF, OldF]);
        DecimalSeparator:='.';
      end;
    fvtString,
    fvtText,
    fvtFile:
      begin
        NewS:=FNewValue;
        OldS:=FOldValue;
        S:=S+Format(' "%s" "%s"',[NewS, OldS]);
      end;
    fvtElement:
      begin
        V:=FNewValue;
        if VarIsNull(V) or
           VarIsEmpty(V) then
          S:=S+' -1 -1 -1'
        else begin
          Unk:=V;
          NewE:=Unk as IDMElement;

          if NewE=nil then
            S:=S+' -1 -1 -1'
          else begin
            if NewE.DataModel=DMDocument.DataModel then
              ModelID:=-1
            else
              ModelID:=(NewE.DataModel as IDMElement).ID;
            ClassID:=NewE.ClassID;
            ID:=NewE.ID;
            S:=S+Format(' %d %d %d',[ModelID, ClassID, ID])
          end;
        end;

        V:=FOldValue;
        if VarIsNull(V) or
           VarIsEmpty(V) then
          S:=S+' -1 -1 -1'
        else begin
          Unk:=V;
          OldE:=Unk as IDMElement;

          if OldE=nil then
            S:=S+' -1 -1 -1'
          else begin
            if OldE.DataModel=nil then
              ModelID:=-1
            else
            if OldE.DataModel=DMDocument.DataModel then
              ModelID:=-1
            else
              ModelID:=(OldE.DataModel as IDMElement).ID;
            ClassID:=OldE.ClassID;
            ID:=OldE.ID;
            S:=S+Format(' %d %d %d',[ModelID, ClassID, ID])
          end;
        end

      end;
    else
      begin
        NewI:=FNewValue;
        OldI:=FOldValue;
        S:=S+Format(' %d %d',[NewI, OldI])
      end;
    end;
  end else
    S:=S+' -1';
end;

procedure TChangeFieldValueOperation.ReadFromString(var S: string;
  const DMDocument: IDMDocument);
var
  DMField:IDMField;
  j, ModelID, ClassID, ID:integer;
  NewE, OldE:IDMElement;
  Unk:IUnknown;
  Value:double;
  aDataModel:IDMElement;
  aCollection2:IDMCollection2;
begin
  inherited;

  if not ExtractValueFromString(S, Value) then Exit;
  FFieldCode:=round(Value);

  DMField:=nil;
  j:=0;
  while j<FElement.FieldCount do begin
    if FElement.Field[j].Code=FFieldCode then
      Break
    else
      inc(j)
  end;
  if j<FElement.FieldCount then
    DMField:=FElement.Field[j];

  if DMField<>nil then begin
    case DMField.ValueType of
    fvtFloat:
      begin
        ExtractValueFromString(S, Value);
        FNewValue:=Value;
        ExtractValueFromString(S, Value);
        FOldValue:=Value;
      end;
    fvtString,
    fvtText,
    fvtFile:
      begin
        FNewValue:=ExtractQuoteFromString(S);
        FOldValue:=ExtractQuoteFromString(S);
      end;
    fvtElement:
      begin
        NewE:=nil;
        if not ExtractValueFromString(S, Value) then Exit;
        ModelID:=round(Value);
        if not ExtractValueFromString(S, Value) then Exit;
        ClassID:=round(Value);
        if not ExtractValueFromString(S, Value) then Exit;
        ID:=round(Value);
        aDataModel:=DMDocument.DataModel as IDMElement;
        if ModelID=-1 then
          aDataModel:=DMDocument.DataModel as IDMElement
        else
          aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

        if ID<>-1 then begin
          aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
          if aCollection2<>nil then
            NewE:=aCollection2.GetItemByID(ID);
        end;
        Unk:=NewE as IUnknown;
        FNewValue:=Unk;

        OldE:=nil;
        if not ExtractValueFromString(S, Value) then Exit;
        ModelID:=round(Value);
        if not ExtractValueFromString(S, Value) then Exit;
        ClassID:=round(Value);
        if not ExtractValueFromString(S, Value) then Exit;
        ID:=round(Value);
        aDataModel:=DMDocument.DataModel as IDMElement;
        if ModelID=-1 then
          aDataModel:=DMDocument.DataModel as IDMElement
        else
          aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

        if ID<>-1 then begin
          aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
          if aCollection2<>nil then
            OldE:=aCollection2.GetItemByID(ID);
        end;
        Unk:=OldE as IUnknown;
        FOldValue:=Unk;
      end;
    else
      begin
        ExtractValueFromString(S, Value);
        FNewValue:=round(Value);
        ExtractValueFromString(S, Value);
        FOldValue:=round(Value);
      end;
    end;
  end;
end;

{ TMoveElementOperation }

procedure TMoveElementOperation.Commit(DMDocument: IDMDocument);
var
  OwnerCollection:IDMCollection2;
begin
  inherited;
  if FElement=nil then Exit;
  if FOldIndex>=FCollection.Count then Exit;
  if FNewIndex>=FCollection.Count then Exit;
  (FCollection as IDMCollection2).Move(FOldIndex, FNewIndex);
  FElement.DataModel.AfterMoveInCollection(FCollection);
  if FMoveInOwnerCollection then begin
    OwnerCollection:=FElement.OwnerCollection as IDMCollection2;
    if OwnerCollection<>FCollection as IDMCollection2 then
      OwnerCollection.Move(FOldOwnerCollectionIndex, FNewOwnerCollectionIndex);
  end;
end;

constructor TMoveElementOperation.Create(const aElement: IDMElement;
     const Collection:IDMCollection; NewIndex: integer;
     MoveInOwnerCollection:WordBool);
var
  OwnerCollection:IDMCollection;
  ReplacedElement:IDMElement;
begin
  inherited Create0(aElement);
  if Collection=nil then Exit;
  FOldIndex:=Collection.IndexOf(aElement);
  FCollection:=Collection;
  OwnerCollection:=aElement.OwnerCollection;
  FNewIndex:=NewIndex;
  FMoveInOwnerCollection:=MoveInOwnerCollection;
  if FMoveInOwnerCollection then begin
    ReplacedElement:=Collection.Item[NewIndex];
    FOldOwnerCollectionIndex:=OwnerCollection.IndexOf(aElement);
    FNewOwnerCollectionIndex:=OwnerCollection.IndexOf(ReplacedElement);
  end;
end;

destructor TMoveElementOperation.Destroy;
begin
  inherited;
  FCollection:=nil
end;

function TMoveElementOperation.GetCode: integer;
begin
  Result:=boMoveElement
end;

procedure TMoveElementOperation.RollBack(DMDocument: IDMDocument);
var
  OwnerCollection:IDMCollection2;
begin
  inherited;
  if FElement=nil then Exit;
  if FOldIndex>=FCollection.Count then Exit;
  if FNewIndex>=FCollection.Count then Exit;
  (FCollection as IDMCollection2).Move(FNewIndex, FOldIndex);
  if FMoveInOwnerCollection then begin
    OwnerCollection:=FElement.OwnerCollection as IDMCollection2;
    if OwnerCollection<>FCollection as IDMCollection2 then
      OwnerCollection.Move(FNewOwnerCollectionIndex, FOldOwnerCollectionIndex);
  end;
end;

procedure TMoveElementOperation.WriteToString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID, CollectionID:integer;
  ParentElement:IDMElement;
begin
  inherited;
  ParentElement:=FCollection.Parent;
  if ParentElement=nil then begin
    ModelID:=-1;
    ClassID:=-1;
    ID:=-1;
    CollectionID:=-1;
  end else begin
    if ParentElement.DataModel=DMDocument.DataModel then
      ModelID:=-1
    else
      ModelID:=(ParentElement.DataModel as IDMElement).ID;
    ClassID:=ParentElement.ClassID;
    ID:=ParentElement.ID;
    CollectionID:=0;
    while CollectionID<ParentElement.CollectionCount do
      if FCollection=ParentElement.Collection[CollectionID] then
        Break
      else
        inc(CollectionID);  
  end;

  S:=S+Format(' %d %d %d %d %d %d %d %d %d',[
    FOldIndex,
    FNewIndex,
    FOldOwnerCollectionIndex,
    FNewOwnerCollectionIndex,
    ModelID, ClassID, ID, CollectionID,
    ord(FMoveInOwnerCollection)]);
end;

procedure TMoveElementOperation.ReadFromString(var S: string;
  const DMDocument: IDMDocument);
var
  ModelID, ClassID, ID, CollectionID, Flag:integer;
  ParentElement:IDMElement;
  Value:double;
  aDataModel:IDMElement;
  aCollection2:IDMCollection2;
begin
  inherited;
  ExtractValueFromString(S, Value);
  FOldIndex:=round(Value);
  ExtractValueFromString(S, Value);
  FNewIndex:=round(Value);
  ExtractValueFromString(S, Value);
  FOldOwnerCollectionIndex:=round(Value);
  ExtractValueFromString(S, Value);
  FNewOwnerCollectionIndex:=round(Value);
  ExtractValueFromString(S, Value);

  ModelID:=round(Value);
  ExtractValueFromString(S, Value);
  ClassID:=round(Value);
  ExtractValueFromString(S, Value);
  ID:=round(Value);
  ExtractValueFromString(S, Value);
  CollectionID:=round(Value);

  aDataModel:=DMDocument.DataModel as IDMElement;
  if ModelID=-1 then
    aDataModel:=DMDocument.DataModel as IDMElement
  else
    aDataModel:=(DMDocument.DataModel as IDataModel).SubModel[ModelID] as IDMElement;

  if ID<>-1 then begin
    aCollection2:=aDataModel.Collection[ClassID] as IDMCollection2;
    if aCollection2<>nil then begin
      ParentElement:=aCollection2.GetItemByID(ID);
      FCollection:=ParentElement.Collection[CollectionID];
    end;
  end;

  ExtractValueFromString(S, Value);
  Flag:=round(Value);
  FMoveInOwnerCollection:=boolean(Flag)
end;

{ TUpdateElementOperation }

procedure TUpdateElementOperation.Commit(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.Update;
//  FElement.UpdateCoords;
  inherited;
end;

function TUpdateElementOperation.GetCode: integer;
begin
  Result:=boUpdateElement
end;

procedure TUpdateElementOperation.RollBack(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.Update;
//  FElement.UpdateCoords;
  inherited;
end;

{ TUpdateCoordsOperation }

procedure TUpdateCoordsOperation.Commit(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.UpdateCoords;
  inherited;
end;

function TUpdateCoordsOperation.GetCode: integer;
begin
  Result:=boUpdateCoords
end;

procedure TUpdateCoordsOperation.RollBack(DMDocument: IDMDocument);
begin
  if FElement=nil then Exit;
  FElement.UpdateCoords;
  inherited;
end;

initialization
  LocalDecimalSeparator:=DecimalSeparator;
  DecimalSeparator:='.';
end.
