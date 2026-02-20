inherited DMChart: TDMChart
  Left = 0
  Top = 84
  Caption = 'DMChart'
  ClientHeight = 364
  ClientWidth = 790
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 790
    Height = 57
    Align = alTop
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 656
      Height = 55
      Align = alLeft
      TabOrder = 0
      object Label1: TLabel
        Left = 12
        Top = 8
        Width = 46
        Height = 13
        Caption = #1060#1091#1085#1082#1094#1080#1103
      end
      object Label2: TLabel
        Left = 292
        Top = 7
        Width = 63
        Height = 13
        Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '
      end
      object cbFunction: TComboBox
        Left = 3
        Top = 24
        Width = 280
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cbFunctionChange
      end
      object cbSort: TComboBox
        Left = 285
        Top = 24
        Width = 280
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cbSortChange
      end
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 57
    Width = 790
    Height = 307
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 1
  end
end
