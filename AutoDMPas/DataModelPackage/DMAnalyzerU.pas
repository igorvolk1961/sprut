unit DMAnalyzerU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ActiveX, Classes, ComObj, SysUtils, StdVcl,
  DMElementU, DataModelU, DataModel_TLB,
  DMServer_TLB, SpatialModelLib_TLB,
  Variants;

type
  TDMAnalyzer = class(TDataModel, IDMAnalyzer)
  private
    FMode:integer;
    FFormHandle:integer;
    FReport:IDMText;
    FPrevAnalyzer:IUnknown;
    FTerminateFlag:boolean;
    function  GetTerminateFlag:boolean;
  protected
    FStage:integer;
    FErrorDescription:string;

    procedure Start(aMode: Integer); virtual; safecall;
    procedure Stop; virtual; safecall;
    procedure Continue; safecall;
    function  Get_Data: IDMElement; safecall;
    procedure Set_Data(const Value: IDMElement); safecall;
    function  Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    function  Get_FormHandle: Integer; safecall;
    procedure Set_FormHandle(Value: Integer); safecall;

    function GetStageName:string; virtual;
    function CalcStepCount:integer; virtual;
    procedure DoAnalysis; virtual;
    procedure TreatElement(const aElement: IDMElement; aMode: Integer); virtual; safecall;
    function Get_Report:IDMText; override; safecall;
    procedure Set_PrevAnalyzer(const Value:IUnknown); safecall;
    function  Get_PrevAnalyzer:IUnknown; safecall;
    function  Get_ErrorDescription:WideString; safecall;

    procedure SetTerminateFlag(Value:boolean); virtual;
    property TerminateFlag:boolean read GetTerminateFlag write SetTerminateFlag;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

{ TDMAnalyzer }

function TDMAnalyzer.CalcStepCount: integer;
begin
  Result:=0
end;

procedure TDMAnalyzer.Continue;
begin
end;

procedure TDMAnalyzer.DoAnalysis;
begin
end;

function TDMAnalyzer.GetStageName: string;
begin
  Result:='';
end;

function TDMAnalyzer.Get_FormHandle: Integer;
begin
  Result:=FFormHandle
end;
procedure TDMAnalyzer.Set_FormHandle(Value: Integer);
begin
  FFormHandle:=Value
end;


function TDMAnalyzer.Get_Mode: Integer;
begin
  Result:=FMode
end;

procedure TDMAnalyzer.Set_Mode(Value: Integer);
begin
  FMode:=Value
end;

function TDMAnalyzer.Get_Data: IDMElement;
begin
  Result:=DataModel as IDMElement
end;

procedure TDMAnalyzer.Set_Data(const Value: IDMElement);
begin
  FDataModel:=pointer(Value as IDataModel);
  DataModel.Analyzer:=Self as IDMAnalyzer
end;

procedure TDMAnalyzer.Start(aMode: Integer);
var
  Document:IDMDocument;
  Server:IDataModelServer;
  S:WideString;
  aDataModel:IDataModel;
begin
  aDataModel:=Get_Data as IDataModel;
  Document:=aDataModel.Document as IDMDocument;
  Server:=Document.Server;
  FMode:=aMode;
  FStage:=0;
  aDataModel.State:=aDataModel.State or dmfExecuting;
  Set_State(Get_State or dmfExecuting);
  FTerminateFlag:=False;
  FErrorDescription:='';
  try
    DoAnalysis;
  finally
    aDataModel.State:=aDataModel.State and not dmfExecuting;
    Set_State(Get_State and not dmfExecuting);
    Server.NextAnalysisStage(S, -1, -1);
  end;
end;

procedure TDMAnalyzer.Stop;
begin
  FTerminateFlag:=True;
end;

procedure TDMAnalyzer.TreatElement(const aElement: IDMElement;
  aMode: Integer);
begin
end;

function TDMAnalyzer.Get_Report: IDMText;
begin
  Result:=FReport;
end;

destructor TDMAnalyzer.Destroy;
begin
  inherited;
  FReport:=nil;
  FPrevAnalyzer:=nil;
end;

procedure TDMAnalyzer.Initialize;
begin
  inherited;
  FReport:=TDMText.Create(Self as IDataModel) as IDMText;
  FTerminateFlag:=False;
end;

function TDMAnalyzer.Get_PrevAnalyzer: IUnknown;
begin
  Result:=FPrevAnalyzer
end;

procedure TDMAnalyzer.Set_PrevAnalyzer(const Value: IUnknown);
begin
  FPrevAnalyzer:=Value
end;

function TDMAnalyzer.GetTerminateFlag: boolean;
begin
  Result:=FTerminateFlag
end;

procedure TDMAnalyzer.SetTerminateFlag(Value: boolean);
begin
  FTerminateFlag:=Value
end;

function TDMAnalyzer.Get_ErrorDescription: WideString;
begin
  Result:=FErrorDescription;
end;

end.
