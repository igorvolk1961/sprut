object fmLoadProgress: TfmLoadProgress
  Left = 172
  Top = 214
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 56
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 263
    Top = 0
    Width = 22
    Height = 56
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel4: TPanel
    Left = 25
    Top = 0
    Width = 238
    Height = 56
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object LStageName: TLabel
      Left = 0
      Top = 13
      Width = 238
      Height = 16
      Align = alClient
      AutoSize = False
      Caption = 'qq'
    end
    object ProgressBar: TProgressBar
      Left = 0
      Top = 41
      Width = 238
      Height = 15
      Align = alBottom
      Min = 0
      Max = 100
      TabOrder = 0
      Visible = False
    end
    object Panel5: TPanel
      Left = 0
      Top = 29
      Width = 238
      Height = 12
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
    end
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 238
      Height = 13
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 25
    Height = 56
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
  end
end
