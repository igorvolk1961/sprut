unit CalcDelayTimeLib;

interface
uses
  Classes, SysUtils,
  DMElementU, DataModel_TLB, SpatialModelLib_TLB,
  DMServer_TLB, SgdbLib_TLB, FacilityModelLib_TLB;

function CalcDelayTimeByEc(const WarriorGroupE: IDMElement;
                          const OvercomeMethod:IOvercomeMethod; aEc:double):double;

implementation

function CalcDelayTimeByEc(const WarriorGroupE: IDMElement;
                          const OvercomeMethod:IOvercomeMethod; aEc:double): double;
var
  j:integer;
  SumA, MaxB, A, B:double;
  aToolTypeE, aToolE:IDMElement;
  aToolKind:IToolKind;
  WarriorGroup:IWarriorGroup;
begin
  Result:=InfinitValue;

  WarriorGroup:=WarriorGroupE as IWarriorGroup;

  SumA:=0;
  MaxB:=0;
  for j:=0 to OvercomeMethod.ToolTypes.Count-1 do begin
    aToolTypeE:=OvercomeMethod.ToolTypes.Item[j];
    aToolE:=(WarriorGroup.Tools as IDMCollection2).GetItemByRefParent(aToolTypeE);
    if aToolE=nil then Exit;  //  у нарушителей нет нужного инструмента
    aToolKind:=aToolE.Ref as IToolKind;

    A:=aToolKind.BaseEc;
    B:=aToolKind.CoeffEc;

    SumA:=SumA+A;
    if MaxB<B then
      MaxB:=B;
  end;
  if MaxB=0 then begin
    WarriorGroupE.DataModel.HandleError
    ('Ошибка в прцедуре CalcDelayTimeByEc: MaxB=0');
    Raise Exception.Create('');
  end;

  if aEc<SumA then
    Result:=InfinitValue  // способ не рационален (из пушки по воробьям)
  else
    Result:=60*(aEc-SumA)/MaxB;
end;

end.
