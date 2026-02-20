object frmDMBrowserOptions: TfrmDMBrowserOptions
  Left = 287
  Top = 113
  Width = 342
  Height = 190
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1086#1082#1085#1072' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1084#1086#1076#1077#1083#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object chbHideEmptyCollections: TCheckBox
    Left = 16
    Top = 16
    Width = 305
    Height = 17
    Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1074#1077#1090#1074#1080' '#1076#1077#1088#1077#1074#1072', '#1085#1077' '#1089#1086#1076#1077#1088#1078#1072#1097#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
    TabOrder = 0
  end
  object rgDetailMode: TRadioGroup
    Left = 16
    Top = 40
    Width = 297
    Height = 65
    Caption = #1056#1077#1078#1080#1084' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1101#1083#1077#1084#1077#1085#1090#1072
    ItemIndex = 0
    Items.Strings = (
      #1057#1087#1080#1089#1086#1082' '#1087#1086#1083#1077#1081' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072
      #1058#1072#1073#1083#1080#1094#1072' '#1087#1086#1083#1077#1081' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1087#1080#1089#1082#1072)
    TabOrder = 1
  end
  object miOK: TButton
    Left = 16
    Top = 128
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    ModalResult = 1
    TabOrder = 2
  end
  object miCancel: TButton
    Left = 128
    Top = 128
    Width = 75
    Height = 25
    Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103
    ModalResult = 2
    TabOrder = 3
  end
  object miHelp: TButton
    Left = 240
    Top = 128
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 4
    Visible = False
  end
end
