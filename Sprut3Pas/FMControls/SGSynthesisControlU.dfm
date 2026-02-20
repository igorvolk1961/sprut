inherited SGSynthesisControl: TSGSynthesisControl
  Left = 0
  Top = 88
  Caption = 'SGSynthesisControl'
  ClientHeight = 445
  ClientWidth = 804
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 30
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 6
      Top = 4
      Width = 125
      Height = 20
      Caption = #1056#1077#1082#1086#1084#1077#1085#1076#1072#1094#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 30
    Width = 804
    Height = 415
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 1
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 400
      Height = 413
      Align = alLeft
      Caption = 'Panel5'
      TabOrder = 0
      object sgEquipmentVariants: TStringGrid
        Left = 1
        Top = 1
        Width = 398
        Height = 333
        Align = alClient
        ColCount = 3
        FixedCols = 0
        Options = [goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
        TabOrder = 0
        OnSelectCell = sgEquipmentVariantsSelectCell
        ColWidths = (
          223
          87
          63)
      end
      object Panel4: TPanel
        Left = 1
        Top = 334
        Width = 398
        Height = 78
        Align = alBottom
        TabOrder = 1
        object btAdd: TButton
          Left = 12
          Top = 8
          Width = 89
          Height = 25
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 0
          OnClick = btAddClick
        end
        object btDelete: TButton
          Left = 106
          Top = 8
          Width = 89
          Height = 25
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 1
          OnClick = btDeleteClick
        end
        object btPersistent: TButton
          Left = 295
          Top = 8
          Width = 89
          Height = 25
          Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
          TabOrder = 2
          OnClick = btPersistentClick
        end
        object rgTotalEfficiencyCalcMode: TRadioGroup
          Left = 8
          Top = 34
          Width = 377
          Height = 43
          Caption = #1040#1085#1072#1083#1080#1079' '#1101#1092#1092#1077#1082#1090#1080#1074#1085#1086#1089#1090#1080
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            #1054#1094#1077#1085#1082#1072' '#1089#1085#1080#1079#1091
            #1059#1089#1088#1077#1076#1085#1077#1085#1085#1072#1103' '#1086#1094#1077#1085#1082#1072)
          TabOrder = 3
          OnClick = rgTotalEfficiencyCalcModeClick
        end
        object btAnalysis: TButton
          Left = 202
          Top = 8
          Width = 86
          Height = 25
          Caption = #1040#1085#1072#1083#1080#1079
          TabOrder = 4
          OnClick = btAnalysisClick
        end
      end
    end
    object sgRecomendations: TStringGrid
      Left = 401
      Top = 1
      Width = 402
      Height = 413
      Align = alClient
      ColCount = 3
      FixedCols = 0
      Options = [goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
      TabOrder = 1
      OnDrawCell = sgRecomendationsDrawCell
      OnSelectCell = sgRecomendationsSelectCell
      OnSetEditText = sgRecomendationsSetEditText
      ColWidths = (
        247
        52
        60)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
  end
end
