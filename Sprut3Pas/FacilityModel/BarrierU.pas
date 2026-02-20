unit BarrierU;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB,
  DelayElementU;

type
  TBarrier=class(TDelayElement, IBarrier, IWidthIntf)
  private
    FAccessControl:boolean;
    FKeyStorage:integer;
    FWidth:double;
  protected
    procedure Set_Parent(const Value: IDMElement);override; safecall;
    function DoCalcDelayTime(const OvercomeMethodE:IDMElement):double; override;
    function Get_Width:double; safecall;
    function Get_AccessControl:WordBool; safecall;

    class function  GetClassID:integer; override;
    function  GetFieldValue(Code: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Code: integer; Value: OleVariant); override; safecall;
    function  FieldIsVisible(Code: integer):WordBool; override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    procedure Set_Ref(const Value:IDMElement); override; safecall;

    function Get_IsTransparent:WordBool; safecall;
    function CalcAttenuation(const PhysicalField:IDMElement):double; safecall;
    function  ShowInLayerName: WordBool; override; safecall; safecall;

    procedure Initialize; override;
  end;

  TBarriers=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function Get_ClassAlias(Index: integer):WideString; override;
  end;

implementation

uses
  FacilityModelConstU,
  CalcDelayTimeLib;

var
  FFields:IDMCollection;

{ TBarrier }

function TBarrier.CalcAttenuation(const PhysicalField: IDMElement): double;
var
  BarrierKind:IBarrierKind;
  Ec:double;
begin
  BarrierKind:=(Ref as IBarrierKind);
  Ec:=BarrierKind.Ec;
  if Ec<>-InfinitValue then
    Result:=Ec
  else
    Result:=0
end;

function TBarrier.DoCalcDelayTime(const OvercomeMethodE:IDMElement):double;
var
  Elevation:double;
  Volume:IVolume;
  Area:IArea;
  OvercomeMethod:IOvercomeMethod;
  WarriorGroupE:IDMElement;
  AdversaryGroup:IAdversaryGroup;
  FacilityModelS:IFMState;
  LockKind:ILockKind;
  WarriorGroup:IWarriorGroup;
  BoundaryE:IDMElement;
begin
  OvercomeMethod:=OvercomeMethodE as IOvercomeMethod;
  Result:=0;
  if OvercomeMethod=nil then Exit;

  FacilityModelS:=DataModel as IFMState;
  WarriorGroupE:=FacilityModelS.CurrentWarriorGroupU as IDMElement;

  case OvercomeMethod.DelayProcCode of
  dpcEc:
    begin
      Result:=CalcDelayTimeByEc(WarriorGroupE,
                      OvercomeMethod, (Ref as IBarrierKind).Ec);
    end;
  dpcCriminalEc:
    Result:=CalcDelayTimeByEc(WarriorGroupE,
                      OvercomeMethod, (Ref as ILockKind).CriminalEc);
  dpcUseKey:
    begin
      LockKind:=Ref as ILockKind;
      if WarriorGroupE.ClassID=_AdversaryGroup then begin
        AdversaryGroup:=WarriorGroupE as IAdversaryGroup;
        if AdversaryGroup.Locks.IndexOf(Self as IDMElement)<>-1 then
          Result:=LockKind.OpeningTime
        else
          Result:=InfinitValue/1000
      end else begin
        WarriorGroup:=WarriorGroupE as IWarriorGroup;
        BoundaryE:=Parent.Parent;
        if WarriorGroup.GetAccessType(BoundaryE, True)<>0 then
          Result:=2
        else
          Result:=InfinitValue/1000
      end;
    end;
   dpcCodeMatrix:
     begin
       Result:=inherited DoCalcDelayTime(OvercomeMethodE);
       if (Ref.Parent as IModelElementType).TypeID<100 then
         Result:=Result*60;
     end;
  else
    Result:=inherited DoCalcDelayTime(OvercomeMethodE);
  end;

  if Parent.Parent.ClassID<>_Boundary then Exit;

  Area:=Parent.Parent.SpatialElement as IArea;
  if Area=nil then Exit;
  if Area.IsVertical then Exit;
  if FacilityModelS.CurrentNodeDirection=pdFrom0To1 then Exit;    //всегда С0.Z>C1.Z

  Volume:=Area.Volume1;

  if Volume=nil then Exit;

  Elevation:=Volume.MaxZ-Volume.MinZ;

  if Elevation<=1 then Exit;
  if Elevation>4000 then
    Result:=InfinitValue
  else
    Result:=Result*exp((Elevation/100-1)*0.35)  //  *2 при 3 м, *4 при 5 м
end;

class function TBarrier.GetClassID: integer;
begin
  Result:=_Barrier;
end;

function TBarrier.Get_IsTransparent: WordBool;
begin
  try
  Result:=False;
  if Ref=nil then Exit;
  Result:=(Ref as IBarrierKind).IsTransparent;
  except
    raise
  end;  
end;

procedure TBarrier.Set_Parent(const Value: IDMElement);
begin
  inherited;
  if DataModel.IsLoading then Exit;
  if Parent=nil then Exit;
  Parent.Update;
  if Parent.Parent=nil then Exit;
  Parent.Parent.Update;
end;

class function TBarrier.GetFields: IDMCollection;
begin
  Result:=FFields
end;

class procedure TBarrier.MakeFields0;
var
  S:WideString;
begin
  inherited;
  AddField(rsLockAccessControl, '', '', '',
                 fvtBoolean, 0, 0, 0,
                 ord(bpAccessControl), 0, pkInput);
  S:='|'+rsKeyInControledRoom+
     '|'+rsKeyAtPerson+
     '|'+rsKeyInDefendedRoom;
  AddField(rsKeyStorage, S, '', '',
                 fvtChoice, 0, 0, 0,
                 ord(lpKeyStorage), 0, pkInput);
  AddField(rsElevation, '%6.2f', '', '',
                 fvtFloat, 0, 0, InfinitValue,
                 ord(bpElevation), 0, pkInput);
  AddField(rsWidth, '%0.0f', '', '',
                 fvtFloat, 0, 0, 0,
                 ord(cnstWidth), 0, pkInput);
end;

function TBarrier.GetFieldValue(Code: integer): OleVariant;
begin
  case Code of
  ord(bpAccessControl):
    Result:=FAccessControl;
  ord(bpKeyStorage):
    Result:=FKeyStorage;
  ord(bpElevation):
    Result:=FElevation;
  ord(cnstWidth):
    Result:=FWidth;
  else
    Result:=inherited GetFieldValue(Code);
  end;
end;

procedure TBarrier.SetFieldValue(Code: integer; Value: OleVariant);
var
  Painter:IUnknown;
begin
  case Code of
  ord(bpAccessControl):
    FAccessControl:=Value;
  ord(bpKeyStorage):
    FKeyStorage:=Value;
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
  ord(bpElevation):
    FElevation:=Value;
  else
    inherited;
  end;
end;  

function TBarrier.Get_Width: double;
begin
  Result:=FWidth
end;

procedure TBarrier.Set_Ref(const Value: IDMElement);
begin
  inherited;
  if Value=nil then Exit;
  FWidth:=(Value as IBarrierKind).DefaultWidth
end;

function TBarrier.Get_AccessControl: WordBool;
begin
  Result:=FAccessControl
end;

function TBarrier.FieldIsVisible(Code: integer): WordBool;
var
  BarrierKind:IBarrierKind;
begin
  case Code of
  ord(bpAccessControl),
  ord(bpKeyStorage):
    begin
      BarrierKind:=Ref as IBarrierKind;
      if BarrierKind<>nil then
        Result:=BarrierKind.ContainLock
      else
        Result:=False
    end;
  ord(bpElevation):
    begin
      BarrierKind:=Ref as IBarrierKind;
      if BarrierKind<>nil then
        Result:=BarrierKind.UseElevation
      else
        Result:=False
    end;
  else
    Result:=inherited FieldIsVisible(Code)
  end;
end;

function TBarrier.ShowInLayerName: WordBool;
begin
  Result:=True
end;

procedure TBarrier.Initialize;
begin
  inherited;
  FSymbolScaleFactor:=1;
end;

{ TBarriers }

class function TBarriers.GetElementClass: TDMElementClass;
begin
  Result:=TBarrier;
end;

function TBarriers.Get_ClassAlias(Index:integer): WideString;
begin
  if Index<akImenitM then
    Result:=rsBarrier
  else
    Result:=rsBarriers
end;

class function TBarriers.GetElementGUID: TGUID;
begin
  Result:=IID_IBarrier
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TBarrier.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
