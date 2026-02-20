object fmLayerList: TfmLayerList
  Left = 178
  Top = 132
  Width = 347
  Height = 275
  Caption = #1054#1073#1098#1077#1076#1080#1085#1077#1085#1080#1077' '#1089#1083#1086#1077#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 339
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 7
      Width = 337
      Height = 33
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 
        #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1083#1086#1081', '#1074' '#1082#1086#1090#1086#1088#1099#1084' '#1076#1086#1083#1078#1085#1099' '#1073#1099#1090#1100' '#1087#1077#1088#1077#1085#1077#1089#1077#1085#1099' '#1086#1073#1098#1077#1082#1090#1099' '#1080#1079' '#1091#1076#1072#1083#1103 +
        #1077#1084#1086#1075#1086' '#1089#1083#1086#1103
      WordWrap = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 205
    Width = 339
    Height = 40
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 12
      Top = 8
      Width = 76
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 99
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object Button3: TButton
      Left = 186
      Top = 8
      Width = 75
      Height = 25
      Caption = #1057#1087#1088#1072#1074#1082#1072
      Enabled = False
      TabOrder = 2
      Visible = False
    end
  end
  object lbLayers: TListBox
    Left = 0
    Top = 41
    Width = 339
    Height = 164
    Align = alClient
    ItemHeight = 13
    TabOrder = 2
  end
end
