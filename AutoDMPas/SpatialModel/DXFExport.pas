unit DXFExport;

interface
uses
  SysUtils, Graphics,
  SpatialModels, SpatialElementLayerU;

procedure ExportDXF(FileName:string; SpatialModel:TSpatialModel);

implementation
uses
  CoordNodes, Lines;

const
  ColorTable:array[1..7] of TColor=
   (clRed, clYellow, clGreen, clLime, clBlue, clPurple, clBlack);
type
  TFlags=0..15;
  TFlagSet=set of TFlags;
  PFlagSet=^TFlagSet;
  TWaitingFlag=(wfDummy, wfCode, wfString, wfByte, wfInteger, wfFloat);
  TDXFSection=(secNUL,
               secHEADER, secCLASSES, secTABLES, secBLOCKS,
               secENTITIES,  secOBJECTS);
  TDXFTable=(tblNUL,
             tblAPPID, tblBLOCK_RECORD, tblDIMSTYLE, tblLAYER,
             tblLTYPE, tblSTYLE, tblUCS, tblVIEW, tblVPORT);

  TDXFEntity=(entNul,
              ent3DFACE, ent3DSOLID, entARC, entATTDEF, entATTRIB,
              entBODY, entCIRCLE, entDIMENSION, entELLIPSE, entHATCH,
              entIMAGE, entINSERT, entLEADER, entLINE, entLWPOLYLINE,
              entMLINE, entMTEXT, entOLEFRAME, entOLE2FRAME, entPOINT,
              entPOLYLINE, entRAY, entREGION, entSEQEND, entSHAPE,
              entSOLID, entSPLINE, entTEXT, entTOLERANCE, entTRACE,
              entVERTEX, entVIEWPORT, entXLINE, entACAD_PROXY_ENTITY);

function FindLayerByName(S:string; SpatialModel:TSpatialModel):TSpatialElementLayer;
var j:integer;
begin
  j:=0;
  while (j<SpatialModel.Layers.Count) and
        (S<>SpatialModel.Layers[j].Ident) do
    inc(j);
  if j<SpatialModel.Layers.Count then
    Result:=SpatialModel.Layers[j]
  else
    Result:=nil;
end;

procedure ExportDXF(FileName:string; SpatialModel:TSpatialModel);
var
  F:TextFile;
  Code:integer;
  S, SV:string;
  IV:integer;
  FV:double;
  WaitingFlag:TWaitingFlag;
  DXFSection:TDXFSection;
  DXFTable:TDXFTable;
  DXFEntity:TDXFEntity;
  aLayer:TSpatialElementLayer;
  aLine:TLine;
  FlagSet, VertexFlagSet:PFlagSet;
  FirstCoord, PrevCoord:TCoordNode;
  Thickness, Elevation:double;
  VerticesJ, VerticesCount:integer;
  aColor:TColor;
begin
  AssignFile(F, FileName);
  Reset(F);
  WaitingFlag:=wfCode;
  DXFSection:=secNUL;
  DXFTable:=tblNUL;
  DXFEntity:=entNUL;
  Code:=0;
  aLine:=nil;
  aLayer:=nil;
  VerticesJ:=0;
  VerticesCount:=0;
  Elevation:=0;
  Thickness:=0;
  FlagSet:=nil;
  VertexFlagSet:=nil;
  FirstCoord:=nil;
  PrevCoord:=nil;
  while not EOF(F) do begin
    case WaitingFlag of
    wfDummy:
      begin
        readln(F);
        WaitingFlag:=wfCode;
      end;
    wfCode:
      begin
        readln(F, Code);
        case Code of
        0..9:    WaitingFlag:=wfString;
        10..59:  WaitingFlag:=wfFloat;    //3D point
        60..79:  WaitingFlag:=wfInteger;  //16-bit integer value
        90..99:  WaitingFlag:=wfInteger;  //32-bit integer value
        100, 102:WaitingFlag:=wfString;
        105:     WaitingFlag:=wfString;    //hex handle value
        140..147:WaitingFlag:=wfFloat;     //Double precision scalar floating-point value
        170..178:WaitingFlag:=wfInteger;   //16-bit integer value
        270..275:WaitingFlag:=wfInteger;   //8-bit integer value
        280..289:WaitingFlag:=wfInteger;   //8-bit integer value
        300..309:WaitingFlag:=wfString;    //Arbitrary text string
        310..319:WaitingFlag:=wfString;    //hex value of binary chunk
        320..329:WaitingFlag:=wfString;    //hex handle value
        330..369:WaitingFlag:=wfString;    //hex object IDs
        999:     WaitingFlag:=wfString;	   //Comment
        1000..1009:WaitingFlag:=wfString;
        1010..1059:WaitingFlag:=wfFloat;   //Floating-point value
        1060..1070:WaitingFlag:=wfInteger; //16-bit integer value
        1071:      WaitingFlag:=wfInteger; //32-bit integer value        2:  WaitingFlag:=wfString;
        else
            WaitingFlag:=wfDummy;
        end;
      end;
    wfString:
      begin
        readln(F, SV);
        WaitingFlag:=wfCode;
        S:=trim(SV);
        case Code of
        0:begin
            if S='SECTION' then begin end
            else if S='CLASS' then begin end
            else if S='TABLE' then begin end
            else if S='ENDSEC' then
              DXFSection:=secNUL
            else if S='ENDTAB' then
              DXFTable:=tblNUL
            else if S='EOF' then
              Break
            else if S='3DFACE' then
              DXFEntity:=ent3DFACE
            else if S='3DSOLID' then
              DXFEntity:=ent3DSOLID
            else if S='ARC' then
              DXFEntity:=entARC
            else if S='ATTDEF' then
              DXFEntity:=entATTDEF
            else if S='ATTRIB' then
              DXFEntity:=entATTRIB
            else if S='BODY' then
              DXFEntity:=entBODY
            else if S='CIRCLE' then
              DXFEntity:=entCIRCLE
            else if S='DIMENSION' then
              DXFEntity:=entDIMENSION
            else if S='ELLIPSE' then
              DXFEntity:=entELLIPSE
            else if S='HATCH' then
              DXFEntity:=entHATCH
            else if S='IMAGE' then
              DXFEntity:=entIMAGE
            else if S='INSERT' then
              DXFEntity:=entINSERT
            else if S='LEADER' then
              DXFEntity:=entLEADER
            else if S='LINE' then begin
              DXFEntity:=entLINE;
              aLine:=pointer(SpatialModel.Lines.CreateElement(False));
              SpatialModel.Lines.Add(aLine);
              aLine.C0:=pointer(SpatialModel.CoordNodes.CreateElement(False));
              SpatialModel.CoordNodes.Add(aLine.C0);
              aLine.C1:=pointer(SpatialModel.CoordNodes.CreateElement(False));
              SpatialModel.CoordNodes.Add(aLine.C1);
              aLine.C0.Z:=0;
              aLine.C1.Z:=0;
            end else if S='LWPOLYLINE' then begin
              DXFEntity:=entLWPOLYLINE;
              aLine:=nil;
              Elevation:=0;
              Thickness:=0;
              VerticesJ:=0;
            end else if S='MLINE' then
              DXFEntity:=entMLINE
            else if S='MTEXT' then
              DXFEntity:=entMTEXT
            else if S='OLEFRAME' then
              DXFEntity:=entOLEFRAME
            else if S='OLE2FRAME' then
              DXFEntity:=entOLE2FRAME
            else if S='POINT' then
              DXFEntity:=entPOINT
            else if S='POLYLINE' then begin
              DXFEntity:=entPOLYLINE;
              aLine:=nil;
              Elevation:=0;
              Thickness:=0;
              VerticesJ:=0;
            end else if S='RAY' then
              DXFEntity:=entRAY
            else if S='REGION' then
              DXFEntity:=entREGION
            else if S='SEQEND' then begin
              if DXFEntity=entVertex then begin
                if (0 in FlagSet^) then
                  aLine.C1:=FirstCoord
                else begin
                  aLine.RemoveParent(aLine.C0);
                  SpatialModel.Lines.RemoveInstance(aLine);
                end;
              end;
              DXFEntity:=entNul;
            end else if S='SHAPE' then
              DXFEntity:=entSHAPE
            else if S='SOLID' then
              DXFEntity:=entSOLID
            else if S='SPLINE' then
              DXFEntity:=entSPLINE
            else if S='TEXT' then
              DXFEntity:=entTEXT
            else if S='TOLERANCE' then
              DXFEntity:=entTOLERANCE
            else if S='TRACE' then
              DXFEntity:=entTRACE
            else if S='VERTEX' then
              DXFEntity:=entVERTEX
            else if S='VIEWPORT' then
              DXFEntity:=entVIEWPORT
            else if S='XLINE' then
              DXFEntity:=entXLINE
            else if S='ACAD_PROXY_ENTITY' then
              DXFEntity:=entACAD_PROXY_ENTITY;
          end;
        2:if DXFSection=secNul then begin
            if S='HEADER' then
              DXFSection:=secHEADER
            else if S='CLASSES' then
              DXFSection:=secCLASSES
            else if S='TABLES' then
              DXFSection:=secTABLES
            else if S='BLOCKS' then
              DXFSection:=secBLOCKS
            else if S='ENTITIES' then
              DXFSection:=secENTITIES
            else if S='OBJECTS' then
              DXFSection:=secOBJECTS
          end else if DXFSection=secTABLES then begin
            if DXFTable=tblNul then begin
              if S='APPID' then
                DXFTable:=tblAPPID
              else if S='BLOCK_RECORD' then
                DXFTable:=tblBLOCK_RECORD
              else if S='DIMSTYLE' then
                DXFTable:=tblDIMSTYLE
              else if S='LAYER' then
                begin
                  DXFTable:=tblLAYER;
                  aLayer:=pointer(SpatialModel.Layers.CreateElement(False));
                  SpatialModel.Layers.Add(aLayer);
                end
              else if S='LTYPE' then
                DXFTable:=tblLTYPE
              else if S='STYLE' then
                DXFTable:=tblSTYLE
              else if S='UCS' then
                DXFTable:=tblUCS
              else if S='VIEW' then
                DXFTable:=tblVIEW
              else if S='VPORT' then
                DXFTable:=tblVPORT
            end else if DXFTable=tblLAYER then
              aLayer.Ident:=S
          end;
        5: begin end;     //Handle
        6:if (DXFSection=secTABLES) and
             (DXFTable=tblLAYER) then
             begin end;  //  aLayer.Style=
        8:if DXFEntity=entLine then
             aLine.Layer:=FindLayerByName(S, SpatialModel)
          else if (DXFEntity=entLWPolyLine) or
                  (DXFEntity=entVertex) then
             aLayer:=FindLayerByName(S, SpatialModel);
        end;
      end;
    wfInteger:
      begin
        readln(F, IV);
        WaitingFlag:=wfCode;
        case Code of
        48:begin end;                   // LineType Scale
        60:begin end;                   // Visibility of object
        62:begin
             if (IV<=7) and (IV>=1) then
               aColor:=ColorTable[IV] //Color (0 - ByBlock, 256 - ByLayer)
             else
               aColor:=TColor(IV);
             if (DXFSection=secTABLES) and
                (DXFTable=tblLAYER) then
               aLayer.Color:=aColor
             else if (DXFSection=secENTITIES) and
               (DXFEntity=entLine) then
               aLine.Color:=aColor
           end;
        67:begin end; // Enitiy in model or in Page space
        70:if (DXFSection=secTABLES) and
                (DXFTable=tblLAYER) then begin
             FlagSet:=@IV;
             aLayer.Visible:=not (0 in FlagSet^) and
                             not (1 in FlagSet^);
             aLayer.Selectable:=not (2 in FlagSet^);
           end else if (DXFSection=secTABLES) then begin
             if (DXFEntity=entLine) or
                (DXFEntity=entLWPolyLine) or
                (DXFEntity=entPolyLine) then
               FlagSet:=@IV
             else if DXFEntity=entVertex then
               VertexFlagSet:=@IV;
           end;
        71:begin end;      //Polygon mesh M vertex count (optional; default = 0)
        72:begin end;      //Polygon mesh N vertex count (optional; default = 0)
        73:begin end;      //Smooth surface M density (optional; default = 0)
        74:begin end;      //Smooth surface N density (optional; default = 0)
        75:begin end;      //Curves and smooth surface type (optional; default = 0); integer codes, not bit-coded:
                                //0 = No smooth surface fitted
                                //5 = Quadratic B-spline surface
                                //6 = Cubic B-spline surface
                                //8 = Bezier surface
        90:if DXFEntity=entLWPolyLine then
              VerticesCount:=IV;
        end;
      end;
    wfFloat:
      begin
        readln(F, FV);
        WaitingFlag:=wfCode;
        case Code of
        10:if DXFEntity=entLine then
               aLine.C0.X:=FV
           else if DXFEntity=entLWPolyLine then begin
             inc(VerticesJ);

             if VerticesJ=1 then begin
               PrevCoord:=pointer(SpatialModel.CoordNodes.CreateElement(False));
               SpatialModel.CoordNodes.Add(PrevCoord);
               PrevCoord.X:=FV;
               PrevCoord.Z:=Elevation;
               FirstCoord:=PrevCoord;
             end else begin
               aLine:=pointer(SpatialModel.Lines.CreateElement(False));
               SpatialModel.Lines.Add(aLine);
               aLine.C0:=PrevCoord;
               aLine.Thickness:=Thickness;
               aLine.Layer:=aLayer;
               aLine.C1:=pointer(SpatialModel.CoordNodes.CreateElement(False));
               SpatialModel.CoordNodes.Add(aLine.C1);
               aLine.C1.Z:=Elevation;
               aLine.C1.X:=FV;
               PrevCoord:=aLine.C1;

               if (VerticesJ=VerticesCount) and
                  (0 in FlagSet^) then begin
                 aLine:=pointer(SpatialModel.Lines.CreateElement(False));
                 SpatialModel.Lines.Add(aLine);
                 aLine.C0:=PrevCoord;
                 aLine.C1:=FirstCoord;
                 aLine.Thickness:=Thickness;
               end;
             end
           end else if DXFEntity=entLWPolyLine then begin
           end else if DXFEntity=entVertex then begin
             inc(VerticesJ);

             PrevCoord:=pointer(SpatialModel.CoordNodes.CreateElement(False));
             SpatialModel.CoordNodes.Add(PrevCoord);
             PrevCoord.Z:=0;
             PrevCoord.X:=FV;
             if VerticesJ=1 then
               FirstCoord:=PrevCoord;

             if aLine<>nil then
               aLine.C1:=PrevCoord;

             aLine:=pointer(SpatialModel.Lines.CreateElement(False));
             SpatialModel.Lines.Add(aLine);
             aLine.C0:=PrevCoord;
             aLine.Thickness:=Thickness;
             aLine.Layer:=aLayer;
             if (VertexFlagSet<>nil) and
                (VertexFlagSet^<>[]) then begin
             end;
           end;
        11:if DXFEntity=entLine then
               aLine.C1.X:=FV;
        20:if DXFEntity=entLine then
               aLine.C0.Y:=FV
           else if DXFEntity=entPolyLine then begin end
           else if (DXFEntity=entLWPolyLine) or
                   (DXFEntity=entVertex) then
              PrevCoord.Y:=FV;
        21:if DXFEntity=entLine then
               aLine.C1.Y:=FV;
        30:if DXFEntity=entLine then
               aLine.C0.Z:=FV
           else if DXFEntity=entPolyLine then begin end
           else if DXFEntity=entVertex then
              PrevCoord.Z:=FV;
        31:if DXFEntity=entLine then
               aLine.C1.Z:=FV;
        38:if DXFEntity=entLWPolyLine then
               Elevation:=FV;
        39:if DXFEntity=entLine then
               aLine.Thickness:=FV
           else if (DXFEntity=entLWPolyLine) or
                   (DXFEntity=entPolyLine) then
               Thickness:=FV;
        40, 41:begin end;  //starting and finishing width for Polyline and LWPolyline
        42:begin end;      //Bulge
        43:if DXFEntity=entLWPolyLine then
               Thickness:=FV;
        100:begin end;            //Subclass marker
        210, 220, 230:begin end;  //Extrusion
        end;
      end;
    end;
  end;
  CloseFile(F);
end;

end.
