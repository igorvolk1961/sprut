inherited fmAddJump: TfmAddJump
  Left = 186
  Top = 231
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1084#1077#1078#1076#1091' '#1079#1086#1085#1072#1084#1080
  ClientHeight = 289
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
      Width = 69
      Caption = #1042#1080#1076' '#1087#1077#1088#1077#1093#1086#1076#1072
    end
    inherited edKind: TComboBox
      Width = 390
    end
    inherited btOK: TButton
      Left = 23
      Top = 187
      Height = 21
    end
    inherited btCancel: TButton
      Left = 106
      Top = 187
      Height = 21
    end
    inherited btHelp: TButton
      Left = 189
      Top = 187
      Height = 21
      HelpKeyword = 'IDH_3_10'
    end
    inherited pName: TPanel
      inherited lName: TLabel
        Width = 62
        Caption = #1048#1084#1103' '#1088#1091#1073#1077#1078#1072
      end
      inherited edName: TEdit
        Width = 390
      end
    end
    inherited pSubKind: TPanel
      inherited lSubKind: TLabel
        Width = 69
        Caption = #1058#1080#1087' '#1087#1077#1088#1077#1093#1086#1076#1072
      end
      inherited edSubKind: TComboBox
        Width = 390
      end
    end
    object btMoreLess: TButton
      Left = 335
      Top = 187
      Width = 73
      Height = 22
      Caption = #1041#1086#1083#1100#1096#1077
      TabOrder = 6
      OnClick = btMoreLessClick
    end
    object PanelWidth: TPanel
      Left = 22
      Top = 148
      Width = 170
      Height = 28
      BevelOuter = bvNone
      TabOrder = 7
      object Label1: TLabel
        Left = 1
        Top = 7
        Width = 103
        Height = 13
        Caption = #1064#1080#1088#1080#1085#1072' '#1087#1077#1088#1077#1093#1086#1076#1072', '#1084
      end
      object edWidth: TEdit
        Left = 109
        Top = 4
        Width = 57
        Height = 21
        TabOrder = 0
        OnChange = edWidthChange
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 225
    Width = 434
    Height = 170
    TabOrder = 1
    Visible = False
    object Label3: TLabel
      Left = 20
      Top = 9
      Width = 154
      Height = 13
      Caption = #1058#1080#1087' '#1089#1083#1086#1103' '#1079#1072#1097#1080#1090#1099' '#1085#1072' '#1087#1077#1088#1077#1093#1086#1076#1077
    end
    object edBoundaryLayerType: TComboBox
      Left = 20
      Top = 26
      Width = 390
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
  end
end
