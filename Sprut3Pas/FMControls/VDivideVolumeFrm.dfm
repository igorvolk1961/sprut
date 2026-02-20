object fmVDivideVolume: TfmVDivideVolume
  Left = 393
  Top = 489
  Width = 376
  Height = 157
  Caption = #1044#1077#1083#1077#1085#1080#1077' '#1079#1086#1085#1099' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object rgKind: TRadioGroup
    Left = 16
    Top = -1
    Width = 333
    Height = 65
    ItemIndex = 0
    Items.Strings = (
      #1044#1077#1083#1077#1085#1080#1077' '#1085#1072' 2 '#1095#1072#1089#1090#1080' '#1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1086#1081' '#1074#1099#1089#1086#1090#1099
      #1044#1077#1083#1077#1085#1080#1077' '#1085#1072' '#1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1086#1077' '#1095#1080#1089#1083#1086' '#1095#1072#1089#1090#1077#1081' '#1088#1072#1074#1085#1086#1081' '#1074#1099#1089#1086#1090#1099)
    TabOrder = 0
    OnClick = rgKindClick
  end
  object PanelH: TPanel
    Left = 154
    Top = 67
    Width = 191
    Height = 27
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 8
      Width = 110
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072' '#1085#1080#1078#1085#1077#1081' '#1095#1072#1089#1090#1080
    end
    object Label2: TLabel
      Left = 168
      Top = 8
      Width = 14
      Height = 13
      Caption = ', '#1084
    end
    object edH: TEdit
      Left = 124
      Top = 5
      Width = 40
      Height = 21
      TabOrder = 0
      OnChange = edHChange
    end
  end
  object PanelN: TPanel
    Left = 15
    Top = 66
    Width = 131
    Height = 27
    BevelOuter = bvNone
    TabOrder = 2
    object Label3: TLabel
      Left = 7
      Top = 8
      Width = 69
      Height = 13
      Caption = #1063#1080#1089#1083#1086' '#1095#1072#1089#1090#1077#1081
    end
    object edN: TEdit
      Left = 82
      Top = 5
      Width = 40
      Height = 21
      TabOrder = 0
      OnChange = edNChange
    end
  end
  object btOK: TButton
    Left = 53
    Top = 100
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object Button1: TButton
    Left = 149
    Top = 100
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 4
  end
  object btHelp: TButton
    Left = 245
    Top = 100
    Width = 75
    Height = 25
    HelpType = htKeyword
    HelpKeyword = 'IDH_5_5_4'
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 5
    OnClick = btHelpClick
  end
end
