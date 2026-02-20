object frmDrawPrintOptions: TfrmDrawPrintOptions
  Left = 136
  Top = 115
  Width = 324
  Height = 171
  Caption = #1054#1087#1094#1080#1080' '#1087#1077#1095#1072#1090#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 7
    Top = 80
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 92
    Top = 80
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object Button3: TButton
    Left = 175
    Top = 80
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 2
  end
  object rgCanvasTag: TRadioGroup
    Left = 8
    Top = 8
    Width = 241
    Height = 65
    Caption = #1042#1099#1073#1086#1088' '#1074#1080#1076#1072
    ItemIndex = 0
    Items.Strings = (
      #1042#1080#1076' '#1089#1074#1077#1088#1093#1091' ('#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1077' '#1089#1077#1095#1077#1085#1080#1077')'
      #1042#1080#1076' '#1089#1073#1086#1082#1091' ('#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086#1077' '#1089#1077#1095#1077#1085#1080#1077')')
    TabOrder = 3
  end
end
