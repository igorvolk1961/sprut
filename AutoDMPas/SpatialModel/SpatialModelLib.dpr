library SpatialModelLib;

uses
  ComServ,
  SpatialModelLib_TLB in 'SpatialModelLib_TLB.pas',
  CoordNodeU in 'CoordNodeU.pas',
  CurvedLineU in 'CurvedLineU.pas',
  AreaU in 'AreaU.pas',
  ImageRectU in 'ImageRectU.pas',
  SMLabelU in 'SMLabelU.pas',
  LineU in 'LineU.pas',
  LineGroupU in 'LineGroupU.pas',
  CustomSpatialElementU in 'CustomSpatialElementU.pas',
  ViewU in 'ViewU.pas',
  VolumeU in 'VolumeU.pas',
  SMViewOperationU in 'SMViewOperationU.pas',
  SMCreateOperationU in 'SMCreateOperationU.pas',
  SMEditOperationU in 'SMEditOperationU.pas',
  SMOperationU in 'SMOperationU.pas',
  SMSelectOperationU in 'SMSelectOperationU.pas',
  SMTransformOperationU in 'SMTransformOperationU.pas',
  BuildFMVolumeOperationU in 'BuildFMVolumeOperationU.pas',
  SpatialModelU in 'SpatialModelU.pas',
  SMOperationConstU in 'SMOperationConstU.pas',
  CustomSMDocumentU in 'CustomSMDocumentU.pas',
  SMDocumentU in 'SMDocumentU.pas' {SMDocument: CoClass},
  CustomSpatialModelU in 'CustomSpatialModelU.pas' {SpatialModel: CoClass},
  SMBuildOperationU in 'SMBuildOperationU.pas',
  SorterU in '..\DataModelPackage\SorterU.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer,

  GetDMDocumentClassObject;

{$R *.tlb}

{$R *.res}

begin
end.
