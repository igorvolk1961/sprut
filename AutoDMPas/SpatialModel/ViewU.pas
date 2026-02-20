unit ViewU;

interface
uses
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, PolyLineU;

type

  TView=class(TNamedDMElement, IView)
  private
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
    FCX:double;
    FCY:double;
    FCZ:double;
    FZangle:double;
    FTangle:double;
    FcosZ:double;
    FsinZ:double;
    FcosT:double;
    FsinT:double;
    FDepth:double;
    FCurrX:double;
    FCurrY:double;
    FCurrZ:double;
    FZmin:double;
    FZmax:double;
    FDmin:double;
    FDmax:double;
    FRevScaleX:double;
    FRevScaleY:double;
    FRevScaleZ:double;
    FStoredParam:integer;

    function  Get_StoredParam: integer; safecall;
    procedure Set_StoredParam(Value: integer); safecall;

    function Get_cosZ: double; safecall;
    function Get_sinZ: double; safecall;
    function Get_cosT: double; safecall;
    function Get_sinT: double; safecall;
    function Get_CX: double; safecall;
    function Get_CY: double; safecall;
    function Get_CZ: double; safecall;
    function Get_Dmax: double; safecall;
    function Get_Dmin: double; safecall;
    function Get_RevScaleX: double; safecall;
    function Get_RevScaleY: double; safecall;
    function Get_RevScaleZ: double; safecall;
    function Get_RevScale: double; safecall;
    function Get_CurrX0: double; safecall;
    function Get_CurrY0: double; safecall;
    function Get_CurrZ0: double; safecall;
    function Get_Zangle: double; safecall;
    function Get_Tangle: double; safecall;
    function Get_Zmax: double; safecall;
    function Get_Zmin: double; safecall;

    procedure Set_Zangle(Value: double); safecall;
    procedure Set_Tangle(Value: double); safecall;
    procedure Set_CX(Value: double); safecall;
    procedure Set_CY(Value: double); safecall;
    procedure Set_CZ(Value: double); safecall;
    procedure Set_Dmax(Value: double); safecall;
    procedure Set_Dmin(Value: double); safecall;
    procedure Set_RevScaleX(Value: double); safecall;
    procedure Set_RevScaleY(Value: double); safecall;
    procedure Set_RevScaleZ(Value: double); safecall;
    procedure Set_RevScale(Value: double); safecall;
    procedure Set_CurrX0(Value: double); safecall;
    procedure Set_CurrY0(Value: double); safecall;
    procedure Set_CurrZ0(Value: double); safecall;
    procedure Set_Zmax(Value: double); safecall;
    procedure Set_Zmin(Value: double); safecall;
  protected
    procedure Initialize; override;
    class function  GetClassID:integer; override;

    class function  GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    procedure SetFieldValue_(Code: integer; Value: OleVariant); safecall;

    function PointIsVisible(X, Y, Z:double; Tag:integer):WordBool; safecall;
    procedure Duplicate(const aView:IView); safecall;
    property RevScale:double read Get_RevScale write Set_RevScale;
  end;

  TViews=class(TDMCollection)
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

{ TView }

procedure TView.Initialize;
begin
  inherited;
  FZmin:=-InfinitValue;
  FZmax:=InfinitValue;
  FDmin:=-InfinitValue;
  FDmax:=InfinitValue;
  Set_TAngle(0);
end;

class function TView.GetClassID: integer;
begin
  Result:=_View;
end;

procedure TView.Set_RevScale(Value: double);
begin
  Set_FieldValue(ord(vRevScaleX), Value);
  Set_FieldValue(ord(vRevScaleY), Value);
  Set_FieldValue(ord(vRevScaleZ), Value);
end;

class function TView.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TView.MakeFields0;
begin
  inherited;
  AddField(rsCentralPointX, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vCentralPointX), 0, pkInput);
  AddField(rsCentralPointY, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vCentralPointY), 0, pkInput);
  AddField(rsCentralPointZ, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vCentralPointZ), 0, pkInput);
  AddField(rsZAngle, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vZAngle), 0, pkInput);
  AddField(rsDepth, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vDepth), 0, pkInput);
  AddField(rsRevScaleX, '%0.2f', '', '',
      fvtFloat, 1, 0, 0,
      ord(vRevScaleX), 0, pkInput);
  AddField(rsRevScaleY, '%0.2f', '', '',
      fvtFloat, 1, 0, 0,
      ord(vRevScaleY), 0, pkInput);
  AddField(rsRevScaleZ, '%0.2f', '', '',
      fvtFloat, 1, 0, 0,
      ord(vRevScaleZ), 0, pkInput);
  AddField(rsCurrX, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vCurrX), 0, pkInput);
  AddField(rsCurrY, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vCurrY), 0, pkInput);
  AddField(rsCurrZ, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vCurrZ), 0, pkInput);
  AddField(rsZmin, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vZmin), 0, pkInput);
  AddField(rsZmax, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vZmax), 0, pkInput);
  AddField(rsDmin, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vDmin), 0, pkInput);
  AddField(rsDmax, '%0.2f', '', '',
      fvtFloat, 0, 0, 0,
      ord(vDmax), 0, pkInput);
  AddField(rsStoredParam, '%0d', '', '',
      fvtInteger, 0, 0, 0,
      ord(vStoredParam), 0, pkInput);
end;

function TView.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(vCentralPointX):
    Result:=FCX;
  ord(vCentralPointY):
    Result:=FCY;
  ord(vCentralPointZ):
    Result:=FCZ;
  ord(vZangle):
    Result:=FZangle;
  ord(vDepth):
    Result:=FDepth;
  ord(vRevScaleX):
    Result:=FRevScaleX;
  ord(vRevScaleY):
    Result:=FRevScaleY;
  ord(vRevScaleZ):
    Result:=FRevScaleZ;
  ord(vCurrX):
    Result:=FCurrX;
  ord(vCurrY):
    Result:=FCurrY;
  ord(vCurrZ):
    Result:=FCurrZ;
  ord(vZmin):
    Result:=FZmin;
  ord(vZmax):
    Result:=FZmax;
  ord(vDmin):
    Result:=FDmin;
  ord(vDmax):
    Result:=FDmax;
  ord(vStoredParam):
    Result:=FStoredParam;
  else
    Result:=inherited Get_FieldValue(Code);
  end;
end;

procedure TView.SetFieldValue_(Code: integer; Value: OleVariant);
begin
  case Code of
  ord(vCentralPointX):
    FCX:=Value;
  ord(vCentralPointY):
    FCY:=Value;
  ord(vCentralPointZ):
    FCZ:=Value;
  ord(vZangle):
    begin
      FZangle:=Value;
      FcosZ:=cos(FZangle*PI/180);
      FsinZ:=sin(FZangle*PI/180);
    end;
  ord(vDepth):
    FDepth:=Value;
  ord(vRevScaleX):
    if Value<>0 then
      FRevScaleX:=Value;
  ord(vRevScaleY):
    if Value<>0 then
      FRevScaleY:=Value;
  ord(vRevScaleZ):
    if Value<>0 then
      FRevScaleZ:=Value;
  ord(vCurrX):
    FCurrX:=Value;
  ord(vCurrY):
    FCurrY:=Value;
  ord(vCurrZ):
    FCurrZ:=Value;
  ord(vZmin):
    FZmin:=Value;
  ord(vZmax):
    FZmax:=Value;
  ord(vDmin):
    FDmin:=Value;
  ord(vDmax):
    FDmax:=Value;
  ord(vStoredParam):
    FStoredParam:=Value;
  else
    inherited;
  end;
end;

procedure TView.Set_Zangle(Value: double);
begin
  Set_FieldValue(ord(vZangle), Value)
end;

function TView.Get_cosZ: double;
begin
  Result:=FcosZ
end;

function TView.Get_CX: double;
begin
  Result:=FCX
end;

function TView.Get_CY: double;
begin
  Result:=FCY
end;

function TView.Get_CZ: double;
begin
  Result:=FCZ
end;

function TView.Get_Dmax: double;
begin
  Result:=FDmax
end;

function TView.Get_Dmin: double;
begin
  Result:=FDmin
end;

function TView.Get_RevScaleX: double;
begin
  Result:=FRevScaleX
end;

function TView.Get_RevScaleY: double;
begin
  Result:=FRevScaleY
end;

function TView.Get_sinZ: double;
begin
  Result:=FsinZ
end;

function TView.Get_CurrX0: double;
begin
  Result:=FCurrX
end;

function TView.Get_CurrY0: double;
begin
  Result:=FCurrY
end;

function TView.Get_Zangle: double;
begin
  Result:=FZangle
end;

function TView.Get_CurrZ0: double;
begin
  Result:=FCurrZ
end;

function TView.Get_Zmax: double;
begin
  Result:=FZmax
end;

function TView.Get_Zmin: double;
begin
  Result:=FZmin
end;

procedure TView.Set_CX(Value: double);
begin
  Set_FieldValue(ord(vCentralPointX), Value)
end;

procedure TView.Set_CY(Value: double);
begin
  Set_FieldValue(ord(vCentralPointY), Value)
end;

procedure TView.Set_CZ(Value: double);
begin
  Set_FieldValue(ord(vCentralPointZ), Value)
end;

procedure TView.Set_Dmax(Value: double);
begin
  Set_FieldValue(ord(vDmax), Value);
end;

procedure TView.Set_Dmin(Value: double);
begin
  Set_FieldValue(ord(vDmin), Value);
end;

procedure TView.Set_RevScaleX(Value: double);
begin
  Set_FieldValue(ord(vRevScaleX), Value);
end;

procedure TView.Set_RevScaleY(Value: double);
begin
  Set_FieldValue(ord(vRevScaleY), Value);
end;

procedure TView.Set_CurrX0(Value: double);
begin
  Set_FieldValue(ord(vCurrX), Value)
end;

procedure TView.Set_CurrY0(Value: double);
begin
  Set_FieldValue(ord(vCurrY), Value)
end;

procedure TView.Set_CurrZ0(Value: double);
var
  Document:IDMDocument;
  Server:IDataModelServer;
  Flag:boolean;
begin
  if DataModel<>nil then begin
    Document:=DataModel.Document as IDMDocument;
    Flag:=not (DataModel.IsLoading or
       DataModel.IsCopying or
       DataModel.IsExecuting or
       DataModel.InUndoRedo or
       ((DataModel.State and dmfLongOperation)<>0))
  end else
    Flag:=False;

  Set_FieldValue(ord(vCurrZ), Value);

  if Flag then begin
    if FCurrZ>FZmax then
      Set_Zmax(FCurrZ)
    else
    if FCurrZ<FZmin then
      Set_Zmin(FCurrZ)
    else
      Flag:=False;
  end;

  if Flag then begin
    Server:=Document.Server;
    Server.RefreshDocument(rfFrontBack);
  end;
end;

procedure TView.Set_Zmax(Value: double);
var
  Document:IDMDocument;
  Server:IDataModelServer;
  Flag:boolean;
begin
  Document:=DataModel.Document as IDMDocument;
  Flag:=not (DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     DataModel.InUndoRedo or
     ((DataModel.State and dmfLongOperation)<>0));

  Set_FieldValue(ord(vZmax), Value);
  if Flag then begin
    if FCurrZ>FZmax then
      Set_CurrZ0(FZmax)
    else
      Flag:=False;
  end;

  if Flag then begin
    Server:=Document.Server;
    Server.RefreshDocument(rfFrontBack);
  end;
end;

procedure TView.Set_Zmin(Value: double);
var
  Document:IDMDocument;
  Server:IDataModelServer;
  Flag:boolean;
begin
  Document:=DataModel.Document as IDMDocument;
  Flag:=not (DataModel.IsLoading or
     DataModel.IsCopying or
     DataModel.IsExecuting or
     DataModel.InUndoRedo or
     ((DataModel.State and dmfLongOperation)<>0));

  Set_FieldValue(ord(vZmin), Value);
  if Flag then begin
    if FCurrZ<FZmin then
      Set_CurrZ0(FZmin)
    else
      Flag:=False;
  end;

  if Flag then begin
    Server:=Document.Server;
    Server.RefreshDocument(rfFrontBack);
  end;

end;

function TView.Get_RevScale: double;
begin
  Result:=FRevScaleX;
end;

function TView.PointIsVisible(X, Y, Z: double; Tag:integer): WordBool;
var
  D0:double;
begin
  Result:=False;
  case Tag of
   1: Result:=(Z>=FZmin)and(Z<=FZmax);
   2:begin
       D0:=Y*FcosZ+X*FsinZ;
       Result:=(D0>=FDmin)and(D0<=FDmax)
     end;
  end;
end;

procedure TView.Duplicate(const aView: IView);
begin
  Set_CX(aView.CX);
  Set_CY(aView.CY);
  Set_CZ(aView.CZ);
  Set_CurrX0(aView.CurrX0);
  Set_CurrY0(aView.CurrY0);
  Set_CurrZ0(aView.CurrZ0);
  Set_RevScaleX(aView.RevScaleX);
  Set_RevScaleY(aView.RevScaleY);
  Set_RevScaleZ(aView.RevScaleZ);
  Set_Zangle(aView.Zangle);
  Set_Zmin(aView.Zmin);
  Set_Zmax(aView.Zmax);
  Set_Dmin(aView.Dmin);
  Set_Dmax(aView.Dmax);
end;

function TView.Get_RevScaleZ: double;
begin
  Result:=FRevScaleZ
end;

procedure TView.Set_RevScaleZ(Value: double);
begin
  Set_FieldValue(ord(vRevScaleZ), Value);
end;

function TView.Get_Tangle: double;
begin
  Result:=FTangle
end;

procedure TView.Set_Tangle(Value: double);
begin
  FTangle:=Value;
  FcosT:=cos(FTangle*PI/180);
  FsinT:=sin(FTangle*PI/180);
end;

function TView.Get_cosT: double;
begin
  Result:=FcosT
end;

function TView.Get_sinT: double;
begin
  Result:=FsinT
end;

procedure TView.SetFieldValue(Code: integer; Value: OleVariant);
//var
//  OperationManager:IDMOperationManager;
begin
{
  if (DataModel.Document=nil) or
     DataModel.IsLoading or
     DataModel.IsExecuting or
     DataModel.InUndoRedo then
}
    SetFieldValue_(Code, Value)
{
  else begin
    OperationManager:=DataModel.Document as IDMOperationManager;
    OperationManager.ChangeFieldValue(
         Self as IDMElement, Code, True, Value);
  end
}
end;

{ TViews }

function TView.Get_StoredParam: integer;
begin
  Result:=FStoredParam
end;
procedure TView.Set_StoredParam(Value: integer);
begin
  Set_FieldValue(ord(vStoredParam), Value);
end;

class function TViews.GetElementClass: TDMElementClass;
begin
  Result:=TView;
end;

function TViews.Get_ClassAlias(Index:integer): WideString;
begin
  Result:=rsView;
end;

class function TViews.GetElementGUID: TGUID;
begin
  Result:=IID_IView;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TView.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
