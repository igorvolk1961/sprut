unit FMContainerU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  DMContainerU, ImgList, ExtCtrls, ComCtrls, Buttons, ToolWin,
  DataModel_TLB, DMServer_TLB, DMEditor_TLB, FacilityModelLib_TLB,
  SgdbLib_TLB, SpatialModelLib_TLB;

const
  sdmBuildRelief      = $000000F0;
  sdmVDivideVolume    = $000000F1;

type
  TFMContainer = class(TDMContainer)
  private
    FShowSingleLayer:boolean;
  protected
//{$IFDEF VER150}
    procedure ProxyCallRefDialog(Sender: TObject;
                               const DMClassCollectionsU: IUnknown;
                               const RefSourceU: IUnknown;
                               const Suffix: WideString;
                               AskName: WordBool); override;

    procedure ProxyCallDialog(Sender: TObject;
                              Mode: integer;
                              const aCaption: WideString;
                              const aPrompt: WideString); override;
(*
{$ELSE}
    procedure ProxyCallRefDialog(Sender: TObject;
                               var DMClassCollectionsV: OleVariant;
                               var RefSourceV: OleVariant;
                               var Suffix: OleVariant;
                               AskName: WordBool);  override;

    procedure ProxyCallDialog(Sender: TObject;
                              Mode: integer;
                              var aCaption: OleVariant;
                              var aPrompt: OleVariant);  override;
{$ENDIF}
*)
    procedure NewDataModel; override; safecall;
    function LoadDataModel(const aFileName: WideString;
      WriteToRegistryFlag: WordBool): WordBool; override; safecall;
  public
    property ShowSingleLayer:boolean read FShowSingleLayer write FShowSingleLayer;
  end;

var
  FMContainer: TFMContainer;

implementation
uses
  AddRefFrm, _AddRefFrm, ChangeRefFrm,
  AddBoundaryFrm, AddZoneFrm, AddBoundaryLayerFrm,
  BuildReliefFrm, VDivideVolumeFrm, AddJumpFrm;

{$R *.dfm}

{ TFMContainer }

procedure TFMContainer.ProxyCallDialog(Sender: TObject;
                              Mode: integer;
//{$IFDEF VER150}
                              const aCaption: WideString;
                              const aPrompt: WideString);
//{$ELSE}
//                              var aCaption: OleVariant;
//                              var aPrompt: OleVariant);
//{$ENDIF}

var
  Document:IDMDocument;
  DataModel:IDataModel;
  GlobalData:IGlobalData;
begin
//  CriticalSection.Enter;
  try
  case Mode of
  sdmBuildRelief:
    begin
      Document:=FDataModelServer.CurrentDocument;
      DataModel:=Document.DataModel as IDataModel;

      if fmBuildRelief=nil then begin
        fmBuildRelief:=TfmBuildRelief.Create(Self);
      end;
      if fmBuildRelief.ShowModal=mrOK then begin
        FDataModelServer.EventData3:=0;
        if DataModel.QueryInterface(IGlobalData, GlobalData)=0 then
          GlobalData.GlobalValue[1]:=
                fmBuildRelief.rgDeleteVAreaDirection.ItemIndex;
      end else
        FDataModelServer.EventData3:=-1
    end;
  sdmVDivideVolume:
    begin
      if fmVDivideVolume=nil then begin
        fmVDivideVolume:=TfmVDivideVolume.Create(Self);
      end;
      fmVDivideVolume.Value:=FDataModelServer.EventData1;
      if fmVDivideVolume.ShowModal=mrOK then begin
        FDataModelServer.EventData3:=fmVDivideVolume.rgKind.ItemIndex;
        FDataModelServer.EventData1:=fmVDivideVolume.Value;
      end else
        FDataModelServer.EventData3:=-1
    end;
  else
    inherited
  end;
  except
    raise
  end;
end;

procedure TFMContainer.ProxyCallRefDialog(Sender: TObject;
//{$IFDEF VER150}
                               const DMClassCollectionsU: IUnknown;
                               const RefSourceU: IUnknown;
                               const Suffix: WideString;
//{$ELSE}
//                               var DMClassCollectionsV, RefSourceV, Suffix: OleVariant;
//{$ENDIF}
                               AskName: WordBool);
var
  Unk:IUnknown;
  aDMClassCollections:IDMClassCollections;
  aRefSource, SubKinds:IDMCollection;
  Document:IDMDocument;
  Element, aElement:IDMElement;
  SpatialModel:ISpatialModel;
  SpatialModel2:ISpatialModel2;
  FacilityModel:IFacilityModel;
  ClassCollections:IDMClassCollections;
  GlobalData:IGlobalData;
  D:double;
  Err:integer;
  j:integer;
  DataModelE, VolumeE, LayerE:IDMElement;
  Boundary:IBoundary;
  SubKindsFlag:boolean;
  Area:IArea;
  DataModel:IDataModel;
begin
//{$IFDEF VER150}
  aDMClassCollections:=DMClassCollectionsU as IDMClassCollections;
  aRefSource:=RefSourceU as IDMCollection;
//{$ELSE}
//  Unk:=RefSourceV;
//  aRefSource:=Unk as IDMCollection;
//  Unk:=DMClassCollectionsV;
//  aDMClassCollections:=Unk as IDMClassCollections;
//{$ENDIF}

  Document:=FDataModelServer.CurrentDocument;
  DataModel:=Document.DataModel as IDataModel;
  DataModelE:=DataModel as IDMElement;
  SpatialModel:=DataModel as ISpatialModel;
  SpatialModel2:=DataModel as ISpatialModel2;
  FacilityModel:=DataModel as IFacilityModel;
  GlobalData:=DataModelE as IGlobalData;

  if (aRefSource=nil) and
     (aDMClassCollections=nil) then begin
     Unk:=FDataModelServer.EventData1;
     aElement:=Unk as IDMElement;
     if aElement=nil then
       Exit;
     if aElement.QueryInterface(IBoundary, Boundary)=0 then begin
       if aElement.QueryInterface(IArea, Area)=0 then begin
         Area:=aElement.SpatialElement as IArea;
         if Area=nil then Exit;
         if Area.IsVertical then
           GlobalData.GlobalValue[1]:=0
         else
           GlobalData.GlobalValue[1]:=1;
       end else
         GlobalData.GlobalValue[1]:=2;

       if fmAddBoundary=nil then
         fmAddBoundary:=TfmAddBoundary.Create(Self);
       FAddRefForm:=fmAddBoundary;
       fmAddBoundary.Caption:='Изменение типа рубежа';
       fmAddBoundary.PanelWidth.Visible:=False;

       SubKindsFlag:=False;
       if (aElement.Ref<>nil) and
          (aElement.Ref.Parent<>nil) then begin
         SubKinds:=aElement.Ref.Parent.SubKinds;
         if SubKinds<>nil then
           SubKindsFlag:=True;
       end;

       fmAddBoundary.DataModel:=DataModel as IDataModel;
       if aElement.Ref<>nil then
         fmAddBoundary.Kinds:=aElement.Ref.Parent.OwnerCollection
       else
         fmAddBoundary.Kinds:=nil;
       if not SubKindsFlag then
         fmAddBoundary.LastKind:=fmAddBoundary.edKind.Items.IndexOfObject(pointer(aElement.Ref))
       else begin
         fmAddBoundary.LastKind:=fmAddBoundary.edKind.Items.IndexOfObject(pointer(aElement.Ref.Parent));
         fmAddBoundary.edSubKind.ItemIndex:=fmAddBoundary.edSubKind.Items.IndexOfObject(pointer(aElement.Ref));
       end;

       if AskName then begin
         fmAddBoundary.pName.Visible:=True;
         fmAddBoundary.edName.Text:=aElement.Name;
         fmAddBoundary.Suffix:=' '+ExtractLastWord(aElement.Name);
       end else
         fmAddBoundary.pName.Visible:=False;

//  Get_DMEditorX.Say('Изменим тип объекта', True, False);

      if fmAddBoundary.ShowModal=mrOK then begin
        Unk:=fmAddBoundary.ElementSubKind;
        FDataModelServer.EventData1:=Unk;
        FDataModelServer.EventData2:=fmAddBoundary.edName.Text;
        FDataModelServer.EventData3:=0;
        j:=fmAddBoundary.edBoundaryLayerType.ItemIndex;
        GlobalData.GlobalIntf[1]:=IDMELement(pointer(fmAddBoundary.edBoundaryLayerType.Items.Objects[j]));
        GlobalData.GlobalValue[1]:=fmAddBoundary.chbFlowIntencity.ItemIndex;
        j:=fmAddBoundary.edLayer.ItemIndex;
        if fmAddBoundary.chbUseLayer.Checked and
           (j<>-1) then
          GlobalData.GlobalIntf[2]:=IDMELement(pointer(fmAddBoundary.edLayer.Items.Objects[j]))
        else
          GlobalData.GlobalIntf[2]:=nil
      end else
        FDataModelServer.EventData3:=-1;

      FDataModelServer.RefreshDocument(rfFast);
    end else begin
      for j:=1 to 10 do begin
        GlobalData.GlobalValue[j]:=-1;
        GlobalData.GlobalIntf[j]:=nil
      end;
      inherited
    end;
  end else
  if aRefSource<>nil then begin

    if (aRefSource.ClassID<>_BoundaryType) and
       (aRefSource.ClassID<>_BoundaryLayerType) and
       (aRefSource.ClassID<>_ZoneType) and
       (aRefSource.ClassID<>_JumpType) then begin
      FAddRefForm:=nil;
      inherited;
      Exit;
    end;

    case aRefSource.ClassID of
    _BoundaryType:
      begin
        if fmAddBoundary=nil then begin
          fmAddBoundary:=TfmAddBoundary.Create(Self);
          fmAddBoundary.DMEditorX:=Self as IDMEditorX;
        end;
        fmAddBoundary.Caption:='Построение рубежей';
        FAddRefForm:=fmAddBoundary;
        fmAddBoundary.rgBuildDirection.ItemIndex:=SpatialModel2.BuildDirection;
        if SpatialModel2.BuildWallsOnAllLevels then
          fmAddBoundary.rgBuildWallsOnAllLevels.ItemIndex:=1
        else
          fmAddBoundary.rgBuildWallsOnAllLevels.ItemIndex:=0;
        fmAddBoundary.rgBuildDirection.Enabled:=(SpatialModel2.EnabledBuildDirection=3);
        ClassCollections:=FacilityModel as IDMClassCollections;
        if (GlobalData.GlobalValue[2]=1) then begin
          fmAddBoundary.PanelWidth.Visible:=True;
//          fmAddBoundary.rgBuildWallsOnAllLevels.Visible:=False;
          if ClassCollections.DefaultClassCollectionIndex[2, -1]<>btVirtual then
            ClassCollections.DefaultClassCollectionIndex[2, -1]:=btEntryPoint;
          fmAddBoundary.edOldLength.Text:=Format('%0.2f',[GlobalData.GlobalValue[3]/100]);
          fmAddBoundary.edOldWidth.Text:=Format('%0.2f',[GlobalData.GlobalValue[4]/100]);
        end else
        if (GlobalData.GlobalValue[2]=0) then begin
          fmAddBoundary.PanelWidth.Visible:=False;
//          fmAddBoundary.rgBuildWallsOnAllLevels.Visible:=True;
          if ClassCollections.DefaultClassCollectionIndex[2, -1]<>btVirtual then begin
            ClassCollections.DefaultClassCollectionIndex[2, -1]:=btBarrier;
            VolumeE:=GlobalData.GlobalIntf[1] as IDMElement;
            if VolumeE<>nil then begin
              if VolumeE.Ref.Ref.Parent.ID=0 then
                fmAddBoundary.DefaultSubKindIndex:=0
              else
                fmAddBoundary.DefaultSubKindIndex:=1;
            end else
              fmAddBoundary.DefaultSubKindIndex:=-1;
          end;
        end else begin
          fmAddBoundary.PanelWidth.Visible:=True;
        end;
        fmAddBoundary.edWidth.Text:=Format('%0.2f',[SpatialModel2.DefaultVerticalAreaWidth]);
      end;
    _ZoneType:
      begin
        if fmAddZone=nil then begin
          fmAddZone:=TfmAddZone.Create(Self);
          fmAddZone.DMEditorX:=Self as IDMEditorX;
        end;
        FAddRefForm:=fmAddZone;
        if SpatialModel2.EnabledBuildDirection<>2 then
          fmAddZone.rgBuildDirection.ItemIndex:=0
        else
          fmAddZone.rgBuildDirection.ItemIndex:=1;
        fmAddZone.rgBuildDirection.Enabled:=(SpatialModel2.EnabledBuildDirection=3);
        fmAddZone.chbBuildJoinedVolume.Checked:=SpatialModel2.BuildJoinedVolume;
        fmAddZone.chbBuildJoinedVolume.Visible:=boolean(round(GlobalData.GlobalValue[3]));
      end;
    _JumpType:
      begin
        if fmAddJump=nil then begin
          fmAddJump:=TfmAddJump.Create(Self);
          fmAddJump.DMEditorX:=Self as IDMEditorX;
        end;
        FAddRefForm:=fmAddJump;
        ClassCollections:=FacilityModel as IDMClassCollections;
        fmAddJump.PanelWidth.Visible:=True;
        fmAddJump.edWidth.Text:=Format('%0.2f',[SpatialModel2.DefaultObjectWidth]);
      end;
    _BoundaryLayerType:
      begin
        if fmAddBoundaryLayer=nil then begin
          fmAddBoundaryLayer:=TfmAddBoundaryLayer.Create(Self);
          fmAddBoundaryLayer.DMEditorX:=Self as IDMEditorX;
        end;
        FAddRefForm:=fmAddBoundaryLayer;
      end;
    else
      begin
        if fmAddRef=nil then begin
          fmAddRef:=TfmAddRef.Create(Self);
          fmAddRef.DMEditorX:=Self as IDMEditorX;
        end;
        FAddRefForm:=fmAddRef;
      end;
    end;
    FAddRefForm.DataModel:=Document.DataModel as IDataModel;
    FAddRefForm.Kinds:=aRefSource;
    FAddRefForm.Suffix:=Suffix;
    FAddRefForm.DefaultName:=FDataModelServer.EventData2;

    FLastClassIndex:=-1;
    FLastKindIndex:=-1;
    ShowHiddenStatusBar;

{$IFDEF Demo}
    FDMMacrosManager.WriteMacrosEvent(mrDialogEvent, -1, deAddRefInit,
         FLastClassIndex, FLastKindIndex, -1, '');
{$ENDIF}

    FDataModelServer.EventData3:=0;
    if FAddRefForm.ShowModal=mrOK then begin
      case aRefSource.ClassID of
      _BoundaryType:
        begin
          SpatialModel2.BuildDirection:=fmAddBoundary.rgBuildDirection.ItemIndex;
          SpatialModel2.BuildWallsOnAllLevels:=boolean(fmAddBoundary.rgBuildWallsOnAllLevels.ItemIndex);
          Val(fmAddBoundary.edWidth.Text, D, Err);
          SpatialModel2.DefaultVerticalAreaWidth:=D;
          j:=fmAddBoundary.edBoundaryLayerType.ItemIndex;
          GlobalData.GlobalIntf[1]:=IDMELement(pointer(fmAddBoundary.edBoundaryLayerType.Items.Objects[j]));
          GlobalData.GlobalValue[1]:=fmAddBoundary.chbFlowIntencity.ItemIndex;
          if (GlobalData.GlobalValue[2]=1) then
            GlobalData.GlobalValue[5]:=fmAddBoundary.rgMode.ItemIndex;

          j:=fmAddBoundary.edLayer.ItemIndex;
          if fmAddBoundary.chbUseLayer.Checked and
             (j<>-1) then
            GlobalData.GlobalIntf[2]:=IDMELement(pointer(fmAddBoundary.edLayer.Items.Objects[j]))
          else
            GlobalData.GlobalIntf[2]:=nil
        end;
      _ZoneType:
        begin
          SpatialModel2.BuildDirection:=fmAddZone.rgBuildDirection.ItemIndex;
          if fmAddZone.chbBuildJoinedVolume.Visible then
            SpatialModel2.BuildJoinedVolume:=fmAddZone.chbBuildJoinedVolume.Checked;
          Val(fmAddZone.edHeight.Text, D, Err);
          j:=fmAddZone.edKind.ItemIndex;
          case j of
          0: FacilityModel.DefaultOpenZoneHeight:=D;
          1: SpatialModel2.DefaultVolumeHeight:=D;
          end;

          j:=fmAddZone.edBoundaryKind.ItemIndex;
          GlobalData.GlobalIntf[1]:=IDMELement(pointer(fmAddZone.edBoundaryKind.Items.Objects[j]));

          Val(fmAddZone.edCategory.Text, D, Err);
          GlobalData.GlobalValue[1]:=D;

          j:=fmAddZone.chbPersonalPresence.ItemIndex;
          GlobalData.GlobalValue[2]:=j;

          Val(fmAddZone.edPersonalCount.Text, D, Err);
          GlobalData.GlobalValue[3]:=D;

          GlobalData.GlobalValue[4]:=fmAddZone.TransparencyDist;

          Val(fmAddZone.edPedestrialVelocity.Text, D, Err);
          GlobalData.GlobalValue[5]:=D;

          j:=fmAddZone.rgVehicleVelocity.ItemIndex;
          GlobalData.GlobalValue[6]:=j;

          Val(fmAddZone.edVehicleVelocity.Text, D, Err);
          GlobalData.GlobalValue[7]:=D;

        end;
      _JumpType:
        begin
          Val(fmAddJump.edWidth.Text, D, Err);
          SpatialModel2.DefaultObjectWidth:=D;
          j:=fmAddJump.edBoundaryLayerType.ItemIndex;
          GlobalData.GlobalIntf[1]:=IDMELement(pointer(fmAddJump.edBoundaryLayerType.Items.Objects[j]));
        end;
      _BoundaryLayerType:
        begin
          Val(fmAddBoundaryLayer.edDistance.Text, D, Err);
          GlobalData.GlobalValue[1]:=D;

          Val(fmAddBoundaryLayer.edHeight.Text, D, Err);
          GlobalData.GlobalValue[2]:=D;

          j:=ord(fmAddBoundaryLayer.chbDrawJoint.Checked);
          GlobalData.GlobalValue[3]:=j;
        end;
      end;

      Unk:=AddRefForm.ElementSubKind as IUnknown;
      FDataModelServer.EventData1:=Unk;
      FDataModelServer.EventData2:=AddRefForm.edName.Text;
      FDataModelServer.EventData3:=0;
      Element:=Unk as IDMElement;
{$IFDEF Demo}
      if Element<>nil then begin
        if Element.Parent<>nil then
          FDMMacrosManager.WriteAddRefMacros(Element.Parent.ID, Element.ID)
        else
          FDMMacrosManager.WriteAddRefMacros(-1, Element.ID)
      end;
{$ENDIF}
    end else
      FDataModelServer.EventData3:=-1;

    FAddRefForm.DefaultSubKindIndex:=-1;

    FDataModelServer.RefreshDocument(rfFast);
  end else if aDMClassCollections<>nil then begin
    if fm_AddRef=nil then begin
      fm_AddRef:=Tfm_AddRef.Create(Self);
      fm_AddRef.DMEditorX:=Self as IDMEditorX;
    end;
    fm_AddRef.DataModel:=Document.DataModel as IDataModel;
    fm_AddRef.ClassCollectionMode:=FDataModelServer.EventData3;
    fm_AddRef.ClassCollections:=aDMClassCollections;
    fm_AddRef.Suffix:=Suffix;

    FLastClassIndex:=fm_AddRef.LastClassIndex;
    ShowHiddenStatusBar;

{$IFDEF Demo}
    FDMMacrosManager.WriteMacrosEvent(mrDialogEvent, -1, de_AddRefInit,
          FLastClassIndex, FLastKindIndex, -1, '');
{$ENDIF}

    if fm_AddRef.ShowModal=mrOK then begin
      if fm_AddRef.edSubKind.Visible then
        Unk:=fm_AddRef.ElementSubKind as IUnknown
      else
        Unk:=fm_AddRef.ElementKind as IUnknown;
      FDataModelServer.EventData1:=Unk;
      FDataModelServer.EventData2:=fm_AddRef.edName.Text;
      FDataModelServer.EventData3:=fm_AddRef.InstanceClassID;
      Element:=Unk as IDMElement;
{$IFDEF Demo}
      if Element<>nil then begin
        if Element.Parent<>nil then
          FDMMacrosManager.Write_AddRefMacros(Element.Parent.ClassID, Element.Parent.ID, Element.ID)
        else
          FDMMacrosManager.Write_AddRefMacros(-1, -1, Element.ID)
      end;
{$ENDIF}
    end else
      FDataModelServer.EventData3:=-1;

    FDataModelServer.RefreshDocument(rfFast);
  end;
end;

procedure TFMContainer.NewDataModel;
var
  Document:IDMDocument;
  FacilityModel:IFacilityModel;
begin
  inherited;
  Document:=FDataModelServer.CurrentDocument;
  FacilityModel:=Document.DataModel as IFacilityModel;
  FacilityModel.ShowSingleLayer:=FShowSingleLayer;
end;

function TFMContainer.LoadDataModel(const aFileName: WideString;
      WriteToRegistryFlag: WordBool): WordBool;
var
  Document:IDMDocument;
  FacilityModel:IFacilityModel;
begin
  Result:=inherited LoadDataModel(aFileName, WriteToRegistryFlag);
  if not Result then Exit;
  Document:=FDataModelServer.CurrentDocument;
  FacilityModel:=Document.DataModel as IFacilityModel;
  FacilityModel.ShowSingleLayer:=FShowSingleLayer;
end;

end.
