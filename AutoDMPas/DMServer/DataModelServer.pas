unit DataModelServer;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_ComObj, DM_ActiveX, DM_AxCtrls, DM_Windows,
  Classes, Dialogs, SysUtils, Forms,
  DataModel_TLB, DMServer_TLB, DMComObjectU,
  DMTransactionU, StdVcl, MyDB;

var
  FDrawThreadBuisy:boolean=False;

function GetDMServerClassObject:IDMClassFactory;

type
  TDMServerFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;

  EWrongPasswordException=class(EDM_OleException)
  end;

  TAnalysisThread = class(TThread)
  private
    FAnalyzer:IDMAnalyzer;
    FMode:integer;
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  published
    constructor CreateIt(aAnalyzer:IDMAnalyzer;
                         aMode:integer);
  end;

  TDataModelServer = class;

  TDrawThread = class(TThread)
  private
    FServer:TDataModelServer;
  protected
    procedure Execute; override;
    procedure DoTerminate; override;
  published
    constructor CreateIt(aServer:TDataModelServer);
    destructor Destroy; override;
  end;

  TDataModelServer = class(TDMComObject,
//  TDataModelServer = class(TDM_AutoObject, //IDM_ConnectionPointContainer,
                           IDataModelServer,
                           IDMCopyBuffer, IDMXML)
  private
//    FConnectionPoint: TDM_ConnectionPoint;
//    FSinkList: TList;
//    FEvents: IDataModelServerEvents;
    FEvents: IDMServerEvents;

    FDocuments: TList;
    FCurrentDocumentIndex:integer;

    FDataModelAlias: WideString;
    FDataModelFileExt: WideString;

    FClassFactory:IDM_ClassFactory;
    FDataModelFactory:IDMClassFactory;

    FDocumentClassFactory:IDM_ClassFactory;
    FDocumentFactory:IDMClassFactory;

    FAnalyzerClassFactory:IDM_ClassFactory;
    FAnalyzerFactory:IDMClassFactory;

//    FClassFactory:IClassFactory;
//    FDocumentClassFactory:IClassFactory;
//    FAnalyzerClassFactory:IClassFactory;

    FProgID:string;
    FDocumentProgID:string;
    FAnalyzerProgID: string;
    FEventData1: Variant;
    FEventData2: Variant;
    FEventData3: Variant;

    FCopyBuffer:TList;
    FLastCopy:TList;
    FAnalysisThread:TAnalysisThread;
    FDrawThread:TDrawThread;

    FInitialDir:WideString;

    FUseAnalysisThread:boolean;

    FXMLFile:TextFile;
    FXMLLevel:integer;

    function DoLoadDataModelFromXML(const FileName:WideString;
                                    const aDataModelU:IUnknown):boolean;
    function DoLoadDataModel(const FileName, Password: WideString;
                             const aDataModelU:IUnknown):boolean;
    procedure ClearCopyBuffer;
    function CreateDocument:IDMDocument;
    procedure OnAnalysisThreadTerminate(Sender:TObject);
    procedure OnDrawThreadTerminate(Sender:TObject);
  public
    procedure Initialize; override;
    destructor Destroy; override;
  protected

// реализация интерфейса IConnectionPointContainer;
//    FConnectionPoints: TDM_ConnectionPoints;
//    property ConnectionPoints: TDM_ConnectionPoints read FConnectionPoints
//      implements IDM_ConnectionPointContainer;
//      implements IConnectionPointContainer;

//    procedure EventSinkChanged(const EventSink: IUnknown); override;

// реализация интерфейса IDataModelServer
    function  Get_ProgID: WideString; safecall;
    procedure Set_ProgID(const Value: WideString); safecall;
    function  Get_DocumentProgID: WideString; safecall;
    procedure Set_DocumentProgID(const Value: WideString); safecall;
    function Get_AnalyzerProgID: WideString; safecall;
    procedure Set_AnalyzerProgID(const Value: WideString); safecall;

    function  Get_DataModelAlias: WideString; safecall;
    procedure Set_DataModelAlias(const Value: WideString); safecall;
    function  Get_DataModelFileExt: WideString; safecall;
    procedure Set_DataModelFileExt(const Value: WideString); safecall;
    function Get_CurrentDocumentIndex: Integer; safecall;
    function Get_Document(Index: Integer): IDMDocument; safecall;
    function Get_DocumentCount: Integer; safecall;
    procedure CloseAll; safecall;
    procedure CloseCurrentDocument; safecall;
    procedure Set_CurrentDocumentIndex(Value: Integer); safecall;
    procedure CreateNewDataModel(const RefDataModel: IUnknown); safecall;
    function LoadDataModel(const FileName, Password: WideString;
      const RefDataModelU: IUnknown): WordBool; safecall;
    procedure DoSaveDataModelToXML(const FileName: WideString; const aDataModelU:IUnknown); safecall;
    procedure DoSaveDataModel(const FileName, Password: WideString; const aDataModelU:IUnknown); safecall;
    procedure SaveDataModel(const FileName: WideString); safecall;
    procedure ExportDataModel(const FileName: WideString; ExportMode: Integer); safecall;
    procedure ImportDataModel(const FileName: WideString; ImportMode_: Integer); safecall;
    procedure DocumentOperation(const DMElement, DMCollection: IUnknown;
      DMOperation, nItemIndex: Integer); safecall;
    function Get_CurrentDocument: IDMDocument; safecall;
    procedure OpenDocument; safecall;
    procedure SelectionChanged(const Element: IUnknown); safecall;
    procedure RefreshDocument(FlagSet: Integer); safecall;
    procedure ChangeCurrentObject(const Obj, DMForm: IUnknown); safecall;
    function Get_EventData1: OleVariant; safecall;
    function Get_EventData2: OleVariant; safecall;
    procedure CallRefDialog(const DMClassCollections, RefSource: IUnknown;
      const Suffix: WideString; AskName: WordBool); safecall;
    procedure CallDialog(Mode: Integer; const Caption, Prompt: WideString);
      safecall;
    procedure Set_EventData1(Value: OleVariant); safecall;
    procedure Set_EventData2(Value: OleVariant); safecall;

    // реализация интерфейса IDMCopyBuffer
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Paste(const ParentElementU, CollectionU: IUnknown;
      aLinkType: Integer; DoPaste: WordBool; out CanPaste: WordBool);
      safecall;
    function Get_EventData3: OleVariant; safecall;
    procedure Set_EventData3(Value: OleVariant); safecall;
    procedure SetControlState(ControlIndex, Index, Mode, State: Integer);
      safecall;
    procedure OperationStepExecuted; safecall;
    procedure StartAnalysis(Mode: Integer); safecall;
    procedure StopAnalysis; safecall;
    procedure NextAnalysisStage(const StageName: WideString; Stage,
      StepCount: Integer); safecall;
    procedure NextAnalysisStep(Step: Integer); safecall;
    function Get_Buffer(Index: Integer): IUnknown; safecall;
    function Get_BufferCount: Integer; safecall;
    function Get_LastCopy(Index: Integer): IUnknown; safecall;
    function Get_LastCopyCount: Integer; safecall;
    function Get_InitialDir: WideString; safecall;
    procedure Set_InitialDir(const Value: WideString); safecall;
    procedure NextLoadStage(const StageName: WideString; Stage,
      StepCount: Integer); safecall;
    procedure RefreshElement(const ElementU: IUnknown); safecall;
    function Get_Events: IDMServerEvents; safecall;
    procedure Set_Events(const Value: IDMServerEvents); safecall;
    procedure AnalysisError(const ErrorMessage: WideString); safecall;
    function Get_UseAnalysisThread: WordBool; safecall;
    procedure Set_UseAnalysisThread(Value: WordBool); safecall;
    function Get_DataModelFactoryU: IUnknown; safecall;
    procedure Set_DataModelFactoryU(const Value: IUnknown); safecall;
    function Get_AnalyzerFactoryU: IUnknown; safecall;
    procedure Set_AnalyzerFactoryU(const Value: IUnknown); safecall;

//IDMXML
    procedure WriteXMLLine(const S: WideString); safecall;
    procedure IncLevel; safecall;
    procedure DecLevel; safecall;
  public
  end;

implementation

uses
  DataModelServerConsts, DMOperationU, SyncObjs;

var
  CriticalSection:TCriticalSection;

procedure TDataModelServer.StartAnalysis(Mode: Integer);
var
  Unk:IUnknown;
  aDocument:IDMDocument;
  NewAnalyzer, OldAnalyzer:IDMAnalyzer;
  aDataModel:IDataModel;
begin
  if (FAnalyzerClassFactory=nil) and
     (FAnalyzerFactory=nil) then Exit;

  aDocument:=Get_CurrentDocument;
  if aDocument=nil then Exit;
  OldAnalyzer:=aDocument.Analyzer as IDMAnalyzer;

  aDataModel:=aDocument.DataModel as IDataModel;
  aDataModel.State:=aDataModel.State or dmfExecuting;

  if FUseAnalysisThread then begin
    if Mode>=0 then begin
      if FAnalyzerClassFactory<>nil then
        FAnalyzerClassFactory.CreateInstance(nil, IUnknown, Unk)
      else
        Unk:=FAnalyzerFactory.CreateInstance;

      NewAnalyzer:=Unk as IDMAnalyzer;
      NewAnalyzer.PrevAnalyzer:=OldAnalyzer as IUnknown;
      aDocument.Analyzer:=Unk;
      FAnalysisThread:=TAnalysisThread.CreateIt(NewAnalyzer, Mode);
    end else
      FAnalysisThread:=TAnalysisThread.CreateIt(OldAnalyzer, Mode);
    FAnalysisThread.OnTerminate:=OnAnalysisThreadTerminate;
    FAnalysisThread.Suspended:=False;
  end else begin                      // без потока (обычно при отдалке)
    if Mode>=0 then begin
      if FAnalyzerClassFactory<>nil then
        FAnalyzerClassFactory.CreateInstance(nil, IUnknown, Unk)
      else
        Unk:=FAnalyzerFactory.CreateInstance;

      NewAnalyzer:=Unk as IDMAnalyzer;
      NewAnalyzer.PrevAnalyzer:=OldAnalyzer as IUnknown;
      aDocument.Analyzer:=Unk;
      NewAnalyzer.Start(Mode);
    end else
      OldAnalyzer.Start(Mode);
 end;
end;

{
procedure TDataModelServer.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IDataModelServerEvents;
  if FConnectionPoint <> nil then
     FSinkList := FConnectionPoint.SinkList;
end;
}

procedure TDataModelServer.Initialize;
begin
  inherited Initialize;

  FDocuments:=TList.Create;
  FDataModelAlias:='DataModel';
  FDataModelFileExt:='mdb';
  FCurrentDocumentIndex:=-1;
  
  FUseAnalysisThread:=False;

  FCopyBuffer:=TList.Create;
  FLastCopy:=TList.Create;
end;

{ TDataModelServer }

procedure TDataModelServer.CreateNewDataModel(
  const RefDataModel: IUnknown);
var
  Unk:IUnknown;
  aDocument:IDMDocument;
  DataModelE:IDMElement;
  aDataModel:IDataModel;
  OldState:integer;
begin
  if FClassFactory<>nil then
    FClassFactory.CreateInstance(nil, IUnknown, Unk)
  else
  if FDataModelFactory<>nil then
    Unk:=FDataModelFactory.CreateInstance
  else
    Exit;  

  DataModelE:=Unk as IDMElement;
  DataModelE.Ref:=RefDataModel as IDMElement;
  DataModelE.Name:=rsNewModel;
  aDataModel:=DataModelE as IDataModel;
  aDocument:=CreateDocument;
  FDocuments.Add(pointer(aDocument));

  aDocument.DataModel:=DataModelE as IDataModel;

  OldState:=aDataModel.State;
  try
    (aDocument.DataModel as IDataModel).Init;
  finally
    aDataModel.State:=OldState;
  end;

  aDocument.Server:=Self as IDataModelServer;
  FCurrentDocumentIndex:=FDocuments.Count-1;
  aDocument._AddRef;

  OpenDocument;

  if FAnalyzerClassFactory<>nil then
    FAnalyzerClassFactory.CreateInstance(nil, IUnknown, Unk)
  else
  if FAnalyzerFactory<>nil then
    Unk:=FAnalyzerFactory.CreateInstance
  else
    Exit;
  aDocument.Analyzer:=Unk;
  
  aDataModel.State:=aDataModel.State and not dmfNotEmpty;
  aDataModel.State:=aDataModel.State and not dmfModified;

end;

procedure TDataModelServer.ExportDataModel(const FileName: WideString; ExportMode: Integer);
begin
end;

procedure TDataModelServer.ImportDataModel(const FileName: WideString; ImportMode_: Integer);
begin
end;

function TDataModelServer.LoadDataModel(const FileName,
  Password: WideString; const RefDataModelU: IUnknown): WordBool;
var
  Unk:IUnknown;
  aDocument:IDMDocument;
  DataModelE:IDMElement;
  aDataModel:IDataModel;
begin
  aDocument:=Get_CurrentDocument;
  if (aDocument<>nil) then begin
    aDataModel:=aDocument.DataModel as IDataModel;
    if ((aDataModel.State and dmfNotEmpty)=0) then
      CloseCurrentDocument;
  end;

  if FClassFactory<>nil then
    FClassFactory.CreateInstance(nil, IUnknown, Unk)
  else
  if FDataModelFactory<>nil then
    Unk:=FDataModelFactory.CreateInstance
  else
    Exit;

  DataModelE:=Unk as IDMElement;
  DataModelE.Ref:=RefDataModelU as IDMElement;
  aDocument:=CreateDocument;
  aDocument.DataModel:=Unk as IDataModel;
  aDocument.Server:=Self as IDataModelServer;
  FDocuments.Add(pointer(aDocument));
  FCurrentDocumentIndex:=FDocuments.Count-1;
  if FAnalyzerClassFactory<>nil then begin
    FAnalyzerClassFactory.CreateInstance(nil, IUnknown, Unk);
    aDocument.Analyzer:=Unk;
  end else
  if FAnalyzerFactory<>nil then begin
    Unk:=FAnalyzerFactory.CreateInstance;
    aDocument.Analyzer:=Unk;
  end;
  aDocument._AddRef;

  aDocument.Password:=Password;

  try
    if Uppercase(ExtractFileExt(FileName))='.XML' then
      Result:=DoLoadDataModelFromXML(FileName, DataModelE)
    else
      Result:=DoLoadDataModel(FileName, Password, DataModelE);
  except
    on E: EWrongPasswordException do begin
      ShowMessage(E.Message);
      Result:=False
    end;
  end;

  if Result then
    OpenDocument
  else begin
    FDocuments.Delete(FCurrentDocumentIndex);
    aDocument._Release;
    FCurrentDocumentIndex:=FDocuments.Count-1;
  end;
end;

procedure TDataModelServer.SaveDataModel(const FileName: WideString);
var
  aDocument:DMDocument;
  aDataModel:IDataModel;
begin
  aDocument:=Get_CurrentDocument;
  aDataModel:=aDocument.DataModel as IDataModel;
  if UpperCase(ExtractFileExt(FileName))='.XML' then begin
    DoSaveDataModelToXML(FileName, aDataModel);
  end else begin
    DoSaveDataModel(FileName, aDocument.Password, aDataModel);
  end;

//   CallDialog(sdmShowMessage, '',
//     'В демонстрационной версии программы "Спрут_ИСТА" сохранение модели не возможно');

end;

destructor TDataModelServer.Destroy;
begin
  inherited;
  
  FEvents:=nil;

  CloseAll;
  FDocuments.Free;

  ClearCopyBuffer;
  FCopyBuffer.Free;
  FLastCopy.Free;

  FClassFactory:=nil;
  FDataModelFactory:=nil;
end;

procedure TDataModelServer.ClearCopyBuffer;
var
  aElement:IDMElement;
begin
  while FCopyBuffer.Count>0 do begin
    aElement:=IDMElement(FCopyBuffer[FCopyBuffer.Count-1]);
    aElement._Release;
    FCopyBuffer.Delete(FCopyBuffer.Count-1);
  end;
end;

function TDataModelServer.DoLoadDataModel(const FileName, Password: WideString;
                                          const aDataModelU:IUnknown):boolean;

var
  aDataBaseU:IUnknown;
  DatabaseFileName:WideString;
  Options, ReadOnly, Connect: OleVariant;
  aDataModel:IDataModel;
  PWD:array[0..255] of char;
begin
  aDataModel:=aDataModelU as IDataModel;
  Result:=False;

  Options:=0;
  ReadOnly:=False;
  StrPCopy(PWD, Password);
  if PWD='' then
    Connect:=''
  else
    Connect:=';PWD='+PWD;
  DatabaseFileName:=FileName;
  if FileExists(DatabaseFileName) then begin
    MyDBInitEngine;
    aDataBaseU:=MyDBOpenDataBase(DatabaseFileName,
                     Options, ReadOnly, Connect);

    if aDataBaseU=nil then Exit;
  end else
    Raise Exception.Create(Format('Error! File %s dosen''t exist',
                                  [DatabaseFileName]));
  try

  (aDataModel as IDMElement).Name:=FileName;  // предваритеольное указание имени для
                                              // информационной панели

  aDataModel.State:=aDataModel.State or dmfLoading;
  aDataModel.LoadFromDatabase(aDataBaseU);
  aDataModel.State:=aDataModel.State or dmfNotEmpty;
  aDataModel.LoadedFromDatabase(aDataBaseU);
  aDataModel.State:=aDataModel.State and not dmfLoading;

  (aDataModel as IDMElement).Name:=FileName;   // сохраняется имя с путем,
                                               // откуда взят файл

  (aDataModel as IDMElement).AfterLoading1;
  (aDataModel as IDMElement).AfterLoading2;

  Result:=True;
  finally
    MyDBCloseDataBase(aDataBaseU);
    MyDBCloseEngine;

    NextLoadStage('', -1, -1);

    aDataModel.State:=aDataModel.State and not dmfLoading;
  end;

end;

procedure TDataModelServer.DoSaveDataModel(const FileName, Password: WideString;
                                           const aDataModelU:IUnknown);
var
  aDataModel:IDataModel;
  aDataBaseU:IUnknown;
  Connect:WideString;
  DatabaseFileName:WideString;
  BakFileName:string;
  S:string;
  j:integer;
begin
  aDataModel:=aDataModelU as IDataModel;
  if Password<>'' then
    Connect:=';LANGID=0x0409;CP=1252;COUNTRY=0;pwd='+Password
  else
    Connect:=';LANGID=0x0409;CP=1252;COUNTRY=0';

  DatabaseFileName:='DMDocument_DataModel.tmp';
  if FileExists(DatabaseFileName) then
    DeleteFile(DatabaseFileName);

  MyDBInitEngine;
  aDataBaseU:=MyDBCreateDataBase(DatabaseFileName, Connect);

  (aDataModel as IDMElement).Name:=FileName;

  Set_EventData3(0);
  CallDialog(sdmPleaseWait, '', 'Запись данных в файл');
  try
  aDataModel.State:=aDataModel.State or dmfCopying;
  aDataModel.SaveToDatabase(aDataBaseU);
  aDataModel.State:=aDataModel.State and not dmfModified and not dmfCopying;
  finally
  Set_EventData3(-1);
  CallDialog(sdmPleaseWait, '', '');
  end;

  MyDBCloseDataBase(aDataBaseU);
  MyDBCloseEngine;

  if FileExists(FileName) then begin
    S:=ExtractFileName(FileName);
    j:=Pos('.', S);
    S:=System.Copy(S, 1, j-1);
    BakFileName:=ExtractFilePath(FileName)+S+'.bak';
    if FileExists(BakFileName) then
      DeleteFile(BakFileName);
    RenameFile(FileName, BakFileName);
  end;
  RenameFile(DatabaseFileName, FileName);
end;

function TDataModelServer.Get_ProgID: WideString;
begin
  Result:=FProgID
end;

type
  TGetDMClassFactory=function:IDMClassFactory;

procedure TDataModelServer.Set_ProgID(const Value: WideString);
var
  H:HMODULE;
  F:TGetDMClassFactory;
  LibName:array[0..255] of Char;
begin
  FProgID:=Value;

  if Pos('.dll', Value)<>0 then begin
    StrPCopy(LibName, Value);
    H:=DM_LoadLibrary(LibName);
    @F:=DM_GetProcAddress(H, 'GetDataModelClassObject');
    FDataModelFactory:=F;
  end else
    DM_CoGetClassObject(DM_ProgIDToClassID(Value), FClassFactory)
end;

procedure TDataModelServer.CloseAll;
var
  j:integer;
  aDocument:IDMDocument;
  aDataModel:IDataModel;
begin
  try
  for j:=0 to Get_DocumentCount-1 do begin
    aDocument:=Get_Document(j);
    aDataModel:=aDocument.DataModel as IDataModel;
    aDataModel.State:=aDataModel.State or dmfCommiting;
    aDocument.ClearSelection(nil);
    aDocument.ClearPrevSelection(True);
    (aDocument.DataModel as IDMElement).Clear;
    aDocument.DataModel:=nil;
    aDocument._Release;
  end;
  FDocuments.Clear;
  
  FCurrentDocumentIndex:=-1;

  if FEvents<>nil then
    FEvents.OnCloseDocument;
  except
    raise
  end;    
end;


function TDataModelServer.Get_DataModelAlias: WideString;
begin
  Result:=FDataModelAlias
end;

function TDataModelServer.Get_DataModelFileExt: WideString;
begin
  Result:=FDataModelFileExt
end;

procedure TDataModelServer.Set_DataModelAlias(const Value: WideString);
begin
  FDataModelAlias:=Value
end;

procedure TDataModelServer.Set_DataModelFileExt(const Value: WideString);
begin
  FDataModelFileExt:=Value
end;

function TDataModelServer.Get_CurrentDocumentIndex: Integer;
begin
  Result:=FCurrentDocumentIndex
end;

function TDataModelServer.Get_Document(Index: Integer): IDMDocument;
begin
  if Index<FDocuments.Count then
    Result:=IDMDocument(FDocuments[Index])
  else
    Result:=nil
end;

function TDataModelServer.Get_DocumentCount: Integer;
begin
  Result:=FDocuments.Count
end;

procedure TDataModelServer.CloseCurrentDocument;
var
  aDocument:IDMDocument;
  j:integer;
  aDataModel:IDataModel;
begin
  if FCurrentDocumentIndex=-1 then Exit;

  aDocument:=Get_Document(FCurrentDocumentIndex);
  if aDocument=nil then Exit;
  aDataModel:=aDocument.DataModel as  IDataModel;

  j:=0;
  while j<FCopyBuffer.Count do begin
    if IDMElement(FCopyBuffer[j]).DataModel=aDocument.DataModel then
      FCopyBuffer.Delete(j)
    else
      inc(j)
  end;
  j:=0;
  while j<FLastCopy.Count do begin
    if IDMElement(FLastCopy[j]).DataModel=aDocument.DataModel then
      FLastCopy.Delete(j)
    else
      inc(j)
  end;

  if (aDataModel.State and dmfAuto)=0 then begin
    aDataModel.State:=aDataModel.State or dmfCommiting;
    aDocument.ClearSelection(nil);
    aDocument.ClearPrevSelection(True);
    (aDocument.DataModel as IDMElement).Clear;
    aDataModel.State:=aDataModel.State and not dmfCommiting;
  end else
    (aDocument.DataModel as IDataModel).Document:=nil;


  aDocument.DataModel:=nil;
  aDocument._Release;
  FDocuments.Delete(FCurrentDocumentIndex);
  FCurrentDocumentIndex:=FDocuments.Count-1;

  if FEvents<>nil then
    FEvents.OnCloseDocument;
end;

procedure TDataModelServer.Set_CurrentDocumentIndex(Value: Integer);
begin
  FCurrentDocumentIndex:=Value
end;

procedure TDataModelServer.Copy;
var
  j:integer;
  aElement:IDMElement;
  aDocument:IDMDocument;
begin
  aDocument:=Get_CurrentDocument;
  if aDocument.SelectionCount>0 then begin
    ClearCopyBuffer;
    for j:=0 to aDocument.SelectionCount-1 do begin
      aElement:=aDocument.SelectionItem[j] as IDMElement;
      aElement._AddRef;
      FCopyBuffer.Add(pointer(aElement));
    end;
    aDocument.ClearSelection(nil);
  end
end;

procedure TDataModelServer.Cut;
begin

end;

procedure TDataModelServer.Paste(const ParentElementU,
  CollectionU: IUnknown; aLinkType: Integer; DoPaste: WordBool;
  out CanPaste: WordBool);
var
  ParentElement:IDMElement;
  Collection:IDMCollection;
  aElement, SourceElement:IDMElement;
  OperationManager:IDMOperationManager;
  aDocument:IDMDocument;
  j:integer;
  Collection2:IDMCollection2;
  aElementU:IUnknown;
  DestDataModel:IDataModel;
begin
  ParentElement:=ParentElementU as IDMElement;
  Collection:=CollectionU as IDMCollection;
  CanPaste:=False;
  if FCopyBuffer.Count=0 then Exit;

  while FLastCopy.Count>0 do begin
    aElement:=IDMElement(FLastCopy[FLastCopy.Count-1]);
    aElement._Release;
    FLastCopy.Delete(FLastCopy.Count-1);
  end;

  aDocument:=Get_CurrentDocument;
  DestDataModel:=aDocument.DataModel as IDataModel;
  DestDataModel.BeforePaste;
  if aDocument.SelectionCount=0 then begin
    if ParentElement=nil then Exit;
    if Collection=nil then Exit;
    SourceElement:=IDMElement(FCopyBuffer[0]);
    if Collection.QueryInterface(IDMCollection2, Collection2)=0 then begin
      if not Collection2.CanContain(SourceElement) then Exit;
    end else begin
      if Collection.Count=0 then Exit;
      if Collection.Item[0].ClassID<>SourceElement.ClassID then Exit;
    end;
    if DoPaste then begin // Добавление в коллекцию из буфера
      OperationManager:=aDocument as IDMOperationManager;
      OperationManager.StartTransaction(Collection, leoPaste, rsPaste);
      for j:=0 to FCopyBuffer.Count-1 do begin
        SourceElement:=IDMElement(FCopyBuffer[j]);
        OperationManager.PasteToCollection(
           ParentElementU,
           SourceElement as IUnknown,
           CollectionU,
           aLinkType,
           aElementU);
           aElement:=aElementU as IDMElement;
         aElement._AddRef;
         FLastCopy.Add(pointer(aElement))
      end;
      DestDataModel.AfterPaste;
      OperationManager.FinishTransaction(aElement as IUnknown,
        CollectionU, leoPaste);
    end;
  end else begin
    if FCopyBuffer.Count>1 then
      Exit
    else begin
      aElement:=aDocument.SelectionItem[0] as IDMElement;
      SourceElement:=IDMElement(FCopyBuffer[0]);
      if (aElement.DataModel as IDMElement).ID<>
         (SourceElement.DataModel as IDMElement).ID then Exit;
      if (SourceElement.Ref<>nil) and
         (SourceElement.Ref.SpatialElement=SourceElement) then begin
        SourceElement:=SourceElement.Ref;
      end;
      if (aElement.Ref<>nil) and
         (aElement.Ref.SpatialElement=aElement) then begin
        aElement:=aElement.Ref;
      end;
      if aElement.ClassID<>SourceElement.ClassID then Exit;
      if DoPaste then begin // Замена свойств выделенных элементов
        OperationManager:=aDocument as IDMOperationManager;
        OperationManager.StartTransaction(Collection, leoPaste, rsPaste);
        for j:=0 to aDocument.SelectionCount-1 do begin
           aElement:=aDocument.SelectionItem[j] as IDMElement;
          if (aElement.Ref<>nil) and
             (aElement.Ref.SpatialElement=aElement) then
            aElement:=aElement.Ref;
          OperationManager.PasteToElement( SourceElement, aElement, False, False);
          aElement.AfterCopyFrom2;
        end;
        DestDataModel.AfterPaste;
        OperationManager.FinishTransaction(aElement, Collection, leoPaste);
      end;
    end;
  end;
  CanPaste:=True;
end;

function TDataModelServer.Get_CurrentDocument: IDMDocument;
begin
  if FCurrentDocumentIndex<>-1 then
    Result:=Get_Document(FCurrentDocumentIndex)
  else
    Result:=nil
end;

procedure TDataModelServer.DocumentOperation(const DMElement,
  DMCollection: IUnknown; DMOperation, nItemIndex: Integer);
begin
  if FEvents<>nil then
    FEvents.OnDocumentOperation(DMElement, DMCollection, DMOperation, nItemIndex)
end;

function TDataModelServer.Get_DocumentProgID: WideString;
begin
  Result:=FProgID
end;

procedure TDataModelServer.Set_DocumentProgID(const Value: WideString);
var
  H:HMODULE;
  F:TGetDMClassFactory;
  LibName:array[0..255] of Char;
begin
  FDocumentProgID:=Value;

  if Pos('.dll', Value)<>0 then begin
    StrPCopy(LibName, Value);
    H:=DM_LoadLibrary(LibName);
    @F:=DM_GetProcAddress(H, 'GetDMDocumentClassObject');
    FDocumentFactory:=F;
  end else
    DM_CoGetClassObject(DM_ProgIDToClassID(Value), FDocumentClassFactory);
end;

function TDataModelServer.CreateDocument: IDMDocument;
var
  Unk:IUnknown;
begin
  if FDocumentClassFactory<>nil then
    FDocumentClassFactory.CreateInstance(nil, IUnknown, Unk)
  else
    Unk:=FDocumentFactory.CreateInstance;
    
  Result:=Unk as IDMDocument;
end;

procedure TDataModelServer.OpenDocument;
begin
  if FEvents<>nil then
    FEvents.OnOpenDocument;
end;

procedure TDataModelServer.RefreshDocument(FlagSet: Integer);
begin
//(*
  try
  if FEvents<>nil then
    FEvents.OnRefreshDocument(FlagSet and not rfBack);
  except
    raise
  end;
//*)
  try
  if FDrawThreadBuisy then Exit;
  except
    raise
  end;

  try
//(*
  if (FlagSet and rfBack)<>0 then begin
//*)
    FDrawThread:=TDrawThread.CreateIt(Self as TDataModelServer);
    FDrawThread.OnTerminate:=OnDrawThreadTerminate;
    FDrawThread.Suspended:=False;
//(*
  end;
//*)
  except
    raise
  end;
end;

procedure TDataModelServer.SelectionChanged(const Element: IUnknown);
begin
  if FEvents<>nil then
    FEvents.OnSelectionChanged(Element);
end;

procedure TDataModelServer.CallRefDialog(const DMClassCollections,
  RefSource: IUnknown; const Suffix: WideString; AskName: WordBool);
begin
  if FEvents<>nil then
    FEvents.OnCallRefDialog(DMClassCollections,
                            RefSource, Suffix, AskName);
end;

function TDataModelServer.Get_EventData1: OleVariant;
begin
  Result:=FEventData1
end;

function TDataModelServer.Get_EventData2: OleVariant;
begin
  Result:=FEventData2
end;

procedure TDataModelServer.Set_EventData1(Value: OleVariant);
begin
  FEventData1:=Value
end;

procedure TDataModelServer.Set_EventData2(Value: OleVariant);
begin
  FEventData2:=Value
end;

function TDataModelServer.Get_EventData3: OleVariant;
begin
  Result:=FEventData3
end;

procedure TDataModelServer.Set_EventData3(Value: OleVariant);
begin
  FEventData3:=Value
end;

procedure TDataModelServer.SetControlState(ControlIndex, Index, Mode,
  State: Integer);
begin
  if FEvents<>nil then
    FEvents.OnSetControlState(ControlIndex, Index, Mode, State);
end;

procedure TDataModelServer.OperationStepExecuted;
begin
  if FEvents<>nil then
    FEvents.OnOperationStepExecuted;
end;

function TDataModelServer.Get_AnalyzerProgID: WideString;
begin
  Result:=FAnalyzerProgID
end;

procedure TDataModelServer.Set_AnalyzerProgID(const Value: WideString);
var
  H:HMODULE;
  F:TGetDMClassFactory;
  LibName:array[0..255] of Char;
begin
  FAnalyzerProgID:=Value;

  if Pos('.dll', Value)<>0 then begin
    StrPCopy(LibName, Value);
    H:=DM_LoadLibrary(LibName);
    @F:=DM_GetProcAddress(H, 'GetDataModelClassObject');
    FAnalyzerFactory:=F;
  end else
    DM_CoGetClassObject(DM_ProgIDToClassID(Value), FAnalyzerClassFactory);
end;

procedure TDataModelServer.StopAnalysis;
var
  aDocument:IDMDocument;
  aDataModel:IDataModel;
begin
  aDocument:=Get_CurrentDocument;
  aDataModel:=aDocument.DataModel as  IDataModel;
  aDataModel.State:=aDataModel.State and not dmfExecuting;
  (aDocument.Analyzer as IDMAnalyzer).Stop;
  if FEvents<>nil then
    FEvents.OnStopAnalysis;
end;

procedure TDataModelServer.NextAnalysisStage(const StageName: WideString;
  Stage, StepCount: Integer);
begin
  if FEvents<>nil then
    FEvents.OnNextAnalysisStage(StageName, Stage, StepCount);
end;

procedure TDataModelServer.NextAnalysisStep(Step: Integer);
begin
  if FEvents<>nil then
    FEvents.OnNextAnalysisStep(Step);
end;

constructor TAnalysisThread.CreateIt(aAnalyzer:IDMAnalyzer;
                                     aMode:integer);
begin
  inherited Create(true);
  FAnalyzer:=aAnalyzer;
  FMode:=aMode;
  FAnalyzer.Mode:=aMode;
  FreeOnTerminate := True;
  Suspended := True;
end;

procedure TAnalysisThread.DoTerminate;
begin
  if Assigned(OnTerminate) then OnTerminate(Self);
end;

procedure TAnalysisThread.Execute; // Main execution for AnalysisThread
begin
  try
    FAnalyzer.Start(FMode);
  except
    on E:EAbort do begin
    end;
  end;
end;

procedure TDataModelServer.CallDialog(Mode: Integer; const Caption,
  Prompt: WideString);
begin
  if FEvents<>nil then
    FEvents.OnCallDialog(Mode, Caption, Prompt);
  RefreshDocument(rfFast);
end;

procedure TDataModelServer.ChangeCurrentObject(const Obj,
  DMForm: IUnknown);
begin
  if FEvents<>nil then
    FEvents.OnChangeCurrentObject(Obj, DMForm);
end;

function TDataModelServer.Get_Buffer(Index: Integer): IUnknown;
begin
  Result:=IDMElement(FCopyBuffer[Index]) as IUnknown
end;

function TDataModelServer.Get_BufferCount: Integer;
begin
  Result:=FCopyBuffer.Count
end;

function TDataModelServer.Get_LastCopy(Index: Integer): IUnknown;
begin
  Result:=IDMElement(FLastCopy[Index]) as IUnknown
end;

function TDataModelServer.Get_LastCopyCount: Integer;
begin
  Result:=FLastCopy.Count
end;

function TDataModelServer.Get_InitialDir: WideString;
begin
  Result:=FInitialDir
end;

procedure TDataModelServer.Set_InitialDir(const Value: WideString);
begin
  FInitialDir:=Value
end;

procedure TDataModelServer.NextLoadStage(const StageName: WideString;
  Stage, StepCount: Integer);
begin
  if FEvents<>nil then
    FEvents.OnNextLoadStage(StageName, Stage, StepCount);
end;

procedure TDataModelServer.RefreshElement(const ElementU: IUnknown);
begin
  if FEvents<>nil then
    FEvents.OnRefreshElement(ElementU);
end;

procedure TDataModelServer.OnAnalysisThreadTerminate(Sender: TObject);
var
  AnalysisThread:TAnalysisThread;
  Text:WideString;
begin
  AnalysisThread:=TAnalysisThread(Sender);
  Text:=AnalysisThread.FAnalyzer.ErrorDescription;
  if Text<>'' then
    CallDialog(2, 'Ошибка', Text+#13)

end;

procedure TDataModelServer.OnDrawThreadTerminate(Sender: TObject);
begin
//  FDrawThreadBuisy:=False;
end;

function TDataModelServer.Get_DataModelFactoryU: IUnknown;
begin
  Result:=FDataModelFactory
end;

procedure TDataModelServer.Set_DataModelFactoryU(const Value: IUnknown);
begin
  FDataModelFactory:=Value as IDMClassFactory
end;

function TDataModelServer.Get_AnalyzerFactoryU: IUnknown;
begin
  Result:=FAnalyzerFactory
end;

procedure TDataModelServer.Set_AnalyzerFactoryU(const Value: IUnknown);
begin
  FAnalyzerFactory:=Value as IDMClassFactory
end;

function TDataModelServer.DoLoadDataModelFromXML(const FileName: WideString;
                                                 const aDataModelU:IUnknown): boolean;
var
  aDataModelXML:IDataModelXML;
  XMLFileName:WideString;
  BakFileName:string;
  S, S0, S1, SS:string;
  j, m, L:integer;
  TagFlag, DelimeterFound:boolean;
  Delimeter:Char;
  aDataModelE:IDMElement;
  aDataModel:IDataModel;
begin
  aDataModel:=aDataModelU as IDataModel;
  Result:=False;

  if FileExists(FileName) then begin
    AssignFile(FXMLFile, FileName);
    Reset(FXMLFile);
  end else
    Raise Exception.Create(Format('Error! File %s dosen''t exist',
                                  [FileName]));
  try
  aDataModelXML:=aDataModel as IDataModelXML;
  aDataModelE:=aDataModel as IDMElement;
  aDataModelE.Name:=FileName;  // предварительное указание имени для
                                              // информационной панели
  aDataModel.State:=aDataModel.State or dmfLoading;

  S0:='';
  TagFlag:=False;
  Delimeter:='<';
  DelimeterFound:=False;
  while not EOF(FXMLFile) do begin
    readln(FXMLFile, S);
    while S<>'' do begin
      m:=Pos(Delimeter, S);
      if m>0 then begin
        if m>1 then begin
          SS:=System.Copy(S, 1, m-1);
        end else
          SS:='';
        S0:=S0+SS;
        S0:=trim(S0);
        if S0<>'' then
          aDataModelXML.ProcessXMLString(S0, TagFlag);
        L:=length(S);
        if m<L then
          S:=System.Copy(S, m+1, L-m)
        else
          S:='';
        S0:='';

        TagFlag:=not TagFlag;
        if TagFlag then
          Delimeter:='>'
        else
          Delimeter:='<';
      end else begin
        S0:=S0+S;
        break;
      end;
    end;
  end;

  aDataModel.State:=aDataModel.State or dmfNotEmpty;
  aDataModelE.Loaded;
  aDataModel.State:=aDataModel.State and not dmfLoading;

  aDataModelE.Name:=FileName;   // сохраняется имя с путем,
                                               // откуда взят файл
  aDataModelE.AfterLoading1;
  aDataModelE.AfterLoading2;

  Result:=True;
  finally

    CloseFile(FXMLFile);

    NextLoadStage('', -1, -1);

    aDataModel.State:=aDataModel.State and not dmfLoading;
  end;
end;

procedure TDataModelServer.DoSaveDataModelToXML(const FileName: WideString;
                                                const aDataModelU:IUnknown);
var
  aDataModel:IDataModel;
  aXML:IDMXML;
  XMLFileName:WideString;
  BakFileName:string;
  S:string;
  j:integer;
begin
  aDataModel:=aDataModelU as IDataModel;

  XMLFileName:='DMDocument_DataModel.tmp';
  if FileExists(XMLFileName) then
    DeleteFile(XMLFileName);

  AssignFile(FXMLFile, XMLFileName);
  Rewrite(FXMLFile);
  aXML:=Self as IDMXML;

  (aDataModel as IDMElement).Name:=FileName;

  Set_EventData3(0);
  CallDialog(sdmPleaseWait, '', 'Запись данных в файл');
  try
  aDataModel.State:=aDataModel.State or dmfCopying;

  writeln(FXMLFile, '<?xml version="1.0" encoding="Windows-1251"?>');
  (aDataModel as IDMElementXML).WriteToXML(aXML, True);

  aDataModel.State:=aDataModel.State and not dmfModified and not dmfCopying;

  finally
  Set_EventData3(-1);
  CallDialog(sdmPleaseWait, '', '');
  end;

  CloseFile(FXMLFile);

  if FileExists(FileName) then begin
    S:=ExtractFileName(FileName);
    j:=Pos('.', S);
    S:=System.Copy(S, 1, j-1);
    BakFileName:=ExtractFilePath(FileName)+S+'.bak';
    if FileExists(BakFileName) then
      DeleteFile(BakFileName);
    RenameFile(FileName, BakFileName);
  end;
  RenameFile(XMLFileName, FileName);
end;

procedure TDataModelServer.DecLevel;
begin
  dec(FXMLLevel)
end;

procedure TDataModelServer.IncLevel;
begin
  inc(FXMLLevel)
end;

procedure TDataModelServer.WriteXMLLine(const S: WideString);
var
  S1:string;
  j:integer;
begin
  S1:='';
  for j:=0 to FXMLLevel-1 do
    S1:=S1+'  ';
  S1:=S1+S;
  writeln(FXMLFile, S1)
end;

{ TDrawThread }

constructor TDrawThread.CreateIt(aServer:TDataModelServer);
begin
  inherited Create(true);
  FServer:=aServer;
  FreeOnTerminate := True;
  Suspended := True;

  CriticalSection.Enter;
  FDrawThreadBuisy:=True;
  CriticalSection.Leave;
end;

destructor TDrawThread.Destroy;
begin
  inherited;

  CriticalSection.Enter;
  FDrawThreadBuisy:=False;
  CriticalSection.Leave;
end;

procedure TDrawThread.DoTerminate;
begin
  if Assigned(OnTerminate) then OnTerminate(Self);
end;

procedure TDrawThread.Execute;
begin
  if FServer.FEvents<>nil then
    FServer.FEvents.OnRefreshDocument(rfFront);
(*
   FServer.FEvents.OnRefreshDocument(rfBack);
*)
end;

function TDataModelServer.Get_Events: IDMServerEvents;
begin
  Result:=FEvents
end;

procedure TDataModelServer.Set_Events(const Value: IDMServerEvents);
begin
  FEvents:=Value
end;

procedure TDataModelServer.AnalysisError(const ErrorMessage: WideString);
begin
  if FEvents<>nil then
    FEvents.OnAnalysisError(ErrorMessage);
end;

function TDataModelServer.Get_UseAnalysisThread: WordBool;
begin
  Result:=FUseAnalysisThread
end;

procedure TDataModelServer.Set_UseAnalysisThread(Value: WordBool);
begin
  FUseAnalysisThread:=Value
end;

{ TDMServerFactory }

function TDMServerFactory.CreateInstance: IUnknown;
begin
  Result:=TDataModelServer.Create(nil) as IUnknown;
end;

function GetDMServerClassObject:IDMClassFactory;
begin
  Result:=TDMServerFactory.Create(nil) as IDMClassFactory;
end;

initialization
  CriticalSection:=TCriticalSection.Create;
//  CreateAutoObjectFactory(TDataModelServer, Class_DataModelServer);
end.
