object fmChangePassword: TfmChangePassword
  Left = 141
  Top = 173
  Width = 332
  Height = 215
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 9
    Width = 80
    Height = 13
    Caption = #1057#1090#1072#1088#1099#1081' '#1087#1072#1088#1086#1083#1100':'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 76
    Height = 13
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
  end
  object Label3: TLabel
    Left = 16
    Top = 103
    Width = 161
    Height = 13
    Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1087#1072#1088#1086#1083#1103':'
  end
  object btLayout: TSpeedButton
    Left = 224
    Top = 24
    Width = 23
    Height = 22
    Caption = 'Ru'
    OnClick = btLayoutClick
  end
  object edOldPassword: TEdit
    Left = 16
    Top = 25
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object edNewPassword: TEdit
    Left = 16
    Top = 73
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edNewPassword1: TEdit
    Left = 16
    Top = 121
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object miOK: TButton
    Left = 224
    Top = 72
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object Button1: TButton
    Left = 224
    Top = 120
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103
    TabOrder = 4
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 288
    Top = 32
  end
end
