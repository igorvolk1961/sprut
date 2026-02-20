unit FacilityModelConstU;

interface
const
  vdfNoDetection=0;
  vdfFull=1;
  vdfSqrt=2;

  tmToRoot=0;
  tmFromRoot=1;

  pakVBoundary = $00000001;
  pakHZone = $00000002;
  pakHLineObject = $00000003;
  pakHBoundary = $00000004;
  pakVZone = $00000005;
  pakVLineObject = $00000006;
  pakChangeFacilityState = $00000007;
  pakChangeWarriorGroup = $00000008;
  pakVBoundary_ = $00000009;
  pakRoad = $0000000A;
  pakTarget = $0000000B;
  pakRZone = $0000000C;
  pakOutline = $0000000D;
  pakTMP = $0000000E;

  wpsStealthEntry=0;
  wpsFastEntry=1;
  wpsStealthExit=2;
  wpsFastExit=3;

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

  FrontCanvas=1;
  BackCanvas=2;
  BackCanvas2=4;

  obsTVCamera=0;
  obsGuardPost=1;
  obsGuardPostDelay=2;
  obsPersonal=3;
  obsPatrol=4;
  obsSensor=5;
  obsGuardPostSoundDet=6;
  obsGuardPostSoundDetDelay=7;
  obsPersonalSoundDet=8;


type

  TFacilityModelParameterNum=(
    fmBuildDirection,
    fmChangeLengthDirection,
    fmDrawOrdered,
    fmCurrentLayer,
    fmCurrentFont,
    fmBuildVerticalLine,
    fmBuildJoinedVolume,
    fmLocalGridCell,
    fmDefaultVerticalAreaWidth,
    fmDefaultObjectWidth,
    fmDefaultVolumeHeight,
    fmRenderAreasMode,

    fmDefaultOpenZoneHeight,
    fmShowOptimalPathFromBoundary,
    fmShowFastPathFromBoundary,
    fmShowStealthPathToBoundary,
    fmShowFastGuardPathToBoundary,
    fmShowOptimalPathFromStart,
    fmShowGraph,
    fmShowText,
    fmShowSymbols,
    fmShowWalls,
    fmShowDetectionZones,
    fmShowOnlyBoundaryAreas,
    fmUseBattleModel,
    fmBuildAllVerticalWays,
    fmDelayTimeDispersionRatio,
    fmZoneDelayTimeDispersionRatio,
    fmResponceTimeDispersionRatio,
    fmDefaultReactionMode,
    fmCriticalFalseAlarmPeriod,
    fmCalcOptimalPathFlag,
    fmCalcOptimalPathFromStartFlag,
    fmCurrencyRate,
    fmPriceCoeffD,
    fmPriceCoeffTZSR,
    fmPriceCoeffPNR,
    fmTotalEfficiencyCalcMode,
    fmGraphColor,
    fmFastPathColor,
    fmStealthPathColor,
    fmRationalPathColor,
    fmGuardPathColor,
    fmMaxBoundaryDistance,
    fmMaxPathAlongBoundaryDistance,
    fmShoulderWidth,
    fmPathHeight,
    fmUseSimpleBattleModel
  );

  TZoneCategory=(
    zscStates,
    zscZones,
    zscSafeguardElements,
    zscObservers,
    zscVBoundaries,
    zscHBoundaries,
    zscJumps
  );

  TBoundaryLayerCategory=(
    dlcStates,
    dlcSafeguardElements,
    dlcSubBoundaries
  );

  TBoundaryCategory=(
    zbcStates,
    zbcBoundaryLayers,
    zbcObservers,
    zbcWarriorPaths
  );

  TControlDeviceCategory=(
    cmcStates,
    cmcConnections,
    cmcBoundaryLayers,
    cmcObservers,
    cmcWarriorPaths
  );

  TFacilityElementParameterNum=(
    fepRationalProbabilityToTarget,
    fepDelayTimeToTarget,
    fepNoDetectionProbabilityFromStart
  );

  TZoneParameterNum=(
    zpRationalProbabilityToTarget,       //0
    zpDelayTimeToTarget,                 //1
    zpNoDetectionProbabilityFromStart,   //2
    zpZoneCategory,                      //3
    zpPersonalPresence,                  //4
    zpPersonalCount,                     //5
    zpDummy10,    //6
    zpDummy11,               //7
    zpTransparencyDist,                  //8
    zpUserDefinedVehicleVelocity,        //9
    zpVehicleVelocity,                   //10
    zpPedestrialVelocity                 //11
  );

  TGlogalZoneParameterNum=(
    gzpRationalProbabilityToTarget,       //0
    gzpDelayTimeToTarget,                 //1
    gzpNoDetectionProbabilityFromStart,   //2
    gzpZoneCategory,                      //3
    gzpPersonalPresence,                  //4
    gzpPersonalCount,                     //5
    gzpDummy10,    //6
    gzpDummy11,               //7
    gzpTransparencyDist,                  //8
    gzpUserDefinedVehicleVelocity,        //9
    gzpVehicleVelocity,                   //10
    gzpPedestrialVelocity,                //11
    gzpLargestZone                        //12
  );

  TRoadParameterNum=(
    rpUserDefinedVehicleVelocity,       //0
    rpVehicleVelocity,                  //1
    rpPedestrialVelocity,               //2
    rpPersonalPresence                  //3
  );


  TBoundaryParameterNum=(
    bopRationalProbabilityToTarget,       //0
    bopDelayTimeToTarget,                 //1
    bopNoDetectionProbabilityFromStart,   //2
    bopUserDefinedDelayTime,              //3
    bopDelayTime,                         //4
    bopUserDefinedDetectionProbability,   //5
    bopDetectionProbability,              //6
    bopFlowIntencity,                     //7
    bopFalseAlarmPeriod,                  //8
    bopDummy10,    //9
    bopDummy11,               //10

    bopShowLayersMode,                    //11
    bopMaxBoundaryDistance,               //12
    bopMaxPathAlongBoundaryDistance,      //13
    bopShoulderWidth,                     //14
    bopBottomEdgeHeight                   //15
  );


   TTargetParameterNum=(
     tpSuccessProbability,                //0
     tpDelayTimeToTarget,                 //1
     tpNoDetectionProbabilityFromStart,   //2
     tpUserDefinedDelayTime,              //3
     tpDelayTime,                         //4
     tpUserDefinedDetectionProbability,   //5
     tpDetectionProbability,              //6
     tpFlowIntencity,                     //7
     tpFalseAlarmPeriod,                  //8
     tpDummy10,    //9
     tpDummy11,               //10

     tpMass,                              //11
     tpMaxSize,                           //12
     tpMinSize,                           //13
     tpHasMetall,                         //14
     tpRadiation                          //15
   );

   TControlDeviceParameterNum=(
     cpSuccessProbability,                //0
     cpDelayTimeToTarget,                 //1
     cpNoDetectionProbabilityFromStart,   //2
     cpUserDefinedDelayTime,              //3
     cpDelayTime,                         //4
     cpUserDefinedDetectionProbability,   //5
     cpDetectionProbability,              //6
     cpFlowIntencity,                     //7
     cpFalseAlarmPeriod,                  //8
     cpDummy10,    //9
     cpDummy11,               //10

     cpDeviceState0,                      //11
     cpDeviceState1                       //12
   );



  TJumpParameterNum=(
    loSuccessProbability,                //0
    loDelayTimeToTarget,                 //1
    loNoDetectionProbabilityFromStart,   //2
    loUserDefinedDelayTime,              //3
    loDelayTime,                         //4
    loUserDefinedDetectionProbability,   //5
    loDetectionProbability,              //6
    loFlowIntencity,                     //7
    loFalseAlarmPeriod,                  //8
    loDummy10,               //9
    loDummy11,               //10

    loBoundary0,                         //11
    loZone0,                             //12
    loBoundary1,                         //13
    loZone1,                             //14
    loWidth,                             //15
    loClimbUpVelocity,                   //16
    loClimbDownVelocity                  //17
  );

const
  fepLabelVisible=201;
  fepLabelScaleMode=202;
  fepFont=203;
  
  fepBackPathRationalProbability=211;
  fepDelayTime0=212;
  fepDetectionProbability0=213;
  fepGoalDefining=214;

  blpHeight0=104;
  blpHeight1=105;
  blpDummy=106;
  blpDistanceFromPrev=107;
  blpDrawJoint0=108;
  blpDrawJoint1=109;
  blpConstruction=140;

  blpUserDefinedDelayTime=111;
  blpDelayTime=112;
  blpUserDefinedDetectionProbability=113;
  blpDetectionProbability=114;

  depUserDefinedWorkProbability=115;
  depWorkProbability=116;

  cnstWidth=7771;
  cnstSymbolDX=7780;
  cnstSymbolDY=7781;
  cnstComment=8881;
  cnstDeviceCount=8882;
  cnstDisabled=8888;
  cnstPresence=9991;
  cnstInstallCoeff=9992;
  cnstShowSymbol=9993;
  cnstSymbolScaleFactor=9994;
  cnstImageRotated=9995;
  cnstImageMirrored=9996;

type

  TSafeguardElementParameterNum=(
    seDeviceState0,
    seDeviceState1
  );

  TCommunicationDeviceParameterNum=(
    cdDeviceState0,
    cdDeviceState1,
    cdConnectionTime,
    cdSecret
  );

  TElementStatetParameter=(
    esUserDefinedDelayTime,               //0
    esDelayTime,                          //1
    esUserDefinedDetectionProbability,    //2
    esDetectionProbability                //3
  );

  TSafeguardElementStateParameterNum=(
    sesUserDefinedDelayTime,               //0
    sesDelayTime,                          //1
    sesUserDefinedDetectionProbability,    //2
    sesDetectionProbability,               //3
    sesDeviceState0,                       //4
    sesDeviceState1                        //5
  );

  TDelayElementParameterNum=(
    deDeviceState0,
    deDeviceState1,
    deUserDefinedDelayTime,
    deDelayTime,
    deUserDefinedDelayTimeDispersionRatio,
    deDelayTimeDispersionRatio
  );

  TBarrierParameterNum=(
    bpDeviceState0,                        //0
    bpDeviceState1,                        //1
    bpUserDefinedDelayTime,                //2
    bpDelayTime,                           //3
    bpUserDefinedDelayTimeDispersionRatio, //4
    bpDelayTimeDispersionRatio,            //5
    bpDummy1,                              //6

    bpAccessControl,                       //7
    bpKeyStorage,                          //8
    bpDummy,                               //9
    bpElevation                            //10
  );

  TUndergroundObstacleParameterNum=(
    uopDeviceState0,                        //0
    uopDeviceState1,                        //1
    uopUserDefinedDelayTime,                //2
    uopDelayTime,                           //3
    uopUserDefinedDelayTimeDispersionRatio, //4
    uopDelayTimeDispersionRatio,            //5
    uopDummy1,                              //6

    uopMinMineDepth                         //7
  );

  TGroundObstacleParameterNum=(
    gopDeviceState0,                        //0
    gopDeviceState1,                        //1
    gopUserDefinedDelayTime,                //2
    gopDelayTime,                           //3
    gopUserDefinedDelayTimeDispersionRatio, //4
    gopDelayTimeDispersionRatio,            //5
    gopDummy1,                              //6

    gopWidth                                //7
  );

  TFenceObstacleParameterNum=(
    fopDeviceState0,                        //0
    fopDeviceState1,                        //1
    fopUserDefinedDelayTime,                //2
    fopDelayTime,                           //3
    fopUserDefinedDelayTimeDispersionRatio, //4
    fopDelayTimeDispersionRatio,            //5
    fopDummy1,                              //6

    fopWidth                                //7
  );

  TLockParameterNum=(
    lpDeviceState0,                        //0
    lpDeviceState1,                        //1
    lpUserDefinedDelayTime,                //2
    lpDelayTime,                           //3
    lpUserDefinedDelayTimeDispersionRatio, //4
    lpDelayTimeDispersionRatio,            //5
    lpDummy1,                              //6

    lpAccessControl,                       //7
    lpKeyStorage,                          //8
    lpLockAccessibility                    //9
  );


  TDetectionParameterNum=(
    depDeviceState0,                     //0
    depDeviceState1,                     //1
    depUserDefinedDetectionProbability,  //2
    depDetectionProbability,             //3
    depDetectionPosition,                //4

    depLocalAlarmSignal,                 //5
    depMainControlDevice,                //6
    depSecondaryControlDevice,           //7
    depTechnicalService                  //8
  );


  TDistantDetectionParameterNum=(
    ddpDeviceState0,                       //0
    ddpDeviceState1,                       //1
    ddpUserDefinedDetectionProbability,    //2
    ddpDetectionProbability,               //3
    ddpDetectionPosition,                  //4

    ddpLocalAlarmSignal,                   //5
    ddpMainControlDevice,                  //6
    ddpSecondaryControlDevice,             //7
    ddpDummy2,                              //8
    ddpTechnicalService,                   //9

    ddpDummy3,                             //10
    ddpDummy4,                             //11
    ddpDummy5,                             //12

    ddpElevation,                          //13
    ddpLabelVisible,                       //14
    ddpLabelScaleMode,                     //15
    ddpFont                                //16
  );


  TTVCameraParameterNum=(
    tvcDeviceState0,                       //0
    tvcDeviceState1,                       //1
    tvcUserDefinedDetectionProbability,    //2
    tvcDetectionProbability,               //3
    tvcDetectionPosition,                  //4

    tvcLocalAlarmSignal,                   //5
    tvcMainControlDevice,                  //6
    tvcSecondaryControlDevice,             //7
    tvcDummy2,                             //8
    tvcTechnicalService,                   //9

    tvcViewAngle,                          //10
    tvcIsSlewing,                          //11
    tvcSlewAngle,                          //12

    tvcElevation,                          //13

    tvcMotionSensor,                       //14
    tvcVideoRecord                         //15
  );


  TSensorParameterNum=(
    spDeviceState0,                        //0
    spDeviceState1,                        //1
    spUserDefinedDetectionProbability,     //2
    spDetectionProbability,                //3
    spDetectionPosition,                   //4

    spLocalAlarmSignal,                    //5
    spMainControlDevice,                   //6
    spSecondaryControlDevice,              //7
    spDummy2,                              //8
    spTechnicalService,                    //9

    spUserDefinedFalseAlarmPeriod,         //10
    spFalseAlarmPeriod,                    //11
    spDisableFalseAlarm                    //12
  );

  TContrabandSensorParameterNum=(
    csDeviceState0,                        //0
    csDeviceState1,                        //1
    csUserDefinedDetectionProbability,     //2
    csDetectionProbability,                //3
    csDetectionPosition,                   //4

    csLocalAlarmSignal,                    //5
    csMainControlDevice,                   //6
    csSecondaryControlDevice,              //7
    csDummy2,                              //8
    csTechnicalService,                    //9

    csUseAlways                            //10
  );

  TPositionSensorParameterNum=(
    pospDeviceState0,                        //0
    pospDeviceState1,                        //1
    pospUserDefinedDetectionProbability,     //2
    pospDetectionProbability,                //3
    pospDetectionPosition,                   //4

    pospLocalAlarmSignal,                    //5
    pospMainControlDevice,                   //6
    pospSecondaryControlDevice,              //7
    pospDummy2,                              //8
    pospTechnicalService,                    //9

    pospUserDefinedFalseAlarmPeriod,         //10
    pospFalseAlarmPeriod,                    //11
    pospDisableFalseAlarm,                   //12

    pospAlwaysAlarms                         //13
  );

  TSurfaceSensorParameterNum=(
    sspDeviceState0,                             //0
    sspDeviceState1,                             //1
    sspUserDefinedDetectionProbability,          //2
    sspDetectionProbability,                     //3
    sspDetectionPosition,                        //4
    sspLocalAlarmSignal,                         //5
    sspMainControlDevice,                        //6
    sspSecondaryControlDevice,                   //7
    sspDummy2,                                   //8
    sspTechnicalService,                         //9

    sspUserDefinedFalseAlarmPeriod,              //10
    sspFalseAlarmPeriod,                         //11
    sspDisableFalseAlarm,                        //12

    sspSensorDistance                            //13
  );

  TPerimeterSensorParameterNum=(
    pspDeviceState0,                           //0
    pspDeviceState1,                           //1
    pspUserDefinedDetectionProbability,        //2
    pspDetectionProbability,                   //3
    pspDetectionPosition,                      //4

    pspLocalAlarmSignal,                       //5
    pspMainControlDevice,                      //6
    pspSecondaryControlDevice,                 //7
    pspDummy2,                                 //8
    pspTechnicalService,                       //9

    pspUserDefinedFalseAlarmPeriod,            //10
    pspFalseAlarmPeriod,                       //11
    pspDisableFalseAlarm,                      //12

    pspElevation,                              //13
    pspLabelVisible,                           //14
    pspLabelScaleMode,                         //15
    pspFont,                                   //16

    pspSensorDepth,                            //17
    pspZoneWidth                               //18
  );

  TGuardPostParameterNum=(
    pstDeviceState0,                       //0
    pstDeviceState1,                       //1
    pstUserDefinedDetectionProbability,    //2
    pstDetectionProbability,               //3
    pstDetectionPosition,                  //4

    pstLocalAlarmSignal,                   //5
    pstMainControlDevice,                  //6
    pstSecondaryControlDevice,             //7
    pstDummy2,                             //8
    pstTechnicalService,                   //9

    pstUserDefinedDelayTime,               //10
    pstDelayTime,                          //11
    pstDummy5,                             //12

    pstElevation,                          //13
    pstLabelVisible,                       //14
    pstLabelScaleMode,                     //15
    pstFont,                               //16

    pstPostAlarmButton,                    //17
    pstDutyDistance,                       //18
    pstDefenceLevel,                       //19
    pstOpenedDefenceState,                 //20
    pstHidedDefenceState                   //21
  );


  TTechnicalServiceParameterNum=(
    tsPeriod,
    tsControl,
    tsTesting
  );

  TSafeguardElementCategory=(
    secStates
  );

  TCabelNodeCategory=(
    cncStates,
    cncCabels
  );

  TDistantDetectionCategory=(
    ddcStates,
    ddcObservers,
    ddcCabels
  );

  TGuardPostCategory=(
    gpcStates,
    gpcObservers,
    gpcControlDevices,
    gpcCommunicationDevices,
    gpcWarriorGroups,
    gpcCabels
  );

  TWarriorCategory=(
    wcWeapons,
    wcVehicles,
    wcTools,
    wcAccesses
  );

  TGuardCategory=(
    gcWeapons,
    gcVehicles,
    gcTools,
    gcAccesses,
    gcStates
  );

   TAdversaryCategory=(
    acWeapons,
    acVehicles,
    acTools,
    acAccesses,
    acLocks,
    acControlDeviceAccesses,
    acGuardPostAccesses,
    acAthorities
  );

  TWarriorParameterNum=(
    wapNumber,
    wapStartPoint,
    wapFinishPoint,
    wapBattleSkill,
    wapToolSkill,
    wapTask
  );

  TAdversaryParameterNum=(
    apNumber,
    apStartPoint,
    apFinishPoint,
    apBattleSkill,
    apToolSkill,
    apTask,
    apTargetAccessRequired,
    apTargetDelayTime,
    apUserDefinedTargetDelayDispersionRatio,
    apTargetDelayDispersionRatio,
    apTargetFieldValue
  );

  TGuardParameterNum=(
    gpNumber,
    gpStartPoint,
    gpFinishPoint,
    gpBattleSkill,
    gpToolSkill,
    gpTask,
    gpStartDelay,
    gpStartCondition,
    gpPursuitKind,
    gpUserDefinedArrivalTime,
    gpArrivalTime,
    gpUserDefinedBattleResult,
    gpDefenceBattleP,
    gpAttackBattleP,
    gpDefenceBattleT,
    gpAttackBattleT
    );

  TAnalysisVariantParameterNum=(
    avpFacilityState,
    avpAdversaryVariant,
    avpGuardStrategy,
    avpGuardVariant,
    avpUserDefinedResponceTime,
    avpResponceTime,
    avpUserDefinedResponceTimeDispersionRatio,
    avpResponceTimeDispersionRatio,
    avpVariantWeight,
    avpSystemEfficiency,
    avpBestAdversarySuccessProbability,
    avpBattleSystemEfficiency,
    avpBattleAdversarySuccessProbability,
    avpFalseAlarmPeriod,
    avpPrice,
    avpMaxPathCount,
    avpLargestZone
  );

  TZoneStateParameterNum=(
    zsUserDefinedDelayTime,
    zsDelayTime,
    zsUserDefinedDetectionProbability,
    zsDetectionProbability,
    zsPersonalPresence,
    zsPersonalCount,
    zsTransparencyDist,
    zsUserDefinedVehicleVelocity,
    zsVehicleVelocity,
    zsPedestrialVelocity
  );

  TGuardArrival=(
    gaArrivalTime0,
    gaArrivalTime1,
    gaUserDefinedArrivalTime
  );

const
  fpmiLow=11;
  
type
  TFacilityPopupMenuItem=(
    fpmiEdit,
    fpmiUp,
    fpmiDown,
    fpmiLeft,
    fpmiRight,
    fpmiShiftUp,
    fpmiShiftDown,
    fpmiShiftLeft,
    fpmiShiftRight,
    fpmiSpace,
    fpmiEscape,

    fpmiCreateZoneSector,
    fpmiCreateBoundary,
    fpmiCreateSafeguardElement,
    fpmiCreateCabel,
    fpmiCreatePath,
    fpmiLinkWithZoneSector,
    fpmiLinkWithBoundary,
    fpmiLinkWithSafeguardElement,
    fpmiLinkWithCabel,
    fpmiLinkWithPatrolPath,
    fpmiDeleteZoneSectorLink,
    fpmiDeleteBoundaryLink,
    fpmiDeleteSafeguardElementLink,
    fpmiDeleteCabelLink,
    fpmiDeletePatrolPathLink,
    fpmiChangeZoneSector,
    fpmiChangeBoundary,
    fpmiChangeSafeguardElement,
    fpmiDeleteObject,
    fpmiDivideZone
  );


  TWarriorPathNodeParameterNum=(
    wpnX,
    wpnY,
    wpnZ,
    wpnDelayTimeToTarget,
    wpnNoDetectionProbabilityFromStart,
    wpnSuccessProbability
  );

  TPatrolPathParameterNum=(
    wpGuardGroup,
    wpPeriod,
    wpIrregular
  );

  TWarriorPathParameterNum=(
    wpSystemEfficiency,
    wpPathRationalProbability,
    wpPathNoDetectionProbability,
    wpPathDelayTime,
    wpCriticalPoint,
    wpResponceTimeRemainder
  );

  TOvercomingBoundaryNum=(
    obInfoState,
    obSumW,
    obProdNotU,
    obBattleProbability,
    obBattleTime,
    obQProbability,
    obResultProbability
  );

  TUserDefinedPathParameterNum=(
    udpSystemEfficiency,
    udpPathDelayTime,
    udpPathNoDetectionProbability,
    udpPathSuccessProbability,
    udpPathRationalProbability,
    udpCriticalPoint,
    udpResponceTimeRemainder,

    udpAnalysisVariant,
    udpReversed,
    udpReorded,
    udpAddTarget,
    udpAddBackPath,
    udpUserDefinedResponceTime,
    udpResponceTime,
    udpUserDefinedResponceTimeDispersionRatio,
    udpResponceTimeDispersionRatio,
    udpBaseLineGroup
//    udpOptimised
  );

  TCritialPointParameterNum=(
    cppInterruptionProbability,
    cppDetectionPotential,
    cppDelayTimeToTarget,
    cppTimeRemainder
  );

  TWarriorPathElementParameterNum=(
    wpeN,
    wpePathArcKind,
    wpeDirection,
    wpePathStage,
    wpeX0,
    wpeY0,
    wpeZ0,
    wpeX1,
    wpeY1,
    wpeZ1,
    wpedT,
    wpeNoDetP,
    wpeT,
    wpeP,
    wpeR,
    wpeB,
    wpeB0,
    wpeB1,
    wpeRejDetP,
    wpeNoFailureP,
    wpeNoEvidence,
    wpeOutsripProbabilityR
  );


const
  cnstConnectionTime=20; // время установления связи, сек
  ShoulderWidth=100;
  constShowDetectionZone=4440;
  constUseDetectionZone=4441;
  constRotationAngle=4442;
  constMaxDistance=4443;
  constGuardTacticFlag=4450;

resourcestring
  rsSPRUT            ='СПРУТ - ';
  rsSpatialModel     ='Схема объекта';
  rsFacilityModel    ='Модель системы охраны';
  rsSafeguardDatabase='База данных';
  rsFacility        ='Объект';
//  rsFacilityZone    ='Зона';
//  rsFacilityZone_Of ='зоны';
//  rsFacilityZones   ='Зоны';
  rsZone      ='Зона';
  rsZone_Of   ='зоны';
  rsZones     ='Зоны';
  rsBoundary    ='Рубеж';
  rsBoundaries  ='Рубежи';
  rsBoundary_Of ='рубежей';
  rsBoundaryLayer    ='Слой рубежа';
  rsBoundaryLayer2   ='Слой защиты';
  rsBoundaryLayer_Of ='слоя рубежа';
  rsBoundaryLayers   ='Слои рубежа';
  rsBoundaryLayers2  ='Слои защиты';
  rsBoundaryLayerState='Вариант состояния слоя рубежа';
  rsBoundaryLayerStates='Варианты состояния слоя рубежа';
  rsTactic     ='Тактика преодоления рубежа';
  rsAnalysisVariant    ='Вариант анализа';
  rsAnalysisVariant_Of ='варианта анализа';
  rsAnalysisVariants   ='Варианты анализа';
  rsElementState='Вариант состояния';
  rsElementStates='Варианты состояния';
  rsSafeguardElementState='Вариант состояния';
  rsSafeguardElementStates='Вариант состояния';   // из-за совместимости
  rsFacilityState    ='Состояние системы';
  rsFacilityState_Of ='состояния системы';
  rsFacilityStates   ='Состояния системы';
  rsFacilitySubState ='Вариант состояния элементов';
  rsFacilitySubStates ='Варианты состояния элементов';

  rsFacilityEnviroments ='Окрестности объекта';

  rsSafeguardElement='Средство охраны';
  rsSafeguardElement2='Элемент системы охраны';
  rsSafeguardElements='Средства охраны';
  rsSafeguardElements2='Элементы системы охраны';
  rsInnerZones      ='Внутренние зоны';
  rsZoneBoundaries      ='Рубежи';
  rsNeighborSector  ='в ближайших секторах';

  rsZoneCategoryError='Сектор %s'+#13+
                                    'не содержит категорию %s';

  rsFacilityBuildInParameter='Встроенный параметр модели';
  rsEffectiveZoneDistance='Эффективная протяженность зоны, м';
  rsZoneBottomHeight='Абсолютная высота нижнего рубежа, м';
  rsZoneTopRelativeHeight='Высота верхнего рубежа относительно нижней, м';
  rsBoundaryThickness='Ширина рубежа, м';
  rsGoalDefining='Целеуказующий рубеж';
  rsUserDefinedDelayTime='Время задержки задано пользователем';
  rsDelayTime='Время задержки, с';
  rsUserDefinedDetectionProbability='Вероятность обнаружения задана пользователем';
  rsDetectionProbability='Вероятность обнаружения';
  rsDetectionPosition='Позиция средства охраны';
  rsOuter='Внешняя';
  rsCentral='Центральная';
  rsInner='Внутренняя';
  rsBothSide='Двусторонняя';
  rsDisableDetection='Не учитывать средства обнаружения';
  rsUserDefinedFalseAlarmPeriod='Среднее время между ложными тревогами задано пользователем';
  rsFalseAlarmPeriod='Среднее время между ложными тревогами, ч';
  rsDisableFalseAlarm='Не учитывать ложные тревоги';

  rsAdversaryVariants='Варианты угрозы';
  rsGuardVariants='Варианты системы охраны';

  rsCreateZone='Создать зонy';
  rsCreateBoundary='Создать рубеж';
  rsCreateSafeguardElement='Создать средство защиты';
  rsCreateCabel='Создать линию связи';
  rsCreatePath='Создать маршрут';

  rsLinkWithZone='Связать с сектором зоны';
  rsLinkWithBoundary='Связать с рубежом';
  rsLinkWithSafeguardElement='Связать со средством защиты';
  rsLinkWithCabel='Связать с линией связи';
  rsLinkWithPatrolPath='Связать с маршрутом патрулирования';

  rsDeleteZoneLink='Удалить связь c зоной';
  rsDeleteBoundaryLink='Удалить связь с рубежом';
  rsDeleteSafeguardElementLink='Удалить связь со средством защиты';
  rsDeleteCabelLink='Удалить связь с линией связи';
  rsDeletePatrolPathLink='Удалить связь с маршрутом патрулирования';
  rsDeleteObject='Удалить';
  rsDivideZone='Разделить зону';

  rsChangeZone='Изменить тип зоны';
  rsChangeBoundary='Изменить тип рубежа';
  rsChangeSafeguardElement='Изменить тип средства защиты';

  rsOutputBuildInParameter='Параметр результата анализа';

  rsSystemEfficiency='Эффективность системы физической защиты';
  rsAdversarySuccessProbability='Вероятность успеха нарушителей';
  rsBattleSystemEfficiency='Эффективность СФЗ с учетом исхода боя';
  rsBattleAdversarySuccessProbability='Вероятность успеха нарушителей с учетом исхода боя';
  rsNeutralizationProbability='Вероятность нейтрализации нарушителя';
  rsInteruptionProbability='Вероятность своевременного перехвата нарушителя';
  rsGuardVictoryProbability='Вероятность победы охранников в бою';
  rsCriticalTime='Время от прохождения критической точки до завершения акции, с';
  rsPrice1='Стоимость дооснащения СФЗ, тыс руб';

  rsOvercomingBoundaries='Преодолеваемые рубежи';
  rsGuardPursuers='Преследующие группы';
  rsBoundarUnknowns='Неизвестно местоположение';
  rsGuardStarts='Группы на старт';
  rsNoIntercepts='Преодолеваемые рубежи в случае неудачного перехвата';
  rsCombatDefeats='Преодолеваемые рубежи в случае поражения в бою';
  rsInfostate='Состояние системы на данном рубеже';
  rsSumW='Накопленная сумма';
  rsProdNotU='Вероятность неперехвата';
  rsBattleProbability='Вероятность победы охраны в бою';
  rsBattleTime='Время боестолкновения';
  rsQProbability='Вероятность';
  rsResultProbability='Серьезная вероятность';

  rsUserDefinedTactic ='Тактика преодоления рубежа задается пользователем';
  rsBestTactic        ='Тактика преодоления рубежа';
  rsEqualHeight           ='Высота вдоль рубежа не изменяется';
  rsImageRotated           ='Перевернуть изображение';
  rsImageMirrored           ='Отразить изображение';
  rsBoundaryWarriorPathElements='Участки пересечения рубежа';
  rsBoundaryZone='Секторы, разделяемые рубежом';

  rsFacilityModelCatgories='Категории модели СФЗ';
  rsSafeguardModelCatgories='Категории модели средств охраны';
  rsGuardModelCatgories='Категории модели сил охраны';
  rsAdversaryModelCatgories='Категории модели нарушителя';
  rsSafeguardAnalysisCatgories='Категории выходных данных';
  rsSafeguardDatabaseCatgories='Категории базы данных';
  rsDrawElement='Изображение элемента';

  rsUnionInnerZones='Удалить вложенные области';
  rsWaySteps='Маршрут';
  rsOutputParameterValue='Значение выходного параметра';
  rsSafeguardElementParameterValue='Значение параметра элемента охраны';
  rsWarriorParameterValue='Значение параметра группы';
  rsWarriorParameterValue_Of='значения параметра группы';
  rsWarriorParameterValues='Значения параметра группы';

  rsZoneSuccessProbability='Вероятность успеха достижения цели из зоны';
  rsZoneDelayTimeToTarget='Время достижения цели из зоны, с';
  rsZoneNoDetectionProbabilityFromStart='Вероятность не обнаружения до зоны';
  rsBoundarySuccessProbability='Вероятность успеха достижения цели от рубежа';
  rsBoundaryDelayTimeToTarget='Время достижения цели от рубежа, с';
  rsBoundaryNoDetectionProbabilityFromStart='Вероятность не обнаружения до рубежа';
  rsWarriorPath='Маршрут движения';
  rsWarriorPaths='Маршруты движения';
  rsWarriorPathLines='Участки маршрута';
  rsBoundaryWarriorPaths='Оптимальные маршруты движения, проходящие через рубеж';
  rsWarriorGroup='Группа';
  rsGuardGroup='Подразделение охраны';
  rsPathDelayTime='Время движения по маршруту, с';
  rsReversed='Инвертировать';
  rsReorded='Упорядочить';
  rsAddTarget='Добавить ближайшую цель';
  rsAddBackPath='Добавить обратный маршрут';
  rsOptimised='Оптимизация';
  rsBaseLineGroup='Исходные линии';
  rsNot='Нет';
  rsAddMainTarget='Целевой объект';
  rsAddBattlePosition='Огневая позиция';
  rsPathNoDetectionProbability='Вероятность необнаружения на маршруте';
  rsPathSuccessProbability='Вероятность успеха на маршруте';
  rsPathRationalProbability='Вероятность успеха нарушителей';
  rsBackPathRationalProbability='Вероятность успеха при отходе от рубежа';
  rsResponceTimeRemainder='Запас/нехватка времени реагирования, с';
  rsGuardTacticFlag='Детальное моделирование тактики охраны';
  rsVBoundaries='Рубежи';
  rsHBoundaries='Верхние и нижние границы';
  rsJumps='Переходы между зонами';

  rsBarrier         ='Физический барьер';
  rsBarrierFixture  ='Крепление барьера';
  rsLock            ='Замок';

  rsSurfaceSensor   ='Поверхностный датчик';
  rsPositionSensor  ='Позиционный датчик';
  rsGuardPostZone        ='Контролируемая зона поста охраны';
  rsPatrolWarriorPathElementZone='Контролируемая зона участка маршрута патрулирования';
  rsVolumeSensorZone     ='Контролируемая зона объемного датчика';
  rsBarrierSensorZone    ='Контролируемая зона барьерного датчика';
  rsTVCameraZone         ='Контролируемая зона видеокамеры';
  rsLightDeviceZone      ='Освещаемая зона осветительного устройства';
  rsGuardPost            ='Пост охраны';
  rsPatrolWarriorPathElement    ='Участок маршрута патрулирования';
  rsVolumeSensor         ='Объемный датчик';
  rsBarrierSensor        ='Барьерный датчик';
  rsPerimeterSensor      ='Периметровый датчик';
  rsContrabandSensor     ='Обнаружение контрабанды';
  rsAccessControl        ='Контроль доступа';

  rsTVCamera             ='Телевизионная  камера';
  rsLightDevice          ='Осветительное устройство';
  rsPowerSource          ='Источник электропитания';
  rsCabel                ='Линия связи';
  rsTarget               ='Цель';
  rsConveyance           ='Маршрут транспортировки';
  rsConveyanceSegment    ='Участок маршрута транспортировки';
  rsLocalPointObject     ='Местный точечный объект';
  rsJump      ='Местный протяженный объект';
  rsStartPoint           ='Исходная позиция';
  rsDisposition          ='Место дислокации';
  rsTakeDefencePositionTime='Время занятия оборонительной позиции, с';
  rsBarriers         ='Физические барьеры';
  rsBarrierFixtures  ='Крепления барьеров';
  rsLocks            ='Замки';
  rsObstacles        ='Препятствия';

  rsSurfaceSensors  ='Поверхностные датчики';
  rsPositionSensors ='Позиционные датчики';
  rsGuardPostZones        ='Контролируемые зоны постов охраны';
  rsPatrolWarriorPathElementZones='Контролируемые зоны участков маршрутов патрулирования';
  rsVolumeSensorZones     ='Контролируемые зоны объемных датчиков';
  rsBarrierSensorZones    ='Контролируемые зоны барьерных датчиков';
  rsTVCameraZones         ='Контролируемые зоны видеокамер';
  rsLightDeviceZones      ='Освещаемые зоны осветительных устройств';
  rsGuardPosts            ='Посты охраны';
  rsPatrolWarriorPathElements    ='Участки маршрутов патрулирования';
  rsVolumeSensors         ='Объемные датчики';
  rsBarrierSensors        ='Барьерные датчики';
  rsPerimeterSensors      ='Периметровые датчики';
  rsContrabandSensors     ='Обнаружение контрабанды';
  rsAccessControls        ='Процедуры контроля доступа';

  rsTVCameras             ='Телевизионные  камеры';
  rsLightDevices          ='Осветительные устройства';
  rsPowerSources          ='Источники электропитания';
  rsCabels                ='Линии связи';
  rsAdditionalDevices     ='Вспомогательные устройства';
  rsAdditionalDevice      ='Вспомогательное устройство';
  rsTargets               ='Цели';
  rsConveyances           ='Маршруты транспортировки';
  rsConveyanceSegments    ='Участки маршрутов транспортировки';
  rsLocalPointObjects     ='Местные точечные объекты';

  rsDelayElement          ='Элемент здержки';
  rsDetectionElement      ='Элемент обнаружения';
  rsSecurityEquipment     ='Охранное оборудование';
  rsSecurityElement       ='Элемент системы охраны';
  rsLocalObject           ='Местный объект';

  rsPatrolPath            ='Маршрут патрулирования';
  rsPatrolPaths           ='Маршруты патрулирования';
  rsActiveSafeguard       ='Устройство активной защиты';
  rsSignalDevice          ='Сигнальное устройство';
  rsSignalDevices         ='Сигнальные устройства';
  rsActiveSafeguards      ='Устройства активной защиты';
  rsPostWarriorGroup      ='Подразделение, охраняющее пост';
  rsPostAlarmButton       ='Пост оборудован кнопкой тревожного вызова';
  rsDutyDistance          ='Протяженность контролируемого участка, м';

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
  rsDefenceLevel='Степень защищенности';
  rsOpenedDefenceState='Силуэт мишени при стрельбе';
  rsHidedDefenceState='Силуэт мишени в укрытии';
  rsNoDefence='Полноростовая фигура';
  rsRunning='Бегущая фигура';
  rsHalfHeightDefence='Поясная фигура';
  rsChestHeightDefence='Грудная фигура';
  rsHeadHeightDefence='Головная фигура';
  rsFullDefence='Не на линии огня';

  rsMotionSensor          ='Детектор движения';
  rsViewAngle             ='Угол поля зрения, град';
  rsIsSlewing             ='Поворотный механизм';
  rsSlewAngle             ='Полный угол обзора, град';

  rsVideoRecord           ='Функции видеонаблюдения';
  rsNoVideoRecord         ='Наблюдение без видеозаписи';
  rsSimpleVideoRecord     ='Ведется видеозапись';
  rsAlarmNoVideoRecord    ='Показ тревожного участка без мгновенного повтора';
  rsAlarmVideoRecord      ='Показ тревожного участка c мгновенным повтором';
  rsPreAlarmVideoRecord   ='Функция "предтревога"';

  rsLocalAlarmSignal          ='Местное оповещение';
  rsMainControlDevice         ='Управляющее устройство';
  rsSecondaryControlDevice    ='Резервное управляющее устройство';

  rsTechnicalServices         ='Техническое обслуживание ТСО';
  rsTechnicalService          ='Регламент технического обслуживания';

  rsAlarmSignalSafety                 ='Защищенность связи';
  rsAlarmSignalNoSafety               ='Линии связи и оборудование не защищены';
  rsAlarmSignalCabelSafety            ='Защищена только линия связи';
  rsAlarmSignalControlSafety          ='Защищено только оборудование';
  rsAlarmSignalCabelAndControlSafety  ='Защищены линии связи и оборудование';

  rsDeviceState0  ='Состояние средства охраны';
  rsDeviceState1  ='Состояние средства охраны при выходе';
  rsShowSymbol    ='Показывать изображение';
  rsSymbolScaleFactor    ='Масштабный множитель изображения';
  rsElevation          ='Высота установки, м';
  rsSignalLine         ='Шлейф';
  rsPowerLine          ='Кабель';
  rsBoundaryPath='Маршрут, проходящий черех рубеж';
  rsBoundaryPaths='Маршруты, проходящие черех рубеж';

    rsTool     ='Инструмент';
    rsWeapon   ='Оружие';
    rsVehicle  ='Транспортное средство';
    rsAthority ='Полномочие';
    rsSkill    ='Навык';
    rsGuardCharacteristic    ='Субъективная характеристика охраны';

    rsTools     ='Инструменты';
    rsWeapons   ='Вооружение';
    rsVehicles  ='Транспортные средства';
    rsAthorities='Полномочия';
    rsAdversaryAthorities='Полномочия сообщника';
    rsSkills    ='Специальные навыки';
    rsGuardCharacteristics    ='Субъективные характеристики охраны';

    rsGuardVariant2='Система охраны';
    rsGuardVariant='Вариант системы охраны';
    rsGuardGroups='Подразделения охраны';

  rsAdversaryVariant='Вариант угрозы';
  rsAdversaryGroup='Группа нарушителей';
  rsAdversaryGroups='Группы нарушителей';

  rsWarriorNumber='Количество человек в группе';
  rsWarriorStartPoint='Точка старта';
  rsWarriorTarget='Цель';
  rsWarriorLifeProbability='Вероятность выживания';
  rsUserDefinedResponceTime='Время реагирования определяется пользователем';
  rsResponceTime='Время реагирования, с';
  rsArrivalTime='Время прибытия, с';
  rsStartDelay='Время задержки начала развертывания, с';
  rsAdversaryTimeFromDetection='Время достижения цели после обнаружения, с';
  rsAdversaryTotalTime='Время достижения цели от начала движения, с';
  rsAdversaryDetectionProbability='Вероятность обнаружения';
  rsAdversaryLifeProbability='Вероятность выживания';
  rsTask='Задача группы';
  rsTargetDelayTime='Время работы с целью, с';
  rsTargetAccessRequired='Требуется непосредственный доступ к целевому предмету';
  rsUserDefinedTargetDelayDispersionRatio='Относительное СКО времени задержи задано пользователем';
  rsTargetDelayDispersionRatio='Относительное СКО времени задержи';
  rsTargetFieldValue='Уровень шума при работе с целью, дБ';
  rsGuardPath='Маршрут прибытия сил реагирования';
  rsGuardPaths='Маршруты прибытия сил реагирования';
  rsAdversaryPath='Маршрут проникновения нарушителей';
  rsAdversaryPaths='Маршруты проникновения нарушителей';
  rsAccesses='Зоны, в которые есть допуск';
  rsStrategyKinds='Доступные стратегии';
  rsElementSubStates='Зависимые элементы';

  rsSafeguardAnalysis='Анализ системы защиты';
    rsPathNode='Узел маршрута';
    rsWarriorPathNode='Узел маршрута';
    rsBoundaryWarriorPathElement='Участок преодоления рубежа';
    rsSectorWarriorPathElement='Путь пересечения зоны';
    rsWarriorPathElement='Элемент маршрута';
    rsWarriorPathElements='Маршрут';
    rsCriticalPointWaySteps='Маршрут, проходящий через точку';
    rsCriticalPoint='Критическая точка обнаружения';
    rsCriticalPoints='Критические точки обнаружения';
    rsWayStep='Элемент маршрута';

    rsBoundaryAreaError='Ошибка в описании области рубежа %s';
    rsNoPathFromStartToFinish='Невозможно пройти от %s до %s';

    rsCheckFacilityModel='Проверка корректности исходных данных';
    rsClearTree='Очистка графа маршрутов';
    rsBuildFacilityStates='Определение возможных состояний системы охраны';
    rsBuildGraph='Построение графа маршрутов';
    rsBuildGuardPaths='Оптимизация маршрута сил реагирования';
    rsBuildSupportGroupPaths='Оптимизация маршрута отвлекающей группы нарушителей';
    rsBuildAdvesaryStealthTree='Оптимизация скрытного участка маршрута нарушителей';
    rsBuildAdvesaryFastTree='Оптимизация маршрута прорыва нарушителей';
    rsBuildAdvesarySuccessTree='Полная оптимизация маршрута нарушителей';
    rsCalcVulnerability='Вычисление полей показателей уязвимости';
    rsCalcSystemEfficiency='Моделирование боя';
    rsDelayTimeToTarget='Время достижения цели от рубежа, с';
    rsNoDetectionProbabilityFromStart='Вероятность не обнаружения до рубежа';
    rsRationalProbabilityToTarget='Вероятность успеха достижения цели от рубежа';
    rsDelayTimeDispersion='Дисперсия времени задержки';
    rsFastPath='Наиболее быстрый маршрут от рубежа до цели';
    rsStealthPath='Наиболее скрытный маршрут извне до рубежа';
    rsOptimalPath='Оптимальный маршрут от рубежа до цели';
    rsVariantBoundaryWarriorPaths='Оптимальные маршруты от точки старта';
    rsStateIsCurrent='Состояние является текущим';
    rsGuardStrategy='Стратегия защиты';
    rsLargestZone='Охраняемая зона';
    rsWallLayer='Контуры стены';
    rsDoorLayer='Двери, ворота';
    rsWindowLayer='Окна';
    rsFenceLayer='Контуры ограждения';
    rsDummyLayer='Условные линии';
    rsInvisibleLayer='Скрытые линии';
    rsCabelLayer='Линии связи';
    rsAdversaryPathLayer='Заданные маршруты';
    rsPatrolPathLayer='Маршрут патрулирования';
    rsSafeguardLayer='Элементы системы охраны';
    rsBackgroundLayer='Фоновое изображение';
    rsExtraTargets='Промежуточные цели';
    rsFacilityStateModel='Состояния системы охраны';
    rsGuardModel='Система охраны';
    rsAdversaryModel='Модель нарушителей';
    rsMass='Масса, кг';
    rsMaxSize='Наибольший размер, м';
    rsMinSize='Наименьший размер, м';
    rsHasMetall='Активирует металлоискатель';
    rsRadiation='Излучение';
    rsSafeguardsAndTargets='Элементы системы охраны и цели, размещенные в зоне';
    rsSkillLevel='Уровень навыка';
    rsLowLevel='Низкий уровень';
    rsMediumLevel='Средний уровень';
    rsHighLevel='Высокий уровень';
    rsZoneCategory='Категория зоны';
    rsPersonalCount='Численность персонала, допущенного в зону';
    rsPersonalPresence='Присутствие персонала';
    rsPersonalNeverPresent='Персонал обычно отсутствует';
    rsPersonalMayPresent='Персонал иногда присутствует (чаще, чем 1 раз в час)';
    rsPersonalAlwaysPresent='Персонал присутствует постоянно (чаще, чем 1 раз за 10 мин)';
    rsTechnicalServicePeriod='Период между регламентными работами, сутки';
    rsTechnicalServiceControl='Порядок проведения техоблуживания';
    rsTechnicalServiceTesting='Проведение испытаний после техобслуживания';

    rsTechnicalServiceNoControl='Наблюдение не требуется';
    rsTechnicalServiceGuardControl='Под наблюдением охранника';
    rsTechnicalServiceSpecControl='Под наблюдением специалиста';
    rsTechnicalServiceNoTesting='Независимые испытания не проводятся';
    rsTechnicalServiceDoTesting='Проводятся независимые испытания';
    rsAlarmCabelSafety='Защищенность от вмешательства линий связи и оборудования';
    rsAlarmCabelNoSafety='Линии связи и оборудование не защищены от вмешательства';
    rsAlarmCabelOnlySafety='Только линии связи защищены от вмешательства';
    rsAlarmPanelOnlySafety='Только оборудование защищено от вмешательства';
    rsAlarmCabelAndPanelSafety='Линии связи и оборудование защищены от вмешательства';
    rsAlarmCabelGuard='Наблюдение за линиями связи и оборудованием';
    rsAlarmCabelNoGuardControl='Линии связи и оборудование не охраняются';
    rsAlarmCabelGuardControled='Линии связи и оборудование находятся пл наблюдением охраны';
    rsBattleSkill='Уровень боевых навыков';
    rsToolSkill='Уровень навыков преодоления барьеров';

    rsMainGroup='Выполнение основной задачи';
    rsSupportGroup='Огневое прикрытие';
    rsInsider='Сообщник из числа персонала';

    rsTakePosition='Занимает назначенную позицию';
    rsInterruptOnDetectionPoint='Перехват в точке обнаружения';
    rsPatrol='Патрулирование';
    rsStayOnPost='Стационарный пост';
    rsInterruptOnTarget='Перехват на подступах к цели';
    rsInterruptOnExit='Перехват на выходе с Объекта';


    rsStartCondition='Условие начала развертывания';
    rsAlarm='При любом сигнале тревоги';
    rsGoalDefiningPointPassed='При обнаружении на целеуказующем рубеже или подтверждении вторжения';
    rsIntrusionProved='При подтверждении вторжения';
    rsArmedIntrusionProved='При подтверждении вооруженного вторжения';

    rsPursuitKind='Условие продолжения преследования';
    rsNever='Никогда';
    rsAlways='Всегда';
    rsUntilGoalDefiningPoint='После целеуказующего рубежа';
    rsUntilObstacleAndStay='После труднопреодолимого рубежа перехватывает у цели';
    rsUntilObstacleAndTurn='Обходит труднопреодолимый рубеж';

    rsLabelVisible='Показывать название';
    rsLabelScaleMode='Масштабирование названия';
    rsFont='Шрифт названия';
    rsLabelNoScale='Фиксированный размер названия';
    rsLabelScale='Масштабировать название';
    rsRoad='Дорога';
    rsRoads='Дороги';
    rsRoadLayer='Контуры дорог';
    rsUserDefinedPaths='Маршруты, заданные пользователем';
    rsUserDefinedPath='Маршрут, заданный пользователем';
    rsCabelZone='Зона размещения аппаратуры и линий связи';
    rsAccess='Доступ в зоны';
    rsAccessType='Тип доступа';
    rsLimitedAccess='Доступ с сопровождающим';
    rsFullAccess='Полный доступ';
    rsAccessRegion='Область доступа';
    rsAllInnerZones='Включая все внутренние зоны';
    rsEqualInnerZones='Исключая внутренние зоны с более высокой категорией';
    rsAccessTimes='Время доступа';
    rsKeys='Замки, к которым есть ключи (коды)';
    rsControlDeviceAccess='Устройства управления, к которым есть доступ';
    rsGuardPostAccess='Посты охраны, контролируемые сообщником';
    rsPatrolPeriod='Средний интервал, ч';
    rsIrregular='Случайный';
    rsSensorDistance='Расстояние между чувствительными элементами, см';
    rsHeight='Высота, м';
    rsHeight0='Высота, м';
    rsHeight1='Высота, м на другом конце рубежа';
    rsDistanceFromPrev='Расстояние от предшествующего слоя, м';
    rsDrawJoint0='Рисовать стык 0';
    rsDrawJoint1='Рисовать стык 1';
    rsSensorDepth='Заглубление чувствительного элемента, м';
    rsFlowIntencity='Интенсивность движения';
    rsLow='Низкая';
    rsMedium='Средняя';
    rsHigh='Высокая';
    rsShowLayersMode='Изображение рубежа';
    rsBoundaryLayerConstruction='Конструкция';

    rsShowOnlyBoundaryLayers='Показывать только слои без контура';
    rsShowOnlyBoundaryArea='Показывать только контур рубежа';
    rsShowBoundaryAreaAndLayers='Показывать слои и контур рубежа';

    rsAlwaysAlarms='Тревожный сигнал подается при любом срабатывании';

    rsLockAccessControl='Открывается системой контроля доступа';
    rsKeyLock='Открывается механическим ключом';
    rsHandLock='Открывается вручную';
    rsUndergroundObstacle   ='Основание заграждения';
    rsGroundObstacle        ='Полоса заграждения';
    rsFenceObstacle         ='Препятствие по верху заграждения';
    rsWidth='Ширина, см';
    rsMinMineDepth='Минимальная глубина подкопа, м';
    rsTransparencyDist='Дальность прямой видимости, м';
    rsUserDefinedDelayTimeDispersionRatio='Относительное СКО времени задержи задается пользователем';
    rsDelayTimeDispersionRatio='Относительное СКО времени задержки при преодолении рубежей';
    rsZoneDelayTimeDispersionRatio='Относительное СКО времени задержки при движении';
    rsKeyStorage='Место хранения ключа(кода)';
    rsKeyInControledRoom='В контролируемом помещении';
    rsKeyAtPerson='Постоянно находится у уполномоченного лица';
    rsKeyInDefendedRoom='В защищенном месте';
    rsLockAccessibility='Доступность механизма запорного устройства';
    rsOuterLockAccessibility='Доступен снаружи';
    rsInnerLockAccessibility='Доступен изнутри';
    rsOuterInnerLockAccessibility='Доступен и снаружи, и изнутри';
    rsNoLockAccessibility='Недоступен';

    rsComment='Комментарий';
    rsUserDefinedVehicleVelocity='Скорость движения транспортных средств задается пользователем';
    rsVehicleVelocity='Скорость движения транспортных средств, км/ч';
    rsPedestrialVelocity='Скорость передвижения пешком, км/ч';

    rsZoneJumps='Элементы конструкции';
    rsBuildSectorLayer='Границы секторов';
    rsReliefLayer='Линии рельефа';
    rsVerticalBoundaryLayer='Вертикальные линии';
    rsWater='Водные рубежи';
    rsGuardPostWarriorPaths='Маршрут движения охраны';
    rsGuardPostControlDevices='Управляющие устройства';
    rsBoundaryState='Состояние рубежа';
    rsBoundaryStates='Состояния рубежа'; // из-за совместимости
    rsZoneState='Вариант состояния зоны';
    rsZoneStates='Варианты состояния зоны';
    rsZoneWidth='Ширина зоны обнаружения, м';
    rsZoneHalfWidth='Полуширина зоны обнаружения, м';

    rsShowOptimalPathFromBoundary='Оптимальный маршрут нарушителей от выделенного рубежа до цели';
    rsShowFastPathFromBoundary='Самый быстрый маршрут нарушителей от выделенного рубежа до цели';
    rsShowStealthPathToBoundary='Самый скрытный маршрут нарушителей от старта до выделенного рубежа';
    rsShowFastGuardPathToBoundary='Самый быстрый маршрут охраны';
    rsShowOptimalPathFromStart='Оптимальный марщрут нарушителей от старта до цели';
    rsShowGraph='Граф маршрутов';
    rsShowText='Надписи';
    rsShowSymbols='Пиктограммы средств охраны';
    rsShowWalls='Стены';
    rsShowDetectionZones='Зоны обнаружения';
    rsShowOnlyBoundaryAreas='Показывать только контуры рубежей';
    rsShowSingleLayer='Показывать все слои рубежей';
    rsUseBattleModel='Моделировать боевое столкновение';
    rsUseSimpleBattleModel='Упрощенная модель тактики охраны';
    rsCalcOptimalPathFlag='Рассчитывать оптимальные маршруты';
    rsCalcOptimalPathFromStartFlag='Рассчитывать оптимальный маршрут от точки старта для стратегии предотвращения';
    rsBuildAllVerticalWays='Моделировать все возможные вертикальные пути';
    rsDefaultReactionMode='Реагирование на сигнал тревоги';
    rsCriticalFalseAlarmPeriod='Критический период ложных тревог, ч';
    rsT='Время задержки на маршруте, с';
    rsP='Вероятность необнаружения на маршруте';
    rsR='Вероятность успеха';
    rsB='Вероятность успеха (от старта)';
    rsB0='Вероятность необнаружения от старта при оптимальной тактике';
    rsB1='Вероятность отмены тревоги от старта при оптимальной тактике';
    rsdT='Время задержки, с';
    rsNoDetP='Вероятность необнаружения';
    rsdR='Убыль вероятности успеха';
    rsdB='Убыль вероятности успеха (от старта)';
    rsWDelayTimeToTargetR='Время задержки до цели, с';
    rsWDelayTimeToTargetDispersionR='Дисперсия времени задержки до цели, с';
    rsOutsripProbabilityR='Вероятность успеть к цели раньше охраны';
    rsRejDetP='Вероятность отмены тревоги';
    rsNoFailureP='Вероятность отсутствия предварительного обнаружения';
    rsNoEvidence='Остаются улики';
    rsPathArcKind='Тип дуги графа маршрутов';
    rsPathStage='Этап маршрута';
    rsN='Порядковый номер';
    rsVBoundary='Пересечение рубежа по середине';
    rsHZone='Пересечение зоны';
    rsHLineObject='Прохождение линейного объекта';
    rsHBoundary='Пересечение горизонтального рубежа';
    rsVZone='Пересечение зоны по вертикали';
    rsVLineObject='Прохождение линейного объекта по вертикали';
    rsChangeFacilityState='Изменение состояния системы';
    rsChangeWarriorGroup='Подача сигнала на начало движения';
    rsVBoundary_='Пересечение рубежа';
    rsBoundary0='Рубеж 0';
    rsZone0='Сектор 0';
    rsBoundary1='Рубеж 1';
    rsZone1='Сектор 1';
    rsWidthM='Ширина, м';
    rsClimbUpVelocity='Скорость подъема, м/с';
    rsClimbDownVelocity='Скорость спуска, м/с';
    rsX0='X0, см';
    rsY0='Y0, см';
    rsZ0='Z0, см';
    rsX1='X1, см';
    rsY1='Y1, см';
    rsZ1='Z1, см';
    rsDirection='Направление';
    rsDeviceCount='Количество';
    rsPresence='Наличие';
    rsRenderAreasMode='Режим закраски плоскостей';
    rsInstallCoeff='Коэф cложности монтажных работ';
    rsModificationStage='Этап модернизации';
    rsInputConnections='Входящие подключения';
    rsOutputConnections='Исходящие подключения';
    rsConnections='Подключения';
    rsConnection='Подключение';
    rsConnection2='Элемент управления';
    rsControlDevice='Устройство обработки информации';
    rsControlDevices='Устройства обработки информации';
    rsControlDevice2='Устройство управления (коммутации)';
    rsControlDevices2='Устройства управления и коммутации';
    rsUserDefinedResponceTimeDispersionRatio='Относительное СКО времени реагирования задано пользователем';
    rsResponceTimeDispersionRatio='Относительное СКО времени реагирования';
    rsCurrencyRate='Курс у е ';
    rsPriceCoeffD='Коэффициент стоимости разработки документации';
    rsPriceCoeffTZSR='Коэффициент стоимости экспедиторских работ';
    rsPriceCoeffPNR='Коэффициент стоимости пуско-наладочных работ';
    rsFMRecomendation='Рекомендации';
    rsCPInterruptionProbability='Вероятность перехвата';
    rsCPDelayTimeToTarget='Время задержки до цели';
    rsCPDetectionPotential='Потенциал обнаружения';
    rsCPTimeRemainder='Запас времени, оставшийся у сил реагирования после перехвата';
    rsVariantWeight='Весовой коэффициент';
    rsTotalEfficiencyCalcMode='Режим обобщенной оценки эффективности';
    rsMaxPathCount='Максимальное число рассчитываемых маршрутов';
    rsGraphColor='Цвет линий графа';
    rsFastPathColor='Цвет линий быстрого маршрута';
    rsStealthPathColor='Цвет линий скрытного маршрута';
    rsRationalPathColor='Цвет линий рационального маршрута';
    rsGuardPathColor='Цвет линий маршрута охраны';
    rsMaxBoundaryDistance='Максимальное расстояние между точками пересечения рубежа, см';
    rsMaxPathAlongBoundaryDistance='Максимальная длина рубежа с одной точкой пересечения, см';
    rsPathHeight='Высота дуг графа над уровнем пола, см';
    rsShoulderWidth='Интервал объединения близлежащих узлов графа, см';
    rsBottomEdgeHeight='Высота нижнего края от уровня пола, см';

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

  rsMakePersistant='Запоминание варианта рекомендаций';
  rsEquipmentRecomendation='Рекомендации по оснащению';
  rsCount='Количество';

  rsDefaultVolumeHeight='Высота закрытых зон по умолчанию, м';
  rsDefaultVerticalAreaWidth='Ширина проемов по умолчанию, м';
  rsDefaultObjectWidth='Ширина пролетов по умолчанию, м';

  rsDefaultOpenZoneHeight='Высота открытых зон по умолчанию, м';

  rsGuardArrival='Прибытие сил охраны';
  rsArrivalTime0='Время прибытия (к внутренней стороне), с';
  rsArrivalTime1='Время прибытия (к внешней стороне), с';
  rsUserDefinedArrivalTime='Способ задания';
  rsCalculatedFromStart='Рассчитано (от точки дислокации)';
  rsUserDefinedFromStart='Явно задано (от точки дислокации)';
  rsCalculatedFromPrev='Рассчитано (от предыдущего участка машрута)';
  rsUserDefinedFromPrev='Явно задано (от предыдущего участка машрута)';
  rsUserDefinedWorkProbability='Вероятность работоспособности задана пользователем';
  rsWorkProbability='Вероятность работоспособности';
  rsDisabled='Исключить из анализа';
  rsElementParameterValue='Значение параметра элемента модели';
  rsElementParameterValues='Значения параметров элементов модели';
  rsDependentDevices='Зависимые устройства';
  rsMainControlDevices='Управление системой охраны';
  rsCommunicationDevice='Средство связи';
  rsCommunicationDevices='Средства связи';

  rsConnectionTime='Время задержки вызова, с';
  rsSecret='Шифрованная связь';
  
  rsLimitedControlDeviceAccess='Имеет доступ в помещение';
  rsFullControlDeviceAccess='Может работать с устройством';
  rsLimitedGuardPostAccess='Стоит на посту';
  rsFullGuardPostAccess='Может приказывать';

  rsSubBoundary='Подрубеж';
  rsSubBoundaries='Подрубежи';

  rsGuardMan='Охранник';
  rsOperator='Оператор';
  rsResponceGroup='Группа реагирования';
  rsDog='Собака';
  rsControlMan='Контролер';
  rsSymbolDX='Смещение изображения по X, cм';
  rsSymbolDY='Смещение изображения по Y, cм';
  rsShowDetectionZone='Показывать диаграмму направленности';
  rsUseDetectionZone='Учитывать диаграмму направленности';
  rsRotationAngle='Угол поворота, град';
  rsMaxDistance='Дальность действия, м';
  rsUseAlways='Применение';
  rsObserver='Наблюдатель';
  rsObservers='Наблюдатели';
  rsObservationKind='Вид наблюдения';
  rsObservationDistance='Расстояние, м';
  rsObservationSide='Направление';
  rsUserDefinedArrivalTime1='Время прибытия задается явно';
  rsUserDefinedBattleResult='Результаты боя задаются явно';
  rsDefenceBattleP='Вероятность победы подразделения охраны в оборонительном бою';
  rsAttackBattleP='Вероятность победы подразделения охраны в наступательном бою';
  rsDefenceBattleT='Длительность оборонительного боя до поражения подразделения охраны, с';
  rsAttackBattleT='Длительность наступательного боя до поражения подразделения охраны, с';
  rsGuardGroupState='Вариант состояния подразделения охраны';
  rsGuardGroupStates='Варианты состояния подразделения охраны';
implementation

end.

