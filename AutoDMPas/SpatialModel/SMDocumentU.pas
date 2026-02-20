unit SMDocumentU;


{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Classes, SysUtils, Dialogs, SpatialModelLib_TLB, DataModel_TLB, DMServer_TLB,
  CustomSMDocumentU, DMComObjectU;

function GetDMDocumentClassObject:IDMClassFactory;

type
  TSMDocumentFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;

  TSMDocument = class(TCustomSMDocument)
  private
  protected
  end;
implementation

uses
  DM_ComObj;

{ TSMDocumentFactory }

function TSMDocumentFactory.CreateInstance: IUnknown;
begin
  Result:=TSMDocument.Create(nil) as IUnknown
end;

function GetDMDocumentClassObject:IDMClassFactory;
begin
  Result:=TSMDocumentFactory.Create(nil) as IDMClassFactory
end;

initialization
//  CreateAutoObjectFactory(TSMDocument, Class_SMDocument);
end.
