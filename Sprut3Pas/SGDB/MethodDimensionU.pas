unit MethodDimensionU;

interface
uses
  SysUtils, DMElementU, DataModel_TLB, SgdbLib_TLB;

type
  TMethodDimension=class(TDMArrayDimension, IMethodDimension)
  private
    FSourceKind: Integer;
    FCode: Integer;
    FKind: Integer;
    FCurrentValueIndex:integer;

  protected
    class function  GetClassID:integer; override;
    function  GetFieldValue(Index: integer): OleVariant; override; safecall;
    procedure SetFieldValue(Index: integer; Value: OleVariant); override; safecall;
    class function GetFields:IDMCollection; override;
    class procedure MakeFields0; override;

    function  Get_SourceKind: Integer; safecall;
    function  Get_Kind: Integer; safecall;
    function  Get_Code: Integer; safecall;
    function  Get_CurrentValueIndex:integer; safecall;
    procedure Set_CurrentValueIndex(Value:integer); safecall;

    procedure Initialize; override;
  end;

  TMethodDimensions=class(TDMCollection)
  protected
    class function GetElementClass:TDMElementClass; override;
    class function GetElementGUID:TGUID; override;
    function       Get_ClassAlias(Index:integer): WideString; override; safecall;
  end;
  
implementation
uses
  MethodDimItemU,
  SafeguardDatabaseConstU;

var
  FFields:IDMCollection;
  
{ TMethodDimension }

class function TMethodDimension.GetClassID: integer;
begin
  Result:=_sgMethodDimension
end;

class function TMethodDimension.GetFields: IDMCollection;
begin
  Result:=FFields
end;

function TMethodDimension.Get_Code: Integer;
begin
  Result:=FCode
end;

function TMethodDimension.Get_SourceKind: Integer;
begin
  Result:=FSourceKind
end;

procedure TMethodDimension.Initialize;
begin
  inherited;
  FDimItems:=TMethodDimItems.Create(Self as IDMElement) as IDMCollection
end;

class procedure TMethodDimension.MakeFields0;
var
  S:WideString;
  j:integer;
begin
  inherited;
  S:='|'+rsSafeguardElementParam+
     '|'+rsSafeguardElementKindParam+
     '|'+rsWarriorGroupParam+
     '|'+rsFinishPointParam+
     '|'+rsBoundaryParam+
     '|'+rsBoundaryLayerParam+
     '|'+rsZoneParam+
     '|'+rsControlDeviceParam+
     '|'+rsControlDeviceKindParam+
     '|'+rsMethodParam;
  AddField(rsMethodDimensionSourceKind, S, '', '',
                 fvtChoice, 0, 0, 0,
                 0, 0, pkInput);
  S:='|'+rsAthorityType+           //0
     '|'+rsSkillLevel+             //1
     '|'+rsHasToolType+            //2
     '|'+rsToolKind+               //3
     '|'+rsHasVehicleType+         //4
     '|'+rsVehicleKInd+            //5
     '|'+rsHasWeaponType+          //6
     '|'+rsWeaponKind+             //7
     '|'+rsHasAccess+              //8
     '|'+rsFieldValueInterval+     //9
     '|'+rsFieldValue+             //10
     '|'+rsGuardOrTV+              //11
     '|'+rsAlarmSignal+            //12
     '|'+rsAlarmSignalSafety+      //13
     '|'+rsOvercomeTime+           //14
     '|'+rsTechnicalService+       //15
     '|'+rsBarrierMaterial+        //16
     '|'+rsDetectionZoneSize+      //17
     '|'+rsAdversaryCount+         //18
     '|'+rsSafeguardElevation+     //19
     '|'+rsDetectionSector+        //20
     '|'+rsDistance+               //21
     '|'+rsCommunication+          //22
     '|'+rsPostDefence+            //23
     '|'+rsTime+                   //24
     '|'+rsMineLength+             //25
     '|'+rsTVMonitorCount+         //26
     '|'+rsWeight+                 //27
     '|'+rsProhibition+            //28
     '|'+rsKindID+                 //29
     '|'+rsSize+                   //30
     '|'+rsHasMetall+              //31
     '|'+rsPersonalCount+          //32
     '|'+rsSensorAccessControl+    //33
     '|'+rsRamEnabled;             //34
  AddField(rsMethodDimensionKind, S, '', 'C',
                 fvtChoice, 0, 0, 0,
                 1, 0, pkInput);
  AddField(rsMethodDimensionCode, '', '', 'C',
                 fvtInteger, 0, 0, 0,
                 2, 0, pkInput);
  AddField(rsSubArrayIndex, '', '', 'C',
                 fvtInteger, 0, 0, 0,
                 3, 0, pkInput);
end;

function TMethodDimension.GetFieldValue(Index: integer): OleVariant;
begin
  case Index of
  0: Result:=FSourceKind;
  1: Result:=FKind;
  2: Result:=FCode;
  3: Result:=FSubArrayIndex;
  else
     Result:=inherited GetFieldValue(Index);
  end;
end;

procedure TMethodDimension.SetFieldValue(Index: integer;
  Value: OleVariant);
begin
  case Index of
  0: FSourceKind:=Value;
  1: FKind:=Value;
  2: FCode:=Value;
  3: begin
       FSubArrayIndex:=Value;
       if not DataModel.IsLoading then
         SetNextDimensionIndexes;
     end;
  else
     inherited
  end;
end;

function TMethodDimension.Get_Kind: Integer;
begin
  Result:=FKind
end;

function TMethodDimension.Get_CurrentValueIndex: integer;
begin
  Result:=FCurrentValueIndex
end;

procedure TMethodDimension.Set_CurrentValueIndex(Value: integer);
begin
  FCurrentValueIndex:=Value
end;

{ TMethodDimensions }

function TMethodDimensions.Get_ClassAlias(Index: integer): WideString;
begin
  Result:=rsMethodDimension
end;

class function TMethodDimensions.GetElementClass: TDMElementClass;
begin
  Result:=TMethodDimension
end;

class function TMethodDimensions.GetElementGUID: TGUID;
begin
  Result:=IID_IDMArrayDimension
end;

initialization
  FFields:=TDMFields.Create(nil) as IDMCollection;
  TMethodDimension.MakeFields;
finalization
  (FFields as IDMCollection2).Clear;
  FFields:=nil;
end.
