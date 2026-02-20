unit SMBuildSectorsOperationU;

interface
uses
   Classes,  Math, Variants, SysUtils,Dialogs,
   SpatialModelLib_TLB, DMServer_TLB, DataModel_TLB,
   DMElementU, SMSelectOperationU, SMOperationConstU, SectorBuilderLib_TLB,
   CustomSMDocumentU;

const
  sdmBuildBuildSectors = 40;

type

  TBuildSectorsOperation=class(TSelectVolumeOperation)
  private
    FDone:boolean;
  public
    procedure Stop(const SMDocument:TCustomSMDocument;
                      ShiftState: integer); override;
    procedure GetStepHint(aStep:integer; var Hint:string; var ACursor:integer);override;
  end;

implementation

var
  FSectorBuilder:ISectorBuilder;

{ TBuildBuildSectorsOperation }

procedure TBuildSectorsOperation.GetStepHint(aStep: integer;
  var Hint: string; var ACursor: integer);
begin
  Hint:='РАЗБИЕНИЕ ЗОН НА СЕКТОРЫ: Укажите зону (SHIFT - выделение рамкой, CTRL - добавить к выделению, F6 - выполнить операцию)';
  ACursor:=cr_Build_Sectors;
end;

procedure TBuildSectorsOperation.Stop(const SMDocument: TCustomSMDocument;
  ShiftState: integer);
var
  DMDocument:IDMDocument;
begin
  DMDocument:=SMDocument as IDMDocument;
  if FSectorBuilder=nil then
    FSectorBuilder:=CoSectorBuilder.Create;
  FSectorBuilder.FacilityModel:=DMDocument.DataModel;
  FSectorBuilder.BuildSectors;
end;

initialization
finalization
  FSectorBuilder:=nil;
end.
