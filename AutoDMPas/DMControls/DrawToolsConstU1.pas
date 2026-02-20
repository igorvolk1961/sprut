unit DrawToolsConstU;

interface
uses
  SpatialModelLib_TLB;

const
  btnSelectCoordNode=0;
  btnSelectVerticalLine=1;
  btnSelectLine=2;
  btnSelectVerticalArea=3;
  btnSelectVolume=4;
  btnCreateLine=5;
  btnCreatePolyLine=6;
  btnCreateClosedPolyLine=7;
  btnCreateCurvedLine=8;
  btnCreateRectangle=9;
  btnCreateInclinedRectangle=10;
  btnCreateEllipse=11;
  btnDoubleBreakLine=12;
  btnBreakLine=13;
  btnIntersectSelected=14;
  btnCreateCoordNode=15;
  btnMoveSelected=16;
  btnScaleSelected=17;
  btnTrimExtendToSelected=18;
  btnRotateSelected=19;
  btnSnapOrtToLine=20;
  btnSnapToNearestOnLine=21;
  btnSnapToMiddleOfLine=22;
  btnZoomIn=23;
  btnZoomOut=24;
  btnViewPan=25;
  btnSelectClosedPolyLine=26;
  btnSnapNone=27;
  btnSnapToNode=28;
  btnSnapToLocalGrid=29;
  btnRedraw=30;
  btnLastView=31;
  btnBuildVolume=32;
  btnBuildVerticalArea=33;
  btnBuildLineObject=34;
  btnBuildArrayObject=35;
  btnDivideVolume=36;
  btnSelectImage=37;
  btnBuildPointObject=38;
  btnSideView=39;
  btnPalette=40;
  btnBuildRelief=41;
  btnZoomSelection=42;
  btnOutlineSelected=43;
  btnSelectLabel=44;
  btnSelectAll=45;
  btnBuildPolylineObject=46;
  btnCreateDoor=47;

  ButtonImageArrayCount=48;
  ButtonArrayCount=52;

var
  ButtonImageArray:array[0..ButtonImageArrayCount-1] of string=(
  'bmpSelectCoordNode',
  'bmpSelectVerticalLine',
  'bmpSelectLine',
  'bmpSelectVerticalArea',
  'bmpSelectVolume',
  'bmpCreateLine',
  'bmpCreatePolyLine',
  'bmpCreateClosedPolyLine',
  'bmpCreateCurvedLine',
  'bmpCreateRectangle',
  'bmpCreateInclinedRectangle',
  'bmpCreateEllipse',
  'bmpDoubleBreakLine',
  'bmpBreakLine',
  'bmpIntersectLines',
  'bmpCreateCoordNode',
  'bmpMoveSelected',
  'bmpScaleSelected',
  'bmpTrimExtend',
  'bmpRotateSelected',
  'bmpSnapOrtToLine',
  'bmpSnapToNearestOnLine',
  'bmpSnapToMiddleOfLine',
  'bmpZoomIn',
  'bmpZoomOut',
  'bmpViewPan',
  'bmpSelectClosedPolyLine',
  'bmpSnapNone',
  'bmpSnapToNode',
  'bmpSnapToLocalGrid',
  'bmpRedraw',
  'bmpLastView',
  'bmpBuildVolume',

  'bmpBuildVerticalArea',
  'bmpBuildLineObject',
  'bmpBuildArrayObject',
  'bmpDivideVolume',
  'bmpSelectImage',
  'bmpBuildPointObject',
  'bmpSideView',
  'bmpPalette',
  'bmpBuildRelief',
  'bmpZoomSelection',
  'bmpOutline',
  'bmpSelectLabel',
  'bmpSelectAll',
  'bmpBuildPolyLineObject',
  'bmpCreateDoor'
);

const
  tbSelect=0;
//  tbSelectLine=1;
//  tbSelectClosedPolyLine=2;
  tbCreateLine=1;
//  tbCreateRectangle=2;
//  tbEdit=2;
  tbTransform=2;
  tbBuild=3;
  tbZoomIn=4;
  tbZoomOut=5;
  tbViewPan=6;
  tbDummy1=7;
  tbLastView=8;
  tbZoomSelection=9;
  tbDummy2=10;
  tbSnapNone=11;
  tbSnapToLine=12;
  tbDummy3=13;
  tbRedraw=14;
  tbDummy4=15;
  tbSideView=16;
  tbDummy5=17;
  tbPalette=18;

resourcestring
  rsCreateLine='Построение линий';
  rsCreatePolyLine='Построение ломаных';
  rsCreateCurvedLine='Построение кривых линий';
  rsCreateClosedPolyLine='Построение многоугольников';
  rsCreateRectangle='Построение прямоугольников';
  rsCreateInclinedRectangle='Построение повернутых прямоугольников';
  rsCreateEllipse='Построение эллипсов';

  rsSelectAll='Выделение';
  rsSelectNode='Выделение точечных объектов';
  rsSelectLine='Выделение линий/рубежей';
  rsSelectVerticalLine='Выделение вертикальных линий';
  rsSelectVerticalArea='Выделение вертикальных плоскостей';
  rsSelectVolume='Выделение зон';
  rsSelectLabel='Выделение меток';

  rsDoubleBreakLine='Создание проемов';
  rsBreakLine='Добавление узлов';
  rsTrimExtend='Продление/усечение до выделенных линий';
  rsOutline='Удвоение контура';

  rsMoveSelected='Перемещение выделенных элементов';
  rsScaleSelected='Изменение размера выделенных элементов';
  rsRotateSelected='Поворот выделенных элементов';
  rsZoomIn='Увеличение масштаба';
  rsZoomOut='Уменьшение масштаба';
  rsZoomSelection='Показать выделенные объекты';
  rsViewPan='Перетаскивание';

  rsSnapToNode='Привязка к ближайшему узлу';
  rsSnapOrtToLine='Привязка по перпендикуляру к отрезку';
  rsSnapToNearestOnLine='Привязка к ближайшей точке отрезка';
  rsSnapToMiddleOfLine='Привязка к середине отрезка';
  rsSnapToLocalGrid='Привязка к местной сетке';
  rsSnapNone='Отмена привязок';

  rsCrossLine='Показ "перекрестья"';  //"перекрестье"-не использ.
  rsRedraw='Обновить изображение';
  rsLastView='Вернуться к предыдущему виду';

  rsBuildVolume='Создание зон...';
  rsBuildVerticalArea='Деление зоны по горизонтали...';
  rsBuildLineObject='Создание переходов между зонами...';
  rsBuildArrayObject='Создание секторов наблюдения/обнаружения...';
  rsCreateCoordNode='Создание целей и элементов системы охраны...';
  rsDivideVolume='Деление зоны по вертикали...';
  rsSelectImage='Выделение изображения';
  rsBuildPolylineObject='Создание протяженных объектов...';
  rsBuildRelief='Создание рельефа местности...';
  rsIntersectSelected='Создание узлов в точках пересечения линий';

  rsSideView='Фронтальный вид';
  rsPalette='Панель закладок';

  const
  tbsButton=0;
  tbsCheck=1;
  tbsDropDown=2;
  tbsSeparator=3;
  tbsDivider=4;
  tbsCheck2=5;


var
  ButtonArray:array[0..ButtonArrayCount-1, 0..4] of integer=
  ((tbSelect,     btnSelectAll,  smoSelectAll,tbsCheck, 1),
                      (-1, btnSelectLabel,  smoSelectLabel, tbsCheck, 0),
                      (-1, btnSelectClosedPolyLine,  smoSelectVolume, tbsCheck, 0),
                      (-1, btnSelectLine,  smoSelectVerticalArea, tbsCheck, 0),
                      (-1, btnSelectCoordNode, smoSelectVerticalLine, tbsCheck, 0),
                      (-1, btnSelectAll,  smoSelectAll, tbsCheck, 0),
  (tbCreateLine,           btnCreateLine,  smoCreateLine, tbsCheck, 1),
                      (-1, btnBreakLine,  smoBreakLine, tbsCheck, 0),
                      (-1, btnCreateEllipse,  smoCreateEllipse, tbsCheck, 0),
                      (-1, btnCreateCurvedLine,  smoCreateCurvedLine, tbsCheck, 0),
                      (-1, btnCreateInclinedRectangle,  smoCreateInclinedRectangle, tbsCheck, 0),
                      (-1, btnCreateRectangle,  smoCreateRectangle, tbsCheck, 0),
                      (-1, btnCreateClosedPolyLine,  smoCreateClosedPolyLine, tbsCheck, 0),
                      (-1, btnCreatePolyLine,  smoCreatePolyLine, tbsCheck, 0),
                      (-1, btnCreateLine,  smoCreateLine, tbsCheck, 0),
  (tbTransform,            btnMoveSelected,  smoMoveSelected, tbsCheck, 1),
                      (-1, btnOutlineSelected,  smoOutlineSelected, tbsCheck, 0),
                      (-1, btnTrimExtendToSelected,  smoTrimExtendToSelected, tbsCheck, 0),
                      (-1, btnScaleSelected,  smoScaleSelected, tbsCheck, 0),
                      (-1, btnRotateSelected,  smoRotateSelected, tbsCheck, 0),
                      (-1, btnMoveSelected,  smoMoveSelected, tbsCheck, 0),
  (tbBuild      ,          btnBuildVolume,  smoBuildVolume, tbsCheck, 1),
                      (-1, btnIntersectSelected,  smoIntersectSelected, tbsCheck, 0),
                      (-1, btnBuildRelief,  smoBuildRelief, tbsCheck, 0),
                      (-1, btnCreateCoordNode,  smoCreateCoordNode, tbsCheck, 0),
                      (-1, btnBuildPolylineObject,  smoBuildPolylineObject, tbsCheck, 0),
                      (-1, btnBuildArrayObject,  smoBuildArrayObject, tbsCheck, 0),
                      (-1, btnBuildLineObject,  smoBuildLineObject, tbsCheck, 0),
                      (-1, btnDivideVolume,  smoDivideVolume, tbsCheck, 0),
                      (-1, btnBuildVerticalArea,  smoBuildVerticalArea, tbsCheck, 0),
                      (-1, btnCreateDoor,  smoDoubleBreakLine, tbsCheck, 0),
                      (-1, btnBuildVolume,  smoBuildVolume, tbsCheck, 0),
  (tbZoomIn,               btnZoomIn,    smoZoomIn,   tbsCheck,  2),
  (tbZoomOut,              btnZoomOut,   smoZoomOut,  tbsCheck,  2),
  (tbViewPan,              btnViewPan,   smoViewPan,  tbsCheck,  2),
  (-1, -1,  -1, tbsSeparator, 2),
                      (-1, btnLastView,  smoLastView, tbsButton, 2),
                      (-1, btnZoomSelection,  smoZoomSelection, tbsButton, 2),
  (-1, -1,  -1, tbsSeparator, 2),
                      (-1, btnSnapNone,  smoSnapNone, tbsCheck, 2),
  (tbSnapToLine,           btnSnapOrtToLine,  smoSnapOrtToLine, tbsCheck, 1),
                      (-1, btnSnapToNode,  smoSnapToNode, tbsCheck, 0),
                      (-1, btnSnapToLocalGrid,  smoSnapToLocalGrid, tbsCheck, 0),
                      (-1, btnSnapToMiddleOfLine,  smoSnapToMiddleOfLine, tbsCheck, 0),
                      (-1, btnSnapToNearestOnLine,  smoSnapToNearestOnLine, tbsCheck, 0),
                      (-1, btnSnapOrtToLine,  smoSnapOrtToLine, tbsCheck, 0),
  (-1, -1,  -1, tbsSeparator, 2),
                      (-1, btnRedraw,    smoRedraw,   tbsButton, 2),
  (-1, -1,  -1, tbsSeparator, 2),
                      (-1, btnSideView,    smoSideView,   tbsCheck2, 2),
  (-1, -1,  -1, tbsSeparator, 2),
                      (-1, btnPalette,    smoPalette,   tbsCheck2, 2));



//__________________________________________________________________

  ButtonHintArray:array[0..ButtonArrayCount-1] of string=(
                       rsSelectAll,
                       rsSelectLabel,
                       rsSelectVolume,
                       rsSelectLine,
                       rsSelectNode,
                       rsSelectAll,

                       rsCreateLine,
                       rsBreakLine,
                       rsCreateEllipse,
                       rsCreateCurvedLine,
                       rsCreateInclinedRectangle,
                       rsCreateRectangle,
                       rsCreateClosedPolyLine,
                       rsCreatePolyLine,
                       rsCreateLine,

                       rsMoveSelected,
                       rsOutline,
                       rsTrimExtend,
                       rsScaleSelected,
                       rsRotateSelected,
                       rsMoveSelected,

                       rsBuildVolume,
                       rsIntersectSelected,
                       rsBuildRelief,
                       rsCreateCoordNode,
                       rsBuildPolylineObject,
                       rsBuildArrayObject,
                       rsBuildLineObject,
                       rsDivideVolume,
                       rsBuildVerticalArea,
                       rsDoubleBreakLine,
                       rsBuildVolume,

                       rsZoomIn,
                       rsZoomOut,
                       rsViewPan,
                        '',
                       rsLastView,
                       rsZoomSelection,
                        '',
                       rsSnapNone,

                       rsSnapOrtToLine,
                       rsSnapToNode,
                       rsSnapToLocalGrid,
                       rsSnapToMiddleOfLine,
                       rsSnapToNearestOnLine,
                       rsSnapOrtToLine,

                       '',
                       rsRedraw,
                       '',
                       rsSideView,
                       '',
                       rsPalette);




implementation

end.
