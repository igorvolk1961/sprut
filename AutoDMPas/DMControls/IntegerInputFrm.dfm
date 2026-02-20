object fmIntegerInput: TfmIntegerInput
  Left = 351
  Top = 386
  Width = 219
  Height = 122
  Caption = #1042#1074#1086#1076' '#1079#1085#1072#1095#1077#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LPrompt: TLabel
    Left = 16
    Top = 7
    Width = 3
    Height = 13
  end
  object edValue: TSpinEdit
    Left = 62
    Top = 31
    Width = 93
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object Button1: TButton
    Left = 24
    Top = 63
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 117
    Top = 63
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object edText: TEdit
    Left = 62
    Top = 32
    Width = 93
    Height = 21
    TabOrder = 3
    Text = '1.5'
    OnChange = edTextChange
  end
end
