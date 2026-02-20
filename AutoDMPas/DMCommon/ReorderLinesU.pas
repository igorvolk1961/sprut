unit ReorderLinesU;

interface
uses
  Classes,
  DataModel_TLB, SpatialModelLib_TLB;

procedure ReorderLines0(const Lines:IDMCollection; const LineParent:IDMElement);

implementation

procedure ReorderLines0(const Lines:IDMCollection; const LineParent:IDMElement);
var
  j:integer;
  Line:ILine;
  LineE:IDMElement;
  TMPList:TList;
  C0, C1:ICoordNode;
  Lines2:IDMCollection2;
  PrevCount:integer;
begin
  if Lines.Count<2 then Exit;
  Lines2:=Lines as IDMCollection2;
  TMPList:=TList.Create;
  LineE:=Lines.Item[0];
  Line:=LineE as ILine;
  C0:=Line.C0;
  C1:=Line.C1;
  Lines2.Delete(0);
  TMPList.Add(pointer(LineE));
  while Lines.Count>0 do begin
    j:=0;
    while j<Lines.Count do begin
      LineE:=Lines.Item[j];
      Line:=LineE as ILine;
      if C0=Line.C0 then begin
        C0:=Line.C1;
        TMPList.Insert(0, pointer(LineE));
        Break
      end else
      if C1=Line.C0 then begin
        C1:=Line.C1;
        TMPList.Add(pointer(LineE));
        Break
      end else
      if C0=Line.C1 then begin
        C0:=Line.C0;
        TMPList.Insert(0, pointer(LineE));
        Break
      end else
      if C1=Line.C1 then begin
        C1:=Line.C0;
        TMPList.Add(pointer(LineE));
        Break
      end else
        inc(j);
    end;
    if j<Lines.Count then
      Lines2.Delete(j)
    else begin
      while Lines.Count>0 do begin
        LineE:=Lines.Item[0];
        PrevCount:=Lines.Count;
        if LineParent<>nil then
          LineE.RemoveParent(LineParent);

        if PrevCount=Lines.Count then
          (Lines as IDMCollection2).Delete(0)
      end;
    end
  end;

  for j:=0 to TMPList.Count-1 do
    Lines2.Add(IDMElement(TMPList[j]));

  TMPList.Free
end;

end.
 