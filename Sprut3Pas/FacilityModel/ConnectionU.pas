unit ConnectionU;

interface
uses
  Classes, SysUtils, Graphics,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB, PainterLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

type

  TConnection=class(TDMElement, IConnection)
  private
    FX0:double;
    FY0:double;
    FZ0:double;
    FX1:double;
    FY1:double;
    FZ1:double;
    procedure CalcXYZ;
  protected
    class procedure MakeFields0; override;

    class function  GetClassID:integer; override;
    class function GetFields:IDMCollection; override;

    function Get_FieldCount_: integer;  override; safecall;
    function Get_Field_(Index: integer): IDMField; override; safecall;
    function  Get_FieldValue_(Index: integer): OleVariant; override; safecall;
    procedure Set_FieldValue_(Index: integer; Value: OleVariant); override; safecall;
    function  GetFieldValue(Code: integer): OleVariant; override;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override;
    procedure GetFieldValueSource(Code: integer; var aCollection: IDMCollection); override;
    function  FieldIsVisible(Code: Integer): WordBool; override; safecall;

    procedure AddChild(const aChild:IDMElement); override; safecall;

    function Get_MainParent:IDMElement; override;
    procedure Set_Parent(const aParent:IDMElement); override;
    function Get_Name:WideString; override;
    procedure Set_Name(const aName:WideString); override;
    procedure Set_Selected(Value:WordBool); override;
    procedure AfterLoading2; override;

    function Get_CollectionCount: integer; override;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure GetCollectionProperties(Index: Integer;
                                      out aCollectionName: WideString;
                                      out aRefSource: IDMCollection;
                                      out aClassCollections: IDMClassCollections;
                                      out aOperations: Integer; out aLinkType: Integer); override; safecall;
    procedure MakeSelectSource(Index: Integer; const aCollection: IDMCollection); override; safecall;


    procedure Draw(const aPainter:IUnknown; DrawSelected:integer); override;

    function  ConnectedTo(const MainControlDeviceE, SecondaryControlDeviceE:IDMElement;
            const CheckedConnections:IDMCollection):WordBool;safecall;
  public
    procedure Initialize; override;
    procedure _Destroy; override;
  end;

  TConnections=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
    function       Get_ClassAlias2(Index:integer): WideString; override; safecall;
  end;

implementation
uses
  FacilityModelConstU, FacilitySubStateU,
  Geometry, Outlines;

var
  FFields:IDMCollection;

{ TConnection }

class function TConnection.GetClassID: integer;
begin
  Result:=_Connection;
end;

procedure TConnection.Initialize;
begin
  inherited;
end;

procedure TConnection._Destroy;
begin
  inherited;
end;

class function TConnection.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TConnection.GetFieldValue(Code: integer): OleVariant;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (Ref=nil) then begin
    Result:=inherited GetFieldValue(Code);
  end else begin
    Result:=Ref.GetFieldValue(Code);
  end;
end;

procedure TConnection.SetFieldValue(Code: integer; Value: OleVariant);
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (Ref=nil) then begin
    inherited;
  end else begin
    Ref.SetFieldValue(Code, Value);
  end;
end;

class procedure TConnection.MakeFields0;
begin
  inherited;
end;

function TConnection.Get_Name: WideString;
var
  S:string;
begin
  S:=inherited Get_Name;
{
  if (Parent<>nil) and (Parent.Parent<>nil) then
    Result:=Parent.Name+'\'+Parent.Parent.Name+' ('+S+')'
  else
}  
    Result:=S

end;

procedure TConnection.CalcXYZ;
var
  CabelE:IDMElement;
  CabelP, Polyline:IPolyline;
  Cabel:ICabel;
  C0, C1:ICoordNode;
  SpatialElement, SafeguardElement:IDMElement;
  Volume:IVolume;
  Line:ILine;
begin
  if Ref=nil then Exit;
  if Parent=nil then Exit;
  if Ref.QueryInterface(ICabel, Cabel)<>0 then Exit;

  CabelE:=Ref;
  CabelP:=CabelE.SpatialElement as IPolyline;

  SafeguardElement:=Parent;
  if SafeguardElement.Parent.ClassID=_Zone then begin
    SpatialElement:=SafeguardElement.SpatialElement;
    if SpatialElement=nil then begin
      Volume:=SafeguardElement.Parent.SpatialElement as IVolume;
      if Volume.BottomAreas.Count>0 then begin
        Polyline:=Volume.BottomAreas.Item[0] as IPolyline;
        FindOutlinesDistance(Polyline.Lines, CabelP.Lines,
                            FX0, FY0, FZ0, FX1, FY1, FZ1);
      end;
    end else begin
      if SpatialElement.ClassID=_CoordNode then begin
        C0:=SpatialElement as ICoordNode;
        FX0:=C0.X;
        FY0:=C0.Y;
        FZ0:=C0.Z;
      end else begin
        C0:=(SpatialElement as ILine).C0;
        FX0:=C0.X;
        FY0:=C0.Y;
        FZ0:=C0.Z;
      end;
      FindPointToOutlineDistance(CabelP.Lines,
                          FX0, FY0, FZ0, FX1, FY1, FZ1);
    end;
  end else begin
    SpatialElement:=SafeguardElement.Parent.Parent.SpatialElement;
    if SpatialElement=nil then
      Exit
    else
    if SpatialElement.QueryInterface(IPolyline, Polyline)=0 then
      FindOutlinesDistance(Polyline.Lines, CabelP.Lines,
                        FX0, FY0, FZ0, FX1, FY1, FZ1)
    else
    if SpatialElement.QueryInterface(ICoordNode, C0)=0 then begin
      FX0:=C0.X;
      FY0:=C0.Y;
      FZ0:=C0.Z;
      FindPointToOutlineDistance(CabelP.Lines,
                          FX0, FY0, FZ0, FX1, FY1, FZ1);
    end else
    if SpatialElement.QueryInterface(ILine, Line)=0 then begin
      C0:=Line.C0;
      C1:=Line.C1;
      FX0:=0.5*(C0.X+C1.X);
      FY0:=0.5*(C0.Y+C1.Y);
      FZ0:=0.5*(C0.Z+C1.Z);
      FindPointToOutlineDistance(CabelP.Lines,
                          FX0, FY0, FZ0, FX1, FY1, FZ1);
    end
  end;
end;

procedure TConnection.Draw(const aPainter: IInterface;
  DrawSelected: integer);
var
  Layer:ILayer;
begin
  try
  if Ref=nil then Exit;
  if Parent=nil then Exit;
  if Ref.SpatialElement=nil then Exit;
  Layer:=Ref.SpatialElement.Parent as ILayer;
  if Layer=nil then Exit;
  if (DataModel.Document<>nil) and
     (((DataModel.Document as IDMDocument).State and dmfAuto)<>0) then Exit;
  if (DrawSelected<>0) or
      Layer.Visible then
    with aPainter as IPainter do begin
      if (DrawSelected=1) then
        PenColor:=clLime
      else if (DrawSelected=-1) then
        PenColor:=clWhite
      else
        PenColor:=Layer.Color;

      PenStyle:=Layer.Style;

      PenWidth:=Layer.LineWidth;
//      PenWidth:=Get_Thickness;
      if DrawSelected=3 then
        PenMode:=ord(pmNotXor)
      else  
        PenMode:=ord(pmCopy);
      DrawLine(FX0, FY0, FZ0, FX1, FY1, FZ1);
      PenWidth:=0;
    end;
  except
    raise
  end
end;

procedure TConnection.Set_Parent(const aParent: IDMElement);
begin
  if (DataModel<>nil) and
     (not DataModel.IsLoading) and
     (not DataModel.IsCopying) then begin

    if (aParent<>nil) and
       (aParent.ClassID=_Connection)  then
      Set_Parent(aParent.Ref)
    else
      inherited;

    CalcXYZ;
    
  end else
    inherited  
end;

function TConnection.ConnectedTo(const MainControlDeviceE, SecondaryControlDeviceE: IDMElement;
           const CheckedConnections:IDMCollection): WordBool;
var
  Cabel:ICabel;
  j, i0, i, m:integer;
  ControlDevice:IControlDevice;
  ControlDeviceN:ICabelNode;
  Connection:IConnection;
  ControlDeviceE, ConnectionE:IDMElement;
begin
  Result:=False;
  Cabel:=Ref as ICabel;
  i0:=Cabel.IndexOf(Parent);

  i:=Cabel.IndexOf(MainControlDeviceE);
  if i<>-1 then
    Result:=not Cabel.CuttedBetween(i0, i);
  if Result then Exit;

  i:=Cabel.IndexOf(SecondaryControlDeviceE);
  if i<>-1 then
    Result:=not Cabel.CuttedBetween(i0, i);
  if Result then Exit;

  (CheckedConnections as IDMCollection2).Add(Self as IDMElement);

  j:=0;
  while j<Cabel.ControlDevices.Count do begin
    ControlDeviceE:=Cabel.ControlDevices.Item[j];
    ControlDeviceN:=ControlDeviceE as ICabelNode;
    ControlDevice:=ControlDeviceE as IControlDevice;
    if ControlDevice.InWorkingState then begin
      i:=Cabel.IndexOf(ControlDeviceE);
      if not Cabel.CuttedBetween(i0, i) then begin
        m:=0;
        while m<ControlDeviceN.Connections.Count do begin
          ConnectionE:=ControlDeviceN.Connections.Item[m];
          Connection:=ConnectionE as IConnection;
          if (Connection<>Self as IConnection) and
             (CheckedConnections.IndexOf(ConnectionE)=-1) and
              Connection.ConnectedTo(MainControlDeviceE,
                                     SecondaryControlDeviceE,
                                     CheckedConnections) then
            Break
          else
            inc(m);
        end;
        if m<ControlDeviceN.Connections.Count then
          Break
        else
          inc(j)
      end else  // if CuttedBetween(i0, i)
        inc(j)
    end else // if not ControlDeviceS.InWorkingState
      inc(j)
  end;
  Result:=(j<Cabel.ControlDevices.Count);
end;

function TConnection.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=nil;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Ref=nil then Exit;
  Result:=Ref.Collection[Index]
end;

function TConnection.Get_CollectionCount: integer;
begin
  Result:=0;
  if DataModel=nil then Exit;
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Ref=nil then Exit;
  Result:=Ref.CollectionCount
end;

procedure TConnection.GetCollectionProperties(Index: Integer;
  out aCollectionName: WideString; out aRefSource: IDMCollection;
  out aClassCollections: IDMClassCollections; out aOperations,
  aLinkType: Integer);
begin
  if DataModel.IsLoading then Exit;
  if DataModel.IsCopying then Exit;
  if Ref=nil then Exit;
  Ref.GetCollectionProperties(Index, aCollectionName,
      aRefSource, aClassCollections, aOperations, aLinkType)
end;

procedure TConnection.MakeSelectSource(Index: Integer;
  const aCollection: IDMCollection);
begin
  if Ref=nil then Exit;
  Ref.MakeSelectSource(Index, aCollection)
end;

function TConnection.Get_FieldCount_: integer;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (Ref=nil) then begin
    Result:=inherited Get_FieldCount_
  end else begin
    Result:=inherited Get_FieldCount_+
            Ref.Get_FieldCount_;
  end;
end;

function TConnection.Get_FieldValue_(Index: integer): OleVariant;
var
  N:integer;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (Ref=nil) then begin
    Result:=inherited Get_FieldValue_(Index)
  end else begin
    N:=inherited Get_FieldCount_;
    if Index<N then
      Result:=inherited Get_FieldValue_(Index)
    else
      Result:=Ref.Get_FieldValue_(Index-N);
  end;
end;

procedure TConnection.Set_FieldValue_(Index: integer; Value: OleVariant);
var
  N:integer;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (Ref=nil) then begin
    inherited
  end else begin
    N:=inherited Get_FieldCount_;
    if Index<N then
      inherited
    else
      Ref.Set_FieldValue_(Index-N, Value);
  end;
end;

function TConnection.Get_Field_(Index: integer): IDMField;
var
  N:integer;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (Ref=nil) then begin
    Result:=inherited Get_Field_(Index)
  end else begin
    N:=inherited Get_FieldCount_;
    if Index<N then
      Result:=inherited Get_Field_(Index)
    else
      Result:=Ref.Get_Field_(Index-N);
  end;
end;

function TConnection.FieldIsVisible(Code: Integer): WordBool;
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (Ref=nil) then begin
    Result:=inherited FieldIsVisible(Code);
  end else begin
    Result:=Ref.FieldIsVisible(Code);
  end;
end;

procedure TConnection.GetFieldValueSource(Code: integer;
  var aCollection: IDMCollection);
begin
  if (DataModel=nil) or
     DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     (Ref=nil) then begin
    inherited GetFieldValueSource(Code, aCollection);
  end else begin
    Ref.GetFieldValueSource(Code, aCollection);
  end;
end;

procedure TConnection.Set_Name(const aName: WideString);
begin
  if (DataModel<>nil) and
     not DataModel.IsLoading and
     not DataModel.IsCopying and
     not DataModel.IsExecuting and
     (Ref<>nil) then
    Ref.Name:=aName;
end;

procedure TConnection.Set_Selected(Value: WordBool);
begin
  if Ref=nil then
    inherited
  else
    Ref.Selected:=Value;
end;

procedure TConnection.AfterLoading2;
begin
  CalcXYZ;

  if (Parent<>nil) and
     (Parent.ClassID=_Connection) then
    Set_Parent(Parent.Ref);
end;

procedure TConnection.AddChild(const aChild: IDMElement);
begin
  if DataModel.IsLoading then Exit;
  inherited;
end;

function TConnection.Get_MainParent: IDMElement;
begin
  Result:=Ref.MainParent
end;

{ TConnections }

class function TConnections.GetElementClass: TDMElementClass;
begin
  Result:=TConnection;
end;

function TConnections.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsConnection
  else
    Result:=rsConnections;
end;

class function TConnections.GetElementGUID: TGUID;
begin
  Result:=IID_IConnection;
end;

function TConnections.Get_ClassAlias2(Index: integer): WideString;
begin
  Result:=rsConnection2
end;

initialization
  FFields:=TDMCollection.Create(nil) as IDMCollection;
  TConnection.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
