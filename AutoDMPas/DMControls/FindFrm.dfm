object frm_Find: Tfrm_Find
  Left = 148
  Top = 315
  Width = 430
  Height = 177
  Caption = #1055#1086#1080#1089#1082' '#1101#1083#1077#1084#1077#1085#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pn_Info: TPanel
    Left = 0
    Top = 95
    Width = 422
    Height = 55
    Align = alClient
    TabOrder = 0
    object lb_Name: TLabel
      Left = 9
      Top = 3
      Width = 3
      Height = 13
    end
  end
  object pn_Param: TPanel
    Left = 0
    Top = 0
    Width = 422
    Height = 95
    Align = alTop
    TabOrder = 1
    object btFind: TButton
      Left = 280
      Top = 12
      Width = 50
      Height = 21
      Caption = #1055#1086#1080#1089#1082
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btFindClick
    end
    object gb_Find: TGroupBox
      Left = 2
      Top = -2
      Width = 270
      Height = 93
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        270
        93)
      object Label1: TLabel
        Left = 6
        Top = 40
        Width = 31
        Height = 13
        Caption = #1050#1083#1072#1089#1089
      end
      object rb_Find_Name: TRadioButton
        Left = 40
        Top = 13
        Width = 101
        Height = 16
        Caption = #1087#1086#1080#1089#1082' '#1087#1086' '#1080#1084#1077#1085#1080
        TabOrder = 0
        OnClick = rb_Find_NameClick
      end
      object rb_Find_ID: TRadioButton
        Left = 164
        Top = 13
        Width = 83
        Height = 16
        Caption = #1087#1086#1080#1089#1082' '#1087#1086'  ID'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rb_Find_IDClick
      end
      object cb_FClassAlias: TComboBox
        Left = 42
        Top = 36
        Width = 225
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnDropDown = cb_FClassAliasDropDown
      end
      object pn_Find_Name: TPanel
        Left = 2
        Top = 59
        Width = 266
        Height = 27
        BevelOuter = bvNone
        TabOrder = 3
        Visible = False
        object lb_pn_Find2: TLabel
          Left = 2
          Top = 8
          Width = 20
          Height = 13
          Caption = #1080#1084#1103
        end
        object cb_Find_Name: TComboBox
          Left = 26
          Top = 5
          Width = 237
          Height = 21
          ItemHeight = 13
          TabOrder = 0
        end
      end
      object pn_Find_ID: TPanel
        Left = 3
        Top = 61
        Width = 265
        Height = 27
        Anchors = []
        BevelOuter = bvNone
        TabOrder = 4
        object lb_pn_Find1: TLabel
          Left = 6
          Top = 9
          Width = 11
          Height = 13
          Caption = 'ID'
        end
        object cb_Find_ID: TComboBox
          Left = 40
          Top = 5
          Width = 143
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnKeyPress = cb_Find_IDKeyPress
        end
      end
    end
    object bt_Stop: TButton
      Left = 280
      Top = 64
      Width = 50
      Height = 21
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = bt_StopClick
    end
  end
end
