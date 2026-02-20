unit DMComparatorU;

//{$DEFINE VER150}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_Messages, DM_Windows,
  DM_AxCtrls, OleCtrls,
  Types, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdVcl, ImgList, Menus, ComCtrls, SyncObjs,
  CommCtrl, StdCtrls, Grids, ExtCtrls, ToolWin, Variants, Registry,
  DataModel_TLB, DMEditor_TLB, DMServer_TLB, DMListForm_TLB,
  DMToolBar, Buttons, DMMenu, DMContainerU, ComObj;


type
  TDMComparator = class(TDMContainer)
  protected
    FClosingDocument:boolean;
    procedure Set_ActiveForm(const Value: IDMForm); override;
    procedure DoOpenDocument; override;
  end;

implementation
{$R *.dfm}

{ TDMComparator }

procedure TDMComparator.DoOpenDocument;
var
  j:integer;
  CopyBuffer:IDMCopyBuffer;
  Document0, Document1:IDMDocument;
begin
  if FClosingDocument then Exit;
  try

//  if FDataModelServer.DocumentCount<2 then begin
    for j:=0 to FFormList0.Count-1 do
      Get_Form(j, 0).OpenDocument0;
//  end else
  if FDataModelServer.DocumentCount=2 then begin
    for j:=0 to FFormList1.Count-1 do
      Get_Form(j, 1).OpenDocument1;
  end else
  if FDataModelServer.DocumentCount>2 then begin
    TabControl.TabIndex:=0;
    FDataModelServer.CurrentDocumentIndex:=0;
    FClosingDocument:=True;
    FDataModelServer.CloseCurrentDocument;
    FClosingDocument:=False;
    for j:=0 to FFormList0.Count-1 do
      Get_Form(j, 0).OpenDocument0;
    for j:=0 to FFormList1.Count-1 do
      Get_Form(j, 1).OpenDocument1;
  end;

  ToolBar1.Enabled:=True;
  for j:=0 to ToolBar1.ButtonCount-1 do
    ToolBar1.Buttons[j].Enabled:=True;

  CopyBuffer:=FDataModelServer as IDMCopyBuffer;

  if FDataModelServer.DocumentCount>0 then
    Document0:=FDataModelServer.Document[0]
  else
    Document0:=nil;
  if FDataModelServer.DocumentCount>1 then
    Document1:=FDataModelServer.Document[1]
  else
    Document1:=nil;

  tbPaste.Enabled:=(CopyBuffer.BufferCount>0);
  tbCopy.Enabled:=((Document0<>nil) and (Document0.SelectionCount>0)) or
                  ((Document1<>nil) and (Document1.SelectionCount>0));
  tbDelete.Enabled:=tbCopy.Enabled;

  CheckDocumentState;

  except
    raise
  end;
end;

procedure TDMComparator.Set_ActiveForm(const Value: IDMForm);
begin
  inherited;
  if Value=Get_Form(0, 0) then begin
    if FDataModelServer.DocumentCount>0 then
      FDataModelServer.CurrentDocumentIndex:=0
  end else
  if FDataModelServer.DocumentCount>1 then
    FDataModelServer.CurrentDocumentIndex:=1;
  CheckDocumentState;  
end;

end.
