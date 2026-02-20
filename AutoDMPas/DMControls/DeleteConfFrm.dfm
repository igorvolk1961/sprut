object fmDeleteConfirm: TfmDeleteConfirm
  Left = 187
  Top = 125
  Width = 355
  Height = 119
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077
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
  object LConfirm: TLabel
    Left = 16
    Top = 8
    Width = 321
    Height = 49
    AutoSize = False
    Caption = #1042#1099' '#1093#1086#1090#1080#1090#1077' '#1091#1076#1072#1083#1080#1090#1100' '#1086#1073#1098#1077#1082#1090' ?'
    WordWrap = True
  end
  object btYes: TButton
    Left = 16
    Top = 61
    Width = 75
    Height = 25
    Caption = #1044#1072
    Default = True
    ModalResult = 6
    TabOrder = 0
  end
  object btYesToAll: TButton
    Left = 96
    Top = 61
    Width = 75
    Height = 25
    Caption = #1044#1072' '#1076#1083#1103' '#1074#1089#1077#1093
    ModalResult = 10
    TabOrder = 1
  end
  object btSkip: TButton
    Left = 176
    Top = 61
    Width = 75
    Height = 25
    Caption = #1055#1088#1086#1087#1091#1089#1090#1080#1090#1100
    ModalResult = 7
    TabOrder = 2
  end
  object btCancel: TButton
    Left = 256
    Top = 61
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
