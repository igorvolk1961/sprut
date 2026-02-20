object fmDMMainCompare: TfmDMMainCompare
  Left = 199
  Top = 218
  Width = 768
  Height = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btCloseDocument: TSpeedButton
    Left = 508
    Top = -25
    Width = 15
    Height = 15
    Glyph.Data = {
      F6040000424DF60400000000000036040000280000000E0000000C0000000100
      080000000000C0000000C40E0000C40E00000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00A4A4A4A4A4A4
      A4A4A4A4A4A4A4A4000007070707070707070707070707A40000070707070707
      07070707070707A4000007070700000707070700000707A40000070707070000
      07070000070707A4000007070707070000000007070707A40000070707070707
      00000707070707A4000007070707070000000007070707A40000070707070000
      07070000070707A4000007070700000707070700000707A40000070707070707
      07070707070707A4000007070707070707070707070707A40000}
  end
  object MainMenu1: TMainMenu
    Left = 457
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object miNew: TMenuItem
        Caption = #1053#1086#1074#1099#1081' '#1092#1072#1081#1083
        GroupIndex = 1
        OnClick = miNewClick
      end
      object miOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        GroupIndex = 1
        ShortCut = 16463
        OnClick = miOpenClick
      end
      object miOpenLast: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1080#1079' '#1095#1080#1089#1083#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1093'...'
        GroupIndex = 1
        object TMenuItem
        end
      end
      object N14: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object miSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        GroupIndex = 1
        ShortCut = 16467
        OnClick = miSaveClick
      end
      object miSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        GroupIndex = 1
        OnClick = miSaveAsClick
      end
      object N7: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object miImportVector: TMenuItem
        Caption = #1048#1084#1087#1086#1088#1090' '#1074#1077#1082#1090#1086#1088#1085#1086#1075#1086' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103'...'
        GroupIndex = 1
        OnClick = miImportVectorClick
      end
      object miImportRaster: TMenuItem
        Caption = #1048#1084#1087#1086#1088#1090' '#1088#1072#1089#1090#1088#1086#1074#1086#1075#1086' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103'...'
        GroupIndex = 1
        OnClick = miImportRasterClick
      end
      object N2: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object N13: TMenuItem
        Caption = #1047#1072#1097#1080#1090#1072
        GroupIndex = 1
        object miPasswordRequired: TMenuItem
          AutoCheck = True
          Caption = #1047#1072#1087#1088#1072#1096#1080#1074#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
          RadioItem = True
          OnClick = miPasswordRequiredClick
        end
        object miChangePassword: TMenuItem
          Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103'...'
          OnClick = miChangePasswordClick
        end
      end
      object N16: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object miPrint: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100'...'
        GroupIndex = 1
        OnClick = miPrintClick
      end
      object N6: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object miClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
        GroupIndex = 1
        ShortCut = 16499
        OnClick = miCloseClick
      end
      object miExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        GroupIndex = 1
        ShortCut = 32883
        OnClick = miExitClick
      end
    end
    object N3: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      object mUndo: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
        ShortCut = 32776
        OnClick = mUndoClick
      end
      object miRedo: TMenuItem
        Caption = #1042#1077#1088#1085#1091#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
        OnClick = miRedoClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miCopy: TMenuItem
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
        ShortCut = 16451
        OnClick = miCopyClick
      end
      object miPaste: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100
        ShortCut = 16470
        OnClick = miPasteClick
      end
      object miDelete: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        OnClick = miDeleteClick
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object N9: TMenuItem
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100
        object miSelect: TMenuItem
          Caption = #1042#1099#1076#1077#1083#1077#1085#1080#1077
          GroupIndex = 100
          RadioItem = True
          OnClick = miActionClick
        end
        object miSelectNode: TMenuItem
          Caption = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1090#1086#1095#1077#1095#1085#1099#1093' '#1086#1073#1098#1077#1082#1090#1086#1074
          GroupIndex = 100
          RadioItem = True
          OnClick = miActionClick
        end
        object miSelectLine: TMenuItem
          Caption = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1083#1080#1085#1080#1081'/'#1088#1091#1073#1077#1078#1077#1081
          GroupIndex = 100
          RadioItem = True
          OnClick = miActionClick
        end
        object miSelectVolume: TMenuItem
          Caption = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1079#1086#1085
          GroupIndex = 100
          RadioItem = True
          OnClick = miActionClick
        end
        object miSelectLabel: TMenuItem
          Caption = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1084#1077#1090#1082#1080
          GroupIndex = 100
          RadioItem = True
          OnClick = miActionClick
        end
      end
      object miUndoSelection: TMenuItem
        Caption = #1042#1077#1088#1085#1091#1090#1100' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1077' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
        OnClick = miUndoSelectionClick
      end
      object miSelectAllNodes: TMenuItem
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077' '#1091#1079#1083#1099
        OnClick = miSelectAllNodesClick
      end
      object N15: TMenuItem
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1077' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
        object miSelectTopEdges: TMenuItem
          Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1077#1088#1093#1085#1080#1077' '#1082#1088#1072#1103' '#1088#1091#1073#1077#1078#1077#1081
          OnClick = miSelectTopEdgesClick
        end
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object miFind: TMenuItem
        Caption = #1055#1086#1080#1089#1082'...'
        ShortCut = 16454
        OnClick = miFindClick
      end
    end
    object miView: TMenuItem
      Caption = #1042#1080#1076
      GroupIndex = 1
      object N5: TMenuItem
        Caption = '-'
        GroupIndex = 3
      end
      object miOutlookPanel: TMenuItem
        AutoCheck = True
        Caption = #1055#1072#1085#1077#1083#1100' Outlook'
        Checked = True
        GroupIndex = 3
        OnClick = miOutlookPanelClick
      end
      object miDuplicateActiveForm: TMenuItem
        Caption = #1044#1091#1073#1083#1080#1088#1086#1074#1072#1090#1100' '#1086#1082#1085#1086
        GroupIndex = 3
        OnClick = miDuplicateActiveFormClick
      end
      object N12: TMenuItem
        Caption = '-'
        GroupIndex = 3
      end
      object N42: TMenuItem
        Caption = #1052#1072#1089#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1077' '#1080' '#1087#1077#1088#1077#1090#1072#1089#1082#1080#1074#1072#1085#1080#1077
        GroupIndex = 3
        object miZoomIn: TMenuItem
          Caption = #1059#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1084#1072#1089#1096#1090#1072#1073#1072
          GroupIndex = 101
          RadioItem = True
          OnClick = miActionClick
        end
        object miZoomOut: TMenuItem
          Caption = #1059#1084#1077#1085#1100#1096#1077#1085#1080#1077' '#1084#1072#1089#1096#1090#1072#1073#1072
          GroupIndex = 101
          RadioItem = True
          OnClick = miActionClick
        end
        object miViewPan: TMenuItem
          Caption = #1055#1077#1088#1077#1090#1072#1089#1082#1080#1074#1072#1085#1080#1077
          GroupIndex = 101
          RadioItem = True
          OnClick = miActionClick
        end
        object miZoomSelection: TMenuItem
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1086#1073#1098#1077#1082#1090#1099
          GroupIndex = 101
          RadioItem = True
          OnClick = miActionClick
        end
        object miLastView: TMenuItem
          Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103' '#1082' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1084#1091' '#1074#1080#1076#1091
          GroupIndex = 101
          OnClick = miActionClick
        end
      end
      object N10: TMenuItem
        Caption = '-'
        GroupIndex = 3
      end
      object miRedraw: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
        GroupIndex = 3
        OnClick = miActionClick
      end
      object N43: TMenuItem
        Caption = '-'
        GroupIndex = 3
        OnClick = miActionClick
      end
      object miSideView: TMenuItem
        AutoCheck = True
        Caption = #1060#1088#1086#1085#1090#1072#1083#1100#1085#1099#1081' '#1074#1080#1076
        Checked = True
        GroupIndex = 3
        OnClick = miActionClick
      end
      object miPalette: TMenuItem
        AutoCheck = True
        Caption = #1055#1072#1085#1077#1083#1100' '#1079#1072#1082#1083#1072#1076#1086#1082
        Checked = True
        GroupIndex = 3
        OnClick = miActionClick
      end
    end
    object miModel: TMenuItem
      Caption = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
      GroupIndex = 1
      object N25: TMenuItem
        Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077
        object miCreateLine: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1083#1080#1085#1080#1081
          GroupIndex = 102
          RadioItem = True
          OnClick = miActionClick
        end
        object miCreatePolyline: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1083#1086#1084#1072#1085#1099#1093
          GroupIndex = 102
          RadioItem = True
          OnClick = miActionClick
        end
        object miCreateClosedPolyline: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1084#1085#1086#1075#1086#1091#1075#1086#1083#1100#1085#1080#1082#1086#1074
          GroupIndex = 102
          RadioItem = True
          OnClick = miActionClick
        end
        object miCreateRectangle: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1087#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082#1086#1074
          GroupIndex = 102
          RadioItem = True
          OnClick = miActionClick
        end
        object miCreateInclinedRectangle: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1087#1086#1074#1077#1088#1085#1091#1090#1099#1093' '#1087#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082#1086#1074
          GroupIndex = 102
          RadioItem = True
          OnClick = miActionClick
        end
        object miCreateCurvedLine: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1082#1088#1080#1074#1099#1093' '#1083#1080#1085#1080#1081
          GroupIndex = 102
        end
        object miCreateEllipse: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1101#1083#1083#1080#1087#1089#1086#1074
          GroupIndex = 102
        end
        object miBreakLine: TMenuItem
          Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1091#1079#1083#1086#1074
          GroupIndex = 102
        end
      end
      object N27: TMenuItem
        Caption = #1058#1088#1072#1085#1089#1092#1086#1088#1084#1072#1094#1080#1103
        object miMoveSelected: TMenuItem
          Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
          GroupIndex = 103
          RadioItem = True
          OnClick = miActionClick
        end
        object miRotateSelected: TMenuItem
          Caption = #1055#1086#1074#1086#1088#1086#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
          GroupIndex = 103
          RadioItem = True
          OnClick = miActionClick
        end
        object miScaleSelected: TMenuItem
          Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1088#1072#1079#1084#1077#1088#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
          GroupIndex = 103
          RadioItem = True
          OnClick = miActionClick
        end
        object miTrimExtendToSelected: TMenuItem
          Caption = #1055#1088#1086#1076#1083#1077#1085#1080#1077'/'#1091#1089#1077#1095#1077#1085#1080#1077'  '#1076#1086' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1083#1080#1085#1080#1081
          GroupIndex = 103
          RadioItem = True
          OnClick = miActionClick
        end
        object miIntersectSelected: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1091#1079#1083#1086#1074' '#1074' '#1090#1086#1095#1082#1072#1093' '#1087#1077#1088#1077#1089#1077#1095#1077#1085#1080#1103' '#1083#1080#1085#1080#1081
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
        object miOutlineSelected: TMenuItem
          Caption = #1059#1076#1074#1086#1077#1085#1080#1077' '#1082#1086#1085#1090#1091#1088#1072'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
        object miBuildRelief: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1088#1077#1083#1100#1077#1092#1072' '#1084#1077#1089#1090#1085#1086#1089#1090#1080'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
      end
      object N29: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1084#1086#1076#1077#1083#1080
        object miBuildVolume: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1079#1086#1085'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
        object miBuildDoor: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1087#1088#1086#1077#1084#1086#1074'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
        object miDivideVolumeByVertical: TMenuItem
          Caption = #1044#1077#1083#1077#1085#1080#1077' '#1079#1086#1085#1099' '#1087#1086' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1080'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
        object miDivideVolumeByHorizontal: TMenuItem
          Caption = #1044#1077#1083#1077#1085#1080#1077' '#1079#1086#1085#1099' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
        object miBuildJumps: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1087#1077#1088#1077#1093#1086#1076#1086#1074' '#1084#1077#1078#1076#1091' '#1079#1086#1085#1072#1084#1080'...'
          GroupIndex = 104
          OnClick = miActionClick
        end
        object miBuildArrayObject: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1079#1086#1085' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103'/'#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1103'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
        object miBuildCoordNode: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1094#1077#1083#1077#1081' '#1080' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1089#1080#1089#1090#1077#1084#1099' '#1086#1093#1088#1072#1085#1099'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
        object miBuildPolylineObject: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1087#1088#1086#1090#1103#1078#1077#1085#1085#1099#1093' '#1086#1073#1098#1077#1082#1090#1086#1074'...'
          GroupIndex = 104
          RadioItem = True
          OnClick = miActionClick
        end
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object miSnap: TMenuItem
        Caption = #1055#1088#1080#1074#1103#1079#1082#1072
        object miSnapNone: TMenuItem
          Caption = #1054#1090#1084#1077#1085#1072' '#1087#1088#1080#1074#1103#1079#1086#1082
          GroupIndex = 105
          RadioItem = True
          OnClick = miActionClick
        end
        object miSnapOrtToLine: TMenuItem
          Caption = #1055#1088#1080#1074#1103#1079#1082#1072' '#1087#1086' '#1087#1077#1088#1087#1077#1085#1076#1080#1082#1091#1083#1103#1088#1091' '#1082' '#1086#1090#1088#1077#1079#1082#1091
          GroupIndex = 105
          RadioItem = True
          OnClick = miActionClick
        end
        object miSnapToNearestOnLine: TMenuItem
          Caption = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1073#1083#1080#1078#1072#1081#1096#1077#1081' '#1090#1086#1095#1082#1077' '#1086#1090#1088#1077#1079#1082#1072
          GroupIndex = 105
          RadioItem = True
          OnClick = miActionClick
        end
        object miSnapToMiddleOfLine: TMenuItem
          Caption = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1089#1077#1088#1077#1076#1080#1085#1077' '#1086#1090#1088#1077#1079#1082#1072
          GroupIndex = 105
          RadioItem = True
          OnClick = miActionClick
        end
        object miSnapToLocalGrid: TMenuItem
          Caption = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1084#1077#1089#1090#1085#1086#1081' '#1089#1077#1090#1082#1077
          GroupIndex = 105
          RadioItem = True
          OnClick = miActionClick
        end
        object miSnapToNode: TMenuItem
          Caption = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1073#1083#1080#1078#1072#1081#1096#1077#1084#1091' '#1091#1079#1083#1091
          GroupIndex = 105
          RadioItem = True
          OnClick = miActionClick
        end
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object miErrors: TMenuItem
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1082#1086#1088#1088#1077#1082#1090#1085#1086#1089#1090#1100' '#1084#1086#1076#1077#1083#1080'...'
        GroupIndex = 103
        OnClick = miErrorsClick
      end
    end
    object miHelp: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      GroupIndex = 1
      object N18: TMenuItem
        Caption = #1042#1099#1079#1086#1074' '#1089#1087#1088#1072#1074#1082#1080
        ShortCut = 112
        OnClick = N18Click
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object N20: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
        OnClick = N20Click
      end
    end
    object Demo1: TMenuItem
      Caption = #1044#1077#1084#1086
      GroupIndex = 1
      Visible = False
      object SaveTransactions1: TMenuItem
        Caption = 'SaveTransactions'
        ShortCut = 49235
        Visible = False
        OnClick = SaveTransactions1Click
      end
      object LoadTransactions1: TMenuItem
        Caption = 'LoadTransactions'
        ShortCut = 49231
        Visible = False
        OnClick = LoadTransactions1Click
      end
      object miWriteMacros: TMenuItem
        Caption = #1047#1072#1087#1080#1089#1100' '#1084#1072#1082#1088#1086#1089#1072
        ShortCut = 123
        Visible = False
      end
      object miLoadMacros: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1084#1072#1082#1088#1086#1089#1072
        ShortCut = 122
        Visible = False
      end
      object miPlayMacros: TMenuItem
        Caption = #1048#1089#1087#1086#1083#1085#1077#1085#1080#1077' '#1084#1072#1082#1088#1086#1089#1072
        ShortCut = 32845
        Visible = False
      end
      object miWriteMacrosLabel: TMenuItem
        Caption = #1047#1072#1087#1080#1089#1100' '#1084#1077#1090#1082#1080
        ShortCut = 32891
      end
    end
  end
  object ImageList1: TImageList
    Left = 376
    Top = 24
  end
  object OpenTransDialog: TOpenDialog
    DefaultExt = 'sav'
    Filter = #1057#1094#1077#1085#1072#1088#1080#1081' (*.sav)|*.sav'
    Left = 232
    Top = 32
  end
  object SaveTransDialog: TSaveDialog
    DefaultExt = 'sav'
    Filter = #1057#1094#1077#1085#1072#1088#1080#1081' (*.sav)|*.sav'
    Left = 232
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 88
    Top = 8
  end
  object System: TDdeServerConv
    OnExecuteMacro = SystemExecuteMacro
    Left = 136
    Top = 152
  end
  object DdeServerItem1: TDdeServerItem
    ServerConv = System
    Left = 181
    Top = 151
  end
  object OpenMacrosDialog: TOpenDialog
    Left = 264
    Top = 32
  end
  object ExportDialog: TSaveDialog
    Filter = 'Microsoft Visio (*.vsd)|*.vsd|AutoCad DXF (*.dxf)|*.dxf'
    Left = 152
    Top = 24
  end
end
