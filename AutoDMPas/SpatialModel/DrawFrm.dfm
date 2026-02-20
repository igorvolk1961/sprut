object fmDraw: TfmDraw
  Left = 0
  Top = 116
  Width = 801
  Height = 364
  Caption = 'fmDraw'
  Color = clBtnFace
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 793
    Height = 64
    Align = alTop
    AutoSize = True
    RowSnap = False
    TabOrder = 0
    OnDockOver = ControlBar1DockOver
    object ToolBarAttachMode: TToolBar
      Left = 650
      Top = 2
      Width = 135
      Height = 26
      AutoSize = True
      Caption = 'ToolBarAttachMode'
      DragKind = dkDock
      Images = ImageList1
      TabOrder = 0
      object btAttachModeNone: TToolButton
        Tag = 1
        Left = 0
        Top = 2
        Hint = #1054#1090#1084#1077#1085#1072' '#1087#1088#1080#1074#1103#1079#1086#1082
        Caption = 'btAttachModeNone'
        Down = True
        Grouped = True
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonAttachClick
      end
      object ToolButton11: TToolButton
        Tag = 2
        Left = 23
        Top = 2
        Hint = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1073#1083#1080#1078#1072#1081#1096#1077#1084#1091' '#1082#1086#1085#1094#1091' '#1083#1080#1085#1080#1080
        Caption = 'ToolButton11'
        Grouped = True
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonAttachClick
      end
      object ToolButton12: TToolButton
        Tag = 3
        Left = 46
        Top = 2
        Hint = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1073#1083#1080#1078#1072#1081#1096#1077#1081' '#1083#1080#1085#1080#1080
        Caption = 'ToolButton12'
        Grouped = True
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonAttachClick
      end
      object ToolButton13: TToolButton
        Tag = 4
        Left = 69
        Top = 2
        Hint = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1089#1077#1088#1077#1076#1080#1085#1077' '#1086#1090#1088#1077#1079#1082#1072
        Caption = 'ToolButton13'
        Grouped = True
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonAttachClick
      end
      object ToolButton9: TToolButton
        Tag = 5
        Left = 92
        Top = 2
        Hint = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1086#1089#1085#1086#1074#1072#1085#1080#1102' '#1087#1077#1088#1087#1077#1085#1076#1080#1082#1091#1083#1103#1088#1072
        Caption = 'ToolButton9'
        Grouped = True
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonAttachClick
      end
    end
    object ToolBarOperations: TToolBar
      Left = 11
      Top = 2
      Width = 626
      Height = 26
      AutoSize = True
      DragKind = dkDock
      Images = ImageList1
      TabOrder = 1
      object ToolButton47: TToolButton
        Tag = 1
        Left = 0
        Top = 2
        Hint = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
        Caption = 'ToolButton47'
        ImageIndex = 30
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonOptionsClick
      end
      object ToolButton48: TToolButton
        Left = 23
        Top = 2
        Width = 8
        Caption = 'ToolButton48'
        ImageIndex = 19
        Style = tbsSeparator
      end
      object btUp: TToolButton
        Tag = 5
        Left = 31
        Top = 2
        Hint = #1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1087#1088#1086#1089#1090#1088#1072#1085#1089#1090#1074#1072
        Caption = 'btUp'
        Down = True
        Grouped = True
        ImageIndex = 44
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOptionsClick
      end
      object btDown: TToolButton
        Tag = 6
        Left = 54
        Top = 2
        Hint = #1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1087#1088#1086#1089#1090#1088#1072#1085#1089#1090#1074#1072
        Caption = 'btDown'
        Grouped = True
        ImageIndex = 43
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOptionsClick
      end
      object ToolButton29: TToolButton
        Left = 77
        Top = 2
        Width = 8
        Caption = 'ToolButton29'
        ImageIndex = 46
        Style = tbsSeparator
      end
      object ToolButton42: TToolButton
        Tag = 1
        Left = 85
        Top = 2
        Hint = #1054#1090#1084#1077#1085#1072' '#1074#1099#1076#1077#1083#1077#1085#1080#1103
        Caption = 'ToolButton42'
        ImageIndex = 29
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton27: TToolButton
        Left = 108
        Top = 2
        Width = 8
        Caption = 'ToolButton27'
        ImageIndex = 46
        Style = tbsSeparator
      end
      object ToolButton8: TToolButton
        Tag = 4
        Left = 116
        Top = 2
        Hint = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1091#1079#1083#1086#1074
        Caption = 'ToolButton8'
        Grouped = True
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton4: TToolButton
        Tag = 2
        Left = 139
        Top = 2
        Hint = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1083#1080#1085#1080#1081
        Caption = 'ToolButton4'
        Grouped = True
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton7: TToolButton
        Tag = 3
        Left = 162
        Top = 2
        Hint = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
        Caption = 'ToolButton7'
        Grouped = True
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton35: TToolButton
        Tag = 30
        Left = 185
        Top = 2
        Hint = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
        Caption = 'ToolButton35'
        Grouped = True
        ImageIndex = 41
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object btSelectVolume: TToolButton
        Tag = 31
        Left = 208
        Top = 2
        Hint = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1086#1073#1098#1077#1084#1085#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
        Caption = 'btSelectVolume'
        Grouped = True
        ImageIndex = 42
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton37: TToolButton
        Left = 231
        Top = 2
        Width = 8
        Caption = 'ToolButton37'
        Grouped = True
        ImageIndex = 19
        Style = tbsSeparator
      end
      object ToolButton2: TToolButton
        Tag = 5
        Left = 239
        Top = 2
        Hint = #1056#1080#1089#1086#1074#1072#1085#1080#1077' '#1086#1090#1088#1077#1079#1082#1086#1074' '#1083#1080#1085#1080#1081
        Caption = 'ToolButton2'
        Grouped = True
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton1: TToolButton
        Tag = 6
        Left = 262
        Top = 2
        Hint = #1056#1080#1089#1086#1074#1072#1085#1080#1077' '#1083#1086#1084#1072#1085#1099#1093' '#1083#1080#1085#1080#1081
        Caption = 'ToolButton1'
        Grouped = True
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object btPolygon: TToolButton
        Tag = 7
        Left = 285
        Top = 2
        Hint = #1056#1080#1089#1086#1074#1072#1085#1080#1077' '#1084#1085#1086#1075#1086#1091#1075#1086#1083#1100#1085#1080#1082#1086#1074
        Caption = 'btPolygon'
        Grouped = True
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object btRectangle: TToolButton
        Tag = 8
        Left = 308
        Top = 2
        Hint = #1056#1080#1089#1086#1074#1072#1085#1080#1077' '#1087#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082#1086#1074
        Caption = 'btRectangle'
        Grouped = True
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton22: TToolButton
        Tag = 9
        Left = 331
        Top = 2
        Hint = #1056#1080#1089#1086#1074#1072#1085#1080#1077' '#1076#1091#1075
        Caption = 'ToolButton22'
        Grouped = True
        ImageIndex = 35
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton30: TToolButton
        Tag = 10
        Left = 354
        Top = 2
        Hint = #1056#1080#1089#1086#1074#1072#1085#1080#1077' '#1101#1083#1083#1080#1087#1089#1086#1074
        Caption = 'ToolButton30'
        Grouped = True
        ImageIndex = 36
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton31: TToolButton
        Tag = 11
        Left = 377
        Top = 2
        Hint = #1056#1080#1089#1086#1074#1072#1085#1080#1077' '#1090#1086#1095#1077#1095#1085#1099#1093' '#1086#1073#1098#1077#1082#1090#1086#1074
        Caption = 'ToolButton31'
        Grouped = True
        ImageIndex = 37
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object btImage: TToolButton
        Tag = 32
        Left = 400
        Top = 2
        Hint = #1074#1089#1090#1072#1074#1082#1072' '#1088#1072#1089#1090#1088#1086#1074#1086#1075#1086' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
        Caption = 'btImage'
        Grouped = True
        ImageIndex = 45
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton38: TToolButton
        Left = 423
        Top = 2
        Width = 8
        Caption = 'ToolButton38'
        Grouped = True
        ImageIndex = 19
        Style = tbsSeparator
      end
      object ToolButton10: TToolButton
        Tag = 12
        Left = 431
        Top = 2
        Hint = #1059#1076#1072#1083#1077#1085#1080#1077' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1086#1073#1098#1077#1082#1090#1086#1074
        Caption = 'ToolButton10'
        Grouped = True
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton14: TToolButton
        Tag = 14
        Left = 454
        Top = 2
        Hint = #1055#1077#1088#1077#1085#1086#1089' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1086#1073#1098#1077#1082#1090#1086#1074
        Caption = 'ToolButton14'
        Grouped = True
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton15: TToolButton
        Tag = 15
        Left = 477
        Top = 2
        Hint = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1088#1072#1079#1084#1077#1088#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1086#1073#1098#1077#1082#1090#1086#1074' '
        Caption = 'ToolButton15'
        Grouped = True
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton16: TToolButton
        Tag = 16
        Left = 500
        Top = 2
        Hint = #1055#1086#1074#1086#1088#1086#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1086#1073#1098#1077#1082#1090#1086#1074
        Caption = 'ToolButton16'
        Grouped = True
        ImageIndex = 16
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object btBreakLine: TToolButton
        Tag = 17
        Left = 523
        Top = 2
        Hint = #1056#1072#1079#1073#1080#1077#1085#1080#1077' '#1083#1080#1085#1080#1080' '#1085#1072' '#1086#1090#1088#1077#1079#1082#1080
        Caption = 'btBreakLine'
        Grouped = True
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton19: TToolButton
        Tag = 18
        Left = 546
        Top = 2
        Hint = #1055#1088#1086#1076#1083#1077#1085#1080#1077'/'#1059#1089#1077#1095#1077#1085#1080#1077' '#1083#1080#1085#1080#1081
        Caption = 'ToolButton19'
        Grouped = True
        ImageIndex = 19
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton21: TToolButton
        Tag = 19
        Left = 569
        Top = 2
        Hint = #1057#1086#1079#1076#1072#1085#1080#1077' '#1091#1079#1083#1072' '#1074' '#1090#1086#1095#1082#1077' '#1087#1077#1088#1077#1089#1077#1095#1077#1085#1080#1103
        Caption = 'ToolButton21'
        Grouped = True
        ImageIndex = 21
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonOperationsClick
      end
      object ToolButton25: TToolButton
        Left = 592
        Top = 2
        Width = 8
        Caption = 'ToolButton25'
        ImageIndex = 23
        Style = tbsSeparator
      end
      object ToolButton24: TToolButton
        Left = 600
        Top = 2
        Hint = #1080#1079#1084#1077#1085#1077#1085#1080#1090#1100' '#1094#1074#1077#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1086#1073#1098#1077#1082#1090#1072
        HelpType = htKeyword
        HelpContext = 123
        Caption = 'ToolButton24'
        ImageIndex = 38
        ParentShowHint = False
        ShowHint = True
        OnClick = ColorChange
      end
      object ToolButton5: TToolButton
        Left = 623
        Top = 2
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 39
        Style = tbsSeparator
      end
    end
    object ToolBarOptions: TToolBar
      Left = 11
      Top = 32
      Width = 30
      Height = 26
      AutoSize = True
      Caption = 'ToolBar5'
      Images = ImageList1
      TabOrder = 2
      object ToolButton28: TToolButton
        Tag = 2
        Left = 0
        Top = 2
        Hint = #1055#1077#1088#1077#1082#1088#1077#1089#1090#1100#1077
        Caption = 'ToolButton23'
        ImageIndex = 24
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonOptionsClick
      end
    end
    object ToolBarZooming: TToolBar
      Left = 54
      Top = 32
      Width = 350
      Height = 26
      AutoSize = True
      Caption = 'ToolBarAttachMode'
      DragKind = dkDock
      Images = ImageList1
      TabOrder = 3
      object Label20: TLabel
        Left = 0
        Top = 2
        Width = 12
        Height = 22
        Caption = '1 :'
        Color = clBtnFace
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
      object edScale: TEdit
        Left = 12
        Top = 2
        Width = 55
        Height = 22
        Hint = #1084#1072#1089#1096#1090#1072#1073
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnChange = edScaleChange
      end
      object sbScale: TSpinButton
        Left = 67
        Top = 2
        Width = 15
        Height = 22
        Hint = #1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1084#1072#1089#1096#1090#1072#1073#1072
        DownGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
          E03D0000E03DE03DE03DE03D1500E03DE03DE03D000000000000E03DE03DE03D
          5B00E03DE03D00000000000000000000E03DE03D2300E03D0000000000000000
          000000000000E03D0400E03DE03DE03DE03DE03DE03DE03DE03DE03DC601}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        UpGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
          00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
          0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
          E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
        OnDownClick = sbScaleDownClick
        OnUpClick = sbScaleUpClick
      end
      object ToolButton23: TToolButton
        Left = 82
        Top = 2
        Width = 8
        Caption = 'ToolButton23'
        ImageIndex = 41
        Style = tbsSeparator
      end
      object ToolButton39: TToolButton
        Tag = 1
        Left = 90
        Top = 2
        Hint = #1059#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1084#1072#1089#1096#1090#1072#1073#1072
        Caption = 'ToolButton3'
        Grouped = True
        ImageIndex = 31
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonZooming
      end
      object ToolButton43: TToolButton
        Tag = 2
        Left = 113
        Top = 2
        Hint = #1059#1084#1077#1085#1100#1096#1077#1085#1080#1077' '#1084#1072#1089#1096#1090#1072#1073#1072
        Caption = 'ToolButton11'
        Grouped = True
        ImageIndex = 32
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonZooming
      end
      object ToolButton44: TToolButton
        Tag = 3
        Left = 136
        Top = 2
        Hint = #1057#1084#1077#1097#1077#1085#1080#1077' '#1090#1086#1095#1082#1080' '#1079#1088#1077#1085#1080#1103
        Caption = 'ToolButton12'
        Grouped = True
        ImageIndex = 33
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonZooming
      end
      object ToolButton46: TToolButton
        Left = 159
        Top = 2
        Width = 3
        Caption = 'ToolButton46'
        ImageIndex = 35
        Style = tbsSeparator
      end
      object cbViews: TComboBox
        Left = 162
        Top = 2
        Width = 140
        Height = 22
        Hint = #1058#1077#1082#1091#1097#1080#1081' '#1074#1080#1076
        Style = csDropDownList
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = cbViewsChange
      end
      object ToolButton45: TToolButton
        Tag = 4
        Left = 302
        Top = 2
        Hint = #1047#1072#1087#1086#1084#1080#1085#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1074#1080#1076#1072
        Caption = 'ToolButton45'
        Grouped = True
        ImageIndex = 39
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonZooming
      end
      object ToolButton32: TToolButton
        Left = 325
        Top = 2
        Hint = #1091#1076#1072#1083#1077#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1074#1080#1076#1072
        Caption = 'ToolButton32'
        ImageIndex = 40
        ParentShowHint = False
        ShowHint = True
        OnClick = DeleteView
      end
    end
    object ToolBar1: TToolBar
      Left = 419
      Top = 32
      Width = 368
      Height = 26
      AutoSize = True
      Caption = 'ToolBarAttachMode'
      DragKind = dkDock
      Images = ImageList1
      TabOrder = 4
      object cbLayers: TComboBox
        Left = 0
        Top = 2
        Width = 126
        Height = 22
        Hint = #1058#1077#1082#1091#1097#1080#1081' '#1090#1077#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1089#1083#1086#1081
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = cbLayersChange
        OnDblClick = cbLayersDblClick
      end
      object ToolButton3: TToolButton
        Left = 126
        Top = 2
        Hint = #1076#1086#1073#1072#1074#1080#1090#1100' '#1089#1083#1086#1081
        Caption = 'ToolButton3'
        ImageIndex = 39
        ParentShowHint = False
        ShowHint = True
        OnClick = CreateLayer
      end
      object ToolButton18: TToolButton
        Left = 149
        Top = 2
        Hint = #1091#1076#1072#1083#1080#1090#1100' '#1089#1083#1086#1081
        Caption = 'ToolButton18'
        ImageIndex = 40
        ParentShowHint = False
        ShowHint = True
        OnClick = DeleteLayer
      end
      object ToolButton26: TToolButton
        Left = 172
        Top = 2
        Width = 3
        Caption = 'ToolButton26'
        ImageIndex = 41
        Style = tbsSeparator
      end
      object PanelLayerColor: TPanel
        Left = 175
        Top = 2
        Width = 23
        Height = 22
        Hint = #1094#1074#1077#1090' '#1086#1073#1077#1082#1090#1086#1074' ('#1082#1088#1086#1084#1077' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1085#1099#1093' '#1074#1099#1076#1077#1083#1077#1085#1080#1077#1084')'
        HelpContext = 65
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = PanelLayerColorClick
        OnMouseDown = PanelLayerColorMouseDown
      end
      object ToolButton17: TToolButton
        Left = 198
        Top = 2
        Width = 6
        Caption = 'ToolButton17'
        ImageIndex = 42
        Style = tbsSeparator
      end
      object CheckVis: TCheckBox
        Left = 204
        Top = 2
        Width = 55
        Height = 22
        Hint = #1074#1082#1083'/'#1074#1099#1082#1083' '#1074#1080#1076#1080#1084#1086#1089#1090#1100' '#1089#1083#1086#1077#1074
        Caption = #1042#1080#1076#1080#1084'.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = CheckVisClick
      end
      object CheckSel: TCheckBox
        Left = 259
        Top = 2
        Width = 55
        Height = 22
        Hint = #1088#1072#1079#1088#1077#1096#1080#1090#1100'/'#1079#1072#1087#1088#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
        Caption = #1042#1099#1076#1077#1083'.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = CheckSelClick
      end
      object Panel3: TPanel
        Left = 314
        Top = 2
        Width = 36
        Height = 22
        Hint = #1090#1080#1087' '#1083#1080#1085#1080#1080
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 64
    Width = 193
    Height = 254
    Align = alLeft
    TabOrder = 1
    object pnlXYZ: TPanel
      Left = 1
      Top = 1
      Width = 191
      Height = 120
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 3
        Top = 4
        Width = 21
        Height = 14
        Caption = 'X, '#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 67
        Top = 4
        Width = 22
        Height = 14
        Caption = 'Y, '#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 131
        Top = 4
        Width = 21
        Height = 14
        Caption = 'Z, '#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 3
        Top = 39
        Width = 41
        Height = 14
        Caption = 'Dmax, '#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 4
        Top = 79
        Width = 34
        Height = 14
        Caption = 'Dmin '#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 131
        Top = 39
        Width = 41
        Height = 14
        Caption = 'Zm'#1072'x, '#1084
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 132
        Top = 79
        Width = 37
        Height = 14
        Caption = 'Zmin, '#1084
        Color = clBtnFace
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object edX: TEdit
        Tag = 1
        Left = 2
        Top = 18
        Width = 60
        Height = 22
        Hint = 'X-'#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = '0'
        OnEnter = edXEnter
        OnExit = edXExit
        OnKeyDown = edXYZKeyDown
        OnKeyPress = edXYZKeyPress
      end
      object edY: TEdit
        Tag = 2
        Left = 66
        Top = 18
        Width = 60
        Height = 22
        Hint = 'Y-'#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = '0'
        OnEnter = edXEnter
        OnExit = edXExit
        OnKeyDown = edXYZKeyDown
        OnKeyPress = edXYZKeyPress
      end
      object edZ: TComboBox
        Tag = 3
        Left = 130
        Top = 18
        Width = 63
        Height = 22
        Hint = 'Z-'#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072' '#1087#1083#1086#1089#1082#1086#1089#1090#1080' '#1088#1080#1089#1086#1074#1072#1085#1080#1103
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = '0'
        OnClick = edZClick
        OnEnter = edXEnter
        OnExit = edXExit
        OnKeyDown = edXYZKeyDown
        OnKeyPress = edXYZKeyPress
      end
      object edDmax: TEdit
        Left = 2
        Top = 52
        Width = 60
        Height = 22
        Hint = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1076#1072#1083#1100#1085#1086#1089#1090#1100' '#1074#1080#1076#1080#1084#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnChange = edDmaxChange
      end
      object edDmin: TEdit
        Left = 2
        Top = 92
        Width = 60
        Height = 22
        Hint = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1072#1103' '#1076#1072#1083#1100#1085#1086#1089#1090#1100' '#1074#1080#1076#1080#1084#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnChange = edDminChange
      end
      object edZmax: TEdit
        Left = 118
        Top = 52
        Width = 60
        Height = 22
        Hint = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1074#1099#1089#1086#1090#1072' '#1074#1080#1076#1080#1084#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnChange = edZmaxChange
      end
      object edZmin: TEdit
        Left = 118
        Top = 92
        Width = 60
        Height = 22
        Hint = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1072#1103' '#1074#1099#1089#1086#1090#1072' '#1074#1080#1076#1080#1084#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnChange = edZminChange
      end
      object sbDMax: TSpinButton
        Left = 62
        Top = 53
        Width = 15
        Height = 20
        Hint = #1091#1074#1077#1083#1080#1095#1080#1090#1100'/'#1091#1084#1077#1085#1100#1096#1080#1090#1100' max '#1076#1072#1083#1100#1085#1086#1089#1090#1100' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' ('#1084')'
        DownGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
          E03D0000E03DE03DE03DE03D1500E03DE03DE03D000000000000E03DE03DE03D
          5B00E03DE03D00000000000000000000E03DE03D2300E03D0000000000000000
          000000000000E03D0400E03DE03DE03DE03DE03DE03DE03DE03DE03DC601}
        FocusControl = edDmax
        ParentShowHint = False
        PopupMenu = pmMinmaxD
        ShowHint = True
        TabOrder = 7
        UpGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
          00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
          0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
          E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
        OnDownClick = sbDMaxDownClick
        OnUpClick = sbDMaxUpClick
      end
      object sbZMax: TSpinButton
        Left = 178
        Top = 53
        Width = 15
        Height = 20
        Hint = #1091#1074#1077#1083#1080#1095#1080#1090#1100'/'#1091#1084#1077#1085#1100#1096#1080#1090#1100' max '#1074#1099#1089#1086#1090#1091' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' ('#1084')'
        DownGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
          E03D0000E03DE03DE03DE03D1500E03DE03DE03D000000000000E03DE03DE03D
          5B00E03DE03D00000000000000000000E03DE03D2300E03D0000000000000000
          000000000000E03D0400E03DE03DE03DE03DE03DE03DE03DE03DE03DC601}
        FocusControl = edZmax
        ParentShowHint = False
        PopupMenu = pmMinmaxZ
        ShowHint = True
        TabOrder = 8
        UpGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
          00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
          0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
          E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
        OnDownClick = sbZMaxDownClick
        OnUpClick = sbZMaxUpClick
      end
      object sbDMin: TSpinButton
        Left = 62
        Top = 93
        Width = 15
        Height = 20
        Hint = #1091#1074#1077#1083#1080#1095#1080#1090#1100'/'#1091#1084#1077#1085#1100#1096#1080#1090#1100' min '#1076#1072#1083#1100#1085#1086#1089#1090#1100' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' ('#1084')'
        DownGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
          E03D0000E03DE03DE03DE03D1500E03DE03DE03D000000000000E03DE03DE03D
          5B00E03DE03D00000000000000000000E03DE03D2300E03D0000000000000000
          000000000000E03D0400E03DE03DE03DE03DE03DE03DE03DE03DE03DC601}
        FocusControl = edDmin
        ParentShowHint = False
        PopupMenu = pmMinmaxD
        ShowHint = True
        TabOrder = 9
        UpGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
          00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
          0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
          E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
        OnDownClick = sbDMinDownClick
        OnUpClick = sbDMinUpClick
      end
      object sbZMin: TSpinButton
        Left = 178
        Top = 93
        Width = 15
        Height = 20
        Hint = #1091#1074#1077#1083#1080#1095#1080#1090#1100'/'#1091#1084#1077#1085#1100#1096#1080#1090#1100' min '#1074#1099#1089#1086#1090#1091' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' ('#1084')'
        DownGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
          E03D0000E03DE03DE03DE03D1500E03DE03DE03D000000000000E03DE03DE03D
          5B00E03DE03D00000000000000000000E03DE03D2300E03D0000000000000000
          000000000000E03D0400E03DE03DE03DE03DE03DE03DE03DE03DE03DC601}
        FocusControl = edZmin
        ParentShowHint = False
        PopupMenu = pmMinmaxZ
        ShowHint = True
        TabOrder = 10
        UpGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
          00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
          0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
          E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
        OnDownClick = sbZMinDownClick
        OnUpClick = sbZMinUpClick
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 121
      Width = 191
      Height = 48
      Align = alTop
      TabOrder = 1
      object Label7: TLabel
        Left = 3
        Top = 1
        Width = 60
        Height = 13
        Caption = #1058#1086#1083#1097#1080#1085#1072', '#1084
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 68
        Top = 1
        Width = 52
        Height = 13
        Caption = #1042#1099#1089#1086#1090#1072', '#1084
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 130
        Top = 1
        Width = 63
        Height = 14
        Caption = #1055#1086#1074#1086#1088#1086#1090', '#1075#1088'.'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object edThickness: TEdit
        Left = 3
        Top = 16
        Width = 30
        Height = 22
        Hint = #1058#1086#1083#1097#1080#1085#1072' '#1086#1073#1098#1077#1082#1090#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = '0'
        OnChange = ThicknessChange
      end
      object edHeight: TEdit
        Left = 66
        Top = 16
        Width = 46
        Height = 22
        Hint = #1042#1099#1089#1086#1090#1072' '#1086#1073#1098#1077#1082#1090#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = '0'
        OnChange = edHeightChange
      end
      object edZAngle: TEdit
        Left = 130
        Top = 16
        Width = 46
        Height = 22
        Hint = #1059#1075#1086#1083' '#1087#1086#1074#1086#1088#1086#1090#1072' '#1089#1080#1089#1090#1077#1084#1099' '#1082#1086#1086#1088#1076#1080#1085#1072#1090
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = '0'
        OnChange = ViewZangleChange
      end
      object sbZAngle: TSpinButton
        Left = 176
        Top = 18
        Width = 15
        Height = 19
        Hint = #1091#1074#1077#1083#1080#1095#1080#1090#1100'/'#1091#1084#1077#1085#1100#1096#1080#1090#1100' '#1091#1075#1086#1083' ('#1075#1088#1072#1076')'
        DownGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
          E03D0000E03DE03DE03DE03D1500E03DE03DE03D000000000000E03DE03DE03D
          5B00E03DE03D00000000000000000000E03DE03D2300E03D0000000000000000
          000000000000E03D0400E03DE03DE03DE03DE03DE03DE03DE03DE03DC601}
        FocusControl = edZAngle
        ParentShowHint = False
        PopupMenu = pm_sbZAngle
        ShowHint = True
        TabOrder = 3
        UpGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
          00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
          0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
          E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
        OnDownClick = sbZAngleDownClick
        OnUpClick = sbZAngleUpClick
      end
      object sbHeight: TSpinButton
        Left = 112
        Top = 18
        Width = 15
        Height = 19
        Hint = #1091#1074#1077#1083#1080#1095#1080#1090#1100'/'#1091#1084#1077#1085#1100#1096#1080#1090#1100' '#1074#1099#1089#1086#1090#1091' ('#1084')'
        DownGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
          E03D0000E03DE03DE03DE03D1500E03DE03DE03D000000000000E03DE03DE03D
          5B00E03DE03D00000000000000000000E03DE03D2300E03D0000000000000000
          000000000000E03D0400E03DE03DE03DE03DE03DE03DE03DE03DE03DC601}
        FocusControl = edHeight
        ParentShowHint = False
        PopupMenu = pm_sbZAngle
        ShowHint = True
        TabOrder = 4
        UpGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
          00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
          0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
          E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
        OnDownClick = sbHeightDownClick
        OnUpClick = sbHeightUpClick
      end
      object sbThickness: TSpinButton
        Left = 40
        Top = 18
        Width = 15
        Height = 19
        Hint = #1091#1074#1077#1083#1080#1095#1080#1090#1100'/'#1091#1084#1077#1085#1100#1096#1080#1090#1100' '#1090#1086#1083#1097#1080#1085#1091' ('#1084')'
        DownGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03DE03DE03D
          E03D0000E03DE03DE03DE03D1500E03DE03DE03D000000000000E03DE03DE03D
          5B00E03DE03D00000000000000000000E03DE03D2300E03D0000000000000000
          000000000000E03D0400E03DE03DE03DE03DE03DE03DE03DE03DE03DC601}
        FocusControl = edThickness
        ParentShowHint = False
        PopupMenu = pm_sbZAngle
        ShowHint = True
        TabOrder = 5
        UpGlyph.Data = {
          BA000000424DBA00000000000000420000002800000009000000060000000100
          1000030000007800000000000000000000000000000000000000007C0000E003
          00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
          00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
          0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
          E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
        OnDownClick = sbThicknessDownClick
        OnUpClick = sbThicknessUpClick
      end
    end
  end
  object Panel0: TPanel
    Left = 193
    Top = 64
    Width = 600
    Height = 254
    Align = alClient
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    OnResize = Panel0Resize
    object Splitter1: TSplitter
      Left = 1
      Top = 201
      Width = 598
      Height = 2
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      OnMoved = Splitter1Moved
    end
    object PanelVert: TPanel
      Left = 1
      Top = 203
      Width = 598
      Height = 50
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object pnZRange: TPanel
        Left = 587
        Top = 1
        Width = 10
        Height = 48
        Hint = #1074#1099#1089#1086#1090#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
        Align = alRight
        BevelOuter = bvNone
        Color = 13303754
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnMouseMove = pnRangeMouseMove
        object spZmax: TSplitter
          Left = 0
          Top = 1
          Width = 10
          Height = 3
          Cursor = crSizeNS
          Hint = #1074#1077#1088#1093#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
          Align = alNone
          AutoSnap = False
          Color = clRed
          MinSize = 1
          ParentColor = False
          ResizeStyle = rsUpdate
          OnMoved = spZmaxMoved
        end
        object spZmin: TSplitter
          Left = 0
          Top = 103
          Width = 10
          Height = 3
          Cursor = crSizeNS
          Hint = #1085#1080#1078#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
          Align = alNone
          AutoSnap = False
          Color = clRed
          MinSize = 1
          ParentColor = False
          ResizeStyle = rsUpdate
          OnMoved = spZminMoved
        end
        object pnZmax: TPanel
          Left = 0
          Top = 0
          Width = 10
          Height = 1
          Align = alTop
          BevelOuter = bvNone
          Color = 15132415
          TabOrder = 0
          OnMouseMove = pnRangeMouseMove
        end
        object pnZmin: TPanel
          Left = 0
          Top = 47
          Width = 10
          Height = 1
          Align = alBottom
          BevelOuter = bvNone
          Color = 15132415
          TabOrder = 1
          OnMouseMove = pnRangeMouseMove
        end
      end
    end
    object PanelHoriz: TPanel
      Left = 1
      Top = 1
      Width = 598
      Height = 200
      Align = alTop
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object pnDRange: TPanel
        Left = 587
        Top = 1
        Width = 10
        Height = 198
        Hint = #1075#1083#1091#1073#1080#1085#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
        Align = alRight
        BevelOuter = bvNone
        Color = 13303754
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnMouseMove = pnRangeMouseMove
        object spDMax: TSplitter
          Left = 0
          Top = 1
          Width = 10
          Height = 3
          Cursor = crSizeNS
          Hint = #1076#1072#1083#1100#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
          Align = alNone
          AutoSnap = False
          Color = clRed
          MinSize = 1
          ParentColor = False
          ResizeStyle = rsUpdate
          OnMoved = spDMaxMoved
        end
        object spDmin: TSplitter
          Left = 0
          Top = 194
          Width = 10
          Height = 3
          Cursor = crSizeNS
          Hint = #1073#1083#1080#1078#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
          Align = alNone
          AutoSnap = False
          Color = clRed
          MinSize = 1
          ParentColor = False
          ResizeStyle = rsUpdate
          OnMoved = spDminMoved
        end
        object pnDmax: TPanel
          Left = 0
          Top = 0
          Width = 10
          Height = 1
          Align = alTop
          BevelOuter = bvNone
          Color = 15132415
          TabOrder = 0
          OnMouseMove = pnRangeMouseMove
        end
        object pnDmin: TPanel
          Left = 0
          Top = 197
          Width = 10
          Height = 1
          Align = alBottom
          BevelOuter = bvNone
          Color = 15132415
          TabOrder = 1
          OnMouseMove = pnRangeMouseMove
        end
      end
    end
  end
  object ImageList1: TImageList
    Left = 653
    Top = 104
    Bitmap = {
      494C01012E003100040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000D000000001001000000000000068
      0000000000000000000000000000000000007B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000007C
      007C007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F007C0000
      7B6F7B6F007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      0000007C007C007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F007C7B6F
      00007B6F007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      0000007C007C007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      007C00007B6F7B6F007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F007C7B6F
      7B6F0000007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      007C00007B6F7B6F007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      007C7B6F00007B6F007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F007C
      007C007C00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      007C7B6F00007B6F007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F0000007C007C007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      007C7B6F7B6F0000007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      007C00007B6F0000007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F007C00007B6F7B6F007C7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F007C007C007C00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F007C007C007C00007B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000007B6F
      7B6F7B6F7B6F007C7B6F00007B6F007C7B6F7B6F7B6F7B6F0000000000007B6F
      7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F0000000000007B6F
      7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F007C7B6F7B6F7B6F007C7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F007C007C007C7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000007B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000007B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000007B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6FE003E003E0037B6F7B6F00007B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000E00300000000000000000000000000001F001F001F001F001F001F001F00
      1F001F001F001F001F001F001F001F001F007B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6FE0037B6F00000000E0037B6F7B6F00007B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000E00300000000000000000000000000001F001F001F001F001F001F001F00
      1F001F001F001F001F001F001F001F001F007B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6FE00300007B6F0000E0037B6F7B6F7B6F00007B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000E00300000000000000000000000000001F001F001F001F001F001F001F00
      1F001F001F001F001F001F00E001E001E0017B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F00000000E0037B6F7B6F0000E0037B6F7B6F7B6F7B6F00007B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000E00300000000000000000000000000001F001F001F001F001F001F001F00
      1F001F001F00E001E001E001E001E001E0017B6F7B6F7B6F7B6F7B6F7B6F7B6F
      000000007B6F7B6F7B6FE003E003E0037B6F7B6F7B6F7B6F7B6F7B6F00007B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000E0030000000000000000000000000000FF03FF03FF03FF03FF03FF03FF03
      FF03E001E001E001E001E001E001E001E0017B6FE003E003E0037B6F00000000
      7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000E0030000000000000000000000000000FF03FF03FF03FF03FF03FF03FF03
      FF03FF03E001E001E001E001E001E001E001E0037B6F7B6F0000E0037B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F00000000000000000000E003E003
      E003E003E003E003E0030000000000000000FF03FF03FF03FF03FF03FF03FF03
      FF03FF03FF03FF03E001E001E001E001E001E003000000007B6FE0037B6F7B6F
      7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F000000000000000000000000E003
      E003E003E003E00300000000000000000000FF03FF03FF03FF03FF03FF03FF03
      FF03FF03FF03FF03FF03FF03E001E001E001E00300007B6F7B6FE0037B6F7B6F
      7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F000000000000000000000000E003
      E003E003E003E00300000000000000000000FF03FF03FF03FF03FF03FF03FF03
      FF03FF03FF03FF03FF03FF03FF03FF03E0017B6FE003E003E0037B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      E003E003E003000000000000000000000000FF03FF03FF03E07FE07FFF03FF03
      FF03FF03FF03FF03FF03FF03FF03FF03FF037B6F7B6F7B6F00007B6F7B6F7B6F
      7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F0000000000000000000000000000
      E003E003E003000000000000000000000000FF03FF03E07FE07FE07FE07FFF03
      FF03FF03FF03FF03FF03FF03FF03FF03FF037B6F7B6F7B6F00007B6F7B6F7B6F
      7B6F7B6F7B6F7B6F00007B6F7B6F7B6F7B6F7B6F7B6F7B6F007C007C007C7B6F
      7B6F7B6F7B6F7B6F7B6F00007B6F7B6F7B6F0000000000000000000000000000
      0000E0030000000000000000000000000000FF03FF03E07FE07FE07FE07FFF03
      FF03FF03FF03FF03FF03FF03FF03FF03FF037B6F7B6F7B6F7B6F000000000000
      000000000000000000007B6F7B6F7B6F7B6F7B6F7B6F007C7B6F7B6F7B6F007C
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000E0030000000000000000000000000000FF03FF03FF03E07FE07FFF03FF03
      FF03FF03FF03FF03FF03FF03FF03FF03FF037B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F007C7B6F7B6F7B6F007C
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      000000000000000000000000000000000000FF03FF03FF03FF03FF03FF03FF03
      FF03FF03FF03FF03FF03FF03FF03FF03FF037B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F007C7B6F7B6F7B6F007C
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      000000000000000000000000000000000000FF03FF03FF03FF03FF03FF03FF03
      FF03FF03FF03FF03FF03FF03FF03FF03FF037B6F7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F007C007C007C7B6F
      7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F7B6F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E003E003E00300000000000000000000000000000000
      0000000000000000E003E003E003E00300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E003E003E003E00300000000E003000000000000000000000000E003E003
      E003E003E003E00300000000E003E00300000000000000000000000000000000
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E003E003E003
      E003000000000000000000000000E00300000000E003E003E003E00300000000
      00000000000000000000E0030000E00300000000000000000000000000000000
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E003E003E003000000000000
      0000000000000000000000000000E00300000000E0030000E003000000000000
      0000000000000000E00300000000E0030000000000000000000000000000E003
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E00300000000000000000000
      0000000000000000000000000000E00300000000E00300000000E0030000E003
      0000E0030000E003000000000000E0030000000000000000000000000000E003
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E00300000000000000000000
      0000000000000000000000000000E00300000000E00300000000000000000000
      0000000000000000E00300000000E003000000000000000000000000E003E003
      E003E003E0030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E00300000000000000000000
      0000000000000000000000000000E00300000000E00300000000E00300000000
      0000000000000000000000000000E003000000000000000000000000E003E003
      E003E003E0030000000000000000000000000000000000000000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000E00300000000000000000000
      0000000000000000000000000000E00300000000E00300000000000000000000
      0000000000000000E00300000000E00300000000000000000000E003E003E003
      E003E003E003E003000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E00300000000000000000000
      00000000000000000000E003E003E00300000000E00300000000E00300000000
      00000000000000000000E003E003E00300000000000000000000000000000000
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E00300000000000000000000
      0000E003E003E003E00300000000000000000000E00300000000E003E003E003
      E003E003E003E003E0030000E003000000000000000000000000000000000000
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E00300000000E003E003E003
      E003000000000000000000000000000000000000E003E003E003000000000000
      0000000000000000E003E0030000000000000000000000000000000000000000
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E003E003E003000000000000
      00000000000000000000000000000000000000000000E003E003E00300000000
      00000000000000000000E0030000000000000000000000000000000000000000
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E003E003E003
      E003E003E003E003E00300000000000000000000000000000000000000000000
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C007C007C007C007C
      007C007C007C007C000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C007C007C007C
      007C007C007C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000007C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000007C007C000000000000003C007C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000003C007C007C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000003C007C00000000000000000000000000000000
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF7F007C00000000000000000000000000000000
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF7FFF7F0000000000000000000000000000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7F000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000F75EFF7F0000000000000000000000000000000000000000
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      EF3D000000000000000000000000000000000000000000000000000000000000
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EF3D
      0000000000000000EF3D00000000000000000000000000000000000000000000
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EF3D00000000
      00000000EF3D0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000EF3D000000000000
      EF3D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000EF3D000000000000EF3D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000EF3D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EF3D
      EF3DEF3DEF3DEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EF3D
      EF3DEF3DEF3DEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000EF3DEF3D
      EF3DEF3DEF3DEF3DEF3D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EF3DEF3DEF3D
      EF3DEF3DEF3DEF3DEF3D0000000000000000000000000000EF3DEF3D0000F75E
      F75EF75EF75E0000EF3DEF3D0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000EF3D000000000000
      EF3D0000E07FEF3D000000000000000000000000000000000000EF3DEF3DEF3D
      EF3DEF3DEF3DEF3DEF3DEF3D000000000000000000000000EF3D0000F75EF75E
      00000000F75EF75E0000EF3D0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000EF3DEF3DEF3DEF3D
      EF3D00000000E07F00000000000000000000000000000000EF3DEF3D0000EF3D
      EF3DEF3DEF3DEF3DEF3DEF3D000000000000000000000000EF3D0000F75E0000
      000000000000F75E0000EF3D0000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EF3DF75EFF7FF75EFF7F
      F75EEF3D0000000000000000000000000000000000000000EF3DEF3D0000EF3D
      EF3DEF3DEF3DEF3D0000EF3D000000000000000000000000EF3D0000F75E0000
      000000000000F75E0000EF3D0000000000000000000000000000000000000000
      000000000000000000000000000000000000EF3DEF3DF75EFF7FF75EFF7FF75E
      FF7FF75EEF3DEF3D0000000000000000000000000000EF3DEF3D00000000EF3D
      0000EF3D0000EF3D0000EF3D000000000000000000000000EF3D0000F75EF75E
      00000000F75EF75E0000EF3D0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000EF3DFF7FF75EFF7FF75EFF7F
      F75EFF7FEF3D000000000000000000000000000000000000000000000000EF3D
      0000EF3D0000EF3D0000EF3D000000000000000000000000EF3DEF3D0000F75E
      F75EF75EF75E0000EF3DEF3D0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000EF3DF75E007C007C007C007C
      007CF75EEF3D000000000000000000000000000000000000000000000000EF3D
      0000EF3D0000EF3D0000EF3D0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000EF3DFF7FF75EFF7FF75EFF7F
      F75EFF7FEF3D000000000000000000000000000000000000000000000000EF3D
      0000EF3D0000EF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EF3DEF3DF75EFF7FF75EFF7FF75E
      FF7FF75EEF3DEF3D00000000000000000000000000000000000000000000EF3D
      0000EF3D0000EF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EF3DF75EFF7FF75EFF7F
      F75EEF3D00000000000000000000000000000000000000000000000000000000
      0000EF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000EF3DEF3DEF3DEF3D
      EF3D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000EF3D000000000000
      EF3D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E003E003E003000000000000
      000000000000000000000000000000000000E003E00300000000000000000000
      0000000000000000000000000000E003E0030000000000000000E07FE07F0000
      E07FE07F0000E07FE07F00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0030000E003E003E003
      E00300000000000000000000000000000000E003E003E003000000000000007C
      007C007C007C000000000000E003E003E0030000E07FE07F00000000E07F0000
      E07FE07F0000E07F00000000E07FE07F00000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003000000000000
      0000E003E003E003E00300000000000000000000E003E003E003007C007C007C
      007C007C007C007C007CE003E003E00300000000E07FE07FE07F000000000000
      E07FE07F000000000000E07FE07FE07F00000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003000000000000
      00000000000000000000E003E003E003E00300000000E003007C007C00000000
      000000000000007C007C007CE0030000000000000000E07FE07FE07F0000E07F
      E07FE07FE07F0000E07FE07FE07F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E00300000000
      0000000000000000000000000000E003000000000000007C007C007C007C0000
      000000000000E003007C007C007C00000000E07F00000000E07FE07FE07FE07F
      E07FE07FE07FE07FE07FE07F00000000E07F0000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E003E003
      E0030000000000000000E003E0030000000000000000007C0000007C007C007C
      00000000E003E003E003007C007C00000000E07FE07F00000000E07FE07F0000
      000000000000E07FE07F00000000E07FE07F000000000000EF3D000000000000
      EF3D0000E07FEF3D000000000000000000000000000000000000000000000000
      0000E003E003E003E00300000000000000000000007C007C00000000007C007C
      007CE003E003E00300000000007C007C0000000000000000E07FE07F00000000
      0000000000000000E07FE07F000000000000000000000000EF3DEF3DEF3DEF3D
      EF3D00000000E07F000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000007C007C000000000000007C
      007C007CE003000000000000007C007C0000E07FE07FE07FE07FE07F00000000
      0000000000000000E07FE07FE07FE07FE07F00000000EF3DFF7FF75EFF7FF75E
      FF7FEF3D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000007C007C000000000000E003
      007C007C007C000000000000007C007C0000E07FE07FE07FE07FE07F00000000
      0000000000000000E07FE07FE07FE07FE07FEF3DEF3DFF7FF75EFF7F007CFF7F
      F75EFF7FEF3DEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000007C007C00000000E003E003
      E003007C007C007C00000000007C007C0000000000000000E07FE07F00000000
      0000000000000000E07FE07F0000000000000000EF3DF75EFF7FF75E007CF75E
      FF7FF75EEF3D0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C007CE003E003E003
      00000000007C007C007C0000007C00000000E07FE07F00000000E07FE07F0000
      000000000000E07FE07F00000000E07FE07F0000EF3DFF7F007C007C007C007C
      007CFF7FEF3D0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C007C007CE0030000
      000000000000007C007C007C007C00000000E07F00000000E07FE07FE07FE07F
      E07FE07FE07FE07FE07FE07F00000000E07F0000EF3DF75EFF7FF75E007CF75E
      FF7FF75EEF3D0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E003007C007C007C0000
      0000000000000000007C007CE0030000000000000000E07FE07FE07F0000E07F
      E07FE07FE07F0000E07FE07FE07F00000000EF3DEF3DFF7FF75EFF7F007CFF7F
      F75EFF7FEF3DEF3D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E003E003E003007C007C007C
      007C007C007C007C007CE003E003E00300000000E07FE07FE07F000000000000
      E07FE07F000000000000E07FE07FE07F000000000000EF3DFF7FF75EFF7FF75E
      FF7FEF3D00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E003E003E003000000000000007C
      007C007C007C000000000000E003E003E0030000E07FE07F00000000E07F0000
      E07FE07F0000E07F00000000E07FE07F0000000000000000EF3DEF3DEF3DEF3D
      EF3D000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E003E00300000000000000000000
      0000000000000000000000000000E003E0030000000000000000E07FE07F0000
      E07FE07F0000E07FE07F0000000000000000000000000000EF3D000000000000
      EF3D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E003E003000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E003E0030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E00300000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E003
      E003000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E003E003E003000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000E003E0030000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003E003E003E003
      E003E003E003E003E003E003000000000000000000000000E003E003E003E003
      E003E003E003E003E003E0030000000000000000000000000000000000000000
      000000000000000000000000E003E00300000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003E003E003E003
      E003E003E003E003E003E003000000000000000000000000E003E003E003E003
      E003E003E003E003E003E0030000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E00300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000001F001F001F00000000000000000000000000000000001F001F001F00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000001F001F001F00000000000000000000000000000000001F001F001F00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001F001F001F000000000000000000000000001F001F001F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001F001F001F001F001F000000
      0000000000001F001F001F001F0000000000000000001F001F001F001F000000
      0000000000001F001F001F001F001F0000000000000000000000000000000000
      000000000000007C000000000000000000000000000000000000000000000000
      0000E003000000000000000000000000000000001F001F001F001F0000000000
      00000000000000001F001F001F0000000000000000001F001F001F0000000000
      00000000000000001F001F001F001F0000000000000000000000000000000000
      00000000007C0000000000000000000000000000000000000000000000000000
      E0030000E00300000000000000000000000000001F001F001F001F0000000000
      00000000000000001F001F001F0000000000000000001F001F001F0000000000
      00000000000000001F001F001F001F0000000000000000000000000000000000
      0000007C0000000000000000000000000000000000000000000000000000E003
      000000000000E0030000000000000000000000001F001F001F001F001F001F00
      00000000000000001F001F001F0000000000000000001F001F001F0000000000
      000000001F001F001F001F001F001F0000000000000000000000000000000000
      007C000000000000000000000000000000000000000000000000000000000000
      E0030000E00300000000000000000000000000001F0000001F001F001F001F00
      1F00000000001F001F001F000000000000000000000000001F001F001F000000
      00001F001F001F001F001F0000001F000000000000000000000000000000007C
      0000000000000000000000000000000000000000000000000000000000000000
      0000E0030000000000000000000000000000000000000000000000001F001F00
      1F001F001F001F001F001F000000000000000000000000001F001F001F001F00
      1F001F001F001F00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001F00
      1F001F001F001F001F00000000000000000000000000000000001F001F001F00
      1F001F001F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001F001F001F0000000000000000000000000000000000000000001F001F00
      1F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003E003E003E003
      E003E003E003E003E003E003E003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003000000000000
      000000000000000000000000E003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E003000000000000000000000000000000000000E003000000000000
      0000000000000000007C0000E0030000000000000000000000000000E0030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E0030000000000000000000000000000000000000000000000000000
      0000000000000000007C0000E003000000000000000000000000E003E0030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E003000000000000000000000000000000000000E003000000000000
      000000000000007C00000000E00300000000000000000000E003E003E0030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E003000000000000000000000000000000000000E003E003E003E003
      E003E0030000007CE003E003E003000000000000000000000000E003E0030000
      00000000E0030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E0030000007C000000000000007C0000000000000000000000000000
      00000000007C00000000000000000000000000000000000000000000E0030000
      00000000E003E003000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E00300000000007C0000007C00000000000000000000000000000000
      0000007C007C0000000000000000000000000000000000000000000000000000
      00000000E003E003E00300000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E003000000000000007C000000000000000000000000000000000000
      0000007C00000000000000000000000000000000000000000000000000000000
      00000000E003E003000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E00300000000007C0000007C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000E0030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E0030000007C000000000000007C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E0030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E0030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E0030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E00300000000000000000000000000000000
      00000000E0030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E003E003E003E003E003E003E003
      000000000000000000000000000000000000E003E003E003E003E003E003E003
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C0000000000000000
      00000000000000000000007C007C00000000E00300000000000000000000E003
      000000000000000000000000000000000000E00300000000000000000000E003
      0000000000000000000000000000000000000000000000000000000000000000
      0000007C000000000000000000000000000000000000007C007C0000E003E003
      E003E003E003E003007C007C000000000000E00300000000000000000000E003
      000000000000000000000000000000000000E00300000000000000000000E003
      0000000000000000000000000000000000000000000000000000000000000000
      007C007C007C000000000000000000000000000000000000007C007C00000000
      000000000000007C007C0000000000000000E00300000000000000000000E003
      000000000000000000000000000000000000007C00000000000000000000007C
      000000000000000000000000000000000000000000000000000000000000007C
      007C007C007C007C00000000000000000000000000000000E003007C007C0000
      00000000007C007C0000E003000000000000E00300000000000000000000E003
      0000000000000000007C0000000000000000007C007C000000000000007C007C
      0000000000000000007C00000000000000000000000000000000000000000000
      0000007C0000000000000000000000000000000000000000E0030000007C007C
      0000007C007C00000000E003000000000000E00300000000000000000000E003
      0000000000000000007C007C000000000000E003007C007C0000007C007CE003
      0000000000000000007C007C000000000000000000000000007C0000E003E003
      E003007CE003E003E0030000007C00000000000000000000E00300000000007C
      007C007C000000000000E003000000000000E00300000000007C007C007C007C
      007C007C007C007C007C007C007C007C0000E0030000007C007C007C0000007C
      007C007C007C007C007C007C007C007C000000000000007C007C0000E0030000
      0000000000000000E0030000007C007C0000000000000000E00300000000007C
      007C007C000000000000E003000000000000E00300000000007C007C007C007C
      007C007C007C007C007C007C007C007C0000E0030000007C007C007C0000007C
      007C007C007C007C007C007C007C007C00000000007C007C007C007C007C0000
      0000000000000000007C007C007C007C007C000000000000E0030000007C007C
      0000007C007C00000000E003000000000000E00300000000000000000000E003
      0000000000000000007C007C000000000000E003007C007C0000007C007CE003
      0000000000000000007C007C00000000000000000000007C007C0000E0030000
      0000000000000000E0030000007C007C0000000000000000E003007C007C0000
      00000000007C007C0000E003000000000000E00300000000000000000000E003
      0000000000000000007C0000000000000000007C007C000000000000007C007C
      0000000000000000007C0000000000000000000000000000007C0000E003E003
      E003007CE003E003E0030000007C00000000000000000000007C007C00000000
      000000000000007C007C0000000000000000E00300000000000000000000E003
      000000000000000000000000000000000000007C00000000000000000000007C
      0000000000000000000000000000000000000000000000000000000000000000
      0000007C000000000000000000000000000000000000007C007C0000E003E003
      E003E003E003E003007C007C000000000000E00300000000000000000000E003
      000000000000000000000000000000000000E00300000000000000000000E003
      000000000000000000000000000000000000000000000000000000000000007C
      007C007C007C007C0000000000000000000000000000007C0000000000000000
      00000000000000000000007C007C00000000E00300000000000000000000E003
      000000000000000000000000000000000000E00300000000000000000000E003
      0000000000000000000000000000000000000000000000000000000000000000
      007C007C007C0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E003E003E003E003E003E003E003
      000000000000000000000000000000000000E003E003E003E003E003E003E003
      0000000000000000000000000000000000000000000000000000000000000000
      0000007C00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000007C
      007C007C00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000007C0000
      00000000007C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000007C007C007C0000000000000000000000000000000000000000007C0000
      00000000007C0000000000000000000000000000000000000000000000000000
      0000007C007C007C000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      007C000000000000007C000000000000000000000000000000000000007C0000
      00000000007C0000000000000000000000000000000000000000000000000000
      007C000000000000007C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      007C000000000000007C0000000000000000000000000000000000000000007C
      007C007C00000000000000000000000000000000000000000000000000000000
      007C000000000000007C00000000000000000000000000000000000000000000
      0000000000000000007C007C007C000000000000000000000000000000000000
      007C000000000000007C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      007C000000000000007C00000000000000000000000000000000000000000000
      000000000000007C000000000000007C00000000000000000000000000000000
      0000007C007C007C000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000007C007C007C000000000000000000000000000000000000000000000000
      000000000000007C000000000000007C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007C000000000000007C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000007C007C007C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E003E003E00300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000E003E00300000000000000000000000000000000
      0000000000000000E003000000000000E0030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000E003E0030000E00300000000000000000000000000000000
      0000000000000000E003000000000000E0030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000E003E003000000000000E00300000000000000000000000000000000
      0000000000000000E003000000000000E0030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E003E0030000000000000000E003000000000000000000000000000000000000
      00000000000000000000E003E003E00300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E003E003
      000000000000000000000000E003000000000000E003E003E003000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003E00300000000
      000000000000000000000000E00300000000E003000000000000E00300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E003E0030000000000000000
      00000000000000000000E003000000000000E003000000000000E00300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E00300000000000000000000
      00000000000000000000E003000000000000E003000000000000E00300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0030000000000000000
      00000000000000000000E0030000000000000000E003E003E003000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003000000000000
      00000000000000000000E0030000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000E003000000000000
      0000000000000000E00300000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C007C007C0000
      0000000000000000000000000000000000000000000000000000E003E003E003
      E003E003E003E003E00300000000000000000000000000000000E003E003E003
      E003E003E003E003E00300000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C000000000000007C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C000000000000007C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007C000000000000007C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C007C007C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000D00000000100010000000000800600000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FE3FFFFF00000000FE3F000000000000
      FE3F000000000000FE3F000000000000FE3F000000000000FE3F000000000000
      F007000000000000F007000000000000F80F000000000000F80F000000000000
      FC1F000000000000FC1F000000000000FE3F000000000000FE3F000000000000
      FF7F000000000000FF7F000000000000FFFFFFFFFFFFFEFFFFFFFFF1FFE1FEFF
      FFFFFF0DF819FC7FFFFFF0FD87F5FC7FFFFF8FFDAFEDF83FFFFFBFFDB55DF83F
      FFFFBFFDBFEDF01FE007BFFDB7FDF01FE007BFFDBFEDE00FE007BFF1B7F1E00F
      FFFFBF0FB00BFC7FFFFFB0FF8FE7FC7FFFFF8FFFC7F7FC7FFFFFFFFFF00FFC7F
      FFFFFFFFFFFFFC7FFFFFFFFFFFFFFC7FFFFFFFFFC01FFFFFFFFFFFFFE02FFFFF
      FFFFFFFFFFE3FFFFF00FE003FF31FFFFCFF3EFFBFFF0FC7FBFFDF777FFF0FC7F
      BFFDF637FFF0FC7FBFFDFB6FFFE1E00FBFFDFBEFFFC3E00FCFF3FDDFFF83E00F
      F00FFDDFFE07FC7FFFFFFEBFFC0FFC7FFFFFFEBFF03FFC7FFFFFFF7FE0FFFFFF
      FFFFFFFF83FFFFFFFFFFFFFF0FFFFFFFFFFDFFFFFFFFFFFFFFF8F80FFFFFFFFF
      FFF1F80FFFFFFFFFFFE3F007C003FFFFFFC7E007C003FFFFE08FE003C003DFFD
      C01FC003C003DFFD803FC003C003EFFB001F8003C003EFFB001F8803C003F3E7
      001FF803C003FC1F001FF807F813FFFF001FF80FFFF3FFFF803FFC1FFFFFFFFF
      C07FFF7FFFFFFFFFE0FFFFFFFFFFFFFF8FFF3FFCF24FFFFD90FF1C389A59FFF8
      AF0F80018E71FFF1AFF0C7C3C423FFE3B7FCC3C36006FFC7B8F2D18333CCE08F
      BB0E9819E7E7C01FBBEE9C3907E0803F8BEE9C3907E0001FD0EE9819E7E7001F
      EB0EC18B33CC001FEBE0C3C36006001FF3EDC3E3C423001FF8E380018E71803F
      FF0F1C389A59C07FFFFF3FFCF24FE0FFFFFFFFFFFFFFFFFFFF7FFFFFFFFFCFFF
      FFFFFE7FFFFFD3FFFF7FFE7FFFFFDCFFFFFFFE7FFFFFDF1FFF7FFE7FFFFFDFE7
      FFFFE007E007DFF9D555E007E007DFFDFFFFFE7FFFFFDFFDFF7FFE7FFFFFDFFD
      FFFFFE7FFFFFCFFDFF7FFE7FFFFFF3FDFFFFFFFFFFFFFCFDFF7FFFFFFFFFFF1D
      FFFFFFFFFFFFFFE5FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      DFFFDFFDFF8FF1FFEFFFEFFBFF8FF1FFF7FFF7F7FFC7E3FFFBFFFBEF83C3C3C1
      FDDFFD5F87E3C7E1FEBFFEBF87E3C7E1FF7FFD5F81E3C781FEBFFEBFA0C7E305
      FDDFFD5FF807E01FFFEFFBEFFC0FF03FFFF7F7F7FF1FF8FFFFFBEFFBFFFFFFFF
      FFFFDFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE003FFF7FFFFFFFF
      EBFBFFE7FFFDFFBFE5EBFBD7FFFDFFBFEEEBF3B7FFFDFFBFCF5BE377FFFDFFBF
      A003F2B7FFFDFFAEDF9FFA97FFFDFFB5EF2FFE8782A98001F777FE97FFFDFFB5
      FBEFFEB7FFFDFFAEFDDFFEEFFFFDFFBFFEBFFEDFFFFDFFBFFF7FFEBFFFFDFFBF
      FFFFFE7FFFFDFFBFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01800180FFFF
      CFF37DBE7DBE8000C0037DBE7DBEBE3EE3C77DBE7DBEBC1EE1877DAE39AEBF7E
      E8177DA611A6A80AEC37600044008BE8EC376000440083E0E8177DA611A68BE8
      E1877DAE39AEA80AE3C77DBE7DBEBF7EC0037DBE7DBEBC1ECFF37DBE7DBEBE3E
      FFFF018001808000FFFFFFFFFFFFFFFFFFFFBFFFFFFFFFFFDFFFDFFFDFFFDFFF
      EFFFEFFFEFFFEFFFF7FFF7FFF7FFF7FFFBFFFBFFF87FFBFFFDFFFDFFF9BFFDFF
      FEFFFE1FFABFFE1FFF7FFE6FFB3FFE6FFFBFFEAFFC3FFEAFFFC3FECFFFDFFE4F
      FFCDFF0FFFEFFF0FE3D5E3F7E3F7FDF7DDDDDDFFDDFFFFFFDDE3DDFFDDFFF7FF
      DDFFDDFFDDFFFFFFE3FFE3FFE3FFDFFFFFFFFFFFFFF1BFFFFFF9FFF9FFE8DFFF
      FFE5FFE5FFE4EFFFFF9DFF9DFF8CF7FFFE7BFE7BFE71FBFFF9FBF9FB89FBFDFF
      E7FBE7FB67FBFEFF9FF79FF717F7FF7FBFF7BFF737F7FFBFDFF7DFF78FF7FFDF
      EFF7EFF7EFEFFFEFEFEFEFEFEFEFE3F7F00FF00FF00FDDFFFFFFFFFFFFFFDDFF
      FFFFFFFFFFFFDDFFFFFFFFFFFFFFE3FFFFFFFFFFFFFFFFFFFFFFFFF9FFF9FFFF
      DFFFFFE5FFE5FFFFEFFFFF9DFF9D8001F7FFFE7BFE7BBFFDFBFFF9FBF9FBBFFD
      FDFFE7FBE7FBBFFDFEFF9FF79FF7BFFDFF7FFFF7BFF7BFFDFFBFFFF7DFF7BFFD
      FFDFFFF7EFF7BFFDFFEFFFEFEFEF8001FFF7F00FF00FFFFFFFFBFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    AutoPopup = False
    Left = 626
    Top = 104
    object miEdit1: TMenuItem
      Tag = -1
      Caption = 'miEdit'
      ShortCut = 115
      Visible = False
      OnClick = miKeyClick
    end
    object miUp1: TMenuItem
      Tag = -2
      Caption = 'miUp'
      Visible = False
      OnClick = miKeyClick
    end
    object miDown1: TMenuItem
      Tag = -3
      Caption = 'miDown'
      Visible = False
      OnClick = miKeyClick
    end
    object miLeft1: TMenuItem
      Tag = -4
      Caption = 'miLeft'
      Visible = False
      OnClick = miKeyClick
    end
    object miRight1: TMenuItem
      Tag = -5
      Caption = 'miRight'
      Visible = False
      OnClick = miKeyClick
    end
    object miShiftUp1: TMenuItem
      Tag = -6
      Caption = 'miShiftUp'
      Visible = False
      OnClick = miKeyClick
    end
    object miShiftDown1: TMenuItem
      Tag = -7
      Caption = 'miShiftDown'
      Visible = False
      OnClick = miKeyClick
    end
    object miShiftLeft1: TMenuItem
      Tag = -8
      Caption = 'miShiftLeft'
      Visible = False
      OnClick = miKeyClick
    end
    object miShiftRight1: TMenuItem
      Tag = -9
      Caption = 'miShiftRight'
      Visible = False
      OnClick = miKeyClick
    end
    object miSpace1: TMenuItem
      Tag = -10
      Caption = 'miSpace'
      ShortCut = 116
      Visible = False
      OnClick = miKeyClick
    end
    object miEscape1: TMenuItem
      Tag = -11
      Caption = 'miEscape'
      ShortCut = 117
      Visible = False
      OnClick = miKeyClick
    end
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Color = -1638426
    Left = 600
    Top = 104
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 679
    Top = 104
  end
  object OpenPictureDialog2: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 706
    Top = 104
  end
  object pm_sbZAngle: TPopupMenu
    Left = 600
    Top = 136
    object N1: TMenuItem
      Caption = #1096#1072#1075' '#1091#1075#1083#1072'        ('#1075#1088#1072#1076')'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1096#1072#1075' '#1074#1099#1089#1086#1090#1099'     ('#1084')'
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1096#1072#1075' '#1090#1086#1083#1097#1080#1085#1099'  ('#1089#1084')'
      OnClick = N3Click
    end
  end
  object pmMinmaxD: TPopupMenu
    Left = 632
    Top = 136
    object mi_IntervalDZ_1: TMenuItem
      Caption = #1096#1072#1075' D/Zmax D/Z min  ('#1084')'
      OnClick = mi_IntervalDZClick
    end
    object mi_MinmaxD: TMenuItem
      Caption = #1096#1072#1075' Dmax Dmin  ('#1084')'
      OnClick = mi_IntervalDZClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mi_Dmax: TMenuItem
      Caption = #1096#1072#1075' Dmax  ('#1084')'
    end
    object mi_Dmin: TMenuItem
      Caption = #1096#1072#1075' Dmin  ('#1084')'
    end
  end
  object pmMinmaxZ: TPopupMenu
    Left = 664
    Top = 136
    object mi_IntervalDZ_2: TMenuItem
      Caption = #1096#1072#1075' D/Zmax D/Z min  ('#1084')'
      OnClick = mi_IntervalDZClick
    end
    object mi_IntervalZ: TMenuItem
      Caption = #1096#1072#1075' Zmax Zmin  ('#1084')'
      OnClick = mi_IntervalZClick
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object mi_Zmax: TMenuItem
      Caption = #1096#1072#1075' Zmax  ('#1084')'
    end
    object mi_Zmin: TMenuItem
      Caption = #1096#1072#1075' Zmin  ('#1084')'
    end
  end
  object MainMenu1: TMainMenu
    Left = 313
    Top = 89
    object MenuItem1: TMenuItem
      Caption = #1060#1072#1081#1083
      object miNew: TMenuItem
        Caption = #1053#1086#1074#1099#1081' '#1092#1072#1081#1083
        OnClick = miNewClick
      end
      object miOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        ShortCut = 16463
        OnClick = miOpenClick
      end
      object miSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = miSaveClick
      end
      object miSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        OnClick = miSaveAsClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object miClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        ShortCut = 16499
        OnClick = miCloseClick
      end
      object miExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 32883
        OnClick = miExitClick
      end
    end
  end
end
