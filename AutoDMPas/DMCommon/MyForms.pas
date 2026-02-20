unit MyForms;

interface
uses
  DM_Windows,
  Classes, Forms;

procedure Form_Resize(Sender: TObject);

implementation

procedure Form_Resize(Sender: TObject);
var
  j, W, H, MaxW, MaxH, HCaption:integer;
begin
  with TForm(Sender) do begin
    if Tag<>0 then Exit;
    Tag:=1;
    HCaption:=DM_GetSystemMetrics(SM_CYCAPTION);
    MaxW:=Width;
    MaxH:=Height;
    for j:=0 to ControlCount-1 do begin
      W:=Controls[j].Width+Controls[j].Left;
      H:=Controls[j].Height+Controls[j].Top+HCaption+10;
      if MaxW<W then
        MaxW:=W;
      if MaxH<H then
        MaxH:=H;
    end;
    Width:=MaxW;
    Height:=MaxH;
  end;
end;

end.
