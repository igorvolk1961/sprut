object fmAutoVisioFrm: TfmAutoVisioFrm
  Left = 235
  Top = 112
  Width = 273
  Height = 185
  Caption = #1054#1087#1094#1080#1080' '#1101#1082#1089#1087#1086#1088#1090#1072' '#1074' VISIO'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Left = 10
    Top = 148
    Width = 92
    Height = 30
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 118
    Top = 148
    Width = 92
    Height = 30
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 226
    Top = 148
    Width = 93
    Height = 30
    Caption = #1057#1087#1088#1072#1074#1082#1072
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
  end
  object RadioGroup1: TRadioGroup
    Left = 10
    Top = 20
    Width = 306
    Height = 109
    Caption = #1042#1099#1073#1086#1088' '#1074#1080#1076#1072
    ItemIndex = 0
    Items.Strings = (
      #1042#1080#1076' '#1089#1074#1077#1088#1093#1091' ('#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1077' '#1089#1077#1095#1077#1085#1080#1077')'
      #1042#1080#1076' '#1089#1073#1086#1082#1091' ('#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1077' '#1089#1077#1095#1077#1085#1080#1077')')
    TabOrder = 3
  end
end
