unit findFrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Types,
  Dialogs, StdCtrls, ExtCtrls ,DMServer_TLB, DataModel_TLB, SpatialModelLib_TLB,
  Spin;

type
  Tfrm_Find = class(TForm)
    pn_Info: TPanel;
    lb_Name: TLabel;
    pn_Param: TPanel;
    btFind: TButton;
    gb_Find: TGroupBox;
    rb_Find_ID: TRadioButton;
    cb_FClassAlias: TComboBox;
    rb_Find_Name: TRadioButton;
    bt_Stop: TButton;
    pn_Find_Name: TPanel;
    lb_pn_Find2: TLabel;
    cb_Find_Name: TComboBox;
    pn_Find_ID: TPanel;
    lb_pn_Find1: TLabel;
    cb_Find_ID: TComboBox;
    Label1: TLabel;
    procedure btFindClick(Sender: TObject);
    procedure cb_FClassAliasDropDown(Sender: TObject);
    procedure cb_FindClassClick(Sender: TObject);
    procedure rb_Find_IDClick(Sender: TObject);
    procedure rb_Find_NameClick(Sender: TObject);
    procedure bt_StopClick(Sender: TObject);
    procedure sbDeltaIDDownClick(Sender: TObject);
    procedure sbDeltaIDUpClick(Sender: TObject);
    procedure cb_Find_IDKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    ElementOldSelected:IDMElement;                      // *** отладка Gol
    { Private declarations }
  public
   DMDocument:IDMDocument;
//   function Get_FDataModelServer: IDataModelServer; safecall;
    { Public declarations }
  end;

var
  frm_Find: Tfrm_Find;

implementation

{$R *.dfm}

procedure Tfrm_Find.btFindClick(Sender: TObject);
var
 aDocument:IDMDocument;
 aDataModel:ISpatialModel;
 aDataModelE:IDMElement;
 aCollection:IDMCollection;
 aElement:IDMElement;
 aClassAlias:string;
 aFoundAlias:string;

 aFoundElement:IDMElement;
 j, k:integer;
 aCount, aID:integer;
 aName:string;


         function Compare(Element0:IDMElement):boolean;
         // result=True, если Element0 - искомый (по ID или Name)
         // найденый элем.заносится в список (ID или Name), если там его нет
         var
          k,m:integer;
          ListFlag:boolean;
          aName,bName:string;
            function CompStr(Text,SubText:string):boolean;
            var
              i,Len:integer;
              aText,aChar:string;
            begin
             result:= False;
             Len:=Length(SubText);
             aChar:=SubText[Len];
             if aChar='*' then begin
              aText:=SubText;
              Delete(aText, Len, 1);
              Dec(Len);
              for i := 1 to Length(Text) do
               if Copy(Text,i,Len) = aText then begin
                result:= True; {  }
                Break;
               end;
             end else begin
              if Text=SubText then
                result:= True; {  }
             end
            end;

         begin
           result:=False;
           Element0.Selected:=False;
           if rb_Find_ID.Checked then begin
            aID := Element0.ID;
            if aID=StrToInt(cb_Find_ID.Text) then begin
             result:=True;
             Element0.Selected:=True;
             ListFlag:=True;
             for k:=0 to cb_Find_ID.Items.Count-1 do begin
              m:=StrToInt(cb_Find_ID.Items[k]);
              if m=aId then begin
               ListFlag:=False;
               break;
              end;
             end;
             if ListFlag then
              cb_Find_ID.Items.Add(IntToStr(aID))
            end
           end else begin
            aName:=Element0.Name;
            if CompStr(aName,cb_Find_Name.Text) then begin
             result:=True;
             Element0.Selected:=True;
             ListFlag:=True;
             for k:=0 to cb_Find_Name.Items.Count-1 do begin
              bName:=cb_Find_Name.Items[k];
              if bName=aName then begin
               ListFlag:=False;
               break;
              end;
             end;
             if ListFlag then
              cb_Find_Name.Items.Add(aName)
            end;
           end;
         end;

begin

  aDocument:=DMDocument;

  aDataModel:=aDocument.DataModel as ISpatialModel;
  aDataModelE:=aDocument.DataModel as IDMElement;

  lb_Name.Font.Color:= clBlack;
  lb_Name.Caption:= '';

  if ElementOldSelected<>nil then
   ElementOldSelected.Selected:=False;

  if aFoundElement<>nil then
   aFoundElement:=nil;

  aCount:=aDataModelE.CollectionCount;       //кол.коллекций


   aFoundAlias:=cb_FClassAlias.Text;
   for j:=0 to aCount-1 do begin
    aCollection:=aDataModelE.Collection[j];
    if aCollection<>nil then begin
      aClassAlias:=aCollection.ClassAlias[akImenit];
      if aClassAlias=aFoundAlias then begin
       for k:=0 to aCollection.Count-1 do begin
        aElement:=aCollection.Item[k];
        if Compare(aElement) then begin
         aFoundElement:=aElement;
         break;                         {[k]}
        end;
       end;
       break;                           {[j]}
      end;
    end;
   end;

  if aFoundElement=nil then begin
   lb_Name.Font.Color:= clRed;
   lb_Name.Caption:= 'не найдено';
  end else begin
    aName:=aFoundElement.Name;
    lb_Name.Caption:= aName;
    aFoundElement.Selected:=True;
    ElementOldSelected:=aFoundElement;
  end;

end;

procedure Tfrm_Find.cb_FindClassClick(Sender: TObject);
begin
//  if cb_FindClass.Checked then begin
//    cb_FClassAlias.Enabled:=True;
//    rb_Find_ID.Enabled:=True
//  end else begin
//    cb_FClassAlias.Enabled:=False;
//    rb_Find_ID.Checked:=False;
//    rb_Find_ID.Enabled:=False;
//    rb_Find_Name.Checked:=True;
//    pn_Find_Name.Visible:=True;
//  end;
end;

procedure Tfrm_Find.rb_Find_NameClick(Sender: TObject);
begin
 if rb_Find_Name.Checked then begin
  pn_Find_ID.Visible:=False;
  pn_Find_Name.Visible:=True;
 end;
end;

procedure Tfrm_Find.rb_Find_IDClick(Sender: TObject);
begin
 if rb_Find_ID.Checked then begin
  pn_Find_Name.Visible:=False;
  pn_Find_ID.Visible:=True;
 end;
end;

procedure Tfrm_Find.cb_FClassAliasDropDown(Sender: TObject);
var
 aDocument:IDMDocument;
 aDataModelE:IDMElement;
 aCollection:IDMCollection;
 j,aCount:integer;
 aClassAlias:string;
begin
  aDocument:=DMDocument;
  aDataModelE:=aDocument.DataModel as IDMElement;

   cb_FClassAlias.Clear;

  aCount:=aDataModelE.CollectionCount;       //кол.коллекций
  for j:=0 to aCount-1 do begin              //заполнить ComboBox
   aCollection:=aDataModelE.Collection[j];
   if aCollection<>nil then begin
    aClassAlias:=aCollection.ClassAlias[akImenit];
    cb_FClassAlias.Items.Add(aClassAlias);
   end;
  end;
end;


procedure Tfrm_Find.bt_StopClick(Sender: TObject);
begin
 frm_Find.Close;
end;

procedure Tfrm_Find.sbDeltaIDDownClick(Sender: TObject);
var
  D:integer;
begin
  D:=StrToInt(cb_Find_ID.Text)-1;
  if D>-1 then
   cb_Find_ID.Text:=IntToStr(D);
end;

procedure Tfrm_Find.sbDeltaIDUpClick(Sender: TObject);
begin
  cb_Find_ID.Text:=IntToStr(StrToInt(cb_Find_ID.Text)+1);
end;


procedure Tfrm_Find.cb_Find_IDKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btFind.Click
end;

procedure Tfrm_Find.FormShow(Sender: TObject);
var
  j, XMax, YMax:integer;
  Control:TControl;
  P, aP:TPoint;
begin
  P:=Point(Left+Width, Top+Height);
  P:=ClientToScreen(P);

  XMax:=0;
  YMax:=0;
  for j:=0 to ComponentCount-1 do begin
    Control:=Components[j] as TControl;
    aP:=Point(Control.Left+Control.Width, Control.Top+Control.Height);
    aP:=Control.ClientToScreen(aP);
    if XMax<aP.X then
      XMax:=aP.X;
    if YMax<aP.Y then
      YMax:=aP.Y;
  end;
  if P.X<XMax+5 then
    Width:=Width+(XMax+5-P.X);
  if P.Y<YMax+5 then
    Height:=Height+(YMax+5-P.Y);
end;

end.
