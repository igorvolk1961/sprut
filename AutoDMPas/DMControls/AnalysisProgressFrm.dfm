object fmAnalysisProgress: TfmAnalysisProgress
  Left = 172
  Top = 214
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1042#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' '#1072#1085#1072#1083#1080#1079' '#1091#1103#1079#1074#1080#1084#1086#1089#1090#1080
  ClientHeight = 122
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 81
    Width = 450
    Height = 41
    Align = alBottom
    Anchors = [akLeft, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      450
      41)
    object btStop: TButton
      Left = 152
      Top = 8
      Width = 149
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 0
      OnClick = btStopClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 49
    Height = 81
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 408
    Top = 0
    Width = 42
    Height = 81
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Panel4: TPanel
    Left = 49
    Top = 0
    Width = 359
    Height = 81
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object LStageName: TLabel
      Left = 0
      Top = 13
      Width = 359
      Height = 41
      Align = alClient
      AutoSize = False
      Caption = 'qq'
    end
    object ProgressBar: TProgressBar
      Left = 0
      Top = 66
      Width = 359
      Height = 15
      Align = alBottom
      Min = 0
      Max = 100
      TabOrder = 0
      Visible = False
    end
    object Panel5: TPanel
      Left = 0
      Top = 54
      Width = 359
      Height = 12
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
    end
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 359
      Height = 13
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
end
