inherited BattleControl: TBattleControl
  Left = -9
  Top = 123
  Caption = 'BattleControl'
  ClientHeight = 448
  ClientWidth = 804
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 72
    Align = alTop
    TabOrder = 0
    OnResize = Panel1Resize
    object Label2: TLabel
      Left = 7
      Top = 43
      Width = 103
      Height = 13
      Caption = #1058#1086#1095#1082#1072' '#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1103':'
    end
    object LStartElement: TLabel
      Left = 119
      Top = 43
      Width = 226
      Height = 23
      AutoSize = False
      Caption = #1085#1077' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1072
      WordWrap = True
    end
    object Label3: TLabel
      Left = 6
      Top = 4
      Width = 103
      Height = 20
      Caption = #1052#1086#1076#1077#1083#1100' '#1073#1086#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 28
      Width = 90
      Height = 13
      Caption = #1042#1072#1088#1080#1072#1085#1090' '#1072#1085#1072#1083#1080#1079#1072':'
    end
    object LFacilityState: TLabel
      Left = 119
      Top = 28
      Width = 69
      Height = 13
      Caption = #1085#1077' '#1086#1087#1088#1077#1076#1077#1083#1077#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 351
      Top = 33
      Width = 83
      Height = 13
      Caption = #1058#1077#1082#1091#1097#1077#1077' '#1074#1088#1077#1084#1103':'
    end
    object LCurrentTime: TLabel
      Left = 441
      Top = 34
      Width = 6
      Height = 13
      Caption = '0'
    end
    object btRestart: TButton
      Left = 372
      Top = 6
      Width = 105
      Height = 24
      Caption = #1050' '#1085#1072#1095#1072#1083#1091' '#1072#1085#1072#1083#1080#1079#1072
      TabOrder = 0
      OnClick = btRestartClick
    end
    object btNextStep: TButton
      Left = 622
      Top = 7
      Width = 152
      Height = 24
      Caption = #1057#1083#1077#1076#1091#1102#1097#1080#1081' '#1096#1072#1075' '#1072#1085#1072#1083#1080#1079#1072
      Enabled = False
      TabOrder = 1
      OnClick = btNextStepClick
    end
    object btCalc: TButton
      Left = 491
      Top = 7
      Width = 118
      Height = 24
      Caption = #1044#1086' '#1082#1086#1085#1094#1072' '#1072#1085#1072#1083#1080#1079#1072
      Enabled = False
      TabOrder = 2
      OnClick = btCalcClick
    end
    object btSuccess: TButton
      Left = 622
      Top = 36
      Width = 152
      Height = 24
      Caption = #1056#1072#1089#1095#1077#1090' '#1091#1089#1087#1077#1093#1072' '#1085#1072' '#1084#1072#1088#1096#1088#1091#1090#1077
      TabOrder = 3
      OnClick = btSuccessClick
    end
    object btGrTab: TButton
      Left = 491
      Top = 37
      Width = 118
      Height = 24
      Caption = #1043#1088#1072#1092#1080#1082
      TabOrder = 4
      OnClick = btGrTabClick
    end
    object cbShowMovment: TCheckBox
      Left = 333
      Top = 48
      Width = 140
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1076#1074#1080#1078#1077#1085#1080#1077
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 72
    Width = 804
    Height = 376
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    Visible = False
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 802
      Height = 374
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Alignment = taLeftJustify
      Title.Text.Strings = (
        '')
      BottomAxis.Automatic = False
      BottomAxis.AutomaticMinimum = False
      BottomAxis.Title.Caption = #1042#1088#1077#1084#1103
      BottomAxis.Title.Font.Charset = RUSSIAN_CHARSET
      BottomAxis.Title.Font.Color = clBlack
      BottomAxis.Title.Font.Height = -13
      BottomAxis.Title.Font.Name = 'Arial'
      BottomAxis.Title.Font.Style = []
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.ExactDateTime = False
      LeftAxis.Increment = 0.1
      LeftAxis.Maximum = 1.1
      LeftAxis.Title.Font.Charset = RUSSIAN_CHARSET
      LeftAxis.Title.Font.Color = clBlack
      LeftAxis.Title.Font.Height = -13
      LeftAxis.Title.Font.Name = 'Arial'
      LeftAxis.Title.Font.Style = []
      Legend.Color = clSilver
      Legend.DividingLines.Width = 4
      Legend.Font.Charset = RUSSIAN_CHARSET
      Legend.Font.Color = clBlack
      Legend.Font.Height = -13
      Legend.Font.Name = 'Arial'
      Legend.Font.Style = []
      Legend.LegendStyle = lsSeries
      RightAxis.Visible = False
      TopAxis.Visible = False
      View3D = False
      View3DOptions.Perspective = 10
      View3DOptions.Zoom = 112
      Align = alClient
      TabOrder = 0
      object btCopy: TButton
        Left = 488
        Top = 1
        Width = 121
        Height = 25
        Caption = #1042' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
        TabOrder = 0
        OnClick = btCopyClick
      end
      object cbChartType: TComboBox
        Left = 32
        Top = 8
        Width = 242
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = #1057#1088#1077#1076#1085#1077#1077' '#1095#1080#1089#1083#1086' '#1074#1099#1078#1080#1074#1096#1080#1093
        OnChange = cbChartTypeChange
        Items.Strings = (
          #1057#1088#1077#1076#1085#1077#1077' '#1095#1080#1089#1083#1086' '#1074#1099#1078#1080#1074#1096#1080#1093
          #1042#1088#1077#1084#1103', '#1079#1072#1090#1088#1072#1095#1077#1085#1085#1086#1077' '#1085#1072' '#1076#1074#1080#1078#1077#1085#1080#1077' '#1082' '#1094#1077#1083#1080', '#1084#1080#1085
          #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1074#1099#1078#1080#1074#1072#1085#1080#1103' '#1093#1086#1090#1103' '#1073#1099' '#1086#1076#1085#1086#1075#1086)
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 72
    Width = 804
    Height = 376
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 384
      Top = 1
      Width = 7
      Height = 374
      Cursor = crHSplit
      AutoSnap = False
    end
    object sgGuards: TStringGrid
      Left = 1
      Top = 1
      Width = 383
      Height = 374
      Align = alLeft
      ColCount = 3
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 0
      OnSelectCell = sgGuardsSelectCell
      ColWidths = (
        152
        63
        64)
    end
    object sgAdversaries: TStringGrid
      Left = 391
      Top = 1
      Width = 412
      Height = 374
      Align = alClient
      ColCount = 3
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 1
      ColWidths = (
        185
        60
        53)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 280
    Top = 16
  end
end
