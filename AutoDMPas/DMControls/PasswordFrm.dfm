object fmPassword: TfmPassword
  Left = 179
  Top = 140
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1087#1088#1072#1074' '#1076#1086#1089#1090#1091#1087#1072
  ClientHeight = 112
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 167
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100' '#1076#1086#1089#1090#1091#1087#1072' '#1082' '#1092#1072#1081#1083#1091
  end
  object lFileName: TLabel
    Left = 16
    Top = 33
    Width = 6
    Height = 13
    Caption = '0'
  end
  object btLayout: TSpeedButton
    Left = 325
    Top = 53
    Width = 23
    Height = 22
    Caption = 'Ru'
    OnClick = btLayoutClick
  end
  object edPassword: TEdit
    Left = 13
    Top = 53
    Width = 308
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object btOK: TButton
    Left = 92
    Top = 81
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 188
    Top = 81
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 264
    Top = 8
  end
end
