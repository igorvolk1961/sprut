object frmIdInput: TfrmIdInput
  Left = 271
  Top = 192
  Width = 213
  Height = 101
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1089#1074#1103#1079#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 11
    Width = 44
    Height = 13
    Caption = 'ID '#1089#1074#1103#1079#1080
  end
  object btOK: TButton
    Left = 4
    Top = 37
    Width = 58
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btCancel: TButton
    Left = 66
    Top = 37
    Width = 61
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object btHelp: TButton
    Left = 131
    Top = 37
    Width = 61
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 2
    Visible = False
  end
  object edID: TEdit
    Left = 56
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 3
    OnChange = edIDChange
  end
end
