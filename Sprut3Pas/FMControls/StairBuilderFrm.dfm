object fmStairBuilder: TfmStairBuilder
  Left = 269
  Top = 120
  Width = 281
  Height = 178
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1083#1077#1089#1090#1085#1080#1094
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 14
    Top = 85
    Width = 90
    Height = 13
    Caption = #1064#1080#1088#1080#1085#1072' '#1084#1072#1088#1096#1072', '#1084
  end
  object rgStairClockwise: TRadioGroup
    Left = 11
    Top = 7
    Width = 246
    Height = 65
    Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1083#1077#1089#1090#1085#1080#1094#1099
    ItemIndex = 0
    Items.Strings = (
      #1055#1088#1086#1090#1080#1074' '#1095#1072#1089#1086#1074#1086#1081' '#1089#1090#1088#1077#1083#1082#1080
      #1055#1086' '#1095#1072#1089#1086#1074#1086#1081' '#1089#1090#1088#1077#1083#1082#1077)
    TabOrder = 0
  end
  object edStairWidth: TEdit
    Left = 115
    Top = 81
    Width = 76
    Height = 21
    TabOrder = 1
    OnChange = edStairWidthChange
  end
  object btOK: TButton
    Left = 12
    Top = 111
    Width = 78
    Height = 25
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btCancel: TButton
    Left = 96
    Top = 111
    Width = 78
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object btHelp: TButton
    Left = 181
    Top = 111
    Width = 78
    Height = 25
    HelpType = htKeyword
    HelpKeyword = 'IDH_5_5_6'
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 4
    OnClick = btHelpClick
  end
end
