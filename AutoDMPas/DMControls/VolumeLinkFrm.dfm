object fmVolumeLink: TfmVolumeLink
  Left = 299
  Top = 170
  Width = 210
  Height = 157
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1089#1074#1103#1079#1080
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
  object rgLinkType: TRadioGroup
    Left = 8
    Top = 8
    Width = 81
    Height = 81
    Caption = #1042#1080#1076' '#1089#1074#1103#1079#1080
    ItemIndex = 0
    Items.Strings = (
      'Volume0'
      'Volume1')
    TabOrder = 0
  end
  object btOK: TButton
    Left = 4
    Top = 96
    Width = 58
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 66
    Top = 96
    Width = 61
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object btHelp: TButton
    Left = 131
    Top = 96
    Width = 61
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 3
    Visible = False
  end
  object chbVolumeIsOuter: TCheckBox
    Left = 101
    Top = 44
    Width = 92
    Height = 17
    Caption = 'VolumeIsOuter'
    TabOrder = 4
  end
end
