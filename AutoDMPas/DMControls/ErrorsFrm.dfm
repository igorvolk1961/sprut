object fmErrors: TfmErrors
  Left = 299
  Top = 140
  Width = 574
  Height = 377
  Caption = #1054#1096#1080#1073#1082#1080' '#1084#1086#1076#1077#1083#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbErrors: TListBox
    Left = 0
    Top = 0
    Width = 566
    Height = 305
    Style = lbOwnerDrawFixed
    Align = alTop
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
    OnClick = lbErrorsClick
    OnDblClick = btShowErrorClick
    OnDrawItem = lbErrorsDrawItem
  end
  object btHelp: TButton
    Left = 442
    Top = 312
    Width = 110
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 1
    Visible = False
  end
  object btShowError: TButton
    Left = 8
    Top = 312
    Width = 110
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1086#1096#1080#1073#1082#1091
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btShowErrorClick
  end
  object btCorrectErrors: TButton
    Left = 128
    Top = 312
    Width = 185
    Height = 25
    Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1086#1096#1080#1073#1082#1080
    TabOrder = 3
    OnClick = btCorrectErrorsClick
  end
  object btClose: TButton
    Left = 321
    Top = 312
    Width = 110
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 4
    OnClick = btCloseClick
  end
end
