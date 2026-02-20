object fmRoundXY: TfmRoundXY
  Left = 212
  Top = 424
  Width = 312
  Height = 111
  Caption = #1042#1072#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1082#1086#1086#1088#1076#1080#1085#1072#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 137
    Height = 33
    AutoSize = False
    Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1086#1082#1088#1091#1075#1083#1077#1085#1080#1103' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1091#1079#1083#1086#1074' '#1087#1086' X '#1080' Y'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 241
    Top = 22
    Width = 20
    Height = 13
    Caption = ', '#1089#1084
  end
  object edD: TEdit
    Left = 169
    Top = 14
    Width = 63
    Height = 21
    TabOrder = 0
    OnChange = edDChange
  end
  object Button1: TButton
    Left = 17
    Top = 48
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 105
    Top = 48
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 193
    Top = 48
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 3
    Visible = False
  end
end
