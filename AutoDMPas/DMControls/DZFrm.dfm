object fmDZ: TfmDZ
  Left = 274
  Top = 214
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 89
  ClientWidth = 144
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 103
    Height = 13
    Caption = #1064#1072#1075' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' Z, '#1084
  end
  object edDZ: TEdit
    Left = 8
    Top = 20
    Width = 124
    Height = 21
    TabOrder = 0
    Text = '1.5'
    OnChange = edDZChange
  end
  object Button1: TButton
    Left = 8
    Top = 48
    Width = 61
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 72
    Top = 48
    Width = 61
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
end
