object FormDlgSIL: TFormDlgSIL
  Left = 254
  Top = 286
  Width = 450
  Height = 333
  BorderIcons = [biSystemMenu]
  BorderWidth = 4
  Caption = 'FormDlgSIL'
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
    Caption = ' При добавлении '
    Items.Strings = (
      'Масштабировать'
      'Центрировать'
      'Разбивать')
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
    object Label1: TLabel
      Left = 8
      Top = 14
      Width = 207
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Размер добавляемого изображения'
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
      Caption = 'такой же, как у результирующего'
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
      Caption = 'Добавить'
      Hint = 'Добавить изображение их файла'
      ShortCut = 45
      OnExecute = ActionAddExecute
    end
    object ActionInsert: TAction
      Caption = 'Вставить'
      Hint = 'Вставить изображение их файла'
      ShortCut = 8237
      OnExecute = ActionInsertExecute
    end
    object ActionDel: TAction
      Caption = 'Удалить'
      Hint = 'Удалить изображение'
      ShortCut = 16430
      OnExecute = ActionDelExecute
      OnUpdate = ActionDelUpdate
    end
    object ActionProps: TAction
      Caption = 'Свойства'
      Hint = 'Свойства результирующего изображения'
      OnExecute = ActionPropsExecute
    end
    object ActionExport: TAction
      Caption = 'Экспорт'
      Hint = 'Сохранить изображение в файл'
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
      Caption = 'Применить'
      OnExecute = ActionApplyExecute
    end
    object ActionClose: TAction
      Caption = 'Закрыть'
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
      Caption = 'Добавить стандартные изображения'
      OnExecute = ActionAddStandartExecute
      OnUpdate = ActionAddStandartUpdate
    end
    object ActionDelResource: TAction
      Tag = -1
      Caption = 'Удалить'
      OnExecute = ActionDelResourceExecute
    end
    object ActionPropResource: TAction
      Tag = -1
      Caption = 'Свойства...'
      OnExecute = ActionPropResourceExecute
    end
    object ActionAddResource: TAction
      Caption = 'Добавить ресурс...'
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
