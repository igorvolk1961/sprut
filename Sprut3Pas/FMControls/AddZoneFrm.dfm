inherited fmAddZone: TfmAddZone
  Left = 180
  Top = 167
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1079#1086#1085
  ClientHeight = 591
  ClientWidth = 451
  OldCreateOrder = True
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnDestroy = nil
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 451
    Height = 223
    inherited lKind: TLabel
      Width = 48
      Caption = #1042#1080#1076' '#1079#1086#1085#1099
    end
    object Label1: TLabel [1]
      Left = 24
      Top = 155
      Width = 81
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072' '#1079#1086#1085#1099', '#1084
    end
    object Label2: TLabel [2]
      Left = 254
      Top = 155
      Width = 82
      Height = 13
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1079#1086#1085#1099
    end
    inherited edKind: TComboBox
      Width = 410
    end
    inherited btOK: TButton
      Left = 23
      Top = 186
      Height = 21
      TabOrder = 4
    end
    inherited btCancel: TButton
      Left = 106
      Top = 186
      Height = 21
      TabOrder = 5
    end
    inherited btHelp: TButton
      Left = 189
      Top = 186
      Height = 21
      TabOrder = 6
    end
    inherited pName: TPanel
      Width = 433
      inherited lName: TLabel
        Width = 51
        Caption = #1048#1084#1103' '#1079#1086#1085#1099
      end
      inherited edName: TEdit
        Width = 410
      end
    end
    inherited pSubKind: TPanel
      Width = 430
      inherited lSubKind: TLabel
        Width = 48
        Caption = #1058#1080#1087' '#1079#1086#1085#1099
      end
      inherited edSubKind: TComboBox
        Width = 410
      end
    end
    object btMoreLess: TButton
      Left = 335
      Top = 186
      Width = 73
      Height = 22
      Caption = #1041#1086#1083#1100#1096#1077
      TabOrder = 7
      OnClick = btMoreLessClick
    end
    object edHeight: TEdit
      Tag = 1
      Left = 119
      Top = 152
      Width = 57
      Height = 21
      TabOrder = 3
      OnChange = EditChange
    end
    object edCategory: TEdit
      Tag = 2
      Left = 346
      Top = 152
      Width = 57
      Height = 21
      TabOrder = 8
      OnChange = EditChange
    end
  end
  object Panel2: TPanel
    Left = -4
    Top = 222
    Width = 457
    Height = 391
    TabOrder = 1
    Visible = False
    object Label3: TLabel
      Left = 21
      Top = 88
      Width = 122
      Height = 13
      Caption = #1055#1088#1080#1089#1091#1090#1089#1090#1074#1080#1077' '#1087#1077#1088#1089#1086#1085#1072#1083#1072
    end
    object Label4: TLabel
      Left = 21
      Top = 170
      Width = 195
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1087#1077#1096#1077#1075#1086' '#1087#1077#1088#1077#1076#1074#1080#1078#1077#1085#1080#1103', '#1082#1084'/'#1095
    end
    object Label6: TLabel
      Left = 21
      Top = 142
      Width = 169
      Height = 13
      Caption = #1044#1072#1083#1100#1085#1086#1089#1090#1100' '#1087#1088#1103#1084#1086#1081' '#1074#1080#1076#1080#1084#1086#1089#1090#1080', '#1084
    end
    object Label7: TLabel
      Left = 21
      Top = 114
      Width = 232
      Height = 13
      Caption = #1063#1080#1089#1083#1077#1085#1085#1086#1089#1090#1100' '#1087#1077#1088#1089#1086#1085#1072#1083#1072', '#1076#1086#1087#1091#1097#1077#1085#1085#1086#1075#1086' '#1074' '#1079#1086#1085#1091
    end
    object Label10: TLabel
      Left = 14
      Top = 316
      Width = 153
      Height = 13
      Caption = #1058#1080#1087' '#1088#1091#1073#1077#1078#1077#1081' '#1085#1072' '#1075#1088#1072#1085#1080#1094#1077' '#1079#1086#1085#1099
    end
    object rgBuildDirection: TRadioGroup
      Left = 15
      Top = 9
      Width = 199
      Height = 65
      Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1079#1086#1085
      ItemIndex = 0
      Items.Strings = (
        #1074#1074#1077#1088#1093
        #1074#1085#1080#1079)
      TabOrder = 0
    end
    object edPedestrialVelocity: TEdit
      Tag = 16
      Left = 258
      Top = 167
      Width = 84
      Height = 21
      TabOrder = 4
      OnChange = EditChange
    end
    object edTransparencyDist: TEdit
      Tag = 8
      Left = 258
      Top = 139
      Width = 84
      Height = 21
      TabOrder = 3
      Text = #1053#1077' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1072
      OnChange = edTransparencyDistChange
      OnKeyDown = edTransparencyDistKeyDown
      OnKeyPress = edTransparencyDistKeyPress
    end
    object chbPersonalPresence: TComboBox
      Left = 148
      Top = 83
      Width = 295
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = #1054#1073#1099#1095#1085#1086' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090
      Items.Strings = (
        #1054#1073#1099#1095#1085#1086' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090
        #1048#1085#1086#1075#1076#1072' '#1087#1088#1080#1089#1091#1090#1089#1090#1074#1091#1077#1090' ('#1095#1072#1097#1077', '#1095#1077#1084' 1 '#1088#1072#1079' '#1074' '#1095#1072#1089')'
        #1055#1088#1080#1089#1091#1090#1089#1090#1074#1091#1077#1090' '#1087#1086#1089#1090#1086#1103#1085#1085#1086' ('#1095#1072#1097#1077', '#1095#1077#1084' 1 '#1088#1072#1079' '#1079#1072' 10 '#1084#1080#1085')')
    end
    object edPersonalCount: TEdit
      Tag = 4
      Left = 259
      Top = 111
      Width = 84
      Height = 21
      TabOrder = 2
      Text = '100'
      OnChange = EditChange
    end
    object rgVehicleVelocity: TRadioGroup
      Left = 14
      Top = 196
      Width = 427
      Height = 77
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1099#1093' '#1089#1088#1077#1076#1089#1090#1074
      ItemIndex = 0
      Items.Strings = (
        
          #1054#1087#1088#1077#1076#1077#1083#1103#1077#1090#1089#1103', '#1080#1089#1093#1086#1076#1103' '#1080#1079' '#1090#1080#1087#1072' '#1084#1077#1089#1090#1085#1086#1089#1090#1080' '#1080' '#1074#1080#1076#1072' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1099#1093' '#1089#1088#1077#1076#1089 +
          #1090#1074
        #1047#1072#1076#1072#1077#1090#1089#1103' '#1103#1074#1085#1086)
      TabOrder = 5
      OnClick = rgVehicleVelocityClick
    end
    object edBoundaryKind: TComboBox
      Left = 14
      Top = 330
      Width = 410
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 7
    end
    object PanelRoadCover: TPanel
      Left = -2
      Top = 278
      Width = 449
      Height = 27
      BevelOuter = bvNone
      TabOrder = 8
      object Label8: TLabel
        Left = 16
        Top = 8
        Width = 76
        Height = 13
        Caption = #1058#1080#1087' '#1084#1077#1089#1090#1085#1086#1089#1090#1080
      end
      object edRoadCover: TComboBox
        Left = 97
        Top = 4
        Width = 345
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 0
        Text = #1042#1086#1079#1084#1086#1078#1085#1086' '#1076#1074#1080#1078#1077#1085#1080#1077' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072' '#1089' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1081' '#1089#1082#1086#1088#1086#1089#1090#1100#1102
        Items.Strings = (
          #1044#1074#1080#1078#1077#1085#1080#1077' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072' '#1085#1077#1074#1086#1079#1084#1086#1078#1085#1086
          #1042#1086#1079#1084#1086#1078#1085#1086' '#1076#1074#1080#1078#1077#1085#1080#1077' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072' '#1089' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1081' '#1089#1082#1086#1088#1086#1089#1090#1100#1102
          #1055#1077#1088#1077#1089#1077#1095#1077#1085#1085#1072#1103' '#1084#1077#1089#1090#1085#1086#1089#1090#1100
          #1058#1088#1091#1076#1085#1086#1087#1088#1086#1093#1086#1076#1080#1084#1072#1103'  '#1084#1077#1089#1090#1085#1086#1089#1090#1100)
      end
    end
    object PanelVehicleVelocity: TPanel
      Left = 121
      Top = 234
      Width = 313
      Height = 34
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 6
      object Label5: TLabel
        Left = 4
        Top = 12
        Width = 249
        Height = 13
        Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1099#1093' '#1089#1088#1077#1076#1089#1090#1074', '#1082#1084'/'#1095
      end
      object edVehicleVelocity: TEdit
        Tag = 32
        Left = 260
        Top = 8
        Width = 43
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = EditChange
      end
    end
    object chbBuildJoinedVolume: TCheckBox
      Left = 231
      Top = 26
      Width = 162
      Height = 17
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1089#1084#1077#1078#1085#1099#1077' '#1079#1086#1085#1099
      TabOrder = 9
    end
  end
end
