unit DataClassModelU;

interface
uses
  DMElementU, DataModel_TLB, SgdbLib_TLB, Variants;

type

  TDataClassModel=class(TDMElement, IDataClassModel, IDataModel)
  private
    FSafeguardClasses:IDMCollection;
    procedure MakeSafeguardClasses;
  protected
// реализация интерфейса IDataModel
    function  Get_GenerationCount: Integer; safecall;
    function  Get_Generation(Index: Integer): IDMElement; safecall;
    procedure BuildGenerations(Mode:integer; const aElement: IDMElement); safecall;
    function  Get_RootObjectCount(Mode:integer): Integer; virtual; safecall;
    procedure GetRootObject(Mode, RootIndex: Integer; out RootObject: IUnknown;
                            out RootObjectName: WideString; out aOperations: Integer;
                            out aLinkType: Integer); virtual; safecall;
    function  Get_Document: IUnknown; safecall;
    procedure Set_Document(const Value: IUnknown); safecall;
    function  Get_NextID(aClassID: Integer): Integer; safecall;
    procedure Set_NextID(aClassID: Integer; Value: Integer); safecall;
    function  Get_IsDestroying: WordBool; safecall;
    function  Get_IsLoading: WordBool; safecall;
    function  Get_IsSaving: WordBool; safecall;
    function  Get_IsExecuting: WordBool; safecall;
    function  Get_InUndoRedo: WordBool; safecall;
    function  Get_IsCopying: WordBool; safecall;
    function  Get_IsChanging: WordBool; safecall;
    procedure LoadedFromDataBase(const aDatabaseU: IUnknown);virtual;  safecall;
    function Get_SubModel(Index: integer): IDataModel; virtual; safecall;
    procedure AfterMoveInCollection(const aCollection:IDMCollection); safecall;
    function Get_ApplicationVersion:WideString; safecall;
    procedure Set_ApplicationVersion(const Value:WideString); safecall;

    function Import(const FileName:WideString):integer; safecall;
    function GetDefaultParent(ClassID:integer): IDMElement; safecall;
    function GetDefaultElement(ClassID:integer): IDMElement; virtual; safecall;
    function Get_Errors:IDMCollection; virtual; safecall;
    function Get_Warnings:IDMCollection; virtual; safecall;
    procedure BeforePaste; safecall;
    procedure AfterPaste; safecall;

    procedure SaveToDatabase(const aDatabaseU: IUnknown); safecall;
    procedure LoadFromDataBase(const aDatabaseU: IUnknown); safecall;
    function  CreateCollection(aClassID:integer; const aParent:IDMElement): IDMCollection; safecall;
    function  CreateElement(aClassID:integer): IDMElement; safecall;
    procedure RemoveElement(const aElement:IDMElement); safecall;
    function  Get_BackRefHolders: IDMCollection;safecall;
    function Get_EmptyBackRefHolder:IDMElement; safecall;
    procedure Set_EmptyBackRefHolder(const Value: IDMElement); safecall;
    function  GetDefaultName(const aRef: IDMElement): WideString; safecall;
    function  Get_IndexCollection(Index: Integer): IDMCollection; safecall;

    function  Get_CollectionCount: Integer; override; safecall;
    function  Get_Collection(Index: Integer): IDMCollection; override; safecall;
    procedure Init; safecall;
    function  Get_States: IDMCollection; safecall;
    function  Get_CurrentState: IDMElement; safecall;
    procedure Set_CurrentState(const Value: IDMElement); safecall;
    function  Get_Analyzer: IDMAnalyzer; safecall;
    procedure Set_Analyzer(const Value: IDMAnalyzer); safecall;
    procedure CheckErrors; safecall;
    procedure CorrectErrors; safecall;
    function Get_Report: IDMText; virtual; safecall;
    function GetElementCollectionCount(const aElement: IDMElement): Integer; virtual; safecall;
    function GetElementFieldVisible(const aElement: IDMElement; Code: Integer): WordBool; virtual; safecall;
//  защищенные методы
    procedure Initialize; override;
    procedure _Destroy; override;
    function Get_XXXRefCount:integer; safecall;
    procedure Set_XXXRefCount(Value:integer); safecall;
    procedure HandleError(const ErrorMessage:WideString); safecall;
  end;

implementation
uses
  SafeguardClassU;

{ TDataClassModel }

procedure TDataClassModel.Initialize;
begin
  inherited;
  FSafeguardClasses:=TSafeguardClasses.Create(Self as IDMElement) as IDMCollection;

  MakeSafeguardClasses;
  ID:=8;
end;

procedure TDataClassModel.MakeSafeguardClasses;

  procedure MakeSafeguardClass(TypeClassID, SpatialElementKind:integer;
                               OptionalSpatialElement:boolean; aID:integer);
  var
    SafeguardClassE:IDMElement;
    SafeguardClass:ISafeguardClass;
    Collection:IDMCollection;
    SafeguardElementTypes:ISafeguardElementTypes;
  begin
    SafeguardClassE:=(FSafeguardClasses as IDMCollection2).CreateElement(False);
    SafeguardClass:=SafeguardClassE as ISafeguardClass;
    (FSafeguardClasses as IDMCollection2).Add(SafeguardClassE);
    SafeguardClass.TypeClassID:=TypeClassID;
    SafeguardClass.SpatialElementKind:=SpatialElementKind;
    SafeguardClass.OptionalSpatialElement:=OptionalSpatialElement;
    SafeguardClassE.ID:=aID;
//    SafeguardClassE.ID:=NextID;
//    inc(NextID);

    if TypeClassID=-1 then Exit;
    Collection:=(DataModel as IDMElement).Collection[TypeClassID];
    if Collection.QueryInterface(ISafeguardElementTypes, SafeguardElementTypes)=0 then
      SafeguardElementTypes.SafeguardClass:=SafeguardClass;
  end;

begin
  //NextID:=0;
  MakeSafeguardClass(_GuardPostType, 2, False, 0);               //0
  MakeSafeguardClass(_BarrierType, 1, True, 1);                  //1
  MakeSafeguardClass(-1, -1, False, 2);                        //2
  MakeSafeguardClass(_LockType, 0, True, 3);                     //3
  MakeSafeguardClass(_UndergroundObstacleType, 1, True, 4);      //4
  MakeSafeguardClass(_SurfaceSensorType, 2, True, 5);            //5
  MakeSafeguardClass(_PositionSensorType, 1, True, 6);           //6
  MakeSafeguardClass(_ContrabandSensorType, 1, True, 7);         //7
  MakeSafeguardClass(_AccessControlType, 1, True, 8);            //8
  MakeSafeguardClass(_VolumeSensorType, 1, True, 9);             //9
  MakeSafeguardClass(_BarrierSensorType, 1, True, 10);            //10
  MakeSafeguardClass(_TVCameraType, 1, True, 11);                 //11
  MakeSafeguardClass(_LightDeviceType, 2, True, 12);              //12
  MakeSafeguardClass(_CommunicationDeviceType, 0, True, 13);            //13
  MakeSafeguardClass(_PowerSourceType, 0, False, 14);             //14
  MakeSafeguardClass(-1, -1, False, 15);                          //15
  MakeSafeguardClass(_CabelType, 1, False, 16);                   //16
  MakeSafeguardClass(-1, -1, False, 17);              //17
  MakeSafeguardClass(_JumpType, -1, True, 18);         //18
  MakeSafeguardClass(_LocalPointObjectType, 0, False, 19);        //19
  MakeSafeguardClass(_TargetType, 0, False, 20);                  //20
  MakeSafeguardClass(_StartPointType, 0, False, 21);              //21

  MakeSafeguardClass(_PerimeterSensorType, 1, True, 23);          //23
  MakeSafeguardClass(_GroundObstacleType, 1, True, 24);           //24
  MakeSafeguardClass(_FenceObstacleType, 1, True, 25);            //25
  MakeSafeguardClass(_ControlDeviceType, 0, False, 26);              //26

  MakeSafeguardClass(_ActiveSafeguardType, 2, True, 22);          //22

end;

procedure TDataClassModel.LoadFromDataBase(const aDatabaseU: IUnknown);
begin
  (FSafeguardClasses as IDMCollection2).LoadedFromDatabase(aDataBaseU)
end;

procedure TDataClassModel.SaveToDatabase(const aDatabaseU: IUnknown);
var
  j:integer;
  aRecordSetU:IUnknown;
begin
  aRecordSetU:=(FSafeguardClasses as IDMCollection2).MakeParentsTable(aDataBaseU);
  for j:=0 to FSafeguardClasses.Count-1 do
    FSafeguardClasses.Item[j].SaveParentsToRecordSet(aRecordSetU)
end;

function TDataClassModel.Get_Document: IUnknown;
begin
  Result:=nil
end;

function TDataClassModel.Get_InUndoRedo: WordBool;
begin
  Result:=False
end;

function TDataClassModel.Get_IsExecuting: WordBool;
begin
  Result:=False
end;

function TDataClassModel.Get_IsLoading: WordBool;
begin
  Result:=False
end;

function TDataClassModel.Get_NextID(aClassID: Integer): Integer;
begin
  Result:=-1
end;

function TDataClassModel.Get_RootObjectCount(Mode:integer): Integer;
begin
  Result:=0
end;

procedure TDataClassModel.GetRootObject(Mode, RootIndex: Integer;
  out RootObject: IUnknown; out RootObjectName: WideString;
  out aOperations, aLinkType: Integer);
begin
  RootObject:=null;
  RootObjectName:='';
  aOperations:=0;
  aLinkType:=0;
end;

procedure TDataClassModel.LoadedFromDataBase(const aDatabaseU: IUnknown);
begin
end;

procedure TDataClassModel.Set_Document(const Value: IUnknown);
begin
end;

procedure TDataClassModel.Set_NextID(aClassID, Value: Integer);
begin
end;

procedure TDataClassModel._Destroy;
begin
  inherited;
  FSafeguardClasses:=nil;
end;

function TDataClassModel.Get_Collection(Index: Integer): IDMCollection;
begin
  Result:=FSafeguardClasses
end;

function TDataClassModel.Get_CollectionCount: Integer;
begin
  Result:=1
end;

function TDataClassModel.Get_SubModel(Index: integer): IDataModel;
begin
  case Index of
  -1: Result:=Self;
   0: Result:=DataModel;
  else
    begin
      if DataModel<>nil then
        Result:=DataModel.SubModel[Index]
      else
        Result:=nil
    end
  end;
end;

function TDataClassModel.Get_IsSaving: WordBool;
begin
  Result:=False
end;

function TDataClassModel.CreateElement(aClassID: integer): IDMElement;
begin
  Result:=nil
end;

procedure TDataClassModel.RemoveElement(const aElement: IDMElement);
begin
end;

function TDataClassModel.Get_IsCopying: WordBool;
begin
  Result:=False
end;

procedure TDataClassModel.Init;
begin
end;

function TDataClassModel.Get_CurrentState: IDMElement;
begin
  Result:=nil
end;

function TDataClassModel.Get_States: IDMCollection;
begin
  Result:=nil
end;

procedure TDataClassModel.Set_CurrentState(const Value: IDMElement);
begin
end;

procedure TDataClassModel.BuildGenerations(Mode:integer; const aElement: IDMElement);
begin
end;

function TDataClassModel.Get_Generation(Index: Integer): IDMElement;
begin
  Result:=nil
end;

function TDataClassModel.Get_GenerationCount: Integer;
begin
  Result:=0
end;

function TDataClassModel.Get_Analyzer: IDMAnalyzer;
begin
  Result:=nil
end;

procedure TDataClassModel.Set_Analyzer(const Value: IDMAnalyzer);
begin
end;

function TDataClassModel.Import(const FileName:WideString): integer;
begin
  Result:=0;
end;

function TDataClassModel.GetDefaultParent(ClassID: integer): IDMElement;
begin
  Result:=nil
end;

procedure TDataClassModel.CorrectErrors;
begin
end;

function TDataClassModel.Get_Errors: IDMCollection;
begin
  Result:=nil
end;

function TDataClassModel.Get_BackRefHolders: IDMCollection;
begin
  Result:=nil
end;

function TDataClassModel.Get_IsDestroying: WordBool;
begin
  Result:=False
end;

function TDataClassModel.Get_Report: IDMText;
begin
  Result:=nil
end;

function TDataClassModel.GetDefaultElement(ClassID: integer): IDMElement;
begin
  Result:=nil
end;

function TDataClassModel.GetDefaultName(
  const aRef: IDMElement): WideString;
begin
   Result:=aRef.Name
end;

function TDataClassModel.Get_IsChanging: WordBool;
begin
  Result:=False
end;

function TDataClassModel.Get_IndexCollection(
  Index: Integer): IDMCollection;
begin
  Result:=nil
end;

procedure TDataClassModel.AfterPaste;
begin

end;

procedure TDataClassModel.BeforePaste;
begin

end;

function TDataClassModel.Get_EmptyBackRefHolder: IDMElement;
begin
  Result:=nil
end;

procedure TDataClassModel.Set_EmptyBackRefHolder(const Value: IDMElement);
begin

end;

function TDataClassModel.CreateCollection(
  aClassID: integer; const aParent:IDMElement): IDMCollection;
begin
  Result:=nil
end;

function TDataClassModel.Get_XXXRefCount: integer;
begin

end;

procedure TDataClassModel.Set_XXXRefCount(Value: integer);
begin

end;

procedure TDataClassModel.HandleError(const ErrorMessage: WideString);
begin
end;

procedure TDataClassModel.CheckErrors;
begin
end;

procedure TDataClassModel.AfterMoveInCollection(
  const aCollection: IDMCollection);
begin
end;

function TDataClassModel.Get_Warnings: IDMCollection;
begin
  Result:=nil
end;

function TDataClassModel.GetElementCollectionCount(
  const aElement: IDMElement): Integer;
begin
   Result:=aElement.CollectionCount
end;

function TDataClassModel.GetElementFieldVisible(const aElement: IDMElement;
  Code: Integer): WordBool;
begin
   Result:=aElement.FieldIsVisible(Code)
end;

function TDataClassModel.Get_ApplicationVersion: WideString;
begin
  Result:='';
end;

procedure TDataClassModel.Set_ApplicationVersion(const Value: WideString);
begin
end;

end.
