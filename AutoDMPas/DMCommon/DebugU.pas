unit DebugU;

interface
const
  MaxDebugRecordsCount=10000;
  
var
  DebugFile:TextFile;
  DebugRecordsCount:integer;
  DebugFlag:boolean;
  DebugKey:boolean;

implementation

initialization
{$I+}
  AssignFile(DebugFile, 'Debug.txt');
  Rewrite(DebugFile);
  DebugRecordsCount:=0;
finalization
  if not TTextRec(DebugFile).Mode=fmClosed then
    CloseFile(DebugFile);
end.
