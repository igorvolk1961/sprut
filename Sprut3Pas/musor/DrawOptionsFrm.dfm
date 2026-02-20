object frmDrawOptions: TfrmDrawOptions
  Left = 196
  Top = 43
  Width = 581
  Height = 558
  Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1101#1083#1077#1082#1090#1088#1086#1085#1085#1086#1075#1086' '#1087#1083#1072#1085#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbShowOptimalPathFromStart: TCheckBox
    Left = 16
    Top = 8
    Width = 361
    Height = 17
    Caption = #1054#1087#1090#1080#1084#1072#1083#1100#1085#1099#1081' '#1084#1072#1088#1097#1088#1091#1090' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081' '#1086#1090' '#1089#1090#1072#1088#1090#1072' '#1076#1086' '#1094#1077#1083#1080
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object cbShowOptimalPathFromBoundary: TCheckBox
    Left = 16
    Top = 28
    Width = 409
    Height = 17
    Caption = #1054#1087#1090#1080#1084#1072#1083#1100#1085#1099#1081' '#1084#1072#1088#1096#1088#1091#1090' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081' '#1086#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1088#1091#1073#1077#1078#1072' '#1076#1086' '#1094#1077#1083#1080
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object rgRenderAreas: TRadioGroup
    Left = 8
    Top = 277
    Width = 313
    Height = 153
    Caption = #1047#1072#1082#1088#1072#1089#1082#1072' '#1086#1073#1083#1072#1089#1090#1077#1081
    ItemIndex = 1
    Items.Strings = (
      #1053#1077' '#1079#1072#1082#1088#1072#1096#1080#1074#1072#1090#1100' '#1086#1073#1083#1072#1089#1090#1080
      #1047#1072#1082#1088#1072#1089#1080#1090#1100' '#1086#1073#1083#1072#1089#1090#1080' '#1103#1074#1085#1086' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1094#1074#1077#1090#1086#1084
      #1055#1086#1083#1077' '#1074#1077#1088#1086#1103#1090#1085#1086#1089#1090#1080' '#1091#1089#1087#1077#1093#1072' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081
      #1055#1086#1083#1077' '#1074#1088#1077#1084#1077#1085#1080' '#1079#1072#1076#1077#1088#1078#1082#1080' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081
      #1055#1086#1083#1077' '#1074#1077#1088#1086#1103#1090#1085#1086#1089#1090#1080' '#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1103' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081
      #1055#1086#1083#1077' '#1074#1088#1077#1084#1077#1085#1080' '#1087#1088#1080#1073#1099#1090#1080#1103' '#1086#1093#1088#1072#1085#1099)
    TabOrder = 2
  end
  object cbShowFastPathFromBoundary: TCheckBox
    Left = 16
    Top = 47
    Width = 413
    Height = 17
    Caption = #1057#1072#1084#1099#1081' '#1073#1099#1089#1090#1088#1099#1081' '#1084#1072#1088#1096#1088#1091#1090' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081' '#1086#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1088#1091#1073#1077#1078#1072' '#1076#1086' '#1094#1077#1083#1080
    TabOrder = 3
  end
  object cbShowStealthPathToBoundary: TCheckBox
    Left = 16
    Top = 67
    Width = 424
    Height = 17
    Caption = 
      #1057#1072#1084#1099#1081' '#1089#1082#1088#1099#1090#1085#1099#1081' '#1084#1072#1088#1096#1088#1091#1090' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081' '#1086#1090' '#1089#1090#1072#1088#1090#1072' '#1076#1086' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1088#1091#1073#1077 +
      #1078#1072
    TabOrder = 4
  end
  object cbShowFastGuardPathToBoundary: TCheckBox
    Left = 16
    Top = 86
    Width = 345
    Height = 17
    Caption = #1057#1072#1084#1099#1081' '#1073#1099#1089#1090#1088#1099#1081' '#1084#1072#1088#1096#1088#1091#1090' '#1086#1093#1088#1072#1085#1099
    TabOrder = 5
  end
  object btOK: TButton
    Left = 352
    Top = 273
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object btCancel: TButton
    Left = 352
    Top = 309
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103
    ModalResult = 2
    TabOrder = 7
  end
  object btHelp: TButton
    Left = 352
    Top = 349
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 8
    Visible = False
  end
  object cbShowText: TCheckBox
    Left = 16
    Top = 106
    Width = 320
    Height = 18
    Caption = #1053#1072#1076#1087#1080#1089#1080
    TabOrder = 9
  end
  object cbShowSymbols: TCheckBox
    Left = 16
    Top = 126
    Width = 314
    Height = 17
    Caption = #1055#1080#1082#1090#1086#1075#1088#1072#1084#1084#1099' '#1089#1088#1077#1076#1089#1090#1074' '#1086#1093#1088#1072#1085#1099
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object cbShowDetectionZones: TCheckBox
    Left = 16
    Top = 145
    Width = 298
    Height = 18
    Caption = #1047#1086#1085#1099' '#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1103
    Checked = True
    State = cbChecked
    TabOrder = 11
  end
  object cbShowGraph: TCheckBox
    Left = 16
    Top = 165
    Width = 161
    Height = 17
    Caption = #1043#1088#1072#1092' '#1084#1072#1088#1096#1088#1091#1090#1086#1074
    TabOrder = 12
  end
  object cbBuildSectorLayer: TCheckBox
    Left = 16
    Top = 185
    Width = 161
    Height = 17
    Caption = #1043#1088#1072#1085#1080#1094#1099' '#1089#1077#1082#1090#1086#1088#1086#1074' '#1079#1086#1085
    Checked = True
    State = cbChecked
    TabOrder = 13
  end
  object cbDrawOrdered: TCheckBox
    Left = 16
    Top = 208
    Width = 199
    Height = 17
    Caption = #1056#1080#1089#1086#1074#1072#1090#1100' '#1087#1083#1086#1089#1082#1086#1089#1090#1080' '#1074' Z-'#1087#1086#1088#1103#1076#1082#1077
    Checked = True
    State = cbChecked
    TabOrder = 14
  end
end
