object fmDemoMenu: TfmDemoMenu
  Left = -6
  Top = 91
  BorderStyle = bsNone
  Caption = 'fmDemoMenu'
  ClientHeight = 414
  ClientWidth = 789
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 373
    Width = 789
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object pBottom: TPanel
      Left = 40
      Top = 1
      Width = 705
      Height = 39
      Align = alCustom
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object Memo1: TMemo
    Left = 528
    Top = 0
    Width = 261
    Height = 373
    Align = alRight
    Color = 16777088
    ReadOnly = True
    TabOrder = 1
  end
end
