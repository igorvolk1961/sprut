object fmBuildPath: TfmBuildPath
  Left = 224
  Top = 180
  Width = 383
  Height = 370
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1084#1072#1088#1096#1088#1091#1090#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 19
    Top = 156
    Width = 87
    Height = 13
    Caption = #1042#1072#1088#1080#1072#1085#1090' '#1072#1085#1072#1083#1080#1079#1072
  end
  object Label2: TLabel
    Left = 24
    Top = 256
    Width = 103
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1084#1072#1088#1096#1088#1091#1090#1072
  end
  object edName: TEdit
    Left = 15
    Top = 274
    Width = 344
    Height = 21
    TabOrder = 0
  end
  object rgPathKind: TRadioGroup
    Left = 8
    Top = 2
    Width = 354
    Height = 140
    Caption = #1058#1080#1087' '#1084#1072#1088#1096#1088#1091#1090#1072
    ItemIndex = 0
    Items.Strings = (
      #1054#1087#1090#1080#1084#1072#1083#1100#1085#1099#1081' '#1087#1091#1090#1100' '#1080#1079#1074#1085#1077' '#1076#1086' '#1094#1077#1083#1080', '#1087#1088#1086#1093#1086#1076#1103#1097#1080#1081' '#1095#1077#1088#1077#1079' '#1088#1091#1073#1077#1078
      #1057#1072#1084#1099#1081' '#1073#1099#1089#1090#1088#1099#1081' '#1087#1091#1090#1100' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081' '#1086#1090' '#1088#1091#1073#1077#1078#1072' '#1076#1086' '#1094#1077#1083#1080
      #1057#1072#1084#1099#1081' '#1089#1082#1088#1099#1090#1085#1099#1081' '#1087#1091#1090#1100' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081' '#1080#1079#1074#1085#1077' '#1076#1086' '#1088#1091#1073#1077#1078#1072
      #1057#1072#1084#1099#1081' '#1073#1099#1089#1090#1088#1099#1081' '#1087#1091#1090#1100' '#1086#1093#1088#1072#1085#1099' '#1086#1090' '#1088#1091#1073#1077#1078#1072' '#1076#1086' '#1094#1077#1083#1080
      #1057#1072#1084#1099#1081' '#1073#1099#1089#1090#1088#1099#1081' '#1087#1091#1090#1100' '#1086#1093#1088#1072#1085#1099' '#1086#1090' '#1090#1086#1095#1082#1080' '#1076#1080#1089#1083#1086#1082#1072#1094#1080#1080' '#1076#1086' '#1088#1091#1073#1077#1078#1072)
    TabOrder = 1
    OnClick = rgPathKindClick
  end
  object chbAnalisysVariant: TComboBox
    Left = 12
    Top = 172
    Width = 347
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnChange = chbAnalisysVariantChange
  end
  object Button1: TButton
    Left = 18
    Top = 311
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 149
    Top = 310
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 4
  end
  object Button3: TButton
    Left = 281
    Top = 310
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 5
    Visible = False
  end
  object pGuardGroup: TPanel
    Left = 11
    Top = 201
    Width = 352
    Height = 52
    BevelOuter = bvNone
    TabOrder = 6
    Visible = False
    object Label3: TLabel
      Left = 12
      Top = 7
      Width = 120
      Height = 13
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1086#1093#1088#1072#1085#1099
    end
    object chbGuardGroup: TComboBox
      Left = 2
      Top = 21
      Width = 347
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = chbGuardGroupChange
    end
  end
end
