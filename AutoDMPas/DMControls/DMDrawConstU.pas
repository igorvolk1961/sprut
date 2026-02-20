unit DMDrawConstU;

interface
uses
  DM_Messages;

const
  WM_ChangeSelection=WM_User+800;
  WM_DragLine=WM_User+801;
  WM_ChangeView=WM_User+802;

  cr_Pen=100;
  cr_Pen_Line=101;
  cr_Pen_Polyline=102;
  cr_Pen_Closed=103;
  cr_Pen_Curved=104;
  cr_Pen_Rect=105;
  cr_Pen_Incl=106;
  cr_Pen_Ellips=107;
  cr_Pen_Circle=108;
  cr_Pen_Image=109;
  cr_Pen_Break=150;
  cr_Pen_Door=151;
  cr_Pen_Stairs=152;
  cr_Pen_Sensor=153;
  cr_Pen_Target=154;

  cr_Hand_Arrow=110;
  cr_Hand_HLine=111;
  cr_Hand_VLine=112;
  cr_Hand_HArea=113;
  cr_Hand_VArea=114;
  cr_Hand_Zone=115;
  cr_Hand_Text=116;


  cr_Hand_Move=120;
  cr_HandV=122;
  cr_HandG=123;
  cr_HandMoveArrow=130;
  cr_Tool_Move=131;
  cr_Tool_Scale=132;
  cr_Tool_Rotate=133;
  cr_Tool_Mirror=134;
  cr_Tool_Trim=135;
  cr_Tool_Out=136;
  cr_Tool_Sect=137;

  cr_HandZoomIn=140;
  cr_HandZoomOut=141;
  cr_ZoomIn=142;
  cr_ZoomOut=143;

  cr_Build_Zone=160;
  cr_Build_DivH=161;
  cr_Build_DivV=162;
  cr_Build_Road=163;
  cr_Build_Door=164;
  cr_Build_Relief=165;
  cr_Build_Sectors=166;
resourcestring

    rsView='Вид';
    rsSaveViewCaption='Сохранение текущего вида';
    rsSaveViewPrompt='Укажите название нового вида:';
    rsCreateLayerCaption='Создание нового слоя';
    rsCreateLayerPrompt='Укажите название нового слоя:';
    rsCreateLayer      ='Создание слоя';
    rsDeleteLayer      ='Удаление слоя';
    rsChangeLayerProperty='Изменение свойств слоя';
    rsCreateView       ='Создание вида';
    rsDeleteView       ='Удаление вида';
    rsChangeView       ='Изменение вида';
    rsPointChange      ='Изменение кординат узла';
    rsLineChange       ='Изменение параметров линии';
    rsAreaChange       ='Изменение параметров плоской области';
    rsVolumeChange     ='Изменение параметров объема';
    rsAlingPoint       ='Выстраивание узлов вдоль линии';
    rsJoinLayer        ='Слияние слоев';
    rsAddLink          ='Добавление связи';
    rsRemoveLink       ='Удаление связи';
    rsRenameLabel      ='Изменение надписи';
    rsChangeLayer      ='Изменение слоя элента';
implementation

end.
