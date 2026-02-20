unit SafeguardDatabaseConstU;

interface


const

  _Zone = $0000000B;
  _Boundary = $0000000C;
  _BoundaryLayer = $0000000D;
  _TechnicalService = $0000000E;
  _FacilityState = $0000000F;
  _FacilitySubState = $00000010;
  _ZoneState = $00000011;
  _BoundaryState = $00000012;
  _BoundaryLayerState = $00000013;
  _BoundaryElementState = $00000014;
  _SafeguardElementState = $00000015;
  _WarriorPath = $00000016;
  _Barrier = $00000017;
  _BarrierFixture = $00000018;
  _Lock = $00000019;
  _UndergroundObstacle = $0000001A;
  _ActiveSafeguard = $0000001B;
  _SurfaceSensor = $0000001C;
  _PositionSensor = $0000001D;
  _VolumeSensor = $0000001E;
  _BarrierSensor = $0000001F;
  _PerimeterSensor = $00000020;
  _ContrabandSensor = $00000021;
  _AccessControl = $00000022;
  _TVCamera = $00000023;
  _LightDevice = $00000024;
  _CommunicationDevice = $00000025;
  _SignalDevice = $00000026;
  _PowerSource = $00000027;
  _Cabel = $00000028;
  _CabelSegment = $00000029;
  _AdditionalDevice = $0000002A;
  _GuardPost = $0000002B;
  _PatrolPath = $0000002C;
  _PatrolPathElement = $0000002D;
  _Target = $0000002E;
  _Conveyance = $0000002F;
  _ConveyanceSegment = $00000030;
  _LocalPointObject = $00000031;
  _Jump = $00000032;
  _StartPoint = $00000033;
  _GuardVariant = $00000034;
  _GuardGroup = $00000035;
  _AnalysisVariant = $00000036;
  _Weapon = $00000037;
  _Tool = $00000038;
  _Vehicle = $00000039;
  _Skill = $0000003A;
  _Road = $0000003B;
  _Athority = $0000003C;
  _AdversaryVariant = $0000003D;
  _AdversaryGroup = $0000003E;
  _FMError = $0000003F;
  _UserDefinedPath = $00000040;
  _GlobalZone = $00000041;
  _Access = $00000042;
  _GroundObstacle = $00000043;
  _FenceObstacle = $00000044;
  _WarriorPathElement = $00000045;
  _Connection = $00000046;
  _ControlDevice = $00000047;
  _CriticalPoint = $00000048;
  _FMRecomendation = $00000049;
  _GuardArrival = $0000004A;
  _ElementParameterValue = $0000004B;

type

  TZoneTypeCategory=(
    fztcKinds,
    fztcSafeguardClasses
  );

  TBoundaryTypeCategory=(
    zbtcKinds
  );

  TBoundaryKindCategory=(
    zbkcBoundaryLayerTypes
  );

  TBoundaryLayerTypeCategory=(
    dltcTactics,
    dltcSubBoundaryKinds,
    dltcSafeguardClasses
  );

  TTacticCategory=(
    tcMethods,
    tcSafeguardClasses,
    tcParents
  );

  TOvercomeMethodCategory=(
    omcArrayDimensions,
    omcArray,
    omcToolTypes,
    omcVehicleTypes,
    omcWeaponTypes,
    omcSkillTypes,
    omcAthorityTypes,
    omcDeviceStates,
    omcTactics,
    omcPhysicalFields,
    omcParents
  );

  TOvercomeMethodParameterNum=(
    ompDelayProcCode,
    ompProbabilityProcCode,
    ompFieldsProcCode,
    ompObserverParam,
    ompDependsOnReliability,
    ompEvidence,
    ompFailure,
    ompAssessRequired,
    ompDestructive
{    ompCalcDelayProc,
    ompCalcDelayLib,
    ompCalcProbabilityProc,
    ompCalcProbabilityLib,
    ompCalcFieldsProc,
    ompCalcFieldsLib,
}
  );

  TDetectionElementTypeParameterNum=(
    depTypeID,
    depCalcFalseAlarmPeriodProc,
    depCalcFalseAlarmPeriodLib
  );

  TDetectionElementKindParameterNum=(
    dekComment,                    //0
    dekImage,                      //1
    dekDetectionProbability,       //2
    dekFalseAlarmPeriod,           //3
    dekReliabilityTime            //4
  );

  TVolumeSensorKindParameterNum=(
    vskComment,                   //0
    vskImage,                     //1
    vskDetectionProbability,      //2
    vskFalseAlarmPeriod,          //3
    vskReliabilityTime,           //4
    vskZoneImage,                 //5
    vskZoneLength,                //6
    vskZoneWidth,                 //7
    vskZoneHeight,                //8
    vskZoneForm,                  //9
    vskDefaultElevation,          //10
    vskDetectionOnBoundary        //11
  );

  TSurfaceSensorKindParameterNum=(
    sskComment,                   //0
    sskImage,                     //1
    sskDetectionProbability,      //2
    sskFalseAlarmPeriod,          //3
    sskReliabilityTime,           //4
    sskContactSensible            //5
  );

  TPerimeterSensorKindParameterNum=(
    pskComment,                   //0
    pskImage,                     //1
    pskDetectionProbability,      //2
    pskFalseAlarmPeriod,          //3
    pskReliabilityTime,           //4
    pskLength,                    //5
    pskZoneWidth                  //6
  );

  TBarrierKindParameterNum=(
    bkComment,              //0
    bkImage,                //1
    bkEc,                   //2
    bkTransparent,          //3
    bkFragile,              //4
    bkSoundResistance,      //5
    bkDefaultWidth,         //6
    bkContainLock,          //7
    bkUseElevation,         //8
    bkTexture               //9
  );

const
    cnstTHL1=310;
    cnstTHL2=311;
    cnstTHM1=312;
    cnstTHM2=313;
    cnstTHH1=314;
    cnstTHH2=315;
    cnstTDL1=316;
    cnstTDL2=317;
    cnstTDM1=318;
    cnstTDM2=319;
    cnstTDH1=320;
    cnstTDH2=321;
    cnstTEL1=322;
    cnstTEL2=323;
    cnstTEM1=324;
    cnstTEM2=325;
    cnstTEH1=326;
    cnstTEH2=327;
    cnstTSL1=328;
    cnstTSL2=329;
    cnstTSM1=330;
    cnstTSM2=331;
    cnstTSH1=332;
    cnstTSH2=333;
    cnstTNorm=334;

type
  TUdergroundObstacleKindParameterNum=(
    uokComment,              //0
    uokImage,                //1
    uokDefaultMineDepth,     //2
    uokGroundType            //3
  );

  TGroundObstacleKindParameterNum=(
    gokComment,              //0
    gokImage,                //1
    gokDefaultWidth          //2
  );

  TFenceObstacleKindParameterNum=(
    fokComment,              //0
    fokImage,                //1
    fokDefaultWidth          //2
  );

  TLockKindParameterNum=(
    lkComment,       //0
    lkImage,         //1
    lkEc,            //2
    lkCriminalEc,    //3
    lkOpeningTime,   //4

    lkAccessControl  //5
  );

  TControlDeviceKindParameterNum=(
    cmkComment,                    //0
    cmkImage,                      //1
    cmkAddressInfo,                //2
    cmkDamageInfo,                 //3
    cmkTamperInfo,                 //4
    cmkLinkCheck,                  //5
    cmkInfoCapacity,               //6
    cmkSystemKind                  //7
  );

  TCommunicationDeviceParameterNum=(
    cdkComment,                    //0
    cdkImage,                      //1
    cdkDuplex,                     //2
    cdkConnectionTime              //3
  );

  TGuardPostKindParameterNum=(
    gpkComment,
    gpkImage,
    gpkDefenceLevel,
    gpkOpenedDefenceState,
    gpkHidedDefenceState
  );

  TToolKindParameterNum=(
    tkComment,          //0
    tkToolBaseEc,       //1
    tkToolCoeffEc,      //2
    tkMass,             //3
    tkMaxLength,        //4
    tkHasMetall,        //5
    tkSoundPower,       //6
    tkKind,             //7
    tkIsDefault         //8
  );

  TBattleSkillParameterNum=(
    bspSkillLevel,
    bspTakeAimTime,
    bspStillStillScoringFactor,
    bspRunStillScoringFactor,
    bspStillRunScoringFactor,
    bspRunRunScoringFactor,
    bspRunEvadeFactor,
    bspStillEvadeFactor,
    bspDefaultAcceptableRisk
  );

  TGuardCharacteristicParameterNum=(
    gcComment,
    gcInControlSectorDetectionProbability,
    gcOutOfControlSectorDetectionProbability,
    gcSoundDetectionProbability
  );

  TLocalObjectKindParameterNum=(
    lokComment,
    lokImage,
    lokClimbUpVelocity,
    lokClimbDownVelocity
  );

  TJumpKindParameterNum=(
    jkComment,
    jkImage,
    jkClimbUpVelocity,
    jkClimbDownVelocity,
    jkDefault
  );

  TTVCameraKindParameterNum=(
    tvComment,
    tvImage,
    tvViewAngle,
    tvViewLength
  );

  TWeaponBreachParameterNum=(
    wbpBulletName,
    wbpDemandArmour
  );

  TWeaponDispersionParameterNum=(
    wdpWeaponDistance,
    wdpCartridgeCountPerScore_Still_Head,
    wdpCartridgeCountPerScore_Still_Chest,
    wdpCartridgeCountPerScore_Still_Half,
    wdpCartridgeCountPerScore_Still_Full,
    wdpCartridgeCountPerScore_Still_Run,
    wdpCartridgeCountPerScore_Run_Head,
    wdpCartridgeCountPerScore_Run_Chest,
    wdpCartridgeCountPerScore_Run_Half,
    wdpCartridgeCountPerScore_Run_Full,
    wdpCartridgeCountPerScore_Run_Run,
    wdpWeaponVerticalDeviation1,
    wdpWeaponHorizontalDeviation1,
    wdpWeaponVerticalDeviation2,
    wdpWeaponHorizontalDeviation2
  );

  TWeaponKindParameterNum=(
    wpComment,                    //0
    wpMaxShotDistance,            //1
    wpPreciseShotDistance,        //2
    wpMass,                       //3
    wpMaxLength,                  //4
    wpHasMetall,                  //5
    wpShotRate,                   //6
    wpShotForce,                  //7
    wpShotCapacity,               //8
    wpCartridgeCountPerHit,       //9
    wpGroupDamage,                //10
    wpIsDefault,                  //11
    wpSoundPower                  //12
  );

  TVehihcleKindParameterNum=(
    vkComment,
    vkVehicleVelocity1,
    vkVehicleVelocity2,
    vkVehicleVelocity3,
    vkVehicleDefenceLevel,
    vkVehicleWidth
  );

  TZoneKindParameterNum=(
    zkpComment,
    zkpPedestrialMovementVelocity,
    zkpCarMovementEnabled,
    zkpAirMovementEnabled,
    zkpWaterMovementEnabled,
    zkpUnderWaterMovementEnabled,
    zkpRoadCover,
    zkpDefaultCategory,
    zkpDefaultTransparencyDist,
    zkpDefaultSideBoundaryKind,
    zkpDefaultBottomBoundaryKind,
    zkpDefaultTopBoundaryKind,
    zkpHSubZoneKind,
    zkpVSubZoneKind,
    zkpUpperZoneKind,
    zkpLowerZoneKind,
    zkpSpecialKind
  );

   TElementImageParameterNum=(
     eiVisible,
     eiSelectable,
     eiColor,
     eiStyle,
     eiExpand,
     eiScalingType,
     eiMinPixels,
     eiMaxSize
  );

  TTacticParameterNum=(
    tFastTactic,
    tStealthTactic,
    tDeceitTactic,
    tForceTactic,
    tEntryTactic,
    tExitTactic,
    tOutsiderTactic,
    tInsiderTactic,
    tGuardTactic,
    tPathArcKind
  );

  TUpdateParameterNum=(
    uOldClassID,
    uOldID
  );

  TElementImageScalingTypeCode=(eitNoScaling, eitScaling, eitXScaling);

  TWarriorPathStage=(wpsStelthEntry, wpsFastEntry, wpsStelthExit, wpsFastExit);

  TShotTargetDimensionsRecord=record
    Width:double;
    Height:double;
    FigureFactor:double;
  end;

    // положение бойца
  TShotTargetType=(ttHeadHigh,     // головная фигура
                   ttChestHigh,    // грудная фигура
                   ttWaistHigh,    // поясная фигура
                   ttFullHigh);    // ростовая фигура

  TShotTargetDimensionsArray=array[ord(ttHeadHigh)..ord(ttFullHigh)] of TShotTargetDimensionsRecord;


const
  cnstDefaultShotDeviationFactor=4;  // фактор увеличения срединного отклонения
                // при стрельбе у неопытного стрелка
  cnstConnectionTime=20; // время установления связи, сек
  cnstInstallCoeff=7771;
  cnstDefaultDetectionPosition=7775;
  cnstPrice=7777;
  cnstPriceDimension=7778;
  cnstImage2=9876;
  cnstMainDeviceState=5432;
  cnstKindID=7779;

const
  ShotTargetDimensions:TShotTargetDimensionsArray =
((Width:0.5; Height:0.3; FigureFactor:0.68),
 (Width:0.5; Height:0.5; FigureFactor:0.8),
 (Width:0.5; Height:1;   FigureFactor:0.9),
 (Width:0.5; Height:1.5; FigureFactor:0.85));


resourcestring
  rsFacilityEnviroments ='Окрестности объекта';

  rsZoneType    ='Зоны';
  rsBoundaryType    ='Рубежи';
  rsBoundaryLayerType    ='Слои рубежа';

  rsBarrierType         ='Физические барьеры';
  rsLockType           ='Запорные устройства';
  rsUndergroundObstacleType ='Основание заграждения';
  rsGroundObstacleType      ='Оборудование запретной зоны';
  rsFenceObstacleType       ='Препятствия перелазу';

  rsSurfaceSensorType   ='Поверхностные извещатели';
  rsPositionSensorType  ='Точечные извещатели';
  rsVolumeSensorType    ='Объемные извещатели';
  rsBarrierSensorType   ='Вид линейного извещателя';
  rsPerimeterSensorType ='Периметровые извещатели';
  rsContrabandSensorType='Контроль перемещения предметов и материалов';
  rsAccessControlType   ='Контроль доступа';

  rsTVCameraType        ='Телевизионные  камеры';
  rsLightDeviceType     ='Осветительные приборы';
  rsPowerSourceType     ='Источники электропитания';
  rsCabelType           ='Линии связи';
  rsAdditionalDeviceType='Вид дополнительного устройства';
  rsGuardPostType       ='Посты охраны';
  rsTargetType          ='Цели';
  rsControlDeviceType     ='Устройства управления и коммутации';
  rsConveyanceType            ='Вид траспортировки предмета охраны';
  rsConveyanceSegmentType    ='Вид участка маршрута транспортировки';
  rsLocalPointObjectType  ='Вид точечного объекта';
  rsJumpType   ='Переходы между зонами';

  rsMethodArgument     ='Аргумент способа';
  rsMethodEfficiency   ='Значение эффективности способа';

  rsPhysicalField     ='Физические поля';
  rsDeviceFunction    ='Функциональность устройства';
  rsDeviceState       ='Состояние средства охраны';
  rsHindrance         ='Вид помех, к которым чувствительно устройство';
  rsWeather           ='Вид погодных условий';

  rsZoneTypes         ='Виды зон';
  rsBoundarieTypes            ='Виды рубежей';
  rsBoundaryLayerTypes        ='Виды слоев рубежа';
  rsSurfaceSensorTypes        ='Виды поверхностных датчиков';
  rsPositionSensorTypes       ='Виды точечных датчиков';
  rsVolumeSensorTypes         ='Виды объемных датчиков';
  rsBarrierSensorTypes        ='Виды линейных датчиков';
  rsPerimeterSensorTypes      ='Виды периметровых датчиков';
  rsTVCameraTypes             ='Виды телевизионных камер';
  rsLightDeviceTypes          ='Виды осветительных приборов';
  rsPowerSourceTypes          ='Виды источников электропитания';
  rsCabelTypes                ='Виды линий связи';
  rsGuardPostTypes            ='Виды постов охраны';
  rsTargetTypes               ='Виды целей';
  rsControlDeviceTypes       ='Устройства управления и коммутации';
  rsConveyanceTypes           ='Виды траспортировки предмета охраны';
  rsConveyanceSegmentTypes    ='Виды участков маршрутов транспортировки';
  rsLocalPointObjectTypes  ='Вид точечного объекта';
  rsJumpTypes   ='Вид перехода между зонами';

  rsMethodArguments     ='Аргументы способа';
  rsMethodEfficiencies   ='Значения эффективности способа';

  rsPhysicalFields     ='Физические поля';
  rsDeviceFunctions    ='Функциональные возможности устройства';
  rsDeviceStates       ='Возможные состояния средства охраны';
  rsHindrances         ='Виды помех, к которым чувствительно устройство';
  rsWeathers           ='Виды погодных условий';

  rsZoneKind    ='Тип зоны';
  rsBoundaryKind    ='Тип рубежа';
  rsBoundaryLayerKind    ='Тип слоя рубежа';

  rsBarrierKind         ='Тип физического барьера';
  rsLockKind            ='Тип замка';
  rsUndergroundObstacleKind ='Тип основания заграждения';
  rsGroundObstacleKind      ='Тип оборудования запретной зоны';
  rsFenceObstacleKind       ='Тип препятствия перелазу';

  rsSurfaceSensorKind   ='Тип поверхностного извещателя';
  rsPositionSensorKind  ='Тип точечного извещателя';
  rsVolumeSensorKind    ='Тип объемного извещателя';
  rsBarrierSensorKind   ='Тип линейного извещателя';
  rsPerimeterSensorKind   ='Тип периметрового извещателя';
  rsContrabandSensorKind='Тип контроля перемещения предметов и материалов';
  rsAccessControlKind   ='Тип контроля доступа';

  rsTVCameraKind        ='Тип телевизионной  камеры';
  rsLightDeviceKind     ='Тип осветительного прибора';
  rsPowerSourceKind     ='Тип источника электропитания';
  rsCabelKind           ='Тип линии связи';
  rsAdditionalDeviceKind='Тип дополнительного устройства';
  rsGuardPostKind       ='Тип поста охраны';
  rsTargetKind          ='Тип цели';
  rsControlDeviceKind   ='Тип устройства управления и коммутации';
  rsConveyanceKind      ='Тип траспортировки предмета охраны';
  rsConveyanceSegmentKind        ='Тип участка маршрута траспортировки предмета охраны';
  rsLocalPointObjectKind  ='Тип точечного объекта';
  rsJumpKind   ='Тип перехода между зонами';

  rsZoneKinds                 ='Типы зон';
  rsBoundaryKinds             ='Типы рубежей';
  rsBoundaryLayerKinds        ='Типы слоев рубежа';
  rsSurfaceSensorKinds        ='Типы поверхностных извещателей';
  rsPositionSensorKinds       ='Типы точечных извещателей';
  rsVolumeSensorKinds         ='Типы объемных извещателей';
  rsBarrierSensorKinds        ='Типы линейных извещателей';
  rsPerimeterSensorKinds      ='Типы периметровых извещателей';
  rsTVCameraKinds             ='Типы телевизионных камер';
  rsLightDeviceKinds          ='Типы осветительных приборов';
  rsPowerSourceKinds          ='Типы источников электропитания';
  rsCabelKinds                ='Типы линий связи';
  rscAdditionalDeviceKinds    ='Типы дополнительных устройств';
  rsGuardPostKinds            ='Типы постов охраны';
  rsTargetKinds               ='Типы целей';
  rsControlDeviceKinds        ='Типы устройств управления и коммутации';
  rsConveyanceKinds        ='Типы траспортировки предмета охраны';
  rsConveyanceSegmentKinds ='Типы участков маршрутов транспортировки';
  rsLocalPointObjectKinds  ='Тип местного точечного объекта';
  rsJumpKinds   ='Тип перехода между зонами';

  rsParents          ='Обратные связи';
  rsOvercomeMethod   ='Способ преодоления средства охраны';
  rsWeaponType       ='Вооружение';
  rsWeaponKind       ='Тип вооружения';
  rsToolType         ='Инструменты';
  rsToolKind         ='Тип инструмента';
  rsIsDefault        ='Имеется по умолчанию';
  rsVehicleType      ='Транспортные средства';
  rsVehicleKind      ='Тип транспортного средства';
  rsAthorityType     ='Полномочия';
  rsSkillType        ='Навыки';
  rsSkillKind        ='Уровень навыков';
  rsGuardCharacteristicType ='Вид субъективных характеристик охраны';
  rsGuardCharacteristicKind ='Уровень субъективных характеристик охраны';

  rsSGDBParameter='Параметр';
  rsSGDBParameters='Параметры';
  rsElementParameter='Параметр элемента модели';
  rsElementParameters='Параметры элементов модели';

  rsShotDispersionRec='Дальность, м';
  rsShotDispersionRecs='Характеристики рассеяния';
  rsShotBreachRec='Тип пули';
  rsShotBreachRecs='Характеристики бронепробития';
  rsMediumDeviationFormat='Срединные отклонения стрельбы на расстоянии %4.0f м';
  rsWeaponBreachFormat='С пулей %s (максимальный класс простреливаемой защиты - %s)';
  rsNotDefined='Не определено';

  rsShotDistanceError='Ошибка при задании характеристики рассеяния';

  rsCalcDelayProc='Процедура расчета времени задержки';
  rsCalcProbabilityProc='Процедура расчета вероятности обнаружения';
  rsCalcFieldsProc='Процедура расчета демаскирующих факторов';
  rsCalcDelayLib='Библиотека процедур расчета времени задержки';
  rsCalcProbabilityLib='Библиотека процедур расчета вероятности обнаружения';
  rsCalcFieldsLib='Библиотека процедур расчета демаскирующих факторов';

  rsWeaponVerticalDeviation1='Срединное отклонение по высоте при стрельбе одиночными выстрелами';
  rsWeaponHorizontalDeviation1='Боковое срединное отклонение при стрельбе одиночными выстрелами';
  rsWeaponVerticalDeviation2='Суммарное срединное отклонение по высоте при стрельбе очередями';
  rsWeaponHorizontalDeviation2='Суммарное боковое срединное отклонение при стрельбе очередями';
  rsWeaponDistance='Расстояние до цели, м';

  rsPedestrialMovementVelocity='Скорость передвижения пешком, км/ч';
  rsCarMovementEnabled='Возможно движение автотранспорта';
  rsAirMovementEnabled='Возможно движение летательных аппаратов';
  rsWaterMovementEnabled='Возможно движение надводных транспортных средств';
  rsUnderWaterMovementEnabled='Возможно движение подводных транспортных средств';
  rsRoadCover='Дорожное покрытие';
  rsDefaultCategory='Категория зоны по умолчанию';
  rsHSubZoneKind='Тип горизонтальных подзон по умолчанию';
  rsVSubZoneKind='Тип вертикальных подзон по умолчанию';
  rsUpperZoneKind='Тип верхней зоны по умолчанию';
  rsLowerZoneKind='Тип нижней зоны по умолчанию';
  rsSpecialKind='Специальный тип зоны';

  rsNone='Нет';
  rsAir='Воздушная зона над объектом';
  rsEarth='Зона под землей';
  rsSite='Зона на поверхности земли';
  rsRoof='Зона на крыше здания';
  rsBuilding='Зона - здание';

  rsPrice='Цена';
  rsInstallCoeff='Коэф cложности монтажных работ';
  rsPriceDimension='Единицы измерения цены';
  rsPerPieceR='руб./шт.';
  rsPerLengthR='руб./м';
  rsPerSquareR='руб./м2';
  rsPerVolumeR='руб./м3';
  rsPerComplectR='руб./компл.';
  rsPerPieceU='у.е./шт.';
  rsPerLengthU='у.е./м';
  rsPerSquareU='у.е./м2';
  rsPerVolumeU='у.е./м3';
  rsPerComplectU='у.е./компл.';

  rsImage='Изображение';
  rsImage2='Дублирующее изображение';
  rsMainDeviceState='Основное состояние';
  rsDefaultHeight='Высота по умолчанию, м';
  rsIsZone='Представляет собой зону';
  rsAlwaysShowImage='Всегда показывать изображение слоя';
  rsElementImage='Изображения объектов';
  rsElementImages='Изображения объектов';
  rsStartPointType='Исходные позиции';
  rsStartPointKind='Тип исходной позиции';
  rsStartPointTypes='Виды исходных позиций';
  rsStartPointKinds='Типы исходных позиций';
  rsActiveSafeguardType='Средства воздействия';
  rsActiveSafeguardKind='Тип средства воздействия';
  rsActiveSafeguardTypes='Виды средств воздействия';
  rsActiveSafeguardKinds='Типы средств воздействия';

  rsElementImageScalingType='Масштабируемость изображения';
  rsElementImageNoScale='Фиксированный размер изображения';
  rsElementImageScale='Масштабируемое изображение';
  rsElementImageXScale='Изображение, масштабируемое по горизонтали';
  rsElementImageMinPixels='Минимальный размер изображения в пикселях';
  rsElementImageMaxSize='Максимальный размер одного изображения, см';

  rsCalcFalseAlarmPeriodProc='Процедура расчета частоты ложных тревог';
  rsCalcFalseAlarmPeriodLib='Библиотека процедур расчета частоты ложных тревог';

  rsTransparent='Прозрачно';
  rsFragile='Хрупко';
  rsIsFieldPath='Влияет на распространение полей';
  rsIsDeceitPath='Может быть преодолен обманным путем';

  rsObserverParam='Задает параметры наблюдения';
  rsDependsOnReliability='Зависит от надежности средства охраны';
  rsNot='Нет';
  rsEvidence='Остаются улики';
  rsLegal='Не вызывает подозрений';
  rsFailure='Неудача приводит к срыву акции';

  rsEc='Стойкость к силовому взлому, Ес';
  rsCriminalEc='Стойкость к криминальному взлому, Ес';
  rsOpeningTime='Время нормального открывания, c';
  rsToolBaseEc='Базовый коэффициент, Ес';
  rsToolCoeffEc='Коэффициент инструмента, Ес/мин';
  rsDelayTimeFactor='Фактор увеличения времени задержки';
  rsNoDetectionProbabilityFactor='Фактор увеличения вероятности необнаружения';
  rsDetectionProbability='Вероятность обнаружения, согласно ТУ';
  rsFalseAlarmPeriod='Период ложных срабатываний, ч';
  rsZoneLength='Длина зоны обнаружения, м';
  rsZoneWidth='Ширина зоны обнаружения, м';
  rsZoneHalfWidth='Полуширина зоны обнаружения, м';
  rsZoneHeight='Высота зоны обнаружения, м';
  rsReliabilityTime='Время наработки на отказ, ч';
  rsDefaultDetectionPosition='Позиция по умолчанию';
  rsOuter='Внешняя';
  rsCentral='Центральная';
  rsInner='Внутренняя';
  rsDetectionZoneImage='Изображение зоны обнаружения';
  rsTVResolution='Разрешение телекамеры, число линий на см';
  rsMinDetectableSpeed='Минимальная скорость обнаруживаемого перемещения, м/c';
  rsUnlockTime='Время открывания замка ключем, с';
  rsOvercomeUsable='Объект может быть использован для преодоления препятствия';
  rsClimbUpVelocity='Скорость подъема, м/с';
  rsClimbDownVelocity='Скорость спуска, м/с';
  rsWeaponRezistanceLevel='Класс защиты от огнестрельного оружия';
  rsAlarmButton='Пост оборудован кнопкой тревожного вызова';
  rsFalseAccessDenay='Вероятность ложного отказа';
  rsFalseAccess='Вероятность ложного допуска';
  rsDelayProcCode='Код встроенной процедуры расчета времени задержки';
  rsProbabilityProcCode='Код встроенной процедуры расчета вероятности обнаружения';
  rsFieldsProcCode='Код встроенной процедуры расчета демаскирующих факторов';

  rsMaxShotDistance='Максимальная дальность поражения, м';
  rsPreciseShotDistance='Прицельная дальность, м';
  rsShotRate='Скорострельность, выстрел/мин';
  rsShotForce='Максимальный класс простреливаемой защиты ';
  rsShotCapacity='Боекомплект';

  rsInControlSectorDetectionProbability='Вероятность визуального обнаружения в основном секторе обзора';
  rsOutOfControlSectorDetectionProbability='Вероятность визуального обнаружения вне основного сектора обзора';
  rsSoundDetectionProbability='Вероятность обнаружения на слух';
  rsSGDBParameterValue='Значение параметра';
  rsSafeguardClass='Класс средств охраны';
  rsSafeguardClasses='Классы средств охраны';
  rsMainGroupStrategy='Тактика основной группы';
  rsDeceitStrategy='Обманная тактика';
  rsPathStage='Направление движения';
  rsReserved='Зарезервировано';
  rsVehicleTypeCode='Вид транспортного средства';
  rsVehicleVelocity1='Максимальная скорость, км/ч';
  rsVehicleVelocity2='Скорость на пересеченной местности, км/ч';
  rsVehicleVelocity3='Скорость на труднопроходимых участках, км/ч';

  rsZoneNoVelocity='Движение транспорта невозможно';
  rsZoneVelocity1='Максимальная скорость движения транспорта';
  rsZoneVelocity2='Пересеченная местность';
  rsZoneVelocity3='Труднопроходимая  местность';

  rsVehicleDefenceLevel='Класс защищенности от стрелкового оружия';
  rsVehicleWidth='Ширина, м';
  rsDefenceLevel='Класс защищенности от стрелкового оружия';
  rsZoneImage='Изображение зоны обнаружения';
  rsDefaultElevation='Рекомендуемая высота установки';
  rsDetectionOnBoundary='Обнаружение только на границе зоны';
  rsComment='Комментарий';
  rsDefaultBottomBoundaryKind='Тип нижнего рубежа по умолчанию';
  rsDefaultTopBoundaryKind='Тип верхнего рубежа по умолчанию';
  rsDefaultSideBoundaryKind='Тип бокового рубежа по умолчанию';
  rsSingleLayer='Имеет только один слой';
  rsHighPath='Проницаем на высоте';
  rsDontCross='Допускается исключение из анализа';
  rsOrientation='Ориентация';
  rsDefaultBottomEdgeHeight='Высота нижнего края по умолчанию, см';
  rsJumpDefault='Используется по умолчанию';
  rsDefaultForStair='Для лестничных маршей';
  rsDefaultForElevator='Для лифтов';
  rsAny='Любая';
  rsVertical='Только вертикальная';
  rsNotVertical='Только не вертикальная';

  rsVirtual='Условные линии';
  rsHidden='Скрытые линии';
  rsWall='Контуры стен';
  rsDoor='Контуры дверей';
  rsWindow='Контуры окон';
  rsFencil='Контуры ограждений';
  rsLayerKind='Графический слой по умолчанию';


  rsSubBoundaryKind='Типы подрубежей';
  rsTactic='Тактика преодоления рубежа';
  rsFastTactic='Тактика применяется при прорыве';
  rsStealthTactic='Тактика применяется при скрытном проникновении';
  rsDeceitTactic='Обманная тактика';
  rsForceTactic='Насильственная тактика';
  rsEntryTactic='Тактика применяется на входе';
  rsExitTactic='Тактика применяется на выходе';
  rsOutsiderTactic='Тактика применяется внешними нарушителями';
  rsInsiderTactic='Тактика применяется внутренними нарушителями';
  rsGuardTactic='Тактика применяется охраной';
  rsPathArcKind='Вид участка маршрута, для которого применяется тактика';
  rsMethodDimItem='Значение параметра способа';
  rsMethodArrayValue='Вектор значений';
  rsMethodDimension='Параметр способа';

  rsCodeMatrix = 'Выбор значения по коду из таблицы';
  rsMatrix = 'Выбор значения из таблицы';
  rsVelocityCodeMatrix = 'Выбор скорости по коду из таблицы';
  rsVelocityMatrix = 'Выбор скорости из таблицы';
  rsMinimum='Минимальная задержка';
  rsExternal = 'Внешняя процедура';
  rsZeroP = 'Нет обнаружения';
  rsZeroD = 'Нет задержки';
  rsOne = 'Не применимо';
  rsInfinit = 'Не применимо';
  rsDirectValue = 'Явно заданное значение';
  rsStandard = 'Вероятность обнаружения в стандартных условиях';
  rsDEc = 'Расчет по ГОСТу';
  rsDCriminalEc = 'Расчет по ГОСТу для криминального вскрытия';
  rsUseKey = 'Алгоритм учета наличия ключа';
  rsClimb = 'Расчет времени подъема/спуска';
  rsGuard = 'Моделирование поста охраны';
  rsMethodDimensionSourceKind='Источник значений параметра';
  rsMethodDimensionKind='Тип параметра';
  rsMethodDimensionCode='Код параметра';
  rsSubArrayIndex='Порядковый номер матрицы';
  rsSafeguardElementParam='Параметр средства охраны';
  rsSafeguardElementKindParam='Параметр типа средства охраны';
  rsWarriorGroupParam='Параметр нарушителя';
  rsFinishPointParam='Параметр цели нарушителя';
  rsBoundaryParam='Параметр рубежа';
  rsBoundaryLayerParam='Параметр слоя рубежа';
  rsZoneParam='Параметр зоны';
  rsControlDeviceParam='Параметр управляющего устройства';
  rsControlDeviceKindParam='Параметр типа управляющего устройства';
  rsMethodParam='Тип матрицы значений';
  rsMass='Масса, кг';
  rsMaxSize='Наибольший размер, м';
  rsMinSize='Наименьший размер, м';
  rsHasMetall='Активирует металлоискатель';
  rsGroupDamage='Поражает группу';
  rsRadiation='Излучение';
  rsSkillLevel ='Уровень навыка';
  rsHasToolType = 'Наличие инструмента';
  rsHasVehicleType = 'Наличие транспортного средства';
  rsHasWeaponType = 'Наличие оружия';
  rsHasAccess = 'Наличие разрешенного доступа';
  rsFieldValueInterval = 'Интервал значений параметра';
  rsFieldValue = 'Значение параметра';
  rsZoneForm='Форма зоны обнаружения';

  rsNoScaling = 'Фиксированный размер изображения';
  rsScaling = 'Фиксированный размер объекта';
  rsXScaling = 'Привязка размера по X к длине объекта';
  rsXYScaling = 'Привязка размера по X и Y к размерам объекта';
  rsXYZScaling = 'Привязка всех размеров к размерам объекта';
  rsConus = 'Изображение сектора поля зрения';
  rsMultScaling = 'Заполение объекта изображением';
  rsVOne='Единственная точка пересечения вертикальной плоскости';
  rsVMany='Несколько точек пересечения вертикальной плоскости';
  rsHOne='Единственная точка пересечения горизонтальной  плоскости';
  rsHMany='Несколько точек пересечения горизонтальной плоскости';
  rsPathKind='Точки пересечения';
  rsSoundResistance='Коэффициент звукоизоляции, дб';
  rsContainLock='Содержит замок';
  rsUseElevation='Может иметь не нулевую высоту установки';
  rsSoundPower='Мощность звука, дб';
  rsViewAngle='Угол зрения';
  rsViewLength='Дальность зоны видимости';
  rsAssessProbability_NoRewind='Вероятность подтверждения обнаружения при отсутствии функции немедленного воспроизведения';
  rsAssessProbability_Rewind='Вероятность подтверждения обнаружения при наличии функции немедленного воспроизведения';
  rsGuardOrTV='Наблюдение';
  rsAlarmSignal='Тревожное оповещение';
  rsAlarmSignalSafety='Зашищенность линий связи';
  rsOvercomeTime='Запас времени';
  rsTechnicalService='Порядок техобслуживания';
  rsBarrierMaterial='Материал барьера';
  rsDetectionZoneSize='Размер зоны обнаружения';
  rsAdversaryCount='Число нарушителей';
  rsSafeguardElevation='Высота установки';
  rsBattleSkill='Уровни боевой подготовки';
  rsTakeAimTime='Время прицеливания';
  rsStillStillScoringFactor='Снижение вероятности попадания при стрельбе на месте по неподвижной мишени';
  rsRunStillScoringFactor='Снижение вероятности попадания при стрельбе на бегу по неподвижной мишени';
  rsStillRunScoringFactor='Снижение вероятности попадания при стрельбе на месте по движущейся мишени';
  rsRunRunScoringFactor='Снижение вероятности попадания при стрельбе на бегу по движущейся мишени';
  rsRunEvadeFactor='Вероятность уклониться от попадания на бегу';
  rsStillEvadeFactor='Вероятность уклониться от попадания на месте';
  rsDefaultAcceptableRisk='Приемлемый риск по умолчанию';
  rsCartridgeCountPerHit='Количество патронов в очереди';
  rsCartridgeCountPerScore_Still_Head='Кол-во патронов для головной фигуры с колена';
  rsCartridgeCountPerScore_Still_Chest='Кол-во патронов для грудной фигуры с колена';
  rsCartridgeCountPerScore_Still_Half='Кол-во патронов для поясной фигуры с колена';
  rsCartridgeCountPerScore_Still_Full='Кол-во патронов для полноростовой фигуры с колена';
  rsCartridgeCountPerScore_Still_Run='Кол-во патронов для движущейся фигуры с колена';
  rsCartridgeCountPerScore_Run_Head='Кол-во патронов для головной фигуры на ходу';
  rsCartridgeCountPerScore_Run_Chest='Кол-во патронов для грудной фигуры на ходу';
  rsCartridgeCountPerScore_Run_Half='Кол-во патронов для поясной фигуры на ходу';
  rsCartridgeCountPerScore_Run_Full='Кол-во патронов для полноростовой фигуры на ходу';
  rsCartridgeCountPerScore_Run_Run='Кол-во патронов для движущейся фигуры на ходу';
  rsScoreProbability='Вероятность поражения цели';
  rsBulletName='Наименование пули';
  rsDemandArmour='Максимальный класс простреливаемой защиты';
  rsBulletPS='ПС';
  rsBulletLPS='ЛПС';
  rsBulletBZ='БЗ';
  rsBulletThermo='ПС-термоупр.';
  rsBulletB32='Б-32';
  rsNoWeaponDefence='Не защищено';
  rsKnifeDefence='Защищено от холодного оружия';
  rsClass1='Защищено - Класс №1';
  rsClass2='Защищено - Класс №2';
  rsClass3='Защищено - Класс №3';
  rsClass4='Защищено - Класс №4';
  rsClass5='Защищено - Класс №5';
  rsClass5a='Защищено - Класс №5а';
  rsClass6='Защищено - Класс №6';
  rsClass6a='Защищено - Класс №6а';
  rsRPGDefence='Защищено от подствольного гранатомета';
  rsGoodRPGDefence='Защищено от ручного гранатомета';
  rsGunDefence='Защищено от стрелкового оружия';
  rsOpenedDefenceState='Силуэт мишени при стрельбе';
  rsHidedDefenceState='Силуэт мишени в укрытии';
  rsNoDefence='Полноростовая фигура';
  rsRunning='Бегущая фигура';
  rsHalfHeightDefence='Поясная фигура';
  rsChestHeightDefence='Грудная фигура';
  rsHeadHeightDefence='Головная фигура';
  rsFullDefence='Не на линии огня';
  rsLockAccessControl='Открывается системой контроля доступа';
  rsDetectionSector='Сектор обзора';
  rsDistance='Расстояние';
  rsCommunication='Средства связи';
  rsPostDefence='Защищенность';
  rsTime='Время';
  rsWeight='Вес';
  rsMineLength='Длина подкопа';
  rsTVMonitorCount='Нагрузка на оператора';
  rsDefaultMineDepth='Минимальная глубина подкопа по умолчанию, м';
  rsDefaultWidth='Ширина, см';
  rsGroundType='Тип грунта';
  rsLightGround='Легкий грунт';
  rsStounGround='Каменистый  грунт';
  rsRockGround='Скальный грунт';
  rsDefaultTransparencyDist='Дальность прямой видимости, м';
  rsHandTool='Ручной инструмент';
  rsDriveTool='Инструмент c приводом';
  rsExposive='Взрывчатка';
  rsAssessProbability='Вероятность подтверждения обнаружения нарушителя';
  rsAssessRequired='Требуется оценка сигнала тревоги';
  rsDestructive='Выводит из строя средство охраны';
  rsOptionalSpatialElement='Пространственный элемент можно не описывать';
  rsContactSensible='Реагирует на прикосновение';
  rsAddressInfo='Передача адреса';
  rsDamageInfo='Сообщение о неисправности';
  rsTamperInfo='Сообщение о вскрытии';
  rsLinkCheck='Проверка связи';
  rsInfoCapacity='Информационная емкость';
  rsProhibition='Запрет';
  rsKindID='KindID';
  rsSize='Размер объекта';
  rsPersonalCount='Численность допущенного персонала';
  rsSensorAccessControl='Управляется СКУД';
  rsRamEnabled='Возможность тарана';

  rsUpdating='Изменения базы данных';
  //rsUpdateKind='Тип изменения';
  rsUpdatingOldClassID='ClassID старого элемента';
  rsUpdatingOldRefID='ID старого элемента';
  rsUpdatingNewRef='ID нового элемента';

  rsTexture='Текстура';
  rsTextures='Текстуры';
  rsTypeID='TypeID';
  rsCommunicationDeviceType='Средства связи';
  rsCommunicationDeviceKind='Тип средства связи';

  rsSystemKind='Назначение';
  rsComplexSystem='Интегрированная система безопасности';
  rsAlarmSystem='Охранная сигнализация';
  rsTVSystem='Телевизионное наблюдение';
  rsAccessSystem='Контроль доступа';
  rsAlarmFireSystem='Охранно-пожарная сигнализация';
  rsFireSystem='Пожарная сигнализация';
  rsKeyStorageSystem='Место хранения ключей';

  rsDuplex='Двусторонний вызов';
  rsConnectionTime='Время соединения, с';
  rsTHL1='Время задержки (ручной инструмент, низкая подготовка, 1 человек), мин';
  rsTHL2='Время задержки (ручной инструмент, низкая подготовка, 2 человека), мин';
  rsTHM1='Время задержки (ручной инструмент, средняя подготовка, 1 человек), мин';
  rsTHM2='Время задержки (ручной инструмент, средняя подготовка, 2 человека), мин';
  rsTHH1='Время задержки (ручной инструмент, высокая подготовка, 1 человек), мин';
  rsTHH2='Время задержки (ручной инструмент, высокая подготовка, 2 человека), мин';

  rsTDL1='Время задержки (инструмент, низкая подготовка, 1 человек), мин';
  rsTDL2='Время задержки (инструмент, низкая подготовка, 2 человека), мин';
  rsTDM1='Время задержки (инструмент, средняя подготовка, 1 человек), мин';
  rsTDM2='Время задержки (инструмент, средняя подготовка, 2 человека), мин';
  rsTDH1='Время задержки (инструмент, высокая подготовка, 1 человек), мин';
  rsTDH2='Время задержки (инструмент, высокая подготовка, 2 человека), мин';

  rsTEL1='Время задержки (ВВ, низкая подготовка, 1 человек), мин';
  rsTEL2='Время задержки (ВВ, низкая подготовка, 2 человека), мин';
  rsTEM1='Время задержки (ВВ, средняя подготовка, 1 человек), мин';
  rsTEM2='Время задержки (ВВ, средняя подготовка, 2 человека), мин';
  rsTEH1='Время задержки (ВВ, высокая подготовка, 1 человек), мин';
  rsTEH2='Время задержки (ВВ, высокая подготовка, 2 человека), мин';

  rsTSL1='Время задержки (спец инструмент, низкая подготовка, 1 человек), мин';
  rsTSL2='Время задержки (спец инструмент, низкая подготовка, 2 человека), мин';
  rsTSM1='Время задержки (спец инструмент, средняя подготовка, 1 человек), мин';
  rsTSM2='Время задержки (спец инструмент, средняя подготовка, 2 человека), мин';
  rsTSH1='Время задержки (спец инструмент, высокая подготовка, 1 человек), мин';
  rsTSH2='Время задержки (спец инструмент, высокая подготовка, 2 человека), мин';

  rsTNorm='Время нормального открывания, с';

  rsTL1='Время задержки (низкая подготовка, 1 человек), мин';
  rsTL2='Время задержки (низкая подготовка, 2 человека), мин';
  rsTM1='Время задержки (средняя подготовка, 1 человек), мин';
  rsTM2='Время задержки (средняя подготовка, 2 человека), мин';
  rsTH1='Время задержки (высокая подготовка, 1 человек), мин';
  rsTH2='Время задержки (высокая подготовка, 2 человека), мин';
implementation

end.
