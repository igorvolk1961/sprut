unit SpatialModelConstU;

interface
uses
  DM_Messages;

const
  WM_ChangeSelection=WM_User+800;
  WM_DragLine=WM_User+801;
  WM_ChangeView=WM_User+802;
  InfinitValue=1000000000;

type
  TSpatialModelParamID=(
    smBuildDirection,
    smChangeLengthDirection,
    smDrawOrdered,
    smFastDraw,
    smCurrentLayer,
    smCurrentFont,
    smBuildVerticalLine,
    smBuildJoinedVolume,
    smLocalGridCell,
    smDefaultVerticalAreaWidth,
    smDefaultObjectWidth,
    smDefaultVolumeHeight,
    smRenderAreasMode
   );

   TSpatialElementParamID=(
     speColor
   );

   TCoordParamID=(
     cooColor,
     cooX,
     cooY,
     cooZ
   );

   TCircleParamID=(
     cirColor,
     cirX,
     cirY,
     cirZ,
     cirRadius
   );

   TLineParamID=(
     linColor,
     linC0,
     linC1,
     linThickness,
     linStyle
   );

   TCurvedLineParamID=(
     clColor,
     clC0,
     clC1,
     clThickness,
     clStyle,
     clP0X,
     clP0Y,
     clP0Z,
     clP1X,
     clP1Y,
     clP1Z
   );

   TImageRectParamID=(
     irColor,
     irC0,
     irC1,
     irThickness,
     irStyle,
     irBitmapFileName,
     irAngle,
     irAlpha
   );

   TAreaParamID=(
     areColor,
     areThickness,
     areStyle,
     areFlags,
     areVolume0,
     areVolume1,
     areIsVertical
   );

   TViewParamID=(
     vCentralPointX,
     vCentralPointY,
     vCentralPointZ,
     vZangle,
     vDepth,
     vRevScaleX,
     vRevScaleY,
     vRevScaleZ,
     vCurrX,
     vCurrY,
     vCurrZ,
     vZmin,
     vZmax,
     vDmin,
     vDmax,
     vStoredParam
   );

   TCustomSpatialElementLayerParamID=(
     cselVisible,
     cselSelectable
   );

   TSpatialElementLayerParamID=(
     selVisible,
     selSelectable,
     selColor,
     selStyle,
     selExpand,
     selLineWidth,
     selCanDelete,
     selKind
   );

   TSMFontParamID=(
    fntSize,
    fntColor,
    fntStyle
   );

   TSMLabelParamID=(
    lbColor,
    lbFont,
    lbLabelScaleMode,
    lbLabelSize,
    lbLabeldX,
    lbLabeldY,
    lbLabeldZ
   );

resourcestring

    rsSpatialElements='"Элемент пространственной модели';
    rsLayer='Слой';
    rsCoordNode='Точка';
    rsLine='Линия';
    rsCurvedLine='Кривая линия';
    rsPolyLine='Ломаная линия';
    rsArea='Плоская область';
    rsEllipsoidSegment='Сегмент элипсоида';
    rsVolume='Область';
    rsView='Вид';
    rsDefaultView='Вид по умолчанию';
    rsDefaultLayer='Слой 0';
    rsImageRect='Растровое изображение';
    rsLineGroup='Группа линий';
    rsCircle='Окуржность';

    rsColor='Цвет';
    rsX='X, см';
    rsY='Y, см';
    rsZ='Z, см';
    rsRadius='Радиус, см';
    rsThickness='Толщина, см';
    rsStyle='Стиль';
    rsVolume0='Область 0';
    rsVolume1='Область 1';
    rsC0='Узел 0';
    rsC1='Узел 1';
    rsIsVertical='Вертикаль';
    rsAreaFlags='Флаги плоскости';
    rsP0X='P0X, см';
    rsP0Y='P0Y, см';
    rsP0Z='P0Z, см';
    rsP1X='P1X, см';
    rsP1Y='P1Y, см';
    rsP1Z='P1Z, см';
    rsCentralPointX='Xc, см';
    rsCentralPointY='Yc, см';
    rsCentralPointZ='Zc, см';
    rsZangle='Угол поворота вокруг оси Z, град';
    rsDepth='Глубина видимой области, см';
    rsRevScaleX='Обратный масштаб по оси X';
    rsRevScaleY='Обратный масштаб по оси Y';
    rsRevScaleZ='Обратный масштаб по оси Z';
    rsCurrX='XCP0, см';
    rsCurrY='YCP0, см';
    rsCurrZ='ZCP0, см';
    rsZmin='Высота нижней плоскости отсечения, см';
    rsZmax='Высота верхней плоскости отсечения, см';
    rsDmin='Глубина ближней плоскости отсечения, см';
    rsDmax='Глубина дальней плоскости отсечения, см';
    rsStoredParam='Запоминаемые данные';
    rsBitmapFileName='Имя файла';
    rsAngle='Угол поворота, град';
    rsAlpha='Прозрачность';
    rsVisible='Видимый';
    rsSelectable='Допускает выделение элементов';
    rsExpand='Копировать слой при создании сектора пространства';
    rsLineWidth='Толщина линий';
    rsCanDelete='Нельзя удалять';
    rsLayerKind='Вид слоя';
    rsFont='Фонт';
    rsFontSize='Размер';
    rsFontColor='Цвет';
    rsFontStyle='Стиль';
    rsLabel='Надпись';
    rsLabelScaleMode='Масштабирование надписи';
    rsLabelSize='Размер надписи, см';
    rsLabelVisible='Показывать надпись';
    rsLabeldX='Смещение надписи по X, cм';
    rsLabeldY='Смещение надписи по Y, cм';
    rsLabeldZ='Смещение надписи по Z, cм';
    rsDefaultFont='Arial Cyr';

    rsDivideVolume='Разбиение объема по вертикали на части';
    rsSubVolumeCount='Число частей';

    rsCreateLine      ='Создание линии';
    rsCreateCircle    ='Создание окружности';
    rsCreatePolyLine  ='Создание отрезка ломаной';
    rsCreateRectangle ='Создание прямоугольника';
    rsCreateCurvedLine='Создание кривой';
    rsCreateEllipse   ='Создание элипса';
    rsCreateInclinedRectangle='Создание повернутого прямоугольника';
    rsCreateImageRect ='Вставка растрового изображения';
    rsImportDXF       ='Импорт векторного изображения';
    rsCreateCoordNode ='Создание точечного объекта';
    rsMoveSelected    ='Параллельный перенос';
    rsRotateSelected  ='Поворот';
    rsScaleSelected   ='Изменение размера';
    rsDeleteSelected  ='Удаление';
    rsDoubleBreakLine ='Создание проема';
    rsTrimExtend      ='Продление/усечение';
    rsIntersectSelected='Пересечение линий';
    rsBreakLine       ='Разбиение линии';
    rsDeleteVertical  ='Удаление вертикальной плоскости';
    rsBuildVolume     ='Построение объема';
    rsBuildArea       ='Построение горизонтальной плоскости';
    rsBuildRelief     ='Построение рельефа';
    rsBuildVerticalArea='Построение вертикальной плоскости';
    rsBuildLineObject ='Создание линейного объекта';
    rsBuildPolylineObject='Создание протяженного объекта';
    rsChangeView      ='Изменение вида';
    rsDeleteConfirm          ='Вы хотите удалить объект "%s" ?';
    rsDeleteLinesConfirm     ='Удалить линии, образующие "%s" ?';
    rsCaskadeDeleteConfirm   =
    'Удаление объекта "%s" приведет к каскадному удалению других связанных с ним объектов. Вы подтверждаете удаление?';
    rsCannotDelete          ='Нельзя удалить объект "%s". Выдавать это сообщение для других объектов?';
    rsCannotDelete1         ='Нерекомендуется удалять объект "%s". Вы подтверждаете удаление?';
    rsOutline               ='Удвоение контура';
    rsOutlineShift          ='Смещение второго контура, м';
    rsLabelNoScale='Фиксированный размер';
    rsLabelScale='Масштабировать';
    rsCurrentLayer='Текущий слой';
    rsCurrentFont='Текущий фонт';
    rsLocalGridCell='Интервал местной сетки, м';
    rsSubVolumeHeight='Высота внутреннего объема';
    rsDrawOrdered='Отображать плоскости в Z-порядке';
    rsFastDraw='Быстрая перерисовка';
    rsChangeLengthDirection='Направление изменения длины линейных объектов';
    rsAddItemCaption=    'Добавление объекта "%s"';
    rsAddItemPrompt=     'Название %s';

    rsBuildVerticalLine='Продлевать вертикали при построении объемов';
    rsBuildJoinedVolume='Объединять смежные объемы при построении';
    rsBuildDirection='Направление построения объемов';

implementation


end.
