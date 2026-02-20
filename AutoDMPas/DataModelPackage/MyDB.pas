unit MyDB;

interface
uses
  DAO_TLB, Variants, Classes, ComObj, Dialogs;

const
  fvtInteger = $00000000;
  fvtFloat = $00000001;
  fvtBoolean = $00000002;
  fvtString = $00000003;
  fvtElement = $00000004;
  fvtText = $00000005;
  fvtColor = $00000006;
  fvtFile = $00000007;
  fvtChoice = $00000008;

type  
  EWrongPasswordException=class(EOleException)
  end;


procedure MyDBAddRecord(const aRecordSetU:IUnknown);
procedure MyDBSetFieldValue(const aRecordSetU:IUnknown;
                            const aFieldName:string;
                            const aValue:OleVariant);
function  MyDBGetFieldValue(const aRecordSetU:IUnknown;
                            const aFieldName:string): OleVariant;
function  MyDBFindFieldValue(const aRecordSetU:IUnknown;
                            const aFieldName:string;
                             var aValue:OleVariant): boolean;
procedure MyDBUpdateRecordSet(const aRecordSetU:IUnknown);
procedure  MyDBCreateTable(const aDataBaseU:IUnknown;
                          const aTableName:string;
                          const FieldList:TStringList;
                          const PrimaryKeyName:string);
function MyDBOpenRecordset(const aDataBaseU:IUnknown;
                           const aTableName:string;
                           WriteFlag:boolean):IUnknown;
procedure MyDBCloseRecordset(const aRecordsetU:IUnknown);
function  MyDBRecordsetEOF(const aRecordSetU:IUnknown):boolean;
procedure MyDBRecordsetMoveNext(const aRecordSetU:IUnknown);
procedure MyDBInitEngine;
function  MyDBOpenDataBase(const DatabaseFileName:string;
                     const Options, ReadOnly, Connect:OleVariant):IUnknown;
function  MyDBCreateDataBase(const DatabaseFileName:string; const Connect:OleVariant):IUnknown;
procedure MyDBCloseDataBase(const aDataBaseU:IUnknown);
procedure MyDBCloseEngine;

implementation
var
  aDBEngine:_DBEngine;
  aWorkSpace:WorkSpace;

function  MyDBFindTableDef(const aDataBaseU:IUnknown;
                          const aTableName:string;
                          var aTableDefU:IUnknown):boolean;
var
  j:integer;
  aDataBase:DataBase;
  aTableDef:TableDef;
begin
  aDataBase:=aDataBaseU as DataBase;
  j:=0;
  while j<aDataBase.TableDefs.Count do begin
    aTableDef:=aDataBase.TableDefs[j];
    if aTableDef.Name=aTableName then
      Break
    else
      inc(j)
  end;
  if j=aDataBase.TableDefs.Count then begin
    Result:=False;
    aTableDefU:=nil;
  end else begin
    Result:=True;
    aTableDefU:=aTableDef;
  end;
end;


procedure MyDBAddRecord(const aRecordSetU:IUnknown);
var
  aRecordSet:RecordSet;
begin
  aRecordSet:=aRecordSetU as RecordSet;
  aRecordSet.AddNew;
end;

procedure MyDBSetFieldValue(const aRecordSetU:IUnknown;
                            const aFieldName:string;
                            const aValue:OleVariant);
var
  aRecordSet:RecordSet;
begin
  try
  aRecordSet:=aRecordSetU as RecordSet;
  aRecordSet.Fields.Item[aFieldName].Value:=aValue;
  except
    raise
  end;  
end;

function  MyDBGetFieldValue(const aRecordSetU:IUnknown;
                            const aFieldName:string): OleVariant;
var
  aRecordSet:RecordSet;
begin
  aRecordSet:=aRecordSetU as RecordSet;
  Result:=aRecordSet.Fields.Item[aFieldName].Value;
end;

function MyDBFindFieldValue(const aRecordSetU:IUnknown;
                             const aFieldName:string;
                             var aValue:OleVariant): boolean;
var
  aRecordSet:RecordSet;
  S:string;
  j, i:integer;
  aField:Field;
begin
  aRecordSet:=aRecordSetU as RecordSet;
  j:=0;
  while j<aRecordSet.Fields.Count do begin
    S:=aRecordSet.Fields.Item[j].Name;
    i:=Pos(' ', S);
    S:=Copy(S, i+1, 64);
    if S=aFieldName then
      Break
    else
      inc(j);
  end;
  if j=aRecordSet.Fields.Count then
    Result:=False
  else begin
    Result:=True;
    aField:=aRecordSet.Fields.Item[j];
    aValue:=aField.Value;
  end;
end;


procedure MyDBUpdateRecordSet(const aRecordSetU:IUnknown);
var
  aRecordSet:RecordSet;
begin
  aRecordSet:=aRecordSetU as RecordSet;
  if aRecordSet.EditMode=dbEditAdd then
    aRecordSet.Update(dbUpdateRegular, False);
end;

procedure MyDBCreateTable(const aDataBaseU:IUnknown;
                         const aTableName:string;
                         const FieldList:TStringList;
                         const PrimaryKeyName:string);
var
  aDatabase: Database;
  aTableDef:TableDef;
  aIndex:Index;
  j, FT:integer;
  FieldName:string;
  FieldValueType:integer;
begin
  aDatabase:=aDatabaseU as Database;
  aTableDef:=aDataBase.CreateTableDef(aTableName, 0, '', '');
  for j:=0 to FieldList.Count-1 do begin
    FieldName:=FieldList[j];
    FieldValueType:=integer(FieldList.Objects[j]);

    case FieldValueType of
    fvtInteger: FT:=dbLong;
    fvtFloat:   FT:=dbDouble;
    fvtBoolean: FT:=dbBoolean;
    fvtString,
    fvtFile:    FT:=dbText;
    fvtText:    FT:=dbMemo;
    else        FT:=dbLong;
    end;
    aTableDef.Fields.Append(aTableDef.CreateField(FieldName, FT, 0));
    case FT of
    dbText,dbMemo:
      aTableDef.Fields.Item[FieldName].Set_AllowZeroLength(True);
    end;
  end;
  aDataBase.TableDefs.Append(aTableDef);

  if PrimaryKeyName<>'' then begin
    aIndex:=aTableDef.CreateIndex(PrimaryKeyName);
    with aIndex do begin
      Fields.Append(CreateField(PrimaryKeyName, dbInteger, 4));
      Set_Primary(False);
      Set_Unique(False);
    end;
    aTableDef.Indexes.Append(aIndex);
  end;
end;

function  MyDBRecordsetEOF(const aRecordSetU:IUnknown):boolean;
var
  aRecordSet:RecordSet;
begin
  aRecordSet:=aRecordSetU as RecordSet;
  Result:=aRecordSet.EOF;
end;

procedure MyDBRecordsetMoveNext(const aRecordSetU:IUnknown);
var
  aRecordSet:RecordSet;
begin
  aRecordSet:=aRecordSetU as RecordSet;
  aRecordSet.MoveNext;
end;

function MyDBOpenRecordset(const aDataBaseU:IUnknown;
                          const aTableName:string;
                          WriteFlag:boolean):IUnknown;
var
  aTableDefU:IUnknown;
  aTableDef:TableDef;
  aRecordSet:RecordSet;
begin
  if not MyDBFindTableDef(aDataBaseU, aTableName, aTableDefU)
     then Exit;
  aTableDef:=aTableDefU as TableDef;
  if WriteFlag then
    aRecordSet:=aTableDef.OpenRecordset(dbOpenTable, dbAppendOnly)
  else
    aRecordSet:=aTableDef.OpenRecordset(dbOpenTable, dbReadOnly);
  Result:=aRecordSet;
end;

procedure MyDBCloseRecordset(const aRecordsetU:IUnknown);
var
  aRecordSet:RecordSet;
begin
  aRecordSet:=aRecordSetU as RecordSet;
  aRecordSet.Close;
end;

procedure MyDBInitEngine;              
begin
  aDBEngine:=CoDBEngine.Create as _DBEngine;                
end;

function  MyDBOpenDataBase(const DatabaseFileName:string;
                     const Options, ReadOnly, Connect:OleVariant):IUnknown;
begin
  aWorkSpace:=aDBEngine.CreateWorkSpace('WS', 'admin', '', dbUseJet);
  try
    Result:=aWorkSpace.OpenDataBase(DatabaseFileName,
                     Options, ReadOnly, Connect)
  except
    on E:EOleException do begin
      aWorkSpace:=nil;
      aDBEngine:=nil;
      if (E.ErrorCode=-2146825257) or
         (E.ErrorCode=-2146825287) then begin
        ShowMessage('Неправильный пароль. Программа будет заверщена');
      end else
        raise
    end else
      raise
  end;
end;

function  MyDBCreateDataBase(const DatabaseFileName:string; const Connect:OleVariant):IUnknown;
begin
  aWorkSpace:=aDBEngine.CreateWorkSpace('WS', 'admin', '', dbUseJet);
  Result:=aWorkSpace.CreateDataBase(DatabaseFileName, Connect, dbVersion40);
end;

procedure MyDBCloseDataBase(const aDataBaseU:IUnknown);
var
  aDataBase:DataBase;
begin
  aDataBase:=aDataBaseU as DataBase;
  aDataBase.Close;
  aWorkSpace:=nil;
end;

procedure MyDBCloseEngine;
begin
  aDBEngine:=nil;
end;

end.
