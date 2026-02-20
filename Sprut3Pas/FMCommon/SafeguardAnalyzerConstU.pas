unit SafeguardAnalyzerConstU;

interface

const
  admGet_DelayTimeToTarget=0;
  admGet_RationalProbabilityToTarget=1;
  admGet_BackPathDelayTime=2;
  admGet_BackPathRationalProbability=3;
  admGet_NoDetectionProbability=4;
  admGet_SoundResistance=5;
  admGet_SuccessProbabilityToTarget=6;
  admGet_SuccessProbabilityFromStart=7;
  admGet_DelayTimeFromStart=8;

resourcestring

rsPathNode='Узел графа маршрутов';
rsPathArc='Дуга графа маршрутов';
rsPath='Маршрут';
rsPathLayer='Группа маршрутов';
rsPathGraph='Граф маршрутов';
rsOptimalPath='Оптимальный маршрут до цели';
rsRationalPath='Рациональный маршрут до цели';
rsFastPath='Самый быстрый маршрут до цели';
rsStealthPath='Самый скрытный маршрут извне';
rsBackPathFacilityState='Обратный маршрут';
rsRoadPart='Участок дороги';
rsVerticalWay='Вертикальный путь';
rsSafeguardSynthesis='Вырабротка рекомендаций';
rsClear='Удаление результатов анализа';
implementation

end.
