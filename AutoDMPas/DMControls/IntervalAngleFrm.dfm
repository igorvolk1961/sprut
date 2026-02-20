object fmInputValue: TfmInputValue
  Left = 50
  Top = 317
  Width = 234
  Height = 144
  Caption = #1080#1085#1090#1077#1088#1074#1072#1083
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 88
    Top = 24
    Width = 49
    Height = 13
    Caption = #1096#1072#1075'   ('#1077#1076'.)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 144
    Top = 24
    Width = 65
    Height = 13
    Caption = #1087#1088#1080#1084#1077#1088': 10.5'
    Color = clActiveBorder
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBackground
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object btOk: TButton
    Left = 16
    Top = 72
    Width = 57
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = btOkClick
  end
  object btClose: TButton
    Left = 152
    Top = 72
    Width = 57
    Height = 25
    Caption = #1086#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 5
    ParentFont = False
    TabOrder = 0
    OnClick = btCloseClick
  end
  object ed_Value: TEdit
    Left = 18
    Top = 20
    Width = 60
    Height = 22
    Hint = #1080#1085#1090#1077#1088#1074#1072#1083' '#1080#1085#1082#1088#1077#1084#1077#1085#1090#1072'/'#1076#1077#1082#1088#1077#1084#1077#1085#1090#1072' '#1091#1075#1083#1072' '#1087#1086#1074#1086#1088#1086#1090#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnChange = ed_ValueChange
  end
end
