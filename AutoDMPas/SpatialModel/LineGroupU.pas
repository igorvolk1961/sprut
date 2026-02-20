unit LineGroupU;

interface
uses
  Classes, SysUtils, Dialogs,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SpatialElementU;

type

  TLineGroup=class(TSpatialElement, ILineGroup)
  private
    FBuildIn:boolean;
  protected
    FLines:IDMCollection;

    procedure Initialize; override;
    procedure _Destroy; override;
    procedure ClearOp; override;

    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;
    procedure Update; override; safecall;
    procedure ReorderLines(const Lines:IDMCollection); virtual; safecall;

    procedure Set_Parent(const Value:IDMElement); override; safecall;
    function  Get_BuildIn: WordBool; override; safecall;
    procedure Set_BuildIn(Value: WordBool); override; safecall;
    function Get_Lines: IDMCollection; safecall;

    property Lines:IDMCollection read Get_Lines;

    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;

    procedure RemoveChild(const Value:IDMElement); override;

    function  Get_CollectionCount:integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;

    function GetLineClassID: integer; virtual;
  end;

  TLineGroups=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;


implementation
uses
  SpatialModelConstU;

var
  FFields:IDMCollection;

{ TLineGroup }

function TLineGroup.GetLineClassID:integer;
begin
  Result:=_Line
end;

procedure TLineGroup.Initialize;
var
  LineClassID:integer;
begin
  inherited;
  LineClassID:=GetLineClassID;
  FLines:=DataModel.CreateCollection(LineClassID, Self as IDMElement);
end;

procedure TLineGroup._Destroy;
begin
  inherited;
  FLines:=nil
end;

class function TLineGroup.GetClassID: integer;
begin
  Result:=_LineGroup;
end;
procedure TLineGroup.Draw(const aPainter:IUnknown; DrawSelected: integer);
var j:integer;
begin
  try
  for j:=0 to FLines.Count-1 do
    FLines.Item[j].Draw(aPainter, DrawSelected);
  except
    raise
  end    
end;

function TLineGroup.Get_Lines: IDMCollection;
begin
  Result:=FLines
end;

function TLineGroup.Get_Collection(Index: Integer): IDMCollection;
begin
  case Index of
  0:Result:=FLines;
  else
    Result:=inherited Get_Collection(Index-1)
  end;
end;

function TLineGroup.Get_CollectionCount: integer;
begin
    Result:=1
end;

procedure TLineGroup.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
    case Index of
    0:begin
        aCollectionName:=FLines.ClassAlias[akImenitM];
        aOperations:=0;
        aRefSource:=nil;
        aClassCollections:=nil;
        aLinkType:=ltManyToMany;
      end;
    else
      inherited GetCollectionProperties(Index-1,
      aCollectionName, aRefSource, aClassCollections, aOperations, aLinkType)
    end;
end;

procedure TLineGroup.Set_Parent(const Value: IDMElement);
var
  j:integer;
  LineE:IDMElement;
begin
  inherited;
  if Value=nil then Exit;
  if Get_BuildIn then Exit;
  if DataModel.IsCopying then Exit;
  if DataModel.IsChanging and
    (FLines<>nil) then
    for j:=0 to FLines.Count-1 do begin
      LineE:=FLines.Item[j];
      LineE.Parent:=Value;
    end;
end;

class function TLineGroup.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TLineGroup.Get_BuildIn: WordBool;
begin
  Result:=FBuildIn
end;

procedure TLineGroup.Set_BuildIn(Value: WordBool);
begin
  inherited;
  FBuildIn:=Value
end;

procedure TLineGroup.ClearOp;
var
 aRef:IDMElement;
begin
  if Ref<>nil then begin
    aRef:=Ref;
    Ref.SpatialElement:=nil;
//    if not DataModel.IsCopying then
//      DataModel.RemoveElement(aRef);
  end;
  inherited;
end;

procedure TLineGroup.RemoveChild(const Value: IDMElement);
begin
  inherited;

end;

procedure TLineGroup.Update;
begin
  inherited;
  if (Ref<>nil) and
      not DataModel.IsLoading then
    Ref.Update;
end;

procedure TLineGroup.ReorderLines(const Lines: IDMCollection);
var
  j, Bestj:integer;
  Line:ILine;
  LineE, BestLineE:IDMElement;
  TMPList:TList;
  C0, C1:ICoordNode;
  Lines2:IDMCollection2;
  PrevCount, K:integer;
  DMin, D00, D01, D10, D11, X0, Y0, Z0, X1, Y1, Z1:double;
begin
  if Lines.Count<2 then Exit;
  Lines2:=Lines as IDMCollection2;
  TMPList:=TList.Create;
  LineE:=Lines.Item[0];
  Line:=LineE as ILine;
  C0:=Line.C0;
  C1:=Line.C1;
  X0:=C0.X;
  Y0:=C0.Y;
  Z0:=C0.Z;
  X1:=C1.X;
  Y1:=C1.Y;
  Z1:=C1.Z;

  Lines2.Delete(0);
  TMPList.Add(pointer(LineE));
  while Lines.Count>0 do begin
    BestLineE:=nil;
    Bestj:=-1;
    K:=-1;
    j:=0;
    while j<Lines.Count do begin
      LineE:=Lines.Item[j];
      Line:=LineE as ILine;
      if C0=Line.C0 then begin
        C0:=Line.C1;
        X0:=C0.X;
        Y0:=C0.Y;
        Z0:=C0.Z;
        BestLineE:=nil;
        TMPList.Insert(0, pointer(LineE));
        Break
      end else
      if C1=Line.C0 then begin
        C1:=Line.C1;
        X1:=C1.X;
        Y1:=C1.Y;
        Z1:=C1.Z;
        BestLineE:=nil;
        TMPList.Add(pointer(LineE));
        Break
      end else
      if C0=Line.C1 then begin
        C0:=Line.C0;
        X0:=C0.X;
        Y0:=C0.Y;
        Z0:=C0.Z;
        BestLineE:=nil;
        TMPList.Insert(0, pointer(LineE));
        Break
      end else
      if C1=Line.C1 then begin
        C1:=Line.C0;
        X1:=C1.X;
        Y1:=C1.Y;
        Z1:=C1.Z;
        BestLineE:=nil;
        TMPList.Add(pointer(LineE));
        Break
      end
      else
        inc(j);
    end;


    if j=Lines.Count then begin
      DMin:=InfinitValue;
      j:=0;
      while j<Lines.Count do begin
        D00:=Line.C0.DistanceFrom(X0, Y0, Z0);
        if DMin>D00 then begin
          DMin:=D00;
          K:=0;
          BestLineE:=LineE;
          Bestj:=j;
        end;
        D10:=Line.C1.DistanceFrom(X0, Y0, Z0);
        if DMin>D10 then begin
          DMin:=D10;
          K:=1;
          BestLineE:=LineE;
          Bestj:=j;
        end;
        D01:=Line.C0.DistanceFrom(X1, Y1, Z1);
        if DMin>D01 then begin
          DMin:=D01;
          K:=2;
          BestLineE:=LineE;
          Bestj:=j;
        end;
        D11:=Line.C1.DistanceFrom(X1, Y1, Z1);
        if DMin>D11 then begin
          DMin:=D11;
          K:=3;
          BestLineE:=LineE;
          Bestj:=j;
        end;
        inc(j);
      end;
    end;

    if BestLineE<>nil then begin
      LineE:=BestLineE;
      Line:=LineE as ILine;
      j:=Bestj;
      case K of
      0:begin
         C0:=Line.C1;
         X0:=C0.X;
         Y0:=C0.Y;
         Z0:=C0.Z;
         TMPList.Insert(0, pointer(LineE));
        end;
      1:begin
         C0:=Line.C0;
         X0:=C0.X;
         Y0:=C0.Y;
         Z0:=C0.Z;
         TMPList.Insert(0, pointer(LineE));
        end;
      2:begin
         C1:=Line.C1;
         X1:=C1.X;
         Y1:=C1.Y;
         Z1:=C1.Z;
         TMPList.Add(pointer(LineE));
        end;
      3:begin
         C1:=Line.C0;
         X1:=C1.X;
         Y1:=C1.Y;
         Z1:=C1.Z;
         TMPList.Add(pointer(LineE));
        end;
      end; // case K
    end;

    if j<Lines.Count then
      Lines2.Delete(j)
    else begin
      while Lines.Count>0 do begin
        LineE:=Lines.Item[0];
        PrevCount:=Lines.Count;
        LineE.RemoveParent(Self as IDMElement);
        if PrevCount=Lines.Count then
          (Lines as IDMCollection2).Delete(0)
      end;
    end
  end;

  for j:=0 to TMPList.Count-1 do
    Lines2.Add(IDMElement(TMPList[j]));

  TMPList.Free
end;

{ TLineGroups }

class function TLineGroups.GetElementClass: TDMElementClass;
begin
  Result:=TLineGroup;
end;

function TLineGroups.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsLineGroup;
end;

class function TLineGroups.GetElementGUID: TGUID;
begin
  Result:=IID_ILineGroup;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TLineGroup.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
