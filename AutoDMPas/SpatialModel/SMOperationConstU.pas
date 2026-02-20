unit SMOperationConstU;

interface
const
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

 rsErrOperation='ошибка выполнения операции';
 rsAction0=' Укажите ';
 rsAction1=' Нажмите ';

 rsAction=' Укажите ';
 rsSizeAction=' укажите размер ';
 rsSelectAction=' Укажите выделяемый объект (ALT - выделять только на плоскости, SHIFT - выделение рамкой, CTRL - добавление к выделению)';
 rsMouseAction1='левую клавишу "мыши"';
 rsMouseAction2='правую клавишу "мыши"';

 rsLineOperation='ЛИНИЯ: ';
 rsLabelOperation='METKA: ';
 rsLineStep1='начальную точку отрезка';
 rsLineStep2='конечную точку отрезка (CTRL - строить параллельно сторонам экрана)';

 rsCurvedLineOperation='КРИВАЯ: ';
 rsCurvedLineStep1='начальную точку кривой';
 rsCurvedLineStep2='конечную точку кривой (CTRL - строить параллельно сторонам экрана)';
 rsCurvedLineStep3='конец касательной к начальной точке';
 rsCurvedLineStep4='конец касательной к конечной точке';

 rsPolyLineOperation='ЛОМАНАЯ: ';
 rsClosedPolyLineOperation='МНОГОУГОЛЬНИК: ';
 rsPolyLineStep1='начальную точку';
 rsPolyLineStep2='следующую точку  (CTRL - строить параллельно сторонам экрана, F6 - прервать)';
 rsClosedPolyLineStep2='следующую точку  (CTRL - строить параллельно сторонам экрана, F6 - замкнуть)';

 rsRectangleOperation='ПРЯМОУГОЛЬНИК: ';
 rsImageRectOperation='РИСУНОК: ';
 rsRectangleStep1='точку в одном из уголов прямоугольника ';
 rsRectangleStep2='точку в противоположном уголу прямоугольника ';

 rsEllipseOperation='ЭЛЛИПС: ';
 rsEllipseStep1='начальную точку первой оси';
 rsEllipseStep2='конечную точку первой оси  (CTRL - строить параллельно сторонам экрана)';
 rsEllipseStep3=' второй оси';

 rsCircleOperation='ОКРУЖНОСТЬ: ';
 rsCircleStep1='центр';
 rsCircleStep2='радиус';

 rsInclinedRectangleOperation='ПОВЕРНУТЫЙ ПРЯМОУГОЛЬНИК: ';
 rsInclinedRectangleStep1='начальную точку первой стороны прямоугольника';
 rsInclinedRectangleStep2='конечную точку первой стороны прямоугольника (CTRL - строить параллельно сторонам экрана)';
 rsInclinedRectangleStep3='конечную точку второй стороны прямоугольника';
//_____________________________________________________
  rsCreateCoordNode='Построение изолированных узлов  (точечных объектов)';
  rsCreateLine='Построение линий';
  rsCreatePolyLine='Построение ломаных линий';
  rsCreateCurvedLine='Построение кривых';
  rsCreateClosedPolyLine='Построение многоугольников';
  rsCreateRectangle='Построение прямоугольников';
  rsCreateInclinedRectangle='Построение повернутых прямоугольников';
  rsCreateEllipse='Построение эллипсов';
  rsBuildVolume='Построение зон';

  rsSelectCoordNode='Выделение узлов  (точечных объектов)';
  rsSelectLine='Выделение линий. ';
  rsSelectVerticalLine='Выделение вертикальных линий. ';
  rsSelectVerticalArea='Выделение вертикальных плоскостей. ';
  rsSelectVolume='Выделение зон. ';
  rsSelectClosedPolyLine='Выделение горизонтальных плоскостей. ';
  rsSelectAll='Выделение объектов. ';

  rsDoubleBreakLine='Создание проемов';
  rsBreakLine='Разбиение линий';
  rsIntersectLines='Разбиение линий по точкам пересечения';
  rsTrimExtend='Усечение/продление выделенных линий';

  rsMoveSelected='Перемещение выделенных элементов';
  rsScaleSelected='Изменение размера выделенных элементов';
  rsRotateSelected='Поворот выделенных элементов';
  rsZoomIn='Увеличиние масштаба (Shift  - растянуть содержимое рамки на все окно)';
  rsZoomOut='Уменьшение масштаба (Shift - содержимое окна ужать до размера рамки)';
  rsViewPan='Смещение положения видимого окна';

  rsSnapToNode='Привязка к ближайшему узлу';
  rsSnapOrtToLine='Привязка по перпендикуляру к отрезку линии ';
  rsSnapToNearestOnLine='Привязка к ближайшей точке отрезка линии';
  rsSnapToMiddleOfLine='Привязка к середине отрезка линии';
  rsSnapNone='Отмена привязок';

  rsCrossLine='Показ "перекрестья"';
  rsRedraw='Обновление построений';
  rsLastView='Возврат к предыдущему виду';

  rsZoomInHintHead='УВЕЛИЧЕНИЕ МАСШТАБА: ';
  rsZoomOutHintHead='УМЕНЬШЕНИЕ МАСШТАБА: ';
  rsZoomHintStep0='Укажите точку, в которую следует переместить центр окна';
  rsZoomHintStep1_Shift='Укажите один из углов рамки';
  rsZoomHintStep2_Shift='Задайте размер рамки';

  rsPanHintHead='Сдвиг ПАНАРАМЫ : ';
  rsPanHintStep1='Укажите начало вектора перемещения';
  rsPanHintStep1_Ctrl='Укажите начало вектора перемещения';
  rsPanHintStep2='Укажите конец вектора перемещения';
  rsPanHintStep2_Ctrl='Укажите начало вектора перемещения';

  rsZoomInStep0=' (Shift  - растянуть содержимое рамки на все окно)';
  rsZoomOutStep0=' (Shift - содержимое окна ужать до размера рамки)';



implementation

end.
