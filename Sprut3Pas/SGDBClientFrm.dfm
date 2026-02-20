inherited Form1: TForm1
  Left = 131
  Top = 247
  Width = 481
  Height = 285
  Font.Height = -10
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited MainMenu1: TMainMenu
    inherited N1: TMenuItem
      inherited miImportVector: TMenuItem
        Visible = False
      end
      inherited miImportRaster: TMenuItem
        Visible = False
      end
      inherited N16: TMenuItem
        Visible = False
      end
    end
    inherited N3: TMenuItem
      inherited miSelectAllNodes: TMenuItem
        Visible = False
      end
      object miChangeObjectType: TMenuItem
        Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1090#1080#1087#1072' '#1086#1073#1098#1077#1082#1090#1072
        OnClick = miChangeObjectTypeClick
      end
    end
    inherited miView: TMenuItem
      inherited miOutlookPanel: TMenuItem
        Visible = False
      end
    end
    inherited miModel: TMenuItem
      inherited N25: TMenuItem
        object miBuildArea: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1080#1079#1086#1083#1080#1088#1086#1074#1072#1085#1085#1086#1081' '#1087#1083#1086#1089#1082#1086#1089#1090#1080
          GroupIndex = 102
          OnClick = miBuildAreaClick
        end
      end
      inherited N27: TMenuItem
        object miMirrorSelected: TMenuItem
          Caption = #1047#1077#1088#1082#1072#1083#1100#1085#1086#1077' '#1086#1090#1088#1072#1078#1077#1085#1077#1080' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
          GroupIndex = 104
          OnClick = miMirrorSelectedClick
        end
      end
    end
    object miCorrect: TMenuItem
      Caption = #1050#1086#1088#1088#1077#1082#1090#1088#1086#1074#1082#1072
      GroupIndex = 1
      OnClick = fmDMMainmiCorrectClick
    end
  end
end
