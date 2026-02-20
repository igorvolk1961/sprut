unit DMDocument;

interface

uses
  DMServer_TLB, DMComObjectU, DataModel_TLB,
  CustomDMDocument, StdVcl;

function GetDMDocumentClassObject:IDMClassFactory;

type
  TDMDocumentFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;

  TDMDocument = class(TCustomDMDocument, IDMDocument)
  protected
  end;

implementation

uses
  DM_ComObj;

{ TDMDocumentFactory }

function TDMDocumentFactory.CreateInstance: IUnknown;
begin
  Result:=TDMDocument.Create(nil) as IUnknown
end;

function GetDMDocumentClassObject:IDMClassFactory;
begin
  Result:=TDMDocumentFactory.Create(nil) as IDMClassFactory
end;

initialization
//  CreateAutoObjectFactory(TDMDocument, Class_DMDocument);
end.
