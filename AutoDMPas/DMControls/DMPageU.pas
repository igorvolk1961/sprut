unit DMPageU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_Windows,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants,
  DataModel_TLB, DMEditor_TLB, DMServer_TLB;

type
  TDMPageClass=class of TDMPage;

  TDMPage = class(TForm, IDMForm, IDMMacrosPlayer)
  private
    FDataModelServer: IDataModelServer;
    FDMEditorX:pointer;
    FMode:integer;
    FFormID:integer;
    FOldCursor:integer;
    FFormClassGUID: TGUID;
    FChangingParent:WordBool;
  protected
    FMacrosRecordKind: integer;
    FMacrosEventID: integer;
    FMacrosControlID:integer;
    FMacrosControl:TWinControl;
    FMacrosX: double;
    FMacrosY: double;
    FMacrosString:string;

    function GetDataModel:IDataModel;
    function Get_DataModelServer: IUnknown; safecall;
    procedure Set_DataModelServer(const Value: IUnknown); safecall;
    procedure DocumentOperation(ElementsV,
      CollectionV: OleVariant; DMOperation, nItemIndex: Integer); virtual; safecall;
    procedure UpdateDocument; virtual; safecall;
    procedure OpenDocument; virtual; safecall;
    procedure OpenDocument0; virtual; safecall;
    procedure OpenDocument1; virtual; safecall;
    procedure CloseDocument; virtual; safecall;
    procedure RefreshDocument(FlagSet:integer); virtual; safecall;
    procedure RefreshElement(DMElement:OleVariant); virtual; safecall;
    procedure SelectionChanged(DMElement:OleVariant); virtual; safecall;
    procedure SetCurrentElement(DMElement:OleVariant); virtual; safecall;
    procedure UpdateCurrentElement; virtual; safecall;
    procedure GetFocus; virtual; safecall;

    procedure DeleteSelected; virtual;
    procedure CopyToBuffer; virtual;
    function PasteFromBuffer:boolean; virtual;
    procedure Undo;
    procedure Redo;
    function DoAction(ActionCode: integer):WordBool; virtual; safecall;
    function Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); virtual; safecall;
    function  Get_DMEditorX: IDMEditorX; safecall;
    procedure Set_DMEditorX(const Value: IDMEditorX); safecall;
    procedure Set_FormID(Value:integer); safecall;
    function  Get_FormID:integer; safecall;
    function  Get_ToolButtonCount: Integer; virtual; safecall;
    procedure GetToolButtonProperties(Index:integer;
                                      var aToolBarTag: Integer; var aButtonImageIndex: Integer;
                                      var aButtonTag: Integer; var aStyle: Integer;
                                      var aMode: Integer; var aGroup: Integer;
                                      var aHint: WideString); virtual; safecall;
    function  Get_ToolButtonImageCount: Integer; virtual; safecall;
    function  Get_ToolButtonImage(Index:integer): WideString; virtual; safecall;
    function  Get_InstanceHandle: Integer; virtual; safecall;
    procedure SetCursor(aCursor:integer); safecall;
    procedure RestoreCursor; safecall;
    procedure CheckDocumentState; virtual; safecall;
    function  Get_FormClassGUID: TGUID; safecall;
    procedure Set_FormClassGUID(Value: TGUID); safecall;
    procedure StopAnalysis(Mode:integer); virtual; safecall;
    procedure StartAnalysis(Mode:integer); virtual; safecall;
    procedure RestoreState; virtual; safecall;
    procedure SaveState; virtual; safecall;
    function DoMacrosStep(RecordKind, ControlID, EventID, X, Y: Integer;
                  const S:WideString):WordBool; virtual; safecall;
    procedure WriteMacrosState; virtual; safecall;
    procedure SetMacrosState(ParamID, Z, X, Y:integer); virtual; safecall;
    procedure CloseActiveWindow; virtual; safecall;
    function Get_FormName: WideString; safecall;
    procedure Set_FormName(const Value: WideString); safecall;
    procedure CallCustomDialog(Mode: Integer; const aCaption: WideString; const aPrompt: WideString); virtual; safecall;
    procedure Set_ChangingParent(Value:WordBool); safecall;
    function  Get_ChangingParent:WordBool; safecall;
    function GetDocument:IDMDocument; virtual; safecall;
  public
    constructor Create(aOwner:TComponent); override;
    procedure Initialize; virtual;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TDMPage }

//*********************************

function TDMPage.DoAction(ActionCode:integer):WordBool;
begin
  Result:=False;
  case ActionCode of
  dmbaAddElement      : begin end;
  dmbaDeleteElement   : begin end;
  dmbaRenameElement   : begin end;
  dmbaSelectElementFromList:
                        begin end;
  dmbaChangeRef       : begin end;
  dmbaExecute         : begin end;
  dmbaCustomOperation1: begin end;
  dmbaCustomOperation2: begin end;
  dmbaDelete          : begin DeleteSelected;  Result:=True end;
  dmbaCopy            : begin CopyToBuffer;    Result:=True end;
  dmbaPaste           : Result:=PasteFromBuffer;
  dmbaSwitchSelection : begin end;
  dmbaSelectAll       : begin end;
  dmbaUnselectAll     : begin end;
  dmbaUndo            : begin Undo;  Result:=True end;
  dmbaRedo            : begin Redo;  Result:=True end;
  dmbaGoToLastElement : begin end;
  dmbaSetOptions      : begin end;
  dmbaShiftElementUp  : begin end;
  dmbaShiftElementDown: begin end;
  end;
end;



procedure TDMPage.DocumentOperation(
  ElementsV, CollectionV: OleVariant; DMOperation,
  nItemIndex: Integer);
begin
end;

procedure TDMPage.Set_DataModelServer(const Value: IUnknown);
begin
  FDataModelServer := Value as IDataModelServer;
end;

destructor TDMPage.Destroy;
begin
  try
  inherited;
  FDataModelServer:=nil;
  except
    raise
  end;  
end;

function TDMPage.Get_DataModelServer: IUnknown;
begin
  Result:=FDataModelServer as IUnknown
end;

procedure TDMPage.OpenDocument;
begin
end;

procedure TDMPage.CloseDocument;
begin
end;

procedure TDMPage.RefreshDocument(FlagSet:integer);
begin
end;

procedure TDMPage.SelectionChanged(DMElement:OleVariant);
begin
end;

function TDMPage.PasteFromBuffer:boolean;
begin
  Result:=False
end;

procedure TDMPage.CopyToBuffer;
begin
  (FDataModelServer as IDMCopyBuffer).Copy;
end;

function TDMPage.Get_Mode: Integer;
begin
  Result:=FMode;
end;

procedure TDMPage.Set_Mode(Value: Integer);
begin
  FMode:=Value;
end;

procedure TDMPage.Redo;
begin
  (GetDocument as IDMOperationManager).Redo
end;

procedure TDMPage.Undo;
begin
  (GetDocument as IDMOperationManager).Undo
end;

procedure TDMPage.DeleteSelected;
begin
end;

function TDMPage.Get_DMEditorX: IDMEditorX;
begin
//  Result:=IDMEditorX(FDMEditorX)
  Result:=Owner as IDMEditorX;
end;

procedure TDMPage.Set_DMEditorX(const Value: IDMEditorX);
begin
  FDMEditorX:=pointer(Value)
end;

procedure TDMPage.Initialize;
begin
  inherited;
  DecimalSeparator:='.';
end;

function TDMPage.Get_ToolButtonCount: Integer;
begin
  Result:=0
end;

function TDMPage.Get_ToolButtonImage(Index:integer): WideString;
begin
  Result:=''
end;

function TDMPage.Get_ToolButtonImageCount: Integer;
begin
  Result:=0
end;

procedure TDMPage.GetToolButtonProperties(Index:integer;
  var aToolBarTag, aButtonImageIndex, aButtonTag, aStyle, aMode, aGroup: Integer;
  var aHint: WideString);
begin
end;

function TDMPage.Get_InstanceHandle: Integer;
begin
  Result:=-1
end;

function TDMPage.Get_FormID: integer;
begin
  Result:=FFormID
end;

procedure TDMPage.Set_FormID(Value: integer);
begin
  FFormID:=Value
end;

procedure TDMPage.RestoreCursor;
begin
  {Screen.}Cursor:=FOldCursor;
end;

procedure TDMPage.SetCursor(aCursor: integer);
begin
  FOldCursor:={Screen.}Cursor;
  {Screen.}Cursor:=TCursor(aCursor);
end;

procedure TDMPage.CheckDocumentState;
begin
end;

procedure TDMPage.SetCurrentElement(DMElement: OleVariant);
begin

end;

function TDMPage.Get_FormClassGUID: TGUID;
begin
  Result:=FFormClassGUID
end;

procedure TDMPage.Set_FormClassGUID(Value: TGUID);
begin
  FFormClassGUID:=Value
end;

procedure TDMPage.StopAnalysis(Mode: integer);
begin
end;

procedure TDMPage.StartAnalysis(Mode: integer);
begin
end;

procedure TDMPage.RefreshElement(DMElement: OleVariant);
begin
end;

procedure TDMPage.RestoreState;
begin
end;

procedure TDMPage.SaveState;
begin
end;

function TDMPage.GetDataModel: IDataModel;
begin
  Result:=GetDocument.DataModel as IDataModel;
  if Get_Mode<0 then
    Result:=(Result as IDMElement).Ref as IDataModel
end;


procedure TDMPage.UpdateDocument;
begin
end;

function TDMPage.DoMacrosStep(RecordKind, ControlID, EventID, X, Y: Integer;
                 const S:WideString):WordBool;
begin
  FMacrosRecordKind:=RecordKind;
  FMacrosEventID:=EventID;
  FMacrosControlID:=ControlID;
  FMacrosX:=X;
  FMacrosY:=Y;
  FMacrosString:=S;
  Result:=True;
end;

procedure TDMPage.WriteMacrosState;
begin
end;

procedure TDMPage.SetMacrosState(ParamID, Z, X, Y:integer);
begin
end;

procedure TDMPage.CloseActiveWindow;
var
  hWind:LongWord;
  theActiveForm:TForm;
  m:integer;
  Component:TComponent;
  Button:TButton;
begin
  hWind:=DM_GetActiveWindow;
  theActiveForm:=Screen.ActiveForm;
  if theActiveForm=nil then
    DM_DestroyWindow(hWind)
  else
  if theActiveForm.Handle<>hWind then
    DM_DestroyWindow(hWind)
  else begin
    Button:=nil;
    m:=0;
    while m<theActiveForm.ComponentCount do begin
      Component:=theActiveForm.Components[m];
      if (Component is TButton) then begin
        Button:=Component as TButton;
        if Button.ModalResult=mrOK then Break
      end else
        inc(m)
    end;
    if m<theActiveForm.ComponentCount then
      Button.Click
    else
      theActiveForm.Close;
  end;
end;

function TDMPage.Get_FormName: WideString;
begin
  Result:=Name
end;

procedure TDMPage.Set_FormName(const Value: WideString);
begin
  Name:=Value
end;

procedure TDMPage.CallCustomDialog(Mode: Integer; const aCaption,
  aPrompt: WideString);
begin
end;

constructor TDMPage.Create(aOwner: TComponent);
begin
  inherited;
  Initialize;
end;

function TDMPage.Get_ChangingParent: WordBool;
begin
  Result:=FChangingParent
end;

procedure TDMPage.Set_ChangingParent(Value: WordBool);
begin
  FChangingParent:=Value
end;

procedure TDMPage.UpdateCurrentElement;
begin
end;

procedure TDMPage.OpenDocument0;
begin
end;

procedure TDMPage.OpenDocument1;
begin
end;

function TDMPage.GetDocument: IDMDocument;
begin
  Result:=(Get_DataModelServer as IDataModelServer).CurrentDocument
end;


procedure TDMPage.GetFocus;
begin
  SetFocus;
end;

end.
