object fmCurrentOptions: TfmCurrentOptions
  Left = 212
  Top = 105
  Width = 484
  Height = 443
  Caption = #1058#1077#1082#1091#1097#1080#1077' '#1091#1089#1090#1072#1085#1086#1074#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btOK: TButton
    Left = 35
    Top = 303
    Width = 75
    Height = 26
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btCancel: TButton
    Left = 123
    Top = 303
    Width = 75
    Height = 26
    Cancel = True
    Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103
    ModalResult = 2
    TabOrder = 1
  end
  object btHelp: TButton
    Left = 211
    Top = 303
    Width = 75
    Height = 26
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 2
    Visible = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 476
    Height = 295
    ActivePage = TabSheet2
    Align = alTop
    TabIndex = 1
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = #1059#1089#1083#1086#1074#1080#1103' '#1087#1088#1077#1086#1076#1086#1083#1077#1085#1080#1103' '#1089#1088#1077#1076#1089#1090#1074' '#1086#1093#1088#1072#1085#1099
      object Label1: TLabel
        Left = 8
        Top = 161
        Width = 120
        Height = 13
        Caption = #1069#1090#1072#1087' '#1072#1082#1094#1080#1080' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1103
      end
      object Label2: TLabel
        Left = 8
        Top = 219
        Width = 187
        Height = 13
        Caption = #1058#1072#1082#1090#1080#1082#1072' '#1087#1088#1077#1086#1076#1086#1083#1077#1085#1080#1103' '#1088#1091#1073#1077#1078#1077#1081' '#1080' '#1079#1086#1085
      end
      object Label3: TLabel
        Left = 8
        Top = 52
        Width = 99
        Height = 13
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
      end
      object Label4: TLabel
        Left = 9
        Top = 8
        Width = 87
        Height = 13
        Caption = #1042#1072#1088#1080#1072#1085#1090' '#1072#1085#1072#1083#1080#1079#1072
      end
      object cbPathStage: TComboBox
        Left = 8
        Top = 179
        Width = 313
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = #1057#1082#1088#1099#1090#1085#1086#1077' '#1087#1088#1086#1085#1080#1082#1085#1086#1074#1077#1085#1080#1077
        OnChange = cbPathStageChange
        Items.Strings = (
          #1057#1082#1088#1099#1090#1085#1086#1077' '#1087#1088#1086#1085#1080#1082#1085#1086#1074#1077#1085#1080#1077
          #1041#1099#1089#1090#1088#1086#1077' '#1087#1088#1085#1080#1082#1085#1086#1074#1077#1085#1080#1077
          #1057#1082#1088#1099#1090#1085#1086#1081' '#1086#1090#1093#1086#1076
          #1041#1099#1089#1090#1088#1099#1081' '#1086#1090#1093#1086#1076)
      end
      object cbTactic: TComboBox
        Left = 8
        Top = 235
        Width = 313
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 1
      end
      object cbFacilityState: TComboBox
        Left = 8
        Top = 69
        Width = 311
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 2
      end
      object cbGroupType: TComboBox
        Left = 8
        Top = 107
        Width = 201
        Height = 21
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clBtnFace
        Ctl3D = False
        ItemHeight = 13
        ItemIndex = 0
        ParentCtl3D = False
        TabOrder = 3
        Text = #1043#1088#1091#1087#1087#1072' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081
        OnChange = cbGroupTypeChange
        Items.Strings = (
          #1043#1088#1091#1087#1087#1072' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1077#1081
          #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1086#1093#1088#1072#1085#1099)
      end
      object cbGroup: TComboBox
        Left = 8
        Top = 129
        Width = 311
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 4
      end
      object cbAnalysisVariant: TComboBox
        Left = 9
        Top = 25
        Width = 311
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 5
        OnChange = cbAnalysisVariantChange
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1072#1085#1072#1083#1080#1079#1072
      ImageIndex = 1
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 159
        Height = 13
        Caption = #1056#1072#1079#1073#1088#1086#1089' '#1079#1072#1076#1077#1088#1078#1077#1082' '#1085#1072#1088#1091#1096#1080#1090#1077#1083#1103
      end
      object Label6: TLabel
        Left = 8
        Top = 32
        Width = 164
        Height = 13
        Caption = #1056#1072#1079#1073#1088#1086#1089' '#1074#1088#1077#1084#1077#1085#1080' '#1088#1077#1072#1075#1080#1088#1086#1074#1072#1085#1080#1103
      end
      object Label7: TLabel
        Left = 8
        Top = 56
        Width = 224
        Height = 30
        AutoSize = False
        Caption = 
          #1056#1077#1072#1075#1080#1088#1086#1074#1072#1085#1080#1077' '#1085#1072' '#1089#1080#1075#1085#1072#1083' '#1090#1088#1077#1074#1086#1075#1080' '#1087#1088#1080' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1080' '#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103' ('#1087#1086' ' +
          #1091#1084#1086#1083#1095#1072#1085#1080#1102')'
        WordWrap = True
      end
      object Label9: TLabel
        Left = 24
        Top = 208
        Width = 225
        Height = 13
        Caption = '('#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1076#1083#1103' '#1074#1099#1088#1072#1073#1086#1090#1082#1080' '#1088#1077#1082#1086#1084#1077#1085#1076#1072#1094#1080#1081')'
      end
      object cbDefaultReactionMode: TComboBox
        Left = 232
        Top = 56
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          #1054#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090
          #1042#1089#1077#1075#1076#1072
          #1042' '#1087#1086#1083#1086#1074#1080#1085#1077' '#1089#1083#1091#1095#1072#1077#1074
          #1047#1072#1074#1080#1089#1080#1090' '#1086#1073#1097#1077#1081' '#1086#1090' '#1095#1072#1089#1090#1086#1090#1099' '#1083#1086#1078#1085#1099#1093' '#1090#1088#1077#1074#1086#1075
          #1047#1072#1074#1080#1089#1080#1090' '#1086#1090' '#1095#1072#1089#1090#1086#1090#1099' '#1083#1086#1078#1085#1099#1093' '#1090#1088#1077#1074#1086#1075' '#1085#1072' '#1088#1091#1073#1077#1078#1077)
      end
      object pCriticalFalseAlarmPeriod: TPanel
        Left = 3
        Top = 88
        Width = 387
        Height = 27
        BevelOuter = bvNone
        TabOrder = 1
        object Label8: TLabel
          Left = 7
          Top = 7
          Width = 194
          Height = 13
          Caption = #1050#1088#1080#1090#1080#1095#1077#1089#1082#1080#1081' '#1087#1077#1088#1080#1086#1076' '#1083#1086#1078#1085#1099#1093' '#1090#1088#1077#1074#1086#1075', '#1095
        end
        object edCriticalFalseAlarmPeriod: TEdit
          Left = 227
          Top = 2
          Width = 57
          Height = 21
          TabOrder = 0
        end
      end
      object cbUseBattleModel: TCheckBox
        Left = 10
        Top = 168
        Width = 233
        Height = 16
        Caption = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1090#1100' '#1073#1086#1077#1074#1086#1077' '#1089#1090#1086#1083#1082#1085#1086#1074#1077#1085#1080#1077
        TabOrder = 2
      end
      object cbBuildAllVerticalWays: TCheckBox
        Left = 10
        Top = 145
        Width = 295
        Height = 18
        Caption = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1077' '#1074#1086#1079#1084#1086#1078#1085#1099#1077' '#1074#1077#1088#1090#1080#1082#1072#1083#1100#1085#1099#1077' '#1087#1091#1090#1080
        TabOrder = 3
      end
      object cbFindCriticalPointsFlag: TCheckBox
        Left = 10
        Top = 189
        Width = 233
        Height = 17
        Caption = #1048#1089#1082#1072#1090#1100' '#1082#1088#1080#1090#1080#1095#1077#1089#1082#1080#1077' '#1090#1086#1095#1082#1080' '#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1103' '
        TabOrder = 4
      end
      object cbDontBreakWalls: TCheckBox
        Left = 10
        Top = 124
        Width = 295
        Height = 17
        Caption = #1053#1077' '#1091#1095#1080#1090#1099#1074#1072#1090#1100' '#1087#1088#1086#1083#1086#1084' '#1089#1090#1077#1085' '#1080' '#1087#1077#1088#1077#1088#1099#1090#1080#1081
        TabOrder = 5
      end
      object edDelayTimeDispersionRatio: TEdit
        Left = 185
        Top = 3
        Width = 34
        Height = 21
        TabOrder = 6
        Text = '0.25'
      end
      object edResponceTimeDispersionRatio: TEdit
        Left = 184
        Top = 30
        Width = 35
        Height = 21
        TabOrder = 7
        Text = '0.25'
      end
    end
  end
end
