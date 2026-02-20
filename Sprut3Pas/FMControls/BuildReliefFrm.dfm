object fmBuildRelief: TfmBuildRelief
  Left = 192
  Top = 119
  Width = 368
  Height = 165
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1088#1077#1083#1100#1077#1092#1072' '#1084#1077#1089#1090#1085#1086#1089#1090#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object rgDeleteVAreaDirection: TRadioGroup
    Left = 8
    Top = 8
    Width = 337
    Height = 73
    Caption = #1057#1075#1083#1072#1078#1080#1074#1072#1085#1080#1077' "'#1089#1090#1091#1087#1077#1085#1077#1082'" '#1088#1077#1083#1100#1077#1092#1072
    ItemIndex = 0
    Items.Strings = (
      #1053#1080#1078#1085#1080#1081' '#1082#1088#1072#1081' "'#1089#1090#1091#1087#1077#1085#1100#1082#1080'" '#1086#1089#1090#1072#1077#1090#1089#1103' '#1085#1072' '#1084#1077#1089#1090#1077
      #1042#1077#1088#1093#1085#1080#1081' '#1082#1088#1072#1081' "'#1089#1090#1091#1087#1077#1085#1100#1082#1080'" '#1086#1089#1090#1072#1077#1090#1089#1103' '#1085#1072' '#1084#1077#1089#1090#1077)
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 96
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 140
    Top = 96
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object btHelp: TButton
    Left = 272
    Top = 96
    Width = 75
    Height = 25
    HelpType = htKeyword
    HelpKeyword = 'IDH_5_5_3'
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 3
    OnClick = btHelpClick
  end
end
