object fmMacrosPosition: TfmMacrosPosition
  Left = 136
  Top = 158
  Width = 258
  Height = 175
  Caption = #1055#1088#1086#1080#1075#1088#1099#1096' '#1084#1072#1082#1088#1086#1089#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 30
    Width = 50
    Height = 16
    Caption = #1053#1072#1095#1072#1083#1086
  end
  object Button1: TButton
    Left = 20
    Top = 108
    Width = 92
    Height = 31
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object edStartPos: TSpinEdit
    Left = 69
    Top = 20
    Width = 149
    Height = 26
    MaxValue = 9999
    MinValue = 1
    TabOrder = 1
    Value = 1
  end
  object fmMacrosPosition: TButton
    Left = 128
    Top = 108
    Width = 92
    Height = 31
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
