object fmSelect: TfmSelect
  Left = 202
  Top = 106
  Width = 507
  Height = 164
  Caption = #1042#1099#1073#1086#1088' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1084#1086#1076#1077#1083#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lElement: TLabel
    Left = 16
    Top = 8
    Width = 85
    Height = 13
    Caption = #1069#1083#1077#1084#1077#1085#1090' '#1084#1086#1076#1077#1083#1080
  end
  object cbElement: TComboBox
    Left = 16
    Top = 32
    Width = 386
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnKeyDown = cbElementKeyDown
  end
  object btOK: TButton
    Left = 88
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 168
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object btHelp: TButton
    Left = 248
    Top = 72
    Width = 75
    Height = 25
    HelpType = htKeyword
    HelpKeyword = 'IDH_5_5_6'
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 3
    OnClick = btHelpClick
  end
end
