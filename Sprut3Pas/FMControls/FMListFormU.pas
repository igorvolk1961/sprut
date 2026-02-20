unit FMListFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DMListFormU, ImgList, StdCtrls, ExtCtrls,
  DataModel_TLB, FacilityModelLib_TLB, SgdbLib_TLB;

const
   fcSubBoundary=4; //'Подрубежи'
   fcNoLock=5;      //'Двери без замков'
   fcDisabled=6;    //'Исключенные из анализа'

type
  TFMListForm = class(TDMListForm)
    chbSelectParents: TCheckBox;
  protected
    function Substitute(const aElement:IDMElement):IDMElement; override;
    function GetAddFlag(const aElement:IDMElement; FilterIndex:integer):boolean; override;
    procedure MakeFilterList; override;
  public
    { Public declarations }
  end;

var
  FMListForm: TFMListForm;

implementation

{$R *.dfm}

function TFMListForm.GetAddFlag(const aElement: IDMElement;
  FilterIndex: integer): boolean;
var
  Boundary:IBoundary;
  j, m:integer;
  BoundaryLayer:ISafeguardUnit;
  SafeguardElementE:IDMElement;
  BarrierKind:IBarrierKind;
  FilterCode:integer;
begin
  Result:=inherited GetAddFlag(aElement, FilterIndex);
  FilterCode:=integer(pointer(cbFilter.Items.Objects[FilterIndex]));
  if aElement.ClassID=_SubBoundary then
    Result:=Result and (FilterCode=fcSubBoundary)
  else
  if aElement.ClassID=_Boundary then begin
    Result:=Result and (FilterCode<>fcSubBoundary);
    case FilterIndex of
    fcNoLock:
      begin
        Boundary:=aElement as IBoundary;
        j:=0;
        while j<Boundary.BoundaryLayers.Count do begin
          BoundaryLayer:=Boundary.BoundaryLayers.Item[j] as ISafeguardUnit;
          m:=0;
          while m<BoundaryLayer.SafeguardElements.Count do begin
            SafeguardElementE:=BoundaryLayer.SafeguardElements.Item[m];
            if SafeguardElementE.ClassID=_Lock then
              Break
            else
            if SafeguardElementE.ClassID=_Barrier then begin
              BarrierKind:=SafeguardElementE.Ref as IBarrierKind;
              if BarrierKind.ContainLock then
                Break
              else
                inc(m)
            end else
              inc(m)
          end;
          if m<BoundaryLayer.SafeguardElements.Count then
            Break
          else
            inc(j);
        end;
        Result:=(j=Boundary.BoundaryLayers.Count) // не нашли замка
      end;
    fcDisabled:
      Result:=(aElement as IPathElement).Disabled;
    end;
  end else
  if aElement.ClassID=_Zone then begin
    case FilterIndex of
    fcDisabled:
      Result:=(aElement as IPathElement).Disabled;
    end;  
  end;
end;

procedure TFMListForm.MakeFilterList;
var
  BackRefHolderIndex:integer;
  P:pointer;
  aBackRefHolderE:IDMElement;
begin
  inherited;
  BackRefHolderIndex:=lbox_BackRefHolders.ItemIndex;
  if BackRefHolderIndex=-1 then Exit;
  P:=pointer(lbox_BackRefHolders.Items.Objects[BackRefHolderIndex]);
  aBackRefHolderE:=IDMElement(P);
  if aBackRefHolderE.Ref.ClassID=_BoundaryKind then begin
    cbFilter.Items.AddObject('Подрубежи', pointer(fcSubBoundary));
    cbFilter.Items.AddObject('Двери без замков', pointer(fcNoLock));
  end;
  case aBackRefHolderE.Ref.ClassID of
  _BoundaryKind,
  _ZoneKind:
    cbFilter.Items.AddObject('Исключенные из анализа', pointer(fcDisabled));
  end;  
end;

function TFMListForm.Substitute(const aElement: IDMElement): IDMElement;
var
  aParent:IDMelement;
begin
  Result:=aElement;
  if chbSelectParents.Checked then begin
    aParent:=aElement.Parent;
    if aParent<>nil then begin
      if aParent.ClassID=_BoundaryLayer then
        aParent:=aParent.Parent;
      Result:=aParent;
    end;
  end;
end;

end.
