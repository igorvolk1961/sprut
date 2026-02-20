unit DMToolBar;

interface

//{$INCLUDE SprutikDef.inc}

uses
  SysUtils, Classes, Types,
  Controls, ToolWin, Forms, Buttons,
  Graphics, ExtCtrls, ComCtrls, DMEditor_TLB, DMServer_TLB, DataModel_TLB;

const
  tbsCheck2=5;
  tbsDropDown2=6;

type
  TDMToolBar = class(TToolBar)
    procedure Timer1Timer(Sender: TObject);
  private
    FToolBars:TList;
    FTimer:TTimer;
    FMacrosTimer:TTimer;
    FImageList1:TImageList;
    FButtonList:TList;
    FButtonGroupList:TList;
    Flag:boolean;
    CurrToolBar:TToolBar;
    CurrToolButton:TToolButton;
    FDMForm: IDMForm;
    FCheckedChanged:boolean;
    FMacrosButton:TToolButton;
    FMacrosEventID:integer;
    FLastToolButton:TControl;

    procedure MakeImages;
    procedure MakeButtons;
    procedure ToolButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButtonMouseDownMain(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButtonMouseUpMain(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolBarExit(Sender: TObject);
    procedure DoAction(aTag: integer);
    procedure SetDMForm(const Value: IDMForm);
    function GetDMForm: IDMForm;
    function SetToolBarButton(aToolButton: TToolButton):TToolButton;
    procedure OnMacrosTimer(Sender: TObject);
    procedure DoCustomDrawButton(Sender: TToolBar;
         Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure DropDownMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShowCurrToolBar;
    procedure UncheckGroup(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DMForm:IDMForm read GetDMForm write SetDMForm;
    procedure SetButtonDown(ButtonIndex:integer;
                            Down, Execute:WordBool);
    function FindButtonByTag(aTag:integer):TToolButton;
    procedure Init;
    procedure SetControlState(Index, Mode, State:integer);
    procedure InitMacrosStep(ControlID, EventID:integer);
    procedure DoMacrosStep;
    procedure WriteMacrosState;
    procedure SetMacrosState(ControlID, EventID, X, Y:integer);
  end;

procedure Register;

implementation
uses
  DMContainerU;

procedure Register;
begin
  RegisterComponents('Samples', [TDMToolBar]);
end;

constructor TDMToolBar.Create(AOwner: TComponent);
begin
  inherited;
//  Name:='DMToolBar';
  FToolBars:=TList.Create;

  FTimer:=TTimer.Create(Self);
  FTimer.Interval:=10;
  FTimer.Enabled:=False;
  FTimer.OnTimer:=Timer1Timer;

{$IFDEF Demo}
  FMacrosTimer:=TTimer.Create(Self);
  FMacrosTimer.Interval:=500;
  FMacrosTimer.Enabled:=False;
  FMacrosTimer.OnTimer:=OnMacrosTimer;
{$ENDIF}

  FImageList1:=TImageList.Create(Self);
  FImageList1.AllocBy:=4;
  FImageList1.BkColor:=clNone;
  FImageList1.BlendColor:=clNone;
  FButtonList:=TList.Create;
  FButtonGroupList:=TList.Create;
  Left:=1000;
  FCheckedChanged:=True;
  OnCustomDrawButton:=DoCustomDrawButton;
end;

destructor TDMToolBar.Destroy;
begin
  inherited;
  FToolBars.Free;
  FButtonList.Free;
  FButtonGroupList.Free;
end;

procedure TDMToolBar.MakeButtons;
var
  aToolBar:TToolBar;
  TMPButtonList:TList;
  aForm:TWinControl;

  function AddToolBar(aTag:integer):TToolBar;
  begin
    if aTag=-1 then
      Result:=nil
    else begin
      Result:=TToolBar.Create(Self);
      Result.Visible:=False;
      Result.Flat:=True;
      Result.Width:=16;
      Result.AutoSize:=True;
      Result.EdgeBorders:=[ebLeft,ebTop,ebRight,ebBottom];
//    Result.Parent:=Parent;
//      Result.Parent:=Parent.Parent;
      Result.Parent:=aForm;
      Result.Images:=FImageList1;
//      Result.Tag:=aTag;
      Result.onExit:=ToolBarExit;
    end;
    FToolBars.Add(Result);
  end;

  procedure AddButton(aToolBarTag, aButtonImageIndex, aButtonTag:integer;
                      aStyle:integer; aMode:integer; aGroup:integer;
                      const aHint:WideString);
  var
    aToolButton:TControl;
    aBitmap:TBitmap;
  begin
    if aStyle<>tbsDropDown2 then
      aToolButton:=TToolButton.Create(Self)
    else
      aToolButton:=TSpeedButton.Create(Self);

    if aStyle<=ord(High(TToolButtonStyle)) then
      (aToolButton as TToolButton).Style:=TToolButtonStyle(aStyle)
    else
    if aStyle=tbsCheck2 then
      (aToolButton as TToolButton).Style:=tbsCheck;

    if aStyle=ord(tbsSeparator) then begin
      aToolButton.Width:=8
    end else
    if aStyle=tbsDropDown2 then begin
      aToolButton.Width:=12;
      aToolButton.Tag:=integer(pointer(FLastToolButton));
      (aToolButton as TSpeedButton).Flat:=True;
      (aToolButton as TSpeedButton).Transparent:=False;
      (aToolButton as TSpeedButton).OnMouseDown:=DropDownMouseDown;
      aBitmap:=TBitmap.Create;
      try
      FImageList1.GetBitmap(aButtonImageIndex, aBitmap);
      (aToolButton as TSpeedButton).Glyph.Assign(aBitmap);
      finally
        aBitmap.Free;
      end;
    end else begin
      aToolButton.Hint:=aHint;
      aToolButton.Tag:=aButtonTag;
      aToolButton.ShowHint:=True;
      (aToolButton as TToolButton).ImageIndex:=aButtonImageIndex;
      if aStyle=ord(tbsCheck) then
        (aToolButton as TToolButton).Grouped:=True
    end;
    Width:=Width+aToolButton.Width;

    case aMode of
    0:begin
        FButtonList[aButtonImageIndex]:=aToolButton;
        FButtonGroupList[aButtonImageIndex]:=pointer(aGroup);
        aToolButton.Parent:=aToolBar;
        if aToolButton is TToolButton then begin
          (aToolButton as TToolButton).OnMouseUp:=ToolButtonMouseUp;
          (aToolButton as TToolButton).OnMouseDown:=ToolButtonMouseDown;
        end;
      end;
    1,2:begin
        if aMode=2 then
          aToolBar:=AddToolBar(-1)
        else
          aToolBar:=AddToolBar(0);
        if (aMode=2) and
           (aButtonImageIndex<>-1) then begin
          FButtonList[aButtonImageIndex]:=aToolButton;
          FButtonGroupList[aButtonImageIndex]:=pointer(aGroup);
        end;
        TMPButtonList.Add(aToolButton);
        if aToolButton is TToolButton then begin
          (aToolButton as TToolButton).OnMouseDown:=ToolButtonMouseDownMain;
          (aToolButton as TToolButton).OnMouseUp:=ToolButtonMouseUpMain;
        end;
        FLastToolButton:=aToolButton;
      end;
    end;
  end;
var
  j, aToolButtonCount:integer;
  aToolBarTag, aButtonImageIndex, aButtonTag,
  aStyle, aMode, aGroup:integer;
  aHint:WideString;
  aParent:TWinControl;
begin
  if ButtonCount>0 then Exit;
  Width:=0;
  TMPButtonList:=TList.Create;

  aParent:=Parent;
  while (aParent<>nil) and
        (not (aParent is TDMContainer)) do
    aParent:=aParent.Parent;
  if aParent<>nil then
    aForm:=aParent
  else
    Exit;

  aToolButtonCount:=FDMForm.ToolButtonCount;
  for j:=0 to aToolButtonCount-1 do begin
    FDMForm.GetToolButtonProperties
             (j, aToolBarTag, aButtonImageIndex, aButtonTag,
                                     aStyle, aMode, aGroup, aHint);
    AddButton(aToolBarTag, aButtonImageIndex, aButtonTag,
                                     aStyle, aMode, aGroup, aHint);
  end;

  for j:=TMPButtonList.Count-1 downto 0 do begin
     TToolButton(TMPButtonList[j]).Parent:=Self;
     if FToolBars[j]<>nil then
       TToolBar(FToolBars[j]).Tag:=j
  end;

  TMPButtonList.Free;
end;


procedure TDMToolBar.ToolButtonMouseDownMain(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
var
  j:integer;
  Server:IDataModelServer;
  aDocument:IDMDocument;
  aDataModel:IDataModel;
begin
  UncheckGroup(Sender);

  if CurrToolBar<>nil  then begin
    CurrToolBar.Visible:=False;
  end;
  CurrToolButton:=TToolButton(Sender);
  j:=CurrToolButton.Index;
  CurrToolBar:=FToolBars[j];
  if CurrToolBar=nil  then Exit;

  Server:=DMForm.DataModelServer as IDataModelServer;
  aDocument:=Server.CurrentDocument;
  if aDocument=nil then Exit;
  
  aDataModel:= aDocument.DataModel as IDataModel;
  if aDataModel.State and dmfDemo<>0 then begin
    Timer1Timer(FTimer)
  end else begin
    FTimer.Interval:=500;
    FTimer.Enabled:=True;
  end;
end;

procedure TDMToolBar.Timer1Timer(Sender: TObject);
begin
  ShowCurrToolBar;
end;

procedure TDMToolBar.ShowCurrToolBar;
var
  ClientP, ParentP:TPoint;
begin
  ClientP:=point(0, CurrToolButton.Height);
  ParentP:=CurrToolButton.ClientToParent(ClientP, Self);
  CurrToolBar.Align:=alNone;
  CurrToolBar.Left:=ParentP.X-1;
  CurrToolBar.Top:=ParentP.Y+4;
  CurrToolBar.Visible:=True;
  CurrToolBar.SetFocus;
  FTimer.Enabled:=false;
end;

procedure TDMToolBar.UncheckGroup(Sender: TObject);
var
  j, Group, aGroup, aButtonImageIndex:integer;
  ToolButton:TToolButton;
begin
  aButtonImageIndex:=(Sender as TToolButton).ImageIndex;
  Group:=integer(FButtonGroupList[aButtonImageIndex]);

  for j:=0 to ButtonCount-1 do begin
    ToolButton:=Buttons[j];
    if ToolButton.Style=tbsCheck then begin
      aButtonImageIndex:=ToolButton.ImageIndex;
      aGroup:=integer(FButtonGroupList[aButtonImageIndex]);
      if (ToolButton<>Sender) and
         (aGroup=Group) then
        ToolButton.Down:=False
    end;
  end;
end;

procedure TDMToolBar.ToolButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
var
  aToolButton, ToolBarButton:TToolButton;
  Server:IDataModelServer;
begin
  aToolButton:=TToolButton(Sender);
  ToolBarButton:=SetToolBarButton(aToolButton);

  FTimer.Enabled:=false;
  DoAction(ToolBarButton.Tag);

{$IFDEF Demo}
 (FDMForm.DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrToolBarEvent,
              -1, aToolButton.ComponentIndex, meMouseUp, -1, -1, '');
{$ENDIF}

  Server:=DMForm.DataModelServer as IDataModelServer;
  Server.RefreshDocument(rfFast);
end;

function TDMToolBar.SetToolBarButton(aToolButton: TToolButton):TToolButton;
var
  aToolBar:TToolBar;
begin
  aToolBar:=TToolBar(aToolButton.Parent);
  if aToolBar<>Self then
    Result:=Buttons[aToolBar.Tag]
  else
    Result:=aToolButton;
  Result.Tag:=aToolButton.Tag;
  Result.ImageIndex:=aToolButton.ImageIndex;
  Result.Hint:=aToolButton.Hint;
  if aToolBar<>Self then begin
    aToolBar.Visible:=False;
  end;
  Result.Enabled:=aToolButton.Enabled;
  Result.Down:=aToolButton.Down;
end;

procedure TDMToolBar.ToolButtonMouseUpMain(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
var
  aToolButton:TToolButton;
  aTag:integer;
begin
  aToolButton:=TToolButton(Sender);

  if FTimer.Enabled then begin
    FTimer.Enabled:=False;
{$IFDEF Demo}
   (FDMForm.DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrToolBarEvent,
                -1, CurrToolButton.ComponentIndex, meLClick, -1, -1, '');
{$ENDIF}
  end else begin
{$IFDEF Demo}
   (FDMForm.DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrToolBarEvent,
                -1, CurrToolButton.ComponentIndex, meMouseMove, -1, -1, '');
   (FDMForm.DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrToolBarEvent,
                -1, CurrToolButton.ComponentIndex, meMouseDown, -1, -1, '');
   (FDMForm.DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrToolBarEvent,
               -1, aToolButton.ComponentIndex, meMouseUp, -1, -1, '');
{$ENDIF}
  end;

  aTag:=aToolButton.Tag;
  DoAction(aTag);

end;

procedure TDMToolBar.DoAction(aTag:integer);
begin
  if FDMForm=nil then Exit;
  FDMForm.DoAction(800+aTag);
  FDMForm.GetFocus;
end;

procedure TDMToolBar.ToolBarExit(Sender: TObject);
var
  aToolBar:TToolBar;
  Server:IDataModelServer;
begin
  aToolBar:=TToolBar(Sender);
  aToolBar.Visible:=false;

  Server:=DMForm.DataModelServer as IDataModelServer;
  Server.RefreshDocument(rfFast);

  DoAction(110);
end;

procedure TDMToolBar.MakeImages;
  procedure AddImage(const ResourceName:string; ResourceInstanceHandle:integer);
  var
    aBitMap:TBitMap;
  begin
      aBitMap:=TBitMap.Create;
      aBitMap.LoadFromResourceName(ResourceInstanceHandle, ResourceName);
      FImageList1.AddMasked(aBitMap, clWhite);
      aBitMap.Free;
      FButtonList.Add(nil);
      FButtonGroupList.Add(nil);
  end;
var
  j, aToolButtonImageCount,
  ResourceInstanceHandle:integer;
  ImageResourceName:string;
begin
  aToolButtonImageCount:=FDMForm.ToolButtonImageCount;
  ResourceInstanceHandle:=FDMForm.InstanceHandle;
  for j:=0 to aToolButtonImageCount-1 do begin
    ImageResourceName:=FDMForm.ToolButtonImage[j];
    AddImage(ImageResourceName, ResourceInstanceHandle);
  end;
end;

procedure TDMToolBar.SetDMForm(const Value: IDMForm);
begin
  FDMForm:= Value;
end;

function TDMToolBar.GetDMForm: IDMForm;
begin
  Result:=FDMForm
end;

procedure TDMToolBar.SetButtonDown(ButtonIndex: integer; Down,
  Execute: WordBool);
var
  Button:TToolButton;
begin
  Button:=FButtonList[ButtonIndex];
  Button.Down:=Down;
  if Execute then
    Button.Click;
end;

function TDMToolBar.FindButtonByTag(aTag: integer): TToolButton;
var
  j:integer;
  Button:TToolButton;
begin
  Button:=nil;
  j:=0;
  while j<FButtonList.Count do begin
    Button:=FButtonList[j];
    if (Button<>nil) and
      (Button.Tag=aTag) then
      Break
    else
      inc(j)
  end;
  if j<FButtonList.Count then
    Result:=Button
  else
    Result:=nil
end;

procedure TDMToolBar.Init;
begin
  inherited;
  if Flag then Exit;
  Flag:=True;
  MakeImages;
  Images:=FImageList1;
  Flat:=True;
  AutoSize:=True;
  MakeButtons;
//  Width:=ButtonCount*ButtonWidth;
  Height:=16;
  Align:=alTop;
end;

procedure TDMToolBar.SetControlState(Index, Mode, State: integer);
var
  Button, aButton:TToolButton;
  aTag:integer;
  aToolBar:TToolBar;
begin
  if Index<0 then begin
    aTag:=-Index;
    Button:=FindButtonByTag(aTag)
  end else
  if Index>=FButtonList.Count then
    Exit
  else
    Button:=FButtonList[Index];
  if Button=nil then Exit;
  case Mode of
  csChecked:
    begin
     if Button.Down<>boolean(State) then begin
       FCheckedChanged:=True;
       Button.Down:=boolean(State);
     end else
       FCheckedChanged:=False;
       SetToolBarButton(Button);
    end;
  csEnabled:
    begin
      Button.Enabled:=boolean(State);
      aToolBar:=TToolBar(Button.Parent);
      aButton:=Buttons[aToolBar.Tag];
      if aButton.Tag=Button.Tag then
        aButton.Enabled:=Button.Enabled;
    end;
  csVisible:
    begin
      Button.Visible:=boolean(State);
    end;
  csClick:
    if (State=1) or FCheckedChanged then begin
      Button.OnMouseUp(Button, mbLeft, [], 0, 0);
      Button.Down:=True;
      SetToolBarButton(Button);
    end;
  end;
end;

procedure TDMToolBar.InitMacrosStep(ControlID, EventID: integer);
{$IFDEF Demo}
var
  DMMacrosManager:IDMMacrosManager;
  CursorStepLength:integer;
{$ENDIF}
begin
{$IFDEF Demo}
  FMacrosButton:=TToolButton(Components[ControlID]);
  FMacrosEventID:=EventID;

  P.X:=FMacrosButton.Width div 2;
  P.Y:=FMacrosButton.Height div 2;
  P1:=FMacrosButton.ClientToScreen(P);

  CursorStepLength:=16;

  DMMacrosManager:=Owner as IDMMacrosManager;
  DMMacrosManager.StartMacrosStep(P1.X, P1.Y, CursorStepLength)
{$ENDIF}
end;

procedure TDMToolBar.DoMacrosStep;
{$IFDEF Demo}
var
  DMMacrosManager:IDMMacrosManager;
  j:integer;
{$ENDIF}
begin
{$IFDEF Demo}
  case FMacrosEventID of
  meLClick:
    begin
      FMacrosButton.Down:=True;
      CurrToolButton:=FMacrosButton;
      j:=CurrToolButton.Index;
      CurrToolBar:=FToolBars[j];

      if FMacrosButton.Parent=Self then
        ToolButtonMouseUpMain(FMacrosButton, mbLeft, [], 0,0)
      else
        ToolButtonMouseUp(FMacrosButton, mbLeft, [], 0,0);
      DMMacrosManager:=Owner as IDMMacrosManager;
      DMMacrosManager.PlayNextStep;
    end;
  meMouseUp:
    begin
      if FMacrosButton.Parent=Self then begin
        ToolButtonMouseUpMain(FMacrosButton, mbLeft, [], 0,0);
        FMacrosTimer.Interval:=500;
      end else begin
        ToolButtonMouseUp(FMacrosButton, mbLeft, [], 0,0);
        FMacrosTimer.Interval:=500;
      end;
      FMacrosTimer.Enabled:=True;
    end;
  meMouseDown:
    begin
      FMacrosButton.Down:=True;
      if FMacrosButton.Parent=Self then
        ToolButtonMouseDownMain(FMacrosButton, mbLeft, [], 0,0)
      else
        ToolButtonMouseDown(FMacrosButton, mbLeft, [], 0,0);
      FMacrosTimer.Interval:=500;
      FMacrosTimer.Enabled:=True;
    end;
  meMouseMove:
    begin
      DMMacrosManager:=Owner as IDMMacrosManager;
      DMMacrosManager.PlayNextStep;
    end
  end;
{$ENDIF}
end;

procedure TDMToolBar.OnMacrosTimer(Sender: TObject);
var
  DMMacrosManager:IDMMacrosManager;
begin
{$IFDEF Demo}
  FMacrosTimer.Enabled:=False;
  DMMacrosManager:=Owner as IDMMacrosManager;
  DMMacrosManager.PlayNextStep;
{$ENDIF}
end;

procedure TDMToolBar.ToolButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aToolButton:TToolButton;
begin
  UncheckGroup(Sender);

  aToolButton:=TToolButton(Sender);

{$IFDEF Demo}
 (FDMForm.DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrToolBarEvent,
              -1, aToolButton.ComponentIndex, meMouseMove, -1, -1, '');
 (FDMForm.DMEditorX as IDMMacrosManager).WriteMacrosEvent(mrToolBarEvent,
              -1, aToolButton.ComponentIndex, meMouseDown, -1, -1, '');
{$ENDIF}
end;

procedure TDMToolBar.WriteMacrosState;
var
  j:integer;
  aToolButton:TToolButton;
  DMMacrosManager:IDMMacrosManager;
begin
{$IFDEF Demo}
  DMMacrosManager:=FDMForm.DMEditorX as IDMMacrosManager;
  for j:=0 to ButtonCount-1 do begin
    aToolButton:=Buttons[j];
    if aToolButton.Style<>tbsSeparator then
     DMMacrosManager.WriteMacrosEvent(mrSetToolBarState,
              -1, aToolButton.Tag, j, ord(aToolButton.Down), -1, '');
  end;
{$ENDIF}
end;

procedure TDMToolBar.SetMacrosState(ControlID, EventID, X, Y:integer);
var
  aTag, State:integer;
begin
{$IFDEF Demo}
  aTag:=ControlID;
  State:=EventID;
  SetControlState(-aTag, csChecked, State)
{$ENDIF}
end;

procedure TDMToolBar.DoCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
{
var
  L, T, R, B, W, H:integer;
  Points:array [0..2] of TPoint;
}
begin
  DefaultDraw:=True;
{
  if FToolBars[Button.Index]<>nil then begin
    L:=Button.Left;
    W:=Button.Width;
    T:=Button.Top;
    H:=Button.Height;
    R:=L+W-5;
    B:=T+H-5;
    L:=R-4;
    T:=B-4;
    Points[0]:=Point(L,B);
    Points[1]:=Point(R,R);
    Points[2]:=Point(R,T);
    Canvas.Polygon(Points);
  end;
}  
end;

procedure TDMToolBar.DropDownMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
var
  j:integer;
begin
  CurrToolButton:=TToolButton(pointer(TControl(Sender).Tag));
  j:=CurrToolButton.Index;
  CurrToolBar:=FToolBars[j];
  ShowCurrToolBar;
end;

end.
