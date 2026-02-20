inherited fmAddBoundary: TfmAddBoundary
  Top = 171
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1088#1091#1073#1077#1078#1077#1081
  ClientHeight = 590
  ClientWidth = 433
  OldCreateOrder = True
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnDestroy = nil
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 433
    Height = 224
    inherited lKind: TLabel
      Width = 59
      Caption = #1042#1080#1076' '#1088#1091#1073#1077#1078#1072
    end
    inherited edKind: TComboBox
      Left = 23
      Width = 390
    end
    inherited btOK: TButton
      Left = 23
      Top = 196
      Height = 21
    end
    inherited btCancel: TButton
      Left = 106
      Top = 196
      Height = 21
    end
    inherited btHelp: TButton
      Left = 189
      Top = 196
      Height = 21
      HelpKeyword = 'IDH_3_7'
    end
    inherited pName: TPanel
      inherited lName: TLabel
        Width = 62
        Caption = #1048#1084#1103' '#1088#1091#1073#1077#1078#1072
      end
      inherited edName: TEdit
        Width = 390
        Height = 24
      end
    end
    inherited pSubKind: TPanel
      inherited lSubKind: TLabel
        Width = 59
        Caption = #1058#1080#1087' '#1088#1091#1073#1077#1078#1072
      end
      inherited edSubKind: TComboBox
        Width = 390
      end
    end
    object btMoreLess: TButton
      Left = 335
      Top = 196
      Width = 72
      Height = 22
      Caption = #1041#1086#1083#1100#1096#1077
      TabOrder = 6
      OnClick = btMoreLessClick
    end
    object PanelWidth: TPanel
      Left = 24
      Top = 140
      Width = 199
      Height = 44
      BevelOuter = bvNone
      TabOrder = 7
      object Label1: TLabel
        Left = 2
        Top = 14
        Width = 131
        Height = 13
        Caption = #1064#1080#1088#1080#1085#1072' '#1085#1086#1074#1086#1075#1086' '#1088#1091#1073#1077#1078#1072', '#1084
      end
      object edWidth: TEdit
        Left = 139
        Top = 11
        Width = 57
        Height = 21
        TabOrder = 0
        OnChange = edWidthChange
      end
    end
    object rgBuildWallsOnAllLevels: TRadioGroup
      Left = 230
      Top = 139
      Width = 177
      Height = 50
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1088#1091#1073#1077#1078#1080
      ItemIndex = 0
      Items.Strings = (
        #1090#1086#1083#1100#1082#1086' '#1085#1072' '#1090#1077#1082#1091#1097#1077#1084' '#1091#1088#1086#1074#1085#1077
        #1085#1072' '#1074#1089#1077#1093' '#1074#1080#1076#1080#1084#1099#1093' '#1091#1088#1086#1074#1085#1103#1093)
      TabOrder = 8
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 223
    Width = 449
    Height = 129
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object Label3: TLabel
      Left = 14
      Top = 41
      Width = 144
      Height = 13
      Caption = #1058#1080#1087' '#1089#1083#1086#1103' '#1079#1072#1097#1080#1090#1099' '#1085#1072' '#1088#1091#1073#1077#1078#1077
    end
    object edBoundaryLayerType: TComboBox
      Left = 11
      Top = 58
      Width = 396
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object PanelFlowIntencity: TPanel
      Left = 14
      Top = 2
      Width = 404
      Height = 31
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 7
        Top = 8
        Width = 236
        Height = 13
        Caption = #1048#1085#1090#1077#1085#1089#1080#1074#1085#1086#1089#1090#1100' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1095#1077#1088#1077#1079' '#1090#1086#1095#1082#1091' '#1076#1086#1089#1090#1091#1087#1072
      end
      object chbFlowIntencity: TComboBox
        Left = 267
        Top = 7
        Width = 75
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = #1053#1080#1079#1082#1072#1103
        Items.Strings = (
          #1053#1080#1079#1082#1072#1103
          #1057#1088#1077#1076#1085#1103#1103
          #1042#1099#1089#1086#1082#1072#1103)
      end
    end
    object chbUseLayer: TCheckBox
      Left = 23
      Top = 82
      Width = 156
      Height = 18
      Caption = #1043#1088#1072#1092#1080#1095#1077#1089#1082#1080#1081' '#1089#1083#1086#1081' '#1088#1091#1073#1077#1078#1072
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnMouseUp = chbUseLayerMouseUp
    end
    object edLayer: TComboBox
      Left = 10
      Top = 99
      Width = 396
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 475
    Width = 433
    Height = 77
    TabOrder = 2
    object rgBuildDirection: TRadioGroup
      Left = 15
      Top = 7
      Width = 199
      Height = 65
      Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1088#1091#1073#1077#1078#1077#1081
      ItemIndex = 0
      Items.Strings = (
        #1074#1074#1077#1088#1093
        #1074#1085#1080#1079)
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 349
    Width = 427
    Height = 98
    BevelOuter = bvNone
    TabOrder = 3
    object Label4: TLabel
      Left = 20
      Top = 7
      Width = 148
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072' '#1080#1089#1093#1086#1076#1085#1086#1075#1086' '#1088#1091#1073#1077#1078#1072', '#1084
      Enabled = False
    end
    object Label5: TLabel
      Left = 259
      Top = 6
      Width = 80
      Height = 13
      Caption = #1044#1083#1080#1085#1072' '#1083#1080#1085#1080#1080', '#1084
      Enabled = False
    end
    object edOldWidth: TEdit
      Left = 181
      Top = 2
      Width = 57
      Height = 21
      Enabled = False
      TabOrder = 0
      OnChange = edWidthChange
    end
    object rgMode: TRadioGroup
      Left = 20
      Top = 27
      Width = 388
      Height = 61
      ItemIndex = 0
      Items.Strings = (
        #1044#1077#1083#1072#1090#1100' '#1087#1088#1086#1077#1084' '#1085#1072#1076' '#1091#1082#1072#1079#1072#1085#1085#1086#1081' '#1083#1080#1085#1080#1077#1081', '#1085#1086' '#1085#1077' '#1073#1086#1083#1077#1077' '#1079#1072#1076#1072#1085#1085#1086#1081' '#1096#1080#1088#1080#1085#1099' '
        #1044#1077#1083#1072#1090#1100' '#1087#1088#1086#1077#1084' '#1079#1072#1076#1072#1085#1085#1086#1081' '#1096#1080#1088#1080#1085#1099', '#1085#1086' '#1085#1077' '#1096#1080#1088#1077' '#1080#1089#1093#1086#1076#1085#1086#1075#1086' '#1088#1091#1073#1077#1078#1072
        #1047#1072#1084#1077#1089#1090#1080#1090#1100' '#1080#1089#1093#1086#1076#1085#1099#1081' '#1088#1091#1073#1077#1078)
      TabOrder = 1
    end
    object edOldLength: TEdit
      Left = 345
      Top = 1
      Width = 60
      Height = 21
      Enabled = False
      TabOrder = 2
      OnChange = edWidthChange
    end
  end
end
