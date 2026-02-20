inherited PriceControl: TPriceControl
  Left = 0
  Top = 95
  Caption = 'PriceControl'
  ClientHeight = 421
  ClientWidth = 804
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 336
    Align = alClient
    TabOrder = 0
    object PriceTable: TStringGrid
      Left = 1
      Top = 1
      Width = 802
      Height = 334
      Align = alClient
      ColCount = 6
      FixedCols = 0
      RowCount = 3
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColMoving]
      TabOrder = 0
      ColWidths = (
        327
        88
        89
        87
        89
        82)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 336
    Width = 804
    Height = 85
    Align = alBottom
    TabOrder = 1
    object L1: TLabel
      Left = 4
      Top = 8
      Width = 205
      Height = 13
      Caption = 'C'#1090#1086#1080#1084#1086#1089#1090#1100' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103', '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' ='
    end
    object lSumm0: TLabel
      Left = 211
      Top = 8
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lSumm: TLabel
      Left = 211
      Top = 68
      Width = 6
      Height = 13
      Caption = '0'
    end
    object L2: TLabel
      Left = 4
      Top = 24
      Width = 157
      Height = 13
      Caption = 'C'#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1086#1085#1090#1072#1078#1085#1099#1093' '#1088#1072#1073#1086#1090' ='
    end
    object Label2: TLabel
      Left = 4
      Top = 66
      Width = 98
      Height = 13
      Caption = #1054#1073#1097#1103#1103' '#1089#1090#1086#1080#1084#1086#1089#1090#1100'='
    end
    object lSumm1: TLabel
      Left = 211
      Top = 25
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label1: TLabel
      Left = 306
      Top = 8
      Width = 201
      Height = 13
      Caption = 'C'#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1080' ='
    end
    object lSumm3: TLabel
      Left = 512
      Top = 8
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label7: TLabel
      Left = 307
      Top = 28
      Width = 221
      Height = 34
      AutoSize = False
      Caption = 
        'C'#1090#1086#1080#1084#1086#1089#1090#1100' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1086'-'#1079#1072#1075#1086#1090#1086#1074#1080#1090#1077#1083#1100#1085#1099#1093',  '#1089#1082#1083#1072#1076#1089#1082#1080#1093' '#1088#1072#1073#1086#1090' '#1080' '#1074#1093#1086#1076#1085#1086 +
        #1075#1086' '#1082#1086#1085#1090#1088#1086#1083#1103' ='
      WordWrap = True
    end
    object lSumm4: TLabel
      Left = 512
      Top = 42
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Bevel1: TBevel
      Left = 6
      Top = 57
      Width = 612
      Height = 2
    end
    object Label6: TLabel
      Left = 4
      Top = 40
      Width = 191
      Height = 13
      Caption = 'C'#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1091#1089#1082#1086'-'#1085#1072#1083#1072#1076#1086#1095#1085#1099#1093' '#1088#1072#1073#1086#1090' ='
    end
    object lSumm2: TLabel
      Left = 211
      Top = 41
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label8: TLabel
      Left = 631
      Top = 3
      Width = 200
      Height = 26
      AutoSize = False
      Caption = #1069#1090#1072#1087' '#1084#1086#1076#1077#1088#1085#1080#1079#1072#1094#1080#1080',  '#1076#1083#1103'          '#1082#1086#1090#1086#1088#1086#1075#1086' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' '#1088#1072#1089#1095#1077#1090
      WordWrap = True
    end
    object Bevel2: TBevel
      Left = 617
      Top = 5
      Width = 1
      Height = 53
    end
    object Bevel3: TBevel
      Left = 302
      Top = 9
      Width = 1
      Height = 52
    end
    object B1: TButton
      Left = 631
      Top = 60
      Width = 76
      Height = 25
      Caption = #1055#1077#1088#1077#1088#1072#1089#1095#1077#1090
      TabOrder = 0
      OnClick = B1Click
    end
    object BKoef: TButton
      Left = 712
      Top = 60
      Width = 76
      Height = 25
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099'...'
      TabOrder = 1
      OnClick = BKoefClick
    end
    object chbModificationStage: TComboBox
      Left = 631
      Top = 31
      Width = 160
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = '1 '#1101#1090#1072#1087' '#1084#1086#1076#1077#1088#1085#1080#1079#1072#1094#1080#1080
      OnChange = chbModificationStageChange
      Items.Strings = (
        '1 '#1101#1090#1072#1087' '#1084#1086#1076#1077#1088#1085#1080#1079#1072#1094#1080#1080
        '2 '#1101#1090#1072#1087' '#1084#1086#1076#1077#1088#1085#1080#1079#1072#1094#1080#1080
        '3 '#1101#1090#1072#1087' '#1084#1086#1076#1077#1088#1085#1080#1079#1072#1094#1080#1080)
    end
  end
end
