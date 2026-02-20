object fmLayerProperties: TfmLayerProperties
  Left = 84
  Top = 160
  Width = 362
  Height = 228
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1089#1083#1086#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 49
    Height = 13
    Caption = #1048#1084#1103' '#1089#1083#1086#1103
  end
  object Label2: TLabel
    Left = 16
    Top = 88
    Width = 321
    Height = 33
    AutoSize = False
    Caption = 
      #1058#1080#1087' '#1075#1088#1072#1085#1080#1094', '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1089#1086#1079#1076#1072#1074#1072#1077#1084#1099#1093' '#1087#1088#1080' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1080' '#1089#1077#1082#1090#1086#1088#1072' '#1087#1088 +
      #1086#1089#1090#1088#1072#1085#1089#1090#1074#1072
    WordWrap = True
  end
  object edName: TEdit
    Left = 16
    Top = 24
    Width = 289
    Height = 21
    TabOrder = 0
  end
  object chbExpand: TCheckBox
    Left = 16
    Top = 56
    Width = 321
    Height = 17
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1089#1083#1086#1081' '#1087#1088#1080' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1080' '#1089#1077#1082#1090#1086#1088#1072' '#1087#1088#1086#1089#1090#1088#1072#1085#1089#1090#1074#1072
    TabOrder = 1
  end
  object edRef: TEdit
    Left = 16
    Top = 120
    Width = 265
    Height = 21
    ReadOnly = True
    TabOrder = 2
    OnKeyPress = edRefKeyPress
  end
  object btDefineRef: TButton
    Left = 280
    Top = 120
    Width = 24
    Height = 22
    Caption = '...'
    TabOrder = 3
    OnClick = btDefineRefClick
  end
  object btOK: TButton
    Left = 16
    Top = 160
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btCcancel: TButton
    Left = 144
    Top = 160
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 5
  end
  object btHelp: TButton
    Left = 264
    Top = 160
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 6
    Visible = False
  end
end
