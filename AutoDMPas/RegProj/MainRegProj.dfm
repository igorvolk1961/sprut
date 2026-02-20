object Form1: TForm1
  Left = 63
  Top = 103
  Width = 544
  Height = 410
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1089#1077#1088#1074#1077#1088#1085#1099#1093' '#1084#1086#1076#1091#1083#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbFiles: TListBox
    Left = 0
    Top = 0
    Width = 536
    Height = 323
    Align = alClient
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 323
    Width = 536
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    object miFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object miNew: TMenuItem
        Caption = #1053#1086#1074#1099#1081
        OnClick = miNewClick
      end
      object miOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        OnClick = miOpenClick
      end
      object miSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100'...'
        OnClick = miSaveClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 32883
        OnClick = miExitClick
      end
    end
    object N8: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      object miAdd: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100'...'
        OnClick = miAddClick
      end
      object miDelete: TMenuItem
        Caption = #1048#1089#1082#1083#1102#1095#1080#1090#1100
        OnClick = miDeleteClick
      end
    end
    object miRegister: TMenuItem
      Caption = #1056#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100
      OnClick = miRegisterClick
    end
    object miUnregister: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1102
      OnClick = miUnregisterClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1057#1087#1080#1089#1086#1082' '#1084#1086#1076#1091#1083#1077#1081' (*.lst)|*.lst'
    Left = 24
  end
  object SaveDialog1: TSaveDialog
    Filter = #1057#1087#1080#1089#1086#1082' '#1084#1086#1076#1091#1083#1077#1081' (*.lst)|*.lst'
    Left = 48
  end
  object OpenDialog2: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Left = 72
  end
end
