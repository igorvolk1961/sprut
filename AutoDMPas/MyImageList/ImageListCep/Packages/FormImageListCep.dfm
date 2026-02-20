object FormDlgSIL: TFormDlgSIL
  Left = 254
  Top = 286
  BorderIcons = [biSystemMenu]
  BorderWidth = 4
  Caption = 'FormDlgSIL'
  ClientHeight = 291
  ClientWidth = 434
  Color = clBtnFace
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  DesignSize = (
    434
    291)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonAdd: TButton
    Left = 0
    Top = 265
    Width = 75
    Height = 25
    Action = ActionAdd
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object ButtonInsert: TButton
    Left = 81
    Top = 265
    Width = 75
    Height = 25
    Action = ActionInsert
    Anchors = [akLeft, akBottom]
    TabOrder = 3
  end
  object ButtonDelete: TButton
    Left = 162
    Top = 265
    Width = 75
    Height = 25
    Action = ActionDel
    Anchors = [akLeft, akBottom]
    TabOrder = 4
  end
  object GroupTypeAdd: TRadioGroup
    Left = 0
    Top = 0
    Width = 129
    Height = 87
    Caption = ' '#1055#1088#1080' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1080' '
    Items.Strings = (
      #1052#1072#1089#1096#1090#1072#1073#1080#1088#1086#1074#1072#1090#1100
      #1062#1077#1085#1090#1088#1080#1088#1086#1074#1072#1090#1100
      #1056#1072#1079#1073#1080#1074#1072#1090#1100)
    TabOrder = 0
    OnClick = GroupTypeAddClick
  end
  object GroupSize: TGroupBox
    Left = 135
    Top = 0
    Width = 218
    Height = 87
    Anchors = [akLeft, akTop, akRight]
    Constraints.MaxWidth = 239
    Constraints.MinWidth = 215
    TabOrder = 1
    DesignSize = (
      218
      87)
    object Label1: TLabel
      Left = 8
      Top = 14
      Width = 207
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = #1056#1072#1079#1084#1077#1088' '#1076#1086#1073#1072#1074#1083#1103#1077#1084#1086#1075#1086' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
      WordWrap = True
    end
    object EHeight: TMaskEdit
      Left = 63
      Top = 35
      Width = 32
      Height = 21
      TabOrder = 1
      OnChange = EChange
      OnKeyPress = MEKeyPress
    end
    object eWidth: TMaskEdit
      Left = 8
      Top = 35
      Width = 32
      Height = 21
      TabOrder = 0
      OnChange = EChange
      OnKeyPress = MEKeyPress
    end
    object CDefaultSize: TCheckBox
      Left = 8
      Top = 62
      Width = 207
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = #1090#1072#1082#1086#1081' '#1078#1077', '#1082#1072#1082' '#1091' '#1088#1077#1079#1091#1083#1100#1090#1080#1088#1091#1102#1097#1077#1075#1086
      TabOrder = 2
      OnClick = CDefaultSizeClick
    end
  end
  object ButtonApply: TButton
    Left = 359
    Top = 61
    Width = 75
    Height = 25
    Action = ActionApply
    Anchors = [akTop, akRight]
    TabOrder = 8
  end
  object ButtonCancel: TButton
    Left = 359
    Top = 31
    Width = 75
    Height = 25
    Action = ActionClose
    Anchors = [akTop, akRight]
    Cancel = True
    TabOrder = 7
  end
  object ButtonOk: TButton
    Left = 359
    Top = 2
    Width = 75
    Height = 25
    Action = ActionOk
    Anchors = [akTop, akRight]
    TabOrder = 6
  end
  object ButtonProps: TButton
    Left = 243
    Top = 265
    Width = 75
    Height = 25
    Action = ActionProps
    Anchors = [akLeft, akBottom]
    TabOrder = 5
  end
  object ButtonExport: TButton
    Left = 324
    Top = 265
    Width = 75
    Height = 25
    Action = ActionExport
    Anchors = [akLeft, akBottom]
    TabOrder = 9
  end
  object ActionList1: TActionList
    Left = 296
    Top = 104
    object ActionAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1080#1093' '#1092#1072#1081#1083#1072
      ShortCut = 45
      OnExecute = ActionAddExecute
    end
    object ActionInsert: TAction
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1080#1093' '#1092#1072#1081#1083#1072
      ShortCut = 8237
      OnExecute = ActionInsertExecute
    end
    object ActionDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      ShortCut = 16430
      OnExecute = ActionDelExecute
      OnUpdate = ActionDelUpdate
    end
    object ActionProps: TAction
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072
      Hint = #1057#1074#1086#1081#1089#1090#1074#1072' '#1088#1077#1079#1091#1083#1100#1090#1080#1088#1091#1102#1097#1077#1075#1086' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
      OnExecute = ActionPropsExecute
    end
    object ActionExport: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1074' '#1092#1072#1081#1083
      ShortCut = 16467
      OnExecute = ActionExportExecute
      OnUpdate = ActionExportUpdate
    end
    object ActionExportAll: TAction
      Caption = 'ActionExportAll'
      ShortCut = 24659
      OnExecute = ActionExportAllExecute
    end
    object ActionApply: TAction
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      OnExecute = ActionApplyExecute
    end
    object ActionClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      OnExecute = ActionCloseExecute
    end
    object ActionOk: TAction
      Caption = 'Ok'
      OnExecute = ActionOkExecute
    end
    object ActionMoveNext: TAction
      Caption = 'ActionMoveNext'
      OnExecute = ActionMoveNextExecute
    end
    object ActionMovePrior: TAction
      Caption = 'ActionMovePrior'
      OnExecute = ActionMovePriorExecute
    end
    object ActionAddStandart: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1090#1072#1085#1076#1072#1088#1090#1085#1099#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
      OnExecute = ActionAddStandartExecute
      OnUpdate = ActionAddStandartUpdate
    end
    object ActionDelResource: TAction
      Tag = -1
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = ActionDelResourceExecute
    end
    object ActionPropResource: TAction
      Tag = -1
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072'...'
      OnExecute = ActionPropResourceExecute
    end
    object ActionAddResource: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1077#1089#1091#1088#1089'...'
      OnExecute = ActionAddResourceExecute
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'bmp'
    Filter = ' (*.bmp)|*.bmp|Bce (*.*)|*.*| (*.res)|*.res'
    FilterIndex = 0
    Left = 264
    Top = 104
  end
end
