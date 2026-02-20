unit SgdbU;

interface

uses
  DM_Windows, DM_ComObj,
  Classes, SysUtils,
  SgdbLib_TLB, StdVcl, DMComObjectU,
  SafeguardDatabaseU, DataModel_TLB;

function GetDataModelClassObject:IDMClassFactory;

type
  TSgdbFactory=class(TDMComObject, IDMClassFactory)
  protected
    function CreateInstance:IUnknown; safecall;
  end;

  TSgdb = class(TSafeguardDatabase)
  private
  protected
// методы IDataModel
  public
  end;

implementation



{ TSgdbFactory }

function TSgdbFactory.CreateInstance: IUnknown;
begin
  Result:=TSgdb.Create(nil) as IUnknown;
end;

function GetDataModelClassObject:IDMClassFactory;
begin
  Result:=TSgdbFactory.Create(nil) as IDMClassFactory
end;

initialization
//  CreateTypedComObjectFactory(TSgdb, Class_Sgdb);
end.
