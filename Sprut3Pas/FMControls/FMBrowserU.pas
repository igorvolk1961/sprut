unit FMBrowserU;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  DM_AxCtrls,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdVcl, Menus,
  DMServer_TLB, FacilityModelLib_TLB,
  ImgList, StdCtrls, Grids, ComCtrls, ExtCtrls,
{$IFDEF VirtualTree}
  DMVBrowserU,
{$ENDIF}
  DMBrowserU;

type
  TFMBrowser = class(TDMBrowser)
  private
  protected
    procedure CallCustomDialog(Mode: Integer; const aCaption: WideString; const aPrompt: WideString); override; safecall;
  end;

implementation

uses BuildPathFrm;

{$R *.dfm}

{ TFMBrowserX }

{ TFMBrowserX }

procedure TFMBrowser.CallCustomDialog(Mode: Integer; const aCaption,
  aPrompt: WideString);
var
  DataModelServer:IDataModelServer;
begin
  case Mode of
  20:begin
       if fmBuildPath=nil then
         fmBuildPath:=TfmBuildPath.Create(Self);
       DataModelServer:=Get_DataModelServer as IDataModelServer;
       DataModelServer.EventData3:=-1;
       fmBuildPath.edName.Text:=DataModelServer.EventData2;
       fmBuildPath.FacilityModel:=GetDataModel as IFacilityModel;
       if fmBuildPath.ShowModal=mrOK then begin
         DataModelServer.EventData3:=fmBuildPath.rgPathKind.ItemIndex;
         DataModelServer.EventData2:=fmBuildPath.edName.Text;
       end;
     end;
  end;
end;

end.
