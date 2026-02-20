unit GroundObstacleU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DelayElementU;

type
  TGroundObstacle=class(TDelayElement, IGroundObstacle, IWidthIntf)
  private
    FWidth:double;
  protected

    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Set_Ref(const Value:IDMElement); override; safecall;

    function  ShowInLayerName: WordBool; override; safecall; safecall;
    function Get_Width:double; safecall;
  end;

  TGroundObstacles=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index: integer): WideString; override; safecall;
  end;

implementation

uses
  FacilityModelConstU;

var
  FFields:IDMCollection;

{ TGroundObstacle }

class function TGroundObstacle.GetClassID: integer;
begin
  Result:=_GroundObstacle;
end;

class function TGroundObstacle.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TGroundObstacle.MakeFields0;
begin
  inherited;
  AddField(rsWidth, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cnstWidth), 0, pkInput);
end;

function TGroundObstacle.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(cnstWidth):
    Result:=FWidth;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TGroundObstacle.SetFieldValue(Code: integer; Value: OleVariant);
var
  Painter:IUnknown;
begin
  case Code of
  ord(cnstWidth):
    begin
      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (not DataModel.IsCopying) and
         (Parent<>nil) then begin
        Painter:=(DataModel.Document as ISMDocument).PainterU;
        Parent.Draw(Painter, -1)
      end;

      FWidth:=Value;
      if (DataModel<>nil) and
         (not DataModel.IsLoading) and
         (not DataModel.IsCopying) and
         (Parent<>nil) then begin
        if Selected then
          Parent.Draw(Painter, 1)
        else
          Parent.Draw(Painter, 0)
      end;
    end;
  else
    inherited;
  end;
end;

procedure TGroundObstacle.Set_Ref(const Value: IDMElement);
begin
  inherited;
end;

function TGroundObstacle.ShowInLayerName: WordBool;
begin
  Result:=True
end;

function TGroundObstacle.Get_Width: double;
begin
  Result:=FWidth;
end;

{ TGroundObstacles }

class function TGroundObstacles.GetElementClass: TDMElementClass;
begin
  Result:=TGroundObstacle;
end;

function TGroundObstacles.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsGroundObstacle;
end;

class function TGroundObstacles.GetElementGUID: TGUID;
begin
  Result:=IID_IGroundObstacle;
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TGroundObstacle.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
