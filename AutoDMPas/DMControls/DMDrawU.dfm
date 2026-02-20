inherited DMDraw: TDMDraw
  Left = 400
  Top = 106
  Caption = 'DMDraw'
  ClientHeight = 432
  ClientWidth = 858
  OldCreateOrder = True
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 628
    Top = 25
    Width = 5
    Height = 407
    Cursor = crHSplit
    Align = alRight
    AutoSnap = False
    Color = clGray
    ParentColor = False
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 858
    Height = 25
    Align = alTop
    AutoSize = True
    RowSnap = False
    TabOrder = 0
    OnClick = ControlBar1Click
  end
  object PanelInfo: TPanel
    Left = 633
    Top = 25
    Width = 225
    Height = 407
    Align = alRight
    TabOrder = 1
    OnEnter = PanelInfoEnter
    OnExit = PanelInfoExit
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 223
      Height = 405
      ActivePage = tsLayers
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      HotTrack = True
      MultiLine = True
      ParentFont = False
      TabHeight = 15
      TabIndex = 2
      TabOrder = 0
      OnEnter = PanelInfoEnter
      object tsXYZ: TTabSheet
        Caption = 'XYZ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        object Label1: TLabel
          Left = 23
          Top = 5
          Width = 22
          Height = 15
          Caption = 'X, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 84
          Top = 5
          Width = 21
          Height = 15
          Caption = 'Y, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 149
          Top = 5
          Width = 21
          Height = 15
          Caption = 'Z, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label20: TLabel
          Left = -1
          Top = 196
          Width = 10
          Height = 15
          Caption = '1:'
          Color = clBtnFace
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label7: TLabel
          Left = 10
          Top = 179
          Width = 54
          Height = 13
          Caption = #1052#1072#1089#1096#1090#1072#1073
        end
        object Label11: TLabel
          Left = 116
          Top = 179
          Width = 83
          Height = 13
          Caption = #1055#1086#1074#1086#1088#1086#1090' '#1086#1089#1077#1081
        end
        object edX: TEdit
          Tag = 1
          Left = 10
          Top = 19
          Width = 60
          Height = 23
          Hint = 'X-'#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = '0'
          OnChange = edXYZChange
          OnClick = PanelClick
          OnEnter = edXYZEnter
          OnExit = edXYZExit
          OnKeyDown = edXYZKeyDown
          OnKeyPress = edXYZKeyPress
          OnMouseDown = ControlMouseDown
        end
        object edZ: TEdit
          Tag = 3
          Left = 138
          Top = 19
          Width = 49
          Height = 23
          Hint = 'Z-'#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072' '#1087#1083#1086#1089#1082#1086#1089#1090#1080' '#1088#1080#1089#1086#1074#1072#1085#1080#1103
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Text = '0'
          OnChange = edXYZChange
          OnClick = PanelClick
          OnDblClick = edZDblClick
          OnEnter = edXYZEnter
          OnExit = edXYZExit
          OnKeyDown = edXYZKeyDown
          OnKeyPress = edXYZKeyPress
          OnMouseDown = ControlMouseDown
        end
        object edScale: TEdit
          Left = 10
          Top = 192
          Width = 55
          Height = 23
          Hint = #1084#1072#1089#1096#1090#1072#1073
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = 15
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnChange = edScaleChange
          OnClick = PanelClick
          OnMouseDown = ControlMouseDown
        end
        object sbScale: TSpinButton
          Left = 64
          Top = 195
          Width = 15
          Height = 18
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
          TabOrder = 9
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
        object edZAngle: TEdit
          Left = 119
          Top = 192
          Width = 58
          Height = 23
          Hint = #1059#1075#1086#1083' '#1087#1086#1074#1086#1088#1086#1090#1072' '#1089#1080#1089#1090#1077#1084#1099' '#1082#1086#1086#1088#1076#1080#1085#1072#1090
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          PopupMenu = pm_sbZAngle
          ShowHint = True
          TabOrder = 8
          Text = '0'
          OnChange = edZangleChange
          OnClick = PanelClick
          OnKeyPress = edZAngleKeyPress
          OnMouseDown = ControlMouseDown
        end
        object sbZAngle: TSpinButton
          Left = 177
          Top = 195
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
          TabOrder = 10
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
        object sbZ: TSpinButton
          Left = 187
          Top = 21
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
          FocusControl = ed_Z
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          UpGlyph.Data = {
            BA000000424DBA00000000000000420000002800000009000000060000000100
            1000030000007800000000000000000000000000000000000000007C0000E003
            00001F000000E03DE03DE03DE03DE03DE03DE03DE03DE03D0300E03D00000000
            00000000000000000000E03D2003E03DE03D00000000000000000000E03DE03D
            0200E03DE03DE03D000000000000E03DE03DE03D1E03E03DE03DE03DE03D0000
            E03DE03DE03DE03DBE81E03DE03DE03DE03DE03DE03DE03DE03DE03DBE81}
          OnDownClick = sbZDownClick
          OnUpClick = sbZUpClick
        end
        object pPolar: TPanel
          Left = -8
          Top = 40
          Width = 209
          Height = 41
          BevelOuter = bvNone
          TabOrder = 3
          Visible = False
          object Label8: TLabel
            Left = 18
            Top = 3
            Width = 52
            Height = 15
            Caption = #1044#1083#1080#1085#1072', '#1084
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label10: TLabel
            Left = 82
            Top = 3
            Width = 60
            Height = 15
            Caption = #1059#1075#1086#1083', '#1075#1088#1072#1076
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edPAngle: TEdit
            Left = 82
            Top = 19
            Width = 60
            Height = 23
            Hint = 'X-'#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '0'
            OnChange = edPLengthChange
            OnClick = PanelClick
            OnEnter = edXYZEnter
            OnExit = edXYZExit
            OnKeyDown = edPLengthKeyDown
            OnKeyPress = edPAngleKeyPress
            OnMouseDown = ControlMouseDown
          end
          object edPLength: TEdit
            Left = 18
            Top = 19
            Width = 60
            Height = 23
            Hint = 'X-'#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = '0'
            OnChange = edPLengthChange
            OnClick = PanelClick
            OnEnter = edXYZEnter
            OnExit = edXYZExit
            OnKeyDown = edPLengthKeyDown
            OnKeyPress = edPLengthKeyPress
            OnMouseDown = ControlMouseDown
          end
        end
        object btF5: TBitBtn
          Left = 4
          Top = 88
          Width = 99
          Height = 25
          Caption = #1051#1077#1074#1072#1103' '#1082#1083'. (F5)'
          TabOrder = 4
          OnClick = btF5Click
        end
        object btF6: TBitBtn
          Left = 103
          Top = 88
          Width = 99
          Height = 25
          Caption = #1055#1088#1072#1074#1072#1103' '#1082#1083'. (F6)'
          TabOrder = 5
          OnClick = btF6Click
        end
        object btF4: TBitBtn
          Left = 4
          Top = 116
          Width = 197
          Height = 25
          Caption = #1042#1086#1079#1074#1088#1072#1090' '#1074' '#1088#1077#1076#1072#1082#1090#1086#1088' (F4)'
          TabOrder = 6
          OnClick = btF4Click
        end
        object edY: TEdit
          Tag = 2
          Left = 74
          Top = 19
          Width = 60
          Height = 23
          Hint = 'Y-'#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Text = '0'
          OnChange = edXYZChange
          OnClick = PanelClick
          OnEnter = edXYZEnter
          OnExit = edXYZExit
          OnKeyDown = edXYZKeyDown
          OnKeyPress = edXYZKeyPress
          OnMouseDown = ControlMouseDown
        end
      end
      object tsViews: TTabSheet
        Caption = #1042#1080#1076#1099
        ImageIndex = 3
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 215
          Height = 42
          Align = alTop
          TabOrder = 0
          object btAddView: TButton
            Left = 0
            Top = 0
            Width = 100
            Height = 20
            Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = tbAddViewClck
            OnMouseDown = ControlMouseDown
          end
          object btDelView: TButton
            Left = 102
            Top = 0
            Width = 100
            Height = 20
            Caption = #1059#1076#1072#1083#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = btDelViewClick
            OnMouseDown = ControlMouseDown
          end
          object btUpdateView: TButton
            Left = 103
            Top = 21
            Width = 99
            Height = 20
            Caption = #1054#1073#1085#1086#1074#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = btUpdateViewClick
            OnMouseDown = ControlMouseDown
          end
          object btRestoreView: TButton
            Left = 0
            Top = 21
            Width = 100
            Height = 20
            Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = btRestoreViewClick
            OnMouseDown = ControlMouseDown
          end
        end
        object sgViews: TStringGrid
          Left = 0
          Top = 42
          Width = 215
          Height = 323
          Cursor = crHandPoint
          Align = alClient
          BorderStyle = bsNone
          ColCount = 6
          Ctl3D = False
          DefaultColWidth = 16
          DefaultRowHeight = 18
          DragCursor = crHandPoint
          FixedColor = 15263976
          RowCount = 2
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowMoving, goThumbTracking]
          ParentCtl3D = False
          ParentFont = False
          PopupMenu = pm_Views
          TabOrder = 1
          OnClick = PanelClick
          OnDblClick = sgViewsDblClick
          OnExit = sgViewsExit
          OnKeyDown = sgViewsKeyDown
          OnRowMoved = sgViewsRowMoved
          OnSelectCell = sgViewsSelectCell
          ColWidths = (
            16
            80
            17
            18
            17
            55)
        end
      end
      object tsLayers: TTabSheet
        Caption = #1057#1083#1086#1080
        ImageIndex = 4
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 215
          Height = 43
          Align = alTop
          TabOrder = 0
          object bt_SetOne: TButton
            Tag = 2
            Left = 140
            Top = 22
            Width = 74
            Height = 21
            Hint = #1059#1089#1090'."+"  '#1090#1086#1083#1100#1082#1086' '#1074' '#1086#1090#1084#1077#1095#1077#1085#1085#1086#1081' '#1089#1090#1088#1086#1082#1077' '#1082#1086#1083#1086#1085#1082#1077
            Caption = #1054#1076#1080#1085
            Enabled = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = bt_SetOneClick
            OnMouseDown = ControlMouseDown
          end
          object bt_SetCurLayer: TButton
            Left = 0
            Top = 22
            Width = 72
            Height = 20
            Hint = #1057#1076#1077#1083#1072#1090#1100' '#1090#1077#1082#1091#1097#1077#1081' '#1074#1099#1076#1077#1083#1077#1085#1085#1091#1102' '#1089#1090#1088#1086#1082#1091
            Caption = #1058#1077#1082#1091#1097#1080#1081
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = bt_SetCurLayerClick
            OnMouseDown = ControlMouseDown
          end
          object Button2: TButton
            Left = 0
            Top = 1
            Width = 72
            Height = 20
            Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1083#1086#1081
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = CreateLayer
            OnMouseDown = ControlMouseDown
          end
          object Button3: TButton
            Left = 72
            Top = 1
            Width = 68
            Height = 20
            Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1083#1086#1081
            Caption = #1059#1076#1072#1083#1080#1090#1100
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = DelLayerClick
            OnMouseDown = ControlMouseDown
          end
          object bt_SetAll: TButton
            Tag = 1
            Left = 72
            Top = 21
            Width = 68
            Height = 21
            Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' "+" '#1087#1086' '#1074#1089#1077#1081' '#1086#1090#1084#1077#1095#1077#1085#1085#1086#1081' '#1082#1086#1083#1086#1085#1082#1077' '
            Caption = #1042#1089#1077
            Enabled = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = bt_SetAllClick
            OnMouseDown = ControlMouseDown
          end
          object btJoinLayer: TButton
            Left = 140
            Top = 1
            Width = 73
            Height = 20
            Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1083#1086#1081
            Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = btJoinLayerClick
            OnMouseDown = ControlMouseDown
          end
        end
        object sgLayers: TStringGrid
          Left = 0
          Top = 43
          Width = 215
          Height = 322
          Cursor = crHandPoint
          Hint = #1058#1072#1073#1083#1080#1094#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1089#1083#1086#1077#1074
          Align = alClient
          BorderStyle = bsNone
          ColCount = 8
          Ctl3D = False
          DefaultColWidth = 16
          DefaultRowHeight = 18
          DragCursor = crHandPoint
          RowCount = 9
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowMoving, goThumbTracking]
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          PopupMenu = pm_Layers
          ShowHint = True
          TabOrder = 1
          OnClick = PanelClick
          OnDblClick = sgLayersDblClick
          OnDrawCell = sgLayersDrawCell
          OnExit = sgLayersExit
          OnKeyDown = sgLayersKeyDown
          OnRowMoved = sgLayersRowMoved
          OnSelectCell = sgLayersSelectCell
          ColWidths = (
            16
            112
            18
            18
            18
            18
            16
            102)
        end
        object cbLayerRef: TComboBox
          Left = 24
          Top = 256
          Width = 145
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 2
          Visible = False
          OnChange = cbLayerRefChange
          OnExit = cbLayerRefExit
          OnKeyPress = cbLayerRefKeyPress
        end
      end
      object tsProperties: TTabSheet
        Caption = #1057#1074#1086#1081#1089#1090#1074#1072
        ImageIndex = 5
        object pn_Param: TPanel
          Left = 0
          Top = 0
          Width = 215
          Height = 71
          Align = alTop
          TabOrder = 0
          object pn_ObjectName: TPanel
            Left = 1
            Top = 1
            Width = 213
            Height = 70
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object lb_SelectCount: TLabel
              Left = 5
              Top = 3
              Width = 6
              Height = 13
              Caption = '1'
              Color = 14408667
              ParentColor = False
            end
            object lb_ClassAlias: TLabel
              Left = 6
              Top = 21
              Width = 26
              Height = 13
              Caption = #1090#1080#1087' - '
              Color = 14408667
              ParentColor = False
            end
            object lbSelLayer: TLabel
              Left = 6
              Top = 44
              Width = 25
              Height = 13
              Caption = #1057#1083#1086#1081
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object cb_SelectLayer: TComboBox
              Tag = 1
              Left = 40
              Top = 40
              Width = 139
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 0
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              TabOrder = 0
              OnChange = SelectLayerChange
              OnClick = cb_SelectLayerClick
            end
          end
        end
        object pn_ParentParam: TPanel
          Left = 0
          Top = 181
          Width = 215
          Height = 184
          Align = alClient
          TabOrder = 1
          object lb_Parents: TListBox
            Left = 1
            Top = 19
            Width = 213
            Height = 160
            Hint = #1069#1083#1077#1084#1077#1085#1090' : '#1042#1083#1072#1076#1077#1083#1077#1094'  '#1101#1083#1077#1084#1077#1085#1090#1072
            Align = alClient
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            IntegralHeight = True
            ItemHeight = 13
            ParentBiDiMode = False
            ParentFont = False
            ParentShowHint = False
            PopupMenu = pmRapair
            ShowHint = True
            TabOrder = 0
            OnDblClick = lb_ParentsDblClick
          end
          object pn_HeadParent: TPanel
            Left = 1
            Top = 1
            Width = 213
            Height = 18
            Align = alTop
            TabOrder = 1
            OnClick = lb_HeadParentClick
            OnMouseDown = ControlMouseDown
            object lb_HeadParent: TLabel
              Left = 4
              Top = 2
              Width = 3
              Height = 13
              Caption = ' '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              OnClick = lb_HeadParentClick
            end
          end
        end
        object pn_SelectedParam: TPanel
          Left = 0
          Top = 71
          Width = 215
          Height = 110
          Align = alTop
          TabOrder = 2
        end
      end
      object tsSection: TTabSheet
        Caption = #1057#1077#1095#1077#1085#1080#1103
        ImageIndex = 1
        OnMouseMove = pnRangeMouseMove
        object LDmax: TLabel
          Left = 8
          Top = 30
          Width = 45
          Height = 15
          Caption = 'Ymax, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 134
          Top = 32
          Width = 45
          Height = 15
          Caption = 'Zm'#1072'x, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object LDMin: TLabel
          Left = 7
          Top = 72
          Width = 40
          Height = 15
          Caption = 'Ymin '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 135
          Top = 72
          Width = 43
          Height = 15
          Caption = 'Zmin, '#1084
          Color = clBtnFace
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label16: TLabel
          Left = 8
          Top = 8
          Width = 175
          Height = 13
          Caption = #1043#1088#1072#1085#1080#1094#1099' '#1079#1086#1085#1099' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' '#1089#1077#1095#1077#1085#1080#1081
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edDmax: TEdit
          Left = 5
          Top = 44
          Width = 60
          Height = 25
          Hint = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1076#1072#1083#1100#1085#1086#1089#1090#1100' '#1074#1080#1076#1080#1084#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = edDmaxChange
          OnMouseDown = ControlMouseDown
          OnMouseMove = pnRangeMouseMove
        end
        object edZmax: TEdit
          Left = 121
          Top = 45
          Width = 60
          Height = 25
          Hint = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1074#1099#1089#1086#1090#1072' '#1074#1080#1076#1080#1084#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnChange = edZmaxChange
          OnMouseDown = ControlMouseDown
          OnMouseMove = pnRangeMouseMove
        end
        object edDmin: TEdit
          Left = 5
          Top = 85
          Width = 60
          Height = 25
          Hint = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1072#1103' '#1076#1072#1083#1100#1085#1086#1089#1090#1100' '#1074#1080#1076#1080#1084#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnChange = edDminChange
          OnMouseDown = ControlMouseDown
          OnMouseMove = pnRangeMouseMove
        end
        object edZmin: TEdit
          Left = 121
          Top = 85
          Width = 60
          Height = 25
          Hint = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1072#1103' '#1074#1099#1089#1086#1090#1072' '#1074#1080#1076#1080#1084#1086#1081' '#1086#1073#1083#1072#1089#1090#1080
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnChange = edZminChange
          OnMouseDown = ControlMouseDown
          OnMouseMove = pnRangeMouseMove
        end
      end
      object tsHistory: TTabSheet
        Caption = #1048#1089#1090#1086#1088#1080#1103
        ImageIndex = 6
        object lsTransactions: TListBox
          Left = 0
          Top = 0
          Width = 215
          Height = 365
          Style = lbOwnerDrawFixed
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
          OnClick = PanelClick
          OnDblClick = lsTransactionsDblClick
          OnDrawItem = lsTransactionsDrawItem
        end
      end
    end
  end
  object Panel0: TPanel
    Left = 0
    Top = 25
    Width = 628
    Height = 407
    Align = alClient
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    OnCanResize = Panel0CanResize
    OnResize = Panel0Resize
    object Splitter2: TSplitter
      Left = 1
      Top = 179
      Width = 626
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Color = clGray
      MinSize = 5
      ParentColor = False
      OnCanResize = Splitter2CanResize
      OnMoved = Splitter1Moved
    end
    object PanelVert: TPanel
      Left = 1
      Top = 184
      Width = 626
      Height = 222
      Align = alBottom
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      object pnZRange: TPanel
        Left = 2
        Top = 2
        Width = 10
        Height = 218
        Hint = #1074#1099#1089#1086#1090#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
        Align = alLeft
        BevelOuter = bvNone
        Color = 13303754
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnMouseMove = pnRangeMouseMove
        object spZmax: TSplitter
          Left = 0
          Top = 88
          Width = 10
          Height = 10
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
          Top = 232
          Width = 10
          Height = 10
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
          Height = 50
          Align = alTop
          BevelOuter = bvNone
          Color = 15132415
          TabOrder = 0
          OnMouseMove = pnRangeMouseMove
        end
        object pnZmin: TPanel
          Left = 0
          Top = 170
          Width = 10
          Height = 48
          Align = alBottom
          BevelOuter = bvNone
          Color = 15132415
          TabOrder = 1
          OnMouseMove = pnRangeMouseMove
        end
      end
      object PanelZ: TPanel
        Left = 611
        Top = 2
        Width = 13
        Height = 218
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object sb_ScrollZ: TScrollBar
          Left = 1
          Top = 0
          Width = 12
          Height = 218
          Align = alRight
          Kind = sbVertical
          LargeChange = 25
          Max = 50
          Min = -50
          PageSize = 0
          SmallChange = 5
          TabOrder = 0
          OnChange = sb_ScrollZChange
          OnEnter = sb_ScrollZEnter
          OnExit = sb_ScrollZExit
          OnScroll = sb_ScrollScroll
        end
      end
    end
    object PanelHoriz: TPanel
      Left = 1
      Top = 1
      Width = 626
      Height = 178
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      object pnDRange: TPanel
        Left = 1
        Top = 1
        Width = 10
        Height = 163
        Hint = #1075#1083#1091#1073#1080#1085#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
        Align = alLeft
        BevelOuter = bvNone
        Color = 13303754
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnMouseMove = pnRangeMouseMove
        object spDMax: TSplitter
          Left = 0
          Top = 68
          Width = 10
          Height = 10
          Cursor = crSizeNS
          Hint = #1076#1072#1083#1100#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080
          Align = alNone
          AutoSnap = False
          Color = clRed
          MinSize = 1
          ParentColor = False
          ResizeStyle = rsUpdate
          OnMoved = spDmaxMoved
        end
        object spDmin: TSplitter
          Left = 0
          Top = 194
          Width = 10
          Height = 10
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
          Height = 50
          Align = alTop
          BevelOuter = bvNone
          Color = 15132415
          TabOrder = 0
          OnMouseMove = pnRangeMouseMove
        end
        object pnDmin: TPanel
          Left = 0
          Top = 113
          Width = 10
          Height = 50
          Align = alBottom
          BevelOuter = bvNone
          Color = 15132415
          TabOrder = 1
          OnMouseMove = pnRangeMouseMove
        end
      end
      object PanelX: TPanel
        Left = 1
        Top = 164
        Width = 624
        Height = 13
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object sb_ScrollX: TScrollBar
          Left = 0
          Top = 0
          Width = 611
          Height = 13
          Align = alClient
          LargeChange = 25
          Max = 50
          Min = -50
          PageSize = 0
          SmallChange = 5
          TabOrder = 0
          OnChange = sb_ScrollXChange
          OnEnter = sb_ScrollXEnter
          OnExit = sb_ScrollXExit
          OnScroll = sb_ScrollScroll
        end
        object Panel4: TPanel
          Left = 611
          Top = 0
          Width = 13
          Height = 13
          Align = alRight
          TabOrder = 1
          DesignSize = (
            13
            13)
          object s_but_CrossLine: TSpeedButton
            Left = 1
            Top = 0
            Width = 13
            Height = 12
            Hint = #1055#1086#1082#1072#1079' "'#1087#1077#1088#1077#1082#1088#1077#1089#1090#1100#1103'"  ('#1074#1080#1079#1080#1088#1085#1086#1075#1086' '#1091#1079#1083#1072')'
            AllowAllUp = True
            Anchors = []
            BiDiMode = bdLeftToRight
            GroupIndex = 1
            Glyph.Data = {
              D6000000424DD60000000000000076000000280000000C0000000C0000000100
              0400000000006000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              0000DDDDDDDDDDDD0000DDDDDDDDDDDD0000DDDD0DDDDDDD0000DDDDDDDDDDDD
              0000DDDD0DDDDDDD0000DDDDDDDDDDDD00000D0D0D0D0DDD0000DDDDDDDDDDDD
              0000DDDD0DDDDDDD0000DDDDDDDDDDDD0000DDDD0DDDDDDD0000}
            ParentShowHint = False
            ParentBiDiMode = False
            ShowHint = True
            OnClick = s_but_CrossLineClick
          end
        end
      end
      object PanelY: TPanel
        Left = 612
        Top = 1
        Width = 13
        Height = 163
        Hint = #1057#1084#1077#1097#1077#1085#1080#1077' '#1087#1086#1083#1103' '#1088#1080#1089#1086#1074#1072#1085#1080#1103
        Align = alRight
        BevelOuter = bvNone
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        object sb_ScrollY: TScrollBar
          Left = 1
          Top = 0
          Width = 12
          Height = 163
          Align = alRight
          Kind = sbVertical
          LargeChange = 25
          Max = 50
          Min = -50
          PageSize = 0
          SmallChange = 5
          TabOrder = 0
          OnChange = sb_ScrollYChange
          OnEnter = sb_ScrollYEnter
          OnExit = sb_ScrollYExit
          OnScroll = sb_ScrollScroll
        end
      end
      object pn_PointParam: TPanel
        Left = 31
        Top = -4
        Width = 154
        Height = 66
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        object Label17: TLabel
          Left = 11
          Top = 5
          Width = 22
          Height = 15
          Caption = 'X, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 59
          Top = 5
          Width = 22
          Height = 15
          Caption = 'Y, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 109
          Top = 5
          Width = 22
          Height = 15
          Caption = 'Z, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lb_ID: TLabel
          Left = 154
          Top = 24
          Width = 6
          Height = 13
          Caption = '0'
        end
        object SpeedButton3: TSpeedButton
          Left = 118
          Top = 44
          Width = 23
          Height = 22
          Hint = #1055#1088#1080#1085#1103#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Glyph.Data = {
            06020000424D0602000000000000760000002800000019000000190000000100
            0400000000009001000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            AAAFFFFFFFFFF0000000FFFFFFFFFFFFAAAFFFFFFFFFF0000000FFFFFFFFFFFA
            AAAFFFFFFFFFF0000000FFFFFFFFFAAAAFAAFFFFFFFFF0000000FFFFFFFFAAAA
            FFAAFFFFFFFFF0000000FFFFFFFAAAFFFFFAAFFFFFFFF0000000FFFFFFAAAFFF
            FFFAAFFFFFFFF0000000FFFFFAAAFFFFFFFAAFFFFFFFF0000000FFFFFAAFFFFF
            FFFFAAFFFFFFF0000000FFFFFFFFFFFFFFFFAAFFFFFFF0000000FFFFFFFFFFFF
            FFFFFAAFFFFFF0000000FFFFFFFFFFFFFFFFFAAFFFFFF0000000FFFFFFFFFFFF
            FFFFFFAAFFFFF0000000FFFFFFFFFFFFFFFFFFAAFFFFF0000000FFFFFFFFFFFF
            FFFFFFAAFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton1Click
        end
        object ed_Y: TEdit
          Tag = 2
          Left = 52
          Top = 20
          Width = 41
          Height = 21
          TabOrder = 1
          OnDblClick = ed_YDblClick
          OnKeyPress = ed_PointChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_X: TEdit
          Tag = 1
          Left = 6
          Top = 20
          Width = 41
          Height = 21
          TabOrder = 0
          OnDblClick = ed_YDblClick
          OnKeyPress = ed_PointChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_Z: TEdit
          Tag = 3
          Left = 98
          Top = 20
          Width = 44
          Height = 21
          TabOrder = 2
          OnDblClick = ed_YDblClick
          OnKeyPress = ed_PointChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
      end
      object pn_AreaParam: TPanel
        Left = 201
        Top = -11
        Width = 216
        Height = 110
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object lb_AreaZmax: TLabel
          Left = 89
          Top = 10
          Width = 40
          Height = 13
          Caption = 'Zmax ,'#1084
          Color = clActiveBorder
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lb_AreaZmin: TLabel
          Left = 6
          Top = 10
          Width = 34
          Height = 13
          Caption = 'Zmin,'#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lb_TopLinesCount: TLabel
          Left = 110
          Top = 30
          Width = 86
          Height = 13
          Caption = 'lb_TopLinesCount'
        end
        object lb_BottomLinesCount: TLabel
          Left = 4
          Top = 30
          Width = 100
          Height = 13
          Caption = 'lb_BottomLinesCount'
        end
        object lb_Volums: TLabel
          Left = 6
          Top = 45
          Width = 48
          Height = 13
          Caption = 'lb_Volums'
        end
        object lb_AreaSize1: TLabel
          Left = 4
          Top = 64
          Width = 62
          Height = 13
          Caption = #1064#1080#1088#1080#1085#1072' ,'#1084' ='
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -9
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 6
          Top = 88
          Width = 101
          Height = 13
          Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1096#1080#1088#1080#1085#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -9
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ed_MinZ: TEdit
          Tag = 1
          Left = 42
          Top = 6
          Width = 42
          Height = 21
          TabOrder = 0
          OnKeyPress = ed_AreaChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_MaxZ: TEdit
          Tag = 2
          Left = 131
          Top = 6
          Width = 41
          Height = 21
          TabOrder = 1
          OnKeyPress = ed_AreaChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_AreaSize1: TEdit
          Tag = 3
          Left = 67
          Top = 61
          Width = 41
          Height = 21
          TabOrder = 2
          OnKeyPress = ed_AreaChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object chbChangeWidthDirection: TComboBox
          Left = 111
          Top = 83
          Width = 84
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 3
          Text = #1054#1090' '#1094#1077#1085#1090#1088#1072
          OnChange = chbChangeLengthDirectionChange
          Items.Strings = (
            #1054#1090' '#1094#1077#1085#1090#1088#1072
            #1057#1083#1077#1074#1072
            #1057#1087#1088#1072#1074#1072
            #1057#1074#1077#1088#1093#1091
            #1057#1085#1080#1079#1091)
        end
      end
      object pn_LineParam: TPanel
        Left = 12
        Top = 57
        Width = 203
        Height = 110
        BevelInner = bvRaised
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        object lb_ID0: TLabel
          Left = 161
          Top = 20
          Width = 17
          Height = 13
          Caption = 'ID -'
          Color = 14408667
          ParentColor = False
        end
        object lb_ID1: TLabel
          Left = 162
          Top = 40
          Width = 17
          Height = 13
          Caption = 'ID -'
          Color = 14408667
          ParentColor = False
        end
        object lb_Len: TLabel
          Left = 1
          Top = 66
          Width = 53
          Height = 13
          Caption = #1044#1083#1080#1085#1072', '#1084'='
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Image1: TImage
          Left = 112
          Top = 63
          Width = 32
          Height = 32
          AutoSize = True
          Picture.Data = {
            055449636F6E0000010001001010100000000000280100001600000028000000
            10000000200000000100040000000000C0000000000000000000000000000000
            0000000000000000000080000080000000808000800000008000800080800000
            80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
            FFFFFF0000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000FFFF0000FFFF0000FFE70000876F00007AAF000079AF000085FF0000
            FDEF0000FEEF0000FEFF0000FECF0000FEB70000FFB70000FFCF0000FFFF0000
            FFFF0000}
          Stretch = True
        end
        object Label13: TLabel
          Left = 11
          Top = 2
          Width = 22
          Height = 15
          Caption = 'X, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 64
          Top = 2
          Width = 22
          Height = 15
          Caption = 'Y, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 120
          Top = 2
          Width = 22
          Height = 15
          Caption = 'Z, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lb_Equal: TLabel
          Left = 128
          Top = 65
          Width = 6
          Height = 13
          Caption = '='
        end
        object Label2: TLabel
          Left = 4
          Top = 89
          Width = 93
          Height = 13
          Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1076#1083#1080#1085#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SpeedButton1: TSpeedButton
          Left = 165
          Top = 60
          Width = 23
          Height = 22
          Hint = #1055#1088#1080#1085#1103#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Glyph.Data = {
            06020000424D0602000000000000760000002800000019000000190000000100
            0400000000009001000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            AAAFFFFFFFFFF0000000FFFFFFFFFFFFAAAFFFFFFFFFF0000000FFFFFFFFFFFA
            AAAFFFFFFFFFF0000000FFFFFFFFFAAAAFAAFFFFFFFFF0000000FFFFFFFFAAAA
            FFAAFFFFFFFFF0000000FFFFFFFAAAFFFFFAAFFFFFFFF0000000FFFFFFAAAFFF
            FFFAAFFFFFFFF0000000FFFFFAAAFFFFFFFAAFFFFFFFF0000000FFFFFAAFFFFF
            FFFFAAFFFFFFF0000000FFFFFFFFFFFFFFFFAAFFFFFFF0000000FFFFFFFFFFFF
            FFFFFAAFFFFFF0000000FFFFFFFFFFFFFFFFFAAFFFFFF0000000FFFFFFFFFFFF
            FFFFFFAAFFFFF0000000FFFFFFFFFFFFFFFFFFAAFFFFF0000000FFFFFFFFFFFF
            FFFFFFAAFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton1Click
        end
        object ed_X0: TEdit
          Tag = 1
          Left = 2
          Top = 15
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_Y0: TEdit
          Tag = 2
          Left = 57
          Top = 15
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 1
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_X1: TEdit
          Tag = 4
          Left = 2
          Top = 36
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 2
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_Y1: TEdit
          Tag = 5
          Left = 57
          Top = 36
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          TabOrder = 3
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_Z0: TEdit
          Tag = 3
          Left = 112
          Top = 15
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 4
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_Z1: TEdit
          Tag = 6
          Left = 112
          Top = 36
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 5
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_Length: TEdit
          Tag = 7
          Left = 57
          Top = 62
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 6
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_ZAngle: TEdit
          Tag = 8
          Left = 132
          Top = 61
          Width = 28
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 7
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object chbChangeLengthDirection: TComboBox
          Left = 105
          Top = 85
          Width = 84
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 8
          Text = #1054#1090' '#1094#1077#1085#1090#1088#1072
          OnChange = chbChangeLengthDirectionChange
          Items.Strings = (
            #1054#1090' '#1094#1077#1085#1090#1088#1072
            #1057#1083#1077#1074#1072
            #1057#1087#1088#1072#1074#1072
            #1057#1074#1077#1088#1093#1091
            #1057#1085#1080#1079#1091)
        end
      end
      object pn_VolumeParam: TPanel
        Left = 155
        Top = 75
        Width = 238
        Height = 70
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        object lb_AreasCount: TLabel
          Left = 5
          Top = 31
          Width = 69
          Height = 13
          Caption = 'lb_AreasCount'
        end
        object lb_TopAreasCount: TLabel
          Left = 5
          Top = 50
          Width = 88
          Height = 13
          Caption = 'lb_TopAreasCount'
        end
        object lb_BottomAreasCount: TLabel
          Left = 96
          Top = 50
          Width = 102
          Height = 13
          Caption = 'lb_BottomAreasCount'
        end
        object ld_AreaMaxZ: TLabel
          Left = 87
          Top = 10
          Width = 38
          Height = 13
          Caption = 'MaxZ,'#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lb_AreaMinZ: TLabel
          Left = 4
          Top = 11
          Width = 35
          Height = 13
          Caption = 'MinZ,'#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SpeedButton2: TSpeedButton
          Left = 151
          Top = 28
          Width = 23
          Height = 22
          Hint = #1055#1088#1080#1085#1103#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Glyph.Data = {
            06020000424D0602000000000000760000002800000019000000190000000100
            0400000000009001000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            AAAFFFFFFFFFF0000000FFFFFFFFFFFFAAAFFFFFFFFFF0000000FFFFFFFFFFFA
            AAAFFFFFFFFFF0000000FFFFFFFFFAAAAFAAFFFFFFFFF0000000FFFFFFFFAAAA
            FFAAFFFFFFFFF0000000FFFFFFFAAAFFFFFAAFFFFFFFF0000000FFFFFFAAAFFF
            FFFAAFFFFFFFF0000000FFFFFAAAFFFFFFFAAFFFFFFFF0000000FFFFFAAFFFFF
            FFFFAAFFFFFFF0000000FFFFFFFFFFFFFFFFAAFFFFFFF0000000FFFFFFFFFFFF
            FFFFFAAFFFFFF0000000FFFFFFFFFFFFFFFFFAAFFFFFF0000000FFFFFFFFFFFF
            FFFFFFAAFFFFF0000000FFFFFFFFFFFFFFFFFFAAFFFFF0000000FFFFFFFFFFFF
            FFFFFFAAFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton1Click
        end
        object Label12: TLabel
          Left = 176
          Top = 10
          Width = 25
          Height = 13
          Caption = 'H,'#1084'='
        end
        object lb_Height: TLabel
          Left = 203
          Top = 11
          Width = 45
          Height = 13
          Caption = 'lb_Height'
        end
        object ed_VolumeMinZ: TEdit
          Tag = 1
          Left = 42
          Top = 6
          Width = 41
          Height = 21
          TabOrder = 0
          OnKeyPress = ed_VolumeChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_VolumeMaxZ: TEdit
          Tag = 2
          Left = 128
          Top = 6
          Width = 41
          Height = 21
          TabOrder = 1
          OnKeyPress = ed_VolumeChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
      end
      object pn_LabelParam: TPanel
        Left = 402
        Top = 112
        Width = 213
        Height = 84
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 7
        object lb_Label: TLabel
          Left = 3
          Top = 5
          Width = 63
          Height = 15
          Caption = ' '#1080#1084#1103' '#1084#1077#1090#1082#1080
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object ed_Name: TEdit
          Tag = 1
          Left = 6
          Top = 20
          Width = 203
          Height = 21
          TabOrder = 0
          OnKeyPress = ed_NameKeyPress
          OnMouseDown = ControlMouseDown
        end
      end
      object pn_ImageRectParam: TPanel
        Left = 396
        Top = 9
        Width = 203
        Height = 110
        BevelInner = bvRaised
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        object lb_IID0: TLabel
          Left = 161
          Top = 20
          Width = 17
          Height = 13
          Caption = 'ID -'
          Color = 14408667
          ParentColor = False
        end
        object lb_IID1: TLabel
          Left = 162
          Top = 40
          Width = 17
          Height = 13
          Caption = 'ID -'
          Color = 14408667
          ParentColor = False
        end
        object Label22: TLabel
          Left = 3
          Top = 64
          Width = 90
          Height = 13
          Caption = #1053#1077#1087#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100'='
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 11
          Top = 2
          Width = 22
          Height = 15
          Caption = 'X, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label24: TLabel
          Left = 64
          Top = 2
          Width = 22
          Height = 15
          Caption = 'Y, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label25: TLabel
          Left = 120
          Top = 2
          Width = 22
          Height = 15
          Caption = 'Z, '#1084
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object SpeedButton4: TSpeedButton
          Left = 165
          Top = 60
          Width = 23
          Height = 22
          Hint = #1055#1088#1080#1085#1103#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Glyph.Data = {
            06020000424D0602000000000000760000002800000019000000190000000100
            0400000000009001000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            AAAFFFFFFFFFF0000000FFFFFFFFFFFFAAAFFFFFFFFFF0000000FFFFFFFFFFFA
            AAAFFFFFFFFFF0000000FFFFFFFFFAAAAFAAFFFFFFFFF0000000FFFFFFFFAAAA
            FFAAFFFFFFFFF0000000FFFFFFFAAAFFFFFAAFFFFFFFF0000000FFFFFFAAAFFF
            FFFAAFFFFFFFF0000000FFFFFAAAFFFFFFFAAFFFFFFFF0000000FFFFFAAFFFFF
            FFFFAAFFFFFFF0000000FFFFFFFFFFFFFFFFAAFFFFFFF0000000FFFFFFFFFFFF
            FFFFFAAFFFFFF0000000FFFFFFFFFFFFFFFFFAAFFFFFF0000000FFFFFFFFFFFF
            FFFFFFAAFFFFF0000000FFFFFFFFFFFFFFFFFFAAFFFFF0000000FFFFFFFFFFFF
            FFFFFFAAFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
            FFFFFFFFFFFFF0000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton1Click
        end
        object ed_IX0: TEdit
          Tag = 1
          Left = 2
          Top = 15
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_IY0: TEdit
          Tag = 2
          Left = 57
          Top = 15
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 1
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_IX1: TEdit
          Tag = 4
          Left = 2
          Top = 36
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 2
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_IY1: TEdit
          Tag = 5
          Left = 57
          Top = 36
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          TabOrder = 3
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_IZ0: TEdit
          Tag = 3
          Left = 112
          Top = 15
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 4
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_IZ1: TEdit
          Tag = 6
          Left = 112
          Top = 36
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 5
          OnDblClick = ed_CoordDblClick
          OnKeyPress = ed_LineChangeKeyPress
          OnMouseDown = ControlMouseDown
        end
        object ed_Alpha: TEdit
          Tag = 7
          Left = 94
          Top = 60
          Width = 47
          Height = 21
          BevelInner = bvNone
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 6
          OnKeyPress = ed_AlphaKeyPress
          OnMouseDown = ControlMouseDown
        end
      end
    end
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Color = -1638426
    Left = 344
  end
  object PopupMenu1: TPopupMenu
    Left = 426
    object miEdit1: TMenuItem
      Tag = -1
      Caption = 'miEdit'
      ShortCut = 115
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
  object pm_sbZAngle: TPopupMenu
    Left = 400
    object mi_IntrvAngele: TMenuItem
      Caption = #1096#1072#1075' '#1091#1075#1083#1072'        ('#1075#1088#1072#1076')'
      OnClick = mi_IntrvAngeleClick
    end
    object N2: TMenuItem
      Caption = #1096#1072#1075' '#1074#1099#1089#1086#1090#1099'     ('#1084')'
    end
    object N3: TMenuItem
      Caption = #1096#1072#1075' '#1090#1086#1083#1097#1080#1085#1099'  ('#1089#1084')'
    end
  end
  object pmMinmaxD: TPopupMenu
    Left = 488
    object mi_MinmaxD: TMenuItem
      Caption = #1096#1072#1075' Dmax Dmin  ('#1084')'
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
    Left = 520
    object mi_IntervalDZ_2: TMenuItem
      Caption = #1096#1072#1075' D/Zmax D/Z min  ('#1084')'
    end
    object mi_IntervalZ: TMenuItem
      Caption = #1096#1072#1075' Zmax Zmin  ('#1084')'
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
  object pm_Layers: TPopupMenu
    Left = 552
    object mi_AddLayer: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1083#1086#1081
      ShortCut = 45
      OnClick = CreateLayer
    end
    object mi_DeleteLayer: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1083#1086#1081
      ShortCut = 46
      OnClick = DelLayerClick
    end
    object N7: TMenuItem
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1089#1083#1086#1080
      OnClick = btJoinLayerClick
    end
    object N8: TMenuItem
      Caption = #1057#1076#1077#1083#1072#1090#1100' '#1089#1083#1086#1081' '#1090#1077#1082#1091#1097#1080#1084
      OnClick = bt_SetCurLayerClick
    end
    object N9: TMenuItem
      Caption = #1042#1089#1077' '#1089#1083#1086#1080' '#1074#1080#1076#1080#1084#1099#1077' ('#1074#1099#1076#1077#1083#1103#1077#1084#1099#1077')'
      OnClick = bt_SetAllClick
    end
    object N10: TMenuItem
      Caption = #1058#1086#1083#1100#1082#1086' '#1086#1076#1080#1085' '#1089#1083#1086#1080' '#1074#1080#1076#1080#1084#1099#1081' ('#1074#1099#1076#1077#1083#1103#1077#1084#1099#1081')'
      OnClick = bt_SetOneClick
    end
    object mi_RenameLayer: TMenuItem
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1089#1083#1086#1081
      ShortCut = 16462
      OnClick = mi_RenameLayerClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object miPalette: TMenuItem
      Caption = 'C'#1082#1088#1099#1090#1100' '#1087#1072#1085#1077#1083#1100
      OnClick = miPaletteClick
    end
  end
  object pm_Views: TPopupMenu
    Left = 582
    object mi_AddView: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1080#1076
      ShortCut = 45
      OnClick = tbAddViewClck
    end
    object mi_DelView: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1080#1076
      ShortCut = 46
      OnClick = btDelViewClick
    end
    object mi_RenameView: TMenuItem
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1074#1080#1076
      ShortCut = 16462
      OnClick = mi_RenameViewClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = #1057#1082#1088#1099#1090#1100' '#1087#1072#1085#1077#1083#1100
    end
  end
  object ImageList1: TImageList
    Left = 320
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000084000000840000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000084000000840000000000848484008484
      840084848400000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00008400000084000000840000008400000084000000840000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000084000000840000000000848484008484
      8400848484000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00008400000084000000000000000000000084000000840000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FF0000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000084000000840000000000848484008484
      84008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00008400000084000000000000000000000000000000000000008400000084
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FF000000FF00
      0000000000000000000000000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00008400000084000000000000000000000000000000000000008400000084
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FF000000FF00
      00000000000000000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF000000000000FF000000FF000000FF00000000000000840084008400
      840084008400000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00008400000084000000000000000000000084000000840000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FF000000FF00
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF000000000000FF000000FF000000FF00000000000000840084008400
      840084008400000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00008400000084000000840000008400000084000000840000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF000000000000FF000000FF000000FF00000000000000840084008400
      8400840084000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000084000000840000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000FFFF0000FFFF0000FFFF000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000FFFF0000FFFF0000FFFF000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000FFFF0000FFFF0000FFFF000000000000FF000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
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
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF0000000000000000000000000000
      000000000000000000000000000000000000000000000000FFFF000000000000
      FFFF000000000000000000000000000000000000000000000000000000000000
      FFFF000000000000FFFF00000000000000000000000000000000000000000000
      FFFF0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0904FFFF
      F81FFFEF09048003E007FFC7FFFFB803C003FF83FFFFB8038001DF070381B803
      0000CE0F038180038001CC1FFFFF8003C003C83FFFFF8003C003C07F33338003
      E007C0FF33338003F81FC1FFFFFF8003FFFFC03FFFFF8003FFFFC01F00008003
      FFFFFFFF00008003FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object OpenDialog1: TOpenDialog
    Filter = 'AutoCad (*.dxf)|*.dxf'
    Left = 368
  end
  object pmRapair: TPopupMenu
    Left = 400
    object miRepairAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1074#1103#1079#1100
      OnClick = miRepairAddClick
    end
    object miCreateLink: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1089#1074#1103#1079#1100
      Visible = False
    end
    object miRepairRemove: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1074#1103#1079#1100
      OnClick = miRepairRemoveClick
    end
    object miRepairSelect: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100
      OnClick = miRepairSelectClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 56
    Top = 16
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer2Timer
    Left = 136
    Top = 8
  end
end
