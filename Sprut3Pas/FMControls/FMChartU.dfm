inherited FMChart: TFMChart
  Left = 41
  Top = 188
  Caption = 'FMChart'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 99
    inherited Splitter1: TSplitter
      Height = 97
    end
    inherited mComment: TMemo
      Height = 97
    end
    inherited Panel2: TPanel
      Height = 97
      inherited sbCopy: TSpeedButton
        Left = 290
        Top = 66
      end
      inherited SpinButton1: TSpinButton
        TabOrder = 4
      end
      inherited SpinButton2: TSpinButton
        TabOrder = 5
      end
      object pAnalysisVariant: TPanel
        Left = 0
        Top = 46
        Width = 286
        Height = 45
        BevelOuter = bvNone
        TabOrder = 2
        object Label3: TLabel
          Left = 11
          Top = 6
          Width = 87
          Height = 13
          Caption = #1042#1072#1088#1080#1072#1085#1090' '#1072#1085#1072#1083#1080#1079#1072
        end
        object chbAnalysisVariant: TComboBox
          Left = 2
          Top = 23
          Width = 280
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = chbAnalysisVariantChange
        end
      end
      object btCopy: TButton
        Left = 318
        Top = 65
        Width = 217
        Height = 25
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1080#1072#1075#1088#1072#1084#1084#1091' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
        TabOrder = 3
        OnClick = btCopyClick
      end
    end
  end
  inherited ScrollBox1: TScrollBox
    Top = 99
    Height = 265
  end
  inherited FontDialog1: TFontDialog
    Left = 543
  end
end
