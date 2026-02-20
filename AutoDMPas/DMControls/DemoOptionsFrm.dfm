object fmDemoOptions: TfmDemoOptions
  Left = 301
  Top = 131
  Width = 299
  Height = 281
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1095#1077#1073#1085#1086#1075#1086' '#1082#1091#1088#1089#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 32
    Top = 80
    Width = 185
    Height = 16
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1082#1091#1088#1089#1086#1088#1072
  end
  object Label2: TLabel
    Left = 35
    Top = 146
    Width = 127
    Height = 16
    Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1087#1072#1091#1079
  end
  object chbSpeech: TCheckBox
    Left = 32
    Top = 24
    Width = 209
    Height = 17
    Caption = #1043#1086#1083#1086#1089#1086#1074#1086#1077' '#1089#1086#1087#1088#1086#1074#1086#1078#1076#1077#1085#1080#1077
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object chbShowText: TCheckBox
    Left = 32
    Top = 48
    Width = 209
    Height = 17
    Caption = #1055#1086#1103#1089#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1090#1077#1082#1089#1090
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object trCursorSpeed: TTrackBar
    Left = 23
    Top = 97
    Width = 242
    Height = 45
    Max = 20
    Min = -20
    Orientation = trHorizontal
    Frequency = 1
    Position = 0
    SelEnd = 0
    SelStart = 0
    TabOrder = 2
    TickMarks = tmBottomRight
    TickStyle = tsAuto
  end
  object trPauseInterval: TTrackBar
    Left = 24
    Top = 163
    Width = 241
    Height = 45
    Max = 2500
    Min = 500
    Orientation = trHorizontal
    Frequency = 100
    Position = 1500
    SelEnd = 0
    SelStart = 0
    TabOrder = 3
    TickMarks = tmBottomRight
    TickStyle = tsAuto
  end
  object btOK: TButton
    Left = 40
    Top = 216
    Width = 91
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btCancel: TButton
    Left = 156
    Top = 215
    Width = 93
    Height = 25
    Cancel = True
    Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103
    ModalResult = 2
    TabOrder = 5
  end
end
